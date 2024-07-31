Return-Path: <linux-kernel+bounces-268944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E27942B6C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC3D91C20961
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77E91AB53E;
	Wed, 31 Jul 2024 10:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="mymBAt5t"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2041.outbound.protection.outlook.com [40.107.255.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972EC1AB526
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 10:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722420113; cv=fail; b=aPi+vaMz8AXg5IpvnclMZSiiyrgHOShAKZ0VCrz7HNFLJ0hkj7i2GuLCejoI87ipzBhC1MlGKQIsvxJpYIo3YcfPMge0y4W9a97e2r3HjMaoXodsgeKUhXlRRA97l+iwQHZarQzJc2iV8EE/tHNwgBcATxsRiPdVS3M8Yv8IJeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722420113; c=relaxed/simple;
	bh=L2jngBA+tH4otzF1DfUlnJNMu2pf8VaP2iiOdm0vtZ8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tSltPCkZgOoYSxnxbLRvgXsn05AHA4VOWq+DqlkAEsD2auunu6i3nHcx+UbJGNmY9rcWlzg6hheJeefeIcWIy5iJuLto3rSOBKY9zNhYTno8AqqJROcs4e/GjAWD/mLi9dM4yjSj3A2+pMJ55SLIzfVIHwHWGg3DrzfizajUvew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=mymBAt5t; arc=fail smtp.client-ip=40.107.255.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EdXdLIFWmVlzF1BoREpLWZRlkWp+9qfEOh37/p0RvfVY8pJaZdFIpkYpmFdNpzxnQCQmfG/3obxwyUaMiQPZmLLsJaICMg6yEn8xQO6/HBWSXwXRXQqKfIkdjCFGWrl6zPMEzBPBuxZ38bBlfKeL6bh7JNlYvCCHv3i7/N6eHYVa3g6bvbCzWQtOThdbmiCJHuy2p+ZLW5PAO3grP3sjcGkb01m13fpV1yeY1vOYjHFyMe880kxZXQac9DvumWh+c1hTXcKxhjNL988PhpKIR5GKudn+p4kssoQPbCX9R7MBjA2Xcj6rNKkDh+v1OV+HGqvPYEdl9zPEAr1+iFr7Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2jngBA+tH4otzF1DfUlnJNMu2pf8VaP2iiOdm0vtZ8=;
 b=xSyRF/H1k6yIGWU+2d3O9CZNjXNUfCLrjOHZEOxMcWbFHiqdHdXhIjv9jJthTrde4OxeoNIw1WtZ2dAkkNfLU7Wzcf6cd/xqza2SYyGuwKYEiqEiLht0OOS9Td2Vk2kpKVWRhZVL0gz3B0JVVSntVRxC0I5lpRGdV9YxMNaxYFIqnY4Iycwsq4NJoO0XqO6lgZ4tsTq2pnZf04TZ8+HYearTcd2WsyBjJNYGLGbV6I78c6DqRB3IUsiZr9OpfpCH5NtD5ZL81uQzWvbOCUNO2a0aSSP5wp3wfWFOXBDcZ0nVedmjIec6acGv6seBOjvn09zFDSWxzsprcVG7vPG8Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2jngBA+tH4otzF1DfUlnJNMu2pf8VaP2iiOdm0vtZ8=;
 b=mymBAt5tUqbpYHGQHmCgppkCTrMW2oCD2QVtQJ9kftWl2HDTEumh7hGwXvKTjmqqth2qTyQmnWAz4+pWLPyR2LHvHjAP4lp8bDLqAFj7J8/jmIVVolteuG2lb9bpmaK90yNiduhZxLtVGpTNufWzEDq9SGvOWU9KzWVRI1/zrt6ClaPt1wSVmUMI2rgps7gweKJilnrI+ZSTA7Uz/n+CjkYFOehuyBimktDMPOhliAlsXJIteVBKZQE/f3teDN6OSxFSsaat7tlR/7bQTE3UvauTch72J0/UMCTwHjLzPVaW4Tk6QtxaSPOTMDymkqhjgdUH3fYcmTESkEA+H9JtNQ==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by TY0PR06MB6853.apcprd06.prod.outlook.com (2603:1096:405:11::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 10:01:45 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 10:01:45 +0000
From: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>
Subject:
 =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlOWkjTogW1BBVENIIHYyXSB1c2I6IGdhZGdl?=
 =?utf-8?B?dDogdXZjOiBGaXhlcyB0aGUgYWJub3JtYWwgZW51bWVyYXRpb24gcHJvYmxl?=
 =?utf-8?Q?m_of_mobile_phone_as_UVC_camera.?=
Thread-Topic:
 =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRDSCB2Ml0gdXNiOiBnYWRnZXQ6IHV2Yzog?=
 =?utf-8?B?Rml4ZXMgdGhlIGFibm9ybWFsIGVudW1lcmF0aW9uIHByb2JsZW0gb2YgbW9i?=
 =?utf-8?Q?ile_phone_as_UVC_camera.?=
Thread-Index: AdrjL9q1PD7TIVFhTm+5hceneIlBvQ==
Date: Wed, 31 Jul 2024 10:01:45 +0000
Message-ID:
 <TYUPR06MB621792398C6E5CF084D4586DD2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|TY0PR06MB6853:EE_
x-ms-office365-filtering-correlation-id: 9b307bf0-7f38-4a2e-f16a-08dcb147c930
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VkM4RUhjZEtKVUdmamNoRkVNRFFaWlhuSFd1UzdUMXR5eHFHeWQxRUVQcm9N?=
 =?utf-8?B?RVl2ODJpV1hrNXFTR0xmTnpVM1ViWTFrSXZJVXNCQlBhbWFvanJYRWx2Ni9T?=
 =?utf-8?B?VlYxbDh2TmxBRUd5SllORWNzYXYzYXNUdHc5OTAwTGtOTDE3S2FjQmdKVWNa?=
 =?utf-8?B?YkRJUGlpTWVpSkdnbVNNK3NiYjM0WW5nV0ZZV3lzcXNiZEdmTFZWaEpra0w4?=
 =?utf-8?B?NWE2ZkhmRkVtZ0lMVllxVzROSmUvTGZ5Y09xWUFiZ0dMaXdNczg5czBhR3hx?=
 =?utf-8?B?VGtPbzJtRUEvSjlLdWhlQlFLNmFEWlYrektwaUY3NWtST2VaSExORmJVVm04?=
 =?utf-8?B?YzZ0R3dodkZ5L1RiWHRCdE1kb3FJNCt2eTdSMHpxYWRuQUhKakVmM0JmL3lU?=
 =?utf-8?B?TE8zMGlxcFhDK1JKM2dDS0ZpU2I4aUZuaGV4bmtERUZEMVdUMkNCZGtXdG4z?=
 =?utf-8?B?ZGpiYStYdXpiWHVnVXdRK1cxRmxJV1FZWU1uQVd4YzZKbFVRZUgycGxUeTdh?=
 =?utf-8?B?czJwelBGTEwxdUFkNGVUTDZkSHFMZDRqYzB2UWwwYzlRUTlGQUJ1S1phNEFh?=
 =?utf-8?B?eVF5WVRySXRlcXVHV2NCSUIxZncxcUd6ZWd1blZ5YU54UXVkYWk4YjVYRjlO?=
 =?utf-8?B?RlJlQnZCcUUrL0hIeFZldTlocUlxeFNBTmpIRFU0dUpWVURkaHFCT2NzOVB1?=
 =?utf-8?B?Ni9hMEpUWDF1ejBLU2poNXEzZVE2UmNZYW1POEc1WVhsZ3lrR1ErS1BsekRq?=
 =?utf-8?B?U3NyV0xVbDA5YzBUTFJhVExmL21IUmRoL0VyOXgrcE5RV3p3ZlkwM2dIWFdm?=
 =?utf-8?B?QndGdWpTaVl1QmFwODFkSFZNTDl0TkpkMi82b0xnTDkwVDZ5VHkzTS9Ib3pp?=
 =?utf-8?B?bUw5cmhaazZtdEdCR01vbGxxQUx5aVl3ZEFoVzBGQ3ZZU1VGSy95RXFaSE1N?=
 =?utf-8?B?RkNsK0ZkeTVMSjloY0hxOHBTdXlLa2lVd1JRQTJOTllmRlUwQ0h4RldQT25w?=
 =?utf-8?B?emhlTnBFdmIrSUh5d1NybUxiSkRrQXBkTm5mTzA3QTNMeG95bGZPejBoN1JJ?=
 =?utf-8?B?b3V5bDJuTnVvYUtENnU4TzF2RUMrRkt5VlRiVE9sbVYwM2taMG5wdGN4Tmpz?=
 =?utf-8?B?TkNlMjVrWEoxd0IwYXBYeStxdndTdkFoMWRuVU1jOEJadUxyY001K2FneVhs?=
 =?utf-8?B?dm9QTDZXQ25VaVgwSnVoMEdsQ2QyeXVUU1RXOFdqT0ZGSDM4b2J2MG5ybzJm?=
 =?utf-8?B?VTh5Y0QrRFlrLzFmUEJOQVpRckFwTW8xdTR2Y29EbzNKWkwvNGk3QzdTMWFh?=
 =?utf-8?B?bmtZdVczeCs3MkJHVDh2SS90aUluZXlDaUtDQllXMmUxNkZUK1pyUE5SbUx3?=
 =?utf-8?B?K2J5VVpTYUdIN3lOejZsbzFjZzhyVmd4YWhmb1NLME1lSUhGaysrVDh5NWNJ?=
 =?utf-8?B?R3RidWNJWlc5OFBnVW1hQkpmWkczZDFsVkdrN1dsK21SSmt6b2FRWWZsM052?=
 =?utf-8?B?ZlRuOWRlMjBUZjZFV3JNZm5zMmVUSnpBVk9xMUxjekRISkxtZ21WMlZOSXJQ?=
 =?utf-8?B?MDk2Ull5czVnOHR0elJ6Sk5LK3B0OTJFcUJGakgxeXlVQjRVTVg3NDVSZWtx?=
 =?utf-8?B?WUFvUmlXTVZ1cExtdGk4b3hCNDlSSFZqbUc4ZFRmR0hZdXVaRGNaYWxBZzRY?=
 =?utf-8?B?d3Z1YW9iZmpGNkpGOGQ0MGFCSHZTMzBicFE1STIxMW5WcFNESkI0dzF4UXQz?=
 =?utf-8?B?aU93cUFsNlBpSm5NWVJrTHg5STRxR28vZnkySWZiR1did1RrbzkwZnZmRFlj?=
 =?utf-8?B?OHh5RlF4blo1WTh2M0I1L1pLaTNSbmJPNnpvU1MrTGFYcFozSTlyOFo3dXdQ?=
 =?utf-8?B?TGpqV1hpbjAvamxtcmFkTm50MGhpRmNIdFBhRGVPdmlzS2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MC9lL2d4SkxDQ0pVS3J1YmRRdWkvcDgxZDdWSmd4RmhLTlFTZHRWNmdPYUM0?=
 =?utf-8?B?ZHlJMnhRMmZuNytBSmxoVGlwVXpmcGVJM1lLVXFjZm82MjBEUkVYT2Q3di9t?=
 =?utf-8?B?eXY1b216eU15cVQrR3lKblV5eUFESVBzU1NuT2V4dHN1SUVqZklTek5CZHFV?=
 =?utf-8?B?UVl4Z0hFek9rUGhYWUFreUM0SWJDYU9oYlhKL1NGWXBHQW5kZW8wY0x4dkZ0?=
 =?utf-8?B?c2w3ZjA5T1dFejBlK3dZWFpud3EyQ2JGdThJREdPM2RtbnVHd1I1cFEzQTRR?=
 =?utf-8?B?T0QvdXZiMzBTU0orRTJXNXlPanRDdTBvb1lNNDIvaDdzVXNtdWJwVXcvSis3?=
 =?utf-8?B?T1RXS293dmZmckxydTdsOHVETFJTWUFxWUZWTTN6dy8zV0lkZitvQ1BkcnRH?=
 =?utf-8?B?WkNCM1JUQlN1Wm8rL044dmJWOENXOUVpQlJlU1BGRWUxSEpnVlM2eGNabEp4?=
 =?utf-8?B?UnM1REc1WEpybVViblpaUnNBVDFJSWMwZDF4SzdSN09qWFBJTEpwbHdKcGpQ?=
 =?utf-8?B?a05zRXNHdFJya25zdXRaTFdBR25DS1N2djZuNmZCOWprSWN5VitNa3hlcDBB?=
 =?utf-8?B?UWQ0a2RmWUFIbXo4SXVVKzhTNUY4MGFXUXB3UEtLdmtIK3ZuWmpSQUJpQjFW?=
 =?utf-8?B?dWwrSk5icmxSYjRTTWNmUEZiamhRL202NCt2NCt1RWFneHJINENrSzlodUU5?=
 =?utf-8?B?ZFd3blg1cStzVFZTSWh3M3FHeTZOb1FVditmSk9rSDdGdG1DNkgrbFRBU1Jo?=
 =?utf-8?B?dVJRMlRqMHpRcGN3Q2NKVmcyUWdqaDB4UW5ZQUkrVTZLa2V5b21LdkVydlpX?=
 =?utf-8?B?Mk9LZjdEUHkxNmptWVcxUXA2bURCazVnZWVEd25kRUdMWWZZNm5QLzdtV1RH?=
 =?utf-8?B?Ry9RckM2bUZIdnVBOUowbnNZT3FCa1FmdjVLYUx4MHl2TWpIZGlpdC9ZQ24r?=
 =?utf-8?B?elpyRHBRcXpmUHZIRm8zK1QvZ0hSN3JmK3pkZzdlc012QVVwSnNHMHd4SmZX?=
 =?utf-8?B?QTltMDFrTGtFbEN5ck53UWdiTnppOU5USXE4R1dFalY3bHFhU3FrMDJwb0k0?=
 =?utf-8?B?NENaUGFIbmUwUTZWVncrRTYyd1VBR2pzVElSbHJ0N1NEL1M1b2FGWlA0d3RK?=
 =?utf-8?B?bkx2bVdycVlic1RlNHl5Q0ZMZlY2ekRnUTI0NmZ4cEQ0dEYwQlo0dUl0SUN3?=
 =?utf-8?B?aVUyQXNtVldaYmVHV29oSmh2aHI5VnZtYjNPV2JRTHk1MFZyUE9JSnd2dlVo?=
 =?utf-8?B?L2VoY1d1Q3NLR0pxM1pQelZydVdIY05GYThlVUpJY2RaOVZGZjdLL0xDMEI0?=
 =?utf-8?B?WmtJRFRPNURXNmtISVpYRjNCY2gyRkNpM05xNGRDQ1hsTVVLREdodUZ4NnZX?=
 =?utf-8?B?TlBQN0RXdUNGeE9IVXYvT1VFaUIrUFhTQlMxUm56Qm5Cb3hMRm5RSGRTVVFB?=
 =?utf-8?B?cHNWWVhERWJHYk5HQVlITEN1d2FtbTlYa2kwdU8zbm1Bd2JMckNOVmJHTmI3?=
 =?utf-8?B?Y3dNNklJaVVUc1VGdXJyWVJDL2xsTVQ2Z1JUbGM0NzhVTFk0N0dmbWdVczZQ?=
 =?utf-8?B?M3RaT2IrbmJyWkZxclprZC9zNXdMY09GRXpWTE84S0hIdjU4TStWMmVCWDlq?=
 =?utf-8?B?Um5tb3JRMERkUElEeHd1UmtJaTNVMFBpSGFWRW5QazFMMWxaNWkwaktUUlhu?=
 =?utf-8?B?WkVEK1R2ZEpselB1NkZTNEtNa2dzSHhyMmpSWWg2UUc4ZFhLajlJMGdXSVFR?=
 =?utf-8?B?QXhydW50cWZaRXdVTWpNSmJ6S0h6a0FZbkRQeGVDNlcrU2Iyek5nSmRKTmNj?=
 =?utf-8?B?cGQrSE4yZWg5MHdYeWdudWtjSkFUTzJva2YrNEdFYkkzWG5PSjdPcDdPZU9K?=
 =?utf-8?B?ZElsR3RjV092dGh0MFdidW9PbjQ1Z3U1TDJRTjZSN29aMFMxQUEyZmFLa2FW?=
 =?utf-8?B?SC81VTJEc25jbkJESktLRlp1QUk0Y08wSWoxZTg1THNLV3RTYTc1R1UxTE1P?=
 =?utf-8?B?eW9nRjNzWi8zUFc0eUMyQnBCSC84NlZBQW1yL25BVkE5U3JOQVhsOE5FR1E2?=
 =?utf-8?B?WWtkMGk0T2p2QkNFL0p5UDR0MU8wVWFwRDVDWUFYU3cxTmJJblEwSzdTRXpu?=
 =?utf-8?Q?n14Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYUPR06MB6217.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b307bf0-7f38-4a2e-f16a-08dcb147c930
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 10:01:45.5494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ezE5zjoeOUiayLJYkQPNhwMkY9C1pHq81O0G1xhBERvpXMe0Q/L0urWYsCIK8J16Suiznq8DnyCMfzQ0eIllxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB6853

SGVsbG8gbGludXggY29tbXVuaXR5IGV4cGVydDoNCg0KSSBzZWUgbm8gIkZpeGVzOiIgdGFnIGhl
cmUgOigNCiAtLS0tLSBNb2RpZnkgdGhlIGVtYWlsIHRpdGxlIEZpeGVkIC0+IEZpeGVzDQoNCkZy
b20gdGhlIHByZXZpb3VzIGNvbW11bmljYXRpb24sIHRoZSBmb2xsb3dpbmcgbWVzc2FnZSBzZWVt
cyBub3QgdG8gYmUgcGxhY2VkIGluIHRoZSBib2R5IG9mIHRoZSBlbWFpbCwgDQpzbyBJIGNoYW5n
ZWQgdGhlIHRpdGxlIG9mIHRoZSBlbWFpbCB0byBpdCwgc28gdGhlcmUgaXMgLSBNb2RpZnkgIkZp
eGVzOiIgdGFnIG9uIHRoZSBjb21taXQuDQoNCnVzYjogZ2FkZ2V0OiB1dmM6IEZpeGVzIHRoZSBh
Ym5vcm1hbCBlbnVtZXJhdGlvbiBwcm9ibGVtIG9mIG1vYmlsZSBwaG9uZSBhcyBVVkMgY2FtZXJh
Lg0KDQpUaGFua3MNCg0KLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0K5Y+R5Lu25Lq6OiBncmVna2hA
bGludXhmb3VuZGF0aW9uLm9yZyA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+IA0K5Y+R6YCB
5pe26Ze0OiAyMDI05bm0N+aciDMx5pelIDE3OjQ5DQrmlLbku7bkuro6IOiDoei/nuWLpCA8aHVs
aWFucWluQHZpdm8uY29tPg0K5oqE6YCBOiBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBvcGVuc291cmNlLmtlcm5lbCA8b3BlbnNvdXJjZS5r
ZXJuZWxAdml2by5jb20+DQrkuLvpopg6IFJlOiDnrZTlpI06IOetlOWkjTogW1BBVENIIHYyXSB1
c2I6IGdhZGdldDogdXZjOiBGaXhlZCB0aGUgYWJub3JtYWwgZW51bWVyYXRpb24gcHJvYmxlbSBv
ZiBtb2JpbGUgcGhvbmUgYXMgVVZDIGNhbWVyYS4NCg0KT24gV2VkLCBKdWwgMzEsIDIwMjQgYXQg
MDk6Mzk6MTZBTSArMDAwMCwg6IOh6L+e5YukIHdyb3RlOg0KPiBXaGVuIHRoZSBwaG9uZSBpcyBj
b25uZWN0ZWQgdG8gdGhlIGNvbXB1dGVyIHRvIHVzZSB0aGUgd2ViY2FtIA0KPiBmdW5jdGlvbiwg
dGhlIHBob25lIG5lZWRzIHRvIGJlIGVudW1lcmF0ZWQgYXMgYSB1dmMgY2FtZXJhIGZ1bmN0aW9u
Lg0KPiANCj4gQmVjYXVzZSB1dmMtPmZ1bmMuYmluZF9kZWFjdGl2YXRlZCBpcyBjb25maWd1cmVk
IGFzIHRydWUgaW4gdGhlIGZfdXZjIA0KPiBkcml2ZXIgdXZjX2FsbG9jIGZ1bmN0aW9uLCB0aGUg
dXNiX2dhZGdldF9kZWFjdGl2YXRlIGZ1bmN0aW9uIGlzIA0KPiBjYWxsZWQgZHVyaW5nIHRoZSBl
eGVjdXRpb24gb2YgdGhlIGNvbmZpZ2ZzX2NvbXBvc2l0ZV9iaW5kIGZ1bmN0aW9uIHRvIA0KPiBz
ZXQgZ2FkZ2V0LT5kZWFjdGl2YXRlZCB0byB0cnVlLCB3aGljaCBpbiB0dXJuIGNhdXNlcyB0aGUg
DQo+IHVzYl9nYWRnZXRfY29ubmVjdF9sb2NrZWQgZnVuY3Rpb24gdG8gZmFpbCB0byBjYWxsIHRo
ZSBjb3JyZXNwb25kaW5nIA0KPiBjb250cm9sbGVyIHB1bGx1cCBvcGVyYXRpb24gKHN1Y2ggYXM6
IGR3YzNfZ2FkZ2V0X3B1bGx1cCwgDQo+IG10dTNfZ2FkZ2V0X3B1bGx1cCksIGFuZCB0aGUgVVNC
IGNhbm5vdCBiZSBlbnVtZXJhdGVkIG5vcm1hbGx5IHVuZGVyIA0KPiB0aGUgdXZjIGZ1bmN0aW9u
IGNvbWJpbmF0aW9uLg0KPiANCj4gQWZ0ZXIgYXBwbHlpbmcgdGhpcyBwYXRjaCwgd2UgbWVhc3Vy
ZWQgdGhhdCB1bmRlciB0aGUgdXZjIGZ1bmN0aW9uLCANCj4gdGhlIGR3YzMgY29udHJvbGxlciBh
bmQgdGhlIG10dTMgY29udHJvbGxlciBjYW4gYmUgZW51bWVyYXRlZCANCj4gbm9ybWFsbHksIGFu
ZCB0aGUgd2ViY2FtIGZ1bmN0aW9uIGlzIG5vcm1hbC4NCj4gDQo+IFRoZXJlZm9yZSwgbW9kaWZ5
IHRoZSBmX3V2YyBkcml2ZXIgdG8gcmVtb3ZlIHRoZSBvcGVyYXRpb24gb2Ygc2V0dGluZw0KPiB1
dmMtPmZ1bmMuYmluZF9kZWFjdGl2YXRlZCB0byB0cnVlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
TGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8uY29tPg0KPiAtLS0NCj4gdjI6DQo+ICAgLSBNb2Rp
ZnkgIkZpeGVzOiIgdGFnIG9uIHRoZSBjb21taXQNCj4gICAtIE1vZGlmeSBkZXNjcmlwdGlvbiBp
bmZvcm1hdGlvbi4NCg0KSSBzZWUgbm8gIkZpeGVzOiIgdGFnIGhlcmUgOigNCg0K

