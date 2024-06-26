Return-Path: <linux-kernel+bounces-230416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2AF917C89
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D2BC1C2350F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF4016DC08;
	Wed, 26 Jun 2024 09:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="mu4nQV4T"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D0416CD07
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719394210; cv=none; b=ln+uNpnxMJFmXNjvWieXY9fS6sQ2ohL0PnNABweRk2UIXG5nxI+tmgPsQBqxdmV2xNnZOakt/7swCHTQkbBJJEEFPFnDvoqFRubnxwwVUu687scnDhE9n7wT74qO6T1RhN1WX1zlnf9rW7Aw7qRyJXRryB8ak+Mrb/0WHWNMgL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719394210; c=relaxed/simple;
	bh=lDBfcXo4MYncJX2tMzyeD2qNceFjdFH7FKwnlwisHi0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=snQGoEijMKoSGO6gjjkVMNvuJ8y1JvWEqpJcdo4hfPzA9l/HbGk1a8ApQJ6K4o6199IFD5VjoB81AXva708ipwO977eSWcm4R1242VWZ6oD4IpHU+vzQocHk6YFHURav6BvkJFVMLeHKLUkBLaH7hKvdmSmzCjsl6QP5jlFZn+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=mu4nQV4T; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-6bce380eb9bso3933248a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 02:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1719394207; x=1719999007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kxer964xgyXPeOfcKPwyWSpEHZF7G93F+GF2s3GrJcU=;
        b=mu4nQV4Tu5vgqYN51F72WtzmyXMOjUGx1ufkjaTtgoPBCP37pehdWywZK2ssqYFMIJ
         rYokYk0XJl+NucxIiTs5TXoOH+Qr6qWas6jOQ+GmqWOlQV7o57olznMxi5CsYZXAlKS4
         BPrRbRZdrXyBRK1G78z//EipbblrCwbeyEIug3qCUw6Z7TDWuugmaJFr9aesc/1p9UnL
         beu0bdrkmLWVxOzTJezN9/Xh1uy85NIoeSiqOl68C0WxX09mfKvX+XcxOELeMB0NLyKp
         OgvM0q+dNJBccAHSR7pT7t31mRyn0ICaJr0hUsecMWfmg+gWhQ+LblUrvx8imsGr6AvN
         mprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719394207; x=1719999007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kxer964xgyXPeOfcKPwyWSpEHZF7G93F+GF2s3GrJcU=;
        b=FJW08C/6gtFrBMLrRHzd5rnHz7dn0vIB+dzfiNtoOTCZi6Y38c1MkFwoYiBti7qHyZ
         Q3EQ94akprqTaOkhi+X/0D9gbHOaV5vpYxbUubnWqF1VbWc8fKT5qyYHOJwhqBX6dDz9
         yVELENYoaqTxXrjNfDEXRkqQyR/Eoim+oPDUzT4ofnOmuhRtyUkrxmWFgbnVAsrfPO/Q
         Im2SH+0m3zWXK92TvUaQYsvyhVftOUD+xDnCEyN8xBSkG3VWrvKFExmDjjCayH5PGQAo
         GhxisfzFF/5YkHihRTSBiGVXkdH85Z8eUi4dvDn5VfboRGD49nD6a4UAiq+NFJBSe81A
         0NmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWakik7OA3L+pfn0tE/5VuqBwI+JJ9CAZ8F/4G0cWtbY9eamRCggnW/uTR+VN7r1ijEKpDEkAMY2Q1fXLAQXDp9sueBnnTAdknIIo/y
X-Gm-Message-State: AOJu0YzBiababB62IcfgfwMfbwGK3J8H9/FsksW0hz2gHv1MLtl/xKVA
	/kEOY7mAKuMlENzdDSQRqN0LEOgKEcDmHi8kCHqSaTVHaHGWwtMcuR8j8iQuYWA=
X-Google-Smtp-Source: AGHT+IGRzPevjU9Paw4Ge6XiaKZ6yUz3NHOTZ7GhcEPpP37dPvI7RAdoZRNUCqJpp8J86vlRiioX4A==
X-Received: by 2002:a05:6a20:341b:b0:1be:b30d:3b37 with SMTP id adf61e73a8af0-1beb30d3ca6mr899340637.36.1719394206912;
        Wed, 26 Jun 2024 02:30:06 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f9eb3c6ecdsm95257395ad.136.2024.06.26.02.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 02:30:06 -0700 (PDT)
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
Subject: [PATCH v7 0/4] PCI: vmd: Enable PCI PM's L1 substates of remapped PCIe Root Port and NVMe
Date: Wed, 26 Jun 2024 17:28:22 +0800
Message-ID: <20240626092821.14158-2-jhp@endlessos.org>
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

 drivers/pci/controller/vmd.c | 13 ++++++++----
 drivers/pci/pcie/aspm.c      | 40 ++++++++++++++++++++++++++++--------
 2 files changed, 40 insertions(+), 13 deletions(-)

-- 
2.45.2


