Return-Path: <linux-kernel+bounces-524653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8171EA3E575
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9086B1887395
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BE61F4E47;
	Thu, 20 Feb 2025 20:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ESpDN/FL"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2108.outbound.protection.outlook.com [40.107.101.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7BE2E630
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 20:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740081695; cv=fail; b=fjbyO7eG2u1eQbUwM3UbKJ9ZaczJZ27pcGSBNz5C7lUmXcNKhZyejL/fntJq/PAEz3WpLD2RMPBmV2y8bKBdnoxFQHwr56S5Av7dZ9/j1/tP8HISzL88wcS/3jPlI6P8Hfe9E2LdXT1QS0OBZYUslz0dfKjnT6tS1JjDvU2xfJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740081695; c=relaxed/simple;
	bh=H15Dq/Uol1nYu3bAFmxM/jP1pcnHJhCKvx1jZkwRQJE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JI0OfAGBQUq2SJ1sw7Et7yUJ5cDvhHnMvnk+AwLE+hH1cyrhBJJRbOZfiJJ0E2xnr1vChm3UAoGNAOzZdft+gUEwIEW+qXuKsvxapwEl5o/K7n2hWXvdbDkSGJ0rffadm2T/UN5E+RLXmFm4i7qoNp5azHHdjDdHemVm6chqgd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ESpDN/FL; arc=fail smtp.client-ip=40.107.101.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdsLXoiNNVuk1wdmXv32rltQ88eT9bOmR08B8mTTPRVLLUZqq+y43Jc8SGAj7nT1vsA3HOR58zTeoxEM9V7wy1FQIqUNFDcxU3+PdctIh6T2D0R74sd+c4xzXjdGONRLfUmNKt+MkF/t3ty4nzefy2Xf9tD3h5vrsNZRgWSH6Z5Hy4xQj+b8YktH1jURlZN+GBukzq4r/Ctp92c538HjZ/hyY1bOnVZvZr9Q4tH/oI2uw7nXnarGMdZVnX7Mx1id+FlR7UBS3d7+rr6YpzReJFFnUAVxMqr6e+q+8gjyKNa1xoP9lhzslr1DSIsVPEcCIc5HV6p/8Q4lmsr/nya49Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sI1gR3spo3TFzwxxCQyUKSy8XBjmyQfBqskBvsvsoQ4=;
 b=EUDGsEd36Raw05TsttTCih+yAB3Iu8g6fIlmihcBKc9wWz0WU7hldbMH2+ciFVzgPrAZUs+W0SFgEQ6yirzgPzwTF5YnFzblD2YNseQ9pYozgtVuHQGKoUfhCgq5a/Auznq86rTb1oHG8sewAUbe5lnlkieY8Bq+iMc7K0WgJIozZxwC4xFfpC5bjnKXGYC0g+K8qY1sFT6UwKaoO0xu0r4FX3QSTO6TOni7Mba2LP3DAYBA+Nd6eJvtfmiurEAsNWtOr8ykDFF4B9a2q6+LcWJco1MrW8zHJ6L5ul18PlU5v/EUG+vY4ovllww1dkZaRsSTjwJ0xJ4LFpWpf8N0SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sI1gR3spo3TFzwxxCQyUKSy8XBjmyQfBqskBvsvsoQ4=;
 b=ESpDN/FLW5uDc2DGMPo9FEKDs/05z7EYvBpnPfH4HKfgzyeR3U+Sjf1Xf2Ui/dgZqKJndZw31ABb1ODsBxOkBfL1Jz8AQQlNYlrf5m0EvmO/ZbxxXBbWHCFEA4PEz4sIfls+HrJPPvO/EUXoMzJll6WWr/rjjTtRWD22X+aCj8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 MW6PR01MB8318.prod.exchangelabs.com (2603:10b6:303:23c::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.14; Thu, 20 Feb 2025 20:01:29 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%6]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 20:01:29 +0000
Message-ID: <ac84727f-0f81-4e63-a822-3fbc2d30eada@os.amperecomputing.com>
Date: Thu, 20 Feb 2025 12:01:25 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] arm64: Add BBM Level 2 cpu feature
To: =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>
Cc: ryan.roberts@arm.com, catalin.marinas@arm.com, will@kernel.org,
 joey.gouly@arm.com, broonie@kernel.org, mark.rutland@arm.com,
 james.morse@arm.com, yangyicong@hisilicon.com, robin.murphy@arm.com,
 anshuman.khandual@arm.com, maz@kernel.org, liaochang1@huawei.com,
 akpm@linux-foundation.org, david@redhat.com, baohua@kernel.org,
 ioworker0@gmail.com, oliver.upton@linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250219143837.44277-3-miko.lenczewski@arm.com>
 <20250219143837.44277-5-miko.lenczewski@arm.com>
 <bfe7fc8e-b22b-4ff6-92c1-7444a0d6c5c2@os.amperecomputing.com>
 <20250220103420.GC11745@mazurka.cambridge.arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20250220103420.GC11745@mazurka.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5P221CA0066.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:930:4::43) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|MW6PR01MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c5e5103-b86c-4347-88af-08dd51e95d33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTdXaVNCSEJ1eVpLeEdLVTY4SGw3aWlLUXlDdU5zRnM3aGVGQVhhRVlXMlZU?=
 =?utf-8?B?Q1lsMW1Ld0hwMlVWa3BEckk2OS93ZGVaTTlKdUVzM1NUZm5Tb244WkhWdnhw?=
 =?utf-8?B?a3QyZmtxdnhzdEtBT2ZYdlhvSGJVT2xwbWduclptV1V1TFp2MGhMMW5jQWdS?=
 =?utf-8?B?TXNQdkc5SnFJUHZlWXBjSzd1SHR3VlpyVXhadm9sQnJJeGE0NXNnbnEwVVVT?=
 =?utf-8?B?c09kYVJ6ek1qTUxlZDgxS1plTGltTGxBVURXZEYrSFlTaUhjdi9BWkQ1VkZD?=
 =?utf-8?B?eXVGeWQvSHlaUm9sOXc4bWZDU2dRQnhXaEZWd0NDMTRSSmMxNUVJcHFSd1hz?=
 =?utf-8?B?UzN5RUpJYStJNmU0eWtsN1lKbTUzTTgwandUdmpJbUMrTjhiOHZ6RmxPNnR5?=
 =?utf-8?B?VXVTYUtKWkpqMjFWOGd4WkhHc0Zyd0dYeU5HUXN0UjdjRUpnOEFmQ2xEM1Nx?=
 =?utf-8?B?Tjd3b0VzcjR6VkRrWHdMbVBTb09CTmNTK3J6dFBOTlpXOGtSdGpVUGFQbEZQ?=
 =?utf-8?B?VkhjcEtjQTRQcDl5dFh4MDQydmoyRUZSejIzTDQ1SWU3cDNPVDBrVDFoM2Zy?=
 =?utf-8?B?K2c0a005U0ZIVHpzdlI4M1Njb2FyelRFeXBoZnVxL2MxVVNZeVpVVUZ5ZWFw?=
 =?utf-8?B?NC9sSzE0WlRHRGVGNVgyZWlnMXQ0dTk3UklxanFuOXEvNnFNZ3N4bUc1UWFn?=
 =?utf-8?B?TndmNWR2SW94UURKM3hDemZJSDhwcFFKTDRsc1JCSmk5cE50UjY2YzNZa2dC?=
 =?utf-8?B?VjlOVnJaOTA2aTFkM2hnYkFMZEZFbU9kdm1NZ2M1NVFTTHR5MGxpWEhWU3hL?=
 =?utf-8?B?ZUNQQmQ1TWlFbnNXQStZQy9IRWRpbTA2Wmt6TDdYREFpQnJ0OHh4L0tRMHow?=
 =?utf-8?B?WFFlVWFZS2dONndWcFp1SU93WGo3Y2t0WTdka09IYTJpU3UrZExYZ09mdCto?=
 =?utf-8?B?QWJMMkwweEVFc1RPdEFweVgzaTk2Y2JnSysxMW9zMXpGem5FU0phNHJtRk9F?=
 =?utf-8?B?L0hVbnNnSHNKK0tQeHVPOGNqRG9oZmFKMTJCNjNuazZtL1hyaS9pNGJKMlBD?=
 =?utf-8?B?TUtLR1RKdHpFOEV5RG01NUNwYktMZHJjcHZla08zdEpybnBuRWQzOWNWejdB?=
 =?utf-8?B?bEgzemlSUmFTUnIwYU0wcmwvOTd3T3ZPeEhMYXRUL3NiaTNBOTRaZVpsRFRN?=
 =?utf-8?B?UW9XaXg5Nkh5amQ0NzIrSlJLOFhncGJCcHI3aGVjSGt2ZEFMblQxQjRaaHdK?=
 =?utf-8?B?NW5XMTFpT0xxd2FBQnRXVGkvdHdhWGpmSW5PeHNDNTFUSTlucU00bFk0YWdL?=
 =?utf-8?B?OUlSUU1zQW5udmVYUGZFeHl1SFByUXZvNzZlYXZIaUkzL3pWbEd1SkVXUFln?=
 =?utf-8?B?RHhnSStSeEQ2K0kzZEpyeWRSWmY1U3QrVmpNaFVhRWhUby9CTVl3ZW1PRG9B?=
 =?utf-8?B?czhYalVWM3FlTGQwZldDOWIvZjB1ZGlNN05kWEkweFZhNm8zbUZ6dU4wZ29L?=
 =?utf-8?B?RXJreGVXbDkvaDFSRHN0WktiSGVhWEl2UFlDTEc1RDAyWkpsVnBLVmRJMG52?=
 =?utf-8?B?aXpNdXBlZk14QW1Mek1PaG1KOHhqRUxvZmZ5TWNIZGFUQjFCZlNsRFZTOGFa?=
 =?utf-8?B?MjRJaVZXRmxsaGJhaWc2akR2alZVazFEZFBvNGVoaEhoQzBRR3pqRkthekZR?=
 =?utf-8?B?bC9IV0RwTnR1djlEcjY2dm5VVXBSbWFTbmMzcVRQUmc2cFRPdC9CMDRIbnlt?=
 =?utf-8?B?SmYrUG1hS2JBVmtjeUtpK3ozeVJKM0tIUUV2MzgwaGV2aWhMaWdzZGp1ZFBP?=
 =?utf-8?B?TGpyaXpBOGUvTWtSbThsaDNPYk1nUXh4OTJkMVRqbnZjZXVVbDV5NXhGeldX?=
 =?utf-8?Q?ZD0sSzQTGJLGg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHl4eHdyaHg0Qjh1K1FMTU8vQmluTk03L1RWSGRSRXBhaTdhZEZtaXhqWENS?=
 =?utf-8?B?UXI1M0s1WlgxUmJJazVuUXA1aVFUb3VYb05tallmZHczb3lXZGFLTDZFS0dZ?=
 =?utf-8?B?YndpcmxKZHVueUtPRDhyY1pNeURFWVNnT20vSnZWODJWVWlnNStVRmpZb3Nx?=
 =?utf-8?B?T1NJRzlWbjFYUEdVTUhyTVRNNVpVSDZZTVJzSXVqVytiNHJEQXAvdkZCbTFY?=
 =?utf-8?B?SkJROWRUaTU5eWRWT0tISDQwRVh3VndBYW1jUHNYbkR6VnUwVFBaMzBLZGxK?=
 =?utf-8?B?MW1qb1pTbThRMUx3MVdsMHJZbnJ3Y1dhWC9tTzFmcHQ3djFOZGVQeU5OVXRT?=
 =?utf-8?B?SkRoM2hzT0NSa0liNmRISkpyMWFSZjRnZmJOOU40V1B0QldHSjlLaGJQdVcz?=
 =?utf-8?B?SDNGT0VDU2Z4cGYyT2M0NGdDRlVQWXc1WGRtVkFwN2J4RG8ybjdCSVN3RE05?=
 =?utf-8?B?WHh3SmVyVVpNVEFEb3NIcjVQdlczaWdpQThaMk93cHVYaXA0MExGNEdXNnFK?=
 =?utf-8?B?SU9IeGNZc3JQUktCQkI2NjI4cDRIa2tVZHJUR2lWUFJPQkxqenFIU1p4R3Nw?=
 =?utf-8?B?eFZIVEkwaG5nK3NmdW5FVXdwR28vc0JjME1HTkkvRzYxUWhyZnZOVFY4RjBz?=
 =?utf-8?B?d29YaU1rb2JQTVcwTU10TnZpMVR3cWllMDdPZ0dsVEIxWlZ3N2VnYXJGa2xH?=
 =?utf-8?B?WEpoK0k0cXl2YUk0MnB3NGVENWFQSk9iMmJ2Y1o5RGVuWkhLUWFnRjkwR3BJ?=
 =?utf-8?B?R1dKald2aEI4RGV4NVVNZVF0RjBEeFRvQlFYaTFYYXRRalZ4NjBGMWZaYWJM?=
 =?utf-8?B?NDNIK21DMTBGSFVYYThneVVNQkVKeit1OWFSOWI1N2tUVENZMGdKQzZyb0RG?=
 =?utf-8?B?emxGMmxhanVkQ24yakplbVNtNFBscklQZ2cyTmdxWFV1RkpLS3N2eWwycnBX?=
 =?utf-8?B?RFVWL3VubTI0RDNsTWZ5SUE4MGtWbzlNdS9TK0JvTGp1YXBrTDRDUFN5RDcx?=
 =?utf-8?B?WWdRVnBmRlNmaFZ4dUZlTmxGNXFyYjlJcHA5YkUweGhGZ29aOHZKNUg5UTFM?=
 =?utf-8?B?ekxqK0hFL3Q4cm10Yzk3WG5rQTZ3TW51eFpvcXp3Z0l3QkVLZm8rZWhhT3cx?=
 =?utf-8?B?dW1xQ2MzL3RzSEwzdUJHK0RIQVdvRHJhQ3hNTnhUVmpvZ2JEczRYWWlnelhI?=
 =?utf-8?B?b2JlRmp5dncvVW43VkEvS1BTcXZZN29EaU1INjM3UC8rellrc3FaNXBJUnEy?=
 =?utf-8?B?VUtnTEdVZGpnNnE4WlF4eWpERlFmSFNZQjE5ZTRYZFpNWFFISzBhcDMvK2Er?=
 =?utf-8?B?a2FzSUpzSk1McXd3bkJTeWh2NUtPQmE4Zkp0MHp5aWtwNzZNNzNrOWl5OHN4?=
 =?utf-8?B?Q291U1puYjdOQjU4bG0raWN6MUJyTDRyekhEeVZSRFpXMkpFeUxIOHNPZWFh?=
 =?utf-8?B?STROU0cvNW5IOWk1QnBSV3B4aDhqSkdUQ3dNVlJ6WkpqRDJzR0VvTW5hNVNO?=
 =?utf-8?B?LzI5ZDM1OFNlTEYyVmJFWkprckVKbG41bTNwbVVWa0hPdkxmSERqYVN2c0VN?=
 =?utf-8?B?cVhycUZPaFhlbGlGU1hkdDRkaFM0eC9iZGpkR2ZzYXQ3U0MxbnBta3VCZXdi?=
 =?utf-8?B?NzdvckRBVTFKKzd3U2YyV0ZJancwZWlWNXFnWlh2Y0ZTVm0zdWlhaytRckFT?=
 =?utf-8?B?NUFrVnF1TU1xNXR3dDBqdGozUzJjOFZ3cTdrcDZWNVVrNmpXSFlTYXNwdGhl?=
 =?utf-8?B?T2VvVWFHOG5leWZSL3FKci9DcWNybW1vcWRLc0JIdmdMSWtNQzE2ZURjM0Jx?=
 =?utf-8?B?bkxoMTZ6ellPZ25rMkJzSlVKbHp3WnBvVU5xM1FpemQvZXg5UFI1V2MwejVs?=
 =?utf-8?B?M1hXZFB0Wi8xaTAzMDFlbjlxYnoxV205emcxK2FiSzNienFkS2FKcmpHOXJD?=
 =?utf-8?B?VkhmMEwzcm1oS1U1V2tvbnBCMndxZGpkekN0K1dIRkpwN0k0THpmL0tCemxR?=
 =?utf-8?B?TGtDYnM4Z2cxNCtMeUNFeEVEb3BjTDd3QXc0cGkzZW5uc2gvQnNENlJ2UXNZ?=
 =?utf-8?B?TTc0YUtVMjhFclBDdXFLKy9qV1Z5R003Y0wxUzhsK1hVcWZQZ1duQVVjUGJB?=
 =?utf-8?B?WmtOL3JycGxLRW9qUVVQUTFrTGRwWk43N1Q4OTBTUytBa0thUU5wWlZjYi9B?=
 =?utf-8?Q?TJH/FTQyoL9hbBRN9h1BY18=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5e5103-b86c-4347-88af-08dd51e95d33
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 20:01:29.2773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9SdVMzONv+QDbCFFUpElkgI9wFuCf022LyBv+GzOf46Au5kFsAJbvmuZUur9WX2mc+ecWz3UhNFjCYVXkuf77hPQ2lplou/6HPQ79VOaoBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR01MB8318




On 2/20/25 2:34 AM, Mikołaj Lenczewski wrote:
> On Wed, Feb 19, 2025 at 05:25:00PM -0800, Yang Shi wrote:
>>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>>> index d561cf3b8ac7..8c337bd95ef7 100644
>>> --- a/arch/arm64/kernel/cpufeature.c
>>> +++ b/arch/arm64/kernel/cpufeature.c
>>> @@ -2176,6 +2176,31 @@ static bool hvhe_possible(const struct arm64_cpu_capabilities *entry,
>>>    	return arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_HVHE);
>>>    }
>>>    
>>> +static bool has_bbml2_noconflict(const struct arm64_cpu_capabilities *entry,
>>> +				 int scope)
>>> +{
>>> +	if (!IS_ENABLED(CONFIG_ARM64_ENABLE_BBML2))
>>> +		return false;
>>> +
>>> +	/* We want to allow usage of bbml2 in as wide a range of kernel contexts
>>> +	 * as possible. This list is therefore an allow-list of known-good
>>> +	 * implementations that both support bbml2 and additionally, fulfil the
>>> +	 * extra constraint of never generating TLB conflict aborts when using
>>> +	 * the relaxed bbml2 semantics (such aborts make use of bbml2 in certain
>>> +	 * kernel contexts difficult to prove safe against recursive aborts).
>>> +	 */
>>> +	static const struct midr_range supports_bbml2_without_abort_list[] = {
>>> +		MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
>>> +		MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
>>> +		{}
>>> +	};
>>> +
>>> +	if (!is_midr_in_range_list(read_cpuid_id(), supports_bbml2_without_abort_list))
>>> +		return false;
>>> +
>>> +	return true;
>>> +}
>> Hi Miko,
>>
>> Thanks for cc'ing me this series. I and Ryan discussed about how to
>> advertise BBML2 properly in my thread
>> (https://lore.kernel.org/linux-arm-kernel/4c44cf6e-98de-47bb-b430-2b1331114904@os.amperecomputing.com/).
>> IIUC, this may not work as expected.
>>
>> The boot cpu initializes the boot_cpu_data, then the secondary cpus need
>> to update it, the "sanitized" register value will be generated. For
>> example, TLB range capability is determined by ISAR0_EL1. If all the
>> cpus have this feature, the "sanitized" register value will show true
>> otherwise it will show false.
>>
>> BBML2 can be determined by MMFR2_EL1. If we can rely on it then system
>> feature does work. But the problem is some implementations may have
>> MMFR2_EL1 set, but they may not be able to handle TLB conflict. We can't
>> rely on it solely so we check MIDR in .matches callback instead of
>> MMFR2_EL1. But system feature .matches callback is just called once on
>> boot CPU because it is supposed to read the sanitized register value. So
>> you actually just checked the MIDR on boot CPU in .matches callback if I
>> read the code correctly.
>>
>> I'm not quite familiar with cpufeature details, if I'm wrong please feel
>> free to correct me.
>>
>> Yang
> Hi Yang,
>
> Thank you for taking the time to review this patch series.
>
> Thank you also for the spot. I am very much not an expert on
> cpufeatures, but I think you are correct. IIUC, currently the .matches
> check would go through as long as the the boot CPU executing the
> .matches function has the correct MIDR value, and as long as
> CONFIG_ARM64_ENABLE_BBML2 is set.
>
> If, as you point out, another CPU has a MIDR that is not on this list
> and which was not checked (because .matches only executes on a single
> boot CPU), then .matches should still go through (and we could run into
> problems when said other CPU executes any BBML2 aware code).
>
> Please let me know if I have understood what you are saying correctly.

Yes, that is exactly what I meant.

>
>  From re-reading `include/asm/cpufeature.h`, making it a SCOPE_LOCAL_CPU
> feature seems to be close to what we want. We want to have each CPU test
> its cpuid against the allowed MIDR list, and the feature overall to
> only be considered present if *all* boot cpus returned true (not as
> SCOPE_LOCAL_CPU puts it "... detect if at least one matches.").

Yeah, LOCAL_CPU feature may work, but I'm not sure whether it can 
satisfy this usecase in the current shape.

>
> I will see if this can be hacked around with the current system, and if
> not, we might have to extend the current cpucaps scopes / machinery like
> you suggest in your patch series comments.

Thank you for looking into it.

Yang

>


