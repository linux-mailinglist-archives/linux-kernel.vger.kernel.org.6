Return-Path: <linux-kernel+bounces-362105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC45699B11E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 07:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDC6A1C20F83
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 05:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBE6130E57;
	Sat, 12 Oct 2024 05:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="jRS9xg/3"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2120.outbound.protection.outlook.com [40.107.255.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DA9946C;
	Sat, 12 Oct 2024 05:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728711809; cv=fail; b=dLDlqG/ExRflt5dxj6BewznHhTDN2GZ7CuTW65crB5/kBGXJ+G3jNhErWj9Gl1EWnVdhxVrY/YSZNcwAgCPsnQ1mtdlCMrgpA70cwpnozO3lVAejuEhQo/mHc3LkGzslH27QQhO3vUtJmI4RR5RwGkwrkQmegcPwwtuyJF2UgtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728711809; c=relaxed/simple;
	bh=PYuHKWhIAzjQmgp4F49kLBxTCUU5+HRxtY5gAKlo59M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hFQQlD8KtuJeoQ+FmuW3JBiko2o65mslRpSIslwcmODqqgpa/fjUUZgksMP9Ik4EYuUOCTQ7b6xvesdRwX3NWHGW1JTkEhX97E37InoO26fRijG1h+trafMbQcFV632/gJljtiJS0tf1XNzFrmZLCiI3CJYem0FbR32RE8FXQm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=jRS9xg/3; arc=fail smtp.client-ip=40.107.255.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6yQp+XBVYQaMqbjtg1nB3ri2PIDI98HnnZrBHMGlZE9x5at9sdDN0t4TB858BoS6UaFOUZ/nrigX0twijZb/v51luIW+MPWK7yRiVyg5bo6l4RBCU1/05+DPeNt4itfw1HsmCO+bigQObHk6huFppOw+dsyyh0c4LP3hxC8JeXBpOzJwM82x7uA/IEwDiExR3046+BZclcJ0WRutsBeluS2aq2hE+8I39wcgFmJSrCGMlNIuuIqWvJdoJh//Bb1sSDoKHbTUjGcpS8GuljffG9BC72UvkWC1b+s/L4UobpDY1fUdh89M8Ykoz7QGCjwpaLzY5YDVViqElCHs6qVvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEvTeLFopiM5BbvZs/fPD4M/Lr0mE85hr6E1YoULBHw=;
 b=Zq0ZBVgHHkEswqFS7eUN2mnfX3CIWjpedexnY6QR4tNXw0T64d5/ReOSS0OXTXWSDs9EEwnznt/ylFqruJQWraqLpA9r7lkFHMQLM4OlN8H/5+rDTnkab7nBTzZyZa6oiyJF1UqYPInXLZUqO7dcAfc/XAPJ5MMmbGvyH4J+Hb/s9aJ/7fLHNAi/Tpty8mnARUGDeWNiXseA1V8vFSWBYX6PBsYq+nRez/mzp5MhfQuRHyt0nspahRwvk1A1ttCy6f0dnejhAZ0/tj/ZBzo8JhSjb8PKDdSMjSH/bXaEs6daaJ3uMjM7DKrR+04VNKnzhA+sDr//LO/SwvrKWsWNLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEvTeLFopiM5BbvZs/fPD4M/Lr0mE85hr6E1YoULBHw=;
 b=jRS9xg/3y+xSa+DfwNNTK2Jz5szp4t8EibsnylW6xOyxOWiIgUCfd82rAZcjzR4q5dyLnjaPid1+U7oKaDbTHulI/cD+gaNSqF0pHzf42kTvxqeJUcnYjFzfOKOE7R2RBJ4kAJvVhCPmwpzVIBZo512A4v3jBLi5O8S2HD11kUX/+7iMYtfaubNfQ5pZh0ROF+NMbPmd+ODdmbjuP0WYKD+8+myMLe1xk/kHzMFvUlSI5yBsGmVZgsThZTucT0W718V/ZSW0/tqBE5VqqCPRrXjAt/u5VhapM/8n7Ofnyb6whTmEtjzE/UxUTPp8iNqy2IjviZ6JyRgBxy7VggLqQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TYUPR03MB7206.apcprd03.prod.outlook.com (2603:1096:400:347::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Sat, 12 Oct
 2024 05:43:22 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%6]) with mapi id 15.20.8048.017; Sat, 12 Oct 2024
 05:43:21 +0000
Message-ID: <0db7362e-5542-4b93-a07a-d7de3af94bdb@amlogic.com>
Date: Sat, 12 Oct 2024 13:43:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] clk: meson: add support for the A5 SoC PLL clock
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chuan Liu <chuan.liu@amlogic.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240914-a5-clk-v1-0-5ee2c4f1b08c@amlogic.com>
 <20240914-a5-clk-v1-4-5ee2c4f1b08c@amlogic.com>
 <1jplotxg8e.fsf@starbuckisacylon.baylibre.com>
 <4e2c7bb7-b97c-43c3-8938-4831e9d1376d@amlogic.com>
 <1jploltr55.fsf@starbuckisacylon.baylibre.com>
Content-Language: en-US
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <1jploltr55.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TYUPR03MB7206:EE_
X-MS-Office365-Filtering-Correlation-Id: c77a48f5-bc9e-4a51-4e52-08dcea80c833
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjgyWURyamU4UDVxclRCeWFZRDM1K0ZJME1mN0ZiTEdqc2h1NWVTdGNXUWox?=
 =?utf-8?B?dy9NZDFkaVJQTHhkNHNsdXFVZkdJRS8yRDVING90QXFOVmZYODFhNVJta0ZZ?=
 =?utf-8?B?MzlOVitFcjF2NVlRUjRnbkF2TVdISCtvREE0L0RQQkpCdy9RY1pDY2VqUVpm?=
 =?utf-8?B?MEwxQStFSlBxTUVwVFIxUGJaWXZDVnhGMHBLL3RxUmt4T2R4eFk2VEZUOXhC?=
 =?utf-8?B?SkFST0hRTXA2djZDN2dyRUdIOU0xWkJlRTBmV2lsTGh5Mm82N0NGUlcra1hS?=
 =?utf-8?B?ZFEwU01BVk5ZY0F3TDV5M1lNcEVZSGRoOXNaUk4rYUh4S05mMDZnZ1Y5L3JW?=
 =?utf-8?B?d2tCQzRqaFFHN2RLYTlOcWNUNjFORDl4WmpyeTc3WHdnaFZXbjRjYTV6dkEx?=
 =?utf-8?B?bUFveDZJNXNEU2xHVGk0Z3dtbXZFM21ESkdMWE5IMkpOQ0lTc291ZDdKdFdt?=
 =?utf-8?B?dGdkc3BjTERtalQ5VkJETC9ZOUdaVlZWR3pWczZsWWxhbmx2L0d1dDhlWDNV?=
 =?utf-8?B?NmhPbHBWbVl0MThpUkZjR3laTE5NY2dVbFYzblFxclNnWE54ZjdYTHpkNUhG?=
 =?utf-8?B?TUJmV0xoUSsyNHRFRTBVQzFOeWVoWUw5Z1ZjeFY5U0Erd0c1TFpVN05EOFh5?=
 =?utf-8?B?L2RncGJXQUlIbVZXOUh3VGdTUDNqNFZ5VzVrSWtKUG84SVk5M1NCZERtMURP?=
 =?utf-8?B?dXQ0RUVJWGp6QXljNUR4SDlvUlNoZlowSWVwb1MrU0lEL2JGb25pb3NwRmRt?=
 =?utf-8?B?NVppd2ZmcXNBRlpJYnhSRlJxTmNUREQ0NlBJeEw3SktpcmI0NE4ydnF5RFk2?=
 =?utf-8?B?ZmNabS91VXhKMndSTzE1aGpTb1pnbWJxZHdYT0x4eGJRQ1E4N2tiZUVkVGZ0?=
 =?utf-8?B?UXpRcjFQbXJTYzRXTCtJd1pyNldOMTNLbC9oanNxcmhYeEFObkRiWjdoUExa?=
 =?utf-8?B?WGIwR3VDVU5UejFBSW1XekRMS2ErYTRWTWhZY3FiT3hxaGR2S3JDWlFvamNO?=
 =?utf-8?B?R3FWK1d0cW02U3NpOVZXS3pYZ3g2NHB4d0tvUHNKYTJhZ0VzcmY1R2dNY0JG?=
 =?utf-8?B?dStlL0xPV1M0b3JkOWFXVDhCQWtINE9ZOFZNOEY0WGJqSGNIS2lTb0hERUxU?=
 =?utf-8?B?WHhyZDF1MmZMei9yaks2NG5mQ3dYKy9aWTM2T1VHZlBFenE3aXhGSUhzNE15?=
 =?utf-8?B?ZktZOHF4UGRqbUVQMTR0RkNYTDhwM3VadVlqL2JLWTMwMnJVZVV1STR5QXU1?=
 =?utf-8?B?M1FWdWl1NzRPRko5QVUydHVoM2NONjhCaFY3cU9UOTEvY2t2UHNMWDN0cExX?=
 =?utf-8?B?TW5zVC8rdGVGbm1TYjQ4L3RzNCtGb0RZc2ZIR0NVdEFYTUw0NkNrRGw1VkZZ?=
 =?utf-8?B?VFVQMDhmWEFxbllEMmhWZVVQL2RRRDhYWGhBVllhdG1qRjBSVUwwemhYRDBy?=
 =?utf-8?B?K2JNMWhwVUVWK3lEMWJzRXpCM3hXTExVMi8vSWpjMTdIYi96ekNmb0RmZ0Vn?=
 =?utf-8?B?aUVkMjdKMnQwWDN6dzdncXp0aWROVDhyM0lYRHlOZ1N3bVpESzdsR0ltNDhS?=
 =?utf-8?B?ODlLSzMvR3A1MDNSNlRvNmovWVpyQ1Q3MmVDN2t2QWdBWWovV0RmSlkyQy9p?=
 =?utf-8?B?Q2p0dk4zd2NzcGlReUZKdkpXYkoxeGErWXd0cWw1OStIeXpvMGI5RytPY1A1?=
 =?utf-8?B?MFFaOUlzU0pPbmVXZURKdFFKaGFubHNlbDZESUJTQ1NvYzJRaEdJSzVBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGxIRjMxdnZIOWJMM2RKOVY4dXl5bjNMaUplMmltOG15RDFCL3pTalU1NXhh?=
 =?utf-8?B?dHdHSkh6L0FrcGVuN0FNa1c1MVVIUUMwalB0MWtWcEFhZk45eU9ScVhTRWZV?=
 =?utf-8?B?SlNtMGVxV2M3dkNkZ2drRjZ4WTlPYXloQzdBbExnWVprT3plc0djbzdOdHdx?=
 =?utf-8?B?WHBaNC9HNFJEVml5bldTS2dCa1YwU3l4TUhDWCs2NDFMNGNFV3F1Ly9rajJS?=
 =?utf-8?B?TFhYRDNjTEtrZCtRNTExbmZzNjdTOUpQSVdETkd5SlMxZU1wcUloaUpwaFdC?=
 =?utf-8?B?bHF4NUYwa0NpS2lYMS9sODZBSDc5b3Bla25BZ3daczAvc1kvSXhabHUvRDVn?=
 =?utf-8?B?MmhIOGdaQ2FScWtnQUs0RzcvSDAzL0JCTTA5enBNYk11SW56ckVmR0JjRThH?=
 =?utf-8?B?UzNuYS9hOWVVc1NaSmJOZW52QlZ2NGZDR2RyUXE3dEQwaWVPQWtpV2MzNDFI?=
 =?utf-8?B?ZDlIaXBRcTk3UkRjdWd4RTg0TjQycHNXejdQcWJ0Z0NnMHc5VytWYWRFSlEr?=
 =?utf-8?B?eGJZUVFYc1JWalozSzIrVDlrWXBOQWVZdzJia2pwcHFybkVpclRiMmRMTjkr?=
 =?utf-8?B?aXdXK2lrKzlOOE5sZGVmdDRDZ0Y2ZHNTNCtsOTc4VjdVYmwwYW5ydXJrRVBQ?=
 =?utf-8?B?R1JwdU0yUjg1RkVLWk5GUWlZaUpwRXhNVFFXeXl6U1FoV3lZR0V2azZRamc5?=
 =?utf-8?B?UVJVZk9IcU5LenBrRDFaZFFaQlQzR1psaFJrQmY5RDFKZzVDVTdaaitleHBh?=
 =?utf-8?B?N1Fwb1lETXFqTTUwZ2Y5WENXdzA0MHgvZ3RQcXZQVFZZbktkOGR6SVdhcTJD?=
 =?utf-8?B?N3RoY2ttWWluSXVsK2FYaUFrWjdkK0hBUkpXWnhZQUM0TFluVDgyLzlWZlRI?=
 =?utf-8?B?SkhCcWg3MlpEQUJxTjdULzM1aENMRjVGM0o0aW5qQyt4RjRJQ1lnSHgwdUpK?=
 =?utf-8?B?eWhFdmJ1TWJCVStpcFFGd2JsRE4yZTBOMSt5ekpTYUFHeU0xemJwY2RvMU9I?=
 =?utf-8?B?eWtMWG16QUk4SWVwMXppcjZiMmwxSHNlS0d4bHJrSi85a0xEZU1QamJOVHVL?=
 =?utf-8?B?ZDVJMTkzNWJBaXNZWmRNcEFnWXJLdURWZUZ0TmZRVHJEMEY0OFY4YVlHMHlG?=
 =?utf-8?B?TzNHekV3UXQwUDlySnJZWVByTjBGZEFGSE43cXo4Mi9aTVJ1QVNuYS9rZzNE?=
 =?utf-8?B?bVU1MWFnR1RJRDR0Wm9sclloekdPeFlIUHptL2FDZlE3Y2wvVXJ4QUVDTEFZ?=
 =?utf-8?B?SHNDUkNnQmZabldPeUQ3SytSclE2UmJCaTl6VEQrNFk2NXozUEdhYnNyL2x1?=
 =?utf-8?B?YWs5cjJZSWh0b3RDY0xLTFprN3B0TWM4WE5ncEV5cjhBeENWN3NRTi92RFlK?=
 =?utf-8?B?R09GNW02OFVBaUhORTBsM0VWVDhQRXhDVG9wN3dINHFKZEtRMEtZK0NRQ2hy?=
 =?utf-8?B?b1V1Q0VMNGhKT3p1aTUyUjE0TXJQdmtiblVteXcrT0dWdytDRmh1ZUdUT0Jt?=
 =?utf-8?B?R3p0M2ZoNytmSjIybXhSRk5oNjVGQ2htVU43V1Jvd0FvemFtMlYwZGtVVjVl?=
 =?utf-8?B?bGd1UzJkaUJ0SDhPbHJ3S1BkNko4WkhMT2xwS0lBbi9VSGVnVTkrSlpwaWRK?=
 =?utf-8?B?bjJjU0J1VXMvRTRYcUdRalRJdFZ5NjQ0Q29oMmRWOVdqU0FUalhEZExjSkJo?=
 =?utf-8?B?L2J0aGF6RUk0aThEN2M5Z1B5enR1dnhGV09zS2dMTDlSajdnK2ZMQ1VVNlVD?=
 =?utf-8?B?OVlUSGw0dUtrQ0hmZmkyYW1EdmxNRzZaVHIrRGJtMEdwS2hSeXNCS0VPQWZK?=
 =?utf-8?B?S1RPcCtabDVsZFRiM3BBSFhQLzVYaTlCUFBLYWNzUGw4TC96TnlFM09LaXdz?=
 =?utf-8?B?Sit0MDF4QmpDYWRud0MvS2M0K1A1MW1qWWk3WVdhS0k4YjN4NjBRTlBYRmdP?=
 =?utf-8?B?dHloSUlQejk4WkptdXQrSDB3UFE3L2J5cXpzQXNZWG9wckx6bWF3R3ZqSEFk?=
 =?utf-8?B?b2hsY1JScUwxNXhrNldHM3pqb2t1ZXBYZ1g0OW1SWHN0ZXEyM2R3RjJRdzF1?=
 =?utf-8?B?azd6NktXQVBVemZjOTBLanRqTFZFd21zTjFZN3FRaWhHSlBkSW92REdndDFD?=
 =?utf-8?B?SCtJa0pBQS9SQzB5WUliSlF2UE1MeUtuWmV3bmIxOW51bnpnUEx5NjV2d2tk?=
 =?utf-8?B?d2c9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c77a48f5-bc9e-4a51-4e52-08dcea80c833
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 05:43:21.7480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BnwTFjotyw8d5JkFVsO6U7OPtAeQ2Lqm6xbTK6F8w9ZaAES9l+AtXieKx1cObAo/ko9XIsxmp2uZ/9pOmoyiQNniHAHM7095DQ23QICBTeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7206

Hi Jerome,
     Thanks for your reply.

On 2024/9/30 17:41, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> On Sun 29 Sep 2024 at 16:17, Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:
> 
>> Hi Jerome,
>>     Thanks for your reply.
>>
>> On 2024/9/24 22:45, Jerome Brunet wrote:
>>> [ EXTERNAL EMAIL ]
>>> On Sat 14 Sep 2024 at 13:25, Xianwei Zhao via B4 Relay
>>> <devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
>>>
>>>> From: Chuan Liu <chuan.liu@amlogic.com>
>>>>
>>>> Add the PLL clock controller driver for the Amlogic A5 SoC family.
>>>>
>>>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>>>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>> ---
>>>>    drivers/clk/meson/Kconfig  |  14 ++
>>>>    drivers/clk/meson/Makefile |   1 +
>>>>    drivers/clk/meson/a5-pll.c | 553 +++++++++++++++++++++++++++++++++++++++++++++
>>>>    3 files changed, 568 insertions(+)
>>>>
>>>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>>>> index 78f648c9c97d..2a713276e46c 100644
>>>> --- a/drivers/clk/meson/Kconfig
>>>> +++ b/drivers/clk/meson/Kconfig
>>>> @@ -132,6 +132,20 @@ config COMMON_CLK_A1_PERIPHERALS
>>>>           device, A1 SoC Family. Say Y if you want A1 Peripherals clock
>>>>           controller to work.
>>>>
>>>> +config COMMON_CLK_A5_PLL
>>>> +     tristate "Amlogic A5 PLL clock controller"
>>>> +     depends on ARM64
>>>> +     default y
>>>> +     imply ARM_SCMI_PROTOCOL
>>> don't think this is needed, same as c3
>>>
>>
>> Will delete it in the next version.
> 
> 
> Ideally, please trim your replies. This avoid the need for me to dig in
> such long patch and find whatever it is that you replied.
> 
> That means, remove text that is not necessary to the reply, leaving the
> necessary context for the discussion.
> 
> Also, if it is just to say that 'you will do it', a reply is no
> necessary. Just do it, it will be fine. Reply if you have further
> questions, remarks or do not agree.
> 
>>
>>>> +     imply COMMON_CLK_SCMI
>>>> +     select COMMON_CLK_MESON_REGMAP
>>>> +     select COMMON_CLK_MESON_PLL
>>>> +     select COMMON_CLK_MESON_CLKC_UTILS
>>>> +     help
>>>> +       Support for the PLL clock controller on Amlogic AV40x device, AKA A5.
>>>> +       Say Y if you want the board to work, because PLLs are the parent
>>>> +       of most peripherals.
>>>> +
>>>>    config COMMON_CLK_C3_PLL
>>>>         tristate "Amlogic C3 PLL clock controller"
>>>>         depends on ARM64
>>>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>>>> index bc56a47931c1..fc4b8a723145 100644
>>>> --- a/drivers/clk/meson/Makefile
>>>> +++ b/drivers/clk/meson/Makefile
>>>> @@ -20,6 +20,7 @@ obj-$(CONFIG_COMMON_CLK_AXG) += axg.o axg-aoclk.o
>>>>    obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
>>>>    obj-$(CONFIG_COMMON_CLK_A1_PLL) += a1-pll.o
>>>>    obj-$(CONFIG_COMMON_CLK_A1_PERIPHERALS) += a1-peripherals.o
>>>> +obj-$(CONFIG_COMMON_CLK_A5_PLL) += a5-pll.o
>>>>    obj-$(CONFIG_COMMON_CLK_C3_PLL) += c3-pll.o
>>>>    obj-$(CONFIG_COMMON_CLK_C3_PERIPHERALS) += c3-peripherals.o
>>>>    obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>>>> diff --git a/drivers/clk/meson/a5-pll.c b/drivers/clk/meson/a5-pll.c
>>>> new file mode 100644
>>>> index 000000000000..d96ed72ef8d4
>>>> --- /dev/null
>>>> +++ b/drivers/clk/meson/a5-pll.c
>>>> @@ -0,0 +1,553 @@
> 
> [...]
> 
>>>> +static struct clk_regmap gp0_pll = {
>>>> +     .data = &(struct clk_regmap_div_data) {
>>>> +             .offset = ANACTRL_GP0PLL_CTRL0,
>>>> +             .shift = 16,
>>>> +             .width = 3,
>>>> +             .table = gp0_pll_od_table,
>>>> +             .flags = CLK_DIVIDER_POWER_OF_TWO,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data) {
>>>> +             .name = "gp0_pll",
>>>> +             .ops = &clk_regmap_divider_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &gp0_pll_dco.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +             .flags = CLK_SET_RATE_PARENT,
>>>> +     },
>>>> +};
>>>> +
>>>> +static const struct reg_sequence hifi_init_regs[] = {
>>>> +     { .reg = ANACTRL_HIFIPLL_CTRL0, .def = 0X08000000 },
>>> What is bit you are flipping in CTRL0 ? it is suspicious
>>>
>>
>> Yes, CTRL0 and CTRL1 are not necessary here and will be removed in the
>> next version.
> 
> That does not really answer my question, does it ?
> 

Here it is confirmed with the chip design engineer that the bit27 of 
CTRL0 is actually useless, and it is meaningless to write 0 or 1.

>>
>>>> +     { .reg = ANACTRL_HIFIPLL_CTRL1, .def = 0x00000000 },
>>>> +     { .reg = ANACTRL_HIFIPLL_CTRL2, .def = 0x00000000 },
>>>> +     { .reg = ANACTRL_HIFIPLL_CTRL3, .def = 0x6a295c00 },
>>>> +     { .reg = ANACTRL_HIFIPLL_CTRL4, .def = 0x65771290 },
>>>> +     { .reg = ANACTRL_HIFIPLL_CTRL5, .def = 0x3927200a },
>>>> +     { .reg = ANACTRL_HIFIPLL_CTRL6, .def = 0x54540000 }
>>>> +};
>>>> +
>>>> +static const struct pll_mult_range hifi_pll_mult_range = {
>>>> +     .min = 125,
>>>> +     .max = 250,
>>>> +};
>>>> +
>>>> +static struct clk_regmap hifi_pll_dco = {
>>>> +     .data = &(struct meson_clk_pll_data) {
>>>> +             .en = {
>>>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>>>> +                     .shift   = 28,
>>>> +                     .width   = 1,
>>>> +             },
>>>> +             .m = {
>>>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>>>> +                     .shift   = 0,
>>>> +                     .width   = 8,
>>>> +             },
>>>> +             .frac = {
>>>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL1,
>>>> +                     .shift   = 0,
>>>> +                     .width   = 17,
>>>> +             },
>>>> +             .n = {
>>>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>>>> +                     .shift   = 10,
>>>> +                     .width   = 5,
>>>> +             },
>>>> +             .l = {
>>>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>>>> +                     .shift   = 31,
>>>> +                     .width   = 1,
>>>> +             },
>>>> +             .rst = {
>>>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>>>> +                     .shift   = 29,
>>>> +                     .width   = 1,
>>>> +             },
>>>> +             .range = &hifi_pll_mult_range,
>>>> +             .init_regs = hifi_init_regs,
>>>> +             .init_count = ARRAY_SIZE(hifi_init_regs),
>>>> +             .frac_max = 100000,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data) {
>>>> +             .name = "hifi_pll_dco",
>>>> +             .ops = &meson_clk_pll_ops,
>>>> +             .parent_data = &(const struct clk_parent_data) {
>>>> +                     .fw_name = "xtal_24m",
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +/* The maximum frequency divider supports is 16, not 128(2^7) */
>>>> +static const struct clk_div_table hifi_pll_od_table[] = {
>>>> +     { 0,  1 },
>>>> +     { 1,  2 },
>>>> +     { 2,  4 },
>>>> +     { 3,  8 },
>>> Why don't you ajust the mask then ? Looks like a POW_OF_2 basic
>>> dividider to me.
>>>
>>
>> The maximum frequency division value above the design document is 8,
>> such as the configuration 4/5/6... The actual frequency division value
>> is still 8, so this table is defined, why there is this restriction in
>> detail I am not clear about.
>>
>> Will add these comment ot describe it.
> 
> I'm not asking you to add a comment.
> With your explanation, my comment still stands.
> 
>>
>>>> +     { /* sentinel */ }
>>>> +};
>>>> +
>>>> +static struct clk_regmap hifi_pll = {
>>>> +     .data = &(struct clk_regmap_div_data) {
>>>> +             .offset = ANACTRL_HIFIPLL_CTRL0,
>>>> +             .shift = 16,
>>>> +             .width = 3,
>>>> +             .table = hifi_pll_od_table,
>>>> +             .flags = CLK_DIVIDER_POWER_OF_TWO,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data) {
>>>> +             .name = "hifi_pll",
>>>> +             .ops = &clk_regmap_divider_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &hifi_pll_dco.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +             .flags = CLK_SET_RATE_PARENT,
>>>> +     },
>>>> +};
>>>> +

