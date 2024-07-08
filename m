Return-Path: <linux-kernel+bounces-244608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425EB92A6C8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96245B21CF2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC52B1465A9;
	Mon,  8 Jul 2024 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="PDMAybxH"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2062.outbound.protection.outlook.com [40.92.19.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C70C145B37;
	Mon,  8 Jul 2024 16:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454714; cv=fail; b=salwziy41hKHm//VHH4jnUiuf7XJIqwOPp6/8zji+RAIME0ct/6HX19DRR0p0JfDrVLgRv2olMcn6owCgH7N8he5k04Gr9vclIqwGSy2an6+DyUoXRkNONTvG46w6VjrMD0/gLKV+MtsRNNWAEPKzqvqHME/AdujOJgL7Ce5N84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454714; c=relaxed/simple;
	bh=72K4Q0Qa2daTiMCo1UQNSnUr/y2IcLNWcEzFWNPJM5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YbD2G30lKDwxJut/aidBx+d2NrT2LczpyMD/6aj75GSSaYOyFn+vCtwPlvihxJSaUuc8hr0j4YGGfRJuDkKKY0TjWrbZZEzqws2LbAGL/vCMCbzN/5LxKPmqquyOWnH9YWiPHf+sDmWsO7nusj1p6dkOi79aAf2cH255XmR1wj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=PDMAybxH; arc=fail smtp.client-ip=40.92.19.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCBSInr57Y65wygVEd5rfq2u4FgxIM+2xQPZrkL1ohixuG1vmILhKK2ViTH1vTK+dUHhMm2izDrFMxhxbIM/SGm9VS/SiRroEP/tw9QHruELieNHjaRjKb0ZoD5DHtGxDCJEolSnc3YDjDTdcpM/Aea0bqN7x5Xlx0bLOR4SPYvIHA6wzlxI0degeleBsl55i0c77OlWHHfeXqIhcEP4dNsWSmZzndT34epbR/66tVbKau0rfZwJD4vyjVIG/sQ5Gtms2e3aRMDaCH8bx8BJXKPGl/fygLqnLBfX6ztUts9CY6VwtBnJuHqf6JrN6idOay/HSC1Gu1ny4fdjoJ9XZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvjVBeqmCmf3mcF/9e25YeswOCAe81gKJ4iTc/beC4w=;
 b=meiMQfHqrx5RFfzbUEG7fAvw3dgC8FQ8Cu+7AXaiEkOVXNJkJggBlhBU6AeLuV6nqCqbjg4U4wp93QVJPXL//vBeX2FGyRBvLjRXTP4VnnUviqQF61lhpACDRtf+dzP6CfBiZ/81F4z5SkB/2RHf/yXbBkQ6pjB/h1uCIPO1nsAzG94v8Bl4/jvbFLx4LfyCxoy8GkyQN6JPj8YLRkhu2VMVjzbLXjr56dIcDcXfXUXVKfx9HbEtULxWA3kTViB5Km9cvpfFCURtA9tKPAEAqaInsnP1trckXlcLCy4y1jfqBmCuCR0BhpL1tBG1a0u3cnS8ChK1WSAjrXaRk4ZajQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvjVBeqmCmf3mcF/9e25YeswOCAe81gKJ4iTc/beC4w=;
 b=PDMAybxHLXmVG7YnWjyfSs60cw1dAkqq51/UOmj9DMNsdi+m9ODtqEBj3s7mY4U7cazDBBRCXnkbnxfA3mehSS9fP2EfI2hOJKIkin8lCE5gyAnqorRckVtAvrqzFbhBrH1X3YMoBAFb+4FOiPAMp4SP2NS1y9J4vSgn+szb6Bnpvq/ZX+odYb/1Llirxk4ujcmEq1IO10JlW5VUTrfJoMA2CtRw7Jg3xEnrmlK9q/86PK/q2996Ncd9ZnEvoDwbQSxgu8cqzwjx92HdXupaMlQW2ZGcRYgcVgrdnP4BXVyQW+ppAVwK+3B9TYXUb/6V0uMMrIBbyJp+54uK7usYGA==
Received: from MN2PR16MB2941.namprd16.prod.outlook.com (2603:10b6:208:e1::15)
 by PH7PR16MB4597.namprd16.prod.outlook.com (2603:10b6:510:139::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 8 Jul
 2024 16:05:09 +0000
Received: from MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490]) by MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 16:05:09 +0000
Date: Mon, 8 Jul 2024 11:05:05 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Maximilian Weigand <mweigand@mweigand.net>,
	Dragan Simic <dsimic@manjaro.org>,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andy Yan <andyshrk@163.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Furkan Kardame <f.kardame@manjaro.org>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	Shengyu Qu <wiagn233@outlook.com>
Subject: Re: arm64: dts: rockchip: Add dma-names to uart-bluetooth rk3566
 devices
Message-ID:
 <MN2PR16MB29416FE9165FB72824266667A5DA2@MN2PR16MB2941.namprd16.prod.outlook.com>
References: <20240705163004.29678-2-didi.debian@cknow.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705163004.29678-2-didi.debian@cknow.org>
X-TMN: [+ChxQEWk9LmHnKIimUhbefbirTxsMlmN2VwdEK9KEF0=]
X-ClientProxiedBy: SN7PR04CA0101.namprd04.prod.outlook.com
 (2603:10b6:806:122::16) To MN2PR16MB2941.namprd16.prod.outlook.com
 (2603:10b6:208:e1::15)
X-Microsoft-Original-Message-ID: <ZowOMULv+jf7VPYa@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR16MB2941:EE_|PH7PR16MB4597:EE_
X-MS-Office365-Filtering-Correlation-Id: 769dff78-b8ae-432b-b9d6-08dc9f67bd37
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|19110799003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	nF/A/+0Y6yzbo+63rEBLQ4rMGz4nSxo7X2BWAqjrRR+cX/+6Vk94Fa9EPkowmnzfssUcm358FPYOlTw1vIItsmS7+W1P9UJ+yDZ0aU8EodUWrQl40in6J+qQM9rv4QALiTBnVk7XrsZ4UNjW72QYFAbu2HpNzSyQ7JP36mluWk+zEhacfiOXRHj6LGjuUwSA7KmBvDS+Zgvyg623O+afidSRxbe12/tA5AnJ9bu4+fc58wVKhiPSz+lhRdKzyGKvSmrubj4udgX0oRqUT71n5u9S4LD4P4bK2NFUeW9UCaOrYTv72vHrwzatzGSbC6J2iVXm4lTNyuU2h9iNh23zudI9+lxxiFLexs6hf5rtFvCJBPSKis9gGRdgghZGvXwBRF0A+Mm8QwYr8W1kstXzKBQEdaycoI0WCV6OoLGXzumVNFofca19C8ZLAP36btSdvON6+A2bpRvwVqZSB8fBsV0QB0iKR4G32zHCmKs/t9nvUqqxp/ZxLIrYza/qv7U68Xi26c9GSe10U9iXT1pS5FfnuMjfiWdLkpMEAWGMmeNcztL0vZ75EU0BgELC31vBAc8kTOSjFD0A0YxO0gQd1Pt4OoBSIFWDRacma23ri5WQfw6GP4ef9OlMgu9J5SHQZaZMd7hGuqfHTG2Sd/PWLA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hZSHS+P+7t3TOMFNW5pbtCA0WqUeI6TUDcer7YTNFPLg8DZ2Av5rbDUtP1Q2?=
 =?us-ascii?Q?sCN4Fvjc/4PlFJEoyorouR48wCZByD7KPrPHHvIQke53//SNWMgkK3/W7FIW?=
 =?us-ascii?Q?Xepzh4RVHo2tZe2lMDQwVCjwoQThBEqndRWOLazHkn19WN6HyZfwSOqCN0LE?=
 =?us-ascii?Q?rSRxzM+Hx4YyZowVfcYMDWriTPhrXXgegmokGMN3szbcVqmLPH0fq+/wGTg9?=
 =?us-ascii?Q?tRvSNUih9JbqVECNVPz7JPfh01vZzxMTnUE8f5W/VyyY3Lrv66UakWz0oggL?=
 =?us-ascii?Q?R6eaJAf0QMRby2lojCtO64jCHZ5X8NbT7ZytShQ1AkTFSwueZkMeHbnEDsPE?=
 =?us-ascii?Q?gLtf46H5tWqRPJ12pzFbJTHN76FTqwmvP2VrZOe10dMSEkzEeaO/JgU0UMSp?=
 =?us-ascii?Q?hI0NSSDqJyamYXSeTumXNhjCWwjvN+3C24Pen2qvxnGweYpz8LH0030pYXnr?=
 =?us-ascii?Q?StllCzfgto2y83zNB4ZUsOoS4sMH1CfqigjE2lxkVEItIMzT/FfPRLlOc11F?=
 =?us-ascii?Q?0et7PUQwwmVVbHrOnRHdwxWb2nFXm3HBh8+AXBewNqxIGL7g3DPhvyeqBwyv?=
 =?us-ascii?Q?GcXabUddnHNbjDKDClHZdzoU4Ub5Ztksp6BWp4AAICkTO/M/DftbmUcHyiKM?=
 =?us-ascii?Q?AAj7xFoU/RPmSHNXAIcuIJeT9Icz8LnLlOsB7G0C31n4Uo2Bl160GeDdmQ8t?=
 =?us-ascii?Q?a3zlFaIfbU1n/7wEhnbfifsoe/RDmD4et+Vlss+pW48mA72RK86j5jMI72z7?=
 =?us-ascii?Q?NEYQFyCWktIax6zKpLyPRDYtnwVKSfBKTyfUTSdCoMrqw007WywItT/gh/b/?=
 =?us-ascii?Q?20JK0xq4y+xo4s0VMr9Bt4FdO+EApbfvd1B8W98kacS9u8KI+6KbD7av6R3t?=
 =?us-ascii?Q?bJ8nmD7NiuSxnGwX1g3LHerzTdKNDUOWtD8pUlZDCqkMAhvdidBwkzlA+kwF?=
 =?us-ascii?Q?Cu7sePIVJGvmet+29TgulB5z9d9L6LsSP80yg8Tk4puT7hs1pG+FlYlhcl71?=
 =?us-ascii?Q?d0O3foZ2AjOEOmSPJ6u5jZ4xqyZ6RcwM0WE07kDB1AVG+P/YyEpvd40rYeIg?=
 =?us-ascii?Q?svMsljELz1SPMZobV1DoA39dx/SJ7hqdRJ6FKLcY//f94EHhpNRewNVkWzxv?=
 =?us-ascii?Q?DCep8d8IYISuC9fsBxo+XsGdB2OT33wY72JAY9zimSFAnJzrXjqOQSIS7Ine?=
 =?us-ascii?Q?V3OQn6VWC6ayy7z0msxrDTnTVxA9RuBpn0ZaW/BM9/lfv/r1VPHg0bbSoOY9?=
 =?us-ascii?Q?fdtDZI7/TZQjkCQsGV3sv6HKJKR/iK8CQ9RDjekzDw=3D=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-559fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 769dff78-b8ae-432b-b9d6-08dc9f67bd37
X-MS-Exchange-CrossTenant-AuthSource: MN2PR16MB2941.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 16:05:09.3778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR16MB4597

On Fri, Jul 05, 2024 at 06:22:12PM +0200, Diederik de Haas wrote:
> This is a single patch which adds the dma-names property to the uart
> node with a bluetooth subnode on Pine64's rk356x devices.
> 
> But that property can potentially be added to several other devices, but
> I have zero familiarity with them or their community, so I choose not to
> add it to those devices, but inform people via this cover letter.

Thank you, but based on past experience the bluetooth failed to work
when I had the DMA names present (which is why I removed them on my
devices). I will however test it again to confirm that is still the
case or not.

> 
> The dts/dtsi files I found as potential candidates are:
> - rk3566-anbernic-rgxx3.dtsi
> - rk3566-box-demo.dts
> - rk3566-powkiddy-rk2023.dtsi
> - rk3566-powkiddy-x55.dts
> - rk3566-radxa-cm3.dtsi
> - rk3566-rock-3c.dts
> - rk3566-roc-pc.dts
> - rk3568-rock-3a.dts

