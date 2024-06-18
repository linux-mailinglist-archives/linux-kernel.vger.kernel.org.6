Return-Path: <linux-kernel+bounces-218681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F04190C3AF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 08:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87AE4B2153B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 06:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C914DA08;
	Tue, 18 Jun 2024 06:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gDj3iDqM"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2016.outbound.protection.outlook.com [40.92.22.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D927288BD;
	Tue, 18 Jun 2024 06:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718692612; cv=fail; b=OMbuSiFg87/acMV/OemK7jZVdJNGXZY0y9ikpzTkCmBe0GMF7C0aEWQH8VAZ94DEwpOnyNzQQOKeul3c5/jsxNZP3N4NtflTvkjc5osggw3s6iW7JUkcrj4ct8oGxOFaVtE8/wo53BTq5a7ILBE5DrCZKjzjpIolNrl6yso+0V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718692612; c=relaxed/simple;
	bh=GMXNDCl2fnC1wUZFGCemtINPac1t/jIFBouhwDye3LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q+Fl/BGAmBUuqTwdxnrX+mOzyw3fgYem5gWCXof3XwArW2hsNloBVqu/02/KrBzbmhwf6hjd93zs7h2LWpCDNMLBoor9zn5YjFac4lAJs98dC7Jye2LFTs9CsKmk2BuMYfRy77k1TAQmFwlQG/x7ZRZaUzM0yQHXss4FOwpib6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gDj3iDqM; arc=fail smtp.client-ip=40.92.22.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIB5eAxeqPKXpV5NoiMiRBmrDApZzJQ1oBdCwUmVTfTh9gxJibaPjlV5Zf/t9xuCH0NIaThIyo5vxMlArRmOPzM/4igSdzim/p4ehBVQcERz1AbPddK2XKenMzbdonSLLN/c8POTWSeThnIpH0jHX/fxn7383QKd4pUJESo6LWRrTLg0c4W/Yd1WCAK9x1bxcqiu5Gg+f/IEIn1ReiOwr9wY0pHQtxCZQ5qqJY8IYxYJk0SiiY3pMdae9dEABncseC8A5H/teFlSJvWj65LCdRXN8Mg4w/hV5t1ZM0RNqgMWbdkr2MouS84TiMA9+MYb5ccYWFRHS7TT2KBEjc1XeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkU90nQc6HucD2odw/Ijiop1X7T1oUi7sRcoPmEOKHc=;
 b=Xvwq81AgLxvZMz7lMrTvikrhpxLCzw81RfnNBOsrRRMR/9ORZNBSijZeIwLny3M/gC5lce7NJaDYHP5J8KTKhVO6FVTUfa5yDlhSAhXxZeK09EMhGFwHYSqKz476nSTK/wDVmusrKznbRhJZWStCo3bPlRd1qu3A8CuoZoaIYZU/uIAo+JP6Z83/Fv8+DpG5qOhZ/gv0RcrL7Wnc7OZ9/hCfwMh9E2dJNbaXrd0O0NCt3Pu5PN/2lEiFGAWS4vGFxhgMH1DdUy4fQS2J2Dcr3yqi3thvphf04+uQPddF7lVBzgBrsF6buF+yRdlfunct6MjkB5DLBpON2PYcBOSWeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkU90nQc6HucD2odw/Ijiop1X7T1oUi7sRcoPmEOKHc=;
 b=gDj3iDqMagdaQHHYYE5tWa/GxYXYWJWrRUx2GDMyu4RJCGBRtGLyjaxDHBYhz6YweMfAikxFBySmzkudZbDvRh7OjlruMezPSCMql3u2X3z5nhEGOq7/K079eXBLqCZbWh0Ugu606TUpkmF4DRuTM4tjpL7Imwl4Glj48g2F0joEBhoSZpLEhokKYhIIaw9XWi44AspLgQnJlg7VIr7GyQVXm2uTeN61uGFjo6OgtcFpDUttYinDt7+0U+4suUxffcxPn+VcDlOVj9tlSMHZQGzX6/xsECkKVNjAhRQKhD7SeWeTHTfnR1h426pVdVMFDXtn/whG+rca4YrrdN/BnA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SN7PR20MB5958.namprd20.prod.outlook.com (2603:10b6:806:34b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 06:36:48 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%6]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 06:36:48 +0000
Date: Tue, 18 Jun 2024 14:36:30 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Samuel Holland <samuel.holland@sifive.com>, 
	Jisheng Zhang <jszhang@kernel.org>, Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Yixun Lan <dlan@gentoo.org>, Inochi Amaoto <inochiama@outlook.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Chen Wang <unicorn_wang@outlook.com>, Chao Wei <chao.wei@sophgo.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH v2 1/6] riscv: dts: sophgo: Put sdhci compatible in dt of
 specific SoC
Message-ID:
 <IA1PR20MB495388209FC7DCFF78FDD545BBCE2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20240612-sg2002-v2-0-19a585af6846@bootlin.com>
 <20240612-sg2002-v2-1-19a585af6846@bootlin.com>
 <IA1PR20MB49534C9E29E86B478205E4B3BBC02@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240616235829.GA4000183@ofsar>
 <c75601a1-1389-400e-90b9-99c1e775a866@bootlin.com>
 <ZnA3O14HOiV1SBPV@xhacker>
 <20240617-exuberant-protegee-f7d414f0976d@spud>
 <6a993b58-3d9e-4f92-bf47-7692c9639314@sifive.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a993b58-3d9e-4f92-bf47-7692c9639314@sifive.com>
X-TMN: [GHCQjbzMTH8GUkDmGJ3CA1YZdmlbBT8P/cIv7+BYm9Q=]
X-ClientProxiedBy: OS3P301CA0043.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:604:21e::11) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <bbteyk6qqdlqboufd2rnzjktr33kmmgsjrf2auotgoxsqagzvz@ujbc7uydizp2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SN7PR20MB5958:EE_
X-MS-Office365-Filtering-Correlation-Id: 580b976a-ba1d-41f3-dab1-08dc8f610757
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|3412199022|440099025|1710799023;
X-Microsoft-Antispam-Message-Info:
	QMw0wekZwQ/i5RsdxRrDK3zmtZKJwSSut1b8JNWmZH501ETBExGG+/pd8CoEF2Xr6GzRH1WBdf+ldbxeTFFwQjpT+I7qZQbF7ryYvT8f/zyJTUeuFpGeLioDEMDnU4dnfC9/ziJak9iL9yh82BkXFeuirULaOgbW2HMm2ZVJuGvAaIMLzKcKq9m6dM5gad/mk+vWTBHu9Jmn9SG5TODWWfhQ+cBy90qTMlCj8ndtAUDWJ1cvtV0wP1JnObDcgXLfIwQedXzyThp4kYmMJLyAoPQ3Dy+LPo8dnUynu7rIMarn+50RBmUgV5ULvIz7+WD+AFFNrSj7iMInsSc1IEtan59HqpnEqz9qDWB4NzGBxH0qWZjYPfG721AWQBv8eLvNkjCdusKQNDJuwuL98YR8vBJkGjJiAWxvO9GKYU3kyGdKSya+T8DiCvzDnHPFRgMtQg3UEwnXZkJP9MzHLxN5yK+tU1KLU3/TcfdepHyW0Xe6wIv/HDWt4PQ6+mCS69wRZRqML6bqu4cuebFuH5Vi9JOjjYdk7ojvVncs7UI4Nl5jBfFZ76LIBLRJd/oASRMn6ScfOJcn9VysEoFAtRwOJBMC2RxG/pkssumLb34pPhPJahbVHIessPWAT6C2VLVb
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nID416C/N8BbZAhVZqMU0A1PinZapmzyEqvUsmKhE3PKR36omijIhzePurrG?=
 =?us-ascii?Q?RHBy6Oz8Gk5LAT/NxxlhIWyT+9/6CBHzO87MIKu9rhwpNIVeQPyFGVfhhtPV?=
 =?us-ascii?Q?WQQhYMILXeBUw43KPLV+DKjN/NoclRDXWOStLbhz4W460rxHs3pPy0r3knUW?=
 =?us-ascii?Q?OXRJlGFHmvq8TZBYzG0mzfhBpxJvmFVrAk1cdkfI/8XzOPqKvRfkT5AZ2BEG?=
 =?us-ascii?Q?PMB00Yjp3ABStpO7a3uIvQ62yJMatjosDzFnNCb64NDxhhBW1cTXgvjjbZ07?=
 =?us-ascii?Q?+5RmtlezcaUGMiBaOsM5Vo3pXb8zT7k33J5tecH/auwmiINhbkahDfwVy2b9?=
 =?us-ascii?Q?DEBbvwy+ZWSf2lm2vMNMpNVUIub2oXcLWAvb6xrr7+aaXqgqLc1JBLQM+TcY?=
 =?us-ascii?Q?yo98ruiozLs/tx2YrAFpLbb8PcMU7wkPge6tnlixziJfOBxil53ou4GW/WMK?=
 =?us-ascii?Q?ny804+e2OeDlJCly5rFsVc2N5r8O6CaAuhXgJsEvofgzexMrriAVRGFeI+l7?=
 =?us-ascii?Q?Ke+Mz5Ed+ooQpnM93d1kS9B6rWatucuPP6Fm3yoMKQSgQaitUtH+fNz6Bz4q?=
 =?us-ascii?Q?7oLTTWCUeCNiNgZpWrxdjpX+LK6EKkkwHHIQhVCsAOHItko0SgeRAo/9GzLq?=
 =?us-ascii?Q?Ncq7+3yVj5NZjh8mZoyB8aoFJ3lNEtkTUL+ZhOQeDK3RlyauZQVsyoV7PiwS?=
 =?us-ascii?Q?s8VBk5gTsNMFvWW8bsmhYO0d3x5Ox47h2iaWeV8GD/xLgK3dHuy8dWqDv5lu?=
 =?us-ascii?Q?thF+a+UOiLGxVi5+Edf8BL3JU4XZ3y/BfZQ6HDimUIRkhDsOG1CQT5f20Vnu?=
 =?us-ascii?Q?vQxR60FVvJUV8vognIHRk4IZ8kK5mh6T0nE4uS0nFdIt6WpklmZMIBXR+HAF?=
 =?us-ascii?Q?YQ6yYhA24GczGERBRfZiUbHlxdp/F4VbE42paYNl6FdXhlJSTjJjyRKV/Uiu?=
 =?us-ascii?Q?aerkPgKbtUFAEtB/0wcxZUst2UqYuuuPrbdtFwcM5nTNpWu3FA9KiF8hyqW8?=
 =?us-ascii?Q?nSaIyx7rJgJyFg5ddrGjyfrN7k+JzHSwC86NlQyGySkfjENDJRt7I+fD8GuM?=
 =?us-ascii?Q?NEOr0GGTxJ9Bx/XqrpP1EZrUAr5Ci/SCUgm8//npqhCodBIf31V/iEcX+HwO?=
 =?us-ascii?Q?pNKzsynNeIYTtHfC1R5vw+ilG6CQa/VJeoZNhrAxnmdZ2T31qN5wpij0mVy0?=
 =?us-ascii?Q?IQ/iU0girJEMfUpBzOhRVZJVhR7tjn5hbHxuCmKwwI/BCVEIIzy2R738qV1m?=
 =?us-ascii?Q?cSptFYHBpI0BCBXvadbN?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 580b976a-ba1d-41f3-dab1-08dc8f610757
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 06:36:47.9856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR20MB5958

On Mon, Jun 17, 2024 at 10:57:54AM GMT, Samuel Holland wrote:
> Hi Jisheng, Thomas,
> 
> On 2024-06-17 10:40 AM, Conor Dooley wrote:
> > On Mon, Jun 17, 2024 at 09:16:43PM +0800, Jisheng Zhang wrote:
> >> On Mon, Jun 17, 2024 at 11:16:32AM +0200, Thomas Bonnefille wrote:
> >>> On 6/17/24 1:58 AM, Yixun Lan wrote:
> >>>> On 18:47 Wed 12 Jun     , Inochi Amaoto wrote:
> > 
> >>>>> Is this change necessary? IIRC, the sdhci is the same across
> >>>>> the whole series.
> > 
> >> sorry for being late, I was busy in the past 2.5 month. Per my
> >> understanding, the sdhci in cv1800b is the same as the one in
> >> sg200x. Maybe I'm wrong, but this was my impression when I cooked
> >> the sdhci driver patch for these SoCs.
> >>
> >>>> I tend to agree with Inochi here, if it's same across all SoC, then no bother to
> >>>> split, it will cause more trouble to maintain..
> >>>>
> >>>
> >>> To be honest, I agree with this to, but as a specific compatible for the
> >>> SG2002 was created in commit 849e81817b9b, I thought that the best practice
> >>> was to use it.
> >>
> >> I'd like to take this chance to query DT maintainers: FWICT, in the past
> >> even if the PLIC is the same between SoCs, adding a new compatible for
> >> them seems a must. So when time goes on, the compatbile list would be
> >> longer and longer, is it really necessary? Can we just use the existing
> >> compatible string?
> >> DT maintainers may answered the query in the past, if so, sorry for
> >> querying again.
> > 
> > For new integrations of an IP, yes, new specific compatibles please. New
> > integrations may have different bugs etc, even if the IP itself is the
> > same. If there's different SoCs that are the same die, but with elements
> > fused off, then sure, use the same compatible.
> > 
> > I expect the list of compatibles in the binding to grow rather large, but
> > that is fine. No one SoC is going to do anything other than something like
> > compatible = "renesas,$soc-plic", "andestech,corecomplex-plic", "riscv,plic";
> > which I think is perfectly fine.
> 
> And you can do the same thing here for the SDHCI controller: if you think sg200x
> has the same controller (and integration! e.g. number of clocks/resets) as
> cv1800b, then you should keep sophgo,cv1800b-dwcmshc as a fallback compatible
> string. Then the driver doesn't need any changes until/unless you eventually
> find some reason they are not compatible.
> 
> It's better to have a SoC-specific compatible string in the DT and not need it,
> than find out later you need one and not have it. :)
> 
> Regards,
> Samuel
> 

This is excellect and reasonable. I will take your advice for the DT
change. With your suggetion, I think it may be acceptable to mark the
low-profile SoC as the default value and let other override it.

Let take the clk as the example:

// in the base file cv18xx.dtsi
clk: clock-controller@3002000 {
	// set the "sophgo,cv1800-clk" as the fallback.
	compatible = "sophgo,cv1800-clk";
	[...]
};

// in the cv1800b.dtsi
// now no need for the clk override since we have the compatible
// default.

// in the cv1812h.dtsi
// we still need this override as it is not compatible
&clk {
	compatible = "sophgo,cv1810-clk";
};

// in the sg2002.dtsi of the patch
// we need this override as it is also not compatible
&clk {
	compatible = "sophgo,sg2000-clk";
};

Do I understand correctly? Or we still need to duplicate these node
for SoCs with different profiles.

Regards,
Inochi

