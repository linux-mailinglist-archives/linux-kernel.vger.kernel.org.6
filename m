Return-Path: <linux-kernel+bounces-172959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2CB8BF95F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7C24283EF8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3549B7350E;
	Wed,  8 May 2024 09:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="C5a85VOZ"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2139.outbound.protection.outlook.com [40.107.8.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FBC71B44;
	Wed,  8 May 2024 09:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715159574; cv=fail; b=s09otQXZgqMYnv8f1IgEvRj2n0SM8Ul8W4xuJUzucpTi7YNJG6Jgv4k641DuknhaiEvf2pKJlAu130fiOFmMEJ01jAt9x/ULIUynASUy4vKqH04mRcMeoQBRp2nrX59qmwZhJOy7QPqVa7+E3ynVO30aw1w9qyBbhjNZYmGa+NM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715159574; c=relaxed/simple;
	bh=v2okUKJTwch9158OMnWJSrzzR33cqi8iUQsZc2/cgrI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qk+8u1ypHP3fVnplcDFmEUrEoR8GfopP2II/hM7ojy/2YVAe+1khjnjT5/c2oq8hGJOdxKDYfnpNyinTCgL6Bta/JkbVRCG0pnMGWUpDC9NK60wyiJJb0zOn07u3bM9/e53s6uJ6/eYpRB2/t4dRSyv+WaACg6ZmUS4sBFa4oaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=C5a85VOZ; arc=fail smtp.client-ip=40.107.8.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzJbg+/zfnmgdZXzJVW6HllY14I4PXZrCWnojgvnUTygvvpyn2m/ST/Gt1ibktYgweY8aVMvCI83wUgtjOfRnisHO7Mkik2scsY5G6Pq9nsi+BuWMa6gTfzEVoVn0f66H1Uq2BopspYftuGGYyuPiapUG/c0BAC9cJTazKXNcCWiFrFl1lQJw3oql2HNXmeRryZyAAJ5EnS18D3BMPakBeQWwM38XlrI2jRHOybEz3QMIXTRC3D2iItL4MUvoF71W7kEF8qD7YzQkzLqznOKV+rLDioSz4AfY5u1KfU+6Ytp1M57ULco79RkTeI3yE2NQVWBF1Ymz3zMhWt0QHIFRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8QyFXGUk/07AS0lsFBStQHTKB5E5mqVCPB7xIp0HG4=;
 b=Qxz4FKzdr6zGDo1lNGzhvv8qyHXQihl6ZU/sZgtON6WOBECUBZjy9aoWUh4bkXVgWmsU9Sxvgfw3kLCrinFDr9IOrslSAkqfqt5hxhfBWLBhB3W4Vj7IheM/I7FbT2peRfxqb/dbXO/TlR7uIX62Vg4lfTD2pIrbgN2brCh+0xlQ6f9XoCojzmm2CmwoPMueKt1D7MfFvPEYbh+LXQO+nr+50jKC2uPJ78SNViWb9fCWGAXfKzCC7Bk8AmkIYwS682Gn49e6O8vcxAbz1eLnCV2lzxMeDmkKGVRP3ae11yvrfbPpCctTkmkg1G5gLFAYU6TBUKXy4PJt2YeDghdMVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8QyFXGUk/07AS0lsFBStQHTKB5E5mqVCPB7xIp0HG4=;
 b=C5a85VOZceqVmQbxnlwSOetxOfZM2y8+XJjxwAhC4X65ifSbJHJVjrOEvNAC3qVkkFClkIbDrm9u+xwxXsunNqDgQ8RxSXnDZkyIR9X5vlyUP8JZgeTjzxZ1BKuF5x1V+w/KIyj9fIlCux5XR6Co33FxBCutuiOPbAviEF0Da0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com (2603:10a6:10:1b::13)
 by VI0PR04MB10289.eurprd04.prod.outlook.com (2603:10a6:800:242::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 09:12:46 +0000
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::ac08:df46:97bd:4ae6]) by DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::ac08:df46:97bd:4ae6%6]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 09:12:46 +0000
Message-ID: <e220061e-0bb5-4fa4-9a91-aefd81e6636c@cherry.de>
Date: Wed, 8 May 2024 11:12:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] arm64: dts: rockchip: Add OPP data for CPU cores
 on RK3588
To: Alexey Charkov <alchark@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Chen-Yu Tsai <wens@kernel.org>, Diederik de Haas <didi.debian@cknow.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Kever Yang <kever.yang@rock-chips.com>
References: <20240506-rk-dts-additions-v4-0-271023ddfd40@gmail.com>
 <20240506-rk-dts-additions-v4-6-271023ddfd40@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240506-rk-dts-additions-v4-6-271023ddfd40@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0004.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::15) To DB7PR04MB4842.eurprd04.prod.outlook.com
 (2603:10a6:10:1b::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4842:EE_|VI0PR04MB10289:EE_
X-MS-Office365-Filtering-Correlation-Id: ed49d9ea-57cf-4042-aabc-08dc6f3f066c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MU9uL3hmKzFMSkptY1JPMnFtRjliRlBvSUZQSUhRUzVoNjZjTmRpMmhSUUVz?=
 =?utf-8?B?aFdVSmRnMWQ4dG9ITTJtYnNMYWd2MGd0QVNGN2crcVN4emFTSk4yWGgxNVMw?=
 =?utf-8?B?ZE8xK2N3VlZXVXZzcWtodFNqdGRLakFHZTNXc2pKZEVnS055emhBcFlnTTdB?=
 =?utf-8?B?R0g4NlNtOHg3L3hIU3lGeWFrNWs1YUtxMFIzc2F3L3VoL2RZYlgzb3FFZlhj?=
 =?utf-8?B?ZWVnc2Y0Vk5RNWxMR1dxbWo5Y0xEQUt3SFRpQllESzVNSzBUc3BudEtUYWVO?=
 =?utf-8?B?c0doMzFxbFlEUmtZOU13QUZXUXljYlVUV2N1TWNmaklDSWc1M2lERkhCVXhB?=
 =?utf-8?B?UnRWMXhVbmxJSVVMYTNoK2dQQkF6UncwRFl1VWg2bUVpT2tUQkVRMS9odm92?=
 =?utf-8?B?ZEh3aE5QWXRqQStFSjdldnlRNmZ6bW9GMkR1VDJSWkhVbzYxdzVzaXc4cmJB?=
 =?utf-8?B?NlpGMFdBeXVrOHE0cml4TzZGVjY0RHF0UzNPcXpqSndHN2ZFNXlNOEEwN2t5?=
 =?utf-8?B?WVVvc1BINndqOEJRMWVla00yM1EyRlg5MEg1L1JEL004cWV4Q0ZmckdHV2l6?=
 =?utf-8?B?UEVvdldLTUdQUnh5TE9DT1YrWncrZnhzakM3ZERtL3htNjVPYVZqcDdhUUY1?=
 =?utf-8?B?OHEvamtWd2JuZExjMmR5QjJwQ0ZOcUIxUzJLelpPUlpISGI5M25lMmxPODky?=
 =?utf-8?B?MkwxWkFydy9FL2tmQktjVDZWZEhZdzFocnR4c213UmpMcWEyb2NSOEY4aXNO?=
 =?utf-8?B?aXN0V05ZNlByV0s4aG1aK3FxWXU2QVlwZGJKMGRnZHBrb2Y1MnB4VjB6VTdP?=
 =?utf-8?B?cFNvMzRhdDcrTDdUNXBYN1Y4NVJXTC8zRzZJK0phZGkzR1hOaDhXRU1JYU1F?=
 =?utf-8?B?WXdJR3NUdFBNNzRLcnc0OFNDak40ZUc2MUc1Rk9ScGdXN0k2VHFENnV3Uk1C?=
 =?utf-8?B?VTZZT042bGpFUENHSThNVFdsSUJRSzlvZmVKNy9qaFFpaUtoVGNBVVV6MUVC?=
 =?utf-8?B?NlVqWEZCS28rd3djZUlxVmFNcGMxRis0V2RUVjQ4WDZuWStwcXUvK3FxWTJF?=
 =?utf-8?B?N0poeUNhYnBRK1V3NjRaVVRHSnBTNXZsb0Z5aXhDMm0zRVJ2cmFVamJheVNV?=
 =?utf-8?B?MnYvdFV4YWVJeVMyMmJuY0lKZkF1YXdzOHhNOE9sS0YyZnA1cGFyWUJKRzF4?=
 =?utf-8?B?YndEMUQ5RHdtSFdXK05OelJHTS9SVnZUUktvK3R1TDh4WU9wWTE0ekRWOG9D?=
 =?utf-8?B?T2pvWldSRnZMNGZKRjFLSTBGY3dOeE9WQVRpR3JSZDhTWnM5U2thVXRaS3dV?=
 =?utf-8?B?VndCeUR4VWNtMWtOY3dmeGVQTG1tQnNxeStMcUJrQXRRamtwMlRiNzU1RzN6?=
 =?utf-8?B?TEx4OHJuMnVHTCs5bWJGbTh0aWl6UXFUeER0UGlWbTVaTlN6dS80UVNuUHUx?=
 =?utf-8?B?akdGTDVlR3pmVkZuTDNKT1huV1czNVlMYUhrN3dwSGVBbm9td204QjdXQk11?=
 =?utf-8?B?M1gyQmxOdFBWMEIxOG96eWY5aE52WmhNTnkvQ3dPUFZDOFM1c2NsQWUxa0Fl?=
 =?utf-8?B?U1VFOEZyU2NMQUErN2Y3UXI1WE5QWDVET2wvNVE5TUR3NjdkQ2RBdEFQUU5G?=
 =?utf-8?B?SG9sMzhlbEorK2VCTFIxUWk3Vy9ubkJOMiswWGxoUlVoR3hvQWpiVUE4ays5?=
 =?utf-8?B?Q3VYRjNyeDZtNVZNSjd1UmlERURQdGFObyszTFN4aDBHbHd1NENXdlhnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4842.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmUydGZiblY2cmprVUFsVDFFYXFVb1krMmlqbEszL3l2TTRHa3dVeHIwcS9G?=
 =?utf-8?B?TG5FUUtqVzJHZFFXd3BmRG8vR0tncTRTbWZSWWh4Sk5JT2FMN3N2eXgxenAr?=
 =?utf-8?B?VnFCQTM5Y2ZqSUEwZWxOSlptZTZLWWx1N3Y0ejVOcU1UTkhFaGh2YnRtYW1X?=
 =?utf-8?B?QWIxQjRMMzhVYWpQQVlyZXFDT3NtSlBDczBjZHg2NytnV09RTUZVcjJFM2M2?=
 =?utf-8?B?UnRxTHN0ZndiQjNtZG1RY2pVVTRWV3BSTGVqTHpPbXlhMmVPTGNRU1cydm5l?=
 =?utf-8?B?ZEhxL1J5cjZSMVArZTZhcGtvQk94ekpVYStBcmx0UXJnYmdLYXU1cWxLdU5h?=
 =?utf-8?B?UjJ5VWw3N05sWjBNV2dudEtzTHdvVmpDQ0NaT1BwWHlGczVHa2R5SGg2bzZy?=
 =?utf-8?B?T245SzUwMDBydERVSUtKUm5zZUNkc0JhY2tZSlBDM1c4QUVTUzcxYk5uMWp3?=
 =?utf-8?B?K3FRSjdlZXNIQW5TVXM5Y3prWkF5Sjd5MWpQZjVOSW5zbUpVWnFXMmZNR1A0?=
 =?utf-8?B?QzQrQXpvUzZMKys5eDVnRHZRek8rUnVjank0dFYvWGl3WWZER0V0czV4RFdB?=
 =?utf-8?B?U1crK3hsRStwNllLUk1KNG1zWHJOSWhpRFNOdjJlaW5FNTB0UkxweGc0Zld2?=
 =?utf-8?B?N3JCa1IwZG9iNEM3c3QxclhrMEtDc0p0aE8xZU9RYW5vT2xMQUMwdFFpRzhQ?=
 =?utf-8?B?RkJBdDFhUVNwd3hMQm5pbDJnRndnZkoxOCttaklyL0w4Smg0OGMvSEtSaGZ0?=
 =?utf-8?B?YUpBZ0xoNDN2czN6UUNwbHRQZU9TVHNDVVJ6bDhlOEg1ZEtkRi9NV29uSEMy?=
 =?utf-8?B?SnZjek9MZTNwSGQycnFkOVg2NFV0QVVUREFhMlNQV2ZlbW5OQXJIRUxmQkFH?=
 =?utf-8?B?THg4c09henVUQlFrbjFmY2lCeW9sRzJlWFkyUzF0SzVVTVVZeWwwTll2Ris4?=
 =?utf-8?B?SEo4ek5LaFpDeWcwZnZxVFpBblBaOFpQakpUT1N3RXJpaG01Y1JzSEJkaVhm?=
 =?utf-8?B?SS9rUVlKYWhRbkp2OHRONHB2QkE3V3k2dmhLZitTaENSK2FST0lZS2hMcjhs?=
 =?utf-8?B?UmlxZGtxcStqTkt4MGQ5RnhsNnZSVzdQczNueEtUU1YzZUhidlZkOTU3YW52?=
 =?utf-8?B?RjJYTWpQT2RwSWpUOW1lTDZ3OWVBNXRQR1FTdStFa0FQYU1aOCtVeGRMcnQx?=
 =?utf-8?B?ZHh4ckZoNml0eHppOW1vMURQenhESHpmdmcxbGtadHQwd3RWVXIyL2M2ZFpu?=
 =?utf-8?B?aU5KWVZHL0s2d0lUWlVaaytRaGdSZG9WbGV0UzRQcXhCK2JyVzlwUWRWTjVk?=
 =?utf-8?B?UEZWQVNNREp5Z3Fxc1B6K2ltL0huTUg3Z0pPdC9tN0FzdFFxNG9CZXA4SDdK?=
 =?utf-8?B?THoxSE5VQ0RScWxJc25JN2R2VmVRWjhPSEwxMkFCcCtlMW9paHdTTWE3NkNu?=
 =?utf-8?B?bmJuckxLTFBKaEVaUHBTMmFPdGQ2Wk5ObHhucFBwNzBQRGN5anZwVUpJRldJ?=
 =?utf-8?B?cm4vTEFRSytoZ1UrN0wzV2c3SU1KMnlwMGJWTVRLaFZRQU5iOFRNaVNpcXdi?=
 =?utf-8?B?WElCanFsZUEybldRNzk4NzY3MTdSTEY2RTNBYXljRnJuZzV0a3NVV0xEU0JV?=
 =?utf-8?B?elFiQWM1VC9ES2cvazJPeEU5dzdHZldDc0xrTkR3d2xaREw4SWF4RTQ3N245?=
 =?utf-8?B?ckFlY1BWdXRFbnM0K0dXZXRKWjlkOGQ5U3FiWThBcnA5eVF0bG1SN2hXOFNZ?=
 =?utf-8?B?TmtaK0tlZTZTRDQwcklTUUU0c2F2ZlY0Y1BtVHBzdTdqUS9mU3poYXZBczAr?=
 =?utf-8?B?MWljK2htcXFnRXhoR0ZrY01DYW5FSkFiZmdTMDN2SHlESmxEOXozTkcvT0Vs?=
 =?utf-8?B?ZHVaMHZpL3lIbjIrQ1JzSElpM3FlOFhoWUtDQklJRlcyZmwzcVk3empEQWZk?=
 =?utf-8?B?eTcycnNuU0xzSWhsSmRHMStOTmRSYXYwM3Zxc2dUeUlDYUhKN29OUk1rZExD?=
 =?utf-8?B?RWZmSFZEU2hwRW5IUXJUdkROd1piTUJLWmxIUXRYYTIwdlp3bHNoMndZMm42?=
 =?utf-8?B?VDZxUHFQMXozcE9FWTMvNkJCOG9RZ0hDdTZDa3g4R044bzQ5SXV5Y3JLM1I5?=
 =?utf-8?B?MWxhejdrSXBmYXhFbDdiU01ta0w0SXdpK1BsTlp6YWNjVlIvdGNoUVVlZHQy?=
 =?utf-8?Q?CzdqTb7lRVCsTiy4DoVKhOU=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ed49d9ea-57cf-4042-aabc-08dc6f3f066c
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4842.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 09:12:46.2371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2t8UXjIAPKdc6DSZIAuDYBOFA64MS7pRV2D+Ycjc5zmqlUpoX65v8jn+5iLlexZmLTMZ6vsSegdMWZnYgIigrCGJMJBo4xc2Aya9nMHsbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10289

Hi Alexey,

On 5/6/24 11:36 AM, Alexey Charkov wrote:
> By default the CPUs on RK3588 start up in a conservative performance
> mode. Add frequency and voltage mappings to the device tree to enable
> dynamic scaling via cpufreq.
> 
> OPP values are adapted from Radxa's downstream kernel for Rock 5B [1],
> stripping them down to the minimum frequency and voltage combinations
> as expected by the generic upstream cpufreq-dt driver, and also dropping
> those OPPs that don't differ in voltage but only in frequency (keeping
> the top frequency OPP in each case).
> 
> Note that this patch ignores voltage scaling for the CPU memory
> interface which the downstream kernel does through a custom cpufreq
> driver, and which is why the downstream version has two sets of voltage
> values for each OPP (the second one being meant for the memory
> interface supply regulator). This is done instead via regulator
> coupling between CPU and memory interface supplies on affected boards.
> 

I'm not sure this is everything we need though.

For the LITTLE cores cluster, all OPPs up to 1.416GHz are using the same 
opp-supported-hw, however the ones above, aren't.

1.608GHz, 1.704GHz and 1.8GHz are all using different opp-supported-hw.

Similarly, for the big cores clusters, all OPPs up to 1.608GHz are using 
the same opp-supported-hw, but not the ones above.

1.8GHz and 2.016GHz, 2.208GHz, 2.256GHz, 2.304GHz, 2.352GHz and 2.4GHz 
all have a different opp-supported-hw.

The values in that array are coming from cpu leakage (different for 
LITTLE, big0 and big1 clusters) and "specification serial number" 
(whatever that means), those are coming from the SoC OTP. In the 
downstream kernel from Rockchip, the former value is called "SoC 
Version" and the latter "Speed Grade".

I think this may have something to do with "binning" and I would see the 
ones above the "common" OPPs as "overclocking". Not all CPUs would 
support them and some may not run stable at some lower frequency than 
their stable max. Adding Kever from Rockchip in Cc to have some input on 
the need to support those.

Cheers,
Quentin

