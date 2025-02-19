Return-Path: <linux-kernel+bounces-521378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA554A3BC7C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604AC3AE826
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7E61DEFE7;
	Wed, 19 Feb 2025 11:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="XJs1fd/u"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012003.outbound.protection.outlook.com [52.101.66.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D410B1DE89A;
	Wed, 19 Feb 2025 11:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739963551; cv=fail; b=tQmmSjD2N/E5ggM1jjtqs7VkdMAYvbT+ReZt5a9uTjgMgwMvBnjRrAgxzrtVDtznTCV4M4AQQaijwHmguNZQnIpUbrQhXaIpqCj10g0q/8ctA859Rr9urGph5KhdUOIXhUYz7Ve3q81r0b6y2V7VGzv/+dLAgbQsC246Dd9taK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739963551; c=relaxed/simple;
	bh=pn6dKZ1wgHzKhaP072B9x1q9E35wom4OHYK9/tx05hI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TMhhM0jqvUtPecvjFe2aRs6GvDuZYCW4ghwIFYjA4xO4Xgv8T6/wJi91YyZfWp+pMCV9DNpN0O7ie0yP+qZrrpE+WScveP3eEwmgtsId0fma3krjHifmHP7OJhW2RAjF3aOd13gtZ6yQIBRskYFmsi4soarEZ7imjiIVU+4DF5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=XJs1fd/u; arc=fail smtp.client-ip=52.101.66.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rdCHI8qbUDLIETmtsbc3acraexgrZznUhufN4zab89vq9i7VicoJwyaiELRNv4VlLk/NMsyaKpBghoMFT2UmF9Iy0vxDSSznIZ7Qh/LUBgMxemY6nCEkgtV9Kg4FT8oH058Lk0tLzdm3FtIl+7vp9VzewzlrgqGdM6ogLxiIlr/pVk5i3A97aFHhbij/ma0lIbCk4Y/xewBQkDzFrPo4WcbiDn5Z6iNr4BlzYBSRyY+1M3Op880n/aFT0DiuZJherYPFdc1kTfAwssHL34gEZpWflKd4Sowl1Mt1StLLQSbooH8x+nAo2RY+BBjID6OQcuxDa1BA/OukwugmpVPbyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1L9E/7RvbrV4ahhQwBNI7f7Ey1tvgqcvFMXpYuxXGQw=;
 b=C4gqlRd5AZKfzRZ/TdIqH9dRZUMrADqldyMy00xzeaPPKEFjo+Teadiwa8VrCYW0ZGnQmKWkbz0gUouY9tI+Bc3FyqcrGeQXs+x+38Xgs9jQrD67gbSB9KPFTAQJya95cX9WxEcy4kCeCGM0RSQl4BOVQ9TT7KaBV66GBYCyxHxphd4/cwJIVgT+RKEY2uO6Avlum4eAis2Eg/xWmfcPKiEYeJZuY8bWf3IBOOyFTmTW5+Q5YCeinaI5RenBgk15uTe55WDsEabYmnp7ldc7VHfGM/sIzSzcBAxNXZwG8LuO8OYL3WkfxeReUJ2ijCPUNqm3+6hQoNKLSzXU6EgS5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1L9E/7RvbrV4ahhQwBNI7f7Ey1tvgqcvFMXpYuxXGQw=;
 b=XJs1fd/uKeumQ/I1J4FufMOjJv5UPT8jaif4V6JmfAdQHN7byAtw2oLJg9R3aDQLUJxxrlRAXZO0MaEVl3ybV99SbhRomJK175sSmQhBfrZthto+gErD2bXS1kp/nmfjdqXQEMD/CLd2wYtHZ+Vwlemu7hqAwlfI1n7gLSzV758=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DBBPR04MB7530.eurprd04.prod.outlook.com (2603:10a6:10:1f5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 11:12:25 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8445.016; Wed, 19 Feb 2025
 11:12:25 +0000
Message-ID: <24e8abf9-0bb9-4cbd-857b-0842fc914486@cherry.de>
Date: Wed, 19 Feb 2025 12:12:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] hwmon: (amc6821) Add PWM polarity configuration
 with OF
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Farouk Bouabid
 <farouk.bouabid@cherry.de>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250218165633.106867-1-francesco@dolcini.it>
 <20250218165633.106867-3-francesco@dolcini.it>
 <eb5c844a-e726-44c0-a0c1-7796d1a28ec3@cherry.de>
 <20250219103307.GA22470@francesco-nb>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250219103307.GA22470@francesco-nb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::11) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DBBPR04MB7530:EE_
X-MS-Office365-Filtering-Correlation-Id: 55f626bb-f935-4c1d-91c2-08dd50d64a02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVJPQ3VZWHowc3h4NzhjM1VYd0NLWFh3MmhVV2lBU1kwS0pUVFFNZWs2ci9E?=
 =?utf-8?B?aGhDN1luWHZQUUVXa1JUaFpVYmpWUDJNRDJMUUg2VWZ4aHNqd2ZGbk1zeUZp?=
 =?utf-8?B?TFNieWt2SnB4RURZWUVRb2NBUHhSUy9TcFdLNGZoVWhacEFxUUt3ZGc0MkZp?=
 =?utf-8?B?d0llQXhjSTBMdFZBb1VTSWJyd0FZdEg0aDI4anV5Wkl4OHNBZjJmMmRIUElQ?=
 =?utf-8?B?ZWVUR0NhNitQcDVteks4YTl2cldlWE9wditTd1MxZW5UNXVHL3k5bG1haHZI?=
 =?utf-8?B?U3VyV0phL0pqUjNOWU9ad2hUWHRnc1NwcDIzM29mUVRsdGpPVWVQdnVGOGo4?=
 =?utf-8?B?b1B1MGVNa2pSK3Y4Y3llbWRQK1Y3MFRvTXFDSFoybkxya0VUUHE4ZnpQTWtG?=
 =?utf-8?B?ZlgyRGFxb2NEVzd6VW9BNCtWZWM0OWxNSVJ6SWRGUUhlY2FzSHd3QkNjY2lJ?=
 =?utf-8?B?QWt0ZUFkTGF1SkJNVWJlbzEyYkpXeG5nb2lnWExSYTVQbVI1UVdOK0UvTVNB?=
 =?utf-8?B?T0s2dlA1ZDFtZitGVTZaNlRRNkJSUUF0cTZIby9BTjB6bW94Y0lIQVNhMGtt?=
 =?utf-8?B?TnpNNzJrZGxFSWkxR1JZMm01VmovYnZ1WGRyYklYSE9VK1hXd0FNcWVYaW5P?=
 =?utf-8?B?WGEzVkxFZEtzT3FQZUhkZnJZRGlxMzZxQW1jUys2UFdYNHJ2V0paTXdDNTJx?=
 =?utf-8?B?RkFoT1c1bXFCRzl5QkJkWkVoUVM4emxPT1F5UzlISXZkRHh2OWVyd3hkZ25l?=
 =?utf-8?B?VWtDdW1HbDZ6NSt1ME9mb0tmb3ZnU09EeHE2NXEyeWxFM2F3MmNjMmw3Nk1M?=
 =?utf-8?B?UzdBdnV6aTM4UUdndDVYN1FJOXhqYjhuZ2xXdXkyVVRENWR5NmdJVFkxMk84?=
 =?utf-8?B?TittZFhSeW5VOWlVMzFEa3hJaHdwM1hvWFlaS3lHSitMMkJKalE5bzFTeGZD?=
 =?utf-8?B?QXZzK29hdjAyRGd3OXRJbTJpM2wvYTlsQWlOcmgwMXE3T0doL0RwbFpBeXhv?=
 =?utf-8?B?RjNrcUdLYnFzNUpjeXR5dG5vbDFmK01HaVZhUy9uUmNTNTNIakZPSnByamlx?=
 =?utf-8?B?a3Y4R1JQUWo2YmM4ei94dzRSSGlhRGZRUU1KVUFXdUFXWjNrRlRQeDMwczBm?=
 =?utf-8?B?MDRuMDVZbzVHc1o0RElEdG84YUFIK3Uvaklsd2wzYUs4OCtLTGlZTFlWcE8r?=
 =?utf-8?B?NEJDNG8xVGFKRCtQR1dLbTZMNmU4U09BMGl4cXd5eWdySHJPTWpqanhwRXFj?=
 =?utf-8?B?Wmx0dmN4djlNa2JuQzRucS9NUVlhcDZxRDNmR3FEczY0MDlkblJkdSswRzVM?=
 =?utf-8?B?QnJZN013THRjb3FlbnAxOU5lUGxOOUlId3ZwOHQrVldQbkFleWNWdkZMc21z?=
 =?utf-8?B?U21mUGJCVlRsWUN4RldVbE9MS01JdWt2R0d4WWVtSmk5T2Q1VnhhU053UDN4?=
 =?utf-8?B?Y0FtTCtyNXVpci9YNHZtRUVPTVM4UEhtWDRqTE94amh2UVJCZjZybFlqZm9k?=
 =?utf-8?B?V0x1VjhMK08zNWJQTG1XazRlWWFOcGlJZ2duY0xuWFVQaU0yRENJbW0xb0lZ?=
 =?utf-8?B?cFYxRktVTnJodEtCd1ludkM0MHlPeDNvVGU0SkYyUGU4eW1PYXdocGVhTitl?=
 =?utf-8?B?SFpqL3NiMzQzSVRobCt3ODJoUUxWSmg2ZzNsWFE2alBqbWFKUU9sUG9ONmxJ?=
 =?utf-8?B?YTk4OTBaa012YmFVL01qRVNveGNBcFFnWlA5VXZhYTdBUldKM08wSm5OS29n?=
 =?utf-8?B?azRHMkFEeEYzNHptMlJ5YTA2MGwwT0I0OU41SkhnRWZmNWxwVnd5QmR1Ty9Q?=
 =?utf-8?B?cXhySUZrUWpYN1BZbEVDL09VT1NNaFY1UXRhdVNlYnhpOGdxeGM3VTk0eXMv?=
 =?utf-8?Q?9aZ1k35MzAmH2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1kwSW5heWNaNVp5am5JUEhBaG1EeUQxKy9wQjA3cUd5Yk42UmRrRTRLWXRs?=
 =?utf-8?B?Njdka3NUek9lMmE5WkpmajJXMFlwWmtaM3BUM3hMQXdWTlRBeitLWEloeUlC?=
 =?utf-8?B?MGNBWElDTEgyV0p3c0g0dWd1NnhhVG1KTFI2Q1MrVE9QNFZ2MjU5N2c4WjQ2?=
 =?utf-8?B?YndBczg5U3o4Y1VLWUlySWZ4cm1HY3JHRC91bi9IcHJseXAvQ2I3VHJtV056?=
 =?utf-8?B?OWtTMVZvY3duUlZ0ODRVb3UydXh1MEhpcmdtV0ZiM0xpNlhoZW0xNmZPaVBB?=
 =?utf-8?B?L0xLNTlHQ3FnMENKVDRRY1phdjc4d3ozZ3JuLzhKZ3Z4UnFDSklxdTRBcC8z?=
 =?utf-8?B?aW8wN1BmM3NqUm1nY0I4M2lkQ3kzbFdQQ3RvQU93dDJEbU9HS09jS0JFYjJC?=
 =?utf-8?B?Z1R4Vzh0OVpTakVOejdVMUk3THZXTTU5UmJLWmJUdldQWis4dnpOZHUyNzhk?=
 =?utf-8?B?b1hMVkhrM1RtMUhObndtR0tXSW4yVlN1b3REZWRyTkV5ZlhoYlJjdEFsVVFV?=
 =?utf-8?B?UUMwRWtaQmNub3V4QXBwZjlhL3NDWUwySWhaNXJWbHhxY2JrZzk5YzRsYjhl?=
 =?utf-8?B?c1Y1cHVIYXRNLzU5bEV0WklVanA2MTk1V0REbUJBZXlvUFl4dVdMZ3BSMEVl?=
 =?utf-8?B?TzJkNmNKaXp5Qm9qbmxjRHpqL0dYS1RBaXNrQmxJOVBSRzhwV1owNDdLMjFW?=
 =?utf-8?B?d3BFOEJJMHZIei9jT0MrWmUyeGVTcE9yaUEwRDZ4VFNncEpWcGVWQktRSzY3?=
 =?utf-8?B?ZHNWYjgzVWlhV3U4UVlYSitIaHU5ekJ0QVMycEtKK1NDdFRNOVIyM2RjYUhO?=
 =?utf-8?B?OXpPTTlLc2E1L3pkZkpUUWpvR1VZZGY4U0dZcGxIVlBEUFhoZEVkKzZSRDRT?=
 =?utf-8?B?ckM2cmkvM0N0VVQ3SkdXVjg5cTQwaEpESjYzRnFpVXJnOEJXTHkzSjZrcUtC?=
 =?utf-8?B?dGtoNHljMU05dHlMVnNQRUVnTjBNbmJMWDdPd0N2eVlqYjd4VVhHRlFYdXc1?=
 =?utf-8?B?MU9lUWtEMGdWTDRMTFJEL1p3QVFkRENCb1gwYVNQTm52V0g0QWxHbUxmL2dn?=
 =?utf-8?B?WTM0RXZZcVpwTVEwZ1NBNEloS0doOURHdUt1VjJ1aFBIT0dQZzBWY0tlbDZU?=
 =?utf-8?B?QkxGc0hhVGhqQUwvU0RoK1ptSWU0WUJ2WVpXNkxzRXdDS3pRaEtJemROZTVs?=
 =?utf-8?B?MmhTWHV5NlJ1OFlKdVRacWhQM0NLL3J2dlNJL3pXWTF2eVNuWExRTVNGdkVD?=
 =?utf-8?B?MkkwQW5LVXJCVFI4UkphVjluc00vS0ZGTUswanRTRHpUZWNkSnE5QndzME13?=
 =?utf-8?B?Rjg1M2tmd001MGtON25jN0F5bkMxYTNPMVcxQlM5OUo1YnRSNlRTbkVmeVR6?=
 =?utf-8?B?VnZRSUlDa1ladkx2YVZuNmJXYkRwQkNwY0JmdlpGRldXNHQrTnhRYVEvdnVo?=
 =?utf-8?B?UUxZekVYNUZ1U3pCNzM0WjZkK000cWtzZ3B3TU1MVFdrMllKUTlaYkFvTGR2?=
 =?utf-8?B?QUtLeUpPbmNBZEhyQnJrb3V2RFNXN010V20yVWRubit1dFNEbFg5TVluWFMw?=
 =?utf-8?B?K0IrWXJNK0VsTGkwdDI3azBvOXNqcEdia0YrOGlISHp1ekMxRExOOE5rUFl4?=
 =?utf-8?B?enFzeHEzckszU3M4NjZzOXMrODd3MDNNdXVlMXhjeFB4bXF6RDRoRnFESE5Y?=
 =?utf-8?B?cHlzZWtFMndxOVZSSm1ZSWN5Vmw5UjAzSThXb3ZjSGNFRU1lY05hNTQ5dmdQ?=
 =?utf-8?B?MlBnWEpROTlMbzlzVnFCcTIxVlhaNHNScUZXMG5YdnNVNGpkaWNwT2UySzlZ?=
 =?utf-8?B?bzBrVTFFNFFURTRUME45MlNrYVVIUURMRWJHMU9OUmppd0tDTjJPeXdiOElZ?=
 =?utf-8?B?Zzh5ajRpdW5UZjN1L1k3RTNQU1g1ZGRuRDNkZ1VvMGZFNUdMYzdvSS93WWNX?=
 =?utf-8?B?TFlQVDJ2SzlxV0V5VjdKdzFRVVA3MzFLT0p3YjNENXdyaFRpNU5WTlArS0pZ?=
 =?utf-8?B?R2hZek1pYUlnclE3eEVQdmhuWWdvZnBmK2JtUHhmWEJOTG8vRHlqVWJUc3Ns?=
 =?utf-8?B?RCtCbEdyVnR2QU5ZbzJONGJVdTROZGs4c3g0SWhTTkN6dDlaS3VyVi93L09k?=
 =?utf-8?B?Y0dDa1pHbnlCamFEajVMemFZNWVqR2tmZmNacWUwcTZxWWRIbTJ3SUVnN1Bk?=
 =?utf-8?B?S0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f626bb-f935-4c1d-91c2-08dd50d64a02
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 11:12:25.3161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qq37oR3s8xvrarkSHDdZ4tZtLxwiY5XfmeXgkY6Oc3e2ISuT463NOeBdZUiyxfeNhd+PIr0iqoqpTYO86qqIiBkF3gkYkmkWWVDd2eFNX+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7530

Hi Francesco,

On 2/19/25 11:33 AM, Francesco Dolcini wrote:
> Hello Quentin,
> 
> On Wed, Feb 19, 2025 at 11:08:43AM +0100, Quentin Schulz wrote:
>> On 2/18/25 5:56 PM, Francesco Dolcini wrote:
>>> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>>>
>>> Add support to configure the PWM-Out pin polarity based on a device
>>> tree property.
>>>
>>> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
>>> ---
>>>    drivers/hwmon/amc6821.c | 7 +++++--
>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
>>> index 1e3c6acd8974..1ea2d97eebca 100644
>>> --- a/drivers/hwmon/amc6821.c
>>> +++ b/drivers/hwmon/amc6821.c
>>> @@ -845,7 +845,7 @@ static int amc6821_detect(struct i2c_client *client, struct i2c_board_info *info
>>>    	return 0;
>>>    }
>>> -static int amc6821_init_client(struct amc6821_data *data)
>>> +static int amc6821_init_client(struct i2c_client *client, struct amc6821_data *data)
>>>    {
>>>    	struct regmap *regmap = data->regmap;
>>>    	int err;
>>> @@ -864,6 +864,9 @@ static int amc6821_init_client(struct amc6821_data *data)
>>>    		if (err)
>>>    			return err;
>>> +		if (of_property_read_bool(client->dev.of_node, "ti,pwm-inverted"))
>>
>> I know that the AMC6821 is doing a lot of smart things, but this really
>> tickled me. PWM controllers actually do support that already via
>> PWM_POLARITY_INVERTED flag for example. See
>> Documentation/devicetree/bindings/hwmon/adt7475.yaml which seems to be
>> another HWMON driver which acts as a PWM controller. I'm not sure this is
>> relevant, applicable or desired but I wanted to highlight this.
> 
>  From the DT binding point of view, it seems to implement the same I am
> proposing here with adi,pwm-active-state property.
> 

Ah! It seems like I read only the part that agreed with the idea I had 
in mind :)

> Do you have anything more specific in mind?
> 

Yes, #pwm-cells just below in the binding. You can then see that the 
third cell in a PWM specifier is for the polarity. If I didn't misread 
once more, I believe that what's in adi,pwm-active-state is ignored 
based on the content of the PWM flags in a PWM cell specifier, c.f. 
adt7475_set_pwm_polarity followed by adt7475_fan_pwm_config in 
adt7475_probe. I would have assumed that having the polarity inverted in 
adi,pwm-active-state would mean that the meaning of the flag in the PWM 
cell specifier would be inverted as well, meaning 0 -> inverted, 
PWM_POLARITY_INVERTED -> doubly inverted so "normal" polarity.

adt7475_fan_pwm_config was added a few years after adt7475_set_pwm_polarity.

>>
>>> +			pwminv = 1;
>>> +
>>
>> This is silently overriding the module parameter.
>>
>> I don't think this is a good idea, at the very least not silently.
> 
> I was thinking at the same, and in the end I do have proposed this
> solution in any case.
> 
> Let's look at the 2 use cases in which the DT property and the module
> parameter are different.
> 
> ## 1
> 
> module parameter pwminv=0
> ti,pwm-inverted DT property present
> 
> => we enable the PWM inversion
> 
> I think this is fair, if someone has a DT based system we need to assume
> that the DT is correct. This is a HW configuration, not a module
> parameter.
> 
> ## 2
> 
> module parameter pwminv=1
> ti,pwm-inverted DT property absent
> 
> => we enable the PWM inversion
> 
> In this case the module parameter is overriding the DT. It means that
> someone explicitly set pwminv=1 module parameter. I think is fair to
> fulfill the module parameter request in this case, overriding the DT
> 

Why are we not assuming the DT is correct here as well? I don't like 
that the behavior is different depending on the presence of the DT 
property. Its absence should carry as much weight as its presence. If 
you don't want that to be the case, we can always have another property like

ti,pwm-polarity = <0>; /* normal polarity */

or

ti,pwm-polarity = <PWM_POLARITY_INVERTED>;

and then the absence of the DT property is a "weak" normal polarity for 
which we shouldn't print the error message if it differs from the module 
param. But honestly, I don't think the DT people will be happy with that 
suggestion :)

>> I would suggest to add some logic in the probe function to set this value
>> and check its consistency.
> 
> With that said I can implement something around the lines you proposed,
> if you still think is worth doing it. I would personally just keep the
> priority on the module parameter over the DT and add an info print on what
> is actually configured by the driver (not checking if they are
> different).
> 	

Module params over DT is fine with me, I just want consistency here, so 
if it's always the case, fine :)

Not really sure we need a dev_info, that's pretty verbose. I liked 
dev_err for when both settings differ.

Cheers,
Quentin

