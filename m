Return-Path: <linux-kernel+bounces-575310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2FCA6FD52
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C197C1696CC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65AE25C6E3;
	Tue, 25 Mar 2025 12:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PTji9/nr"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2082.outbound.protection.outlook.com [40.107.105.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F24625BADE
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905305; cv=fail; b=TdyZ9/A5Tc/sUHHE0vsd5Us0D2ugPAP7FRbxOTsRK/h437rDQKcWxYci1OPNWz4uYQBkEgJKLnhgsvJwK+sK47fvpIWMtoOxp7PyPJ0XZ/qTWnwgvcho1REBsEc8FlcqkTsIUbo3vN5SxmxnR82gigZBYGCUs640ZR6z2UngGEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905305; c=relaxed/simple;
	bh=kNHU9tKL24CdeEB+cyINzd03979/SYdZkVWKFIo+bdc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CCK0RnmBLcfsyKOgRrHTWCC8eri5yF5LjxE+icsOblKlGhXnACK2RK23jilQMmUMsYhA6XLEqj7A7y+piP5Aa9sI9e8CBS8bHW3f1sAo9zhrorSJceDpY8jbc+wiHJVVLda/4IxFByogfdHEqJ+seXk+NDAG6KdJ5WD+0mge3GE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PTji9/nr; arc=fail smtp.client-ip=40.107.105.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RwNj04ZxzxuE4Yp7Zgs8/gRyfQHYpv9XLkuquLx1CL/Jh4u2pXHmfXs2OJayA6nzjIZK6hIWtGF0nf5ssi3TEfNtoK0b2pvfGtN2Pq490hzRnPJQO1X+JR++dZoFhRNL86VFjfGqHHAsChxr/dZuhCQzEhPTWh5Ln6egNkr0gaZ3qEirD9AO9RXJNWOTKY9SceR/z6hWzWsxI/vwqxV2q0t4OlWutmHB076FgmiCuuQs6pt0wKUYOK5N2RubkU1TmyUDwYTDrFcsr3FgByhHeb5Oop5m7k1m60Ja+dkZK1eCT/k03M4HVgCaa6yEVF9l7S6Z2TDtRjRSLkbyr+PrsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rT49O53CA8t9mCidX3amYrwwupgEm9CWCGDIgawkt0=;
 b=RLmX9njrcd9rYYwU7BNvphkn+xnoftXdsblJxoRhLAffyuQ4lOzetROlRjQAUKOibgkBS11pmdwM3ln9TkTPiqDUjwFb7Yt6nNxEO/C89cRAsKK5XysF2UZ+vsfYfei3/DVgatAwnEjTczwiU+gpA4nCfaqnpQJNxmTWSAy+qGH1BGpBxQ5dMsrk9dsNl68SzSZUJlrOCp+UrUH5CsD/+m52KUNCoj2cvYh7ATnia8txglrvS/WvOT8+HPBhQRYFeTXujeKtzNPYsYt3lIlu2DObS4LwNTCNSaVfPZBbGKd8J9/MnqfOOJ3HoIV4x7yLqGjajpxJvI4rfq1mJVZESw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rT49O53CA8t9mCidX3amYrwwupgEm9CWCGDIgawkt0=;
 b=PTji9/nr1dtx7C/NQjYIsH8pywWkBDTjW4moHX87T+fqmFjy0RkfEttzC0tYikxyVSN8d1stlBJcQIFYKe/zVWLLOhiuOM9auBR77T6HowVmgKWwGngoCmsLa0mPif7qmGX9ZBgWH27rVJjG+4ks1jlkDpHNisRDERRESdopb86qopl7o/JexBuEHoXTo/Ynpj+fq5+gyCeYpJqgG170RveaTPH7kq8/51YBlUbx09+duUEtNrvgTRJoRjfxwlHyKG6OPANsai7VJddkTnNzg0T8Au+iKpAT/bpwv9IkOGbM5B4UPKtbDY7GhLLY9p1KUd1aRZDNoIY1C5hHQxvm/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24)
 by DB9PR04MB8431.eurprd04.prod.outlook.com (2603:10a6:10:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 12:21:39 +0000
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::c96e:12f1:67b7:ed74]) by DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::c96e:12f1:67b7:ed74%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 12:21:39 +0000
Message-ID: <068713cb-47ca-ae26-e113-9f5026be9196@oss.nxp.com>
Date: Tue, 25 Mar 2025 14:21:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/2] clocksource/drivers/nxp-timer: Add the System Timer
 Module for the s32g platform
Content-Language: en-US
To: Daniel Lezcano <daniel.lezcano@linaro.org>, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, Thomas Fossati <thomas.fossati@linaro.org>,
 Larisa Grigore <Larisa.Grigore@nxp.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, NXP S32 Linux Team <s32@nxp.com>
References: <20250324100008.346009-1-daniel.lezcano@linaro.org>
 <20250324100008.346009-2-daniel.lezcano@linaro.org>
 <d60fca36-0beb-2574-cb82-3969bbfb58a9@oss.nxp.com>
 <8c208e8c-2e1e-430c-916a-dbc6732881b0@linaro.org>
 <065d6f32-3161-8316-bbbd-4da18eef839b@oss.nxp.com>
 <098c5de8-9291-4f3e-a276-500825cac7c5@linaro.org>
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
In-Reply-To: <098c5de8-9291-4f3e-a276-500825cac7c5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0122.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::27) To DU2PR04MB8582.eurprd04.prod.outlook.com
 (2603:10a6:10:2d9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8582:EE_|DB9PR04MB8431:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ded1ab5-b7dc-4f68-3f6f-08dd6b9797bb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3VCbkxvUThEVGZWUFJheGY5QU1jZC9UVVA0bDBNcWM2U3FPUUNOaWg3M3dH?=
 =?utf-8?B?Z1Uxb29vNkdkRGxZTTVrdmx1Q1hXd3VCWmFSUFZLUGJBQ1pZYWprQzVwUjln?=
 =?utf-8?B?VGRsSVpHQWdKWkk2U3RTMFZlNDkxajdTbTRnWUZFT0VxZ3d2bDlPcTVRMWw3?=
 =?utf-8?B?VktxSkdqYU03bkVlUWprQkpGdnlCZ3RsUktPNXhDVitmTy9tcjVBMXRqdFh5?=
 =?utf-8?B?cElvWHROV0VzYzBUVXBnMVcvV2RwdzRSRFA0TklMbEljZTBkSUdKRDN0Sjl2?=
 =?utf-8?B?NzFKeUFEeVppNWtxbXJhZUJ2a005NjlOTjdRYlprWU5zN1Q1dkxZamtMdkYz?=
 =?utf-8?B?N2E3aVBYMjh6M1JKNkYzUkJwZVpZSXJXNUREc2UvbDlhM1VNbzcvYXB4bXly?=
 =?utf-8?B?aHQxWTVEaHdaUURSNGRRbm5CdDF5Rk1UT1RnVkJ0UGp6NlVHTFU3b1Q0R0d6?=
 =?utf-8?B?SFRRVUl6WHZyUVMybTBzK2VJeWdseWV0RFArVGwrQ1NtdEtwZkZSczNqVG5l?=
 =?utf-8?B?WURSUlBvblduL1dVTGp4MzNFVDk4K01GNU9wTVh1SDNDTVQvOXIvT0lqUm9L?=
 =?utf-8?B?ZTBaMFowYXMvVVpqZklFZGgzQ1hkRVg5TFJWcHI2dXd5NTd5L1A0TjVFZHFE?=
 =?utf-8?B?UnJVbUZNZ3N0V3dhL25YTzhRbkZJK2czOEhjTEk3ZVVXaU1jSE5wektJZnpB?=
 =?utf-8?B?WitHU0E5TFZtRjhwNjVxR0oyV2MvV3VzdFR2a2JyMnlaY1RZcHUzNWhQY1dn?=
 =?utf-8?B?bnBNU0ZYMzh6eE5aVlJqZE1KVHJsYzBtOTRiczZlS1RXY1RhMzdFYkNMKzMz?=
 =?utf-8?B?U3JKT056N1lsUDhsN1lDVDBtS3ZJendsWmE3UXE4bU5CTUhqVUdTMUYzRVdx?=
 =?utf-8?B?OXc3QU1tUnlqRU1Dcm1ucjNBME8yYkZDQlVVdEFHeTBTQ2o5MWRLNFhYOXZl?=
 =?utf-8?B?SG00bkNVVDlleUZUL0tKYzhLZkMrUkJSZUE1VytSbnFRbk9ObE1KeXhmNU5Z?=
 =?utf-8?B?bENuUExFcmFsU0swR3l1bDUwRFRsKzB5TDBHR0VSSVpIdTFJYXY3RnpDbkVm?=
 =?utf-8?B?SERMTE8yYjFpWFpsNURqVWN3UTEyVkczWENhb2FpbnErS3hIc1ozYnBkaTBq?=
 =?utf-8?B?aDBHMEVBcVNTVFU4RTdDUGRNRDhqYVNYSDhONmozUS8rWTc5bzlLUGhEZmNk?=
 =?utf-8?B?K25Yc0FLMlZacjhDelhoT2IvT3hJMzRJb2JWSks1bGZFM1hVakI1YlFPblJD?=
 =?utf-8?B?Yit4SVpUa2s2NUFiM1hnWHQ2cVpKMjlyN2lqRy81UXhKZTBZRC9MQTVXL3JP?=
 =?utf-8?B?RUN6amZiT3RWYkJIRHVMMFAxTW5JUXhVcDNQbkdNWC9OZ0JmWHQ0VVBONzBQ?=
 =?utf-8?B?RVFJWkNNVUxGdDBIRmhtV0grU1FSL2RKMTR2TlZMd2xSeHNuV3dES1UzdWJW?=
 =?utf-8?B?RmJXb3hNZk5tVGxNbWp2aFdWUnljeFFNL1MranBxU201dVNIbzNhMmlwZnk4?=
 =?utf-8?B?N2Y5b2JvaE94aE1Lc0s0WStaWDV4aHpsNXEwdVhlUkw2VUJVWGhpMkxtclZs?=
 =?utf-8?B?ZGxTQUhUZHo4Wk1QQUgveFB5Ky8vaGZzaE83K1ZZWHZlNk90K21FT0sxdm9C?=
 =?utf-8?B?L2hheTRkOVN2djBnTjFGcDVwT0lKRnZGdXBHamlhSVBxUi9Pcjh6WUlORTFI?=
 =?utf-8?B?TDhvT0s5WmdEOFNCT3pOOTY1LytEMkV2VE9URDNmYW90cWt6MlFXRmVjL0JH?=
 =?utf-8?B?WXBpNjBwam9Qa3AxT3F6QkN4QzFHL0QvbFNOcUd1Y0NHUzBZSGhjRE5ZcU1I?=
 =?utf-8?B?dUF6NzFmY0R2Kzc3SWFEdTRkSGEvWGhSTGJVeWE2K0dYRnpvaDd4QUx2RlNX?=
 =?utf-8?Q?HhhPIWVykF3l8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8582.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1hHcTg5Ui9IRWg3YVRCQXBjUHFKNHlLRTRwaCttUHB2WWtRM1lSM1lCcTdk?=
 =?utf-8?B?d1ZDWm1rNCtwUWJxRmljeEpNd2hNV3EybnAxS2ZjVE85V2R0THZmR0JEVHgv?=
 =?utf-8?B?RVlwTVdJOGlCdjl6aGhlRUREUjZmUStzUWhsU2M2b21RWnIxOW9kcS9QRlZ5?=
 =?utf-8?B?cEZIT1lOQ0E2MWo3U3R6NEorcVlPbVpjY1ZTY2kvRzJoOThzYTZNdHhpTWZU?=
 =?utf-8?B?b1BJZTlkd21USVpkcC8ybFRUV0YxbXlrZThQQU9CaSttaW5BbXJDQ3ExR0Vi?=
 =?utf-8?B?LzhySFBIQnEva09neStCNXBobnNKdEhjbDY5eE95bTNVZTZZbkRJL2RFQlUw?=
 =?utf-8?B?bml0ekNMc2VxRzczSmw1SFVQU3BjRjlWRmlmcXA2NjB0TWM5c0pGci8rVm1Q?=
 =?utf-8?B?SXYxNjNvN3ZZRDlBLzdzYWlVeWhTYjIwTGMreC80T0JwSkJ2dEtiaXdjL0hH?=
 =?utf-8?B?Rnh2NUo2RlZGVU9CMDZZMk5UKzVvVktZZ1d5bU5PcUhXMEdFR3gwQk1jVEVn?=
 =?utf-8?B?R2VjM1RnNk9FT2tzUWNUOFZ0N21tUHk3RWIwUWhZUEdaekhJVkFFZXhwSnZz?=
 =?utf-8?B?TnRpZHBlaUdmR3FVZG1mRkM1UXBnVkFObXl6NFNUblpZdVRydDlrbm5Dd0U3?=
 =?utf-8?B?dmZGcm9PYWwwNEl0b2pWaWlpckZzMExHbmxVWThvSTExSXFQRUMranNqR2pi?=
 =?utf-8?B?dFFYc0dxM280MndjOGp3VDlqa0ZSbE9XRWR5ekdjZEMyaWppdHl5Q0ExVFlL?=
 =?utf-8?B?SVVnL3RHald0cXdmSnA2RFhZMjRSNnpnMnlZcjVqVEpVSDNPZmpmdUZkYVov?=
 =?utf-8?B?bStsckhlbmVrUVBPUUgwc1N2SWo3dnhYRFViTHZBc2tWWVlvR1AvWHRkdVpS?=
 =?utf-8?B?ODUzTWVFb2Z2ZXJnT1hneFJxbE1YS1hJaDVyOFhwWkdNSXJoZTA4ejlnQXdK?=
 =?utf-8?B?dFRFb25GUVVUR2ZQeVJ4SVJNR0ZKU3Jyd0pXRVNGTDZrVzFqa0p6NXJUc0VO?=
 =?utf-8?B?TnlIaFpGMjdlMm5DTWlrODdDbjdkQmhFZ1JMcmlTWXFGdk51Vmg5ZWZ0eXZ6?=
 =?utf-8?B?RUxiUEJTc3pYQ2NzV3kzN3NLSnlpUW8xSTJPL0pFNkxDUXBEL0FKamwyaXFY?=
 =?utf-8?B?TzJLcXl4T2JkSlFSL0NXWnN6TzBCU0c0bnFsTU45cTdZNkI0ZHlsbXZHK0hR?=
 =?utf-8?B?eDdleVhaK1VTY2p0TnVYbTU3Ty9aeDduZEltMFNiRlJYczgxZlpLUFpDUnhj?=
 =?utf-8?B?eU1qMUFUU212azhLVlpLOEIvZUhtZEtkUTBnVk91dDF3NmQ1MkR2VS9WQmp1?=
 =?utf-8?B?aDIvOGdPL1g0cjhINjRRbzlNcDRjYkgrS1ZEVDBvamRxWHdSYWpuay9tR1Qz?=
 =?utf-8?B?cjkzdHFrNmpjNEtIQS90TnBGYVVqczE3eURxY1d6S0hheDlzeVpNVHhLbSti?=
 =?utf-8?B?Mm5uN2sza1lGd1NCUlRRYzFCNjdvT1J4ODg2d1hQQ2lQUklaWEJPNzFDSXQw?=
 =?utf-8?B?TEhYeVRxZzM2MGxoamdHb1IyRVBsS0ZYMGNISExpcFVWWnNyMlJLb3J1YlRx?=
 =?utf-8?B?dnFDaTV1QmI0ZmQzRGtqaG51YXFoOGYwVFBIcTBGOXRjRGVNakd2bzlFTEQx?=
 =?utf-8?B?bkwxYVc2OWg4dXFSNWVkVVBpVnQ5N2wrNUdrdmROWUZoeTBNRG9qYVJGckdN?=
 =?utf-8?B?VWQ5OFlPdHJpWHF2WTlaVXZremlkTWVmWGVqWnAyMnlzNzdrdHBJRGFQOWlS?=
 =?utf-8?B?VVB5b0dpYmZ0UWtTaS94UzE5eVh2Y3AydGdOU3lxays3NHRDSUhaRVE1aWNs?=
 =?utf-8?B?a3hXVjlhekkycTZYUFJQYi9YaHR3UEVvYXMzZ3lkdmVYU2FHUGFNd1daNE9R?=
 =?utf-8?B?K1llUTN6T1luNjk4eWVuajVoOEJ6R04zb0ZYRkxJU0xNK1FPZGtaTmNEdnFJ?=
 =?utf-8?B?NlVERzJsWm41c3l1TklvdVJqcXhBaDEzajF1YVN0VW5PNlFNbXVTZXhJbVNk?=
 =?utf-8?B?ZFdEMEl1ckVYYUlNQU82SWgyak5rVUxTL3E2T25mekZyWDAvMWF0cnFjakUw?=
 =?utf-8?B?dlFlc3h5RWZId3kxazRxdFVubDFad20va21KZWJEZ1cxdUxtYnUyQnZBYlVN?=
 =?utf-8?B?aERnTzRvbVZYOFdMaWh0dk9yNnFHNy9YbWxWbnZmL0ZBVVFxdjhraW9udFEy?=
 =?utf-8?Q?m9xK4rkiHXf8HT1xR1qr6z0=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ded1ab5-b7dc-4f68-3f6f-08dd6b9797bb
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8582.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 12:21:38.9235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+JyqMXaicteetVcsx84FNp7gU7c5B+seNax0OkoO1TXGYFyZbvQRak8cP+TuFT1G/XTGoMrEhcvvXmiDklJSonRPIA7NB1MX0XWpiFp+yQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8431

On 3/25/2025 2:09 PM, Daniel Lezcano wrote:
> On 25/03/2025 12:40, Ghennadi Procopciuc wrote:
>> On 3/25/2025 12:53 PM, Daniel Lezcano wrote:
>> [ ... ]
>>>>> +static int __init nxp_stm_clocksource_init(struct device *dev, const
>>>>> char *name,
>>>>> +                       void __iomem *base, struct clk *clk)
>>>>> +{
>>>>> +    struct stm_timer *stm_timer;
>>>>> +    int ret;
>>>>> +
>>>>> +    stm_timer = devm_kzalloc(dev, sizeof(*stm_timer), GFP_KERNEL);
>>>>> +    if (!stm_timer)
>>>>> +        return -ENOMEM;
>>>>> +
>>>>> +    stm_timer->base = base;
>>>>> +    stm_timer->rate = clk_get_rate(clk);
>>>>> +
>>>>> +    stm_timer->scs.cs.name = name;
>>>>> +    stm_timer->scs.cs.rating = 460;
>>>>> +    stm_timer->scs.cs.read = nxp_stm_clocksource_read;
>>>>> +    stm_timer->scs.cs.enable = nxp_stm_clocksource_enable;
>>>>> +    stm_timer->scs.cs.disable = nxp_stm_clocksource_disable;
>>>>> +    stm_timer->scs.cs.suspend = nxp_stm_clocksource_suspend;
>>>>> +    stm_timer->scs.cs.resume = nxp_stm_clocksource_resume;
>>>>> +    stm_timer->scs.cs.mask = CLOCKSOURCE_MASK(32);
>>>>> +    stm_timer->scs.cs.flags = CLOCK_SOURCE_IS_CONTINUOUS;
>>>>> +
>>>>> +    ret = clocksource_register_hz(&stm_timer->scs.cs,
>>>>> stm_timer->rate);
>>>>> +    if (ret)
>>>>> +        return ret;
>>>>
>>>> clocksource_unregister during remove callback for cleanup?
>>>
>>> Sorry I don't get it :/
>>>
>>> There is no cleanup after the clocksource_register_hz() is successful
>>>
>>
>> I noticed that other drivers, such as
>> drivers/clocksource/timer-tegra186.c and
>> drivers/clocksource/timer-sun5i.c, perform clocksource_unregister during
>> their platform_driver.remove callback. Shouldn't this apply here as well?
> 
> The tegra186 registers with one probe several timers and clocksources.
> The timer-nxp probes for each node.
> 
> The timer-sun5i.c has the remove callback but it is pointless as it can
> not be compiled as module. So it should not have it.
> 

Ok.

>> [ ... ]
>>>
>>>>> +static int nxp_stm_clockevent_set_next_event(unsigned long delta,
>>>>> struct clock_event_device *ced)
>>>>> +{
>>>>> +    struct stm_timer *stm_timer = ced_to_stm(ced);
>>>>> +    u32 val;
>>>>> +
>>>>> +    nxp_stm_clockevent_disable(stm_timer);
>>>>
>>>> While examining the code base, I came across the
>>>> drivers/clocksource/timer-imx-gpt.c file, specifically the
>>>> mx1_2_set_next_event function, which includes a protection against
>>>> missing events. Using a similar approach would allow us to keep the STM
>>>> module enabled while only altering the channel's register state. This
>>>> risk can also be mitigated by adjusting min_delta_ns based on tick
>>>> frequency.
>>>
>>> How would you validate that ?
>>>
>>
>> How would I validate that this works?
>>
>> If this is the question, I see that the core performs an auto adjustment
>> of the minimum delta as part of the clockevents_program_min_delta
>> function when CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST is enabled.
>> Initially, I would examine how many times dev->set_next_event() returns
>> -ETIME. At the end of the function, min_delta_ns should reflect the
>> actual minimum delta the device can handle.
> 
> That is an area of optimization and I would prefer to keep that as a
> separate change focused on validating this approach.
> 

This suggestion supports the argument presented below.

>> [ ... ]
>>>>> +static int __init nxp_stm_timer_probe(struct platform_device *pdev)
>>>>> +{
>>>>> +    struct device *dev = &pdev->dev;
>>>>> +    struct device_node *np = dev->of_node;
>>>>> +    struct stm_instances *stm_instances;
>>>>> +    const char *name = of_node_full_name(np);
>>>>> +    void __iomem *base;
>>>>> +    int irq, ret;
>>>>> +    struct clk *clk;
>>>>> +
>>>>> +    stm_instances =
>>>>> (typeof(stm_instances))of_device_get_match_data(dev);
>>>>> +    if (!stm_instances) {
>>>>> +        dev_err(dev, "No STM instances associated with a cpu");
>>>>> +        return -EINVAL;
>>>>> +    }
>>>>> +
>>>>> +    base = devm_of_iomap(dev, np, 0, NULL);
>>>>> +    if (IS_ERR(base)) {
>>>>> +        dev_err(dev, "Failed to iomap %pOFn\n", np);
>>>>> +        return PTR_ERR(base);
>>>>> +    }
>>>>> +
>>>>> +    irq = irq_of_parse_and_map(np, 0);
>>>>> +    if (irq <= 0) {
>>>>> +        dev_err(dev, "Failed to parse and map IRQ: %d\n", irq);
>>>>> +        return -EINVAL;
>>>>> +    }
>>>>
>>>>   From commit description:
>>>>
>>>>> The first probed STM is used as a clocksource, the second will be the
>>>>> broadcast timer and the rest are used as a clockevent with the
>>>>> affinity set to a CPU.
>>>>
>>>> Why is the interrupt mandatory when the node is probed as a
>>>> clocksource?
>>>
>>> It relies on the DT description and it does not hurt to have a
>>> consistent code path for clockevent / clocksource even if the interrupt
>>> is not requested for the clocksource later.
>>>
>>
>> If so, in my opinion, it would make sense to use the same STM instance
>> for both the clocksource and broadcast clockevent, as both functions can
>> be accommodated within a single STM instance, which will help reduce the
>> number of STM instances used.
> 
> The broadcast timer is stopped when it is unused which is the case for
> the s32 because there are no idle state powering down the local timers.
> They have to have be separated.
> 

This wouldn't be the case if the STM is kept running/counting during the
clock event setup, with only the clock event interrupt being disabled
(CCR.CEN).

-- 
Regards,
Ghennadi


