Return-Path: <linux-kernel+bounces-308731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F7F966101
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30BAF287708
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638E8199FB1;
	Fri, 30 Aug 2024 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b="41r0yaKk"
Received: from FR6P281CU001.outbound.protection.outlook.com (mail-germanywestcentralazon11020111.outbound.protection.outlook.com [52.101.171.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5C514EC41;
	Fri, 30 Aug 2024 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.171.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725018604; cv=fail; b=bioCEDycWD7FHHMJ/cmrEgw/c48Z2oyi9atR6hPZINWNqAofAFXt9QxtmSYOC//HzMExPNwWrDsMuyqbK8+Q1upDh7t2szY7PxkZgiautZWcsgImKCQhe7+Ly+sNdz/svCJ9ENvVuFJdpQV9Asa7GE8u8r4hAubni/e3Gu0CKPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725018604; c=relaxed/simple;
	bh=8CWaak/pZCZO8z/lJVPu7LDSAb5BJLLpFGFwofU91bg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iqwnMIKOKEv1bCkuygE6LIhhgAW8cCKf7AV8d4N+Wo3kmV1Teqku7hksYM3EVLRt8amTRnk6anlqyBG1Xy8MCGx4l635VDnPN3Jfffz293ZfKkNXH+qPmin7zk6emJa8Hci0pdnaq7u2nYAT7JbeBhTFDs4WkHN9Bwm++X5fUUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Softing.com; spf=pass smtp.mailfrom=Softing.com; dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b=41r0yaKk; arc=fail smtp.client-ip=52.101.171.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Softing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Softing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tfq3svmdZqd3Dn3vNB9h4HBi3/oiPOZ1vCHuEnPRiWGwC3MImZHMM19/Os4k643I8RqdqFJJkumxYvbgaSkSPZlQTGdaIhLl9W2kILQ32Mmrj1mm1QdUCfd0Ww/+TiuWxt/y9vsmgzGFqu7ogs396Itb6+aY/wWCtGc6AnJUYIYlGva/eFUtrUcpBwzPn16IoFiMFw1AxGno4Z6yVi0ArNYwz1mjYZIYvF6McFWAvxykF39BKocJ7FrgADgyGRvGlUM3J4x6T1ooDJ4shB74VHv7hemJJx2k43srgx2FtyYxu1rgHVfu1U2Q1Mb4OxXGyBBQTuP7IKZ4n4/dFRPQzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHpRLIz3n7m0ZZ7e26E+e30NvMPKdoLbhemD3VX3nMc=;
 b=MXu02LERkenwVHD/mtA1QD1jJ95ng7YjUuc6ft41GOFYRjKblR1FkynQ0i715eD6CvGbQfGoGO16HFmjC3kBMh6UZHFifChDlmRhQ/My3l9cjX6A4lElAx0tfbWOuR3n3Qzi1PF1ODLv6xP8kyKrF2feYbktVT6bX4tVikR+v40jylk1VDCTUeEzBDErHo2za1eXDWWnQVkprCZ7iAbCUNhJXzYaQgjBKNi0Cm7npPkfoTC3Cnc3XTvPiJbFTiOW8C6wewEWDUp3hC7wSAGBtcD3cswqdOHC/m7Z9ye+HTCdtp06Io7FsAm8MOncZbZm5WY/vqrNMITpni38asA3xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softing.com; dmarc=pass action=none header.from=softing.com;
 dkim=pass header.d=softing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=softing.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHpRLIz3n7m0ZZ7e26E+e30NvMPKdoLbhemD3VX3nMc=;
 b=41r0yaKkwHuI3NUh8DHkQdr6UR0jZCsJCHgwlJCdXVps2qQFH/9xZ0GBdhCzjIFj88erYiPRo+q7fM+mN0JRphu8JrVOk0fcUoWZugCUlFmYB/nzEKjoBlR5d51f52Fgzo8tJPvOjaDXtWXcSx9qM5/cmlETSZNgWyUf/MPSkWbteQe45RWTxqd5YPABSPIIdRJ0L+GndBFugMnkvGflcn1RZYUwOuDlVBaR8Gqdd8q5wzmpAlxJnQt0wZZQcSQCHFyOhls2o4SY6FPA9a9QjMvI/FAk9ItCcPpGAfBw0Xs52qCe22nrtEOmk7EH6eLb8Qoi6DxSWW0OkbR7S4q5Fw==
Received: from BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::7) by
 FR2P281MB2926.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:65::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.20; Fri, 30 Aug 2024 11:49:57 +0000
Received: from BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8de2:b2ba:4092:939a]) by BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8de2:b2ba:4092:939a%6]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 11:49:56 +0000
From: "Sperling, Tobias" <Tobias.Sperling@Softing.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
CC: "jdelvare@suse.com" <jdelvare@suse.com>, "linux@roeck-us.net"
	<linux@roeck-us.net>, "Sperling, Tobias" <Tobias.Sperling@Softing.com>
Subject: [PATCH 2/2] hwmon: Add driver for ADS71x8
Thread-Topic: [PATCH 2/2] hwmon: Add driver for ADS71x8
Thread-Index: Adr60nxZNNNsP9NXTlO1squBQ91rSA==
Date: Fri, 30 Aug 2024 11:49:56 +0000
Message-ID:
 <BE1P281MB2420E8DFF47AD9754CEB3970EF972@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Softing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB2420:EE_|FR2P281MB2926:EE_
x-ms-office365-filtering-correlation-id: 617b6842-c63d-461c-e18c-08dcc8e9deb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6TyNNzrxjQR0p0JnlcMXGqmNKZmYqyzvjW8hbk4khjz8zu6wLqbshvvXnM3L?=
 =?us-ascii?Q?KrO70Gk6pivQ1vF/5Bn47+s1HBOvtuOIqgglxiqhzpAv+HtbrO0ZolRYKy/B?=
 =?us-ascii?Q?1Gkc3DLYLJGo/AYZrfg85j/Hw8YRz5qn5Rdk2Z56oPZgy5eoLdSoRDYreunj?=
 =?us-ascii?Q?puAY/ldTrkuN6/hHA55ZV/1UV6sNIx91567pyPOMY4LRmunCGxdm0PQRnrdz?=
 =?us-ascii?Q?6INKLjnkzqhhyccnQP9O47IowlK+KqxW5BQWgALVeFaJU44rYQpSnVbpJ7Fr?=
 =?us-ascii?Q?l3ErieOUyRUVjrTjnuNQzbYPyGIOkcDtFw/ZFMmCNLu2L5vGT3c59PkAQUaC?=
 =?us-ascii?Q?/6C6bcIhnYDOLlDQ3ejXcaUN5dTevpAiW3wGS56vCWH4eMzV/hv5hjoIawQJ?=
 =?us-ascii?Q?x7MI+4KG10PSqmBLJlQM7sdk+0TkIFDZW68na7YkbaB6f3FZTaC3S3pPjhZs?=
 =?us-ascii?Q?GoPzyS2qBsRWyUGyVsGUWPA2aq9pXW6IahDbXiezR8KukWIQ5ojIp2Ld9AmE?=
 =?us-ascii?Q?x2zRk2e4KScsTSVmSh34jleTYJBF57vMGh/UPleO2P70sYJ+fGP+pI3MtEKK?=
 =?us-ascii?Q?69X2c7g+er+AH894OjOS8HAx049To5TnA8oW/NF2Me0xQNIw2gTBZQ7/vqFm?=
 =?us-ascii?Q?pGhvUbp/Xp9fg6O7JaixFWMfs3ZwsDkvICq6O0CuwrU7lCxSFymYguctiRWX?=
 =?us-ascii?Q?bvGpQ5UaudmDLIcEM52p0mm4RTmw3+KCjSo2DWgYXYeTmKX/C3pKxng5t+9W?=
 =?us-ascii?Q?zDCHBzoMLZNKj0UZj3r0e5e8I5Y4ZLlYtWmVpr8LCwgjzCQzoBFYwzB1XENa?=
 =?us-ascii?Q?fIB5k6IrVCEn8VdMr96l/llAQ9vVE3o7qrUGH395ffIBezQQRvQrIHKd/WcG?=
 =?us-ascii?Q?o4SdmC+VNeppwCHYiIQOvK9I+82Nu2qM6xozoYPfv2uz4cFRwXIw+J8j+PVM?=
 =?us-ascii?Q?4rtVE535/1er/lnm/31p58yFp0bOGq1bbMlWQKEnVh6R9NhuY7KrBD6p8yjt?=
 =?us-ascii?Q?Xu1Js30P8JMIkyQlsnftYWxofrh1tC+orp9lZarQS5XGmPVId6SAXGPgDSqE?=
 =?us-ascii?Q?KdnGAV/VKtd2TqKho2qIMTHEIMGpccVK31H8XpgERe9j+hPxwHi5ZD9t6wUr?=
 =?us-ascii?Q?hT1ZnxHD+Tf5I2XEaGJ6BLEEsHcSGNlPLsnFS03aeeq/tvaHNJT4T7R05nCt?=
 =?us-ascii?Q?qXUnXh21xwV6GC8TmdCGG87+V6QNp+BgDeyjAYY9xWMU4Op2S35M0DH+aZy4?=
 =?us-ascii?Q?+KYdEkbVYNWVdPXAgJP5Fom6moGek32afAyH7owMnh4VZw3qD5hsGlW/8g8u?=
 =?us-ascii?Q?YOesjKshnwVFpv9OrY1HM9WkqAKzKyCA9QEd9A8h6VJZdIe9h6yA8x0ezpM2?=
 =?us-ascii?Q?xRWZgRIfE8NkNO/HR/6xVQo5SYF+Xi1b+QgBw0DgDNKWFPsWqA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xpdAngn+qjpm5VGCd4HVitA5GiQ1W9G2iFk/FY8JiWeSPj12XJ0UeOsXRxqK?=
 =?us-ascii?Q?WzewmT9zEUgViRdGcb0S0hT/s5Q3XHY1Qbd1Q7M7Wuy3ivL+WsBKuQstVlJN?=
 =?us-ascii?Q?wlFWqg6Ll0Yryr3ffRKjQTNvx9fW50omCpgN+vofxJwgXl4f2jtrUPv1PE0y?=
 =?us-ascii?Q?Ji1tZrLE7uA75u2/8PLpmHKDh5MHP+VOehKGaYNeM4ElJ0PtE5MI2kR1kW1m?=
 =?us-ascii?Q?z12AJgGKdOPetxZX6fIMnk28vALzMETrA9lGNg6A+P0Idj/VIbhMl9Mmf7HG?=
 =?us-ascii?Q?V6e2nrdkUj6cILfhD9t4g4xqf6+h/nyKYC6/bMovk5hhO2zt6H84lHSB62i8?=
 =?us-ascii?Q?C96qvYqdn2lvLjlOPvXjU+brl1YCngU0dBfX6ahVFLl4zqGDTP+P1aItGEZX?=
 =?us-ascii?Q?VvgN6jHnzUr+hhO8LL819jUji9hrQPF4bIkU6HiPj0KjqLI0l+HJRjqVpQ4T?=
 =?us-ascii?Q?GvdeYvjH1M8gVqGNB0yFPHI76SeYZrVMV7JY7txCqQs1ehT2QK7TGOpNYxsU?=
 =?us-ascii?Q?+pUl/R4pgcBDZBQcC/YvXdi1A7ArqGO4AED6VdwCJLsX/Y5IhRYPJurVtRb1?=
 =?us-ascii?Q?q4ePXFhNHHDBT4aZ//ji07puRuyWykDXscDGlV8L7Mv1FMp8WwKhK57AgLWK?=
 =?us-ascii?Q?bl587X9xV0cxdiapYaOWSK/dvdIUkqVHnMOgCNz1kq22kt1WWJ51QNqoR5Or?=
 =?us-ascii?Q?YIRd8mlLeVaTYnJpw/+5MswTweW+25E+hua12jRS60nl0wH4Z3DGxmfCVdzn?=
 =?us-ascii?Q?XuAMBbKOzgWBnTBz+jbnOuJKjqAmqbZhtaE9HeFW0CQNgawOqHgksqvgQ/Jt?=
 =?us-ascii?Q?wmFz9GWLlnBuZRp161M1FRGveLlDIdTFRSgTKDprpY14F6iRFkhK/nRKqWCH?=
 =?us-ascii?Q?RzEpQtyOl0VlO8Ag+8LUd0nFjiXaDrONuZl8V7JgoMw1b5wUm6SV5c4YL3Vx?=
 =?us-ascii?Q?mmUU/9aNHgFndU3JjgIjogY+iP4VlpXHV1/BWKQcORqYd6SZ03y4xHZGtyK5?=
 =?us-ascii?Q?iIJ9B9tCgBl7D24zuOfOCI/ss0TRQOXZ5zcRb4OJIUukFJvu9oDjiyF8IEZB?=
 =?us-ascii?Q?4DxBn7AIH5bp3kKaknZyJb+fbflO3rjvy/ECUBBznZU3oT/Cw2ejgf4Emkcy?=
 =?us-ascii?Q?3tDXuGfOfy+Vmd7To2rcqI0lckb6y+ppbey2Mj7Xau5gB5/HxVera+wbUsah?=
 =?us-ascii?Q?okn5lPM3RR/O0nPvzbILjqDbuhD9xqKYDr4X9FfmazinQUJcR5PCn6UJQPxa?=
 =?us-ascii?Q?sQCy9DV8+zvAXF0ofqM0NJkzebFhXtME+S/vFATVSi7KYjTQgC+lGFRI4+IS?=
 =?us-ascii?Q?VHvBHg6WQ6Facv665e0wINmqjq/etdCROHQqvZcYhsERCYhMMr1VDgmbf6kX?=
 =?us-ascii?Q?QLVnsDO2n5rRqcQ5F90BfGoJ4e1vkpZYsjUKl3esYPWubIWXVC6aaS4Vp4e5?=
 =?us-ascii?Q?zSFXobqOGzLGkcpy0HqaSglhW2ypee5gMZYeYVgUQwFVQpsVnSiXvhNps5Zg?=
 =?us-ascii?Q?ojG6EAkGUZtxlhNb9/DoVSvP1P/yIMJsQF5IyWp+p5HobDBOG5f6Czu8/IDf?=
 =?us-ascii?Q?5rAlFzPXhM2mhBhYaFSo1XF0CvAOxXPA9ICSDYG/T6HqSNuaiJj68HO2HAn1?=
 =?us-ascii?Q?Z0YwQPFodAwA2bRfM71EQt3MOGtMR/7W2gIDonVDXdzpAHfHZlfTXLRRkFsX?=
 =?us-ascii?Q?8e1YQQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: softing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 617b6842-c63d-461c-e18c-08dcc8e9deb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2024 11:49:56.9208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe3606fa-d397-4238-9997-68dcd7851f64
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BkxrmM9Nv/b/+h78zQCW3DT8Q2ig6lya8lIdCAF6Gw12pMvmc520o2MxK+js9lfT6PS937/reOJrrE+2ZiFKdjd29ARr461tJ7cSeD1L9g8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB2926

From 4b2836f3984ceee899b55448fc4b25cf27e5912e Mon Sep 17 00:00:00 2001
From: Tobias Sperling <tobias.sperling@softing.com>
Date: Fri, 23 Aug 2024 12:07:50 +0200
Subject: [PATCH 2/2] hwmon: Add driver for ADS71x8

Add driver for ADS7128 and ADS7138 12-bit, 8-channel analog-to-digital
converters. These ADCs have a wide operating range and a wide feature
set. Communication is based on an I2C interface.
The driver provides the functionality of manually reading single channels
or sequentially reading all channels automatically.

Signed-off-by: Tobias Sperling <tobias.sperling@softing.com>
---
 drivers/hwmon/Kconfig   |  10 +
 drivers/hwmon/Makefile  |   1 +
 drivers/hwmon/ads71x8.c | 702 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 713 insertions(+)
 create mode 100644 drivers/hwmon/ads71x8.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index b60fe2e58ad6..062ff1dfc8fa 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2090,6 +2090,16 @@ config SENSORS_ADC128D818
 	  This driver can also be built as a module. If so, the module
 	  will be called adc128d818.
=20
+config SENSORS_ADS71X8
+	tristate "Texas Instruments ADS7128 and ADS7138"
+	depends on I2C
+	help
+	  If you say yes here you get support for Texas Instruments ADS7128 and
+	  ADS7138 8-channel A/D converters with 12-bit resolution.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called ads71x8.
+
 config SENSORS_ADS7828
 	tristate "Texas Instruments ADS7828 and compatibles"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index b1c7056c37db..e6488368b890 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_SENSORS_ADM1029)	+=3D adm1029.o
 obj-$(CONFIG_SENSORS_ADM1031)	+=3D adm1031.o
 obj-$(CONFIG_SENSORS_ADM1177)	+=3D adm1177.o
 obj-$(CONFIG_SENSORS_ADM9240)	+=3D adm9240.o
+obj-$(CONFIG_SENSORS_ADS71X8)	+=3D ads71x8.o
 obj-$(CONFIG_SENSORS_ADS7828)	+=3D ads7828.o
 obj-$(CONFIG_SENSORS_ADS7871)	+=3D ads7871.o
 obj-$(CONFIG_SENSORS_ADT7X10)	+=3D adt7x10.o
diff --git a/drivers/hwmon/ads71x8.c b/drivers/hwmon/ads71x8.c
new file mode 100644
index 000000000000..f9334ba7187c
--- /dev/null
+++ b/drivers/hwmon/ads71x8.c
@@ -0,0 +1,702 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * ads71x8.c - driver for TI ADS71x8 8-channel A/D converter and compatibl=
es
+ *
+ * For further information, see the Documentation/hwmon/ads71x8.rst file.
+ */
+
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+
+#define MODULE_NAME "ads71x8"
+
+/* AVDD (VREF) operating range */
+#define ADS71x8_AVDD_MV_MIN		2350
+#define ADS71x8_AVDD_MV_MAX		5500
+
+/* ADS71x8 operation codes */
+#define ADS71x8_OPCODE_WRITE		0x08
+#define ADS71x8_OPCODE_SET_BIT		0x18
+#define ADS71x8_OPCODE_BLOCK_WRITE	0x28
+#define ADS71x8_OPCODE_BLOCK_READ	0x30
+
+/* ADS71x8 registers */
+#define ADS71x8_REG_GENERAL_CFG		0x01
+#define ADS71x8_REG_OSR_CFG		0x03
+#define ADS71x8_REG_OPMODE_CFG		0x04
+#define ADS71x8_REG_SEQUENCE_CFG	0x10
+#define ADS71x8_REG_CHANNEL_SEL		0x11
+#define ADS71x8_REG_AUTO_SEQ_CH_SEL	0x12
+#define ADS71x8_REG_ALERT_CH_SEL	0x14
+#define ADS71x8_REG_EVENT_FLAG		0x18
+#define ADS71x8_REG_EVENT_HIGH_FLAG	0x1A
+#define ADS71x8_REG_EVENT_LOW_FLAG	0x1C
+#define ADS71x8_REG_HIGH_TH_CH0		0x21
+#define ADS71x8_REG_LOW_TH_CH0		0x23
+#define ADS71x8_REG_MAX_CH0_LSB		0x60
+#define ADS71x8_REG_MIN_CH0_LSB		0x80
+#define ADS71x8_REG_RECENT_CH0_LSB	0xA0
+
+/*
+ * Modes after ADS71x8_MODE_MAX can't be selected by configuration
+ * and are only intended for internal use of the driver.
+ */
+enum ads71x8_modes { ADS71x8_MODE_MANUAL, ADS71x8_MODE_AUTO,
+	ADS71x8_MODE_MAX, ADS71x8_MODE_AUTO_IRQ };
+
+/* Client specific data */
+struct ads71x8_data {
+	const struct i2c_device_id *id;
+	struct i2c_client *client;
+	struct device *hwmon_dev;
+	int vref; /* Reference voltage in mV */
+	struct mutex lock;
+	u8 mode;
+	u16 interval_us; /* Interval in us a new conversion is triggered */
+	long alarms; /* State of window comparator events */
+};
+
+struct ads71x8_val_map {
+	u16 val;
+	u8 bits;
+};
+
+static const struct ads71x8_val_map ads71x8_intervals_us[] =3D {
+	{ 1, 0x0 }, { 2, 0x02 }, { 3, 0x03 }, { 4, 0x04 }, { 6, 0x05 },
+	{ 8, 0x06 }, { 12, 0x07 }, { 16, 0x08 }, { 24, 0x09 }, { 32, 0x10 },
+	{ 48, 0x11 }, { 64, 0x12 }, { 96, 0x13 }, { 128, 0x14 },
+	{ 192, 0x15 }, { 256, 0x16 }, { 384, 0x17 }, { 512, 0x18 },
+	{ 768, 0x19 }, { 1024, 0x1A }, { 1536, 0x1B }, { 2048, 0x1C },
+	{ 3072, 0x1D }, { 4096, 0x1E }, { 6144, 0x1F }
+};
+
+/* List of supported devices */
+enum ads71x8_chips { ads7128, ads7138 };
+
+static const struct i2c_device_id ads71x8_device_ids[] =3D {
+	{ "ads7128", ads7128 },
+	{ "ads7138", ads7138 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ads71x8_device_ids);
+
+static const struct of_device_id __maybe_unused ads71x8_of_match[] =3D {
+	{
+		.compatible =3D "ti,ads7128",
+		.data =3D (void *)ads7128
+	},
+	{
+		.compatible =3D "ti,ads7138",
+		.data =3D (void *)ads7138
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ads71x8_of_match);
+
+static int ads71x8_i2c_write_block(const struct i2c_client *client, u8 reg=
,
+	u8 *values, u8 length)
+{
+	struct ads71x8_data *data =3D i2c_get_clientdata(client);
+	int ret;
+	struct i2c_msg msgs[] =3D {
+		{
+			.addr =3D client->addr,
+			.flags =3D 0,
+			.len =3D length + 2, /* "+ 2" for OPCODE and reg */
+		},
+	};
+
+	msgs[0].buf =3D kmalloc(msgs[0].len, GFP_KERNEL);
+	if (!msgs[0].buf)
+		return -ENOMEM;
+
+	msgs[0].buf[0] =3D ADS71x8_OPCODE_BLOCK_WRITE;
+	msgs[0].buf[1] =3D reg;
+	memcpy(&msgs[0].buf[2], values, length);
+
+	mutex_lock(&data->lock);
+	ret =3D i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+	mutex_unlock(&data->lock);
+	kfree(msgs[0].buf);
+
+	return ret;
+}
+
+static int ads71x8_i2c_write(const struct i2c_client *client, u8 reg, u8 v=
alue)
+{
+	return ads71x8_i2c_write_block(client, reg, &value, sizeof(value));
+}
+
+static int ads71x8_i2c_set_bit(const struct i2c_client *client, u8 reg, u8=
 bits)
+{
+	struct ads71x8_data *data =3D i2c_get_clientdata(client);
+	int ret;
+	u8 buf[3] =3D {ADS71x8_OPCODE_SET_BIT, reg, bits};
+	struct i2c_msg msgs[] =3D {
+		{
+			.addr =3D client->addr,
+			.flags =3D 0,
+			.len =3D ARRAY_SIZE(buf),
+			.buf =3D buf,
+		},
+	};
+
+	mutex_lock(&data->lock);
+	ret =3D i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static int ads71x8_i2c_read_block(const struct i2c_client *client, u8 reg,
+	u8 *out_values, u8 length)
+{
+	struct ads71x8_data *data =3D i2c_get_clientdata(client);
+	int ret;
+	u8 buf[2] =3D {ADS71x8_OPCODE_BLOCK_READ, reg};
+	struct i2c_msg msgs[] =3D {
+		{
+			.addr =3D client->addr,
+			.flags =3D 0,
+			.len =3D ARRAY_SIZE(buf),
+			.buf =3D buf,
+		},
+		{
+			.addr =3D client->addr,
+			.flags =3D I2C_M_RD,
+			.len =3D length,
+			.buf =3D out_values,
+		},
+	};
+
+	mutex_lock(&data->lock);
+	ret =3D i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static int ads71x8_i2c_read(const struct i2c_client *client, u8 reg)
+{
+	u8 value;
+	int ret =3D ads71x8_i2c_read_block(client, reg, &value, sizeof(value));
+
+	if (ret < 0)
+		return ret;
+	return value;
+}
+
+static int ads71x8_i2c_read_manual(const struct i2c_client *client, u8 cha=
nnel,
+	u16 *out_value)
+{
+	struct ads71x8_data *data =3D i2c_get_clientdata(client);
+	int ret;
+	u8 buf[3] =3D {ADS71x8_OPCODE_WRITE, ADS71x8_REG_CHANNEL_SEL, channel};
+	struct i2c_msg msgs[] =3D {
+		{
+			.addr =3D client->addr,
+			.flags =3D 0,
+			.len =3D ARRAY_SIZE(buf),
+			.buf =3D buf,
+		},
+		{
+			.addr =3D client->addr,
+			.flags =3D I2C_M_RD,
+			.len =3D 2,
+			.buf =3D buf,
+		},
+	};
+
+	mutex_lock(&data->lock);
+	ret =3D i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+	mutex_unlock(&data->lock);
+
+	/*
+	 * For manual reading the order of LSB and MSB is swapped in comparison
+	 * to the other registers.
+	 */
+	*out_value =3D ((buf[0] << 8) | buf[1]);
+
+	return ret;
+}
+
+static int ads71x8_read_input_mv(struct ads71x8_data *data, u8 reg, long *=
val)
+{
+	u8 values[2];
+	int ret;
+
+	ret =3D ads71x8_i2c_read_block(data->client, reg, values,
+		ARRAY_SIZE(values));
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Mask the lowest 4 bits, because it has to be masked for some
+	 * registers and doesn't change anything in the result, anyway.
+	 */
+	*val =3D ((values[1] << 8) | (values[0] & 0xF0));
+	/*
+	 * Standard resolution is 12 bit, but can get 16 bit if oversampling is
+	 * enabled. Therefore, use 16 bit all the time, because the registers
+	 * are aligned like that anyway.
+	 */
+	*val =3D DIV_ROUND_CLOSEST(*val * data->vref, (1 << 16));
+	return 0;
+}
+
+static int ads71x8_read(struct device *dev, enum hwmon_sensor_types type,
+	u32 attr, int channel, long *val)
+{
+	struct ads71x8_data *data =3D dev_get_drvdata(dev);
+	u8 reg, values[2];
+	u16 tmp_val;
+	int ret;
+
+	switch (type) {
+	case hwmon_chip:
+		switch (attr) {
+		case hwmon_chip_samples:
+			ret =3D ads71x8_i2c_read(data->client, ADS71x8_REG_OSR_CFG);
+			if (ret < 0)
+				return ret;
+			*val =3D (1 << (ret & 0x07));
+			return 0;
+		case hwmon_chip_update_interval:
+			*val =3D data->interval_us;
+			return 0;
+		case hwmon_chip_alarms:
+			*val =3D data->alarms;
+			/* Reset alarms after reading */
+			data->alarms =3D 0;
+			return 0;
+		default:
+			return -EOPNOTSUPP;
+		}
+
+	case hwmon_in:
+		switch (attr) {
+		case hwmon_in_input:
+			if (data->mode =3D=3D ADS71x8_MODE_MANUAL) {
+				ret =3D ads71x8_i2c_read_manual(data->client,
+					channel, &tmp_val);
+				*val =3D tmp_val;
+			} else {
+				reg =3D ADS71x8_REG_RECENT_CH0_LSB + (2 * channel);
+				ret =3D ads71x8_i2c_read_block(data->client, reg,
+					values, ARRAY_SIZE(values));
+				*val =3D ((values[1] << 8) | values[0]);
+			}
+			if (ret < 0)
+				return ret;
+			*val =3D DIV_ROUND_CLOSEST(*val * data->vref, (1 << 16));
+			return 0;
+		case hwmon_in_min:
+			reg =3D ADS71x8_REG_MIN_CH0_LSB + (2 * channel);
+			return ads71x8_read_input_mv(data, reg, val);
+		case hwmon_in_max:
+			reg =3D ADS71x8_REG_MAX_CH0_LSB + (2 * channel);
+			return ads71x8_read_input_mv(data, reg, val);
+		case hwmon_in_min_alarm:
+			reg =3D ADS71x8_REG_LOW_TH_CH0 - 1 + (4 * channel);
+			return ads71x8_read_input_mv(data, reg, val);
+		case hwmon_in_max_alarm:
+			reg =3D ADS71x8_REG_HIGH_TH_CH0 - 1 + (4 * channel);
+			return ads71x8_read_input_mv(data, reg, val);
+		default:
+			return -EOPNOTSUPP;
+		}
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static u32 get_closest_log2(u32 val)
+{
+	u32 down =3D ilog2(val);
+	u32 up =3D ilog2(roundup_pow_of_two(val));
+
+	return (val - (1 << down) < (1 << up) - val) ? down : up;
+}
+
+static int ads71x8_write(struct device *dev, enum hwmon_sensor_types type,
+	u32 attr, int channel, long val)
+{
+	struct ads71x8_data *data =3D dev_get_drvdata(dev);
+	u8 reg, values[2];
+	int ret;
+
+	switch (type) {
+	case hwmon_chip:
+		switch (attr) {
+		case hwmon_chip_samples:
+			/* Number of samples can only be a power of 2 */
+			values[0] =3D get_closest_log2(clamp_val(val, 1, 128));
+			ret =3D ads71x8_i2c_write(data->client,
+				ADS71x8_REG_OSR_CFG, values[0]);
+			return ret < 0 ? ret : 0;
+		default:
+			return -EOPNOTSUPP;
+		}
+
+	case hwmon_in:
+		switch (attr) {
+		case hwmon_in_min_alarm:
+			reg =3D ADS71x8_REG_LOW_TH_CH0 - 1 + (4 * channel);
+			val =3D DIV_ROUND_CLOSEST(val * (1 << 16), data->vref);
+			val =3D clamp_val(val, 0, 65535);
+			values[0] =3D (val & 0xF0);
+			values[1] =3D (val >> 8) & 0xFF;
+			ret =3D ads71x8_i2c_write_block(data->client, reg,
+				values, ARRAY_SIZE(values));
+			return ret < 0 ? ret : 0;
+		case hwmon_in_max_alarm:
+			reg =3D ADS71x8_REG_HIGH_TH_CH0 - 1 + (4 * channel);
+			val =3D DIV_ROUND_CLOSEST(val * (1 << 16), data->vref);
+			val =3D clamp_val(val, 0, 65535);
+			values[0] =3D (val & 0xF0);
+			values[1] =3D (val >> 8) & 0xFF;
+			ret =3D ads71x8_i2c_write_block(data->client, reg,
+				values, ARRAY_SIZE(values));
+			return ret < 0 ? ret : 0;
+		default:
+			return -EOPNOTSUPP;
+		}
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static umode_t ads71x8_is_visible(const void *_data,
+	enum hwmon_sensor_types type, u32 attr, int channel)
+{
+	u8 mode =3D ((struct ads71x8_data *)_data)->mode;
+
+	switch (type) {
+	case hwmon_chip:
+		switch (attr) {
+		case hwmon_chip_samples:
+			return 0644;
+		case hwmon_chip_update_interval:
+			return mode >=3D ADS71x8_MODE_AUTO ? 0444 : 0;
+		case hwmon_chip_alarms:
+			return mode >=3D ADS71x8_MODE_AUTO_IRQ ? 0444 : 0;
+		default:
+			return 0;
+		}
+
+	case hwmon_in:
+		switch (attr) {
+		case hwmon_in_input:
+			return 0444;
+		case hwmon_in_min:
+		case hwmon_in_max:
+			return mode >=3D ADS71x8_MODE_AUTO ? 0444 : 0;
+		case hwmon_in_min_alarm:
+		case hwmon_in_max_alarm:
+			return mode >=3D ADS71x8_MODE_AUTO_IRQ ? 0644 : 0;
+		default:
+			return 0;
+		}
+
+	default:
+		return 0;
+	}
+}
+
+static const struct hwmon_channel_info *ads71x8_info[] =3D {
+	HWMON_CHANNEL_INFO(chip,
+		HWMON_C_SAMPLES | HWMON_C_ALARMS | HWMON_C_UPDATE_INTERVAL),
+	HWMON_CHANNEL_INFO(in,
+		HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX | HWMON_I_MIN_ALARM | HWMON_I_=
MAX_ALARM,
+		HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX | HWMON_I_MIN_ALARM | HWMON_I_=
MAX_ALARM,
+		HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX | HWMON_I_MIN_ALARM | HWMON_I_=
MAX_ALARM,
+		HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX | HWMON_I_MIN_ALARM | HWMON_I_=
MAX_ALARM,
+		HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX | HWMON_I_MIN_ALARM | HWMON_I_=
MAX_ALARM,
+		HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX | HWMON_I_MIN_ALARM | HWMON_I_=
MAX_ALARM,
+		HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX | HWMON_I_MIN_ALARM | HWMON_I_=
MAX_ALARM,
+		HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX | HWMON_I_MIN_ALARM | HWMON_I_=
MAX_ALARM),
+	NULL
+};
+
+static const struct hwmon_ops ads71x8_hwmon_ops =3D {
+	.is_visible =3D ads71x8_is_visible,
+	.read =3D ads71x8_read,
+	.write =3D ads71x8_write,
+};
+
+static const struct hwmon_chip_info ads71x8_chip_info =3D {
+	.ops =3D &ads71x8_hwmon_ops,
+	.info =3D ads71x8_info,
+};
+
+static ssize_t ads71x8_cal_show(struct device *dev,
+	struct device_attribute *da, char *buf)
+{
+	struct ads71x8_data *data =3D dev_get_drvdata(dev);
+	int ret;
+
+	ret =3D ads71x8_i2c_read(data->client, ADS71x8_REG_GENERAL_CFG);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "%d\n", (ret & 0x02));
+}
+
+static ssize_t ads71x8_cal_store(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct ads71x8_data *data =3D dev_get_drvdata(dev);
+	int ret;
+	long val;
+
+	ret =3D kstrtol(buf, 10, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val =3D=3D 0)
+		return count;
+
+	ret =3D ads71x8_i2c_set_bit(data->client, ADS71x8_REG_GENERAL_CFG, 0x02);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR_RW(calibrate, ads71x8_cal, 0);
+
+static struct attribute *ads71x8_attrs[] =3D {
+	&sensor_dev_attr_calibrate.dev_attr.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(ads71x8);
+
+static const struct ads71x8_val_map *get_closest_interval(u16 freq)
+{
+	const int idx_max =3D ARRAY_SIZE(ads71x8_intervals_us) - 1;
+	u16 cur, best =3D ads71x8_intervals_us[idx_max].val;
+	int i;
+
+	freq =3D clamp_val(freq, ads71x8_intervals_us[0].val,
+		ads71x8_intervals_us[idx_max].val);
+
+	for (i =3D 0; i <=3D idx_max; i++) {
+		cur =3D abs(ads71x8_intervals_us[i].val - freq);
+		if (cur > best)
+			return &ads71x8_intervals_us[i-1];
+		best =3D cur;
+	}
+	return &ads71x8_intervals_us[0];
+}
+
+static irqreturn_t ads71x8_irq_handler(int irq, void *_data)
+{
+	struct ads71x8_data *data =3D _data;
+	struct device *dev =3D &data->client->dev;
+	int ret;
+
+	ret =3D ads71x8_i2c_read(data->client, ADS71x8_REG_EVENT_FLAG);
+	if (ret <=3D 0)
+		return IRQ_NONE;
+
+	ret =3D ads71x8_i2c_read(data->client, ADS71x8_REG_EVENT_HIGH_FLAG);
+	if (ret < 0)
+		goto out;
+	data->alarms |=3D (ret << 8);
+
+	ret =3D ads71x8_i2c_read(data->client, ADS71x8_REG_EVENT_LOW_FLAG);
+	if (ret < 0)
+		goto out;
+	data->alarms |=3D (ret);
+
+	/* Clear all interrupt flags, so next interrupt can be captured */
+	ret =3D ads71x8_i2c_write(data->client, ADS71x8_REG_EVENT_HIGH_FLAG, 0xFF=
);
+	if (ret < 0)
+		goto out;
+	ret =3D ads71x8_i2c_write(data->client, ADS71x8_REG_EVENT_LOW_FLAG, 0xFF)=
;
+	if (ret < 0)
+		goto out;
+
+	/* Notify poll/select in userspace. CONFIG_SYSFS must be set! */
+	sysfs_notify(&data->hwmon_dev->kobj, NULL, "alarms");
+	kobject_uevent(&data->hwmon_dev->kobj, KOBJ_CHANGE);
+
+out:
+	if (ret < 0)
+		dev_warn(dev, "couldn't handle interrupt correctly: %d\n", ret);
+	return IRQ_HANDLED;
+}
+
+static int ads71x8_probe(struct i2c_client *client)
+{
+	struct device *dev =3D &client->dev;
+	struct ads71x8_data *data;
+	struct device *hwmon_dev;
+	struct regulator *regulator;
+	const struct ads71x8_val_map *interval =3D ads71x8_intervals_us;
+	int vref, ret, err =3D 0;
+
+	data =3D devm_kzalloc(dev, sizeof(struct ads71x8_data), GFP_KERNEL);
+	if (!data) {
+		err =3D -ENOMEM;
+		goto out;
+	}
+
+	data->client =3D client;
+	data->id =3D i2c_match_id(ads71x8_device_ids, client);
+	i2c_set_clientdata(client, data);
+	mutex_init(&data->lock);
+
+	/* Reset the chip to get a defined starting configuration */
+	ret =3D ads71x8_i2c_write(data->client, ADS71x8_REG_GENERAL_CFG, 0x01);
+	if (ret < 0) {
+		dev_err(dev, "failed to reset\n");
+		err =3D ret;
+		goto cleanup_mutex;
+	}
+
+	/* Get AVDD (in mv) which is the analog supply and reference voltage */
+	regulator =3D devm_regulator_get(dev, "avdd");
+	if (IS_ERR(regulator)) {
+		err =3D PTR_ERR(regulator);
+		goto cleanup_mutex;
+	}
+
+	vref =3D regulator_get_voltage(regulator);
+	data->vref =3D DIV_ROUND_CLOSEST(vref, 1000);
+	if (data->vref < ADS71x8_AVDD_MV_MIN || data->vref > ADS71x8_AVDD_MV_MAX)=
 {
+		dev_err(dev, "invalid value for AVDD %d\n", data->vref);
+		err =3D -EINVAL;
+		goto cleanup_mutex;
+	}
+
+	/*
+	 * Try reading optional parameter 'ti,mode', otherwise keep current
+	 * mode, which is manual mode.
+	 */
+	if (of_property_read_u8(dev->of_node, "ti,mode", &data->mode) =3D=3D 0) {
+		if (data->mode >=3D ADS71x8_MODE_MAX) {
+			dev_err(dev, "invalid operation mode %d\n", data->mode);
+			err =3D -EINVAL;
+			goto cleanup_mutex;
+		}
+	}
+
+	if (data->mode <=3D ADS71x8_MODE_MANUAL)
+		goto conf_manual;
+
+	/* Try reading optional parameter 'ti,interval' */
+	if (of_property_read_u16(dev->of_node, "ti,interval", &data->interval_us)=
 =3D=3D 0)
+		interval =3D get_closest_interval(data->interval_us);
+	data->interval_us =3D interval->val;
+
+	/* Check if interrupt is also configured */
+	if (!client->irq) {
+		dev_warn(dev, "interrupt not available, intended?\n");
+		goto conf_auto;
+	}
+
+	data->mode =3D ADS71x8_MODE_AUTO_IRQ;
+	ret =3D devm_request_threaded_irq(&client->dev, client->irq,
+		NULL, ads71x8_irq_handler,
+		IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED,
+		NULL, data);
+	if (ret) {
+		dev_err(dev, "unable to request IRQ %d\n", client->irq);
+		err =3D ret;
+		goto cleanup_mutex;
+	}
+
+	/* Enable possibility to trigger an alert/interrupt for all channels */
+	ret =3D ads71x8_i2c_write(data->client, ADS71x8_REG_ALERT_CH_SEL, 0xFF);
+	if (ret < 0) {
+		err =3D ret;
+		goto cleanup_config;
+	}
+
+conf_auto:
+	/* Set to autonomous conversion and update interval */
+	ret =3D ads71x8_i2c_write(data->client, ADS71x8_REG_OPMODE_CFG,
+		0b00100000 | (interval->bits & 0x1F));
+	if (ret < 0) {
+		err =3D ret;
+		goto cleanup_config;
+	}
+
+	/* Enable statistics and digital window comparator */
+	ret =3D ads71x8_i2c_write(data->client, ADS71x8_REG_GENERAL_CFG,
+		0b00110000);
+	if (ret < 0) {
+		err =3D ret;
+		goto cleanup_config;
+	}
+
+	/* Enable all channels for auto sequencing */
+	ret =3D ads71x8_i2c_write(data->client, ADS71x8_REG_AUTO_SEQ_CH_SEL,
+		0xFF);
+	if (ret < 0) {
+		err =3D ret;
+		goto cleanup_config;
+	}
+
+	/* Set auto sequence mode and start sequencing */
+	ret =3D ads71x8_i2c_write(data->client, ADS71x8_REG_SEQUENCE_CFG,
+		0b00010001);
+	if (ret < 0) {
+		err =3D ret;
+		goto cleanup_config;
+	}
+
+conf_manual:
+	hwmon_dev =3D devm_hwmon_device_register_with_info(dev, client->name,
+		data, &ads71x8_chip_info, ads71x8_groups);
+	if (IS_ERR_OR_NULL(hwmon_dev)) {
+		err =3D PTR_ERR_OR_ZERO(hwmon_dev);
+		goto cleanup_mutex;
+	}
+	data->hwmon_dev =3D hwmon_dev;
+
+	goto out;
+
+cleanup_config:
+	dev_err(dev, "failed to configure IC: %d\n", err);
+cleanup_mutex:
+	mutex_destroy(&data->lock);
+out:
+	return err;
+}
+
+static void ads71x8_remove(struct i2c_client *client)
+{
+	struct ads71x8_data *data =3D i2c_get_clientdata(client);
+
+	/* Reset the chip */
+	if (ads71x8_i2c_write(data->client, ADS71x8_REG_GENERAL_CFG, 0x01) < 0)
+		dev_err(&client->dev, "failed to reset\n");
+
+	mutex_destroy(&data->lock);
+}
+
+static struct i2c_driver ads71x8_driver =3D {
+	.driver =3D {
+		.name =3D MODULE_NAME,
+		.of_match_table =3D of_match_ptr(ads71x8_of_match),
+	},
+	.id_table =3D ads71x8_device_ids,
+	.probe =3D ads71x8_probe,
+	.remove =3D ads71x8_remove,
+};
+/* Cares about module_init and _exit */
+module_i2c_driver(ads71x8_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Tobias Sperling <tobias.sperling@softing.com>");
+MODULE_DESCRIPTION("Driver for TI ADS71x8 ADCs");
--=20
2.39.2


