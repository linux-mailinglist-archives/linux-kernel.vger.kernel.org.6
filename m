Return-Path: <linux-kernel+bounces-533936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBB0A46083
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00EFA178A40
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F6B16A395;
	Wed, 26 Feb 2025 13:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="S1SEYfpR"
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012021.outbound.protection.outlook.com [52.101.71.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DCF7464
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740575863; cv=fail; b=WqsxOIyJ+lSoRk29dEpFxESbnOspKJsQWXQvZUgzMIYBc5Xu3Ep/dziDGl0magZSUg0zDwGdjeIVjegrWB9oplIHXkuQtDQWm+Ifxw4CMnpRfNZBgwSoHf+bT5tx6aXlP9mpj576i+QNFs1cV9T5xKHg75g1vujiEp6NrF3lp34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740575863; c=relaxed/simple;
	bh=0mgVu0GbZHhYWLwsb9cGNCvcZ4ls83burBzMHEr21R0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uWYfTIA08aVWe5XBkycNclG1HiMBeUOONUcxoUlAsjxJW3Szplq6oNF7lT18t4bOA32ZrQENAjlgJaDT1Ou0g8p5IL2J7BpkcCO0CWD9Zr1HrIui+n8hvHsvEFFKpgxTPlN0s5Il3DCMiOXc+zbmbMglCHC0CwOPECPYG43XVME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=S1SEYfpR; arc=fail smtp.client-ip=52.101.71.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMA7xzIWZfTWQE7Vkm+YeZpIOLbKwyPEkTR6NG6VrPLHqTOotfjBsTdkaaLBR/dN8ktuik5yw4Fy7M6oDosknpIUCPvnmSwsPWbNhkB0mLCZF/SCv5PZKBfsZKwF3NM2GfvgaD5R515sM4qbpCmCwJFY/UDqsE8KZqBz4wACz2p5eEFWB7g4KOukhb65ivviuRrqy7GR+vW23qjRjkMjRvPVab0xbXeWyQdridQivya3mfmT18IL3q6mL+QTu2FYruJvMrD8oKW62MA83tbe5mTAqTCW4i1PqLRAZjOLHGqaRfO+dHaBzLXLqpU0i7L9DrXwU4pPTDS39Wo/zWhspQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uq4KSK6FZXmvcHxN+b4zX0wlOF3CDvoeIpAE5+k6YU=;
 b=gaK1cO61ha4oq2w1qiHC5gMeBauKvCb+2pffhC8x3IpYFzNFfK4QOwDZcVNLzuj984agd4+SZCTnuIvkpHp73EMQpgU96HeRbLR6KeW0r62esZz/On1JxyWBqelTRdwJ4B+Xorhm6M2TIfoHLtiGei2UhGIVGJA69M4mGnoA9Pl4zXCd8n1D9BiVo4LPWG0qipcuJmdcfOnK12qn0X5VK2m6iAwpkf7Sri12lhtcFO/oMxxKH1RXznlAD9pzZvQ4MtSJYtCQyUMGfuF4nC3zOy+2+Bpqs8yLvfJ5wB1zxcODBH9oJYDpMpxKU3Gknm52l7y9O+uv91uGIB+8JB+TPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uq4KSK6FZXmvcHxN+b4zX0wlOF3CDvoeIpAE5+k6YU=;
 b=S1SEYfpRx/HXStIL3v6KmI74uAM9a7jvsP565pE3tS6MmEmqoPRx4llN3vff6WiM4lCn7vhPj8fCV559RyekdwFV2OmfpU6P+UZa54T9MaYQLCbJCXTF5+beHdhq4Bb/M9RrkY1ItG83eLyD6njyGkqIBbdboQM0do9o11nHLzw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM8PR04MB7875.eurprd04.prod.outlook.com (2603:10a6:20b:236::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Wed, 26 Feb
 2025 13:17:38 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 13:17:38 +0000
Message-ID: <28a16ca5-42f7-4aa1-9bc7-fc6b72364556@cherry.de>
Date: Wed, 26 Feb 2025 14:17:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: dts: rockchip: add usb typec host support to
 rk3588-jaguar
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, lukasz.czechowski@thaumatec.com,
 Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20250226102507.3743437-1-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250226102507.3743437-1-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM8PR04MB7875:EE_
X-MS-Office365-Filtering-Correlation-Id: f52d426d-1187-4927-f23e-08dd5667f0e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXdrVTFLejBoUytyNnI0RHVZdzh0aXlaZXRpMG1mUVVnMzkvcGh3dW1LZlpE?=
 =?utf-8?B?bnRqVDRGRmJ1WnBWblpJbkY5ZFBDd2c1QXBoOVgydUl3cDZMVWl2OUtxSWp0?=
 =?utf-8?B?VnVFaDB1RVJTQ3doTXl2eEtoU1dBQkkvTjhNdUZXRmsrUlFIUVI2dEluWHpY?=
 =?utf-8?B?QTFyWjVpSXBLMnpXWjMxNHBFbitSdG1NdVhNS3A5MlQ2SURHeXlwcDNhM2pk?=
 =?utf-8?B?QlIySjJMUXZQd1BjR1VZc1dZSTlTWHUvVm0vV3EzQ1Uwd1BIdURjMXFqK1lu?=
 =?utf-8?B?aXdTKzI0Qk9xNjJLZ2tuTms4c1RxRWVDdGNSSE5tTUp5dnEycUoxaWFRY1g3?=
 =?utf-8?B?ZTExSzFWdTVRMG90b2JROVdrNDAxbElDbVBXM3JrVUxoK2E5c1J1N0I5WG1w?=
 =?utf-8?B?V2ZDTkRRRHQ1VUxFNDlFQlRrMmNzSkVIcURmQWJ0QW95OFh6VnJyRW1PdGln?=
 =?utf-8?B?OUFsNldpOXRFYm03L2psUEo5bjhSMjFjRVd6blVlMnVudXJZYkFQM1RmVGs1?=
 =?utf-8?B?dnlEcFBLZTcxWFB0ZkhkaWhVcVI3OTY1TlNCSDRheFJVenVNejFVWXo5Q252?=
 =?utf-8?B?bEYyM1lNeUlsZTRUYTYvd0FQYVZ5Tm96b0lxOUxrYTltRDFxcFVwR1FlVGNo?=
 =?utf-8?B?aERHT3dhZDBaS1JMQSsxNHN2NWNtaWFYejRScU5XdytnZ0VTQktRaGJodGJY?=
 =?utf-8?B?UnRvdjV1RUNiekpHdndQMVZDUkdTaW01bUx5b3lBK2pXTzBOZnpXTDc1YkRN?=
 =?utf-8?B?bGdTbEx3anlHeEo2alhjbCt3NHNxb0JOcmhGTkxkb1YvczJxYVhrRnBNcmZD?=
 =?utf-8?B?bmxYNjIrQ0dhcWh6TE9jdTY0TkRLV1pnYklFMkJwWDYxV2g3bjRXZTA3VkNn?=
 =?utf-8?B?R0hhV2RVWjY0UFNhMzdaRkJpNGp1dFAxbE9hWFdydDBCdWlMVkJaZXlRaG9E?=
 =?utf-8?B?S1Nra09TRkE1TEc1b1NZTGpHZHg3ODZXSnNZYWxObjM0V2FhMVFkeUk5OXJ4?=
 =?utf-8?B?NjlrT29HL295VXRtenF0eHpCbDhxdGIvak0xdGNCRDhCa1VhNkxKYjJNeVZz?=
 =?utf-8?B?QmFnRFcweUdJTWdyUnc0bFgyQW1KclluWER1TENNTHJ5Mmo1eXcxMDMxbE5j?=
 =?utf-8?B?L1hCYUJEdWMxUWoyZ0d5RHgvdVpadnJvWG82cjgyRjRWbThyMGU3VW5DQW5X?=
 =?utf-8?B?MWlzSFZpRFNTazFjdktCNmRWOHNna09RMGIvYm9TMGExbDIzSmJ4V2dxYmxG?=
 =?utf-8?B?RC9TNTdCSFAxTFlPMk5Vcm5nS2Q1R0NycEJOTnNFK3YvNmZtKzQvYzE4ZU8v?=
 =?utf-8?B?aTB1Y2RwUTQzWnk2bUFWbzhOTFBmbVlOREJnUWJLWU44NDdVdHJBbk8xeUpl?=
 =?utf-8?B?VG9aWlFlaDJ0ZmFpekV6U0RkN2EvOWdXbU9RTFF0NE1MRzVsNUhpaDFYZ2tT?=
 =?utf-8?B?MHVYK2RncU1qdjJtOGJBQnRvcFN1bjJ0MHRLNzNUemFVem5FV0VRYmkreXJC?=
 =?utf-8?B?WkQrRmlkTnZ1NEd0K2w3amwremdZWlo1ZFNadFJYUG5TKzI0eFM4MUV0RTJX?=
 =?utf-8?B?UW8xNVk0dFdKU0ZjbEswTWVzRVNHRGdFc2cycTNvdllFRGdEdFdJMEs2VjRR?=
 =?utf-8?B?emNrVm1kc0VxQzFBN3B6d0VpKytremp3Vm9FeHVyOFVmUEVzRWpvVHBXSzk0?=
 =?utf-8?B?YW5XMTRYWG5nZThhZmZjOXBYakMzVm9yaEVCdTV2bk0zdkN0S2t4UzRGdGU2?=
 =?utf-8?B?ZUs1dEV1TmJBY3dLcUg0WldoSlVCQ2x2b1p6VUxWMW9SRDlraGkrUThVWVRt?=
 =?utf-8?B?V3dTMkNkbE1QbGtIK2pXdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlZOMEdLcGxRaElwS1RuQk1BK3gxN0ZxU2I3RGh5TnRnU1ROV3d2Zi9jcGhk?=
 =?utf-8?B?YW9xWHJ5Nk5JbzFVa2NxOU9KK2xGU3d6bHVlZ3NXWDJDazNJNVJSKy9GbmEw?=
 =?utf-8?B?UWtJNDVVQSt4dG8wUnZqZUlNQjBhUjJ2RW8xZVZtNTVBKzNvdzZ6Yy80Vm9j?=
 =?utf-8?B?eldoeFpmYzBLZHZIOUs5Z2ROSFZJY29oZXRFaktvcVZpWkZMSFBEaU8zZTc5?=
 =?utf-8?B?TFdwcVNwTmYrSTU4TEV2TXZDTnNZcTI1dkVyWk5aYVVNR0YvRzluZEVnSXhn?=
 =?utf-8?B?Zmh5NWhzRVFLc212VXQwRUdhOTkzamFHWXVmQzZTamd4TzdpcHJhS2NzRW91?=
 =?utf-8?B?MEk1azlzZ3BFdFVCWitxM0llcGw0OGZNc3hSSEl0T2I2SzlXdWlCU1pGbCs0?=
 =?utf-8?B?SmlWVEw4Vy9GeHlsbWE3a1JNNVlXVlNhaEpaZ3FhRjRuMTJOdzZjdWM1bCt1?=
 =?utf-8?B?YTJmNW1OOUpuMXcvTjJFbTNadHNMMkI3UnBTZnZXR0ErYVFNZ3ZMbkkrdy9u?=
 =?utf-8?B?Y1Z3ZFBqbWdybHcwbDBabDM2bEtPQVA5dHFyenJMcjdvS1dMZWVPWUpMK1E2?=
 =?utf-8?B?UzJobzlsQzA1ZWdrTkFyWWJLSWFWL1d6ZVQ0b3k2ZEVNKzFtRUp1MUZhQkxH?=
 =?utf-8?B?SFFyNjF4L1FHNGNhelBLeGhyMzJDN0VhR0ZkWHBiTlNjVkVIL1pGK3BxTnZu?=
 =?utf-8?B?MURXYU9teDdZYUxjNHUvYmVYeFBtMFNWNTk1RkgzWU5sUE9CSzdOYVNpRVVz?=
 =?utf-8?B?UG85OHBWMUs1Z0hNWFo4aER1dHVhZlFZa29BZW1VTVhSZWNPZnRkM3FxZUt0?=
 =?utf-8?B?ZWFjYkhPanI2UnhFdHRDS0tremZMaTYyQlp6TXRmeUMzRVhQMW5JMjN6SUlU?=
 =?utf-8?B?RVBwWTR0V09HRys1b3hjRiswUDJ4MFBBSXYwd0dIcm1zRVFBMEpOTHE2ZzJh?=
 =?utf-8?B?Z1JDeEw2SlVFaWVxcDgvM3RuaGdTTFBGbm5QbGNuNGd6UktlZU5CcHJIakY5?=
 =?utf-8?B?YWk5eTJFZmhLQ3dYc3lGaEZRUHcrYzQrWm5NSmtqNmZqQXhQY3luMEV5eHZF?=
 =?utf-8?B?WjFSSVh6b2hreHh5WnVjMFpPNzJuaUVxWWl5WTZxeXdjRTYxWStvcWRGMlBX?=
 =?utf-8?B?a2ppdFpLcVA4d2NKdmliT3BHMmp0MzBRbG5ZREt1Z280cmFPR0o5SmFFUUkx?=
 =?utf-8?B?azUvMWFxaW10bjlzQVpWOGIrQ0tsekR6T3B0K2NlbiszWGhiNzJlN1VBQUky?=
 =?utf-8?B?bXZJc3BmbjJ3VUhuK1paS0hVazN3RnphYUtNVUhnWS9QRzZzeG1MMnhVYzN0?=
 =?utf-8?B?VFhNWk1xVVBjSngvNlVMaFNoTmZFLzNEMXBJTnd1ckxPNTRDNUtNODJ1SVhr?=
 =?utf-8?B?UHlPTlF6V2dnK210anhzd0Z4Y2FGY3hvazNyVXNnZXY3Q3pLYkN5TjNmUDBY?=
 =?utf-8?B?WitOb24zZDc3YVVlV3RPL0tYWkowdVg3bmw0a3dpeFlqcE9YeUhqL1JxMndp?=
 =?utf-8?B?VWM0RlJxZWNLQ3lUZEI5TUM3R1MrVUlSL2EvaWhxZmZZSlVSNXNVNUFGSjZO?=
 =?utf-8?B?YjlPbGd5bVd1TStlL3FJdTd1VTE0dHRqTm0xYUJSWnh0YlJueUErOTFrT2lG?=
 =?utf-8?B?dEdWQmsrdHlzcG9ZUHA5Y0w0N1VXTU1kTVJGZFhIRTg0Um9VaTVSZW0wQ3dM?=
 =?utf-8?B?VkNSeHhxMEVMd21GTEo0RXZTTEcraXpGUGFMT2NFZTFRMmFObllUcE9tQmZr?=
 =?utf-8?B?V2RNNkdzZnF5RHMwM0hicWpkT0lPejVYMlp1NDhDWmp5ZjdtUFVsMkU3dldB?=
 =?utf-8?B?SEtkQmNZZEFiRHloU2QxdEsxUUZrbytNelRxMWdHYnA5VHhOdzRLT0hUTzY0?=
 =?utf-8?B?YmlpT2E1bitjbnhsM0s4L2pMZ3hNUEhnZ2FPdVV1N2xwUHd1UVg4aHdSMkxM?=
 =?utf-8?B?RmswWGs3NnJKS1B6S3kxaTFhamtQcHdjQ2RoK2pGYkFPT3ZOQ3c5S2k1UmE4?=
 =?utf-8?B?NWdXWXN4T004UjJHMVBBbnhueDhxQU9BZHY2MGh5TkZPYkZEdTNFUEJqOTNM?=
 =?utf-8?B?RTVIQ245TWZBTk9paCtDK3hidXhyWEJWL1lKb3VwRXY0bG5QRHV4Vlp2UGY5?=
 =?utf-8?B?Ky80dnpCcnZscEtibmpTVzR4RWJ4QUtaZlk3ellMV3JYcVRyV2hNSFRZNGxa?=
 =?utf-8?B?V3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f52d426d-1187-4927-f23e-08dd5667f0e1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 13:17:38.1229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tGYaKtYnJgZqdfobD6aKRiLbmxIOWxPwoOZwS3/T42FVJaA0gv0zNirOaDFAGsUTDup4jqiiOErA5gPW2+TYjikYjbeUEWWSNaqSr/m0PCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7875

Hi Heiko,

On 2/26/25 11:25 AM, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> Jaguar has two type-c ports connected to fusb302 controllers that can
> work both in host and device mode and can also run in display-port
> altmode.
> 
> While these ports can work in dual-role data mode, they do not support
> powering the device itself as power-sink. This causes issues because
> the current infrastructure does not cope well with dual-role data
> without dual-role power.
> 
> So add the necessary nodes for the type-c controllers as well
> as enable the relevant core usb nodes, but limit the mode to host-mode
> for now until we figure out device mode.
> 

We're not limiting the mode to host-mode anymore in v3.

I tested and indeed peripheral mode doesn't work. While my ACM gadget 
device is created, I cannot communicate with it.

Maybe reword in the commit log that only host mode is supported even 
though we don't enforce it?

The USB2-only issue I experienced in v2 has been fixed with:
https://lore.kernel.org/linux-rockchip/20250226103810.3746018-1-heiko@sntech.de/T/#t

Tested-by: Quentin Schulz <quentin.schulz@cherry.de>

See below for further comments.

> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> ---
> changes in v3:
> - more review comments from Quentin
>    (sbu-pin pinctrl, comments)
> changes in v2:
> - address review comments from Quentin
>    (comments, pinctrl, sbu-gpios and much more)
> 
>   .../arm64/boot/dts/rockchip/rk3588-jaguar.dts | 218 ++++++++++++++++++
>   1 file changed, 218 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
> index 20b566d4168f..5dbcdf67f0a5 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
[...]
> @@ -483,6 +583,26 @@ pcie30x4_waken_m0: pcie30x4-waken-m0 {
>   			rockchip,pins = <0 RK_PC7 12 &pcfg_pull_none>;
>   		};
>   	};
> +
> +	usb3 {
> +		cc_int1: cc-int1 {
> +			rockchip,pins = <4 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		cc_int2: cc-int2 {
> +			rockchip,pins = <4 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		typec0_sbu_pins: typec0-sbu-pins {

Please rename to typec<x>_sbu_dc_pins as they aren't SBU pins, they are 
pins for DC coupling of SBU as far as I could tell from the DT binding.

> +			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>,
> +					<1 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		typec1_sbu_pins: typec1-sbu-pins {
> +			rockchip,pins = <0 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>,
> +					<1 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};

We're the first ones to declare a pinmux/pinconf for the SBU-DC pins and 
I'm not too sure if we should let them "float" or not. The default 
pinconf for those pins is PD, so maybe we should keep that PD. (For C1 
they are PU).

Rock 5 ITX routes the SBU-DC pins to GPIOs whose pinconf defaults to PU. 
CM3588 from FriendlyElec, Orange Pi 5, Orange Pi 5 Plus and NanoPC-T6 
use GPIOs whose pinconf defaults to PD.

I don't see external HW PU/PD in our or their designs so I would 
recommend to respect the default pinconf and put PD for the sbu-dc pins 
for USB-C0 and PU for USB-C1?

Cheers,
Quentin

