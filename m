Return-Path: <linux-kernel+bounces-268421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1C1942481
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 04:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ACB7284B7C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 02:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E1C101C4;
	Wed, 31 Jul 2024 02:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="zMOW5wLC"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2132.outbound.protection.outlook.com [40.107.22.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1177A2F37
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 02:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722393050; cv=fail; b=IxwRn5Zrgg2Bo9JC6nIudX3ItPZJM/wXyI7ek3gnVnsTScbWmKy0wyYVAp1sicVZV0ri98+b8+kOy7cnvnxIzXk/B6dOY9/KNV34Ai/OVnyJzKqhzUJOY9ad2IWG1dM0DooSY7A4KDJHWxJ244BVcjq2mvzNmI59DryKxYiaoIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722393050; c=relaxed/simple;
	bh=YvJvK30LdDICnyuMXZlz5Sdx/kVYCO8qWWpWGDhUgdM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kkw+cnV6+8COZng7/ZT4OmfGCATR+GcqN8Jr1mloFBCFZQXvObYEX52t0XF2mKExK3Suihm6JgcXW1nmvY5ag838qCwAMb2zIcSeuIp+/OfXTeYL0rrcSNdfR1Mq0+OqmBU7XqaB7qV6dAQRItO/9nivpyS3Pd2cnmdTmjvDtNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=zMOW5wLC; arc=fail smtp.client-ip=40.107.22.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jV1FA3k+qfg/+/VkYAzD2cS5nWG/phvLhb+Qy/AYRhIWAJ3Emtb+q5DxIcmljhGs3j39uxfa0MqDOuA3rvI9bIdfURfP5rscgHyoeHI11N6Tey7eS4YqUsyyErKDjkLJ4WoZq9AEt4RznGYtELnWnyhTT2+MHiwkGaNQCWZ7pnTRMsa4RpStikR7QRv2t3cJTpW4rGBlT3IgXOsbidaWH3pYABOxVKscLwdHRVWFQM3qkDpMMcOZt8Z9mcD97BoqgHvC6Z81wc/VCzc90tUaeKWjPEek9TUfM3tkG84OK+g4e95/0rV433Z9vlPECcyU23CjFJkYUbrf6c0mOJTzTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kM6d3CqWBt+Kv3YKsdmap3wqypUtASlczbFKRKf4sPU=;
 b=lGSSyh+JD05Ybsa+v9IrAx9eCrg+phMnITRDpCNL3kmt+XQseloaIfRgxkHdTT7MpRI1cDtNtpKbX9gb8+UjEJyWEqBOCQ3f3Rd7L7Vb+R3FLxzBN/AiTWtZe4qGQtV6N2u8A0MGqiLusEcxxzn2MvAGnD/jPmuEPwFz79O/l1/1QhHHCnVPEtz8haBv1yBmkk6egOmdwqw7QY0r0GfI0kVUnmfDG6uyp2wDdn++OiOeYCTvPovEEyB4xe/HKIhWmq90bjrIOCzWHC4alvMeIZY9pcweAj0qrJPXYgx2ZWGsTYo5egfA5L8wIEBjlNpSAcjgX+76fQqyaEtzLoHIdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kM6d3CqWBt+Kv3YKsdmap3wqypUtASlczbFKRKf4sPU=;
 b=zMOW5wLCqCDj0SOqV43NPocm9cNUolhHxpsERdxdeldMXwOLsLEbRmb+2XBIHfSaB9Rym59t7rtM88bNxVKg/CfnB9+HDBPVmh+o+DX/8D4RICoJlWAqAYPlxjhSvw6CohKRzELtITL/dNhCmnXaFHEeltlKkDyZM+ClLOG2PGOZ7i1HL6ObQfc2EPqJe/79PmKF/wFChA9LHlMT7nzKYkB55QC3hS6aErCwmszJ+A6Z9pXGNO36Drx/0VO+0ZDV1QJd56zTDt2H3ANPLpG5VzHjJUkc5X2TK0eq61+EFJh6N4+Ni3QhIiZSGvA9FBOYAbddefe+27pCuBW32+Mtgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by AS2PR08MB8926.eurprd08.prod.outlook.com (2603:10a6:20b:5f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 02:30:44 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::7261:fca8:8c2e:29ce]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::7261:fca8:8c2e:29ce%4]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 02:30:44 +0000
Message-ID: <baad00ff-6450-4a1b-b62a-3fabdb35beb3@virtuozzo.com>
Date: Wed, 31 Jul 2024 10:30:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] kmemleak: enable tracking for percpu pointers
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
 Chen Jun <chenjun102@huawei.com>,
 Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
 kernel@openvz.org
References: <20240725041223.872472-1-ptikhomirov@virtuozzo.com>
 <20240725041223.872472-2-ptikhomirov@virtuozzo.com>
 <Zqj1eByCCStxAKNJ@arm.com>
Content-Language: en-US
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
In-Reply-To: <Zqj1eByCCStxAKNJ@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1P15301CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:6::23) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|AS2PR08MB8926:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a3d3a1c-bcf6-43aa-135a-08dcb108c732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDFsMVFIOFJqWUF1UjBTWWd4NXlPVkZsNlV5em96QzIxMkFyMkViMUE2cVo2?=
 =?utf-8?B?NWdYb1BvY3hzaFVpMUtSOXJ0Q0F2VWxQaHRMMFc1OGltelA1amNoK29PdDBo?=
 =?utf-8?B?YzdOdWp6NDVORGZUVlJISDIrVjdMSFFMRUxNWDJ5VGxDemdudjA1M0lnOS9H?=
 =?utf-8?B?aGh1U2xpbGZ6ZU5zOTArc3FUWlRVdEJzQnVaanR1Zks0ZWZIVUpmL0YvTThw?=
 =?utf-8?B?TWpBQWs3RTJZQmhtWXU5elNDaTVKczg1VmYveXh6RnZhbXdNTnFOcTQzS2R0?=
 =?utf-8?B?Y0x4UkFUYkFmWGQveFpKcjNra2ZNejRsQ3hXVkRaNVl4RmhIcWthRkRmSlpE?=
 =?utf-8?B?K0dTYTAxTE9icWh1OFQ2MXF5TUxzUWs2bnp6RlYwRzZDaXZRV09Fbk5HYi9S?=
 =?utf-8?B?WXZRSkQ0UWVGcjBGaFBudS9sMC9LcVZzMW5PTW4yWEJYOXozYk9uSndXN1VX?=
 =?utf-8?B?YXBka2RQeHVobDRXVmQ3ZTBnQlBLUHlLSmMzUDJERkIyYzJ5bWxXaldkMlFp?=
 =?utf-8?B?UFlNUEtoZGdrNCtnSXNPR1d1Y0hHVWxvcGloY2tJdWQzYXc5YW9wYURiRWhl?=
 =?utf-8?B?V1p4ZU52Y0V0d1ZVbDBacFAvMTV0a2xDSzE3N3NtNTBKYjVsdlQzSGl5Z1Iv?=
 =?utf-8?B?b0FLVU9JcStpZHMzZHZ2bDZuR2JNQlBnQjV3SGE1NHkwdDk3Tmw4YUFkTGdO?=
 =?utf-8?B?Umd0MlhpanI0RnlVd1hROHZSbk9DQkdqTkt1RXpqZG11WXMrcVVyT3l6UnRZ?=
 =?utf-8?B?RS9zblFIRGY3WXpNZUUva3hNWm9NRkcwaURBaUNsRGx2Q2xUY3pFWkNNQnBY?=
 =?utf-8?B?VFJRZGhYVEFHUG96RmFRNUN4VnRJQ2YybERQeVF1V0VrK2ExaERuYjNiOFV6?=
 =?utf-8?B?Y09VY1diZy8yNmtNNGlyVlFhcHJQNzVmV05YUDZsbDJWRXRIQkszV0pXc3RH?=
 =?utf-8?B?amJqa1Q2b2MvYk9KbndSQndQcVMxcUVOc1ZRUTV6SDhsWGdWTWVLdVc2US93?=
 =?utf-8?B?bjNORTkvM0E3RGVsRmtXc0FITzlNK2Vna0ppZjJQVGo2UnM0ZFJaRWZxOGNo?=
 =?utf-8?B?d05tbUFCYnRmTXNCZDBDeGFtOWtZUWhwUDA4OFp5OWNaQkp1TVNxdU9QeXZk?=
 =?utf-8?B?ay9IeHBQVTFlYllqYlVPazExRHR4Y3UwU1VCMFltWmYwOHlPYmNqVVBjRWRj?=
 =?utf-8?B?NFF0eHB0YVlaajdqTzVRQ0k2S3N3NHY0Y3lFbHVGNG02cUJONnNBTmtxR1R5?=
 =?utf-8?B?Tk5JV1lmSEd6VTFIRGtTZjIzSkdkcWMwQXB0UFl0K1JidTVoTS9yQjk4bGFj?=
 =?utf-8?B?RU5nL1U1YVhyTzNiODFhQlB5aDN4azdQWCsyUko2aUZCS0xlNEJHWVZCa0hI?=
 =?utf-8?B?UldYcFEzT2xjMERhWE4wanJ3WFhsZVFrM3FhbktVVGRSSXBONTRqUFZxRVRl?=
 =?utf-8?B?V1pQMHVHK2V2MjZoQ05POE8vMTJEV3ZkOFNDTStkajJHenAxd3hBbDhVR2hN?=
 =?utf-8?B?b0VON0FCdVZzNHczejc0Tm53VTZ5ZHBkUnFTZUxHSXJrZ1Q1QStwR3FSOTNz?=
 =?utf-8?B?SUgzakNWM1RnZGp5bE44cVJlcW9rTjZoN3drb240UmtiRFVwZXdYK2dNTkQr?=
 =?utf-8?B?czBxNTNibWZrallTR2l5YnZ1cGpNdlZzc1h0VVhhaUpyeFdLUHpIRXVUcXhh?=
 =?utf-8?B?NWNFUGRRRld5b0NBY0h5WVo2c2FlV3N2SHJaU3dLUWQ5UnErQWxWK2xLUFpQ?=
 =?utf-8?B?Q2xZV2tMaWJBM2pyaGlmekFZcGMya2NhanFIc1dYUkxqdVRUVGtHbW1nNmVY?=
 =?utf-8?B?U3Z0U2pSVm84WkhnVW43Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGlDM0dxcW1BeUtuTUNsV0V1bmdid0hsTmM4dnhiV0RoK2JTeSsxcTd3WVVi?=
 =?utf-8?B?aU9YQ0RsVG5hRzQ4SVlsZDhtZytwd3NIc1k0Z044eTB6SXZOdTBZbnR2dU1l?=
 =?utf-8?B?ZmhQdzZ0cDVYQWhsY0U4UW9yTE5TK1VXRHA2c1FOL0s4YlBqVlMwbGRTRGpw?=
 =?utf-8?B?NWwzV0ZaVlRaTjczcWlpclg2ZHBIaUwyU0VxNVNTK1FwdXBBdVc1K1FyVjlH?=
 =?utf-8?B?V1F5MTZ4czU2cjB4amNWSFFEMjRjdE8xa3d0bWV1dWJtcEp6RGtTZ21TS3BR?=
 =?utf-8?B?alVxMW5tMzl2RkhNT05zdG5zeGVCR2ZtTUtPblNoekluckI4aStQN09QeVRu?=
 =?utf-8?B?VEJjdmI1NDJYdXZoOEt1WUh2ZjFjOXNBSzBLbkFEbjZEeC9wVTltbkRpNVpy?=
 =?utf-8?B?VUxuSTQ2djd2LzgxVDdPcCtOM2g2b1JSbFBVcGdJdUZLclp6T21RRzRWOFlQ?=
 =?utf-8?B?cnU4YWowbXhFLzdJcUxrL3phdHJaNzd4ODhERGZmNldiaWlRL0dRbHFFUlFW?=
 =?utf-8?B?eGZzY3NxUFFZN1o3MUJmd0llaDJyQ0kwUFpSejlmZFE4Tmh0RG9DRFZsU1cx?=
 =?utf-8?B?MzNQK081bUFVK2Z6bEs5czA5MnBtVHpIQjBhN3hFbXdZOWIvRnFtOVdSTVVF?=
 =?utf-8?B?N1cvQndtTFNmZ2RJOWM5eUQ2dVZLTjlQMFZ4Wjdib0Vla3VxMERycWVHZ3dx?=
 =?utf-8?B?MlNSYXZtcStXeGF1c2N3TmVsaUdzZ1VnNXkxcFRDcXRTUHNNeXpYTVNXQ05V?=
 =?utf-8?B?NStrZDJRTklFOTZFQWljdzJxQ25BbmFPNm1hTzhUdnZQNnE2aDJWc3c4cTBC?=
 =?utf-8?B?R2xINy85Q005WDc1ZXhBL3libjhsdjFrckJQR00zT3EwMU55WlBoSlQydnZu?=
 =?utf-8?B?N2l4L3laQ2tYZEhkak1qK1ZId3ZhbnNiTlBvWkJlOFdMYjN5c2dIYmgwSWlv?=
 =?utf-8?B?T1U4Q253OTVsL25BZkZHZVU1R3ZFTzV5dXpDUGo1TUVZU3hpcXdWclUvY3Bs?=
 =?utf-8?B?emVJbU1qRWtneTU3cERpQ29seWcyNC9pRFBhMjJwOXRUeEF3NHBnaXYzaFJj?=
 =?utf-8?B?OWw5d2VaaXJVb0xiTWo1NHhCTFJmY3lBeUxIN2F1aE9ReTUyeEVZNVM2SUFP?=
 =?utf-8?B?U1kwZysrMDBkYS9BQlJ5TSt5czJ0Z2JvSVk0OVFOVUhoakZZdVV4YXFzMzdp?=
 =?utf-8?B?U1BXbDhseExadWhrcGZ0bzZFR3pxd3FJRENoL0svQ1ZHeUJmNUNVa2cyR0Qr?=
 =?utf-8?B?dThwL3EwbXVPUDVuZDJ2S2hudHgvcFRrZFJnMkYrc25iaDA3MEQzcExEd0ZK?=
 =?utf-8?B?UlpxNU92K1JLdlp3VWdDOTM4QjR5emR2UjVJYUlta2EvN3d0aHR5Y2RyZ2g3?=
 =?utf-8?B?eWYzVEh0MWVGK3lQK2tseVRpVExQZHBNdFZzTVd6bnc2WHJGZUVuWDZyWVNj?=
 =?utf-8?B?MFRkT0NhS2NuMHhwTkNmMjBPNkpyb0dDa0U4VjZlSzdYemRMVmt1aDIraEpJ?=
 =?utf-8?B?bWxrcE5KQTBjOUdNbXNCVGo2L0s0YTlTL2FWaWVLN1ZHQU8xMlRxME4rbS85?=
 =?utf-8?B?ZWhpa00vcHpkU0RNTzNrNEx1aXNPQ3NMZkkwMllnUUJJMkwwejkvY1BwRitK?=
 =?utf-8?B?djlWc0hUQmtNVzhzTEdlNUtjNEh1bHBnU3pWYWRDc1FVWFFma1laQVF3OE93?=
 =?utf-8?B?RUsyVm5IVmJRTEtVM2xpaWZRRVJ3am9vUHNQTXRDZlY1bGNLVisyNjVVWEJY?=
 =?utf-8?B?cDZvR0xEMm1OQXdBYTFDT3Z0Nk9ydHo2a3dJSFFFeTM4YTluL04zVDJ5NitS?=
 =?utf-8?B?UFFqSkMvc0pZUHdXY3ZoQkk2N21IQnA3bTJxUTNDTDZ5M21hUmhHNzRGRlN3?=
 =?utf-8?B?L3RLUUI3UUZDL0JvTnFCY1Rpdm5UeGprRzUyMGdQWHJ4NHNDUExKZDNaU2N3?=
 =?utf-8?B?RUtlSHlZQWFtdVZBM0hDeWFLYi9ZOTRxUlVnZ0NPMSsxcXFEUHlWWWhqTzYy?=
 =?utf-8?B?NmVhTjQ5Y1AwVHhOeU5GRUlmblZONEI4NWRkd3B1ZGFuRm8xV3pyb0l4ZXQr?=
 =?utf-8?B?UUtndm83TStzLy8wa0dsNXc0M0c1VXlVWTVTbmhMcWhkZitKVXVOWU8xYmhR?=
 =?utf-8?B?QWVCTHBkWWFiWHJ6ekpmSTRaY1RkVWZOLzRyYnZlQUltM0R0VjNjdEc3Qkhv?=
 =?utf-8?B?TDM0TWJSYkNxMloybkZWWk94Q0lJRklzNDlQM2tWZHBVWjVXLzVxYzdHR3Y1?=
 =?utf-8?B?UTV2b0Q3eTNLWFUyeE5SUnVLbm93PT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a3d3a1c-bcf6-43aa-135a-08dcb108c732
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 02:30:44.2483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNb0DQ4fdyEynIBe33hqy1suwHuwZ7sIO1Ad1Imx6WtVdm9BEGanLYiAfH1/g/FbVQAA+dzKSWCqQI2XbB5EO+tcoESprWl8r70HfjGKDqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8926



On 7/30/24 22:15, Catalin Marinas wrote:
> Hi Pavel,
> 
> On Thu, Jul 25, 2024 at 12:12:15PM +0800, Pavel Tikhomirov wrote:
>> @@ -1308,12 +1319,23 @@ static bool update_checksum(struct kmemleak_object *object)
>>   {
>>   	u32 old_csum = object->checksum;
>>   
>> -	if (WARN_ON_ONCE(object->flags & (OBJECT_PHYS | OBJECT_PERCPU)))
>> +	if (WARN_ON_ONCE(object->flags & OBJECT_PHYS))
>>   		return false;
>>   
>>   	kasan_disable_current();
>>   	kcsan_disable_current();
>> -	object->checksum = crc32(0, kasan_reset_tag((void *)object->pointer), object->size);
>> +	if (object->flags & OBJECT_PERCPU) {
>> +		unsigned int cpu;
>> +
>> +		object->checksum = 0;
>> +		for_each_possible_cpu(cpu) {
>> +			void *ptr = per_cpu_ptr((void __percpu *)object->pointer, cpu);
>> +
>> +			object->checksum ^= crc32(0, kasan_reset_tag((void *)ptr), object->size);
>> +		}
> 
> Slight worry this may take too long for large-ish objects with a large
> number of CPUs. But we can revisit if anyone complains.
> 
>> +	} else {
>> +		object->checksum = crc32(0, kasan_reset_tag((void *)object->pointer), object->size);
>> +	}
>>   	kasan_enable_current();
>>   	kcsan_enable_current();
>>   
>> @@ -1365,6 +1387,64 @@ static int scan_should_stop(void)
>>   	return 0;
>>   }
>>   
>> +static void scan_pointer(struct kmemleak_object *scanned,
>> +			 unsigned long pointer, unsigned int objflags)
> 
> Nitpick: I'd have called this lookup_pointer or something like that.
> When I first saw it, I tried to figure out why it doesn't have a size
> argument but it became clear that it's not actually scanning/reading the
> location at 'pointer' but simply looking the value up in various trees.
> Up to you if you want to change the name to something else. The patch
> looks good.

Yes, I agree "scan_" is a bit too confusing. Let's try 
"pointer_update_refs", as it is more self-explanatory, and represents 
what the function does. The "lookup_pointer" seems like a function which 
should return a pointer, e.g. like "lookup_object" returns an object, 
but we can always switch to "lookup_pointer" if you like.

I will send v2 with this change shortly.

> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> Thanks.
> 

-- 
Best regards, Tikhomirov Pavel
Senior Software Developer, Virtuozzo.

