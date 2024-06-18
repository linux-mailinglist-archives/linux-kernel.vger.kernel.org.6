Return-Path: <linux-kernel+bounces-220249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 225C590DE6F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B979928B145
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F27D1779A5;
	Tue, 18 Jun 2024 21:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="WXrTT0fY"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01rlnn2041.outbound.protection.outlook.com [40.95.53.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A8E13AA44;
	Tue, 18 Jun 2024 21:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.95.53.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718746297; cv=fail; b=PLsIu8EDdcL60p82A8O8lfOiI5BMctWpJMOYBB3gl05jaZ2/jG6oPjb0zQajr1kyFKVs/kSzqNzigkg0hzj+IHvqVJVv926ldBJ7oKn1S0PgeVZurSmK8bdCR2B/3qmpmfllLZoSoCF749874U3r2HyiJCRAtUj/mRXON7fjIzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718746297; c=relaxed/simple;
	bh=6qFE/++LigOwBKplj6LC9fe9PoYblv+LhP+n5dqq/fc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d8mHQruf6GjrPC23pn2VU04gPvPeOXxVCP53kLMQEMGkdxuCMtS6O87fz6BZTltZQP3A7pwW1KmtJUYa/ocJMWgvj/MhPy2PonHX/OOh8neE4+YPkHkJJVyRxG0msErbt5efYZFZ3g3s1RS8DzFZUAMUmxPWXwk/xHKmH8HBeUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=taln60.nuvoton.co.il; dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b=WXrTT0fY; arc=fail smtp.client-ip=40.95.53.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=taln60.nuvoton.co.il
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WX1o8KVBgqqKpLoa0POAYNXwvyuxslqBtFFX5u43c3kA0PleEpshtCsHi6tJqVL5FNAXjVAE5Rroesvr7rDnqqEALzNoENQ/b0NHdACqC2CGeGKvbct8f9uPpfD9jUSDuU+k9gpbTSnvqZ7WoQU8H3Ziw02Yu2ByrbsFRLhkpTEUb9HEcFjB2M1Dv97wTboZxkH+7Dg13ooqFOgWKoUOonEy/0RlJVA82Bxsj1GWtcqiO4G9ROhwaQp5iPZ34XFTSMabvk2jlh/u/xbjk5GC2OnHReceOTAkrJ2n2Ti1EZa1Y+2uBg2T9kBmTKmH8A9/znp0VtMqI++qgJ/8AAnwnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73pqnawXo40W0WI+XDfa64884yldD2V3lr9aqQ3zrD0=;
 b=XjuL33AkJ+T6vaDIhjEXeee2SZkERE887ci5aVbsOQLAijiQJ/2ajDDTKg/w2gGUiGfrVPqVIEzVUIjmvZhHgCytedq3ifls/qQnAf3u4rUMVMeD2P+BnB4qPi4mUPjVB4fYLbbjjlxB3icLxyDivZLz6JmujkKWNTxYkM/8b/7oX7fkPpoIGXOyaBH8LzE5OOTFsRwjSlg5w5S7X+0QLp0bqPgU9+svYtmKTxumLkdygn02gjG8Ai7jWuxVomxwL27IzTWPYpZC9Sa48O4UArfAeOJtEvqdPrSTvpMWTbNRlRAHzDRciz3jG1rEbBaB0+YL+NtCOpTjN9Vq1wGbag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 175.98.123.7) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73pqnawXo40W0WI+XDfa64884yldD2V3lr9aqQ3zrD0=;
 b=WXrTT0fYVs/LkGlwD6SY9GgptXGOX6r7JpFWg2qW0F6kRYkpewvqAsNOsaLlwxPJl3kQ1M+DRVEajoGHr8Sh0Gux1sOEpZv9vU3LNWwGJGmjxUL7WjQXaG37AwVQxUnlhxtDXQFbQT1bhXEwdRBR52wS4PTNzysLgO4Gd9+y/zI=
Received: from PS1PR03CA0018.apcprd03.prod.outlook.com (2603:1096:803:3d::30)
 by SEZPR03MB8816.apcprd03.prod.outlook.com (2603:1096:101:251::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 18:58:25 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:803:3d:cafe::2d) by PS1PR03CA0018.outlook.office365.com
 (2603:1096:803:3d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Tue, 18 Jun 2024 18:58:25 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 175.98.123.7)
 smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: None (protection.outlook.com: taln60.nuvoton.co.il does not
 designate permitted sender hosts)
Received: from NTHCCAS02.nuvoton.com (175.98.123.7) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 18:58:23 +0000
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Jun
 2024 02:58:23 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Jun
 2024 02:58:22 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 19 Jun 2024 02:58:22 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id C970B5F627;
	Tue, 18 Jun 2024 21:58:21 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id B5A55DC0726; Tue, 18 Jun 2024 21:58:21 +0300 (IDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <p.zabel@pengutronix.de>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<tali.perry1@gmail.com>, <joel@jms.id.au>, <venture@google.com>,
	<yuenn@google.com>, <benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Tomer Maimon
	<tmaimon77@gmail.com>
Subject: [PATCH v25 0/3] Introduce Nuvoton Arbel NPCM8XX BMC SoC
Date: Tue, 18 Jun 2024 21:58:16 +0300
Message-ID: <20240618185819.2155595-1-tmaimon77@gmail.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|SEZPR03MB8816:EE_
X-MS-Office365-Filtering-Correlation-Id: 14b36a06-7313-4354-4fb8-08dc8fc8a0ea
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|7093399009|82310400023|61400799024|35950700013|48200799015|921017|35450700002;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ay9XdzJjUWdvcEFTcFVoaWNTYXI3cUJxaXdGRktMTVMzWlZGOHMzV1lBYVRr?=
 =?utf-8?B?SklNa0NibGMzTmhNYlVMVXRDN1ZxZVU1QVRva0MyR041dUUya29OZ2NoMlNn?=
 =?utf-8?B?K3dtNUxrcFN3SkxnMWdZTzFVK1BPNjg4bTBTVkw3ZE5oUDZ2ZWNObHBKWlBE?=
 =?utf-8?B?YkpDRGNXOVdCUlFscVpCTW14bnZxYStwNjdrSER0QzdFdU9aeDQzeVoyM280?=
 =?utf-8?B?TkczVG9tZi9EVTFjMHRHUkdmT2pUQ0dYVk52T0dCNVd0RWNDMGtzYnZuZXZU?=
 =?utf-8?B?bnU3eEZNcWtLQy9BRzhIL0x3enFKUU52MTlkYWFlam9EQnNMSVBDYkNocGxM?=
 =?utf-8?B?RkMvanVMMGhNYklVOHMzaEVmYWlXTjR2aDFPd2E1d1pqTXdrRmw0YjNaTi9Q?=
 =?utf-8?B?KzdCL01nakJOU0N2OGNOQ1pqdzUydVU2clNyRFBtdEVudWR1ZlVieDVIMFhX?=
 =?utf-8?B?MGZ3OWlhQjJYbXpZblV0ajRvbHpaQnJMY0RzYktVd0JXU3c1eCs4ZDhuQ0xj?=
 =?utf-8?B?eHpQeVl3RGFaSnlyN09RYTh1eFRwRWN3RUJZQlBnZ0FXY0xKdVFFYVJWOTdV?=
 =?utf-8?B?SGI2ZGJQWFh6aXVUN2xQUmdteVZSS3d6ZEdYTW9udHlaTElzUlczTVlOczUz?=
 =?utf-8?B?b1B5aUpCbm9FNURtemFiUnViWVVlVTYrdDR5NUtXOFBHeUhtWEN3dmg4d2w1?=
 =?utf-8?B?ZVhHSCtnR1J3QjludzJ0SlpleDVIQ0s0NWdac2hnNngrQkhNcFpSL1h0RHZI?=
 =?utf-8?B?RGNEYlpISm0wMGhzdDJ0RCtWOU0zT3dTY0cvSnh0SVFJZmtlTGR1bmZlS2xV?=
 =?utf-8?B?U0NpTFp4eldBNmlaYkI5Y09sUlQ4NW9KK1hxcFlPMlBsTzE4TkJvQ25VNDNU?=
 =?utf-8?B?c1gwei9FVFVRYktGcEMwbkdQL1NJYlVEOWpnS0VCMUIxZ3FtS0VuTFUwMnlU?=
 =?utf-8?B?THJwK3BQTytXUVA1cnJ4MTFVSEQwMWhxczRvVGlzcTYzVlVaMVU4dUY2dExB?=
 =?utf-8?B?dFNMaitZRmJNQ1RoYVZuNTFZcWMxVEpPbWdmd2oxOVhYS1dsWHgray9yM1hj?=
 =?utf-8?B?VFRLS0VmQ0x5ZEMyOXkwdzB0NWE0bHBVa2JVYm5OQ3RIL2gvbG9NUVF4K1Vn?=
 =?utf-8?B?d2E0QmN1UWYyTmFqRmdJL04zYzVEZWY1anAvZXdOcjQ0WUlUd29pTnNHRkJw?=
 =?utf-8?B?bUlKT0djdTVPM2VYWVpkRXg0alllaHptSDJydzVHT0dtY1gxZmxJcVdERW9K?=
 =?utf-8?B?Q0R4cTZWTG9PMURUZ1kzUHhFbHdBcHErbGlhZVFSc0tncFY4MkorclNoUTRW?=
 =?utf-8?B?eElHVU0wZ2tuRk04elJoakl3Y0ZsellWQnNJOGlKbXJvSlhoaXpVcThSMVpY?=
 =?utf-8?B?aElGQ1lLdG5XUWJmQ1U1ODRwN1p2MzBxTjQyTzhVbWpZNHc1ZEdGSW9jbjNk?=
 =?utf-8?B?OVFCc2J5OElDbzBsc1dxUXI5OStwQTNEYVUySzVVYTRkcWJ5RGNDZHJlK0Ir?=
 =?utf-8?B?czNhZVV6MGtYeENlZkl4Y2VMYzI3TTlxZ25hWElMajdFV2NLQVRlbzBvOEpw?=
 =?utf-8?B?ekhxNkIzaWNOdEQ4VWx4V1lHK0tvUmovT1dFUDZlaFhXSlpYSEwvY3d5WHFa?=
 =?utf-8?B?S2RKZm1lV2JOWGlGbjRqbEZLNmVxejRtWndjTDRMeXFVdGlXUGU1RksxMXo2?=
 =?utf-8?B?aTdlVzZTamxXSWRjZ2p4RWgxSE9XMjN4UTlzUnQwMVNxWTdKNk5TclNVZ3c0?=
 =?utf-8?B?SHFhcG9XeVJ4bmFweUMwSC90V1hRdUxGajh3UFIrK1NkblZBbTVhbDA4amIx?=
 =?utf-8?B?WnpIOWJFaWVIOXdFN0MvWkxMZ0xqNHh0OS8rNkgwSGFUbmdPSzlrT0x1TTZH?=
 =?utf-8?B?VUtvVE15TW9MUzNUUFpkL1dBOWFwcUpWSnNEMHF4QU1BQnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS02.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230037)(376011)(7416011)(7093399009)(82310400023)(61400799024)(35950700013)(48200799015)(921017)(35450700002);DIR:OUT;SFP:1022;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 18:58:23.5240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b36a06-7313-4354-4fb8-08dc8fc8a0ea
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS02.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8816

This patchset adds clock support for the Nuvoton 
Arbel NPCM8XX Board Management controller (BMC) SoC family.

The NPCM8xx clock controller is created using the auxiliary device framework
and set up in the npcm reset driver since the NPCM8xx clock is using the
same register region.

This patchset cover letter is based from the initial support for NPCM8xx BMC to
keep tracking the version history.

This patchset was tested on the Arbel NPCM8XX evaluation board.

Addressed comments from:
 - Rob Herring: https://www.spinics.net/lists/linux-clk/msg99034.html
				https://www.spinics.net/lists/linux-clk/msg99033.html
 - kernel test robot : https://www.spinics.net/lists/linux-clk/msg98970.html

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
 drivers/clk/clk-npcm8xx.c                     | 429 ++++++++++++++++++
 drivers/reset/reset-npcm.c                    |  72 ++-
 include/soc/nuvoton/clock-npcm8xx.h           |  16 +
 6 files changed, 543 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/clk-npcm8xx.c
 create mode 100644 include/soc/nuvoton/clock-npcm8xx.h

-- 
2.34.1


