Return-Path: <linux-kernel+bounces-572923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35443A6D073
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 18:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2C8016E4FE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 17:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B94C1991DB;
	Sun, 23 Mar 2025 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ov95lJhE"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19010008.outbound.protection.outlook.com [52.103.11.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDB1190472
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 17:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742752343; cv=fail; b=nBUIKtMmT3Wv/VqS/eBrw5q5Y+a3afzPl5clx/VhaSxE1EQDjKTUZBjeDCkGxGONIG/leXUfAl+5JrVrNOucnbrh2xmUL4Fw3N4pr/iWXAHiiNFx5SnouSxMCni5+zfIsQGv7EfF5O3fG9eTzcT0bz1ErqS7169pj/pokUecvSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742752343; c=relaxed/simple;
	bh=A4AoeaEvE98lMRVMnVhOT/O73sRCiSk41wqoKKkVSIg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lN1sLH8n5R0y/l60tWrUiqk4Xf/f1SMSYwlvMSAuYgsMp3p0SuDpqWNT4pjUBt46wNDUdlARDZDsa+3GdyS60u6LG4aJavy2i3ZluYZNMFykYzPuRO0t2D1d0+hcYCfWEp+stVy8xsMLzHF+x5eo1yWej9N8xiaz7ubI2ksFou4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ov95lJhE; arc=fail smtp.client-ip=52.103.11.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SyCiu339TuJXMmbUvsTT7FMB3z+AJ8Th5MUfJ/vxCysfaXcsHex/WXu+kB5XAolZHSQ5nvVkuGPQ9souaqbf3s78nKZ+qWDl0pdyXVOzJ4HAA6y3rvt96aMGW2gLiyqyVljuaBsDhl/aHUooF9IVk1Mz4Sr2k34+GA3ehKN1fem+7W0iffqOX1fqTozdJ9x/1QnGmQsMtpplfo1CBl1zzquoHMblJG3PqsWxUDvAnn6JXq5r75BbPF+B7zKW+zPTC5epb24H+APKymOA0onqyAlWGXc5dhixzu0/YtYfjVBEKFngfq9L6sTIniDJaB1ZDGYE4oMpeMIebbkufcKHVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4AoeaEvE98lMRVMnVhOT/O73sRCiSk41wqoKKkVSIg=;
 b=AzlHPIPwC7E3Cl3NEGupEk/v+77WaQq0G802nJ3bae8UajyjN77eaIrz+XK/wPpHLzqmQT3UFfHfxtTAgK9qO+u0ddeYczkbabX/ZXWguYVPjUs+1ELOdQG7I9jffB3/pQtHMBtxKVXLH3g41NXQxJJgy22VoC2OVkFwMhXZOpkQDxt3IQOjdo9YA5Z/U3UOkaRJZbspoO4i24hHsfNaJVck9RLctf2WXYVYHF4GCe/vytdoWcKTJxi1zEVDqD3XnmychmXIJrbXcyifbjCJ2+zaEtk7YWk3rErGA0oH8ivAhaz6dp43N9foDvD1ZjLU+cu0SkxYuPL4ogKbsHN5lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4AoeaEvE98lMRVMnVhOT/O73sRCiSk41wqoKKkVSIg=;
 b=ov95lJhE5rgBsac2ihrALnB/mDIKu6esuce0qVC9RljpXEZibojb5woDCGm0lUbxvK5c9dTDQgpfSqhdUsu/dtcBOq3v8zisTyvxHhebLdfFxUVWYHmnocHA5myrNk6YQzbqvWdLmtpJI7uTT46iVevleUb7brwcDnOJkAq8MDdKnX2TZLse6EaKU3abWfK8p8ConTGNnnvS1yRkih5/uflhFRu9I/mXMhuJRjFk78x96VE2Vo3AiBNxDbFe2B37qYZ4U23mUdDFIsRfGBQqIP3wJ1k5tSW2kxj2m58NMbyTZzb5tLNl0euomnkOiKE/003u3dE4WvOemw/ueedgvg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB9747.namprd02.prod.outlook.com (2603:10b6:610:17b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Sun, 23 Mar
 2025 17:52:17 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8534.040; Sun, 23 Mar 2025
 17:52:17 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nick Terrell <terrelln@meta.com>, Ingo Molnar <mingo@kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, "dsterba@suse.com" <dsterba@suse.com>,
	"brgerst@gmail.com" <brgerst@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: Compile problems w/gcc 9.4.0 in linux-next
Thread-Topic: Compile problems w/gcc 9.4.0 in linux-next
Thread-Index:
 AduZw3CVEeBLGArOR7mAlPxdXuU1qQACZlCAAALC4gAAArDlMAAUVscAAA/WCVAAImbcAAAswVuAABqq9MA=
Date: Sun, 23 Mar 2025 17:52:17 +0000
Message-ID:
 <SN6PR02MB4157AF07EC9A5566473CC135D4A52@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <SN6PR02MB415723FBCD79365E8D72CA5FD4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <CAMj1kXH-awwT99FTaBJqyEbgBoxc20h4LfbzXMP00NQHBs03+A@mail.gmail.com>
 <SN6PR02MB415765C109AF9820DDC3AF0FD4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB41575C4BA0C467B1C95EEB21D4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Z90XZqJVwuWkarnX@gmail.com>
 <SN6PR02MB4157E2AC0708EB2074302E6FD4DB2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Z95oip1UjPofpHUq@gmail.com> <346FD6B5-CB59-4A40-81B0-1C5B5A0A6C42@meta.com>
In-Reply-To: <346FD6B5-CB59-4A40-81B0-1C5B5A0A6C42@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB9747:EE_
x-ms-office365-filtering-correlation-id: dcfddbe1-e284-49d1-6ee4-08dd6a3373c0
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|461199028|8062599003|8060799006|15080799006|10035399004|440099028|3412199025|4302099013|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?utf-8?B?UC9Pa2pDblh0c0FoMUxBTkJMUXZqZlRQbDdORmh4cUZVcjhNemhRS1hZUFo2?=
 =?utf-8?B?cjRjMlM3Qi82Z1cyWFJGcWw0NVBFa2E3TGMwYWxKWlRDaDJmVCsza0ZjTHQr?=
 =?utf-8?B?SDJQeFR1UTNva2FSZGc1dFdkT1Fia3g5a2xhNEhoTjFwMXYrbnFUcHdoOW95?=
 =?utf-8?B?dE11RVRjbC9Ib0l4RnFrM1V3WENpSm5qK29Damo4Rm1jR1NFaHlZZ1VLZVhh?=
 =?utf-8?B?eVBrS2dEcXNYOFhiNFVrSks1WWFDdW11b0pUcElSU3R5aUtrZGJHSjZQKzRM?=
 =?utf-8?B?RndiYm9nZXEvU0lFU1o3MzAzclRSQWcydDZKQnVEelVaTzhFVG5uVm0yU0xI?=
 =?utf-8?B?Z05yYUh4dXN1N3RvS01ycFZQWnlvMGVHU1VFNE5nbUZ6VE1Vc0FyZ3Jxdk9j?=
 =?utf-8?B?Y3BCOVhvaDgrY3NuNlhlQjE3RG9teU5aN3VPZXlrazVDZHJXZEQ4VDBzMW5D?=
 =?utf-8?B?b0R0ZUtmL09iVGVUdHpIT2JldEt1a1pIck5WaVM2L0J1QXRONm5lLzZrNGs3?=
 =?utf-8?B?SzdoT2kwbDNqNHIxZytjNUN0dTRQb1ovVFV4SjJIS0twMWJXWGJkSmRaMUc2?=
 =?utf-8?B?cHVMaWN0MDRZcDZucTFxQmFFaGxrQXB5WFU2RUFzL1RtWlR3bTNqUUpKZW1x?=
 =?utf-8?B?MkJpMjJrNm1mQ3NQTitoaS9zVlpzdUR2OFZQNHNRaTNHa0U2bWc0T1FMamQz?=
 =?utf-8?B?a0l2YmVjQUk2eUtISG5YbFhlK1V1UncwSGgvaW12eGtXYWk2cXR2d0N4a1dR?=
 =?utf-8?B?b3QzbURQZTQ0VDJWbmJZaUczUW9JR2ZxUE1QMzN1NDUrbFhMM1JKWHpGUkhm?=
 =?utf-8?B?R1lLcjEyTGtHWExhclV4L3ZlODRxaldxd285TTMzZEtCa2ZkS1BtN1NIODlH?=
 =?utf-8?B?V2N6OTdOczNjZFFEQUdXaU5ncnZtWlAzajR5MEQ0dldjOXpoa3pTRkgwdVRn?=
 =?utf-8?B?MDBoaXFzbTgvOFEvTzZFSlM2RmJ3VXUrYmFZdXlzbHVaN25CNndMVDA2c3N5?=
 =?utf-8?B?N0h0N3RWN0pmRWNZNFRqbG9vS1Z5T01SRGp4MWlWTlVEVmtmWmxJMjhZdjhL?=
 =?utf-8?B?SmQ2Ni9KZEh0R3BNdlZwL1c1VDRTTy9PMFI5YlR5SFh3UTZBQ3lkOFY0Nldp?=
 =?utf-8?B?UkZnWHlKc0hpbWp3ZkFSWU5HMDRNSnlEd2pOaE9GRnAvUWxKK2E3MUdrUmFN?=
 =?utf-8?B?VFhnTjZmRkwzVFhhbE9DTStYRFA4UFB4MjE5T0pUTTZ6MDZLZ3Fma3RMNTNr?=
 =?utf-8?B?K2JvYmlWb3k1Qk94UTdZakhjeUViYVdnSThObGFQQW9kK0laWmxGS3o2VTJ4?=
 =?utf-8?B?NXlBdnY5VlB4S28zbEJKWVBmMERWcXo1ODRhUlBZK2plK1N3eGdJUmI3RHRK?=
 =?utf-8?B?a1hUNFNSM09GNDNnL2hYaHgrUkF4OEwydnYvU2Fnc1hPV2tTSmpsaXdyYlZB?=
 =?utf-8?B?ZTNBeGEzTzZnRHBwZExZUDVFZ0JVWWNTRU9vS2V0MytrbEdUaTZDTkhyczcv?=
 =?utf-8?B?WGxncWVwMkNXUUFDM2RWUTJaTjZPVDJIaS9EVW8zWG81cVRTZlE2dzViaWVo?=
 =?utf-8?B?UnY1NEdIME1UOG9kZ1FIV2laelM1QlVMbUZwc01Dd2RyUHJJVEFLOWRQbFYr?=
 =?utf-8?B?U1ByenVrM1BIVzNheFQrWjE2cmszUXA4N1R5Z0NMSWRXUkdGYThyV1NubU0x?=
 =?utf-8?Q?KduBWmtJxZneCsC6WjoN?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZWo4bVJIOHRVd0dEZ3Y4YjdBOHNFRUFyb3lFTTJaUXIzeEwzRFNmUVZoOTAy?=
 =?utf-8?B?Q3BOSFJYN202aFQ5TXVrVDlETHl2OGJsT1Nta21OaXNwRWRMWTF2THR6K3ZY?=
 =?utf-8?B?WEpPOG52NENiVVJZYWhwYzZOTHRVSjVTNDdUQTk2emp0U2g2REtJNHZpR1g4?=
 =?utf-8?B?TzFyVXdDQ29qRGxXbE1NeGM4citSZHNaSmtabFRscGxCUmMwVTJkQVBDUGZB?=
 =?utf-8?B?bEN5cGlTNmtLZmlzWXRSSnRXM3MybUlLK3NEZ0ZQdmU4RFJ6VEh2MHdPNWVG?=
 =?utf-8?B?Wi91R3p2RERoeGhNS3dnV0laV2loZ2E0d1k4amNqQVlCbmFWUk12OG0reFFr?=
 =?utf-8?B?TDlUUzVnSWtWdGxoaGwrcytUK0dwaGR1bDZSZGR2d214d3lKQUYvTmt3Q01J?=
 =?utf-8?B?c21makZJV2NNSWIzZlNzYWdPRE5uVWlxdC9ncFNVRTFFV3RvNzBjVXlYVlg1?=
 =?utf-8?B?aWsrOXB1OTlhTEEwaTd1RTRiNUQ0VkNZeEF4MlNHbnNVMS9RRFBKcmR6T1JQ?=
 =?utf-8?B?clkyem5DNTJKZ3lzcHE3VnRFU3k2eVk4bVUrNG5rd3J2c3RQUWVQOG5aMW52?=
 =?utf-8?B?Y2Z5dE9PUHdVSkxWeU5VZW4xUlRxVGI2NlBNbGxzd3ZyWm1aRm9zYWxVRzFp?=
 =?utf-8?B?N0srN0VNOVJpeDJQUnd4WWZRcDNISzI0UTFxOWY4VnZxNThOVHM0VlY4WmQ4?=
 =?utf-8?B?aWYwYW1FM2xESzlKdmhtN3h1TUZFUGlDY0xMTit4cktoUVc1RmdvVXlEd1JW?=
 =?utf-8?B?N1IwK1JGUTBldDMrdXdLWnhzSGtZQlVjTjVKeTZvMkhLYmNsVWpvU2JRMU5z?=
 =?utf-8?B?VEJRMHprV2dwaGV4QVNOaE45SGc0b2c3TlowWlNSTExRcDNVUkVuV1JpL1Z3?=
 =?utf-8?B?OGlPWktFajVwcTlrT2ovZXpSNE5HMDh6bjlyUVBaV0RkTy9SZDdXd1hZcjhB?=
 =?utf-8?B?c3Roak1rZ2dQODlsYkNjK09PaTBseExqcTRITDdnR0VpQUtOZTMrbWdKOGdh?=
 =?utf-8?B?aGR0dlRtZjc5WDYzd25UUThYeVZxOVJyZGhmMVI5OXVDaHVmSVIrQk5VdkVK?=
 =?utf-8?B?ZHlPZHFmRGluQjJuZWF0ZGI0S0hHeFYzS1BEU0tvbUFVM2Uyd05UMzZlWFNw?=
 =?utf-8?B?dXlEVDhpOXNyZXZrT3NIV083TGNCemY1WjRmQytUcjdSWDJ6Q0MzMnJNWm1v?=
 =?utf-8?B?ZS9yR1RVdUh0RUdwNklDUzMxYVJ3dWt3dTZ3WVAyNzhmbnJabHlSQzRQRjVB?=
 =?utf-8?B?Rmo3TUdMdHhaRFpiQVpHQ0FONExscU9Ma3JXZzV1NGxnNnZQNWFZbUNUUDhy?=
 =?utf-8?B?YTlUL016K21aKzhHd25oeEVWWEpwcU1KN2VEa0lGclE3SXR3TUFFUU84RG13?=
 =?utf-8?B?OE9uQ2Eyb0ZMUGpsM2orUnAwdVlLNHhRUzBVWTlJazFTV0ttVnpJaVBPNW9H?=
 =?utf-8?B?aE8rQlBhbll3eGJmR2EvblRkNkorRTdJL0pBNDZaNlptRTFuZ0lYa0trTGtR?=
 =?utf-8?B?ME9VQjNKNWhJaDRpajhlbEloOUpwVXFkcHlGWm5XcXh1NVNNVCt2Q1hRVGZI?=
 =?utf-8?B?TnprclVhWGxDQXc1QzdFOUJkT24yQkp5dzcvb0VGeEQzMXFpWm1XRm1FSWJZ?=
 =?utf-8?Q?wAbgpFQsHwNx4WFGuo7e9S3rb40Nh86oK7qc1gjdkO3c=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dcfddbe1-e284-49d1-6ee4-08dd6a3373c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2025 17:52:17.4096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9747

RnJvbTogTmljayBUZXJyZWxsIDx0ZXJyZWxsbkBtZXRhLmNvbT4gU2VudDogU2F0dXJkYXksIE1h
cmNoIDIyLCAyMDI1IDk6NTggUE0NCj4gDQo+ID4gT24gTWFyIDIyLCAyMDI1LCBhdCAxMjozNuKA
r0FNLCBJbmdvIE1vbG5hciA8bWluZ29Aa2VybmVsLm9yZz4gd3JvdGU6DQo+ID4gDQo+ID4gKiBN
aWNoYWVsIEtlbGxleSA8bWhrbGludXhAb3V0bG9vay5jb20+IHdyb3RlOg0KPiA+DQo+ID4+IEZy
b206IEluZ28gTW9sbmFyIDxtaW5nb0BrZXJuZWwub3JnPiBTZW50OiBGcmlkYXksIE1hcmNoIDIx
LCAyMDI1IDEyOjM4IEFNDQo+ID4+Pg0KPiA+Pj4gKiBNaWNoYWVsIEtlbGxleSA8bWhrbGludXhA
b3V0bG9vay5jb20+IHdyb3RlOg0KPiA+Pj4NCj4gPj4+Pj4gV2hhdCBhcmUgeW91ciB0aG91Z2h0
cyBhcyBtYWludGFpbmVycyBvZiBsaWIvenN0ZD8NCj4gPj4+Pg0KPiA+Pj4+IEZZSSwgdGhlIHNh
bWUgc2VnZmF1bHQgb2NjdXJzIHdpdGggZ2NjIDEwLjUuIFRoZSBwcm9ibGVtIGlzIGZpeGVkDQo+
ID4+Pj4gaW4gZ2NjIDExLjQuDQo+ID4+Pg0KPiA+Pj4gU28gdGhlIHBhdGNoIGJlbG93IHdvdWxk
IHdvcmsgdGhpcyBhcm91bmQgb24gR0NDOSBhbmQgR0NDMTA/DQo+ID4+DQo+ID4+IEkndmUgY29u
ZmlybWVkIHRoYXQgdGhlIHBhdGNoIGdpdmVzIGEgY2xlYW4gY29tcGlsZSB3aXRoIGdjYyA5LjQu
DQo+ID4+DQo+ID4+IE5vdGUgdGhhdCBJIGNvbmZpcm1lZCB5ZXN0ZXJkYXkgdGhhdCB0aGUgZ2Nj
IHByb2JsZW0gaXMgZml4ZWQgd2l0aA0KPiA+PiAxMS40LiBJIGRvbid0IGtub3cgYWJvdXQgZWFy
bGllciBnY2MgMTEgbWlub3IgdmVyc2lvbnMuIExlbW1lIHNlZQ0KPiA+PiBpZiBJIGNhbiBnZXQg
dGhlIG9yaWdpbmFsIGdjYyAxMSByZWxlYXNlIGFuZCB0cnkgdGhhdCB0byBjb25maXJtIHRoYXQN
Cj4gPj4geW91ciBwYXRjaCBoYXMgdGhlIHJpZ2h0IHZlcnNpb24gY3V0b2ZmLg0KDQpBZnRlciBh
IGJ1bmNoIG9mIG1hbnVhbCB3cmFuZ2xpbmcsIEkgZmluYWxseSBnb3QgZ2NjLTExLjEuMC0xIGlu
c3RhbGxlZA0KYWxvbmdzaWRlIGdjYy05LjQuMCBpbiBhIGNsZWFuIFVidW50dSAyMC4wNCBWTS4g
QXMgZXhwZWN0ZWQsDQpidWlsZGluZyBsaW51eC1uZXh0LTIwMjUwMzIxIHdpdGggZ2NjLTkuNC4w
IGZhaWxzLiAgQW5kIGJ1aWxkaW5nIHdpdGgNCmdjYy0xMS4xLjAtMSBjb21waWxlcyB3aXRoIG5v
IHByb2JsZW1zLCBhbmQgdGhlIHJlc3VsdGluZyBrZXJuZWwNCnJ1bnMgY29ycmVjdGx5Lg0KDQpn
Y2MtMTEuMS4wLTEgaXMgdGhlIGVhcmxpZXN0IDExLnggdmVyc2lvbiBJIGNhbiBmaW5kLiBJdCdz
IGZyb20gdGhlDQpEZWJpYW4gcmVwbyBhcmNoaXZlcy4gSW50ZXJlc3RpbmdseSwgZ2NjLTExLjEu
MC0xIGFsc28gcmVxdWlyZXMNCmJpbnV0aWxzIDIuMzUuMi0yIChpdCBmYWlscyB3aXRoIDIuMzQp
LCBzbyBJIGhhZCB0byBtYW51YWxseSBpbnN0YWxsIHRob3NlDQpwYWNrYWdlcyBhcyB3ZWxsLiBC
dXQgMTEuNC4wIHdvcmtzIGZpbmUgd2l0aCBiaW51dGlscyAyLjM0LCBzbyBtYXliZQ0KdGhleSBk
b3duZ3JhZGVkIHRoZSByZXF1aXJlbWVudHMgYXQgc29tZSBwb2ludCBpbiB0aGUgbWlub3INCnVw
ZGF0ZSBzdHJlYW0uDQoNCk1pY2hhZWwNCg0KPiA+DQo+ID4gVGhhbmsgeW91IGZvciB0aGUgdGVz
dGluZyENCj4gDQo+IEkndmUgc3VibWl0dGVkIHRoYXQgcGF0Y2ggaGVyZToNCj4gDQo+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyNTAzMjMwNTA3NDkuMTY1ODYzLTEtbmlja3J0ZXJy
ZWxsQGdtYWlsLmNvbS8NCj4gDQo+IEkndmUgbWVyZ2VkIGl0IGludG8gbXkgbGludXgtbmV4dCBi
cmFuY2ggYXMgd2VsbC4NCj4gDQo+IEJlc3QsDQo+IE5pY2sgVGVycmVsbA0KPiANCj4gPj4+ICsr
KyBiL2xpYi96c3RkL2NvbW1vbi9wb3J0YWJpbGl0eV9tYWNyb3MuaA0KPiA+Pj4gQEAgLTU1LDcg
KzU1LDcgQEANCj4gPj4+ICNpZm5kZWYgRFlOQU1JQ19CTUkyDQo+ID4+PiAgICNpZiAoKGRlZmlu
ZWQoX19jbGFuZ19fKSAmJiBfX2hhc19hdHRyaWJ1dGUoX190YXJnZXRfXykpIFwNCj4gPj4+ICAg
ICAgIHx8IChkZWZpbmVkKF9fR05VQ19fKSBcDQo+ID4+PiAtICAgICAgICAgICYmIChfX0dOVUNf
XyA+PSA1IHx8IChfX0dOVUNfXyA9PSA0ICYmIF9fR05VQ19NSU5PUl9fID49IDgpKSkpIFwNCj4g
Pj4+ICsgICAgICAgICAgJiYgKF9fR05VQ19fID49IDExKSkpIFwNCj4gPj4+ICAgICAgICYmIChk
ZWZpbmVkKF9feDg2XzY0X18pIHx8IGRlZmluZWQoX01fWDY0KSkgXA0KPiA+Pj4gICAgICAgJiYg
IWRlZmluZWQoX19CTUkyX18pDQo+ID4+PiAgICMgIGRlZmluZSBEWU5BTUlDX0JNSTIgMQ0KPiA+
DQo+ID4gV29yc3QgY2FzZSwgaWYgaXQgaXNuJ3QsIEkgc3VwcG9zZSB3ZSdsbCBnZXQgZm9sbG93
dXAgYnVnIHJlcG9ydHMuDQo+ID4NCj4gPiBUaGFua3MsDQo+ID4NCj4gPiBJbmdvDQo+IA0KDQo=

