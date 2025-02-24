Return-Path: <linux-kernel+bounces-528546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDE7A418EA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E119B189BF95
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A8824C67A;
	Mon, 24 Feb 2025 09:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iris-sensing.com header.i=@iris-sensing.com header.b="sC09fKxU"
Received: from BEUP281CU002.outbound.protection.outlook.com (mail-germanynorthazon11020140.outbound.protection.outlook.com [52.101.169.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5673824C689;
	Mon, 24 Feb 2025 09:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.169.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388749; cv=fail; b=H6QGZ8stNpsY5TWYXtaWoyux7OCHSQKvKPfXaWqFjlJPgPDk4VC/J6idT/qr8obaS+OGyQ2pdHMTFS4WXjS93YBZhWfSOlSoDpQlB5M7jc9xngymxiUbZpgn1Hz3il+uj5trO8X+kAsWSo6B0ylkaJd2t5YwfJc4KHTe1jTly4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388749; c=relaxed/simple;
	bh=4XqCd1TS4BGqAN3Q7w+XCVq8IRcH+HXmYHWvLLaRYOo=;
	h=From:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oENA17Ax5W/k7AL8J1xR6EzdkdW6wxUDrwpjdFTrpTJYgCvMCnMCsAafOE20WSsOjT6p6J9EcyQH63+olWxqe3/nIgLwc3+hdkE/XX578FrP5vZS/YPt6R3aDpuacPXPCXMVeFqFLThAayi7JXbtR56MLSV+NTFHblo93heGZmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iris-sensing.com; spf=pass smtp.mailfrom=iris-sensing.com; dkim=pass (2048-bit key) header.d=iris-sensing.com header.i=@iris-sensing.com header.b=sC09fKxU; arc=fail smtp.client-ip=52.101.169.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iris-sensing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iris-sensing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/a8C0Js/jTY95NmfTvOxchkij77UMi1jXYh2xbNCCzt6ORHpV+lME+f7OrwJfgC1uvY/RU083UGcmyea9/Dga027O0VL2CDBPWGAGQhye5ZLEOhZpMCaBRF6iFgVJWY7QQnb3yqXiwcyYl6sZ9cQI748b8kMxFJbMjFYdC78laiXPQgOAUHNvpxkiYMOk27c3dvwQ2FRlpNBYvCBcV1Ekl8JRIXluWiwfiFc6iv1L6bI+kkob7flfhPkK2vMnbF7SDmXNCP/RMybYeZm8lriosXHyBSWRwY0ZmlJtVvxYtTweaaNLxtIjTnUaaptB6ezE1xOlXUY22PJsx+r1Nksw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XqCd1TS4BGqAN3Q7w+XCVq8IRcH+HXmYHWvLLaRYOo=;
 b=XDB8gUwA7z7aSMKkWs1KN3pJI4CdZth+a0bMjWSGAWUJ9eoAO4VVNOAG2w5aFs+/U3DbvxlFjKHK4zi9pvXbCWnT4OPITKHx0uslbMXotkSe2gZthjXLzx3Q+tZPiKaWVG6bFuKjdqXHdHzFHLo9mQHIS/xwWjuhk+2mjkHrfAVgTo1tC4Q403aRqGj8lp/Pg09+KBNn3koK15WOLwHTMDnukfRZqbjBqVKH+pmikjRcpBa/rKwUCKGPTTYj5qKxAefAmEHIjL6Xf1v5f8MIMSW9vXdG9P7E/0zBAYXRyBk0WPdi2QNsI1+3ZpT6kohklfoPsjijPX1aJu1cO2vGoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iris-sensing.com; dmarc=pass action=none
 header.from=iris-sensing.com; dkim=pass header.d=iris-sensing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iris-sensing.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XqCd1TS4BGqAN3Q7w+XCVq8IRcH+HXmYHWvLLaRYOo=;
 b=sC09fKxUZEiJfAfPEjj/c1l5BRICUTjbCU+wiyvgsSUcfW9vI02fQ9awK67eSHZ5SSlAnYAY+qIkivTFwXr9HmFxzt2sgfMQrbTKHzkWDFgVbB8Qd27NE7JkJPxnbY59bxZyS148ErLL7bKaf36sECgQvlkm3myP98nkriKyEh/d0c+05RT8XgaJN8rajaUlh61CdGRS1pMp65YuASJwbCKqD+qbCxhOmSti7hCgn6u+ycv23pxjQsj5+PIYQ3Op104wOtIcQdpydIXnPypKEZ0+ZvfUmokSAe7AF+6msiGg2QxVOGYnMrZ5DUsVaaJ/7fYyvVOExCcU49zQ466dcg==
Received: from FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:23::8) by
 FR5P281MB4138.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:104::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.21; Mon, 24 Feb 2025 09:19:04 +0000
Received: from FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d685:f312:e114:519e]) by FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d685:f312:e114:519e%3]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 09:19:04 +0000
From: Erik Schumacher <erik.schumacher@iris-sensing.com>
CC: "linux@roeck-us.net" <linux@roeck-us.net>, "linux-hwmon@vger.kernel.org"
	<linux-hwmon@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jdelvare@suse.com" <jdelvare@suse.com>
Subject: [PATCH v2] hwmon: (ad7314) Validate leading zero bits and return
 error
Thread-Topic: [PATCH v2] hwmon: (ad7314) Validate leading zero bits and return
 error
Thread-Index: AQHbhp0lUa8a/4GXQ0ecDFY0kJm8Bw==
Date: Mon, 24 Feb 2025 09:19:04 +0000
Message-ID: <24a50c2981a318580aca8f50d23be7987b69ea00.camel@iris-sensing.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iris-sensing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR0P281MB2809:EE_|FR5P281MB4138:EE_
x-ms-office365-filtering-correlation-id: 1745f350-760f-40b6-18b7-08dd54b44877
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c1d2a1lHdTdjVlRXZENkNGVpdFlzTURzaTBtZ1B4dGJKVSt3Q1JqRUxpa3Jl?=
 =?utf-8?B?dk5DY214ZnJUdXg4UElwZVpzZHBqeFY5dkV2RUp4dGJGZ2RzSDlXL3VEV2Uv?=
 =?utf-8?B?aVcwVWxBZjVLMXJQdUV3WEhtNXhkQkJCU2FUVkN1b2xsQWZ1WWVHbFhoMm0r?=
 =?utf-8?B?dE04c1lkUkJZaDhhS1JVOThMc0p1K0N1RitSNFd0SGwwMkNlcXk2UGFBNEt4?=
 =?utf-8?B?Um1QQThCaTMwOWhydTRIY0xUbUUwajNpcDRweW51Y2Y1aXoxUWtXenowSzh0?=
 =?utf-8?B?YndDdFA1OWFhYnBZbHNIRG1PenJWTWtuL2hVRXZxc0hRbkFsemIwMUN0Y1R2?=
 =?utf-8?B?eDNCbGdnZUpIMGFEV1E5dGFlNVdRY1k1LytDOTYzMjZnTm51SklOKzd1Z2NN?=
 =?utf-8?B?Um9INFVWczhwRnAyeVR2Ryt2bFpRREtjcE9OMGpHZnNJMkhkRE82YjRzb0c5?=
 =?utf-8?B?ekxQUDhjeHltaWdnclhMVEl0aGdBUm9nNzlEaGxsOWRYQTFkcjN4UlZoa1RO?=
 =?utf-8?B?d2hpTWZzeUdhZ0tHREpRL1ZsQ3Q3Z01CTzVRZGhVT0Y2ZU9aRWh0UDZSeXRk?=
 =?utf-8?B?Q3k3UitCKzFoeW9CZzAycjYwMElUWHBzaHIyNjlYcWhSZVpReHBiOEtzOXky?=
 =?utf-8?B?b3J6LzlJTUtBWXVIckpVQ2hVRHNHTGFmYjR0cm1mb1I4dFc4WnhON3NaWVF0?=
 =?utf-8?B?d3hNYzVxUk81K095YUYwQ0dNYXFBQTFQa1NoZFRWaUtFMVViei9ZU1JpRGc3?=
 =?utf-8?B?SkU5VVAyTWFHNlUxcWhwbHVKdi9YR0FjMUt0YnhzZG85L1N4VjhQb3IxVEI2?=
 =?utf-8?B?WHdna2J5QlNveWtpR205Rjc2b3V1bDluejd0V3MrWG15cjd3Q2NXcVpFWG5U?=
 =?utf-8?B?anVuNEJFdkswUjV5U1BMMVNSRG5rc3BaSFJjbHNSVHY4RkpIOGI3TXFET0tp?=
 =?utf-8?B?cm5YTEtxQ1p6NzY5TUhiSEJPdTROQ0tZNXVRaE5rd0JaMHFKajlUUExGdVAw?=
 =?utf-8?B?bG5zK2p0ZXUvc2g3alVIcEsvcmtObDZFZW85WGsrOThabHVGN0ZydmQ4VUx1?=
 =?utf-8?B?NzF6VXVIYlV2cHJScDhIMHB2d0YwMmVsUXEwd1ovQ05rbG56OUhpRDJnS2Vt?=
 =?utf-8?B?NDI4bXN0WVhSUU50dFowYjBzdlF0WUI3WllhT29EcEFOT3dQUXFYNGg1WGFS?=
 =?utf-8?B?dTYyUDFVaEZRd1gzQmp6Q1hrM2pyN1QrdFQ2U0xzZG5oOHpPbG1WOTZKczBn?=
 =?utf-8?B?VUxRaW02NjRTSkt2bXQxVXM5b3JqVHo4c1JDWTFVY1JzR1NHQnZtcllKeGpZ?=
 =?utf-8?B?L3lndk1Od29GNVZ2SUtxZXhXV1N1Q2Y4bXZaaUZyTGRiUHpKcDZVRFZlWTJi?=
 =?utf-8?B?NHlKMzZvTjJnSVNrOGJpaGZwUklTNFhlbXNULzBsS3cyVjFCTXR1M0FiNzhV?=
 =?utf-8?B?T1BlajZoTTRCL0ludng0d2ZCMkNIOGFYNFJpbTNwNkN3L20ra3Z4YWV4c1Vk?=
 =?utf-8?B?OXFISlhmQlltYzN0Y3IrME5FYnc1VExoMllneXFJV1QyQUh4VlJNVnlCSm9U?=
 =?utf-8?B?aWM2WXJsRThYQ3Z4cXFFQ00rWGZsbWh2dEZvclhDaGdVQVJIcWduRVMxQ1NN?=
 =?utf-8?B?SDQ2Uy8yem1FSTd3NEc3OFdRb05UWVZqUzZYeWFFNEZHSk9jVnVVNWMyMUVt?=
 =?utf-8?B?K3hsQ0lvU2d1QS9idXZvQjdkY0RKbGxpMmNQRG9LekhaSXJFRU9GNkM5ZTVH?=
 =?utf-8?B?Ym5SVjJvVjJadFd1Nnk1VXRsQnNPU2dzQmx1eVdNQlBNc0NOOFF6Y2pnaGJJ?=
 =?utf-8?B?SXc3WlFYSTlOMkJDMVBtM3ZKbXNsbytFSnFOZVpwM3lHbzgrOVVmbjY0cW90?=
 =?utf-8?B?QWJxNnlYRGtaNTdENE1ibzlqMVMrRThWT1J5T2kzOWNpQ0ExTWswS2lxNGhU?=
 =?utf-8?Q?Lz/aaQoVUiKpsdtZDGmIzdjGsNytr1il?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZklVUStYMFlMWnBWdWNWcEpCcjFmdTBvUmNDTHMyczE1VTNNZXFGY3pKY3Nn?=
 =?utf-8?B?NldGZmZBcWFncmpPQVVaUjhvaGo4N0JwbXpWQkN6YTMrWGIvRWg2dDFWR1Nz?=
 =?utf-8?B?VGsrQlBLeDMrY0YxczFTRlRzT0ptYi8vWm9BMXFEL0FtUWJBQTVFSjR1YVAv?=
 =?utf-8?B?VkExR09INnlBYmR3WHprMG1yajBWNWh0czFMeThoRXduOHVqZFRBRXpWSTkr?=
 =?utf-8?B?UUdKam5vZDJMdWtrbnFrM2dlZDUzeTk5VVBIdVFDNFpzc0ZpRWdPbGR4MmNa?=
 =?utf-8?B?WkJFeFc4UEVGRnlyU2h2L0V4TVdpVkpDdklaSmpEUCtjYWk3ME5MTG1BTU1K?=
 =?utf-8?B?WHpDWW1qS2dUWjVCdFFYN0JLYUMxQkExTWhydWNvY2VIN2lqZy83ckJieW9t?=
 =?utf-8?B?U29tKy9zSDRoY1gyL3MyZ2tVSmwxZ2JNZEhybndxS2FOV3hLT2h5aG80ZStD?=
 =?utf-8?B?UVNOejJFd0pGbGhXTzE3UFplRzhwZjZSTWI0aW5PdldiMTFMeVZuNjAwNHBo?=
 =?utf-8?B?ckk1UnlNK1FRU3NXZm5CYmF2V0dSSzJMRDZmSnhsd2ppaG9XTTUzUXZFcmJS?=
 =?utf-8?B?OGFxNmtBdlZGKzM3TXNwVHBhK1BwMThXNlMwSjBuWU1ERmtzcVpEL2M0Rlox?=
 =?utf-8?B?VFJXN1JWbjZRSHQyVWxtaERsVTJjbUVvM2ZQTW5hQWV3Q0lla3VBaHZ1VlpY?=
 =?utf-8?B?K3oyckxrTW95THpNNFBNVGxPS0tXcDVpU2ZXTmN4WjBtQzA0TVdWTkpUc2dW?=
 =?utf-8?B?UGpsSzYvQTVhcmJGWGJtZGhEbWNmd2pGRmNJRElEQ0lVc1QzSU1uY25BUFZr?=
 =?utf-8?B?c2JrSFFTTm0yYU8rVTFtaTE3MENGcHZVL3N4VWQ2d3RHZi9QRVIxc1k1T2Jw?=
 =?utf-8?B?N25FZDhVS1FGUHd0VnZIaklsdUxzeGtqUFU5SVZpL2FEQVp3bUlCUXZETUFt?=
 =?utf-8?B?S1k3c3BYNjBkU2ZIYjE1UnlzMmx1UEM4Um5ScG5XMElrZUNiTDlYR09Xdkgw?=
 =?utf-8?B?WW1pcHR2cS82eEZXSjFDSGVaWGlXWlJlRmd5b1RxUGpmSzhwekZWbGRhcjlp?=
 =?utf-8?B?SmJ6emRPT3ZoaGw4STFFRkRVRnJVM1NRc0ErK0pUV0xGMEc3Sm5ZWkhMUEVn?=
 =?utf-8?B?ZmdXNG1tcEIwNGFCUGR4Tmx2bmc4MS9KZENhRkFrbk1lRXlOeDFud1k4YUxF?=
 =?utf-8?B?WG9mY1JaWFVRajFjZWVNTkJjK2ZrOVdOblAvQlNxdGlJbHpXU3A3WCtGV01Y?=
 =?utf-8?B?MHFPQVZKY2RuQ0N3UkFaSm9XTEZDWHlHZEtqN1R1SUFra2E3cGFLdE5YZXRm?=
 =?utf-8?B?UHlqRE1JSlM4N01TdHdzSkR4V0c0K3RmelFPVUFYak1GMkhGOTljc3hFMFZI?=
 =?utf-8?B?S1BkM05xNWI2dnhYV2JlVDZia21PYXJURWhqMTRjVlhONHpjbFNiMm8vN1Ru?=
 =?utf-8?B?WWdubi84dlVQdkx2Mk9na2JsM3BzZnFkdjliWThRbVMvV1M4alpPMkpZRE9T?=
 =?utf-8?B?YnVlVG5KQUNYaDRCZmx1bmcrRFlsMmNIdSt3TEdpNmhHNjV4NmNJanB4R1BN?=
 =?utf-8?B?a1ZITlZFaUxDNWJycHM1c0hYaDY5TmVXMXJ5MmhtMi80S0V6ckJTZHVFOTZF?=
 =?utf-8?B?K2N2OEFmWWpsTnVJVnQwSFJEWXJ3cmszcnFybHRTbjgwam9BbWdkTEdEeE5i?=
 =?utf-8?B?RWR4SkhwTmRxMFlhdURkcjVJNnZlbVloT3hheGpPZERqTWdXUW5vRktyK01r?=
 =?utf-8?B?NWpGZXhTU0FjSFA4TTB2V2d5cEZ5QnA0eGpCTXdKZ3pzTlZmMytnVmwrMTlY?=
 =?utf-8?B?eGc1T3BDNDhUODAweDlweU5waTV1bnhYWGQ5dkgrdEk1YXl1OWl4N2s5Mktl?=
 =?utf-8?B?bC9qNkN0cTZzeCtJWFAxZUF3dTU4MVl0Zi9SdjQzeVRzZ2dxbzFpOU1GT0lz?=
 =?utf-8?B?M1dzK21EZkM4S0o2RHNySUVzdUlLMzJFemhIdnV6eW5TWEZLTm1PY0lYK2tX?=
 =?utf-8?B?ZXlYbkRzUFd0ZEl4RWR3NFREOExPNUJKVzduNEhIQUpiK3M0WHlVSVdVWW5R?=
 =?utf-8?B?ZzNwemc3eW9pV25xdVFid2l0YThkL3Q2d01lS2VJZldYQk1wazUwdlI2czlP?=
 =?utf-8?B?UU1zdU42cVAwUDNCSDJJaytHTVFrOTJMZ0JqZVpZdjJ4MUVJMzhSNlM1YW5I?=
 =?utf-8?Q?297J/1m69KG56VUztmzylxg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B59993964997D4389EA31F1ED59A7B7@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: iris-sensing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1745f350-760f-40b6-18b7-08dd54b44877
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 09:19:04.2584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 963f3913-ffae-43fd-856b-2dfd3f6604e3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gEI3MKS7A/tTt+S2fo85atN6pOcyEH/X5Qd5va7x/BhEFIXgK6EdQ3dTp/GpLkGoAFWMV+GN/Pvq/koYcDU9L0zOPo++VuEJJiwUyZCW4/zVaESzRw1cmUk7aNdPe3h0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR5P281MB4138

TGVhZGluZyB6ZXJvIGJpdHMgYXJlIHNlbnQgb24gdGhlIGJ1cyBiZWZvcmUgdGhlIHRlbXBlcmF0
dXJlIHZhbHVlIGlzDQp0cmFuc21pdHRlZC4gSWYgYW55IG9mIHRoZXNlIGJpdHMgYXJlIGhpZ2gs
IHRoZSBjb25uZWN0aW9uIG1pZ2h0IGJlDQp1bnN0YWJsZSBvciB0aGVyZSBjb3VsZCBiZSBubyBB
RDczMTQgLyBBRFQ3MzB4IChvciBjb21wYXRpYmxlKSBhdCBhbGwuDQpSZXR1cm4gLUVJTyBpbiB0
aGF0IGNhc2UuDQoNClNpZ25lZC1vZmYtYnk6IEVyaWsgU2NodW1hY2hlciA8ZXJpay5zY2h1bWFj
aGVyQGlyaXMtc2Vuc2luZy5jb20+DQotLS0NCg0KQ2hhbmdlcyB2MSAtPiB2MjoNCi0gcmV0dXJu
IEVJTyBpbnN0ZWFkIG9mIEVOWElPDQotIGNoZWNrIGxlYWRpbmcgemVyb3MgZm9yIEFEVDczMDEv
MiBhcyB3ZWxsDQoNCiBkcml2ZXJzL2h3bW9uL2FkNzMxNC5jIHwgMTAgKysrKysrKysrKw0KIDEg
ZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2h3
bW9uL2FkNzMxNC5jIGIvZHJpdmVycy9od21vbi9hZDczMTQuYw0KaW5kZXggNzgwMmJiZjVmOTU4
Li41OTQyNDEwM2Y2MzQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2h3bW9uL2FkNzMxNC5jDQorKysg
Yi9kcml2ZXJzL2h3bW9uL2FkNzMxNC5jDQpAQCAtMjIsMTEgKzIyLDEzIEBADQogICovDQogI2Rl
ZmluZSBBRDczMTRfVEVNUF9NQVNLCQkweDdGRTANCiAjZGVmaW5lIEFENzMxNF9URU1QX1NISUZU
CQk1DQorI2RlZmluZSBBRDczMTRfTEVBRElOR19aRVJPU19NQVNLCUJJVCgxNSkNCiANCiAvKg0K
ICAqIEFEVDczMDEgYW5kIEFEVDczMDIgdGVtcGVyYXR1cmUgbWFza3MNCiAgKi8NCiAjZGVmaW5l
IEFEVDczMDFfVEVNUF9NQVNLCQkweDNGRkYNCisjZGVmaW5lIEFEVDczMDFfTEVBRElOR19aRVJP
U19NQVNLCShCSVQoMTUpIHwgQklUKDE0KSkNCiANCiBlbnVtIGFkNzMxNF92YXJpYW50IHsNCiAJ
YWR0NzMwMSwNCkBAIC02NSwxMiArNjcsMjAgQEAgc3RhdGljIHNzaXplX3QgYWQ3MzE0X3RlbXBl
cmF0dXJlX3Nob3coc3RydWN0IGRldmljZSAqZGV2LA0KIAkJcmV0dXJuIHJldDsNCiAJc3dpdGNo
IChzcGlfZ2V0X2RldmljZV9pZChjaGlwLT5zcGlfZGV2KS0+ZHJpdmVyX2RhdGEpIHsNCiAJY2Fz
ZSBhZDczMTQ6DQorCQlpZiAocmV0ICYgQUQ3MzE0X0xFQURJTkdfWkVST1NfTUFTSykgew0KKwkJ
CS8qIEludmFsaWQgcmVhZC1vdXQsIGxlYWRpbmcgemVybyBwYXJ0IGlzIG1pc3NpbmcgKi8NCisJ
CQlyZXR1cm4gLUVJTzsNCisJCX0NCiAJCWRhdGEgPSAocmV0ICYgQUQ3MzE0X1RFTVBfTUFTSykg
Pj4gQUQ3MzE0X1RFTVBfU0hJRlQ7DQogCQlkYXRhID0gc2lnbl9leHRlbmQzMihkYXRhLCA5KTsN
CiANCiAJCXJldHVybiBzcHJpbnRmKGJ1ZiwgIiVkXG4iLCAyNTAgKiBkYXRhKTsNCiAJY2FzZSBh
ZHQ3MzAxOg0KIAljYXNlIGFkdDczMDI6DQorCQlpZiAocmV0ICYgQURUNzMwMV9MRUFESU5HX1pF
Uk9TX01BU0spIHsNCisJCQkvKiBJbnZhbGlkIHJlYWQtb3V0LCBsZWFkaW5nIHplcm8gcGFydCBp
cyBtaXNzaW5nICovDQorCQkJcmV0dXJuIC1FSU87DQorCQl9DQogCQkvKg0KIAkJICogRG9jdW1l
bnRlZCBhcyBhIDEzIGJpdCB0d29zIGNvbXBsZW1lbnQgcmVnaXN0ZXINCiAJCSAqIHdpdGggYSBz
aWduIGJpdCAtIHdoaWNoIGlzIGEgMTQgYml0IDIncyBjb21wbGVtZW50DQotLSANCjIuNDQuMQ0K
DQo=

