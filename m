Return-Path: <linux-kernel+bounces-521604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 447DFA3BFD5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DD233AE8AA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E611E8323;
	Wed, 19 Feb 2025 13:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="I3DA9XkE"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDE21E5B90;
	Wed, 19 Feb 2025 13:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971512; cv=fail; b=CDqLPKEv6bin8hHwNj1E2FOvAgg4REiiybG3GNndbdf8lkViAyTEFWoyWRQFBRbqBVADeXVvwNO7V83qu0RkpJv6ZmbnM+Y7NrdOvpLuDhQGi8LPaGgXazumCDZBNjnPIl6J3syOV1d87TZFJJSqYjxl8QAt0mcWca8qRL3fYXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971512; c=relaxed/simple;
	bh=VFZfnHjb8CjNF1WZF0jTQTAOh8wy34GjoxnyRQ8L/wQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nTOwp8IGYTJjZzAE2fYJIGYcQj86lb3m2P6AWMK1J035q7wpjhRUOPJcsARZArg5mqNLeU6CUeSHmNOcPHZO8gEExpjeBBxP0ThupjJSeS5T4eSYPFoX49MxurVcUIOg8oQr9m2l+cItcz2Km8L+JKUOww5rJm2is0DH0jCIxuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=I3DA9XkE; arc=fail smtp.client-ip=40.107.20.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7O0Uiol5lmOXimUAj8iStbnZPWtWRhDwZVtMvrWJHU+t6fW+P4bdVJxpj+M8gqSVlE+UTXqzBCekiqiPkI5sY+7VSO2jU/HTs5RERc3gLuRYdCWTOfoc/Wo9+uAVKu0ZBZC0TW2wMCBkNQlfhDOqjILuo6xPP27y9Rmzs0qeiaC7xkIln8kb37hy7+C1y3iYimu1TzTgx4EECUlQrq9r4lYS/16yoQUzXIPv2pK2bi1N98JnQksP+KtPVw2OmN8UTpmJD2cALr0J4KksTpMSw2u6msBtQaVxxPuM4SUC0Kdjpoxj6ju5TJ0xB99QJPDo4ef4kH0O1Ui0VLbkDo/qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6osgqR47X1FSReNJfAwrFn0LJiEUyimjeR1zsSJlmU=;
 b=lBzeC2tov3QDqavW6hHCOIyFwVjoQzr80NJpEjhf0iXlpHT0DV8M7PB2TWwjJMRTKdVKV0XE1l8z8hL9eD9NFPpXJFbIdDSFSRN5syNBAB6IFy8Ja9s7HMSmCvX/JUEj2y/9ImZoHhthL+71pxtrT01DmdzNwmhhePeQ0NSfjygID8bKd/VMnWooNsmXaNcxrTfjZUM4oKcLoDY7Jq0sWJXBMbWqcQruiOgZqQyEUbgSaCSuY847HOxxvKXH9SflLqq/bx2RGccyh0wBS1jNNKjQVxASNAFN4c2Q74vCJB4TtuHvntqp6P+Zce8kOJOWoZYe3HdZGIzGhoNXpEitpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6osgqR47X1FSReNJfAwrFn0LJiEUyimjeR1zsSJlmU=;
 b=I3DA9XkE/BNSU9vm0jfTQt6rimBtC93WzKvQw6kRfFYZzOFCEiqolRqxyZiw9mf+8z/axj922Gj30t2D9LZv/zEFxanlgILX3/PDuZ/An28xT9WDISzYZtqDrrkkHZBWNQbAcrA8qQgx55VA48sFKW8R7G/z+hroNF56Wl8b9uxOstF9LatfL+IGBKT2hb5+dWmclOLwNaLeltdHnLVGyd3fGvxtJS05J0tF6E7hwmu1XvRa1iLL3Hzwm4G3M0tdTmeAajc43GlzKj8qDhhXxql3RMyfMdCFFG98RARZpcH0FL/hLdZBVG12HIPi6WUrSv4W7nockRHkD3QnfNkGKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com (2603:10a6:10:5b3::14)
 by PA1PR04MB10841.eurprd04.prod.outlook.com (2603:10a6:102:487::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 19 Feb
 2025 13:25:07 +0000
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db]) by DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db%2]) with mapi id 15.20.8398.021; Wed, 19 Feb 2025
 13:25:07 +0000
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
	Florin Leotescu <florin.leotescu@nxp.com>
Subject: [PATCH v2 2/3] hwmon: emc2305: Add device tree support for polarity and pwm output
Date: Wed, 19 Feb 2025 15:32:20 +0200
Message-Id: <20250219133221.2641041-3-florin.leotescu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219133221.2641041-1-florin.leotescu@oss.nxp.com>
References: <20250219133221.2641041-1-florin.leotescu@oss.nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0099.namprd03.prod.outlook.com
 (2603:10b6:208:32a::14) To DU7PR04MB11163.eurprd04.prod.outlook.com
 (2603:10a6:10:5b3::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU7PR04MB11163:EE_|PA1PR04MB10841:EE_
X-MS-Office365-Filtering-Correlation-Id: 13a2e8a0-07d5-40ee-b176-08dd50e8d3c9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?5769OmXFfVWjP53/xQJ0YYlsGYc9/5nvKgZczfMve9i0b3H1IqavMRx16t?=
 =?iso-8859-1?Q?6bZAA2PwahqicHvas5Kh4egpSGUvpJpklYwLZ20F/VDvOhkyBHI3fZxPuI?=
 =?iso-8859-1?Q?fvh38r88nkpNfVFokfwzpiHZTvIJNyhtNIcK5ei2FpvMGnK07Y10ciyPLA?=
 =?iso-8859-1?Q?ATpcSueGPjflrZw/q+upOj5kOUltPMZKVfWfmoVOCqOUL2ffSM24+OC66u?=
 =?iso-8859-1?Q?Eaj/V19oAEgG8eS7pr8UXJEdd7e5k8h7Kha51K6wc1J6O1xcPB6+5qea/r?=
 =?iso-8859-1?Q?fW+gQrsDeN8OyUI1TBjCaEoeXXxwGXVihIzIrTeCde+hLEnvuJbGwkdA6O?=
 =?iso-8859-1?Q?Hoe6YcHcfy1IDdI1g6J5pFYvE7w6ZA8Pa1KlyLbUI7EQrpPB2UL0xpOYMM?=
 =?iso-8859-1?Q?IOHsY5sCojYp51iz4c04kRBrWUxr796h5cpv8p4oEV9KAECoyPYU9Tb1CX?=
 =?iso-8859-1?Q?rfDTOYaK3PgE9nu6wxP8QEWNBVSZ0TzfJqT7uS6XrUKvihpYvsk23zrhSW?=
 =?iso-8859-1?Q?odADjS/AQshogsB1bQGCFQ0Eg/9FdnAb+6TjuY1vbpDENapSd8dCby6L60?=
 =?iso-8859-1?Q?46UecawXCcdWpVpZqCMYers7N27HikDf5KgyxZrziwfnaSUNeZb7BwYb8z?=
 =?iso-8859-1?Q?5h05FD/tF0rzCFnOUoIfn5ITStnAaUnYF1jR0ssPrQItoIjAW/2mm0xQqW?=
 =?iso-8859-1?Q?8Y3hEBmhBIU5IDQ5eqVKZTPAhSqf5Y3D5cGlToPosSbsSlgzNZzVZMYZYL?=
 =?iso-8859-1?Q?n3HViwERpAMSTiaAzBrq03kl0Cl31YI8vi+gA3sSgQZJcjQObltDQjCG5u?=
 =?iso-8859-1?Q?OKhAqOcGfPYAxxbQvbEmVTuPNIVeLhwf8tg6NNjH2WNj1deJCmVFUYdYp6?=
 =?iso-8859-1?Q?EvqvWX3ov3LfM4M8Xp3nI4tisGmOWmI2xG3QWO9Wn7mwVG54qGyv+FNVtv?=
 =?iso-8859-1?Q?Az+tO6luS+IpbsyuXdwEW8CeYCDwce3uD2jG3ogh6S3ZC4+Y1XT6qO6LJt?=
 =?iso-8859-1?Q?gmSldJTZ9lSshZ8b9KTSRiL9DGdSyYcBmv8+CdIbw9I6YYugXNo2S3MIG7?=
 =?iso-8859-1?Q?1exiJcEHCjt3tcK/BiqyhNKlupgviGHqz2yzXLb/69NSlMEhbXAYhBbYt3?=
 =?iso-8859-1?Q?lcPNbIeAmoTWojWP5lC/divhSL9YDzcfXoIglbkfl5bxk4tj6l+ger//a6?=
 =?iso-8859-1?Q?YaB7l9arpzrzPliVwZ9eC+VemD95bqWurzam4pPr3cwee0CaXLTbBq1/v7?=
 =?iso-8859-1?Q?jvjsDLUCReJb74HW6RuA9fJdLwruKIu8uvGHDiauWJ2TJPOJN8/A8p2e5T?=
 =?iso-8859-1?Q?bB7SjlQXbY2UlNyZjI5gySqZSZ+fu5JgbLN6wUDKXKN5JwXx9esdu98ANX?=
 =?iso-8859-1?Q?VhOhpS0n13LpQsVte98V95l3hydvTBl0sr34rk1gI4xBv1uCwwYr+gPz74?=
 =?iso-8859-1?Q?9ZVlt7Cbabib72lY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU7PR04MB11163.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?gFO6ZrW8byEL5XeAlODYR8LnuT/ZwFEOlhPDBlRDVRY6YMncqatYUdfUFv?=
 =?iso-8859-1?Q?8UUV/Ymm18Zv2QB7yB8iY5oG/xZ/jz1zrJjjsRx3/tUn2JD8nQhoBcSdt9?=
 =?iso-8859-1?Q?qacXbYCDdmWEmpmAGJ4LxUeAj45VGDdmiCXEYZ0q3U9zahxl466Vh3TaNe?=
 =?iso-8859-1?Q?GKBg8ksiC89+dCILRQX7lv3QldN4ZR9XdETBC/QRBypeMieS76Ig25waIT?=
 =?iso-8859-1?Q?a8L5OkzncCz2ta1yJVbHCOERxokJfCtmPE734HoznKXtSQ7Fa4LXvFNBiO?=
 =?iso-8859-1?Q?v6/AEgY/VVgN6/4nD5UEE3VLOGuSaCE6MZFqgwWJXlstsqnWfIjwMjaex7?=
 =?iso-8859-1?Q?MJqTzexv1HlADFxT6SBQ42I9EQpk/pngahP/axXesXeBJGE3X/ZkGiNGT2?=
 =?iso-8859-1?Q?KHQTq2X7c642V5AnglBaAvykTY6gwIBzNXUr0Swep1+Tp+kCs4uOJ3eFBe?=
 =?iso-8859-1?Q?qVDfeitQdo04bW6GqTGqbMfwLNtS7OXpxoS5iyTTbupm4GVSXmO+BdlAfP?=
 =?iso-8859-1?Q?YzuOx3EcQL9KZWnatQF/FDjIBa97k6hKHonrKgvUdd20pzHxttBSLeFQsx?=
 =?iso-8859-1?Q?z/A0Gwf1AjUwFDu+I42h0cypDr7UQWkyYUJ52PBkvZ6D56ynbpiF08BHSD?=
 =?iso-8859-1?Q?K5gjJwxL76KdTDQ9feUMouIPBwwfkNR+sT5z69vcXwF6lelhEh5wup3kAW?=
 =?iso-8859-1?Q?JVDgnbMDWo0688ZpB11d0AFSl+46qlrMVJ0zgNYnu9rW/gu4nBLjmXIozb?=
 =?iso-8859-1?Q?bKwroyCHkqpKti7YWaSlas44dB8k9S75TIFeKcfkO5L9Fgz0Zm6bDWZUer?=
 =?iso-8859-1?Q?Zb0CCZsw0LFSk93s2MfrTIjbScx2k/ViEWDQzG7rgOtraeXtZOlcNj6AzF?=
 =?iso-8859-1?Q?nJrbnzaV0mU+h9dJWQ6ELSjJfEJLyfGNRYL33oPZ2a8VHhU8M3wKO2YWYQ?=
 =?iso-8859-1?Q?2+P4rV85PIdbOJ1IvRiPrFtSfpqM0WPV0e6zQVOjGpUg5otoxGiMpC+DY7?=
 =?iso-8859-1?Q?b49yx2E58yh7MpWfupo7nglzd8x2rj7OPNKY5NdY0rZdjAS1uQLpqRM5Ab?=
 =?iso-8859-1?Q?y4PcRKNQeMrqZKk0V2HbMpKX0gKcVMqAgS0pa3WgqPpOsDVq8zXxpUE4k1?=
 =?iso-8859-1?Q?RmKxRFRTd1jngMprbj8YO4GsGpvAg+6qAdxwfuLl9gx0fx/MTkVNObeB1S?=
 =?iso-8859-1?Q?LYXDFxryukAA6RVdCIwL2pj6Sv+84nzxIQGtMAnl6dS1M9R1bqYbnKM3/A?=
 =?iso-8859-1?Q?dLenDjnqP4eXUY7vDOaWgXWmYNycSOomF2sT2+Qn+81HXAFOsvbM/Z385e?=
 =?iso-8859-1?Q?xFJwooKl9Tm6ryvBbxfLS2nyccHQX592rj5qlPgnGw0PhmJDJ1K2pbO5gy?=
 =?iso-8859-1?Q?V+FwsoElZcs5JviEVgHVUTzZS6JyJnR0E1rxvHmG/kropMQaeO8sgcW4/K?=
 =?iso-8859-1?Q?AHp9mrKryEzIojJoIP1la/CWWBQcsbNQL85vEsh/FsVBkJ8HnszstYJABS?=
 =?iso-8859-1?Q?18YCVbFsN1UcB/FZtzc4AV2hqS/L0Nlrgeh0eE4E543N/p7HuTPD8Goich?=
 =?iso-8859-1?Q?fOHEb7XlYWbxoW9ESfmH+LOzY9c15dNHT/7FSAcyP88YHvsu8vH8YUJsVp?=
 =?iso-8859-1?Q?MSsoP+aswjgCqJ0F8x/O6O3tc9IYeK9lg0R3tm9MYenxnQ84hyM89esw?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a2e8a0-07d5-40ee-b176-08dd50e8d3c9
X-MS-Exchange-CrossTenant-AuthSource: DU7PR04MB11163.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 13:25:07.3757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzTL8YIBScRsE3C5H+R/l8oJN3jdRVvWylO9LElWVWr3MVEBVUMdL/OPvjKxIH8VHBGW5aeetgnQflZTU57xAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10841

From: Florin Leotescu <florin.leotescu@nxp.com>

The patch enhances emc2305 driver by adding support for configuring
pwm output and polarity via Device Tree properties.

Signed-off-by: Florin Leotescu <florin.leotescu@nxp.com>
---
 drivers/hwmon/emc2305.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/hwmon/emc2305.c b/drivers/hwmon/emc2305.c
index 5d8fb7526e23..e646221ab65d 100644
--- a/drivers/hwmon/emc2305.c
+++ b/drivers/hwmon/emc2305.c
@@ -23,6 +23,8 @@
 #define EMC2305_TACH_REGS_UNUSE_BITS	3
 #define EMC2305_TACH_CNT_MULTIPLIER	0x02
 #define EMC2305_TACH_RANGE_MIN		480
+#define EMC2305_REG_DRIVE_PWM_OUT_CONFIG 0x2b
+#define EMC2305_REG_POLARITY 0x2a
 
 #define EMC2305_PWM_DUTY2STATE(duty, max_state, pwm_max) \
 	DIV_ROUND_CLOSEST((duty) * (max_state), (pwm_max))
@@ -523,6 +525,8 @@ static int emc2305_probe(struct i2c_client *client)
 	int vendor;
 	int ret;
 	int i;
+	int pwm_polarity;
+	int pwm_output;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
 		return -ENODEV;
@@ -576,6 +580,29 @@ static int emc2305_probe(struct i2c_client *client)
 			return ret;
 	}
 
+	if (!of_property_read_u32(dev->of_node, "pwm_output", &pwm_output)) {
+		dev_dbg(dev, "Configuring pwm output\n");
+		if (pwm_output >= 0 && pwm_output <= ((1 << data->pwm_num) - 1)) {
+			ret = i2c_smbus_write_byte_data(client, EMC2305_REG_DRIVE_PWM_OUT_CONFIG,
+							 pwm_output);
+			if (ret < 0)
+				dev_err(dev, "Failed to configure pwm output, using default\n");
+		} else {
+			dev_err(dev, "Wrong PWM output config provided: %u\n", pwm_output);
+		}
+	}
+
+	if (!of_property_read_u32(dev->of_node, "pwm_polarity", &pwm_polarity)) {
+		dev_dbg(dev, "Configuring pwm polarity\n");
+		if (pwm_polarity >= 0 && pwm_polarity  <= ((1 << data->pwm_num) - 1)) {
+			ret = i2c_smbus_write_byte_data(client, EMC2305_REG_POLARITY, pwm_polarity);
+			if (ret < 0)
+				dev_err(dev, "Failed to configure pwm polarity, using default\n");
+		} else {
+			dev_err(dev, "Wrong PWM polarity config provided: %u\n", pwm_polarity);
+		}
+	}
+
 	for (i = 0; i < data->pwm_num; i++) {
 		ret = i2c_smbus_write_byte_data(client, EMC2305_REG_FAN_MIN_DRIVE(i),
 						data->pwm_min[i]);
-- 
2.34.1


