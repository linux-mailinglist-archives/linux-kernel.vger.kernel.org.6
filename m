Return-Path: <linux-kernel+bounces-212815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2B99066B9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174A0281918
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0611420A3;
	Thu, 13 Jun 2024 08:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="m3qHUrZv"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5094739FCE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267291; cv=none; b=Jj+yrI8v2vmV5pTuwDHJ5j9DViQ1GaQkEf2t7RBdahhGdbADNRFknKFFGkIYzzJMnZaiZMUr7ngJJkI450xHWejVgkqFDhxJRY2D7P3qg//kHeVsay3RJuOO/6UOJTQT9ZxvvSbGFQVLMNXgMLtd9vAgHwXlNkCZIMTZy1vWF7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267291; c=relaxed/simple;
	bh=HAObrbbzE0TQLfgup3KQTN40gEAzIttEj6AOQZ738lM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uvzHwH4Y3bcQbhZWZPlj/Ii0J/UaUfq/FTQXb8u82ear6A+F7clQBP20dvoWlwz0gPeRvNYHoIC1ZhjqopG3uHJfC0dtrJWw/vkMtFr0qv/88s4t4KSF+bDuOeRJg+XYSE3fWCqp7H7EtrwIYo+JFonZsGmDLzBXiN4BzplyhX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=m3qHUrZv; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45D8R6kK096441;
	Thu, 13 Jun 2024 03:27:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718267226;
	bh=6NtxnPB5cbCDF/Wpkq/8aAGbHdXDlZm6OGryzWfh4Q8=;
	h=From:To:CC:Subject:Date;
	b=m3qHUrZvtUT/0EGVmM8zXu7fkYUEyab3avZE3nFIjK6h7aRc8kwwaw++77qReR/Jw
	 ZyGnkFgAETigxm7hpPGU9k+Ny7XJeF5WCpQ4O/cL06/HSJNFnfaUsSlBh4Vs7+GYrH
	 wKvPT/9gvccyBgP8L0OdBu9tQL5RUDSJdtLCPmlI=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45D8R6YF012520
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Jun 2024 03:27:06 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 03:27:06 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 03:27:06 -0500
Received: from lelvsmtp6.itg.ti.com ([10.250.165.138])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45D8QwPT058785;
	Thu, 13 Jun 2024 03:26:59 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <tiwai@suse.de>
CC: <robh+dt@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <lgirdwood@gmail.com>, <perex@perex.cz>,
        <pierre-louis.bossart@linux.intel.com>, <kevin-lu@ti.com>,
        <shenghao-ding@ti.com>, <navada@ti.com>, <13916275206@139.com>,
        <v-hampiholi@ti.com>, <v-po@ti.com>, <niranjan.hy@ti.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <liam.r.girdwood@intel.com>, <yung-chuan.liao@linux.intel.com>,
        <baojun.xu@ti.com>, <broonie@kernel.org>, <soyer@irl.hu>
Subject: [PATCH v7 0/1] Add tas2781 driver for SPI.
Date: Thu, 13 Jun 2024 16:26:32 +0800
Message-ID: <20240613082633.388-1-baojun.xu@ti.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This patch was used to add TAS2781 devices on SPI support in sound/pci/hda.
It use ACPI node descript about parameters of TAS2781 on SPI, it like:
    Scope (_SB.PC00.SPI0)
    {
        Device (GSPK)
        {
            Name (_HID, "TXNW2781")  // _HID: Hardware ID
            Method (_CRS, 0, NotSerialized)
            {
                Name (RBUF, ResourceTemplate ()
                {
                    SpiSerialBusV2 (...)
                    SpiSerialBusV2 (...)
                }
            }
        }
    }

And in platform/x86/serial-multi-instantiate.c, those spi devices will be
added into system as a single SPI device, so TAS2781 SPI driver will
probe twice for every single SPI device. And driver will also parser
mono DSP firmware binary and RCA binary for itself.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>

Baojun Xu (1):
  ALSA: hda/tas2781: Add tas2781 hda driver based on SPI

 drivers/acpi/scan.c                           |    1 +
 .../platform/x86/serial-multi-instantiate.c   |   12 +
 sound/pci/hda/Kconfig                         |   14 +
 sound/pci/hda/Makefile                        |    2 +
 sound/pci/hda/patch_realtek.c                 |   14 +
 sound/pci/hda/tas2781-spi.h                   |  148 ++
 sound/pci/hda/tas2781_hda_spi.c               | 1266 ++++++++++
 sound/pci/hda/tas2781_spi_fwlib.c             | 2101 +++++++++++++++++
 8 files changed, 3558 insertions(+)
 create mode 100644 sound/pci/hda/tas2781-spi.h
 create mode 100644 sound/pci/hda/tas2781_hda_spi.c
 create mode 100644 sound/pci/hda/tas2781_spi_fwlib.c

-- 
2.40.1


