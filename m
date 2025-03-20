Return-Path: <linux-kernel+bounces-569368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EEAA6A1F8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66AC01895364
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F642206A9;
	Thu, 20 Mar 2025 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="K5/LKNnV"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2094.outbound.protection.outlook.com [40.107.255.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF65F213245;
	Thu, 20 Mar 2025 08:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742461185; cv=fail; b=QmF/qHz6PoTBaw5hj0il6ZQ+e0/J1XgtR+vJzH6GDJVIC1NUR9VLmXGtKpLVxkcIoUwyJANBtCOb8eNQZLXCqIduDO236L9OXAC95u0IIvpY5KOHZiYJc3FoYb4hjrFSVLBCYKHuJBHbFNGgshATH0MHbbSz0G606ZqhmF/Wo3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742461185; c=relaxed/simple;
	bh=DC168nbeaGudpjSpQx8f0HmgYMjkl1C0+x2nTRK4GjA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o31j0yNTjTTnA0BI6coIRwLF4Sj6ljnotevB/jvzO2BYfjptX+hb5T6NSZoO29IdfZIMRj2+bHwgMgZka+SnAKFi+9x5c31L/8E2uiNAtgKludDVUDK40sPwG/q8Vae/SHNRBiskLVhbQ2NhFtzStckjH8jCua2RuYyA+vaP6Bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=K5/LKNnV; arc=fail smtp.client-ip=40.107.255.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/zPvZWNQ3WyQsoftkAZtJy2NYEXf+pNvjMhcgs8xg+2X9e1mlKmvYPxpmdKHpsPaIYeAuO6yvq5LbzM0G9bjF/7BZNySI1h8DQtvXAozDyDWNnQLP5+PtPHQHcibeBSHZ/LiNx6AiLYg//BufIIi+Z0BJSBwhPr05bBXM/EnpVG596yPAX+GNaVyOI5u91qWVXPjVCiTDeHROArL+ZtsZyroilKX9lAA/dvFqSHjwv47BmUN5ZrXIDsej5Vr4FXFAwW9cvLGLMvex6emG2FArm+jmazZ+EuE3iQ9yoDqy0aXXLRt6zu6wZlUClTuvQB2VJKOjr3M8T0lA90KAFaxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djwlAFvkSSZdPImsYEzo5uRS5ld9Ui+AhF0yH81xsWo=;
 b=NMtSKNMhMFIj0j1LcmNqfBjZqp5K21mW9LAhgXiAJyFV0jJl08wKny6Um8C4qRAVpb/4Yafy/W2rrFVjzNRHUVrJZ2D9pqJSdaclli54IelSOKTjr5I2ZFyUAy+Y5asfSKcWDfLwWTrgMK1Plj+2ZOAo13vNKVYTHwJ+uYiDlt+Xa3IVHxxuMkzWGny32gbz75FV2hCrMqxQix/DCI+pCNK6Ju1/oi340okyIP4vMVqWUCdEskd8EvF+MiNjysdR1in1lv+tZOhv2Ku6bhFQLHnbsdS0wJvhrrad0wy4P2n0XEaG9iedPi+cwWbAt/FQ+UzDRhhXh0cVx9HbT/ZklA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djwlAFvkSSZdPImsYEzo5uRS5ld9Ui+AhF0yH81xsWo=;
 b=K5/LKNnVClN0pFOkSoppcVHm+56Ai2h6MNGXZxlTpA3iylytFhYrUD+P1cQLamqyppN9bCDBuFfY2birZNRjLE/IeWJ95dMdro8Km0rGNN93kLM55B8//T0Yx6LO4ri+cfLF8tkT8zHRpAR+mz9dThmNI6by7Dj8pQot1udVot9z9Jvdoo+QYRlxspF83WKCWraepvFnUNqImFvx7ZACLRgyO9CDKlewy4lYiwJJXA+WVSsaBKW/3QqKreGPOWK/oNvoRaWnAEI6S7EB0noSt56N5Mew+bh0SG+yVDTAXOQhKaeWcyBYLxqDObv5a4ftELLcEXTSneKTeKCABI6rKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PUZPR03MB7135.apcprd03.prod.outlook.com (2603:1096:301:113::15)
 by TYZPR03MB6446.apcprd03.prod.outlook.com (2603:1096:400:1cd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 08:59:36 +0000
Received: from PUZPR03MB7135.apcprd03.prod.outlook.com
 ([fe80::ecac:a387:36d8:144d]) by PUZPR03MB7135.apcprd03.prod.outlook.com
 ([fe80::ecac:a387:36d8:144d%7]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 08:59:36 +0000
Message-ID: <c3acf2bb-c067-41d8-982c-4cdbafb86944@amlogic.com>
Date: Thu, 20 Mar 2025 16:59:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] clk: meson: axg-audio: Add the mclk pad div for s4
 chip
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
References: <20250319-audio_drvier-v4-0-686867fad719@amlogic.com>
 <20250319-audio_drvier-v4-5-686867fad719@amlogic.com>
 <1jldt02iv4.fsf@starbuckisacylon.baylibre.com>
From: Jiebing Chen <jiebing.chen@amlogic.com>
In-Reply-To: <1jldt02iv4.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0102.apcprd03.prod.outlook.com
 (2603:1096:4:7c::30) To PUZPR03MB7135.apcprd03.prod.outlook.com
 (2603:1096:301:113::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR03MB7135:EE_|TYZPR03MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: aff4b2e9-f066-4dda-6194-08dd678d89f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUN3WjltamdrMGFCRFpsd0E4WmVvaUE1ZHB0eENVYWhzSjJobDljRFo0NVZy?=
 =?utf-8?B?V0crYldBYmk1ekNST2xzYlJQbU43WDVFWGQ1N0FCTDhMTG5vd2VjbTRPZWpZ?=
 =?utf-8?B?S1hodnp1MWdPMTY2cy9SSi9nL1A2cExlcVQzbFlIRWRmVDYzejNvMDlBNzNu?=
 =?utf-8?B?TGF1TURlMFlXOHRaQlZPRG9VZElSc0oxd2FKMmJsYWpYMlgrcFVTOTF5dUlo?=
 =?utf-8?B?NFNjQytoYUFGZW9HNUN0SHZ2cTBqMUlQLzdRVmpwcG5ETFRHVlRhYzhtdVhT?=
 =?utf-8?B?OHY4WUFvMTN3VDRHMWFtaGtubjh4RlN3U3lJaDFjTHVyN2FBdjhkN3lneGNk?=
 =?utf-8?B?cUtsSFV2ZER2OXRQRktoOC9LeFAzdUpERFBlcmV1T2NwRENYRWxSOXdhbnlT?=
 =?utf-8?B?NWh1QVV4V1p0Y0w0S0Z2K2ZrYXE4YkovbXdyNFFpalZPTjI0ZkExQTBxWUtJ?=
 =?utf-8?B?NFprVUIzR0lSOFdva3lzQ1JsbDA3N0c3cjRqeitxQ1BMWDVLa0NPNmMxeEEy?=
 =?utf-8?B?QnBMRzlvSUFQU2hMdTFaV0ZDdDdINDRTalpyVlJHVGdNcHl2Nk5XaVUxeTBp?=
 =?utf-8?B?MmFJWm82TXpsUDZuSU1vNml6TW1UaDZBQ1dSSm1tTU85d2xOOFo1MVJTUFNh?=
 =?utf-8?B?bVhzWVJoODB5akJBNjVQaVh2T2NTdHVOMk83b1lhQkJUVDVSdnpNZ290ODY3?=
 =?utf-8?B?MVdvempjVFdReWc1ekZrNEFZWkVJQ2FjQmY1Sk5USU1rZVdidlA1TVhaSzI4?=
 =?utf-8?B?MS9Yd0thbHdobGVhZU0rcHd3OUxvQlRQRnczN1FCVDdhNllmQ1RXUGNSMTky?=
 =?utf-8?B?QjB0V3d5UmJ2UGE3S0FnTjcrMTJXRVF1YlFJWjB2dGJLNldLZmcyMlplWDhx?=
 =?utf-8?B?TVVTcVBSb2lSRy9qZ0tBWnlYS2hHY2JGYms3cWduL2E4MU5HNmhGQkVFMkJN?=
 =?utf-8?B?VVRDUE9VTXBhRzRrd1hQZWZKRVFaUmFoR2ZVVXZ1RWE5TktwTmtFWVNDZ0hj?=
 =?utf-8?B?Z2ZlZ0RkWCtSYkhZODFnS3dWd0RVQ3dsMlVVZ2E2aTZuMHNGWEp4a3dnZzVk?=
 =?utf-8?B?S21EMEhjcnYvTjJtWHlMNDFxeDVRdWVwTTZEcTRNYXlwa2ZwaFdUSFRuelEr?=
 =?utf-8?B?ZmxGc2pvbGZ4aFNoZVdYK1J1aEhodDZYL3RiRU5zK0w3bm9oK0E0NU9XUVRu?=
 =?utf-8?B?bmNKcTdERjBpU1hQTG41RnNPL01nNXA2RWxpL1dxV25vZEg1WE85RW00aGlW?=
 =?utf-8?B?VXBhQzRTT0tJSVppN1k5eTRKYTFSY1lJdUphUDh1UEFpb01Cd0V0RHhWRWxx?=
 =?utf-8?B?eDFzbDNnZjB2L2VHTW4wNCtQaWFWOXNieGFTTjdSbHZWTWgvWXE4Qk5NVlNj?=
 =?utf-8?B?cDRMVmw2aFR1NUV0eWRzSGNjS2lvczE3dGJSR1dVb0RFT1dKUTlPeUE4UFNm?=
 =?utf-8?B?TEZrVWh5RGhDNTJRaGxTL3RqbmtvZXVoVkRmcU9IbEg5SzFhRHRQOWg0TjRy?=
 =?utf-8?B?SDJlTWdvNTNIdXBkMXlSbDlFTEdWdEpoaUFieEpYY2QzT2tkRlhLODFickdj?=
 =?utf-8?B?VjgzYlAvejBuZmdGb0t1VmRyUDFYQkJHSGtkOFR5Z3NYUWZ5Sml4N1BzOVVS?=
 =?utf-8?B?NUdHWnBEd1pvcXloZ3pwcnF4NE9LcGV2U0pXTnlvenNVaWl2MXcwNGVVeVl5?=
 =?utf-8?B?eFNqOUw4RlZKTEhqZ1JacFd3dG92UDFVK1M4c2p1MEVnY2ZxUW45cDlIcklt?=
 =?utf-8?B?UjZmSkxpbG9tVVpZSS9XTWtyS25zNDBuZnU5T1FibUlCSTU4ejhPYVhzL0RL?=
 =?utf-8?B?TEtnUHZmSVJZa1orek5YRnBjdjk5Wk92YzN2QTRrdXpHWGhxdDlsRzZNTWM1?=
 =?utf-8?Q?w76bQzGtLu4XA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB7135.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWVMSmNmUHo5dVcrN1NtZG9PSUtmejlKa0d1MzFSekVEOXd6ckZQU3BvVWI3?=
 =?utf-8?B?MkYxODhGNkdKVkNITk83TUhPbHR3NExHY0dtK2lqN3dtazJiS2FsWkJlbElt?=
 =?utf-8?B?YldWdmdNcSsvMWlCTE1kdmY3N2l4YTVKSFBTVDNHYzlpSm1HeXI2RE02eUFk?=
 =?utf-8?B?d3A5TnhkakZvL0xSSHlQdXBvN1BFQ2FLOHpHWmVPUVFucGtGV3NxeU5DTXFx?=
 =?utf-8?B?V0tKd0hsSGRDOHpvOXhlQWJTc0JEaXU3N0FLODJ4dXJxcjd5Y0ZpaTF6eEdj?=
 =?utf-8?B?ZWEwZld2czU4b1ZqS3JTWXd5dDlWTWRDNWRkaGIvdzlRQnhLcXdxaHovNHY3?=
 =?utf-8?B?Tm1KUkFhUWI0L1JJL0JBMUk3QldwbDVvbElVdnA3TGp5NGdCajFXcktaNVJv?=
 =?utf-8?B?eWNwcCt1Tk1oQnhNN0YvVUtua0VxSXZ3djhManlXL2dESC9OaStUZGZWODAv?=
 =?utf-8?B?a3RRRzNoYkpnSmRQZGRqVmRvalFSQm5hZUM1VlRXc2RRV3YwOXIrL3dDUHFU?=
 =?utf-8?B?ekhHWkxpcU02UXJHWm1nazM3ODZ2cllRaDdhc01EWFkydU5mVjI0OE14Vm9n?=
 =?utf-8?B?ZjNzOE55dTN6ME5yaTZOanBBMTF4eURwNnd4S3ZPRjRMRGRJMkZTZFJNUlNX?=
 =?utf-8?B?bXpReEU1cVpKc29iQzVLdXFzdkwvTUlWUzZ0RFB2VHROMjcxcU5nZnhzMitp?=
 =?utf-8?B?ZW5ZUUlJQ00yRTBpdFB4elBPdHNTK0NTclI1NHB1M29VMU13bkVrYnhKbnY4?=
 =?utf-8?B?bXZJSmt5RFZzOGpmMWJWWi9vNCtmenN5UjZlNzJEVE0zckRWU3puZkZUelRn?=
 =?utf-8?B?SEdOMHVTL2I2QXJGMVZ4WExML0FwS2JOWnpnUjd0RzNJNnp1WnVkdXRpMEhB?=
 =?utf-8?B?T2NEZDU1bGtzTXUrYVhwUFpLWXBLdDJmNWp4My82dUhMTFNDYUZWRms5ZTNJ?=
 =?utf-8?B?NUJaVUtLWStOdytMYmx1WE4vY0dwN3hCV3RXMHVtOXFVSWVtQUtHR2RwMGNq?=
 =?utf-8?B?UHM4QVdaMzlnVFMwWjErNWNDalRaQ0xVcUxnV0IxV2h1ZkQ0SzkzYUl6VXpY?=
 =?utf-8?B?bEZoSC9hY2gyeERPK05yYU5GWmV1NjRuYnBGZXVVMUdkSVQ2ZXlyNVpOdzND?=
 =?utf-8?B?UGQ1dmZXVHQ2VmViVHZNcUM2SzdPVWtPM2dmdDVWVWxncVJjSGFOYnFlcGhD?=
 =?utf-8?B?YWovOTNyNUtjRkpza2FYVit4MTVpNzFnS0ZzWUllZUswZzE4YlZ3cm1Ed0hp?=
 =?utf-8?B?Y3BYelJ4N1phekJmY3FhbGhoL1ZvK25yZW1UTHBRY0dnVTBLcTljZWNiSG0y?=
 =?utf-8?B?YTRlVUx1SGtrZUozR3NZdjJqN0duWktoN0xaQ2w4ZW45T2QvYWhOdVU1aloz?=
 =?utf-8?B?ckZpZTFJN2IrMnROdXhEdzNpcXJLRUdUUWg1N1pBZVU2SXNSelFIekdOekNO?=
 =?utf-8?B?a3VKckROejIwWTM5MEtzcCtwblpTWHZpOVg3d29zZ2czamozaU5QbzhqNlE5?=
 =?utf-8?B?RG1qdHNlVlgyS2p3MFV2Z0dsdW1TNjRIQWRoeENjRXlsUXNQNFlrWTFPVkFn?=
 =?utf-8?B?MzloRnUvZ2UyUlJjamRRUlBFSGRkbklJaDAwcFVaUmQvRW9WL0tZTGEycTY1?=
 =?utf-8?B?ODF3b2ZQVFdZS21lSzJSdHU3YUJINGdmSTYzWWNJRXVPRU1aZ2s5WDNMbytG?=
 =?utf-8?B?cEZ6SkR2K0JTVDR1bkt3Z3NuOGVaV1NwNmNmYzd3V0ppTTFWUTJyRkRrT1py?=
 =?utf-8?B?Z3RQbytPemdrMmVuYjkzcGlRby9INlQ4S3RjRDREY2JUTnlSRmRzeHFKK29v?=
 =?utf-8?B?N2NUWS80OUMxQmJLakR3SFpWb0RwbE9OYkd3Qkp3T0FYNG1IaTVFQlE5WE5w?=
 =?utf-8?B?TG1Ic2JiNDVDNHRYc2lFdkVrZkNEdmROT3VDeXRwcWtQY2c2clZOcit2MTF2?=
 =?utf-8?B?NVB1aUZKRTNLT2t4Wk1nTXU5d0xWVE94cnZJOFpvMlYwclZrbGxDQW1EQUVE?=
 =?utf-8?B?RFhXeFNwckpMd2IwM0svV0xrSVBCdmIxOU1FSTA1T0ZsN1NQN1F0NENuNFBo?=
 =?utf-8?B?ZDN0dXNoampCc1dnMHcwRUZJQVpLQ1pxSWNoVjhGTXdzOVM5WTlHN0J5SjVF?=
 =?utf-8?B?UVFDZlpaK3R6MGh2dEx1NWQ3RVYzUkRtUitKb3YrWVFoQmpoT1J2VWxJOVlB?=
 =?utf-8?B?VlE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff4b2e9-f066-4dda-6194-08dd678d89f1
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB7135.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 08:59:36.2206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3pcnmq5zJg6kTbONoxkPIQ5eUw5vU4AyrFvSCZi3Q29HBDlRvgsRm/zWdLmXKWA6MiabaatHJm1eO7vh9dAJFVvKq1DOfFKVX+tKo6zuTUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6446


在 2025/3/20 16:42, Jerome Brunet 写道:
> [ EXTERNAL EMAIL ]
>
> On Wed 19 Mar 2025 at 15:04, jiebing chen via B4 Relay <devnull+jiebing.chen.amlogic.com@kernel.org> wrote:
>
>> From: jiebing chen <jiebing.chen@amlogic.com>
>>
>> Add mclk pad div support, Increased the number of lrclk
>> and sclk pads to five
>>
>> Signed-off-by: jiebing chen <jiebing.chen@amlogic.com>
>> ---
>>   drivers/clk/meson/axg-audio.c | 441 +++++++++++++++++++++++++++++++++++++++++-
>>   drivers/clk/meson/axg-audio.h |   6 +
>>   2 files changed, 445 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
>> index 9df627b142f89788966ede0262aaaf39e13f0b49..50e7c78ddb98ee08121690633c8113489503bc04 100644
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
>> @@ -1678,6 +1902,177 @@ static struct clk_regmap *const sm1_clk_regmaps[] = {
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
>> +};
>> +
>> +static struct clk_regmap *const s4_clk_pad_regmaps[] = {
>> +     &s4_tdm_mclk_pad_0,
>> +     &s4_tdm_mclk_pad_1,
>> +     &s4_tdm_mclk_pad_2,
>> +     &s4_tdm_lrclk_pad_0,
>> +     &s4_tdm_lrclk_pad_1,
>> +     &s4_tdm_lrclk_pad_2,
>> +     &s4_tdm_lrclk_pad_3,
>> +     &s4_tdm_lrclk_pad_4,
>> +     &s4_tdm_sclk_pad_0,
>> +     &s4_tdm_sclk_pad_1,
>> +     &s4_tdm_sclk_pad_2,
>> +     &s4_tdm_sclk_pad_3,
>> +     &s4_tdm_sclk_pad_4,
>> +     &s4_tdm_mclk_pad0_sel,
>> +     &s4_tdm_mclk_pad1_sel,
>> +     &s4_tdm_mclk_pad0_div,
>> +     &s4_tdm_mclk_pad1_div,
>> +     &s4_tdm_mclk_pad2_sel,
>> +     &s4_tdm_mclk_pad2_div,
>> +};
>> +
>>   struct axg_audio_reset_data {
>>        struct reset_controller_dev rstc;
>>        struct regmap *map;
>> @@ -1764,13 +2159,20 @@ static struct regmap_config axg_audio_regmap_cfg = {
>>
>>   struct audioclk_data {
>>        struct clk_regmap *const *regmap_clks;
>> +     struct clk_regmap *const *regmap_clks_pads;
>>        unsigned int regmap_clk_num;
>> +     unsigned int regmap_clk_pads_num;
>>        struct meson_clk_hw_data hw_clks;
>>        unsigned int reset_offset;
>>        unsigned int reset_num;
>>        unsigned int max_register;
>>   };
>>
>> +static int audio_clock_pad_is_new_regmap(struct device_node *np)
>> +{
>> +     return of_device_is_compatible(np, "amlogic,s4-audio-clkc");
>> +}
>> +
>>   static int axg_audio_clkc_probe(struct platform_device *pdev)
>>   {
>>        struct device *dev = &pdev->dev;
>> @@ -1812,6 +2214,25 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
>>        for (i = 0; i < data->regmap_clk_num; i++)
>>                data->regmap_clks[i]->map = map;
>>
>> +     /* some amlogic chip clock pad reg domian is different */
>> +     if (audio_clock_pad_is_new_regmap(dev->of_node)) {
>> +             struct resource *res;
>> +             static const struct regmap_config aud_regmap_config = {
>> +                     .reg_bits = 32,
>> +                     .val_bits = 32,
>> +                     .reg_stride = 4,
>> +             };
>> +             regs = devm_platform_get_and_ioremap_resource(pdev, 1, &res);
>> +             if (IS_ERR(regs))
>> +                     return PTR_ERR(regs);
>> +             aud_regmap_config.max_register = resource_size(res) - 4;
>> +             aud_regmap_config.name =
>> +                     devm_kasprintf(dev, GFP_KERNEL, "%s-%s", dev->of_node->name, "pads");
>> +             map = devm_regmap_init_mmio(dev, regs, &aud_regmap_config);
>> +             /* Populate clk pad regmap for the regmap backed clocks */
>> +             for (i = 0; i < data->regmap_clk_pads_num; i++)
>> +                     data->regmap_clks_pads[i]->map = map;
>> +     }
> This adds complexity for no good reason.
> Deal with pad clock in a distinct controller

this is a good idea, we only add a new clock pad distinct controller in 
dts, thanks

>
>
>>        /* Take care to skip the registered input clocks */
>>        for (i = AUD_CLKID_DDR_ARB; i < data->hw_clks.num; i++) {
>>                const char *name;
>> @@ -1822,7 +2243,6 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
>>                        continue;
>>
>>                name = hw->init->name;
>> -
>>                ret = devm_clk_hw_register(dev, hw);
>>                if (ret) {
>>                        dev_err(dev, "failed to register clock %s\n", name);
>> @@ -1886,6 +2306,20 @@ static const struct audioclk_data sm1_audioclk_data = {
>>        .max_register = AUDIO_EARCRX_DMAC_CLK_CTRL,
>>   };
>>
>> +static const struct audioclk_data s4_audioclk_data = {
>> +     .regmap_clks = s4_clk_regmaps,
>> +     .regmap_clk_num = ARRAY_SIZE(s4_clk_regmaps),
>> +     .regmap_clks_pads = s4_clk_pad_regmaps,
>> +     .regmap_clk_pads_num = ARRAY_SIZE(s4_clk_pad_regmaps),
>> +     .hw_clks = {
>> +             .hws = s4_audio_hw_clks,
>> +             .num = ARRAY_SIZE(s4_audio_hw_clks),
>> +     },
>> +     .reset_offset = AUDIO_SM1_SW_RESET0,
>> +     .reset_num = 39,
>> +     .max_register = AUDIO_EARCRX_DMAC_CLK_CTRL,
>> +};
>> +
>>   static const struct of_device_id clkc_match_table[] = {
>>        {
>>                .compatible = "amlogic,axg-audio-clkc",
>> @@ -1896,7 +2330,10 @@ static const struct of_device_id clkc_match_table[] = {
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
>> index 9e7765b630c96a8029140539ffda789b7db5277a..24233c40171034eba86c699db0200f07555926af 100644
>> --- a/drivers/clk/meson/axg-audio.h
>> +++ b/drivers/clk/meson/axg-audio.h
>> @@ -67,4 +67,10 @@
>>   #define AUDIO_EARCRX_CMDC_CLK_CTRL   0x0D0
>>   #define AUDIO_EARCRX_DMAC_CLK_CTRL   0x0D4
>>
>> +/* s4 clock pads use new reg base */
>> +#define AUDIO_S4_MCLK_PAD_CTRL0 0x0
>> +#define AUDIO_S4_MCLK_PAD_CTRL1 0x4
>> +#define AUDIO_S4_SCLK_PAD_CTRL0 0x8
>> +#define AUDIO_S4_SCLK_PAD_CTRL1 0xC
>> +
>>   #endif /*__AXG_AUDIO_CLKC_H */
> --
> Jerome

