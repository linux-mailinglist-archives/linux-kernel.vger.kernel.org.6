Return-Path: <linux-kernel+bounces-257595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49871937C6E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 20:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 641D81C20EBA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50D91474BA;
	Fri, 19 Jul 2024 18:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ot+pX2Yi"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013060.outbound.protection.outlook.com [52.101.67.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7096F1474AD
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721413569; cv=fail; b=Fxdgcq5R3HaiE2bLvMmBEfnXSqZ5bFgVMzsAUooSq4ssXRtf9KJ/ynQoPaQcRC9wwTIo6nPMfYTYipQf9/F3zEbo1MOkJe2+Tm5zwlnqearEyb+2F3YSasP1FqaxtFl5Haiw+O6KRI8hFMB8ugTJuiHj8K1Mxjvnj6VY2sPe240=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721413569; c=relaxed/simple;
	bh=mFjxJGqoEYZgR4joa6k/0zQjuwd06NDK3e63uy47+ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=atfXxRvnMgvpP4UfutxVyDxN+Zz2I3mYo94Yh8awxgb8JZHCQrRzqkGyDvRVucii6r2xxzStThr6fwM1YDAl85DL142ODGUXHR+f09//YjT+urstcDiv+nbJBj34rMYeOwyzIQWXzJP5+dHUiCqwfHOetnswB0wKgDNfCIEnfDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ot+pX2Yi; arc=fail smtp.client-ip=52.101.67.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfFiLfpJfdrShpqcd/DGS1vC/qnoZy4NKGXV6Av4I/Ao5Va2U2Q8B+ll3jxCDmTvE1AI58r0LdSWkO/mHiEVLUev9MbY4da7vergrAvYkfaLj1msLTxbcEGsWhtehzDvMbktNQjNHmgFN7uz31I9fB12HNNy7YBpDCHO9Qbv4Mxt4b6c3INRCa2RFIOuj5wBSehi/feAmYLUuW4PRtGa8051Akdd9I8uHTDVhCwoHQdGPhl0s6lqw+V3TD0qDNC+syVojIh0YUtFOP+VHMetTDJzDp3S5/Azs0XbT+gbyLv5vzSelRAlRcPV3hNnxQkK/dWeQNF2HWr49lJSEZZLFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJI6wiSHypl8Us7+m2S3+YdZUBtJalc/SjTSqBkJEmA=;
 b=YewEZjNyFa2dj49qbKSvZp0Q+A8RGireBWKKje+MX/xB/XlZUXr388S5DkOkUMShRiIi/+fjpLy1Uy7E14pu1TVWMoDZTIeyfE8AZ0QTzf0KPPcnQ6YD2sUD1hfupMKMAaqa8rpB+nxtNcwfEIAY84L9V5adn+zt9Ml8yJy1A6RKsBP/9ia5Mcose7J6bWdnVeXpesTZO7bv9N40NIfYhjborBgcp3tiuUFj2Tobix/i04mDfBHZ1dLB6bVxVMFAlToYX6ycGOd4pCFoQDU3bS4o0gj8++Y36lWPyKgirFDUEje0I/NgxQpBAs0Whj/4TMfTg1srTZj7AAkI+Y/+9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJI6wiSHypl8Us7+m2S3+YdZUBtJalc/SjTSqBkJEmA=;
 b=Ot+pX2YiKo5ls9h5XFIzGCMOjzlwLT0R/BRMj/jHWJyxqmJkv1+mi0jxBDPgMAifZawYYfCJ93uJyMwaDsX4K2LnG7zR+TcEWOYZxiweGE+OVVIOJneCrZdaWH9+oKQ8uh37Qtc+nRE/eyWdx6OxFUYy82zRTgvNHIU+CT0Td80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB7152.eurprd04.prod.outlook.com (2603:10a6:800:12b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Fri, 19 Jul
 2024 18:26:02 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 18:26:02 +0000
Date: Fri, 19 Jul 2024 14:25:55 -0400
From: Frank Li <Frank.li@nxp.com>
To: Carlos Song <carlos.song@nxp.com>
Cc: "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
	"conor.culhane@silvaco.com" <conor.culhane@silvaco.com>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v2] i3c: master: svc: adjust the first broadcast speed
Message-ID: <Zpqvs+ok7UQtlYkZ@lizhi-Precision-Tower-5810>
References: <20240719080351.842848-1-carlos.song@nxp.com>
 <Zpp/uv0yeEhld6We@lizhi-Precision-Tower-5810>
 <VI1PR04MB50058C9E30C4A357E43CB34FE8AD2@VI1PR04MB5005.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB50058C9E30C4A357E43CB34FE8AD2@VI1PR04MB5005.eurprd04.prod.outlook.com>
X-ClientProxiedBy: BY5PR16CA0036.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::49) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 314dff34-ebf4-4807-f0a1-08dca8203ec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D1QpOl/XLHer7XtOjPe1IpSxStxgIqaivgUMbpupSGEJCEY9oJgQJFnZMGsU?=
 =?us-ascii?Q?IjVJedKyQQRCx4rZ7qs9yDwxQ0QvJyvohV9ncf4HqKhaxlk5kMZGDtobTRHc?=
 =?us-ascii?Q?eWVbbsjsaxG433bouRlZeeaD8iKtKC9J3/3TUE2xa1jaDLuhY9WmO2a1Etxd?=
 =?us-ascii?Q?Wwv0d/VQcBzdt/HK/SKYeX+tbTv/j8Jf5ak8Ne1D4BTRWDWgs5o4ztQ9s0sj?=
 =?us-ascii?Q?8nBNzYnEasWKihCwpHSLA5ZwG+6q0q0CIdr5ya6UbY+Q/mhSwoo03GA0lr3R?=
 =?us-ascii?Q?/PrpCMIs2vgOy9XDEPmhUi5l/tfflgm32yERsMeKSkjepHppnNsVaGxlYwDn?=
 =?us-ascii?Q?32YKkGk+FLlcpyvZMQcwI4Yc9n7BdEcpNwcxOy7UAEa48ap1XHqWZhUo8NZV?=
 =?us-ascii?Q?HaNmfvokaxfI/J1dq4s16rCeW+syML1h0PCyV3TLCRMDIDPFgJdKoeIrgbHv?=
 =?us-ascii?Q?CCQULpu4OP4Qpd9wKkh1/XUa1H2x8S7Wpfa6YjHieVYlCu5F6GnhoBHE8kTF?=
 =?us-ascii?Q?FeruAzqxIyvn6dDqaG/nd5iwrDBzHWejf23sqtSWYgUeXwqpSiRZ7oBSEr5l?=
 =?us-ascii?Q?7z7h+Sa3JfVJLvUvBPLeelL/X/CY3S+3e5t1ByR1NFQmUQqxoumk/RKYZUmC?=
 =?us-ascii?Q?iBJfnYxo0M3+QyLh9Fi8nxcf1Zknd7RhpWAOhBxifNYoVUPiBA6Jvxquxbai?=
 =?us-ascii?Q?HIH4+MGPhO+OtwSFmAtEJUZ8HNDV/RQlBRd2JNzNk+q2OuSXYuJ6pyZBD2T8?=
 =?us-ascii?Q?IngbshRyZ9+h0VrUYuf/b0BGCXQYPkiAP4k4G5bW9/e9FASgWSLR5ztfowT8?=
 =?us-ascii?Q?LBhTsfsOyrKzi1lNDpfQ6Vw7oSjAGVizJrkewWOzi0QoD2BW1TmfIkVU0w0N?=
 =?us-ascii?Q?nJjCrMeDLT+J+oVZT6JMtes5bZomH/+w6nuwNAOt45TvbpEX1eh92OxdAYmP?=
 =?us-ascii?Q?q1wqe9YDtmWXPbJun3grCC0KluTfAPuAivefZmxlNS+EVEzbHHro64Rt1Ovw?=
 =?us-ascii?Q?iD8ESrdhuy+VSn4Ck8nZ56r5UA3l+RMb1g2SQQUg0vnCyenD81ue3IS2QwfT?=
 =?us-ascii?Q?01N4HcK9tpqUM2ovZSJQApynR0HyDk3/dCi30Fxvvu42PfEEYSuwbZ3cTUUh?=
 =?us-ascii?Q?0reQPEt4/+fhzd56q5BegsOWvhACNVFkeKzkDjPPgrQer1OjPiISyOt68VMA?=
 =?us-ascii?Q?txSWx3ToO5G+x1mRZ2rG+ITrO2woYMf50rtdN17BmoyRRtzVMdH7kXeCxrQg?=
 =?us-ascii?Q?MsSqI/0Oee2uJbf7Od829I0xDS3tUt4s4SQRHHUaGuNiG0uKPPjR2x/iT8fQ?=
 =?us-ascii?Q?PjrGLieXZhkGa0Uqc/LiSzaUbA8Pkfe4ZGHrONs1+7sB2ff11SJyaZOsqCYj?=
 =?us-ascii?Q?F7Ab4e/JgPyMjwRJ39ZkGCdKCOvafyPb0GqIDgugAB+50LFtOg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G6u0RkLL1iaKAF0/T7oql4uRajeEWJBqxt7/gDeC7EmryyPzxibiEXyqOvEW?=
 =?us-ascii?Q?B/Ue2QLh/yW2iNySvJRnRYgprnvJCnFhdUJ2KWoGgMAi9+NMnxlkcRcscx9I?=
 =?us-ascii?Q?OkPZGLMOx9mGMN1Qq0A9OPMwqdTZ18KcJQrerF/DRJMM/xx0Q5EAwLsdfjno?=
 =?us-ascii?Q?zSodFZOp7YOI95+1MdIEFxRkl4e7eELs7sBJmRz0aDi+gPZX+TPKOzZCD4lJ?=
 =?us-ascii?Q?K6aSW5ixndvWLBvPZ0G2cnfVl34qle5f/ik85uZ+1fM+bFSii4NtSLEw2vKI?=
 =?us-ascii?Q?HRHSio+MbufsXZZTOBylPv7QOTSj0be1ith/cj6VVWOfCKqxuuBbFsT2gA6q?=
 =?us-ascii?Q?V1mXfQrKofZtTylFdgMERXHVKEuqyvXncWZOweUtTPvjbLPAWD0iWFYsOJgQ?=
 =?us-ascii?Q?2u158OKCL0Hhrd2gPFjri5FU1CONgKgwTXDSvkdF2nbWEOy1Jwds8pOGT8lf?=
 =?us-ascii?Q?AVxlrC14/PlTj3epWN/KoFpe9aFXL4YLRYnq8VMvKbZpYySHlcQh1fhNRyfm?=
 =?us-ascii?Q?d2n1a7m3mEnglx/iLhFVr6UD2zQJNldaUM49IVjjPol4qcNoPhNlVnHWBqnY?=
 =?us-ascii?Q?LXlFUBdnpf1x1CvNBh0p7glq2MZAoFAwlkDSG4WSbtyd+6eoxVxhnyBjn2sT?=
 =?us-ascii?Q?ZA6THBaknNvVzR1di2yTbMY0tMDi2jnC6xcSkuiB/eb1+X5JjPLX6kBs+21R?=
 =?us-ascii?Q?FBZ8Uljyjv8qolIr7mnlPnkyeuHILE5H8v7mzqjrwms6+ACO+PvP6wrlWSmk?=
 =?us-ascii?Q?oIguNzUJpduEGqWVZUh1gleteqiPvHUNRpI7llC9AD/+FgC9NRpVXkB4Mw8X?=
 =?us-ascii?Q?dFzzt+S6Z/NCU7NLjx6/gjRrJNfgMtjNb83ZvivEYYsHoM2oxlFlq0u9jHpb?=
 =?us-ascii?Q?lYZh0trt9P8Hz2jqFqdHh3dAkwqhL7lfxt/p+f31jAwe0kIDvrlXUCec2vN6?=
 =?us-ascii?Q?QvXKUIP1vSsBU2OY/ovNmSQtVuIqOMRkLzGXlAE5ET5SktwXqE++vNHSF664?=
 =?us-ascii?Q?Vvz5za18IBuXF4xZ7yuMk9o/MDPOf6o6m/fRjAb0SawKz3iGfDCTJ3jquVG/?=
 =?us-ascii?Q?2wEK77EnSemqEudAGej6Gmd9+L12Y8MQaqVBgdcbwvvs47kaHw8Huy2R9MAu?=
 =?us-ascii?Q?9SeG3x6U6xfVEIPqDQVIiDImmy/JLLSO7boxWCyjRhYpGD6fPrVxDYtjBGTh?=
 =?us-ascii?Q?ptD3wR4icZlmtuH0aiipHoK83Ns8D8V6wb5aRfahWjUKBSxah40g9TIRVGuo?=
 =?us-ascii?Q?IK9gpcqF24K3TO+U2zoYyoi9VDAZ/UJVT7/cGv9rBoCpUsjvJ3+f0DDAKm7X?=
 =?us-ascii?Q?u6M6dniQH+MnviXmajbDh/dy76xnFUElhKWl0D06GlwzhsE1imULj6Witqhf?=
 =?us-ascii?Q?NVPt2aY6F0Av2srdLz7+7qprWGdho33L0L/2WBIyXIdt15cCjT9D3Ufmyid7?=
 =?us-ascii?Q?CQDqF03kdGUm1Wa5xWuGGIISwrnLvRVfuHUp3bIqWLol8YjwH3Fj3bqt5c9M?=
 =?us-ascii?Q?dik0iNS1MdfHh0jieYOnsAku7pYJOHI3ijMmRiBob+vFPuSj9ZdfJwKTU8Vw?=
 =?us-ascii?Q?KZ6VA4sCuyUg3KnEM60=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 314dff34-ebf4-4807-f0a1-08dca8203ec1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 18:26:02.6422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RPBTXg4MzfdeQw8rA9s3qNPDUex3rGCFRinSNlDij4KG63zu4J3QKogSZnBBrdZ5DoTnj08tKopSXOyyj9VeuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7152

On Fri, Jul 19, 2024 at 04:37:01PM +0000, Carlos Song wrote:
> 
> 
> > -----Original Message-----
> > From: Frank Li <frank.li@nxp.com>
> > Sent: Friday, July 19, 2024 11:01 PM
> > To: Carlos Song <carlos.song@nxp.com>
> > Cc: miquel.raynal@bootlin.com; conor.culhane@silvaco.com;
> > alexandre.belloni@bootlin.com; linux-i3c@lists.infradead.org;
> > linux-kernel@vger.kernel.org; imx@lists.linux.dev; dl-linux-imx
> > <linux-imx@nxp.com>
> > Subject: Re: [PATCH v2] i3c: master: svc: adjust the first broadcast speed
> > 
> > On Fri, Jul 19, 2024 at 04:03:51PM +0800, carlos.song@nxp.com wrote:
> > > From: Carlos Song <carlos.song@nxp.com>
> > >
> > > According to the i3c spec 6.2 Timing Specification, the first
> > > broadcast open drain timing should be adjust to High Period of SCL
> > > Clock is 200ns at least. I3C device working as a i2c device will see
> > > the broadcast to close its Spike Filter to change to i3c mode. After
> > > that I3C open drain SCL high level should be adjust to 32ns~45ns.
> > >
> > > Signed-off-by: Carlos Song <carlos.song@nxp.com>
> > > ---
> > > Change for V2:
> > > - use slow_speed instead of first_broadcast
> > > - add default_speed variable in svc_i3c_xfer to avoid set default
> > >   speed every time
> > > - change start_xfer if else for easy understand
> > > ---
> > >  drivers/i3c/master/svc-i3c-master.c | 55
> > > +++++++++++++++++++++++++++++
> > >  1 file changed, 55 insertions(+)
> > >
> > > diff --git a/drivers/i3c/master/svc-i3c-master.c
> > > b/drivers/i3c/master/svc-i3c-master.c
> > > index 78116530f431..7cd3a9a4d7dd 100644
> > > --- a/drivers/i3c/master/svc-i3c-master.c
> > > +++ b/drivers/i3c/master/svc-i3c-master.c
> > > @@ -142,6 +142,7 @@ struct svc_i3c_cmd {
> > >  	unsigned int actual_len;
> > >  	struct i3c_priv_xfer *xfer;
> > >  	bool continued;
> > > +	bool slow_address;
> > >  };
> > >
> > >  struct svc_i3c_xfer {
> > > @@ -214,6 +215,11 @@ struct svc_i3c_master {
> > >  	} ibi;
> > >  	struct mutex lock;
> > >  	int enabled_events;
> > > +
> > > +	unsigned long fclk_rate;
> > > +	u32 mctrl_config;
> > > +	bool slow_speed;
> > > +	bool default_speed;
> > 
> > I think you needn't two varible 'slow_speed' and 'default_speed'.
> > 	default_speed should always !slow_speed
> > 
> > Frank
> > 
> 
> Hi, Frank
> 
> In fact, I am struggling for using just one variable: slow speed. Adding a variable "default_speed "was also a have-to move.
> 
> If I use "if else" in xfer for easy understand, it means I only can change the MCTRL register value one time in every xfer. So in the first xfer, I must change slow_speed to false, then next xfer cmd->slow_address will be false. So in next xfer, I can set initial configuration back to the controller. 
> But the question is I have to set it every time, so I add the extra variable to avoid writel in every xfer.
> It looks bad... Sorry for my poor coding.
> 
> If only one variable " slow_speed " is used , I think "if else" and "writel one time", only one can be used. Maybe there is a better code method but I don't get it? 

If I understand correct. 

svc_i3c_master_set_slow_address_speed()
{
	...
	master->slow_speed = true;
}

svc_i3c_master_set_default_speed()
{
	if (master->slow_speed) {
		writel();
		master->slow_speed false;
	}
}

  if (cmd->slow_address)                                     
	svc_i3c_master_set_slow_address_speed(master);     
  else                                                       
	svc_i3c_master_set_default_speed(master);

When slow_address is ture, always set slow_speed = ture
when slow_address is false, call to set_sefault_speed, if previous 
	slow_speed is true, then change to default speed, slow_speed will
be false.
	when next time call to set_default_speed() do nothing.

Frank
> 
> Carlos
> > >  };
> > >
> > >  /**
> > > @@ -531,6 +537,43 @@ static irqreturn_t svc_i3c_master_irq_handler(int
> > irq, void *dev_id)
> > >  	return IRQ_HANDLED;
> > >  }
> > >
> > > +static void svc_i3c_master_set_slow_address_speed(struct
> > > +svc_i3c_master *master) {
> > > +	struct i3c_bus *bus = i3c_master_get_bus(&master->base);
> > > +	u32 ppbaud, odbaud, odhpp, mconfig;
> > > +
> > > +	master->mctrl_config = readl(master->regs + SVC_I3C_MCONFIG);
> > > +	mconfig = master->mctrl_config;
> > > +
> > > +	/*
> > > +	 * Set the I3C OPEN-DRAIN mode to the FM speed of 50%
> > duty-cycle(400K/2500ns),
> > > +	 * so that the first broadcast is visible to all devices on the i3c bus.
> > > +	 * I3C device with 50ns filter will turn off the filter.
> > > +	 */
> > > +
> > > +	ppbaud = FIELD_GET(GENMASK(11, 8), mconfig);
> > > +	odhpp = 0;
> > > +	odbaud = DIV_ROUND_UP(master->fclk_rate, bus->scl_rate.i2c * (2 + 2 *
> > ppbaud)) - 1;
> > > +	mconfig &= ~GENMASK(24, 16);
> > > +	mconfig |= SVC_I3C_MCONFIG_ODBAUD(odbaud) |
> > > +SVC_I3C_MCONFIG_ODHPP(odhpp);
> > > +
> > > +	writel(mconfig, master->regs + SVC_I3C_MCONFIG);
> > > +	master->slow_speed = false;
> > > +}
> > > +
> > > +static void svc_i3c_master_set_default_speed(struct svc_i3c_master
> > > +*master) {
> > > +	/*
> > > +	 * The bus mode is already determined when the bus is initialized, so
> > setting initial
> > > +	 * configuration back to the controller. No need to set it in every transfer,
> > just
> > > +	 * restore it once time.
> > > +	 */
> > > +	if (!master->default_speed) {
> > > +		writel(master->mctrl_config, master->regs + SVC_I3C_MCONFIG);
> > > +		master->default_speed = true;
> > > +	}
> > > +}
> > > +
> > >  static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
> > > {
> > >  	struct svc_i3c_master *master = to_svc_i3c_master(m); @@ -624,6
> > > +667,8 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller
> > *m)
> > >  	      SVC_I3C_MCONFIG_I2CBAUD(i2cbaud);
> > >  	writel(reg, master->regs + SVC_I3C_MCONFIG);
> > >
> > > +	master->slow_speed = true;
> > > +	master->fclk_rate = fclk_rate;
> > >  	/* Master core's registration */
> > >  	ret = i3c_master_get_free_addr(m, 0);
> > >  	if (ret < 0)
> > > @@ -1251,6 +1296,11 @@ static void
> > svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
> > >  	for (i = 0; i < xfer->ncmds; i++) {
> > >  		struct svc_i3c_cmd *cmd = &xfer->cmds[i];
> > >
> > > +		if (cmd->slow_address)
> > > +			svc_i3c_master_set_slow_address_speed(master);
> > > +		else
> > > +			svc_i3c_master_set_default_speed(master);
> > > +
> > >  		ret = svc_i3c_master_xfer(master, cmd->rnw, xfer->type,
> > >  					  cmd->addr, cmd->in, cmd->out,
> > >  					  cmd->len, &cmd->actual_len,
> > > @@ -1346,6 +1396,11 @@ static int
> > svc_i3c_master_send_bdcast_ccc_cmd(struct svc_i3c_master *master,
> > >  	cmd->actual_len = 0;
> > >  	cmd->continued = false;
> > >
> > > +	if (master->slow_speed)
> > > +		cmd->slow_address = true;
> > > +	else
> > > +		cmd->slow_address = false;
> > > +
> > >  	mutex_lock(&master->lock);
> > >  	svc_i3c_master_enqueue_xfer(master, xfer);
> > >  	if (!wait_for_completion_timeout(&xfer->comp,
> > > msecs_to_jiffies(1000)))
> > > --
> > > 2.34.1
> > >

