Return-Path: <linux-kernel+bounces-371005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D919A34F8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 285971F252D1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DB5186284;
	Fri, 18 Oct 2024 05:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jl6MvWJ6"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4081714A0
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 05:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729231170; cv=fail; b=TZjBthNM7sDvR7FcuxU9Ss+MdIUf6Pfr3+EshFygOCiRCJC/Bpt2kbUllvJVYjtBP0SEyldrZqtVPex5MC7HOzmmxo96AWeEy7BEmtan7ENT/40b7od3qo1C9g86RwGre/o/1s7T36Js5r4CNKYIMyABD0b07hSXoSlN0uxHh5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729231170; c=relaxed/simple;
	bh=DhxSOvXDHSprHlPEGbVwPQBnpc2Kk3tnocuCFSrjjS0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A1ZtCDfvYtUYQNLaq0famIlVy1kk4eS4lgFuyHQESgxRJr+psUdulYr4RMDckz5fxBngBCaV5R6kvnhtvJMRPk4h4Vitw/xjcAb0YMTAQl2SJsNrZrzvLeTZ/MPa05DKQrNTtDFHq0n2yT3RlC8cMAfVY6w/2IQcGbnOlDfUMEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jl6MvWJ6; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHpTaBzvs9NjCoLU0OWEjJAbSfbQRrIn8BxZmikvv9NXw7k50KtvHVuuZo/+OucFgfzjw17dG0VUpdNyIafqmfG0EO8gGoqa7vcK65gf33vh+olNuoAyymebo2w8Ta2K5BY8TG0ysSx9Ge5hwbel9bQG5NeCu+xugiDsYBxAhPIz1exsFNDdP2u1fuafaMz7Dv+fqoL4sgizog/3heiZ7YII3vKTvDqzwF+PIWZ5v3T61x1F7gACj29DzNN2uZ7PO/eR3up73GhoenUPefkSl/dSvVTxd3pGNtFVZ+AG5o1ZJR8cY8tay0FmS16X7Ns4GuCB87omYbiBvkDADdPayg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFnPMUPwOYKuTeFEFjN0LAbLj/oQxK2rR3iykwYRxdc=;
 b=vkCz52F8SfJk966Qsh9RJtWfSe0YxaA3fYYatXzQgnhLQ1k39zi3UGbpTDwTYqthy8xs8foWT3qa53W563zbVY9baUD5CRWazsFlsNXH61ebrAdDa558P9KcHbyfPOuo+8Om/Hvy6VAQo7QziZ9UMiM64qaPsDnRrVI1x7Kb6iEeqpBngB4I9ksHvVVjd7fqLANjX/Szz3p0kL9ZV3lUadAV+9a4Cbi/JBjP7mt79+38aqj6RaTV9v0SIvfTIdJZ8p/obRw1K4O6RcnaCbT/8ghslJasYV8LtIQP44HjO74LWwUFqYJxcAkDnfgb7EGyvqr3sZlLlDPyprrCB/TbWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFnPMUPwOYKuTeFEFjN0LAbLj/oQxK2rR3iykwYRxdc=;
 b=jl6MvWJ6dpc1XEahnSz87Rd3SnYVTBuvKQOqFU9rgRLdKBu04r6tESdrtqZbfHBKKFxKiKTd3LB6npLktCJDAfuILWefYE2KyfNqW8Fd0BsPWA/D1YbWJHB4WrjOx8xZO3SINs5PGxaw40asmVz8ytOgXblOBkzGKjLZaaXAxPg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 PH8PR12MB7184.namprd12.prod.outlook.com (2603:10b6:510:227::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 05:59:23 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%3]) with mapi id 15.20.8069.019; Fri, 18 Oct 2024
 05:59:23 +0000
Message-ID: <4692a0c7-3eef-45c1-ba06-fa01b4f01d74@amd.com>
Date: Fri, 18 Oct 2024 11:29:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] x86/sev: Treat the contiguous RMP table as a
 single RMP segment
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1727709735.git.thomas.lendacky@amd.com>
 <3a9a4f94fefe3b4ebb23a7dd3d33d9fd7a344ce1.1727709735.git.thomas.lendacky@amd.com>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <3a9a4f94fefe3b4ebb23a7dd3d33d9fd7a344ce1.1727709735.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0125.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::10) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|PH8PR12MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: 4caf7f6f-d3d4-4d02-9f12-08dcef3a037e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1AreVpZVnhBeXUwSnI3NWMyVS9FTjdYaFRWdlIrT21BNWdXNGs3RDZZcjFZ?=
 =?utf-8?B?NHdnMUtqM3lQMXR2Vyt3T0VTRnZlOVRLWXlvQzlpVDUxQUdPd3RSQU12QU9k?=
 =?utf-8?B?OXpWTnVyOVVLbTZOdE9GZlM4YUVNOGlYdi9rQ3BFWEpJUmhoejJJcFZwcjFV?=
 =?utf-8?B?c3BtMUJacVNLUGNROUZ0UndiZERpK2pmWllsaEVOOGN2ei9iaGpYK0FlUmlP?=
 =?utf-8?B?Q0p6Lzh3NHlNdWh6YmNKWFpEcUUxMkl4elRqbGEwa0l1V2Z6Vmxod0RXSlZH?=
 =?utf-8?B?bGl1ODU3NWtNYWZONlkzQVMveXdRbWhnVytRNmQzQ2lWcVczZDV6YUhpNVBs?=
 =?utf-8?B?TjByTlJLb3g3NzFYMlpjdXhKTmdqYTQ5ajlyc1E1Z0xsSmpKa2lOenduVisz?=
 =?utf-8?B?N1Q1MlhROXRaQ0laZVptSkQ3emFITlNXa2tHODhVVUcySm9DQ0dxWUxGTTJ3?=
 =?utf-8?B?OWFITTVuOTNWTFdPMkpQc0pNalZSYzFQNkNOVlUwNElCNXBsYm5ucCt0UUZT?=
 =?utf-8?B?dlp4OEcvOGJvSk1XdmFOL2VWMWNWZ2doNjg3aWZQUE9NZXZIOFVZdDA3bmto?=
 =?utf-8?B?dy9WRlMxZmk5SWFOcEhtMkNTTnlwWkJMZlN5aXFldmdSdC94U1FrK09mRUVx?=
 =?utf-8?B?Y3Z1Y21QWWlJYm14N285Z3I4NHkwc095QkR6ZjlFK3VMRytKVU5FNlVOaDdQ?=
 =?utf-8?B?elVBeUtNZmdlV0JHN2tYSGp4ZHZkVjVueFRlK1ZTKzJzMjFBa0ovMXVteFBY?=
 =?utf-8?B?a0lXWkNBbG1ZZXduRzQ1WlRWZTYwcVNwSzBEUkp0YkxsMlg1U1VIOHBwSjM2?=
 =?utf-8?B?Mnl0K3hqcmNSWE5kS0h2bm5IdDBJclpPbDRyR2toNEUwY3J2djhXV1d3TEZz?=
 =?utf-8?B?eC9aSkozRDIrMkpNSzB0MUNpZTdmV0VBZmJLSVVKSkp5bVVjL1NtRFVzR21O?=
 =?utf-8?B?RnV1ZmRudXdSZXR6SjVKMldTc3VINnZLcXBwWEpuK2xIM2lsdzNMVU9SYWE1?=
 =?utf-8?B?K2tNWU1yNWZ4WTBWcXVTTnVoRXBKVGc3dHpQQ3F6LytnVnEwNEJaVUNCcjd5?=
 =?utf-8?B?VEJ4cms0eEpmMllJUm1OOGMxYTlSeFEzMWI5MEV0UTkxcGlBQWdwNjI0d3pr?=
 =?utf-8?B?V3EwWVVkNUN4NWhHQmViQStac2owYmtqeDdhcFNlNUtha0RVc0Nia1R0bkpG?=
 =?utf-8?B?WXJFaEZ2OGN6bmVjOWZxSElaMThBcmhPRVc2TGN0SDFSdkxRVVUxTExDcngw?=
 =?utf-8?B?ekNnNjZ1WUROLzZPeU12U1VyWEZ3U25LOGVHMkF3UXljaXIxQTQ3UjBxWjQ5?=
 =?utf-8?B?R2M0bzN1Y3I1Uml6OXcyYjgxMDNFWmdtc1E2RkZ0Z0NjUjhJTzc0SUswQ3ZO?=
 =?utf-8?B?K2hhcUJhVUZkTW5HWWp0YVprUE5IeFpGMjNwZ2JxclM2VnVCSzFGa1VrODQ2?=
 =?utf-8?B?MDNjeElPVVlKbnJnQWhFUEdFQ0FlaWVra2syMStTcTU1QTYxNE1pY3EzMmJO?=
 =?utf-8?B?ZDM3OGlWYXAwVTlaMUVpWWJtSzB4cnIxTjhzYmVFMGNmak5WNHVJNXdXRzk4?=
 =?utf-8?B?NDhvUWRkSEFtVEQrRVA5eG16QkdnMDJZd1dIMlZaTzZKSU9FQUdXamhkZ2la?=
 =?utf-8?B?cnZoR3NkMGJYWVRrU2MyMEo2a3RCVmY4M0xUZVR6SnZGQ2xlZXU2OGV2THly?=
 =?utf-8?B?TkRCdHdzT0Q1MzQva1RqZWdKbm9UNklNK2N1TG9pZ2czM3EvanJaZnNQSjMv?=
 =?utf-8?Q?UP3xWi7f0LiquJ3ZGB46gewjOwA9w6qfkl5Sy4X?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vm9FNEtheGQ5UkVkbVZ2N0kvdnVDQmczNW1nR1ZqYVdaZFNSaEZ5cXJycjdG?=
 =?utf-8?B?dU5ReGNHanVNSHh2QlRGcSt0cWhldVg2c3NrQXMzSHlqZDR4ZGpyNkhvTDhK?=
 =?utf-8?B?WlpNMHN1YkN3MW9qbktOUjl2KzBSWDFrUDNxYXR3ckQyWWQwQ3dIM0JYY0or?=
 =?utf-8?B?VzZGL2JyNEhzd01weWhBR2swenhkdStRSEtnbDF0NXBMU3Z2UHRXck94Q3c3?=
 =?utf-8?B?RGZVRk55cDFabnUvRlhPenhXQVJob1JZZnR6UWp3VFpYMi83bUtsNUNvYUxY?=
 =?utf-8?B?a3A3amE4cGI4ZUVaYWh3eXNGbnMyY2xSdHZlWGtZa1hIVmZzdTEzNUV1ZE1G?=
 =?utf-8?B?TC9uUkQ4MlRwZjNvRUpmYktSck56bVVBRGVJdGFtN0JYSEtRUzhSZmNoaFdM?=
 =?utf-8?B?VGI5blUvZGMvMTNqTDNtZkUzd3B5bFRxZ0lIZmNNV0g4NG9FSXcrYjBDQWtD?=
 =?utf-8?B?eHhrYktNNWtxYmgwTzBBelcrRkMvb09NQU02TWRZb25LdXFwd01QNGlKcTFY?=
 =?utf-8?B?MHlUeEdoMzUyTnZObFdIc0tJUkNqVTV4VnM1Y29hQWdubGhQNGdVdnpndDVO?=
 =?utf-8?B?Y29ya1MyYUtIdXU4YkNGZFI0SGlXZEpQT3d5d212QVlTOXRyZWFweFVOZkgz?=
 =?utf-8?B?c2haSnYwTGFOdWRPV1dteW8wTjVsQ0hFWm5MR292MDROSG1QbmdBYktuZHVP?=
 =?utf-8?B?bkVBcjJRc244VG5JNHdYK1lYc0dqT2RZSmdXZGZJWm00ellUYUduYnlEUTZS?=
 =?utf-8?B?U0llTXg2NU04bS9tNTJOUmxSU0RqREhoTGVnY3NIZE9NKzRYT1hFMWxBU3JI?=
 =?utf-8?B?czk1enRyZ1hQK1VlVVBxbkF4Zk5YVS9jbGlidGlxTlkxTCtqRm5SRTFOcnh6?=
 =?utf-8?B?cnJqVGY1ckhxOHIydld3L0FTankxZ1NHUmtXcDJWYkZuTnQ3cGZXc0lLS2k2?=
 =?utf-8?B?dlBYRzZMYTVCRjcreXZaNGZtVHl6MW90UmIwallaNGhCYkZUZ3JESGVpTXZ3?=
 =?utf-8?B?RWptdFVsSCtzRjhPOExvaHROaWNVQytUd3BDak8vb0JidXVadzh0Q0NBSmR0?=
 =?utf-8?B?eWpKNWF0NytIc3VzOHJ4UVQyd1lmTVhZWXgydWJVcmJEbVNRRTFKRkpkcUhL?=
 =?utf-8?B?MmlPT0RQYmwyQlpVcGNwNVFlSTVjRGR4NUg2ZEE0ZVQyeGtINTV6c01PSzVs?=
 =?utf-8?B?Y2V6ZWVxSHhURlVOQXRiMXBZTlZJTzZWeCtLeFFPa3MreitwK1ljZzQ0QURN?=
 =?utf-8?B?dGdsYjV6dW5jc1QxdyswOVhsWk8rRUo0RC9EOGxRRnZ3Q051eDhyRHUwOGJh?=
 =?utf-8?B?TlJCald0SlliOTdlMXFKNHVGc0ZYY1N1MUErd3psQW4wMU5YSDJNSngwOGJB?=
 =?utf-8?B?cnlzak9lQjNCUjFmZWdwUWYwOUhGS2ZkM0xFUUFwUVRad3YyYmh1SWwxcXRN?=
 =?utf-8?B?ZVBUazlWM1BOSGpNOHE4ZlpmV0lRb3d1dTdvLzJoRGRtSkFtbHdvdVJFZkZs?=
 =?utf-8?B?a3JhME5jTlErZEVLbkM1YWpoWGh4Wk9rUlpMS1BvWjQ5Tmx6d21WaGlKdyt5?=
 =?utf-8?B?N2NhT0lyQVRDTmxFU0JCbEo4Vy96em9NdkFOb00rK2w2d2RyTm83V2ZuNTBG?=
 =?utf-8?B?aTRQcGppMVkxdURwbGNXMno4VVA1UWtBL1U2UGh2UUM1cWcwQXd1dGRsOW1I?=
 =?utf-8?B?LzFOdjVGOUNxMVFuZkZPa21hUS82TThXaVVTbnpQQktSUWoxemhNT3JybnRE?=
 =?utf-8?B?eTZpbUE1bGVJZzJYdzQ1VzgyRG9yaWkxUGZrcFppdDg2S2pvc2hzVEUyVEZO?=
 =?utf-8?B?cHhhSCsxelZ0YkdvWHZRSzNtWVdKRStUWWt5N0lMZnkrYk5ndFVWYWlJSlh4?=
 =?utf-8?B?ZlhYRFRlNXB2L2J0ZzBFN3B1QjQ0dDEzMFAwR2hVbW1lL1hwSnk4TkcrRkpp?=
 =?utf-8?B?UEVzWDFvYlBidnBVTEJYQmRCL3ZzZENQRlhadnhuMHVWRnV1M0xmd2pMWGYv?=
 =?utf-8?B?ZTlyVnNKRURoaUk1MnpLK3phWXM3T0hXK3FHM2lTQzl0Qnl5ekFmYURzZzVi?=
 =?utf-8?B?TkUvSENKRk9vWnE1RFVIL2FDTVZCQkRXK3I3K1MzaFJTM1lWbVA5anNsRHRw?=
 =?utf-8?Q?bXMlVFrCTFebq7R7hlAVc8WWW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4caf7f6f-d3d4-4d02-9f12-08dcef3a037e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 05:59:22.9288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVx+TXmwh/GBvzEWAz159M3Dc6st8dBqwU99/7npmHgGxH+Mq7JEPsT4nSKGz8smpZvrgcUmHIdSzY27FNSIjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7184



On 9/30/2024 8:52 PM, Tom Lendacky wrote:
> In preparation for support of a segmented RMP table, treat the contiguous
> RMP table as a segmented RMP table with a single segment covering all
> of memory. By treating a contiguous RMP table as a single segment, much
> of the code that initializes and accesses the RMP can be re-used.
> 
> Segmented RMP tables can have up to 512 segment entries. Each segment
> will have metadata associated with it to identify the segment location,
> the segment size, etc. The segment data and the physical address are used
> to determine the index of the segment within the table and then the RMP
> entry within the segment. For an actual segmented RMP table environment,
> much of the segment information will come from a configuration MSR. For
> the contiguous RMP, though, much of the information will be statically
> defined.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/virt/svm/sev.c | 195 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 176 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index 81e21d833cf0..ebfb924652f8 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
> @@ -18,6 +18,7 @@
>  #include <linux/cpumask.h>
>  #include <linux/iommu.h>
>  #include <linux/amd-iommu.h>
> +#include <linux/nospec.h>
>  
>  #include <asm/sev.h>
>  #include <asm/processor.h>
> @@ -74,12 +75,42 @@ struct rmpentry_raw {
>   */
>  #define RMPTABLE_CPU_BOOKKEEPING_SZ	0x4000
>  
> +/*
> + * For a non-segmented RMP table, use the maximum physical addressing as the
> + * segment size in order to always arrive at index 0 in the table.
> + */
> +#define RMPTABLE_NON_SEGMENTED_SHIFT	52
> +
> +struct rmp_segment_desc {
> +	struct rmpentry_raw *rmp_entry;
> +	u64 max_index;
> +	u64 size;
> +};
> +
> +/*
> + * Segmented RMP Table support.
> + *   - The segment size is used for two purposes:
> + *     - Identify the amount of memory covered by an RMP segment
> + *     - Quickly locate an RMP segment table entry for a physical address
> + *
> + *   - The RMP segment table contains pointers to an RMP table that covers
> + *     a specific portion of memory. There can be up to 512 8-byte entries,
> + *     one pages worth.
> + */
> +static struct rmp_segment_desc **rmp_segment_table __ro_after_init;
> +static unsigned int rst_max_index __ro_after_init = 512;
> +
> +static u64 rmp_segment_size_max;
> +static unsigned int rmp_segment_coverage_shift;
> +static unsigned long rmp_segment_coverage_size;
> +static unsigned long rmp_segment_coverage_mask;

rmp_segment_size_max is of type u64 and rmp_segment_coverage_size is 1 << 52
for single RMP segment. So, maybe use u64 for rmp_segment_coverage_size
and rmp_segment_coverage_mask also?


- Neeraj

