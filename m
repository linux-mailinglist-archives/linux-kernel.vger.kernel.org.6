Return-Path: <linux-kernel+bounces-408249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 997409C7C90
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 21:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5216A1F26646
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE7E2071EC;
	Wed, 13 Nov 2024 20:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aqrEgLh0"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010003.outbound.protection.outlook.com [52.101.69.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3923E205E1F;
	Wed, 13 Nov 2024 20:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731528201; cv=fail; b=H95CL4AOuJs88kGA3zXbj+MNAQgLaElqtLp/ZJOnrlWcOzllJqKMySRNFz7Nvi7fg7VcvJlyNWYSMtJaREuwk9XUGZ4Imkn5/KiqHk+aRcHKLNg4P6LmZVmF+OYhZFSDvytSsIHpas1EcKY96acr4f6MuWYhR0Hf9vAZGdMWxmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731528201; c=relaxed/simple;
	bh=8cksl8WyY40thtgYgSm6a2dYrNvDQbKkG2DpZvbGuY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I3SPaEQYcHckxkIS5uCCwn/b8252NctI3bjy1RPEARJsZAlK3naSqeUSg82I3RQa0Om18CHfE21eDDiTS0RBeBEHYzuDHyrDQPWQkp2mhP6oqbI1ft2Wwbck/hBQJrkv79qeEK4aSjx4CcfViYNlW033sC/arTXZfKWmzRuLaEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aqrEgLh0; arc=fail smtp.client-ip=52.101.69.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6dqFU0wqZnoy1unZW5pjZm/8717a6HnqdiNqyB+nD0/otl2vPFlUXklenbDj0wpJ5O1l5FZf/5CMcRwHfvmpPJa6V5nOn3RQ3MFCWE2BtvhW6cij7kbY8ZfIHOcQD55T85ATCqC8hOvVR8j7vIX/S9c5uzLxS2rBjlmEVdDkrJ7H7xUhUYxRB8RcvF3p4/OUu4p1BPwNi7XbSYF/5sDk/J/xXawA0fGUPSewvpHy/OUNruJ69Zq82y9ryZC+ttD3Pga9bcTxYCczxkTZ22T9j2pBzfV5oSStDKl6KImQWM7QSB5D0OjXGSEuFNW6fN8LhZPudIY0kQcr2DuCQvuLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgQ91ULqt93qFhPkKdCqQ0VhZXoQC7LaepNUgDRnceY=;
 b=VDjkxhm/KJBe2AKLelXUP6n8TLnvdQY1Y9GPNMp/dg/uROQfumjp9S/ja9YabAf4TKuvkYEM7KKUCledZ/lLYytnJMhEMgMdpZbhye57F19haqsdlL9lBj3b86c37Bv9EgjZGHzaRK690UzXrJAUp5aCtlI49igjYl+e9V7wVegmyFR02/gAror22t43xaTwCRDtZTfvOoLGyPBc76CLba0m3HlAD9CMPXUOwbr1MRqHN2zSGDrd9WJYpFTRjxaFE/Ipv2o9n8Jg6xfuz6MAjAi3AEL+nOEcuBxSWXWCjpcagyPNK7uJSh+WcO+Nrnd1SVykrETEZI989inigSYSrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgQ91ULqt93qFhPkKdCqQ0VhZXoQC7LaepNUgDRnceY=;
 b=aqrEgLh0h6YKrbMNmKnfOwdYLd0fngcso0qA0yX5Z2cMx5qZYu4jk3CIWUvlgpsoGrhpnjvy0txULRRBCjAlF4o6eX40kVfOZMwwHkXCxa2TOWGgnT8ETpsPk3jcXz6PMBw7DqhOfNgPL5A2iM0f1rg5gN9sAzg9yczaeQ79tWGbXiXwQI2lA/PedCobn0tMX1MVvOe4S9UXJJcieYt6GG+tbqPm7VzGMwkzWdGH3JbSekPWfZlXVb2gvgs9gcLEnB7bBxFTX+pdvn0245tzzlEwYx08Cso6WA4WXRNFaM4gjZ3UNBVSrGMNIwgjxvZZh1cxHuoovXl4DoFyLwSvqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS4PR04MB9506.eurprd04.prod.outlook.com (2603:10a6:20b:4c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Wed, 13 Nov
 2024 20:03:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 20:03:15 +0000
Date: Wed, 13 Nov 2024 15:03:06 -0500
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Takashi Iwai <tiwai@suse.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-sound@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] ASoC: dt-bindings: add common binding for NXP CPUs
Message-ID: <ZzUF+iFeKSqKGcpX@lizhi-Precision-Tower-5810>
References: <20241113195240.3699-1-laurentiumihalcea111@gmail.com>
 <20241113195240.3699-2-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113195240.3699-2-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0300.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS4PR04MB9506:EE_
X-MS-Office365-Filtering-Correlation-Id: adb01d0c-3e64-4b08-b62c-08dd041e3581
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HM/vCZZBc8fS3sCjEAUtuwJkxBumsH6mko5kS9cNxWYybyReIu6dhg+RVDNb?=
 =?us-ascii?Q?6JFE9AWJNUVuoaP7skf9xkcyB/6K3LFaDx/r+JcfsEbTC0Zv5Vz2146I9DIS?=
 =?us-ascii?Q?VfsYZZADDyZthPAS0r3knQj2Mct1ef6jVppKfPzC0ZiKrterenRd+WFAJpus?=
 =?us-ascii?Q?cO1F3LwI15iWOMYkB4wrTlvYzLCEDjMwT+4YCW/fY/hJgNGkiIuHG4jVhGo9?=
 =?us-ascii?Q?kruMUNE1V9Ai2jrC/VHrZFFBAxyA2Xy/RPCXYaYyFtGpXPIQMqYOtBAWU2XN?=
 =?us-ascii?Q?hdtC8jPIc63fQqmHMhMA4RZaUom34lzhKBMMFEdkam2OZcoYoZ9h8CaMKnlR?=
 =?us-ascii?Q?0CGkBtTyjZOF+vd/gwIg2vvMmWUFK3v2nn9G8N24N2bhagE3H4QxCagfIs7E?=
 =?us-ascii?Q?GBvh9qd9Bo4tK6Zue8Sme6ffEt88Gjr5pO9pLfRdlvkO+LO6PEo+ocNsboeX?=
 =?us-ascii?Q?KRMOOEM+21KtGB3NcCAKaWfhfRJYIDe67n+wJTr0TP/By8rhncpLx4SMV33H?=
 =?us-ascii?Q?oNq3qGFvCdfTQlyRVxSgnvMv2hd8i2hiouOVTCCixwuXzfTOArXzvL1FDDx2?=
 =?us-ascii?Q?Um3VNpPd4feIMMk3XdiG6xVtRYEz7mJ1intrrv580QK1oIIF3F5VglQ2Eil7?=
 =?us-ascii?Q?JYNIs9vQRFgRehhZw/K9WoUviSXRipkX0biawh+/WixS/OfLtWMRlVm334kj?=
 =?us-ascii?Q?okSXMcFISPWJ9q6MwUs7AVVgpoqbitQc0GkZSrFMU84TVkRHxTHK/NABLTul?=
 =?us-ascii?Q?0tue4sk2YqV1JRdflO8ioOm4r3nCWEYVV0yBbzryfrWnVnxbaxZYnvdK3/07?=
 =?us-ascii?Q?m97kY4tOfFlsjOARa/idrdJR1Zn4bTQmXTxoELZsgkYMAlkG6lm4l/8ICtGw?=
 =?us-ascii?Q?DYl+3pA+MVVWcsZPwmXPa9o2mduVpDIbC3wCf/Dq5mHSJSb19rX0CWrayOup?=
 =?us-ascii?Q?LdVRe1PlRpx5ORJtVnNOvNG2ojp/f6FUm55ANrNodIN/sxLMQ/Ve6wVsEYhP?=
 =?us-ascii?Q?Rq3QlG1TRlnzTEKjkYAGdhm/ZAueEel6fJWHjnW95+sY24uRlx3x9yfyEftE?=
 =?us-ascii?Q?nSTRrOKQRSG9se/TzLV6Jala94kkup7QIEvACVUgnfCL3/rMwyU+4WyKjbZT?=
 =?us-ascii?Q?4lMnOX8rqVcbbQxDzplzqyBrkBCBHtUCGhqDA6vcesWa57U8sKl3MRBmZNSM?=
 =?us-ascii?Q?aWWVuHQPAGrFUGUrynAztQZ/wSopam8N1cawXv14ULW5SdScqSjLpF4T+1Ss?=
 =?us-ascii?Q?VdLgZHVH3pq+Ua3q+n4AuXGFisMS0ffatWXpVpCEZj6Uo/JoY1HoA4+5g8Dz?=
 =?us-ascii?Q?H3mo1UvY1WdHPusELJjbXZie?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YrE/j1X3DSn1VI4thd6ZRgKwoYNy1LnPkRTePhYYfzJHVp9DMrPbOCgVrcLa?=
 =?us-ascii?Q?jAmgH2D/pUmjNbdRcDLK9mbdcGbtjXt/VNfDZdHp5Frd1fr1oNIeKgza5Dwr?=
 =?us-ascii?Q?sfXftsVbwX2mE1hFJ3xiOX4H7IpyoturCmRX5dqnUOGjv5oeiEsd2JdM+rFv?=
 =?us-ascii?Q?oBmPutk2knYt5AnMYlZsHxdORcg4sC6ge+RWml34QVT1VZ/w2xd/xsA+gGDf?=
 =?us-ascii?Q?rCEWwsrMB7F+QHtRZvJvrU0B3uEzdlWZ7HAUIvbNLWrvVSdLamZOw7iWxIh0?=
 =?us-ascii?Q?qnTWN6ZcoueoPRFbLq9Oul3lcbuWx18lqPIwZKZKK1piL7j2wME+FJsrrwL4?=
 =?us-ascii?Q?IlwLnLHyXKuhBwe3XuFwrPuUSRNnPO61IiCNlnInLLqAfVTKLwo4paVTlen1?=
 =?us-ascii?Q?TtXkgxus17tRzjTLAmMwQhatqTZdcOM5QjID+kDCig65q9ImRld9RlIW0v0p?=
 =?us-ascii?Q?luWQK9eUbV8jLEknnLDTnnuEdf7syTU0LwvY8osrJi6xguYmhM3Svw2aj1Vg?=
 =?us-ascii?Q?EXm2kb00TRXwaMxBNvsw+gP1JLNyDJTNy6kEkUm4WI5xK9sbWD9sOftTEipa?=
 =?us-ascii?Q?WILMHK1AC9eoTIYPSx1lGFM1YSdbwj0JUkdEB6TzoAobnBuHQLpvea1CKXPy?=
 =?us-ascii?Q?Kc7lPSknNo1/3CCZ/py/n0d+lH/xAieQLpUuWBQrPtp3PewuHqO8+Im8bWce?=
 =?us-ascii?Q?YYKSoIgeOOqtsqi/+V53neM3R0Zkm/bifNBvAiWQfYrnNBL3aeUbs0S1Njvj?=
 =?us-ascii?Q?6t+B8J2CJs5UnHqzrkvv/+VAbT6mhmG+qBUmYH+ricHc0EYgAMi37Hb4GEh6?=
 =?us-ascii?Q?GyzBO1CYQlXHMBabYNfrwtE0THeAlDC6JW0brWie8DMvnbCf3E34fE1tLDak?=
 =?us-ascii?Q?D8lKgNEHMuz0ziVofE4He24UdiqNn15DfUmlwh+ZXXKzaZSgC3RPKBYmTtBt?=
 =?us-ascii?Q?bwNL+QfS/X36fXOtfHIyArYPwWRCYquGcRyyPDlBqpWarEMR3jNeGdOJrYQB?=
 =?us-ascii?Q?3OC1aYWwY4wZw35RUL5FNeMEhrZSWxBXKYPE+6sRRxfuoU3Lcfpy3cqYN+58?=
 =?us-ascii?Q?Gb2oPxp6zS3XCBdopYWyDrGC0j4kvQAQVTPlnGHHYNza8eZw30cfmRD31ChS?=
 =?us-ascii?Q?p+ty7oCio78Dc8oNAz95BytmhkIXsaxQt1b/tuVzOqLswuvgEIOweE5CqJaz?=
 =?us-ascii?Q?YVauGKeTtUVczXMib3s+DJYXBUP6cwbmW6RdP11lChdJD6ODUGOAjrSHVfdt?=
 =?us-ascii?Q?snboA1t+S0d9/FaORNBUVSlSnoFIilhvURypKyEGQFrXD/V5gvBPUZzH1qQY?=
 =?us-ascii?Q?lQgDIT3vtSDWrk+v8OReQUMhrfCM+OWCV2WxU+PmdV9XRvVP9LqH3P+InWlr?=
 =?us-ascii?Q?H7+eg9vAONjAPhuwCB17KGQSrWZ3RX/WnyVTM+VFpQ5Eh4MKLZ1NGG6CTj8X?=
 =?us-ascii?Q?qcwAlOVAAw0flW8ttmzZL1ZPvCZ6z8VcFGtIHv7WTYinSFq06nKFV6NkHHxn?=
 =?us-ascii?Q?oO3yXYYl8CbmF9Mo9vo03VEYJWUN9jyypp2BJP0Se8T77SfiM5mz8Yd3LJOP?=
 =?us-ascii?Q?4ap+Onr2UKJRkN3a+NpVb3FvPShjWy5cMJSXXw9o?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adb01d0c-3e64-4b08-b62c-08dd041e3581
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 20:03:15.1606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LL6s13HtoT2Akj1OTp0BltDLqzVIddEGo5AJtTU9a6ry8Qe5fuCx7a7gEFFV/NIs1LzpD/AF6Mj9NKJsm+d+pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9506

On Wed, Nov 13, 2024 at 02:52:36PM -0500, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> Add common binding for NXP CPUs sharing the same programming
> model (i.e: audio processing with SOF).

Add binding for NXP audio processor with Sound Open Firmware (SOF) support.

>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  .../bindings/sound/fsl,sof-cpu.yaml           | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,sof-cpu.yaml
>
> diff --git a/Documentation/devicetree/bindings/sound/fsl,sof-cpu.yaml b/Documentation/devicetree/bindings/sound/fsl,sof-cpu.yaml
> new file mode 100644
> index 000000000000..6d63fcd71154
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,sof-cpu.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/fsl,sof-cpu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP audio CPU common properties

audio processor?

> +
> +maintainers:
> +  - Daniel Baluta <daniel.baluta@nxp.com>
> +
> +properties:
> +  reg:
> +    maxItems: 1
> +
> +  mboxes:
> +    maxItems: 4
> +
> +  mbox-names:
> +    items:
> +      - const: txdb0
> +      - const: txdb1
> +      - const: rxdb0
> +      - const: rxdb1
> +
> +  memory-region:
> +    maxItems: 1
> +
> +required:
> +  - reg
> +  - mboxes
> +  - mbox-names
> +  - memory-region
> +
> +additionalProperties: true

example ?

Frank

> --
> 2.34.1
>

