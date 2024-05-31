Return-Path: <linux-kernel+bounces-197328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3A58D695C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10766284C8B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 19:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DD37FBA8;
	Fri, 31 May 2024 19:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jAxffO6M"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392B8219FD
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 19:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717182209; cv=fail; b=gvyyIu4lFUKrdUv9ufIQ73++HNOfuVTVKjQPoOwHvcbPF6g+6rX8kyo25i4o74pel9hg/sZkZB2f6ktu0Iee708ImL4gWlDTbeKukuQv/mkQg6SZsbTWs0RWAPy/s3yhCPpeJwlaObM4HL7iqA/EkLxwcVt9TeDp0YyG3CpNEcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717182209; c=relaxed/simple;
	bh=dIZ/nYmh/pchicQb2B83n/jgrT4UdBJAfv4JOZR5Z5k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JvrGdDQBLXFEw14ebn4OY1Cd8XXNKEOtplhwqA3jYfEyGcj0XFVEitmO0+8nkjKFReIulMGztBALwBjrX1YGE2W7T5F01aJ3ocWputAamH/GC6ljXAPiOWfpV/vPA1aszOYGgaRkuEEY7Yt1LXQUO4GR7ynOmiQBOerHT5kU5Kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jAxffO6M; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3H1naVWvwT3GLnOuuEWPQ7HWBO0K+EYSUwAqoK23X2JEEJvTIM3+oEsjj8mUw/tpf2pMIzrXhalQpG8YcXRwvZAVkrucRVP0LkaBjQJtsw1/kFxeDRTV/8DSPIDGogHQdfuWPA8GzUjFkWpEQ47s5E83a0Sqy/geQ779g+Yr0wksBDsQNMV0fOjAteBv0MwzzGkqrVbuOu8xcNlxKhx7X1QIxVMjiVgQphr+L0n1RbL+6qW3bMMWc6G5XDl9Mxj7EnqBMjFTaeaD5OjERS2zECwttFyf/V/buThmXvUuT87/wH98q4hmSDiWRVIRNnRA2Y6l/DzWDDblHVX2PYJPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynZxi1RAMGUVvX6VYTyjov5eG1Deyazh8J/sHHG3bPo=;
 b=GGXy7ahJzLVNFOHMOLYD3WFOR52vLFX6vJ3pqSo9h/ZYnj6VXTOW9yneCB3uDJ4P1jCb2bHtPp3ngAqYk8nUUI4lGOeRCaPLNTNvy+igWTwhtOnc5YEgzxLB1QdYcm9xSaXXDQYykWpLHe0YJnz1GCjD5Wwu53xBPJs95F5swLGv6Zls2Yb6zuM7xX63+bk/5fLp/b3ixGbWNRmK7Nr4hJrUG+vntY7sQjmykFYlby9p3juwKJwTVL7eCOLk9fZ8R6bAqwWKPnbJ1CIDCsMw9Sghn65aEpphENkQ431/mxnewrGD7X8zgf5/RGkBO6JKomdBvInO2YGPNHiMMCndMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynZxi1RAMGUVvX6VYTyjov5eG1Deyazh8J/sHHG3bPo=;
 b=jAxffO6MFQNd3YpnijEiPhW2K0pAJ1vJo4/jwt/KhUGYk44Xj48/+RG3xB5q0PE70+i3Q/aLAWaxVn0YOd0hbm1wHXepq+9nZyD6gDNwx9aL4BUvCn5KkqjPdWlTKUA/uL0dhyPT+k+BGyCFaZrhy9IqHxNPu07Z6kmgcCELJdE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by CY8PR12MB7123.namprd12.prod.outlook.com (2603:10b6:930:60::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.27; Fri, 31 May
 2024 19:03:24 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%7]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 19:03:23 +0000
Message-ID: <f3bed7b1-0044-0962-3094-2d7ae2ac3737@amd.com>
Date: Fri, 31 May 2024 14:03:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 14/15] x86/sev: Extend the config-fs attestation
 support for an SVSM
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev,
 svsm-devel@coconut-svsm.dev, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <9a4c4a16d00834c1b7ff458e25c185ac1c9bcf79.1713974291.git.thomas.lendacky@amd.com>
 <20240531131619.GKZlnNo20bj98_ILiM@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20240531131619.GKZlnNo20bj98_ILiM@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0050.namprd05.prod.outlook.com
 (2603:10b6:803:41::27) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|CY8PR12MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: 29ea3840-22ea-4e35-3759-08dc81a45862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VU1iRzNGeU1YYnorOHE4bjUxRXpuZWhKbUZ6bEovUTQzYTBqTVJaV1l1NzY0?=
 =?utf-8?B?S0prWGNCcFd3b1psWHVha1VBZUpMazluR296YXNVRmpIOXNmSy9pOHhYbzlr?=
 =?utf-8?B?eUwvTVNndzZkc2FzT0tKZSt1RUFEU2NpZjhJb0drOTNnMERjam54YU8wWmNV?=
 =?utf-8?B?UVVjditheXBkLzBFeC8wVTBLNnFray9kNDNTTi82a3lZSjhvNnNDZm13UFY4?=
 =?utf-8?B?Z29VMDhpTDViUEc3YlRBbFYxTXpjOGN6YUNoUEpVRWRib011Mkg2TWdON1Qy?=
 =?utf-8?B?eGdqSzlnNisydWdkcU1NZVZXYmhkVDVDYWUxZk5ENE9jVmEyWStjTWdZWjcv?=
 =?utf-8?B?Ym5pWHdVaEsvVGFvTFFTTDNNRVhOZVZOT2l2NHJDSlJseTJYd3BidXZGVjhR?=
 =?utf-8?B?bGpCQjlVMkRXemVtV3dvL1gyTXVtSlV5TS8wK1p4OWpRbGhqUWY4czJTbFdy?=
 =?utf-8?B?aVBoeUdYWmo0SGE3UEt4cDlzMXQrM1RLQnZRRXdEOU9iWW9WT0Jzci9jOWVa?=
 =?utf-8?B?aE9wcFBrWWFabWhqenU1ZVcxTDBwUkxXK3lZZXlTUjVodk02UjJiUzF4eWpL?=
 =?utf-8?B?YzZQNExETENNWWFQRjNYSm9IL3RHb29aRGgwZVFJS3dhRDFiSCtaangrVkc4?=
 =?utf-8?B?MzhGYUlzMzR4cVE0aFNKRDk5NXpoVGVOeXYwbHkxdDNqTGNJakhoR1FIbnFh?=
 =?utf-8?B?WkZZeHByOTR4OE5lYk0wUjRKU0RReFI3UjJYbzlkRENFRnhSTWZrV0g2Z3V4?=
 =?utf-8?B?U3kxOGs4bEh6c3hqWlE5UmE2N3ZUTjdRZzlyNTVhM3JSR3RWclA1TlRtYlZn?=
 =?utf-8?B?UTRXRm5iQ0pSVDJRL1VCaGs1OHRFWWtXU1BRS08rZHVSWDhuRVB1dGRKWW5q?=
 =?utf-8?B?TkR5ZXAxK3h4YmRTVGs0cnptMEFidDJNYWgxNXk1UmIxWkl3OVdmM1hPZjdL?=
 =?utf-8?B?Q0VJRjI0WDRORmlheEVXblQrR002RlJXZTNWZWl5TlVMTC9jSGtValNrODNK?=
 =?utf-8?B?QkhSWXdYenk0Vk9RWmd5alFRR3RoVFJDeFA1Z3pBVWF2S3FJM28vM1RQLzdn?=
 =?utf-8?B?TTAyUzQ0RU94Q0EvdEJ4VHkyOTVnZnpKVWlpa3A4VHM4bkZ0M3czTUNPcy9u?=
 =?utf-8?B?VWlCc0daV0c0c1JaUzZId1FvR1NUMmZHclZaVFlyaXhwVFVMc2ozOXNzQnIz?=
 =?utf-8?B?ZnBjTGpiclgxWk85SHY1bTZaek14V3BQQm9lNnMyVld5S3lhRE1BSzlBN2xx?=
 =?utf-8?B?SW52NC90ci85RlRGekNndTNLTVZyZ0dGV29qejNZN2JkcFd0T09oeCtqYWNS?=
 =?utf-8?B?UGFUVXRVN2RmNkJFcFJtK1E5OE1PSkxEQkhRQ3ZrSXZpYUdnTlNVc3RIRDl0?=
 =?utf-8?B?eTJ1UXRrNHdBRFFYczVnaDhwdytDVTFHMWhrTDh6ZWx1Qlg5dzVoaWVjaEVG?=
 =?utf-8?B?TEkzSEliaHFuMDc5RFBtM2tnS1hFdGF5OTJ1VTVLWS9pbW5OQy8xLzdhbGwz?=
 =?utf-8?B?bVZ4UzlpR1NUK2JteGJwTVdZVmNvZHVEdW43TnM5VHFpSCtCSlN6cXVybW1h?=
 =?utf-8?B?dzh6clRMN1piMno2U2grZEQvbTlmbVFoSW9peVBKY3I4aXBpUjJYNStlZUJI?=
 =?utf-8?B?TEZ2N29qVHpka3hYb0d6STdNWXc0WmFYY3kyZkdrZmVEbmtydFVEZG84Qk9t?=
 =?utf-8?B?MUVGU2pHcW1VZ0hBS2R0a1Z4VGkyVlpQdEZwZ0N4ZVhQZXdSSEFMZHZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bE1xMDFQZDFFN0JvaGh5dmRKK0dPTlYyT0RhQnVuTkJ1dmRhVGIyQklsVnlJ?=
 =?utf-8?B?Z0NqWldVLzVlYmZ3M2hTZGVtZmcvSGVsTkU1TXozTDNnVkU3QkJyclhqUHJ6?=
 =?utf-8?B?UnRlUHNVWldiYUh5TDNtaG1tU0VRQ2xIVlhySkNFWDlhdGU0YkwzM1FRUEh2?=
 =?utf-8?B?R0tVK1FuNmVvOEw0WHVOWFQyTlBRbmppWlRsMXVyNGNaUU9xdGo1ZVl4K1Zh?=
 =?utf-8?B?bEFUS3hPYTBiUGMwWFNDV0E0bUZlZE1jc1dqZGlESjRuZFFvU3lURm5nQUtU?=
 =?utf-8?B?aFZjazhYTlQ3TjFoMmtSSU1MYU9jY0lDYjRUQ3c4OGlXWWhGRE5BQ0w3dzR0?=
 =?utf-8?B?WEdzNWdjaWZkY3lKYzJ0a2JyUVJENlRSbm5BME8wbFdveW8vbEE2elc0c2Nh?=
 =?utf-8?B?ckR5cFAwM3ZhVVJudkpQRDJGNWNsWDFqTVdZb29MMUExR21NeFhwN09YUkdn?=
 =?utf-8?B?YUV3eldLanIrQXo1YmVRVUJNSjRlY3UyZzJobnA1bHRaOWM0SUxvenNCeUxW?=
 =?utf-8?B?WkhweEV6NXRGbnFxdDNYdmxwakFTWGozWGRxMUFLV3h2Sk9GTUNNZVMzc3NT?=
 =?utf-8?B?ZkdwcTUvb1lEeU5QeVZlNndwTzNUcGNTOVVZcjdoRmQxUUw3MW5hVkNnWTU2?=
 =?utf-8?B?dFc0RnlsVlVJOHBWVFFscVBIZFJlWm92bUtBY05FdWMwZlc5bVU1YkNsd1Rw?=
 =?utf-8?B?VGhxelpCSTZmS0ZlNlFOZndSUXNDeUlscFptcHJzVklPdnNGTXhTQlI3cExS?=
 =?utf-8?B?ckN3WGF6aWo1cTdUSzU3MVc2aGV0cGlNL2ZuaEFMNDBZSC93YVRZR2F3Z3JU?=
 =?utf-8?B?eXBiNG1YMnJvK0QrbW9FNmFESUs4a3BWdVE0MmxsaTg5K08wMkFjb01WUlN1?=
 =?utf-8?B?T0VKMzIrL1lieC9jYWNEcmluaXNnOW0vVUJ3eTU5V29KTTJSZjZXY2RXQ3JR?=
 =?utf-8?B?V09NVEhPaU5yR3lKWm5XT0Z3NDBqNHFIUi9URjNWV2lBc0tLa1BGby9YSHQ5?=
 =?utf-8?B?cEZpQTU4NFQ2ejdNa0VjWmxPUW1GVDczc3MxRVR2VXUrcXFKYnJxc3BJTm9m?=
 =?utf-8?B?bmFFQVRpZjdHc1ZMVG5NeXhwUHd1Q3Z5YUUvWWJ3Nm15WkJwNURxeEpVRi93?=
 =?utf-8?B?NFlmMmtnMUQxSjFTVWoxWDdTN0ZrQzBWWWcvZUFjdG0wZGtvdUx6elAybnlq?=
 =?utf-8?B?aUhaOUZGZTMrci9tVytPZU1yU29ZdnQ5eWlKZTcza0NJdmJiYmxvakxqSXBK?=
 =?utf-8?B?TXRTYXR5MDlPOVAyeG9ESVptQ0xuTmptQ2NjYXM4YWhqaGMxZEdXZHViZ0pU?=
 =?utf-8?B?Z0hqMGVieVFOcE1DVjg4elJTdjllOWZ1V29QNkhRRDl3d1J2V2hRZW13MmJ0?=
 =?utf-8?B?Y2hjSVVhQitDUXFZdFpxajA3VDU4ZWpzV0xiNUp3Mi9mM3EreCtCcFBDTXQw?=
 =?utf-8?B?WWhNeXI4czBNOFkyTWdUYjlBMm5HZTYrSGZPcWR2OE1Ham9LZGplVWRKcmU4?=
 =?utf-8?B?UXFmWitXMXIxRXlnN2tlQ0VQSWZVQ2FYN1VFK1I0bSs5Y3owWmhuM0tRR1ZO?=
 =?utf-8?B?bzdsWlMvMlkxdXViZzRNcXFaVENHYlg1Y0dnWnpZRTVQUVkxM0tWSVQzVjI2?=
 =?utf-8?B?Z1ZERUxwZ29Oak02K0RKaGJmeTloUkh3RCtSV2NSYTI1alpHSDg2T3ptRzZq?=
 =?utf-8?B?UzIzYUp4dzV0VUZyNFhaTC9UZ2ZBRGMwdGRnL0R6TEs5Z3Y1eGFoUklhdGlW?=
 =?utf-8?B?NWEvUklyLzhnbTJOZXNtSjAvbE1XWENJVDgvT1dsYUdmdnRjU2VQeTRrdWZI?=
 =?utf-8?B?NHdRU0NnaHhnb09ETFA2R2FxekZTYlYxNXY1ZEFkMVZtVk5UZHJpdHpyWU5I?=
 =?utf-8?B?SnJGa1M3a3NHdVZmbldYTXJDVXlveWNFMUJUcmxxYmJrTFZwZUN5dWw5Mi9D?=
 =?utf-8?B?cXJGN0RQL0RkeWZ4a3dvSHdvMmRoQU10YzVRNjUreHRuSjQzNEtITTNHc3pi?=
 =?utf-8?B?U1RHVlZjcHJYUkpGWUNBUlRjNENFT0t4QktVR1UxOUtyRGtoRGhDcFhTR1FQ?=
 =?utf-8?B?bjBRczBmL3NpcVFlYkdVaFpXQW9QTkIrSVJ1dEdJOVZOV3pyNXFUdThrcHBT?=
 =?utf-8?Q?U0qCLE6oQJqstzvsb3QBtRzKI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ea3840-22ea-4e35-3759-08dc81a45862
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 19:03:23.8547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a34TtWAiMvj6f74XRlgsp5SJJYGg8qt0Bb7ACM/LilQODHMbUxt4gWKW8KHvuQY5h1ESR2DzN9s9FcwyfgGBPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7123

On 5/31/24 08:16, Borislav Petkov wrote:
> On Wed, Apr 24, 2024 at 10:58:10AM -0500, Tom Lendacky wrote:
>> +/*
>> + * The SVSM Attestation related structures
>> + */
>> +struct svsm_location_entry {
> 
> "svsm_loc" should be enough.

Ok

> 
>> +	u64 pa;
>> +	u32 len;
>> +	u8 rsvd[4];
>> +};
>> +
>> +struct svsm_attestation_call {
> 
> Can we shorten all "attestion" to "atst" or "attest"?

Will shorten to attest.

> 
>> +	struct svsm_location_entry report_buffer;
>> +	struct svsm_location_entry nonce;
>> +	struct svsm_location_entry manifest_buffer;
>> +	struct svsm_location_entry certificates_buffer;
> 
> report_buf;
> nonce;
> manifest_buf;
> certs_buf;
> 
> Please shorten all those.

Ok.

> 
>> +	/* For attesting a single service */
>> +	u8 service_guid[16];
>> +	u32 service_manifest_version;
> 
> manifest_ver;

Yep.

> 
>> +	u8 rsvd[4];
>> +};
>> +
>>   /*
>>    * SVSM protocol structure
> 
> ...
> 
>> +static void update_attestation_input(struct svsm_call *call, struct svsm_attestation_call *input)
>> +{
>> +	/* If (new) lengths have been returned, propograte them up */
> 
> "propagate"

Fixed.

> 
>> +	if (call->rcx_out != call->rcx)
>> +		input->manifest_buffer.len = call->rcx_out;
>> +
>> +	if (call->rdx_out != call->rdx)
>> +		input->certificates_buffer.len = call->rdx_out;
>> +
>> +	if (call->r8_out != call->r8)
>> +		input->report_buffer.len = call->r8_out;
>> +}
>> +
>> +int snp_issue_svsm_attestation_request(u64 call_id, struct svsm_attestation_call *input)
> 
> This looks like BIOS code. The only thing that's missing is the
> CamelCase. :-)
> 
> int snp_issue_svsm_attest_req(u64 call_id, struct svsm_attest_call *input_call)
> 
> Now that's more like it!

Ok.

> 
>> +{
>> +	struct svsm_attestation_call *attest_call;
> 
> 	struct svsm_attest_call *atst_call;

Ok, I'll use 'ac'

> 
>> +	struct svsm_call call = {};
>> +	unsigned long flags;
>> +	u64 attest_call_pa;
>> +	int ret;
>> +
>> +	if (!vmpl)
>> +		return -EINVAL;
>> +
> 
> ...
> 
>> +static int sev_svsm_report_new(struct tsm_report *report, void *data)
>> +{
>> +	unsigned int report_len, manifest_len, certificates_len;
>> +	void *report_blob, *manifest_blob, *certificates_blob;
> 
> Prose. Shorter pls.

Ok.

Thanks,
Tom

> 
>> +	struct svsm_attestation_call attest_call = {};
>> +	struct tsm_desc *desc = &report->desc;
>> +	unsigned int retry_count;
>> +	unsigned int size;
>> +	bool try_again;
>> +	void *buffer;
>> +	u64 call_id;
>> +	int ret;
> 
> ...
> 

