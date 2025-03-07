Return-Path: <linux-kernel+bounces-550323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D261CA55DF3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 03:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30244189042B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0DD18C337;
	Fri,  7 Mar 2025 02:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="AI/5VSMX"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021123.outbound.protection.outlook.com [52.101.129.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B6C7E9;
	Fri,  7 Mar 2025 02:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741316329; cv=fail; b=HKMr4zh60S/VLiMrTDMuPeNXTxbEEOuv2F9fswe8T4vLq5gANI5jYBwavjlj+UGCAmqhbrhVGHtBY0nj/IdFVvfrDn7ExK+egl1ax3iVBBKFE/uW6sqmehBZ5SOPYY9sTuUEnbEo1VEhEknteSGlS/SlCar5FZFjCTWh1yLGS+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741316329; c=relaxed/simple;
	bh=uYaFhZQdxai1qYb0v2sGPscnB5uBT+tqMO7TuKnf9JU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gStYAjUZghjSEQcuzMfWRObGTIpY2Hck2d298Oexg4/yrE7XCldf6eddTTGTMHR9Qor8x9JxcFzV4ffQkDLutSmQj50zmmcDYPNWkNLidTXfyPOWLKMGLBCZ8nq4UfPDWRtaPHP8PvFd17OnBR3mJX88XAI1jUvqBB1y3omYQ/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=AI/5VSMX; arc=fail smtp.client-ip=52.101.129.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUywqKx+jbFzTbn97EuiFqFTiNQVV+i5z+tuaq2feJTXg67fdv42qymA3YFYEmm2sK2YoKrRQ5VYiShkdb7fDUzfw/D8u/GMpX+wIPMEaZZnmTfyxjYZyfuWJsuzO/aZziyP3FAAV9ER50nEiG4yU1imwEPs5DtcomIbAPBU4HQP2i+tz14N7lQsoSr7W6yItQOWhwaNKKoKx9dVKOjOTz/EzgRRElTpWuWaTiZAyC8wXsFVUHSHJJikCUmM6VGHTR6AW0jZXLTi5GB506RqIKHu50MdFjF2doCFem3RrvQlSZRLaDbecMWT/7UXZvcO0gRPaxgtinH3tCsBM+eYtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zF6W8bSE5qv1kZ5sq77czz/83tqAvowcmZdBiWHldBs=;
 b=uQm36fMrdm9kjtQBNtRtA/YU39KvUILhXkFWgdU2t2TUp/EolKrG+kS9JxyW7EPmpOeudhN+hq5uv1QsV4Oox5KgczYw6HWXweviWp10MRQPiN0Decsv+GSv18we0GngMyN7yE/L14pU6Q3LEnNzfTUEuL+Zs7kqUhF9EUW/oJixTzzadYrI/JhJY4BQo6vgwcEUFkeMsvshgIsrqH9oKQolZLdnWgv6GnCo6Mla725DObO14DXP5GdsDKBXNfx7mdM+kZRCCfymZR9/zqGNpMwe1bDsksfMU8yJTmVwFk04lvCgHkuJxilhoSrpzFeZwAv06npVNTXCUMF8LzndRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zF6W8bSE5qv1kZ5sq77czz/83tqAvowcmZdBiWHldBs=;
 b=AI/5VSMXs+6Frmm9g/S/zNmmoZkBo3fsDdh6PthMUJKncjzRKbJnvh9zXgoWeEpBfkxhk6UKj//X7n2n5lwABfnvhSi/ZsdolX2YNohdYquK1pi6lJQHfzPVjNxT9UaBdHGp8L2NQ5Khhr1RdK/MxhFlJZHhrBNGxa/U7EowSo1YWq1f2ZnWnNMmD+6DXTuVgKfhr7HSgjr/sShZPMS0P3w2MhsSXLQv8FJDAqdOyBvD3b/FRvYNk/XK2ZF0RY1UQ3l+hBnKDEnzOvJgYzBgfE3yl1jqCX/suK3N7oMkRXVF8u6pLzJksL+/OToUNbMQrlJoRPbuEaLiPsSrvLhnkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PUZPR03MB7135.apcprd03.prod.outlook.com (2603:1096:301:113::15)
 by TYZPR03MB7520.apcprd03.prod.outlook.com (2603:1096:400:41a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 02:58:40 +0000
Received: from PUZPR03MB7135.apcprd03.prod.outlook.com
 ([fe80::ecac:a387:36d8:144d]) by PUZPR03MB7135.apcprd03.prod.outlook.com
 ([fe80::ecac:a387:36d8:144d%7]) with mapi id 15.20.8489.025; Fri, 7 Mar 2025
 02:58:40 +0000
Message-ID: <25994adc-d89f-47fb-93d7-eb479f362c73@amlogic.com>
Date: Fri, 7 Mar 2025 10:58:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] clk: meson: axg-audio: Add the mclk pad div for s4
To: Jerome Brunet <jbrunet@baylibre.com>,
 jiebing chen via B4 Relay <devnull+jiebing.chen.amlogic.com@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 jian.xu@amlogic.com, shuai.li@amlogic.com, zhe.wang@amlogic.com
References: <20250228-audio_drvier-v3-0-dbfd30507e4c@amlogic.com>
 <20250228-audio_drvier-v3-4-dbfd30507e4c@amlogic.com>
 <1ja59y5cy8.fsf@starbuckisacylon.baylibre.com>
From: Jiebing Chen <jiebing.chen@amlogic.com>
In-Reply-To: <1ja59y5cy8.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0103.apcprd02.prod.outlook.com
 (2603:1096:4:92::19) To PUZPR03MB7135.apcprd03.prod.outlook.com
 (2603:1096:301:113::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR03MB7135:EE_|TYZPR03MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: 55c157ab-ecf2-442e-8ce9-08dd5d23f686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c013U1BDanlkOVlWVTB6WEU2ZSs2dEg0bnlFdWVXRXIrVjNDVk9KRWpKaHVp?=
 =?utf-8?B?Mk1lalE4QjcrZkUyYzZCNS8wMjdEdGxZVU95UmRDSkNWeXRMeXpwOWlSc0NM?=
 =?utf-8?B?WW1ZZ1djSnU1SFFCOVl5cHFGbEU0cDZOc2owUCthRTJZelU4cWVVN29YTm9D?=
 =?utf-8?B?aUlVZlBPRmpJblJsYm11c080ZmlyQmtCRzVhKzAzT1lMSmduNDNhVE1UMTla?=
 =?utf-8?B?ZlZMbHlMOWMzUVFjR3Z2OVFudkZhN2pBM2ZsYlhOWGEwK01IQVZEZm54TnpT?=
 =?utf-8?B?OHBPTEJkdDFRMXQwOWVLaDM4OTVxNExLV3k1YTAzQ1hLR1pQTUl5THZMMUl6?=
 =?utf-8?B?Z2x1bGhiVHRNUEw2NXNvTGI5ZGpvUWxwZWtuY21EUUpaUTg5QktuSUJXSnFx?=
 =?utf-8?B?U1dwVk1aLzBxdXZMVHNLSkdZRys4MUxJTFBtYURyQUd5L2lsZmpudXJieEY4?=
 =?utf-8?B?TTgxdEllbE55VGNhVjVuYUtPTzYyaTVkNXA2ODhTM2pMeWNiTXp2Yy9mRDJ4?=
 =?utf-8?B?MVVlS3NXSnBuVFF4SEMvZmg3STJhdGdzaHRMUVcraWNUYnBTQ1pCNGwrT2hX?=
 =?utf-8?B?eDdYazNhckR2VFEweUpPdEFnVVFWaENRS3UrdlVLQnZWV3B0eUtGcXNpbmpK?=
 =?utf-8?B?NExNM2ZyMG5JdnNRSmI1bllnM3JBdGJpUEVGTXlEaEQ0aDl3Z0FIb09TZ3Mz?=
 =?utf-8?B?ODNWOVVnZlh3dlJqcFBVVlJCdzdqMFhiaVdTNVNLTVc4VzhJVkUxQ0Z6bWta?=
 =?utf-8?B?YzQvczQ4TFlldTBsWnp5a3N5M0tnWSsxNGo4cEFtOU92d1dwdHE2SmdYNytU?=
 =?utf-8?B?eGdHMHlvMHpBbUVmcTV0YkpjSllyYy9pSmFNRlBwM2kyem90dGdxTFNUYVN3?=
 =?utf-8?B?QUgxN3NmOEgrcWFqdllyN2pIT3BqeGM1N1BxaGxpNnRtcTZjL1RMMGNCL2NB?=
 =?utf-8?B?RWc0bmdTSHFnVVpvcWRDUElLaUFVZkxKZVlHVnVtZFVhVFFvNTM1enpsb3ov?=
 =?utf-8?B?c05zT3d6SXJRcHRYRmM5bGVaalJtVTd2Zk9jeW9LSC9YVHhNUkpIRHlCeTFE?=
 =?utf-8?B?eitWN3ZKVmZZZ3hEMXV0bXhyRmJaV3g4aUJ6TFVQMlFrQm91b1VEYWc0NXl4?=
 =?utf-8?B?YS9XNlFPalBKR2dveDVta2ZtU3UxWnVDSW9pRDFxekxEQWx5Um5JQjk1cTNv?=
 =?utf-8?B?UENDdHE5TWtEUmpTYXFGR2NJaGZDRW92ZkxmZlJNdFZvM1FMYis5YTlRV0xL?=
 =?utf-8?B?MDR3b2tRU2lpS0hjTHZPaVhLYlNId2xCSjY4dFhoemhQbDFWdFlPU0lrYmFy?=
 =?utf-8?B?b1ZtdFhUeVpNOGtJTUFXa0t1RFBMdXZZZWxUOWRKTE1jaWlhcmhUODJSRlJh?=
 =?utf-8?B?eGVXK1laRWUvY3dkSkV6U1RJclBlV2NRQnNpbkNaQXNJQ0hSRFIvc0o0cE1k?=
 =?utf-8?B?SThFTGxJOVA4UksySGtHd2lUSC9mMERwRTZ5Rmw5bnduS1A4bmtKQk1lRzgv?=
 =?utf-8?B?ZFc5NGQrTll1WHJ3MVNudjFGYXcvMGlkM1FxOVYxSDJJeU5aSXFaQmNyQlE2?=
 =?utf-8?B?U0ZiZjlkcCtwNzZzcHEveHBGNXJwSHVRTitRSEl6Vmp0Mks5VTJOUTlUT1Zm?=
 =?utf-8?B?MTY5MTZCaGhrTWRsN01wL05WNWdLUVB0MGtWak5CK0dsMmFHcGR4YXQxSjEz?=
 =?utf-8?B?a1IrVUFHeDZ4KzNIL0FUaXRveGNiOE5PRTlPRTVmdE5wWWlKOTdpMWoyeXR1?=
 =?utf-8?B?ZkVOZ2VucjVCNFpRY1dubXdlUFV3Y0VKaGlDbXJlczZJRVVURzlnVzErTzdR?=
 =?utf-8?B?RVdkamZ5YTVtcHZ6ZmlIRGsvR1hWc0dYSnkvSVVkdzZWMXBNdk1lMkJDK01P?=
 =?utf-8?Q?tygAYHee2HWDL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB7135.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUxuZXBNd0lVTFRDYjVIZW1zRHdBWTArREZ5R08xSnRWQkhtVXhCRDE3Z0cx?=
 =?utf-8?B?Zkt1WmJUK3NQOU9sT1lBd21CcGhCdUN0NTF3clBIUG01emsxYlFDSmVoVGx6?=
 =?utf-8?B?bVdRRStDSHFNM0tmMGQ5bVBMelFvOXpLSlVNNE5vYlEza0x6OXVQY0J2bTc4?=
 =?utf-8?B?cUtBbHo1R1BXcThCT2VGUTVQUEcwOWUyOTF3dSszanFtc3lqQ3NxYVZzRk1n?=
 =?utf-8?B?cnJzRzhiWVhwOGU2bU1aVVRHMzFZZGtvWVAxVnRheE80SmRmWUd2ZlZzaWNY?=
 =?utf-8?B?ZWZlT2hsM09uVk9PQVdyU2dhRVdYM1VRWi9wN1RtRGhTalovWVJseWlaWk4x?=
 =?utf-8?B?U2xFcFYyckU2enFVZUZIOVk1ZkVtUnU0eklEMHBlZ1VmN0g2N0NPWkVmZWZT?=
 =?utf-8?B?TmNIWDRFaWMvQmNaVUVRZjBsdlRzWmJoaDc2TnN1ZVA3L21kTUpMTnQxcFJU?=
 =?utf-8?B?TC9FSUNEUVZ1TVNKTlIxRnlCeHpxTWtSSEJKSmRkditpNTRBY21McXNJd1pF?=
 =?utf-8?B?cmUrWFN1dTE5UXFKcVQ4WmhYbEJnWmlGem4xWjNUYU9IdVIrZGhRQWhxMXVv?=
 =?utf-8?B?Vm94MDk5UWZvM0FXMGJ3U1J0djFsbDFlMkxLN3Z1dVpYNFIyVTNxckR0MjQ0?=
 =?utf-8?B?WXp5ZmlaK0RQOTQ2MWlGQjJFYlRDaVhzL2xUSkRtK3gwSWJtVVhFTGNrTTh2?=
 =?utf-8?B?RHRpOHdzS0dhcThuVnRQV2l5aVJCL3ZLOXdwOHdZWnMvOHQ3cTliV1lIQUI1?=
 =?utf-8?B?MXRtOW9nVUhzRGxFRm1qYzNTNDUzeTM3UTBRVDNBZzM1QVFYV0o1N2ZrRTE2?=
 =?utf-8?B?ZTNaV2tReFlFSUJTMVR4aVNFSVhHaVhOR2NxWk4wUjk3bEVtUktqSmVOcGMz?=
 =?utf-8?B?QUZITEttU2tFNmQ3VGFPR3BGUytncHQ5bXVnTUI4OCt3UHZac2QyZGtZaWZh?=
 =?utf-8?B?VjRYNnVBZVpFRlZiTnhQclJLbGtxOWRqN1BTVzlKVE5WU3R4S3NlYTBLMGI2?=
 =?utf-8?B?bW1MR0kwL0tJUzErMHJkZFBkTnhpVWJoblM4MTJFQ28weXlHNlZ2aUJYNSs4?=
 =?utf-8?B?d1dHNWpGc1B6MlczZW5xeWJ0S25VWms1QlRqcTJ1YWRFa2xGYkUzZFp5SmJM?=
 =?utf-8?B?SXhTMnNYUkEyb2N3dVdkYkNqUlJaY0U3Q1k5MCtFaTFGWEd4dDkzdjdTRGJX?=
 =?utf-8?B?ZjdBVmd2czhLVSt5cnA0cTdMZ3NOeG9XR1AyQllvcDdWV2F3ZFJvZ0kxVVFO?=
 =?utf-8?B?bFp0dE1lVFpCcmxlYkxlZ3hHVnViTXZnSWtIcyt2b2ZvQmNYM2J2QlNwVVhy?=
 =?utf-8?B?aTdhY3Y5b3pya3p1TUlJRVd5YmYyTVZCcDlrTzZBcTI4eTEwSU1NZzdmVm9l?=
 =?utf-8?B?MlovdjQwcEl4M1JyRElOcGdTM0V3K2dQaDJZY0tXRks3UUtjMkhJK1NycGIr?=
 =?utf-8?B?djkxeGpiTDRxY1UzZS8xck9WZ3ZQYVJ5WHdad1FLSXI4a3E5QWExR2t2V2pl?=
 =?utf-8?B?bit5VXpZTjVNVHFRbk10UHVsc3JVZ09TUnJ1cFQyb2NFQXRrTFhsU0tjN3Yx?=
 =?utf-8?B?QXh5Qmp4a2lLa2hRMWczKzJGNkVhaDJodnRrcStsWDlVUFRSRFJlUklTeU9F?=
 =?utf-8?B?YXNadFBJTGFENzk1REpyaGNWSG1YemdGWVBVMDg1UXpIcnI4RzFDODhyME16?=
 =?utf-8?B?ZjR3S3Bwa2Z5TXViQTFSejJSVkUyVHhRTUFOOVlYSGMxMDNEU2M4dEFqK00y?=
 =?utf-8?B?VncvRFkrOXhLajVmMmtTUGdZU0U5aGt6L012cHJpNEZPLzhSb1FnTndIWmFK?=
 =?utf-8?B?WHgrK3FudjNiamxNLzNiRnJzeDBHQzlJek5FUEFLRGxId0FYNDdqVDkxUDBO?=
 =?utf-8?B?TXhKOXRtRmc3cGRwNjUzQklxM2xhdXVpK0RDUkFxVTdHT1AwajlmcVFiSzJi?=
 =?utf-8?B?bUVpTXNXZnI3MDBBTkZZWkt4NFM5dHdYVnNaMDZaa05Udm4rVTFTN01yRFFX?=
 =?utf-8?B?c3M5TFF0Rjk4aldvMlFTUHNJWE91SDZYSThyT2pFNmJUQVZ3c09RSFNzRDJ5?=
 =?utf-8?B?YnZEc0JIU1grVzg2YmNzSXNwZXVlbURRM3NiSWh3SUFzNmRXbWZaWkpZMkNI?=
 =?utf-8?B?bW5LaCtUVVVnWnd6TFpKWHZYU1R2U2NTbHZEOWUvUU1iR2tWN2p0ajJkZnVj?=
 =?utf-8?B?elE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c157ab-ecf2-442e-8ce9-08dd5d23f686
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB7135.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 02:58:40.0938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8FuYlTJmbvvg0mMxcPe+CJP56czt9pNuTfqoQI1UiQWhlCR+3k9eAfLcRQ3sD4qSh2EDtS89OfIiEeuYN937qv3F2hm+r3KUQTsmvuHd6ew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7520


在 2025/3/7 0:41, Jerome Brunet 写道:
> [ EXTERNAL EMAIL ]
>
> On Fri 28 Feb 2025 at 16:04, jiebing chen via B4 Relay <devnull+jiebing.chen.amlogic.com@kernel.org> wrote:
>
>> From: jiebing chen <jiebing.chen@amlogic.com>
>>
>> Add mclk pad div support, Increased the number of lrclk
>> and sclk pads to five
>>
>> Signed-off-by: jiebing chen <jiebing.chen@amlogic.com>
>> ---
>>   drivers/clk/meson/axg-audio.c | 410 +++++++++++++++++++++++++++++++++++++++++-
>>   drivers/clk/meson/axg-audio.h |   4 +
>>   2 files changed, 412 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
>> index 9df627b142f89788966ede0262aaaf39e13f0b49..e70559ee0fd8deaf9858b0592e839fdf49d05886 100644
>> --- a/drivers/clk/meson/axg-audio.c
>> +++ b/drivers/clk/meson/axg-audio.c
>> @@ -323,6 +323,16 @@ static const struct clk_parent_data lrclk_pad_ctrl_parent_data[] = {
>>        AUD_MUX(_name, _reg, 0x7, _shift, 0, _parents,          \
>>                CLK_SET_RATE_NO_REPARENT)
>>
>> +#define AUD_MCLK_PAD_MUX(_name, _reg, _shift)                                        \
>> +     AUD_MUX(_name##_sel, _reg, 0x7, _shift, CLK_MUX_ROUND_CLOSEST,                  \
>> +             mclk_pad_ctrl_parent_data, 0)
>> +#define AUD_MCLK_PAD_DIV(_name, _reg, _shift)                                        \
>> +     AUD_DIV(_name##_div, _reg, _shift, 8, CLK_DIVIDER_ROUND_CLOSEST,                        \
>> +             aud_##_name##_sel, CLK_SET_RATE_PARENT)
>> +#define AUD_MCLK_PAD_GATE(_name, _reg, _shift)                                       \
>> +     AUD_GATE(_name, _reg, _shift, aud_##_name##_div,                        \
>> +              CLK_SET_RATE_PARENT)
>> +
>>   /* Common Clocks */
>>   static struct clk_regmap ddr_arb =
>>        AUD_PCLK_GATE(ddr_arb, AUDIO_CLK_GATE_EN, 0);
>> @@ -826,6 +836,49 @@ static struct clk_regmap sm1_tdm_sclk_pad_1 = AUD_TDM_PAD_CTRL(
>>   static struct clk_regmap sm1_tdm_sclk_pad_2 = AUD_TDM_PAD_CTRL(
>>        tdm_sclk_pad_2, AUDIO_SM1_MST_PAD_CTRL1, 8, sclk_pad_ctrl_parent_data);
>>
>> +static struct clk_regmap s4_tdm_mclk_pad0_sel =
>> +     AUD_MCLK_PAD_MUX(mclk_pad0, AUDIO_S4_MCLK_PAD_CTRL0, 8);
>> +static struct clk_regmap s4_tdm_mclk_pad1_sel =
>> +     AUD_MCLK_PAD_MUX(mclk_pad1, AUDIO_S4_MCLK_PAD_CTRL0, 24);
>> +static struct clk_regmap s4_tdm_mclk_pad2_sel =
>> +     AUD_MCLK_PAD_MUX(mclk_pad2, AUDIO_S4_MCLK_PAD_CTRL1, 8);
>> +
>> +static struct clk_regmap s4_tdm_mclk_pad0_div =
>> +     AUD_MCLK_PAD_DIV(mclk_pad0, AUDIO_S4_MCLK_PAD_CTRL0, 0);
>> +static struct clk_regmap s4_tdm_mclk_pad1_div =
>> +     AUD_MCLK_PAD_DIV(mclk_pad1, AUDIO_S4_MCLK_PAD_CTRL0, 16);
>> +static struct clk_regmap s4_tdm_mclk_pad2_div =
>> +     AUD_MCLK_PAD_DIV(mclk_pad2, AUDIO_S4_MCLK_PAD_CTRL1, 0);
>> +
>> +static struct clk_regmap s4_tdm_mclk_pad_0 =
>> +     AUD_MCLK_PAD_GATE(mclk_pad0, AUDIO_S4_MCLK_PAD_CTRL0, 15);
>> +static struct clk_regmap s4_tdm_mclk_pad_1 =
>> +     AUD_MCLK_PAD_GATE(mclk_pad1, AUDIO_S4_MCLK_PAD_CTRL0, 31);
>> +static struct clk_regmap s4_tdm_mclk_pad_2 =
>> +     AUD_MCLK_PAD_GATE(mclk_pad2, AUDIO_S4_MCLK_PAD_CTRL1, 15);
>> +
>> +static struct clk_regmap s4_tdm_sclk_pad_0 =
>> +     AUD_TDM_PAD_CTRL(tdm_sclk_pad_0, AUDIO_S4_SCLK_PAD_CTRL0, 0, lrclk_pad_ctrl_parent_data);
>> +static struct clk_regmap s4_tdm_sclk_pad_1 =
>> +     AUD_TDM_PAD_CTRL(tdm_sclk_pad_1, AUDIO_S4_SCLK_PAD_CTRL0, 4, lrclk_pad_ctrl_parent_data);
>> +static struct clk_regmap s4_tdm_sclk_pad_2 =
>> +     AUD_TDM_PAD_CTRL(tdm_sclk_pad_2, AUDIO_S4_SCLK_PAD_CTRL0, 8, lrclk_pad_ctrl_parent_data);
>> +static struct clk_regmap s4_tdm_sclk_pad_3 =
>> +     AUD_TDM_PAD_CTRL(tdm_sclk_pad_3, AUDIO_S4_SCLK_PAD_CTRL0, 16, lrclk_pad_ctrl_parent_data);
>> +static struct clk_regmap s4_tdm_sclk_pad_4 =
>> +     AUD_TDM_PAD_CTRL(tdm_sclk_pad_4, AUDIO_S4_SCLK_PAD_CTRL0, 20, lrclk_pad_ctrl_parent_data);
>> +
>> +static struct clk_regmap s4_tdm_lrclk_pad_0 =
>> +     AUD_TDM_PAD_CTRL(tdm_lrclk_pad_0, AUDIO_S4_SCLK_PAD_CTRL1, 0, lrclk_pad_ctrl_parent_data);
>> +static struct clk_regmap s4_tdm_lrclk_pad_1 =
>> +     AUD_TDM_PAD_CTRL(tdm_lrclk_pad_1, AUDIO_S4_SCLK_PAD_CTRL1, 4, lrclk_pad_ctrl_parent_data);
>> +static struct clk_regmap s4_tdm_lrclk_pad_2 =
>> +     AUD_TDM_PAD_CTRL(tdm_lrclk_pad_2, AUDIO_S4_SCLK_PAD_CTRL1, 8, lrclk_pad_ctrl_parent_data);
>> +static struct clk_regmap s4_tdm_lrclk_pad_3 =
>> +     AUD_TDM_PAD_CTRL(tdm_lrclk_pad_3, AUDIO_S4_SCLK_PAD_CTRL1, 16, lrclk_pad_ctrl_parent_data);
>> +static struct clk_regmap s4_tdm_lrclk_pad_4 =
>> +     AUD_TDM_PAD_CTRL(tdm_lrclk_pad_4, AUDIO_S4_SCLK_PAD_CTRL1, 20, lrclk_pad_ctrl_parent_data);
>> +
>>   /*
>>    * Array of all clocks provided by this provider
>>    * The input clocks of the controller will be populated at runtime
>> @@ -1257,6 +1310,177 @@ static struct clk_hw *sm1_audio_hw_clks[] = {
>>        [AUD_CLKID_EARCRX_DMAC]         = &sm1_earcrx_dmac_clk.hw,
>>   };
>>
>> +/*
>> + * Array of all S4 clocks provided by this provider
>> + * The input clocks of the controller will be populated at runtime
>> + */
>> +static struct clk_hw *s4_audio_hw_clks[] = {
>> +     [AUD_CLKID_DDR_ARB]             = &ddr_arb.hw,
>> +     [AUD_CLKID_PDM]                 = &pdm.hw,
>> +     [AUD_CLKID_TDMIN_A]             = &tdmin_a.hw,
>> +     [AUD_CLKID_TDMIN_B]             = &tdmin_b.hw,
>> +     [AUD_CLKID_TDMIN_C]             = &tdmin_c.hw,
>> +     [AUD_CLKID_TDMIN_LB]            = &tdmin_lb.hw,
>> +     [AUD_CLKID_TDMOUT_A]            = &tdmout_a.hw,
>> +     [AUD_CLKID_TDMOUT_B]            = &tdmout_b.hw,
>> +     [AUD_CLKID_TDMOUT_C]            = &tdmout_c.hw,
>> +     [AUD_CLKID_FRDDR_A]             = &frddr_a.hw,
>> +     [AUD_CLKID_FRDDR_B]             = &frddr_b.hw,
>> +     [AUD_CLKID_FRDDR_C]             = &frddr_c.hw,
>> +     [AUD_CLKID_TODDR_A]             = &toddr_a.hw,
>> +     [AUD_CLKID_TODDR_B]             = &toddr_b.hw,
>> +     [AUD_CLKID_TODDR_C]             = &toddr_c.hw,
>> +     [AUD_CLKID_LOOPBACK]            = &loopback.hw,
>> +     [AUD_CLKID_SPDIFIN]             = &spdifin.hw,
>> +     [AUD_CLKID_SPDIFOUT]            = &spdifout.hw,
>> +     [AUD_CLKID_RESAMPLE]            = &resample.hw,
>> +     [AUD_CLKID_SPDIFOUT_B]          = &spdifout_b.hw,
>> +     [AUD_CLKID_MST_A_MCLK_SEL]      = &sm1_mst_a_mclk_sel.hw,
>> +     [AUD_CLKID_MST_B_MCLK_SEL]      = &sm1_mst_b_mclk_sel.hw,
>> +     [AUD_CLKID_MST_C_MCLK_SEL]      = &sm1_mst_c_mclk_sel.hw,
>> +     [AUD_CLKID_MST_D_MCLK_SEL]      = &sm1_mst_d_mclk_sel.hw,
>> +     [AUD_CLKID_MST_E_MCLK_SEL]      = &sm1_mst_e_mclk_sel.hw,
>> +     [AUD_CLKID_MST_F_MCLK_SEL]      = &sm1_mst_f_mclk_sel.hw,
>> +     [AUD_CLKID_MST_A_MCLK_DIV]      = &sm1_mst_a_mclk_div.hw,
>> +     [AUD_CLKID_MST_B_MCLK_DIV]      = &sm1_mst_b_mclk_div.hw,
>> +     [AUD_CLKID_MST_C_MCLK_DIV]      = &sm1_mst_c_mclk_div.hw,
>> +     [AUD_CLKID_MST_D_MCLK_DIV]      = &sm1_mst_d_mclk_div.hw,
>> +     [AUD_CLKID_MST_E_MCLK_DIV]      = &sm1_mst_e_mclk_div.hw,
>> +     [AUD_CLKID_MST_F_MCLK_DIV]      = &sm1_mst_f_mclk_div.hw,
>> +     [AUD_CLKID_MST_A_MCLK]          = &sm1_mst_a_mclk.hw,
>> +     [AUD_CLKID_MST_B_MCLK]          = &sm1_mst_b_mclk.hw,
>> +     [AUD_CLKID_MST_C_MCLK]          = &sm1_mst_c_mclk.hw,
>> +     [AUD_CLKID_MST_D_MCLK]          = &sm1_mst_d_mclk.hw,
>> +     [AUD_CLKID_MST_E_MCLK]          = &sm1_mst_e_mclk.hw,
>> +     [AUD_CLKID_MST_F_MCLK]          = &sm1_mst_f_mclk.hw,
>> +     [AUD_CLKID_SPDIFOUT_CLK_SEL]    = &spdifout_clk_sel.hw,
>> +     [AUD_CLKID_SPDIFOUT_CLK_DIV]    = &spdifout_clk_div.hw,
>> +     [AUD_CLKID_SPDIFOUT_CLK]        = &spdifout_clk.hw,
>> +     [AUD_CLKID_SPDIFOUT_B_CLK_SEL]  = &spdifout_b_clk_sel.hw,
>> +     [AUD_CLKID_SPDIFOUT_B_CLK_DIV]  = &spdifout_b_clk_div.hw,
>> +     [AUD_CLKID_SPDIFOUT_B_CLK]      = &spdifout_b_clk.hw,
>> +     [AUD_CLKID_SPDIFIN_CLK_SEL]     = &spdifin_clk_sel.hw,
>> +     [AUD_CLKID_SPDIFIN_CLK_DIV]     = &spdifin_clk_div.hw,
>> +     [AUD_CLKID_SPDIFIN_CLK]         = &spdifin_clk.hw,
>> +     [AUD_CLKID_PDM_DCLK_SEL]        = &pdm_dclk_sel.hw,
>> +     [AUD_CLKID_PDM_DCLK_DIV]        = &pdm_dclk_div.hw,
>> +     [AUD_CLKID_PDM_DCLK]            = &pdm_dclk.hw,
>> +     [AUD_CLKID_PDM_SYSCLK_SEL]      = &pdm_sysclk_sel.hw,
>> +     [AUD_CLKID_PDM_SYSCLK_DIV]      = &pdm_sysclk_div.hw,
>> +     [AUD_CLKID_PDM_SYSCLK]          = &pdm_sysclk.hw,
>> +     [AUD_CLKID_MST_A_SCLK_PRE_EN]   = &mst_a_sclk_pre_en.hw,
>> +     [AUD_CLKID_MST_B_SCLK_PRE_EN]   = &mst_b_sclk_pre_en.hw,
>> +     [AUD_CLKID_MST_C_SCLK_PRE_EN]   = &mst_c_sclk_pre_en.hw,
>> +     [AUD_CLKID_MST_D_SCLK_PRE_EN]   = &mst_d_sclk_pre_en.hw,
>> +     [AUD_CLKID_MST_E_SCLK_PRE_EN]   = &mst_e_sclk_pre_en.hw,
>> +     [AUD_CLKID_MST_F_SCLK_PRE_EN]   = &mst_f_sclk_pre_en.hw,
>> +     [AUD_CLKID_MST_A_SCLK_DIV]      = &mst_a_sclk_div.hw,
>> +     [AUD_CLKID_MST_B_SCLK_DIV]      = &mst_b_sclk_div.hw,
>> +     [AUD_CLKID_MST_C_SCLK_DIV]      = &mst_c_sclk_div.hw,
>> +     [AUD_CLKID_MST_D_SCLK_DIV]      = &mst_d_sclk_div.hw,
>> +     [AUD_CLKID_MST_E_SCLK_DIV]      = &mst_e_sclk_div.hw,
>> +     [AUD_CLKID_MST_F_SCLK_DIV]      = &mst_f_sclk_div.hw,
>> +     [AUD_CLKID_MST_A_SCLK_POST_EN]  = &mst_a_sclk_post_en.hw,
>> +     [AUD_CLKID_MST_B_SCLK_POST_EN]  = &mst_b_sclk_post_en.hw,
>> +     [AUD_CLKID_MST_C_SCLK_POST_EN]  = &mst_c_sclk_post_en.hw,
>> +     [AUD_CLKID_MST_D_SCLK_POST_EN]  = &mst_d_sclk_post_en.hw,
>> +     [AUD_CLKID_MST_E_SCLK_POST_EN]  = &mst_e_sclk_post_en.hw,
>> +     [AUD_CLKID_MST_F_SCLK_POST_EN]  = &mst_f_sclk_post_en.hw,
>> +     [AUD_CLKID_MST_A_SCLK]          = &mst_a_sclk.hw,
>> +     [AUD_CLKID_MST_B_SCLK]          = &mst_b_sclk.hw,
>> +     [AUD_CLKID_MST_C_SCLK]          = &mst_c_sclk.hw,
>> +     [AUD_CLKID_MST_D_SCLK]          = &mst_d_sclk.hw,
>> +     [AUD_CLKID_MST_E_SCLK]          = &mst_e_sclk.hw,
>> +     [AUD_CLKID_MST_F_SCLK]          = &mst_f_sclk.hw,
>> +     [AUD_CLKID_MST_A_LRCLK_DIV]     = &mst_a_lrclk_div.hw,
>> +     [AUD_CLKID_MST_B_LRCLK_DIV]     = &mst_b_lrclk_div.hw,
>> +     [AUD_CLKID_MST_C_LRCLK_DIV]     = &mst_c_lrclk_div.hw,
>> +     [AUD_CLKID_MST_D_LRCLK_DIV]     = &mst_d_lrclk_div.hw,
>> +     [AUD_CLKID_MST_E_LRCLK_DIV]     = &mst_e_lrclk_div.hw,
>> +     [AUD_CLKID_MST_F_LRCLK_DIV]     = &mst_f_lrclk_div.hw,
>> +     [AUD_CLKID_MST_A_LRCLK]         = &mst_a_lrclk.hw,
>> +     [AUD_CLKID_MST_B_LRCLK]         = &mst_b_lrclk.hw,
>> +     [AUD_CLKID_MST_C_LRCLK]         = &mst_c_lrclk.hw,
>> +     [AUD_CLKID_MST_D_LRCLK]         = &mst_d_lrclk.hw,
>> +     [AUD_CLKID_MST_E_LRCLK]         = &mst_e_lrclk.hw,
>> +     [AUD_CLKID_MST_F_LRCLK]         = &mst_f_lrclk.hw,
>> +     [AUD_CLKID_TDMIN_A_SCLK_SEL]    = &tdmin_a_sclk_sel.hw,
>> +     [AUD_CLKID_TDMIN_B_SCLK_SEL]    = &tdmin_b_sclk_sel.hw,
>> +     [AUD_CLKID_TDMIN_C_SCLK_SEL]    = &tdmin_c_sclk_sel.hw,
>> +     [AUD_CLKID_TDMIN_LB_SCLK_SEL]   = &tdmin_lb_sclk_sel.hw,
>> +     [AUD_CLKID_TDMOUT_A_SCLK_SEL]   = &tdmout_a_sclk_sel.hw,
>> +     [AUD_CLKID_TDMOUT_B_SCLK_SEL]   = &tdmout_b_sclk_sel.hw,
>> +     [AUD_CLKID_TDMOUT_C_SCLK_SEL]   = &tdmout_c_sclk_sel.hw,
>> +     [AUD_CLKID_TDMIN_A_SCLK_PRE_EN] = &tdmin_a_sclk_pre_en.hw,
>> +     [AUD_CLKID_TDMIN_B_SCLK_PRE_EN] = &tdmin_b_sclk_pre_en.hw,
>> +     [AUD_CLKID_TDMIN_C_SCLK_PRE_EN] = &tdmin_c_sclk_pre_en.hw,
>> +     [AUD_CLKID_TDMIN_LB_SCLK_PRE_EN] = &tdmin_lb_sclk_pre_en.hw,
>> +     [AUD_CLKID_TDMOUT_A_SCLK_PRE_EN] = &tdmout_a_sclk_pre_en.hw,
>> +     [AUD_CLKID_TDMOUT_B_SCLK_PRE_EN] = &tdmout_b_sclk_pre_en.hw,
>> +     [AUD_CLKID_TDMOUT_C_SCLK_PRE_EN] = &tdmout_c_sclk_pre_en.hw,
>> +     [AUD_CLKID_TDMIN_A_SCLK_POST_EN] = &tdmin_a_sclk_post_en.hw,
>> +     [AUD_CLKID_TDMIN_B_SCLK_POST_EN] = &tdmin_b_sclk_post_en.hw,
>> +     [AUD_CLKID_TDMIN_C_SCLK_POST_EN] = &tdmin_c_sclk_post_en.hw,
>> +     [AUD_CLKID_TDMIN_LB_SCLK_POST_EN] = &tdmin_lb_sclk_post_en.hw,
>> +     [AUD_CLKID_TDMOUT_A_SCLK_POST_EN] = &tdmout_a_sclk_post_en.hw,
>> +     [AUD_CLKID_TDMOUT_B_SCLK_POST_EN] = &tdmout_b_sclk_post_en.hw,
>> +     [AUD_CLKID_TDMOUT_C_SCLK_POST_EN] = &tdmout_c_sclk_post_en.hw,
>> +     [AUD_CLKID_TDMIN_A_SCLK]        = &tdmin_a_sclk.hw,
>> +     [AUD_CLKID_TDMIN_B_SCLK]        = &tdmin_b_sclk.hw,
>> +     [AUD_CLKID_TDMIN_C_SCLK]        = &tdmin_c_sclk.hw,
>> +     [AUD_CLKID_TDMIN_LB_SCLK]       = &tdmin_lb_sclk.hw,
>> +     [AUD_CLKID_TDMOUT_A_SCLK]       = &g12a_tdmout_a_sclk.hw,
>> +     [AUD_CLKID_TDMOUT_B_SCLK]       = &g12a_tdmout_b_sclk.hw,
>> +     [AUD_CLKID_TDMOUT_C_SCLK]       = &g12a_tdmout_c_sclk.hw,
>> +     [AUD_CLKID_TDMIN_A_LRCLK]       = &tdmin_a_lrclk.hw,
>> +     [AUD_CLKID_TDMIN_B_LRCLK]       = &tdmin_b_lrclk.hw,
>> +     [AUD_CLKID_TDMIN_C_LRCLK]       = &tdmin_c_lrclk.hw,
>> +     [AUD_CLKID_TDMIN_LB_LRCLK]      = &tdmin_lb_lrclk.hw,
>> +     [AUD_CLKID_TDMOUT_A_LRCLK]      = &tdmout_a_lrclk.hw,
>> +     [AUD_CLKID_TDMOUT_B_LRCLK]      = &tdmout_b_lrclk.hw,
>> +     [AUD_CLKID_TDMOUT_C_LRCLK]      = &tdmout_c_lrclk.hw,
>> +     [AUD_CLKID_TDM_MCLK_PAD0]       = &s4_tdm_mclk_pad_0.hw,
>> +     [AUD_CLKID_TDM_MCLK_PAD1]       = &s4_tdm_mclk_pad_1.hw,
>> +     [AUD_CLKID_TDM_LRCLK_PAD0]      = &s4_tdm_lrclk_pad_0.hw,
>> +     [AUD_CLKID_TDM_LRCLK_PAD1]      = &s4_tdm_lrclk_pad_1.hw,
>> +     [AUD_CLKID_TDM_LRCLK_PAD2]      = &s4_tdm_lrclk_pad_2.hw,
>> +     [AUD_CLKID_TDM_SCLK_PAD0]       = &s4_tdm_sclk_pad_0.hw,
>> +     [AUD_CLKID_TDM_SCLK_PAD1]       = &s4_tdm_sclk_pad_1.hw,
>> +     [AUD_CLKID_TDM_SCLK_PAD2]       = &s4_tdm_sclk_pad_2.hw,
>> +     [AUD_CLKID_TOP]                 = &sm1_aud_top.hw,
>> +     [AUD_CLKID_TORAM]               = &toram.hw,
>> +     [AUD_CLKID_EQDRC]               = &eqdrc.hw,
>> +     [AUD_CLKID_RESAMPLE_B]          = &resample_b.hw,
>> +     [AUD_CLKID_TOVAD]               = &tovad.hw,
>> +     [AUD_CLKID_LOCKER]              = &locker.hw,
>> +     [AUD_CLKID_SPDIFIN_LB]          = &spdifin_lb.hw,
>> +     [AUD_CLKID_FRDDR_D]             = &frddr_d.hw,
>> +     [AUD_CLKID_TODDR_D]             = &toddr_d.hw,
>> +     [AUD_CLKID_LOOPBACK_B]          = &loopback_b.hw,
>> +     [AUD_CLKID_CLK81_EN]            = &sm1_clk81_en.hw,
>> +     [AUD_CLKID_SYSCLK_A_DIV]        = &sm1_sysclk_a_div.hw,
>> +     [AUD_CLKID_SYSCLK_A_EN]         = &sm1_sysclk_a_en.hw,
>> +     [AUD_CLKID_SYSCLK_B_DIV]        = &sm1_sysclk_b_div.hw,
>> +     [AUD_CLKID_SYSCLK_B_EN]         = &sm1_sysclk_b_en.hw,
>> +     [AUD_CLKID_EARCRX]              = &earcrx.hw,
>> +     [AUD_CLKID_EARCRX_CMDC_SEL]     = &sm1_earcrx_cmdc_clk_sel.hw,
>> +     [AUD_CLKID_EARCRX_CMDC_DIV]     = &sm1_earcrx_cmdc_clk_div.hw,
>> +     [AUD_CLKID_EARCRX_CMDC]         = &sm1_earcrx_cmdc_clk.hw,
>> +     [AUD_CLKID_EARCRX_DMAC_SEL]     = &sm1_earcrx_dmac_clk_sel.hw,
>> +     [AUD_CLKID_EARCRX_DMAC_DIV]     = &sm1_earcrx_dmac_clk_div.hw,
>> +     [AUD_CLKID_EARCRX_DMAC]         = &sm1_earcrx_dmac_clk.hw,
>> +     [AUD_CLKID_TDM_MCLK_PAD0_SEL]           = &s4_tdm_mclk_pad0_sel.hw,
>> +     [AUD_CLKID_TDM_MCLK_PAD1_SEL]       = &s4_tdm_mclk_pad1_sel.hw,
>> +     [AUD_CLKID_TDM_MCLK_PAD0_DIV]           = &s4_tdm_mclk_pad0_div.hw,
>> +     [AUD_CLKID_TDM_MCLK_PAD1_DIV]       = &s4_tdm_mclk_pad1_div.hw,
>> +     [AUD_CLKID_TDM_MCLK_PAD2]               = &s4_tdm_mclk_pad_2.hw,
>> +     [AUD_CLKID_TDM_MCLK_PAD2_SEL]           = &s4_tdm_mclk_pad2_sel.hw,
>> +     [AUD_CLKID_TDM_MCLK_PAD2_DIV]       = &s4_tdm_mclk_pad2_div.hw,
>> +     [AUD_CLKID_TDM_SCLK_PAD3]       = &s4_tdm_sclk_pad_3.hw,
>> +     [AUD_CLKID_TDM_SCLK_PAD4]       = &s4_tdm_sclk_pad_4.hw,
>> +     [AUD_CLKID_TDM_LRCLK_PAD3]      = &s4_tdm_lrclk_pad_3.hw,
>> +     [AUD_CLKID_TDM_LRCLK_PAD4]      = &s4_tdm_lrclk_pad_4.hw,
>> +};
>>
>>   /* Convenience table to populate regmap in .probe(). */
>>   static struct clk_regmap *const axg_clk_regmaps[] = {
>> @@ -1678,6 +1902,174 @@ static struct clk_regmap *const sm1_clk_regmaps[] = {
>>        &sm1_earcrx_dmac_clk,
>>   };
>>
>> +static struct clk_regmap *const s4_clk_regmaps[] = {
>> +     &ddr_arb,
>> +     &pdm,
>> +     &tdmin_a,
>> +     &tdmin_b,
>> +     &tdmin_c,
>> +     &tdmin_lb,
>> +     &tdmout_a,
>> +     &tdmout_b,
>> +     &tdmout_c,
>> +     &frddr_a,
>> +     &frddr_b,
>> +     &frddr_c,
>> +     &toddr_a,
>> +     &toddr_b,
>> +     &toddr_c,
>> +     &loopback,
>> +     &spdifin,
>> +     &spdifout,
>> +     &resample,
>> +     &spdifout_b,
>> +     &sm1_mst_a_mclk_sel,
>> +     &sm1_mst_b_mclk_sel,
>> +     &sm1_mst_c_mclk_sel,
>> +     &sm1_mst_d_mclk_sel,
>> +     &sm1_mst_e_mclk_sel,
>> +     &sm1_mst_f_mclk_sel,
>> +     &sm1_mst_a_mclk_div,
>> +     &sm1_mst_b_mclk_div,
>> +     &sm1_mst_c_mclk_div,
>> +     &sm1_mst_d_mclk_div,
>> +     &sm1_mst_e_mclk_div,
>> +     &sm1_mst_f_mclk_div,
>> +     &sm1_mst_a_mclk,
>> +     &sm1_mst_b_mclk,
>> +     &sm1_mst_c_mclk,
>> +     &sm1_mst_d_mclk,
>> +     &sm1_mst_e_mclk,
>> +     &sm1_mst_f_mclk,
>> +     &spdifout_clk_sel,
>> +     &spdifout_clk_div,
>> +     &spdifout_clk,
>> +     &spdifin_clk_sel,
>> +     &spdifin_clk_div,
>> +     &spdifin_clk,
>> +     &pdm_dclk_sel,
>> +     &pdm_dclk_div,
>> +     &pdm_dclk,
>> +     &pdm_sysclk_sel,
>> +     &pdm_sysclk_div,
>> +     &pdm_sysclk,
>> +     &mst_a_sclk_pre_en,
>> +     &mst_b_sclk_pre_en,
>> +     &mst_c_sclk_pre_en,
>> +     &mst_d_sclk_pre_en,
>> +     &mst_e_sclk_pre_en,
>> +     &mst_f_sclk_pre_en,
>> +     &mst_a_sclk_div,
>> +     &mst_b_sclk_div,
>> +     &mst_c_sclk_div,
>> +     &mst_d_sclk_div,
>> +     &mst_e_sclk_div,
>> +     &mst_f_sclk_div,
>> +     &mst_a_sclk_post_en,
>> +     &mst_b_sclk_post_en,
>> +     &mst_c_sclk_post_en,
>> +     &mst_d_sclk_post_en,
>> +     &mst_e_sclk_post_en,
>> +     &mst_f_sclk_post_en,
>> +     &mst_a_sclk,
>> +     &mst_b_sclk,
>> +     &mst_c_sclk,
>> +     &mst_d_sclk,
>> +     &mst_e_sclk,
>> +     &mst_f_sclk,
>> +     &mst_a_lrclk_div,
>> +     &mst_b_lrclk_div,
>> +     &mst_c_lrclk_div,
>> +     &mst_d_lrclk_div,
>> +     &mst_e_lrclk_div,
>> +     &mst_f_lrclk_div,
>> +     &mst_a_lrclk,
>> +     &mst_b_lrclk,
>> +     &mst_c_lrclk,
>> +     &mst_d_lrclk,
>> +     &mst_e_lrclk,
>> +     &mst_f_lrclk,
>> +     &tdmin_a_sclk_sel,
>> +     &tdmin_b_sclk_sel,
>> +     &tdmin_c_sclk_sel,
>> +     &tdmin_lb_sclk_sel,
>> +     &tdmout_a_sclk_sel,
>> +     &tdmout_b_sclk_sel,
>> +     &tdmout_c_sclk_sel,
>> +     &tdmin_a_sclk_pre_en,
>> +     &tdmin_b_sclk_pre_en,
>> +     &tdmin_c_sclk_pre_en,
>> +     &tdmin_lb_sclk_pre_en,
>> +     &tdmout_a_sclk_pre_en,
>> +     &tdmout_b_sclk_pre_en,
>> +     &tdmout_c_sclk_pre_en,
>> +     &tdmin_a_sclk_post_en,
>> +     &tdmin_b_sclk_post_en,
>> +     &tdmin_c_sclk_post_en,
>> +     &tdmin_lb_sclk_post_en,
>> +     &tdmout_a_sclk_post_en,
>> +     &tdmout_b_sclk_post_en,
>> +     &tdmout_c_sclk_post_en,
>> +     &tdmin_a_sclk,
>> +     &tdmin_b_sclk,
>> +     &tdmin_c_sclk,
>> +     &tdmin_lb_sclk,
>> +     &g12a_tdmout_a_sclk,
>> +     &g12a_tdmout_b_sclk,
>> +     &g12a_tdmout_c_sclk,
>> +     &tdmin_a_lrclk,
>> +     &tdmin_b_lrclk,
>> +     &tdmin_c_lrclk,
>> +     &tdmin_lb_lrclk,
>> +     &tdmout_a_lrclk,
>> +     &tdmout_b_lrclk,
>> +     &tdmout_c_lrclk,
>> +     &spdifout_b_clk_sel,
>> +     &spdifout_b_clk_div,
>> +     &spdifout_b_clk,
>> +     &s4_tdm_mclk_pad_0,
>> +     &s4_tdm_mclk_pad_1,
>> +     &s4_tdm_lrclk_pad_0,
>> +     &s4_tdm_lrclk_pad_1,
>> +     &s4_tdm_lrclk_pad_2,
>> +     &s4_tdm_sclk_pad_0,
>> +     &s4_tdm_sclk_pad_1,
>> +     &s4_tdm_sclk_pad_2,
>> +     &sm1_aud_top,
>> +     &toram,
>> +     &eqdrc,
>> +     &resample_b,
>> +     &tovad,
>> +     &locker,
>> +     &spdifin_lb,
>> +     &frddr_d,
>> +     &toddr_d,
>> +     &loopback_b,
>> +     &sm1_clk81_en,
>> +     &sm1_sysclk_a_div,
>> +     &sm1_sysclk_a_en,
>> +     &sm1_sysclk_b_div,
>> +     &sm1_sysclk_b_en,
>> +     &earcrx,
>> +     &sm1_earcrx_cmdc_clk_sel,
>> +     &sm1_earcrx_cmdc_clk_div,
>> +     &sm1_earcrx_cmdc_clk,
>> +     &sm1_earcrx_dmac_clk_sel,
>> +     &sm1_earcrx_dmac_clk_div,
>> +     &sm1_earcrx_dmac_clk,
>> +     &s4_tdm_mclk_pad0_sel,
>> +     &s4_tdm_mclk_pad1_sel,
>> +     &s4_tdm_mclk_pad0_div,
>> +     &s4_tdm_mclk_pad1_div,
>> +     &s4_tdm_mclk_pad_2,
>> +     &s4_tdm_mclk_pad2_sel,
>> +     &s4_tdm_mclk_pad2_div,
>> +     &s4_tdm_sclk_pad_3,
>> +     &s4_tdm_sclk_pad_4,
>> +     &s4_tdm_lrclk_pad_3,
>> +     &s4_tdm_lrclk_pad_4,
>> +};
>> +
>>   struct axg_audio_reset_data {
>>        struct reset_controller_dev rstc;
>>        struct regmap *map;
>> @@ -1822,7 +2214,6 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
>>                        continue;
>>
>>                name = hw->init->name;
>> -
>>                ret = devm_clk_hw_register(dev, hw);
>>                if (ret) {
>>                        dev_err(dev, "failed to register clock %s\n", name);
>> @@ -1886,6 +2277,18 @@ static const struct audioclk_data sm1_audioclk_data = {
>>        .max_register = AUDIO_EARCRX_DMAC_CLK_CTRL,
>>   };
>>
>> +static const struct audioclk_data s4_audioclk_data = {
>> +     .regmap_clks = s4_clk_regmaps,
>> +     .regmap_clk_num = ARRAY_SIZE(s4_clk_regmaps),
>> +     .hw_clks = {
>> +             .hws = s4_audio_hw_clks,
>> +             .num = ARRAY_SIZE(s4_audio_hw_clks),
>> +     },
>> +     .reset_offset = AUDIO_SM1_SW_RESET0,
>> +     .reset_num = 39,
>> +     .max_register = AUDIO_S4_SCLK_PAD_CTRL1,
>> +};
>> +
>>   static const struct of_device_id clkc_match_table[] = {
>>        {
>>                .compatible = "amlogic,axg-audio-clkc",
>> @@ -1896,7 +2299,10 @@ static const struct of_device_id clkc_match_table[] = {
>>        }, {
>>                .compatible = "amlogic,sm1-audio-clkc",
>>                .data = &sm1_audioclk_data
>> -     }, {}
>> +     }, {
>> +             .compatible = "amlogic,s4-audio-clkc",
>> +             .data = &s4_audioclk_data
>> +     }, { }
>>   };
>>   MODULE_DEVICE_TABLE(of, clkc_match_table);
>>
>> diff --git a/drivers/clk/meson/axg-audio.h b/drivers/clk/meson/axg-audio.h
>> index 9e7765b630c96a8029140539ffda789b7db5277a..2dd1c41d775da8f91ed281470d06e9c970cfc92c 100644
>> --- a/drivers/clk/meson/axg-audio.h
>> +++ b/drivers/clk/meson/axg-audio.h
>> @@ -66,5 +66,9 @@
>>   #define AUDIO_CLK81_EN               0x034
>>   #define AUDIO_EARCRX_CMDC_CLK_CTRL   0x0D0
>>   #define AUDIO_EARCRX_DMAC_CLK_CTRL   0x0D4
> Judging by the DT posted, there is plenty in between of non-clock
> component in between these 2 offsets/regions
>
>> +#define AUDIO_S4_MCLK_PAD_CTRL0 0xE80
>> +#define AUDIO_S4_MCLK_PAD_CTRL1 0xE84
>> +#define AUDIO_S4_SCLK_PAD_CTRL0 0xE88
>> +#define AUDIO_S4_SCLK_PAD_CTRL1 0xE8C
>>
> ... and this is not even mapped by the clock controller, so this won't
> work with the DT you have posted.

Hi, Jerome

thanks, I will recheck the register offset regmap, some register is  
really not friendly enough,

so the software may need to change a lot in order to be compatible

>
>>   #endif /*__AXG_AUDIO_CLKC_H */
> --
> Jerome

