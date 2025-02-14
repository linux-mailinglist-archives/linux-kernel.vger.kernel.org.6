Return-Path: <linux-kernel+bounces-514709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3E8A35A9F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87E2716F7C7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F4F250BF5;
	Fri, 14 Feb 2025 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="vMPNd8Pj"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2092.outbound.protection.outlook.com [40.107.215.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1150324BBE1;
	Fri, 14 Feb 2025 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739526252; cv=fail; b=oMwIbc1cg9U9VOma7wZS0YxAEwrAQIM1Mc0c6HxKX6xNa6it6JBKfYWw98t1WXjk04E4+ciUq+38JxEkpJO5xxtFT0PmKh0iZa4YBXSCe4PoIzDnc28RnU6Bzl0/CCceG2yIvEVd5uYK4TaDzjUXyFGzRt8ethIX3A0Gk38lBBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739526252; c=relaxed/simple;
	bh=Sz07iVgSrKQ4niXka4DPQua0XTXmO4Kr+YTNQxkEUfs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BgqcxoG+RRzQhEvQa5T47NLiPjXYH9HDu70gkUa3v2cQUoxAUXnmOqNHrZclh2PYl6PfUyxhkkBFU3vIyjyy5jt0ubJk5+1sKvb03YI9nK4XLlwciAq/wQjsi0YJp4PTEiSTRp221iK2kdYTpxh48XgICJ8wj0T+cX5TANQ0Ees=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=vMPNd8Pj; arc=fail smtp.client-ip=40.107.215.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DHM58tIiQYgZPgjj5ImEqkPHF6vAET0b2sFT52xPFHUBWWNSx6Rw5ulMpLPxHxp/0UPgj5DqI2tYrzoPKNrxVaHxvBnrp6Ep4mOhU5wJ0lRycjFy0HIeW2yy5K57YtPSqZ28SH4npV8BiRE3RbBhYvdO0gwq8fNwnCm5+TSPhxrp+TaTKID1ONX3HdjAQC7ct2fWX/6p88fdbZCXJkLfbt1FubWwoetDU5s8J8nlY1EmIC2JmVp6UdODxb4xdc5QxiXgmIG4gMEGUVC30URz59/9IDNqBnuBLuLYkNOup18GHb+OHkRopvRFQS75ZoIhll1apGpkIHrZvLfGw7Bpbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7099vK8fIYr9XXj8nxJjan8Un6rw1bsjgvGWLjAR7nc=;
 b=XPiCglAhqPcocD8SZG5HBoAq+O0f25lDGFj+IHE09I2eThsUJFlMbxdBia+of5A2WJLQx7c9b7ABJm3VglzQaKF/4ORR8ceX73Ri3Qgl0jn+7ktZny/SGGYCUS7uDdqe3CktLrvw13e8DqFx5/lRzP5mS1Me9C82FnomK21fr+iP+0RGE97OffPV/rvOt7WMiA9C72rySbNx0Yh9PKRg/9rIKK1rAtIogsXxlxYW4hSF49lNPdY793GBteDk0ObixArRKOG9HtO3bozwEkzWNv108VXCYFWzDloC4iT7/njFhKiFC+Gqs0h9Qwtt2awFRBbTAZTPBZcylvOmWUyJVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7099vK8fIYr9XXj8nxJjan8Un6rw1bsjgvGWLjAR7nc=;
 b=vMPNd8PjFqZzZMNKPrES6Nc6Dmuy/ZT53zi1/QAxxwf7J8GUCIcdxXi0EticNM6NBWpuxBGCdI1lnmWtRNV8/84IBMuu07GNIHFTGryDnhxzIHTJReJPzzU3bZ96lDbXPAVcgyn0rBb00X4tVF70fUpRza5hEbkdaaOwxM7jxKY8AyxadiQ15ynX/tiulPV/593fqwb3iOnfVF83mk/571C6nVtvEHtEYKRDnKNjr4bQOpIz6S/YImcBAO97YESbNB27Klf2S02yl46qEUgvjJJhW3ikHPjfjaIFFt5XAIKAQaGiebzGyN1+KRz75mpZZrDrdseXZsKmQAlH3Wv1iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PUZPR03MB7135.apcprd03.prod.outlook.com (2603:1096:301:113::15)
 by TYZPR03MB7529.apcprd03.prod.outlook.com (2603:1096:400:421::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 09:44:06 +0000
Received: from PUZPR03MB7135.apcprd03.prod.outlook.com
 ([fe80::ecac:a387:36d8:144d]) by PUZPR03MB7135.apcprd03.prod.outlook.com
 ([fe80::ecac:a387:36d8:144d%3]) with mapi id 15.20.8445.015; Fri, 14 Feb 2025
 09:44:06 +0000
Message-ID: <67aa2e46-b63e-4a7c-8b14-37e2b63d44ec@amlogic.com>
Date: Fri, 14 Feb 2025 17:44:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] ASoC: meson: s4:support the audio clk
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
References: <20250214-audio_drvier-v2-0-37881fa37c9e@amlogic.com>
 <20250214-audio_drvier-v2-3-37881fa37c9e@amlogic.com>
 <1jed00zy4i.fsf@starbuckisacylon.baylibre.com>
 <1j8qq8zxzn.fsf@starbuckisacylon.baylibre.com>
From: Jiebing Chen <jiebing.chen@amlogic.com>
In-Reply-To: <1j8qq8zxzn.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::30)
 To PUZPR03MB7135.apcprd03.prod.outlook.com (2603:1096:301:113::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR03MB7135:EE_|TYZPR03MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: cb0c65b2-4ee3-4637-f7d2-08dd4cdc1f5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2hZdFJsLzZXTWgvZ0NEMHhTc0JmVW5DL3lxWTM4UUxpMk9zbVBOUzRFc0da?=
 =?utf-8?B?WDU1U3M4VkxVTUdYb0ZuL0Q4WjBwbS93K2JFVUpQb1dBR1h1K205RHlIa2V2?=
 =?utf-8?B?a1pqd0FJSGFkMzF0bmpJazkyRDVaMFkzVElaKzdGVTV5aEdscFMvMWF1TFQ1?=
 =?utf-8?B?VVlYeWtTL1U2UkxGQldGVTFSdmNGVGgvaFVTVmJBVUtoNzlxbUE5R2VLdFdK?=
 =?utf-8?B?SXY3a1BDUkQzYUlKUFBUQkVUd2hxZHNBRzVQL1dFWXVQc3hqbDVLSWx6NUFQ?=
 =?utf-8?B?M2IwWmtFL2U1QU5yUlRzQkhYcVAzKzI1Q3VzTWYxZGpNam03NDN1OVRqcTcr?=
 =?utf-8?B?TjdDSHZabDVva1FwQnNPQmFpZmMrMnMwV1ZqVTdUS2gzNUd0NUJ6MzhJNS81?=
 =?utf-8?B?REYyNDdqNVFjS2Rtc0dWeWsrVTFRbnA1VUxpUE1BR0lqaGIxRE5kQjRCSHhF?=
 =?utf-8?B?M2prQ1hrbEh0ZlJ2aUJ3cjJHNGhVbXlJWHUrOUJaUDl2QVVTS0g2c0x2UDMy?=
 =?utf-8?B?d3QzZEZEalErY2dsejUvSG1wZVJaVDZUcytIbWU3Yit3eUxmcXRocVlkdEFF?=
 =?utf-8?B?TXpNYitpNitaaGNEbkg5YytJcTZ3QXE0ZGlxYkVNb3cxOEJ0ZkFDakppb3J3?=
 =?utf-8?B?VVE3SGhDamxRN0loOExvUGpERURpeUdkalViQzZUTjF0ZFp2ZWVDaDhJU2V1?=
 =?utf-8?B?Wk82YXNITTZ6UGkyRXBUMFhwblBEdjV1ZUxZdXpobThmZTdoZUprbFJ4d1M0?=
 =?utf-8?B?b2YyM1NLcC9KZkFwUU1vc3haQ0NjUjFaT3dRelNPRVNKdW4rd0RENzN2NmZq?=
 =?utf-8?B?TWM3cFQxT3ZJcVgvVytDMnR2Y1UzRTFtek9EVlkxM2JtR2s4bGdPSVk5SllE?=
 =?utf-8?B?bTd2Y2k2dnhEOTNqR2pMenNQV3RHeCsyWmFqWGFZVTdpaTNEaFhmT1E4VVFW?=
 =?utf-8?B?Rzh5Z1d6ZXhtQldaNVdxQ0ErOUhWK2FyeTBZcDNXQWxvZ3pzUThZWHpjWUNx?=
 =?utf-8?B?RlZoUklocVBvN1JmQzhzUU04NUNrRWh1dDdSVlIyYzljQ0hDY05aaStjZmNH?=
 =?utf-8?B?NnFnanB2cVAra3V1RVlrUWNUUUlpWFk4aFdQalR4SDJUV1dKbUpuazEwWWJs?=
 =?utf-8?B?eEJPb0hsdmVQaXZjejNtMElDc2Q1dHZaY3JOTXF0K0RHUjRtZlQvNXFlZTJ6?=
 =?utf-8?B?MG0xTGgxSzhOME5JTmFXZE5kYkJxbzR3Q1dMSDdGbHBKT1FPUkwvMVBnbXpX?=
 =?utf-8?B?RkhjcTdvNXcyK3pFNTdBbDBodC9mNDU0T2dUUnBwRzU3QTZMY0QrTGYva0Fi?=
 =?utf-8?B?ZTJsWXlzTFJydyt0S1ZOWU1wSFkxc0JlMmFiNFg4ZTMwM3pEemlhUXVCbUw2?=
 =?utf-8?B?UE1XeUpWOTRTT1NzR2F4MnM3RjRKbnl1VFpTMWliWWJqQ1JzVnFoWkNYd3kw?=
 =?utf-8?B?L3JpU3FWNStUQkpkMnFNUmEyczJjUFh2YkZLZWFQenRJUnFKOVRsMEhaTksx?=
 =?utf-8?B?c2Yva0I3YnlaVEJsekVWQ2JiNWxObmRqRG1USkt4T1F3L3pnYkNwOXFmU1I5?=
 =?utf-8?B?WmlwelZqcXJveWFjTDQ4MU5IOTZmaFVXQjdNbnhubWN5Q0xJZ08rSit2QXNV?=
 =?utf-8?B?U3lyV2xGWlIyNVF1Ry9qZzMzeWdQdnBNTXZOV2VGZmNLRFhBR1hBZU1hdXE5?=
 =?utf-8?B?VjlBMUdoaTkyUE92RGtZczMwWTZWZHptSUtqQ2VwUE50a0w2RWNjOUJNWVRH?=
 =?utf-8?B?WGtSSVZyd2hFZkUzQjdXTDJDYVVqSjlEVnd4RC9OVHhFam9Yb1JnZGN0S2R2?=
 =?utf-8?B?ZVVoUjF1N3BlQmlZR2ZWQWlPVHBRR2dKSS9BUk1CdzFSaThNcVppNjNxVzNy?=
 =?utf-8?Q?v1EfwB2etivSO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB7135.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WENvM0VPUnI0TEJzU0g1WnB6OVZxWmY1M0VuU0JnUitrdEpxam5sWDNGREhK?=
 =?utf-8?B?OUEreGV1dFhDTHFnOGRoa20rOHR1RzlHaDlWOXJLa0dUUEhEQVpDWFNYL1pR?=
 =?utf-8?B?U0xPOFlPN2plRzhpVnB0aXRoY203ZS9kVTRkeXZWLytRQlA1VmR1cm9lWWNE?=
 =?utf-8?B?NXJHdjR5NlQvc1RwTE05ak5kQ0xBTGVVSFlEWXJjUFJrVUZYMkw4MGFoVWRC?=
 =?utf-8?B?azBDN1phVHM1L1lzVy9BQUEraDFVMTA1akE3c2d5WHdLTnFhd2ttZk82QTY1?=
 =?utf-8?B?OEgrVURhYlAxYVUyUlVXVitDNmRBdXVycWV2YVB1dUUvYXBDUDZFQzJwSjYz?=
 =?utf-8?B?UFRiQTJLRTBqNE91TnphUzFkcmJ2WnZvL3dNcmtwQXpnaEE2cVZhQUNEMkY3?=
 =?utf-8?B?dFp0UDFlTWxzbnRuUTJxSVhCcEVYd2RSL0M5dEZRR0tZZmxkdUJmSGJSTGdB?=
 =?utf-8?B?Q3hvd24vdVUxTE1HSUpTbnFuZzNvbGsyNjhJODEyNDkzdVdQN3BsNlF6NDgy?=
 =?utf-8?B?Ti9TUVRSVWpRaUxZajVncUVObEVLVjMxa0ovYUlNZU81ZXBmYWpUU0d2bEpD?=
 =?utf-8?B?cTJYVnF2UWVLMC9YcWxVK3prM1RNM0Q4OEtaL01FeTI3WnIwWHRQZzhsUEY4?=
 =?utf-8?B?eWxRZzBLZWJIUE9pR3d2TXpsM2NwZEdUNDlKRE1lWG9nSUFxQzU5Q2hyZ1N1?=
 =?utf-8?B?K1pQRklReTAxVUxNeGY3RkhIVmdlTnZhY0FVYXd6cDlpQllYVjVFUG1EOExR?=
 =?utf-8?B?RVc0eUZzeVNOZ29ESHVvNlozQkovc0k2Vm4wT0prK09uRE4rZEQybmg2ZGQy?=
 =?utf-8?B?SmhkRXd4aEMvS1pDRVBVY0lBcnNEblIzN2NybTVJanAwTXhCaGdMT0szcHlm?=
 =?utf-8?B?MEdmRllaOTRwd0lxUkNpMTBpQzRhSmF3S0E4cllEa2VXcUIwVjVKTGMyZzdK?=
 =?utf-8?B?OUhCaDJnOWRJTFlPQjhKb29tb2hONHlHUWxrSFMxN1JYMll3bi9VandwT0wr?=
 =?utf-8?B?RXpsSXRFMG52UUhYdGw0MlR5VmpTTHQzRGpkM0RGbXJMRFgxSnNRdGVqTUFP?=
 =?utf-8?B?MDY4Mk9kRmJDZmU1K2YzRDhiK3NqVUVjdTdxM1VXSjh1aEt3Vk9nZEhJck91?=
 =?utf-8?B?L1lGTW1SQTdUemhoTEh0U1VnKzJGWDlpaEh2RDJvL21TeVRTUlpNbW16ZjVi?=
 =?utf-8?B?WnZmUFBtaXgrQS9CS1A3TjZXMEE5MXNaR1FyZkZPRWdkL0hlVnJiVlk3eW9l?=
 =?utf-8?B?d0JMMzZpdlBIdDlldzN1Um9iazBlUHJGcThSRE9aZG50WjFpM3Z1cFR5NFZW?=
 =?utf-8?B?WXdWWWJFT3U5VEpscDJKSHRnYS9XZjFGZU9Hdnh1UXVGczdxWG44L3J4YU9S?=
 =?utf-8?B?TzFHb09PWXViNHVBSk0wRytRb1pFK1pFQ1RBUHpRaW8zeFppNEpLM3l0Q0R3?=
 =?utf-8?B?UlU1eTFYMjlqeWFDdTYzd1FtSVRaYzlDbHZob093SGZLelNVV0VNOGZnUDZI?=
 =?utf-8?B?Vi8yQ3ZGUHFvTTNYN2ZnV0dZcllwUGJZVzFuaUdsTXp1dmlRcU5vRVE0OWdr?=
 =?utf-8?B?R09BSC9HNGxXSisyQ3IvWE5BZ2JNM1F6Q2hXRkNtbUZuZ1pQZTRHZERxS1Rn?=
 =?utf-8?B?VjVYVU1ycktRMHZGa1dwN1NtM3VoQklXTzVqdldSaURtSzZqZlA2R0piTlNz?=
 =?utf-8?B?azhtWkdlWmtBSExjV244UXBnZ2ZEblZsUEFxSWsyUmdJS09BQmxIZHUzVldD?=
 =?utf-8?B?anorVnVMN2todWJ4ZFZoY3BFUFlra05KUkJYNEMvS0Qra2NyL1BCQ1B2ZDlN?=
 =?utf-8?B?RlFDc2R6WjRpbHpDSkUxa2lTMjlvUXR3U3I3cEFqbE9jalY1aG9uYXozL0R5?=
 =?utf-8?B?NjROR3hvVHZIb0c5blQwOFZCZk1XSzNGcTlDWUNrTVFOcXZJM2tTdmU4dWNW?=
 =?utf-8?B?czVmNlNHTEpyMVYxR3llcTJWS0pLazFUTXVIQ2h1dnpIaS9nVW04UWs3cDI3?=
 =?utf-8?B?Vmo1eDE4YnAvdC84cmE0YXUwa1NTVG4zKzUyalhSUXRwdWNYZ0tqcGlHN2VX?=
 =?utf-8?B?ZnZuY2RMMldVZVUxSkV6WjROTUE5VXU4RUtPV0NjUTdURlNJQkFlbWdXdk5w?=
 =?utf-8?B?VW90TzFFaFN4L2VSRGRGbFJ3d3JEYWVzMUwvejg3a2VmeW03UHZMTnRsK25T?=
 =?utf-8?B?Q2c9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0c65b2-4ee3-4637-f7d2-08dd4cdc1f5f
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB7135.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 09:44:06.2394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RI7vSmFPceOEfZaWV7PA5hvpgxLwCt4GVBgMbuXiK2XY1y/7WppnhpQu6EMr38l5lpB9z75l7ZdaZrqH93XVeqp44yL/aty1W5+TUU2qw2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7529


在 2025/2/14 17:17, Jerome Brunet 写道:
> [ EXTERNAL EMAIL ]
>
> On Fri 14 Feb 2025 at 10:14, Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>> On Fri 14 Feb 2025 at 10:13, jiebing chen via B4 Relay <devnull+jiebing.chen.amlogic.com@kernel.org> wrote:
>>
>>> From: jiebing chen <jiebing.chen@amlogic.com>
>>>
>>> Add the audio clk tree for s4, add new mclk, sclk and lrclk pad.
>>>
>> This disregard previous feedback about the compatibility with the
>> axg/g12 platform.
>>
>> Is what follows really the only difference between the 2 ?
>> You previous reported the difference would be significant and now this ?
>> I don't get it.
> And the title is wrong

Hi, jerome

The s4 mclk pad  is different from the g12a ,for g12a. the mclk pad not 
to add the div factor,

for the previous version, we only test the internal codec, it didn't 
rely on an mclk pad,

if not use the external codec(dac/adc), old clock  id is compatible, so 
the old clock id still work,

based on your suggestion, we re-added the full clk id for s4, the s4 
base on sm1,  except for some

minor differences between the mclk pad and toodec and sm1, everything 
else is exactly the same

This is the s4 mclkpad  register


>
>>> Signed-off-by: jiebing chen <jiebing.chen@amlogic.com>
>>> ---
>>>   drivers/clk/meson/axg-audio.c | 410 +++++++++++++++++++++++++++++++++++++++++-
>>>   drivers/clk/meson/axg-audio.h |   4 +
>>>   2 files changed, 412 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
>>> index 9df627b142f89788966ede0262aaaf39e13f0b49..e70559ee0fd8deaf9858b0592e839fdf49d05886 100644
>>> --- a/drivers/clk/meson/axg-audio.c
>>> +++ b/drivers/clk/meson/axg-audio.c
>>> @@ -323,6 +323,16 @@ static const struct clk_parent_data lrclk_pad_ctrl_parent_data[] = {
>>>       AUD_MUX(_name, _reg, 0x7, _shift, 0, _parents,          \
>>>               CLK_SET_RATE_NO_REPARENT)
>>>
>>> +#define AUD_MCLK_PAD_MUX(_name, _reg, _shift)                                       \
>>> +    AUD_MUX(_name##_sel, _reg, 0x7, _shift, CLK_MUX_ROUND_CLOSEST,                  \
>>> +            mclk_pad_ctrl_parent_data, 0)
>>> +#define AUD_MCLK_PAD_DIV(_name, _reg, _shift)                                       \
>>> +    AUD_DIV(_name##_div, _reg, _shift, 8, CLK_DIVIDER_ROUND_CLOSEST,                        \
>>> +            aud_##_name##_sel, CLK_SET_RATE_PARENT)
>>> +#define AUD_MCLK_PAD_GATE(_name, _reg, _shift)                                      \
>>> +    AUD_GATE(_name, _reg, _shift, aud_##_name##_div,                        \
>>> +             CLK_SET_RATE_PARENT)
>>> +
>>>   /* Common Clocks */
>>>   static struct clk_regmap ddr_arb =
>>>       AUD_PCLK_GATE(ddr_arb, AUDIO_CLK_GATE_EN, 0);
>>> @@ -826,6 +836,49 @@ static struct clk_regmap sm1_tdm_sclk_pad_1 = AUD_TDM_PAD_CTRL(
>>>   static struct clk_regmap sm1_tdm_sclk_pad_2 = AUD_TDM_PAD_CTRL(
>>>       tdm_sclk_pad_2, AUDIO_SM1_MST_PAD_CTRL1, 8, sclk_pad_ctrl_parent_data);
>>>
>>> +static struct clk_regmap s4_tdm_mclk_pad0_sel =
>>> +    AUD_MCLK_PAD_MUX(mclk_pad0, AUDIO_S4_MCLK_PAD_CTRL0, 8);
>>> +static struct clk_regmap s4_tdm_mclk_pad1_sel =
>>> +    AUD_MCLK_PAD_MUX(mclk_pad1, AUDIO_S4_MCLK_PAD_CTRL0, 24);
>>> +static struct clk_regmap s4_tdm_mclk_pad2_sel =
>>> +    AUD_MCLK_PAD_MUX(mclk_pad2, AUDIO_S4_MCLK_PAD_CTRL1, 8);
>>> +
>>> +static struct clk_regmap s4_tdm_mclk_pad0_div =
>>> +    AUD_MCLK_PAD_DIV(mclk_pad0, AUDIO_S4_MCLK_PAD_CTRL0, 0);
>>> +static struct clk_regmap s4_tdm_mclk_pad1_div =
>>> +    AUD_MCLK_PAD_DIV(mclk_pad1, AUDIO_S4_MCLK_PAD_CTRL0, 16);
>>> +static struct clk_regmap s4_tdm_mclk_pad2_div =
>>> +    AUD_MCLK_PAD_DIV(mclk_pad2, AUDIO_S4_MCLK_PAD_CTRL1, 0);
>>> +
>>> +static struct clk_regmap s4_tdm_mclk_pad_0 =
>>> +    AUD_MCLK_PAD_GATE(mclk_pad0, AUDIO_S4_MCLK_PAD_CTRL0, 15);
>>> +static struct clk_regmap s4_tdm_mclk_pad_1 =
>>> +    AUD_MCLK_PAD_GATE(mclk_pad1, AUDIO_S4_MCLK_PAD_CTRL0, 31);
>>> +static struct clk_regmap s4_tdm_mclk_pad_2 =
>>> +    AUD_MCLK_PAD_GATE(mclk_pad2, AUDIO_S4_MCLK_PAD_CTRL1, 15);
>>> +
>>> +static struct clk_regmap s4_tdm_sclk_pad_0 =
>>> +    AUD_TDM_PAD_CTRL(tdm_sclk_pad_0, AUDIO_S4_SCLK_PAD_CTRL0, 0, lrclk_pad_ctrl_parent_data);
>>> +static struct clk_regmap s4_tdm_sclk_pad_1 =
>>> +    AUD_TDM_PAD_CTRL(tdm_sclk_pad_1, AUDIO_S4_SCLK_PAD_CTRL0, 4, lrclk_pad_ctrl_parent_data);
>>> +static struct clk_regmap s4_tdm_sclk_pad_2 =
>>> +    AUD_TDM_PAD_CTRL(tdm_sclk_pad_2, AUDIO_S4_SCLK_PAD_CTRL0, 8, lrclk_pad_ctrl_parent_data);
>>> +static struct clk_regmap s4_tdm_sclk_pad_3 =
>>> +    AUD_TDM_PAD_CTRL(tdm_sclk_pad_3, AUDIO_S4_SCLK_PAD_CTRL0, 16, lrclk_pad_ctrl_parent_data);
>>> +static struct clk_regmap s4_tdm_sclk_pad_4 =
>>> +    AUD_TDM_PAD_CTRL(tdm_sclk_pad_4, AUDIO_S4_SCLK_PAD_CTRL0, 20, lrclk_pad_ctrl_parent_data);
>>> +
>>> +static struct clk_regmap s4_tdm_lrclk_pad_0 =
>>> +    AUD_TDM_PAD_CTRL(tdm_lrclk_pad_0, AUDIO_S4_SCLK_PAD_CTRL1, 0, lrclk_pad_ctrl_parent_data);
>>> +static struct clk_regmap s4_tdm_lrclk_pad_1 =
>>> +    AUD_TDM_PAD_CTRL(tdm_lrclk_pad_1, AUDIO_S4_SCLK_PAD_CTRL1, 4, lrclk_pad_ctrl_parent_data);
>>> +static struct clk_regmap s4_tdm_lrclk_pad_2 =
>>> +    AUD_TDM_PAD_CTRL(tdm_lrclk_pad_2, AUDIO_S4_SCLK_PAD_CTRL1, 8, lrclk_pad_ctrl_parent_data);
>>> +static struct clk_regmap s4_tdm_lrclk_pad_3 =
>>> +    AUD_TDM_PAD_CTRL(tdm_lrclk_pad_3, AUDIO_S4_SCLK_PAD_CTRL1, 16, lrclk_pad_ctrl_parent_data);
>>> +static struct clk_regmap s4_tdm_lrclk_pad_4 =
>>> +    AUD_TDM_PAD_CTRL(tdm_lrclk_pad_4, AUDIO_S4_SCLK_PAD_CTRL1, 20, lrclk_pad_ctrl_parent_data);
>>> +
>>>   /*
>>>    * Array of all clocks provided by this provider
>>>    * The input clocks of the controller will be populated at runtime
>>> @@ -1257,6 +1310,177 @@ static struct clk_hw *sm1_audio_hw_clks[] = {
>>>       [AUD_CLKID_EARCRX_DMAC]         = &sm1_earcrx_dmac_clk.hw,
>>>   };
>>>
>>> +/*
>>> + * Array of all S4 clocks provided by this provider
>>> + * The input clocks of the controller will be populated at runtime
>>> + */
>>> +static struct clk_hw *s4_audio_hw_clks[] = {
>>> +    [AUD_CLKID_DDR_ARB]             = &ddr_arb.hw,
>>> +    [AUD_CLKID_PDM]                 = &pdm.hw,
>>> +    [AUD_CLKID_TDMIN_A]             = &tdmin_a.hw,
>>> +    [AUD_CLKID_TDMIN_B]             = &tdmin_b.hw,
>>> +    [AUD_CLKID_TDMIN_C]             = &tdmin_c.hw,
>>> +    [AUD_CLKID_TDMIN_LB]            = &tdmin_lb.hw,
>>> +    [AUD_CLKID_TDMOUT_A]            = &tdmout_a.hw,
>>> +    [AUD_CLKID_TDMOUT_B]            = &tdmout_b.hw,
>>> +    [AUD_CLKID_TDMOUT_C]            = &tdmout_c.hw,
>>> +    [AUD_CLKID_FRDDR_A]             = &frddr_a.hw,
>>> +    [AUD_CLKID_FRDDR_B]             = &frddr_b.hw,
>>> +    [AUD_CLKID_FRDDR_C]             = &frddr_c.hw,
>>> +    [AUD_CLKID_TODDR_A]             = &toddr_a.hw,
>>> +    [AUD_CLKID_TODDR_B]             = &toddr_b.hw,
>>> +    [AUD_CLKID_TODDR_C]             = &toddr_c.hw,
>>> +    [AUD_CLKID_LOOPBACK]            = &loopback.hw,
>>> +    [AUD_CLKID_SPDIFIN]             = &spdifin.hw,
>>> +    [AUD_CLKID_SPDIFOUT]            = &spdifout.hw,
>>> +    [AUD_CLKID_RESAMPLE]            = &resample.hw,
>>> +    [AUD_CLKID_SPDIFOUT_B]          = &spdifout_b.hw,
>>> +    [AUD_CLKID_MST_A_MCLK_SEL]      = &sm1_mst_a_mclk_sel.hw,
>>> +    [AUD_CLKID_MST_B_MCLK_SEL]      = &sm1_mst_b_mclk_sel.hw,
>>> +    [AUD_CLKID_MST_C_MCLK_SEL]      = &sm1_mst_c_mclk_sel.hw,
>>> +    [AUD_CLKID_MST_D_MCLK_SEL]      = &sm1_mst_d_mclk_sel.hw,
>>> +    [AUD_CLKID_MST_E_MCLK_SEL]      = &sm1_mst_e_mclk_sel.hw,
>>> +    [AUD_CLKID_MST_F_MCLK_SEL]      = &sm1_mst_f_mclk_sel.hw,
>>> +    [AUD_CLKID_MST_A_MCLK_DIV]      = &sm1_mst_a_mclk_div.hw,
>>> +    [AUD_CLKID_MST_B_MCLK_DIV]      = &sm1_mst_b_mclk_div.hw,
>>> +    [AUD_CLKID_MST_C_MCLK_DIV]      = &sm1_mst_c_mclk_div.hw,
>>> +    [AUD_CLKID_MST_D_MCLK_DIV]      = &sm1_mst_d_mclk_div.hw,
>>> +    [AUD_CLKID_MST_E_MCLK_DIV]      = &sm1_mst_e_mclk_div.hw,
>>> +    [AUD_CLKID_MST_F_MCLK_DIV]      = &sm1_mst_f_mclk_div.hw,
>>> +    [AUD_CLKID_MST_A_MCLK]          = &sm1_mst_a_mclk.hw,
>>> +    [AUD_CLKID_MST_B_MCLK]          = &sm1_mst_b_mclk.hw,
>>> +    [AUD_CLKID_MST_C_MCLK]          = &sm1_mst_c_mclk.hw,
>>> +    [AUD_CLKID_MST_D_MCLK]          = &sm1_mst_d_mclk.hw,
>>> +    [AUD_CLKID_MST_E_MCLK]          = &sm1_mst_e_mclk.hw,
>>> +    [AUD_CLKID_MST_F_MCLK]          = &sm1_mst_f_mclk.hw,
>>> +    [AUD_CLKID_SPDIFOUT_CLK_SEL]    = &spdifout_clk_sel.hw,
>>> +    [AUD_CLKID_SPDIFOUT_CLK_DIV]    = &spdifout_clk_div.hw,
>>> +    [AUD_CLKID_SPDIFOUT_CLK]        = &spdifout_clk.hw,
>>> +    [AUD_CLKID_SPDIFOUT_B_CLK_SEL]  = &spdifout_b_clk_sel.hw,
>>> +    [AUD_CLKID_SPDIFOUT_B_CLK_DIV]  = &spdifout_b_clk_div.hw,
>>> +    [AUD_CLKID_SPDIFOUT_B_CLK]      = &spdifout_b_clk.hw,
>>> +    [AUD_CLKID_SPDIFIN_CLK_SEL]     = &spdifin_clk_sel.hw,
>>> +    [AUD_CLKID_SPDIFIN_CLK_DIV]     = &spdifin_clk_div.hw,
>>> +    [AUD_CLKID_SPDIFIN_CLK]         = &spdifin_clk.hw,
>>> +    [AUD_CLKID_PDM_DCLK_SEL]        = &pdm_dclk_sel.hw,
>>> +    [AUD_CLKID_PDM_DCLK_DIV]        = &pdm_dclk_div.hw,
>>> +    [AUD_CLKID_PDM_DCLK]            = &pdm_dclk.hw,
>>> +    [AUD_CLKID_PDM_SYSCLK_SEL]      = &pdm_sysclk_sel.hw,
>>> +    [AUD_CLKID_PDM_SYSCLK_DIV]      = &pdm_sysclk_div.hw,
>>> +    [AUD_CLKID_PDM_SYSCLK]          = &pdm_sysclk.hw,
>>> +    [AUD_CLKID_MST_A_SCLK_PRE_EN]   = &mst_a_sclk_pre_en.hw,
>>> +    [AUD_CLKID_MST_B_SCLK_PRE_EN]   = &mst_b_sclk_pre_en.hw,
>>> +    [AUD_CLKID_MST_C_SCLK_PRE_EN]   = &mst_c_sclk_pre_en.hw,
>>> +    [AUD_CLKID_MST_D_SCLK_PRE_EN]   = &mst_d_sclk_pre_en.hw,
>>> +    [AUD_CLKID_MST_E_SCLK_PRE_EN]   = &mst_e_sclk_pre_en.hw,
>>> +    [AUD_CLKID_MST_F_SCLK_PRE_EN]   = &mst_f_sclk_pre_en.hw,
>>> +    [AUD_CLKID_MST_A_SCLK_DIV]      = &mst_a_sclk_div.hw,
>>> +    [AUD_CLKID_MST_B_SCLK_DIV]      = &mst_b_sclk_div.hw,
>>> +    [AUD_CLKID_MST_C_SCLK_DIV]      = &mst_c_sclk_div.hw,
>>> +    [AUD_CLKID_MST_D_SCLK_DIV]      = &mst_d_sclk_div.hw,
>>> +    [AUD_CLKID_MST_E_SCLK_DIV]      = &mst_e_sclk_div.hw,
>>> +    [AUD_CLKID_MST_F_SCLK_DIV]      = &mst_f_sclk_div.hw,
>>> +    [AUD_CLKID_MST_A_SCLK_POST_EN]  = &mst_a_sclk_post_en.hw,
>>> +    [AUD_CLKID_MST_B_SCLK_POST_EN]  = &mst_b_sclk_post_en.hw,
>>> +    [AUD_CLKID_MST_C_SCLK_POST_EN]  = &mst_c_sclk_post_en.hw,
>>> +    [AUD_CLKID_MST_D_SCLK_POST_EN]  = &mst_d_sclk_post_en.hw,
>>> +    [AUD_CLKID_MST_E_SCLK_POST_EN]  = &mst_e_sclk_post_en.hw,
>>> +    [AUD_CLKID_MST_F_SCLK_POST_EN]  = &mst_f_sclk_post_en.hw,
>>> +    [AUD_CLKID_MST_A_SCLK]          = &mst_a_sclk.hw,
>>> +    [AUD_CLKID_MST_B_SCLK]          = &mst_b_sclk.hw,
>>> +    [AUD_CLKID_MST_C_SCLK]          = &mst_c_sclk.hw,
>>> +    [AUD_CLKID_MST_D_SCLK]          = &mst_d_sclk.hw,
>>> +    [AUD_CLKID_MST_E_SCLK]          = &mst_e_sclk.hw,
>>> +    [AUD_CLKID_MST_F_SCLK]          = &mst_f_sclk.hw,
>>> +    [AUD_CLKID_MST_A_LRCLK_DIV]     = &mst_a_lrclk_div.hw,
>>> +    [AUD_CLKID_MST_B_LRCLK_DIV]     = &mst_b_lrclk_div.hw,
>>> +    [AUD_CLKID_MST_C_LRCLK_DIV]     = &mst_c_lrclk_div.hw,
>>> +    [AUD_CLKID_MST_D_LRCLK_DIV]     = &mst_d_lrclk_div.hw,
>>> +    [AUD_CLKID_MST_E_LRCLK_DIV]     = &mst_e_lrclk_div.hw,
>>> +    [AUD_CLKID_MST_F_LRCLK_DIV]     = &mst_f_lrclk_div.hw,
>>> +    [AUD_CLKID_MST_A_LRCLK]         = &mst_a_lrclk.hw,
>>> +    [AUD_CLKID_MST_B_LRCLK]         = &mst_b_lrclk.hw,
>>> +    [AUD_CLKID_MST_C_LRCLK]         = &mst_c_lrclk.hw,
>>> +    [AUD_CLKID_MST_D_LRCLK]         = &mst_d_lrclk.hw,
>>> +    [AUD_CLKID_MST_E_LRCLK]         = &mst_e_lrclk.hw,
>>> +    [AUD_CLKID_MST_F_LRCLK]         = &mst_f_lrclk.hw,
>>> +    [AUD_CLKID_TDMIN_A_SCLK_SEL]    = &tdmin_a_sclk_sel.hw,
>>> +    [AUD_CLKID_TDMIN_B_SCLK_SEL]    = &tdmin_b_sclk_sel.hw,
>>> +    [AUD_CLKID_TDMIN_C_SCLK_SEL]    = &tdmin_c_sclk_sel.hw,
>>> +    [AUD_CLKID_TDMIN_LB_SCLK_SEL]   = &tdmin_lb_sclk_sel.hw,
>>> +    [AUD_CLKID_TDMOUT_A_SCLK_SEL]   = &tdmout_a_sclk_sel.hw,
>>> +    [AUD_CLKID_TDMOUT_B_SCLK_SEL]   = &tdmout_b_sclk_sel.hw,
>>> +    [AUD_CLKID_TDMOUT_C_SCLK_SEL]   = &tdmout_c_sclk_sel.hw,
>>> +    [AUD_CLKID_TDMIN_A_SCLK_PRE_EN] = &tdmin_a_sclk_pre_en.hw,
>>> +    [AUD_CLKID_TDMIN_B_SCLK_PRE_EN] = &tdmin_b_sclk_pre_en.hw,
>>> +    [AUD_CLKID_TDMIN_C_SCLK_PRE_EN] = &tdmin_c_sclk_pre_en.hw,
>>> +    [AUD_CLKID_TDMIN_LB_SCLK_PRE_EN] = &tdmin_lb_sclk_pre_en.hw,
>>> +    [AUD_CLKID_TDMOUT_A_SCLK_PRE_EN] = &tdmout_a_sclk_pre_en.hw,
>>> +    [AUD_CLKID_TDMOUT_B_SCLK_PRE_EN] = &tdmout_b_sclk_pre_en.hw,
>>> +    [AUD_CLKID_TDMOUT_C_SCLK_PRE_EN] = &tdmout_c_sclk_pre_en.hw,
>>> +    [AUD_CLKID_TDMIN_A_SCLK_POST_EN] = &tdmin_a_sclk_post_en.hw,
>>> +    [AUD_CLKID_TDMIN_B_SCLK_POST_EN] = &tdmin_b_sclk_post_en.hw,
>>> +    [AUD_CLKID_TDMIN_C_SCLK_POST_EN] = &tdmin_c_sclk_post_en.hw,
>>> +    [AUD_CLKID_TDMIN_LB_SCLK_POST_EN] = &tdmin_lb_sclk_post_en.hw,
>>> +    [AUD_CLKID_TDMOUT_A_SCLK_POST_EN] = &tdmout_a_sclk_post_en.hw,
>>> +    [AUD_CLKID_TDMOUT_B_SCLK_POST_EN] = &tdmout_b_sclk_post_en.hw,
>>> +    [AUD_CLKID_TDMOUT_C_SCLK_POST_EN] = &tdmout_c_sclk_post_en.hw,
>>> +    [AUD_CLKID_TDMIN_A_SCLK]        = &tdmin_a_sclk.hw,
>>> +    [AUD_CLKID_TDMIN_B_SCLK]        = &tdmin_b_sclk.hw,
>>> +    [AUD_CLKID_TDMIN_C_SCLK]        = &tdmin_c_sclk.hw,
>>> +    [AUD_CLKID_TDMIN_LB_SCLK]       = &tdmin_lb_sclk.hw,
>>> +    [AUD_CLKID_TDMOUT_A_SCLK]       = &g12a_tdmout_a_sclk.hw,
>>> +    [AUD_CLKID_TDMOUT_B_SCLK]       = &g12a_tdmout_b_sclk.hw,
>>> +    [AUD_CLKID_TDMOUT_C_SCLK]       = &g12a_tdmout_c_sclk.hw,
>>> +    [AUD_CLKID_TDMIN_A_LRCLK]       = &tdmin_a_lrclk.hw,
>>> +    [AUD_CLKID_TDMIN_B_LRCLK]       = &tdmin_b_lrclk.hw,
>>> +    [AUD_CLKID_TDMIN_C_LRCLK]       = &tdmin_c_lrclk.hw,
>>> +    [AUD_CLKID_TDMIN_LB_LRCLK]      = &tdmin_lb_lrclk.hw,
>>> +    [AUD_CLKID_TDMOUT_A_LRCLK]      = &tdmout_a_lrclk.hw,
>>> +    [AUD_CLKID_TDMOUT_B_LRCLK]      = &tdmout_b_lrclk.hw,
>>> +    [AUD_CLKID_TDMOUT_C_LRCLK]      = &tdmout_c_lrclk.hw,
>>> +    [AUD_CLKID_TDM_MCLK_PAD0]       = &s4_tdm_mclk_pad_0.hw,
>>> +    [AUD_CLKID_TDM_MCLK_PAD1]       = &s4_tdm_mclk_pad_1.hw,
>>> +    [AUD_CLKID_TDM_LRCLK_PAD0]      = &s4_tdm_lrclk_pad_0.hw,
>>> +    [AUD_CLKID_TDM_LRCLK_PAD1]      = &s4_tdm_lrclk_pad_1.hw,
>>> +    [AUD_CLKID_TDM_LRCLK_PAD2]      = &s4_tdm_lrclk_pad_2.hw,
>>> +    [AUD_CLKID_TDM_SCLK_PAD0]       = &s4_tdm_sclk_pad_0.hw,
>>> +    [AUD_CLKID_TDM_SCLK_PAD1]       = &s4_tdm_sclk_pad_1.hw,
>>> +    [AUD_CLKID_TDM_SCLK_PAD2]       = &s4_tdm_sclk_pad_2.hw,
>>> +    [AUD_CLKID_TOP]                 = &sm1_aud_top.hw,
>>> +    [AUD_CLKID_TORAM]               = &toram.hw,
>>> +    [AUD_CLKID_EQDRC]               = &eqdrc.hw,
>>> +    [AUD_CLKID_RESAMPLE_B]          = &resample_b.hw,
>>> +    [AUD_CLKID_TOVAD]               = &tovad.hw,
>>> +    [AUD_CLKID_LOCKER]              = &locker.hw,
>>> +    [AUD_CLKID_SPDIFIN_LB]          = &spdifin_lb.hw,
>>> +    [AUD_CLKID_FRDDR_D]             = &frddr_d.hw,
>>> +    [AUD_CLKID_TODDR_D]             = &toddr_d.hw,
>>> +    [AUD_CLKID_LOOPBACK_B]          = &loopback_b.hw,
>>> +    [AUD_CLKID_CLK81_EN]            = &sm1_clk81_en.hw,
>>> +    [AUD_CLKID_SYSCLK_A_DIV]        = &sm1_sysclk_a_div.hw,
>>> +    [AUD_CLKID_SYSCLK_A_EN]         = &sm1_sysclk_a_en.hw,
>>> +    [AUD_CLKID_SYSCLK_B_DIV]        = &sm1_sysclk_b_div.hw,
>>> +    [AUD_CLKID_SYSCLK_B_EN]         = &sm1_sysclk_b_en.hw,
>>> +    [AUD_CLKID_EARCRX]              = &earcrx.hw,
>>> +    [AUD_CLKID_EARCRX_CMDC_SEL]     = &sm1_earcrx_cmdc_clk_sel.hw,
>>> +    [AUD_CLKID_EARCRX_CMDC_DIV]     = &sm1_earcrx_cmdc_clk_div.hw,
>>> +    [AUD_CLKID_EARCRX_CMDC]         = &sm1_earcrx_cmdc_clk.hw,
>>> +    [AUD_CLKID_EARCRX_DMAC_SEL]     = &sm1_earcrx_dmac_clk_sel.hw,
>>> +    [AUD_CLKID_EARCRX_DMAC_DIV]     = &sm1_earcrx_dmac_clk_div.hw,
>>> +    [AUD_CLKID_EARCRX_DMAC]         = &sm1_earcrx_dmac_clk.hw,
>>> +    [AUD_CLKID_TDM_MCLK_PAD0_SEL]           = &s4_tdm_mclk_pad0_sel.hw,
>>> +    [AUD_CLKID_TDM_MCLK_PAD1_SEL]       = &s4_tdm_mclk_pad1_sel.hw,
>>> +    [AUD_CLKID_TDM_MCLK_PAD0_DIV]           = &s4_tdm_mclk_pad0_div.hw,
>>> +    [AUD_CLKID_TDM_MCLK_PAD1_DIV]       = &s4_tdm_mclk_pad1_div.hw,
>>> +    [AUD_CLKID_TDM_MCLK_PAD2]               = &s4_tdm_mclk_pad_2.hw,
>>> +    [AUD_CLKID_TDM_MCLK_PAD2_SEL]           = &s4_tdm_mclk_pad2_sel.hw,
>>> +    [AUD_CLKID_TDM_MCLK_PAD2_DIV]       = &s4_tdm_mclk_pad2_div.hw,
>>> +    [AUD_CLKID_TDM_SCLK_PAD3]       = &s4_tdm_sclk_pad_3.hw,
>>> +    [AUD_CLKID_TDM_SCLK_PAD4]       = &s4_tdm_sclk_pad_4.hw,
>>> +    [AUD_CLKID_TDM_LRCLK_PAD3]      = &s4_tdm_lrclk_pad_3.hw,
>>> +    [AUD_CLKID_TDM_LRCLK_PAD4]      = &s4_tdm_lrclk_pad_4.hw,
>>> +};
>>>
>>>   /* Convenience table to populate regmap in .probe(). */
>>>   static struct clk_regmap *const axg_clk_regmaps[] = {
>>> @@ -1678,6 +1902,174 @@ static struct clk_regmap *const sm1_clk_regmaps[] = {
>>>       &sm1_earcrx_dmac_clk,
>>>   };
>>>
>>> +static struct clk_regmap *const s4_clk_regmaps[] = {
>>> +    &ddr_arb,
>>> +    &pdm,
>>> +    &tdmin_a,
>>> +    &tdmin_b,
>>> +    &tdmin_c,
>>> +    &tdmin_lb,
>>> +    &tdmout_a,
>>> +    &tdmout_b,
>>> +    &tdmout_c,
>>> +    &frddr_a,
>>> +    &frddr_b,
>>> +    &frddr_c,
>>> +    &toddr_a,
>>> +    &toddr_b,
>>> +    &toddr_c,
>>> +    &loopback,
>>> +    &spdifin,
>>> +    &spdifout,
>>> +    &resample,
>>> +    &spdifout_b,
>>> +    &sm1_mst_a_mclk_sel,
>>> +    &sm1_mst_b_mclk_sel,
>>> +    &sm1_mst_c_mclk_sel,
>>> +    &sm1_mst_d_mclk_sel,
>>> +    &sm1_mst_e_mclk_sel,
>>> +    &sm1_mst_f_mclk_sel,
>>> +    &sm1_mst_a_mclk_div,
>>> +    &sm1_mst_b_mclk_div,
>>> +    &sm1_mst_c_mclk_div,
>>> +    &sm1_mst_d_mclk_div,
>>> +    &sm1_mst_e_mclk_div,
>>> +    &sm1_mst_f_mclk_div,
>>> +    &sm1_mst_a_mclk,
>>> +    &sm1_mst_b_mclk,
>>> +    &sm1_mst_c_mclk,
>>> +    &sm1_mst_d_mclk,
>>> +    &sm1_mst_e_mclk,
>>> +    &sm1_mst_f_mclk,
>>> +    &spdifout_clk_sel,
>>> +    &spdifout_clk_div,
>>> +    &spdifout_clk,
>>> +    &spdifin_clk_sel,
>>> +    &spdifin_clk_div,
>>> +    &spdifin_clk,
>>> +    &pdm_dclk_sel,
>>> +    &pdm_dclk_div,
>>> +    &pdm_dclk,
>>> +    &pdm_sysclk_sel,
>>> +    &pdm_sysclk_div,
>>> +    &pdm_sysclk,
>>> +    &mst_a_sclk_pre_en,
>>> +    &mst_b_sclk_pre_en,
>>> +    &mst_c_sclk_pre_en,
>>> +    &mst_d_sclk_pre_en,
>>> +    &mst_e_sclk_pre_en,
>>> +    &mst_f_sclk_pre_en,
>>> +    &mst_a_sclk_div,
>>> +    &mst_b_sclk_div,
>>> +    &mst_c_sclk_div,
>>> +    &mst_d_sclk_div,
>>> +    &mst_e_sclk_div,
>>> +    &mst_f_sclk_div,
>>> +    &mst_a_sclk_post_en,
>>> +    &mst_b_sclk_post_en,
>>> +    &mst_c_sclk_post_en,
>>> +    &mst_d_sclk_post_en,
>>> +    &mst_e_sclk_post_en,
>>> +    &mst_f_sclk_post_en,
>>> +    &mst_a_sclk,
>>> +    &mst_b_sclk,
>>> +    &mst_c_sclk,
>>> +    &mst_d_sclk,
>>> +    &mst_e_sclk,
>>> +    &mst_f_sclk,
>>> +    &mst_a_lrclk_div,
>>> +    &mst_b_lrclk_div,
>>> +    &mst_c_lrclk_div,
>>> +    &mst_d_lrclk_div,
>>> +    &mst_e_lrclk_div,
>>> +    &mst_f_lrclk_div,
>>> +    &mst_a_lrclk,
>>> +    &mst_b_lrclk,
>>> +    &mst_c_lrclk,
>>> +    &mst_d_lrclk,
>>> +    &mst_e_lrclk,
>>> +    &mst_f_lrclk,
>>> +    &tdmin_a_sclk_sel,
>>> +    &tdmin_b_sclk_sel,
>>> +    &tdmin_c_sclk_sel,
>>> +    &tdmin_lb_sclk_sel,
>>> +    &tdmout_a_sclk_sel,
>>> +    &tdmout_b_sclk_sel,
>>> +    &tdmout_c_sclk_sel,
>>> +    &tdmin_a_sclk_pre_en,
>>> +    &tdmin_b_sclk_pre_en,
>>> +    &tdmin_c_sclk_pre_en,
>>> +    &tdmin_lb_sclk_pre_en,
>>> +    &tdmout_a_sclk_pre_en,
>>> +    &tdmout_b_sclk_pre_en,
>>> +    &tdmout_c_sclk_pre_en,
>>> +    &tdmin_a_sclk_post_en,
>>> +    &tdmin_b_sclk_post_en,
>>> +    &tdmin_c_sclk_post_en,
>>> +    &tdmin_lb_sclk_post_en,
>>> +    &tdmout_a_sclk_post_en,
>>> +    &tdmout_b_sclk_post_en,
>>> +    &tdmout_c_sclk_post_en,
>>> +    &tdmin_a_sclk,
>>> +    &tdmin_b_sclk,
>>> +    &tdmin_c_sclk,
>>> +    &tdmin_lb_sclk,
>>> +    &g12a_tdmout_a_sclk,
>>> +    &g12a_tdmout_b_sclk,
>>> +    &g12a_tdmout_c_sclk,
>>> +    &tdmin_a_lrclk,
>>> +    &tdmin_b_lrclk,
>>> +    &tdmin_c_lrclk,
>>> +    &tdmin_lb_lrclk,
>>> +    &tdmout_a_lrclk,
>>> +    &tdmout_b_lrclk,
>>> +    &tdmout_c_lrclk,
>>> +    &spdifout_b_clk_sel,
>>> +    &spdifout_b_clk_div,
>>> +    &spdifout_b_clk,
>>> +    &s4_tdm_mclk_pad_0,
>>> +    &s4_tdm_mclk_pad_1,
>>> +    &s4_tdm_lrclk_pad_0,
>>> +    &s4_tdm_lrclk_pad_1,
>>> +    &s4_tdm_lrclk_pad_2,
>>> +    &s4_tdm_sclk_pad_0,
>>> +    &s4_tdm_sclk_pad_1,
>>> +    &s4_tdm_sclk_pad_2,
>>> +    &sm1_aud_top,
>>> +    &toram,
>>> +    &eqdrc,
>>> +    &resample_b,
>>> +    &tovad,
>>> +    &locker,
>>> +    &spdifin_lb,
>>> +    &frddr_d,
>>> +    &toddr_d,
>>> +    &loopback_b,
>>> +    &sm1_clk81_en,
>>> +    &sm1_sysclk_a_div,
>>> +    &sm1_sysclk_a_en,
>>> +    &sm1_sysclk_b_div,
>>> +    &sm1_sysclk_b_en,
>>> +    &earcrx,
>>> +    &sm1_earcrx_cmdc_clk_sel,
>>> +    &sm1_earcrx_cmdc_clk_div,
>>> +    &sm1_earcrx_cmdc_clk,
>>> +    &sm1_earcrx_dmac_clk_sel,
>>> +    &sm1_earcrx_dmac_clk_div,
>>> +    &sm1_earcrx_dmac_clk,
>>> +    &s4_tdm_mclk_pad0_sel,
>>> +    &s4_tdm_mclk_pad1_sel,
>>> +    &s4_tdm_mclk_pad0_div,
>>> +    &s4_tdm_mclk_pad1_div,
>>> +    &s4_tdm_mclk_pad_2,
>>> +    &s4_tdm_mclk_pad2_sel,
>>> +    &s4_tdm_mclk_pad2_div,
>>> +    &s4_tdm_sclk_pad_3,
>>> +    &s4_tdm_sclk_pad_4,
>>> +    &s4_tdm_lrclk_pad_3,
>>> +    &s4_tdm_lrclk_pad_4,
>>> +};
>>> +
>>>   struct axg_audio_reset_data {
>>>       struct reset_controller_dev rstc;
>>>       struct regmap *map;
>>> @@ -1822,7 +2214,6 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
>>>                       continue;
>>>
>>>               name = hw->init->name;
>>> -
>>>               ret = devm_clk_hw_register(dev, hw);
>>>               if (ret) {
>>>                       dev_err(dev, "failed to register clock %s\n", name);
>>> @@ -1886,6 +2277,18 @@ static const struct audioclk_data sm1_audioclk_data = {
>>>       .max_register = AUDIO_EARCRX_DMAC_CLK_CTRL,
>>>   };
>>>
>>> +static const struct audioclk_data s4_audioclk_data = {
>>> +    .regmap_clks = s4_clk_regmaps,
>>> +    .regmap_clk_num = ARRAY_SIZE(s4_clk_regmaps),
>>> +    .hw_clks = {
>>> +            .hws = s4_audio_hw_clks,
>>> +            .num = ARRAY_SIZE(s4_audio_hw_clks),
>>> +    },
>>> +    .reset_offset = AUDIO_SM1_SW_RESET0,
>>> +    .reset_num = 39,
>>> +    .max_register = AUDIO_S4_SCLK_PAD_CTRL1,
>>> +};
>>> +
>>>   static const struct of_device_id clkc_match_table[] = {
>>>       {
>>>               .compatible = "amlogic,axg-audio-clkc",
>>> @@ -1896,7 +2299,10 @@ static const struct of_device_id clkc_match_table[] = {
>>>       }, {
>>>               .compatible = "amlogic,sm1-audio-clkc",
>>>               .data = &sm1_audioclk_data
>>> -    }, {}
>>> +    }, {
>>> +            .compatible = "amlogic,s4-audio-clkc",
>>> +            .data = &s4_audioclk_data
>>> +    }, { }
>>>   };
>>>   MODULE_DEVICE_TABLE(of, clkc_match_table);
>>>
>>> diff --git a/drivers/clk/meson/axg-audio.h b/drivers/clk/meson/axg-audio.h
>>> index 9e7765b630c96a8029140539ffda789b7db5277a..2dd1c41d775da8f91ed281470d06e9c970cfc92c 100644
>>> --- a/drivers/clk/meson/axg-audio.h
>>> +++ b/drivers/clk/meson/axg-audio.h
>>> @@ -66,5 +66,9 @@
>>>   #define AUDIO_CLK81_EN              0x034
>>>   #define AUDIO_EARCRX_CMDC_CLK_CTRL  0x0D0
>>>   #define AUDIO_EARCRX_DMAC_CLK_CTRL  0x0D4
>>> +#define AUDIO_S4_MCLK_PAD_CTRL0 0xE80
>>> +#define AUDIO_S4_MCLK_PAD_CTRL1 0xE84
>>> +#define AUDIO_S4_SCLK_PAD_CTRL0 0xE88
>>> +#define AUDIO_S4_SCLK_PAD_CTRL1 0xE8C
>>>
>>>   #endif /*__AXG_AUDIO_CLKC_H */
> --
> Jerome

