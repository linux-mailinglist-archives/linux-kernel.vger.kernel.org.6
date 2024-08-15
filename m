Return-Path: <linux-kernel+bounces-288178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D419536E5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 684E128CC6E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525981ABEBB;
	Thu, 15 Aug 2024 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="Fd2mP5wZ"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01rlnn2083.outbound.protection.outlook.com [40.95.53.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1D21A4F1C;
	Thu, 15 Aug 2024 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.95.53.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735081; cv=fail; b=bW2/mG2XJBI50T+FJDLZTdCZHdnQEmsn3sC5HhSz7mVJwVVCOVg5CIp7OOseIffhk6JgAm4EYuoEEC+S3qZAn7MfEFuhkozxQRrcb1aQBWRjGGw2rXAErprjFJbrN7aT3yYouI9DxfG1RXkLVFASA6OfGXzF/ZZfwH4b8dXW1Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735081; c=relaxed/simple;
	bh=/g2iM2bGTXTlH3uYJTi7TJiOG5mbSzanfTIDhgDGESA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WFnFzj95yN//z6ZW4zW2ylbfS1808P8kC+gIfaVRCEoDLtbAR8TlXHByuA0tkBgXUCgaPskM8c+bDFod8vhlzP4AJdKsb6rmMUqd8f6LSiDA4pnXSUchtYqErBZvEy4knj0yJs9TkY4phmVZgV794VQLPkiGSSjiL9Q5MGtKkoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=taln60.nuvoton.co.il; dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b=Fd2mP5wZ; arc=fail smtp.client-ip=40.95.53.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=taln60.nuvoton.co.il
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YEG/z5PWBCWoz7gLgX3SCwms6Sb66t1O8+ATqzFbRI5dLbaIOkPHLs/Nbf3rdAZvw24dug3CNirLlahLJJNLBJ/AB5UYJ8kjZStGqELFBxgtOI718Xyx40QJpPEoBPCqY3boG3pvwBrZCyi5Adx9UGyFcq20BCPHUl8UWel//eJnTK664XRhOWJiOadtB4iVB6ZmOJjYNG/heg6sJZocFNbhvTlBjXtj+PyR3irO66y6tQuuP/i6s+9DWHkU5kxmDcI2Pkt2HPRBqFu2xy1QjrJqg7tGNB0wM7qe4DwbGbaHp52KVaoLFWhmiK/OHLKTvU8Tv76fa3XFitd8MPQjmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/9CZWCU0OESCuK8UwQ4B85eRO7vRGo4NR7N7TvHhZE=;
 b=cHNspdFoAqAYFnHWvixH1GJOibJjT5i2/JkaDY/te5PlwgE+QKA9/WHZe51M8afaifkt/J3HgD939CQW7DCGsB7q1+0quP+cO6ajInzqbzN4QWXI9T4ffL64lkR39dcmA0LQ4/lpdo8JOeS3XeS0dFzsMHlrU87RjgBc6QKazU7iYKDqkMFFr8evs+N/6K3wbDjxH2NqzCqTtLBNLiXbbF2mLXmqiU2OpYUdRJJCGis7KUKGKfMhycT4ka7eO+5TpCftf4XCSNGvkMwFozM6npP/Lji/UAcvsaRXb/wWG1o3SZlZzatRNb3hcfJymU6QeydwTJHXeg2YL0OYwlrejQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 211.75.126.7) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/9CZWCU0OESCuK8UwQ4B85eRO7vRGo4NR7N7TvHhZE=;
 b=Fd2mP5wZcdZg3w+Gl3blBB3TvAbNHZJDDymZXk/En6zwbNBZVsThetmE8l8eUrCOnUR5g10k/mYWGIerYI4oRxbVMZFdyIZCJ55bP+RuZaCcQ9VDLBAqejxro/hMKecJWUdVuRWjyqxZyiDtbhXvEO7wO3FYDFuzhQ1fONPM8bA=
Received: from SG2PR02CA0062.apcprd02.prod.outlook.com (2603:1096:4:54::26) by
 JH0PR03MB7465.apcprd03.prod.outlook.com (2603:1096:990:a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.18; Thu, 15 Aug 2024 15:03:00 +0000
Received: from HK2PEPF00006FB3.apcprd02.prod.outlook.com
 (2603:1096:4:54:cafe::e7) by SG2PR02CA0062.outlook.office365.com
 (2603:1096:4:54::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.24 via Frontend
 Transport; Thu, 15 Aug 2024 15:03:00 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 211.75.126.7)
 smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: None (protection.outlook.com: taln60.nuvoton.co.il does not
 designate permitted sender hosts)
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 HK2PEPF00006FB3.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 15:02:58 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 Aug
 2024 23:02:58 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 15 Aug 2024 23:02:58 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id 3C3A35F5D6;
	Thu, 15 Aug 2024 18:02:57 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id 26A7BDC0ACC; Thu, 15 Aug 2024 18:02:57 +0300 (IDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <p.zabel@pengutronix.de>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<tali.perry1@gmail.com>, <joel@jms.id.au>, <venture@google.com>,
	<yuenn@google.com>, <benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Tomer Maimon
	<tmaimon77@gmail.com>
Subject: [PATCH RESEND v27 0/3] Introduce Nuvoton Arbel NPCM8XX BMC SoC
Date: Thu, 15 Aug 2024 18:02:52 +0300
Message-ID: <20240815150255.3996258-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB3:EE_|JH0PR03MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: d3c543ad-2b16-4725-c52b-08dcbd3b59de
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|61400799027|376014|7416014|48200799018|35950700016|7093399012|921020|35450700002;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dW5mK3JFMDU5NG9CSG9HTEc2MisxUXZpcTRPSG40aTJ5bm9acjJ1cnpYNkpN?=
 =?utf-8?B?TVNxRlBjUFRPUk1UcUdYL0hmWWhWMzBEdnNQZS81WktBUkFqY21FTktqT0FV?=
 =?utf-8?B?WTJzNDI1RGFVS0FqSjc1bDNZVGl0U3QrRjBSWnhtbExFZGNKZnJGYVJOVm1t?=
 =?utf-8?B?YUhqYkRFaUdLTTAwakxLaW82c2FnUGRLSEZIaFd5MHc1TERodkxkVGFJQ3lE?=
 =?utf-8?B?dkNmTm5PaXpSdVVId1FJc2tHZEFPaVAwanZuaGQzUUVJRUQ3M0J4b2NLR0JY?=
 =?utf-8?B?Snc2MXc0TE4xMjE4ZWV1cmoyZEdaTCsvSjh0bHVYSmpENkhyUzhKQVdWRTFv?=
 =?utf-8?B?L0p3dVZ5VGtHMGo3V29jRDkxcWpuS1gyVUdXR25qcUh2bGtEUlhQSTBiNE9Z?=
 =?utf-8?B?L21PN3RpZEhwR0pOdndNWHAzSHdiV3h3cXl0YkVGOVZxSzhOQUFGSFFlM3FL?=
 =?utf-8?B?N3Uvd2FGQVVsc3gvaEIyNGpnRmI4aCttdUh3TnppUE5QSkd3MHhjNEdHb2xK?=
 =?utf-8?B?L2xzcXpPQUtwZzF2VVZlZUlka0JvU3JnenVHZ1JYeS90T0UrTjNUbzYyaEEx?=
 =?utf-8?B?WC85aU5BbXM4OGVzN0VYZEtubGhEZUN3UW5UVW9PN1hHODdOOTZyd2xmZTdw?=
 =?utf-8?B?dEtxUTFtcStYRDJjRlpJQ1RWTGNvbGRveXJJY3RuenJVSHVTeFlJeXIyU2FO?=
 =?utf-8?B?K1dQUGY2RWpCTktnZTk5enhnWWxVYWZHejBNMUV2YllqTDNxcWN1R2plalRY?=
 =?utf-8?B?NXRLNHpvRU9hTElPMHE4MVd2cDM1N09nZ0d2ZFlMRUtZeTBuSGU0Y0dQOHdh?=
 =?utf-8?B?VS80M1c4Tlh2YUtLeU9lS09DYVRpODJqNzVVelZhckhuc3NWMTd3MUxGVm41?=
 =?utf-8?B?aXdqUEZRV1Q4dURLVUNVbFA2bFpyQjlkU2VCbXpxdWJlR01HYjlUODN1SlFU?=
 =?utf-8?B?SUl2SFVyWk5ZWTFhZ1krN1VoLy9oZXVlQ08rcGVjSUdCdHV2VGNITTQ0SWpw?=
 =?utf-8?B?bVdhMWl5dkFkVFl6bDhXUWdOdjgrQUNMT0xDTnBOQmx1N2dVMjdRUnIwZks0?=
 =?utf-8?B?ejdFUDU5anptc1FTRWg1ZTRhN0lsM253ZGt4ZVh1MUZ6emJOc1l2c09oZkVX?=
 =?utf-8?B?UkpqSGxpbXQ1V3EzWWYrckJnMzRRSXhybkkybEF5RFVlWC9BRnNONnpmVVRC?=
 =?utf-8?B?U09jOUtwZ1RickFDNzkwZ0cyUFkxR1hJelBnbE81NVNVbXVBU1pHR3VqTEtZ?=
 =?utf-8?B?UGN4aWx6RnVuWUtGQVR5ZEQ2Y3N3bHdBbTNaMHRoS1FDa1R6K0drZTlRSnJv?=
 =?utf-8?B?U2tqOHZ5Z1VoenVYRHNlQnBiRGJmS05weldBVThyUDhHOVRrWGUvUDZGUlRI?=
 =?utf-8?B?anZCcEh4ZHAzVm9Ja1R0NUdsYXRvRlVHY1oxTFpvOW5TZ1ZMaHdVWEhBcm9m?=
 =?utf-8?B?VnV6OXlLc2lkVEpFeHdpRll2M1ppdXA3OTdNZnRaSUZTQUdHTEs3WlNMK3Ux?=
 =?utf-8?B?T3B6enB6VkwvUk90MjdieUlONlpSWFdacnpDblFCS2o4RC9Dc0ZwV1BzcTJm?=
 =?utf-8?B?WDRXeU1iKzVyVWIwRk0vMk1xb1I0K0QrSGZySnYrMlh5cnVEaS9tRWd1TFhq?=
 =?utf-8?B?MTRwVWo2dFB3TW96SFl4cEtwREhqT1k1SkpnY3UvKzNMNWc3OHhIYWZubExB?=
 =?utf-8?B?cys3N2RNM3NWQktQQlBIaXM2bjNvc2NDc1BYTVA4dm90TFg0ZjNVRjVGOUM4?=
 =?utf-8?B?MktTenIxT2tKcytjVUdUZFVqblhsam1rNWt6dUFJK05meVMwKzZlT0plbWVC?=
 =?utf-8?B?azhpVWZmNU5Nems0ZFlra1E3ZHpzSG9paGtRU3ZXWEZmOHZWTHhsY1ZvMzNh?=
 =?utf-8?B?aXJNZ2tIQ09CNG9TS1JrWU9NaVllRVFiWk10Q1V5YXRmdWZqc3duWXdLT1BO?=
 =?utf-8?B?WWVqZnNBUVg4eW9vdVFXWGF6T3Z3NmQveFJPZVVsMUEwYzJpeSttWHRlTlhP?=
 =?utf-8?Q?VOexVVErhySXf7V32fPJYtt6xx4MA4=3D?=
X-Forefront-Antispam-Report:
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(82310400026)(61400799027)(376014)(7416014)(48200799018)(35950700016)(7093399012)(921020)(35450700002);DIR:OUT;SFP:1022;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 15:02:58.7790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c543ad-2b16-4725-c52b-08dcbd3b59de
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7465

This patchset adds clock support for the Nuvoton 
Arbel NPCM8XX Board Management controller (BMC) SoC family.

The NPCM8xx clock controller is created using the auxiliary device framework
and set up in the npcm reset driver since the NPCM8xx clock is using the
same register region.

This patchset cover letter is based from the initial support for NPCM8xx BMC to
keep tracking the version history.

This patchset was tested on the Arbel NPCM8XX evaluation board.

No changes since version 26, only tested in kernel 6.11.rc1

Changes since version 25:
 - Add select AUXILIARY_BUS to npcm_reset kconfig.
 - Include <linux/auxiliary_bus.h> and <linux/slab.h> in reset and clock driver.
 
Changes since version 24:
 - Keep clock npcm8xx dt-binding to avoid ABI break.
 - Fix kfree parameter.
 - Correct reference.
 - Modify commit message.
 
Changes since version 23:
 - NPCM8xx clock controller using the auxiliary device framework.
 - Add NPCM8xx clock controller aux device registration support in npcm reset driver.
 - Remove unused nuvoton,npcm845 clk bindings.
 - Remove all string #define 
 
Changes since version 22:
 - Modify commit message to explain broken ABI in dt-binding
 - Using regmap parenet regmap memory therefore remove use of npcm8xx rst-clock patch.
 - Leave npcm7xx rst node as is
 
Changes since version 21:
 - Since using regmap instead of ioremap replace reg to syscon 
   property in dt-bindings and dts.
 - Add reference clock property to the dt-bindings and dts.
 - Using .index instead of .name in clk_parent_data structures.
 - Using string where any macros are used once.

Changes since version 20:
 - Using regmap instead of ioremap.
   the clock and reset modules are sharing the same memory region 
   and cause failure when using devm_platform_ioremap_resource
   function, this version uses regmap to handle shared 
   reset and clock memory region, in case it is approved I will
   modify the reset driver to use the regmap as well.
 - Using clk_hw instead of clk_parent_data structre.
 - Divider clock definition to one line

Changes since version 19:
 - Remove unnecessary free command.
 - Defining pr_fmt().
 - Using dev_err_probe.
 - Return zero in the end of the probe function.

Changes since version 18:
 - NPCM8XX clock driver did not changed from version 18 only build and tested under kernel 6.6-rc1.

Changes since version 17:
 - NPCM8XX clock driver did not changed from version 17 only build and tested under kernel 6.5-rc3.

Changes since version 16:
 - NPCM8XX clock driver
	- Using devm_kzalloc instead kzalloc.
	- Remove unnecessary parenthesis.
	- Modify incorrect spelling.

Changes since version 15:
 - NPCM8XX clock driver
	- Remove unused regs parameter from npcm8xx_pll_data structure.
	- Using index and clk_hw parameters to set the clock parent in the clock structures.

Changes since version 14:
 - NPCM8XX clock driver
	- Remove unnecessary register definitions.
	- Remove the internal reference clock, instead use the external DT reference clock.
	- rearrange the driver.
	- using .names parameter in DT to define clock (refclk).

Changes since version 13:
 - NPCM8XX clock driver
	- Remove unnecessary definitions and add module.h define
	- Use in clk_parent_data struct.fw_name and .name.
	- Add module_exit function.
	- Add const to divider clock names.
	- Add MODULE_DESCRIPTION and MODULE_LICENSE

Changes since version 12:
 - NPCM8XX clock driver
	- Use clk_parent_data in mux and div clock structure.
	- Add const to mux tables.
	- Using devm_clk_hw_register_fixed_rate function.
	- use only .name clk_parent_data instead .name and .fw_name.
	- Modify mask values in mux clocks. 

Changes since version 11:
 - NPCM8XX clock driver
	- Modify Kconfig help.
	- Modify loop variable to unsigned int.

Changes since version 11:
 - NPCM8XX clock driver
	- Modify Kconfig help.
	- Modify loop variable to unsigned int.

Changes since version 10:
 - NPCM8XX clock driver
	- Fix const warning.

Changes since version 9:
 - NPCM8XX clock driver
	- Move configuration place.
	- Using clk_parent_data instead of parent_name
	- using devm_ioremap instead of ioremap. deeply sorry, I know we had
	 a long discussion on what should the driver use, from other examples 
	 (also in other clock drivers) I see the combination of 
	 platform_get_resource and devm_ioremap are commonly used and it answer
	 the reset and clock needs.

Changes since version 8:
 - NPCM8XX clock driver
	- Move configuration place.
	- Add space before and aftre '{' '}'.
	- Handle devm_of_clk_add_hw_provider function error.

Changes since version 7:
 - NPCM8XX clock driver
	- The clock and reset registers using the same memory region, 
	  due to it the clock driver should claim the ioremap directly 
	  without checking the memory region.

Changes since version 5:
 - NPCM8XX clock driver
	- Remove refclk if devm_of_clk_add_hw_provider function failed.

Changes since version 4:
 - NPCM8XX clock driver
	- Use the same quote in the dt-binding file.

Changes since version 3:
 - NPCM8XX clock driver
	- Rename NPCM8xx clock dt-binding header file.
	- Remove unused structures.
	- Improve Handling the clocks registration.

Changes since version 2:
 - NPCM8XX clock driver
	- Add debug new line.
	- Add 25M fixed rate clock.
	- Remove unused clocks and clock name from dt-binding.

Changes since version 1:
 - NPCM8XX clock driver
	- Modify dt-binding.
	- Remove unsed definition and include.
	- Include alphabetically.
	- Use clock devm.

Tomer Maimon (3):
  dt-bindings: reset: npcm: add clock properties
  reset: npcm: register npcm8xx clock auxiliary bus device
  clk: npcm8xx: add clock controller

 .../bindings/reset/nuvoton,npcm750-reset.yaml |  18 +
 drivers/clk/Kconfig                           |   8 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-npcm8xx.c                     | 430 ++++++++++++++++++
 drivers/reset/Kconfig                         |   1 +
 drivers/reset/reset-npcm.c                    |  74 ++-
 include/soc/nuvoton/clock-npcm8xx.h           |  16 +
 7 files changed, 547 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/clk-npcm8xx.c
 create mode 100755 include/soc/nuvoton/clock-npcm8xx.h

-- 
2.34.1


