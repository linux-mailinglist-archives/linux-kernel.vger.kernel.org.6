Return-Path: <linux-kernel+bounces-536973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 464CFA4868B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A45E316E00A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85D81DDC30;
	Thu, 27 Feb 2025 17:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G6tpIidi"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013061.outbound.protection.outlook.com [40.107.159.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791341A3178;
	Thu, 27 Feb 2025 17:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740677011; cv=fail; b=doU6P068DV6EL385nqNFPbUaykR1ldQ0xAmdBTrTkZFFOuZreg1FJwClrpKOVXUFL0V/n1p+v3UWW2ROFmm0FKRVbwZfOePZ+rS7WSH+fVyNBYCHzlzPu372Xe64GjfKXUtSgmCyXffZZuIwm94gNqeDXTmpwuJclNhneXoYrkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740677011; c=relaxed/simple;
	bh=CCyl08YMlWQ64EZXIiduB0SpiC7/H/m2rxN7RZ/vlx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Sq2n+rHkgtaug4NWU7UFS3ZXwuQHTNWHKd5848avTOyEVX2ansha6+J4qo7RdWrLcGTyEmD/LNTftXcblpVnvw+QGQOIi0UP7UIkj8mqfX6a7tUIv5ZYPJvGPWxnY8V+SB/mibr4hCkderAob7lwTnazImrlNR82MfcBfeaxC94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G6tpIidi; arc=fail smtp.client-ip=40.107.159.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCnk/CHZui9h3QpKqzRBK7JT1yGPVbFTf018GaVfj13piAmiBsNmmG5EBJgndqWjmPw7qfdPQH0BTguCQ86M2IvbsXvRfh+5q0nZHAxrc5OpaO5wZTBgPMvLmF7TE1phyO0QCrnMnEMJSdenRrs437wwQfGH04LDylxytdyhnbs9rsEG6UwbV4y0NFHD+Wx79wgsY/QyBSuE6SYxSbZJJDjGrcYHrX5sDkvppEEzudMvcMa2h41lXquDzmBXtEPDEvgHGGWgachmIbmrLvxeEi2Q9mXgDu96GU/n6u/v12KZrtN0a2vvaYben8oQZZmgx84MBHcDZGcvt/2ultpm6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1F7b4fIIsqtco4sxoUbP0aMqKfhWkRRYTPq62AyBQM=;
 b=HUxXVjpX5XRbkQx1WKkCu92wTGEfVnmgYciS8pMnIV+OSCSJ6KXh1j6IfY0NMKq079xel+i8M/1Ti5AyC67v2lEpZLOZZ5Sl/WZv2R3gtPcAoYNbv+pfxaAuC3V92mh85wK7b+tKGpxZwftFEgSDuV1bfyc/hsehEoX+9+IDzeEpJBLGyg5vSEWg3iZk3qNQUFmneQTNyoZL62e9mNDPZs8cSZZ0mvssebWvodcvYZtyWFautX6qQyd/DYcBWiqdonOmWfT6lqY+2Y+/zMBECY0zgdAmaLiOjXDRX7c1naOs7tMnvEMijkzjLPAp3NxU+j8Rxk55oAcBDsO7fxwKtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1F7b4fIIsqtco4sxoUbP0aMqKfhWkRRYTPq62AyBQM=;
 b=G6tpIidiTfnQjjpTqJPI4EyyMP2thZIiPZ/aLlsVL+jcDZodOdh6mhAw5a//TraL2JolALU/9m9Sj6hECFFPXj69d8/YP2469NiFKgCal07EMxZEu6jBmE6IdC3+gh1O6c07jnLUB/3wmG4pRnuF9SeLznGK21jo6elbMSTx+fGq7oxHUa84Jm9WE73yIYjlDLUPb+6+MH1eZu7Xh+wV7GxNpm7K1xPrVAT8Ayb++19H6CWatqvrJ2FO6XpT6ONQHRlDknDlzeB317r4hQo27eFOFvhoV/e57B6q6k6ux+xSxNoTv5aNr1XGNHJRxOPUMRL7nZ6XyuCbVYosx4/9PQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB10055.eurprd04.prod.outlook.com (2603:10a6:102:380::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 17:23:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 17:23:26 +0000
Date: Thu, 27 Feb 2025 12:23:18 -0500
From: Frank Li <Frank.li@nxp.com>
To: Stanley Chu <stanley.chuys@gmail.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH v5 3/5] i3c: master: svc: Fix npcm845 FIFO empty issue
Message-ID: <Z8CfhvcoQSKsk3Ev@lizhi-Precision-Tower-5810>
References: <20250227060131.2206860-1-yschu@nuvoton.com>
 <20250227060131.2206860-4-yschu@nuvoton.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227060131.2206860-4-yschu@nuvoton.com>
X-ClientProxiedBy: BYAPR05CA0081.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAWPR04MB10055:EE_
X-MS-Office365-Filtering-Correlation-Id: be99ddc3-bde6-4d15-7747-08dd575371d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jCUpJKDJ4hxAAE1bc3B7Xcuh3CQIxkyq0827yyh8wstyNRTndTZOk9mwennb?=
 =?us-ascii?Q?0FnEcmrsZCHAssLbLPfgcRDy8TugFUKuwoi5uP5i83IlwXcuNKDm28DWMKf4?=
 =?us-ascii?Q?mxiaLj0th73mzPmOh3+6a2ogFyYkFMXu21Lnpc9TIp6Tn37QjTx3sdN2BPvN?=
 =?us-ascii?Q?2q/KKYoG6TaDYM5pBB+byzJymJK0wpu8FoNixAAM+VYEX56JSEZcP58rW9mf?=
 =?us-ascii?Q?tf+GYpoD7pQI1GtcHiryAly0ndmHDPgZRJv/taRA6gSLsC0oCmkk+Vkun4IX?=
 =?us-ascii?Q?gCHN4RHkLpBISuxYLktRiMlzxcK5BAVZzJXY8d9a6SAlo754E2Xi+W4xNb25?=
 =?us-ascii?Q?J0F5XUysYiFcl2Au/Wg9NxSsev4hx+aa9GkLCRere9kAW+pJalRD6fmyx82H?=
 =?us-ascii?Q?csjBM6S66M2glJ4Pi0NDEEfpXiA4/JQoYFVS0GFSTMVzAtzXvO4bu8OfL0N1?=
 =?us-ascii?Q?C54pH6n5LcIzhcC4lEfRKu0bFj6kUr3Qr0KcAAiAJ8GNnlcNBTCPuV9/OyK5?=
 =?us-ascii?Q?7aMPgFmWQWq7NJ/aUTKLBzzY0QQg5sbzVjnCQComKvWEhf/vDe9QM/EXo+fB?=
 =?us-ascii?Q?KHcXF9LiTydzge3ibhkHzCI5Pf1ModmOBV8xyeiXjUd6GjxCoYmG4Pu+vkBQ?=
 =?us-ascii?Q?h+Y6VhgzicwEj8cYXFkqHJjF+yDke1eDtr6nlvCOiW+SlRdiS9CbamclPAxU?=
 =?us-ascii?Q?7Io/wgxz9Ds7rCHxD4fkPMMEV3Bc/UmnAUxD91jyVA1/9gIrNFRRA3VmRCiu?=
 =?us-ascii?Q?HGOwysRAvIXp6QOldNj7tiyfXHRwVdLLyx89u2OYycfWRFDE1SETQe/XBbEC?=
 =?us-ascii?Q?TNu+ZbIlLwhOM7oy1BZE2bTejHIs9bNFndy4xQqjJ5ZkWnr5fyF8PPXSFAw1?=
 =?us-ascii?Q?z3Y6OdedzaKuiOApqd04KagaNyME1vanc7xIGy2t3qUKv04sBeHoBh3lcAoc?=
 =?us-ascii?Q?Y8NQILR/JvrNitadTzpbJrs1l0eIHt4GYOnE7jgfCyxK8ReHUlHzW8roXi5M?=
 =?us-ascii?Q?aBx5YmEohvaIPDw3Oa1sRcw2B9YFAG4CL/F8/tSwJvUqq/08GIoQcMcvTwSE?=
 =?us-ascii?Q?fHqWs311C/PpC8Dk0r6FEp9qfYMcYgl5ldyHyxo0B/VVBDw/YSnN/113Jw6O?=
 =?us-ascii?Q?0Mx/nUoocR0sXixAiJJIIB0BvE1uEfzUsTqiDMnKc4qaepUh0r7Mca/757DP?=
 =?us-ascii?Q?fcumvJ4busZP3WGJr8shBY2wKTvE7Xfdkx7CxVSzIV8E2VfiesZ73DB1SDqE?=
 =?us-ascii?Q?0UWWDg3i3o4SeOvr7Q4i3GG8RFdkLqlsT115B2u8Jbc261KAu0wwBnvmPHO5?=
 =?us-ascii?Q?5PJ69reZl0CRwNyNWdsJIeXf9r6C0VHv8+HF//WRKithHZvKluiiVuwrewwR?=
 =?us-ascii?Q?WNU0wv4RDwlDnlPMe7M7hbCcxMEQ8S74Z4Z2wInb6sGRTIED69CNWHsMXLb9?=
 =?us-ascii?Q?PJfW3lHk7srWxba5MHx3nZ9IU6eESlgf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5O81/KgmDmp9D1kzw2FpBA1Uzv00MmOp3bRgKXyC7QjnJGm40hWgRfwfStz6?=
 =?us-ascii?Q?PJyt4mal5Iko49NNbdCBdj7atmp8Bq6iPTMlwItm4UWgNfqnN3iSBgVIRXXa?=
 =?us-ascii?Q?040cxlyLiDMQQ6xDuerriMEcWFZJM0mace1ktfIDsUAoekxvcgfP1F5zW7pn?=
 =?us-ascii?Q?0yO6tNS3DSxzfYDzwA1xLFhI1tRUSrceqRroJ2de7fnlpw24vSovLwJwrgJC?=
 =?us-ascii?Q?d4aQs7HOoXkKRo6jESIMdF/R2A7HzESqA2Z4CCz8Wk7otM/WqHBofbT/asL1?=
 =?us-ascii?Q?RZN1Mz69UNlpPWeaMbE/ZkonEv4PZY3BXLhtibat0SSYg5ZHBldSD72BUKQq?=
 =?us-ascii?Q?dHQzaZXtPYfcJLmVIhvWj2HcxC3u5bPq+Nm+sPlwO6rhU+1b5C4OcK6kFL9U?=
 =?us-ascii?Q?5SmIkS8sfvaLhaFZQus4IdYTh46wF/luwj8Vsh1spCSQ/Kpau/8hKv+120vU?=
 =?us-ascii?Q?0ZdVTtZ9mK8gEXx8uZ9v3wLi7Eyrt/zXpXqlKjyOt/zS3ZgM08aTLi0FllCB?=
 =?us-ascii?Q?Jm1B/Wl2dDV2i+ZnNbhFB+iup5Xv5g9XgKL78ZxWJ9fjL+Fju4HEp/eq7sfm?=
 =?us-ascii?Q?hZMr11E8uKDfVvyHFMMuok/B0zISaa6v34iYZwdK6YKPW0etArpABAwfy1Mh?=
 =?us-ascii?Q?0tmVi1Leq0CibE9zFxIe4KVRVXRX65oTYEdJC4Og9ROUVNvkOLQnt0qyFV3Y?=
 =?us-ascii?Q?nIpGiyVVKS5JioTi+F0E2JVdrbHQaOb7TunmXEs8jtm0KN8173JYOAusHbc+?=
 =?us-ascii?Q?3vGhV8N6BCXDk6PaZ7PKd1bNL2/D2AvwlMjJ38Q2HM+k7fT8GbR+4/xOBcFt?=
 =?us-ascii?Q?6VUzMLSHxrjCdxDoAs8lMfHcMhX76ta3lLByFKIG4niBDCk5s65WvJnj/RVK?=
 =?us-ascii?Q?gc7MFzfNp16fXj6VYbsx5gqQLfjy6tFyfhNNAau7lYmWtJpgD1qPi0i6IrMZ?=
 =?us-ascii?Q?WWRhxkru0W3Fu1ZITUVIf+m/wOwP5uEjNZTmQXEUEJhlPTNdTetkSyRpX5yz?=
 =?us-ascii?Q?JLOq2TO3DxuS8RBM+LGmI9Z/Q6iWZMsBJJ3kjqafF9SGL7A1FV6HQGEg1fQ6?=
 =?us-ascii?Q?da/+IBz5gDNPxv7WsjLECKR3VPit4IBDSX62ZCYtdEORgrx3mkjGuom6IKVg?=
 =?us-ascii?Q?gXy5ssoF1ZzH/ldtgfu0Edo5Fo6mrkPci4zmvJO8PV+MLW2OTysyHZSggwQb?=
 =?us-ascii?Q?Wj1YPH+lMff4PwROch2xSBBLXMxdXqbwFlRP5P3nt5L5zsN77b8iZy2dDfa4?=
 =?us-ascii?Q?GcigiiYJWg0Ysb76eajaBZoyEze9IvYuqR/u3XfJYEFYF8+uGakyo/ejEJNZ?=
 =?us-ascii?Q?LOxfBOtI6iB4qX/KZkhyJGALQt/IXg8ehOMryM7S9mYveFT0XgMBGzgIj7fG?=
 =?us-ascii?Q?bs5cgm6uofHv25wtTu+mgjpw9ofa1ME/QNuOt9S1hXLymUF5/YSFBZ1r7XQT?=
 =?us-ascii?Q?zC669tCZ6/LyXwVSlrNUkt8TLjm+zgfpHnJ44Xy585/s4qjzkRHzcbLGCYXx?=
 =?us-ascii?Q?LHJlYb5/JBRsRIwaXjI1wH3sxwP/evdkEYSJmO8QlqZEss9gSXVKRT0HNVk7?=
 =?us-ascii?Q?wQ31kay7yCXfIpt0wpQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be99ddc3-bde6-4d15-7747-08dd575371d7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 17:23:26.1533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /QYQ//UOOBg6LzHvBPIE8JIOmqrlhwq43bbHNRjy3LbEjRcAHCytiz8K0Ev7+qxW1vCBHYtIYb5062etcrj88w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10055

On Thu, Feb 27, 2025 at 02:01:29PM +0800, Stanley Chu wrote:
> From: Stanley Chu <yschu@nuvoton.com>
>
> I3C HW stalls the write transfer if the transmit FIFO becomes empty,
> when new data is written to FIFO, I3C HW resumes the transfer but the
> first transmitted data bit may have the wrong value.
> Fill the FIFO in advance to prevent FIFO from becoming empty.
>
> Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> ---
>  drivers/i3c/master/svc-i3c-master.c | 52 ++++++++++++++++++++++++-----
>  1 file changed, 43 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index 9143a079de53..a0c6d8053a25 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -114,6 +114,7 @@
>  #define SVC_I3C_MWDATAHE     0x0BC
>  #define SVC_I3C_MRDATAB      0x0C0
>  #define SVC_I3C_MRDATAH      0x0C8
> +#define SVC_I3C_MWDATAB1     0x0CC
>  #define SVC_I3C_MWMSG_SDR    0x0D0
>  #define SVC_I3C_MRMSG_SDR    0x0D4
>  #define SVC_I3C_MWMSG_DDR    0x0D8
> @@ -940,7 +941,7 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
>  					u8 *addrs, unsigned int *count)
>  {
>  	u64 prov_id[SVC_I3C_MAX_DEVS] = {}, nacking_prov_id = 0;
> -	unsigned int dev_nb = 0, last_addr = 0;
> +	unsigned int dev_nb = 0, last_addr = 0, dyn_addr;
>  	u32 reg;
>  	int ret, i;
>
> @@ -983,6 +984,25 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
>  		if (SVC_I3C_MSTATUS_RXPEND(reg)) {
>  			u8 data[6];
>
> +			/*
> +			 * One slave sends its ID to request for address assignment,
> +			 * prefilling the dynamic address can reduce SCL clock stalls
> +			 * and also fix the SVC_I3C_QUIRK_FIFO_EMPTY quirk.
> +			 *
> +			 * Ideally, prefilling before the processDAA command is better.
> +			 * However, it requires an additional check to write the dyn_addr
> +			 * at the right time because the driver needs to write the processDAA
> +			 * command twice for one assignment.
> +			 * Prefilling here is safe and efficient because the FIFO starts
> +			 * filling within a few hundred nanoseconds, which is significantly
> +			 * faster compared to the 64 SCL clock cycles.
> +			 */
> +			dyn_addr = i3c_master_get_free_addr(&master->base, last_addr + 1);
> +			if (dyn_addr < 0)
> +				return -ENOSPC;
> +
> +			writel(dyn_addr, master->regs + SVC_I3C_MWDATAB);
> +
>  			/*
>  			 * We only care about the 48-bit provisioned ID yet to
>  			 * be sure a device does not nack an address twice.
> @@ -1061,21 +1081,16 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
>  		if (ret)
>  			break;
>
> -		/* Give the slave device a suitable dynamic address */
> -		ret = i3c_master_get_free_addr(&master->base, last_addr + 1);
> -		if (ret < 0)
> -			break;
> -
> -		addrs[dev_nb] = ret;
> +		addrs[dev_nb] = dyn_addr;
>  		dev_dbg(master->dev, "DAA: device %d assigned to 0x%02x\n",
>  			dev_nb, addrs[dev_nb]);
> -
> -		writel(addrs[dev_nb], master->regs + SVC_I3C_MWDATAB);
>  		last_addr = addrs[dev_nb++];
>  	}
>
>  	/* Need manual issue STOP except for Complete condition */
>  	svc_i3c_master_emit_stop(master);
> +	svc_i3c_master_flush_fifo(master);
> +
>  	return ret;
>  }
>
> @@ -1272,6 +1287,24 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
>  		       SVC_I3C_MCTRL_RDTERM(*actual_len),
>  		       master->regs + SVC_I3C_MCTRL);
>
> +		/*
> +		 * The entire transaction can consist of multiple write transfers.
> +		 * Prefilling before EmitStartAddr causes the data to be emitted
> +		 * immediately, becoming part of the previous transfer.
> +		 * The only way to work around this hardware issue is to let the
> +		 * FIFO start filling as soon as possible after EmitStartAddr.
> +		 */
> +		if (svc_has_quirk(master, SVC_I3C_QUIRK_FIFO_EMPTY) && !rnw && xfer_len) {
> +			u32 end = xfer_len > SVC_I3C_FIFO_SIZE ? 0 : BIT(8);

Define BIT(8) as macro

Let me find a time at next week to do simple test for this.

> +			u32 len = min_t(u32, xfer_len, SVC_I3C_FIFO_SIZE);
> +
> +			writesb(master->regs + SVC_I3C_MWDATAB1, out, len - 1);
> +			/* Mark END bit if this is the last byte */
> +			writel(out[len - 1] | end, master->regs + SVC_I3C_MWDATAB);
> +			xfer_len -= len;
> +			out += len;
> +		}
> +
>  		ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
>  				 SVC_I3C_MSTATUS_MCTRLDONE(reg), 0, 1000);
>  		if (ret)
> @@ -1360,6 +1393,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
>  emit_stop:
>  	svc_i3c_master_emit_stop(master);
>  	svc_i3c_master_clear_merrwarn(master);
> +	svc_i3c_master_flush_fifo(master);
>
>  	return ret;
>  }
> --
> 2.34.1
>

