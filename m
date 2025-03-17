Return-Path: <linux-kernel+bounces-563693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BA9A646C3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0EA21885A82
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC20E2206AF;
	Mon, 17 Mar 2025 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MjGwx7/E"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2E221E096
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742202799; cv=fail; b=m6B5W8ROqfpG0j9WDfGRZWD/cPQm+jX839v3uDmhT7aN3tNpfDIuSNLrsQVM8idNnxO2jOhnSursQv2j1O+71xCSKoqBUmraFbs4BNY46mHrJy0nsnYz79P4dK5NJPvDPTjIC/bDvaWPGy57oBs922844HCLew2CDG+sjJV0x1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742202799; c=relaxed/simple;
	bh=envX209ukd1faPwkYcU21iHG1IBySnW4apekA0CP5/I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iO2g2VTrMgNxroSb8SrTanR7B9fKMJDnZe+gJ/VzbKi/XPxh0+cj6xtZTcMxqlIOkbJ6RadvxjPKj9ZUwyH8x3/HzSlTy7ufbp82OuSrwpz1tmGskq4jO7jxswvCG5sDjaSFquyZ7ktMyhCdFd+Avenx7As0+UGC+Rq5mk1qwyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MjGwx7/E; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBIZAuFrhboURJramVdyGZY/yFYw/XM/Ht6Qh7h2aYKAJ6QLIEwnp0QxlBrzOP1YtCwO7v1pMYxjOY5yrlydclXl8H4WHJkXz1tgjKEgaEMElisAXw38v3BOtjnzyt2dDJiqjVMclmFmnESEK7f/glZh9XUAm1UP507ZXKYdIhdUIrcTzlVDU/Y1Q9H2RNB5l7z4Tsly+BEVD6FBObb669XGA6VFKvOw8afvRfapDxxYQaZre2lKPjSBtOO9ChhVXVjvrt1/TS3uqAyO4b2Ll1SSMZKoOHWzCtNRLtMySsE8XPVNmP0Z2aTeSlwuWS0cJEWzoXf+5wVR6IknrYvAOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQ7robRzlx9nmUj8HiBCLxSYvxX8FCLVHvjBmwe11Ko=;
 b=uTrF518TxIszmaDIMXisTfzneGTV+HV4J0eQjdapzIyH6vx9EmR1mZffSj/ziGSdkQ+mNRyb7R5mIW5v9Sp8++TLdJTCNgUdAo45ctlRlVHeXo5hTrNFH+gFh8bQxyGXTKwnL90C7MilVz+889/Qjvd3oDwM0H4X0aMxq1oBwhtbMEP2Yy586RwNIv5ciGL7TjCCjhqogIVI2d1wVMeG+e9YeOpPpFG1G2VYqRG7j4Ndvxr1NY7of0C+xwV9j3E0M0TP6rsbyun2aUOEmzHAH0i0V5TjtIbZ3mr3Q22kIx0Owb1KoLzgc7sV4yc99SjLvDiSa3WNvNmcCXK5ockrmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQ7robRzlx9nmUj8HiBCLxSYvxX8FCLVHvjBmwe11Ko=;
 b=MjGwx7/EB1ZL8k3aeYsc00OMA6BrgHCap/EXQyYovQoR5rud6oR8cfUbBVTUYY/au4QtjJDEaCOTZxfV6fQfD5ZGLNsngDTleO065txk0+mYudlhvllwiOy/9rRPkoBI6FtBHkkrg+sfi+ILwdkhuczaW/jbtBFgV1tp2xe17Un2FwwFUoaloepfJx9XMjzOkecDHClfxxm9TrFE2CZwl9IA1CjkzpYgpu2ivh5o5rptnZ1dsyFiFuq8nCTol2P7pViaGDlr9wxD7o3Cp6uqyu5KvIZ95dK6jMN7hnTE1vrB96I6mXX/dYAPi+7ihRZGb3k09Y7PeiRnFZdaD9++eA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7286.namprd12.prod.outlook.com (2603:10b6:303:22f::5)
 by BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 09:13:15 +0000
Received: from MW4PR12MB7286.namprd12.prod.outlook.com
 ([fe80::8beb:2d90:7572:13a3]) by MW4PR12MB7286.namprd12.prod.outlook.com
 ([fe80::8beb:2d90:7572:13a3%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 09:13:15 +0000
Message-ID: <b5d80ef2-fd5a-41cc-9184-6c82226c330a@nvidia.com>
Date: Mon, 17 Mar 2025 20:13:10 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: commit 7ffb791423c7 breaks steam game
To: Bert Karwatzki <spasswolf@web.de>, Alex Deucher <alexdeucher@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
References: <20250310112206.4168-1-spasswolf@web.de>
 <9a5df5627d3d72b2a97f501dfb7d944cc1e9920f.camel@web.de>
 <fdea59fe-f570-489f-bf88-1ffd47119cac@nvidia.com>
 <414f4deb8c7670a159854006b0c410ce05a6049e.camel@web.de>
 <12d950ee-4152-4ad6-b93e-7c5b75804b1a@nvidia.com>
 <705e95cec3dc5181ca2aa73722e6b84f63f3e91d.camel@web.de>
 <20b5823e-247a-456a-bb55-d50f212a9f5a@nvidia.com>
 <a34a1ae0b1d226b1bac7d73daa24da8e5899cb3e.camel@web.de>
 <c7bb0bd1-529d-466d-9cce-abbac4b480ab@nvidia.com>
 <146277bb0ecbb392d490683c424b8ae0dfa82838.camel@web.de>
 <b63b1de8-7eec-4235-b61e-e654e78543ba@nvidia.com>
 <fa8d5e76694918bdaae9faee9648776f298f78ca.camel@web.de>
 <7866593f-0322-4fb3-9729-82366940fc85@nvidia.com>
 <a168e78b-ae27-4675-8821-0b1a2499b2b2@nvidia.com>
 <5d34bfc5109b8d104fd4f8550dd17945344f9d07.camel@web.de>
 <551b9797-20d6-4bfe-b54c-84dd7aae7794@nvidia.com>
 <CADnq5_Pvmxa10dJWYjajwxG-0Y_oxhL6wS6NsG2F0dmcJS6o8A@mail.gmail.com>
 <9be36dfab79b17e108f71d51a6ebf39073e110c6.camel@web.de>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <9be36dfab79b17e108f71d51a6ebf39073e110c6.camel@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:a03:217::30) To MW4PR12MB7286.namprd12.prod.outlook.com
 (2603:10b6:303:22f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7286:EE_|BL1PR12MB5754:EE_
X-MS-Office365-Filtering-Correlation-Id: e54e6893-d75a-4374-4892-08dd6533f2d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDJCVW44NkNSWm9SdytBZ3JNQXhjRE11RlJpVngrZkJSNm5UamIwZmE5N21Q?=
 =?utf-8?B?TGljZFlnL3B3cFphSDQxVzZ1dTZ1Y3NYYVNmRi9rVUd1NDJVbkN5OEl2ZW9N?=
 =?utf-8?B?ZzhYN3BaclBTcVhIRm9jZXQwSEVGSVlwZnFCU1lCZUkvNWd1UjlWWXJhU25v?=
 =?utf-8?B?S1B4MDZTYVFHeFQzK25VdDRxb1ZUUUprVjhLbzM1QWdUN1Z0d2p6akJTMkha?=
 =?utf-8?B?VG95aERtT0h1SndUeGU0Uzg3ZmFnUldBdmdmM2orR2JBendGdDN1STg4RTQ0?=
 =?utf-8?B?Q1BtRm0zcEh5cVVVMGtVNTFJdUQ5L0dHVSt0YWpDRFR2VHlWYjE2YVZKVDIr?=
 =?utf-8?B?NDdCOVdVYy9udU5IeUxJSk1RaDhReThkeWZYTk1xeDZYdlBnVktkUGRtSEpC?=
 =?utf-8?B?YWcxRHEyUHFGTDEyL0EvTlhWQklPWXJJMUdybTZLREtBMGhpUmxIclNLMlla?=
 =?utf-8?B?VnBNYVFvMmtyM0hnVzR0NG1PR0N0cXVDZzd0QlVWTWp2Vno3QkhtLytMdVRk?=
 =?utf-8?B?K0hFMFA5T1RxSzg2RFo5TkcvbXJYUmtpVkx5Q3JTVW1JYnV6cVFEMHRZV2hY?=
 =?utf-8?B?dDR4bWlKcjk5eFA4c0tUVFFuUzV3NUhxMHJqMHd5ZWZtRm9nZ2VNdFFRZVZz?=
 =?utf-8?B?anV2d3V4MkFtSkNqWndKeWtQT3NlTVY2ZTVxQ3JOMk9pUTdyTE5aNHY1ckpY?=
 =?utf-8?B?NXp6OVQwTzdJUlRwamNTdkowOE1Lajg5b1hVRlBIM3lFclhyYlBCQmg2dG16?=
 =?utf-8?B?R2hMRHVlK0xkL0h3QjZzcTZPSHg3ZE9HOXhaTkJUNEU4NUUyUmdFUlRPVk5T?=
 =?utf-8?B?STh4KzR2K0w5c2tzTURuL1NHSVF3R3had1JvN1RDQ3FhRDJlUzhNa1hEWjFL?=
 =?utf-8?B?akNnK0syTE9qaG5FZ3pPUlF1R1JDRkRDOEdzZnhuV0hDc05ONFlWWkYvRnhq?=
 =?utf-8?B?UmZEaDhQNUtjYWNGVFE3NGdITXcvdHo1dUE3NFhoM0x2VDF4TEJNb0s5VktK?=
 =?utf-8?B?OW4vdWRUakR5WGE0cGFRVkRRSU1BWFd0TEEzbTAzSWZyWkc3Z3pWOFdUaHdT?=
 =?utf-8?B?RzlhWHlYam1LUmN6WHJOWXdKb2V2NGZKQTNZcnJGb0FCdEMvQktkQUFIcmhT?=
 =?utf-8?B?VndBbEVGOHZ0T3piNWpHYTBKTFV5QnBZb2V3L3gxRnhjaThmWCt1ZWNDcmhn?=
 =?utf-8?B?K2l0clF0TSs1T3VHMm95WU5LK0hDWmM3UHc5a3pBc3BBbXJZaTFyRFJQNWNQ?=
 =?utf-8?B?anNQTVpqZzNHRlJXekNPMU9WQWNSZzNvNUdmSUgwSWdkMEp1OWJuTHpIdWNZ?=
 =?utf-8?B?TkNTRThGUkpiU0RKT3JpVVRBT3NQejhXazV3dGZBQnhjRXdIVmxQbVlWY3FM?=
 =?utf-8?B?cG14M3Nnc3JrTWl1b2JGOTcwb0ZDYzNMQUt0am5mRWZUbi8rWllrTHhwcGd5?=
 =?utf-8?B?TUR6N1IxdFZsTGovM2E0NXZmNlJlS1k4bDhaMndDNHpHa2tET2MyYzZFUW0w?=
 =?utf-8?B?cDZkWXVZbCsrZHNyT2ZTTVFiZCtCK1RhbnBGdDFlY3pSaVJ1Q0tIODlSSWRS?=
 =?utf-8?B?V0p0ZVBkOCtmeG5YYzdYV3dZM1cvMzNUcnpJSmRRZnpacmNPUVp5SFYvTTE5?=
 =?utf-8?B?UWhNYzVIeW12MENFcXIwTFlLMk01U29McnBlQ00xMGpMWGMvV3o2bklCelNU?=
 =?utf-8?B?TDFrV1FKdnp3OEZnTVVURTYzbzFaY3BCcE9BamVsZS8rZkVPNU1lZnFCdHVj?=
 =?utf-8?B?bm53b0hkWSthSTJWVDFpZ1hMUWZ3Q05CNTZnY2VRQVVpL0lIbUNMZUhQN1VL?=
 =?utf-8?B?a2NNc2tJNHdIMzlhYTgyQ0xOQk1MOTU5R0pTUDdrTEF6L3lVc1dva3NiZ0NY?=
 =?utf-8?Q?fBREmGHMFPFk8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0E5MnhyRUdEMUxzTWdXQUsydkpTSFczNXdLMjZyMEdxN2w5V0hHeGNoQWRS?=
 =?utf-8?B?NVJvVG95UG8rYUFHdUYzNHpnd29zRGpmV0V4bVcwMFJLZW1pSTNTZk5DRXV2?=
 =?utf-8?B?OGhiU1hFWW93M2REQTQ2RUlrdHFpTHlQTTFEcERRdnVmTHlzTjRIL0M4UmhF?=
 =?utf-8?B?RjZudTNCamJTUmZqYVhQNk1ybTJYWWVHdVl4bHhkMm9FM2FVRXNEdHBTRVIv?=
 =?utf-8?B?RmMzMW9wbUFseGw1MC8rd1RDemRoYXJOZ2xNVDYvbEZRSDJ1VldwNkNsTU12?=
 =?utf-8?B?MDlyUng4dFJQZHZINUh3Si9QcGlwV0F3OGl2ck5WcS9aMEtJc3N2TFBjQlVU?=
 =?utf-8?B?RFhtd2EyWllNaEJ0aE5qRDVvdThwOUtWT2kybC9VWmhoQWxPOEJpSHJIUlFt?=
 =?utf-8?B?eEhyZ2tSTUlDcnNHY21xN05vdWxlWEtKOVpCUXVocVpJdlpMMnJCM3hTYUxN?=
 =?utf-8?B?QWtKdmVaM0tJd0NVYXVtQkMvV2hCZktuRDVhaWNzdGJGRGYwQkJwWEN5U2FH?=
 =?utf-8?B?T3JTaTU5a2RNaE1vZ1U2Z0xXRG5ScUJWK1FWZUh5T2lzZ1huSnE5TjVPajZS?=
 =?utf-8?B?V3pLNFBvbkJ3ckxIS1VzMGcraTdGNDE0R1U0M0Q2ck5YNGM2R3AwbSs5V1lx?=
 =?utf-8?B?MW1LWXF3RFVSdTNEcVc1dkhvUlF0bGdtNW9Hc2NscjM2RDI3SU9YZFpwaU8y?=
 =?utf-8?B?NXl5OTk1aVpHWW9pRSs3bVdKVXVBOTg0UWlWdnljaHR0QkhaTlpISHJSYk45?=
 =?utf-8?B?Y1laUGxuVTJncS8yekZPMjJzUk5mcjhWRjlpVU44MmloN3BDaGJMNlp3V28x?=
 =?utf-8?B?U0EyMlFtOWhoYmFsbWtVRloxektjR1VySFlIZGtPSU1reVBCM0RmTGk4Mklx?=
 =?utf-8?B?WTFrR3l3M0FGb1RTOHd6U3JJZkNmRnVlYnBINGNYOU95NjN0MzBOOVNVSUdW?=
 =?utf-8?B?c1VxZThoOW9xSEdvWldqU1JsTDdKaTY3bkd4Rk9YWHhWQnBtb243Q203RGpC?=
 =?utf-8?B?cUZYcVFPQXdoempPdlNWVzlMUU5IZUx5UkZaano2YktCRld6dk0wUThnbnd0?=
 =?utf-8?B?SUZlMmNMakp1dzg5MUtNK0lBeWxqL1AvY016LzVGaW9BNFZ1Vmh0ZzlEbDhQ?=
 =?utf-8?B?aCs5c21HbklaaFBsMUxqM000QnliMlNrUC8yYitVQzlUWDVxbERhT01hSFA4?=
 =?utf-8?B?WitGYnZ3MWxmSElYTW1uSFAzeUNwUFpnbnYwakpRbVlEcml0a0tQdU9maHR4?=
 =?utf-8?B?bGRtNExvVUI1K3Ixb0lkK3k1QXkxMmorb3ZyZHJFd0xZSW9sMTBVRTlXM1JN?=
 =?utf-8?B?ZU44VWJvckJMTExtTW9uMWZYd05PY2Q4eG1OSVJhLzk5R09iSVN3UWtGMi9K?=
 =?utf-8?B?NXBvbG9UTUFJbGhoWGJVcm1RRnhtZThnUDM2dHVBbitXeEJZY2tEL1oyNWs3?=
 =?utf-8?B?ZGZjM0JCSHkvNGJCT3h5R3JEZTNkay9wb2FNaHBkZDRIa3Y1NDlMNWRnck5p?=
 =?utf-8?B?bERsSTFPUGtQd1RwVGNQMjFWWGdFNlY0QXlVUHZOUXJvWGVoblZnMU9hUTBz?=
 =?utf-8?B?aHMzTWRaVHJsK29SdHMrcFMrSUVDR1dZMXM0ejh2QTdZaG00eFlDOE9SUHha?=
 =?utf-8?B?ZGtScC9VU3JCdWNvQ1AzMjJQSjllT2MxbjNxUyt4VlBUeXozT2RGWUdaNjd1?=
 =?utf-8?B?TkxJZ0lTby9zRkRVRjZXcG5pNnhodVMvaTZLS0U3WXlNQzA5NDV3NmEwRkFh?=
 =?utf-8?B?NFVGUGZZZkJDY3E5bG0rVzJCVW1FRzhXWkU5bW5aYURkZm9zRmZKcHVzMTYv?=
 =?utf-8?B?M25tV3FubWtuWTlucnUrdnBNWUk2V3kwMEJ4eTlIK0RkaWpvaHdiVytEdmdP?=
 =?utf-8?B?eEdGaDgyVCtmM3hiNG1hWkVIVXpiVUZaSlpXUHlkM3dlYjZyemZRczh2UEJO?=
 =?utf-8?B?ang0OGNiRHRVQ2wyYlJnT1dCN05TZkVuODJMSWhJdkphaWlnUXlKR3EvR2ZO?=
 =?utf-8?B?NDFsVFNsS0diNjVKenNQRlZnQUJCcHJDZC9RM1JrTVlOL0JuOTU0akdKcVl6?=
 =?utf-8?B?SGIwajBpbEJmQm1iYzlnelRzcWpqQVZHaFE3WFIrYUtEWG9mUTlnMEhVQWQx?=
 =?utf-8?Q?nPYhwtFmguaVV0JvOaV3InuDk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e54e6893-d75a-4374-4892-08dd6533f2d8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 09:13:15.0343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lWvF4b0YR7ZluT1jUr8kJhspWHGX5CHwui4LITwfGlSZP3xl8LGIeSHUGMAaZxUClGBeyeGkGc53wR80M7Kirg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5754

On 3/17/25 00:09, Bert Karwatzki wrote:
> This is related to the admgpu.gttsize. My laptop has the maximum amount 
> of memory (64G) and usually gttsize is half of main memory size. I just 
> tested with cmdline="nokaslr amdgpi.gttsize=2048" and the problem does 
> not occur. So I did some more testing with varying gttsize and got this
> for the built-in GPU
> 
> 08:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
> Cezanne [Radeon Vega Series / Radeon Vega Mobile Series] (rev c5)
> 
> (nokaslr is always enabeld)
> gttssize   input behaviour
>  2048		GOOD
>  2064		GOOD
>  2080		SEMIBAD (i.e. noticeable input lag but not as bad as below)
>  3072		BAD
>  4096		BAD
>  8192		BAD
> 16384		BAD
> 
> As the build-in GPU has ~512 VRAM there seems to be problems when gttsize >
> 4*VRAM so I tested for the discrete GPU with 8G of VRAM
> gttsize   input behaviour
> 49152		GOOD
> 64000		GOOD
> 
> So for the discrete GPU increasing gttsize does no reproduce the bug.
> 

Very interesting, I am not a GTT expert, but with these experiments do you
find anything interesting in

/sys/kernel/debug/x86/pat_memtype_list?

It's weird that you don't see any issues in Xorg (Xfce), just the games.
May be we should get help from the amd-gfx experts to further diagnose/debug
the interaction of nokaslr with the game.

Balbir


