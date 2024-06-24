Return-Path: <linux-kernel+bounces-226818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6596C91444C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F44E1F23252
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87354964E;
	Mon, 24 Jun 2024 08:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="NFNVrUh8"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F24A4963E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719216700; cv=none; b=AjXGP+SjHrwZIOumtBAXvM+q3CRe36lOVfEcXDPrArwm0ZpvKh/lNWwnG3umXhEtyC1fUHux3v9St7yPVNe3ZJVOsurTpjTLL/b3c+8zgUdQE0lBWLgZyWS5a0M0+jvtYrcsfOzoZj8OOm8TK/dYRenFwWfpArBZOso9sepOeUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719216700; c=relaxed/simple;
	bh=7ksf9aEJgz40hmVhyKxMXv3XhkOYeMUS0Ab3WjDTLl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i3o77Fe4ontXn06sU9Gq170nleThmGwr/ID3vn/ZY4x6SLneZYRzLcbwAXI0nh4n3MaSoM4pkXzJ4R3rrUtT3Uqjp2lVzKGErx/GZJLpv6uI7ZZBNF9pRBnnNqssdSkMoexkIypYMwviR8XoNHc16OAKs4Xgu2EyAmejjG3OUYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=NFNVrUh8; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6f9fbec4fd9so2212077a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 01:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1719216698; x=1719821498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1bWqdbh6piHPKQhakpLxXBJ7wWL09Ug+BBJfp1dagVs=;
        b=NFNVrUh8ypK+nqVCM4JPo/TGpR/ZF+XoFwVfcFvmESi08p7X7UHBMPyl4ZHggRjCGw
         3W2vN4Wu/bmnJrPnfZYq6sCg+JjoTtGsPc+4H56ebOrJ4DokJvlbjb9qX+KV8ijFbkxK
         Q8mBBId7nyyzM55g6E7DQWQYl9S1z/4at98m6oUuJlSl4oXemFV96Nsgy3Q4PUuFhF5M
         fXPVAlMqSeo5gHPrRebmWcyZTilf/PnWTseUE9/9/HT7SP7hwfp10fIm4cyN74UcQthN
         GuE5Y87p6Q5WMK7+8KBMfyDg9L1P2MG7GrctahdeTYvgCqGc41jV0IzSb0okk+9tagvR
         7iHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719216698; x=1719821498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1bWqdbh6piHPKQhakpLxXBJ7wWL09Ug+BBJfp1dagVs=;
        b=YhnB8D8CEH9j2jR3/kmwHwFu5fjQti7ZqG73iEwftuYNQg9tEnoZ0nKOh6bR/3z3E1
         oBRZ5ltuZm/LGNybRSFFWr/A6rh3mkPy+x2gkp8lruu91lArHKMtjhhZmbRhbAO9uxam
         qcWG1n7pAWclRHeE9ht90AaFTGfJJC7DxTSNMQL6ZVoO+eyTst+A8OpTufDk2V0ZwMGy
         0+mDwLCXBuh/pxYlsWS6sFZ4qns6aZva0Z8TE2tWPmvwxsuPMzcirtK2ExPd/oqiwkXf
         mB82eEjv9phOSFC7x+57V6QZygrqQ7j4vIGV+amEL+LtjxC4UQ0uJR5qdXuGZHVSx6iu
         BKqg==
X-Forwarded-Encrypted: i=1; AJvYcCUJsKbYJGy+jLt5HESEdEU9G4y6BxoUpj6Ny2/VouyJtqWA3z54YNJMdOpFSd5g0qoEaxeWGrcDuOsQs/OUP0LrCvOE2ixFZPfbv93E
X-Gm-Message-State: AOJu0YxZOZoKcHc8l6WqLEYHQlhVS4rRTSSeA0yk0tlI9mZAR7gMfGX0
	Au92ONy1u1VVuzzlXc3buxDj5+Asw68xdDxDNpc9bGUJDWBUpSpQd/3wHmRGPc8=
X-Google-Smtp-Source: AGHT+IEaD5GBtPT/cw1JX323PXaFx8ViNSmytQEEvMG0JYhColsoY+4Z2lL2dbJKPQGt8NpfTxHGNw==
X-Received: by 2002:a9d:5e19:0:b0:6f9:5e9b:66e4 with SMTP id 46e09a7af769-700b11d1d80mr4261590a34.15.1719216698044;
        Mon, 24 Jun 2024 01:11:38 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-716bb22dffesm5029841a12.83.2024.06.24.01.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 01:11:37 -0700 (PDT)
From: Jian-Hong Pan <jhp@endlessos.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Johan Hovold <johan@kernel.org>,
	David Box <david.e.box@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@endlessos.org,
	Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH v6 0/3] PCI: vmd: Enable PCI PM's L1 substates of remapped PCIe Root Port and NVMe
Date: Mon, 24 Jun 2024 16:11:09 +0800
Message-ID: <20240624081108.10143-2-jhp@endlessos.org>
X-Mailer: git-send-email 2.45.2
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

10000:e0:06.0 PCI bridge: Intel Corporation 11th Gen Core Processor PCIe Controller (rev 01) (prog-if 00 [Normal decode])
    ...
    Capabilities: [200 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
        	  PortCommonModeRestoreTime=45us PortTPowerOnTime=50us
        L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
        	   T_CommonMode=45us LTR1.2_Threshold=101376ns
        L1SubCtl2: T_PwrOn=50us

10000:e1:00.0 Non-Volatile memory controller: Sandisk Corp WD Blue SN550 NVMe SSD (rev 01) (prog-if 02 [NVM Express])
    ...
    Capabilities: [900 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
                  PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
        L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
                   T_CommonMode=0us LTR1.2_Threshold=0ns
        L1SubCtl2: T_PwrOn=10us

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
  PCI: vmd: Drop resetting PCI bus action after scan mapped PCI child
    bus

 drivers/pci/controller/vmd.c | 33 +++++++++------------------------
 drivers/pci/pcie/aspm.c      |  6 ++++++
 2 files changed, 15 insertions(+), 24 deletions(-)

-- 
2.45.2


