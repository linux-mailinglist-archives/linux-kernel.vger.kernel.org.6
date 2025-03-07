Return-Path: <linux-kernel+bounces-550355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B929A55E49
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 04:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BC0318976DD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 03:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFA318DB39;
	Fri,  7 Mar 2025 03:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wlEzhJrz"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BC87F9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 03:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741318051; cv=fail; b=Sf9vs8DiwSiCWSAbIQTcoyzrGcZARmJmoBpy/O/TXWuuuyce7RE2Ki1+GYynsa8coZoiRGdzFBvwCdeCehY3SROhM+ZDaTuxYPYAlWwjNbou6cWaIjgjWMGXPvCvMMeE0VP1CQdnU1o2Gu3ccj08DpiKKVRxVLW/sdSLDMWU/uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741318051; c=relaxed/simple;
	bh=04cXlJf7+t0O0A3xIWIflvq9HuHXgQfgvhffbAhI92c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SwyG2GjxYGHNRuCcTwBCF8fKKFG8IIRFs7uGSdmdiN2VConCCkDNzCWHRBXlnD2PmQTUjJQZGCW7bGRzHbq2J+fhhJmimfC6sd/VBJ8co1SAwI0pIF/JCAczL8B8PS9lsgAAo2yMkrTGaoqTl0B0T+se0Z1km0Ygk/XwEJkRN4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wlEzhJrz; arc=fail smtp.client-ip=40.107.92.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5A5D5yd7wpf96fuXGFRCjjCD8FHeq2DV2+7ZRkP+1OyJyQKdWgbGZHC9vhAg8P3dtHq/VVDrD41cOhR94UDjGJMMl9/mVXR7KY32LRPyM1Aqocp6g8nCh+yfeVNZLGTT2E+S4y9UyaDnW2T3KgmDl3pjkmzZTTWhrg+PB69NS288V0HlYlkwRff0pAHwtmonZ3zhoduvnVAqEGhU5Ezb6020ODh3RwDv2I2/yMF3Il70AHXyeO5bqa7xNCoRkmcAbwO3Hkiu6bqqKYIDKxct3BSbQ/LLJu5ntS2mnd+f2svISfkz2jUQFlCpjkuYHfkQ4EFkrYn+TBmWHc6TS4rsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GpBtS0BGSIOeINZrt42IdSoqyQiuer4IraZIQPpfpIY=;
 b=vygDHgFfbjf1eWWNLMD2r6e1vo15qW0LXgYk6CPawqXO3+el+g5q3rSFtlgntq5Fcvj680eRAtJl9bOimCavD/5j81izI21599uzlu8eIrHpQZzz3bLTQzO6ifWPKuJvZDasZsHlQdw3D+c+kpsxDMFy4RcBfKbuDC+lVZcBKgHHfje4OC1R+aX8GSuai8SODy3eHa1oyQCJBUD/hdtNtZZwbdyJEXv/5pZ6Ah+tf8xo4ThzWTU46A3zHpYb1tjgcCC0bnPOBPjF8sp91beA4XLawPBM9z9v8KTcH6vYeJ5KG5+WhMTLBwVUsL+x6Rf+xlMTWTepo6vPvZtk5ls+gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpBtS0BGSIOeINZrt42IdSoqyQiuer4IraZIQPpfpIY=;
 b=wlEzhJrziirYD50UXgAmtRA85pqC7qvyyMAPLnrqSDffDx/Ajz4EgZZUlBIriSrdxEIbtgKI1LMcLFCKXRcaasuK7PaW/HIYW5WovgTxeux0ngvncShxAlpamuQgfO2NjfakgbLBLaSW7JFYX7n4OpeoKTVrOPLe1vBOgdJzPGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by DS0PR12MB8247.namprd12.prod.outlook.com (2603:10b6:8:f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 03:27:26 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134%3]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 03:27:26 +0000
Message-ID: <1b6fa3d4-2127-4427-bc6d-cddf6459849f@amd.com>
Date: Fri, 7 Mar 2025 08:57:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] mm: kpromoted: Hot page info collection and
 promotion daemon
To: michael.day@amd.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com,
 Jonathan.Cameron@huawei.com, akpm@linux-foundation.org,
 dave.hansen@intel.com, david@redhat.com, feng.tang@intel.com,
 gourry@gourry.net, hannes@cmpxchg.org, honggyu.kim@sk.com, hughd@google.com,
 jhubbard@nvidia.com, k.shutemov@gmail.com, kbusch@meta.com,
 kmanaouil.dev@gmail.com, leesuyeon0506@gmail.com, leillc@google.com,
 liam.howlett@oracle.com, mgorman@techsingularity.net, mingo@redhat.com,
 nadav.amit@gmail.com, nphamcs@gmail.com, peterz@infradead.org,
 raghavendra.kt@amd.com, riel@surriel.com, rientjes@google.com,
 rppt@kernel.org, shivankg@amd.com, shy828301@gmail.com, sj@kernel.org,
 vbabka@suse.cz, weixugc@google.com, willy@infradead.org,
 ying.huang@linux.alibaba.com, ziy@nvidia.com, dave@stgolabs.net,
 yuanchu@google.com
References: <20250306054532.221138-1-bharata@amd.com>
 <20250306054532.221138-3-bharata@amd.com>
 <5017862d-98d7-4f4a-8272-88bcdfa78fcb@amd.com>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <5017862d-98d7-4f4a-8272-88bcdfa78fcb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0203.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::15) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|DS0PR12MB8247:EE_
X-MS-Office365-Filtering-Correlation-Id: 18e1995b-ed42-400a-2fed-08dd5d27fb64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blVCSDlWU3U1bVM2NjdrM2ZYZkpDSXlhZmJ4KzhqWjFSR3cwS1ZDQWQ1TGFw?=
 =?utf-8?B?RXNZT2I5R0RBcVdVN2dBNGJraTJZanQ3b3cvaDR0MThjWGRvRlhPZzFxN2ZB?=
 =?utf-8?B?TVUwKzFGeVo5dkxkbDB1dHM4c0V4YWFuampacjZ6Y2FJejB2Ni95NmIxUUJI?=
 =?utf-8?B?TzErWm1ZQlcyMTJ5YVdtRlZTM2g2dFp6bVBwS3haKzNkMGQxYnlYdzRWUDV4?=
 =?utf-8?B?bnVjVThFZzRacnJibDU4Qm5qK2dVdmU5RG5FYzM1cEhwTTlndWVUcmxMNzBa?=
 =?utf-8?B?YVMySmRReVlKUzJYSGxUdEdOMEExRGpTVE41V0dmeWpBV1AzQ2xvVUNyMUgy?=
 =?utf-8?B?WXBnZlp3SWZvK0ZkWTJTaHZRNTU2RTlFUFlQclg1L3JVcHdPeTc3bWJlQzRi?=
 =?utf-8?B?RVorajg5TlpJM28zcXpLMEZrRjNHckVTQjJNbjU3ckFwcVdXK0xyRjJtVHdi?=
 =?utf-8?B?ZEFRZmNxempZWS9zK1hJOHhTL01zN0tYUjhWUjZPVkU3WExzZWRoNG01UVg2?=
 =?utf-8?B?OG1FTXZiZVptZlNsUzBDam83NzhPMWxCSzhIa3JEYlA1TGtoZm55Y2d0Ri9K?=
 =?utf-8?B?bDI0dWdmWmNMcU5Ca0dXVkpoK1czV1UrWVNQZUc1dHNuODNXcEF3Z1BXMFRj?=
 =?utf-8?B?MEE5b0NUM0MyT2U2RjJZRzVuME1SU1QrSGR6UXJvM211WW5yNmkrRHpuME14?=
 =?utf-8?B?THZmZ3g0VzFLOVE1dTdieEdSYW44YjI1NjVuTFJWOTJ4cDllN0lQTmN1MDFP?=
 =?utf-8?B?b2pnV2NFdlJmSStWR0x6RkhTSWJ0anlId3ZQNDdwcWhCNzlpczd4aXNVanE4?=
 =?utf-8?B?cERIdTYvYnBRaUVwbS9xSGFsT0NFZE9Zc0tYQWtqMEdBV2ZkbkdOSGphbTZO?=
 =?utf-8?B?NnZYOEtMMWlzMTNxREs3N2owSkRzczRJVnBvWWo0OU9jUyt0aVBPMlNsWG9T?=
 =?utf-8?B?K1prL0pLWml3dllGOGY0elM0cTZzWXJJanJuVTg4blNaK0Z2WnRXdWpzQmFB?=
 =?utf-8?B?QXdOYkl3d09wa3J3cUZuamxhUFMzYVlIU24zM1ppNFVucml3UDAwaTRjTi85?=
 =?utf-8?B?QUlkai9uelE0TzNVaTVtQjVjdzQzNFNlSXJOTTZyaHNXVDJLbFJBdzBHcWhx?=
 =?utf-8?B?S0JlV2ErbnRBYklUdkdzY2lFNWt2aXpISzFIS0R4VEsxVnp2aUlDaWZGWmky?=
 =?utf-8?B?OFpnQTVxS0ROaldWZzAvZDVLenFMcU9mcjIrd1FHSk9Xai82ZlVIa1lFMnBS?=
 =?utf-8?B?MlpHVGgwZHhmQXlmdFN0cUNlVzdmRk91ZDJUR1pjeGo1dTZaYjE2akxlRnhK?=
 =?utf-8?B?V3FwZXBza2ZlNkQzWDQ5d3daYUsxcnhPa1FmcWVFVDd5eFNzM2lUaThnVlpQ?=
 =?utf-8?B?TGk2aC9RMXFKbWxaUDk4VE1BU1FHNlAwNXFTdDhpMEx6MG9tdy9xdEMzNGdO?=
 =?utf-8?B?bm1BMjBYK2VsWDFkVWZtclZuQ09Ic0Q0WENZWmF2OUtya0dYSmRuZGE3ekxH?=
 =?utf-8?B?VWN0YnVOMVo5cjYyYldXaHR6cGprWC9jSTFWZnVzdG9WaDNrTmFTWSt1MGMx?=
 =?utf-8?B?Y2lsSHhQU1hkcmkwNG1yMzBEOFUyMmI3eUppeHV3bU5TYmtaNTkvWkxsS29O?=
 =?utf-8?B?MENTVmRkZG1ld3oxUVhZZDNndVk5UE10dXBCVWx2SXZJSDVMTmxsUktsM3FK?=
 =?utf-8?B?UXZ2WjNnNXlwUEU3ak8yc2huY3BIUk5NdEZUMGUvNzRYQ2tqa0hRM1RCRXdS?=
 =?utf-8?B?V3RXbGlOa2JVcUNidlhGOXI3eDNyaENpWS9aeE1qOVN3RVBmU2IzNWQ2c3pW?=
 =?utf-8?B?T29seXhianlSSmc2QUxwTUlMNGx6MmN3eVI1TE8zdDVwOEZHbXVWc0t3U0pH?=
 =?utf-8?Q?et08gzBccrH1n?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NURxdU1yUm1TVFZ4RHE2ditnanV0KzZ2Z2dLbDcyMTBiNE90M0o5OEkvOEVm?=
 =?utf-8?B?bEM3RFp6VnZUKzdiTVRIMkpscFFmZy9LUlh2R2I1QmFVUDlXcXpUNERUV3BO?=
 =?utf-8?B?Uk9YdVkrM280dHNlMEFkazI2SUtCYXJ4THdIY2VDQWphYWtEdVMwbDVlNXR6?=
 =?utf-8?B?NDdYSmJIR2E5S3dKVXl6dFpzRXhYMDNtM25FTUdSa2lQLzFDazVaRG4zd3lN?=
 =?utf-8?B?UkMyMVlsM05xQnBEMG81Y0ExT1loblZ4OFVGUlA2ZW9SaDhzNlRvenhkWk5o?=
 =?utf-8?B?U0VES212Qk0yWC9Xc0xJMlFmcFJJY3hVeTBNOUdpY0xYclo2S3pkQ2RNUi80?=
 =?utf-8?B?eFJTaWZoS2Iwc21hb2V1QTRUWldJbEJCdDZoOWMzZjVLc2NWeGxJUEU4R1Uy?=
 =?utf-8?B?MVVGWVRSaTN6ZlBqVzBPNWMxcjBIRkxGNTY0Tm9sdFVFSUVPd0FQbmkzY3JD?=
 =?utf-8?B?Z1g1U2NZT0d2RnlYQlJLOTNsbms3OXFyV21kY0FiNDMyWlROTVZsYy8vY2FL?=
 =?utf-8?B?VG03TXUzeG9iRFZ6bzRaaml2TWJZZHY5Y3JITVJnNWJGUnpKbzAvZ2plRnlp?=
 =?utf-8?B?aGFwQVRLMEZDOHRrbjJXd2lLbnM2TW5ZdlpaVitnVVNaMWhlZlJZVmxQc0x2?=
 =?utf-8?B?UEFjN2dVSmxhVWovSERRU0RFRTVBcTRaZkpUUzNEZ3QwWDNpNUVwM1MwcUxH?=
 =?utf-8?B?Q0dJY0l5dkcrdlQvcDU5MlE2ejAwM253N3BUdjZoTEtvU2xTbDU2eG9IQWdu?=
 =?utf-8?B?MlFVTnhTTi9uUWc5b3hQODhJaVRSNkN6NzViV3M2eDJCQk5URjF0SXd6TUdE?=
 =?utf-8?B?MDBiREkyVlR0Y2d1bjhMekxzQWEwVGw0WnV0MEpGL0VYcHByZnNsU2V2WEQ4?=
 =?utf-8?B?SjNZaXk5VEFrTUhPQTBiU1hldGxacnpTWFMvenpnOU9XS2NvRm1qaXVTMDU3?=
 =?utf-8?B?R1A1SFFtcUJMdis4U0tITEJBVHFwdUJCVWJ3QzVieEEvR0kzN0QrL0dpZi80?=
 =?utf-8?B?ajRhZkxGdVBQakxjYVhkZTBPdkhMcmRiWWppbkxYVXdManRyM05IcnlxKysx?=
 =?utf-8?B?WVphQ2gyT2Nsa3dJTDJ1TU5aNTMyTktUNEw4dkUzcUF5bjJocWNNTjVxd0xD?=
 =?utf-8?B?NTVISURZSVJPOTl4SktFcU5RdnRSQlIrK2R5LzZwQm8xZnlWSThmcGR6a3Zr?=
 =?utf-8?B?WXZZa1hLV05obDlNNjlSelpzazhGbndwVUR6b0xNQUlxOHFpZUpUSFZldnhW?=
 =?utf-8?B?WVI5UUY2Y2RqYTFpdlQ0VzM0bkF6TlZSbEpJTTk1QjNrN3VUQnFrOTM5bm0x?=
 =?utf-8?B?UEM2N29JUm5LMW44TjJaQ0ZJb1lBNkFDdytuTzd0UnRtckFwS0F0NHozNmps?=
 =?utf-8?B?Y2phcGN4UVJSSitrUUd3NkphZVNpQkRlQ3NtbE1kYVhQaWorRkEvajlZb0hy?=
 =?utf-8?B?L1dOdkpncWpXZzRYM0Rra2NaZGY2K1V3SWpFdzh2NUZ1a0RGeWhRSE5CcHpL?=
 =?utf-8?B?bDNtYkNIUVludUxuWlI3NjdxR0U5NXJCS3lmSm94ZGdMZ3FIMFZvMkp3OU5i?=
 =?utf-8?B?Q0trRkRYMzZlM0RNNENxL3hxZWpxQXlKMlFmY1g0RitNcU5hcUsybGxOOHJz?=
 =?utf-8?B?TGRvUW5oRS9VME4wNm9qMGs2TS9WdFhBY2ZjS0htb2tRRWhSMG9lNS9LZ0Qx?=
 =?utf-8?B?UWRER254WisvNm5BdnA4S2JpSnM5akdLWkdGN2NKL1dadlA5MFlnVXJOQkxh?=
 =?utf-8?B?Y05lYnhFMVNaYkZ0MGlyMVpsM0JvbGkyeUEzZ3h5ZVdCTm1FMTBlM3h3YzZW?=
 =?utf-8?B?dmdCRkp0eHdOUERWNjFKUHRMY2g3Y2Z3a3FvZURCY3NyM3ZRa0ErT093NVNs?=
 =?utf-8?B?UXBoZ2kwdXhUVHdWV2N4RVlHNlVZRERMZ3BzT0pVWVd6ZHc3blVMY1B2b0sr?=
 =?utf-8?B?S2FlcmxsUEFicEVvTmErQ01JRUwyK0pUUngyNnJpa2tUQTFKZ3l2eGZHNklw?=
 =?utf-8?B?czRlS2l3Y3N4YWNSSC8wbmtsMVdLTnZxa0U4NEozSXdzUE9lbnBOeFFQS0ZR?=
 =?utf-8?B?NnY5cXhTaWY5dHd3bEpOSkViUVVYZEcxSHhVWExza0Rxb3E4clZHanZ6VTRP?=
 =?utf-8?Q?uYI5VDIZtCfwEBNhynz2yuteX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e1995b-ed42-400a-2fed-08dd5d27fb64
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 03:27:26.2772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wKCwNnI0CjUirfRZSLHeYFwvM+VBloO5AD33/wJdMaq/i0rAB6wuCS0lz6rxWo88sfK9YdibPf4khESsOWEvGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8247

On 06-Mar-25 10:52 PM, Mike Day wrote:
> 
> 
> On 3/5/25 23:45, Bharata B Rao wrote:
>> +static void kpromoted_migrate(pg_data_t *pgdat)
>> +{
>> +    int nid = pgdat->node_id;
>> +    struct page_hotness_info *phi;
>> +    struct hlist_node *tmp;
>> +    int nr_bkts = HASH_SIZE(page_hotness_hash);
>> +    int bkt;
>> +
>> +    for (bkt = 0; bkt < nr_bkts; bkt++) {
>> +        mutex_lock(&page_hotness_lock[bkt]);
>> +        hlist_for_each_entry_safe(phi, tmp, &page_hotness_hash[bkt], 
>> hnode) {
>> +            if (phi->hot_node != nid)
>> +                continue;
>> +
>> +            if (page_should_be_promoted(phi)) {
>> +                count_vm_event(KPROMOTED_MIG_CANDIDATE);
>> +                if (!kpromote_page(phi)) {
>> +                    count_vm_event(KPROMOTED_MIG_PROMOTED);
>> +                    hlist_del_init(&phi->hnode);
>> +                    kfree(phi);
>> +                }
>> +            } else {
>> +                /*
>> +                 * Not a suitable page or cold page, stop tracking it.
>> +                 * TODO: Identify cold pages and drive demotion?
>> +                 */
>> +                count_vm_event(KPROMOTED_MIG_DROPPED);
>> +                hlist_del_init(&phi->hnode);
>> +                kfree(phi);
>> +            }
>> +        }
>> +        mutex_unlock(&page_hotness_lock[bkt]);
>> +    }
>> +}
>> +
>> +static struct page_hotness_info *__kpromoted_lookup(unsigned long 
>> pfn, int bkt)
>> +{
>> +    struct page_hotness_info *phi;
>> +
>> +    hlist_for_each_entry(phi, &page_hotness_hash[bkt], hnode) {
> 
> Should this be hlist_for_each_entry_safe(), given that 
> kpromoted_migrate() may be
> running concurrently?

I don't think so because the migration path can't walk the list 
concurrently as the lists are protected by mutex.

Regards,
Bharata.

