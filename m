Return-Path: <linux-kernel+bounces-565728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 169B8A66E20
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F52E16E6F0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6AB1F63F0;
	Tue, 18 Mar 2025 08:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7MqOfFn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68A01C6FF4;
	Tue, 18 Mar 2025 08:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742286428; cv=none; b=b5Ufnxb2TLPOWNRQplGUxCPNm9wABAdiB8b0og17E7fOWVr/QZPj3Xvp/wbTzePiZrc2XZEkyRmojerqvb5vkN3a+ngnateM+Tjt6X1h6WcBEruBKRQ/6U7NL9f7EFUGLv5XLeKrCbgDW5mjWwiSGaDgLszKRprAyMwfqXFBGfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742286428; c=relaxed/simple;
	bh=ROlfKfFEYmVi6Jef/7Ul9oBfKnMqC5hiSH7wMJxghcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=owzHhspvgxnQ4lGGkPIhHKQ+9wraffOhJDfpfuJmvY2OMxgu8P6QDU3eFooTFPgCcvs2uhK2OT+KHn38qiyhylkgsmp3bMC3ix8+dN00O4zY6koiZ8yfoH85GAzsSqEhogUUlQTzZE931o8ekc5991dxM/nOy5pU9mL+J4RPO2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7MqOfFn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678DBC4CEEF;
	Tue, 18 Mar 2025 08:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742286427;
	bh=ROlfKfFEYmVi6Jef/7Ul9oBfKnMqC5hiSH7wMJxghcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p7MqOfFn4kqcyAfz3rAusBuZrGFrnaC4v03ejlxPvyfVA+4L8LHF6K3mVzqyHKJ3x
	 1AAAc7aFsmegnMD3TAP4hUX5VnoDtT/0w2DsAOL3EP/OfIObLIzsHj7fSu7hHhhprd
	 BbZ5Gwuvyc5Ih6zKmuccd689aCKqLZKVyqQ6HcmLY0SITXEyoooapCX1vWcCxuRJKB
	 bmAXNUkqkVHrmFFOV9QrQjpzn1ODTrtArXbfncBtQ7o0sIci8jfZl0LMBvjAQOeCWj
	 t5zqDPOYb/oFIzZVl7JtjKWbn0slbiKA6mrwie+5/9/U+qmX6T8nUXjOWQTfXt9A+1
	 dHQgZcjLjDq7w==
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
Subject: Re: [PATCH v2] rust: optimize rust symbol generation for SeqFile
Date: Tue, 18 Mar 2025 09:26:46 +0100
Message-ID: <20250318-delfin-bleichen-c931856104dd@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317030418.2371265-1-kunwu.chan@linux.dev>
References: <20250317030418.2371265-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1259; i=brauner@kernel.org; h=from:subject:message-id; bh=ROlfKfFEYmVi6Jef/7Ul9oBfKnMqC5hiSH7wMJxghcA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTf1PNkaLvR0XFW4n1mtv7nKo+g3dOrTeQSrm7bdkx68 c26D+7cHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhvCxSkAE/HjY/in+T1DR07bvem2/LU1 265rHnbP3s12S0/DOj/9xZWlHmtKGf4ZnGLlFYlZMGXXTXu5cJO/Tyc6pZaFbD3t76fLtdgoUoI XAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 17 Mar 2025 11:04:18 +0800, Kunwu Chan wrote:
> When build the kernel using the llvm-18.1.3-rust-1.85.0-x86_64
> with ARCH=arm64, the following symbols are generated:
> 
> $nm vmlinux | grep ' _R'.*SeqFile | rustfilt
> ffff8000805b78ac T <kernel::seq_file::SeqFile>::call_printf
> 
> This Rust symbol is trivial wrappers around the C functions seq_printf.
> It doesn't make sense to go through a trivial wrapper for its functions,
> so mark it inline.
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

[1/1] rust: optimize rust symbol generation for SeqFile
      https://git.kernel.org/vfs/vfs/c/0b9817caac1d

