Return-Path: <linux-kernel+bounces-410536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A3C9CDCF2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B58DDB255B1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6C419308C;
	Fri, 15 Nov 2024 10:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5geBqcCm"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E73836127
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 10:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731667555; cv=fail; b=bUGa/1sWcI2dwnlRVbQN0HPDMIiNS+NpSCMjwiwD4CbZ3sDuCYwjAxVCOy2baa815a6wVyABV9AbrOqthJPKw/jf1O3x02sIAYuLZC74eIEDQRL2q5+aLyhs4+DHLOm/D1NDEplfYScTB/uKh8fLUPZksJXROwijq16gHymqh/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731667555; c=relaxed/simple;
	bh=bPd1iyOsZl/ZYLG526MC7YuBlhz0/FCVuAA5h8EaEWw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XUrVlRCR7uDoalvsQ0U2Mr4x29E91Wz+M4fqbmuXNDJhi4jSB3UKNxN+qKBjjgM6MIxfUovhiWYBUS3eB28LMAOIP7oPBHhsVihwe2jaV79R+iiSdmLeDFntv+QI3MKRHoLSAEmrSXmFX5RZc2eIyHwbL7DY5B+8hFgKwUru0Nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5geBqcCm; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eAVafOnYJBglMpiXHTISvkW8kR0P2zCHJCATv9L45bbK87TqWpziiTDI2r4bUnI91MKJsqkPyiIwM6TAlscjJZHzTbs/0OCF9vJjzJSIDtsuuMk48qvMc1p4C28/qywjxtIPfFclJMVR2FhMP00pC/tPYVISsENZIc3zWHFlM0XdDKovgfSvkE3GI84XvJeFF7VNit/7egOFTJRhNJXMJW0S9OIGX3UYZpHUpaYf9YXhd7CeqT7l7qZHmpFUazfCAi2VOPAt0N8fEdNkgvYXIvoNtRvQ6+0QyXVMwud1ROQ0lAvHLXbwCS0tmnzewCyYNEsNrfYuSx0XE6x7s+X07Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0W4zQpwP7vFhx5aeCuSK9qdI28W15GVhI73Wxqs7/Y=;
 b=EK0IMI2fCLmfOcNtSPjfqlILJWfRYErkY53NfNh+Gf78mNE8voIhY/a5PDp3PBAU9KMNYykNN7lj18IvwUB4Jx1Wk5LrNkNYN/SyCWp26FxXmgemz4AlEAjHjnXFHRolAV9bYJkzkoAocIpjCJI8UjXVe1olYttyBwWkmaDhAU+4iuKlhRVgVmQZEQ61KOFavraSZUqtmoUJKl/kJJ1B86lVZkKNTcuqPzIkKfZCFTOOQzsd/G3o7Z/9PNigsNdxKoKrNsAjvuSeG9NYfgF094Ct1wd6Rs6SdCAM3DqfSmF2JtlXrgf5lsSxGqdFHKdCZaps2i8mBtcBXXwFnhERqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0W4zQpwP7vFhx5aeCuSK9qdI28W15GVhI73Wxqs7/Y=;
 b=5geBqcCm3DEJbw2/NwCSQbrfSLkY0clofC3UooUXctOpCbvmiBFPOqVQB7TYAEh5ktOGdeeIS7bKuKpJCzSrkJ4jJIr2rtrYaQYkKhDUC6UOnOHm7C5rYUBeNX/3UiUHys1igjorU86iBrips6eYOlZy0DrZn59rngdeda+R+3w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 10:45:49 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3%5]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 10:45:49 +0000
Message-ID: <1c8e478d-866a-440e-a11f-80fd210cc5ca@amd.com>
Date: Fri, 15 Nov 2024 16:15:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] sched/numa: Fix memory leak due to the overwritten
 vma->numab_state
To: Adrian Huang <adrianhuang0701@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Adrian Huang <ahuang12@lenovo.com>, Jiwei Sun <sunjw10@lenovo.com>,
 Vlastimil Babka <vbabka@suse.cz>
References: <20241113102146.2384-1-ahuang12@lenovo.com>
Content-Language: en-US
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <20241113102146.2384-1-ahuang12@lenovo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::11) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|CH0PR12MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bcc5691-378d-4074-a89e-08dd0562ab20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTU2ZUFZQzVvVGhCcFhjTmhXOCtNaERGbmZaVWVseVRrYlRUZyt3N2lPZ0N3?=
 =?utf-8?B?dS9MYWxEUytlYlJwemRpdXRZTzZCdmdYcUxwdzFRRStQUitDZFFkRGtPaGpS?=
 =?utf-8?B?QzFmeTRYNURzNHRJcnVhSy9ha3I4aWhyaGJvNGNGS05oWXNyMEJ4TlphSW9Q?=
 =?utf-8?B?cXcrZDJFUGxNNkdjSjFuMFJWYWZUZ2ZNVjZDY1R0ZjYvUkdxODUzRUhNZlhN?=
 =?utf-8?B?WnFFcFk4VXFtdFdnY0d5ZUVzQWRBVld1UHJQTlR2ZGcyekVSaHpSajNVSEpj?=
 =?utf-8?B?VTFjckxsZnRxOTZwS0ZyczBnd1E3RGw0V05PQzFVM1FmNkRSTlRkMUxQanMz?=
 =?utf-8?B?RG4zUjliK1hCNDd2UFNkK3NuaUpYS1M1Z3pURlo2NUVONnNJb25tU1BCcmYr?=
 =?utf-8?B?ZDUvZ2Zpa1ZTVGw1dndoRHN0eEd3TCt4cXkxWGRyUDJoTzBnUWt5VVN1UStK?=
 =?utf-8?B?OHJSaWJCaUg4R01SN1VNWnlxbGhTaGdWMldrWlpaK3pkZjZ1aldJT1UvcG9R?=
 =?utf-8?B?R0dKblBXcnNMNnNZSXlPTnNjelVYbExjWllIdVVhTkRNNWhORkIyQnRYSkRa?=
 =?utf-8?B?Q1pCQWdLOUxLSENnaDFMWVJvNWY4RWt1QnJiYkNBbEpEZ0VSQXcxL01Wd2JC?=
 =?utf-8?B?Nm5iSkNSbUU0YUsydDYvZXI1cHA5S1BoTVlBVEJjKysxRThJd2FCdkVPRkNi?=
 =?utf-8?B?TkJjSGJDN2JYcG00cHJrYzg5Z0wweFpiWEFjcEN5QkFHY1k5MDk1T2MvdFVS?=
 =?utf-8?B?L2ZTeGFnREtFRkkwWmVwVWlhSHpFVU1JNXZDcDA4OUcyQ3NjbmQxTEFZRDNu?=
 =?utf-8?B?Mlp1dy96Tk5KVWhnTXRSVjY4cFlaNVp6ekxJYWRjcHFaZ1VKaHowQm9tZ3dH?=
 =?utf-8?B?SXdtYVpvL2VUc2FScXdxZDZjQ1RUdDFLVHNwRVBUckl0UVpYSkZYWEFCQ1FG?=
 =?utf-8?B?dXp6ZVZDdVlGU0t5eVJLVVNYaXAzUUNvK0FzMzdPUVNSdHM2SCt3QnV0b3lm?=
 =?utf-8?B?S2dpSzhhUTY0bTcvcHlZQkloSUZROTlZVUt1S1lqa3lTTkxFb2ttR1F0Sm1Q?=
 =?utf-8?B?Uy9vUVI3SVdEME1YTjF3YjhDTS9NYjhZZWRTODNUWGFzd2NMd24yTnN6dEgz?=
 =?utf-8?B?bTJZVGN0UEMvYjNQRTgxbElwbllMS2ZPT2hGTFJTU3FMcDhzME13VkdxdlJM?=
 =?utf-8?B?T1hYM2x5aEpKQmlpTncwS3VwWjI3ZTIyMzV6a3hWSDZPa2U3RzdLSk5qQ0xY?=
 =?utf-8?B?V1pwNHV1L010aTFvMTRTbDBoM0NsTWNnVDhjcEc1dzAxYXFQNSt1VElCc1dm?=
 =?utf-8?B?UkxLS3F0UVBTc2NnckRBbGlCTVNyOHVhaWQwWmJQdTc5MGdLN0NrNVA0RzM4?=
 =?utf-8?B?azFOTHNobTB3QjA5ci84a2xVN1BlelNQeE9pVThlWUQrZ1dyQS9waktZSmdO?=
 =?utf-8?B?V1RsdUN0aW9VWDRna2JPZERuMVhyYjA1RHBMa2lnaUdTSXRVSHNzSG1WY0Jt?=
 =?utf-8?B?T0RFVmVMcThIb2FweEdtdXB4UkZ2U3ZvR3pFUjVBdmpONGc5RFBuVWxiRnJ0?=
 =?utf-8?B?dmNKR3NqV2JJRG90bU9wMmhaQnBKdDF3SjdQejhwWGFaaW1mQlg0RnRUNytN?=
 =?utf-8?B?RkxMZEFmUzZwZjU1eVd6UzJVNHRIcTgwYitpZjhjU3VQckRwL2JRWHVQR01t?=
 =?utf-8?B?TUJDaUZOdFNsS0VDMmtzRks3UzZTS3NBQWs1MXJwcnBHTDliQXhNdDRkT0Fo?=
 =?utf-8?Q?EkFbtEF7H0hrk8Trwf8IvbHnurSVl/jJCDCVvBp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHJGMklNSjVXY3NnZ1hyWEF6QkFBRmxsTEgzeE44akNxSnpkRm5iWG0vQlhm?=
 =?utf-8?B?YTRONzJzQURBc0swUmxFU001TDFDUit3NVgxTERJTEloa0NZTDk0aEhOeEtS?=
 =?utf-8?B?NXQ4UlhuQkN6WDZBL3N4YVNFdlJNQW9CQ1BQZ3pVVGRtbFVKcnd0ZnBZcVdQ?=
 =?utf-8?B?OUtKcG1IL3BON0FuUFVneU94YlRoeDkxazJveDB5Si80WVNOd2xUc0lqc2lJ?=
 =?utf-8?B?NWFjMXBSZDZabmZ0QXdtRUN1RmVISVZtVVF3MVRYU1hKbExUNXVzNWYyL2Q4?=
 =?utf-8?B?ODFiRzR2Qll2b3VDN0FTNjk0aGNwb0plNi9JeUVxOVlPRVh6NjJmUDVyMHJ1?=
 =?utf-8?B?dGxuTHlzdE1ydTJZcW1XV1psbk9yN09DNzJDL00zMXlYNVZjQkhmQmZaZEc4?=
 =?utf-8?B?K3FmUXRPclFsZmNXQVZLUm83UUEzbTBvSWxFRnBtcFhwL3dyK2lJNU5rQ2hv?=
 =?utf-8?B?clZqbTlqVjNXeCt6N1VTRHpvVVhlMWFJM3ZTcWNsZzNlc0ZZZ1hWYXJtcTJS?=
 =?utf-8?B?Sko4elFyUTNYL1ZlQzhESjVqTno1c0grWlA1S2x3UU83dVJORGRKalhkMXZ3?=
 =?utf-8?B?dTFUS3ptM3NSSGVaVitiUUhuTE1sbHdpbkM2RGhWQUhCTFVGQUQxMEhjMEZU?=
 =?utf-8?B?Q2lrazcrOTF1Y1lxZWI0ZlJZMGZJSUthZFM2RElHR1JDRHVvL2R2Y0kvazgv?=
 =?utf-8?B?TmZiYkRvQmdsUm9oUzFVOTBPMmg1aFNOMEdCMk1YQ1ZveFpuSmhQL3NnQjJv?=
 =?utf-8?B?cXZ5RjdXSFIvY255WWxEV2pLWDBNUUdmcUZ5RHRrT1RXVjFzUFBIaTBuSGpx?=
 =?utf-8?B?Lzd1MzRYMjZya2Q1cnJ3Vml0bXY5cHVncml6V2VRakd0U1hEVU5YOENjejBl?=
 =?utf-8?B?dlZKTVJqVTJZaytJbXhDQmpZQUhESWRkRDEwanZyRW1SdFZlZTF3SHNnL1Bs?=
 =?utf-8?B?NFJOV2NPejF6cXRLNldRbkJBQ2liYzkvcjgwR2o3NlIrd2pLNjA3OTdMYnNY?=
 =?utf-8?B?cGV3UWdDRThhMDdkRHBoMTJaQXFTMTEvbk9Zbjg2c2s0YlJqSlBERkJyY21z?=
 =?utf-8?B?b3hSV05YWGlTaWM1MWliOElnRnlWZjlkQkpPLyszSWNLd0syZnM2M2x3S1cr?=
 =?utf-8?B?TE91bEJObHo1QktEZUF0UW5kMUZEMUNweEF3ZG1TRlUyejduRlJKYy9lWlpj?=
 =?utf-8?B?SUxNenluSE0wNDVHMFlhaFJkQ2krMGs3b2hnZVVHWUZFM1BJam1YdmMzOVZk?=
 =?utf-8?B?S2gzSlV1MlVKTWFnVy8rN2pDdDBrcmJwZXNTYU5TU2I1SFowOEJkTCtnSVNo?=
 =?utf-8?B?QWp1VjhGU0JRckxHdS9nZDB1Y1RNeGFyT0Q2b3VzS01FMmtMUk1xQUowTCt4?=
 =?utf-8?B?ckF1MlQ5dm14UHdYZWxjd20ybEdyUEMyNkN0TVlaeEd4TTc5U3Rpa2Z6TjNq?=
 =?utf-8?B?UmRHSUxyZ0w1UVF1TXg1UWUyVVovbjd6eGdGSjIyL2wwYUNhdzE4OURmMGhP?=
 =?utf-8?B?UU9TTXJVVkRBREI4ZmVqcFlxSFo4ZWZZRC9ETTExWEthV05qSkRoOVF4Z0gw?=
 =?utf-8?B?NDZUYXBjUTRsemJwVnRlMFFoSzZLOXg3b05NNTBLUmRyWmVRUGd3VXJybzZE?=
 =?utf-8?B?WjZubmRxM1pzaXFsTzhlcWVnWEZUcmRDMTAxMjE1b2R0UFJDc2dNYi8zM2p6?=
 =?utf-8?B?Y0kwVk9nTmNWZGFTQmRUK2s3MVNSWU45UGdwWjMwWW1MZ3NncjhxclVxUGNY?=
 =?utf-8?B?TVIza1BzVG1XaEFoSkpHeEtTUTdua050NEhMRngxNzVSRzRZS0lOSzU2dkF6?=
 =?utf-8?B?M0pCNktEbXpPdU15aERZcmpPUGhFQlVrWlVTcEpSUkRiSTFnOGVGZFB6elJ5?=
 =?utf-8?B?Qjhyb3pONWduWlZiZEliOUlYaWdzTXBwR2F0ejczZzVMQzhJVHB4b3VkeXY0?=
 =?utf-8?B?NXJKZ3RETXI4bUZLajlLcFF3UkZReXl1WFM0RVM5K3Z3dnhwMWc1TG16bUgv?=
 =?utf-8?B?ekhFUUQxZkF5UXhMOGlEN0FHblZ2dkFneXg4bWt2dWVrbktGVUVvZTZkRmZY?=
 =?utf-8?B?L2oxWWNDb2FWbWtYWjhPWVlBRzJvQkx5Q0MyRTdaYmQ1Q2tpdG15RjZKOURY?=
 =?utf-8?Q?0hClBkbX1jaSzkSRffrDQPjJX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bcc5691-378d-4074-a89e-08dd0562ab20
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 10:45:49.5723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gfcccw7znvem+SOby5LsvcKOQkuPq6Te4kFn6doZHMncT4rVNe3QhKEjcjUWXfrNABsaB890xCQ52ENAZtonWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8464

+ Vlastimil

Looks like he was unintentionally missed in CC. He has added Reviewed-by 
to V1

On 11/13/2024 3:51 PM, Adrian Huang wrote:
> From: Adrian Huang <ahuang12@lenovo.com>
> 
> [Problem Description]
> When running the hackbench program of LTP, the following memory leak is
> reported by kmemleak.
> 
>    # /opt/ltp/testcases/bin/hackbench 20 thread 1000
>    Running with 20*40 (== 800) tasks.
> 
>    # dmesg | grep kmemleak
>    ...
>    kmemleak: 480 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
>    kmemleak: 665 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
> 
>    # cat /sys/kernel/debug/kmemleak
>    unreferenced object 0xffff888cd8ca2c40 (size 64):
>      comm "hackbench", pid 17142, jiffies 4299780315
>      hex dump (first 32 bytes):
>        ac 74 49 00 01 00 00 00 4c 84 49 00 01 00 00 00  .tI.....L.I.....
>        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      backtrace (crc bff18fd4):
>        [<ffffffff81419a89>] __kmalloc_cache_noprof+0x2f9/0x3f0
>        [<ffffffff8113f715>] task_numa_work+0x725/0xa00
>        [<ffffffff8110f878>] task_work_run+0x58/0x90
>        [<ffffffff81ddd9f8>] syscall_exit_to_user_mode+0x1c8/0x1e0
>        [<ffffffff81dd78d5>] do_syscall_64+0x85/0x150
>        [<ffffffff81e0012b>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
>    ...
> 
> This issue can be consistently reproduced on three different servers:
>    * a 448-core server
>    * a 256-core server
>    * a 192-core server
> 
> [Root Cause]
> Since multiple threads are created by the hackbench program (along with
> the command argument 'thread'), a shared vma might be accessed by two or
> more cores simultaneously. When two or more cores observe that
> vma->numab_state is NULL at the same time, vma->numab_state will be
> overwritten.
> 
> Although current code ensures that only one thread scans the VMAs in a
> single 'numa_scan_period', there might be a chance for another thread
> to enter in the next 'numa_scan_period' while we have not gotten till
> numab_state allocation [1].
> 
> Note that the command `/opt/ltp/testcases/bin/hackbench 50 process 1000`
> cannot the reproduce the issue. It is verified with 200+ test runs.
> 
> [Solution]
> Use the cmpxchg atomic operation to ensure that only one thread executes
> the vma->numab_state assignment.
> 
> [1] https://lore.kernel.org/lkml/1794be3c-358c-4cdc-a43d-a1f841d91ef7@amd.com/
> 
> Fixes: ef6a22b70f6d ("sched/numa: apply the scan delay to every new vma")
> Reported-by: Jiwei Sun <sunjw10@lenovo.com>
> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
> Reviewed-by: Raghavendra K T <raghavendra.kt@amd.com>
> ---
>   kernel/sched/fair.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 3356315d7e64..7f99df294583 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3399,10 +3399,16 @@ static void task_numa_work(struct callback_head *work)
>   
>   		/* Initialise new per-VMA NUMAB state. */
>   		if (!vma->numab_state) {
> -			vma->numab_state = kzalloc(sizeof(struct vma_numab_state),
> -				GFP_KERNEL);
> -			if (!vma->numab_state)
> +			struct vma_numab_state *ptr;
> +
> +			ptr = kzalloc(sizeof(*ptr), GFP_KERNEL);
> +			if (!ptr)
> +				continue;
> +
> +			if (cmpxchg(&vma->numab_state, NULL, ptr)) {
> +				kfree(ptr);
>   				continue;
> +			}
>   
>   			vma->numab_state->start_scan_seq = mm->numa_scan_seq;
>   

