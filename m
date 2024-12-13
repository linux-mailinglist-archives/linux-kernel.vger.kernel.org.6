Return-Path: <linux-kernel+bounces-444125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FD59F0130
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 01:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEED02827EF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 00:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED354C8F;
	Fri, 13 Dec 2024 00:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="GNUewspX"
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010052.outbound.protection.outlook.com [52.101.228.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C6C1854;
	Fri, 13 Dec 2024 00:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734050416; cv=fail; b=KJsheOzQxZfrGjn2X0pORh6TUPySf7aZfvk1aDsH7tUcjCoe4zlYNDoDhqGU9x+Po7b+7K/GJWdb/vYq6DkWPd66eaByiYdUlhxTUw+ezQAIFd/+qz2PNyRL1xXF5pRbfvSZ12tszUvpY2DgE+6Pq7yDiqtQxqxTrZu/VGX+Fl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734050416; c=relaxed/simple;
	bh=1u5TI6jh6792kpBpLQ8H6PHGKAPLfBQ1n7sGOqTadfA=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=nCXoDlBAcJ7rb2Hxu4UpnPlIto5ih9ct2+pDH6DMzqAp3tiaGxMiRLP9KKGmpAUSkpSKjGiYhNtkbpbf+9ySPqyfat3pptCMnwwVdzvyQWIZZnNdMqcHgJpc8p/OaQwuQIfeqPHNYsgsyjzh6p5cH/ej2yPXZ/bqTN8i3tldFl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=GNUewspX; arc=fail smtp.client-ip=52.101.228.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYAB/DEdxzoPcppESexyASXGXu0H9JogLErx6zFGM2/MN9bPyGJjT9tMDV2UxwEcpdevn8Zo7q3WtNiKGX+gcbxWnfT0F4Zr1nfMTbSHlwOgJqAWPMK65ocsHjxNsR/Gk6dB/Q30nNovX8pHSuCAK8WlirKYCL8/sNGh9kXZfT2SeUMNDbnb/v/p/GuADeI95d7ZONYqunD6oM896MDi1pQ5FvhJ6T8ahzJomxnwbGC5n4mxdktz7NDgDLv7Yf3pKBnPI3oNQUjGa+ANrqIGewy0hE8TlnzDFezoN6x30nxbTYBJaPJbH11HWetzy8PunmuTuiwJdBLCJd0uXP9FCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b97zXbe593hSNySV5bPbs5AKsgT9G6XTgV9fEXsQCn4=;
 b=Z+Jk3L4LmiKjh1JQByNgcqG8/Er0YZOTqPRuaEx0sDPUyOZrFXE7r6H5gZEYAmFQnsZZ541sdRPgImtFtctWUBgNDHRmP0/FUEfpBpN+pzsp8s0uJgWBtuS+IHynwK7Vn7raVvpSVsV0v9ZlWtR4P3iVHlHhtqDjI2VM3FPZr3QsmBAany0jHruqPvJ8L6U/7v+UW4NCOUE8xjO86ipkQr7otfu9ka22MEiJ7BI9pFm0xW3EjxXy/LRMbXYZMSYlolsdukfXyMeVoJXg2wvZvCCKnBSrp+u9QRXQYJChFyBrKY0Pd1Z8le6wfiuN5QW5ht7vS4bOog0CDVRYWPYr6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b97zXbe593hSNySV5bPbs5AKsgT9G6XTgV9fEXsQCn4=;
 b=GNUewspXYr0FwO/LodfgROAcAbZWy+3CCk4N7185pXkPYqsvvvoMPEnPfLFAO3pba9WWjocphA+N2wcODeAIHypxHxkpWfVqsHiZZUuC8rbbZj+CumXT6Nm3NAPnzVMlxwDESijnSNai+pih41sRcGt5lWZ3L70BTfYoZHZG4N8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OSCPR01MB13008.jpnprd01.prod.outlook.com
 (2603:1096:604:336::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 00:40:11 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 00:40:11 +0000
Message-ID: <87cyhw8lg5.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Frank Li <Frank.li@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-sound@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] ASoC: dt-bindings: audio-graph-card2: add widgets and hp-det-gpios support
In-Reply-To: <1fc1f1ae-766d-4266-84ec-11dbd67a608a@gmail.com>
References: <20241113195240.3699-1-laurentiumihalcea111@gmail.com>
	<20241113195240.3699-4-laurentiumihalcea111@gmail.com>
	<ZzUH3n50Vw6RhmNJ@lizhi-Precision-Tower-5810>
	<1fc1f1ae-766d-4266-84ec-11dbd67a608a@gmail.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Fri, 13 Dec 2024 00:40:11 +0000
X-ClientProxiedBy: TYCP301CA0024.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::14) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OSCPR01MB13008:EE_
X-MS-Office365-Filtering-Correlation-Id: 685e3db3-443a-45ec-0b1c-08dd1b0eb380
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ng09GBKiEUYQw8FZrZz92xz7Yp07gyjNbH0Z956WE2VYnPglBRzn9hsftrlW?=
 =?us-ascii?Q?tZA5jQvjyokgXgUcutQtH1HJR62pd3uvtWTZ+9m4Pp68HerG2kA52CL8isvF?=
 =?us-ascii?Q?F0LBdRkfrJMG2mf25lQ48I0DZmq9ByZVwgxQ5pD/jymeCgHvMo+YAkoQnlWU?=
 =?us-ascii?Q?9TBjrTka9rh5AwRkGRJdWaAH5ZHoQkolOxkVYsCVUowpT4fskfOuR7Co3NJZ?=
 =?us-ascii?Q?aQMk9wCCH5bMoSJU2SUKD0y0akS40VhiVSJ+NqgJ1U7NISzPxUVAHpaleltY?=
 =?us-ascii?Q?big4PLlntxBC+BwE+AsRe5JoDKi2IJhLisczQUsN3ftAEW1euil2dHBLFcHi?=
 =?us-ascii?Q?WOnMBkP1UzS96IUIHeJbLhaziggoTmi3Fjrfnfg11UZtYa+hIiJzlkLogx+h?=
 =?us-ascii?Q?+psubCOgXoR2WyBsA9NAhX0uFAsMylIw74tLeIRwVXY+prXBBw1nULfVBdHk?=
 =?us-ascii?Q?5T220CUrOPNAImYrZuPBaJ03782DUp5UNHZLqFeha22qHOwkU8cU2yOJfD7h?=
 =?us-ascii?Q?icpSwTh5dNJpyHtP/kCq8fLFVuzTwVsBkKUZObbQfm1YDRNnJ8SeBH0bXs+j?=
 =?us-ascii?Q?Pp7xZ8WyVmvahT7lHmvwSFiqgI9H3d1c+uFcfOudsU3qNzaGRBPxR6CKtwA1?=
 =?us-ascii?Q?59d6i35zCsFxnpR8A2QAhGa69kmvAt+LiB6JBi0a8iD6cWZRL/zmfpXRrv07?=
 =?us-ascii?Q?qwbe4QULVB9cukP/5/ROl5r+YAixkgg2mgMvnezuInLMSzZ7Kv7PcwL7Sghy?=
 =?us-ascii?Q?2hH+8vUCUsVfqFzRsfNFhPsd7YWzcGPVCN+drfkQV/Y+kWVt/v1D+cOfPsJv?=
 =?us-ascii?Q?20MOh0nKxxGyYHcVfD+QL9FdJxdp8MmWjIciI3lWnPooFHG8rZMvaVXhFi6z?=
 =?us-ascii?Q?7+fpwXf+UnD/XJYTJQw4X4pfx/XEAJPfh5e3yUZ98WRK89RlPkyz87OYqngC?=
 =?us-ascii?Q?A9Eob2Do+gxHh/YNGLbFIEfQSsN2ogv2IgVoceut0MYCLKvec6WlI6m7wpb2?=
 =?us-ascii?Q?boCdMg05jTNptceJsjZzvoT4E5vDgQBufJlR/31LdMNAhYdeBI46PrH1FnbP?=
 =?us-ascii?Q?BmLiyWEVeGkkwRQ4ppc6rBZjwjtla6t/0rE81fkK3jLNr+d+0KcGkb8o6Nry?=
 =?us-ascii?Q?VdU8bTOPLBK5zFZ/W0iOySku7QBuW0utJeraqJGTD9EF/zxaYd0aXTlkIjfv?=
 =?us-ascii?Q?pTrtCqLAasq6i/pMPbR9O1ey4GPnRR+ZgSRTLtsShy/Y7K3LT0LAhVlYauJ/?=
 =?us-ascii?Q?mjvOWCflteEbBClEctiIkacMBEYNsTVdy4Cl/jOtSsm4PkjWfxqckSRowo+x?=
 =?us-ascii?Q?dgNDIIoGbprVLX5SuSKvuychGH/2W7y5VrA03U8BFlinenaCLnJ6RddMiRaR?=
 =?us-ascii?Q?r+3/FdWKY9R0fenJL7Ui4tfL35VbO7+ENOWeyl924bCVn4EnxA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rSlJ70Z67oAI3EfzsrTZlUib2yzZ3TgiYNFyW8L9rXfxs23xZhp4T5iY6NV9?=
 =?us-ascii?Q?S+VlvY+QKVvoHj/hFA6P/q4uWpW5DgJd8QZswS2a9RWoN+6MZ7KfqOEmPs1M?=
 =?us-ascii?Q?t+/PBMyc/Htss2Y0gTcJXUWbBydAEJfrUxL+j72M6lg5rfKsYiLc2sAa2C0W?=
 =?us-ascii?Q?j5lt0KNeqR9rPgnHzedw75dnSneIuH1OwidiSKU6o/gLHJJStZXMxORWAiGJ?=
 =?us-ascii?Q?6WrI0g7Jaw1s8zVQOHdsiodeRkmuhffSc+Ndqw4Vszk6FOZzvoiiQ1j7f7t6?=
 =?us-ascii?Q?3sA8Ql6j9EWZKJlpvfUQeYZgBkYqqfqCrmeqsuBWai8HbweU1o0fFdzdFilJ?=
 =?us-ascii?Q?xlUmu/1BezUF0qrT1cpnwufODLHrRqjyWhyrIqWv6wQkxvNOToRf9UBhgXvz?=
 =?us-ascii?Q?8eGRcqaeg/2YK7/Fu9TC/KJ1EEiNmb5nv3ntN/G1voOjnlfR+jWCYeYb3i7s?=
 =?us-ascii?Q?8JwnFWWUqlWczjcITgl0/NMg9jQfvV6Pi85Fxm/1G70WSb9kNTMI4t/OGuOT?=
 =?us-ascii?Q?G+CiZTO/HtZaSWGGMFtcIGx+NmsDbhu7cPxzSnQRqEdHIQvUAsYJ8S86wDRM?=
 =?us-ascii?Q?HNKv4AZqqNH1rYEjf5XdMcXUJ9rcvi0Lkxh4wcu3m3qrQE8ICG1lWJPMMuxT?=
 =?us-ascii?Q?JU5j/QTA0G9hzfZG+NWq9Z9V992WLpOmWauzRqMvizwJK5bUJ1YyuI0R2YWh?=
 =?us-ascii?Q?5MzQqQEMxeZy7IL4Ll5evgsaPjtIbWBD7VUmiw6F+ctzTx7ko+VM14ALK1Et?=
 =?us-ascii?Q?3u8DvZHWiMWmeoe/3IO+Bfkw9DebidlmX5FAZP52IuXYa7IPeX6DbHbuPldG?=
 =?us-ascii?Q?YP4Fm7SSDW5jB+9yyYOGjyPQBwTVvYrMMF5lgf3y9ccY3ftmv0r9ZKnIgfyN?=
 =?us-ascii?Q?k8D5ebcb7pmftwx9qDPjZLlpKuS2wWrpQsUjHZ1nFRM87DH9r3bjgfgsn63C?=
 =?us-ascii?Q?FsRKLv9jSe90+8jG2CS+ALMUo4om9TDjUHuLIjAb0KJ53n+BUAXTXmO7IklD?=
 =?us-ascii?Q?lQ4667tyKQTwL1FHWjo7yDuGMHocI459Y16Bn2cSz7eOUamfFkrgy2NVHwNm?=
 =?us-ascii?Q?TpwB+Jon0+JVLgDzXsvkTGibUyuAZin7+eUgOtu81hXxymh5iBNpErsXqgQR?=
 =?us-ascii?Q?Ory7DPmtg9DQGFifeyvYNuqGLh2nIEyQuPbnRlmNF5Bokeh3wDGB1PLBcxQ/?=
 =?us-ascii?Q?CdQqzUBWWizOpRym5XdlIJ+LGMHdtueDiCdXhImO8sP+e3I3lR2Yc2fRY15g?=
 =?us-ascii?Q?YG7DI7pCJ/5B2QE9Pc42m5Hb/kfDB0X6EDnoc24Bm2SOLgHir3BsIB4Nn4kK?=
 =?us-ascii?Q?3fItX01fdL3emIcL2cESjDWs7IuVVQdZX2fyOpmdfTzFH3pfvLjPncAaKSws?=
 =?us-ascii?Q?MT+Tp7AryKu+IRPczdJLneQSjFk/MQ4G59WMj+SMm0xxMU7vMLlUQ0U6yNAk?=
 =?us-ascii?Q?T3Y9n56hQt8RS6257sLJMD5r8V20KjYC+/8zfTutzrH0PnUXGA14ODslM5Fp?=
 =?us-ascii?Q?j4LUbfjJF1r8PIt4PGHvuCd30F3QDEZZUBXjm0m+yWLWeuOkxO2/fYg67mN4?=
 =?us-ascii?Q?FnMkY+fr6I2EByXRld2WR/VfmRE2eEwtl+4PVfhWrJpBHGzGyONT7laHRR/N?=
 =?us-ascii?Q?hJWRnBRPBrKnyuZNVEcTqtg=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 685e3db3-443a-45ec-0b1c-08dd1b0eb380
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 00:40:11.2748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Jscj33+9NLYLe5oLzeXLU7c18Y+dpz6ZSY7F1T7Zvm+BkTPL8zLaJ5m/XFEWJQ19WeycrBfrtx2Ro4OX8M9heMO4cI81kyAtlaiZuV03Du7qfkZ6yQBEw+yrWLWJFLQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13008


Hi

> >> diff --git a/Documentation/devicetree/bindings/sound/audio-graph-card2.yaml b/Documentation/devicetree/bindings/sound/audio-graph-card2.yaml
> >> index f943f90d8b15..94588353f852 100644
> >> --- a/Documentation/devicetree/bindings/sound/audio-graph-card2.yaml
> >> +++ b/Documentation/devicetree/bindings/sound/audio-graph-card2.yaml
> >> @@ -37,6 +37,10 @@ properties:
> >>    codec2codec:
> >>      type: object
> >>      description: Codec to Codec node
> >> +  hp-det-gpios:
> >> +    $ref: audio-graph.yaml#/properties/hp-det-gpios
> >> +  widgets:
> >> +    $ref: audio-graph.yaml#/properties/widgets
>
> > why not direct ref Documentation/devicetree/bindings/sound/audio-graph.yaml
> > and define these again here.
>
> We don't actually want all the properties from 'audio-graph.yaml'
> (for the moment at least). Also ref-ing 'audio-graph.yaml' will make the
> 'dais' property required, which is not targeted in this patch.
> Maybe Kuninori Morimoto can comment more on this.

I'm not a DT yaml expert, but audio-graph.yaml is for audio-graph-card and
its custom card. unfortunately audio-graph-card2 is using different style,
so ref audio-graph.yaml on audio-graph-card2 is impossible, or makes yaml
more complex.

Thank you for your help !!

Best regards
---
Kuninori Morimoto

