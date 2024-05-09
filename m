Return-Path: <linux-kernel+bounces-174818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5052C8C1564
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 21:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01BC32831CF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 19:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5289D7F7DD;
	Thu,  9 May 2024 19:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="IsRgI2t8"
Received: from SINPR02CU002.outbound.protection.outlook.com (mail-southeastasiaazon11011004.outbound.protection.outlook.com [52.101.133.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37632770E0;
	Thu,  9 May 2024 19:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.133.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715282663; cv=fail; b=X6KMrh3nIF2bNz3SsvYjRaDpp0sB2b06wkGmIbN+vo9pFFNlwp3SEe5bYgxHTJ4YiKyUGQyE3lFPjKEdBzNioxAmCK4GYCau0EOI6uBv9nJPOGMFLImStTIfvenmMdNml79uBbz/KJs6TIjGCuD2+ziZSUy9MvyB7GVewCC56zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715282663; c=relaxed/simple;
	bh=f3AICPkJHghXoSf3Xq1Vd85QBJpOmrETLFw2DGLjm8s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kdx6FwWVPXhZBOXBqDzpfA7gl2SO+9w7VPeHAVIsGgzGPNMRTtPxP18Hnb9Ubc63l49I5UBxIh1PW4GNPIK1zy2WwPjt4gEnK2fFANtyaeJW6/zag5O0PihXReu2O8u4Fqz9YcnwHJrY0sMsys3lmrI9s85+hrbg0bhhsLJDaMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=nuvoton.com; dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b=IsRgI2t8; arc=fail smtp.client-ip=52.101.133.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuvoton.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kw7d6cZ5W1ozhXrubxJpcyY/UfvnKKa/SKPa+UNVPUS7AeTQBPxqL2selbce3GFWy5QbvOw2E3VQdDXigUo3gfNEICIciuzTzEuVx1XlifgdYTB5MzHivDAZoQtHZWryRJIETfHJPMOqy4+lNk/CBDmRmTF0EaWGYcl8JUqTnxN75VtDYu+PDGK4UUAVjJUwI5P6OwMWh1H09npw4Hx/KyCUalSZdaqIPdvueXSTZG37+gO9KF4j/9KNKZmPxyZy5n7UwFzrBcJa+Y72I3H8bhdiBJCHnWQ5VPah0suAZxZdM1YHA1XjRP5GrZvdpM4uAOwzmtEhO5zPvA7wYB7LAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cFkpo0Y7bOA8a3RtwuNGedgKJPHlF4kASLaX98OHIc=;
 b=iVlkiqWEnnG699B1MiX1XIbAY5PoPRxHBxKCtsE7wnXt17qTyIHEPi3KP6YfmWExuvUMjsDw3gEqmf5a4w0MpkMDzGSCGjx+NfYuhm/ZPXKeP/jtDnRCOLzZxLQzi3dg5VzQ/smYm4AVlBVXCbLCs6xNluhzX9ouO1vrAvf4PPMjSR28mV/1UQk1oP8mjFdj36lf7UI7IrSQHY2mbXR+sWgd2fPiekuuxHt1ps/p81hr9jO3t7NcrY1hC9NqFm7+11F0N6bT3k7UWBnl9vK2hdQDr8nFssJdjMyzArh5F9nt6dcZdYAy3aMj2gffZUC2xkEGjj/UD2t/mPR5hIF9lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 175.98.123.7) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cFkpo0Y7bOA8a3RtwuNGedgKJPHlF4kASLaX98OHIc=;
 b=IsRgI2t8bghvNNWj7DoXJsLHClRpfCmbC6cCF1onk14nMZMC/JgmOCFwmuQJ9/PXbBxSqzBjBH2hlcsavhsO64gQ0rOVACxmSJRJ8NcO+PdKh9BcqjiF0hj1vbH/eKn46Tudnoh8fq+/7VGVBrv/SJOE7zFATK5Ls8dUj3/RiHc=
Received: from SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8) by
 TYZPR03MB7291.apcprd03.prod.outlook.com (2603:1096:400:420::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.43; Thu, 9 May 2024 19:24:15 +0000
Received: from SG2PEPF000B66CA.apcprd03.prod.outlook.com
 (2603:1096:4:140:cafe::8) by SI2P153CA0007.outlook.office365.com
 (2603:1096:4:140::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.10 via Frontend
 Transport; Thu, 9 May 2024 19:24:15 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 175.98.123.7) smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not
 signed) header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of taln60.nuvoton.co.il: DNS Timeout)
Received: from NTHCCAS02.nuvoton.com (175.98.123.7) by
 SG2PEPF000B66CA.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 19:24:14 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Fri, 10 May
 2024 03:24:13 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 10 May 2024 03:24:13 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id 932895F66B;
	Thu,  9 May 2024 22:24:12 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id 7A0BBDC0BCE; Thu,  9 May 2024 22:24:12 +0300 (IDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <p.zabel@pengutronix.de>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<tali.perry1@gmail.com>, <joel@jms.id.au>, <venture@google.com>,
	<yuenn@google.com>, <benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Tomer Maimon
	<tmaimon77@gmail.com>
Subject: [PATCH v24 0/4] Introduce Nuvoton Arbel NPCM8XX BMC SoC
Date: Thu, 9 May 2024 22:24:07 +0300
Message-ID: <20240509192411.2432066-1-tmaimon77@gmail.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CA:EE_|TYZPR03MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f584ef8-6041-40e9-20ad-08dc705d9cbb
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|82310400017|7093399003|48200799009|61400799018|35950700004|376005|921011|35450700002;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVhIaTBad09zM1FPSksyZGgwTGVTQWhzcHl1V25rVEMwWEZtZm95RitRU09Q?=
 =?utf-8?B?a0swSU9vL3JDS200ZXNNUXZGVHN2UUFxOHFqb3lDVGNRcmI2Q1dxSWhqaU1j?=
 =?utf-8?B?aThJenpZQ2pjUmljNGNISE9xSjk5ZVdJbjdzRTVjSWpLbTl5Q0VuclFIQlZV?=
 =?utf-8?B?WUExdXA1NEVHeGxaeDloU0d6ZSs2NG9QWEpVTnAxK0x1cVo2Tm1VaUEvZHhm?=
 =?utf-8?B?ek1Ea2JOOUlNaGxud3lWNFlVczVNMExtblhWUnpqRWdHVUR1YTdMY0poTitZ?=
 =?utf-8?B?YXZ0M2c5U0VDWklwSGh0VkR1dXpXT3hBeENrUjZoaWswazcwdVo3OXlmZ2ZK?=
 =?utf-8?B?eXNwaEJrV3FCZENRZ2NVR0NVekYwMHFLZWwxd3VJL01NNUpFZDMwK0ZpbXow?=
 =?utf-8?B?NzdQUENkeFJZd0VEWjVUQTlZZHhuRW0vN3czU2ZiUEI5UUFjUTczdlA4Qndp?=
 =?utf-8?B?dGdpWko5VjZIbHMrZTRnMnQ3d0gzaTMxWklUdmFLVXQ4WVU2aU94Y1ZCK2NE?=
 =?utf-8?B?aWs0REJGUExSU0VUZjhwWGlJK3A1MWRGNjFUc1BZYjhnVm95WHI0Q2g5M1lw?=
 =?utf-8?B?MjdnTm5BczBISGNwWjR0OEtBOENiZGlBUVhkYnhiVG9Bdi9KRVNCeHJ3RjVY?=
 =?utf-8?B?R0hiY2dJTUxDSVF2U0pUNG5Zay8zQnQ0WGlxNUpUZ2JTcVRDTDd4Kzk3b0JJ?=
 =?utf-8?B?QnZSRi8yL2hEM0QyQlF6VUJzSmlvUk5WZnp5bitJNG82T2VHTDY3UWMwamNy?=
 =?utf-8?B?SzlZQmtoVWJ4OVVQU0lPNkJ4T0Q3c3dLTHdzQjMwaTE0b0JrdFFocUtWSnRm?=
 =?utf-8?B?MFgrQm5wZVVtU0p0Q2pSdmpzQVl5WEFqVWZaam56eW5hTVN5ZkYvS0xmcmpN?=
 =?utf-8?B?OVAraVBtM1RPaGYyQUU2UG5BTmVkYVJMYjQ1Sjh2cDZKTWQyQkttbnJwd1pK?=
 =?utf-8?B?R2NhWCtHY1dDOVVjMVdPK0xHaW1KRDU1SlNGTGNrSGJUend2QmVHajBNMVd1?=
 =?utf-8?B?ZCtrNzRpZmpuRTVkTXV3Z3V3U3hZUnFrRVI1aFRGdVRFWjZJSFQwMkphS2ZF?=
 =?utf-8?B?MG8wUXpaRC93N0t0NlNrOWJXNVdKTU5EQUNZL2RIUnNuMG5VY0VLTFFUb1JW?=
 =?utf-8?B?R2ROVGY1RjV4OTBZNGpzK3lScGh4ZUtzcVBuaXJFUi9TcUlaZTZDRHlkcGww?=
 =?utf-8?B?Q1RxVlJvdDd2S3FmVVJjS3ZWc2Fnb3RwWlE5TXdrMllxYmNESld2dUNNZHFF?=
 =?utf-8?B?Uk1zN3pVME43eU1laWoweXhMMUJyVWg4R2R3WURnWVQyam43dlZCTjFWcTlw?=
 =?utf-8?B?UHJJbDNZWFR2Y0oyb1RkeElkcThZa3BQZEp5c1NFT3l5NjFoR3FOT3hEcXlZ?=
 =?utf-8?B?cDhNcEJFeTlrT2RVaExMTjRtYzYyU3NUUU80bzlRNkZmbTVaQk5FVGJuMVNR?=
 =?utf-8?B?bFg1eUh1eHhDcDBLc1hCbk14T05RUFFZMVoyTDRCYUlNOEord2RGc1JyeHps?=
 =?utf-8?B?WEE5TWJ1TEhQRFdoQWxBVlc0STlTUUV2aVcwUG5mSlM1MmsyMEdvbjEvaStL?=
 =?utf-8?B?ak4xVmZVdURDeWlTUFRkYVZ4Q0FHOXlFMEFJNnVHdmdCWHpVV1JMQVVCc0JK?=
 =?utf-8?B?bGJrWW9SYzJmME1ncHZ0V1VxU0picjZwbFZPMjk4WjZ5U1VmZnY1K2F5c0dh?=
 =?utf-8?B?UXZ4R1E0QlArN2FJZUhxWmVKS3lHakVNWWRidHRFTmJTL3FEYWxhSjdBVzJR?=
 =?utf-8?B?amVjYkJGWkZFNlhCQVQ2elcyNnE3ZGkyekxFY1BZOXRqMGhtOFI3L2hoZlJo?=
 =?utf-8?B?NTBvcTRNN0czTTBwMk9jbWRxUFFEeTFVY2FSaTJST0dYeDB5OHFMSml1MVBD?=
 =?utf-8?B?VTNUWG1LTW5WaFVib0YxN2tqWDE5eXMzRk50R1BPZ2hBR1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS02.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(7416005)(82310400017)(7093399003)(48200799009)(61400799018)(35950700004)(376005)(921011)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 19:24:14.2608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f584ef8-6041-40e9-20ad-08dc705d9cbb
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS02.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CA.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7291

This patchset adds clock support for the Nuvoton 
Arbel NPCM8XX Board Management controller (BMC) SoC family.

The NPCM8xx clock controller is created using the auxiliary device framework
and set up in the npcm reset driver since the NPCM8xx clock is using the
same register region.

This patchset cover letter is based from the initial support for NPCM8xx BMC to
keep tracking the version history.

This patchset was tested on the Arbel NPCM8XX evaluation board.

Addressed comments from:
 - Stephen Boyd: https://www.spinics.net/lists/linux-clk/msg96261.html

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

Tomer Maimon (4):
  dt-bindings: reset: npcm: add clock properties
  reset: npcm: register npcm8xx clock auxiliary bus device
  clk: npcm8xx: add clock controller
  dt-binding: clock: remove nuvoton npcm845-clk bindings

 .../bindings/clock/nuvoton,npcm845-clk.yaml   |  49 --
 .../bindings/reset/nuvoton,npcm750-reset.yaml |  18 +
 drivers/clk/Kconfig                           |   8 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-npcm8xx.c                     | 429 ++++++++++++++++++
 drivers/reset/reset-npcm.c                    |  72 ++-
 include/soc/nuvoton/clock-npcm8xx.h           |  16 +
 7 files changed, 543 insertions(+), 50 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
 create mode 100644 drivers/clk/clk-npcm8xx.c
 create mode 100644 include/soc/nuvoton/clock-npcm8xx.h

-- 
2.34.1


