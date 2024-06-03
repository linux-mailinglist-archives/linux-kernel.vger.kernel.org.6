Return-Path: <linux-kernel+bounces-198959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 797F48D7FBA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4B6D1F2117B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AF48289E;
	Mon,  3 Jun 2024 10:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="N0PQ9kSk"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2078.outbound.protection.outlook.com [40.107.13.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A27B77A1E;
	Mon,  3 Jun 2024 10:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717409324; cv=fail; b=HdlhMIovcGrE03gBxD7MiIK64zlfzi0izyz7fR3UZgZrLw9Vi9dpG23KIyv8jmOoAWgoNjO3IPZApBrXVX1SFAn+GFMUj9hiMnZkNN9RICHhUe7CVtkKeQh4+pCrxDcS1oKXQdA4o4E/YdmZt0Gk9aFzE6wxh43SldsgP8zvdtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717409324; c=relaxed/simple;
	bh=10WWr4BXdxpN57HgbbKe2H1s/iOU9aqVNgvZelJZb+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=oOp08YiIPhO/WSf79HCBvB98yrVfoLH1YerDpCRXn2QdRQ296B+5yJxlY4y3u5ny7b0kKepUsREDm+GzZWjgHi+7HUYhjBGP+fSsKzPhbpiEz9y6YagTNT5DLBhc8n8IacLUL94wS2a9NmOl7PvwL0nM/KNHKd/jxTDACy/6ulA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=N0PQ9kSk; arc=fail smtp.client-ip=40.107.13.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSngYDkfqwfe2mggn3MMC51aUgjwCGKJ/iA7q4kIXjNPbJUvczvGD14TNF/nygMS6cyfLBT43Nzs0vfXUUEIqLIGna9do9HQ5w4YStziOYb6VgWu2cB+XIj5NcLmmi6zsC4Xv5RiAE/qvYth5rqQGjDnxC0YfH9d0+sin06FpnSFJ/2iy29YTC3XfD2ClV55SHho1qh/L1xj/+nVVOwq7nrYBb4hUCVUP1E8WvRElHE2Hg0ehQ/lGmsNo/dXuSyDbdfQHpIVsEiVOnWpXh4wXT0Wuq5pQsNEjQHTfaavhSseXBZryoZsudKBzRdJOJWYAi0SlasYC1NlsQgjEyP+nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShG+Kb1J/1DQQx5GG2zUHffwVEiygeVlyCc/hbFC0mk=;
 b=f4qrpnLzZjcVKBYmmewaMnrIxBCabkO5EHS1Eph/ZLLQFpv72mu9gy+Sp2kPKvigt8XaVpX1c4YZq7MYY+kxBdCo4eNhF0wwmbiEfTtYULYWOqGhma7uQkD0vHHmWiKAE8Ti6L0eI+5P54YdDeChskvlIfE9fQ9s6bfN+y16L/33jKv9KPCPjEXWFo9LSNzxkNlzy3VetdwojiAGZHzoWJIwvYARDtvbRjZzORGtenLGDlTagNSyosYO5oPG1fxbLvoF58JQn8YD1zQdA6qp1+HZmXdVQuA3scFY5V17CoMMTpaM7oQamGq1p8xLfUooc2p+GzlAJV1p8FLKw1Ud8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShG+Kb1J/1DQQx5GG2zUHffwVEiygeVlyCc/hbFC0mk=;
 b=N0PQ9kSkfISg1IeUFeYT4BG6nK2JBZPdM1jLTBnBpk9W9pfGQHQIc/ycDIC2Kjuo1wy9qmZl214ajPs9iB2YRGszoicp0GgswV49kuN4ET7tuGW5YNe2N5GUDXwyUn8R4ASv3Ap1usJed80t50Og4rXW79S8gYsMm8c6KtorTso=
Received: from DU2PR04CA0276.eurprd04.prod.outlook.com (2603:10a6:10:28c::11)
 by AM9PR02MB6546.eurprd02.prod.outlook.com (2603:10a6:20b:2ca::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 10:08:38 +0000
Received: from DB3PEPF00008859.eurprd02.prod.outlook.com
 (2603:10a6:10:28c:cafe::27) by DU2PR04CA0276.outlook.office365.com
 (2603:10a6:10:28c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27 via Frontend
 Transport; Mon, 3 Jun 2024 10:08:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB3PEPF00008859.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 10:08:37 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Jun
 2024 12:08:37 +0200
Received: from se-mail02w.axis.com (10.20.40.8) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Jun
 2024 12:08:37 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 3 Jun 2024 12:08:37 +0200
Received: from lnxamnaw.se.axis.com (unknown [10.92.129.190])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 2D4F72A6A;
	Mon,  3 Jun 2024 12:08:37 +0200 (CEST)
Received: by lnxamnaw.se.axis.com (Postfix, from userid 12778)
	id 29296206ACE; Mon,  3 Jun 2024 12:08:37 +0200 (CEST)
From: Amna Waseem <Amna.Waseem@axis.com>
Date: Mon, 3 Jun 2024 12:08:35 +0200
Subject: [PATCH v3 2/2] hwmon: (ina2xx) Add device tree support to pass
 alert polarity
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240603-apol-ina2xx-fix-v3-2-b9eff3158e4e@axis.com>
References: <20240603-apol-ina2xx-fix-v3-0-b9eff3158e4e@axis.com>
In-Reply-To: <20240603-apol-ina2xx-fix-v3-0-b9eff3158e4e@axis.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, <linux-hwmon@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Amna Waseem
	<Amna.Waseem@axis.com>, <kernel@axis.com>
X-Mailer: b4 0.13.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF00008859:EE_|AM9PR02MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: 21456d1c-1f35-49d5-83fd-08dc83b522fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3F5K3Q3YkY1QnVPRkVLRzAyaWg3UE1YZzlrWTFLUWVXTm54WUR2YXpsUkcr?=
 =?utf-8?B?RUpOTldISjVkbUdPalVwalQ4WDI3SzI2OUE4YXkzbytrcU1VelRxeTFLclJq?=
 =?utf-8?B?SzFMTitud2QwZnFETWo2b2RONjl6Y2xiNWF4bUhXTzhxOGJCU2ZpUE5ETllW?=
 =?utf-8?B?b2p1VGN0c1dueGtDZDdFOHNVNWs2UVFERmtpd2RaTVhzRW0rUXJEcnhneGYw?=
 =?utf-8?B?WUZlSmdNVk1rMkJtWHpnT0I5a1RmaCtFTDNmL2k2VmcwNzJkdS9EUFdrZlR5?=
 =?utf-8?B?aWJpVTdVbTBBUUZNaUlyRDdQNTFPZUE2NEJwM25tNklwaGpGUWVYdSs1ZTRa?=
 =?utf-8?B?a1pDdUtYNndOMEUvcHMvNHY1dWhMRkQ1RkZ2RW5scTArdG9tZ1EvM3FzR3Ba?=
 =?utf-8?B?RnhZOGxpUUJzanNsdW5rSG4raFcwTEE0UFhZYjRPVEt4d1dNci9lSkEyVndm?=
 =?utf-8?B?VE1WUXEydGthSVZabjBYMy94b1hJb3d5cWVmUm1nTmJjSFRQNGVqdmM2VG9t?=
 =?utf-8?B?cUl5MXVEUkE1bUNCV0ZjTDlxeVZ0anhUbE40QzU3VDN3L1pLRWkwaW5ueUZl?=
 =?utf-8?B?RndwUWduVmNkU1VpTitQa2poVVJqNVMzdVJlazM5K2FlendGanAzS01WUHNn?=
 =?utf-8?B?eTA3Q0pwS0p1ZGVXeW9wTFFwRFlrMk1vTDErYWFaUVlnZi9FSThIWmNYR01m?=
 =?utf-8?B?R2dSOXRNeUJ5UytqMHl5K0NTcXlDY3NyUWlJa3V4bkFVQ0k1UDJOL1lpQVhR?=
 =?utf-8?B?SUVyL2k3VDJiL3Z2VU05Q2FLYURLVlM1YnoybkM3TGNnUkxsWUFCN21BaTBL?=
 =?utf-8?B?R1YyRDdUSERQMHpGVkNjUUdUMS9pNk1reUpoMmJwTGQ2OTV6WllydlEvcVJ3?=
 =?utf-8?B?dS9QQ3JUVlJ4VVFuNnZGRWgvbFpET01xSmVncFFCNlJiWk1qRlhRMTdSc3pX?=
 =?utf-8?B?S0x2UU1XY0FEbFJKVDRoclAzR0pCa3d4dUxHd2JXTjd6T3VRbVlsbkx5NDAw?=
 =?utf-8?B?V3RsZzhvUTRVZTdla2VLRUFpSnBJaVg1MmpKZVJCNDE0N0xsV2pTN21JMVo0?=
 =?utf-8?B?WEpLelZzNm9UdTFEckI4M0NnWGUweWRLdDFFekMzMzVraFpldnoyc1BUNlB0?=
 =?utf-8?B?SkVMa1NWWktseVpSbVh3em5CK2tCU293dkExenJLeHFKbi9GSEpmV1RpZzV2?=
 =?utf-8?B?eDRrcmNvNkcxTUlEc0FIRGFiNnBEeXBVN3NwNkdTUmhITWtvc2RDeDdmL0xQ?=
 =?utf-8?B?UllXMVRxRDdxUkl2Tkh3dkcybGJUNzYrTlV2YUlXNENoYmo3N0k0T2lrdkNG?=
 =?utf-8?B?eUJFNkRGanhTaHNOaFZKdFQ0QzZFN0ZLdmxScmV5TmQ1N3IxQjJibGtiakdR?=
 =?utf-8?B?THJvcmg1RWJiVzBENDVqVW9MODhJUHJVSi9ldGxJU1pXWlI0cXNFbS9VVHlt?=
 =?utf-8?B?MUFRRnRabVhVZngzay85dUFlbXpWdWh1TzBxblR3WGVxZS9sQzVudFM5dWNF?=
 =?utf-8?B?MTJZR3Fhd3A2UnRrNUQvT1EzYlBkQml6V3RVdEhCbXlDWGFQbUpUdnY3UTRl?=
 =?utf-8?B?c0dqRmx1UmpwbVk5V2xHazliKzBydEgyT1MxeE1veWwraldnSDJtQXFyNDlC?=
 =?utf-8?B?Q3pFV0JpRmJrOVo4ZmxHU21qS1lTNlNvZ3FLaHlQZXNhVksyTVowM2lNL3J0?=
 =?utf-8?B?VHpnakVCcUllSGFhc255a010TjNPeEY0RmZ6N0RHYnZ0WS9wRGhUWDBRTGEx?=
 =?utf-8?B?RFZXbHBkUEJIcDNVakFPcFh6T1pucnpNR2MxZ2M1TWhUSlpTNitiMC9Dbnow?=
 =?utf-8?B?OXF6RTJBNWlSYWNVZi9ldTFZc1lXWEpVVlhoS3ljUXROUUk3V3FoelByV3Nn?=
 =?utf-8?Q?pO+aZLDEFHD/r?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 10:08:37.8148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21456d1c-1f35-49d5-83fd-08dc83b522fa
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF00008859.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6546

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
 drivers/hwmon/ina2xx.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index d8415d1f21fc..101346d26c88 100644
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
@@ -178,6 +183,17 @@ static u16 ina226_interval_to_reg(int interval)
 	return INA226_SHIFT_AVG(avg_bits);
 }
 
+static int ina2xx_set_alert_polarity(struct ina2xx_data *data,
+				     unsigned long val)
+{
+	if (!(val == 0 || val == 1))
+		return -EINVAL;
+
+	return regmap_update_bits(data->regmap, INA226_MASK_ENABLE,
+				 INA226_ALERT_POLARITY_MASK,
+				 INA226_SHIFT_ALERT_POLARITY(val));
+}
+
 /*
  * Calibration register is set to the best value, which eliminates
  * truncation errors on calculating current register in hardware.
@@ -659,6 +675,25 @@ static int ina2xx_probe(struct i2c_client *client)
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


