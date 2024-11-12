Return-Path: <linux-kernel+bounces-405424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3FD9C5123
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EDB528237A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706EF20BB39;
	Tue, 12 Nov 2024 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xrHr0m99"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F3F154456
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731401340; cv=fail; b=IDo6HDQ2mNQVotSjqMqFVrm83qgYoNMGm1OB+AqMeakrvwZHXJTzoE5WmUwumovMI6h96k4o0Y7/202nHFLW5Gl4ZhljgYnyNPlvkfy03Zhr+DTMVXZAHUF+NYO2ZLfvm/H3u7HaSit/LQUSL1ZiiRSflxq99EgfFZudidcvP9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731401340; c=relaxed/simple;
	bh=+imfWTxcY5znN+HJ7J7d1r1dKij83jZhLbKb3PjEtt8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f/Q/JalOF4TleJnic0H90N/lqZTl6/T5efrdHhME6RzgfEAqlgXMASviXXPNICk3grTvTSEA15L+bIwsJ6QpYDgLysM7d4SkNAqsYK8qqYPGsfYKZplSioq18NiLvliPSSOEWbe3uEObTUGqjXPEQMyh955lxmYMETX7WTX4mf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xrHr0m99; arc=fail smtp.client-ip=40.107.236.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0bujf2v4WPv5o75PpqJ8qv7iPWxtYplTGGxXV4NCECISCfM0zMAotQvblpSoUr32TzCnCAZ/icug4diiqK4PY7J2pfruqet11V6dGT7V5VBjZf1hooTOM7fKZfpnf7e5E4bA0Qtxekm2RmVslrI36pjAvue6dzH0z+ALQ98QPPnV5pLrMu3GzAj4/KTjGKxwCWvIfly5QwsUgLhJ4TPlqRIMyJ5VxaXnXlnkJWSDS2yi54p6sDdmxJx9Z5CK+jwdGc3PB4Lo8rRbBffkJ1Z+6B/00Rq5PLpKbpa7stnQy7sjqq4+9ZrS4agXe+PiSzJyj0vEqYAcTg8hQpaVCuXZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTMSVWNAqIFW9v3ZW6sAxdeREPimgiGVwuJk6B9pt4A=;
 b=vPvM7NU4mvj6Sr01b8Zya+9pb7KkRyL+Ok2H77ouqdA4FMqyJfmDDmyS6O07MhQXo2pcO5iFQH98aojs9PpB9+VArrtJLGNVwwQXIJSHJQc6BxIEikTKrsxzsycJU9VqQMJkKRW9fiJHV79s+ERpBbp14Apb19cqVHBuh4O/o99g3OU2Hxm/3HHNfgWcXhM5TuMMcwVxH0F59xQVhhQ6J0uK92l73+VuXT6eiLF0romzOTGmrAsY0Q5KKTbCZ5PwJSGBi8yedZC0rYw/th0R2Pkhmb04SSPkqK12GxCkqpctUqbdUB6BhafD6Dn1rcCsojIguq1lyB9MLHccTDNxEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTMSVWNAqIFW9v3ZW6sAxdeREPimgiGVwuJk6B9pt4A=;
 b=xrHr0m99uM5figv1+IU16CX690BHIonMmVJrsPGjq8Yu5Eqz6dXORyZl/rifU7UjAID5Gptsb9wOMFjJmee4QLkRXI3pHyyM5zwxWczg70XZNuL/WCN7mmTiNh2olTMgwWwgNeZde8gMzo2PhEphUqcjHGuMGO+ee/YYTg5AMPM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by SJ2PR12MB8883.namprd12.prod.outlook.com (2603:10b6:a03:538::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Tue, 12 Nov
 2024 08:48:56 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%5]) with mapi id 15.20.8158.013; Tue, 12 Nov 2024
 08:48:55 +0000
Message-ID: <507a8af4-f128-4d73-9d0f-b8a6a15603d3@amd.com>
Date: Tue, 12 Nov 2024 14:18:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] i3c: dw: Add support for AMDI0015 ACPI ID
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Sanket.Goswami@amd.com, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241108073323.523805-1-Shyam-sundar.S-k@amd.com>
 <20241108073323.523805-2-Shyam-sundar.S-k@amd.com>
 <09cfdd95-c566-4379-be17-2d5e0f0e8357@linux.intel.com>
Content-Language: en-US
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <09cfdd95-c566-4379-be17-2d5e0f0e8357@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0175.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::20) To DM4PR12MB5184.namprd12.prod.outlook.com
 (2603:10b6:5:397::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|SJ2PR12MB8883:EE_
X-MS-Office365-Filtering-Correlation-Id: 79d7657a-41d5-4506-29e9-08dd02f6d6b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1RKYmx2RTlaTzZBOEJCTkN4SlF6WEZWT1JxaHpIV3o2WlpwUFI1Q2dna2xu?=
 =?utf-8?B?MGJaRzUvOEJBSGZBV1ZjSXhadG9jRFNPclpOcVk1dUQvRUdRd2VKblNUMlk5?=
 =?utf-8?B?STQrYlV0clZOZmZqbEVNclM1VHovU3J1QlhVYnJhRXdaTnNma3c5eHovdTFM?=
 =?utf-8?B?cnpldGViM0p2WitGc2ZiWGM2b0dwZzdvRmlnbGVYeGhPZHVLaUJwU09UZ0sy?=
 =?utf-8?B?VmRFRER1N21DV1dqNGNEdWgvQVRGTHFDS2IwMGVsSi9JVStKM1JPNE1kNWRY?=
 =?utf-8?B?ZmhtVUVqcjlsaDBmanlNR2lRSTVJTCtFcjVZeDJSWGxFZ1Y4TmgrSW1ZRlRC?=
 =?utf-8?B?L3g4RnFpVWhPcFlrRHdwbUQ0OC9zZ2lGcEtZdWE5WXJWeTlTNW1iSWRBSGtZ?=
 =?utf-8?B?UDRpOE5PdFBBanhNbXpyb05lb1U3VVQ5Yk9keVdvK1k1N3k1S1JWT2Qvc3k4?=
 =?utf-8?B?QTdKMlo1VkR0UkdKYnBnUVZHV0IvQzZxVkVIZmJyQXNrWmhCTzBPZHEyd0hT?=
 =?utf-8?B?b0FUZTUwQ2Nid1hNSTUzUWhIUkVjUmcvbTEvVDRHQWhtVE91T01CbmxpL3Bw?=
 =?utf-8?B?RURXUVM5cXJzVklZM0VTZFh4TmlRTitPRHNLSjJvdDkxSXdNUlN4d01nai9h?=
 =?utf-8?B?c04yM0U2Wmd2MlhpQkU2WDVKSk5zSVN6ZlNuSytGM045alc4QTBRWWF1Qy82?=
 =?utf-8?B?LzBCUTZPUGpJKzZlQ1J5a2tNd1o5S0FheElsUTF3OFFlZGFWTmVjVVo0SEl0?=
 =?utf-8?B?ZFNvYmp5SnZnMk1NSUp3YmdKNGZmYXFsQ0FVOFUxRzEwNUg1L3Y4a1hENnRy?=
 =?utf-8?B?WU4wQzlFRGtzdUFRa3dDekNiRkF3OVRXbDhyalVpeGwweU8rdzJ0Qm5MZU5x?=
 =?utf-8?B?U2pIZXlZQ0ZXYzgvNGhWck5XMVR0LzFTdG9oSmswZU9URHpiUzg2em5VRXNS?=
 =?utf-8?B?c3NrUUhLaHhjM0tqU0JWbVA5SnU1bFEyZlFQeEZzK1kvV3FCeWQyVGlyYUVO?=
 =?utf-8?B?TloxS2cwdzVqYkRzU3FJb1VGc2VmMnlzMUx1VjFjbHgwTHBXWnQyc3hzUzg3?=
 =?utf-8?B?NGFsS0VzSnhMdVJJeHpCMnhKVVpMTzl2YnR1U3hTbE9LZ0ZoeUt3TG9TdSt1?=
 =?utf-8?B?MlNuUlVhK0cyMDloTmV4VytFeUhDUUVuaTcvU3FxVU1oZ00vb3k3Y0dBNUYy?=
 =?utf-8?B?VE54eTNuMGpTZEtuWlJsYmRjYndtOGpEUnRHUkZpelFXTDdjem5leGZlVUdp?=
 =?utf-8?B?RHR2dUJqQmwxdWI4ZmFRSVNhU3F3ampVQnFpb1R1WGNyOEhoaTRSVnAwcUE3?=
 =?utf-8?B?YmlJZVE4VCtObHIydGpReThTOFA1Vno2WlNWNzRpK2UrZE5MTUFzNXNpREIx?=
 =?utf-8?B?ekRCVHp6bFgrYmZZU3Z4b3cvNGNWcG04MGxqNFNjNjJPWE5Xa29Yek5wa1pu?=
 =?utf-8?B?bWlUTFlyT0NGS0tqWHhHRURHM056b250dVRPWXl1UTdmMFE1TThoQTdpRWYx?=
 =?utf-8?B?U2F3cFlZazBmazJtamZBS0dZcXVxTjRWN3grMVFvK09UMXBFMk5pVytEN1o5?=
 =?utf-8?B?NC9CNDdMdExGbm4xTmJPQk1YeUE1OUUralpuOFlDTU5OOVllQnlQYUZmSncw?=
 =?utf-8?B?UXMrQ3diaUxZemlnNnJZWE1halpPZzd2aVhWRGlSVTB0eER5TEEyMFBPRnNr?=
 =?utf-8?B?bUQrMVRiYW9yT29XWURicDRqaUFGVm4wem56REFTS05JcE1NTDMyc2l6WWl2?=
 =?utf-8?Q?incBv594ezqy+WRJ9gCFvw2vZHsOBFsoZPrlf2a?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTlzeHVkZ1RoRGVrN2lEZjFNRUtVdG9VU3ZTdHJqZVNSaFRWVHMwdDl1Yi82?=
 =?utf-8?B?YXFoS0VUeCt0cCthSXdxRkZKMnhhak41dVhER25uQjViTDRvamptVkM2L3lD?=
 =?utf-8?B?NDVOR0tkWTZaeGtYZmlVci8xVVZrSUxrbzJ1VmNRMWgwWGN2QkRISHJiV0Zx?=
 =?utf-8?B?bXE5K3NWUVJKTXZLZ0c4MXVldStxSkR1eWo3dDYyaXFkcXFacER6WURtL29r?=
 =?utf-8?B?eE43QTRqU1I1ZkRCQ2RyeG03Qm8yR2RMSjJ1VTA1bjZSNjZMUm9QYXhlN2xW?=
 =?utf-8?B?VmtoL3BOanpmaUsyeEcxOUVlNytJOTRXQllNbm5zQ2xzU2JNcDVGV29jam5k?=
 =?utf-8?B?K2wzZXR1VTNTQ2g3Y3YyOEh1K0NsUGFkR2FJQS9NeFdKWnJjeWZPbTR3MDRQ?=
 =?utf-8?B?ZEtHODVyUjJpUHV2S003SmVwMytJVDFwUjcrcU8vSXdiU1g4OTZFancvRTJa?=
 =?utf-8?B?T1o3enRaZDJLbEQzVXYzbVhUU1phQlZLYjFnbkRtVDRib3VGbFdFb0c2V1Rq?=
 =?utf-8?B?ejdXVHdlVUkzVUxLd2toeE05MWlIWFA0a2RiSHE2aG1EK1hzVEI5TENZbjgx?=
 =?utf-8?B?OVRKRkYvQkFnQ1FCOE9zb2w5VlR2c2U4Yk0ySHZlL1FPNU41ZFhZTGxVa1l3?=
 =?utf-8?B?S0xLakMrbWJKMXBlM3l0Y1haaUd6M0w5bkY3WTFTMFdJR091MEhuTUhkdk9p?=
 =?utf-8?B?bERmcEgxZlZmb2dPNHU2NGhZcWZwTHJCRVp0MDltdkZXZmExNURvSTQ0MG4r?=
 =?utf-8?B?dTNLdnIzYjk3SmJ4MnJCVkRaMWJPU0NpelY0dWE5SHpXRC80bWtWditaTHo5?=
 =?utf-8?B?VWhLR205UUVFUGRPS0xxc2htRjU3QnhxQXpxbVFlS09jbERnZFVZcXNlZUgx?=
 =?utf-8?B?ajZMUjFJdnZPbXk0TWJZbXBISWxlVjd6d2lpUUp5dWJPSGlFUS9VL2c0TEIz?=
 =?utf-8?B?emdiNFdMUnJCVk80TGQxcENqd0xWbzBoL2Zyb0JzUlRQaHdTVXlPNFlvcFRr?=
 =?utf-8?B?OGhLQTAyRVhKeU9UY3dNR2xxUGRlUWh0czU1aHllT0ZTQ1VUZ3MvRW1NeWpC?=
 =?utf-8?B?WnNoVTY5RU9jUXk1WCttR3JidjJtZHZwZy96amZWb3l1RUtmQytQWm41aDJp?=
 =?utf-8?B?MHFOQWNSS0tUdnhJRllJV3c0U0tqUnBPZDBqdUErcEdNOVZlWlFFcmc1ZjNH?=
 =?utf-8?B?a21jRFltblloT3FGYnVaMjcrYURCUGUwMmVxL09XbnNYYUhSTkRHQTZGaUE1?=
 =?utf-8?B?ZU1ha2pmQ1hVZzZMM3dRRFV1UGhpWEZHdnd3RFJ5YkN0ZG1PRnhoeS9DT2tI?=
 =?utf-8?B?U1JwUmdOclNKdzYyU2tsRGRMaE9CR1ErNko5Ui9IUkp5STIvV0RkSzdPRFRz?=
 =?utf-8?B?eG5UMHNtejdFYWE5YTVLdWdueVFQRTA1R0YzQkw1ckpmTm5OeVRvUXI1Z1Vq?=
 =?utf-8?B?NXVyL0o1U1JSNkY2TVRycS9TZGUyMkhpUHNzNDZpNi9raFdNRmFDalBOSkx0?=
 =?utf-8?B?Rk5QRXV6UFdreEcrdXg5MGVQeU1xRkVlQnlTUkdCbkxCdzdZRFVMZjNyMjdm?=
 =?utf-8?B?ZXkzMVRzYUZuTFFicElpaHA2blpvWnc3MGo3UnVXUi96VjN0eU9ZSDVzRWpO?=
 =?utf-8?B?U1gvVWtHNGlCOHlaZGhGUEN0K0c3NzREN25tYzB0MVhNeW9XREJjbWRFOEho?=
 =?utf-8?B?OHVEd3ozMTQrSnN0YkxFQ1VocTBpWjhMNlcxSkZJb3lYSm4yM0lBeHdNWWUx?=
 =?utf-8?B?TmtIaEIra0lKcUVEOHRxMm81TWpsVXlFYkxWYzE4Tk03RlVKUzV0NXNxM1lv?=
 =?utf-8?B?ejYvaWYvdHozZjg0aXUvQzNEdTlkcDlpMzB6TFBOK25lRHg3aEtVdU84elp6?=
 =?utf-8?B?ZWhMbGNwYkw5ZlBkOVNGTnY2bDBaajdNdHRBemFkckJsRkI1V3lvVkhLWmh5?=
 =?utf-8?B?WVNNVWhDZW9UUVhFRDBJWHI3UVZicjJRa2pZVHRiak5RcjI5T3FHVXpDcVdp?=
 =?utf-8?B?UCs4Slp2QXZXcU1hMDd4aUh0RWplSlhJeXROQ0hPSjBMK0c3R2czZEF3RnVu?=
 =?utf-8?B?TVdCZGR0VEtWU1I2WkdHQkNsL2hmNGkzNmNIMVowZkpadGtURnd2MU1FOG40?=
 =?utf-8?Q?//S7NQ+MMic7djcD7RwQccF5t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d7657a-41d5-4506-29e9-08dd02f6d6b9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5184.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 08:48:55.5863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kj4JgYCXUIbHCps2tNUKnSKd3pGkBSNwLNJykceOD8HzXamrKwNjNJ88/+GjKxTBGiGiDYGdpTVyBlz3BRkkJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8883

Hi Jarkko,

On 11/12/2024 13:46, Jarkko Nikula wrote:
> Hi
> 
> On 11/8/24 9:33 AM, Shyam Sundar S K wrote:
>> Add AMDI0015 _HID for Designware I3C driver so that the dw-i3c-master
>> driver can be probed on AMD platforms.
>>
>> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>> ---
>>   drivers/i3c/master/dw-i3c-master.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/i3c/master/dw-i3c-master.c
>> b/drivers/i3c/master/dw-i3c-master.c
>> index 8d694672c110..1a7c300b6d45 100644
>> --- a/drivers/i3c/master/dw-i3c-master.c
>> +++ b/drivers/i3c/master/dw-i3c-master.c
>> @@ -1748,12 +1748,19 @@ static const struct of_device_id
>> dw_i3c_master_of_match[] = {
>>   };
>>   MODULE_DEVICE_TABLE(of, dw_i3c_master_of_match);
>>   +static const struct acpi_device_id amd_i3c_device_match[] = {
>> +    { "AMDI0015" },
>> +    { }
>> +};
>> +MODULE_DEVICE_TABLE(acpi, amd_i3c_device_match);
>> +
>>   static struct platform_driver dw_i3c_driver = {
>>       .probe = dw_i3c_probe,
>>       .remove_new = dw_i3c_remove,
>>       .driver = {
>>           .name = "dw-i3c-master",
>>           .of_match_table = dw_i3c_master_of_match,
>> +        .acpi_match_table = amd_i3c_device_match,
>>           .pm = &dw_i3c_pm_ops,
>>       },
>>   };
> 
> Am I right this and patch 5/5 can be independent from rest of the series?

Right. 1/5 and 5/5 can be grouped. But rest of the other patches are
equally important because they drive the usecase.

> 
> To me it looks these two patches enable bus communication and thus be
> useful without rest of the series while latter need more discussion
> (I'll have some notes coming) and Cc'ing linux-acpi.

I have Cc'ed linux-acpi in this revision. Do you have any feedback for
patches 2-4 ?

Thanks,
Shyam

