Return-Path: <linux-kernel+bounces-557008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF93A5D254
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 23:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF1C17C332
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 22:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC232264FB5;
	Tue, 11 Mar 2025 22:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NCZcg+tW"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059CD262819
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 22:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741731028; cv=fail; b=oNBfrqE3ZqM9GeTdpQHWFDM7cYTKJKPTGOlMy+PQTvm65HZZQZYAdJyAHrtmUnsRgtWhbD0AGTJ+iJzsVdRzYqFmELFSYbnQBevEu+fppAAJ5Vn2sreGIBuSsiL3oWHeXb7y1JWliM6Y8m6BwUKK4wqppoe5oJ3cSwJ9y8u24Nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741731028; c=relaxed/simple;
	bh=cHgDcv8XcOIt+Gh/oVYLRX/XwuPq9gVnvYQ2hf8/jjM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Pbp+yNpWVFvzv2J499yJz4kQJblf0hwsJlFUk9vk3IJEDBZklsOpZGCuO80rJzxyonXJNLCmzrZjZlcHgWijAf/T/SSdR42VDddTi/Xb3iFyTjbVDBLiTyrt33ZSmXbEmgh/jcDwXApfUa9vKB5VcIIQtNKBCB15WCB7mUs2TaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NCZcg+tW; arc=fail smtp.client-ip=40.107.100.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSHKv2p2KrUAlycMlEiXgq+QqrJm+9Dhv+koJPeHNLV88qvcr0M3ctoxGnsiA6DfaDZHU2x5P/8DeTsceGn2RhL7rdDdByR/uCGhMeD1qhR3qJf40KKFfX9ifkwvkBQoY/kZ+UjNBgSqRG955r+TxuQqhbGYzESW15YwqRz72sMxbgle0aNjENJ5t6W/bgd5yq19Ql7gtMCoJiSlGhbrUI6R06s5OXWmoQm5KuoLpF55S1FSu2sZRVDgY11fgYKxyNDiDnZNssFHlHSk5p9xKZ7kDGoSG7/zsITU+6tBpK5ZIXBbW8gcNObj621bWua8xNKFTYPGPhugQobKouh+aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4DSjHkgMFDa82M44V+KW/0aXCJyWtQvsW9GnBSlCGI=;
 b=gZEpL0NX+IzqRNs2prAW7cPwMKqIjOV1oH8uzamYb7lYQhSHUxDsHR6NLFI5PeVA+3we9GDuJ1NS0z51r0M+59mV++rTP5XyzHyW7t2itBi6ENZqU/ZTBXRW70u4MU6Dv2NkffUKB8J60fX/c/0NeghoU3pyTAETAQ9xl6TIzRzQpdiGdlPT57/SqDKjuJJS9I+09O3KPJZcRn40vAcc4ISvmHWCsHlBy2sxCNegHD26cQIoG0SdslyReNAlQMkaExn3gwsFxT6wQSCAm4qqqB2gV52tp2lMO1d/fgla8CFF60+xlaEZWJnP7ay1xNgBL5XMJikSWw61SRMlhn0jpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4DSjHkgMFDa82M44V+KW/0aXCJyWtQvsW9GnBSlCGI=;
 b=NCZcg+tWVzxWppST742uP4Boy/xrdoVnZJzPccVV1lgkkBj8Q4mq46f5sujXEUx15MkkWfJgfWNhgZ3SExgJ7DytK+ShWIY5rlrckJp/Lc6L89CkbfH0NyDBpW6ba2Qh13gBHZF7YtJ72/6jOjtzy6e1IigkKB1nuhV6JYwsELZsPnGSJb2adXd6Z0MITjBiEFhmhCrnEYG0AnlH2bVekzRCBtZwmCOKb1e3TUuQZPywYr4gQeXo7rs3qNvYYIsXuI3xd8JG43Y4o01/r4gM9LHfOct2zrw4OcO6qOj5FqqgdzOEYYuSd58hpdKV7rRYYXz9XX4h3UYFy23ZffFpjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 by CY5PR12MB6552.namprd12.prod.outlook.com (2603:10b6:930:40::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 22:10:24 +0000
Received: from SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868]) by SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868%7]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 22:10:24 +0000
Message-ID: <fdea59fe-f570-489f-bf88-1ffd47119cac@nvidia.com>
Date: Wed, 12 Mar 2025 09:10:19 +1100
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
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <9a5df5627d3d72b2a97f501dfb7d944cc1e9920f.camel@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0070.prod.exchangelabs.com (2603:10b6:a03:94::47)
 To SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB7272:EE_|CY5PR12MB6552:EE_
X-MS-Office365-Filtering-Correlation-Id: b910edd2-cfe7-4942-5562-08dd60e98555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkNubDl5d0RGRVZjdm1PbHUxcURRZXpjNXVJQnJrYXZHbDZTYnBHTEZJWVg3?=
 =?utf-8?B?OU5xdGs0ajZnelMrMDdkbzh2V2NKVG9tL1lZRlp0U0l4QkhmUkowcmZpajR0?=
 =?utf-8?B?MHNISHhRdUtUZ0NLMmdFQTZqYklzby9hVDI5RnFzYTlsRGxWV3JoR3gyUk02?=
 =?utf-8?B?VndoRG04REtyVWg0eWxCNnBLMWZ0YVc3RXZjK0QveEI4RXVaUEJTTDNnVHlX?=
 =?utf-8?B?eW9KQWFOYW9GVkY3SFpRc3Y2OFlOb2RZWExuSFhESmxLbGlxWE9BeTllb2ZX?=
 =?utf-8?B?UUVNSEJQbWd1SG0wWEVMcWE2OFd2Ky9JV2dLOW9LV3BFVmRRUmNMengyNjNQ?=
 =?utf-8?B?bWZINCtPTFV2L3RYS3d3aVJUYXhYTXRibng3KzhQcmplS2RXSENpcFh3Y1ln?=
 =?utf-8?B?WjBJRlZnNlluQzRaVjlWZDBDL0txOFVqOFYxZTcxNE15VGF5YkM5aDNVL0Mz?=
 =?utf-8?B?bXlDdHg0eW1talh0YXlQNE9aTXFXSTRyS1dpQTZFdUtabFFuTDhIWUF3Smd5?=
 =?utf-8?B?ck5XcENtUVJhY1F0Y3hTRGh3ck5wellXaGlScE4yQ1cwYWQzZWZONEovRXNV?=
 =?utf-8?B?UVRRMXY0WlVOamQ3emR1MHl1Tks1RURzcGxpZWlXRmlGUXM0bVZQdEV2clJO?=
 =?utf-8?B?QVVXRGt0OTE3S0VRc0RrTlRXdkNISWMvcHVuSkFKUW5SSGpwSUhpcFUzYlk2?=
 =?utf-8?B?UmtCdFBhU3E3N25jTlRhejRYNFRUQUpZQk9nbWRMdU0rZVF0dWJJMnBGc0ho?=
 =?utf-8?B?MFJDeGNEckdZUlBoY1V4R1lXNit6MXA4ZjRnSGNWWWg4QWdQYUlSUjlwSldK?=
 =?utf-8?B?L29tbHZOdGhIWmpLZ013VzJ3YndPdHBFeVBTejFGa21CN0ZpRHY3NnNjMVBn?=
 =?utf-8?B?ck1xdkdxRXYrOHlPbFdnN2tRZVdmb014NmNYdWY1SHFtTGtQU2RGblJLZTdT?=
 =?utf-8?B?TUtWY01rQnBySU9wL1QxenNhN0c4SWRnOTVnUS9SeE8rN1FhUEJQL2tTK09O?=
 =?utf-8?B?WkYxNEc4cC9JRmhGRSt2cS92dHBGT0djVTZQWW1FN1NHVzFUbmlJb1hJWXdp?=
 =?utf-8?B?WFduREljbTZlZGU5WndWcHRKYUhEUVNFTmQ4eG5HMFJVbVpsK0d3M28zVU1Y?=
 =?utf-8?B?QS9IYk92MDR2NE9DYkwxMjdqaU8rRCtGdkJwbUZJQUtOOW5PbjY4QkY4alc3?=
 =?utf-8?B?OTdwWDJYSTBPRXVpUEx1NFUxWXQyYkZBZXpiQkxvRXd5eUtadGdDeEFpaFpq?=
 =?utf-8?B?R0VuWHoycHgySFc0dkJEeVBqU2Y0MzU5QzNaczU3a2FPVGVEU0ovQ0NsUkxV?=
 =?utf-8?B?MnlpeG53SVRNS2xQbjgwR1Z2NHBkVDJ1eGJBQW5xdVh4K09KWmtjWVVUakZ6?=
 =?utf-8?B?aUU4bzJ4WW5XZWVxcE0ySm9xNHUzUzNJL25XZGNsSE83YitLLzJZNExiVXVw?=
 =?utf-8?B?bFhTOEFGcUJvMEVHQ09uZTZPaEVRNU0vaHVaV3FqSURlbHo3YVY4TWhXVUdN?=
 =?utf-8?B?M2ZQenBaUVRkRVk5S0doL3FHTjQ3OHliZnV2cGMxVWM4TXhzenhYZjhPM09C?=
 =?utf-8?B?ZUF1bVY4UW11bW96UUFGam5uV1h4YXdOSkJUMXNHdnQzVG45T1V4ZlpvN2ZN?=
 =?utf-8?B?UWI2Q1dVUi8zZDRLTFp1RkxicHFCWUUwaXgxYmN5SGg3U0Z3SkxMNXNFbmVL?=
 =?utf-8?B?ZFNUTmw1T1BHQjQvNkkyM25LVzN0QXBGNmxXc2Zuc1FUcEl1dUJFUVUzRDVN?=
 =?utf-8?B?Vk5MS1NoaDFSYnNWdGhPeXZKZ3JpRERqY0M3ODNkMmd0NTlkVmYreGhBU0N3?=
 =?utf-8?B?Q0s3cjUzVTVrSEhFM09OVCs3UGs1Q3Eya29UZWx4TEVPdlVRbEFWSWpRRjFK?=
 =?utf-8?Q?W+ISq8txBhUAY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7272.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUpCQTc2SktSRmlrTFVQSm9MNlBpYjM3Yk1NVXRHczRMMkRpOWFydHFUN0pp?=
 =?utf-8?B?Q090Wk5CYXRVMk9NVjVrUGlFc1F3TjFkWE9HVzdCS2FWeFh3eHZmV0VpbVBv?=
 =?utf-8?B?TkVqWUdpL3p0VVRVRFBRZitkUE1zRExOczBNK000U1cyaXlTdVBhbU94SEds?=
 =?utf-8?B?L0ZPbVBIdVhocEJaeWxLUHI1bHZHRUZoZGRON0ttL1g2UE5NaTQ3RFU3SHRE?=
 =?utf-8?B?SVEycjlKMlEwbzNqVlpwTy90YWJoampOTXJ0Y1dkTTVTRTdVcnN6MUUvSWIr?=
 =?utf-8?B?aW12RnJFM2J3ZlR2V2RyQzRCeCtBQmtkbUhNZndJczVtQTFobEVMeWJjL3Qz?=
 =?utf-8?B?MkFyR3JjVFhDR05KTEtaN0JpR2VjeVJmOXlpUUVtZFJHd1BScHFCMUgxS09o?=
 =?utf-8?B?QWRGUU1IMGJtUENFeEtIaHhnTC9DcnJXSGQwdlZUVlBuaDNkcFlVWmdFVGJE?=
 =?utf-8?B?THVveitMY2k0cDgxK2cxRlloaFFUdjBNZmUwSnh0YWtsMThCTmMwWXd5S1Rx?=
 =?utf-8?B?WkxhTngzR2U1YmVUTVJUNCtLYm91ZzRGb1hKMHY4ZHpxS2NZTnloaU9YcE8x?=
 =?utf-8?B?dlNyYkVIaE8vek9qUERzQ0VOeXB2MEhSaXQ4WUpKZXVwL0hNL0xzK3VtMVNr?=
 =?utf-8?B?VjFKZE1iUHgzOHV2Zk1iTzA4bi95ek5mTGZyay9RcWpnamh1a0h1c1hPQ2lK?=
 =?utf-8?B?bmdqMmRtY1UxcnhwVWtqYUhrZ3h5ZTQ4bE1QSkxUUW4wb0kzZGVnNEFFeDJY?=
 =?utf-8?B?VUtDYU5UUjdxVnNMU1ExSWh0eVNFb2FJcmxsQ0pWQVVpRXIvT1NkVEU4aEJ5?=
 =?utf-8?B?TFFBYk9QQnJVUG05QmVnNXhIRUFjY2FEa3ozdVJ0WHllbWpJVkJscHJuRHlH?=
 =?utf-8?B?YVVGb2JZNEZiNkdyWlo0RG5iS2FRM0JQQ0hVQlZDV3kzNFpGWVUrWlNmUW1x?=
 =?utf-8?B?dEhZL3JRWVVXZGo5OU9ZcXhtZ3IyTU9IUExXZ21GdmorZmxhMlBjY1dFTWZq?=
 =?utf-8?B?VFZQVEU1STVQaUZTS3VDNitSUndNVmNkWlp0Q1NNbGdaVTc1emRZTDNkTWxP?=
 =?utf-8?B?WDlOUG9WZmN3b1FWSHd5bmlkVSs4b2ZwV2xHb1VXQUE4WmZ4d3JSM3AwK0Fz?=
 =?utf-8?B?aTljRm9SeG5yTzNTVFljVXoyUmVrNmpOMzJDdEJ1aS91cHA4OXIwWnB0OGVN?=
 =?utf-8?B?SkNjc3B1S1JWd1ZPdFVZeE1RMk5OL0pzaUEvbTBGUDdIemxneXYwWlg2RmhQ?=
 =?utf-8?B?WmEwbTJzREJNTzVVbjVyWUg4SDhvUWZuSjJ2RUVrVHFsUjBPTlhyalJtVFBW?=
 =?utf-8?B?R1pZQ0YwYUlSb3BTTmRIVVYwb2Q1cFRPMmRaUjVLbk9McjdJSGxrRnYraTk5?=
 =?utf-8?B?bko2aENKeUw0UzkzMkVMYTVHSk9HaE5HRU50WkdCYXUvcDZFVW1mYUhFV1Bw?=
 =?utf-8?B?WlloNnRxTnl1NmtRcy9QMVRONnpmS3BNaUpGWG9kd3hFY244QzdRazFuZUdp?=
 =?utf-8?B?VVBpaldYQ1ZmbTNZL2ZaSm80N3RUVXpMaGVOZVFiNW1LellBWk1zMUZmMnpE?=
 =?utf-8?B?M2ErdmUxUmZMTWlrYW9RSDVWWC85OTJ3UWNFSEcrU2N0bU5tUW9EM0lBaEpi?=
 =?utf-8?B?NVJNMWdmQWVmc0tUcXRzU0tMcWxPdGhPbEIvdXBBbnRtdWluSm5wcS9pTGF6?=
 =?utf-8?B?R2tBOTVLYStDTm94K3owb3pEREI2UThJekMyTWpmSDRGVGxyQ3VVUG5vSk8y?=
 =?utf-8?B?dHV6c3RVUkh5b3VNMnZtdmhzOUR2V29veTNDTGtiVDYxSFNLa3ZEb3BLUzBy?=
 =?utf-8?B?L2g4dS9DeVNlZHY3Njc2bVNvVjVReWYzeDV5OXM1V0NacGZGZmZVNGlBUkUw?=
 =?utf-8?B?SjBTQXY1MkZkMjhNN0MzeFQvNmVCSVNEVEZnR1VqSzVxN3E4enh6cFZCcnZB?=
 =?utf-8?B?NEo1SEFPVzIwalBYMUpNVEwwRS8wVVppSFV3ZWxLSlBjMUYyS0o1ajA5OVF2?=
 =?utf-8?B?VlFHZ2pjMit3VmpBZHFBMHIxcElqZS9LWlFpaEdnVG1QTXNMUDRzTjZZM3V3?=
 =?utf-8?B?QjRPdWNiWVBLeEZGNFRUbFZvd3pXMGw5eEVNMTQxbXBtY0hXb2dsYXkwQ1ov?=
 =?utf-8?Q?PzMHeV/LHTqCRwCUWztybVjAi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b910edd2-cfe7-4942-5562-08dd60e98555
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 22:10:23.8875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: asZk8wYeMo5ft1YJIdhQoTt+popNEKQ0oTLjIIdOEVSKT4hHcQT1umJQ4pAjdXOCq9rKn4syuN0jFtYx8FsxNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6552

On 3/12/25 05:24, Bert Karwatzki wrote:
> Am Dienstag, dem 11.03.2025 um 12:15 +0100 schrieb Bert Karwatzki:
>> Am Dienstag, dem 11.03.2025 um 18:19 +1100 schrieb Balbir Singh:
>>> On 3/11/25 08:48, Balbir Singh wrote:
>>>> On 3/10/25 22:22, Bert Karwatzki wrote:
>>>>> Using linux next-20250307 to play the game stellaris via steam I noticed that
>>>>> loading the game gets sluggish with the progress bar getting stuck at 100%.
>>>>> In this situation mouse and keyboard inputs don't work properly anymore.
>>>>> Switching to a VT and killing stellaris somewhat fixes the situation though in
>>>>> one instance the touchpad did not work after that. I bisected this between
>>>>> v6.14-rc5 and next-20250307 and got this as the first bad commit:
>>>>>
>>>>> 7ffb791423c7c518269a9aad35039ef824a40adb is the first bad commit
>>>>> commit 7ffb791423c7c518269a9aad35039ef824a40adb (HEAD)
>>>>> Author: Balbir Singh <balbirs@nvidia.com>
>>>>> Date:   Fri Feb 7 10:42:34 2025 +1100
>>>>>
>>>>>     x86/kaslr: Reduce KASLR entropy on most x86 systems
>>>>>
>>>>> Reverting commit 7ffb791423c7 in next-20250307 fixes the issue for me.
>>>>>
>>>>
>>>> Thanks for the report! Could you also share the dmesg? Do you have any proprietary
>>>> modules loaded? Could you also share the output of /proc/iomem (captured as sudo)?
>>>> The lspci output is useful, lspci -vvv (captured with sudo) would help see where
>>>> the BAR regions are, specifically before and after the patch. Could you also share
>>>> the kernel config?
>>>>
>>>> I assume your config has CONFIG_PCI_P2PDMA enabled. Did the system ever work with
>>>> nokaslr for you?
>>>>
>>>> I am a little surprised that reducing the entropy causes these issues and having
>>>> a larger direct map causes these issues.
>>>
>>> Hi, Bert
>>>
>>> I tried to reproduce the issue at my end, but could not. I am new to Steam and my
>>> hardware/games are also different. From what I could gather, Steam is a 32 bit
>>> application that uses SDL. For my testing I used Xorg, not wayland
>>>
>>> In addition to the above?
>>>
>>> 1. Could you confirm if the mouse/keyboard work outside of Steam?
>>> 2. Does evtest /dev/input/<mouse device> show anything?
>>> 3. We could run the kernel with nokaslr and see if the issue reproduces?
>>> 4. As a test, we could try disabling CONFIG_PCI_P2PDMA in the kernel config,
>>> build boot and test, this has the same effect has not having the patch
>>>
>>> Balbir
>>>
>>
>> 1. The problem is not with steam but specifically with the game stellaris (which
>> can be started without steam). As long as stellaris is running there is a ~2s
>> delay in keyboard and mouse input (for everything), killing stellaris restores
>> input to normal.
>> 2 evtest /dev/input/event{1,3,4} (keyboard, touchpad, mouse) seems to show the
>> same output whether stellaris is running or not, only if it's running there's
>> the mentioned delay.

Thanks, so the issue is specific to the game and running it?

>> 3. For some weird reason my kernel does not recongnize the nokaslr cmdline
>> parameter, so I build a kernel without CONFIG_RANDOMIZE_BASE and this does NOT
>> fix the issue.

Can you clarify if you're booting with the compressed image bzImage/vmlinuz or
with vmlinux?

>> 4. Most surprisingly removing CONFIG_PCI_P2PDMA also does NOT fix the issue.
>>


> 
> I've done more experimenting regarding 4.:
> next-20250307 with "CONFIG_RANDOMIZE_BASE=y" AND "CONFIG_PCI_P2PDMA is not set"
> works as expected (i.e. no input lag when stellaris is running)
> 
> next-20250307 with "CONFIG_RANDOMIZE_BASE is not set" AND "CONFIG_PCI_P2PDMA is
> not set" also shows the buggy behaviour (i.e. input lag when stellaris is
> running) (this was the configuration I tested before)

This is an interesting experiment, I am beginning to wonder if the system relies
on a reduced direct map for the game to work correctly. Can you also check in this
scenario if CONFIG_RANDOMIZE_MEMORY is disabled?

Can you please share the dmesg
1. output before and after the changes?
2. Do you see any warnings/errors in journalctl or game specific log files?
3. lspci -vvv output before and after the changes?


> 
> As a sidenote, I've tested several kernel with nokaslr as command line parameter
> (6.1.128, 6.8.12, 6.12.17 (the debian sid distributional kernel)) and nokaslr is
> not recognized as a command line parameter in any of them
> 

Please see my comment above about booting. How did you check if nokaslr is being
recognized, is it via looking up dmesg?

Thanks!
Balbir Singh

