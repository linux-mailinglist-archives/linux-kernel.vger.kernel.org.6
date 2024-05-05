Return-Path: <linux-kernel+bounces-168989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4CB8BC09D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 15:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 324002819BB
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 13:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AB320B0E;
	Sun,  5 May 2024 13:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="th1zE3O7"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A161D556
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 13:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714916548; cv=fail; b=EiQ72wuppg6wgrPhPCTGFtPi11q2tAi1xXd7Dx6pLE19mZJQoeA/7002nzWujVvA09rr5+btL/u0Nhl5d/tQWNA3oU3kxItvDT458RICi6c2W9P0Uli1/3hV+JD+aj3aSf99guN4nQ//L1F67J9N/UiIHfybAoef8IVS826q0+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714916548; c=relaxed/simple;
	bh=6OwtmpZcvY1w9q2UmyMIoSBi0MXMdpihraYF4xQSRO4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mqaAqWi1NaHYM9Y6Vwa/wSamMNLWKohypq+m+HNgt66ppzohLM0HpcJVis43ikfk0D4ul6xbQCM689lDVPlzOKheI5GeFG0+QUtRLKDTQmMa4dBXTb40+zRCTYs/Da5Os0ETYs3Gk1MW/XvITVylYgO4K3FPRtSmAu7v7BmSZxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=th1zE3O7; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHYtA70ENrdnt66iIyeEHVmfgOQ8psCtV4Rm7Gk6hNq7Lf0T1UmuX9wrFCucSmM2SOeZoknm5CzEtsppaHQQYmh6n20c0WqjIw/M5wqPzD3FSgltcNCkqcPokagI580pYU6s0NM9DS+5fgTYrCzVE9ySBFPgS5DIwHBtiSXWk+S1C4dVBbS7MLfKnsAeE+A4ms8k5d21GF75FHuyFPJEHR+hia4RQ83hfiYtQvbbeJX6Udd2Hfuf4NjyUAJ4+YN307QKBXMvJ/9Bj9BkL5ZOwp2yad9ZBRcRfu5479LU0h0QauCd0o2Uvn8NTal5OjLWicLq8NGQJf6QjPsAtbucmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfqdFfnY20hkh1jpwpbsIwyv8VyYZU2PPsOfQXq98N0=;
 b=IPAagS17OmMhQUZiQOQMhdE9qtm98hO1ab1yi2ULBcbLW74KFjB9nXa1+8B0NM6zLDVXVVwLigjRzY/uBdlsVy3MO0liFKuhD/GUJxi1uLEmxtIGAFWYh2OVndMEAcdw8oQiCP8rJX94hJWx2pMQOqgqHGZTFBj8UW3sNq2xdBvWmfnjUkTJ0qhN71T5ZNxqomvFbvzHaTmKR/FU+hAG6INaPtGCOzwIPCCVtrOJaaGwSGzOgkUywUhaUzA7n4QMk0pejXCsM21Ipuocg3e60DKKJQXhqZ6dbEXt8kWCb1HbTjh4NEMX0StvNSaLALpmHsnX0oqZcn2HByVgD19RzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfqdFfnY20hkh1jpwpbsIwyv8VyYZU2PPsOfQXq98N0=;
 b=th1zE3O74Q9PIv/eGzRu7ak7ohvXD2GOdiHRWICRK+Q6hTdnPIXKPQzJP8M9QCYSHfRe8Mfueh0dqzcxCGG43hCyF+LmdSul+Fg0nwrCzRFyNM1KyWwYguOgmikEaaPQT0J1z4y2E2tsVBNaUhzJxPVPzeHmQb727ijKS2nBw/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB5792.namprd12.prod.outlook.com (2603:10b6:8:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Sun, 5 May
 2024 13:42:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7544.036; Sun, 5 May 2024
 13:42:24 +0000
Message-ID: <cd9c5b6a-0155-434a-b868-a9ea52e878c9@amd.com>
Date: Sun, 5 May 2024 08:42:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/chrome: cros_kbd_led_backlight: enable probing
 through EC_FEATURE_PWM_KEYB
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>,
 Guenter Roeck <groeck@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
 Dustin Howett <dustin@howett.net>
References: <20240505-cros_ec-kbd-led-framework-v1-1-bfcca69013d2@weissschuh.net>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240505-cros_ec-kbd-led-framework-v1-1-bfcca69013d2@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR03CA0093.namprd03.prod.outlook.com
 (2603:10b6:5:333::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: aa7da996-6f12-464a-d2f8-08dc6d093202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WE9JV3p1d3RPdEV6VGxOVWQwZHRBZ2laMXBtT2VnSEFlNUJFOFJsaTVUelYv?=
 =?utf-8?B?NlJiQ3BpL1lkRlVaVjFvR1FRajVSSDVNd1pMbUkzaWswZFFaRzUwaWtyeGV5?=
 =?utf-8?B?LzFkQzFuZlFHclV2Y0tVWU5NeFNYYk5tN25ncnBhL2cwRXFlUWNXTGFkYisr?=
 =?utf-8?B?Z0xGV25mMkZ1UDZaS0VucUs1SFlYbmV3cmdiT3I1R215SkdyZW9LM0drZWhw?=
 =?utf-8?B?MXMvdGpmSGlrakdsZEM0OVNFSW82bzR2UHRZMEhHY0p3NEY0YWpwSVprVCt0?=
 =?utf-8?B?N0k2clFjOVJIc0dMYllTbWxaNkIySUM1b2o1NFhSY3BzTlB1eEhtVmgvYWFR?=
 =?utf-8?B?c3ZSbXVwNno2bDZRdTFkMU1reHhrUlFSblBaRXVYcFFKVkJaUVEzYWJjN3hK?=
 =?utf-8?B?V3FJZ0sxSVdiVUl4bHBiTkpnYk05MkhOUWVVMU4rWEtJVUdkbG0yOXRoZlBQ?=
 =?utf-8?B?cUVSV1k0TCtWeFljN2lsbHdING5xdFp1TXliZ2ZXVWFuZ25JZm4zaHBZTkRs?=
 =?utf-8?B?VlA1ZnVISS81TWRaamFzdk9kUGViVUhTSFNycTdDK05vQmhpZWRvS08ydnJZ?=
 =?utf-8?B?NVI2ZzhuRTVUVWNiZGFtazdMamVMbVdxZnZrSWo4UXRkQWMxYVVQZE5vU3hq?=
 =?utf-8?B?Q2s3MnY3RmRTTXBQSVNIWklDLzNhNXRnbUNpUklDbkNDZ2NOWElhZG1jQmNT?=
 =?utf-8?B?ckJ1UURaZ0pzQnN2WWxWc0tmU2NkTjk4RTl5eEFJdHRNVjhVWGwwUFpjSGt6?=
 =?utf-8?B?cmh0WDNHcm5aNzRNZ2NJN3dkTWtrV1dVMkVnM2RaM3VRZDF4NGJNYlpYQzh2?=
 =?utf-8?B?dHdGSEhzUER6Vk9oZkZleE9pZ2FNazFnUWVFelcyalFxSFNobmxFU3NoRG8x?=
 =?utf-8?B?VkhxaG1XU2pweU8xd2NXS2NWL2NMYTA2V0JyWGFtVHR2WENRWGtyTk1LajJn?=
 =?utf-8?B?ZkgzTkhQNHJNSGtrclJ6Z1kwamdOZHVWV004NTBxTTZEY1lodXZ5VmRDZFh5?=
 =?utf-8?B?MGthRjRtSzBEUXM5SXpBbDVRTVJGZ1VhbU0rMkdnYUNwUVNQaWYydzUvd3k3?=
 =?utf-8?B?Mk12WVN0Rm1vQURLMHNzVUljc1FrYUhqRWlTU0FnazVzNm5SZGlUV3BjMXdy?=
 =?utf-8?B?MVdvZWQyWTU3bFNVN21YTCtjeTJZWTFtRFdZNlRtcDZWTmR6Rml1RHhVdUJ6?=
 =?utf-8?B?UnlZMWc4OW1NRDJJQzB1Z2J0dDNlMUwza2VsS0VhRFp6bkRZY2NsUzBiM3ZJ?=
 =?utf-8?B?a3Nzay81eTd3V2pVQm56QmpyYU9MR1FjMGJGWXZpUmFYRXJweE9OOGdueWZs?=
 =?utf-8?B?RU9UVVhlS1BOT3NBRU1KbnNUdS9sTWFiL3N1bjBzV3RSWmdLMXROd1p6NlVz?=
 =?utf-8?B?Ykd4MU5LQ0NqM040eDNFaGF3cnZsSlpDZVkwa3gwOHlzQVpzZ1JPRzN6V1NT?=
 =?utf-8?B?Z3pIVHZoakplMDJxNTlrZE5lSDArcGUxRkM1bnVGblE4Tk1RYnRtUzBNanB3?=
 =?utf-8?B?RnFDQUMzaE10eGtBdVZOWkJ6eW1ZeEJUZ1AycDNPeDJxRE5CZzdPY1NoRmVB?=
 =?utf-8?B?U2Z2SndxV3psTTZXdkZMVWRLSXkrSkROSldXUWk0aEVRODJPNmtTTHJTT2g0?=
 =?utf-8?Q?A+vcd4SpvrfzGptdxWue+QMXRD8axzcumVVXiwDZhqyo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2tFZzB5Q2VISE1rcHYxeXRKTWNlOU8rU3B4VXZKTVFwYVZMNkZQRU1EUWRI?=
 =?utf-8?B?YTN6allwS01OdzIyQVhORmVvQ09qTEo1QjIybUtQd1FHTDZiOEdLcEZyZ2Yz?=
 =?utf-8?B?eXUxTFVzQW5lbTFHS1YydnBkZGp5c1k2ZDdhT1AxNDJ0dVJFQndFY0diQWFs?=
 =?utf-8?B?MDhOWlluTVVYV0JKTTlPb0RkSVJHY3hXVXRrY1FKbHY2OUtQRTZQRDRFMkR0?=
 =?utf-8?B?SFRJWlphd0NabUtSc0dHUXF4NWVCcGhIL05JNTZMMVE3UjU4aUJIVncyc25a?=
 =?utf-8?B?dXM0ZUpONTBHV3F2d1dQejF5N2owbTJJWmhza3BTRVB2V2JHeWk3RnFJYkdW?=
 =?utf-8?B?SWpQQmpwbjVCZ2NNNS8vNlc2MDJJdjBXV3d2Q1lNT2thaWFRdGRpQ05Yem94?=
 =?utf-8?B?dVZEejRRc1NIU1I1c3QvbW5rbnlrbmFvbHFXN1pFUEdSVThDY0hYVWlvV1lo?=
 =?utf-8?B?RjFiQzNHYUpMeVNQUVMzVnFBbUFiYzdiaTB6VFhlMzNFUXpPRW51WlI0dzlT?=
 =?utf-8?B?ckQyR0JTMklEVmNjVXpXdE9rc015anVUQkwyRXFkcU9ydnZNNnNLY2dhYVpI?=
 =?utf-8?B?ZHpGazdlZFoxMUcza2k3SVZXazFaaTBVeXUvQ3MzYW1leVo2dWZ2cW5hZVJi?=
 =?utf-8?B?L3RJWDJ3cy9JTFUzSEdaNnhZcUlkTTk5dXprVHlUcjNOK0J0eDJtOW85SURZ?=
 =?utf-8?B?cXUxZjAwNXU3WjhsRGY2V3Z4bXFzWVp5QWtuZjAzL0dEb0VRK3NINUprNGF4?=
 =?utf-8?B?RGN0SGxodVhQbnIrT2JLV3ROcUhVOFZwd0RHMyt1Q0EzRWRzZHNnTlAzaGRo?=
 =?utf-8?B?NDY2M2Q3OHlpK3RYTU8xZWxWTk8wRCsvTERoQTlCclhGeW5NcG9JL2JtSmZi?=
 =?utf-8?B?aXFOVklNUnRma0FsMXRXdi8wTC9mdVVKdXIrNEI3UEFjMXNobythSXBqeGxE?=
 =?utf-8?B?cVFvTytmc3pZNW9aSVZmb05NNTdSdkdRc283eE1JaG52MVIwR0NEdnRMd3pI?=
 =?utf-8?B?U1pQVU5zV05Fd0RXUjVpRjRySkV5UnBscldreGQ2ZlkxcWN1SGppVU5JYXlW?=
 =?utf-8?B?YzJEd1RGWlBKeDEwN1ZCTlY2WUlEZldFNHhQQldCNm85NHRJblEwaGJqK0gr?=
 =?utf-8?B?ZEZwU0JNY1U5ZUw4T1hkMExDYTg4RzFUZ2lMdUNmbXIzc3FDTzRja2ZEdnZE?=
 =?utf-8?B?Z1YxY2Q1SkI2VGJxdVVmQVVhKzNDaEtmZHlkVENDNlZScWRaTHlSQnY2UDhT?=
 =?utf-8?B?OXRoWTJxRWQxWjZUY0I4OHpBRWVVb1hoelJCUVlCbTNEN0JpU3pRSnNjYURH?=
 =?utf-8?B?VERpYy8yRm9pTTBiR01SWThHamJ2SmdqZmtuREQxZlEza1IxdjJsZkFpLzJT?=
 =?utf-8?B?bGJsaW01WTdVRHVtaWRlMVBGSFR1L25WcmVwbnowcHlsSm52M2pTNmZNWkVp?=
 =?utf-8?B?SU9jdHFMZGZidFc2SWN3YjM5RDNKVW5JSStnSFpCTG8zSmxHMS9uSDZIREdj?=
 =?utf-8?B?Vk1Tc29ZTmZPTWE4aTlCSnpHcnRNVzRVR3JuV1M5bkh6aGhKRkVHMW9GMVBr?=
 =?utf-8?B?bjI0T0lpRmdRMzdVenRNT0tGR1prOE01TnV1dVpWV09mZ1ZoN2t2MjhaL1B6?=
 =?utf-8?B?aFhTdDZjREhaVmtSMXV0cVNBTk5UVm5wK1IwQmxjbmVWVGlrT0tldUUxbE1W?=
 =?utf-8?B?T3B5RWNoNWpSdlJiUUx0QU82enh0N0JBV2EwMGErZFgycnFaekMrYWF2YWJq?=
 =?utf-8?B?OHV6QlQwbTN1bGhNdmhwb3I3anlwdUNlWWQvQzRPYU9sRWc3MnVISkZYYkhO?=
 =?utf-8?B?VjlzNTFpMzlwdW5lZUdzMGNKclFEaEpvaHN6cXFNVG5uVkJYc1hGRjRVWHNw?=
 =?utf-8?B?MUcveHl0cmJzSkNEb3JxTko1cmxwRlJpSUFGeE1rQlF2RDd3T0FXclJVSFh6?=
 =?utf-8?B?V3hpWVNNUitmYzB2bm9DWUl2WEhtczJKNGZFeU1Tak5hZjg4ckIvZE9QSWJk?=
 =?utf-8?B?bGdhaE1oMmgvMFhoVmsxT3RicFpna2Fra2duOHVHQ3dFMXN3bDZhRm95cFZZ?=
 =?utf-8?B?eVk0UllCQUtkSlN2cGhrak5OUmRFeUExT0dvdzMxOUdmY0xCNmoyRjBGYUZW?=
 =?utf-8?Q?g/Qi9ZrW+xaAqkkjWtdQ9SqFs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7da996-6f12-464a-d2f8-08dc6d093202
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 13:42:24.2276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBZFcWjGkLlY2sAKso/oVdn0LNH1R/5oGAtIDUw6flAFtRnaofngL4jVdNoKRCtgr7QNRVJxTuPg5g/EaFucAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5792

On 5/5/2024 04:41, Thomas Weißschuh wrote:
> The ChromeOS EC used in Framework laptops supports the standard cros
> keyboard backlight protocol.
> However the firmware on these laptops don't implement the ACPI ID
> GOOG0002 that is recognized by cros_kbd_led_backlight and they also
> don't use device tree.

Something I'd wonder is if the GOOG0002 ACPI ID can go away entirely 
with this type of change.  Presumably the Chromebooks with ChromeOS EC 
/also/ advertise EC_FEATURE_PWM_KEYB.

> 
> Extend the cros_ec MFD device to also load cros_kbd_led_backlight
> when the EC reports EC_FEATURE_PWM_KEYB.
> 
> Tested on a Framework 13 AMD, Bios 3.05.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> This is based on
> https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next
> 
> The helper keyboard_led_is_mfd_device is a bit iffy, but I couldn't find
> a nicer way.
> 
> * driver_data from platform_device_id is overwritten by the mfd platform data
> * Setting the driver_data in drivers/mfd/cros_ec_dev.c would expose the
>    internals of cros_kbd_led_backlight
> ---
>   drivers/mfd/cros_ec_dev.c                        |  9 ++++++
>   drivers/platform/chrome/cros_kbd_led_backlight.c | 41 +++++++++++++++++++++++-
>   2 files changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index a52d59cc2b1e..4444b361aeae 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -99,6 +99,10 @@ static const struct mfd_cell cros_ec_wdt_cells[] = {
>   	{ .name = "cros-ec-wdt", }
>   };
>   
> +static const struct mfd_cell cros_ec_keyboard_leds_cells[] = {
> +	{ .name = "cros-keyboard-leds", },
> +};
> +
>   static const struct cros_feature_to_cells cros_subdevices[] = {
>   	{
>   		.id		= EC_FEATURE_CEC,
> @@ -125,6 +129,11 @@ static const struct cros_feature_to_cells cros_subdevices[] = {
>   		.mfd_cells	= cros_ec_wdt_cells,
>   		.num_cells	= ARRAY_SIZE(cros_ec_wdt_cells),
>   	},
> +	{
> +		.id		= EC_FEATURE_PWM_KEYB,
> +		.mfd_cells	= cros_ec_keyboard_leds_cells,
> +		.num_cells	= ARRAY_SIZE(cros_ec_keyboard_leds_cells),
> +	},
>   };
>   
>   static const struct mfd_cell cros_ec_platform_cells[] = {
> diff --git a/drivers/platform/chrome/cros_kbd_led_backlight.c b/drivers/platform/chrome/cros_kbd_led_backlight.c
> index b83e4f328620..88dd3848e5da 100644
> --- a/drivers/platform/chrome/cros_kbd_led_backlight.c
> +++ b/drivers/platform/chrome/cros_kbd_led_backlight.c
> @@ -194,13 +194,52 @@ static const __maybe_unused struct keyboard_led_drvdata keyboard_led_drvdata_ec_
>   
>   #endif /* IS_ENABLED(CONFIG_CROS_EC) */
>   
> +#if IS_ENABLED(CONFIG_MFD_CROS_EC_DEV)
> +static int keyboard_led_init_ec_pwm_mfd(struct platform_device *pdev)
> +{
> +	struct cros_ec_dev *ec_dev = dev_get_drvdata(pdev->dev.parent);
> +	struct cros_ec_device *cros_ec = ec_dev->ec_dev;
> +	struct keyboard_led *keyboard_led = platform_get_drvdata(pdev);
> +
> +	keyboard_led->ec = cros_ec;
> +
> +	return 0;
> +}
> +
> +static const struct keyboard_led_drvdata keyboard_led_drvdata_ec_pwm_mfd = {
> +	.init = keyboard_led_init_ec_pwm_mfd,
> +	.brightness_set_blocking = keyboard_led_set_brightness_ec_pwm,
> +	.brightness_get = keyboard_led_get_brightness_ec_pwm,
> +	.max_brightness = KEYBOARD_BACKLIGHT_MAX,
> +};
> +
> +#else /* IS_ENABLED(CONFIG_MFD_CROS_EC_DEV) */
> +
> +static const struct keyboard_led_drvdata keyboard_led_drvdata_ec_pwm = {};
> +
> +#endif /* IS_ENABLED(CONFIG_MFD_CROS_EC_DEV) */
> +
> +static int keyboard_led_is_mfd_device(struct platform_device *pdev)
> +{
> +	if (!IS_ENABLED(CONFIG_MFD_CROS_EC_DEV))
> +		return 0;
> +
> +	if (!pdev->dev.parent)
> +		return 0;
> +
> +	return strcmp(pdev->dev.parent->driver->name, "cros-ec-dev") == 0;
> +}
> +
>   static int keyboard_led_probe(struct platform_device *pdev)
>   {
>   	const struct keyboard_led_drvdata *drvdata;
>   	struct keyboard_led *keyboard_led;
>   	int error;
>   
> -	drvdata = device_get_match_data(&pdev->dev);
> +	if (keyboard_led_is_mfd_device(pdev))
> +		drvdata = &keyboard_led_drvdata_ec_pwm_mfd;
> +	else
> +		drvdata = device_get_match_data(&pdev->dev);
>   	if (!drvdata)
>   		return -EINVAL;
>   
> 
> ---
> base-commit: 2fbe479c0024e1c6b992184a799055e19932aa48
> change-id: 20240505-cros_ec-kbd-led-framework-7e2e831bc79c
> 
> Best regards,


