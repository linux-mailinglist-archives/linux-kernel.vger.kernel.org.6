Return-Path: <linux-kernel+bounces-341529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8354988141
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 11:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8D71F21A2C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B211BA888;
	Fri, 27 Sep 2024 09:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="ecxXbqU6"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2088.outbound.protection.outlook.com [40.107.117.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F53433D9;
	Fri, 27 Sep 2024 09:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727429061; cv=fail; b=EBFYg4WuQ1RrnDZ7hEcMgmajGtRuI/vPMSbomRssGDSHfCkihbQwgGfEYV283SaKSjQHujel/YRZ3ZVo7gXMrkBYPJgTJ+F8FLRaXJchZatiPkHhDvwfagOIGJB/KZm3yaEnIylAduu5wQSntisEvwJM002aMnK3S2y48c86Th0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727429061; c=relaxed/simple;
	bh=utJOCuhKWRlGP9MdgMT+5YUcgNvnM+QL8NqxR5FJDAk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tk6J2VSZ9C/puY7z9LldIeLg0v2QGnhwGn2aABYF2ayGq1+oeF8twErsIvQzaiWqVX8dS41DW9k3NgseeDHD0xUyWORm5JptZntEqGOfWmqC2ns9fC86sKoK0mbokvl5nXXYYOXAb3AgnRkXZyNOnOXTvwped5GOYPOVtdczvsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=ecxXbqU6; arc=fail smtp.client-ip=40.107.117.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SlNhSpEJrYcZdNDvQitXZY+wiVD4keHhlkc5w6VO4ZevScV+duzb7N22bSxr4uxxbv5ftUuzi8PLAfNIzG1ZFPahgF03HxUPiDaIcKW4ifo3JsR+H8VRSKVuC3d0Rsrh8cp0EcH+Qsr67sJPWM7HhCD9jxxdl418ho504cIIidpcbs67NGU/rGHIcxx9NLBFhzWWwnQQWzAehWdqP42dyABu9Kc6a+kov8tx5MyTI1BLmiQ+oJZu6sLyrbWC0avqySWnCzsA+rrCKjFzIiRZ9TsYAHKnYOnWz+eYg9TJV2zaLERPcH5x5CgAfJZYmEQ/iXzs5hEzEGNgO/2E58jIsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utJOCuhKWRlGP9MdgMT+5YUcgNvnM+QL8NqxR5FJDAk=;
 b=to/Yz+r62ivjehyMDj5p4M+KoWFE1Y4fmyF2o1z5ZwcOVZDoItPG49fMQnmiovcM+DNBoxCdVnn2EvxH2hz5zNnV+FiPBjWt68HKLljVettAFE+lq+ozTtOZi2DlXHUDOeBB4t08SdfCFB5+MzmHiS1+2bUisRDgn1Uo7C4Rv72NSozp1NsrhmcE4ZyE2EXj/4iA+71LPy/93m62j7TTewb/mBAjZsHdoeL0nwXs0iwwFHxLCflL0si/19K/FpSUK4Y9FZ3gYZuyEpUrt73LY0nyiwTTIFPoBkBfbbbPJJ4lvZRAaoZEbf82SaoWv8h3Jku1MRYL/bKXqrOK5bKxDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utJOCuhKWRlGP9MdgMT+5YUcgNvnM+QL8NqxR5FJDAk=;
 b=ecxXbqU6syocS+6SAJUXlOymZxsjjQLabbz65agjdmZDMPzHEdtQYWVCI/tY1ZtaC9yFyOlkaHQIA3Eod4oHbxYVZMEmdyaiLhiH7meoRrwYLI42Yk53nnVaHw4paA1HgNc7037Ild1BIk4dSPCkzkoLb0f4Kj3tRuTxEvs13qrpkfLXLgWUKGdSyVFXZLiDuxkiudcxQDUOCONsla/mQl63mCNFApJL5Wrzb2uQ2wNWx4MOyYv5rcV6pU0OlUVbQ21z8p6T0jnI2SKRVwcg1iGcP1lPOUa9hzHv3dEa6dxL4CAp8z+v9WLGv+768VvvbVTZhIk0th2a7MlDK0pQWw==
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com (2603:1096:400:1f3::5)
 by SI6PR04MB8250.apcprd04.prod.outlook.com (2603:1096:4:235::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Fri, 27 Sep
 2024 09:24:12 +0000
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96]) by TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96%6]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 09:24:11 +0000
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
Subject: RE: [PATCH v1] ARM: dts: aspeed: yosemite4: Add i2c-mux for CPLD IOE
 on Spider Board
Thread-Topic: [PATCH v1] ARM: dts: aspeed: yosemite4: Add i2c-mux for CPLD IOE
 on Spider Board
Thread-Index: AQHbD72dvqgTMAKzWkuYvi4zIhwj+rJrJMWAgAAxixA=
Date: Fri, 27 Sep 2024 09:24:11 +0000
Message-ID:
 <TYZPR04MB5853B51141F3D0610D970265D66B2@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240926024133.3786712-1-Delphine_CC_Chiu@wiwynn.com>
 <fbdc9efe87a1bed9fea7d0abaf955aa1a3dc24ac.camel@codeconstruct.com.au>
In-Reply-To:
 <fbdc9efe87a1bed9fea7d0abaf955aa1a3dc24ac.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR04MB5853:EE_|SI6PR04MB8250:EE_
x-ms-office365-filtering-correlation-id: 9d4d31c1-84a0-495b-5cb6-08dcded62597
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Vk5RMitaMlh4akFXeTRHQkU3Tzl6MSs3UnN4aXFtS0hRUkM0TUNHN01SUlND?=
 =?utf-8?B?VWRZOUtiYmxZMXI5VHN6S2ttejBPb0JUc0FwdVcxanczRnpDTHBVTzNnYjZh?=
 =?utf-8?B?OFg5ZU9KWUlYVVJ1Q2JzaVlvbEhpelhKZGZ4anhkOUI3VUFFZFNTOVRKdEJS?=
 =?utf-8?B?VGNaTlBEMkl6QSsyZlpqcmsyY0tHSnlXSTVvYzQ3Rm9BMUFtYmJOZmNoRi91?=
 =?utf-8?B?a2VObmFWQWxVamNqVlQ0Q0t4K0VBMWdVRVlJQzg5RHdEbDFEMmFIeUVCblh3?=
 =?utf-8?B?VXUydlE2ZGtOcENaZVd2MFJGZkZXVWJ6dk9ZemRESkJJaDRNMVR1aHZuWjZt?=
 =?utf-8?B?UEFldUE5QTZwWG9GVFN2bmhwMkdPb0JxcTd1cVZldE5YRk5hdU5DNGtNY0Ur?=
 =?utf-8?B?UzAvVTB0Rlp0R0RQTWdPakhzUmxtTnhnWVlPTEpWQnV6V3NjcGdtNWxDdUlC?=
 =?utf-8?B?SFR2YzF0NWVHZ0s1cmhnRldaUUJCMGM2blRPRkNzWk41NFV1THpDWmFhaGc0?=
 =?utf-8?B?YS9MQW04Rmw3TkZtK2xveVJHNklQV1BVM3VDWW5sTms4WXBEWVZTU2drTWov?=
 =?utf-8?B?L3huZ2Ftb202YVhqZ3FzanpieW96K0RjN3M1Mnd3YjljQkY4ZzBCQWRUWDAv?=
 =?utf-8?B?N2hKVXFtTnRWbUZITFhDWWlHZG1jTHExZ3FxWUdVSjd0b21neUpibWQyeUZq?=
 =?utf-8?B?UjhVRDhUVkNCbXhyTVpPNlJwQ0lXQnl4eE1OQldRYkRGN3VPdmZ1bGltVHdy?=
 =?utf-8?B?dExLbmpYdGVBYjh6YlBaMmFWQW1hVGxhZDNvNEt2VHhTd0w2d2dKaUlqQlRX?=
 =?utf-8?B?NSt4QXFaTGhjS3FvT1o1ODJ5ZkRPVVplTVU0azBDdGhwdnFrVVdTeklaWFJr?=
 =?utf-8?B?Vlg2a2FiOW9DUStQdGNtWFdMRTU3WFA4b3Y5Qyt1S2dtdUlZTUh1TG1Fc3cz?=
 =?utf-8?B?N0NZUkxuRlhVeWFqUTl1THdkM2V5QWcrVm53bWxVekZwL2d1QWNGTSs0Vk5R?=
 =?utf-8?B?YkhFK0NrV1VKQmVLTHNvaUt5aXZtTXBGRVQ5ZG1lQWtteFZydFBTQko2NzBF?=
 =?utf-8?B?SHVaay9EeU8yL1kwTlAzZ3JnWk5jdEtQRXI5cDI4WFI4SVc5RE9HSzd6WUFr?=
 =?utf-8?B?RGNSMU14TlRZc1NUc3dDR3lzeDduMUhQOU9pK2JTREJsMlE5aEVKV1VWajVM?=
 =?utf-8?B?STZIeExyNk5POEViTTduYVlOR25VaVprNTVzQ2wwVkhUVnlabEpOQTBlY1Yr?=
 =?utf-8?B?S0VaZlJmNHkrT05pNGFVY0hVeGJlT2hLWmJQcHh3ZzZiV3Uwd2xsQkE3Mzhq?=
 =?utf-8?B?OHpJL1AvcnlVaHcwa3ZUdlU0UGVMSUtrS0gyNG5McWJLRWtuSmxsb1pmNHFt?=
 =?utf-8?B?Y1l2ZXdabExoeXhPTi9sYWg3QXZEc2U5bUtDNlZPVGl0U3hPOWpzaDN6Q3Zl?=
 =?utf-8?B?R3VyR0JJVHZrYU5yb29STEhRcktXZzZYN2RKamYxNExIWndqcjZwTCtOamlh?=
 =?utf-8?B?dThTSkRmeGNqTyt1d2t5bTgyblplbUNLN2pWaGMvU1dtQmFrZ3NHYUMyLzkv?=
 =?utf-8?B?ZCtxNkJjMEhQcFFFNjVpeHV1djJYa2dCd1hoNU9ZcWZLYVFleEVQWnhyQ2Fs?=
 =?utf-8?B?TmRTaU9QVXBacndmemxEM1kxV2YzSkphRnJQL2t3czYwWjN5enZ4UGVrWWdT?=
 =?utf-8?B?ZVh3dzFnTWVqZGZzQXp6d1paMTVvejlOZFZ0Zm1oMHZFaVJOdXVSTWtBNTdz?=
 =?utf-8?B?cGNQeHlnb2lUQ1hSbmY1TzRwQjkyWEpNbDh1QXRSalVMcFBKT2VxR3NqN3pr?=
 =?utf-8?B?QW5lMS8wZVVZR1orZWlIdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR04MB5853.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TmNraEZlb1k2Z2FrdU9sSEQ2SEJMNUJZcHQ2S1ZhNHBJYllxYlh6b3RkRnMx?=
 =?utf-8?B?VXo1UU5rK3lMc0ZSbTAySWVsamZRU3FqK0pBUFBPN0VNZ0c3TS9yenh4cGR0?=
 =?utf-8?B?MmFMWGUxb3FyN2xpY3dVYUFvS2NlYjNTS3U1RFpMcWh1eElRdzdQblEzQmI3?=
 =?utf-8?B?YUdPZ1g1MXVBYUlQclJPbDk1Qld6Rk85ZlhmdnVEcUpiMHh2S1N6MmgvZTNP?=
 =?utf-8?B?QXdMNVJlaDc2UkxhM3UzOWtWWWl3dkYzVWhtSDJTelZYbENScklFVmkvNnU0?=
 =?utf-8?B?cWNoeW5HN211TEhYRlI2dzZYVkdwWHFBbXRUSkpxWkpidWM5M0ZIZDNaMGhi?=
 =?utf-8?B?VjMzeFJVN21vYldLVWoyd09NTEVQT1hsUjhyQk15ZnpmQnY2cERPc0pjTS85?=
 =?utf-8?B?eUdSYmRTTGgybGxpc254UnBsc2JZWFdZR1N3dVVFaUdwdnMvOGJxL09iSkVK?=
 =?utf-8?B?MGV1VUhnTW51cnIzYUtOM3VZTllQcmMrRTVnOFNnTXQ2NVhPOHRiWXdZdHU5?=
 =?utf-8?B?QTRmZW5IeURMWUQyQksvUm9WL2pndmM0K1RaWWU1eEQ5S2MwWXNMbGlCS2VS?=
 =?utf-8?B?S2E3Z3U3MldCTElOWGQrTGl2QWdzdmUyZ0pLM3FmbFVEWkZUbUlma3Uwa29O?=
 =?utf-8?B?d1VEVXVzSHFUdzY2aGU5UklLVUN3VzhKZ2pHOXBZWGJxNGQxdmk4TUtGdzZU?=
 =?utf-8?B?ZWl3ZkU3QmEyWmRKd2VtWHc2Z2xqSTF0b0xxOFVkRUR2eWgremxHMllTUmo4?=
 =?utf-8?B?blZRVkVPMTMzV3BrbGtUTkhEK0g0NUdoZXROc0lhR1FsNWEyaGN1azhYbGxv?=
 =?utf-8?B?ckI4ZU1xUkN0S1BUeEpaem4vUk0zVjZVUXFtNmlyOGtJUFl6OGcvVTBiVlZ6?=
 =?utf-8?B?aSt3d3VXWHkyMmZpdHcwV1VEZlc1UVJIQ1JiaCs5eGZDQUtqWHlXdUVySUx1?=
 =?utf-8?B?ZW9ZNHVob3d4OVNTV1UraDNxMzlGNnRGNEVySENyVUFFK2szZTUwSU5kbUdR?=
 =?utf-8?B?WkRCNGJPOEF0Ylpwbm15ZVYzMVRDK3VsVkZUZG5YSEd0WHBhMWtRTmJsQmNQ?=
 =?utf-8?B?Q0dISGtVSExPLzlHUGJJTkxJQW50YzYybk5JQkViVCs1UU9EeEFqR2dOZ0xS?=
 =?utf-8?B?dlcvSHFrNHJCVkhURE5GN053eGM2TVRlNUpINHlnVzJza0RmZjVZclJRUm4z?=
 =?utf-8?B?dVgwZE1Wc0xpMjNvN1Ixb0t6TEwwTFN1RXp2SW43dlVSN1c2bWE1UzcwM0Nz?=
 =?utf-8?B?eHBxbXdIM2c2TS9EalhmNEw1UTErRWFFNStsWVJLWXNuamtGZzVpT0V0NGtP?=
 =?utf-8?B?OSt5ckFRdkFXQzdEUHgrelVvbjFTazJEK3BlK3doUDVuOFBvbEdObnE0b3Rl?=
 =?utf-8?B?ZlFiUmF1WDBJbU5vYkVROUZZZWY1alE0TnJyZjVvcENIN01oNUJ5Ujdjbk1h?=
 =?utf-8?B?cWppZ0o4cytzK3dPaVFudUpneTd5dVZ1M0htdkZTOEZvYk1paEQ1YUsxdUR6?=
 =?utf-8?B?YlFpci9nRSsxaXlUeldtK05qVmJVYmZqQks4LzVrYlRnS2IvRnFvZ1V4Uk5u?=
 =?utf-8?B?UVFJMVdoSFI0UDZIcm8ra2NiV014UVFvZ0c0NytJUFEvcmxkT3N2bVltcFND?=
 =?utf-8?B?WlBFMlQrSzlNaW1LMjRRbjlzdW5RWktIN3JWRnR5UEZhZkpyejFRT0FsMnE3?=
 =?utf-8?B?ckdIdlJlUEpoK2NGWXFNbGNnUGJ0NnhFN1IrQUdwME1MZjlRREdnUzhhMnNw?=
 =?utf-8?B?b3Q5aEVISnQ4NEQ0RDNuWHVyYzZWcEtCbVBsNWFwbG5ZeDA2d2I4Y0xpbFBY?=
 =?utf-8?B?ZUczZGR6ZHBMVUpvNHZMaTMwZnk2eUVVMlpsc3R0NjFvT0ZLUVBxUjZJVTFy?=
 =?utf-8?B?MWNzT0g1cnFOYlhqbGswTzZzckpNZUNpdk5LSDdYb2crN3N1bVE5ekdFaE9j?=
 =?utf-8?B?bXgwVlFkV0xya3psejFLQ0lqUkJUajBxenh1WkxlNS9uWHk0RXc4ME8rN3BN?=
 =?utf-8?B?MnFGbFhrKytMajlFd0RKc0hxbkFOQXMydld0Rm5tTWt1UGswdGU1Q1J2SWcw?=
 =?utf-8?B?U3poSFVObWJQZnU4aFh3ZFd3bUJNdG1lZGxUYTJLdmtIa0xmU3JObzJVSkli?=
 =?utf-8?Q?MGUWNEujvFT9EjD40MlP0XdEb?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4d31c1-84a0-495b-5cb6-08dcded62597
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 09:24:11.4454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AvjM3CDfOvyVx8jI+Z9HS5aZ4Cf9Ccvmaj9R7cZa30Nos1iXiYuKwH1Y7tfHEuiDGIWzZ8udD3MoOd9WdHonGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR04MB8250

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IEplZmZlcnkg
PGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT4NCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIg
MjcsIDIwMjQgMTo1NyBQTQ0KPiBUbzogRGVscGhpbmVfQ0NfQ2hpdS9XWUhRL1dpd3lubiA8RGVs
cGhpbmVfQ0NfQ2hpdUB3aXd5bm4uY29tPjsNCj4gcGF0cmlja0BzdHdjeC54eXo7IFJvYiBIZXJy
aW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpDQo+IDxrcnprK2R0QGtl
cm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBKb2VsIFN0YW5s
ZXkNCj4gPGpvZWxAam1zLmlkLmF1Pg0KPiBDYzogUmlja3kgQ1ggV3UgPHJpY2t5LmN4Lnd1Lndp
d3lubkBnbWFpbC5jb20+Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1hc3BlZWRAbGlzdHMub3psYWJz
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYxXSBBUk06IGR0czogYXNwZWVkOiB5b3NlbWl0ZTQ6IEFkZCBpMmMtbXV4IGZvciBDUExEDQo+
IElPRSBvbiBTcGlkZXIgQm9hcmQNCj4gDQo+ICBbRXh0ZXJuYWwgU2VuZGVyXQ0KPiANCj4gIFtF
eHRlcm5hbCBTZW5kZXJdDQo+IA0KPiBPbiBUaHUsIDIwMjQtMDktMjYgYXQgMTA6NDEgKzA4MDAs
IERlbHBoaW5lIENDIENoaXUgd3JvdGU6DQo+ID4gRnJvbTogUmlja3kgQ1ggV3UgPHJpY2t5LmN4
Lnd1Lndpd3lubkBnbWFpbC5jb20+DQo+ID4NCj4gPiBBZGQgSTJDIG11eCBmb3IgQ1BMRCBJT0Ug
b24gU3BpZGVyIEJvYXJkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmlja3kgQ1ggV3UgPHJp
Y2t5LmN4Lnd1Lndpd3lubkBnbWFpbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogRGVscGhpbmUg
Q0MgQ2hpdSA8RGVscGhpbmVfQ0NfQ2hpdUB3aXd5bm4uY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4v
YXNwZWVkL2FzcGVlZC1ibWMtZmFjZWJvb2steW9zZW1pdGU0LmR0cyAgfCA2Nw0KPiA+ICsrKysr
KysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDY3IGluc2VydGlvbnMoKykNCj4g
Pg0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC9hc3BlZWQt
Ym1jLWZhY2Vib29rLXlvc2VtaXRlNC5kdHMNCj4gPiBiL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVl
ZC9hc3BlZWQtYm1jLWZhY2Vib29rLXlvc2VtaXRlNC5kdHMNCj4gPiBpbmRleCA5ODQ3Nzc5MmFh
MDAuLmVhMWE5Yzc2NTQ4MyAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9hc3Bl
ZWQvYXNwZWVkLWJtYy1mYWNlYm9vay15b3NlbWl0ZTQuZHRzDQo+ID4gKysrIGIvYXJjaC9hcm0v
Ym9vdC9kdHMvYXNwZWVkL2FzcGVlZC1ibWMtZmFjZWJvb2steW9zZW1pdGU0LmR0cw0KPiA+IEBA
IC0xNyw2ICsxNyw5IEBAIGFsaWFzZXMgew0KPiA+ICAgICAgICAgICAgICAgc2VyaWFsNiA9ICZ1
YXJ0NzsNCj4gPiAgICAgICAgICAgICAgIHNlcmlhbDcgPSAmdWFydDg7DQo+ID4gICAgICAgICAg
ICAgICBzZXJpYWw4ID0gJnVhcnQ5Ow0KPiA+ICsNCj4gPiArICAgICAgICAgICAgIGkyYzI4ID0g
JmltdXgyODsNCj4gPiArICAgICAgICAgICAgIGkyYzI5ID0gJmltdXgyOTsNCj4gPiAgICAgICB9
Ow0KPiA+DQo+IA0KPiBIYXZlIHlvdSB0cmllZCB0byBhcHBseSBhbGwgb2YgeW91ciBpbmRpdmlk
dWFsIHlvc2VtaXRlNCBwYXRjaGVzIHRvZ2V0aGVyIGluDQo+IG9uZSBicmFuY2g/IEkgaGF2ZSwg
YW5kIHVuZm9ydHVuYXRlbHkgSSBjYW4ndCBhcHBseSB0aGVtIGFsbCwgYmVjYXVzZSB0aGV5DQo+
IGdlbmVyYXRlIGNvbmZsaWN0cyB3aXRoIGVhY2ggb3RoZXIuDQo+IA0KPiBJZiB5b3VyIHBhdGNo
ZXMgaGF2ZSBjb250ZXh0IGRlcGVuZGVuY2llcyB5b3UgbmVlZCB0byBzZW5kIHRoZW0gYXMgYSBz
aW5nbGUNCj4gc2VyaWVzIGFuZCBub3Qgc2VwYXJhdGUgcGF0Y2hlcyB0aGF0IGNhbm5vdCBiZSBw
cm9wZXJseSBjb21iaW5lZC4NCj4gDQo+IFBsZWFzZSBhc3Nlc3MgdGhlIHJlbWFpbmluZyB5b3Nl
bWl0ZTQgZGV2aWNldHJlZSBwYXRjaGVzICh0aG9zZSB5b3UgaGF2ZW4ndA0KPiByZWNlaXZlZCBh
IHRoYW5rLXlvdSBlbWFpbCBmb3IpIGFuZCBzZW5kIGFuIGFwcHJvcHJpYXRlbHkgY29uc3RydWN0
ZWQgc2VyaWVzDQo+IHNvIHRoZXkgY2FuIGFsbCBiZSBhcHBsaWVkIHRvZ2V0aGVyLCBiYXNlZCBv
biB0aGUgdHJlZSBoZXJlOg0KPiANCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBz
Oi8vZ2l0aHViLmNvbS9hbWJvYXIvbGludXgvdHJlZS9mb3IvYm1jL2QNCj4gdF9fOyEhSjYzcXFn
WGohS25aVC13Tzhrc0s1M0J2R2lGTWRoaE5nQ25ROThGUUxNZEhleVlPU0dzUHcyS0cxDQo+IE1O
ZUpqdnNaejR6dVg3WWVnZXVMZlNzYTlxOVpFQnJpRFlzVFR1OExqdU0kDQo+IA0KPiBQbGVhc2Ug
YWxzbyBpbmRpY2F0ZSBpbiB0aGUgY292ZXIgbGV0dGVyICh3aXRoIGxpbmtzIHRvIGxvcmUpIHdo
aWNoIHJlbWFpbmluZw0KPiBwYXRjaGVzIGFyZSB0cnVseSBpbmRlcGVuZGVudCB0aGF0IHN0aWxs
IG5lZWQgdG8gYmUgYXBwbGllZC4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEFuZHJldw0KSGkgQW5k
cmV3DQoNCldvdWxkIGxpa2UgdG8gYXNrIHNob3VsZCBJIGJhc2Ugb24gdGhlIG9wZW5ibWMvbGlu
dXggcmVwbyB0byBjcmVhdGUgdGhlDQpyZW1haW5pbmcgcGF0Y2hlcyB0aGF0IGhhdmUgY29udGV4
dCBkZXBlbmRlbmNpZXMgYW5kIGFkZCB0aGUgbG9yZSBsaW5rDQpvZiB0aGUgdGhvc2UgcGF0Y2hl
cyB0aGF0IEkndmUgc2VudCBpbiB0aGUgY292ZXIgbGV0dGVyPw0KDQpSaWNreQ0KDQo=

