Return-Path: <linux-kernel+bounces-392051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3F99B8F1D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 507FBB234C7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C9518952C;
	Fri,  1 Nov 2024 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="RT1sXvJH"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02olkn2091.outbound.protection.outlook.com [40.92.44.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508FC15D5B6;
	Fri,  1 Nov 2024 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.44.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730456610; cv=fail; b=fGsRIOCcy4dpPA02yBP1sBuhudnK7kU4IZnEt/Xcm+oXjBSnMxw7K4zOUUefpkNJW3AU0GZkjZG2gfB7jxq/rmGhrdbWumf1eCzio58x/A0mHPbtdLCN8ZsZLQrFKTvzFUsGKjjZdd2Cw55gDPmQUil5YN1/IQGBC5QFlSo4Bwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730456610; c=relaxed/simple;
	bh=VI/8uPm6GLXfS0XqO8ysUaWgPAatn8v5JRBefgksAaQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s/Sn6urVvSE5qhadTTLKSN3NDERIzAgHde7FR2lbHIgw3CB3R+8tk3xNDP6owSNLwJulqQdKGSgkAdih1zbrJ7nmCS/JYKnSCM37EwHuFBGCJ8yBdD703hRWx2/xZc2QOlePFD2vJetC65AFWQwlaG5a1f4Dag3fzEMhUH1UouI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=RT1sXvJH; arc=fail smtp.client-ip=40.92.44.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QyhlxDQeSNqjmtsqRSCTIhhWjShGj/9QuU4AXHMF0hiKaZKvonOysnre+z2p//jgv01wz9B+AIc/OYlZlDGBvcFzaiXqPDcRpOeyOZsrTGIFF03DVXwfDzaxXsJ4YM6pc/legtQiXufHYwunESoN0+HjM3sAgANoF/V14ipxMMucJE42stsqswqe8xVjCerl5WN5j5baHfNSTPOWgFi9aw7j9pP9gDFeO8NYT/C3mSOl6Foq6Q7DQWf6/Uk/UP9ygmeZflMK+RPMMt/8SP/hHoFpqBtArtFAVxaQaoWh871YTNWjvP2x28Dq+9prjac2RRxrQqZfbDV1EiN6XNcp3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VI/8uPm6GLXfS0XqO8ysUaWgPAatn8v5JRBefgksAaQ=;
 b=KhorTpXz5kef/EkGVKIG98bfZz7DdJN8dNSgNmxXDlZQvmzMakOrQx5JkdJzie60sHdmiGR0+D0VZr0+qcKXT3Vo+qAnfD0w1g3GaqrXd2XZPpNgvTA1WaySnEkMLy52F+U4ZV8ytL1dIpFNz+fMP1KXIwNvWxp7FZEbfA+Uf9KLzR1NEyuZ2ASmelwqn2cQ/Tcyt5PcUKdlzyBu+A1jMMRC3rv/ecJRURZ2XOvbyd2lGcTclYq/qU7nlU33jH0FA5aoOeF8P10eq8PfM0myPa84D38ZVZSVxCwe89NIOQTsDIPDKi0rHYbJh8i476jo2opH04beGEgflv+xSWtWkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VI/8uPm6GLXfS0XqO8ysUaWgPAatn8v5JRBefgksAaQ=;
 b=RT1sXvJHBpiSAsBs1Y+/5TO1iZrjOZ0ZMKZCUFWlWTyWd1atespv21LjRMy3dIGh+OBjIrRdziV3LcnGOJE9+6oeMv7K6JbiGlseWOtxPgg3AnCfkLC9iHgeSWqLPr0bNL7fVAFZqAgO4lFd2ncamT6lfC70sW/pG2AtM11RtOWvNqoO1IBTRMUw+5x2bBuPY4m7ZfgaZCvQLiSSzdKMXrcyz6mHUICLECon890Z6oXQDMVt2is5cZiFJ4GiuEHWBequzTpvu3FmLUsG805o1xVdATFxVqmp4OHHLy/9kGtVin94Gn1Df/k4DXO6xeyYs3FgzFMC4mbEuvBAigc9tQ==
Received: from BL0PR02MB4914.namprd02.prod.outlook.com (2603:10b6:208:53::23)
 by DS0PR02MB9273.namprd02.prod.outlook.com (2603:10b6:8:14b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 10:23:23 +0000
Received: from BL0PR02MB4914.namprd02.prod.outlook.com
 ([fe80::906b:d00a:2d95:d089]) by BL0PR02MB4914.namprd02.prod.outlook.com
 ([fe80::906b:d00a:2d95:d089%3]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 10:23:23 +0000
From: Filipe Xavier <felipe_life@live.com>
To: Lyude Paul <lyude@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, Miguel
 Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJuIFJveSBCYXJvbg==?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Martin
 Rodriguez Reboredo <yakoyoku@gmail.com>, Valentin Obst
	<kernel@valentinobst.de>
Subject: Re: [PATCH v3 2/2] rust: sync: Make Guard::new() public
Thread-Topic: [PATCH v3 2/2] rust: sync: Make Guard::new() public
Thread-Index: AQHbK+oeZFmQtg8uyESeAvoIm2eaG7KiN6Pq
Date: Fri, 1 Nov 2024 10:23:23 +0000
Message-ID:
 <BL0PR02MB491496C88E898872E92339E2E9562@BL0PR02MB4914.namprd02.prod.outlook.com>
References: <20241031231025.3466571-1-lyude@redhat.com>
 <20241031231025.3466571-3-lyude@redhat.com>
In-Reply-To: <20241031231025.3466571-3-lyude@redhat.com>
Accept-Language: pt-BR, en-US
Content-Language: pt-BR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR02MB4914:EE_|DS0PR02MB9273:EE_
x-ms-office365-filtering-correlation-id: efe147f1-7db5-4b67-118f-08dcfa5f371a
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|7092599003|461199028|15080799006|8062599003|19110799003|15030799003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?d2ZHRFRsRUJXeThjcG43RXB4WUhEREVzN1ltakJQeDM4WDhEdDFKREk3aFFH?=
 =?utf-8?B?Vm9yc21yLzZidEpZT3U4VnlCSXRTTE9wR3RQMytUQjdndE55WEJRbjNWazh4?=
 =?utf-8?B?dnptNDV2MHhib3ZEbXo3RVJhUDcxNUlTNGt2WjRHU0xZTnRPVTVOZjBsRXQ3?=
 =?utf-8?B?UW5wSVZQNUtIdGhxdE5GSkpURUV6Z3Jtc2lUTkZ4djZUellzZVJkMFdUdlN3?=
 =?utf-8?B?bTJNTjlHRFZaUzlPVld3VlE3Nm95VE0zSksvSFpGMyt4RmF3U3pXVHJoWnZp?=
 =?utf-8?B?VTZDYlBScTRZWW1KaWhiKzlBVTZTS1hpQ2duOGxqaVpKT0N0M1MyMWYzemw0?=
 =?utf-8?B?b2FlZnhuOEFhd1B0bkUwNERQa0lvU3RDcGJEMXljLzFaekxQbjhhdFBZSGJE?=
 =?utf-8?B?SWFiMGdwbTNvQjVUR0pManFBaHdYS3JweEMyY01ZRWF5N3RMSE1wR24rQWZx?=
 =?utf-8?B?UjhDY2xHaXBpOTMrRVhmd0V0dWYwSFc3eTVjMkl2bWxBQ09iZk9vR24yZTRw?=
 =?utf-8?B?WitDZkhHS3RvVFVaWDBtcXpSY3JxcWpyU3dUWmlQTlh2Nm9UV3QrUTdRY0Ew?=
 =?utf-8?B?Ym5oQXc1L1hQRDhsZGl4aGc4M21oVU5TMFlmRnZqZm5yMUJqL0FCdStKOWFv?=
 =?utf-8?B?MnlDNWFkWTNFSUR6OVIxdHRZRUI5cU5uZ254bzFlRW1taGIzS2UwbkpzQ0Q1?=
 =?utf-8?B?enNuWXhEODgrdnVRSVpwMVNuY1Izd0luem1LaXc5WkpPWEZnRStHL0lDS01M?=
 =?utf-8?B?SzZPYXQ2aFNER3Z0QW41UFJoMkMvaGsxS0lnOHNZc1U5dldWcUFtd1ltSzIx?=
 =?utf-8?B?Wnp6RFQrcldFbmdaVVpYLy9RMFVOYklqUmViUmdhNldhWGJwVUxiYk9HRlJZ?=
 =?utf-8?B?ZUFJZzZDa2RYWi9GeVRuQW9nelNBT21MNHJxcjVBNDV3OXZTZDA1akhIaUFj?=
 =?utf-8?B?dUlrbkNGL2svWnhjTzRLUUFUdG9qY1gwRE5Da1JPQzBnL3hXb0xOU3Blenp1?=
 =?utf-8?B?aUJhSkJST3dBUklxMmF4djZZNUExZzk2RCthSkMvOXIzZzA5bzkweDNseGxY?=
 =?utf-8?B?bSszamdvcys2dWRpL1VEcFRscExlczlmU3hwWUNLbG9jVml4QVhlL3FDYzEy?=
 =?utf-8?B?Z1JzSXp1UHRxbDdBblZoWWRtY25sSlRUYkJCNjBGNi9ZdHlwa3orY203Y2p0?=
 =?utf-8?B?OGkybFZoV0RvcmY1OHRYM0hBaWdHcTFuQzNKcjdhUnlKbnc1cFBONHd6M3Vj?=
 =?utf-8?B?WjdPSHZFU2R2MGY0dUROaitYQUszakdpWEdlV21DalloUTlkZ0d2WjU5VXJp?=
 =?utf-8?B?a2pRZTFVaE5pcWNORlNSTmUwY0lNOEViOGVjbW1DSEp0cmlSZTJ6dVM2ckZv?=
 =?utf-8?B?RmMyakw5Ukx3TTlXQllyNlBrYlJCL1lEb09rMi82OXJuTXVBeEdmZHpOMVZ3?=
 =?utf-8?Q?nOwZhZgE?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eVA0UDFMRmpqVVJaODVjQ3hNLy9GaFM1c0kzMXFsVjdQOG00eVpmWjZCaXQv?=
 =?utf-8?B?NTF5QXRwbURxazcrMmN0a2Rmd2JKampOeVFPdDdxOGZSYmpDMERrOWJyZDcr?=
 =?utf-8?B?V01nMU1hV0ZvdHlxRmp2MEZLcU5GZEptdFh3MTkvd01aTXh5T2VSaGlBOXZt?=
 =?utf-8?B?c3JwekVwVjdONndORGFsR1ZBMjhHZGlUZXNYZ3paZy93RWVUWHJSN1Z0Mkp3?=
 =?utf-8?B?NW93N0lxOWgrcXloaEw4VEFiVHBNWWdVNDRSL2p2OFMwZmpLUHVqWXdndjJx?=
 =?utf-8?B?Y1pUOXNkb2EzaUFrV3RxbXBtV2s2UVRDWGpSWTB0a001cEIrUFAvejVXaVdJ?=
 =?utf-8?B?MFA0ajhhZlhkYmR5OGZES3RBNUV6SnlyaHB1aHRpTzQvMTBBTlRlc0lWSEtt?=
 =?utf-8?B?UlZsdFArbEVWYzA0SHRySEN6c3JxWkxidTdydXI4Z29hNkhwVXN3bldDRkFk?=
 =?utf-8?B?NisxMXd4NWl1NFJxbXV0cTBRTHIzTEJjSHgvWGhmOG4wSTZjL1FvdUh0NUZU?=
 =?utf-8?B?VkxCeGNScysyVC94Y09VOXRORVZkbUR2R2IvL0tjbGFJVkx3VkhENnFLWnUx?=
 =?utf-8?B?VkNZclVUY01YeFluZEc3U0RId1YyMXpsRm9wa1VDUzZTc2FSdkhtN0lZUHVE?=
 =?utf-8?B?WnN1dkhlVHlsYkJjK1NZdXZMaWU4dWwvYXcvbk0zZlZsa0wxNzVGdU5PbjdF?=
 =?utf-8?B?dS81SUxOb2x1cTAyREQ1MVQ5dmc2TjVwanhnU2UxcDFYWHZEenorN3M1YUJz?=
 =?utf-8?B?UGVNeG1CbEdlL0Y4cHZueDFnOXdrU0YzWnYyaDA4bE8zR2tsZDdzYTB4Nmtq?=
 =?utf-8?B?b2pnUmNCeS84ZVBOMHNIZWpWYTVSalJaRFduVy9EZTkyQjA3MGhuemYzSlp3?=
 =?utf-8?B?YzBJRWF6akxTRFR2VlM2RDBZdmUxa2YwZnNxcXlJUVFJOU9XWTNWZmZ0c0Jv?=
 =?utf-8?B?WURrbHo5S010N3FFUFowamdVVk8zUVZwY1VRcWJUcWt3K2N3bktSZTVkQW8w?=
 =?utf-8?B?NEFVQVdpMFp4S3RNSzNna0h5Q1Z1TkdDU2VWTVVaLzJudFNZTHN0dllrSWxm?=
 =?utf-8?B?cHNuQStCQnpaZ3JORGxwdTVJMlF1S2c4NlhCR3YydnpsVmVrMWI4WWZvcGF5?=
 =?utf-8?B?ajhXakMxK29laEtlbXlVZWJuSE9Fb3cvT0J2NEZ1ZkMwK0d3MVpybDE0dFVM?=
 =?utf-8?B?bi9zQWFUWk9iMmZiaWlSTnpJbjE1QkozditvbXhNMDVSbUFFVE5XSUR6b0Zl?=
 =?utf-8?B?NDM5LzBTVFRGNUc0ZU5Scy9JeUFEYnkxcUdGOW5RaDM4c3dFaFpsRGZ5Mytx?=
 =?utf-8?B?RkdHbzM1VnRmNlNzU2dnYWxvenJseUZHV2QyTWRJT3BlZTFncDJxcWZ4NDF0?=
 =?utf-8?B?RlJyT3Rsbi82WUVvYXkxb2MxZkFrN3pSbmhaQXR1WVdOYWRYNWxSN2JQaFhh?=
 =?utf-8?B?ZmVSS05SMlMrQ29oekk4TU9nZUovSzQ3bnVXVU5oVDZlbFBhbDBPd0NJZURw?=
 =?utf-8?B?RmJZL3pLUlJVLzlOT1p3RHJZSGN3NWVMVmdMbTI3SzBFbVNBaHlSZk52eUVv?=
 =?utf-8?B?M3lYRW5JVHR1QnBxSHMyNnBETDdZVXpXZFdZdmhuRXZwWldZSnlpWDFEWDNh?=
 =?utf-8?B?cTViNGsweEg0dkRWa0RuaVVEa0FudSt5V1NLYktER2JWbVFDQStVRWhuejF6?=
 =?utf-8?B?TkV1RHgwSnozS053NWxrbGQzblN4YVd4dUFZazliSXRNMStPTE9rWWkxcHBR?=
 =?utf-8?Q?w+KgoUf1uUpIZvcT/U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-0f88b.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB4914.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: efe147f1-7db5-4b67-118f-08dcfa5f371a
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 10:23:23.2451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9273

T24gRnJpLCBOb3YgMSwgMjAyNCBhdCAxMjoxMOKAr0FNIEx5dWRlIFBhdWwgPGx5dWRlQHJlZGhh
dC5jb20+IHdyb3RlOgo+Cj4gU2luY2Ugd2UgYWRkZWQgYSBMb2NrOjpmcm9tX3JhdygpIGZ1bmN0
aW9uIHByZXZpb3VzbHksIGl0IG1ha2VzIHNlbnNlIHRvCj4gYWxzbyBpbnRyb2R1Y2UgYW4gaW50
ZXJmYWNlIGZvciBjcmVhdGluZyBhIEd1YXJkIGZyb20gYSByZWZlcmVuY2UgdG8gYSBMb2NrCj4g
Zm9yIGluc3RhbmNlcyB3aGVyZSB3ZSd2ZSBkZXJpdmVkIHRoZSBMb2NrIGZyb20gYSByYXcgcG9p
bnRlciBhbmQga25vdyB0aGF0Cj4gdGhlIGxvY2sgaXMgYWxyZWFkeSBhY3F1aXJlZCwgc29tZXRo
aW5nIHdlIGRvIGluIHRoZSBLTVMgQVBJLgo+Cj4gU2lnbmVkLW9mZi1ieTogTHl1ZGUgUGF1bCA8
bHl1ZGVAcmVkaGF0LmNvbT4KClJldmlld2VkLWJ5OiBGaWxpcGUgWGF2aWVyIDxmZWxpcGVfbGlm
ZUBsaXZlLmNvbT4K

