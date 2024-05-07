Return-Path: <linux-kernel+bounces-171878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB1C8BE9CC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF05D1C20CA5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719A7200D3;
	Tue,  7 May 2024 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TAu9tEDs"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2050.outbound.protection.outlook.com [40.107.212.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E0BC148
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715100830; cv=fail; b=ZzI1xj+X8Jn0SCxvhQ8zFzJYPrlSL4j74b3sIUCV7NEYUsQzeI8xLt0Hvx+wsQ56nAvjAoPwKY9VJz06hCLOZf5bGGV1gyQ24XX9nREfCv6qdwQKxCLmZqp709IBJbTrhmmy9ojND93+ss2KD81y3kkszf2h/qIpc5daabQB94k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715100830; c=relaxed/simple;
	bh=ZrtjRzoHSZznAXCa9Tlc8EFBN5Bw48Mc8ohTTZfEU+g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bCJtyZuF6kez38wOTAMJrlDRMF0idFnVmdyq6l6I7eqBAfJ8z7LXB3WwO4RsmGWWCaP9J3fOvaWiQay3pVJ6E9S1y5t8QyeT90snSfq7El3cdg7OPAKzFBZakaKSnOZEDV0K5Ei7qYtQiZrlju5ht98jSB39iI2XlCQtvhJqR3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TAu9tEDs; arc=fail smtp.client-ip=40.107.212.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S21bgNVxC1F633Y8/7sEJH0wXE+Fcanha635V5iv4zRh3aWM4sFOkK/UIm5iQzHALbJlZD7DQ1RSHJENYvbhwRXD1hRLlbKSsTpz9Hfqv8amyWWsSJGxLP62IglbWiCuRNgyyjldZfamAr78dbWtwfKXWjd+vuAwxrM3ouUwa3O0gThRfD4hEBJAK2bsJs/z54auJldRB97QS8WpiEuNqNwg8F0buRw8qx8okFbgwvQWtVLp3ZaljC/ZEzl3H6iRBxmmWvoiygI0QmSHWnd9u4KRFcTPhfqa+EfMu50jIzCbCqNhS8AEN496J9/UFMQ7Z8t104Puu5aDSLbM21bJdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9kDQ+parLLJIBl2NA8gLcYVCu4X4nDbTubuCO3A8Xk=;
 b=VCQnYHqJ5o8KT0QHwakEM/q9pd0B+b67e+z3XMMCeykahZOXo1nXYSxWnzWZ7yvZrjKqmlFFqHxm/8hWtTc2FkP0ByDmhGhH9bS/WpPQ8+rNM3QtUDwfjdpyORFGlXhAzQInBYTA9oefZgZaa+x9e6HjF0BHTZ0Ep3wvBfpjCt+LSqtZIpQ2jOiubA6NxyGRB92r6GxbQzCyGcYiCndnfAkxbHxJraZNmUf1PQ7Q2N/rN096uetE57UsVGzRIxIXcH28hkxFG5VakuTYQ3L+DDOttqG3Tfo2zgeBNydfj3fXaMea1CTMigiyHa1FVWwCBSxqpI+F0Eka/yzvxQ6vJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9kDQ+parLLJIBl2NA8gLcYVCu4X4nDbTubuCO3A8Xk=;
 b=TAu9tEDszh7zKgIkYIZERWNpC2q9tpUhvIwnaZtF2z5100ugO3VxVxW96VPS9ZXhopE4G2FikCso7mQx0IlA2gf5N2MD12bggqQW3i5ayDTiKQ7Er4rX3X8tBuGms7DIXkiL1aBZ78T0YB0w37NOs5eveWj0Is2g5+gdlmKQL1N87BbK4MA9ut9CKnkUvRv16xeYHoQoZaAh2yPb/Rrh0yc6NL6ew2O/nLEOWTFeVh3SBz6cFtFZ/aNmC/igQcZF2Anq8g2+sfamm0L+FR3lo+S16sao4R7OPYHnR7Q9mlNjzqaMxI+alyx17tQtxAQADQFkGSBoUsPcWEg8U4cGSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13)
 by DM4PR12MB8571.namprd12.prod.outlook.com (2603:10b6:8:187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 16:53:46 +0000
Received: from DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::5b0:8154:dfef:2cac]) by DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::5b0:8154:dfef:2cac%3]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 16:53:45 +0000
Message-ID: <16ab2040-9d99-41b8-8b9d-39b0753533c6@nvidia.com>
Date: Tue, 7 May 2024 09:53:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fault: speed up uffd-unit-test by 10x: rate-limit
 "MCE: Killing" logs
To: David Hildenbrand <david@redhat.com>, Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 Peter Xu <peterx@redhat.com>, Axel Rasmussen <axelrasmussen@google.com>
References: <20240507022939.236896-1-jhubbard@nvidia.com>
 <016d8cff-efc3-4ef1-9aff-7c21c48f2d69@redhat.com>
 <302d50ac-45ff-470e-90a0-b349821706a6@nvidia.com>
 <21d88422-7378-4a63-8fbf-f70889f309c1@redhat.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <21d88422-7378-4a63-8fbf-f70889f309c1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0377.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::22) To DM6PR12MB4140.namprd12.prod.outlook.com
 (2603:10b6:5:221::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4140:EE_|DM4PR12MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: 118f9925-7950-4e5b-4b11-08dc6eb64274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlRVV0VldFpVUlZ6aTcwems3dUJuaWVNeFA5Um1QRW0zSWpUckxhSW16ZXk2?=
 =?utf-8?B?ZlV1WmRRaHl1OUdaUHdmRHZ1UXNHSXZOWXR5NVhBYWxzeE1waUlKQ0FLaTRI?=
 =?utf-8?B?eTNrNENiUm9RL0d1OTRKdHIrQVpRWVFKZXE5a0s4TzhwSEtOVXZaZzUwU1du?=
 =?utf-8?B?UXBvMnJFZG12TU1LZ21qcUxXd01oL3ZaN0ZsSWo0RUVLM1E0ekppY3RVRzJE?=
 =?utf-8?B?Z0NveVBDRHRBUjNHdWN1WUwvQmxDa29DbGVLMnVSeXB5bVZhbEV3OU1ZOHhV?=
 =?utf-8?B?MmVoeXBFamloYnhacElZa3NqUWRrcU5xNm9ZTXNLVHVaU2dEWUJ5dGF1Rjd5?=
 =?utf-8?B?czM3cEw2WTZkNUNwek1LUlpOSE54K056VTNOMTBQU1lnY2VQU1doNnRuZjFG?=
 =?utf-8?B?dEpDRHNsN1ZQRjhQb3o2TUhqb1R6TEs1STNjWTRpckZtbDltWHVDMFNlTW04?=
 =?utf-8?B?UnptVGRFWFNXMEd5NWwzWjBLZXFBREtmajQxZ0ZwMlRSUm1PM0FHRHRlT2Uy?=
 =?utf-8?B?QVA2b3hzRVpNLysxMXA0a3pibjdJL0pqcUR6b2hjRWZ4dTRVdHhJZ0o0ZjZF?=
 =?utf-8?B?Wm9HNVoyZzQ5eGRKZE1wWmxvK2RMSlUyY293Tm9RakNUZzFlV3ZEMWhOSzdK?=
 =?utf-8?B?NTlVRElzOHdxR1pCU1Z2QU9LeEZQWXVqelNqVEY5NHJqcnBZb015ek05NERT?=
 =?utf-8?B?M25mdmZ4UW9HV3g5N1Myd2ZHVWZCSmRxRXhubGxadEpkOXd3WmphMEZmd0ZH?=
 =?utf-8?B?MjRkdTBRYlQ1aVpFQlFiMWhocENPWDhqSXlIamx6bVk3RHd3dm5UaDlUdGdD?=
 =?utf-8?B?UFBSWk5JS2RXUmVhWWYxSGQ5MXNGZDNKK2UrTFZHVmpGQWRNbDNMaXdCVWp3?=
 =?utf-8?B?Vms2eU5KQXVkcXEwREFMVFlMak81UzNsSCt5L0lBb0V3dGJpOTcwV1E1dmJm?=
 =?utf-8?B?YVZoVEluaGVHK3BWRGtIWXl2N1VrS2JRdS9YQ2tER3AzN0FiRWdKUnJTSFl3?=
 =?utf-8?B?SUk1WURsNzAySHUyL2MyK1NFTThHSzYxV0RWcUtTbHJlSTczZVg5QlZBemYy?=
 =?utf-8?B?WDd6SURIcW1YYTBxbnVrVmMrMTJ5VGtweHh3a1pWMFdwR1dJbEdwVUZhU0Vo?=
 =?utf-8?B?WEtETHlLS0p0aGtJOVhpeTlVcEVHTlMrUzkxYTdSaDNsUWtCK212Wm90QkpC?=
 =?utf-8?B?MG0wSEpRSm5sMVV1QlRkQkYwRmFzNGN2UzBMVXlxZ29oK1N4Tmw4Rk5ScWE3?=
 =?utf-8?B?eHFtL2d5b29HWEtXbEtjZmI1Y1NVOHpwYktwTjhUcmF5V1lPMVJQeU45OVEr?=
 =?utf-8?B?VFNjdVVHK3JyalNQZWRmTmxQdGl4MGc1ZGlZcnFacjVockJTd3Nva2tzVEdw?=
 =?utf-8?B?ODNjTUhXWmhkOWZXWVdtR1BNb2RNVlZTSDhmTTE1RFdMbGZkcDdKbm5QNnpj?=
 =?utf-8?B?bmYyallLWDNnRUhNUkI5c0FQc00xS2cxSm0wNW5LTVQ5SCtEUU5PSm1XYWZY?=
 =?utf-8?B?ZFdZR2l6MkpVS0hoNmxGb2d0eFVEYWZrUFV5Vm95M25MNjdqeTMyQXFzajN6?=
 =?utf-8?B?T24zQkEyZEt4a0VUVkcyME16TlRPMkZtZlRXRzlFbnYxaHR0RzFaeUpCQmll?=
 =?utf-8?B?cXJUOSt1SDhkQW1ReWRwTjFCWFFrcHk5ZjB2Q09qT0QycmtCOU5Cd0Z4WWx4?=
 =?utf-8?B?S1p5RGxmM25WelhabXpub3hvTk9rSzlWd2RPWXJMOHNoc1BkdUVLYW9BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGRUcDYzSjBGMmU4eGczSXFIOExyVXlVNUlJZDNuTmpJMnh4cGZpdFdnZEYz?=
 =?utf-8?B?TlpwQjRjWVAxSEpkU3MydlVhNUdvcFg3RlkxTS9VajRRdFU5UXdHWjZwM3RG?=
 =?utf-8?B?WnliZFdUSm5FalN5Sk03UzdjYXR0TE90MnZZb2RjblNvYWcvNUVrVjFVajhW?=
 =?utf-8?B?YURMN2h2V0xIOUJEYldCVW5UblMvWE1KYUh0T2tiUDF2eENZem1zdkFsdXg3?=
 =?utf-8?B?Wk9LV29NdkhjMXhudW5GQkVjelNrSDN2VWJQVWxQK1dKZWRCbWZqZXdUL3FJ?=
 =?utf-8?B?NFhIU05xM3RYb2lNUTBuY1p6MUgzTDB6VGlFeW1GR3Z3dld5dlNrdGthTytB?=
 =?utf-8?B?dFpUdnZpdEJJWmJzaG5PNkt0SGdMYjU4VWlqTHd5TDUzbEtJaU9YZDM4THFx?=
 =?utf-8?B?TUc1VmhtT1lMa1BsWStlUEU4T3IzcWFJWVo3cndwWVdFSW9VdytFV3RodUpQ?=
 =?utf-8?B?cy9jRkI3YnNSdzlhclhLTmZ6K3B1R0VTMkpNb3VBVlk3bWZCY1lCMWg1NjFj?=
 =?utf-8?B?aURWWmNXMlorR2szRmlreEo2dUhTbFBZTzJqNWZzcGFXWlpmS3lINm1RMzNC?=
 =?utf-8?B?TDhRMjh1YVB1aWpVRkVLdDJNNThaZTlxOFdkZlliMGE4T2dQVjBYZndGT3RQ?=
 =?utf-8?B?RW5ZUDRjQmFVYjE3OGYwNnVDUU5HbVoxMk5YMHNEYTQ0ZlhFY0dtVjNJS3Rk?=
 =?utf-8?B?UEN2c0tXajRwNnlaWk5kYWt2c1BxOXo3QUR6QThJVEZ0czErc0pnZmZUcDkw?=
 =?utf-8?B?YnZQZjZtazhwSHorL3E1cENMU1YzbFJ3dTJYMXFCR2dpakhpeHF3MUtROG9k?=
 =?utf-8?B?ZFpUYlVKc0NmYkhBck1yeGc5ZHRSNDdhMG5SZWZmUnM3RUNLc2tRZTZyc0xP?=
 =?utf-8?B?NHd5M1dGckcxS29NUkUvdm1SckJ5K0k0SFY0TUFFN1F6aFRlTk5ycW1ab3Zy?=
 =?utf-8?B?OVpCaEVRc1pjbVFQeTdCY29xMURHL3EwUzJtclgxcTFXWklpU0pRaks2VlVt?=
 =?utf-8?B?TThXVkJxcXBxUmV1d1dnRkg1UW9MaHRjbDYzZUwvS2tXc0dZWUhVekFDWUUr?=
 =?utf-8?B?MHZYNDFGVmlDSHovNDUvZFo4N2dhNEZVcUdwRlZKWjZDTmk1OEFVOUJkaFlL?=
 =?utf-8?B?S201NGhVZFBjVkE5cVlNY1gvTVNsbm9sUjlYSmh0RXUxTDFNWmxvUlNWWFlk?=
 =?utf-8?B?VUdHaHRpTWdRcHo4dlVIaGFINGIzcWs3Qm5wbXZWb3JUWmcwdEFvNzdBLzdX?=
 =?utf-8?B?T2o1Wkt5ZXBGODhML09INE16cElkWnMwRkdqbVRvTHNpSVV1N1JybHlLdHR3?=
 =?utf-8?B?TDJldGZFbmlOUklUa3Nkd1d3Q1Nidm40V2tZVlRYT1FIS3FuQmNvcmdPVTk4?=
 =?utf-8?B?L2Y1Vk85T3B6K05VdC92NzlNRTJKa1RnMlhMaUxGNlBHQmtnQ3kvZXphZ3lL?=
 =?utf-8?B?c1BScDc0QVFkSGd2WElwNEQ5QkdxRm9lQURPcFRhS2czb1IwRnpNQjF4dFUy?=
 =?utf-8?B?RksyMW9VVWt4RXpFNzQ2MkprcEdOdnFGcG5aSHUyY0RrL3ZESmVDVEkrZFp0?=
 =?utf-8?B?RlBSWjVFaDUvWElaV0pUU0swZTdJYXVzN3NoTnVoT0QzU3pLNHZ6clNzdEZr?=
 =?utf-8?B?VmJuZFB1bUF0OENORXlkcXpNYWhYb0kvMStVcStIYm1BWU41M3N2b0tuL21a?=
 =?utf-8?B?YXJFU1JLblY1WVY4am5OZzRhMHdPVWhYRnVnRFVUQU12ZzZFTmUrdGNtYlRj?=
 =?utf-8?B?MUFQV0g0eUhta2cwdnFqcitLa2hDVWtXcjg3dEVQNDNpd0tUbDJ3eWNiOVlM?=
 =?utf-8?B?cmtzUFI2U1pLeTVPdWdUZENtdEZPVlhpQ25zVlJLNFEzemQwWmNSVkQrd1ZX?=
 =?utf-8?B?c1pkOVI0RThTMUdBb2ZWRHJ3ZmJ4RG5KZ2FyelRpb2hqdHVERkhhc05vU3RO?=
 =?utf-8?B?dERqYmpCY2hkVWFVaEhUY3dsc1U4OHRNeTllWjZvMmo4S3VSeis4eVR3aStB?=
 =?utf-8?B?L2dubFk0a3MyT1RkRjh3STVNak5YT3dQQTFoVld5dFA0cUNlNEZQRExER0kv?=
 =?utf-8?B?dVhwL1YxcERSZHo3ODhwUGlqYUkwSkJIdldJNEFaS29sY2k1eVpIMTRMVm1w?=
 =?utf-8?B?cGVpRlM2bmhzOFA1UkNmYjI1UFNmNUxlMU92SEpGNlBqSXVjQnFKV2F1SU5z?=
 =?utf-8?B?d3c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 118f9925-7950-4e5b-4b11-08dc6eb64274
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 16:53:45.9150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T622KG3b7CvC8JwF4tHTpOsKjwTkLVNRBMmKdu2yMLHaVGBUvCj1JxzXShDJqIocnbmiNVt9e/QoSK2/7Yiw3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8571

On 5/7/24 9:43 AM, David Hildenbrand wrote:
> On 07.05.24 18:28, John Hubbard wrote:
>> On 5/7/24 1:13 AM, David Hildenbrand wrote:
..
>> I'd like to just do this patch almost as-is, just with a fixed up 
>> subject,
>> perhaps:
>>
>>       x86/fault: rate-limit to avoid flooding dmesg with "MCE: Killing"
>> reports
>>
>> Yes?
> 
> 
> Makes sense to me (and thanks for confirming that we don't need 
> complexity elsewhere).
> 
> I think we at least need "Fixes:" (not sure if stable is warranted as 
> well, 1b0a151c10a6d823f033023b9fdd9af72a89591b didn't CC stable).
> 
> Consider adding a link to the report in that thread.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 

OK, there's enough changes to the commit description that I'll go ahead
and send a v2, with a new subject line, a Fixes:, your Ack, a link to
the other conversation, and maybe reword a bit based on your feedback
too.

Thanks for the review and the Ack!

thanks,
-- 
John Hubbard
NVIDIA


