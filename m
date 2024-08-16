Return-Path: <linux-kernel+bounces-290376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C722955310
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 00:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60BE81C2435E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77102143C70;
	Fri, 16 Aug 2024 22:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LzTPfZPE"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942951465B4;
	Fri, 16 Aug 2024 22:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723845870; cv=fail; b=fuO7VKPA0OLCOfvmOHoeqi2WOCJ/gCRbhz86YVVCd0Tf2z/pYdPPNH3mOjTmHyigcft/H5cjiwYxasGU+WAlD0BWpjeQ/KXR5PZ/eJ2+edSj8dTMwp5NhoOkrvD21pAe5j/AytHXfHkzThP068jXYvZjrAeQWTS54CO+gDeJdDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723845870; c=relaxed/simple;
	bh=RFHMWa/Y11wI7NRT24q8O6eZfTqAeupfb+K87KJtXrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M2N6iGoBxnFhvV56LWOAkUH9MIsIoJIRYYCZjFm2vfzAKdJd0Dhr/WQ9rb8f8FqTR1lXxHZK+EA235bEvWXnSrFRBYM6OnWlzZiUqEdzZ1Or5RdkXbC9rZQt88BJF4HNo78DHnEGEbQ+8j8V1tPQ/Hwp3coiyO4BSRnbyupiNAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LzTPfZPE; arc=fail smtp.client-ip=40.107.22.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SfLLSKi6M5fNnkqei/KGiACJLMzIZxjCYG0JMLxeSJeNDK6dKbcQs2/f9op8nQrzYeXMEEfZciwQDSuWsIeKM25pooYUHFVShthjEzO1nKtExYXgQ/QaVdZd16+W/c2T/zqGNPE21AW1hUqYtAHfVeQwX45LUSMRpKb7awCstRXZ/+VzIJgyWqwCfmXC18o5MYwLx95gD8rQJe0MFAgT/byaCRwHc8L7zPciOvHvGwUM1Wu66+3gHvrZbvX6hcqN0UIeWrLPvma2xMo1lB/fpXN6fPmZmGGa+HhOGlooeeoZ4pLTLL4dc4QN55tPn6bVgeDV3rmzirGSkvbVcD/cBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJevJLCxCXyGxm3xVyRydWQRlmHeE9xcsFqKYU5aZso=;
 b=DhRM6GEsLTTtqrDt8VM0bW2jXXsnMceprXbq35RjH1oU4K7xlq2TDvd8gjrBPs4nG+nqdny3tkfLfT9hJSStKi3jDZ9P4s8Vt8DYHL8ljolIRYJSK75FoeC8PUZyBOrKjssmNcCNMSqftgSvzKyf4gs8/l4xs2OiWoiXsrIKvjRJi8KYW5qGSFMeA01FyxqhM8z/2kRbGN6+62F8meyoZHvOLRQzkrut+hWqD5ypyd31soaijR4vibEHdCfFauJ7bSejwk/Kk0rkbhNtnh6AjYYlEKpf9HzH3U2faAgBeMD1uIECnOfHwdMZq54x95l4AGJm2i+Qqj2olnUg9UFPXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJevJLCxCXyGxm3xVyRydWQRlmHeE9xcsFqKYU5aZso=;
 b=LzTPfZPEnYH54+7ZZRktPh0zVS4fhJOF2VVHp9rZMqbUpZE8l54T0pQT8u+9Powdf9yinHVhuVZNXeiELlvnm+60JdBts5xhX/Ot2/muXRlDjomivosUpQxBgnQ+nbVVx92kcItB/6F5xRFk4gj536rKfv36Q3FyTNTJfL2Zm8E09UEsKeIX0eA/ZPsP3Ff2UZy69gdOfo5P3nHfxWyolX6RazEmNfgXSLNPbcJYRMdl50hDkD3+7kPcGNlgqKs5nGWW1J0L2EYqQP30fugMy864PSN1vHKinM29IiyNauAdbO60juXIsWJvDM4JRt/qZuW+nE3BI5YqAVf3KHsq1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS4PR04MB9388.eurprd04.prod.outlook.com (2603:10a6:20b:4eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 16 Aug
 2024 22:04:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 22:04:24 +0000
Date: Fri, 16 Aug 2024 18:04:17 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: board: convert fsl-board.txt to yaml
Message-ID: <Zr/M4bSqaqCft/Y5@lizhi-Precision-Tower-5810>
References: <20240813163638.3889778-1-Frank.Li@nxp.com>
 <20240816212741.GA2225734-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816212741.GA2225734-robh@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0043.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS4PR04MB9388:EE_
X-MS-Office365-Filtering-Correlation-Id: 472ad744-3618-4fbb-36c6-08dcbe3f636a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ruqObVfxoNPcasRuus1PM95CdoNb3sz8RtcBDYX8g/AqtpEciC00MYXupToL?=
 =?us-ascii?Q?sVbFDevDoL22ETqWvmr4sKLKqtzjGNEGaN8fPeBMEReVC5JmyAmIGCgCU3fU?=
 =?us-ascii?Q?TlYKUXqiL6tlOf16gNFX67gYalDuxyOwwIUr7nKMlIEK9JBP7TpJFVIAbn7/?=
 =?us-ascii?Q?iFzKzVIf+phTUW+WTqwL28Fk5wp1tTeTpC7s0aPvN4zrqPjy56QEQTmShTMN?=
 =?us-ascii?Q?fOTZV6m7y05+FyZf0T9OS148XOSZ/vIpVcRHNM7ZgfcgjQ8y7U9aM20ugCkW?=
 =?us-ascii?Q?QxyvEuKTLyarM46Lu9ujjThOn1yB4GclL/t+RLQNbFdlB+reeICLYIwDmIMe?=
 =?us-ascii?Q?wdHJvwJZpGuXxjGOYtM4FN1rUUPHiYdHvIpPpbtYGTliT5dlGIbThaS2xFh5?=
 =?us-ascii?Q?/RTQuaFjr0BA6XEuP40tzMBNXgdnjsZnmJjLPp47auuabcfz+0qOxguyBQJr?=
 =?us-ascii?Q?KbtGm+oMD/CzCp8h65prUa4h3QFacyAdDi5MnEokQzyjCN3oL4Ezrvl+YO2L?=
 =?us-ascii?Q?p3H4f9xKszCKP58B9U0wswLQ0PEpcq0EETDoGGfEL90s8iCutTL1E02IbsO9?=
 =?us-ascii?Q?I0qU8mwt3rfRcSPsWL3PhlSL1jmdXCqkjsJvNNCmMj/xZZi4l7P75XxR7oo3?=
 =?us-ascii?Q?j6t8NN1+Jvs/tpeEwTecgwpPvJup1Hn0okx1QfB4swR5sbztUZkrcYfoIVUs?=
 =?us-ascii?Q?t+7W/BslDbAD7eVQs9Hsrjiu2Rc5xXfWY/4h+VHSm46ayw2E2hsWgjMdL6J1?=
 =?us-ascii?Q?HAvj8bfQN6Vz15zmvYWxZrdAAE+NzUKjs5xKN7BbC06tY86AwKkDxd36FwVp?=
 =?us-ascii?Q?bu2Eqv75ows0jyQC9hS9ohJp03tkiLHw7DuRlKwP3+qxfXSwGe0mjrLaPUW5?=
 =?us-ascii?Q?/y+SiG1vaatsnV5v1qvQOaugXoJ5pAglsRLnnqUrxaDxO/ZeMLzb86fVg/EW?=
 =?us-ascii?Q?CPkG+YGZ/JwajBjoEyLhs/P1WhiFjb8A2tzSTJy6dedkc0+RFZSu4IYqWRbp?=
 =?us-ascii?Q?WurhujBPZfZd/qfobT11YrR9ZzzENQhoLS3whK/L95evIwcm5JtxT3UrUvXT?=
 =?us-ascii?Q?nWG9B1kaPt5f7aRJfdozz7COMrAyjJj4RfNig0B5uqM6/orx0jkR85CnJiaX?=
 =?us-ascii?Q?Kslg9aCngO5D1A2krlbQHoSjry+hLcQQF/6U+Pl67XdBsdfKDP+svPo7HM80?=
 =?us-ascii?Q?CzwZepNNzVzNem4luZ/oxq2EcH4h3pFIrdvvdAZPTIwTFDFoU4lwlrlBIb36?=
 =?us-ascii?Q?od8vG0mVZx2j7R4Lr0vnKhOUv8nnYWCKryASDb+79/d3ALgx78OEhWu3t2if?=
 =?us-ascii?Q?b0fUwxifupn26eYj3cEdAgg7igJJUKVN1hpCBGLdy478k52gR+y5Jq7tr0CS?=
 =?us-ascii?Q?EjP+7GY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aaXhIrwdkzeiF+Y1WcE8s7P/vD+R+y0kJOKQI/0xmkxTt/vcHiDSabH4v7jZ?=
 =?us-ascii?Q?rx2spzrffbwDVb0qFoNbCJ79DIU7KwGRL0UJIk+HR6tlw9scnG5yEIRPlWM3?=
 =?us-ascii?Q?r+sgvDwJQP1BIn86Cw+TokA30nTaIY/gaGgmWMbSlz8Z+yZC+52Uaa0OHXdi?=
 =?us-ascii?Q?AvXQGybwgufrL/hcp7XP9t3oVbgQv3bxnyisSVOqKHlvms2J1jJGe5SNhshY?=
 =?us-ascii?Q?v1nJ5jXJKxYSj+53Pn8xvObj3gJ4tpOv5O921V0PcG+gdihYrC98RKM9/1X1?=
 =?us-ascii?Q?9D+lJnVpvdTeJwD3NBBSSEjfSPb88PK6DrupDlhQ4AwZxstlQmjqbZ5PQf+B?=
 =?us-ascii?Q?y5ukkXHF6JCj29PgcajWGyY7LWFQHc0Si7gC7IdspK7p6zFOzs8XWqFs0glH?=
 =?us-ascii?Q?PdqodB74MUhdyLy4Gz4Fe7X++PCTj92Kc+gSZ2qfGhoKz7f/HM7et3xNjSHj?=
 =?us-ascii?Q?bS3PB6066ONndvnneGIvPehn33h+IDmJTlmoN9KSotXaIsSH8akEgFsB1Jci?=
 =?us-ascii?Q?SCKvqTivRHLhQi59LeCzqb16hLoMCy0V/FX+3AjFJSoimK97uP6qp9Mz1tbV?=
 =?us-ascii?Q?pWIiAwu2IcbXBORTL2+QHfR8l09IZzfgzs2zaXuga1g7qZoO0RyGxhGfWTdw?=
 =?us-ascii?Q?FOCJrCWfbk0PT/aO2rYwCL1FtvLULz/v5yDpntbklr+T5YsiE5rdN1wbY+5f?=
 =?us-ascii?Q?F3VEq0Cscw2/hppXGUSBARBHmRqAld8PwUIocQrPqtu0ScaLc9dCL7S/qc7/?=
 =?us-ascii?Q?i57KFy3IpW0F2yX/jj8fjv7OnnABvW9oi8bReO5TvVIHio9z1gBaEZFlqpy9?=
 =?us-ascii?Q?EDrRE+oc+juWJ3dY+p5TuSesAGllG0VdavItzPy8pe7f3fg4QUOkRPi2rC8U?=
 =?us-ascii?Q?OT08w9PwV95UVtftUxTEgTSJP9VBsR3YuWYvB79dN6Cik/lg3tWNO92EuNRe?=
 =?us-ascii?Q?YRxmZl7jNMaFxBUj+eKYS4t/b7Lks37tKPmoGmNUAdJSSdsOLGPDOGBChGJQ?=
 =?us-ascii?Q?24hYLc1VDB0Td1s/f91QN6STTrE5T6V1WITqWgSNZlEVNvNQMc241U6hByeQ?=
 =?us-ascii?Q?gJHBYV4mzHMwfiiBn18CLCZzC6PRkE69Pn3QPQZvvvS+Q/9K/ihEtpXQav3H?=
 =?us-ascii?Q?RhlrMwrvCKYvxzX3BZ1dS74/HreIs+ezu5mB2tYw2HqZtPz7Dk5Xoz6q4B+x?=
 =?us-ascii?Q?b7POoFUoKPktgBPx5I88EIxIkcp1OXEq1UdjuvTSt3DarZqP8JXX3PZhhvej?=
 =?us-ascii?Q?E3B4o9EbD6aKvQuVD67ZRCeKIgxoWoG/vfiMqeaitFnaC6EyYTY6KHgRUWbu?=
 =?us-ascii?Q?g3XVZnT8SMWzcbky/lOWJPY+dECnE5OkN7TT6juWkMw/v9ZS7tmR5HyuzLOQ?=
 =?us-ascii?Q?RbnmAM9nVdfqJMaOxpfwgFLv64BbO3F/2TXFnls13XLn/YOXUCNK8+wwCaLM?=
 =?us-ascii?Q?fI9LWNvzu8ymGzS3qY3GpQoJI//t6bd9d3K2//FXDli4vuel5irti9i/D0r4?=
 =?us-ascii?Q?9YQ3VWgikWSIMzaRo4w6bPEDKFVwomZ6CBigSRV1w3UrWpnptm35GhOPQp2I?=
 =?us-ascii?Q?/yquVfxrXoD/mYUYrcOT4S3YDLS2vy7nsPOfz86X?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 472ad744-3618-4fbb-36c6-08dcbe3f636a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 22:04:24.1485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82qjzFkqE9FWVL1PO3qrrVvqKyox01P92sJpJJ9zunmD7JYsb9F08Wuv1uMO1dsGetjjwCf4vDb14eTgbCb2+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9388

On Fri, Aug 16, 2024 at 03:27:41PM -0600, Rob Herring wrote:
> On Tue, Aug 13, 2024 at 12:36:29PM -0400, Frank Li wrote:
> > Convert binding doc fsl-board.txt to yaml format. split to 3 part
> > fsl,bcsr.yaml, fsl,fpga-qixis.yaml, fsl,fpga-qixis-i2c.yaml
> >
> > Additional change for fsl,fpga-qixis.yaml
> > - Add childnode mdio-mux-emi*
> > - Add compatible string fsl,ls1043aqds-fpga, fsl,ls1043ardb-fpga,
> > fsl,ls1046aqds-fpga, fsl,ls1046ardb-fpga, fsl,ls208xaqds-fpga,
> > fsl,ls1043ardb-cpld, fsl,ls1046ardb-cpld, fsl,ls1088aqds-fpga,
> > fsl,ls1088ardb-fpga, fsl,ls2080aqds-fpga, fsl,ls2080ardb-fpga.
> > - Change address to 32bit in example.
> >
> > Additional change for fsl,fpga-qixis-i2c.yaml
> > - Add mux-controller
> > - Add compatible string fsl,ls1028aqds-fpga, fsl,lx2160aqds-fpga
> >
> > Fix below warning:
> >
> > arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dtb: /soc/i2c@2000000/fpga@66: failed to match any schema with compatible: ['fsl,ls1028aqds-fpga', 'fsl,fpga-qixis-i2c', 'simple-mfd']
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v1 to v2
> > - drop description in fsl,bcsr.yaml
> > - bsc9132qds is too old, their dts have not simple-mfd.
> > - split qixis-i2c compatible to two group, one with simple-mfd and the
> > other one without simple-mfd.
> > - Add new full example for ls1028
> > - Remove [0-9], keep @ for mdio-mux-emi. Dts need be update to avoid
> > warning
> > - fix typo dt-binding in subject
> > ---
> >  .../devicetree/bindings/board/fsl,bcsr.yaml   | 32 ++++++++
> >  .../bindings/board/fsl,fpga-qixis-i2c.yaml    | 70 ++++++++++++++++
> >  .../bindings/board/fsl,fpga-qixis.yaml        | 81 +++++++++++++++++++
> >  .../devicetree/bindings/board/fsl-board.txt   | 81 -------------------
> >  .../boot/dts/freescale/fsl-ls1043a-qds.dts    |  2 +-
> >  5 files changed, 184 insertions(+), 82 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/board/fsl,bcsr.yaml
> >  create mode 100644 Documentation/devicetree/bindings/board/fsl,fpga-qixis-i2c.yaml
> >  create mode 100644 Documentation/devicetree/bindings/board/fsl,fpga-qixis.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/board/fsl-board.txt
> >
> > diff --git a/Documentation/devicetree/bindings/board/fsl,bcsr.yaml b/Documentation/devicetree/bindings/board/fsl,bcsr.yaml
> > new file mode 100644
> > index 0000000000000..df3dd8399671f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/board/fsl,bcsr.yaml
> > @@ -0,0 +1,32 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/board/fsl,bcsr.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Board Control and Status
> > +
> > +maintainers:
> > +  - Frank Li <Frank.Li@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - fsl,mpc8360mds-bcsr
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    board@f8000000 {
> > +        compatible = "fsl,mpc8360mds-bcsr";
> > +        reg = <0xf8000000 0x8000>;
> > +    };
> > +
> > diff --git a/Documentation/devicetree/bindings/board/fsl,fpga-qixis-i2c.yaml b/Documentation/devicetree/bindings/board/fsl,fpga-qixis-i2c.yaml
> > new file mode 100644
> > index 0000000000000..28b37772fb656
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/board/fsl,fpga-qixis-i2c.yaml
> > @@ -0,0 +1,70 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/board/fsl,fpga-qixis-i2c.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Freescale on-board FPGA connected on I2C bus
> > +
> > +maintainers:
> > +  - Frank Li <Frank.Li@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - fsl,bsc9132qds-fpga
> > +          - const: fsl,fpga-qixis-i2c
> > +      - items:
> > +          - enum:
> > +              - fsl,ls1028aqds-fpga
> > +              - fsl,lx2160aqds-fpga
> > +          - const: fsl,fpga-qixis-i2c
> > +          - const: simple-mfd
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  mux-controller:
> > +    $ref: /schemas/mux/reg-mux.yaml
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        board-control@66 {
> > +            compatible = "fsl,bsc9132qds-fpga", "fsl,fpga-qixis-i2c";
> > +            reg = <0x66>;
> > +        };
> > +    };
> > +
> > +  - |
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        board-control@66 {
> > +            compatible = "fsl,ls1028aqds-fpga", "fsl,fpga-qixis-i2c",
> > +                         "simple-mfd";
> > +            reg = <0x66>;
> > +
> > +            mux-controller {
> > +                compatible = "reg-mux";
> > +                #mux-control-cells = <1>;
> > +                mux-reg-masks = <0x54 0xf0>; /* 0: reg 0x54, bits 7:4 */
> > +            };
> > +        };
> > +    };
> > +
> > diff --git a/Documentation/devicetree/bindings/board/fsl,fpga-qixis.yaml b/Documentation/devicetree/bindings/board/fsl,fpga-qixis.yaml
> > new file mode 100644
> > index 0000000000000..4d4eb45ce64cd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/board/fsl,fpga-qixis.yaml
> > @@ -0,0 +1,81 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/board/fsl,fpga-qixis.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Freescale on-board FPGA/CPLD
> > +
> > +maintainers:
> > +  - Frank Li <Frank.Li@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - const: fsl,p1022ds-fpga
> > +          - const: fsl,fpga-ngpixis
> > +      - items:
> > +          - enum:
> > +              - fsl,ls1088aqds-fpga
> > +              - fsl,ls1088ardb-fpga
> > +              - fsl,ls2080aqds-fpga
> > +              - fsl,ls2080ardb-fpga
> > +          - const: fsl,fpga-qixis
> > +      - items:
> > +          - enum:
> > +              - fsl,ls1043aqds-fpga
> > +              - fsl,ls1043ardb-fpga
> > +              - fsl,ls1046aqds-fpga
> > +              - fsl,ls1046ardb-fpga
> > +              - fsl,ls208xaqds-fpga
> > +          - const: fsl,fpga-qixis
> > +          - const: simple-mfd
> > +      - enum:
> > +          - fsl,ls1043ardb-cpld
> > +          - fsl,ls1046ardb-cpld
> > +          - fsl,t1040rdb-cpld
> > +          - fsl,t1042rdb-cpld
> > +          - fsl,t1042rdb_pi-cpld
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 1
> > +
> > +  ranges:
> > +    maxItems: 1
> > +
> > +patternProperties:
> > +  '^mdio-mux-emi@[a-f0-9]+$':
>
> If we're going to update the dts file, this should be 'mdio-mux@'. I'll
> fix this when applying. The rest looks good.

Thanks, I will fix dts in v2 3nrd clean up patchset.

Frank

>
> Note that p5040ds.dts has 2 nodes at the same reg address, but different
> bit offsets. The way we handle that is adding the register starting bit
> offset to the unit-address like this:
>
> mdio-mux@9,1 (mux-mask 0x6)
> mdio-mux@9,3 (mux-mask 0x78)
>
> Rob

