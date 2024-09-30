Return-Path: <linux-kernel+bounces-343568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F53989CBD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F625283ADB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CB417A584;
	Mon, 30 Sep 2024 08:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="phbQ8+jK"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BF0176AC5
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 08:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727684783; cv=none; b=Rx0wLegfv40dIlVJCvfZEuv22CdoekSu//vXrpvFAFmvYG5b6uO3OoR9TQsxOc96e+xtT7Df1KXNoyx16AqMXZJHoQw7shKs2ranuBa6F9fkFOVZKiU6TKXLAG2sW/TeLZ5xAMvLg0qls8q1Q5LXH0E4TneIUzdBLHyo6Ao8ZPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727684783; c=relaxed/simple;
	bh=sjT6ukd3PKEKSU3+RSXdWT/8Zkq2/Gnd0DL/XZxOjfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G+F8dPGCHeHCsxQFj3hgBVwAy4BnEunZRp8i0WOv//sRTj/ApEmIuZ5bEnb37c9qmsLZhju7z9T2HhKbuDZVuCjhbUFNSfKVMITbZQW5VNrGmClhAggvlAGilW4NIfFejvRG4T/w3koQKas5eIbsz89ObDcuMSbdpu1SMxk5ShU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=phbQ8+jK; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-208cf673b8dso40793105ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 01:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1727684781; x=1728289581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0xKp489To+kZdQ2N4G3JNP+h7PtJl5bQrYRI2mnZ3mY=;
        b=phbQ8+jKhrI7SJ6uI2Vw9sI278SPoJx1gmhEWppG1kL2fHSLpkqVVa5YxSK0hS/oNj
         eROWJYmXSgprjOXErtkEAZg4cCuSQJhfVRoeVzi30709bg9aHBdDxkfg6jqoedj5u4Cb
         S1mNfD2GSNN2v3V4QWCo/XJ62NBISyQVFaxwtjRnhThViYVqzENWtJzza1Uh26HN1ERa
         uBirkiq76X+pjISGq3ZOS4OJSIFTvc32dOi2aXa9vghofo1jZf8e1Yqt6U16sp/TNgsT
         Ez5TcXbFvV+y8Qh+VeYx47I9TTSr/pU2KwtuhH++TWjKREzXeVZNXq5bYMJeowv11Okk
         Za1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727684781; x=1728289581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0xKp489To+kZdQ2N4G3JNP+h7PtJl5bQrYRI2mnZ3mY=;
        b=UaXSVLURXoVPFvreWppJ5QdawFHrgkk6HHk7Ft8mE4PWK3kR+Qfu4RUAeE2He9Nc55
         AFkdDBoh4FvJ5iRAB5ZAiAjIUfNe+y3h25ZsPCcTs6y79lygKoQ0J8BjDWFEbSkPnMrX
         fZozLclbAlpH+RGdBLLxLrcyaghUNzbMfpFVVcum9rFe9FmVGoG/jQ3OeuAeDSkNAShk
         YLzGL4XlK1vAJXhbhgEJ6jUsjPHKgxQD7sizSHQ9W5SglslZpblR0S5Xamdi4MHn4lJp
         vbDByntwc4aHhhLA0KCT5VQ2piJHu5dBhch+4/BxbQnlzlr9kNr7OkH268CD19K40gGj
         /thA==
X-Forwarded-Encrypted: i=1; AJvYcCVfhhcAcBZ6e4eVmWFDnWwiVQVpfSQOlasPCplPRdpFDoGYkjzpmP3z64CZXi5RtiNQPxlijA4Mxu185tA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2HqaEF06D/t96ZvWvcInt4DiiMt+MntYr7KxzF116SSHppVj4
	oBLpQ7cgb2yVyoMGb3eAMkwvXcl2aWW3kC6M797E1zrIGKKxp65M+miXB0nG4rs=
X-Google-Smtp-Source: AGHT+IGaxQOb0TqO2WjPoalsnOkl+vCSQMCAn+I6F760DUTsQiQBtZCg3SfU7TlgxH+Kt3DXCQg/AA==
X-Received: by 2002:a17:902:c942:b0:20b:9535:922d with SMTP id d9443c01a7336-20b95359428mr17802335ad.60.1727684780509;
        Mon, 30 Sep 2024 01:26:20 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20b37e0d60bsm49385555ad.129.2024.09.30.01.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 01:26:20 -0700 (PDT)
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
Subject: [PATCH v11 0/3] PCI: vmd: Enable PCI PM's L1 substates of remapped PCIe Root Port and NVMe
Date: Mon, 30 Sep 2024 16:25:31 +0800
Message-ID: <20240930082530.12839-2-jhp@endlessos.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
  PCI/ASPM: Make pci_save_aspm_l1ss_state save both child and parent's
    L1SS configuration

 drivers/pci/controller/vmd.c | 13 +++++++++----
 drivers/pci/pcie/aspm.c      | 26 +++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 5 deletions(-)

-- 
2.46.2


