Return-Path: <linux-kernel+bounces-376448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD189AB1B9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1C31F23C1C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDA01A2C04;
	Tue, 22 Oct 2024 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y+zqyODQ"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010067.outbound.protection.outlook.com [52.101.69.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342771A262D;
	Tue, 22 Oct 2024 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729609760; cv=fail; b=lP/rh7kM3qRbJ3hAJ0Inil+XJuCJj/Lqs2dLUa9WcponBR01/t9Rym2gF3YW4Mws/89C14s/ALgL1NOm49AwVc5c6DCFsphowl/rt54wqQwSKNFwlrFhXrRBb5saUoN4iJJtGmcJPPfHq0lUvcf7liC16AwjQankUA8JOcNhVgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729609760; c=relaxed/simple;
	bh=A0/0a9kL2kBIiqxKR8/NgQb05LQhsW1Ou06yHB85dDM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CsL7gm7VEGDhPnLUqLAnTk4EHZgT2YyTRRhF2dCHXzchgtP7zlqRV18Ij4rtJTRH/U+R7SHvGdVSY+7RRIqkhXIFLS1aCpSdghwhMuBPKaSZmc/YNe57B6uKQ2+ndPaPp2oSiBiMSS0RhhtczZV6CT7/9BOW0lRgWg2rbwLyjcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y+zqyODQ; arc=fail smtp.client-ip=52.101.69.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSsCSd4uEbSRDdcm9/MteBDPCbs31m/zVSZUy4mirh/bY/xTQrBgppWYVaecS2Rylf89yTMhDzXD8CC2NdiraczNt7fmqL9EZAi/i6vV+/l6tj5NSTnpCvB4c4umiHUNbQzlzgG8p7OXUYYYkB5dIokFLK5Wvh6bqj0RlAn4sK/qO5ZMR/J9YtDJkl+VmsggD0Kpgmnx4pMI+Rgq50cWvG5n5CW2JLVyd5iyevt96evhzhYeDHM/4XBpmrVPvCNqHLo4//8vpgZuxGBqW1sX5eth8eWORUnpAlBijkyiypZxmHJcHwfYIb+md79dHHpH6Vvi7ErWYjjGL0c+pA2XkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fccql/TCOb87C1EZGQX6jxV5JqI9QE6ikC3s7DM1PgA=;
 b=F4Kx7XOeOQakMQiVtapah1MCX2kqgiDIcftYM4WgtjyjagudqkK/9X/cRfk+MKQGj36ndF32xruH7Qc+YhLd5uFqXoMTW/wsnL/WwWNpG8SfmMbg5w31rbNw7B5CumpFUt9nlkz6OBV2WI7FUIx3ak7sCQ3xxzu5JVWpMds/YIZyuYS5Jp8uRSRWetqn6K+fm/wGK67eQbmnxllM9rh0tZwQbDX2PBl3RMiA1NuLwKuRY1f3gMoIwHUfZ5FSXjx12yt4iQI2/q5k8AfnGUAnVFEuYvTOGU7/9xaDzs1oc8o7767meITYV3vqbYNakMQEWyyA/kuodcjZFnCL+Qoc9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fccql/TCOb87C1EZGQX6jxV5JqI9QE6ikC3s7DM1PgA=;
 b=Y+zqyODQX4U6nRMZhEyy3Ic3N3B3gJanOyvLGpB8dFouBYEBk0qMEBlt+EOgsu+k9aXBWAkSXrmdTt7XYdkZanIPEZp6x9jkvJuItJRLTVFJAk0q+0PNfUoSTz9BEBiA6ZA/f3dUSXLGm1foMCLXBcNMoVrvirlJ21dAfF1Eo8cE/NRB2Hd01903O03852PO/kOvF0EL8RIMj0vpv4iYsnKmBnpG/YW+kRPudIiEGiGbzjAggVA69W8hZeCNyjdwk750yPtB9tabphQfZxAth26SzRz2ZBSSszp06IK9qcrN4zRw+ccmGnhsuIJZNtWr0AO95FxDShdtRn0ZCVuNIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by VI2PR04MB10955.eurprd04.prod.outlook.com (2603:10a6:800:27c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 15:09:14 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::88b8:8584:24dc:e2a1]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::88b8:8584:24dc:e2a1%5]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 15:09:14 +0000
Message-ID: <a87c6c13-52da-4ff1-bb10-3065b4622696@nxp.com>
Date: Tue, 22 Oct 2024 18:09:10 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] configure imx8 dsp DT node for rproc usage
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Daniel Baluta
 <daniel.baluta@nxp.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 Tushar Khandelwal <Tushar.Khandelwal@arm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Frank Li <Frank.li@nxp.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20241021155221.112073-1-laurentiumihalcea111@gmail.com>
Content-Language: en-US
From: Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <20241021155221.112073-1-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P250CA0001.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::6) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_|VI2PR04MB10955:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b296ac1-85c2-4612-0120-08dcf2ab7dc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGswNXBtMFJlVThZSk5vRkRLUkg2K2d0Z0VHcnhwL3JVUlFFWGNyR2o5TWtL?=
 =?utf-8?B?bVlKc2QwRDVERlowK2pMMWJ1SElObnJMYWpxQTZ0TTJmS1k1aWNpOWk2QUNT?=
 =?utf-8?B?Z0ZsU1VkeEMvbWNwZnpjbDJPQXlEb1U3elV1NkEvVUZGTnNlRksreHg1WUQy?=
 =?utf-8?B?SUozQ2xuZzNacFk3KythV2hGWjdLS2hWN0pFbTJCeHJVSTVOWU9GWGFXTXNQ?=
 =?utf-8?B?MmljdHJOZkdiMithVE9pWFhCeEVUUjVKTXk0Z1ZRN1VSZXJkS1hiUzdldFVB?=
 =?utf-8?B?czNzTFJwNFJ2emN5NjJpNVJ0OFArMzBBNm9SblhObFBZeVBWWWQzWnNuZm5S?=
 =?utf-8?B?T2NNYWREU25xTENXZmxhOWZuRW4zRTZhUkhlVzAvMkY1YXJXcWxiZTdUVlM3?=
 =?utf-8?B?K1cvQkZJdDVZSzNWSTNjSWtzY3g0OTRPM21lRFlyKzJzcVFQVVV5MjhJeHRC?=
 =?utf-8?B?OHAxa2JZb2JmQUVxYkJrNW0zTkUzSFNGdG9Xbkwzb0JiZzIxT0lEdmpHQUxt?=
 =?utf-8?B?ZXF6elhvaHBtbTMzbnU4NUZyMjVEZzhpQWVKK0p2UVh6aGJXRjZOQmFMamJr?=
 =?utf-8?B?S0RScVNyRGpxOUZFY1RUVHZjMjYvMStJbUFVQW5FRWpSeHk5Q0Jxc0o1d0xT?=
 =?utf-8?B?WmtWMUVKR3poa0RqTHJNOFEwakxUTWhlekF4UzlOSlJJL3NGODE1bmt0UHlZ?=
 =?utf-8?B?b01KZURpR2N5QTBiaHZGYnozaHdsK1BnM3AvcUJaWEJ4WndnQzVlaUpMMThB?=
 =?utf-8?B?RzFoK1lpdEFhTmVvWFZlWTdCVGlYOW4rT2k4QTNVZndVR004M0FVakVuMWlL?=
 =?utf-8?B?Szc3NnNNT3c0SVEvLzcxS09SRVJnamVjWjhOZFh3Tkt3WWJnL1BTTnRGa3VV?=
 =?utf-8?B?NVg0Y3BmRjBxUGFPdUo1aGRWWnlCMkpJZDBQeHAwZm9taGZSOXRKY2dTZlFk?=
 =?utf-8?B?VFlGU2JpRlRxRzhKL1MzZDNnVCtYdVp0NUlKYTZ6QU51Vy9Qa2pManFBTzJq?=
 =?utf-8?B?UWpIVG1sUUxtaml3MHhqeG01a3RxNEJQVll0bFVJZGhLbjVrM0QxelNtYVpI?=
 =?utf-8?B?SEo3bGRDZTNCNVloM25pUVdUckRFdUg1OTdicEFsNE1MeGtBNG5pcDVLL3Rl?=
 =?utf-8?B?NXQ4dHZsVGhhYzFQMm1kcmlNSGgxbGFUUFdBWkJDNGhudWs2V2MvODhieE0w?=
 =?utf-8?B?TkhObzlLZWYyd2tPN2UwSHBiVnNrcnBxZFEzcURseTlHd2dZcWdaWG4wNzAw?=
 =?utf-8?B?d0ZOb3gvNWRPaDhVYXpKTjZpZXhma3VZUUd6enpCM2poY2cxR2xqSXRkRHV3?=
 =?utf-8?B?dXEwbGdjbEdmYVdwTHZEL3JDOVRnTlp5QmV2aGxnQS8yc1RpbGx0M1VSNEIx?=
 =?utf-8?B?NjhQV2lma0NvVEZRYzJPTmdKR1VhUnp6QlEvMlI5SURwdHFkZElhSUlrc3JI?=
 =?utf-8?B?Ly9KVkVHQjZmQzFTK3F4OUpRd2ErSUlEY1ZLMUY1UTZqZWJJZVhxUTlCTXBy?=
 =?utf-8?B?enZNb0c4UGI3NWxVeWoyanJ3cWVWNWhqY0U2cm9SUUhsem5waldrR2pGY0Rv?=
 =?utf-8?B?eWFEZk1URytPWVBqdEQ3VTZNTTRWWnhITkFLRnlMamgyWGUrVVNSb1lRck1t?=
 =?utf-8?B?WEQ1L2M4Um45bi9INUZTZzNYU0JUSmhjbG0yZGRId250T0ZPdjJ6N1pDT1Bl?=
 =?utf-8?B?N0dXY1Z3UTREdzYxMUg4ek1xWDBHbkRVRE8rc1FuU2hibXg2ZW9pRThxRkVx?=
 =?utf-8?B?SmJVY0xYaktDR2ZpdlE0UUYwdlg5TTR0Uy9RSEZFTjVJNmV6Y2FjUzgzVjFD?=
 =?utf-8?Q?HK4cwASgiFOEFOuOpUzupNTWX+C+X/iq0GXik=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bCtmUnIyQTRPZkpiOXZIQnFPRkc4K0RZZkw1RnBRZ1p0YTdwdUlSc1NtWjF6?=
 =?utf-8?B?Y1NwVWZlTy9uR0dNSHVxMXhqK0ZVWkFSOGdlL2VKOVE4V0tYdTBsd1Y5WXlI?=
 =?utf-8?B?bmVOOG1TekZxNDFPT2krRkFzSDBqazg0Q0NnbFR4ZU5BQmYwQkFmT0VLeHJh?=
 =?utf-8?B?ck5qc0VETjZuVHdVUldqRHpNSHlkMmJoZzAyNzZKTXZuMXJQRC8rQTB0Q21P?=
 =?utf-8?B?VEdxVDAvZlFoQlNqYS8vcVpLcTYzQlh4My9sNklvSkhmc0RQcmRzSHVtczBa?=
 =?utf-8?B?bnFFQjhMNWh5dmU4TGluQVRELzc1UXJKWk80eUxRRDJGRXJ2amhsN0ZEaGw3?=
 =?utf-8?B?RnEyTWl0WHRTbjRZWXpUM0p6V0RmeGMveUZqa2VlQVpzRVBOOW9YTm1aTHV4?=
 =?utf-8?B?YzBCRzBwU0YwV0Q4a051R2FiUnRjMnh5ZXZvcHdGZTNzMWUxdDVBbWpjOHBr?=
 =?utf-8?B?RGllV3B6QkZKRUlVRUR4RWJaTXF0MlZWNXIreVk4eENkblVLR0thRlJJcjdu?=
 =?utf-8?B?ZE5ybG42eDJJelRpVXMzTDVlMW40RHM5K2dHeVZCWHAyYjNsUHNSNCtoNE8z?=
 =?utf-8?B?RFcrd2NTMzk0U3FVVXJYbDdQc3pUVXdtWFBBczFlYUdoOVozb0o2Zi91NXNU?=
 =?utf-8?B?d0hscU1CSDRteG5XdW9hUWtOcElmVnFscWJPQ29NMUZmaUZnVklxU1IyeDVZ?=
 =?utf-8?B?cloyQmVIa094YmV2dG0veUlodU5PbmhsMEUrZlhyTXhvbFJ6Smp5WExOTW9m?=
 =?utf-8?B?aXE0VUZXNHVNQ2szTG1sYk04enVRZmhXRm1VbVhmMm4wbVVVYkowb1cvUDBY?=
 =?utf-8?B?RFhWL1ZjVnNUbEN5NDVMdmI4MHZBaml1bFBVL1RlcTc1NlZuU0ZENFY2dlBE?=
 =?utf-8?B?NzE2a2VSSWFPNW16anRBYWpsdmp0dW9XRitLY3dweFl1UnpSdGNMM25EckdK?=
 =?utf-8?B?VFFiSjZjYWlUeWFEN3pCbWozc1ozeEZ0UmdUTjVWWHk3N3pYU1dXVXZJZFdK?=
 =?utf-8?B?SGI4U29PdzNna1NZY3Z5bUN1ZE0vdGI0RmhCMGhBL29zcURTejJwcDlnZTVI?=
 =?utf-8?B?V083UmNoRGJhRjNab3l1blVQMlJEa3pBQjU4WHZIOE5yWHl2WXMrTXk2TWxK?=
 =?utf-8?B?NXdlaHJxY3ZPVXdNcFFGeWVPTm0ya0laK1RSWmp1a1NNdmczaEtra2N4dzVq?=
 =?utf-8?B?ZXNQRnZXNHVyTTUvR1g3QmFvK0lwVDYraGw3cWNLSW50UjExVkVZRGh1QlJ0?=
 =?utf-8?B?SHNINEhrRmY5Nm5FSFphVFM1TVQ3VFRlSmRjSnNWclJaVXRHOUQweHptcUF5?=
 =?utf-8?B?KzZBd1VTMDJGZktaUXZneDZzRUwzeUdwSGZUV3ZmR25aVEZuVCszR2pWQytM?=
 =?utf-8?B?Yi82TWdvQ1VwcGxzMHNPWXR0b3lmY0o5UTU0QnVLRDdDa0FvME9yOEEwZWJx?=
 =?utf-8?B?NXh3dVNGL0N5RUZwYkpIS3p3bzRDUWdZWnIrcFBXRDlyWU9zcExXaVFGYWxZ?=
 =?utf-8?B?YlcwbndEQVRHWGFiK0I4ZkJNZ25zb1BrZnEreGM0N1JrbG9EcUFwMy9YdVZC?=
 =?utf-8?B?MGMvSnMzSkJhd0ZEUlVJVzNwdzNnWWIxTGxpTmhPYnpjb3RXa0IzYW1zWk12?=
 =?utf-8?B?Z3Z3UUNtRElvbTZ6b2RIa2c4Ums4cHhuSmRhdWM2RjBIZ2pzS0hMNXZpQmdp?=
 =?utf-8?B?U1kyZ3E2dEVIV1pxRzFCT3JLbmZPZVNHQ2F3OVgvMUgvcFN3bjJLWmhSVURG?=
 =?utf-8?B?VmNtcnFTWkpkeXZ3QlVPUzJrUHM0UUsxL3Z4VTdXRDg2ZEtyaEZNbnArQUpS?=
 =?utf-8?B?QnVKQStUd0dFOWNkVUU2SFFOQVZwczBsZ1dnN2QrVFhRdjgxM0w5N0lEbnZt?=
 =?utf-8?B?c3MxWUhtdEZ5MmtZWE41bVRhY3h5WDRPQXBiNng5Yy9zUnFFYTVwOWE1Q2dr?=
 =?utf-8?B?TGkveU5JUVVNTmJqZVJKUWIvWElleUlSM0NNdXJzV2NJVnU4SjJUUHVvNGlU?=
 =?utf-8?B?WEF0bVJCcXNOajc0MlNPL2xEaEpCaHB0VXhhN3A2MEkyVnZjem9LcUxNeThr?=
 =?utf-8?B?YnJaN3pvNU5odmRNaGM1U0RJSHdpYk9tZkdrNFlCT09iYTh4QVM0a01WTm5F?=
 =?utf-8?Q?P0ml6D2O10xLCRYckOk6PGsnj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b296ac1-85c2-4612-0120-08dcf2ab7dc7
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 15:09:14.5106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PhReirXDXrbUzFVjkMbkmhHMK0cRYeoX4G+YW2GZLnh8rUQ1uhDEVtGNn/UK3VrtAguAoz1DlrIGt1aR3Z0QZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10955


On 10/21/2024 6:52 PM, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> Configure/add imx8 dsp DT node for rproc usage.
> Additionally, fix number of power domains from the fsl,dsp.yaml binding.
For the series:

Tested-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>

Thanks,
Iulia
> ---
> Changes in v4:
> - Added Krzysztof's and Frank's R-b's.
>
> - Wrapped DT commit messages to 75 chars.
>
> - Placed 'mbox-names' after 'mboxes' property in 'vpu_dsp' DT node.
>
> - Link to v3: https://lore.kernel.org/lkml/20241011150439.4027-1-laurentiumihalcea111@gmail.com/
>
> Changes in v3:
> - Moved handling of IRQSTR_DSP PD to fiwmare side. Now QXP has 2
> mandatory PDs, while QM has 4.
>
> - Dropped the optional PDs. All PDs are now mandatory.
>
> - Dropped Linux implementation details from the binding's commit
> message.
>
> - Renamed reserved memory nodes to generic "memory".
>
> - Split QXP board and soc DT changes into dif. patches.
>
> - Dropped comments about SOF and rewrote the commit message of the
> patch that modifies the 'dsp' node from 'imx8-ss-audio.dtsi'. Hopefully,
> should be more clear why the change is done.
>
> - Squashed arm,mhuv2 binding changes.
>
> - Link to v2: https://lore.kernel.org/lkml/20240925232008.205802-1-laurentiumihalcea111@gmail.com/
>
> Changes in v2:
> - Modify subject of commit changing fsl,dsp.yaml to state that the change
> is for fsl,dsp.yaml
>
> - Fix issue with arm,mhuv2 binding found by Rob's bot caused by the
> changes to fsl,dsp binding
>
> - Improve formatting of commit messages
>
> - Link to v1: https://lore.kernel.org/lkml/20240918182117.86221-1-laurentiumihalcea111@gmail.com
> ---
>
> Laurentiu Mihalcea (6):
>    dt-bindings: dsp: fsl,dsp: fix power domain count
>    arm64: dts: imx8-ss-audio: configure dsp node for rproc usage
>    arm64: dts: imx8qxp-mek: add dsp rproc-related mem regions
>    arm64: dts: imx8qm: drop dsp node from audio_subsys bus
>    arm64: dts: imx8qm: add node for VPU dsp
>    arm64: dts: imx8qm-mek: enable dsp node for rproc usage
>
>   .../devicetree/bindings/dsp/fsl,dsp.yaml      | 31 +++++++++++++++----
>   .../bindings/mailbox/arm,mhuv2.yaml           |  2 +-
>   .../boot/dts/freescale/imx8-ss-audio.dtsi     | 19 +++++-------
>   arch/arm64/boot/dts/freescale/imx8qm-mek.dts  | 27 ++++++++++++++++
>   arch/arm64/boot/dts/freescale/imx8qm.dtsi     | 28 +++++++++++++++++
>   arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 21 ++++++++++++-
>   6 files changed, 109 insertions(+), 19 deletions(-)
>

