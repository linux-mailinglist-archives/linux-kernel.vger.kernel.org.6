Return-Path: <linux-kernel+bounces-193876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C55A8D3386
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A081F28711
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAE016F0D1;
	Wed, 29 May 2024 09:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="JLZy5vcV"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2085.outbound.protection.outlook.com [40.107.13.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D0716E89B;
	Wed, 29 May 2024 09:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976076; cv=fail; b=USAc/CEmfmtRhh2hftdr4V/0zDAzjHsTzFFt1m5dW//FTZsywMIf67jKw0RhY65h+CjFGtKx5bUuLKGkFgJraUYmaCqwSlfwe925okV3w7YQzSHpanPuoiQotyyON1i1+tgxykPtbO1+CKvf7gBdZns6iJ9rTtLGuLW7+frmYrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976076; c=relaxed/simple;
	bh=KPWu1TWHkt0rKiViYB8JKDO/5UTs051XhH3aPPWbMrs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BrrjQONPXsieuR6YKgbvTZDTLd4kmDV3Rgbg+ysBLSpVWN8CNS76oM65aIpnnhR+movHtriDQmGMdzZDE/rs05M4vzbHcIcg8dNbrqlQX/g2Mirm8K/eRRaXxDNDUSzF1cyGXGgOZr1gnhaxF3M7dpxIyUf8G+9vMORMUy3VR50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=JLZy5vcV; arc=fail smtp.client-ip=40.107.13.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEPM/Ix0IrYNxZWJ/QernNEqLRPFM/WdQK92H6aAuOvLTbbsR4cKRoO0MtTBY9VpnYgSXbouX5POkyXCa+R6pnNuY/s7qVdJ5SbvS8lwdVstSfBCycwK+xETe9mMkzG2k3dLrqi06lFVwniM0P3X3X3XqLXd8ApUbJsjbnPrPcS+3QA64n/NKjRhTL6DNR9AxI5JSvsviVbmj5VtEQR78Tlpspnz16ZFnze067HFSHG3kGMza+lf9MPgNH/FQc3xzv/CZ2hD8UfBg1m7k4rQrTuWebb5CLgf+2l4/2ZDGpFgpxkIZCBoql9Bzgv/M8clLvUj5CqhNwCipOEx+aQ0Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrLpnh9+fkESpl7UMWXjl6VDbeYtSTYo1enDU0wBgcc=;
 b=Xwaj4TtF46+59wEY0l2RbALSvFNVvoiEj4zzqwwyamKSyt5/c2aku1zql5mlK6s9/GUhLA+/MpPKEinOSuIV5glvAJwdisJRY6fJrKt/d0zue1bxeBJa5Q53iU3Vu/YELK1y0K2LurCpzHfgEFaYUZ6WFp8auv8p+pBconaLVLnyUvE404ExqaSOb0TZPP27QAEUIzxq6jfKHjWJpsIBsR/cdbRizR+ZWds5KOjomftivsEnfth7wST8oojOURjO5+noXZaD/hZNhywmNC46upztQCNZMCf9b0XdqT9oL3VoKfJbvMWUcLtXu2lC3tbJ02MIjfNU6IgQBXhoc/7t6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrLpnh9+fkESpl7UMWXjl6VDbeYtSTYo1enDU0wBgcc=;
 b=JLZy5vcVhrQaMe0c0n2R50vmS3ieR6PUmY1a8kdl/jY/7MZA6xH4k2QRAbwhKjDanbIQqo/k8MuJaXfIsMUBanD9zL3XxVsrzC9NZ3i+qa58jsU/AaziiqFmUro8hDAUqL1rQd4pS1MJLGKplYNz+uzBzRiayghFtlBq0WvYW4c=
Received: from AS4P250CA0003.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5df::19)
 by PA4PR02MB6702.eurprd02.prod.outlook.com (2603:10a6:102:fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Wed, 29 May
 2024 09:47:51 +0000
Received: from AM4PEPF00027A5D.eurprd04.prod.outlook.com
 (2603:10a6:20b:5df:cafe::e2) by AS4P250CA0003.outlook.office365.com
 (2603:10a6:20b:5df::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19 via Frontend
 Transport; Wed, 29 May 2024 09:47:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A5D.mail.protection.outlook.com (10.167.16.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 29 May 2024 09:47:50 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 29 May
 2024 11:47:50 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 29 May 2024 11:47:50 +0200
Received: from lnxamnaw.se.axis.com (unknown [10.92.129.190])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 682E02243;
	Wed, 29 May 2024 11:47:50 +0200 (CEST)
Received: by lnxamnaw.se.axis.com (Postfix, from userid 12778)
	id 638AD2069D6; Wed, 29 May 2024 11:47:45 +0200 (CEST)
From: Amna Waseem <Amna.Waseem@axis.com>
Date: Wed, 29 May 2024 11:47:45 +0200
Subject: [PATCH v2 2/2] hwmon: (ina2xx) Add device tree support to pass
 alert polarity
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240529-apol-ina2xx-fix-v2-2-ee2d76142de2@axis.com>
References: <20240529-apol-ina2xx-fix-v2-0-ee2d76142de2@axis.com>
In-Reply-To: <20240529-apol-ina2xx-fix-v2-0-ee2d76142de2@axis.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, <linux-hwmon@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Amna Waseem
	<Amna.Waseem@axis.com>, <kernel@axis.com>
X-Mailer: b4 0.13.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A5D:EE_|PA4PR02MB6702:EE_
X-MS-Office365-Filtering-Correlation-Id: 62cdfb0d-0253-4518-43d0-08dc7fc467bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|82310400017|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cC9iV091b1dpL1NiS0VhcmdmbUpNRTBySTViOFN3U3d5NjVxcVRodmFGTXJk?=
 =?utf-8?B?ZnJKZVc5UnF2TDJKZDJ1ZWRwZXFQeTFEcU9DMHZZbHJYZUJ1bW9PMHhVb2NV?=
 =?utf-8?B?d2lvT1JZU2haSWgwM3h4UXc4elEvd0JmaytRY0w2NmRZZjh5Q0xmaml5VjIw?=
 =?utf-8?B?TlI3ZGYrQzVuUVJzZEdPS2dYbnZCWFhiSUp4YmlCb2xvNE8wUTF1N2Rjdlhn?=
 =?utf-8?B?T1pIWGJHMzBtaG5WY2JpSEkvWEpTNHpHTUVTenR1MnZlY0pzcmp1ZG5WSFh4?=
 =?utf-8?B?ZFFXQU12ci9sV0R0RE1wRFNvRmZhR0RBQlhreVdDNUlTNHZsWDhSL1lENzVi?=
 =?utf-8?B?R1QrOWlLQStTcHNPQ1hQZHlidzA5MkRoS0h4cm9Ed1JhMFRJZURUVnpXVm5R?=
 =?utf-8?B?ZXY1Tm04ZkFLT2JnZHJKRHQvZk1vU0JFL3V1bXB1UTNaNTQxdys4YnFSR2U5?=
 =?utf-8?B?WTFNY0tvdWYxU1drNmp1YjA5YlpVbWZPVGI1aVRodGlFU2FWWFBKeGRLMGxW?=
 =?utf-8?B?TWJLcENMNU5qZHlVN0o2eFpZd3hsbll0Rnpzc25FNWFqcW8yaFRkbkw4YWNV?=
 =?utf-8?B?elhTUzJrR1NCQmtnT1FpSzd0Vm9YbDV5WkQwQTNCbklaelI4c2VwSHZhbkJk?=
 =?utf-8?B?Q25Eb2R4N2FaLzMyY29pdXFMS1VReVdkWGJQbUk4Um9FRDFHNVZCS3J4ckJw?=
 =?utf-8?B?ZmlTeDFnRlo1K2VSTVd1NFFBY0xRQmduVTRrOXZmZUxJVGh5ZFZic09aYVNZ?=
 =?utf-8?B?SldwN0hBYXJQUWh1dzlBZEh6NldGcVE2UHhCVkRvckRSWXhLem9FWWtIMmNx?=
 =?utf-8?B?MThVcGJjYmZrNEZPKzhXYmh3MUU2KzJQRFhIYXJQU2dtOWZDV0w4eXF1UE82?=
 =?utf-8?B?cHgyZG1CRkVaamJsSU9TTVJUTnlwbG95d3lXS1loK2diTkNqZE90dCt3YUg3?=
 =?utf-8?B?MHg1M1UybUw3MGgrWlRxUnBlMkl0WktoTEg3Ulh1czVic1N0c2N5MDlHL3JE?=
 =?utf-8?B?bUVoWXpsQkkvcityeE0wNXptc3Z2RFpOL0FNT3VZakhoaUYyZ3NFOExEdExx?=
 =?utf-8?B?SEVQaDU5dGliRUxCa201TTlxV2NCWTEzSUdrV3hzaXF6NDhXVmRsSytrK3M4?=
 =?utf-8?B?Nlg1czJzVUI2K2kwZjJhb0R2WDdWdzdsN0pnQndNemN4SjRkSFhOajFKK2Np?=
 =?utf-8?B?bExVc0JrOXMwTE54SDJpSTZvTjZYUkdKZGNjSHliOHVQWFlmOVVDUjI1MjN0?=
 =?utf-8?B?VmlZMU1tWHM5cHV4bGJ1QW4vTzBEd3d0UHd3U2o0YmUwVWhaemtadzR3Mmdq?=
 =?utf-8?B?d3BEMmhZQzVwT21PdkhHOHpBdFplSStseFhqTzI0QzhiVFQxVmowVnBlNGw4?=
 =?utf-8?B?a2lzMTJyMStKUkRVNFF4Z29oaXViT24xcFFwTGo3S3N6NUZpcWhKOHF1cW5L?=
 =?utf-8?B?T1BiRG51YkZDMGFTYW5HMUVDZVZPK3hEakFsOThYV2g2QkNpcEZZcU1aK3M3?=
 =?utf-8?B?UHgrNWRKeTh3NVVrMitPQkc2L1YwSFJjakVlbHRWNkZmbXZjcmdPZHpkcUNv?=
 =?utf-8?B?QUJqWXNiY0dZMGQwVTlOQm4zYmt0ME9vRndzclNiZmQwcnI4VS83RWZTeVpt?=
 =?utf-8?B?bUdwL1ZBNnVwdlFibW12NEN5eE5nSlBuTG9sL3JBaUQ0Q0tibDNXS3BPRFJU?=
 =?utf-8?B?YVhKdjcyVmlsWFhqdC9WakVKcUQ1OVlwMXlMSWxzOWRQOVloVUpoMFRkWFhT?=
 =?utf-8?B?NmRjTW5UdHU3NnZtUk5ZWnp3Z0Z3czU2Wms1VTBmSmh6eDM3Y0NuWjJmTG5F?=
 =?utf-8?Q?vqsFn6nYB+KlsaRP9CooY/a3dKMZPPCjzeGZ0=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400017)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 09:47:50.9539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62cdfb0d-0253-4518-43d0-08dc7fc467bc
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB6702

The INA230 has an Alert pin which is asserted when the alert
function selected in the Mask/Enable register exceeds the
value programmed into the Alert Limit register. Assertion is based
on the Alert Polarity Bit (APOL, bit 1 of the Mask/Enable register).
It is default set to value 0 i.e Normal (active-low open collector).
However, hardware can be designed in such a way that expects Alert pin
to become active high if a user-defined threshold in Alert limit
register has been exceeded. This patch adds a way to pass alert polarity
value to the driver via device tree.

Signed-off-by: Amna Waseem <Amna.Waseem@axis.com>
---
 drivers/hwmon/ina2xx.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index d8415d1f21fc..9afaabdc367d 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -73,6 +73,9 @@
 #define INA226_READ_AVG(reg)		(((reg) & INA226_AVG_RD_MASK) >> 9)
 #define INA226_SHIFT_AVG(val)		((val) << 9)
 
+#define INA226_ALERT_POLARITY_MASK		0x0002
+#define INA226_SHIFT_ALERT_POLARITY(val)	((val) << 1)
+
 /* bit number of alert functions in Mask/Enable Register */
 #define INA226_SHUNT_OVER_VOLTAGE_BIT	15
 #define INA226_SHUNT_UNDER_VOLTAGE_BIT	14
@@ -178,6 +181,21 @@ static u16 ina226_interval_to_reg(int interval)
 	return INA226_SHIFT_AVG(avg_bits);
 }
 
+static int ina2xx_set_alert_polarity(struct ina2xx_data *data,
+				     unsigned long val)
+{
+	int ret;
+
+	if (val > INT_MAX || !(val == 0 || val == 1))
+		return -EINVAL;
+
+	ret = regmap_update_bits(data->regmap, INA226_MASK_ENABLE,
+				 INA226_ALERT_POLARITY_MASK,
+				 INA226_SHIFT_ALERT_POLARITY(val));
+
+	return ret;
+}
+
 /*
  * Calibration register is set to the best value, which eliminates
  * truncation errors on calculating current register in hardware.
@@ -659,6 +677,15 @@ static int ina2xx_probe(struct i2c_client *client)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to enable vs regulator\n");
 
+	if (!of_property_read_u32(dev->of_node, "ti,alert-polarity", &val)) {
+		ret = ina2xx_set_alert_polarity(data, val);
+		if (ret < 0) {
+			return dev_err_probe(
+			   dev, ret,
+			   "failed to set APOL bit of Enable/Mask register\n");
+		}
+	}
+
 	ret = ina2xx_init(data);
 	if (ret < 0) {
 		dev_err(dev, "error configuring the device: %d\n", ret);

-- 
2.30.2


