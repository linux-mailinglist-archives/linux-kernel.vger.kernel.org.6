Return-Path: <linux-kernel+bounces-261629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA5493BA16
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 03:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C5428588E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 01:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD16063A9;
	Thu, 25 Jul 2024 01:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YzTWUPuC"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D521B4C74;
	Thu, 25 Jul 2024 01:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721870580; cv=fail; b=daAcJZwXmOwEvbVcRu9G2dtB89fVNRFw96xxYit7iaUb30NNEQcBnEkZh35HNXDFvHlM/ttIYoqVc07YR/aw6QwC7SwNHZhAVEGqP9XPFU6dyyv4QQ403ueUapeFTKQtkUTMgw/MMfwnCEzxR9o6DtDUStpdKAGxrghDJrDf61c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721870580; c=relaxed/simple;
	bh=EZ0vGHZIrhRpaZEaZRR3gpMihYRV8kuM6+i/jXfsvRE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dKeiSW97cW6rKinHTu4Ktm0hG4zABygz+aGLV1VTXhRwHdY4XQfAjPywAY4Qa2yx0HRARWytow7KDlYvGdixx1yeK2SM5f3HpCf4vLcyiEYXgb0IXkd6Qej9uYNtRmlGIOeXDTUjhOo3nK+jAF9SLBt1BE4zVMTDw2lUs7gpXrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YzTWUPuC; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qY15aI5w1iywf6bQ/bdvyOli9BxiOQGpME1GTZXuhTqB7UZ+WytlpArFNfefaC3cajpvJWfiLL1Cje5+QXdYQ0xT8riC4QudyZ2L+fb6mrN/2WNnRT2Q6O4EUtbfn8dWvHVT8jacMSlKaIsldc3g28cF4fMfsUH0peJYpvhQQKozuCjZ750Sk9BLc5EPp/PX2CSRgrkwVxSDBS5blnMVCmCa40wk9WjY0keDIXHlAXFutU5cjCwFwQEaFl/TdjNVUmCv9VQF0i5J8TADnZ0S6r7g/ttJFEF1+NLNHpUKG03Y5+BP9LGAPt5IsGmxO5k+VzlYty9ckgRLKDzViuUolA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbWWOVValKQL8Aarog2PBRr4NpSqCSj3d4+OSW1ENFM=;
 b=a7Rk8ugkOD6iDBO1yEMGMOBmEut6DVC+UD5UszZJjeS291LxWLuG4up1s3m+TLEUnZN2W6WUn73NtlvlIx5nD69+BYbEFAWv1EcRVLBk++YSYC7t8sA7K4v9u3DJwNq13VMqfr9/kMe19AN7TpYEZnYgDPo+vRJOpX60htCm1AMHZqLLM5VU1fmRgBVLm7QTNLgpwYR+4StN+6fHHsPKIDYiqJcsqxtdPkf9Pf9ic8cFx8vIMo8ga2uYStcBG11LHGp+1BwmnCi/GLXZwUELdhxI3UKvwoP2B6AorgI8K5bW9xhqjaAGVslKVKucot0SvE0LRH1whuDQJaOkXx43GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbWWOVValKQL8Aarog2PBRr4NpSqCSj3d4+OSW1ENFM=;
 b=YzTWUPuC6uVG0gmdvI8IWlh8+ZqIpODrlpAo52D8X0CXXVd3gjmGMoAxRxDornrfruDxdChR4CfExdzGxXTvJJ8DsnVgT3zhVXQ1bew+Z/YCMlGxAVpjo5UwFXRZvIBrVlDU8hmoxBV+IADQZ61F6SSHaVtqu5DM7+hlf9XtdGg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN2PR12MB4254.namprd12.prod.outlook.com (2603:10b6:208:1d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 01:22:56 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 01:22:56 +0000
Message-ID: <54127ad5-8dce-b783-acf2-61bebd0db86d@amd.com>
Date: Wed, 24 Jul 2024 20:22:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 20/20] x86/resctrl: Introduce interface to modify
 assignment states of the groups
Content-Language: en-US
To: Peter Newman <peternewman@google.com>, Babu Moger <babu.moger@amd.com>
Cc: corbet@lwn.net, fenghua.yu@intel.com, reinette.chatre@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
 james.morse@arm.com
References: <cover.1720043311.git.babu.moger@amd.com>
 <49aa5321f6e81825a0e9e44cef06c243634e341a.1720043311.git.babu.moger@amd.com>
 <CALPaoCjL92Jwm=Ynt+pEpSt5KLVxnJL8KOKymZ=WP+cUufy_Uw@mail.gmail.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <CALPaoCjL92Jwm=Ynt+pEpSt5KLVxnJL8KOKymZ=WP+cUufy_Uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0102.namprd12.prod.outlook.com
 (2603:10b6:802:21::37) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN2PR12MB4254:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df800dd-d002-45c0-a1f0-08dcac484fff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkJkTlgwUjJyaFU4eGMyVjMrZTlVNmxLT1JLUFN3c1NOMkhOeThsRlFCSlYv?=
 =?utf-8?B?b2hOK1NYeEc5VTRpNnNwZzFGa1M2TGtrL01ZU3R2T2hMY1Q5ckhTd2xXb1B3?=
 =?utf-8?B?SDdaUGsxSHRZMFNPYU4waHdLREJha2lHc3J6TFJveDBjOGJneXlSY3Y3VGJH?=
 =?utf-8?B?YTBHWHNzNUhScUtCY2I1RWFBVVNvUkJqUERmYWZsU0JiMFlrQXNqWEVVM1NR?=
 =?utf-8?B?WEMxZzFsSmJtWloxYkM2Z24yM0RvaXVXanA5YjEwUnpReHYzTE8vS2hHTGQ0?=
 =?utf-8?B?ODY3T0xpR1ltQmtzT25oS2lHNFpaQ2FkMFdPd3BuUlE4RzQzTTNvcE1haEN2?=
 =?utf-8?B?U0FTWjVvekRjZXAxbUVyZm0xQk5GY3JOTExndlZNalNvdnllYUJscVN0aXE3?=
 =?utf-8?B?a1owSXg0bWhlY2M1b3NhTzFibHRQNFRRb1lpalFxcXN1UnNPclcwb0VybVRv?=
 =?utf-8?B?M1l3UVBUVXVJMDViVG01MkJ6QlRHYWRUSVAyb1pNbkt6N2V2ekx3dld3TlF1?=
 =?utf-8?B?RkRYSS90c3JQRnhFcTBjTEVzUWI5VVgrYjVPaWtldEZ4QlJqVTNSV0pLek1y?=
 =?utf-8?B?dzZxdVIzTkpYTms3N1hjczRDWkpaSDdNVGtrUE8yQk03NHZQcTNyYWZHV1NO?=
 =?utf-8?B?dGEzWXJoeFpDdWJkVG9Pa0VqdEpiVEFyRzdySDgzKzdtVWJHa0JhVHkxMFJp?=
 =?utf-8?B?NkpwK3RzNjJTdHhJb1hEWDcrcXVCNjJHS1RQR3Z5VUt0dndTcmVhRHYxUmtP?=
 =?utf-8?B?TUxpOEt5bjFCRVdEaFpxZlJ2dmc5WFZFeGM5RVRFUFhMMzNscmVNR3l2dXhu?=
 =?utf-8?B?SnkzSURLbkQwQjkya3B3aHBDeGRveFcvSFRtUG1RMWsvOG4xNWF0dW9mTUtr?=
 =?utf-8?B?Q1k3eWM1VktaaE9hYUwyWVdSR1YrY041Z0N4bTZUOGFsR0JlNXBzU2NQdFdO?=
 =?utf-8?B?SW5SbFRKUklmY3lndnc2eiszQkdOS0xRVDV6dStjQXFRaDJlTWdsaFh1WHZO?=
 =?utf-8?B?Z3hBRUxUK1ZpNXhreTdXL24zc2ZId3Urdk1PQ3kvb1AzK1YwMEcyUHd6bFdG?=
 =?utf-8?B?UXNCTnR5UloranpucEJDK0xLWnNDSmtnMStlajJkN1NKR0RwZUpyZlppUURu?=
 =?utf-8?B?QzNVNHp3NnBXMmlFVjFIc0ZZanNDVHducUhLdldUM0txUHVtUDAvMi9pclZP?=
 =?utf-8?B?ZnlLMEtlUnNBeWp0dXlpd0Erejc2OTdzVjJTMCtuWk1saUYzQUxQTWNudHNC?=
 =?utf-8?B?R0I5Yk1yNmF5bytlY25uNjQzWVBicGlEVzN6TjV4cHduWWxtWGh6YlNiUE5t?=
 =?utf-8?B?dFl4aEpPckd0bkl2RTZhcWVsSGtnYnlLU1VNLzZ1aXUwN05HUkFIRmU2T2Ex?=
 =?utf-8?B?R0FEekl2SktpREtncFh2K1dxdG9saXdsR0M4RXZNcmQyTU96d2h1QnNyNjl3?=
 =?utf-8?B?UEE4MlYreXpTNHVlUCs3WXVoenhxYWFJQUhENlNnVFJqZVc3ZEtNTmV1bkFi?=
 =?utf-8?B?YVNZSlFLTVVWS3Qzemp3c1YwZFNTU201NjNNcFRSUVVYK1RSL1B6bDJCLzRH?=
 =?utf-8?B?VERWaTNza2tBTnhDejZKb0RvQ2hSaGZCT2hnRDMzdjFLOUxGUTZGZEZ0S2tv?=
 =?utf-8?B?RGg1V2ViNjJUeEFtMVdYTkJjQS90RGgwMmQyTUhpUWNuTmp1L2ZaWlQyMTg1?=
 =?utf-8?B?ZUJvbnh4R01FM2hYV0RqQ0J0cG9RcmdLOHREeU1YOGxtKytRdUU5QWVCOHlw?=
 =?utf-8?Q?05M9iOCYSgnQCJPTMI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVM0YzVyektJN0hZVnFTa3FtWmJvNEJseHVvbWpueWt5RXpqOVRHUlpTYk9h?=
 =?utf-8?B?NC9yeUVhUUVjVHNuSkNodFA5TTltcXlubG9QOHNKejR0RmdoNkx3K241MEVj?=
 =?utf-8?B?eWVWaW5VMlVTUEN1V0FtWDRWc1ZpRHlIZHVFbUttZUpsQks2MDY4SzlFVlVh?=
 =?utf-8?B?UDJENFNHUk1IVit1aHJSblg3ZkVJZkVFVytwTFdsN0Z6V2xwa0k1Z2ZQTndr?=
 =?utf-8?B?NExGcjRxSE45VUR5VXY3YTFMZUdjZE5Oei9sek1VeXRnaEduVmxiZ1RCL2w2?=
 =?utf-8?B?UWE2UVRiN01oWENHbGZ5YjRqU01BOTZHRXB2STNVdUJXUkVGQ0NPVTJva0Fo?=
 =?utf-8?B?amNtQm0vTmpkSnAyOTNEVTVVUTBUSmw1SzZBY1ZIRWJVSGdITkRseDgySEJJ?=
 =?utf-8?B?NjNTN3NCb1IxVTN1ZldjMXFXTHNEM3UwOHFPQ3V6QWxKQ3M1RGtDMWloNkhi?=
 =?utf-8?B?KzRydFpLVEN4NmhacWd0ZWRZSDB1WGpDUFh3SnhDTGNrMkk3dUVvZTRIN3Jq?=
 =?utf-8?B?WEFQZjRnNllGQkZ6MVRSL3ZRbjBDOWV6eHQ0eUJhVlovM0p1MEdCNmJOSlR4?=
 =?utf-8?B?cm1zblA0bERaazVYZS9Va1VqMjBTdFF1S3pGMDh4UkdjZ3hrYVJhbHlURE5M?=
 =?utf-8?B?UzVJSGs3ZHdRNHM0d0VaUWJqU0ZDc0oydUNjUmg2dXRRSGsxRFQ1eFdER0Uw?=
 =?utf-8?B?d3JkTFdPRmRlbEtTNTlqUmtjUHIwMHkvVUExYm9waGxSOGhYc3VKbFd3aStt?=
 =?utf-8?B?T2hZcDlyT3RUZWlFVTVRZkFjOTZzZmoxNjZXNjE0SEJvcTQyWFluSDZZbHFl?=
 =?utf-8?B?RTRMT2xPWDV3ZlNnVkVaSWFqUlFaeFRIUzVQWUlEOGlrak4zZFRTbVB4T21t?=
 =?utf-8?B?YkdMNHV6MWpWa3JJZUdocnNnWVJIWEJ3Nk1ZTnE3cHVhblBSUVJ0cW9iRS91?=
 =?utf-8?B?anZxSXRyL2UxSGduNzdRQW9XZTk0VGtxekszbTlabUViQW9wY2dOcnpsNElh?=
 =?utf-8?B?Uy9kTHBSem1vSlQ3anRBVE40TmFsVU5tUVZkRTdidEZwcGlkdHU5VlZEYjRL?=
 =?utf-8?B?cGFrcmtkaHc4eXJ1ZWhxdzVFakFJQjFMc1o4OEVvZjBjVWZoenZkTXVIcUZr?=
 =?utf-8?B?cjFCZGJVRzRsNnhMRUdocUwyb0dXSUhJTkdLMkRkV2Q2NEJtVUthNFEvL1NH?=
 =?utf-8?B?aWdzRnJBajZsWmM2enpBNkk0Um5YSmFRYy9KcUFkQnNUbi9BTnRnYTRKbE43?=
 =?utf-8?B?R21yQ04yekJzU3hiby9IdWQwZkZiNHhTV3dQU29mR2VQNndST0RIWW1Kd3lL?=
 =?utf-8?B?ZDc2NGFlZnVHNDhqdGhFUVphaVphcm9GTzNWbjd2T3RZdjRUTFRta1h0ZVVG?=
 =?utf-8?B?NEdYSFBSeEtvcWdxY2N4eVE4cUVCOEFZdkFxMDc1azJvNkVyU2p3azlzNXg1?=
 =?utf-8?B?RlB0ZGFTS2owa1hsMXcrcS90am01eVJsaUNMaE5UZDd5dHVNQTZOQXBsS2JV?=
 =?utf-8?B?OVU1QlFKM2FwTjZNTkp0bjBJYVU2Q1V3T2ROZmNLd0VQWFRocU00MXcvVVNB?=
 =?utf-8?B?Q1M1elpqNFF3aFpzOE5BNUx2bXlMcG9WWlFkQzhJMzlMOTZrV2l1VzdrRUla?=
 =?utf-8?B?WVAwMGJMejg3a2FuS2RCcllRQXFGbDBpcWNHbkNSQmFhc2FPREltOWRxL3ZE?=
 =?utf-8?B?RkJXQ21ha3BrMDJ5alpVVEplR2RZSnhseDJiWUpXQit6bnA4S2I1bjBESGRE?=
 =?utf-8?B?eHhTUzhFYmVaNlNnMFdoTm9vQTUrei9iSzVwOFhVSy82WnViOS9qRjFhUnY2?=
 =?utf-8?B?UWlhaU84eWwwN0dkcTlhTFBiYXp2MjRUL2hDbzY3dklpOVdjTUdjNzlCQ0Ja?=
 =?utf-8?B?eG15MXNYSzYzTlhWeUJmTTlldEhLMldHTUJwbnJWMjZmUG51V3MvNGN5UlpY?=
 =?utf-8?B?UnJoMkFVZXY1alpnWmpKWlA5K3BFTkxXY1dtQmtUOEc4TDJOajMybFpxdFpy?=
 =?utf-8?B?VlJ1Y0JQVlFIUHV6NGpka1I0b3YyL2Y5TlRRR3RBWVRLck5BYWoySmNVZFli?=
 =?utf-8?B?RTJLWmRBWUYxYkhoTHNWU2d2Ym03K2NZMGZka2VyZkVGTUlrVWdYY0NOcDQ3?=
 =?utf-8?Q?1bjk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df800dd-d002-45c0-a1f0-08dcac484fff
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 01:22:56.0980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7J7dKatv5BmLuZDiKKNTyedz05OEAEMr5DLmSZ/swY58M0aMoX2U1mcRJixnsr8X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4254

Hi Peter,

On 7/24/2024 7:03 PM, Peter Newman wrote:
> Hi Babu,
> 
> On Wed, Jul 3, 2024 at 2:51 PM Babu Moger <babu.moger@amd.com> wrote:
>>
>> Introduce the interface to enable events in ABMC mode.
>>
>> Events can be enabled or disabled by writing to file
>> /sys/fs/resctrl/info/L3_MON/mbm_control
>>
>> Format is similar to the list format with addition of op-code for the
>> assignment operation.
>>   "<CTRL_MON group>/<MON group>/<op-code><flags>"
>>
>> Format for specific type of groups:
>>
>>   * Default CTRL_MON group:
>>           "//<domain_id><op-code><flags>"
>>
>>   * Non-default CTRL_MON group:
>>           "<CTRL_MON group>//<domain_id><op-code><flags>"
>>
>>   * Child MON group of default CTRL_MON group:
>>           "/<MON group>/<domain_id><op-code><flags>"
>>
>>   * Child MON group of non-default CTRL_MON group:
>>           "<CTRL_MON group>/<MON group>/<domain_id><op-code><flags>"
> 
> Just a reminder, Reinette and I had discussed[1] omitting the
> domain_id for performing the same operation on all domains.

Yes. I remember. Lets refresh our memory.
> 
> I would really appreciate this, otherwise our most typical operations
> could be really tedious and needlessly serialized.

> 
> # cat mbm_control
> //0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;8=tl;9=tl;10=tl;11=tl;12=tl;13=tl;14=tl;15=tl;16=tl;17=tl;18=tl;19=tl;20=tl;21=tl;22=tl;23=tl;24=tl;25=tl;26=tl;27=tl;28=tl;29=tl;30=tl;31=tl;
> # echo '//-l' > mbm_control

What is the expectation here?
You want to unassign local event on all the domains?

Domain id makes it easy to parse the command. Without that it parsing 
code becomes  messy.

How about something like this? We can use the max domain id to mean all 
the domains. In the above case there are 32 domains(0-31). 32 is total 
number of domains. We can get that details looking through all the 
domains. We can print that detail when we list it.

# cat mbm_control
//0=tl;1=tl;2=tl;3=tl;... 31=tl;
Max domain id is 31. Use domain-id 32 to apply the flags on all the 
domains.

echo '//32-l' > mbm_control

There is only on syscall but IPIs will be sent to all the domains.

Any other ideas?

> -bash: echo: write error: Invalid argument
> # cat ../last_cmd_status
> Missing domain id
> 
> If you can't get to it in this series, I'll push a
> scalability-oriented series after the basic assignment support is
> merged.

Lets try to get this resolved in this series.

> 
> Thanks!
> -Peter
> 
> [1] https://lore.kernel.org/lkml/CALPaoChcJq5zoPchB2j0aM+nZpQe1xoo7w2QQUjtH+c58Yyxag@mail.gmail.com/

-- 
- Babu Moger

