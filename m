Return-Path: <linux-kernel+bounces-311751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7180F968D08
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 19:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F33011F23F29
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9209E1C62AA;
	Mon,  2 Sep 2024 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JWa1RZ1m"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2086.outbound.protection.outlook.com [40.107.104.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE261CB52F;
	Mon,  2 Sep 2024 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725299873; cv=fail; b=KHMxVbJN75jZXpXtkbXqviAsxbXofP+kQsEr4zCtbgHsLGfpYU/82olfy54XTR4A+osjcvq9Tq2mEQg8fpnPth+ivdcvAf2V0cCl5UOPdqrd6Yg9mL2oRWVUMp20ozRdpGxHsax1EqWCqwTHCCwz9eQ0vRFKONhpuPRK6EV+yJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725299873; c=relaxed/simple;
	bh=j3pDmhylS8ET17XfRS1yU1Od9iQSdD/jRFrpSJv1+n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qjh1rMBf8ENTBvkWbXL7kRm9RoG0E0ikngoBhOApHiZZvwtnZu239hyelQFxyb3q7I029U8bOTJVPPNXChYZGf/wwmpXfYpwUloDR/4pUM7Miwn5z4Y0gDCcsQABQLq4sYGMLOxDNQ+XFg3QUpRoF46CxW4KmgW8wGh3o931GGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JWa1RZ1m; arc=fail smtp.client-ip=40.107.104.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nboqZooeSLRlIKEJvyjWIhXIf+Vd2bNVXikqlMfZ6ej5mydueo/ykhTmWwPhbfZ5N8dw5WLoWzZYOewWKwHuqeti2wFgc5+OsdSRFE1Br38eTZHv/V+v0sErVdPpWwBfTH6TP1urUR6YZNuG/HNEl7hnF5md9egCK7FeCAQftLUeoKGztMMfDosrE8BOhcPhMKUDvbGDWVZ+LNntJfitbk2//c0vO9A1PnEiUNRWJvQW+bQliIhie9SKM6kafd7NWLz0m9GYoNpF9bcA+4HLWhzYpFqleHkgerFCSa/tIF0sHv3/W9t2tDmxaYLFEOKibM/Wy2tbWrMTXDRuZuADiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fg2MmIgonyxVAt2WM7TF7uD1+1DLEOMk1L9IiB9+9Qc=;
 b=UmaWrRheqrY1AVZsEHANInlvt40s6O/mkwaGeS9uOSeBo4jPbjQ8+f9AxZPIURuSDdKlaEGGVg69gGKO1JCkFf97tasLe4mhHSMNDGRlQJsO7o5KXzDbnegE8F86taw+BtFe6Vmv8YAn20dncE4/HksAVYKL/hH5wOf2OaiibrfES73vhz2Z07gpEx8bJ9Z2jI7koJBUyv1+h+WDPrUBbuhNx11IFpiWlDP1C6sVzz3DlwYzEiLd4kV+SNDcbiu0I/mlLpYfgz783uuqsmuOg5F11mULnPiYrGLKTRO938pxNE6+IBC8IF6OsfqrobN9G05CH0BxBz/CpWEr2/ULKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fg2MmIgonyxVAt2WM7TF7uD1+1DLEOMk1L9IiB9+9Qc=;
 b=JWa1RZ1mMkZMbEeOZ/ypo3HNmUYn98sSlpD+aWf8O7QeLLb6ppDIHyCNDYGI7vGCc9eXPpvxZuK1w1wA9c9Gjf5DtLqOCVuimYFFucKymthqwPpIzvcQ24oCVtTtA+Hyd2XpiVD3A2RcM59v3E6yYHl+mL7Z1xALvNab+KtwvR8ewJzNVVzLMoM8LhY3d3Hug3I5ZIX8ozSbu3H/zCenqLdi4OfFYKnbkIhS23vNZS5+iBh6bGPX8iAuolaPSZ9U1HawdHXX4PdBOw9RxOjpw4HY8UrdEMthDJjfWBVTdyAgYOgrsHaeqHvjvOmv9lsib6C0ns6UCnWDiYDTZn+Ytg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB6891.eurprd04.prod.outlook.com (2603:10a6:10:112::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 17:57:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 17:57:48 +0000
Date: Mon, 2 Sep 2024 13:57:39 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Michael Walle <mwalle@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	"open list:MEMORY CONTROLLER DRIVERS" <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	imx@lists.linux.dev
Subject: Re: [PATCH v3 1/1] dt-bindings: memory-controllers: fsl,ifc: add
 compatible string fsl,ifc-nand
Message-ID: <ZtX8k7UB/Txri5HF@lizhi-Precision-Tower-5810>
References: <20240830191144.1375849-1-Frank.Li@nxp.com>
 <l2xjrs7txycf3uhhhyzypfzoem2fr4fsvbyg3bt4ktfpbzxz47@loiytha55oml>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <l2xjrs7txycf3uhhhyzypfzoem2fr4fsvbyg3bt4ktfpbzxz47@loiytha55oml>
X-ClientProxiedBy: SJ0PR03CA0103.namprd03.prod.outlook.com
 (2603:10b6:a03:333::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e03564e-967d-4eb6-4e9e-08dccb78c144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qjM3GUoDV7hRtoq7zlICDIinJQN4Yzy477Pco3SS1znVbBL3y+dSE8mjsc8q?=
 =?us-ascii?Q?yY7dp1iXvUoqCbztYijAUhIpS+M43O5MQp2raeUr3YPQ5RYM6+PHbe3tOU/d?=
 =?us-ascii?Q?IvHoJQ/LZCrQZdw3nMGoslFlDKn/NT/XQILKzC0ca9r7fshWIUzCWl4lsYAB?=
 =?us-ascii?Q?owvPrb1b4NO+3T9i90QrpGcD7sofcUFtfQXExsF3McLMzrgCAPIdxcpToBWq?=
 =?us-ascii?Q?jv5F5aXA770AfbHvUla/7mkkGJUs/JBpEH8PTzxuSNf8p+GIKaoSjboGoWSS?=
 =?us-ascii?Q?03RaIcglr4LVQxvp8ewQkJog7OGhglY/OY1DqKH4/iJgBwnsoOkbHoBWMadp?=
 =?us-ascii?Q?VRxs3eu+U8lCEIykv02RtPWJRdAQQATeFLDJ0SMYngnz9rJxAZ6W06O+3bMD?=
 =?us-ascii?Q?AMtBhLLZeOziBkHAC3gtUuu0FfWan2+Q+yq7CppihL9M85LCHCuLiEvBbeDX?=
 =?us-ascii?Q?ZIKk/dXYoxuWEqSKdjiuo3miu+4YuvPam03udCMV+QbRhe3ytBa6hheJ3Tlw?=
 =?us-ascii?Q?VFD8WXBFtcYpAig8ahlYIE8qG0qVrOdbgToWysc1s57IY+1qQ9SIlp1Zn6TH?=
 =?us-ascii?Q?gFdb+D6yMvI/NOy7mH0S8pkYk4SOBiMGCIGb5cMHZv+SpEGC5y68CLI0U1fa?=
 =?us-ascii?Q?dlx/vAugjhHeEVh5Bv+SDNNysA4CUnf30H5kHcAFjchHbA508HMC6RyESZ+A?=
 =?us-ascii?Q?6Vk/fDY7X8+8tgkoGzqDB3FCecDM2OSTBBzJIrGe1wyiKn/i9ZxZkNqYBdVW?=
 =?us-ascii?Q?fjucjzO0fbBtDmfXGjzjeEoTLXPF7StNxd6Oz2LI0zmqWGSyqsPxomGULqiv?=
 =?us-ascii?Q?2c1ghQVdUxR3usLC1nfKCM/na3rFrsW8OQcEvsJfXlWr2n0cTwGQb518lx5A?=
 =?us-ascii?Q?PPLrIjlDYloa9H0s3d0Yh1iravgPEadv85gpo6R8md0B74bVCGGWkafvGdri?=
 =?us-ascii?Q?iJ7hxTA2BywXK4JxgoaHjXjI30+adGIL+PUq4dSOGSozLwcgR2G0pRKO5fyf?=
 =?us-ascii?Q?T2TP3VZwqFhrDuGKMD5BYJQ3U2ZcdeSEBBzlKFh4/B7/djyJVZoNrI0mIC3n?=
 =?us-ascii?Q?IVJD4T0YLBVEVuQIk9+QulkYMuOY2FjFi70MoOR19/SFTTidXotJZMZvOcji?=
 =?us-ascii?Q?5FCY74cKXBW3tf0FfpGG+Hibp6G69BjTZpi1hP4DjzbqD/i+hwFvahwpHU0V?=
 =?us-ascii?Q?RPAlJRbCavyVkYzERhuw1MdBEtOCM+NxH5a2YRFCpJGn5UnURlfdiyA55EB/?=
 =?us-ascii?Q?SkUcFEmhaDBlWoJUJGJ+eHHsQkqbBi4MS/9irlKyDWNn/Tg2T4SaxVtiZlHT?=
 =?us-ascii?Q?wBmKxnyBQavmLJV9Vj0fwMvAD3PHGXFAs4lmHX9WA3LtRPFji51sCPi0NP5G?=
 =?us-ascii?Q?SUcmcpnGsj3GWkNcmNUDH2drWOCHTVJNkoysagGY7CoR8kwr+w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cUAAN/9d26IUZJGxrmL5z1H/CG3/Cr8JmWnG0yLg0/r819vbLJP/cjc9wNnt?=
 =?us-ascii?Q?qutAld5eVpy/eXn5XFM9Ir8zZ00d+rT8B4nrCS8GPU7b9XugAZEwJX5vO1IH?=
 =?us-ascii?Q?vbml+kRSlcuZ3BCsLOy7xuAQ2F1FxPN6Y+SXT3BW1SFak6+x9aY9vyZckgms?=
 =?us-ascii?Q?16D7j7WXoTiO8udXst1i+LAanVM1OUkIDX7q0O9AlWZZhTs8EUdzAuGlr46J?=
 =?us-ascii?Q?pFoUdYZPQ3wOKB5+DetGIZ1Z4/5lOVmm0tVReP1XtLBPumPbA+h7MVK7ovrG?=
 =?us-ascii?Q?JfYc+FQln2AXC6BzQMt7m2e2GrPzCqjlgpUy0BnN3qi6ZRkxJM2EZtCcYjEF?=
 =?us-ascii?Q?xCAZaAY+Vz7KzCtJrhkITMwfPZ1FAyqiE1ZZg6Me6XPRYIZd3uU64fZsMXGf?=
 =?us-ascii?Q?wP4UPt4sGHTD1f1Goz/OUYciaDcnvkSE9cgHg2SL3XykfZ+6KNDjV8QIiNsy?=
 =?us-ascii?Q?kk52C/q+3k5Mf7Sj5X80W/zayQytjVrY9GtNbojms++T5WthHgRv5Tx/0DYh?=
 =?us-ascii?Q?eLMs9I/XiHHLo4mLhBQdDm66Ct6edST1I4Y7PF5UTEXY9tvRVK64c9GO5w53?=
 =?us-ascii?Q?f8EGH0B+b3gXkVWgGBoFPAYuN9fRKZ2lYIutl06Bk6sVr0FbEuvSuiP8Vl/k?=
 =?us-ascii?Q?nIAl425QL4K8kaQVf3YnzLrPIu20Tfi67s1wjjE0V5UdRXxDQXajkY35Rxe9?=
 =?us-ascii?Q?7Hij3t9v9NkVnwyFi8mWi3K2YdpQqXg/87Ejyo8BQqxjs201/vUPR/WIGnod?=
 =?us-ascii?Q?Q9IXdOnaEDdFHJqdoyIoeCogSlAeq+oh3grMY92gzGnJod1uWpxPs8snQKhe?=
 =?us-ascii?Q?8EysgB6zaEq+Rjq8YYS4jx51VPlo3GYdbnCUsQDmEQ2axtz7Q31AvEUveCao?=
 =?us-ascii?Q?q71AqPHEjbn7q5TElnZ3xNvhPT1iosER3ga4GGQqTN0q0sS3ouLP549SFjOf?=
 =?us-ascii?Q?7y1qZXTwshOgUarR9Y868FFtms8cL7X3ANCmAqfkv61MrblazUj5dtAC+kG9?=
 =?us-ascii?Q?4vt+yMY7PZYOhqAnpbFcng0p2MpJUAYW8ujWkky7Rg6neo7oQ/coHQSouAp0?=
 =?us-ascii?Q?QBmLP0Ny+fdnvDBFvlRCsHjCOYT/lHhgx5vUfCJqd+FPKrpEVOpCi4RO37tH?=
 =?us-ascii?Q?yDsKrfLjuWlCQHvuVfldt7DkJcF1XzWFyiDuJaCLPN00YaNelu4woOa25Kej?=
 =?us-ascii?Q?G/7tKPWm19fHABuMpQwYRrJAJ7RDdh5mfivtH0ao9Z9xAfFa+dqoZBDLJe/H?=
 =?us-ascii?Q?fUUrtJN4YiS26aPzHTfcj0EFjMlsB/iYHtuSIEYCfp0dJY41mWurpaLD7IUh?=
 =?us-ascii?Q?oHQFg3vyqNNffF39OrJa4bVVJfXGc4xooQH72WV8MyVqJhGYe77xxYZZ1Qd3?=
 =?us-ascii?Q?KH4Ryqj15E1zVMEYKhS6UcgByeW+QPpEb4m3ACfDgsIa3EsVTpKveDCRxvjx?=
 =?us-ascii?Q?iD+FXHdv3NUAcO2bWHcCR0ezfG0FZht5e66zIETwOu73TSYjbUm0pnUygjqh?=
 =?us-ascii?Q?gjR0bdxH9T9Ic3/eVfTSwcrjmvjLKfVnsXHLzuxTr9PoYHxImpGPb87Cnaj4?=
 =?us-ascii?Q?zOqz2WzpBVG7082GfhA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e03564e-967d-4eb6-4e9e-08dccb78c144
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 17:57:48.0417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /gsEjflFJnJP0bh6yx74/otCUsOAm49DgcOsUgbe3pW+QfLzY8Iljn3ycBtPwOyM3dqzfgSEdQHcymakwTPEDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6891

On Mon, Sep 02, 2024 at 09:11:05AM +0200, Krzysztof Kozlowski wrote:
> On Fri, Aug 30, 2024 at 03:11:43PM -0400, Frank Li wrote:
> > ifc can connect nor, nand and fpag. Add child node "nand@" under fsl,ifc
> > and compatible string "fsl,ifc-nand" when ifc connect to nand flash.
> >
> > Fix below warning:
> > arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: /soc/memory-controller@1530000/nand@1,0:
> > 	failed to match any schema with compatible: ['fsl,ifc-nand']
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v2 to v3
> > - add partition child node for nand
> > - Only partition property is used at ppc
> > Change from v1 to v2
> > - add address-cells and size-cells
> > ---
> >  .../memory-controllers/fsl/fsl,ifc.yaml       | 26 +++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml
> > index d1c3421bee107..5a11224da8914 100644
> > --- a/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml
> > +++ b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml
> > @@ -58,6 +58,32 @@ properties:
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
> > +
> > +    patternProperties:
> > +      "^partition@[0-9a-f]+":
> > +        $ref: /schemas/mtd/partitions/partition.yaml#
> > +        deprecated: true
> > +
> > +    required:
> > +      - compatible
> > +      - reg
> > +
> > +    additionalProperties: false
> > +
> >    "^.*@[a-f0-9]+(,[a-f0-9]+)+$":
>
> This pattern is for NAND already. I don't understand why you are
> duplicating it. If this part does not work, fix it.

It is old binding. It did not require compatible string. It should split
into nand\flash\fpga ...

The difference part require difference compatible string. NAND is only
1st step to improve it.

Frank

>
> Best regards,
> Krzysztof
>

