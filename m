Return-Path: <linux-kernel+bounces-287452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F202F9527EF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 04:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 174271C212F9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 02:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CA91863E;
	Thu, 15 Aug 2024 02:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=missouri.edu header.i=@missouri.edu header.b="0cb6e52i"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2113.outbound.protection.outlook.com [40.107.237.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B25614290
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 02:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723689264; cv=fail; b=oZUkeTF8qKmLhc1asmNkUElQzJGeD4fgXlFePBnYRr0gSfLp74bPtLiFunDa+sqH9R4Opu10kS1cGJUyDLhP6r0l7qPuUS1YjAp0UAJsIGrdSGP+fw0GfJFvZdDDW1Lz+egfDhsZ2m8FQ44RwjZsCTM9u/+ENTR+kVgNBRCa7lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723689264; c=relaxed/simple;
	bh=RBEppcFGcgaS+PM6r/Eut8L1+18nfO3/14/e7QQDA3U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UjHY4yfbh338sPC0qa6E0wmsnD/q2dty7r312fOsplURjXt/FBqLDEDMRk18yEAPJ5B1E1oaTRTEYpeRPLkanxOyHKugT3Y5hu6Ti01bOaJ1N1XMzr1RQyGdQHgy43tyO5b1H01DCQ3UpePkyC07Mj++7Emz84T9GJ5Uu6U7Yt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=missouri.edu; spf=pass smtp.mailfrom=missouri.edu; dkim=pass (2048-bit key) header.d=missouri.edu header.i=@missouri.edu header.b=0cb6e52i; arc=fail smtp.client-ip=40.107.237.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=missouri.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=missouri.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B91PjfNYgp4bc8CEePX9jtt+9yfGQo78bNfyLRc7iO9OFEb+A2kKR+3EWi+vgJ1wM7NCOik6n4m8rYXG/vnKIV2EJ3awB1h2odephW+KrXc+pU4jSShZqsuqIPMoYeMlGeWzsDrJNAmti8UztDsHArqHHVJ60HbzwS0iC+Dd9QZjlhbFuyBerbfLN/jPeIDE2OqlTOr04ydY+Kr73gCO8rFSI2r5P8E0SiIqYR3e6wzuUDVCoFBX9XSrGFfUlMBx0aRmMLxTxzhLBKX0oWQrDkUKv1BomTEiiX4JEvyybN1Ew6UdLGp6kc5Tf6jsa9hSkguchmud5TBIow17yywQnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBEppcFGcgaS+PM6r/Eut8L1+18nfO3/14/e7QQDA3U=;
 b=vLQaKjuFmavzm2WSZKZJfEXDY86lsDFbVgASd+inu+YLXgKNxUWzIsyUd7+MUfym1V2ZTnqAfSurNSINbkGK90ETZtqkXGVZURa695AJ1N3MFwhxpm+KVaWKHRX28mpznqV5Zk21g0yQsc/VKSvJAF8A88RAg7b0f4e+zpXu6BsEVTwrL+6+S8oHMGVmatuMUjQR/nUuoWAKhfbkO7Yf7N93VzO6Aizk4cvcQN20tYgdqsaB12gWQ2ibilxVujyMH/tVXlJlTKCa11hxg9W/uO4XK8peYPsIcIQrIjFDKNQAnY2QKkWK4zhxq6+Dj/LSBWG5ZzvNsswiQ48QR59Mjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=missouri.edu; dmarc=pass action=none header.from=missouri.edu;
 dkim=pass header.d=missouri.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=missouri.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBEppcFGcgaS+PM6r/Eut8L1+18nfO3/14/e7QQDA3U=;
 b=0cb6e52iwfD2oSQVZAHz8NOGdlKb+VtXUol7x0CzZcAIK3ScF0zEB+QG7eEtTx1Cx0BoEXbGnxEVU9ZEdJufCsK9S4HIvLZsOVpAUhdJV2LWacDXlzhGmzXbvZ/i43QNhhfZzv+h/D5QE6kxczxc14hp1FGeb/66jA98mc9S5yjibFWMZWfY6CDQCeKKhkfKBaXxEdupMEnjv6b4+UyVPkfqk0OeRqf/2Uh02aK7QIOyx0O4oW2kmT//eRTmVY+E6wzFa9f5A4mG2GXrk2x1phlwSiGryw1R1JHQm/gMzpZakT9RC7drznzAtd9goUfkREAe0EeESEr8Keo6wGnptA==
Received: from BL1PR01MB7675.prod.exchangelabs.com (2603:10b6:208:396::20) by
 CH0PR01MB7035.prod.exchangelabs.com (2603:10b6:610:109::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.24; Thu, 15 Aug 2024 02:34:18 +0000
Received: from BL1PR01MB7675.prod.exchangelabs.com
 ([fe80::75c4:6269:5bdc:d2b3]) by BL1PR01MB7675.prod.exchangelabs.com
 ([fe80::75c4:6269:5bdc:d2b3%7]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 02:34:18 +0000
From: "Selvaraj, Joel (MU-Student)" <jsbrq@missouri.edu>
To: "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ekansh
 Gupta <quic_ekangupt@quicinc.com>, stable <stable@kernel.org>, Dmitry
 Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH 6/6] misc: fastrpc: Restrict untrusted app to attach to
 privileged PD
Thread-Topic: [PATCH 6/6] misc: fastrpc: Restrict untrusted app to attach to
 privileged PD
Thread-Index: AQHa7rugvhduxqHZ3UO6KRLCp0GxGw==
Date: Thu, 15 Aug 2024 02:34:18 +0000
Message-ID: <9a9f5646-a554-4b65-8122-d212bb665c81@umsystem.edu>
References: <20240628114501.14310-1-srinivas.kandagatla@linaro.org>
 <20240628114501.14310-7-srinivas.kandagatla@linaro.org>
In-Reply-To: <20240628114501.14310-7-srinivas.kandagatla@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=missouri.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR01MB7675:EE_|CH0PR01MB7035:EE_
x-ms-office365-filtering-correlation-id: 41e13304-ff63-43c4-9ad7-08dcbcd2c355
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Yzc0MEVoeW1pSTNsY2NpL2p0QmU2SHlXeEZtajM5Y29ZVSswcEFqNFFzTWdw?=
 =?utf-8?B?QmE4aXJJd05RQ01jeGg5MElXMHBrelQ4aFZ5ekYzOGxDdmx4SjVYZEhPOWNI?=
 =?utf-8?B?b00rdG9TOHZlUVRnOWZ6L3dQRDNWWHdkSm5mWG44SDhxeXlGT0pMSzlGSnZP?=
 =?utf-8?B?ektsZ3l3aUplNDlPZU5FN3JFV2QzSjYybmpVQ0l6aGtINjBxa1hUcDAwWnVU?=
 =?utf-8?B?T0NRMHJqNmtOMGxxNHBNMXdjTUJYMEgzVEJ0RGZwZ2pjKzhxcksvYmNacGNo?=
 =?utf-8?B?WW94ZWJqUW5hc0dRaW9ITUMwODN4MzQ4QmxMVXJQT2Z0bnlzUFRkeTljMGJj?=
 =?utf-8?B?cWhGWEpSbm1KUkI4WFNUaVZ4Mm0wR1Fqdi93OWxpc1NBQlhLbmdkVWM1Y0Zr?=
 =?utf-8?B?M2p4bWgvUlQ3VjJyNG5SbEdVOER6MlFmN2FFVjJYaERESDEwNUlCM2RrQUFi?=
 =?utf-8?B?bkdjc2VQS0pUNERqc2ZrekQrd3B6RVNnRGFFSEJ5N1JJTmxFaHBPOGRIM3VC?=
 =?utf-8?B?Qk1uVUNuNGNGdytWVVNadU85ME1VUlBEelhESHdzZkdLUGdOeTNxK3MzaGZr?=
 =?utf-8?B?UURIOXVFR2Q1N0NKZmJDcVFWcjYrTGJRMTU1NWxYZHNaMU5wUGt0NTYxNkJJ?=
 =?utf-8?B?RTRCbmhaRFlLUVk3RU84SXByZ05ZSjZ4TzEwMTR0L01ZM1NtcVQxSmtNc1B0?=
 =?utf-8?B?UTkxRlAxTjNpVktLS3Q2K1BpTFdGamdMcktBYnVLdk45TlJhMklpK25GSW9S?=
 =?utf-8?B?d0poSklVTC80aXR3WFZXSGlQRmlvRUlKWWlpMGo4d0g2MTg3N2pjOG1NNndI?=
 =?utf-8?B?OG9kemFpeW9ibnQ5ZmhnZG5MU3J2RjA1RzhoY3RsaUhyZ1lQZWJHeGtQTzlU?=
 =?utf-8?B?VnA0Rk4xK0NWNGFGRGQrMWpTTVB4UTBvWWlQZzhSUGZCaU9XK3VsK09lajU0?=
 =?utf-8?B?MW15NUgyb1BXQ1BLbGpmb2F4UWlPWWprRHVTVWNjTzVzT1dEV3llRXRPRlEv?=
 =?utf-8?B?Rjd5SGpLSEllcmUwbkZmNk5oYkE1OVBRTTJCWkx4V01GaXgxMHBHdEErR1J2?=
 =?utf-8?B?Z3p2Mm0zWGhDMFZWdGdHelhEbHdRVDZxbkpFcW90OU11RGY0NUFSQUFwdnhK?=
 =?utf-8?B?elRuZWMrMWczcVY5b1hqLy9kc2gwdzJBRTF5OE82SGI0WUgwNU1CUUQxNEIy?=
 =?utf-8?B?Ni9XcUs2ZTlGUHFBSGE1VDRQeTJOUTBVQS83U1RBT0ZJWGZOL3p3ZWFNald6?=
 =?utf-8?B?ZFRReVJVTUFXZ2xEZ0tERXNYdGZEaGJ4ZWZmaXFqdm1YcUg5SWJWQkJHOFFK?=
 =?utf-8?B?VHMvUXUrNjNkcHkwSTRUalVJczMwVjBJaEo5YlpxT0o0N3doaWhwMEpRNzVX?=
 =?utf-8?B?L1h5SnV4WWZqeGF0M0tCQlJEWmVqVThTWEVwMy93b2pqY2xobHpqeDRtWVF3?=
 =?utf-8?B?ZTQzTmtzOXFwV25YTEtENkpRSSs1UTcvTHUyd1NjeTlXeFVTYTlEcmZJVS9a?=
 =?utf-8?B?WTBPSE9WZWg0cmQ1UG9qVmpPa3BCSDNRandwWnZWa1RTMWVCaTZnRjI5c1lQ?=
 =?utf-8?B?YTFQNEdpUTZPN3NDTVpWS2k0dG8vOUlwaWV4ZERFUUMydXlVWDhnQzJDellx?=
 =?utf-8?B?blRHaEd6Sk5xaE4wMVZEdnVlYXVHeGVkamV6UTdyRHNhRHlnY3NNT2pjSGZV?=
 =?utf-8?B?TU5BNWdicmp1ekZoZFF0a1VmMnRmMWNKdFRMaDk4S1gzOVM4cEczUDFPaG5X?=
 =?utf-8?B?M0ZaZGEvT1RXMzQ4aWVIcUxZeFlsTzBZc0FNNzVtV0FRRXhJZlBQRmUwVGM1?=
 =?utf-8?B?RUxVLzBGdkovcVUwQ21NbEtoWmRzNFh6Z1dYcEdBMlVGVlFGVkt2T2FmMVRn?=
 =?utf-8?B?WUxsaUZGclE4c3NVU0h0OTUvU05VSlE2Yk5KT0t0Y05Xa1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR01MB7675.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MDhoeW93dGczNFFNRTlPcTlLZDAzL1lTMTU0T21EbGxCeVZPbm4yc0ExckMy?=
 =?utf-8?B?SHNLZ2FjY2lJZGFiWDlEQzl0bjZxMTlwY2VGQjNmL2FwM1pCSmthMjB3UEZU?=
 =?utf-8?B?UGlLeHJPSjhxbDdWTUNKbjN0WEcxdFBEaTA0NUhEb0c3a1JLSExla2dSbEM5?=
 =?utf-8?B?anN3UlpJRHFFWGFlQkNEb0NZenlpc0YzN1laYlNLdUJQOVNSUW14ckdCeVNp?=
 =?utf-8?B?WkplN2ZZUHc5eS9tTTMrN1hOVEtFMUZuL0pQaGh1MlhOb3pKS1RuNkFyaWtD?=
 =?utf-8?B?WFc1OWFxcjQxQVBWbTl4RVhHSjZHL3VkbVBSSC9hbE5oelgrajVPNDQ2elBr?=
 =?utf-8?B?cThaVzdoemFpSFNubWFCem5oR2ZQb1VmR25kQ0l5SHpRdVZwUWQvdkFrbzNN?=
 =?utf-8?B?L1Z4VWxoRDRHNGpiNE9pU2F0ejZOcWZsWDVKa0NPZlh6N1RaL3pHbzQ2OUg5?=
 =?utf-8?B?bUVuRHJCRlJBMElOVlRwRjBSSWR4NGRSVkttb3lxVnRuUGVkWVlCQnFxTmow?=
 =?utf-8?B?aXNuUi9xK0xxeEdENCt6N05xZjQrVUk2OVBLcXI1NDgvWXlFQVYrNnVSOW1w?=
 =?utf-8?B?OGRlZDFZdklYUG0yUzY2VkZOS2I1YVB1b2ZOUW11Rm1nR2tKN3pwUlplWjU5?=
 =?utf-8?B?a2J4UVgwUTBSZ3hkdXpqZGF1bFFQN2gxUVF4LyttYjErWE5MNCtyaUhNb2Jl?=
 =?utf-8?B?b1dQQ0dlVFhDOFo0elErRlhuelFQWlM0a3BDWHBTNk02TDN3NE9PRjRWOHpi?=
 =?utf-8?B?eTVVdjcwM1paOVp2S0ZsY3pvcFdFRndZOXMyVVVBSE94dEtOSGJ3YU9OWnJa?=
 =?utf-8?B?MzdhWXp2ZDNpZTAyL2FTQ2pGamZqM2x6M2dHVlFZVzVlOG90Y1llTVNzSjY4?=
 =?utf-8?B?OUpjNFNVT1ZYNlNsZitHcWdiQnVsMGFBUGdtQUJTK2JRVkwrNW9KSHFZVnJ2?=
 =?utf-8?B?bldHNFUwSWZBdTJVRG1iak1KR2lzaG4yNjFpemNmRXgyaGsvYWZ3MVFJRXVo?=
 =?utf-8?B?a0o3cmFGeGZ0NVJIbUpvMHRrbTNwZ2VpS0R5bmJNbys0b1dvODNZNlVubUpr?=
 =?utf-8?B?QXBvWDNKUFdPL3IzbXNHUnFkUi9QWFRndFF6NHNFMksrbnBnN2pWbXRnMFoz?=
 =?utf-8?B?Y25FL04yWmZ2a3pGa01IN00ybElZalpmRVczMC9TNlhKQktVbElHTWVCd1dn?=
 =?utf-8?B?dllsRysweG1LdmdWNjJFSlk5R3FZS1pLVHRHalB2dXBHbU5TWG9aOUV0WWhZ?=
 =?utf-8?B?cERFa0o5NmQyV1lHRkRNOHFDQjRJWWRyMEFCYmF3T2h3aEFKb1BwdVF1ZlNO?=
 =?utf-8?B?dnViQ200WWRzWUlvUmdQR1oxSVNnc1BxZnphKy9yNk12d0Vab2hubU1BaEJj?=
 =?utf-8?B?Wi9GSEh4NWNMR0wrandxYU9xTG40ZmxZa0FBeXNBY1A3aWVtVjBGNlFaM2gr?=
 =?utf-8?B?eHlrSUh3L1pKazNqcjM5MzF2QWtJU2VsenR5Q1pJRWl3cGF3Y1QyVkFXOSs1?=
 =?utf-8?B?L2gzeHZlc3hJQzZtRHdZc2RSMGc1OTRGK2l0YUNGSHY3dUtiaVhGTlJHb0sy?=
 =?utf-8?B?cUV5cTZtS3JZeFdGb08yRURBY3FBRjRKVDllZFhieUZ5QVAwZ1lMOUwwaEFm?=
 =?utf-8?B?T0ZMejhKU1pDRlo3N0NWT2Qxcm1LU2lrUTRwbjFFOFdsL2RmNGxKOHEwNWRX?=
 =?utf-8?B?QU50Q1c1M0xjVmFrdHk3WVFoN0JXWG05SFZDSFU0VUdPZGd3T3A1UUFEY2RT?=
 =?utf-8?B?SXVZcUlrUm1TZENmcjV0STIwMlhMdVpUY28zNlhOenVKK2NQOHdxMTNtWmhy?=
 =?utf-8?B?aE1SNFhuM2NuTjlGVnlQYXRhd2YxUE5GL3B4cGlXbUlNTmNTTWFiVldud2Jt?=
 =?utf-8?B?blljeW1DYllZUUJMaE4zTVQyWFBCMzQ2dFpHV090dGkwcFJGZUxURElscVI5?=
 =?utf-8?B?QkRETnkxYmV0WWEzRy9DMkpoYnFwNmp6WmFjajVnT1d6WEM0SjZJd0Q4QS9C?=
 =?utf-8?B?VGVHMVdmd2x5U1BEN3duMFJsVVVXRUdlOUk2SDJvemdmSXBqTGROTkh2WFFW?=
 =?utf-8?B?N0gvcFV1RDZmNkExUnhEUTM3ZlloMjJxclZBOGpxUHV5WnJWR0xEd1NGZVFx?=
 =?utf-8?B?Z3hveTZ1WXM5emJXemF2eENxLytSdjlXU1d4SkN4QnlSOTdjaFRDVjZ0M2lj?=
 =?utf-8?Q?1C/BcLPDFvl9wwdvutqWBCw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1018DB8A1580D54BB1534D12F4CED1AF@prod.exchangelabs.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: missouri.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR01MB7675.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e13304-ff63-43c4-9ad7-08dcbcd2c355
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 02:34:18.5684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e3fefdbe-f7e9-401b-a51a-355e01b05a89
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XOK+f0J1Ma591clMQ+P9R0JqGWoYZ8zp6d3/RIJ+mWN5CbBgkGfAeqqy6i/j8Rhh4bNCtAiCJp2Hu3zAcVHeOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7035

SGkgU3Jpbml2YXMgS2FuZGFnYXRsYSBhbmQgRWthbnNoIEd1cHRhLA0KDQpPbiA2LzI4LzI0IDA2
OjQ1LCBzcmluaXZhcy5rYW5kYWdhdGxhQGxpbmFyby5vcmcgd3JvdGU6DQo+IEZyb206IEVrYW5z
aCBHdXB0YSA8cXVpY19la2FuZ3VwdEBxdWljaW5jLmNvbT4NCj4gDQo+IFVudHJ1c3RlZCBhcHBs
aWNhdGlvbiB3aXRoIGFjY2VzcyB0byBvbmx5IG5vbi1zZWN1cmUgZmFzdHJwYyBkZXZpY2UNCj4g
bm9kZSBjYW4gYXR0YWNoIHRvIHJvb3RfcGQgb3Igc3RhdGljIFBEcyBpZiBpdCBjYW4gbWFrZSB0
aGUgcmVzcGVjdGl2ZQ0KPiBpbml0IHJlcXVlc3QuIFRoaXMgY2FuIGNhdXNlIHByb2JsZW1zIGFz
IHRoZSB1bnRydXN0ZWQgYXBwbGljYXRpb24NCj4gY2FuIHNlbmQgYmFkIHJlcXVlc3RzIHRvIHJv
b3RfcGQgb3Igc3RhdGljIFBEcy4gQWRkIGNoYW5nZXMgdG8gcmVqZWN0DQo+IGF0dGFjaCB0byBw
cml2aWxlZ2VkIFBEcyBpZiB0aGUgcmVxdWVzdCBpcyBiZWluZyBtYWRlIHVzaW5nIG5vbi1zZWN1
cmUNCj4gZmFzdHJwYyBkZXZpY2Ugbm9kZS4NCj4gDQo+IEZpeGVzOiAwODcxNTYxMDU1ZTYgKCJt
aXNjOiBmYXN0cnBjOiBBZGQgc3VwcG9ydCBmb3IgYXVkaW9wZCIpDQo+IENjOiBzdGFibGUgPHN0
YWJsZUBrZXJuZWwub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBFa2Fuc2ggR3VwdGEgPHF1aWNfZWth
bmd1cHRAcXVpY2luYy5jb20+DQo+IFJldmlld2VkLWJ5OiBEbWl0cnkgQmFyeXNoa292IDxkbWl0
cnkuYmFyeXNoa292QGxpbmFyby5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IFNyaW5pdmFzIEthbmRh
Z2F0bGEgPHNyaW5pdmFzLmthbmRhZ2F0bGFAbGluYXJvLm9yZz4NCj4gLS0tDQo+ICAgZHJpdmVy
cy9taXNjL2Zhc3RycGMuYyAgICAgIHwgMjIgKysrKysrKysrKysrKysrKysrKy0tLQ0KPiAgIGlu
Y2x1ZGUvdWFwaS9taXNjL2Zhc3RycGMuaCB8ICAzICsrKw0KPiAgIDIgZmlsZXMgY2hhbmdlZCwg
MjIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL21pc2MvZmFzdHJwYy5jIGIvZHJpdmVycy9taXNjL2Zhc3RycGMuYw0KPiBpbmRleCA1Njgw
ODU2YzBmYjguLmE3YTJiY2VkYjM3ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9taXNjL2Zhc3Ry
cGMuYw0KPiArKysgYi9kcml2ZXJzL21pc2MvZmFzdHJwYy5jDQo+IEBAIC0yMDg3LDYgKzIwODcs
MTYgQEAgc3RhdGljIGludCBmYXN0cnBjX3JlcV9tZW1fbWFwKHN0cnVjdCBmYXN0cnBjX3VzZXIg
KmZsLCBjaGFyIF9fdXNlciAqYXJncCkNCj4gICAJcmV0dXJuIGVycjsNCj4gICB9DQo+ICAgDQo+
ICtzdGF0aWMgaW50IGlzX2F0dGFjaF9yZWplY3RlZChzdHJ1Y3QgZmFzdHJwY191c2VyICpmbCkN
Cj4gK3sNCj4gKwkvKiBDaGVjayBpZiB0aGUgZGV2aWNlIG5vZGUgaXMgbm9uLXNlY3VyZSAqLw0K
PiArCWlmICghZmwtPmlzX3NlY3VyZV9kZXYpIHsNCj4gKwkJZGV2X2RiZygmZmwtPmNjdHgtPnJw
ZGV2LT5kZXYsICJ1bnRydXN0ZWQgYXBwIHRyeWluZyB0byBhdHRhY2ggdG8gcHJpdmlsZWdlZCBE
U1AgUERcbiIpOw0KPiArCQlyZXR1cm4gLUVBQ0NFUzsNCj4gKwl9DQo+ICsJcmV0dXJuIDA7DQo+
ICt9DQoNClRoaXMgYnJva2UgdXNlcnNwYWNlIGZvciB1cy4gU2Vuc29ycyBzdG9wcGVkIHdvcmtp
bmcgaW4gU0RNODQ1IGFuZCBvdGhlciANCnFjb20gU29DIGRldmljZXMgcnVubmluZyBwb3N0bWFy
a2V0T1MuIFRyeWluZyB0byBjb21tdW5pY2F0ZSB3aXRoIHRoZSANCmZhc3RycGMgZGV2aWNlIGp1
c3QgZW5kcyB1cCB3aXRoIGEgcGVybWlzc2lvbiBkZW5pZWQgZXJyb3IuIFRoaXMgd2FzIA0KcHJl
dmlvdXNseSB3b3JraW5nLiBJIGFtIG5vdCBzdXJlIGlmIHRoaXMgaXMgaW50ZW5kZWQuIEhlcmUg
YXJlIG15IHR3byANCm9ic2VydmF0aW9uczoNCg0KMS4gaWYgY2hhbmdlIHRoZSBpZiBjb25kaXRp
b24gdG8NCg0KYGlmICghZmwtPmlzX3NlY3VyZV9kZXYgJiYgZmwtPmNjdHgtPnNlY3VyZSlgDQoN
CnNpbWlsYXIgdG8gaG93IGl0J3MgZG9uZSBpbiBmYXN0cnBjJ3MgYGlzX3Nlc3Npb25fcmVqZWN0
ZWQoKWAgZnVuY3Rpb24sIA0KdGhlbiBpdCB3b3Jrcy4gQnV0IEkgYW0gbm90IHN1cmUgaWYgdGhp
cyBpcyBhbiB2YWxpZCBmaXguIEJ1dCBjdXJyZW50bHksIA0KZmFzdHJwYyB3aWxsIHNpbXBseSBk
ZW55IGFjY2VzcyB0byBhbGwgZmFzdHJwYyBkZXZpY2UgdGhhdCBjb250YWlucyB0aGUgDQpgcWNv
bSxub24tc2VjdXJlLWRvbWFpbmAgZHQgcHJvcGVydHkuIElzIHRoYXQgdGhlIGludGVuZGVkIGNo
YW5nZT8gDQpCZWNhdXNlIEkgc2VlIGEgbG90IG9mIGFkc3AsIGNkc3AgYW5kIHNkc3AgZmFzdHJw
YyBub2RlcyBoYXZlIHRoYXQgZHQgDQpwcm9wZXJ0eS4NCg0KMi4gSW4gdGhlIGBmYXN0cnBjX3Jw
bXNnX3Byb2JlKClgIGZ1bmN0aW9uLCBpdCBpcyBjb21tZW50ZWQgdGhhdCwNCg0KIlVuc2lnbmVk
IFBEIG9mZmxvYWRpbmcgaXMgb25seSBzdXBwb3J0ZWQgb24gQ0RTUCINCg0KRG9lcyB0aGlzIG1l
YW4gYWRzcCBhbmQgc2RzcCBzaG91bGRuJ3QgaGF2ZSB0aGUgYHFjb20sbm9uLXNlY3VyZS1kb21h
aW5gIA0KZHQgcHJvcGVydHk/IEluIGZhY3QsIGl0IHdhcyByZXBvcnRlZCB0aGF0IHJlbW92aW5n
IHRoaXMgZHQgcHJvcGVydHkgYW5kIA0KdXNpbmcgdGhlIGAvZGV2L2Zhc3RycGMtc2RzcC1zZWN1
cmVgIG5vZGUgaW5zdGVhZCB3b3JrcyBmaW5lIHRvby4gSXMgDQp0aGlzIHRoZSBjb3JyZWN0IHdh
eSB0byBmaXggaXQ/DQoNCkkgZG9uJ3Qga25vdyBtdWNoIGFib3V0IGZhc3RycGMsIGp1c3QgcmVw
b3J0aW5nIHRoZSBpc3N1ZSBhbmQgZ3Vlc3NpbmcgDQpoZXJlLiBJdCB3b3VsZCBiZSByZWFsbHkg
aWYgdGhpcyBjYW4gYmUgZml4ZWQgYmVmb3JlIHRoZSBzdGFibGUgcmVsZWFzZS4NCg0KVGhhbmsg
eW91LA0KSm9lbCBTZWx2YXJhag0KDQoNCg==

