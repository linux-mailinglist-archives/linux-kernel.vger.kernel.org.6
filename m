Return-Path: <linux-kernel+bounces-170279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 877918BD465
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 20:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA9861C220F7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CE815885E;
	Mon,  6 May 2024 18:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vXENn4M+"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC9E15821F;
	Mon,  6 May 2024 18:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715018979; cv=fail; b=cYc0PUj4WQBbm7oUEtS9qFRP+t9uKGH7wjqpi0dtNLZUkYjxdvh0X9+DrOGqmZvfQ2Zkgdn0QwewKitxu4VVCLleD4YdQ3UA4MussoRgEQlZyM+WFrpA3iacCmnkcNQyHYWpXtCIpNTRTUgwG7rRC/BScyHFZKA2WF5QFyetKgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715018979; c=relaxed/simple;
	bh=AJBII8SYqJkRwr/YKUEOK8X+0Z9gRNjJIo/t9JeoeLc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uXAorehqnIq7mnI3XEH9U2Jt2muFRN7uC8ueklBB8jL16cekHiVt92t+6mJSa5lmZMG+ioecr7WNVt7W3X889Z8/S6ShzxJONUKmbDP8zuYkA/S5c/Z561qiLy6nATiiWB1GdIw5SHxt6VXwXyFnVHOLWkCVfUjIYmSsn5o9x/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vXENn4M+; arc=fail smtp.client-ip=40.107.94.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNVdTFbPgZ2lQpmfIPzjjZa5Wz9Vt/ByCo0ZzccI1P6bqgT5cIechvp/PFbINfVG2WC3m9M4QzT1VzakwNglNOxmbNwLFUKu+O+mAWBrJiUfY6bHUrOYtVj+OGX++xw2FTYVeAD6k3Kp84/vFy7lCDSyZQseThxu95ABQjDL1b1lpnt2w5faH+f08zgHu6fKZnfJ8BYG3ajcvNsPu3Ar88d0+fWAz+kO6/EjlVQbUZyB8CEAf8LGSSDWJq+9YFCXWwK6UeHF6o3I4gnFsnCL0yWHHXSeRUFyUnc7SiTJaNfTb9W1H1+6pZCDI49Tl7Nj9CjKmwy/mmkRL2mU+tUTrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sa+AdLwe9HFIZt9OzyDyhYMNoNqVl0uHoZR0QJSnnRA=;
 b=MiSP7IAqRvy+Wc4IeBFBXwA1Yyd8QMTLJinJ3VMeN33f9qxVQJp5X0ycr4lG0oDJdcjxNeQz1FnU5BxYMOqfkalzHOKaWYRxxyJDhFu6+I6hN0lA9vWOoLHk5q06ThS8z0+ZkdZ0zVtoVXqHUWRqgJZHQSWCikw6MnsOx8uR+cGNJo9HwOHGVpcg3WNiM+m9a3b0XDphaX8lMY+DCTrINAysUkW8o8yPX3N5WsFI4moHRqW6xi7IB9Dbvj647H+jb1kdi2xdq4yIkQaaMDy1HVuNLfDS98dPesYwPnN0Lwskl8t+Ai7xieoqJGaE/R9HNTXX4QnpIb9b6y0Ad3xdcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sa+AdLwe9HFIZt9OzyDyhYMNoNqVl0uHoZR0QJSnnRA=;
 b=vXENn4M+skhaMOrOwbqZwZBzeauMRD35HZdhn8mBR9MsR/xXGuTCohf9YziK3dCienInLu1uuZ/FKU+LIzqALhi8ERDIEvx2RHbu7jEOLEXnKEk5MC1eP/ed6c+H2CiTQqc5E7Swaqk4hLSC04wpSzGXfSaeGmAv5vq9mNgy3j8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN0PR12MB6269.namprd12.prod.outlook.com (2603:10b6:208:3c3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 18:09:34 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 18:09:34 +0000
Message-ID: <91ccdf56-1a33-437e-9a55-ae2e1e89fa8d@amd.com>
Date: Mon, 6 May 2024 13:09:29 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH v3 17/17] x86/resctrl: Introduce interface to modify
 assignment states of the groups
To: Reinette Chatre <reinette.chatre@intel.com>,
 Peter Newman <peternewman@google.com>
Cc: corbet@lwn.net, fenghua.yu@intel.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
 james.morse@arm.com
References: <cover.1711674410.git.babu.moger@amd.com>
 <f7dac996d87b4144e4c786178a7fd3d218eaebe8.1711674410.git.babu.moger@amd.com>
 <CALPaoCihU+mat2A-wNtTm=qbpya8ZqhDURsfZfjuHitch0WrLA@mail.gmail.com>
 <9d59d38b-af1a-46d8-81c4-b426d47d4ed6@amd.com>
 <CALPaoCgFEybS5MhsPx4EaJmsfBe8Es_6QwWBXpoctdaNf0NcMQ@mail.gmail.com>
 <80c56417-3d74-7d68-1228-9cd944567b4e@amd.com>
 <c8a23c54-237c-4ebb-9c88-39606b9ae1ab@intel.com>
 <4cfe9c47-4736-b08c-50a3-5d7a11246b5b@amd.com>
 <330e3391-b917-4a88-bae3-bdcbb8cfd6f4@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <330e3391-b917-4a88-bae3-bdcbb8cfd6f4@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0100.namprd11.prod.outlook.com
 (2603:10b6:806:d1::15) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN0PR12MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b104d36-87cb-457c-603c-08dc6df7aedb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cExjQzZrMzQ0ZFVqcC9vQ1hNODl3ZFJxNEx2WnYrNVgzM0trNzFjTUdLbHYz?=
 =?utf-8?B?QS83TUdSMlNMZFhYZG40a2VROXVEUTBnbUZkaXR3b0RmWlR5SGU1cnd4L2Rl?=
 =?utf-8?B?Y0Fjcnh1b3FtZVR2ZFlNMUNpUXkzanZpd1VnaTNYNG10Vnl3aW1OUHJnZFkz?=
 =?utf-8?B?VDdYN3k3UmVLNExQV1h1ZjJoRU5MWTl3US9IRk5kY1FpejZqdFNERXZHdTZB?=
 =?utf-8?B?MU01QUh6Rld5KzlWRHQvZnVFSDJWanhnL3YwL0EvNWlxWWVVKzlsRWF0OE9M?=
 =?utf-8?B?UkoycUF2TWZxWEV6VnhhLzU4aVFvc3ArS21kWC96Q2lySFpxMnVmNDRGaDQ3?=
 =?utf-8?B?Q01yMjdUbUc4bjhva2dlWEllZEpESFRXYUFCMnpJRDZIaFpBUDJ4dEhNZUF6?=
 =?utf-8?B?TXFVVEZOVGIwRk5NbWhjNm80MWFWTWxPTWhXQ2p2SmFkVWZHMldwV2VQUy9Y?=
 =?utf-8?B?b2s5ZTJpbm1HalROcy9VaUJrN0s4c3lYdmNiWVRjQ1Q1QnpmMmVNTUV5eEow?=
 =?utf-8?B?czdlV2o4SHNoN1c1YVRiNzBQcTZFZUNRa1c3MGtRcFFuNWxwY2QvQzdpMTFX?=
 =?utf-8?B?MTQ0L2QrKzhYc0FQcE83L3JBZytVK3o1QUIwNDNYeFA1aVJuUEtqdTloSHBL?=
 =?utf-8?B?TDZJRkdZNHl1citGTHorc3p1NjdLU0FUK2czQlJtRVhCSVlFSXZHV3ZmaXJh?=
 =?utf-8?B?ZUF0cjU0OGcrMDZQRnBKdkVKbTNaMFJmbjRYTU1DNE0xQmxzS3ZWWXFtM2hE?=
 =?utf-8?B?MENCeGdSL00rbmdtemZMZlFRNitpUHdpM2ZoN1FZRmRvU2R6UWtTbHJKMUpt?=
 =?utf-8?B?VU1KMWxhcWtHd3phdVUrRmlaM2pTT3RnbHdodFVLNjlKcDRWSncrTGlYc1lZ?=
 =?utf-8?B?aktYQVVCcHE5ai9oWjBhaXptL1VkQ0Fsa2JDaUUraUxUbGV0UUx0NHF1Z1hF?=
 =?utf-8?B?U0FuSEttcm42MVJIdk9HRFZXbk8xU2VULzV1N0lOcFRrSUw3M05KUXZxRDNX?=
 =?utf-8?B?cmo2bDlEaXFnTXdBMmVMeDd6WjhtL1lXWUpaQjhVdi96QVgrTHhTRmZkMDlo?=
 =?utf-8?B?d2x0bWFONEN0S0FFVEhZNklva1BBS21pT1R1eUZsZUgxMDVQZVA0OWtDTlBj?=
 =?utf-8?B?YU00ZHBOUGJjN2xpYmdEWTBYOVcrK1c1clZTTG9pdW9qMllYMXQvVjJOTyty?=
 =?utf-8?B?bGJkc1J5MXo5VjRjczhnRytZd29XbGVjUDUwR3dCNTFhQ1MrYzhwZkwyVTV2?=
 =?utf-8?B?M3g3SnQxQi9QUVZOWGtmMDRoM3ZGMkh3clhERmRIS2YrZHZ6ajBKUEF5a0s1?=
 =?utf-8?B?SGVLemRSdHhwK1Z5L0RnckZLTW5RNDJ0L0lzcndlUmJnOUl6ejZjNjVsWmxG?=
 =?utf-8?B?bUlCR1RqTWZ1QTFpaDFUK2RPdU9zdUgvQVdlQmcvUHRMRWVWUmJ6NnN0cG5H?=
 =?utf-8?B?bmw5UmxteERzcFBzMGJCNlF2WDRqTzJPME5Gek1iSjZWNjFhYkJIelpjaTFi?=
 =?utf-8?B?R2ZnOVYzQkd2VExrOXg3Yk9mb3d3RzYyQ3FXQ1ZLZi9LK1R0Q0ZyNVJXOW1D?=
 =?utf-8?B?eW1pWUFNeTJGQUxMYkxSOUZYWDhIU2VMVVlLekpQdEpCSjIyakZTV3BlT3Rv?=
 =?utf-8?B?OVpzYitSd3B6NmNRYUk2ZmJvenZIcm1tdFRwb1JzMGR5eWRkUHBQdUtTVlNt?=
 =?utf-8?B?OWpWRHFHVHNQQUZldjdUZ3FjcllURVF2cEJrS0ppYUJlTW44M0tHZE1nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGhFcDh6UXJCNUJTSyt1cVNYTmJrMTkxOFgvT2xlajBBT2huajlsSUNSaERN?=
 =?utf-8?B?ZlEyaVlHN0ptMWsrOTV0S09EU2xmUEtqV2p1dTYyK3duaVBxdUh3WUhKK1Uz?=
 =?utf-8?B?TGRUV2p1U1ZwYmIrY2NJNkVodk1MNWtybG1jM1VhYWJEQ1ZmVVZIQVo4V2RW?=
 =?utf-8?B?ZWVZQXN3bVlkRWJEWU5vNnJwVTFWek9WKzRNRmkvbVp0Q3RYWW1zeno5RTNx?=
 =?utf-8?B?b2k1VlQ3bjY5SnFYcERtVGxsc2xvRHgxbDBtU0RxbXVkWXYxNXN6cUs4Rko2?=
 =?utf-8?B?RnVhb0hiM0RCQnJNQkRjbTQxV04waXprM2xaYnR1bXlRTUtMVnpzSUFlTTF6?=
 =?utf-8?B?QlNLNXh2NUl4ZXpxeldJeHliMXMzOHJCTXcyL0Q0MXhqVWx4NFZEdlk1dG92?=
 =?utf-8?B?enJXKzJyUHppcTRtQWljZktFRkJPK2g3VmtXd2Z1VitRYVNBTmltSlF4VkNT?=
 =?utf-8?B?TVhYUEh3eVhlY2tkNXAvZzdqWHNJOVFod3lPNzRkYVFUMTVJaUQzeVdkNGY0?=
 =?utf-8?B?ZnoyT2ZMU3VXMzhhY0I4NmRHZ0g3V2dkNmR2NjRLM1QrRlZWdjFQdENob2tT?=
 =?utf-8?B?SFk0amZIb2l5Ky8xSzVQT2pTWjF3YUhIdjF3QWU4U0NibzZjLzdTZ2NhSUhN?=
 =?utf-8?B?cGRjSXRSalFpRVk1cGhQSko2U0pYSEwzMzFIcTdRYmdCSzVvV2k5ZndpblNt?=
 =?utf-8?B?emszS1owdXA2RWJ6ZkxLcFI2elRDdjBmRVV5OVYxQmgwS1NXcUdYMWJINGl2?=
 =?utf-8?B?bVBQM1UxYTdVbmNTMFRic056cERhM3BTUGxnVXhSditqL0dKUGx4NmVzQ2No?=
 =?utf-8?B?N0NObkh4MUFkRHdzWVJ0TzE5TUIwTytJY0FHUGs5aGhFYTJaM2VYRUo0ODdW?=
 =?utf-8?B?Y0MvUmNnWE1zZlUyZGtscURIeXBxaVJ3d0RlWktoNUFicVEzM3pRNDhIemxE?=
 =?utf-8?B?QVBubCtTY3BGUTNoNS9QQjBNVVpNUFRPWUFNU3g5TDVWSFpyUzFnZy9QN0Jy?=
 =?utf-8?B?YkxKUnduRGtIVGt1R3ZMaG1TSmwvemtVNCtmdVVTYVhET2JvZ2p0czUybGVD?=
 =?utf-8?B?ODNxSmxoQ2FhbHpqLzVPNzg2eWYvSjV1Ym0vaEtpLzRwVjRBcnJiY29idHFK?=
 =?utf-8?B?K0hJM283bWg2bE9OK29VZldyOVlXcXF2OWlDd2FJdER5TkZYR2ZVZGYvOEgz?=
 =?utf-8?B?WFVqME5NcEhSck5Fb2U4OXh0QjJPQVBpQkFPcmFuZFQ2dlRhREw5cTVOTVVZ?=
 =?utf-8?B?RHcySGZINEhBMXpyU2ZLOUZWRXdndVRNeDNTMzZKazlFQlltSzRnT3hOTkVi?=
 =?utf-8?B?YlB0Q0FzeERQWmJOekI5RUV0VDh4RjU1b01sekhNa0VpTUcvdUxUOFdha0Zl?=
 =?utf-8?B?YzhrMGxBWitYeTRzWXJvd0hRSFZOUWlKdDJPc0hXcHFQVnMveXoyaXo3UkFM?=
 =?utf-8?B?b0Ywc1dEY0VOc3JqTlRoRHRpcVJTQ2hnN1ZlVHZoeVltbVhDNmlxaDIxVGI4?=
 =?utf-8?B?VUt6U0ppdkZyZUNVU3VuSnBVUFp5eFlQamdQaFVheUM2K2oxbnV2d2UrajFp?=
 =?utf-8?B?TFRLeVl0UU5zTlhWdzlJSEJkOG1BUE4rMjBmKy9oUDZ1RTlXbzB6ZThQOWpS?=
 =?utf-8?B?RER1dXNMTUg0Ukd5TUZtQVhXSHFaT1VBTzhOaGViL3ZUbUZpMWZVTWNoU0JD?=
 =?utf-8?B?b0UzWGhkZ0swcUpsa0xkSmFIUnFRYUJXQ0RXMzZidEtJR2FzaWU5MklZWm9a?=
 =?utf-8?B?S253K1RzUTFFNzc4UFZUZHNqU05lZDZJdDRneDlxdnYyYklpWkZqazIzb3VJ?=
 =?utf-8?B?WHFQemlYYTdpUEM3N0l1U1FxaXJ5c3lCZVp0c052S1VUZnB2bWk1MG5zVkwx?=
 =?utf-8?B?VXZteisrTjBJM3JOQUI3aDcybyt1YjBvc3FMdXZCWXF1UUtWbnd1V2h6NmVy?=
 =?utf-8?B?dTAxS2lDZS9NR1lOTFhVd0NsWW9pdndyY2hOSVVTS0tFM0ppTGp5bWt6UDB3?=
 =?utf-8?B?M0hHNStldnA0R0duRDV4bDd6TkU5UHlwUkZReXJZZ2VXN2RZTHNGWTNiTGtX?=
 =?utf-8?B?UE9rWXhoVUdtVmtsNERvM25FZVF4ay9FSEZ3OHY4SWNnNXJxNzFYLzZvdzBB?=
 =?utf-8?Q?T1ZU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b104d36-87cb-457c-603c-08dc6df7aedb
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 18:09:33.9607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X9YgIt0afUq8YseVQNSzavNzn3kZoSIkDHNU5tx/vLix7iPls3YQjpXL9GnEWeYp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6269

Hi Reinette,

On 5/3/24 16:16, Reinette Chatre wrote:
> Hi Babu,
> 
> On 5/3/2024 9:14 AM, Moger, Babu wrote:
>> On 5/2/2024 6:00 PM, Reinette Chatre wrote:
>>> On 4/17/2024 3:52 PM, Moger, Babu wrote:
>>>> On 4/17/2024 3:56 PM, Peter Newman wrote:
>>>>> On Wed, Apr 17, 2024 at 12:39 PM Moger, Babu <babu.moger@amd.com> wrote:
>>>>>> On 4/17/24 12:45, Peter Newman wrote:
>>>>>>> On Thu, Mar 28, 2024 at 6:10 PM Babu Moger <babu.moger@amd.com> wrote:
>>>>>>>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>>>>>>>> index 2d96565501ab..64ec70637c66 100644
>>>>>>>> --- a/Documentation/arch/x86/resctrl.rst
>>>>>>>> +++ b/Documentation/arch/x86/resctrl.rst
>>>>>>>> @@ -328,6 +328,77 @@ with the following files:
>>>>>>>>            None of events are assigned on this mon group. This is a child
>>>>>>>>            monitor group of the non default control mon group.
>>>>>>>>
>>>>>>>> +       Assignment state can be updated by writing to this interface.
>>>>>>>> +
>>>>>>>> +       NOTE: Assignment on one domain applied on all the domains. User can
>>>>>>>> +       pass one valid domain and assignment will be updated on all the
>>>>>>>> +       available domains.
>>>>>>> How would different assignments to different domains work? If the
>>>>>>> allocations are global, then the allocated monitor ID is available to
>>>>>>> all domains whether they use it or not.
>>>>>> That is correct.
>>>>>> [A] Hardware counters(max 2 per group) are allocated at the group level.
>>>>>> So, those counters are available to all the domains on that group. I will
>>>>>> maintain a bitmap at the domain level. The bitmap will be set on the
>>>>>> domains where assignment is applied and IPIs are sent. IPIs will not be
>>>>>> sent to other domains.
>>>>> Unless the monitor allocation is scoped at the domain level, I don't
>>>>> see much point in implementing the per-domain parsing today, as the
>>>>> only benefit is avoiding IPIs to domains whose counters you don't plan
>>>>> to read.
>>>>
>>>> In that case lets remove the domain specific assignments. We can avoid some code complexity.
>>>>
>>>
>>> As I understand counters are scoped at the domain level and it is
>>> an implementation choice to make the allocation global. (Similar to
>>> the decision to make CLOSIDs global.)
>>>
>>> Could you please elaborate how you plan to remove domain specific
>>> assignments? I do think it needs to remain as part of the user interface
>>> so I wonder if this may look like only "*=<flags>" is supported on
>>> these systems and attempting to assign an individual domain may fail
>>> with "not supported".
>>
>> This series applies the assignment to all the domains.
>>
>> For example:
>>
>> # echo "//0=t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>
>> User here wants to assign a monitor to total event on domain 0.
>> But this series applies monitor to all the domains in the system. IPIs will be sent to all the domains.
> 
> I would like to recommend against this. (a) this is not what the API
> says will happen, (b) behavior like this may result in users having scripts
> with syntax like above expecting changes to all domains and when/if
> AMD or another architecture decides to implement per-domain assignment
> it will break user space.

Sure. We keep per-domain specific assignment.

"//0=t"   This will apply assignment only domain 0.
"//*=t"   This will apply assignment one all the domains.

Hope it clarifies.

> 
>> Basically this is equivalent to
>>
>> # echo "//*=t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>
>>
>> I was thinking of adding domain specific assignment in next version.
>> That involves adding a new field in rdt_domain to keep track of
>> assignment. Peter suggested it may not be much of a value add for his
>> usage model.
> 
> I do not have insight into how all users will end up using this.
> 
> Reinette
> 

-- 
Thanks
Babu Moger

