Return-Path: <linux-kernel+bounces-171871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D138BE9B4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4DB528E931
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D29350A80;
	Tue,  7 May 2024 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="RcGdyfl0"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2135.outbound.protection.outlook.com [40.107.104.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD020E570;
	Tue,  7 May 2024 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715100536; cv=fail; b=qo1/L9NmIQp1yPPvCyZV5ZO0acTEiXIEAwQbUgarIv8TBgas8y28GeYc1oMBFaoynchzDaPotuWgjzlfRPkvVm0Ko6ciCQ3jVg3KDzLqeedNPejEhAuLT0ULZMXZZsMh5NJQbTMP309uSMmuf0YotbAHftbqskLss1h/bTOKgAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715100536; c=relaxed/simple;
	bh=2FDyXrJkz2THIKbJysje9MdQW554WILfLGRZJb9mGAQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TetPqtdGLu+xgiCKUkESk5AFpCCqfmgHqZDF+DScy2TDfffPU+jxGkWaXJFbUEU2bh4vJlbTc8wEZTV3gvTVAK1vWJDfu7hrPa+84zcWcyBZOFSLv9jy+D7LZzvSj7Lzn1kkZhWKSS6EwHBEpd4f5Z+6Wrqcz9edsQ6VfZThceA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=RcGdyfl0; arc=fail smtp.client-ip=40.107.104.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXgIVJsQpvHdQgnH1aUPRs/MFpAL/uCHBtqVqahAEkXYK6XnsSCSzXKx71cMljptmyKCAz+f4pCgakpR0wEjJKg6y0W7rubc9Van6FYhJTUnsTEoeQcXTl6oQf8I/u/3673Gig5CYvaDCS01h6UmZC0YGBnUA3rKVIaw0rNjMuhSVtQ07R++VWZnnyLtBftsnWWqwFu0Fmt6FpswXMW8M/MTB4/vgi60puQPIBOCt2BjK1MrJF7abDvGMJ0wbMhKl8rUf2u3oJtghFeruhkuEBe/SgU6mW4ZVCZsGpVOcRR03RJQbtPCT0M10JJhYHZU87VWU+KzIw24JeDvzexToQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlhSSP/WQ2bB9NMi2bb6KferMu8NUk353fiVUfKggas=;
 b=FP7BQv1K8mvgPdc5Bj/W0o8FrxeqWtF+/NOna13QcBqSG+30MfYM2EFCGjH4m7oHnn8KwXqcsAPRYk04p2jkE92UED5TXFMn9QQsc61zqhCbsr+rteqYiNjVwH0cTsesKzMI/2kEZOys1SBOq3BEGu754ovBrQ1hmZIwPfvyrPetahd1g7x9hWvPWIgmkA/v9VaVvcrIP4sVDFyQXN2ur9M4N9z1Dk3s62euoYj+5R6Sgu8F6kULNOksdufkfARJul87cSbZYOfr+Tm/EEAL9BFr54X/ebix8wg+yL0IUsWWvsiPdfnML/RT0UhY106839TTVkz/tbrjy3vaZ3UZEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlhSSP/WQ2bB9NMi2bb6KferMu8NUk353fiVUfKggas=;
 b=RcGdyfl0NJW51Rlktf4cNVA+5V07zu+dj+O62F+ZvlvWHr+IRnB2vob3VoIXKq0fzY5djFq29le5urQoR02iA9SrXFcSttkbMrwzaR6S9ZTH5hVSjVqsp56D3aDgXNglMk901H8Wlw74YdH83eDoFiCcUX05I6aGqZM+UxW2fd8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com (2603:10a6:10:1b::13)
 by AM9PR04MB8811.eurprd04.prod.outlook.com (2603:10a6:20b:40a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 7 May
 2024 16:48:49 +0000
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::ac08:df46:97bd:4ae6]) by DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::ac08:df46:97bd:4ae6%6]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 16:48:48 +0000
Message-ID: <f44c76ac-3dc1-45d6-b435-e5b77b708d6e@cherry.de>
Date: Tue, 7 May 2024 18:48:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: soc: rockchip: add rk3588 mipi dcphy syscon
To: Heiko Stuebner <heiko@sntech.de>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: andy.yan@rock-chips.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20240506124632.3621378-1-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240506124632.3621378-1-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0023.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::10) To DB7PR04MB4842.eurprd04.prod.outlook.com
 (2603:10a6:10:1b::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4842:EE_|AM9PR04MB8811:EE_
X-MS-Office365-Filtering-Correlation-Id: cf8baa57-1ec7-4abc-4b5d-08dc6eb59150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3JRYlhYR0tlcUo5Q3ZBZlRZVVdzbEc4eVlQM3Zma2xqa1oxejZVNzd0RS9T?=
 =?utf-8?B?Z0hzSTNkN21KeVpSbVFaRUcrZzBSNm1KMkNuUExCMDd6Y3E5Rk8rVDl3RDgr?=
 =?utf-8?B?SDQ4M3BIY1NMdldiRlgxVkdHMXZ6ZWdLTnBXNzczZllFSW5FOTdUQTVRMkpQ?=
 =?utf-8?B?amlLVFFtbWJuNWtPc056MUtTY05KSkRzaFY5NW16L24rNU9rOUREaUdXV0ww?=
 =?utf-8?B?dFBMNURVNElZNGU2dXVmU1VSeHdXRzJEcEIyNjRsSUxRRlV5MlhSMm5SYkov?=
 =?utf-8?B?amhnOXpWSWtjMS92b1NCV1VaOGpVVURucnpMaHNDa3NvUUMvR24wZ3B5OG1M?=
 =?utf-8?B?QzkzTjlEVEl3N3A5MDRNSDhXOExycW15YkYxU0c4Mkg2VDlYRkVFejRnU2Nk?=
 =?utf-8?B?bE1QbUp0SGFHS0tWLzM4cWF3SDRTdVJ0dzhsc21aREJIM0pxa2dnVm1GdFM5?=
 =?utf-8?B?Zi9FcS9BRDc5ODZwUGRrUVlnY1B3VGEwd1FTNHgrdlBtbTlzcjh0V1JvblVZ?=
 =?utf-8?B?akVJT2FZRmJMUTNTWmszWDhUcWpCZlBDcEN1aVArQkQzVEdRTmpyY0ZxRkhC?=
 =?utf-8?B?UmVXVzZUaVU4SWtiNFJVaURoKzdYVno5TmFKQjJScG1JUE5yNUIrUG80S2Fu?=
 =?utf-8?B?MzF2TnVaUUNQbzFXKytybFV3K0J2dE9hTlNMZzh6WEo1N3VLZy9wUEczelAv?=
 =?utf-8?B?Tjg5QnpuZlN4RVdwd0hiYk1mMS9TR3g5ejRLTFRrWVhPYUhDYjBrMXJNZDJu?=
 =?utf-8?B?dWFRdnA2Tk1nQjhkTGVlVWtWdEdEelp3aEJQUXJKT0V6Q05ram5CWlo3aEhO?=
 =?utf-8?B?SitvS2pZSWFuNFhhTGw3a0Jrc0I0dVRPZzBzODlTTWJVSlM3ZHFWa0xoWG9n?=
 =?utf-8?B?TDkvNFdjZVpLR2RXS0dwOUpjU3FrOHQ1aGFhMlovWW1qakd6SGh0NkFJdlA4?=
 =?utf-8?B?SVJDdnFWdWs4ZVBVTllmOUVjbkQzZlJUN1RnaUNKSnI4T293eFM0anVVaDdw?=
 =?utf-8?B?b0ZKT0hOU1VVWlpHUmJXZERsTFFRLzcxRGpUdzlleE1wQy9BN0hiUllnTkx1?=
 =?utf-8?B?MEdoSWtxdkg4YjE0RUk3dklRN2ZHZ0thL1lUbE9RaUFPZHJTNWhNeE1paDhy?=
 =?utf-8?B?NGVKSFpoVzBmbUMweDhtS0pMcGVnZStnOS9qR0w2T3ZYYzEwcURYUExmeW9D?=
 =?utf-8?B?OWdVK3c4Z2l3ajU3eTMxdXJvdVdLTVNvT0ltbzNjbGtZdGF4WUwvbEhiWkhr?=
 =?utf-8?B?THF4SkhaQlFzUGN6S1QxcmdLSXN4YVFyZzFQK0xvWnUrbE1UQ1FJclMzMXNV?=
 =?utf-8?B?QTdxelBnMzNwNjBjZGR4c1Z6UnFxTDZuKzhwNnRTMXFqeVZlcEtTY0FiY1I0?=
 =?utf-8?B?RUU5Ym1XN3lvRVRONW5QMXd1K2ZGYytSekZRNTdKYjduUDlISTduVmR6SjBa?=
 =?utf-8?B?dkU1QkMxcS9LVUY1Qk1lcmN2dTdsU0dIQ2NWODJLekdIbzFFNGhiZ1VpTUZ0?=
 =?utf-8?B?dExJUzMwVk5la2pHMTNyZloydFV5ZlNxNTcwOWlqREJPYlU2MUIrS08ydXlQ?=
 =?utf-8?B?YVQ0Y0FpNmRXVWFraXByY2VaTjcrQWdQaTZxMHl2ZVovbzRDSmlWcWNUZ3B2?=
 =?utf-8?B?RGRIVEV2TkVlMXdPdUJ6RDR6eTdMTG1WcjBBRXJ6QzVvZ3hZZWp6MGQ0Ulk0?=
 =?utf-8?B?QWZvRDh2azNvR1dNek1DUG1VL2ZjS2Noc0M3NjNyU05qWlRuemN2YXp3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4842.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkxQS2hJWkRjemo4MS95M3Vsd3Q2RGNza2J2UW5BS0wrRWZhMHRNa2h1WW5k?=
 =?utf-8?B?UXF0QUY0ck15Vk96dWZCSk50cTlmeU5ONHVwMWFRdTJsS1JqYVpXTmZDMm5X?=
 =?utf-8?B?L3FNQmZraGVFME5PN3FxbS9ldHBEUU12SjlrMlpZOUNSV3dpa2hPdU90MWFY?=
 =?utf-8?B?eHE0WnpiaHVuMkZtYlRxdXdGSjBmSUFMeWM4NEt5dlp6Q3QrM3lUeGV6QXIw?=
 =?utf-8?B?QStXUUFuN0NwbkU3UzRSSmNmL1lpZjducEdHVzVJdFhUd2lGbW42T2twb0dm?=
 =?utf-8?B?NEs4RVdFU3gyM24yL2tiZ0VtTUR3ek5ONCtWeVYyQ0VVNDZzLzJWbElBMkJR?=
 =?utf-8?B?bHNHVkNkM2NHZXlKdGhJTzdyRUM1Wk9MTVpFMzUzRlBib1RBMFkvZENDZ00x?=
 =?utf-8?B?bnpkZXhKRTV0NU1mZjlJNjhMZkowalBpSXRNUnR3VUh4Y1RMeEZGellqOFBR?=
 =?utf-8?B?ejRna2VnaldoNUR5WC9MZTVoMmFseE11TlRlNUFaRGJPME8wMEVmUGhVVndD?=
 =?utf-8?B?QWdhb3dpTnUxZHVveGxaVmFKV3d2eC9uSERpU1VWWDk2WjVnRk1XWXNLVGVW?=
 =?utf-8?B?aW9BQzdTbWdic1dqMXlRcVB2S1V1OEdYRGpKQjJhZDNwSEZjdFh3dytXMlh4?=
 =?utf-8?B?TFQ3KzVhbmM1YjV1WEZGcVhCVWU1blhvK2FmQ1ZpczlRVitCRW5WRFlhMURq?=
 =?utf-8?B?cUd6OHJFRVBKa2NEby9LZWp2S2NrdXJaTURLaWR6ZWlHRWdlN1pNOUNFQ3Ar?=
 =?utf-8?B?YURjNTRQV2JsVnVZaVM0M25UUXZsV1hIYXM5L1VwSnBCSktlL0lKc1VKUlRN?=
 =?utf-8?B?ZHpSQ0NIR3JrLzZpMjVPSUNMUi96djduRlFBKzlTb2hlMkx2bHVqaDRIeUJS?=
 =?utf-8?B?a2ZUZGlYNG5ZRXJLRG84dHpBUXR4U2J1czZhMmxwYldjc3d0WjEzRmxScE1N?=
 =?utf-8?B?S1pMYWt2WTdteXliYW5abXBZN1FKY0lUNjZBV0NnNVlXdEtDUmc5eEtxWm02?=
 =?utf-8?B?cVV5RDJNajdBMnVEdjY1Nm1HT21UY00zM0NXTVlqVUpVcENBQjJpelVHYTZ1?=
 =?utf-8?B?MmcxV1ZqM2RYanN1aWQ5ODdKTjdXTFdaUEViaER4YkxxRHZGd2toZnZnZjYz?=
 =?utf-8?B?ay9vbnVjSVNtTWlCMlZiQUlPVThwUmJMMVNHQ2hmM1NOMjlvczVHZU14UjNp?=
 =?utf-8?B?cm9WTGkxend2aFVaVDE4Szc3QlNHK0tVU3BPZW9lbHZsL3lNYnFWWkNKUTh3?=
 =?utf-8?B?ZCtVbFUyQTZEWlh6N01LSlJ0QStQbnJ4NFNkUk1KWFFsL3g2YlkvSmRwczFa?=
 =?utf-8?B?ckxDVGFFZUY0R01tWk5hbUFNTHZqRUJSSG9jUTM0UkFXY2RjYXlDaUZqNEk2?=
 =?utf-8?B?Mlk3VUdwTURnOWcycjVRWkpPN3pDVGhBYVNtVHVROTdxVytuU1N6MS9rT1Yx?=
 =?utf-8?B?N0NEcHk1aUZPZ09LN2UwSDhZMzQxQVY0TFpRWnJCUG9QaXltV2svMWZkWUtw?=
 =?utf-8?B?YTd4dmt1M3ZGcHVEdFR6VDg4TVljN0twZXI3eWlHYjdTTEhZbEdOOWd1Q05u?=
 =?utf-8?B?bHR4VjRCdm1aTVRuTklndXZzN0k2bnBIdjdrL2s2ejU4T29pSFkzb2hYUWNx?=
 =?utf-8?B?MkZiZUJvQnpKRjdzc0dVanNyQWY0WkdMZlZtNzZtZCszU2pUbVN2VEIrY3Nl?=
 =?utf-8?B?RzR6dFRCKzRYTDZmemFOVUtVQ0k1NWVxQWJvWVYzLzdsMHFrazRwK2pSdEJs?=
 =?utf-8?B?ZjhjZVkrdUsrNXgybjM0V3dHTEJYbkhZS3dYbTRNUHk0Qlp2SkNsV09ES1Jt?=
 =?utf-8?B?K0U0bis4eWpXVmhzWUFpWWdzaTBHUkIxTjFsRU1VU1RzZy9xUzh6aExUYTR6?=
 =?utf-8?B?UXR6N3puMkZPSWN5Nk5HeUxJa0l0SkRKSDBHMW1wTkQ1eXB1V1hQOGtHYXov?=
 =?utf-8?B?ZnBXaTVNR1B2T254VVpWYm5VMWhZTTE3d2xOMUtMOFRQbGJPYmN4UCsyMU9J?=
 =?utf-8?B?MUhzc0hCenpxbUVFeVpTZWJqdGx2RDBNNFFVV2JHT2x0VXNWQXd1RFNZcFRG?=
 =?utf-8?B?UEhUc0p1dTVxK0xOWGlSNTNxU2d4ZnJTSGZtNmEyeDFaTzVtUTNIcFl4K054?=
 =?utf-8?B?R2VHWWVSdGpWdkxrR1czSmJncEhOd1grY2xmUVY2U0piejlielZEcVNnaHRi?=
 =?utf-8?B?T3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cf8baa57-1ec7-4abc-4b5d-08dc6eb59150
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4842.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 16:48:48.7938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfbkMbxQvCfEL/P5tZ7w7utd+KFtLqPLrS3GhUScenb4d8qHyXPwrVjvCmPYW+MBK35fY3nbYHeGplM5LfJfwOyBz2hbaJxTdG8+0Gc1lI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8811

Hi Heiko,

On 5/6/24 2:46 PM, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> RK3588 CSI and DSI support requires the GRF for DC-PHY.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> ---
>   Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> index 0b87c266760c6..0131c62893450 100644
> --- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> +++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> @@ -22,6 +22,7 @@ properties:
>                 - rockchip,rk3568-usb2phy-grf
>                 - rockchip,rk3588-bigcore0-grf
>                 - rockchip,rk3588-bigcore1-grf
> +              - rockchip,rk3588-dcphy-grf

There are two. While the TRM states:

"""
There are two MIPICDPHY_GRF modules in RK3588.They have different base 
address.
"""

(ignore the typo :) )

it states the same for the bigcore grf but we have two bindings for them 
in there... So not sure what to go for here? Similarly, pipe-grf has 
three instances but we define only one binding...

So who knows :)

That being said,
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

