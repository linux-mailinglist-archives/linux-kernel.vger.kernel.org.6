Return-Path: <linux-kernel+bounces-576837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C387A714FE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 499033B4A31
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C7F1C701C;
	Wed, 26 Mar 2025 10:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hxozztyi"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CB01B21A7
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742985420; cv=fail; b=XPFBdfN9mNB5NG0eWSV6BBbpnrsZFM8kQMYW1LRIP0vikht80MyFzdK48MGuEWeVdc1xSKMJJUoYfYtLwuKsifgxQ6O8AgOBIOcjoAYKnHzHe1fHIwbCetRFEDE+Ip8lhkPz/nifRHjIIu2rxY68SMKH/UwNPGPjHLAgIn58MnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742985420; c=relaxed/simple;
	bh=J4YEI3CHU3hLbGS3PZ1jrHdlkMG/qQWPhSDRT+0M+cc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hsv/ABM3bRnZzoUq+Dv2wIvo+t71Dgpg7cND8fiZsR9WRPCkwXtxqpR1ECAZvsF9tUL4X0YNl30wV4+5Hkxss/shQ8e+IwDe319ztXFEKlmtzoqfgN5Xvldy/iKd0EcMiy4v14vHXO/lpMNEzZkZwfaT7E8QvrSlWzeXFvU0u7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hxozztyi; arc=fail smtp.client-ip=40.107.236.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFxyTyxkc02jmdi4hgX9P/u0o/KOToY0IvO019F+XNCL2r4V+xczA9skYc2uJVs/5wKWMbOpdUOWVTIzNpNiZbJodjkkYyx13qayvtIZFuXAznP0/w3k3Gg9v44yRZdqev0wyQPv12M4B6nmpsD/w6a422SttxXwpDGbSL3NnRxTozdp/FAbPrf2xe/37qnwi4tNxwto8u21cPstlw4oV+5voZCSailvceoMXSdjxLHTvVN46oo5zyBJO45O8Dejafyq2QAzIahmJFE8dsqIZhTnIN7zXGfR1gNOQnGtN/OM0ht/2eZ8Qtvb76pLpQL+yfzJkrl6WfGSoavcW4KsjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdSqdtcVzaYc3we2ASmChAJvhpgb3Fo1tEkTa2aZCzo=;
 b=mBRWSM7eZmdEhFt/Lf1hhduNbQaCfvbnnkkn5va2kWjmRQfZwInwRulvuTIpka45qSNxKYW4hZ3iYdyC+Dq30HEK9wD8L103/UzqHnj+cMKpPMj5NRXmwawLWc62gcfNwa5Fcb3ww5ywO9vGngqun7DJp5vOjyVcjPKrkRSUcnTNNFhMI5G3ndQ5jFzzM1e9L0Meeqiq4sjy296oiAn0iBilHq17wc3Dwv/56fI6LVb5VSzSXtH6Fd/UJ9hkGp8RvQzUtgnQsyAnE0x7D6LRvR1IauNAne5q/cVH+v8ai477pm10ODCmubv/RUoZFoHzb65l+3FeVoj9qkL/4gpejQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdSqdtcVzaYc3we2ASmChAJvhpgb3Fo1tEkTa2aZCzo=;
 b=Hxozztyi9U2fzrXeSkOU4GPBUron1TKUc63V7s1ej37LqfKwdX0sVH4lq8MAZ1G3NPEYx/pKfTCSI6lcOrdO3NR6fQNqQJ1v4kctJnkiIQYdNbbh3MltALx7A9k7RTT/l893VvwcxBQkgNuMfpcvb9vZqaFKDXxYgLEHUA4ln/6z7EBQY93LnQWm/EbLWCcdLmG24FIoRRgC9o0r2+1/4lKTKqWQxRYFR+tH03Me1BMbfUx1r1S906qF2wwb3zQ9UzTnRVNdBpAc/HL6MYlu4vBhWIGi5UkyTv+XB1G8l/Wn09+VGjtDJazrrZbiROc1ZU0CPZ9P+0DuFAbH8CDW9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 by DS4PR12MB9611.namprd12.prod.outlook.com (2603:10b6:8:277::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 10:36:54 +0000
Received: from SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868]) by SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868%6]) with mapi id 15.20.8534.031; Wed, 26 Mar 2025
 10:36:54 +0000
Message-ID: <c6d996b4-5e44-4066-964c-5a2a27dfaa6a@nvidia.com>
Date: Wed, 26 Mar 2025 21:36:49 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: commit 7ffb791423c7 breaks steam game
To: Bert Karwatzki <spasswolf@web.de>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
References: <20250322122351.3268-1-spasswolf@web.de>
 <688f2757-e364-45db-ad54-daa6ff1c4f3c@nvidia.com>
 <6e8ad3cd27b570aaefd85395810cc90bb3120734.camel@web.de>
 <7cdbe06c-1586-4112-8d27-defa89c368e9@amd.com>
 <b1d72b95-5b5f-4954-923f-8eebc7909c4d@nvidia.com>
 <938c2cbd-c47f-4925-ba82-94eef54d9ebc@amd.com>
 <261e7069-9f65-4a89-95cb-25c224ff04f1@nvidia.com>
 <eb041c610719c8275d321c4c420c0b006d31d9f4.camel@web.de>
 <76672910-423c-4664-a1bd-da5c1d7d6afd@nvidia.com>
 <a9f37e3b-2192-42d2-8d5d-c38c0d3fe509@nvidia.com>
 <79a263b2af01e7ed6594ca5896048bd9d7aae35e.camel@web.de>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <79a263b2af01e7ed6594ca5896048bd9d7aae35e.camel@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0050.prod.exchangelabs.com (2603:10b6:a03:94::27)
 To SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB7272:EE_|DS4PR12MB9611:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ecf2e1d-d9af-4bcc-556c-08dd6c522081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmxvbXVJemRYQzQ5djdKbktrTmhDODc2UGRoUnBZQ0FQb2xkQVY4UDB4Q3dl?=
 =?utf-8?B?bVRIRSsydGkyQSszSEU1NUNNbEg0QjF0ZEZQNU5yZEo0VHVkdUNwVWtlSTZk?=
 =?utf-8?B?OUZvdGJIK0JMMFhzRHhDZW13ZHE2UnMyMTUzenY2SUFxWXIxZVdjdkVmS3dV?=
 =?utf-8?B?RzZvc3E0R1lZWElVOXU2MVJZRHo1ZlRxT1hoTlVJcERTUzFYSzdNbTJWTGx3?=
 =?utf-8?B?SkJyaDRYQmNTK1l6SitmNC9vVis3Q3RpQUFmcEptN3BLNktjWStPQ3ZGMkUz?=
 =?utf-8?B?UUErRUpGVTkzQjg0QXdFYmZWRTJIZzU0Q3doUkdHT2JTbnRDckNSOEphOEFG?=
 =?utf-8?B?V3RPTFJiYjQvNktEbit4VldNbWlPVDN1NGt3R1IzN2pCemN1aGxGSExsM2pk?=
 =?utf-8?B?enJoTmIxdzZVZ1dydEE0Z0p4M29RdG4vRklXUFRPUkdvNi90YlEwdGVnSlpl?=
 =?utf-8?B?Tm15aUZOTWVjdmxhbWcyVXNHWEQ0bEIybXZ1NXpmMlBCRDhnWkt5NGt2bkZn?=
 =?utf-8?B?TlhScUpaUjBtc2tpN2liVUFRTWVlZHFLVisxQzgyRm53OWVPY1ZlZmlXWjhJ?=
 =?utf-8?B?eStwYk4xRjY2MTYwWThQUWJUc0xvYUxzeDc1RWdGSEtlZFUzdEg0KzdYaWdj?=
 =?utf-8?B?cjg2U0lmTXp1V3FXcUtlQlhweXVBb3pDSzYvdDFUeVRNWDgrRENZbW9WVzg2?=
 =?utf-8?B?dUhDY0RrSkEzRlRhWU9XUXQ0eFhzNFlRQzViTWdTdTF5b3NzYU13Y2duZ05R?=
 =?utf-8?B?OGhQM1NVNDZYK0diRllLdWs1M1FrZC9hQ1VFZzNJRHFFNVIxK1BpNVRUb2tD?=
 =?utf-8?B?d243UjE4ZUZRNEVZQWJvQm56RjU0TzV3SE1hWTNJVTM4STFCdzc1d0ZQcytj?=
 =?utf-8?B?bXhFL3VYeExadmJlc3BKMi9YeDgvM1FwMmEwVXRLNFVNaGNLOGRtM3JYakFq?=
 =?utf-8?B?eXZsN3QrNHBQZFlGQnFaUDc4WmZ1K0Zlcm9ER0RMNis1bzJ6QTJGU21MUTN2?=
 =?utf-8?B?emdKNWhOcDJWMmhLdmJuczRyQmpTTVRqOWZpenZ1eW9pSUtBNjBVd1h4b3g5?=
 =?utf-8?B?VHhNK2hPNGsvL0ZkSkEvQmlObG1HdXlxcnZ2U0I4dzA2clJwcWcyT1pKOVlq?=
 =?utf-8?B?S0hQSmgwa1ZkaFoyUHBoVmR6MkplODdNMjNYdHk0Wmc2MnRlS3dtN0hTTW9h?=
 =?utf-8?B?WFFoQkwwQms2OUlaK3B6b3pKdGdCekN3U21wamw5RmhaeEphdVU0czVTaFVM?=
 =?utf-8?B?VU5hbHZ5NzY3ajd4NWg3amx6VEgrRGErV2Y2N0Z2MnVFS3ZLRTIwRmFjaHg5?=
 =?utf-8?B?S1h4SVQ5QnVmaHdaSlROclhIZlZwdDNSYlRtcldRQUU4NjRCcjBVYkNud3oy?=
 =?utf-8?B?TisxZVF2U2J2T0VuZENTbTRoVnBLK1c5M1NXbTJ3R0lFMy9sSVRkUVJOeEdn?=
 =?utf-8?B?d3ZUeEZ1SlhVb3UyMHlsdUpnbzk3djNGOGtoNVhncE9HN2tYdkFPZGkrOFJY?=
 =?utf-8?B?UFdhS3Uxc052d3BwNGhCcktJTjhzTS9YWk5VbmdJQUlabW9wS0M4SUhNK09j?=
 =?utf-8?B?QXl0Q01uTmR4R0owQWt3SWN1WWYzekdRMWI3c0d5UW5ZN0tsKzJGNFIxUUVU?=
 =?utf-8?B?NCtxTmZNL0sxRkVtbFJVOTF1Q3FTeENYQnNmc1BmK1luWGl5T0x0ck1teHVo?=
 =?utf-8?B?MFFWL09aOWcydTV2N2VTYUZPbitRNGtTM0Rtb0k5Szl1cW5makVxNzdFTWVB?=
 =?utf-8?B?bzdBaXZEQUg5bDJNTWZ3UHc2Ujd3RnB1Sk12TFR2cEZlZlUzejJRYW5SRlBn?=
 =?utf-8?B?eXREajBuTmpmT0xQR0hZakJ4WGdNUWZtNW83MVJlOUd5WUl1V3JoS0Z4WVps?=
 =?utf-8?B?YjFwRDRXTWVlME1xc0Q4VmxxY01JaWVsZDZoc2E3NHJGVUFYVWpOa2cyZkVD?=
 =?utf-8?Q?uDfssPgxN58=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7272.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1h1bm41NzRTNnRFM3huY1lPbXNNb0t4bjBFTjBpdithWG9JZVA3WEx3a1Bw?=
 =?utf-8?B?QnQvdDZwZVUxczZEdHVLL0NGaUliOTZPUjNVNVpIeE9ENkdoVS9seHZEdEVt?=
 =?utf-8?B?b1dDNWs4Q1U2eXlOekVBMHhjam5ybE1TdTdueXBFTFBBRHcyTlBCamVDQng4?=
 =?utf-8?B?YkoyY2dZaGFGUnFjQ1lZV1lxYnYwcDBZc09qSFdtOEh0WWRYcjZrVkVFWkd1?=
 =?utf-8?B?MVlJdHh5MlZmMkR0YktyWEpNeEtweHJnd1MzamxFOCtCZUl6ZHZZVjBsOEZ2?=
 =?utf-8?B?QUZSYTJRVC9PdTJLMmwwWGJSdS9GbFVkVTdrbG0vZG5RL1NvL3dzbUtYOENz?=
 =?utf-8?B?aUhncTh3YmY3NW5WR0RDM2oyZ09XRFRtWUdaVXhYUjJXVWpDNG9Ed2ZSYmdk?=
 =?utf-8?B?RjQrTE5UcERsaDEwM2hEVkp5MGY5bDJjN2lkdjF6bE1OY3F3YmN5ZzRLNFQv?=
 =?utf-8?B?L09rT21HWGxFM1FvQXo1SGZJQTlDVWMyQktJMmtWUmJNQzdzRzBYSDNhK004?=
 =?utf-8?B?aHB6SWExVDJZQzhHUXpXd2ZLOCtvbjV4dTRxRU1jenlaOGRtNWwxNVp2Zkxj?=
 =?utf-8?B?dWcydlFZR0xhaFFHeExYZkNnaVFFWG1PWThYVEFtREJtN284ZmZDanRsN2h1?=
 =?utf-8?B?cjVGQ1NBWXIvdG16cExDcTlyTmRNcVc0aGpHcm9nN1FHSm9pZzFQaWFSRTFO?=
 =?utf-8?B?Rk0xWm8zVVNYczBySld4cGJuRkpacjIzdXhhYjhSa0hSQThoUXdxOVVkWk12?=
 =?utf-8?B?aU1JK2NGc3VoZENmS0xzMi9jdHEwTWxqa0pXNUtyM25reGFVNmVLNEdISlBs?=
 =?utf-8?B?Ni9EVGROQURKN3NjUmhJRHRYMGF0cHgvSHQwRk1vUVR1bkQ2MVp5WW1WemdH?=
 =?utf-8?B?dFFab09BMHloWW5MbnpQQWpBUlgxdVBlZHp1aDNNRVdZZTBYNmRzWE9yTFRv?=
 =?utf-8?B?MmJWMVVXOWZZaDNmL0Z2YVFwQ0tvbmM3VXpqODE0VWxtb0g4VWNveUhNYnNX?=
 =?utf-8?B?UVRTUi9rTG8vNFkraTVqUmhFZEVqS3JJcG9DVUZEV2cyZWhOZGt1N25WQVow?=
 =?utf-8?B?RkpjNXYrRyt0OVVoZ00zM0hJUU1zNDIxYVBBa0hubGRERTZIcmR6VWtKUkRC?=
 =?utf-8?B?VGNWNWdRc2FuKzU2Tm9WRk1Ub3N1UUZIdkNyM0h0czdwOEdiMHdLK0Q5ZjMr?=
 =?utf-8?B?ZWVIdlpPclRpK1k5YnEwc1I5eS9ydTRhbTQyUUJyczJMY1ZNdEo3UDJZMmVz?=
 =?utf-8?B?M0RHOHZycUFUSy9SY2dWQTN1N0M3QVU2UURqdlpuNmFBU3hzZENDUDd0ZU9h?=
 =?utf-8?B?MWdUUDBtcVZUUVowZy80VnhpVFU1MTNaSVVXSFV4U3JjVTBpTitteXNrV2lZ?=
 =?utf-8?B?OVhHWDR2TWNZek9ScTEyTytWNUpGZWs1dmNYWFduUE1Td3BRb0lMbGNwZmxD?=
 =?utf-8?B?VU0yRWx6Nis5ZGRYK3lzTFRZOVB1OC9RQWhZVmt0RDVFQkJMOW9OdnZSTkVa?=
 =?utf-8?B?cm85clhua0ZaanFyWGN4VTNhRUFjRGlyNGd5bzVJcnByeUpuUUZ6NVlsOUFZ?=
 =?utf-8?B?cGY3cGdneGxsclF3VGs3UTBzNnAwTFNHaElSV3QzaUhvdWpTNklObFdsSUQ3?=
 =?utf-8?B?R0c0ZlN0c2o4NW95LzZubHhMUFFabmxKOWFxcE1oLzcxeVFFZXB0Z1E1My8x?=
 =?utf-8?B?eFV3VXhJQkMvSzdsTVVmUjMwaVJ5cUtZMFZLWWd1UlJleWtDSU5ULzdRYnJQ?=
 =?utf-8?B?ODFxenB0Q1FwQU84Ym1LempTY1hLQ2ZGTWp4UFMwY3J4RU5KYUhyL0tNa21F?=
 =?utf-8?B?QzlzcXFWeHk1aUZhdFhCT0tQNVhaTHphZ0wrbEtZcit0eWMyTDFtVmVtRmds?=
 =?utf-8?B?bnYzdHoxOHlETEplVUFwb3ZVM3RpRmw4RzZIZEcwNkxaZmF2NGtxeVlVTE4z?=
 =?utf-8?B?OThHcmUvbE0vc2EzUWJPTk1ncjN3eDlNWVZhQllJcnFuK0RTODBGdEZySzh6?=
 =?utf-8?B?c3dyRFNsNFFmVHU5MWxHR0hRQWtHOXFZMWlRWXFTSFVZVFhqOU5HNzZhYjla?=
 =?utf-8?B?RVFubGZBdzBsZXA0SUpxdXNmdXEzVmZxcm5wR1VsZ1NBVmxrUlNMd1lZYWdQ?=
 =?utf-8?Q?TD0seqL6q4szmLu1BUGTY5V1z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ecf2e1d-d9af-4bcc-556c-08dd6c522081
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 10:36:54.6228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4I0VJ79b+yaIqyNCK8gxOOARr/Qh4vj/DZ+ICJUBtugzjqZncFjA9aketHWvQ8QBUKWEBrgOqqbk50kpgOiuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9611

On 3/26/25 21:10, Bert Karwatzki wrote:
> Am Mittwoch, dem 26.03.2025 um 12:50 +1100 schrieb Balbir Singh:
>> On 3/26/25 10:43, Balbir Singh wrote:
>>> On 3/26/25 10:21, Bert Karwatzki wrote:
>>>> Am Mittwoch, dem 26.03.2025 um 09:45 +1100 schrieb Balbir Singh:
>>>>>
>>>>>
>>>>> The second region seems to be additional, I suspect that is HMM mapping from kgd2kfd_init_zone_device()
>>>>>
>>>>> Balbir Singh
>>>>>
>>>> Good guess! I inserted a printk into kgd2kfd_init_zone_device():
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>>> index d05d199b5e44..201220e2ac42 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>>> @@ -1049,6 +1049,8 @@ int kgd2kfd_init_zone_device(struct amdgpu_device *adev)
>>>>                 pgmap->range.end = res->end;
>>>>                 pgmap->type = MEMORY_DEVICE_PRIVATE;
>>>>         }
>>>> +       dev_info(adev->dev, "%s: range.start = 0x%llx ranges.end = 0x%llx\n",
>>>> +                       __func__, pgmap->range.start, pgmap->range.end);
>>>>
>>>>         pgmap->nr_range = 1;
>>>>         pgmap->ops = &svm_migrate_pgmap_ops;
>>>>
>>>>
>>>> and get this in the case without nokaslr:
>>>>
>>>> [    T367] amdgpu 0000:03:00.0: kfd_migrate: kgd2kfd_init_zone_device:
>>>> range.start = 0xafe00000000 ranges.end = 0xaffffffffff
>>>>
>>>> and this in the case with nokaslr:
>>>>
>>>> [    T365] amdgpu 0000:03:00.0: kfd_migrate: kgd2kfd_init_zone_device:
>>>> range.start = 0x3ffe00000000 ranges.end = 0x3fffffffffff
>>>>
>>>
>>> So we should ignore the second region then for the purposes of this issue.
>>>
>>> I think this now boils down to
>>>
>>> Why is the dma_get_required_mask set to all of addressable memory (46 bits)
>>> when we have nokaslr
>>>
>>
>> I think I know the root cause of the required_mask going up and hence the
>> use of DMA32
>>
>> 1. HMM calls add_pages()
>> 2. add_pages calls update_end_of_memory_vars()
>> 3. This updates max_pfn and that causes required_mask to go up to 46 bits
>>
>> Do you have CONFIG_HSA_AMD_SVM enabled? Does turning it off, fix the issue?
>>
>> The actual issue is the update of max_pfn.
>>
>> Balbir Singh
>>
> 
> Yes, turning off CONFIG_HSA_AMD_SVM fixes the issue, the strange memory
> resource 
> afe00000000-affffffffff : 0000:03:00.0
> is gone.
> 
> If one would add a max_pyhs_addr argument to devm_request_free_mem_region()
> (which return the resource addr in kgd2kfd_init_zone_device()) one could keep
> the memory below the 44bit limit with CONFIG_HSA_AMD_SVM enabled.
> 

Thanks for reporting the result, does this patch work

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 01ea7c6df303..14f42f8012ab 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -968,8 +968,9 @@ int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
 	WARN_ON_ONCE(ret);
 
 	/* update max_pfn, max_low_pfn and high_memory */
-	update_end_of_memory_vars(start_pfn << PAGE_SHIFT,
-				  nr_pages << PAGE_SHIFT);
+	if (!params->pgmap)
+		update_end_of_memory_vars(start_pfn << PAGE_SHIFT,
+					  nr_pages << PAGE_SHIFT);
 
 	return ret;
 }

It basically prevents max_pfn from moving when the inserted memory is zone_device.

FYI: It's a test patch and will still create issues if the amount of present memory
(physically) is very high, because the driver need to enable use_dma32 in that case.

If you could try this with everything back to the original config with both kaslr/nokaslr that
would be very helpful

Thanks,
Balbir Singh


