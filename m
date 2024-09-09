Return-Path: <linux-kernel+bounces-322173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F1B97254A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 00:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16DF01C22992
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2112618CC09;
	Mon,  9 Sep 2024 22:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OtYuo6vB"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2092.outbound.protection.outlook.com [40.92.22.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD22D1791EB;
	Mon,  9 Sep 2024 22:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725920759; cv=fail; b=aj4x6bMLDpVCNeFjXOcl0RX70SdXTBi51fadV8lSIhfBg3f7EWKOcnBekxLqd49pRMg1wozD4zFh4KMbnY23y2gVu4aAcYm79GqPjJ6hLuLZVanZEDNgVGJqHZSeonAqIIyV0ruA35L9C+zdLOS9IP8R5AvdV8OU3mHOoHIuzqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725920759; c=relaxed/simple;
	bh=Uct95l/0IQZ/hRj/cqbFXRbZbTIMpMxWlTdhzuJvBlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YnCgVHAP/qNng/kLeZtskePBMXebGobziLSQU16PXrTweOnzkhJT9X2i+2VhWIjPv/y5NM7E5QIueeccSJaUEdTSA4vZc348zvdfaez60NS4ICUy5OwpTmzf+MXDmolsMJkTHcmaBWOVwh9oBHcg/18/u+RJIw9w1QE8V64fFqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OtYuo6vB; arc=fail smtp.client-ip=40.92.22.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XrfHcCYBT11CmsPTYxMhbHHFyaqoq21DWdW9anJd7WrsJTO1+t3U+v79Aw3gL88cjwK+9rdq+KHSyi6B1sZpdzXd2GxB3HO2z44oFSWjlyMMLohBTlzr7Gy63uxabirDmJDp4Lz3WE2MQlihpWF1ieCnsSl1rKQ+5KXDo+Ose86wVpnvZ4ZfFicxdvTlZMPr4Ww3WRzMhi9aPrTJutH4J7G9Xgv0EE/m54MJGYkqdwJbVvhl5QhvR9J6abgvdaXm2urfXd2IdYQwp78MBnkaNNGmCutPYhLwWnJiAf2w9tUWmt8+0sqvVJl/U9NWTktTGXibgWhDplWG6r9LNmBorg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tks8eCInAVEoVYgBhFPKzfxvPL983O7VHag5zAQzJa4=;
 b=m2ZqQUfIcRCA19uGOpfX7dcRUg/o4hip9/+HN6pgTNqNXYzkQM7HO3xTvs92l78Ks+M6sR33KxRzMbgSmetIMq4aAvn7Wo1lCGRm+C7ipNzQ+mAkuoekLH5S4733KAf+8tBIzfXTAxAmqORd0l3sBjQHaseX6TJ5wouzJf6WN8lufnFbZp9aIfJQ0q0wvgnzwtbGDWePM8nGNJxhizWYq47Y+3othoRPiPeSCttbaEu5eLv9udPUJezNYg9tnxoFA3WCh5S0LXSHCz7IEY33/HitdJvFE+pyBTlWIdoLyDjWALGhng32p4WbKxNPujqlcQliC3MbppXuDBaIqfUhOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tks8eCInAVEoVYgBhFPKzfxvPL983O7VHag5zAQzJa4=;
 b=OtYuo6vBCk357p1lQ+edC/g8sGYPCFwmP4rlR+nh/d7vAYKD7uLpKD0GLKhJUyRUDa28zGx8+ZuaVSX/Cr4Jd0Ev5mBPXxQxXN7N8p+CVuPMMqrQeQxN3VSZo45aNxF3iiKSjp4iVedRg77iGR5fjlusRuP9/6TK5VItNDKN1hKK+D4s7801ZtU115QlGr3W6tWeJ/mIo31gk4VkT+JTVTnjwhV4/GClmjyF9JvLhYpcpiyTBlxHRL+vcFI9JpTzdJfLqSVTmozfoyDTiMGgzhgPqytRBAx4EVWweV4PoCJargo6ipTfUDTDWeWwy+/oo74fjAPOJlO4C5vBMPNlkA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CY5PR20MB4949.namprd20.prod.outlook.com (2603:10b6:930:3b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 9 Sep
 2024 22:25:55 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7939.017; Mon, 9 Sep 2024
 22:25:52 +0000
Date: Tue, 10 Sep 2024 06:24:34 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Conor Dooley <conor@kernel.org>, Inochi Amaoto <inochiama@outlook.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jisheng Zhang <jszhang@kernel.org>, Haylen Chu <heylenay@outlook.com>, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] riscv: sophgo: Add pinctrl support for CV1800
 series SoC
Message-ID:
 <IA1PR20MB4953A0D6A2B73D03BF162671BB992@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB495374DB8C4208575AAC9675BB972@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240909-prowler-renewal-0592d820ccca@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909-prowler-renewal-0592d820ccca@spud>
X-TMN: [hLvTlaZkxt67+lYUj+c515BeEpcqPlu6PGwK6qD0/KU=]
X-ClientProxiedBy: SG2PR04CA0156.apcprd04.prod.outlook.com (2603:1096:4::18)
 To IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <otacikshybxbs6rpmhqpcipfmtwpeytmxcuefwgpuso55n6fwj@bvwtjvghklai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CY5PR20MB4949:EE_
X-MS-Office365-Filtering-Correlation-Id: 153f76ae-a8f4-4790-59bb-08dcd11e5d3c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|6090799003|5072599009|19110799003|8060799006|461199028|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	Eqd0dNyWxwfleCjT6pSWcnirc18EVia0LfuW+fJN/RFRRKZ07Pz/ww7f08RtXUDbRef/tGraHitFEBqQJ0+Nv/8yVVmou7Pq85NTCaKt78tjTfQSl3W6C7GkO3XBtRfvt7HgLAVUosT+R7KayTUJso5ZOzY4+vWflwKD82CCQkwXnYQNxAEygAUwKlwZAGxs/f32zEoiZJnx7zw+JlbZE/vJvh8ZMTCGu3Xj4C9dmnRVcn72+Nz69wGfVa+vQ2zj9FHzMULw6puzPBgaX3P2y/Y4rrouA/R1WxhjTimf5hLjcxUqAIYaZCHM/PSf8Avyva1ZKwt/WDFzBWB4ZoUFrqTs369v2scjIcRApqRtnOPYH/rQEvSl7v00gJAQlB1f7dO2DT0x+Ymgp0mIx8HW0wPD7yh55VPG/5/GDNyGzS/UP8CmqYNx2r/KBbg4td477Pu+D3klnRcBE0l8pbpLAD/7fHI7eNKtrIlDFzFsGxK5ChY8VArcI1GxtKX9DT90CZI0CWhUCmnClMr5C0NEFf02D8rtG8nwPYdFsSmgCcnOU8HqFkQ7h+BG78uVQLFidL+NG6EjjxDbGHWCve8mIAxKdjgW63J+nn/ekwvgQ6L0rf9YuJeoa6eDKsy8S57XX6xVFFCEs7peDcFR99PVOaP+KMON2/ActPUhQYcor3iNpxripoRe5iy539sIU0/FLFXEDcVmuumxGV20rgc56z6+fFyPZsfvEStWgk0tzolz6Jsu10qij1eF82VMeGSuy8xMu5e/EjGQ/7oRFdqCmQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fv0moVOtVN5BzMJAeEgnirPX6vl7aFd+8LT4bmIrbMHCRa5c2zEbovF8r6Fn?=
 =?us-ascii?Q?fFC6qsy+VoSqPwi1CMtDufVuS0O12YGh/owY5TV2c78boUvI90U4qckT1zcu?=
 =?us-ascii?Q?nSbJwJf/K57/e2xCYxHRuewjCIeTozkGXEzSLqDfGAownrZuFr9GsDEImZa1?=
 =?us-ascii?Q?Px+vtQsEblpOTZpbALEQR1mUQQCBadQb/zEoGbyY14uuUUkk4s17Ok7dvju3?=
 =?us-ascii?Q?z1l5LFBYkpZuGwsel6aFFWfcZV3al7zk8TkoMONC0qf6ANENzQT3QgFN7Fvi?=
 =?us-ascii?Q?tUhnQbEZCAKdbL6fu9MSo1Gqcrz3O0NFJQHxoL2kUDtPN99eEJIPSPA8RlKV?=
 =?us-ascii?Q?PL+6O94R8Kg5LOw1IecJ58Q7/cDNF+WXlBLeGcrpyJqk28ROorf8w89VCX92?=
 =?us-ascii?Q?P0pvD5N2mBMT2mxuAASSPsvAVZk0Gp7mtIFaF6vRRoJ2xoUsOl2XCnJO8zcS?=
 =?us-ascii?Q?wlHRTq8wLw+vxZwpz1kZYN7CE0ZxILGK05WQG+Mobr8yFkAuWI1b38g8SN7n?=
 =?us-ascii?Q?RtK9e1es19585JJvUN00x1DlISWaSmu/EpXMwQJ2YgrHErrwYcLk/ksjybH3?=
 =?us-ascii?Q?rLNJP0azj51+o9hSh5+gEQhDXfBmssG6E3joDX5zTSyOh+u5QIZZuMrQwnch?=
 =?us-ascii?Q?uAjwcr90HFIYuEHopt8+G96woSN/BcQnQErq9GGYo66iJ61vxuwC9G9LKBN3?=
 =?us-ascii?Q?bJ4qPeAhtZUs4+vs+Py3DJyOPrabr2qAcS4F2+vIANaXi38J8SnzLlYMBQuQ?=
 =?us-ascii?Q?CWz5codeLAB7ATt8TE77DMhmDrP7QSdPLZH8e2ymKQ+8NtMk4Oi72NWWKmhZ?=
 =?us-ascii?Q?cq9KaCnlJQHeCs6Xq4rSXPZwqDy8zI/27PoVZZpIch8SQnpN//TnXB1T74gV?=
 =?us-ascii?Q?ApYm/iCcssEpYRX64wZpeqx9ATHPt+feMuna+iswrUkTl8bQgV3mhf+js0EJ?=
 =?us-ascii?Q?hVOSgs3nLrkKx8rcEEXhXqvNwor4dqBFzeWhBJS3YeS2LCvIM68TSVxDxld+?=
 =?us-ascii?Q?O/zWxE2XjzQwrEPsM8LOmfY0bjigU8m2jY8eSa9ZnEmgJnrb0t8RhD0ZfrL3?=
 =?us-ascii?Q?7ei2OI4y7eEBHj34tFC17+g6QK+2mO8YrpKSUSM4rnjo07LexeZj4qhaCPEB?=
 =?us-ascii?Q?aPNoIzJqSGdTqiNcGsIQOgvigfDxryu4mEfDThsZot20CEWIszwYIiZY8Mpk?=
 =?us-ascii?Q?FMcc4qDr9IP5lIqNC3BQGHiNN81GoNdmqX0/smhvCf55UUTbgqi8/168DHHe?=
 =?us-ascii?Q?y5x0yMadbMLBKcOiKfkh?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 153f76ae-a8f4-4790-59bb-08dcd11e5d3c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 22:25:52.5519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR20MB4949

On Mon, Sep 09, 2024 at 03:41:10PM GMT, Conor Dooley wrote:
> On Sat, Aug 31, 2024 at 06:38:40AM +0800, Inochi Amaoto wrote:
> > Add basic pinctrl driver for Sophgo CV1800 series SoCs.
> > This patch series aims to replace the previous patch from Jisheng [1].
> > Since the pinctrl of cv1800 has nested mux and its pin definination
> > is discrete, it is not suitable to use "pinctrl-single" to cover the
> > pinctrl device.
> > 
> > This patch require another patch [2] that provides standard attribute
> > "input-schmitt-microvolt"
> > 
> > The v4 version is from [3]
> 
> Which version of this ended up in linux-next? I see a link to v4 in
> what's been applied, but this v5 was sent before that code was
> committed.
> 
> Either way, what's been applied and what's here produce warnings:
> cv1812h.dtsi:19.28-24.5: Warning (simple_bus_reg): /soc/pinctrl@3008000: simple-bus unit address format error, expected "3001000"
> cv1800b.dtsi:18.28-23.5: Warning (simple_bus_reg): /soc/pinctrl@3008000: simple-bus unit address format error, expected "3001000"
> 
> It's just a copy-paste error I would imagine, but please send a fix.
> 
> Thanks,
> Conor.

Yes, it is like some copy-paste error, I will fix it.

Regards,
Inochi

