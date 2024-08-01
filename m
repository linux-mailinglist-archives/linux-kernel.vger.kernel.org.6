Return-Path: <linux-kernel+bounces-271812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2AC945384
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39320B23828
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A3114B075;
	Thu,  1 Aug 2024 19:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="qlMYCOrU"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2056.outbound.protection.outlook.com [40.107.215.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2540114AD2B;
	Thu,  1 Aug 2024 19:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722541604; cv=fail; b=MEXH+XmNXzaVWcnkCFugFqYzdwPBY+Xh5Q2FAf3dNh2iUviQz2fP6UKsPUH1wj3vl+PQCK33x1gzSo93kQh0GKY/+UyBSf03PcaOxE3+nII9Ui5YDZ4qhQ8s0Mbwz/0TFDTR2/gPytDCCBp+t7/B5JZ5bsr2EKi+jVVvpUQczYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722541604; c=relaxed/simple;
	bh=/g2iM2bGTXTlH3uYJTi7TJiOG5mbSzanfTIDhgDGESA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sUID1WCbPyoyla18gOqZp9fB5vyYHNCa75ft40urXZunXcRJnYjQvYW4dscJQmMPwWzCKGBR2K1rw+nYJRAeZVw4SLSAUM3nqu4434We3QBa7VrLdSkm8avHnsEQ4TpFiokL2Wf4Y9nn/JWTO2hAZUlnQ8kNJqF1UWln47ANxQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=nuvoton.com; dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b=qlMYCOrU; arc=fail smtp.client-ip=40.107.215.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuvoton.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6fZkSWpocDE8EY81dtVT35VvEM07/tDkouposl1uZ1539tU9buy7I/zJzC7cVQfTzQmwGKP9oBgsLWS4eSm0MHZoPGKlDSmyzjCEpTD3VUjKBO7fSx3G8QjH4qdwD8B9grAyZ21ioLEdedhkL3CYgZFLa7AYjkSf8NsXlt89bUN3LCOwy8/jSER5zpIcKYF8NXhoD/RGeDFuO4VZGCsorU0Wa7dMwUcvBHfy2VC+4XD1lmrXUPHEfPIKnR3/XNiVpyGE1cyOvBQXpTH5tX9J8xNiRiqIkOKj73h3Bz5Tj9V7DFL0T2ZeEr27OxZdJ+fZ4kC81XjKLOAgZz6i0+swA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/9CZWCU0OESCuK8UwQ4B85eRO7vRGo4NR7N7TvHhZE=;
 b=EezAKt524jnmKF5RrOgQ/bK2CU16x+OmADCCaovpQp9C+hBrMhNmhY7YL7jQl5/5PDJhmlyeSi6HzlhRvVCIdvrkEPdoERmEKuBiBN2qOBkymUv64pwoZ8pQ2IoXcHlgpyWUA/dyIGglSIqvst+PA3FdvY1UaMPQFw5PMibO6m8S+0+zvnkVv14CYWm9sD5S1gT/yBrzdVGvc79pgo1mjZg0mmdiowEkcu3tZXN73fvx03Ih/8gbn1fl7sZr0evJEQCpwZeBnysi0AO5Wp3EowwUNNx0BcfR5zLQPx8QTCzxXvLTWVxMErn48CO4pIjvjGWygv2/Ob7NJBFwoexUBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 175.98.123.7) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/9CZWCU0OESCuK8UwQ4B85eRO7vRGo4NR7N7TvHhZE=;
 b=qlMYCOrUmHKQeOj2aqiwoXO15FHMue7Pv+GZ3FO2M+N5HtvpXpJx02t6GqPpEwd4zJD1eARQU1jEl27L9p4OCrXjAS/bSeAD1f+SKo0zPkdS+rd9bURUKxDe6ePkKl62Fyptm7XeZMQPvh4WaxTi41MXXr09EENm18kxtixWcfs=
Received: from SI2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::9) by
 KL1PR03MB8307.apcprd03.prod.outlook.com (2603:1096:820:10d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 1 Aug
 2024 19:46:38 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:4:140:cafe::e1) by SI2P153CA0018.outlook.office365.com
 (2603:1096:4:140::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.5 via Frontend
 Transport; Thu, 1 Aug 2024 19:46:38 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 175.98.123.7) smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not
 signed) header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of taln60.nuvoton.co.il: DNS Timeout)
Received: from NTHCCAS02.nuvoton.com (175.98.123.7) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 19:46:36 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 2 Aug
 2024 03:46:35 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 2 Aug 2024 03:46:35 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id E97155F641;
	Thu,  1 Aug 2024 22:46:34 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id D7AD1DC1A05; Thu,  1 Aug 2024 22:46:34 +0300 (IDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <p.zabel@pengutronix.de>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<tali.perry1@gmail.com>, <joel@jms.id.au>, <venture@google.com>,
	<yuenn@google.com>, <benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Tomer Maimon
	<tmaimon77@gmail.com>
Subject: [PATCH v27 0/3] Introduce Nuvoton Arbel NPCM8XX BMC SoC
Date: Thu, 1 Aug 2024 22:46:29 +0300
Message-ID: <20240801194632.742006-1-tmaimon77@gmail.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|KL1PR03MB8307:EE_
X-MS-Office365-Filtering-Correlation-Id: 212a2f66-056b-4d1a-9fc4-08dcb262a75d
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|35950700016|7093399012|48200799018|61400799027|7416014|921020|35450700002;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTlnNm54TFNwRkJZRFR5YW1ZNmZRZ2dPQTdiWjExQ1Fnc1RZRVo5UStFaUc2?=
 =?utf-8?B?SWgxQ1FRdFMvQkM1eGYyWEFlUThOQ1lrbFBZam91aGVCSGFWbHlMOFdpbUk3?=
 =?utf-8?B?cnFEY3ZtM0dsYzdUejN0ZFpNSTVKM0s2czhsSnBRMngrMU9ybWpqd0Q5Zk1j?=
 =?utf-8?B?L2czbzRzLzJuVklnZ0Vlakl4aXYxVnZ2YlNQQ0hYTVFsMzNJUm45ZDlTRmR5?=
 =?utf-8?B?dTRhbk9tYnV6VEpCRm9jYkl2d0lpUGNtVDFqL204TC9UcXR0elYzaHljOEha?=
 =?utf-8?B?Q3Q4azNBNFVuRWhXaU5NQUt6T1hKYkJXZkc5LzdLemhMaTFCZkZ0YmYxYnNn?=
 =?utf-8?B?d09kVzhNWXBlUXo3OU5Ld3VEYVg2NVNSbm1CZlJtMjdLdGYwVUVjVnVnZ2ox?=
 =?utf-8?B?OXZLaWVRd2I1aVZqb0hoT1VvYzFmcmhuQUNMUXV4MFdCTGlCZXJ4d01kNktU?=
 =?utf-8?B?L0wxMVBoNXd6TUhhYmp2TElWeUFUamo3dk1NaFo5SzFOMU51UlJGOGl6c3Zy?=
 =?utf-8?B?RGI5ZDc3aFVGcENiWnNtNTVLZnRGU1BGN2lFOXljbWR0VWcvd0dQdTZRVThB?=
 =?utf-8?B?eDNHQWJQL29OQlA5VGg5b2VLN3JDajVuS0lJY0xGKzJJemwvNFFRaEMvQmdR?=
 =?utf-8?B?TWdaei90a1J0cUdiVDliVWVZZ2tKL2RhVWc0cWJERjlVdFlQdTBBeU1yaVRL?=
 =?utf-8?B?aEtEeDBJamUrWWc0U3BxSUZLZk00RU9QbU1aU1pxNFRSejB6RDVoK25MRDFm?=
 =?utf-8?B?VzhFTW9BV0pyU3lUQm5mM0hUakVBZU9meForWC85L2wwSG5QWWRWeVhSak0r?=
 =?utf-8?B?RHNDbU9SK3Q0Q3ZBWFZ6UHNYZUNIYVdOYWYwcHpVTUM0K09hSUFkeXNHOXhm?=
 =?utf-8?B?MmlicnhsdHNKdDIyYmgzSkYwSmtxRVc3YWoyZGhZWHg0TWxTTFBxUkc2K0xw?=
 =?utf-8?B?UksyQStTOUg1d0lCYXk1ZFUxek4vQ2loa25KUm4wQ3ZQNzIxeUVqeEpOdXp1?=
 =?utf-8?B?cDN6TkE2cmg0bHdMQ3Exd1NnSDRlZkFSb2xxNzk2ankvM3lVMEpwOFhMNjh6?=
 =?utf-8?B?ZDhFTUJaeUdRNTAxWGp0cDhzYVA3RTRxalVuVnpBcVFtWUFsUnd5Q09WMk9X?=
 =?utf-8?B?eFV2cXFETEUvSFdjaUw1VlppWW5oZ2VSYWE3Z21VM2FrbjNmVkxMSTlZZGR2?=
 =?utf-8?B?RmZhNXl5LzBiclNyYjFadDBNbWdzNFNPMnBsUSsvQzliS20xQmpXQVc5RDIz?=
 =?utf-8?B?STlBY0FNVzdrVnRiYWJtMTljMEhEdEY4V2JZQTdKaUFUcUREWS90em9OdzFG?=
 =?utf-8?B?T1NUSFUxT2J1dDNEOC9TcmM5RUhsSXoyOElzUisrM3lqWDdlYXZZZlYrQWNq?=
 =?utf-8?B?YU9yelM2VlljNFFLMW9JZXhMZEpoV3J2aTFJTnFjQUZIR1N1YWd1YzFiZDZ1?=
 =?utf-8?B?Q3R0Q0ZIK1hZdlNRYUF5QzhTb2gxbW5BY0htOHpyb1M4MHllM0pEZTI3a1hM?=
 =?utf-8?B?cmJqdWduWWlRM2RxNUVjQS85b3RHTjBmcDVuWEl2d0hJV2xqWHQxSTR6d2Vu?=
 =?utf-8?B?alRCVnIxQm95SHEyT3F6NXRsVURvYVhKZ3pmS2szWURobTQrVkxid2JrWjNt?=
 =?utf-8?B?NTFxeEdiRFUydWFGL3JXeCtTazh1YmRoSzZnRi9oTC9mL0tJOFlBNkZIQ3Fh?=
 =?utf-8?B?MmI3SlJhRkdWbHJKcmxRbWNLZXlQWmpNWHZob0FjS1FKRnhETUxUNE1pbU9N?=
 =?utf-8?B?VHYvQm9nZFBna1pEQWl5MTJGWTBrRnl3b29ibXBMRTdxb0JpRmtoWUptbzVt?=
 =?utf-8?B?WEFXRjYrc1ZKWTh1VjgyZ3hrN1dYYjdjY1ZTaXhpR0pUUHZKd2NvN0tkVU9P?=
 =?utf-8?B?L2xULzdaMFV1alF2MHJwamJxR25NcGNCeTM4RWhISHVxbHoyVStKNDNCUXY1?=
 =?utf-8?B?VUMwM1dIdUZGZUJXNWhjTU9KNURxZVYyWHIwU3pMTXlLQlBpRmJlTVpLRXNG?=
 =?utf-8?Q?UID0Op1srQ7ZZ1xLxXim9WC+3CVWPc=3D?=
X-Forefront-Antispam-Report:
	CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS02.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230040)(376014)(82310400026)(35950700016)(7093399012)(48200799018)(61400799027)(7416014)(921020)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 19:46:36.3769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 212a2f66-056b-4d1a-9fc4-08dcb262a75d
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS02.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8307

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


