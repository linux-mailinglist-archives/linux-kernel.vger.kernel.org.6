Return-Path: <linux-kernel+bounces-308730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9C79660FE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64CB328769D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A533A18F2D5;
	Fri, 30 Aug 2024 11:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b="Ec5+5DmT"
Received: from FR5P281CU006.outbound.protection.outlook.com (mail-germanywestcentralazon11022134.outbound.protection.outlook.com [40.107.149.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C11170A01;
	Fri, 30 Aug 2024 11:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725018601; cv=fail; b=JaHoU96si9Sk4W6dvdbneJ8Iugesbqnvoiklq+TpDsNUblDlnLTanSknpRb52EXGKouOx2n+i0VTNldfFvxqDc8jlrUmEzEUBRgP0VtYl4l6K8VBbVZ5NN0bkot3t/e4qfl8QkH+qJv4XCqOHUGh4UUHU+QqrK78tOou/yjtJnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725018601; c=relaxed/simple;
	bh=mp8KqmPVjYY5HQzruIpwFh6Ey5YjF5BvF/QPV880OVg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=liEuunTiTwVN4tIC85YGd3SAQpv8ceyp42fUfmC3v1B7BK9f6BO1EYeDk3OYTv+z/0kYRUoYIoWCRojoF0dI+lO2gH2/uAJ2ahnChaut/ABOR9fmmTWay2JeEMhajo3JrKUCjhQSMOTnz7Slnexz2kOR/0t3w0HDZq0NF7/95gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Softing.com; spf=pass smtp.mailfrom=Softing.com; dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b=Ec5+5DmT; arc=fail smtp.client-ip=40.107.149.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Softing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Softing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QW3i5nFCoZv3XPUHdUouwAMj+rs+vBjlG3aMnrRjtI5/PTDAjV0FVwO9P65178znL3/8LabmpFWQcWWU2cFcJWfIuf8Zc9H42fzoSmzEoAgdxWMZXGOXREEDgx+qFukOriGVZwiiDD2B62CcQaRonQAJ3EqdxJMaGESLLrz0sOcuFA+PNqKlR2+i4Q7yZcm/5QUAvzUAMYVHdKT9++iAitRCsPDJsdIYeu6Uxw3/CUl+J9TybOI/5XPERQNsAhI+zKwQRVJJidwfK98FQkOvHuqFsVyCUaslE6DcSOqfzDfov+tTwB02h/lVLHWovytbkUiwE1/XYXXGxLcIbVzFbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EemrGTTmrZgaozT/sfY3WA1Qdii7epm7DQ3Rv/82ues=;
 b=uaEA20yKtWwYwJFsCp5X1GEpNSFocGTxOyYyvSwCjS/XEN9xmY5OOG8bOMefV4kxVqCLf/jBLtNoO1lo3Ncp18A4R3sXj+TyRviEe5k1uZ9qD+AWCavj2R1lUnP8hzFEIPxjLXxGNPe5k50xH2Ecw/NyO7UJhVho6kaLjvVpDWCQo1Mkg13UJmX5+vA85ZAGK/N8jyOrI/2C3nLYsNd2ODUVHmnG9nwP4KVjLMr+6hhR8mJbWCZG5+guNnYXlBfYK4lneFhwDSZ7niwRsrNd4q9nmQbGwDZiimhxVrjtl+ZgrJFVxMDYH5o/BA7Nm9qOiGXB1yOx7FC6hMtNaWdfvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softing.com; dmarc=pass action=none header.from=softing.com;
 dkim=pass header.d=softing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=softing.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EemrGTTmrZgaozT/sfY3WA1Qdii7epm7DQ3Rv/82ues=;
 b=Ec5+5DmTaRf+zLSMb7Yiy4STmDmQIpgDNgSYuNjzaAMhyMni4HEXscmoD9N0vYLHMeu4aGgk2kX2gc1Vbtan7CnpJrm39gJtFQkp/DVIoMiIViwTLv7kMdZ8IojMFXCkDZDureGgaR9vUVA5AvKWcu/97I7Rwr7kxpxf9iMZKfEXa/CvUHHUvp+LD1Iz+YYKT17qaBqebT9KEDBwVoNs1tqI3yuI9DrIRRUHZ26tskqykprzb/JdDTGrWCjZa7Lhp1MVM9wIgnu7Lmvr92AUDvuyYcpDyoqMZjjLvyXfupW8WEORmARKmdn5EhcX+59icE8HdwjU3yRqhCX85g5pXg==
Received: from BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::7) by
 FR5P281MB4123.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:106::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.28; Fri, 30 Aug 2024 11:49:53 +0000
Received: from BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8de2:b2ba:4092:939a]) by BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8de2:b2ba:4092:939a%6]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 11:49:53 +0000
From: "Sperling, Tobias" <Tobias.Sperling@Softing.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC: "jdelvare@suse.com" <jdelvare@suse.com>, "linux@roeck-us.net"
	<linux@roeck-us.net>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>, "Sperling, Tobias"
	<Tobias.Sperling@Softing.com>
Subject: [PATCH 1/2] dt-bindings: hwmon: Introduce ADS71x8
Thread-Topic: [PATCH 1/2] dt-bindings: hwmon: Introduce ADS71x8
Thread-Index: Adr60bwOPjoiJD3QTreu2+tBMAOlGg==
Date: Fri, 30 Aug 2024 11:49:53 +0000
Message-ID:
 <BE1P281MB24208CB90AF549578AA5C384EF972@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Softing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB2420:EE_|FR5P281MB4123:EE_
x-ms-office365-filtering-correlation-id: 15995782-8292-4e7d-6e6f-08dcc8e9dc9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?L+02nldvPKSnq0IkiWMVs3e0jh8waoyn5bRs5h0eMeEiWAmka9VbkeD4d3eE?=
 =?us-ascii?Q?KvFJZXnPj+O6LSKvoDPmxXoOKI3QlxME38DAbdb60ZOs+rLrakzSD8ArauEo?=
 =?us-ascii?Q?6SFliBXNQg7C9PSvIkoaQO26ViNl56xLPG0tM4k872KAjoZ9SMUU8ZiBLZMD?=
 =?us-ascii?Q?Br2R/HWNRcL44uUJOUXEsZsHxA5bLNYdKtPTp8iWO+iauZMsqSiUPQ4e25aB?=
 =?us-ascii?Q?GxhutVrGnYM5bNFT4qbko+PTXQXh/Kflwx+To/KM9HGlx4A2EnC72WsfpWVy?=
 =?us-ascii?Q?PfeoRuUujFIgYy+PuwjTRHFOJVu0akBObnCqPQTsanRj+fbaQHeWbpCxj5VM?=
 =?us-ascii?Q?g+CS7wVTs6eP7vwHgybQ5ye80fReX3yUxh3tQ072ElFNzlqDfkSLfJ4TBmmd?=
 =?us-ascii?Q?RWQRCo7OoHHCcEFmyoKYpTLqH7nXc+uXIjrqnaxt3QvTCysJ535hS8iN58k1?=
 =?us-ascii?Q?He7zPg5QDQuNmVEk4KWB+A3almIHqmAfz+4EZCsBT30wjg4j05J0L1/1C4sp?=
 =?us-ascii?Q?uVYoaCRwVEkbbpicy4VV5DVF8sIFEz1ckw35R4f5MmM7UH2dLT++U99z6b/o?=
 =?us-ascii?Q?w6/VkYFu5+k1hdQvH4847ZLZlnjLZeOlA8WNWExFHqEj2HLtBK4mQ7jWnyuF?=
 =?us-ascii?Q?eIZkQVGFfaCDLbknBXD9sifSGXBcLyO91ZvgUpapmpOiiA71QOOY+HneunBM?=
 =?us-ascii?Q?+8PXDmvgIU0S321NZn45jyT6um4/Dnftx2ojgn7BDK3tl/3wVgIFIYBG1c74?=
 =?us-ascii?Q?8BN4I4chjTsjMnlPQ0BmRwJtq/5t+b0oliSDRNFP/yBV771TqOfeJ1AH5eho?=
 =?us-ascii?Q?81LC/BdyZbOgnjDpAQembbqU9qzPgP/PhpZVO1XCWFrXzj9/QBYxv4x8jDym?=
 =?us-ascii?Q?04eQenNpN+T62Erjpv0r+yntHdE6W6ji8G0nQfpY5YBlfKX1aKfZO9fVAeep?=
 =?us-ascii?Q?HuYzuh7din6qoMmQ1xx4FqyZG43RBPge1pKBMUen0L8W8Efg5JrWVjNoEZKc?=
 =?us-ascii?Q?qwbjsCg9pV3wB/OQ2+9f5kf23gzjyzfqzknvs8A9zdrjdzc5G7+fAbUaDY0J?=
 =?us-ascii?Q?+SSuaXcLLZ42m6M+4bbD1+Sqdg5EXGB2xIncrTgzTgupZwP1KIlja10CgHnM?=
 =?us-ascii?Q?WGX1ycsNUq1uIl8P23nThkLObeRMEBDTnHRD9lm1TV9ZMt+15f7NHL5yLz1a?=
 =?us-ascii?Q?vOKdufcp0NnK4+mS8+SnSpoHOocGAFplUt5+5KSR6Acs3gp3r1OTU27Xet2H?=
 =?us-ascii?Q?IXey7sU3FXsu1r6QkykHy9snmAjjFVvwoAdzUSik8NgPYQCbW1+tzj6zpXn1?=
 =?us-ascii?Q?OUq2gEFNKndVow4QDcLYtsKuiqWSz4SYxl63tTNiSQcmQL9yvLCzybY6Y5MJ?=
 =?us-ascii?Q?lXjCV24=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ux8PwsKhNQBdybb2XiSpszwOPVf/A1VFha3Sv+9VeuHsx7S59DxX9DXYufDZ?=
 =?us-ascii?Q?yNlWJ3X1nitHjAgc/J7Ff3Wiz2eKkgqtVWAMq7XbbRsK8e1UkUjTP0jtOR1J?=
 =?us-ascii?Q?XkAnMU8h+gx82zWL4BKoLw/47xpiWaY3/FG9FoO52nynyqw92YsdekBba4d7?=
 =?us-ascii?Q?vDA5iBI1hXVsyZ+OOZ6HO4TD8280t0SRYtKVOULwZgNGdHM2TKse92a7vInk?=
 =?us-ascii?Q?CzsPf/Hfw4oenySxjyT34suzMcrS87Za3ir51PP1RfJcJJ0rjiV7bpVCUsIH?=
 =?us-ascii?Q?HchntIqy8r1aGld1ZY9LMiNjOF6VcVITIGAhetOYEY2VAxun5x4EjJoe8nuj?=
 =?us-ascii?Q?hFe7iinhdXtBm70LDjMhFB3TnUQiklp2fb6rDGfjRrffzUwj4MzAb4P713jd?=
 =?us-ascii?Q?WUHkwYdQQ6Zze6v1+iFiCN/LnVrEHcIuP7ArfQxcQGICmUaa3w/CDN9DS0iW?=
 =?us-ascii?Q?lxtkFxuIf+57ryouDbGvH3KJn8Ieg0VQWxhApwN73aCTBFdy9p1R/UbngolO?=
 =?us-ascii?Q?VDUyHMxtG4+/N1YDQ/EaMp9CaRRaO7fO+l492UUUsS8Z9H9+HTyZP7boWDCg?=
 =?us-ascii?Q?y6BcumRKbwZ7S42XzDcLftNyg+7sYIMiPievFjqQ+Qlr1kaVT82CvkA9NFGv?=
 =?us-ascii?Q?JtEC/ZZIMg8SDesAkfIvZ3W4doGuVHRvKlEo3Co5RSrtexegBKv+gCOjgtGV?=
 =?us-ascii?Q?LKiPIm05bCHQEU/by5s/GsGFuBn1lvnB4MdunZTIVrWv3WuIge0j+FL/V5Qk?=
 =?us-ascii?Q?7B0MpnKaPlPUDOQ2xNBo7O7rSuTZbXaLSZH+A4XTo2fs10usZ56XhzJSOdLi?=
 =?us-ascii?Q?3DPSaZgGsCbRgux8OLlNQYZrVGH9sxYXP4o6b5ogPGCFUqY8C3pePsqYytAg?=
 =?us-ascii?Q?kqHA6OMGpnfNaj6w2UI7MnOusnHGDKWO9jnGfPhTOpgHgpvg4PzNsdipljNS?=
 =?us-ascii?Q?1hqnd1+SE0cYbzfLYW/axNK/ohPAWeNxaj1II7K9L51sl68cCTkh9QDhzInQ?=
 =?us-ascii?Q?HUtjxAOkya0flMtUZYjqENIpcgi/t8mtRQ5lp659FrKnBya4NUX9beBQow/I?=
 =?us-ascii?Q?r8TuozOlKGuoEHhV7jbYyt8dyrAax2qgG733oZw0l1RpTKlh3hKxvYIMaWPu?=
 =?us-ascii?Q?AM1IsGjfNA1GfdPj9qzsnn3V+LOmHfaz1JBADNhARYIAx7ZolkioEHC9bdq0?=
 =?us-ascii?Q?6kiFMA85oPfO0sNceT0J9FtPS+hiN9ILHTehvoLLspEJBvWfp/z7CNYkKaHj?=
 =?us-ascii?Q?b09gFQJQZneWjxtJ6AQSEAnzjwzwzT6nG9rw8740MrXG9VOfE55vXgNWEnnp?=
 =?us-ascii?Q?/iobe4u/N+8Qsc+ivItmJRLJncTrhL4ksQ9lvo24Wvtb1tx4nP6aKTbvtBet?=
 =?us-ascii?Q?fpF6ZnwgZxccog95NFHjdMtwVYgMTODIpqkTTvcUHl01QiugvfZPFL9wpLXX?=
 =?us-ascii?Q?Lv/B9P1C1lN2dG11xSmlHTC5mb3uWFgcQOk6ZH/+Y+Mb0SpOO4xTVpIlXB+y?=
 =?us-ascii?Q?fwdNq/f3UhcrvrpnnTzGnaNICzpDMtc/tPHr3FNtGRzslZ9QgInmjxHgHnMn?=
 =?us-ascii?Q?AKSHr3jyI1f7CKb6pef4zHvg5C9BZ8J0+OlnmvzlS0YbumC04rMVJzK490BS?=
 =?us-ascii?Q?hLy8L5P3tzClHALkxBLIHpDXGn/cIUly8+02gws31VO7CQmG9utZ+yk8i9DH?=
 =?us-ascii?Q?ILvV3g=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 15995782-8292-4e7d-6e6f-08dcc8e9dc9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2024 11:49:53.3571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe3606fa-d397-4238-9997-68dcd7851f64
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /gtlp5yFwp+n9up8BuRBA8p/+xA8ovvcKqQ9OmJfC+1Yk0v2ItfZ1LZ91gAVQuLmXcPLKIsMGvrBw3qUENpdvYhB1n/zrlVAuIld6eYmpCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR5P281MB4123

From b2e04ce5500faf274654be5284be9db4f3abefce Mon Sep 17 00:00:00 2001
From: Tobias Sperling <tobias.sperling@softing.com>
Date: Fri, 23 Aug 2024 12:08:33 +0200
Subject: [PATCH 1/2] dt-bindings: hwmon: Introduce ADS71x8

Add documentation for the driver of ADS7128 and ADS7138 12-bit, 8-channel
analog-to-digital converters. These ADCs have a wide operating range and
a wide feature set. Communication is based on an I2C interface.
The driver provides the functionality of manually reading single channels
or sequentially reading all channels automatically.

Signed-off-by: Tobias Sperling <tobias.sperling@softing.com>
---
 .../devicetree/bindings/hwmon/ti,ads71x8.yaml |  85 +++++++++++
 Documentation/hwmon/ads71x8.rst               | 140 ++++++++++++++++++
 Documentation/hwmon/index.rst                 |   1 +
 3 files changed, 226 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ti,ads71x8.yaml
 create mode 100644 Documentation/hwmon/ads71x8.rst

diff --git a/Documentation/devicetree/bindings/hwmon/ti,ads71x8.yaml b/Docu=
mentation/devicetree/bindings/hwmon/ti,ads71x8.yaml
new file mode 100644
index 000000000000..e422c4ebd207
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ti,ads71x8.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/ti,ads71x8.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments ADS7128/ADS7138 Analog to Digital Converter (ADC)
+
+maintainers:
+  - None
+
+description: |
+  The ADS7128 is 12-Bit, 8-Channel Sampling Analog to Digital Converter (A=
DC)
+  with an I2C interface.
+
+  Datasheets:
+    https://www.ti.com/product/ADS7128
+    https://www.ti.com/product/ADS7138
+
+properties:
+  compatible:
+    enum:
+      - ti,ads7128
+      - ti,ads7138
+
+  reg:
+    maxItems: 1
+
+  avdd-supply:
+    description:
+      The regulator used as analog supply voltage as well as reference vol=
tage.
+
+  ti,mode:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description: |
+      Operation mode
+      Mode 0 - Manual mode. A channel is only sampled when the according i=
nput
+        in the sysfs is read.
+      Mode 1 - Auto mode. All channels are automatically sampled sequentia=
lly.
+        Reading an input returns the last valid sample. In this mode furth=
er
+        features like statistics and interrupts are available.
+    default: 0
+
+  ti,interval:
+    $ref: /schemas/types.yaml#/definitions/uint16
+    description: |
+      Only considered in mode 1!
+      Interval in microseconds a new sample is triggered. Is set to closes=
t
+      possible interval, see datasheet.
+    default: 1
+
+  interrupts:
+    description: |
+      Only considered in mode 1!
+      Interrupt specifier the device's ALERT pin is connected to. Level mu=
st be
+      IRQ_TYPE_LEVEL_LOW. If not configured the digital window comparator =
(DWC)
+      is not available.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - avdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        ads7138@10 {
+            compatible =3D "ti,ads7138";
+            reg =3D <0x10>;
+            avdd-supply =3D <&reg_stb_3v3>;
+            ti,mode =3D /bits/ 8 <1>;
+            ti,interval =3D /bits/ 16 <1000>;
+            interrupt-parent =3D <&gpio2>;
+            interrupts =3D <12 IRQ_TYPE_LEVEL_LOW>;
+            status =3D "okay";
+        };
+    };
diff --git a/Documentation/hwmon/ads71x8.rst b/Documentation/hwmon/ads71x8.=
rst
new file mode 100644
index 000000000000..383669c1f8c5
--- /dev/null
+++ b/Documentation/hwmon/ads71x8.rst
@@ -0,0 +1,140 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Kernel driver ads71x8
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:
+
+  * Texas Instruments ADS7138
+
+	Prefix: 'ads7128'
+
+	Datasheet: Publicly available at the Texas Instruments website:
+	http://focus.ti.com/lit/ds/symlink/ads7128.pdf
+
+  * Texas Instruments ADS7138
+
+	Prefix: 'ads7138'
+
+	Datasheet: Publicly available at the Texas Instruments website:
+	http://focus.ti.com/lit/ds/symlink/ads7138.pdf
+
+Author: Tobias Sperling <tobias.sperling@softing.com>
+	(based on ads7828 by Steve Hardy)
+
+Description
+-----------
+
+This driver implements support for the Texas Instruments ADS7128 and ADS71=
38,
+which are 8-channel 12-bit A/D converters.
+
+The chip requires an external analog supply voltage AVDD which is also use=
d as
+reference voltage. If it is missing or too low, the chip won't show up as =
I2C
+device.
+
+The driver can be run in different modes. In manual mode a new (averaged) =
sample
+is created when the according input is read.
+
+In auto mode all channels are sampled sequentially automatically. Reading =
an
+input returns the last valid sample. In this mode there are also further
+features like statistics and the possibility to trigger an interrupt if a
+voltage drops/raises below/above a specific value (DWC - Digital Window
+Comparator).
+The overall update time (after which all channels are updated) depends on =
the
+number of samples, the update interval and the amount of channels (8).
+
+	update time =3D samples * update_interval * 8
+
+There is no reliable way to identify this chip, so the driver will not sca=
n
+some addresses to try to auto-detect it. That means that you will have to
+statically declare the device in the device tree.
+
+sysfs-Interface
+---------------
+
+The following interfaces are available in all modes.
+
++----------------+----+---------------------------------------------+
+| in[0-7]_input  | ro | Voltage in mV sampled at channel [0-7]      |
++----------------+----+---------------------------------------------+
+| samples        | rw | Number of samples used for averaging 1-128. |
+|                |    | Automatically set to closest power of 2.    |
++----------------+----+---------------------------------------------+
+| calibrate      | rw | Write any value greater than 0 to trigger   |
+|                |    | self-calibration. Reads as 0 if finished.   |
++----------------+----+---------------------------------------------+
+
+If the device is running in auto mode there are also the following interfa=
ces.
+
++------------------+----+-------------------------------------------------=
----+
+| in[0-7]_max      | ro | Maximum value in mV that occurred at channel [0-=
7]  |
++------------------+----+-------------------------------------------------=
----+
+| in[0-7]_min      | ro | Minimal value in mV that occurred at channel [0-=
7]  |
++------------------+----+-------------------------------------------------=
----+
+| update_interval  | ro | Time in microseconds after which the next sample=
 is |
+|                  |    | executed.                                       =
    |
++------------------+----+-------------------------------------------------=
----+
+
+If the device is running in auto mode and the interrupt is configured also=
 the
+following interfaces are added. If CONFIG_SYSFS is set in the kernel
+configuration it is also possible to poll the 'alrarms', see example below=
.
+
++--------------------+----+-----------------------------------------------=
----+
+| alarms             | ro | | Contains the flags of DWC events. Once read =
it  |
+|                    |    |   is reset to 0.                              =
    |
+|                    |    | | BIT0 equals the low event flag of channel 0.=
    |
+|                    |    | | BIT7 equals the low event flag of channel 7.=
    |
+|                    |    | | BIT8 equals the high event flag of channel 0=
.   |
+|                    |    | | BIT15 equals the high event flag of channel =
7.  |
++--------------------+----+-----------------------------------------------=
----+
+| in[0-7]_max_alarm  | rw | Set high threshold in mV of DWC for channel [0=
-7] |
++--------------------+----+-----------------------------------------------=
----+
+| in[0-7]_min_alarm  | rw | Set low threshold in mV of DWC for channel [0-=
7]  |
++--------------------+----+-----------------------------------------------=
----+
+
+Example
+-------
+
+.. code:: c
+
+	#include <stdio.h>
+	#include <stdlib.h>
+	#include <fcntl.h>
+	#include <sys/select.h>
+	#include <unistd.h>
+
+	int main(void)
+	{
+		int		retval, fd;
+		fd_set	exceptfds;
+		char	buf[16];
+
+		fd =3D open("/sys/class/hwmon/hwmon1/alarms", O_RDONLY);
+
+		while (1) {
+
+			FD_ZERO(&exceptfds);
+			FD_SET(fd, &exceptfds);
+
+			/* Must be assigned to 'exceptional conditions'. For poll() use
+				POLLPRI. */
+			retval =3D select(fd + 1, NULL, NULL, &exceptfds, NULL);
+			if (retval =3D=3D -1)
+				perror("select()");
+			else if (retval) {
+				/* Close and reopen is required, since it's a sysfs file */
+				close(fd);
+				fd =3D open("/sys/class/hwmon/hwmon1/alarms", O_RDONLY);
+				retval =3D read(fd, buf, sizeof(buf));
+				printf("Received: %.*s\n", retval,buf);
+			}
+		}
+
+	close(fd);
+	exit(EXIT_SUCCESS);
+	}
+
+Notes
+-----
+
+TODO support for GPIOs, ADC hysteresis and counts is missing yet.
diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 913c11390a45..a54df7af27ea 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -33,6 +33,7 @@ Hardware Monitoring Kernel Drivers
    adm1275
    adm9240
    adp1050
+   ads71x8
    ads7828
    adt7410
    adt7411
--=20
2.39.2


