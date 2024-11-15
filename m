Return-Path: <linux-kernel+bounces-410804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD6A9CE127
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6BE21F21E83
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0130B1CEEAA;
	Fri, 15 Nov 2024 14:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZVLD2N/W"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04461CEAD6
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731680584; cv=fail; b=nBHAWI7NstLleDcnK3tRSrEzoV+brTUTGTHxrIs5nea8a+NfE59fxwV4hj/ltBDFwj2MJmhibrd0leXWB4xZ80tLoqE8SBjRiynWDScdQ6D0U5HuSA4O4K8V0DRVNwj9kJOaz1TSMIW2mK/MINWhNKb29ASNZ3mDps7HwDdZFzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731680584; c=relaxed/simple;
	bh=Gk9QwStHkB085hSk3kV5sxGRYBe8/yXdF9pcfo6TGo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PX/VLs63k6It+7xK2z7NIcvA4O8mbMv9I1D0I7Pppd9wef89MWCZx9XAn8iIjlKUesulWUvOIBXYiAy+RW5CEdtnvYsilc7OI6a6Bppgul0eksNeVwpVa88O5CiYQHLMS45vMwszC+uzJtv8ief7G34Wg/3GB4jJ/qvcUYsLE0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZVLD2N/W; arc=fail smtp.client-ip=40.107.22.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AlnmjRXe7y3ArwOjn8anFniGy+fbKehpTreMkXAWVIMy7zANsgGLAW66uEvX8IvmNErkXVkbudjPtQNRTaU3ebk6eF5DVfM/MY3FvXxfSOheW4Z0vieFJr/jJEsAwnayaMfssRoR+61HdI6U/F2ZIB1rw+mMLNbhs17H8KdQwaaanRCauoSaAAc0AmdAV3sLEPhYaMv0s1hIrUR6ZnnwzyD2ko3Mtvbc1fQOkbYEmx39ySc61e0vR+DrdAgvpIzHq/bKp0Z1Eqs3Tq3cDuFABeAn9M7wnP++ZxgX8Qewg+ZITOWlqWkJUfIrvAnkpy3OXNjag4OMrSigxbC1aBdYCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWgMY7WZUvayC2osyABYv36LlCuqOJ+DHWhGmQaIcTk=;
 b=g6mTsLUjl09AOrsEmu50jhq7ZDekBD13cm6JUvQl8F8EZD917+7arPj3AqwWoCP+WLbTYUiP1M7u5Ckj52LXQLU/Y+ZT5QQU3EbWLzi9i3E9Uy+GPKsJ8uUqI5ijMdDxG+qFT4GC1SCPAUWteBPLcFBKssdDrnt20j70orIHpKqLvl7dHhe8bIr9b6tdIb9VHWNynE8dug6aAeCz5YZgrpIXUvlFjydomk6iHEELnI1bnc6gZuASVsU4kvKfKp4VBLZqc9KgjmawrYm0Lwx9xgfKdFdKHKJvvc54xe9KmnhlM3Nl0QXhwTi8eM1+raOJ/VJiX1sWHIrB0+JRpcpTGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWgMY7WZUvayC2osyABYv36LlCuqOJ+DHWhGmQaIcTk=;
 b=ZVLD2N/WQIV8AHH3g4dEuPaJEBcv0CP/XWjPhSo1g6xMOP2QYXv4plBGpcc1W16xKsvwFRE5VkqU+7BN7b1YJUADUdoRASkmNIw+3O0GMxOdiGXmKuvnDrqcBcxuorDUCzqzluwwUNMZMgt7Hl/DfIwhraO3baeecRLXya0ZqIMQF6tcVEpzVhY/ly0DgPzArjNBXnGjabaxH1qjHUmnNms6PG6VoCDk20/Zqrf7LxINP+94SbqVST5KxOAIUPWi4fpt1no1TkuOZkRw4JfYMDxyfQLQTjQvk1cnS2hzclCP2PYg8S/coLIiHksHWbcHwrzMZ2Mo2GKxS6Nq69q7yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com (2603:10a6:20b:42f::6)
 by DB8PR04MB6827.eurprd04.prod.outlook.com (2603:10a6:10:f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 14:22:57 +0000
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e]) by AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e%7]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 14:22:56 +0000
Date: Fri, 15 Nov 2024 16:22:51 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: stuyoder@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Of fsl_mc_allocator_driver_exit
Message-ID: <xly4pttb77ivx24tjd2zhqnrrwvvcdqdgdirvvshb2lugcbdq7@njdg5ogzho7u>
References: <ZzdRhcE2kG5z6NLk@gallifrey>
 <ZzdUE1E7ypErPuSz@gallifrey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzdUE1E7ypErPuSz@gallifrey>
X-ClientProxiedBy: AM0PR06CA0123.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::28) To AS8PR04MB8868.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8868:EE_|DB8PR04MB6827:EE_
X-MS-Office365-Filtering-Correlation-Id: 19beffb0-6335-43fe-052c-08dd0580ffeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sg1REo4mr6FMCx8oIEWHeeHLT/+F+tcwhMbTKM0cyT9R9g+mS1Dnxkm25zQr?=
 =?us-ascii?Q?ZSZ5X/J1bF7ytl35MNuA98dE279aEQoZA0k7zlsIMBI9uR+yaBbEwsXnUwXx?=
 =?us-ascii?Q?X4zA66X11a7wdeLXAFsgnVv1NX2d+55GR1nq4yWmcasOWT8z5sXF3NloAUuU?=
 =?us-ascii?Q?0ceMuLXR8oyvZsUSr9Z7c/6kcb17wPYH/S5cgbEcUZXhFX4w/URaaIfLx2BZ?=
 =?us-ascii?Q?W5IFYTGuf0pP0MIw0hsB0KuClVOfW8PlffidvZRAAKqtX9KIk/NmC8s7wXVz?=
 =?us-ascii?Q?56fcOF3VdxqXrV2E0ZhC6tJelC3YDud7roX0kkDueKkpfX8p7iCfvbz49Dxf?=
 =?us-ascii?Q?9skAh7melOJKGpuTJqdTpSzwkOLDPG8f+KWAOZdftE2g3YErG3lhNYwp2AtB?=
 =?us-ascii?Q?yrD/4g+aWxr38g3Qg3H/adiHPAbm2Fk/k5z1c3Do5uWOOlN7DUyN3rlDoFoz?=
 =?us-ascii?Q?9/ktBmI8FY3t1cN2TY64nYw9dIawEKtCyMnhQVcorzMG6u2SrkZWsU5Lgd6l?=
 =?us-ascii?Q?XSwUcr4PdC1HI8IJndrWqoyanloCPuE/TP+orD16A0UeDehpgOX48imED4/S?=
 =?us-ascii?Q?A2CI2MvjhJvhmVY/OC840U/XtU6TncwDPePPxKXS7kcMzCAvPCfw90vkRXht?=
 =?us-ascii?Q?9OZcccPupT7w9jOyy8w/OjjBHW20kK+GBIQINrQ5kUqRLYLqGvqCttCGesUG?=
 =?us-ascii?Q?F14rkVqfToZRSX6GAkwZy/XB1nMQsiZN0P4W/tDjXh5H7dZdMK6Z0uAnOhYp?=
 =?us-ascii?Q?VkhX85PnCPJwjMgT22lEOgBcdC9jYLUNDWT3zfG5maSXYNomLHNdXYa4XxdF?=
 =?us-ascii?Q?87D62qiZSDcuOGd/gcAA4yYtUR9M1QC7yXoB2IJfVeJIehJP/gYjFUzSPtur?=
 =?us-ascii?Q?HofnvsnHFMky7h6d28BstesbkWyp9alqKnwzXO3V/kQZBgyflMbX3W6cOmZ0?=
 =?us-ascii?Q?iTDLIF7vplWSc0s3/2eAc3FvlhtJzsR/juyh6eKdBRYlnYGZ4BsbuauDkuWr?=
 =?us-ascii?Q?mv5q4fpBrhX2G13a07rZskdYHhbbF99AiF2srGHNoFivVvgzkVQB0xdbrX8c?=
 =?us-ascii?Q?ABguY4XI4sDeOh4Fl3MOQlxqTwA//2imMlPR6WnT/lExSnFACbuFQLAUw6u1?=
 =?us-ascii?Q?gY2hX1QVFSEV1v+y+J66gqpYBpPS5UIu6kNyrfXgzIU45xE11lJ3FpCuP7UE?=
 =?us-ascii?Q?7qcgyOzlQ/j+EX+4VjT+Dr9HNzkeJGyWweu7BSe9TIsnU0cxhLAK+8BUaNY5?=
 =?us-ascii?Q?G5QU7i5t8yfWsE+R5GwNfjuc6uMjyMf4w55yJTY2qfSNZPuIF+R2fARXqqur?=
 =?us-ascii?Q?iERvHKLvcqvu1V8SqK4Z47hw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8868.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KXAceZdgzS8WCJzIhN22LyuLIXy/hVyhLpSEa8fea6VJ+FF8cC4e8fsN77G7?=
 =?us-ascii?Q?rmW4CwBa7HkenWy9xtvHb/7FEQUq8yAaPddssf35xUVdRABy5BW+bENVU6QO?=
 =?us-ascii?Q?aR4ItBGQvuPH5kOs/0TJtMDUFybFp3WdyVA372kaoa6FkMUkktxGaKf/RXNM?=
 =?us-ascii?Q?Kw06xtSIHZ0QiYjbJ/flh3o/Y/T2JWn6mXp7nOI2fcCp8tYSCPqI55GN37qo?=
 =?us-ascii?Q?LgZqyxKM00I2khK7Qtb+HXSWTNcbfhYehq8THA4br1gACvctLG66ol3gCmW6?=
 =?us-ascii?Q?lIdL8JiiUppe82jxVFfMEZgp4ECZ0UJ9j2k4Jg7WSruWeM/zPLTZyjbDweKM?=
 =?us-ascii?Q?kCS/U7U2S+6HZWgu/7IK0f86eMkVukZjnnSeYSD9YCfMKkG5+zJQzQfWbp57?=
 =?us-ascii?Q?MsO1zd2OVfgfscNGLOh4eyv06vyfKmJ8fPt27ekLgeNApejtUK90MChaeMgi?=
 =?us-ascii?Q?8a9/ws2WVyE/JDive8NvrkfQJmi9qREZ7CD9B7FafodM+isohPFp7AXPLYl3?=
 =?us-ascii?Q?9ouxuE9coYKEnEFH4SzPn9LvXgByvdq/V5GI73ptbo3B+1letSJbbeemoqJc?=
 =?us-ascii?Q?Qm/N1PS9mLuEXh1NxeT0cP/iP0qt7BhrIvy4AvG1xYcuzOIuzqzQsxBx5ojq?=
 =?us-ascii?Q?cAMdJ8N1mYKYO8Y39L1R/LdSEtxs2qSeJaiMfVDtRCSxZi6eaCDHfpPPlsKU?=
 =?us-ascii?Q?ktqQwUjYsgJPDf+4xGl67MjKVbCrFHDcaql2wPB0mgL0SIQENfW4eMk72Tst?=
 =?us-ascii?Q?5NqwhgTDqSyZ+Zlu5ZVk6s2PNCOr0XtNs3VLMCxYAFWmtcLqzyJ6ue/4R8hI?=
 =?us-ascii?Q?3J/cwGee+sxhgVnu0UHg779UkkSN3oFRVQIG1FMVM839Z+yY35Oj+r6CEegg?=
 =?us-ascii?Q?txscwyhOVmw56q94vLEc3s+bvqN+PrJtbhNeWqhk+igJp4w5KTOOikm6NCJE?=
 =?us-ascii?Q?3mofs9/LZGXRDVrA9fhUXSig/gvmhQjmu79NWeYPA4o2BdqkxSFfR82AV3TW?=
 =?us-ascii?Q?mHj6MW8yuEzgzBCup4n3ibwGAGL4eK2YXUKOgDum/opyPTFTgoUvLwWhRavP?=
 =?us-ascii?Q?I/4kjUGBEhMK2Agt1LpeKq/49V6qz1Cpercw2O0WnRuN7HRJzCQ+W8lwMid9?=
 =?us-ascii?Q?7Ec3JcepFFCmF4rIuXAWesYRCDZktitjj2ufuUNR1lHUfhwfzzXNK6fmBKHd?=
 =?us-ascii?Q?eyTdfOpThwXEGLFDKH3+ElCgVLHC900tRNGPB8VUz2QUBW2OQWZN6UHZM67Q?=
 =?us-ascii?Q?mlf+NWgbOrnjQQoh8rT2sZ/O6dQUPzjYtwUH/0vsdL5C4QTT9JFokeaX0E7O?=
 =?us-ascii?Q?3fCAglgZkT+OmYdX+Te6+XskKrdqYGKaZ4eHFIOHoZ1nJ35VxMF1CKg1C+Yc?=
 =?us-ascii?Q?zE3KzHqHT7pkc7gpek1oYGoNb4PJM9aNpJ5DvRUZRSa59rsVWKvWcNWhBChG?=
 =?us-ascii?Q?Um8vcurRqcKLBZ+XieN2B/7WcVZHs1p/759XywHWTxsOSutoM2rtK1YnDh7h?=
 =?us-ascii?Q?8psst7wwAaZOOk8WNh4sH5Z2L52gOhS3FRjbPBNnFWfxZTcS04YC23y0+dOY?=
 =?us-ascii?Q?UAezRTYGeFyUjroUT+16ZOXO9r2PT1k+4SiqRl/f?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19beffb0-6335-43fe-052c-08dd0580ffeb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8868.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 14:22:56.8417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RE/FdoDkT0f+wgBi03KOeIJi3EJ7CRd1XHftGTLXSe0SQr+f6q81iZfARlvBodU9sWEzzqttyzIWrUaoizTn5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6827

> * Dr. David Alan Gilbert (linux@treblig.org) wrote:
> > Hi,
> >   One of my scripts noticed that fsl_mc_allocator_driver_exit()
> > was added explicitly in
> > commit 1e8ac83b6caf ("bus: fsl-mc: add fsl_mc_allocator cleanup function")
> >
> > but appears to be unused; given it's a cleanup function it feels like
> > it should be wired up _somewhere_.
> >

I don't think that fsl_mc_allocator_driver_exit() is of any use at this
point. The entire FSL_MC_BUS can only be built-in which means that there
is no module_exit() which references it.

The same thing is true about the dprc_driver_exit() function.

Ioana


