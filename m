Return-Path: <linux-kernel+bounces-188759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CC08CE67A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20BDF1C21AF4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 13:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FD112C461;
	Fri, 24 May 2024 13:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEKf2oNO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BBC1E52C
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 13:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716559096; cv=none; b=k6uQS7s2Vn5jTek7mhDCByHo6w6w951HoauonOizALKpiwKIJAbP3sio9xr9HhleHvz+nvPZFbUSjLIYmX6Vy5z86JOWTursTWRiQoFIbvblqPMN7Aen72nkFSQTCjbo7nMmFjjC++/tLQ+S9+v+wiaVOtjsD7nBXzejM5E+1pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716559096; c=relaxed/simple;
	bh=uFDcDFnvfL5qT+v6BH7T1D5GHPvkVzjP6kkXiYmqx0s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=D+1/PbyJoRWj1CGwf656InysdgS8EG31hHOFmxgBMq/oRkY+6VkjDGkkppPlZjHtgascgJKoZv6r0H8gG7FOeLBK+8PSbt4Qb/YSR8x/2KmR0bhhey+SyQNGzRvTzgfgTc41qdaODN9s6l0a9MX6Q1Kr+8XU8i0haSZkfuhSiAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEKf2oNO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC16C32782;
	Fri, 24 May 2024 13:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716559095;
	bh=uFDcDFnvfL5qT+v6BH7T1D5GHPvkVzjP6kkXiYmqx0s=;
	h=Date:From:To:Cc:Subject:From;
	b=OEKf2oNOw4ClzvvnGF1nGv5jdj9y66xt5tu/XIadvaU0Sz4VUwSqJLd137R0qiAqF
	 36kxyU2n/ACR1am+UfAzK2Gz+nDaXWDO4o9L/5hVf+NP2m5m0Q1YASL3SU6zy8i/wI
	 LNDSbTsQBUYWVeDxpVG6FtjfTxnQ/umAC98hfaAr9Acp8CoTFPmPTGRWAV99zyvJZb
	 ZaT4XiMEg9fbpZoQJyCvSA/4rryP7N1c8/K0vH9QyOvM8j81ZtaLEP+RZRfipdwPjq
	 4OwDirAwfafcQ3ub1Vd9QLG3lAdD4eTZoW06sf6hzwtUvejz5jjuHBZ1bTQZJ4aAJR
	 L0kC6itmoFePQ==
Date: Fri, 24 May 2024 21:57:46 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Hongzhen Luo <hongzhen@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>, Chao Yu <chao@kernel.org>
Subject: [GIT PULL] erofs more updates for 6.10-rc1
Message-ID: <ZlCc2s0h0H1v16er@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Hongzhen Luo <hongzhen@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>, Chao Yu <chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

Could you consider these extra patches for 6.10-rc1?

The main ones are metadata API conversion to byte offsets by
Al Viro.  Since some of patches are also part of VFS
"->bd_inode elimination" (and they were merged upstream days ago),
I did a merge commit to resolve the dependency with the detailed
description.

Another patch gets rid of unnecessary memory allocation out of
DEFLATE decompressor.  The remaining one is a trivial cleanup.

All commits have been in -next and no potential merge conflict is
observed.

Thanks,
Gao Xiang

The following changes since commit 7c35de4df1056a5a1fb4de042197b8f5b1033b61:

  erofs: Zstandard compression support (2024-05-09 07:46:56 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.10-rc1-2

for you to fetch changes up to 80eb4f62056d6ae709bdd0636ab96ce660f494b2:

  erofs: avoid allocating DEFLATE streams before mounting (2024-05-21 03:07:39 +0800)

----------------------------------------------------------------
Changes since last update:

 - Convert metadata APIs to byte offsets;

 - Avoid allocating DEFLATE streams unnecessarily;

 - Some erofs_show_options() cleanup.

----------------------------------------------------------------
Al Viro (6):
      erofs: switch erofs_bread() to passing offset instead of block number
      erofs_buf: store address_space instead of inode
      erofs: mechanically convert erofs_read_metabuf() to offsets
      erofs: don't align offset for erofs_read_metabuf() (simple cases)
      erofs: don't round offset down for erofs_read_metabuf()
      z_erofs_pcluster_begin(): don't bother with rounding position down

Gao Xiang (2):
      Merge branch 'misc.erofs' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git
      erofs: avoid allocating DEFLATE streams before mounting

Hongzhen Luo (1):
      erofs: clean up erofs_show_options()

 fs/erofs/data.c                 | 25 +++++++++----------
 fs/erofs/decompressor_deflate.c | 55 ++++++++++++++++++++++-------------------
 fs/erofs/dir.c                  |  4 +--
 fs/erofs/fscache.c              | 12 +++------
 fs/erofs/inode.c                |  4 +--
 fs/erofs/internal.h             |  9 +++----
 fs/erofs/namei.c                |  6 ++---
 fs/erofs/super.c                | 44 +++++++++++----------------------
 fs/erofs/xattr.c                | 37 +++++++++++----------------
 fs/erofs/zdata.c                |  8 +++---
 fs/erofs/zmap.c                 | 24 +++++++++---------
 11 files changed, 97 insertions(+), 131 deletions(-)

