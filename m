Return-Path: <linux-kernel+bounces-251999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE5A930CDA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 04:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 431531C20925
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 02:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05048BA4D;
	Mon, 15 Jul 2024 02:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="aDL5FTnb"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2049.outbound.protection.outlook.com [40.92.41.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282385234;
	Mon, 15 Jul 2024 02:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721012023; cv=fail; b=Hj039DaRJfw0raXKrrWJozVWTsTjUHYGOxvw9chx3U9723UTLDtCxNzFtSDqWIqbwi94iMVaP5VFXewwkNoXBYOpmh7AkaEYyj9ABlUX5ug40wseN7DccyoFA/Ke1Y4FBCztXQfzPvkHjtW9hDydRu6kqvqoxhGJXset5Zd1N7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721012023; c=relaxed/simple;
	bh=ZxYTT6pkk0UTMLKEiAXaa77DHMWi5mZmE8c1hQOgOT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WU6Fnh0MRh6sRSQCZQ8RWV9JClIdyFlDRVEVeYsXnV92pyDyt+9rIWWirhfkFhdBzVs82/mBE+a4g1to820wTm4NPA3GAITaFRKkk2S2dn+3ueGJjIJPNTeD5ugWDX1gxLmtEOI1oi/fgGZgqNQOmIKZNJVkRbRP1cXQEi0W9o0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=aDL5FTnb; arc=fail smtp.client-ip=40.92.41.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ckSALFit7FRIxdw+z6V1ueNgmKrh/U1j7NpJ6GVJQxldkEG/S9FcZObQET5WCoTpfoQx7n1Ur+Wpl+n+eml4Xh8OHAyeY/DRZZe9p/vf1kARPP4+mpAfkWZ0CBOmdlUMoKRnTJjTfnl7XkVNyD66CdqnsjkRtW28DJzktT9QRAtFqj7NCJBAOngGWAFCIFxP1s1Lcq/y5Wt6WhwJ8dhdNHwzIPbRQcYpXdf+uq3aDKYYFN6X513dR1Uua2xenx/frqAuMOWjP5XoPBO9DDcmxIBlKcOvGG5D2YzE4zuY1ddGIvtVPYPUAhehVwEEMcziYwl9QqgsN1vve0Ga8sLCrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voGH9Q93LnT6wC3l/YJUvLhD2BkD43YgE1EttNhZzt4=;
 b=OuRe8xVhwgtsF08Z1R2AAJAhzZeeTNa0APrJ1EHDvY/HB17iSyM+dQdJyinpLIe/W+Bm/Q6YiGxkEoWK/4KnPPX3787poNjOzEwxmvjkNQ4iEtaRgtUNI8JU55SnC/4J7Gjj6rivknkaLUocUklKQGibkpzWfyTMOkruY8SwEZLATULc3ERka6RB3+osOHoK1FmL8uVkuKQ8ivrW0kbbto7vskNRntF18Xl6WFHmOQjufNhqOja8ZhawhZq00b3Z0oa3g5biJ+K1gZY5ba3ss2o48chrFtX7LHzjd26OBJihCtZrgVzrQud4yMrn+AVlnrekJqfFqRomXIjNVtN7/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voGH9Q93LnT6wC3l/YJUvLhD2BkD43YgE1EttNhZzt4=;
 b=aDL5FTnbgosxYzqSCuNqfIDs6CBas+Slhe6ALCGKyzmky9QVwzv3KyEv/ZMQFOPdDPuAfbe44PFQXzner4bri5QPu0dSRkXWiZMFvb++sVwOwwSIBPG4C/ZDZd8D87Etg4rckZprTIHkfPXRqix+PjSnvyAcTyKi+e1a+SGAFMteaxMOSNhPFdAhSXaOkOTVH9hWbJVeCDx+PoK7u+yQqYZH9RO2I34Zqx463+T05ycaFW51b4r7PivGl3B+fFhsAE2R0xlMxtuAFwhaQ6Nym8F1uK0I/yAsGzUG2rjCTPuq8dDUrJvYvZOgzgZMBgCvgtsyCJDvd6SrKNR6J2Wglw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by BY1PR20MB7331.namprd20.prod.outlook.com (2603:10b6:a03:4aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Mon, 15 Jul
 2024 02:53:38 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%6]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 02:53:38 +0000
Date: Mon, 15 Jul 2024 10:53:29 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Yuntao Dai <d1581209858@live.com>, jassisinghbrar@gmail.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	unicorn_wang@outlook.com, inochiama@outlook.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/3]  riscv: dts: add mailbox for Sophgo cv18x SoCs
Message-ID:
 <IA1PR20MB4953A004BE0E8A08DA19F3D5BBA12@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <SYBP282MB223825D5903777B937A8A377C4A02@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
 <SYBP282MB2238CE3A016F21B632E61219C4A02@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SYBP282MB2238CE3A016F21B632E61219C4A02@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
X-TMN: [pqc0rj24XLurjgaDBj/2JRFEWmm7i0otZw9NNyBemKo=]
X-ClientProxiedBy: TYCP286CA0204.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::8) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <lz2njdjvrr6nlwzdxknljkeokpz63czb4yg2db4jw3j3d3v5dn@wyamwlq6txy5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|BY1PR20MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: 314936db-3d22-499d-e70e-08dca47953bc
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|19110799003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	gv3+InkOPpsOwHAOIOH2iisvDIjacfMwNGutMR4puBMVQ1uYPOWxbVG99x4c/r4s1qfQlEZbi9NJ42bYh5coqUMUVYrrJP8FXR1Od0j2U/OfLOEWYpjR3RX1782sRK+SRM6DGFbmGvKCniJ12yep1HMBmkeNAZm0MnMzTOB//9C5TeSE21BU67kYnOQzJABimrs/KQrsJ5Qln+78Tq7oFmsTjxV3K1kkbZmQxThrZHKS/mPJQLMw70pUKBJpuzA2JTLCSI0z7PVkPhhs+Vqe/dAw+Ji+cLXQyD+AufutcpTQ+gtrXrkMXPFZkV99zuXjKunwFsWdn2aWhsG+oLuYcvG6iLqfyyILim7JyqYMNs1yxXLZDyh8xfdpjQrBXyezLx+59sYsJHscYZ9z3H7s+jFgfpktx6ebqmgOhDAGlSYCSAoyKHy7bFa/p21Fhniftt6HEtUahnILijhVc9kjiqudGltoDOF2RD1VFLkLYted0CdqRnIi1oL7KwJ6h+Np2MEqEGEDWt28M01KXXYTpOcAc8HCK/dvpAV22UKZXR1a3eUpeHxyAKl19t8uInjs6+uVBQ/HjLc2n52Ps9tC3QzXX1Hkj9Q9p0xYcSVeymSwwnSvKhvungDGpbla0tOoW31B6IxI98Py/poqu6LgRHzNcke9qnp5muJRU95MtCU3HnmhkiKbYDk/zKLjRi48
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MFywK72yOjBUwQcBjfvP0MGSWDW2PKK6dUkr5Xy0DNtxj8rWtLvG7Dqegp//?=
 =?us-ascii?Q?7HLj26MBpIJaaGlGA4gZ/eIPBh5+6SRHSBOnwDzMQWhLxBoalRTvsRw3T/9l?=
 =?us-ascii?Q?whoF9372VDAYknBJGsYkbH1NdE/gDVWrNG85yNbgUaHi+Axqm0am+dLctCdv?=
 =?us-ascii?Q?6Ar4RHSGeIWSqnux8CWUgG/6PlmCTHqg3ezJ2K6GGqpwD2BZ3JAbbhEtMOWs?=
 =?us-ascii?Q?l8AwNJYZUjzBk40Lqp7hwZK3rKaECzvW9d9qnvGv0qVHASyZR0V5rW//gPI+?=
 =?us-ascii?Q?dnUPDoSGnNkJidvbkBZVioUI6nL5VaPMINaZvUDTke5eboPdMAFbLwGWO7EN?=
 =?us-ascii?Q?XypxLh9UQ5N3zqbx8qnDgI4iCDKsADB965sTApaHhDgfLOd00HHdoDjb4R5W?=
 =?us-ascii?Q?uyomsH00y2KiD793xB/tFwdyK9L7iyZWDyjrGk4M2PG9Uxlsvo12NNNQpI3r?=
 =?us-ascii?Q?Na05+nTIQXmpStej02Ydps51a2eQ8DoTNucfxSJ1thct2iahrkEtGcVG/UBG?=
 =?us-ascii?Q?e8euSJD0cJRVMPAnt3/op2hPDIqe3rnYSgfCv/r3ZsTQRmzpOBTq3QCbjt7X?=
 =?us-ascii?Q?qZGHbFpy0Anz/v3OUCbiCDvBO1wa6DJiHTyvAWPUf+Jiqc8mWrtvTnlTq+5L?=
 =?us-ascii?Q?hg26c6XG7gX71fEBTtKAiiCCxi0QE8qclz24skENJMPnUAnQu/q1IILV9xFX?=
 =?us-ascii?Q?GtY0ExCm9/Lo7I4HBckT6rEJJ3pfodXEU4jL/k0JCYLNLlIU90SO73SKpHVB?=
 =?us-ascii?Q?mnT6PweK/82B8AzzKKjp8SRk6tkMKN96E5kgMalgp0Rzvxesxokv/4rSmKlM?=
 =?us-ascii?Q?/PwTDTw9aLbmVz5xlPHcyC9SSZP3upOPwWYTgVRj5Llu+XNxxH7h6CG72J/p?=
 =?us-ascii?Q?/V8hzJCI+XhkWimx4dyoebzLT+8KSu+jyePwuLRyhJdL4HBHVBbqOw7snTBN?=
 =?us-ascii?Q?vuzFy293RKLzHIVv2ou023ofN8tFpzYLWYmnrZmTslH9PiYXWBasSr4/XVV+?=
 =?us-ascii?Q?wNADvW9Me9ecDy3KATmn8CS05uuC7v/C7T2W5l2nEi8bflf6cO8i0B0daKQv?=
 =?us-ascii?Q?eW6WtTiRJRhVH6/8hwoGEW6/HOtJ3L9VGVA02uM/vyuljtxFKGl5fhHuy0fZ?=
 =?us-ascii?Q?wAtvLnlp15Fd5kQGmoeUHVwf61rBw0YL7WGwWqGnib/feiyQ2n6VuEc7NbLY?=
 =?us-ascii?Q?ajWhfWEK+BtaIhOt0wjGIlM0BB2/NkugOaDSVRZb4MM6I/vBDwA9rLzZl260?=
 =?us-ascii?Q?LODmhKWm43GFhGBwD10X?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 314936db-3d22-499d-e70e-08dca47953bc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 02:53:38.4485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR20MB7331

On Mon, Jul 15, 2024 at 12:36:46AM GMT, Yuntao Dai wrote:
> Add mailbox node for Sophgo cv18x SoCs
> 
> Signed-off-by: Yuntao Dai <d1581209858@live.com>
> ---
>  arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> index 891932ae4..1c7035737 100644
> --- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> @@ -310,5 +310,14 @@
>  			reg = <0x74000000 0x10000>;
>  			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
>  		};
> +
> +		mailbox: mailbox@1900000 {
> +			compatible = "sophgo,cv1800-mailbox";
> +			reg = <0x01900000 0x1000>;
> +			interrupts = <101 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "mailbox";

> +			interrupt-parent = <&plic>;

interrupt-parent is not needed, which is already set globally.

> +			#mbox-cells = <2>;
> +		};
>  	};
>  };
> -- 
> 2.17.1
> 

