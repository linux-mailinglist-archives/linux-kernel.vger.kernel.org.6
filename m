Return-Path: <linux-kernel+bounces-288088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA229533EF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0943DB20F3A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4316B1A00F5;
	Thu, 15 Aug 2024 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="KHEwVxUd"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C683114AD0A;
	Thu, 15 Aug 2024 14:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731645; cv=fail; b=qfcwUaJaviB2kEhaD3hbQaA0qRdDOH4sUG/KC2lpioAZZ8Y8fpipYDuMJnM6E+44TksRbtbrfQoOT+KnWH6vQPCEijfn20naiGzfjmL1lfFbpu5SIlkMF8f3jmKyRfZ+ooxUhovQ1E5XOnCrrMNkeRddcwhCRdFT10lRje6dhNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731645; c=relaxed/simple;
	bh=aQ4ThGiHv5R1UEHCmZ9dE7TV4Q2uykPzyxja43AQ+iY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KanblN02mbGSy6QM3QkalhwEpOLWdt65pfpmT5WJKMXp++YxVMdz4tpVGcjVn+qhY6EwXaSlUD/NOACn5reXumgDBp6CAm1/kBz7xsaptnR5ddZWiRhV0Ptt5kbaIFMe2mIjhWn/z3qoAApuOTUEiEDr3i35dB3kw7NNMdSOpd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=KHEwVxUd; arc=fail smtp.client-ip=40.107.21.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIzW+bHaFrhUPRtpDdllgoQ4VAN5t6Wqoag8JpOpUdUq8NAyK9QjlXi6+1RenhEmD2oJRVYx1iQDX/mho4e2TqkUYtWQraCqAIaRMsB2ptokxfV9WzPiVTdxMeC0Gvy6duzdwYDaN2ionnCjF2rvA8zsDpXXL7yag7EYa8k6GhrN5qE1wQSbwogZ3PMZ6ztStynVozmWX13w/j5G2eYCL8WWbeNhsxv4mwPfM5Gwq53FuYZWnPsB/LHQvNz+kENZNE6j6CIqt5voD8tMnzd0EnN2b0RBiWjNio4kp/fYoJbg4KU/eT4VPWuu6NFS3rGNHreuVCwSPfZB0Io2TBrJWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHbg6kmSm1xkYg/OO0lCqkr0zh7Wbd/BHXWiqP+7dgY=;
 b=ABlMcTiqqkHiasjitWXqEJIeKkQqauAAK1+XaAqcchLubUvrcrPFHaAQzX8QVY1LFAkEQUZ8OGjt9RDOVjZG2tyGcccGRi9QmNg413gOYiCFi1kBNPLauo8Bj/UE6vrXjRXMXv3DA6/PLzfnuifQ/AT1X9BYfcqzzssr7v8cqxkWbvP+Ad1L/OLHQDkuxJdifRWhYCql85JOvug4KMjCF1NmkQUd/kK8fuIZ90F/OxsZp+isQtTzN8ddMgvR9FE9ZzS1Two30UHOymHiB4P5nARHktPHup4dLLSDIz+JqPra3Ms+8+ZY+yIBk+cO63HGAimnlQBvJrnUSxEuepd+Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHbg6kmSm1xkYg/OO0lCqkr0zh7Wbd/BHXWiqP+7dgY=;
 b=KHEwVxUd6kbZbFm1exWha9yPpQRVAy/R6Kb1YHvpWmUah5s8U5gMuZhNZWuCF9NugCGlILEbbGgT1IGEZtJKjyKuKDNClj+f0P7nQUt347QACk8fNb9gyKPLJwaevO56XlzOucdtNpCDDK3/w49udvqdFXT2ngk8JkyBB70h/YWTrlFGy6MgQnHCRTy32e5xTX8BVyYq8s7tcM93cd9s9dYcJEFFwQuKNOEWuEbrQfJk01dTv2rOlPPOjgog3TragGFr/ndZsgjkhnLu2c0ue0dsCTsZDdW0BEbSdITz282NW4nnPPLEbB/ooBqhXbInq3kq6cMBN66oJAFMkKJ7TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB6940.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 14:20:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 14:20:39 +0000
Message-ID: <092d9466-b899-4f84-bbd9-bfb6dbf2635e@siemens.com>
Date: Thu, 15 Aug 2024 16:20:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] arm64: dts: ti: k3-am65: Add ESM nodes
To: Nishanth Menon <nm@ti.com>, Judith Mendez <jm@ti.com>
Cc: devicetree@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>
References: <20240813230312.3289428-1-jm@ti.com>
 <20240813230312.3289428-7-jm@ti.com>
 <c5c378e1-e503-43e6-a5ce-1fd53da19375@ti.com>
 <20240815123219.ovn7hdvnhseh37bb@multiple>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 xsFNBGZY+hkBEACkdtFD81AUVtTVX+UEiUFs7ZQPQsdFpzVmr6R3D059f+lzr4Mlg6KKAcNZ
 uNUqthIkgLGWzKugodvkcCK8Wbyw+1vxcl4Lw56WezLsOTfu7oi7Z0vp1XkrLcM0tofTbClW
 xMA964mgUlBT2m/J/ybZd945D0wU57k/smGzDAxkpJgHBrYE/iJWcu46jkGZaLjK4xcMoBWB
 I6hW9Njxx3Ek0fpLO3876bszc8KjcHOulKreK+ezyJ01Hvbx85s68XWN6N2ulLGtk7E/sXlb
 79hylHy5QuU9mZdsRjjRGJb0H9Buzfuz0XrcwOTMJq7e7fbN0QakjivAXsmXim+s5dlKlZjr
 L3ILWte4ah7cGgqc06nFb5jOhnGnZwnKJlpuod3pc/BFaFGtVHvyoRgxJ9tmDZnjzMfu8YrA
 +MVv6muwbHnEAeh/f8e9O+oeouqTBzgcaWTq81IyS56/UD6U5GHet9Pz1MB15nnzVcyZXIoC
 roIhgCUkcl+5m2Z9G56bkiUcFq0IcACzjcRPWvwA09ZbRHXAK/ao/+vPAIMnU6OTx3ejsbHn
 oh6VpHD3tucIt+xA4/l3LlkZMt5FZjFdkZUuAVU6kBAwElNBCYcrrLYZBRkSGPGDGYZmXAW/
 VkNUVTJkRg6MGIeqZmpeoaV2xaIGHBSTDX8+b0c0hT/Bgzjv8QARAQABzSNKYW4gS2lzemth
 IDxqYW4ua2lzemthQHNpZW1lbnMuY29tPsLBlAQTAQoAPhYhBABMZH11cs99cr20+2mdhQqf
 QXvYBQJmWPvXAhsDBQkFo5qABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEGmdhQqfQXvY
 zPAP/jGiVJ2VgPcRWt2P8FbByfrJJAPCsos+SZpncRi7tl9yTEpS+t57h7myEKPdB3L+kxzg
 K3dt1UhYp4FeIHA3jpJYaFvD7kNZJZ1cU55QXrJI3xu/xfB6VhCs+VAUlt7XhOsOmTQqCpH7
 pRcZ5juxZCOxXG2fTQTQo0gfF5+PQwQYUp0NdTbVox5PTx5RK3KfPqmAJsBKdwEaIkuY9FbM
 9lGg8XBNzD2R/13cCd4hRrZDtyegrtocpBAruVqOZhsMb/h7Wd0TGoJ/zJr3w3WnDM08c+RA
 5LHMbiA29MXq1KxlnsYDfWB8ts3HIJ3ROBvagA20mbOm26ddeFjLdGcBTrzbHbzCReEtN++s
 gZneKsYiueFDTxXjUOJgp8JDdVPM+++axSMo2js8TwVefTfCYt0oWMEqlQqSqgQwIuzpRO6I
 ik7HAFq8fssy2cY8Imofbj77uKz0BNZC/1nGG1OI9cU2jHrqsn1i95KaS6fPu4EN6XP/Gi/O
 0DxND+HEyzVqhUJkvXUhTsOzgzWAvW9BlkKRiVizKM6PLsVm/XmeapGs4ir/U8OzKI+SM3R8
 VMW8eovWgXNUQ9F2vS1dHO8eRn2UqDKBZSo+qCRWLRtsqNzmU4N0zuGqZSaDCvkMwF6kIRkD
 ZkDjjYQtoftPGchLBTUzeUa2gfOr1T4xSQUHhPL8zsFNBGZY+hkBEADb5quW4M0eaWPIjqY6
 aC/vHCmpELmS/HMa5zlA0dWlxCPEjkchN8W4PB+NMOXFEJuKLLFs6+s5/KlNok/kGKg4fITf
 Vcd+BQd/YRks3qFifckU+kxoXpTc2bksTtLuiPkcyFmjBph/BGms35mvOA0OaEO6fQbauiHa
 QnYrgUQM+YD4uFoQOLnWTPmBjccoPuiJDafzLxwj4r+JH4fA/4zzDa5OFbfVq3ieYGqiBrtj
 tBFv5epVvGK1zoQ+Rc+h5+dCWPwC2i3cXTUVf0woepF8mUXFcNhY+Eh8vvh1lxfD35z2CJeY
 txMcA44Lp06kArpWDjGJddd+OTmUkFWeYtAdaCpj/GItuJcQZkaaTeiHqPPrbvXM361rtvaw
 XFUzUlvoW1Sb7/SeE/BtWoxkeZOgsqouXPTjlFLapvLu5g9MPNimjkYqukASq/+e8MMKP+EE
 v3BAFVFGvNE3UlNRh+ppBqBUZiqkzg4q2hfeTjnivgChzXlvfTx9M6BJmuDnYAho4BA6vRh4
 Dr7LYTLIwGjguIuuQcP2ENN+l32nidy154zCEp5/Rv4K8SYdVegrQ7rWiULgDz9VQWo2zAjo
 TgFKg3AE3ujDy4V2VndtkMRYpwwuilCDQ+Bpb5ixfbFyZ4oVGs6F3jhtWN5Uu43FhHSCqUv8
 FCzl44AyGulVYU7hTQARAQABwsF8BBgBCgAmFiEEAExkfXVyz31yvbT7aZ2FCp9Be9gFAmZY
 +hkCGwwFCQWjmoAACgkQaZ2FCp9Be9hN3g/8CdNqlOfBZGCFNZ8Kf4tpRpeN3TGmekGRpohU
 bBMvHYiWW8SvmCgEuBokS+Lx3pyPJQCYZDXLCq47gsLdnhVcQ2ZKNCrr9yhrj6kHxe1Sqv1S
 MhxD8dBqW6CFe/mbiK9wEMDIqys7L0Xy/lgCFxZswlBW3eU2Zacdo0fDzLiJm9I0C9iPZzkJ
 gITjoqsiIi/5c3eCY2s2OENL9VPXiH1GPQfHZ23ouiMf+ojVZ7kycLjz+nFr5A14w/B7uHjz
 uL6tnA+AtGCredDne66LSK3HD0vC7569sZ/j8kGKjlUtC+zm0j03iPI6gi8YeCn9b4F8sLpB
 lBdlqo9BB+uqoM6F8zMfIfDsqjB0r/q7WeJaI8NKfFwNOGPuo93N+WUyBi2yYCXMOgBUifm0
 T6Hbf3SHQpbA56wcKPWJqAC2iFaxNDowcJij9LtEqOlToCMtDBekDwchRvqrWN1mDXLg+av8
 qH4kDzsqKX8zzTzfAWFxrkXA/kFpR3JsMzNmvextkN2kOLCCHkym0zz5Y3vxaYtbXG2wTrqJ
 8WpkWIE8STUhQa9AkezgucXN7r6uSrzW8IQXxBInZwFIyBgM0f/fzyNqzThFT15QMrYUqhhW
 ZffO4PeNJOUYfXdH13A6rbU0y6xE7Okuoa01EqNi9yqyLA8gPgg/DhOpGtK8KokCsdYsTbk=
In-Reply-To: <20240815123219.ovn7hdvnhseh37bb@multiple>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: 68b87412-149d-41fc-5e81-08dcbd357040
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STNpMnBZdWlHNjM4ekJFNjZkRGh6YzB2d0ZlNEY1MTlINy96ZUJIV0QvOHNr?=
 =?utf-8?B?czRmNVF5ZVg0R3NYUHRxV2tGUnhZL1ZSVUVEUFdRczloU1paSWVYMjNBeEND?=
 =?utf-8?B?NnZJTDcyeEwyTmZibDJLSVI0R1I3eTE1NmR0VHR0c1FFK0JhbXN1VFR4dHdy?=
 =?utf-8?B?cmlzdTRFeGlacjlRb3ZIN1NIZnNVRkN6Rk05VC9JaTQ2UHJCRkFIT1JtcVNU?=
 =?utf-8?B?T3hBUDBjZytTNVNMUFdtcmJPY1JLYVJTUG9zeDNKcThtWTd4S3NGRVVnWEpP?=
 =?utf-8?B?TFFWNjdVT0ZQVXpEU2xoSFhyS1lkem5DS3RKTFhhOFIrRFgydWZrcW1UdlVo?=
 =?utf-8?B?SFYrSFZFcVFpSzlGcVVZSlE5MUVNVmYwaDNoNjUwaFhiYzByNnVmaFZ6NXlx?=
 =?utf-8?B?NkNGNzdYZUp4NGZPWGtlQk1qOFAzV1ZLVVptT2Zacmd1ZHc5R1EwNForSXNZ?=
 =?utf-8?B?YVFuaHVmaHoxMHI0eEFwUFNhazFoS01qYXhjVUNyU0lkRUEyTFpkQ2t6bFFm?=
 =?utf-8?B?cnlzVVRGNFMyS01KSkh6emMwVzZmaklmNjIxRzQzeXlHUkJ0NUpabDZ6NEEw?=
 =?utf-8?B?NlZxOUwyVzVsanhxY2dyc1Vvd0RhNTRUK0U2clRHbXZYTk54SXhucTZTYjcx?=
 =?utf-8?B?YWs5anNiYkwrR2RxbERZNGVFbmUzMEFRbVE2MHl3YTFMamN4MWFrMHhodHpL?=
 =?utf-8?B?VUZaQm9sTTRyNDZ5dzNaQ2ZUVmhXem0yVjcxczJxUjluK3Z3c0tsT0FkRU44?=
 =?utf-8?B?dUVUZzRKdk9wMld6NmhiKzRyMC93N1diNGpRWmY1anFyRVhIVjIzelNJOFFU?=
 =?utf-8?B?Ni9vYmk2V1FRZ0hmTlY1VVZscG53K1BRWGdJMkhmZTlXWHNlbVYxOE9wYTdO?=
 =?utf-8?B?ekFydEhWWHJtQmVLSmhUOUhyZ1VPeDhoSGpsdVJhK1o0KzhYejE4bm5qRjBx?=
 =?utf-8?B?TG9IN0ZNU0E0eDkwRHBXQ0JKMTlITE9nbGtVR3RaZ3EyandlYzZJUlh4Qm9i?=
 =?utf-8?B?QWFQbStOV3dvczlwWkU2UXBGcUtoSTVRY2gzc2NKOGk3cCtsKzhpMFNHQXZJ?=
 =?utf-8?B?SVVsLzJ3QU5Ib0NQMW5NZExDVTM4TDBxN0loaGp3L2pOT0QzNEFsa1ZOU2hN?=
 =?utf-8?B?SmZBWU4rMHp5eVBTeHRaR1FXZDVkS0FPZThwbzVNK2pwTnNOamUvL2UyalJD?=
 =?utf-8?B?ZnUyUEY1eC9LRWRPQVZlMGpQd2hlUkU2dmhnNjhSa3BGdnV0MHFsMFFJdVk5?=
 =?utf-8?B?L1BPOXNmUjFXc0dxdUxYalZjL2h5blFiSTE1VlQ5S2RZYTFlcCtUQkcvNWp1?=
 =?utf-8?B?YnRha2JVUm9Ma0pacHFRckFiQWVBTjgyTnkwTXhZWnVwRjE4UTVUMWdoQTJt?=
 =?utf-8?B?TE9MTmtMRXBBcVUvRi9uRFBaWjl1SEV5bnZ1OWVlMFBtV2RZb1hUYmEzeGJk?=
 =?utf-8?B?MFZTWXJ4M2RLQ1VPTTNFajNNZ1c3dHN1NU93M2p2SHQ5Wm16V0Z4SUxCS0xl?=
 =?utf-8?B?c0hBNzBoZXZVNy9yb1g1WTUvSkt0amRXNGZmRnZocUR6Vk5TZmtMVTRGbjdX?=
 =?utf-8?B?QU5EYlBROS96N2JiVm9LQVVoUnNydVlVVk0wdndCYkpvNWFIR1IvaGVVbzVj?=
 =?utf-8?B?YmhwOUkrbGlyWVhpSklYZ2ZWR2YwWXpsaUV4cTVIcDlXc3FLMStYK1I5c21k?=
 =?utf-8?B?ek04ZitWOXQrQjVtSk5BUytCYWVWbHpldGk5UGluOGVLLzhqMy9oM2ZhZzZm?=
 =?utf-8?B?bmJ0d3dYeDMwM285Tzk1RVRzNThaOUkyWHA5d0JVM1NBbTFhK1Y1OEdrM3dy?=
 =?utf-8?Q?A8C5w8v0RkWK1fWs5Ien22wUUAKAZ0UIZrLH4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UG1zeG8xQmtDZ2dYVFlkcWowYjNjWGMrMDVkSVlwYkNINVk1UWpCRCsyOU5F?=
 =?utf-8?B?YU5rTW16Q0hvOVJBNkZvRGYzd2wzNG95MjlMVmhodUl4R3JGcjFJWlVzQi9t?=
 =?utf-8?B?MFZPVUtSNlB4LzUzSzhzRjI2ZnA0ZjBQUzV2cXdhdlhVWUJqTktPSWdzSnpa?=
 =?utf-8?B?OGZUTHhISGM3eWVPV0xLd1B0TDJUazVLdkZRZFpxNTl4dERGeHo1NzdBb2h4?=
 =?utf-8?B?bWhnUk9hS3NoRTFzekpBSGlzYmYyZ1ZOeGRDR095cjN5c28vTDcyZnJGakYy?=
 =?utf-8?B?MTVqSnJIU2VMVXFzN3dpVndDK0lIYmR5amZBN0M0Qmx6MVlHU295TVc4b2dC?=
 =?utf-8?B?WUhDN2tVMXE2THdJbnFBam9pdllQYVhqekppZWJEeTMyYVh4amZUOWwvY1o3?=
 =?utf-8?B?VEFqajRBVTl4d3RYQzhLMkNtL000bEZMMzg5cU9lUDh3M1lUNXc4Ym43N1BD?=
 =?utf-8?B?RlFiQTNrOWsxWjhYU2kwRE9HaGZDb1JFNnZjdFZWQmtyRVpaNDNNMmRJUzN6?=
 =?utf-8?B?NkV0Nk11bHpLYzExaWpDeHIrVzFHeHhZckI1VE5ZVzc0VW50NzNiWjR2Qmo0?=
 =?utf-8?B?aEJlUmIzdmFOZDlJV0c3NWZpbFJqY080SndHb3NkSFU1TlhZczhBRHdKaGhQ?=
 =?utf-8?B?MG9VeE9MNmZqSzMvZXdVR0FYajA5N1Z3bU51NG81Z1dPdjhQOS9iNjJsb0FG?=
 =?utf-8?B?Y090Tzd5RHY2dmRoTDdTV3VBUzNRbWdXWEFKbTFUM2gyaExEbW9MdWVNR2Er?=
 =?utf-8?B?MXZiRUpqR3o5YjVmcnI4dWRpSE5ZU1BEYzFJNkFMbFR0TmFvMFg3WmJ0R2ZT?=
 =?utf-8?B?V01WMHYrekxrbjZoUTN1REtiT1pza2lwNEcvK1NPOUxGZ1ltSkRxVlp4UnRz?=
 =?utf-8?B?S08xRzhKT0pUTkFJZFk2eC9TenhzSTFmYjF6SEpEL0k4MUpVUkZZem5wWDE3?=
 =?utf-8?B?UWhzZGFxS1h2SDl5RG50eFU1UWlqKzRYNjV2RWIzZkNORzA0QnlGS01lK2dB?=
 =?utf-8?B?amhsd25aV3Z2VGR6Zkw4UFhmTTJjcHcwSG1tWVI5Sjl5TVJKRVJnVFU4cm5Y?=
 =?utf-8?B?cTFUZDJ1bnJKc0RSd1hJdGlFcEhVcTVibkNmelc3bUpSWlg2UXVpTFU2cjBs?=
 =?utf-8?B?OVNBMUtZSWY1c0tWM29IUFlpMVdkOFZrd3prTkdLQUQxQTZnNXU5a2tVc0xY?=
 =?utf-8?B?Z2hsa1dQYUVzL1dLaGFNWjcvK2xZUUpkaUZoUUtpczVCV21yRUVnOVoyTjBK?=
 =?utf-8?B?Z3Zka295WERMSCtJTlp2VWYvK0d4MUJ2U0Rjb2lxaHZVSzd1TkJ6T1pqVXoy?=
 =?utf-8?B?SHZQVjBVNFcwdG83czJEVGJFN3pjNlBqUDk2eDJ4UnNxTVNGd0xISm1EdGFs?=
 =?utf-8?B?SUNUOUN0NGhvd1o0YlhpZE5vTTZpLzhOME50OUZUYjlURHV2U3JTUXcwQlRU?=
 =?utf-8?B?Sno2MmFMenBLaW5FT3BOZXZEbmhsdzE0clBZZnJzNWc1T1dNOXdJa1QzK0xn?=
 =?utf-8?B?bFZTTDNvenJkV21hZDVEb0EyUjdQQ2VVWHdkZFBleXEzZmNuWnRjN1FqbDRa?=
 =?utf-8?B?VTd0K1Fhcmw5ell5OVBZalozYnFnMW5xcGNOQ0JheDE0czFQWnkrY2VVU2xE?=
 =?utf-8?B?MnV5aWsxQ011clZJQnNXTmJvVUM3UnpNSGFsc2xWZ1NQWmxyczU5Q0pnV0xJ?=
 =?utf-8?B?NFRvMUI1ZnZRS0tERWJINzZPM3Q1TG41TjdkdFRaY1kwc0Y5ZWgvTmM1Qkk0?=
 =?utf-8?B?T29XN2NkaERPdGI3dW1xalcrMURKOEdPRGpCNllDSjVYbDRCa05VVy9yZGRM?=
 =?utf-8?B?MFlVSFVHOUJ6N1RSYlVOeExjRkNIUUIrOXJleGFVNXhJenJVVjZia1pmUUJn?=
 =?utf-8?B?Mkpab2dIaGlrWHhnbUtvNmxFWWxSTGduR3VPY0IrVVJNT2c5ZGtvY1hackFN?=
 =?utf-8?B?YWYvM3JvKzMxRXQxbUg1bjJvTWFFMElCelk3ejBEdVUraGpzS0JzbllmbU52?=
 =?utf-8?B?S1kyRVpoN0NvLzFraXQzUUoyaFY0RFl3MlNNUVBNb2xwMHNWbkVyZzk4ZkUy?=
 =?utf-8?B?NXlxYU0rWEFKM2RUOXprTS9EenNkcVA0TFFkRlN0UXZLMG1KNTJROXRUZEQy?=
 =?utf-8?Q?280uCeC2CYCqN/9Dfo2LA89RH?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b87412-149d-41fc-5e81-08dcbd357040
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 14:20:39.5419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iW/zEBjVGlkxrtKGAA49tSvLGd4knJ3CJX6SEPxzLw+UMat/i8M1fl8VD10zkGOfmkPKc3ZUItxvHhSA66kBLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6940

On 15.08.24 14:32, Nishanth Menon wrote:
> On 09:05-20240814, Judith Mendez wrote:
>> Hi all,
>>
>> On 8/13/24 6:03 PM, Judith Mendez wrote:
>>> Add Error Signaling Module (ESM) instances in MCU and MAIN
>>> domains, set ESM interrupt sources for rti as per TRM [0] 9.4
>>> Interrupt Sources.
>>>
>>> Add comments to describe what interrupt sources are routed to
>>> ESM modules.
>>>
>>> [0] https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf
> 
> As mentioned[1], please update the commit message
> 
>>>
>>> Signed-off-by: Judith Mendez <jm@ti.com>
>>> ---
>>> Changes since v1:
>>> - Add patch 6/6 for am65x
>>> ---
>>>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 8 ++++++++
>>>   arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi  | 8 ++++++++
>>>   2 files changed, 16 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>>> index 1af3dedde1f67..07c9f043dac0b 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>>> @@ -54,6 +54,14 @@ gic_its: msi-controller@1820000 {
>>>   		};
>>>   	};
>>> +	main_esm: esm@700000 {
>>> +		compatible = "ti,j721e-esm";
>>> +		reg = <0x00 0x700000 0x00 0x1000>;
>>> +		/* Interrupt sources: rti0, rti1, rti2, rti3 */
>>> +		ti,esm-pins = <224>, <225>, <226>, <227>;
>>
>> I am not sure if someone knows the answer to this question, but..
>>
>> I noticed that for rti, the interrupt source id's are different
>> for SR1 vs SR2, so which should be used here in k3-am65-main?
>>
>> Here, I assumed SR2.
> 
> The only production board with SR1.0 that I am aware of is
> arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi I think - Jan can
> clarify. The technique used is to do an override in the dtsi if I am not
> mistaken.
> 
> [1] https://lore.kernel.org/all/20240815122928.4i2yob5aj5ssqhzw@reply/

Yes, we have to boards with SR1.0 in field, k3-am6528-iot2050-basic.dts
and k3-am6548-iot2050-advanced.dts (which include the above dtsi).

But given that AM65 is not benefiting from all these changes anyway if I
got the reply correctly, why do we care?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


