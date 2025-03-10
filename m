Return-Path: <linux-kernel+bounces-554574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FEEA59A16
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A783E166196
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD3022D7BE;
	Mon, 10 Mar 2025 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UZjlPBun"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E607F2206BE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741620959; cv=fail; b=RlV5aPwWZjCyKQVHNNkIpg2YeEBQHaRyquT2P70He+3uTPGc6qZptylhcWrg7wVAQAxAtFzm6QXNRa+/27Fp0w3N35XNSGD8ttTLuTUin6YmUl8rhB21O/9N+dyfDc9JbJ5cCbPy3dEqW/cJj+Vi3EOcud2ABYouq7Y4Z67HJbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741620959; c=relaxed/simple;
	bh=GRJ51xxth75v7MGgsdsJkhyyIblNfCVz3A+yoPmd0nM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GLCGS4KIkN341quTefd40hQihr2yXYzy2kZlI9tlUTYjg7HGNyvJo/biiKuu9SVr2D8Z5XZnE7poHQjR+/T0YDmUk8CG7392Z/AF9huzAf7UKY8oPIu0MsmLb+H87nQksDZzyzBG7oSy/Pg9uO61FmAHR/1jsAT9IpXLZrDy3kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UZjlPBun; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=piWASN3m/NqJmFgm6ZB3nkqf/EN6zPNtZicPwMD0U9z/8TDmeJvuDYrvjabOnD4A1zvYIfR/0B+CtFLmOPBhoStWYiT/bvAEC/RniPC48teOTnHpw7143dBHdz9GvjzrsHi9CGw1DOTvNmOq9b2L4jsEq6COkPrFRjGwhNEQFfHDi003dB0hY61s4X4oeUV9ULwmDR8Ky1viysIxJWXNSQ4Jk1/4Wmnc/71pujYPwbGGxwNiaNIfbpXyl7mnmqCED0dLgvuz/rCq8pKuze6l1bvLSXClcfeP01BXJu1dgQWuQuV/9psyK+nXZLr2RONf19UGef8TrFMwRK3xFsgDFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HgnLvs4yaRPvlB79AQnRhuyxsNN2GPuHck3m5gtWJw=;
 b=v9Zfh71O/d3pFyzNhOHigpS7mbUsm9CdZtycjGk53RkXfeLWzW7hiN7kTNxC+ftmzt/E1lkQavwJqdWxQLIdHVOSd2CowGnKX3UP+pjHG/VCXOHRVuivXxyUd5FnLLQaTKU/ggQgEPnGwMX4jLEMFPZMpopGEDwHvAq5dfsO7uJdlYBDW0l3n0t1n82sN0TvLvD2uZIQwyU4BomHppiqpFxaqDEEaap1fthZtG8hD5Kx8SsbyVs0XLCnMJx2OPR7RvFbYZtD/cLsHhxYqMfQDSm68467/KUplayWg09/fe6tpqJWfDtq5rB6qCMlJbW9K4zSTsQIdoNEBLW0bXLgrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HgnLvs4yaRPvlB79AQnRhuyxsNN2GPuHck3m5gtWJw=;
 b=UZjlPBunfhZOYgXsU+bso6od78lzh8cB56S7uWXIULGy2MYutKPH0sz1ycC4tIrDBSMuzBMG7JJH/zdOpgeaoVgrT5YU0udGEMUpBKW/lb+WQ8N34ZSHH1gmbszwcV+JodMn2cWT++UASmq++YvUFzlcD0myGstMjt17KAst/Vw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MW4PR12MB6681.namprd12.prod.outlook.com (2603:10b6:303:1e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 15:35:56 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 15:35:55 +0000
Message-ID: <0f36ca48-09ab-4fca-8a8d-7ed3b2abc056@amd.com>
Date: Mon, 10 Mar 2025 21:05:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] perf: Make perf_pmu_unregister() useable
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, lucas.demarchi@intel.com, linux-kernel@vger.kernel.org,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250307193305.486326750@infradead.org>
 <20250307193723.525402029@infradead.org>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20250307193723.525402029@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0046.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::15)
 To PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|MW4PR12MB6681:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f1c4e7b-cac1-43a9-e782-08dd5fe93f94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXJGK1hxVkFIM2s4KzZGaTZJbTBLSjNlR01CM080OHhNWjNlMnJqS1ZTNWdN?=
 =?utf-8?B?eTRjNnM2RFV1U3l6d1Q4UHdNU0lQOVdac0wzYTVNVU9tYWdJMW14bEllV2JI?=
 =?utf-8?B?NVZrNC90SlhyS2Z2T3hLcFpSQUVrblN2ait3ZEp3ajZmeXJCQlh6UFVmRWZQ?=
 =?utf-8?B?dVJjaWdqTXQyQThHa3UwV0V3cDVyOGJ3OVhqd1dGcDZaQStTRjdlR0dSdGhS?=
 =?utf-8?B?c3JzZEhnaXl5ZUg1Rm82cUdITGJqRHlPbG9sNXFmZnRMRVUrdzlYQXBxQXlR?=
 =?utf-8?B?K2lncWt4QkRDRW9ZSThUVEtmUGd1a1hjZmFtbEFYdVhJa2ZXbkhQWHBSV1RE?=
 =?utf-8?B?Ky9OZDN1WlJJMVlGem85RUFWVS9zWXREek8rbFk4ZVlzcmxrck1CNnc0TjFT?=
 =?utf-8?B?eVFhYWQrelVhR2J1RHlndkVHL3ZGUVRUMUZEdm5uUVVmTTVXY1ZWVTk0c3l2?=
 =?utf-8?B?ZHR3V0p5TEFrN3dzTitjREF5S1VUS085a2xMcGI3SVVFYXZMUENEQVhUbzRw?=
 =?utf-8?B?VnZoNFg0WWw3UjJXRjh5azhjT00xVG1WSENhTW9SRnJRbG9LVEYrZytVSXJR?=
 =?utf-8?B?dXBnOGlzcXVjV1U2a1RZdnl5c3RiQTZieEZzc1gyVi9zL2R3ZjJGa1E0bXVS?=
 =?utf-8?B?R3lianlZdzZCZUtoTHp2Vm5oREhIR3VtY3RZczZJUy9RMitFUDdlRkRnNEhC?=
 =?utf-8?B?MTcyYnJ4TWcrZ0hNYjhrUU5xY0xISXFad2gxaWNadC9TVS9pRzFBbjVqNlNj?=
 =?utf-8?B?emkveVdmSUpwcTV4b201S2YwVHN4bGlCZUN4Yit1RjR4YmR4RnBreFl6V1Bl?=
 =?utf-8?B?VHhlbHgraXVaNVFLMlgyMDZiSG8wRnRvV0MyU1Z6SjlPRjc4RDhtamtmS0Rv?=
 =?utf-8?B?REtLcEdqSXdvWUMrQzNQK3ZVQ0xsRG9oU3ZGaGNPU3FJcjRBYmJzc1NOVnht?=
 =?utf-8?B?VVRGaDdmczBNZXhCMHNPQ0NZcVhudUhkZVpKZHBlcGQ4ZitlOWxDMFp6U2ta?=
 =?utf-8?B?bU1hYVgrdUlpUXYxUnpaNmRTK3hteGZUQnlFMkxKbllKbzVxRHorNlNDSGcv?=
 =?utf-8?B?Tm1iWXRNVHFPdkhhaERwWDZjL245R1lGeGQzU2lpazNhTFF0N0Q1NTEzSkty?=
 =?utf-8?B?cDBtZTFzbnlnOWovNVVLMDVleGVTL09TYnRtcWRZWDJ6QmhCUGVBQlpVYnJ4?=
 =?utf-8?B?aUtGejZRYlV0THp1K2dUZHNkckZsNUVOdEF2NnZkRFF6UnlFZ2tHZklQOXAr?=
 =?utf-8?B?MElPdVM4VlZuQzRhU3dJQlZ6V01iZGRhV2FoTHBleHRRQzVWVyttMHI1N3Qv?=
 =?utf-8?B?NGZhejFWd3g3SXVWbDEyRk5sSXM5RDBBRWxFVFM1UDJkcjJVaExrWWthcXgy?=
 =?utf-8?B?dmJUeTY4UTBmZ1R6bHY3SThKYktQSGlwakFCTUwyZlZDR2pVVlZqTUhINFAv?=
 =?utf-8?B?L1prODZUR0xhYnFmc2w5TFQ0OGZJbmVObnlVaGF1akNCZmRmQ0cyR1dFd3l5?=
 =?utf-8?B?MS8zV0RTOHVMcTd0d25zeUV5T3hYdVBmWWVpeDFUZjg2QmVJUytRT25FbmVL?=
 =?utf-8?B?c1ZoS3JLNmRwTHA3SUZtNTZxb3Q1dzJmT3U5dXpTaUJYY09PSE4xdDliQkI5?=
 =?utf-8?B?OGtHc1MwNUZEQ3I4WE0zbmtjelR2eHNZdmMwQStuY25BWk9CNHJxc21ZME41?=
 =?utf-8?B?c3dUNUhyLzBJMjN5bjZlbEFnRGh5dURhOHRPdGpQbTQwM2hmSkgxUmVLUUxv?=
 =?utf-8?B?dGxZVVBQOU5ZcEtYZWNQK05DQndoWVMvY2dMR1EvcXZwSG8vYmpkUzk3YnhX?=
 =?utf-8?B?RjF2VFN3ZFRwZ1pUcXhLZ3ZMQnpNVXRINFM4TXhhTmYvU3dLdWdCMGtVZ0Ru?=
 =?utf-8?Q?usy+Agr2QZHJM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTJYOHZjN2tFRVBWUjBvaXZZVlpKVGEzdllVUjVmYlJJOWVkVUxKTjNzK0FC?=
 =?utf-8?B?aDRvSnM2UFprOTh5UklXYWtRMlRVMHA3V3RFTGNjcUloWGVmcE5nM0NTS1pS?=
 =?utf-8?B?cEZxcEJrOW1SZk82L0RsRFBSdXQ0WXNWQWU1ZUprMnB0amxXdjRNZmNVcmpM?=
 =?utf-8?B?SUNwaSthcEtRNC84YldOUDM5Zk80TmNpVDZwdllBZ3N3dkxlc3JYeWlqRkRZ?=
 =?utf-8?B?c2hBZDZuSjlGS2wrcFpqcUpubXdKT1lyYkxLM0tpS0h0NXBXZGp5dDlyZnhU?=
 =?utf-8?B?d0tVNDdoVlYrVlA3Wi9YRXBKeE9hWG5lUE9sTVV1ODZ2Mmx1Y1ZWRHRuMVE0?=
 =?utf-8?B?b0czb1BYVDZYZEZwd0t6bkRWWTh3TnZ4WDM3N3NuRzVFS0NsU3EraDRDM0l6?=
 =?utf-8?B?bzBqazdMbXZkT1N1S2NMVHNxQWJyWEJZQ1pZOHl5MkpjcTVkL1lDYWkwWkp6?=
 =?utf-8?B?bzhZVWlrc2ZmRFUyaFJHOEN3VDJFaFhFYmJjK29LQnhMS29CWEx0SFN6OUk0?=
 =?utf-8?B?SXhtSGdQWTUyVTU4UjVERDJ5QVFzRHhPbjU3UzhueE5FSERzcDJxVGViM3Ft?=
 =?utf-8?B?Qm10WDEveGtLVnZUOGxuVDhxUTJncmtZTVlBUGgyTU8rNFh6YzVrQjU2bUlz?=
 =?utf-8?B?NkppQUlwSWtmMVBiS2pIM3FaRTc3ZFFJNkNScWs4cm1jb1dUcnd3dWxkcWhq?=
 =?utf-8?B?ditXVHIxYTgwVW1UOE9jT2ZhY1ZJMTUxSFBzTDVPbjNQOG5RNURtZmhYdSs5?=
 =?utf-8?B?Q2ZlVlZIbVVoOVFFNWR5cnljVnFYNlVaTVBFS3Y3YTVsUDhYMG1DVjJnNkx6?=
 =?utf-8?B?V2o5YWI1bDZiakxWSnJZMk1VckoweHRzVGlXMFhNU0Y1a2hOc3grTXl2dy84?=
 =?utf-8?B?Z1VTaklEN3ZlRWlSQjZ5Z3lMaDFGL1ZYcm1YUzBiUHdQZWNxdUlsZXh0MEZq?=
 =?utf-8?B?MjU5MzhWekFkUnloVThRaGxKbzVYUXBpKyt1ZTk5ODlySG5LaUEyMUJjMmpJ?=
 =?utf-8?B?QW1ScjgvSVR3YmJ4Rnk2ZHZhK29ocTFWckt4RkZjV1NTanV3NWdTV0RIT0xl?=
 =?utf-8?B?ZDJ2MzZpTHRLdUNLZmJuU3J0cFZPYURNVis3UFNrSktPZHZVN2o2UERQaDZx?=
 =?utf-8?B?aDhGTVRCcjRoaVhQVHMxUEpGYkh5UGFzVktZQjc4ZThxeGZXdFUwcERYTWs1?=
 =?utf-8?B?RzJFY3JvclR2YUhJOFBhWURCWS9wTGpCcFpmcDBhWDNuSDdkRWhBdUxVNDJt?=
 =?utf-8?B?OFFaWHNJT1NMemdKdEJTU3J5UjR5YmxlVUhLSi80NjVGRGZjZGcySzlEN3lk?=
 =?utf-8?B?Z1A1SzE1THZxZWJ4Tmt3eWRqQ3huMlNKeVVEWkV6OUFHRjVlWS81UndOa1FZ?=
 =?utf-8?B?bUNpNUhVZ0txTjZtaW9ZWS9TNDNoeWR3S25VWEtQY0g1MlZnSm5qaG1yaWhH?=
 =?utf-8?B?dmhHaVJvYWRrOTczNVNzWnVZZDJzdklXVVQyUUZMOVFvKzBkY0VqeFJHakVL?=
 =?utf-8?B?SnZKQWNIYzJNa2hOMHBZV1Zac1pnUTNvQi90a0NpZkFQWU9XeUk4R09vZXZ0?=
 =?utf-8?B?WTB5QVRpMjZTdGc4aU9vMmJZY2xKTWhSbHJJV2E0K3RvMTRxdXVWT0V3bEtS?=
 =?utf-8?B?WW16NHJIb0NDTWV2Q0k5YWl5RFB5VW1qQnpWbW40RFNUUStORk94clRVZFo5?=
 =?utf-8?B?QVY2RWtyUGUvUXN6ZDRmeGtzalQ4MG1lVGg2Z1hQL2hIOHFOTlFUVFh0TFh4?=
 =?utf-8?B?YS9NT1hLTzBFTjA2R2xYZytkNFNHUFp4MHg1c3NpWlhkdmxEcnVOdFE2TkVu?=
 =?utf-8?B?RENud0NyT25IdjVOaDlYSGVjdC9FVXJlaEJhZjVORUVsVjR0bDYwRGNXUldO?=
 =?utf-8?B?Ny80NmRzTTVhWWdiYXIwRVFrM2wwV3ZLVjJHV013bEFkckEzbkFIbzd1WWxB?=
 =?utf-8?B?T3plS0h3MEV4MHhVczNXL1BENGNURlZGcVlPYytJejFkVWZyZEpFMTh5bWc3?=
 =?utf-8?B?c2had3k0Y3I3MXlrODhjc3BpZ1dRWDZNQ3dDa0JWUXVUeW9iSHZBTFF3RzFW?=
 =?utf-8?B?SUVaRGE0bFZidVVDWis2NWxsT1JrbENvcXYvbXpRK1luVTlLZ3YrSExyQXlp?=
 =?utf-8?Q?Wy3unHwxuaT9xta6+knSUNKZq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1c4e7b-cac1-43a9-e782-08dd5fe93f94
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 15:35:55.8470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gDngO/gUxDruZvRns3VjD9clHRF5vNqG6P0/vdTMycJx7YQ717vkqCakuQkdXGwFtmA0Ti8n0E+wcjDqE7GOdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6681

> @@ -207,6 +207,7 @@ static void perf_ctx_unlock(struct perf_
>  }
>  
>  #define TASK_TOMBSTONE ((void *)-1L)
> +#define EVENT_TOMBSTONE ((void *)-1L)
>  
>  static bool is_kernel_event(struct perf_event *event)
>  {
> @@ -2348,6 +2349,11 @@ static void perf_child_detach(struct per
>  
>  	sync_child_event(event);
>  	list_del_init(&event->child_list);
> +	/*
> +	 * Cannot set to NULL, as that would confuse the situation vs
> +	 * not being a child event. See for example unaccount_event().
> +	 */
> +	event->parent = EVENT_TOMBSTONE;

This will cause issues where we do `event = event->parent`. No? For ex:

  perf_pmu_unregister()
    ...
      perf_event_exit_event()
        perf_event_wakeup()
          ring_buffer_wakeup()
            if (event->parent)
              event = event->parent;

Thanks,
Ravi

