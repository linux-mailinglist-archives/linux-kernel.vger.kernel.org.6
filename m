Return-Path: <linux-kernel+bounces-209581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 585CB9037F8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B67EBB258F7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D08176FC6;
	Tue, 11 Jun 2024 09:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="H0m8tWyo"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2053.outbound.protection.outlook.com [40.107.6.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B9617623D;
	Tue, 11 Jun 2024 09:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718098597; cv=fail; b=WMuQ0izuqlIfStOb1VztvfugaasATKYVdUqlUvZtwQRayv1xH/aEvgtg21Pa8/cDakfVRVq8QRE6mR80F+9/36au5wzGG70SOOH1nUpwtn8+GraEnKyuIMhBMNZNYqPoawVPzZipG/tvfVT2gaENWe9MrlxgSOG7wwPR1HDQm/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718098597; c=relaxed/simple;
	bh=/pLFLvsmTvstIusxiLOXn00gR8P/rtdCps+6C+6HuYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=eqqXtY5nB5P+GoQVMooM953JllJo4H5oGSxt1+Km3+Y65kwYwAGYSoASRd/8U2o0oMGCZNEOFmYPQvUe16nNqVH4PDGCRNvGSOEtn/eQd/NRZvW0ZyO29pip9qzT8F/Qfl04wOkpTKFNHW2EeDu+C698M4xGbjjGwCIp987ZJG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=H0m8tWyo; arc=fail smtp.client-ip=40.107.6.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Anx5OQVF0fyeM6yWOZzTEiQcqJCXyXvot60Kt7rooK/awQsgthwZWwqzxj47TN65HnMqvplYl81g5GGHSx2qy7169nn0bgEjLjAXs0MM2ZzBsG31mI6pCltNqc8azOop91025aymArHaktMq/8mV4GdTm8somMfhvVrhVmo7V0Dog5YQWQDOJ5Zm0DugELzgptO7OB/C6D0w1jXwB0z45/GXIEt+fE31UC/a/afBOzsz6HfO9ppg44iokEShNNHGNxmsU/IQELJBqwPZtWGIBBKmwB5eH3H5PYSJLd8R4kc9kbQhbCxzO7nv4k794Wa/DSS1h1v4s+9kn0Ewip4X9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LISKJW0Ft8RRdvxUOaTd+tMKHmGv1hfXEUZAakyH90=;
 b=SBc0tkCXseq9/93zMuwOHrPg3+qYwmkVZPlIRoTNlYOc2HXxGGCS+IQiHHXsGsp0izTAKl0B5EJ2Xy0Fw59xyaANoN51Idi0+M8hC9ZNOGBvme20Uf0tpdYTHJR1Q9YOIsHGUgcH4onm8VzItTHnhh9V8N1LYEWJpjXxrxMQTt/MszCTrgtVWt3cgHHUdKFZ+1AGXRgHKYn/bZ/YYHHvYnGxoSBeQyvJRlrzVJiKNwEBNVjcaPSINJ9mRqSL5ckd7d+SP9U0ne3aSVpwKAO5j5TsfQ1pJYaSCGkkRSUxXGGWB8L2FEqPS7JD880dc+XNzhrByvZPTsr7IDkjVzA/GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LISKJW0Ft8RRdvxUOaTd+tMKHmGv1hfXEUZAakyH90=;
 b=H0m8tWyoM0z0m2qQvbuPWIho/4j5gjHuvtSCGBerGxVIdXefRQ5TAAPKhdjiqrVE50FPalfQWT29DQ8qY9tN8TfUfKazfUr+HQXd10+umMC7iYym073y5Bs9o/Ig6ZqBeTyAj7AKoY1XsjQVhQMJnsyBKs3NLYI+w4h/XJFJ2Uo=
Received: from DUZPR01CA0175.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::19) by PA4PR02MB8193.eurprd02.prod.outlook.com
 (2603:10a6:102:272::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 09:36:30 +0000
Received: from DB1PEPF000509ED.eurprd03.prod.outlook.com
 (2603:10a6:10:4b3:cafe::41) by DUZPR01CA0175.outlook.office365.com
 (2603:10a6:10:4b3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.27 via Frontend
 Transport; Tue, 11 Jun 2024 09:36:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509ED.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 09:36:28 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:36:28 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 11 Jun 2024 11:36:28 +0200
Received: from lnxamnaw.se.axis.com (unknown [10.92.129.190])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 4A6D4574A;
	Tue, 11 Jun 2024 11:36:28 +0200 (CEST)
Received: by lnxamnaw.se.axis.com (Postfix, from userid 12778)
	id 47A90207290; Tue, 11 Jun 2024 11:36:28 +0200 (CEST)
From: Amna Waseem <Amna.Waseem@axis.com>
Date: Tue, 11 Jun 2024 11:36:26 +0200
Subject: [PATCH v4 2/2] hwmon: (ina2xx) Add device tree support to pass
 alert polarity
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240611-apol-ina2xx-fix-v4-2-8df1d2282fc5@axis.com>
References: <20240611-apol-ina2xx-fix-v4-0-8df1d2282fc5@axis.com>
In-Reply-To: <20240611-apol-ina2xx-fix-v4-0-8df1d2282fc5@axis.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, <linux-hwmon@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Amna Waseem
	<Amna.Waseem@axis.com>, <kernel@axis.com>
X-Mailer: b4 0.13.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509ED:EE_|PA4PR02MB8193:EE_
X-MS-Office365-Filtering-Correlation-Id: e9baa9c4-bf86-4c2b-2951-08dc89f9f893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZG1BK1pnS2lLUld1TXhoUUxwK1dITDJXVHp4NzNkT013aVAwUWJ5RysvN3FB?=
 =?utf-8?B?WlBqRFJQbDRiMk83ZHNEVFBmR3ZzWWxhMGJWZjZaQnNYNmcvVmZaaExQMTZX?=
 =?utf-8?B?RVpmSXJWZk9NbTR1Rkc1ekY1dE9LTWdlT0Zsdm1JTG00UEpLU3BVQ1RRcXVM?=
 =?utf-8?B?V0dnREtGeUFleHZCWXl0ZWJCMjJkb2pJbU5GbThPMmVuVkhwSEFnUVZ5emlT?=
 =?utf-8?B?NXBJN1dUU0wvajNsaVVCUi9sUUQwWEFpaGNrakVpTXFwanoxaGJDRHgrTGlm?=
 =?utf-8?B?ZFpjdEhPV2RkSEhaTkRCMGxaemp5RTlFeit5NVRUdTZyOGlYZ01ZaStLczkv?=
 =?utf-8?B?Y1czV2Z5TStZU3FQSmx0QWZvU1JheUV2WitvMnRrTGt5cWtpOEtaKzVDZVFu?=
 =?utf-8?B?WTRrWXZMN295SjdlMkh3K0lINnA4amxBOWNRZTJiRkxmSFhMRjl4M1lNUTZQ?=
 =?utf-8?B?UHVtMG84ZE5idGszTzFsKzUvUzVZSDBvY3NJM3cyLzh6T3JGMnpWMEZhbk1U?=
 =?utf-8?B?VXhOc3hQdmJWQkxiUUd4YlNjMlpCbTVHakRPaUw2NDB4OU04amcyaHFiUXJI?=
 =?utf-8?B?UmhhdkZ6UGxyaUdpMk5vdjRFMmtnRFptTElrRC83Q2tQUEFyUU9sUm9GaVZj?=
 =?utf-8?B?czdsd0NlY2NvV1hKOVdkNHZqVU5yWGJHa2J2V0N2YldmRGFpcW1VME1IUWFh?=
 =?utf-8?B?djlSZmhIUzVKeU1Hc0dDQzdjSkNwaVNzZzd5VWR6bzQ5UHZYS2RlS3RkQVMw?=
 =?utf-8?B?aCtJTWE0bkEwYUlzRG9rMWpHQTBjNVJxcWdSNVlObFV3bW96a2tRSVo1M0cw?=
 =?utf-8?B?UWdHYnYyNzJtNndKMlFvU2xHM2tWY3BXY01RY3BwcDNoNXNndmhjVEd6SGRI?=
 =?utf-8?B?OVk0NmxGR3JjOGtmVUVNaTJQVVZqK0NDdGZTbGFrOW1JY3ZuRW5UMzQ1Q09j?=
 =?utf-8?B?OEV3d2FDendsREoxVGh6bkdSb0gvZ1RRVTE0WEZzYnIwaUx2TXliakNLeE8r?=
 =?utf-8?B?cjdqaG9obnJRYWVvc1VYeDFGR2pIY2ZaNlQ5bEhDZW9aT0xpWDAxcmNSWlNx?=
 =?utf-8?B?Yk5mK2Q5VHF3ZmtLOU5FMmE0R2NFRUQ4K0JvN0ZYTXcwVjd1aytZWHRwaVJx?=
 =?utf-8?B?ZnVsKzN3SU1qMVNCclZ6enZ5MWk5RXlkM0Nua0pXdEpsRmdCcmUzWGh3YVp0?=
 =?utf-8?B?Unk5NkpLcVNuVmpZUWRISWF0Sk8yZnVJVTIrZWwweldJKzN1bWFoaElvOXor?=
 =?utf-8?B?V3NYZDZjMkFBRHVJbTBVRFhDSk8xZHY3d3BNYmdBMVNieWVraW1rSm44MytX?=
 =?utf-8?B?eVk5Z1k5TUIraUxSelVlTzlDdGNqQmVRYks3L2drUlNlWDJFcmU3ZXFNV3FE?=
 =?utf-8?B?UWF3RVpyNFVBK01ycWVVb0NBcUdDd3FXdFROZE5hRlVpUEF6VVFKWnJucVpR?=
 =?utf-8?B?eDJBQkZmNW0wNmhOQng5SklxWWc4Y3VpZXdpNkRqWTVvN0hKTzJkVGgzaGVV?=
 =?utf-8?B?SzM1a0xwT0lBVCtnQkhMUVU3WldHNDJ3d0NNRE9zM0VQNysycTZXVGlFTXUy?=
 =?utf-8?B?b1U3aDRkUEU5clJUYkR2UE5QU1RBTzVsRWFERXh6VFo0VWpUNHd2VXpMcXZH?=
 =?utf-8?B?amVOTU9hQU1oejU0cndzWEJUdVpTSWdUd2hXSUhabjAwUUNoU2ZDd1Y5Y2pP?=
 =?utf-8?B?ZEFjMlFLcDhSRUdOaEhwUnc2TXVwNzlxalpScHdqSDR3NDY2dUZXN1pxSnRi?=
 =?utf-8?B?VExDakxPdFgrRGNnSEdaVGFpR0psQlN0cmxpTytCNS8yN0puR1ZScWtaL2ZW?=
 =?utf-8?B?cVJ1L1dHRXpBbjNFSi9Zay9oakwvRytSR2Fwc3dlUUFUdHV1d09aaUNOeU9n?=
 =?utf-8?B?MTk2aEYxTEZBcHdveCtvZUZFZTRubEdCSU85SGR5NHJsTXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 09:36:28.9243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9baa9c4-bf86-4c2b-2951-08dc89f9f893
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509ED.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB8193

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
 drivers/hwmon/ina2xx.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index d8415d1f21fc..f26ba479bf5c 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -73,6 +73,11 @@
 #define INA226_READ_AVG(reg)		(((reg) & INA226_AVG_RD_MASK) >> 9)
 #define INA226_SHIFT_AVG(val)		((val) << 9)
 
+#define INA226_ALERT_POLARITY_MASK		0x0002
+#define INA226_SHIFT_ALERT_POLARITY(val)	((val) << 1)
+#define INA226_ALERT_POL_LOW			0
+#define INA226_ALERT_POL_HIGH			1
+
 /* bit number of alert functions in Mask/Enable Register */
 #define INA226_SHUNT_OVER_VOLTAGE_BIT	15
 #define INA226_SHUNT_UNDER_VOLTAGE_BIT	14
@@ -178,6 +183,14 @@ static u16 ina226_interval_to_reg(int interval)
 	return INA226_SHIFT_AVG(avg_bits);
 }
 
+static int ina2xx_set_alert_polarity(struct ina2xx_data *data,
+				     unsigned long val)
+{
+	return regmap_update_bits(data->regmap, INA226_MASK_ENABLE,
+				 INA226_ALERT_POLARITY_MASK,
+				 INA226_SHIFT_ALERT_POLARITY(val));
+}
+
 /*
  * Calibration register is set to the best value, which eliminates
  * truncation errors on calculating current register in hardware.
@@ -659,6 +672,25 @@ static int ina2xx_probe(struct i2c_client *client)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to enable vs regulator\n");
 
+	if (chip == ina226) {
+		if (of_property_read_bool(dev->of_node, "ti,alert-polarity-active-high")) {
+			ret = ina2xx_set_alert_polarity(data,
+							INA226_ALERT_POL_HIGH);
+			if (ret < 0) {
+				return dev_err_probe(dev, ret,
+					"failed to set alert polarity active high\n");
+			}
+		} else {
+			/* Set default value i.e active low */
+			ret = ina2xx_set_alert_polarity(data,
+							INA226_ALERT_POL_LOW);
+			if (ret < 0) {
+				return dev_err_probe(dev, ret,
+					"failed to set alert polarity active low\n");
+			}
+		}
+	}
+
 	ret = ina2xx_init(data);
 	if (ret < 0) {
 		dev_err(dev, "error configuring the device: %d\n", ret);

-- 
2.30.2


