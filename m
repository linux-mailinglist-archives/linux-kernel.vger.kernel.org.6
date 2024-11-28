Return-Path: <linux-kernel+bounces-424102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE429DB0A2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E0E828153E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6C119BBC;
	Thu, 28 Nov 2024 01:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMmvPgg+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBAA139E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732756518; cv=none; b=V3NlTgG2fyfjEPC4DpKp33q/qc22sS9mG+42jtgWxh46oMu2Isly5AZmXJ5IXBTCj2Btt0I5R8HyxL3e1+bQrrxZjGHSpi5FbFrlHMIc79HY9dW7aI8vG4wnUYRTtQ4xdYRc+yCuuJUDojaEtgbZsaURPLQTKY5b99qqBjdjl+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732756518; c=relaxed/simple;
	bh=zJODIhOrziEm2/9PTiUZ94QLvcm5t3isSf/hY5I8alg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=VVeK5yxSINAdtDwnnuPsIJDtaI/yM0pbCq6Wo4rmIDhp3JRZIu7CNm+7+gIFypLelEfr6ASq6ZZ2rGeZRZaQv6DLj5zeEsWASRCv3ZWWL+O1cn+8+NKFkiuCvhu5L8vjIVkcznDMBE16I2gEipJhngvT2oREv6WJqUeZmlLhd6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMmvPgg+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D83BC4CECC
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732756517;
	bh=zJODIhOrziEm2/9PTiUZ94QLvcm5t3isSf/hY5I8alg=;
	h=From:Date:Subject:To:Cc:From;
	b=OMmvPgg+BjbwNbja3aL8gzYRigWdYWfbgr7CsZMEj/CTPDwstVE4yBbEWADdYAS8f
	 Rj3Ny1ZG3hK8UaLVF1j4wyqETU9Cihe3nqPTQ8cY4yfGQCKQXxTa4e6Zr4ar3u+NrN
	 oJw9H5bFqTn9aUrn5z0oifhf9gBT2kiqK2J+mDqwYcM0nhcDiCJoJ8Nc9cm/NgCn9C
	 mED61exsLgJbrQ47Nt/O1wlRjwoF9wf62cCgHAqB496FsF2ikgSfpLkdr+zax5xMon
	 dImz2ytwo3ohJwYX/b89EP28d5uzH6lu3ujA/WH1x9sRFFI8F9rjRvJfnJfEcH9Gqf
	 svBA7isrd2lng==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3ea4f9825f6so205434b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 17:15:17 -0800 (PST)
X-Gm-Message-State: AOJu0YwLLOPXiq2WvCBDxEJbth2gdTF6C0uR/8w78Ft1syrRhdQhbzs0
	Po7FRTH4nwasSzX1CGMhh8jpY9Rwwd02m1eoNXR0sRWPl3p8v/lMT9o4tODxR8Ymf0IvvpxopiY
	CBu9/VriOHruxiGleuskxv7uakOc=
X-Google-Smtp-Source: AGHT+IHwxuCF33RsQgzRLqWglwTpe5Uwy9TdOcYLb6W1TX5cJobCf2jMaAUVJUAR/awfQxGj4LDK7/SV9w0kBprH+zg=
X-Received: by 2002:a05:6830:f93:b0:71d:58df:3277 with SMTP id
 46e09a7af769-71d65cf1d78mr4352297a34.24.1732756516884; Wed, 27 Nov 2024
 17:15:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 28 Nov 2024 10:15:05 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9nv9eEHgt55sWBWo98bkOXctDJGjQo+FSJYtVGwtKOhA@mail.gmail.com>
Message-ID: <CAKYAXd9nv9eEHgt55sWBWo98bkOXctDJGjQo+FSJYtVGwtKOhA@mail.gmail.com>
Subject: [GIT PULL] exfat update for 6.13-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	"Yuezhang.Mo" <Yuezhang.Mo@sony.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

This is exfat update pull request for v6.13-rc1. I add description of
this pull request on below. Please pull exfat with following ones.

Thanks!

The following changes since commit 9f16d5e6f220661f73b36a4be1b21575651d8833:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
(2024-11-23 16:00:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
tags/exfat-for-6.13-rc1

for you to fetch changes up to 8a3f5711ad74db9881b289a6e34d7f3b700df720:

  exfat: reduce FAT chain traversal (2024-11-25 17:08:27 +0900)

----------------------------------------------------------------
Description for this pull request:
- Handle it as the empty directory if the start cluster of stream entry
  is invalid.
- Valid size of steam entry cannot be greater than data size.
  If valid_size is invalid, Deal with data_size.
- Move Direct-IO alignment check to before extending the valid size.
- Fix uninit-value issue reported by syzbot.
- Optimize to find directory entry-set in write_inode, rename, unlink.

----------------------------------------------------------------
Namjae Jeon (1):
      exfat: fix uninit-value in __exfat_get_dentry_set

Yuezhang Mo (9):
      exfat: fix out-of-bounds access of directory entries
      exfat: fix file being changed by unaligned direct write
      exfat: remove unnecessary read entry in __exfat_rename()
      exfat: rename argument name for exfat_move_file and exfat_rename_file
      exfat: add exfat_get_dentry_set_by_ei() helper
      exfat: move exfat_chain_set() out of __exfat_resolve_path()
      exfat: remove argument 'p_dir' from exfat_add_entry()
      exfat: code cleanup for exfat_readdir()
      exfat: reduce FAT chain traversal

 fs/exfat/dir.c      |  29 ++------
 fs/exfat/exfat_fs.h |   6 ++
 fs/exfat/file.c     |  10 +++
 fs/exfat/inode.c    |   2 +-
 fs/exfat/namei.c    | 194 ++++++++++++++++++++++++----------------------------
 5 files changed, 113 insertions(+), 128 deletions(-)

