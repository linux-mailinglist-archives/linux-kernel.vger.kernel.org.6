Return-Path: <linux-kernel+bounces-519815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B546DA3A23C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78FDA18912DF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E948626E176;
	Tue, 18 Feb 2025 16:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="n4X4zP+d"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2047.outbound.protection.outlook.com [40.107.247.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289E726D5BC;
	Tue, 18 Feb 2025 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739894916; cv=fail; b=OxCkZGPUaUhFnmX66KWVZ7C3Io0sBOfvq9S20nlb8wsFWgs9J7Uevv6EmaViM97ulQj9s/tsgOOtZZ8FEKNnvS2/3/w6giM3DVCPrhostEw+avRT0ERHZI+sqiDA/c/neIZ7JTu700m3rrCWQWokRHXGM7YSDPXqfkrIAvWtYE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739894916; c=relaxed/simple;
	bh=i/7UITyPIKteQvP4bMPU2SYN3fHEZULE72AD9CYEJFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YeaN8VONKjY+Smmx30OmoRYek8X5C1cQ5kYqg6wlp2qWA4HyEXFyj0JiFRslj3m0jj1JqYtq0iH60On1Uu9OTxglSzIfXy2I/zykc9eO2ajg8YRCus+hCStj0+d/Ff0RFZ+lQqySBc2L6fUv5NN4NEGnJzdFOZQmMRDnlmZndL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=n4X4zP+d; arc=fail smtp.client-ip=40.107.247.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QeBwtbHR8xSdcD/NqVvWgu8u3vo2h2nJHzc6eAPkVGajKSqrpAPJ9Khu+hkX6LIF7LDY96mDfl30QKwzg27v72VX+zqK/B9SJBVcqPMkwGXLsbGWjWo21Lrgn9NksUQoI/KDYqDCmVmo+GXLutOTUSf1+HgIhJ1WnN5ibN343u6b7X3OrsNUwD6UwEz7IjiaKKFEHrEb09sbT6/VoDIods/DibJb1YhJCKQKBhJW2U5fSqg09LX9fJ/n3m7DrslwRjHFeRm08FUx36TBx7EFNT3Uibrz/gVPBmtXY267OCAVJZ0VjnzdPRNWRAgYy2DRFEgbnJw5JIy9/xdr6hQbFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuMal2plC6Vb+9Wqzw78mqNclHj9QusQ8kH0aW5kA+4=;
 b=bA8rMaLUXtJn4CD1rsEdVYGKEpsdIKeEGY37a8KJHsZZiwvg8g8cenmF/DjU8FtVkfu6xSvlk5osERKt6nYeMwntOASbM8PzO+njGoifBBAILiSj0ijr+gAedGS2110X72yjMb3bO9GFN0gZmveN8EU++NVk/4XGpNMOvBnBmqe795UVgks6agw8vNGxuhhOyVSngDqT5w1g09WbysovkZouQHm7hHzUzPGPqiXZm/5Vke/trUZBan2Cc7lhDSzDUHYtloUwvJ7tC/d7AeFmuog0hWMjc8sQ/g6bLreWhamFE3Q594FRZHQgqMbvh3jID0BSOfCefc7YeH90+Gifww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuMal2plC6Vb+9Wqzw78mqNclHj9QusQ8kH0aW5kA+4=;
 b=n4X4zP+dPKvfKsueIc9xe/HC9PIbfS/rASTNfzt6O/EfpEdVYHX2jPUkM37W6BDLKAZpalRyoqQ1RSoVMaRjwtmnTQ5DE4fkw2qyQDmrx3quJbKCS6DpG3GArMN85CqA5CBNjPwfjzlx5e5dB/h7tZFg7TAgRukSbxHne9GoCKUCVkFzQTC/mVjCOBSwmudBd2CkS1gAsf0NOrB/rEKye6+cV67L27LQjU+kZscc3oiEw68MHcSNPxjy5crNWI8E8yO2IrYB977LJgksQ/lZFiOw1Zvrh/konmi4AczbN+3KKpULI1FryKxadJ8MBA0UdHsIsDqfWLtVJwCzzoJYAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10288.eurprd04.prod.outlook.com (2603:10a6:800:220::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 16:08:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 16:08:29 +0000
Date: Tue, 18 Feb 2025 11:08:21 -0500
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: clock: imx8mp: add axi clock
Message-ID: <Z7SwdQixnYLUMSiH@lizhi-Precision-Tower-5810>
References: <20250217165718.74619-1-laurentiumihalcea111@gmail.com>
 <20250217165718.74619-2-laurentiumihalcea111@gmail.com>
 <Z7Sv3yawaYdKFYxi@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7Sv3yawaYdKFYxi@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SJ0PR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:a03:333::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10288:EE_
X-MS-Office365-Filtering-Correlation-Id: ced94d75-db9d-4054-337c-08dd50367c22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rqos5Iq2t+r2DGoreay4MteebfWvs6oeCTYQEiFKvoLEo35usWF7og7Fsd4U?=
 =?us-ascii?Q?B+Kj2DcjCxTueTSWrHurD9TIqaFDtW1RX+UWQplY12REmLgeXPbn+/HVWftk?=
 =?us-ascii?Q?TTEHBRtY6BgHVXzlhC1WvFWdM9oAlEaohi0viEwnN9uVuEcFDZFEgZ8UPInt?=
 =?us-ascii?Q?T0867e3JMwZrborq0qkDJwc9S4GN3uUKhlRFK5ZS3c2qYB9ALtGLHEQ7C7pb?=
 =?us-ascii?Q?wUba7cT7JFV4Gsjb81EtG7pSfHSKAZZNwvDYUIhkpYkMWkK1ySEXxgEB1Dy+?=
 =?us-ascii?Q?auW+DQMT0RLe34L2pwXvsuYdVDztib3dAIewsStbFqUA4VVoCUwFv/LXfokX?=
 =?us-ascii?Q?l9xmn5i8U5feUtBMX0jWHPfCno4n59yGyod3NwLLBxlY28qWXD9u5WYGpP3J?=
 =?us-ascii?Q?gLu1HxszHqEpz9Lnyai+laqad1VxJ6sCUPzg8Z/3NX32ba20TQvTxJMNy7zz?=
 =?us-ascii?Q?U/xulq9PJN5ndsBUBBjrmCiFXl27h9r+mra/+vRhGM+LTvsFEzbYsYKNAhVx?=
 =?us-ascii?Q?W3ZmfuLol1GrzstUWREyanPe4/7LXT8VHthT5TlMWOmaw5VMArNWSXOWLoYs?=
 =?us-ascii?Q?9nglsJz1QFJEJ6OjSJ3EPNmyDO0ESzR2j+Yum0M6lVLo6pxuLttvX9h+PSpk?=
 =?us-ascii?Q?8LzwLCo9dWVyc11m0L7IX6mwz5I27cifLZZDMRgfzp5ODrQNc63sNruyhvUL?=
 =?us-ascii?Q?Yl7D2dgReeXMQ2HtZZUbNFWV3f7UEZbn8vsu9rbI2t7SN1mOpnE7Xw4jpOGG?=
 =?us-ascii?Q?nIn6q1czNlE3OB04mOGbACRa7J6VkN7teAEK3vY4f/9YSsyy+U0KZEDXo6rh?=
 =?us-ascii?Q?oeCnKG3eSTLr/Aet23kMog0pmkmfS++rbXQarCLoTYFxR9YFxkkoHyI6jIsS?=
 =?us-ascii?Q?Bak6xvZn4BzaaIue/SPyJLHrZEm5ZcQeezncszk8+BgblJHJj2dIdPcW5nMG?=
 =?us-ascii?Q?QwQyL0BQTA2vJsfizEkUqaPeapAwy2D4eVW3f3TjS5Hh6pu5JchRpRKtG2uO?=
 =?us-ascii?Q?2Qp+nYK3pv9F7xN4pK1Pq3RjkZyhN8f8KuaCVBWLsvImKEVyJeWjJgJPs9Ge?=
 =?us-ascii?Q?9fNblLQzKEqa/odICacBSMl1ads1V4Ab7t5MnZiMbUThfp3c8HCF0cETZ4n9?=
 =?us-ascii?Q?ZgqQ7xdvyReK9cbF3wiquC5UmY7z+2DydhPQ3WV5ntlN7VMjWexIVYhklo/z?=
 =?us-ascii?Q?Pret/P2JPscvkEAF66KodUlazdeS1P5q8kRYI5idyXgI/5big+HimetWAjOn?=
 =?us-ascii?Q?4pnG2MBltnJ/P/Sj4bbruK2crWwI6YZv6k3g3IN7ZKlO3xdpdkKyEOSNxr87?=
 =?us-ascii?Q?mXP5kpT5QVA7U4/vXys+uy7eBtwOYmiawlBAL4BgN7KorXV/XHtVmYVPatUo?=
 =?us-ascii?Q?mloomVaxllERRv2FMUc9z2LHNcO8hlGn2b+urawVhP2iK8Mjq4sSmvdCdvdy?=
 =?us-ascii?Q?nRUOCGc7Wnfb1J533AKPGOLr6En15l5K?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/xRnonChNhGYprUqTpfd91YcU7qL62Pju2qp2bYH+q2I2WfHFq812LVauUAT?=
 =?us-ascii?Q?fIYr2/2NPt0VrNHpoclyErn+P8AbLvyaSWCIR7aL4ohSABxN4dPd4TlYtVm4?=
 =?us-ascii?Q?L4B1qFeJUNsDDlSWCl/qBA4pgB9IphMA3NkQDiZUrUl4NEUU5oN30B4fUDyv?=
 =?us-ascii?Q?g9NiRwL87oYZteOW+GA0S5qBKllT0GuTdwuj7W1bw3d4RdIvvabII4EwIeN7?=
 =?us-ascii?Q?gh1fzq2wXVyBL4IW6GITXHzCzGGZT0Z5Sqxc4g4D89zw4dvgeZKEzcpDSWSN?=
 =?us-ascii?Q?JkyuqU7DJX4sjRGMfjwJRh4v4pGjGUG3DnEd7IFlOY4bZE8oJ/xI4FbAYIjq?=
 =?us-ascii?Q?5+rHGzCvhNgSp7Qujc1zZsWckBuDhBc+bDZjFf98+3rHkj+CQt/1pviYC32o?=
 =?us-ascii?Q?ynRYs2mruI8JYkquf0GLMimEi/Y1XxhHxSJgcmpsybRrpuSWOet+LZfRTMLX?=
 =?us-ascii?Q?b0I+918JwjyaQhQC5AmXSv68NqEQ437bleb9B9YuB0Ps9lFo2wv1yOIUcbuc?=
 =?us-ascii?Q?n46ZX2tDERUu7BqtmK+B5EPffzMnHiRPnVD1y4d0N5ozmBgJ1mLcMSFM5OAu?=
 =?us-ascii?Q?vmo8GpIi4L+HGsM/t/OfKZIKzqbHYKaPv5uHgUDCEkXN5tpMYZiJ22NAWbQs?=
 =?us-ascii?Q?Iu8PJQRK90vZ1O4rOws0qo01QIFOnTFcalxayzcBMJZoS1hSuGZtl/g4/Fox?=
 =?us-ascii?Q?OfzG2amzCgvBWw/FQgXxCptUoHJrxyydhTA7fLOvhkRWUiSBB5+o5xuG0Vx9?=
 =?us-ascii?Q?1w4pD96Mse/c1zIwz6ag+Pq34k+Sc5swSdQ8EUuPmW0zisiAnbOYzYATzkKF?=
 =?us-ascii?Q?V5oIm53Xr14C3HqUMG/87CYAQLtK0lwjaEKGXIbU9PnkpYBltnMQzj0CbGDM?=
 =?us-ascii?Q?0ZMEFtghw4ZLKjft3XDloEzMrt7cAO1hK8agoh5qodZfq9jAofGGF7+Fe6Nn?=
 =?us-ascii?Q?B9R/Hp3d36Y2QF4HmHvzgoiX0EfqKWtHmckUVCR8E1RqpMUNPgkSrWQ2ayin?=
 =?us-ascii?Q?ooL1WNWWlCURRq2M4/QwaERIeRPVNq4B3tE+39VU+p0iHPkwFGhbXtAmmMAE?=
 =?us-ascii?Q?h9vMsdSv17p7sn2LfZDN2ep5luSXZicWzolDox2CfvcaAN4JxzoqpS/o1thh?=
 =?us-ascii?Q?kIoGsTALjM1RF5AXVXIz/DXoQqs6ROhldYG1VjLb/rnOaxUrGeyaMlpn/CHW?=
 =?us-ascii?Q?E1cV77K8bxYbO1IdQdC/IntSSC5jsNgN3Bpa4AYjdDbxwSMYFjqnysFasUF8?=
 =?us-ascii?Q?k4asq3UJEi0EKpdmgrS6d5lWN1MCjngA0XKhLdqrvhZY5atQWjwdio8fT8OX?=
 =?us-ascii?Q?/m7G000QBQHhdETPBa/ZUZ71swwrWUMXc+6BG14KA76fNK6vcDYePZefprQH?=
 =?us-ascii?Q?l/sMcr++v4ja+5ogYRLW0T0PVkCH8eGLGl2eenYyWk7I+M2dC3ttoZJZmYGD?=
 =?us-ascii?Q?cVbsLiPxY9PwIcdy17SXNYkBGKUV7C/3P/aWs3mW5fxhzK1tb9SxZu5LApio?=
 =?us-ascii?Q?bBZC1J7ktLvTkBrsQ/WxVHiEU8MddSqxVJd7i+ygm3YUMlxNmV9grzHTiF8R?=
 =?us-ascii?Q?350/3hecJ5fa0bs4Ri+4TdDE5IlUSKY63qgjGJg4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ced94d75-db9d-4054-337c-08dd50367c22
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 16:08:29.8808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ruDTRbuwwcb6dxkjQP76E3KMeR6idpqinsiUDyphIWyMYskLgietjx7IPvJ7SiXXuU7OWztsKOjWFohSR+SWkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10288

On Tue, Feb 18, 2025 at 11:05:51AM -0500, Frank Li wrote:
> On Mon, Feb 17, 2025 at 11:57:15AM -0500, Laurentiu Mihalcea wrote:
> > From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> >
> > The AUDIOMIX clock provider takes an additional clock: AUDIO_AXI_CLK_ROOT.
> >
> > Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> > ---
> >  .../devicetree/bindings/clock/imx8mp-audiomix.yaml     | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> > index 6588a17a7d9a..0272c9527037 100644
> > --- a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> > +++ b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> > @@ -24,8 +24,8 @@ properties:
> >      maxItems: 1
> >
> >    clocks:
> > -    minItems: 7
> > -    maxItems: 7
> > +    minItems: 8
> > +    maxItems: 8
>
> Are you sure clock axi is mandatory or optional clock?
>
> If it is mandatory, you need update dts also, otherwise, there will many
> DTB_CHECK warning.
>
> If it is optional, minItems should be 7.
>
> Please run CEHCK_DTB for arm64/dts/boot/freescale, make sure no new warning
> added.

Sorry, I saw your dts update patch. Please forget my comments.

Frank

>
> Frank
> >
> >    clock-names:
> >      items:
> > @@ -36,6 +36,7 @@ properties:
> >        - const: sai5
> >        - const: sai6
> >        - const: sai7
> > +      - const: axi
> >
> >    '#clock-cells':
> >      const: 1
> > @@ -72,10 +73,11 @@ examples:
> >                   <&clk IMX8MP_CLK_SAI3>,
> >                   <&clk IMX8MP_CLK_SAI5>,
> >                   <&clk IMX8MP_CLK_SAI6>,
> > -                 <&clk IMX8MP_CLK_SAI7>;
> > +                 <&clk IMX8MP_CLK_SAI7>,
> > +                 <&clk IMX8MP_CLK_AUDIO_AXI_ROOT>;
> >          clock-names = "ahb",
> >                        "sai1", "sai2", "sai3",
> > -                      "sai5", "sai6", "sai7";
> > +                      "sai5", "sai6", "sai7", "axi";
> >          power-domains = <&pgc_audio>;
> >      };
> >
> > --
> > 2.34.1
> >

