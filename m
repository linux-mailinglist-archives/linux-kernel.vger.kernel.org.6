Return-Path: <linux-kernel+bounces-209812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB79F903B35
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6444C2898BC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6904B176ACC;
	Tue, 11 Jun 2024 11:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="XGRDva6t"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2073.outbound.protection.outlook.com [40.107.215.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F0114F9E4
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 11:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718106955; cv=fail; b=YWtIQZc30X/nKpfVHM7H/1MZ6eZw+GGVMCzh7FHuOCS7lY4NS8dljN+I6M2A8qPl0HQX4zt+m17/IK0uQPwoTxDGQAeGSC4w8HBtkzD2Sq0yvvcDnmXbskaBPoC/1cfGUUIjp2/scC0KdsLGA7oZalvWs2JPScaTxOO5gzMc5eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718106955; c=relaxed/simple;
	bh=MB1vBn4SEoH7GTsZkyogSeqiU0ovifuIeBNLDdrnRLY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aP0RlJooQ8bF1+acmlxMYOi8LtOz+uVUXdNIrzrNmlaJY821TBhUsjCmzHe1PhBsHN7Pk7Fg9C6XoMzoOQAoHiB8VurozVeX7I/2Og08Y/R/aAUjNL63g1vqGxgGvvXp2cv+ssOe927q3EiQXYjYoWSoE6A/jETddeoOodK+ZpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=XGRDva6t; arc=fail smtp.client-ip=40.107.215.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kErNFoMRJHvPu+VFOYN4h7jOs19eZx0akj5naXMAdOLxjPylNUpvCNVq4KjNvu8MYzUNVS3RuC9B4t0zYs/QmsZ3+I/kjyBSca2dmjjFBWiwk88D3G50RjJaEIqhVa3uJfP+DivzAdngN+x8Fb+hajV+CrIF1WjAnLvfkJSbg6JoZWkP0QE9aMSu7wSRy5833NfQ0qYMmKyvEK7Ucf2IvSD5cTwZMBVrbzXETmaevQ1LVm4PcKHaNtIsd19pqjKL1pASvwDt1Yop+fUpcAqYQY+SUrV2T8SYWVIz1Bc2QO4PhPYJEYAg5hhTy7VjyWNgKLv2VmSHXJ/cOYcKaSqqsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6wXV+7hvWXL5m+jiq6hqrJoVnipMspSBDceFOx4UvQ=;
 b=gVgnARsFJLNNRuD4UYtKrXsKpSvEo0qso5xIidlQQVkiAR+Qe2zGREx4Urt5KoDg1STg3+E1x8e64yzRHTjrAfILfges6W5J6kCQ+pKf7Jf7TLjfycRNjm2zDgj3Yc1Y+ne4/HV566pPm4z2VAaika9giUhmPqOJDc01DbFX8kOTqNJkvryNytCelq70FeLoHcxVY2ebRqEz/YFZwZo2diMAYBEoL6nTE4hjteLDbiyTnSTrZznJyqat3naMsnPOx5dnWxm7Djvo0WT+uxkQrOANSdykszdnRsj/C88YT5vlA/t1H9SJW2b4g1SAKgj1+CNCYnahd9gFs5h9LiqVog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6wXV+7hvWXL5m+jiq6hqrJoVnipMspSBDceFOx4UvQ=;
 b=XGRDva6t5o/SZfaEZx/tS3+eS0ji7ZS4343gMOibkJ81S/cotm1PohkE5mTgDYqQrHtbmMWnv2z68n3FTHFe52YiA+MaaLwnsJSM2XgpX6O5LOtfV2vIFgMepTegUaS1+su6GwnZqQadevdk0o72nrG1DTmIJLnyt+1jZrITCQE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SEYPR02MB8152.apcprd02.prod.outlook.com (2603:1096:101:206::6)
 by SEYPR02MB7099.apcprd02.prod.outlook.com (2603:1096:101:1a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 11:55:49 +0000
Received: from SEYPR02MB8152.apcprd02.prod.outlook.com
 ([fe80::6bae:c194:2032:70d7]) by SEYPR02MB8152.apcprd02.prod.outlook.com
 ([fe80::6bae:c194:2032:70d7%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 11:55:48 +0000
Message-ID: <4d127882-7552-4454-a151-b051fd0abf92@oppo.com>
Date: Tue, 11 Jun 2024 19:55:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH_V2] sched/fair: updates weight of cfs_rq before
 update_cfs_group() in enqueue_entity()
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 linux-kernel@vger.kernel.org
References: <20240603091805.858-1-pugaowei@oppo.com>
 <CAKfTPtDhXVc4HVeRJzgf9o1n9nOrXM=SgKSru3cynLngFPdxSg@mail.gmail.com>
From: Gaowei Pu <pugaowei@oppo.com>
In-Reply-To: <CAKfTPtDhXVc4HVeRJzgf9o1n9nOrXM=SgKSru3cynLngFPdxSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To SEYPR02MB8152.apcprd02.prod.outlook.com
 (2603:1096:101:206::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR02MB8152:EE_|SEYPR02MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: 19d6550c-cea7-42c5-0739-08dc8a0d6f2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmdCNTVJdXN1ZHZ1TlhvYXJ0b0RtSkFhS3BqUWJON2pqNlloczBKVFdPd0Zx?=
 =?utf-8?B?L1RNWTBXVkVuRG1SNWtIUjNITHUzNTdXSE5keksrYXRtN1BCSWwzZW1PVU1H?=
 =?utf-8?B?Sk5nYXZ4SmhBS1RKREJBZFNwdGlvb1BPbUhoQVEvWnEvdkNBM3RkN0I3Z1dW?=
 =?utf-8?B?Z1FzcUlFaXRqRTI2N0ZiVWRoblJzK2xkVEx5U0hUaDdxNVVyRjZrdDZzWDdY?=
 =?utf-8?B?WkVQc1lBZ0JyYmpxa0ZqYzhHQURPYWpyZ056Qk9lN2tRZHlOaXRENmRTRk9x?=
 =?utf-8?B?UlFXSkJIMVg1TW0rR0hZekFEMExGQTVkbHV4c0ZJZGNrN0gzbWhsMmhncCtr?=
 =?utf-8?B?VUpwMUFIQVlTTHNlcFdxUkNXTUNUbEpVVzc3QVVwYWpTc1NPZGxzc0c0QTc0?=
 =?utf-8?B?eGtKR09MTE9LR09QbUVUbGhIYW1ZL2dZTGVjYmhhUVNQZHcvRndYMXQ1OVk3?=
 =?utf-8?B?dXVzcmNZNzMvRENEV2JtaFdiQUlheVR0a1Q3NWN3b3hyMjVWNmE5T0VGaFh1?=
 =?utf-8?B?dmZnZUdxY295YjdIb1N5d3I4bFFuZmNCSWFMQXAwTUwzOTlXRGUvZUJ4QnhK?=
 =?utf-8?B?amppVGFhamk5TEh6aUwwbjdmTHJwVkVrQS9uQmNIQWF5WlYva2NYc1g4aEN2?=
 =?utf-8?B?K2NsbzM4UXNENGZlcWsxTzRTQlZvYjBKUDk0ME1HSTRFQUwvTXFxKzFQNWcv?=
 =?utf-8?B?NzF0N2lBV0xGTHN0MXZYa0tEMGVqczRmZzQ3NWNERXRmVmh2LzJ5R2xHZm9a?=
 =?utf-8?B?V1h5VEVPbnViWFYycitWYVFham56SHpsdGRsU3VvZ2orMm1lUUVQYVhnaTNa?=
 =?utf-8?B?WnkyM0dYbHVHcWxhVjdKcXYzbVB3ME1DRDlQWDJKVHFWczFEL3dTcFJYcEly?=
 =?utf-8?B?OVBXY2hqMzRRUjJBVmN1Z0dLcDhGNnJXN0pmd2RoQnZQQXRteFJkb0daeUxz?=
 =?utf-8?B?bVd4YnkwclhqNFJSZGpKSmlmS3pIaDZOQ2ppRlgxN25qN3AzOXhycXIvZ2l3?=
 =?utf-8?B?eDk2WDdkb29OYi9Kb2w5S0Eyc2JnTWJTZ1RvZndIMHk1SFBnSFVDV0Frb0VH?=
 =?utf-8?B?bkYxeTFHQ2M2aGVmekVPOUF2L3JDb1o1ZUdVYStEYytkYzNTRHJNMEluSUlH?=
 =?utf-8?B?NWE1UkNjTEtVejUzUjlKdWVTRVZHZjhFS3RZQmEvS05qd21qbEUvY0p3Mmg5?=
 =?utf-8?B?U3JHUFh3TVhwS3Bvb0N0ZkNreVdtQi90bU9LcW1oSHlzcFJpWFBvS3NsNGJp?=
 =?utf-8?B?clJOYkpuMzNnL3dDeGREcE0xVTNUUUxVS3dqRWpRQTFxNXBUaGc2YlF0dDl1?=
 =?utf-8?B?d3R3MWRsOHc4R2VGZXM2YkNEbWVOT05ZSXJsS2tZZE1sNGFJZFR5MjFqZUpr?=
 =?utf-8?B?Zk5aa1FNakFHcTlibmRYa3l2LzdCanBWcTVTMS9ERUIwTkxDYVJwRzR5c0tK?=
 =?utf-8?B?Z045SVJLcDdDbWhTNGU5ZzdxL0NFVXRuUVBWZ1lYNjZLNEJYZHNsdk5Zdk5t?=
 =?utf-8?B?VVVRZCtuRndCUi9INmNEZHlqRjhOdkhWdENmNGJRUXUyS2pHQjhXdUtwUWxQ?=
 =?utf-8?B?UDViUjQzN2g1YUFMcHlYNzk0T0lNOHZGbHZrZ2g0K2Z6UzhRYWI2bEwySCsr?=
 =?utf-8?B?K1VHa0wzdnJMVzVNUlIzNERRcUY5UUMxYitUZmpWWHRXdnFRSmsrcHczMXY0?=
 =?utf-8?Q?ZqPQRNHLqLqRrDi5x2IF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR02MB8152.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzRsNkwxTitxeG8vTGlOT1l4Wm1pSWtkMTl2Tk9vd1psU3E5UFNlbUVMWkk1?=
 =?utf-8?B?QVdlSzRsTzJuSlZPYVpMWFIrWVdSdWJoZnJXNytiMEgwL09nZzJ6OEc3RmhL?=
 =?utf-8?B?RzJrc0VyYVB3N05vVFZWWVVYTjVYUENvVmVQTXpvNnA1WVF1dURYUnFMci85?=
 =?utf-8?B?RW1SVjhmUmlUVys0eEtETkxWaEJSbjdyeW9pWm9ERDZTZkZaUG9NMkFaQXpy?=
 =?utf-8?B?anBSSDRaSFljeVVVajBkWDlWUGk4UG81cm50Q0lCQVNIZ0szYWFlcHFQZGN3?=
 =?utf-8?B?Vmpxdy9PK0xia0QwOUZsakJZRXB1MkhMTWczMzNBZnVJOFlpTXB3SmNYVW5q?=
 =?utf-8?B?ZDhUZmdPb3dESzRTOXllZytkT1Jna3A3VHYyR2JWVk9wU2xIbXAvN1YwU3Mr?=
 =?utf-8?B?V2pwYWxGUkpSbHlxeVZnd1hwN1FTa2lCNW9iS1hLWWt2OS9FME1mTXFYV1dO?=
 =?utf-8?B?ME10aEdPN05HVUYwNDkyK1FwODZJRjR6a3lvS3QzTG5vOWtMR2k3dHBuK0la?=
 =?utf-8?B?dTFMaS9oc2tLOG5PUGxMNDNYQkJHSkxNb3VFR0JhdkVJNkFyaURWLzF3bFZ1?=
 =?utf-8?B?Tzl3bngvL0ltQVAvL3FBYjl4N3IzVzBNNXJTbHFDVE5FWnpCT2ZONUVPVTJr?=
 =?utf-8?B?WGNhdlNTRUdsUEpieUdrNGpFc05tZjR3N0FtYUZ1THNETXlOZXpzdUpRS3pE?=
 =?utf-8?B?ZFNPTVUrSW5qQUZnT0UyZWVvVjBScHdqL3F1T2Uva0k3VDROcUpnaEpoRUp6?=
 =?utf-8?B?YXliVUNaT1pxTzRvTk9vdW5XQWV1NmN0aFkrWDl0S2VUNXdLL1pScGZDTmdt?=
 =?utf-8?B?SW5DYkV3SGhWNkduOXMvY3l1Y1Z3MFJsZkZJTis4Yi9raHhvdis4WExPRzE2?=
 =?utf-8?B?aGliaDNUR3RkMXk4YzVYVlc4eTFlc2F2Sk9FajhFYjdsV0RZZ0tVNDVZODVT?=
 =?utf-8?B?TnFKTS8rVEF0dlFIUU1OK053N3M1bWFsZjRMN1A1RHRnUXlhUDg2cFNIbmVW?=
 =?utf-8?B?WUhpVGZPQ0N1U3dJWXhUNnpLN2NqQTJqeGNVTFpzNitHQzdGZW40UTVEQWdJ?=
 =?utf-8?B?eFJjY3EvQ3l6SVQwOUxscmI2NXJtajNBZlF3R3JKTEJxL0trYkIrOFczR2Vq?=
 =?utf-8?B?eTlUSVVSQ3pqTm9CNERjNnhqb1FwYk0rVFRpaDVDL2tyOFFvOVlPNnptYUxF?=
 =?utf-8?B?VjdyUUZscm05aHgvQzRDL0F6eTFvNkNLVzdRRGo0TzRybXU3U3VqOUlscE80?=
 =?utf-8?B?cVZMVmc3RkhmVjhhMzVOVFlsQVBrMzI2NWNGVGdsdGY4czZOa283NitsTFU0?=
 =?utf-8?B?L0NZL0NWYlQ1RmlHcUNMd3NETlBSR0FNaS9DL2hjVTlkZEZhOC80ZHBaTTUx?=
 =?utf-8?B?YURmaE1Od3JWdjZlUllscWcxRDBYZkVlNldCL1pvQ2k0WU9meC9DK2JGU0xw?=
 =?utf-8?B?bnpzYUZNbUlXWnllcFBLNWdsZ2NTdk5kbkJCNmdiVjMzay9oSmVTU2krRjcw?=
 =?utf-8?B?S24vVWlUcTVUQUl2L3RVYU1vV2NvRlZ3bzMvMXQ1MVVHdmN3VjRJSmJObUVG?=
 =?utf-8?B?OGRiWXdUYUttOEpQa2dCRCt1dnVtcStkMjBRc0ZnQmxwdmFyemYzWnlRSmsy?=
 =?utf-8?B?VkxzT2VpTDhHOCs4aDMyN1JuYkUva3BkWDF1VU1YNUdLa1Q3REZFZUN3ckEw?=
 =?utf-8?B?aEcrUmVvYWU0VU1hem5zSEZ0VFZqWDFTeHZWQ21Sc2FZYVVBUDZEYzlmZGZV?=
 =?utf-8?B?Sk1KMm1zdGxJNFNDREIwTkNuT1VGc0hJcEtRMWxsZWZEZkRlK1N1WVcwQlBk?=
 =?utf-8?B?QWZmbE5XUHBEazFmMVdSOEFiWDJZQTkxWXkrWWRaa01FSWlzQk5KNFB5SG9u?=
 =?utf-8?B?dkZwdGtRUWI5R3hZOTlLcmt1SEVjRkdRSXJqR05xZlpRS3U3YWN3SUU3aWNi?=
 =?utf-8?B?VmZZYmdxa2pXV2tnYnZVM1VDVlBHVHJRT2V1UkF4QXZXcktEVDRCNnV1amtL?=
 =?utf-8?B?TTc1WDFpWjRvR0tPY3BBd0R6VjY2ckxKM1FYTnVnbGFpS3E5YzZvRGQzZjRt?=
 =?utf-8?B?NmlZZUhUem1qSTdqSm1UYlVwRUNjUE1UdFhOWDhGMFdPL2U4bTlpZEZjTXRm?=
 =?utf-8?Q?SmS85M7J/1uviD2Oa621dPp8e?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d6550c-cea7-42c5-0739-08dc8a0d6f2a
X-MS-Exchange-CrossTenant-AuthSource: SEYPR02MB8152.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 11:55:48.5744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZIQ+GFTiRE27hzoY6bGKgzws1dPIBypdLoAJTFS85vH2dZ+Qb2HjU4JUpFjhlJtRehNXmhoZM/Yvc04nyoiCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7099

Hi vincent,

On 2024/6/11 18:59, Vincent Guittot wrote:
> On Mon, 3 Jun 2024 at 11:18, Gaowei.Pu <pugaowei@oppo.com> wrote:
>>
>> From: pugaowei <pugaowei@oppo.com>
>>
>> we should update the weight of cfs_rq before update_cfs_group().
> 
> update_cfs_group() updates the weight of se that is about to be
> enqueued on cfs_rq so the current order looks good for me:
> 
> update_cfs_group()
>   reweight_entity(cfs_rq, se, shares); //se->on_rq == 0
>     update_load_set(&se->load, weight);
>       se->load.weight = weight
> 
> account_entity_enqueue(cfs_rq, se);
>   update_load_add(&cfs_rq->load, se->load.weight);
>     cfs_rq->load.weight += se->load.weight
> 
> Have you faced some problems in particular ?
sorry, made a mistask.
account_entity_enqueue(cfs_rq, se) updates weight of cfs_rq on which entity queued.
update_cfs_group(se) updates weight of the cfs_rq owned by the entity. so there is no conflict
or running order problem.
thanks for your reply~
> 
>> Ensure that we can get accurate shares of the cfs_rq when its
>> weights changes. we can find this work was done correctly in
>> dequeue_entity(). so fix it.
>>
>> patch_V1 :
>> https://lore.kernel.org/lkml/20240531030833.3375-1-pugaowei@oppo.com/T/#u
>> trigger a warnning below because of the changing order of
>> account_entity_enqueue().
>>
>> [ 0.400603][ T0] ? __warn (kernel/panic.c:693)
>>
>> [ 0.400603][ T0] ? place_entity (kernel/sched/fair.c:5256 (discriminator 1))
>>
>> [ 0.400603][ T0] ? report_bug (lib/bug.c:180 lib/bug.c:219)
>>
>> [ 0.400603][ T0] ? handle_bug (arch/x86/kernel/traps.c:239)
>>
>> [ 0.400603][ T0] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1))
>>
>> [ 0.400603][ T0] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621)
>>
>> [ 0.400603][ T0] ? place_entity (kernel/sched/fair.c:5256 (discriminator 1))
>>
>> [ 0.400603][ T0] ? place_entity (kernel/sched/fair.c:5182)
>>
>> [ 0.400603][ T0] enqueue_entity (kernel/sched/fair.c:5328)
>>
>> [ 0.400603][ T0] enqueue_task_fair (kernel/sched/fair.c:6785)
>>
>> V2 fix the warnning and keep the lag without inflating it when it is
>> the first sched_entity queued on the cfs_rq.
>>
>> Signed-off-by: pugaowei <pugaowei@oppo.com>
>> ---
>>  kernel/sched/fair.c | 24 ++++++++++++++++--------
>>  1 file changed, 16 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 8a5b1ae0aa55..2fb1fbcfdda3 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -5190,12 +5190,12 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>>          *
>>          * EEVDF: placement strategy #1 / #2
>>          */
>> -       if (sched_feat(PLACE_LAG) && cfs_rq->nr_running) {
>> +       if (sched_feat(PLACE_LAG)) {
>>                 struct sched_entity *curr = cfs_rq->curr;
>> -               unsigned long load;
>> +               unsigned long load, se_load;
>>
>>                 lag = se->vlag;
>> -
>> +               se_load = scale_load_down(se->load.weight);
>>                 /*
>>                  * If we want to place a task and preserve lag, we have to
>>                  * consider the effect of the new entity on the weighted
>> @@ -5252,9 +5252,13 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>>                 if (curr && curr->on_rq)
>>                         load += scale_load_down(curr->load.weight);
>>
>> -               lag *= load + scale_load_down(se->load.weight);
>> -               if (WARN_ON_ONCE(!load))
>> -                       load = 1;
>> +               lag *= load + se_load;
>> +               /*
>> +                * we just need to keep the lag whithout inflating it when the se is
>> +                * the first sched_entity queued on cfs_rq.
>> +                */
>> +               if (!load)
>> +                       load = se_load;
>>                 lag = div_s64(lag, load);
>>         }
>>
>> @@ -5304,6 +5308,12 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>>          */
>>         update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH);
>>         se_update_runnable(se);
>> +
>> +       /*
>> +        * we should update the weight of cfs_rq before update_cfs_group.
>> +        * Ensure we can get accurate shares of the cfs_rq when its weights changes.
>> +        */
>> +       account_entity_enqueue(cfs_rq, se);
>>         /*
>>          * XXX update_load_avg() above will have attached us to the pelt sum;
>>          * but update_cfs_group() here will re-adjust the weight and have to
>> @@ -5318,8 +5328,6 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>>         if (!curr)
>>                 place_entity(cfs_rq, se, flags);
>>
>> -       account_entity_enqueue(cfs_rq, se);
>> -
>>         /* Entity has migrated, no longer consider this task hot */
>>         if (flags & ENQUEUE_MIGRATED)
>>                 se->exec_start = 0;
>> --
>> 2.17.1
>>

