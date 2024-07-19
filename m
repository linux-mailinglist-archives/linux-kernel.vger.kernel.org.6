Return-Path: <linux-kernel+bounces-257052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F72937492
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 09:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4CEDB22639
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 07:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EE059168;
	Fri, 19 Jul 2024 07:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="pg0YvKPy"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D2657C8D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 07:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721375554; cv=none; b=et3oiSTWfNpNzBfzRplfgKPeZxdv8rutNVmvs724JkubGfiRyi4pwOgK7q0TboIhm5HlPBFxmFTCHBzXNOxVDjBoX9q3p39HSj0YTsqPsIkJf3ll85lIQMiFBoTaiYYeMbSYH5Jpe0rGPndI0BBW4PyXA6pS61JpS0m+aI6hahA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721375554; c=relaxed/simple;
	bh=qP6PS8j+5yMOFD4CbCQZisOY5HUz99JCpst3NMXxIhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H+9Z7NLi/aUw0Fal4L0FAoD1Y1Pfs0KwgsAWI7j2yzcjC+1c/cnAZrn6eaGz+RKxzYGG/cHyPOktDjiISH6yYPvBz++9Ybr7L+tdx+rCt9ZiOng0rn15ji3MbTQHgsYPwrGVtPFsetEKQiQzoWYNw+514XsuYKCLYguF6uACtns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=pg0YvKPy; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e026a2238d8so1682383276.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 00:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1721375550; x=1721980350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=55aXfChwRcmllhGH8VjIHFF0gPthm76qm4vIrxGKr+I=;
        b=pg0YvKPyXVYpACTRg6GdUHfIf3moMja8XFenxtfsPEtg9el4V5F0RFGf0rbHXqFjVD
         Mf9p7FSYAB76hTDaaC6KHe5nTgwVDucEW8dsVyiE35UvUgWKx/kkbojw78GIA8o0YF3k
         T046qv7BO9m+N2+ERbaqZz/KHSj6DqSdTJAulO+tw2+0ziguqDvLuhBSZh0Rq0FDzAGy
         ot3C2tzR75sZqdEhtGO0PrWD5C64GdJ4o1Oswipk4tjQnrdG1x+jhWJSlBVMKKMz9H9s
         MNBxVxnoNNt3IMAMHgggA2TW+T26gGzOJ6avJyHquloHbTi5byOz29durTfJmJXfBH6u
         sR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721375550; x=1721980350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=55aXfChwRcmllhGH8VjIHFF0gPthm76qm4vIrxGKr+I=;
        b=JY0ZsbQdS45yVXkn8uyOPPtHrAodlDEq4JpEexNMiBbRQpnfsKcrPlEOK+awn4Nxu5
         8O0YkdzQ0ZMfi+8khBwWR5ZR3YzHmQ3q3yrcHGHsr5Olfgfrlk82CCeNPP61iIomCUFW
         TMaFEozOa6SAfwSasZdL2YAHmST6BK97oXy/cJ3NfuSu+9INzsv6NLMLjYHqHE1ukM9+
         LQ4Tc11PYGtw92JN9O+thPI3dViR4gj/O7DH4ldiaHtGKLow9FOdGjMM/EwydENdt83z
         2n0Z+8LcAvHW80u/C6pO87L1WAztzDPkcUPVMrt/ZhaNGEQtPZbm2hunVVRvzSwe4Bbk
         MpqA==
X-Forwarded-Encrypted: i=1; AJvYcCW1jse4bqMn6cpBxXJ5rzfuCUMVTi+wmOdKD8HVNkb4a+Gzxtj3Pr3C01HF/R8/FKcBsLB4gwYFVtNvuJlLiTUAhZvyG+QLRV6dkZ0x
X-Gm-Message-State: AOJu0YyJJrlULbxEVrYPc9FnLchdh/Y5mwcjuH0JsIU05Fam/ajYnpg+
	gvsFCDyu7Dm55mjqmqx2BOteuenTCqfqFO9RertaDeveqLHmpZs8A3MMEXisMebuNP55Bfn3WLt
	FMsU=
X-Google-Smtp-Source: AGHT+IGmB1lgAWBoLGChS81Kvh4nHyCJovCQaeGnWYLxM/BVslhDq5ar7EVQGbKHOwQE0Um/ZCVzmA==
X-Received: by 2002:a05:6902:a85:b0:dfb:6ff:403e with SMTP id 3f1490d57ef6-e05feadc1b5mr6417137276.13.1721375550471;
        Fri, 19 Jul 2024 00:52:30 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-79db6cba71bsm577428a12.40.2024.07.19.00.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 00:52:30 -0700 (PDT)
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
Subject: [PATCH v8 0/4] PCI: vmd: Enable PCI PM's L1 substates of remapped PCIe Root Port and NVMe
Date: Fri, 19 Jul 2024 15:52:01 +0800
Message-ID: <20240719075200.10717-2-jhp@endlessos.org>
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

Jian-Hong Pan (4):
  PCI: vmd: Set PCI devices to D0 before enable PCI PM's L1 substates
  PCI/ASPM: Add notes about enabling PCI-PM L1SS to
    pci_enable_link_state(_locked)
  PCI/ASPM: Introduce aspm_get_l1ss_cap()
  PCI/ASPM: Fix L1.2 parameters when enable link state

 drivers/pci/controller/vmd.c | 13 +++++++----
 drivers/pci/pcie/aspm.c      | 44 ++++++++++++++++++++++++++++--------
 2 files changed, 44 insertions(+), 13 deletions(-)

-- 
2.45.2


