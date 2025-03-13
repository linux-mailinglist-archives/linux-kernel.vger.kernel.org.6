Return-Path: <linux-kernel+bounces-559522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6314A5F4F5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CADE1885950
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9E0267AF8;
	Thu, 13 Mar 2025 12:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="glEJWqYp"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C190F267731;
	Thu, 13 Mar 2025 12:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741870242; cv=fail; b=aJBajKI1Uaich8BFD4jMfrmd3GAqRLRZt5bw8TtD+YnEtzrprJEOe/2DHzslVlUCW2Uh3w1icc0jUr0jfWQNHFv1luzKZIbDzOGZYkQW6oLdhNzexieHZW2CyPTSZq8GZA8k17AmIfyYvNLgTSNz6MG6YGWzfcEzxwlFJ070dIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741870242; c=relaxed/simple;
	bh=12ddnSGbIaWfg7E2TPLFxJakB6OxILOhRRm6gpEsGSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ksCRhw7fkck+Z+LV2XZIB8/dh8pi3faWo5XJi67Yoasl99vv9FAf+mV+OfZMQoVRptCK2pYJZ0SsyXGql/VyYrTxsbFCzQH/R1gPg9QYMcBH6JzCcNC9Jsjk+j/nQFhxz4BxL8pTpsjfgZ/oNs56LfAWJr4mLaDKKU8P2iRToaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=glEJWqYp; arc=fail smtp.client-ip=40.107.20.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KgDamm/eQqpnJ0gWTNnayXniVe7yBYsp6njqzwspbllchzE6j82GlDJIaR38g85pJ7JWh/3y/5LelRpmCDmGPYOVCRq4FtyL8G8kPX5GVwOcmdRphATNV/jCBM75zL47szNtvwCN8CH1MDZ8WWj1/5gEra7Q0hQM8NsIg2NctILOyjNP814Qvh+Cy7xQey47wd02+jx7kU2ThgrOJRNGC+po1rU+8wqUpHuG5DsHoKXKBABixoTKgMRjd2JxgimvsS80qTIUYHEN6N+0YSw+/FUSjM3iXJRwHXcy8HRlDwx1aJUKezHZYv5H+WRXvnCY6BqGuMmFi4QpX3dDDF8Nag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SAS32sWUqrMSSHqOwA3qiSpt4GRQEm8a3yJVSVKFmM=;
 b=byQGw/uITwU6szGIrfW0bulqpvx7jZkWY+75o8yf/dapTiNteF8YopX9eK6RsidokpiFzvF12qksloRvfeS7TL8GgHhXRl6c8UCB/6VEmgacvRJIQCHSC+1T6E+v3rBpTYEwjeDn07Q+ecnwOq1Xh6EvBYBQ32YZ6isF/FFYwYpTHKysq4wlsS6OAreDOa5yA0MoVJEtlf9Vak12w+mn2perwfYPTiYM7/OM6jsyblfcD8xUquzYfBH6u7dWcxMAYKTRela96DSvS7/5oDqj3c9lALw0sqIsxKP4gBAFZoGZy0/4JYKzB1vJm2wEjyFHf+0311kkpfbJxFc0uOF/HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SAS32sWUqrMSSHqOwA3qiSpt4GRQEm8a3yJVSVKFmM=;
 b=glEJWqYpSoJFkd0SNRHHxpnOWp0I5cj/wqQRLQPudNn9O9nzBwB42/4pnpzYlgWKbc0kyPqzw06eIv3AInbbZ+AyLPJbAX2Q1uynrjNfAf3jDAmrpWjkUj4/2lEdeCb6SgR6IEhQ0OL8aMaBM7q2tHdM7zYLonxiurMKfpgZZUpp07nMX0scL0T+J7MmR7AhpbN4aZkXMBgLtWoaDIG55en+7DRv+X/6d/Ke/CFXuOf1ff8Icvq9f+pUeVH+Hkwxk++oXDbAPOU90f6MtQeleynbZwYmKyj9UvNIecR00KuT9EcIb9TmS+GhzNYyE98ykhiDlUT5vU6TmregaSs6NQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com (2603:10a6:10:5b3::14)
 by VI2PR04MB11025.eurprd04.prod.outlook.com (2603:10a6:800:277::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 12:50:37 +0000
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db]) by DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db%4]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 12:50:37 +0000
From: florin.leotescu@oss.nxp.com
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Shych <michaelsh@nvidia.com>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: viorel.suman@nxp.com,
	carlos.song@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	festevam@gmail.com,
	Florin Leotescu <florin.leotescu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 3/3] hwmon: emc2305: Use devm_thermal_of_cooling_device_register
Date: Thu, 13 Mar 2025 14:57:46 +0200
Message-Id: <20250313125746.2901904-4-florin.leotescu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250313125746.2901904-1-florin.leotescu@oss.nxp.com>
References: <20250313125746.2901904-1-florin.leotescu@oss.nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P191CA0001.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::6) To DU7PR04MB11163.eurprd04.prod.outlook.com
 (2603:10a6:10:5b3::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU7PR04MB11163:EE_|VI2PR04MB11025:EE_
X-MS-Office365-Filtering-Correlation-Id: 4096f8e8-6f0d-4299-f595-08dd622da710
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?8Q28nhDyQu2g5u3l/N99tgwnmc6gNxFzs/R/+DwDRhLbCEPXUnPbCwQNNK?=
 =?iso-8859-1?Q?fIpMcq5ebqP1EODl0DWJ0ai9vnZKLdwR2Y/BRNpFnsQVWe9BFyWaTugbWL?=
 =?iso-8859-1?Q?PS6cS8YGTFHVn95k0sfqRtr3MlucPWaKviN7/bkVzT7IFhbgNEx1G1aVNM?=
 =?iso-8859-1?Q?Utsga3O5I5qUmK0hCscjETt4g2InWesFMR6zYP3rBhHThk7I26wdhwvd5v?=
 =?iso-8859-1?Q?mAuFXFsEROuIjI9hkuZifayKo3vJHDRU1Ce9+wbyRMgzAUPKVd4BOrJwLE?=
 =?iso-8859-1?Q?kxbw4JNeb6P8Vg5KDjBssDYU+f6f0UQ1+NhcZgPy2QgQAoTfqE6qxLiUgf?=
 =?iso-8859-1?Q?yKDzwqGbTFZiesdXD20Yw6tRSCiXnNMGecOmKSKoZNROcZQcfNd+gDNR/W?=
 =?iso-8859-1?Q?QG2/asf4cvIwU1BUHiArWA22g1+eYlPu1coOhVch2013ig+1CtEi4h5v4W?=
 =?iso-8859-1?Q?TnJ46ATlsd++rOpift12uAVT5GOX9iO4Yoof+VTTY0PFT0Gngy3sgQecdt?=
 =?iso-8859-1?Q?l6aYocej2EeoxWCg0zaVKZlkU2+yfQ7VyUQgSZDrdT8jgA5kBDGkTGj0PV?=
 =?iso-8859-1?Q?gB6/7NvXiEweOHmzvPo1XJxAIWj/0LULJUEl0gR9Z3NEYNSl1Knq0g/p0c?=
 =?iso-8859-1?Q?RQfRta1YtImzaaouOFydBiw3uwEz7uwNMCg2Ybt285zLDyREsddwXPF3JP?=
 =?iso-8859-1?Q?298ssPhvbJG8SM7obPv1m31IavgtukwSfkjQFZUOQjybO+3XxKo9nnSB9Z?=
 =?iso-8859-1?Q?/Fi7ER20MOLZ9lfhC6AIqJld/sIS64vyAoCed2SdcNIL49qYoPVW6La379?=
 =?iso-8859-1?Q?Mk2s6h1JWiq3OaZgFhxHgshYMJ55+baYuaVz8RMkJ/iufP2Lu/yaiC1U4K?=
 =?iso-8859-1?Q?QMDz0Ihm+Fg0ft6LTy2qBQ6hcc1toUYsiQx9yFfpI1Uba7JQESzN9Kyn6P?=
 =?iso-8859-1?Q?yfPCevlzc7aikyWpj11yG1nKqx44PFGJVW7AYWIaGqgqN+EwEJvQ7PR1ZX?=
 =?iso-8859-1?Q?o2Sv3xjYoCLLCdpmF/rb52x93jcP9euiOl00nLIp1WRlBUGNvtokbr+nbB?=
 =?iso-8859-1?Q?nIrMRB3EPLWcyFhS/ISRXA9gQfQeHSQVED7jehLYz5XiJDF6NBO5fmZeRq?=
 =?iso-8859-1?Q?HW9NMgGifOQ8oExZrhZPsJW4ysMdUsyuw+DL7/vs4ZUbrqV45TgXs25Qp7?=
 =?iso-8859-1?Q?VK5GZw7Du2o9AVQqs3v6lpbQCWM2DgJpJdDEUS39vX/OcLvYk6jHTut2tH?=
 =?iso-8859-1?Q?+qYlDiaPEqbc5jipnkrOnAU+spRs+PyvCoUZy25PdgA7XKX9WCcGQJZQgJ?=
 =?iso-8859-1?Q?aqDcdgRo6iTdCx1G0G+Dqbd6AbN26VDCcMoVaDhXKmEih7AaN+cbAavOQL?=
 =?iso-8859-1?Q?+QhHuKmHyaYY0unvq+JdtNbCC7np4QXCCBvdJmrvNFP7jPsCeZl7PkxEMZ?=
 =?iso-8859-1?Q?UWUJWe8vHiZCdPKB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU7PR04MB11163.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?KMS+1SDB0S1hpFb4y7KM0GD4XRvHB9uZ2UqATvmesU8Y0hIx/3GjQ+Fe+v?=
 =?iso-8859-1?Q?SlZCHhNfwYz3WFt6CXl5fXDwy9AxSx3w4arg/J7EdORNMLZNNB+LNpR2Gy?=
 =?iso-8859-1?Q?alE6xKMFJ06O5houqSGW6tQk3SmUbuZ6I22Ki6EeJ1H3SfIvgBLBnAAMFY?=
 =?iso-8859-1?Q?HYFt6TOnAIp4WKgvP0BXcyoZFvyJoKsm6QMpaXAg6/dGT7nQYrLrtCkuIl?=
 =?iso-8859-1?Q?nT8zc+bctsDo+/irCNB+Cnb4pjSvmtSCWj+pg0zE53b+hq71meoZTYcV22?=
 =?iso-8859-1?Q?yB4bJ/7c09S+xWAh8VKNboSdqAsVk65f3Agcau0mK7Mr43/5b/veOzjIcP?=
 =?iso-8859-1?Q?uKPuS581OOFJEWqq39uQdaq2MY1HldE0xHHs73MqTkNi6dOscKIPRIap3B?=
 =?iso-8859-1?Q?5kOSdoYucvT94q0+Pr26P2bxauvwvIbnUfSO44ak4EoyfBWTtkmC2c6R8G?=
 =?iso-8859-1?Q?ayBBXHb3G27jLKpUcmrlEkvJ5kMwFlM/nXM2hPCeLRYIfhksZnbyfdVnmt?=
 =?iso-8859-1?Q?tWgCIvnKqzfnHnnG88/U/TzjqPl1tNZyEoOqdKFCgiDHvtNXMLhbRlVwdQ?=
 =?iso-8859-1?Q?9JpAHvWIlDEqNQp50GbndcvHwKAdANifBwWRk9fTaeP1c2t/UlOUFsCgvw?=
 =?iso-8859-1?Q?VPUOPva4ggSVZwMGHAzr4Xi/mUSo3uXbni/2vOUlg7O0aoMPTCf+BA9TQG?=
 =?iso-8859-1?Q?J22HttQDUnL12ILoGsjHYdoKIDbCTDaIZli9YpvMJThAObOuS6EpWqDdJG?=
 =?iso-8859-1?Q?z2U3F6A2a6YU/3z5ljwn/6F4UCeyQ3J78lsnxokVxFOeq8EWH4xZWnldW5?=
 =?iso-8859-1?Q?WppGf6JFaX2h1rz5+J8YSEuMv9lpOFXMRYzt0K+rSfc4AJe3iGYVFxUdjR?=
 =?iso-8859-1?Q?wmjmqo1Wdjaf9YlGtypW7vaoEx3xTfOf1vQu8UWDb+zyLT5iiFY9DshQmO?=
 =?iso-8859-1?Q?H4iUsW/m/4uxVpb5QkkzhWNzNQi45jvkSLHQxB8f2G2gKesgYAkca/aUha?=
 =?iso-8859-1?Q?PKk6cUG9hrdsg47ga+YvZluONYWtw+SoYcXk9KZnGXyir0cVDFOeajO7o2?=
 =?iso-8859-1?Q?pkpP48ivYb39k5P4W2kzi2dZoGoJcJett3vk2mqJ2L53h+gQnVXLyeLIns?=
 =?iso-8859-1?Q?KtqUjlFhT3DgSJHRQ+XzfASXU+PtARClequV73NVs7tkIMav7jQjNF6QYx?=
 =?iso-8859-1?Q?RoV63UB3O058bXlLe4ZvBZA1jSChr9DYLM96Cnqt4Ft1oHY1Nvfk5DFK04?=
 =?iso-8859-1?Q?TIufoUN2VdWUX9fk3As3GaAQFVFtBWozxOGbgiQVL5Z2cvL68UBs5PSHWC?=
 =?iso-8859-1?Q?twgVHkjti1nztZ+JSMrkNo6DRZDMNgdsRMmJQgW20Fm1Zn0Hf9ubV4jc1E?=
 =?iso-8859-1?Q?gSumJhugbj5rWePNKFX/WI8A9X0FyiOjzktq+6tKFPqv1TCbt4elNySUer?=
 =?iso-8859-1?Q?jNAe+v8V3VYFGb1ffYOYKVPhOstlGNHPfdQmgsNhFJ3/BrINYsU1spgh2V?=
 =?iso-8859-1?Q?ydkUg/KVMgED4OemR1yLbA3uakbPIYFOXksRbewFlw/AskWjJnwgE0IPMd?=
 =?iso-8859-1?Q?H1QtHZ4Tumx1I51tf037vMq7yJn8kQZW0oOPQiWzxj/apbrnsOo9QiA4qa?=
 =?iso-8859-1?Q?YH3NFU3lN7qgsnAa+G5w/WHAfEkQOMPzfqJFKk+BAO1yiAvl1fjyzUpQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4096f8e8-6f0d-4299-f595-08dd622da710
X-MS-Exchange-CrossTenant-AuthSource: DU7PR04MB11163.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 12:50:37.3828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cDL8PskESo6TGKvdajhAQ85K4VlVKdPLyT+FjJEccTl8vHsjdapzukiT5BS6NyeZaGINwaBQb1/0vwdaVKq4mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11025

From: Florin Leotescu <florin.leotescu@nxp.com>

Prepare the emc2305 driver to use configuration from Device Tree nodes.
Switch to devm_thermal_of_cooling_device_register to simplify the
cleanup procedure, allowing the removal of emc2305_unset_tz and
emc2305_remove, which are no longer needed.

Signed-off-by: Florin Leotescu <florin.leotescu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/hwmon/emc2305.c | 33 ++++-----------------------------
 1 file changed, 4 insertions(+), 29 deletions(-)

diff --git a/drivers/hwmon/emc2305.c b/drivers/hwmon/emc2305.c
index f8a4c76fcadd..234c54956a4b 100644
--- a/drivers/hwmon/emc2305.c
+++ b/drivers/hwmon/emc2305.c
@@ -112,8 +112,6 @@ static char *emc2305_fan_name[] = {
 	"emc2305_fan5",
 };
 
-static void emc2305_unset_tz(struct device *dev);
-
 static int emc2305_get_max_channel(const struct emc2305_data *data)
 {
 	return data->pwm_num;
@@ -293,8 +291,9 @@ static int emc2305_set_single_tz(struct device *dev, int idx)
 	pwm = data->pwm_min[cdev_idx];
 
 	data->cdev_data[cdev_idx].cdev =
-		thermal_cooling_device_register(emc2305_fan_name[idx], data,
-						&emc2305_cooling_ops);
+		devm_thermal_of_cooling_device_register(dev, dev->of_node,
+							emc2305_fan_name[idx], data,
+							&emc2305_cooling_ops);
 
 	if (IS_ERR(data->cdev_data[cdev_idx].cdev)) {
 		dev_err(dev, "Failed to register cooling device %s\n", emc2305_fan_name[idx]);
@@ -332,24 +331,9 @@ static int emc2305_set_tz(struct device *dev)
 	for (i = 0; i < data->pwm_num; i++) {
 		ret = emc2305_set_single_tz(dev, i + 1);
 		if (ret)
-			goto thermal_cooling_device_register_fail;
+			return ret;
 	}
 	return 0;
-
-thermal_cooling_device_register_fail:
-	emc2305_unset_tz(dev);
-	return ret;
-}
-
-static void emc2305_unset_tz(struct device *dev)
-{
-	struct emc2305_data *data = dev_get_drvdata(dev);
-	int i;
-
-	/* Unregister cooling device. */
-	for (i = 0; i < EMC2305_PWM_MAX; i++)
-		if (data->cdev_data[i].cdev)
-			thermal_cooling_device_unregister(data->cdev_data[i].cdev);
 }
 
 static umode_t
@@ -599,14 +583,6 @@ static int emc2305_probe(struct i2c_client *client)
 	return 0;
 }
 
-static void emc2305_remove(struct i2c_client *client)
-{
-	struct device *dev = &client->dev;
-
-	if (IS_REACHABLE(CONFIG_THERMAL))
-		emc2305_unset_tz(dev);
-}
-
 static const struct of_device_id of_emc2305_match_table[] = {
 	{ .compatible = "microchip,emc2305", },
 	{},
@@ -619,7 +595,6 @@ static struct i2c_driver emc2305_driver = {
 		.of_match_table = of_emc2305_match_table,
 	},
 	.probe = emc2305_probe,
-	.remove	  = emc2305_remove,
 	.id_table = emc2305_ids,
 };
 
-- 
2.34.1


