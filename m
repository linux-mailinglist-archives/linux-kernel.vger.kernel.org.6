Return-Path: <linux-kernel+bounces-511054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7965EA32524
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AF8B1632E9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E08820ADC7;
	Wed, 12 Feb 2025 11:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L+/f0VfB"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2042.outbound.protection.outlook.com [40.107.241.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9564207DE3;
	Wed, 12 Feb 2025 11:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739360301; cv=fail; b=FBpFQsuUx83ny3sjraLan95m6WJy21rAFqpYqKkpzh1AoDX6EGmokCO80Q2O4E3uvXfKHFDxCepA7q3e9Q01YJPfB0MIgt/6M2wdVdb6a1TNIASK8QwaHgVvzO9Od0FY259LCkQkLc6amzWW4beDzjCRlvo7ASakUB/pwvLsMD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739360301; c=relaxed/simple;
	bh=h2lVmBV/supNWIq36kxp13aZ5H094SCAf5NZ58AacOI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aG8HqhtLtf/xfrauQPmzzOd6HNHR7x79Vnxqq7FFlItlRW2k1YVZVWw4uCyM0+CvSM8RxfyCW0/s0zUFDKg8IAt0SMa/Dut3gUZtwh48ELy2/yjyCaBdgCpNp9SjkNGwuf0Vew8JRKKkEVtYXxfXUwACNjuVTnL5v8GUKhfTHAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L+/f0VfB; arc=fail smtp.client-ip=40.107.241.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WyOjhlAerYG7rhKkJpGO3ZDP1EedpE7PpNfWbxJ2qvbLfOUSST9q1/5257hCbakuPqsp6nu8qlYsJWA79wr6KAcUyBLbyHjZO5nYgBJAU/5pmo6+Gy0xNpo1IAUhMFrCcGIwrxL4G1AqG9CZYECgNTT6tt7HjfblRpyUdwl79+1Jh9Fh6oydKPwr2+Y3OYiPxq9Q2oLA9wIY0INb+3SvjoQTWVaxAHWoovMEIjhnTndjT+31MDAjd81RUiKLirEpqFgg1Phka7w1e4Im17x5B5aO1BkWUKh/c1ltdS7GqmowtUYBskWJ+0fVjBDa2SS27as1n/tDyLKClWXLSRRbhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ll5Ig1TdUUDqDmZbNuGZMueasdJsZ4VGWaFjht8Fws=;
 b=Gv7Gpim5cwAt3e78Lpu4R/KBWBxl0YGKdWp0VJF61UlFzeDmoRD0iygZmZbQVAo9hyNOEVjX8pOKGN2znIIjzJ9/5gvDAmbwtHvWSeCi90eFKQsxyMe+tEx/hgOOTD44X9QbyPw/AWqICglGJZLDpxqgfUa77dVxGP70T+mRtlG0jVl05/nWYzo99OPgoCCtacFWdn7ew/1k87k5ZjiawuBiIPCdgQN4olWxDInwZQ+kg7kulioOlMXvEfViB4tBsfr0HJh48Q9mIr8O/0j9nseFLbcrWHrNpw0Su+rml6NAzUeVEbR89GEAArX5UbCXWfd50AylNBX0vTdW8LcwWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ll5Ig1TdUUDqDmZbNuGZMueasdJsZ4VGWaFjht8Fws=;
 b=L+/f0VfBfVy3KXjhdPHdeg4r+BniGNq+j2BXWgnmpCwCv4WGRi64pQiTrUAfpPysvU3vGSbNPT/P0B3YZNQ/A//UHifYFKMQlRIPwfuHsSRI9thZJ778L4KZXIvLxMG1xKkWqaMNcg8TSbtQ+0j2oS+E+/FwmiuofzaJdWY2orA62t9yQtofS564pB+f0j9rmthCw9Xc+nSROCK3t8hmp18qF3FIdze/6EErUlwI/jyjV1KFb8gT1VUihPBQKveWdpWCKalribzFjII35FmXgZA9DeuiYKSo8gwowAv+o1sqsBOnIHYXAAJDknrUhjWDgeD28LNiQe5wDA+g9IgiWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by PAXPR04MB9680.eurprd04.prod.outlook.com (2603:10a6:102:23e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 11:38:15 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::88b8:8584:24dc:e2a1]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::88b8:8584:24dc:e2a1%7]) with mapi id 15.20.8445.011; Wed, 12 Feb 2025
 11:38:15 +0000
Message-ID: <0bba6e5a-a073-688a-003a-dbbf89888886@nxp.com>
Date: Wed, 12 Feb 2025 13:38:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 0/3] add sof support on imx95
Content-Language: en-US
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20250211225808.3050-1-laurentiumihalcea111@gmail.com>
From: Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <20250211225808.3050-1-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P189CA0030.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::35) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_|PAXPR04MB9680:EE_
X-MS-Office365-Filtering-Correlation-Id: e19b2bb5-1f41-4dba-3915-08dd4b59bcea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGVZSGc1NzRLT3Q5QlpQdUY4THZpNjlaR0tuUEptSGI1L09CWTVNUEdscWZM?=
 =?utf-8?B?dStaYm94cXRUdnNqb1RaK1VNL1F0REhGaXpKbzhYdW1xSEdCVWY1eW5DVXNG?=
 =?utf-8?B?MDhscUZrUlRodkkrVVlJeHYyTzJ4TVV4VWVNRGliaEYrVWJKOEdpanRBL21a?=
 =?utf-8?B?TmE2bmw5NnE0aEw0VnIzbmJNZHlYRmF0aDh0MmZyMloxb2JtdDRySEZuYnd3?=
 =?utf-8?B?L1QwTE51bDZqRGtiQlp2azM3NXltMEErZ3Q4YjdaRlNBS0xEL3M3MFFmVytG?=
 =?utf-8?B?R05wcTRpRW5GRTVaMjhSQ28xcG9tNHhRYnpqeW9Xb2tmSEowT3VUNmExNUQ1?=
 =?utf-8?B?YjFMSHdRd21xYlg2TklURGRhRXZTVkI2S05EUUhodWhLLzZGY01ZS1c2cjJo?=
 =?utf-8?B?M0JkV3lvTU5GVlZiMHgzcCtPV3dqNjZWNGJtZ00wWFVUcFMrck9wM014bFZm?=
 =?utf-8?B?K0RycldPWlcvOWRHSGJCV1l6Z0FIdWxhQ0FYazFuUHlQakVSREZxczhvWWNC?=
 =?utf-8?B?OFRDUERETSt3MHBCdk96eDBJQWFNNktxMWt5MFZXQzJuNWRVMVZDTnhVQldV?=
 =?utf-8?B?cHdTWGdPSlJaeVFqakt0ZG9ScDlZVExva1RKdG9nMDRXSFVJVXBRb1RacGtm?=
 =?utf-8?B?K1dFVk5qc1RCemptZmhzaVhDL1htMG85K2Rtd3lVM3JlQkpWRHFaeEdOSW16?=
 =?utf-8?B?cnE5MkduVjhpbm8rMXNjaDdmQmlISHoyRm1KS2xKUURwUy9yN1lYQlV5ZzZL?=
 =?utf-8?B?OHJsdUV0K2M3OXhjZmh3VEZ5RXdmbVFpSENnbXRDVjF6enFPZWFVRXdCTXh0?=
 =?utf-8?B?Ulg0VmIyZzhmNEZJRkhTY0h1M3Q2cTQ4NUFtYW5qMVFHRU92cXVKYXFCWVRn?=
 =?utf-8?B?VWJEalpmcElRaitOQkVJVEQ2NDdzb3pwSVBWL1VsamFwNDlRcW1KcEN2VDJE?=
 =?utf-8?B?ZG9kVFZhanpjeGJoY3Z4VEhmWWRsTldnZjRvVjdsMjlaayt6ZVIvZGdwamsy?=
 =?utf-8?B?ajlCM0dXRnNmb0tFN1kvOVdZNk5Cb0lqczRreUVPaFJtYW0yMTJkeHY3UEJN?=
 =?utf-8?B?dFVBMXBzTzF2aUduUk9RSUUxbjJNOW9hY3pIUm9YelpjNmlJejA5b291T1gw?=
 =?utf-8?B?RU5semZmY0daTnMyTzYzb2hJMXAvejF5UnRjUVZzcmROeDBuM3hMQ3VsQStw?=
 =?utf-8?B?aTFTT0wyNDI3Z2dXNlFwbWJwcEp3bFZVS1A3anVoNmxYeEFGbmw3U0xjRmYw?=
 =?utf-8?B?RklUWDRHVU5wVjc2Z2R1YzljL0NUYS9sU0V6V3RTTUxIcmVSY0t5NkxBNFU0?=
 =?utf-8?B?M21YaVpLZGR3bXJ1eWFHWVJSVmQzTzBneVFyb2VTeEdELzM4UmdaNFpOVkJQ?=
 =?utf-8?B?R3VXdzZUTnArNDFWOHBSLzkrTXRuZlQraSt6M1M0WjdQWjduMHlQa0JNeFBy?=
 =?utf-8?B?T3VDTEJPUzF6dldIYzJlOHg2MTRaOVhtbGtSeHhwWGVCME9mNFY3VFpxQnNm?=
 =?utf-8?B?cFdGMzNGNVc5N3hYZmNRRTlDaDAyNWxDUG4vMkczZ2JxdzlZOWpCOHB4b0Zw?=
 =?utf-8?B?eFN4Zzhnc2FsMzB3Z1V3OGZ3aDVVRm1oMGFvZk94NGJmbkZLeUdhRVlFaU13?=
 =?utf-8?B?ZFdyMkl1M3E4Z0FLM1gzdXpad0ZNbEJhSWlHbVdNektUbFRsT1hrT3ZRREt4?=
 =?utf-8?B?VnoyUkREVzlvMVlydTZDd2xmMmtXemtadHl6UEdNZUJYWkNxNTdQYXBsdHky?=
 =?utf-8?B?b240OFJqMndVWlhWV1I5ekNaa0R4SllnY2tBb1dyWm4zUlYzNGhHZEtyNmZD?=
 =?utf-8?B?QzIzQXN1Z1RzZkRKN2xUOWRvb2lUUjl0RU9NbFRETzlucnZUYlJ4Qmx1c2tu?=
 =?utf-8?Q?1NMjnZwBZQABy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnVPeFh1WTNOSWpoNU04SzZGK3MxTk1iTUR4dWtvWGJMU2Z1b1lnaU1FWTVD?=
 =?utf-8?B?WjkwemR1eHdENnUxR0FUbmtLMlByYW1Sa0JNblZ3NWtiaFNJZ1hqY2ZXa0tJ?=
 =?utf-8?B?c1d1WkQ2VlJVVmpmZXV5WUNUQm5XMmhpRGQ5UnJabFdtOHJwU010L0JXdEc5?=
 =?utf-8?B?V1puSVNtd09obUpnekZPbkdCb3BQd28vMmdKeWJpck1FaUw3c3VOWHdrZEdy?=
 =?utf-8?B?a2ZiU3dOcFBVcDNocWZKU3A1N2RvY3FFOXp4R0lXV1ZOMVN5WmxJTW82dEtL?=
 =?utf-8?B?Y0pzemdjMjNqRlg0S1l6ZERhdlV4a1BXYTc0bW9PWW0yRnlITUFuc3JQNlh4?=
 =?utf-8?B?SlFBc0N0dm5mZlJlUy9vUTFpZ3Q4RkdCZTFYUG5XTU51U1QvMmZrZEcyb3Zx?=
 =?utf-8?B?QldRNm9zbTFNYUljOG1ZZU5yem9WU3lDNzA4WHphSmM1dEtLWVFscTR1ZGF6?=
 =?utf-8?B?NjB2bjRPWkNnK0R4T0ZhdWtCQVhianMwTG9zR3MyaXFiMk50K08xNjZ2VGRh?=
 =?utf-8?B?UUtqNTM3bVNna1lRanNpWUt0MGhYN0Z4cEJNN2hocFVoTHNtckNXb3l5cGhs?=
 =?utf-8?B?Q1VaZnkxQlBRWDBHTGtRZDFDVGdPZ29mSGt6SDE1MW9kSkNac000dkRZRE80?=
 =?utf-8?B?UlhLMVJack4zQ094L1lTZk50c3kxMzc3SFQ3Y2wzWVljRjcyQ0M5MUdYK0xM?=
 =?utf-8?B?bXhoUTB0NnN1ODBzSVlqVXBnK29NU21vVkdvYitxQVpReURHeWRWZ1RIUUox?=
 =?utf-8?B?Q0dHLzVJb1lJWGRXV1NYcXg0K0s1NGY1SEtQbStKeElJeVB3YXdqZU9WOTFt?=
 =?utf-8?B?TzBISUF0cU1WMzhqVk1vSUQrOWZ0ZDlPaVA3ZE9xMDJITGFkQVI5UExDZUFZ?=
 =?utf-8?B?ekJhSDVyaldZbm8zQjdiejMzRFdvRFc1U2JMakcyQVBHdWkxWWxPbWRGTFoz?=
 =?utf-8?B?MDkrdGo5RWhlN09uTkJKR1JFZUJ5NWc4dXZRQi81OWhBOUNiUVNqMWNBN0RW?=
 =?utf-8?B?c2RKaUN6dkgrZmVwd2EwNTdUWU56Z0diVytYMlJGUXZEakpEaGlLYVY5a3dX?=
 =?utf-8?B?OEpSUmNaeDhDNE5uWDlQZnA4dEVKRzNkb2V1ODk4enFXQmk4SjhzdlJzekUy?=
 =?utf-8?B?Q2Q5L3JVRTVhZlRuNHp6WkwzWFlhN0c0THlzYTREUVN6WkR1RU1rM3dxQStZ?=
 =?utf-8?B?Z3B0MXppMHB3VWI5Qm5wQnRLMGhyUm1PdU5tcUJNMG1uN2VNajM2SmFkMWtv?=
 =?utf-8?B?OFpXODZSWXdZTHBFVkwySVpUdjVzVFcyajB3MVFyRXlya1RYVTUzanh5bkNX?=
 =?utf-8?B?ck1BVlkrblhCVU9JM3ZGU2svdk5mT1AwMUI0VWljVEFLdzFhd0ZBcnlaRUtz?=
 =?utf-8?B?UDJmdjdDVUtBT3dOV3JrSEdxQWFRcmpvRzZuN0dmVk53V0dBSzhnaVlHZXJj?=
 =?utf-8?B?b005dDI3cC9Hc0RWSFo4QWthYWNlZ1JtM0t6emhHKytPdHpZYXV5SWY1Y3BP?=
 =?utf-8?B?d25CUy9odjZ2aEdwVE9uMlUvd3krU25rOVg1clFJM0FmamhxUWlneVgyaVRY?=
 =?utf-8?B?VHlxTWxhN0N4R0xyRGErbFJ3aDRpOUxsRHltbUNIWEwycmt0N1RuVXFrZjJZ?=
 =?utf-8?B?QWlKcjh6MmcxNFFNSHIzbjFaaUcyT2tvMW5XQ25ZcjhkUkloem9sMnFubnBl?=
 =?utf-8?B?RkFBMEhVNzlQWUNKN0x6UExZTHZNZGFrczVzeDNKK1Y4NGs4OC8vVTlJQTJD?=
 =?utf-8?B?LzVhazBGcGUxY0ROOGo3dmNIR1pFa0ROVStwT1RqZUFuSlJTeDB0aHZ1YXJz?=
 =?utf-8?B?MlRPYW5Kd0RIcGRPanRSMVdGN2xwZUl0OHZXajdGa0tZYm12SnZEV3VhUEhV?=
 =?utf-8?B?VktYM3NUWVU1YWpoR2ZZM0Y1b1k1aGs2YzFoL2NkditMOWI0d3oxWTRpMFdm?=
 =?utf-8?B?ZG4zM3JCMlVuTWFQZW9Zc09BaFRnekVLajQyOWhGeDZ5Y0hrSVlEZWxJUS9r?=
 =?utf-8?B?ZUh6ZWIxNmswK2dCTDZBWWtDQXVaVTdUK2V2UzB3dWZUaThQOXdBbEp6Mkcy?=
 =?utf-8?B?Z0M5NFdtWE8xeXYreHc4MU5OOTRIeFFUN2tQMGt6Y285VmN0RzJMbmdLeUdU?=
 =?utf-8?Q?FGTDlHAIy65jf8BrNoKMNc9Dl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e19b2bb5-1f41-4dba-3915-08dd4b59bcea
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 11:38:15.2008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1NR5VkCP0is20R91QiPypuDPINQdORvrq99Z8IfV2M2yw9banSY/eBTj/8NUpOO9/OGm0r+b6kS5cnxsbLwznQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9680

On 2/12/2025 12:58 AM, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> Add sof support on imx95. This series also includes some changes to
> the audio-graph-card2 binding required for the support.
For the series:
Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>

Thanks,
Iulia

> ---
> Changes in v4:
> - addressed Frank's comments regarding the DTS.
> - squashed commits for common and imx95 bindings.
> - dropped patch introducing driver. This was already handled via
> https://lore.kernel.org/all/20250207162246.3104-1-laurentiumihalcea111@gmail.com/
> - introduced two new properties: 'reg-names' and 'memory-region-names',
> which are now needed by the driver to work properly. Because of this, 'reg'
> and 'memory-region' properties had to be moved from the common binding as
> 'reg-names' and 'memory-region-names' depend on them (you'd get a failure
> when running the binding check otherwise).
> - added missing 'bitclock-master' and 'frame-master' properties to codec EP.
> - addressed Krzysztof's comments regarding the imx95 binding
> - added Krzysztof's Acked-by
> - Link to v3: https://lore.kernel.org/lkml/20241216145039.3074-1-laurentiumihalcea111@gmail.com/
>
> Changes in v3:
> - Ordered DT nodes alphabetically
> - Removed 'cpu' and 'cpu_ep' labels from binding example
> - Some small changes to the binding commit messages/titles.
> - Link to v2: https://lore.kernel.org/lkml/20241113195240.3699-1-laurentiumihalcea111@gmail.com/
>
> Changes in v2:
> - Added new binding for 95's CM7 core with SOF. fsl,dsp.yaml is no longer used.
> - "hp-det-gpios" and "widgets" properties now reference the definitions from audio-graph.yaml
> - Removed extra empty spaces from DTS as suggested by Frank
> - Ordered 'edma2', 'sai3', 'wm8962' DT nodes alphabetically. The order of the nodes
> placed inside / is kept the same for readability
> - Ordered driver header files includes alphabetically as suggested by Frank
> - Removed "reg-names" and changed the maximum size of the "reg" property to 1 to align
> with the other NXP CPUs sharing the same programming model (i.e: audio processing with SOF).
> The region described in the DTS is the SRAM and the mailbox region is now hardcoded in the
> driver as an offset to the start of the SRAM region.
> - Added new binding with properties required by all NXP CPUs sharing the same programming
> model (i.e: audio processing with SOF).
> - Various driver adjustments made to accomodate the DT changes + some bug fixing related
> to the mboxes not being requested/free'd on resume/suspend.
> - Fixed value passed to "dma-channel-mask". A set bit means the channel is masked, not the
> other way around.
> - Link to v1: https://lore.kernel.org/lkml/20241023162114.3354-1-laurentiumihalcea111@gmail.com/
> ---
>
> Laurentiu Mihalcea (3):
>    ASoC: dt-bindings: support imx95's CM7 core
>    ASoC: dt-bindings: audio-graph-card2: add widgets and hp-det-gpios
>      support
>    arm64: dts: imx: add imx95 dts for sof
>
>   .../bindings/sound/audio-graph-card2.yaml     |  4 +
>   .../bindings/sound/fsl,imx95-cm7-sof.yaml     | 64 ++++++++++++++
>   .../bindings/sound/fsl,sof-cpu.yaml           | 27 ++++++
>   arch/arm64/boot/dts/freescale/Makefile        |  1 +
>   .../dts/freescale/imx95-19x19-evk-sof.dts     | 85 +++++++++++++++++++
>   5 files changed, 181 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/sound/fsl,imx95-cm7-sof.yaml
>   create mode 100644 Documentation/devicetree/bindings/sound/fsl,sof-cpu.yaml
>   create mode 100644 arch/arm64/boot/dts/freescale/imx95-19x19-evk-sof.dts
>

