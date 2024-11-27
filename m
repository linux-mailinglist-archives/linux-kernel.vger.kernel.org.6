Return-Path: <linux-kernel+bounces-423318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5539B9DA5C2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA2D116559D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CC519885F;
	Wed, 27 Nov 2024 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="Gi2h02rI"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2133.outbound.protection.outlook.com [40.107.20.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA02155389;
	Wed, 27 Nov 2024 10:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732703428; cv=fail; b=ev7KE9T4NJjh3Epn9Mb2BmPNc/blDnbWPsdD/iRuSX+C/xxA6qAlN4yOjg+jIMUielaqShs6KK1RGqYZ85mySreQhdEOD7U23cTkqhj5Vhg2/dQXpUEXayPxii1j0ZlJ/TWgtakgaBymGi7IFWgMy7WICByeAePFTY77SYhT6LM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732703428; c=relaxed/simple;
	bh=qBe+mPz0CUvgfwOaKdjLuY5T6pq37sp5W7pb3eGN9Ks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BEE6NbFh530B5zzyJeKL9hfL62czJgwKE/kVHXOC7382itasU/2/cCOEiYG+UeoC2Rrr3ksXDgPEfQ1Ou4v+4m0wmFA84K5SKVudb3StxBi9y3QdL5+g2Qfi7myB8hKvMCyZZ65JU50UPXIUcreIjsyNcBmHutiEd1yyzw7lCbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b=Gi2h02rI; arc=fail smtp.client-ip=40.107.20.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKmF6yDT+FDDMRc8QI5cN5RCtA5nKt5lyFYNHL/gnrdvzXeqtAV8dXGweO2PFXOkYd2N/XjxyRU3JoqD+FAv2Iur/QFRh2nEjvnyj8VedLUTXfJQ163tT46lB7EnI3kxAR6JqNEM/gw34MO0/oIXuaob8nenJb9XsCZJET2nHy2vmrAxoLOSq69eBaOJSK9aDBMwm2SPIyqTG8cZfiYeEsLQ3hOxkl/m5E3RrOTIwPK6OrFaujgHaszPk8aSNghbty/k84XBWgcIbPQYaVNZNUb1V76qlc1vtquhzgKljh+X3yslUpNHE82co8fMV2BQowadjGL4uvg2C1Xi/Q80dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBe+mPz0CUvgfwOaKdjLuY5T6pq37sp5W7pb3eGN9Ks=;
 b=FVTHJqW2mWIsN9Z/AGTPqgEvc7pZ/8GQ5/ng5eioD47lT3+oavIenoalnlT+5yiagyv5FyqteK6DQbglfVkIFESrUl1Kv14jREjVuG2NIV1B9UTBtuuVwKmDlyvOZBDlJulWtIsDc+QCDxrAArZ0DGOiE2FSaUrYHFokHtn0IeaxdwPlm+W4JrnQYFeKOh0L5MMW6Ro8n+bwHd9gTqRP+EK2qKheYOAivFknuqvasoSNdIeQpBQ/Q97wfd87kds7rBw1MCgy0tSP/yWGSe1cqpZn0IAcpAerd1R3uw9zjlm9x0ceoyOEbufyspDp6Y5GLNjChZ4biLgUVCcbK5dHNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBe+mPz0CUvgfwOaKdjLuY5T6pq37sp5W7pb3eGN9Ks=;
 b=Gi2h02rIfJ+HOQMCWmN9/FeqAWUYu0tuMSXkG89kzA8z/mZvHYKQQvQM6OSD2/CMF1ZfiHGvB46+mnBvkAUrqg4oRTNclC6xYtqQCwTyhDNoS2rASFsLR/wCFktw5cintSMR6sIi129Y4AiDWiRdnFSl92i443QGvGfgAQUsbgk=
Received: from AS4PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:20b:5d4::6)
 by AS1P195MB1496.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 10:30:18 +0000
Received: from AM3PEPF0000A78E.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d4:cafe::ec) by AS4PR09CA0018.outlook.office365.com
 (2603:10a6:20b:5d4::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.13 via Frontend Transport; Wed,
 27 Nov 2024 10:30:18 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF0000A78E.mail.protection.outlook.com (10.167.16.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Wed, 27 Nov 2024 10:30:18 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 27 Nov
 2024 11:30:18 +0100
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 27 Nov
 2024 11:30:17 +0100
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Wed, 27 Nov 2024 11:30:17 +0100
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
Subject: Re: [Upstream] [PATCH 07/15] arm64: dts: imx8mm-phyboard-polis: Set
 RTC as wakeup-source
Thread-Topic: [Upstream] [PATCH 07/15] arm64: dts: imx8mm-phyboard-polis: Set
 RTC as wakeup-source
Thread-Index: AQHbQLdaUPreLA4UMUeG1kkKOoGd8w==
Date: Wed, 27 Nov 2024 10:30:17 +0000
Message-ID: <2eb71fb0b8ea582ae71525d4c0ec09fad6c776d1.camel@phytec.de>
References: <20241125081814.397352-1-andrej.picej@norik.com>
	 <20241125081814.397352-8-andrej.picej@norik.com>
In-Reply-To: <20241125081814.397352-8-andrej.picej@norik.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0091481EB22104A915C07F695AA40DE@phytec.de>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A78E:EE_|AS1P195MB1496:EE_
X-MS-Office365-Filtering-Correlation-Id: cf86715e-e418-41ef-7a50-08dd0ece7d59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RENKSWFlVitqVEpsRFJzQk5HMUdvamQ5Z1VSSGVYbTBCaUh0bGQ3T2JiWDlO?=
 =?utf-8?B?NktGY0dlRGpmNXU2MkVKYkpLZm5CY2JNbzBQbEJHdkNVNjVnMWJQb0dOVjlR?=
 =?utf-8?B?Ti9sTTFJaXdIbGt2Z2ZyVnAzRjl6b3JjOUltNER6NXFFS2swV2xNN3FiclJR?=
 =?utf-8?B?MlNkZVo2Z1pLU25KUTRWa3NobHJzd01Ob1dUZjVJeXkwL0JIWkpBckV0VjBp?=
 =?utf-8?B?TU9iVXExSGR1SlpwSjdTN05RVjBvOXRNYWQzN2F4bzcwc0FtUzZlL0E5YXBG?=
 =?utf-8?B?Umkzb2dodC96MDlUSnEyTUZzekdnVkk3eDFmc2xhSDFYVXQ1aWYxSzl4UE9E?=
 =?utf-8?B?NXdURWRQWVJLTTJTRlZTa29vMkNLNDJCWTJvTVVHVFBJUHB1RHoxVGc5akgy?=
 =?utf-8?B?UjB2MW82M3lLUk1rejJML2gwOFVJN3Vnai9NV2h4UWt5MmxaYXBrbzV1a2lk?=
 =?utf-8?B?WTJTZ29ZeXRTRnZkckY5MjZrRDFkYlBIaHNIZWNEdWpzT2ZYZDZERG9NeFdo?=
 =?utf-8?B?YUJ2Y2hyOHJIQ0ZwTmtMWXB5L2ZuRURnUjlHdkk4NnZIV2p4NmtkbDdtQ2lP?=
 =?utf-8?B?TGkzUk5xV09ES3RUbUx6WEI1RFExSm1CMzBkK2ZtNC9WTTZ0N0FJUXdMaWZQ?=
 =?utf-8?B?WmdRTFVCUlp0TGVZWjhJRkxjb1k2VnpiUnNTRzFDYnpGUndFM2RtWkltZ0VY?=
 =?utf-8?B?TWFFQytYTGU1U3hZQUU5SEZTQXlvcEZsSGYrNDBQcnhjMjA1bVNMNVJ0RTVa?=
 =?utf-8?B?cFZyY2RtbDRWTEo1cyt4MWRXclZhcGdZVjJoMkFyTi91c004c0oyWURQMWQv?=
 =?utf-8?B?V1lBUEZqcXpkZnNvYXFmYTBydERMUWdabTRjTDR3WjZZeVJuMTVpNGRDM1JU?=
 =?utf-8?B?TFVvOTk1OHMvaEgwbGxEdTNwVW41UWhTbDdaeGFKaTFvOCtwT0I2K0IyUFVy?=
 =?utf-8?B?ZUVzU2FNczM5eHRBUUpNMVRkZ2V3c2hnUkRxNnJoUjJOY2FvSHZrL0Y5MmZP?=
 =?utf-8?B?MWpYaEs1dmk4UlJOV3J1U2dNdzZKdXJWQjh6YmFMa05vN2tMUjYzYmV1U1Av?=
 =?utf-8?B?aXE4b2Q4eGlpNXpuMjFwVGlRb0llMnY4eW8zVDA1VDVqakc3U3BjT09sTUcz?=
 =?utf-8?B?QjRYVjVnTklla3hHenRWZTdiZGhJTGpIQnZQdUZQb291aVhPbXBEVWtlTGlB?=
 =?utf-8?B?TUcvVDhFQlBucnd1Z0FXTnlCVlMramtiY2IxdEI1eWwwNkI5NjNzUVB4OGVU?=
 =?utf-8?B?OEw4V0RnVlBROElxQTg3NVkrTFdUZlBaWGQzV2hqSCtWRzdaaGlQbWcycTJY?=
 =?utf-8?B?UjVJbDU4ZFhEZ09WM2tvdmRobURjQ3ZmeEE0UEtuQkxkZnNYaFNpSVh3c2VN?=
 =?utf-8?B?VFpTLzFUWHdDV05QZXd0SjA0TzVKN3dCQTE3TFAzcVU3N0pwMkoyNG1TZkJ3?=
 =?utf-8?B?SGNnK0VlQnhpNFlmV2JvYjZnYXNiZDFuc2R2QzVxMGgybzk1MnJDeUZKTmY0?=
 =?utf-8?B?QmIySUcyZ3o5ZzB1K2gvYWdLWFVWdWZRZVE2US84QlhjSEJoYzkvMlR1UDBE?=
 =?utf-8?B?YUdhMWhZNXNZeWt2S09ZMU4zZldvTlJoM1VVSmxWaUdSdGtKOWlLTWJZY1dq?=
 =?utf-8?B?elJyTHVKbjlKSmE4K2Y0VnhHOUg0L0xKZ1hjTVZucDhuYnNlUTNGOHAvOVdE?=
 =?utf-8?B?WVJXUzdkZE4xQUxBL3FhUmY1YVYyTDZFUmZYYzBHcEhBVFExMlhBSVl0ZjV2?=
 =?utf-8?B?cGF0SzlhUWc1bUNOYWg3RXNHNkNuV1RaNHFGWDQ0ZEs1bUs5bmhZNHY3aTAz?=
 =?utf-8?B?WUd5VXZwTnpGRlVYdmdpS3ZkNk9SVmpOOEdDeUdsN3g1WDdBKzNSUWtKL1lS?=
 =?utf-8?B?Y3hmcThmYkFONy9hTDFxK3kwcHAwbUtwOFdFYmxRcG5tU0gwNGgvOWtaKzd4?=
 =?utf-8?Q?s0DX7hEQRst0wbtrx0WA9z46enu4FZUn?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:Diagnostix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 10:30:18.5077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf86715e-e418-41ef-7a50-08dd0ece7d59
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A78E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1P195MB1496

QW0gTW9udGFnLCBkZW0gMjUuMTEuMjAyNCB1bSAwOToxOCArMDEwMCBzY2hyaWViIEFuZHJlaiBQ
aWNlajoNCj4gUlYtMzAyOCBSVEMgY2FuIGJlIHVzZWQgdG8gd2FrZXVwIHRoZSBzeXN0ZW0gb24g
cGh5Qk9BUkQtUG9saXMtDQo+IGkuTVg4TU0sDQo+IG1hcmsgdGhlIGRldmljZSBhcyB3YWtldXAg
c291cmNlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5kcmVqIFBpY2VqIDxhbmRyZWoucGljZWpA
bm9yaWsuY29tPg0KUmV2aWV3ZWQtYnk6IFRlcmVzYSBSZW1tZXQgPHQucmVtbWV0QHBoeXRlYy5k
ZT4NCg0KPiAtLS0NCj4gwqBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tcGh5
Ym9hcmQtcG9saXMtcmRrLmR0cyB8IDEgKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lt
eDhtbS1waHlib2FyZC1wb2xpcy0NCj4gcmRrLmR0cyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2lteDhtbS1waHlib2FyZC1wb2xpcy1yZGsuZHRzDQo+IGluZGV4IDZjOTUyNTcxMTlk
Ni4uN2FhZjcwNWM3ZTQ3IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9pbXg4bW0tcGh5Ym9hcmQtcG9saXMtcmRrLmR0cw0KPiArKysgYi9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tcGh5Ym9hcmQtcG9saXMtcmRrLmR0cw0KPiBAQCAtMjIz
LDYgKzIyMyw3IEBAICZwY2llX3BoeSB7DQo+IMKgJnJ2MzAyOCB7DQo+IMKgwqDCoMKgwqDCoMKg
wqBhdXgtdm9sdGFnZS1jaGFyZ2VhYmxlID0gPDE+Ow0KPiDCoMKgwqDCoMKgwqDCoMKgdHJpY2ts
ZS1yZXNpc3Rvci1vaG1zID0gPDMwMDA+Ow0KPiArwqDCoMKgwqDCoMKgwqB3YWtldXAtc291cmNl
Ow0KPiDCoH07DQo+IMKgDQo+IMKgJnNudnNfcHdya2V5IHsNCg0KLS0gDQpQSFlURUMgTWVzc3Rl
Y2huaWsgR21iSCB8IEJhcmNlbG9uYS1BbGxlZSAxIHwgNTUxMjkgTWFpbnosIEdlcm1hbnkNCg0K
R2VzY2jDpGZ0c2bDvGhyZXI6IERpcGwuLUluZy4gTWljaGFlbCBNaXRlemtpLCBEaXBsLi1Jbmcu
IEJvZG8gSHViZXIsDQpEaXBsLi1JbmcuIChGSCkgTWFya3VzIExpY2tlcyB8IEhhbmRlbHNyZWdp
c3RlciBNYWlueiBIUkIgNDY1NiB8DQpGaW5hbnphbXQgTWFpbnogfCBTdC5Oci4gMjYvNjY1LzAw
NjA4LCBERSAxNDkwNTk4NTUNCg==

