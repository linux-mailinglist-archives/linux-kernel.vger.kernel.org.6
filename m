Return-Path: <linux-kernel+bounces-407066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEA49C6822
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 05:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20889B266E4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 04:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7DD16EBE6;
	Wed, 13 Nov 2024 04:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="WkwFEZOc"
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011017.outbound.protection.outlook.com [40.107.74.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7CB1388;
	Wed, 13 Nov 2024 04:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731472547; cv=fail; b=qh7GOJqi1TUGHO4TkJvMtk5vdwW4limVB1xBI/bJFhymYrjFHFYMdwgFDYzOX258L9r4tlxsDIVCE8HC5PfXdiBLqrFKJtsxq0b2xFUN5gmCEHfjtGtTqVrAFbE9Q5KbFmg3cmSWvboGzhg8lAw7DqKPIo0iLrQgZZ+l1+d2BvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731472547; c=relaxed/simple;
	bh=VuYuS79vql7FWsiHzKKCdhqBv/hru+eBhpYEBkJQnnc=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=UJMWrUp5Nbr6s28VOt4/Goz1pPpW8azpS2yYzw7vVnrvnz5CrfKEuljynULcWZSwCnuHHf5/T76T8Z4A5trFB1RXDe4Txd92hh2kg+uNFap308G0l9bFylWherIRvwT7YJbEp3lG5QNekzfSld74iL5PNd7Dn6wxS3PPn9n8WUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=WkwFEZOc; arc=fail smtp.client-ip=40.107.74.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8EA9QI8i7DN/yee7G0hXEb1BdulkOU/OiC6fJEf5DQ/DUyh2sfijwP0uVljtZ7FqoPZczam3UqSlclLAf+6w1EqhkAPZcHdmJtm/0252XAtcsyiUNEYLKuhgF3Jg8gA2BsConvQgikpiUlrTHbPyagrJin9AvSu8Wrxn9P6hSHk+I7lqFQ1NSr3OHWdy4qVAGrHbDYlmQwBrA84lhE+RO3m+1fJ4ThEt2TwTS9X3f32BCIDA0gvNSFjh6Yt2tk8dTnhUrJUB9Ddzuz6fc4UVmuPbqkThktxQic8RB6tBJPKlRjV/x77rfaajcj80pOePdnq+pGm35mAv+A9QCU7hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnL8N43crrzvd5x63aiu6K7+m9SFV9vU7zyuM4g82Uw=;
 b=qNpzAy+eZUgcCagg8B8GSfNNK7fKA+0uKp05tHJHdMlOjpkz3MDb3kcnV7X7XR6Wxq2BRzZkRfNp8NEQJNCGOXXKpPeraF2WOJwBHktX+KFdqYiypnVm8mwrdqGnhasobjymAxhg64Otw6nNi/1QJFyFqJAxhNxdMZaJfDPh8DIfrQk4z8bZ1iu0wXO+NANqJrGYH9lWOThFw8/RnBoeMRfulD9jObti6iVWgXwGD5EinG6QUVnfLPlVnjls2hJOj7sspfdCgwtHZAr4hVO/L4u3cXTFkYUjlyX+jzDy0WA01TJNlkCY+5zyoeBmRc2/fooR7HpHJuULNjl7/n4bLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnL8N43crrzvd5x63aiu6K7+m9SFV9vU7zyuM4g82Uw=;
 b=WkwFEZOclz+Mk+lo5rA7r2fPkkpWu5uIwgdou+fuVSA5NSW9XZVDnurx6TEWEDu3FHK6f0LiZcNeg7UQHquYMR+gZy3J2gfH8dRpJuTZjo3z4GNddnyAOCHrQ4/VSYLdnZpy+cvQqd1faCSzlrsXSqtWsbvI4OQxCY4oemsnFv0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYRPR01MB13538.jpnprd01.prod.outlook.com
 (2603:1096:405:1d0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 04:35:41 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%7]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 04:35:41 +0000
Message-ID: <87cyizu4x0.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: John Watts <contact@jookia.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: test-component: Support continuous rates for test component
In-Reply-To: <20241112-alsa_test_rates-v1-1-95cf529db871@jookia.org>
References: <20241112-alsa_test_rates-v1-1-95cf529db871@jookia.org>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 13 Nov 2024 04:35:40 +0000
X-ClientProxiedBy: TYCP286CA0324.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::12) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYRPR01MB13538:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ecab9b-cf3c-42d7-b405-08dd039ca11a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fa/QTuOXA0ramGYE6lofg/4sKExdLa24dEc5utkoRa8Wmv21tF+qL8ZHdrxd?=
 =?us-ascii?Q?CyiTrcNjVO6v6ZzMkLZIAxYO3LGSOwThaE/rLy6fpMpaEWDDY8+6aCKRK/0+?=
 =?us-ascii?Q?qW+5QOmMQ81Ps0hqsf178afwkDzEG/5n8eXBkkIQTuuQGB/FFyJnNGKwIDS6?=
 =?us-ascii?Q?lUxu5tHznFDgq2+TtuO0KwjtDHUKEFCP+DMEffAXRFoqZXaQZqOAliaUZdhr?=
 =?us-ascii?Q?JqUdllwVmTLbKPS23osTftkjDovpB/T3xvWT5trqZJh3HB2kT3VKVxFqdK9B?=
 =?us-ascii?Q?wA32quYAAQpFGw+uZLFt2a7Ds02Dryai4tbdSs7jXrRnRK9AngVI3gQiMCkg?=
 =?us-ascii?Q?W0RZ5N6j5Qd4Ear4QUBc+PHU9REvlUjVnQ7pjyI+r9+TacSSbqHy32Fpyk4V?=
 =?us-ascii?Q?FS/Z2BHCEcg5JbSyQQiHbOfp2Utb4oAvPxZ8Fm0VqRfuttRexi1dUHTBFum+?=
 =?us-ascii?Q?3uqcUaspFMYajwnjpcg5r+hQQUj/77sTPgXh5BsX18i4Hx2RZfthf8pokQUu?=
 =?us-ascii?Q?rxhdrx1MPOepCwCAUESDQoCI9UuFqWl7zmhtpPxw4yq81frCYUlB8QfgHD04?=
 =?us-ascii?Q?WgJNbUjdh6vTt3fEqKGWkxT1JMoZKx85UJ7u5fzh0OombvDR2ynb/udeuvY1?=
 =?us-ascii?Q?qKedVvsZ19Kqdi7Sz7t8shuXhfm9bKt6O3+accf6CXBYVok++E8LEgImiptB?=
 =?us-ascii?Q?rKlxkod9qrJG8DRIwlQCTaKSVxEiky55WUtYjK5zdrz6CBXiFGP+vOBijnMF?=
 =?us-ascii?Q?Eb9uQZqHlhTqssUjixNQWQx3bLL0ATN7obTuJCIAT56eplOQWC9yLjAlw24s?=
 =?us-ascii?Q?Psrj2TrMC4ielsbdnAL2T3p8K7ZwqRAgmiZXu6W9rFVqE/mAAs5c+kz5WGio?=
 =?us-ascii?Q?JvLZjFZAPno2U4u0gHVwVK/MirZ9K7Qfu0O9pobc1F2ExPEGKjXEbDd1fJ9N?=
 =?us-ascii?Q?gNPULN08Q0wQSIUb/8Mdsh80FKwjrn7cak4vtzyTB5NAD4cIvA9dcPTGsIfq?=
 =?us-ascii?Q?RCiB29fpiL4BKisvyQXwgjyxL5AHcMYmR/MRv5rTfkdCK7tnvsIrqXFVwkT6?=
 =?us-ascii?Q?8d3XAuILQ4cLYmTPNav0eo1HRIiblTvOqM7UNsD+B5z2Zd0VE9cy7XUYR6RD?=
 =?us-ascii?Q?W2v+tW9roPpy7IGMXPRBtCCqyPMDrtms7WxEpDc7M9EQl0FEcchGR4t4VYqY?=
 =?us-ascii?Q?IznxVLTndZStnKNcJBguO9S5BqCN8HvM1lGgMbzzghrwACVLE7oeAHh7rkas?=
 =?us-ascii?Q?/HwBuQCKynpnDqmR5uoNUQTlefXGkujw90jwss0UsqJmj1KxNeGxnfpdcCTQ?=
 =?us-ascii?Q?tv8jiLq2PT5cT+AcyZdrXjAVKzcKR+7c/j2lH66V0mEX8O3A9RvsAPG8yzHC?=
 =?us-ascii?Q?kmS4FAk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6y0qrbiRDn+HqTZS+bOfPf3bBkYulU+RJ30ySkmX6iIbwK8EvrtjD+Bv84eI?=
 =?us-ascii?Q?quSwNvVTHjHheNE4Z8GvUtdp8cLsgE98B3oBKkR/m70ljfH3gCAWFIJnnmMN?=
 =?us-ascii?Q?gkoEq7viRQQauugijaunGDYwPJ4QjQiDZw07eIOavWmMY9/WRKHmq5d2FZLS?=
 =?us-ascii?Q?xBKA7g6M8oJpX1QrP2XRau56Eyfg6+cpZvsDMYGh4JgZLz2W6F9VOftBdqct?=
 =?us-ascii?Q?xL7dUotrVcKGrYO8KKYEqfTk5gJUwti0d/Gavn261nEgnTEKHftlmUZ5+XDB?=
 =?us-ascii?Q?RZ2QqnPSA1q2gSMjZt21HDGEYAGTgRQs5sgeKyGUAK0z3ShLgDrCZIyQBmMp?=
 =?us-ascii?Q?y4mpN21N4xEwAIfp/hgZKuTFi5gkRretxhApOCPt1ZPSNiMotVv7z9aMD5GY?=
 =?us-ascii?Q?HwQE1vz5gmfs2Bf5TdhcawB72RS/1DZpnoFtXHAeU6MRIJ8/E+Yo0O0Uv7i9?=
 =?us-ascii?Q?e1UJRbO3qzJDCA9auIc3NJ/8nLRejAy+BeoYoJmikVp9Q5n2yAayvKbFt11y?=
 =?us-ascii?Q?Y6B0kqeBEs76qD5UhBHWtxz/E3/A1HsGLiRHfzXAYsR+SwWZf9jnvO5M45NA?=
 =?us-ascii?Q?qWFtCUjmBQ5CHpYNANWTp9v1RjoRr6yKMZ3XRYs9xPP+Pe/bg8f5r8M6HK7R?=
 =?us-ascii?Q?FmgN+VxA4jBDuDhp7OBvvlYDMHwr2Iqk7Fof1IIpyxqW21sMlBMCW2/9YgiN?=
 =?us-ascii?Q?9Q+BAU/jTrt+YAFmrsdcKffbYBlUuUCO7WnQzsf6bFY1xF689MuaIEv431wk?=
 =?us-ascii?Q?IhxRx2Wx3wiFAqj3BJYEfsFVlAnS3bK4xoe2U2uHvJC7mTYpJ4GBmBtCpf6N?=
 =?us-ascii?Q?oL7LRHj/De2jdadBFuT8UrMER2IsvfGrqcA9EGEY1dh1090oyV574rYZ0FM/?=
 =?us-ascii?Q?UObVO4+CwUdo8XqVYDKO8fpWhseJ6Zazp7dnoveW0MJsg2TQQL8liDLJJ7Ri?=
 =?us-ascii?Q?oEJ72BMQ8OBw78xoyCgons4Y477LOQPP6mUJIH/9+xs3IqbdceLhO05+5oDn?=
 =?us-ascii?Q?T50/CTKx751IsIP+FwsQgiLxXA5tBJYXgTwIbCuD+D6dUbKKqG5arFGp8RIz?=
 =?us-ascii?Q?4LRUrv2hMuElTdfwSZiJCXdqpFnsKEOvtjWN0CCq1FT82L3B9PdYqVxHFmQW?=
 =?us-ascii?Q?/F6tNxne73gO/h/+YXHrcHRlXroUSF96OdizwA1oJ7Sp4ura02rTgwmoCASk?=
 =?us-ascii?Q?fO0FsKPP1A4y6KaJ8Y3Kx3Kc8qHtf1cvanQKd1O2/I4Fdzp0wYLrCo+V0IH7?=
 =?us-ascii?Q?8+uwIWF0egYuXUJKEGjoNGh58P765rdMvfLw9L4Q4O+gyI5npxt9uYj3gx5x?=
 =?us-ascii?Q?dGhEdvAUh2ykGM/MpZryesLgWRgN1ssXGhJusVjYmFSyaroTJAS47TVK0lSF?=
 =?us-ascii?Q?eh8gPReK0fWZkW8N0iIYq0X8jH+U4tkt2MDW8TNMImqydnJf64XdVLgztSXb?=
 =?us-ascii?Q?vBxFQWwd08wPZjqmrq01wHQaD10LloGhYS2Q/FCs4kJlYsSSpmzvN8H3AhnK?=
 =?us-ascii?Q?YUlMCopGkMa4HqiuxkGuxyjzvibNiixh0ctSf6IQuu9AzSEil5QNYOqsep9E?=
 =?us-ascii?Q?W4YV5wI28RoC5T0kugyR84j+maUJNljmktx4i8MReTSeKeWz/9ZzayHKt5uM?=
 =?us-ascii?Q?bEcxfVSwn/aA74jfxc3s+O4=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ecab9b-cf3c-42d7-b405-08dd039ca11a
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 04:35:41.0963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XXeGCuAk8Qsuc0ONwIClbvVODQh0Vy3Bt+3SARHW81XTLCFF313S3l8UuXPb/XuNunCSGzwqNKacQdOpWwOcBT1YDltTCpJfVB9LoZUzLSJOecfUtBuPDU3EIF1IaTgQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13538


Hi John

Thank you for the patch

> There's no reason to limit the supported rates of the test component
> to specific ones as if it's a real piece of hardware. Set the rates to
> continuous to aid in testing different rates.
> 
> Signed-off-by: John Watts <contact@jookia.org>
> ---
> I've needed to use this while testing audio-graph-card2 with a variable
> MCLK. I'm not sure if there's a reason why it's not continous already but this
> patch seems to work well enough from my test results.

I didn't know SNDRV_PCM_RATE_CONTINUOUS, but indeed dummy_dai is using it.
The reason why I used 8000-384000 on the test-component was that it was most
wide range support.

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>



Thank you for your help !!

Best regards
---
Kuninori Morimoto

