Return-Path: <linux-kernel+bounces-236592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C628391E475
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C92C285ADF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C172816D333;
	Mon,  1 Jul 2024 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QXA3d8eh"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2076.outbound.protection.outlook.com [40.107.247.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDADA16CD2E;
	Mon,  1 Jul 2024 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719848755; cv=fail; b=CiEE8gfOqrNCy5Srs0si8bUwBEeLjGlnIv0DBByeFsznbEmGsg9lXdckOHuMichOLdgKBifr+llEsn1XWpYi4ncnWooTu04NPCPDoW489bUd7fs/nAENcWpUji8cGYZEAc2xVGkBd902ZMs8tVGiMgnOZ+tmPM61glQHD/61QMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719848755; c=relaxed/simple;
	bh=AvsqKe3NAQdwNSP9t45LDirbg3NOe4/hB1HlzwcRjhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HXDzskpPq/rBm1kkdapKaC0z4SQ437Tksiz8XT7seUeue1g10I2zsTM0vJWVZJJMuhhL26/ImW7AHDO0c7fC27bIcPrXPpGt+CtpRiJLGVhrOw0uVhB4fQNzYNVpwvdoWklw7m+FGxmrkTqc78Nmf6XhPLaET3CB1l8gieAAHtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=QXA3d8eh; arc=fail smtp.client-ip=40.107.247.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7l8KT7sUWs4JMMPa04Ssrhu9w2V4qfDWZaicmke4Sz08Jh3jJuMNNTtZDb+8u+7Zl16HoDhZ1Jlf0x7CYRPDMW8dMyb3cJnh+0yNt8jW3DWNcg2i7ymykjRcDIHWTP8XATWGHz9++JpSy/uu8oe0w4rx0uawaggU8jGnY0jehDT8KjMvu5c9L8tzODz4+ASdbzClYlfLeA4kRP2AhZSs4+yB08GUJt1btgmGWp3hmxPqH7osbl57cPBc4cm7Lxa2QNrv16Cqvuq+R2QiKGWPxF0T+WjmSYMH6TZ/I3S7B/EqId5bDDZmm7DNJfS4TfJ0H/oeDA1pz73uqhIjYCFGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okMDi51a/kMHt5pcLQ2qcX88lbSka+BBND8WDsdvqeM=;
 b=hj3DwuLBNY5qd/DWL9rw5KvHZ0CCI8oU+M561zWf1XNgRiHQelV5rhG6VWk8EU/1JOQZZ4+RiOa4gHfF+6ZYjycT+ieZH6CkoLeLhTGseA0ilnx+jxLeZ47zstPftECa4CE50t42A8LCmVnFTKVUMUECXX7tVP4rJ+mALrToLnGa6pJN9MZU8g2cVF7NLFkaif+NpGJkowz9Gyz3rqgt/nxbVfW0WGQm53NZDT3B65CnhA0aNXZiMdwmp18fq5cGxPt9Kc1hgzLYT+CLWcRey/iRjwz7ec3C4upH5whV8yjPyeMYoS0fJgWg/oXkPGc2AEkprMiffgkcV8Hcr/rE5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okMDi51a/kMHt5pcLQ2qcX88lbSka+BBND8WDsdvqeM=;
 b=QXA3d8ehBl102RCGjMZuc0rOp24Og3sZkLdUvZlp6vXmzHJsqAJWTcpBJMpR1lYgAgW3/x+vP0ng0NXxD3Y0OnUmWIo3qI7gllZfaut0C8oa7K2pg4pYEcIhjnTuLxa+/V0pyRFzjfJTy2i9W+8OLDA2BRQ0WPLPES98HlGBDbM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB7115.eurprd04.prod.outlook.com (2603:10a6:10:128::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 15:45:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.022; Mon, 1 Jul 2024
 15:45:49 +0000
Date: Mon, 1 Jul 2024 11:45:40 -0400
From: Frank Li <Frank.li@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] arm64: dts: imx95-19x19-evk: Add audio related nodes
Message-ID: <ZoLPJPR8r1+XaRAB@lizhi-Precision-Tower-5810>
References: <20240627220001.692875-1-Frank.Li@nxp.com>
 <20240627220001.692875-3-Frank.Li@nxp.com>
 <AM6PR04MB5941C1138E4F33AA3FA49AA388D02@AM6PR04MB5941.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB5941C1138E4F33AA3FA49AA388D02@AM6PR04MB5941.eurprd04.prod.outlook.com>
X-ClientProxiedBy: BYAPR21CA0021.namprd21.prod.outlook.com
 (2603:10b6:a03:114::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB7115:EE_
X-MS-Office365-Filtering-Correlation-Id: 9533c0ae-6cf6-447c-3614-08dc99e4e121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fmjqd8QviXdDefpKmLBjlqXwtfDZPDhJ0XXyIqUXUw8HG2daJxkb669uA/fZ?=
 =?us-ascii?Q?NeDzDBJlYH2BWfAm6KurG/3IhA+seg35xZ4Bg6y5kd8sNEqRqvWEH/YEuQjR?=
 =?us-ascii?Q?tRMcmD/v2LDhvpuaPV0BfKQEvKDeiGpO6JpG1RsovV9vlaasxvzUVAGaGDvs?=
 =?us-ascii?Q?bBSu/DvUJvCDxAQd647BHzTyY6g/D6N7uV7NOtq5cSfIScUQKbC0Mk1hJC7S?=
 =?us-ascii?Q?ccRWzudNocmxI/577huKhGckkmza3/NqPwZiihccQ7QGjrkivTmIZ/eQVkmj?=
 =?us-ascii?Q?4Wee1pea0RsB1aXjd+nNqMpOJcXwbyc0DgsjYNjHuz8aMO19+bZcGWKWdfjp?=
 =?us-ascii?Q?R+hjt1vxZlNH50c9q+ftDNTUNFsspzLxuzNrStHMa3SmJenYvEnVFhQSaWoR?=
 =?us-ascii?Q?PmEKeZs/pe8EqzkLSzub46/GaInCcE+27FL3/QPfElX5rt/7IZPG8ZoKwLy9?=
 =?us-ascii?Q?4Ir+rSxoKhLjdeQS+xMsH70fATh3n+iAAnPU2L5W+mC9DHJwKcLehhgKUmMz?=
 =?us-ascii?Q?PPP0pZJiJ4KqCKkJVflri6OtGUcBzFrIODHqM2lmJLUrMtTfQFo7ectrhJIk?=
 =?us-ascii?Q?alB0HFmUsr9FNbHpS/8yh2SCfiM0bplKi3tkpGvEAvj1bUItwu1JDVCxYxpL?=
 =?us-ascii?Q?IWGHpIAABR6yhfA+IxqgarI4dwAf/FiuZIOEU+LcAXvt1/z9hv8w0mZqjJVn?=
 =?us-ascii?Q?S8gtaUEHqPCeszzgfZtXFSL0sFuyv26Yo0qIUeV6WnKIZ/YTmacQvhaWOuhk?=
 =?us-ascii?Q?J4UO/A7XS3bM71GUp02CoNF9FkR9CjT+O9wuBL+X67dLqph5Opz7J70xEkKe?=
 =?us-ascii?Q?+A6phXKukmy0L+TxxtG6UQd+bxnwvvqm6qaYGx5ildPVXwLl1gsEZ1TLK79/?=
 =?us-ascii?Q?iIMw2p0AyHC3TXpbfkX+Rqd887M/0Ubq8soPdDNQ42TYdyluDwdkx/IMwYBJ?=
 =?us-ascii?Q?QGneO9rg0W7jqHPUUDfgRefYCKNUvxIZIysww3wHX4vLFPe4z/gldfFpp6eQ?=
 =?us-ascii?Q?KZWbEXR1HaOY2483SVYjO/FC2sAmL8+FJeVX4XhtGtV71KlXiJYBkTUCVD7I?=
 =?us-ascii?Q?ITACfZdG0IBmguMbE4KCTmixg8AcvmZuqirfOpKO1bJHyjslUwk70l7Oy3DC?=
 =?us-ascii?Q?wIHj+F17bmFaNTRgvzOcuu2Qg42RxHbWb8MEl7Kl6XWp9XiB84BIcX3Zm7Q4?=
 =?us-ascii?Q?fWJXrmrm1bP9HeC4JONB8XpUft5ZFH2Ud0esgz3lrc1kT4XGQS92WmQhyFUA?=
 =?us-ascii?Q?rVcCTyW8so2umTF+YX4XS+2to3NnBEqsgcHZqCs5LRpbPaTBzcojjgTAqCPA?=
 =?us-ascii?Q?9yqDpz57YKeySchLhER2YuKEVMzwE0lgeJrMijv4/H8wtt+gVuLv41HCi2/b?=
 =?us-ascii?Q?2yKP+opwhd4UbJgY2jerJTA9zGcdPbE3LXmSS0+K8RKEmCcKWA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ma32rxEBRUC8MpEo5w3bAxiZBfRiLiZpC1JhWqoTAj7NJeqRmjzliESFa7Zp?=
 =?us-ascii?Q?OEg8rBdBBRnA1Fnju9Fqc4NDMnSbg28lX3QRI6A4VaKYIH0jDBvAb6N0okNT?=
 =?us-ascii?Q?0C9Xtrtn6oSIeYvG6nzI/OrHOI/udzqDuZPSTQCyhieimWv5YdbTwnlL94oB?=
 =?us-ascii?Q?7lABe2a3P7VyIH850lNzVJ+Iqe5J2NFS77wcbUd9r3J54no3y8dcPBZ5uNxD?=
 =?us-ascii?Q?aGrQdOlPaoF2kYGihZpkQRDB7flow7WJPV1ghQd+4LWvIFw2dIJ6SPpDe2tM?=
 =?us-ascii?Q?duRp50ZqNjydRcKQ16mNxBW3bQhCbKAltANwdSn4nEgR70aLA9lXfOub/N8Y?=
 =?us-ascii?Q?O8TVI6kvyDW358fvgPHRgqhb/rgazJJzu1rreECJLHLbDTt15XGe5A/rNGec?=
 =?us-ascii?Q?rbHjott3WDze/Vdzx0FYo+Cw+AFg5nWWXzbj7qnUBTKcK/MNLl0CeHqvyBUp?=
 =?us-ascii?Q?lfa43L59py6ct/O8qAmxHnHmqGoN73Rh+MH0XK3EuuxaPyF8N4CflNF4cWv+?=
 =?us-ascii?Q?FyjABZtCwC6NQDKck+2oczdTcsMARNafIKBwqYUUOvkfi/ScbrIMDoK/Qat7?=
 =?us-ascii?Q?DOgVD4BHfRB/DdikNKNpHKoaZaGyVsqQ1KU+PmaU+qSGZPDk+3uYKwwCvHpy?=
 =?us-ascii?Q?6Y0Kz+k8qVsL/tk6BGu0z0yFesRv7JgisvwTEP7IyRPOlrJKO90wg+/TyCrw?=
 =?us-ascii?Q?9ZSQRTvg54il1pDSLq4csfn7T4HwyAyCgMREg7/VsStbmlLjm/fzgZ+awqGW?=
 =?us-ascii?Q?4shOsxHtLV6vQxqjNYNT4EdVQl7fOJxbZ6n/p4PT9yn/QSj+QTjJCf1RgUJk?=
 =?us-ascii?Q?Q9wJCAbPEdYB7/U1ohIfpcHV6YjBHFeRR9O0CHYZdicv+v3J91Dx7pkgC4di?=
 =?us-ascii?Q?Ot6L9z9rlhZwRKfnaQMRTGsqnpJo4oBEtXymHKlvprLHEyqKKOhh+OZY7LgF?=
 =?us-ascii?Q?6B1drHy5ixc6e7clteFbGuQjbTslftK4Hmm7OvK4pkxc1LGdYhYrwWiTDCUd?=
 =?us-ascii?Q?pU12iB5QFQtI/Uh1k+1UarDhkrlB1UEss/t87EMNFsrvL3p9rZ36HlrrL5xT?=
 =?us-ascii?Q?rMvCDxhAlus7HTCCWjbueUwuJQSGxMMtCjk9zEaDNbp1/CandLjftRUJZXk0?=
 =?us-ascii?Q?PbImLa+64nIrUVvfT+0Y5rNosxh0wxTjP0TL6mkbboyi9Hf7E2gH3xVUSFZ/?=
 =?us-ascii?Q?adVc1RTkn35//l1DDNctGvAwmwnFl897SkY+zgzCBWeJVkePuEWCttGIRwMt?=
 =?us-ascii?Q?YfE5SNFVQn9I0Q+uYjp6iKU2mNIVcGz57+n1Zj3wKrzAtp4jK1WB6kRhrtRE?=
 =?us-ascii?Q?stB9QbXci2KmYsYIvPaXC47iH2S5YTFFFwvhZ5apKj655vqSmDM/S8GhkHUG?=
 =?us-ascii?Q?xZfc1pZe65dv9/fyREk9MDrgUBxk8Yadt67fAC19yHXyZHkl3g7VV4GYGAbg?=
 =?us-ascii?Q?LknALay7uYjcfhO+60HE7PyxgeetpKiTA5QEs/c/HUrW6BL0TJgflVNRwAro?=
 =?us-ascii?Q?nRx8uLzB40Xeiy5dqfKycdsFkRicVTCx6MZOauW31KRwwZmfipC3Nqkfgs44?=
 =?us-ascii?Q?bb4DEt3aQqBBBfaurSnMywL/jg6q6MI1EJtYkZJe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9533c0ae-6cf6-447c-3614-08dc99e4e121
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 15:45:49.0508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PiyrjlEnLR80bx57Y7L31Ceed02JT/Ad3vi0IKG11t5Kukzr6JXbV/kazWrV8zkZy8sX/9XAmWqR61s6yQNXYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7115

On Fri, Jun 28, 2024 at 12:03:27AM +0000, Peng Fan wrote:
> > Subject: [PATCH 3/7] arm64: dts: imx95-19x19-evk: Add audio related
> > nodes
> > 
> > Add sai1, sai2. Add i2c4 and wm8962 and other dependent nodes.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  .../boot/dts/freescale/imx95-19x19-evk.dts    | 238
> > ++++++++++++++++++
> >  1 file changed, 238 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> > b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> > index d14a54ab4fd47..660e623f4f964 100644
> > --- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> > @@ -17,6 +17,11 @@ aliases {
> >  		serial0 = &lpuart1;
> >  	};
> > 
...
> > +			     0x0000 /* 4:FN_DMICCDAT */
> > +			     0x0000 /* 5:Default */
> > +			   >;
> > +	};
> > +
> > +	i2c4_gpio_expander_21: gpio@21 {
> 
> Use gpio-expander@21?
> It is easy to duplicate the node if other i2c bus also
> has one.

It should be fine, parent node is difference. gpio-expander@21 can't
resolve your problem. 

i2c2
{
	gpio-expander@21 {};
}

i2c3
{
	gpio-expander@21 {};
}

It should be same situation as gpio@21.

DT should allow the same name under difference parent.

Frank

> 
> Regards,
> Peng.
> 

