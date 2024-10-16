Return-Path: <linux-kernel+bounces-367635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 998F09A04B7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E0E2840DE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8120204F8C;
	Wed, 16 Oct 2024 08:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JrBs/cLI"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5843B20493E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729068754; cv=fail; b=HzJaLblcikfo7xk2Wv7VQnfjP2TDdNPCE9Bqn5WXPilZ85HzTS2r6+WgSv32bETOGUAbGdGBZxJUhya+yO4xFYOwFJAczoHYC3s9aQqBF2FG9Zwckwx9ZDSZoNGp5ppolk/5s0B8FxHZJuFodx+JcDknxgtooqOfdvYOLcOPAVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729068754; c=relaxed/simple;
	bh=xeNUI1S7T+Q5IhNvJ+shVF//O6djOM2pyTIYF2dlqL4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZCJ/eWZOuPX9AM2/edV4vBfRvSfQpe4QJ1zP0v/znvt+t7uvPA43h1iGYQ3DhelC8tI6SE7m5It0n/sYU/k+nNHb1xf7kT7+EGVe2dqru/bsmkn+nqplfYaXyRXIgb7AJ1MHvyYktGOfeb7Ce5El86+bRIwSSgd9+NkrrFEi53k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JrBs/cLI; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wn39wI0FBl8aUwjDm30WeRK7ExcobwCId7EGjjbMnRLEaQDYgG1pRwg1Q7qrTqMSWEYl5meSVB6XoyGgcceAb03OD5e/sBzk4eBFKeo8OsB9D648qP4fyJHmbm8PnA+l+gS91nBkTJNz53wWYYNBbG8Uu0xBCMTl3Qc9MsmBsPxjB8dv/CSI3/IJL8iKL1uGjWHOlqgpwqVVUKfnRI4Ob55HIrr37eKCPVh2MBG9MlWvS0nRaE83nX8ua+WXZHIH+dlS1X1bpoaJTpmNeUcoXChDoQfxHSdScG+/1V3BYH8+YE759KLw5SXBINLPHXiFZAfJR9MLwjOZCfrJTjj0uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpE4pR9O7grxgGhAT6O9C0Jhl4E8TvDWcPelXzMcrbA=;
 b=drbV2OowFVppyoXoi7yb75ZnliRoxG8TwkBExBvmpzyEsJKiruyp05nd0+Mw4fgECvLXkqEOBPxnliimaZudOBejfD1OurqBfls8/lKH42mZ8R1mApcXzMTAtJXMO0wlQuVt4BhGAYEG2sy9QfilLNXJC6Oo8BFCjw1t91foa/FMg5GtMUAyDYo2KWkvEJ+1REPOP5eSEWB3hDV/D8HaMAWNWmeRr60cDKELgHdURYho3IQU5ubyAAZWOsMVytwZ5ekIzji9iqrDEoF7UG2X7skJoz+unEpA9yLmdyystxdylOapGtxmc3QbFHJCQfHXOW5CBqUtVjIt7Ryfl5bsVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpE4pR9O7grxgGhAT6O9C0Jhl4E8TvDWcPelXzMcrbA=;
 b=JrBs/cLI0cwXIFZxR9rVPNaXxazEOBjzOshgJHkLO4zL34AXBb1y0JgZF31TU2yiJLyTrbW9tTvuKAwiJxQzmvYLcVOvlTereHEQhE9VBdCrW8i4VJx+XUmktjAqKE488aJ4TsTcelXFbR1SoTa2rrV2SXBrrOjHZGCoqRE61Ng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 SJ0PR12MB6711.namprd12.prod.outlook.com (2603:10b6:a03:44d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 08:52:30 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::b890:920f:cf3b:5fec]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::b890:920f:cf3b:5fec%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 08:52:30 +0000
Message-ID: <85583be0-5e8a-82ce-a134-95fe9d85a2a7@amd.com>
Date: Wed, 16 Oct 2024 14:22:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 1/8] x86/sev: Prepare for using the RMPREAD instruction
 to access the RMP
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1727709735.git.thomas.lendacky@amd.com>
 <4d62cc503d1e3278c3830f24462e3956233760ac.1727709735.git.thomas.lendacky@amd.com>
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <4d62cc503d1e3278c3830f24462e3956233760ac.1727709735.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0144.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::11) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|SJ0PR12MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: f85a73c9-92cb-43c6-c788-08dcedbfde3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjVSa1Q1UFprbHNobUgzK2FDRlVmMGtNa1R0OVBWTnVKUUtCbDdUWEQ0T25U?=
 =?utf-8?B?SE15ODJjU0dmRC9jcWVFMVFDTjZzMEU0eERaZzY2SVNyMGhQWmZpVVFHUXpQ?=
 =?utf-8?B?TWpvanNvSWZCazdJbU5NSW9iVnFuUnNuOHM4MWpzVHh4L2FpR28xSm4zbmNJ?=
 =?utf-8?B?TW5VTUhUVlZYaEw5TDV2WGp0WlE4L2h5bUQ2eUlvL3UySUxiYWxoSEJ3NkNU?=
 =?utf-8?B?eEpmcDJXRWxVazltN0poNjRoTDdNQ1BCTEJxU0dBNW02d2dTOWl6dHQ0QThs?=
 =?utf-8?B?Q1RDU1FUYmpaZlVQTnFoeUZZTDNEZGpyQkI4cEsrWkw5TjlicUJyQkNDVzAv?=
 =?utf-8?B?WmFqZThScjBSb2QzS0VPUE50NC9HRm1pRzFpWUlhZUFyczB1TDF4a2poa1Mw?=
 =?utf-8?B?K21XTEJ2SkJ6Ui9RQnRqMmtKRXR0SGlBR2ttM01Ta1F0Q2N6UU1ER1V1c2t6?=
 =?utf-8?B?YnFxZ3ZnbVJwc2RxazBWL0V2bk53YlpwclZNNmtDNE9aNmlwSzduVDVaWXV1?=
 =?utf-8?B?cHovczBraGowYTR0S1V6WkVvRjM2OGN0RElJVFFteHlkYUhoK2xvNHAzbURv?=
 =?utf-8?B?bmwxekxDMmxMR212dTJiNWRoOFE4aWs5Y2RJTjRVbUZ4K2U5SlIyeVdQWXVW?=
 =?utf-8?B?R1R2aXdYYmM2U3doemtXYTF1UFd6ZU44WkI1YTN5dFVVb3FOcmp6bC9mM2pu?=
 =?utf-8?B?MC9GMDV2WXBDSTZtR2pXUXpQYk5FNHQ0d1dyaGNHLytobFk0dU5WajJuQndN?=
 =?utf-8?B?alRuUnNvczA1OFRMRDRwdVVwazVHa0JVbHE5NTM5TlE5K3Iyc1B1b2I5QkFV?=
 =?utf-8?B?UkJIY2NUUkFXL01KRm82YjdDY2RNMGJ6TnBjWEdkZzYxeU5lRHlRSWcwSXMz?=
 =?utf-8?B?cjBrL2pQanp5SGowcmwveGxXcktRQmI1ZkJCR1k5bkxYaFVzVFFFd0d4ait4?=
 =?utf-8?B?ZWZ3QSsrVEZOU09mT0UrTTRzRU1wSmcvd0o2cU5ZMnVlWlJPd01OK0ROaFBK?=
 =?utf-8?B?NlNmSldJeGFCUXBpRGJpY1M1SmpSZUc1NmV5QjN5QjJrL3AvVXpzTkNRckJD?=
 =?utf-8?B?blBmMlJ4YmtCQlhtNFJEblNGQkZZQm13Nmt1cXpJMUhRM3RZNjAzN2c4aGFt?=
 =?utf-8?B?YVFUdGZDVTdEVC9KWjBjZFVVRHJZbm4rTHlsZllrK1JyTG9XV21QempINytE?=
 =?utf-8?B?VWdHZFptU09TRU5ac2ZvNTNTYnQvL0JyZzBpdXlNRTlzQ2NwSVg3UGZTSmhJ?=
 =?utf-8?B?L0Y1RkZlRjRpcjJmUy9iam55R0JmeUh6RjhQTE5RcFJLakgya280dnZUcnph?=
 =?utf-8?B?cHRUQ0MxU0lXclhDbU1Td2lyTWRBRWNHcWVmTUVzTmp3N01iN3pVU29CYy9w?=
 =?utf-8?B?NDFYcHU2dGZ0cXc4RlNRMDJWVFBPQTJtK25lclNHQXdCZE5kOXVaYmphMWZt?=
 =?utf-8?B?RXhDd1p4UlFNTlNxVjREQ3czMGlxaWN4Y0hLSjR5T1dITnJJTmN5allTd3hs?=
 =?utf-8?B?ZEhmR2h5WlRIa1JENGczWllBOTRpMWpwWXpMMVNIN0V1dElpR2kzeVh3WU5G?=
 =?utf-8?B?WGo1QjVGNVh5MmhFelpOb1RzSk1iVm5yMU5HV2YyWkQ1cWowczJJMDhEQTF6?=
 =?utf-8?B?QmZUWDV3eDE1Z2liUGRxWDY3RlA5VFA0YzdGblVRTzFoWU1LOXBBTVIzTEhI?=
 =?utf-8?B?Y2pBa2lSOTE2bU9vSDVhbURVTUp2YjdsMW94bGxaaGc2T1dvc2x5T2J3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFhqSFNMMWpPZGVzWlozNUtRTkpNU3lhVk0xSHl1dFhleDFURlBwa3YvMlQv?=
 =?utf-8?B?elQrNkVwWHZTd09la0Q2V3A5QUFHK3pBMHZjT0dZZFJXUGZnV1BXaEhpdmdQ?=
 =?utf-8?B?OFRGVXE4Mi80bys3Z2ZGbjFYWWhuWFBOWkFMM2JQeHhFWEs5cnZ4VDJId0Zh?=
 =?utf-8?B?clB2b2NPdlJHS3EwdFdZT3JUV0VHdEdydE9lN2RaSC93L3lZYkpyT2VTd2M5?=
 =?utf-8?B?TzFKZE1ZV1F0bTM5VEM5N3YrU1FxckEwcXRPZ3dJcUQ5ejhqenB1ak9UTGdG?=
 =?utf-8?B?Z2tQM2YxMUNjcEpiZEd3dk5EdWNOM200cWUwUk9mWHRyS3l2RVhLRXI3QmZs?=
 =?utf-8?B?ZWhmQWxoV0doVmNpSjIxSlpYZnRWbjdlNU5EQXptbjBrYUV6WDYvZzE1a0hO?=
 =?utf-8?B?VS9pL2taWmdRM29Ca0djbGYvVVhobWJHTU44M0NqK2N4OGl6MTExTmdQQlkx?=
 =?utf-8?B?RldiZkFTODd1ZHJibzMxM3grUXdXZWhnK2pNNE42VzljU0NmTDNmUWlCQU9j?=
 =?utf-8?B?anFMNnhwbmdMNXNqWVBUQTNlaUZaUDdPS2wySyszZXBDZWFCZjNNTmsxUERT?=
 =?utf-8?B?SS9lV1FURHlsSnp5UmJpSmFTeHl2QzNBNk43SVQ5UXdvNUdsQzloQS9CVHVt?=
 =?utf-8?B?NVNHdWVseTViejViMWYrMzJOMTJlemhWbmtOam1lM09nNjZ3SWFOcnNZRWgx?=
 =?utf-8?B?UWw5Y2xPUEU3dnA1VFF0TFY5bDkvOWxzRzJvYW42Z3FwQVdmMDZmbXo0MVNU?=
 =?utf-8?B?Z0I1K1Rld0tZMHZra0M3eUVoZkVxWklObTJEWnlDNzgxWU4vc1F0MWlseisy?=
 =?utf-8?B?ek5BSnJRSXVDREc3RHgyM1Vwa28vRWJHZmlCK0g5YytPZUZZQ05uMjZsekVp?=
 =?utf-8?B?Uk91STB5M2p5WnJkVmJPUjd0QkVQdEhZSlJmNFVzMGh4VUVyR01JY3hGNCtv?=
 =?utf-8?B?c3JibzNuV0JhTitqTWMrK3BDWmNEaHowMk9ucTErRUFMb3dBYWRwS2JEaDh5?=
 =?utf-8?B?YldRWUpNSWVveFY1VHNVQXBtN3lQaWhZdWkzYUtNZC9PbUQxVzNQaDVRUnFl?=
 =?utf-8?B?OFQ1KzlwRWpVaUV4WjgxdXU4RFhZQjBXMkZXb3FsNVcwdWhONllLQUtScnFq?=
 =?utf-8?B?T1FURktOTm1LaHEvalROU29TdmJGN3NaMXdtaW9LZlF2U3Jhcm9MQzBjKzhR?=
 =?utf-8?B?WHFDaWVWTWJkVmhGVU5Kd3JlTGtWdXZWN09VcVBoL01raFlLUXVpeWlSaGZB?=
 =?utf-8?B?TXZmSDFVbjZUL0cxYjZ6dHZ5bWduVXFIemYxdUFkK1ZYdEQ1ZnhzTjN2MGZW?=
 =?utf-8?B?aGlwd040dmJSd0FZdEJRTXdKOUExc2V4cER6UGRYQS9aYVVPYkh0bmNrWlJo?=
 =?utf-8?B?bWZlN01VWHJhRGZyODA3WVYrQThVVWhQOUhKc3Vtck94bXowRDM1N08vMTcr?=
 =?utf-8?B?MWZoZ2wrdk14bW5BcnRpVlo0NHdkYVVEV1gvVFhtQTJiREdTM3EreHVkSEJO?=
 =?utf-8?B?cTFFZHJWbXBnUmZDVUZKUUc2b2N6Sk0zOXVSYkxnUmdRakhnQUdWdXJCcWFx?=
 =?utf-8?B?NzBvZmp4UktXWlFOMGdFeU51WkpnOTB6bkJBVEpLa2RNQ0k1ZHNBcFFBUzBQ?=
 =?utf-8?B?L0pNYTMvWk82U1pSUGgwRXVuaHovbEFScTNac3l4cHF0MXRXdkxrdUxZUW1m?=
 =?utf-8?B?ZERmeHZPQzM2dzk2ZE9JSG1TcHpTbzhxbzZIZ0FRaXZGSHhEUnRiSlBjN1FH?=
 =?utf-8?B?K1JEYnB2c25rZkh5ZzQxVjBId0Qwd3F3OUE5SGRwK25FMnVUSk5VYlQ0N3Bs?=
 =?utf-8?B?c1NUZFRxS1lpMFQwNmE2aWxDcnpkajJvUTJCdm12MzVSTzhhVkZZcVdSMUda?=
 =?utf-8?B?WTR0blRTVkZKanlVMWNUOW4rWExYU2lmNVo0aVJDUml3SjZjVzZWM0szelFP?=
 =?utf-8?B?WHZNTkRjbVEvdi9tTjEwRGVtY0hkbFpWeEYvNmNxbmtROUdRL013ODFFbjVn?=
 =?utf-8?B?dTQ3dzNMd3VGR08vTE5xVHVPT1psZjh2TURBeXNWYXBjblBReWw3K09hUGow?=
 =?utf-8?B?MXpGd2ZML2NjcjhRd0JzVWczR0t0c3l2TWw4Zlo2WHZTdEZDSE5pZE13K3hV?=
 =?utf-8?Q?69DzNA5oXGUdAHfjpZi19DnD2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85a73c9-92cb-43c6-c788-08dcedbfde3f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 08:52:30.6205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+6F5N4IT8v9IeICYk2dbw5x20mlzzZy7HDAEDIIg4QhVMQAj2TaZc5+3IeVgr4OQh9FADMYtcAVr4dWM94jTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6711

On 9/30/2024 8:52 PM, Tom Lendacky wrote:
> The RMPREAD instruction returns an architecture defined format of an
> RMP entry. This is the preferred method for examining RMP entries.
> 
> In preparation for using the RMPREAD instruction, convert the existing
> code that directly accesses the RMP to map the raw RMP information into
> the architecture defined format.
> 
> RMPREAD output returns a status bit for the 2MB region status. If the
> input page address is 2MB aligned and any other pages within the 2MB
> region are assigned, then 2MB region status will be set to 1. Otherwise,
> the 2MB region status will be set to 0. For systems that do not support
> RMPREAD, calculating this value would require looping over all of the RMP
> table entries within that range until one is found with the assigned bit
> set. Since this bit is not defined in the current format, and so not used
> today, do not incur the overhead associated with calculating it.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/virt/svm/sev.c | 141 ++++++++++++++++++++++++++++------------
>  1 file changed, 98 insertions(+), 43 deletions(-)
> 
> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index 0ce17766c0e5..103a2dd6e81d 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
> @@ -30,11 +30,27 @@
>  #include <asm/cmdline.h>
>  #include <asm/iommu.h>
>  
> +/*
> + * The RMP entry format as returned by the RMPREAD instruction.
> + */
> +struct rmpentry {
> +	u64 gpa;
> +	u8  assigned		:1,
> +	    rsvd1		:7;
> +	u8  pagesize		:1,
> +	    hpage_region_status	:1,
> +	    rsvd2		:6;
> +	u8  immutable		:1,
> +	    rsvd3		:7;
> +	u8  rsvd4;
> +	u32 asid;
> +} __packed;
> +
>  /*
>   * The RMP entry format is not architectural. The format is defined in PPR
>   * Family 19h Model 01h, Rev B1 processor.
>   */
> -struct rmpentry {
> +struct rmpentry_raw {
>  	union {
>  		struct {
>  			u64 assigned	: 1,
> @@ -62,7 +78,7 @@ struct rmpentry {
>  #define PFN_PMD_MASK	GENMASK_ULL(63, PMD_SHIFT - PAGE_SHIFT)
>  
>  static u64 probed_rmp_base, probed_rmp_size;
> -static struct rmpentry *rmptable __ro_after_init;
> +static struct rmpentry_raw *rmptable __ro_after_init;
>  static u64 rmptable_max_pfn __ro_after_init;
>  
>  static LIST_HEAD(snp_leaked_pages_list);
> @@ -247,8 +263,8 @@ static int __init snp_rmptable_init(void)
>  	rmptable_start += RMPTABLE_CPU_BOOKKEEPING_SZ;
>  	rmptable_size = probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ;
>  
> -	rmptable = (struct rmpentry *)rmptable_start;
> -	rmptable_max_pfn = rmptable_size / sizeof(struct rmpentry) - 1;
> +	rmptable = (struct rmpentry_raw *)rmptable_start;
> +	rmptable_max_pfn = rmptable_size / sizeof(struct rmpentry_raw) - 1;
>  
>  	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/rmptable_init:online", __snp_enable, NULL);
>  
> @@ -270,48 +286,77 @@ static int __init snp_rmptable_init(void)
>   */
>  device_initcall(snp_rmptable_init);
>  
> -static struct rmpentry *get_rmpentry(u64 pfn)
> +static struct rmpentry_raw *__get_rmpentry(unsigned long pfn)

pfn type has changed from u64 => unsigned long, is this intentional ?

>  {
> -	if (WARN_ON_ONCE(pfn > rmptable_max_pfn))
> -		return ERR_PTR(-EFAULT);
> -
> -	return &rmptable[pfn];
> -}
> -
> -static struct rmpentry *__snp_lookup_rmpentry(u64 pfn, int *level)
> -{
> -	struct rmpentry *large_entry, *entry;
> -
> -	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
> +	if (!rmptable)
>  		return ERR_PTR(-ENODEV);
>  
> -	entry = get_rmpentry(pfn);
> -	if (IS_ERR(entry))
> -		return entry;
> +	if (unlikely(pfn > rmptable_max_pfn))
> +		return ERR_PTR(-EFAULT);
> +
> +	return rmptable + pfn;
> +}
> +
> +static int get_rmpentry(u64 pfn, struct rmpentry *entry)
> +{
> +	struct rmpentry_raw *e;
> +
> +	e = __get_rmpentry(pfn);
> +	if (IS_ERR(e))
> +		return PTR_ERR(e);
> +
> +	/*
> +	 * Map the RMP table entry onto the RMPREAD output format.
> +	 * The 2MB region status indicator (hpage_region_status field) is not
> +	 * calculated, since the overhead could be significant and the field
> +	 * is not used.
> +	 */
> +	memset(entry, 0, sizeof(*entry));
> +	entry->gpa       = e->gpa << PAGE_SHIFT;
> +	entry->asid      = e->asid;
> +	entry->assigned  = e->assigned;
> +	entry->pagesize  = e->pagesize;
> +	entry->immutable = e->immutable;
> +
> +	return 0;
> +}
> +
> +static int __snp_lookup_rmpentry(u64 pfn, struct rmpentry *entry, int *level)
> +{
> +	struct rmpentry large_entry;
> +	int ret;
> +
> +	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
> +		return -ENODEV;

Can we rely on rmp_table check in __get_rmpentry() and remove the above check ?
If rmp_table is NULL, CC_ATTR_HOST_SEV_SNP is always cleared.

> +
> +	ret = get_rmpentry(pfn, entry);
> +	if (ret)
> +		return ret;

Regards
Nikunj

