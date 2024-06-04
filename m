Return-Path: <linux-kernel+bounces-201552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9F38FBFEC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FE641C226FE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0322414D43E;
	Tue,  4 Jun 2024 23:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="NHrFe2KT"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2049.outbound.protection.outlook.com [40.107.114.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C6AA5F;
	Tue,  4 Jun 2024 23:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717544184; cv=fail; b=dxCaQg9NyqVy02alQaeLJyi4CEZVqrk/KSb/j4hBoCWGkVQUt0W5llYtyww1OoXQCvcefFTgbLfKYYskc12adEwV//fNV2c8m60L0knm/+n/seabIi9ljBm7oz/mSGTq4gF8IzUcso8ojVNi7z4pvNafYYMcjk7eXFUofwJ/a00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717544184; c=relaxed/simple;
	bh=nck3ElsswYHozrrqJSa8vxOYNHB/HgHNEQF1APIt7Rs=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=siOKlRnNDuikyGYd00F9sqG6uFxkh2A2BLGGGVu5Q9UjAKStebZ3LJ8r3D25Ue34oc0pXX6BYEqmplOtdXOyfK2LIiDhknHrdZy/3WYncMaP10O3rT8KbkvkDwESuorQqMWH3/OP3Rdld1V9aWD0wE0Pn+dAlGKdzqj93d9WaAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=NHrFe2KT; arc=fail smtp.client-ip=40.107.114.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFwFrPCUpzYuSSbsjjzz3ac/Pkac4vmMwx066qOKvHICxdfYNDZLlilYC6f2n7f9xWrKIGuJjWnCTwOyx8NORJaRTt3rwR521pCmIfgTtyTEEhx6KQRN97zMRkVtEQ+IFnoGdv048JLfPe29MpG0IjEBLVJ0ma6rUlLM0oRg+IWBZXudbVP9/CJUz7x6z5jN5hXvah/Qaf05PM8fzrMo8oqz+xD1WKmU9N1DgRnNCgwkzS178Qmaafq9mOOc63KxKWEDgI/wnrJFKTzrI/CUgl5lrYvtaGxKfS4zkNrzPVHWjOt9Orio/Hz9GEHTDdMVA+poHdn63rypDNPWzAITgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nck3ElsswYHozrrqJSa8vxOYNHB/HgHNEQF1APIt7Rs=;
 b=L+pDvgL+5dzu8wJbrHturkfkllY+KyedJVX3EDypZCTL4zJksWo2WRTgZ2luYQToez2skThrZXPMcj0fPK7dTNF3ENXtu8+xISccGLKav2ZAP/x8WRKIbyvHj7Gcv0AHND6KkJxJWShe4jD3kq2tbOnpngbr4d15eviOQQQtsuHxyBOrwFSuROiZI/2JuNROuA4uNYliEcnFelnlYYQsCCzOV4Dlq8J643f6n2MyNmSvHslTBoFh4bVsraVhxmqfM6Ic06jvAwniE3KbnlRAPB1jSJC8IurgaHAfJ+T/QVZFai+a3e0eRPg4V3tb5RfMqTttrvFYRz2Qi61umwq0JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nck3ElsswYHozrrqJSa8vxOYNHB/HgHNEQF1APIt7Rs=;
 b=NHrFe2KT/efEMd7kG3t90MDncXs0UGtbcQQK44zKt2CUIEQb07tE6ZNeaq38cCerd1gvuiDon8aKjFJoQ3QyKTsi9OQ4xyqQGaFLFzr2wyis8+cEOT67iCEKPu3N7UzDA1tNltPMb2Up/tJs8hmqAm6W6GQHBq8CVS69KeAnNG4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYWPR01MB10304.jpnprd01.prod.outlook.com
 (2603:1096:400:1e1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Tue, 4 Jun
 2024 23:36:17 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 23:36:13 +0000
Message-ID: <87tti8p9gc.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Andrei Simion <andrei.simion@microchip.com>
Cc: <claudiu.beznea@tuxon.dev>,
	<lgirdwood@gmail.com>,
	<broonie@kernel.org>,
	<perex@perex.cz>,
	<tiwai@suse.com>,
	<nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>,
	<alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: atmel: atmel-classd: Re-add dai_link->platform to fix card init
In-Reply-To: <20240604101030.237792-1-andrei.simion@microchip.com>
References: <20240604101030.237792-1-andrei.simion@microchip.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 4 Jun 2024 23:36:12 +0000
X-ClientProxiedBy: TYCPR01CA0190.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::7) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYWPR01MB10304:EE_
X-MS-Office365-Filtering-Correlation-Id: fb54a3b2-af1f-4152-c488-08dc84ef1ede
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|52116005|366007|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JXne/6ZXDu92t3gfPfWfHQkWKBHILn5TyHvAF5Vf4P830qLIYw8n7N2ecPpF?=
 =?us-ascii?Q?Ono8plaD7bVF4zksPIRVYmkyDNWNu8c4I6AT0WoVqYBnGr1qwcV9aeXkv/7z?=
 =?us-ascii?Q?XQrSJ5/YMRifD38A5aOwiECjzLdmoC/UBzfRXQUrXXqQwINElcewKsHVFlnf?=
 =?us-ascii?Q?sgYZBFUA6219N9tfmR+I7F+i4pTkx/baYHxTyh9RjL9MKtrc/5RXhdKxiH0R?=
 =?us-ascii?Q?FKS6hEMSLtU1dKTEO4DjHa4xQTOGOMxAzLCo/a2EQgZsy17gqhAz3VsH7Rlt?=
 =?us-ascii?Q?6ifVdvQJiBp02HU5gJ/Wil6qJhyTEiXxn/qtaIULOIUKbT0QlDyjjXtO06gL?=
 =?us-ascii?Q?j9fI2g89xpDOHUOtPVgPICqVcV+ZFMip4+bn6VhHQWKAlzG5nbWTifF+XZHD?=
 =?us-ascii?Q?PdU2GyJtwI0Et8MK6jCA9gLFpmhvKIvh7snlBEi9cYyasaHVVgGAzZFtygoW?=
 =?us-ascii?Q?WHZ4tRAJ0iyIRBVUcVVnIEuZ+GIk/rq/fHf5tfjrX5scjwbaHYfkYbt+BXt9?=
 =?us-ascii?Q?iK5R5ZmcGhpMRhvJRsCgfEm3eq0C63MkUbAHH7Mwm7pPoaZoyQE0yxpTJ8b9?=
 =?us-ascii?Q?DoCDGXcDy2wr1ap1Xa4b92f0bQ0ifZKpf6Hh9UACnVPTu8aYixCRgFy/DIBn?=
 =?us-ascii?Q?nfLFyEU5fBsDdoCrdRe4K1P/f+zlFhu6vCG9LF7LbsRavgejuTCDNNXRkVDm?=
 =?us-ascii?Q?b+7pXqUGxfl6bxRtpyvLRQvHZ8sYvePuhEODVQpwGdvzLR+O6+3j/MX+BqR1?=
 =?us-ascii?Q?1KfQeKtn3NRBEOSsY32eV3LAR2FdBFuQX5XBJtVrRrP5fi77SyWNjxDCUl1V?=
 =?us-ascii?Q?GFuOeMAm0eWgmvWv+kPRiSSnu/zIk6kJ4iIqb4P9V0INR5OUB8p0l4OcxsyI?=
 =?us-ascii?Q?caApP+LeUG7r4D7e5RwmXvLFDXOQZ51JB2LQqcxlKPBmnxEiDvp3obSWb2Zx?=
 =?us-ascii?Q?rRNIcWyP9CaBj85w+zFL4v0UGrnHbq9A4qZAu58pRTDUeKoV5g/k7m0Nl/Lm?=
 =?us-ascii?Q?6rbfTvK2uyOm73T9rbKsmCXQ/dHI/NBbRQ4dKPmOt/dm6euHbbB3tC6szGlV?=
 =?us-ascii?Q?X+6AV1pqbdVi9RQ8dTTRalLKZfx2BStjJOQhT+BQ8XjcPcdyOJpEwzlQLGGN?=
 =?us-ascii?Q?Nflcl9ub3YeWHP2uJg4qNAHGD2fStlQkc97hmuhKS2CQ5S2ib9dnqf+hBsdB?=
 =?us-ascii?Q?R+pvQGlZE1dKHA981Cvv7fA1S9D2rndBhirwQbbS5iwqs6bLoGzfjIpp+sE3?=
 =?us-ascii?Q?AIKp3HM3BlGh23nGK4RLlioTxR7A/TAEQ+ew5f9xDuc9g52aMWN6ibCHWiGJ?=
 =?us-ascii?Q?PyvrMis1scVv6sOdDG/aVCzP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(52116005)(366007)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eXrs8buvAxGPR4p6oz6HQnK6xU+Qn/gYH8QdoUBfKDilFuwsuzEcjEsdthIO?=
 =?us-ascii?Q?cM1uY+uJR5kTwdUwvoj4jcuSD5CpOrKyTaAmJ/YpKU37kqDIPe0818An9zdp?=
 =?us-ascii?Q?vuHOoG+PFzWrx0fFRIZg2Zo+DGAWlZnT5bSN+FPyM9v0CtfBVS3Clg/VgYoQ?=
 =?us-ascii?Q?9fA/PM02x5EPFORrTSR4P8aL7+LvbQCOujMD1TjM1P4FUi1aiMg3zZhvygdP?=
 =?us-ascii?Q?/7rZVPtGV+bROiaN+HY04cZ3pobbfRIKVcrGAder/nM4dmWAm849pqo0d4k9?=
 =?us-ascii?Q?o7/gQcY6c3xbs+5UdMh2Y7fCqJJvX32MjrCkpa5OG6SBCJst3B53kGDY5IuB?=
 =?us-ascii?Q?qu+2PvFkidL2F2QesflzXSBcqh2W1GfCtxN9JwJooU9DEIydD7zE/KPCOiST?=
 =?us-ascii?Q?pZmKmlRP309w7jU7Zl/x0ZQcC3pCq+PPbr9fc84kh5G+iyX8GJeTkdfj9vse?=
 =?us-ascii?Q?85rku8wRLplFe5uBowyjWYOdNYm81EHHX1az9gAob03WteSzvoNG65Yr+79A?=
 =?us-ascii?Q?t4oHmO36vsDrfzepv3xjeXLEi4oOWrg9D6WbW0UeESWwN47zld4yKvHskh3/?=
 =?us-ascii?Q?pkOXjrLwItsGqN6Lbib2lFugLWAI/K42gvAEvEy4VNHjdfXfEqUA8KZbm577?=
 =?us-ascii?Q?lEDE13agUHTgkq8bPDQaSQ4b4AKrNNbKj3j9zcikecH/eaHpbBnd5qRXCMLt?=
 =?us-ascii?Q?5ZnvVlOGlba2ze8V3sEgwEayMgG6KMOlLOO+qCPSeL/3L+kpxZD9rdHRdiA1?=
 =?us-ascii?Q?i7xZKrOPzOk09+1RzeIzFJnh/hg57qfibj4Uj11GbkAMHSpdoVIOX3AfAYQL?=
 =?us-ascii?Q?1IdXb3nJjLu1CPf4QVv27BU2y7ZQcAKq74xtSjwHXQQV3U8AamYOIz1u1TTq?=
 =?us-ascii?Q?VYGOVyNfw/09L4GDgBGV1YWhEDHIGkO8ydIMcnrRfnwPjcKJfeKJv6771a6g?=
 =?us-ascii?Q?+m16apHYnogrQl2UT3BeNvTcjhdHmgjHBieKw7Z78bUnWW1fwBqUN2ATwqXh?=
 =?us-ascii?Q?j485v4nMJlID+2sLENsg7dLq7V0j7mM42XMAYl1u4Ca41as4B7q5x4b8xeeL?=
 =?us-ascii?Q?YxnCi+Q5ltDOk1wj4mtL0kRkglW6vDRdx0hbjYccGttzX0y+4tTIrqLDZG5m?=
 =?us-ascii?Q?yMmEJjWENkrMO7h9voY06PQ9Jmm54J1KqFkVBDLe1CPMK5So2IsHETrCLHSa?=
 =?us-ascii?Q?5QZof/+LKdJe5J9vGNSEYJXLgDTTXtOUgk/JXAPnfu61lueRIkvcj0R+vv2T?=
 =?us-ascii?Q?NhEWgK/48K450WlJmoLnHfMwg8joxk5w1Iw1NKOUB97WnuyAK5qf2lG1RzIm?=
 =?us-ascii?Q?F4gBgSNbpukjnsFEDIhxFFxxs37IO0kRrfKkopINm6AQ291gbU9WRFpXvcEc?=
 =?us-ascii?Q?6mgpGGXcAn1V92Z2z1O5ruaA9WBQuawqn02z+bySGs0nMKGcyz0Yu2B0xs6D?=
 =?us-ascii?Q?IN05H9QValm9wBi+QmHJFfi+wOt90P2W1UyNfuIyxRV5YqeFnoZQXF0JxgzQ?=
 =?us-ascii?Q?YtHpuyKkXIhurvkY8+MIxJ+ipwbPC/oj0dFnDIVjlTG3Y/IhIgx062ErBQh+?=
 =?us-ascii?Q?D+WUqyifNVupioNFHIlzNgyYLJbURKPWKmIaDOyqjxVcVryTKbsvIjjJverO?=
 =?us-ascii?Q?tDrI1IgaZj8Pzq1T1H9bnXE=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb54a3b2-af1f-4152-c488-08dc84ef1ede
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 23:36:13.1219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ULxc23oxWJBHLltWm3FRSJ8lVnOpxDJb0e2ecIsFATlLFV6vNLLdXuJFFgyR933Cy6yQFF9iA0J2rkplomsnQzIweIuhPejliLDADyEhJWQmj4zt/Azrn3V/fED9Ltv/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10304


Hi Andrei

> The removed dai_link->platform component cause a fail which
> is exposed at runtime. (ex: when a sound tool is used)
> This patch re-adds the dai_link->platform component to have
> a full card registered.

Thank you for the patch, and sorry to bother you by my patch.

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>


I would like to ask for reference. What is this "sound tool" ?
(Is it on userland side ? or Kernel side ?)
And do you know what it will do to dai_link->platform ?

Thank you for your help !!
Best regards
---
Kuninori Morimoto

