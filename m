Return-Path: <linux-kernel+bounces-565727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB43CA66E1F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3289016DF87
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEE61F582A;
	Tue, 18 Mar 2025 08:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvaTaHZC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C8B1E5211;
	Tue, 18 Mar 2025 08:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742286420; cv=none; b=poOo6dB/tSlZRVXv0OsbUSQNaGWdHDyYlPQzTOXbBfmfrkd8lgmilfnRVzJgeDyBrNLedNnCPRBkWw+nYXTU+0j9iZsHvCYWbtXCsnZslhkFBoZ4FOjuLrnagMuhvGM5fzT6fopOj0FW0fjZ/6LFn/zFvuj4m/FEw9vWJlZ3Eko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742286420; c=relaxed/simple;
	bh=Hfwgtea6YzI7L/bkPhSCE/CbnovpT3+2xdknK/nhMTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PJZpyQA6boUIE0ixD0ju+OgcfiNCc0rx6cm+tLjebNzVIEv00UA1F9PygGsMZ9nyK7wWkSMMLMA7hpBFF+69x6NhCu3AKs7lEvuPNFChG4FSOtcmGJHvyX7nzl6TWiX7tTSJckAf/v0NO9akfo8xPAxFS3WW1LdTXwkEGleqGMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvaTaHZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E10C4CEEE;
	Tue, 18 Mar 2025 08:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742286419;
	bh=Hfwgtea6YzI7L/bkPhSCE/CbnovpT3+2xdknK/nhMTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tvaTaHZC/DO9q6aP0JfTv2l8PB4VvcFQSLHwIc/Hc7yXxwdOJmtLfL4d6S9QDk5YZ
	 /E4yzEVsYp9efJOnX2BGAkIk+ALAn4hJj51Wvuj1jaKmVmpL82si5FCjQS1yP2EEF4
	 2NRI6rsP08L9FjcbUfupY2e3Fb5GDJh2x28Nz7c08MVHozq+hh8i1/Md+QpeLCuh/g
	 TZGsCzwYIYhG6SgsFYs3LhYWK5LsGeFdYzyO7lrGETdHv7pFyg+83z0Jd8Hed9ur0I
	 x8MSs49kWaqJfIm2ehBwYAR0ifdkN7wtd/SK5wkVTn5izAvBTRJUHLwKH1R5/5JKle
	 5FRKfSAxRZ3xg==
From: Christian Brauner <brauner@kernel.org>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	Kunwu Chan <kunwu.chan@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Kunwu Chan <kunwu.chan@hotmail.com>,
	Grace Deng <Grace.Deng006@Gmail.com>
Subject: Re: [PATCH v2] rust: file: optimize rust symbol generation for FileDescriptorReservation
Date: Tue, 18 Mar 2025 09:26:45 +0100
Message-ID: <20250318-sintflut-zwilling-c5e996346ed9@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317023702.2360726-1-kunwu.chan@linux.dev>
References: <20250317023702.2360726-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1291; i=brauner@kernel.org; h=from:subject:message-id; bh=Hfwgtea6YzI7L/bkPhSCE/CbnovpT3+2xdknK/nhMTY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTf1PPYefFd94QQnn9v+t4UGUn0tH9vWR8iJL+kk1vbw livMq2ho5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKZmxn+Sj/4/VVuxbstS40q DwuW9NqweTgI31I6/c3E9KHqzKMPvjH8rzmqudPezU5O0Tnx7jR1UeHyDq6s1KNRNoKTTTmUnu9 iAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 17 Mar 2025 10:37:02 +0800, Kunwu Chan wrote:
> When build the kernel using the llvm-18.1.3-rust-1.85.0-x86_64
> with ARCH=arm64, the following symbols are generated:
> 
> $ nm vmlinux | grep ' _R'.*FileDescriptorReservation | rustfilt
> ... T <kernel::fs::file::FileDescriptorReservation>::fd_install
> ... T <kernel::fs::file::FileDescriptorReservation>::get_unused_fd_flags
> ... T <kernel::fs::file::FileDescriptorReservation as core::ops::drop::Drop>::drop
> 
> [...]

Applied to the vfs-6.15.rust branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.rust branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.rust

[1/1] rust: file: optimize rust symbol generation for FileDescriptorReservation
      https://git.kernel.org/vfs/vfs/c/e27b0e3c54f0

