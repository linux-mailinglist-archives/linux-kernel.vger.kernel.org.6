Return-Path: <linux-kernel+bounces-510744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC76AA32165
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C7A27A21DF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA83C204699;
	Wed, 12 Feb 2025 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="PX1qtY4g"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2076.outbound.protection.outlook.com [40.92.40.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9622271828;
	Wed, 12 Feb 2025 08:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739349934; cv=fail; b=WJo4w00lrnzODL6fwNlhveE71SQpyvSRlXRmwF7yvXFNZ3IkM+R+8om53mskod2I6HXqmUtPj/kqivLMchW1WzKIkjW0uwyK9FARnsj2LXK51CHoLlsDeisJTBY0i+cxtKC6coCloBR42rr5M7MM3K0lQgzYFPDwgou/IIBiyPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739349934; c=relaxed/simple;
	bh=X6f7MFuaz84/x5aZ7pmc/PtBj9LTgN0Lo/+6xAfImzc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VxbvcZUzaejCaIqoxrS3Ic4b2e3Eyh94oMoAGHLbIH93fpPX4tKPANRKZPV+okZSmSFhxq16IfK0EbPAE1MuAb+0ZeX/h34ScW+kSxob77wctaQtvI4X9F5KqAumrdlzpNDCr1jY98hMOP/WqxPaT/zCJ/fJhuqUUjA1BHpG/UE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=PX1qtY4g; arc=fail smtp.client-ip=40.92.40.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzY6oQYYMgVKNGHExDlta3pDTVH6esrVdi9OaOexi5b0ShUwKrYVrR7MLRmM9MfcFSMLO/W0fQekqxrsdHJQpw0XrP5OVD8Tfi75h8YkuRFYkFoNeqoqn0uaOxaDGX0OTpN4xpc15HpWV9IULXaVfbym6zp02VWaILDRWUyKMkN/PW1OgaHTgpOxwJWsjKgO8tpELMFgbeVRCro/Cj7WP1rPbCXl9I7B+f2bMijCb8sChkkkLl32ef8LXrZ4I1WUpz4ZrZLC6eGzzMSnIlaBi+MY35rBLqM3r44tyMqMew9NmWtApKFzGdNngAnk8pPyktEC4aYsW9IbqMN6SSV8tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6f7MFuaz84/x5aZ7pmc/PtBj9LTgN0Lo/+6xAfImzc=;
 b=MPTn93m158fpLcTh1Nii+esBDx0YliTs5Y0P4JdVuz14yfg2xsaqGm9kUVrTSKIXsWVP41UBqMNNXeuQrY3vDThjW0dznEVjnxBPORZ8w6250zqsKbThDSBjRu5Ft64wUlVhOz2UYVOzgm4Wu6DL9dgTfvJN3m5zH335gCPhaL0EldLZq4foyETtsf08rcPTbC1pC0eG0jvOn5N9EOOJw3x4HJrU7qcJU6YD/7RJ2LOCv64a06ai11CQA24jivcSzqfmVMn5HJXCBK1R9BUepSjudHO01C7+9XhxAotq+OWfMpUFlNSPpXG/UoSH0lXkDPQ5+6BimhtFbkiIBCLUnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6f7MFuaz84/x5aZ7pmc/PtBj9LTgN0Lo/+6xAfImzc=;
 b=PX1qtY4garQpjjBAUZXfFexu2QTqqo28Yzh1USsKaVosjV/gTOzNH2UXNWznXXE8Wuyl62+1mVJh5MeKVDDw9CanBFJD3dwczXCzQcIA7DVvC2Aq6+deXD0uYYDoCoavtFMfWEIv7DjShHMSH+Xm7AosRC+Xybv3/iJD4xo8Wj8+Ia5Eex44sH5F3FMSBJ3oNCyl6CZF4eIyhz66op21Q3t/BG7LqnKWIWdgRyLaU1/oy03OlogfQ/3tL33dM9Dpbejrdhd65tSQoAbJH0c7st4corCoV9AyfUwuxD/GKx1xgbvAtYNdPBQS1YrhZxhqeuZnsTbLeQRDJMUN65Qv7A==
Received: from BYAPR12MB3205.namprd12.prod.outlook.com (2603:10b6:a03:134::32)
 by SJ1PR12MB6145.namprd12.prod.outlook.com (2603:10b6:a03:45c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 12 Feb
 2025 08:45:29 +0000
Received: from BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::489:5515:fcf2:b991]) by BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::489:5515:fcf2:b991%5]) with mapi id 15.20.8422.012; Wed, 12 Feb 2025
 08:45:29 +0000
From: stephen eta zhou <stephen.eta.zhou@outlook.com>
To: =?utf-8?B?Vmlyw6FnaCBCYXJuYWLDoXM=?= <cyborgyn@gmail.com>, Richard
 Henderson <richard.henderson@linaro.org>, "mattst88@gmail.com"
	<mattst88@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC: "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arch/alpha: optimize virt_to_phys with compiler automatic
 sign extension
Thread-Topic: [PATCH] arch/alpha: optimize virt_to_phys with compiler
 automatic sign extension
Thread-Index: AQHbfGT8bXQnnoZcCkuc2ewxr4TU+7NCUeAAgACKJ0iAAH0kAIAAAr0D
Date: Wed, 12 Feb 2025 08:45:29 +0000
Message-ID:
 <BYAPR12MB320549F97245529A28247A38D5FC2@BYAPR12MB3205.namprd12.prod.outlook.com>
References:
 <BYAPR12MB32057EF854A36230B5BC7E1AD5FD2@BYAPR12MB3205.namprd12.prod.outlook.com>
 <a1803d33-c92a-4294-acd0-a2152fb0c163@linaro.org>
 <BYAPR12MB3205F7AB3307D62DAC5B8977D5FC2@BYAPR12MB3205.namprd12.prod.outlook.com>
 <C4FB92F2-948F-437F-872D-737ADF45BD12@gmail.com>
In-Reply-To: <C4FB92F2-948F-437F-872D-737ADF45BD12@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3205:EE_|SJ1PR12MB6145:EE_
x-ms-office365-filtering-correlation-id: 336f1b92-4c65-4c59-1b83-08dd4b419a7d
x-microsoft-antispam:
 BCL:0;ARA:14566002|6072599003|461199028|15080799006|8062599003|15030799003|8060799006|19110799003|440099028|3412199025|102099032|41001999003;
x-microsoft-antispam-message-info:
 =?utf-8?B?STJ5NzBHMlVxZmhWUndaYS9kd281R3pvaWtDVllXSm4rbW5MTC9ZbStkUHJs?=
 =?utf-8?B?WG0yNk1UVWQyVU1LaTNyUFdjcEpodG8yalVYajhlUmtmeGgrS0lFTm84M3Qw?=
 =?utf-8?B?bDVYczVEQ1kwenhZc0FISjgvU0E3VWt0SW5oWlQ3Zlo1NWY0RlZFVHdtNmZn?=
 =?utf-8?B?dzZvT1BWT2FnRUlsaUdGRHBnM3k1cXEycE9wdXhlSHg2Z0M0UGFTTWd1aFhG?=
 =?utf-8?B?WTlFWm5hQlcxZEtLYVZQKzY3TG14ci9VM0w4MGYyMUlLT2J0VDZKZWJFVlRC?=
 =?utf-8?B?MHkyT0xDKzB0blJLYTY2dVdlN3U2OGpLUmw1eTJlbHZ4dE5VU1Y5RTMxVkxt?=
 =?utf-8?B?RWRhaHhuL1BFUHZFeWk5c24rUUNPbnRidGZCQndGdHBsODhSS3JUdXR4T3o5?=
 =?utf-8?B?V1pLYXdzZWJxR0d4aDZDWlRhLzA0RlIvTGpoazBoM1lGUWxjaCtnd2NkYkZj?=
 =?utf-8?B?bXB1Nm5acVVvM2trYUVzeUR0Zi9xNTZ1V0QxamZjeUk4Y0M2d1drWC9rdmhr?=
 =?utf-8?B?b280K08rQW15dzAyMWdTUFdpaXRyMTI3d0VkL1hpeUsra3NmL2ZrRDZNaHlH?=
 =?utf-8?B?d3hFRHFoN1FnSVY0bmc1TEhwSWIxVzh0L1lRQVlrUE02KzYvTUYwdFV0aC9U?=
 =?utf-8?B?VGRHRmY5bUwzZytTdUgxTGpQOTZEL1pyN3NaZVkzU3l5MTI1QmJlbmJmTXhy?=
 =?utf-8?B?Y2pGS1E5QnA0ZG1tUWhyZFF2Wld6Z3ZzN0tMY1F5Zk1XbjJFTURFR3V5cGFB?=
 =?utf-8?B?TDVoTTF3bDFSbnA5TlJvMWxxNHcxSTJPNFVXUFZyN2JHamU5MHA4V0x6Q0Rr?=
 =?utf-8?B?bVllWXJkdVRrS09UeTVxc0NtVWhsemlTSVNuRU1tWXI1VTE3V2IzV1YzVkV1?=
 =?utf-8?B?aVVnUVlSbFlXSVFtK3VuakVrNnpPRUo5RGQ3MFYzSzNCT0VmLzl2VW9ibmdK?=
 =?utf-8?B?Z21IVUF0ZTVWN1BRTWhsK3RZRHErNFJtTzBqRkJiN0QraCswLyswVk85TVpC?=
 =?utf-8?B?MlFwcHJqRG1ja3lacE9oaGtLZWNUTVN5QTZrMGJ4QnJVcFl1RGhlWmhUZnJE?=
 =?utf-8?B?M3ZzMmdQM3JRMlRGdkJJYUE2eUF2TUptU3FUSUxka2hscnZxNHFpRjhjTjdM?=
 =?utf-8?B?MWRIelFCTll5WmNzZUhBN2Jkdll4eFoxVzlZVnM2SVE0MVMvcEtlRUNxNXhD?=
 =?utf-8?B?QTkvc3J3VkRNaitsdE4zY2dOd3VpOTYxeEtvMDA2MXM0RWNQZzR3ODBJT2lx?=
 =?utf-8?B?c1dlZ3BWU1poTkVQWUN0REhBZEEvY0lvQnNmWm1uMUJrcjhUeFJKUHB5anhE?=
 =?utf-8?B?VzBqUU8zU2txckQzYTZpajc5b1MwWWlmaUhLb3JWeVYwMzE4Y1I4Tm15KzVq?=
 =?utf-8?B?WmdJdW5SWUtDRXNTQTZPSERuTkh0YkdMb2p0OUtNNVVoeGN1bDh2WVZ6ZW5U?=
 =?utf-8?B?M1VJOVJ0Z3RISUxHdXhncS9NRjdLS3BXcWxKVUV0dFFyeDdvMDlUb0RmTjdN?=
 =?utf-8?B?bmNRTHV6RlE2dnlSSDhQVzdjT2syaTI4aDFOcFVBZVo1TCtHeGg2alBHSnlo?=
 =?utf-8?B?NDNtQT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZXhmeTVUbm4xMHFsZU9uQVh4RjdoWTA2ckFKRVJnVkpPQnBBK1ZleHJOU1ov?=
 =?utf-8?B?WXd5WDFaakJ4aFU2NGh4TlpkeGJseEsxd2FBbG9ESEVidmdBUmlNRm0yc3dv?=
 =?utf-8?B?UGJGYitoSFJJTjNOcVJCOXJDakd1RkNoMlRXaEFZNTdJWiswVkhRVGpSNEJu?=
 =?utf-8?B?czFrOXBZQ2dYeXY5dHRqbzlEREt5VU5CVkJFZFdpTjdyQjlYYy82ZHRNem1V?=
 =?utf-8?B?RC9VTU53Q0ZNQVc2K1Q2RTg4TEl6ZDE1UkxjMVpoUDZScEYwdk1NUWpETDM4?=
 =?utf-8?B?THJCWmxSSzRFREM0VlF0ckJCbllMbnNHWi9HVVNVL28rTWJpU04wU25naEFD?=
 =?utf-8?B?RWRJSTM4NmowQUVsTFFwbE1UcUZuNDc0eHVieWJvbUVOY0pHM3p5VzArSUJE?=
 =?utf-8?B?K0s4N2JwQm04d2ZxdlhLNXpqUmg0UGVQM051ekswYnA4Z3c1OTlIZmFhdzVB?=
 =?utf-8?B?dEhGZVJQOThzUXRUVVdGMkdhUTExSVVZQWRlaTNMeFhraVZjV1JWRFQxQi9H?=
 =?utf-8?B?R0R6VnM1L3F1a0IydW9MM1orRGxVQy9VZ0l2ekk4S0Y5S0paSEtobmgzSWRk?=
 =?utf-8?B?QVY0TnZ3emJ1a1dQNkhPUjUyMzJ6Z3dWcWhzOEVMbnMrMmFvdHlra2dPanRw?=
 =?utf-8?B?QjltYlFBVzY2ZWtjeE9iSE9KK2xRb3dkU3BCMUlFSlNuMTk1YldnOHJqUU5l?=
 =?utf-8?B?d3dBZnpDQTNWNkVJZ1RkOWYxWEtlZmVoTmUvR3ZQUnZVMVhZcWsyb3MrVitT?=
 =?utf-8?B?NU5VNHBGdlBua2dmZTFUcURNV0FNdFJkRGNza3E5cmdzQ3MySXduVjFjdnFM?=
 =?utf-8?B?cmhOai9zbDkxU2JkWWtFZEcwVno4L3NaL09EVlBYN1ZjUncrVHZoS1N3Kzd3?=
 =?utf-8?B?ZW5kTUhLbngxYUROVmhlNUx1eWEwaEljUi93cU1wbm1nQThic21QVWROYUR5?=
 =?utf-8?B?OVRKeGlKSzlzMng5ZVNQQ3JhLzBqUmp5aEZwaTFwNjlBendjZnlYR3FNMEto?=
 =?utf-8?B?dGlLcDlKall5TGZ1Ymg1TDV6UzdJK3RuRjhSOTlnYlg3ZHl4TUljRng2SzhE?=
 =?utf-8?B?NDNwbjc5TS9qL2NGRlYxaGNYaHFhUVlPOUdqRHVvMUtUTHJzR3kySENEUU9j?=
 =?utf-8?B?V2J5T1Ywd1ZwYlB5QkZ2K2wxSlNIaGpIVW44VmRzTmE3U1dwYVdKRjM2U3lO?=
 =?utf-8?B?VEo3cWtnTzYrWGI4enZmTTg0cTBSNUFSSUM0RFFjaG95cWc3Q0dVK01XSStJ?=
 =?utf-8?B?OWNMQjJXZEVwa3lLQldCRW5kZHhLUnRSS1JxRTMyVC8zQVUrVVVqNjAralVo?=
 =?utf-8?B?cEkyOXBvLy9LQTNmUDBFQ3FyRGJFbXhybFpGS1JRSkJSNU5IZHpqS3cyemNB?=
 =?utf-8?B?MGM4RThtellFNkdSd2RMbGNYRWxsb1VRUHN2TndHOUVrL3AzMUlVZno4WnAz?=
 =?utf-8?B?Q2NwWjdsVXc4bUpvK2xyMmw0ZkEwOVAwbkFLa0t3QktBSW1ob0NvbDF2c0la?=
 =?utf-8?B?K1ltSUZycER0ODB6dUNtQWhlUjJiT3FmQXRpcDVaRnJXMjJ0VytxRFBBbXF4?=
 =?utf-8?B?WENoTm9QYnEyVG5laVdHR3R0L0IxWWFTUWxNVWlQeFhXQm1iK2xWYmZiLzRm?=
 =?utf-8?B?MGVFZ3Q0bmlRcWx5RFFac2RkTElGeE9KYk5pRkJobEtnZVdWdTdBdm9uMFpO?=
 =?utf-8?Q?Qt7Xp9/MBVG3O7YoNDU0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 336f1b92-4c65-4c59-1b83-08dd4b419a7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 08:45:29.3111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6145

Cj4gV293LiBwcm9wZXIgQUkgcmVzcG9uc2UuIFdhcyB0aGUgcGF0Y2ggYWxzbyBwcmVwYXJlZCBi
eSBBST8KCk5vLCBJIGp1c3Qgd2FudGVkIHRvIG1ha2UgdGhlIGFuc3dlciBsb29rIG1vcmUgZm9y
bWFsIGxvbC4uLgoKQmVzdCByZWdhcmRzLApTdGVwaGVuIEV0YSBaaG91Cl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KRnJvbTrCoFZpcsOhZ2ggQmFybmFiw6FzIDxjeWJv
cmd5bkBnbWFpbC5jb20+ClNlbnQ6wqBXZWRuZXNkYXksIEZlYnJ1YXJ5IDEyLCAyMDI1IDE2OjM0
ClRvOsKgWmhvdSBTdGVwaGVuIEV0YSA8c3RlcGhlbi5ldGEuemhvdUBvdXRsb29rLmNvbT47IFJp
Y2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPjsgbWF0dHN0ODhA
Z21haWwuY29tIDxtYXR0c3Q4OEBnbWFpbC5jb20+OyBhcm5kQGFybmRiLmRlIDxhcm5kQGFybmRi
LmRlPjsgcGF1bG1ja0BrZXJuZWwub3JnIDxwYXVsbWNrQGtlcm5lbC5vcmc+OyBsaW51cy53YWxs
ZWlqQGxpbmFyby5vcmcgPGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZz4KQ2M6wqBsaW51eC1hbHBo
YUB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWFscGhhQHZnZXIua2VybmVsLm9yZz47IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+ClN1Ympl
Y3Q6wqBSZTogW1BBVENIXSBhcmNoL2FscGhhOiBvcHRpbWl6ZSB2aXJ0X3RvX3BoeXMgd2l0aCBj
b21waWxlciBhdXRvbWF0aWMgc2lnbiBleHRlbnNpb24KwqAKV293LiBwcm9wZXIgQUkgcmVzcG9u
c2UuIFdhcyB0aGUgcGF0Y2ggYWxzbyBwcmVwYXJlZCBieSBBST8KCgpPbiAxMiBGZWJydWFyeSAy
MDI1IDAxOjA5OjUyIFVUQywgWmhvdSBTdGVwaGVuIEV0YSA8c3RlcGhlbi5ldGEuemhvdUBvdXRs
b29rLmNvbT4gd3JvdGU6CkhpIFJpY2hhcmQKCk5BQ0suwqAgV2hhdCBkbyB5b3UgdGhpbmsgdGhp
cyBkb2VzP8KgIFdoYXQgaXQgZG9lc24ndCBkbyBpcyBzaWduLWV4dGVuZCBmcm9tIGJpdCA0MS4K
Ckkgd291bGQgbGlrZSB0byBwcm92aWRlIHNvbWUgY2xhcmlmaWNhdGlvbiByZWdhcmRpbmcgdGhl
IHBhdGNoIEkgc3VibWl0dGVkIGZvciBvcHRpbWl6aW5nIHRoZSB2aXJ0X3RvX3BoeXMoKSBmdW5j
dGlvbi4gTXkgaW50ZW50aW9uIHdhcyB0byByZWx5IG9uIHRoZSBjb21waWxlcidzIGF1dG9tYXRp
YyBzaWduIGV4dGVuc2lvbiBieSB1c2luZyB0aGUgbG9uZyB0eXBlLCByYXRoZXIgdGhhbiBtYW51
YWxseSBwZXJmb3JtaW5nIGJpdCBzaGlmdHMuIEhvd2V2ZXIsIEkgb3Zlcmxvb2tlZCB0aGUgZmFj
dCB0aGF0IG9uIHRoZSBBbHBoYSBhcmNoaXRlY3R1cmUsIGxvbmcgaXMgYSA2NC1iaXQgdHlwZSwg
d2hpY2ggcmVzdWx0ZWQgaW4gYSBzaWduIGV4dGVuc2lvbiBmcm9tIGJpdCA2Mywgbm90IGJpdCA0
MSBhcyBvcmlnaW5hbGx5IGludGVuZGVkLgrvu78KSSBzaW5jZXJlbHkgYXBvbG9naXplIGZvciB0
aGlzIG92ZXJzaWdodC4gSW4gQWxwaGEsIHRoZSBzaWduIGV4dGVuc2lvbiBzaG91bGQgYmVnaW4g
ZnJvbSBiaXQgNDEsIGFuZCBJIG1pc3Rha2VubHkgYXNzdW1lZCB0aGF0IHRoZSBjb21waWxlcidz
IGF1dG9tYXRpYyBzaWduIGV4dGVuc2lvbiB3b3VsZCB3b3JrIGFzIEkgaW50ZW5kZWQuIEkgbm93
IHJlYWxpemUgdGhlIGltcG9ydGFuY2Ugb2YgcmV0YWluaW5nIHRoZSBtYW51YWwgc2lnbiBleHRl
bnNpb24gZnJvbSBiaXQgNDEsIHdoaWNoIGlzIGNydWNpYWwgZm9yIHByb3BlciBhZGRyZXNzIGhh
bmRsaW5nIG9uIHRoaXMgcGxhdGZvcm0uCgpCZXN0IHJlZ2FyZHMsClN0ZXBoZW4gRXRhIFpob3UK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpGcm9tOsKgUmljaGFyZCBI
ZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+ClNlbnQ6wqBXZWRuZXNkYXks
IEZlYnJ1YXJ5IDEyLCAyMDI1IDEyOjUyIEFNClRvOsKgWmhvdSBTdGVwaGVuIEV0YSA8c3RlcGhl
bi5ldGEuemhvdUBvdXRsb29rLmNvbT47IG1hdHRzdDg4QGdtYWlsLmNvbSA8bWF0dHN0ODhAZ21h
aWwuY29tPjsgYXJuZEBhcm5kYi5kZSA8YXJuZEBhcm5kYi5kZT47IHBhdWxtY2tAa2VybmVsLm9y
ZyA8cGF1bG1ja0BrZXJuZWwub3JnPjsgbGludXMud2FsbGVpakBsaW5hcm8ub3JnIDxsaW51cy53
YWxsZWlqQGxpbmFyby5vcmc+CkNjOsKgbGludXgtYWxwaGFAdmdlci5rZXJuZWwub3JnIDxsaW51
eC1hbHBoYUB2Z2VyLmtlcm5lbC5vcmc+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIDxs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPgpTdWJqZWN0OsKgUmU6IFtQQVRDSF0gYXJjaC9h
bHBoYTogb3B0aW1pemUgdmlydF90b19waHlzIHdpdGggY29tcGlsZXIgYXV0b21hdGljIHNpZ24g
ZXh0ZW5zaW9uCsKgCk9uIDIvMTEvMjUgMDE6MzIsIFpob3UgU3RlcGhlbiBFdGEgd3JvdGU6CsKg
IEZyb20gMGJmMmRkODE2YzgzNjllMmM2OTA4NjliNWY2YzY3MWYyOGMyYjE5NiBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDEKIEZyb206ICJzdGVwaGVuLmV0YS56aG91IiA8c3RlcGhlbi5ldGEuemhv
dUBvdXRsb29rLmNvbT4KIERhdGU6IFR1ZSwgMTEgRmViIDIwMjUgMTY6NDg6MTQgKzA4MDAKIFN1
YmplY3Q6IFtQQVRDSF0gYXJjaC9hbHBoYTogb3B0aW1pemUgdmlydF90b19waHlzIHdpdGggY29t
cGlsZXIgYXV0b21hdGljCsKgwqAgc2lnbiBleHRlbnNpb24KCiBJbiB0aGUgYHZpcnRfdG9fcGh5
c2AgZnVuY3Rpb24sIHRoZSBmb2xsb3dpbmcgY2hhbmdlcyBoYXZlIGJlZW4gbWFkZToKIDEuICoq
QXV0b21hdGljIFNpZ24gRXh0ZW5zaW9uKio6CsKgwqDCoMKgIC0gVGhlIG1hbnVhbCBzaWduIGV4
dGVuc2lvbiBjb2RlIGhhcyBiZWVuIHJlcGxhY2VkIHdpdGggdGhlCsKgwqDCoMKgwqDCoCBjb21w
aWxlcidzIGF1dG9tYXRpYyBzaWduIGV4dGVuc2lvbi4KwqDCoMKgwqAgLSBUaGlzIHNpbXBsaWZp
ZXMgdGhlIGNvZGUgYW5kIGxldmVyYWdlcyB0aGUKwqDCoMKgwqDCoMKgIGNvbXBpbGVyJ3Mgb3B0
aW1pemF0aW9uLgoKIDIuICoqRml4IGZvciA2NC1iaXQgQWRkcmVzcyBPdmVyZmxvdyoqOgrCoMKg
wqDCoCAtIFByZXZpb3VzbHksIHdoZW4gdGhlIGlucHV0IHdhcyBhIDY0LWJpdCBhZGRyZXNzIHdp
dGggYQrCoMKgwqDCoMKgwqAgbmVnYXRpdmUgaGlnaCBiaXQgKHNpZ24gYml0KSwgdGhlIHNpZ24g
ZXh0ZW5zaW9uIGNhdXNlZCBhbgrCoMKgwqDCoMKgwqAgb3ZlcmZsb3csIHJlc3VsdGluZyBpbiBh
biBpbmNvcnJlY3QgY29udmVyc2lvbiB0byAwLgrCoMKgwqDCoCAtIFRoaXMgaXNzdWUgaGFzIGJl
ZW4gYWRkcmVzc2VkIGJ5IHVzaW5nIHRoZSBjb21waWxlcidzCsKgwqDCoMKgwqDCoCBhdXRvbWF0
aWMgc2lnbiBleHRlbnNpb24sCsKgwqDCoMKgwqDCoCB3aGljaCBlbnN1cmVzIHByb3BlciBoYW5k
bGluZyBvZiBuZWdhdGl2ZSBhZGRyZXNzZXMuCgogMy4gKipOVUxMIFBvaW50ZXIgQ2hlY2sqKjoK
wqDCoMKgwqAgLSBBIE5VTEwgcG9pbnRlciBjaGVjayBoYXMgYmVlbiBhZGRlZCBhdCB0aGUKwqDC
oMKgwqDCoMKgIGJlZ2lubmluZyBvZiB0aGUgZnVuY3Rpb24uCsKgwqDCoMKgIC0gSWYgdGhlIGFk
ZHJlc3MgaXMgTlVMTCwgdGhlIGZ1bmN0aW9uIG5vdwrCoMKgwqDCoMKgwqAgcmV0dXJucyAwIHRv
IHByZXZlbnQgcG90ZW50aWFsIGNyYXNoZXMuCgogU2lnbmVkLW9mZi1ieTogc3RlcGhlbi5ldGEu
emhvdSA8c3RlcGhlbi5ldGEuemhvdUBvdXRsb29rLmNvbT4KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwrCoMKgIGFyY2gvYWxwaGEvaW5jbHVkZS9hc20vaW8uaCB8IDgg
KysrKystLS0KwqDCoCAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKQoKIGRpZmYgLS1naXQgYS9hcmNoL2FscGhhL2luY2x1ZGUvYXNtL2lvLmggYi9hcmNoL2Fs
cGhhL2luY2x1ZGUvYXNtL2lvLmgKIGluZGV4IDY1ZmUxZTU0YzZkYS4uNGQ3Y2Q3NDg2YjdkIDEw
MDY0NAogLS0tIGEvYXJjaC9hbHBoYS9pbmNsdWRlL2FzbS9pby5oCiArKysgYi9hcmNoL2FscGhh
L2luY2x1ZGUvYXNtL2lvLmgKIEBAIC03MCw5ICs3MCwxMSBAQCBzdGF0aWMgaW5saW5lIHVuc2ln
bmVkIGxvbmcgdmlydF90b19waHlzKHZvbGF0aWxlIHZvaWQgKmFkZHJlc3MpCsKgwqAgewrCoMKg
wqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIHBoeXMgPSAodW5zaWduZWQgbG9uZylhZGRy
ZXNzOwrCoMKgCiAtwqDCoMKgwqAgLyogU2lnbi1leHRlbmQgZnJvbSBiaXQgNDEuwqAgKi8KIC3C
oMKgwqDCoCBwaHlzIDw8PSAoNjQgLSA0MSk7CiAtwqDCoMKgwqAgcGh5cyA9IChsb25nKXBoeXMg
Pj4gKDY0IC0gNDEpOwogK8KgwqDCoMKgIGlmICghYWRkcmVzcykKICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIDA7CiArCiArwqDCoMKgwqAgLyogQXV0b21hdGljIFNpZ24tZXh0ZW5k
wqAgKi8KICvCoMKgwqDCoCBwaHlzID0gKGxvbmcpcGh5czsKCk5BQ0suwqAgV2hhdCBkbyB5b3Ug
dGhpbmsgdGhpcyBkb2VzP8KgIFdoYXQgaXQgZG9lc24ndCBkbyBpcyBzaWduLWV4dGVuZCBmcm9t
IGJpdCA0MS4KCgpyfgotLQpWaXLDoWdoIEJhcm5hYsOhcwpjeWJvcmd5bkBnbWFpbC5jb20KZ3Bn
IGlkOiBmNjkwIGM0YmEgODdjOSA0MWMz

