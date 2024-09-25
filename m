Return-Path: <linux-kernel+bounces-339513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A502986633
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 20:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B833328371B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF71213698E;
	Wed, 25 Sep 2024 18:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AiGLDj4c"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D8D1D5ACD;
	Wed, 25 Sep 2024 18:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727288359; cv=fail; b=N3Kdnz+0hifsFSQzgyOq7vfanAWRJebw8pF2RRq1ZJx0rfP7v/NVSJbZQjHixIsRZNJkUP1iQBlo7wWgivFCFspbY/m6RGX4iKjGxAPY4ywR1BozZL7OTWzaeJySfJuspuhoI8rkclZ+dseEPGdczZYMrIoQ6CCvXc6H/I3VcDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727288359; c=relaxed/simple;
	bh=VT1UhtLgP3P5nxxWmuJ+MvzPtUbQOO1ZZG9KQcTFKEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Kh/gcVoQcZ8qUG61DwcMPn1dF8Dpi2r+33GP84GjrlIBiiGQ+xe5KJzRHy5367CGVXL5B8w648okpw2yFf2i/E4C7CSDIq7YEldoZicU0bPIRDoUzgElK3mQvGSjl+cL2XN8IM/HLIxVNzduKqegtyhOpRx8cnKpCXrUkenoQcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AiGLDj4c; arc=fail smtp.client-ip=40.107.22.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBT+8L5OjaE3GfU/i1vUhH3amc+Cn3bmMjrVNx/iiPeMfwDXHFKsYbw14cqkbFnRYE6wyNJiNxwr8KF6lj+W570RrjWNLq+cPnqj0YZtsVFPwL2ixUf3uUibJWwxIxADR4eJUqitaSMPnTwkK074Z1w5xOyjWw1mIMy2dEx55fBo77G4YrP7IiaDqFsRY/OG8vz1CdUn4yH2eCq0Jkws04lfApHCW57jd07sn/dFiqPy4KLJTidrhh0LaIafg483DbHJcd8uwVw3t/h46lQ0BglRfs8atS6tzOcKIo1SwhqpobK3GlHxt+R37qcdh2ReAy/vLeTBJBFYMMGekbrbEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqESTZ8kP7XaoUm7Kwg5qbJcIYCW00hyPhVT4hClb7A=;
 b=mD1KUpn1hs/l4a4msag6/N/MiupELEr3j6qPWg+fW0HCiX64rHhRflbxIf8ozV8aO4hK3Ja9ZFTCK6FcbXtO8GC8ttpe2JITvHwiDk8Hs3v/A4rby3zodOR5PhM9wBJveKWEiKkVI8aJA0DVQVAaIlZ+kwjc0MhxYjJ59vHai5lNawZspcXTQbpzXsFcRcEaheOmtdtDPzB2f+PR3tBN9iUuYNgsfe6JrgrM2WNxxw5Q4rifENVDYoGVUPWu/+YuKNQZ44ahnP67Jq2hF0B7AMSBUhIgRnmQTeknAin8RTOZmpwVmDL5uZsHqjLxK9yvxDXWw0EZi6jme19BN/35pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqESTZ8kP7XaoUm7Kwg5qbJcIYCW00hyPhVT4hClb7A=;
 b=AiGLDj4cnxbFFUMt3mDvYz39CMz93IphMZHWgg+Ej67FIG0tGekxnVuXWkrUbWXV0KEjYxtAPEz7KJ02jdneJZO60ymKkDT89Ae2j1IHPNGuzn7cTowvgYkf+W+jKa5R0017kJamfo6+ZGYzBubQA8a47JsEl1gnqLb5fJ/m/X8K39N+L32FBouSZQqsC9f2n97dAqvn4dvidtTH4yW9FUcGQe4BReob5F2yFVXZJVeeLoKWJnbgtTt+E09ikW8uoZHct3i2PUpnnurwA9zfhLL5ADDHT7oz1K8oKyIlDxY40anqeHaIEkpnskNAg8iptIO98cjgjlLJ9Y8KR4HfIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8640.eurprd04.prod.outlook.com (2603:10a6:102:21f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 25 Sep
 2024 18:19:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 18:19:12 +0000
Date: Wed, 25 Sep 2024 14:19:06 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interrupt-controller: fsl,mu-msi: Drop
 "interrupt-controller" property
Message-ID: <ZvRUGvX9ZL4YVeMf@lizhi-Precision-Tower-5810>
References: <20240925173438.1906339-1-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925173438.1906339-1-robh@kernel.org>
X-ClientProxiedBy: BY5PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8640:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e3ccc2f-0996-44d4-51e7-08dcdd8e8e8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HFFifFedhKT1PUK7xfO6ENOvCiSvkM/lFAFGF8FI0aRDpSyd8Vgph9j/SY3N?=
 =?us-ascii?Q?nS0s3e+sZdCGvkns5qWJozMmsn4vYH+1IGdEo9CMnREq/C82iwIq3BhruU7x?=
 =?us-ascii?Q?wy3fU79IUQ6HyOe3Bf5rgybksmlfj9cXQmxZVg5GTTuZyQxG/0aj45UjN898?=
 =?us-ascii?Q?OT57tY5e72PaoICSaMqj2NJM69Qfj6T0KJ8Qji4ripNfNLPFSjVDhOcYJ9Bm?=
 =?us-ascii?Q?E1JF3P23dAAxrmEXHnw5OuJabCfGdQ6J3p6iDFEiZTLSV1qHje20UGZnBpgP?=
 =?us-ascii?Q?26PTSWUgDZqXoDkQhh0N+jq711pxRU7UkIkxQf22qfwWXWbM2TMRZtKuHKWH?=
 =?us-ascii?Q?D+AzQQLfveWILOlUuZpLISMkNjqAPNO1XjO6TR17NFhoT8zMFIMwmEG12Inf?=
 =?us-ascii?Q?aRr3KeUGAgJJEKWgn1OM3/83l6odu/sEIx00CRjTeSjwW+V5cMWCuVYCZYO3?=
 =?us-ascii?Q?h8yEi4ujKIIQVnysF4z75h/ZyNnr+6FT/lpXzf7TQWNDOJ6DeahopyYwHp03?=
 =?us-ascii?Q?RgiXubIyogyEqWnGqr5HtSZFJk+HGxjgpUDXafH8mUYsey9GSh95hktutL2q?=
 =?us-ascii?Q?1S3jJ93T2vCNz42u3982W6dXkEDdmYA7vOKzX9cn0O5/odSBT1RKXNP2eNLl?=
 =?us-ascii?Q?6O8mknCR/QaWctbh0K3F0iQfQ1xUireeHt8yrg+ubA9Lig4Slyx5Mqs8KG9+?=
 =?us-ascii?Q?4WB0LFfh7fP4hEaL5cc0Cl93BRJtxm8sRW/ZdxuB8TVTXAJy4V9Cws7PSTQM?=
 =?us-ascii?Q?F19ivLBmLeuZ3lFHWBE+3CJCSwi5p4yHtr9NT35su7Ok1V9w3uNYpBfsXc+V?=
 =?us-ascii?Q?4gXMRxRNnvWC9HbxxXssEriFUi+RvqyG+6M2OcORE3c+VjKU8+Fz6W8e1vLw?=
 =?us-ascii?Q?xo/87e2/85WFtjx58b45uSbmNFfCi9hlqhXrZWqxrsad3nZ8UdS8OiTBQFHR?=
 =?us-ascii?Q?rwN2fjio61XvMXXNVxbNTiDbAlFVuwEhEvYfwydPGoptSGW3Y3ntry4jlzOh?=
 =?us-ascii?Q?0yyv9/A633z/Zw6AyhQkN7vL0KjrkZcmIdOn9hjydP6L/Uf7ZMKkhwJBg6Jv?=
 =?us-ascii?Q?V6kc+whOTkTFyBjmFzfwIvRLBD4lN1s+wuZdJGT3vkVdvqN+idFWQkRZtA0l?=
 =?us-ascii?Q?5Ir1a2RE6nLLbRIzU+mcjNuPz8dLgOqpIGQskD3PzVeSDOrpExJNh29sKwgF?=
 =?us-ascii?Q?JNDHU/u1QvUy/6ZHdKG7W+q+x5lG2MxN+aUpj67IuWTEKW4b8VG0rKWVgNR6?=
 =?us-ascii?Q?xm0iP2SBskDm1eR2SZl9v7a1DatgPSvz9aaXn6l8v+dNJzNCPLXA0f46LP9C?=
 =?us-ascii?Q?70pDBjCXX+tHxuUMcg49FWmxRHt26bsmUz3jv/UW9ggIvr9TleIR5PPpFfsz?=
 =?us-ascii?Q?tngMYIxRNrzKM0N49jJXiro9SK/gXNmAkf1u9U6bH9yS0WA+Sw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vHlSEUYJbZh0QkO8vCaV3XF1pNZtCD2Gzqkpy7IUJ1tDacK5NoAfQueyYiig?=
 =?us-ascii?Q?Aq9u+mTqJ3NHsjkoh8OiEmco09EGBKb2nOsh9vqFziPe8gEWv+lhL9tgytcJ?=
 =?us-ascii?Q?rytKeMpeJ3mVYnTokLZy/mU/QvsoyQhcxCvXNth/2JULhjafx1QYOz1pH+fy?=
 =?us-ascii?Q?nBCrNQYSaNKTmRV7jyY3y8uGJDUBqGX9/g2lgMQh6+xUXPZE1/4BlVrD7QQM?=
 =?us-ascii?Q?Hy75PmV68KuSFMjA9Br5Ecm+xIflwrM2jnSHEHSqcujRSdky4oHzRTjZ6hV0?=
 =?us-ascii?Q?gI93gYJTkqHwFbtVKKj9pUUwNek/KZ7n3mG1ltt060/tXegQliDUQ9w7P61a?=
 =?us-ascii?Q?SRAzEEcYR5+XmjTGd51+Yy+Gul0LD+jBwRpv+xlkvAaJG6jsGANly/LuwRVk?=
 =?us-ascii?Q?LC4dvBacgG0nlkY7PaNN7G8YLrH4OgwBqNinNzdfGe/CNZfo1K3n2KdtGJlm?=
 =?us-ascii?Q?TMSjA0lz1v9JwhIBorQqGY2FR9s7wwWNYznVstHpOw16ZTHklimtElw6wZDx?=
 =?us-ascii?Q?gqPSo3jFoqNoL9gC8BIPvA10+eg1SqncLJFbsoF+ZKVyNl4rGSPkFHIbOgSM?=
 =?us-ascii?Q?gxvKiuSLntdRrdrFbsCSzNtUTsQByJ/okv7kXQmvdx9kq43EppATyGvuNuLl?=
 =?us-ascii?Q?gugrj5g96boOv6/Gw2p8p5PCedxmQP1x/yU/zI+JnZoQoVZYP9en1Q7+SuLn?=
 =?us-ascii?Q?EV7OMi3uS6SAZIv2Ea4JS3gC1XgJjckfzEIScp4gXeRhrcZ4eaj61dPFnm55?=
 =?us-ascii?Q?DE8Ia9WWjH7Ch11cDmUoZBcxHqvT6imRnstF+MZlrGiY+WlWCSzl/ZM8pShz?=
 =?us-ascii?Q?ijw46lWsg+8HbN0wFJ7rQ5uwsqZJ8bMa0+ii12on47o4TGg4QlyBst0bal2P?=
 =?us-ascii?Q?mIVFTABiFJ2vFMkpctCdCpGyPJTI1t/MPOAO4I5ri/SIySeiBO1fcGafPeRZ?=
 =?us-ascii?Q?lQouIlmvxOkxusKyEKr3nwrcO/+6MK+o121TAugEFzRdT3dC0mWgxSaRV3pi?=
 =?us-ascii?Q?vEWTkS9kW2cIpM3QWHI4YCIlNpZ4/W19UOpeesAh3eyVQm2xVwUz0IAjaUai?=
 =?us-ascii?Q?X8T3DmE7fnuzRG1ksQvwSa0v8N6tjZQbIZ/7DmPIqTGaBAkprFatDjmFTXsQ?=
 =?us-ascii?Q?ePDsJjqZTE2XFXInh42gQAnoyDRSFWyPJxYR1rYhSwqnWAtWECvmCPnG99OK?=
 =?us-ascii?Q?VW2KREwX3KhjHgowcrLvhPek8WRAE3e50Co5G2ADMst3L82nTSsy0lxoSLbG?=
 =?us-ascii?Q?lYTxmuWWVcAzeSHMNSHoUcD7CwG6o6hW5kGAsrOLI8kaYfLbbEYSzt8/dtuK?=
 =?us-ascii?Q?SYd1LDwc8c6svYmQAqI4BE02nzAcc9rbBN6N0fPiYExHIIXLR2ZGokWZTCp6?=
 =?us-ascii?Q?z/49HO9uv7pob5O3906NMN4kDagNlV+nj1133ZyM6U1iMy68uAIGYQC8UEHJ?=
 =?us-ascii?Q?izmW2iPfiDlBJsXDrS7xrOk9L9X/u7GtN2l+UD1HdjA0r28Og9UmQ9LOPOBq?=
 =?us-ascii?Q?M5PhAPhqkm24zE4GQfE/2pPOUaqr7cCzNfuDAByBZ68k444x2XcMz27cdyxo?=
 =?us-ascii?Q?2u+/c8ME1f7gVGHymtIAd4x4i+w1B7zvAcSm0Qhp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3ccc2f-0996-44d4-51e7-08dcdd8e8e8b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 18:19:12.7916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cQSzaiWSPw7BwUeDM8NSqUpmfFOEuw2KzTfP9A2yJpbl0uiBdtYZLaaaW+89CObbnnTs3q+B0HYX/meSTOrbbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8640

On Wed, Sep 25, 2024 at 12:34:38PM -0500, Rob Herring (Arm) wrote:
> The Freescale MU-MSI is an MSI provider, not an interrupt provider, so
> drop the "interrupt-controller" property. This fixes dtc "interrupt_provider"
> warning.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> If this is not correct, then #interrupt-cells needs to be added.
> ---
>  .../devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml  | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
> index 799ae5c3e32a..b5282c857f44 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
> @@ -62,8 +62,6 @@ properties:
>        - const: processor-a-side
>        - const: processor-b-side
>
> -  interrupt-controller: true
> -
>    msi-controller: true
>
>    "#msi-cells":
> @@ -73,7 +71,6 @@ required:
>    - compatible
>    - reg
>    - interrupts
> -  - interrupt-controller
>    - msi-controller
>    - "#msi-cells"
>
> @@ -88,7 +85,6 @@ examples:
>          compatible = "fsl,imx6sx-mu-msi";
>          msi-controller;
>          #msi-cells = <0>;
> -        interrupt-controller;
>          reg = <0x5d270000 0x10000>,     /* A side */
>                <0x5d300000 0x10000>;     /* B side */
>          reg-names = "processor-a-side", "processor-b-side";
> --
> 2.45.2
>

