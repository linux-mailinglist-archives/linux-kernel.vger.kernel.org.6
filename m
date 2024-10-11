Return-Path: <linux-kernel+bounces-360295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF8699982D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 02:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5CDA1F23D8A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 00:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86B41FC8;
	Fri, 11 Oct 2024 00:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qYToBomO"
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2093.outbound.protection.outlook.com [40.92.102.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224EA4A1A;
	Fri, 11 Oct 2024 00:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728607331; cv=fail; b=JibV4pAMEbPFbjW1V+tgbag2/QOFP3lUR7GTdJdtkOSDIyKB+5RTZ6k47IwZo0EZpVAKpPDELCKPQlhDDtCejVf8bDwjVMatektP3wUzOfGPc9qGZaFzMQbHSvopoWlgfzK7H4lnQlMyR7uxUyaUvxLHkcP6QLUM0YrL9eR1oUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728607331; c=relaxed/simple;
	bh=K0OwXa4K3BWbZbncnD0epwTw4bre62lZXgMlKr4Lzlk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hkfHUCiX+sUXgj/Y6u9Bkl0SARJwKUzzoI5+8NcnVic59tmXTjvIiS0NLD3b5cI0Ij/vC8pCwgwGTdKKhLpCFyf7aS+Amne7yLDsJbrWr2G3Dv/ghH8Fh6JuGFvuiwg7o9mr+bEa1wwQSPc/+bJQaZWNRef+1nwUct8IVwWykEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qYToBomO; arc=fail smtp.client-ip=40.92.102.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qW0fcteNPyji0zwnleyzK+JUeXEOqr/EyEXhOcfUFwNMt9/Fy8OTOURIpzpexVSRbXoXwU+heqfS4sPgrgYmq1v84fY7Rxh4+QqHLeGimB3GuCOUb701Zyciscm4UhGAxMPS8MwnqszscIZNUbh/AvVzLsmxI/QJx84nCazIiPwR0k+MFABhm/QYOSjuBZ/PSkyJj2cc44CtMCh23x9DHtXnP4BwrZM2TpXqyLwYZQwG4PIQQEtKxPVb3ac568FIF85NSXJdDzuka6RMoae/2UcxtkaUk7rpt4U/PAvUDD34J6fR4cY6CWEoSgR1Zt84aPx6ioo8jZLQ4afoE/lRaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PILh1GDsDtbXQ0u04D2di982i2eg/il7n2NPMb8tppY=;
 b=TlU/Ov+uSwXdDUdN1wipXRWCSWLTMZ8IBsq8xPUKfrws3Z+8xcLFPXnWrSGJHKUEVzkYkWUMsFei56rsT85fvQd6qyqkRqGtDaNXXVfus63z2cAjRzRq+j3LLLR7z1LCjnNuMfiu05PxBBewmGvnebkNYPOXWfuxeJzPFVbCrPQkOoe4pB5X7wRt7l/J96OHQ0s4A/vpMjBoZTneaTJOjFk5ejWP2oB7Zs0g+UlW6HoMoGDpoETNPeUcT9gpd+M5eSCxuBxP6SUW9qH1k5MPb/7AelfzuqoXw/lfcewfYWN1QMdNR0drQY4iycbSFHOd5MxuANH4wQmKTzsydoFIKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PILh1GDsDtbXQ0u04D2di982i2eg/il7n2NPMb8tppY=;
 b=qYToBomOAIjsedQRPoeBX1tB3zNB7SQoQOYdYBBrNUcD8CUfg4sZb9dBZH6WS+7uiGDgqcaOyxjgb58fH06U0s0KA5iyrdSfgW9mqGsDVYOF6g59VmVLh6KCdtnsWcZ1586t17SSFea5vXvVZM2C/2cCiR79H8OmkMtr3X5ZEpKd2hln3fb3FWfdxCzjH4CMuLADtf29afcLs4qi9WYv07bhzlIsI0sPM99LrQiqmZChMcgLHWT+3vt/rx+6c96MO65eTXXQXcK1aFT83BZWhvWqIYzLfMK1e/m3ya7lfaoQMWTv39r9uMH0iF2xxUq6Rjr56RAjxAVA7AM/Mu3Tzw==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN2P287MB0381.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:f1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 00:42:01 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%3]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 00:42:01 +0000
Message-ID:
 <MA0P287MB28220483221F62EBA640035AFE792@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Fri, 11 Oct 2024 08:41:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] riscv: dts: sophgo: Add initial SG2002 SoC device
 tree
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Inochi Amaoto <inochiama@outlook.com>, Chao Wei <chao.wei@sophgo.com>,
 Conor Dooley <conor@kernel.org>
References: <20241010-sg2002-v5-0-a0f2e582b932@bootlin.com>
 <20241010-sg2002-v5-1-a0f2e582b932@bootlin.com>
 <d7b32bed-2078-4f5b-80c6-681b7d67302a@bootlin.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <d7b32bed-2078-4f5b-80c6-681b7d67302a@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0050.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::19)
 To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <66f7d5fb-4193-4eda-8e93-494aa002a122@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN2P287MB0381:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ef3334a-8aba-4c1b-9257-08dce98d84ac
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|7092599003|15080799006|6090799003|461199028|5072599009|19110799003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	jpQEPNansPD1E6Y9xm2/9GxvKXcsfPAQMgHI6Pv7h3MANHaHiBTsgLcopjQqlhtHOx32lQcWVjxqRVH2i8IwVBXSCPJEEyTkbneBuqjMJouSM3Kd0WdHLfQNIypI71qi+FgK3aoHa7eukAybjIMxKuFpLXMJXtYfL29H6jyLYe+VNM81W5Hm1YTqnyunSPlMyyj0t88u4hsW6l7jYR2DoTNBlufsPhKoHnh7GSeXD7A2RHqPx6BE5hxfZwlQKkxME7VBXb5ebeJwEF8ydgxrJpIOn8em0LAdURwNnatk/HKzRALQt7boFa9W75UkMqguqKmB2FoPX1/QC8JRj8n4vy23qbY52cvA/5EhOy5MQ22JM5qFjf0x/6xl/dss6bFyPpR9I/ddi9ETiVDLt+k1qZhSzDRxEJNuaiwZ8f1NNfW7/cPsEWZ7PdBPX48g8ygH9zIOClH8LuLwtBKt6CZSSof0wjeRnTK+89QF9e77tN7JtFZw1j1mutlS9W+8EvDSIWbfz6J8nW/bqFgENw4SSzAJoJk5WUeMRzSOp/F2GeDxg0lOFwrIYLVRYzzEDUCOGSaQxHUQBvdRtDq00mIcl749cSlq8WlEoJoCZhFqE87lT7YHqxwUvkz//xvIjTvrL5Pm4JZjq1YGuf0JLxMDj0Pf+oUvIfIAizJVJ7qN6USJCaBtlmkeSRTNAlj0O3TN1TzsefwNzgyVCeKpf+1Ycx1fpAU1iU7Bo9z5H13UHuzwgppfPF8+aA05FjMsCtXzIVs0oomhCHw2GozK5ZU50Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bklYOWxyME8zYWlFQkxmdWxvSkZuSVMrU1FqOGdQbGV0c09Nc0JWOWREZ21T?=
 =?utf-8?B?Tmx2QnUxQlYvR012cGoyR2lhbnVBelorWmVYMGJSKytncGpnMnIvellSYWhx?=
 =?utf-8?B?RlQvSlpYZTdqcUN5ZXpBV1V2c1FrTmN1NEw5UEhKazdpQmttMkFaNGtCbmMr?=
 =?utf-8?B?WWZXeHkzWGpha0FzNUI2dXJWL093UjI1YmVreS9IMnNBOElTUmluT2VmVDNY?=
 =?utf-8?B?SURKYVhJWlJqOE8vaEpRaHlNR3E2Ym9MV3c1YkF4bEVJdDJ3djB0a2hrb2s0?=
 =?utf-8?B?NWVVZ0xabjROTERMb3dTMUV1ZnhNKy83SzZyZ1IxTnlpdFo1bm1NUzZNUVdp?=
 =?utf-8?B?dXV3LysxRjZDbnpBTThOK1BsQXRJUUJ5OHZsUlhyblBjaUs4QlFZdFBuUEpC?=
 =?utf-8?B?bHRFb1ZvSzF2SnZRc2VPV2lMM3Btc1N6NHZiNi9wUHg5dWNtRXRyUEMxbUV2?=
 =?utf-8?B?K3FycG1FT0FTUTJRMTJlaFUvcThQc1hNRmtPcm9mVGxRZXJEUHIxWnlXVEFQ?=
 =?utf-8?B?UEZLbGc4K1FwU2ZORnA1eUd0N2t0NjcxMTlQNjlsOFRqamtmaEM5dE11ZElW?=
 =?utf-8?B?aGJYeHo4Z0VNaUFVbTdIbyt4eVJIdFh6S25CV1ZONEZQZG8zcDRZUk1IMG54?=
 =?utf-8?B?YkVVMDNlei9UTTAzL3pMVW1pb2o0bkZYNkltQmRCOStpMEdLZjN2U3NLRmdX?=
 =?utf-8?B?Y1NyRDhycHRBaWtKTXRSeGR1ckxxbmpmUlFDQlMydzRobnRiK3doR1ZROCtv?=
 =?utf-8?B?V2UrbjM5YnB3ZGNqQ0YzUVVTNkszOE5KQVBKQUxaRlZzVmdkd3NKbk5qQU1m?=
 =?utf-8?B?c0tPbUgxeFdHTDVjN2JoejNYUWNRZks1ZlBPL0FRTW15R3ZSVWl4cXJlcFRV?=
 =?utf-8?B?dFVBSEhWUTRPS0s5d0VYZzM1WTdIcUs3T0tSWHorRUJYZEFpMDR2TXJpRmts?=
 =?utf-8?B?dG9qS0VOMjlUV3hZY01wbzVjOU9kZTkrV3BJbEJmSzMyWEpTYXpyT2JMQXZt?=
 =?utf-8?B?dUt2aC9WRDdKZUZuNk51MlRRaHFmdTk5Q2U2WjM3TU44Y0MyM2NzdDFNK1Nk?=
 =?utf-8?B?cWxIMWtmekRGdkRveEdiVG5HbmJFWTk0NWNpV21OS1dUMWRVaXhaZEw0anUr?=
 =?utf-8?B?dzFFUmJnUS9BbVJPNTBoUjlQMWZZSld1QU1BMUx5UGphdnlGTzNaRXhXakxG?=
 =?utf-8?B?Q3NZd0Z0VlBVVkpXY2t5bWZLb1UwWUM5VGRBUXBTMzlHdFlrVjlDWHBuVjBJ?=
 =?utf-8?B?V0NQQUFGdXR5bHBWYytSblVZY083NUtpSEJmZi9SbEwwVVoxYXFLejBURDlC?=
 =?utf-8?B?R1NFcmZTWmhYZG41ZWhJYnYrL0JDbWNVYVpPSkdGMFNRc1B1SU1iQ3JxTndM?=
 =?utf-8?B?a3VuQk9LQ0pibDRMZjgzWVd3OHZGR054N3k2MWV1aXZtZUVuK0R5R0ZPWmxY?=
 =?utf-8?B?T211aUUrWWtETUN2UHZoeVI3dzZyNktGRTBOTlBSWkVnZGZNRTZpeDFRa09V?=
 =?utf-8?B?Z1VjbXhxUG5FTU9GdkRxbGdiRDcrQnd6TnZsSWhMOU15WFFPZDNPT2F6U0t2?=
 =?utf-8?B?RFVEUmM2TVRhdXJLTTBnTmRQQzNqaU0xM1lPWGtyZ2VJQS9LSFBFSFVUcWFq?=
 =?utf-8?B?SkhmY1V0RFMzU2M5MDF4MUJOMlI3REg1RFNXUFhVNDczeUtPNFQ2Qnk5Rjdp?=
 =?utf-8?Q?IoNL+2RF2/IHjzYdb1x2?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef3334a-8aba-4c1b-9257-08dce98d84ac
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 00:42:00.9424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0381


On 2024/10/10 23:23, Thomas Bonnefille wrote:
> Hello, sorry for the double email.
>
> On 10/10/24 5:07 PM, Thomas Bonnefille wrote:
>> Add initial device tree for the SG2002 RISC-V SoC by SOPHGO.
>>
>> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
>> ---
>> The commit adding the bindings for the compatible "sophgo,sg2002-clint"
>> has been applied to Daniel Lezcano git tree. This commit may trigger the
>> bots because of this missing binding.
>> ---
>
> I wanted to say, that the comment above is no longer relevant because 
> Daniel Lezcano's branch was applied in 6.11.

OK, I will remove it when PR this patch.

Thanks,

Chen

>
> Best regards,
> Thomas

