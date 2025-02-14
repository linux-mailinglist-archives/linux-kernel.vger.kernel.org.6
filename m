Return-Path: <linux-kernel+bounces-514783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0C0A35B8B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DFA316F108
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C52325A35C;
	Fri, 14 Feb 2025 10:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="MrrZacbl"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2106.outbound.protection.outlook.com [40.107.215.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12722566D9;
	Fri, 14 Feb 2025 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739528839; cv=fail; b=kccfQKtjNtEO0pY9rMN7KmixOFXcISTyQhgmfo8sjOnMna39Ils4cwjxLOqMwoM5O8o8hYIu0kxAxsVsC5P1xwnxhfbop64G2aY2AHSvkiCi5LlAn+0Gb7muLB0EfuusFCec+DuPSUf8QynjeZSvS233gS9l9O5L6q7ZXglwMgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739528839; c=relaxed/simple;
	bh=GVcz/x15n2+sczpv3u3/X11pLkwV43U1osFvOwCDvMA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sA7f+cgTK9x/PUUCaJzWbZ/mPamdwZ+s4ZtALwUFR9Wod7SiD55v+/ot6XKz3ZQjHEKJgdv0Mw4MVTE8xN9RSPa+AHNJwzLsCwRKOtSd5JIwRBueaATGZNKIbywA+B63ei3M67uz/ADMWawXBjsSR6viseOrugk1DYpXNN8gc1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=MrrZacbl; arc=fail smtp.client-ip=40.107.215.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DuUFKmn93kASwQm2atbglX5dN/Kne1P8JMxxCCei54jCnwxMO13Yrzhf1c/6+4dBdk9D0E7nuD83GSBcZPsm7xTjarWXuJ5QHPOnN+eNN7UowaxcUyO1Kb7kd4jg58YyeNXkHhXjdWJT94Nv8IPMlhKiliDnxzEmXx94efklk8ndG83VrrrOc1au5+3nxMuwD02h0kjV3464XEkcOtK0zqrm27gcLgCP2fc9jmoC/JKAk4vt06IJpgzylRhkBVHjrA84HS3+XE8/U78wlFV3UvxSf4GH+3Zj75dULyjIBEH1bjZNSNkQzBehNb/6Pi46BYgJ8IlBWrea5+m7Wizs9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcIrworRT4ULiPU5ixvfyl9uXYXA0GA59np7yrimZdY=;
 b=IolW7Olxx1y7Fy/PC+rAp0NkWxBzhTFv5q6Ec/NDl6XPR42xUG34MELpdqmTzUcf5t4IyWXDKcF2CqfI3/ujbxz3n2chpk/x0hY2Iw1g0mWIEMX2fAxwAaHtsDrAqNkQYd/KfuQChTtp1bxhJJT+bQLxz9BGxEjK37OpHEWtd/H4pKKBklJMtxf1+A0EGvH1qg+GOHk3nNWj37Yc5te5CW3CxBkJcn6Hm9GTP51TnZ4mfweJ4upqoXkf0o5rCPCNkJh3/GL7LOTcA850eDvlYrucMNleKepF0FU5j4L/QCWdNmchPtW+Vf+CPuwhuMqf6Lw/RrPoPVe0+sRyYBW21w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcIrworRT4ULiPU5ixvfyl9uXYXA0GA59np7yrimZdY=;
 b=MrrZacblEmf3JDGNHI5Yxd+Iu1is9oTSsZHpyUapVR6thHAb7Lezz8pRDlshXY7JZHNd16TcOZVa4cTM93PmvMaogIeCqTkXlR3InAiAz+WwFdL08r7BGfz/tIniSsgnl+sawRRGHKQYJUlcuDpMUDmnM0z8j0Dq6VNoHdYWTNYY4Wu3XZ7skR+WsuRejAfSuJOBxWAJvmbSqRGDrOOAANnrFCxUzOpz3RmEFEAWM6xX6G6nB99sd57dhWJTXxtO1fIpjsSbE/2c9LMGKwDiIitaDKRTYRfPvm8fg7cwgBoe0wCjJwnYFAzITrKBiQUynws8CJQL4o7cRX1HczFVwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PUZPR03MB7135.apcprd03.prod.outlook.com (2603:1096:301:113::15)
 by KL1PR03MB7150.apcprd03.prod.outlook.com (2603:1096:820:cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 10:27:12 +0000
Received: from PUZPR03MB7135.apcprd03.prod.outlook.com
 ([fe80::ecac:a387:36d8:144d]) by PUZPR03MB7135.apcprd03.prod.outlook.com
 ([fe80::ecac:a387:36d8:144d%3]) with mapi id 15.20.8445.015; Fri, 14 Feb 2025
 10:27:12 +0000
Message-ID: <53276a7d-20c8-43ab-bc44-84dbc50ebca2@amlogic.com>
Date: Fri, 14 Feb 2025 18:27:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] ASoC: meson: s4:support audio tocodec
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
 <20250214-audio_drvier-v2-4-37881fa37c9e@amlogic.com>
 <1j34ggzwel.fsf@starbuckisacylon.baylibre.com>
From: Jiebing Chen <jiebing.chen@amlogic.com>
In-Reply-To: <1j34ggzwel.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To PUZPR03MB7135.apcprd03.prod.outlook.com (2603:1096:301:113::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR03MB7135:EE_|KL1PR03MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: 89c3412a-b28e-4466-6835-08dd4ce224af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXVoZ2lzYmJWakFUUXl3bnU2RWR5WWl0cUVxYWpUUFNXTTR3VEZCOG9kRHZW?=
 =?utf-8?B?UWpaTnF0RWpvbFlVNms5UGhjU0FHU0twZEFocElTRU9wa2JVSUtKUEV2dC9B?=
 =?utf-8?B?MVFpYzJVMjFvUVYrYzN2c0YyLzZCcWdxS2Z0ZVhqQmhVbTc0MUlJRGdsZm5K?=
 =?utf-8?B?WkhMUkNmejM2c0Fpa3FTd0l0ZHo5NTF0dEpzdjFKTGtDVUFoR0pXNjR0bjZ6?=
 =?utf-8?B?TWNEZ3lvS3hkaDkzQ1NDcDQ4aEpRZU5WdEpwdW42TWJKT2ZyYTZLdDFPUCsx?=
 =?utf-8?B?alJkZHpQTUllK3FwL29NelNEN0dKdkQ5S1VTdXk5SXEzZXhZdTJIV2JuanFi?=
 =?utf-8?B?NnRKWXRKVFJzSzBuWUJiQzFKZWlFRFdOMWRmL2MxaDhSU0xJNGk1MzJCcmpk?=
 =?utf-8?B?OVYzSzY5bkhJUWpxMHFaOXR4ZjhZNmpZNEczV3RXTnp2OFR1TDlENmdNRDEx?=
 =?utf-8?B?L1JvZ0p6TU5mNHB5N2FvUG9hMk5ieXUxQkM5a0hmUEpvaDlib0ZTZnFwQWZS?=
 =?utf-8?B?Y2JjMTBzVWRHSUVpS2tvUXJ1ZTh4S0NuK0pNeXFmcjRzbHhnSTFzMjN6allM?=
 =?utf-8?B?SzYzT25wY2toVjJEUHFCSDNSb1lDNFdKd2Vuc0c4dW5EU1RCbmVjcTVBMDZq?=
 =?utf-8?B?c1Z6Q0ZqaHM2ZHJCMWVJcVZ6S0Z1bUVCa1ZTaTBaMmxSbjVZeW1OcWsxNkJJ?=
 =?utf-8?B?WE9PM2lyV0F5Z2dRRWhTVFAwRWxoVWZGVnk3SUJhWFZ1eHhnRlZzaEYxNGNH?=
 =?utf-8?B?eEhPN0ZjdXpVZ000alZBTExmNTN1RFBuSHJibjFyK3ZkcEUvUkdKUHVPOVBv?=
 =?utf-8?B?emUvZG02RGtEVFFieFRabTVYeUo1VUx1T1doczJQSXU2YUpJdkx0VGJYM1Bu?=
 =?utf-8?B?U09DSnFkd0xMTGpTS1pKMWxKTngyamxNSW13bzRZQlNHVjV3MC9IWmR1dXJ5?=
 =?utf-8?B?eE0wQ253TG95a0trTUQ4NlBGeFh5SFhoSUdYM1R5RnhqUWNUZERIb3lKbG5H?=
 =?utf-8?B?N3JnS1puV3p5U3k0N0lkTlUxVHJNWGJ0dFdjMDgwMnphRnFuOVR6K0xqN3BQ?=
 =?utf-8?B?RHdTRmpSa0RJRjhMV045OTh3WG5VSEFpSnJybCtCVDJBMFZXNUk0RmtpQkJq?=
 =?utf-8?B?UmdUV3lCWUw0bkVSS1pxMk0yRURWVS9OUlhBbkV1YUhYMXhFNndyQi9Sbmxh?=
 =?utf-8?B?UWEzRnlkc28zbFRTVEVKTnNzdGRLM2JlSi9xcVRxU3oxNjRhMDRIMXp6c2ZB?=
 =?utf-8?B?QWM3aWpFMjcrTmhLZ2lReG9JQTBvcHlPdFhVNFJpZUU1QkkwNkdVMkRYc2NP?=
 =?utf-8?B?c1AxTmd4VXRjbjhnNDV2NUVxZTJMKzNoMFozVXB5RWxjamxGMXRBWUFjTG4w?=
 =?utf-8?B?dCttT1UzaHQrSTNNRGF6TlNZRkJScmRzWktBWGpwOGEzVnBwUDh0SjhJcFI0?=
 =?utf-8?B?VmtLL01HYUkwb1pCR0hsc2ZQdExOR2pKelFIekI3VEVnQnlOa2s1WmJBejZI?=
 =?utf-8?B?SmxFdHFJZlpCaFBQQlU1eWVZdEJGaGZJWC9lK2kxM0lyWVhUZ1lDdHVDU245?=
 =?utf-8?B?Z0Y4SVhLRW15RjFIY3hMdjFJNWdENWJlUzRuaWtMR08wSGpFSlhJNk1sdGN3?=
 =?utf-8?B?WmVReldLWFd3ZnpxYy82Kzl6d050SjVNb080Um51NEpCdXBISlYyWnFYZXlU?=
 =?utf-8?B?dVNBcDNPVVZHaWMrSzNNaHo1OHBtKzJQcGtCbVhJOHM3MzMydS9RSGZJL0NT?=
 =?utf-8?B?ZmV2TE1jNGR1bnZ1ZmQvY0ZwUmhIYjFOenUwL3VqVkhLUEtNcE81b3JyRUpJ?=
 =?utf-8?B?ZFU1eTB2YTVOY1F5YVlTSi9PeE1UekovVzBJQVZrK0lTMy9Yb1Z5a0V4VSt4?=
 =?utf-8?Q?5TlDZ/NLwDZ13?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB7135.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWlmZHU1VUlkcUVvUkNVZnFxN01QTDEvdFRkMThjV1ZRUEJwS0ZzNEZsblFs?=
 =?utf-8?B?ZjVYQ2Vpc1FPazdrdndtdG9pMFdVMEFpaU1oMEVBU0JaMW1lZC85a1pXQUdI?=
 =?utf-8?B?SzczUmE5Q0NPS0NDOGJvL0ozeUJ4UWkrZGdzTVdNd0Joc0JFaDhpRWFWZ3Z5?=
 =?utf-8?B?M1h3MEdPZ0pkSGhFd204cGNmWlVqeElMdmhKdm1MNDIzSGtXVlhENloxaE1m?=
 =?utf-8?B?YmxvVmE5ekxoc1NMbmlxUC9lRzZpTVpmaUtPVnJ0QTNZcW0ya09taUlNV09k?=
 =?utf-8?B?WC9PcU1ZeVhsZTdLMmt0MVNpTk1UOWZWQTFqb3FWUFhjREpDcEhQOGtkVUFp?=
 =?utf-8?B?ZGQ3VGs3MHlaNUR1aEt2VkdyUGdldWdMOGUxdW10MEgvbXBVNk5CODdTZFBn?=
 =?utf-8?B?QytFUHhPRllEd2N0WFpSMk1YTE8wZWhaSUZhRzJmR3IrRWlJcGxhU2E2RzFV?=
 =?utf-8?B?dytkSzV0NmdzTDdWck9iWlozSXZlY3pOdENsSWpkV2pVV3d2NFpRNXR5YStJ?=
 =?utf-8?B?V3p3SWhyRTc0Q2ZBaXlhNHVuQnZBVFVXbU8vellQSU5YcUJwTHdiMFRyMFVG?=
 =?utf-8?B?N2U2WXZjcy9zMmR3Ym9JczNJNmhBZmp3NUlONEVmNXlkYjkvWlhUREhObnA5?=
 =?utf-8?B?UDlzVlpkdHZCUDhEcW1uTFNpREZzUGQvQWthRURFMTZCaVBjV2dYQ29KRUxX?=
 =?utf-8?B?WWx5TnNWUGlrS29DcnJoNm1NaXo4STdaNkFiZmtwb3JpWjJJRkJ5elVNSW40?=
 =?utf-8?B?NGdkYm43ZkErajArRXA1Mm5qdlJwNURzWjdocnhNU3JML1N3RFJVcG5xa1lG?=
 =?utf-8?B?L2dGVVE3TklNdzRSdXlCbFd4bkVyTUpNQm41UGtQZWtLMVpSSmxlK2Frakxn?=
 =?utf-8?B?Q1l0QStIcmpPTkRMYy9Bb1JDNy9rOHVIM0lKV3kzRkpyRE00cDF6K1MzZWxs?=
 =?utf-8?B?RXpxcjQ4Vk9Panc4NUU2ZnE5WTVDQlVYeW5rWnZiMHllL05BYU5MQnhNL3JP?=
 =?utf-8?B?eHF2Zm5FNU90cFpYRWs4NkZLR0hzemtGRkx4a01UNGJ0TG1DbFJWTWZmT0Vx?=
 =?utf-8?B?NVZrdlFpWmlOMjR3ZGpldVk0LzFKdE9hUWN3YVNaM3Ywd2dSTitCSlo4ZTM2?=
 =?utf-8?B?ZmFaV1B4dGxxTTlGZ0NvVXdZRUJYRFJ6UjlSOWl5ZEY5OGtMeENOdkdXYnJw?=
 =?utf-8?B?c0VLTExvWWR4THVBaEJNQ1dFSGdmSDJIUWVoVHYzWnMxT2dUcFFEN2NIUTJ5?=
 =?utf-8?B?UGRmeHphWTN4MWpscUNxdVh6NlhhampjMUZTRHVJOHVVZ1ltb1ZBVUY1UVNF?=
 =?utf-8?B?TTM1L1cxd21tRlFFTkFYeTZxV2FMZVEyVmNwUmptUHlUQzVUTmhHU2VTQ1VG?=
 =?utf-8?B?S1ZhYlNuMlZ3c01vdWtXZk9VY0w3VmVXK2J5RDJSSkxiSTBNanA0UXhZY1g4?=
 =?utf-8?B?bTdYYko3VWFjUHg5RzUwaWsvRG9qMitMYmorSEozbjhBTUNKaWxBNDk2WTZ4?=
 =?utf-8?B?OG9mZFd0M0I5RUVsa1pyM3lMeWl2a1A5VWNVblg5cmJETnM4Y1hFSE9rUmp5?=
 =?utf-8?B?dW1OZTJ4aW9uRXMyM29aTHphN3BRTXRMWVhFTTlXYXMwRXpLakwrN0RpSUV6?=
 =?utf-8?B?NkZDYWd2ZDd0Smt4aWlxc3Btd1RRZnJMbGEzZ3RuQjUza2EwUGVwZjZBMTlH?=
 =?utf-8?B?M1d2WXBvakkrVFRkVEMzWkR1NWxhaWp2SXRUbVZDWE1kaVI4UDc1TzM0Vmdj?=
 =?utf-8?B?T0lLRDFmQmhRSmM3dlZpcExIb2tCTzc1TldFTVdnOFgvZjFZYndweGFqY1BW?=
 =?utf-8?B?bHhDcmpsUEJ1Z1h1NXBGckVaeE0ydjRLUC90eUVNeEd1YlE2WWxSREtiQkpl?=
 =?utf-8?B?SG15bU12VnFiQkJuMWdIYU1VRjFRaTFSOHhiTGVMUHhwL3hHV1YzT01INWdx?=
 =?utf-8?B?RytmdlJKRjZ4R3FydGxpeElHZDFIVVVBRnRiS3Q5TWk2Z1BLK2dOd29Gc0dY?=
 =?utf-8?B?UHc2bjRMY2JZQjJrbWtYOUZJMzhvL2sxMCtJYmFkeDluQ0xPMkE5NzF6ODF6?=
 =?utf-8?B?Y0JlVjBEMm9xalg2ODRIRkVxeFNqTWkxT29NRWJXbUlqVmgyRUg0NHJlUHc2?=
 =?utf-8?B?Qk5BOWVDM0VVb1lMQ1B0U1dhbTlSNmNsUVk2WFBJYnUzd2F6N1l2anJsOWFt?=
 =?utf-8?B?NHc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c3412a-b28e-4466-6835-08dd4ce224af
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB7135.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 10:27:12.0291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xzc5tuYlDN8ZRBIvNeCIIH3K/MW+DE/0llg1mU0/9DKwx6/y5afYNZabr+v4xUT0SCgNzBx8yl0MhbcOhRfGRgz1IXNdMl7Fxt9BvCpkHQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7150


在 2025/2/14 17:51, Jerome Brunet 写道:
> [ EXTERNAL EMAIL ]
>
> On Fri 14 Feb 2025 at 10:13, jiebing chen via B4 Relay <devnull+jiebing.chen.amlogic.com@kernel.org> wrote:
>
>> From: jiebing chen <jiebing.chen@amlogic.com>
>>
>> Add the audio tocodec for s4, add the 8 lane support,
>> add the mclk and sclk enable event when start data enable auto switch
> Again, incomplete description and mixing things together.
>
>> Signed-off-by: jiebing chen <jiebing.chen@amlogic.com>
>> ---
>>   sound/soc/meson/axg-card.c      |  3 +-
>>   sound/soc/meson/g12a-toacodec.c | 64 +++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 66 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
>> index a2dfccb7990f3a53f508fc6724b21de53b4494d8..5cef069c3370257d4aaf24d7270482651babcfe1 100644
>> --- a/sound/soc/meson/axg-card.c
>> +++ b/sound/soc/meson/axg-card.c
>> @@ -303,7 +303,8 @@ static int axg_card_cpu_is_tdm_iface(struct device_node *np)
>>   static int axg_card_cpu_is_codec(struct device_node *np)
>>   {
>>        return of_device_is_compatible(np, DT_PREFIX "g12a-tohdmitx") ||
>> -             of_device_is_compatible(np, DT_PREFIX "g12a-toacodec");
>> +             of_device_is_compatible(np, DT_PREFIX "g12a-toacodec") ||
>> +             of_device_is_compatible(np, DT_PREFIX "s4-toacodec");
> There is no need to extend that indefinitely, use fall-back
>
>>   }
>>
>>   static int axg_card_add_link(struct snd_soc_card *card, struct device_node *np,
>> diff --git a/sound/soc/meson/g12a-toacodec.c b/sound/soc/meson/g12a-toacodec.c
>> index 531bb8707a3ec4c47814d6a0676d5c62c705da75..a93a91136e8ea00e856c3981b9c1e7e08d927a3b 100644
>> --- a/sound/soc/meson/g12a-toacodec.c
>> +++ b/sound/soc/meson/g12a-toacodec.c
>> @@ -41,6 +41,9 @@
>>   #define  CTRL0_BCLK_SEL_LSB          4
>>   #define  CTRL0_MCLK_SEL                      GENMASK(2, 0)
>>
>> +#define CTRL0_BCLK_ENABLE_SHIFT              30
>> +#define CTRL0_MCLK_ENABLE_SHIFT              29
>> +
>>   #define TOACODEC_OUT_CHMAX           2
>>
>>   struct g12a_toacodec {
>> @@ -107,6 +110,33 @@ static int g12a_toacodec_mux_put_enum(struct snd_kcontrol *kcontrol,
>>        return 1;
>>   }
>>
>> +static int tocodec_clk_enable(struct snd_soc_dapm_widget *w,
>> +                           struct snd_kcontrol *control,
>> +                           int event)
>> +{
>> +     int ret = 0;
>> +     unsigned int mask = 0, val = 0;
>> +     struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
>> +
> Over complicated for no reason
>
>> +     switch (event) {
>> +     case SND_SOC_DAPM_PRE_PMU:
>> +             mask = 1 << CTRL0_MCLK_ENABLE_SHIFT | 1 << CTRL0_BCLK_ENABLE_SHIFT;
>> +             val = 1 << CTRL0_MCLK_ENABLE_SHIFT | 1 << CTRL0_BCLK_ENABLE_SHIFT;
>> +             ret = snd_soc_component_update_bits(component, TOACODEC_CTRL0, mask, val);
> All this could be done in one line and be actually readable if you
> properly used the BIT() macro.
>
>> +             break;
>> +     case SND_SOC_DAPM_PRE_PMD:
>> +             mask = 1 << CTRL0_MCLK_ENABLE_SHIFT | 1 << CTRL0_BCLK_ENABLE_SHIFT;
>> +             val = 0 << CTRL0_MCLK_ENABLE_SHIFT | 0 << CTRL0_BCLK_ENABLE_SHIFT;
>> +             ret = snd_soc_component_update_bits(component, TOACODEC_CTRL0, mask, val);
>> +             break;
>> +     default:
>> +             dev_err(component->dev, "Unexpected event %d\n", event);
>> +             return -EINVAL;
>> +     }
> ... and nothing explains what is being done and why ...
>
>> +
>> +     return ret;
>> +}
>> +
>>   static SOC_ENUM_SINGLE_DECL(g12a_toacodec_mux_enum, TOACODEC_CTRL0,
>>                            CTRL0_DAT_SEL_LSB,
>>                            g12a_toacodec_mux_texts);
>> @@ -143,6 +173,14 @@ static const struct snd_soc_dapm_widget sm1_toacodec_widgets[] = {
>>                            &g12a_toacodec_out_enable),
>>   };
>>
>> +static const struct snd_soc_dapm_widget s4_toacodec_widgets[] = {
>> +     SND_SOC_DAPM_MUX("SRC", SND_SOC_NOPM, 0, 0,
>> +                      &sm1_toacodec_mux),
>> +     SND_SOC_DAPM_SWITCH_E("OUT EN", SND_SOC_NOPM, 0, 0,
>> +                           &g12a_toacodec_out_enable, tocodec_clk_enable,
>> +                           (SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD)),
> Drops the .autodisable without a even comment
>
> AFAICT, could be done like the other SoC with SOC_SINGLE_AUTODISABLE()
> with properly chosen values.

you mean we can add the New switch for auto enable tocodec mclk bit[29]

and tocodec bclk bit[30]

static const struct snd_kcontrol_new s4_toacodec_mclk_enable =
     SOC_DAPM_SINGLE_AUTODISABLE("Switch", TOACODEC_CTRL0,
                     CTRL0_ENABLE_BCLK_SHIFT, 1, 0);

static const struct snd_kcontrol_new s4_toacodec_bclk_enable =
     SOC_DAPM_SINGLE_AUTODISABLE("Switch", TOACODEC_CTRL0,
                     CTRL0_ENABLE_MCLK_SHIFT, 1, 0);

add the route path


static const struct snd_soc_dapm_widget s4_toacodec_widgets[] = {
     SND_SOC_DAPM_MUX("SRC", SND_SOC_NOPM, 0, 0,
              &sm1_toacodec_mux),
     SND_SOC_DAPM_SWITCH("OUT EN", SND_SOC_NOPM, 0, 0,
                 &g12a_toacodec_out_enable),

     SND_SOC_DAPM_SWITCH("MCLK OUT EN", SND_SOC_NOPM, 0, 0,
                 &s4_toacodec_mclk_enable),

     SND_SOC_DAPM_SWITCH("BCLK OUT EN", SND_SOC_NOPM, 0, 0,
                 &s4_toacodec_mclk_enable),

};

static const struct snd_soc_dapm_route s4_toacodec_routes[] = {
     { "SRC", "I2S A", "IN A Playback" },
     { "SRC", "I2S B", "IN B Playback" },
     { "SRC", "I2S C", "IN C Playback" },
     { "OUT EN", "Switch", "SRC" },

     {"MCLK OUT EN", "Switch","OUT EN"},

     {"BCLK OUT EN", "Switch","MCLK OUT EN"},

     { "OUT Capture", NULL, "BCLK OUT EN" },
};

add it replace auto switch event, like it ?

>> +};
>> +
>>   static int g12a_toacodec_input_hw_params(struct snd_pcm_substream *substream,
>>                                         struct snd_pcm_hw_params *params,
>>                                         struct snd_soc_dai *dai)
>> @@ -236,6 +274,10 @@ static const struct snd_kcontrol_new sm1_toacodec_controls[] = {
>>        SOC_SINGLE("Lane Select", TOACODEC_CTRL0, CTRL0_LANE_SEL_SM1, 3, 0),
>>   };
>>
>> +static const struct snd_kcontrol_new s4_toacodec_controls[] = {
>> +     SOC_SINGLE("Lane Select", TOACODEC_CTRL0, CTRL0_LANE_SEL_SM1, 7, 0),
>> +};
>> +
> No. there is no reason to add that for s4 and not for sm1 which has 8
> line HW support too. That clearly shows up with #define used.
>
> If you must do that, please do it correctly without leaving the other
> platforms behind.
>
>>   static const struct snd_soc_component_driver g12a_toacodec_component_drv = {
>>        .probe                  = g12a_toacodec_component_probe,
>>        .controls               = g12a_toacodec_controls,
>> @@ -258,6 +300,17 @@ static const struct snd_soc_component_driver sm1_toacodec_component_drv = {
>>        .endianness             = 1,
>>   };
>>
>> +static const struct snd_soc_component_driver s4_toacodec_component_drv = {
>> +     .probe                  = sm1_toacodec_component_probe,
>> +     .controls               = s4_toacodec_controls,
>> +     .num_controls           = ARRAY_SIZE(s4_toacodec_controls),
>> +     .dapm_widgets           = s4_toacodec_widgets,
>> +     .num_dapm_widgets       = ARRAY_SIZE(s4_toacodec_widgets),
>> +     .dapm_routes            = g12a_toacodec_routes,
>> +     .num_dapm_routes        = ARRAY_SIZE(g12a_toacodec_routes),
>> +     .endianness             = 1,
>> +};
>> +
>>   static const struct regmap_config g12a_toacodec_regmap_cfg = {
>>        .reg_bits       = 32,
>>        .val_bits       = 32,
>> @@ -278,6 +331,13 @@ static const struct g12a_toacodec_match_data sm1_toacodec_match_data = {
>>        .field_bclk_sel = REG_FIELD(TOACODEC_CTRL0, 4, 6),
>>   };
>>
>> +static const struct g12a_toacodec_match_data s4_toacodec_match_data = {
>> +     .component_drv  = &s4_toacodec_component_drv,
>> +     .field_dat_sel  = REG_FIELD(TOACODEC_CTRL0, 19, 20),
>> +     .field_lrclk_sel = REG_FIELD(TOACODEC_CTRL0, 12, 14),
>> +     .field_bclk_sel = REG_FIELD(TOACODEC_CTRL0, 4, 6),
>> +};
>> +
>>   static const struct of_device_id g12a_toacodec_of_match[] = {
>>        {
>>                .compatible = "amlogic,g12a-toacodec",
>> @@ -287,6 +347,10 @@ static const struct of_device_id g12a_toacodec_of_match[] = {
>>                .compatible = "amlogic,sm1-toacodec",
>>                .data = &sm1_toacodec_match_data,
>>        },
>> +     {
>> +             .compatible = "amlogic,s4-toacodec",
>> +             .data = &s4_toacodec_match_data,
>> +     },
>>        {}
>>   };
>>   MODULE_DEVICE_TABLE(of, g12a_toacodec_of_match);
> --
> Jerome

