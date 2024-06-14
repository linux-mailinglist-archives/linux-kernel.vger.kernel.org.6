Return-Path: <linux-kernel+bounces-215505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA519093CD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 23:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 002381C21E04
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 21:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752031850AA;
	Fri, 14 Jun 2024 21:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ghsabMK7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC25C13A27E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 21:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718402170; cv=none; b=vGNN8uWHznvdXmRe4B7epkUTmalHikKVVBId0IUTyqLicqRLZGESjWxSTVcPcZnZOkCiYHW6v/S6EqlA101rEF8qBb+o4DW5Y1vjSrqKRvXP9X5S0UDZjDlfRmsjKxUlFImpLilkplYZQBMlroEocL7bqZxvTal6yl3YAc0pHaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718402170; c=relaxed/simple;
	bh=Vwg6q7fggXLeb5tpS4EisZKmEOQoagaqE3VchQj5zPk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=alRanPJ7dtE61WlrjmuvOBwM1wn2dppMRLXt9O/VH/kjry8pdVeKipaRVvVygzueKxrcmabetWbJe4klsLoSrAag4bBxr3dNXA9lMt6KEbijTVKEKCC59sYIFT6CSBou2eR+mbNQLHi1r/cEDPs00sbLjj2sD7FgqZRkNc2W6GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ghsabMK7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718402167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a+FgBZXjI3XY9vehVUUcgNN5izssMgAKgIaS5/cDLQU=;
	b=ghsabMK7ufib6iAFNDIy3qFDtPsYDFmnLZKmhzP13bbUphWSV8842V5J+P+aJg7om/6pg5
	nTiEUg9+y6yaaKA3zU6Z6NuLth3gFU8eaHll50sMFSGSpJNXTF7zKgRMdA1bRQKuUpLvof
	ES9pqwF1xv3qSC7+JreipBrnypVqfjw=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-5f96oem_OcCj_hCgn1m_xw-1; Fri, 14 Jun 2024 17:56:06 -0400
X-MC-Unique: 5f96oem_OcCj_hCgn1m_xw-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7eb73f0683cso258162239f.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 14:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718402165; x=1719006965;
        h=content-transfer-encoding:mime-version:organization:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+FgBZXjI3XY9vehVUUcgNN5izssMgAKgIaS5/cDLQU=;
        b=ocS+emoCvL6jPlQwkn5eZb/rQqwfYDwEZKaWFZQNQoz+kKdEd+pQyKAD9YK8WsPMRL
         6FLCKouSLKQvpC+OHRjxUoq8jnsLLNEg9ojJAPnAtILQ7+lL6bqK4pREMOrlpVBHwquc
         QIyRNAeZcpREu9a2FOd0RDCyjgGs4VwSiAVL6rX2al/kue/CPisVHgT5Ug/XTd/V4RVe
         HYk3aPL85UQyipP4NpwtBhax6BmgLJQNY4N0yOwBPtkjXwUtfzs4b4D7xfh5y98VqjRH
         7RBjycQnx1O1rTkuQjZL5iFK1mkxCtXgSsPkfmjMNfjV+PaZhh+Dv0RHX1jnD1xewhOH
         B0vw==
X-Forwarded-Encrypted: i=1; AJvYcCWrpnfez/9KITRQXzac8nW7i5EULA/cKQRi89lvqXo1b1zd4OYhSHSKW4ACVBuhaHTCKyl/LkCv32Bz/CwR0TvqzqDRa3UUYkSFfqzJ
X-Gm-Message-State: AOJu0Yx+Er69epIJjTxl14AeMbJBRw29sSGzL1hM/mI6O3g8UZIz88Hj
	I5gjBfKB+To1scXJlOCPYnmtAlQ3MD+GBrrRuFOwZvQRcgnB45+PHThH4CYuFFc36tX28eOBdM4
	xkc6BmGMo7IoGIfvz/sHPCaev+bf+TJM+9kN/QJAB3NnR61K+pty9ZSHvbNs1vQ==
X-Received: by 2002:a05:6e02:1786:b0:375:c473:4a81 with SMTP id e9e14a558f8ab-375e0fe301cmr40129045ab.31.1718402165632;
        Fri, 14 Jun 2024 14:56:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXKj6qscxO8UfaNmhMDffg7PhHYVOZb9bJtLKPndTHdHaaCEe/bSaYvU1Qjw3bfZ0F7F6cIQ==
X-Received: by 2002:a05:6e02:1786:b0:375:c473:4a81 with SMTP id e9e14a558f8ab-375e0fe301cmr40128885ab.31.1718402165284;
        Fri, 14 Jun 2024 14:56:05 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-375d866e47fsm8316835ab.11.2024.06.14.14.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 14:56:04 -0700 (PDT)
Date: Fri, 14 Jun 2024 15:56:03 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] VFIO fixes for v6.10-rc4
Message-ID: <20240614155603.34567eb7.alex.williamson@redhat.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Linus,

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  https://github.com/awilliam/linux-vfio.git tags/vfio-v6.10-rc4

for you to fetch changes up to d71a989cf5d961989c273093cdff2550acdde314:

  vfio/pci: Insert full vma on mmap'd MMIO fault (2024-06-12 15:40:39 -0600)

----------------------------------------------------------------
VFIO fixes for v6.10-rc4

 - Fix long standing lockdep issue of using remap_pfn_range() from
   the vfio-pci fault handler for mapping device MMIO.  Commit
   ba168b52bf8e ("mm: use rwsem assertion macros for mmap_lock") now
   exposes this as a warning forcing this to be addressed.

   remap_pfn_range() was used here to efficiently map the entire vma,
   but it really never should have been used in the fault handler and
   doesn't handle concurrency, which introduced complex locking.  We
   also needed to track vmas mapping the device memory in order to zap
   those vmas when the memory is disabled resulting in a vma list.

   Instead of all that mess, setup an address space on the device fd
   such that we can use unmap_mapping_range() for zapping to avoid
   the tracking overhead and use the standard vmf_insert_pfn() to
   insert mappings on fault.  For now we'll iterate the vma and
   opportunistically try to insert mappings for the entire vma.  This
   aligns with typical use cases, but hopefully in the future we can
   drop the iterative approach and make use of huge_fault instead,
   once vmf_insert_pfn{pud,pmd}() learn to handle pfnmaps.
   (Alex Williamson)

----------------------------------------------------------------
Alex Williamson (3):
      vfio: Create vfio_fs_type with inode per device
      vfio/pci: Use unmap_mapping_range()
      vfio/pci: Insert full vma on mmap'd MMIO fault

 drivers/vfio/device_cdev.c       |   7 +
 drivers/vfio/group.c             |   7 +
 drivers/vfio/pci/vfio_pci_core.c | 271 ++++++++++-----------------------------
 drivers/vfio/vfio_main.c         |  44 +++++++
 include/linux/vfio.h             |   1 +
 include/linux/vfio_pci_core.h    |   2 -
 6 files changed, 125 insertions(+), 207 deletions(-)


