Return-Path: <linux-kernel+bounces-425279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB819DBFCA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 08:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 150B316364D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 07:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45F5156885;
	Fri, 29 Nov 2024 07:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="V/dHlZRu"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023079.outbound.protection.outlook.com [40.93.201.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC11184F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 07:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732866036; cv=fail; b=GPfG40EQ81/tcNIUn/f7Tr/7zkKIfb0mtQGwOPyeCweEsfE43LXZC0vKNVtLFruVpedDpzgOTRnJj5rMCcr4LDYmcSd0rooycKJZCOyM7qgjgsONAYnhKuZ/HAVk77nBzhuv/7UV7OR9ujjrjlJuFqV+BJciShXmKvOegVl9KXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732866036; c=relaxed/simple;
	bh=mZ2yTZ8Lsr7AzxQeBwX+N5dSjYuqe0Nomg68y+PHc5o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pUbGx+dGyUL83p6ebdfeLMAPqBgPtSMdHwfyCZgRfboyG0rD/xfCcBajh+7whKKqL8Y5UWNm3FWG6rkGEbnsd2IM3i0YF+aI2Vlj85lhwtttDnnSysmb7e5tm8dZUu9buzeqSJMt6KjzTbW8IVem+NNVU7iaFdGk88hd3l7HsyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=V/dHlZRu; arc=fail smtp.client-ip=40.93.201.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tr/5Xb86gUCQfMIOOZ9d6+BO6IzEq/hqT4B1bo+mPmKldCkUpqfMJtImwZuAgn96rSyMy094MLlzvMrLfusbm/GkD83CR7KXOe62o7jGbkqVyRnv1982aguQhpr0CkShM/iPF+LP10DaLo8yrOM1cDSDtV7RzYwvg/irNb5xXQYjEVu2w/PfEdc7pKGZS5ItsDPnT9eQe8UTd/mQ2qmcFyseeeyMypU8FTSIHT+C7R/3lFuJnsZ3XnijdWeRN/+M1agPNBe1FmL/9AmcqGb+at9hzp8Hx8OOCLzLl2Brg+V3xR/Cc7MGKqdjvc7XHjrD9eu97eQ1y4GJ6D96hW2A7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WafUZxQ8/wt1yPOQafiOfYG4dmKbHei/0DQSEHL69GI=;
 b=ndifkxwxweFNzO8Igz6EkYk4B6ehCr4B23NgZIpaxRk1cTydrXXjoucjk6x09Hf2G9iR04RpAyE43xrkWp58X0js07oavRiSzRM1EQDYZdzyI/N7HLprDjpv1Zn9gXKt6AZYghtBQKUIOt55O7MoR9YFlV//UxjjP4Kt7WrmARGwCV3f0lgcQt6lksiJWKySGtEqW6oOQxehwcZfuqc25y3yLyyximJub9OrEGmCnziZypMc9rB4exTRU0oTfrGSDF7M0VLjGVun+fD827fzQZan534VVwI7ZTJJOD9plE5uDfRtgT9n0rVrIyfpTqyOSziWvkTDE+Uh5GrA+39Kxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WafUZxQ8/wt1yPOQafiOfYG4dmKbHei/0DQSEHL69GI=;
 b=V/dHlZRu0rCHRyw3MM/o9K6sK/6biYQhRanFTGp2BLm4Du/IKsSvGFw45S/MqgRAeKCVP6W7uM3cbqXCCnYb+9ZJQa8VmC3yZGzMC0wHuHFu1KKVDeqSfZ8Jkm8tIQXvW+9PSgWxGkPhfXhNLk4LgcfrOieM8F9dK9Tf+b/Pzz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ0PR01MB6445.prod.exchangelabs.com (2603:10b6:a03:2a1::14) by
 PH0PR01MB7317.prod.exchangelabs.com (2603:10b6:510:10d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.5; Fri, 29 Nov 2024 07:40:28 +0000
Received: from SJ0PR01MB6445.prod.exchangelabs.com
 ([fe80::223:9849:bfff:b119]) by SJ0PR01MB6445.prod.exchangelabs.com
 ([fe80::223:9849:bfff:b119%5]) with mapi id 15.20.8230.000; Fri, 29 Nov 2024
 07:40:28 +0000
Message-ID: <cf3dbcfe-3c26-48e3-b32f-6473c8dbeb06@os.amperecomputing.com>
Date: Fri, 29 Nov 2024 15:40:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] sched/fair: Fix warning if NEXT_BUDDY enabled
To: K Prateek Nayak <kprateek.nayak@amd.com>, peterz@infradead.org,
 mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
 patches@amperecomputing.com, cl@linux.com, christian.loehle@arm.com,
 vineethr@linux.ibm.com
References: <20241127055610.7076-1-adamli@os.amperecomputing.com>
 <20241127055610.7076-2-adamli@os.amperecomputing.com>
 <670a0d54-e398-4b1f-8a6e-90784e2fdf89@amd.com>
 <3deb3671-64df-4dd9-a539-3d41009f9875@os.amperecomputing.com>
 <d16cc372-b4ae-473f-bf86-83469fbead99@amd.com>
Content-Language: en-US
From: Adam Li <adamli@os.amperecomputing.com>
In-Reply-To: <d16cc372-b4ae-473f-bf86-83469fbead99@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0112.apcprd02.prod.outlook.com
 (2603:1096:4:92::28) To SJ0PR01MB6445.prod.exchangelabs.com
 (2603:10b6:a03:2a1::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6445:EE_|PH0PR01MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: e5b0e095-f2fe-44e3-de7c-08dd10491825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUZ4VDN4TkJmNERJVmhQMHdvSEJ0S0o1OStHVGtIMm9EdXJaR3FCVkpSZ01a?=
 =?utf-8?B?YzJMU3RlT1drZVU5bGU3dHBXM3pQOURjS1p4b3dKcFdxQzdpZ29CdHhja29m?=
 =?utf-8?B?U3FsazJVTmVvVUdTMjdPeDRpR3ZNeGQ2T3dUVXhnYUhZZW9rWEZleUlFVTlk?=
 =?utf-8?B?c3lQcDg4NithRlNGYmtOTmo5RWd1SWhaVjZnY1JIclVSK2VlZFVNNTN5OGxM?=
 =?utf-8?B?NlVjV2dxUDYwUWh1cHZPN1NpNEJRcXp3KzkxRUE5cCtlQW1aSVhaUXRhRWRF?=
 =?utf-8?B?M3lsTXZrUkFTK2JsR3RIaEVrdkdidUNidldvV0YyNHlpNUlld0ZaVEJ4a210?=
 =?utf-8?B?K01tbUVScEp1emhjdk1kb3lsRzJMSi9QbmsyTWpYU2hHMkdvdE1mZGVaWnlP?=
 =?utf-8?B?R3c2bSt4Nm13cnBZZVBJeHFZNFQrWGRpVGRMVk9LYWV3aFJOMzFuMVpUSWF6?=
 =?utf-8?B?eWxVZVZQRUk1T25jKzNhemt2c1UxRmlnNWdaQXg2UVd0cmY1NDRvU3ZsOWxq?=
 =?utf-8?B?WXBEaCtJNnNxZi9Pd3RneWxmRW0zU21PSk9iSWowUVNVRmFWSThuK2lVczBq?=
 =?utf-8?B?eDhOaWVXcnBTNm5lVXp0cUVoZnoxOW9aZHAwZFpSdlpnNHlYZFBiZHF1UERw?=
 =?utf-8?B?aFBWL2tPazBRNk40eVVOOVV4Vi9pVmJ5TjhVMEMrTHVHMEZiSmduajB4cWJo?=
 =?utf-8?B?eVBFcGhleTdwZDFCMjAvZGgzUWt4cHhhby9vUC9ScWRDY2RBQ3UyUG9USzhY?=
 =?utf-8?B?ZXFMcUJvN1BrZW9YL2FON3hPOFo4eFBlbzArblc5dk01cUNyL05NNGV1bHFD?=
 =?utf-8?B?dTJJNTZoK0ZaSVBiSnZjK29KcmxuSXlTRi9qNHFYbkhOeHBhUVU2NjNSbnF6?=
 =?utf-8?B?aDJYZllKUnJZZ1ZHamtxZmo0VDFIQkIxU0lwUjQ5Ky9RSWM5dEFBSUtUR1NS?=
 =?utf-8?B?VHRDUENnSEh6K3VyM0x0V3ZxZXQrSmNpRyt3Q3VZeXVNNWE2YlFHUjhMRDJC?=
 =?utf-8?B?Uy9mNGtqRnB5YU1SeFJXOUhTcXlUanNWWnhSUnJiR3o3UDQ4VUp2L2U3dUI5?=
 =?utf-8?B?QS9kK0Z5WWlWVE81KzZIUzVScEx1cUNNUW5FZ0JEKzgwVkVlWk5Jd2xjTWNN?=
 =?utf-8?B?ZFhEakgvMVVUNVRYZVZmWmJuMVN4bFdIRmlqWXRScTA1SGxjQTl1Rk9DQkhY?=
 =?utf-8?B?UkhGSTBwejhrVm5jcThEbkRIcTI1Qjh3QjYvMjhqdU5lQkQzTitTUEROV3pU?=
 =?utf-8?B?Z25RcS8zTnhBY0E0aHBWMGg5eTRudzJtaVh0TDFvYWZVaXM4Q2ExTk1KUkpB?=
 =?utf-8?B?WGU4Zm5QenlwQ2kxbDlFRDRiYXFJbHl6em5UbjQwc1ppc3dJaGFuQUJ3eGt3?=
 =?utf-8?B?cXNVcmplejlnc09yT29oOXF3WG82V3dRN1Uzb1c2dTBFdjlSM2pXdktLdnJF?=
 =?utf-8?B?VzVhb0RjOEZDUWlIV3orSE9TZm9XNmhSUE9OaTZqZk93YmZLRzBJeU15RDFD?=
 =?utf-8?B?d2xvc0Q4aE0yakZDNk1ValJ2Zmk1cXFKNXQ4SVhiaUtjemtwbUpiVC9wemVZ?=
 =?utf-8?B?bUg4TDY2WUx3elNIRGJiVWVNRitzQnNuRkRSWGRIak44YVN4NURiNUk0Vzla?=
 =?utf-8?B?UG9qR1IremZjRGJscmU1aDZQOHhRMzdzZ0pycFFCMk96ZGZ4SmE3LzJGQ3Z1?=
 =?utf-8?B?NWFYV015NkpZaG4ybFIwQjVPRmxmVGRiS2NJWFozalU0Q0hnVCtkK3pzMDJI?=
 =?utf-8?Q?ETdxVpQ/ZTgMUAyvaY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clIxT2ljUHFieW8xODMxNWRBbHp6dGsxMm4wY1dqaHN5V3JHVytBaDdyWUlG?=
 =?utf-8?B?b1BOZWNiM0ZxZWcvVWxYZS9jV1BEM2tJQ01NWjgzN3BrdzIxQTYzd2dqeUUx?=
 =?utf-8?B?RGVKZmtNODNPbDJJTmRRNHU4SWxpRSs2OEg0dzl1d3JCWHJ1OGczckRXZXlz?=
 =?utf-8?B?Z0VGQzN0L0dNb3M3OHk4UE40MElyOHBuVURtcVJLQit2djhaRFZtUjVWcngy?=
 =?utf-8?B?QnNEVFlMazB4Y0QxMmF1V3YwU1l3SU01djBLK0pDRXU4eW9LMXhHRzVNdlIw?=
 =?utf-8?B?SVo1V0g1SENKenRta280S2tnd1dHNTJnWmdyVUsxQXdpd3pESWtXY2ROc2Zm?=
 =?utf-8?B?ZTNsSVdKK3p4YjNNR2hnR1JJdXBXbHlTSXhiUEVtTXB5Y3JsVHlQcm1wdE5k?=
 =?utf-8?B?YklJS1Bpdy9rYVgvOUJtR3FsTGZlYVVEcWYwazFGR0o0N3JvcFdwanBsam1u?=
 =?utf-8?B?VElXZ0dwc1lRbWloZ2xFazJoYW9xZnNObzJYNDM1Q3o1SWI3YWJUTjI2eUR3?=
 =?utf-8?B?WGJJaFBVK2M2c1Izc3V6WkJHd1YxMWxFWitEamI3K3RPUWl6MTY2R29jSEIx?=
 =?utf-8?B?eXo0TnF2UkFydFFwOC9ZNnF3blU1QVFiRGV0YjgxZVIyYU5kZE5IM2cydEg0?=
 =?utf-8?B?dytMVUpJaS9lMEZkTmRUYWtHaDJqWTZQM1lVMkFVQ2dldktZZzVKakFPOXJW?=
 =?utf-8?B?Uk56OUo3aEhvZGYxVlRSVE9yWkk0TklGV29NemNEQnBCV1dReWFBSWhiVnZB?=
 =?utf-8?B?RDZRa1piLzR3K2pYVUFNUVhjck9GV1RqN0FDL21tKzVYeEFoN01LN29VTmlI?=
 =?utf-8?B?SE1EamR0Nkl6RDB0YXFNbE5MM2NQQngwYVpvVnhzTy94NVlCUDU5YURiYUtK?=
 =?utf-8?B?aHZIbnp6VWt4MEtUem81aWY1dXBqTk1OeGlMblhXeDcxSVc2Qmc0SkFMdEFY?=
 =?utf-8?B?eVJYMFhNNlNRclEwemYySUJMeFNpWEhnWENWV05YL2VBVW9QWTQ5RkFCVFhE?=
 =?utf-8?B?clJkL0J1RGlFMEJNRVNHamFqSXNyMm9xZWFWZW5EWmNyaUt3YVFjWUNzak1E?=
 =?utf-8?B?UXdMVDRuRmk2ejMxbmJrQjV3a3dYWTQ4SzdTTDhENUNHc2VmUWhnU3VESGF6?=
 =?utf-8?B?NjFYN2c2UGtwaFdHMERwWlJDOC93TCtvbVFlbHdmV0ZtNVVoSWdnR2RORHNI?=
 =?utf-8?B?WmlBSDVScUh1M2FXTHZJL2wyMTdmbS9EZWhac1RlUWwyMUw5MkEvTlNGMjBH?=
 =?utf-8?B?UXlZZnpHRkJ5U3JReFJDTjhPUHl5ZCtnM081eGNOS05BRkwwMWpnemtyNmpO?=
 =?utf-8?B?cnB2Qm51YTQwMWJwWVpzNlc2Z243eGhTaVlWcFV4dllua3dkdTZpQ3VucUgy?=
 =?utf-8?B?VlExOG5pd2Jhdm9lSDNBNHZQZkN6V1BLcm1qd2Rmb1UwQXQ5cDEvWUx3MnVy?=
 =?utf-8?B?UzBMMUo0dnVCNW15SHY3QVZQVnNXdktrc2tCeG9RQlhlM0FHTStnNThoUFNk?=
 =?utf-8?B?bjVBMmFEeWdyQm5DTzRrNlBwcGM4UWxoN1VjYzFNRDBHbGZYeXZLSUVCZHdZ?=
 =?utf-8?B?cSs2MHVrYnhyYWFOTDVXZUNoL1lhMEV0THhGR0xyWEZQaVBzdkYrWWJCYTdu?=
 =?utf-8?B?Q1E0Y1NDR0VqM01JbE9JQUJOdjZwcmZsT3FFNzZsWitCc1JTbkFwRXVza1VD?=
 =?utf-8?B?YXhwOGhEMXhrSFhyUHNGOTJOd00vRWhsemo4b2l4ZWd5MTQzQjFsZXU5MU4y?=
 =?utf-8?B?MEdwZG9ObzBjb2lJT1BOUU90V2xJanFhanlrVzJmdWVIRmJGazBxcTVVSG5R?=
 =?utf-8?B?WjJJV2pzTU0wZUxyR3JzaHpZcTQ3NW5CekdBNlZsM3Y1NVRYY3BMdWk5VzN6?=
 =?utf-8?B?aW0vYWpwbFczYU9GSU5jejVqZzhoL3NKd2pRQjBTUU5uT2ZyckR5bW5DVytx?=
 =?utf-8?B?TjZmVCtkTHVlOFdLMmMrcGIrYk55RVFXZGVIZlBpSFAwMzFLSXNvOGZZd1d3?=
 =?utf-8?B?VlMrNGhkR3J6QTBaWFB1SDJIZEErWTFuMCsvamZZK2lvZ1NQODdtOWhtY2dT?=
 =?utf-8?B?MkxDdDg3M0dHUFJkUmM2Unk2ckRpREFIK3BtazZVYitycjl5cDBQZFRLWk45?=
 =?utf-8?B?NnBlOWRNNm8veXF2SGxZRjJ3Y0JXL1JjQmh4MU5UWnMzM0k2MUphSGk5QjhB?=
 =?utf-8?Q?5iTl908pDi5djXq3St1Fa14=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b0e095-f2fe-44e3-de7c-08dd10491825
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 07:40:28.3937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gr22bS+BWDAGk6f97NjPeB2a1pb3W0AadM//94Nx7ML0zWG0AD/G2gdZA86xEyCLEJ9E9sg5r7co6kou+Umv/ZTqfMLTbA96ktegza1oJryWXVtwrvEaG+x5a4UtuGeb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7317

On 11/29/2024 12:28 PM, K Prateek Nayak wrote:

>>> I also see PSI splats like:
>>>
>>>      psi: inconsistent task state! task=2524:kworker/u1028:2 cpu=154 psi_flags=10 clear=14 set=0
>>>
>>> but the PSI flags it has set "(TSK_MEMSTALL_RUNNING | TSK_MEMSTALL)" and
>>> the flags it is trying to clear
>>> "(TSK_MEMSTALL_RUNNING | TSK_MEMSTALL | TSK_RUNNING)" seem to be only
>>> possible if you have picked a dequeued entity for running before its
>>> wakeup, which is also perhaps why the "nr_running" computation goes awry
>>> and pick_eevdf() returns NULL (which it should never since
>>> pick_next_entity() is only called when rq->cfs.nr_running is > 0)
>> IIUC, one path for pick_eevdf() to return NULL is:
>> pick_eevdf():
>> <snip>
>>     if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
>>         curr = NULL; <--- curr is set to NULL
> 
> "on_rq" is only cleared when the entity is dequeued so "curr" is in fact
> going to sleep (proper sleep) and we've reached at pick_eevdf(),
> otherwise, if "curr" is not eligible, there is at least one more tasks
> on the cfs_rq which implies best has be found and will be non-null.
> 
if curr->sched_delayed == 1, the condition: '(curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))'
can be true. Please correct me if wrong.

>> <snip>
>> found:
>>     if (!best || (curr && entity_before(curr, best)))
>>         best = curr; <--- curr and best are both NULL
> 
> Say "curr" is going to sleep, and there is no "best", in which case
> "curr" is already blocked and "cfs_rq->nr_running" should be 0 and it
> should have not reached pick_eevdf() in the first place since
> pick_next_entity() is only called by pick_task_fair() if
> "cfs_rq->nr_running" is non-zero.
> 
> So as long as "cfs_rq->nr_running" is non-zero, pick_eevdf() should
> return a valid runnable entity. Failure to do so perhaps points to
> "entity_eligible()" check going sideways somewhere or a bug in
> "nr_running" accounting.
> 
> Chenyu had proposed a similar fix long back in
> https://lore.kernel.org/lkml/20240226082349.302363-1-yu.c.chen@intel.com/
> but the consensus was it was covering up a larger problem which
> then boiled down to avg_vruntime being computed incorrectly
> https://lore.kernel.org/lkml/ZiAWTU5xb%2FJMn%2FHs@chenyu5-mobl2/
> 
Thanks for the information.
From the timeline, it seems the issue is before 152e11f6df29 ("sched/fair: Implement delayed dequeue").
DELAY_DEQUEUE may introduce risk for pick_eevdf() return NULL.

After patch 1 ("Fix warning if NEXT_BUDDY enabled"), the NULL pointer panic disappears.
Patch 2 ("Fix panic if pick_eevdf() returns NULL") is a safe guard.

Thanks,
-adam


