Return-Path: <linux-kernel+bounces-545243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D68B6A4EB88
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97EC1883251
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3D82638AF;
	Tue,  4 Mar 2025 17:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Sb9ay7Hr"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C739127E1C7;
	Tue,  4 Mar 2025 17:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110273; cv=fail; b=uvXAdBwtCoPwO3I6vQxaknnYw4U8EPIqQCdBHmeCehz6sCJ4nup75K0ct9zmLsI2qP2ZT7MsUYM4wkLgZNCCVP3UQqhIp5OUsRN9TbRi3qtXhxwKyVPdibq/f+H+huLioBKlyOMc1Yv4ErJ3peStT+gEm+aV9X10UE4ZlQWBlzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110273; c=relaxed/simple;
	bh=p3roeF4e8YT1SF77EwctuX5vGee6TpMy8SzXsrai/AM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dGyXjvX6KTK/yBydgTh4SEmFmTQQ5dZAHIvu4F8wHZSXzrWO7MyIBcK3j4lKfP+m0Uy+5g1aFogyBHl0fToVgpp2tyqShMBxTmIgbndhcDFdJSdFLhQ/urcL5g22IGfBPJOQjugIEClCA0ZxZqCXFolvJIOofDd/PX2xTQq6e1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Sb9ay7Hr; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+/K2Hv0u+KPgxtr0C1epIGAh4Q3y6xggaLJ4+8UuXqMhA5js2KNobQyc4tZLZ5rOmvX4vwWCyxtTpaXdXi2hWFVFVEi1G1q9vl5Fz+4hrfGizqrUf5R5p1WbkzyWItIYvIf67QAelEeJ89NmYrzCu5JviEIn9eR1ySrXIr/QxMo2yKlWucc5SGx/MHy/jRg9XUMHzvBYXpp8WF+0H3TqlSrjbrz7r/MPeZ00ou5dhODcdb+dKuqKF0V4aoqYR7xf92zmEPnCABl3DZ/pPRokhWOyUaOTbV2cwacyMOVZ+3xqZAp2mmR966/oUm7+nYFqLl8NbnjgWp9Oi80w1jRjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sTwWdEnosRFZbKz5qiDfcEtOP2JD4oGE/LWe4urY/M=;
 b=pVV5+aA8gwv0u0r5XNupCz3ifTb4n/vF5ws37o4MMZpLcXZn0ch/9jNc9Fvyd+/8yq4TnAeuYz+FGsYOFCqGxD3EI73B1Bys6vvQFXG7ZAgBdEwxBWmFG/EEiZBHxSreHBZ/MBMoA+TWajZrdEsmnwhYl78MszHtu5Ml06tfGgdSW2emrVHcbWOE7IGBF+Mje1Xjvn4R6X5IaeYDvP3rFck63lFmEOdJzjfmpphmP18g+/JrRyYRQtcYdFlKJDT8pCacwL77RDFsTexfvbYUpbKfXLqPhUNtse0ay4EcVBLtYJ2WsUzGhLCWTH6vhF+xfh0Ya1ip+nm4qTI4RKBXyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sTwWdEnosRFZbKz5qiDfcEtOP2JD4oGE/LWe4urY/M=;
 b=Sb9ay7HrieEVQHD6Y9onXHPWAqBpzUGI1kromsPQm4azY8J5i+4M3BGihDN+8Sr6YAX3aQwb1OVLgPksP6gbGPRAsHZ0MkUEBPQuJfYIo3QRb+N5HxunCt5lm2+qk8XA71mMoIda6/Xb57mnhb7jCRUr4uCMG90UvWnKaaPEigM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6429.namprd12.prod.outlook.com (2603:10b6:930:3b::16)
 by PH7PR12MB9101.namprd12.prod.outlook.com (2603:10b6:510:2f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 17:44:25 +0000
Received: from CY5PR12MB6429.namprd12.prod.outlook.com
 ([fe80::1b40:2f7f:a826:3fa0]) by CY5PR12MB6429.namprd12.prod.outlook.com
 ([fe80::1b40:2f7f:a826:3fa0%7]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 17:44:25 +0000
Message-ID: <053f72c4-4055-4b79-9cd5-c6d1f1f23268@amd.com>
Date: Tue, 4 Mar 2025 12:44:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: amd: Add ISP platform info
To: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>, ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 benjamin.chan@amd.com, bin.du@amd.com, king.li@amd.com,
 gjorgji.rosikopulos@amd.com, dominic.antony@amd.com
References: <20250228170238.3484860-1-pratap.nirujogi@amd.com>
 <cd25d131-bead-4a38-98dc-1011c2843286@redhat.com>
 <3d57b624-7753-4a4d-9051-0a55cbdff1ec@amd.com>
 <3beeeb19-3791-4090-860e-45b8df2568a7@gmx.de>
Content-Language: en-GB
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <3beeeb19-3791-4090-860e-45b8df2568a7@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::17) To CY5PR12MB6429.namprd12.prod.outlook.com
 (2603:10b6:930:3b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6429:EE_|PH7PR12MB9101:EE_
X-MS-Office365-Filtering-Correlation-Id: e98280ab-ac1a-4617-55e9-08dd5b443430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUZsTUNnanN2bUxsM2J1UnV6MnRSU3ZYRi9ldFM2MFFQQzFibUNXWG1QQURa?=
 =?utf-8?B?NzZISy9XSUFKcjIzcmtoZWJCNXlkU3QwRE9lWTdQWlp5YTRmME9BTjNuWE9O?=
 =?utf-8?B?MnpheUdQVkU3NW5aTjUzRkhUU0lQV2pDV0lZdU9TZFlhSEtiMTlDak5FbTBx?=
 =?utf-8?B?dWNYdmxraEpzVjRnMmZISTNtRmlJdlRnMlljMEVBNW0rc2k5M2pzV3RSQ2Mz?=
 =?utf-8?B?ZmltS1NyQWJLYTdwbE10Q0psZ2tLcmtHTEtKbWQxRXg5L0QxMmd4aUtPNjVq?=
 =?utf-8?B?TDk3OUsxa0Q2RHhrUXM2Nld2K1REM1poT2t2VGhtOW1scnFsLzJ6eVdZbmpC?=
 =?utf-8?B?RDZ0SlNJMjQ2Y3RnV3IvZFZJcVR6WUxWL3c4R0FIeGxPN2hiZHl5YVVMdjFO?=
 =?utf-8?B?OU40VWNTTnZKTVRXdTByS1RycWhxNDZoajV2NGZFdm0xOER1T0VLcTNXbk5I?=
 =?utf-8?B?b2xDK0drd0lZSnpuZ3pPYXFkVnBCRlVIbHpDSFlPazdMVyt5Q1hObWpobG90?=
 =?utf-8?B?UEovZ2lGYjg5Z2VQWVJCeDFFR0I4UmQ4NVlPNmhBN1FnYzhBditqd3V4Zlk2?=
 =?utf-8?B?cE9kTkh5eWowK2s1aXpGWXVBWXRoZVd2VFlyeFIySTFsakl5UEczaDRXMUZo?=
 =?utf-8?B?ellLcGlnWGx0eFRsck5xd2xTQ0lmWHB0aDhhTm1CYnNLUGFEcDJRY085Z3Bt?=
 =?utf-8?B?RE9PYmZSMFdUVXhTNTFMaTBqTUhESTY0VXF1VTlzckxvNmhLNXdZT0lQamhC?=
 =?utf-8?B?dk5HTExic3luMlB2L3FyYUpCbSs4TVhqaDNZN1V3a29nM1pQelhnOUp4dy81?=
 =?utf-8?B?a0RWNkRHV1JVRjJHRU12RHdMU0swakF0YnBhY25vK1crZzRkeEtxbWM5WkhJ?=
 =?utf-8?B?OEUyaDRpSm9VU2d3YktyL0d1TER0UUZNUkdDSFIzMGNzVStVL2RsVDd4S2tB?=
 =?utf-8?B?aHNMbDhmOWxoOTZoS0VERzBlNHRpcFdTajZGYmxQSXhDU0FlNEJXbC9VTGRw?=
 =?utf-8?B?eUdXSG9OOE1KczN6WnJPQTBURVRJakdsenJTUXFqUG4ydUNyekpaTXRKMVBR?=
 =?utf-8?B?ODNWZG9HTmQvenVmcFJ3WjlWTXg4TW5aYzNrRDkwd3F6MkN4SUhQQnhhRFhM?=
 =?utf-8?B?cS80Mk9aV1FwcXI3b1ZvKzFVbC9EM0NET3Y1NXR6WmNJUy9wTWhqeEgvM0R5?=
 =?utf-8?B?MXZJcDNpSlJsVDFDc2Z5dlBZNFF0Q0pTa1M4Y2lzeEVaRHFuSktPM1EzRUUz?=
 =?utf-8?B?U1ArNlgyY2U4SjBkOTZSRUYyNFZtUUt3OEQ1VUZkM3Bkd1RyZENtUkUzVFZR?=
 =?utf-8?B?RDJoN3ZadFBNUVAvWmhzQnIwR1dzZmlNWWIwczF3T1M1QUVhUExIcmxJR2xu?=
 =?utf-8?B?NDNvdWlVT1VvTlRlUW9TVDByV1hsaTdwVVZrNDArdnA5TEpjbk9BL1VUMGNN?=
 =?utf-8?B?ZSs1SEExcS94azk5YitOMWN1MjUzOUZoeXlOVWd6Z2ZoK21wY0hQV3FQZzYr?=
 =?utf-8?B?WmE4V3FxKzNDYkx1V3UyUFU0WktCSG9FVlJVUkpXM2dpQlZrc01idFc2MkNh?=
 =?utf-8?B?NFZQcVo2L3F3eTdUMjJsWW9NVjl1TmRXLytWVkQyQ0tkbjB2VU1HeUdHTHFY?=
 =?utf-8?B?dkh2L0lTRUxvRG9jR1B5b0R6a1dNR0p3YnZQaHlMeU9rTVZ3eUQ5ME5sTS9I?=
 =?utf-8?B?WjJKK3pKWVlpN2oxSWo0V09mNkNGNGs4MjBHQXpvRkltR1FvWFlyT2VBQ2Fh?=
 =?utf-8?B?b1lXZzFwenZ0VGpQMjQ3TUVvTnBWSHFTSW5CWEtIWm1ZU0JpeGprcFdMcEpS?=
 =?utf-8?B?U1dwN0EvckRHUldqYjBDUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6429.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmxYZUdUNzhJWWgyQllIV2piVGt1YXVJdmJCZWpIWUFBUXRmOGJiK2ZGRCtT?=
 =?utf-8?B?SS9HRmRVUzc2RUx2ZmphdE9yWG1wYThvUVBRdmlkN2I0TXlISWxOL1NVNE0y?=
 =?utf-8?B?eWVPbkhwWUdLTE8vcmd4TkxmU1NtVVVwK1ZKSGVXZGJXbU5KdGNTajBMYnh6?=
 =?utf-8?B?L0FVSGhiWkJoM0ZYWkJ1a3paL1pnWVNKZmRBei9ORlBsbzRKK2I4ejRldU9F?=
 =?utf-8?B?L3VKUGkyaEZQaWtWbWFRVzJmWDI0RzBLTjFsUTNsQ040Yjd1ZkY2dkZuQUN6?=
 =?utf-8?B?NHBvMEJxR2JrNHBMVklPczYrV3EyZjNVS0RtdmNBak9mTlhJNVFIUHg1c0Zu?=
 =?utf-8?B?WlE2cUY5Qjd1cGZDUnVYTThsQUpKTDJlUTV2clM3S2FCbWplQzQxcU9aZjhF?=
 =?utf-8?B?L21UWDBQNmlnMGgzWTJXZWs2WDV1c0NEMm15OThIdFFLMlVqNjlZRUVhdCty?=
 =?utf-8?B?NGFyNXZOL2R5TnJEaGNSUWgwY2F5OThhamZtMlVRcTRSWkZ3eEwvM0FsNkhZ?=
 =?utf-8?B?ZUUwUUdMNGdTNk5EaGZXM3J5Y21GUUdwMXZOZ3ozbHlvaEZ4cDhrdWJESDBp?=
 =?utf-8?B?VjFzY0pQSmFicERSZkx5WVZVUWllNm51S2JEeStYZUFnZ1U4ZGJvWWRhaFVC?=
 =?utf-8?B?ME1La3RxTmdlUkFhSXVYZjRHT3pFZm5sMmJPemprSUQzdFdMb3lXaERjdzE0?=
 =?utf-8?B?dXNTalJyY1lPSTcrK3c4MDNITXpscE9uNVN2MU9Fa3IzQkdUanBweVV6RDNv?=
 =?utf-8?B?d2QvM3hTOW90LzI1UnJnOWZXaktpQXIvK0lrMm9wczB6aDhPdkVtY0dTaUha?=
 =?utf-8?B?aFZIcWw0WnR2bHdMcnBrRm41Vy9ZaExHSU1aZ25rclhZQVhxSWhaSERDa1dq?=
 =?utf-8?B?cW44YnlwREJtWWpMREI4bnkxT1FNcFZxOUFWZ0h2T0hhRmZqdUU2SW9IQ0lq?=
 =?utf-8?B?RVNMMy96MFQwL2s5ZSs0dWxKVzlpNVR4TmZGRVV4UHg3TDZWSTQ1SVIvamFL?=
 =?utf-8?B?T1ZKeGs1RVJNTiszQmlGTUV1S2pqT0oyRUkxa2srTWJCL0h4YjZIWXFwTUYw?=
 =?utf-8?B?Um1FU3N0UCtyNUtVWFAzYUdsekxvWEp2eU13cVlIMnYrZGR4QXBUWkxmZ1la?=
 =?utf-8?B?dnBIWnhkTWxUcXlxdXI1QUJCbDF2TERoUm5zRmpLYStiZVZDVlJQYlpPTEtZ?=
 =?utf-8?B?OGdKck5hRjkzbUZDQ0g1SDhNa2VTempPUVlrNTZabGlmWXlNMUZTdkgxcEVx?=
 =?utf-8?B?aktHMDhjdktOL25YS0dNRmdqbXNHdjdmZnFNV3U2UlFzMGxKMXhxSUs5UDZW?=
 =?utf-8?B?Vk9JbTl0T1QrdEU0NkNwcm5PcUVzWVZUT1R6OG9CRnV4NjdKY0txRGhqNTl6?=
 =?utf-8?B?bzlPYjlYWHVQOWpwdGxMUnpUeGxhL1Nydjh4dVhNdUVIekZlbHpZb2NSWDBW?=
 =?utf-8?B?ajJ3Y1FzT3EveVExc3lGWG1EQmdncVRaaDBNd3JrTzBOeFordUlWaXZkNzcy?=
 =?utf-8?B?QW0rSEcyOGthQ3ppUDVTUkZDNGQ4WS9jdyswZ01MdGptMDAwREoxYUxqdEdY?=
 =?utf-8?B?aG1seDRZaG8zYVhSeUFuSkdPZzIvYnMvQWxUeElmZThidE4rVTJRMUdwWkNm?=
 =?utf-8?B?V2xveUMyOEo3MkhvWmNmNDZTWlljVXNLMGFEV20ycnhRL2phYi9tOXdKcUNh?=
 =?utf-8?B?ZjRGdSsyblhCQWJGQmRMcDBSOGJ4b2tlazJJL3ZVL203YjB3M3dEb2NjVUlU?=
 =?utf-8?B?WURIOWxvRDBHSEFyeXFXTHl5YUQwWURPNG1FVU1QR2pPa0ZxRzdnQmVBSTd1?=
 =?utf-8?B?RFd3ME9ha1IyaVRyeThRNFROR2hqZmUvcFpsR2M2UEVBR2hWT1kzWUZVQzRr?=
 =?utf-8?B?S3pDNm8vYnU1cW1WU05IT2ZCMVZ0eHJIdDNqZ3RpZDdLL1UvM0xmZ3NlVkdn?=
 =?utf-8?B?TFMxUHI4aHF6RTl5QTBJbWVpZXhUZ2h2Z1laUXoxVHhNaURpL3VFTWF0OGgx?=
 =?utf-8?B?aEwzSllscUQ2cXhGZVlpMnFOY1pCVlZQQ0piRWM5MnRjWDAvVG5iMWhMZnJ1?=
 =?utf-8?B?ZThzV0VjTmwrdTVuRGE4QTdGSkMvcWdmM1lzaitUWkx6aUJJZnVEVGJObURO?=
 =?utf-8?Q?IGBiaXx4+qnTkAHFwwuAFfRkr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e98280ab-ac1a-4617-55e9-08dd5b443430
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6429.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 17:44:25.1270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tu5Dw48N3jRwxE/WAeS/L/uR6cOiT2Rw6KD4CH82BDiYqt/gprAUntppZlNpdW5xmWubW7T5TMz8LCORc+774Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9101

Hi Armin,

Thanks for your comment.

Thanks,
Pratap

On 3/3/2025 6:56 PM, Armin Wolf wrote:
> Caution: This message originated from an External Source. Use proper 
> caution when opening attachments, clicking links, or responding.
> 
> 
> Am 04.03.25 um 00:14 schrieb Nirujogi, Pratap:
> 
>> Hi Hans,
>>
>> Thanks for your review. Please see the inline comments and let us know
>> your insights.
>>
>> Thanks,
>> Pratap
>>
>>
>> On 3/3/2025 8:41 AM, Hans de Goede wrote:
>>> Caution: This message originated from an External Source. Use proper
>>> caution when opening attachments, clicking links, or responding.
>>>
>>>
>>> Hi Pratap,
>>>
>>> Thank you for your patch.
>>>
>>> On 28-Feb-25 18:02, Pratap Nirujogi wrote:
>>>> Add ov05c i2c boardinfo and GPIO pin info for AMD ISP platform.
>>>>
>>>> Details of the resources added:
>>>>
>>>> - Added i2c bus number for AMD ISP platform is 99.
>>>> - Added GPIO 85 to allow ISP driver to enable and disable ISP access.
>>>> - Added GPIO 0 to allow sensor driver to enable and disable sensor
>>>> module.
>>>>
>>>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
>>>> ---
>>>>   drivers/platform/x86/amd/Kconfig   | 11 +++++
>>>>   drivers/platform/x86/amd/Makefile  |  1 +
>>>>   drivers/platform/x86/amd/amd_isp.c | 72
>>>> ++++++++++++++++++++++++++++++
>>>>   3 files changed, 84 insertions(+)
>>>>   create mode 100644 drivers/platform/x86/amd/amd_isp.c
>>>>
>>>> diff --git a/drivers/platform/x86/amd/Kconfig
>>>> b/drivers/platform/x86/amd/Kconfig
>>>> index c3e086ea64fc..4b373edd750d 100644
>>>> --- a/drivers/platform/x86/amd/Kconfig
>>>> +++ b/drivers/platform/x86/amd/Kconfig
>>>> @@ -32,3 +32,14 @@ config AMD_WBRF
>>>>
>>>>          This mechanism will only be activated on platforms that
>>>> advertise a
>>>>          need for it.
>>>> +
>>>> +config AMD_ISP_PLATFORM
>>>> +     bool "AMD platform with ISP4 that supports Camera sensor device"
>>>> +     depends on I2C && X86_64 && AMD_ISP4
>>>> +     help
>>>> +       For AMD platform that support Image signal processor
>>>> generation 4, it
>>>> +       is necessary to add platform specific camera sensor module
>>>> board info
>>>> +       which includes the sensor driver device id and the i2c address.
>>>> +
>>>> +       If you have a AMD platform that support ISP4 and with a sensor
>>>> +       connected to it, say Y here
>>>> diff --git a/drivers/platform/x86/amd/Makefile
>>>> b/drivers/platform/x86/amd/Makefile
>>>> index 56f62fc9c97b..0d89e2d4f7e6 100644
>>>> --- a/drivers/platform/x86/amd/Makefile
>>>> +++ b/drivers/platform/x86/amd/Makefile
>>>> @@ -10,3 +10,4 @@ obj-$(CONFIG_AMD_PMC)               += pmc/
>>>>   obj-$(CONFIG_AMD_HSMP)               += hsmp/
>>>>   obj-$(CONFIG_AMD_PMF)                += pmf/
>>>>   obj-$(CONFIG_AMD_WBRF)               += wbrf.o
>>>> +obj-$(CONFIG_AMD_ISP_PLATFORM)       += amd_isp.o
>>>> diff --git a/drivers/platform/x86/amd/amd_isp.c
>>>> b/drivers/platform/x86/amd/amd_isp.c
>>>> new file mode 100644
>>>> index 000000000000..751f209e9509
>>>> --- /dev/null
>>>> +++ b/drivers/platform/x86/amd/amd_isp.c
>>>> @@ -0,0 +1,72 @@
>>>> +/* SPDX-License-Identifier: MIT */
>>>> +/*
>>>> + * Copyright 2025 Advanced Micro Devices, Inc.
>>>> + *
>>>> + * Permission is hereby granted, free of charge, to any person
>>>> obtaining a
>>>> + * copy of this software and associated documentation files (the
>>>> "Software"),
>>>> + * to deal in the Software without restriction, including without
>>>> limitation
>>>> + * the rights to use, copy, modify, merge, publish, distribute,
>>>> sublicense,
>>>> + * and/or sell copies of the Software, and to permit persons to
>>>> whom the
>>>> + * Software is furnished to do so, subject to the following
>>>> conditions:
>>>> + *
>>>> + * The above copyright notice and this permission notice shall be
>>>> included in
>>>> + * all copies or substantial portions of the Software.
>>>> + *
>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>>>> EXPRESS OR
>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>>>> MERCHANTABILITY,
>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
>>>> EVENT SHALL
>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
>>>> DAMAGES OR
>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>>>> OTHERWISE,
>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
>>>> USE OR
>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>> + */
>>>> +
>>>> +#include <linux/init.h>
>>>> +#include <linux/i2c.h>
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/gpio/machine.h>
>>>> +
>>>> +#define AMDISP_I2C_BUS               99
>>>
>>> I'm not a fan of using static i2c-bus numbers for this. static bus
>>> numbers are
>>> something of the past and we typically do not use these on x86 anymore.
>>>
>>> Using this static number + i2c_register_board_info() also requires
>>> this code
>>> to be builtin rather then modular which is also undesirable.
>>>
>>> For a more dynamic way of manually adding i2c-devices see:
>>>
>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/ 
>>> linux.git/tree/drivers/platform/x86/dell/dell-lis3lv02d.c
>>>
>>>
>>> But a better question here is why instantiate the sensor i2c device
>>> manually at all.
>>>
>>> ACPI has a standardized way to describe I2C-clients which tyically
>>> is used for all I2C devices on ACPI platforms like I2C touchscreens /
>>> touchpads / audio-codecs / accelerometers / etc.
>>> I don't see why the camera sensor on AMD platforms is so special that
>>> it could not be described in ACPI using an ACPI child-device of the
>>> i2c-controller with a ACPI resource (_CRS entry) of the I2cSerialBusV2()
>>> type.
>>>
>>> Likewise the sensor enable GPIO should also be described in the ACPI
>>> table as a Gpio type resource in the same _CRS table.
>>>
>>
>> We have to take this approach because ISP is a child to GFX PCI device
>> in AMD HW architectures, and since it is not an independent device,
>> its device specific configuration (gpio pin ids, i2c-bus number etc.)
>> is not registered in ACPI.
>>
>>> Can you run acpidump -o acpidump.txt on a laptop with this camera
>>> sensor and send me the acpidupm.txt offlist ? Please run this
>>> on a production hardware laptop model using production firmware.
>>>
>>
>> Please refer the attached acpidump.txt
>>
>>> I suspect that Windows will also be using the ACPI description
>>> for the sensor so we really should figure out what Windows is doing
>>> here.
>>>
>>
>> Yes, same ACPI configuration for both Windows and Linux. Similar
>> approach followed even on windows to control the isp gpio pins.
>>
> The OMNI5C10 ACPI device has a _DSM method that supports the GUID 
> f8fd3bff-21b7-4a99-bdc8-c414a3e9453c. Do you know
> more about the purpose of this method?
> 
> Thanks,
> Armin Wolf
> 

This GUID is windows specific. Sorry, I'm not completely sure on what 
exactly it is used for. I'm thinking it is used to distinguish the 
different sensor modules that OEMs supports on different SKUs. I confirm
its not applicable for Linux.

>>> As Mario mentioned we cannot just assume that the GPIOs +
>>> sensor address and model are valid for all laptops. Ideally we should
>>> be getting this information from ACPI rather then hardcoding it
>>> in the kernel.
>>>
>>
>> Yes, we initially assumed CONFIG_AMD_ISP_PLATFORM=y will be set only
>> on the intended platforms, but as that assumption is not valid, the below
>> check is added in v2 patch checking the specific ov05c acpi hw id to
>> present before running the driver.
>>
>> /* check for valid platform before configuring isp4 board resources */
>>     if (!acpi_dev_found(AMDISP_ACPI_CAM_HID))
>>         return -ENODEV;
>>
>>>> +
>>>> +static struct gpiod_lookup_table isp_gpio_table = {
>>>> +     .dev_id = "amd_isp_capture",
>>>> +     .table = {
>>>> +             GPIO_LOOKUP("AMDI0030:00", 85, "enable_isp",
>>>> GPIO_ACTIVE_HIGH),
>>>> +             { }
>>>> +     },
>>>> +};
>>>
>>> This too really should be an Gpio() type ACPI resource on the ACPI
>>> device
>>> node for the ISP.
>>>
>>> How/where is this "amd_isp_capture" device created ?
>>>
>>
>> "amd_isp_capture" is the V4L2 ISP driver in this case. The patches for
>> ISP driver are yet to be submitted. It will be loaded during AMDGPU
>> device probe on the AMD platforms supporting isp4.2 HW. AMDGPU
>> reference to trigger the isp device probe:
>> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/ 
>> amdgpu/isp_v4_1_1.c#L108
>>
>>
>>> Regards,
>>>
>>> Hans
>>>
>>>
>>>> +
>>>> +static struct gpiod_lookup_table isp_sensor_gpio_table = {
>>>> +     .dev_id = "ov05c",
>>>> +     .table = {
>>>> +             GPIO_LOOKUP("amdisp-pinctrl", 0, "sensor0_enable",
>>>> GPIO_ACTIVE_HIGH),
>>>> +             { }
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct i2c_board_info sensor_info = {
>>>> +     .dev_name = "ov05c",
>>>> +     I2C_BOARD_INFO("ov05c", 0x10),
>>>> +};
>>>> +
>>>> +static int __init amd_isp_init(void)
>>>> +{
>>>> +     int ret;
>>>> +
>>>> +     gpiod_add_lookup_table(&isp_gpio_table);
>>>> +     gpiod_add_lookup_table(&isp_sensor_gpio_table);
>>>> +
>>>> +     ret = i2c_register_board_info(AMDISP_I2C_BUS, &sensor_info, 1);
>>>> +     if (ret)
>>>> +             pr_err("%s: cannot register i2c board devices:%s",
>>>> +                    __func__, sensor_info.dev_name);
>>>> +
>>>> +     return ret;
>>>> +}
>>>> +
>>>> +arch_initcall(amd_isp_init);
>>>> +
>>>> +MODULE_AUTHOR("Benjamin Chan <benjamin.chan@amd.com>");
>>>> +MODULE_AUTHOR("Pratap Nirujogi <pratap.nirujogi@amd.com>");
>>>> +MODULE_DESCRIPTION("AMD ISP Platform parameters");
>>>> +MODULE_LICENSE("GPL and additional rights");
>>>


