Return-Path: <linux-kernel+bounces-565402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37382A6679E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92D73B36C5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99DF1C6889;
	Tue, 18 Mar 2025 03:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QdG8MSFv"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6741AA1D5;
	Tue, 18 Mar 2025 03:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269329; cv=fail; b=KbB3sIO5m1tjFTGVikbChCbRvRTCnDnNCZtiBOx14ReCdxSHin7Zze9MkiAwv6cFQKD/DZrKNIr+aqlr+fxkAGXHL98/uZ96M0qBhXVygu2fZuEqLwB7lQlD2QXQ222dpHw/qJ7y8cd3GG7IYurAEBxYSgIx1oHDJWTGFMBVmNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269329; c=relaxed/simple;
	bh=nnvE41nTIK5pkz9wAF10Qwl0chheUoMIoAmSVdoVIHc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sjQ9bxgTfNziQuoO7kSVnxGYoZw4ZFFp+aF1TAY0ue2SvsjeRMdTwopWqRvANg2LDhZjUC2zjTQqIaWkGTmKHj+WZ3zeGk9ZWAYF6Z8LZCTLUnegLaLtuULkLFg4ZNH3ZvG5PV1l7bOrEWO+JGK7SacZ01hz8D6lk5dfAAG/zbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QdG8MSFv; arc=fail smtp.client-ip=40.107.102.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5NS2y+BxaGyOXwyY2dDvTKowXmvF1Pk6KDnHUaLJ1QzEuQ84zTzu1iurOHtl0R17kn3umojTfyuN43WAVJD3VQy368a0elmPcOcqa+Q3eYNnJdk7kG9H/mQ8HTmRW3HVE3mshIah0Sa3I450fO8wC/hHQIwXFcnUbPH4qQCx+65uzbtaRE0m4MIuJhze68+li4z94yCUvroja05YjrFMNE9ztGawU8FbQ0qc8h3+nTbn59wcAQ+a96ZWHMM1yX5erpmlbgxGwajXGMDz5OCWcRzYpNa5gjdn74wmAk8thVQ3hEWw/wtVvIDxBrgTMXpPfmCc5bHkQKIJGe6MFDb3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45GGgUlBA7TROacki1rBUN9/K06zEUd1/rqI+7JTpjU=;
 b=TA0mb24J+0Q4+4w5cS9C8nhh2Ea4XjUfqHnQnNCPVuhOtLieinY/8NtLeIxrwbGVUb7S0VaJCubbcmv7xWa3tkSyhtnkokNn3/OpISPojcUgZ+xGD8ENeOtyK6b/mIvLF59MuFxqSZQqGk7kT3txRs0CwIW2KFO1s+xt7nUVITsnGvAFvBfPhB8r6UMcimZZQUP4KzF2JX6skKCqCIl/HvkCbmdOOfg/dVv1tLbbNKYoeacDJHL1mY4k2D4dSe3s8s2bR8urMD+EN0LtVtQNvcplOJSPw+O4YMf1BvIvPN4VN9ej0cz5FyBU0dNz63hWpM/EM6PNtpZ6gi8Pq5JlDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45GGgUlBA7TROacki1rBUN9/K06zEUd1/rqI+7JTpjU=;
 b=QdG8MSFv9+/XWfv9/9G0hrZH2WPEfhG/OSpA1ZIeDditt8d2P4Ywq90pdQW692RtOnqgeSJHGt3870rSxmrrnFj6/nqxVU6J8Fa1Uboa1elrZKFT4f9JNzrmZyqh8TlNasD/yXyMDJLEvSo/foaPSyWUVCJE51hEut+kde3F+Qo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY3PR12MB9680.namprd12.prod.outlook.com (2603:10b6:930:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 03:42:04 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 03:42:03 +0000
Message-ID: <a2362bda-de8b-43c4-ae86-af953b4e1ed8@amd.com>
Date: Mon, 17 Mar 2025 22:42:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 8/8] platform/x86: asus-armoury: add ppt_* and nv_*
 tuning knobs
To: Luke Jones <luke@ljones.dev>, linux-kernel@vger.kernel.org
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org
References: <20250316230724.100165-1-luke@ljones.dev>
 <20250316230724.100165-9-luke@ljones.dev>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250316230724.100165-9-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0063.namprd12.prod.outlook.com
 (2603:10b6:802:20::34) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY3PR12MB9680:EE_
X-MS-Office365-Filtering-Correlation-Id: 86edaf4e-46ba-4776-7530-08dd65ced85f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUtqYlkrcWZpbEVWUk1Hd3NpK0p1ZWUwUTdzQ2JIcTc0SFQxSk9JaE8vcGFj?=
 =?utf-8?B?MVpCdnJKWm9GUVh0M3loNHBhMHBjejJoTWRNV002R3hmbGlPMXVyMFZtUUcy?=
 =?utf-8?B?TXdJaUpPN2pKMGRJNFhBalN4STFVRU1XZFVxNFFXRjFkT3FNWDJWVXRKN3U1?=
 =?utf-8?B?RFREbUxpYldyaVdkZllXcWNqbTMrc25GQUp6bzhKVW0xUTlDcWFNb3JCWXQr?=
 =?utf-8?B?OGtDYjVNdVMrUzhyZGdSa3dINkxrTUFoS2RrZEZIaWZMZ1IrV3NIZWx2MnNK?=
 =?utf-8?B?eFF5Y0JzWG95MzF3bFBZVjdpZ0JpZVFUQ3hlRGFyZFNONjRRd2dSNWpNZFRR?=
 =?utf-8?B?WFNRSk5TZmd4eGFCRnQ1TWpXQk1sUFkzZ00xZU8vTVF5SUI4OG1oemI3L1Q1?=
 =?utf-8?B?c0RXNXFLaVJuSHVnQlQvU3pkQnlNQXhYOHJsVEVlcHJadk5idkZ3RXZhZkNn?=
 =?utf-8?B?SW9oQ3ZzRG5NTjFCVVZlSWJWbkJVaHlZNko3R0FRZGR4TDN0OVQ3YnVOUkx0?=
 =?utf-8?B?L0kwNVRDWW0yU2xROGZrOC9TNUR5MzdnY2lGSVdBZVlRZERRR1RUZFAvbG5X?=
 =?utf-8?B?djROTXF0UlJrak1FNU5GdCs0dEx0Z1oxWnJ2YlBWZGdHY29oUzBYV0ZKK09w?=
 =?utf-8?B?MGJFRFRncklZQlRMeEF2UFR3REZvenBFU3psaWV4RVVhU2dNUmJOU2VGWjhN?=
 =?utf-8?B?cXltMUZ3UmkxaDAvU2VKL1hPY1ZIS05rcEs4aHh3RjBCM3RFVEZ5WFRUT094?=
 =?utf-8?B?c1hmT21JdHBIMmJGbXh6SzY4aG9DRitIdjMyL3BhV2VWdnp1U3orNi9RUUZN?=
 =?utf-8?B?aFo2TCtySHZqSllHL200RWUxSldBQ0RHdkJEYVpSTmIwa2xZZG8zYnhaY0NE?=
 =?utf-8?B?YjlKS2V3OHh4RTl5QlBGa2FYWXJncmx2VVpnVEIrNGpYTVNtSFJUME9XVCtz?=
 =?utf-8?B?azF0dmtyOGZ4OEExRlBWeHVKU0I4R3JWN2JORGdkc0VJT0FYZGhKZnIxbHdh?=
 =?utf-8?B?WlpzeWhJMGhjSHFGVGlnazYrWFdUaTh5b04wdTg1ZndSeW1CTkI5RWRBQXlp?=
 =?utf-8?B?bnBPMi9UcDJuR1V0MmQyNU0xMmhYMVRPVTNIZ2RXZHUrVXpYWDA3YXpiWnA2?=
 =?utf-8?B?eE42K1dZTTJTTm1BeXVtNVVPRlBObzlnZ0IweUErQW9XWERpa2w4U0c0VEQw?=
 =?utf-8?B?cUlkdWRMSHBnOXY0REJFQytVRUFtZ2t1VHBTbk9EdG1jT1VKRmJHWXFRVW9U?=
 =?utf-8?B?N1RZNE9leUljNFhtb091eGFpK1N5dndDbk9GN0pNNEtTdDA1Um9Hd1k3bjZv?=
 =?utf-8?B?M3d5Y1F6eW5KS3dNekJNVDRQNDRXeHd5ZHg3R21NVkxFNG5UQjFHNzQrOGMw?=
 =?utf-8?B?ZmtSWVF5RlJiRVVCdlVTa1I5MExsaFQwWG1xeU9YSEkrWjVhdE9KYTZsVDR0?=
 =?utf-8?B?TC95ekQwZ29IVXRvNlc5cm1oaHRoSm0vTTNDSFUyUDVjMVdTSVJlMFdDbGEv?=
 =?utf-8?B?S082N3BFYWVvMDJiR0doSHhoSjJMeDg1SlV2YUh3OHhla2JLOGx6ZGFEMjc3?=
 =?utf-8?B?VWdKOGh6eDF6NkxtYUtUWHpTVHBBWFVFZTJONm1XN0FhMktBNkF4VkZ4dG1Y?=
 =?utf-8?B?Y2dDTlFOOUtxMkdSaWs3dHRXNHpYbWRncnAyc3FrRlNsZTRHYWVXcHNBZmZH?=
 =?utf-8?B?Rmg5dnJHZU1VdVo1VTFCSXAyelpVc3FTV21zcGZBTS84ejZTKy8xWk56UU91?=
 =?utf-8?B?NXF6cmVyWEVyRk1qTlFROU03VzBzelhMWFdqK2orQUNpdzFhUHQrVXhZZkY1?=
 =?utf-8?B?RTA1bDYyQWxNZHpjMGtjOUV0TFUxa2tRaTNhN0RzSGZEb2VqTytpQ05tb0hE?=
 =?utf-8?Q?8sEle0gT3WMAB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEl4ZDJhYnNHVkVZcC9RNExJSGFXVlVPRHhQaFNVRWtNK0YzV0U3MHErRW9E?=
 =?utf-8?B?OERZSHpBN2ZKaksycWhFQVAzbGR0Wmg5N09yVWJRTE5CSWw1Y1lyUmdLQ0RL?=
 =?utf-8?B?d3NscnFjS2hRamhpQWNFUXJuTkNkcC8wN2E1QWRqajV4cWlveFE2NE1OL0Ru?=
 =?utf-8?B?RTJrdlowREpsWnNZbFNLTVEzMll5c1JqQlUvZVFDVzhENmphbkdxejRNaHJh?=
 =?utf-8?B?NVlkcW94NjN1d2tOdlBiWGpPYitycjFTSWRvak1HK0k2ZWNHRm9wRXFVMTEv?=
 =?utf-8?B?MFUrSTY3dlU3dDQxcVQwWHJFa3Q2Zi9MS2JqUG1kdkZPS0svU3lEVkVZa204?=
 =?utf-8?B?a2o2ZDRYcjIxandFcFB5THd6aWM2SGZ3TGxzTkJoc2E5eHVTNlBlbXN5Ym5x?=
 =?utf-8?B?TlVoL3JmRDZHMHhkWDgvbWo3Nk5DQVBiM3oyNGY5dGxPcy9TQlJmdjcvZzFr?=
 =?utf-8?B?UUJDT0h6WWtDeXpzMTJEcGhsUlQ1d1FGNmhVbmY2TUMvWVlrb3RKOVJQM1Zh?=
 =?utf-8?B?LzZBQnZZOTJ3Yk9wOTBDT1EvcGw1NDZTbUc4bUpnYkhycFJva0xQSzN4SzNt?=
 =?utf-8?B?dHdpakFsQjRBTmJOemJhYUtDS1NJNkVObjF4cEFEcFI2cVQ0aTVDcE5jaEhi?=
 =?utf-8?B?QnZ4R1E3REI1U1prajB6d0FWMVp6UEJqckhSL2lGMzdMbGRxN292Smxab3BM?=
 =?utf-8?B?UmcyMDZETHE1bVlIbHBsU2NyWFNHWmNsUDlZY1h6bm5vZGVkTXRFb08xODMx?=
 =?utf-8?B?Z0wzTzdCeEFKbzB4TkUwN0w2eThuZU44d0ZhOW5XS2RDRFBDOFNTZ0ZsMU1M?=
 =?utf-8?B?UERHQW9YQk5FbE5uMlVjNC9ZamhCSHhDY3lZMzhBd3luZThHRHVLQzFJRmxB?=
 =?utf-8?B?L29IdC9XSkJrOElNQm5Wa3cycFlkT0RnbE1FS2Rza29lRmo5eFNRV2dsa1dr?=
 =?utf-8?B?YnpyN3hPSHdlckVYV2hsVVBYdWhtcDFXcUEvWEJnbEtEM0ZiNXBHcFpVMEtO?=
 =?utf-8?B?M2JpZElYYlBhYW9rMEEzUXVzL2plSDZJVC9xWnJZdjc1aE5wMndxSW5UTGw3?=
 =?utf-8?B?TEtpSXgvVlhMaW5uU1dIQ1pybkUrYlBpZGhDRXQ0YnVnbXdWMm9IYnA1MWxV?=
 =?utf-8?B?Q1ZuQTV2RDF6ekRxa2dJeVZWd25RbkVWUm9vK3h0QytDZUJDOERZZmQybE9W?=
 =?utf-8?B?MVBGclZ5RWptd2tobGVZVE1Ja2dkQVRINGt4N0tZRFlmZU5adjZZdC9WdXZO?=
 =?utf-8?B?TE1JWUVlTWd6bXBYWGFORGQ2ckZkQWVVb1ZobE52L09FczZ1SjJBMWhpRURw?=
 =?utf-8?B?OUFNSWloL2pDWUoxRGRad0F2ZHRwWHkzU01mM1lMaUY1WFJ2blRPMHl2N0FF?=
 =?utf-8?B?dnhiWUxRem13Y0dpNS9PVllwNFZQd1BEQk00SDk2MlNVZ0R2bkFmRzhaWmsv?=
 =?utf-8?B?NXRabG9lTmZvTm5vUHhWR3BaUHpxbXdpUWcwZjBQNk9QdFBaRzhIazBHVGFt?=
 =?utf-8?B?RFVvVXoralZxT1diZG9VMlcrQzBDQ01GaTNhd2prQzY4cHhINDdJSk9kcHNH?=
 =?utf-8?B?WmxYYmxsa01pRFJmZWxXZVVZZExzV0dMd1ZldlJrazdGbmg5T2FocmU3U2JD?=
 =?utf-8?B?ZU5CL1lZUEduZlFxK21hZHViTEVTUmsyNUp6elIzL1IyVDNJL0djVkVqNzdx?=
 =?utf-8?B?NnN2U2pmYis5eGdLYTZCQmlrZGV6ejh1WlluUEtoZS9rZkFiODAxOWkxWU9w?=
 =?utf-8?B?WmR4SW84azNvMDJSRGdLQWU3QjZ4N1htUlRZUzBvNjNLaTU5L1BDVTFva09L?=
 =?utf-8?B?KzFwQ3JGdWVjUnkwaGJJUHRaVkxFZzdGMHNvUWlzMmNmZ0lpczlVeWc0c0dB?=
 =?utf-8?B?YkxucVNGTHZTbm9oRXhZdGxNSTNNbmZUUFplb2k0QnJUelM3ZSs2dWtwdU1T?=
 =?utf-8?B?MjdQbWlyU2ZwRDJUdGhxcEl6NDdtTHYwODdINHcyQkQyZ050eTVQZm40Nlgv?=
 =?utf-8?B?RDRReHFnVklyYnhnOWFWYmxXUWFjeU00S1BHb3RqcG8rUVlWNkZyZStoYVVl?=
 =?utf-8?B?UURKaTJSQUYzaTE5VTVzb2xycVNhQjJ0eTZ6Zld3c2k0UXVVYnY2UUdGOFFC?=
 =?utf-8?Q?mRG/l7oV652Bh0qEGAz0HHFcJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86edaf4e-46ba-4776-7530-08dd65ced85f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 03:42:03.0148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S6Fz+wdNUargP8XcmXbs9XzZHYLUHeZAtKwLSCV1KlgBtdIHZrSMFlBqaKLG8xRKTL9sPE5Oll9+xgqHlXGCTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9680

On 3/16/2025 18:07, Luke Jones wrote:
> From: "Luke D. Jones" <luke@ljones.dev>
> 
> Adds the ppt_* and nv_* tuning knobs that are available via WMI methods
> and adds proper min/max levels plus defaults.
> 
> The min/max are defined by ASUS and typically gained by looking at what
> they allow in the ASUS Armoury Crate application - ASUS does not share
> the values outside of this. It could also be possible to gain the AMD
> values by use of ryzenadj and testing for the minimum stable value.
> 
> The general rule of thumb for adding to the match table is that if the
> model range has a single CPU used throughout, then the DMI match can
> omit the last letter of the model number as this is the GPU model.
> 
> If a min or max value is not provided it is assumed that the particular
> setting is not supported. for example ppt_pl2_sppt_min/max is not set.
> If a <ppt_setting>_def is not set then the default is assumed to be
> <ppt_setting>_max
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>   drivers/platform/x86/asus-armoury.c        |  217 +++-
>   drivers/platform/x86/asus-armoury.h        | 1087 +++++++++++++++++++-
>   include/linux/platform_data/x86/asus-wmi.h |    3 +
>   3 files changed, 1300 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
> index 591805f46725..5598da5295b8 100644
> --- a/drivers/platform/x86/asus-armoury.c
> +++ b/drivers/platform/x86/asus-armoury.c
> @@ -20,6 +20,7 @@
>   #include <linux/module.h>
>   #include <linux/mutex.h>
>   #include <linux/platform_data/x86/asus-wmi.h>
> +#include <linux/power_supply.h>
>   #include <linux/types.h>
>   #include <linux/acpi.h>
>   
> @@ -67,11 +68,25 @@ struct cpu_cores {
>   	u32 max_power_cores;
>   };
>   
> +struct rog_tunables {
> +	const struct power_data *tuning_limits;
> +	u32 ppt_pl1_spl; // cpu
> +	u32 ppt_pl2_sppt; // cpu
> +	u32 ppt_pl3_fppt; // cpu
> +	u32 ppt_apu_sppt; // plat
> +	u32 ppt_platform_sppt; // plat
> +
> +	u32 nv_dynamic_boost;
> +	u32 nv_temp_target;
> +	u32 nv_tgp;
> +};
> +
>   static struct asus_armoury_priv {
>   	struct device *fw_attr_dev;
>   	struct kset *fw_attr_kset;
>   
>   	struct cpu_cores *cpu_cores;
> +	struct rog_tunables *rog_tunables;
>   	u32 mini_led_dev_id;
>   	u32 gpu_mux_dev_id;
>   	/*
> @@ -741,6 +756,26 @@ ATTR_GROUP_CORES_RW(cores_efficiency, "cores_efficiency",
>   		    "Set the max available efficiency cores");
>   
>   /* Simple attribute creation */
> +ATTR_GROUP_ROG_TUNABLE(ppt_pl1_spl, "ppt_pl1_spl", ASUS_WMI_DEVID_PPT_PL1_SPL,
> +		       "Set the CPU slow package limit");
> +ATTR_GROUP_ROG_TUNABLE(ppt_pl2_sppt, "ppt_pl2_sppt", ASUS_WMI_DEVID_PPT_PL2_SPPT,
> +		       "Set the CPU fast package limit");
> +ATTR_GROUP_ROG_TUNABLE(ppt_pl3_fppt, "ppt_pl3_fppt", ASUS_WMI_DEVID_PPT_FPPT,
> +		       "Set the CPU fastest package limit");
> +ATTR_GROUP_ROG_TUNABLE(ppt_apu_sppt, "ppt_apu_sppt", ASUS_WMI_DEVID_PPT_APU_SPPT,
> +		       "Set the APU package limit");
> +ATTR_GROUP_ROG_TUNABLE(ppt_platform_sppt, "ppt_platform_sppt", ASUS_WMI_DEVID_PPT_PLAT_SPPT,
> +		       "Set the platform package limit");
> +ATTR_GROUP_ROG_TUNABLE(nv_dynamic_boost, "nv_dynamic_boost", ASUS_WMI_DEVID_NV_DYN_BOOST,
> +		       "Set the Nvidia dynamic boost limit");
> +ATTR_GROUP_ROG_TUNABLE(nv_temp_target, "nv_temp_target", ASUS_WMI_DEVID_NV_THERM_TARGET,
> +		       "Set the Nvidia max thermal limit");
> +ATTR_GROUP_ROG_TUNABLE(nv_tgp, "dgpu_tgp", ASUS_WMI_DEVID_DGPU_SET_TGP,
> +		       "Set the additional TGP on top of the base TGP");
> +ATTR_GROUP_INT_VALUE_ONLY_RO(nv_base_tgp, "nv_base_tgp", ASUS_WMI_DEVID_DGPU_BASE_TGP,
> +			     "Read the base TGP value");
> +
> +
>   ATTR_GROUP_ENUM_INT_RO(charge_mode, "charge_mode", ASUS_WMI_DEVID_CHARGE_MODE, "0;1;2",
>   		       "Show the current mode of charging");
>   
> @@ -767,6 +802,16 @@ static const struct asus_attr_group armoury_attr_groups[] = {
>   	{ &cores_efficiency_attr_group, ASUS_WMI_DEVID_CORES_MAX },
>   	{ &cores_performance_attr_group, ASUS_WMI_DEVID_CORES_MAX },
>   
> +	{ &ppt_pl1_spl_attr_group, ASUS_WMI_DEVID_PPT_PL1_SPL },
> +	{ &ppt_pl2_sppt_attr_group, ASUS_WMI_DEVID_PPT_PL2_SPPT },
> +	{ &ppt_pl3_fppt_attr_group, ASUS_WMI_DEVID_PPT_FPPT },
> +	{ &ppt_apu_sppt_attr_group, ASUS_WMI_DEVID_PPT_APU_SPPT },
> +	{ &ppt_platform_sppt_attr_group, ASUS_WMI_DEVID_PPT_PLAT_SPPT },
> +	{ &nv_dynamic_boost_attr_group, ASUS_WMI_DEVID_NV_DYN_BOOST },
> +	{ &nv_temp_target_attr_group, ASUS_WMI_DEVID_NV_THERM_TARGET },
> +	{ &nv_base_tgp_attr_group, ASUS_WMI_DEVID_DGPU_BASE_TGP },
> +	{ &nv_tgp_attr_group, ASUS_WMI_DEVID_DGPU_SET_TGP },
> +
>   	{ &charge_mode_attr_group, ASUS_WMI_DEVID_CHARGE_MODE },
>   	{ &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
>   	{ &mcu_powersave_attr_group, ASUS_WMI_DEVID_MCU_POWERSAVE },
> @@ -774,8 +819,64 @@ static const struct asus_attr_group armoury_attr_groups[] = {
>   	{ &panel_hd_mode_attr_group, ASUS_WMI_DEVID_PANEL_HD },
>   };
>   
> +/**
> + * should_create_tunable_attr - Determines if a tunable attribute should be created
> + * @name: The name of the attribute
> + * @limits: Pointer to the power_limits structure containing limit values
> + *
> + * This function checks if a power-related tunable attribute should be created
> + * based on whether appropriate limit values are available. It also logs an error
> + * if the attribute should exist but is missing required limit values.
> + *
> + * Return: true if the attribute should be created, false otherwise
> + */
> +static bool should_create_tunable_attr(const char *name,
> +				       const struct power_limits *limits)
> +{
> +	bool is_tunable_attr = false;
> +	bool has_limit = false;
> +
> +	if (!limits)
> +		return false;
> +
> +	struct {
> +		const char *attr_name;
> +		u32 limit_value;
> +	} limit_map[] = {
> +		{ "ppt_pl1_spl", limits->ppt_pl1_spl_max },
> +		{ "ppt_pl2_sppt", limits->ppt_pl2_sppt_max },
> +		{ "ppt_pl3_fppt", limits->ppt_pl3_fppt_max },
> +		{ "ppt_apu_sppt", limits->ppt_apu_sppt_max },
> +		{ "ppt_platform_sppt", limits->ppt_platform_sppt_max },
> +		{ "nv_dynamic_boost", limits->nv_dynamic_boost_max },
> +		{ "nv_temp_target", limits->nv_temp_target_max },
> +		{ "nv_base_tgp", limits->nv_tgp_max },
> +		{ "dgpu_tgp", limits->nv_tgp_max },
> +	};
> +
> +	for (int i = 0; i < ARRAY_SIZE(limit_map); i++) {
> +		if (!strcmp(name, limit_map[i].attr_name)) {
> +			is_tunable_attr = true;
> +			has_limit = limit_map[i].limit_value > 0;
> +			break;
> +		}
> +	}
> +
> +	if (!is_tunable_attr)
> +		return true;
> +
> +	if (!has_limit)
> +		pr_err("Missing max value on %s for tunable: %s\n",
> +		       dmi_get_system_info(DMI_BOARD_NAME), name);

I'm wondering if this message is really correct.  The reason I say this 
is what if you have a pure AMD system without an NV GPU?  Should you 
really expect to have nv_dynamic_boost, nv_temp_target, nv_base_tgp and 
dgpu_tgp?

IE Maybe this message should be debug.

> +
> +	return has_limit;
> +}
> +
>   static int asus_fw_attr_add(void)
>   {
> +	const struct power_limits *limits;
> +	bool should_create;
> +	const char *name;
>   	int err, i;
>   
>   	asus_armoury.fw_attr_dev = device_create(&firmware_attributes_class, NULL, MKDEV(0, 0),
> @@ -832,12 +933,25 @@ static int asus_fw_attr_add(void)
>   		if (!asus_wmi_is_present(armoury_attr_groups[i].wmi_devid))
>   			continue;
>   
> -		err = sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
> -					 armoury_attr_groups[i].attr_group);
> -		if (err) {
> -			pr_err("Failed to create sysfs-group for %s\n",
> -			       armoury_attr_groups[i].attr_group->name);
> -			goto err_remove_groups;
> +		/* Always create by default, unless PPT is not present */
> +		should_create = true;
> +		name = armoury_attr_groups[i].attr_group->name;
> +
> +		/* Check if this is a power-related tunable requiring limits */
> +		if (asus_armoury.rog_tunables && asus_armoury.rog_tunables->tuning_limits) {
> +			limits = asus_armoury.rog_tunables->tuning_limits->ac_data;
> +			should_create = should_create_tunable_attr(name, limits);
> +		}
> +
> +		if (should_create) {
> +			err = sysfs_create_group(
> +				&asus_armoury.fw_attr_kset->kobj,
> +				armoury_attr_groups[i].attr_group);
> +			if (err) {
> +				pr_err("Failed to create sysfs-group for %s\n",
> +				       armoury_attr_groups[i].attr_group->name);
> +				goto err_remove_groups;
> +			}
>   		}
>   	}
>   
> @@ -866,6 +980,87 @@ static int asus_fw_attr_add(void)
>   
>   /* Init / exit ****************************************************************/
>   
> +/* Set up the min/max and defaults for ROG tunables */
> +static bool init_rog_tunables(struct rog_tunables *rog)
> +{
> +	const struct dmi_system_id *dmi_id;
> +	const struct power_data *power_data;
> +	const struct power_limits *limits;
> +
> +	/* Match the system against the power_limits table */
> +	dmi_id = dmi_first_match(power_limits);
> +	if (!dmi_id) {
> +		pr_warn("No matching power limits found for this system\n");
> +		// rog->tuning_limits = &default_power_data;

Presumably you meant to strip this commented line?

> +		rog->tuning_limits = NULL;
> +		return false;
> +	}
> +
> +	/* Get the power data for this system */
> +	power_data = dmi_id->driver_data;
> +	if (!power_data) {
> +		pr_info("No power data available for this system\n");
> +		return false;
> +	}
> +
> +	/* Store the power limits for later use */
> +	rog->tuning_limits = power_data;
> +
> +	if (power_supply_is_system_supplied()) {
> +		limits = power_data->ac_data;
> +		if (!limits) {
> +			pr_warn("No AC power limits available\n");
> +			return false;
> +		}
> +	} else {
> +		limits = power_data->dc_data;
> +		if (!limits) {
> +			rog->ppt_pl1_spl = 0;
> +			rog->ppt_pl2_sppt = 0;
> +			rog->ppt_pl3_fppt = 0;
> +			rog->ppt_apu_sppt = 0;
> +			rog->ppt_platform_sppt = 0;
> +			rog->nv_dynamic_boost = 0;
> +			rog->nv_temp_target = 0;
> +			rog->nv_tgp = 0;
> +
> +			pr_warn("No DC power limits available, initializing to 0\n");
> +			return true;
> +		}
> +	}

I'm a bit confused by the above logic here.  If you boot the system with 
the power supply connected and no limits specified you don't get any 
limit control created at all.
But if you boot the system without a power supply connected and no 
limits specified you do get them initialized to 0 and created.

Two things come to mind thinking this through.

1) Shouldn't you be returning the same thing in both cases?  IE both 
cases should return false and no attributes created.
2) Shouldn't you be checking both AC and DC no matter how you boot?  You 
want limits for both AC and DC; and if you don't have them for one or 
the other you should return false.

> +
> +	/* Set initial values */
> +	rog->ppt_pl1_spl = limits->ppt_pl1_spl_def ?
> +			   limits->ppt_pl1_spl_def :
> +			   limits->ppt_pl1_spl_max;
> +
> +	rog->ppt_pl2_sppt = limits->ppt_pl2_sppt_def ?
> +			    limits->ppt_pl2_sppt_def :
> +			    limits->ppt_pl2_sppt_max;
> +
> +	rog->ppt_pl3_fppt = limits->ppt_pl3_fppt_def ?
> +			    limits->ppt_pl3_fppt_def :
> +			    limits->ppt_pl3_fppt_max;
> +
> +	rog->ppt_apu_sppt = limits->ppt_apu_sppt_def ?
> +			    limits->ppt_apu_sppt_def :
> +			    limits->ppt_apu_sppt_max;
> +
> +	rog->ppt_platform_sppt = limits->ppt_platform_sppt_def ?
> +				limits->ppt_platform_sppt_def :
> +				limits->ppt_platform_sppt_max;
> +
> +	rog->nv_dynamic_boost = limits->nv_dynamic_boost_max;
> +	rog->nv_temp_target = limits->nv_temp_target_max;
> +	rog->nv_tgp = limits->nv_tgp_max;
> +
> +	pr_debug("Power limits initialized for %s (%s power)\n",
> +		 dmi_id->matches[0].substr,
> +		 power_supply_is_system_supplied() ? "AC" : "DC");
> +
> +	return true;
> +}
> +
>   static int __init asus_fw_init(void)
>   {
>   	char *wmi_uid;
> @@ -896,6 +1091,16 @@ static int __init asus_fw_init(void)
>   		}
>   	}
>   
> +	asus_armoury.rog_tunables = kzalloc(sizeof(struct rog_tunables), GFP_KERNEL);
> +	if (!asus_armoury.rog_tunables)
> +		return -ENOMEM;
> +	/* Init logs warn/error and the driver should still be usable if init fails */
> +	if (!init_rog_tunables(asus_armoury.rog_tunables)) {
> +		kfree(asus_armoury.rog_tunables);
> +		pr_err("Could not initialise PPT tunable control %d\n", err);

Since init_rog_tunables() will emit warnings for every possible problem, 
why is this err still needed?  I'd say drop this message.

> +	}
> +
> +	/* Must always be last step to ensure data is available */
>   	err = asus_fw_attr_add();
>   	if (err)
>   		return err;
> diff --git a/drivers/platform/x86/asus-armoury.h b/drivers/platform/x86/asus-armoury.h
> index 584a75df113d..e61cf3fdb559 100644
> --- a/drivers/platform/x86/asus-armoury.h
> +++ b/drivers/platform/x86/asus-armoury.h
> @@ -8,6 +8,7 @@
>   #ifndef _ASUS_ARMOURY_H_
>   #define _ASUS_ARMOURY_H_
>   
> +#include <linux/dmi.h>
>   #include <linux/types.h>
>   #include <linux/platform_device.h>
>   
> @@ -63,7 +64,6 @@
>   	static struct kobj_attribute attr_##_attrname##_##_prop =		\
>   		__ASUS_ATTR_RO(_attrname, _prop)
>   
> -
>   #define __ATTR_RO_INT_GROUP_ENUM(_attrname, _wmi, _fsname, _possible, _dispname)\
>   	WMI_SHOW_INT(_attrname##_current_value, "%d\n", _wmi);			\
>   	static struct kobj_attribute attr_##_attrname##_current_value =		\
> @@ -190,4 +190,1089 @@
>   		.name = _fsname, .attrs = _attrname##_attrs		\
>   	}
>   
> +#define ATTR_GROUP_INT_VALUE_ONLY_RO(_attrname, _fsname, _wmi, _dispname)	\
> +	WMI_SHOW_INT(_attrname##_current_value, "%d\n", _wmi);			\
> +	static struct kobj_attribute attr_##_attrname##_current_value =		\
> +		__ASUS_ATTR_RO(_attrname, current_value);			\
> +	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);		\
> +	static struct kobj_attribute attr_##_attrname##_type =			\
> +		__ASUS_ATTR_RO_AS(type, int_type_show);				\
> +	static struct attribute *_attrname##_attrs[] = {			\
> +		&attr_##_attrname##_current_value.attr,				\
> +		&attr_##_attrname##_display_name.attr,				\
> +		&attr_##_attrname##_type.attr, NULL				\
> +	};									\
> +	static const struct attribute_group _attrname##_attr_group = {		\
> +		.name = _fsname, .attrs = _attrname##_attrs			\
> +	}
> +
> +/*
> + * ROG PPT attributes need a little different in setup as they
> + * require rog_tunables members.
> + */
> +
> + #define __ROG_TUNABLE_SHOW(_prop, _attrname, _val)				\
> +	static ssize_t _attrname##_##_prop##_show(				\
> +		struct kobject *kobj, struct kobj_attribute *attr, char *buf)	\
> +	{									\
> +		const struct power_limits *limits;				\
> +		limits = power_supply_is_system_supplied() ?			\
> +			asus_armoury.rog_tunables->tuning_limits->ac_data :	\
> +			asus_armoury.rog_tunables->tuning_limits->dc_data;	\
> +		if (!limits)							\
> +			return -ENODEV;						\
> +		return sysfs_emit(buf, "%d\n", limits->_val);			\
> +	}									\
> +	static struct kobj_attribute attr_##_attrname##_##_prop =		\
> +		__ASUS_ATTR_RO(_attrname, _prop)
> +
> +#define __ROG_TUNABLE_SHOW_DEFAULT(_attrname)					\
> +	static ssize_t _attrname##_default_value_show(				\
> +		struct kobject *kobj, struct kobj_attribute *attr, char *buf)	\
> +	{									\
> +		const struct power_limits *limits;				\
> +		limits = power_supply_is_system_supplied() ?			\
> +			asus_armoury.rog_tunables->tuning_limits->ac_data :	\
> +			asus_armoury.rog_tunables->tuning_limits->dc_data;	\
> +		if (!limits)							\
> +			return -ENODEV;						\
> +		return sysfs_emit(buf, "%d\n",					\
> +				 limits->_attrname##_def ?			\
> +				 limits->_attrname##_def :			\
> +				 limits->_attrname##_max);			\
> +	}									\
> +	static struct kobj_attribute attr_##_attrname##_default_value =		\
> +		__ASUS_ATTR_RO(_attrname, default_value)
> +
> +#define __ROG_TUNABLE_RW(_attr, _wmi)						\
> +	static ssize_t _attr##_current_value_store(				\
> +		struct kobject *kobj, struct kobj_attribute *attr,		\
> +		const char *buf, size_t count)					\
> +	{									\
> +		const struct power_limits *limits;				\
> +		limits = power_supply_is_system_supplied() ?			\
> +			asus_armoury.rog_tunables->tuning_limits->ac_data :	\
> +			asus_armoury.rog_tunables->tuning_limits->dc_data;	\
> +		if (!limits)							\
> +			return -ENODEV;						\
> +		return attr_uint_store(kobj, attr, buf, count,			\
> +				      limits->_attr##_min,			\
> +				      limits->_attr##_max,			\
> +				      &asus_armoury.rog_tunables->_attr,	\
> +				      _wmi);					\
> +	}									\
> +	static ssize_t _attr##_current_value_show(				\
> +		struct kobject *kobj, struct kobj_attribute *attr,		\
> +		char *buf)							\
> +	{									\
> +		return sysfs_emit(buf, "%u\n",					\
> +				  asus_armoury.rog_tunables->_attr);		\
> +	}									\
> +	static struct kobj_attribute attr_##_attr##_current_value =		\
> +		__ASUS_ATTR_RW(_attr, current_value)
> +
> +#define ATTR_GROUP_ROG_TUNABLE(_attrname, _fsname, _wmi, _dispname)	\
> +	__ROG_TUNABLE_RW(_attrname, _wmi);				\
> +	__ROG_TUNABLE_SHOW_DEFAULT(_attrname);				\
> +	__ROG_TUNABLE_SHOW(min_value, _attrname, _attrname##_min);	\
> +	__ROG_TUNABLE_SHOW(max_value, _attrname, _attrname##_max);	\
> +	__ATTR_SHOW_FMT(scalar_increment, _attrname, "%d\n", 1);	\
> +	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);	\
> +	static struct kobj_attribute attr_##_attrname##_type =		\
> +		__ASUS_ATTR_RO_AS(type, int_type_show);			\
> +	static struct attribute *_attrname##_attrs[] = {		\
> +		&attr_##_attrname##_current_value.attr,			\
> +		&attr_##_attrname##_default_value.attr,			\
> +		&attr_##_attrname##_min_value.attr,			\
> +		&attr_##_attrname##_max_value.attr,			\
> +		&attr_##_attrname##_scalar_increment.attr,		\
> +		&attr_##_attrname##_display_name.attr,			\
> +		&attr_##_attrname##_type.attr,				\
> +		NULL							\
> +	};								\
> +	static const struct attribute_group _attrname##_attr_group = {	\
> +		.name = _fsname, .attrs = _attrname##_attrs		\
> +	}
> +
> +/* Default is always the maximum value unless *_def is specified */
> +struct power_limits {
> +	u8 ppt_pl1_spl_min;
> +	u8 ppt_pl1_spl_def;
> +	u8 ppt_pl1_spl_max;
> +	u8 ppt_pl2_sppt_min;
> +	u8 ppt_pl2_sppt_def;
> +	u8 ppt_pl2_sppt_max;
> +	u8 ppt_pl3_fppt_min;
> +	u8 ppt_pl3_fppt_def;
> +	u8 ppt_pl3_fppt_max;
> +	u8 ppt_apu_sppt_min;
> +	u8 ppt_apu_sppt_def;
> +	u8 ppt_apu_sppt_max;
> +	u8 ppt_platform_sppt_min;
> +	u8 ppt_platform_sppt_def;
> +	u8 ppt_platform_sppt_max;
> +	/* Nvidia GPU specific, default is always max */
> +	u8 nv_dynamic_boost_def; // unused. exists for macro
> +	u8 nv_dynamic_boost_min;
> +	u8 nv_dynamic_boost_max;
> +	u8 nv_temp_target_def; // unused. exists for macro
> +	u8 nv_temp_target_min;
> +	u8 nv_temp_target_max;
> +	u8 nv_tgp_def; // unused. exists for macro
> +	u8 nv_tgp_min;
> +	u8 nv_tgp_max;
> +};
> +
> +struct power_data {
> +		const struct power_limits *ac_data;
> +		const struct power_limits *dc_data;
> +		bool requires_fan_curve;
> +};
> +
> +/*
> + * For each avilable attribute there must be a min and a max.
> + * _def is not required and will be assumed to be default == max if missing.
> + */
> +static const struct dmi_system_id power_limits[] = {
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "FA401W"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_max = 80,
> +				.ppt_pl2_sppt_min = 35,
> +				.ppt_pl2_sppt_max = 80,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_max = 80,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 25,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +				.nv_tgp_min = 55,
> +				.nv_tgp_max = 75,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 25,
> +				.ppt_pl1_spl_max = 30,
> +				.ppt_pl2_sppt_min = 31,
> +				.ppt_pl2_sppt_max = 44,
> +				.ppt_pl3_fppt_min = 45,
> +				.ppt_pl3_fppt_max = 65,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "FA507N"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_max = 80,
> +				.ppt_pl2_sppt_min = 35,
> +				.ppt_pl2_sppt_max = 80,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_max = 80,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 25,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_def = 45,
> +				.ppt_pl1_spl_max = 65,
> +				.ppt_pl2_sppt_min = 35,
> +				.ppt_pl2_sppt_def = 54,
> +				.ppt_pl2_sppt_max = 65,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_max = 65,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			}
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "FA507R"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_max = 80,
> +				.ppt_pl2_sppt_min = 25,
> +				.ppt_pl2_sppt_max = 80,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_max = 80
> +			},
> +			.dc_data = NULL
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "FA507X"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_max = 80,
> +				.ppt_pl2_sppt_min = 35,
> +				.ppt_pl2_sppt_max = 80,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_max = 80,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 20,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +				.nv_tgp_min = 55,
> +				.nv_tgp_max = 85,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_def = 45,
> +				.ppt_pl1_spl_max = 65,
> +				.ppt_pl2_sppt_min = 35,
> +				.ppt_pl2_sppt_def = 54,
> +				.ppt_pl2_sppt_max = 65,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_max = 65,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			}
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "FA507Z"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 28,
> +				.ppt_pl1_spl_max = 65,
> +				.ppt_pl2_sppt_min = 28,
> +				.ppt_pl2_sppt_max = 105,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 15,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +				.nv_tgp_min = 55,
> +				.nv_tgp_max = 85,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 25,
> +				.ppt_pl1_spl_max = 45,
> +				.ppt_pl2_sppt_min = 35,
> +				.ppt_pl2_sppt_max = 60,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			}
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "FA607P"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 30,
> +				.ppt_pl1_spl_def = 100,
> +				.ppt_pl1_spl_max = 135,
> +				.ppt_pl2_sppt_min = 30,
> +				.ppt_pl2_sppt_def = 115,
> +				.ppt_pl2_sppt_max = 135,
> +				.ppt_pl3_fppt_min = 30,
> +				.ppt_pl3_fppt_max = 135,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 25,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +				.nv_tgp_min = 55,
> +				.nv_tgp_max = 115,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 25,
> +				.ppt_pl1_spl_def = 45,
> +				.ppt_pl1_spl_max = 80,
> +				.ppt_pl2_sppt_min = 25,
> +				.ppt_pl2_sppt_def = 60,
> +				.ppt_pl2_sppt_max = 80,
> +				.ppt_pl3_fppt_min = 25,
> +				.ppt_pl3_fppt_max = 80,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			}
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "FA617NS"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_apu_sppt_min = 15,
> +				.ppt_apu_sppt_max = 80,
> +				.ppt_platform_sppt_min = 30,
> +				.ppt_platform_sppt_max = 120
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_apu_sppt_min = 25,
> +				.ppt_apu_sppt_max = 35,
> +				.ppt_platform_sppt_min = 45,
> +				.ppt_platform_sppt_max = 100
> +			}
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "FA617NT"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_apu_sppt_min = 15,
> +				.ppt_apu_sppt_max = 80,
> +				.ppt_platform_sppt_min = 30,
> +				.ppt_platform_sppt_max = 115
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_apu_sppt_min = 15,
> +				.ppt_apu_sppt_max = 45,
> +				.ppt_platform_sppt_min = 30,
> +				.ppt_platform_sppt_max = 50
> +			}
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "FA617XS"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_apu_sppt_min = 15,
> +				.ppt_apu_sppt_max = 80,
> +				.ppt_platform_sppt_min = 30,
> +				.ppt_platform_sppt_max = 120,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_apu_sppt_min = 25,
> +				.ppt_apu_sppt_max = 35,
> +				.ppt_platform_sppt_min = 45,
> +				.ppt_platform_sppt_max = 100,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			}
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "FX507Z"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 28,
> +				.ppt_pl1_spl_max = 90,
> +				.ppt_pl2_sppt_min = 28,
> +				.ppt_pl2_sppt_max = 135,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 15,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 25,
> +				.ppt_pl1_spl_max = 45,
> +				.ppt_pl2_sppt_min = 35,
> +				.ppt_pl2_sppt_max = 60,
> +			},
> +			.requires_fan_curve = true,
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "GA401Q"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_max = 80,
> +				.ppt_pl2_sppt_min = 15,
> +				.ppt_pl2_sppt_max = 80,
> +			},
> +			.dc_data = NULL
> +		},
> +	},
> +	{
> +		.matches = {
> +			// This model is full AMD. No Nvidia dGPU.
> +			DMI_MATCH(DMI_BOARD_NAME, "GA402R"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_apu_sppt_min = 15,
> +				.ppt_apu_sppt_max = 80,
> +				.ppt_platform_sppt_min = 30,
> +				.ppt_platform_sppt_max = 115,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_apu_sppt_min = 25,
> +				.ppt_apu_sppt_def = 30,
> +				.ppt_apu_sppt_max = 45,
> +				.ppt_platform_sppt_min = 40,
> +				.ppt_platform_sppt_max = 60,
> +			}
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "GA402X"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_def = 35,
> +				.ppt_pl1_spl_max = 80,
> +				.ppt_pl2_sppt_min = 25,
> +				.ppt_pl2_sppt_def = 65,
> +				.ppt_pl2_sppt_max = 80,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_max = 80,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_max = 35,
> +				.ppt_pl2_sppt_min = 25,
> +				.ppt_pl2_sppt_max = 35,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_max = 65,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.requires_fan_curve = true,
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "GA403U"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_max = 80,
> +				.ppt_pl2_sppt_min = 25,
> +				.ppt_pl2_sppt_max = 80,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_max = 80,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 25,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +				.nv_tgp_min = 55,
> +				.nv_tgp_max = 65,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_max = 35,
> +				.ppt_pl2_sppt_min = 25,
> +				.ppt_pl2_sppt_max = 35,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_max = 65,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.requires_fan_curve = true,
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "GA503R"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_def = 35,
> +				.ppt_pl1_spl_max = 80,
> +				.ppt_pl2_sppt_min = 35,
> +				.ppt_pl2_sppt_def = 65,
> +				.ppt_pl2_sppt_max = 80,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_max = 80,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 20,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_def = 25,
> +				.ppt_pl1_spl_max = 65,
> +				.ppt_pl2_sppt_min = 35,
> +				.ppt_pl2_sppt_def = 54,
> +				.ppt_pl2_sppt_max = 60,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_max = 65
> +			}
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "GA605W"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_max = 80,
> +				.ppt_pl2_sppt_min = 35,
> +				.ppt_pl2_sppt_max = 80,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_max = 80,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 20,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +				.nv_tgp_min = 55,
> +				.nv_tgp_max = 85,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 25,
> +				.ppt_pl1_spl_max = 35,
> +				.ppt_pl2_sppt_min = 31,
> +				.ppt_pl2_sppt_max = 44,
> +				.ppt_pl3_fppt_min = 45,
> +				.ppt_pl3_fppt_max = 65,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.requires_fan_curve = true,
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "GU603Z"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 25,
> +				.ppt_pl1_spl_max = 60,
> +				.ppt_pl2_sppt_min = 25,
> +				.ppt_pl2_sppt_max = 135,
> +				/* Only allowed in AC mode */
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 20,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 25,
> +				.ppt_pl1_spl_max = 40,
> +				.ppt_pl2_sppt_min = 25,
> +				.ppt_pl2_sppt_max = 40,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			}
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "GU604V"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 65,
> +				.ppt_pl1_spl_max = 120,
> +				.ppt_pl2_sppt_min = 65,
> +				.ppt_pl2_sppt_max = 150,
> +				/* Only allowed in AC mode */
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 25,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 25,
> +				.ppt_pl1_spl_max = 40,
> +				.ppt_pl2_sppt_min = 35,
> +				.ppt_pl2_sppt_def = 40,
> +				.ppt_pl2_sppt_max = 60,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			}
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "GU605M"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 28,
> +				.ppt_pl1_spl_max = 90,
> +				.ppt_pl2_sppt_min = 28,
> +				.ppt_pl2_sppt_max = 135,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 20,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 25,
> +				.ppt_pl1_spl_max = 35,
> +				.ppt_pl2_sppt_min = 38,
> +				.ppt_pl2_sppt_max = 53,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.requires_fan_curve = true,
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "GV301Q"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_max = 45,
> +				.ppt_pl2_sppt_min = 65,
> +				.ppt_pl2_sppt_max = 80,
> +			},
> +			.dc_data = NULL
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "GV301R"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_max = 45,
> +				.ppt_pl2_sppt_min = 25,
> +				.ppt_pl2_sppt_max = 54,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_max = 65,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_max = 35,
> +				.ppt_pl2_sppt_min = 25,
> +				.ppt_pl2_sppt_max = 35,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_max = 65,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			}
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "GV601R"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_def = 35,
> +				.ppt_pl1_spl_max = 90,
> +				.ppt_pl2_sppt_min = 35,
> +				.ppt_pl2_sppt_def = 54,
> +				.ppt_pl2_sppt_max = 100,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_def = 80,
> +				.ppt_pl3_fppt_max = 125,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 25,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_def = 28,
> +				.ppt_pl1_spl_max = 65,
> +				.ppt_pl2_sppt_min = 35,
> +				.ppt_pl2_sppt_def = 54,
> +				.ppt_pl2_sppt_def = 40,
> +				.ppt_pl2_sppt_max = 60,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_def = 80,
> +				.ppt_pl3_fppt_max = 65,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			}
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "GV601V"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 28,
> +				.ppt_pl1_spl_def = 100,
> +				.ppt_pl1_spl_max = 110,
> +				.ppt_pl2_sppt_min = 28,
> +				.ppt_pl2_sppt_max = 135,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 20,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 25,
> +				.ppt_pl1_spl_max = 40,
> +				.ppt_pl2_sppt_min = 35,
> +				.ppt_pl2_sppt_def = 40,
> +				.ppt_pl2_sppt_max = 60,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			}
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "GX650P"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_def = 110,
> +				.ppt_pl1_spl_max = 130,
> +				.ppt_pl2_sppt_min = 35,
> +				.ppt_pl2_sppt_def = 125,
> +				.ppt_pl2_sppt_max = 130,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_def = 125,
> +				.ppt_pl3_fppt_max = 135,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 25,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_def = 25,
> +				.ppt_pl1_spl_max = 65,
> +				.ppt_pl2_sppt_min = 35,
> +				.ppt_pl2_sppt_def = 35,
> +				.ppt_pl2_sppt_max = 65,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_def = 42,
> +				.ppt_pl3_fppt_max = 65,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			}
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "G513I"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				/* Yes this laptop is very limited */
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_max = 80,
> +				.ppt_pl2_sppt_min = 15,
> +				.ppt_pl2_sppt_max = 80,
> +			},
> +			.dc_data = NULL,
> +			.requires_fan_curve = true,
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "G513QM"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				/* Yes this laptop is very limited */
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_max = 100,
> +				.ppt_pl2_sppt_min = 15,
> +				.ppt_pl2_sppt_max = 190,
> +			},
> +			.dc_data = NULL,
> +			.requires_fan_curve = true,
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "G513R"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 35,
> +				.ppt_pl1_spl_max = 90,
> +				.ppt_pl2_sppt_min = 54,
> +				.ppt_pl2_sppt_max = 100,
> +				.ppt_pl3_fppt_min = 54,
> +				.ppt_pl3_fppt_max = 125,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 25,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 28,
> +				.ppt_pl1_spl_max = 50,
> +				.ppt_pl2_sppt_min = 28,
> +				.ppt_pl2_sppt_max = 50,
> +				.ppt_pl3_fppt_min = 28,
> +				.ppt_pl3_fppt_max = 65,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.requires_fan_curve = true,
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "G614J"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 28,
> +				.ppt_pl1_spl_max = 140,
> +				.ppt_pl2_sppt_min = 28,
> +				.ppt_pl2_sppt_max = 175,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 25,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 25,
> +				.ppt_pl1_spl_max = 55,
> +				.ppt_pl2_sppt_min = 25,
> +				.ppt_pl2_sppt_max = 70,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.requires_fan_curve = true,
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "G634J"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 28,
> +				.ppt_pl1_spl_max = 140,
> +				.ppt_pl2_sppt_min = 28,
> +				.ppt_pl2_sppt_max = 175,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 25,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 25,
> +				.ppt_pl1_spl_max = 55,
> +				.ppt_pl2_sppt_min = 25,
> +				.ppt_pl2_sppt_max = 70,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.requires_fan_curve = true,
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "G733C"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 28,
> +				.ppt_pl1_spl_max = 170,
> +				.ppt_pl2_sppt_min = 28,
> +				.ppt_pl2_sppt_max = 175,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 25,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 28,
> +				.ppt_pl1_spl_max = 35,
> +				.ppt_pl2_sppt_min = 28,
> +				.ppt_pl2_sppt_max = 35,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.requires_fan_curve = true,
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "G733P"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 30,
> +				.ppt_pl1_spl_def = 100,
> +				.ppt_pl1_spl_max = 130,
> +				.ppt_pl2_sppt_min = 65,
> +				.ppt_pl2_sppt_def = 125,
> +				.ppt_pl2_sppt_max = 130,
> +				.ppt_pl3_fppt_min = 65,
> +				.ppt_pl3_fppt_def = 125,
> +				.ppt_pl3_fppt_max = 130,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 25,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 25,
> +				.ppt_pl1_spl_max = 65,
> +				.ppt_pl2_sppt_min = 25,
> +				.ppt_pl2_sppt_max = 65,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_max = 75,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.requires_fan_curve = true,
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "G814J"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 28,
> +				.ppt_pl1_spl_max = 140,
> +				.ppt_pl2_sppt_min = 28,
> +				.ppt_pl2_sppt_max = 140,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 25,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 25,
> +				.ppt_pl1_spl_max = 55,
> +				.ppt_pl2_sppt_min = 25,
> +				.ppt_pl2_sppt_max = 70,
> +			},
> +			.requires_fan_curve = true,
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "G834J"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 28,
> +				.ppt_pl1_spl_max = 140,
> +				.ppt_pl2_sppt_min = 28,
> +				.ppt_pl2_sppt_max = 175,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 25,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 25,
> +				.ppt_pl1_spl_max = 55,
> +				.ppt_pl2_sppt_min = 25,
> +				.ppt_pl2_sppt_max = 70,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.requires_fan_curve = true,
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "H7606W"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_max = 80,
> +				.ppt_pl2_sppt_min = 35,
> +				.ppt_pl2_sppt_max = 80,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_max = 80,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 20,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +				.nv_tgp_min = 55,
> +				.nv_tgp_max = 85,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 25,
> +				.ppt_pl1_spl_max = 35,
> +				.ppt_pl2_sppt_min = 31,
> +				.ppt_pl2_sppt_max = 44,
> +				.ppt_pl3_fppt_min = 45,
> +				.ppt_pl3_fppt_max = 65,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			}
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "RC71"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 7,
> +				.ppt_pl1_spl_max = 30,
> +				.ppt_pl2_sppt_min = 15,
> +				.ppt_pl2_sppt_max = 43,
> +				.ppt_pl3_fppt_min = 15,
> +				.ppt_pl3_fppt_max = 53
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 7,
> +				.ppt_pl1_spl_def = 15,
> +				.ppt_pl1_spl_max = 25,
> +				.ppt_pl2_sppt_min = 15,
> +				.ppt_pl2_sppt_def = 20,
> +				.ppt_pl2_sppt_max = 30,
> +				.ppt_pl3_fppt_min = 15,
> +				.ppt_pl3_fppt_def = 25,
> +				.ppt_pl3_fppt_max = 35
> +			}
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "RC72"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 7,
> +				.ppt_pl1_spl_max = 30,
> +				.ppt_pl2_sppt_min = 15,
> +				.ppt_pl2_sppt_max = 43,
> +				.ppt_pl3_fppt_min = 15,
> +				.ppt_pl3_fppt_max = 53
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 7,
> +				.ppt_pl1_spl_def = 17,
> +				.ppt_pl1_spl_max = 25,
> +				.ppt_pl2_sppt_min = 15,
> +				.ppt_pl2_sppt_def = 24,
> +				.ppt_pl2_sppt_max = 30,
> +				.ppt_pl3_fppt_min = 15,
> +				.ppt_pl3_fppt_def = 30,
> +				.ppt_pl3_fppt_max = 35
> +			}
> +		},
> +	},
> +	{}
> +};
> +
>   #endif /* _ASUS_ARMOURY_H_ */
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index 92fea0710ada..bf53592e2a2f 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -145,6 +145,9 @@
>   
>   #define ASUS_WMI_DEVID_APU_MEM		0x000600C1
>   
> +#define ASUS_WMI_DEVID_DGPU_BASE_TGP	0x00120099
> +#define ASUS_WMI_DEVID_DGPU_SET_TGP	0x00120098
> +
>   /* gpu mux switch, 0 = dGPU, 1 = Optimus */
>   #define ASUS_WMI_DEVID_GPU_MUX		0x00090016
>   #define ASUS_WMI_DEVID_GPU_MUX_VIVO	0x00090026


