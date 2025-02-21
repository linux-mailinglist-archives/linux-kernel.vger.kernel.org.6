Return-Path: <linux-kernel+bounces-525043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978EAA3EA1D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8DEB3BECE0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DC9200B0;
	Fri, 21 Feb 2025 01:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="vGTfQWdr"
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011039.outbound.protection.outlook.com [52.103.43.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECAA1876;
	Fri, 21 Feb 2025 01:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740101622; cv=fail; b=rGNVgrgQzHD864DvclXv/3cc8jHhmNw4Br0WroWDqnSYapeH7TawFglqo2vSbrx5bwUrv7vBRePGCQ6UcUBbXM8fdx4RbxsYNvt+cbKQ8t6640v5N6JpChP8tLAv/9FCgsAuU+nKwGEb0Nd7IdPIFn9GLVhQmyB8ZIY2zVEdc3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740101622; c=relaxed/simple;
	bh=8Yx22f50Yl2M4PViBkxRsQn/jkS/TPKRak2rl/+In9k=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PjT2R15RPZW8kXJpyX9THh22OzsYsy6IjWjHZn+qZ9Sk67idPczCv7RvJsXDeisf6H54iQUqDIslb7tzNyYlbX8p2DqV5KFaP72ZOo/bBnTSvacYBVVEf9/MPqOqld2JcfEoRW3qV1yNTzKhaKRJbf/7nP1jIZz4FXdJeQ443jQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=vGTfQWdr; arc=fail smtp.client-ip=52.103.43.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7kL02LzsEEBn00k6BkfHsU9DgDsZfLVZLFjJ2qVZQe5zkvAuvS2JxM6yY8TIQv9eBoh7xrTrFuwjM5MxGHCwC3TE73HL2nWeR66RRwqoyxg8mbTNzVUe9FaiRmhbkn+CST6Cd08lRdj8lGUscpL6JqIFyPIn4A8MLbqr5yL0OkMi2o7SQ2M8uwahlN1bFwz56M1NvrenNvZnIDY/4Rmp2GT6P1LeI3Qpj+zdv46oZWrLtCHoWyFQqs7uoWwOeK1u0JpXBfw8ozQWAFdmLNCQe91YYMWCwhmBFR0UkP2l00KxODs9jBsobRcvaWKBOh3/rp2j5RC5eY4Yn6IbPsP/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Yx22f50Yl2M4PViBkxRsQn/jkS/TPKRak2rl/+In9k=;
 b=Kel+o9PHWoWvXqQdQL4Gvor/NjWOLd3J9JpkSYpbefVVx0iO1pyBwAZ/Wct8D7/zTg+68bUUYJAntqfE5PaPanB4eWcY7tLPWoQ7kvzBe09ng7kz5zh/yVctDFDfb35ktZ773vyS/R8G4iS/gMRwairstnPYAA5/sA2mtra9InRZ0h9qObm+s9Jg4/bOc5H5GGNpD/OEhkrmQsXOyBDYYoocDH6GCdGrAH+RVsRccxeSOWpLEBK+l96Q6QU18rfp7i2RkJ7PQ8rUstSCSPPa3ddxusSSt0EJ3Hq8ayqZqqZIfC3JlNSknUhNvG3nDONenAbmKJ7BfSVTsNnBw5Bc9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Yx22f50Yl2M4PViBkxRsQn/jkS/TPKRak2rl/+In9k=;
 b=vGTfQWdrLeJ1MGWdEj2CoN5zx6+6hdxFtXI19K8VPMMqPcxK0YL6Yk9cLJQ5ZLCREha0+NPfEKydV+dLNquEN2lra53uytu1FMJZ4QDShJDokRMFkh3DZ+slgnrqWsWRk9kJYroZCumPdV3+XeEUiTDNXumhy4FJ7F+/6sWW4SYPuP1j6VWz0MAsw4cTAjHaXgbd2/Mc4nWRU3WH4B63z99Sza9JrGHGTVFxN46orSa2m5I86Lb09qgD36X+piJVTSrJC/mA0BAM+ZxGh51cb54C41TvmzMyLzktsE1OhgsvVNskA4Jb7n158e+AJiF4aMK07QZXFACDRhgQvR3KdA==
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
 by TYWPR01MB11286.jpnprd01.prod.outlook.com (2603:1096:400:3f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 01:33:36 +0000
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f]) by TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f%5]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 01:33:36 +0000
Message-ID:
 <TYCPR01MB84372ADA424622EB20982E3898C72@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Date: Fri, 21 Feb 2025 09:33:27 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, Chen-Yu Tsai <wens@csie.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: rock-3a: Remove bluetooth node
To: Chen-Yu Tsai <wens@kernel.org>, Heiko Stuebner <heiko@sntech.de>
References: <20250220165051.1889055-1-wens@kernel.org>
From: Shengyu Qu <wiagn233@outlook.com>
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
In-Reply-To: <20250220165051.1889055-1-wens@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------SR0N2wID0zLyz0q4DHW0Geop"
X-ClientProxiedBy: TYBP286CA0036.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::24) To TYCPR01MB8437.jpnprd01.prod.outlook.com
 (2603:1096:400:156::5)
X-Microsoft-Original-Message-ID:
 <adc301b2-a992-4681-acad-f232477abde1@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB8437:EE_|TYWPR01MB11286:EE_
X-MS-Office365-Filtering-Correlation-Id: c356c223-7620-4112-1961-08dd5217c2b4
X-MS-Exchange-SLBlob-MailProps:
	EgT5Wr3QDKyfA/kqhNtxhLoDzMvzACCoHRGRNdR/d7hf+4GkxndAGN8f0z5xPyzXBDe2yBhlRzuR7P9f7g5T+vVJz/5D94VZvn13Xo8QvXJ2xzjbiwrOUFwSWm8YhA1OljRzrPiQvL+himJ7DiDUdqVxLub4s9FVQE6021cRAjFw/A7arG07cc6itSN8Yzn4ETaSBiuq5fH18PY+bxR7jVO2kJpgkxU2JYkHzfLTyCq9a+5VAAO6DV7++SLNKA8AGne678B7isH0L0gCBInnotoUyxHAcZCHmKDmwt+TnZFBkoamNk0huDowe92iN9+PgTNbrbOZK/NYvMXxEvIvED4+CK/ge2GM5Zd+54WwRDYob96vy42m2VXNxtGJQFqgSFKaoO/HgboeB1757All+UvP+LmBdBx+UecOTEu8OghfghzNlFO9UWMUiJw9ZgDZd80QmqGzYfaZlRIyUMUFvEOst34K/svczoJR0IWEmm7smHe6gB9PuAZWwGMHnezsCJdXQnHR6+pqCqMUNXKWWPV7KwWbPvCf26xq5dJoOEMflCbLaGrQnZl3ZcJmgjSrIpXVIlWRrueFZC1DcYuhRzkwGhdy8dep1gMskQssnkYDdhJcDTz5IB2Lr9w+BBbO1lkXzI/11NGdKxSj7DF735Dwzc5omZa5pyE1SRlWyL6b2mbniwV6Yh8055yTZOEoK6Cffs1FeYv3jqYvE8IhoUnFUWXEEws0VRf3yikDoU4=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|5072599009|8060799006|19110799003|461199028|12121999004|7092599003|6092099012|13095399003|440099028|3412199025|26115399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WklUT2x3QzROaGQ5Mmd1Zk41eFJ2VkR1aGVldm1OVWtOR2p2Qk9La1Z5L2xy?=
 =?utf-8?B?STcyM0VsTTh5aHA0dzFMVStMRXRNN25KWjVlZ2M5WjdWbDd6YTFBSGs3RzE4?=
 =?utf-8?B?cUNDWFNJZ3hBZHplYUFXYk01T0MyaXRqOG9lc3RMN0FicFlFajI5QVJZcyt3?=
 =?utf-8?B?RnF4dkoyU05OdlB6Vit2NzFmZXdUZm13aUJFZzlQZ29LSVVRY3hSTWJDZ1RN?=
 =?utf-8?B?VkdNdSsvYk5Wa3UycnlMd1ZGZnIzN2VhOWNXTkRjbEVhNlZUOXI0amFobVhr?=
 =?utf-8?B?L203ejFXcktidU0yVitndXliZG1qREdRcDlaRFFPTTg3TzltSEJNL0RMV3ZF?=
 =?utf-8?B?cVlHMVIvc0srQ0ZsNnR2UnA2L2o5aHN4bC8rUy9wNE1CMzJkNnRYWjh6SVN4?=
 =?utf-8?B?UzFDZ1p4c2gxUVdXRXphdm02V1NYS29TOFlPbm9sUUlPUTVIRkpvak9Ca3lv?=
 =?utf-8?B?U0poQVEySGZiTDF6QkhNcjdubDhYQlFFdmhxenEyNXBMb3FpODhHVyt3Ynhy?=
 =?utf-8?B?L3dFNHVMOC9CdUNiOXZidDhkOUlZcUI1dWs5WnFrdFNHZW5TbjlKdDU4eXJX?=
 =?utf-8?B?UHJtbEFHVlhtWnhleG1uTG5PZG82Mm52RHo1QUcvWTQzNERGMDF5N3AzNW01?=
 =?utf-8?B?Ui9vdjVKMVBCV1BYRzI3djBiakpacmx3cXF5ejRKdlk0K243WlFmOEgrU1ZG?=
 =?utf-8?B?dEt4YWxlMTdJczRseHlyOWVGS2FhVjQwTzZnUGNxNDQ5ZTVnUjdwaVBwelgw?=
 =?utf-8?B?Z3RnNnE0QWd0TCtLRDJ2YllNcVlOSm1ma21CMlFPdjhoZ3FPNmN1ZUJNY25H?=
 =?utf-8?B?UmV4SEJ2YTl5d0JXTmxmU1dCbnYvZ2UySG5BdS9ZR09TMkUxdlhIV3FDb3pw?=
 =?utf-8?B?c1Zrd2JiaHBzc0J1ZnZ2SEI4WS9uR2xBNjRYMUhlTE51aTFZcFcvS3NjcXVH?=
 =?utf-8?B?cVZXbFBTOEV4Sm9IbzR0eW8xR1FvS0RGNEJKcDZRdGhvZGtRWjErVmVIUFNH?=
 =?utf-8?B?SDM3ZFdSRGdhU1M1NkVLWTd6R0xNZVNIaVFVZGIrekZZaG1kRGRMMnpSMElz?=
 =?utf-8?B?ODR2NUxXak0xYzhWTEZETG5od0RqWkZjK0JubzlKbGw2Zm5xdWRKZ3dyZnJ4?=
 =?utf-8?B?bWkyNjBOZ0hicGJ0TjFNUzVOSXNzdEZ1cmg2eUxhczlQZ0tzZS9HWE1CL295?=
 =?utf-8?B?Q0lCMVZ5N1grcmpzazBwMlhleUtHdUVONFg0UzM3SytpUmZPUmdQc1d3cGtj?=
 =?utf-8?B?NDFiaVJacnlWUEdSQ1VsRHMxTjhpc1R2bFZzNHVyU3FCWDZJRnFocjVTb0lY?=
 =?utf-8?B?bURTRTBMeUpWTUhJMjJkcTVYTDJJNWFYNlJ4QlloeU42UzYxNXdJY1dYQlBL?=
 =?utf-8?B?WkhNSkR6OGxkQmtKbE80cXBDQlJiVjhiQ0JuNi9NbDJPdFlEaHhLanYrSjJR?=
 =?utf-8?B?YnVRaEFiV2x2OUVxbDlYTjBuRWpDcFA3RWhCWExXa1VCazF6ZG5VRkxqZkdi?=
 =?utf-8?B?WmsrTi9QVzBES0lzN3NWYVpTMERJZWRGZVQ0WW5vV2Q0S1BHZzZnUHB0b1VF?=
 =?utf-8?B?QUViRCszcXlocjJuWmFLU01DRURIQVpYVTF6dG5valVVS0IwU0dYUCtDTjht?=
 =?utf-8?Q?9RIVHQ30hBMArEsmafmiHM+r/V6XLyQkB+PHNZUCIx4w=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZktzTjBuMUtoNTBVQmQrNFdZRGthcWJsTFV0Tlc2T1Z4WVNUejRkaFl1eWpz?=
 =?utf-8?B?amdvMlFUc2FxTndmSmtodHZUR2NXc1kxTnF4QVkvMkRuZG42UUFKd1h4djln?=
 =?utf-8?B?eFdhYXRrRUF3RWthQmVWVE1DQ2JhYXp2OUI0OVdiL0MvK3hKbGZVMlZwSlNq?=
 =?utf-8?B?ZUlNN24vOUd0RHhYWU1KRXVlKzFBNVoxSytGbDdoUkw0L0RsaUFPTm5qVmNX?=
 =?utf-8?B?dW9sdGxHYnlTaDRueWVFVVdOUW9YbWt1ZzNXZUhudjNuWXRlRThaTmdHNmRS?=
 =?utf-8?B?WmJwZHBDYkxJb2lsZ1g4ZUdMa2pTRHpQTFRYdDlCajdJa2RkTzcrTHBiWTl1?=
 =?utf-8?B?WXBMZkh4V2pDNHU2WklQUzczdzIxNStvRGEzSGJQQklPQVVZbWdKQVZnYXhT?=
 =?utf-8?B?RkVuSWx4QXk4ajVuV0RZd1FodEN3Tml4eWtjVzdSL3NMN29wbE1OaXFCVUkr?=
 =?utf-8?B?UWVHUTliSjlPQ1B3VldobXArWVlSSVhMS2RVWW1hdC9zOGp6b2Rra1VOWHly?=
 =?utf-8?B?aTMrd2VQdjJGTGNQL25ZdkdoN2x1bTh1NEx1Z0hzbVV3NUFnT21TVTd4MG5V?=
 =?utf-8?B?Y2Q5V1lwY2I2MCt0UGx2TmdXWEhHdGdFYkt0WTBDbC92MFF1UjY2NjNxbjlp?=
 =?utf-8?B?WTRHem1zeE9FaWh3cjhKQW0wL3liMFkrN0pXMTcxU3NkVml2WVVoSGkzcndp?=
 =?utf-8?B?NjEzYjVyTW5PRmFvSGdGaGpHVDFsTFJ1RGp0RWh2V0FJU1ltWnlNQVVoZEdw?=
 =?utf-8?B?MXRoN3ZSN3p0RWF4K1ZrakJtUXpiQmZvMVhDSnNoQURVSEhrMVNQcWNnMEFv?=
 =?utf-8?B?bk5LZG9sYVZWNnpGaHVTUDdIYmJBaS90cWttNXRuR2YwaUZUNi9vS1pXbmFs?=
 =?utf-8?B?aFl5TEVYei9lWjhkd2hrbXE1NXB3cTZZZGVxTFB2N08xTXd5cWphTE5tNVZP?=
 =?utf-8?B?NUdFa3dnSUFxdTNvWFBpZW84SGt0QnRmTjNzK08yOVVyNjdLNEE0bTNKNnlz?=
 =?utf-8?B?Nmc2S2VZMkg4YjIyR0Q0eXhtdUh5UU1xNzlLRWgxNSs4RHVNdDVudmczVGt1?=
 =?utf-8?B?Q1NkaWJNbUtqUU1VUXMxTGYrdHpJTHQ0SXEzeDVkczVvbXI3RmlnajJUQUhU?=
 =?utf-8?B?bVI2SVV3WnJ5dkxMRm5JYWxEMzVaODBROGFZaVArUklmclcwaHpMeUI2dlQx?=
 =?utf-8?B?STlMOFRYTCtBMzd5YUc3MFpJWDZKaFo3OHVMUjZnVUtLK1AvQWgwVXF2TDFu?=
 =?utf-8?B?L0xHSXRSOHRsa2gxWUVPWWhHTityNHZmbzBkSmZnMzlxYjcyNDlJbDFoSDlS?=
 =?utf-8?B?N2ZwVGx6TllDU3BBL0hzN3NUMXBBZjRaR1N2VlZDTWVscmRndjNRUWhRUE5y?=
 =?utf-8?B?VzZtREJiejNRMVBlUUZhODdKK3NORDJuSG9lUVlHdmp6ODRIR0lGU1NjZmgx?=
 =?utf-8?B?aFV2QVpGZVJKLzJGQ2NERkE3VTV5RXV1MHZ6Rm5ER2thUlBqcHBBZURrd1FH?=
 =?utf-8?B?VlF1QkUyQk5MTjB4Kzc1NjFUNkR4MGZobFF0NHFNMDlPNC9QV3JnZjFvUkRO?=
 =?utf-8?B?U3N0bVlhRUt1clZBK25jbzBPSzVIMWczT1oyaHdMa1dwUjBBYy9iREFhQjB2?=
 =?utf-8?B?bGNZSy9ZaE5vbG1WVzNxNjk4YWdlczI4NlVFOFBoWHl1QnBQZGxVVnRTbFh0?=
 =?utf-8?B?cVk2RmZOMEpsOHFjOTBuN3RUVmpVWFViMS85eDZFVGN1dVduci9IdTlabzNJ?=
 =?utf-8?Q?xB3S5X+qGQ4Y3UeWDg=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c356c223-7620-4112-1961-08dd5217c2b4
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8437.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 01:33:36.3767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11286

--------------SR0N2wID0zLyz0q4DHW0Geop
Content-Type: multipart/mixed; boundary="------------vSEAK17PxhZYs61ClEQk2Fsa";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Chen-Yu Tsai <wens@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: wiagn233@outlook.com, Chen-Yu Tsai <wens@csie.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <adc301b2-a992-4681-acad-f232477abde1@outlook.com>
Subject: Re: [PATCH] arm64: dts: rockchip: rock-3a: Remove bluetooth node
References: <20250220165051.1889055-1-wens@kernel.org>
In-Reply-To: <20250220165051.1889055-1-wens@kernel.org>

--------------vSEAK17PxhZYs61ClEQk2Fsa
Content-Type: multipart/mixed; boundary="------------cHQlD1YmbVVfYlzvcO34GtgB"

--------------cHQlD1YmbVVfYlzvcO34GtgB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCldoYXQgYWJvdXQgYWRkaW5nIGFub3RoZXIgcGF0Y2ggdGhhdCBjb252ZXJ0cyBp
dCB0byBhIGR0c28/DQoNCkJlc3QgcmVnYXJkcywNClNoZW5neXUNCg0K5ZyoIDIwMjUvMi8y
MSAwOjUwLCBDaGVuLVl1IFRzYWkg5YaZ6YGTOg0KPiBGcm9tOiBDaGVuLVl1IFRzYWkgPHdl
bnNAY3NpZS5vcmc+DQo+IA0KPiBUaGUgQmx1ZXRvb3RoIG5vZGUgZGVzY3JpYmVkIGluIHRo
ZSBkZXZpY2UgdHJlZSBpcyBhY3R1YWxseSBvbiBhbiBNLjINCj4gc2xvdC4gV2hhdCBtb2R1
bGUgaXMgcHJlc2VudCBkZXBlbmRzIG9uIHdoYXQgdGhlIGVuZCB1c2VyIGluc3RhbGxlZCwN
Cj4gYW5kIHNob3VsZCBiZSBsZWZ0IHRvIGFuIG92ZXJsYXkuDQo+IA0KPiBSZW1vdmUgdGhl
IGV4aXN0aW5nIGJsdWV0b290aCBub2RlLiBUaGlzIGdldHMgcmlkIG9mIGJvZ3VzIHRpbWVv
dXQNCj4gZXJyb3JzLg0KPiANCj4gRml4ZXM6IDhjZjg5MGFhYmQ0NSAoImFybTY0OiBkdHM6
IHJvY2tjaGlwOiBBZGQgbm9kZXMgZm9yIFNESU8vVUFSVCBXaS1GaS9CbHVldG9vdGggbW9k
dWxlcyB0byBSYWR4YSBSb2NrIDNBIikNCj4gU2lnbmVkLW9mZi1ieTogQ2hlbi1ZdSBUc2Fp
IDx3ZW5zQGNzaWUub3JnPg0KPiAtLS0NCj4gICBhcmNoL2FybTY0L2Jvb3QvZHRzL3JvY2tj
aGlwL3JrMzU2OC1yb2NrLTNhLmR0cyB8IDE0IC0tLS0tLS0tLS0tLS0tDQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDE0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
NjQvYm9vdC9kdHMvcm9ja2NoaXAvcmszNTY4LXJvY2stM2EuZHRzIGIvYXJjaC9hcm02NC9i
b290L2R0cy9yb2NrY2hpcC9yazM1Njgtcm9jay0zYS5kdHMNCj4gaW5kZXggYWM3OTE0MGE5
ZWNkLi40NGNmZGZlZWQ2NjggMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMv
cm9ja2NoaXAvcmszNTY4LXJvY2stM2EuZHRzDQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9k
dHMvcm9ja2NoaXAvcmszNTY4LXJvY2stM2EuZHRzDQo+IEBAIC03NzgsMjAgKzc3OCw2IEBA
ICZ1YXJ0MSB7DQo+ICAgCXBpbmN0cmwtMCA9IDwmdWFydDFtMF94ZmVyICZ1YXJ0MW0wX2N0
c24gJnVhcnQxbTBfcnRzbj47DQo+ICAgCXVhcnQtaGFzLXJ0c2N0czsNCj4gICAJc3RhdHVz
ID0gIm9rYXkiOw0KPiAtDQo+IC0JYmx1ZXRvb3RoIHsNCj4gLQkJY29tcGF0aWJsZSA9ICJi
cmNtLGJjbTQzNDM4LWJ0IjsNCj4gLQkJY2xvY2tzID0gPCZyazgwOSAxPjsNCj4gLQkJY2xv
Y2stbmFtZXMgPSAibHBvIjsNCj4gLQkJZGV2aWNlLXdha2V1cC1ncGlvcyA9IDwmZ3BpbzQg
UktfUEI1IEdQSU9fQUNUSVZFX0hJR0g+Ow0KPiAtCQlob3N0LXdha2V1cC1ncGlvcyA9IDwm
Z3BpbzQgUktfUEI0IEdQSU9fQUNUSVZFX0hJR0g+Ow0KPiAtCQlzaHV0ZG93bi1ncGlvcyA9
IDwmZ3BpbzQgUktfUEIyIEdQSU9fQUNUSVZFX0hJR0g+Ow0KPiAtCQlwaW5jdHJsLW5hbWVz
ID0gImRlZmF1bHQiOw0KPiAtCQlwaW5jdHJsLTAgPSA8JmJ0X2hvc3Rfd2FrZSAmYnRfd2Fr
ZSAmYnRfZW5hYmxlPjsNCj4gLQkJdmJhdC1zdXBwbHkgPSA8JnZjYzN2M19zeXM+Ow0KPiAt
CQl2ZGRpby1zdXBwbHkgPSA8JnZjY18xdjg+Ow0KPiAtCQkvKiB2ZGRpbyBjb21lcyBmcm9t
IHJlZ3VsYXRvciBvbiBtb2R1bGUsIHVzZSBJTyBiYW5rIHZvbHRhZ2UgaW5zdGVhZCAqLw0K
PiAtCX07DQo+ICAgfTsNCj4gICANCj4gICAmdWFydDIgew0KDQo=
--------------cHQlD1YmbVVfYlzvcO34GtgB
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
scUnWnv8sErY943hM8MUsMQ5D0P2
=3DUrys
-----END PGP PUBLIC KEY BLOCK-----

--------------cHQlD1YmbVVfYlzvcO34GtgB--

--------------vSEAK17PxhZYs61ClEQk2Fsa--

--------------SR0N2wID0zLyz0q4DHW0Geop
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAme31+gFAwAAAAAACgkQX75KBAfJsRlu
rBAAomyKR39lshCFUsEGJqCxyKP2aoOeU/btxkq5/kp75GInWLYUsDfFkiGuHN2qtrvjXRZTYfpB
K6eWlfl1uNNddFO/xRxFXDEOm53yqot5y+7dUb+4f84ndVFN3OQFxK4V8lvf+CPKDPnmLvK8mJRy
vUm2TkOPXLV/z59SYrQ+rI3ZmNTW6bDlRhTqlrQqfMQNXw4SdI8gtrtrQ4aEQbd7mmax+RGwzUqj
9zAW3iRfbKeIAtpvr6WuFh4joR1OTGW+61G/xZEDdZTPHpvhu8wQI8Pnev9F+t4SDJRRHEhmJbav
97WhH43WqCbSFvzzK0w9jnca7+2G7i7kWi3SjW10nyeKraglqQxYVDMmyNOvD2Vokh9kJJbbRaCW
b56CQdR4SIZVFVcEUi7USREbmdo+WKe1RMuYi9u7M/eSeEFoZiCPEojWFu+NPtxCI9Mub2vu5ccP
Sd2zHM6fHMld6atoaKMWA89tUSjWBW5B8Qnihm4VV/TFE7o4xbQPvBadmv8UlEmbZ1C1kleY4EKa
M5l03ESYAb52J1cA93NBYtnKiNYZMI7/Dq2J2BRmcSJzglTzULqhPqX3X1S5uZqIZ3SFsb6jo1F9
x79ykkZOKOawrDrKPWqfWrtiDqVLAHxJpmixFjVdJBFlp6NPGoKlwm0Bo7mu/6J/iWpKNgBsH6YM
lks=
=w1YP
-----END PGP SIGNATURE-----

--------------SR0N2wID0zLyz0q4DHW0Geop--

