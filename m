Return-Path: <linux-kernel+bounces-294453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC89958DD3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 20:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F16A1C21A59
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52641C3F14;
	Tue, 20 Aug 2024 18:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gs2VAzjJ"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2044.outbound.protection.outlook.com [40.107.241.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C341B9B32;
	Tue, 20 Aug 2024 18:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724177498; cv=fail; b=YLCHrSYzlOBKNqlrOj5g0RqHbslWAZ4KAVNL6NpxgXQ/wEHTa1ZIxjXWSutAVlfum98wCYjcEJ4rgAB468vwbAoTE+/lAa+NPfFDqLana0V3ke1ZVruTUodw/1/0FJUUGBqmF94ldNzAq6zYiipnCrOnDPCDteStfmZqu3BAako=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724177498; c=relaxed/simple;
	bh=JK6j9890H5mF+MJpfratEe8G9PLez6ZCYKaFiEWMktk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q8lYNzxp5Y99o4Ei+W9l7ONAGTTpbEghxwsjEbehiCIenp3hYD7wGQjFgwAGgdvE0QoFMCjaS6+JQjZ0uk4krAuujSgI2cIq48btk55a2WhZyOVhpzlzuTgo6miaHny1bzlx7C/AU8DG9oxIGoybBmHCCTnHi/K1D06VVqwISVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gs2VAzjJ; arc=fail smtp.client-ip=40.107.241.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aMxUaHdwgbj6XlRjfQU7QtJo36OXPMdz3N7vqIBjbtHHcBx0qSD5s/Md7QxCJy3nQBQ8K/SMPUm3AgfoDELdpyhZNj9VNRewf6KvPucgHb4ezFts5f+mbU65FOSZod6tzkqh2aZlp7ExYdIoa84ZycbSxh4TcFNlMz5li/QtGICXmOKLHgqgakzM6hcv88COEdv6HDey06ka/fuaNK98ME6W9EyymsobHnlIi63n4Ox/nZXkcr/GxZsvOQbnxXyI/zOXYXt1Nf2Y8uOTKaudSC/g5I8utJnnolz1T/prWW/br8TFbmXU0mPuMAQnCdTXC4Ravll6VkoU1iNdTOs++w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OeHeS+45fKHXjJb1yX4w7T5er3Nq2rUYRw7xbSXd+dk=;
 b=Fd0rxNHzBh4nfKRRTkZ/FZ/cGt4bM14FzwRF0mWYH9XEmYmcvXM31Md+Rtw/rXuz310g1aKQnXFduzbX8eZj93kovFsqISo76bN7Yl5BW3mXLsbW+UuCqpEuoXw6foXUrZJR1M5eqFavTi9wgCNl7MbkzCO68rqwzUAk6LA8Ugil4mM2y2246Cy4iVaQR3GGzwJrGkz1vEuD/d47O2pxtNwKM9lmZVUoEvJoPHN/DIm7NP3Ml1YMGYvu1O2AjX+7J55ZUm0XUACQaVLiXevMU8xRvNtexc3WFCYAg/0MdPwYNYrFi6L3x1g7xHSCG+1OG+ylFdfe99yF9oTv9bV9tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeHeS+45fKHXjJb1yX4w7T5er3Nq2rUYRw7xbSXd+dk=;
 b=gs2VAzjJf4EjL4oVNyFHqVDv0nlpKOaOWpUuNTE6y7PQIjF6IKpTcbj/md76whJBzLmjWMlngpPhhNJ2M21KD2fSKLcbg0K2+qWwaeuQsYm0x3cjq90W0ZgJp+mWoT0FhOArtujnPFlhrDsfD0uBiQm/7vnGc2RW6Gk++gvcdoe2MnIPZTaXo4p72gV2gfuGwKzBCOX/sdChTcb7zUVkPHulxFK6ZoYmUQv/N0V74nAZip8jABt2Y94yPQN/jnyxzONQ7QxfQD1Vx63JZYpZ0ctI5HteSZ5S9vVkoukQT+sbfZceGTdVsBYTkKyMwPTqjoi+IKgFTEPobavi0WFrxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB7059.eurprd04.prod.outlook.com (2603:10a6:208:192::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Tue, 20 Aug
 2024 18:11:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 18:11:33 +0000
Date: Tue, 20 Aug 2024 14:11:26 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Walle <mwalle@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	"open list:MEMORY CONTROLLER DRIVERS" <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-binding: memory-controllers: fsl,ifc: add
 compatible string fsl,ifc-nand
Message-ID: <ZsTcTt3Fu9ttcoYw@lizhi-Precision-Tower-5810>
References: <20240814212958.4047882-1-Frank.Li@nxp.com>
 <20240818153914.GA120816-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240818153914.GA120816-robh@kernel.org>
X-ClientProxiedBy: SJ0PR13CA0085.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB7059:EE_
X-MS-Office365-Filtering-Correlation-Id: c349eb68-fabe-4b37-ccb9-08dcc1438602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Uu2E6svknJvXvhzqt+ZGfR+w2H5Db2C/Ld7whrLTK7zXRyV4a285I1ZFA1CH?=
 =?us-ascii?Q?/b2f+pNu5HUFR6WhjLouAIU1yChmmbBFJJGJDrm0pzKcW+ZGflK3Y4w8lCy2?=
 =?us-ascii?Q?hKrxfoL+b2SsCiJvUVgBR89L3VmGrYXgAdMnQAuESeaBO/DjqfUvBlvYizZY?=
 =?us-ascii?Q?76sxhOY1ussWwPFv8Wr3bJzaShvtwbhf3uRRefZYFxNSqH2FwnX7uD8ddJgY?=
 =?us-ascii?Q?Uxd0y9CCQ8DEC4vDoFzeL/XcuZQONO6F8gGBtVu8srswWr9Hndm0xif7D8kl?=
 =?us-ascii?Q?y8VGi94vzwVdPPm48m52AhWVuhsmkRUVnzz6/VMys4OHPYZMO+j2xSTknYyt?=
 =?us-ascii?Q?NCpl2DS/D6WtFxr3268P4SPKGw5agS/D4ZSMxjitfnBO2Qua3ypMEKx62Fsg?=
 =?us-ascii?Q?cQv+UgWSaEm3rxCCq9Ay5A/JbA8WeIvXmoASQBd/4yLBi5kYxiHjs8+smB7n?=
 =?us-ascii?Q?UAeUTkuWKzjWUkkO4hiPMcvrMQQPDOmEWFQjG/66oX5HfPbLxnQbyFpkkAMq?=
 =?us-ascii?Q?rUGn76wgQ3yYEat20kf8VHpgR3I3Ungk6qspw41dQapOgRcijpXR5DT2ZNC+?=
 =?us-ascii?Q?8vLAwRJWcl1ITyhQnw/mFbe0Trki/As979Duhvf6CLigoxQlhPDo0x7rMz+E?=
 =?us-ascii?Q?Vp3Bgk0PRVlOaeJ19/zt+AzQnDknmzZShx7RovLlpgwDIGtw3eGdCBajDvrW?=
 =?us-ascii?Q?9Af9Q5ulnz52DSRBirF09NkZ+0aDyMthr0NYoWzdcjzpB5RAY68YJGqEVnTP?=
 =?us-ascii?Q?C676sCK2S2ImH5Bm9KmmFGeqDIybpXp+BqPSAVRdKWBzneg8DhuciajogZ8s?=
 =?us-ascii?Q?bhFClx/R/kl1LHI7AZM3+8AbT0pkUd7dgWt3qx2LS6z/JZbncLkdGEN43EMc?=
 =?us-ascii?Q?i8Djo6ljhk4VZj3EB2nrYaf4YDN+6kb27OT02wvfbJAumpztyw8dFge7wyWK?=
 =?us-ascii?Q?4PNyOEhJFIlSVaZRr3ENKeK+h9GpmnywMupLstUN/1fpTImG+5BiAroWd4cX?=
 =?us-ascii?Q?QQsUCXmcT5Xbg9KZ2mEWinCKkLcruPzzl0eS3aOujZk9IAS1hwGadMVX9zV1?=
 =?us-ascii?Q?08peObaRJaJQu6MkNTxX4Xrl0kKGGGdF8qlZOHDTBUn8OuXnEVe8/qabiVJv?=
 =?us-ascii?Q?uB32yZhW2+xsTZC40CBcEOwnYv+k84oSMDrtE/V83wbbhzl16P7psiRh7gTX?=
 =?us-ascii?Q?fL3bYxi3gQZFewNKmAW6M8BRteH/Xj5Bp4kBH7eoGqbk0cJG/6vb8ILqZa32?=
 =?us-ascii?Q?wDbjagB4BMBQa+XHHDa3GTG9dSc6vFJAcKq/oGO3N7ZKQcAw+skpGKHakepO?=
 =?us-ascii?Q?0kmtMgOO41pHHbubOjgTPbG4pkyK9XDmmpIa4u1qAkLInzLGGJyhfIKWc41h?=
 =?us-ascii?Q?2j6ADlwkHYLCSyzvSyRJl5t4UgorbCi4t17bsoKl6Cz4a4WvTA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gOi6/Qy+XT71EH3JRdds3xdbgEm4uP/UNbZA3g/g7GGR5YueJ7N/qA+vxg8j?=
 =?us-ascii?Q?+GBhlZPYiH/Mv04UQQsCmGSbHAJAsagRE5TH21DUQxUqS1hWzOW7ZrqZp3e7?=
 =?us-ascii?Q?AtBSotv/5Clra8ht4H6vNUJQuP8sZbqHgQZhIdoTObAbGT5iQwqF3F3BQoXB?=
 =?us-ascii?Q?du67jwfOsiRpzkP25oES1NertPsjcw0DabK4MjHVKfaIYcOxUEd/UvREIPM9?=
 =?us-ascii?Q?W3kWaAZO0FoOfh5/wzGQs5e93HRKmNSQ/4AUg+JRgmfzIr7HRsvjaicz1E9n?=
 =?us-ascii?Q?0VVwRCWwK1luFRMZn73ZDMLvBTRNg45B4ojGBVt1g9hZROTvYRQL0wSYIKP+?=
 =?us-ascii?Q?WrDFl/fxY5rNJWPa6u363h+4Gx6EsvUNYWDt6g7dy74bvwI/KFzixDRD7r7Y?=
 =?us-ascii?Q?8Nrn3dDUShCab0xzrUtwwRfXxucZycy3JTYxOSOYkqRXjuLU6FhzFcStQ8T9?=
 =?us-ascii?Q?7/FZCzk+dhy+ICMJaWy9rhF++kzteT6bNlFiB5HDiykBwBpAYPDmA7u9hct1?=
 =?us-ascii?Q?1lJi2XsGxAJCp2mnntEWdgKK3HIDdi9rZ3j87yRERbv9NfTuKqgy4PvciqL3?=
 =?us-ascii?Q?jYuxcmBQHm+fgvb4tY+wPnzD5CkArB2xZa3f/7SA6TT6r9GH1jNtVL9fsTYb?=
 =?us-ascii?Q?L6GdWg1WClQZjTfGMLwW189NK98z3lNqGB5dRPEwJ6MzSU+qus+NVjhjccq/?=
 =?us-ascii?Q?BkuCK3udvoPrBmaDLG9+1XTFJobp1WSo50/I2HNmgh5ZpAtMlb+ADnhqcyWq?=
 =?us-ascii?Q?hET+6+DvLUlobJ7EtPGosNFLS2Pqln7I5ByKvgYHuAAxgWgeGVbh8EPFMJHd?=
 =?us-ascii?Q?b32pv0TzBj4D8wVYhxb0ATl5rUw0s2Q0jjIHMlq1wgiFc0tAeacjxIinuyAQ?=
 =?us-ascii?Q?/rmt7DPBLc3KqNJIIBR5i63upift7e9sOoodRiFJ3gIkHit0BlUSDq0ZlZgX?=
 =?us-ascii?Q?D9EVdlvEfEsncULBmrgAxj3Wte0mIw9lxGFeGiplOu1u2o3V4sfseFQUtNzb?=
 =?us-ascii?Q?c203tdllCes5G3vTPxk8q2yK8XhU/+ZGYQPktFgMpC3ezW1ibsb+Xk0dmUDd?=
 =?us-ascii?Q?HqYC8hAG45f8dHd6hDSYlbkwBAdnvtGc128oJJ0H6cXI0x7jsv0HBPzt+Tjl?=
 =?us-ascii?Q?UsOCtMp/vfpy4LUQEDwRaEf8vnGC2UGjZ6QZp3k/PBqDUAIEQU9caRBQEL67?=
 =?us-ascii?Q?PFRx9kwZ/WGAfcZh7orb1yco2i3V+9TIPmUiwk+LHLB6+BRX2Z4ItjROvyUE?=
 =?us-ascii?Q?HpdvFjYWx5konbxsxB73zXSAZjJuJawl6gstnn4hcI1ho70F76HcPeqRXaaZ?=
 =?us-ascii?Q?9DweCKEUVmYbtKyU8h8KG30ywv0Trk16XBFIP858FaOT1JCCs/HnMtd4GxKX?=
 =?us-ascii?Q?MCsDDiooE0jOQ3x4NHqndbfI8LQ7y/9EsRLy8UWzyWjrLupRNs/F0265q+GE?=
 =?us-ascii?Q?Qf8A9YfDcw4Py0boZPF7Cflw+cn6DAMtZPxw4valOcVxq/u3gUy9qeZEydet?=
 =?us-ascii?Q?50x6OTJh8exc5N+RvFRk+bjW+jnPXt2Ue8GGwpzsN9GB+ineLTXOq0kx6SSS?=
 =?us-ascii?Q?lYAKJGiVUSAaKx5VbY4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c349eb68-fabe-4b37-ccb9-08dcc1438602
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 18:11:33.6393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GoLYOkFnCORRaI2QUydwfDlgGHd/wlPupS8ryYwxFRTINc1tbpNdrnQD1/xUKx5jW0oAF5D4z5kUDocuNQw6nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7059

On Sun, Aug 18, 2024 at 09:39:14AM -0600, Rob Herring wrote:
> On Wed, Aug 14, 2024 at 05:29:57PM -0400, Frank Li wrote:
> > ifc can connect nor, nand and fpag. Add child node "nand@" under fsl,ifc
> > and compatible string "fsl,ifc-nand" when ifc connect to nand flash.
> >
> > Fix below warning:
> > arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: /soc/memory-controller@1530000/nand@1,0:
> > 	failed to match any schema with compatible: ['fsl,ifc-nand']
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v1 to v2
> > - add address-cells and size-cells
> > ---
> >  .../memory-controllers/fsl/fsl,ifc.yaml       | 21 +++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml
> > index d1c3421bee107..c12bb7f51db62 100644
> > --- a/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml
> > +++ b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml
> > @@ -58,6 +58,27 @@ properties:
> >        access window as configured.
> >
> >  patternProperties:
> > +  "^nand@[a-f0-9]+(,[a-f0-9]+)+$":
> > +    type: object
> > +    properties:
> > +      compatible:
> > +        const: fsl,ifc-nand
> > +
> > +      reg:
> > +        maxItems: 1
> > +
> > +      "#address-cells":
> > +        const: 1
> > +
> > +      "#size-cells":
> > +        const: 1
>
> These only apply to child nodes, but you've disabled any child nodes.

I will add mtd partition for it.

>
> > +
> > +    required:
> > +      - compatible
> > +      - reg
> > +
> > +    additionalProperties: false
>
> You could minimally make this 'type: object' instead of false.

Sorry, I have not understood your means. I already set nand@*** as object.

nand@[a-f0-9]+(,[a-f0-9]+)+$":
  type: object

>
> Or does this follow the nand controller and chip bindings? May not being
> older binding.

I check if-nand driver, which have not parse other nand controller's
property yet.


Frank
>
> > +
> >    "^.*@[a-f0-9]+(,[a-f0-9]+)+$":
> >      type: object
> >      description: |
> > --
> > 2.34.1
> >

