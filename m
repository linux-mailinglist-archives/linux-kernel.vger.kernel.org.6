Return-Path: <linux-kernel+bounces-204689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CFC8FF273
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6174B2B81D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BF919B3E4;
	Thu,  6 Jun 2024 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K3X4n30N"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61500199E96;
	Thu,  6 Jun 2024 16:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690726; cv=fail; b=VVmIi+l931KclM3QQHq8V9QAIGGn6xMUxSOAl1ZXLT4w/QJRiLcdUWcS4ReNzG6INM6K7lKCNS8B9JHm5KLNpX+fdi6vGqxdbneoftxPwm3DWnBMVGsc1Iinea36ZbISiA9BfRUy309RExnnJe6rOHBLsnURQh9/BfKnOfULGkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690726; c=relaxed/simple;
	bh=F7F3rmMbMEDLvIwSL/wW21j9DSd3T1qI2TN/B5/rFbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VSFIfNDyzbOMhMdqjOUZVbcpUnPqw712TcScHTxjQAOEBqgzNki2ohCJ3xOsD4sr5zjt2rw68Y8icFJ0az9gh6XzQhmBYqusQScE7RORToUsfPd2uMPxyq+PElGYAg5C41XHh73S7oGamTOJWM/4zNucbr25+bnMOM+pn1blLps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=K3X4n30N; arc=fail smtp.client-ip=40.107.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTG4clXC5twLs7+wU+qpB+rH7r8RVgg0mts5AEfbmUmKSWwNffws2zn6JI74wJGJMzdBJYY4eF5AeGCewZ1fx9C+WA2wYXe9sWXVkjpGVat25P/g+vJyekuXDdmJoDquXk7WVtSaDAoJlCKKBg6fYBPzl2VrXZT+2ay6rQHaV3cXXZ6gRJ1yV4nj6THcAJ7HPKZzSwcv/KK1HoDxvlT5WvaAwPkDrntbPGwOE7uh7ldemG6i10CQ6ZIt5Q0dMjK21tveGEKNznlp4M+b4zsa6p2q1WOAXIcN6nVaLKwptabZ0th8Xi3ZaWvmyBV/jaMh5eU1e7A1Dzob2EQgQS37MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYAu33795QYQgVBvOw2QE6TH/F5FGMR137YrYxQO+fA=;
 b=PPJGwvL7N1//70RFrzjVdaWKKnxhhVT/hi4fitXIWjR6uO9jDUg4x1N7/VmV1fu/IFI/ELkCucJGrScx7vjgeIU6t2iFRWNsXmsWw6Ev746OlyZ740OFjVqd7ieJLr671sHt1yekXHQLz+VaWuI6fEbJv1E9cIMMIZNW1E3xLEel9Mqat/tJSw9/6KFSoVB+9O7GPKrJePPzNjHhA6H/YTFqa/SJt0nwQr6XiA0EagT4C35Lr9oOs1U+vt/muUx8QacOjqoPULCMbJn5dvS1UuoJmNlM9O419qEcb+0iIVy5W0ze8n4hxxe8ba9ppAdsq5c2HOu8qng9dTTkHnqAjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYAu33795QYQgVBvOw2QE6TH/F5FGMR137YrYxQO+fA=;
 b=K3X4n30NroA8GUyDDEEn6ZZrrOIUHJT0SS6xepd993KNOZXC80T5YrKV1LCARUdJfRhCFZL0NC5MqupfwooGBfND6sxXQpKIVErG3mgopIld0Dr83TAvST7JTMuVZk+ljO2lZmMegfsNaGx4bcsaHdf9mnm1mm1pfrWL3RqvB7I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8147.eurprd04.prod.outlook.com (2603:10a6:20b:3e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 16:18:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 16:18:39 +0000
Date: Thu, 6 Jun 2024 12:18:31 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 1/1] arm64: dts: imx8dxl-evk: add imx8dxl_cm4, lsio mu5,
 related memory region
Message-ID: <ZmHhVyT3qs/TjmWv@lizhi-Precision-Tower-5810>
References: <20240605202703.1220203-1-Frank.Li@nxp.com>
 <171768925588.3793206.4383956652676926878.robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171768925588.3793206.4383956652676926878.robh@kernel.org>
X-ClientProxiedBy: SJ0PR05CA0078.namprd05.prod.outlook.com
 (2603:10b6:a03:332::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8147:EE_
X-MS-Office365-Filtering-Correlation-Id: 37413318-8516-45ac-7d29-08dc8644537f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|7416005|52116005|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fCxRyz31YNXuv0ntIlW9aSCvSYdNJrT0j5Khz3YSy0+YGsT5yfUdnFYHD0fV?=
 =?us-ascii?Q?Zsmqpcv9/Hd/KXewtnzazMPqE4TTXQcOe36k6rYWynwHCYF8Q0oRVsuOzu1s?=
 =?us-ascii?Q?xrAA8BYuZzH4oT+ZwP1fMI0DVGdiW90D8qccH7YE0v0Iw5rhxSoA5GrWjFCN?=
 =?us-ascii?Q?kPKviGKYf7zkVI9jPmFXpqg1n7iNgLeBGf3xuC+MdcaQ3R2edpLVi+3TV5Wy?=
 =?us-ascii?Q?WKO/bRFJUcK4P8w+B+H8Jrcarj4dnPLG/Em53zAqzHQFbU9ZDoHZbqoLJCWh?=
 =?us-ascii?Q?jA8j8EMy9tQjQ50G48k9Qep+WJuZjYC+l3J1xuwcpxdimJdkN4d+OaTlkugC?=
 =?us-ascii?Q?Cswhm/Ap7bj2yDsVqq64G+g/+/copWYKiqpxmhajXI/3EY7HmBEtglADLD2k?=
 =?us-ascii?Q?jbInoemhDEt23ak4V2U0tW5tkI/irUFQgSuW29K4VeWm22yK7iqVIB2pVtvF?=
 =?us-ascii?Q?EMaQLm4BDbBdlTUR/nh5/D1S6nscUdlMJkqbUKmhSUtOrFBLlLIgopXGAhZ5?=
 =?us-ascii?Q?mgkOS0CemMlEW+0sli2JM55p3oLb9Rm/zCylxee+d4JLO0sAKrkpXdEyORa4?=
 =?us-ascii?Q?XZhDVxnhaa37ccKjjCvZZipnZ9oc2ofiUAIEJGIj1tyC8bkyK+7N6+mKDvGe?=
 =?us-ascii?Q?XlsInas9T2eATCxME7tFXdRuMzctFgJRK7RrO7lFgdHu0SMVZ9ZXk2I0f4cE?=
 =?us-ascii?Q?eS+vciwZp4IzaSexjdZFcwyvqmg2BPx1GARKoLBv4UtIx0y3LLloYpMae4xL?=
 =?us-ascii?Q?LhAtBsf5BYULnb0/WQqgd+rVQisxaPBIClDgfBjhA+BzotfAeU0w6qonfh5L?=
 =?us-ascii?Q?xrx7gULcYOVYj9EKsq9f05tnHglhu8ayOa/bvN+itiuD5zpcMFaCSWzby3hc?=
 =?us-ascii?Q?KLbhD/eU0yXf/Y9k583ccoHwX5KMh9+8NFGR9Ds7eTw0f5vfOJZC1rbtlnrg?=
 =?us-ascii?Q?0lDZHc1a4ycwAOBeYjXrC1os0F53ak+gNA+jUkvMrIaBWD30bj/TtZ/okHn6?=
 =?us-ascii?Q?3BTtSlANzW4Np5WdDncEr0ZdJUJOqQefNRauiGFnGP8Q17YyFKbyXm0hxuwB?=
 =?us-ascii?Q?iZUSNWwEOHz8lSanL2cmnSosMgECDdscfFLouoAfOQCnnMHCmGg/gTWrkj4V?=
 =?us-ascii?Q?/R58bEN3bcUOhSztxuDZWobDwb9S1l+UXy05FeFvpkCEedmePt9oiqKjpBSC?=
 =?us-ascii?Q?fPFScoDH6ibDXpDVCr6AmeMcV4ooMPbJ3XSnahincabHVLmmz80Suv7F+23M?=
 =?us-ascii?Q?8CN5BZyIntOWWoMn5IVazb0Mb+WxU0+E5O0amD4pKVtUOd+Rzn8opBnDTdpV?=
 =?us-ascii?Q?LcSN1mVHYvPOdwt2FFHCfLeZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(52116005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?miCmHad2woiaMhVbQ1OPELLZ3qqG68lcZrWZQRMWrmzcS0zo29aTMBk9hvvB?=
 =?us-ascii?Q?G00A/U62Q0O3n3xQLUVL2eeTfoxzNf0e7D+XDEtp1p+tGJM6GHfanbyj9gGX?=
 =?us-ascii?Q?pP4iaLT84f5aZNYEO0nyhkNK0jz24FVbdgmT8U1AMy4HcJt47Sl5EWMR5cs1?=
 =?us-ascii?Q?uuLsKBn9VDq1BkMj1KkhZOzADZlVvCfcutkpE4ntxx54BMbqNtMWAxfHflKs?=
 =?us-ascii?Q?3EbEmxDJLBitPTZ0t5OR+qWPKLQj+8l48hxxCdXZ7qzL4ZpFXgo4+261Tnvr?=
 =?us-ascii?Q?oa/wEXfFIqygYp6+ferVJSIvRlPKfYfkNCgLWr9rrStteFAflIFM0tvPOIcM?=
 =?us-ascii?Q?l8n34TsuEsDwG0D8okV3ILz/2/52NGTecQw+Ma4cjUcOdwyK7tnNoH0dBj7/?=
 =?us-ascii?Q?ZOqQ36LX7+Ss7gJB2LywoTTHuq9NPqbVKqZPD0N4U+LJsSjiT8gNFIFSQMdR?=
 =?us-ascii?Q?X1RIifEjITgHdE/gZ4ZnoCrgrslYVlCQCGze+GvvI63/JdKlJe21hwCh9+2V?=
 =?us-ascii?Q?gQWEVqqRfBprhR3YZmzaHfaPXZj1XgjDUxndaNofQuqNBxRq+rzPqDGmvWff?=
 =?us-ascii?Q?b0QqjyN7N0fYAbmo7jb139c8adXfH3tgOv8zPwb7/L/Q7uodmY0TcG7yYDJh?=
 =?us-ascii?Q?QmIfIVwmSQpshG5+o1h9+5qnYnKfeq3PQBoE7Z02fTNkGz7jQeUsmjIaqTQN?=
 =?us-ascii?Q?0z7iZ4yzL1JAmr2VDkNMcdar+ZMsQzJBbwcGmIxSQ+dR8IlqYurP8u+VaSTO?=
 =?us-ascii?Q?FZA0rg3m9W3ksW8YrEubW9gzZhYuA3XVwFxEW2cL+5gvZ5ssY4XMpAf6va3B?=
 =?us-ascii?Q?IyGXwtd/biqekKdj+62AakkOYDWFST7+eSH+dzsaUPPcz8qON+wmtXJdvZ86?=
 =?us-ascii?Q?fUUTzZJ6IzP718qJRrzjDPgDT9BUV/bhuW8thBKK6rEJCLPsmZ8RA3yteo3i?=
 =?us-ascii?Q?hAPUl8S4wuNg8HiDeIAGPDyPZ3TO9fmOj1VA6r2Jts9TvofC9C80KN2KlTml?=
 =?us-ascii?Q?ZtEnROohCQ566wckVR7IZk2FNs+VQ/1c+rMVs4DG41t+3eCPXrj5S42L4+ZT?=
 =?us-ascii?Q?g+45ilJc/W5jIYpjIrseYdJj5TNXPt8cneDZ1Vdp5Ae6lIeXS+G9qIE66xLq?=
 =?us-ascii?Q?3X1bkHXCOVuipM2Pvg34xkhL6CoAZFVcBWHZNAVy0wCuJSMnVCS2qcuMfqbe?=
 =?us-ascii?Q?Uux7OFvDTTb73w/sBy8MxANymJLTJOKMKwITFikWvpSTZB8gciIU51uHXIJY?=
 =?us-ascii?Q?0lywvQ1urkBidRPsXUqW/cSFxMcFY97Whi84o1RObr/E5xMpZYN5PQPVqWL5?=
 =?us-ascii?Q?AYGxBtrApVU9VScpx+XzToe939Q9d/5YjdkQklo/edkKWnUT4b6Z0jj8Yczs?=
 =?us-ascii?Q?ENPs+MpqDocpuQ3ZnImi2DNVHT/uqhV/7Kvo6yArCS1ISDazLMG1XJSMjEdQ?=
 =?us-ascii?Q?sBIwZQHk+W37g0EVKB+Ny8iUB3NNRx8FJp0+pn7ctkYrFi7kazzY81pE5jR4?=
 =?us-ascii?Q?8jQGsiZyk2+ZMzIGxDC1suDgIHuHJkTZhL04hX480zN3JHz1SYmI2eQ05dYN?=
 =?us-ascii?Q?ZRKSv9VcLflCbJYiD76TFe6d7/zC0KEox/Dg/RTn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37413318-8516-45ac-7d29-08dc8644537f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 16:18:39.7244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bGU2xk8AbS1tvjpax40B1gNZNNVXcfdFMFNoASW46pQ0YgVXBbSODnlRklbMXkmYamEF4y8GmF2eGNOyLlmPJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8147

On Thu, Jun 06, 2024 at 09:56:14AM -0600, Rob Herring (Arm) wrote:
> 
> On Wed, 05 Jun 2024 16:27:03 -0400, Frank Li wrote:
> > Add imx8dxl_cm4, lsio mu5 and related memory region.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 48 +++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> > 
> 
> 
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
> 
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
> 
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
> 
>   pip3 install dtschema --upgrade
> 
> 
> New warnings running 'make CHECK_DTBS=y freescale/imx8dxl-evk.dtb' for 20240605202703.1220203-1-Frank.Li@nxp.com:
> 
> arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: imx8dxl-cm4: power-domains: [[14, 278], [14, 297]] is too short
> 	from schema $id: http://devicetree.org/schemas/remoteproc/fsl,imx-rproc.yaml#

Rob:

Fixed patch already sent before send this patch. 

https://lore.kernel.org/imx/20240606150030.3067015-1-Frank.Li@nxp.com/T/#u

Do I need sent both patch together? I faced many similar cases.

Frank Li

> 
> 
> 
> 
> 

