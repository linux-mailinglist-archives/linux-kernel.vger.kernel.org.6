Return-Path: <linux-kernel+bounces-571126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EABAAA6B97C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C51188B2DB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF8B22068D;
	Fri, 21 Mar 2025 11:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DIayluUq"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAF91F12ED
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742555124; cv=fail; b=dEpjnRor/1FCSNAN6EY6Uha0Rdtm7j3M8hlslrwolV5Ixx7lpoVINb8VKFtIFeJyJDKmy4luYjnCVMIVtQORWmoQ6ZQimpUx31cmDBajuwD+KmFtxzH+AsV5pj/B0vq8xmEhzqQjIHVTZL4Dr4oAWtJZmnBWRXTZNf+nklGAjM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742555124; c=relaxed/simple;
	bh=R+3wUFKQWWN4+NqVfXDsXl0z/H2CJzschRZl99V6hCw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=alWcRTD4uTA7VwK2j/voXTbZJvMZrpI7aBl4pLKlQF9U69qKHOR9+w4hPtUZyMPoBG8RDn0AODNwSFPJKBx676k3TySq2KrLMO/7gOxM9F8eP3FdpbLxnMxOu813K45upftM6WYva3q5kK4Jy7/WYq3FGemGKAvabLkgs3MA8F0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DIayluUq; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SAJ8wi8DkcIMDVBH8METo+LDNPJLEhMxkzuorR7/OdQEZrMcxs0D+hdNEhdSdLMiQ1QPDrlo05H5OlnacggOxyQKsKyMhEHhcAZ0NzyYmybZJq9jSpGrtTCWOkQ744HCZCEh//7WGZEi4qzw5h7HIP683HBggCXnkxy5jP9ZOC4gQkTaiXXjShf0RkGW+qFvc+pg85qjcoAdRZmfrCl8eJ+02Prh7XdhBNaJrg8rF3OCKlNqkpAWSegmFg0pz6jpkdYdo6g7MWcqV00yei5/DciPBqOdEZTT4hQqNC+GkU2H3M+7GZ7r/r987RIWd0ts7cS2OpryTr/Ga08v6xyUhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f43R9kd45DUl7sSJa5kcKkog2db3AsdjQgdpSAbKlu4=;
 b=L7GyHV5OtsidZThcOD1WpXmMeUtf3vfwcLwtCOZwnwqmjkis/Ychzq3ViOLDYYbxLZrCPQ9ie1x9l0ogBLjN/kqMNDomnSLkYNM/BgC+5uw2pAeKJ18dXsOy9Wy5TvUf7cG3KfHYqmvJvB2Z7Ln3EzVDdq+LFF7J+rvU7yMZyO7UPG+HzbSnXnX0nHP+gGa8rJ2IkuLQ2930+iNXjZUK4Kzc5vSWqrguBLFCcXetcMaS9iwAK6YIlkR7xJRxzurW6b0leY7s8mVYJAw0NTVd2f87wwn3pg7EPPyBn1JeTHzkHR+KMh2li+YYU03haxY45WfJMHBLfDac1vH/9Kl37A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f43R9kd45DUl7sSJa5kcKkog2db3AsdjQgdpSAbKlu4=;
 b=DIayluUqyodXR6y7HtjcZZYcxEPoNIXxt2gc18UG+4MHkyyxpwGP2NlR0I8INvzeLwBRyotnjYC8FaEQVCCnvi+cEsf7eHfsZyHAPxLmXuXxHDMw9pR/zEidXgHqpK5lWrfKPDPV6hOwbXBXhkz31d7JhWX/MxebL9i66i2hjms+mUaLWYdpxFplekTvF8jo9EL5BqMcJ3qPXx2t+PSAtOhiLN4LbF7Wx5ttLRqTZIdbaKijwXXYiS4BU14NlZbATmwzIZcRPcb1FtN8qA+hICWcU7DiSb3dXZDFzMBtD/sZpsSM/PNEgHoD/RXmh0svM8+Rf57xydpDBznyAsZYNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 by DS0PR12MB7535.namprd12.prod.outlook.com (2603:10b6:8:13a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 11:05:20 +0000
Received: from SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868]) by SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868%6]) with mapi id 15.20.8534.031; Fri, 21 Mar 2025
 11:05:19 +0000
Message-ID: <01414c31-82c8-4de7-920f-87020610580b@nvidia.com>
Date: Fri, 21 Mar 2025 22:05:15 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: commit 7ffb791423c7 breaks steam game
To: Ingo Molnar <mingo@kernel.org>
Cc: Bert Karwatzki <spasswolf@web.de>, Alex Deucher <alexdeucher@gmail.com>,
 Kees Cook <kees@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
References: <fa8d5e76694918bdaae9faee9648776f298f78ca.camel@web.de>
 <7866593f-0322-4fb3-9729-82366940fc85@nvidia.com>
 <a168e78b-ae27-4675-8821-0b1a2499b2b2@nvidia.com>
 <5d34bfc5109b8d104fd4f8550dd17945344f9d07.camel@web.de>
 <551b9797-20d6-4bfe-b54c-84dd7aae7794@nvidia.com>
 <CADnq5_Pvmxa10dJWYjajwxG-0Y_oxhL6wS6NsG2F0dmcJS6o8A@mail.gmail.com>
 <9be36dfab79b17e108f71d51a6ebf39073e110c6.camel@web.de>
 <b5d80ef2-fd5a-41cc-9184-6c82226c330a@nvidia.com>
 <Z9vZYIbXOz2wF59j@gmail.com>
 <2cafd3e1-9265-403a-9854-7200d84ca397@nvidia.com>
 <Z90-VOyC5oanCC8z@gmail.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <Z90-VOyC5oanCC8z@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0066.namprd11.prod.outlook.com
 (2603:10b6:a03:80::43) To SA1PR12MB7272.namprd12.prod.outlook.com
 (2603:10b6:806:2b6::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB7272:EE_|DS0PR12MB7535:EE_
X-MS-Office365-Filtering-Correlation-Id: 84d3fddf-db69-4703-a06f-08dd686844c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1RZSUU0V3UxQmljZ1BNeVdOUGdpVHBZUXQ4MGlxNngrTlQyT1N0UXpCZXlL?=
 =?utf-8?B?dHNEdUplTVprNFdHNmRTaHZPeE4waDZTQzVERyt4d3hmRU9aeEQyamZHN0JL?=
 =?utf-8?B?eVJoZmt0T1BCdkEwQWNtTlJLYmlMdTM2cGVsNUZnWkcweFp5YUdGYytva2tF?=
 =?utf-8?B?SzFiNWttQUpzVGZHQU0yS0NLVjRSVEZjOHZJamROSU1rcDZlRk9meWpHdnZN?=
 =?utf-8?B?SkhJdjhWQUY4Q3A0ZlExN1A5YVlpR0FFcThVZjlCNHEwREV3eUVBNkcxRTg4?=
 =?utf-8?B?STd2OFhHTG43dCtFS2QvclRicXhTb0RTeEtqUS9wZ1R1ZWVhTjR0UDV2b2lq?=
 =?utf-8?B?TDhLcDJuSXh1TmRQVUtMNVJNZkpkdTBWRHFzQU1uREFFZ0RNK1hCUHp1MFlD?=
 =?utf-8?B?dFNPdFF0dmZNYTFRaHcxUWMwbzV1VS9oKzVMZjYzRnBGSFBZVTRDQThSbUVa?=
 =?utf-8?B?Z3FYOUVpWmRHcXluN0hMcjBZdkM1L1hKVXpjS3JuektyVFJIdGN4a0RXeFpw?=
 =?utf-8?B?cFo4MzdJRGw3Qk9vOVJuZWNKa3k0ZWhlMWtYOGRqMndFbUtlUmxIQzdhRjI2?=
 =?utf-8?B?ZmIwWVcwS21qTmN6c1NtSEZmb1FQa1VoZ2JCeGNLeFNKaVd4VDRYdWhtZmlJ?=
 =?utf-8?B?SHJvNFFDSHdkakFETVptRHlhbnFIVmt6QmI3Qy9YY08xS25lY3AzNVNNQjBn?=
 =?utf-8?B?Nm53MW84c3NkbVBFbC9sN25WdmsyYTd2OCtFcUhXWFh0QVVVZjR2RUVkSFZX?=
 =?utf-8?B?RUJlekRSajN2N0pwQU5TdW9mb3lnbUhXS28yeXF3eWVLQTVzeG5ITi81K0tH?=
 =?utf-8?B?T0V5US9WVjF6RG1UTzlEYzA0ek5SbnZUYkFKSGpPdDM4RVFCaW9GaldjeDVr?=
 =?utf-8?B?U0ZQYi9UdHllSitrTXB4Q2R0NWtHMXRBOEZsTU92TDFFdGdqcW15VVlkeXpG?=
 =?utf-8?B?TThGM2NpQkpTelYyRnQ3SVV6YjJmYlFCM2o3c3R5Mjd2QkxsNmQwR2lXSU40?=
 =?utf-8?B?NlhOVjY2bE9CcTdySk5LOVpwRzlkNDFOT1pmb0FDQWd6S3VMcHJabi9ZRnVv?=
 =?utf-8?B?VU9wcFNlNGZEZXJ3dW1qREd2bVVWZXZabDhrbTFIR3JKSnpnQnFKa1Q1SnFo?=
 =?utf-8?B?N0txUDZiYkt0QWNmckNtQzQxOFVSV2lST05ydjRGVkRYd2c2VDFmUCtCRWt0?=
 =?utf-8?B?b3h4MFBLSlR3b1UxK1oxTVUzSzhXZ25FR3gyd0FBOHR2a2huVVhQQ0l5cENi?=
 =?utf-8?B?NGZMcTQ3MU9tS3lZRTJRbFAxZDVhU0dMWWY2bzdkaDR5ZUozVzVLVHRJNndE?=
 =?utf-8?B?a0h1SDkxQUhOcldMWkczampIZnF1eE1xODlQdnhSeDFJSUk0Rlc0c25rOE1M?=
 =?utf-8?B?ZnpZaFF2VGFtSWFEN2h5UllONllYWHFrMGxDSXVHK0l2bGhnVndnZWJkMy9v?=
 =?utf-8?B?dGRUMnFZYVdheHd1MHhTN1RHdWd0VHZXcXlTaUUrZ2xxMmQ5bEFjV25wWjZS?=
 =?utf-8?B?SmRvWU9FbU1sWnJ4Skh4cWtSeGxmT0MvTU5LaUtxbGxIaUQ0OFhwWFBkbEx1?=
 =?utf-8?B?SUFlYW9tbEloWk9ObTdGbnRmMEJ1LzNZYTg4c2QvYk5IcUxoK1JUc3RsNEta?=
 =?utf-8?B?Z2VHUlpTU0hIcmQ3SllySitFZjhJemQ2Vm9VUkF1aEhHdXgxM3E0aTdSMU14?=
 =?utf-8?B?dTZId05MOXdUY0hkNWxETGVnaHlSdEhlRnk4S3l0aFpBSlZ1eXZCQ24zcFdQ?=
 =?utf-8?B?a0NHRGwwQjBKZ1RXZWs2OVRwTFVaMFRidXNlcnNTR3Q2MXhnUmJkQnM0cWZ6?=
 =?utf-8?B?bXBWYis0N1M3dmYxb2xNVTRsRm1Bd0ZIOG5lcFRWdlppRTBMc0kxSHk3UC8x?=
 =?utf-8?Q?AFMljEb5zxlF4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7272.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGZEMGN6SDdLQ3BBZWtEZytzd2FxUUFxMzVwVW85K2ZmU0JmM0lybWdNSVpm?=
 =?utf-8?B?aHZYTHdTejZYTXdRamZ3bjBicVhaM1hycU4xazd1Y0dkVHR2QzBlNnlBUFZq?=
 =?utf-8?B?Tklyd0M5b1Z4RjBiRUJZblZyOWs5clhUZmc5OUdUWkcrWWY0dEFIVDVnTUpS?=
 =?utf-8?B?b3cwemFmT2srTVNxcTZGTWRRcFpPeEpxbjNQbGo2c2o5ZVJUYnhmL243MjFV?=
 =?utf-8?B?YWlsbGcwTUhJRHFkV04wZkdIc0l0MW1LWXNOZW5PN2o5cm9hNGh5N2ZaWEk0?=
 =?utf-8?B?dDQ2Q2dlNDEzZWxYL2ZUSWxGV2g1T3Z3M1l5dVRjUFFWeVpaR1p4M2xOUUtq?=
 =?utf-8?B?UkVxOG9tanMxNTRZMU9RSjJWZVNLSmxJUXV5Y1NPR3ovck1tVGxyZ1BjSE5Y?=
 =?utf-8?B?ajhvNGtTOG9QLzlQLzhTY1VNdk9GOTlmcmRJZmNPTTZKWkxqN3JCa1VJN0lQ?=
 =?utf-8?B?bTBIcFBHS0UwNWpQZXAyMFNzbEtVYytMUDFXMzdoOXNOMXdJeXhwYzBQZ0NE?=
 =?utf-8?B?RWNoendTd2lZN1ByMHk0UUsxUmhYSzY2NmJodWxtTnVocVpXT3k2Q0oyWEZV?=
 =?utf-8?B?b2d5OW1ZMDMzb0g1MXRldW5kcEYzN1ZPY01xK1JhYndKNDBFME1NVGFyZ2VS?=
 =?utf-8?B?OXVJNkRkalZzYkMxUGlybjMxUVBpWUY1Y2w5TmVoT2YrZjNTb1RWTXIyaC83?=
 =?utf-8?B?MVQwbE1tQnVGN0cvUEVSYXlUNTU0eXY0ZGEzdXlXN1hscmZ4ZUVIVEE3K1Bk?=
 =?utf-8?B?QkdsUXFJTDlwRnoreEhUSkhmTzNaNWFwelhxdHoza2E5RUtVUVd2dzFaZ3d1?=
 =?utf-8?B?K0RxeFhtZ04xYmZCUW9XMEJhRFJsb3diclBKZldwZ2tzbnBhRUFtazZqYXFN?=
 =?utf-8?B?MkJCWkhyclczN0xvbzdGTlEvRXk1OEIyUHZXeUVVc0NmY0x2Q0dlWFFoRTRK?=
 =?utf-8?B?VEZuZGhRMytyN1NHQzAwZmlFQ0xLcjB4VmFyVGZSaFcwcjlBVlh2a3RKOGpL?=
 =?utf-8?B?UWpuSnFJeVdPZ2pXNTF1WEpTb09wY0hCMzZOb1M0VTdMWFMzSjVSakhZaDZ1?=
 =?utf-8?B?RUNldTgrWVhsWENUaEtzTkRqcG5HQ01HTllBN3RWSmdEQWZrUzZiWTlTZlR6?=
 =?utf-8?B?dEFURGI0cFQ3UXhQTGkreTFMaHpBQU5SV3Y4RVFhc0d5eXlJT3FpamFLV05U?=
 =?utf-8?B?alZrWXo1aGxmWUdrVk5wM2Z4aUkvS0x2V2JTdUwwQjZxL2kwVkRjMVdoYWNM?=
 =?utf-8?B?VVNMNGFqWWNoRXNsZklpbFRuNjJuUmM4L3lZckNHUEcwN3VkWDNKNWs0UEp1?=
 =?utf-8?B?dGlxbUIyaE5Db290MXBBZURFRU9sSVZuMDRhZlNCb2ZIa1B3TzRTMkIvVmFM?=
 =?utf-8?B?czQ5dzB2RklodXc1WTdqN3hFRE91cGFUTy9xQVFnRFdLVGRDYlFtTTloV3Ra?=
 =?utf-8?B?RnhzbHJzdXdCQnVsUklXVzd6YzdoUW9oSEQ0TkJXdFgxL05BS3VPcXE5L29O?=
 =?utf-8?B?WFF3OTV3a1ZzRkNWYW91S2dSN08vUTNUOU50ODk4dEhUeFhsN3ZRUzd5VE9K?=
 =?utf-8?B?aUx0SERzYm1tTlpsMnA3YmV1Y1BZVEhpM0tUSHVXMEczR3hveHVadGVhOUVW?=
 =?utf-8?B?NnpkMHZiRkhWajl2T3REdW1YSllJcHJhSjZFdkc0RnN1d2M4OUkxSjlRbGxH?=
 =?utf-8?B?OUZ0UXB5azJrZ0I3a0Vwa2RhL1VwU2UzenUrTnFQQWMwNzUrUmhQMHVzdzlD?=
 =?utf-8?B?Z2IzQXRSS05iZS9qM1lqSnpzTlE1UVBKV213TFlWV3ZzQ1g2TW5md2gwdWl6?=
 =?utf-8?B?bVF1R2lmcHBLajZmUlUwQVdxTlhpYk9uZDJSbTRBQ0lBcndqUVZDM0JmdzFK?=
 =?utf-8?B?aU5MbUsyMjdYb2czRlNsS1BzSzBhWGlDZmxqUk5nNnd6YUtXM2VQdVpRdHdF?=
 =?utf-8?B?M0JuL2ZhSS82VC9EUVhNRFFNWDZFNXd0bkE5VnNUNCtqSnB2V1FRL1V0T294?=
 =?utf-8?B?Vk1Da0Q2TDBmdmFWODZKelNOL0UzRk40K0NBeXNTbllYVHdIMm1GenRkbDV0?=
 =?utf-8?B?V096VmdhczRzdlkwZVMyRWo1eXErelRRa0s2ODk0WkhWb3YvMVlDaXdkUWgw?=
 =?utf-8?Q?4lA8W8tBCkREFCVSZe5/2nZzv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d3fddf-db69-4703-a06f-08dd686844c9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 11:05:19.8205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELssnvK9DpzBexs/01GghQFdRcfd0T5j9OTkL3/yhlHayWwj+4Qts3osBgGu+7BsEmTwJTj1CoX+lDuTHUzRsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7535

On 3/21/25 21:24, Ingo Molnar wrote:
> 
> * Balbir Singh <balbirs@nvidia.com> wrote:
> 
>> On 3/20/25 20:01, Ingo Molnar wrote:
>>>
>>> * Balbir Singh <balbirs@nvidia.com> wrote:
>>>
>>>> On 3/17/25 00:09, Bert Karwatzki wrote:
>>>>> This is related to the admgpu.gttsize. My laptop has the maximum amount 
>>>>> of memory (64G) and usually gttsize is half of main memory size. I just 
>>>>> tested with cmdline="nokaslr amdgpi.gttsize=2048" and the problem does 
>>>>> not occur. So I did some more testing with varying gttsize and got this
>>>>> for the built-in GPU
>>>>>
>>>>> 08:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
>>>>> Cezanne [Radeon Vega Series / Radeon Vega Mobile Series] (rev c5)
>>>>>
>>>>> (nokaslr is always enabeld)
>>>>> gttssize   input behaviour
>>>>>  2048		GOOD
>>>>>  2064		GOOD
>>>>>  2080		SEMIBAD (i.e. noticeable input lag but not as bad as below)
>>>>>  3072		BAD
>>>>>  4096		BAD
>>>>>  8192		BAD
>>>>> 16384		BAD
>>>>>
>>>>> As the build-in GPU has ~512 VRAM there seems to be problems when gttsize >
>>>>> 4*VRAM so I tested for the discrete GPU with 8G of VRAM
>>>>> gttsize   input behaviour
>>>>> 49152		GOOD
>>>>> 64000		GOOD
>>>>>
>>>>> So for the discrete GPU increasing gttsize does no reproduce the bug.
>>>>>
>>>>
>>>> Very interesting, I am not a GTT expert, but with these experiments do you
>>>> find anything interesting in
>>>>
>>>> /sys/kernel/debug/x86/pat_memtype_list?
>>>>
>>>> It's weird that you don't see any issues in Xorg (Xfce), just the games.
>>>> May be we should get help from the amd-gfx experts to further diagnose/debug
>>>> the interaction of nokaslr with the game.
>>>
>>> So basically your commit:
>>>
>>>   7ffb791423c7 ("x86/kaslr: Reduce KASLR entropy on most x86 systems")
>>>
>>> inflicts part of the effects of a 'nokaslr' boot command line option, 
>>> and triggers the regression due to that?
>>>
>>> Or is there some other cause?
>>>
>>
>> You are right in your assessment of the root cause. Just to reiterate
>>
>> - nokaslr does not work with the iGPU, specifically for the games 
>>   mentioned
>>
>> - There is a workaround for the problem, which involves reducing the 
>>   amdgpu.gttsize
>>
>> - The patch exposes the system to nokaslr situation (effect) when 
>>   PCI_P2PDMA is enabled
> 
> Note that every major x86 distro I checked enables CONFIG_PCI_P2PDMA=y 
> and also keeps KASLR enables, so the above qualifiers are immaterial in 
> terms of user impact: it's a 100% certainty that distro kernels on 
> these systems will regress under these games, right?

From what I understand, the impact is on the integrated GPU of the machine
for the user. The discrete card works without any problem. The impact
scope is mentioned in

1. https://lore.kernel.org/lkml/146277bb0ecbb392d490683c424b8ae0dfa82838.camel@web.de/
2. https://lore.kernel.org/lkml/6b0c9a4d840757ee54b141ed26f4e81c3e4eaacf.camel@web.de/


> 
> What is the importance of the original fix? I should have insisted on a 
> fuller changelog, because it's rather thin on details:
> 
>   If the BAR address is beyond this limit, PCI peer to peer DMA
>   mappings fail.
> 

The issue I ran into and was exposed to was the following:

- On systems with PCI_P2PDMA enabled, the PCI bar space for the devices
was above the 10TiB limit set up by direct physmap reduction in KASLR.

Basically pci_p2pdma_add_resource() fails, because pci_resource_start(pdev, bar)
lies outside of the direct physmap region and devm_memremap_pages() fails

- The only way to enable PCI peer to peer DMA is to disable KASLR. This
leads to a less than desirable security posture. So using PCI peer to peer
DMA becomes a security tradeoff discussion.

This patch keeps KASLR enabled, with lesser entropy, but allows the
PCI peer to peer DMA mappings to succeed.


> How frequently does this happen and what is the impact to users if this 
> happens?
> 

It happens a 100% of the time when the BAR space lies beyond the 10TiB
region.

> We might be forced to revert this change if it regresses other systems.
> 

I am quite surprised with the select few games that are impacted and that
the rest of the ecosystem is not impacted (from what I understand).
The issue is also exposed with nokaslr, I think we should get the bug fixed
as the issue exists, but is hidden by kaslr. It exists on current kernels
as well.

Looking at the dmesg logs shared by the user, there was no warnings/errors
that caught my attention.

Thanks,
Balbir

