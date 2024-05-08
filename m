Return-Path: <linux-kernel+bounces-172881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 895F38BF81E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5241C21DC0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 08:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9302140BFE;
	Wed,  8 May 2024 08:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="I2WWOD/w"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2125.outbound.protection.outlook.com [40.107.117.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1303D96D;
	Wed,  8 May 2024 08:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715155615; cv=fail; b=R5A+A2xlKLzovSjWnyaMlcUcJFB1s5HrnKXJDWpDXcX1SYDGznmtu7L1XamlE5KyhzQxc8OS7KIhHAe6ahs9k93WEioYxI0g8pdP+nnRzmE4g0xcJrCUalY9YQZ0Rl6GCDP7z+z0XcKXr9k2JnSPITMlJtN7nbo7Aw0Cnp2fcE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715155615; c=relaxed/simple;
	bh=E93DrrCDr7LpM+mbRlboO4bJTQcAjdRZy+VRQ1jT6Xg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j+x6SzyUS1TjX5MZ/U1ZVNwmQhHoPSA7RJ1HjEfrq71gXO+LoHauE3BbC5LQkX3y9svSts4SV1uuSv+anJKrjh9EgFiDA2AHs5W+VsshfYvNCWMPxZ54OQxEXlnUa3T407nUBLAmUWVUMh/ZViE/ML4EuoN9JcbRmoXBs7HEeak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=I2WWOD/w; arc=fail smtp.client-ip=40.107.117.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCbl54Ow3FDy/zJiiYz0e1X/hYno8gQhDHwCGvnCoHJD/mQZIxdJdYX/whZWRAB35mXPmFVweqF0asfCTKOBIagtu+evPookbC6YPTFRvmqv8PkIDMkTx3SdPW81ORtCkM45vao63hpodbYtMQ4jBmBmK2GfY1OxAeiIMJqxCahhvZ+Z7nGMau6MoiqeIQ8cqQslpVnChkXbwj0WG+QuvMJDCNTzJhA/WPZgBcTJnFGWC7Jm/bj75gSPf9yNcWcSfWr1uu98wMxjcbodKPKqXwpHBP+1qqKyfPovuOR/yUF/6WfbwH5ib9/KEujqIStRXBULQkwBsL+rLio9ly1BGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYkQysNKVngFrcwkl45GjBNk3R860T0nluJhtr4tQQI=;
 b=btDhDkNXKAb1Qn8whmqj7JaM52VPAH3FXGkK2nRKyN+OYDIbJUiqaXstaFfkqB72yu4863+rNpNgcKjWr7YW6DLMHq3/nBmXjHvVLCrJpxAAksbKsnwOhdaTsIalPZvPJfnzhPRRrgjEd4+MfOYY65OJQTuhJvYIPgTF4/GLoq9nAn6TZ5vtO9AiQoPcDQ10lzvxm3FDNfJ1bn86DHJd0drbi8X1BARvUU02j9hP2vUfqBhbeHLfuKwM0l6m5HuWrJdWMRjDktnFZGo6/9a76nbfxOTvCG8hzMRdU/VdAsAgrHbOWCrGWYKHv+iwLCPtCLFYfjIPxlmL7tfD9HPVGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYkQysNKVngFrcwkl45GjBNk3R860T0nluJhtr4tQQI=;
 b=I2WWOD/w3yAMYOOmoKATzThh9BDSBz2MbsTFXbdwyx3TwZLFfDhCUz/BaESo0vFKd4m++s8guQhXLAVU+E6yNi8RnBKNdK/XXRODSRaEfDDO/Rl+a14yTGCLHhSvgGW1mh/LOsWCQfO0vvR+9i/p+riDrlY6cm86Zqa/aNX8kcx1D9xn+Z57VzyqxSBbZI1cfKZPrEzSsVfz/BQXEKFiAOiZ7Sch9Dk9uFpecfe3/oE4fRpOO7pwqbCPrP60bxfL4SUVGcMisPeJ4g2ho813sRuvrXN9+eg+aUDqmR9o+skAClr+WY1/2/Smob3QP4uBqvI4LKi/F4CvfhVZCOZObg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SEZPR03MB7007.apcprd03.prod.outlook.com (2603:1096:101:ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 08:06:49 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::f4ff:211b:7c34:16c8]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::f4ff:211b:7c34:16c8%6]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 08:06:48 +0000
Message-ID: <6ec50b46-ab20-4115-8edd-c5c2884fd345@amlogic.com>
Date: Wed, 8 May 2024 16:06:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/5] clk: meson: c3: add support for the C3 SoC PLL
 clock
Content-Language: en-US
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Chuan Liu <chuan.liu@amlogic.com>
References: <20240430064438.2094701-1-xianwei.zhao@amlogic.com>
 <20240430064438.2094701-5-xianwei.zhao@amlogic.com>
 <1jzft72ddi.fsf@starbuckisacylon.baylibre.com>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <1jzft72ddi.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::16) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SEZPR03MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: b068c6ca-817c-4757-f762-08dc6f35cf76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmRHQVUrcjJYQjQ1Yzk0VHdiWTdxUmEzTnpmTitzZU04N0NPaG04SlVFWDFV?=
 =?utf-8?B?L1h1S2NWL2ZQampmeW90ME51ZFA5eHl1WC9qOC9CbTdxZE8vQTgvOUVWcDRO?=
 =?utf-8?B?SlVadzlJa3k3dlEvSVJjNnJZbE1lUVZOam1TUFl6YTNhMjYzRnVqZ0d5Rlhy?=
 =?utf-8?B?akVVbUVqdzYvUU1uUE5MWkVIa0U1aVlrRSszNmk3b0lCcWQyYWZCR21EWkdl?=
 =?utf-8?B?Z2JBWi9lZU9KbytXMGM5WEFBcGkwNGxsdHNPM3c5akpKOGhmdzNWdXQzOEEv?=
 =?utf-8?B?TjRKV1h5WlhNQjV2ckVlWUhXNVBjU042ZTZxb0s1bkdxazVrWVJBRUlhOGZk?=
 =?utf-8?B?NnM2Kzh6SXBrVmxpUmRpcEgrR3A5NzZmVVVBdkZuS211eXZ6aVVUSjRRZ2dK?=
 =?utf-8?B?UE52QjVyVUxlWG5PcEFEak05TytGenY3UmNqZmlCN3FjZEJNYTkwK0pYazBM?=
 =?utf-8?B?b3lkZE5EelhON1hKQnlaSWJZRVJ0R2V5VlRHUDVQWmpVVndNRGJZbFl4RGJM?=
 =?utf-8?B?a1lVdVF0ODN2UHlkMEtYQVFyVHVsSGpnNXJobzdVbDljMGhnT3FkVVFmdm5i?=
 =?utf-8?B?aWVOUjFla3hud1pHbFRvWkgwSzh0VDdTUmZheGhwNXFtUVlyYlB1TzhHTjdn?=
 =?utf-8?B?NlMzaGo5K29JVnVtdDFicVNEd0pZN0p3cEVMdkJhZEQ0UUFLMVFNd2psd25v?=
 =?utf-8?B?TldOeUFsQ3hmS3YrSDdvRFdWaW5GMFg3OURFS1IyU2EwN3NBcklOakdQUjBU?=
 =?utf-8?B?VlY4WUUxTHdmdkFuVDJiS0V2Z3p5ZTBrVWxyaWVCdk1oTTZROHlySGc5WnhP?=
 =?utf-8?B?dDJDbG1DR0FUUGxrNUVybThOUHMvMWlvUmJ4TThOaitOQWwraDkzdHorbkVF?=
 =?utf-8?B?K3FNaSsyaVAwT084WWRTN3FTQnFsS0JPRUdCVHlWNzl3eGpEOUhEdVdTcy9E?=
 =?utf-8?B?ait6RlJqeWZHZ0c2TDFFanREcU1VSDFqUDVDQ2VkeFZKQ0ZLOEtxN2JVOU9Y?=
 =?utf-8?B?OTdoL0dpU1hXNDQ2cFJsNDNtVE1KV3ZZV25tUlltTFlsM0ZjSGNHWktzTVVv?=
 =?utf-8?B?M0xLUXRrZnAyT3dwWFNPTGFqVUd3dkFPcTdUcFpQQU9BaTlraUhOd2xUNW5X?=
 =?utf-8?B?WGRseVkzaTJxYkZUR1hDRUoxNlJSVCtKTklhVUljZHR6dzBiZklVUGxKYkw4?=
 =?utf-8?B?MEwvK1ZFZzRGWUNnUDNQMng2UXRxd0dnQjFHSC80bjJtNkc5TkUvdUw1L3lX?=
 =?utf-8?B?aUdMYTM5SU14blRkb0t0MSt2Skc0SjhGcjRkV1dISlU2eWFtWGRPU0UxSzRp?=
 =?utf-8?B?WStqTDdIeXJGNGJnZFJ3Y1JqbFFERmRWb21NT2NheXEyZkJhd0RlMDFxMDA2?=
 =?utf-8?B?d0NjVXhoUWx6eldPQ1dKZXYvTGtVVzBRdGlubnp5V25sV1hBQnpTOXF5TFNZ?=
 =?utf-8?B?SkxTOHdPTitGMmgxL2Z2QS9sd2gvLzFZdEJtaFdSWTAzUHNFZ3QvZ3phYnZJ?=
 =?utf-8?B?YlZsZGlndzNVWTNmSUVLU0c3cmt3NGNWbTIxSHN3OCtaeU1MYzhOQ0NKa3NX?=
 =?utf-8?B?ODRHREkzdWVQVzhHRWZxNy9BazNQNWU5QnZTNGVLaHRZelI4alBSZHltbHMw?=
 =?utf-8?B?VnltTDhSbkZWU0pzT0Qrc21FQTlIbDZpMmZDb1BuTi96cnBOQzc4b1grRzhZ?=
 =?utf-8?B?S3lCN2h2b3JKaDNjN253ZVBlQWpLNE5jbGZqbmxlYUI4RGExZ3p3VVRBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHhwNzVWRGJwam9vdEF3QURxSk4yS3B2Q3dKYzFlSk9LTktNL2pudWZJMFZV?=
 =?utf-8?B?NkIxaktJVTdab2JVcjQ4enJYclZlV0h1YmNXN3p4RjgxT3JBWnpTK2tTM2hv?=
 =?utf-8?B?dUkzd0oxRXhjbkFQTjZVQTBvTnZobGxZVVVaWEIrbVEyZENQM05Gc1QyRTNi?=
 =?utf-8?B?cVlCTERtdlVaRVdFc1l1ZWVtSVJFcit6RTR5NWN0V0c2cHA4UmxJc3Zxbm5X?=
 =?utf-8?B?UmdRZHlVUzJ3MVRTWFM3VWJaN1ZFRDNSUEdVZzJ0R2xZUnBBOHdTMUNyQ1JZ?=
 =?utf-8?B?WGxtSnVxbEYxTlF5OHRlQ1ZQbWVXdjhNV0ROUE8rem9aaWgzZWN0NjAyNFJn?=
 =?utf-8?B?R0tJS1JKMG1sNTBZR3U5NFlHMnBaTDBpWW5GS0RvWTNRWGlYZitBZk13RTBv?=
 =?utf-8?B?MEJJN1BvQnFObDl4Z3hBOXc4L2ozTXZWeVhla2VQZUFGSGpaYnptckE0OXVv?=
 =?utf-8?B?N3JtYW0zMVErbUY1eC9ZYVdHMzUrcGNaMHlzVjZ5MGJqaU1RSUpzRVg3WEJ0?=
 =?utf-8?B?NU4zUjZncDhsak1EUmovWkpsRGc3RzB0TEEzNFcvMXBXR3FEZjlmNWM4d0xP?=
 =?utf-8?B?ekxqcUpFeUFYZ2c3Qm1GUEZ4bkFTWFpBbXk0T3A2Y2lSci9Sd0RTS3BmaURo?=
 =?utf-8?B?OEVtZlRuUVQ3cy8xNHI0OEdodUJsSGs1UWZqZDRmTjNHai9SRFltSVZnZzhZ?=
 =?utf-8?B?d0oxUXV6VnNmSlIzOGFsNXdHK1ZyUUpOWC9iWkxQMjYvSDlTcjI1ZWlXVWY3?=
 =?utf-8?B?RzRGRlIyVjNNQlB1VWFYL1hXNGtKUlpTUW5DeWpXdzhLRzBYR29aR2FFaE5C?=
 =?utf-8?B?ZVJsRkRWdmF2c0xocDZtQTNySGhVSXVFN2dZMVZOS0pyZmdqZ1ZSSUxJTHE4?=
 =?utf-8?B?Y1h0TzAxYVViNldpd1NsdlhYL1N2bTNnbWEvN2tkbkI4WG1EbmZmTzdqN3lq?=
 =?utf-8?B?SFFSYVFQS3p4OUVJQjdRZU9aRFFaRi9paTlJeGpXRkZTRFVhTDVGOU1BSVQz?=
 =?utf-8?B?djlDOUNVb2FKb3BtZ3BSUzVFOTdadkJlUnhnVk50ZkJDTXltenNkRDB4S21h?=
 =?utf-8?B?NXZyUEZGVzdPY3dNU1VUeERVanNrZDR1TFAwN0s4OEc0b21Lcnc5TllqOTUw?=
 =?utf-8?B?TEM4U3BxNnQ3aEc4UlBnTzJsWE1iTmpzQXpJUTJqNzNZYStrTkRHWDZIUUFV?=
 =?utf-8?B?K2JxWG80MTYrSmFlSEQ0T2FoTGI5djlmeVBpdnpsb0E1UW9QQ2R4TkJWYnJu?=
 =?utf-8?B?WExPOXFiMWQzc1hyZmtmdlJOZEtsZEhyWm9XL2xXVFg4RFdwbDIwRHhFbXYr?=
 =?utf-8?B?SlFvZG1ObEdkRTZjNi9KaU5ZNTJudTdOZ1FXaFRiQXorNkVnT2VjUCswUGNE?=
 =?utf-8?B?NXBmRjlTMWZsbzFqSnVDNisyQnN0R083UWd0QmV6VkZsVGczWFBuUCtPMWk4?=
 =?utf-8?B?YVFpdldZQ2xweXdCWk9QNW10TzgwVitOL25CeUNIeE5vbkw5SklMTXowM2dU?=
 =?utf-8?B?YlZyV0RqdDF1UDU3aW1neHhadWdjb0VsVzVwcE9yRm9ZL0F2RVF6VlJlUDZB?=
 =?utf-8?B?NC95TE4vWjZ4N1JDWnJVUHdMaFRFVmtTQktqTWdRZUF3M3FvaHU2ZnQvM2k3?=
 =?utf-8?B?QXQ1Z1BnWFpySmpvS2FpaHUzQnF6QXN6WEo5b1oxbjl4OTBJS1JEU2pPbGVm?=
 =?utf-8?B?bks4SjhxK3RyS2hqdXNlV3I4TUFlRTN3VVFnNGRSTDZraXNWVW5IZWJieXVK?=
 =?utf-8?B?WHJTY3FQWWVPM1Y3UlJ3OU1PM2UySzJkM1ZJRVZpREFmNEdHODFqOStOUE5N?=
 =?utf-8?B?cGliMzdmS3d4eDNtT2dEQzEzallNRkdPK0FhKzNIbWpiL1k3V3BVRFlTd252?=
 =?utf-8?B?Umk0ZDBJZnBscXU4M1RYR1B1SDJ2YXdzRDVScWlZd3ovUlp6a3QvZndONU50?=
 =?utf-8?B?VmNYS3RTN0E5ZDl1V0xKb0o2YXlGWWRXSUc3WE8reGRCQVJ1ODZjZ1FNRWF1?=
 =?utf-8?B?Q21aLzBrc0diSlJXWmh3K0ZDSFhZTm9mVlJuaXoyMWlyNSthd25RdXVtQ04r?=
 =?utf-8?B?L3dENlVoK0IyTk1KNnBuajNUTzdmb3JpOXRWT2RoNExMa1hWdmRGM3ZNVU1w?=
 =?utf-8?B?M1hQWWxORGJnS0FiMXQ1WW03a2V0bVk4NFcwSGYxQTFadTNOTUUrOGt0ends?=
 =?utf-8?B?VHc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b068c6ca-817c-4757-f762-08dc6f35cf76
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 08:06:48.6694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2jh8Ql6IrHsrE33gXTRNIXYhdMIzQapBhfUWuixhpRBtaFT1BBPFq3sseWT0ZAB/bGbjVZQ2kYL6d+qHkkDyuDscr25xmF8beCAuki0RVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7007

Hi Jerome,
    Thanks for your reply.

On 2024/5/3 22:11, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> On Tue 30 Apr 2024 at 14:44, Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:
> 
>> Add the C3 PLL clock controller driver for the Amlogic C3 SoC family.
>>
>> Co-developed-by: Chuan Liu <chuan.liu@amlogic.com>
>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   drivers/clk/meson/Kconfig  |  14 +
>>   drivers/clk/meson/Makefile |   1 +
>>   drivers/clk/meson/c3-pll.c | 746 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 761 insertions(+)
>>   create mode 100644 drivers/clk/meson/c3-pll.c
>>
>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>> index 29ffd14d267b..9f975a980581 100644
>> --- a/drivers/clk/meson/Kconfig
>> +++ b/drivers/clk/meson/Kconfig
>> @@ -128,6 +128,20 @@ config COMMON_CLK_A1_PERIPHERALS
>>          device, A1 SoC Family. Say Y if you want A1 Peripherals clock
>>          controller to work.
>>
>> +config COMMON_CLK_C3_PLL
>> +     tristate "Amlogic C3 PLL clock controller"
>> +     depends on ARM64
>> +     depends on ARM_SCMI_PROTOCOL
> 
> There was a comment from Rob on v7 that was not addressed.
> Please make sure you address all comments before reposting.
> 
Will detete it.

>> +     depends on COMMON_CLK_SCMI
> 
> imply, not depend.
Will fix it  "imply COMMON_CLK_SCMI"
> 
>> +     default y
>> +     select COMMON_CLK_MESON_REGMAP
>> +     select COMMON_CLK_MESON_PLL
>> +     select COMMON_CLK_MESON_CLKC_UTILS
>> +     help
>> +       Support for the PLL clock controller on Amlogic C302X and C308L devices,
>> +       AKA C3. Say Y if you want the board to work, because PLLs are the parent
>> +       of most peripherals.
>> +
>>   config COMMON_CLK_G12A
>>        tristate "G12 and SM1 SoC clock controllers support"
>>        depends on ARM64
>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>> index 9ee4b954c896..4420af628b31 100644
>> --- a/drivers/clk/meson/Makefile
>> +++ b/drivers/clk/meson/Makefile
>> @@ -19,6 +19,7 @@ obj-$(CONFIG_COMMON_CLK_AXG) += axg.o axg-aoclk.o
>>   obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
>>   obj-$(CONFIG_COMMON_CLK_A1_PLL) += a1-pll.o
>>   obj-$(CONFIG_COMMON_CLK_A1_PERIPHERALS) += a1-peripherals.o
>> +obj-$(CONFIG_COMMON_CLK_C3_PLL) += c3-pll.o
>>   obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>>   obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
>>   obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o meson8-ddr.o
>> diff --git a/drivers/clk/meson/c3-pll.c b/drivers/clk/meson/c3-pll.c
>> new file mode 100644
>> index 000000000000..74e11add165c
>> --- /dev/null
>> +++ b/drivers/clk/meson/c3-pll.c
>> @@ -0,0 +1,746 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Amlogic C3 PLL Controller Driver
>> + *
>> + * Copyright (c) 2023 Amlogic, inc.
>> + * Author: Chuan Liu <chuan.liu@amlogic.com>
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/platform_device.h>
>> +#include "clk-regmap.h"
>> +#include "clk-pll.h"
>> +#include "meson-clkc-utils.h"
>> +#include <dt-bindings/clock/amlogic,c3-pll-clkc.h>
>> +
>> +#define ANACTRL_FIXPLL_CTRL4                 0x50
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
>> +
>> +static struct clk_regmap fclk_50m_en = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = ANACTRL_FIXPLL_CTRL4,
>> +             .bit_idx = 0,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "fclk_50m_en",
>> +             .ops = &clk_regmap_gate_ro_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "fix"
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor fclk_50m = {
>> +     .mult = 1,
>> +     .div = 40,
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "fclk_50m",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &fclk_50m_en.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor fclk_div2_div = {
>> +     .mult = 1,
>> +     .div = 2,
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "fclk_div2_div",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "fix"
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap fclk_div2 = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = ANACTRL_FIXPLL_CTRL4,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "fclk_div2",
>> +             .ops = &clk_regmap_gate_ro_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &fclk_div2_div.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor fclk_div2p5_div = {
>> +     .mult = 2,
>> +     .div = 5,
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "fclk_div2p5_div",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "fix"
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap fclk_div2p5 = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = ANACTRL_FIXPLL_CTRL4,
>> +             .bit_idx = 4,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "fclk_div2p5",
>> +             .ops = &clk_regmap_gate_ro_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &fclk_div2p5_div.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor fclk_div3_div = {
>> +     .mult = 1,
>> +     .div = 3,
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "fclk_div3_div",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "fix"
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap fclk_div3 = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = ANACTRL_FIXPLL_CTRL4,
>> +             .bit_idx = 20,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "fclk_div3",
>> +             .ops = &clk_regmap_gate_ro_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &fclk_div3_div.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor fclk_div4_div = {
>> +     .mult = 1,
>> +     .div = 4,
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "fclk_div4_div",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "fix"
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap fclk_div4 = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = ANACTRL_FIXPLL_CTRL4,
>> +             .bit_idx = 21,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "fclk_div4",
>> +             .ops = &clk_regmap_gate_ro_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &fclk_div4_div.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor fclk_div5_div = {
>> +     .mult = 1,
>> +     .div = 5,
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "fclk_div5_div",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "fix"
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap fclk_div5 = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = ANACTRL_FIXPLL_CTRL4,
>> +             .bit_idx = 22,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "fclk_div5",
>> +             .ops = &clk_regmap_gate_ro_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &fclk_div5_div.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor fclk_div7_div = {
>> +     .mult = 1,
>> +     .div = 7,
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "fclk_div7_div",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "fix"
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap fclk_div7 = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = ANACTRL_FIXPLL_CTRL4,
>> +             .bit_idx = 23,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "fclk_div7",
>> +             .ops = &clk_regmap_gate_ro_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &fclk_div7_div.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static const struct reg_sequence c3_gp0_init_regs[] = {
>> +     { .reg = ANACTRL_GP0PLL_CTRL2,  .def = 0x0 },
>> +     { .reg = ANACTRL_GP0PLL_CTRL3,  .def = 0x48681c00 },
>> +     { .reg = ANACTRL_GP0PLL_CTRL4,  .def = 0x88770290 },
>> +     { .reg = ANACTRL_GP0PLL_CTRL5,  .def = 0x3927200a },
>> +     { .reg = ANACTRL_GP0PLL_CTRL6,  .def = 0x56540000 },
>> +};
>> +
>> +static const struct pll_mult_range c3_gp0_pll_mult_range = {
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
>> +                     .width   = 9,
>> +             },
>> +             .frac = {
>> +                     .reg_off = ANACTRL_GP0PLL_CTRL1,
>> +                     .shift   = 0,
>> +                     .width   = 19,
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
>> +             .range = &c3_gp0_pll_mult_range,
>> +             .init_regs = c3_gp0_init_regs,
>> +             .init_count = ARRAY_SIZE(c3_gp0_init_regs),
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "gp0_pll_dco",
>> +             .ops = &meson_clk_pll_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "top",
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +/* The maximum frequency divider supports is 32, not 128(2^7) */
>> +static const struct clk_div_table c3_gp0_pll_od_table[] = {
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
>> +             .table = c3_gp0_pll_od_table,
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
>> +static const struct reg_sequence c3_hifi_init_regs[] = {
>> +     { .reg = ANACTRL_HIFIPLL_CTRL2, .def = 0x0 },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL3, .def = 0x6a285c00 },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL4, .def = 0x65771290 },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL5, .def = 0x3927200a },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL6, .def = 0x56540000 },
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
>> +                     .width   = 19,
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
>> +             .range = &c3_gp0_pll_mult_range,
>> +             .init_regs = c3_hifi_init_regs,
>> +             .init_count = ARRAY_SIZE(c3_hifi_init_regs),
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hifi_pll_dco",
>> +             .ops = &meson_clk_pll_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "top",
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap hifi_pll = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = ANACTRL_HIFIPLL_CTRL0,
>> +             .shift = 16,
>> +             .width = 2,
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
>> +static const struct reg_sequence c3_mclk_init_regs[] = {
>> +     { .reg = ANACTRL_MPLL_CTRL1,    .def = 0x1420500f },
>> +     { .reg = ANACTRL_MPLL_CTRL2,    .def = 0x00023041 },
>> +     { .reg = ANACTRL_MPLL_CTRL3,    .def = 0x18180000 },
>> +     { .reg = ANACTRL_MPLL_CTRL2,    .def = 0x00023001 }
>> +};
>> +
>> +static const struct pll_mult_range c3_mclk_pll_mult_range = {
>> +     .min = 67,
>> +     .max = 133,
>> +};
>> +
>> +static struct clk_regmap mclk_pll_dco = {
>> +     .data = &(struct meson_clk_pll_data) {
>> +             .en = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL0,
>> +                     .shift   = 28,
>> +                     .width   = 1,
>> +             },
>> +             .m = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL0,
>> +                     .shift   = 0,
>> +                     .width   = 8,
>> +             },
>> +             .n = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL0,
>> +                     .shift   = 16,
>> +                     .width   = 5,
>> +             },
>> +             .l = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL0,
>> +                     .shift   = 31,
>> +                     .width   = 1,
>> +             },
>> +             .rst = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL0,
>> +                     .shift   = 29,
>> +                     .width   = 1,
>> +             },
>> +             .range = &c3_mclk_pll_mult_range,
>> +             .init_regs = c3_mclk_init_regs,
>> +             .init_count = ARRAY_SIZE(c3_mclk_init_regs),
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "mclk_pll_dco",
>> +             .ops = &meson_clk_pll_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "mclk",
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static const struct clk_div_table c3_mpll_od_table[] = {
>> +     { 0,  1 },
>> +     { 1,  2 },
>> +     { 2,  4 },
>> +     { 3,  8 },
>> +     { 4, 16 },
>> +     { /* sentinel */ }
>> +};
>> +
>> +static struct clk_regmap mclk_pll_od = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = ANACTRL_MPLL_CTRL0,
>> +             .shift = 12,
>> +             .width = 3,
>> +             .table = c3_mpll_od_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "mclk_pll_od",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &mclk_pll_dco.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/* both value 0 and 1 gives divide the input rate by one */
>> +static struct clk_regmap mclk_pll = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = ANACTRL_MPLL_CTRL4,
>> +             .shift = 16,
>> +             .width = 5,
>> +             .flags = CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "mclk_pll",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &mclk_pll_od.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data mclk_parent[] = {
>> +     { .hw = &mclk_pll.hw },
>> +     { .fw_name = "mclk" },
>> +     { .hw = &fclk_50m.hw }
>> +};
>> +
>> +static struct clk_regmap mclk0_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = ANACTRL_MPLL_CTRL4,
>> +             .mask = 0x3,
>> +             .shift = 4,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "mclk0_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = mclk_parent,
>> +             .num_parents = ARRAY_SIZE(mclk_parent),
>> +     },
>> +};
>> +
>> +static struct clk_regmap mclk0_div_en = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = ANACTRL_MPLL_CTRL4,
>> +             .bit_idx = 1,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "mclk0_div_en",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &mclk0_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap mclk0_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = ANACTRL_MPLL_CTRL4,
>> +             .shift = 2,
>> +             .width = 1,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "mclk0_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &mclk0_div_en.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap mclk0 = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = ANACTRL_MPLL_CTRL4,
>> +             .bit_idx = 0,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "mclk0",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &mclk0_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap mclk1_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = ANACTRL_MPLL_CTRL4,
>> +             .mask = 0x3,
>> +             .shift = 12,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "mclk1_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = mclk_parent,
>> +             .num_parents = ARRAY_SIZE(mclk_parent),
>> +     },
>> +};
>> +
>> +static struct clk_regmap mclk1_div_en = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = ANACTRL_MPLL_CTRL4,
>> +             .bit_idx = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "mclk1_div_en",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &mclk1_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap mclk1_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = ANACTRL_MPLL_CTRL4,
>> +             .shift = 10,
>> +             .width = 1,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "mclk1_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &mclk1_div_en.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap mclk1 = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = ANACTRL_MPLL_CTRL4,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "mclk1",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &mclk1_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_hw *c3_pll_hw_clks[] = {
>> +     [CLKID_FCLK_50M_EN]     = &fclk_50m_en.hw,
>> +     [CLKID_FCLK_50M]        = &fclk_50m.hw,
>> +     [CLKID_FCLK_DIV2_DIV]   = &fclk_div2_div.hw,
>> +     [CLKID_FCLK_DIV2]       = &fclk_div2.hw,
>> +     [CLKID_FCLK_DIV2P5_DIV] = &fclk_div2p5_div.hw,
>> +     [CLKID_FCLK_DIV2P5]     = &fclk_div2p5.hw,
>> +     [CLKID_FCLK_DIV3_DIV]   = &fclk_div3_div.hw,
>> +     [CLKID_FCLK_DIV3]       = &fclk_div3.hw,
>> +     [CLKID_FCLK_DIV4_DIV]   = &fclk_div4_div.hw,
>> +     [CLKID_FCLK_DIV4]       = &fclk_div4.hw,
>> +     [CLKID_FCLK_DIV5_DIV]   = &fclk_div5_div.hw,
>> +     [CLKID_FCLK_DIV5]       = &fclk_div5.hw,
>> +     [CLKID_FCLK_DIV7_DIV]   = &fclk_div7_div.hw,
>> +     [CLKID_FCLK_DIV7]       = &fclk_div7.hw,
>> +     [CLKID_GP0_PLL_DCO]     = &gp0_pll_dco.hw,
>> +     [CLKID_GP0_PLL]         = &gp0_pll.hw,
>> +     [CLKID_HIFI_PLL_DCO]    = &hifi_pll_dco.hw,
>> +     [CLKID_HIFI_PLL]        = &hifi_pll.hw,
>> +     [CLKID_MCLK_PLL_DCO]    = &mclk_pll_dco.hw,
>> +     [CLKID_MCLK_PLL_OD]     = &mclk_pll_od.hw,
>> +     [CLKID_MCLK_PLL]        = &mclk_pll.hw,
>> +     [CLKID_MCLK0_SEL]       = &mclk0_sel.hw,
>> +     [CLKID_MCLK0_SEL_EN]    = &mclk0_div_en.hw,
>> +     [CLKID_MCLK0_DIV]       = &mclk0_div.hw,
>> +     [CLKID_MCLK0]           = &mclk0.hw,
>> +     [CLKID_MCLK1_SEL]       = &mclk1_sel.hw,
>> +     [CLKID_MCLK1_SEL_EN]    = &mclk1_div_en.hw,
>> +     [CLKID_MCLK1_DIV]       = &mclk1_div.hw,
>> +     [CLKID_MCLK1]           = &mclk1.hw
>> +};
>> +
>> +/* Convenience table to populate regmap in .probe */
>> +static struct clk_regmap *const c3_pll_clk_regmaps[] = {
>> +     &fclk_50m_en,
>> +     &fclk_div2,
>> +     &fclk_div2p5,
>> +     &fclk_div3,
>> +     &fclk_div4,
>> +     &fclk_div5,
>> +     &fclk_div7,
>> +     &gp0_pll_dco,
>> +     &gp0_pll,
>> +     &hifi_pll_dco,
>> +     &hifi_pll,
>> +     &mclk_pll_dco,
>> +     &mclk_pll_od,
>> +     &mclk_pll,
>> +     &mclk0_sel,
>> +     &mclk0_div_en,
>> +     &mclk0_div,
>> +     &mclk0,
>> +     &mclk1_sel,
>> +     &mclk1_div_en,
>> +     &mclk1_div,
>> +     &mclk1,
>> +};
>> +
>> +static struct regmap_config clkc_regmap_config = {
>> +     .reg_bits       = 32,
>> +     .val_bits       = 32,
>> +     .reg_stride     = 4,
>> +     .max_register   = ANACTRL_MPLL_CTRL4,
>> +};
>> +
>> +static struct meson_clk_hw_data c3_pll_clks = {
>> +     .hws = c3_pll_hw_clks,
>> +     .num = ARRAY_SIZE(c3_pll_hw_clks),
>> +};
>> +
>> +static int aml_c3_pll_probe(struct platform_device *pdev)
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
>> +     for (i = 0; i < ARRAY_SIZE(c3_pll_clk_regmaps); i++)
>> +             c3_pll_clk_regmaps[i]->map = regmap;
>> +
>> +     for (clkid = 0; clkid < c3_pll_clks.num; clkid++) {
>> +             /* array might be sparse */
>> +             if (!c3_pll_clks.hws[clkid])
>> +                     continue;
>> +
>> +             ret = devm_clk_hw_register(dev, c3_pll_clks.hws[clkid]);
>> +             if (ret) {
>> +                     dev_err(dev, "Clock registration failed\n");
>> +                     return ret;
>> +             }
>> +     }
>> +
>> +     return devm_of_clk_add_hw_provider(dev, meson_clk_hw_get,
>> +                                        &c3_pll_clks);
>> +}
>> +
>> +static const struct of_device_id c3_pll_clkc_match_table[] = {
>> +     {
>> +             .compatible = "amlogic,c3-pll-clkc",
>> +     },
>> +     {}
>> +};
>> +MODULE_DEVICE_TABLE(of, c3_pll_clkc_match_table);
>> +
>> +static struct platform_driver c3_pll_driver = {
>> +     .probe          = aml_c3_pll_probe,
>> +     .driver         = {
>> +             .name   = "c3-pll-clkc",
>> +             .of_match_table = c3_pll_clkc_match_table,
>> +     },
>> +};
>> +
>> +module_platform_driver(c3_pll_driver);
>> +MODULE_AUTHOR("Chuan Liu <chuan.liu@amlogic.com>");
>> +MODULE_LICENSE("GPL");
> 
> 
> --
> Jerome

