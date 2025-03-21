Return-Path: <linux-kernel+bounces-570795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD4CA6B493
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05B6189B853
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CB81EA7D7;
	Fri, 21 Mar 2025 06:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="STJxMBm0"
Received: from outbound.mail.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5788E12E7F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742539710; cv=fail; b=WgmPzZ9vgN54I3C7OSWIsv4zFVa5/gJG0yA1rpbOaP816sm8eAoczYVl3MACOMyuxotKh3sIMzO7MK14A1UH63Qbs9HgHvkn16gUJdThqSTu8YbkHDSL4BIJQFFru8Wmrf0DoJMelkFuAUjU4NaXwWxsFbgIYV+8G+IkqTjN7XE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742539710; c=relaxed/simple;
	bh=abThU/G41j2EoQZF+7PGxedyjJpgFJP5rYtatVXXynQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Meoqw07u4YtX9ahvnP61nmts+cSmO6kQsPcszJrh+Kw0KIaMSSV9V8LXsZIgjwFucQrgZYkTUpcqiTK/WFs9q9i6j7FPEdjwCYsAJ8gGd78U1nPcL7mpY/FGgsJFUR37IoG2vFh/LqDFROjmPRqcGNx3oQJM8PZfo4byCQsM4YU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=STJxMBm0; arc=fail smtp.client-ip=40.107.94.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFS8fw9Rn8YOD/hhHNSpupsDW9s0lJ1eOjN1nwuT0mGrkwU/638v77s0AH4Iy5eN3ZADnKOU5j//n0TnS0We7XKudu6quUxT7yurImhtGaVf3MTQakbQEN6x5nOf5heC8qdwjZrP6r8BkPsRSk2/chJzJZlm2pM99TbHQ1lieDaaHmwaa/P0hfJwS9aiVkeh+5m2e5JP0bbaXDDyrjHRMyHW6skoKtzcgRJiEBCjwZYhjhUx4l2H0WAlsNWzDq+mqGTtD+hd4jIEzcRNhyOqYcZBue2X3JuNxeNfduNzXgLrq/JIStna2oq6asPSzNXszZjiE2G38wx5EJLHqU844w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYZq97aPgevCA/nIbvm4hpRAgyK1H9uGySdH50Oy9Pc=;
 b=zN8ss24UMbdAq/BDs1TUPuXT811Yj13fO4pUixqV4RjvBQ1B9CEMC6FTG6ninsLEP/BSSTo5xkiuXa5D80GzdrvrsF7STHuTtPO/A1ymjpRbWpi7k0Ebh5sOJZDCm5R+0eM6LyW7F7u3urfNOZZg/R3OPjbhej1DIvOc9PqQ5jDMF6YGESyvaFLi+OsZqc1jVGmuzoKqQO296vMeVfOIoKwlWaXJSR5NkNFFyOe9T+BtGfbUqfLH5ab4NTShuuzHBl0ojAoL4UONLDNyS/Galj5LYthMW1QKxa+7GT1+ZJ6cW1I13CQvLTWOQq+77QRSjyW+l0zZ712zAyqI9px5Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYZq97aPgevCA/nIbvm4hpRAgyK1H9uGySdH50Oy9Pc=;
 b=STJxMBm0K/EMdf70cHbhlmKm/pL+JNfuUI6NmX3HeOt7JxcFGQrYAcyMvE/d+xI6SCBMT7fLuTGHVX8a6XC/1u/HfZQQ8AKJdUzGRM4E1PXF846FJes32unih0EyQYGVzvcQKEGw8inYAvmrNFDtZe4Ij8JC996X1SlVEshi1Mk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by DM4PR12MB8474.namprd12.prod.outlook.com (2603:10b6:8:181::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 06:48:25 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3%3]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 06:48:24 +0000
Message-ID: <a157a899-81b5-4098-8405-89ab899cdc68@amd.com>
Date: Fri, 21 Mar 2025 12:18:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V1 00/13] mm: slowtier page promotion based on PTE A
 bit
To: AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com,
 Michael.Day@amd.com, akpm@linux-foundation.org, bharata@amd.com,
 dave.hansen@intel.com, david@redhat.com, dongjoo.linux.dev@gmail.com,
 feng.tang@intel.com, gourry@gourry.net, hannes@cmpxchg.org,
 honggyu.kim@sk.com, hughd@google.com, jhubbard@nvidia.com,
 jon.grimm@amd.com, k.shutemov@gmail.com, kbusch@meta.com,
 kmanaouil.dev@gmail.com, leesuyeon0506@gmail.com, leillc@google.com,
 liam.howlett@oracle.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mgorman@techsingularity.net, mingo@redhat.com, nadav.amit@gmail.com,
 nphamcs@gmail.com, peterz@infradead.org, riel@surriel.com,
 rientjes@google.com, rppt@kernel.org, santosh.shukla@amd.com,
 shivankg@amd.com, shy828301@gmail.com, sj@kernel.org, vbabka@suse.cz,
 weixugc@google.com, willy@infradead.org, ying.huang@linux.alibaba.com,
 ziy@nvidia.com, Jonathan.Cameron@huawei.com, alok.rathore@samsung.com,
 yuzhao@google.com
References: <20250319193028.29514-1-raghavendra.kt@amd.com>
 <20250319230015.bewglxf3hrf2mx3f@offworld>
 <52b2c1dd-2f4a-42fa-8a40-bd3664e7c56a@amd.com>
 <20250320215056.miwm2vdphdksrfjx@offworld>
Content-Language: en-US
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <20250320215056.miwm2vdphdksrfjx@offworld>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::10) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|DM4PR12MB8474:EE_
X-MS-Office365-Filtering-Correlation-Id: fe3f05ba-2b67-4c3d-8d2e-08dd6844608e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cE52R0FhRVV1Mzl4UWZoZXRyNXdRMVhpTXBseXdJVUVzWjNFRXRFWTdOZk9p?=
 =?utf-8?B?UXZETEh0aTdaZmJuaFI5bFdVSWJtZG5FeVNxY2RqTDRyTUtzZm5HMnNNTkVs?=
 =?utf-8?B?dkRYU2ZFZUg1dFRwSkxnWU4xT3dCK25teHRzdFlSQkZCZ0p3U1gxNWFzYWFI?=
 =?utf-8?B?NjdzV1pYdmpJY09HWXJaWVRkR2tXVlNVb0ZJbHBIWS9jei8rTGhGQmU1MUdE?=
 =?utf-8?B?YTBrVHlEWkZNZkdhY0JyUUtqUkZReEpQTkRrZ1lLeUdYSTZiNldxN3BndW5V?=
 =?utf-8?B?S05JZFVENU5iNGVyWU9YTSszQjA3TGpHK0ZTNi9kVE9nTExwaklJakc4UW03?=
 =?utf-8?B?VEFsUTJ0QXBnOThzR3dRcUF5WkJuRHNVTmlZeVY5cjhhb0JWMmdaczlPdHNG?=
 =?utf-8?B?dWNJVVJYcXgyL01DM3d2UFBiRTJXVUMvMEtnWjN0dHNVT0ZsQ3l4SHlhSTdw?=
 =?utf-8?B?T1luNkpSZUlkTG9DRXoxZE1CQTNXdDlQeUhJeTBTRUlWNlYzSmpMMFBuNGQ4?=
 =?utf-8?B?WkhRYUNEQlduQkNxZndkUUlTcnVPelo4OUo2S25tNjJsMzZhcksycHM0ejVz?=
 =?utf-8?B?Q1R3eG5BMTJPVXVDeW1OUnJYR1pUR05PVkpkTGF2L1EvM1h0VlNCSzd2am93?=
 =?utf-8?B?amY2bW9ZYk0yRTFkZE4vZ1EvWnhmcTZjalJXK0VudVd0MC91d3hXTmZUZTcy?=
 =?utf-8?B?UHBBOVh0MTIyZVN3QmJaQjgrUlNzSFhtTjhVMUZjSjk1dGZKR05hMU5oTUpO?=
 =?utf-8?B?Q1lyTmd0azFmcnBOUWZFQWVXdEFILzcyRDYwaTV0VGg1dStVK2JScXlNdEpN?=
 =?utf-8?B?a2tlQkFlSjlObko2Qmhnbno0My9FQkdPUHNPVW5pa0NNWitTOERYanlSbGN0?=
 =?utf-8?B?Z0h3UDNOUllkdW5VRTE0dXV0TlpheXltMXVWMy9MSTAzTHkwN05lem1HVEUv?=
 =?utf-8?B?Z2FFT3YrNHBubk9Za2dZcmFERUVyaC9XNWQ3SmIweGdTTExHQ0FpSmtmbGJV?=
 =?utf-8?B?aU5zQ1ljOHpvc3gxSlBPUWp3TFBKT3RoWnRDMGdvOEZMZXFLWllxSVNPS1Uy?=
 =?utf-8?B?cEd6REV2Nk1iU3lXNlUrSlBGRXIzYjYzSUVNVTJEcmMrNWhYQkZjL3B5U0Rq?=
 =?utf-8?B?NmwzQ3V6dFJEN0RTMk1QMlFKZlE0YWJWNUpGb2JNa3FOL1VONDBlMnVrdnYw?=
 =?utf-8?B?S3pTQW9QSkxuWGU1U04zUjFFb1htQWFjK1pCblR4N2R3Ylk5eHVnd216Ujhw?=
 =?utf-8?B?bGVEMWxraVd5SnZFR1hDdjVyd2xSU0lXRHZxdExUaHhEUW4wYzZIMWthQ2R6?=
 =?utf-8?B?Z3lYUlB5dGQyaWs0dnU3dHk4SS9LbHNQQ3g3MTVpd0xRMm05QXg4SjV4Z3hS?=
 =?utf-8?B?YTl0L2prSHhKVWJRMTk2S3U1YTNTWjZiMk9iVTVtajBGNVkzN0lVYVVyVk5y?=
 =?utf-8?B?b3p2YXhXOE5OSGNCSlJRWHFmYXZVQWRTKzFmVkRtMDI2cUU3TkloVHcrSWlP?=
 =?utf-8?B?UXBwamJ2VFkwUHpTenBlcUFvL21xSkYwNWVsc2UrNCsyaGlSMDdBUE91UnVq?=
 =?utf-8?B?OTFJSzJjZ1RBQitXK0FFMG93MVlWWHpEMVZHOGhUQjc3cmc3ZTdxL3E3VHpn?=
 =?utf-8?B?cS9Dbm52QjZUWVpsalVxOU1lR05VbklaMkhWV3hxZ282akxOQjZMb2gxTEp0?=
 =?utf-8?B?VURnVExVZlhyRlhpYjdaTGdNNDBpOERyV2pQRHNncStldDRMaXAxTFBnUlZP?=
 =?utf-8?B?OC8wVzFrTmZHNEl1RGIvOHhqSUJMd1JXcmZEbEhvRjBqSGNsMUxCdWxxN2pu?=
 =?utf-8?B?alNYRFN2VzI3bHFJZUNYM0pUVlpVc1Zmb00wd2o2TldoRmEyc3o4TjF2SUxN?=
 =?utf-8?B?OEY3NGtWdTQzaWNEYVNxVGppekZXVWt0amF2WDFnSHRtQzh3SjRhYTBrd3hV?=
 =?utf-8?Q?T24kejwuJKk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGxIS1hhSnRlR1ROdSt1U0Q4dklSTnRDRmJqZFArZFB6cGozL2JuaFA1dXNP?=
 =?utf-8?B?VnBTMTlSR01xcmkxd2JQajlRcEZiMGg5cVFiOC9qUUNDbzBFQ0hnTlppaHJx?=
 =?utf-8?B?UGF4ZjBnb29RVHNNS1RxVW4waVhZK0lWcnY3aXJhMHVPY0NUVlI5YlFqYTdF?=
 =?utf-8?B?MDZMQU55MWhJSm5aK2JKTW9veExpVytDdFJGR25YNWIzM3ljU0huWVkzaS9W?=
 =?utf-8?B?ZzBxcXN4MjRaTGV5QlBkZjl3Y3YzME5vTlJHMEQxdXFXL0t4RVNBN0lMM2RZ?=
 =?utf-8?B?djFoK05HOFU0RG1lM0NVT1d6S041WHJVYzBpTDVNUzNoeFdUcXJCMFI5eHF0?=
 =?utf-8?B?ZThvbzFYNjI3WUFVQ1B5eWlSWG43ZktRR3l4S3dJS05xMytuSlNXZmNyWTYr?=
 =?utf-8?B?b1FqeHNPMjBCbFlWRTRmNll6OW1GUUVFQXBtQ0laUTV6dnZOaktTWTFZNzJx?=
 =?utf-8?B?UUdjb1M5endjN0N1WTlScmx5WEdrOGU0bjJUaVhCdXJ2Y0FQQXFWdUk2VURW?=
 =?utf-8?B?WVJWWXFGbUUrOE9YUHpmalhPWWtaVm9MREpYVzFFNWdhaVd1NVdqNXVHUXkw?=
 =?utf-8?B?WHJzTlU4Zm1yeWVqdUo4YURhNGNBemZQY2lyeEtDeVlZcWpjeGlYNmJBMUx5?=
 =?utf-8?B?SG5QTUtrSW0zN01teDgrOTY4M3MxWTRFZUYweXc2UDhxK09ZaVB2eE9RcHJk?=
 =?utf-8?B?NnUyR1AyMkVDc1d4T3cyaXA2cGJtNGdibG15VE1hOFVWV0JDWi84aVdCVjgv?=
 =?utf-8?B?SkJuSjlGNHFnelRWMGJ0VWszYU9VRU5LRHZaUDlhdmtCRUYrZjg3WHBiL3Jo?=
 =?utf-8?B?SWQ1UEFIdzZuSXg1RFV5clF6ano2S1JsWU42MHVmd0NZWHNDekJuVzJjTWpo?=
 =?utf-8?B?anNVbnJLVHZZckIzdmVhL1ZmZEI0VXJtdXBzdlMzVittd2FhK201LzllUmFW?=
 =?utf-8?B?ZmlONlIwcFFTNHNsSTFybzdxcGZHdGl1czZrSmF6NG1EV1NXWjk4aVFPZ1pI?=
 =?utf-8?B?NCtOQ0IydWFaMlMwOFk0aGpHRFhPZmNBK2pncGJBeEZCTHd6dVM1bmlGTUNt?=
 =?utf-8?B?dWt1d3d0eWRHQjRJZjJkZERnbTZhYWpsdURMQWxtNCtwYkFNejVORzdDN24v?=
 =?utf-8?B?MFh3angya2ZSdkYwSkxFeDVna3VLOE5ZSU4zZk5SK2NiOFpaaWlJOVEyM2FZ?=
 =?utf-8?B?RkpQS3RJeXViemRXMFZ4MTFscU91ZWN4R21EYVhFRWJWL1pyM2hzWnp5cjhs?=
 =?utf-8?B?VG1KY2VoNEQ3K2VhWXlUdnlnTE92YUhXN0RkUFlPZzBSZFBPVW1xNDJMK3pB?=
 =?utf-8?B?NmhWdmRveC9ubTgxc3k0RjNwUEpGRVBrUS9xYnk5RkEzQnVTREZIK2dDYnJJ?=
 =?utf-8?B?UmJDOG9vdjI2NkhLZ0FWYVRTbHh1dUhCdVdoY0pJRzVhQlBLMVZuK25ZYUN3?=
 =?utf-8?B?WWxVYUZyZ1k1ZzdnYVRYWndDZXU1VU1DczBta2VpdEswMEFycENoU2oyZ284?=
 =?utf-8?B?SlBLK0xPQXZrUmNwdFkrVjhZM3BhWmpkNTNRRmFjY2VCWTVQMHNBN3E3UGFC?=
 =?utf-8?B?aGpMa2o3eFpmU0RTV1ZUMUpFQ25MbS9wLy9RTzkxTjhDSjErMmVkUWVPLzVV?=
 =?utf-8?B?TThOdHJiVXdTNWo0MUdFak0yRk82UHBsTHR3bHZGd0I1bkdXVHQzYS9rYWZ0?=
 =?utf-8?B?Zkxta2toVi95REY0Z3E0azBRdnA0d1pNMGNad280UGJ3NmpDSzZSblhVZy9o?=
 =?utf-8?B?aWZNdzZqeCtRcW00Z01MVXdlMkcvRFNPL20wZWdrcWpsV2tjT29sK1ZVQ1ZB?=
 =?utf-8?B?allVRWMxM2RFRFhjem9NdkV5VWthakpDTDNydWcrdXJDOHVBbnNyZWl2NDJT?=
 =?utf-8?B?OHlyS0FtdGY0YXRlRXBBOTNLSENTQWpadExHd3UrN0FZbkh6VkhIeGlNbmVH?=
 =?utf-8?B?VDAvbHMyRFRrRjRNWWNZNlFiWGR4QU4vZkJwQUFwR1pQU2Y0dFYvc2NON3Vu?=
 =?utf-8?B?T1hzNmlVL3VZZFQ0NFYxRmg5RjdLSUtsYkxwdDVraENQV2czMmNxdkd5NFJY?=
 =?utf-8?B?NHhEaEloY0tUZHJDeTVTWVFoVSswbytwUmpmOEZjTmdsTXcyS0hKREU0Z21x?=
 =?utf-8?Q?eu25FkgMXaW5L5mDfdcxu53EO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3f05ba-2b67-4c3d-8d2e-08dd6844608e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 06:48:24.7298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65L0UOIb5qgBWYID4gPgpNk5okqESWVAmMvvYYIgltf4oU22dDqBXt8k1m3MwPUPKdMC+10Jme9DP2NYzVMXcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8474

+Yu Zhao

Realized we had not CCed him earlier

On 3/21/2025 3:20 AM, Davidlohr Bueso wrote:
> On Thu, 20 Mar 2025, Raghavendra K T wrote:
> 
>>> Does NUMAB2 continue to exist? Are there any benefits in having two
>>> sources?
>>>
>>
>> I think there is surely a benefit in having two sources.
> 
> I think I was a bit vague. What I'm really asking is if the scanning is
> done async (kmmscand), should NUMAB2 also exist as a source and also feed
> into the migrator? Looking at it differently, I guess doing so would allow
> additional flexibility in choosing what to use.
> 

Not exactly. Since NUMAB2 is bringing accurate timestamp information and
additional migration throttling logic on top of NUMAB1,
we can just keep NUMAB1, but borrowing migration throttling from NUMAB2
and make sure that migration is asynchronous.

This is with the assumption that kmmscand will be able to detect the
exact target node in most of the cases, and additional flexibility
of toptier balancing come from NUMAB1.


>> NUMAB2 is more accurate but slow learning.
> 
> Yes. Which is also why it is important to have demotion in the picture to
> measure the ping pong effect. LRU based heuristics work best here.
> 

+1

>> IBS: No scan overhead but we need more sampledata.
> 
>> PTE A bit: more scanning overhead (but was not much significant to
>> impact performance when compared with NUMAB1/NUMAB2, rather it was more
>> performing because of proactive migration) but has less accurate data on
>> hotness, target_node(?).
>>
>> When system is more stable, IBS was more effective.
> 
> IBS will never be as effective as it should be simply because of the lack
> of time decay/frequency (hence all that related phi hackery in the 
> kpromoted
> series). It has a global view of memory, it should beat any sw scanning
> heuristics by far but the numbers have lacked.
> 
> As you know, PeterZ, Dave Hansen, Ying and I have expressed concerns about
> this in the past. But that is not to say it does not serve as a source,
> as you point out.
> 
> Thanks,
> Davidlohr


