Return-Path: <linux-kernel+bounces-572930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2698A6D07F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 19:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5B2B7A63B3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 18:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701731624D5;
	Sun, 23 Mar 2025 18:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jQl3fZDa"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19010015.outbound.protection.outlook.com [52.103.11.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DBC802
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 18:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742753171; cv=fail; b=kOX12KW/b5kHDEhBMqfk4Bw00ovxap4MOgvsbpuzaQsfyp92ALw8cI/xwiJ8ozL3FGDD48zjgXORE+m2HJSAZKp0uylA9dLezR04y3rV7xzf07yEd10/4P/ggwSTEfEKjaBOsI5y5YHuCgrt+RFuWTdgZjOq1/3hoFSQWKIoPz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742753171; c=relaxed/simple;
	bh=HOIG3YIPZTEeCpeeQXn+U9ke0NX/S7ELVL8aLf8F0+M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=az7OUt+mFEBp0A0ymy+5EH0LD/yU6YtaMXUL+Rj4R193obWznnbyYfD7OFQCPX+TWAG92HrFZw99QbeWYgODaBb7CqGBsNLC1zyciyfOrUSnBiMK7A1xgzbs/mzBMowO8IxRzRmIagXfg/22dq2ahu1BXmq4ghb06AIRHYnigCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jQl3fZDa; arc=fail smtp.client-ip=52.103.11.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HyoxfT34D3l7N9k9Y0HMiOFZ2GzUF33JTjsbEXfkMMrxBZu8K96N/XTSr03GQmAZANLa9eQjq3oaq+gaRGTnRB/NHm/CJFjQaUJf2jjaSwU5+TmWoZUpqbyfATXWsYGmBLonMo+a9JtvRGuo8w+Hmew5FxgfQOnoyD5aq+T1vUKi/mZBdizpY5isPOhnqMX7jljzjaS3OlFoHM97HzxEZA24pXx9r2IsJ9sPH2RqKaPJQveVqDQuWxCneTzHdQsqO4mcD3/jBdT8LZTnLlB1b3vkBqct1xn5RkPjsdlvmG6nY/Z4ih49hPNLQvs+uBHvaUzvffc/ahaWXyf/9o1JwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOIG3YIPZTEeCpeeQXn+U9ke0NX/S7ELVL8aLf8F0+M=;
 b=eibJkM7D66+hYzN5+AcTKuCsVdvDIl5+NOTfE+r6O5xAN0tC+r6NgKf4NmPPGhK2LY7I2fc9fFJe8Xstj5NqC/BmOO9uirA/SHPtLzGtBezbkAmyCG/BVq9IucSc2xeITSVZGioCq6ZPs2IunL2+j2z8tG7CnXF4nFAsdFr3HUlnsgS7bAJF0cHMUIIvIqRf7QIWnErsnzLeRo/zHrvJgvzeLmNE7Wnbsx/6k23QIpViHEKKUOGJG8cvzje+21WRPF2PXHEjLJG3Q8blOftbVHkvRF9E+J+Y/9S/MooBT4ZWD12NJxxtISds/ZbqMGURM6WrkOvFzXYtm7q8xAT6yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOIG3YIPZTEeCpeeQXn+U9ke0NX/S7ELVL8aLf8F0+M=;
 b=jQl3fZDasglCd2oxyZnCtgRmAl+SM/MewxSE++F/1rENCXP3C3n9anVapt4yfllHDZa1Csp31knUC2Q/ixGsUvvXh1QmobOJ4Pam6DXAhtGAN0YdtdbfPJwLC5oxTcz/Vbsj77tuBBbpN2AkhebRXHCf3d3MXsY2DKW9rRxUMz50huP7W8JC3tLXgsxz5YsDSO3+SUk/UTv6bTDLmJQvfTBUPmb9FSZwL+IiM547/okTbzpw69KnlsUF9M7CdZ3ItDPg5UmetmVNw2KmsJLUavlVfL5++iLMB58fU7h2vThaYZc3kWYqz+iLyApRz+YSzuW7+5lHlFgWfaYX94XNEw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH0PR02MB8244.namprd02.prod.outlook.com (2603:10b6:610:fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Sun, 23 Mar
 2025 18:06:07 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8534.040; Sun, 23 Mar 2025
 18:06:07 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: "H. Peter Anvin (Intel)" <hpa@zytor.com>, "Xin Li (Intel)"
	<xin@zytor.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar
	<mingo@kernel.org>, Nikolay Borisov <nik.borisov@suse.com>, "x86@kernel.org"
	<x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [tip: x86/core] x86/cpufeatures: Generate the
 <asm/cpufeaturemasks.h> header based on build config
Thread-Topic: [tip: x86/core] x86/cpufeatures: Generate the
 <asm/cpufeaturemasks.h> header based on build config
Thread-Index: AQHbmL/tCQztYwdxdkmEec0xfywcqbN8L4iwgAAQ/4CABMcnQA==
Date: Sun, 23 Mar 2025 18:06:07 +0000
Message-ID:
 <SN6PR02MB4157D2C2260E6BD529BCF08AD4A52@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250305184725.3341760-3-xin@zytor.com>
 <174238223959.14745.6970497940010271580.tip-bot2@tip-bot2>
 <SN6PR02MB415756D1829740F6E8AC11D1D4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <CAHk-=whChrRQ0kuRuZo2+9D+J2BO9Q=1CV2eEk_yjrNi8kdjBg@mail.gmail.com>
In-Reply-To:
 <CAHk-=whChrRQ0kuRuZo2+9D+J2BO9Q=1CV2eEk_yjrNi8kdjBg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH0PR02MB8244:EE_
x-ms-office365-filtering-correlation-id: 568262df-6d60-4e96-7dbd-08dd6a356289
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|15080799006|8062599003|19110799003|461199028|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?ODRZRkQzZkRWRW1tWDJsY0pLYUp5QmM1TXVOWkkxTmh1YkkreDFMeFNKT3ZC?=
 =?utf-8?B?QXg3STVtM3hrMmtFbUxZNXR1ZURlbWlwbkdHUGY0VTB6TWNYUUhoazU3eUVT?=
 =?utf-8?B?dUgvOUgwVkZ0Y2JlK25VQjlnQ1RyUzhkQVF0WE5jTUlmelJiVjM2MmxjQ2NK?=
 =?utf-8?B?Ym1tZ1BrcmNEOWNKalNVdmNmaURzUzdFbk9sbUU4MzlmZExLYVpBeDN3R2lN?=
 =?utf-8?B?Y0dpU2hubXhrV0Z2L091L3UxanhxL1pVN3MwSkQ5TkpuR1ZpWnh0L1RNWWFD?=
 =?utf-8?B?ZGxaeTZIczk0d3RNZzB4QUxWL1o5ZGFMcUIwZ3RyVVMrU21RK3VCbEZxbDdo?=
 =?utf-8?B?VUNwZUpCQld1OHBWQjZVamRhVXFlQWRYMXBNUVFVbDBhUXhUNEt2cTNBSDJ5?=
 =?utf-8?B?NjhpMXloaUh0OVI2UUVEemRENVJwaXRSc2RFMnRJZjFZUFA5eHA5ekd1K2Jq?=
 =?utf-8?B?RzlPdU5lbDk0K2VNR20vYzk0YUc4aXFWcGFWMkFRYzlLdVJiNmw4eTVTekhN?=
 =?utf-8?B?ZGRVcHNtOUZPNG1za3lVRGR6ZHZVTjZGNSt4RGNvL3pEbkZ5TXV6cUVpRlVj?=
 =?utf-8?B?NG50cmlXZG9Ib2habDE3T1U5ZWxGcHkyMVJhaWhGNGdyOVpKV2VkTVdYcVJ1?=
 =?utf-8?B?TER5bjk0TWxGVXJyL1ZFZVo4VGplNVFEdklNUmRkU2dWUlo1ZHRiMU9kWVBZ?=
 =?utf-8?B?MGFnRFR1dHNrR09nWDA3TXRXYXVHVEhyUHBqR0JlcjJYY1k3Q2FWUFRMcWJ0?=
 =?utf-8?B?NmpJaW1rYTRHM0EycWcySThqYXpCSS9oT2ova2tkWHBxRkxFd1VaSU9lZVBM?=
 =?utf-8?B?aHRSRC9PRThFSUZFUEtIaU42STFTZ2Q1am80YU04UUNpTU82MU53NzNzSUpK?=
 =?utf-8?B?YWVmTFVUSjFmR0ZZWXR0a0VWTmdOZ3ZDdkduNDlwVkNpYUxrSE0rY3RSaDhY?=
 =?utf-8?B?Vml6b2VkbnY0ZHdLVGNxSUpmOTgzOXJQR0FtSFk1Qm5IL0lPRXZ6WFFvaitx?=
 =?utf-8?B?dWkrZ2U3YjU3ZDAxc3pRK0xhR0ZqN2hYbHY1OEVYQmUxQzhmUkthakI3bGx4?=
 =?utf-8?B?SS9Cb0xob2c3SHlIclc1MkxsRS9mODAwaWVBRVJ0WHJBblJzQmpLdTVjOWNu?=
 =?utf-8?B?VnYzMS8zd2prQzRsMDRUOFBSdm0yTndtQ3JWNkZEREw5QVZUN0RQenFJT2lB?=
 =?utf-8?B?N0JQaEVJUU9vcm9zcnFNa3FnNUk1MGYrcVRGdW90djd4U2QrMm5vays5bEl6?=
 =?utf-8?B?aVF2Q1BKaWVEYW1OUVFHNHEyWXFoTVhWSERKcEIxLy91Kzdwa1d6cEc3c1Q2?=
 =?utf-8?B?ajNCcmp2Wk1qM2RXZ1JORjdhZmd5aHFrSnFOS3dYUXFweVlWTHI1MTN0eFZy?=
 =?utf-8?B?TGNNbjZNRGRTdjBYQ2pxY2tCK3ZVN1VGOXg3Y3pXclgrMFNjbmJteHpEeDA3?=
 =?utf-8?B?YlBWSU9WK0grTnM3QzdpaUFJMDJiNXhWejFka1RBPT0=?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WmQ5SGRjOFIxMVJnejlkV3l4N1p5YVRXVGVGaHlsdmtJdFF5bHdlN0t3c3U4?=
 =?utf-8?B?RHRSeGhBby9nZnU3Qkk2Nm5zejFOYzZWN3NPSFhOaTVWb1VDZFVpLzFSRjdX?=
 =?utf-8?B?dU5LZGFQNDRWNGszZzUvdllpdENlZU9QMkMwem9NQ3NqUDFOSlY2Q3ZSZ2My?=
 =?utf-8?B?TVc1dzNxY1M1WjkwQVE5N3p2R2g0TEVJUENLWGdvZFdlY0NVYVF6NWdTMmJF?=
 =?utf-8?B?K0poaGt4eFZ4NVU2aVpMa0tqbTRMcW9WM2VxYlhhTWZUWngxWWkybFNHNDNM?=
 =?utf-8?B?TUovanVqWVcvYVc3Z2d2ZlJpanNoVE9GTjEva3pLQ0k1aFN1RXBUUlhTeTRj?=
 =?utf-8?B?RXNhSjZMWnBhK1dMWExNM25LY2NzRHowdnNhQXVFSjUvczRNalE5Q0ZTN3VV?=
 =?utf-8?B?dmxQYmNoM2g1dFhsYnFaaGFsK0pzNTlaS1dBSUFQa3NhRFdnb2xSSVkzS2RP?=
 =?utf-8?B?QWVlWmhSVXVMOEV6OHVoWTRUQ1RUcjBEdGorc2E5S3c2aTM1Rm1aSlBaTUNq?=
 =?utf-8?B?T3Blb3Y3QXhSbVRIdExOWEFCeUN4VDZ4dTRGMUxmRzlMcVJJVlFjYzQxZzY2?=
 =?utf-8?B?cmRXbnh6bDJPdDZmWmtKanpzb3ZMSzF6UW40eTJlQ0RKTUltNkFPUUtDaVlr?=
 =?utf-8?B?NEticXFpVkdWUURaZ25MdW1oVWpnd3hhb2w3Z2dvTTY1VkJhRkU5WVNURlM2?=
 =?utf-8?B?ZlRzMEo3T3pLYzRrdnlnRjlUdktYRXBhcS9kM0xPSFlaQWkwT3AzTW1SWTA1?=
 =?utf-8?B?L2tWZmVEbUlsMFdOcjZiZXJPQkFuL2tVM2JCTFlXTjV3dG5scnJUK3hGNm1u?=
 =?utf-8?B?VDczRWo0cWQzbTRMWVRaV3BCRGlGelZNWFFsUStXeWZDZENrRS9vMTMxY3h3?=
 =?utf-8?B?T3lQOUVua3NSSGphSWx5TnlvTnpUY3BYcENLRm45UjZ4elE3T2I0UVEzcTdz?=
 =?utf-8?B?UW04RWx6dDFMUllHdUlBYXVjMTBreFBMT21hRjBueHI3K1V2L2VZVWJ2WW03?=
 =?utf-8?B?S0gvRWEzMVdaaHR3OXprOHc3cHg4RmZYSS90ekxlKzZCUjBqUWptRjdwbWlF?=
 =?utf-8?B?OU1iREhTOUR6Y1RZZkorcU1zb0dPRVZ3eWhyVEdkNWV6b1NOTTRBSnN4ZXlp?=
 =?utf-8?B?dXV0eFNGQkxGczhjQWVVOEx0RngrQUxTa08wYmhpMWVCZ1NKOWpDN0pLTDVY?=
 =?utf-8?B?c0s5VitWWjBDTHlzNWdkT0FnRTlZMDczOTcvWlRrZHJOdkZ4SEcxMDRLaGwv?=
 =?utf-8?B?d0Z5dHltU0N3RXk4ZnN2b3ppdERzZVdJUzRxUGptSVh2b2dPV3U3RWMyS1FR?=
 =?utf-8?B?Q1o1QkdHUUZxVFhkaWlobEpycU1jbitzeStHUVJ1OE4rZGJpM0d4Ni9XQzh6?=
 =?utf-8?B?dk9tc2NiQ0w3SWFUL1lPdkdzWE1DeHh0RGROQTIwcm9GdmZwREdqbWVidWpO?=
 =?utf-8?B?eTdjWHZFSzNKUVRhMjZFZ29IdXNTNVcvQ2d0SE5hQXNqaUt0SzhiYWpFc3E3?=
 =?utf-8?B?d3ltUWpvNnlyR05jaUphTkpiRUQ3QWpnenBDb1phWDJnUStlM2JqdHhuMi9H?=
 =?utf-8?B?M2w3NXdGK29BT2R3Tk4vbVAvNEQyM0hlaEFaVHBBYkpPUkpmb3VyYTVOeUZF?=
 =?utf-8?Q?SltknFHHli+zlwkrtgL9tbU0pZoalhxjwxMnE9IlFOS4=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 568262df-6d60-4e96-7dbd-08dd6a356289
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2025 18:06:07.4998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8244

RnJvbTogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPiBTZW50
OiBUaHVyc2RheSwgTWFyY2ggMjAsIDIwMjUgOTo1NiBBTQ0KPiANCj4gT24gVGh1LCAyMCBNYXIg
MjAyNSBhdCAwOToyMywgTWljaGFlbCBLZWxsZXkgPG1oa2xpbnV4QG91dGxvb2suY29tPiB3cm90
ZToNCj4gPg0KPiA+IFdpdGggdGhpcyBjb21taXQsIGNoYW5naW5nIHRoZSBtb2RpZmllZCB0aW1l
IG9uIC5jb25maWcgY2F1c2VzIGNwdWZlYXR1cmVtYXNrcy5oDQo+ID4gdG8gYmUgcmVidWlsdCwg
YW5kIHRoZW4gYWxsIGRlcGVuZGVuY2llcyBvbiBjcHVmZWF0dXJlbWFza3MuaCBhcmUgYWxzbyBy
ZWJ1aWx0LiBJdA0KPiA+IGRvZXNuJ3QgZmlndXJlIG91dCB0aGF0IG5vdGhpbmcgaGFzIGNoYW5n
ZWQgaW4gLmNvbmZpZy4gQSBmYWlyIGFtb3VudCBvZg0KPiA+IHVubmVjZXNzYXJ5IHJlYnVpbGRp
bmcgaXMgZG9uZS4NCj4gDQo+IEhtbS4gTm9ybWFsbHkgaXQgaXMgdGhlIHRvb2xzIHRoYXQgKmNy
ZWF0ZSogdGhlIGNvbmZpZyBmaWxlIHRoYXQNCj4gc2hvdWxkIG5vdGljZSB0aGF0IGl0IGhhc24n
dCBjaGFuZ2VkLCBhbmQgbm90IHdyaXRlIGEgbmV3IG9uZS4NCj4gDQo+IFNlZSBjb25mX3dyaXRl
KCkgaW4gc2NyaXB0cy9rY29uZmlnL2NvbmZkYXRhLmMgZm9yIHRoZSBwYXJ0aWN1bGFyIGNhc2UN
Cj4gb2YgdGhlIHJlZ3VsYXIgIm1ha2UgKmNvbmZpZyonDQo+IA0KPiA+IEknbSBzZWVpbmcgdGhp
cyBjaGFuZ2VkIGJlaGF2aW9yIHNwZWNpZmljYWxseSB3aXRoIHRoZSBtYWtlLWtwa2cgc2NyaXB0
IG9uDQo+ID4gVWJ1bnR1IDIwLjA0LiBJdCdzIG5vdCBjbGVhciB3aHkgbWFrZS1rcGtnIGlzIHVw
ZGF0aW5nIHRoZSBtb2RpZmllZCB0aW1lDQo+ID4gb24gLmNvbmZpZywgYnV0IHByaW9yIHRvIHRo
aXMgY29tbWl0LCB0aGF0IHVwZGF0ZSBoYWQgbm8gbmVnYXRpdmUgZWZmZWN0Lg0KPiANCj4gSXQg
c291bmRzIGxpa2UgdGhlIG1ha2Uta3BrZyBzY3JpcHQgc2hvdWxkIHByb2JhYmx5IGJlIGZpeGVk
IHRvIG5vdA0KPiBvdmVyd3JpdGUgdGhlIGNvbmZpZyBmaWxlIHVuY29uZGl0aW9uYWxseSwgYW5k
IGRvIHRoYXQgIm1ha2UNCj4gb2xkY29uZmlnIiBhbmQgZnJpZW5kcyBkbywgd2hpY2ggaXMgdG8g
bm90aWNlIHdoZW4gaXQgaGFzbid0IGNoYW5nZWQNCj4gYW5kIGxlYXZlIGl0IGFsb25lLg0KPiAN
Cg0KRm9yIHRoZSByZWNvcmQsIHRoZSBwcm9ibGVtIHdpdGggbWFrZS1rcGtnIGlzIHRoYXQgaXQg
ZG9lcyAibWFrZSBzeW5jY29uZmlnIg0KbXVsdGlwbGUgdGltZXMgaW4gcHJlcHBpbmcgdG8gYnVp
bGQsIHNvbWV0aW1lcyBwYXNzaW5nIGVudmlyb25tZW50DQp2YXJpYWJsZSBBUkNIPXg4NiBhbmQg
c29tZXRpbWVzIEFSQ0g9eDg2XzY0LiBzY3JpcHRzL2tjb25maWcvY29uZiB1c2VzDQp0aGF0IGVu
dmlyb25tZW50IHZhcmlhYmxlIHRvIGRlY29yYXRlIHRoZSBoZWFkZXIgb2YgdGhlIGdlbmVyYXRl
ZCAuY29uZmlnDQpmaWxlLCBhbmQgdG8gZm9yY2UgYSByZWJ1aWxkIGluIGluY2x1ZGUvY29uZmln
L2F1dG8uY29uZi5jbWQgaWYgdGhlIHZhbHVlIGNoYW5nZXMuDQpTbyBmbGlwcGluZyBiZXR3ZWVu
IHR3byBkaWZmZXJlbnQgdmFsdWVzIGNhdXNlcyBhICJuZXciIC5jb25maWcgdG8gYmUNCmdlbmVy
YXRlZCBldmVuIHRob3VnaCBub3RoaW5nIG9mIHN1YnN0YW5jZSBoYXMgY2hhbmdlZC4NCg0KSSBo
YWNrZWQgdGhlIG1ha2Uta3BrZyBzY3JpcHRzIHRvIGNvbnNpc3RlbnRseSB1c2UgQVJDSD14ODYg
YW5kIHRoYXQNCnNvbHZlcyB0aGUgcHJvYmxlbS4gQnV0IHRoaXMgaXMgYSBwcml2YXRlIGhhY2sg
YXMgbWFrZS1rcGtnIGhhc24ndCBiZWVuDQp1cGRhdGVkIGluIHllYXJzIGFuZCBpcyBubyBsb25n
ZXIgc3VwcG9ydGVkLiBJbiBVYnVudHUgcmVsZWFzZXMsIGl0IGlzDQpkZXByZWNhdGVkIGFmdGVy
IDIwLjA0Lg0KDQpNaWNoYWVsDQo=

