Return-Path: <linux-kernel+bounces-577038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA6FA71791
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9D6D188C0BD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42521E98EC;
	Wed, 26 Mar 2025 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iCX9GnB0"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013014.outbound.protection.outlook.com [52.101.72.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC3815278E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742995880; cv=fail; b=d7WqhFsNSXDmUSyyzro016g0BuCVHDUHfaMmKW3hg8G5aiYYs8PUluNOn+V9OhYe7u19GOt/LkGQ/DILzxYj37UloV0f7haaealIxiDv0gUa9F0aEFb1zk5r9ofTE9UIoOBGMHxZQEOzYWyDkTF2+3dUF1Z6AEOOesjv0mJHSF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742995880; c=relaxed/simple;
	bh=KvTZzQJQ+7cUKQnIvcC6gotMmDxw45yYg2rZFqS6Zts=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TIL/DhuxuYjYkNBf63ijjtdVA6IjstCy7tSvRpxx0tjCzsDPFRo8JvpEyTW2Kpw0B7th0li0yNHIJOOyw/Uq0IkSk5eEfRxTSMt4kOaGFEID6HRNKGCDlii405fp+wF5+x2AxCFB2aD2E8nALH6hPiQWo/F/JeezPG/i2t2VVH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=iCX9GnB0; arc=fail smtp.client-ip=52.101.72.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4Bn00Og/Rv/rRP9jIf1gvr9snWqGc4Z4UVENXSdy8w0JkouCuwXCFHvb/9eN/5qlRTz9Tb6grZA6McfjLc4NvJcWw3GZiLg0CIWawdBWCxWemujsoHX8xfTNCtmJ2EyxSouuAmlwksZYj+jAwY7uv+X8p6ERIE//6GSqTRcn0i8+2mqX1A3ezd/SposUk19Iy5FLqtMUiLcOOIAbabK9UajwigO4G0AvPPVD9iUCmhXkU6/uEK8s4ZNg+uQR44beyuW/yvWP88kyJAN8mSifPXVZbgtmVmRH3VtLCVFJoZdr8/xPmPPiB2KVM9rpEYtY4+Nc+1gE5ldfImva3vPyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnBFVHU6d/YAjyXH+U4GdR5Z8mjPJIBomVlgza2xcuc=;
 b=krswemMkbixaq+zuGUETaQ+GC6Gtc4fPdIzvWzAoBWzTkKH4JUV0s+8GPpQDTUdJmJ5CJvIs/cXUxe9Jo7eNDTm2vP2g8SSoA0dFPN/uNLNov/mDQJb84fRXipz5LYi3hKhnp1o7G0i80AxsgOOcL83189MTchqe7PFMd4cSiZiRHzI6NZw4odaueHwg1ubncn2Ad9BxxsxNl/5m8cfzba4/9gYZFqxNtxSMdA7HICUuLbwlQFmmaBbICf/AuCCwcihgkl/gtuVeqOAqVcRrg3s9XKTcCX3YPPp7MBfrc4GM8QNSLIu+DTamtZgHvk2d6YXiAUM4Uca/EKs2gdxRjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnBFVHU6d/YAjyXH+U4GdR5Z8mjPJIBomVlgza2xcuc=;
 b=iCX9GnB0vvL1prhGAujcDTUeotohYASqrVgJNnVLXggdvQ4AqkiENwcUkY0qdNGbtsViYS+N/QH1vNCegx8YE7fUhSW4+tfb+2tJSOE7iakXBi9uD43XqVIVIr6j7HIgINORPLmBginO27Yp5PpEaMMeurylsCahGaIKZbVYn0LGTNhBnRNBcdLn77ibJv2ElU4lj/ty9YTjq3YgYejHXbBNgCOHCTZbHGOO21WOyBbLF+j8mkaTsTaAPov28qXZe3PlSqD3yInIz3dwP6nuU0TTQmsW/D9eJNbrETzNqp7ciZMP0sf0p+GiPwrTSjTjfidgJpZ3wjPV/Azbmefe7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24)
 by AS8PR04MB8962.eurprd04.prod.outlook.com (2603:10a6:20b:42d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 13:31:14 +0000
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::c96e:12f1:67b7:ed74]) by DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::c96e:12f1:67b7:ed74%5]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 13:31:14 +0000
Message-ID: <6b48ad6a-2b45-455f-1ba8-3d90deb516f4@oss.nxp.com>
Date: Wed, 26 Mar 2025 15:31:10 +0200
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
 <linux-arm-kernel@lists.infradead.org>, NXP S32 Linux Team <s32@nxp.com>
References: <20250324100008.346009-1-daniel.lezcano@linaro.org>
 <20250324100008.346009-2-daniel.lezcano@linaro.org>
 <d60fca36-0beb-2574-cb82-3969bbfb58a9@oss.nxp.com>
 <8c208e8c-2e1e-430c-916a-dbc6732881b0@linaro.org>
 <065d6f32-3161-8316-bbbd-4da18eef839b@oss.nxp.com>
 <098c5de8-9291-4f3e-a276-500825cac7c5@linaro.org>
 <068713cb-47ca-ae26-e113-9f5026be9196@oss.nxp.com>
 <cc2dd75c-e279-4e55-ab88-75498e93146a@linaro.org>
 <50d2c651-746e-4ddd-4036-f72742a622f8@oss.nxp.com>
 <e8054f85-2a23-4ceb-8e1c-7cdfe7c87628@linaro.org>
 <a31a575b-8f6d-6317-f172-b4f8b1a5cda7@oss.nxp.com>
 <f1268261-c900-4adc-aefe-795f23faba59@linaro.org>
 <2d7b18bf-31ed-abfc-20db-7f5b54c812af@oss.nxp.com>
 <16d02edf-181e-42a1-8b0f-cdef61109fbf@linaro.org>
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
In-Reply-To: <16d02edf-181e-42a1-8b0f-cdef61109fbf@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0002.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::11) To DU2PR04MB8582.eurprd04.prod.outlook.com
 (2603:10a6:10:2d9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8582:EE_|AS8PR04MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: 9792cad7-32ea-4c32-82d3-08dd6c6a7add
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWhlMm1JMEhmUTNXcUlkVnY4dURtVVEwMFJEejU3RW4ycDdrWnJOREVWaHEv?=
 =?utf-8?B?NUkyYURCaG9NSENlaFZGLzdxQ0pDNGFLZFhLUVNPeVUwSk5SVkU4dTAvWFhi?=
 =?utf-8?B?SjZoYzBOSU5jNXVZWERYNG9xZmVsV0VnU05pVlZvb2RxMG5OZ3lWdUZ4dzYv?=
 =?utf-8?B?QW5LV3AvQysvdFJPUnlqMU5icFB6SFlGUlZCeDRtL0F5eXJNZG5nMm1Uejh1?=
 =?utf-8?B?REZxNXVzV0pOYlZtT0d0Kzd3ZjMxTDdBYWE0RXdkdXVlc2hmWkI1YnpabXlt?=
 =?utf-8?B?TkJsK3g0WWNMV3krQVpCQWk4MEVWTmdUQUVMcXg1dXhCLzB2TkNjbDdyc2No?=
 =?utf-8?B?L2tFUDduS0ZIYlFkZjMveHhDRlFNY1ljMmo0STdwcUNuMWg1aXpXTWdDT1BM?=
 =?utf-8?B?aFBmalAvcTVJbndUZ2ZsQ09nVCt4UDFKYlVETUlZT1JNaDg1SUF1M2owRkdG?=
 =?utf-8?B?S0hmelpDQTNCUDhmWFdPRVdZcHo4QTA4QWNyejZxMVZ1QU11eVlxRXFWRWd0?=
 =?utf-8?B?V09mblJLdjFIa2RncFduVUtjUG5jUkJrSDhrejdJcUtJcm5zSDJBVXU2MTR4?=
 =?utf-8?B?YkkvSko1eGo4R1BxMFpDNU8xNGw2dGd5ZmZRUlhkSXBZL2hxZWpXaVo1ODgr?=
 =?utf-8?B?anZHQWlqdXNESEdSTjBMNThNeUoyZ1NtcTBsSDBUSTl3WjdjTzIyajBNUTB1?=
 =?utf-8?B?LytOVFYvbmZ6TVJneml5S0MvZkJuczY4eTlYVk1TbVlucnhMc21Wa2syTGNt?=
 =?utf-8?B?Wk96NGh3bGkyMnl4bktQNmVqUUZzemhtbzVXNVV2MG5xbmZTVWtLdGc0RzEy?=
 =?utf-8?B?ZmtMZ2gwdGxXZDcyYVZvN1lsSDJSU0F0TlVrN2hkcVp3K2lkUHg3NUdyUG80?=
 =?utf-8?B?Si9TUEZNbGVKNEZDNU43SllxNjltOUtZQmJrV0EvbFk2MHo5cCtRb0YyVi8v?=
 =?utf-8?B?N3hMVzBuQVpLUDYxbVZ2bGZqUVJGYzNTb0ErUzV4MDFoL3ROTEx2ZnVuUHpH?=
 =?utf-8?B?U3pwVWU2WFlpdHMwQnFGL0VqSUdBQXZtcVJ0bStnMVp1UC9CVVViOVJjOGhl?=
 =?utf-8?B?bEk4WHhyMnE2VDNuRUhTSTF6bGE1T2NRQVlkMW1XL1p4dnNkUHY0UkZtTlY1?=
 =?utf-8?B?L1ZVc0l0NEFYYnpMOUdNaDhFUXZCTWJxeWRDNlFjRmh3VWdWblYyOWlLQUR1?=
 =?utf-8?B?YTYxZXBDdFZXMmliUXBPQnRwdGhjOGFXYVdVVEJWekZ0NjdWOXl2ck1MRzR2?=
 =?utf-8?B?TkJocDg1S3lkRFhqQXFyVDlBUlFJUmdUMmM5K3hFOVpXeTIwRE5WcE9kNjBu?=
 =?utf-8?B?Si9Kbm96NE9ZUWU0THVkSVhpc3NlenZRekVHbXQrZ21zZGZsK0NSc1RzZWFL?=
 =?utf-8?B?RWRTMlEzMUNMYkxPNzZYdUtlemNucE1Rb0hUVHJJdVJVL3JyYkdxek1kN0FV?=
 =?utf-8?B?VTNsZFdjNUdON1EwSEd2OStmNWMvTi81aUlvQjZMOVMwdjE2VWhGQ3hJUUg5?=
 =?utf-8?B?UHdwNXZlSDViRitHYTNDVmIra1lYTm94RjV1ZjBuejg1b2thbFdtWlR3OVU4?=
 =?utf-8?B?bmVLNTljaTUrZEdNSEJnVWExckhickFtamRIQTU5U0dEdFlhQWtzUjVSK0Z0?=
 =?utf-8?B?WEhiSGZtVCs0NmF0blF4dXFQNHA2OWdSbVFrdzVKRTlyem50NkJOcHdIQS9k?=
 =?utf-8?B?eDBxK2daUmJRT0I5c3NHcnhUU0JSYUlxczdjdzB2aXhVM3hwaFd0Y1MweEU3?=
 =?utf-8?B?ckMzcXoyU3JRUHdqR2E4amlOZDdQTGY5RG1ZV2hYaU1lVE9ldzBqWmVoWVU1?=
 =?utf-8?B?bm4rb1FLQVc0d3ZsZ0w2VjdsclBsd1d5eEswRDdjOENEb1FGRnV1TFZhcDBD?=
 =?utf-8?Q?zp+lADKDG12Be?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8582.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHcyNUpLOEdSQkRnREd0YTA5dm9oK3Qya1FMMXEveTROYnhNb1ZtbFBaODZK?=
 =?utf-8?B?dXVFT2pWeTVUendaeHArZXhHVU1xblhGMjVPY3hlOUN5TmRpMHk2dnZFTmVk?=
 =?utf-8?B?MFVyTTlLdUFEdnUzeXB6YkhpaDFIVjNPd0hZMnVlWTFTU2U4eVJkZVZrL1Zk?=
 =?utf-8?B?ZVBHcWxRU2pCYzY4akJxa21OYjBBVEsvVkl1RVVCeXZ0Rnd0U2lvL2xEZytt?=
 =?utf-8?B?Mk1WRmJFdkRXNUViZDhFOFFhQlNYaDdJbDJBbTZrYy9nRTA5ZjFCRGpFbUJp?=
 =?utf-8?B?UnhzWTRZWi9iNzUxbFBSZkQ0cFFqMWxlcHA3OXVyKzk2NFNhWWphTU9xWHAr?=
 =?utf-8?B?QmgzVXBXU01hTEhmenlhS2V6bkNrRXRFY0xXNkhOZnZCVzB6RGdBUEtCY0Vt?=
 =?utf-8?B?Z21nUjZUdnNaZUVqdnpjZitWNmtUL3VBMVhOT2IyRWxlMkF2cXcwN3ZPQlcv?=
 =?utf-8?B?WlRzQmY2SWFRMFpvVFNpQjZOZ2x2OEpYT0dmc2RzT3A4MUFhQUtUV05wUlVV?=
 =?utf-8?B?RFVEamQ1b2JwMFBpeWtqT0VBQlJVNmlYLzZCanRCNkVKakUzNk5QbHJrQ0Zs?=
 =?utf-8?B?djFEOXBtWDBpMVB2TlFWSjVWSmt6VHRrTStjQk1aYnV0R2xCMDVYUmUvbVh5?=
 =?utf-8?B?dW5xcm0xMCtQR1krZVErZjArSFJFbHBaYzA3cDhXM0MzY3dTbUdqdXI4cDB3?=
 =?utf-8?B?aUN1MzlSKzdtNityejFDSGV2dSs4Q2Qzc0xURm5PSjluc1phSmxuOTI3NVhC?=
 =?utf-8?B?NDRmT3pJQ0lzNmxhT1lXZEVyWk1YOUpxaUEwMGV2cmErc0FvTm5UKzlmLzV3?=
 =?utf-8?B?WUJrKzh1RmZPWjdzRHlpbEFGWndsbXAvSUN2c0w1REltOVVvTitReTVVQTdt?=
 =?utf-8?B?Zk9adFdRa2lkZ0lBcTV4ZUpiNXYxd3cwSmI2aTBOZmJGT1loSE14WXMrUDVs?=
 =?utf-8?B?RDltcDVRaC9yUVp5R0w1d1hJSGlVdGN3eUkwcTNPc2M0N1d0OHk5SXZkL1VQ?=
 =?utf-8?B?ZWR0UERvNDNxZG1ObXExd29rREpNN0tQdEtFUmM0WURhTVFrZFk5VW9IS0Yz?=
 =?utf-8?B?dVFqbHBkdlZaaGhJSDN3NmVWeXR2bktNY04xYnVEVTFKS2NNd1lDaERYM1Rn?=
 =?utf-8?B?NnNmUDhqQmdHMlMzc084ejFYb2YrMkl6MXFIQnBPcmxSMlZzY0hQdTMrWW00?=
 =?utf-8?B?d0JGdzFNSzZXS1BrU2hueExEL1JGM3RkajhvalFwMkM1T01ZWWJYVWtvQUE4?=
 =?utf-8?B?YW5jZ2VteW50RGk2KzdlVVFWNEJIQTRIc1czQjg5RjlDb0RnZzdDdmJaWDFp?=
 =?utf-8?B?L3l5cGo4MW51SGR0aEtseUNpYUtveWF2bCtKMGhNWHdtbEFkUlFSWHJnWFpY?=
 =?utf-8?B?RTlCMWYwYnRhTVNsdHhhRmFreUNBeUR4Yjc5aDZGQVo4SjFMcVk2aUNQUFFl?=
 =?utf-8?B?ZlRFclB2aW1nM0ZUV1IwYTJodzhsOVZMVXplWjUwaDd4ZjAzOEVzK3UyVEJF?=
 =?utf-8?B?OUNVOERtOElnM3FGV0cxeFBSdXRNcVRNN013MldCQWRwSUxjSllmNHkxbXZN?=
 =?utf-8?B?R2dwcmlCZVFYcm8ySGN4VU5VdzNRMW5weWttZVB0d1Ivb2h6TjdDUDk5MFds?=
 =?utf-8?B?ejV3ZkdVbE1SdG9GeXBlcENzN3dNNmQ2WHVEeTBYazFBMHBsbTNMS0I4ek40?=
 =?utf-8?B?N0pSbmNwdDRvZDJTMnlsa1J0YXFudkFYSVpDcVNjeW1hWnhlaWkwcWZpaUNr?=
 =?utf-8?B?Zk1pYVZvZTZUMmVpRHBBeEF3eG1FTFEvTFY0bUZGNjU3ckJHeWplTXJ1WXkv?=
 =?utf-8?B?NjlWbG1kci81Y0lCNXdaY3k5K3ZtaFJEN3QySm1uaXpxS212UTBxZThqMHZD?=
 =?utf-8?B?WnNMQjBFVG1Dd29UYXRTbVhoVHRrWlF0eEZKWlRaVEJYQ2ZQZVRFQWVSaHFn?=
 =?utf-8?B?SHRiQlYvbWxtU3RaZTJHdW91alVXVTZKV2dYMlUyOGVaQjZQcjlYQzRaMERv?=
 =?utf-8?B?NWhSSzZST2VDWk9yK25FS215cGtsS2JXcWE0NXphVzhGYVRFVlIxbjdFS3pS?=
 =?utf-8?B?Si9uSEg5dDVyMkx1TlkrZlFBa0h1SWVhOWpYbG9GOVl4bE8rNkkrb2pqTjZw?=
 =?utf-8?B?ellPMDZ0NWQ4QVJtb2MvTEduMjIyL09wcWZoTmI0VVgvUHNwdDlac3N5T3pv?=
 =?utf-8?B?VkE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9792cad7-32ea-4c32-82d3-08dd6c6a7add
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8582.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 13:31:14.3077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lGrddyekgyPYqNSgT3pCuIdotcQk3S/K2QIwSbx+fkRBgeYwgx6OQns6tssGaM7p5LyCkzr/LXGaHmMfScXZ/GvFdiC44DZBC7G9zM4Nqz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8962

On 3/26/2025 12:31 PM, Daniel Lezcano wrote:
> On 26/03/2025 10:57, Ghennadi Procopciuc wrote:
>> On 3/26/2025 11:19 AM, Daniel Lezcano wrote:
>>> On 26/03/2025 08:44, Ghennadi Procopciuc wrote:
>>>> On 3/25/2025 3:54 PM, Daniel Lezcano wrote:
>>>>> On 25/03/2025 14:21, Ghennadi Procopciuc wrote:
>>>>>> On 3/25/2025 2:51 PM, Daniel Lezcano wrote:
>>>>>> [ ... ]
>>>>>>>>>>>>> +static int __init nxp_stm_timer_probe(struct platform_device
>>>>>>>>>>>>> *pdev)
>>>>>>>>>>>>> +{
>>>>>>>>>>>>> +    struct device *dev = &pdev->dev;
>>>>>>>>>>>>> +    struct device_node *np = dev->of_node;
>>>>>>>>>>>>> +    struct stm_instances *stm_instances;
>>>>>>>>>>>>> +    const char *name = of_node_full_name(np);
>>>>>>>>>>>>> +    void __iomem *base;
>>>>>>>>>>>>> +    int irq, ret;
>>>>>>>>>>>>> +    struct clk *clk;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +    stm_instances =
>>>>>>>>>>>>> (typeof(stm_instances))of_device_get_match_data(dev);
>>>>>>>>>>>>> +    if (!stm_instances) {
>>>>>>>>>>>>> +        dev_err(dev, "No STM instances associated with a
>>>>>>>>>>>>> cpu");
>>>>>>>>>>>>> +        return -EINVAL;
>>>>>>>>>>>>> +    }
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +    base = devm_of_iomap(dev, np, 0, NULL);
>>>>>>>>>>>>> +    if (IS_ERR(base)) {
>>>>>>>>>>>>> +        dev_err(dev, "Failed to iomap %pOFn\n", np);
>>>>>>>>>>>>> +        return PTR_ERR(base);
>>>>>>>>>>>>> +    }
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +    irq = irq_of_parse_and_map(np, 0);
>>>>>>>>>>>>> +    if (irq <= 0) {
>>>>>>>>>>>>> +        dev_err(dev, "Failed to parse and map IRQ: %d\n",
>>>>>>>>>>>>> irq);
>>>>>>>>>>>>> +        return -EINVAL;
>>>>>>>>>>>>> +    }
>>>>>>>>>>>>
>>>>>>>>>>>>       From commit description:
>>>>>>>>>>>>
>>>>>>>>>>>>> The first probed STM is used as a clocksource, the second
>>>>>>>>>>>>> will be
>>>>>>>>>>>>> the
>>>>>>>>>>>>> broadcast timer and the rest are used as a clockevent with the
>>>>>>>>>>>>> affinity set to a CPU.
>>>>>>>>>>>>
>>>>>>>>>>>> Why is the interrupt mandatory when the node is probed as a
>>>>>>>>>>>> clocksource?
>>>>>>>>>>>
>>>>>>>>>>> It relies on the DT description and it does not hurt to have a
>>>>>>>>>>> consistent code path for clockevent / clocksource even if the
>>>>>>>>>>> interrupt
>>>>>>>>>>> is not requested for the clocksource later.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> If so, in my opinion, it would make sense to use the same STM
>>>>>>>>>> instance
>>>>>>>>>> for both the clocksource and broadcast clockevent, as both
>>>>>>>>>> functions
>>>>>>>>>> can
>>>>>>>>>> be accommodated within a single STM instance, which will help
>>>>>>>>>> reduce
>>>>>>>>>> the
>>>>>>>>>> number of STM instances used.
>>>>>>>>>
>>>>>>>>> The broadcast timer is stopped when it is unused which is the
>>>>>>>>> case for
>>>>>>>>> the s32 because there are no idle state powering down the local
>>>>>>>>> timers.
>>>>>>>>> They have to have be separated.
>>>>>>>>>
>>>>>>>>
>>>>>>>> This wouldn't be the case if the STM is kept running/counting
>>>>>>>> during
>>>>>>>> the
>>>>>>>> clock event setup, with only the clock event interrupt being
>>>>>>>> disabled
>>>>>>>> (CCR.CEN).
>>>>>>>
>>>>>>> Are you asking to use two different channels for the same STM
>>>>>>> instance,
>>>>>>> one for the clocksource and one for the clockevent ?
>>>>>>>
>>>>>>
>>>>>> I suggested using the CNT register to obtain the count for the clock
>>>>>> source, while using one of the STM channels for the clock event.
>>>>>
>>>>> Ah, ok.
>>>>>
>>>>> I think it is preferable to keep them separated to keep the code
>>>>> modular. Given the number of STM on the platform, it does not hurt
>>>>>
>>>>
>>>> The S32G2 and S32G3 are SoCs featuring a diverse set of cores. Linux is
>>>> expected to run on Cortex-A53 cores, while other software stacks will
>>>> operate on Cortex-M cores. The number of STM instances has been
>>>> sized to
>>>> include at most one instance per core. Allocating six instances (1
>>>> clock
>>>> source, 1 broadcast clock event, and 4 clock events for all A53 cores)
>>>> to Linux on the S32G2 leaves the M7 software stacks without adequate
>>>> STM
>>>> coverage.
>>>
>>> Given this description I'm wondering why one STM has to be used as a
>>> clocksource if the STM_07 is already a TS one. And also, we can get rid
>>> of the broadcast timer as there is no idle state forcing a switch to an
>>> always-on timer.
>>
>> Indeed, STM_07 can be used as a system clock source, but Linux should
>> not assume ownership of it.
>>
>>>
>>> IIUC, on the S32g2 there are 4 x Cortex-A53 and 3 x Cortex-M3, that
>>> means we need 7 timers.
>>>
>>> The system has 7 timers + a special one for timestamp.
>>>
>>> So if I follow the reasoning, the broadcast timer should not be used
>>> otherwise one cortex-M3 will end up without a timer.
>>>
>>
>> On the S32G2, there are eight STM timers and STM_TS. Therefore, there
>> should be enough instances to accommodate 4xA53 and 3xM7 cores.
>>
>>> That leads us to one clocksource for the first per CPU timer initialized
>>> or alternatively one STM instance == 1 clocksource and 1 clockevent
>>> which makes things simpler
>>>
>> I'm not sure I understood the entire description. As I see it, two STM
>> instances should be used to accommodate one clock source, a broadcast
>> clock event, and four clock events—one per core.
> 
> What I meant is to do something simpler:
> 
> -----------------
> 
> cat /proc/interrupts
> 
>  16:       7891          0          0          0    GICv3  56 Level
> stm@4011c000
>  17:          0       5326          0          0    GICv3  57 Level
> stm@40120000
>  18:          3          0      16668          0    GICv3  58 Level
> stm@40124000
>  19:          0          0          0       5152    GICv3  59 Level
> stm@40128000
> 
> ------------------
> 
> cat /sys/devices/system/clockevents/clockevent*/current_device
> 
> stm@4011c000
> stm@40120000
> stm@40124000
> stm@40128000
> 
> ------------------
> 
> cat /sys/devices/system/clocksource/clocksource0/available_clocksource
> 
> stm@4011c000 stm@40120000 stm@40124000 stm@40128000 arch_sys_counter
> 
> 
> 
> On the S32G2: 4 STM instances used for one clocksource and one clockevent
> 
> On the S32G3: 8 STM instances used for one clocksource and one clockevent
> 
> 
> Specific broadcast timer is not needed as the s32g system.
> 
> 
> The resulting timer driver code is much simpler.
> 

Okay, it makes sense from a complexity standpoint, even though it
doubles the number of STM modules used, while keeping the required
number of STM modules aligned with the number of cores.

> 
>> E.g.
>> STM_0
>>     - clocksource (based on CNT)
>>     - broadcast clock event (channel 0)
>>
>> STM_1
>>     - Cortex-A53 0 (channel 0)
>>     - Cortex-A53 1 (channel 1)
>>     - Cortex-A53 2 (channel 2)
>>     - Cortex-A53 3 (channel 3)
>>
> 
> 



-- 
Regards,
Ghennadi


