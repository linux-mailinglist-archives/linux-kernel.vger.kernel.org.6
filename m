Return-Path: <linux-kernel+bounces-522401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C0DA3C9CD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28BE5189B26C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16468230997;
	Wed, 19 Feb 2025 20:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="URdxAsfP"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE34215042
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 20:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739996998; cv=fail; b=fi3hEMqCrRe75AR/2JWgFnne110D3ESTCOPjtJ7sWako7TcmY/yPLST+GQKHHd6cHOvV21D+27ZBQZ+RE7il2UWA8ZzBDdgfGvAuAKZ5XfphCnwhESZdN3VyR16auUYkhCp2/IxiGNWbKxdQJ/fW8fZ+wrpbnA1LoWA7oXumiuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739996998; c=relaxed/simple;
	bh=2kohjO4URlBqvxpT7vHj8IbpaS/sNdpS4TFk18CXZDg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XqT4Ny217QXkZoJ3H2xLQoLwiDAAA8SToj0l/Wy7efZRQPA1f/avEBZjeVJa/262vq7F8MKvxF6rpOrZM/QrXKmLKYUGrP/RUxWCh36eFtK5AlDRZeJqBTpgK+DUSR0OtKZ1j+20zn14Trffd/QhJajxAzf86GfUURyVVPUzor0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=URdxAsfP; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OMbmMlmtQlcE4dmpXgiYSYhVj5DiY35AnpCChtMbGMoUvIeeDegxeDikLZbPipLFvBflZbgTudJ5nhEtxF1meDA3GY1XvXxYpVSqNXsB+/nKB1gAXdBxvrKZHyQuRBWn0b0PahYPaOeQ24l/NqYZRYNkvx4DwoQSPmd7Da5o3svZ5LTYWBeMKiXy5TN2WCcXsGFt8mRbDlOq4vfSQoqN+/6pxXpNGmgQOPl1S0+beOBS/A7rNxD20IDBS3/IIUu4xa8QaSKK6UdZfcPYtjPzxFMEfuxvY3vARKPCeve3xWmsP8WjlB3/LqVfaek1oPvPpeLs5Ec2eOTaesQA9az1JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqRKH4l11IuPkXHIPH7K86P/G6MJU60slMuIfbmayPY=;
 b=ObSs4ZcVMsNpjaEz00PQrJHu/ykFuGA8g6GR6zqCcaz0D03rbsdbVuNsQJyULJ3HudHUJDFdrpeIZNd38mQjJk+6vV2PDOawn5U4j9cm35l61yoEpMlFQa44VVZDLzWS1BiZ7DjFBeTHLsmA6BXc1acksW3TpLy9oqwnbk4Vp76qRDMeQf8V92LwX4YhhzMYKvD0wYJvdryDjuekfSX0/46fE5eraYlCrWpleazaBHTPypWw4DfpgbN97dDerShOkIIQGTz3NWgrqD8mb+6Wmwus7Wn0/5rUth+7OtKWk8eD1H2bvLd4NLnDhzSRzcxAKH4PWhf1Ixkeu48axVtLGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqRKH4l11IuPkXHIPH7K86P/G6MJU60slMuIfbmayPY=;
 b=URdxAsfPM4A9XV9YQKIVT5K2/PMQkkG51nzDdgtnNJ/M3qvMoIX8DKjLexAS6IVfI8Wgp2n928PrExP5qe9P/0Hr6jvsMJXkWZsus60dYFJ7hP59wzcHo2zrYglOn9HVMwfGpILVT4EDQHqO4B9eB2F95+cB8o1S++2r2+rb09I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SJ5PPFDDE56F72B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 20:29:54 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%4]) with mapi id 15.20.8466.015; Wed, 19 Feb 2025
 20:29:54 +0000
Message-ID: <57df3cae-a70d-48c7-a623-fe8194f620cc@amd.com>
Date: Wed, 19 Feb 2025 15:29:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mailmap: Add entry for Rodrigo Siqueira
To: Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, Leo Li <sunpeng.li@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org
References: <20250219184702.242924-1-siqueira@igalia.com>
 <20250219184702.242924-3-siqueira@igalia.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20250219184702.242924-3-siqueira@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0079.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::25) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|SJ5PPFDDE56F72B:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fdf8bd0-4768-4fb6-6e65-08dd51242b14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUVjcXBCWWRaYzNJUVVPc0llMGpaSFE3VzJvanljRHFtaGVERGV2SHVld3lF?=
 =?utf-8?B?V0dZc1hyeGlwNDVYOEJhK2FTazJQTWNUaW9lU2FobTRZYUhOdTZ4V01YMktV?=
 =?utf-8?B?OWpOR0k0QVJQUmlGM2djVUhVUlBURjBPeHlwWHF0RUxXRE56VXZEcWxybGxv?=
 =?utf-8?B?M1RXL2Ivb3ZwMzgzcmE0RWN4VnZDNHpiSm12S3oyTHhjR3lOK3ZOcHRnc3pS?=
 =?utf-8?B?SUtndldTdEJCMTMxb0FINkM3Yzg4MGZseXJkSWE2YXpaZWZUTnV2SXR2Yzkv?=
 =?utf-8?B?bXN0NlgxTE1mUzNXOEZDV2xQUFo1TzM0WnNyQ09DVzBRMFhIMGdldzZGekxi?=
 =?utf-8?B?N2ZXWUYvNjNOeEtWTGZ1RXpYbnB3eTNzdm0xTGZNbkNyNC8yZW5SbEd6alZR?=
 =?utf-8?B?R0tDVW5UUGZibUJ1aVNlTk9lUE5HMU5zc3BsaStqa2NvQXhqcytTRGF1MUtP?=
 =?utf-8?B?OHB4MGdQajM2M1I0VVlXNjRMdmhwNHhzdUFFNk5oOE1jcFEyazhYZzFNSzQw?=
 =?utf-8?B?M3V6cUx3SVhvR2ZMUHRScWpydzhPZHIrVUc4ZHRRQ2tQeFlCV3luMzhPQ3E2?=
 =?utf-8?B?N29RRVM2SUxkcXBiVlcvc1lCU2x6SkRhMlZsUGVSWDBtdFlWdGVLWDZ6SjBa?=
 =?utf-8?B?azkwUzZYTkQzRkFnWXhLUDhaUXRaZFJ1azU3ZHVHTTZ4dlRqcjdKUW5ubE1l?=
 =?utf-8?B?d2lpVUdPTisyQi9VT1FPbG9QSG53MjgvNVpsUUg0b3RVaDJPU1U0cFlDVXJn?=
 =?utf-8?B?dGFFRjdTQmJYYWttYVJQRnJ6dzdtQ3lJYzVVbW1Vc0NPRllhZEpqb2N0UGd5?=
 =?utf-8?B?T3B6NEwxd09keG4waEd2Y2JaNFNqWU53U1RVQURiVHRpQnpMaGJJRVZDNnVo?=
 =?utf-8?B?VUV5UUdKbTl2YnBIaTZiRG5lTTNoZ1ZZR1VMeUVFMVR0WHB2ankvM3JEaU9u?=
 =?utf-8?B?dmsrbTZvODgzMmJySVg0d3V1V20vUXFTRnltVHo0U3BuSnBkUlV1dE1Bem1T?=
 =?utf-8?B?Yi9BaUYwMjMvTlhaMzBhQ3pvWlF3eU1Oc1prRWNvdDUrY0xVMmQ2VDBHVThm?=
 =?utf-8?B?M0o5aU1BYURJTTlramsySE5MNlYwV0xwTFJzQ0lsWmN5NkJITG5KK283MlNq?=
 =?utf-8?B?UDdQNFZQM3cxakg5Z3R3Z24yZTg1TDNvbXdadGNBaFlSemVHdm5PKy95Yko3?=
 =?utf-8?B?c0hETUtkdW1DZWtCOU9ISitnYmxtMUVZMmtuZEpvSHkzRmlLMW9SWHNCVEdU?=
 =?utf-8?B?ZE5razN4Y01SRkljS2s5K1RmVE1MbFZrOGlmWVlHeElhcHBGSDBFdUw1UGxl?=
 =?utf-8?B?bHpESUYzYVRmK0pzWkF4OFY4TitmRElMU0s2aEY1Tk5LUU12NEtWbnJlVWJ0?=
 =?utf-8?B?dWpqbHZUemlUS1dScXh2eERablBoeHRveHFJQzFvMVMxc2F1ajU0WXhVNTA4?=
 =?utf-8?B?RUZTUlV1dnY4TEVMcGhLdFBWRDYzaVJxNmxTY0VpcHRnMTRTYVNmOHpjZGdY?=
 =?utf-8?B?OW1ES012dlo0b0NVWEt6K09FTElzdjBrQldPcGpIQ21kMmFvNklodXdzcWdT?=
 =?utf-8?B?SzFHdGc2cWVva2lJZTVwT0xINUxVd2IwejJ4V25oSHEzUXhxZE9PMnpVaXVV?=
 =?utf-8?B?QnkvbWdraEdEYU1SQkZhMTNaV0Y2WjVCUzNmUXpURW1WbUxlc21Zc3lCVG04?=
 =?utf-8?B?akp3U2VXT1dlZkxyYlZzL2ltN1Y2ZzVoUDJMRW9lMExYSStOWEIvVnBRUHM1?=
 =?utf-8?B?M0NPQm95TmM5VENwOGxGVk8vZXBjVUJWK0hYRGdGbGtuenhwSXJyRGtCZTVG?=
 =?utf-8?B?aWhnSFdsd2ppQVg2TkptMlFDRzhyL0FENk56djdNYjNuUXFKUnpDV0xSQi9w?=
 =?utf-8?Q?OPEDfmREIyx9V?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5427.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUhaSndtYldXelZURHlVK1A1RmFYN0RaWWdaTTZibFUyUThuWXZkdzlGbnFi?=
 =?utf-8?B?QmZRQmpOQ1RYNUNtZnZJTG5MZ2I3QXFHbExxaWljSFpWckZDNk0vVFhEaFRv?=
 =?utf-8?B?TWhHdFhSR2dJQTlSR1dwcjRPMjZla0JiVkNwTTd4aFM2VFo5L2xmZSszT0Ir?=
 =?utf-8?B?VHB6TXQxeUVKVFc5SDVKUFcvcnJzUmVaK3BsUzc0eVRJSE52UDBJRTJrelZj?=
 =?utf-8?B?SVM2Vyt2WlJsaUZzaFhUYU13TFdDaHg0azN3c21vT01uejgrZHZxSmVBeWFZ?=
 =?utf-8?B?eWwycEcyTk1QakJSbzJ4NHVXK0hrcmllOWp3T0IvR08wMjhvLzdNZ2JnanRM?=
 =?utf-8?B?VGtOTzNqWE5MZEUyc1pWMUVpV0oyZGRKbWljS2h6WUxOcVdPOEorZ2FUU3Br?=
 =?utf-8?B?TW9ic1I3MUlpVFdkTldNWGRacnRJeGxjV05YM3o2d0J0V3gyejY1dGxTWkFK?=
 =?utf-8?B?blBhYStYeUZQc3N2aHZnY2lRclJPSDRjb0JadTdHYTlVUmdtZDFxRFMySEhP?=
 =?utf-8?B?SXh4ZHo2YzA0OEk3Z1pRRUhtV1ZJaVgwMmpwVzEvVEtSOExRbzV1eXpoUGQ1?=
 =?utf-8?B?a29tZGJmY2VFZEd0UExxZlg1aHdMY2xBNjBJWHRXODBBMzNUTTRrcWxhYnZQ?=
 =?utf-8?B?YzNUTFNwUXVPTUhYS3hvbTRqa05BdkluQkVTajZtL3B2L2wvLys2Um1aVXQ4?=
 =?utf-8?B?RENVMUlSejhKV0k5ME1lK2MvS3NDNTJ4cUJsa2h6ZFBLdGVFVXJuZXZURDgz?=
 =?utf-8?B?MmlSaTR0NTRDRG9XLzByc3RuVUg5VlFJNEFPZjA0Y1RRUnFrUW9SL0FHMnlX?=
 =?utf-8?B?RHVXdHIrUG1kb2toUC9kckYrdWg2UjByWC9lbVZSSVVseHFBeVlhWEdnVndl?=
 =?utf-8?B?WXNEUklMWnNBWU9xNW8zQjFyZFJhMEk1VDZaNk5ZaDZjcXFOWHZvbHMxQVIz?=
 =?utf-8?B?ampadWxEdTQrME1QQ3BRT3FWVGFYU2o0Z3ozTUdXcUhqYkVGMDBzNVMwSzR4?=
 =?utf-8?B?N2VWZ01YSlFyYXVkejd0RnZESEhidXVCRWdEbjE4ejJIUHgrQ1d3WFdvczNs?=
 =?utf-8?B?ZUZtSW5WUDlBdWlqM3Y1NGc2SnBmcFNQZ2dzR0dtUkE1OXB3QkJwek55dmFy?=
 =?utf-8?B?U1kvcG5rZ2xrZlcxY3NmRkpkblhycmRlUDB0a1ZLVk5EVmlQbHYvMG5adnJH?=
 =?utf-8?B?YXBOUXM0eGdyQmNEK2ZPWUc1eDBxQmloWEd6T3VCQkhzSWlRMzV6SFI4UGpO?=
 =?utf-8?B?aWtubktod1QwQ2dhaStyY3FHeXpTc2NleGVleUNGcXhDYlUwRjdNNEsrci9M?=
 =?utf-8?B?R0hzd21DU0o4cE5JWHBmczR0Vzg0VTl0cGJtQ01jd3pMWDM0Y05JT0d5SWo4?=
 =?utf-8?B?VytBSnhyUmk1WlVUbTdrUzhHUmhoMWs5Y0tlTGs5djdweDhlY21xb2g3cnZR?=
 =?utf-8?B?L2FVQTVscTJaRloyNzliSlJxWFRCUENuZU1TY24yMm1LcnY2ZGU2QkRsMXZZ?=
 =?utf-8?B?bGtQVDUwMkUraXdyUWhzMXNDT1kvOHhiSEFidkdJTXZXTHkvVnVVcXZwYTRr?=
 =?utf-8?B?T1NncVlXd0ZJaC9nRjMvbjlPUDBIZ09xVTIyMm5RSFpqZ3Jmb1VMMm5SM0JO?=
 =?utf-8?B?MGJNWVNPWDdjY1lBSnFsdk42OGFaRER5aEdkaVorcFF3TS9oN3pBYzk3Y0R6?=
 =?utf-8?B?UmRDaVR1YkFFby9zc2U2akQzTDc4Z0V5K0pPbkwxQnJjRHZNZCs3UjdnOCtl?=
 =?utf-8?B?SzN4aWxxTlM3elZMNGJUV3NKMmpjZm9vVytZTXdOblJXSTJmT2hpMDArbzBT?=
 =?utf-8?B?YjgzMlhtQ3pUVnI5R1NIUTdvMTJFNWIvc3JFb3BLR2Jrekp3VVZiQzV4ZjZP?=
 =?utf-8?B?VmRYM09mTWN0VVNUM3pkVStBekt2SEJ5alR3UFZMR3RUbTlyTGxQSkRscXR3?=
 =?utf-8?B?SHBTNDhpdFRkN0tWMFlwZjE5Y28veFVuT0JvTnVCNjR2aVpDbVFYbDh1OG1v?=
 =?utf-8?B?ZktqTEhHQkZZQXRZVy9XanpkMHdUNUNLYXRvVlpuRlNyYXBJUG0vbVhkaDky?=
 =?utf-8?B?NUkvTjZkQkc1b3dBNFR3OG55YjFQcllxZDVDQ1EzNHJ1THVGb1l5eldjTnVl?=
 =?utf-8?Q?/gXBkhhwMw95L1mYHLScDos/U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fdf8bd0-4768-4fb6-6e65-08dd51242b14
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 20:29:54.1455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XKV8AqFZV4QwyAvCiImhUXey0K2MHNyWYIEtRsKu7XQ8wcn8MxXbG80nRqxmqzHCMafO8jJLDVlJ0G7V21rnSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDDE56F72B

On 2025-02-19 13:46, Rodrigo Siqueira wrote:
> Map all of my previously used email addresses to my @igalia.com address.
> 
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>

Acked-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .mailmap | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/.mailmap b/.mailmap
> index 5e829da09e7f..64413bbc286c 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -583,6 +583,8 @@ Richard Leitner <richard.leitner@linux.dev> <me@g0hl1n.net>
>  Richard Leitner <richard.leitner@linux.dev> <richard.leitner@skidata.com>
>  Robert Foss <rfoss@kernel.org> <robert.foss@linaro.org>
>  Rocky Liao <quic_rjliao@quicinc.com> <rjliao@codeaurora.org>
> +Rodrigo Siqueira <siqueira@igalia.com> <rodrigosiqueiramelo@gmail.com>
> +Rodrigo Siqueira <siqueira@igalia.com> <Rodrigo.Siqueira@amd.com>
>  Roman Gushchin <roman.gushchin@linux.dev> <guro@fb.com>
>  Roman Gushchin <roman.gushchin@linux.dev> <guroan@gmail.com>
>  Roman Gushchin <roman.gushchin@linux.dev> <klamm@yandex-team.ru>


