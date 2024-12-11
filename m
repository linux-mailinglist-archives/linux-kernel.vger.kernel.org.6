Return-Path: <linux-kernel+bounces-440932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6719EC699
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBEB01627D3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B4B1D5ACF;
	Wed, 11 Dec 2024 08:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="AusPWlX0"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2094.outbound.protection.outlook.com [40.107.215.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C965D1CACF7;
	Wed, 11 Dec 2024 08:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904581; cv=fail; b=sChMtIDdogFj0L1W+DR9100b74EkQpeWQmQIVwrj1mkFsI34VeyHNwbbZS0QMQfebLBoCPLUxB82QCekLPE9QHmE+hDci+KvR5oLkyLZ76oxUrR89Zv6cyZEp5/0HG02mpy/ImxGyBmo+11mmQZLVKUgAiMpB4lCasS0mQewl5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904581; c=relaxed/simple;
	bh=dpOOxOgYmjeh+V5BdoFeUBCvGjzjf0LENAR5sT/1g2g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QITBMUMS5W5P6WoTb5lk3GNlyOfvJkw2PKtkiJmqqkgYAzLefqAHnZ7M5W5gWHPm8tkLmJjEqAfA4KP16uHgZ4DoRsF+MnlKVnotVTx4HFjjxXN6LEV78qEehIXvWo2qw2tE2O8JNT6hlQ6upAf3ok4j3NbE5e2d6jo2AU7eSC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=AusPWlX0; arc=fail smtp.client-ip=40.107.215.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEFqM3tiBXY4VXrrCrTy+YokJgepIjAM1gTpAHlFBVXZq16GOTMFUoe9bV/unGumMjXTD5yxlkumB6tE/bWt4/I25xcfLH6PmFnRz/a8ZN8A4PdQidts81GWJzhhhLM6KU1BrC05fv83daMMa9seDT3nLg43QyrG7d27wg+cvXGNHmKn/Qd1m2sZUoz7PzjIl+0wP//rcwsRRGknOuU8TKNpr7Xu8Hm6DGAXOkHLCVcLSPQ2h8+Twd+3eyWjQCIGwxZYSz8KtRGLzV9ddyhPyIcVfBKCpYY6E526P0/NX+ulcmyDJCf0yQZye7ufKXUGwcfPaSS6brSn9yd8B0lfnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjTLj6GKC5G93JXJ2AY6avcC5XZcxdOGP9LGOPcVn1s=;
 b=OCDYBxFtYGztaSCOUgP8Rlif0D8z7xVrCS8WyKU0VXqBnm9GMIC3bbS44ApOMGnq0/WwcJf/9XfYERHAHQ66Ffg7ovrpVpZoV60MYe8EJLSjbGNJIz40FwKSeqqnHobGgP/ZW05htSetwAukOjVq2tr0PCadnEtiLi0FlgUn3/cs2YaEAHe7NtUI2zJH+TT0gkrnbiz5T+yY73heLu9MhHjpbe9bpKXLx2w/RwysK7SS3se09Q4gUm+nXKUMwdNiiFoVDc3yu32qA2huI0mFM528xdSUlmgAhnEXEUG9nFvm9qIrZG6+L5V9oVCpQX6e5g3dYzAtcB7VEALZuNCxLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjTLj6GKC5G93JXJ2AY6avcC5XZcxdOGP9LGOPcVn1s=;
 b=AusPWlX05EcvFHqSHSbmPgLUYnvOxoNkBV90hRENU0EbljVELP/mFPXpVa6jh4nhwpztPn3MkLDm6Ie26zeXkzCQKRzAayy1GSZ5N/ni7CEZpx9MEKZsF1ql+xOZlpZ0OMsjv0hgmzaDorjqIAPqhatdOOwAZ1PcewRGnM9PsQhqXNtFJv42A231hTgZv6JrlBaHr2LTbPFVj0idn4oDBakSX93iQHHRmMkRST2IOvZt7MqB8tFo81KkFCsXVEz0uHMKt4VhW+Nm41Gcn60oezqUdU2qoMYyvpHMNHK/Wzt4cpyoLEEB6rjnBQZvUiFf0xklj3haS57zWaHijdy+qQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SEZPR03MB7123.apcprd03.prod.outlook.com (2603:1096:101:e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 08:09:34 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%7]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 08:09:34 +0000
Message-ID: <e32950ba-001e-4cb2-82f0-7a498644bdae@amlogic.com>
Date: Wed, 11 Dec 2024 16:09:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] dt-bindings: clock: add Amlogic A5 peripherals
 clock controller
Content-Language: en-US
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
 <20241120-a5-clk-v2-3-1208621e961d@amlogic.com>
 <1jmshntfty.fsf@starbuckisacylon.baylibre.com>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <1jmshntfty.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::13) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SEZPR03MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: a7abe3ff-60f4-4438-067e-08dd19bb261a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zm44UkJUWG1qZmNRWnBpNXZKbUFRZ21BbUVIZG1LaUowd3RPcUhZWVZFb1ox?=
 =?utf-8?B?cFcxRmJEVUhwM0J1YkxZV0QrNHppZzJKeHZxQTFXeEhBeVU3VmljZnEwendE?=
 =?utf-8?B?b2VRei9ncDFZWklZOW9tTytLbXNqR2dxenRkQ08xSkZpUWo1T0ZOQ2xvUmxU?=
 =?utf-8?B?YXIyeVhQWWppaFhCb3RxNUlEU0c0Z3hSVDZaZTZ4YXhrRlNnQWpSc25GME1Z?=
 =?utf-8?B?Z1RpYmh6ZGY3MjRXbzdvNlgwb0RWdlRBc2xpYkZGRGJ6SVNBa0JFWjlTUDMv?=
 =?utf-8?B?QkdpK2NpOVA0V3Z3QUwvQVpZa1R4ckZTaHZaZ0VENU1BOGh4M2pOczBFak5y?=
 =?utf-8?B?M2hwdkxCL01sdUtvM3RuT3VoeHJrMEplT0ZtUVRSUjJrWWVNT0tjL0lCV1BT?=
 =?utf-8?B?cy9IK2MrTmJKRENkWHB5OU1XbFZVdjBnZ3RFMnRwMzlSNHJkbHNPeGNPNUJJ?=
 =?utf-8?B?bVhRYUhrS0szajBTbE84YTlqdVcrZ1J1Zmc3M29Dd2V0bThjcHljNVMzOWVp?=
 =?utf-8?B?dDRZeStjS0hpTElHSnBxTFU0UVIyL3hsSURKUFFqWWprSUduKzBHN2pNUnhK?=
 =?utf-8?B?eWI4a2cwWWF5U2U4eFV6Z2lJS3hBQmpWaHhLNzBJMEw0VFdzZG5MVzRXb3o5?=
 =?utf-8?B?ajBzM29SeHNpWFhUeGZBOFpKWTdsRTliSytEdlJ2M0hQRGdoampTNlp4dE5i?=
 =?utf-8?B?RVA0cDh0Y0lwRGZ3U0F2ejQvYTdqWFV4YlFldzRUNldlL0hkVTBCTUEvME04?=
 =?utf-8?B?TkVNMGlKZ2RnVHA2RXE2UmFDWDRNTE55bWU4bG5tSkJ3a1BJYWhGWGRvK0ow?=
 =?utf-8?B?N2ZpL1pQZFJ2b1RmVmlyZWdzQWYzaGdiOEIwVmV1bElzYkYrVUZ6ZVRSN0Jx?=
 =?utf-8?B?RG1laWt4ZGlnbFE3K0pPQjFkTW5YN1BJRjhXcHdqWURXODZkcHg0KzZlbEJs?=
 =?utf-8?B?eG5xclZkYm1JbU5HWHNaV2NFNlVQalFRRWg1V3p1ZHFreDQra3ZtZUFXSUVj?=
 =?utf-8?B?SDVxSWd0QTczQkc2RFNNSEFnclhMQXRQdkw4TVZoUFdtbFFIM2UrTXBWVXFr?=
 =?utf-8?B?SEF3UEhMbTF0UG56dFFHSVJqQjFFRWxxOFdzTDhVSk1wOUxJeVVoeWp5Lzlh?=
 =?utf-8?B?L1R4dmVvZzFJZ3hSc0MvcytENkFBREdJR1pJaFdISytQcndDWnlhRit0T3Qw?=
 =?utf-8?B?MVorNUdPODZENCt3bUpac0s1VWpqYXhuQlJvZlJXZDhKamhNRjRLaDNRTWpC?=
 =?utf-8?B?T3UxVkloekp1TUxhUXRKbWZSaktZWmNRaHFHTmtWdWxkaGdRVERwNmFzU2Vy?=
 =?utf-8?B?SWp5YVpxelRKajBTMVhobmhVWXp6dWgxSVVOMERjZ0pPaWMxQ1R5Y3ZUUk9y?=
 =?utf-8?B?d1VRK3pON1hldFpXbmFZWHRlOGFoOXB4V1FTQ0RXWmlENzFoQ0pvdThsSDhl?=
 =?utf-8?B?RXZqNWlUWGJoeHhtYlRyZWFucGtvSm9WWmpLUDhJbDBObmtSWmtsSXd2WFl2?=
 =?utf-8?B?Ky8rcmRQZS8vTU5WWllMUWFCQmoxVWdsSS9YeWVhWFo1TlZVU0diODFCVkRG?=
 =?utf-8?B?Mkk4dWl1aFlLY2JJY1VVb3lBVGJvbWJJYWFzSmJXODlnVjhyY2Vkam5mczhU?=
 =?utf-8?B?MTZlQXBub1MzNnV4bWFTeXczL05kZ1BjeGcvUVB5YkNDbmRPRzhrMVozWVU4?=
 =?utf-8?B?WU5JUlVHeEFWZTJMSlFxZUZZT0lSL29tNmpUaWdhbFZFV0NnTFpNdUg0NWxB?=
 =?utf-8?Q?z1AuhOSVp4uGJPlggI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlNldCs1NTlTWUhRTE45dXBZOXcyenNIRURJVnczOW00UlRWNE9QOU1mMlZm?=
 =?utf-8?B?bnNZNnBnUXlIcFpyMVFHT294Ny9nY3A5b1AzcEtWbk1TcjkvaG9GSDNqWCta?=
 =?utf-8?B?Yytyc1o4U3V0MHB4VEh2aTBQZmpMWXNISlljMzFrWnpGZVViTE9BbmRaV1NN?=
 =?utf-8?B?OXNyU3FDcDh4YmpTSzkzdWNncGVBOUJVNnAzWDZXdTl5VzJEZTFTL3hENTRx?=
 =?utf-8?B?OTNScDhxdWFMWW1maDZtaFBQeHdWbzB6RzVCR1Jzb0Z1Q0h4Qi9xSW1sOUdP?=
 =?utf-8?B?Qko3bjlMQ0FmNDR0VjNHMG9WMHJUL01abHphcmNpL3VFb24vYmNlcTdBSDEr?=
 =?utf-8?B?dlpFcjlNRzBJNlI0Y2tqcGd3SjBLVGx0dk9lRmNYTDVwK3pxb05IT1krRTA3?=
 =?utf-8?B?WWhlUkgxdThUZU5oZ2Z6OE4zd3AvbjJlTGFUUlpuTGdOQXlWQ2l0dno5NFRQ?=
 =?utf-8?B?UDlqWlllRWtmc2t2NFpBK3QyZjBBMFBvNlI3SXkzbFp0VHpjUnhRUGlLNklJ?=
 =?utf-8?B?TDQxbzdKTUU0NGxDQnYzQjR1Qk9weUNJbzgyc3lpWnZwOUJCQnlCVEJsd2FN?=
 =?utf-8?B?U0NZTE5HNkgvQkE2dTRJS3pWcXhPNlpPaXhEVEdJdytTY3kweEN2dWV2RTB6?=
 =?utf-8?B?Vng4WHJMMHpLMU9jTlVBOVExaW9yUFpNYSt6Qyt4ZWdaZVlCREpJVmZZK3RU?=
 =?utf-8?B?eUtXbnRqRU1HaUVvY1RIR08rWUEwZFZrRW0zRGFMOFN1TzA2eGhUNU1PMkR2?=
 =?utf-8?B?d2tLYzdNbEYzbDY2VXpWbEZYcFUvZVFSMnpMSTl6REpCdEhRNzgvWEJmOW9y?=
 =?utf-8?B?K3lTbEExbGJPRjMwMkZWWHpxK2Q4WWNaOEJrR2FHaTJpZnRjQ3g1dnNyaXVp?=
 =?utf-8?B?L0gzYVlPMUxpUVpFYjNma3pnb3VLZm5iS1RHZWJzZzIvdHlFQy9JMVBJRXcr?=
 =?utf-8?B?bkZjT2x0aG5CbE9iVlJaak0xcFZ6dy94VWRGNmhkTFYrdi8zMjU2UGp1QWR1?=
 =?utf-8?B?cU5WTVFDQ25UQko5bWN5czFSOEtjb3c5RDFvdWg4OGQyNm80a2N5a1VDQ1ND?=
 =?utf-8?B?VHVrOUFrTGkrcW94WWhOVDREMHVlMTBka3JKRzJlOVhmZm5UdmVodjk0VTV2?=
 =?utf-8?B?U1FoNThvdHZ4WFVEYkl5ck50YUNKdXRFZytLbHo4Q0tiMjRwRkxHei9IWmlE?=
 =?utf-8?B?c1VhdExLU3ZwU0lReFBEWjBybTJpaFRVVVhlTkZZazJKQWsxVEZlamhwSXVK?=
 =?utf-8?B?Y2ppbXdvdlB6QVRILzl5OS92c2M2a05rYUdWRm9La0NVSzZSbzJlV2JHcitT?=
 =?utf-8?B?ak9KdlEzVnc4Y1hKSUpqWjQyMW41bmk2TC84R29jMytKaDdFZXNMbVhteHVy?=
 =?utf-8?B?elNML3B0blIzemg4NUZCUHNDcUxCRDROdmlLbE5TYkFPRlViQVpEVFdTOTRR?=
 =?utf-8?B?Y3hOaTdpRGU0L2l6UytCOFN2ZlRJTUcrS1c2WTAvNDRIcWRXU0ViODJRdkdw?=
 =?utf-8?B?QVhHUFVHS3lVb1Q0V0lwcmxjb0o5SHIwb2xhWW5oWE4zbnRRTkxhdG9NRmR3?=
 =?utf-8?B?azZqR1JZTitPWktRTE5FQ2JtcExwYUJlb0VjaHJEamV6aTgvcmducENIY0k1?=
 =?utf-8?B?azgrcCt0VzJrVjAyS282VHB0SVZ1d0lOMnhvMkJmNXFTRk5sQ1FESTJUamFD?=
 =?utf-8?B?bGZ4dkdTclkzSWR4cUJsdmZmYjYwbG9pam5vbldkWXpaek9xTnhHcWx5MW1D?=
 =?utf-8?B?QlIyQnJYY3NLVGdjNWd6bHVWQjZTSEtHelhsVlFRZm1KMmxybGtJeUNqOTds?=
 =?utf-8?B?Z2lQTTAxckpWRjc0ZFo1Ui9lMWg1bW5DVUZJRDJMRGt1MTdjNEl1K2tJUmg4?=
 =?utf-8?B?S0ZkK0xrTllOR2loQ2QxYzN0ZDV2b05VZkp5MjlHTE0xK2VIRlVXRlFXRHRm?=
 =?utf-8?B?SFFpSXBzUHpoUE5aTVh4djhmUW8vc0xWQ3MyUmJkSUpZdHlDMjdlemJFeTFx?=
 =?utf-8?B?eFFWZmxVSWVEbm9rUFVtMDFoR3BOZHYyS2RtWUxTb0c2aWsrZi8xUEZITHQ5?=
 =?utf-8?B?QTRCSjJSQ3d1aEVmSDZBelFlN2lvVy9FUElGTHRvTWhQNWIvQ0tDM1YxNDBT?=
 =?utf-8?B?RWtNMmlqN1Q4ZmZVczBsMEdVeU1zSWFOdHh1UVlQWXlKS29TY1pIcUZVbjNK?=
 =?utf-8?B?Tmc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7abe3ff-60f4-4438-067e-08dd19bb261a
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 08:09:34.6120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgLG5rWwwbz6gUQFL/TmSiZ4i7FlMvu6dzYPRG7aDCki4zNiIRMtPKN/Rx0yapruHckZL6ZT0IOHi71x8tFS5MHTeQOoaoEAvDmFVAP8goY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7123

Hi Jerome,
    Thanks for your reply.

On 2024/11/26 00:53, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> On Wed 20 Nov 2024 at 15:01, Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
> 
>> From: Chuan Liu <chuan.liu@amlogic.com>
>>
>> Add the peripherals clock controller dt-bindings for Amlogic A5 SoC family.
>>
>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   .../clock/amlogic,a5-peripherals-clkc.yaml         | 130 ++++++++++++++++++++
>>   .../clock/amlogic,a5-peripherals-clkc.h            | 132 +++++++++++++++++++++
>>   2 files changed, 262 insertions(+)
>>
>> diff --git
>> a/Documentation/devicetree/bindings/clock/amlogic,a5-peripherals-clkc.yaml
>> b/Documentation/devicetree/bindings/clock/amlogic,a5-peripherals-clkc.yaml
>> new file mode 100644
>> index 000000000000..0f15e104fd12
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/amlogic,a5-peripherals-clkc.yaml
>> @@ -0,0 +1,130 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (C) 2024 Amlogic, Inc. All rights reserved
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/amlogic,a5-peripherals-clkc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Amlogic A5 series Peripheral Clock Controller
>> +
>> +maintainers:
>> +  - Xianwei Zhao <xianwei.zhao@amlogic.com>
>> +  - Chuan Liu <chuan.liu@amlogic.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: amlogic,a5-peripherals-clkc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    minItems: 18
>> +    items:
>> +      - description: input oscillator (usually at 24MHz)
>> +      - description: input oscillators multiplexer
>> +      - description: input fix pll
>> +      - description: input fclk div 2
>> +      - description: input fclk div 2p5
>> +      - description: input fclk div 3
>> +      - description: input fclk div 4
>> +      - description: input fclk div 5
>> +      - description: input fclk div 7
>> +      - description: input mpll2
>> +      - description: input mpll3
>> +      - description: input gp0 pll
>> +      - description: input gp1 pll
>> +      - description: input hifi pll
>> +      - description: input sys clk
>> +      - description: input axi clk
>> +      - description: input sys pll div 16
>> +      - description: input cpu clk div 16
>> +      - description: input pad clock for rtc clk (optional)
>> +      - description: input ddr pll (optional)
>> +      - description: input source from clk-measure (optional)
>> +
>> +  clock-names:
>> +    minItems: 18
>> +    items:
>> +      - const: xtal_24m
> 
> You should not mention the rate here. xtal is fine.
> 
Will do.
>> +      - const: oscin
>> +      - const: fix
>> +      - const: fdiv2
>> +      - const: fdiv2p5
>> +      - const: fdiv3
>> +      - const: fdiv4
>> +      - const: fdiv5
>> +      - const: fdiv7
>> +      - const: mpll2
>> +      - const: mpll3
>> +      - const: gp0
>> +      - const: gp1
>> +      - const: hifi
>> +      - const: sysclk
>> +      - const: axiclk
>> +      - const: sysplldiv16
>> +      - const: cpudiv16
>> +      - const: pad_osc
>> +      - const: ddr
>> +      - const: clkmsr
>> +
>> +  "#clock-cells":
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - "#clock-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    apb {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        clock-controller@0 {
>> +            compatible = "amlogic,a5-peripherals-clkc";
>> +            reg = <0x0 0x0 0x0 0x224>;
>> +            #clock-cells = <1>;
>> +            clocks = <&xtal_24m>,
>> +                     <&scmi_clk 0>,
>> +                     <&scmi_clk 7>,
>> +                     <&scmi_clk 15>,
>> +                     <&scmi_clk 17>,
>> +                     <&scmi_clk 19>,
>> +                     <&scmi_clk 21>,
>> +                     <&scmi_clk 23>,
>> +                     <&scmi_clk 25>,
>> +                     <&clkc_pll 6>,
>> +                     <&clkc_pll 8>,
>> +                     <&clkc_pll 10>,
>> +                     <&scmi_clk 5>,
>> +                     <&clkc_pll 12>,
>> +                     <&scmi_clk 1>,
>> +                     <&scmi_clk 2>,
>> +                     <&scmi_clk 9>,
>> +                     <&scmi_clk 10>;
>> +            clock-names = "xtal_24m",
>> +                          "oscin",
>> +                          "fix",
>> +                          "fdiv2",
>> +                          "fdiv2p5",
>> +                          "fdiv3",
>> +                          "fdiv4",
>> +                          "fdiv5",
>> +                          "fdiv7",
>> +                          "mpll2",
>> +                          "mpll3",
>> +                          "gp0",
>> +                          "gp1",
>> +                          "hifi",
>> +                          "sysclk",
>> +                          "axiclk",
>> +                          "sysplldiv16",
>> +                          "cpudiv16";
>> +        };
>> +    };
>> diff --git a/include/dt-bindings/clock/amlogic,a5-peripherals-clkc.h b/include/dt-bindings/clock/amlogic,a5-peripherals-clkc.h
>> new file mode 100644
>> index 000000000000..74e740ebe6bd
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/amlogic,a5-peripherals-clkc.h
>> @@ -0,0 +1,132 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
>> +/*
>> + * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
>> + * Author: Chuan Liu <chuan.liu@amlogic.com>
>> + */
>> +
>> +#ifndef _DT_BINDINGS_CLOCK_AMLOGIC_A5_PERIPHERALS_CLKC_H
>> +#define _DT_BINDINGS_CLOCK_AMLOGIC_A5_PERIPHERALS_CLKC_H
>> +
>> +#define CLKID_RTC_XTAL_CLKIN                 0
>> +#define CLKID_RTC_32K_DIV                    1
>> +#define CLKID_RTC_32K_MUX                    2
>> +#define CLKID_RTC_32K                                3
>> +#define CLKID_RTC_CLK                                4
>> +#define CLKID_SYS_RESET_CTRL                 5
>> +#define CLKID_SYS_PWR_CTRL                   6
>> +#define CLKID_SYS_PAD_CTRL                   7
>> +#define CLKID_SYS_CTRL                               8
>> +#define CLKID_SYS_TS_PLL                     9
>> +#define CLKID_SYS_DEV_ARB                    10
>> +#define CLKID_SYS_MAILBOX                    11
>> +#define CLKID_SYS_JTAG_CTRL                  12
>> +#define CLKID_SYS_IR_CTRL                    13
>> +#define CLKID_SYS_MSR_CLK                    14
>> +#define CLKID_SYS_ROM                                15
>> +#define CLKID_SYS_CPU_ARB                    16
>> +#define CLKID_SYS_RSA                                17
>> +#define CLKID_SYS_SAR_ADC                    18
>> +#define CLKID_SYS_STARTUP                    19
>> +#define CLKID_SYS_SECURE                     20
>> +#define CLKID_SYS_SPIFC                              21
>> +#define CLKID_SYS_DSPA                               22
>> +#define CLKID_SYS_NNA                                23
>> +#define CLKID_SYS_ETH_MAC                    24
>> +#define CLKID_SYS_RAMA                               25
>> +#define CLKID_SYS_RAMB                               26
>> +#define CLKID_SYS_AUDIO_TOP                  27
>> +#define CLKID_SYS_AUDIO_VAD                  28
>> +#define CLKID_SYS_USB                                29
>> +#define CLKID_SYS_SD_EMMC_A                  30
>> +#define CLKID_SYS_SD_EMMC_C                  31
>> +#define CLKID_SYS_PWM_AB                     32
>> +#define CLKID_SYS_PWM_CD                     33
>> +#define CLKID_SYS_PWM_EF                     34
>> +#define CLKID_SYS_PWM_GH                     35
>> +#define CLKID_SYS_SPICC_1                    36
>> +#define CLKID_SYS_SPICC_0                    37
>> +#define CLKID_SYS_UART_A                     38
>> +#define CLKID_SYS_UART_B                     39
>> +#define CLKID_SYS_UART_C                     40
>> +#define CLKID_SYS_UART_D                     41
>> +#define CLKID_SYS_UART_E                     42
>> +#define CLKID_SYS_I2C_M_A                    43
>> +#define CLKID_SYS_I2C_M_B                    44
>> +#define CLKID_SYS_I2C_M_C                    45
>> +#define CLKID_SYS_I2C_M_D                    46
>> +#define CLKID_SYS_RTC                                47
>> +#define CLKID_AXI_AUDIO_VAD                  48
>> +#define CLKID_AXI_AUDIO_TOP                  49
>> +#define CLKID_AXI_RAMB                               50
>> +#define CLKID_AXI_RAMA                               51
>> +#define CLKID_AXI_NNA                                52
>> +#define CLKID_AXI_DEV1_DMC                   53
>> +#define CLKID_AXI_DEV0_DMC                   54
>> +#define CLKID_AXI_DSP_DMC                    55
>> +#define CLKID_12_24M_IN                              56
>> +#define CLKID_12M_24M                                57
>> +#define CLKID_FCLK_25M_DIV                   58
>> +#define CLKID_FCLK_25M                               59
>> +#define CLKID_GEN_SEL                                60
>> +#define CLKID_GEN_DIV                                61
>> +#define CLKID_GEN                            62
>> +#define CLKID_SARADC_SEL                     63
>> +#define CLKID_SARADC_DIV                     64
>> +#define CLKID_SARADC                         65
>> +#define CLKID_PWM_A_SEL                              66
>> +#define CLKID_PWM_A_DIV                              67
>> +#define CLKID_PWM_A                          68
>> +#define CLKID_PWM_B_SEL                              69
>> +#define CLKID_PWM_B_DIV                              70
>> +#define CLKID_PWM_B                          71
>> +#define CLKID_PWM_C_SEL                              72
>> +#define CLKID_PWM_C_DIV                              73
>> +#define CLKID_PWM_C                          74
>> +#define CLKID_PWM_D_SEL                              75
>> +#define CLKID_PWM_D_DIV                              76
>> +#define CLKID_PWM_D                          77
>> +#define CLKID_PWM_E_SEL                              78
>> +#define CLKID_PWM_E_DIV                              79
>> +#define CLKID_PWM_E                          80
>> +#define CLKID_PWM_F_SEL                              81
>> +#define CLKID_PWM_F_DIV                              82
>> +#define CLKID_PWM_F                          83
>> +#define CLKID_PWM_G_SEL                              84
>> +#define CLKID_PWM_G_DIV                              85
>> +#define CLKID_PWM_G                          86
>> +#define CLKID_PWM_H_SEL                              87
>> +#define CLKID_PWM_H_DIV                              88
>> +#define CLKID_PWM_H                          89
>> +#define CLKID_SPICC_0_SEL                    90
>> +#define CLKID_SPICC_0_DIV                    91
>> +#define CLKID_SPICC_0                                92
>> +#define CLKID_SPICC_1_SEL                    93
>> +#define CLKID_SPICC_1_DIV                    94
>> +#define CLKID_SPICC_1                                95
>> +#define CLKID_SD_EMMC_A_SEL                  96
>> +#define CLKID_SD_EMMC_A_DIV                  97
>> +#define CLKID_SD_EMMC_A                              98
>> +#define CLKID_SD_EMMC_C_SEL                  99
>> +#define CLKID_SD_EMMC_C_DIV                  100
>> +#define CLKID_SD_EMMC_C                              101
>> +#define CLKID_TS_DIV                         102
>> +#define CLKID_TS                             103
>> +#define CLKID_ETH_125M_DIV                   104
>> +#define CLKID_ETH_125M                               105
>> +#define CLKID_ETH_RMII_DIV                   106
>> +#define CLKID_ETH_RMII                               107
>> +#define CLKID_DSPA_0_SEL                     108
>> +#define CLKID_DSPA_0_DIV                     109
>> +#define CLKID_DSPA_0                         110
>> +#define CLKID_DSPA_1_SEL                     111
>> +#define CLKID_DSPA_1_DIV                     112
>> +#define CLKID_DSPA_1                         113
>> +#define CLKID_DSPA                           114
>> +#define CLKID_NNA_CORE_SEL                   115
>> +#define CLKID_NNA_CORE_DIV                   116
>> +#define CLKID_NNA_CORE                               117
>> +#define CLKID_NNA_AXI_SEL                    118
>> +#define CLKID_NNA_AXI_DIV                    119
>> +#define CLKID_NNA_AXI                                120
>> +
>> +#endif  /* _DT_BINDINGS_CLOCK_AMLOGIC_A5_PERIPHERALS_CLKC_H */
> 
> --
> Jerome

