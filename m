Return-Path: <linux-kernel+bounces-366493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F5699F614
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7B01F26BFC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E8F20370D;
	Tue, 15 Oct 2024 18:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iu4EEd5U"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3DE20370F
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 18:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729018306; cv=none; b=OJRZRkAusnU/AmhGHKdPwYi4vn7vK1pHVFfSstWw8lUVRcY4QpoJoynlIsUtWYi/MSEBcaRM8kjtncy0rwuVOJu+N+aDbrHkMIweVy3oDvxtIqKRWBn7aLksE/jfKgS0IX6dz4pM3xMlytbro0rIwYc9+9TX36YcWibGbEVUJaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729018306; c=relaxed/simple;
	bh=YYwOSyuNwzPMG+/oq7uN2BePBtYq5BuqWQxzXADBcmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KzZuVFl9nzizODo1ZFO6EdtVvO0HSX8u+U87utwQ7mawQ+uS8WkA3hJIHp6AtUDdv+6aWknXDbP6/NnwZ5PDqul/m7l1zhNorzLVbyHSqgV/eYNHVqcwYBU691TMxSNubHz2Lu3aJ8H2dWcfN3IdYR30oJr4a04lLeCQ4PAuTFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iu4EEd5U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729018302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N0GRF4pPtSOgd1WabJUy8wYxVfX9TEQxA2AbPtBzocc=;
	b=Iu4EEd5Ungz9TYIabB7OQoafM2FugMHu+IEHY+MJU2v1rpk4B8WTbvCs5wF/3X848emf4u
	lVLtjoKUo6slnKtSu/ZRcmqKSuK57Ud5UxeIQqoJFtsvSBEWVh7FjQKkp0kgz76FPLr4Nt
	W8u8VXqQp1WlrQ88Ft9sMaRJMTj3MpY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-MRnd3YmjPvqS57TRhpXrIA-1; Tue, 15 Oct 2024 14:51:41 -0400
X-MC-Unique: MRnd3YmjPvqS57TRhpXrIA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5c94ccfb210so3348107a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 11:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729018300; x=1729623100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0GRF4pPtSOgd1WabJUy8wYxVfX9TEQxA2AbPtBzocc=;
        b=WKgMCPLZ1uQPWB9vkQC7f8h5IlXSN9yDogJGKE4koG31xYWmr1qtG5LSlssToKbM/i
         KhBWK/10Sxv/LusKEwoWjR1RH3k6Fd0wIhCECarTa33WXSVkGQcPFByswjE/5qo2gJRs
         Wxxq8Awu+Z7FxNeNHtnq0ceo2xQ4tn9EwXjLezavj2eUb64Lgkqpe6OvuoGXUMU6svpS
         9UbkYcq3xOqZJkSYvC6uHM9jaUC1hpNpj9tyTRQuhnN9rbYZIyYRJ8yEGknahFX7exLS
         yDdUiPC4F3hOy6P3OL6n1nYBmZKt1uCv7on6sqiDm72FjPXFsvyz9SUqP9LKLJ1+tPDt
         Ri8g==
X-Forwarded-Encrypted: i=1; AJvYcCUAFq1wVIlRonbZZ/FdV/PynJ3zSxmsLeoabbOnZ6DWG9gBEbxEzpjeJp1ESRZgSUq1FCRzBg1Fwvz5heg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbQK6rNf7Bl8HEGuGMxpxZ+uC9q3I3XFmdyra7QBR4GUP4qyBL
	TIEscow0cTiFInu5cHPJdL0qu40fAlbcz34nvBPhWF/GHVo5QrrbjYcT59LsNfRTxnNcYq8IXrD
	c9qKXwsT3VjYT6/kNKLxVdKFCRfTPx/lb/A8tyBCvTnCHVlY0Hvnigq8M2ad3nA==
X-Received: by 2002:a05:6402:5212:b0:5c9:547d:99 with SMTP id 4fb4d7f45d1cf-5c99501ced5mr1032564a12.2.1729018300235;
        Tue, 15 Oct 2024 11:51:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoUi+m94pA/sZ0UkPSNqunOeFPcNR+QjlgzRmDDQ7K7kAorm0A07Mz2aeKaa+48zMcVX+P9g==
X-Received: by 2002:a05:6402:5212:b0:5c9:547d:99 with SMTP id 4fb4d7f45d1cf-5c99501ced5mr1032505a12.2.1729018299657;
        Tue, 15 Oct 2024 11:51:39 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82d5d5a0006e2615320d1d4db.dip.versatel-1u1.de. [2001:16b8:2d5d:5a00:6e2:6153:20d1:d4db])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d39a9a2sm974438a12.0.2024.10.15.11.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 11:51:38 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Basavaraj Natikar <basavaraj.natikar@amd.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Dubov <oakad@yahoo.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rasesh Mody <rmody@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	Igor Mitsyanko <imitsyanko@quantenna.com>,
	Sergey Matyukevich <geomatsi@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sanjay R Mehta <sanju.mehta@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Chen Ni <nichen@iscas.ac.cn>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Ricky Wu <ricky_wu@realtek.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yi Liu <yi.l.liu@intel.com>,
	Christian Brauner <brauner@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Eric Auger <eric.auger@redhat.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Ye Bin <yebin10@huawei.com>,
	=?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Rui Salvaterra <rsalvaterra@gmail.com>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-sound@vger.kernel.org
Subject: [PATCH 00/13] Remove implicit devres from pci_intx()
Date: Tue, 15 Oct 2024 20:51:10 +0200
Message-ID: <20241015185124.64726-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

@Driver-Maintainers: Your driver might be touched by patch "Remove
devres from pci_intx()". You might want to take a look.

Changes since the RFC [1]:
  - Add a patch deprecating pci{m}_intx(). (Heiner, Andy, Me)
  - Add Acked-by's already given.
  - Export pcim_intx() as a GPL function. (Alex)
  - Drop patch for rts5280, since this driver will be removed quite
    soon. (Philipp Hortmann, Greg)
  - Use early-return in pci_intx_unmanaged() and pci_intx(). (Andy)

Hi all,

this series removes a problematic feature from pci_intx(). That function
sometimes implicitly uses devres for automatic cleanup. We should get
rid of this implicit behavior.

To do so, a pci_intx() version that is always-managed, and one that is
never-managed are provided. Then, all pci_intx() users are ported to the
version they need. Afterwards, pci_intx() can be cleaned up and the
users of the never-managed version be ported back to pci_intx().

This way we'd get this PCI API consistent again.

Patch "Remove devres from pci_intx()" obviously reverts the previous
patches that made drivers use pci_intx_unmanaged(). But this way it's
easier to review and approve. It also makes sure that each checked out
commit should provide correct behavior, not just the entire series as a
whole.

Merge plan for this is to enter through the PCI tree.

[1] https://lore.kernel.org/all/20241009083519.10088-1-pstanner@redhat.com/


Regards,
P.

Philipp Stanner (13):
  PCI: Prepare removing devres from pci_intx()
  ALSA: hda_intel: Use always-managed version of pcim_intx()
  drivers/xen: Use never-managed version of pci_intx()
  net/ethernet: Use never-managed version of pci_intx()
  net/ntb: Use never-managed version of pci_intx()
  misc: Use never-managed version of pci_intx()
  vfio/pci: Use never-managed version of pci_intx()
  PCI: MSI: Use never-managed version of pci_intx()
  ata: Use always-managed version of pci_intx()
  wifi: qtnfmac: use always-managed version of pcim_intx()
  HID: amd_sfh: Use always-managed version of pcim_intx()
  Remove devres from pci_intx()
  PCI: Deprecate pci_intx(), pcim_intx()

 drivers/ata/ahci.c                            |  2 +-
 drivers/ata/ata_piix.c                        |  2 +-
 drivers/ata/pata_rdc.c                        |  2 +-
 drivers/ata/sata_sil24.c                      |  2 +-
 drivers/ata/sata_sis.c                        |  2 +-
 drivers/ata/sata_uli.c                        |  2 +-
 drivers/ata/sata_vsc.c                        |  2 +-
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c        |  4 +--
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c |  2 +-
 .../wireless/quantenna/qtnfmac/pcie/pcie.c    |  2 +-
 drivers/pci/devres.c                          | 29 +++++--------------
 drivers/pci/pci.c                             | 19 ++++--------
 include/linux/pci.h                           |  1 +
 sound/pci/hda/hda_intel.c                     |  2 +-
 14 files changed, 26 insertions(+), 47 deletions(-)

-- 
2.47.0


