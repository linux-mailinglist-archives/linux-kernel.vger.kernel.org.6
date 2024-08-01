Return-Path: <linux-kernel+bounces-271906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DA49454C7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 01:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 036CA1C22F71
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 23:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBC714D449;
	Thu,  1 Aug 2024 23:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="g9oxWpYC"
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011025.outbound.protection.outlook.com [52.101.125.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB9E1482E2;
	Thu,  1 Aug 2024 23:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722553799; cv=fail; b=u7+diNIDPHy3Xp6MzwTjIuJkA/FfBYHUygXHV/BIDCnYFH0IIEcOBjBGcfPpjshOVP5PdrMnhZ5hkGgq133Pbshe9uS/qs0/fZTQaLLMTB5XFmzWbhhGA3Btm3jDINTrRFoWVdNPX4XUl6v901ZaDgD/WPDmWSXMISEmier+Y1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722553799; c=relaxed/simple;
	bh=rFpCiiFTvIB1s7nd/RPzwh+Egz2W6sBaP0KetN2wPrU=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=jcq4tUiv40Wvd7IiBf5fJu2bQ3nn+gHGEoMDzTa2D7xwS9LNqqPE5NNGAhyFWoejZfNTRI4aSq+k7RAinMTdjwIn9v3b4n9BYSMQVrDPnWMLuCrJTOu19kyT7siGb8IFG4DFqUjs1EWD0d6B+YN4QnO2vHjzFPr6QbDQn+em2qI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=g9oxWpYC; arc=fail smtp.client-ip=52.101.125.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJqEsh5fsp04kN1zwqaBlVa2PYbsZhIL5Re7/C6xiycMZE97BZGApiESmS4t1L23rhJD7CgvqoumgfsLWnfGgb3FBO5PABziVK6PwRCBeCijaZXYLzBFYwJvf8Wz9+Yv3Bv3c7nso8DcLiWNXhKXsKgkUOxW9QeNuNP8AhXhUF8VCLRm5a3PR4X75KX3whz0dY0nteOvNc70rq+uHN15tDxcSXsJNJGZyEzcYSxd7R4Tt/NR4S5EvwbkBMwDIc+3moonaRyoq2EjEAzXDd4CyyEQHIHpzVLJikB9pgFo3lQfpDhCw8DGWIsLZRO3nTNYUjWQeuiPzUIyki2RUfXNxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BnWOvlFr75fZNqQ/nZTrJNCAmvYSecrSgp2SnflkIs=;
 b=MlrOS8dVfpa7QfuCkz3aHFkEL6YjUZvYl0RoAP+OTJuZIOqRFMmruHxH6PH5OEeXDzIYv2F1jR9qvrSrDTMs8D/qzU3w+7e/I0gky7ShcrhiJhKBhbNoYVfqJJMvQAVl1Z2daxUkbjoC3qotNlET4/yIDtDqRO0/5vCLRwKc1zqjvAku8EScC7qtkYB0A+GpeskuWtTIBjBioN2LT4v1LjfdaowzLmOG5LlM1r+QfGoYJsB3yb2LHOOAPqcoxoq3lvKKNJYQVLrkDvixoq+1yyJ9X/NLVZqKN8CbpXSzihozrdkQmzTIFGXENPoE4PMy8HgZZ3fHKvWsuukvv54Aiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BnWOvlFr75fZNqQ/nZTrJNCAmvYSecrSgp2SnflkIs=;
 b=g9oxWpYCGgVvZkHiRRIaf9UBheQC8BjKQ9sfc1xER0sx/zSvze3LLGQnAgDpsYnPNjky9XzdqEU4vkLvlTmgX67Po/haORPPyjiBX6CuAwVoZy/DqbOSyaUVZrBuG8SQnGxS73q+LUlIW1v/RoTGqf/8ZpGSLZjJK2/vXLOwhXM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB10906.jpnprd01.prod.outlook.com
 (2603:1096:400:3af::14) by TYCPR01MB6638.jpnprd01.prod.outlook.com
 (2603:1096:400:9b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Thu, 1 Aug
 2024 23:09:52 +0000
Received: from TY3PR01MB10906.jpnprd01.prod.outlook.com
 ([fe80::592:9b7b:ef57:2dd8]) by TY3PR01MB10906.jpnprd01.prod.outlook.com
 ([fe80::592:9b7b:ef57:2dd8%3]) with mapi id 15.20.7828.023; Thu, 1 Aug 2024
 23:09:52 +0000
Message-ID: <87r0b7n8lj.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: Use of_property_read_bool()
In-Reply-To: <20240731191312.1710417-20-robh@kernel.org>
References: <20240731191312.1710417-20-robh@kernel.org>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 1 Aug 2024 23:09:52 +0000
X-ClientProxiedBy: TY2PR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:404:f6::14) To TY3PR01MB10906.jpnprd01.prod.outlook.com
 (2603:1096:400:3af::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB10906:EE_|TYCPR01MB6638:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f5e4b39-f5ce-435e-899b-08dcb27f0ca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PmkZQQ9JXKpeQ7K03omvMh+aC+b+7P8L+dh48hwXY8PDDuTvMclvNy6w/xQK?=
 =?us-ascii?Q?0zMs+mxBU6odv4j4insXblqNTjNBX2XRN5tiFTLg2+wWrViDjmbGGU7D9lfT?=
 =?us-ascii?Q?kA5Sch2YetBsZBUzjUe8Dxw6AtkfIlMESzbu9QAX/BmrBCnBXfg/Q8cE63Ms?=
 =?us-ascii?Q?6QMCoY3BYrKgeYhCPrN1bpybpcL3un7ykaJHIapVnzPPmHDCvA8oBeCR6RQ7?=
 =?us-ascii?Q?UEufpF3GIaK8jNPiP23NpK6KwwkcC5zUqXaiUovFYboX7Qzg4OV3D0I+ey/N?=
 =?us-ascii?Q?EX4meF621EFHsCSOpU0EQYinIbdXP6Dp2ebCayfRM/kSRp7dlivgXqJeGL0G?=
 =?us-ascii?Q?2DdhkQRaBN6WHwvz9LCLRqi5ZnjFK8lCZnNaDFNwGYLsERuh0WWf9iRljQ7K?=
 =?us-ascii?Q?q8OBwxQl5fEhPkkK4HBIliJpu6tI2sCis17DlFh79+SHeGb8xd0emrovMKQU?=
 =?us-ascii?Q?4t6IU+0anN8A/7jI/Rnw/n6GCthhPZ66WjupfSaZPGSSVKfPUUKYYbKC6g9X?=
 =?us-ascii?Q?T70nZPjInejxg4vfNh9afupxLlJwU4HCvMd+wJQ6fM08DMyRWsMco8Ak+GVg?=
 =?us-ascii?Q?ZCJMElrp3mUfJIv9vmWYqX+xxbnZz+/yfPGUPGnJqzdiEWXUQZZO8ITVjVlk?=
 =?us-ascii?Q?WO5USFnW99V7bjiauddBf/3+1vYCWfWknLJynhK5ZAzAk1nB78+V98Q/BDzi?=
 =?us-ascii?Q?SBSGq0Gjb+aLAVdVeeLrx16+gqLekncntLaTGWcpAaApjldnEo6wEEYOgaeQ?=
 =?us-ascii?Q?yXHEL2X9OAapAy9tO011BFGsWA7HP6tF0v/rcX7zoMvPxVN+4TX29Fbz9F/Q?=
 =?us-ascii?Q?XJsmQv4wkjpdPsq1Gse0M7aPGFr2k1yn7MHTswK9KKwJ5rYkX+3CNlyLncvh?=
 =?us-ascii?Q?LEHb9W/lepkqh1VI6mpVUMWWzfam8/mnTnKknsW42fascudG2HreylHkjkj9?=
 =?us-ascii?Q?pOxSACdr+3GVSGMhXiv2PzLPeoh+RdoX7OuV8ugPEPUy/iEvFjZrvClOzvjq?=
 =?us-ascii?Q?oJrtmVs6P7MNOmq+CVKmDVDcaYpD6oTXUTbJ1IFbJelu7zXzCYfegiIjVp1C?=
 =?us-ascii?Q?FgXH84Td/Mvbps1ATg10VQYDWLnbYusS78sX0Uzq/DhWMF2ACrqaulMQY0s9?=
 =?us-ascii?Q?qkr7V5yLDrD0OqQxvSJylrJ2Ns94LhlLUaO9GBqisvyqKSaM7nSmTDLelLVb?=
 =?us-ascii?Q?hG4gviXzvPp9X/rcvJW7NDNrFhRNrrcq0qSnq2TfhprW+dvlbcTpNwu54oPT?=
 =?us-ascii?Q?K9V/s2hwLui/IEkBTcJF9S47VqdEO1xADcqratDsTbzrnjrxKuiMS/+AFdWE?=
 =?us-ascii?Q?SEmtgxgeAiYhlWV2GAxND6xHZYiywYYg/vjqoOaMur0qBL56Bhv7D+DKUuOA?=
 =?us-ascii?Q?DzkWptdko7T+gWUtg8kbNRyMYK8QITvlsebNY6S7CHc/LBnYIA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB10906.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xdp6+4xqz+GWE9g8oHElFb6dlBv4GKahc4R4ntZDuLLlJn9XGwRYobNKR9R6?=
 =?us-ascii?Q?eYYrniEXJgkp5g5YXPw8N6/J0MeG23DhkZAfJTBHpH/it6Tx0Fs27hMHT33A?=
 =?us-ascii?Q?OssxVr+OBuN9RZ0MhaCj8MOrV8kqYKR5Dwc55B64YRjsGTcC8WBcXFT0LLoE?=
 =?us-ascii?Q?XpEwZ7XTO6azZhEx5O73vAYOWlfNgHsEmET49UGeP1IH1CREzFeuSuv7sZmq?=
 =?us-ascii?Q?CtUn47XuDduI6yt/PB+a5gCV6PUlHqVYY9tZ9slurtODeGu75GVQg8GppyQ9?=
 =?us-ascii?Q?En7XH4PTfrV0atvs082+UfoFNIxDxRYf+w5thQ29vqrk2TxItyjIwy1J+Jk4?=
 =?us-ascii?Q?5G+S6qU2N08KCcEjo3QwdwqB8ExiHz+SXL4hDCvMoqxgkE0xlBUcfODYdXmV?=
 =?us-ascii?Q?AXlX2mgsZPayMPFDM4Ex+1rOHK5Hlo6j3GFpxBAkaT/UwxAb0aJ+kJglRRvQ?=
 =?us-ascii?Q?IhKlvhxUgnq+9LAJASDwrSbDec+rGCcBWlSf/9hP+4xcU9f+Evl7kstuaibL?=
 =?us-ascii?Q?bGdNgWRp3dZ8TQhwFa/YRyZqkoNHDIgcZwhDR3RzqGvY8ZKS0hqyKTRWRYd3?=
 =?us-ascii?Q?8WJejqgwdVxDpaNOHbrK5qQjbfzsEiEVRlToUNKioKraamlZLQSeZEnRGplR?=
 =?us-ascii?Q?sEVNE8vqG1Yzzh4xEFkixKfxEoFjit7mL8q5XXMsJJTI9LLmkV6Mrq+5bJmV?=
 =?us-ascii?Q?TuQhZTjwA6P0Gy2/SV/4Ni8TNGe+kpVPV3Sqpb5AmvVhqxwe+ILoYoupoREc?=
 =?us-ascii?Q?dUpT6WRh6ZatajDZxOF7S03xRMmrH8pQoMgNB4npP9Eg01k9kVD53NDc4jJ9?=
 =?us-ascii?Q?66kp3ktGzFOWtVUMwj1/mB71idAkUhA04prRE58dKuB8XwC8uTuLz4+pzFTz?=
 =?us-ascii?Q?cmrZYShrGHb9wWOkscQB2UUPo6a7uARf5+4UoWSD5RGNe22+0lEytaih/0vz?=
 =?us-ascii?Q?QF1z9JqVOYWNwzjUY1iZqqPyph/ZHFPhNQD93BBMZL85mEP6AgOKBcEbfH4o?=
 =?us-ascii?Q?Q7b2CnbwajCpL1j+kuGijWC3IqaiT7eYGrhzUTsJ/djQXD1Lu3Wu9phfWLbD?=
 =?us-ascii?Q?KBG7vPLE9NhoXnnVwrf5w8avXNT54FWANTA3HSV4CbKZFLe9RDDgoHCzfgiS?=
 =?us-ascii?Q?0CXIEdL+iduZiz+hH2YjmtM3gJ7JFmIGV2fY5kZBDwK0S6mq/c/1aGpOwX2F?=
 =?us-ascii?Q?YD3ijJbCPPf/VmE1D+TQhWXML1RAbPAZWahi0Xt9gWsWzqEqQvnvcF/oS7uy?=
 =?us-ascii?Q?uGYRp1oquFRkJhtf7eDKzGw3XNCsnuc6A6KMaC10fMDKt4g2N6o7Dd9tpll0?=
 =?us-ascii?Q?Lsne9rEwQwS2VuxDhzt0quH2HNuQCsz8AI0B1hCPW53H44hF/x0dvBTn0+Ka?=
 =?us-ascii?Q?7EiHGRQpCEMwoQUfmz5GOhbEFEGqSH6UV48o9v1+ISHyv3yfQWRHib7fooSO?=
 =?us-ascii?Q?jA+vb64Hdcf76W5ECN02rsTpkABnLINDDgUF5FAphAj+mmkoR2/jJyWvvRLx?=
 =?us-ascii?Q?sGDAyyaSjsqrQh6gb7TiUrmB7SLAtcGHkuZYalOKHv8mmqR51+e+jXsGrw3Y?=
 =?us-ascii?Q?I0eGty+kANtGm09PMoHlP7ril2EgwOndYI2f+kbOFSR4vhKNfpg8pZI5qJRS?=
 =?us-ascii?Q?7Uj53co1aZoDKdn4DRvrbn8=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5e4b39-f5ce-435e-899b-08dcb27f0ca2
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB10906.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 23:09:52.3376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2dePek/XYsFZdkGY+0b9bac5u2HymTARk9ypZU4teC+wUeEpvNbYHXWFdVJHsFK56j3e9KppBr4uSUWZVScoha98OaNEqF8qXmLsCj8cF4JZbByQ5Zpai/7IWdSN35Kn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6638


Hi

> Use of_property_read_bool() to read boolean properties rather than
> of_get_property(). This is part of a larger effort to remove callers
> of of_get_property() and similar functions. of_get_property() leaks
> the DT property data pointer which is a problem for dynamically
> allocated nodes which may be freed.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thank you for your help !!

Best regards
---
Kuninori Morimoto

