Return-Path: <linux-kernel+bounces-254971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9FA9339EB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC811B213F9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5223BBF7;
	Wed, 17 Jul 2024 09:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NyggOTtA"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F651BF37;
	Wed, 17 Jul 2024 09:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721208762; cv=fail; b=c1UB8E16uqpgxw3DiRgl8IWG9dMESJksrj2VoxLr57uRnkHgOnjSTjwSoh9jk2phfMXY/EZAbLNih5LurEp0Wbw1LA3nq3RBTStUkmJitTRvsa0adN7fCbcEXu2eCej6uNm26fUW44GNm0AKbPZoh7ZPJXTxtu8Jk7ywDEBTZJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721208762; c=relaxed/simple;
	bh=8vtJWYvtmvMjc38ZIK6pgSe7a63bNQeRXMD7PUk8/DA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gBRTVfzat/DWu+Tk2a2tlk8GCvcfKKSWJDA0pmKaO7xenslR54gMIT5OkSInWELfWy+oRwtXDp/PHG1jv5AXbPKYRryZf3Hnj2bZsmvqMYx9s0zdRFzyyZVNUhHisOq6xmh+j25HOsSGporRwdQ22i99n4YkcDOFFzktgxoWIg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NyggOTtA; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SfGVjSKv5DQ6QW2mf+oHtrNP1yHFdvWyqrWTmnoLHlmb5Ss6/buPvn+XHJtGgSY4OfqFeP5+qkYmhme+3LBhcyHtfSwvJOJyR7ebRklZvCagWi11R0EZLKdV3cSBdlKrbtn1KSgQX7DUz5vvC46x+Zp5QqaLsZ0sUDK6qDbbyNmLivHvpTKlr+8HjY4jiMHu8EY7xtxDmCSxhIjY0kV1nMZQZ5RCcW3oVmiyhN7TqFzMhjHktuEylG6IxOiGE68gaNS7yruWmrNkVoahMD/ZTMmu3d0ybsN6+GwCdjk2IbGHVzhHJEZxwBEtREITyJd4wxXUI9ZRuTkbnOGN/paAEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mE/nT1qC8giHDzlJg7T1kgyAT4CsiUB6ztWFMo5rRKk=;
 b=EHqYY6oPN5WC8aSmilWRrFEBkYQPfRX6V+ft+K9PINGBcw7BbosgV45rIGPOZjV8nSE96s8jBWMNhLvRYWRJjm3kBO8OWcJfuzIvGnB9FqKuSbWTe8YKmzj4CjCujHhPiindlZ71Doyv9mF/eCOq4BH4cr7M7Z/fRrXBna9ilKSz6ukZzfhmOJVWnZzFNfjnGwi8iWkxeBAWYnD0Jyr4/Mo+Qrrv9z0uGHDXg3S2moMs5PYi3DbawgHMf6uFaORHa5hJBJSYsF1wOj8uskO4icLlpXZTlRhY64wnszeMTfEStXOb5hnkhEOy/U0Xan/RKpMP/9TxjJdqdmLumhh8IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mE/nT1qC8giHDzlJg7T1kgyAT4CsiUB6ztWFMo5rRKk=;
 b=NyggOTtARjSCvbcdcUJSKWf9BhIWZobe/5I9lNN/1SDHiIhRTph77Xbg7eACqQOtT+4MT6AEpsHRtRuNpceKHCd+fLGGMUW0APiJSg/cAIUVcYg1H1FqtRDvLGYbxJa1hTYrx2Vhl6BI6Pv7DaALCpIQQ8BhUSrCshYGXgpw5RA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ1PR12MB6124.namprd12.prod.outlook.com (2603:10b6:a03:459::15)
 by DM4PR12MB6469.namprd12.prod.outlook.com (2603:10b6:8:b6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.29; Wed, 17 Jul 2024 09:32:38 +0000
Received: from SJ1PR12MB6124.namprd12.prod.outlook.com
 ([fe80::c15b:b99d:8d9e:fb25]) by SJ1PR12MB6124.namprd12.prod.outlook.com
 ([fe80::c15b:b99d:8d9e:fb25%3]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 09:32:38 +0000
Message-ID: <a4943b94-3407-42a0-9273-f7948ae8c35b@amd.com>
Date: Wed, 17 Jul 2024 15:02:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] x86/elf: Add a new .note section containing
 xfeatures buffer layout info to x86 core files
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>,
 "Balasubrmanian, Vignesh" <Vignesh.Balasubrmanian@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>
Cc: "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "npiggin@gmail.com" <npiggin@gmail.com>,
 "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
 "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
 "naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
 "ebiederm@xmission.com" <ebiederm@xmission.com>,
 "keescook@chromium.org" <keescook@chromium.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "Petkov, Borislav" <Borislav.Petkov@amd.com>,
 "George, Jini Susan" <JiniSusan.George@amd.com>, "matz@suse.de"
 <matz@suse.de>, "binutils@sourceware.org" <binutils@sourceware.org>,
 "jhb@FreeBSD.org" <jhb@FreeBSD.org>,
 "felix.willgerodt@intel.com" <felix.willgerodt@intel.com>,
 Borislav Petkov <bp@alien8.de>
References: <20240712094630.29757-1-vigbalas@amd.com>
 <20240712094630.29757-2-vigbalas@amd.com> <87plrhshdl.ffs@tglx>
From: "Balasubrmanian, Vignesh" <vigbalas@amd.com>
In-Reply-To: <87plrhshdl.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0003.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::17) To SJ1PR12MB6124.namprd12.prod.outlook.com
 (2603:10b6:a03:459::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6124:EE_|DM4PR12MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: a77d7bbd-d82c-4e37-ba66-08dca643658d
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UG1JRWNlbUN1aVdoUS9JOTIzeUVwYzMxZ1ZEaG9IQmxMZFMzODYreDM2TnRW?=
 =?utf-8?B?Zy9RbTVzTGFUanY3QzdYTXlveERadWJjMXVZcndicy8wTXpsUXhUUFJjRVVk?=
 =?utf-8?B?Szc3N0puZ2t5YzJ2RCszUGkwL1ZGSHZkS0xWZHNWcWVmcUJwR1ZyNGo5emVw?=
 =?utf-8?B?NE0ycDViOVVOU2I5UXJQSjZwckdvRUc3WkcyTWlDU2s5RE9ZdmV2eDNqLzNF?=
 =?utf-8?B?V0hiQlhYeklCU2FudjlOWW5PMGxCRE96ZXJta0xsVDIxb2pPd29YaGZXME1K?=
 =?utf-8?B?dWNMYWFxc3I3Qi9jOUNuMGNjcUJsWVZXdlFwRXpBUmVBUmZrb292YjhWTnM4?=
 =?utf-8?B?YVVhZmY3N0dKTTFicmpzUi83NDVQM2lhODhYOTE0eUpLN2ZiTkU0U0sxUldh?=
 =?utf-8?B?aEZpV01MSlk4b1hVeldqamVnMXVxS3R5NWlBOVJMNFI1T0lqd0Q1WXNQSkV6?=
 =?utf-8?B?c25LZUVOQmJzUGpObWRCb2tPNHZzQ25DWU05MVFJOUh0M1BmWHZWWXp2SU95?=
 =?utf-8?B?U2dzRUZPQkxha3ByZ01HcmRYS2ZZWFBtWGJXUnpTQUlpb0xGVGFMa0FxTkRp?=
 =?utf-8?B?dFZXWmRGN0UvaFNBY0dhb1I3UEtINzByY0RyL3hWeUI5SzVsTHFCRDRCeXJW?=
 =?utf-8?B?R0l3bFoycjNvVFh1bkN0eXFrMmVCQWNMaVpyYW1kOU9YbnhDNDR2ZHFRSDds?=
 =?utf-8?B?QklqMDZJWFI0bk8yTkhXV1czeG5ZUDZ2RWJ2TmQ2QzlKcXJnWXRmcFJLWm4r?=
 =?utf-8?B?NkhJS0kva1BDdkl6cHRWRUNJZC93dXEyTy9DQUEyM1ZMZ0RSbkxYY0VqMDI0?=
 =?utf-8?B?STAwbjA3NXJHdDlJUmZSM3lOWGdsN1RjM2c5Ui9BV2NZQWliQ202QVA3bVJK?=
 =?utf-8?B?Y2xxVkVWUkVkQUNFWmlRck5OZ204V2IxYVkrMHM1Z1RVVk5La2ZMQndRZkRL?=
 =?utf-8?B?UCs2bElzUEVLU21DYnlqM3QxS01xMGU1dXNaTHBhYTJLN2RlblFKMmhVbDVV?=
 =?utf-8?B?Y1NISWR1MEg5WVdMZDBhVnFpL1FDMGRTQ1FRN2ZyWEZqS3BKcHdZWDlMRVFP?=
 =?utf-8?B?YW5rUkF2bnJ6Q1pwWHg2ZFR0a1lNZ0RmWndrbTh1eFQwMHdiN082TFczbHF2?=
 =?utf-8?B?dzlOSlByTHNBYm9QSUZ2bGJUTHJyelM4c3hUbnpINnYzVm5Md3QxRWFxY09Q?=
 =?utf-8?B?aFMyUFlHcUxhZE1nWW0zUnVSc0hQdnFINTNDUSsxMVNqZldkeWlxd29aZVFZ?=
 =?utf-8?B?QlJXUnAzaU5GL1puTWRDaS9mcXdBSVhld25EYXdtS3AxQXlxQVR4dkM0cXdM?=
 =?utf-8?B?Wm9ObFlKRllhTVFST1U4MklVbHh0TWNMdS9RVFcrcGg2VS9qR21tcTNDU0pB?=
 =?utf-8?B?ZW9rVFREdzc1NjREYXArNlQ5ckVyOThWb2ZlQ2dJanl3S3UvUFZPamcxRDI0?=
 =?utf-8?B?aGlxeGlRQkJlVUZmT0hadVBUVHJpN1luSDVPd1N2Wmd1NUpJOHZFdGpONlR3?=
 =?utf-8?B?cFBpM0xraG84ckV5a0R4OWpYTVIydXMyL1V3OHNYU0g2V1hpdEpDQVVJUWNI?=
 =?utf-8?B?d0hCT05HUHRhbEpGeEo0dVFzTUlhbnUrSWNGY0M3VDArWXBkK0hyRkZUeEgz?=
 =?utf-8?B?MjdwcDdwcThWU0h0aDRjOTZFRXFGR0t1Ny81djJxYTc4V0NVN1U4NXNlQmhF?=
 =?utf-8?B?bDBqaUVKaWdUblBxb1I0d1RFcU9OblViUTd6b0wxbG0wcnNmSkNocjVGV1hN?=
 =?utf-8?B?MzJocTJjQzFybGplbVh4dmtnQyswYmdNSTcwbXIwRk1zQ2JqZSt3T1RwZTNK?=
 =?utf-8?B?SHFQYVhOQXJuczNuZWJVZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6124.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDVZT0YxSlJ1Zjd0ODdyOXY3cjluZnEwck5IQUg5YzMyWG5Vc0dGcFRZa1dG?=
 =?utf-8?B?ck9YUWhuKys3ZUV2UlBlN1hvVjdaWGZKMzk0Q09MYlFBS1FObGREMloxT1BJ?=
 =?utf-8?B?SkhFK0N0alNDb3J5SUpNR0RYK2ZUZzRVcXB3b2tsajNkbE42c3ZEd0NhZ3VN?=
 =?utf-8?B?VENUdnJWMVZzTDYySm5iVm9EVFR0RDRLYVNlZGF5UGlWQVgxNmllMkVZcWtt?=
 =?utf-8?B?dWVBanFkc1ZRTmRmRjV1d1k5MEFjVGw2WWhoekJHRGRNSHE3UXBwZHNpU2tG?=
 =?utf-8?B?UEpMTUU2NmlOUUhHbDVWQkZnbXIrczRUK2NhSVZlNWliK1hUOTZwQVhPQ2pT?=
 =?utf-8?B?U1FwZ2lVanduWmlNTVJHdHdwOVVkVEwrc3FXQXFTd2tCWGFpaFUraGIrK0dK?=
 =?utf-8?B?RGQ3MXNObUt2djJGTlFJZmpoS2hpYm5BbjhuUzBNek0wREVoZjM3QklDd2pF?=
 =?utf-8?B?TnVCSXovU1hsS3c5bDAwMmtaT0xXNGJ6QjJ6NkFjZkZvbCtYTDUyaEJaNU1I?=
 =?utf-8?B?VEVQYS9mdkFIQVd4ZEo0Y1VFMnpiU1puQnN2eHNxRmZqYUsvaTMxSFo0MDhn?=
 =?utf-8?B?VzJlTXFybnVJSFZBNUtTc1F4WjNCVUhYc2szYXdINmgrVzFlTXJaWUJlbGJI?=
 =?utf-8?B?aGpuYU9KeVRqd0M3eEV6akhQZWlZNWlQNG9LTVUrd1UyYzhYMDNBWWdDMnYr?=
 =?utf-8?B?Z1VxejhtY2s3L2Q2endSWGY0YWdBOEg3a2lhMlVCUk5ocEdWMUlWaCt1UlRl?=
 =?utf-8?B?Y0UvTzZpMkpzVXA0MnMzM2VNT24xUXJqMC9RNXNXbW10UzFZcXpJY1hjMlJi?=
 =?utf-8?B?dWtyNHpWenU2SlhudUpFMGc0dnU2REhQczcxZ0VZa0ErRFlHU2l1Wk5NWFNI?=
 =?utf-8?B?K3RlVERLOFJaako2NnBqcHM1dDFQZTNXMVVGdnExMWdwcmROeHk1MzdBUXRY?=
 =?utf-8?B?c0N0d1duUkdtOFQ3QjlUSjRTSURheHBrTUg0cjluTkR0Y3hDZW5KVmRTbXBy?=
 =?utf-8?B?K0J0dXltaWRiblNkaVRNZEtwQWdDMWVaUlFGWTZIZmpqblVzS0YxZ1JOOWJU?=
 =?utf-8?B?M2xpWkxESlhBMm8velhoRjNGM0NEVXVmS0UvM1dCMnljd0ZvUTYwbDI4QUtv?=
 =?utf-8?B?Q2VvbU11ZjZBQ3l5TENuREc4WEw3NGZvM1dxK2xXdDZJZFdnSVErWTZVTnFy?=
 =?utf-8?B?TjJPZjF4K1I0TFZRUU5UT0lKR0R6M2FmVjFlSG94cWt5N3hZRmFHeWZxalIy?=
 =?utf-8?B?djdVRzloR1lTM3VBU0ZRVTgrQ3hVVTNnbmZDTUtqanlPdFRnMkRjRVMvVFVp?=
 =?utf-8?B?OVJxVXRMeWZ5Rzh2K1MySGlJbGFISFM5Qm01TjYvczExZUU3bDJ0dWVZb05y?=
 =?utf-8?B?NXR3QjVkNS94dkNNL2VQelhrbk95T2lMRjRTUzZ2aFdOTmltZFhKaHZZNnk1?=
 =?utf-8?B?WGkrUStIZkp3UHN5Y2ZucHlaaWw5Z3RxYkxwYjI2WDZqbFdnbGFkNWNNYSty?=
 =?utf-8?B?OE1UMU1yL253dGJpWE56NzlrSTJ6MDk2R1ptWFdPdzR2SFpGck9uN1dVc1M1?=
 =?utf-8?B?TmtXMnZ2S1M5SU5xWmU3Wk14bEM0c0RKVjlROFU0K3EvT3V4eWRNb2FPMFgz?=
 =?utf-8?B?bzcxSUxlc1Z6STBlYTN1MFVBZXlUR0FtRDlkWUJTN3hsTlpPek9aMlh6b0xY?=
 =?utf-8?B?aXVycmd0QTRVRlJuaVpKRGtoQktmZ3pNb2ZrdUtoaWxrMjN2UDhiNXppSmdY?=
 =?utf-8?B?ZVVabHJqS0dDdUFvY1MrRTZVbVZmTWtjbWZDOG1RT2F2VVBVc2ptKzBpa1I3?=
 =?utf-8?B?TUFIeFZ4SW5uREU1dUNIWTZDTzVqbWxlL0RoSXlMY0lzY2RWSDZOTU1JT25W?=
 =?utf-8?B?bU43R3EwUUdFSi9pSzBWTUQ3VUZtYk9zVzhYRkJPNEI3RkdKYThqZWhvazUz?=
 =?utf-8?B?UEVLWG1ieENHMS9FQzFISnVrZmx6dlVIMmdMRlBYY2VaT2p3STFIbmRsU2pX?=
 =?utf-8?B?L01YZDVTQVZnNGJVSTltVitTeXR0Zm9tV2o5WEpKWldGVHd4SzY4dVRMdk1y?=
 =?utf-8?B?Z0cveHpyYndNaEovSTRLeUkwZWtzelFTNFhqSTdlT0pmTjJmRVNkSldIblVS?=
 =?utf-8?Q?isiC3AUF7rx33uVKJwL5prBPE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a77d7bbd-d82c-4e37-ba66-08dca643658d
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 09:32:37.9594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y3wgcmOWVZoa67w9cp6pL6ZvAU7B/XufGK21cQ6XhdWp6oSfuAgtuKJE0vpYBsKA4I9EKgoHjCrGSv6yqzp7xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6469


On 7/13/2024 4:12 PM, Thomas Gleixner wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> On Fri, Jul 12 2024 at 15:16, Vignesh Balasubramanian wrote:
>> diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
>> index 1fb83d477..cad37090b 100644
>> --- a/arch/x86/include/asm/elf.h
>> +++ b/arch/x86/include/asm/elf.h
>> @@ -13,6 +13,15 @@
>>   #include <asm/auxvec.h>
>>   #include <asm/fsgsbase.h>
>>
>> +struct xfeat_component {
>> +     u32 type;
>> +     u32 size;
>> +     u32 offset;
>> +     u32 flags;
>> +} __packed;
>> +
>> +_Static_assert(sizeof(struct xfeat_component)%4 == 0, "xfeat_component is not aligned");
> This struct is only used in xstate.c and asm/elf.h is not a UAPI
> header. So what's the point of declaring it in the header instead of
> xtsate.c?
>
> If this needs to provided for user space consumption, then it want's to
> be in a UAPI header, no?
Our initial idea is to pass the "struct xfeat_component" through "glibc".
is "include/uapi/linux/elf.h" proper header to add this ?

I couldn't see any proper header inside "arch/x86/include/uapi/asm/".

Please advise.


thanks,
vigneshbalu
> Thanks,
>
>          tglx

