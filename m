Return-Path: <linux-kernel+bounces-562608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E76A62E1C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 15:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65BFE189CB5A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 14:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431F31FFC45;
	Sat, 15 Mar 2025 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pGCQz3f5"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13220AD51;
	Sat, 15 Mar 2025 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742048771; cv=fail; b=knVBQjtdDFaUOcFTfRUDuHUOMxQncswPCi3R30Y/02wclRXr5nTRYsXkQ93oOzbKCZsqHNUmNkOulxOv2YPfCGUU2euXZdNIMFW3asds4/cUTw55vbvwnsq3QpanCyC1I4vnAy0cls+mqAH8O60RDpEF9FQPPH0bh5CV47wCxFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742048771; c=relaxed/simple;
	bh=SXoUeEJd8Y/yJ7PP5L4lbe7PXO1Hqrl0u71WZWdw5es=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=jSfLt6jsnMmq5nnkJSI0p+cZkQZRzCrBXirO5AZY1pD0XcZ8B+u7blOf+YBz6ulg6DuCCEGzxlOxsB/6HodZFgZVUTwGEhTSnRm+McDgHaq4s5dOETqavdFxcXdxCpkWWncME3bffKw3W2vMvT76ijNu3NDwUgrQB3RbeyA+vQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pGCQz3f5; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYwsj07Ls3XwYabkuMK0mSy/JVE9hOPzFWb4pVFB6RP9EQq+Aw6h+XFq7jKmvSxWDmu0bwoa6oTfja1MdRET43c15qnjjSeWRDFfoeLIYYF8Ot2xAiTIiO7SSM9vAR7sB4S4RpYDbChsgzvOXSYkH0SY69jXDzPQcOVfajSFCo79BG/z/kEx7s4Or+kOu/06lSNA1u+nUwYORbgSWZPQgonzPDtAZvmyN9f0/9AvwAsRsJor2nc4fL1sGyRr4GfS2y/mAPgsJ95/d86naCefrM232OKM4A0XaY7sU+p7F/IAIROypH8N5iOk6sZE9eGuFnnyPUdDw8V58o4aYJROvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYuRrRuchdf7lvt/AT6+4DMWtfGt9Uktp1Oo4mUy0EI=;
 b=KPP9F87dXJMx1xWsUgnLULyFNOQ9xoa0wq/GeGR4QRbjrfAk7PFkI1GGi2ygxDep9WUhv5idw4xKesZRLXEaOy/D7Yur/LYkGnNLFn+Gs+ndSnrnQgUiGqJKBrvSsgwqkpMJeHy4Ld/7SaxcyeLyVwf01Fn9/8hbeNihVix4/we84GuOfW+rpSCrEHtddEQBWhU25SKqA6xGqYXljAX9azOw887z+QsD/uGj75P7GjS+TkdBqPD5Xlvh0VQJTsc4rltPnBjX/FnVmTIHcnxS6VYXt+N/j/YLq2mxyDrVj9956xV6o2RsgfrQC2jo3ZJQZry4NmV/UVlgp4OD9GaKBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYuRrRuchdf7lvt/AT6+4DMWtfGt9Uktp1Oo4mUy0EI=;
 b=pGCQz3f5/00MH8xeSOJWCyjsmgeP16KkMVgEguIA/Bb2twE08hgaNMNpNZ/J2DK7CqJ/3kqWa6zySoEv53ANIsUfOYr2WHWRYXhPEEaceQZ3yuM64Hlkv2UkQlOZ2wwh3SFsJFbJIL81jL7Ky36jWpoax7KIADmDPbTbRkfJpXy5p2cnW/+qIH2OX1msJEXrTgTUscBivtyAwKQo9eiAA4Qx10rgbHCFcxgKNZ4MkztNlNi8os4+FP7Jx+w0Vg6d2hlVDyqPUJNp3geqJPAt0qJfc4TueWSGgkfRbFlVCgdWBcIZHp1TF4Wc0cuOFXJ4ZvvGjgZBuP2NO2681DN+4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BL1PR12MB5972.namprd12.prod.outlook.com (2603:10b6:208:39b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Sat, 15 Mar
 2025 14:26:05 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%6]) with mapi id 15.20.8511.031; Sat, 15 Mar 2025
 14:26:05 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 15 Mar 2025 23:26:02 +0900
Message-Id: <D8GWQXK312SX.2RI3EOHM1QGG3@nvidia.com>
Cc: "Benno Lossin" <benno.lossin@proton.me>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust/revocable: add try_with() convenience method
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250313-try_with-v1-1-adcae7ed98a9@nvidia.com>
 <D8F7D2RPRVAO.2EF39MZXM6FPR@proton.me>
 <D8F8E4PBHK7O.399Y83M1L3XK3@nvidia.com>
 <D8F91L51P2EA.2FBHGJYSV06HY@proton.me> <Z9L-Z4Aw64Hi5Lj8@pollux>
 <D8FBUHBNPIEL.5A8GOEMPJSEA@proton.me>
 <D8GWCWYM15WI.3II7R71LIAEI9@nvidia.com> <Z9WL-95sJ0DCpaPa@pollux>
In-Reply-To: <Z9WL-95sJ0DCpaPa@pollux>
X-ClientProxiedBy: TYCPR01CA0019.jpnprd01.prod.outlook.com (2603:1096:405::31)
 To CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BL1PR12MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f68e281-8957-43e0-97d9-08dd63cd5234
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDZKekdhbWJRL2JPalNyRVlBdnNTd0lZbEVxOURwbXZJdkt1TTNEOHZlR0s0?=
 =?utf-8?B?UUpJMUZqd2tCK3poM2NlZlpvYmlFYm9YeFMzdmxJUnVCTzY5NUhTamlSNVZJ?=
 =?utf-8?B?Vkk4YnNZVXFYcmRUcW1Rdzk3T3pQQnh1cms3MGRCeE9nU1RkRExvUklodjRv?=
 =?utf-8?B?U2VyeWJEaTNxbEpERU01N3FIcUxlYmZtNkJHQ2VRbklXTjdSblh6V2tZVlhQ?=
 =?utf-8?B?SnJmS2krbWlzdTlVQU9lS20xdUN6cXo3TlUzZFFkd3ZjYzNxTjFpQVNqNXdO?=
 =?utf-8?B?WDlXUis4Q1daRUxkTXIvRXRrYzFSZzZWLzRSQ0tPQnFtMWFZTGhybytUM2dW?=
 =?utf-8?B?RlUycGxFRXFhZTJZeGZTdTUxK3BUb1ZYOVFuVTIyTXI4TFlFeFhlVzFuN0dX?=
 =?utf-8?B?MHh6bTUxR2ZjTUhFeFY4dFBGTmU4QmU3YXlPSVZWNGRENUdmZlErbmVJQmZ3?=
 =?utf-8?B?dFdMZEJOclRRRFVzZlFjWkhMNDc5NkdTVllFVlBBMytpRjZac0ZQdmVleTdO?=
 =?utf-8?B?dDF2YjNzN0xNbW5hSkpoTFJka2lkd2RheGFrQTBNU21DNWliN2NuN0pOajNL?=
 =?utf-8?B?dXRZSUFYZkxEODEyUnBMaWxGa3RuYnBFOXd3VHdRVWVUSktVV2pqUW5DOTIr?=
 =?utf-8?B?cVlRQWJGWDIwckxMall0TmhQTzVBZ3FZcU5KbDRjaGgrc1A5WmNMcEkvOUVP?=
 =?utf-8?B?eWc4VDlGcSsvQzA0MkpOYlVlOFJhbmQ5bEoyRDFBNnVRR0dLRkpKam92ckNJ?=
 =?utf-8?B?QXhjSFVwU1hrc0RLU1JVMUpJUjN1NXBpcytDWnM0a3VqQTRhVG5UY3JKY3U2?=
 =?utf-8?B?NnNpOTJMeTVhN0xvY0x4cCthZnYxdE9COVVtZm1nNmZWelZ1RE1ZTXhaUzlo?=
 =?utf-8?B?dm5UVXFYUjAzYjFSR2ZmWDAvbnhaVGg4VHAxQ3grREpNNzJxVG9EbThHeG1Y?=
 =?utf-8?B?dTBRcEdzOXMyVTVEM2lqeUFNQytBSGtVNit3YVdNZHdISkJIc1JkWGxoeEpq?=
 =?utf-8?B?NmluY0gzbStiN2lMYzVJbWVmYmdTdDlneGZUajBUYndCMHNvdm9aajA5QWNE?=
 =?utf-8?B?bENkTlFoTU0wVEFSUkYxZFZLQUs3RmJBbHVxb2p3YnBaMlFCbE9QcDIxbTlm?=
 =?utf-8?B?L3lIOGdiZE1UcDlXUmU5OHh4Qys0RUZXZUs4ZUticWQ4Nlk3NjJ4Q1NBSUsv?=
 =?utf-8?B?UXR0SEdQMHFUczNjRzB2SSsyY1J6d2NBdXd5YWptM0E1ODZCcUFEaUY3R25z?=
 =?utf-8?B?aEw3aHFEcUphSkNtcnUvSlRkNGJQZXFrSGpLN2JpZWJ4cXZHLzB6Snhldyth?=
 =?utf-8?B?MkhEaUhpa3Ezd28yWlR1V2tkZ0Fad3Q0Lzk2NDJkb2ZOOG9nb3JLK0VnSjFy?=
 =?utf-8?B?VXhJVFdRRkQ1MXZpdmRsSjFDb3p0R3NMZDVJK0RjYXR5RXozVW5ySU1uejhv?=
 =?utf-8?B?MFVUbFlaNG01MUplWENYczVvbUVDS0RiNkorYnZnbm41Umt4S3ZuRU1RMjF0?=
 =?utf-8?B?dEx0eGFTeExVSFpUWHhlUG5DR1Zubk1XKy9sMEt0bnFvc3l4cDhDR0g0aTda?=
 =?utf-8?B?azdIL2xWSDhJVDQ2eFQ2TlZDa1RqTzdmWTd4VWZuY2VwUDhTeXZPemhFNm00?=
 =?utf-8?B?UVRXRnlrTExlejhHTXNwdTVLWk4zTjFGSERtenpEcVQxSWtTRzU5aU5EUU9O?=
 =?utf-8?B?Q0VKNTJQVitXN0s0M0h5ZkFLUmJNSVVtclc5cjN6SldMZEdXNTY3NlRwdmZR?=
 =?utf-8?B?UkZ6QjZSNlJ2Z3FOTXdISlgvYVgyOUN5RHkwa2FpdHMwNTVFT210djZVZnRG?=
 =?utf-8?B?ZzFQd2J0YXdvb25uUWk5SWF5M0Job2M0VWtFUnVXeVVQNjFmVHM1b0lrSkQ1?=
 =?utf-8?Q?pZCSsDnwlXSs8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1ZWUGVuc2tlMVZiVnlNZTV4aGtLRnoxeXZQRkx3UitIeWZzU1NGYUFJeHRh?=
 =?utf-8?B?WCsyWjVtcERSaDg1Z2RqTFlkSjd0RFdoRExpWjNWYWpveDhNV1YyM0pQM3cz?=
 =?utf-8?B?QXN3NnNpb1QrUzIrVy9SM1N4b0ZxU2IvL2xtYjRZT3ZWK00rUEdyeWZhSWxJ?=
 =?utf-8?B?UG1OZHdDblhZdTdiempHT1gzL1dNUXptaHM4RE9VYjVSTFVwVjFGaUMrQkVh?=
 =?utf-8?B?bHlKYXg5VkNiRTBmRnJWSlNvalJzdWNvVkxncnVWcUYzQUVJZk5JQUx5Ui9W?=
 =?utf-8?B?M05IWkxUTGQ1YXlHR3ByNEFWbStlbkRyU01WMG1DVEdZQnZmNTIwcDhJaTc4?=
 =?utf-8?B?T1NCOGxDd3BPOHAzVEhGN3ByK1IycUxoUWEvM0lHQmhFYjNobU5XemRESnky?=
 =?utf-8?B?ZWZEZSs1RVV6YXBBUGtQTkRPc25qQkt2QUtIL1hUWm1tV0haT2xYMkgycUVV?=
 =?utf-8?B?dDdLbWR6eHcyZHdPd1hBbEhXQWFqVGY4cTczNWtPM2ZnS3pUaFBDbm5CaC80?=
 =?utf-8?B?VzROSWZzQlAwK0ZpYlA0UXoxdWRINElTWVFuWGZNY1pzOHZSVEQ5U3ZLWk05?=
 =?utf-8?B?WEhoTmFNYWFBV0h2REFNR0hVYytHSno0MTRzV3FqRE5mRkY4K1ZKTU5qTEht?=
 =?utf-8?B?bWpjVEF5cG5ZclI0YjdQemRXRk9jMDZqd2diR21qSVRKVFdqZ2xPVHhlWnRO?=
 =?utf-8?B?ajlEWkY3SjBhWXh6VG1Kb1p2VjZEemJHaEQyWTJZTWZKVGlrM09mVHB5Ykl1?=
 =?utf-8?B?cGVTNVhrNjBnemd5MG1FRkFtSXZ4TENxRU5NZ3BiSzQ5dzV2WUpYaG54Y3RL?=
 =?utf-8?B?ZHJ2azgvdnBGeFBUNm1DRGpHRjhoMHZBRjJtNEtnTk5BQVFUQTVhRldqR2Vo?=
 =?utf-8?B?cW5yZFJNaVlTODFaZHZDMllQRnJuL01TOXc0OVVIRGZkY284Z3lWcURNVjlO?=
 =?utf-8?B?WUFFMG1uaGxSMEVKcUtCbzVTbUc3L3ZrR2FZMmVEUlFtVVIzN3JrOHJVZFBS?=
 =?utf-8?B?L0F2REk4c0pTOGJrTm8yMVZFN1czSnl5M2hyR1EwSEpTSTk3eUxhOFhIbEFp?=
 =?utf-8?B?L0g1TnB0emtXOXo4Y2ZLMncyVFd2Q2lCZlZ0aE12N25kV2dYWEk2cjEwR21k?=
 =?utf-8?B?S0M1VTU2L24vSUh6Z3FzVXdPMDVMREYvU3k4TUN6TVFrVW9lb09uV1lvU2NY?=
 =?utf-8?B?WFc2S29jQjRTUWd0Vk8wd0VlM0NMWHNTVHR1OUdwVk9FdFNsYjJZTnplS3lD?=
 =?utf-8?B?dnpibUVUSXlWb1I2VDFWNFYrOTRKMXhTVGdqNXp3YmF5SHlKdS9oQjZTcEVa?=
 =?utf-8?B?VUJJZmVkZEpBOGdKSG1FOWhsMTg3d3FtQ0RVSXNxMDVmck9TUklGWVR2amVy?=
 =?utf-8?B?UjJUVEVtOXZickRqWStKV1dxbC85a1ljR3JDNHFDMkZvVDZPMCthR2VvYnUv?=
 =?utf-8?B?ZmFHSjdEUzcwbGg0MXY5czYxMVkyWFpmNnRSTmlsdXp1Mnc5a2k2WkNMZ0hI?=
 =?utf-8?B?V2FwMk51Q0NoRWJTem82bVZLZzVuYk0zRW5rQ1NESHJ2bnNmQktSN0g1elhH?=
 =?utf-8?B?Snd1VVpKSGhXU0kwTHBaR0k0VFU3YTA1eTRiT1IrTlVRWmNKYkJvZTVCaWdL?=
 =?utf-8?B?K1ZSaW9vRVlDemYyMitWMS8xQW1KS3RESjJlRWVkalhYa2tBUDVkOXlXWS9B?=
 =?utf-8?B?MnNieHRLbHBpZzM3ZDBpN3luWE8yczdtNDR1QVVGaE1GRUJhd1I1WnZETU5X?=
 =?utf-8?B?bjhYb2hFSXdadGdkanBiQzg3Ukl5dmIvYmw2QzFHbTdTQjRwQS8rekEzZmZk?=
 =?utf-8?B?aGRzbEhwMHhDd0JPYVRXYlVPN0FPZ3BVZlVSeWp0Q0IzaUdvYlZKVXNOajhT?=
 =?utf-8?B?Q3pieURrMDVkdWlNWEdpbWUwT1RNcFJzSmR1eHpBSUdQbTVEWVdEaHBaM1E1?=
 =?utf-8?B?N3VjK2tHaHA2ZlYvOHF4VzZvbDMyWjY2NXc1eG1aa3ZtZzFIeDVmWlVwaU1h?=
 =?utf-8?B?NFBjeTlYdmVPanZ3UXl2emVCNEVNK1Vpa1ZiUnJPdlRDYVlDaXdNSE8rdGp6?=
 =?utf-8?B?SXQ3ZVVUVTVnMmt1SHluYnlWZzBxQWxmdTVoYWRlelNNeVJDV3AzeDgwN29I?=
 =?utf-8?B?SjNsNFozbGsreitFRzZibm1sb2w0V2JzSG0vNkVRc0pndGpVSjU3ekdIVDAw?=
 =?utf-8?Q?g3oa2qF99SNjy4gLQXE3saaKyj9VdANOcmCMcef3o+co?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f68e281-8957-43e0-97d9-08dd63cd5234
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2025 14:26:05.6228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IGpvE6F25aw8qe2tBnm8OakLJiY9HOh9NbZ6VTn3czyQaJSECusD/8jaDZkfwIuC7cVPiNirGWIwHZzj/fVuGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5972

On Sat Mar 15, 2025 at 11:17 PM JST, Danilo Krummrich wrote:
> On Sat, Mar 15, 2025 at 11:07:44PM +0900, Alexandre Courbot wrote:
>> On Fri Mar 14, 2025 at 2:50 AM JST, Benno Lossin wrote:
>> > On Thu Mar 13, 2025 at 4:48 PM CET, Danilo Krummrich wrote:
>> >> On Thu, Mar 13, 2025 at 03:38:55PM +0000, Benno Lossin wrote:
>> >>> On Thu Mar 13, 2025 at 4:08 PM CET, Alexandre Courbot wrote:
>> >>> > On Thu Mar 13, 2025 at 11:19 PM JST, Benno Lossin wrote:
>> >>> >> Would it make sense to not use `Result` here and continue with `O=
ption`?
>> >>> >
>> >>> > We would have to return an Option<Result<R>> in this case. The cur=
rent
>> >>> > code folds the closure's Result into the one of the guard's acquis=
ition
>> >>> > for convenience.
>> >>> >
>> >>> > Actually, I don't think I have ever used try_access() a single tim=
e
>> >>> > without converting its returned Option into a Result. Wouldn't it =
make
>> >>> > sense to do the opposite, i.e. make try_access() return Err(ENXIO)=
 when
>> >>> > the guard cannot be acquired and document this behavior?
>> >>>=20
>> >>> Sure, if you're always doing
>> >>>=20
>> >>>     let guard =3D rev.try_access().ok_or(ENXIO)?;
>> >>>=20
>> >>> Then it makes sense from my view, maybe Danilo has some other argume=
nt
>> >>> for why `Option` is better.
>> >>
>> >> Most of the time I think we indeed want to derive an Err() if try_acc=
ess()
>> >> fails, but not with a specific error code. The error code depends on =
the context
>> >> of where the revocable is used (e.g. for I/O mappings), but it also d=
epends on
>> >> the driver semantics.
>> >
>> > In that case a single function with this signature would make sense:
>> >
>> >     fn access_with<R>(&self, f: impl FnOnce(&T) -> R) -> Option<R>;
>> >
>> > If there are common usages that always return the same error code, the=
n
>> > we could add them as functions with `Result`.
>>=20
>> Yeah the more I think about it the more this seems to make sense,
>> from a strictly logical point of view.
>>=20
>> Where I am still on the fence is that the goal is also to reduce the
>> friction introduced by the Revocable business, which a large driver
>> might need to interact with hundreds of times. If the user wants the
>> callback to return a Result, then this method will return an
>> Option<Result>. One would then need to ok_or the Option, then flatten
>> the two results, which is a bit verbose.
>
> I think you see this from the perspective of one specific usecase, i.e.
> Devres<T>, where T dereferences to Io, right?

Indeed.

>
>> I suppose drivers could add their own macros to do that automatically
>> and reduce code verbosity, at the cost of less cohesion across drivers.
>> Guess I'll go with that if I cannot come with anything better.
>
> Maybe we could do something more specific but yet generic on top (for the
> use-case above), but we still can't assume the exact error code a driver =
wants
> to derive from failing try_access(). So, maybe a driver specific wrapper =
is
> indeed what you want on top of what this patch provides.

So be it! It's not that bad and more flexible in the end.

