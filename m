Return-Path: <linux-kernel+bounces-405548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 024AC9C52C4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C402839BD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EA22123EE;
	Tue, 12 Nov 2024 10:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="OmWAJm/i"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2119.outbound.protection.outlook.com [40.107.255.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935812101AF;
	Tue, 12 Nov 2024 10:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731406008; cv=fail; b=OOOyyUFbOgiyxLKjaF8uSq1B4MIrVJHEDRhjY9CPZzd4QV23o4f9tPPyUpzmvnLR8UypNqZSJiKNJMPWYqSt0XessaHD0cbgFsoJ12Q3AeSFexpq+8Tnp1ZrOpRHmqhWhigTuNGepV6gwDewEiOfD/aV4+SZEePEdhO3LeSDmDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731406008; c=relaxed/simple;
	bh=xIPCWtbROZERStWbY1B7faFG+QJDJe975PCmQUZowx4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fzt4cmFgZy6tZmRnq8n3jvcB3C7n0ZCpRUAy6ci6g9y4CFi+q3Z1RJw0w7UHx6GRwZB0w+uj2aAZwwEiGH0fSYnBtuZuNH0iKzVCVenIck1R1sidd2VTM5oNlNC44TTOIkgufn6bHpQIdWbriAGBTwZ5HxKsVwziR5BMqD51wOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=OmWAJm/i; arc=fail smtp.client-ip=40.107.255.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EN8noqVtqRz2Am9asJco8QKcHHHKVPnN3SZ4yHx6AyF0itGGWiNqnZK52citPWgOVHbjQY7ztzc/3i4S1OwHzo2M9lQFyEtX5uXtQs9P7CTcKIfJIjvHGU1d91ditb/ZNq62eMaUQEUOscGIcevDagBAW4jSOCCWJC7iXQHsRMHCkr+9P4WllEI2z/ttRUZ5OowPH0WKT375/JOJRuoHhJF4EC8tUa7Mx2SIDRacHo7YWFzGESNkhtUUNFrb7QJBFt9Pm3X3D9zJn0CRE2WqG/swTiudviJ/YmTSyeayK5EQI/rTww9xzV099WA/XbR1eEKVspKXQVcwIZCiJKXONw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElOw7rmGWaS5t8u48irYFRYWBGV9o3J3e6tEOyR9Xdk=;
 b=tvrSBw9gL9pVvpZNjL4efOgbQ1lW3T0lPXpytl8myY+Ld6KNYindHXnccZpoRCpgF5MLILHW264ZL9ze/TApLafj/Y0zV3HZdiJ4nuPB6n/kn85mhGto4CrXTG07egh0o0aLoJmAxKMyT13gcb+JZofqy4WoWnUu2pNcK89fElf09XOsiBF6rRLEr8SxIPrO/XBw8rWPjkT6oS29w8/tc1XU3bf/OZOvGJTk7JBqDXo8PE6qBuI40a27aXWLCRJKQhKWlUJZq1hnRQ7NP7UTaC3ghW6h4su+c8GeIbGt1FqB/zUBzW9jYfokBh9sWY8pTIYu+LQOmQx1/hapMqHNvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElOw7rmGWaS5t8u48irYFRYWBGV9o3J3e6tEOyR9Xdk=;
 b=OmWAJm/iXEPSeFkWhEYsjDE/ONbZpj1jgIenbUeJd7jPUimiu7RBGwwMCvSs+zNCKpYCd/1pZuVAghGN2JmTAOU971/HojzscwQ1mBo+AxF8K2H2eQun/gQPPyj5CgtraFIJT0/IFCXlmjCPUO4PbzWIAWZ7h8MPezGneTfYRMtKF2snzKmz3IXxHg0ilj2i8DEz64p2op44kPWtPe9J2qHiR01STYEEE1lSHELzbdoN20SSlgCZgErDZTZATwXMFWtmu7kt2qZxdiLkoH41uuYObYi3k15zGY2UvMvrdA6J8DG242gmgDidkZXccfgPCBvyyQBgqYozKLmQGpho1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SI2PR03MB5786.apcprd03.prod.outlook.com (2603:1096:4:150::10)
 by SEYPR03MB7892.apcprd03.prod.outlook.com (2603:1096:101:166::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.25; Tue, 12 Nov
 2024 10:06:38 +0000
Received: from SI2PR03MB5786.apcprd03.prod.outlook.com
 ([fe80::3f37:cacc:420b:9b86]) by SI2PR03MB5786.apcprd03.prod.outlook.com
 ([fe80::3f37:cacc:420b:9b86%3]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 10:06:38 +0000
Message-ID: <f8c3b6e7-2f5d-493e-8254-2a27623f0d2e@amlogic.com>
Date: Tue, 12 Nov 2024 18:05:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] clk: core: refine disable unused clocks
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <1jcykltj7g.fsf@starbuckisacylon.baylibre.com>
 <20241004133953.494445-1-jbrunet@baylibre.com>
 <07594a59-c999-4592-84b8-4e163d3edba4@amlogic.com>
 <1jttci2k8k.fsf@starbuckisacylon.baylibre.com>
 <85aae140-5c9b-4ff9-a522-549009f62601@amlogic.com>
 <1jcyj62gi7.fsf@starbuckisacylon.baylibre.com>
 <5eb12197-330c-4f55-82f7-d13ea458ba43@amlogic.com>
 <1j4j4c3l2n.fsf@starbuckisacylon.baylibre.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <1j4j4c3l2n.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To SI2PR03MB5786.apcprd03.prod.outlook.com
 (2603:1096:4:150::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR03MB5786:EE_|SEYPR03MB7892:EE_
X-MS-Office365-Filtering-Correlation-Id: 66480c75-284c-4ca5-5189-08dd0301b267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjhwRGRqbjdXeXJvUDJlVEM2MjdVNVVoRStUVml6eVcybWJKWWdFWWZmaTdF?=
 =?utf-8?B?YzNxQXBUeFBsOXlXdGVUUkZQS2g2eDN5NWZoSkM1MXBkZERUaVhhNjY1M1hS?=
 =?utf-8?B?SVg0cE42OHVpQ1NDSjhEQXVkdHcxUWY5ZnFYdzdxMWhLM2hvSkVKT1FIUTNi?=
 =?utf-8?B?cklVL01xVm1jN0xCWWJJU2dsYzNxU0ZYeG4xYlowVzRzR2xOcmZoRndReXow?=
 =?utf-8?B?cEwvZjJ3ZHpuc1dJamRmb1RwMGJVWTYwOWQ5REd6RVhYN3ByVk9JSDYwcTVk?=
 =?utf-8?B?bWJ3YWUyYU9QdXVKZWY3ODJpRDBxZjlYVlI0U1J2M0lxeVpyVStGT3VDbEk2?=
 =?utf-8?B?QW9NK01Nd2lhbm5ZdnIvS1dFaUNqZjdDZGk5My9jZTVPZFZ3VmJSdXJMUU41?=
 =?utf-8?B?b3I2d2czNHpQeFFudmluQXZJSG8rMUw5ZXVNaDUzWEpNZmhIYnBKM1dhcllY?=
 =?utf-8?B?cTM4UnRyVGpubjkvV0dsZGV5SjlHQnRrZ0NQdDdhSGdoT3c3MVdITERXSXht?=
 =?utf-8?B?TFNuZTRiMUpMbmprY1pGd1lqalVIbWs1RUhHeXRrOTZsTFJTWFR6bWNrMGRs?=
 =?utf-8?B?ZXFiVDlVSEdJRStkRVAveStiaWZiczNUL1c2SW9HRllzcGVqKzJqaWdUMHFy?=
 =?utf-8?B?U1A5YmZDQVpxbEp3U092UkJjV2tRY251WENCd0F2ai94aWFndDRPVzZOL0pU?=
 =?utf-8?B?NFI3MlpaWXNNMUQvNm1qYW5XV2hqVGFxNnZmUXFiakdCVTR1eGlEbkszTk1i?=
 =?utf-8?B?U1hwQ05SZys2bVlPTlhaZW5XcFdOWnNQK010WU14bUJSZjBTOFhPa0pabUF3?=
 =?utf-8?B?bmJweHNOenhMMnY0V1Yvdld3ekx3TjFIRzArSVE5MVZHS2RnTkdhemt3aU83?=
 =?utf-8?B?UU9iZlIvM21pK0lBaVVkWUFxUGgzd1lqNFBEYm1aMGYzZnV6NFJHZHNVS3Q1?=
 =?utf-8?B?Nnc3TUk3cDN3YzZINGdkRmJ3cjNTRlBncWFLT0RoZ2hpdjc3QlRpL1ovZWRT?=
 =?utf-8?B?dVc3TXVUWUJVc3NFTTgrTHkrbHJVUTNwallJa1IwaWZoNSthWGhqZGxKTFg4?=
 =?utf-8?B?dVY3SGp4dGFWWGdIaGlNL3ZPZ0FYdnR0UnN3U0tERm5LMElKTVUvc3R5N0pX?=
 =?utf-8?B?S0J4VzFwS2pNQmdRL1pBb1oxcGRaekFyRmdTdTVlUU9GNkc5MjExQitRN09M?=
 =?utf-8?B?aWpad3pMK1ZPNDZlVzhNbTd5VTljWDd2Um5rcUxpR044VjVUc0dFOXBEQWFx?=
 =?utf-8?B?ZWNCVGQ3MXIwTERTUUJ1YkhXRkZxaHV5NzFURjA5djhuN2x6QnMreHg3aHBD?=
 =?utf-8?B?bHRjMEtMcFQwRVFSR2NFdUJoZHJncjdtQ29weTNmUllVU1ZsWGQ1UytoeVky?=
 =?utf-8?B?QzJaejRnbFZIWjJpSUtuRENNbksybEJNRzA1TmRHNEZFYUp4TzNYM1NRK3BJ?=
 =?utf-8?B?eWRIMDVSMkpJNjlqMEhPY1BSeDVLMWlHa0M0bEpUQ2VXMmJ2akwvb2xTLzFw?=
 =?utf-8?B?K0FnQzNlQ09FazNRellsNjBBdE1TMnhMZ0FOeTRKeDlTUGZHaGFvY0ROVW1h?=
 =?utf-8?B?UDJvblAxTUdYV2NJcjdsYUVpZWJTamJOYjVOcTBmM0lyWnZQZ3lycnJXV2dN?=
 =?utf-8?B?OHQ0cWgxU05RK3hXTmw2b3FUZ1ZzdFpaOXE3YTRZckxMYnp3Y0hBS0k5OVBs?=
 =?utf-8?B?K0UxdjZzendVSFBKSUkzaGdSbE4xaWNPR2Z5RWluUklCeVRuaGZYbEl5WGNU?=
 =?utf-8?Q?cciV+gvX4FOPcJjLchrv1ARMP4myCtjZtvG/dL2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5786.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmZ3OTZlMW5uSVFrNjF0eEdtdkZxakRWRmU1SEowcmp5ZkhJT2x3N05obXd4?=
 =?utf-8?B?YzlPLzdaYnB1UW1ybkhqUUpHbzJtWXIxUnNXZDZKR3A5N0Jham1LNXZpemVO?=
 =?utf-8?B?cnpsR053dzJYVlBFQW5SQVVSTnNCOGxURkpaYlcySURRRHJncEZ1cUpVVXY0?=
 =?utf-8?B?WXg1ZzcyQ294ZFdsM016ZENSbEh6T2ZRblArRk5WRytZVHBTNjVpaFpVNXk0?=
 =?utf-8?B?TDB1RzNBdVovTW03K3BabS8xY0tIRFhFcjJWWG9relp1K0d5OE5BZCtFaWVm?=
 =?utf-8?B?dUpydVlzdFBZVWtOb1IrbDdLeXFWNEpMV01JZG9GdHdqTlZJWG5xS1dRMEE0?=
 =?utf-8?B?bFc0U1c3aVczUzRrNk9DdXhZRmFEemw2NndLSTY1NXp6RTMzVWM0b0c2eVd4?=
 =?utf-8?B?L3pkMTFWMXBkSWowNUZxT2FncTU2d2Izd3Z4cnJYM1hucVpGN3N0UjBNM2li?=
 =?utf-8?B?T25jeWQrNkxDTmRTTUpSYUpxaVZpOG94RHdnVUdtYVp6WEo3V3N3YVBIOW44?=
 =?utf-8?B?RW83SWJ3aFRWa1lPUWQ3R2g4Z1pZWWFvbUkyR1VFajRtV0hHRXZlV2pIcnd3?=
 =?utf-8?B?T1VzbjhzdExnRVNlT3FKRWFnaTZ2NTc4emUwRDdOdHR4c1BYYUV1Q21rbEtu?=
 =?utf-8?B?SUFFODQ4aml1WGxDNVp1alpzL1N5UmJhUTZOWDdvMzBsSXViNkR5eGN2WnZK?=
 =?utf-8?B?UmFMQit1RUdwRzVaVlNYd094YTk5SzlmUGcvNDZUeDFRdWtLVHVXUVllMkdt?=
 =?utf-8?B?dk96UVdBMkx0RXZORVZ1Szl0TFFFakpWRlh2MlNpaXhHaDZGUC85Mk9sYzY4?=
 =?utf-8?B?UHRjNG82Tlk0WG1wbnNEd2ErS3lCN1NUZDZiSDJIenBxbUNEbmxLRytMYktq?=
 =?utf-8?B?WTRqL2x3YzFyQ1N0Uk5mZkJlNStTQWVFeVg1WmJRZmp0TDZtMUxwa2dpWVRV?=
 =?utf-8?B?ZHdLcFoza09ldVhvRUQ2MGVTUUUyd2twNllSUWtRdnRhQUZSRmwxcjdyODF1?=
 =?utf-8?B?V2NVVCt6aHowSnBqZkg1cG56SzkyRFNKZ0pqQ05RMXpHQnY0ZW5rNjN3V1Qx?=
 =?utf-8?B?NG02K0N2U3ZSY3U4cGNBK3M0VFJrL1NMVkM3Z05WcTJVZndhSmZFazlYL1gy?=
 =?utf-8?B?RXRkQ3FlRlJMM2w1SnBYWVdacG1saDlkQ1pVbGZwME5jbFZJNWd3bmFZalZ3?=
 =?utf-8?B?QlM5aldNa2YwamdFNFFVMWVxMklUKzNJakxWdVo2a01hWURhbEdjZWNhQ3Bw?=
 =?utf-8?B?TU92Vy82cU1mSzFJRll3Q1lNTTh0Zjl0KytHbXlKL3I3dmJva0VqdXlRSE9v?=
 =?utf-8?B?N0JaWStBNTFJTXpHbk9FVTUvN2t4MlV0S2ZPd3BJZ0NXRlYyczZJUG9xb0xU?=
 =?utf-8?B?YmE5TUw2NXlja3ZjUkoybjVseS9lK3NWSXVHbGpTb3F2aEp5eHQwUVFWRHdS?=
 =?utf-8?B?eEs0b2ZFZ1Z2UzE3eGRKUUpOOWlrRVpBZUF4WXRwZ3dnMFQrSlVpQVNuQ1Ix?=
 =?utf-8?B?bndVZ1g4YzRnOHpjU3ROMmUrRmx5d2xwQUc5eFJtRHRmaVllV0NtbUdnRURQ?=
 =?utf-8?B?bFVsNW1ybjg1RDFKMXdaTkR4eVcxQm0vdUpCZ25zb1QrdzlOOVNWcC80aWds?=
 =?utf-8?B?UFhZY2pxZnBNZnBkNlZoeUpFRVJyK2pZT1VkUDNzUWpCRmZob0N0UzV3R2FG?=
 =?utf-8?B?b1NLdUFFQ042S01PV25rSldrSlUvT1VjVGlia0EyMjE5dldENUVFT29kaEc0?=
 =?utf-8?B?SmZ0SUNMeElETE9CVUd4K1YxSmQ0NFpDeXpESzVoMldWTkh5ak1oaENjTU0v?=
 =?utf-8?B?ZTk5djhLUDRNb01jemR2K3NWTTRPTk1QaXBTcjRUMWlTV0pqdHhVNXBjUFl6?=
 =?utf-8?B?TVpGT0p6Q0ZyVGZFWnJxeEhvMnJkU0xrV1d3cEQ2U2xmdzBES3JGQTFxekVX?=
 =?utf-8?B?NkpjTDJwT211aTk3UmtpUXRpdms5ZjdycCsyM2w2Rm8rc2ExYjJhL3RDNmpy?=
 =?utf-8?B?amtrQ1U1N3Z2RENJRERXRjBFQi9iS1NzUjNhZzZWK3RFUGw4cjM3SGN5dFZQ?=
 =?utf-8?B?ZnZEL1MvSDlxWldOQWd0QS9KK1YzWUpHVzhZSnhJUXJ3alZaYmJGalkyRmFK?=
 =?utf-8?Q?K2n0angc3NXoDi7P+9iHBQM9L?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66480c75-284c-4ca5-5189-08dd0301b267
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5786.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 10:06:38.0999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iwXPwkSUxe7PQTjsdkP+jwNWs+E8nW7MMxQZz3Iu4FePoCYdoReAAjEHhxiTWQHFL4wLuMjClxIeHKxV2Cf7Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7892


On 11/12/2024 4:36 PM, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
>
> On Fri 08 Nov 2024 at 19:49, Chuan Liu <chuan.liu@amlogic.com> wrote:
>
>> On 11/8/2024 5:59 PM, Jerome Brunet wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> On Fri 08 Nov 2024 at 17:23, Chuan Liu <chuan.liu@amlogic.com> wrote:
>>>
>>>>>>> -       if (core->flags & CLK_IGNORE_UNUSED)
>>>>>>> +       /*
>>>>>>> +        * If the parent is disabled but the gate is open, we should sanitize
>>>>>>> +        * the situation. This will avoid an unexpected enable of the clock as
>>>>>>> +        * soon as the parent is enabled, without control of CCF.
>>>>>>> +        *
>>>>>>> +        * Doing so is not possible with a CLK_OPS_PARENT_ENABLE clock without
>>>>>>> +        * forcefully enabling a whole part of the subtree.  Just let the
>>>>>>> +        * situation resolve it self on the first enable of the clock
>>>>>>> +        */
>>>>>>> +       if (!parent_enabled && (core->flags & CLK_OPS_PARENT_ENABLE))
>>>> At first, I couldn't grasp the logic behind the 'return' here. Now it's
>>>> clear. This approach is equivalent to completely giving up on
>>>> handling clocks with CLK_OPS_PARENT_ENABLE feature in
>>>> clk_disable_unused_subtree().

Referring to the situation of 'clk_c' below, combined with your
previous explanation:

* Knowing the parent status allows to safely disable clocks with
   CLK_OPS_PARENT_ENABLE when the parent is enabled. Otherwise it means
   that, while the clock is not gated it is effectively disabled. Turning on
   the parents to sanitize the sitation would bring back our initial
   problem, so just let it sanitize itself when the clock gets used.

Do you mean 'clk_c' cases should be sanitized before clk_disable_unused()
(such as during driver probe(), etc.)? Dropped in clk_disable_unused_subtree()?
This is actually my biggest confusion.🙁

>>>>
>>> No. It's handled correctly as long as the tree is in coherent state.
>>>
>>> What is not done anymore is fixing up an inconsistent tree, by this I
>>> mean: A clock with CLK_OPS_PARENT_ENABLE, which report enabled from its
>>> own registers but has its parent disabled.
>>>
>>> In that particular case, clk_disable_unused_subtree() won't be turning on
>>> everything to properly disable that one clock. That is the root cause of
>>> the problem you reported initially. The clock is disabled anyway.
>>>
>>> Every other case are properly handled (at least I think).
>> name              en_sts            flags
>> clk_a                1          CLK_IGNORE_UNUSED
>>      clk_b            0                0
>>          clk_c        1         CLK_OPS_PARENT_ENABLE
>>
>> Based on the above case:
>> 1. When 'clk_c' is configured with CLK_OPS_PARENT_ENABLE, disabling
>> 'clk_c' requires enabling 'clk_b' first (disabling 'clk_c' before
>> disabling 'clk_b'). How can to ensure that during the period of
>> disabling 'clk_c', 'clk_b' remains enabled?
> That's perfect example of incoherent state.
> How can 'clk_c' be enabled if its parent is disable. That makes no
> sense, so there is no point enabling a whole subtree for this IMO.
>
>> 2. 'clk_c' is not configured with CLK_IGNORE_UNUSED, it should be
>> disabled later. However, here it goes to a 'goto' statement and then
>> return 'false', ultimately resulting in 'clk_c' not being disabled?
> We've discussed that 2 times already. This discussion is going in
> circles now.
>
>>>>>>>                     goto unlock_out;
>>>>>>>
>>>>>>>             /*
>>>>>>> @@ -1516,8 +1545,7 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
>>>>>>>
>>>>>>>      unlock_out:
>>>>>>>             clk_enable_unlock(flags);
>>>>>>> -       if (core->flags & CLK_OPS_PARENT_ENABLE)
>>>>>>> -               clk_core_disable_unprepare(core->parent);
>>>>>>> +       return (core->flags & CLK_IGNORE_UNUSED) && enabled;
>>>>>>>      }
>>>>>>>
>>>>>>>      static bool clk_ignore_unused __initdata;
>>>>>>> @@ -1550,16 +1578,16 @@ static int __init clk_disable_unused(void)
>>>>>>>             clk_prepare_lock();
>>>>>>>
>>>>>>>             hlist_for_each_entry(core, &clk_root_list, child_node)
>>>>>>> -               clk_disable_unused_subtree(core);
>>>>>>> +               clk_disable_unused_subtree(core, true);
>>>>>>>
>>>>>>>             hlist_for_each_entry(core, &clk_orphan_list, child_node)
>>>>>>> -               clk_disable_unused_subtree(core);
>>>>>>> +               clk_disable_unused_subtree(core, true);
>>>>>>>
>>>>>>>             hlist_for_each_entry(core, &clk_root_list, child_node)
>>>>>>> -               clk_unprepare_unused_subtree(core);
>>>>>>> +               clk_unprepare_unused_subtree(core, true);
>>>>>>>
>>>>>>>             hlist_for_each_entry(core, &clk_orphan_list, child_node)
>>>>>>> -               clk_unprepare_unused_subtree(core);
>>>>>>> +               clk_unprepare_unused_subtree(core, true);
>>>>>>>
>>>>>>>             clk_prepare_unlock();
>>>>>>>
>>>>>>> --
>>>>>>> 2.45.2
>>>>>>>
>>>>> --
>>>>> Jerome
>>> --
>>> Jerome
> --
> Jerome

