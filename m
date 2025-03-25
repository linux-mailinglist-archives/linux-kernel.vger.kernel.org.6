Return-Path: <linux-kernel+bounces-575216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FCEA6F466
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7650716C220
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8754A2561B3;
	Tue, 25 Mar 2025 11:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SiwXT74L"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2058.outbound.protection.outlook.com [40.107.20.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7FD1DF72C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902853; cv=fail; b=EJZCgJQUfdUpHvT/pZcOB0v1hkVSC0Ze7JWG8HtDREQvh36jcstewWtLqjzQ/gsCbNfZfCG67Sc6gjGn66bNPYoCgSUB0czyEt4DSjJRkwm+KWW6q+AsEMvS8vwY1lbtcfq4L8a5b7gmH6y8o4lW+YXwmfwZFPWkHXXrN+Hzx8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902853; c=relaxed/simple;
	bh=2I7fvKqkbdBjtZ0z4fiCztjGngjtrs17qbFA3guLjgw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A5mOM4udZBrKGSGZDWIaF9mWRn/lLOhRYoZ8zeyDCbedvxqg145wJuJB2Ykr00S6FWLPHK1yrmqK4DgPzkzbrX1c0qIjiq38wnPrgV4Xy3uASTYO1ldkWyCH35lQGrJBBF3mdYRafI+LHi5mHCulyCmU3WOuGC3KgFSKI+FsGxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=SiwXT74L; arc=fail smtp.client-ip=40.107.20.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPfCc/Locsyrady5xcCLyw1eAxG17w66iMYlQx+Er3KWREb7QO7oIsYs5XRPynnYO3NNMd4P3xxRZKYv4qNqOxGwagdapKNN1d1WEqxPCEj0gFCBgi9tbpd7znDtq41Rw/UEzu22q5BlRiCglHMSBURBCM7CWfgYFo02S8r8xkKV/Y6ttts8WXNRh01db0yt2pYtUAwZ//qCYAJKOkkfuydv8598RWPlHhcn2NinkUFfm2ybTk4S5hhUaSjmmMKulAdJXuNSWotV8pcc62p0FRM71hCCWWZPma3tFW6UpHKBs8Zj566P6xlh+8p29/pHd+n3fDbrVHtpGOea64qBAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9p8SxoCgO1CRxOGHFQK1oOByabIkxwuKSUJPUEUyKc=;
 b=Vk/UNJ0Z7QwRgCO7b6TWL5+licvNMedUteQDWeoU0jv2jzeLLkSJY+DTh7GBZk3iqWxR5+yco+jTKoyUTCi5XLymGiQ/2UumsGZqLtwd2oo3ZAlsp0+Ui3jwaUsaa7vUCkqiWTIT+sSfdVNxshyDD5RyY3YERyJvr8VXNUY6e7Qt2OhWc0/C9peO515q5CS9SAi44VHBW7onNh3IlIG9M0101HAO4wqcvxgNEfNf/J9Q4lUs88SLDrWdzJDZTQGQECWj0MCQeUDbstmjdkwdNwjkKt/P37h7Idww6VcW1pdWTRNwXqtnYS5nO8u6gtIAPpSoG5FirlBbqHAXCD3RVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9p8SxoCgO1CRxOGHFQK1oOByabIkxwuKSUJPUEUyKc=;
 b=SiwXT74Ldq2s5g4r5bgkvAviYUZRv5RsUYqx6mRZA5mMxGFCi2BH3dq+vTVqvXX+hhHpKywgA+nYNsreyUh+iAduaP6fC/vuc/2dFmaBWdBfXyXfhD307X6mJFuV10vLrFxsmfNFBGT/kwmcqBaaznU4ztObAmi6aeh57w+jHo7wcQS3DsqVU9WrzXEtqVwuMlx/W8XR1EgVFH81A8qkTntSHnklkU4YRG0pd1xlHuZXCp/xYxtghjx/aDNzLSRi2PwMo9GFfGBFxhctbHfv8mlvcqFan4HwURtuU5ubdnaKYVU+GnXZa1rxG2pkbv5WYZOlmVyG+FbDUIxPlThZXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24)
 by PAXPR04MB8766.eurprd04.prod.outlook.com (2603:10a6:102:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 11:40:48 +0000
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::c96e:12f1:67b7:ed74]) by DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::c96e:12f1:67b7:ed74%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 11:40:48 +0000
Message-ID: <065d6f32-3161-8316-bbbd-4da18eef839b@oss.nxp.com>
Date: Tue, 25 Mar 2025 13:40:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/2] clocksource/drivers/nxp-timer: Add the System Timer
 Module for the s32g platform
Content-Language: en-US
To: Daniel Lezcano <daniel.lezcano@linaro.org>, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, Thomas Fossati <thomas.fossati@linaro.org>,
 Larisa Grigore <Larisa.Grigore@nxp.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
References: <20250324100008.346009-1-daniel.lezcano@linaro.org>
 <20250324100008.346009-2-daniel.lezcano@linaro.org>
 <d60fca36-0beb-2574-cb82-3969bbfb58a9@oss.nxp.com>
 <8c208e8c-2e1e-430c-916a-dbc6732881b0@linaro.org>
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
In-Reply-To: <8c208e8c-2e1e-430c-916a-dbc6732881b0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA0P291CA0015.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::20) To DU2PR04MB8582.eurprd04.prod.outlook.com
 (2603:10a6:10:2d9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8582:EE_|PAXPR04MB8766:EE_
X-MS-Office365-Filtering-Correlation-Id: 23abe2b7-468a-4002-f592-08dd6b91e2e8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ukd3UFpDbHZHbmVVd2hLZkhpL25nZVRXbEViTjhwVnBwUzFmNjJMZ1BPd3N5?=
 =?utf-8?B?NWRueXBvWnBaYXg1aVllRGpvUHZTYmh0SFE2cjVvT3MzQzM1bXh1aW1pZWZ3?=
 =?utf-8?B?QnZOU3BGUFJNRkhIVlU2ekxPSEVUemRGWmJqMkV6WURSY1hXUXFxWklPOGhU?=
 =?utf-8?B?Wm9HTkxsMG5UdUlxaUFITmNlWGJRYVRYTEU3WTlJc05MeDFZSFlOYmx4NzBn?=
 =?utf-8?B?d0dYREQxUjNuM3pGdWlBcjN4TG9WNzFPZTc2VVFjdmZweFNRWTJIa2FWVUZl?=
 =?utf-8?B?NEx5MTlZWENhcmZrMlBkTGdHUU1WNjZWNStRSnpxbjJoSkQ5aGNXdUNrOEoz?=
 =?utf-8?B?QkxxaSthbWZwdVRJWEtqS3VscUFIU1J0c0hjSXJXdnEvSnY2aFhqTmxac1c1?=
 =?utf-8?B?NGNXR0IzVFhYYXpVckQ4TzIxQVR0VU9uVERXT01pUS9wTWFHZDVNZ2lLRWx5?=
 =?utf-8?B?Q2p6dzQ2OWJtNEMzbmVYbnNUbEljR0FPNXRWTk1uOWdBTDc0dDFPWUordW1h?=
 =?utf-8?B?QjJIbzdHNjlxNGRIaHJES0p3aDFsbWpJemNhM05vWVVhSTFLN3dBN3ZRVnJE?=
 =?utf-8?B?TXlWSTQzc3ArVXJrM0hlcktDQjRMeWM2cElaN2VlbFRhSHZMU2EvRDduVWJF?=
 =?utf-8?B?SndQZG96NENHNStBOHl4S0VrbldocGVMc3VOM1lGK0hRZHVCYkJlQlE5azlN?=
 =?utf-8?B?VFVLS3RMb1hiZmYybHVIVktLaWVTbGJiWWRmbUF4ckR6Tjhxb2owR1Z3dE9Q?=
 =?utf-8?B?ZHlFVmpBdXpvK2pxOUhMbndZQWpsTnF5UU1wVDNNcG1EeEQwVzBHSUpYdFk5?=
 =?utf-8?B?VUFmVmdsWXU0Y2NGNGRtTnAwaEJiS0tuKzJyMlVUcE9ObHlxU3VNc3I5SGIr?=
 =?utf-8?B?RnZvTDNVT3BURElzcDQxMWtLUHl0ZXp6UUFIU2tuWkptNDBQdGMyTUN3T1pG?=
 =?utf-8?B?ZC9CWWEyekYzMGYvT0p6d1QvaFJLWG5pUEtFMVNQYmFjS2tkbTZvOHpHN2dS?=
 =?utf-8?B?dkF3dTJxT281WFI3elNvT01iTzRKYmZOaDJzL0lyQTNLaWQ3OXNzbm5qVGRv?=
 =?utf-8?B?aWlVQjdPMG5Wb1hTK2h5UDQ3UGtZOWozbklNZjZORVZjS01aVGtZc1lVSjlF?=
 =?utf-8?B?cE9Yb0VhVHdXekNCdGNDd2Uwa2Y4cmRZNlRmNVRwamFYczEyNmwvNmJsZ0xU?=
 =?utf-8?B?bnBGcFdHY0JzSldqVFExek1jb09jNXROTTBZaEZjNjZmZ3REUksveGxBRmpZ?=
 =?utf-8?B?UTNNcmNaTlVFVmNpRUluWjFVTHJEMnhmYjZHZ0Zmdm42MEtmVU5xNUozOFlv?=
 =?utf-8?B?YlVpcmpoSWUwZC9OMXpuemQwY3NvOEIxNmpEaGttclAwTWt4bzI2RjRxL1ZG?=
 =?utf-8?B?UmVRd0kvOExvcEV6RWxpay9uN2FqblE0QnlOM2cwOUI5NmZaR3ZnWk9hWllP?=
 =?utf-8?B?WWdySTQzaWZBRE1JSHhzRk82ZUxIQTJEMFl0SlNHQXo0SUFsSjJHcmwrTG9t?=
 =?utf-8?B?b2dkM2kzeHZFV0lOTjlxVmhpR1k3MGhQTG5rb2JxRnFtbTdJWlEzZ3BPLzNW?=
 =?utf-8?B?a1gzeWxGT1czcTB0dzZ1Mk1DQ3NzSXlGUGdhZTE1dFVaMXVoNlRVQko4Q2V6?=
 =?utf-8?B?d2xvSDdHYStIam5HdklwK3h6RERBaDZ5dzZTamRmRVRQVitGTFJJekt0NytQ?=
 =?utf-8?B?VDZiTU4vN3lzU1BqWVFEY3FCYTMxbHh2MkhiOFgrVDdrQ2VUSGVOczIwbHU3?=
 =?utf-8?B?QldoeFNQWFdJNmtUc1pzZW14WEFJeGhMRzZDVHlVV01YK0V0Q05XZkpDZUJO?=
 =?utf-8?B?SDA4ejhlN2JtMGRSa0lXMEREdnYvZEx5cDlCcUpnRk1LbEFqYjZYcGdNV1p3?=
 =?utf-8?Q?CT14Hvnl1fg+Q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8582.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U044UWRTbmR0KzdSQ0hDV2pucGdzS05SOWJIakNJY2hyYUs1eU5xdTNMV2dt?=
 =?utf-8?B?VlliZDI0VWRUbXlvYlgwQTd2Q3NYcTdTanpiK1FHVlJEYWNFc0tBemR2ZmZQ?=
 =?utf-8?B?OTBSVTlxUnVadzgxQm1CNWRHU0xWK3phL3pjaVhZaG9uV092Ny9vTzZ2blpk?=
 =?utf-8?B?WkRkOGNpOWtrelROaVArMVoyb01zSVdLdmlDK1d0ck8xc2pXblh5R2o0VFRm?=
 =?utf-8?B?SWR2Mi9md2NJdmp5TURWVmg0aUhYUmplZmkzSVErVm5taTFlT3JtZ1ptb1Z0?=
 =?utf-8?B?MFlCZCtrdU90VmN6QThGZEZiaTk2L3hxRW1uZzQ0MHJYL2Z6Mk8yR1dBWUp1?=
 =?utf-8?B?ZG9lQjZBTGt5M1JENzA0ZEpsQ25PTllaRkVBTDF2NnVtY3dST3k0Sm9sd3pE?=
 =?utf-8?B?UlEwOFlxcmJRWkxVckxjbGUxN3dOd2JCMk5KcE1tOGdJSkFkMkJTcm5PTHFt?=
 =?utf-8?B?czdNZUdqcU1HU05UT0h3dWJyaVFQOXcvZXdpTUlESmZERTJMaEhwMXgxUnY1?=
 =?utf-8?B?QkRYQktrdzNOanI0R1NOWThGWWN3dmRCeG9Bd3paZlR1TTByMXFQUzJkbVEr?=
 =?utf-8?B?Wk13WEF3R1U5VW1EZjl4RkNBYXdGWHYvQ2Q2dldwOFd5V1dnU0FZTlU4ZFBu?=
 =?utf-8?B?QmJKY2d2SWtLTk4yZWJGczB3cENZY2N5Q2lVMERBTm5WMzc3SDNPeXNLZVpr?=
 =?utf-8?B?NnJXRW1VUG9lSVFUU05UQW1mRHJWdER6WW55aDdlN01KVWlJNnA0WGV3bUlJ?=
 =?utf-8?B?K3FEa3BqY2t2WlFtWkZ6NVRNRCtKMEhNcW9IU1Y2aWhKUGxtQVRZZHA1eDVu?=
 =?utf-8?B?V0VrK1BxcSs1TFBwaVd3UGwxL25zVVVzdUg5bFYvcUhoLzZ1MDRYTmtpcGRW?=
 =?utf-8?B?MklhWjl4bERVSXd2NjBYRlJCNmdwOXEwZjFWUUFRTU93WGZ3Rjh1QU9Wak9l?=
 =?utf-8?B?QWs4cjBMNWUxVzkzM29OVkFuUml6bFViUjlGTkMwSlJhdmFpejkxNktmYXEx?=
 =?utf-8?B?emFzK2FwNWY3VlpQV21YNmlUenZxUVZwNkhrK2ZwL1ZBMFQxTHhpUHdsa2JT?=
 =?utf-8?B?SHBYdVlveVUxSm5qWDZ1OGlBVS9LSENSZ3RyOGsvdEtNc2RPbENZa3hVWWRk?=
 =?utf-8?B?UFZ0bUNzSjdPUHZ5ei9adEdDZlQrUjZLZldvZ1NTQUNTMTZFOGtydFd4OHRH?=
 =?utf-8?B?MkJKVFh0VUNyNjBZOXhodmlMRjd6YjJ3eFppaFJUb1drdWdkU25CdW1SZzIw?=
 =?utf-8?B?WFNYenYrWC9hQWU3RzQzNCtISCsrNHNIY1pMSTZ1cjIvWGhWTVJvUFBYUmp6?=
 =?utf-8?B?R3J0V1RzeTd1ZmR5NWdORkJTUTVrV1Azcyt6dmVKcldCRW5PK3NvNE1WMG1V?=
 =?utf-8?B?dzR1QkxzQjNpN1E1QnoybjBiYkYrMTZpeDI3UERPZ3lQT0Q0cDNqdmFMelV4?=
 =?utf-8?B?RnI1MGFRNEVpYWowYWd0Y25UODJZTXQ1aGVMUjl6NGlkc1hYSFYvN3k5K3E1?=
 =?utf-8?B?VFFwNUlMVFFzMHAvMm5scy9yT3ZaOG9lc25yL09TYWFTMDJKN1ZkLzNUdWQ5?=
 =?utf-8?B?RTc4RWZqa09XdFZ2eE8zV2hhSGhBbHpyN2VDTEs4ZmtUK1dvbzNjQXV6d1Ay?=
 =?utf-8?B?bVNldEdNM2thOFZNYzRtMG5ORkFrOGx0bTY3eG95SVBWVlQ4Q3hGdEo0T1Z1?=
 =?utf-8?B?b1JReVBPclk4emo4Ykx1VGsrYVNXV25SQkNXZloxYUo4djRNVGszbTVJQ1dE?=
 =?utf-8?B?TThlQzBUdG1jZVpxT0tDREh3b3FLdjN1RzIvY1k4blVtZ0tzbEUza0Z3MkNn?=
 =?utf-8?B?dUw0QXV0RHRsZ0xDUVVYMlk5MCtTdlE2UTBTZWlKZ3hMcTJ5amgzTUZMUXVW?=
 =?utf-8?B?UDNxaDBFUk5tSkY4WGI1TUVrS2xINDBIcnd3N0pheW5MNlgxWG9DWnVmcjVF?=
 =?utf-8?B?Z0hBYXorU2NobGNObXJ5RzVjRGdWS25yVm1uQUEvSXFyL0RBQndyMW0xU2d6?=
 =?utf-8?B?OU5NQTEwK05wV25NUTFRMDFqNHNrc29JWDZ6Y2VYT3dNems0Y2pDTUlhZmxK?=
 =?utf-8?B?cUdZNHRSbGdjUmVXRHduR2cwYmlyaW9vSVRzdUhsKy9kNTIyQ3RwVERzTXFZ?=
 =?utf-8?B?VmF5b3JXdW9FUDBvbXROWnlzVFNQS1RHTk9vUlYxS3hITGdWZnRvY3BlVFRs?=
 =?utf-8?Q?a++n1R3XYrQKXD8ZHB+4WCc=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23abe2b7-468a-4002-f592-08dd6b91e2e8
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8582.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 11:40:48.0745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ikzco8/FGX6PTFTe6671tXDeKN/YexjRAHj3SHOgw3xJTsPqycSIkXR3iZMfDBAX++I6SG262FiHrhUu7og5IHaB0jkkY0avwoMEp41EkzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8766

On 3/25/2025 12:53 PM, Daniel Lezcano wrote:
[ ... ]
>>> +static int __init nxp_stm_clocksource_init(struct device *dev, const
>>> char *name,
>>> +                       void __iomem *base, struct clk *clk)
>>> +{
>>> +    struct stm_timer *stm_timer;
>>> +    int ret;
>>> +
>>> +    stm_timer = devm_kzalloc(dev, sizeof(*stm_timer), GFP_KERNEL);
>>> +    if (!stm_timer)
>>> +        return -ENOMEM;
>>> +
>>> +    stm_timer->base = base;
>>> +    stm_timer->rate = clk_get_rate(clk);
>>> +
>>> +    stm_timer->scs.cs.name = name;
>>> +    stm_timer->scs.cs.rating = 460;
>>> +    stm_timer->scs.cs.read = nxp_stm_clocksource_read;
>>> +    stm_timer->scs.cs.enable = nxp_stm_clocksource_enable;
>>> +    stm_timer->scs.cs.disable = nxp_stm_clocksource_disable;
>>> +    stm_timer->scs.cs.suspend = nxp_stm_clocksource_suspend;
>>> +    stm_timer->scs.cs.resume = nxp_stm_clocksource_resume;
>>> +    stm_timer->scs.cs.mask = CLOCKSOURCE_MASK(32);
>>> +    stm_timer->scs.cs.flags = CLOCK_SOURCE_IS_CONTINUOUS;
>>> +
>>> +    ret = clocksource_register_hz(&stm_timer->scs.cs, stm_timer->rate);
>>> +    if (ret)
>>> +        return ret;
>>
>> clocksource_unregister during remove callback for cleanup?
> 
> Sorry I don't get it :/
> 
> There is no cleanup after the clocksource_register_hz() is successful
> 

I noticed that other drivers, such as
drivers/clocksource/timer-tegra186.c and
drivers/clocksource/timer-sun5i.c, perform clocksource_unregister during
their platform_driver.remove callback. Shouldn't this apply here as well?

[ ... ]
> 
>>> +static int nxp_stm_clockevent_set_next_event(unsigned long delta,
>>> struct clock_event_device *ced)
>>> +{
>>> +    struct stm_timer *stm_timer = ced_to_stm(ced);
>>> +    u32 val;
>>> +
>>> +    nxp_stm_clockevent_disable(stm_timer);
>>
>> While examining the code base, I came across the
>> drivers/clocksource/timer-imx-gpt.c file, specifically the
>> mx1_2_set_next_event function, which includes a protection against
>> missing events. Using a similar approach would allow us to keep the STM
>> module enabled while only altering the channel's register state. This
>> risk can also be mitigated by adjusting min_delta_ns based on tick
>> frequency.
> 
> How would you validate that ?
> 

How would I validate that this works?

If this is the question, I see that the core performs an auto adjustment
of the minimum delta as part of the clockevents_program_min_delta
function when CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST is enabled.
Initially, I would examine how many times dev->set_next_event() returns
-ETIME. At the end of the function, min_delta_ns should reflect the
actual minimum delta the device can handle.

[ ... ]
>>> +static int __init nxp_stm_timer_probe(struct platform_device *pdev)
>>> +{
>>> +    struct device *dev = &pdev->dev;
>>> +    struct device_node *np = dev->of_node;
>>> +    struct stm_instances *stm_instances;
>>> +    const char *name = of_node_full_name(np);
>>> +    void __iomem *base;
>>> +    int irq, ret;
>>> +    struct clk *clk;
>>> +
>>> +    stm_instances =
>>> (typeof(stm_instances))of_device_get_match_data(dev);
>>> +    if (!stm_instances) {
>>> +        dev_err(dev, "No STM instances associated with a cpu");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    base = devm_of_iomap(dev, np, 0, NULL);
>>> +    if (IS_ERR(base)) {
>>> +        dev_err(dev, "Failed to iomap %pOFn\n", np);
>>> +        return PTR_ERR(base);
>>> +    }
>>> +
>>> +    irq = irq_of_parse_and_map(np, 0);
>>> +    if (irq <= 0) {
>>> +        dev_err(dev, "Failed to parse and map IRQ: %d\n", irq);
>>> +        return -EINVAL;
>>> +    }
>>
>>  From commit description:
>>
>>> The first probed STM is used as a clocksource, the second will be the
>>> broadcast timer and the rest are used as a clockevent with the
>>> affinity set to a CPU.
>>
>> Why is the interrupt mandatory when the node is probed as a clocksource?
> 
> It relies on the DT description and it does not hurt to have a
> consistent code path for clockevent / clocksource even if the interrupt
> is not requested for the clocksource later.
> 

If so, in my opinion, it would make sense to use the same STM instance
for both the clocksource and broadcast clockevent, as both functions can
be accommodated within a single STM instance, which will help reduce the
number of STM instances used.

-- 
Regards,
Ghennadi


