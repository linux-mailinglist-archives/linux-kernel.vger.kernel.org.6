Return-Path: <linux-kernel+bounces-216678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8D790A2E9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 05:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0751C20AE3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B985117E476;
	Mon, 17 Jun 2024 03:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hnVd7ayY"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2103.outbound.protection.outlook.com [40.92.19.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03085DDA3;
	Mon, 17 Jun 2024 03:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718595415; cv=fail; b=P7KbZ5xYUYnnVG6WQO7eRC5hL6/l/asCnv0pNKnpHc4dx3aeYPiJomAoRzIDGSAg7FelEhCbtJ18qvXsuEdho8OKfkVbsQiO94S1ppICrXXLVPmMPyl8RZlIqtUC68ItUC2SF6YEdg1K7S5a1+Qf3lso0QiQisHeXBix03WSBns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718595415; c=relaxed/simple;
	bh=Rb0tDMjA3Uih/lGlMPnT7tF6Rye7RJh2wWiplIAp7NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LXGmqTzJTsNBo9/Uz5BgDiqdl+3ZET1rMLon1fejHie3EgUzp1hYt3j1BHTVu6lGNdPwAwHZlE4ZP0drBiCq/HwQNoQUcYTSEFRQinYZ3d6lk89gtXLWmkbt7BK2PDa1cAHacSGHQYBSxU7Hi2tcLmMtahVh0IeQjYbWUNX4gNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hnVd7ayY; arc=fail smtp.client-ip=40.92.19.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brV7gbBKE3VbgXc7EAYlAKgabdRGCNb+LH6XDmIWWeXwnFfWFGUlv8ZO3fKQNR6kORNSZ8JoikDiXYJvHpaVszodS9Ih3bXpq5OCKbwtg2tdWvfd+gJHtCdfcd0l4pNLr02LXScisHNLYGKG36s+nh9+pSR3eyA+Ju0DB5fxOrfz12LLpMZLpTcIlDY2hn4nKX5v2DwjMBSD21hNx4v+sFIkn50CYy93CTiLCXhwVIidTE4Nzk1NdzeqSvC3VTMmdDngmAtnTYakFTzY8ZL27B/NtmzluGKQqsbn1kCKk2agBUULu8C9kKorCcUb+N+mBb5bD7TKj+uuyCEESJYskg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLDYYt94R3SBx75IkHRdr9goWcLkGiL0nQP9KpGgdf4=;
 b=RC8luhbW61GC5FAuBmkmPqRJbz3PJbOv0e+6VHlwVsbLya4WU1VoS8aZgVyjXuf6AHBrqU3szJ6SiMkelTOafXhLCtlbPWt2X+D3dlMnuYR3Ebte5ehVXhDYnr16R6nGCM92N97rhIUZ65KTyF8eiafAkeiGRrD2kuQXVkXobunqiHXjqt0yX6paYl3ohxkOXzCHiDinBQRE04uXbwFUVNs5ngrYf9EOqh5q41/FVWu+lQ+pzcF+uK9LcGwCKGBwfsLgn9vK1yXbHfac/9zn9rUUd7vDDwtTqEofKnzmyFYdTBrKL3AsOTWUKvQY5Nb0CWw8aSkgvwBNpwPnRGo62g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLDYYt94R3SBx75IkHRdr9goWcLkGiL0nQP9KpGgdf4=;
 b=hnVd7ayY0xx9DUvQeIyD+YFolOU9cr4Is/TkGQ1v7hd+5EkpTGjp2vY+4MCsXujN9mvhrBwKLULVsblfTTgpXv/JRsuLR5vMJhLFHfimZvsLN7RZRm0ArWu12DHTIzYQMBqOKrJwZuZomhUmNJvISHa+nrIHILy8B1HvTqdERayWieWk52pmmmyHA7QuJCRqRVd9lW6gldJgXUEKu5gvw94rryX00g2s04GRGvXT1AvQRDuEP/SGxp8cABU21/lKaGcBHrwLWYhe8TqLWNRvKr+7S8FjwuIJtTCn+o4CVRRJyLTM1C4Lju5TJj7RFFjWyyYzoPZWS8UyHnrF3OqIyA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH8PR20MB6366.namprd20.prod.outlook.com (2603:10b6:510:25a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 03:36:48 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%6]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 03:36:47 +0000
Date: Mon, 17 Jun 2024 11:36:32 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Yixun Lan <dlan@gentoo.org>, 
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Inochi Amaoto <inochiama@outlook.com>, 
	Jisheng Zhang <jszhang@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Chen Wang <unicorn_wang@outlook.com>, 
	Chao Wei <chao.wei@sophgo.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/6] riscv: dts: sophgo: Put sdhci compatible in dt of
 specific SoC
Message-ID:
 <IA1PR20MB4953B4A44227ED6431888709BBCD2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20240612-sg2002-v2-0-19a585af6846@bootlin.com>
 <20240612-sg2002-v2-1-19a585af6846@bootlin.com>
 <IA1PR20MB49534C9E29E86B478205E4B3BBC02@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240616235829.GA4000183@ofsar>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616235829.GA4000183@ofsar>
X-TMN: [teVdx8pYKGkwsWmTL89gu1C9pc2RdzW7AcsQoxpcJvQ=]
X-ClientProxiedBy: TYWP286CA0008.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::11) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <zpijoyh5okdqmhexlcn5fr2mbfnwlrfejfixxeox6myh43ku5b@4zcwrvyqssp5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH8PR20MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: c00157c3-1fb7-4bdc-a254-08dc8e7eb788
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|3412199022|440099025|1710799023;
X-Microsoft-Antispam-Message-Info:
	L0dhNuWsDzx08Fr7TUks/6ApOuddRbr1C4z8MpBk9ljKvchlqrOp1CoehAklRNlXd4BdSvVAY1s2j8bbXguEDfQdCm6h3jSBMSm+vp6mu6YLg5cR+J23Ha5WxCNOL1JT+cimtSN1Ojkpg9HQGccX3GEZ9VWrBD92JY+qN0vOaXJBJf/ZlpD9GzHMPa5m5E5Vh4VDG7DK1I1QMc+eVLgOmxBDiLO74oQh8BTonirwH+W+XcRdRKRhMU2zmvdtOl83AVkB5HGSLoR2Bm974JT12KELxcL1RI/rHq30Xa4dmXFyqVwy39L98odF5baZc+qgl4vSWTjBzozZKXj/kCx4dEbz9D3K7lYjppO1mQs/2lMGFYN3AXMTvqpkbWQZyRF/PMw/+stU32/+QMHAFfLmelX+VBCL4b0y/9aMCR7ZzWe/GbRaYCkvbxghiCqjktp/x0Xux9auFBqs6DOcQDa0bqht8LalR2KpJ25iD7VRUPw10Qd9gYTdQ6lqPLup6G9398//GarCqwKUe4m4Z7Kmvs0/VF0HZm5GhQ43QuEDWD5uGTHTfLoRL7qeDGMAXBk3vzNBB24Wwg76WYOx2zhuvYTGlGgEXA8CejAkTXYJVco8okoxPX9ZbI7yZ6nMT2vG
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hwf1Kvj645Ts1UamDiqqitVMqK23jRPYDECb7BRIF8GYBcT34yY1YXe+CrkP?=
 =?us-ascii?Q?6CE9wJ4cNadjqb1bifMJ6IujWv/nm/70sBJJeRn3j2+3s+fj8nFBSlb8g7On?=
 =?us-ascii?Q?ZQT0ZrobH4I3+PRrCKY7hLHk0Ejm7Kl39Zk//V3muo0x7/G1iG/zaEzZr6gA?=
 =?us-ascii?Q?DZr9Pnl4Vnm5ZB29YAFiqZ5fRk0YUIjOrzttWIlhsglODP4b+0liP1N/MvHa?=
 =?us-ascii?Q?1jQixbQJkyJp4dKsiNysOtp6OFYy0qa8izXJGCaqWV0eGgolu85oriYIfytT?=
 =?us-ascii?Q?yo2P6Wi5h2woU3hxDvMob/eRDRd6CWDrttJk1m05i3zMnjDFSQnqJxVoOwh9?=
 =?us-ascii?Q?74leQy9XoG+PzI1pRMQVV2Q1WI1ichld2fRK5AqIGWjPjDIEp2D2xGFnT101?=
 =?us-ascii?Q?1QTscydMTTcRv69bwT75gYEmlAeF1pX4CgOubJoGHbjA+iEveAjZ6o0M9zzJ?=
 =?us-ascii?Q?Zw2A0X1PYHNCk1qz4tOu/qZul2iHzAaXuJ7VkrcjzrEWm3Bu0yB2iJh5kHGs?=
 =?us-ascii?Q?RqE2xGhG5+0+ff+rcTICCu30jbbG8+CyBGoS9A327mFZtnaBinXuqVnW1T9P?=
 =?us-ascii?Q?UUviIyWt3T2GjkTm5b30y/CP/Yyv62T+2TyKwfpEHgbpiyb80PzceR5D7ydW?=
 =?us-ascii?Q?zK/gPug/uEhx5gyP+63Jysjd9cgoj083HJR3XhsFtuP4ni4ChbQS/hN62XkT?=
 =?us-ascii?Q?HvjxkY13WqGDOY5wd7zstQWFsbHumbdWtzRB1uNBKFWRvl1vh+oskgYTsO/c?=
 =?us-ascii?Q?0WWXeHXJrJVhMjzTji2jlapbwcwdTdqPGLfJQofCzBNa+1HR5F8Ny7q5vIYj?=
 =?us-ascii?Q?lPyyUklyQrbpIONULgavcdI/lR79MuFj2XBhcL5umt3Tc8BjsMU8lTwNCJ1p?=
 =?us-ascii?Q?kZ+pEqrdTZ2SMFlo0F5Sjv1sUalgK3ZqgvOfeZB2QtqSW/4kt/UGLrOrKHjM?=
 =?us-ascii?Q?BYLIug6YploID44ljq2mkTMD/Fb3pRAXtlICoPoQBig6fsQJ4QwVB2/mWP9D?=
 =?us-ascii?Q?a8qRG1l1VyJvjcCjPdSZRBePGTAsyb582aI6mkRNbArXlio0EuyLNATCSC9X?=
 =?us-ascii?Q?yGoEUPZ0/HtGvQi+9bk+qZUonzF1NRlP2cFYGbMQJR1YEoWLB0aPuIg1CPih?=
 =?us-ascii?Q?aDMP0FbMxYvYVTfQ7DledYyRvsTUu1bna4Crc8fiDvQ83ZT6nvb9cVckK7Xd?=
 =?us-ascii?Q?udJNHCtuXM2X3yekd7QXgc9LgcWTHqkz0yw60rB3ElZvwka/cFJS85PZwtSS?=
 =?us-ascii?Q?6Yoj0FYxJ4aUc7Upuw/C?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c00157c3-1fb7-4bdc-a254-08dc8e7eb788
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 03:36:47.8199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR20MB6366

On Sun, Jun 16, 2024 at 11:58:29PM GMT, Yixun Lan wrote:
> Hi
> 
> On 18:47 Wed 12 Jun     , Inochi Amaoto wrote:
> > On Wed, Jun 12, 2024 at 10:02:31AM GMT, Thomas Bonnefille wrote:
> > > Remove SDHCI compatible for CV1800b from common dtsi file to put it in
> > > the specific dtsi file of the CV1800b.
> > > This commits aims at following the same guidelines as in the other nodes
> > > of the CV18XX family.
> is there any URL of guideline? or did I miss anything
> couldn't find any discussion about this in v1
> 

No, it seems like that this is a new change from Thomas.

> > > 
> > > Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> > > ---
> > >  arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 4 ++++
> > >  arch/riscv/boot/dts/sophgo/cv18xx.dtsi  | 1 -
> > >  2 files changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > > index ec9530972ae2..b9cd51457b4c 100644
> > > --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > > +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > > @@ -25,3 +25,7 @@ &clint {
> > >  &clk {
> > >  	compatible = "sophgo,cv1800-clk";
> > >  };
> > > +
> > > +&sdhci0 {
> > > +	compatible = "sophgo,cv1800b-dwcmshc";
> > > +};
> > > diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> > > index 891932ae470f..7247c7c3013c 100644
> > > --- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> > > +++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> > > @@ -288,7 +288,6 @@ uart4: serial@41c0000 {
> > >  		};
> > >  
> > >  		sdhci0: mmc@4310000 {
> > > -			compatible = "sophgo,cv1800b-dwcmshc";
> > >  			reg = <0x4310000 0x1000>;
> > >  			interrupts = <36 IRQ_TYPE_LEVEL_HIGH>;
> > >  			clocks = <&clk CLK_AXI4_SD0>,
> > > 
> > > -- 
> > > 2.45.2
> > > 
> > 
> > Hi, Jisheng,
> > 
> > Is this change necessary? IIRC, the sdhci is the same across 
> > the whole series.
> I tend to agree with Inochi here, if it's same across all SoC, then no bother to
> split, it will cause more trouble to maintain..
> 
> > 
> > Regards,
> > Inochi
> 
> -- 
> Yixun Lan (dlan)
> Gentoo Linux Developer
> GPG Key ID AABEFD55

