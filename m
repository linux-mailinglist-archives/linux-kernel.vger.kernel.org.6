Return-Path: <linux-kernel+bounces-531117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A73B6A43C5F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD283ABCCE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEDE2676FD;
	Tue, 25 Feb 2025 10:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxwspY8b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A1B26738B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481012; cv=none; b=LxxpozGTG00sORAIZf4oIZK7Jv87Do3jCcTxGgtgC/vepxWw4LO//+XBUi6kEx3wo8AUnEj4KdJIdTeAYW69VvVOmVyQ+AIaot3nnY1zTv/HNQ4Off0rn5rYWE8wTkWLOyJmaSo6r0pL/w0MWKREnfQiUYsz1S8j/JkB4pTgMGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481012; c=relaxed/simple;
	bh=oDNEKrwsSaK+PEmr2890ReGD6rVMhK0UXp4uOVcx2kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SAbw07eKB2Th5fNVyepuJ8ufhDiZ+QCZfn1kjU+UFr2acHZj0stvxlzEF7pguL690Zx2XVhoq5mtAVbTKfuaNui9aWNWTHsoaOuLHkTsrvg55mLck/+vbzotRZ9xXyLeBrUdUSj89x93oDd+k9NfuSUqpzs4gsqnaDDxuQiVPww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxwspY8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619E5C4CEE8;
	Tue, 25 Feb 2025 10:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740481011;
	bh=oDNEKrwsSaK+PEmr2890ReGD6rVMhK0UXp4uOVcx2kQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oxwspY8bQbx7/ccNyOxb0j+IPiwbV38BZLZ6OL9tYVUiLoXW8yZRCKhssWBxsD0s0
	 PcUf6WgemopZJK1vvaCQcnR4I100nxoKjtoN6Qksc5IEXsB5crhUTvUb+Br+aT2UWx
	 SXeDY4XyEqqcvT7oliBUsVKdP+MiMssNGvRttMfQEiE/x8q8lgYFs/ph3ahiRCBQvo
	 eU9YCiY5V/5SEAevMTlhoavQsAcPVeeo5sdZsFl4VWdqrWXH38mNxO6RDTA4Gb8P6r
	 pUDejD5p7aICFnICepcdTearzNvXKk1odOcvcE+mrDHX4i3eNreEJ2I+gZmrR6GgVC
	 yn2VH9gJ3kOAg==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	Arnd Bergmann <arnd@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] samples/vfs: fix printf format string for size_t
Date: Tue, 25 Feb 2025 11:56:46 +0100
Message-ID: <20250225-torpedieren-bannen-9efd90dc7115@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250224141406.1400864-1-arnd@kernel.org>
References: <20250224141406.1400864-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1749; i=brauner@kernel.org; h=from:subject:message-id; bh=oDNEKrwsSaK+PEmr2890ReGD6rVMhK0UXp4uOVcx2kQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTvXfheo/yLxMndDYe3cCx9ciVnp1a40FX/qrwc1cV+R dofDMVXdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk3VNGhod9ddzf3/hO2GCx 0faFQ7DBFIbij0xbd3qE1cf4TXcVamRk6JnP+i1aOjKB3+In+4S5jf9Yvlw7Ill46rTzRaNTuxn +cgEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 24 Feb 2025 15:14:00 +0100, Arnd Bergmann wrote:
> size_t needs a %z format string modifier instead of %l
> 
> samples/vfs/test-list-all-mounts.c:152:39: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
>   152 |                                         printf("mnt_uidmap[%lu]:\t%s\n", idx, idmap);
>       |                                                            ~~~           ^~~
>       |                                                            %zu
> samples/vfs/test-list-all-mounts.c:161:39: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
>   161 |                                         printf("mnt_gidmap[%lu]:\t%s\n", idx, idmap);
>       |                                                            ~~~           ^~~
>       |                                                            %zu
> 
> [...]

Applied to the vfs-6.15.mount branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.mount branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.mount

[1/1] samples/vfs: fix printf format string for size_t
      https://git.kernel.org/vfs/vfs/c/33cec19dc022

