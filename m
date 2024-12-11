Return-Path: <linux-kernel+bounces-440559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684A19EC0FD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 01:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4442281A0B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 00:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275372BD04;
	Wed, 11 Dec 2024 00:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="F4TMXMRk"
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011009.outbound.protection.outlook.com [52.101.125.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EBE259C;
	Wed, 11 Dec 2024 00:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733877454; cv=fail; b=P3cxK1t1p87KUvc8LIsl+WpBt/B4110hOA2vC+FdQRslN5AwYT+MqMp0lBjGoONLmvRo3K6fFoChgktQWLij4CD8DqtN71ZcyEwGPyzICZsjSF5VSr1H3PRGEflm6R8gVbQc9g6kll2IpWb7eK/5C8ipzSOhSUJ9BQXEJB2hwKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733877454; c=relaxed/simple;
	bh=WLNjGbo8aib0FiptILWPP7G0ezioJktsRpEBa8iyfFo=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=fHFQmnqOe6zl+cdl1XgbL7KqDTxcRUsBFlCrc5JwmUVXH133FESYjK6RHit4g2duy63M1g9CtJHR6/AS3a6UVEYW1E0wYcheq1qHmXt/ftVHgAwYsLbXSUSfxyxtjf4wlr1pmG7wwFpkGhu4aR09f3a/TE+5KUtwCKLGJAY6P3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=F4TMXMRk; arc=fail smtp.client-ip=52.101.125.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9TMY+2t89f3meEz4imtkgmBTYgu9lBoJC8/FwEO18c3gsgg/DTovfNJB4EK7nWu7sFrjCmhUQGkY/RaDVhRah+YOAAy+FeSvu9yBktY7OStfR+UqD0DdL6lBoy6+zz1tfwrFzDN2CqWA6MLak7lW+xHvsA5RsHiQd21jD1AkWwW7Kci/vcyDTd8e42z3F39a4NnEQY+we8BX2VVxyfTkn9kDCJNJD5ATa1HxAiBpXIKwpxaWpRVvwC33qpMRidfiZWQSo6DPTILQ/6lGQexowLYU++k3DqRgM+1s6RcSBZgGq2/9EvsjidO7TB/MLcbTfw1L0nTcbZw+x4NTAzRog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UA99Q2sOGQqFIrX27yvlpIYZKDaAJ6H7AOeg5it6640=;
 b=qwWeDb0yQQtm97FDq4Nh4mvgg5RwhI6V5EWmrLfFNAMeDTcM5Si6EPz4/sO/ZdINjpEjQ+e2VTJnwJlK5tPPmvxN1bCtxlqKZQatQSMAN6KITPNzUkzRt8fbwT0RnFDeprtvdWo1OzM1+riSv0vEHx+AC+/DVwiCtHC+DWGfH6koi2L471Sk/27Z2PbZ9PvO4SrU4L7alwJwRcfUagjdhP/MI00TgJkmififBJ7F4fC/du6vMCxNx7qczKYWep3AmTVkY6k9CXlhUzQSnxT1xpavB5pQX/N+dVMbxBMubFh0AkfamHDXjIcra99r4mH/n23vQannZYaCTeGaF6MyOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UA99Q2sOGQqFIrX27yvlpIYZKDaAJ6H7AOeg5it6640=;
 b=F4TMXMRkwWhhVE/SZC2c8MpQorxavnbR9gXo7EVONSae/QgJk5aC8tgJCdu11hmkm+I/5t8PsX8Y68/cG9mbfDe23pJDJhL67vVJyuMBOeVgAejWW10mTzvBJ91vCKHYjITae72JZhuade/eU+a3pEJGqJ1W7sQuTGe2H9Q8z5Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY3PR01MB10384.jpnprd01.prod.outlook.com
 (2603:1096:400:250::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 11 Dec
 2024 00:37:28 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 00:37:27 +0000
Message-ID: <87r06f6omw.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Stephen Gordon <gordoste@iinet.net.au>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ASoC: audio-graph-card: Call of_node_put() on correct node
In-Reply-To: <20241210033648.4872-1-gordoste@iinet.net.au>
References: <20241210033648.4872-1-gordoste@iinet.net.au>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 11 Dec 2024 00:37:27 +0000
X-ClientProxiedBy: TYWP286CA0033.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::18) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY3PR01MB10384:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c881d61-36e2-4f82-1170-08dd197bfd3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A8j8ojVLaToE2923QtRgAnZoah53tfbC/1iBudyCRqg/kQh0oeWgNRYA0TS9?=
 =?us-ascii?Q?lyMTT3wSH5GCLViZtCXKmEXSLHMH+p38OyHgZGZUWqxPtGCYhc2SjwwuWAt5?=
 =?us-ascii?Q?u/zoAbaIbPI4S1hS5xOs4RrnoCR7E7nY3NnUJWH3Afa4IPt2xXCBy5UPPIz2?=
 =?us-ascii?Q?hZY3m25xAeYky30Vn+eBfn4R+bhuYxTtsJAYN4lRT8JxRx/sPJ3Xb7W+BqS5?=
 =?us-ascii?Q?t/eIV3DjgNuYzc/YJDGL81ULzaISNIuRY5/0OYNxySK9YES2yHLmbHwixstm?=
 =?us-ascii?Q?0sMLpScwysXzEQybIpzO0afpRDfmTijwqC67nihZ+Zx7DS0SDrGjrUVrgs8l?=
 =?us-ascii?Q?0UUjKGJl7FF+4G4QGLclgHEhEVCeqS2hgJ6FP7pezcAPUsaT22RtgBpD5AUG?=
 =?us-ascii?Q?r+GetuhPlaQjGnCZVMavOCQbOA2gW9pivsYXJMNX0vPWUqhyPjsJA3jn8lRD?=
 =?us-ascii?Q?L+Sv/yxCIA8kbLHyhUQIaFK/w/i8+xavgLEBh5oAoXw5qvqLotm4WFuHHcUN?=
 =?us-ascii?Q?+WAGaQ5Dc7/A7935UXJL6MY8hs8+9f+Jb+y1LWiDvnJZoOF/QL6EBwYw4Hjd?=
 =?us-ascii?Q?uEtHTn5dhztWDjtjaG+WnAEOWs/R6lv1j96RXSB5sEfmY1R7EhXCGy05241/?=
 =?us-ascii?Q?wju8uqma58vlDK8NIDZaeTZwjheyfFJjlrkz56SAdCMArRBzQ7fVe5xdDlkt?=
 =?us-ascii?Q?IMrleltaZfA+Oz/W2kzXLN8BF2GZHsociMStR9hBT2DZomTUQxD0n8cTossL?=
 =?us-ascii?Q?v0KpuECm1EHsHU3xo5Luj9z72dKErBJy7lJ+Zv9JKjIsZHeKqxfjrkBlIvlb?=
 =?us-ascii?Q?+rWswCzgX2aykGEcwNd0xk93B3WIQlfIgM3nFzZ4f8DpiOELVBmSCKdaQMOQ?=
 =?us-ascii?Q?Lsm9ddQSVqmITXqURHtE/44BblfIape1fowMi+IdTjHUYnitcVxRuk9M0Llc?=
 =?us-ascii?Q?39pldeoK/px10vTcf5Q5YQkPtofEqgS//b9f+QEFdyL0+2lOyqR0wutRhaaM?=
 =?us-ascii?Q?5zWyuSAe14QDxXXE7vDlDPWhxJ6147ZRa2+TY3q8X1mxTiCOZq5WV3tTdhHy?=
 =?us-ascii?Q?XUgdRwFsi0RBIndVRaiU26L3R7+3Cq+26+6QjCRUQiWxz1mSC4ck93ccFp7p?=
 =?us-ascii?Q?KwlOp/ey/J68tmRdK4FlIiI97aJm1LFgyBCPGzJjGajgjOPWKGBJmz6jusvV?=
 =?us-ascii?Q?w3EfAFqFz/miQw2VM/YQK9EDp/+jCxqq1Fem6t5IotQ8ao7C3OPD4eH3m89z?=
 =?us-ascii?Q?wGuHC+pFI9IoUb59DEgYVLvON9YT8/PmIIEFMl5cbVHawPu+OPxDK2MsLQY0?=
 =?us-ascii?Q?B2vxTxVhqrbfOAjviHLGDnngb1Untb8khrh7PlkQAJcHKmS1KTMVF3275BnR?=
 =?us-ascii?Q?JTQZkdBYMt9wlvhFRIqjqBeIjZLy6O3CFXYklbUbRUG1wa9EZQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wK6M6X8bIQh42B1A9hY0/ddFOAyYXJ53W9j74rLqaCiuaUe5bgbYphounTVg?=
 =?us-ascii?Q?hhgvkrdGhCq2HB2EBlXoTxbolYZ12o5/L8So++Yz5Pfw5h2TIO0tJZANCIg+?=
 =?us-ascii?Q?JjClu/AkWJsQaiY1BV1LHlaC4a4OYNo/oaK5tp9nV4ib05VY0tE8fX9sgmMj?=
 =?us-ascii?Q?LT6PIvQV1IUcfUXasdkyMEtNoUcet4zdVTHdSwX5bfO4ah/9ObAFMdDVHZeh?=
 =?us-ascii?Q?q6/xN3KYrWR1VqSi0scaG7q36j2DjWAi/byLcWTk/F312/RPXLti9kL4vdp9?=
 =?us-ascii?Q?ANNokKgONS9pA0czzEO/5xOuH/JoY0++bx5CjD48bFhMsVQuYptSBe0FC1Ci?=
 =?us-ascii?Q?ope4C6wzJ47j4MAauTB3pQ9iXKxR+8HGoA5E16RfFKsHqJVzZ0qT4jUjeuGq?=
 =?us-ascii?Q?2wW7TOSHe/YORZ8wBieo7cob2u8guzWjqTonBf5033yUlGGI7wfgXA9/eqRa?=
 =?us-ascii?Q?ZRQnlCSpaYCF9WObJADvFY0h8wG6NF/TRTpJRCjFhuUAw8k70bLtkGALnNie?=
 =?us-ascii?Q?Q2E5i47cqh3JGTSU88/K1eODGxqaOtF62XE7sGfUKmvJuD2nfNfnHgK6pySq?=
 =?us-ascii?Q?trN1QfOXPMzOe9OYqyG8jfE27S1q9FRqKsLbFNfUJyoy/5TEeQi4as2E4LI/?=
 =?us-ascii?Q?blckJ+0+p7p0Qx9Uhowu0vlnOglauutTZbr6E+OfRsp109p/a3VbtyAPiFRR?=
 =?us-ascii?Q?rsLUHByDuK74b2YCmo2C3yLEku0oskzXaQfyMy6bt+1pfMAl+i2d3taYNXFq?=
 =?us-ascii?Q?smez+ZEthYnnN3D7NgGYf2uk83gk4UqyEL5c2oCviUyl/vt+6YE+DLOCdwMJ?=
 =?us-ascii?Q?peNhf0uNzXsMyD/FrsyDAxZDHlmaM2Xtd2NL65ffpTIMw3GJiA1FsnoLbW0t?=
 =?us-ascii?Q?TCx8lqIvjXHabEqcT7zAEAcVkKnP9xskLTZp9t4FdltyKY5q0zGhcT3UJ+Jo?=
 =?us-ascii?Q?OUMoQu3GV51M2FqM13STZ+05iud930XGhtd0Q7Uy/4pAsfmk0RG8VXU3n+XQ?=
 =?us-ascii?Q?nrpEGgsCeZdxXN3XnJdc56f1GVoDtx91xLhPGg7RBaaC9ufKUgrHADfXtXF6?=
 =?us-ascii?Q?4h4miNFieQ2XyYosgVmgJj43/Eec28Dys99rn1jj68P1bLAnEt4Cz93zPgwv?=
 =?us-ascii?Q?rfoRIOuRfRndS6xdbdN8Ehxo3qtLgjHJcsT952msBdBEP65NVDVlfDLrA5Wr?=
 =?us-ascii?Q?LWXkPrIrr+m0J2+NNuMDNSSAStnziJkEUXmAxz1mOCB/orSeobqU8pLr8HOH?=
 =?us-ascii?Q?Y5rvUSPEMnEa45WF9uqv+3DqbxEq0phIAWi/3otmNsQ2LYlJ06+CHSu9YGHP?=
 =?us-ascii?Q?+QlQ8++iF1l87LARDKiqoT1YvHvMv7jcAtPA6LAjkFglYxqWTGZv8m/DfHOh?=
 =?us-ascii?Q?MHM1agEIG9YO0kTmva5XMkri+nbGUCpHkPwYoNrecuWHF2GzWc4nSVXrAp6t?=
 =?us-ascii?Q?CoMba9GMj2yLUhLIok4vpqOAUd7I75ykPLadnmNlh8ToAoyXOUh4TI1s0P7n?=
 =?us-ascii?Q?j2tYWR4bbwRIh2MNRwSGXVQpDJ5upIpQS1S04ftkUPGjzsH1XN5msVD8QN6P?=
 =?us-ascii?Q?mPEHDTLz9wiy76APggde/nEI4tPwRT23kOUan2gSL4eJvmBf4T6BTaJCCImU?=
 =?us-ascii?Q?wyWcT1T73Y+bbNN4DTxwie8=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c881d61-36e2-4f82-1170-08dd197bfd3f
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 00:37:27.8324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vb9wcSMqchm3OBLi/FPPxk9Ba0ksha763AgotImdkMaX7YPXFwey+D74MjlhHkSssKSVKcOjzUlMcPEVnWH2W6EnO5f1i/NxYSG9SIMJHEURlTYEYebsdrcDr2KyYYW5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10384


Hi

> A small obvious fix.
> 
> Signed-off-by: Stephen Gordon <gordoste@iinet.net.au>
> ---

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thank you for your help !!

Best regards
---
Kuninori Morimoto

