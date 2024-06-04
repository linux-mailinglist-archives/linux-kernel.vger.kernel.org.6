Return-Path: <linux-kernel+bounces-200310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1028FAE5A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A245D1C22D69
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEB614374E;
	Tue,  4 Jun 2024 09:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="D/OcZnfA"
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9281B142E9A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492150; cv=none; b=Msl61kxj85Mh5O4S8kvUcPk1fh1YBxHKM7eDirvZbMkaRwayDhwPbxO/8wL9TWpEmi423ZHSAvnnPdyYMjbRw/cypZYIaJXG5hBrrkrmIJUs0bVDQFNRPcuFBpk3ITOX2NvrqEM0Jh4d+xW3nnePZDacGc/3d+5rTXRT/KZXGQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492150; c=relaxed/simple;
	bh=6ipgItDqro2hagPht5JjdD4lSHGvF00vyhIdME+gW/g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cDXCbTOS3OWCbzjqkgcvf4zksY5hL1N2pNipZnpJ2tRrtlYggE5biJk5jWQ5FdSPT13BcIm+WkG0GTRx4xwbGkdf4qIkjwX8F/ClZEZnx6rccic1VkJ4nDB68w4jKjhU1mzuKtJK/vewecUbpOu7DpCBhccU9hrp3UEgP4OpXOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=D/OcZnfA; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63a96so4769599a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 02:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1717492146; x=1718096946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PzIzp+ixMNHCeCKZs399tnTjJhrG7D+k1l6DCFs334k=;
        b=D/OcZnfAcr0P9Qerfo5vBqLwyQesaXGhSHW5XaljDtacYYZy4+9qyvPysYlgqa/uMW
         RhmrYktrPhM33JPAf9PGbhENgO6S6dtUwQjpHgihGxbM7Iv9jAgcFFPLdYV5PApSxK6q
         y1yE7IdRPwsK3rlxAFD5paL4y9oOVja3NYmtCzCHxf8Oe4XIXqlGL/eRJ71DvtviQzJL
         QtsLFdJ40ogp3gi9T4EyqblruQ1a+ASBO1kA1Ql5g9671BFnwt/JqwL1BYVyd3bNF50s
         n2LNI13tPC2MZQhfWb+UHh+kcAa6cJGoMS0BEqXu0Q4vTvNcVwvqlWWk/7cGJ3vsb4dg
         vONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717492146; x=1718096946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PzIzp+ixMNHCeCKZs399tnTjJhrG7D+k1l6DCFs334k=;
        b=qTg7eTS39nIN8+W3rb0uciLDTAdim48UvGaC/WOJ0ONquMTnlOV++OfalvvHzx28em
         uHgSi7uc4J4t8Iinv739L0V/FOy6jdL8d2tC0UH3QMmsj2aemjmjQztGdsQ+9aSdR9mG
         LjlN0v842YEwMpk1yjaCvIiXxe3HHy+mjZa8sJswBNqryAaKfPXwSoZ+mKoLnrTYdUo7
         Y6jBQLGdfj3Np7Cku5JV1nJgsWpjNNmsNbWAlyuT8WgKnWxKCAbpyrz3oUCioz0noFtm
         Dj3MUNOWoJfuRtzeXArgFdm3wRookxnm5Ftm1TLhROHzY4tmQL2NlOqHMmibQffvVICm
         AbBg==
X-Forwarded-Encrypted: i=1; AJvYcCUYOV2cpvDJ3dYBNuQ+Lj4Mfy4v7Aa/iiljrYBEjusdA5Bg0oDbYXI94ET0S4XmfiM/mthlwI1tznR9XQkkkwOXL1XbM1pbPSGQlXUi
X-Gm-Message-State: AOJu0YxbkozQigwnEd7K+qElCIttdGzTxwrH7rNbXE0Fi6Sb4D+ChOtp
	i7FAwEh/tw6Gg+c5UB5EyxwSxcSJVHXyRsSieabgWFB7fROMD+QrV2xOhZefVnk=
X-Google-Smtp-Source: AGHT+IF0CVeraAix/Wu1DETz7eZJsftNnxHZh4LxVOxqHFlDfvUyJXKOpdf7qe5jC/cidD4CraAUaw==
X-Received: by 2002:a17:906:3415:b0:a68:a287:da78 with SMTP id a640c23a62f3a-a68a287e3e7mr584081866b.62.1717492145637;
        Tue, 04 Jun 2024 02:09:05 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f4f9200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4f:9200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68fa49e66fsm328376766b.129.2024.06.04.02.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 02:09:04 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	david@redhat.com,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v6 00/15] Fast kernel headers: split linux/mm.h
Date: Tue,  4 Jun 2024 11:08:30 +0200
Message-Id: <20240604090845.2182265-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch set aims to clean up the linux/mm.h header and reduce
dependencies on it by moving parts out.

The goal was to eliminate dependencies on linux/mm.h from other
popular headers such as highmem.h and dma-mapping.h, and I started by
checking which symbols were really used and moved those declarations
to separate slim headers.

This patch set borrows the name "fast kernel headers" from Ingo
Molnar's effort a few years ago.  While this kind of refactoring does
indeed improve build times because the amount of code that has to be
processed in each compilation unit is reduced, build speed is the
least important advantage.

Much more important is that this gives us greater confidence that the
code is correct: if we forget to include a header, it might (or might
not) already be included indirectly by some other header somewhere
down the large impenetrable include tree.  Chances are almost 100%
that linux/kernel.h or linux/mm.h gets included somewhere, which then
in turn includes everything else.  Now if this indirect include just
happens to be changed eventually, the build may suddenly fail at
remote places.  Worse, an #ifdef may silently produce different code.
Therefore, at each source file, all the includes that are needed
should be included directly (but not more).  This is only possible if
headers are small, and linux/mm.h and linux/kernel.h are large
offenders resisting the cleanup.

Therefore, splitting those is the first step towards leaner header
dependencies.  This patch set starts with linux/mm.h, and I am already
preparing another patch set addressing linux/kernel.h.

Some of these changes were part of a previous, bigger patch set
(https://lore.kernel.org/lkml/20240131145008.1345531-1-max.kellermann@ionos.com/)
but this patch set grew so large, it could not be reviewed.  This is
an attempt to break the patch set into smaller pieces.

---
v1 -> v2: added more explanations to commit messages; renamed several
  new headers from page_*.h to folio_*.h as suggested by Matthew
  Wilcox; rebase on linux-next; fix build failures on architectures
  um,nios2,hexagon by adding more missing includes
v2 -> v3: rebase on linux-next
v3 -> v4: rebase on linux-next; fix build failure on loongarch64
  (reported by kernel test robot); add missing includes to
  drivers/dma/bcm2835-dma.c and include/scsi/scsicam.h
v4 -> v5: rebase on linux-next; more text in cover letter as suggested
  by David Hildenbrand
v5 -> v6: rebase on linux-next d04466706db5...d97496ca23a2

Max Kellermann (15):
  drivers: add missing includes on linux/mm.h (and others)
  include/drm/drm_gem.h: add poll_table_struct forward declaration
  include/scsi/scsicam.h: forward-declare struct block_device
  linux/mm.h: move page_kasan_tag() to mm/page_kasan_tag.h
  linux/mm.h: move section functions to mm/page_section.h
  linux/mm.h: move page_address() and others to mm/page_address.h
  linux/mm.h: move folio_size(), ... to mm/folio_size.h
  linux/mm.h: move folio_next() to mm/folio_next.h
  linux/mm.h: move devmap-related declarations to mm/devmap_managed.h
  linux/mm.h: move usage count functions to mm/folio_usage.h
  linux/mm.h: move page_zone_id() and more to mm/folio_zone.h
  linux/mm.h: move pfmemalloc-related functions to pfmemalloc.h
  linux/mm.h: move is_vmalloc_addr() to mm/vmalloc_addr.h
  linux/mm.h: move high_memory to mm/high_memory.h
  include: reduce dependencies on linux/mm.h

 MAINTAINERS                                   |   1 +
 arch/arm/include/asm/memory.h                 |   4 +
 arch/arm/include/asm/pgtable.h                |   2 +
 arch/arm/mm/iomap.c                           |   3 +
 arch/csky/include/asm/page.h                  |   1 +
 arch/hexagon/include/asm/mem-layout.h         |   4 +
 arch/m68k/include/asm/page_mm.h               |   1 +
 arch/m68k/include/asm/pgtable_mm.h            |   1 +
 arch/parisc/include/asm/floppy.h              |   1 +
 arch/powerpc/include/asm/book3s/32/pgtable.h  |   4 +
 arch/powerpc/include/asm/nohash/32/pgtable.h  |   1 +
 arch/powerpc/include/asm/page.h               |   1 +
 arch/x86/include/asm/floppy.h                 |   1 +
 arch/x86/include/asm/pgtable_32_areas.h       |   4 +
 drivers/comedi/comedi_buf.c                   |   1 +
 .../qat/qat_common/adf_gen4_pm_debugfs.c      |   1 +
 drivers/dma/bcm2835-dma.c                     |   1 +
 drivers/dma/dma-axi-dmac.c                    |   1 +
 drivers/dma/sh/rcar-dmac.c                    |   1 +
 drivers/firmware/qcom/qcom_scm-legacy.c       |   1 +
 drivers/firmware/qcom/qcom_scm-smc.c          |   1 +
 drivers/firmware/raspberrypi.c                |   1 +
 drivers/iio/buffer/industrialio-buffer-dma.c  |   1 +
 drivers/iommu/iommufd/ioas.c                  |   2 +
 drivers/iommu/iommufd/selftest.c              |   1 +
 drivers/media/platform/mediatek/vpu/mtk_vpu.c |   1 +
 drivers/media/platform/ti/omap/omap_voutlib.c |   1 +
 drivers/misc/bcm-vk/bcm_vk_dev.c              |   1 +
 drivers/misc/fastrpc.c                        |   1 +
 drivers/misc/genwqe/card_dev.c                |   1 +
 drivers/misc/uacce/uacce.c                    |   1 +
 drivers/mtd/nand/onenand/onenand_samsung.c    |   1 +
 drivers/mtd/spi-nor/core.h                    |   2 +
 drivers/pci/p2pdma.c                          |   1 +
 drivers/pci/pci.c                             |   1 +
 drivers/remoteproc/mtk_scp.c                  |   1 +
 drivers/remoteproc/remoteproc_core.c          |   1 +
 drivers/soc/qcom/rmtfs_mem.c                  |   1 +
 drivers/spi/spi-aspeed-smc.c                  |   1 +
 drivers/spi/spi-bcm2835.c                     |   2 +
 drivers/spi/spi-intel.c                       |   1 +
 drivers/virtio/virtio_ring.c                  |   1 +
 include/drm/drm_file.h                        |   1 +
 include/linux/bio.h                           |   2 +
 include/linux/bpfptr.h                        |   1 -
 include/linux/dma-mapping.h                   |   1 +
 include/linux/highmem-internal.h              |   2 +
 include/linux/highmem.h                       |   4 +-
 include/linux/huge_mm.h                       |   2 +
 include/linux/iommu.h                         |   1 +
 include/linux/mm.h                            | 598 +-----------------
 include/linux/mm/devmap_managed.h             |  32 +
 include/linux/mm/folio_next.h                 |  27 +
 include/linux/mm/folio_size.h                 | 150 +++++
 include/linux/mm/folio_usage.h                | 182 ++++++
 include/linux/mm/folio_zone.h                 |  56 ++
 include/linux/mm/high_memory.h                |   7 +
 include/linux/mm/page_address.h               |  71 +++
 include/linux/mm/page_kasan_tag.h             |  66 ++
 include/linux/mm/page_section.h               |  23 +
 include/linux/mm/pfmemalloc.h                 |  52 ++
 include/linux/mm/vmalloc_addr.h               |  33 +
 include/linux/net.h                           |   2 +-
 include/linux/nvme-keyring.h                  |   2 +
 include/linux/oom.h                           |   2 +-
 include/linux/page-flags.h                    |   3 +
 include/linux/pagemap.h                       |   2 +-
 include/linux/scatterlist.h                   |   8 +-
 include/linux/skbuff.h                        |   4 +
 include/linux/vmstat.h                        |   2 +
 include/scsi/scsicam.h                        |   5 +
 kernel/dma/ops_helpers.c                      |   1 +
 kernel/dma/remap.c                            |   1 +
 kernel/rcu/rcutorture.c                       |   1 +
 lib/scatterlist.c                             |   1 +
 mm/dmapool.c                                  |   1 +
 76 files changed, 811 insertions(+), 595 deletions(-)
 create mode 100644 include/linux/mm/devmap_managed.h
 create mode 100644 include/linux/mm/folio_next.h
 create mode 100644 include/linux/mm/folio_size.h
 create mode 100644 include/linux/mm/folio_usage.h
 create mode 100644 include/linux/mm/folio_zone.h
 create mode 100644 include/linux/mm/high_memory.h
 create mode 100644 include/linux/mm/page_address.h
 create mode 100644 include/linux/mm/page_kasan_tag.h
 create mode 100644 include/linux/mm/page_section.h
 create mode 100644 include/linux/mm/pfmemalloc.h
 create mode 100644 include/linux/mm/vmalloc_addr.h

-- 
2.39.2


