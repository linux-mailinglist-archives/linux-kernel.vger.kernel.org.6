Return-Path: <linux-kernel+bounces-376704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AD19AB510
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3BC21C22ACD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1646A1BD513;
	Tue, 22 Oct 2024 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=newgenag.onmicrosoft.com header.i=@newgenag.onmicrosoft.com header.b="ACdRNVcG"
Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11022081.outbound.protection.outlook.com [40.107.168.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1366EB7C;
	Tue, 22 Oct 2024 17:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.168.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618137; cv=fail; b=QOZKYIl2a1ss6MkI8bpHINyp5rHiJydUA0JGSXTWpOoovZCZjcXcVc/xCk88JaCk0sqlF3cvWmXMjV6HrKdEqgLV78fv9R0DKe710i7CjMWwgxiVi+PblJZM/ifYdissJe2U127HxqCDWeCVX5oloUsNoofYSI3Y3gJbxtjDT5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618137; c=relaxed/simple;
	bh=l3FJE3F1GNT8xcufy4EqEY5p0YaO8fFvVGL2y2w0cKc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tFWJsl8WKawsbAO4rw9mfWyAvSYA6j8dtlLUFAu3LB9JT+3Kvc6qi+nIqwRUhQ4lCX9qnVNZzH2p4NZHK3RO0qCPwJ7wz4sLKigDCv8JXDS4hTlaaLk/gAssKEyXpHLeCV7cAv83zrKkiQ7q4F1mYB8GaIWwnrqvp2nksBMExnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mbv.ch; spf=pass smtp.mailfrom=mbv.ch; dkim=pass (1024-bit key) header.d=newgenag.onmicrosoft.com header.i=@newgenag.onmicrosoft.com header.b=ACdRNVcG; arc=fail smtp.client-ip=40.107.168.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mbv.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mbv.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=paM2oP+qUwlAKvjkns/IiuvZL5SlK1p1GKYrylMQgNg7KnihBqut+2ft20mFWsFIKO3tN6N6fR3u3ixyRwu1VSKl1oqjm6cL2HoyGo0ETt9zRDHX9FnVmWcQbbXUNnO2nVTbt3IFCjbu0yRLO9lmYvKFJGii2EtzTqkVbt8M4M4lJUvSXBhlsjtdwvTspN5CnkarrFL2zEmfDjSMm5SlLFJELMTcw4Yv8flvEbmJmsFPg9m16J/keoEIUWqmUSsJExyxYEHkPoPRYHkVH4cWp0JWDe94+NxyfSHkgkJzFF6wlU8lhYYtdDOW4NOaLs+Gs/cKkFQSmOCr9Yf2YnGv1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NjVe3C78BbUTU6R+TCZ5ngIxsbsYi+1Q1slHoWddsc=;
 b=IQiKHI34SshsyDNRd2dX3mV3VuprRY1bjEuDK2vHTsJJLRVA7giHHKdnDV9xVIdprYWRfn5tBXAKlNxpVrh/GJBX01+mbfz1WvyKBO681cEn0ZfKt8E7i7Cg9xxyhHJJ/aGUqPhjqjcsDFqAS37mMKJ0vrifNzrAxTDJNzAS4stOfzK5wGoPk3Os2t1Cd9Fteq4IVa/DSXGcF0gSgDZs4hrST0A4KF4vVJDSGcUjqmNY8pAW64eFUhLcPOa5SLv4SfrpbX8hLRlItUrRq08Roye3QloSgQP5PT2uCSDVJQLBEkjdUtK7mXHYwUr7hdSop0v+A8JgWLAe3EsigHcvOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mbv.ch; dmarc=pass action=none header.from=mbv.ch; dkim=pass
 header.d=mbv.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=newgenag.onmicrosoft.com; s=selector1-newgenag-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NjVe3C78BbUTU6R+TCZ5ngIxsbsYi+1Q1slHoWddsc=;
 b=ACdRNVcGEz1l0piKaRiJAZyW1ZScLNm5+G4xjcmA21mHKckujrD+eVY4+mDgDQxWlLW1BBSDUgW1zjVLjjUDEXc9hsEOpQfCMAXi2fRIL55QSncbnh26r6nl6XekM+ygeTGqVJrD8nbWOcRLBWztQAdRK+jEr4EvExicwce7org=
Received: from GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:49::12)
 by ZRAP278MB0109.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:12::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Tue, 22 Oct
 2024 17:28:51 +0000
Received: from GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM
 ([fe80::373:3184:90d1:31b6]) by GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM
 ([fe80::373:3184:90d1:31b6%3]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 17:28:51 +0000
From: Yanik Fuchs <Yanik.fuchs@mbv.ch>
To: "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"rdbabiera@google.com" <rdbabiera@google.com>, "linux@roeck-us.net"
	<linux@roeck-us.net>, "kyletso@google.com" <kyletso@google.com>,
	"badhri@google.com" <badhri@google.com>, "xu.yang_2@nxp.com"
	<xu.yang_2@nxp.com>, "amitsd@google.com" <amitsd@google.com>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] usb: typec: tcpm: Prevent Hard_Reset if Vbus was never low
Thread-Topic: [PATCH] usb: typec: tcpm: Prevent Hard_Reset if Vbus was never
 low
Thread-Index: AQHbJKZBKbAlUNbL60mUuxGGz7rdEw==
Date: Tue, 22 Oct 2024 17:28:51 +0000
Message-ID:
 <GVAP278MB0662F98EAAFAD95645E7010A974C2@GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM>
Accept-Language: de-DE, de-CH, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mbv.ch;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVAP278MB0662:EE_|ZRAP278MB0109:EE_
x-ms-office365-filtering-correlation-id: 43480654-e877-496a-a616-08dcf2beff28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?AZGlTc/gnJPqtook6V/DtOrHk/lTaICmQb7dblINAIAUu6zJtKZRghEkzt?=
 =?iso-8859-1?Q?97YrPrNXGqTimVXIV6tOk7r1Gf78XwZyXNpVxh0qQjvAmUmhYxv3m5CJ24?=
 =?iso-8859-1?Q?TszetEOOG46qmeRcnS1xemNr5sArSgzTo2ATPLpGlBf5G1fWKZ8aC56ci3?=
 =?iso-8859-1?Q?iprAPOFttMBCBAAORPKFQIn1Ln2K6r959cNn1p9Apldy78kaHQgMOhSQW1?=
 =?iso-8859-1?Q?a1hAiWGr+q0fPMT1bf0NagbQ4JyeNFs6XhGhUpo86ntkMEFO4I9qhZxKCP?=
 =?iso-8859-1?Q?iGA6BZjpakV1fKCj4f49pOJvfH62VGCpqKrWR5YO1KJu8xsRZGGH3kyXuN?=
 =?iso-8859-1?Q?5bqWQh716bGYA7nqGwFgnaWvo1af2cX0UlTzMZVnwR1ymKYPIKwYN6FgqS?=
 =?iso-8859-1?Q?gevx5R9YPnN6VnfBuh/uGZQ6YlmeT9v+STBDnWtH6Y8LtS9+C0AWTjyUPa?=
 =?iso-8859-1?Q?a8EdrwOVuZs7xM3iG+n7GAidQYTAhzTNsbc3SqQbVrkSa6C6JIjxnV44hB?=
 =?iso-8859-1?Q?/0NeUG6OyQXtf3jdFrGKLR1UuZrv+BhchI/ZuRKAAsyDKY8XjlZUdKOCsR?=
 =?iso-8859-1?Q?4073z+BfSsu+4M44Bi5dc5hyKNdABOU7l9Qoyv7Nr4bqZAcc6BUrGpuf8C?=
 =?iso-8859-1?Q?is3PSKVDhtOn5pSVq9KhDhSj+DYTl2V8hlIlI+svFXZl+9BQiLZ6u0Za7H?=
 =?iso-8859-1?Q?eH8+RsKGPkGS8lIAdOadqAGr5l3l1VXW7J3I2NwHZMzRtmGmZu03ZbXR3k?=
 =?iso-8859-1?Q?6wMgn/Ar35E2kZmHomyPug0Tn3JRLKVEIByZZK1Xg2MuFpx9mpA7YpfYhi?=
 =?iso-8859-1?Q?lPx9svCuWS7NbiwDz/lijofHUophQGw8WCDKpCSt/4woXTDi1I+rvArswt?=
 =?iso-8859-1?Q?57av7MDtwdVnFNJndatJFPVQFf5rUHqY3kbJtC5EpH/IrLBBM0S9qyapLJ?=
 =?iso-8859-1?Q?oWZfooejxGLDga3H6uW6n4yVezhkNCpnOacGc2MtZiMN8mUhd6J5jx0Vpa?=
 =?iso-8859-1?Q?K4PXdR9Hw0+xDJIc3YUWHjrxlGHZPH3La11ucCOSfucYnB8QVUH48+aK5K?=
 =?iso-8859-1?Q?f9yp+kNnUb1yrFQWd78A25PnWPDt+MFk94IsdV1zlcVaalcSRqhesIGwh9?=
 =?iso-8859-1?Q?auUJClQxxsE8M+XoxQXcr/ByswuD309mtVziYCP3zSezn5oXe6+bl16bu7?=
 =?iso-8859-1?Q?M8qTRMy29xFC78ejZB53dizna2XNwaCbmQIykk0je9bumkKIXjvhpS+kQL?=
 =?iso-8859-1?Q?tYrO40eGzCYp03Svhj77vX0TLojIvWXzWNnJ4dPuLFonTGzq9PkMHYa1Tf?=
 =?iso-8859-1?Q?yhj7UB3CJ0Sxh2qGJGBeZYpnwuBlRu7EaCp4lMqgtObOoAAgeJvgnRI9cK?=
 =?iso-8859-1?Q?A9lQ1nOVTHfKg2gcyyeRj0UjGeOL4e3/KKMXrkb41M2NMus6qIt4Y=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ZsaKZp+yzTjfV3FAS6W99X/yojbTsYR/4Douoxfdj0JS9P6wcpixz/VRK2?=
 =?iso-8859-1?Q?ytibuybaoqvDKIOVs3ztvKFMR37z2651ff9NS1QoVrOSoQuanIg/pldLS/?=
 =?iso-8859-1?Q?+nN1LONYVUPuPI+mMyC420ixoV8wZbQT8ZOy+F7RnIVDnL3BHhtrzXx+wq?=
 =?iso-8859-1?Q?ltffVI37wLvzFiq2BYqPnhya1K8BPhwjVIIGo7KZ5VXwNQ2V0fUwEVZi1l?=
 =?iso-8859-1?Q?ynNOzddcoxPVXrDL0lsXP06cDgAU2urPdqFHWRo3IdGhe58ADN1Y+wU5yF?=
 =?iso-8859-1?Q?Ruat+0fShfUE+rvxWXQIf6/K6jHYIrOsSJOtXfVVQtBbofDRgVFTEqwjU5?=
 =?iso-8859-1?Q?B8AUsvFXjyfiBQHv0n0cXFl85u4G0jppLPTnITs7Us3++ZB4wK5zf18TwI?=
 =?iso-8859-1?Q?jHK0yYTEqvWmEPOySqHV5uPa4bR3KzEYGzzoSdwKsiY0PLExPVRJ3C8chz?=
 =?iso-8859-1?Q?n0+z0w7mhG5wGZPAakN4nx4pALEyIrrE0wjfEAmC9PQw/Y8HmBWSRaelB0?=
 =?iso-8859-1?Q?cUFVeJiWJBvbmCZCNnUhLpx4HtiyO6uc0fUQLjDq1fBhRCQbeGRueS3iRJ?=
 =?iso-8859-1?Q?TBU+SOe9Exvb7e/p/wlYi5L+Q26TG/0JbWMd4ViTB3cu0PS1Q6L8TjZTh9?=
 =?iso-8859-1?Q?BWZa5lsMfpi6yhdkJ/soQtwmYSQ+yIzd7hfL2U9JlZe99Qh7QHnUT2wQF7?=
 =?iso-8859-1?Q?6fRAvY0W3ocHalvL9IpaTYKU5iK4tXtGbsxDBQ5t+i3pmbFCU13l+eDhWx?=
 =?iso-8859-1?Q?G/OZi/SNv9NBihiyTv12mkkoGjy3J7gOhPcA/PFZRpCgxX7mH/jsgbJ0mk?=
 =?iso-8859-1?Q?k2WydA8pnn4lrpfN2O4hvkfDhqQEhOpT1k7OqAZY569UhPn7w1EEoGJksb?=
 =?iso-8859-1?Q?wIAuwBGUWNxR1vpP2gIywq7nC+BrJn7gbII6/Z+1wNeVyn8cPqL8zTdAfQ?=
 =?iso-8859-1?Q?SWN6180Yc9xEbIPodpwycSKwPWR5EWPh12aqG3kuGc3Lni4SwzVguBJXXs?=
 =?iso-8859-1?Q?s3oHBmrER59NLHSAwSDr3IQ2ZjAEsst496AYse/+/zDAgyESZc8d2y6FHK?=
 =?iso-8859-1?Q?U4mBRV+rRCLLbnFFztmHsKJ5EUFcLRV7UoQZGmopHChHpYtZdL4e5Dqmwt?=
 =?iso-8859-1?Q?0FzYWrkzoU9zDb/8QRz3p3qkLSPOpjjvNHPKWNtOd2qoOCVb+NfBVzDfjJ?=
 =?iso-8859-1?Q?XyO4T21n2dp2rkqoR7GLvXFlO8wm9L78nkgG3fvcX0li4RT+1DPtSSQfCw?=
 =?iso-8859-1?Q?QG8JFPSySh8MwFAoteY945p7gSv9VJb8kK+SJYiNltiFMAjDLBIksevWaz?=
 =?iso-8859-1?Q?CeKfh8arYPNsTafWNDWNEMNWggN1DmPFufifn5chOye3FGc1Ye/zpf1ofw?=
 =?iso-8859-1?Q?cKtU0RgO/GH5sxRBlUWpcQdE31FTW5Pz63zMoQStVyrlGvf4QajWOpDx3o?=
 =?iso-8859-1?Q?sBbF629OOCDieZWB6AAycQ3lK19M+SMannK+Bwgs7dNRntq+Wu/wOGxGK+?=
 =?iso-8859-1?Q?AtjPBSNOKgwNiEf1823sRSNOk4kfBuBnn0H2hYQjeewYvNC/2wgruljqGn?=
 =?iso-8859-1?Q?HFPCmf2t1N28yT+A1yFbslTKljykKYXvGadnHPJEK39+gueGrRh5clUgwK?=
 =?iso-8859-1?Q?Yk75H9oBNQwk4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: mbv.ch
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 43480654-e877-496a-a616-08dcf2beff28
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 17:28:51.7722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0b9c2100-a992-4d02-9349-895ecb1a1527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mqkvy/jeMbQD3P+vCStOrU21PiUxta75WPIxWr5VboZWZlYrB0ry4+FJwknaVM8pCWS7/gm3rr/CXpbVXCBU6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0109

Good Evening=0A=
=0A=
Here is a Patch to resolve an issue with TCPM if Vbus was never low.=0A=
Please consider that this is one of my first kernel pull requests, I may ha=
ve missunderstood the process.=0A=
=0A=
Freundliche Gr=FCsse=0A=
Best regards=0A=
=0A=
=0A=
Yanik Fuchs=0A=
=0A=
---=0A=
=0A=
From 604b97b6394b5643394bc63d4ac691c098c99c40 Mon Sep 17 00:00:00 2001=0A=
From: yfu <yanikfuchs@me.com>=0A=
Date: Tue, 22 Oct 2024 18:23:18 +0200=0A=
Subject: [PATCH] usb: typec: tcpm: Prevent Hard_Reset if Vbus was never low=
=0A=
=0A=
Before this patch, tcpm went into SOFT_RESET state, if Vbus was never low=
=0A=
resulting in Hard_Reset, if power supply does not support USB_PD Soft_Reset=
.=0A=
=0A=
In order to prevent this, I remove the Vbus check completely, so that =0A=
we go as well into the SNK_WAIT_CAPABILITIES_TIMEOUT state. There, we send =
=0A=
PD_CTRL_GET_SOURCE_CAP which many power supply do support.=0A=
(122968f8dda8 usb: typec: tcpm: avoid resets for missing source capability =
messages)=0A=
=0A=
Additionally, I added SOFT_RESET (instead of Hard_Reset) as Fallback soluti=
on=0A=
if we still not have gotten any capabilities. Hard_Reset is now only done, =
=0A=
if PD_CTRL_GET_SOURCE_CAP and SOFT_RESET fail to get capabilities.=0A=
---=0A=
 drivers/usb/typec/tcpm/tcpm.c | 10 ++--------=0A=
 1 file changed, 2 insertions(+), 8 deletions(-)=0A=
=0A=
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c=
=0A=
index fc619478200f..c7a59c9f78ee 100644=0A=
--- a/drivers/usb/typec/tcpm/tcpm.c=0A=
+++ b/drivers/usb/typec/tcpm/tcpm.c=0A=
@@ -5038,14 +5038,8 @@ static void run_state_machine(struct tcpm_port *port=
)=0A=
 		 * were already in a stable contract before this boot.=0A=
 		 * Do this only once.=0A=
 		 */=0A=
-		if (port->vbus_never_low) {=0A=
-			port->vbus_never_low =3D false;=0A=
-			tcpm_set_state(port, SNK_SOFT_RESET,=0A=
+		tcpm_set_state(port, SNK_WAIT_CAPABILITIES_TIMEOUT,=0A=
 				       PD_T_SINK_WAIT_CAP);=0A=
-		} else {=0A=
-			tcpm_set_state(port, SNK_WAIT_CAPABILITIES_TIMEOUT,=0A=
-				       PD_T_SINK_WAIT_CAP);=0A=
-		}=0A=
 		break;=0A=
 	case SNK_WAIT_CAPABILITIES_TIMEOUT:=0A=
 		/*=0A=
@@ -5064,7 +5058,7 @@ static void run_state_machine(struct tcpm_port *port)=
=0A=
 		 * according to the specification.=0A=
 		 */=0A=
 		if (tcpm_pd_send_control(port, PD_CTRL_GET_SOURCE_CAP, TCPC_TX_SOP))=0A=
-			tcpm_set_state_cond(port, hard_reset_state(port), 0);=0A=
+			tcpm_set_state_cond(port, SNK_SOFT_RESET, 0);=0A=
 		else=0A=
 			tcpm_set_state(port, hard_reset_state(port), PD_T_SINK_WAIT_CAP);=0A=
 		break;=0A=
-- =0A=
2.34.1=0A=
=0A=

