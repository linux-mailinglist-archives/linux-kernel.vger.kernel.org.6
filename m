Return-Path: <linux-kernel+bounces-533861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915ACA45F6E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC0E01694C3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C3D16F288;
	Wed, 26 Feb 2025 12:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="DpRBgGkY"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEED85931
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740573501; cv=fail; b=NspozuMAv8pzJNd9vpy6/vm31xYN7PprS1JW6jE3Ny+/xLqn5rpZTJYGK5fwir56I6AyUbWs7qUfj2RexipnK6TDY+R6hVxzHYe8xxdeS2y7nWgV4qKNTPGKjNCw5oP7654V05VIFnRzJ4BW2bPjMo/kvZryXnFKJeLICXFDk+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740573501; c=relaxed/simple;
	bh=ylAyA0MFuvHr6l+Xbs2ix4ivfRDinfNmnEpsBYnlneE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rxjp6nMa6XzQ+lXXm/XysVjJzxvfVMpo0Dm27AWOtaeKUtcUAYy/DNWwrMgxIu26AsRr6ePanK6MyWGhxQWesrHdJwtb0p8HSyM8mk+nZ07w/7UIdoA4dYCXWUskeZ9YZ0Rli7aCxiFooLymeV0d3SwqGrYM1ZAxWze6/QBdTIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=DpRBgGkY; arc=fail smtp.client-ip=40.107.22.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQO7By8+bhITxbY2FDWHytZIz/0bkLa/Mew3KhqM5OyIbtOCnpPH5bEb+UnQVmcXFD1JfedXYq6FGHmfiR/55CMBRsj8vilaNwxlM7TAUnCHYLyJ6fyBTaEF/M+L20HRIy6phHKtjUsF+xWgs33uD9l/qOzxsTd/RRa3yQOR4aRQ5l0/i5RQ2e/b4T2S9F3sVYpKCHnB3PKQu758JeiSKVKoLFxFYI58MICScKw24JVKNksk5pdVWAObnj7FPBC/Xr8EkKLh5HLTz61Dy1MlGFYC0WRtZd1t417aPKRIX6E/lu9i48bhuqrPcJWOeWQUequ7caOje2JOtt/zYi0LCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvuzt1LgfD7lshsurbTr+15jFO6jCyn46ulRYyR16dg=;
 b=HDEbXGXpieIzq/8uLJ8OuS2D/ijr2Gjoe0fBAR0vTHZ41ZZpE7ET7uEyGCh2n+u9UMVnFSNibQCmmEpbF0ujRVlUP+FWpJoRI63OkwO1S9X2xfoerIkP6tAOtLTIEjOyZjy7/cHUhWYtS4k4Gao71dhBipU76QrJKGULQzIqpZlgmKNH380IJgrWLnACiswrXCr2nxSMQk3yI1UqEgLjIvYivESSic5ahARIFQfuI2Qq39U1eWGFuVflR+UiVGOdgHcJ0hDvbOROW5eM2MRadrrs7bWaERPNqXZR2qcXgFVc0j350axPDmqv5KZGmSmogL+Q+vIN0C5dxOtWbOJ6IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvuzt1LgfD7lshsurbTr+15jFO6jCyn46ulRYyR16dg=;
 b=DpRBgGkYN2XFJ00FMbBoszEFGkL83YBoWpEw+Nygdfbr+IRsnU9xDXUsE4BddaAeffuR3KH/v1R1xbLpCeJCh3/xT5uh+8ZohXycYYIZshFlr1XWPMplKTq4FCkr280mUCd9s3TfBBZlUB8Qw4hh7q0rP0dEFrSoxkupUQiYQ6U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB8188.eurprd04.prod.outlook.com (2603:10a6:10:25e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Wed, 26 Feb
 2025 12:38:15 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 12:38:14 +0000
Message-ID: <02757b21-7599-4ee7-9f97-247b04ba646a@cherry.de>
Date: Wed, 26 Feb 2025 13:38:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] phy: rockchip: usbdp: re-init the phy on
 orientation-change
To: Heiko Stuebner <heiko@sntech.de>, vkoul@kernel.org, kishon@kernel.org
Cc: linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 sebastian.reichel@collabora.com, christophe.jaillet@wanadoo.fr,
 Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20250226103810.3746018-1-heiko@sntech.de>
 <20250226103810.3746018-3-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250226103810.3746018-3-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0245.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::6) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: 14429453-32c0-4d46-d0a2-08dd56626e5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHpnQmFFb2wrRm4wUDNWZ251anVVV1ludDVRRzFMS1c0NWtEaDh0WjEyNUdZ?=
 =?utf-8?B?R3pGWWN3cUJ6MmhlcFlZeFNPaTVHSTE5WmRUNUEzZHUyQktXSXRNZFdWeUJW?=
 =?utf-8?B?VWxJY2ZvVHEzNTEzbGpBd0Uyd0FxKzZ1TlUzRk1NUUZwTTVsSGRPWjVUcGdN?=
 =?utf-8?B?RTkyY2g0QVBFZnk2SXBOTXNLM2JIbytlTVU2S2ZlL3dUTVBTM01qeWp6L093?=
 =?utf-8?B?aDZIVnZVY3pQNnhwQmRXbGJSYkRXM2UzSlpNL3N4eXkwRUlkY3lUYWNmRDZx?=
 =?utf-8?B?M3VIUXRXak03ZW5uMjNRN0VtT2M5b2d6NkM0Nk5sYUFwNjhyWFdOTUx0d1hD?=
 =?utf-8?B?SDRnZndGdlVMWEEzTXFsN0kwdDFKNytsRkh3SnEwU0VJVVlnSWZCQ1A0eXdM?=
 =?utf-8?B?c3cxd09adGZIeFlNaW9kOU1nYXdkbmFvd0tOaWRoV08vellJWmZQbUNwZU5m?=
 =?utf-8?B?Qy81My9hOC9kcEczaTVhZHBSRUNtd3hXUjNGZ1NIUHVVWUd3dzZwRXJJSGEy?=
 =?utf-8?B?bVJrdTJKWFRPamEzZmZidEpvdmJ5U29ramhERiswc1d2QkpoQklpakxuN1dj?=
 =?utf-8?B?cmVBUVJtaU1jbjNFamZpQkhPc3FjY0g4YnVoRUMyYmkxM1lKQ0tuemt6eUZM?=
 =?utf-8?B?Uk4zb3N0OE5aeGJYU3pjd0VOdEdRUXI1bkVmbCs0bm85QUMraTFrK0gvMndk?=
 =?utf-8?B?WllNc1NtZS9MZEtKclplWWJVdTNvUlhrMHE0eGVkYmZtbm5MQkZvSlpiR0Zz?=
 =?utf-8?B?d0tzZGFyYjFvMThxMHUzek84TXYzMlpNVlVsQmFLWkw3eWM4a2hUSUh3VkJp?=
 =?utf-8?B?Y2pIVnBqZ0JXdThzR0NNR1hkSk5vTG9ibkxlOWFqcDV6QXliWGVnMDVicFpB?=
 =?utf-8?B?bzl4QWxVVm5TS3FoanhnZ3FRTDV2aHNuMnQ2dk53WUZ6a3grMUd1bFlYOG5o?=
 =?utf-8?B?OUpDWWhEVll1aDY1UXNLRG9uRjBFQkFEcGxMR1RVZTA3ZDNuenByMHFNem15?=
 =?utf-8?B?ZW14ZWJrNUpaNnNMaERkL0tTVUZuYithVnl6eHlPVWErNFllbnNibHl1aXdJ?=
 =?utf-8?B?OWtQbUpNV2ZVOHRUNFNJYitpaThiYURYZmN3eXg1QURBd2grMTlrbWdhVCs2?=
 =?utf-8?B?TnVGQll1YnMrcnhobS9zZGhydlI5d0xxL3lqelRjUnVERnlJNnEzNVVOdVEw?=
 =?utf-8?B?UzdUYXF1ODNtNWgyc0FBSjQxN1RPK0ZRbUVGaHNVUXNDREI3bmdwdlNwczl6?=
 =?utf-8?B?K0JXR1RPRXEzdUtaTmtlQk1NdkhWOHNOU0FrTzBnbXVHOUloTGFMemcvdkVI?=
 =?utf-8?B?akN4TnFrU0xkdXlCTmtLYUt2OWNrMms5akpINjJrZFNaYmh2WTVPU0U4SDQz?=
 =?utf-8?B?cHpLSWZGMytJZGxMWWVZYmZpWEpId3AxaWgwV2N1dkQ4cXJRQWJ1SGV6S2xE?=
 =?utf-8?B?bG5jSjNMUnVFemcySzZGZ09RbjgxWmphdkhTb2crR2MwdmlxT0VNb2lHWHMz?=
 =?utf-8?B?aGgzVjJpcVkyUXJTMGFxOFFlRjBOQ2VHNm9XWXRnZ0Rlejc1aHdVSFFTTGI5?=
 =?utf-8?B?em1XY0ZKcmxHK1pKTVZNZHhLeFVZUkc5S2RKWUFySUczQTdybDZveUVZQTRk?=
 =?utf-8?B?TmNPQngzaU1XYTUzeEVVNklzMlV3TEl3aTRZN09vVnJTSk1nODczdGJpdDA4?=
 =?utf-8?B?N0xiK2hSS0FjM0VFY2tORU9BL1RPbUNQMU1xdFpMUUUzTVN2akNkN2lJQlNn?=
 =?utf-8?B?dk51QmVJWnVQVVZGTXVJNjRvTDE5UGQzaG96UWU4YzNuS0REZG5rMk9EMXRN?=
 =?utf-8?B?dGV3d3JVS3d2QnRZNmRBRlozY3lLSUJFS05TYktOVFRpSHI1NlNYQ1pJZm5u?=
 =?utf-8?Q?k9dOCoSJnlhyy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUJ0N0t1YmVsZFcrcDQ2T0RCRFZLRTExWW5kSWNGT0NmdUxVRUZ2UTNUalZH?=
 =?utf-8?B?N21VbCswcEh2QldyUG8yS1hUaXhFUTI1WElPUWZFMkUwck5SaS9naEo2UEVj?=
 =?utf-8?B?Rld4TEJPbjR2WEVIL2I5UXROY3p4WGR5QVI3dURhSUZUK0xrbjRhK0ZTdkNj?=
 =?utf-8?B?a2puQ01XY3MxYjgyVlNYZERiTENrS0wxcFNXd0pJN2JjOVpZTEFVaU05ZTZR?=
 =?utf-8?B?Z1ZheHJHSjE4dk10TDE5Y0xtR0ZPTCtQZ3NxYzVzY3J6WTlqZldzajhQakVH?=
 =?utf-8?B?eXF4dXdXb0E5OXdadFFYb3hKbldGZkNWUS9kWi9CWHg3TVVhOXJ3Q0dSemxp?=
 =?utf-8?B?TnA0MFlSajFUZklGM0RSQzIrUzdIRDJmb3paV2dMMzRQeStldHp1V2lKZG9T?=
 =?utf-8?B?RC9TN1VMS2lzakVOR2szZkVCUjFEenJBb3RiaHd5bjVYU1ErTldpK1Jua1dE?=
 =?utf-8?B?V2swL053ZGRyZHR0Q1gxQVdXdWZVNnBtV3JOSTNYYUFkbjM4dTIwSnJoaWc0?=
 =?utf-8?B?dWFIaE91YTlPWWdGbFVacXNrQkxyY204U3pjSVpadzRhRDVUeE1zbzVxWUZX?=
 =?utf-8?B?Tk5paFMza3Y5MStxVGtmMWVFTUFOZ3dJSkZLbC83TGNiQTZLa084c3BHVlBF?=
 =?utf-8?B?em1SeFlsTWxiVE8zRkVzN3V2OU02cUQxSFA3ZVp4dmFSL085ZEVXR0E2djFG?=
 =?utf-8?B?VVp1UU9IWE5jdVNEcG5mVk1ZNUp1NnFkK09WQ09hb0RRZkdSSUpPSEdJT2Uw?=
 =?utf-8?B?aXBMQTUxK0pDcVR5aVBQaFNvL3hIdGIzaDVyS0swazB6WUxUaC9wbDZSaDJh?=
 =?utf-8?B?Y3JRaTdkYVUxY1NMc0hCOS9hbXl4Smlrak5HMnNjcW1TcVJnWFI1TkdPQml6?=
 =?utf-8?B?LzIwTlBmKzdtYTlZbEZwT0lNZDBHeGNlNmhlQm8xN1hBL1VucGVlM2JUL3Bh?=
 =?utf-8?B?YmpyM1ZDT2oydXBqenhLUk5OUzcrUGRRekhhdk5OcXZ6RklaeVZFcitjNVRa?=
 =?utf-8?B?OHBoK0d0TVE4RzBmc3lkK1ltU2RPYWhWV0RpMW8vNkYwcmoraXo4S0dDUDVL?=
 =?utf-8?B?RG13SkwyM3dqejNwZUEzWGhlQWs3WDhhak56dnduNmlmMFdnRzhTaWREZEQ3?=
 =?utf-8?B?R0toTmVzQWNJenhDTW51RjhHM2FabDNMWDFMRjJxK0R0L3NuSDNab3lTQVBq?=
 =?utf-8?B?amwwSERqR0dibTVjZmtoVDhFanVIb2NqOTdDR3NNWjFEVWdHNDBIZk1CaEQ0?=
 =?utf-8?B?eUVZbDR1K1VvcmV0cGtsZG9lbWFIbGljMURBVEo5M0xRdzM4VGpPdWZCb3RF?=
 =?utf-8?B?bzh3dTI5Q2ZoS2FsNjhGSVRwWHAwRzZpdVVWcVh4U0RXSll6WGwwVHp4K1RT?=
 =?utf-8?B?U3NPU0FBYXlTVUM1WHNFQ0NCY3diVGRYZ2ZDcUZKbVVBZnpYcGsxY1BLOHRC?=
 =?utf-8?B?Yk4xRDZDQWhFVlVkbXlXY2VxVG9RRlMyVjlnSGpRYXRCbEtvUTUrNDZhWHFG?=
 =?utf-8?B?MFArWXp2MjRpaTNiVGFremhETkc3MHZ3bXhDdlFxTnBHbk0xTmZyS3h5bzc0?=
 =?utf-8?B?bjg5V09vblhlSjA1OFBLQ1NmVzIwV1RUdG5zR1RTQ0g5RHQ1STN3T3lRQ2tk?=
 =?utf-8?B?L1BSYm1EVExhQnhiak4yaUhFNDB0cjZIUHYvR0ZEWGR4UVd2TVMzaXFJVmR4?=
 =?utf-8?B?ZFdKNVVwQXdHb1FZRW0wQ21pQ3dFaGorc0lXWEdFbk8wRVB5UEZubUlnelJR?=
 =?utf-8?B?T2pZeWVUVkYzMDI1WHZvYzZ4bEcwdGIwYUp5ZzI3OUFzeStDVGZ2dFJaUnVz?=
 =?utf-8?B?YkQ3cGpwbDNMWEdJZFh1ZzBEMVVvb1F5NG1uMGdRdmQ0bHkzVzlPaU9qL2x4?=
 =?utf-8?B?RklzWWdWeFlyLzRQTnIvaFYrWDBsUlZpelFtcjNYQXA1amxha0ZpV25TTis3?=
 =?utf-8?B?bTFYNXA3Z2RTMVFYU0VZcjhndEpWbStURDJvSHlUVzh1ZERlbUNVbGxXcTl3?=
 =?utf-8?B?NW43TE9sTTg5L2RkUWt0VjVzZ01XaDlNSkRXSWdiODY0UnN4MWV1dEUxMzRK?=
 =?utf-8?B?QjlVNURCY1A2dWZiNU9rWWJRYko2ZEsyZVIvYkhiU2lxakFyU1kzTnFMMEJk?=
 =?utf-8?B?aklodUtXald1MWxmS2ttUUptOG1EY2RZYVMyemhDdVdtR3BvTnZEa1kyZUdy?=
 =?utf-8?B?UXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 14429453-32c0-4d46-d0a2-08dd56626e5c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 12:38:14.8063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ou5p6B665QZx2ts6k8yW4bMsoa5okY9Zs0KLA+kMMSmX8+mSaQbT2b9YzRxhVIL/wG+xfrN5STaenzytxzn1CWwRRee400e5qba+vV/VLG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8188

Hi Heiko,

On 2/26/25 11:38 AM, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> Until now the usbdp in the orientation-handler set the new lane setup in
> its internal state variables and adapted the sbu gpios as needed.
> It never actually updated the phy itself though, but relied on the
> controlling usb-controller to disable and re-enable the phy.
> 
> And while on the vendor-kernel, I could see that on every unplug the dwc3
> did go to its suspend and woke up on the next device plug-in event,
> thus toggling the phy as needed, this does not happen in all cases and we
> should not rely on that behaviour.
> 
> This results in the usb2 always working, as it's not affected by the
> orientation, but usb3 only working in one direction right now.
> 
> So similar to how the update works in the power-on callback, just re-init
> the phy if it's already running when the orientation-event happens.
> 
> Both the power-on/-off functions as well as the orientation-set callback
> work with the usbdp-mutex held, so can't conflict.
> 
> The behaviour is similar to how the qcom qmp phys handle the orientaton
> re-init - by re-initting the phy.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>

Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # RK3588 Jaguar

> ---
>   drivers/phy/rockchip/phy-rockchip-usbdp.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
> index 960cad5b01a9..c07b79da5b6b 100644
> --- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
> +++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
> @@ -1277,6 +1277,7 @@ static int rk_udphy_orien_sw_set(struct typec_switch_dev *sw,
>   				 enum typec_orientation orien)
>   {
>   	struct rk_udphy *udphy = typec_switch_get_drvdata(sw);
> +	int ret = 0;
>   
>   	mutex_lock(&udphy->mutex);
>   
> @@ -1292,9 +1293,13 @@ static int rk_udphy_orien_sw_set(struct typec_switch_dev *sw,

Unrelated to this patch (but may be triggered by this patch?), I'm 
wondering how flip is really handled.

It seems like we have flip store the orientation of the cable, but also 
if rockchip,dp-lane-mux is set to <0 1>. But wouldn't that break if we 
ignore that initial flipped lane-mux whenever a USB-C cable is inserted 
in reverse? Basically, shouldn't a reserve orientation of the cable when 
rockchip,dp-lane-mux is set to <0 1> mean "normal mux"?

Cheers,
Quentin

