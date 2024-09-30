Return-Path: <linux-kernel+bounces-343280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E164989910
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 03:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C714F1F219F1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 01:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250A6848E;
	Mon, 30 Sep 2024 01:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="ZNeMvvdJ"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2046.outbound.protection.outlook.com [40.107.117.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8181BC13B;
	Mon, 30 Sep 2024 01:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727661417; cv=fail; b=IuYqfSw2j/ylrxaMoNzVGj8tGFBRct/WsshDRU0nT6Sg5EnS/roXMyUhBekI+UEQS/NBL9dHT8TZuFzNYZwDtleXBkVLs/s8CxA5oHcppDAGRSz5WClq+UNDeEv7OVFsQuS/PY0nKIuWE6jCR6ipa/PXDz+V7C1bCQEk0aDYNJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727661417; c=relaxed/simple;
	bh=aEa0t0/ubY6jGpNsz/pu20p//MhXcpLRuJS/hUkOs7A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XJpRP1H7E/rsYvjCis75gribIfEb8ur2wCufwC1LzJQFBRamiVbC8xikRXiu/9T55V9SAj9PEydLg3KPCkHZ5hpbigN3WzV/Of+xVWDCXmkYtSeVkbqdgBAO7MzGN93sa+cBeGWGPTdSDMoJ2exbGWKVThvA9g8XBZtKdGWFkmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=ZNeMvvdJ; arc=fail smtp.client-ip=40.107.117.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RCQisCnueIIUmDyKyJ2WSIJCwSdY+DrYYOw5ADUbB7M8+sWEvWvvF+9nLwbvt0NxYnJemkCLYL4fLPwEtDjnnpIA7GAtIsOyIElt1qb/s00ZlePf4VW+MAnAmaahZKzn7lSm8VzijPa8fdrbPTefC6kNTqXW2P9239g0ZGevk6MWVjQOyefkz7u5P6uLzlMXZoBzZVsErUvXWeUD8e/zdETLFZRQjOgCYyiNagm47voebrGHXvfHDZxk+ScL9LgP2T9JQI3xHcPP7RB5FCVxKWzpZdKUjpQJquZarQi8brbiJo6GRJ6HdhnYsfTTCHDFo4VZSuAyyKCEew6M7Xy/mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aEa0t0/ubY6jGpNsz/pu20p//MhXcpLRuJS/hUkOs7A=;
 b=MO6+SqmgyjKIaEh4fabbWj4u8WlfTPWi4V121hTuBMtKFcA5PMbo8p8AdnJzXZZFvEy+Tz7VkHJTJRT91K974makAAiZqSBoh6qZaaGHNbLPwxaYEsrgR4fdf3GYuGxBd18wKSUNiQkNM9jL/XoAmp/Y5TrTcx6jaeZeSStCtIwdoYEfnvReYsvQ9hHVKmSM+gaDcig/iJ+5OltoAaTe35K5KNOapgbWEvMhfcb3HP4QcmeSzsj2/Sf/VdSH6X1IUfrQzBHuLlN30eag59j/s4t5EJkZ0faTyO2zHanY6WokV3yQ+uH0HIQwEYLlxp0unYBN9n3m0dM9zKANxpcN7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEa0t0/ubY6jGpNsz/pu20p//MhXcpLRuJS/hUkOs7A=;
 b=ZNeMvvdJVSRZcJhFmnh8iXE2Z8ldqvrlBn1WJa4ERGfL0iHWd0W5rGGXsySacMNIm6A/fFJlTEDRPDveR2qEsGkMwvmCW5vFHZgokRjGW0mFdPHxkanVEKBYpaM1/Hm0JOnVvvWUeSVUhQKU+3nFT+sGguoRBifoXTx0BU7H04kCANXg2jrbyzMd93MRWWr8fziiDA89a/M/rhdbMA0nPGkYX4tyGn4NV2Sw1j5DHy+8MzJvYazDzqacuaF7FmVRQLS06n8H5NGK286WC75Xyyr6UvAeCuetrnIyzkp4kCmt6MA6x7xMfuWa10lGPYwJhFvspcUzbycs40XWrD3NKA==
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com (2603:1096:400:1f3::5)
 by KL1PR04MB6949.apcprd04.prod.outlook.com (2603:1096:820:df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 01:56:51 +0000
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96]) by TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96%6]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 01:56:51 +0000
From: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Delphine_CC_Chiu/WYHQ/Wiwynn
	<Delphine_CC_Chiu@wiwynn.com>, "patrick@stwcx.xyz" <patrick@stwcx.xyz>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
CC: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 2/5] ARM: dts: aspeed: yosemite4: remove led gpio
 pca9552 on fan boards
Thread-Topic: [PATCH v1 2/5] ARM: dts: aspeed: yosemite4: remove led gpio
 pca9552 on fan boards
Thread-Index: AQHbD8QqQJuGMpPsqkiQ5QruptEkkrJrINAAgAR201A=
Date: Mon, 30 Sep 2024 01:56:51 +0000
Message-ID:
 <TYZPR04MB585383DB1DD37DF3776BE945D6762@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240926032821.4171466-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240926032821.4171466-3-Delphine_CC_Chiu@wiwynn.com>
 <0e9483a19f916982ba6996b81c2f1254da3801f3.camel@codeconstruct.com.au>
In-Reply-To:
 <0e9483a19f916982ba6996b81c2f1254da3801f3.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR04MB5853:EE_|KL1PR04MB6949:EE_
x-ms-office365-filtering-correlation-id: 2f02a2c8-dae5-4962-e31b-08dce0f326cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SFdnSmd2bkI5ZmIzYkxqSVZsendQdVNFRlI1aEtneUpjMzFmeldBdnJIM1gv?=
 =?utf-8?B?WXd3aSsveGRoNmczS2NST2luR0hEdXBsNWhkQk45R0VjdUQ0Z3lYVTZIb2Fm?=
 =?utf-8?B?N0xIVU95aVl2dXcxR2JKa016MWErSTFwT2JZejBDSmxPQ0JLWGkrWnQwUXBv?=
 =?utf-8?B?SjJQY2NucndaYUoxOWw3Q2JqeG8yZjhhMVRQNy9VYTk3VGN0djFVVG9FNXA3?=
 =?utf-8?B?KzRDb3IyQzMyQm1nYjFtNUNxM1c5N2RWZlpOT2VKaVRCSjlrbm5vaCswMDBw?=
 =?utf-8?B?T1FjUytFQmNsZDFWM1ZtKzA4UjZLcTgvRVpDQU9xZVIxUmdkMnhNWXh1cjRP?=
 =?utf-8?B?TlZSRU1jQm9tM0R5eXVXd0FiNTMxbDVyaXprVHJyOTdtaVR5Y0dZcEhPYlpt?=
 =?utf-8?B?bW4vN2J6ZWc5Z0ZpcjllTzhCNjJMajMyRFBCd0tZOGZkTmYzbzRLL3ZabjRz?=
 =?utf-8?B?b1B4NWlubGdBQ2RlbElqTjhscDBGOGdQekZYVDdQOVN6ZFVxMlhNYWFvbkhv?=
 =?utf-8?B?em9hb2FuMHJCN2lSL0RSc3duYTlnRHJGeCt1Rlc4encxNlNXRDRZSWw3OWQ1?=
 =?utf-8?B?d2s2cU1DVWU5Tmk5RUFHVHhSK1BpSnBwMU9XcDFpQWRtOUFnMHA4NjNscyt3?=
 =?utf-8?B?dlpxS0JrQUpIMjlxUDJVSnBsS0R5Q0ZzUmlLajdPUC9uSXVsZUpOanhISTY4?=
 =?utf-8?B?NnZDcEFVNHptZ0JWOTE2RUpTWUdHUkVIOGxQTmF6cUd3em1NU0NhNE0rRnFQ?=
 =?utf-8?B?aTkyN2lkNlRYZHp3TWRpZ0FmQ3owZjJVK3R6bmJpSVRvSG1PUFpaRU9iTnpC?=
 =?utf-8?B?ekF5MUl3bkltcDY1T0hKT2VXbEY1VExFY0FTVzg1T3FrQlRYOVV6MFhlcXdX?=
 =?utf-8?B?WTBGM2VOcU4wRG1kaHlsVHorSTBhb2h6SGNHNktNcUp5Q3BpUW5COUdwdTNY?=
 =?utf-8?B?N0ROMEVEL2VhRi9XMlNaSytkdEFhYTV3d3VsRXBVcmptR2piY2hVRWcyL0tD?=
 =?utf-8?B?Vm5MRVFiZk53L0FWZjdBYzhiZktnRGhJNy9lUzd1TkhrOVhaWlFFRDJaWUF0?=
 =?utf-8?B?RkdYOTNzTFY1clVUVlp6ZU1USXZWZTFvay9MN3c2UlhYNVF6dFczOVhYQXIx?=
 =?utf-8?B?czlRV0tnYzZ0MmYwSytKcDg5c2JRakFOZ0QrYS9CTVdtazM5Q0w3NEQ0MnJa?=
 =?utf-8?B?ZWV0Z2drOEczZ0ZoaVJQNUJ5dkRBWFYvWkUzVi82R2NiMmdhL2owa1hLdUsr?=
 =?utf-8?B?dDZ2RnhxdG1md1ZSK2FnRFQ1Njd4QytNVUZzYXQ4N21ibFhid2ovUWsvRUkz?=
 =?utf-8?B?VmhqdXgwRVl1bkxjVXRBNUhOQmdsMzh4NkxxdmxnbmZobVBRdXRHVkFLbkQ1?=
 =?utf-8?B?ZEp1c1pDZjI0YjFCeG00ald5ejVDdmJsSUdsajVxZzZvZWIrd3ZuOHVIQkcx?=
 =?utf-8?B?Q3NJYXRLRjJIUjBsemMyMk9jcGFraTNqMW1ZRzdYeHRuL3pOalNUSzFidHBS?=
 =?utf-8?B?SFA4R3p4b0dER01TME1OT2p4VVRXRThkUFRWdHk4dDB3M3JRVTQ1TUhaL244?=
 =?utf-8?B?MkxwZzQwVEwrSlovWTZncXU2Q2hPenA4bmNzV1ZCS0NxYkg2UTk3bTVnelp6?=
 =?utf-8?B?eG1EVDAweUJEaHVORkVIWVA1Z29UNCtaQURyRWRQY3FMSGk0dWR0TEhxb0pJ?=
 =?utf-8?B?Yk9yYTlBMUk2M0ZLVXRPZzJaZkFidVZvL2svbFo1bk9iS0g4aXBJU2F3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR04MB5853.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cHVZMWg4SEJWVGI1dkJuVDVPcjNzNWpqc3ZBaXZBMmtRUFZEbVAzM0RGL1N6?=
 =?utf-8?B?SjF1UU40VlQ4TG0xV3pDM1FJWC9ZbDVmY2pwTmF5WHFzUnFDTDVRemFzOHBP?=
 =?utf-8?B?YkhQK2tTMEVBU3FNMEYxaW9sMHJDa054WFB5K1duWWpwSU9TZmlmSHo2K1N0?=
 =?utf-8?B?dGswTXc4Unc1dDBkMFhjMlNaQS8zQlVWR0pYZWJMMWtYOGttM2xWc3EwYXlT?=
 =?utf-8?B?RVFnOXhUUGZIcjNVOWF6TEhxeDdiUzkybW41di9FOWp5ZDRrbUFwMGRNeUU5?=
 =?utf-8?B?UEJBa2ZGMDRnQk9DZ3Q2OXozR0ZhVzQ4Z2t1OXNIMURERkpYbE82ZDU0b1Y4?=
 =?utf-8?B?UVJUOFlKSnNkZm1lS3JGZGVlK0t4QmtGa1oyVW8zVWNTRHdNWVFjSHQwbHFq?=
 =?utf-8?B?SW56bncxaXNHbDBQZ3JJN0VMWENyOVZQUE5jdTI5aXh2ak1qQU91S3BHb3lw?=
 =?utf-8?B?QklKQVBsRDl4Y3c4cENCSDg3ckowQ2FHT2JYQXFDUzhQWlRRMnVxYnlRUnY2?=
 =?utf-8?B?YU5TWXJZYzNmTndhc05TVGNsMkpCWTFHQWZJUVdRb1loZjJBVXBCUFgvNm1Z?=
 =?utf-8?B?MWcwSkpSSm5aaHhKVVJzZzhqOWhocUQxSVZWaDBHNkx5c1JJMkFSdTA4bmx4?=
 =?utf-8?B?YVdTSTRVa1VYcU9IejRrQklLUVlxQm5KejB1SFdXUGM5ekdEUTJVVm9meGw1?=
 =?utf-8?B?S29GRkxHWlhZTXZCLzR5aloyamtWOHZvL1QyZlliakVYR1RBR25tT25aM1Vk?=
 =?utf-8?B?MGxrbDJOaVg3RUxtdXpxOThzd3l4WGdHYi95anJ4Y25LeU9kdm5xUDE1Z2lm?=
 =?utf-8?B?aHJMMWtMYnB2U2ZXVFhxRms1ZTM0Q2R2dEUzdTlzNWkxWVZ6ckQ3dS9oWFox?=
 =?utf-8?B?Mm84STkyNHd3UVBRNEJDK2dROE1wbGhGUzdiRVBBb2xvYVhkSVJhcENuS3Mz?=
 =?utf-8?B?ZE5LNnJ5UnpYSEhPdktrMXo2cDNIWGxaY3EvWERWbjV5d3g4Z040c01mTXBF?=
 =?utf-8?B?L1hpUHJ0Z1JjVFZEc3pGNzJWUGl2djFSeHNrMGNCQUdvckk2YnNEeW9XTlJo?=
 =?utf-8?B?NVp3KzFBYXlNZ1lucGMzY1A4bW56Qk1mbVdpNVdTNmpEVTFuUDVKeFJTU0Z5?=
 =?utf-8?B?WUN6aGdmWUh0THdBZDdjSFZqVnA4U2toeGNIaVVzMUV1WkxRbmhEMFdDdFQy?=
 =?utf-8?B?dUd6cE9FcWFqbmdtdkNvT2JVcHNxL2dBWktkTjhZWHp0cEU1OVkzblVPODVU?=
 =?utf-8?B?bVp4dUdicXNvQldPTkZEMGJxaGR2Tk1DMGpMRHhpNk9EUk1XMHlWSFUrSWpB?=
 =?utf-8?B?NVZkYW45TE9jeGQwdDV1cVpVNDhsWGdGZVBmb1B6ajh5dS9WRWYvcFlFb0JH?=
 =?utf-8?B?MEF0bHFvei8zUjFpQ3htTDFhc2d6MVp2YjdRME1XbmdyL3VMQU5tbWpqd3or?=
 =?utf-8?B?S1RwVVMwY2tqeE03ZzF1ZGtZWEExalBKRlU3WXJXTWxiSndiOXduOFRQRGVr?=
 =?utf-8?B?Qk5hMDJoTEg5TFVpUlB3S1o3UkdqbjNDcVhoWVVoN2cySDFhM00waTZQZXdm?=
 =?utf-8?B?c0FwN1UrajdOLytheU02dDFjWmR1bXhZN29kSGxyZGY0K2h4ZzR5WDd3cVdC?=
 =?utf-8?B?aG93azFiQWc2azYxZU9HOTJ0bmNxQkFkL212ZG9LdVpsUjRVNEk1K2JRTjdD?=
 =?utf-8?B?MnFHRXlNTUxCaXRlQ1dTOHRrZlRRVGhNVlljYzY0NDhRQ3FORnF4WmJOVHFk?=
 =?utf-8?B?blJ1NVBwbDc5N0Y0TEM1SXd6T2phLzVkS1kxNjVtdWhXTnFOenNSVGdIN25U?=
 =?utf-8?B?akpnZFpHVXhwdkJYa3puc1d6dDZMMmhqNG45aFFiQU9JdyszVzhqckFQZnU4?=
 =?utf-8?B?K1VHU0t3Tk5qMzRGVnlPNVczTmxKR2FQYnlVa2s2a0djTjEvQVZqU0ZRblEr?=
 =?utf-8?B?WlhxNWxjRWxLdFJRb2J6STkzdnR3YlAxTEI3TkRIV0psK3I2YkM0ZDBMM1Vu?=
 =?utf-8?B?L0FVNkJMZW5BWEdZa1hSM29hN0JIYnJlR21jNUFUeTRaRVB2TXVMUGtSWWpr?=
 =?utf-8?B?dTRMdmdsamNGZnJMSVNqd1VHaFN1NUt5TlRjcytTT293K0NLUnZzM0tzNVVs?=
 =?utf-8?Q?Shv8xkGcC5oI0Ua6x9TU1611x?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB5853.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f02a2c8-dae5-4962-e31b-08dce0f326cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 01:56:51.1936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JHJwp5PBXLsB1zWVIRUI6z2vfxAVkS8JoPeAY9JqVnEuE4dQxk8BdEuR/0h76Yo3AFho/j8GmWBGI5mtLCfU+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB6949

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IEplZmZlcnkg
PGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT4NCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIg
MjcsIDIwMjQgMTo0MyBQTQ0KPiBUbzogRGVscGhpbmVfQ0NfQ2hpdS9XWUhRL1dpd3lubiA8RGVs
cGhpbmVfQ0NfQ2hpdUB3aXd5bm4uY29tPjsNCj4gcGF0cmlja0BzdHdjeC54eXo7IFJvYiBIZXJy
aW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpDQo+IDxrcnprK2R0QGtl
cm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBKb2VsIFN0YW5s
ZXkNCj4gPGpvZWxAam1zLmlkLmF1Pg0KPiBDYzogUmlja3kgQ1ggV3UgPHJpY2t5LmN4Lnd1Lndp
d3lubkBnbWFpbC5jb20+Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1hc3BlZWRAbGlzdHMub3psYWJz
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYxIDIvNV0gQVJNOiBkdHM6IGFzcGVlZDogeW9zZW1pdGU0OiByZW1vdmUgbGVkIGdwaW8NCj4g
cGNhOTU1MiBvbiBmYW4gYm9hcmRzDQo+IA0KPiAgW0V4dGVybmFsIFNlbmRlcl0NCj4gDQo+ICBb
RXh0ZXJuYWwgU2VuZGVyXQ0KPiANCj4gT24gVGh1LCAyMDI0LTA5LTI2IGF0IDExOjI4ICswODAw
LCBEZWxwaGluZSBDQyBDaGl1IHdyb3RlOg0KPiA+IEZyb206IFJpY2t5IENYIFd1IDxyaWNreS5j
eC53dS53aXd5bm5AZ21haWwuY29tPg0KPiA+DQo+ID4gUmVtb3ZlIGxlZCBncGlvIGNvbnRvcmxs
ZXI6IHBjYTk1NTIgb24gZmFuIGJvYXJkcyBzaW5jZSB0aGVyZSBpcyBubw0KPiA+IGJpbmRpbmcg
ZG9jdW1lbnQgZm9yIHBjYTk1NTIgY3VycmVudGx5Lg0KPiANCj4gVGhhdCdzIG5vdCB0cnVlLCB0
aGVyZSBpcywganVzdCBpdCdzIG5vdCBjb252ZXJ0ZWQgdG8gZHQtc2NoZW1hOg0KPiANCj4gaHR0
cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9s
aW51eC9rZXJuZWwvZ2l0L3QNCj4gb3J2YWxkcy9saW51eC5naXQvdHJlZS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbGVkcy9sZWRzLXBjYTk1NXgudA0KPiB4dD9oPXY2LjExX187
ISFKNjNxcWdYaiFLSmxaWGdfR25wZ1lFc2ZMd3J4a1VFcXdmc0hrdF80MWpUbkMwOXlkNVZQQXFU
DQo+IHJhcWt0WTVwLUt3VU5RM3hQRWJkb2NrU0Qta256VGVPclE4aWpydXEzLVE0YyQNCj4gDQo+
IFNvIHRoZSBub2RlcyBjYW4gc3RheSwgdGhvdWdoIHRoZXkgcHJvYmFibHkgZ2VuZXJhdGUgd2Fy
bmluZ3MuIFRoZSByaWdodCB3YXkNCj4gdG8gZml4IHRoaXMgaXMgdG8gY29udmVydCB0aGUgYmlu
ZGluZyBkb2N1bWVudC4NCj4gDQo+IEFuZHJldw0KPiANCkhpIEFuZHJldywNClRoYW5rcyBmb3Ig
eW91ciBzdWdnZXN0aW9ucy4NCkknbGwgcmVtYWluIHRoZSBub2RlcyBhbmQgcHJvdmlkZSB0aGUg
YmluZGluZyBkb2N1bWVudCBpbiBhbm90aGVyIHBhdGNoLg0KDQpSZWdhcmRzLA0KUmlja3kNCg==

