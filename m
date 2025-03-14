Return-Path: <linux-kernel+bounces-561242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8D8A60F22
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C43731650DC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731781F130E;
	Fri, 14 Mar 2025 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="RnDQZTKW"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2088.outbound.protection.outlook.com [40.107.255.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E111DC9B3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741948692; cv=fail; b=NY7+qt3wxvx9NHQog3gTxMf0Yj2wfwZWCJQMwvhthW7KyUeff26AIQpJy1B6Fg+sHgdDES6xexnHAf69XBO2ZOv2DP2/YM7Eez8sxzSNZ1QeKiXWSNQOPl/+q0VwDsA4I4+Ujh4NmcRDItq33Udhnsz7RTI/9/MLkx+tFNA9Wn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741948692; c=relaxed/simple;
	bh=mPVMvJIj8I73cgx1+OQ103/azTKbMLiiR+lLoeKBMIw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f9Kplm0egaJvpUFeQtBynV4UDTHJR3V1U22LAheVSfDswCGKnVXjiBDRXeV7T9mmcofzNtS9RdZ7/KnRysMFu071hC2VGpJ5jzLVlJjcW3N+8WMpZ9IdFFA0k4OkuqccVLqUq2X9PaTeB6RP5EtStbPN/iCfwraNomLOdclZ6Jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=RnDQZTKW; arc=fail smtp.client-ip=40.107.255.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tigt7BiNMdC1DlUu0pX3KoaX1uIjce+2X3VjIpVmyMXvFpnOl3g85+adL2gHr6yYjvKYm+ykIGlSTuTwNLJqqM6J3xrS/IwWR12TivsX0mnLbeAfG6TO5hbIyrUayLbdV5omiyynGULnGt4UZ0g5oEYXalhJvr9yM/kfsW1lVrlGE6Zy4C6J45pxxT9N63f40B7ndoseUpU4Hx+jAkYynJEgmSPJ7tL6tU7iJj1Y4gQMfUOZrnwvsNhSujf/mZlZWtMj9aKiZQZ62buXrxBM428pkoYkeBwQGkM3gV8lB7u6mJJdK56ez9tV6YYgjJGMstEMavT2M7FuCmlmAY8aew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPVMvJIj8I73cgx1+OQ103/azTKbMLiiR+lLoeKBMIw=;
 b=VMYR8UL9USk2fjZ6HN3LGfKYV8zSCl0x8e+OeEZvsQ+giUbqmYu/HpuOFoManFRE3WMKQgfpCWHbHKvVBzBSL3OaBMxzssxg5yjbFFiQ614XHI/eoOu8BnSKHmTS7HBdqj1CD6SaMTydTBoZQMOUufwaXIVcb334I7N+mrQr5KYdU2PCaJYfVDulJGbPczjy8bE5FbRwwR7GywIMYI5b7PNe03h5jlZ8AG6aYUgKDVfq7WVI86U07t74b2MDcQ48keAsgYloa8LZ1X5mFtjReiz/durBZWCfu1S5wPsH74KI/CvW6X8qhKi3oQ91RFc1o3BbKKlww/P4pa4nwqCGMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPVMvJIj8I73cgx1+OQ103/azTKbMLiiR+lLoeKBMIw=;
 b=RnDQZTKWe/HxB/qvKQTQ8obEkDWv90HdnHAirEdb1S3fS/AwWWZ19wRA4f126tDEQODddYXj7SlVNvH0dYT6Pfzi54wx8+QPwUO0d6uxHCd+swj4TRaE+hvR3jhkVQrQlGpMU3hFELFlr4ThhMphp0duUTHheeJhr0wQpGOxmoLS4+PKQ5aUiuNmbWjNDRfu/KPJ2SYYmqfhAh9FjpW+ruwESIcPF9v6AaxeCjHT3TVAwF1dlJ2/xScnaZOLOAQgM+gFieHUhK8AgIEvxFgCwNIGEU6QAxJxcta0a/3BRe71SHSISCzcf3gDk8uZzq/3jI0XONlmuMN/UUoL0/Wtow==
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by KL1PR0601MB5488.apcprd06.prod.outlook.com (2603:1096:820:9d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Fri, 14 Mar
 2025 10:38:03 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b%5]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 10:38:03 +0000
From: Chunhai Guo <guochunhai@vivo.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chunhai Guo <guochunhai@vivo.com>
CC: "chao@kernel.org" <chao@kernel.org>,
	"linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] f2fs: fix missing discard candidates in fstrim
Thread-Topic: [PATCH v3] f2fs: fix missing discard candidates in fstrim
Thread-Index: AQHbkzXTVgozripjeUWgKe9uCQaXHrNvj14AgALkiAA=
Date: Fri, 14 Mar 2025 10:38:02 +0000
Message-ID: <3df184dd-8a8e-43e7-9b1c-6cfafc95aabe@vivo.com>
References: <20250312102005.2893698-1-guochunhai@vivo.com>
 <Z9GZ1kg6VVMFpomb@google.com>
In-Reply-To: <Z9GZ1kg6VVMFpomb@google.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB7096:EE_|KL1PR0601MB5488:EE_
x-ms-office365-filtering-correlation-id: 3f53b61e-c409-4f23-0066-08dd62e44c44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|13003099007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Ym0rcTRlZkdwRDRsOHFWMlNtYlc4YVB2cURwVWJpQS9zVzJkKzE2TVZCNCsw?=
 =?utf-8?B?VXdlSmxqdE9iMEJUQmVybnVIWVVVeitCcGtDRDdEWloyMDRnaithbGJrNGt1?=
 =?utf-8?B?ekZQU0JwRGRVOG5oY0Q5b2JxcWp0OHBMeUk3Y2RCZ3hjRVVzZjlISlhpYmJF?=
 =?utf-8?B?T0FMTzhSclM3MkVHSEt5dFdaR3hLRzFUUUFGLzU1QWZmZERiY3hrY3JjcnVn?=
 =?utf-8?B?aTd1a2Q5L1VheFVQM2Y3SzF2dWV1eXpjMytMQ0xhYzZjS1dwUzZONnEwUWFY?=
 =?utf-8?B?emlCU0U3K1JXTHZBdllLQzErdExYUzF3alRRcExYK21ueUJzWHdCei9aRUsr?=
 =?utf-8?B?bkhZT1pOeHVXOE5NWGF3Vit6UitacFhhRXlKakFZSk9uMDVEV2d2OENVWFpD?=
 =?utf-8?B?aDZIem5mdEJ0NXp4V0lYemxTVGJpY3Rta2xXT1crMXV0OW8ybnZQVldUaUxn?=
 =?utf-8?B?UlVSTUJBZW5XcjNRaDFld2dURWw0d2t5bU9HeXB3Wk5ISzBJelhvWHl0Z0xz?=
 =?utf-8?B?OWNlSm1LUUIrKzdTclJMV2NqUk5QNjVMeHRTYnkrM2duMWd5eGlpb1Nkc2E0?=
 =?utf-8?B?dnoxK2JpSklhSVdJVUdjdXFTMDRGY2dId3BTOTNReDlGVDhlc25naVJEeWlt?=
 =?utf-8?B?dklESkViU1U4ZVRoRlduL2ZpR3o0L2VDN3BTaU5VVm80QWJPNGFaUk5pbzV4?=
 =?utf-8?B?Z2cxWDYxM0JNd2ZmM29jdHJVbFRhcmxBR2JJcU5PUWQ5bXh2WU16UXpsaDly?=
 =?utf-8?B?aXJDbTdUUG9DeSt2eVBFR29yMlNCbG5KSWtYOWUrWS81U0dNd2IrVVVxYjhq?=
 =?utf-8?B?OWRIZGR1YW1mL0cxMzBKRTBDYWJhS3RMYWZuUXhqeTlIMnZja0c1QzU5ek5h?=
 =?utf-8?B?TTZaNHZvZnVyeWlzOGVYU0lWUGpjTW1YNmdaYUFhOCtqU3R5Zm1GWlpqOGFR?=
 =?utf-8?B?ckFrUkg5Ri8xdVl5bjBJNTNUSmdhVFdVNTllL2hCQXRDUzdWOGxISElGTHlu?=
 =?utf-8?B?Y1k3cWFabzQySDlnS2h4MkI1WnlqSzU1b1BPTGorVnZPdHM5OWdNNnBqVkdP?=
 =?utf-8?B?M3BwZjZUMkJ6V1lSYm9mMDF2MU83V3o5VWl2V0hkN3hTa2M4Q0pTR2lrM1ND?=
 =?utf-8?B?SVVRRmcvVldlSGQvaUlPT1UvelozN1V5cHlDbW5DeUNzZEJKRU9sRVI2UFEx?=
 =?utf-8?B?cFV5NGtaYmk4NGZiYVRtdU5WQnhkQkZrOGhJV2NwOVZRcHJCQTdiUWhjekh4?=
 =?utf-8?B?ZnpBRWlPejhQemRBVWNhUmRtd1RVQWJsY0l5SFNyMzBUdklUbXdJRU9ZUzd6?=
 =?utf-8?B?YStNUlZYdEVvbjlQMXM4TExnZ2I4eWdQcXZGNUhuVngvU1hnSEFodGpEdFlL?=
 =?utf-8?B?RXF0MEZMczV0bXZ1REpMbC9ML1l1MXRSNlpZUk5tMjdobCtwNkYxOUc2VmE5?=
 =?utf-8?B?RUZGQmF2aU9BazNOdy9jMGNrYm1NOHFML2dtVlJHY3lKbzc2TVFZWWhla3lY?=
 =?utf-8?B?Y3o2S3d4Z092clR0NURRc3M5QlpFVGkvYUY0RVFvUlFGaUUxZldWSElHVXdt?=
 =?utf-8?B?ODR1YU9qZElXRUFCcmFUekJtVThCN2ZVbWY5V01NNE8wS3FGbm50WlN3U0dj?=
 =?utf-8?B?SndkVEVacWdBTXdHQVczSTN5WktuSC8yQlRudytpY2pSbGtiY1M0cGtRV1Uz?=
 =?utf-8?B?VFpmSk9HY1JYMmNVVFo4WFRKUmpPZnRuT2UzRHFkbkovVXI0R2RkV0krNnkv?=
 =?utf-8?B?NmQrdHM0WTEwdnE3VGtFMmFjMG5hU0lTZm91T290MXIzem03WVlMVyszL2Ew?=
 =?utf-8?B?OUZ1Nkc2ZHdZK29RT1ZmTU1URUdUV09Mc21mZW9EYXY0eWRseVEvMXQ2MFRX?=
 =?utf-8?B?K2VuZmMzbjhYdms5RXlhZTJ0T3ZDbUwvZitYY0ZaQ2Vnd0FMajJrUng5VDc2?=
 =?utf-8?Q?+MsH1kQ65UHfd/osDP+0gKyjK8/mcBtL?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MHR6UTBNZ05YVGx0eC9wYWM1TWpmejNPbkxQQ3NiVlpYNzJUTFFJT294Z3BL?=
 =?utf-8?B?ajFIVG5CU2Y2SktIa0pYQTVqSFgvNytTbG1obnhhVHFqWUlBMWV0YlJnOUNT?=
 =?utf-8?B?Tzd5eVFlT2xlbGdleXVQRHZWOFg1NUVxZW45YzArZjlaOWxzSW9xamkzWm1y?=
 =?utf-8?B?dHJSb1h0ZW54WVgyL2JndGl2SlplTUFZcjV2VFEremtPUjBIbEVIVWNaK200?=
 =?utf-8?B?eG5QNjBUM0VqUVN2NnY3UVY1SWJINjlVUlNTaXJyeTZZSVluMDNLQ3lFSFEy?=
 =?utf-8?B?NTZiRVpjdFpnUFZ5U3B5Tm1LRlhMVmpyM01LTW1CRUkxNW03Q1dLbFhDL1o3?=
 =?utf-8?B?bEJCR1Q0d1pZUUM0bmRSa0l6NmZ4ZmY4QnlxOWdlaGxTNVB5RG9rekV0ZG1P?=
 =?utf-8?B?bEthL2R0MXFSOFVYSDNmRDhmQjZqeERwZkNzeFpMSGpLOG96QWNZK2VxRjdn?=
 =?utf-8?B?Y016dkZZOHJMTUl3WlVIU3VpeGJyaG9TWUQveHBXNEsxQ1hzVG1XMjhjcDc5?=
 =?utf-8?B?RFNrV0R3VEtFQnliVWpnbW9WdzBuWUZleU96VEw1TmQvdGNBMW40cXRuQURr?=
 =?utf-8?B?T0YzWEkvVjRiY3hPRWJFTS92Wjl3MVJCaUswTG8zaTE0eEZ2R2pBOEhLR0Rv?=
 =?utf-8?B?MWIxRzB1ZXU0a3o4Q1dHa0NOMGRZYTRieW1idytiRHd6OThBMDQyb2lYUUl4?=
 =?utf-8?B?TUw1ZUhOOTQ1K1RXenJhc25GcERxY0xSSm0vYmRGeGN5aVF4WGhkTzdCak91?=
 =?utf-8?B?Q2d0akM5RHYrUWFwZmIvOFhrdHlTSXY3allWSHFRZTd2MmtNYy9vZ211ajgr?=
 =?utf-8?B?cisxRy80Qm9LZ3JyUHpmektLWFRVYzBhbmxaaGFMQlhUU3BBV1ZWNzZYUXl1?=
 =?utf-8?B?cEUvRnh3eExxMzJjclNyQS9xaHV1ZFYrTUVudSsvbWIvLy85eW5mR0IvR3VB?=
 =?utf-8?B?QVVvZDFGeXJkMW9uby9MdlFiMVhVZWgrWWUvRVFBK3F2cFgxU1NYNklLTG94?=
 =?utf-8?B?M0lLUjFOTEdMSmNIc2FLZWIxS1RpWDU2VmNXaWhLOHZGckEwNEp2TUt5MmlT?=
 =?utf-8?B?dUh1NUNJNStkaUdpMUxxVFgzY2JwSlpGTjNESWxXTUdzS3YxVWhFQUQxWVZq?=
 =?utf-8?B?VHF3OENxblVLVVJWQUN6dG9TcUh6REFESjVTWU8yZU9EUjM0RUI4blhVOEFN?=
 =?utf-8?B?YmJTM3pZU2J3V1IwTlU1eXg4TCtvN3ludWYyZlZLNW9zc2tjTVN4NXorSThu?=
 =?utf-8?B?bkNKV0dxSDZzOUJZQ2hJa1hYSXNINFc2eTRFTTZvamtmZW1tZkZMNHNvOGRV?=
 =?utf-8?B?MkFmVmVra3p3UWdYV2NBOTU2aGY3RHNoQU1WVlBLWUo2ZXFDNkdHRkdrOFNP?=
 =?utf-8?B?YXdNdUhCdjJIOW9OeXRRZyttSlRWa05qN2xXK2RQeGFtdkNpQ3hNRkpsQVZt?=
 =?utf-8?B?ZHhVclk4M1hGbUsyZW1WWUdZMUxSOG41RFYwOVBKbndaNFBBanRGejFteE01?=
 =?utf-8?B?V0V3b2VEWFN5clZRdHNvVW9Ta1E2OTZyZjdMdHJvMGNBTlFQdy83SjNyTGdX?=
 =?utf-8?B?bVdScVdxNUlydjF2YjVDSEJhcHduNGpzdnFmQkF6WTVUQ1dTZWRlZkliWWZl?=
 =?utf-8?B?N0sxZ0t5TXUwV0x0NjZvWlpqMklCcTJZMnhsZXFhL3lqMWNtVkZSdjluUENk?=
 =?utf-8?B?ZTlhbW9vOVM5blo3QXE5QU4wRnZFQ3AybTc5VVVaVDZ2MXl6TXY3Q0c1Q0ht?=
 =?utf-8?B?Zk0vMXo4VTVsVjkxOCtCcHlDM3dxS0U1SlJkam43MEhBVnNyelgxN2MydG5P?=
 =?utf-8?B?c3FtSGtqNEVhaHMwUHdkRXRpdDh6ZzU2TzNwZXpvZkpGaFJzQnIvNWY1c0Yw?=
 =?utf-8?B?TFN5ZDFQR2thejVJTTdzOTVpR081bUoyaU9IcEJWN1JZampLekN3dzRoS1dK?=
 =?utf-8?B?TDZ4YWtPaWRRRlYvTmRFQ2RTaHdlZ0VDUnV6OS9EbHhxempzK3pPMENUN2oy?=
 =?utf-8?B?QjViMUtDTkMyaEhDSzNjd25VZEJZT0ZXM1dqaDJod1FHb0ZEaVVBNldKQUor?=
 =?utf-8?B?cEZJbEZUYURHWXVqTCsyalFvVEhyK2YvS3pydEVNcjk4dktEdkFqUG9aS3h4?=
 =?utf-8?Q?NCW4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AAA3EF688258DF4196A305539749EDE5@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f53b61e-c409-4f23-0066-08dd62e44c44
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 10:38:02.7468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 58Rc8wiktG65BQaC7rLAkz9Cuu8OwT87OOAmEJg4GLKDehU8XB9onZ8ezNKtZZfFwIyFOFbqIlnI4CwuyjjV7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5488

5ZyoIDMvMTIvMjAyNSAxMDoyNyBQTSwgSmFlZ2V1ayBLaW0g5YaZ6YGTOg0KPiBPbiAwMy8xMiwg
Q2h1bmhhaSBHdW8gd3JvdGU6DQo+PiBmc3RyaW0gbWF5IG1pc3MgY2FuZGlkYXRlcyB0aGF0IG5l
ZWQgdG8gYmUgZGlzY2FyZGVkLCBhcyBzaG93biBpbiB0aGUNCj4+IGV4YW1wbGVzIGJlbG93Lg0K
Pj4NCj4+IFRoZSByb290IGNhdXNlIGlzIHRoYXQgd2hlbiBjcGMtPnJlYXNvbiBpcyBzZXQgd2l0
aCBDUF9ESVNDQVJELA0KPj4gYWRkX2Rpc2NhcmRfYWRkcnMoKSBleHBlY3RzIHRoYXQgY2twdF92
YWxpZF9tYXAgYW5kIGN1cl92YWxpZF9tYXAgaGF2ZQ0KPj4gYmVlbiBzeW5jZWQgYnkgc2VnX2lu
Zm9fdG9fcmF3X3NpdCgpIFsxXSwgYW5kIGl0IHRyaWVzIHRvIGZpbmQgdGhlDQo+PiBjYW5kaWRh
dGVzIGJhc2VkIG9uIGNrcHRfdmFsaWRfbWFwIGFuZCBkaXNjYXJkX21hcC4gSG93ZXZlciwNCj4+
IHNlZ19pbmZvX3RvX3Jhd19zaXQoKSBkb2VzIG5vdCBhY3R1YWxseSBydW4gYmVmb3JlDQo+PiBm
MmZzX2V4aXN0X3RyaW1fY2FuZGlkYXRlcygpLCByZXN1bHRpbmcgaW4gdGhlIGZhaWx1cmUuDQo+
IEkgdGhpbmsgd2UgbmVlZCB0byBmaXggdGhlIGFib3ZlIGxvZ2ljLg0KDQoNCkhpIEphZWdldWss
DQoNCkkgaW5pdGlhbGx5IGF0dGVtcHRlZCB0byBhZGRyZXNzIHRoaXMgaXNzdWUgYnkgY2hlY2tp
bmcgd2hldGhlciANCnNlZ19pbmZvX3RvX3Jhd19zaXQoKSBydW5zIGJlZm9yZSBhZGRfZGlzY2Fy
ZF9hZGRycygpLiBUaGUgDQppbXBsZW1lbnRhdGlvbiBjYW4gYmUgZm91bmQgaW4gdGhlIFYxIHBh
dGNoIGhlcmU6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1mMmZzLWRldmVsLzIwMjUw
MTAyMTAxMzEwLjU4MDI3Ny0xLWd1b2NodW5oYWlAdml2by5jb20vDQoNCkhvd2V2ZXIsIGFmdGVy
IGRpc2N1c3Npbmcgd2l0aCBDaGFvLCBJIHJlYWxpemVkIHRoYXQgcGVyaGFwcyBhIGJldHRlciAN
CndheSBpcyB0byBmaW5kIGFsbCB0aGUgZGlzY2FyZCBibG9ja3MgYmFzZWQgb25seSBvbiBkaXNj
YXJkX21hcC4gVGhpcyANCmFwcHJvYWNoIGlzIG11Y2ggc2ltcGxlciBhbmQgbWFrZXMgYWRkX2Rp
c2NhcmRfYWRkcnMoKSBpbmRlcGVuZGVudCBvZiANCnRoZSBwcmUtcnVuIG9mIHNlZ19pbmZvX3Rv
X3Jhd19zaXQoKS4NCg0KQ291bGQgeW91IHBsZWFzZSBkZXRhaWwgeW91ciBvcGluaW9uPw0KDQpU
aGFua3MsDQoNCg0KPj4gVGhlIGNvZGUgbG9naWMgY2FuIGJlIHNpbXBsaWZpZWQgZm9yIGFsbCBj
YXNlcyBieSBmaW5kaW5nIGFsbCB0aGUNCj4+IGRpc2NhcmQgYmxvY2tzIGJhc2VkIG9ubHkgb24g
ZGlzY2FyZF9tYXAuIFRoaXMgbWlnaHQgcmVzdWx0IGluIG1vcmUNCj4+IGRpc2NhcmQgYmxvY2tz
IGJlaW5nIHNlbnQgZm9yIHRoZSBzZWdtZW50IGR1cmluZyB0aGUgZmlyc3QgY2hlY2twb2ludA0K
Pj4gYWZ0ZXIgbW91bnRpbmcsIHdoaWNoIHdlcmUgb3JpZ2luYWxseSBleHBlY3RlZCB0byBiZSBz
ZW50IG9ubHkgaW4NCj4+IGZzdHJpbS4gUmVnYXJkbGVzcywgdGhlc2UgZGlzY2FyZCBibG9ja3Mg
c2hvdWxkIGV2ZW50dWFsbHkgYmUgc2VudCwgYW5kDQo+PiB0aGUgc2ltcGxpZmllZCBjb2RlIG1h
a2VzIHNlbnNlIGluIHRoaXMgY29udGV4dC4NCj4+DQo+PiByb290IyBjcCB0ZXN0ZmlsZSAvZjJm
c19tb3VudHBvaW50DQo+Pg0KPj4gcm9vdCMgZjJmc19pbyBmaWVtYXAgMCAxIC9mMmZzX21vdW50
cG9pbnQvdGVzdGZpbGUNCj4+IEZpZW1hcDogb2Zmc2V0ID0gMCBsZW4gPSAxDQo+PiAgICAgICAg
ICBsb2dpY2FsIGFkZHIuICAgIHBoeXNpY2FsIGFkZHIuICAgbGVuZ3RoICAgICAgICAgICBmbGFn
cw0KPj4gMCAgICAgICAwMDAwMDAwMDAwMDAwMDAwIDAwMDAwMDA0MDZhMDAwMDAgMDAwMDAwMDAz
ZDgwMDAwMCAwMDAwMTAwMA0KPj4NCj4+IHJvb3QjIHJtIC9mMmZzX21vdW50cG9pbnQvdGVzdGZp
bGUNCj4+DQo+PiByb290IyBmc3RyaW0gLXYgLW8gMHg0MDZhMDAwMDAgLWwgMTAyNE0gL2YyZnNf
bW91bnRwb2ludCAtLSBubyBjYW5kaWRhdGUgaXMgZm91bmQNCj4+IC9mMmZzX21vdW50cG9pbnQ6
IDAgQiAoMCBieXRlcykgdHJpbW1lZA0KPj4NCj4+IFJlbGV2YW50IGNvZGUgcHJvY2VzcyBvZiB0
aGUgcm9vdCBjYXVzZToNCj4+IGYyZnNfdHJpbV9mcygpDQo+PiAgICAgIGYyZnNfd3JpdGVfY2hl
Y2twb2ludCgpDQo+PiAgICAgICAgICAuLi4NCj4+ICAgICAgICAgIGlmIChjcGMtPnJlYXNvbiAm
IENQX0RJU0NBUkQpIHsNCj4+ICAgICAgICAgICAgICAgICAgaWYgKCFmMmZzX2V4aXN0X3RyaW1f
Y2FuZGlkYXRlcyhzYmksIGNwYykpIHsNCj4+ICAgICAgICAgICAgICAgICAgICAgIHVuYmxvY2tf
b3BlcmF0aW9ucyhzYmkpOw0KPj4gICAgICAgICAgICAgICAgICAgICAgZ290byBvdXQ7IC8vIE5v
IGNhbmRpZGF0ZXMgYXJlIGZvdW5kIGhlcmUsIGFuZCBpdCBleGl0cy4NCj4+ICAgICAgICAgICAg
ICAgICAgfQ0KPj4gICAgICAgICAgICAgIC4uLg0KPj4gICAgICAgICAgfQ0KPj4NCj4+IFsxXSBQ
bGVhc2UgcmVmZXIgdG8gY29tbWl0IGQ3YmMyNDg0YjhkNCAoImYyZnM6IGZpeCBzbWFsbCBkaXNj
YXJkcyBub3QNCj4+IHRvIGlzc3VlIHJlZHVuZGFudGx5IikgZm9yIHRoZSByZWxhdGlvbnNoaXAg
YmV0d2Vlbg0KPj4gc2VnX2luZm9fdG9fcmF3X3NpdCgpIGFuZCBhZGRfZGlzY2FyZF9hZGRycygp
Lg0KPj4NCj4+IEZpeGVzOiAyNTI5MGZhNTU5MWQgKCJmMmZzOiByZXR1cm4gZnNfdHJpbSBpZiB0
aGVyZSBpcyBubyBjYW5kaWRhdGUiKQ0KPj4gU2lnbmVkLW9mZi1ieTogQ2h1bmhhaSBHdW8gPGd1
b2NodW5oYWlAdml2by5jb20+DQo+PiAtLS0NCj4+IHYyLT52MzogQWRkIGYyZnNfYnVnX29uKCkg
dG8gbWFrZSBzdXJlIGl0IG5ldmVyIGlzc3VlcyBkaXNjYXJkIHRvIHZhbGlkIGRhdGEncyBibG9j
ayBhZGRyZXNzLg0KPj4gdjEtPnYyOiBGaW5kIGFsbCB0aGUgZGlzY2FyZCBibG9ja3MgYmFzZWQg
b25seSBvbiBkaXNjYXJkX21hcCBpbiBhZGRfZGlzY2FyZF9hZGRycygpLg0KPj4gdjE6IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWYyZnMtZGV2ZWwvMjAyNTAxMDIxMDEzMTAuNTgwMjc3
LTEtZ3VvY2h1bmhhaUB2aXZvLmNvbS8NCj4+IC0tLQ0KPj4gICBmcy9mMmZzL3NlZ21lbnQuYyB8
IDggKysrKy0tLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxl
dGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9zZWdtZW50LmMgYi9mcy9mMmZz
L3NlZ21lbnQuYw0KPj4gaW5kZXggODZlNTQ3ZjAwOGY5Li5jOGFkOGUzYmZlYmIgMTAwNjQ0DQo+
PiAtLS0gYS9mcy9mMmZzL3NlZ21lbnQuYw0KPj4gKysrIGIvZnMvZjJmcy9zZWdtZW50LmMNCj4+
IEBAIC0yMDc1LDcgKzIwNzUsNiBAQCBzdGF0aWMgYm9vbCBhZGRfZGlzY2FyZF9hZGRycyhzdHJ1
Y3QgZjJmc19zYl9pbmZvICpzYmksIHN0cnVjdCBjcF9jb250cm9sICpjcGMsDQo+PiAgIAlpbnQg
ZW50cmllcyA9IFNJVF9WQkxPQ0tfTUFQX1NJWkUgLyBzaXplb2YodW5zaWduZWQgbG9uZyk7DQo+
PiAgIAlzdHJ1Y3Qgc2VnX2VudHJ5ICpzZSA9IGdldF9zZWdfZW50cnkoc2JpLCBjcGMtPnRyaW1f
c3RhcnQpOw0KPj4gICAJdW5zaWduZWQgbG9uZyAqY3VyX21hcCA9ICh1bnNpZ25lZCBsb25nICop
c2UtPmN1cl92YWxpZF9tYXA7DQo+PiAtCXVuc2lnbmVkIGxvbmcgKmNrcHRfbWFwID0gKHVuc2ln
bmVkIGxvbmcgKilzZS0+Y2twdF92YWxpZF9tYXA7DQo+PiAgIAl1bnNpZ25lZCBsb25nICpkaXNj
YXJkX21hcCA9ICh1bnNpZ25lZCBsb25nICopc2UtPmRpc2NhcmRfbWFwOw0KPj4gICAJdW5zaWdu
ZWQgbG9uZyAqZG1hcCA9IFNJVF9JKHNiaSktPnRtcF9tYXA7DQo+PiAgIAl1bnNpZ25lZCBpbnQg
c3RhcnQgPSAwLCBlbmQgPSAtMTsNCj4+IEBAIC0yMDk3LDkgKzIwOTYsMTAgQEAgc3RhdGljIGJv
b2wgYWRkX2Rpc2NhcmRfYWRkcnMoc3RydWN0IGYyZnNfc2JfaW5mbyAqc2JpLCBzdHJ1Y3QgY3Bf
Y29udHJvbCAqY3BjLA0KPj4gICAJfQ0KPj4gICANCj4+ICAgCS8qIFNJVF9WQkxPQ0tfTUFQX1NJ
WkUgc2hvdWxkIGJlIG11bHRpcGxlIG9mIHNpemVvZih1bnNpZ25lZCBsb25nKSAqLw0KPj4gLQlm
b3IgKGkgPSAwOyBpIDwgZW50cmllczsgaSsrKQ0KPj4gLQkJZG1hcFtpXSA9IGZvcmNlID8gfmNr
cHRfbWFwW2ldICYgfmRpc2NhcmRfbWFwW2ldIDoNCj4+IC0JCQkJKGN1cl9tYXBbaV0gXiBja3B0
X21hcFtpXSkgJiBja3B0X21hcFtpXTsNCj4+ICsJZm9yIChpID0gMDsgaSA8IGVudHJpZXM7IGkr
Kykgew0KPj4gKwkJZG1hcFtpXSA9IH5kaXNjYXJkX21hcFtpXTsNCj4+ICsJCWYyZnNfYnVnX29u
KHNiaSwgKGN1cl9tYXBbaV0gXiBkaXNjYXJkX21hcFtpXSkgJiBjdXJfbWFwW2ldKTsNCj4+ICsJ
fQ0KPj4gICANCj4+ICAgCXdoaWxlIChmb3JjZSB8fCBTTV9JKHNiaSktPmRjY19pbmZvLT5ucl9k
aXNjYXJkcyA8PQ0KPj4gICAJCQkJU01fSShzYmkpLT5kY2NfaW5mby0+bWF4X2Rpc2NhcmRzKSB7
DQo+PiAtLSANCj4+IDIuMzQuMQ0KDQoNCg==

