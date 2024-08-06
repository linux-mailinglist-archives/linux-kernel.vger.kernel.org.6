Return-Path: <linux-kernel+bounces-275805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC02948A0B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A6A51C232BF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 07:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BF2165F10;
	Tue,  6 Aug 2024 07:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="JWUJtmZo"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2079.outbound.protection.outlook.com [40.107.255.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62337159217
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 07:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722929031; cv=fail; b=L++2Vvxhq9SuunKDOtCMMdeInHlwtVEDQQ3gDb20b+vdlGS+wGH1OPLYN4NhyazyWR81+5PLwxqKuv7JGvKf12NJ9xW3RyIjhwNUj3dyYsHprm6aug0vQonC5cGTdPzfLyFCyc2jNqEPRVe33cxNDOesjAzisHdUTmHTwRYmTwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722929031; c=relaxed/simple;
	bh=ha81jJlO4QPhUutXQ95XceBHRl0qyykTObBlotWv/xs=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=orQXJf0IfT8knxJVHSUgZFXu96frqtxh1cI14foQ2Cc+3qZCK1E9sL0XmnfohsJw0RfGSFBm6wmAHts/HxMRkHsGLNElz8wNjrwwa8OWvJgxjeY721uN3KAuj+QoDLVK8N6KaQ3pPStC/UR2Syx8Si7uKmcctot+ILGnQC+kMh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=JWUJtmZo; arc=fail smtp.client-ip=40.107.255.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOq4QHE5ntCKHl7hPydoZUnxYY4t6qdPRI6jg4aL4wRsH3c7xSxFWT7Wa2mbtKj3GcHpJlPPZBzOLJcQun02ujLNC9yyo/gJqypLzRIaZDrZXLfQ5Ge2BapYIPB4MAUg+ZUgLuIjvp/yqxopRI3+j6F9VWMlEKlIIGeFU8+QMQd7zmor6GqajV4nuzbKZqh4UQXm7DQVnow56bdCQSo7XMUrGUdHg/RzXqnGDJw9ZwMVMWAijQ2/uWpNyWebmo/ALMq1bC2+uVllSceUxsmwPAcbal89ghv20OkR8Zb20XIQTyimbLoCAHnYmUliKhvXtHfY3gRZMP5CB/XyOydzaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPAtVh+87FEkBZsyHwMX7y23Ie8ZMoolgjqjI6LsJyg=;
 b=MBeRowo/OpBYyG8yx4yJUs6BzpoAKWn9hJm3AQ1m4UJZ968NXXE/tz0kexXUhj9Psu5yFE0fmJBE1msfqUd8KrnX8PV+tpK9xKishp9jKULi492vZYZbKZ4oiqO+djlT4e9fUzfROoyvn4m/X+Y+waC8r3EgQAr01PBphpqedtwSW/ZV5Qws1u7OkVD+CfYwhtDASKxUXP+rW08KGHg5/JQ2BcWAq5BVbLKnHHSQLtbQm9h3Xfo5BE+39XC4tXBl8SbkdAWDGIw4sbbGMdvg54iDtKAcV9WrBUtjbABNOU0p7I9bFkDthm3liHlOFEor9exz7J3W77LIpSzw5bQqCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPAtVh+87FEkBZsyHwMX7y23Ie8ZMoolgjqjI6LsJyg=;
 b=JWUJtmZoaJO6wxsN0YwzfaSdQ4YWb5scvf9okVNlAfCfFXlfaaX2UoiodMRqZpDGNDgBQcZTAgDlFH7viq/LIqdvZpEVNLZNvBxjcrSq48JOaoG/3tdQU47xLpOvyn37ggZb+aWD8NhUHwk8k/XccTK3qt00dECO36p/geUWJlsbbzwH5ZAzMyzM32/Vj18JPIavKIvrg55N9D03Ui5L3f5wRI+KdXQx1gVbpB/MSsKMmWs7tc+C9oXxu76ZS6YVSVecoCuU8jYehajq5tCT7dA+EO7aaRLUfrgoH9D028MBsP1X4dBc5f8yPRM8/6N0CBCmffejuwGzdVhvZEHWgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SI6PR06MB7113.apcprd06.prod.outlook.com (2603:1096:4:247::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Tue, 6 Aug
 2024 07:23:33 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 07:23:32 +0000
Message-ID: <b2ea5b52-311d-4c6c-a59d-9982b8723738@vivo.com>
Date: Tue, 6 Aug 2024 15:23:26 +0800
User-Agent: Mozilla Thunderbird
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Kairui Song <kasong@tencent.com>, Chris Li <chrisl@kernel.org>,
 "Huang, Ying" <ying.huang@intel.com>, Hugh Dickins <hughd@google.com>,
 Kalesh Singh <kaleshsingh@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 David Hildenbrand <david@redhat.com>
Reply-To: 20240806012409.61962-1-21cnbao@gmail.com
From: zhiguojiang <justinjiang@vivo.com>
Subject: [PATCH] mm: attempt to batch free swap entries for zap_pte_range()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0222.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::18) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SI6PR06MB7113:EE_
X-MS-Office365-Filtering-Correlation-Id: 5501ad13-1e20-4868-2c26-08dcb5e8ad76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFVrOGtwMlpHYU1US3QrSzkzSFM1WTlXbktMY0Jyd092QUdtMEMvWlArdVIz?=
 =?utf-8?B?WmpJK3prSlQ3cERacGcwNTdxOE80MCtNZzNhSndkaWxKZ3l5V004RDZtaUF2?=
 =?utf-8?B?bHN6blQxQ05wV0crQ2JYZWE2cm8xYWhFczNzek9FMDRBY0ZTQ2lqMmxpdjBQ?=
 =?utf-8?B?aGFGdDJIZENnU0dHYzVjU1BjVG5jTnpyeTlTWVkydHJNbG82WGtYdGloOVA2?=
 =?utf-8?B?YzMwcTNUbXYzMGh2eE9aZUZmVjZjelJydFNaWVhycVRYSFoxRHIxZzFObDAy?=
 =?utf-8?B?N3pqbzR5MDRaTlRuUmh4a29SdWdxUCtKR0kzUnZvTWx2c3BNNlIrWTlGQ3FD?=
 =?utf-8?B?R2pzbEpma0RHRlNSbHVxaE5kTGducWYzTjVMSUpwaG4vc2F1cXZoYkdiRWFM?=
 =?utf-8?B?bC9ITDBVTU5qYzMxd2VQamVZTDNyUzlzOElNUlpjby9ZaXF3SnRpZkRtSW5M?=
 =?utf-8?B?RHY3ZEhCa2FEeHdlMWhVTXBXWlNzay9HamJTWVFmWUhWVlVLTWFTc1ZZZ3cr?=
 =?utf-8?B?aEhSU2xlMzJCRzUwRXZGRDN0bW1pMldrUUp1UGNEVG9TSUtmQ1NuQ1lTWnhC?=
 =?utf-8?B?c01hanQwRFF4UUY4NDZuMG9qdlNYUzRvUHFkUElMYnE2aURWLzl5WFJrYk1B?=
 =?utf-8?B?YUZWVk1PWjBubUE2b1J6d1pHK1YwdXhiTmpXcUxDb0xEOHRaTDVBZ2VzOEZN?=
 =?utf-8?B?ZzhDZ0lmWVJVOUx0TXV6b2VHYXFmQzdIOWxUenNSdTNza3NueFFySlZWTS90?=
 =?utf-8?B?cVgxY2RHdldtTGVxNjlxRDRzZGh3NUVaN095S2hWYjBmMlZUQS9pZUZUcGhl?=
 =?utf-8?B?T3JoSStyRjVEZENJTUoveDdtckdGNm5sN21SMDI0OWcwenlvWjVsQzUyRWdD?=
 =?utf-8?B?ZDAxY0tFQjJmdTd4Vjd5b3ZxRWt1VnN4aTJubVo3eEY2UExVU001ekpuR1ZI?=
 =?utf-8?B?OHptRng1UmpPQzdnRlJGNjM3Mjc4SnkyemxEODZxSnQ4ZGs4U3lVaFhoaWZK?=
 =?utf-8?B?OTVia3U5cDFWQkRBMG84Y2QzM1h0MU00bWVEQ1E5WHBLS1l0Nm9tWjRRVzZo?=
 =?utf-8?B?N1JPdGxKcHlQUFA1NmxsSGQ2YjNXTEZZOGdEa0Jvai9UMGsvNUhYalV3aGhW?=
 =?utf-8?B?eU5yNGJXRTZUbDlybC81Qm81NytyMGRnZ2xIYk1ILzFYTWVGOTlQSGNYdDhQ?=
 =?utf-8?B?WnVacWtmUERsbkw1MGtkdUdrMkZQUTR5YW8wR0RxVFJTbStJRHlYTStFKyta?=
 =?utf-8?B?UU8vSit6MDdGbE1VbXJhZlpCYjhNV0ZzRGRqTS9qakhLMmtCdjRuSm0zTEdU?=
 =?utf-8?B?VHZRbG80MURWcnJxODNtT3lVNzlGc2c5TjhTQjNzRENDWUxLYU9YSFBJQ3Yx?=
 =?utf-8?B?NHExMXFId0tneldqMnJXMWdLWHorZFZVQXJGdUV3azlVSzc1VS9SRmpiQ2I4?=
 =?utf-8?B?MlB5cTg0OW5FYnY4bndSWFJmYmhRTVNRU0V6K3RtWVBQRmtWazhXaEFnRVEx?=
 =?utf-8?B?ZTRENVZPTitzNHpobUdNWldhL3BnbS9Udll5TEo5TElldmVneDZueFhKMHBI?=
 =?utf-8?B?cnRXSW1pS2lVa0dBM2hhRGNTNGdidTJmVGtubXh2NkFjNU92dlRvdHBNcEFi?=
 =?utf-8?B?UEhFL1M1V3VGRUVBYXNyaC95QmdOWEx1SDgyMmhaQ3dDTFVxQmEyNW12MGtn?=
 =?utf-8?B?MXIzRVRlSTM3b1VvUWg1S3Y2b0JycmhnS285dnh3elRMeFBnVytSQWlYbXBK?=
 =?utf-8?B?VGIvdDVLTHFHS2ViL2hPejlxMk93Ykk3K0p4eTRlUlZjWDA1ZHYybHRzYzRz?=
 =?utf-8?B?alhnL1VsSFZsN2VJcnkyUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFIzVHpJS20xU1dkNGJDS2MvVmUwZHpzU2ZrU3lHdU5vSDVBbGhaZEFtUG5s?=
 =?utf-8?B?N0M5V0pjSHJWVENOSDJQQmpjUE9oQUJIUzRoWGtJOTZPNFhqUzZBemlrVlNJ?=
 =?utf-8?B?YTF4V0RSZVpDUXVEcUJGRUxlb0ZDSUNSREZrOTE5NS9mZ2c2RDhvT2NSdkpG?=
 =?utf-8?B?M2R4cU1SRjVpbjJIcG9GQWVTNXBaM3FYaXBicHlZRFJaejV1VmNHMVZQTmtr?=
 =?utf-8?B?emY4a1Bud28rUDg4NmR0TXVRVDZOQjJxZi8rbmtPOWxUcGZISnRiTFFnNk1F?=
 =?utf-8?B?ak5Da0tpSGw1WlBGN2hGZHhLY2hRNGYrMTRtZGZGRlFnZHZ3UzRkSHFtS1NS?=
 =?utf-8?B?cHcvOTZkbGJtVVJWeVpJZDRtWlVpVkRFVlN1UmlkaGV5MHhsZnlZdUU0bGpE?=
 =?utf-8?B?aVVCd1pGY28yM1pKZFRsYVlSQ1NvanNxdVNqWFFaZGhESEN4TE0xUFZMY2Vl?=
 =?utf-8?B?VjAwTFZnM0o5MVRvZjRtSldSWWxrTUZJMDRpWmZoQkNaK0Vha2tVRnNBVVBT?=
 =?utf-8?B?U0Frc1RwSFdYN0h0VDZhNWdxc2VXN0REU0o4NitpRFU0Mkg2c2RwRkVZdjRq?=
 =?utf-8?B?dllscHdpR1RwbzhrSlkrSTBObVhQakZXUC9hckVDYXdxRzNzQWxFSHEwRXE1?=
 =?utf-8?B?bEhCcFFBN0tWVDJQUk5IYmVSSG82VjFtZ29BOFRiRkNQZ3AwWXljK0hNNnpn?=
 =?utf-8?B?TVZyaXVIL0dmd1FmcThCNjcwWWt1Y2x1c0tINm9SSWI3Mk85THRreDlsZkF1?=
 =?utf-8?B?Y3U0RzhaQk9VTjA1eG9VcmpJai9HQ0hQQithL3NiT3NyeFJxSnZFNHBpWmdQ?=
 =?utf-8?B?elpVSWpwOE1mWUE4OVhtSW1yUzhZcjdXc1lwcTZMempwbFo5UkV0SjlhaEpr?=
 =?utf-8?B?M2lNQnZCL1dxWlpPQVNFV3BXOFB2bjhVUFdhU1Q0eER5dys5S1ZZWTIrbGN1?=
 =?utf-8?B?RUxLVWxDa1VlL1l2STNyWDcrQlNWaXMwUHlPS1VwaGZNekVENkhZK2YreTdD?=
 =?utf-8?B?ZWtuOUNCMDg3UEsycEV3cUFnc1o1cmk1V2c3a2s5elRJVXlMcWFaTkRmbnhP?=
 =?utf-8?B?OFZyUmJ5c0U4SXF3enNKZ0c2KzVSM3dwYXdGdzZmbk0zNzlJbHhzSUI5Tmk0?=
 =?utf-8?B?NlRqdzB1MG9MbDVTSEFzb2MrazU1YXEzamFiUzNZcDBmRElkWVU4dUo3eTJy?=
 =?utf-8?B?K1JidGgvZHk5UHplQ21PRWpybS96RmplWlcwWVZLWGZGZWFvNmt4Rlo0ZXM5?=
 =?utf-8?B?dERxMGF6R2hkL2FKOW5NL04vRFBUcHQ2d3NpTkJ0RDJVclRaVFVMV01wc3gx?=
 =?utf-8?B?ZTRXNSt3RHl2amZPTkhicnBNT29OSXRYb0c2ZFp4RU43T0pNVEJvWThTWmJ1?=
 =?utf-8?B?Sk85eXp4aDA4RTZkUW9URXlPQ0xSTjZobDJOZmdtRWw3cFB6UjZkQW1EREFt?=
 =?utf-8?B?MWxBR1RPUHY5eEorS1VrVm51WUNFRTc3aVhxc3hnYzJaeWwzRE5neTZzTlVy?=
 =?utf-8?B?VlRZSytVbFJ5VmlXc2xLQ21RVDRqcVVmZEtlejhhVkF6N1ZpbFVDLzZlWGpB?=
 =?utf-8?B?cU5lVklYeEUrbmQ1NDZhdmxUM1c1NVhLamNJK094MkdQczQ3cThUOU92ZlJl?=
 =?utf-8?B?eDhUcUYzdlhjUUJDODNGNFdkbHRMdExjM1pNWVcyTklDZTB1VDJXRXF5ODJt?=
 =?utf-8?B?eDNEWTMycW9CMVNvQXl2b1dEaU4yYXA4T2ZoNFVjWHNGYUpZMy82ODhyQ2hh?=
 =?utf-8?B?YVcxaGM2a2l2VjZ4cmJLZ05YQVhqRmkvWmpRWDk3aThmUytSYmU5ZDZ5U0Y4?=
 =?utf-8?B?L045amw4dkZqVDNEYVBVajV6UEdtb05SRlFubWUxd3FyVkxEVDRhK3pkTTA2?=
 =?utf-8?B?S25Xc0dlR2Z2R0ZXUjJaUTdUK0traGtFVTdzV1loVFBKcnlGT3JJenY2K3Bl?=
 =?utf-8?B?bm8wNkp6WUtUVmlTR0tmejNMNFNMUm1PbnBCam96VHNpWlpiN3NhSXk1dUtV?=
 =?utf-8?B?NlU0OGNlN1IzQVFxV2M1dWw4K21Fd3JqUnkvN2hXZ2NKTnhPMVRrUmtwaGFC?=
 =?utf-8?B?eDVsT2VJY0YrakNBY2ZJNHVkK2Z0a2NtSHd1Tkl2SzM1eFBxeGQ4RFB4eDhX?=
 =?utf-8?Q?gO8zUtGj7lAR1qUe3KjbT/EVl?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5501ad13-1e20-4868-2c26-08dcb5e8ad76
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 07:23:32.8799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pR6m0YMxtJH4xXYF3RlWI9s5Bl+HQyy5lpFYALq+kGd0ZUCGqOpqNd8iv0+VIK34tA1HhMd6m6TVmEJ96INANA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7113

From: Barry Song <v-songbaohua@oppo.com>

Zhiguo reported that swap release could be a serious bottleneck
during process exits[1]. With mTHP, we have the opportunity to
batch free swaps.
Thanks to the work of Chris and Kairui[2], I was able to achieve
this optimization with minimal code changes by building on their
efforts.
If swap_count is 1, which is likely true as most anon memory are
private, we can free all contiguous swap slots all together.

Ran the below test program for measuring the bandwidth of munmap
using zRAM and 64KiB mTHP:

  #include <sys/mman.h>
  #include <sys/time.h>
  #include <stdlib.h>

  unsigned long long tv_to_ms(struct timeval tv)
  {
         return tv.tv_sec * 1000 + tv.tv_usec / 1000;
  }

  main()
  {
         struct timeval tv_b, tv_e;
         int i;
  #define SIZE 1024*1024*1024
         void *p = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
                                 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
         if (!p) {
                 perror("fail to get memory");
                 exit(-1);
         }

         madvise(p, SIZE, MADV_HUGEPAGE);
         memset(p, 0x11, SIZE); /* write to get mem */

         madvise(p, SIZE, MADV_PAGEOUT);

         gettimeofday(&tv_b, NULL);
         munmap(p, SIZE);
         gettimeofday(&tv_e, NULL);

         printf("munmap in bandwidth: %ld bytes/ms\n",
                         SIZE/(tv_to_ms(tv_e) - tv_to_ms(tv_b)));
  }

The result is as below (munmap bandwidth):
                 mm-unstable  mm-unstable-with-patch
    round1       21053761      63161283
    round2       21053761      63161283
    round3       21053761      63161283
    round4       20648881      67108864
    round5       20648881      67108864

munmap bandwidth becomes 3X faster.

[1] https://lore.kernel.org/linux-mm/20240731133318.527-1-justinjiang@vivo.com/
[2] https://lore.kernel.org/linux-mm/20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org/

Cc: Kairui Song <kasong@tencent.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
  mm/swapfile.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++
  1 file changed, 61 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index ea023fc25d08..ed872a186e81 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -156,6 +156,25 @@ static bool swap_is_has_cache(struct swap_info_struct *si,
  	return true;
  }
  
+static bool swap_is_last_map(struct swap_info_struct *si,
+			      unsigned long offset, int nr_pages,
+			      bool *has_cache)
+{
+	unsigned char *map = si->swap_map + offset;
+	unsigned char *map_end = map + nr_pages;
+	bool cached = false;
+
+	do {
+		if ((*map & ~SWAP_HAS_CACHE) != 1)
+			return false;
+		if (*map & SWAP_HAS_CACHE)
+			cached = true;
+	} while (++map < map_end);
+
+	*has_cache = cached;
+	return true;
+}
+
  /*
   * returns number of pages in the folio that backs the swap entry. If positive,
   * the folio was reclaimed. If negative, the folio was not reclaimed. If 0, no
@@ -1469,6 +1488,39 @@ static unsigned char __swap_entry_free(struct swap_info_struct *p,
  	return usage;
  }
  
+static bool try_batch_swap_entries_free(struct swap_info_struct *p,
+		swp_entry_t entry, int nr, bool *any_only_cache)
+{
+	unsigned long offset = swp_offset(entry);
+	struct swap_cluster_info *ci;
+	bool has_cache = false;
+	bool can_batch;
+	int i;
+
+	/* cross into another cluster */
+	if (nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER)
+		return false;
My understand of mTHP swap entries alloced by by cluster_alloc_swap()
is that they belong to the same cluster in the same swapinfo , so
theoretically it will not appear for
(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER)?
Can you help confirm?

+	ci = lock_cluster_or_swap_info(p, offset);
+	can_batch = swap_is_last_map(p, offset, nr, &has_cache);
+	if (can_batch) {
+		for (i = 0; i < nr; i++)
+			WRITE_ONCE(p->swap_map[offset + i], SWAP_HAS_CACHE);
+	}
+	unlock_cluster_or_swap_info(p, ci);
+
+	/* all swap_maps have count==1 and have no swapcache */
+	if (!can_batch)
+		goto out;
+	if (!has_cache) {
+		spin_lock(&p->lock);
+		swap_entry_range_free(p, entry, nr);
+		spin_unlock(&p->lock);
+	}
+	*any_only_cache = has_cache;
+out:
+	return can_batch;
+}
+
  /*
   * Drop the last HAS_CACHE flag of swap entries, caller have to
   * ensure all entries belong to the same cgroup.
@@ -1797,6 +1849,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
  	bool any_only_cache = false;
  	unsigned long offset;
  	unsigned char count;
+	bool batched;
  
  	if (non_swap_entry(entry))
  		return;
@@ -1808,6 +1861,13 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
  	if (WARN_ON(end_offset > si->max))
  		goto out;
  
+	if (nr > 1 && swap_count(data_race(si->swap_map[start_offset]) == 1)) {
+		batched = try_batch_swap_entries_free(si, entry, nr,
+						&any_only_cache);
+		if (batched)
+			goto reclaim;
+	}
The mTHP swap entries are batch freed as a whole directly by skipping
percpu swp_slots caches, instead of freeing every swap entry separately,
which can accelerate the mTHP swap entries release. I think it is
valuable.

+
  	/*
  	 * First free all entries in the range.
  	 */
@@ -1821,6 +1881,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
  		}
  	}
  
+reclaim:
  	/*
  	 * Short-circuit the below loop if none of the entries had their
  	 * reference drop to zero.
-- 
2.34.1

Thanks
Zhiguo




