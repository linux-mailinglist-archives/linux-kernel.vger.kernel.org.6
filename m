Return-Path: <linux-kernel+bounces-560620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7296A60727
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 02:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A4A23BBD42
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 01:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF7E18EB0;
	Fri, 14 Mar 2025 01:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kdqgE2Yq"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94B3D530
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 01:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741917436; cv=fail; b=OJSQh7nbSQ3H+JzUnHJ9Ft10EBCeMM47B0PZemH1tSfU9Uh1A7lbJAKkc//YOZFO9NRk0IT0ssBrOjOwdlcKVI8lhVG5jxlZ86u4ihideuCJOjyb/dNG6Za8qf4yUTp66/g+4pxNvgpei74RiHJh1h8aJka4P3jZKMZRixNvHmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741917436; c=relaxed/simple;
	bh=sqXsNOjjpChZrQS2qPuavLACDzA5ycoj7VEaZ6+BYX8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N/xpMl3wzsn17XutJt7e0QAxlX4dwZFXPOTDgRadGR6yV3KXY90CvZOUN+S4olpSv71pF1TKZA+cPjXtBB996TkaGD7qgzCwDGa1VTaPi6R8239wcgHr8uBMo39MLWF7P/g2yR7vWn+aRKlX0rzWVIe/XNOipVOxsO99d4z6PWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kdqgE2Yq; arc=fail smtp.client-ip=40.107.243.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2I5xyY0g8ag9+85Zy6hPQkMH5tCa6LL2VkRJcyn0lE+AOX1Ou0GV5o3uHcOHczczzdnd9zSa2v29CaiBiDNRLbnvRWbJQBWiMrwjOFx65ZrgyVnhXAJt8jwvSu0SLeaVNEgsXjFCRpd+Y5y7wucsnCnBj5Vo4Upvvd5V0bZFuUYyx0e8KSnl83Ltu3Yhw3vj7r28b/cBEpoPnS9f7yiL5uW6E97Mf0d9bumebyxC3eHCfs2fYS9S61lbQmhg/F3XarwknL41+Vbf7iVpJ5UdX/vsZxOOh7AcSqiyrnS6tNZp3+91MpCL7D/TFHt0UcI4s3At1wgleW+QZk8MiD9Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fY3zY3qIkwfFSdjci+DQOSrxS5bj++W1tdGaHd9SAQk=;
 b=xQ4f4pxBhqYOmIDnV1tAAx8bRsZ+sf3ZgqM+65neN0AKe20WYIB04yshaxuqJIoik42eff2pcKCW2YRexIQ5D3LVk59KyuoxSZ9ucAPCbjsgsqHRifnGnflg6YQCY/wILKSd3N841ffkSn0jFPoe22NAdZgUqVGiSWdWtFgKCDHhdrNG0PROE3qs6C9qY/OIYl9vQgStexPEzjacqtIRg7WxO093nbOsYR6L02isjRKbWYCs85fS3KFKDjyVsD71YZkxz1V2rLPCJuvTehHSwsxQJ/DJ/AFQynn7zlS+jCVqsrdlUeQRP0eXas8q12cGnykhQCu4h8mRSY6KAIdEwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fY3zY3qIkwfFSdjci+DQOSrxS5bj++W1tdGaHd9SAQk=;
 b=kdqgE2YqBciW6NoXAc4T3P3+J+cMgrGOlxhs+qXu6MjOHZvJ2TmMA03QtUfuEOpnVw3LoOC3VLu8pQ9FWV5NQ2Wktymdoy1vq/0bM9m5TCTUnCWFT93y7xlQZPgn1kMdBjuALK4yNz3gl9Nv8c1lmxi6HLgxDSq3mGrJTtwO4sg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by PH7PR12MB6811.namprd12.prod.outlook.com (2603:10b6:510:1b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 01:57:11 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3%3]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 01:57:11 +0000
Message-ID: <56872982-8676-4d65-85ef-b894728db18b@amd.com>
Date: Fri, 14 Mar 2025 07:26:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Overhauling hot page detection and promotion
 based on PTE A bit scanning
To: "Huang, Ying" <ying.huang@linux.alibaba.com>, linux-mm@kvack.org,
 akpm@linux-foundation.org, lsf-pc@lists.linux-foundation.org,
 bharata@amd.com, gourry@gourry.net, nehagholkar@meta.com,
 abhishekd@meta.com, nphamcs@gmail.com, hannes@cmpxchg.org,
 feng.tang@intel.com, kbusch@meta.com, Hasan.Maruf@amd.com, sj@kernel.org,
 david@redhat.com, willy@infradead.org, k.shutemov@gmail.com,
 mgorman@techsingularity.net, vbabka@suse.cz, hughd@google.com,
 rientjes@google.com, shy828301@gmail.com, liam.howlett@oracle.com,
 peterz@infradead.org, mingo@redhat.com, nadav.amit@gmail.com,
 shivankg@amd.com, ziy@nvidia.com, jhubbard@nvidia.com,
 AneeshKumar.KizhakeVeetil@arm.com, linux-kernel@vger.kernel.org,
 jon.grimm@amd.com, santosh.shukla@amd.com, Michael.Day@amd.com,
 riel@surriel.com, weixugc@google.com, leesuyeon0506@gmail.com,
 honggyu.kim@sk.com, leillc@google.com, kmanaouil.dev@gmail.com,
 rppt@kernel.org, dave.hansen@intel.com, dongjoo.linux.dev@gmail.com
References: <20250123105721.424117-1-raghavendra.kt@amd.com>
 <87o6zub978.fsf@DESKTOP-5N7EMDA> <20250207190651.hpmkzl4f2zynqiun@offworld>
Content-Language: en-US
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <20250207190651.hpmkzl4f2zynqiun@offworld>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::19) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|PH7PR12MB6811:EE_
X-MS-Office365-Filtering-Correlation-Id: 74608381-f98e-46f9-172d-08dd629b88e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVM4WUZyQ3R4VUFBd2Yvc2ZFdGtGR2FyUnBVM0ZvSEo1aGM1OURsMmtjNWl1?=
 =?utf-8?B?VkNWbmQ4aVlGTkVNZWN5ejVDU2twdUI1cTRIbGdRSDNWblRiZmwyelVpQUVi?=
 =?utf-8?B?ZmJlbzFPZmlTaXRQQTE2YkRHbVVESFg3SG1mQS9wTURNOTZlMWJZWk9MZCsw?=
 =?utf-8?B?SVJneWZRRUhZWW1BQjdJTWxtbUNtNGYzU1hzTlhBdmR4K2JzRzh2eW1zdElv?=
 =?utf-8?B?SmhhNnpFYk1wUlZVK2xtYVBNRXJCbmRRaGZZdTJmOGFkR0ozUjkwd0diR2Fs?=
 =?utf-8?B?TXNIZHcvNktSak5Kb2IyN29yTnFhT2F0RklNVzYyM2ROR01OdE40Q1oxQVg0?=
 =?utf-8?B?L281UlM1VnRWWnJ6R0ZvcWtLSm4zeWlMMHVHbVVmQ3d3UlBrWmdQekRrb28y?=
 =?utf-8?B?c1E2SW9udjFCU3Q2aWVHOTZ5VW8wUWd1ZkFEcWdoa09hUDlqQWFLSHN5cWla?=
 =?utf-8?B?UC9ROVlSN01MMW92dzBtMGF2U0U2SERLOHQ2aVBpUTNnVE5USWZDbE1SclpG?=
 =?utf-8?B?NlRZcDkvOURZY2lObmxWTXlic1VGcXFVVjhUM0JRWnc1RlFqdmpFbjB2TU5I?=
 =?utf-8?B?UnpUVzk4NUl5Qy9ValpaTXp4U0NRSFRhTGUza0VISnZ0dXVNYmdSR2swK0tK?=
 =?utf-8?B?WnZjN1hUVm16Ym94dHlZWE1iZXJlTWxnREc2a1prcS9ocHJ3N2U1blRzaVI5?=
 =?utf-8?B?b0lGZURWcmwvcnBzRVFnQnZzL0NlMDJIQ3dNaWVFc3VpZ3I3ZUJ0U0FmV3Mx?=
 =?utf-8?B?ZEtPaVI4S2VyQkNEUTdiMStXQ2tyeWZGVWlvcDR4UzlBWFhpOGxVVnNaZ3hv?=
 =?utf-8?B?NGtvSWpLNTg1dTFDZUhpa3lrZllJWFFvTWJkMjlqYS93SllOWHVxZ0hPSk1D?=
 =?utf-8?B?SHF2UGN4bUNwNm5qMktzazlVaWM5aG5PQnlXaHptekpQR05xZGVJSjErWmNy?=
 =?utf-8?B?R0dBb1VZazVFYVM5ZGs2a3pnRFlub0lnbWxsa0plV3N0RUdKSVAxZ2t2RkVk?=
 =?utf-8?B?VVROSDAxQWVxR08vaU15dXlnQnpnTVA2SEZSck4wQ2tjMjNSN1ljMWU4RHAr?=
 =?utf-8?B?b21uT1Z0MVlCTUdVMFo0MlJVL3kvVTNwSlRXSjBPcUF4c2RGa0FUSVQxdTNC?=
 =?utf-8?B?RDhyZElCdVNQOGdYVjVNalI1aHpZekRGSmZXMFFseUlXaEVNTmZLNFhaU2FJ?=
 =?utf-8?B?RERTS3RkeHZFQ3R3K21kTjdYeDdLZ0xIY0tjMncwUDFPWmx4QWpTdU56YUZX?=
 =?utf-8?B?bEhUK1JVdXNlZVUwTWx6UzBVNHJsdlk5WjVLRnhxbm5oeEFxckxteDk0RXRa?=
 =?utf-8?B?Rmk2T2pmRWZka2ZZc2VkUkcwUU1xUytEVnJSbHMzSU0zUDQxMUw5WVRXb2wv?=
 =?utf-8?B?emVCYjl1SWQ4cXFZRlc4MzVtc1piVnpvSFg5LzJzODIzTDF4MXlWMkN2amRy?=
 =?utf-8?B?Y3hYNmhuNE5rYjQvMUJZUkRuTUlYVEpRUFk5SlZGWUdDUy96U3l3alkwNnlw?=
 =?utf-8?B?QzhKM05JN0hZL0s1dTl5OFRIUGRhSFQ3T2toRmJWUmluYnl1anZQUzd6b2Vr?=
 =?utf-8?B?VUVmMnVIRnN5QmJVV3FNa25ra2hzUlZoT3JFM2hjS21NMFBnZnhMdjExV2xJ?=
 =?utf-8?B?OU4yLzdLZ21MYnVhVldMZFpVNzU3cHpEM21NdG9CVzB1Zi93Q1BwLzR1ZDg2?=
 =?utf-8?B?eFhSWlFLd2FBaDd3bllWSTdJTUNLRG5ZQ0pIcnhLMm85Um85aUJ1QTV4NlBY?=
 =?utf-8?B?enFRaTRqZ1lobm1FT1QydCtqOWN4akFPZlhlZHFZemY1S0NBdXQ5bUpqd3ds?=
 =?utf-8?B?cTI5Zm5uNmNrZ1pnVktvS0hRNlk4eVVZSTlqUmdhSlRldGRldHBGVGpKZDJ5?=
 =?utf-8?Q?aYnI9PcEEJEF9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTZxaHlGTkdiQWVpNyttUGpYZHNqQkpyZDJPYnF4d0NrYzM3OXJORE4vU2Rz?=
 =?utf-8?B?ZkdjbVB0YTg4QW9aZnhFeFhDTVQ0Z2h0MElOck9hMDVKTXFIaTZ1QUlSc00w?=
 =?utf-8?B?YWxvRXJvR0ZwQUkyWGl0TmJtck4yZ3M2L1BzNTVYUHVYdE9nbm54ZlZ6M1Ez?=
 =?utf-8?B?N3dmZGMrZ0JtaFk0cTQxZXJVVG5SZ1lzRGZYaVFkQTJhTExQdXJuNG0zSjJu?=
 =?utf-8?B?ZE1QU0ZEck0xVUlWWHhIUDFhN0wvMGZDaUIzVTNXSU0xUUp2Y202N3hlcG1U?=
 =?utf-8?B?eWcxUDdCZ2hSUzlUSjJFTFFUMFByN0FJRTBaOWcrZkx1QlBSdksyeHhvWVcr?=
 =?utf-8?B?QWVlNE50YS90b1F2V3hQMUN4bnRkTGZHdk9jYS9FYjNOajh5ZjQzMklsTmd1?=
 =?utf-8?B?dG9PWU9uMGkzVXd3L2lkbzI1Vk1PYWFudnFlNTRhR1RvdjYrMGk1WFFGRjVZ?=
 =?utf-8?B?S0xwOXVVSHhhWVlyd2lqb2NsbDhKNEhNbVI0ZEo4YzhyNkhXR21SbFlNWTQr?=
 =?utf-8?B?bFFkSFFYdFBtMDBNVDJSQUxSNTJldE5BKzljSE01eDhNV3RqSldxWTU2SkZm?=
 =?utf-8?B?UFZyd1RCOVh4YUtrVFVwVDJLclI1SG54ZEpHcVIxekVCZXlNVTBPQ0dyZ0px?=
 =?utf-8?B?U0hXK0RYeUpITm9jTUZld3dEbWMwMklFVmlxWWZxYXVHVStwQ2FGRFdWMzI4?=
 =?utf-8?B?S3g3VlJnQm9kaXZ5WTZhMGpobVd5L2NGSkx1VHpwN0NWK0twbnVENWJrbkZx?=
 =?utf-8?B?a2JSK2s2Q3hhVk1DVmlDNEwwdnI2L3BnQ0xCTTdGcW9rbzc5aGtnUDMvZlFx?=
 =?utf-8?B?aTlmQnNBNTFFN2NZRy9EdGNhUUhENGwrZVpTSUd6Z2s5RlFBWFJabWl4RHg5?=
 =?utf-8?B?MHBQTWMzMWZaZ3RWek84TGJ1ZWpHZWxXb0NuRXVBT25RR0duUXQvUDhDQ2dB?=
 =?utf-8?B?YUR5OFJSZXNIR0RsMXZxcVhHcDFQTzNiY1JkdWV4c2lDZGxMNkdRWXBvYjNK?=
 =?utf-8?B?Wi9JQWRCeEcrOHA5TnVkNlFpdXdkYW9FNTNHR2hoTVdkbSthcWpURHFuS3pa?=
 =?utf-8?B?d3U0by8yL0RBK0Nha1ExZzVUVWpHbFh0SDJCdVhzUi9aRzdiWmJCS1JVMkFy?=
 =?utf-8?B?Skk5dWZNS3dibUNVMEtlRnJ2T1hkekwwZTNJOU51alZWSzRyZngvQnRTY1Ja?=
 =?utf-8?B?THppMkl6N203MVdhSjhTM2FIbWFHdlU3MXNaUnpzUjdGZmtnUUZiT0xwTkhQ?=
 =?utf-8?B?TG1mUUxhTW1JcGoxcnIvbHdodXBRa0tEQjFaRUltakw4Q2M5ZkNDNXpSNUtx?=
 =?utf-8?B?UzFFSWxqRjNHSEZ6TFdpTG80ZGxRQ2JudFA0V2lQTW1rUW1OZDZjQ01zbnFt?=
 =?utf-8?B?a3poTmdNOFZGdGNaVDhJTUt2Rk9WTThPcTY5eWF1Z3FscHFudHc3SlViQUJM?=
 =?utf-8?B?ZnlnaGF6bks4WjhhZmpNdmtQVzRDNUtwNkxQZGVPVTFCcnBEYzMzWHpCVll3?=
 =?utf-8?B?aTFzWVpYNWNZSEtmZ2JHMlJHdk03L2g4a3JIT0xSWUhsTSsrRmpoc3dldFE5?=
 =?utf-8?B?VmpRelVlK3FsNjJEaGJQNzF3TUh5aFc1YXdoblZseEozb3c2WGpSQW9PaVhU?=
 =?utf-8?B?a1lqdWlJbkRJT1AvL0w0SEFBYVhoTEJSbitBbUp0MmhZWFJ5S2xVZHNiZTlM?=
 =?utf-8?B?SXkzOHVCWGNVR0cyYmd5NGwvcGJIL211V0JGalc4MG1jbTZpRXBwQllwaWNn?=
 =?utf-8?B?QmU5cG9QS0JhZ3UyN3h3cE1jV1REdFhJaXBUbXF6aGRrU2JMZCtvSlVUeDF1?=
 =?utf-8?B?QlFib1kxb1hmcWQyaHNmZktneU4vR0IwdmdlUjlMT0JWcDN3RzhzcDBGTWNP?=
 =?utf-8?B?TDVrNXpFM1FxVGNuMUplVXJXR20vc05wZnJ0SmdJelhMRTFJOE9DSHAyVEdJ?=
 =?utf-8?B?SCt0ck1QMDIyditYR29GR21Cb25udWd4Vi83WGZGQVpoQ0o3dDNhcDNrb0k2?=
 =?utf-8?B?dDFNYzZyaGQwbmNBbXNKUG5MelRyVGN6TnNFcEREc0FIcHRvU2tET0VLNGxT?=
 =?utf-8?B?U1RaeU9sV3VWSk1IMEVKdzlDUGtKaXdsZHRRUHhKT3R1WEtsdmhaZm9SOEpi?=
 =?utf-8?Q?N5Zc761Z98xvbBpWRdvuixgGH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74608381-f98e-46f9-172d-08dd629b88e0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 01:57:11.6632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +91B/29HX2lisUfJ1pZqnIVdx2tDIQ7ZrvsXArfpAF2bSB+4AR5O7XvX9Zh8acAkt7aM7uDgcY/6z/lqQozY+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6811



On 2/8/2025 12:36 AM, Davidlohr Bueso wrote:
> On Sun, 26 Jan 2025, Huang, Ying wrote:
> 
>> Hi, Raghavendra,
>>
>> Raghavendra K T <raghavendra.kt@amd.com> writes:
>>
>>> Bharata and I would like to propose the following topic for LSFMM.
>>>
>>> Topic: Overhauling hot page detection and promotion based on PTE A 
>>> bit scanning.
>>>
>>> In the Linux kernel, hot page information can potentially be obtained 
>>> from
>>> multiple sources:
>>>
>>> a. PROT_NONE faults (NUMA balancing)
>>> b. PTE Access bit (LRU scanning)
>>> c. Hardware provided page hotness info (like AMD IBS)
>>>
>>> This information is further used to migrate (or promote) pages from 
>>> slow memory
>>> tier to top tier to increase performance.
>>>
>>> In the current hot page promotion mechanism, all the activities 
>>> including the
>>> process address space scanning, NUMA hint fault handling and page 
>>> migration are
>>> performed in the process context. i.e., scanning overhead is borne by 
>>> the
>>> applications.
>>>
>>> I had recently posted a patch [1] to improve this in the context of 
>>> slow-tier
>>> page promotion. Here, Scanning is done by a global kernel thread 
>>> which routinely
>>> scans all the processes' address spaces and checks for accesses by 
>>> reading the
>>> PTE A bit. The hot pages thus identified are maintained in list and 
>>> subsequently
>>> are promoted to a default top-tier node. Thus, the approach pushes 
>>> overhead of
>>> scanning, NUMA hint faults and migrations off from process context.
> 
> It seems that overall having a global view of hot memory is where folks 
> are leaning
> towards. In the past we have discussed an external thread to harvest 
> information
> from different sources and do the corresponding migration. I think your 
> work is a
> step in this direction (and shows promising numbers), but I'm not sure 
> if it should
> be doing the scanning part, as opposed to just receive the information 
> and migrate
> (according to some policy based on a wider system view of what is hot; 
> ie: what CHMU
> says is hot might not be so hot to the rest of the system, or as is 
> pointed out
> below, workload based, as priorities).
> 
>>
>> This has been discussed before too.  For example, in the following thread
>>
>> https://lore.kernel.org/ 
>> all/20200417100633.GU20730@hirez.programming.kicks-ass.net/T/
>>
>> The drawbacks of asynchronous scanning including
>>
>> - The CPU cycles used are not charged properly
>>
>> - There may be no idle CPU cycles to use
>>
>> - The scanning CPU may be not near the workload CPUs enough
> 
> One approach we experimented with was doing only the page migration 
> asynchronously,
> leaving the scanning to the task context, which also knows the dest numa 
> node.
> Results showed that page fault latencies were reduced without affecting 
> benchmark
> performance. Of course busy systems are an issue, as the window between 
> servicing
> the fault and actually making it available to the user in fast memory is 
> enlarged.
> 
>> It's better to involve Mel and Peter in the discussion for this.
>>
>>> The topic was presented in the MM alignment session hosted by David 
>>> Rientjes [2].
>>> The topic also finds a mention in S J Park's LSFMM proposal [3].
>>>
>>> Here is the list of potential discussion points:
>>> 1. Other improvements and enhancements to PTE A bit scanning 
>>> approach. Use of
>>> multiple kernel threads, throttling improvements, promotion policies, 
>>> per-process
>>> opt-in via prctl, virtual vs physical address based scanning, tuning 
>>> hot page
>>> detection algorithm etc.
>>
>> One drawback of physical address based scanning is that it's hard to
>> apply some workload specific policy.  For example, if a low priority
>> workload has many relatively hot pages, while a high priority workload
>> has many relative warm (not so hot) pages.  We need to promote the warm
>> pages in the high priority workload, while physcial address based
>> scanning may report the hot pages in the low priority workload.  Right?
>>
>>> 2. Possibility of maintaining single source of truth for page hotness 
>>> that would
>>> maintain hot page information from multiple sources and let other 
>>> sub-systems
>>> use that info.
>>>
>>> 3. Discuss how hardware provided hotness info (like AMD IBS) can 
>>> further aid
>>> promotion. Bharata had posted an RFC [4] on this a while back.
>>>
>>> 4. Overlap with DAMON and potential reuse.
>>>
>>> Links:
>>>
>>> [1] https://lore.kernel.org/all/20241201153818.2633616-1- 
>>> raghavendra.kt@amd.com/
>>> [2] https://lore.kernel.org/linux- 
>>> mm/20241226012833.rmmbkws4wdhzdht6@ed.ac.uk/T/
>>> [3] https://lore.kernel.org/lkml/Z4XUoWlU-UgRik18@gourry-fedora- 
>>> PF4VCD3F/T/
>>> [4] https://lore.kernel.org/lkml/20230208073533.715-2-bharata@amd.com/


Hello All,
Sorry to comeback late on this. But after "Unifying source of page
temperature discussion",
I was trying to get one step closer towards that. (along with Bharata).
(also sometime spent on failed muti-threaded scanning that perhaps needs
more time if it is needed).

I am posting a single patch which is still in "raw" state (as reply to
this email). I will cleanup, split the patch and post early next week.

Sending this so to have a gist of what is coming atleast before LSFMM.

So here are the list of implemented feedback that we can build further
(depending on the consensus).

1. Scanning and migration is separated. A separate migration thread is
created.

Potential improvements that can be done here:
  - Have one instance of migration thread per node.
  - API to accept hot pages for promotion from different sources
	(for e.g., IBS / LRU as Bharata already mentioned)
  - Controlling throttling similar to what Huang has done in NUMAB=2 case
  - Take both PFN and folio as argument for migration
  - Make use of batch migration enhancements
  - usage of per mm migration list to have a easy lookup and control
(using  mmslot, This also helps build upon identifying actual hot pages 
(2 subsequent access) than single access.)

2. Implemented David's (Rientjes) suggestion of having a prctl approach.
Currently prctl values can range from 0..10.
	0 is for disabling
	>1 for enabling. But in the future idea is to use this as controlling 
scan rate further.

3. Steves' comment on tracing incorporated

4. Davidlohr's reported issue on the path series is fixed

5. Very importantly,
I do have a basic algorithm that detects "target node for migration"
which was the main pain point for PTE A bit scanning.

Algorithm:
As part of our scanning we are doing, scan of top tier pages also.
During the scan, How many pages
    - scanned/accessed that belongs to particular toptier/slowtier node
is also recorded.
Currently my algorithm chooses the toptier node that had the maximum
pages scanned.

But we can really build complex algorithm using scanned/accessed recently.
(for e.g. decay last scanned/accessed info, if current topteir node
becomes nearly becomes full find next preferred node, thus using
nodemask/or preferred list instead of single node etc).

Potential improvements on scanning part can be use of complex data 
structures to maintain area of hotpages similar to what DAMON is doing
or reuse some infrastructure from DAMON.

Thanks and Regards
- Raghu



