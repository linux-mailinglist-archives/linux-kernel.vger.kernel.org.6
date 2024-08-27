Return-Path: <linux-kernel+bounces-303123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CBB9607BA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 456191C2245D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FA919E7EF;
	Tue, 27 Aug 2024 10:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="mxx/bLSc"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C152FB2;
	Tue, 27 Aug 2024 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724755467; cv=fail; b=TqdJFgRg6+kS6GmHC4rKagEXH3nphoXBepTNZoK3PERYj49FdBtqarnIn7ECwD7bwlhqYQdsqVnr2L5G0C2l4c2f0AtI73rOaR7m7Ox1aR9IOoeYXM/j/7BWvZ9rnvmZbcS0+TPyHH7e1nyCPobiExbwXLc8/VDbGCh8Czemx4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724755467; c=relaxed/simple;
	bh=ZftxxX0PUzoKzG2OQDstOcFGApA1HpUdNWJRr4PRtAg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GR75yhFtVTve80mOSW0gKQI7cq6ERUVL6QCk6LLZ3zSvbk00UCISPXnsCxDEqXm6/r+PbHFmqQhK65vDLIx0WiVoJmmkJGLCQ/pcbDtoM/9GxNCyPldBY49bd+sIGtS3CDC0xNiQZDlRup7JlH4qUrkYgHLXPhFXtsZ7xUTmPfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=mxx/bLSc; arc=fail smtp.client-ip=40.107.20.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFafnZBuGDlBFXu1Xtm8gZxUNXo8SuuzlmtZ0sxdBPJZY3MsiflcG3y7n6d1CBqJ0gw8X+ByWN7jKpa5xzLBytHvGZL0rw3v51t7qzoNywnWpMNXnwnnxl1a8JJEZBZBcg5qjMb3e2qxrwqYI2EVyiui+CLe68gili06IeKqDGDCFrCov4yf6/dYYBF/JQEwV09dZ+eFkDDuYbzNudUp9w9jNs3Yf2bwsCumEtA7woc108N0Avz2h6ANWcr5z0lku+J2+vSfFpY+3gq9LBWtmu/r4b0UWeKxf1crwDm3GXeWnrL2f7bVykcpv+DoJSBEJekc98rGMklY8G3tBOYD9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKB36Nku4vduW8FJc8H6cj0FtDlVkKxXCA6Z1II0U2w=;
 b=VruC5887hGYMA0wzh/DEr3dqzBwO2MA76YQjak4lCyMJqa21u3KPRcLOmBLssKoT/gIXgK03uEd3l5gEhBeMeeD3MohzCXnP+HB+vu/04qiVIEa9vLGYB0ui3f4CUykT7BhdJz9oMEPTVcHSKtPnZQWW1pd/fBFRgbIdUb74INr6hYWjFVmhyICbX4+v6Zck6F4ZJqlscgZ1EO2JzWZLfLopaRCw2JokAmwUtXesuOgFeq+abasA8ujaIEvKGKToLN+265kFcUa5kmxtdyKNxfDKGe1ia605u5gvelsIC9Mdr/Ev4W+W7IhvldpufExz78iJEzZKDyHoAhhVle5DjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKB36Nku4vduW8FJc8H6cj0FtDlVkKxXCA6Z1II0U2w=;
 b=mxx/bLScrZiKhkeALmoIGpu/OS56af2B/G7ccZJXkZxgJqT7bkNu2viDg4oof6s4x79Z4qXbPm7KanNH8iNDxQLbdmFTQGNRTshpVHaYcziLMPU2iNj0OmGvGWDyErpkIBjOfS6Z9LQPziRfnus/lx3fdG3Qc1tM2Q4KMd74wYxFZGgXXbJoA9UGjxGjiadvZ+HKNdlK6kRHsHVaOW7l+a78rZi2pQ6hy1Mwsz5YH+DFPS+eIpxu1jKJTO8lE9vale1HgY6SQNakqm879Orz9/RYVRPjENwJ/W2CRVk6+uoQRyruISuBXTXECtKm1D/17ovYkslRlHu6h2NGns+YUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7609.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 10:44:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 10:44:21 +0000
Message-ID: <554cb065-6483-42be-bfed-9ed6d3b16fb1@siemens.com>
Date: Tue, 27 Aug 2024 12:44:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] dt-bindings: PCI: ti,am65: Extend for use with PVU
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Bao Cheng Su <baocheng.su@siemens.com>, Hua Qian Li
 <huaqian.li@siemens.com>, Diogo Ivo <diogo.ivo@siemens.com>
References: <cover.1724709007.git.jan.kiszka@siemens.com>
 <82ac9e266f6aca42699ec4a3c8f10887789ee6bf.1724709007.git.jan.kiszka@siemens.com>
 <afyz3i4xihir4fnt4djo45saytz5ubu3wel6munq7cinwcb55m@ohdelne4xf34>
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
In-Reply-To: <afyz3i4xihir4fnt4djo45saytz5ubu3wel6munq7cinwcb55m@ohdelne4xf34>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0043.namprd14.prod.outlook.com
 (2603:10b6:610:56::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7609:EE_
X-MS-Office365-Filtering-Correlation-Id: 642181cf-3b5c-4a92-d658-08dcc6853556
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDZCUVErZ3h1Mk92UEkzWndoWXlRRnFoMXVRVUI4T0ZLajZRbUtWQWFLUDlV?=
 =?utf-8?B?SGJJZS9lVVg5N2dBdWlIYTV3OWtJVm5EdTRia24wU0xOdkpRcktSTHFQby9M?=
 =?utf-8?B?T3htM0dTTHlTNWszSDdodm5pQ2dUTXEzMmZXRzQ5aEJQbjkwZis1NDZ1VVhN?=
 =?utf-8?B?YVZzRG9Oa243dHorWXNreHhnaGtNVW85Z2hXOSs5M0tySEdtY2NQcEVBS3dD?=
 =?utf-8?B?UGUrak1EYUZqVWM0WEtLMTA0ZStDZ3JDTHUvWEgyazNSTXREb1JWWnVPbi9M?=
 =?utf-8?B?Nm9weFh3cDhQcUljRG1MSGN4V1J2RFNZSHI5YkJPYXp3clJYQnBmREZOdEty?=
 =?utf-8?B?TjZjbDJaU3FreThQcU45YStPZ3orL3IySnE0ak5FUFRwVkd6Q20wNEhMc0dJ?=
 =?utf-8?B?Ky9PbDI5TlZsaWRrOWhBWVc5Sjdha1UxcEhzdEc3ZjhrNjBHVk5SWlBYOStH?=
 =?utf-8?B?SkxMR1ptc3FjWTJZQjhuYVh6eGN0bjRUSFRpMm5YcjZoYXJZWHFRRVpiUzQ2?=
 =?utf-8?B?UjNuNFNqL2JtYzFlNXBtdkVLdzN4UU96bnZmOW9YK1lJNXBKYk5IZ1FqK0RR?=
 =?utf-8?B?T0paV1dhaDU0UllWdXFydmQxNDV3SEkwamVTWnZ1R1V5Y1I4cWs2cnBCWWJk?=
 =?utf-8?B?RjhWT0J5akJlU1R5N3NjdUQyVGUwRDFramN1ejg1RXdmeG16YWdiV2tTbVg5?=
 =?utf-8?B?YmN2WEtoR0dnQVFXOTBCbHNHNnlHMUcvYTIxSzBxMkcyTmNLWDB5WUdZeHZs?=
 =?utf-8?B?Vm5qbVVoaDJBTVhHdTlrUjNOS0ovTjkrVnhWQm9iaW43b0hnRnRqb0lYOEFo?=
 =?utf-8?B?VWV0bm9kUUxpMzVkVU00cnR0VitBaVg3UXN4MmQ2bHFaTGYwRFk4WVMxMHRQ?=
 =?utf-8?B?NzJmQVdmR3JHNFRqejRHUzdneFpoT3A4bEhwK1NneUtUZXFTYk1uVXMydTh2?=
 =?utf-8?B?VXdkM0lpeFhublo5MkVzamNKc09FZjZjNVFUSkhwb2E5cUh4WktlZ01ySDEw?=
 =?utf-8?B?QmdaS0VGNVBOQzNudHpqbGN0MEdTYks1L1VBZFdyU2hRSFF4dDhiR21maERM?=
 =?utf-8?B?TEpMckpMek9Wa1hDa0hPbGFMTFVzaTQrOGVzZmU1ai9tRU9VMXJvQyt0OHNC?=
 =?utf-8?B?UFhrOXJkZnNMUm1xdzNMYUE1R25kcUpLMUJMN0twYzRRa3JSR2NxVmplVDk0?=
 =?utf-8?B?M3NEVHc1LytnQXE4cTlxeldhV3hlUWxsd2FOd1FKRlBkZG45Wm53UDBESGJU?=
 =?utf-8?B?UnJXMHlqZjdqdE9QMFRZdnpnTExNZ3NRT0N6dEFOcVRGZ3JKWENKa1Z0UWJk?=
 =?utf-8?B?NStCNGkzWnRINFZEK09EcUNMTmJCb2xtUXQyd0J5cE9KbXM5WWdSOUQweXNh?=
 =?utf-8?B?YmlqenJhSHhIQ2d2QjhZNytWUFgxVFRiOWppWTNqYldkUDJoYmk3SmtvblhP?=
 =?utf-8?B?QzZBWWxuUmxTbTRJMmtwbExpK09GYXVoMVBhd1pzUytrUVFkTnFHUVYyQmdC?=
 =?utf-8?B?MlUvVitQdDJjZW9raFNjOW5kM2Uxdk5nbERvUTBWbXp6OUZyMTZDNVd6NGNr?=
 =?utf-8?B?V3NvVC9vaTdLbVVyNGt2QWZpR0tEckdvWHVrTVJmcW5Rb3BDbi9kSkZWU2Y1?=
 =?utf-8?B?QUdteTZpY21kMVBLQzdwUzRQSE1QdUFEQnBSYk0zbExJQWtWd21mRWg3amNY?=
 =?utf-8?B?MnljR0o0YUhWYUR6OFJPY1lyT0ZYNjNPWWZwUmVKSXZRaTFYOUNPTjhSUThv?=
 =?utf-8?B?M3VYNE11NXkrU2JKb1g3ZW5scks5ZmIvb216VmkyMWlETW1RTHRadEtOMFV5?=
 =?utf-8?B?WUg5QWV5QTBPUHFpQ09rUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWVnTnhFN0NWR2d2aTQ5R0pzWjF4RER0ZnpzZkticmdOc1gzUWFURmpBNjl1?=
 =?utf-8?B?TThWMTFpbnJOWFc5S0c0WjlzcEMzaHdiZ0Q3YStKQnBzK2MvZENMV3RvZVVS?=
 =?utf-8?B?RTNtU0dDSUljTHREVW9ESWltV0pDczhXbUFsRGVZUnhaSEIzWGV6Z2VING50?=
 =?utf-8?B?SmJVYm9zUU9KM2FYbWdkcWxXVFFuQ1NxYlJnY2J2U3piZFhZei9LZkJoM29j?=
 =?utf-8?B?R0NYa2hidGFKQU16NEFlWU9rNTNoUThnbm9DYzQ2TEZqc3RrcU54K1N2c0Ju?=
 =?utf-8?B?Um8rMHFmQ3IyRGkzYjFXS1U3U09KWkRlSzE5WU93Z1lZUEtDajc5KzdXc0NQ?=
 =?utf-8?B?TTRPUm1zNmR2c3BGUXFFZkNZY21vR0VvL3p1eGMwbk1oSi81MjV4QktvcDB5?=
 =?utf-8?B?RHZFN0c3R2U0Nzkwckh6ZUxMTzl6VFF5WktHbjI5OTVsMEcrL0VEQ3d3RDRT?=
 =?utf-8?B?NTVXZTFicTh2Y0hJN2FISDZDdEMzTWRvcGErNUZDeUFoRTE1WFFSNWlFa2ZH?=
 =?utf-8?B?UzBXTXltMG5PZkdWeU9FeFE0OWc5ZDVxMmNabm02cEo2K1ZaWFBXMkNjY3dW?=
 =?utf-8?B?eFZCTVIyOTFMTjlmeGJOcjRaVHB5UWUwbEVzYzNJQWpSNjhwNTRwVFkrc2FZ?=
 =?utf-8?B?RjhDNUhnTmpMS0F0bjUxYnVhZjhqKy9JbVljYnRuaTV4VzFhTWlWN25DN3BI?=
 =?utf-8?B?eGRCR0NKVC9pVmZydWIrOE5IYnowY3pxWXlVai9KK0FwQVAvY1dIVmxwRk94?=
 =?utf-8?B?ZUx0NzZiVmpCbEpCcklwZVo2NktOM09BZlh2TmVxN3dOUGdyaW5zMDAxcU91?=
 =?utf-8?B?Y1BHNTFtRnZzSGpyZlZ3Mkh1d0NaL1RDUmNlME1UVUp3dnBQek1WN1pseGF4?=
 =?utf-8?B?bTRvWUIvZEhESS9MbThNRlJLSzc3MnNwVmx3aTgrVDl2dzRac1pwMHV1M0JC?=
 =?utf-8?B?bHkxRkdONEE0cmIzMWlIMU1TdTIwS3EwaGJBclFOSGNMSVY1ZEhkdXFhNjVL?=
 =?utf-8?B?Nkd6MGl6VWs2NGJFMmJpcmtBYjRIZ2lScDByUlp6ckNLay9pVnl0VmF4UUda?=
 =?utf-8?B?NlNndi8ybDhEM2tzdWl4cytqNm9rUUNjTVJDMjZ5N2hKTmtuOG9CSld3aVZh?=
 =?utf-8?B?N0krVWpIdUxVUnN0RGRtblQ3OXdHRWV3RzBvYWZkV2hxUm1IeHFDRzZkY1NQ?=
 =?utf-8?B?ZzZjUzJtd2V5bFg1SldZVFd3MmN6TUgwS3dXUkJ3ZE9RaDM4YVFkZDk4MzMw?=
 =?utf-8?B?RVlRbUVmUm9RYkg3OFE0MCtnUlI1NC9XVXVGNGo4T0l5Qk1hZ1lxaCtLaUpC?=
 =?utf-8?B?WlZqVmxaTlBzSm5vcFhWWSs5S3h4MGg3U3dyUHVkNy95Q3ZxcVA4VVkwakxZ?=
 =?utf-8?B?emFUM0hxL3JzUE9rL3FsMEpnUFJFbWZMVDJrS1lXalM4WkpRa1A1R1kwN3Yr?=
 =?utf-8?B?S1liVUduWXdLeE8vdFVDdFlaQUNJdEk2a2hNMXB4VFJlRDlPT3Bhb0JHanNP?=
 =?utf-8?B?MG1vb3E2MWMyejBRKzlqZndYbVZMRXhxVEdkMXRrbzhNUno2dTJ4Q1hjblkz?=
 =?utf-8?B?R0FQQ0RicjUzbzRxc0ozTHJyeUZWTXhuR0FoUTJpZ3czUXJSTmp2UUVtOXNR?=
 =?utf-8?B?cFJKMnBLQmFiTnM4allCMW5yb29kVTZXVVIzem52T3V1RXBxK3QzeE5TSk5K?=
 =?utf-8?B?SVorbEE4OS9CNFN1UHJiMzNzNEQyTFVQYjdRMjF0eHBWRFlRWEQxNDZWSXBX?=
 =?utf-8?B?aGhONjV1eCt1MVh4U3l3Ynl4dktvd2wvL3huVlI5QVU5eWZrc3FmMVRGQi9N?=
 =?utf-8?B?M3FBc0pRV0lJNXNpNi9MeVVGSDJrMXMzakc2L2RiYXZjMUIzL2hySk1LR2Fs?=
 =?utf-8?B?cEc0dnBCOWxvTGpFeEorWlNnMkk3YWJkcmpRMnpmU1Zyb2xlQWxsNEdUTHY3?=
 =?utf-8?B?ZWFpR2JSbGJ0U3JKQjBHNWZmY2dGSCs2WGgyZmYvNjFxMGVSMUkrQ1RvUXRB?=
 =?utf-8?B?ZWVWRkFSWXRMWjFwZzlWZVhKQmFyVThQNkVHenY2ZUZmS0VFaVVQT21jeHps?=
 =?utf-8?B?TFBJbnhqU3VFc1hUWFpSdmRadWRGWWdId1dXdWdWcm1pMWs3bFhYOVF2TU00?=
 =?utf-8?B?OW1LUFI2RTg0QVpSZnU5emZwU29YSDZzaWRBbXJsNVZrMGZjazJZOEpiSWYy?=
 =?utf-8?B?eVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 642181cf-3b5c-4a92-d658-08dcc6853556
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 10:44:20.9644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h0vf9rYhod41w/0Z7fuy7Oac+2EJIMf+7A1k6rAz9HH5+zmE7x/2C9hvJL0WlEwWH8qlLA8uMcng6fL3kbprng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7609

On 27.08.24 08:37, Krzysztof Kozlowski wrote:
> On Mon, Aug 26, 2024 at 11:50:04PM +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Describe also the VMAP registers which are needed in order to make use
>> of the PVU with this PCI host. Furthermore, permit to specify a
>> restricted DMA pool by phandle.
> 
> That's an ABI break without explanation why it is necessary.
> 
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  .../devicetree/bindings/pci/ti,am65-pci-host.yaml   | 13 ++++++++++---
>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>> index 0a9d10532cc8..72f78f21e1e8 100644
>> --- a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>> +++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>> @@ -20,7 +20,7 @@ properties:
>>        - ti,keystone-pcie
>>  
>>    reg:
>> -    maxItems: 4
>> +    maxItems: 6
>>  
>>    reg-names:
>>      items:
>> @@ -28,6 +28,8 @@ properties:
>>        - const: dbics
>>        - const: config
>>        - const: atu
>> +      - const: vmap_lp
>> +      - const: vmap_hp
>>  
>>    interrupts:
>>      maxItems: 1
>> @@ -69,6 +71,9 @@ properties:
>>      items:
>>        pattern: '^pcie-phy[0-1]$'
>>  
>> +  memory-region:
>> +    description: phandle to restricted DMA pool to be used for all devices behind this controller
> 
> missing constraints, maxItems
> 

In fact, that was intentional: There could also be multiple region
specified here. The driver already handles this.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


