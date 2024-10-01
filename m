Return-Path: <linux-kernel+bounces-345504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D707F98B70A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831AE1F224C1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DAF19AD48;
	Tue,  1 Oct 2024 08:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="AprasQOE"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C233199FD2
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727771717; cv=none; b=Z0obQaL8Ub5Bxkc0QIlJjEoBSOnmmbyxTzIOQXcoRraODFzLqtI3U9W1JH+59BeoqCD+7YkYiT4RIxPJfmQ883EmT0WmgSQlfDfER3a60ZrQ7+Q9owH0PSxwzeNr8L7+RCmPwpMRnP3jx8v2KR1doWrMqOiZ7lRZmcYs9ESVdso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727771717; c=relaxed/simple;
	bh=sjT6ukd3PKEKSU3+RSXdWT/8Zkq2/Gnd0DL/XZxOjfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KdPuDk/fVqGhNqLw+6DJDWeg/3Cx3hG7tzvtRf1/toEOEGz2hTAhc5Xe2PqxmcLPvBQJTI82mJ2yFde9CrmtoBysfDS6o7g9V1LBeUtbcWYjz73GWJXjSwx/mFsxH095sI5wGWasyi5TkkfoHSiqyVbI3KzZVnyrAvKYYb1zdf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=AprasQOE; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-710e1a48130so1871359a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 01:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1727771713; x=1728376513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0xKp489To+kZdQ2N4G3JNP+h7PtJl5bQrYRI2mnZ3mY=;
        b=AprasQOEtjRs9/cJUQoZzoSQEScsPiuMi9fSzv/PnJ4YdE7icGtM/dCQZNXHwkY7m8
         PP+8VYOLtIQSLnrFzZ1cSYx0wHYZ53IsGacRNCzT4h3Z8SAIoI6VogWKVmJd98Dg1x0p
         KCqvgCGWK+mV4Zacz10Ju69EyW+M8aE8AsuHTGBHkU/dCIXKmUoDCMxd0QkCd8Ex1ToD
         O8NnNEdSDQRIDfOjdmpGO6h8MZBeViT/MJKO7bGf8+mFQDyvTfWd8dPSk9MDhqH6ZFOP
         W87B1lF5i4rU5Ho9cLTHwtfFzsQFj0XUuofJUDZlOiVDp9JL3qlJszew//uoBLowEoxP
         Zt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727771713; x=1728376513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0xKp489To+kZdQ2N4G3JNP+h7PtJl5bQrYRI2mnZ3mY=;
        b=pMZ2PzbjZlTDm0qiYYmvZCLn1Mf2oG0s3zGEMlZogfdnxO3knALe2RLbMI1vwwOccx
         8U5FWVFn2pNH9mhpB3EOLtiwqczuyVpkcLOxGJaVPAArezINF3cXLcjHZ03IXlCWRwqA
         MY8ao5Fu1hypvQaOBLpZcGKuS5ptX81LRFNO6XyZHiFGe71iU+LgRfPWXTdXf97mjjvr
         eSt1BhG7udnWWFpSkstW7pAtUn5IEvoIMtClhhP8W1+nvIKfJ4CzebqeLhpH40bGN43m
         Q9+5qLKXxUk1uL/TtOLDKPij8M8hMkWdAGwhffZpt8FZNpgN5H1I1GmHEbFBIY+RSP56
         H/gw==
X-Forwarded-Encrypted: i=1; AJvYcCVC/kKQMx728/O+b92uWKrlcw0bDm70s2Fw8Ewb77fdY0BjukwNBObBOuWLIt7Clq1ytS+/zQjagmbf8LM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdkjlIe0eTBzqVRbJERMT6DgIGV2/2gX+k5UJh5KP3cO9kBp66
	XA854jhNWpZ47+Ww0CJH+vhkfmMoGvKYUzDFgaOirHZusFqdIBHbk7UUe+uO9YI=
X-Google-Smtp-Source: AGHT+IHCmZL9lfI92oxKpIN8LZlTynU5oG9jp7HrYXx53tJm3QmqHAWVb6Nu97nnPilQHfWSE4RUPw==
X-Received: by 2002:a05:6830:610c:b0:710:f3ae:5a79 with SMTP id 46e09a7af769-714fbefe76dmr10684290a34.22.1727771713446;
        Tue, 01 Oct 2024 01:35:13 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71b26516148sm7521573b3a.110.2024.10.01.01.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 01:35:12 -0700 (PDT)
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
Subject: [PATCH v12 0/3] PCI: vmd: Enable PCI PM's L1 substates of remapped PCIe Root Port and NVMe
Date: Tue,  1 Oct 2024 16:34:36 +0800
Message-ID: <20241001083438.10070-2-jhp@endlessos.org>
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


