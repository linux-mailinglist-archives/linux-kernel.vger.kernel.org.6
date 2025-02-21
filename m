Return-Path: <linux-kernel+bounces-526526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A1CA3FFD8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A0219E0D1E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF382528F6;
	Fri, 21 Feb 2025 19:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PJDtYQnD"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013055.outbound.protection.outlook.com [40.107.159.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B361FBC93;
	Fri, 21 Feb 2025 19:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740166645; cv=fail; b=iz6+ieDOEGAKsHvbD/vOp5bpvglklQurfYEGp2YbXN17yWhzultrZo6poNDjuSZp58Qa4jGqu4loTXpUxGUMjlH/HQfqUaGBuasW5ZhD6W+qBNH7FpaJm5wJpl1Jq0BwuQStWWwYFOKx1wLTPdvhVOof4pMN9/FEK+jrHsIcleY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740166645; c=relaxed/simple;
	bh=NJHNscT9elJ6F8WJXArK8r6tFTqP+nYGLjA/AmkBndI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GfMDBDy5PPcOeCf1HlE23AObpUZaxnFnJbOQy7jpFLy4xoBsQIlK0nBW0QHinl2GPDIc7dcQeS3OzCPwlgKACVAO6VE3mwXb0CNMX0lS1SMMEEpXiTdGP6C7qm/smNqehXW9xM4GwDw1i8H0RVmLg6eOzkLkauLspc/1w0+JEag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PJDtYQnD; arc=fail smtp.client-ip=40.107.159.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+X8A0sObRQE10ltqBVoQZpXLWkI3lQofpgvkDe/MS5ak+zfEARpNTC2/uGw2LPmeuqxgopir64r+55rC/B3zM3IRfudrynsRAzXhrN/HQkpoJoNiLLH3Huk+PmOZal8FiYo4/rs8vZohZwxOuUzY6S9FE119c5N/buyokhmDX/7u+g8NvAFfnLQYT00V3+vn/TnrjgY5kdg2OyUdYEkeWhjyQGi4DWdsfKcuEpEhzBz9VmP7FK2QYIOqQyGbPLf4WZjMCjyiMoQ2uNONwxOXOw/0CfGPE4Cz4aDfRK8UZUcXaA7kGUQCTA+LfcPwYXMw7FjCxfFw57qaTS1yiW4RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbecM0vuOOc1JfArtHIfiTUNOE9Mk7qMPQiINMlR9oQ=;
 b=eXyVNaYzyBHEuvlom6DUESHeUjZoDPprbzD1+dj+3jBi4woZVmEhpNVczVK9kYtyBDgahR2VirGTo8abwoa4fuRtkJjr17EVeIw1Edvf0CAs24P/LqWk+ZGHs1I4kJ4OIkdGrIHdGfVFXjFJdsN7o0AbOuBmbleeZ7IxwNWBJtvhV5R4DXa9Zc5eYE3UW3wmwcN3BoPHWHgSoTVxfUDwjDAB/ZIBLh1ntqsXRW7HjUNGsgCYH+VSlOIgmmEBcNYaa4Nh7ZmsglD0h9cj2M47fKjcs6ahzgbBE0Bzw9LX+coIxPgoiPvP10t4B1Vq1X7hHDsMPpPhXfegNhklHnj5UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbecM0vuOOc1JfArtHIfiTUNOE9Mk7qMPQiINMlR9oQ=;
 b=PJDtYQnDas6qhLgtZx8ITfY7+/Cc8faPgUHZP8rRjgEaAVrnjv25MzyVHMWZIOchpChoh5diA/o73th6+VKuO+kMdkUHsT+zXhKK6R3gk3lbVI5UFJksvnuWPSnDGsTlKMBWfzqEvGc+90LNb/V7n37igXm7VMLih2ErRPgiHlF30S8/RC3RkC+tQF86StqiWRxfSd0IawRHaH1ubWwp+atxf74A8/3CJ83lQeg9VBhq6HdX8/k0+6CXzdC1VzvpojyPqhVgAXemMbl+3JQgrkiMVPlQycE8ax4j+z9RiCUrHK9QlBpP5L4f/Fl1qDnfJqC5JoOmFPFkQpxla1qKrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA3PR04MB11202.eurprd04.prod.outlook.com (2603:10a6:102:4b0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Fri, 21 Feb
 2025 19:37:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 19:37:20 +0000
Date: Fri, 21 Feb 2025 14:37:12 -0500
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: dsp: fsl,dsp: document
 'access-controllers' property
Message-ID: <Z7jV6Lp6HUWdi3kN@lizhi-Precision-Tower-5810>
References: <20250221191909.31874-1-laurentiumihalcea111@gmail.com>
 <20250221191909.31874-3-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221191909.31874-3-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0367.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA3PR04MB11202:EE_
X-MS-Office365-Filtering-Correlation-Id: 303ee7ee-7d91-40d2-f8ef-08dd52af2822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ktXKPAktqaHkRA5ditmR0kfjrpk0oXSAiFPFkjlekoceujawmqT7qaIU+Hgx?=
 =?us-ascii?Q?QQKXGSp0CLRmzdH4CKPhykxAtB1Fy3ZodYcLqgaY6Q4Vxv3s74L4mVUckHIm?=
 =?us-ascii?Q?eZJrtf1QPmaNrmY7Ci6zhS5lzs+aYvpAQUCreW/m1C/PbIwhlfEyrziH5mhR?=
 =?us-ascii?Q?aASs9PXhRrBxCOTrKcV+/bgrCMzfyE1C6pJYik4QYFXJRweIIptnugN/qA8U?=
 =?us-ascii?Q?KsAoMMqFY1hlM+bw4ND9Fym4EHPxKqzvhQGwD4p7mTvah2077ROzJDM4jH2W?=
 =?us-ascii?Q?wi+QJpf/RjDR34ODuarxG+0QgA4lakE+8CWSY6OD/V4BdGmJiMvJVredaSKY?=
 =?us-ascii?Q?HiemiTv3EaBvBWcUvqHE1W7stFrwK+BkcQ/iA90cdrF0EMa7C61c7kiXObkT?=
 =?us-ascii?Q?2O6PJQKOmLzOCeTL1XxOix/+HgtMVDJXmCTN5Ys4zNxMRhlV8scfpqxDyXJx?=
 =?us-ascii?Q?ekOdhASO/1nwRMUhPtbxl/4O+3UZWQUNv55Ef6J19ayxm5mSQsqOka7H12aP?=
 =?us-ascii?Q?tAjjaHgwRBhK2UQYPeBw1Ee/P3AGL4tRjE1TL2XPAgCzsxJDbpoqiTAZfilg?=
 =?us-ascii?Q?us4GcnlPVv6FOy59VwHuRWmD4h+FNCX8A7kgrbxbFcpjv4UixknL6tyOWxf0?=
 =?us-ascii?Q?XP8QvReAaNR1E7vi8qnrV66VYA31yee6UWhebc7p+FNV/+ltn5Q0RggIhz10?=
 =?us-ascii?Q?5rD7ti1pFgHdYUxwxxG3CT3/5HCylb9IEQOovuvQVgMzxLhgRa7JBkeybyWg?=
 =?us-ascii?Q?23iOFKUknU6CBY+7WXRvoyeKD+CrIiQZ65j793mRf1uSU7wbc/ORgFW0MLsT?=
 =?us-ascii?Q?8mMLyEMgNzOYWwa31s5WVjlcLkFqSRthZcNuOPDPXFf/c3rYPqmSd0WAV5cs?=
 =?us-ascii?Q?snUKu1Czmap3F1aIyToqCGd1voFvoYP1N/tZu2y2gx65/qgXxD7gI/qXeAJm?=
 =?us-ascii?Q?J0AqJ+CAJSsuCFghgum6yGmOD+b3OLtUDXs0XX5JqMW9PI2cGzd369KOjyOh?=
 =?us-ascii?Q?/ZplQFrH3tNyc++CFHxZ2lnLbP+Hu54sqT+45YdFVHj4Y9WUf5rDTQB/14qo?=
 =?us-ascii?Q?Y6GDXnpplRrKTu44QJtg/gvzbmwjQUKmWoduqipXF/vZmZyCSFy8v2cegqks?=
 =?us-ascii?Q?uYwCsEdSHO87i7E48fcHTwnSzycyUPB7Bep8d1E/Gi1jGXlNdmrG+/bq1SUy?=
 =?us-ascii?Q?pG58wA1gxD2glhpY00J8OnGWUZD6zYhScebDSYdT+aTclQSVTMTJFbHNkQEz?=
 =?us-ascii?Q?/8DmibBfCXsnE8WXO6bX+l6JbpSQCykNrQj3YWJ0yePg+1xiBNVM0XyVK8yt?=
 =?us-ascii?Q?C2bNYdSg4cgJDHF42baEcuylvMS6vtdpj0KepJ5UTSrxyksMvELOO2JYDaHV?=
 =?us-ascii?Q?MHzrXX7TZU0NbbvqhjTgs4s+unaNMYNxrVHHwIC/UgP85GFLGo3fQQP/1d6D?=
 =?us-ascii?Q?cTJVCm5zcNVmH9DcInlsVZfvnAsQw7YX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yToRxItpuLpz6xOxLZ15XpxnPRpai1YNTZrbkbdXpB+BH6kwx8e2Qk4/e2DN?=
 =?us-ascii?Q?PkpGFfRSQpihjoRDYcSjqojeHCwcUUYnFKOa3V1H0p8SfBmls1QCRRQDTy3w?=
 =?us-ascii?Q?AROdu5+3R1SKaPVguoK8EBp4OIbnlVgkwN42XRLRyazoA1PRdFmYlP1wsPhl?=
 =?us-ascii?Q?LZcqfUZlt6eZ1FMFDPHYb+9UGqr82bqS94Tff38QlCsE/cNQa8TDEtMFDBRl?=
 =?us-ascii?Q?FF6lDoNlIkkR3n67zbWh6i9ckoDlL5dArYf6hWDM1coB4gmpyR45JD6sO2ye?=
 =?us-ascii?Q?+UhULgZfkkPRg473dD+blP9NP8ZjDdyjcIhu8kX6/mjlleNGzLVaJ1y1tpKI?=
 =?us-ascii?Q?Z+hWKus0ZrHjer1mU7I01dS3SVersJ6f+lWcEFfR0G/fXH4WNjVPdC+ycFjg?=
 =?us-ascii?Q?WINWmV+pGwcfsWe+fuRgtIyHS9D2CBGWLUhWy21uOQM4XNQ2n+FLLrluj9Pu?=
 =?us-ascii?Q?CpR7Gm7eT9h49icAYyeI+kn+g5sE5w4/7n22GhUl+bgg0fUXmXroyaEwKq5l?=
 =?us-ascii?Q?gSp/xYaRyVR662WLZJo6Rr8+VCbQD88lV1GXmIC0DvdrzHcTBP18QL74FgfL?=
 =?us-ascii?Q?rs8Dnsjz2adr+HCFR1oudYml3n7u2TFAueBdCzyPaldtlbCLx6QfWY9hcetS?=
 =?us-ascii?Q?uMnf3rATjnBptZ8ksekBRFqtly1aDuZ7WOid83qnucFIFGl6RnE88tZfU+Ig?=
 =?us-ascii?Q?ko6H1E58SZwr8VnURQssrYCmgXlsYp2taN+2tZ6e2mfl6FJ6GFw+OrTtELn6?=
 =?us-ascii?Q?ug7Vxq5Yqmu4YZpHYdFQVck5RJS31lh+xfyw/zg9bsZlJ1b6XeTKzTpsWe8q?=
 =?us-ascii?Q?gEf7WgvqemuFKLNsPJyMvq+t/WRUHvPPgkq3QOwImv1aqLS3h16C0q1o1xQz?=
 =?us-ascii?Q?4pVGJvRtGCjCnXLW62GCaxauCDRPgxmQJnMPHWlLHtV5bAXM07UZfs7DhRf1?=
 =?us-ascii?Q?upY5HEwzP4JlKCkD3bPqtMArz6A2ouUrbTTtozq2rXfTbjVgctwgjQuJ3QYk?=
 =?us-ascii?Q?3SMezSHvO72bG0FWVYJFXVAusPvSLqrntHT22gG+0K5wL3IvhJLeBdTOW3yk?=
 =?us-ascii?Q?FJwKR1hzoQXjwPQrt6kzoHiLh9NOSaYN8i/k1+xdUTPRm7d2Y1aLQ1fV59En?=
 =?us-ascii?Q?b2CflTYvgHtrVmdxIvv56qTiD4yR94+7/OCEdg9Rk/C4T9bHhBnG/erJ/3Ym?=
 =?us-ascii?Q?3thu3pTDhSvj6zhMmIiPExD0Rwz17TaCIhULG17BKR6GZLoJL2ygNNYCza7X?=
 =?us-ascii?Q?IeLjOhoi7a754KS2VNXhr9PL/RBVCfgPlhvSHNRvh9jOx5Y3dri4ZQUMekwe?=
 =?us-ascii?Q?3VkZhcx9YY9KmlTfEBv8nZMeyrqj4VgTOeK8sg1obW81DkPB2Nn2SVEYLa89?=
 =?us-ascii?Q?Q+geD3SsiEKP435TCpMbs7MmDuhTrNekfI95Y2ie5S4OqSm2jXykljcAfNkm?=
 =?us-ascii?Q?c0yFaQ8klobRMAh9KCM65b/IGlzq/CzG6ZMhtFueQyjFAvrpWTxSB/SXX1bu?=
 =?us-ascii?Q?dIrpZSGa0GEK+vxOcuqiJsHPNIsXP5szSNRFwAWjCXs1lDgOKatARv1+17u9?=
 =?us-ascii?Q?2BHx2oU/e6st70H4FSaZFWSLIzd+qTIw9dd78VlV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 303ee7ee-7d91-40d2-f8ef-08dd52af2822
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 19:37:20.5041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kC90kRUlmwBGjOgfKfgUGvaryKM5qZT2J/Fg8DehoBm135QO5Og9mI2jKgqVo4Hhl+nQEA8b2FUHI66BcxoDJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11202

On Fri, Feb 21, 2025 at 02:19:06PM -0500, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> Some DSP instances may have their access to certain peripherals
> conditioned by a bus access controller such as the one from the
> AIPSTZ bridge.
>
> Add the optional 'access-controllers' property, which may be used
> in such cases.
>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  Documentation/devicetree/bindings/dsp/fsl,dsp.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> index ab93ffd3d2e5..869df7fcece0 100644
> --- a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> +++ b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> @@ -82,6 +82,9 @@ properties:
>      description:
>        Phandle to syscon block which provide access for processor enablement
>
> +  access-controllers:
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
> --
> 2.34.1
>

