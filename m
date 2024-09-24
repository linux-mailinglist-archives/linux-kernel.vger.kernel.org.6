Return-Path: <linux-kernel+bounces-336653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6A7983D98
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C37C2817AF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91DC12D1EA;
	Tue, 24 Sep 2024 07:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="di5CXtYJ"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D7D84E0D
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727161805; cv=none; b=ULnMyHs86+oIp4uUHxvpiWB5IQuoiCpbp2qfouTMAWxn89il/LU3Yu5uaTxt2kHhQstAb9v6cK6REVAUxMNJ7+dnDO9oE/QkaHKy+b95Js9E85FnywCFDa05VQKLnNP1/j21CR6giZ4NUotiHYjMKAuXpiG2iQa7JZ3L59gsMyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727161805; c=relaxed/simple;
	bh=QPajdV22rZnihgKAIkWl2EaW7aKjLgMWaHnc9ibIl/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pQpQfJd0fJ7/bxV20ClOF/HeHJxo2raSI/SyXnjpIK0+q5KRUM3hpun/FteK/fhn5cOBxHAEVe60iPw21I6yN38ePBKDn90Ti7ZRdcU/0kDGB+oq0WPUiUZcLp2QGsjjzalLtyEgaxWhqjxC2wDqOf4qoY1dEfxihkeNafRoTXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=di5CXtYJ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d87176316eso4394218a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 00:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1727161802; x=1727766602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yzo2H8d6ZWSTpRzfllRZ8YXEGlJS6NEXcuxM94LSSQE=;
        b=di5CXtYJ0taivy5wJzYEafdQ9Fqkc5CqyEvPSMmSp7U2hMAtk/GFetL+2yw6BHu8CB
         wigUkzJgJgRzQRF5Hga3NTRYmt7J3EMaMjOSw4gVaREXAXGJhsb81eiWa7cXl57H7w/9
         4p1Hh/7rogBQxyxEf3UFZhK5AEZ9JSK0BFrqnrOI7iWkgWcEQSOWLUSxRXNCmzgnvnZ9
         aAf35pjENAmsdqMsRdmTXKsJV0N5uQs4x1yIjHbF6rrZDHiju4KRf+jtFM9zDdc8nukf
         b/7C4gHSsVkswENh5MfmTJFsXcVGVCZyzOzVIuqEbZFgEArO9oi75gfnUNpTp9+3Qbai
         /9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727161802; x=1727766602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yzo2H8d6ZWSTpRzfllRZ8YXEGlJS6NEXcuxM94LSSQE=;
        b=K0MLiOiY3eDxyb6rZDbHrnys1UxOX6CnZsBq+ZyC3Flsb7PtrmdN1xkceuIPx/2xeS
         piPmNlt4kZABwMzarGzsCbcfDrX9+qfg85mMAhQS3B05vuxpwMt12HfKSXiRw3ksORLs
         UQFhPrbchfiE/l0gKkXGmshVT/kdw8oh082ADIdwEQwVTiNcCpMtE6W4jZmJuAcVkqpx
         T4wEOLMHkum5yHkE69NPSdWEzQ6ELUhEVNLb7w4rTebwrPOkJFrFR3UFR45/zAjv+891
         jufI4pP1WbPQktQzMxVKpubdD1kReLgXGS22L9npZ4kV0EWD/rVcwOsoztYXFwB8e2oB
         7QNA==
X-Forwarded-Encrypted: i=1; AJvYcCU0o8fZJzRudwLXeeuPhItUCfZhRQIRyL1Bnchl2ZZQyPMNJBLxiU13+Mw3Co7/oocGEF/RAXdyXo31GY4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjg3bFOcIsIlKb4XDIXkftW5HYK9OL92f/cUfnV49a0Liv4n8U
	eb7Mnc3S+Mkj0+8rjN2ckGjCfiTGf9CQzVj9hxS75ar55PQoa0aVAJHlP3Enj5A=
X-Google-Smtp-Source: AGHT+IGAFKrprsXiQuE02+8ygPUIUIiNGbBL7e1XZs0OIl0s6BrWWlUm2V1FPuDQvpu3rjJNUiLviQ==
X-Received: by 2002:a17:90a:8a8d:b0:2d8:e6d8:14c8 with SMTP id 98e67ed59e1d1-2e05686e640mr3358513a91.15.1727161801847;
        Tue, 24 Sep 2024 00:10:01 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2dd6ee98b8dsm10584472a91.16.2024.09.24.00.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 00:10:01 -0700 (PDT)
From: Jian-Hong Pan <jhp@endlessos.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Johan Hovold <johan@kernel.org>,
	David Box <david.e.box@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@endlessos.org,
	Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH v9 0/3] PCI: vmd: Enable PCI PM's L1 substates of remapped PCIe Root Port and NVMe
Date: Tue, 24 Sep 2024 15:05:52 +0800
Message-ID: <20240924070551.14976-2-jhp@endlessos.org>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Notice the VMD remapped PCIe Root Port and NVMe have PCI PM L1 substates
capability, but they are disabled originally.

Here is a failed example on ASUS B1400CEAE with enabled VMD:

10000:e0:06.0 PCI bridge [0604]: Intel Corporation 11th Gen Core Processor PCIe Controller [8086:9a09] (rev 01) (prog-if 00 [Normal decode])
    ...
    Capabilities: [200 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
                  PortCommonModeRestoreTime=45us PortTPowerOnTime=50us
        L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
                   T_CommonMode=0us LTR1.2_Threshold=0ns
        L1SubCtl2: T_PwrOn=0us

10000:e1:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD Blue SN550 NVMe SSD [15b7:5009] (rev 01) (prog-if 02 [NVM Express])
    ...
    Capabilities: [900 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
                  PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
        L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
                   T_CommonMode=0us LTR1.2_Threshold=101376ns
        L1SubCtl2: T_PwrOn=50us

According to "PCIe r6.0, sec 5.5.4", to config the link between the PCIe
Root Port and the child device correctly:
* Ensure both devices are in D0 before enabling PCI-PM L1 PM Substates.
* Ensure L1.2 parameters: Common_Mode_Restore_Times, T_POWER_ON and
  LTR_L1.2_THRESHOLD are programmed properly on both devices before enable
  bits for L1.2.

Prepare this series to fix that.

Jian-Hong Pan (3):
  PCI: vmd: Set PCI devices to D0 before enable PCI PM's L1 substates
  PCI/ASPM: Add notes about enabling PCI-PM L1SS to
    pci_enable_link_state(_locked)
  PCI: vmd: Save/restore PCIe bridge states before/after pci_reset_bus()

 drivers/pci/controller/vmd.c | 20 ++++++++++++++++----
 drivers/pci/pcie/aspm.c      |  6 ++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

-- 
2.46.1


