Return-Path: <linux-kernel+bounces-196334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D918D5A59
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5451F22DB1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03377D408;
	Fri, 31 May 2024 06:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EhfbK691"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08293F8FB
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 06:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717135908; cv=none; b=mpXkxNvPM7f2TD3LobBfI5/OolcKppVJ1Wov1WpsieVIYRoyNrKPZ1ZTS0HMQAI/lYCtPsmcUlEez+Pf+USsAZwxYfpDa0zH0IYFPCJ1PgT0MKft1ufcU4xhbUsK3uS0N/W3jseet9sT0gJWCC8VNB8MJ+JkpFlZi8cNZ5GXCOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717135908; c=relaxed/simple;
	bh=b0Y5dRLQaYt3mf0VGzfdq8z0+s59RcDFw7CTP55VyrU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vC+lWDk+gXq5m04RpbcqBJjWeXpKwF1qwgDGlO/LA0ut5auPfJ5nQ9C9cyVlQ2ag2fizVpAbNnJcxnzR1FDh1JKBykCjsSP1EzsCMeamqOivjOhpgtdPm8PKjVUwxm2/d/1VmpelnrA7EDLrcTJTfhg/hWBavi42v5vnuzLzjg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EhfbK691; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44V6AjaJ016213;
	Fri, 31 May 2024 01:10:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717135845;
	bh=WhEVFbeNknRh1BQSwCnDYk1qPCnB8HaWvQq4y3qw8pU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=EhfbK691DNfBC8sDsKUJ+XctjPTvAXm6Fa6mbOaogFzqQtOu/W+AFLgncCr+WrZ8N
	 tBiKxKA6BiTGYWoEdcuBU2uU3W67s12XMj2BaJPkQMGEi+y/Awgp8kHFswEREC6VoO
	 f1XwBGZ0svfPOEgTN/EOvFAPjnGPUPTj8jJ2dSKI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44V6AjL1047883
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 31 May 2024 01:10:45 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 31
 May 2024 01:10:44 -0500
Received: from DLEE100.ent.ti.com ([fe80::ad4d:c227:3f85:880d]) by
 DLEE100.ent.ti.com ([fe80::ad4d:c227:3f85:880d%17]) with mapi id
 15.01.2507.023; Fri, 31 May 2024 01:10:44 -0500
From: "Xu, Baojun" <baojun.xu@ti.com>
To: "tiwai@suse.de" <tiwai@suse.de>
CC: "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz"
	<perex@perex.cz>,
        "pierre-louis.bossart@linux.intel.com"
	<pierre-louis.bossart@linux.intel.com>,
        "Lu, Kevin" <kevin-lu@ti.com>,
        "Ding,
 Shenghao" <shenghao-ding@ti.com>,
        "Navada Kanyana, Mukund" <navada@ti.com>,
        "13916275206@139.com" <13916275206@139.com>,
        "Hampiholi, Vallabha"
	<v-hampiholi@ti.com>,
        "P O, Vijeth" <v-po@ti.com>,
        "Holalu Yogendra,
 Niranjan" <niranjan.hy@ti.com>,
        "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "liam.r.girdwood@intel.com"
	<liam.r.girdwood@intel.com>,
        "yung-chuan.liao@linux.intel.com"
	<yung-chuan.liao@linux.intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "soyer@irl.hu" <soyer@irl.hu>
Subject: Re: [PATCH v6 0/1] Add tas2781 driver for SPI.
Thread-Topic: [PATCH v6 0/1] Add tas2781 driver for SPI.
Thread-Index: AQHaseDnrvmrnJlJZ0CQY5+1p/UdJbGw25Ri
Date: Fri, 31 May 2024 06:10:44 +0000
Message-ID: <62a298a58b944ecdaa1b2842d51f3a38@ti.com>
References: <20240529155653.3037-1-baojun.xu@ti.com>
In-Reply-To: <20240529155653.3037-1-baojun.xu@ti.com>
Accept-Language: en-GB, zh-CN, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Pierre,

Do you know any different between windows and Ubuntu on SPI inialyze?
We are testing my patch on Laptop (HP-Varcolac, SSID:103C8B92, fly-out SPI =
& I2S cables), no any issue with wondows, but with Linux, second speaker ha=
s no sound, it's initialyze is totally same with first AMP, and relative re=
gisters can be dumped, no problem found.

Best Regards
Jim
________________________________________
From: Xu, Baojun
Sent: 29 May 2024 23:56
To: tiwai@suse.de
Cc: robh+dt@kernel.org; andriy.shevchenko@linux.intel.com; lgirdwood@gmail.=
com; perex@perex.cz; pierre-louis.bossart@linux.intel.com; Lu, Kevin; Ding,=
 Shenghao; Navada Kanyana, Mukund; 13916275206@139.com; Hampiholi, Vallabha=
; P O, Vijeth; Holalu Yogendra, Niranjan; alsa-devel@alsa-project.org; linu=
x-kernel@vger.kernel.org; liam.r.girdwood@intel.com; yung-chuan.liao@linux.=
intel.com; Xu, Baojun; broonie@kernel.org; soyer@irl.hu
Subject: [PATCH v6 0/1] Add tas2781 driver for SPI.

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
 sound/pci/hda/patch_realtek.c                 |   13 +
 sound/pci/hda/tas2781-spi.h                   |  148 ++
 sound/pci/hda/tas2781_hda_spi.c               | 1266 ++++++++++
 sound/pci/hda/tas2781_spi_fwlib.c             | 2101 +++++++++++++++++
 8 files changed, 3557 insertions(+)
 create mode 100644 sound/pci/hda/tas2781-spi.h
 create mode 100644 sound/pci/hda/tas2781_hda_spi.c
 create mode 100644 sound/pci/hda/tas2781_spi_fwlib.c

--
2.40.1


