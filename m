Return-Path: <linux-kernel+bounces-438958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C4B9EA8BF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 07:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED01D188892C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 06:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FCC22B8DD;
	Tue, 10 Dec 2024 06:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jMGi7PWQ"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA9522616F;
	Tue, 10 Dec 2024 06:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733811895; cv=fail; b=Hd3B8QbpGOvtFAtm2IhNLJlr/D0jmQX0EdUvu+qqFjcfJwS9CAZAr9HguAPFu4e7C9Dp6NBfhy9A6oknI4OZgPHnKkpR44VMHVHlnmCTnTUDtKhvSwKSleOUFit+zp3Jtw10/MVQYOXSA53da5/nSkuE7s6gmE+qGNNNTl8ZrUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733811895; c=relaxed/simple;
	bh=SbN6zqRb82OxavBrcKuXo1/N4HDkwCILSS8Wn7tE+Fg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V7xoy5NqqFMhSTfYEN/5n56U4lqpR0WH+OvHWSiOgpcD+u7rNkGuVcx4uaRwsCW1ZVHxqkuzECRGfLfg7nZlKWTftLvk211MnkpDNFHLPh6oM6JnBLu2ysNWMfYQ+pC6b06yp9Ydm2FAD//cUAtTBFqLyXVvJNxL/JaEcr8B2fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jMGi7PWQ; arc=fail smtp.client-ip=40.107.92.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AugIHzOq7d+ijRFn+7NjnV7z6vq8q4XTb5GVwR4q64AaWtdGRSM9p4pqOiS7kdQV7dgy4W/Z8q99UJ8MK0O8tmQob93ywvIa1o+ZDtrichGWiotiG3TCw1ncsJ323y8tZzEIqS76ORnN1nT0fdAWZh5p4f6L72AHgURnFSc1HscVKEjcYs1b5gZtBfNtGvQaLp/q/ZmzStHMWQzRrkMMajQaECd/LX3JQqT6TZC8RrdXoYNxQ7o4imMLmsUtec+w/+WQ4M+tuEPmsB9lGS3YLXINwXAFlDuxrI9S+tzTjgFGakBV1YSsL5buGd1Hc8snyj00gjBQXW2XF+lHXJ+sQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MvUteckYXfYuIrrSrQ9XvcVKi2N56mQmbt7l8XzyTM=;
 b=lSUQUwmgI6hMcQooiU5qMEyo3ZoJmaEroTvFuiPIw7DSpyjgivCUNebeYDh1sXE7CMb1/1NNEnmdhDqHnn/nxyuo8/z4UCyifqjZuIh5MDW8hNGpt844zXn7DcG3Q+Q+vaC73X9Lf6Q9SxcbabcLytKVb0f8JMDdLv2RzrCGOaDBFgkPmdl9wh72k+WsZUnCm+0SYv7wJQjekuhGW83QcJ+LKY/2I8JzS7oPFp26gOf3zLBHO6oYE/ofWy75I+GeDWfyLDW++BqfypZN5q9Zd8mjI1MZXsiQj8CRjjCiBlS2fzEwDEFX+WVsiwREaRc/y9x6CdvI1vqyCtRC5R6Gyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MvUteckYXfYuIrrSrQ9XvcVKi2N56mQmbt7l8XzyTM=;
 b=jMGi7PWQSVpcv6UpXW/RfBHMfJ9PJj7gwKzMV1vlRokZElBBD4Fi4gWNwq3HkZnFeMkKKUZorxYHI01V+29p2nb/Gtf5GAt/4CNYGw3VGuHASNd33KtprnKzTrVrab46krlPyzlxLvgcjw+/agPqSKXf1q6ksYWNYj/VZUsoQx8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16)
 by MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Tue, 10 Dec
 2024 06:24:48 +0000
Received: from PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::df88:d99:3cf3:dec0]) by PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::df88:d99:3cf3:dec0%4]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 06:24:48 +0000
Message-ID: <21c58803-a8ed-44de-9211-7c8742cf5eb3@amd.com>
Date: Tue, 10 Dec 2024 11:54:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: amd: yc: Fix the wrong return value
Content-Language: en-US
To: Markus Elfring <Markus.Elfring@web.de>, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Basavaraj Hiregoudar <Basavaraj.Hiregoudar@amd.com>,
 Jaroslav Kysela <perex@perex.cz>, Jiawei Wang <me@jwang.link>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Sunil-kumar Dommati <Sunil-kumar.Dommati@amd.com>,
 Syed Saba Kareem <Syed.SabaKareem@amd.com>, Takashi Iwai <tiwai@suse.com>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>, end.to.start@mail.ru
References: <20241209101320.970571-1-venkataprasad.potturu@amd.com>
 <cabca893-74f3-441a-ad27-9589819cb1f4@web.de>
From: potturu venkata prasad <venkataprasad.potturu@amd.com>
In-Reply-To: <cabca893-74f3-441a-ad27-9589819cb1f4@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0218.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::10) To PH7PR12MB5951.namprd12.prod.outlook.com
 (2603:10b6:510:1da::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5951:EE_|MW4PR12MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fae0798-1a08-4d08-1804-08dd18e35858
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWFsd2ZNaFBBTUtNSlpkZ1B5ZyttSUpYdjJZYkFENzBUWkxjbVhCZjVsOTdO?=
 =?utf-8?B?KytGUit1TjFEelVHcnp6TGNpZUp2eGVkeU9GZ2I4alZnL2V5azltY1d0dUNH?=
 =?utf-8?B?SXIzdCtiWFhyMmloVkx2MWxneUhja2ZISlViTExoTGlFSWhlK3UxMzVCYXRS?=
 =?utf-8?B?b0NsemVGclRVT1cyM2NFY0EzQzhsdTRCUTU4VXNSOHpIQXJTNUU3Tmg4SDA0?=
 =?utf-8?B?WmVycEUvTit1aWtiMkpEdUI4NXZJYnViODNwM0EvdlNiRFEycU9tdXVVdG4z?=
 =?utf-8?B?ZmpmVFBRRE9ONGhRNCtkcmdFYXJtdExSZXMvanhQTk1UVHp6a0I5aXVXdTNF?=
 =?utf-8?B?ZFVNYk1YVTVzODFCMk1pZENUVmhqTCtjbVZCVC80RnM5YXRVdEFvd2hJSGRL?=
 =?utf-8?B?YzNvV3g1TVBrdWZyV1Q5Q0dpSXFBZVM3VCtOU3BUTUxtZ0tXa2pQcDNKUnBt?=
 =?utf-8?B?OUFudENEVTczWUZrcGliN1NkRzdUSXNXVmZVSzBJYm9CeDVBSEthb2FZWVhu?=
 =?utf-8?B?eXAwM1lId1Fmek14UGx4bE0vOHN2Z29zS0kvZ1QzUzRqVnlKcW44VG5HY3Rn?=
 =?utf-8?B?dHNHV0gza0NWREU5cUV3RUgvcjV5Y0luWk9FbWh4ZE56dHViMXFSRTFDMzBI?=
 =?utf-8?B?WThHYVU5M241SFBRdzM0MUNvWlZ6WE9aM20xclN1bW5nNFVzV0pqY0gwT25Y?=
 =?utf-8?B?UlVVRnNSTk8yWkNYN1lGeUNUTlNReVNOWnlDYmV4VFNORXhpUTVwYUM5cFF5?=
 =?utf-8?B?dml2U0laOEkzVU1nUFFFZWxLWFdubjRjTW1qbGVUb1F0dmRjR0dGSXcvOW9B?=
 =?utf-8?B?aW1pek5UZ2czdXlBR1k3K3phdnhnNWdLRHNGcjRtWXYxT3V1dkx5QWhhME1r?=
 =?utf-8?B?SFYzVWdYVy9DeENKYVZ2SElqYStBdml1ek83MkpDOXBHKzQ5emZMbDE5YldE?=
 =?utf-8?B?TDQ3VmFSbEVNM2xMejZobkNRS2hQd2ZlOWczTkdGSGhob0R2RjN1VFFFN0Iv?=
 =?utf-8?B?OGlPNmcrQzJZSlgvOERIT3FDTmFtazhYSmVTVmdZMW5PZkZZNGkrTmZ1WG1t?=
 =?utf-8?B?alYzVEFOcGRYd1hydEx3UU80MnZWRTR4V0h3ckpVblNnN2hNUnJUMWkrRjVL?=
 =?utf-8?B?aTU3a3NhUlhrTVAyY09EREl4a212ZE5nMm5kelFLcVBaUGszRzdwNmE5QWw1?=
 =?utf-8?B?ZmNYRnQ3SUNVc0dNUGVuRzRESkFWN1Ewc2Nmd3cwcFNNblUyR29FblN0Y1ZV?=
 =?utf-8?B?dU8zWmNLVGQxNTBlRTBEUkQrenlpeFlmZXErbFhqVkdWS1J6SE1iZW1zY0d5?=
 =?utf-8?B?Tkp6Mys3U0xLQWYyNTltNXlwOXUrM3hWbEN0ZmplR05DN0FublN5WFVnSndv?=
 =?utf-8?B?SnFpZjNwcGl6anpncHFpTDgrM2JacmgyTU43dzVjVTAvWkJIRjd4VjdZUDJi?=
 =?utf-8?B?UlVjM2c3MHlTa1cwd0h0SW5lQ1pRTWZDVkJhak9oRzJkVVV6U3FWK3pLdFJH?=
 =?utf-8?B?ajQ4ajhnYkY5dVBvdzh4NWMrNUJFZWFwK1pINU9FbkEyYU1sQ0w0Wm1xZzF3?=
 =?utf-8?B?S1ZGT3NTZGpBak9ZOUF3OHRCaUJXbHZ3Y2dSS2dPTzBEbTJRcHZDazBzVnFj?=
 =?utf-8?B?cjV3RFdQaitLMyt1REJpYjJiL1FrTTFkcEszcDZ3bnZlL0p0cnlQQ3ZQUlNT?=
 =?utf-8?B?QkhtZm9KN3ZoZlh2cW5iNWY5dTRLQzQwcjNCNVJQZlNYb2Z2bUFJdENOTXMx?=
 =?utf-8?B?RWFzL3M3UFBxMnBSaHhOSllRd2E3Z1JtZGlhbEU3YjFBREdNNy9Oa1djNEYv?=
 =?utf-8?B?S0lEM2JnSzlSMkdvNC95QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5951.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L04xZG1WaUFrQXBMQzZxWFo0YXZjZWkzSEVPZ2ZvRzJMQkNpMkY3RUVEYll3?=
 =?utf-8?B?NTlnek5sQlQzN1pqOVRKYWlnNVliSUpLODYyKzVuaXFTbXdkRFRSTnNWQmt0?=
 =?utf-8?B?b3RWMXNmSHRYSzMxMGdFMlZBYmR0cXpMTzlINDdaVGNudFJXaGY1SDlRWXFv?=
 =?utf-8?B?K3Evay9uK094d0JYaFZlMS9DWlRoMDNuTy9vanNBaGxmMUJ2ZjBTYmovRW1T?=
 =?utf-8?B?UDFTL0Y4SElvbHJGaGRRN2lSQ0Q3d3lGMFMyQ2cvcERpNnRHc2k1MHlSbjFB?=
 =?utf-8?B?RnRuSjhhcG9jMisvZk1VczNTQjg5enFMOGxLMy95RUxvWmxNZi91Z2cxRjgz?=
 =?utf-8?B?RkcvZWRKMkgzN1ptc204L2hyZis4dW5FTW5UaUtnUzJHR3UxMnZFVTIwUVIx?=
 =?utf-8?B?R21nMlQ4L08xZTlFNXhOTS9oZUt2c0JySUhiMnVWY1Y5Rlhya3FEY0NobmRR?=
 =?utf-8?B?c3Z3eVJhU0c4RHFqZG5ybkhNZTRPdi92TkZTQmZ4K2hBMXpndWdxT0lkVDhz?=
 =?utf-8?B?TEFvUFZNblp5QlpYZExoSWg2VHZwYWZxd1VKZGtUdmNVQ1EzTlZBVENWZjBu?=
 =?utf-8?B?UXpzMXZremo5VUVRY2dHNUYvbjRseUZoY2lMNUNUNXFIZldsY1RSeWJ4UDhx?=
 =?utf-8?B?NThJTWpXVStVTFdmdFF2NDl0a21DdEU1T0I1T1hvcmhFa3kvNmRVOUNWUk81?=
 =?utf-8?B?T3NCamV5NjBXU2plZWtHRXhISVI0am5wNEIxcnRzOHppRkZrQ0pWd2xsSkFH?=
 =?utf-8?B?WVdoSm5leGFLa3hWd1A1YytRYW0wZ3Q3WncyYkVNV2Mvd0hicHZROElHRlVy?=
 =?utf-8?B?dFBvdkQ3OHhqMm1iWmhUc1NwVys3RDlWNkFXeW1nYWV1Q2pKME1jM3g3L2dk?=
 =?utf-8?B?SG9DL1VuZjdSMGt2U2dhRVhYMzdEL1FTUU1oRFdLT0NkZmpBOVRYdzNQd3FH?=
 =?utf-8?B?bXN2bkJGcGg5Tm01VFhlandsbDRZUnhyN1h0TFA4bmpIdG1ONTBPU0I1UWtF?=
 =?utf-8?B?UFVzSFdFVXVXcWZkNE9FVXRraTl5bmFPWHpVU0NrNlg4TVY2NFJJTG9GcFNO?=
 =?utf-8?B?S0RrdkVDN0pRRkRzRWd2d3BOOGJmemZqSlJ2QWdvT2NQRFBsWUhXNUhNNVVN?=
 =?utf-8?B?MmdLY1RaS2NEWmljNXVCR0hERHRnRzNzOUl6YjdzTXdYLy9LOFpXWXhzNVp1?=
 =?utf-8?B?SE1GNFh0VEprUk5ZeHIza2dXYXUyOVpjVWtSeFRvOVlPcTBnUnRmWGtLdDN2?=
 =?utf-8?B?YkEvTHc5MktUTGNLcTF4c1BVWmc0T0w5dGx0NTRzdVNsdEw5OEFTaVZWZ3V2?=
 =?utf-8?B?QkNEK3NPWTF5OTlQR1I4SkNTQ1NCenJHOGt6K2pTZlNEUWR3UGJLY1RseEdJ?=
 =?utf-8?B?Qk0wd2ZUS3dDaHByQUp5NGpPZmoyajBSRmM5Z1d2eWYwRGRjbHc3Y1hpUDZn?=
 =?utf-8?B?dmIyYmxKU0wxaUN2ZXBjQW1acFlIRmg3RzFkVTRuVW5Bbms4WXpTZ0ZFeFBE?=
 =?utf-8?B?LzJxNVNZZnUwS25SY2owajh5Z3BOSjkzV2d4c082NnZFeE9FZm5zMG1rNmt2?=
 =?utf-8?B?aEM3ZSthMUpMbWl6YjFyRTliVC9yd2oydC84VnVZYW5HZHJMVGsyS0xIMXR2?=
 =?utf-8?B?VHFTN0llNU1iVmE5cytCUTFnNDR3MDNXbGNUb01NQVZYdEdIQ1VKbTZDVWxR?=
 =?utf-8?B?cmlJUXNzUHBXVmd2RytITWpidXpYRDJQWFhOTHlmOEdIRVdpWHpGa3FUUytn?=
 =?utf-8?B?TXBubElNSXV1dXhCSytyZGN0Z3NQR0Z5SGdxemxiWnI1MXpLRnJINS9BQmdn?=
 =?utf-8?B?bHpLTG1MSEYxMUtRdGZ3cDNhT200a245OS9HeUpKZUVQZTdlZEZ2T0lydWRK?=
 =?utf-8?B?bjdydUFtRlRBMVFLclFlUEpOT2hhemlGVTdLZ3RJU3lTeEtxc1BMTk8vNDha?=
 =?utf-8?B?empvcjBEV1IzN1V6ZkQ3YnlIM2JvNEVmWjNGRWQrTWF1YUZiUlhFN1hVK3g0?=
 =?utf-8?B?SStYT2Y4UGJqaXk0Ny90ZjVLYmd2YXpoKzIvNFRoWnRlckRVNjJvRDl4bjd3?=
 =?utf-8?B?WUNpMTRhbS9IMGJMN0RlV1RBNmQwV05jcXJ5VHo1OXFTS3NoaWNoa3g2YVAy?=
 =?utf-8?Q?NZUyNnU/iHfYPBB7FacLmqOXD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fae0798-1a08-4d08-1804-08dd18e35858
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5951.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 06:24:47.9330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZyhnfbeEbAXmyeM3p0QDX7ZSRQFF/xGtZ1FCs5rv5sSX4mH5up+JlCDbx+G6QCCaKMXogezYCgXgaHWqhMFrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730


On 12/9/24 19:16, Markus Elfring wrote:
Hi Markus,
> …
>> Add a condition check to jump to check the DMI entries
>> incase of ACP driver fail to read ACPI _WOV method.
>    in case?             failure?
It's a continuous statement.
"Added a condition check to jump into check_dmi_entry when ACP driver 
fail to read ACPI _WOV method".
>
>
> …
>> +++ b/sound/soc/amd/yc/acp6x-mach.c
>> @@ -578,14 +578,19 @@ static int acp6x_probe(struct platform_device *pdev)
>>
>>   	handle = ACPI_HANDLE(pdev->dev.parent);
>>   	ret = acpi_evaluate_integer(handle, "_WOV", NULL, &dmic_status);
>> -	if (!ACPI_FAILURE(ret))
>> +	if (!ACPI_FAILURE(ret)) {
>>   		wov_en = dmic_status;
>> +		if (!wov_en)
>> +			return -ENODEV;
>> +	} else {
>> +		/* Incase of ACPI method read failure then jump to check_dmi_entry */
>> +		goto check_dmi_entry;
>> +	}
>>
>>   	if (is_dmic_enable && wov_en)
>>   		platform_set_drvdata(pdev, &acp6x_card);
> …
>
> Is there a need to adjust another condition check accordingly?
No Markus, not required.
>
> Regards,
> Markus

