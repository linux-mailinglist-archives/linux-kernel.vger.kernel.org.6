Return-Path: <linux-kernel+bounces-285250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56352950B36
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EAA12815DA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3D71A0AF8;
	Tue, 13 Aug 2024 17:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="jfKcmVx6"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2125.outbound.protection.outlook.com [40.107.93.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9043A26AC6
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 17:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568911; cv=fail; b=WGDe9o4sUgU2jk4LRNVNAj00A8PToqSOWmtW8xYiN6tT/XQYWVmtUMA+7Obu2NWYCndnNm1UXgybkcIjlDMiJsFRpqhiIlH2QzZdywlNvoNDGnKoBqQQVK4KkgbWvZ0hRlPfur5a4CZMoLQ7IKRdf9cPk62Hk64/qqvJLKZKM0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568911; c=relaxed/simple;
	bh=Ti5SdGkDT50rxtNjz58m56SpzFDHZgMeHEtOs4vrpmk=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VoT1r/pxg9qpUyqCmvIr52zZB/ZfqnYsAIkDSnKYYteHEVdxMNZQW5AfdGsAHrL4fz1RFqguS9ycaFTX8QWYqLhA5wqmChpv5lJtvoiqX4VmHA5L4tG4qyUmpnYk90JjOTaUF0gr1+ZYlv0MOfcaoMJU6BzvlMJLXpk1JzJR7hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=jfKcmVx6; arc=fail smtp.client-ip=40.107.93.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXnngMLXobeiEFT33FD0evae1Y0RIirnKOm6aycHd0Y87fHeRkQF/Gm/MZaPD2ilno5kS08TfCPiVYVUEDVACC11eINOf5BN/ZtXjGIGs56eCQszuJEkmyhyyprnWvD8BiwbLWnQHUOqsQkEfucHolEaL4sc+ZpyaYrGiMBSR5lcR0FP0osSf9JZgFP4w9NXPrwhHvK+pmpKFA+pRkZmXWNWrw54l1Cy5LUvJwt7WNIWN52hCl7rI7r7MiqJHWz9/Q9FRRQqo06W5VRRk1DRxUtFFyIbyWOGI0Vqbn4YdwyOdhvZ0eba8bDV/ZtZ/6FPfVObNvdFtUnJmk+O1FtHlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvKd4RC0lIB/FFA4YOLK77oQihrsMkBvSRtJOpwT3GI=;
 b=S4d0p0C07jfcTYoptZCN2ZnambL2n8zETwFeZM4Q8uoPBBwp2OVgeMWLXi4q1hCQ6fx3a9xDy5NleDO4lJNz+5gaT+33GxU+WhLxJhnLo7Mf1fodE6L3t1GUaWZ0rST2kT7D2p4WsmqSOoSElBs2J9S7RGsh9c2lZXdeMeJOGq2NAYVIv8LnWn6aAxbX/61txlNWgtB4y9ZbwSj6JIeJ6DIe1Qj0G1g6HfeiSHHwQqWKJhAAYTa9hMng0z8Qe/HnsPCarL7GrsJouzSr58VFc888EQM43LMay01ZWP24CyOKnjde/tcnYyllh2NXBR9ICeBLZ54AADoipLxCMjxuhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvKd4RC0lIB/FFA4YOLK77oQihrsMkBvSRtJOpwT3GI=;
 b=jfKcmVx6PDumFUb1nsxbLKC45p5WL6WMZ2qijBnfCMIRg8XA2bC1R4D49yD0zERq3nMHo+upxJAFZz+t8VfiI3ShpPCHsuJkEqU+0uGjVT3a7zbs74hmuHyUlnsKPJZTad4UvKd6HhBReud34Kt1nGZUXtvXoUNeunbNGPNTti4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 IA0PR01MB8238.prod.exchangelabs.com (2603:10b6:208:490::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.22; Tue, 13 Aug 2024 17:08:25 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 17:08:24 +0000
Message-ID: <a8ac43c8-d5e7-4d47-89fb-394db5994fe1@os.amperecomputing.com>
Date: Tue, 13 Aug 2024 10:08:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hugetlbfs: add MTE support
From: Yang Shi <yang@os.amperecomputing.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: muchun.song@linux.dev, will@kernel.org, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240625233717.2769975-1-yang@os.amperecomputing.com>
 <ZoPz14fYSqVyvRTw@arm.com>
 <7a4a60af-e471-484b-a4a3-ed31daaca30b@os.amperecomputing.com>
 <546bf8d4-3680-4af3-8d4d-af2d7c192d04@os.amperecomputing.com>
 <ZoanN7hkWDBjCTu3@arm.com>
 <b140e3e1-cbf7-4b07-8239-abfe8b85d14c@os.amperecomputing.com>
Content-Language: en-US
In-Reply-To: <b140e3e1-cbf7-4b07-8239-abfe8b85d14c@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::42) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|IA0PR01MB8238:EE_
X-MS-Office365-Filtering-Correlation-Id: c3616f8a-569b-4637-e24c-08dcbbba8a98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWpKd2lGUDR6Vkh1MjVwdVJDMURkNXdPV0VqU1lWVzAwaEJPd1g5RXg1c1kz?=
 =?utf-8?B?Y3h6R3dpNFN6eHlUVVVoeWRPTU42cDNkdU4rWUFXMnVvcnpuQTM3bzBXN3Az?=
 =?utf-8?B?bW5teXlqUlFFbWlEamFhU2xVMkwvVThQSk9JSUZ2RUVwaUs5RWdpaUhSSGxO?=
 =?utf-8?B?L2pzVkRkUTBMaFZPelB1bkswa0hCMDBXVnI1QUZPT0x6aVNIN0w3N3AveSs5?=
 =?utf-8?B?Nkt3SjdBV0FrNVV4R2VqSnk2d0FKcHB0TzJMTVFlNGpsMVhVa3dJNU9uNmNX?=
 =?utf-8?B?NlNEa3B5MUtXZzdxSXBVbUgwVnNYbUtDOEZDQWlmdGxJaGtZSzJLRnlWNVp5?=
 =?utf-8?B?OEFPWUJKRVhwL0M3VVpVakNlSXp2UU1KZGFrdkMyTFcyelNqdlRWYzlYcXhV?=
 =?utf-8?B?NkxsVTdoa1FWcEo0RkNFbkF6NkE2YTBMeEpPSW9YaHRVeGlaZ3hnbExrTjdX?=
 =?utf-8?B?R3kramlQWHdJV241UU5ST3dmZnFtaWpVTnBIcTVJS1Vtdi84cW1DbTZNRE9L?=
 =?utf-8?B?OUZlTSsxUU1yQ21UMi9XbDc2LzZjZlNuYXJzNUtKUDkxWDVnWE1kNEgwd3Vn?=
 =?utf-8?B?VytZK016MFI4N3ZjRkIwaE8vdk4xdUxVbndza2NzYzdCN1BoM3dzamRpbkJR?=
 =?utf-8?B?QnBRTlkzazV6Q2ZPd0hKRVMvMzVVbzR1WXFvUVZPN1dyUU4wMTdCQlRWaktE?=
 =?utf-8?B?bkdLcDZ3SU5NSDJNU3A4V1A3aTZMYm1qRzJ1NTFFYzBLdTVzSEpMcCtqM04x?=
 =?utf-8?B?SnFzNWJsbnN5SmttbEJad3ZwUzkyT3U0VGFjUHRncDdEalZIT1lvWTVMRE0r?=
 =?utf-8?B?YSttS0NJR2NDSW1Mc05pR284OUMzdHdVVFVxMi9RKzMyTFlucDJraEpTaERV?=
 =?utf-8?B?RE5YQ1lobHZkWFlMU0NkRzMzYmswUXZ1WWYwZDB1bjBjQUs2RVlUMjk5SDdn?=
 =?utf-8?B?R2xGTGtJL1R5WjFvTmtOUkphVHBzVGhxMk1nY25PdGRGWTNSN2NCbmJESzNU?=
 =?utf-8?B?MjNGM29WK1h4MC9renhjMTRMYlBoUFVLeDZCSnBOY2ZjNk8rK2FMdjNQcGEv?=
 =?utf-8?B?RkpwT001Q0lmeW5KQlh0YmF1ZHFBUFJ0RncvUk1ESWw0cXJ0RkVSMnBoTXN0?=
 =?utf-8?B?OGZIYzA3S2R4M1p3TE5GRlRndjBzMFhVZmprWTNkemxLcFJwVlNXZEpYaHEy?=
 =?utf-8?B?TkVybG0zaEkzTnpUKzhvcDZtRXBHaU1rRkpzYThjczFLeGx6MFZyUFFnd2tT?=
 =?utf-8?B?azdZREM3WElOQitDb2RoSnhaQTBLNkpYanVuQi9wOCtJTnRBenBLQkQ3dFYr?=
 =?utf-8?B?MG95RnRNZ09tTzBramUyaDNZMHpDUXVoMGFCM1J3dU13amd2N1hodE5VajV4?=
 =?utf-8?B?VXlrVnhtdUQrZno5a1ZXYUFXQ3hTTlNycEZjMlhhMmhJV3BsR2ljZnNkNHhk?=
 =?utf-8?B?Q2JnbEcrR0wrTFBKVUFmekF3QmFaTkl0L25rMVVMYzY5TTRndENQVVFMeStC?=
 =?utf-8?B?bjNFNkVtN3JvV1d6TG9ibzlQNjlHQVBHYVZBRXNzeE5UM3NiWWR6SFNhL2hv?=
 =?utf-8?B?aFh6OURsRERnQzBEZU9xTUFQcS9LSWwwVlRkS1dEcW12d0FmTmwvRVhSNmgy?=
 =?utf-8?B?TFV2cGU0Zk92czN0OWo5a1V6cmxTV2RMMDhCYWNzYlJKNHN0RTlNcENTdlYz?=
 =?utf-8?B?Q3Z1WnppbjM2N2s2NWhFRzR6bHdoK3ZFdVpJY291Ym9xS2FUYldZdy9yY0Y1?=
 =?utf-8?B?T0NqSGhMc1hEbzFKa1JzWG02bEtJSEtLQmxHSlB1WjFtMHhBUHBHMnoyYWJr?=
 =?utf-8?B?VjM0Z0wwWWhhdWJkRStLZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWFDUElrQVNIVXR6MTl2RzZkY1haQ3I1SUtaZ3BDRHpHQXlaK0J5WnR2QmRN?=
 =?utf-8?B?Q0NZL1NCb0tRRkpwZXlaZ1pjMzdEZ3JIMmxGb1FpMTJlaXdCUUVCM2FwVlVL?=
 =?utf-8?B?VG1ycUFUOVRuSDg0cjkwU0hTcExYa3dVWUlraGt0KytHdlNsRDhHQXk3OXlk?=
 =?utf-8?B?VnBvY2QrbGFMdy9lK3N2dmY3SlEwMkJSK1pTanp5ZnBpakJUcUU5UHllZE1Y?=
 =?utf-8?B?cEc4c0syeDRKR1lRM1oremJFV3BiZXphSUtkNjlhS25YeHBoUVltdFZxNHVt?=
 =?utf-8?B?cSsyUUZtMklaZ2w2Z21UZnBuZ3lodzBESDlXalVKZGR1K2xjanRwM2JGOW04?=
 =?utf-8?B?S1ZINTdZdnJXeWRFV3FHclh2Y1ZRVVE5ODlRckcyTDBLaWgyam1HVEhoRTNK?=
 =?utf-8?B?c1BGS24rVGpyRHFBY3RzWFdrK0tOQTdscWE1Smh5WDdWbmN3VzB0bXdnNUNm?=
 =?utf-8?B?U0l3b1c0T1cwSDBOM1FXdHlFeUlCUlp0TVViVUU1eHp3ZkpMZHpwYVVwemVl?=
 =?utf-8?B?SEFSa1M5M2ZlYmpmV0w0N21OeTZJcXJPWnl6S3dySTEyUDNOSkZZdE9MY3dB?=
 =?utf-8?B?c29RUXdGNjNoeGxlRnBkSkQyMk9teUR0akpXOVRpRnNBTVFBUG1wRG82aUhr?=
 =?utf-8?B?Nmo1eFFhVTFTdDJLOWFMN1ZFZkpnYWdvNWhsaktmWDBoZlR5RjRZeW02dnAz?=
 =?utf-8?B?cFZsd00velREZE5ubERDZUFaVnBYS2ZJSlhMZ0Z6Vk5JR0h4MGUrV3VqR0Nh?=
 =?utf-8?B?YXNrUTI5OWtzRi9VZW5hbEU1NWNlbjhOOE1NTkxWdjM2UExOZWY2WE9JTC9N?=
 =?utf-8?B?VGtsdWxCNHBZTS95UUNuYURCZXVIRkVGUnF1VDNQUDlkdkpuUm4wVHdCVVdm?=
 =?utf-8?B?TGlTUU1oZm9hV2dYM0xydHVEOXlDbW1RVG1CNGQ3TUdIYVgyZEVicElWdGZn?=
 =?utf-8?B?NG93S1RPVDY2VEdxc2xXbUQ3eXFYMmJIL3hlTERzSER1SWNjT095WFUzM1FP?=
 =?utf-8?B?UVdaeE1Nd2IwTDcxY0lLdG5mUVAwWlY3Z3crcG8rT3MzN0lEYktpMlY3OEM0?=
 =?utf-8?B?SjA2VzMzV2tFZGtZTEt4cjBPWEhMVTNibVVNdjYvVmY0ZnVPVlczd0dQWDVE?=
 =?utf-8?B?d2pmZjlkY0RWUWtDcVdHb1VzMWlOSDUvKzgvR3l5bHZKUjFrYVJtc2pROGRr?=
 =?utf-8?B?ZnNySHdOOFo3WHBmRmFSYnNGYXV5K1FnSGNGZzRwd1FYTVJ0dmc0WUoraVRH?=
 =?utf-8?B?RHZYTUluK1Nxb1FWMUxGZ0drSUtKOFBKckFnS2VMbkhWdktZbjlSTG1KaVR1?=
 =?utf-8?B?Znhpa2thWGx4ckRZeVg5U3VUSjZIekR6OGVYRFVsK0dnUGQ2SUk3cmR6M29k?=
 =?utf-8?B?SzJtV0VsbUNKcFJ3Z05VOFNuNXpUTU1IQUVGSitIMzF5ZzY2VXdxNjhnVmxx?=
 =?utf-8?B?ZGVpMy80ZVh5bE9EUHdwQ1JydmQ5V1g0NGJPSllKYU9iZmZsd0NGVzVCdHQ5?=
 =?utf-8?B?M3FvR1hPZGpkTVZ5SVBHQURESlNEODRWaTdCOXlzTVlQNlhCUUphMmFhTTIz?=
 =?utf-8?B?cXU4NXVLd3FGYVJSM0RaUmFHcTNydGxNbHZwOXI3Qi8rYXczZnpUc3BjR2pK?=
 =?utf-8?B?WUs5SHY4NWVrRUtvNXhhUUxMb09mS0UvcVZveTMwaUVPQytaUndpRVk1enRS?=
 =?utf-8?B?SVZPNXpRL0dTSGZCYmNnaWpXczVKRG5uQW43bUxSOHVyTnByMHQybnJoRWti?=
 =?utf-8?B?TE1reUxRNGpvRXJKamU5cXhnN2FBRkI5bFMxQXhTamM5ZHg2OE9LYUVxV01N?=
 =?utf-8?B?Yk1BWE0zaGdrei9BQktUTXlEeTJ2b1RwR3JjUXMyNXJsVmd0bnpVcXZMd1RB?=
 =?utf-8?B?T0l2bnEyanpxWEJHUjZ3ZTRMZjJueDZmTEFIb2pxQjhVQTF1Z1Z3RFNPakVJ?=
 =?utf-8?B?b0k5VnFhZ0RpeFh5RklMS0hIR2JLV3VWK0NDOTR0TWpUVnl0NXo0cnNueWQw?=
 =?utf-8?B?VkZHREpHbkYreXJadktaRnFjYnhPUGhWc2hlNzFJQ0IxZUVyazhlcWVrNU5h?=
 =?utf-8?B?SFp1UDdnbW8xRjZvM3BxNmJyUUJLSm5jcXBFWGFZUHZtUSttUmcxcmpsYlRW?=
 =?utf-8?B?R2ZQbkM0bXJzUE1ndVR6RzVLTHpXc1ljRkZEZmhHRHNpUEdyQmlJZWJ6RUM2?=
 =?utf-8?Q?F5zyq5FwcjcpoUVdj8hMa3E=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3616f8a-569b-4637-e24c-08dcbbba8a98
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 17:08:24.7976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2x8oi4raA65XZH9o1SzJhAkJYW7cs645DtA/cCE0JuSoOzxOHTirFaQXIOlbiqkIRxNQ3kwUfG/6v1caZ5DIG5uV73Qp0AZaq6EALt0qBJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR01MB8238



On 7/9/24 10:42 AM, Yang Shi wrote:
>
>
> On 7/4/24 6:44 AM, Catalin Marinas wrote:
>> On Tue, Jul 02, 2024 at 05:15:12PM -0700, Yang Shi wrote:
>>> On 7/2/24 5:04 PM, Yang Shi wrote:
>>>> On 7/2/24 5:34 AM, Catalin Marinas wrote:
>>>>> Last time I checked, about a year ago, this was not sufficient. One
>>>>> issue is that there's no arch_clear_hugetlb_flags() implemented by 
>>>>> your
>>>>> patch, leaving PG_arch_{2,3} set on a page. The other issue was 
>>>>> that I
>>>>> initially tried to do this only on the head page but this did not go
>>>>> well with the folio_copy() -> copy_highpage() which expects the
>>>>> PG_arch_* flags on each individual page. The alternative was for
>>>>> arch_clear_hugetlb_flags() to iterate over all the pages in a folio.
>>>> Thanks for pointing this out. I did miss this point. I took a quick 
>>>> look
>>>> at when the PG_ flags are set. IIUC, it is set by post_alloc_hook() 
>>>> for
>>>> order-0 anonymous folio (clearing page and tags) and set_ptes() for
>>>> others (just clear tags), for example, THP and hugetlb.
>>>>
>>>> I can see THP does set the PG_mte_tagged flag for each sub pages. 
>>>> But it
>>>> seems it does not do it for hugetlb if I read the code correctly. The
>>>> call path is:
>>>>
>>>> hugetlb_fault() ->
>>>>    hugetlb_no_page->
>>>>      set_huge_pte_at ->
>>>>        __set_ptes() ->
>>>>          __sync_cache_and_tags() ->
>>>>
>>>>
>>>> The __set_ptes() is called in a loop:
>>>>
>>>> if (!pte_present(pte)) {
>>>>          for (i = 0; i < ncontig; i++, ptep++, addr += pgsize)
>>>>              __set_ptes(mm, addr, ptep, pte, 1);
>>>>          return;
>>>>      }
>>>>
>>>> The ncontig and pgsize are returned by num_contig_ptes(). For example,
>>>> 2M hugetlb, ncontig is 1 and pgsize is 2M IIUC. So it means actually
>>>> just the head page has PG_mte_tagged set. If so the copy_highpage() 
>>>> will
>>>> just copy the old head page's flag to the new head page, and the tag.
>>>> All the sub pages don't have PG_mte_tagged set.
>>>>
>>>> Is it expected behavior? I'm supposed we need tags for every sub pages
>>>> too, right?
>>> We should need something like the below to have tags and page flag 
>>> set up
>>> for each sub page:
>>>
>>> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
>>> index 3f09ac73cce3..528164deef27 100644
>>> --- a/arch/arm64/mm/hugetlbpage.c
>>> +++ b/arch/arm64/mm/hugetlbpage.c
>>> @@ -228,9 +228,12 @@ void set_huge_pte_at(struct mm_struct *mm, 
>>> unsigned
>>> long addr,
>>>          int ncontig;
>>>          unsigned long pfn, dpfn;
>>>          pgprot_t hugeprot;
>>> +       unsigned long nr = sz >> PAGE_SHIFT;
>>>
>>>          ncontig = num_contig_ptes(sz, &pgsize);
>>>
>>> +       __sync_cache_and_tags(pte, nr);
>>> +
>>>          if (!pte_present(pte)) {
>>>                  for (i = 0; i < ncontig; i++, ptep++, addr += pgsize)
>>>                          __set_ptes(mm, addr, ptep, pte, 1);
>> We only need this for the last loop when we have a present pte. I'd also
>> avoid calling __set_ptes(...., 1) if we call the __sync_cache_and_tags()
>> here already. Basically just unroll __set_ptes() in set_huge_pte_at()
>> and call __set_pte() directly.
>>
>> It might be better to convert those page flag checks to only happen on
>> the head page. My stashed changes from over a year ago (before we had
>> more folio conversions) below. However, as I mentioned, I got stuck on
>> folio_copy() which also does a cond_resched() between copy_highpage().
>

Ping...

Does this make sense and sound good? If is is good, I will try to 
implement it.

> We can have the page flags set for head only for hugetlb page. For 
> copy_highpage(), we should be able to do something like the below:
>
> if  page_is_head && page_is_hugetlb && page_has_mte_tagged
>     set page_mte_tagged flags
>     copy tags for all sub pages
> else // <-- tail page or non-hugetlb page
>     current copy_highpage implementation
>
>
> The hugetlb folio can't go away under us since migration path should 
> pin it so the status of folio is stable. The preemption caused by 
> cond_resched() should be fine too due to the pin and the page table 
> entry keeps being migration entry until migration is done, so every 
> one should just see migration entry and wait for migration is done.
>
> The other concerned user of copy_highpage() is uprobe, but it also 
> pins the page then doing copy and it is called with holding write 
> mmap_lock.
>
> IIUC, it should work if I don't miss something. This also should have 
> no impact on HVO. The overhead for other users of copy_highpage() 
> should be also acceptable.
>
>>
>> ---------8<--------------------------------
>> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
>> index f5bcb0dc6267..a84ad0e46f12 100644
>> --- a/arch/arm64/kernel/mte.c
>> +++ b/arch/arm64/kernel/mte.c
>> @@ -49,7 +49,9 @@ static void mte_sync_page_tags(struct page *page, 
>> pte_t old_pte,
>>           return;
>>         if (try_page_mte_tagging(page)) {
>> -        mte_clear_page_tags(page_address(page));
>> +        unsigned long i, nr_pages = compound_nr(page);
>> +        for (i = 0; i < nr_pages; i++)
>> +            mte_clear_page_tags(page_address(page + i));
>>           set_page_mte_tagged(page);
>>       }
>>   }
>> @@ -57,22 +59,23 @@ static void mte_sync_page_tags(struct page *page, 
>> pte_t old_pte,
>>   void mte_sync_tags(pte_t old_pte, pte_t pte)
>>   {
>>       struct page *page = pte_page(pte);
>> -    long i, nr_pages = compound_nr(page);
>> -    bool check_swap = nr_pages == 1;
>> +    bool check_swap = !PageCompound(page);
>>       bool pte_is_tagged = pte_tagged(pte);
>>         /* Early out if there's nothing to do */
>>       if (!check_swap && !pte_is_tagged)
>>           return;
>>   +    /*
>> +     * HugeTLB pages are always fully mapped, so only setting head 
>> page's
>> +     * PG_mte_* flags is enough.
>> +     */
>> +    if (PageHuge(page))
>> +        page = compound_head(page);
>> +
>>       /* if PG_mte_tagged is set, tags have already been initialised */
>> -    for (i = 0; i < nr_pages; i++, page++) {
>> -        if (!page_mte_tagged(page)) {
>> -            mte_sync_page_tags(page, old_pte, check_swap,
>> -                       pte_is_tagged);
>> -            set_page_mte_tagged(page);
>> -        }
>> -    }
>> +    if (!page_mte_tagged(page))
>> +        mte_sync_page_tags(page, old_pte, check_swap, pte_is_tagged);
>>         /* ensure the tags are visible before the PTE is set */
>>       smp_wmb();
>> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
>> index 5626ddb540ce..692198d8c0d2 100644
>> --- a/arch/arm64/kvm/guest.c
>> +++ b/arch/arm64/kvm/guest.c
>> @@ -1079,7 +1079,7 @@ long kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
>>                 /* uaccess failed, don't leave stale tags */
>>               if (num_tags != MTE_GRANULES_PER_PAGE)
>> -                mte_clear_page_tags(page);
>> +                mte_clear_page_tags(page_address(page));
>>               set_page_mte_tagged(page);
>>                 kvm_release_pfn_dirty(pfn);
>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>> index 31d7fa4c7c14..b531b1d75cda 100644
>> --- a/arch/arm64/kvm/mmu.c
>> +++ b/arch/arm64/kvm/mmu.c
>> @@ -1173,11 +1173,10 @@ static void sanitise_mte_tags(struct kvm 
>> *kvm, kvm_pfn_t pfn,
>>       if (!kvm_has_mte(kvm))
>>           return;
>>   -    for (i = 0; i < nr_pages; i++, page++) {
>> -        if (try_page_mte_tagging(page)) {
>> -            mte_clear_page_tags(page_address(page));
>> -            set_page_mte_tagged(page);
>> -        }
>> +    if (try_page_mte_tagging(page)) {
>> +        for (i = 0; i < nr_pages; i++)
>> +            mte_clear_page_tags(page_address(page + i));
>> +        set_page_mte_tagged(page);
>>       }
>>   }
>>
>


