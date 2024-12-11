Return-Path: <linux-kernel+bounces-441236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C40469ECB8D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6BDD1886FC1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6D92210F3;
	Wed, 11 Dec 2024 11:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rrYhCjil"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCBA211A2A;
	Wed, 11 Dec 2024 11:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733917754; cv=fail; b=f9VsbQ0Vxpzf4WXOwopzRwu06xkaownHCD3Zh6Qf5RWwTctG5ajSrH7ZBd2GjMLXLZmuvdxA2rkyAYwrKArlHWHqp3QA4eaXXGjUYjq3bq8dgTL/MkvCAxQQ7cdEHnd8U6nXIaviVF5jpNtcA5AR5BJ9HGsi2zljKGLzqRuS85o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733917754; c=relaxed/simple;
	bh=GsOwKZ9M1Z86e6UcccOXYX947vjry2k1TrwtYMdYy0Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QOvi73NBEUhuNEtCTchgLMj4aeSQ9Fe72my0iBCbTUAWDqM/EXE9saNAGsGK8K3GaW5OTX7W255uz24F1GIV6cYCrH8AaiWAIWji5R0mekg2RY0NlCSJXbeWB5nhygIpe9gT8VP4A9FHqwR0MvSuYeImX76Qzt0BBu0Mo5Oe7n8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rrYhCjil; arc=fail smtp.client-ip=40.107.101.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dt+z0gNdnsKvU4dqIZA9XgL7igvRqIfyw/iA+N4s/IIV/GgrhlKwv0V5pwRXv+KAqzkuXDRCMF+XVpDM61WAHT+2yby/KPp72fqmP7BcP7MK4qxrNDeylu3HhaP1KBmbC/hbhHmnQVA017QEQGenB1YMecBYqaKibMbmTtzkkmlFfY7a2Ug3aXOfpP0DNSOEV1TkF5nQfXBB2ak7a7/dSaV/b5RzvY+TIFJZ2nQ1wfA+sSWL9DidnkkpvB3xr3T+H4Zk+sh/WHQP7yZ1xC4EQf1m2RiPUE7fg5YfYnYoKY5crw3L/KY+pPT/MWqKNgHtjjDlmDFBmG1u1GbkAVSstA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLMCJdsIuVvNdQ2t8dI2LneQ0JVku9vc4KDGkirJy48=;
 b=DcW9XrAC+o4qDD2/nObv4m++HYnHoN4RnfYgZBEfff+IqE5OxlwxL7BzOwJJkWUtimC9c9+JqsmSoh7SWVeYAqxOaADdMf6wSNN32rVnSOsM/1ZNcvWBf857bKmQHjqkCp+8xluGAj3U61j2BnjSv+miEPlcUvvGl8okKrya7ONytRJZDeWr2i2Mf0mCVwX9QzETT0RUUH3SGvbnU7pqnnWRFMAX2nvjAL5qLpOX4s4uDpaVQo6PK55zFC9209JsVL4K5RjpTLbbpxiXqMLkW5nmaesnuyDo74GYWvtbcTpvYo8qGBKzun34iF+dXvHfNHEEF/G61ObSOasjES5jcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLMCJdsIuVvNdQ2t8dI2LneQ0JVku9vc4KDGkirJy48=;
 b=rrYhCjilRz3IWXZq3vZq4xYTBEtByXJNmiK7dAGl7zRReqsn69qqb39h0tMYXhewXppBPzLcXx+EAwGVuZXWRL5qWrUyOXUy+n1LMZ0fpK6tMbDP3doBaEwcWpAeiEUTtlPqDzZBdD/+daVW5zT3BzKrAe5hvPUPXVFVJIG1ZkE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB8901.namprd12.prod.outlook.com (2603:10b6:610:180::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 11:49:10 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 11:49:10 +0000
Message-ID: <844282e1-1c69-4d66-bd98-f9188901c7ac@amd.com>
Date: Wed, 11 Dec 2024 12:48:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: zynqmp: add clock-output-names property in
 clock nodes
To: Naman Trivedi <naman.trivedimanojbhai@amd.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, senthilnathan.thangaraj@amd.com
Cc: linux-kernel@vger.kernel.org
References: <20241122095712.1166883-1-naman.trivedimanojbhai@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241122095712.1166883-1-naman.trivedimanojbhai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0038.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::9) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB8901:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fcacf1d-2efe-4866-1514-08dd19d9d37e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3M3MnlwZDhaZU5PQ2lsMUpjMitndyt4c01TTk1IR3J1dy9qV1BkTmJzTDM4?=
 =?utf-8?B?TUh4MlMvQlh4MzhGZ051alVzQS9QU3VpOTlOYko5SmpoalIvbWtoWXJ4YjVk?=
 =?utf-8?B?T0Y5M0Q1YndiQ3NzVnZ2M2xuenlKRWNiVnJyVEZobGlQR1BhUHNCUUxLbTFO?=
 =?utf-8?B?Z0ZzZG43ZEdoLzRaZEpaMExta1UrWUxMeDZWajlUT0NDbXZLT2huK1pOTzFl?=
 =?utf-8?B?Rkp6L2FvOFNrR3dlcTVGOGJRTUU3d3p6dXM2alpLVFUvSSsvMHlsQStIVnBX?=
 =?utf-8?B?RGxmVWZJaDdWZFZ5NG16MTVYNjh4NTF1bkRtNXBUbmFlWVpGMGMyZnJ6QUxP?=
 =?utf-8?B?UG5OTHpkdk1GVlRlbXd1dk54V0pGL2ZXZEdrbS9IdjRZVFQ5VXUxT3NlaEZM?=
 =?utf-8?B?OEtKZHc4ZHNYN3NZZ0ZnUGVkM21WeG42QTB5SG0rTlMvYm1CcjRNY3RvUEp0?=
 =?utf-8?B?T3lESVVjUU5najJvT29xN1VPL05qeXNvdXYrbDlvWG04dW1QR3VJQ0xZajZ6?=
 =?utf-8?B?OGNEbUtiWCtjZmZoSzJtb2RJbWZMQUowRDM4bHo5VUpDdldtcXlLSnQ5Ylpt?=
 =?utf-8?B?Q2xVM3ZyREFxTWFYVE1HNGluOFFUQ09qZHhEOGpjdlF0VDdvWmlVRVZPcXM4?=
 =?utf-8?B?TmZWYjlrcXVlWnhuM2dwZVljeEFHeGJQcDY0ZWRjd3R0UXlWM2FtWHUyT0ta?=
 =?utf-8?B?TVh1MTVoQ2hsRi9BZTFkV2ZMY1BQTlhjWFVMcjV1N1p0MVBDTmRXcDRBcGRt?=
 =?utf-8?B?TGdKbVVyVnpwMm9OaElZYzZ6UmErdW1KRTZIcVl5dWcxNmJPSE9vZlk4S21X?=
 =?utf-8?B?YlVpRXRhTmhYZlZOSzYvQ2dLMEIvMWowbHpOd3AwdXdJOCtkTnFyM2ZHSWlu?=
 =?utf-8?B?SmFJb1RIQXJIcG91TDBEUEllakg0K0FmcENrNHE2cy9RSFZ5dUlJak41MFYz?=
 =?utf-8?B?czQ2MzhzQW05VWloQmUvd1BEWjhJdW44QzFMdU44SEszdEFhaUQ5UGx6ZzZT?=
 =?utf-8?B?QXN4L2NJc2pObFkwaHhoQ29uN2hMazR0MGRrMStvdHJwL2x3Y09YU1kyeitT?=
 =?utf-8?B?MW9neXo4U1Z6UHdpekdTM0VZdlFxcmI3d3Nkd1VrWTROWmJYYWhiNGVaR2VO?=
 =?utf-8?B?SUZwS1dDei8zdE9SSlgxMzRtaEtEKzdhTTNaYk5LOG1TdzZ0d0ptY2hpVnBV?=
 =?utf-8?B?c0NjcHVad0RMZkVoQzhXb1dERnp0VVJRQUd4UzRvOXZkRk4rV3BoR1hSeDVl?=
 =?utf-8?B?cUhtTzhsNGJxL2xEcTFiR0V0TjBSaGplcmpCaGZ4SkRLc0dUWHIzcXNEMU52?=
 =?utf-8?B?amFpY2pFcjg1U0lqbmtsOUZTZTRHc2RuS3BhTG9ZTVk4L1JaSzg4OXZJRnJ2?=
 =?utf-8?B?dFJFaDJMWlNScWl3T1p6K1hrMWlLOE1PNDZXaXdoaTlNSWVSZzNrWTBHM0ZD?=
 =?utf-8?B?UTgxNjgzWjl6RS84ZzVoUHYySUNwSVkyNjNwa2d5K3pXbFc3MjI4RlNML1Zn?=
 =?utf-8?B?S25rVk83QzlCVjJvYnpzZEhFS21IVC9Gb3hnbjZFVGg3VUJNaDgzbGJpd0g0?=
 =?utf-8?B?SUJITHJpUmNaeWtySnFwd3BYNmFsbXNqY3k5M1pHRnN6S3Ztc3d4ejEyaEJj?=
 =?utf-8?B?YmNhOHdibWFHbk9vMXhnajVWVmRudERRZFR3VytDejVYM2JrUncyYVdkTDhh?=
 =?utf-8?B?eURRdGZZaWlDL0w2d3AxcTVVYWNzRUpKeDRaMWllMXFKTlB6ZjhlemJ1ZTJo?=
 =?utf-8?Q?hOf8FkP86tsWgaYsZo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWtIZTl2dnZGMjV5UXczcFpiL0pKZ0lrZkpOTS9zSlQ0SmRPSWtVcy9GN3dy?=
 =?utf-8?B?bFg5TnQzVlpwU1dFRCs1enI5YUs0U005QkdsL09uN1JUcG5ZYjNOK0pITkVS?=
 =?utf-8?B?ZEVhTDBpYUJpZ0JvRWdhUGpkMTV2SEQxRHhXcnh1bWtnRjZBbGNtVjdncnZC?=
 =?utf-8?B?YkxyZ2lRb20vRXJFTEljSXMvbmlHYm9PeWtHZ1hjdmRxNkVwUXhSc0MvQTdE?=
 =?utf-8?B?bUU2TGMycTNFb3JCSTQyUE1MNmY5a1NiTnRWV2VxQitVVDU2anpUSG1Bb3d1?=
 =?utf-8?B?dTh5QWdKNFBCTTZCRjBITkhPM1ZidTZQdy9sT0JSTFo2ZTdSSCtlcCtWdkFj?=
 =?utf-8?B?cDRlZTZSNXc2eEg4UVdiZmFNSFloWDhHdktJTGR0SkVXbjFxeDV5Z1hJLyt1?=
 =?utf-8?B?MUNuLzZyNHBqVlQ4Nmp3TzlHdEpISHBVczNYYXd3anB6NHUrV0RjZUVEZDJp?=
 =?utf-8?B?WDU0VWVoVDlKWExLVms5MGJDYW83NHhFZkQ2ZnZXeEJPQ2h1Nk5Hd1NHZTZ2?=
 =?utf-8?B?UXJoV25LRFF5ZGhDVGh1eENWZ0tZTzdJWVBEaUpaRStoRDFxTXZxVThWT0k0?=
 =?utf-8?B?cWZ0UVdqVUYvQzlXSWFlUXhaNCtRY01GNC9sNnUvdnNhdUNuOWdRalc3bm9x?=
 =?utf-8?B?UGlGK3NhRkR4dFZSOU4vdFlOZDRrUXpwR0UxeGk5UjZqWC9RRWthQ2d6YXF1?=
 =?utf-8?B?WUt3RFI1SjVOSjVoZW13MWVSZ1FLNmlzY0RrZlpkV1lFSHlxR0RKd0xUN002?=
 =?utf-8?B?QXo1a2NreFMreFpTTTQvS2pkeGNhVTFqK1V5Nk83VjJrZW1FRy9ZMUJZMnBS?=
 =?utf-8?B?d0pXdFdYYWg5MUVjRnQwZm0xeWU2SVVhSWtXb1Q4N1RkY2NFUHNPTGNNV3Ju?=
 =?utf-8?B?V3hEV0ZiamdlM3ZlWENPd0ZGei9JMW1xd2hSVTNyRG9yTmNxSExLVnllM1Zp?=
 =?utf-8?B?eTdRZUhSQjg5VGZuWmZ6TGxhdjRjQ3VZQUZFWEZKTlNXVERqTWYyNytSVDUx?=
 =?utf-8?B?UjFCZ3ZWanBvajJEdExIS0RlL1VBdWpoNWtIb1dlcVlORDFUZWp1dmoxT2Fo?=
 =?utf-8?B?enRJUkNLMVdqQXlsVjNHZ09USXptYXM2WTRTYXlFVlFicGptdlhaYVRLSFdP?=
 =?utf-8?B?UmdLMlAxdHNhc09GY0lRQnowWE5Hd0VyK1hycVoyZ3NIWXZUdkVmVCsxVWMy?=
 =?utf-8?B?SStoMVB2WmtMWU5FVzhMKzduamVlWTFNczFrS0Vwd3NpVnNuamlmN2ZrWUN2?=
 =?utf-8?B?S1crYnFtUElTM2hSME15NGlaUXNrV3N3QldYYmZLRWhtd0RuYVJveXZjVFhL?=
 =?utf-8?B?SnRVbFN6UFpsT2RpUUFKNmU4bk9EemY3UjhiLysyUkdiVlk0bFpzVTJzN1Zz?=
 =?utf-8?B?OHA1WDFZVnhpT25MRUVJQnczOUNRS3dWcStzUitxN1pXRjhSb0RXQjI4Zjd1?=
 =?utf-8?B?K05neloyRkRaZ1dGc29EWXI3Z2dUKzIrdTJSell0SHNoUFVzL2tjazh6VGh1?=
 =?utf-8?B?Yjk3WU55Sk5vOVFOLy9ISHVrR0JYWExpdTB3eSs2UFhScWIxeHROd3ZDM08w?=
 =?utf-8?B?bEd5VGZqclVBeEU0MXd4cXowNHVSTk9VVklkMkIwVkdWazAyZC9DcEUvU0Zm?=
 =?utf-8?B?eXNwUmZGbGVROXVKaFByMGV0czhWQmVkNExVajFWRkYxbW1MeWZaUVJUQWpX?=
 =?utf-8?B?K1pWS1lyS1NTRUlDMHRidGRpR2s1OW5HVjFsN2liR1ZPejcvblR2OEh1YnQz?=
 =?utf-8?B?bUFwL1J3ektyeFFGZVhxSGJVQUU4U2F4cE53OFVmZ3BQcVlydGI4NGxrc2Z5?=
 =?utf-8?B?MVphclY5RVlZMWJ1Ny9obElHSWt1NFpyanhXZWdmdnowUnJlWHlrQUE4YnZH?=
 =?utf-8?B?WDh4UDd3OHhwcE5DalVYVFpKT2NDajNuTm03eHhzcTVUcU1yd1JPQUYzZFVD?=
 =?utf-8?B?Y3p3c2NZdkk4Mk10cm02WVF1WjdRN2xZVklBQ1VnM3BoZHFsa2RwbzRYWENt?=
 =?utf-8?B?OUxnU1hoSlZGd0ZZUHBSaW9lZXQxNk1OQ293RW40b0JKTmZPQTBSOExiV3NT?=
 =?utf-8?B?UUd4UzFxZitSbzlHampRbXhDYjF1NmQ3N3Zyd0NPUFRrT3V5RnBkNURBV3d3?=
 =?utf-8?Q?QFWTPBbbVFn72EAMeOxH7MIlM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fcacf1d-2efe-4866-1514-08dd19d9d37e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 11:49:10.5731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: woSzZLwRfoHS+34gaeH+Weg0BclcQ3aAMFUAGBHiqM+6ssUVgH9ICPoZC0LdiBlE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8901



On 11/22/24 10:57, Naman Trivedi wrote:
> Add clock-output-names property to clock nodes, so that the resulting
> clock name do not change when clock node name is changed.
> Also, replace underscores with hyphens in the clock node names as per
> dt-schema rule.
> 
> Signed-off-by: Naman Trivedi <naman.trivedimanojbhai@amd.com>
> ---
> v1: https://lore.kernel.org/all/c5d6effa-bdcf-49e3-a4bf-3713db889b70@kernel.org
> Changes v1 -> v2:
> - Fix the clock node names by replacing underscore with hyphen.
> ---
>   arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> index 60d1b1acf9a0..385fed8a852a 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> @@ -10,39 +10,44 @@
>   
>   #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
>   / {
> -	pss_ref_clk: pss_ref_clk {
> +	pss_ref_clk: pss-ref-clk {
>   		bootph-all;
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <33333333>;
> +		clock-output-names = "pss_ref_clk";
>   	};
>   
> -	video_clk: video_clk {
> +	video_clk: video-clk {
>   		bootph-all;
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <27000000>;
> +		clock-output-names = "video_clk";
>   	};
>   
> -	pss_alt_ref_clk: pss_alt_ref_clk {
> +	pss_alt_ref_clk: pss-alt-ref-clk {
>   		bootph-all;
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <0>;
> +		clock-output-names = "pss_alt_ref_clk";
>   	};
>   
> -	gt_crx_ref_clk: gt_crx_ref_clk {
> +	gt_crx_ref_clk: gt-crx-ref-clk {
>   		bootph-all;
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <108000000>;
> +		clock-output-names = "gt_crx_ref_clk";
>   	};
>   
> -	aux_ref_clk: aux_ref_clk {
> +	aux_ref_clk: aux-ref-clk {
>   		bootph-all;
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <27000000>;
> +		clock-output-names = "aux_ref_clk";
>   	};
>   };
>   

Apply.

M

