Return-Path: <linux-kernel+bounces-271888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76B3945480
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 00:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9F621C2310F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 22:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A40214D432;
	Thu,  1 Aug 2024 22:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nk6ahN75"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E0314D299;
	Thu,  1 Aug 2024 22:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722551015; cv=fail; b=jChEgBr7TJlv+Rv/+KCdIBiXuMZY5HyLXsqFj8rNKfxovynb05RKDV/3d8i7ZeKLtYO8CRiaHeG9e2TmpC+Yqfsw5weD1YsMCwg1l23zMN6yBniAcKt0+hcIaRD887A/ErExX4pBUJIfmAq43n0ONry+rdJph+HfXS3ldv2nedo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722551015; c=relaxed/simple;
	bh=6GLBQi7VyiFcX5IMcZicKzEsk0YNbupRcCeWn4frYaw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dINRrHQwseXsC+E9l4VfOukosqDHfgAxmd95IooAcI2PKwMGYPIRJdefE4ziXgfYlQ5biaTmO2dGItqvpxf2qeADlgT+a9xZk29gcN7bjUZlukxcN8jlaefGdDPMrbO8EzHVH+NdeWpTdKEfmaPZizYXLZxZsZ17C9aEeSZ2CD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nk6ahN75; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmbwmL6tECPbBJCWqisEvtOjMNzaWWFeDXK6wH9ptiu7bgAU0qCDsExGBsCeJtw5wqEdeBa1943GqZymYdrguFAf4vxBK99kjTryc6xEIGnKAduNTkp+C0LZSLp2c1mBpTz0UlIx0kLkb8uxgwTSmX3tL3L1oqo2VR1m2u18Y+PdV4MqGcMcatYr97C/Qm1md89TwURaFaoxXBgf1Qv6TXldFtdUOQM5YE0j7ncOb5ARj7NARqhnjQow13IHuTcWpeQ18qTME82U9MKU4Vj2jga4YjVYoZH2i/H5mmtYCh5kLRnVTJ3BPNkCR3ali/4cl7TS+HDQyWQkQ1cJpVfy/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDSQ1FTcvBXMaLcYmJ23Ryt2lWXulW3riS3kiK/3Y+I=;
 b=xxHzp7d3+ECeF3IqqGKSxwMzEEaOalAzY0vObNGaXzaGdhh8ONPkOHV+sJ7dUv1ThWIFJ7zEQGITTJP4PlrLNYJkEQOoceKesTnDpKTQteAvi+ijeMYCDf5BG/+TCJ3TyuNeegz1NWmx2B4dtOCv/KWblxTHUu/FlHi0o4dCmaGnysrWcral73L/xr40BWjFlySuoB9SwTI7Ln+ucfFaT2zGeVApgA0lAt0mpPrf4O+a07H7kvYp/9F1Zx/GMb1IOdSo3g0G9RufeVhYGFWN5soi+pf+Eb/1nnGko+yqhI/z1qUtud7txpqBQbsDCV9cSa/9HWKo+TC6f43V+0pnaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDSQ1FTcvBXMaLcYmJ23Ryt2lWXulW3riS3kiK/3Y+I=;
 b=nk6ahN75rA2Qqnp6neck7hWisO7KmY0FfFlj1FvFx/ZAPZ/FgnE7L/1diZwe6bKAgGmhy60D/CN5LD17hSLBMeT8T9bhVs5ztoLvW9nZ8s2llk3RAGNuiu1LMHA6AmhKqE4u8ZBZUNxlJuMrtAfRqpod5t2Do4J8JZxOmddUJ4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23)
 by PH7PR12MB8794.namprd12.prod.outlook.com (2603:10b6:510:27d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 22:23:30 +0000
Received: from SA0PR12MB4447.namprd12.prod.outlook.com
 ([fe80::b4ba:6991:ab76:86d2]) by SA0PR12MB4447.namprd12.prod.outlook.com
 ([fe80::b4ba:6991:ab76:86d2%4]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 22:23:30 +0000
Message-ID: <12829169-2484-8e98-c489-570dade578bd@amd.com>
Date: Thu, 1 Aug 2024 17:23:29 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/2] "nosnp" sev command line support
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Eric Van Tassell <Eric.VanTassell@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Michael Roth <michael.roth@amd.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, "Giani, Dhaval" <Dhaval.Giani@amd.com>
References: <20240801205638.6603-1-papaluri@amd.com>
 <Zqv2_wQbCLN_AOfy@casper.infradead.org>
From: "Paluri, PavanKumar" <papaluri@amd.com>
In-Reply-To: <Zqv2_wQbCLN_AOfy@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0057.namprd05.prod.outlook.com
 (2603:10b6:803:41::34) To SA0PR12MB4447.namprd12.prod.outlook.com
 (2603:10b6:806:9b::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4447:EE_|PH7PR12MB8794:EE_
X-MS-Office365-Filtering-Correlation-Id: a3853b1f-cc6a-4ab3-4560-08dcb27892b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dEVUeW5mYVVOSzUvbFVvcHJ3RDZ0Sy9iM3dkQlhKc3B4NXhPME1TS3lwOVZN?=
 =?utf-8?B?SFlBQWJnbmpCMWhRdjhpOGVDa1JPdWV5Wjl0OFdZaGZkS25CcW1odDlNblZ4?=
 =?utf-8?B?anhza3ZRTU1WQS94WUpZb0VTN3pxb0hlakRxbGlpUzVJaWNsSlU3bzV5S014?=
 =?utf-8?B?b0xNTXFyOXBTNDFxMVF0a3IrNk5DajdvSStuRnN1SnhVWEd4Y3hyMUMzNlZz?=
 =?utf-8?B?aXpUa0hNam9YZWRVQlE5TU9oS2c2NzdYL01wOUtnVTBkc0JuZHZnUmcxUGhG?=
 =?utf-8?B?ZHVtOFRPQkQ3amR2OHYwODYxMUN4Z1EzTFRvS3FwNDlXWXFGVEVBN0ZiNDJS?=
 =?utf-8?B?NUZmSmN4bXBBNWJKd0FxQ1JmQVVwei9iOUY4aCt6bWJJRS96OG04T29TZjdw?=
 =?utf-8?B?WG82YXFqaFBWM1lyOUpvN0pQcjJqb2VmelI3VTdtZXNyNHBpdXlXRW9ab1BM?=
 =?utf-8?B?ejZKMlJnU1dOTUYxUHpLbk1UN0ZvTi9rcWpkaGZidE0xc05zL25hYVJvVklJ?=
 =?utf-8?B?SDNvd2FJdnNJcVlXeGd1YUpnU0xURWVVaUUrSUN6RWR5QXJWK1dEaGNIVDlI?=
 =?utf-8?B?Q28xSnpUTXVVbllrK3dwczdIYzlDMXRPdEdXWlByajZaMy9qMUlzVVFWcnNE?=
 =?utf-8?B?UU5VVFVSdkEwSUpIb2dYdnBDUDRpNHQ1S0pRNE5ZOCtucTZpWG03T2NMdjNK?=
 =?utf-8?B?eDEzQnRmRUc1SlgxR045NFd6VUFBVjJDWFZxcldHemZEMlBnRUdXYkpJZnlH?=
 =?utf-8?B?c2NyZUlEaUp2dW14ZmtJS3NvSFI1dlBUakpSMUZVallZOTVPUXN2czZIYWxQ?=
 =?utf-8?B?T2FJOHpPeGx1ZnBCT3NlZCtUMzdFY09KY1dXZjVpRSsxUTkyR3hRVXNZNDNj?=
 =?utf-8?B?Uy9nTVV4L2tnWFYrL2doTXJwZjZlNVBTOEFZY0ZTdzdVczdOZS83QVg2MGpY?=
 =?utf-8?B?NlVBQi9WY0lOUVVycEVJSlpYVnMrZm5UK2c4SllVR3pKbSt0YVdUZVJrd05y?=
 =?utf-8?B?cXlNSllVdHFBeWZ5VUJFMER2dzhBZlBzek5ZNXpVTFlVbHNHdEUyL3laamFl?=
 =?utf-8?B?K2drL2Z6NldKMzVzK0JJdTlseGpGUHdsSm1iRWt3UG0zK0VReUtsaWJXeW9t?=
 =?utf-8?B?ZFpucEUvRjVFbDBkWnowYTUrWXNSUExQc1dyaUtnNlJlcnc4TGZOT0ljUEh0?=
 =?utf-8?B?N1hoQWVici83TDJrbU1yb3BJRUIyRWZUTHo0R2J1bnBpTlJGd1RvNFpUeVhY?=
 =?utf-8?B?K3dYQ1g4VlRIenNOSkxiT3ZBdDlBSkVrVmxHakJYcmNqRjhBd1dsU1Y2TDFx?=
 =?utf-8?B?NWY1QW9OUXZVTC9nQm1ONUM0ZCthdFFJa0phYUM4TVRyVk9GY1lCQnUxVVB1?=
 =?utf-8?B?a1R5RjMxalZHdTc5ZUIxaWZlcHEwSHJOM29oejZWYUE3QS9JZGNvU2hvK1pE?=
 =?utf-8?B?ODArUzB3bWowL3pJM0k1YWxNVW9vdElwVnVBNkg5SDEyUk5QQXNxcHdxWTBP?=
 =?utf-8?B?SzNqSC9TZ1EvUng3T3NqeG1teEpxM2MyRHdJdlhvVGhJOWhiSVRsNk1ybnN2?=
 =?utf-8?B?cExtZDdTVWxteERNTUVmdTNuVG03Q1phZStpbkVrLzVqbFREdXV2YXB0bW81?=
 =?utf-8?B?RXIrNEgrT1VPRjdLN0JBdm5qclpMOXJ4Q1B6bmtBTkR4SWpVQXd4QXJmOXlO?=
 =?utf-8?B?T3BtU0ptUG1nekoyMG5jOS9aMEcyZml0TXVXeFJ2OEg0RVgrTGd5VW5mTS83?=
 =?utf-8?Q?/f11mFyaG8kO9OXDlQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4447.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGFxUlE1Q3Urd3BFSU5WZWFPSHppSitsSWQwd0NrR05RVWRGUzFSYkx4YSs1?=
 =?utf-8?B?bGNUYWhFV0FYUDhTakFWeEFWSDFvVFJ2dy9jRTIvOG1WMExTWTJ2enpIcm5O?=
 =?utf-8?B?UGYzRFRMVjhBQ3VacUFSb1JzR1pZQlc4TkFRMVp3bFozcHFOKytTTVFTMDVG?=
 =?utf-8?B?UW8vajE2UnVmSzlydU8rUjgzRmNJV3hOemtOS0lFdXhwS2JRNlY4QmRCQVNU?=
 =?utf-8?B?ZktZTGRraEFsdHRZbG11ZjZkRTVXS2pZVVVhQW9rcjluZFBmWklKVVhCVi95?=
 =?utf-8?B?V0FkRERDZ3dWUEg4TUpiUDZLd1F1bmc0NGFMbjAxcUdoUzhoMXVWeTFUanNo?=
 =?utf-8?B?eXZIVTlJeWZ2bWNGSkVXdGM2TjRldG9HUGlDa1l5KzZzVE9mRGpKOStPUkhM?=
 =?utf-8?B?YWlDN0szaGVRRjNidXNvQXFUQXlYdElIdllsVnpsQlRKenZkdkdtVTd2L2Zk?=
 =?utf-8?B?Y1dKeWxqK0pUc3FOMmtzZHdGSzk0OG1xSHdMbStzUS8yLytLYUQ0aHdETy9H?=
 =?utf-8?B?SEJIYWFJVE5PR0JUSE85S05teHFiMUgrY2U2dWpzVGtCSnEyeDlSbUoxVk1s?=
 =?utf-8?B?VkxUVVlKcjhsc3lGdUZFdklEcHhReWQ2VjVHcjVFTmg0bWRxdGNFZzltM0s5?=
 =?utf-8?B?bDd2Y1NWZFhYTlFGS0pxRWlCbzJ5WHE5UmNkYlJKeldBTjlsUVV2aklrOWZs?=
 =?utf-8?B?MFpUQlFiK2g3ZndlR3ZmS1oyc2pEVHpaTGhtV01SMzNKQmxiWUE1N09UaGFu?=
 =?utf-8?B?L1FYZlVaaTRySExwb0J1dnVRTWVBUFdva2o5OVc5MERLem9kUzA5WWZMYzNt?=
 =?utf-8?B?L2t0blJwendjZloremcyLzBtYmJYSzZqL0lWNXc1VzArcXlwM2o2dzk5dVFD?=
 =?utf-8?B?UEtmOW90bjhYaDJsL2hFUHU1MVBvQit4ckQxM20zMzhvd3ZNdHQvNmQ0K3Ru?=
 =?utf-8?B?UUpqL2RNWUVLZk1UQzdlcVJGSm1WMDR0ZlIrbGRqdnRXQWd6TCt5b0J1V1ly?=
 =?utf-8?B?Wm1CVzdXZ0E1bnlqSGhJRkdxUlNJTENIaVQ5bWl4TDk3OGtyT2NkQVRkRG5Z?=
 =?utf-8?B?VFRtT3BrdnRGNEhnb0dmMXMyZUROUDdNN2pWRXVSM0xYd1JiRWIxZ2tPNmRa?=
 =?utf-8?B?NE51bzBFNzUzQWhnUE4zTFhmMzMzbTZqSVF4aTVjNFZzS0lOUzl0VHN4Yk1o?=
 =?utf-8?B?eTRmNm8xMzVHRXRqOHcyU3JIZkswb1BDZU80NmFQV0hSaVlyY2U4NGYrMTVo?=
 =?utf-8?B?VGJQZ0xpdXFjdDFwNzg5Yzd5dWFwNUdMc2NWdHF0NTRTdi9JaEpDYmhMNnN4?=
 =?utf-8?B?ckY4VGdqTFBPS1VXRzB5a2hXNkVMWGNYY2F1akFjamRLZUllYjhGNG1SU2JT?=
 =?utf-8?B?eUF4SXlaNGlaaWF3WHBoTytNd2hCcDJJZWZpRENCbFpodFpQV0lWR1F3V3BR?=
 =?utf-8?B?eDdWNjV2WWovdE82QjRONUFSRUNha2lpU0RjREdOWENHbjRJMmh0dHEzd29G?=
 =?utf-8?B?d1BaQkZwbVorVFlxQWs1WkJyNks3bDBCRmZGMGhhd01nVVdMbndIYmNmZmpB?=
 =?utf-8?B?ZmhVSG9oWll1NEZrbzd1aTdOekZrS2JCSUdSNEhyYUpKZWFZbFhVbzlmSFov?=
 =?utf-8?B?RFNBeXA3SElPWktNcXdzQXNZbi9jTXNWcUtZQWQrM3QyV0dVeGNkQldtbEtL?=
 =?utf-8?B?UXp4b01Zd2xMQXFySFMwR2tFaUFDdmFIdVdXTjVUOXNQT0ZINS9hTkNVVWNF?=
 =?utf-8?B?NHdoS0NsVE5jakJhb1ZxVDJHTVRTS2NTbXFjNTVhRzM4SGx3SEJicWd3ancy?=
 =?utf-8?B?VnhKbU82MkZQR01TcEVkUi83alprNWlZN3FOV3pIZUhENnM3bWlPRmUxOFpx?=
 =?utf-8?B?amovbCtzcVVCb2xaVHU1Si83RXVOWkhjY3l1T2F4cEZncENXTTRPYVowREx5?=
 =?utf-8?B?Wll0c3lHU0ZWZk5BOC8ya3JCdjNGcTJlZDFpa01hcTdTSnhUbENTWWt4REVX?=
 =?utf-8?B?V0ZacWtXNkVyWkNvY0htOFlIL1Y1dldxREVMa2NoWXE5UkNXekQ0T3lQdVlq?=
 =?utf-8?B?OEdsNnRvM3B3MWJzMHRuYTNOSk9ITVZzVzdvQWVpSk9NRWJ5VllKbHh4UC9Z?=
 =?utf-8?Q?VBeSxNNSFU3+SbMce9B60umis?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3853b1f-cc6a-4ab3-4560-08dcb27892b6
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4447.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 22:23:30.8312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JRDwFX0Rp7+O+K7R5cXagyzv4DSkhfUlRqQsT89j3xlMrm7xKHRywZ+1A4eYWZz4PkdiqVuv6tIF2Z4sa/4sNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8794

Hi Matthew,

On 8/1/2024 3:58 PM, Matthew Wilcox wrote:
> On Thu, Aug 01, 2024 at 03:56:36PM -0500, Pavan Kumar Paluri wrote:
>> Provide "nosnp" boot option via "sev=nosnp" kernel command line to
>> prevent SNP-capable host kernel from enabling SEV-SNP and initializing
>> RMP table.
> 
> Congratulations on using three acronyms multiple times and defining none
> of them.

I apologize for not defining the acronyms, I had wrongly assumed they
were well understood by the reviewers/maintainers. I can fix that up
going forward. In the meantime:

RMP: Reverse Map Table
SEV: Secure Encrypted Virtualization
SNP: Secure Nested Paging

These definitions are also available in AMD-APM vol 2: Chapter 15 [1]

[1]:
https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf

Thanks,
Pavan

