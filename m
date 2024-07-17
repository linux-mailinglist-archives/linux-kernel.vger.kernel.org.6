Return-Path: <linux-kernel+bounces-255706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30ED89343F3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 23:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDFCD1F2187D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 21:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6246E188CB2;
	Wed, 17 Jul 2024 21:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J6NHIgJc"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E151850A3
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 21:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721252027; cv=none; b=E9cH+65LM6ZoypKypEB6m1UVsOgW56Bokcsckl5HO50g4ErQ9R3nKcsvTyeWCOYIQpaGcBQnqxxT0t7W4qbtHzCpkKKzQDGwRNBxOY3thAzAFYzGA0od5pwPknm23kxAlM4qHYJ20yR3TDGNtWeulU9UNqsCOzCx5xMGov99SxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721252027; c=relaxed/simple;
	bh=x4AxNVE4O+WfqzVJnnmu85pZqmIfGnKYsIXUmc1r8y8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eeb1zQyQzljaRDtqgVqctUEYKA+wVqWIZYziC4Qz1V+WGhZrItWE2wZeKfEBR6pFm9w2ID9cK4p4m3o82lsSGz6ZaMqekARn03OyxVOIwvMWxNECCNUgvR0dsl7NEmKJ+B5kbMvCCO5AMKtYDxl9FrtKBBddz/g7FsXugQJCUHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J6NHIgJc; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-664b7a67ad4so2169077b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 14:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721252024; x=1721856824; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZB/4mcQzsOoOaqb8afktp7uOucLSH7cA09jFpTDUMV0=;
        b=J6NHIgJcOMqdTCGaKfi1bnUBDtXEX1rfUQMrsLm/YojnJve+Lqq40RnVV9Dj3+XWFn
         w6ekM1nf5LUdJ+qgUin5K+hND0jFTtfn5+Y1uHYwAPWh1ENIfC0IqoLYUHjQTDBwSIAz
         8sx3JHjGdaVJn5gQeVTmxAEBso0pEmZV+mKjLgANC1PCKlOi1+B7kI3Rd1jzJ1lBKUm7
         j5OpNwEE1cSr88SSFOZFYQsfTNz2Yl5j+LVm9SC9Tplxa1ahhWhSvsDovaYt/7G/EPVX
         eKdsDMjNqnZc4N/R15P/yWqYiWOK+qKMgDUynQDardNBmt+XiStyM+sq/lgM9rhQzD7m
         sMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721252024; x=1721856824;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZB/4mcQzsOoOaqb8afktp7uOucLSH7cA09jFpTDUMV0=;
        b=MTJUfEAiMF6HcBINlnySbhjxCxMcoiWlLPruAW18G0cA1aMkpJjhhtfXpnr+nTP2xz
         eSvebV3nUZCQxVTaFpGtNhxfeI0FSY/uxgWkn6w1/+sGzY9b7UPQvTkn/3fxycKcSDjx
         6MwyGVsRaSY+Gf5odJtsMIh6C9sMgaHegc3htPfn7t99SrZV2Q0wcPiANySp4D3pYR4s
         GzXu99LNJrP3NX1tUzF98zouRsWl698fQpiWnmqcndCh6lvQjEM9nIGxhd+xmfL1q+ZI
         95m4Oo4N5nul7OsMItd0+3LI1LynOSJKWh99dbw9g1L0EfPZmlLydu0mWGSEiBOFGh4T
         llZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlcO8U4qU+Klrdpqc1pp8uk5j9CKD5czHvtK7H8Ynp8nl7KNXEcW4STinoqSgeWlRxSruuF9ndxTp0xuJ81lmSFtce3im5FASCqElG
X-Gm-Message-State: AOJu0YylW56sc2R4dvFiRydKizVdtZbnkCJAq1s+5tX79Qpn8EhRzAnI
	u1doVGpimK2wDDsjrVMOYwb+3Sc0a/kLaziDPMQFdEjMa36zgnvcu4y88QzCZTHAWaBeSaEiJk8
	KN6mQ4j48hbfCU38u0jV1W0zbdKIx2w==
X-Google-Smtp-Source: AGHT+IE/F3kuqtrq1gronND0JsdGxzDxmNfarL3qLMn5KiwPZ0T3K407YPV2orhl71mUZY2G4uIIPHcXQ2a4+vbABDfo
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:a503:d697:557b:840c])
 (user=axelrasmussen job=sendgmr) by 2002:a05:690c:3405:b0:622:cd7d:fec4 with
 SMTP id 00721157ae682-66605444531mr187067b3.9.1721252024222; Wed, 17 Jul 2024
 14:33:44 -0700 (PDT)
Date: Wed, 17 Jul 2024 14:33:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240717213339.1921530-1-axelrasmussen@google.com>
Subject: [PATCH 6.9 0/3] Backport VFIO refactor to fix fork ordering bug
From: Axel Rasmussen <axelrasmussen@google.com>
To: stable@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Ankit Agrawal <ankita@nvidia.com>, 
	Eric Auger <eric.auger@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Kunwu Chan <chentao@kylinos.cn>, Leah Rumancik <leah.rumancik@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Stefan Hajnoczi <stefanha@redhat.com>, Yi Liu <yi.l.liu@intel.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"

35e351780fa9 ("fork: defer linking file vma until vma is fully initialized")
switched the ordering of vm_ops->open() and copy_page_range() on fork. This is a
bug for VFIO, because it causes two problems:

1. Because open() is called before copy_page_range(), the range can conceivably
   have unmapped 'holes' in it. This causes the code underneath untrack_pfn() to
   WARN.

2. More seriously, open() is trying to guarantee that the entire range is
   zapped, so any future accesses in the child will result in the VFIO fault
   handler being called. Because we copy_page_range() *after* open() (and
   therefore after zapping), this guarantee is violatd.

We can't revert 35e351780fa9, because it fixes a real bug for hugetlbfs. The fix
is also not as simple as just reodering open() and copy_page_range(), as Miaohe
points out in [1]. So, although these patches are kind of large for stable, just
backport this refactoring which completely sidesteps the issue.

Note that patch 2 is the key one here which fixes the issue. Patch 1 is a
prerequisite required for patch 2 to build / work. This would almost be enough,
but we might see significantly regressed performance. Patch 3 fixes that up,
putting performance back on par with what it was before.

Note [1] also has a more full discussion justifying taking these backports.

[1]: https://lore.kernel.org/all/20240702042948.2629267-1-leah.rumancik@gmail.com/T/

Alex Williamson (3):
  vfio: Create vfio_fs_type with inode per device
  vfio/pci: Use unmap_mapping_range()
  vfio/pci: Insert full vma on mmap'd MMIO fault

 drivers/vfio/device_cdev.c       |   7 +
 drivers/vfio/group.c             |   7 +
 drivers/vfio/pci/vfio_pci_core.c | 271 ++++++++-----------------------
 drivers/vfio/vfio_main.c         |  44 +++++
 include/linux/vfio.h             |   1 +
 include/linux/vfio_pci_core.h    |   2 -
 6 files changed, 125 insertions(+), 207 deletions(-)

--
2.45.2.993.g49e7a77208-goog


