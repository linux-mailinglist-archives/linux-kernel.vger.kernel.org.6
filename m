Return-Path: <linux-kernel+bounces-254693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A62693366F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83AE0B22874
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 05:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF28101F7;
	Wed, 17 Jul 2024 05:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ksa5pywy"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7263F7494
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 05:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721194530; cv=fail; b=McQuBi+HQwaWonrNtQasLjRDDMn7iLxk7WjXYaFcV5+7HXG6nhWG9SADxNEBqz9RAGzhIc0jo4BAKaSu4vfo/yjcjHGSp+FOi49FkJbQ9/ORDrlHbMUKmYUp8Z0uV720ND7dBPiytIAcBBLWv5KbMbq+/AujscTzn4aCVuJY87E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721194530; c=relaxed/simple;
	bh=hw1svfBWVIPKfoKkbZiPYigaMUvSnlri8DQEgIhclxs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=p9Y96kw9JJFLtW/eEEzq1EzplfV3KV9f4qDNhm1f+0j+W2TlFB9Nr5FQzQWYCwsyT7457CA4DXZbo+UqIfu7Te+o/JreeBCaSpEPXsQmll+REdg7LDgr/DpHMS177F7Cya8eRNNK4Jvu+ClJk7+NWf2Je5DcvWalkJwXjliEdqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Ksa5pywy reason="signature verification failed"; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46H0WWEW031780;
	Tue, 16 Jul 2024 22:35:04 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 40e3g8rr6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 22:35:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZWcZVLlYbyOMFr+c2CagsrmJhTgVmq4f2EFRZR9t9tEmSWfqy2sWe3KDv07f/B5KktHTZ/pnkKCi6sAOWQXToJmfouOrGTT77kaZLn+OxdlTF25OeYWHYFSAUv7eS/2Y/+dtqu8wJkZCxVthPX6hnpLC+/GHbu+uSWzWZ1iQjqJmXPx7j60Q/FY+e9yEwNbi1CVLcAgbLIbYw5RPe469yupI50xM0WlO6tJnIlYAD8rslAjiHIKovb176AuoBb2BKO1p9tq0mIQLKmM/RxdI7F9/9X3ldDdrHUHxABMX6OJfeIwncVSClRECvnjDdccgVuz8mfwSZsrKjqC6JiC3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9WWfyzvEseilcHx8vJfH45/I0bCCBd0yazFfUi3GRE=;
 b=zDfq2Y+ZQL2Piyng8Yx2FFI3gjwAzmaLrx/qn3u0B7pN3LOsTNX9pJ6oDdNFWi5D2NWHDsjZqiUvDiidYMVmpEE6YTFerOrr3bViRL+B1zMX7Db8N1ayW9lIFUohfKj/xWF9tH2Y6O1RV5xqLZ1SEIoNgGQYgu66p01wo8jzHAp9qrFQ88wUSUcFGitPU3lZlK135PRVCdzWnkdq6VK/JFfWUlDKg+Eb36+eH3NFkLUOuWKn4Fav5d6jnNAb5HWGusHMBFrIaxEb+ewM/Q3HvBIfA3s/O51C0GunaSa6bZ9tH6iVwmwXlfd1d+QJG0CwkbCchc5P5E5B5dIHjrIuKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9WWfyzvEseilcHx8vJfH45/I0bCCBd0yazFfUi3GRE=;
 b=Ksa5pywymxNKyJqs20/oX8pUjuUk5e3/0nwCEcZTWmZisfdzImDChQbkKiDAmQqOCK7ykwg+EaFn7wbBxZ+Yd66d0S2mbZBqYUPk+CGynfUnTNq6c+/m5gRMnNxiBFpsfEAdiPFOnpxhCpQ1oqMbtvPyZd808i/QvQJdpzVx2gY=
Received: from MW4PR18MB5244.namprd18.prod.outlook.com (2603:10b6:303:1e0::16)
 by BY3PR18MB4529.namprd18.prod.outlook.com (2603:10b6:a03:3b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Wed, 17 Jul
 2024 05:35:01 +0000
Received: from MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::52f3:9792:ee42:90b]) by MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::52f3:9792:ee42:90b%3]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 05:35:00 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>
Subject: RE: [EXTERNAL] Re: [PATCH] misc: mrvl-cn10k-dpi: resolve compilation
 issues on 32-bit ARM
Thread-Topic: [EXTERNAL] Re: [PATCH] misc: mrvl-cn10k-dpi: resolve compilation
 issues on 32-bit ARM
Thread-Index: AQHa2AUlZI50MZOoe0yWhZWePjzeErH6YQQAgAACIRA=
Date: Wed, 17 Jul 2024 05:35:00 +0000
Message-ID: 
 <MW4PR18MB5244DBBC231E986EDBEDD5BEA6A32@MW4PR18MB5244.namprd18.prod.outlook.com>
References: <20240717045225.138799-1-vattunuru@marvell.com>
 <2024071709-nephew-scooter-5c6b@gregkh>
In-Reply-To: <2024071709-nephew-scooter-5c6b@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR18MB5244:EE_|BY3PR18MB4529:EE_
x-ms-office365-filtering-correlation-id: 86ed2b32-1023-439a-17cf-08dca62233c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?a0hxMlR0YWxYSzk1OTFJM3llcjJxZ3pWVTVqVTRabWJ5d1psQ2QvUnJINi85?=
 =?utf-8?B?SjB4UHcxMjJyQ3dlSFBXZElUWHErUmt6RUwzUWlwb1Y1Tm1qRkxTbTBtQjRi?=
 =?utf-8?B?amMxRzJBQnEwc1Z0bGtuYVprZldrczdxR2dnZ2tsemlHd2lzbkZWUFNaMWZ3?=
 =?utf-8?B?RjFHc3lPQXJScU05NkNOMlYxVDhGTDhTUWhWZHkzWEFkMzZJenNQazRPcCtF?=
 =?utf-8?B?YWlHbHlSZE1PT1pJVUFZb3A0TzRRY1l3RE5lNWd6dDdTVm1TMnlLcHVuWTh1?=
 =?utf-8?B?RkpMMUxIcDhCZVYveGFPWE9FQWxlYVVaSzNXWmF0WE5UaXNhd2lPYVZmK3Y0?=
 =?utf-8?B?K3E1WTJHZGRaRCtXbmZvU1JqUnk1Vm1rbWRzVGlvd21RVWFMYWd1YnpNdXNv?=
 =?utf-8?B?ZGV1WW8wR2owU0RnV3FkSW0yUDZ2RUtyekZBb3hiaGZ0bzl1ZXJuRXlQdWlT?=
 =?utf-8?B?N2J6SFdPQllUVjM4MHhRUmVhanRTdVNJRTJMd0NCdk0vWk5FNjYveEN2WENJ?=
 =?utf-8?B?cU5VeFFaejdOOVNDOXZwMGZXZjFxc0VmOGlOSklLVEREOFMzejBBTStYcTZE?=
 =?utf-8?B?cmk4UUYyNDh0Q0NsVHZzbjBzQXBxUFBlTk00U3hCbFhhaS9BcWJhZHh5UXVE?=
 =?utf-8?B?N2NUR3JUVVhMTW5ZQWtPTDVXdERqaEc5eG04Y0Y2cVgxNE5neEMzRW41STNx?=
 =?utf-8?B?RjJuWmYxS2hjb2xxODRMUXFTTUhwZm9XN2J2QWhrQlJRRVByb1ZzUzJtTk9Z?=
 =?utf-8?B?YXFqUFRDdmlrZ3RNYTVtNjRHcjBJRFlON0dCVHNFWkEzcTdMSkpLOEVZTSt1?=
 =?utf-8?B?S0JHejBBbjhvQk5pMFJLY2ZiTWFVRGJ2WXZXRTNRbXU3SjJzSVlRR1R2QXB3?=
 =?utf-8?B?b25Pcnk5N3ZtSXE3MnRnalByRHFlRmNuZUlnWHdPbTVtaS9LM3dQYkJ2T3FU?=
 =?utf-8?B?UFpwREVpWFNnKzJ3aCtHcHkwcWNXT1hoanVwVmsya1JlM1ZJeGFOdVRkRUNz?=
 =?utf-8?B?VEhTSE1xa0tuWDdhY0NvWGd3bVpmOUxMOGN1bTJWNWxTcFJ1NEw5MU0wU2pB?=
 =?utf-8?B?aUozZ1pMaTkvbDlsaUMvazRvUmRpdW9kU0VlWnNucTFBRWJiblpqWnVLQWd4?=
 =?utf-8?B?Q0V3emlJdUE2TERBNXJXcENsQVcwN1lIVitlTFlja3FZMkJHKzkwSHl3Q3pN?=
 =?utf-8?B?WTBIMmNKK3lYNHowakFIK1phVFZRUzdMMlN0VW1iZ0I5WlVnNk5tbkxuMkpy?=
 =?utf-8?B?ZCt6NWs4aWYrTng1anRkY0dnbytMQlArdXJrTzJKWUZDVjJhMWRIdEVZd2ZJ?=
 =?utf-8?B?K1pmN2w5Q2JRZVRxTURyOGQ4Y0NodFFWeW0yeWZnY0tVbGQvbWZtcjhhaTlx?=
 =?utf-8?B?a1lVUWl1UVdZREZIbDJlTzJ2TVUwaE93ZWEvcVNWUGtLSVk4TVY5cVhCa3ky?=
 =?utf-8?B?bit2N2tLdG1BZUw0T1ZEUzVOcjFJeTBUVG1rdnBUSys1SThBaHBvNkQwdmNz?=
 =?utf-8?B?NmFGZ2w1VlJBNmd5M29pcWJ0K0NXVVJJalI2a3dtd25YeDZ4UlA0QnlVbHRl?=
 =?utf-8?B?aW1JU1Rycm5yaGFzeWt6VGJNRjBKdHlpTk0wWFR1QnlWeXd0U3JPYWVzQis1?=
 =?utf-8?B?cURFTTNTMkNNNE5ycVRGbzZmdndkNWlpQjdnckxjTzFlN3doNUNQTzlYM3U1?=
 =?utf-8?B?QThFamNDb3FRVjIybkJrRklCVG5MMTJCYWlkQU5WZEFEMVQxdVJQZUJzQ3hB?=
 =?utf-8?B?ZEt0ZnFQc2NaRmMzN2dIdlpxNEJ3WGFkZi9Va0FiZWxPaGVldHNrZnhXNCtI?=
 =?utf-8?B?VjJvcU9udUxnOHU1T3cxVFhyczRsYVQ4VEtKdVpZdmlNdVZvWnZDcWtuMWVP?=
 =?utf-8?B?YzJOZnN5ZmgyQ1p2TUJTMWs2c1lQRTVYYlM3elNlQ1cwUHc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5244.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MGIxMEFUMTZVYk1UNTd6OGgwZVlURXVVdm00QTQzTUJaN0JQM2p2ajZqTHVF?=
 =?utf-8?B?bkFyUnhCYXovUzlvRjlMR3Z5dE9IWmk2SHg0eUhaK3FINXJ5N0xjVUoxaVEy?=
 =?utf-8?B?dFJPQ0NCeFpvS2hWRUhGNjFia3RTUmVSZzAra25rdGh1TmFWRkt3cThDdCtP?=
 =?utf-8?B?RVBBeGJpb2JsUjlIRllyVzhraWFYWHhCbGZ0UnRFd2wyeEcyM0MrSVFtNXhU?=
 =?utf-8?B?Q0hEaE5sdVRYS3oxd1c0eGVOVmt3UXBXL2JLdXd5bmFPWFZ2MTAyc25LbTV3?=
 =?utf-8?B?Q25DNkdZc0pLaFk5bVFaTllzRVNKMU9FYm1tK1RncGZhNHJDVCsvL0tOcU5G?=
 =?utf-8?B?OGloZkdNVVlnMk5admFQV054R3EyZUFwT00yYWJ6aHRRR2RoQXRxMkdPV0hM?=
 =?utf-8?B?Ti9VU25mOW5yeWdRMXdpUWFVSTVkTW9Ka3FNTmVNbXFRdVhRZmFrbDRaWjZj?=
 =?utf-8?B?RzNTZ2g1OG1LSDRjalpma2tIeGFLMEsxNTZ0d1MxSDhhUWpGenlremhGWjVQ?=
 =?utf-8?B?T0hmeEZ1Wk4vNXBkc0tlRnFCVGtET2F1aEpzYlZLTitnK2o1ZE9CTjhVQU5m?=
 =?utf-8?B?YU9uckx2S3VZYVNuemxnSCtWdWltZTZlSVdTQVdDMFo0MklYOGdMN1lVbGxM?=
 =?utf-8?B?T05XSjFlM3oxbjJHTGhqTlBxSnRIOU82M0NZaklzTExzSmtWUzdTTW5lTHp1?=
 =?utf-8?B?ZW9jdEE1MDN4YXpKUUdVc1FkS2x5QjV1bWd3MTVadjYrYTZaZVYxdnQySWtI?=
 =?utf-8?B?ZGlVMXBKRnFLWXI4WlhxL2diV0VxVml3Q0M3T1dHSk1rL0NKL3NzMkMwZGpy?=
 =?utf-8?B?eWVQajVHOG5HTWI5bmxqbUl2S2lLdGxuUitUQmJsKy92amhBRWNUdC9DTkln?=
 =?utf-8?B?UTZmcWloQTRLNnRUczdHZDRlUEo3c3hudndxaWk4ZGdnNDhBMmVLY3RRUStI?=
 =?utf-8?B?RkJuOXhtb1VkK2JHRUdXRlVESVhEbnl6TFRQalJrNk9zWHlrMDc4WS93aTdh?=
 =?utf-8?B?ekc1dDhEZzJzUkUweDFNZk4xd3BSc005aXJJSURjQlRJK0pOMDRKbm0vRitI?=
 =?utf-8?B?dFpSZjVWY0w0VVIrT1NqVjBEMDIyenFSaHQyTERNTnhpZExLS1dPMUllWkxx?=
 =?utf-8?B?YlVVUUJqM0JGcWhFbS9UaFNkamdKTEtFOWhCUmVBT2QrOTBzWnFjMnF5MkEz?=
 =?utf-8?B?SmVlc3NZWlJIR1p6VDluMUY0RDgvTnArbW0zbHpjNWNJalRMTTh2cis4cXBH?=
 =?utf-8?B?ZGdhWTNoRUJ2emkxQ3UyRlpIUE9YeE9FL2RhMWlPYS9YZWNlSjBuUnVwSFNY?=
 =?utf-8?B?MzBFeXBOcW5VMTlJSTZLM0lUb3RVU0E5dTBGMi9sRjRBc0NoY0xiVFZSK0xL?=
 =?utf-8?B?dnVrZ3BBMXl3d2M5MTJNRXovRURsdTdtdHB1Q1QxSys2ZEVaRU9CYzhyODdE?=
 =?utf-8?B?S2tURVdEYTBIb0llTG1sb1hEeXpOK2lxOGFaWEZXRUxZWkVvc0hBOHdBQ01l?=
 =?utf-8?B?SWV1YXVHVyt6eEQ5VTRyYzZIdHFxRTBiS1p1MTNiaFZyQ3RTTmVObE5GcTha?=
 =?utf-8?B?ZXZWQURTYjR4TXlwODErNXFaNEJBdWxpKzdoMjJtTEpDbTdpanI2b2s0ZERu?=
 =?utf-8?B?dDNHUnlaSFpqYzZTZmFJbWNQbEV6VUFoaFJFbDdkRzlobW94d2xnSUNrZVRQ?=
 =?utf-8?B?TUJpZjlGT0MwT3M2VmQwT2YwS09HU2VaM0N6SFUwT3k0eVY2bmkwdzYxL1U1?=
 =?utf-8?B?ZWJiRlN5V1AvSjlwNzdobjhiUUlvblRXTmhTM3dZc3E4Ry85UVJHME9iL0Fv?=
 =?utf-8?B?TStzc0lhTDVwR053N2ljQUdrQWwvTXZnNXFIbnhETHNRYnBuR095VFIyczFi?=
 =?utf-8?B?bEh5d1RzNk5OV1Q2c0tWUjF2dGxvSUI4K0JzWS94dTZVelB4bGdQd05tY2Rj?=
 =?utf-8?B?ZlFtWkplN0NXR3VjS0d0NXlqM0Zqcy9kYXByMlVNUEZTV3hZZjVRK2xCb1d2?=
 =?utf-8?B?VnlLL1BBSmppZmNEb2RvemlUZkQvWEl0SFR0QnNsNUhSZGhrSFFqZExTd2t2?=
 =?utf-8?B?Y2FUQTZXZThDMUNycjBVVDVscVBoVlB3Qy9VWGxnR3RVTnRkSk9UaXBqaGpw?=
 =?utf-8?Q?5udbthxOP2zptWdibA+d1bFhC?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5244.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ed2b32-1023-439a-17cf-08dca62233c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 05:35:00.7119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aHYSdhT1+heg4XIXSnp5z/vEr2+jjk/bX5EigVY4Vm5Eh6gU4l5lY+ncjj6crqJU2+jfunyHgL07+mOCyNtELg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR18MB4529
X-Proofpoint-ORIG-GUID: YpM_EMvovOgOViFFiR7EWLaK3GYuREQV
X-Proofpoint-GUID: YpM_EMvovOgOViFFiR7EWLaK3GYuREQV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_02,2024-07-16_02,2024-05-17_01



>-----Original Message-----
>From: Greg KH <gregkh@linuxfoundation.org>
>Sent: Wednesday, July 17, 2024 10:47 AM
>To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
>Cc: arnd@arndb.de; linux-kernel@vger.kernel.org; nathan@kernel.org;
>quic_jjohnson@quicinc.com
>Subject: [EXTERNAL] Re: [PATCH] misc: mrvl-cn10k-dpi: resolve compilation
>issues on 32-bit ARM
>
>On Tue, Jul 16, 2024 at 09:=E2=80=8A52:=E2=80=8A25PM -0700, Vamsi Attunuru=
 wrote: > Upon
>adding CONFIG_ARCH_THUNDER & CONFIG_COMPILE_TEST dependency, >
>compilation errors arise on 32-bit ARM with writeq() & readq() calls > whi=
ch
>are used for=20
>On Tue, Jul 16, 2024 at 09:52:25PM -0700, Vamsi Attunuru wrote:
>> Upon adding CONFIG_ARCH_THUNDER & CONFIG_COMPILE_TEST
>dependency,
>> compilation errors arise on 32-bit ARM with writeq() & readq() calls
>> which are used for accessing 64-bit values.
>>
>> Patch utilizes CONFIG_64BIT checks to define appropriate calls for
>> accessing 64-bit values.
>>
>> Fixes: a5e43e2d202d ("misc: Kconfig: add a new dependency for
>> MARVELL_CN10K_DPI")
>> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
>> ---
>>  drivers/misc/mrvl_cn10k_dpi.c | 47
>> ++++++++++++++++++++++++++++++++---
>>  1 file changed, 43 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/misc/mrvl_cn10k_dpi.c
>> b/drivers/misc/mrvl_cn10k_dpi.c index 7d5433121ff6..8d24dd6b421b
>> 100644
>> --- a/drivers/misc/mrvl_cn10k_dpi.c
>> +++ b/drivers/misc/mrvl_cn10k_dpi.c
>> @@ -13,6 +13,9 @@
>>  #include <linux/pci.h>
>>  #include <linux/irq.h>
>>  #include <linux/interrupt.h>
>> +#ifndef CONFIG_64BIT
>> +#include <linux/io-64-nonatomic-lo-hi.h> #endif
>
>Are you sure the #ifndef is needed for this include file?

Check may not be needed, will discard the check.
>
>>
>>  #include <uapi/misc/mrvl_cn10k_dpi.h>
>>
>> @@ -185,6 +188,8 @@ struct dpi_mbox_message {
>>  	uint64_t word_h;
>>  };
>>
>> +#ifdef CONFIG_64BIT
>> +
>>  static inline void dpi_reg_write(struct dpipf *dpi, u64 offset, u64
>> val)  {
>>  	writeq(val, dpi->reg_base + offset); @@ -195,6 +200,40 @@ static
>> inline u64 dpi_reg_read(struct dpipf *dpi, u64 offset)
>>  	return readq(dpi->reg_base + offset);  }
>>
>> +static inline void dpi_writeq(u64 val, void __iomem *addr) {
>> +	writeq(val, addr);
>> +}
>> +
>> +static inline u64 dpi_readq(const void __iomem *addr) {
>> +	return readq(addr);
>> +}
>> +
>> +#else
>
>Normally we do not like #ifdef in .c files, are you sure this is the corre=
ct way to
>handle this?

Ok, came across the similar usage in some other drivers and presumed it's f=
ine with small routines. I will move the #ifdef inside the routines than.

Thank you, Greg, for the prompt feedback.
>
>thanks,
>
>greg k-h

