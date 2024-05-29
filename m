Return-Path: <linux-kernel+bounces-193488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC888D2CEC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A5FB1F26579
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 06:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517DE15EFCA;
	Wed, 29 May 2024 06:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="GDZjUMjg"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C556415D5A1;
	Wed, 29 May 2024 06:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716962843; cv=fail; b=a29pnIBNL+jADZT608rJ+KBdtRm5fp45En1ykhKhlxJVn2tR/zc4wP+D0JPLhyNbc+kdHUWefs8l1ho2KJqQctWr6Wzj8kDlgayLz60y8MRijf3puXZhRyKI66Yv1mKkXbIx75vgbM32x7HlnmLR0sHkbubZwnqXIg/B6cWcGHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716962843; c=relaxed/simple;
	bh=c3nY3mwN6jz4DqaJfWXUWcUNXcqKlAoSOA28e751IVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=n7o0+Q6OTPvJBkpsnvM0RGg2b6cPJTRr5jwAnCAnT1Wdv9r0kNW0klntrgPWiCgWL/SZQfUFSChir0X6QqmfB3ZjtdXW9J9ENcqugAamjcWoxAFzOq1K5liFuEuD8n8/zqkZBHDAe3WEpqNPU3H/lf2tG++lJq3E5Vi1zGj8oA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=GDZjUMjg; arc=fail smtp.client-ip=40.107.20.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8h4xhd9tptq115iRyDB5SWm+rMhI+VwsmdEz7E5ki+p0K5lHGfom8zh4sHxwueDcesgK6OWNQRGUe34CaW+gcQ6/Ukw6cP6BW7oXK/t+mukbGmYLTMKekY0jj/XV6fhU3m6yqiVL4ygwD8D1nU/61+0FVs+08O398AAueLJMl4mhkv7hdCmIcGpWyg28rvWbiTTFjMv2w4aunIvy/631oVPeDD94Zcb3pKPZ1aF5FTMUKMpAUEJWR8x6iFoUG1vVoDYCW4TShBZZpamj3CjJCsUbTLO+KolFLHPnOKIN0zxJXXBDBTkjhWgN+Ixo42VaVZLFLd2gd2CatmGAtaldA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2IxADBIWTdmK6FdzFFyOSBMwe6IlF0rxniiTKDwA5M=;
 b=mJsJAeNeVGMmxIgYJAy+m6VCj6fubzNLQEf160TSP3IZYxv07rZbxO1vpuTarb2XBYHIOFt5Mum560OH09raX7pxpw3AZ7OhDlWfHlwgBLJ2N9b13qs7U7WQH2QCTjjIJ7bCTCW6llBD5umArqXNy5PcIueOTKHQqm5c4AQFWJPkHbKf9da216RnFGnwuS8PFXb72Xhlfn1gkD9iLuiBz+0Jg7epavEsndAshKC3q/yATlwTOx+dSzH3eJPKLg/C1rF7isl5Hx2aAKL472rIALlazyR7/0vJ4YJP4n0egFMnGD4pNW+kCCGR2fDps9zt+g1i6ErYY7vxWKcaG52SjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2IxADBIWTdmK6FdzFFyOSBMwe6IlF0rxniiTKDwA5M=;
 b=GDZjUMjgVZrCWYfatPNtPcBegkaMkG19FAwlvvNN5orNTWlKr18YrFY9oAGTyNY2bZ8J+3qLHh8dqemtaIiQ/ON2+OlLWZT6k8w4Oj+fp8ysK60nJ9vjT2OkD0/zepNks3wxOhWvwDqfxdMZHG9w8KzYioEhinyy2vA/RtF6BXU=
Received: from AS9PR04CA0115.eurprd04.prod.outlook.com (2603:10a6:20b:531::25)
 by AS8PR02MB9233.eurprd02.prod.outlook.com (2603:10a6:20b:5b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.34; Wed, 29 May
 2024 06:07:18 +0000
Received: from AMS0EPF000001A9.eurprd05.prod.outlook.com
 (2603:10a6:20b:531:cafe::d9) by AS9PR04CA0115.outlook.office365.com
 (2603:10a6:20b:531::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Wed, 29 May 2024 06:07:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001A9.mail.protection.outlook.com (10.167.16.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 29 May 2024 06:07:18 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 29 May
 2024 08:07:17 +0200
Received: from se-mail02w.axis.com (10.20.40.8) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 May
 2024 08:07:17 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 29 May 2024 08:07:17 +0200
Received: from lnxamnaw.se.axis.com (unknown [10.92.129.190])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 26EC41E15;
	Wed, 29 May 2024 08:07:17 +0200 (CEST)
Received: by lnxamnaw.se.axis.com (Postfix, from userid 12778)
	id 23A04206972; Wed, 29 May 2024 08:07:17 +0200 (CEST)
From: Amna Waseem <Amna.Waseem@axis.com>
Date: Wed, 29 May 2024 08:07:15 +0200
Subject: [PATCH 2/2] hwmon: (ina2xx) Add device tree support to pass alert
 polarity
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240529-apol-ina2xx-fix-v1-2-77b4b382190f@axis.com>
References: <20240529-apol-ina2xx-fix-v1-0-77b4b382190f@axis.com>
In-Reply-To: <20240529-apol-ina2xx-fix-v1-0-77b4b382190f@axis.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, <linux-hwmon@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Amna Waseem
	<Amna.Waseem@axis.com>, <kernel@axis.com>
X-Mailer: b4 0.13.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A9:EE_|AS8PR02MB9233:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f70a1e7-396a-48a7-3360-08dc7fa59888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2tYVCtZbms1UHROL3JORjEzSDkwYWpCdVZya1VkZmZlSFJRd24vZ216WnAz?=
 =?utf-8?B?VmxnSmZ4VWdxZEtEU1I0RkNmYjZXR0JqMjNEMThmU0JFVEJxQjFjbmJzdXk2?=
 =?utf-8?B?L3p5a2RLRDJyWlM1ZlEyenVxYWFVbmpkTnRrTkVQYXMxQmtxT0pkN0FoT21u?=
 =?utf-8?B?NU5NT3pIUzRBWjduMnVjTVErV1JMNEVHbmE4RmlPRzZBUFRMczhlSUU2YUE3?=
 =?utf-8?B?M3MzeWxSa1pORFBBV0k3ZnoxbUo4aTBDTGVQQVJHeFVGN2UrUEw2MmpWMUp4?=
 =?utf-8?B?MElrVmJmaDBLekRDbEVYa2xVQUlzNllqc2s3azB1cFZyYkNoK29KVkhZQk5h?=
 =?utf-8?B?amhXamd3bDZhMGdQb3gyMlFzZ0gyMnJoUFp4TlJsRk1uNHYwdkUxWVQwOVZm?=
 =?utf-8?B?c2RTbjJNQ080TGx3cG5MQXFKNXlZdG1DN2Y2b09FSGpHclV3SkZ5ZmtnNmV3?=
 =?utf-8?B?NEN0Y3ZjMTFnTmhuNFRwUElyRDNnd0N6dzFUYmFPWHVuR3ZaNUVDcDJsSStQ?=
 =?utf-8?B?RUhyQ1pab2RaWHJ4OGRhT0wyQm56ZGFVbGx4QUdGK1JBU3c4N0xmLzNlWWJ6?=
 =?utf-8?B?K1VVV1pCK2c4SDZ4SjJoRVVRcktFdVMyWlBjQXgwYjB6RjExWWk1MFZjTTlI?=
 =?utf-8?B?KzlOSnRNbmlmbE9NaUZxa09uNzhHWUw2UUplaGNHZk90Tk5FWVVsYlp2YjEv?=
 =?utf-8?B?TUtlaStFRU9naGNjRWpuQWlibjVtZlBudUNXck8rKzIxS2VtZituYVlmcU43?=
 =?utf-8?B?V0cxNmxmTjFKVU92b0hFZXhNbnF3NEhidkNVbGNGdHVLRFNlNmU1K1dCbWRh?=
 =?utf-8?B?VWdEN2JFVE9kaDJXbVU1UTlKbUF3RDErbFpLd0NnRjZrY3BKOU5zOWFMbGhU?=
 =?utf-8?B?L3NQeGVvR2ZjbVdxajRXNEFjeXI4MWpHMEU2SURNZmVHT1k0Vmw4WTJMaTFL?=
 =?utf-8?B?MjlPM1FwM1BBV00zeEIrMkhKUDhwY1JTUjJPVENYODd6dW5Va3VLZnB0bmU5?=
 =?utf-8?B?UUQ2ZzV0N0NTN3gvS01CNkRnZ01nQWcxWXJHNHFuQjFUclYycy9ueVdyTkMz?=
 =?utf-8?B?anhEQUptbUgzWVp4VjBUM0lvcklXY3VpQzVnQzVtc0Z4ZVNIdFErbEJzb21Y?=
 =?utf-8?B?U0Q5UDRCUkh3dTFNSnNaR0RpWmxkUnBJUi9ncW03MUxJVGs0M1d5S3JZZjNZ?=
 =?utf-8?B?Um4wdEo2bDFtRzdGK2xsOXZlbkw3RWYybTM4dHV5UzBVWXdsWWgzNDI0R2NZ?=
 =?utf-8?B?L2htU1M2R0VNZ0gwOFZzaVh3SktmS0ZtZytNWll1M1JIM0NON0VGR3pYYm1L?=
 =?utf-8?B?eGFQY2dTQzFjN0lRc3ZUYTd0eWMyVFZSK0lqYWZudXdwWmVnZTNpcXVoT3Bo?=
 =?utf-8?B?QlExeXRSRTcwTXVKRkFsNWQ0SEFEUEZoUkpaaCtpSFNYeHZualFHQ3ZDU21i?=
 =?utf-8?B?NmJFVXZrTURnc09CNVdrU2lYOUcxb0w0d094OVJUOEpudGVTQUVJaEJlNmhC?=
 =?utf-8?B?UVE0YUR2cTZWSGtxOGRwQTUzMXdDSnFtZE9Vdk1pN2tIcHM4MCs0RDhqK08v?=
 =?utf-8?B?Q2UrMnh4OVlPZXpNeWNjWHZGVUxTSnhBNW03ZWdKdjVBYnpvWWdlRjMzd0tG?=
 =?utf-8?B?QmNGK2NtK3NSNGtTMkV6OGxKQUFzam5CKy9jaTB1MGVTd01CNXNvV3NHTS9Y?=
 =?utf-8?B?WHF0NTd0T3hwc25WbW1FT01McitXbko2c083azB6Z3Jsanh1NmNDMHBueUN1?=
 =?utf-8?B?dlR1NUtlaWFIdGF2Smc1a3V2ek9nc2NyUnptVHFWZlVaYmxQZGU3TE9uMDdS?=
 =?utf-8?Q?NfJJMcq6nGSAf94NT7QkBtHybcVZMwCa15VuI=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 06:07:18.4693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f70a1e7-396a-48a7-3360-08dc7fa59888
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A9.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9233

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
 drivers/hwmon/ina2xx.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index d8415d1f21fc..b58e795bdc8f 100644
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
@@ -178,6 +181,23 @@ static u16 ina226_interval_to_reg(int interval)
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
+	mutex_lock(&data->config_lock);
+	ret = regmap_update_bits(data->regmap, INA226_MASK_ENABLE,
+				 INA226_ALERT_POLARITY_MASK,
+				 INA226_SHIFT_ALERT_POLARITY(val));
+
+	mutex_unlock(&data->config_lock);
+	return ret;
+}
+
 /*
  * Calibration register is set to the best value, which eliminates
  * truncation errors on calculating current register in hardware.
@@ -659,6 +679,14 @@ static int ina2xx_probe(struct i2c_client *client)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to enable vs regulator\n");
 
+	if (!of_property_read_u32(dev->of_node, "alert-polarity", &val)) {
+		ret = ina2xx_set_alert_polarity(data, val);
+		if (ret < 0)
+			return dev_err_probe(
+				dev, ret,
+				"failed to set APOL bit of Enable/Mask register\n");
+	}
+
 	ret = ina2xx_init(data);
 	if (ret < 0) {
 		dev_err(dev, "error configuring the device: %d\n", ret);

-- 
2.30.2


