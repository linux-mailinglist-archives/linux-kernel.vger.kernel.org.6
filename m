Return-Path: <linux-kernel+bounces-554058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F3DA59243
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D291716B227
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F798226D1E;
	Mon, 10 Mar 2025 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v5MaXLFh"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010B4226193
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741604931; cv=fail; b=RAJzR5IppJzynSlKBScTJF7KNt0ZcVcTAhqA+M2dGpj/yX/WUzqIYt8V3DEvS2Zg+Kz/d7g/dcn7LRsVbibUxreVVVDwOBlkNrGC5I9qDLX0Pi0iwJEZPN3oU07Um1XZhwxJNC5dxisQNUNCCy/qVkvxA7QzKOkvY4hTCZrWWfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741604931; c=relaxed/simple;
	bh=ja+PfpKe2KAlrLbOEo5HG5kWPLYBNJfeN25ykOkO4YY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JuRAjZJb1wXf0JnkaWtbvUqeMZolfVtFV5AncrFe1Zm2HNWfb4HwVCTxvMHku2y23wcB1stU5rDGFXkFFApvFi2KWsZ/FSAuGGjIVDOZKz3mTVxyrRhElL4mGVccpV+C7+cb2AAgjQ8S2IHKSfwml5DfOsyntYMaHmakIUR42ZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v5MaXLFh; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymBD7gsd3nQBT51YiWsqkrrasSc2GWT9IO2lDmYtGKmQkSvbIMd+A0oPi7KzXK12Dz3Nycn8FStz+hygLn0P81snLGNHL/dZ9higk/NbgAS9B+WtEGySdVYUCoII1EXUBpteup5CeQGMS9EgkH5YyuxvPkOlJOCsNgDTTMS2IrvPInNrUcrQ7oqheOZdU9/pxtUDyxYaSsuazioNB588cu0/mM14WY8JeU6nMhgWxgj2K1uibTEQHLKmwemHMmO61FaK4TFwm8OX1RH/p0yxa1DcyE8/B9fX58J9uUBB5Sy1vpGDc4Kbre51+b7fKk1JcVjQ7ZLZU6X/KbztD4Pr5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjt824qT4DNHD1kx0siqH6OBJu0sRIzi3ZdQjd3QcpA=;
 b=Vp5FV+l/ySfcEYYD9CNOcnRN9PIgk0fsVYfUPBM/UdgpvvoMGn70iYqAOuJ1fwmAikqDLmYstqMVyyqJ3dTh8H5EuVnQ09dmb1NWJuTZERhbBw9GJnmr5B/YTSNlqp7aHIetZWeoApF51fD2NbutaS+Ni16NOuKEZolzv8RQQKE+MbAq61/durCLoRed5Q3K3MQSRlJDlacBzm2KVwrCxVwZJFWM3R2Mmj0GcPDtPH2N/JFJvHqN5vnWAd2cWy1FLSjMYPY0hPph42T8tqxf9DfFnCmcMnpespq7oRca2wG+MkYP8VaF6xUXYTIi2fXdBFLMM4QSV/Qhdw/0Ao167A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjt824qT4DNHD1kx0siqH6OBJu0sRIzi3ZdQjd3QcpA=;
 b=v5MaXLFhZ4OJJYDV1yIFyNTmPq2S761VJj2wwajllFVmJTOjffxgbBGvbsKBF0GnZD7LZxfqOxWPWZVq/pBYSvRlINuWdg35nQFJav5jquUe96pHfvmGvbcwaCvQ3nG/hpSz8go8Efdab695kXgMw1Q6pHQsNvcS5wVv8C2NGTo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 11:08:46 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 11:08:45 +0000
Message-ID: <d8be26ad-763b-4ab0-9f57-cfafad792194@amd.com>
Date: Mon, 10 Mar 2025 16:38:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] perf: Rename perf_event_exit_task(.child)
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, lucas.demarchi@intel.com, linux-kernel@vger.kernel.org,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250307193305.486326750@infradead.org>
 <20250307193723.417881572@infradead.org>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20250307193723.417881572@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::6) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b08d9c7-37a4-4415-8af5-08dd5fc3ece6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzRnaWNSNDB4T3I3bTYwZUhpcnhZcHRWbnBNWFFEMjVQOHhCTDB6bW5lZXEv?=
 =?utf-8?B?NFpUejRKSEJYQkR1SCtHZExMMjJZdUF5cHQzV1dsQ04xM3NlRmlGcHAzbzVE?=
 =?utf-8?B?dWtaMzllendMOUNtZ1lBWEFTcVByai9jNUZTRklkU3dwRlRON1ZWeGl4Q01x?=
 =?utf-8?B?L0FON3hEZU9EdW55dWsyOUR4OUhhTUljWkdmS0RqNXorTERJelNCMVJibjgx?=
 =?utf-8?B?ZDZCRWlJREpRNTNQbWFRMmd2QTl4U3JHcU5aQWxHNStlWFJCV3VNMHJhcFRE?=
 =?utf-8?B?L01xZmIySzYrNTNqNGp4RVhUN25zcjlDU0RTclZ1Wk5pTmNmQnNNSzhaR3BY?=
 =?utf-8?B?YmwzaFhpRXIySFdMVHBONlExMzZLaXVsc1B6R0lyVkEwUnF1WTBzekp0VWxC?=
 =?utf-8?B?NDNScjZtSjFSSU44Nmh6VkYwb2kxbElXZG5oLzdOcVpiTFBqZEExREFENFQ2?=
 =?utf-8?B?ckx3ZGdaaEhTUDhwTTM1dks4bW95VWZ0MERDQWpoTXBZNUNtMUdKUWZLN0pI?=
 =?utf-8?B?Q0pvdktrMFlDSUc5bjJaaDFvRFhzbjFkNnlVeFF5aElXR3prdnpFMExBbzl0?=
 =?utf-8?B?MXdMODZCcEMyZ2kxZ3ZkTmMzUTJiejhlWnRaVjhjbFBzSlR4MTYwT1ZnVWRX?=
 =?utf-8?B?YUF0RjB2VHp0aEtFaVdGeUJpRmFlK1NxOXNwaU5jSU9DRGI0b0VWYk9vUjJZ?=
 =?utf-8?B?REVGbllGcmtNZnJUSEFGTytJTmM4d1k5NFNsK2xQdUp4ZStkOURRWkFQbXZu?=
 =?utf-8?B?MFA0RkVHaGpuN3g2Z0orTzVHRUJnNzhpV0NnYmxXQXcrRVRldTEyWkNRZXFt?=
 =?utf-8?B?N3k4RHNvd0tvanVJT3VLMTdhWHRla0V2N2VvR2F1TWZyYXN3ODB0Ymo0UUhl?=
 =?utf-8?B?Q1R2WjFwcFRVdGF3UHJnSXNrU2JtSHVXeHdRamUwYXhBZTZwVE1HWkd4V1h0?=
 =?utf-8?B?Q2FaMkNSQzVxMnRMajg4SWtRRm9kOXZ5YkdjcUx1NzMyaHVnMFVNczhGS2FH?=
 =?utf-8?B?Rkxpc0pSOS9nSGpuY2tuaVd6d1VQV2J2ZHRvSEFHWGRJZXZGaS82ZXkvVU9P?=
 =?utf-8?B?L2lDNWJjZ2ZKKytqSys2eTlXdVNIcUVXejZEYUJ0ZGRrQ1lXcEdNeCtVNGRq?=
 =?utf-8?B?TExPUXpsSXVNa2l2ZVdCYktFTGVQTG1DL1F2WGNXN1kzdU1KcGFiTmswMFdn?=
 =?utf-8?B?Nnp3eTJEZ1ArMmUvUHU4bTFnc0JnS3NOQ1BWZm1HQm02YStUdnA2QnY5YXNS?=
 =?utf-8?B?OU5mUCtQSFUxU2J0dG1XTXlRUXlTRXY3cmVtOEZ6MnZTdm41M2xPQXRwVzd3?=
 =?utf-8?B?ZHlnWFlYU2tHenFCbCtVczlXdnE4MGpVOHlXSFRmZEpQWGFtUm9SeGtudjRW?=
 =?utf-8?B?WG5rOGFPeVVFaDBlcVlOMnBTOXkwSUxkS2xybERFWlFpaHVuL3p3WGVON3RY?=
 =?utf-8?B?V1BLMjlmY3dGVTQvejhFV3orMmJUU2FzaUlDeElIWWw3SEljWGhQUU92WDZs?=
 =?utf-8?B?VlMvQjhDVENLZERWbWoxb25tZ3IyRzVvMUVueDcwWUw4ZXFtRnBZRTYyWkJI?=
 =?utf-8?B?TEpHbDJ1ekdXQ1J0MGxDSGNlMVRQckxSRFdod2tqcWMwZ0MvU0poWjR6amYr?=
 =?utf-8?B?VTJmUzBhT0xUamJsQzl3N3A0VUNBMnpTaW1uZ2lyUWZmTGdIdzFxc3FHZ1Qr?=
 =?utf-8?B?YzEyOWhQUVc1dXhUSnVORm9DVmluaFZ5RFpYNkFpalFVMEp0UTdCRHBFQjRa?=
 =?utf-8?B?MEhVL254dnRwZ0g0eHpLOGpBMmFtMDNLTUU5R0ZkWnZRZUFybGhjYkloUjRY?=
 =?utf-8?B?cTZrVDJKa2RlaWpSSWdJSzJlelN1SHVoR0cxZkRXdU9KNUludVRZQ3pUSVZh?=
 =?utf-8?Q?hEieeiwsPWbKw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUFoVi9Pd0JQbk1JbWlKY2xkWkNOS2V3a2xWc0xEbEUwVXhJM1RxTXlSNUhT?=
 =?utf-8?B?d0NBRm0wYXhzdmJKTDNIVklQTGFldzV3ai9kRGRhVldDUHBOS2Q4a3R4anRY?=
 =?utf-8?B?cnB0emROQ1h2NEVBZi9NUDV0VDNteXBBam8zck5tZkVsYnVqejltNll6a3NF?=
 =?utf-8?B?cGdCWnc0RWUyR1NMYnNVUFNkWkpEaGlWbllRK0V1WmZDWnY1enBGeWlWWmVX?=
 =?utf-8?B?Mzl0RmloMjhrS242YkhvOXFPMG9lcE5qdXMvSWs3cnU4SVZBMUgxdDlveVF6?=
 =?utf-8?B?SFEyaWpwVjFIOXdLemJLd25ocm1RVDdSNm5QVkU1dXlsejRMaCtLQXBJMTF5?=
 =?utf-8?B?UnlISGM0TFZKOUd4c1FRK0J4cGNWMmJZR1B0dHZRZ001cUJ3U3ZyZ2dPWnZl?=
 =?utf-8?B?dkUzZUlQaFpTZWYrUFNEUWgvS0ZSUkZkNVo2V1ozbmc2NDdpMGFiQ2xTcVJa?=
 =?utf-8?B?dVBXN095U2lycU9tZ2dRaGM0MTYyUEx5SzZSWXF6SURzMU44T1NwWjVxKzQ3?=
 =?utf-8?B?em9RZTNRSHdRV1pMTmR4NklPUEpyRE1HOThVMktLYTk1ZXVKMWhpR0Fuc25P?=
 =?utf-8?B?SXQ2bnRGd1FSbUpLTjhIVjdVdzJXaFhpRVhsNWt2aXlKNVNFczVLWEJ5c1Mw?=
 =?utf-8?B?ZmhZVFhMMFZwQ3VCOU1uRTBGWWdWUmNSWHRNYnNVQXZJN1BYcU9xL3R5cEpS?=
 =?utf-8?B?ME9SSmVpRk5lN0hVc3NWOFVJTmdtKzBXUjl1ekVkUFltZnBXb0ZVTlAwVlNN?=
 =?utf-8?B?a0NuZlByOEZLbmQxTWx5bnNIcFNqOHNsdDZteFJWb2c3UlNaRHpaL0dpV1NU?=
 =?utf-8?B?TjJJZUtKUWZYaWRUZ2dLRzNpaFdud0R2ZUJOUVlxdEFraGM3eGVNcXAyYkN2?=
 =?utf-8?B?eW9uWEtJcmwxaUNoSzJHcWdMZGxDTy81elNTYjVKakNiOUpnZUIxRjV6V2RM?=
 =?utf-8?B?RmMzZkxIRnNPSExqOGlXWTlpcDF2ZkpLVDJ2ZGFobUQxSXBPS1QveG1pRHFR?=
 =?utf-8?B?em5peEN2Vk8rOUZtaGUwd3RTdm5Mc2hJbkdUTW9oSEVjQXhNK2xjQUxESmsx?=
 =?utf-8?B?RUVXZm9EZW10amxQdDVubDJ3VjJHc05YKy95OXEvbXFCZllGWlBlVlFJVTFB?=
 =?utf-8?B?QmJxMXpycVZaYUdJTFB6ZTJKSHVVSDliTkJlTzd6bGJ1RlA4bGdRTVBldlRm?=
 =?utf-8?B?c0NGY08xUWo4WDN0TzdtTVpDTGhUWllQaENyYVBvNDlXdjFFWG5XWllIZkZ3?=
 =?utf-8?B?MTIzMGZCK2JuM3RwTnNvTFM3bGExKzN5ZjNGVm01ajBORDE1NklOYnM0dWJo?=
 =?utf-8?B?RktPcW4vNEFxcDJKWVl3ejgyY2hvTW5YRHdoanArSDJ1bVkwUnMzcnVIVmsv?=
 =?utf-8?B?cDdJYktLRVd3Rkk2eHhtYzF0N2hZOWFpZHRDcjJKNC9halVtcTRNblB3cFk0?=
 =?utf-8?B?SXRWNG5QdDVvbnZOdmpXSTdiQVNCUk5WS3FNcUtXMlhKVm5mRFl4VVJocmNa?=
 =?utf-8?B?dElRSUdBZ0FkZEhuajJVNmovckdPdkJWaGhRRTFCZ0FmQ05sdnVpWFVieFQv?=
 =?utf-8?B?S25RVXRqaTZSWE5ncjlmV2pjbXVNekdRRWFXMGZRSGxpNXUrNXZuZDZKR0w4?=
 =?utf-8?B?TVRYSE9BclBuRmFBYnl1QTFuWU9kZzlaaVRBMzJEQ0JxUEYrb1NJalZmRUcx?=
 =?utf-8?B?ZklBbUVPQ211Skg0dUVaeXFCNEZabEhucHpiV0V1VnpyRmdoMld2VnlLNWE0?=
 =?utf-8?B?eXFEeHEya1J3Y05ZK0RkdzAxSStGaUQ2NFEyZ1ZXL1FCaS94K0ZCV1RaYUw2?=
 =?utf-8?B?NWhEU01NMU5rekpBNzNDN0RIWS9uSnFiNE81ZGVyUWRCNUJsbEpVTVJQWk9z?=
 =?utf-8?B?QlBteXZSaFpqS0VUMFFxQWVFV3g0Z0V6SlFrVDNmUkZwOEFldXBSVHFuV1dQ?=
 =?utf-8?B?ejgzckF2TDk1YlJzeUt4c2J6dnVUWWo2NmNNUzBwZFZuSXpLVklIazJ0clFV?=
 =?utf-8?B?elgrNTdvR2hGWVQzUWx3eGVYS0tDbVlyNEJSSzBDVTZkWVd0MDB1RC83M1pB?=
 =?utf-8?B?OWI1WDBRV1NCYzNpaDM5c0dta2JYTytjMmhkK2JFUURmUUFrOUVZZ2gwYlZZ?=
 =?utf-8?Q?WmzO4mztbTLsGOkDbY5ysrbsL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b08d9c7-37a4-4415-8af5-08dd5fc3ece6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 11:08:45.7893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukW/KG/6N0X1ChRmEsKsqERFHy0ItMLvtep9rqdPmvEiUVx5xCiK/WEXnICZ3WBajH7JUEFyGnTC12zXMArZoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354

Hi Peter,

On 08-Mar-25 1:03 AM, Peter Zijlstra wrote:
> The task passed to perf_event_exit_task() is not a child, it is
> current. Fix this confusing naming, since much of the rest of the code
> also relies on it being current.
> 
> Specifically, both exec() and exit() callers use it with current as
> the argument.

...

> -static void perf_event_exit_task_context(struct task_struct *child, bool exit)
> +static void perf_event_exit_task_context(struct task_struct *task, bool exit)
>  {
> -	struct perf_event_context *child_ctx, *clone_ctx = NULL;
> +	struct perf_event_context *ctx, *clone_ctx = NULL;
>  	struct perf_event *child_event, *next;
>  
> -	WARN_ON_ONCE(child != current);
> +	WARN_ON_ONCE(task != current);

exec() codepath (i.e. copy_process()) passes child pointer, not 'current'.

Thanks,
Ravi

