Return-Path: <linux-kernel+bounces-244938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A98E92ABF2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 00:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EAC21C2207F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 22:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317D4152DF2;
	Mon,  8 Jul 2024 22:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cApNb++L"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02olkn2077.outbound.protection.outlook.com [40.92.44.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FDD39AFD;
	Mon,  8 Jul 2024 22:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.44.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720476981; cv=fail; b=U1f3ThjH1gFPxLWVqXqM59UcefG7HUDTR3l1pTx+WM3zM6I7r+Im8TNiK1UOtmm/fXTk3O1xxroyvouxlObziHXJEpqiJUwJhQ0xZ6bRyFgF1KNn6HACC2AZ163MHxYhUHgPUFmHvUtgs61VUEZZM1JZ8NoCw+Y6g2WUxEIlEZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720476981; c=relaxed/simple;
	bh=XauxVu0WABWxbCGod7D4FDvSFamnH5KE+1jB3nSV7Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uqNTK2EBGYnVkDXYNiVOc0wuJkNSF1QEr+/MczRlAAsY7hWQUONNXOCf1QU0sfsc6pXZb0mhIL0X9mJItmylBJ60DOFhQEwBb9aJHeO/2nhNDXMcOGMDZXNnf6N2wlq3MM840ba8AcjL2IM5rEYquzR8sNbda/Dg3GnR2z5vqNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cApNb++L; arc=fail smtp.client-ip=40.92.44.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgPC09x7e4KNsI7/0EcNs2sV0A7HT7lGaFaMFZ79u2rE2sJpKBvjqR8BZSTDczRGkGQSmNYpAK4i8kMDVgVED6++taGTPbPRVqjFjNFxy/L/qfUbO88w0omlhE8Hpr1L0khEAYkNj107j1t0BIBySwKsXxtbQpyKey+M/44iN3ZFD+hkqeYdFwPczKjFftY94cLN/UvC/Vpf/rlwmOBy4Wh8JbuYXh0P0dvou995iI3mgl1einhXqcRslVfAxVFoHKbGsFu76f77hiqu+US8uXuaxH2tHvbvfQWsR/nKntt9Jh51z+O2BYUJgybbBbcDyGh2Z3+7IA+yoxP4xF9a9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XO9fUZO6x0zYtoWSkXRVi3VFwWwomR8OJn0q9N0TmJk=;
 b=WCChUqqGPavV9QSRg/1gY5vYzbP3SApv0QpFbIPlzE6Z3XAdnMSB1Ih7JaFrzAErXkXn6zSgoizu+Lz2P/NnlwxoocxJytloZEVxL/d2a64fbWZoTi+l3Iy+G7+RLmR2qqZdlppZWjtLAZZgU8NG8ffUnjczDn/HO855NIbEZeMWxqxLvc3SZlH7l/lhtsYmW9GNT92SUDCxxjIspvZxDLVXUtDYPdOmwVRE+Co96NwNSMvioIX89gJ5sRVqazP0y9UMzui7/0uMJxRoJyqU1VEXqUB3DEOhIsYN7LAKuKVyjK3esnH9RCSKeRfTcm3na/BwAwpoP/jxi6LM7KZaXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XO9fUZO6x0zYtoWSkXRVi3VFwWwomR8OJn0q9N0TmJk=;
 b=cApNb++LEzn14LbXnArf3GGag7ArD/MHKrqOTe+3cfF/3AEKn6omSwkIKGjBmA4Xc3MLKurXDe+wI/FXkS6RqCfbF/cw3B3QZ91fm68ZxYJjKxF76wZP4f1Rxu1PLJjgE2LLXlA46aO+n1QGWo0oNWDRROXpPHxQQrpt3KwAmCG2Y/a5apcQjJSQ6429lLJa1qIadPi/ZQJQ+d0FKApXIUKcMACEqeOwJuUDKAYBTcYI8OzZOCsaYr+in6iyniiwOBwQgnAvpRjeEHChf6ZdsSgVv/99xNYiTB7vJDITgi5ZdXLhmGjWOZ6Be4d5K5KLSy4UGiCeKe4lAYrQbgpufQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SN7PR20MB6035.namprd20.prod.outlook.com (2603:10b6:806:358::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Mon, 8 Jul
 2024 22:16:17 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 22:16:17 +0000
Date: Tue, 9 Jul 2024 06:15:39 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Jean Delvare <jdelvare@suse.com>, 
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 2/2] drivers: hwmon: sophgo: Add SG2042 external
 hardware monitor support
Message-ID:
 <IA1PR20MB495309AA07F1B77D4DA1EF6BBBDA2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953967EA6AF3A6EFAE6AB10BBDD2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953EC4C486B8D4B186BB848BBDD2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <MA0P287MB2822935DEA9EE418F3411CFAFEDA2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <IA1PR20MB4953230DCEDD7DF01134A8A9BBDA2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <MA0P287MB2822676C9CF9443B9A3CB657FEDA2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MA0P287MB2822676C9CF9443B9A3CB657FEDA2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
X-TMN: [QSFSlv4DpVhTXGSbGCBHt/Thw7nSUOUjQejCPGo3v/o=]
X-ClientProxiedBy: PS2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::36) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <umzw6ckzltd4gbznxnfpubbz7gsgiu3ivgkllv2q5mrnya5pfp@mma4vhbz2q6e>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SN7PR20MB6035:EE_
X-MS-Office365-Filtering-Correlation-Id: a4bfce0c-cd05-4929-f1d6-08dc9f9b9630
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|461199028|8060799006|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	x+4bBCKMsWd5/HKAtARHeCxDI79f+ttcW6PPta5G8qvAf/aEV1csA0pqGGP/SFBMN0rJGuUigmAarl1dfalhopQhXDjTr94JMhe42DzuIU/8L2SNc/NOk1TwlUe7DZSyXO6JXW/soLY/iTK0yauhuE803JKqjKxgl4c7s0Xp6ck6dsYlZ28XBx0xLjz5q+un/9VudkGIo1SM6ZOoX+tc/aK2phIbnnopJVWFfUuJi564Y9URYQhQaOwmgeSeUzSB6slmkACtRMPbhLij3M+SAHcoMnbDS6GUzGXYHJAUBJiR1dAysNfXUaDE/IGLMdlpp7/pUCIw5QS1Bvrtj0MGcYKHIELTCEkpa5lix3SYifAi47SoYXUthOQsr43ywqgcA+UTP9WPgK0jvsCuPb6hh12KqeH4MylEDUV9yUZHOpnOiOEu4gzF44bAwNYbcJH2pqz+Qw4XUTCh6fYTUsKKAdzl3Zy/NNO3g62FuRh7CYaRBwMGzNwd4yHrwllgeOYf0e7hAJDMsMR2hR1bsLcgYdrcfFeCFn5bRuJ7S7U0tLiissgU59rC6puBZgj2gBYiLxFi/1jpkBsEkJEBHcVg+6wnwFIjnW0cFe/C3xucnOne+iPBA+KMNgagDsULf2s2q7j6INTstkb4NhFiXqWW20Tvcvi553/rAXZnvuDUPCGrVSryOQT6Jjnh8k0fME+L
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pORryrrSWAJlgfIo9z9eetpp1RHQQh13RqJfQfpZRr8zqyF0Gv+QZmIMNgbI?=
 =?us-ascii?Q?JGevnIW0C2n0OJTP28KmVBrovRuKVTetxOOITEEzXpyVh68Q/IeCW52MT4XD?=
 =?us-ascii?Q?yFoHqFqQQBSlLihiySKJu60G2ZOxZgr+hXraxeUd1OF2RxU7J2HJq7NWwRQC?=
 =?us-ascii?Q?ntmqr78JSzhxtnQu5JnrCA3Eot4JUie7KcKzfHmAm+wx8PK9Z4HQbUJ3HGMA?=
 =?us-ascii?Q?k9XtJbYDGyHbJu6WC8AvZIgbdB624rojp0uCwFRPJJNb/ihYlpFEsfFcQuhv?=
 =?us-ascii?Q?aAecBtBIgjj/VxWisGmYMNsF7L3LwEJnONwrtMIuwhKVYIWSkble83qy99m3?=
 =?us-ascii?Q?hiIg+OPgvXIVlXFsmeMQO1/pxQi8CiZ0Z4PkdvimIb/SKCfdUgSnc5OspcEZ?=
 =?us-ascii?Q?QjaX5sn/gIh3lH35V0gKtnALbw9N2I5eECd5Jq5zPCvmtRryvTz3OR+DTNPL?=
 =?us-ascii?Q?NXbhp7XDEvAu9MU9W6Vavm8DQTe0+QWG55nyjTF+jDSfosUXcXqAFHKXfk0h?=
 =?us-ascii?Q?rU5gYJr62Wj3dLj6SqxAStMRyVtSDlwVm2t2QCbJyz76GGCqt0gEpnBovOKn?=
 =?us-ascii?Q?XucHuWHVgg59s2Z68IAA9ZFTsncRSsJeBJmfkZWL6hjaCl2fQ00Q3rATU1zF?=
 =?us-ascii?Q?QLCgD3R/mm0e4Pbz0JSB1cfEQqQDTKkKONqc3Op7kQk4egzqZTYQSvmLpR4A?=
 =?us-ascii?Q?mNy/flcJvXs+gCKurmOCUwNVZ2TBCvzeIGCewgpjBONfG08qWsgtXNp4BPzK?=
 =?us-ascii?Q?7m3+Gz7jdQvhY1U/30fVGxnEesRq6jc/2wvAyyuBqA2sfU9mpi67mODhgE51?=
 =?us-ascii?Q?RMdvTs36aXND+tv4mc1S4dAo9ap+pkULWgd4J2JVwhUX5xnCvFB2VELCioAz?=
 =?us-ascii?Q?GFfSlR9O5bbeQfn+3m8WSaDnaygAe2ktgF7H/4omSmX+Jg1jIxtsNqNJEhEI?=
 =?us-ascii?Q?DKirOVKLO86+HIZfgDkUHg69asakAzEqYpshW6VUcYgArs1Qy6fSBiMTjNWI?=
 =?us-ascii?Q?crxFR0Q2zdqZ137BDFy+T77QtcYV5lAS2rJO7+tfhwxrdSJ3drD0+jmgKOlG?=
 =?us-ascii?Q?3OI9K0uqFLFJC3u81Hrg3gnP43IbxCOZt1t6+hCBZFIW/sCMeeA71RLEZRBF?=
 =?us-ascii?Q?M2ra1nkieO/07OmiwAEn3yQvsWKENg/bohqJESlYUwdATcjcgiE1WOIvdZag?=
 =?us-ascii?Q?OlfqfuDqXKPcZnFMnQaDGvrFG05OjzFwgZwxk33/KYJzh6CUfaIaIu+V5V7l?=
 =?us-ascii?Q?+AHHvbvK8uu4K+IhZkM6?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4bfce0c-cd05-4929-f1d6-08dc9f9b9630
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 22:16:17.0970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR20MB6035

On Mon, Jul 08, 2024 at 03:11:37PM GMT, Chen Wang wrote:
> 
> On 2024/7/8 8:53, Inochi Amaoto wrote:
> > On Mon, Jul 08, 2024 at 08:25:55AM GMT, Chen Wang wrote:
> > > On 2024/7/3 10:30, Inochi Amaoto wrote:
> > > > SG2042 use an external MCU to provide basic hardware information
> > > > and thermal sensors.
> > > > 
> > > > Add driver support for the onboard MCU of SG2042.
> > > > 
> > > > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > > > ---
> > > >    Documentation/hwmon/index.rst |   1 +
> > > >    Documentation/hwmon/sgmcu.rst |  44 +++
> > > >    drivers/hwmon/Kconfig         |  11 +
> > > >    drivers/hwmon/Makefile        |   1 +
> > > >    drivers/hwmon/sgmcu.c         | 585 ++++++++++++++++++++++++++++++++++
> > > >    5 files changed, 642 insertions(+)
> > > >    create mode 100644 Documentation/hwmon/sgmcu.rst
> > > >    create mode 100644 drivers/hwmon/sgmcu.c
> > > > 
> > > > diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> > > > index 03d313af469a..189626b3a055 100644
> > > > --- a/Documentation/hwmon/index.rst
> > > > +++ b/Documentation/hwmon/index.rst
> > > > @@ -203,6 +203,7 @@ Hardware Monitoring Kernel Drivers
> > > >       sch5636
> > > >       scpi-hwmon
> > > >       sfctemp
> > > > +   sgmcu
> > > This driver is for sg2042 only, right? "sgmcu" looks be general for all
> > > sophgo products.
> > Yes, according to sophgo, it use this mechanism for multiple products,
> > so I switch to a general name.
> 
> But multiple != ALL.
> 
> [......]
> 
> 

We can add new driver when there is new mechanism.

