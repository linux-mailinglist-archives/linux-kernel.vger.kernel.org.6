Return-Path: <linux-kernel+bounces-282769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB4694E85F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17751F222B5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE28916A95A;
	Mon, 12 Aug 2024 08:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="TUsV3wft"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010027.outbound.protection.outlook.com [52.101.128.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A6A1547DF;
	Mon, 12 Aug 2024 08:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723450742; cv=fail; b=ksWUyHfg3bqWBvkIEe9vo2VzeAAGwVMLk1l47zqgMcho5rqdFD030Dj0rErLmlWHSCzL2BsIQzK0myOfqKybByrp0gjZbRcZpYGJ8jtjYS9ZpmsJc8RoLgma34781TwWaRAN2ay0JeBWHYaEt3MBmG/eRkAIZPIWV4Q407K8fyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723450742; c=relaxed/simple;
	bh=asZ9BAlPBDdViaCyidGSN7EOzoa5qG9rkDwxenrpY4k=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EQYGLVLKbH8mWVu9QNNIgB0M1d6cr1VFosTfjg27yhi4ssueHoiWzrV6lbJGvh9Il+UKztNFEUIkyqRHwt+HdRMKAsyHAwzKOPywaAxyKGNcRifcoXFFzVclaUYYEVb9GTVB7ASLf5blat4vFBIaV2NlZGLjDnK+8jxSsJHHp5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=TUsV3wft; arc=fail smtp.client-ip=52.101.128.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XyGjuJSM38VwrapL6rUyOPDWalQfIa/zLwlV9xfuT36xsURgxXhQcq1Cvr3vrf6HIMzBXjK/4N1kqH4NimAIUVgP4Eiv7a5re1p0wqn6BuZbABWX2r7f7Vm3AKm45vi54Als0fdNXyQbgODhgjx3O3IeJOJqAlTuadiyi0l6UuJB6Ve6rS9Qm/aSNKmaBbzk9LWQz0NS3Pg1EMA8RazORAZOJguLeoTIMg6GThxE3tfa58g0hWCjOGI1FrfahGZBQpJQ6lTuKMVL4QZoS5eRl12LvgBBdhANQdRA8z2P56dxLRN1cHfJYXkHGVCty5L73iOkD3q9XT47o239Hzin7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asZ9BAlPBDdViaCyidGSN7EOzoa5qG9rkDwxenrpY4k=;
 b=ww/zLB2NmqE8sEJzE6z1nvBSHgRNl3nIqx35NOy24bgBLYmNbTxvbEQxHZaX/gArYGvpw05YyVFiEdSOd20E4iQLOE81qd4L8KhMpJBURRpWIImK2FboV+ZJBbYlfmeOsBQL1iayWed9KNwsoNdlm+ljWUI3i7q9VU7cYfBTAY9HzudRgnbPyRG8e4ZnpB8zzNzMzyS+96fc8a/nzlmUqUR+KJ7NGAfQQ3HuTsylMeciIkOeLQcQBApdNgz9PceQxol3622VWXFtNFe7qsfmWJ9OVbd8/SMRv8aS38CrfO/MvbMPJR+3Mfh0Cfh4YiOx3Oa31AYxyR3iw7AgDfP5Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asZ9BAlPBDdViaCyidGSN7EOzoa5qG9rkDwxenrpY4k=;
 b=TUsV3wft0sS5Hnv9ZbZodgZ6LiODNnqzw3eC7fF9TIy6kgscFAZbUE0M9kHAPykVQsDSyNooqu3tAXCLsz1uar3KgB0vjejzgy1b+iODi3ch3fgWiLQ5MDUbjMW0bwsyBNwyT6a0fBSzC5P5ESPE4dQ65mC/bcMgpjsbCt9ZT0wqpAs5sytVl4cLxUXjCdplT5tEahISYSAqFhabwzLIL+oTFrpQDItw6cnSFdSpbiAa3L3AL7Qn6vUA1o1Br29hymbFiUHUrWln6wFf5rVpP6274v4xzxRNncCer1Gq51GP7y+4IP96lUl/KCfsbnRsj0lN/3SVpPedK0vezBSS5g==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by SEYPR06MB6249.apcprd06.prod.outlook.com (2603:1096:101:de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 08:18:51 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 08:18:50 +0000
From: =?gb2312?B?uvrBrMfa?= <hulianqin@vivo.com>
To: Takashi Iwai <tiwai@suse.de>
CC: "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
	"mbarriolinares@gmail.com" <mbarriolinares@gmail.com>,
	"wangdicheng@kylinos.cn" <wangdicheng@kylinos.cn>, "sean@mess.org"
	<sean@mess.org>, "alexander@tsoy.me" <alexander@tsoy.me>,
	"xristos.thes@gmail.com" <xristos.thes@gmail.com>, "knuesel@gmail.com"
	<knuesel@gmail.com>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, opensource.kernel
	<opensource.kernel@vivo.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
Subject: Re: [PATCH v1] ALSA: usb-audio: Add delay quirk for VIVO USB-C-XE710
 HEADSET
Thread-Topic: [PATCH v1] ALSA: usb-audio: Add delay quirk for VIVO USB-C-XE710
 HEADSET
Thread-Index: AdrskDuj+tueDEmdT8O97cajpGGO0A==
Date: Mon, 12 Aug 2024 08:18:50 +0000
Message-ID:
 <TYUPR06MB62176817F2096C7448636F59D2852@TYUPR06MB6217.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|SEYPR06MB6249:EE_
x-ms-office365-filtering-correlation-id: 1991f84b-ad85-4696-f7fd-08dcbaa765a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?RlF0QzVwd29Ob2p5aHIzT0g5TUZDUTI1SEQ4N3ZqaW9xWkNvWE1nb3lKdlk3?=
 =?gb2312?B?b0VyL3ZYbDI2ZXFzOGpGeCtEeHBmWjB4eUZUeUR5bkhBUUx1RFpzbExRelNq?=
 =?gb2312?B?eHRzMnpUeHdicmR5RVBGNnp0cE9CemVQTndQeHl5YVJCNnRJSDFPVDAxdkE1?=
 =?gb2312?B?N0lFTWFESkFTUFVIV1JXYmNXZFFQRWhjaEp0ZktuaGVjaTNZTjJMNm41cG1n?=
 =?gb2312?B?dHg1RnpadTJiZCtvRGNGWG1mT0wvYko0M240c0FzTXMreVRPZ0NUQWM1MEVL?=
 =?gb2312?B?TllLZm1ITGo4OVdSVTBWTUFwcWxkODhsaXg3Q24yRVl4U0xFbHV2THBLTlpI?=
 =?gb2312?B?MUJwRUtZRElNZkZ5OG9DMWJwUVdxYkt3bVhNTkV3elR4TGpVZ0RGVzdjaGN3?=
 =?gb2312?B?NTNCZXpWMXhyMG9tN2ovaU5OSXlGZUNRYXZudWR5U21rR1lkaGIyRm1LRTVS?=
 =?gb2312?B?NmpRbWVVc0lvTmxuZEpSbGtmZVRwNVMrZVcxNitwWE04SFJUN3NSUmVDb1BB?=
 =?gb2312?B?U05HRkpPN2tiTjk1UjVzYWJRM0R4SmFhN2hjOWkvQjVrMVo1d1lubWRRczF5?=
 =?gb2312?B?OGpGL1liRjN1REc3M2RHVm9iQXVObkk4VHJOYWNYRmR5UW5FcndWZ0FqNGZQ?=
 =?gb2312?B?UnNlNzh1QitXOWRFZmo1enBHakVBcDdUcGI1RVovU3Q0bkxGenJKUldHTmRl?=
 =?gb2312?B?eU4yTUZsSHJPV1BiSDdRdkJaMmhmdW1Udzh2b0VuWG1VcW0vUDhTNTVtOElw?=
 =?gb2312?B?akFwN3BJdHVIQVdZT3RWUkhWTXFKQUNiY0UwclpzTytEdytYSVdYeTZzSzlp?=
 =?gb2312?B?RmRHc25BWS9IWXlYTHgrWlVkai9pbmVIajdRUHgyUGhyVnlCSTlmUHdpSFpz?=
 =?gb2312?B?V2ZkVDdKS2ZsSWM2OVZQSElST1NpaVh0TEgyeE9LcnZRSjZsL29lM1FQMzBF?=
 =?gb2312?B?NEl5QlZwTGUwd0l2YWR4WU1LaXUwY0xzdGJ3ZXRuT3U2ZHNYaVQrZms5K3BL?=
 =?gb2312?B?VzU5QUF0aTh1bTdSV1B0R1dqbTNmQVU0K2JDZ0hCR0xJWWtJUnZvQitEc3c3?=
 =?gb2312?B?enRkQTY5RUJrRE9POW9MNzdMa3ZmVjlmQW94U2tTMnVjdnp1bEtRZUxoRmEv?=
 =?gb2312?B?RGFPTXk2WkI3NmlhWktjVENNVE83SVVZbEhOR2VkN2JDWkduYVd2OHo1bzhK?=
 =?gb2312?B?QURFa2RTd0RWekcvZzFpd0t1dUtER3RsTG9Oc1NTeDNrRlp5UndaOU1wSmJJ?=
 =?gb2312?B?bmtxWWJadWY4SHZoMmVnR0wrWWNHZWdFcktBc2kvUUc0WWxadFJBS3hjSGNq?=
 =?gb2312?B?dGhLOUk2UXFpcllpNkFVQkhWMEMxVFVTSEFySXBLRmd5RFd6c2ZDUFFCcWJz?=
 =?gb2312?B?cWtZOEh5S3cvSk9HS3RhaW5Pb2dqcXl4T2M1NzZSMWdHK1hFd05XaTFWZStn?=
 =?gb2312?B?MlJGUmVoUkVQd1Q3cmJPMGVsR3N4azhCMmdjNTM0L2J0SnFCMjZOekd4SGgv?=
 =?gb2312?B?NklYNHhzK242WTFXQmgrWlBpY2hsMTh0c1RQQkVvbmZOa1hVZkxpeE5RcTYv?=
 =?gb2312?B?L0RnOTJJWGJxamFlUjE0Vk5EaGNVZURhVk5MUm9obDZGbEVnWkV3VElTbnVh?=
 =?gb2312?B?VlZ1QzFoMVczc0FuVjN2UFZOQmpRb3dDK254QUNjWUgxd3dXUGtzVkl2L3V2?=
 =?gb2312?B?WnY1cjllY0ptZVhzYjFMMGdzdUxiV2Vxb1RkWGpFY2xHbVE1SmcvdTZ6eDBv?=
 =?gb2312?B?KzJiVE0xN0N2bEJtbTVIZm1ZT01zMGVDREJqR2RYUjJCWENEa0VRVFVzZFlh?=
 =?gb2312?B?Y2FyMmw3cDFvZ3E3V0FyS2U5VVNnYWV2UzYxbEJlU1JMVHpVZ3o5S2xwVVJK?=
 =?gb2312?B?SWE5c3dyQUI3d1d1OGJtTXo2ZGt1WWY2NDhUOW5ydVU4MXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?bVVFbDRmaVBiU2JDOHN4KzlhWkZhV1JrbDl1UCsxZ0VsanBnS3NkYnFlb0h1?=
 =?gb2312?B?SEJ3S0NjYzN1alRDVWhqV01DQnYzeVR2bVUvS2QwelBnYURYR29sSnp3bSsr?=
 =?gb2312?B?TnlFWEZSTWtsRFNGSXlOWERESTI4YVl2cXMrdFZxeVQvalNvNkpCWWdDV0J6?=
 =?gb2312?B?RHQrbWU2NWpzV2pRQlNEbTBJWlJyMmZocC9ZZnlOUnZnZ1FjRFFaU0EveFFn?=
 =?gb2312?B?RnlNTmNVQjlRVU51a290NE9XZGNhVVZBSXdYWVVFbmpWNTBSekFZUVczOFA1?=
 =?gb2312?B?NmprZ1VnWGVOYUl0WERPNTdQMllTTENTaXRhNGJZaDNUdHlqZkV1cEszOUdn?=
 =?gb2312?B?TXNNM3hnRnYrTTdXUHF0K0xKaGVWN0JlMmVKRTY4OGQ2NmhBai96YVF6dnRq?=
 =?gb2312?B?ZzhYYVFVYWFOYTJyNmNGWi9RVW5HZEVpRHRvVDdtbHhxdlE4UThpRTd0V1dG?=
 =?gb2312?B?YjBNMW1YY2pjQW0vR2JXbWZtUFR3bmhLSGk0U0trbytTSVgxc1VYeDA5T2s0?=
 =?gb2312?B?dlozWi9EREZWcHQvZlVGaSt0OTFoM1VTWCtSNDZBRkg3Y21NZ25Zdi9DRkhC?=
 =?gb2312?B?Q3o5Nk9OM29NR0oxUlM1K2lHaTE0OHR1bnF3dUFoTE5icXFPbE1GZFd3dGxI?=
 =?gb2312?B?VWRMTWNHcVN4N2VNb3IxUFllUDBpekdqTUpOTm5XTHF0RmROak5GcjNIZmtU?=
 =?gb2312?B?dWEvdFcza2NnOVJCMkJ4UWJsRXNMc3BIaVQyLy9Yc2UvU0J3RnpGWEJuQ01C?=
 =?gb2312?B?NFlCWHByZlVXQkZsQjJxenYwdFQ0MkF6ZHZtc3I1dXJpSFhCcW94bzdIbVhH?=
 =?gb2312?B?RUEyYVp5L2xETGpjd3VtZWJ0QjZ3enRZQjBDVFY4VFpKWEpsSVZkZ3BiMkpG?=
 =?gb2312?B?aVk4OWtpeThPQmNvbHN0OXN1QzRiYU05MTE3emxkbzQ4UVBUam5iVHFSUmhL?=
 =?gb2312?B?ME1UbUNVdGxLZGliWVdKMUpwMmFiSUtGZ3VIWnBicFVrYWNqSkJiVzNicVBx?=
 =?gb2312?B?UU8yYXF5WDUwcitUaVpqNTVXTzlWYVplQm9pcTMvT2tvUDczQm9iaHZZZ29I?=
 =?gb2312?B?NTF0d3BMUnRWS2hMbXJGbTVTZ083V2tKa1cxem5FUlp6OVIydDJXenJPUG5Y?=
 =?gb2312?B?RFBSVUFGNG1nQXc1RlRzdzJiYm5SZ01neDkvUWtXaW5ScDhHazFlbk9Fd2ht?=
 =?gb2312?B?b0ozUUlGT1VxcWYyZEpHSVdySmdsMUcxSk1QWi9JZ0IzTTI0UmpsSlEyekRM?=
 =?gb2312?B?OXcxMVdUdzZTRUNSUDJtODkzTDA5WWk0YXY3Znk5djhaRXBiS0QybkdHYmsw?=
 =?gb2312?B?VHF3N0gxV3hBQ21ndEliWEt2emVtZkNkT2NPZUhTL2E2UnJNZERsME5YUUM0?=
 =?gb2312?B?bG9heHBIb2pMUDE0WGN1bGk0SjdDTlVDMlc3TWlRUCtLa0ZubVJYY2NtZHdR?=
 =?gb2312?B?T01vTzdIL204N0cwcG5EUWMycUR1WVp5cGFXMXVad0NJYXF0YW9SWTJBZDJz?=
 =?gb2312?B?ZFFpRkhEczRsaVJtMjdZd3ZLbDdkNlM0U2RrMlNVZHRUWGVYaDNqLzlYVHd2?=
 =?gb2312?B?OEpBRzBYdFdBTG1hb2krNDgrZUZTeTkrMHdtc3YyWVpmcWRQY0g2bFhYb2cz?=
 =?gb2312?B?THAzemt3RTlXNmFmSjhOclladXJweWpzTTA0TVRIbDNyR2ZONkF5MkVaQzNK?=
 =?gb2312?B?YmduL0RqVDZKNXFSUVA2VEhOclRicXpJVVdKQmdEQnpUSVB3ZndmekpGZEN5?=
 =?gb2312?B?RytlL25QWXZiSUJ6ZThUVE00UVFIMEVEM0VGRTVtamN6MUJkTU9EYnhCMVp5?=
 =?gb2312?B?c05qRmRkQmxSSmgvYVNldE5jci8rWm5pU3BuYUlwOU14bXVwaXFUOG1KY0ov?=
 =?gb2312?B?VWFNalRkd1ZlaXlzUWEzRzd5bDIzTVhvTTlKMXFPV1hLcGFzWVMxdEV1UTZF?=
 =?gb2312?B?R1ZJeG5nT2V4TmJOeW9aeGJhOFFIU0x2ZWprZTRyZTd1cFAyQTVVa21pblU1?=
 =?gb2312?B?L3ZKbU9WeFVPSUluWmhjWDUzTWVjRzdyYVVidGRPTmRYbUp3RVFJajlBT2Vt?=
 =?gb2312?B?Q1RudGtQUTdkN1EzRUF1OFBlUGhwZDA5ZGZ2L1lzRGNQekx0RThIV0tubWZN?=
 =?gb2312?Q?UeSw=3D?=
Content-Type: text/plain; charset="gb2312"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1991f84b-ad85-4696-f7fd-08dcbaa765a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 08:18:50.7018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XrY7BP0MmaDIHO9WGb9fAFjGBGBAp0Z1heRp5KVo7B121LSz0chO11D2FBlKLKxWye1y2qp63P+n9itcpSi68w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6249

SGVsbG8gIGxpbnV4IGNvbW11bml0eSBleHBlcnQ6DQoNCiAgT0suDQoNClRoYW5rcw0KDQotLS0t
LdPKvP7Urbz+LS0tLS0NCreivP7IyzogVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlPiANCrei
y83KsbzkOiAyMDI0xOo41MIxMsjVIDE1OjIzDQrK1bz+yMs6ILr6wazH2iA8aHVsaWFucWluQHZp
dm8uY29tPg0Ks63LzTogcGVyZXhAcGVyZXguY3o7IHRpd2FpQHN1c2UuY29tOyBtYmFycmlvbGlu
YXJlc0BnbWFpbC5jb207IHdhbmdkaWNoZW5nQGt5bGlub3MuY247IHNlYW5AbWVzcy5vcmc7IGFs
ZXhhbmRlckB0c295Lm1lOyB4cmlzdG9zLnRoZXNAZ21haWwuY29tOyBrbnVlc2VsQGdtYWlsLmNv
bTsgbGludXgtc291bmRAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBvcGVuc291cmNlLmtlcm5lbCA8b3BlbnNvdXJjZS5rZXJuZWxAdml2by5jb20+OyBha3Bt
QGxpbnV4LWZvdW5kYXRpb24ub3JnDQrW98ziOiBSZTogW1BBVENIIHYxXSBBTFNBOiB1c2ItYXVk
aW86IEFkZCBkZWxheSBxdWlyayBmb3IgVklWTyBVU0ItQy1YRTcxMCBIRUFEU0VUDQoNCltZb3Ug
ZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gdGl3YWlAc3VzZS5kZS4gTGVhcm4gd2h5IHRoaXMg
aXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNh
dGlvbiBdDQoNCk9uIFN1biwgMTEgQXVnIDIwMjQgMTA6MzA6MTEgKzAyMDAsDQq6+sGsx9ogd3Jv
dGU6DQo+DQo+IEZyb206IExpYW5xaW4gSHUgPGh1bGlhbnFpbkB2aXZvLmNvbT4NCj4NCj4gQXVk
aW8gY29udHJvbCByZXF1ZXN0cyB0aGF0IHNldHMgc2FtcGxpbmcgZnJlcXVlbmN5IHNvbWV0aW1l
cyBmYWlsIG9uIA0KPiB0aGlzIGNhcmQuIEFkZGluZyBkZWxheSBiZXR3ZWVuIGNvbnRyb2wgbWVz
c2FnZXMgZWxpbWluYXRlcyB0aGF0IHByb2JsZW0uDQo+DQo+IFNpZ25lZC1vZmYtYnk6IExpYW5x
aW4gSHUgPGh1bGlhbnFpbkB2aXZvLmNvbT4NCj4gLS0tDQo+IHYxOg0KPiAgIC0gTW9kaWZ5IHRo
ZSBjb2RlIHBvc2l0aW9uIGFuZCBzb3J0IGJ5IElEDQoNClRoYW5rcywgYXBwbGllZCB0byBmb3It
bGludXMgYnJhbmNoIG5vdy4NCg0KDQpUYWthc2hpDQo=

