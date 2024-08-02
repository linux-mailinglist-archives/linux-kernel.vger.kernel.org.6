Return-Path: <linux-kernel+bounces-272127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EF0945785
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 07:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ADFB2863CE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 05:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DE6224D6;
	Fri,  2 Aug 2024 05:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NLsJhRBZ"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268492E646
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 05:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722575931; cv=fail; b=Fek/ksOKNBSi+lU/NHqSjNge1yf4rbAHPgD7U6hxYXCMRTKP62qFtPff3pAf+6XUqSGq8lyNkV44FyL3PKyfMEMX0lDvcvgMx4QR1IPUFgtbWCElWdSrA66ZPDwszECrztau4xuJKa+rHrIHTkRnFqitkBgLuTrBAmnAKq2l0Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722575931; c=relaxed/simple;
	bh=s4CfPqrv1V6xh+tvjVOZb8orXngZO9SQEWCPCnW9+7U=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cx2TRh542Becd6LC4VhVXXeZDHdFgqS1FV2pIOBQPu+Q5GFvVVqc83a7g15l5Df38J8zYTcaOfGeKYxWCDXEMi4kJ1mD1Z/92AgNl9+KzTEpHplDzSpkHbHSL2q7FrAk3b50GC6gtvVwUjyS8dtTbGBL3Pv1bIfZcAIy3hp0YZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NLsJhRBZ; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6XdvGgOexs5Pc5pckxE1pjVSPVTs0yx9N7ubBb0G2YvZJ8PeU2WMx7pd7c40bm55YjZcJKnzQK99ZffGZN9e9R84gO/bB+h9oqNjUKxz/Kdw+6OIMloIgrk4plFStmeHklRr9gWubjvk9QJFJDPdn7zHhClZLKZGSKB+0X86fIP0MvUgqjFVFi+olKCrOiJpUgXL4Ku4MgLcMmM/NBy/DanJywyTaTpBf3485qKgGoIN9MCmaN3VcaXpkrVs9HEVZFqz6IQfiXpE0PqQiEv/8jy7d56RU0WSDibEluttf603cJi1am/D+91pRQDBDq4w+tXtJRPJESpB6mn/sXRmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAZVsS5wowFcpieR1X+Hxi62lCzngSjiFluEIFPd3nA=;
 b=fBEA9u5dxj7ilx+qTtwgsvxZkobRnII0fdgH+2uQS+Ajd/PepuMKzK7dhZmV8LCEzNEzHlp7+hrWspiR23rd6FA4oEOsx6iKE1Ygd/gmSZYXxFGmCtt2xLjAyfgF3l6Wei6Mlf+gKOUWJ9m3vbN0uTzOb/l2RTT1lt4/PWtWOiGz3vGe7nTmm3E5rqS4C3iwhLkA1EaOdGscIWW3NEqzpYQXcQd4lmwS1GE0Af42hm2fLwSY9TSajwkGPEMR3EdSHX9aEZXEDnZIWvDJSK1vdUR357b9lQPRwK1mn4LXgTw1vnoobT9mIVn6fr3+yGzOCF37KfI1zPnYkKZ2merOxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAZVsS5wowFcpieR1X+Hxi62lCzngSjiFluEIFPd3nA=;
 b=NLsJhRBZhYXniSo+UR1LC9guIcKTmBV5qQZ/4pm+t1ndBMVL8bKz3Ykl0Hm6z2aZ8hYCssKElOiCnE9inWgb08TFG+x+qZemYGdcJS+4FhJDtt3NqsbzfEH/gJCtcok0eSmsCQ06ld3ja0li1XOyTwiJVI9vf4ItSKEy6Q86O8U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by IA0PR12MB8837.namprd12.prod.outlook.com (2603:10b6:208:491::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 2 Aug
 2024 05:18:47 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%7]) with mapi id 15.20.7828.021; Fri, 2 Aug 2024
 05:18:47 +0000
Message-ID: <c25f36c1-8703-40d9-818c-a5a5f7472c63@amd.com>
Date: Fri, 2 Aug 2024 10:48:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vmstat: Fix placement of per-node stats in
 /proc/zoneinfo
From: Shivank Garg <shivankg@amd.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
 hillf.zj@alibaba-inc.com, mgorman@techsingularity.net, hannes@cmpxchg.org
References: <20240725105626.824-1-shivankg@amd.com>
 <20240725124710.76206c2c9baa27b8463b825d@linux-foundation.org>
 <32f8680b-ca66-4126-84ac-d8e375ce2f18@amd.com>
Content-Language: en-US
In-Reply-To: <32f8680b-ca66-4126-84ac-d8e375ce2f18@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0230.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::15) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|IA0PR12MB8837:EE_
X-MS-Office365-Filtering-Correlation-Id: 299a1da0-c23a-4960-6346-08dcb2b295f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDd1Vkd0QUM3SnhzdGcxb2MxM0czNVNiZmtVYWlTek9BQVNJVjN0Qkp6dncw?=
 =?utf-8?B?T0Fqbk85NEMzTEFTaHNBdDU3YnVYWXpUZ1hWZzRMKyttb1ZxZlA5MmI0dTRH?=
 =?utf-8?B?SlBia0ZxQ2VZaTBwQXUrWGEwZm93Q05LUm1obHQ3WjRJZGQvZ0tqY0lRK09C?=
 =?utf-8?B?a0dRL2krTkoySXo2TEtRMHlCNTc0WHJtald1ZG1FWTJzeTFnZ0Z6ZFpHQ0dp?=
 =?utf-8?B?ekJ2bnZqcXhXQUp4OVpDdWdQd3JpWHFQZjFNQlhRazF3NE4wNzBHcFNkZmJZ?=
 =?utf-8?B?WS9sWnJOZFJkQ1QwSmV0OEcwbk9BdEgzWmFzMUZQVGxnWHhGUmVhMUFZQW9F?=
 =?utf-8?B?cmJ1Q0ovRnB5dXUvZzFiL3RYTnlUTFI1OUNJL3RSb1hZUGZpSmVhWjEwbFV5?=
 =?utf-8?B?S3dORm5OZWVsTWVNMmMzYU9jTDROZUkvd2grdzlveU10ZzY3SllZaDVzYjhG?=
 =?utf-8?B?cFM5QXQvVkhLZXJXVE5nejhod0ptbk9rODF3SjlBYkhMWEtBSGFzTzVmcUtu?=
 =?utf-8?B?WDNOQlFtcWpLbExkVmFLd0l1N3QrTHJsK1crVWgzOGdMa254K1NDTlA1QnY4?=
 =?utf-8?B?UVpYTUNiamtJYlJTZ1RxbUdUWjlhcTRKSE1mWHk3blJpY2hFZ3Q4K0l1MENR?=
 =?utf-8?B?VzhLU0J2QjNla0Z2MnRPcGhQOEQ3SXJ0OE9wK2puTTJyUk40cTVjTnU1TUwx?=
 =?utf-8?B?SjNpeHVIdDZnSncxdjV2Q0R2bk1jNVA4c2ZCMjkxUE12ellCam14Z3ptaGlN?=
 =?utf-8?B?N2hoVmFPaWk4ak9OQkRWdzRqWjFiakExbmducWplaklJQ0Foa0NuQjRGaDRD?=
 =?utf-8?B?MER0SFVyYkEydDRCZmh3ZlBqQTh0RG9XdDRveDZFQk1mK2Y5ODE4OFBna1FC?=
 =?utf-8?B?czdQQ0ZzaUNDa09HcnJNc0hkM0FQdjZyRVIzZWdqVitTNlRSZzlXZU5waU5Z?=
 =?utf-8?B?Tlo3ZXAybGVCUU5hUHBVZndacUFPaFJtMlpBQUJURUtpL1pxYTZjRVlIN2Z2?=
 =?utf-8?B?eUl3UnZab2JwVlUzWDB6NG55bE43d01pUnNkNzFOZEgvanRKQmdQTm1Fc0gy?=
 =?utf-8?B?YzNYQkg1dXd4S1N3bHdGeVlYNXFFdVZQVFNZTkJZSVZhUmZZaUpyZk1IWmhr?=
 =?utf-8?B?ZEpnWEFTZVhuZXBENHZMUlJLc01WVFkzeVZBVFJ6NmlnS3V5aXhJU0xuUWQz?=
 =?utf-8?B?azRsSUt3Z1M1TUl6Nm9aVXU1MmUrMXdqc3F4L292QUdiUm93RVZJTHpRN3FQ?=
 =?utf-8?B?UWpFc2d6aHQwVkZ5U3V3Z0FMZW42bVd5UXFBOWpwazZEQmh0ZHQ0YjlwS0VG?=
 =?utf-8?B?RGczWi9BdmdGTmoxdTVsekhOWjIrbmhDVVl6WllERFViQ3NuSkJrc3pFWldK?=
 =?utf-8?B?MTFBbkZiYjFTbzJ1Zy9FNUIxOUJmdm1aVWU1bHZzTllnMXdvVjF2dDdCYmY4?=
 =?utf-8?B?VG0vVTlTMXZGSzlQTEM1dHduNHFQelFrTUNPSkRoUFc4YnkvYnNHSWVBWk1J?=
 =?utf-8?B?YUlDOE1mb0hOcC85cExLU0NwV1Z5KzFYc1g5Tk1meW5zaGIyVGdSOWJ2NUc0?=
 =?utf-8?B?OCtiVGduajlEWENOT0NZa0xFWDJzQThuLzhiRnR3U2J5TUcwNTR4TS9YUFNn?=
 =?utf-8?B?R2tOU1NubzIyWkJ4dU54UTJoK2ZUUDJ3UGNETnBmRk1sOEVnMTBHL1JpNFVB?=
 =?utf-8?B?QXQ5b3hyQlpXd0tFdjFHZkZBV3RpTmFwa2VnUWhPWThIZHUwUUFpdEJhaDZU?=
 =?utf-8?Q?jCrAsLlu32Qir2HDbQ/QzQusBFopvgjUMpXGjkO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjNTS3Q5bnRrbzVLa2w0eVU2UWx6RWs5VUpzbTNOZCswTGRVSEpTMEtlUnNw?=
 =?utf-8?B?SDFGenIrdVQ5akc3d0c0VCs4dWtmTjRlWTB1ZUtOWm1oU0kyZURlTy9HVXZ6?=
 =?utf-8?B?OWU5ZEJLeEMrUndKVkZTU20yRnRjTENJZ0xObm1UWXBBSWlZQ0lUM2c1dVhL?=
 =?utf-8?B?ZFk0MzBkUkF0dk5WTWxuUEtMcm9UeXhCdm5jQ1lBK3MveldQWkNONWRuVUNW?=
 =?utf-8?B?M0laaEdlaXUzenA0eW9WZzFJSlhtYVRaYUVRMGdOM3U0L3BKMXA0dThnYWhM?=
 =?utf-8?B?SlA1OGpXSSsvTlhFTFBEd0xsanNZWDVTVzlla2xuMUZkWEtNNjV0Y0EyS3Z3?=
 =?utf-8?B?aU5tZ2V3WTNTdTd5QUp1MXdoTW9KU1U1YUlQblg2bXkyZ1pycFd4WTNiVFBX?=
 =?utf-8?B?bEJjV2ZwSDk1UEk4VTQ1TTRyckpBbitZRlN2VnpxQnRUTTF3aGk5eHJyZW5Z?=
 =?utf-8?B?MlJKU2huWUxkVzBzMzFicVRXTzJVUW1nN21aSDU2dDgvWnNHK2VZbWl6eVNm?=
 =?utf-8?B?R29SYlY3YXNydDIrcGZzMC95T2VQdFJrcFFITjdma1RqTlR4bEhyQUc2Q3FG?=
 =?utf-8?B?UHVIcGxRMHYzVGR0aWZSUE1yTDlBREJBVDVydWpxVktyUDA4L0p5a3k3RjNl?=
 =?utf-8?B?TnlmejBjU1JIQmdBdm5CQUNZUlNqZXd0Z2NsbS9MNHNWMjUzblJBTDJHSmJi?=
 =?utf-8?B?bDB0NHBMVkdrajVUdE9PQ1J1cHNjb1lNZ3QzZFVuUjJkaDcxQmQ2RlpMOXNm?=
 =?utf-8?B?Mmxzc0IyUWVITk1VMGIybnhJQzZDMDl1b25PN2FOa051RmFiQlNNSDJDcjJ1?=
 =?utf-8?B?c2dYNWROeWxtUFFnZVgyWjRRVXg5VEhEcDg2eGVwSVRHWks0dnlYUTlXRk9T?=
 =?utf-8?B?M3cvSnJwdk1pbEVxdWZQakZFYlBpalhUMGVSVjlIZTJPendKd2ZJK1RYeDdF?=
 =?utf-8?B?TlZodjlsMHpIaEMxdkxPdUxRSUc0V0NLZVhqQW1UNDdmWUhweE1SQ3NVdDdi?=
 =?utf-8?B?blMwZ2ZIejFmdmg2MmswZElISWpLOG1iWHFjRkhNTDRKd05CeFNGUm43bWRU?=
 =?utf-8?B?SUVQd0hReEdEY3RLRERZS0JjbEZwOU5lNFNoa01vT3VEREZKNnBETkEvSjJ3?=
 =?utf-8?B?ZjlBeTcxdnZEcDJrdTNBTGtUMHg3MmQ5S21SVExvMEFlWCs4QXZGMERMTzky?=
 =?utf-8?B?cUVMalRQajdBZ0Q1anBoRHZrbFUwTWxPYTRGcENEU2hSNkFCa2JqY2FnLzM5?=
 =?utf-8?B?L3VEUXorK2FGaThCNlZmZkczMi92UEVBYjRaK1A3SlZ3Zm8rVzZBUmhoYVlJ?=
 =?utf-8?B?UjJlVlNwS1ZlN0F3WVJBL1JZOXF3YzI2cTEyNGo5Ulg5dnE2bmZRVFlrN3dV?=
 =?utf-8?B?Sy9hUWdRalVFNG1uSXlLcXhpOFl4SVJHaE04cnpvakxkOWdiREp6N0trb3py?=
 =?utf-8?B?QUZUYS83TjdaTXExejJUcjBvWjdaVEZZczJpWG9pYnNiY21mb2JuSjQ3Rmxk?=
 =?utf-8?B?Mm5ObWFMa2RXWUJkeHhIN00vRlo5MCt2OFRzNE1EY2kva29wNzlJdXcyQ0Nr?=
 =?utf-8?B?SDlPbEozZjIrVnBBR2NVSnRCc1pBRFYzeFRKY2ZPNHRnZHZTei8ycXpkL1ZL?=
 =?utf-8?B?eVFmNHhXc0xLbjcxbnpnY1lxaVZtR0tGdU12Wmlucm9SQUFmZis5clU2RmYx?=
 =?utf-8?B?YndwYndyK3cycWVMSmxhVjJGdGlYVmJQVFpWdEM0aDlvQU9GbVAxOC9PS29Z?=
 =?utf-8?B?c09rK0lwMDliSGJFd01TQTBVT3I0RnFMOENCUUE4UlVnc1R1US9BUERObWpW?=
 =?utf-8?B?bmREL1d2L2p2ZTBESzJtdEFhQ1dxdnRyODJDV1R5TU52Ym9PK0s3ejNrSHJV?=
 =?utf-8?B?RDNlbHd2NU1yZjhRMlp2dC80QTRqOVpWbjU0Qm93cllrNEExSG1UM0crSGR1?=
 =?utf-8?B?LzRDSGlubDZXYjdQNFRpWVFzZW5xajhMT3FJdEo0ZnZUek9vTFlHUVlocXVC?=
 =?utf-8?B?NWtVUnplQmY4SGgyUk1ROXFVTDB2Z1owRFgxYWVBejI1Mis2UXpiZ2F1cEVt?=
 =?utf-8?B?a2QrWWkvVWtmTXVJZGEyT2Y2Zk9xUFJMNlpJS0NueVJ1Q2VwU1ZwN1NzNXlE?=
 =?utf-8?Q?zg0yCZlAXGFalIjkevs2q61hX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 299a1da0-c23a-4960-6346-08dcb2b295f6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 05:18:47.3532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U7cVZkC0uOcHE8cTFGzMhjSwzNseoMfZYPVstIrFd0Lu5/GhTpQjWwHiA0KYCGI6j6oZgwtmu2NJ65fDO1Vphw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8837



On 7/26/2024 9:46 AM, Garg, Shivank wrote:
> 
> 
> On 7/26/2024 1:17 AM, Andrew Morton wrote:
>> On Thu, 25 Jul 2024 16:26:26 +0530 Shivank Garg <shivankg@amd.com> wrote:
>>
>>> The per-node stats in /proc/zoneinfo output are incorrectly inserted
>>> between the first populated zone title and its specific stats. This
>>> creates confusion while reading or parsing its output.
>>
>> I pity anyone who has to write a parser for that mess.
> 
> Some userspace parser have faced an issue like this:
> https://github.com/prometheus/procfs/issues/386
> In the fix commit, they are ignoring per-node stats section.
> 
>>
>>> This patch relocates the per-node stats at the beginning for each node,
>>> followed by the individual zone statistics. This fix results in a clearer
>>> and more consistent output format.
>>
>>> Fixes: e2ecc8a79ed4 ("mm, vmstat: print node-based stats in zoneinfo file")
>>
>> It's been this way since 2016?  Surely there's a risk of breaking
>> existing userspace parsers?
> 
> For some of the per-node stats, some application may probe the
> /sys/devices/system/node/node*/meminfo (in KB)



As per this commit,

https://github.com/torvalds/linux/commit/e2ecc8a79ed49f7838b4fdf352c4c48cec9424ac 
"There are a number of stats that were previously accessible via zoneinfo
that are now invisible.  While it is possible to create a new file for
the node stats, this may be missed by users.  Instead this patch prints
the stats under the first populated zone in /proc/zoneinfo."

per node stats were added to zoneinfo since some stats were missing.


However I find that all stats are in fact present in 
/sys/devices/system/node/node*/vmstat
hence I wonder why should we continue to have per-node stats in zoneinfo.


> 
> There may be a possibility of breaking scripts, but it will make the
> output more consistent for future scripts.
> 
> Thanks,
> Shivank
> 
> 

