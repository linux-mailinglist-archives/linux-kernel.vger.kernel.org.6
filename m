Return-Path: <linux-kernel+bounces-422575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 890009D9B55
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E8328288F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AED11D89E4;
	Tue, 26 Nov 2024 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HUxsmg9w"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC371D63D6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 16:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732638213; cv=none; b=Bl8R5Q2UDdfW2kGRhxyvKAjevuHueS9LFQRN3E7pknLql0ROQZzaQBaiWDWcJ0EvaCudDS0W2CqEtEaLF3yUBk8oZpM0VEzS6r7McHLAFPgNWBEhCtGJleWPgrRjFELG/MrIi5jDPp7+H5arfekvsXZxYp7/18HshU4AF7SzZTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732638213; c=relaxed/simple;
	bh=dAU0be43lUtaN2A6L3grtUSCSgEAAAvX8KUUVSXRwjw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=VWSstRri72Dx0/WNKugYUagK5I5NsMLw5/19tnwbMRrj2Y0HO93PIOm7CooQ7/DP5NjB4O8Je+31oVfVXwt9teKp6BFEFBHAQygj0S1jo9+5D2V7m4IAS3n0b+bSB+G9d70Z5TQMg7T6E/pyvqjSYcssnJThzIJfMz8xgBWNpGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HUxsmg9w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732638209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ivxt8DJ1dWfy2xx2RTjyQoRe9uivu7z8Zk3l+EfcnXw=;
	b=HUxsmg9w2VT+2K9kd2FrJ428wWHHYQBjt8r2P1u7+ZrPjNpQmjo6OqXW9VRtc62rH+NpRT
	AA0hT0oZ7z5OXT0bib3ERBPLHty7T0rvkOScAmm31yTDcnCoALc928tBiifu6QF4MmDBBu
	sGsvm8h2xGot4Em/G3vLpQ6dMQNxSQ8=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-nTZNsow4PTCesVvoiAcCxg-1; Tue, 26 Nov 2024 11:23:27 -0500
X-MC-Unique: nTZNsow4PTCesVvoiAcCxg-1
X-Mimecast-MFC-AGG-ID: nTZNsow4PTCesVvoiAcCxg
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a763b3bac5so8413745ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 08:23:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732638207; x=1733243007;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ivxt8DJ1dWfy2xx2RTjyQoRe9uivu7z8Zk3l+EfcnXw=;
        b=DocmTpCEHQb0YxM0pMrwRi43TEChdh7sXp++X8lLdPTHdNmh21lL49x85HermN88ID
         GDA+lSLVEAYFOV8/shmiI57xUM0yqxJS5nqLZlsOosRFjcjH+um3ZMj7ywTQ10eh3CMa
         dNJUqudUW6x7mwmjEanaZXyhrt7IQRODBmffp1WncQ6Z8O6bSZRFhhrK/nNe+HeaQGqk
         yrc6e+e73grw3aosDxwhEAbOq8qyh/MqyqoZUYfurEbLpL0doZsuqcdt3rCZwPpyBb8V
         GGYvb5VMtxHlOUq/cr2+8D8pnqB2wESf4nbPxxJSsSBs8W/VvmmOHY7eqJPifV+vscGa
         aJHQ==
X-Gm-Message-State: AOJu0YzNRJGG5RopUyVu2ewoQhTLuXhHSM3KSxjCtBGMUME35b6ziThE
	chWmCrg9q6KoFZXT2soIqNR8Z+C5MBnIVhYVU4gLcP0zH7QkkYoL0I9asn51ZpuWcTen6P+uEo2
	7ewYuRlRH7C8T+Wu4b8MSglAax4t4XH5qK3ZnazuFaN/d3m4uenXx0HtfW3moSQ==
X-Gm-Gg: ASbGncvZ7Oe/as70kql7WT7lSTPimyp6avVThipq/nonBvwgyeP+AESWH3cB8LncMsI
	QDuwC6NVuMhqWbnXb5CAtHIN19d3rALZjFb7g16VOGBXalODbE6Dv0vPVE+5/ZsBMKYqEd9O3nW
	9ddkacnfS9+RJh7IL0XR8VbPw+Mad8iP6Y49rBdCPs3SGPyzHtWJFhecz8P7kcPjOo36JhuLt8j
	Qedfw61wrsd786Ia0gdTF3x7ePUguvdO5B9P9ghgLVnywlXJMxmbA==
X-Received: by 2002:a05:6602:3422:b0:83a:9c22:23b3 with SMTP id ca18e2360f4ac-842a9dfbbf0mr161475539f.4.1732638207176;
        Tue, 26 Nov 2024 08:23:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7yBcF8QGmX0RFK+b0OweHjpaMg/80iAkfPiQX0P06wmNUXD4tI5AyuiJKVGmOlGB9GDEfHg==
X-Received: by 2002:a05:6602:3422:b0:83a:9c22:23b3 with SMTP id ca18e2360f4ac-842a9dfbbf0mr161474939f.4.1732638206805;
        Tue, 26 Nov 2024 08:23:26 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e20e45c0e7sm728566173.119.2024.11.26.08.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 08:23:26 -0800 (PST)
Date: Tue, 26 Nov 2024 09:23:24 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>
Subject: [GIT PULL] VFIO updates for v6.13-rc1
Message-ID: <20241126092324.272debec.alex.williamson@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Linus,

The following changes since commit 81983758430957d9a5cb3333fe324fd70cf63e7e:

  Linux 6.12-rc5 (2024-10-27 12:52:02 -1000)

are available in the Git repository at:

  https://github.com/awilliam/linux-vfio.git tags/vfio-v6.13-rc1

for you to fetch changes up to fe4bf8d0b6716a423b16495d55b35d3fe515905d:

  vfio/pci: Properly hide first-in-list PCIe extended capability (2024-11-25 08:34:22 -0700)

----------------------------------------------------------------
VFIO updates for v6.13

 - Constify an unmodified structure used in linking vfio and kvm.
   (Christophe JAILLET)

 - Add ID for an additional hardware SKU supported by the nvgrace-gpu
   vfio-pci variant driver. (Ankit Agrawal)

 - Fix incorrect signed cast in QAT vfio-pci variant driver, negating
   test in check_add_overflow(), though still caught by later tests.
   (Giovanni Cabiddu)

 - Additional debugfs attributes exposed in hisi_acc vfio-pci variant
   driver for migration debugging. (Longfang Liu)

 - Migration support is added to the virtio vfio-pci variant driver,
   becoming the primary feature of the driver while retaining emulation
   of virtio legacy support as a secondary option. (Yishai Hadas)

 - Fixes to a few unwind flows in the mlx5 vfio-pci driver discovered
   through reviews of the virtio variant driver. (Yishai Hadas)

 - Fix an unlikely issue where a PCI device exposed to userspace with
   an unknown capability at the base of the extended capability chain
   can overflow an array index. (Avihai Horon)

----------------------------------------------------------------
Ankit Agrawal (1):
      vfio/nvgrace-gpu: Add a new GH200 SKU to the devid table

Avihai Horon (1):
      vfio/pci: Properly hide first-in-list PCIe extended capability

Christophe JAILLET (1):
      kvm/vfio: Constify struct kvm_device_ops

Giovanni Cabiddu (1):
      vfio/qat: fix overflow check in qat_vf_resume_write()

Longfang Liu (4):
      hisi_acc_vfio_pci: extract public functions for container_of
      hisi_acc_vfio_pci: create subfunction for data reading
      hisi_acc_vfio_pci: register debugfs for hisilicon migration driver
      Documentation: add debugfs description for hisi migration

Yishai Hadas (9):
      virtio_pci: Introduce device parts access commands
      virtio: Extend the admin command to include the result size
      virtio: Manage device and driver capabilities via the admin commands
      virtio-pci: Introduce APIs to execute device parts admin commands
      vfio/virtio: Add support for the basic live migration functionality
      vfio/virtio: Add PRE_COPY support for live migration
      vfio/virtio: Enable live migration once VIRTIO_PCI was configured
      vfio/mlx5: Fix an unwind issue in mlx5vf_add_migration_pages()
      vfio/mlx5: Fix unwind flows in mlx5vf_pci_save/resume_device_data()

 Documentation/ABI/testing/debugfs-hisi-migration |   25 +
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c   |  266 ++++-
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h   |   19 +
 drivers/vfio/pci/mlx5/cmd.c                      |    6 +-
 drivers/vfio/pci/mlx5/main.c                     |   35 +-
 drivers/vfio/pci/nvgrace-gpu/main.c              |    2 +
 drivers/vfio/pci/qat/main.c                      |    2 +-
 drivers/vfio/pci/vfio_pci_config.c               |   16 +-
 drivers/vfio/pci/virtio/Kconfig                  |   42 +-
 drivers/vfio/pci/virtio/Makefile                 |    3 +-
 drivers/vfio/pci/virtio/common.h                 |  127 ++
 drivers/vfio/pci/virtio/legacy_io.c              |  418 +++++++
 drivers/vfio/pci/virtio/main.c                   |  476 ++------
 drivers/vfio/pci/virtio/migrate.c                | 1337 ++++++++++++++++++++++
 drivers/virtio/virtio_pci_common.h               |   19 +-
 drivers/virtio/virtio_pci_modern.c               |  457 +++++++-
 include/linux/virtio.h                           |    1 +
 include/linux/virtio_pci_admin.h                 |   11 +
 include/uapi/linux/virtio_pci.h                  |  131 +++
 virt/kvm/vfio.c                                  |    2 +-
 20 files changed, 2920 insertions(+), 475 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-hisi-migration
 create mode 100644 drivers/vfio/pci/virtio/common.h
 create mode 100644 drivers/vfio/pci/virtio/legacy_io.c
 create mode 100644 drivers/vfio/pci/virtio/migrate.c


