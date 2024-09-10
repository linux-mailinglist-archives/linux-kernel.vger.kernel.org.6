Return-Path: <linux-kernel+bounces-323948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4F19745F6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 00:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CBF91F270E4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 22:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208D21ABEDA;
	Tue, 10 Sep 2024 22:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rziymZl5"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2020.outbound.protection.outlook.com [40.92.46.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19F51A3BAF;
	Tue, 10 Sep 2024 22:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.46.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726007232; cv=fail; b=nDq9wWHf24HueExt/pHP0blK5IB3SYvvKHajC9VMFXsqNS1r+IPzHb8W1om6iiKsZ4MNKghD6GS3f6PhakDlg8HxJI8cCOjxibuoibaWHoHEN0V/RPou1eGI79TSqiz9IdYiukKIx2sJ3XugqyAqhMXnkVnDbGDZnfQVBlrX1ZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726007232; c=relaxed/simple;
	bh=jV08mHRhECHFNpOT/v0mRg6SQ6fvdI2T3Z8l4iIwKcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qjm5IbrkCM0cbCb49+WadaX81f4jmZQfXg5ULvsD/ueRSdqUJDrsmeFWbVEoYOW1si6AQabamrl6HYnufkvTx5wI5DohiVEavcUCHxijB92X7vsVWQtobIiUQL7pyDoYqMGuRchQW6KjTdN0al6hyMjODPbBYJ1CTxb1xvljheQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rziymZl5; arc=fail smtp.client-ip=40.92.46.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMYKLLhGlPPW8CDNzW7i3blQuqdL0uD3s49i8wUyuqHMnkRIJCmx15sX0BVtb04qLwaCHxIngT/bB4WBWTCmk9FMsGT5om40nkEKIm5Vvn3oQW0Rp4J1c3k/Z24vEI+Ap+IXqGDy4hQGmRWBD2iWayJRc6+B1hzs7B7F2C6WGRQF+m88lpkyIpE+XxaQPYm/duTCp0UgovciWdoamPlGcAN6tmk7Nkp1swsInzGxS3ax2mw3ymF4Gh5N2lAbEfEBxHvbT8wGqexR+h/5ztTp8i0uPTBb484OePWCpoyeuI1tnWr1axlkQOZ66g+SBJl2ojjbssmh8sC7PehubGBZ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSFRnQhZP4g7kdAk6rJhyseq4OmtnlenShNmkN4qjjU=;
 b=uP7wgORNKT5oT6QE2ax/U93c33pJl3i55WtUbNIbB0UW5svevZvuLnev3fo/peGNiXadgcRZ77QYL2rXmRi+HzrrbUmasELaCG/Q5xg9oRA0UDbc2IzoD7kZt0dJPgH45hvupl8KD4mQR2ADyucwJDI6Ilkr+Dwoku34TNvO6sjtdhoLnppEAAi9qKNHQEfnKkoHEZMxnRxkh4JMaS+IUyQSCjc68WAlatKFvPnQ+6/zSPQZg2On6SdoORGI3Zgj/0uAXe/rFOvIca+xg4G6Nru4MUE8+atgRj21MPmsZxyAiIbMjcTgx+OF7WgWDLz6lRq9MOq+VOw9bWEv6cKULQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSFRnQhZP4g7kdAk6rJhyseq4OmtnlenShNmkN4qjjU=;
 b=rziymZl5BegSCNUOr/06dw8WP1UlKuZdVpOlsxvIReFo28PxX0wZqgICBqzFiNTYk3ZhkMeMXZOCvorA3stP7+/XMKyulMc+z+W7a3+sSmGzxkqOw0ze7CBsiJG4jkm/+rd2P4FpbZltkZvp+rWE+wuh+a+2EnKMIdz0N1J9I+UDT9/rlKioQhFJ36JOpmxV9xj71/CuoQutO8C7szAtA7LUODgz7iWFRAhqfJfXVuL1MIkWsCXzTcW0axSeUFx1RintlNF7VVUA+HTcEtjlHeQ0vbjo24c+J6fFcbPEw/4xIZ2NK7GD8Xm1qV1DcqMjalq9fpccojD+4xyBSdec2Q==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MW4PR20MB5297.namprd20.prod.outlook.com (2603:10b6:303:20c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 10 Sep
 2024 22:27:07 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7939.017; Tue, 10 Sep 2024
 22:27:07 +0000
Date: Wed, 11 Sep 2024 06:25:49 +0800
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
 <IA1PR20MB495316205F5AC588867FA8E1BB9A2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB495374DB8C4208575AAC9675BB972@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240909-prowler-renewal-0592d820ccca@spud>
 <IA1PR20MB4953A0D6A2B73D03BF162671BB992@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240910-bust-mulled-e45f6f6ef29d@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910-bust-mulled-e45f6f6ef29d@spud>
X-TMN: [AWn+tYGNRNo8yQKl6YinOeuDG2TiVcdinU9FABZh8SE=]
X-ClientProxiedBy: PS2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::15) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <jcalupqrlblzwyiewq7ldtcvo3ok6bpy7jcrnotg62c2y4v54w@2sk72fe6jgn4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MW4PR20MB5297:EE_
X-MS-Office365-Filtering-Correlation-Id: b06810d0-30da-498b-6494-08dcd1e7b3f4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|5072599009|15080799006|19110799003|461199028|6090799003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	NVCWJAB1KVD3dmTmm5cY4yuSAZwaEi1RFanI7fgN3V5CgoEnAuUypFxpgCgAJFK7h84S6FFiXSRsfCy2wOtNgXXoqkfFXneKcxiR1nX1wtDsxUWBjxq7rR0BD8BRhmpdYom2Dgjq2cIIomVrKhoDkHdBiFM6KeVxwwu3yjcVPm+ZJBCR+O/BiiMyhPC5vyL+6wAk/umTVlRWKOKurv7wH2HMlZ+PhlbMaAqlUYKJw6MAe5Cpue2gE8PZuA8ezq9HeAOI4En0a9mimLAb2UuxzNltr26vPajU3XlLzWVvf0kXxvJ2xXwI1ZCGr0PTwzwQlDbMqlzP2lPHySJS+n3uCET72xaeNHqUDiFlzbjbI3CFIwj0rDIrQTZkUtCrNHKuyIBCpGQg45HbH7rqAW4k5PdXGAI+Nhi4ZD3p2SclXtJkwwnohiiREXZHBX5qqv+7d/MmFQw0JWfOVJ9gkOq4b4SjOhZ+zdLHo/nhc6rNv+ebGFf+RGNqy0fnmIRQ2Ln/2c7DK4uEuqlRYIYFSTqv3tM2Xx0DIO2gHCuzrIC3e4Bttu6EG5mf587Jde0P3XvSsgDLjTFbBBDbYCg9ONocHoI6TKK2QC94tIUG1ubXh9yUhNQqqkRyXiwxjYvpyvFjgnXIrWwh4juqIv9u8TWmGeJ1L5qgLmLu1TMTBkmFKzmMeu6mZcXCnuczyjZEJMaNikbc2rsIA8Q5hyWOcTKD+setF6o2m3/aMTWVQls9vkia+qBA927zRGNbtB3IGyevdjlgCwXmbab+wPhytebWxg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+6+1S0K+lE6ZVIom9RWSK4xvs+PrgVhMQ8Q3MHc32aT9gdE/wFpq8+WRBV1A?=
 =?us-ascii?Q?WRGgRcF2j41q0O65edqNiJga4pSGC2N3M3eSt7/JbiV7L6lFrSqJqxmeyoZd?=
 =?us-ascii?Q?JVtpQbbL7+oeF4ICQfLgqjpYVfWgYM7RN0/7htzsCMRDRZhVHGmYLB3QEstK?=
 =?us-ascii?Q?2bGDJsHSQXplQnVBJwzRwkfWewow6YLhLGOWhbZstHqO6p/C0N95PVk1J4y6?=
 =?us-ascii?Q?8vHojbY+IikDGUpPDa9P3qb0Jk3eMLMA540EUvBKyU9y3SdjRR5DWhuqD194?=
 =?us-ascii?Q?uCFe/6B7HJDpF/DsfOjxVLJPFxkQM2pfdUr79nEk7haNUMl40+lhT1kiK4Ou?=
 =?us-ascii?Q?spQgg18eNifK6TG0wTrKhw+2xiDJdTQjra5gdJeeVFu5+d+/LPbGpqG6Xnxo?=
 =?us-ascii?Q?X6Qr57120woBhH2w4kA79JZoyEyqRZB5M0q8bMBpmaKzYrjWUIMDrypUqFzV?=
 =?us-ascii?Q?5rWMzKDFZlFmWd0b0yOAbkuneQHJBxk3PU+tVXVvgyDJuEh6VJjZcT8y4xqP?=
 =?us-ascii?Q?twFEO4zJoGkKfIvs6FqqbcvfuJv1g9IEorsPlgAaxkkDMaa12u2ra4vg+7iy?=
 =?us-ascii?Q?oaw2pMlYMz8t007DltDF+uU+mISYbI0bfUwTIBJtHcEdQE7xK8B5mYH60I+y?=
 =?us-ascii?Q?m/Q0sdYLccGL8BFsRhTymLofZwFOotb81QtpxL1o5nbJeC+lupBxMbQTaVBW?=
 =?us-ascii?Q?DmkeQWnZP9KKoEvNgigBvj82IWYnidPLho33gSLD3sCmiccOSCUBQQ5USYUf?=
 =?us-ascii?Q?Vl5hyeSs+8ZXbSQHnFE1rhboZ6+U0TdXTCBFDbZE3TybDRrHKrD2C7/R7Gsd?=
 =?us-ascii?Q?27A0UySSaUhfupYE8xNNxuzRNyG4synhgKuJ1UKvvNEEXAkUgFc0d/keWYAV?=
 =?us-ascii?Q?YGUh62hB5MSek/+Lt2PNtBto92QUN6uoyu728cHBVLai3zXLAxbX0U8/euqO?=
 =?us-ascii?Q?9TGSvHOMiKee7976pvcoDogpuqBUL3e+Uu+wLkQuYM/9ke+uOGe98vbrcOzg?=
 =?us-ascii?Q?g7d6IxOFP70T6C/DI/U6iwmr2UFyhDXBpXTgXkVab3/yEn2Z5TulxZIW9p0b?=
 =?us-ascii?Q?+uv5nCm7R2Mll1Uz+NUoUcDSsgcNwipblIAyMM8HcHkP+OoMrZRuFPQGJjLX?=
 =?us-ascii?Q?LbgAR7S7F+QDb7L1zKsixAOJyEvnSsQpgqfkOobpkSgUXdKjQla/RGuu7USk?=
 =?us-ascii?Q?qMIJUdgEQKQPNtdcxlRz21mx8xT6RuSzk5toFjyKtTUZZcHnxS1QZ8zGqZK3?=
 =?us-ascii?Q?nqRuyRJRVzB064VbPKMv?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b06810d0-30da-498b-6494-08dcd1e7b3f4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 22:27:06.8693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR20MB5297

On Tue, Sep 10, 2024 at 05:13:43PM GMT, Conor Dooley wrote:
> On Tue, Sep 10, 2024 at 06:24:34AM +0800, Inochi Amaoto wrote:
> > On Mon, Sep 09, 2024 at 03:41:10PM GMT, Conor Dooley wrote:
> > > On Sat, Aug 31, 2024 at 06:38:40AM +0800, Inochi Amaoto wrote:
> > > > Add basic pinctrl driver for Sophgo CV1800 series SoCs.
> > > > This patch series aims to replace the previous patch from Jisheng [1].
> > > > Since the pinctrl of cv1800 has nested mux and its pin definination
> > > > is discrete, it is not suitable to use "pinctrl-single" to cover the
> > > > pinctrl device.
> > > > 
> > > > This patch require another patch [2] that provides standard attribute
> > > > "input-schmitt-microvolt"
> > > > 
> > > > The v4 version is from [3]
> > > 
> > > Which version of this ended up in linux-next? I see a link to v4 in
> > > what's been applied, but this v5 was sent before that code was
> > > committed.
> > > 
> > > Either way, what's been applied and what's here produce warnings:
> > > cv1812h.dtsi:19.28-24.5: Warning (simple_bus_reg): /soc/pinctrl@3008000: simple-bus unit address format error, expected "3001000"
> > > cv1800b.dtsi:18.28-23.5: Warning (simple_bus_reg): /soc/pinctrl@3008000: simple-bus unit address format error, expected "3001000"
> > > 
> > > It's just a copy-paste error I would imagine, but please send a fix.
> > 
> > Yes, it is like some copy-paste error, I will fix it.
> 
> I'd rather you had sent some follow-up patches, than rebase your tree at
> this point in the cycle. I assume you hadn't yet sent that stuff in a PR
> to Arnd?
> 
> Cheers,
> Conor.

Yes, the pinctrl dts needs binding header, which is taken by Linus.
So we hadn't sent them. This is why I sent a new version to fix this.

Thanks,
Inochi
 

