Return-Path: <linux-kernel+bounces-573998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CEFA6DF69
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6109E188CB08
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F4E262D35;
	Mon, 24 Mar 2025 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lNAk/C7M"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C34262D26
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742833063; cv=fail; b=S7ZzSpgdTrjE7PeYfx8LdxGVd6tXcqATwFBB/pMzTUozsX0OmOZJwRj+nnjYFqvIMwCXvLGgSfGL63swBQzbi3bliSwVUaradNmulrqTf33wEt+MBgiTPQB+Y5EsomsVpwJ/2nXMeI0e3M4Xv2XYVnW/SmVQm+PuRo44hLcWVsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742833063; c=relaxed/simple;
	bh=qdks5c5/4N000rO+rQzGDkRJ0KBTinK8Gv06Byn+5RU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H5nPxkynADKkfR0OfZmGvpjI4Gwf8vf5lDQnQ+GBdy/K+bSEtgtOdcvPCEgeOmCB1eFeKJT5h3t+tfcEs+XS8cH95qMaJJujzlz1sqhHcebx/utXdFIErCPc97X3HGCMsgO66XfLl95761d/FufQg5Dxt/8kUlUzDx2t+NKGvDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lNAk/C7M; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mva5hRMzPKoCBI8ouk+PdFK4SGA62cvGOywCnXnVGEOnpe9/9+PJwxmHtJ92/tXAOcVgH/nzKy32walYRBc11qwLx5VvtVH56b+BgMzrDo/LDFVGrtpcwqPW8yTyWDV/edfcnHfpiobSBFswj60W+Zg12JpBp/6s86EHZcYxug+8mVEA9r5SMNJWVHZP2DOAQnG3bBlzfOlykYnXGPtKPt6sWbT+z+pYD8bMDqZ/nANZZrqevcReLTQx+BGvhEoFZ4jc0c9FpU7fFCyWUmxpl7Y8Q02vGdyzr5Qgfik+GdEaqWugX9CYufqVIvLT5OnYYP08O6M/HWW4Ge73SH3+sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHMfkctDx7dlg6iuXzq3GidFGls5/PTq+abupVqk3/w=;
 b=JSBrPQCS3d0tMAi36TEjG1E2z86PG6PT32XMvA1AlcqxmCtYTezg6Qc3+XRAuLa+thufUweuV8YrK6U1ts18Sb868E+yr46SpUoacGqKherLIp5nuE9whhTs6PIIyJLW/Fvozw+HBKv8Luzy7Eiwa2qHQtgEKWVCT2przSA0tVRLdAyFCd9fVf9kAjudPiTYISQT3jMjlmEyq+7Nb36iKs3gHLh2iOI60iu+5rt4RVXVYpZjFahHV/SAbslParF4AvUF5acZwWTblrtK8UNyXqDIwPZKnOTOKw2Ky/3c+zIEImd7EoGqo332KOmoXcFuDZp9YKWAGCUXpLMygIvPTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHMfkctDx7dlg6iuXzq3GidFGls5/PTq+abupVqk3/w=;
 b=lNAk/C7MFwsYW274b0Hr8ryrFzZPXJ5uZaaJSxb7afxRv0PEE1VHuPenfT1Xuzac6JgjK/3CoRN1z14Gf3RlJof93BA3njBkPPrurpqpNi52umUEJrIpCQHciTkqpuXtCZQFirXnuaDi3bBDa1iMJ7yRLZ4YDfHgJkYX+xX18jc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by CY5PR12MB6155.namprd12.prod.outlook.com (2603:10b6:930:25::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 16:17:37 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3%3]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 16:17:37 +0000
Message-ID: <2965932d-bde8-4610-8946-c575794c0991@amd.com>
Date: Mon, 24 Mar 2025 21:47:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V1 09/13] mm: Add heuristic to calculate target node
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com,
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
 ziy@nvidia.com, dave@stgolabs.net, Hillf Danton <hdanton@sina.com>
References: <20250319193028.29514-1-raghavendra.kt@amd.com>
 <20250319193028.29514-10-raghavendra.kt@amd.com>
 <20250321174232.000047fa@huawei.com>
Content-Language: en-US
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <20250321174232.000047fa@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::8) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|CY5PR12MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: a1e254f2-f905-4448-4728-08dd6aef6466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c29kWTg4MTJlMGJqNHJ6dUMrMXBhUkNyaGNhWlNtSHRaOFlZZEhnN01Tb2lz?=
 =?utf-8?B?bTh3TDBFbFRlaVUyYmtJak1KWFdLa25aZk9YR1FWU1hFU0RJTEdGTENnUkxl?=
 =?utf-8?B?bDFUMWZBVnJzRUlEcFBJSFJWRExRdTltb3g3eFZzczJETStzaU5LZU1mNmRn?=
 =?utf-8?B?eFVRRWNNbjJFbTV5R1hnZkdML3VvWTZVWXhvQWVSWG1XQklKTGtweGVLS1RR?=
 =?utf-8?B?VUpKTm9KNHBLZHVLejZicEtkWkdrZGc1enIrWGtValRlQi85WUh5Z3Z3UHU1?=
 =?utf-8?B?K041b0puRktDNjNDQ1IxVkR5Qzc2THJycXRtT0Jya0tZeTN5dXMwczFDSlJn?=
 =?utf-8?B?ZHROUlhSb1pScTl3c3g5Y1k3MVJXd3ZYYkZrUlcxTk05aHQ1MUFaSEZmTkVa?=
 =?utf-8?B?ZWVUSmwzVmU3MUFoaTFwa1M0bHUvek9LbmpRK2VmbXNTNm10Q1l4VlJxaklj?=
 =?utf-8?B?c0lzTnJTZjY4SWxJT0R3VEhHcGRBYUJuRUhzZ1hFaCtjQlQxWkdoSE9SUFpM?=
 =?utf-8?B?Z3AxbnpCc09kejZiWFJtUzlPQmdyekprZDVJelZZNG1qY3ZDbVVJRzR6eWgv?=
 =?utf-8?B?UDBuMEJ6WTFzWWxReU55M3FmellwK1NBSm1WYjdrdmMxanErMGp0VzRmYkd3?=
 =?utf-8?B?bHAwRjdvaS9IcC84azJaM2wzMHdUUVVubW15UHdOTlgybWF3N0tvSVNBOWRy?=
 =?utf-8?B?YllaWnYwTUExaEhZSkJVcGVzamxQUTluY1VJaHdnZC9iOXlhZG56M2FhOEFC?=
 =?utf-8?B?UDhSekp4Y09SbGNOd1Fjc0tSU081R0tTYlNZMm5qWkFwbGU5TFE1VGplbmxi?=
 =?utf-8?B?aHFuS3I1Rm5oRXJxY3JqVjEybENNZWRJTjh4ZUZtNG5VUFFYMVJOazN1ZTJk?=
 =?utf-8?B?aFRzbVc5ZlNhVkl0dUxMb0FKOS96TEdTUmVJR254KzFFamEyUmNQZll3WHNs?=
 =?utf-8?B?VzA3WVBsVTg0UUczcWxCZ1Q4akpmRS80RjBIdWxwWHNxRVhueDZKQ1psVUxG?=
 =?utf-8?B?L3Y3Wm1zQ0lCSWRlSENtbzF2MXUwSC9CK0t5dktQbi9TTWZla0gxb2t3ckEy?=
 =?utf-8?B?QVhscnVnSWNLTHRPMnk0UldnS0tnVTNKazFDcnkyeUUzQ3lsMnVPU3U2Ymoy?=
 =?utf-8?B?eU9SczhNc3IzS1NDYitHL0VITGxSc0llUThCZi91cmVLQWpvcTNjRWVKNVdV?=
 =?utf-8?B?SzdWTmE5MnEvQ0xFT0JqdSt6RHpra2NCQWJVQVVMTXo3dVhmNzJJbGg3L0hl?=
 =?utf-8?B?Zy9wNXkweGgvb2pYSHd2c05zWnkvNklnQzFJRkVyTnJ4WDhLZ3o1cHJsVmpX?=
 =?utf-8?B?Q3F1UWdscHVEQnlOVVN4RW1wM3Z4OTJhZUFHRXJ3Njhvcm84SlJnTloySXpP?=
 =?utf-8?B?ajQwaEU3ZzZrc29QWGdzdlBQbCs0RkZjaHZrTmczRXJaVkZWYTM1dlRZYmgx?=
 =?utf-8?B?RGIyOTdHbTVGR2NEZWxKZXJldEhsSnNOdVRXRWdCR1VaZXpvcVdNZjZKNU5E?=
 =?utf-8?B?bDJjV29mL2lkaGpMMjlnMDdHYVhkSXBEeHI0SHBEV1JuQ2ZvdTkzU2lhZVlu?=
 =?utf-8?B?eVJEelkwSVExU2pNT1JFakZJbmxmN3lTR20xVzBoWU5RYjE1OUYrUzQrZnEv?=
 =?utf-8?B?QVFFaGxWRm5WSEcvSUlTcGxhR0NnUlJ0aVF4Q1VHVU1PSTRHcGJ0aDNkTWcz?=
 =?utf-8?B?RXd0WFN2TWpxdVJ1cElWZVUvVmxUa3BmcFQxUjUrSVF3SUVBRythVnRqTWlU?=
 =?utf-8?B?bk5zcDZXZEVsRENPKzUvMUNXeDBadTFZSzZocm9la0xyTTJzcDY1ckxiTXBp?=
 =?utf-8?B?NGprLy9jUjVUUU9ESU9sOThiTWxFVEN2ZlBpOVJRUGJyekV1alJRMU0wTzhr?=
 =?utf-8?Q?76iEq4YsjqFhc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TE5DOUFwMzA3Q2M0WXVuYjJjdGgzRUN4bWVXY3hQMDBBNE5JUGJPSHlEMDBQ?=
 =?utf-8?B?TmtienRqUkd1bWpHREZuMzFpeWtOQUJ4ejN2NnNpaHBwOW1YN0htVnY4VWtx?=
 =?utf-8?B?UStTY2dMaHpiSmd1WC9YUzJWSVlwOXRSYnh1bEk2MllnenR0OTFnVENMbUZx?=
 =?utf-8?B?c0cvSzljZlZzdHgxSFdacngxQ1pkUHg4dVR5NGo4S01vVCs5OFBVczNITTBo?=
 =?utf-8?B?SjhvakU3Q01EM294WDJ5cGNGVktaaGs0Zm5GVllyYjV5VisyaEJWbjRyUk5p?=
 =?utf-8?B?K1hzU0Q3VUhyc2tKcWxUNVJDbUNubVJRcndyMk00MldsN096QUJsVDJwTUVY?=
 =?utf-8?B?TUJENEdQbGsyZFh0K3BZTC9LRkF2RmxlNEg2VDJYZS83azVyRDhxYXlla1hZ?=
 =?utf-8?B?VXFLSnBRTEFjUHRQOFFGdHRtQmdnTHM0KzlZNWhlcmZQdUgvV21CRzVETE1T?=
 =?utf-8?B?WEJNRU43UEZUR2NKZjBpSnRDeEtEK0tTVCtoSmNCRWlpRUVVYkdwMHZwUG05?=
 =?utf-8?B?WTdWbllFSk9QdVBVQjVPVlVTQTc0V2x5MU9ZbkV5TnRKRzdmd3Y5TWxjYmdy?=
 =?utf-8?B?M2lMaHNqc0s2ZExDY2pOam5Xc0lwa29aR0o2UVNMdXUySmhtT1NabjlORjRQ?=
 =?utf-8?B?MmhjSGZQZlh2eFlQeGhpZ0hTVlNHV043SnRiVFVSeXNaNnJobjcrMUtPeHBm?=
 =?utf-8?B?Mi8xQ0ZlZm1XM0g5S1Iyc29OQWxNL2wyRzdTLzJGWXFxR0doRnpyeXZRTk10?=
 =?utf-8?B?UU5KSE1BdllZakhHRVlCbWZ5NlVrL2E3SkxJUjFkNlJhdDlqVTdsbXM2YWpU?=
 =?utf-8?B?NllCbEdrYXVESEhvYkZha3Q3UXlYZFE5MWhPZW01eGdvRDArNyt1TCtVUHR5?=
 =?utf-8?B?OG14QVRXSDUxMlkzNDI5U014TlFNZ1piUEtwWXY5VmJNck5VZFJxU2M0VlE5?=
 =?utf-8?B?cjcxRnh3WmJJWUJMZ3FtbUErYXBXRWZrQ2JzTjNMb3dSc3Y0aUNJaGZIbzRJ?=
 =?utf-8?B?a2RLYUFwdmsrTDd5R2l1TzRoN0c1bXFDaDU4ajJNemp0UzQxUlllamt6Tnpr?=
 =?utf-8?B?YjNrcDdXQUV3UFNUZG9XL3ErYVQvRWJ2TWJ3L3JWN2s3WHVUZWJ4OEw5WjQx?=
 =?utf-8?B?ZnNTenZDbzBjUXduc1hqcWR0QnBjdEpQZ2RJSDBoLzBBZ01SZWk4c0l5YWZB?=
 =?utf-8?B?cVVZbnMxTHJYYkhmdlAzSExCMzRpR1VnUk9rSWM5V0hESEFCazkraGJlVk5O?=
 =?utf-8?B?cHpFV2tDZW81Ni9SRVBkcWgwUHU0WTJYV1BkOUxwcmw3b25nUWdNalNGOVFC?=
 =?utf-8?B?TkZ5ZUxkZFpsbGRpQ01ycFAzUjdQaDIzQVhnWEpMd3F1RGE0UlkxaWJ1RWFC?=
 =?utf-8?B?cVpRUW1rbmVMeHExSW4wREhuRUEyQXVYVDY3MUt4VlNVMGNUNDNqZ2Erc2tG?=
 =?utf-8?B?SFBSb0xWdXdjTTlpVWN5aythMkx6cS9hbTMxSEZuMUI3YWF4aHBLQStUNldU?=
 =?utf-8?B?OFJ0QmRmWjlsUnJBeTFVOWt2WHVmU1piUWh2TDUyWXJ0L3Q5ZmJ1ZVp6YzRq?=
 =?utf-8?B?QW1aVGhVRGtVczdtSHZSRUZyZ3RqWHIyRFZJek9vaDNqaitva1pHYjllbU11?=
 =?utf-8?B?b2wyZklMN0hjVGhocVJIMk5HcTBvd3dhaFhmVGVpQVRyMDU0ZHp0eFpaWEQ3?=
 =?utf-8?B?cTdJMGpOdThKVGRwL1FHL3lsSm5kc0dSY1BDc1pjaWFNSjAzQUtIdzVPZ095?=
 =?utf-8?B?bWhYaS9icEhVeUlnYXJUVFhsSGcxZ20xVnJUMStNbnorV3RtUmR2bjllalQ5?=
 =?utf-8?B?K25kckQyejl1bEFjNExwbkppWEU4WHMzMjR2bndJKzVsenQxMExtQ2N5Y2o4?=
 =?utf-8?B?M09zZ0gybzBzZ1czYmFFdWdqTHR2T1BVRHFZQlNEWFFYdnI0QzI2ZWZHV0do?=
 =?utf-8?B?cGtVRXFrV05sd3NFQ3NKd041aDgveWl0OVZtU1NmNHpLeTZSM2xKeU1zcXo5?=
 =?utf-8?B?UDZZMVdEdW1PRkV0UktqWDNQVUYrV3h2N3ZJeDJMby9MNW9xanpGQUJkeG5l?=
 =?utf-8?B?b3REVnFJRFZWOXN5MVk3QnorZGRIMjA4Z0hjT1RMYzJmQjFmTzl4MFY0UnBC?=
 =?utf-8?Q?iFFwT5hrUtdjNEsGKpeeSFddN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e254f2-f905-4448-4728-08dd6aef6466
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 16:17:37.4861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzxAyp3QWyrTxYQi2/Ng78Oa9mUDliwmOuCzhm/ADjfHLt0KjbkXbcX6fuzTkBsOj2CdUldmYl5UxTzNwCcmzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6155

+Hillf

On 3/21/2025 11:12 PM, Jonathan Cameron wrote:
> On Wed, 19 Mar 2025 19:30:24 +0000
> Raghavendra K T <raghavendra.kt@amd.com> wrote:
> 
>> One of the key challenges in PTE A bit based scanning is to find right
>> target node to promote to.
> 
> I have the same problem with the CXL hotpage monitor so very keen to
> see solutions to this (though this particular one doesn't work for
> me unless A bit scanning is happening as well).
>

This is the thought I have (for how final solution looks like)

A migrate list and mm or target node(s) passed from various sources to
common migration thread for async migration.

source:
case1)
kmmscand -> (migratelist (type: folio/PFN, mminfo/migrate node) ---> 
(kmmmigrated/kpromoted)
                                                (unified migration thread)

case2)
  IBS/CHMU --> (migrate_list (type : PFN), NULL) --> (kmmmigrated/kpromoted)


for case 2 issue I see is, we are not able to associate any task or mm
to PFN. But in case we can get that.. we should be able use heuristic.

For case two, applying Hillf's suggestion of reverse demotion target +
next faster tier with highest free page availability should help IMHO.

>>
>> Here is a simple heuristic based approach:
>>     While scanning pages of any mm we also scan toptier pages that belong
>> to that mm. We get an insight on the distribution of pages that potentially
>> belonging to particular toptier node and also its recent access.
>>
>> Current logic walks all the toptier node, and picks the one with highest
>> accesses.
> 
> Maybe talk through why this heuristic works?  What is the intuition behind it?
> 
> I can see that on basis of first touch allocation, we should get a reasonable
> number of pages in the node where that CPU doing initialization is.
> 

Rationale is that suppose a workload is already running and has some
part of its working set in toptier node, consolidate it in that toptier
node.

for e.g.,

Bharata has a benchmark cbench-split (will share abench and cbench-split
source) where I can run 25:75 50:50 etc allocation on both CXL and
toptier.
After that workload touches all the pages to make them hot.

node0 (128GB) toptier
node1 (128GB) toptier
node2 (128GB) slowtier

I have run the workload with memory footprint of 8GB, 32GB, 128GB with
split of 50:50 on one toptier and one slowtier.

Observation:

Memory 	Base time (s)	Patched time (s)	%improvement
   8GB	53.29	46.47	12.79
  32GB	213.86	184.22	13.85
128GB	862.66	703.26	18.47

I could see that workload is consolidating on one node with a decent
more than 10% gain. Importantly if workload has its working set on node1
all the target_node is chosen for CXL pages is node1.

(Same thing happen when workload is spread between node0:node2,
target_node = 0)

However, going forward we need to device complex mechanism to take care 
of freepages available etc proactively.

 > Is this relying on some other mechanism to ensure that the pages 
being touched
 > are local to the CPUs touching them?

Unfortunately this where there is no control/visibility, access could be
from both local/remote. This is where we will have to rely on NUMAB1 to
take care of last mile toptier balancing (both CPU/memory).

- Raghu
[...]

