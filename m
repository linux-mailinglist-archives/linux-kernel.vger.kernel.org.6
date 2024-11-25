Return-Path: <linux-kernel+bounces-421031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF45E9D85D7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FE2C289FB0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17481A01C3;
	Mon, 25 Nov 2024 13:05:06 +0000 (UTC)
Received: from mx0a-00176a03.pphosted.com (mx0a-00176a03.pphosted.com [67.231.149.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD16D944F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 13:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732539906; cv=fail; b=GFTf5F33epaFf6ILNanREIbyVL7/7gyHD+N43w0uJYPLl566yB+MiQ6DOcaoH7ZGpZYQU0cVJhIaBeppppJA7ljKZy0lMO0F6SOi9Z7DrDfiJm61/I8x2I0HADDFt9dCnTO4PfGGFb61/0qP16wlOFey1OOwUn8dnmzaLhFhpWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732539906; c=relaxed/simple;
	bh=x6v6VlTUm+wAespa23q11pXGGsNBdOQOcaWJCptzfGs=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=C6UmbQu9xmLxzAHstR7MFWG/3XOmxX4M9AhsPNUEou3C1m3CFVxPdLijQi5RXv0Apanqwe7qZAsmB0NLNDZpLshRuGt8WpNWI+LE0CvYz2nKl71EmD0HH44sSbWyka/0KDkJ1smp35PJxfHtPgcy6aX8PaFCMJ21Ga+p8GwMGSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ge.com; spf=none smtp.mailfrom=ge.com; arc=fail smtp.client-ip=67.231.149.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ge.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ge.com
Received: from pps.filterd (m0047962.ppops.net [127.0.0.1])
	by m0047962.ppops.net-00176a03. (8.18.1.2/8.18.1.2) with ESMTP id 4APBcEPO000913
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 07:16:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y6HBGqBmpAsVjR+EVy8M67ruoYki66W7YQph0/RhIFE7pUbNEP69gfGJR4UV0WAxEeVsrby8m5DqzYYVp7uBBDlgiTtdQsliiafK0Xh51Vy4oqn5GZNjYGTxR1XZa0fZTsA5dxRiEwSu8pk9WCKOI6w3tJvWx8WoZ0gZG2e5S3H1zL3p9LhvNyKqz6BIkPxg14XxqVYxlqlfLPbH+5cEimtvgr7jGs8c1PGHg5/DIvv732OTD7ydBC2YeIWi6FomfeuIV+Iw5H5jN2Je+QoJDBXz/RBO0SKD74/ScP75tRPlEqC++EGGUnUzWt+NWYgyeN6bK2mO7nwp/b03xA0Q/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykjVbTKg+wPfZgFP1biP7/YQZJdAmmw7S5QxQYfp/AE=;
 b=GDawBNGUYMgiIPPkmOtP5bm5+f6SRZeDJ0jQ+1OeFUnicR9Iu6nULlcy3fOq7Uj6YlJMfp+2UA17sJcp+xsWsc/NtL7UvskZENulAMBtPhoVSlLRVka16Ef5iU6WtyuxRs2DwlonL5g/x9iQVHbuwBZHQ2FnSpEY/0G8/TpppO6ewaEuG47ZEMoVruv9j1EW7AbIMDBgnmn2h9F1lBLCRCWlP/+uSSl4i+0kKqIXGRmbiOEg9gbZsqc/YoK85fWmxIfPEoTN+J/mHM6FNlTtVSn6PU4b+C0Jd+QwmJgbz1HK1k9sBtSSgBAfjs6gz5ZRsydMmxSF8dLDpr3LzcjJaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ge.com; dmarc=pass action=none header.from=ge.com; dkim=pass
 header.d=ge.com; arc=none
From: "Dalmas, Marcelo (GE Vernova)" <marcelo.dalmas@ge.com>
To: "jstultz@google.com" <jstultz@google.com>,
        "tglx@linutronix.de"
	<tglx@linutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Dalmas, Marcelo (GE Vernova)" <marcelo.dalmas@ge.com>
Subject: [PATCH] ntp: fix bug in adjtimex reading time offset
Thread-Topic: [PATCH] ntp: fix bug in adjtimex reading time offset
Thread-Index: Ads/My84dVlSiCGMQfa4xsAzAFEqmA==
Date: Mon, 25 Nov 2024 12:16:09 +0000
Message-ID: <SJ0P101MB03687BF7D5A10FD3C49C51E5F42E2@SJ0P101MB0368.NAMP101.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0P101MB0368:EE_|DUZP101MB0575:EE_
x-ms-office365-filtering-correlation-id: 96dd11d4-94a6-4477-3090-08dd0d4af224
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?8L5GIqep90+9BlNNs7kbVydLNRN2Hob1qq/uRCWAcASZC9sFUneZuY2FkcYN?=
 =?us-ascii?Q?MMgofF0W/qIB4pG6yHBfGnqP+MehKdjtRYmJGerGpk0HhTGeQ3RP4M5xSHC4?=
 =?us-ascii?Q?yGXVKNCd8zyWuBKoz/9Zh51DRXw4sKKQBKgIFgDfYWNU2W2NvcgbgQ+pcfiM?=
 =?us-ascii?Q?IokNwIfukdwsUuy8AHGzCSsfxm5gPR5sBkjGUqBSp4mgrIM3LitHbaFWbhU2?=
 =?us-ascii?Q?/hlX1l/FguDmSjhpq5W23HFU/rfGQJ1HLmJUvEF5nPf8RE/+XIZ4h2wvUDNK?=
 =?us-ascii?Q?Lo4+6MLCd6MUDKbF1/dVeBriI8tL53x+sLLVrGJWWeBemw8LVGPhhWezou0m?=
 =?us-ascii?Q?UJ79YWexOM2+qg8p0vRS/whw/+P3cHnWHQiUuR8XvN7X+TTdUwkHzvPRT1gZ?=
 =?us-ascii?Q?fc2R4Y+9wLJQKQciW8CY6nyZPiFafu5J8X/bi8OI7SWxoHAZg/3CJzFMnp/c?=
 =?us-ascii?Q?MEZ8W/aboshMSj1PqroqMO0uXGoPfYburUgF2xZH/z00iFF33ltrKFtxC0bz?=
 =?us-ascii?Q?Y+zNEVKwgLJrArZawiHFo0p7VBWMmznzoPg00hjzUMWdLXbsO3A95Rn2HeD+?=
 =?us-ascii?Q?EGWWmAQG+oCWh7sDAiyIEbtu2egzNoQTEVMa89ZHRuRXB1vXaN8XLNRk47Qp?=
 =?us-ascii?Q?EwtG4zPMm1p/rX4FmO5tF1lEdfTW5rjCwR7lj6MMhf7YpgSayinELOXy5oPj?=
 =?us-ascii?Q?5lPGLQ2/KqWzm/fRZgpPMbZdynierYoYccXSUJPAFK6f4vEIic3VN1Ze01g7?=
 =?us-ascii?Q?pxtFDWxS1ziOobObCN7ezvNeN1jgWK+UTRAMKSLCCkjAMncXUqYogegfyXnt?=
 =?us-ascii?Q?arQgH/5XSjqZljFnuMVeTY1RgRCfaBr+j0wPFOX+wgUwDH5oU9jHb6TuWKI5?=
 =?us-ascii?Q?m8y3dfnnyf4wWQBzyMXK965vJn/NcrtQPxS7xY3bu99ZlEppYU7LCHjpb8wu?=
 =?us-ascii?Q?QPyVlnc45Ia7Mm9RB8+d/4jPKcQw/mmkEi8KEliS0WCZO6lA/5L0btYGAOeg?=
 =?us-ascii?Q?qLK50fh3uKFC+8PSSGJOnDSxaybQCUMHBIQWTsxcR7rSZT1kWO51nIRxS+ux?=
 =?us-ascii?Q?rU+FbJNHygrGNpRMK6r7cZXBWwMpFHVj4+auTR2eCOJk9+DzfBNVVgJHzsAu?=
 =?us-ascii?Q?fO7/ihye2kSF+zokgzTlrZfdDkZ4CaMzc0XdMquTd20AoGOgIn0HejobQIzT?=
 =?us-ascii?Q?mha9wpTulvjTDaRB4ZPit6uTdrXdKMgVLBBR2har8SU9x2IweXZrBL0F1xc2?=
 =?us-ascii?Q?viuBCvmb7pvXoZzVFlqccdX/8sRUSaITtMQohdlizerEqhirq9q3RvTAfM/x?=
 =?us-ascii?Q?KPFQVgq49+XVNYYcFuj1RbMn+cb+YmQ92pwtoUb3Q6Usz+Q06Ee+CTlwncxm?=
 =?us-ascii?Q?6hVpWoFDrGoIc/QMAdGd7QA2kUqFA+2Rt4yg7QcVMcFX4jjFfQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0P101MB0368.NAMP101.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aamoFjMBlhQAyKK231ILTogpBN8Wwb1AwOGrtWbgS5TdWUO8063qWDftaDuc?=
 =?us-ascii?Q?UxF5aUtbVK+/g7VUoNqEXr4Ansoczs0hhqWvdYGVFsQLyw1qPtHk+mUqqtzQ?=
 =?us-ascii?Q?7VXgV+w3uurdKJ6faHzoCTjGMDWiDsBpTthlUKyNI4FaAlTq/2opp9vQkXtD?=
 =?us-ascii?Q?hLjaCDNS8H2RK/MxiTLMOBv5YXH8w7qKCy6d4CNTq1RpwTo3PW8bJyWlFaNe?=
 =?us-ascii?Q?V0Dw6r+SLhsTSsnddtwSCI1zVV+aYqEITqYy2MTJ7c+MU8Y09QbyTtFkVqC+?=
 =?us-ascii?Q?nig1YFrnQMwikNPkyGmcDFBSGyv9gB061VfbqRlLDThbV8ZfKcq5JH78VZEX?=
 =?us-ascii?Q?qrcrD4TKbdeS8lXSpqKn3xCuDD06IrWNnh6HjgyPj8YiInMdCudqO09esjWf?=
 =?us-ascii?Q?hBGu78UYWr2byqiNQ3psPk3MbVtO8perC8zK3P7WtfbYpw2w2Ug9/pVflqjJ?=
 =?us-ascii?Q?XEN8VBB4pHzJnKL2Rhf0fKoyUAWDH3dz7/Gu+6KGapco6SxMGT9lhCzarF95?=
 =?us-ascii?Q?JsXqgnGQQoXUeLpLaPV3dENkJ4igHXfGXUhNusFYEKIfDakN78DdxU7Lgk7z?=
 =?us-ascii?Q?bx9+beGOqcS4lwuO+zmDS6nDeZS9gunsLNK+hcGZF0BvqTDCCBODYLVympfl?=
 =?us-ascii?Q?0qll2EM/dLC3B+nw9kQBubBadADlMcbHPsjoQfgndtD2Tcl69SfBf2gzqNBJ?=
 =?us-ascii?Q?81DH0KkVBLMdSzveVzr51qSA3STCW+N3GVlQPGW14zsU5XwjUHKLUf3252Ty?=
 =?us-ascii?Q?LG96nLC+C4nFTwVBzWriLyYTxENM0dpX+t0tPIfIpttyP9BXMpPdYpFxE3T2?=
 =?us-ascii?Q?/RsgvR415ydK9QbxNtngP5To5OgzFzBtcx0NJPCwyHj4bcz8xPOwuUjq9yas?=
 =?us-ascii?Q?/+MFdpzm445GOf9ECLqKwY++OpRTqKBtRfOa2qBpA2HCvKYP+5lVMwAHQ6Xy?=
 =?us-ascii?Q?7NoKJO/wHexd+t2C2PeUzgxS83GDAAUeF8UnX4DUbxVmYzobGZwqNPisvhJr?=
 =?us-ascii?Q?gY+loVMEMqXdR7JthwANj3nz9bsF/IZ0x4ARmKRklEa2EtVF0KQL/lRZHAD1?=
 =?us-ascii?Q?KKo46z+J9vhfxhnW+DIBRY30qJ56GUFbTkL/VVfXWaKBhUCzLBaSAVGn8EXZ?=
 =?us-ascii?Q?yUPabeXr/LIYtToOQbQYsQANnOLYkDBnDq0cLg7ogK11U1RcIoGDPVRNZfP1?=
 =?us-ascii?Q?8NE8kYbWw4DWgl7MT4aZm9BrUSsLrQHNjQR23U6P2BmhGReO0GVW8vPy80Cb?=
 =?us-ascii?Q?pt27BQiu8m/AJsmliO5fmlb8Ldj+BEGWyX8SwKWV+zTGN1Fq9W5hLnXiIje+?=
 =?us-ascii?Q?tMg7RIJJu0klj7n72dywk5a6+0rsIl8fI06kEMjjk5la09B7soO4reHvnqB/?=
 =?us-ascii?Q?kzJC+P9MR6L/l8no7oBAIhpdKGrhBO3MGcwp/blVVK9LZHYdfuQ7lmRk5zh4?=
 =?us-ascii?Q?2tnV7i7gkdEqeQsPg2F5+arZMjbPny1owsLHk3tWcpUKirYyYfY+EHuz9evQ?=
 =?us-ascii?Q?CUIX0dE91/nubtSa+Anpghsm4F+nzJktsyPTj0Di9bIlwhErllJCGnR46XCA?=
 =?us-ascii?Q?qXdDJPKm1sKR7E02VlE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0P101MB0368.NAMP101.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 96dd11d4-94a6-4477-3090-08dd0d4af224
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2024 12:16:09.7086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 15ccb6d1-d335-4996-b6f9-7b6925f08121
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qGecXmvtSuBhGTlt+q16QgqDT4PnGL2zKEQtkZUJaGjy4DSVjrXVw3UVnbxgg1HApneNdD1ZgTsLHxgiBseP/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZP101MB0575
X-OriginatorOrg: ge.com
X-Proofpoint-GUID: a8SbADT2K7ejiZV09rHRTEK0c3wvtK23
X-Proofpoint-ORIG-GUID: a8SbADT2K7ejiZV09rHRTEK0c3wvtK23
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-19_08,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 clxscore=1011 impostorscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411250105

Due to an unsigned cast, adjtimex returns wrong offest when using ADJ_MICRO=
 and the offset is negative.
In this case a small negative offset return approximately 4.29 seconds (~ 2=
^32/1000 milliseconds).

Signed-off-by: Marcelo Dalmas <marcelo.dalmas@ge.com>
---
 kernel/time/ntp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index b550ebe0f03b..02e7fe6a0afa 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -798,7 +798,7 @@ int __do_adjtimex(struct __kernel_timex *txc, const str=
uct timespec64 *ts,

                txc->offset =3D shift_right(ntpdata->time_offset * NTP_INTE=
RVAL_FREQ, NTP_SCALE_SHIFT);
                if (!(ntpdata->time_status & STA_NANO))
-                       txc->offset =3D (u32)txc->offset / NSEC_PER_USEC;
+                       txc->offset /=3D NSEC_PER_USEC;
        }

        result =3D ntpdata->time_state;
--
2.39.5




