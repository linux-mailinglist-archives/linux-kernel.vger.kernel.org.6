Return-Path: <linux-kernel+bounces-423316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8E39DA5BF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E062816551C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBC5197A7C;
	Wed, 27 Nov 2024 10:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="eU4u/+gR"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2096.outbound.protection.outlook.com [40.107.22.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F6A1946A1;
	Wed, 27 Nov 2024 10:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732703374; cv=fail; b=jNzrv/sL9zrSNRJ1AnFcaKJLtNmkhc+SqyRq9tVBcuF1Hu8aHuyRSJ2jmPnf/hlkSnZqwxfmuShyoJAC0Kyp9vpQUKhl4qiL9K5ehxBqX0+cir8B7MjTwBkguOSYRQoPwnOro1QJqqfjnPUzv4EpHTfUPhcEA49CYnZ8z/HHDZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732703374; c=relaxed/simple;
	bh=IUzyx982xeygWICzRSpAyBpxnf+8uFok172YIKwE/U8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mcOG4oQzLkNU9x7Tqxi11SKgME6+rSQKNERondOmHrO8d8UUAPuMPQFeffpZ0Qbgzk0TwUGUQhp50PlhF7EpvDFolk6IAcYGzdaPiNU7P2XUqcKMcorNNXxWChVoAAkwCXXA3ZKrp/40N+QavdeCQhnuaEwy1uRRZYpGIrIeHr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b=eU4u/+gR; arc=fail smtp.client-ip=40.107.22.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2TwuqCUD2lOFxVCNHch5lYj68eZXKFgtaoozM4NlOK86Y65Xe1aXdAmco/Cnsr5J48IrbmUFzFzypcIKHyJyXf1OjOgoZTWpzZpRIIQRUY6KIc7ygY7xpwvnSt9sduG2SCdRCLlrLeK3EhaAOS6rneXxS5seqUKn0rdASh1ruhHcoRfMGK5fiKvBcotI+tzacMHlC48fbBjaQUUkXmI4mAczeufgH1enfx+iGyKM8Q5VZcHGBuIaGAltf4gd7BQO6lrtaiGctzzxJhjoPk2CjFhvWCjNCZK+dVQqhqwkWafFAdC2KMcbxI3oDQMjpN99n7D5mxk8eKzkBcZOBgGTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUzyx982xeygWICzRSpAyBpxnf+8uFok172YIKwE/U8=;
 b=GmFboXR32xsLTh8tPnn8nIsYEYX6XC/KzVgDV6ULbF8yvQ60KyiAa9nuLUTa1NbT5T8HIfoCpGH0mbKXA89aR2qwDUWiaxwbYeSpbOvTQyMXtaxHW9GN/Z+3aKZL0ipEEn7M5GyAZ28bTxJXbLKWWD+WovyNq7f/HAhXNsN1r6gqNqUa6Zg/+xYl43GSxbUVkNeV0FyDAa/aTkWe94UxgCUfbPcS3ezq+WTWKydEwMx1ZKA/SxaQgpRU0VUjRJ2ZWbkTfFdpbT7vEVIMUhcubhdeaVIU3edvoPsylAV9VERlzXQUhmlcadBNwcZoKnZUFFHi3oiDwGnBbouEkjQR/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUzyx982xeygWICzRSpAyBpxnf+8uFok172YIKwE/U8=;
 b=eU4u/+gRh1HgBF5Uj06147wI0N7j+/hOrio9bYJPQgF9z34EV3jsm5mW7XBpwICO9UcFUJmGB4zvcjje+AQLOOGjWWdTjJ8wv+hU1/IFVZDl1Q6ap4fwxbi2arlnK4oIj8xupxQvc/mMYAnsjZTZep7+hWIQXksETmmJdIv35hA=
Received: from AS4P250CA0012.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5df::18)
 by GV1P195MB2530.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:1ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 10:29:23 +0000
Received: from AM3PEPF0000A794.eurprd04.prod.outlook.com
 (2603:10a6:20b:5df:cafe::ed) by AS4P250CA0012.outlook.office365.com
 (2603:10a6:20b:5df::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12 via Frontend Transport; Wed,
 27 Nov 2024 10:29:23 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF0000A794.mail.protection.outlook.com (10.167.16.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Wed, 27 Nov 2024 10:29:23 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 27 Nov
 2024 11:29:22 +0100
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Wed, 27 Nov 2024 11:29:22 +0100
From: Teresa Remmet <T.Remmet@phytec.de>
To: "kernel@pengutronix.de" <kernel@pengutronix.de>, Andrej Picej
	<andrej.picej@norik.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"robh@kernel.org" <robh@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"festevam@gmail.com" <festevam@gmail.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, PHYTEC Upstream
	<upstream@lists.phytec.de>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [Upstream] [PATCH 02/15] arm64: dts: imx8mm-phycore-som: Fix
 bluetooth wakeup source
Thread-Topic: [Upstream] [PATCH 02/15] arm64: dts: imx8mm-phycore-som: Fix
 bluetooth wakeup source
Thread-Index: AQHbQLc5JRhIzDutfUCHAAJKopfZOQ==
Date: Wed, 27 Nov 2024 10:29:22 +0000
Message-ID: <48b876665032daf11e33fb97155605883ed5d18c.camel@phytec.de>
References: <20241125081814.397352-1-andrej.picej@norik.com>
	 <20241125081814.397352-3-andrej.picej@norik.com>
In-Reply-To: <20241125081814.397352-3-andrej.picej@norik.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <76A7AA8A104C2842B85885919FECF072@phytec.de>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A794:EE_|GV1P195MB2530:EE_
X-MS-Office365-Filtering-Correlation-Id: 93b74fbd-b0bf-4489-1d5e-08dd0ece5c70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUx2YTU5c0kvdHR6OXVDcUQrVkdJTGxUdFJIcTRZUEFJWEZKdHg1Y1cyLzN0?=
 =?utf-8?B?NUM0WlZCZDh5eE1HWG5HZTNiaDNpVVN3ZHV3ZWJWUGlaNVRUU2NNZnRjQk5H?=
 =?utf-8?B?bUgzLy9mMFJjYkFCVW95ZTRJQUpha0pVVkFTTDF3cWU0VjhjOGs3S1JESXpZ?=
 =?utf-8?B?dGNDRnQySnNac2VZSEN1dHpvSXdiYTZwWkN5YmVVRW5jb0F2UEdRbGJuaTBx?=
 =?utf-8?B?a1JXVG0xQzZxUVEzd2xoMFlac1JhdnZkbXRIbmloZkkrdHRUOHlMelBEZElI?=
 =?utf-8?B?bGU3cnJLRmlnQ2F2bVhGSEIxdnowSGRBV2drMVBOZWM4Rys5S1VMdG8zcm0r?=
 =?utf-8?B?bHd3M1pEVDJ0Y3JyUTA3TEk5QzY5b0xyY0twbG91dnZjLytjN1pLcE9xV1Qy?=
 =?utf-8?B?RkdCcVFRUWNFVzJ3L1gzLzV5NGhTN2pVa1dIWXlCR3VJU0tydDl2S0F6WnFp?=
 =?utf-8?B?Qm95UEp4UFR1Ym5SNlp4bU5nd0RlM0ZQaG44blBwSjIyOVdaY0pDR1JjaVY5?=
 =?utf-8?B?WGNSRjVKZWxHNDI0bERnWTRqaS9XZ3g2KzVuZ2wxRW40dWJTUW52Ui94WkQ4?=
 =?utf-8?B?Qy9GNHYvSnM2RGkySUg2UVBwZTBObldyNzlrUkxLaFNyUmV3Mk9CVUcrUTVS?=
 =?utf-8?B?MWIyYjdCYUhxL2NzMzlGRVBFV0JVUnFoRUV2TlB0MVpzVjNPUXlNUUNPNTJL?=
 =?utf-8?B?V05SaXFCSVo0ZzgxOHVYSmNhOE9JSzVFZ0JlOHVNa3h0ODhNaVBVQmlxM1Fu?=
 =?utf-8?B?MEZiWjlWS3Q3L3FvSGRmdm52bFYwOGJkVXZYZ21ZbUtBbU9VVWhtMTN4TTVJ?=
 =?utf-8?B?L3N5a3A1T2NSaWgxeXUrbkhhbTVpWTZBVTVSVUROQmxTR0RZalZ0cG5HbmZn?=
 =?utf-8?B?RXRUVGhUeHVPN0JOM2lYbXdLWlhSVktFSkowK2NxL3FXZnBQSXZtSTNpN3pQ?=
 =?utf-8?B?eUR5aDRnWlhwQ1hEZW56elFXbDFkNU5uOCt1SWxMSkNDc3EvdXQ1NmdFVFdH?=
 =?utf-8?B?NVZuYThMNTZHQnNKNTh6RDhGMDdaOTlNdUtGZ05GY2NNck5oT2Rtb1ZsWWE0?=
 =?utf-8?B?NDBFQnlwMFZrZlRReS9MWkYwZmFaMHQ1bkFwTitXZ3BzUnNkRDNBelQ5M0F3?=
 =?utf-8?B?R2RhNDVaeCttVGU1SzcwVGhvSnpVTm1SNVBmZDVQNnJ3TjNnUW1PYkdXQ2ZI?=
 =?utf-8?B?MjQ2YW5ib3RZYW1TRndjOTdtOUkvazlvYnR4dDBJSWRkY2lQbWhTNlA5RUx5?=
 =?utf-8?B?RHRhZnMxVkFOMlVtci9mL01ISTJvOWFkb3c5dlJqWlMxVkFNNmM0c3FJamQ3?=
 =?utf-8?B?cE92MmxHMmlIYjBjVFRidG9SdWNudWpyWUFTWnp1U01LcTRJSlF6KzVkTHcy?=
 =?utf-8?B?QWNjZWNMdzh4c3RwZW4zR0RFR1BDMWhQdW9jdUpuYVJhTitTaER3WThML3dy?=
 =?utf-8?B?WnFEMDZBWUF0N2RYOUFEQ3ZWaHRYa2VqTDFucDN1Yldwd1hCbmZqTDlmTktZ?=
 =?utf-8?B?dWFqRS9sOW0vOFhKd090elNqOTdxM2lwd1lyeFY1TzdwTVlrLzRRWXcvRWZE?=
 =?utf-8?B?bjdXSFRabUt6am04czhZalVsNWt4OUZHNkwxR25qZFNTcjQyODcvV0JjMDdT?=
 =?utf-8?B?QmN2OTYvYWxDUHhZSjNmanYrcmZmYjVXT2p4SWdyNWd1UEJhanJ5SHdWQUZL?=
 =?utf-8?B?QU5rbGtZb0tTZTB3ajdhMGtBWjg3WUxob2svYkg3Y0JBMDdnbHpGMG1USW1p?=
 =?utf-8?B?S0VHQjZoZ05SSGYyL2VXamh0T242YVJxR080aW4vQm1DS0p4YzZuS3lCUFRP?=
 =?utf-8?B?WXJiOElOTVFDSnFsbHNaZDViQmtab3F5M0ZXRWg5cCtEbXBhcHcxV0hKZThp?=
 =?utf-8?B?bUQrdmRKNDhROXV0b0swaTkyOUcyYlpwNDdCdXYvTW4zZWJoR0FwUGhEQjVo?=
 =?utf-8?Q?vy9MypSyzFL/vvX5D/x0vSwABXvr4h5K?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:Diagnostix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 10:29:23.3069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b74fbd-b0bf-4489-1d5e-08dd0ece5c70
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A794.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB2530

QW0gTW9udGFnLCBkZW0gMjUuMTEuMjAyNCB1bSAwOToxOCArMDEwMCBzY2hyaWViIEFuZHJlaiBQ
aWNlajoKPiBOb3QgdXNpbmcgcHVsbC11cCBvbiB0aGUgaG9zdCB3YWtlLXVwIGxpbmUgdHJpZ2dl
cnMgdGhlIHdha2UgdXAKPiBpbW1lZGlhdGVseSBhZnRlciBkZXZpY2UgZW50ZXJzIHN1c3BlbmQu
IEZpeCB0aGlzIGJ5IGVuYWJsaW5nCj4gaW50ZXJuYWwKPiBwdWxsLXVwIGFuZCBzZXR0aW5nIGlu
dGVycnVwdCB0cmlnZ2VyaW5nIG9uIHRoZSBmYWxsaW5nIGVkZ2UuCj4gCj4gU2lnbmVkLW9mZi1i
eTogQW5kcmVqIFBpY2VqIDxhbmRyZWoucGljZWpAbm9yaWsuY29tPgpSZXZpZXdlZC1ieTogVGVy
ZXNhIFJlbW1ldCA8dC5yZW1tZXRAcGh5dGVjLmRlPgoKPiAtLS0KPiDCoGFyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDhtbS1waHlib2FyZC1wb2xpcy1yZGsuZHRzIHwgNCArKy0tCj4g
wqAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+IAo+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tcGh5Ym9hcmQt
cG9saXMtCj4gcmRrLmR0cyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1w
aHlib2FyZC1wb2xpcy1yZGsuZHRzCj4gaW5kZXggNWVhY2JkOTYxMWVlLi4zMWQ1YzU3ZDNjMjQg
MTAwNjQ0Cj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLXBoeWJv
YXJkLXBvbGlzLXJkay5kdHMKPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9p
bXg4bW0tcGh5Ym9hcmQtcG9saXMtcmRrLmR0cwo+IEBAIC0yNTUsNyArMjU1LDcgQEAgYmx1ZXRv
b3RoIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldmljZS13YWtldXAtZ3Bp
b3MgPSA8JmdwaW8yIDggR1BJT19BQ1RJVkVfSElHSD47Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBpbnRlcnJ1cHQtbmFtZXMgPSAiaG9zdC13YWtldXAiOwo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgaW50ZXJydXB0LXBhcmVudCA9IDwmZ3BpbzI+Owo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpbnRlcnJ1cHRzID0gPDkgSVJRX1RZUEVfRURHRV9C
T1RIPjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaW50ZXJydXB0cyA9IDw5IElS
UV9UWVBFX0VER0VfRkFMTElORz47Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBt
YXgtc3BlZWQgPSA8MjAwMDAwMD47Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBw
aW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcGluY3RybC0wID0gPCZwaW5jdHJsX2J0PjsKPiBAQCAtMzMyLDcgKzMzMiw3IEBAIHBpbmN0
cmxfYnQ6IGJ0Z3JwIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZzbCxwaW5z
ID0gPAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoE1Y
OE1NX0lPTVVYQ19TRDFfREFUQTRfR1BJTzJfSU82wqDCoMKgwqDCoMKgwqDCoDB4MDAKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBNWDhNTV9JT01VWENf
U0QxX0RBVEE2X0dQSU8yX0lPOMKgwqDCoMKgwqDCoMKgwqAweDAwCj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBNWDhNTV9JT01VWENfU0QxX0RBVEE3X0dQ
SU8yX0lPOcKgwqDCoMKgwqDCoMKgwqAweDAwCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBNWDhNTV9JT01VWENfU0QxX0RBVEE3X0dQSU8yX0lPOcKgwqDC
oMKgwqDCoMKgwqAweDE0MAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPjsKPiDC
oMKgwqDCoMKgwqDCoMKgfTsKPiDCoAoKLS0gClBIWVRFQyBNZXNzdGVjaG5payBHbWJIIHwgQmFy
Y2Vsb25hLUFsbGVlIDEgfCA1NTEyOSBNYWlueiwgR2VybWFueQoKR2VzY2jDpGZ0c2bDvGhyZXI6
IERpcGwuLUluZy4gTWljaGFlbCBNaXRlemtpLCBEaXBsLi1JbmcuIEJvZG8gSHViZXIsCkRpcGwu
LUluZy4gKEZIKSBNYXJrdXMgTGlja2VzIHwgSGFuZGVsc3JlZ2lzdGVyIE1haW56IEhSQiA0NjU2
IHwKRmluYW56YW10IE1haW56IHwgU3QuTnIuIDI2LzY2NS8wMDYwOCwgREUgMTQ5MDU5ODU1Cg==

