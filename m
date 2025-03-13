Return-Path: <linux-kernel+bounces-559224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF37A5F10D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE5817B3A4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5050226037A;
	Thu, 13 Mar 2025 10:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YHiegBXM"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8565916BE17
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862449; cv=fail; b=Ws5w2wIlf2SW4UhGpsT/S+lAW86JV88RhGJbYXBIYXSprLFrZD6Q12bo80xyP19rdF0MlJH+F7D1dfNwYQZtc2i4ygYr5O+0pvQIeDNoqQdQccFzkgCmK9rm7J5hul706eaYQQvuSf0YRdbNXnLKBDi+DS7hfseHir71cZmN6Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862449; c=relaxed/simple;
	bh=PN6E1EIOZxqZ9iUQifQIqT9KZI2s3owpBEbHjBw81nI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZFjqglLwmqRN6DAkJRfFY+9iBDcON5qBsmRdGUwKOv2VcVUXTU03knaGOZm8PNtaFuHlZcBObyysw5u/INuvlI2Wm4yqHwaxY4aLZ/5Yic5dzOgdJUEuAqU38zvaTdl+91RycV4VKlI0G34i5IYnQhlWKVaLMv+8Y4tCW5H3t1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YHiegBXM; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OgO0a0PHOdllgF0Yw0BwL3pdi5JnME20RQU0Wc1WMNcoB6xWdulykf7197qYHDN4ltfMhMrHM6s6SLiBMl1hc0oSYoNEBNWPcRds83osX/mL3S7hNPY25WDj2HKZMuY5gdEUILsX3YTr5rVJDzr8xFBzgcxrASBKLK1ap+lvMgSXf1hcj9i6AwtFpTkHc6FHgOZtxKGxqLRRxkuyA9JPo8a/hMLb5fYsG4avONVEchye5dq4SUlSsy4BBo2TVRmIiCbyTzhUDMdSxrsFSKMYb9O+DVW2WXB8AriqvZDzqRydxB3hdFlkCNDrVmzT3MVugR/H85BAHV2Ufazqwgakmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHMhDU/sAuC+jHuWvvfqZWo6nqfmCaS7tF0z6+Uzg5o=;
 b=ufHzvlGDlqyrB9+aDqhq9YQse6+Jfvj21RlUPCHyJNG1QvU6EOEWefJke7hyIOOAa6zMAfcR3BKwxolvkewlBWmUd1JFmxarHf02dVk32ehOW/WuWoXPTmE4RCZqizaI6Xu5Z8MsfGPSw1vkqW/AX2GXx5gQKx/3/rOP2i1K7iCDZbtiZXp48PNqZY1/6Cd+nVfsV1jDbr6Qf2rSJW/Z/RA/k5Z3bSbtkRt0ZHtU/8VZWq6f6OCgISRMaGjken/VCy1IvMX12s06UW5+Z4OYSmHUmHvrNMCesXdizwNmHLumgri9v8d3qLadgGBnJbpbQ5ujVk7G9kqbn3wKeaOEDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHMhDU/sAuC+jHuWvvfqZWo6nqfmCaS7tF0z6+Uzg5o=;
 b=YHiegBXMsh/A1Z7APxXPOGgEi/4rDL5MsiCP5KdPyYpLlBN+RphbwyZYMf9A5Gf4hrcnMAxriT0iJaBaK0mk8Xfyftbek1uVq4riWnWVCq/BqDMDsdI25hDilduBBu8XdVuhufRksWnWi+36JNIZG+ygxRsSZV6eH6eFgD4XwDuBLCSWopeImNVz1svPE/1OUGtWzuKt+gcTSutCpz4J4HysJQ9h23qMEuZ/vNcLTmtLfDqzToqeE1TGNu2JJe/4IRevRf6BEY3wIKmuh2Sh1kAKAas1Xqi5kv/yzd1Wn1vLW5Z4AHegih1FMZ9JdKCCftqeySpkuVJJasbLEnh+Eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 by IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 10:40:44 +0000
Received: from SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868]) by SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868%7]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 10:40:44 +0000
Message-ID: <20b5823e-247a-456a-bb55-d50f212a9f5a@nvidia.com>
Date: Thu, 13 Mar 2025 21:40:40 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: commit 7ffb791423c7 breaks steam game
To: Bert Karwatzki <spasswolf@web.de>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20250310112206.4168-1-spasswolf@web.de>
 <951f9d13-72e4-41c3-9ace-8639e2a9485d@nvidia.com>
 <ce940e2a-632d-41be-9f13-e5b11d49b0db@nvidia.com>
 <09131c563332c892284ec7fb4ce706996131db8c.camel@web.de>
 <9a5df5627d3d72b2a97f501dfb7d944cc1e9920f.camel@web.de>
 <fdea59fe-f570-489f-bf88-1ffd47119cac@nvidia.com>
 <414f4deb8c7670a159854006b0c410ce05a6049e.camel@web.de>
 <12d950ee-4152-4ad6-b93e-7c5b75804b1a@nvidia.com>
 <705e95cec3dc5181ca2aa73722e6b84f63f3e91d.camel@web.de>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <705e95cec3dc5181ca2aa73722e6b84f63f3e91d.camel@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::7) To SA1PR12MB7272.namprd12.prod.outlook.com
 (2603:10b6:806:2b6::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB7272:EE_|IA0PR12MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff9981b-8a29-4115-4097-08dd621b824c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2c4SjhRcmZGR1p2MnFxcVZiZStCRlZZRkdxdlhjbXRuVVlBS093KzVXb2sr?=
 =?utf-8?B?KzFHTDY1V2o1SUd6M09lZmcrcSswcmpTMG5HY0JTM2FxejhRT0xTaFNyY3BZ?=
 =?utf-8?B?ZWxSSk5nTkF5YmJrNU44N1ZhWDFLVldrelAzdGhjSTNRSkxGRE9xWHVVYU10?=
 =?utf-8?B?bzBBeDNnd0R2OEpKR3dKTG45RzNvY2I3Y2hwZ2FZZ0Q1Y3ZZOXpMVnlkbEdn?=
 =?utf-8?B?TUV4UmFNNlhGc0hvT1pDNmVJWWt4aHc3TW5wV1B0UlFrWUNSMlB4L0Vkb0pQ?=
 =?utf-8?B?NGJpZmk5MWRUWXpwV2IvSUVlWlltMVZZcW5hUjBqUlVNekU5Tzh6Y0ZUL2l6?=
 =?utf-8?B?d2UzanNOVmJoaEUrNHdyaElqMk1yK3BnOGxoS0tiaDFEVGRRazk3WG51UGor?=
 =?utf-8?B?ZzlyRE1wanZNK3prOE1tdEcwSE44NXZWMVkzdE5QUWlvMjNhQ3h1aG1BdWE4?=
 =?utf-8?B?em5RbWtJcWxEV1hmc1JTTlhhYXVtSkdweXNKN1VPd3NTUEFkT3IrcUVORXRB?=
 =?utf-8?B?N3c3VjJGZGJRN2lhaUR2STB2R0lIYkoyOHpCdVhIR3NJNlJOWDBRazBqQ2VU?=
 =?utf-8?B?clB0TmFrd1Y3MXZxTVRkZWgrQ3RiNFl3bE1wdW5GMnh6c25iT1Y0NHlSekUw?=
 =?utf-8?B?UnZ5eHJyNzcxTnliY0dRNFRxcXBzMnhUaHpGN3B0UGlvVW1OcG1jVFJnM0hU?=
 =?utf-8?B?ZWtJZjErL2J6MFkrOEVTamFHbllNQ1RHRmtNcTJ0Z3V3cVQrQk9BUGVBRUgx?=
 =?utf-8?B?WEI0eEVsVXhROHVoMWdEaUlWa2lGYVcvKzJqL1hRSXN2NTVjUXc5ZG1IOHpC?=
 =?utf-8?B?SW5oZytvdElseklSYmlvTWVTTlJrZmFXZW8yNjlJenVzZjQ4RFZBL3hqbyt2?=
 =?utf-8?B?azRTZ1c4VitOS3ZaSkpWM3JDSHpldGtvL2tueGZIcTMwZEtrbE43VXQ4YUhR?=
 =?utf-8?B?N01tNVlZbVpPZDdJcXF2ai8waG5yTjFHMFVyeTRTeG9hdk1ERVdpbFg3R1BQ?=
 =?utf-8?B?RTJiNDBMS2ZaeTdBUm1ja0dqSDdXUVRYRkljWjVrS3hDT0hyWE5QemxQNDRI?=
 =?utf-8?B?aFhJSlpwVjBIbk0rZUdmSklDY0JYNmpNbnFWUDQ1ei9mUUJYV1BqMW5xcUtT?=
 =?utf-8?B?Sk5kMEd6YzVxRFBWbGV6dnl2N21MaUVKNHJsTXNrYUhXMGlTMFhsMEJoR1JB?=
 =?utf-8?B?a1gyZ0lqbjZUWlJnc0lGVjhJZkVGUHd0VkM0eWFOMmtiL1VEbTdVbXdjekdI?=
 =?utf-8?B?WTl3VUl2Z1NTZDVhaG9VZk9MSjZPNlFGdDJJa3JvSEhpRkdXanRXV285czdD?=
 =?utf-8?B?MUhyQmNvNHU3YkhnQnBJa1JuQW5XRVppZUZpWUV0SDRlb3UzcVh5bHJNWThl?=
 =?utf-8?B?dGZzMjJJbytMV1lmK05zTlNMRlExTEJicU9VMnRjaEpiS0FnMFlOZ2FPdExi?=
 =?utf-8?B?ZUNjYnMxVERab3RobjcxdHlacjBDM0tKN3BnVHFxaWZiVGVXOVJiQ2c0Q3Ay?=
 =?utf-8?B?a1laayttajhlV251Nk83akRhY1kwU3p5ZlBUWDNvRVN2V3dYaVJFQyt4V1RG?=
 =?utf-8?B?eUZnOSt4dmkyVFdmOVo2NmQ3akxNaEpuM2dzMlVoM1lKYU51cHJjeDNBMjZn?=
 =?utf-8?B?Nks5YUR0S2ErNnBJRytzbHZLYzZYRk9VL3VTZmlzWWluakRlNmk3eU9QcDVx?=
 =?utf-8?B?eldqcW8rQVpFWW1neGo2TGtTaHhIaW5KNUx3ck9wcGtEQWhvRFdlangvSjZH?=
 =?utf-8?B?dEZjU3FqQ3ZYckhnZ0NXRGgycnl5d0JXbm13VFo4My9iK3FlSW13NUpJVXVa?=
 =?utf-8?B?SFprS0x3UVJZK1RUUVB2aitnUlgzMFNSOG10cE94dnFmV2JpNXR2R2VHUWJO?=
 =?utf-8?Q?cNspiRhMpO1eG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7272.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXk4UVVLNWJRTFVJblhjRlhMMnFCNk5sUlhJQjhTdnBFblBTUWoxdVlka0Jn?=
 =?utf-8?B?akVYQW4ybk5uRmJtMTAybTg2Y2ZRR3kzQzJVNUQ0cVNUaGJ3UXZUanZGMjAx?=
 =?utf-8?B?cVBHbUQ4dzREWkNJZUxpSzdWL3hxa1JzbWszK0NaeGNLVG94eWkyQk1ZSjMz?=
 =?utf-8?B?SFRuZWJzWXBnb0NSZmloTmpuN1JDMmxMeGpRaWZlZGx2UExsejB0WTlrbnB6?=
 =?utf-8?B?Qkp5dmsxSTdjTWYrZ1dWN0FsK2p3MkdDcXhLNTFIa0IzWUN1THJZdmp2Q0JG?=
 =?utf-8?B?Z1prekFxQ3Zmd0t1Y3E3c3FUTWQ2TUdpd3A5TUd0Smt6QmNYSzlWeGJrN0di?=
 =?utf-8?B?WHQyRGt0MEVIYzVOUjVDUlJNRUhMTUlVd1Yzc1ZmNm02eFNsRmRqOGZsSkk0?=
 =?utf-8?B?a1VpQW5mT20wUG1TL3NINGgwK0pxckYrZFExM0RKYVBneTRIbWw1akNhTkp3?=
 =?utf-8?B?TDlXZHNJY3R2bkpqYkM4b296TU5nK2NzMkdRdjlnUE9Zb3g3bXpYN3drQzJP?=
 =?utf-8?B?Y3p4b3FJMS9ocjlkeGR4K3BhZUI3K0xIZDd4aDlySlp6YXJrUjlDYnBYZ1Av?=
 =?utf-8?B?RFhjU2hEZUd1d1FtakJ3YUF6a2R5Z2NZWS9Zd3luQzlFTzlDSDdubFBBU2Ur?=
 =?utf-8?B?NERIbkpPclhXQWpYVkR3OGl4cnR2Zlc1U2N0bS8xelQ3QlFGNlFMR2NCZkdF?=
 =?utf-8?B?cXRKZkRSam9NOXJqWE1OMHR1dm1FZzRtSHBYR21heUE4UmhTRGU1KzVVbVFH?=
 =?utf-8?B?WjNXaGs5eHhZTW5aVXQ1Z2M0MXZLTGJPYkRBNzJOWTRNWXhQZGRkWEsyeUJ1?=
 =?utf-8?B?bHozOTFpRnIxZnRVODR3RzhTbjREbi9tTnhDM1p6dlp6ckVEcTJXbFptZk9o?=
 =?utf-8?B?T0pSNGRuWVkvSEg2cWswRTRxOG00SjJVTXBCc2ZxSnJ2YU1mbVN4RVU5Kys2?=
 =?utf-8?B?QnREbW5iNUJnOUdrMlZxQjFkQmJERTBvaGYrODBXSElOYnowbmJ0UlpKZmJo?=
 =?utf-8?B?bUFQd3AxVktkR3JjTzlOTjFVRS9UaFM5cXZDdVlIOTNpMVliOVRpRnFDVW1B?=
 =?utf-8?B?bmFvbHpPaDE3ejhVMDZ4TFJNcHFFRUE3eWpyQlYrRklNSTU2M2NrcGw1cnFt?=
 =?utf-8?B?Qy81RG15cWlCcXRMeHZkQkdWUUFSTDBYaTcvczkreDhXQ2hLL1lqMHgwNVE0?=
 =?utf-8?B?U2FPbFhpRmhrV1JNamYvL1Q4NmcwT2ZMdTNNb1U5VTJTYllpZTdzbS8zTEFD?=
 =?utf-8?B?QlZWT3Z5cjRCK3ZqeXFTd1lRUnJtYmtYZHJrWXBxbkZ1OFhaOFNFeFM2Vit3?=
 =?utf-8?B?aG53QlJ3azZudFduRDBSWlFtb3VCR0ppRXp3VHNQS1JKN2VFRktpQWZsRFYv?=
 =?utf-8?B?ZGo1dnpCUk9vZnhFbUNMelNlQXpNbmllSVN0TWJwV2Fjb3czdmpLcHpwYWNU?=
 =?utf-8?B?N25FY1d6RFVZWTN1N3BnUzRrWEJwenE2ZXVnK1Z3VFIrVDNoUU11QmNOVE1v?=
 =?utf-8?B?eGNuVmMrR21WdkpNU1RGSUdTVGNQRmJrVm01SUNzYWdSc2JxZ3dzOUFFbloy?=
 =?utf-8?B?Y1c5cGd0NFJhdUt1SmI5eGlLb2ZWeGJETGQrVlRyd2MwYUJ1R2Yyakw5V3pl?=
 =?utf-8?B?ckV0cGxjS1JiL2g3QUgzVWhrZHpDYnQzdWtRWWlWQmkxVTRzYzBqM2pDK2FR?=
 =?utf-8?B?WFE3dE5nMFhteU1KbFlOSG5EdTI1aG9uOW9hUEhIeWhRcDkremVEQ1pzbkhB?=
 =?utf-8?B?aDYxR1VCS1QzUVhaSW8wclg3NFlLbStzaXZZanA0TVpLTk5oQjNVU0ZOV2s3?=
 =?utf-8?B?OGRXTlJXUjRKc2x6WjRhZTMrZjFyMHV6dk04NmFpZ0RKRDhmbVo0RlNVUjl3?=
 =?utf-8?B?QjZDUS9sYnBNa1IvNlVZZG1VYUF1Y0lmY0dtOTR2WmZlOFVZNG96eU5CNnEz?=
 =?utf-8?B?ZVhHVWFYUE41UVdHUFpkK1BuUXM2TlVpenIxTUpORDkrNnNWNC9LbHlqdENo?=
 =?utf-8?B?ekF3Ny9JVUVkRUlNRlZzaHBHQWdSK3BiY0tpSW04ZnMrcHNTa0NMNEdYWC9o?=
 =?utf-8?B?V3pRMEtlcHdZOEZybFBRS1Zza1Zwd2VCWTVRc0hwZFkvVEV6dFVxeCthMG43?=
 =?utf-8?Q?TFja1v89pLgmo8c7Btm+uGDwu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff9981b-8a29-4115-4097-08dd621b824c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 10:40:44.7204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5UBW2ffzGE2iuzmSxn3v1JMzO+xOZCJqq6CEOMoYEohPCZ9U09B/XJjS2FiiDZQrAct8O7KWLhyvRzvHcjYDuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8374

On 3/13/25 20:22, Bert Karwatzki wrote:
> Am Mittwoch, dem 12.03.2025 um 12:24 +1100 schrieb Balbir Singh:
>>>>
>>>>>
>>>>> As a sidenote, I've tested several kernel with nokaslr as command line parameter
>>>>> (6.1.128, 6.8.12, 6.12.17 (the debian sid distributional kernel)) and nokaslr is
>>>>> not recognized as a command line parameter in any of them
>>>>>
>>>>
>>>> Please see my comment above about booting. How did you check if nokaslr is being
>>>> recognized, is it via looking up dmesg?
>>>>
>>> When I boot with nokaslr I get the following messages in dmesg
>>> [    T0] Unknown kernel command line parameters "nokaslr
>>> BOOT_IMAGE=/boot/vmlinuz-6.14.0-rc5-next-20250307-master", will be passed to
>>> user space.
>>>
>>> This also happens when I use the debian kernel with standard .config
>>
>> That is quite strange, I can see nokaslr handling in choose_random_location() in
>> arch/x86/boot/compressed/kaslr.c (which depends on CONFIG_RANDOMIZE_BASE)
>>
>> Thanks,
>> Balbir
> 
> The command line parameter nokaslr does actually work, I tested that by booting
> the kernel with and without nokaslr and checked /proc/iomem for the physical
> address of the kernel. With nokalsr it's always at 0x1200000.
> 
> The warning message in the code
> 	if (cmdline_find_option_bool("nokaslr")) {
> 		warn("KASLR disabled: 'nokaslr' on cmdline.");
> 		return;
> 	}
> on the other hand is not shown, because warn is basically __putstr() which
> outputs to the serial console and the screen, not the log buffer (Which we do
> not have this early in boot anyway, I assume).
> 
> So with this solved I tested stellaris with a kernel without CONFIG_PCI_P2PDMA
> and nokaslr and found the same buggy behaviour (i.e. laggy input while stellaris
> is running).
> 
Thanks, the system/game is not working correctly accessing memory at 64 TiB

I am beginning to wonder what your physical address bits are set to?
I can't figure out from lspci, the capabilities of the iommu on your laptop

Could you please share your full dmesg/lspci before and after the patch/nokaslr
command line. 

Here is the what I know so far and based on some search I did, I could find
your laptop might have a CPU like this one
https://openbenchmarking.org/s/AMD+Ryzen+7+3750H

It has 43 bits of physical address and sev supported and IIRC sev can change the
amount of physical memory accessible, but I am surprised to see that 0xaff...
which is the 10TiB range is accessible (44 bits) and the 64 TiB may not be.
I am keen to know if the system works or is it just the game that is sluggiesh?
Does graphics work in general, do other games work?

The arch/x86/mm code assumes we have 46 or 52 bits of physically addressable
bits. There are experts who can correct me if I missed anything in my
analysis.

It seems like kaslr has been hiding the issue that exists on your laptop.

Balbir

PS: We could try some other experiments once we have the full dmesg and also get
help from other experts. 

