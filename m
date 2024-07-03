Return-Path: <linux-kernel+bounces-238601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04801924CAE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 02:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28B7B1C21E36
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFA01361;
	Wed,  3 Jul 2024 00:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Tu1ywZoZ"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2138.outbound.protection.outlook.com [40.107.243.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DC3635
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 00:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719965733; cv=fail; b=OkUhqJJofHGhmnxWGyakhhSYjbZBFPCsnHkXXhuqsNxw62jo/B9HhPb0saXpLuEdQs4JFtv/ufUjvqLSAbG8XzxlBk+O0xdJWux/h12rbSq3bqfWtqIC4UjTws0hZQpVQ0x6IQ9XYiDJgTuOird2knCwqiHUKWzTmvRR39sOBW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719965733; c=relaxed/simple;
	bh=ieafX6g0JnlCqiMbbDzdZKvXR3zjqh+Y0j15anLG16M=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uuC6Kr7I7jPQt/j9SWX/uF8jnVMm/NZh8I1DkVOJ8QAY175HF75hkZOQMbC9d7+UDaJcKpq2hh2zOViHHt2RlmlZYAIYLqXkHArd+f8fiyfRYiepiEKQk3sue/QMmAIpE07NNrj0q7kMbrrWMzAXx1Jj473bVGfsMtB+dqbqZVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Tu1ywZoZ; arc=fail smtp.client-ip=40.107.243.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2dqJyHyalArfPYH+0hfzL2to4Jo5Otc5wA+dDFVg1EpRGC5pAkzXQ18uvUcwkrZs3kB/BsgZ9CSEbyQSMtX1r0re0PLchbpc2Dz8ilo9Np9MsopcyDHSQPPNhqEHQUvULvzxuySJ6V7f0JlZbxcHfE3/ec+aCIeuZ3ZsKju5WpXKWMPHtLH/x0u+KIOw5s8Ecx9zXQD7g9iQuAv82yTUKZ7YQzAWQiZ5B61GipyLQNAzfSOGkYJREin5NxKs0kcvxolFrH3ki5GvuPdX7QVmbH5Ou4uyBZogFGe4/YhSxyVUj5OdqUVZOh3EoXVDcFpEqD9Jy2WK687/lyDqKUHZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6B0y5tUUxi/asF+i7CCcX1QQ0CbODK08+zOeen+v+A=;
 b=LI76g0apZd2OeyZA8RV0GQ3nckUpCiNHYnCMIHO47aOTEBnWQi1DdbMGwNC+nRhbVFKAV7PS0V2eAkwEQbhy1P6uac+eOopgDty2q9XlOsNv1A8pWCAmhqeHzN8brhkjk+xWSyXLtUgR3QpIJl1LPdLhuP5Nzbz1vxOcGK/cVZUavjlI3FdFK9sLddql47fErWdgsOwFDAEjFk9EXFYraCLo1hBFpRmG0ktpBZhi4vsnkBS1ofz54oFkPxKM3wITnTtH5xppFxDzMow8aqede7cdhnK/HdN8pYu3KpbYeUQEQal1wphvISfoSp+DYK2wph/SggudT1WrybayWTkMyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6B0y5tUUxi/asF+i7CCcX1QQ0CbODK08+zOeen+v+A=;
 b=Tu1ywZoZfjv/PunAGaF1HdKIio/vbMBTDH5ZiXc2tus1+QE5qaSh8rBZHmvnxLHwr1Pp/2nZ2v7MsM5WxOqWx+RoQlF6haiJ/VTLSHDE0gT8Qem7iEP49N29NszqFaF+1wLAgHs0qh8wIVfdcRn4jOZTR5zEAr9x7u7//srHTw0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BYAPR01MB5463.prod.exchangelabs.com (2603:10b6:a03:11b::20) by
 SA0PR01MB6154.prod.exchangelabs.com (2603:10b6:806:e5::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.32; Wed, 3 Jul 2024 00:15:27 +0000
Received: from BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955]) by BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955%4]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 00:15:27 +0000
Message-ID: <546bf8d4-3680-4af3-8d4d-af2d7c192d04@os.amperecomputing.com>
Date: Tue, 2 Jul 2024 17:15:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hugetlbfs: add MTE support
From: Yang Shi <yang@os.amperecomputing.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: muchun.song@linux.dev, will@kernel.org, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240625233717.2769975-1-yang@os.amperecomputing.com>
 <ZoPz14fYSqVyvRTw@arm.com>
 <7a4a60af-e471-484b-a4a3-ed31daaca30b@os.amperecomputing.com>
Content-Language: en-US
In-Reply-To: <7a4a60af-e471-484b-a4a3-ed31daaca30b@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR19CA0024.namprd19.prod.outlook.com
 (2603:10b6:610:4d::34) To BYAPR01MB5463.prod.exchangelabs.com
 (2603:10b6:a03:11b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB5463:EE_|SA0PR01MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: 4969dc94-b60a-436e-4498-08dc9af53dc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEhPc3p1QzVvNnAxdWRKVjE1VjZkL0hhODB6dGtxYm84YTlsVG5pYVhrZkNV?=
 =?utf-8?B?R0ROb0wvNlJjYUE3T3VaZkpwQjJLOHRsVi9aNVN4WElmK2VtYkVXUXN5UE9H?=
 =?utf-8?B?Z2ZIUTRjYnhTSzlrTHpKaCt6aStIcXV5bzZhbGhZOFc2S0tIYlgvQ1ZYSGZl?=
 =?utf-8?B?SnNtVC9KQW1sYjlnMkFNM3NsdHlEWTdpWDJjeXQzM2hmcS81OHlsL1BlYWxT?=
 =?utf-8?B?WlBFWmtmN1VGRjVaMjMxZU1Od2FMaDJnUFRCYW5xOVh2OExPZXZVL0lYV0hM?=
 =?utf-8?B?TDBSN1V1UG1xQ3QxWUQ0bFgycnVsWXhzbW5nb0Z5VFNkaXZYWVBQeVIzWGMz?=
 =?utf-8?B?WDljYmlSMWQ2TzdSWHlBTVRVSFRPbnVZVVBDWk1FQVVYdFZiYytaVnhHVHo1?=
 =?utf-8?B?TFVGdE1RZnJxNEVFM2xwTXdPZzlmSVJHL0p3YXptZjFsbDl6Z1kzcXhUcTNy?=
 =?utf-8?B?MzQ0SDdoS1dzSnFRY1B3V0FERjF5Q0ZYWHlVWDl3bEVPSTZxV1pQT0tOcjBR?=
 =?utf-8?B?bkxmZ1Z3R1c3WUQ4a20vbGtyZzhTRkpsOHNKNWk0Njc2bVRRakpEc1YrWEJI?=
 =?utf-8?B?b3VRdlI0MW4vN21RTjZQUHh0aVZmNmk2MzNTdkwzTm9NdjlhbzUrOHYxZEk0?=
 =?utf-8?B?TkREa090UHZ6Zy91U3VXMHpIY3pyaVpnQjduZDE0TXZmcjZOR3FOb0syeWVL?=
 =?utf-8?B?cDYyem5wUG1ETStPZE0ycGNKUUxzQ09lOCtIV0EzQlM1dU13SzFuVWZhQUE2?=
 =?utf-8?B?blZWeXJiakQ5WDY4WGJiNVZsOGF5MTArQmVneVJtUWJTbGFOOENKaUhkaXZz?=
 =?utf-8?B?SmNSQkhwTWRBWXlEYXFxNDgyejB4ZVllUVR4QmxkNmZqRms3NHBxLzhUK3B2?=
 =?utf-8?B?cThWMWJ4eHZRYUxXdW5sRmVDbzlZajdmai80SGV2cTJOWDFxK1JoaVNJY1M0?=
 =?utf-8?B?ekl2UmlUMEtDYW1yM3k3dEFIT1h4aXo3TG4yS01TNHppUTVLRjhPK1FuOWo3?=
 =?utf-8?B?dzREYW0xQkY4aWhyZEROS0ttdVhnKzl0SVlXVEdFQSsxSCtXZ0dMdzRCY1J2?=
 =?utf-8?B?OVdpQ1drWmNQZDZNTGpsb2pjQzdoZThEakJlT2JqSWFLM2VndUFMWFZyWEl6?=
 =?utf-8?B?d3lGNm9Gb21CT0V2VjJJeTFBdEpCUHBvMis0eGZ3WVAzODdCMy9xb2NJUW92?=
 =?utf-8?B?Q1FMRVloaEtXSnY3RmozbUxlOEF1T3lMNkpOa0xjdXorbjNQY0JNNm1xVzVy?=
 =?utf-8?B?ZDR1ZmdHRHFVcUorVFBHaWlVSTNzbnlYOTRiLzdNRmtmMVRJSFE3V25rR2wy?=
 =?utf-8?B?WXVBTHhiOW5WMXAzd3BESXpDU2cwRWo1bzdYL3I0SGZnM2JyMzNiYk5Nak9C?=
 =?utf-8?B?ZnNEYlFuZVdXNVNGQkQ5TXNsem12QmxlTkdQbVozdnJkeEY0ZjFpeDVIcWV1?=
 =?utf-8?B?cUFKMkx5d0xWbDN4dFBwWG5EL3NNby94and3bC91OGlNTHF3blBsRGR6b2hX?=
 =?utf-8?B?cGRHVGRab0ZvaDlzWGFDSSsvRGNIOXc4N3AvWjduVm0vbG83MmlEMmNaZm02?=
 =?utf-8?B?alozZldyWW5MVFlPa0o0cyt3WWN0SkpWREZkVXdZSFpTWFAyTzJTMmRUOTJl?=
 =?utf-8?B?aW9RZUQ3cVhjcUtaYThtcUYxcGVUMld0TTE1bENOeXRreEFVZTVEVndBemVZ?=
 =?utf-8?B?SWNuWHUrOXFMQm5tazI0TU45ZzNnUk85SGhnWGpRVFZ6ek12RGt3Zis1Nk9i?=
 =?utf-8?B?L3BLK3hpK2RKL2J0ZDdqK1FnNytZTWREeFEyMmVrMUo4S2VLUWpWUDh3SzNQ?=
 =?utf-8?B?cExJRHk4WHRWMVhrZWFaQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5463.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0dDaFNOZnNvZFp0YUM1SDBsQUxYVnBaeEdYVldzbjBkeGZqMjdzOTFSU0JM?=
 =?utf-8?B?SXgwdjM2YTZ4S3JZQkl4NDA1R2QxSHpKYi95eXVvcmRhUVpNM3BYMkhlNEtO?=
 =?utf-8?B?M3NmR3ZDQWg4bFdOWlNNWDVZZm11RVMvSlAvMFpTWlk3SDVOR3E5ckdnNjRD?=
 =?utf-8?B?MlRRZmdXZXdOczIrOXVXWldlY0h5elFqeU1lVDFaRkhnbU8zcm0zbE1INEkz?=
 =?utf-8?B?bGNkM2o0Y1lIRC9BTlVsSVVZcGY5VjduSENZYUtnRkc3ZG1TVVdkVnNCWDI1?=
 =?utf-8?B?WUN6R2dwSjRMR29vOHZqVEdQV3lxczhGQ1VadWkrY296RlE0MGRTUkQ5elF4?=
 =?utf-8?B?UXQ0V3N6Nm5rL0svUmE4VlJJOERWZjR4bWhqdHVQemw2bVlwSzNrZ29zUG92?=
 =?utf-8?B?c2c1VEF3OERIQjNXdFAxWEc0Wm53V2N6bkV5aXgwQTRyU3E2dG9rQjYySno5?=
 =?utf-8?B?aTlKL29SWFhJS1FhbVR1VEpGYUFrWXc0bG15Nnl1eURyeGVONkZLKzVxVzlM?=
 =?utf-8?B?c3E0R2dSbHUwQ3A0NElrVHpaamZKanUvbHVaNkJpdmRuY2FvMnJQMFJuVjhJ?=
 =?utf-8?B?aElqM0dCb3dxdlU1elhxelhhbElUd1lhaU1PR1BxSjZydGpkZ3BpL1E4TFU1?=
 =?utf-8?B?WlgwRFVYd0ZqNVBmemJFMVU2WHdteFpHdlJKQ2hRK2Q1eUdCSTcvSitWQUxF?=
 =?utf-8?B?ZTFlQ05ENHd1MVRSdUxOb1VVODA4Q2RlRG9EOWpjdXZNYkx2bmRBNW5zamtk?=
 =?utf-8?B?cHBVc052VERlOE51SGh4N25XbTNmYVNGbHJ2YnhYWEdBN3JHWmpPeHRrREpu?=
 =?utf-8?B?V1craGFTZlMweUlnVFNGclplKzJEUjJsbjViSVRlVlFjaUEzbkJMMWp6MXFz?=
 =?utf-8?B?QXVEVUNUd0o4bmlkZzhSU3p3d1RtTWhyMHg2UFBnSEVMV3FHOUp3eFBQdE5i?=
 =?utf-8?B?TWc4Sk8xeWNzYXhFRjN0TXBSNFFWTGY5U3FyaS9BWjlwbThZUEVNSCtacVpG?=
 =?utf-8?B?SU8xMDBOSXlFeVlENnlVUGJDN01JNG8vZXVaNE9pTXorR1dWU2plYmE5ZzN5?=
 =?utf-8?B?Smt1dS9TOTRxOEVrck5aN2VrQ2YrNjFwcnMxdC9MMXJPN3dqMDhvZ1A5cmk3?=
 =?utf-8?B?Q011bE1kc0tuUHpJM3o5SEZwdTFYUXdYOXJEZVp2TGEybGdiNzNuSUE4TVY2?=
 =?utf-8?B?dFNIWXpVK1VtbUtOeUhxMzNFelhWSWZCSmxCcmRqT3ExNXlsOUZ3Mm15RGJS?=
 =?utf-8?B?VERENGR3MktmTjhHWEtxN2s1eWZmSERsamF4M0k4L1lqM0tVTU50MDF2WGsr?=
 =?utf-8?B?ZWNYUnRtYitURkVad3J6QlVIT2ZTK21yWHBYVjFualhJWDdmblRQZkVQenJV?=
 =?utf-8?B?dU90ZUxtaXNSSDRxK2VEVGR1ZEQ0TS9mQ2oxL1lCa2VKeG9ReERIMW9FMUUv?=
 =?utf-8?B?by9kYlNiNFFIdXczZEY4YVliaXBWejNhbEFZb21EY3dDb1hqbTk2U2wvS3J1?=
 =?utf-8?B?cmwxSmwxYUtpTHpRajYwRGhDVjRVdU55SUFYT0htM0JJMUMrQW05cGhWeTJa?=
 =?utf-8?B?OFBNUU5ISmszb1NlMzFFRlpGdk1aNzRtQytXcDhwMkw3aTk0ZjFSSG1MKytM?=
 =?utf-8?B?emJnbEZTWmVTUnZOcGlqdThyT2xsc1NnOHg3bmJTTWhScVFoV2MrajBmTVhM?=
 =?utf-8?B?YXF1TUk5Yi9CUWVVU0pndm9pVHI5Ymo4RDY4N2FpN1FzUWJQVW5ybjNlNkFH?=
 =?utf-8?B?cG1DbXV2M0QyRXBZaXJNbDU0ejQxb2FhL1NXQWdzS3UydDJBWG81WlBuN254?=
 =?utf-8?B?YUFNT3N3ZWV0eVozQVNNMUtFaVhVc0ZCcnlYTWFuVGtyN2xQMjhPdE1TS0NN?=
 =?utf-8?B?K2pjS25JZjdDMnlMUS9vUzRVTG1FN3dRZFo1a09IVGlJUFEvKzI3N0RKVDlo?=
 =?utf-8?B?Y1Vzd3RaSmtTdWJXVjk5RlZOQTB5R2xLZks1NUxYWFRWamJKNkJZQms0VVVr?=
 =?utf-8?B?NjBvTXhKUjFJN3FsVFZxSXQ4MmR6elhwczZud0NqTHpFUEMzMnRxbnRLSzRV?=
 =?utf-8?B?bW5LVWNvcHlVb3c4UlVFaGxET1U4TjJOaWV4ajRvTVZEdVRrQWRzS0t0Qzkz?=
 =?utf-8?B?aXlmRzNEUG5oQ0V0emZjY3lxMFhqdzJBL1I2cEpYTTZ4dEYwUnE5ZjZVZ0Jl?=
 =?utf-8?Q?GNIzAXYpiVZBCvHBrYhQrH0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4969dc94-b60a-436e-4498-08dc9af53dc6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB5463.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 00:15:27.5082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: axKO1CpKtHEyG/ISHtLwDOcWiYP2rmeBLxnyaNfyjIR5C9e95+VpfNkdPVQ8m1ey4FF5nqJ/jKy9YhaLHysGiVNI4pGaIyjB+a5OBXATAcg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6154



On 7/2/24 5:04 PM, Yang Shi wrote:
>
>
> On 7/2/24 5:34 AM, Catalin Marinas wrote:
>> On Tue, Jun 25, 2024 at 04:37:17PM -0700, Yang Shi wrote:
>>> MTE can be supported on ram based filesystem. It is supported on tmpfs.
>>> There is use case to use MTE on hugetlbfs as well, adding MTE support.
>>>
>>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>>> ---
>>>   fs/hugetlbfs/inode.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
>>> index ecad73a4f713..c34faef62daf 100644
>>> --- a/fs/hugetlbfs/inode.c
>>> +++ b/fs/hugetlbfs/inode.c
>>> @@ -110,7 +110,7 @@ static int hugetlbfs_file_mmap(struct file 
>>> *file, struct vm_area_struct *vma)
>>>        * way when do_mmap unwinds (may be important on powerpc
>>>        * and ia64).
>>>        */
>>> -    vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND);
>>> +    vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND | VM_MTE_ALLOWED);
>>>       vma->vm_ops = &hugetlb_vm_ops;
>> Last time I checked, about a year ago, this was not sufficient. One
>> issue is that there's no arch_clear_hugetlb_flags() implemented by your
>> patch, leaving PG_arch_{2,3} set on a page. The other issue was that I
>> initially tried to do this only on the head page but this did not go
>> well with the folio_copy() -> copy_highpage() which expects the
>> PG_arch_* flags on each individual page. The alternative was for
>> arch_clear_hugetlb_flags() to iterate over all the pages in a folio.
>
> Thanks for pointing this out. I did miss this point. I took a quick 
> look at when the PG_ flags are set. IIUC, it is set by 
> post_alloc_hook() for order-0 anonymous folio (clearing page and tags) 
> and set_ptes() for others (just clear tags), for example, THP and 
> hugetlb.
>
> I can see THP does set the PG_mte_tagged flag for each sub pages. But 
> it seems it does not do it for hugetlb if I read the code correctly. 
> The call path is:
>
> hugetlb_fault() ->
>   hugetlb_no_page->
>     set_huge_pte_at ->
>       __set_ptes() ->
>         __sync_cache_and_tags() ->
>
>
> The __set_ptes() is called in a loop:
>
> if (!pte_present(pte)) {
>         for (i = 0; i < ncontig; i++, ptep++, addr += pgsize)
>             __set_ptes(mm, addr, ptep, pte, 1);
>         return;
>     }
>
> The ncontig and pgsize are returned by num_contig_ptes(). For example, 
> 2M hugetlb, ncontig is 1 and pgsize is 2M IIUC. So it means actually 
> just the head page has PG_mte_tagged set. If so the copy_highpage() 
> will just copy the old head page's flag to the new head page, and the 
> tag. All the sub pages don't have PG_mte_tagged set.
>
>
> Is it expected behavior? I'm supposed we need tags for every sub pages 
> too, right?

We should need something like the below to have tags and page flag set 
up for each sub page:

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 3f09ac73cce3..528164deef27 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -228,9 +228,12 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned 
long addr,
         int ncontig;
         unsigned long pfn, dpfn;
         pgprot_t hugeprot;
+       unsigned long nr = sz >> PAGE_SHIFT;

         ncontig = num_contig_ptes(sz, &pgsize);

+       __sync_cache_and_tags(pte, nr);
+
         if (!pte_present(pte)) {
                 for (i = 0; i < ncontig; i++, ptep++, addr += pgsize)
                         __set_ptes(mm, addr, ptep, pte, 1);

>
>>
>> I'd also like to see some tests added to
>> tools/testing/selftest/arm64/mte to exercise MAP_HUGETLB with PROT_MTE:
>> write/read tags, a series of mman+munmap (mostly to check if old page
>> flags are still around), force some copy on write. I don't think we
>> should merge the patch without proper tests.
>>
>> An untested hunk on top of your changes:
>>
>> diff --git a/arch/arm64/include/asm/hugetlb.h 
>> b/arch/arm64/include/asm/hugetlb.h
>> index 3954cbd2ff56..5357b00b9087 100644
>> --- a/arch/arm64/include/asm/hugetlb.h
>> +++ b/arch/arm64/include/asm/hugetlb.h
>> @@ -20,7 +20,19 @@ extern bool 
>> arch_hugetlb_migration_supported(struct hstate *h);
>>     static inline void arch_clear_hugetlb_flags(struct folio *folio)
>>   {
>> -    clear_bit(PG_dcache_clean, &folio->flags);
>> +    unsigned long i, nr_pages = folio_nr_pages(folio);
>> +    const unsigned long clear_flags = BIT(PG_dcache_clean) |
>> +        BIT(PG_arch_2) | BIT(PG_arch_3);
>> +
>> +    if (!system_supports_mte()) {
>> +        clear_bit(PG_dcache_clean, &folio->flags);
>> +        return;
>> +    }
>> +
>> +    for (i = 0; i < nr_pages; i++) {
>> +        struct page *page = folio_page(folio, i);
>> +        page->flags &= ~clear_flags;
>> +    }
>>   }
>>   #define arch_clear_hugetlb_flags arch_clear_hugetlb_flags
>>   diff --git a/arch/arm64/include/asm/mman.h 
>> b/arch/arm64/include/asm/mman.h
>> index 5966ee4a6154..304dfc499e68 100644
>> --- a/arch/arm64/include/asm/mman.h
>> +++ b/arch/arm64/include/asm/mman.h
>> @@ -28,7 +28,8 @@ static inline unsigned long 
>> arch_calc_vm_flag_bits(unsigned long flags)
>>        * backed by tags-capable memory. The vm_flags may be 
>> overridden by a
>>        * filesystem supporting MTE (RAM-based).
>>        */
>> -    if (system_supports_mte() && (flags & MAP_ANONYMOUS))
>> +    if (system_supports_mte() &&
>> +        (flags & (MAP_ANONYMOUS | MAP_HUGETLB)))
>>           return VM_MTE_ALLOWED;
>
> Do we really need this change? IIRC, the mmap_region() will call 
> hugetlbfs's mmap and set VM_MTE_ALLOWED in vma->vm_flags, then update 
> vma->vm_page_prot with the new vma->vm_flags.
>
> If this is needed, MTE for tmpfs won't work, right?
>
>>         return 0;
>>
>


