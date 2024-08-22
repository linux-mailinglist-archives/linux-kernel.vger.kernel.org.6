Return-Path: <linux-kernel+bounces-296600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D55295ACA5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D01F4B21332
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 04:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C934779D;
	Thu, 22 Aug 2024 04:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="HFzStYDu"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2065.outbound.protection.outlook.com [40.107.255.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA70320F;
	Thu, 22 Aug 2024 04:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724302010; cv=fail; b=Bmts+fwwHNu5yjC2KW8NBOqQsvnFrGjLIuFq2R692WRq7AzZHHFLDdsIihUpTYqiTlemsU6zC+3k58UHexl9tKAQgb8TxZveo/0bNfXiYRhULEZofVwAulNNqTlYhO8mqwgRqxABfBGADssPNVxaaH3T23sL2AxSlxISUlBA2uA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724302010; c=relaxed/simple;
	bh=RhBAqHcvREGN9Bhf/1mWBADUVNEPi9SPLfECvkOPXxs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qXiQ8xv/AQItl+Whxg4Bf3C8cXTdfzPCZB3JNXwSFZHhYDIc3iKj6cP8/r2mb+jFf5dOpVUNS8lFlFwvDCkmdZ1pepFdsJGZ5/qpiaYHU8YrWaSqWRQUGRw9jPq8+eCye1Hy8lnk9HjYKLamkMPaVCtQgpV5RRU3bEzna9q/9cU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=HFzStYDu; arc=fail smtp.client-ip=40.107.255.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8lZEMG0iTJghSRVtF4AXhUIMX+oSMFgFAdmjn7kxKswoILOOqFu2Ljaj8XBZvWO57udhR2lgmNrEoKYfoeJXsaDPWXQ2asAvwUknblGOxAZZtP9NTAtHUln6dlaAB6NB/8ivwQHZJYOaweytfHsvMs5GSsm+KPdMGUbIc1k4v7epNekZLdedHyMReTLWvdj3vWVEUKja1Eft39zHcGmL6tWUj91mdBLfDiqnr4QYv5BHdgK5BAYZ9DgV1I9UVUUc4OkCrSMjKnb30IIZrxfWuvl7xgdHxa7o+KKgIiskBLkTRKcXWmlA733vTo8GWy/OeCpcVqGcYm5tqy85wpl+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYrjcsVP3w3f1v0bdhgMC4Krw6WUqXDOfHB9RJgiDjI=;
 b=NGOrwzMsdL/K0AA4pf8ajRfBDbmAa5mRUgx1mxHJexFSXZokKDe97epJ+EX/kQ7JRTnu9DpJeo5EssSYiyaYW+YvVNUv+0yVaMDRWxfrWVVBtHYgsgcqpaGY4Vv5XT81LZbT/4AgKdwYYsrrfJEjGd5YxidDh1lIspk22UU8h3K6tk+gukTU2wyATULljrJ6iw8itUq7D3zC92bNSkA1VsDS8Y4OW1e8ChkBoK4+d8HmNHIVV5WUiCzuDBqiUEFv4xETKuV0GKZlrJMan8ray+/DiBVm6v6FIGjzWKUdF42ISlvA4C4W4MUxxL6YtTE6sN5ve3t1L70TbmI5uRkkuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYrjcsVP3w3f1v0bdhgMC4Krw6WUqXDOfHB9RJgiDjI=;
 b=HFzStYDuWrVcSQ77EgiEp0wpm+0J1nYqfBH2PQgfT98IJ7YCBHFh/m6CwbnDwxwtjmybpQBsdN6ZUMujhMftI+e9AH2zDk5GQXkhWZ3WFREZWJJXv8Z0gVwZqyMvzzJDrHoBoys04dyahDdXc8w2HBc3IPSShUexCRUGJQZb0upRK2H5IHwVy0I3xMWbUoxMsg+SH5Z/HtAMjd7N8idoty8M3ygdJVZf0/NYN72fonIXCK9ITiaKvYuRQV14BfCg0vqeccI/i5Q4wCiWmwMS4Udl8r8vpR8lHj4UglZIn8V7zb+I/LeWVtL5Xvkp1EmKyKA7TTPizL107gyp/TqsOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5620.apcprd06.prod.outlook.com (2603:1096:301:ee::9)
 by SEZPR06MB5246.apcprd06.prod.outlook.com (2603:1096:101:76::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Thu, 22 Aug
 2024 04:46:42 +0000
Received: from PUZPR06MB5620.apcprd06.prod.outlook.com
 ([fe80::b771:8e9f:2fb:ee83]) by PUZPR06MB5620.apcprd06.prod.outlook.com
 ([fe80::b771:8e9f:2fb:ee83%7]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 04:46:42 +0000
Message-ID: <b356bdb2-fc17-44ef-b0e5-3868b452a8c2@vivo.com>
Date: Thu, 22 Aug 2024 12:46:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/5] usb drivers use devm_clk_get_enabled() helpers
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Neal Liu <neal_liu@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Daniel Mack
 <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Conor Dooley <conor.dooley@microchip.com>,
 Daire McNamara <daire.mcnamara@microchip.com>, Bin Liu <b-liu@ti.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, opensource.kernel@vivo.com
References: <20240822040734.29412-1-liulei.rjpt@vivo.com>
 <2024082210-stadium-sly-cf06@gregkh>
From: Lei Liu <liulei.rjpt@vivo.com>
In-Reply-To: <2024082210-stadium-sly-cf06@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0093.jpnprd01.prod.outlook.com
 (2603:1096:405:3::33) To PUZPR06MB5620.apcprd06.prod.outlook.com
 (2603:1096:301:ee::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5620:EE_|SEZPR06MB5246:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d079db5-27c6-405f-864f-08dcc2656af3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ay9ORitwa2Nhb0Y0Yy9PQjhONTJWTkQvbCt2QTBycmJiMThpOEw4UEEvSWFO?=
 =?utf-8?B?SXFvVi96MHVuY09sNzRnNHdoUXBjbUpzMlo2ZklXS1RPOGVwaUdYOWIxVGt2?=
 =?utf-8?B?YUYvNUJKc1p0bXJSMUZTczJvNzY4SVFrSG9iajI2aHdUWUxiOHFzaDZrQzRu?=
 =?utf-8?B?QlZ3ZVZpUHZoRGxITldIUmh1U3ArZHhRR2NXdk5ER2dXNllDSjVKbjNkUWpy?=
 =?utf-8?B?SkJ1dlhzTXpiU3ltMFVkeXQxbnlvT0lYQlExOU1zWkNTUUVCRGUzY3pBdDkv?=
 =?utf-8?B?ZnVnM29oaHg5QzlyeFRWVTFYYWlEWndlVmx1eXAzZ2VJNWJIR0phKzhuaFZt?=
 =?utf-8?B?QURseVY0cXVKS29ocFl3U1Z3YkprODJrK1h6ZG1XL1p1elJzaFJva2MrbTlR?=
 =?utf-8?B?NGdzdXhKS2hOL2hQWFNZaDcrdlN4R2phRmRCUnRiZHhOWlNHYVlyRGUzZUNr?=
 =?utf-8?B?eUxHMVVpd0R6ckRoaFRSZ0NpeTlSK3d5U0JoN2Q5QWxqSkV1eW5seU1Fdits?=
 =?utf-8?B?UVE2VzBjc3dieXZzZmdWTHJlMHNIQzRwMTJ3WUxWbUdHWjVUSWNtekswK3NM?=
 =?utf-8?B?RzFJK1RlQzBvRkVzSnVuUkJ3RDdHYUhCanR4RVFHSm9rSUxkeU11MmZWWkd3?=
 =?utf-8?B?alRvR084U3FoMDFpZkJwdlN5SjV4TndPOFI2UnkvK2tRYUpvZTluS3hyd3cw?=
 =?utf-8?B?bldUaWFPTE1IUVBFSSt4ZmxpM3lhN0ZPMXhGczRpakhlSG9HSmN2YWVST2Vr?=
 =?utf-8?B?eVEzdDVkL0tIazZrbjZkUnFuampaUzMrbGRsOGhTdlhQNFVCNHN5SmFUL1NQ?=
 =?utf-8?B?WmwxbFRCbGYzWjNLV0lOQmJoSTcybk03S01NaUNEdEMzWDcxYlMxM3dzSXIz?=
 =?utf-8?B?MGJPMjBBaEt2WVkzS0R4R3p2c0w0d1hRc0RFeGVPUzhwMVpvRFF0T09vYXNI?=
 =?utf-8?B?d09jbG91YlFDaXR1cjBXWktBMzJiZWEvNDJjSHVEZVplQkZkMkxhRlRQZW1W?=
 =?utf-8?B?RkNjVms2a0dkckd5V1VUcy9weGZLQnh2dDFLVEJUbkVqSlpBbTBWL1lKQUlp?=
 =?utf-8?B?ZE1SQ3lNKzlvY1BwSElEbCtLVWdKY0tJSmc4QUFzM3h2cmk1ejY0b3ozdkFw?=
 =?utf-8?B?Q1dEclh6aCs0UUhSYjhtZStBL0gxQklvOFhHYlJ2RnZvYU5SNmFWd0lDanB4?=
 =?utf-8?B?a2htT0JPTlBNc2ZHOFVwdmdTeDBLRHpjbG9ZeG16WkxQc2gxcW5wQitEUWs1?=
 =?utf-8?B?dHA2Q0ZQalFINmdycWswRk9ZYXNTQThjVFBHMDJZZU55Y1RuSHgrYjc1UE9o?=
 =?utf-8?B?dm9QV3llMmY0Q2NKKzdMejc4OWc1aTJtTWo5WDVFVytMWW9qWTlIOEJrb2ZS?=
 =?utf-8?B?L3FLK1NPQXEwWnF4ai9GUDF0VHJrZzZYRFRIVFNoeVlOU0tXeGVYcUtVSmNa?=
 =?utf-8?B?ejc0dGFDczRFbEtxdEM4Tll1alZZZUNQNnJuL2Q3OXNCQ2FKaHlpR2FwZWow?=
 =?utf-8?B?TWI3eVpJdnhBWk96VHgzYnh1ejFuR3VERmMyOFN0U1dGdTFPd3pkV0ViNDg5?=
 =?utf-8?B?RGExMVhGVjdubktOd2srbWg0NG42dU52SkFUVDBjVUU5dmRJdGd0YTh5dUVI?=
 =?utf-8?B?Z28rcjBOV25IOE1PUDZkQ3VHRmxxYmM4Y2dxN3VBM1k4V1R2RlRSOHdLRGhU?=
 =?utf-8?B?d0JKMGVCMElSN3FVdDY3WUlMNU56RHEvcUJoNzlBakRTdStpc01IUUszdVJk?=
 =?utf-8?B?UzExNW44U1k1cWIwTjlLYnFFK1FjdWkrNU9sc0h5RmRxMjR0akF3N0wxaDJ0?=
 =?utf-8?B?M21KaVhFTXBpTzd3Z3lDbzlOTzFhSGJrYXFjeWRDY0tuMmxqcEpPMllrTFcy?=
 =?utf-8?B?NUlDbXU0djRVMVZEZnQ4bTlILzl1NUp1SytaOUJlOU16cUdEVkxBblUvSzZl?=
 =?utf-8?Q?jUnJsdvwQj2Cx1NlJBpDTS5wERz6U1BA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5620.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEMzNjlJcVE5QzhiL21XQ1pEditsK3ZQK1dZNEFyalNxL25QcnpSMjRjTjNx?=
 =?utf-8?B?VzBLazRWeW5sMnVuZkh4UW5tUVFHTnZacnd0NG1PL1Q2dUpINVhRTlJmbEI2?=
 =?utf-8?B?QTArZVhNRDdTT2hRT0lSMGVQTWNJUUYxbnYxempyWlNRRGJvelF6TTl5QkdO?=
 =?utf-8?B?ay9KMXp1MGVuU3dTYXhML3ZRcDJMNXhGUVJ0VU1sZmc4czZpVzFTWWhpelBk?=
 =?utf-8?B?UW5ELzcrVkg5WFBCeVdKTE96c0dLY05hVWlTYUZOV21zdUNrVUYwd3BPNVRq?=
 =?utf-8?B?TklMeDBKOGZWLzBLU1NIT0NlYXBGWXpaVzJTdG1zU0R6NVBjTUVXbzFOVVJr?=
 =?utf-8?B?bmRFYWpYaUorQzVBak5EaENod0pYWlBXZDkvRkJLZTVHZzlDS0hWMXJPWXc5?=
 =?utf-8?B?SzNsOUhnMENtMzZLdTk3Vlg4WW1VOFdld29Pa3dTRVN6VG9xT2p4NFZTMDNj?=
 =?utf-8?B?aDlsTnZhaUxqUzVjcko5SVJQd0JHbzRNTmlybVpKVExNR2dSY1V1ZWg5UjMr?=
 =?utf-8?B?QXNVRndCU3JsOEJBaExzRldmNllFTGdvVWhRdVRCaE05M0UwcDhTNE9vOGFG?=
 =?utf-8?B?MnR5UGJzNkZsVmtCMnRiWThoTXRQZGIvY0FDaVFCUEVGQmcvNHl1V1NIS3lq?=
 =?utf-8?B?c2xrRHhHOE8vc2lZY1BBNmFKMDhpNjlrNStKclZud3BaNGFuZzBoTnFGMHFB?=
 =?utf-8?B?K2dPL0Noc29DT3hRNnBDc3BQc2lsSkxrZXpDMzIxZGZMYzhXdVdRSW5rN0tW?=
 =?utf-8?B?eDdCQXUvZ2lKcnlrd2k3dnZuLzAwK3l2SmpZUUc3ZHQyVjNleXh0MFZoSUZG?=
 =?utf-8?B?ZDdlQlc2ODNaV0Z1YVliblJzZkhoc3NyZW1ia1YyRVkwc1BFcEdvckVFenpw?=
 =?utf-8?B?UVBjcHgvdTdBQmlnTHF5NUQ1WTNHaHZsT2RMbHU3cytKWEJLZ1JrSGpkRUkz?=
 =?utf-8?B?YVB0R3ZxWXFCVStEdW4yMDQrdXEzUzRNVjU3SG1hc2dsdTdtdXl3TDZBUS81?=
 =?utf-8?B?b3BFVTY1eXBuZFRyTUhMbEFIYXhPaGxXdHIxRnd3UFN5MmliWXZnc2FkU0tu?=
 =?utf-8?B?SlZ3YmQ2NjBlWkY4UHNZaW9jQzI0K0xlbm80eDdxVGl4a1kzVlRyVys3bkh2?=
 =?utf-8?B?UlNNQ1ErRVNUWUFtMDNPMEM1aFNGZVRQN2kyaWdEN3hYdDR4T3VkcjE1RVRI?=
 =?utf-8?B?ZXVISVBMTzdyR1NZM0NwdkRxMjNBQ2NPeFByazRFRENKaVdhQ3B0dURkUUhB?=
 =?utf-8?B?a2RiSzFCbGM0WG1HaHh6YWhFdk8wckZaUDVKemNVS0NYaTZrR082N3d5Q2Fz?=
 =?utf-8?B?UEhpMVBTdVEreXRnTjlpZnpVdUNUZWlqVC81elN0VFpPdGNYSkx0MlZiMXFq?=
 =?utf-8?B?WmprZ0lzd29TdTJ1N2F2WVpmdkZXNFJpNi9QTGd5SzBweThONkNxS0poY3Ny?=
 =?utf-8?B?WTFYV2tiaE1FMGc0ekxjTzUwcUlISE82Q0VkbE5QdzA0T0NqbHQzOXZYWHQ3?=
 =?utf-8?B?TVZlSW0rTUZTcEpiL2RqY1ZJNU1vdExIUURpWm9qVHpXWlJEa0pmeTRPdkVH?=
 =?utf-8?B?YjJ1M0dUMHh0V3VDTmNIbzB0bE1CbkdCOTI5V3VOM3hEUERoQ0tIMG5oK1NU?=
 =?utf-8?B?MjBsbm9IRDd4ZDJQL0ZLR1B0WDRlZ2MzSUJFZVMzdjJvQjBGVWRZeCtlVUJU?=
 =?utf-8?B?R1I1VmpCdUxlZW1ZS1BsRGdkYlF4UFUrTm9aZnpudWhIMm5Ed2NYaWVXVXVK?=
 =?utf-8?B?Wno3T3FvemxjUzFkc3RLeXlUZlZZaXFwZWFGWXVWQkRXMmQyMWFyMzdRdVJJ?=
 =?utf-8?B?Tm43d1hFTWw3RWR3MU9GTlNCblZwM3FlZ29Gc0o5Zk5mVXdaY2dFc2IwUU92?=
 =?utf-8?B?bGpuUDJQOWJhaU5HQnpRcmlFdzVRWGhsN0VWM1liUlJMajA4aWRUS0Q3V3A4?=
 =?utf-8?B?cVBBVWRYSXRKeWpENk1HYlR0YTlYeDZHR0V6WDRaZ1hOSWtsemRZQktQUUk5?=
 =?utf-8?B?SkZ4NnIrZDlOcVMzSkFvTnpsQWhEejlqVGM5UGNUUS8rYjVQYURUWWJxVHZ0?=
 =?utf-8?B?Qkt6SXVML25Qb0lTeHFZNWhsVFhhNit4R0lCR1ZYT093cVQyUkpPejlUbHk1?=
 =?utf-8?Q?NDyuhp7FK9Zf2ZyQNuLFD0g7p?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d079db5-27c6-405f-864f-08dcc2656af3
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5620.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 04:46:42.2823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EJujI2zTkkN5O1oipa5ta0MP8992qK3dJBJ7WbXf7qCAWiz7DQGTo6fdExnraajhZxaXrEEGllRomIQpsddmYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5246


on 2024/8/22 12:27, Greg Kroah-Hartman wrote:
> On Thu, Aug 22, 2024 at 12:07:25PM +0800, Lei Liu wrote:
>> The devm_clk_get_enabled() helpers:
>>      - call devm_clk_get()
>>      - call clk_prepare_enable() and register what is needed in order to
>>       call clk_disable_unprepare() when needed, as a managed resource.
>>
>> This simplifies the code and avoids calls to clk_disable_unprepare().
>>
>> ---
>> The files ux500.c, mpfs.c, and pxa27x_udc.c have incorrect usage of
>> certain interfaces due to the lack of synchronization during the
>> commit updates. These issues have been corrected in the v1 version.
>>
>> version 1 changes
>> 1.ux500: Incorrect usage of clk_prepare_enable() should be corrected to
>>    devm_clk_get_enabled().
>> 2.mpfs: Incorrect usage of devm_clk_get_enable() should be corrected to
>>    devm_clk_get_enabled().
>> 3.pxa27x_udc: Incorrect usage of clk_prepare_enable() should be
>>    corrected to devm_clk_get_enabled().
> Patch versions start at 1, this should be 2, right?

Hi，Do I need to update the patch from v1 to v2 again?

Lei Liu


>

