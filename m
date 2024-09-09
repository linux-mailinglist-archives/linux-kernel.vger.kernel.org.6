Return-Path: <linux-kernel+bounces-321266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5CC9716A0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0F41B2540E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D862F11711;
	Mon,  9 Sep 2024 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="F5c9eOhM"
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010015.outbound.protection.outlook.com [52.103.43.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527281B5833;
	Mon,  9 Sep 2024 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725880813; cv=fail; b=a+ZPrZ/FRdruv7KByHX/tssU7K6IcS4I+SiKMkHU/y3off3sG2RUx8jshnX9T4E99jDIykGSm7UiTPSiR4mPodkvKI5ytkG7j4NFyTO+8iIEVJizLgB5asDgW5wlGSML48YH8F96xtfsvPlvI9ynPJzTESEWq4fuPCt5hTaBQss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725880813; c=relaxed/simple;
	bh=uiQnVr6vZNO+O4uAS1PEl8asMcwCSpnnxceII2Q6u1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RtwT6xMQK9B4GgM91xQ7ocxHDNVWIvmFfAOAWvUoNUHdxpE3Momsi+9592hlSKNVXw0bw5N2paMKqN97VblAIS93o+nYRya5Y0CRGqtsNDIfurC/pYCpwpv2avzRWIr4jyV5+q0KBle0pYduETg4HcUkS08xwpDkV8fOTHfH8T8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=F5c9eOhM; arc=fail smtp.client-ip=52.103.43.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZpHMXfcmDE/8dm3/QWvACQT5DDLpl+fPnQZnJEKPXHbd0CqTx9Ofwp458lCU9qd6Ie7uZOlJisbxxicRdqo+It+tHyN+IRl0oiwQaM846qobOxm3f//RMyGUc3EoGHRruLBzCn36r3N1ISqcQPbL6YXwTfM34YCcX53TLv/JfcIdn8qSlEdsEahrChmkyJEzWq0iW1GY7KPOswJ2Dyr258HAU/ao0wWbWg67DQEENpG3RE+2yyiENu4XEFCCp2P1zQVqiuVXZKOFw5oJcXCIfIo39qH6r2M3ooH6eS38kOifsZWOhX29LsPcxM6cnGnfOA4h3Svwtw5ZQY8GOwTLeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nl8/ptXhjIf6utLKi0vGNX1G8ze7uoKwe/9J9vVL4ks=;
 b=UHmmT4v0jNz2RTlaRf4m9bI8MQYxUkrIaN83GvNNVAw7C8yi5qW6A6h2F4vxgJKAOT7pVqZxkbW+AMjInaFH0KPq9rjjR1hab15bsjN+2cuOnMSNwcM+XeeFvC9xBwQxCaYU8nCpDdy/Wt1UZQBaO2XPkkzsZ/F47bF1Bkk4SWh7IFV8FoSGPY3FHupAWnbBoBKn3uahwBelGxAu0jqlwWMIhM/1Uo6E99GxFz7l/BLsjcCz/N/DbGxba9YTaMWdE44yNAE1fqPCliyv2Fue2K46W35AIDcjpbFIMOL2bzxQFhxwesuM1K82mgtnRCeafI7Lrdme/VO0BmZr1b8D6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nl8/ptXhjIf6utLKi0vGNX1G8ze7uoKwe/9J9vVL4ks=;
 b=F5c9eOhMesioXqmsEpeP/R9ls1cDGD1cf0KjMctqKyULWwIlYU1+4E1UH7XZiZDyRn+K8i9YjeWUyHs8xFRH8SCgA0MMNNTFVQmup934rVChwN3Wi4ngEsTuoEOCSEea/7FKUXQ9fPQbhif9cPxlZ5LTMK2dQD3gtRCMqOy57PFejKz6V4kH/Dwsq6lFECCK0cP5elgA41SfHpLfNT2M6J4H3lPGpI8KubaeBsQbSiqiES8W3ueo38PHx27t99jbLEz9e+xAJi7QA5YImq4u2iEex+koCf45MbLGhLVdhSkm6RVYqhTbd6BiMt1RmCzeIgTQe2QQhggVnOWLbj++nA==
Received: from TYAP286MB0746.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:85::11)
 by OS9P286MB5189.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:30a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 11:20:07 +0000
Received: from TYAP286MB0746.JPNP286.PROD.OUTLOOK.COM
 ([fe80::1672:339f:cd51:afdd]) by TYAP286MB0746.JPNP286.PROD.OUTLOOK.COM
 ([fe80::1672:339f:cd51:afdd%7]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 11:20:07 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: sergio.paracuellos@gmail.com
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	tsbogend@alpha.franken.de
Subject: Re: [PATCH] clk: ralink: mtmips: fix clock plan for Ralink SoC RT3883
Date: Mon,  9 Sep 2024 19:17:34 +0800
Message-ID:
 <TYAP286MB07463A0C8ABD8837888C6853BC992@TYAP286MB0746.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240806142902.224164-1-sergio.paracuellos@gmail.com>
References: <20240806142902.224164-1-sergio.paracuellos@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [MjjEMGIXhzlFuFXPzG6nPkBwct2jRAYx]
X-ClientProxiedBy: SG2PR01CA0171.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::27) To TYAP286MB0746.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:85::11)
X-Microsoft-Original-Message-ID:
 <20240909111734.25282-1-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0746:EE_|OS9P286MB5189:EE_
X-MS-Office365-Filtering-Correlation-Id: 0977a1a5-7b4e-4c09-e37f-08dcd0c15bc3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799006|8060799006|5072599009|19110799003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	hoLK6FmEtThfy6Ym7uN0IqqJK/uYs/IOLQBzzHzPIktY/NNF9rYR6XyD9LW2EPQOtV9DUeuFSPa5pysgk6bKTYQn42Z134/vnRnnIlLfdqrh074Clmjh9Tw59m/wT+DY/stXutoYq56GavR6Lvx3FB/x4ONpLpKqDfyQ3Mnik8iJKDneHlv8tbJJuG7mpec8zfs12W3SmqO43dWCsUWZTdicydgd15Tmwy1+h2kqRojWo/XUCXclF4LqvCeVikJ+U/KzG1CfQPo5Zl638ks4m5ql6m6QDlR8JskHTIMSVfMuQ06jcLP/6YAXur1PFgvWHwIXVtD1ZNUGzgHmbezko4ZDOXZdB8adaSZmyBlImRkn9nDvI0GDWXsSizCVzi27nUxzdpbNauL3eNkos0Vw79YsP0xr8UznA0fdkpHgaqIRPIgXlfDasY+fAAILCQLWKTLqWsBqILRyFiU2UgA8YfcqIqyTRlpuzxyJgR/tJOfasoBJ+xElggcE7b2zQUeVL+izptx9g5WjCQBz9bLC3SVqWy3TSM1dG13hPBhsU0QbqpAUILhwOSvnWHHSHq0VLvN1zB+OSrDZICJKICupJu1DtXhWSLVqWEEdj8gpOwvViCeLWmYpqmgEsq157KnJwij8QEJ+KP3FfT7Jmp6efazJ1R9eBFqRkm6xU3avf3D+aPhDlAr3N8ZrYbPyCIx/x/EdjxkFqi5VsYGBDgSGlA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OMu/WLh/AFTwQwPBI37e4qSzRgorE4r8jj66tjqTT5P7IWDDrwEQSaHVfEU0?=
 =?us-ascii?Q?YZ1DfEtpKKP50UIk9Y5AI3ZBj8mSDUoJEskN4O3YIBb+U0sL1zH5dx0I9/RI?=
 =?us-ascii?Q?t/+kEOg3EEhFDBLPbCt/vrd+bnOxXIQ/HkUAw+q7jt7YnaZrAU0zCXOsKDfm?=
 =?us-ascii?Q?g/E7ajb/rkQu27qbaqqGig3rYkX+1kmEDQAjU9Y8hNkpoMctHeeBp/4vB2t4?=
 =?us-ascii?Q?cIE3RAKvS4oXgH6t9IcQqhrR6njH37naSIiBaNApbY3e455iOa9eax9GEOE6?=
 =?us-ascii?Q?FTiPYzwTc/+KTgJ8gjRmb859oleGfrFEwa65GNCPMrSn53/M6L4TFO0c1B1u?=
 =?us-ascii?Q?9mtX6Tv8hPRQf6ZnbEba5jz4eKhWmaRe91lfazO2Vq6CpjcQ/aBxkBjuh7s4?=
 =?us-ascii?Q?3ehEu7PX995+CaqFeUEXq17uwFW1vX4TlHS9MK//WSmNX29hD9UzDxC86lyv?=
 =?us-ascii?Q?5SN0XkmCt0mtJIA85BU+mzLmObXrCCUluezm9oLiLBK6G5qem4UFO2Jvtw2g?=
 =?us-ascii?Q?TItrASEIY90oMibKtuUIAHs2+uubrnFLUXNoH2nK2n2tXCB7bJffd/k/55df?=
 =?us-ascii?Q?BYwCcT7frOWHfqAEWz5qnH+dGtIbK+sMzdBK6umzfuMMqpq3RptK6xTPI+EZ?=
 =?us-ascii?Q?a7tIO6cuwaOK8u6FdN86JZs2xVlLRj383TjNKwe5I4GjdLgaCTdAAbkfG5+F?=
 =?us-ascii?Q?g2E2KxlVBhT34AEtcXTjgFVNEskiWHKnkgdsO3nufQZ6p4hjxqoORm+sN/eP?=
 =?us-ascii?Q?XYfvz2CK4hf4Q6pPPP0FZf/156/4oCXs20/qysR3R2TNcEUeaCwFIn+JpPHo?=
 =?us-ascii?Q?gRKxNf6h9L5nWQQq1JCrL5pNdjMakwfHsRuauJVznivtO4+Bat15J0CvuzOW?=
 =?us-ascii?Q?FQiPp1MgE+v7ihu6sR1doVi3HxkUESVTZ97EtrxMnWAF9bOHdnjnhQPnWxG4?=
 =?us-ascii?Q?3vpeUxp+Yd0OTJIin0lr0y8/xxC2m0je3dl8X8SbShMi4y2li+WAasIPWY2m?=
 =?us-ascii?Q?CdZiF0V8bXuxir5ntNL/HBw6N7fauXc6yXsUHF80XT4zZlDxIKUokcI6J1Ul?=
 =?us-ascii?Q?aUzC/GIWUc1xsRN4IvTMKyUwPxdjAErrF/+LuipADF6AzWjkQX+agRpUHrpI?=
 =?us-ascii?Q?NcbPP0cLdBPfl5ksXmJCSsf54LpURyBy1fmy8F5eA6B1dDUn6e8o/D2hQkUn?=
 =?us-ascii?Q?tCYFOkxtaF9WeeDsaOsrv8DFg5+Tlqct4hmYTAHUBMDC7Ce+VgNnuTCcOtSA?=
 =?us-ascii?Q?cuRyupTyc+ezm7+LcBPZ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0977a1a5-7b4e-4c09-e37f-08dcd0c15bc3
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0746.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 11:20:07.3270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB5189

On Tue,  6 Aug 2024 16:29:02 +0200, Sergio Paracuellos wrote:

>diff --git a/drivers/clk/ralink/clk-mtmips.c b/drivers/clk/ralink/clk-mtmips.c
>index 50a443bf79ec..787ff3e66b34 100644
>--- a/drivers/clk/ralink/clk-mtmips.c
>+++ b/drivers/clk/ralink/clk-mtmips.c
>@@ -267,6 +267,11 @@ static struct mtmips_clk_fixed rt305x_fixed_clocks[] = {
> 	CLK_FIXED("xtal", NULL, 40000000)
> };
> 
>+static struct mtmips_clk_fixed rt3383_fixed_clocks[] = {

Hi! I found a small issue. The SoC name is rt3883 instead of rt3383.

>+	CLK_FIXED("xtal", NULL, 40000000),
>+	CLK_FIXED("periph", "xtal", 40000000)
>+};
>+
> static struct mtmips_clk_fixed rt3352_fixed_clocks[] = {
> 	CLK_FIXED("periph", "xtal", 40000000)
> };
>@@ -779,8 +784,8 @@ static const struct mtmips_clk_data rt3352_clk_data = {
> static const struct mtmips_clk_data rt3883_clk_data = {
> 	.clk_base = rt3883_clks_base,
> 	.num_clk_base = ARRAY_SIZE(rt3883_clks_base),
>-	.clk_fixed = rt305x_fixed_clocks,
>-	.num_clk_fixed = ARRAY_SIZE(rt305x_fixed_clocks),
>+	.clk_fixed = rt3383_fixed_clocks,
>+	.num_clk_fixed = ARRAY_SIZE(rt3383_fixed_clocks),
> 	.clk_factor = NULL,
> 	.num_clk_factor = 0,
> 	.clk_periph = rt5350_pherip_clks,

Regards,
Shiji Yang

