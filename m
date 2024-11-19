Return-Path: <linux-kernel+bounces-414440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B3E9D2828
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 433D5B287C8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737041CC17F;
	Tue, 19 Nov 2024 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D6+mwsue"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6871991D2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 14:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732026206; cv=fail; b=jxtVkUQ0wc9G78ddj56Etq3ygRYb8b6N5WRrlosCtxMsza0EG1qhnPKfsMk1nkVojy6FKueW8RVArXbtUax1neTGOOWfx/fkOM8Oq1Gmx1un365WNxh0IE9Am1duTx1+FOrLjRuhrzPl5ZP+wmC9QQf0AcOeBTmXHzz2geT4Ka0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732026206; c=relaxed/simple;
	bh=aZ2fAvipz/L38h0CmUwJ+0IpWYpKAWqcxiMD41dS75k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nAlEaBTFUN4+F/a2De350GtXWfzFf5lHkBqb0vWJxurHBk1FBSg8ZPZXEPCC1fT/INn9bkunOw/uk6HYGm7o84634TLvdR732jFYTMdNoFJB/d8UQLHQEat+t19+v7WyADsCiURZtOkrKo9e7Y3kKPTGrhP8diVJ3h6syskv114=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D6+mwsue; arc=fail smtp.client-ip=40.107.237.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVqkK1TWho0RvPS4yMj469WEQ40y7qn3EdU/dvi3RBnNPQ8suBjjAbreAaQZL4Z1xANcycr5dJoUZPGUgWyLaopEflWV5uW9j1rBhXEqsKYSHTZnjGpjCAwZY+7s5W1+jKiPmorPPOQAhY2RP+lUtuRuFTceBNcwzRsnt0psxhjOq/rZhqAuwTzmFvjqvWw7UQlwUFM+epLst/lTDLpCOl4QdXLZbr6pu+yxFUVaRwJWgL0TbRMfR6gcCHclliV/SxAnrOT+bCKMYH6/iBVnkOZQN2fEhj+9T9uCVlADG7u6mij4xRYBzN0xNMPV0gfiPZ8sJ96plVSnPiCLjgn37Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6X/+YPCeU7yWwSdCWmnJ5y6MxFN80dN7JExru/pV7ow=;
 b=Zh4QQTH3hmODCkX6XIfP+GpQsxgGVCycjoa68IZ+zgxe3ATOvl7/GqKdbNYl68qikVGIjZbaWaN683hG9Sr0xGz5Ens9ekUK5ABjf4aIpJMhUiQhrhVRHh+ndoFWLLv6d6o6m1qX4qYs6OVCTyOcgrTiY+Foa4DQw3bvVNwH83dWnjhzT3HiA94wl3lyU1zm5lL+2F98lQGsKvqG8SEPTKBkF+A+7D7fkpRJInFlJZIbYdJcJxgXtMrcNsuA669WTPT7SDWsjLkYBJ3F7F30wdVU3wqIzsGvfV2+AB61TqUvYZjTdZpagheAwxQ24dcnoz7KbQ9MrZQWLo5FXi10ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6X/+YPCeU7yWwSdCWmnJ5y6MxFN80dN7JExru/pV7ow=;
 b=D6+mwsuea6G7n/GQ8PxkZSQwV26+TTwxHwxd2G1DItrCv6LSS3MFRu9F/D3MzVYK03hNOq95mUIleGVQDJZUCvghkZKDYgiTJW/D6wkD3XhejniORubCjySjNm4gaW3g2L+J9VnS9ewAIkAEQxUGkNp+h7p2x6DGF7k1BMF3r5w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CYXPR12MB9340.namprd12.prod.outlook.com (2603:10b6:930:e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 14:23:20 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 14:23:16 +0000
Message-ID: <fc2202de-595b-f561-dc59-08f32c56ff73@amd.com>
Date: Tue, 19 Nov 2024 08:23:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] x86/sev: Initialize ctxt variable and zero fi
Content-Language: en-US
To: Ragavendra <ragavendra.bn@gmail.com>, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 ardb@kernel.org, tzimmermann@suse.de, bhelgaas@google.com
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
References: <20241118225828.123945-2-ragavendra.bn@gmail.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20241118225828.123945-2-ragavendra.bn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0047.namprd12.prod.outlook.com
 (2603:10b6:802:20::18) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CYXPR12MB9340:EE_
X-MS-Office365-Filtering-Correlation-Id: 4839e7a1-6e62-42f0-2e0a-08dd08a5b57d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVpPZjJkQUhFdGlYbnFsZVBySWFMaDJhK05aWi82Q2NiYWorV1NLYXVDUTJl?=
 =?utf-8?B?Q0FZaEh2UjI0SkRoYjFIdDJaSUk2eXE0VDVPUElnYncvMkR3c1h0TVNES1NJ?=
 =?utf-8?B?TjhxQlNSNytFeTQ5emI4a2JpUDQ0STdzUFR4cGt0YWEzc0pySW0xR0o0Y0dX?=
 =?utf-8?B?UWdCeDNIcWNLOXNZWU41S0MvMHI4YStKQW5US2hLTm81ejZVWmIzOVovVjls?=
 =?utf-8?B?R3lvYXFNMStBWVpDVG1CSWVEeUpZSDBncXpSQ2JlNzVkb0VENDlrbHMyWFdY?=
 =?utf-8?B?bXJ0MHFxeUQwd3VtcXF3ZHFTcEJreVlQNytEQVZ1bks3Zm5ZTkdpQmpPcGZa?=
 =?utf-8?B?YWZiVmNHb29UWHNVTjF5M08xL0F6c3JSQ0JWOFZvVUhDcFVxdloySzhqeU5r?=
 =?utf-8?B?V0JqRUVtSit4YVNqOG9lSTJydXUxRGRHbzZBNzQ3YzA1MUlQc05YYUgrWVll?=
 =?utf-8?B?RmZJVWJpTkM4SkpRYXU5TG5LL2J0SGwvU0hOOUs2M1Z0WlcvNTIyS0VDc0gx?=
 =?utf-8?B?dCtHZnJHeEptLzBmWVdXL2lScS9TcHFGMjYxR2J2eG9oQ3gzendVZ3U2dmxD?=
 =?utf-8?B?a0NJWXY1VDBZZXdLTkVTcE9VbXBSd2dXY3c1YklEUnZBVyt0MzcyOWtLbDNs?=
 =?utf-8?B?T3FjSHZvQTdkK3c1Q3ZhUHg0VkJtWldPWDh5eG9GVVR0aFNxdzhUTzExd3hV?=
 =?utf-8?B?b0wrVW9tMEoxdjJqTEo5UzVnRDhaTG9meFN6NXc1S1hDRmN1RHZ5c0NMNkVy?=
 =?utf-8?B?UDI5RXFUVWNhWkxKS1JSR0h5cU1OdUY2Y2Q2RjNUWSs2c25zYnAvR2psR0pq?=
 =?utf-8?B?NDk1KzZqNGVzTTVwMEFDNXlzaUtzMS9MaXhvM3I4MUZQa2MzVlNobmFuVGZC?=
 =?utf-8?B?Y1RKa2pPUXliaXlvbEN4SnNGNEkzOXdITEpaZHZSZHlOelJCTFpsUk1FOHBU?=
 =?utf-8?B?Q0lZeWQ4WnBxMG9OUXBMTGpSTW5ja2x3VlliWWNjdWRQYzV5WHNMTnNNU0p4?=
 =?utf-8?B?Q2hGaXN3eVdHWDdwSUFCK0lMdHJWVDNaNFlmdXd1VlhEczd3cjFldjZzVU9v?=
 =?utf-8?B?WGdsamFIK3hYUWc1Vy9sbUhYSkhQS2ZzNXJ0UWo1VklhbTVGMGNWTUdFUjBm?=
 =?utf-8?B?VzN6RjVQVmk2clZwTlNpcGszVVBwZFFObEVxeW1rcXlhZm0yWnk5WmR6ZE1y?=
 =?utf-8?B?SnpiaENDSUNTRVVTeGN3elhqdVI3Vm9HdlowZ1YwWTBXV2ZtTzF0c2YrYUpP?=
 =?utf-8?B?TG1STVB1SE9nR0NzaGRUK1B3SzVsNXFxcDJ0dEFSV01wMDJrVWJKOHJWcHBl?=
 =?utf-8?B?amlrenBxeTYyWWt3aGZqUlN4eFFFR25TVVZ3cEFVOEo1S0crUUhWNjdVbGxw?=
 =?utf-8?B?c1ZVOEc3enRLUE1xK0hReVN4UUphS1BVRzkxNGxqMG5RV0ZPUG1WTUc5ZE1M?=
 =?utf-8?B?bkxBZWI3TUpIZEFEUWdEaENURjgxbkc4VmUvTk9QWHFzTFYrek5RT1hMR2NC?=
 =?utf-8?B?UDV4UlVRUXFCWFZRMnJkNElrTUNNcnB6dE1DRnJacHd0QVRRNzVrZ2VJeUhM?=
 =?utf-8?B?aHh2TTB6bmNETUlERisrRU12Z2VvS0Zhd0d3M1BVTW14U1o3Q0IrQXdDQlVG?=
 =?utf-8?B?OU0wTWpNcVh0WElkQlEvS3FPZ0ttRmxaYldYN3Zvdkh6QmlyUWJsZS9WMGlB?=
 =?utf-8?B?aGtlcTdFWStibHdoL2JiZlRIWVJrM1N3NVdhc1JGZTFpcGpiMUgxWU00N0NH?=
 =?utf-8?Q?fkpflhWC7PkFamhCg3rDF2tA4Ipz5TUJHMP0FWF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVlpMGJydFBWZlR4MnVRcGh1SXFrV0t0M3FLRytxYmVuaUlNOERCaTkzWGhr?=
 =?utf-8?B?SnRaM296UFQyZUtjQW1qc1F4ZllQSDV1U2tEZlgwN2wyWEVyZ1B5eXh0V0ZL?=
 =?utf-8?B?a1lyREE5UlFvWXZYaDJYQW8wZGN3WnFGTHF1dk1pT3Q2eS9lV3RkYnhObHVB?=
 =?utf-8?B?S0NTTU1nbmdhQ2lvQ1hsL1liMnpSUXJVOFdHNHlkckxtVE85U2FGL1dKTE43?=
 =?utf-8?B?Vnd0R01FWCtiQitETFBrV3FYRVBIUWZ5OWtra2ttNWYzNXVjTGxJNW1mR01n?=
 =?utf-8?B?bkhwSytmNEQyQmFxV2Zma2JRdTJmUk9FeGpQY2xJUEdsdU9jMi9rT1h5bE5U?=
 =?utf-8?B?Uys3ZkRVM1JBdWs4R3ZiUXBaS1ZHTWxSME96ODV3UHJKM2ZLUUNDaEtvRllo?=
 =?utf-8?B?TjkrRnhwZm9IajU5ZFluREwxeHNQaVBPRjlob0piMVFLMWM3aE43RGwwS25H?=
 =?utf-8?B?NDJVQXROZUUyWmc3MUtJRGorc0Rka3JsT1hKNkUwL3U4RDZ5WFNFT0RtS2Jy?=
 =?utf-8?B?c1BBR005b1YvM1dwYjRnTXN0OTRBYVNGblYwWDdTVWVnbGdHTzYzbk5kVVM1?=
 =?utf-8?B?T2R3WHErUSt6dWRRMWY3NXV2OG1HeGRCMWlrZzkzZzJPUHlkRE94ZThZeklz?=
 =?utf-8?B?dGUrSlFpcHpYU1ZkM0U1dG5RR2x6QTlmaWt5RFZvRGZneG5ybXQyTW5wbjds?=
 =?utf-8?B?a3JySC9lUDZjaHZ0T1Ezb1hxNkJESjNxaDFYakozakNtNlJJcm9aTC9kUjls?=
 =?utf-8?B?UVlCMVM4dmRQazVmMmJXQURZYUZjd0I2S3pBTEliZk9SWXBGMkdaQ3drQ25r?=
 =?utf-8?B?OEY3c2w3aWx6Yk1STjNJNDVENC9VNXhWSms3dVZxQnFzaDVGU3lwV3JVZHFy?=
 =?utf-8?B?MCt3RUdhMTRSdFNIbUJocGEvdGtOMnFoZkE2cUp1SVFxalZSZEx6SXNHN2d1?=
 =?utf-8?B?algxWHc0WjJoVUhHS1ZpQjM1VHJ1N3k5MmZ1dE03Wm5TQjA4Q3E4SHBXWGRt?=
 =?utf-8?B?Y2hmVUNNS0FyWnVBWjAxR0hROHRGRjhOSzB2Y3pmVEFlSkZxeFRQcVhZQ21v?=
 =?utf-8?B?a1FBTVV4OXVpcGZyc0VVMFE2WVREaTA2L3ZFM3E0Z0Y2Q2NPSXExTUlVMnJ4?=
 =?utf-8?B?NHFKTytRS3hzV3dtTnZJbUsxdnBQZ1hmTmZVeWZwWTliM29RZEFwMjE3Mmpn?=
 =?utf-8?B?SWhwQVJWdE1Ua1E3bnFuOUQvZFNVTDdDTVl1cGpUeUVFYVhhZGlvRDhNaG1P?=
 =?utf-8?B?NHNPc0FpWDVuRzlkbjJYWFdzWW9lUzROSGRub2tLVEZMbTlFUFAwZzhuWXlU?=
 =?utf-8?B?Ti83RGp0eWRaNGhZcXUvaFFPNEsyTE5yWDNoNUJSUGZ0T3ZCc0xySDlGSStQ?=
 =?utf-8?B?OXlvQ1QxZ3B6ZFRCaENCRnNrTExxRW4wVkZaM0pYL1QzK0RrK3RDemp3dDc1?=
 =?utf-8?B?Y2plZERKRDY3Z1N1UVNyL1pqOHFLT0VlWTFrWFAyZjU4SmFtTHYwREwrZ1lK?=
 =?utf-8?B?bGpObFhUTnA0Q3ZVNkxOSS92dytReDNremhjcUJ0YnlYdmpHWktMYXFmS2s5?=
 =?utf-8?B?WlpsUTFJdHFTVGpodzdFZDNjUEZVM0pNN2FxcDJGTkdSMkV5QVFJWkY0WjFy?=
 =?utf-8?B?YjFQYU1FMUNEVGp4RVBFZHB5VHp2RVI2K3hKbC9xODlXY25nNDFBY1BDTkFF?=
 =?utf-8?B?Ni9Lb2NJWGRmWlpMVlhCTlhDZ0NQb2VkMUd1RkJnOTFRelQ0QjMxTU9kSU41?=
 =?utf-8?B?L3ZLT2MrRDlnOFM5ZnpQUWx5dWoxditncnhSekhDMVFZY3dMYVVRQnlWeXlW?=
 =?utf-8?B?a29tU0lIWlNxelRWOU5Ybk9NTUd6QUlzTHpMNFNpVzR3Zy9WcDNsT2MvSUVk?=
 =?utf-8?B?WjdzWnQvT2czSk1QVFpJa1VTWlZLL1U1R1k3aWQ5TzhtRDJrYXJsVHhVY3Vv?=
 =?utf-8?B?N2lON3QzNW5BMkZ6RTA4bHM0RXh4Qk1FVlFmZjN3cTlhRFRPTm5VSVU5ekZG?=
 =?utf-8?B?N2RSaExqbFpSbCtGTVA4MnJvVjJSUlRXUUtyamRLbnp2djFRMmNocVN4dXU5?=
 =?utf-8?B?YmlpbGx6Y0loT29JYWIzWWFWV0FnaUhSSHN3dFNTbDZwaEZsSFQyODRNRE52?=
 =?utf-8?Q?jl+MGA+oTEc+JIkY/W8lM8Gya?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4839e7a1-6e62-42f0-2e0a-08dd08a5b57d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 14:23:16.5755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dy4pvus85JrixqBNAOkVxfwM/kBiSIcrQj++BPGztE7eRnXOA2s5bRCsSIg/Ei+HDNd2XEv9jKNuVDxt/cYUFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9340

On 11/18/24 16:58, Ragavendra wrote:
> Updating the ctxt value to {} in the svsm_perform_ghcb_protocol as
> it was not initialized. Updating memory to zero for the ctxt->fi
> variable in verify_exception_info when ES_EXCEPTION is returned.
> 
> Fixes: 34ff65901735 x86/sev: Use kernel provided SVSM Calling Areas
> Signed-off-by: Ragavendra Nagraj <ragavendra.bn@gmail.com>
> ---
>  arch/x86/coco/sev/shared.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/coco/sev/shared.c b/arch/x86/coco/sev/shared.c
> index 71de53194089..5e0f6fbf4dd2 100644
> --- a/arch/x86/coco/sev/shared.c
> +++ b/arch/x86/coco/sev/shared.c
> @@ -239,6 +239,8 @@ static enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt
>  		if ((info & SVM_EVTINJ_VALID) &&
>  		    ((v == X86_TRAP_GP) || (v == X86_TRAP_UD)) &&
>  		    ((info & SVM_EVTINJ_TYPE_MASK) == SVM_EVTINJ_TYPE_EXEPT)) {
> +			memset(&ctxt->fi, 0, sizeof(ctxt->fi));
> +
>  			ctxt->fi.vector = v;
>  
>  			if (info & SVM_EVTINJ_VALID_ERR)
> @@ -335,7 +337,7 @@ static int svsm_perform_msr_protocol(struct svsm_call *call)
>  
>  static int svsm_perform_ghcb_protocol(struct ghcb *ghcb, struct svsm_call *call)
>  {
> -	struct es_em_ctxt ctxt;
> +	struct es_em_ctxt ctxt = {};

This isn't necessary if you are doing the memset.

Thanks,
Tom

>  	u8 pending = 0;
>  
>  	vc_ghcb_invalidate(ghcb);

