Return-Path: <linux-kernel+bounces-238413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E4B924A14
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 23:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB27286B84
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D29205E0F;
	Tue,  2 Jul 2024 21:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="qOsBECss"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01rlnn2060.outbound.protection.outlook.com [40.95.110.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535D21BD512;
	Tue,  2 Jul 2024 21:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.95.110.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957054; cv=fail; b=PXQtzcAhM81nb1fT4fcrRmpATH8hPdSMJnt4GTIwTCi/PdGJbFsz+W4Y+ZFK3r2dLOukmfQYPPSk9eytl0uhjTEwFUybeMeSskik4Baj9MQPeAg8MlXbv4UBSe4j4YMPcJMw3TOcnmhv18ba3WQFCJ82ymdOH9C4JF9cdSjvo2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957054; c=relaxed/simple;
	bh=+nQyyyhkV8SUx9MjRzWLJEKW9ZCxjSNg3cST2SuGfJo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ia3nSfWrCiWwgzOWPBNx52GmYXgCU2WkopZxO3rGnCDiQkQ6st61OhWkz1jx6QWgxpReskPkvUWE0oLPTxSXbkVJaLzvXeeodOIuvX4RKasmkGWnP3UpUEYUWwQq6pJ5thDNtIpDPlmXbTLvz5YKU6LBgIJKKbB5urRe8uyw1ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=taln60.nuvoton.co.il; dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b=qOsBECss; arc=fail smtp.client-ip=40.95.110.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=taln60.nuvoton.co.il
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmu5pVZct6cdBe1WSNxYsNwHVEErj2TLr8x3JwNuqmZOtmxJrumfNmng0XX3XHojV7TYUH7DbKnS+8U8UZc3E4Kcyvxv2+wOLcpRTucE4SHkmD8bYyz7SSfzubKbh4exhr38u6fFKt2DihrlZ1/c378tEemYYH9K463t4ANxGvwmUtE/f8cn2UOAgK8RlvbumrTdTFdii4UWCYMtflZX3SZQ7uTzz7TyzyqXxKFsFiU13Yyj2/DTUQJJGOJDu7qyilerZvX5u947Wrxg72j9NBNKpBn+Zjo7UXkvjD83dFZdgW9D3W1npM5OHh5V46sUAf5Il3/3ozV3X2HSbx9SDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bTaU946f0vzgGk0xWgmVHtu5LXTyNGjLUE2n5Hky18=;
 b=ktajw9FKE8p0+UBuRoz2tNHAK2ljGKnjMgq4LIJ0cJuaeeUAJr0wMGzA36qDI+lluY0uBmIvIy38/JdrWWsxfHAwkhCFvVzFnE1Q0hldQGZOiaGX+pyCS8pVlD4ro32Hl/vok1UJ2q9pLHYSWZtTQkElmEVWkHFTkSSHUbY7REcXSB2jKXjpqGeVTSwVABt3ZVKSFh1R4XjqtlhCTQ32jA7wyXFM2CSQkOGphlCNhk6wF4hxfec3FUSUaoGb0D+JKtx5QMUASxfBJGGLzSoB+ROYvU+G5uC0RucdnGokffgIheVecAmEzjGC5HR7IHFVeNbvX96vpJmXuQxaPejEMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 211.75.126.7) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bTaU946f0vzgGk0xWgmVHtu5LXTyNGjLUE2n5Hky18=;
 b=qOsBECssbO+e0PwoceMqezRMNUEA2RPc0XsSwThjyTGXvKQSbVIGXSd3ls5O9gycXfKAugFixuy6VCRqlnRPLLwiBdNLJNt873haPD50oox5DrJBJwZutdm8s42ycXCF14YDcPrfQqyQ7YC5XfqJnNc1yu4etFnGH3joJiZwHbo=
Received: from SI1PR02CA0016.apcprd02.prod.outlook.com (2603:1096:4:1f4::17)
 by OSQPR03MB8699.apcprd03.prod.outlook.com (2603:1096:604:2a0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Tue, 2 Jul
 2024 19:17:00 +0000
Received: from SG1PEPF000082E7.apcprd02.prod.outlook.com
 (2603:1096:4:1f4:cafe::a7) by SI1PR02CA0016.outlook.office365.com
 (2603:1096:4:1f4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25 via Frontend
 Transport; Tue, 2 Jul 2024 19:17:00 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 211.75.126.7)
 smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: None (protection.outlook.com: taln60.nuvoton.co.il does not
 designate permitted sender hosts)
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG1PEPF000082E7.mail.protection.outlook.com (10.167.240.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Tue, 2 Jul 2024 19:16:58 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 03:16:58 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 3 Jul 2024 03:16:57 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id C4EBD5F67D;
	Tue,  2 Jul 2024 22:16:56 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id B03D3DC0750; Tue,  2 Jul 2024 22:16:56 +0300 (IDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <p.zabel@pengutronix.de>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<tali.perry1@gmail.com>, <joel@jms.id.au>, <venture@google.com>,
	<yuenn@google.com>, <benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Tomer Maimon
	<tmaimon77@gmail.com>
Subject: [PATCH v26 0/3] Introduce Nuvoton Arbel NPCM8XX BMC SoC
Date: Tue, 2 Jul 2024 22:16:47 +0300
Message-ID: <20240702191650.57364-1-tmaimon77@gmail.com>
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
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E7:EE_|OSQPR03MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: 897a095f-1273-4e5f-70cc-08dc9acb8b94
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7093399012|48200799018|7416014|82310400026|376014|35950700016|61400799027|921020|35450700002;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWVuS2JXbkpxekpKTm5sY0MvS2ZOdFpxM0QwQmlSdE05RFhHa29zMm1ac09G?=
 =?utf-8?B?Y2orRHRaWWFENzZGRUgrajJsOG5uamxpakhaMjJaV3I5OHhibkdSNW1uYzlM?=
 =?utf-8?B?YTVPb2JrdGhuVWRMbE5VSEltOFpLUVZHUnN3MVlwL2I4QjBtMWpCOXRvZGhk?=
 =?utf-8?B?UG5uUFRwK3lMVXcxR2QxcjJSa1FoWkM1NWdpTGMyTk95ZEwvS09wY0VDdytl?=
 =?utf-8?B?eG5sMk5QUkQrN1psckpoUW4wVFVRQ1BBSXg0YnNPQkY3TkIyREcxVStTdHpL?=
 =?utf-8?B?aFVScmdjNHYxWEYzVklXU1ozS01zMFBpL1ZjT21HNHloZDUvL0pTQWZrZ05r?=
 =?utf-8?B?NDNYeTQ1S2FTZmJ5MHVIWTk0aVNJcXVkSkJ3ckZLREltd2NRakFQU0U5MXV2?=
 =?utf-8?B?QXJENkNtZmRYK2IybndrN3lpc2h1L2NiMmlYVzdRZENEYUFGRjRrampodFly?=
 =?utf-8?B?K1ovNmlZSHJSL0E5N2NYK2lGMHFkZTd0ZCtyTEI1eGp1VXZDcnVBRGc5WHox?=
 =?utf-8?B?QzM4SDNLWmNaNjZzWEgyUno2Tk93eTA4aEpsc09DdXBDc2RTQ2MwYmdZQ1c3?=
 =?utf-8?B?SmNEU1dFZzFGeVhkRGhjN2pGMjJGR1lUc3ZJUlZCb0lHN0FmdnRyZE5reHU2?=
 =?utf-8?B?TUxIV3ZXWlNhT2R0alN6YWlPQ05Dc0VIVnNXOFhEN3N0Uk03bjE0cnVsdXMz?=
 =?utf-8?B?NEZvdzdsZnFmYjhEME1lZnFreWVHcEhscmlCU1JNdTcyZXJRT2ZNQTJHdmdC?=
 =?utf-8?B?YkZDYUw5Qlh6T29TaVhNM1F4NU5RSnBkUjZaVHFMVG1BZ2pnQnEycmxDUjRC?=
 =?utf-8?B?Z3BtUms5c1lqUXVCbWVjYXlOdVpxYktJckNMVEE2UC9jbUFsQXRMRGwya3lS?=
 =?utf-8?B?RnpQL0dYTExmVVFpU2RRU3FQZEFDTFhMRU1xTStOTnp2TFNmanlRcHRUSzN3?=
 =?utf-8?B?TFRZY201YzFGcHBtUVVkY1E4dElpUVlKM2ovVzNZUjJwVDA3MjRnMVVnUzd6?=
 =?utf-8?B?OWtkSThrblgyQlNqaWowVlU2ejhkQnJBdjArRXBiUFYyWjhwT1gxaGxuU3No?=
 =?utf-8?B?a1Q5MjI1UUo5ZjJzOWtJV1RNa2dyL1pIYVd0bDhYMy9xc2xMOHBvS3I2WTls?=
 =?utf-8?B?dGVaTGdMUjI0cEZRSUczQktrZEJRZk9wSW01Z2lWbXlxSXVVRFJ4eDdZZ1dp?=
 =?utf-8?B?aGZuQTFFaWxaTE5HdWxibWxXUnoyNUJEVVZib0grdldmbEVYcjBmTHFGdDBX?=
 =?utf-8?B?aTBGVjdLc0tIaEJPcHpvTGNBMGE4dm43cjEzY3d1Mm01Ymh5b0FVblZWbEVB?=
 =?utf-8?B?VFZrQWRrQjlFNk1DaTU0RVBvV05BRXZ5WXR1MnhkTHRHTUNYTWx5ZncwMjI0?=
 =?utf-8?B?eHRFRkl1Q0wrYlhwMWx0V0ErbVVSVVFIVXdpcXhqVFVSYXZBUGpsclh4ZWt4?=
 =?utf-8?B?VEFtNFNnNVgrZ3JPbUk4cDdFUG9ndWJ3bzJWdVJQTnF2aDBpRFRtSFBqOXJM?=
 =?utf-8?B?SVE0eGJ0QjU5T0o4T0dRMERTYkdHek9idGF3NTRwT1RIYldKSnI3bjhETk40?=
 =?utf-8?B?SHoyb21vc28yaGswQ0pLVnhTZmloVGdkWVltc1NKY2ZyTnptNjdrS2d0dTQ3?=
 =?utf-8?B?L0VhZ0FGdWVPUjlCR1loV1FvUFBXeHhWWG5qdWpsdTJ6V2NQamwrUFhWY2s2?=
 =?utf-8?B?azFoQ09oZ0RPdmpLeFNrclFDTHF3ZW1tOVlFMzF2MWdhU2VRQVNXQU8xZzdJ?=
 =?utf-8?B?di9YZXZxd3VFTXZvVkRSWG1MKzZEMHRBb2xHcVcrRS90QXhFOXV4bC85bmtj?=
 =?utf-8?B?dDBTTW5hcXpRb0dqY3VEZVd0Tm9oR1NRYlJhbGhFVUpvdzV5dGhTZVVJUFNR?=
 =?utf-8?B?ejhxMEYxeEJYdHhEdThmbnZKSXlWMHYwYmptTUczY1NwVVRsVEFJOVoyc1N1?=
 =?utf-8?Q?CYrhnX/AZDevhbvnF6AvIa06q5j0gDf1?=
X-Forefront-Antispam-Report:
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(7093399012)(48200799018)(7416014)(82310400026)(376014)(35950700016)(61400799027)(921020)(35450700002);DIR:OUT;SFP:1022;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 19:16:58.9630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 897a095f-1273-4e5f-70cc-08dc9acb8b94
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E7.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8699

This patchset adds clock support for the Nuvoton 
Arbel NPCM8XX Board Management controller (BMC) SoC family.

The NPCM8xx clock controller is created using the auxiliary device framework
and set up in the npcm reset driver since the NPCM8xx clock is using the
same register region.

This patchset cover letter is based from the initial support for NPCM8xx BMC to
keep tracking the version history.

This patchset was tested on the Arbel NPCM8XX evaluation board.

Addressed comments from:
 - kernel test robot : https://www.spinics.net/lists/linux-clk/msg100302.html

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
 create mode 100644 include/soc/nuvoton/clock-npcm8xx.h

-- 
2.34.1


