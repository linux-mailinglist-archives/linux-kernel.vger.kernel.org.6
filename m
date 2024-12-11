Return-Path: <linux-kernel+bounces-440890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C97C9EC605
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0BCA2817F4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 07:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9891CACF6;
	Wed, 11 Dec 2024 07:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="ZxHr8Qmk"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023136.outbound.protection.outlook.com [40.107.44.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97832451E2;
	Wed, 11 Dec 2024 07:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733903649; cv=fail; b=Zr4RkZnlcCT6/yH/lElfL2w63symcozaFTQia+mgFBKmGRqOclebxtuWw7hqG7YZrQ4Tds0IxpFV5DbC8Li/RheiXShrYUvEgsebqEqYZsorq0lzoo0o7fM3EPRWZD1a3D6POpRe74CyFmUeAvLcFn3Vf3lu+ON7EiY9SuE+QUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733903649; c=relaxed/simple;
	bh=nCXlfwnjXSIKJEVkpBgAcLCjJWgD36HKTpffEwy3BM8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZDQ/HpDnLRN4t0AwMd0M4bTaSvenRi483tqB9tI0VlOObmJ9QKN/5QpG6wmU/mlVfDlcRuqTMnBxatg2cje0KgK8ljVY3itr1xXXZvs/OSVqKkfvqsmEDwt/OTMLjpl3qEtXNdTWYkK+sQJZIGHG1NRaD97ing3nnQdWz4Szr0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=ZxHr8Qmk; arc=fail smtp.client-ip=40.107.44.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=botJONRrxFSolfmR9olGHoe+sHJUUd01kbQDkBFZ/UD++o8Q0FRZfXF/51tXnWEV+klLZghCjBI3XNODFXJAlfFC1MrJtpHP/rivqNKz3GpxUIsYib8KRsmDQ5isLlZUUX1f8QivZEJiNCn2piVvZKK7h/p4wBwJHS4zBdWjlMrPl5ImbzqQSCHfPbvlD0neW7Azsfeo8mmUNL+IpEZPbAYNls1Lw6Chw1fkf41/B12HWac4FbSicUxZC67qU6zLOpbX6hUX9Nlh8kYFqx71w5adWmyK6/640Y/gEUTwG36KmRuNT82ytFyNCsd7doNPpTgFCBPeCXoikhpgysJH4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzMUbfR52GyWiInJA1q7VGtz0BvZZPETAoazXH/jPoI=;
 b=CSQCXXP46l8n3GbmuGooZNAXWIAB8woYwcuKGZbwXjOVNbkzP9u/msgRd/TisCLLaHyEyKCdmfW7yfI4KQKB2UdabhjvTR2IKtebpD6x7Rv4Wy4IJruYrF59ub9fYFRWdaEBcCcn/b9ojlEfr3by6O2C04+UAbiKo5KvFzTp6OtnHh4lHr0R16Bq/ZX47pizhvGFdTbwvm0GAX+OqbcNIqYbte3+/O5M11LqWzc26E8o3O6Bq5pqhqGVl3nxQhZxXbawkJQzfffH9biaRKYIV7+lzsojZ0l2IXjL/9Ox2iHVmOz07NPNmgZ4STlUCsJqjGlzaRE7Wdi4A+Q/Q50XYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzMUbfR52GyWiInJA1q7VGtz0BvZZPETAoazXH/jPoI=;
 b=ZxHr8QmkFAz7KnVkdqgyWzJrEE1LgtYwugFdzfn4ezaa7PBn2ogR8Ku+htOklYJl1VfNR1kbhN3ZXrNksgV3wAuVLuK6t3f8CnsKcasjZu342mxiWYVSMxZ2fSis+xOWHKQqFjGLy14PUzHbHpQ7rmF1wpSKDM/ChzAuz7Szu1QkuCVCtkgbpFN1iw6c2fS94WqFhiXdBrsrqwGhRaL1Et8Dt9D+UfrS4jYANEy4vV3pNsD3cZKHSaaxVpFaoPxj79dYuLniGy1pH/p/xjyJTdDqCq1a0Adq97lv7oLfqpKwMpbz1cJ0yvwrBnOti2f6Y/mxWhfFMOYCh/tTNMJCFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by JH0PR03MB7982.apcprd03.prod.outlook.com (2603:1096:990:36::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 07:54:02 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%7]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 07:54:02 +0000
Message-ID: <e5085ed9-191d-47b2-9728-22962673af02@amlogic.com>
Date: Wed, 11 Dec 2024 15:53:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] clk: meson: add support for the A5 SoC PLL clock
To: Jerome Brunet <jbrunet@baylibre.com>,
 Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chuan Liu <chuan.liu@amlogic.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20241120-a5-clk-v2-0-1208621e961d@amlogic.com>
 <20241120-a5-clk-v2-4-1208621e961d@amlogic.com>
 <1jttbvtfxv.fsf@starbuckisacylon.baylibre.com>
Content-Language: en-US
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <1jttbvtfxv.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::8) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|JH0PR03MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: d9a38005-0538-49f5-ba3b-08dd19b8fa36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WE9XUmNVbXByOTU2cVFvSVZnTHNWU1pKS2p6emNWclUxbkQ0Q3plWENPNzVL?=
 =?utf-8?B?UE1mRXh3a3hMV3FxbE5WdVBwTnJicVR5bk9rT2N6OWVEa0piZzBNOHVnVDBS?=
 =?utf-8?B?YW5yYzRCMk1iWlpMQ2YvM2c3dGFMMzFuZjAwS1dRT0ljempPZnM0TmFRNlBZ?=
 =?utf-8?B?dkJJYnJ4OFBaL3kwQithQXRicmQ3RFRGaHRKVU9wRklNOGU4QnlsSC9GZ3l4?=
 =?utf-8?B?YXI0R1NGQ3VGcEdTWldMWHdlbGJsbFlQN1BJQlJ2MzlUd24xVnNLVlhaVDZq?=
 =?utf-8?B?TkhIVlhJZVlxQzZwUkVaekxhZUlxbytRS1IvU2JHVE5nTUVuQTBsbGFmRy9F?=
 =?utf-8?B?Zy9SekVCcmRDdkM0bzRzVzJRMjJJT1ZBQWZseG1WTnRZNVpNbUt5aWVraytG?=
 =?utf-8?B?RDdvUEpmYTVhd0pWbHQ4cnVCYnZOeWhXaytrSGxDSkVKbHhyT1RGT0NodVpK?=
 =?utf-8?B?Yng0cVh4eGlWQVA5d1pFc3pFUlljSzJBZ3I0ZFFKZStSQWxVRTdFTkplNTE3?=
 =?utf-8?B?d0pVK1M1UnBxY3hvNDZhL2lPTVc4dVJFWkVGdG5wZWNXWHBvbmFVMkJCWmg0?=
 =?utf-8?B?OTlMZkRnSklQNWZhejNpd0JTaW5DenZkUEszb3ZLU0NpUWEzcWJVTUZLMU1O?=
 =?utf-8?B?K3hPdDBrZ0t2QTNpMjIyRVFMR1AwSmlWQzJKY0ZnV2Z0ai92WkloZlgrL3Yy?=
 =?utf-8?B?OEgxK2pkajN4WFFlMVczSzk3b3NiQzZFcU5OY1h6ZDlNL2QzdjhHWVZFSkIz?=
 =?utf-8?B?S052Mzl4dkJncE5GTmV6dERNOGRpem9BMGl5NDNmOEZUSWtxL01lbDluc1ZN?=
 =?utf-8?B?dlRQUnpKNXAvbXZRTjBncXNjbTlOUW9Vd2VWb0ZIWVRMaFV4VTNsRWs4cnJo?=
 =?utf-8?B?OEtLT0Fka05IREQ5d3ZCRmNxV2hFTjRlVVdwcm5IM1ZkRDI5dUlyT0NJYWVj?=
 =?utf-8?B?UU5CU3Y4RkNkc0ZGQzVlWEI4NUlqSndXK1JCTkY4UmNqTmRMTXlhTVcxbkNR?=
 =?utf-8?B?VnFqMXlOS0JOVEM1SnBiWDE1ODFNMi9keFA0Wk45cm1USUpqUlJHQ0xjeUZw?=
 =?utf-8?B?OGtaUkpmY3FBalQ1ZVRtWWtNWmlIRDc5UisvSmE3Z0c2alU5M3prK1FnYStU?=
 =?utf-8?B?OWxvOUJwSWlVdHRCRmRPRlpDUndCMTdsZm85K0lkcXpXZDZSTk5mSkFiSlRx?=
 =?utf-8?B?Y0lwZjhnMmcxYjFKdElJS0xFTzdzN2pIWGtxZWpoREkxU1YxOTRWM2x5RXVK?=
 =?utf-8?B?TEdiOVhXcVcrT0hYQ1lEY2t2QjVhR2thOVB1VmRJcFAzNm44eFZnUm1FMkRR?=
 =?utf-8?B?N3M4a0FLMGw2aEowRll1K2EvaGo5WjkvV0hKTFE5aEVYN2RZU0JuQkdFVG5J?=
 =?utf-8?B?WEpCTzBGK3Frc3UrVlJKZmhON3FnaE1xeHBxKy9wb1VTazdBVXkrOUwvYTJV?=
 =?utf-8?B?RjRoT3d4aDkxK1ZvdXFTblBXS00rT2JjeG9uamY4OXA4bHFHNGVWQ0lxY2F2?=
 =?utf-8?B?YW1QeGJ6RUlCbk5ETitFMG9wSExuUU5JRW1pTkc5YTZ6amdYQXR4TlUycHg0?=
 =?utf-8?B?OVE3cktNRkJFOHdrME9YYmR6YURaNmtjYnY5Qk80RDdacUxGNTcyeWZJWUZY?=
 =?utf-8?B?dVpUZm53bzVKRzc3QjdBZ3JqYTNLSXo4b2hLMGhaZU8wNUppbWZ6TE8yZVc4?=
 =?utf-8?B?NkU5L3VoNUNJNDRHRVhxclBYRkxtR3lkeW5ZMktha0tCMzRFSGRkKy9TdG1k?=
 =?utf-8?B?Yk43UmcxSjMxaGh2aUd3VmY4REtSN2RZQy9IVm84UmxVdGp1SmwwMFJMcHZF?=
 =?utf-8?B?RUJZNHNtM3ZZdVk3djMvQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RW96QmRGdkJqODZjczNUWUExN0M5RmdjenlFVEhNNkpvZklWZDlCZnBncEFo?=
 =?utf-8?B?cnVBRmRXbDlDQ0N1bUtZTVhCZ1prdlpvRVVzMWI5eTVJbzJjMERxeVk4dC92?=
 =?utf-8?B?OERuQ0JSMVBEN2IwVTM3cGlQVTIwSEh1cC9aOWdOcDV5TWY2czNIMUFrTWsx?=
 =?utf-8?B?Y1pLZmRXVVBTQXlIZFNaZVFXTTNyeGxiWHpFbElqRE1aV0I5YUNEWll1aXRn?=
 =?utf-8?B?NHAyeVJGaGFrd21PUDBkTFA5UTZuNFZmNTFxTnN6OU5DYitWaUxuQmprbTBE?=
 =?utf-8?B?SFFmT25ZdHM0MGtvbm1rTFRvd2RVUmRvbE50aGwvOW92RFQrUG1IbmtNS2Jz?=
 =?utf-8?B?dTVYMGNRa1J0OWQyTFlDUnVWUGUyZVRKTDg2dUFkVmZOU2JJMDlYbmpLdVZK?=
 =?utf-8?B?bm4xYjZaNjFRS3Q3OFlKeFlsOVI2R0I3RkZhYUNqMFFKcWkweTFYb0s1cTBM?=
 =?utf-8?B?UEEydUpjRFNUMHhaWnEvbjV4dk9qZWpJMCs4WUNLdUErL1ZBVmZFU3VyblNF?=
 =?utf-8?B?TGJvNjdjWi9ncXl3akZvNXd6Vi85d0gvZG5RdzJIZmFSU1g4dEtqd283Nkcv?=
 =?utf-8?B?STN5MzhLVzc3M2c0a2RNOFdIc2xLTXZBN2I1SURvSWNWTVc0SFhqckFsV3lz?=
 =?utf-8?B?bFR2S0JwcHpXQ2Q4K3llSWZVT25hTStwbE55LzhFY2xuWmc5ekZoWlpScGEr?=
 =?utf-8?B?a1FDTjNoaytjbERGOHJFR1RrZTVTQjBrZ2J4d1ZDZDZEUUkvcDlXZnNMSnpV?=
 =?utf-8?B?Q0kyL2Q4U0I0ekxWUzFSb2xsQ0Q3Um9jUStVTS8xajE5RjdOeHhVeUg5Y0VG?=
 =?utf-8?B?ODk1NFJMNlh0eDRONUNvOERGdmwyeE8zaGJINU5rV0xOcEJCU1FqVTlnQVI3?=
 =?utf-8?B?bmpya3hOd0oraGRGaWxFZnRkTnlMVEwwbVVRV0Y2dU5haEVEZkhtYU40amN2?=
 =?utf-8?B?TVgvRkZTVzd4cHBzL2FvUFlPVlJaUjM5a1pJUHNSSHZpYkhxbGtvcUVxVlF5?=
 =?utf-8?B?Nm1FSkZuOEFzTTYxWjdaZTVUQ00zSVZKYTdPUHdJc2d0MUN6b3lkRkVmb1BT?=
 =?utf-8?B?bGRFT1o4WlJmaktzRlNURmRWYnVYQnkvNUVVUHhFcmpHNEVFVVhBRjE3WURE?=
 =?utf-8?B?V0kzSkNWakRCZmN4SHo5Y0d1RDRjRzJNRExseHNiemJ6RUxQWE8xTGJJVUlr?=
 =?utf-8?B?ajAvRng4L1QzalNremdGZzNpTXNBVmFEc09TZEVnTjlrR1ZDaUFZMXhaVmdt?=
 =?utf-8?B?QkR3Rk1WRllVZEtkdklHS0t2M0hGSjRTZFJYSmFocmVXNk11N0FXaHMxYUFV?=
 =?utf-8?B?N0k5TW94ZFIxWkg2L1UzWGJOSm45eHZmTVVKU1BPTW5hcGFidG1XaDJ2Qytp?=
 =?utf-8?B?RldMcmdwVUhRQUFSVmZERVlrYWFOMzQ4bHlQb2RwR1ppRHR3UXlmZ0JmN1NB?=
 =?utf-8?B?QTg3ZmJPVUFwVERyaHNkN3BTK3M1ZGZrTXVYTWU5UzBmUExyOWdsQ0J5dFla?=
 =?utf-8?B?cFBZYXpmNXV1bGI3QldsRHNqWVRsL054UExkTFY0MXlIcVF6M0htZGU3Sk40?=
 =?utf-8?B?U21kS2NJVnhLZFlJZkpaRzJRazhoQ2FIT1hvbmR1ZTVlallnRnVTeUxUV29j?=
 =?utf-8?B?ckRwL2VncldSaEdMT0ZoMktQLy9lMXhBR2VQUzM1Z0pUeGFXOHQ2TytmS0RO?=
 =?utf-8?B?MklIQmJEQmtUOFZxR1ZEZ1hVS3JQQjJiU3BuTnNrdTBFcUNJVFppTTNKQXU0?=
 =?utf-8?B?c05tYjc2MnZPRGwzTWhCcFZWS0puaDljQ1NqeGx6RXVWTHJPM0NUeXZyOGxL?=
 =?utf-8?B?Mm5jWEJsdmlRcmE2aGlhaUcrOTJvTGFNay9iMm1oTjJLU3pWeHQ3ZHNZMVNF?=
 =?utf-8?B?NXBid2E0Z1Z5d1lFZTFVck1OdGJJemMrcVBqR0NNY21qY2ozZHRBMENBV1JM?=
 =?utf-8?B?SVJ4WCs3cjY1ODVOWUZuenorNElJaFpGNWM0YmVJSGZlSkZrT1YyaG5XOEJq?=
 =?utf-8?B?WW9Va2VFSzRCOXovUUQ5NmhiZ01WdnBUYkppN20zdUdka0diMytuNUQ4OXFp?=
 =?utf-8?B?clFObVhMMTlkN25mUXdMUXRqSnhTNXpiNDEvQnBZMWs4TWJkb2NRZWpvMHlE?=
 =?utf-8?B?MWRpa0wrc2I0TldwNkI2WjlpTVI0dFk3M2NEMHhPUVhNaUhFNVZXQ1h5WmNp?=
 =?utf-8?B?Rnc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a38005-0538-49f5-ba3b-08dd19b8fa36
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 07:54:02.1989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fjo5tdnWTFDTCCgUOSZ2TCqv43oocF9QK0r0Li5GY0oJfrnT+NR7uERI9gbGVNuJiMS8HMNkw1JQkemYgAHgxTIfwsjFOSwS/ApKLSTLmWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7982

Hi Jerome,
    Thanks for your reply.

On 2024/11/26 00:51, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> On Wed 20 Nov 2024 at 15:01, Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
> 
>> From: Chuan Liu <chuan.liu@amlogic.com>
>>
>> Add the PLL clock controller driver for the Amlogic A5 SoC family.
>>
>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   drivers/clk/meson/Kconfig  |  14 ++
>>   drivers/clk/meson/Makefile |   1 +
>>   drivers/clk/meson/a5-pll.c | 543 +++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 558 insertions(+)
>>
>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>> index 78f648c9c97d..3c97b3a1649d 100644
>> --- a/drivers/clk/meson/Kconfig
>> +++ b/drivers/clk/meson/Kconfig
>> @@ -132,6 +132,20 @@ config COMMON_CLK_A1_PERIPHERALS
>>          device, A1 SoC Family. Say Y if you want A1 Peripherals clock
>>          controller to work.
>>
>> +config COMMON_CLK_A5_PLL
>> +     tristate "Amlogic A5 PLL clock controller"
>> +     depends on ARM64
>> +     default y
>> +     imply COMMON_CLK_SCMI
>> +     select COMMON_CLK_MESON_REGMAP
>> +     select COMMON_CLK_MESON_PLL
>> +     select COMMON_CLK_MESON_MPLL
>> +     select COMMON_CLK_MESON_CLKC_UTILS
>> +     help
>> +       Support for the PLL clock controller on Amlogic AV40x device, AKA A5.
> 
> What is an AV40x ? if it is a SoC that's alright.
> If it is a board, then it is not Ok. The driver does not support a
> single board, does it ?
> 

It is a board, Will modify.

>> +       Say Y if you want the board to work, because PLLs are the parent
>> +       of most peripherals.
>> +
>>   config COMMON_CLK_C3_PLL
>>        tristate "Amlogic C3 PLL clock controller"
>>        depends on ARM64
>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>> index bc56a47931c1..fc4b8a723145 100644
>> --- a/drivers/clk/meson/Makefile
>> +++ b/drivers/clk/meson/Makefile
>> @@ -20,6 +20,7 @@ obj-$(CONFIG_COMMON_CLK_AXG) += axg.o axg-aoclk.o
>>   obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
>>   obj-$(CONFIG_COMMON_CLK_A1_PLL) += a1-pll.o
>>   obj-$(CONFIG_COMMON_CLK_A1_PERIPHERALS) += a1-peripherals.o
>> +obj-$(CONFIG_COMMON_CLK_A5_PLL) += a5-pll.o
>>   obj-$(CONFIG_COMMON_CLK_C3_PLL) += c3-pll.o
>>   obj-$(CONFIG_COMMON_CLK_C3_PERIPHERALS) += c3-peripherals.o
>>   obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>> diff --git a/drivers/clk/meson/a5-pll.c b/drivers/clk/meson/a5-pll.c
>> new file mode 100644
>> index 000000000000..f18700dfd055
>> --- /dev/null
>> +++ b/drivers/clk/meson/a5-pll.c
>> @@ -0,0 +1,543 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Amlogic A5 PLL Controller Driver
>> + *
>> + * Copyright (c) 2024 Amlogic, inc.
>> + * Author: Chuan Liu <chuan.liu@amlogic.com>
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/platform_device.h>
>> +#include "clk-regmap.h"
>> +#include "clk-pll.h"
>> +#include "clk-mpll.h"
>> +#include "meson-clkc-utils.h"
>> +#include <dt-bindings/clock/amlogic,a5-pll-clkc.h>
>> +
>> +#define ANACTRL_GP0PLL_CTRL0                 0x80
>> +#define ANACTRL_GP0PLL_CTRL1                 0x84
>> +#define ANACTRL_GP0PLL_CTRL2                 0x88
>> +#define ANACTRL_GP0PLL_CTRL3                 0x8c
>> +#define ANACTRL_GP0PLL_CTRL4                 0x90
>> +#define ANACTRL_GP0PLL_CTRL5                 0x94
>> +#define ANACTRL_GP0PLL_CTRL6                 0x98
>> +#define ANACTRL_HIFIPLL_CTRL0                        0x100
>> +#define ANACTRL_HIFIPLL_CTRL1                        0x104
>> +#define ANACTRL_HIFIPLL_CTRL2                        0x108
>> +#define ANACTRL_HIFIPLL_CTRL3                        0x10c
>> +#define ANACTRL_HIFIPLL_CTRL4                        0x110
>> +#define ANACTRL_HIFIPLL_CTRL5                        0x114
>> +#define ANACTRL_HIFIPLL_CTRL6                        0x118
>> +#define ANACTRL_MPLL_CTRL0                   0x180
>> +#define ANACTRL_MPLL_CTRL1                   0x184
>> +#define ANACTRL_MPLL_CTRL2                   0x188
>> +#define ANACTRL_MPLL_CTRL3                   0x18c
>> +#define ANACTRL_MPLL_CTRL4                   0x190
>> +#define ANACTRL_MPLL_CTRL5                   0x194
>> +#define ANACTRL_MPLL_CTRL6                   0x198
>> +#define ANACTRL_MPLL_CTRL7                   0x19c
>> +#define ANACTRL_MPLL_CTRL8                   0x1a0
> 
> Same question as usual, is there clocks and *ONLY* clock between 0x0 and
> 0x1a0 ?
> 
> If you can guarantee that, you'll need to split the controller into
> multiple devices.
> 

Between 0x0 and 0x5c are fix_pll and sys_pll. These two plls are
processed in bl31 due to security restrictions. Besides, there are
no registers of other modules interspersed in it.

>> +
>> +static struct clk_fixed_factor mpll_prediv = {
>> +     .mult = 1,
>> +     .div = 2,
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mpll_prediv",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "fix_dco"
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static const struct reg_sequence mpll0_init_regs[] = {
>> +     { .reg = ANACTRL_MPLL_CTRL2,    .def = 0x40000033 },
>> +};
>> +
>> +static struct clk_regmap mpll0_div = {
>> +     .data = &(struct meson_clk_mpll_data){
>> +             .sdm = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL1,
>> +                     .shift   = 0,
>> +                     .width   = 14,
>> +             },
>> +             .sdm_en = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL1,
>> +                     .shift   = 30,
>> +                     .width   = 1,
>> +             },
>> +             .n2 = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL1,
>> +                     .shift   = 20,
>> +                     .width   = 9,
>> +             },
>> +             .ssen = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL1,
>> +                     .shift   = 29,
>> +                     .width   = 1,
>> +             },
>> +             .init_regs = mpll0_init_regs,
>> +             .init_count = ARRAY_SIZE(mpll0_init_regs),
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mpll0_div",
>> +             .ops = &meson_clk_mpll_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &mpll_prediv.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap mpll0 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = ANACTRL_MPLL_CTRL1,
>> +             .bit_idx = 31,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mpll0",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &mpll0_div.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct reg_sequence mpll1_init_regs[] = {
>> +     { .reg = ANACTRL_MPLL_CTRL4,    .def = 0x40000033 },
>> +};
>> +
>> +static struct clk_regmap mpll1_div = {
>> +     .data = &(struct meson_clk_mpll_data){
>> +             .sdm = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL3,
>> +                     .shift   = 0,
>> +                     .width   = 14,
>> +             },
>> +             .sdm_en = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL3,
>> +                     .shift   = 30,
>> +                     .width   = 1,
>> +             },
>> +             .n2 = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL3,
>> +                     .shift   = 20,
>> +                     .width   = 9,
>> +             },
>> +             .ssen = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL3,
>> +                     .shift   = 29,
>> +                     .width   = 1,
>> +             },
>> +             .init_regs = mpll1_init_regs,
>> +             .init_count = ARRAY_SIZE(mpll1_init_regs),
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mpll1_div",
>> +             .ops = &meson_clk_mpll_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &mpll_prediv.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap mpll1 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = ANACTRL_MPLL_CTRL3,
>> +             .bit_idx = 31,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mpll1",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &mpll1_div.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct reg_sequence mpll2_init_regs[] = {
>> +     { .reg = ANACTRL_MPLL_CTRL6,    .def = 0x40000033 },
>> +};
>> +
>> +static struct clk_regmap mpll2_div = {
>> +     .data = &(struct meson_clk_mpll_data){
>> +             .sdm = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL5,
>> +                     .shift   = 0,
>> +                     .width   = 14,
>> +             },
>> +             .sdm_en = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL5,
>> +                     .shift   = 30,
>> +                     .width   = 1,
>> +             },
>> +             .n2 = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL5,
>> +                     .shift   = 20,
>> +                     .width   = 9,
>> +             },
>> +             .ssen = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL5,
>> +                     .shift   = 29,
>> +                     .width   = 1,
>> +             },
>> +             .init_regs = mpll2_init_regs,
>> +             .init_count = ARRAY_SIZE(mpll2_init_regs),
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mpll2_div",
>> +             .ops = &meson_clk_mpll_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &mpll_prediv.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap mpll2 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = ANACTRL_MPLL_CTRL5,
>> +             .bit_idx = 31,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mpll2",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &mpll2_div.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct reg_sequence mpll3_init_regs[] = {
>> +     { .reg = ANACTRL_MPLL_CTRL8,    .def = 0x40000033 },
>> +};
>> +
>> +static struct clk_regmap mpll3_div = {
>> +     .data = &(struct meson_clk_mpll_data){
>> +             .sdm = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL7,
>> +                     .shift   = 0,
>> +                     .width   = 14,
>> +             },
>> +             .sdm_en = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL7,
>> +                     .shift   = 30,
>> +                     .width   = 1,
>> +             },
>> +             .n2 = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL7,
>> +                     .shift   = 20,
>> +                     .width   = 9,
>> +             },
>> +             .ssen = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL7,
>> +                     .shift   = 29,
>> +                     .width   = 1,
>> +             },
>> +             .init_regs = mpll3_init_regs,
>> +             .init_count = ARRAY_SIZE(mpll3_init_regs),
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mpll3_div",
>> +             .ops = &meson_clk_mpll_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &mpll_prediv.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap mpll3 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = ANACTRL_MPLL_CTRL7,
>> +             .bit_idx = 31,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mpll3",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &mpll3_div.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct reg_sequence gp0_init_regs[] = {
>> +     { .reg = ANACTRL_GP0PLL_CTRL2, .def = 0x00000000 },
>> +     { .reg = ANACTRL_GP0PLL_CTRL3, .def = 0x6a295c00 },
>> +     { .reg = ANACTRL_GP0PLL_CTRL4, .def = 0x65771290 },
>> +     { .reg = ANACTRL_GP0PLL_CTRL5, .def = 0x3927200a },
>> +     { .reg = ANACTRL_GP0PLL_CTRL6, .def = 0x54540000 }
>> +};
>> +
>> +static const struct pll_mult_range gp0_pll_mult_range = {
>> +     .min = 125,
>> +     .max = 250,
>> +};
>> +
>> +static struct clk_regmap gp0_pll_dco = {
>> +     .data = &(struct meson_clk_pll_data) {
>> +             .en = {
>> +                     .reg_off = ANACTRL_GP0PLL_CTRL0,
>> +                     .shift   = 28,
>> +                     .width   = 1,
>> +             },
>> +             .m = {
>> +                     .reg_off = ANACTRL_GP0PLL_CTRL0,
>> +                     .shift   = 0,
>> +                     .width   = 8,
>> +             },
>> +             .frac = {
>> +                     .reg_off = ANACTRL_GP0PLL_CTRL1,
>> +                     .shift   = 0,
>> +                     .width   = 17,
>> +             },
>> +             .n = {
>> +                     .reg_off = ANACTRL_GP0PLL_CTRL0,
>> +                     .shift   = 10,
>> +                     .width   = 5,
>> +             },
>> +             .l = {
>> +                     .reg_off = ANACTRL_GP0PLL_CTRL0,
>> +                     .shift   = 31,
>> +                     .width   = 1,
>> +             },
>> +             .rst = {
>> +                     .reg_off = ANACTRL_GP0PLL_CTRL0,
>> +                     .shift   = 29,
>> +                     .width   = 1,
>> +             },
>> +             .range = &gp0_pll_mult_range,
>> +             .init_regs = gp0_init_regs,
>> +             .init_count = ARRAY_SIZE(gp0_init_regs),
>> +             .frac_max = 100000,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "gp0_pll_dco",
>> +             .ops = &meson_clk_pll_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "xtal_24m",
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +/* The maximum frequency divider supports is 32, not 128(2^7) */
>> +static const struct clk_div_table gp0_pll_od_table[] = {
>> +     { 0,  1 },
>> +     { 1,  2 },
>> +     { 2,  4 },
>> +     { 3,  8 },
>> +     { 4, 16 },
>> +     { 5, 32 },
>> +     { /* sentinel */ }
>> +};
>> +
>> +static struct clk_regmap gp0_pll = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = ANACTRL_GP0PLL_CTRL0,
>> +             .shift = 16,
>> +             .width = 3,
>> +             .table = gp0_pll_od_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "gp0_pll",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &gp0_pll_dco.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct reg_sequence hifi_init_regs[] = {
>> +     { .reg = ANACTRL_HIFIPLL_CTRL2, .def = 0x00000000 },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL3, .def = 0x6a295c00 },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL4, .def = 0x65771290 },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL5, .def = 0x3927200a },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL6, .def = 0x54540000 }
>> +};
>> +
>> +static const struct pll_mult_range hifi_pll_mult_range = {
>> +     .min = 125,
>> +     .max = 250,
>> +};
>> +
>> +static struct clk_regmap hifi_pll_dco = {
>> +     .data = &(struct meson_clk_pll_data) {
>> +             .en = {
>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>> +                     .shift   = 28,
>> +                     .width   = 1,
>> +             },
>> +             .m = {
>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>> +                     .shift   = 0,
>> +                     .width   = 8,
>> +             },
>> +             .frac = {
>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL1,
>> +                     .shift   = 0,
>> +                     .width   = 17,
>> +             },
>> +             .n = {
>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>> +                     .shift   = 10,
>> +                     .width   = 5,
>> +             },
>> +             .l = {
>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>> +                     .shift   = 31,
>> +                     .width   = 1,
>> +             },
>> +             .rst = {
>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>> +                     .shift   = 29,
>> +                     .width   = 1,
>> +             },
>> +             .range = &hifi_pll_mult_range,
>> +             .init_regs = hifi_init_regs,
>> +             .init_count = ARRAY_SIZE(hifi_init_regs),
>> +             .frac_max = 100000,
>> +             /* NOTE: The original design of hifi_pll is to provide
>> +              * clock for audio, which requires clock accuracy.
>> +              * Therefore, flag CLK_MESON_PLL_ROUND_CLOSEST is added
>> +              * to make the output frequency of hifi_pll closer to
>> +              * the target frequency.
>> +              */
> 
> The comment format is incorrect. not quite sure the commnet itself is useful.
> 

Delete this comment in the next version.

>> +             .flags = CLK_MESON_PLL_ROUND_CLOSEST,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hifi_pll_dco",
>> +             .ops = &meson_clk_pll_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "xtal_24m",
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap hifi_pll = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = ANACTRL_HIFIPLL_CTRL0,
>> +             .shift = 16,
>> +             /* NOTE: The actual reserved bit width of the od (output
>> +              * divider) of hifi_pll is 3 bit, but its actual maximum
>> +              * effective divider factor is 8. It can just use 2 bit and add
>> +              * flag CLK_DIVIDER_POWER_OF_TWO (max_div = 2^3 = 8).
>> +              */
> 
> Same here

Delete this comment in the next version.

> 
>> +             .width = 2,
> 
> ... yet the width is 2 ??
> 
>> +             .flags = CLK_DIVIDER_POWER_OF_TWO,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hifi_pll",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &hifi_pll_dco.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_hw *a5_pll_hw_clks[] = {
>> +     [CLKID_MPLL_PREDIV]     = &mpll_prediv.hw,
>> +     [CLKID_MPLL0_DIV]       = &mpll0_div.hw,
>> +     [CLKID_MPLL0]           = &mpll0.hw,
>> +     [CLKID_MPLL1_DIV]       = &mpll1_div.hw,
>> +     [CLKID_MPLL1]           = &mpll1.hw,
>> +     [CLKID_MPLL2_DIV]       = &mpll2_div.hw,
>> +     [CLKID_MPLL2]           = &mpll2.hw,
>> +     [CLKID_MPLL3_DIV]       = &mpll3_div.hw,
>> +     [CLKID_MPLL3]           = &mpll3.hw,
>> +     [CLKID_GP0_PLL_DCO]     = &gp0_pll_dco.hw,
>> +     [CLKID_GP0_PLL]         = &gp0_pll.hw,
>> +     [CLKID_HIFI_PLL_DCO]    = &hifi_pll_dco.hw,
>> +     [CLKID_HIFI_PLL]        = &hifi_pll.hw
>> +};
>> +
>> +/* Convenience table to populate regmap in .probe */
>> +static struct clk_regmap *const a5_pll_clk_regmaps[] = {
>> +     &mpll0_div,
>> +     &mpll0,
>> +     &mpll1_div,
>> +     &mpll1,
>> +     &mpll2_div,
>> +     &mpll2,
>> +     &mpll3_div,
>> +     &mpll3,
>> +     &gp0_pll_dco,
>> +     &gp0_pll,
>> +     &hifi_pll_dco,
>> +     &hifi_pll
>> +};
>> +
>> +static const struct regmap_config clkc_regmap_config = {
>> +     .reg_bits       = 32,
>> +     .val_bits       = 32,
>> +     .reg_stride     = 4,
>> +     .max_register   = ANACTRL_MPLL_CTRL8,
>> +};
>> +
>> +static struct meson_clk_hw_data a5_pll_clks = {
>> +     .hws = a5_pll_hw_clks,
>> +     .num = ARRAY_SIZE(a5_pll_hw_clks),
>> +};
>> +
>> +static int aml_a5_pll_probe(struct platform_device *pdev)
>> +{
>> +     struct device *dev = &pdev->dev;
>> +     struct regmap *regmap;
>> +     void __iomem *base;
>> +     int clkid, ret, i;
>> +
>> +     base = devm_platform_ioremap_resource(pdev, 0);
>> +     if (IS_ERR(base))
>> +             return PTR_ERR(base);
>> +
>> +     regmap = devm_regmap_init_mmio(dev, base, &clkc_regmap_config);
>> +     if (IS_ERR(regmap))
>> +             return PTR_ERR(regmap);
>> +
>> +     /* Populate regmap for the regmap backed clocks */
>> +     for (i = 0; i < ARRAY_SIZE(a5_pll_clk_regmaps); i++)
>> +             a5_pll_clk_regmaps[i]->map = regmap;
>> +
>> +     for (clkid = 0; clkid < a5_pll_clks.num; clkid++) {
>> +             /* array might be sparse */
>> +             if (!a5_pll_clks.hws[clkid])
>> +                     continue;
>> +
>> +             ret = devm_clk_hw_register(dev, a5_pll_clks.hws[clkid]);
>> +             if (ret) {
>> +                     dev_err(dev, "Clock registration failed\n");
>> +                     return ret;
>> +             }
>> +     }
>> +
>> +     return devm_of_clk_add_hw_provider(dev, meson_clk_hw_get,
>> +                                        &a5_pll_clks);
>> +}
>> +
>> +static const struct of_device_id a5_pll_clkc_match_table[] = {
>> +     {
>> +             .compatible = "amlogic,a5-pll-clkc",
>> +     },
>> +     {}
>> +};
>> +MODULE_DEVICE_TABLE(of, a5_pll_clkc_match_table);
>> +
>> +static struct platform_driver a5_pll_driver = {
>> +     .probe          = aml_a5_pll_probe,
>> +     .driver         = {
>> +             .name   = "a5-pll-clkc",
>> +             .of_match_table = a5_pll_clkc_match_table,
>> +     },
>> +};
>> +module_platform_driver(a5_pll_driver);
>> +
>> +MODULE_DESCRIPTION("Amlogic A5 PLL Clock Controller driver");
>> +MODULE_AUTHOR("Chuan Liu <chuan.liu@amlogic.com>");
>> +MODULE_LICENSE("GPL");
> 
> --
> Jerome

