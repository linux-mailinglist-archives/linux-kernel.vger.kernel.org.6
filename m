Return-Path: <linux-kernel+bounces-423329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4679DA5DD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B364280F8B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB0C198825;
	Wed, 27 Nov 2024 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="PHOzXDV7"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2096.outbound.protection.outlook.com [40.107.247.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185B2155389;
	Wed, 27 Nov 2024 10:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732703670; cv=fail; b=t8fnUJwX0OG4ueEM5NyE5AkuU0/Ib8LG94dGTgyw6ttlBIJSt+oQEazYNkq0Z/0Jtqb7ouadKvwdjxOrvVf9uPizXn0PWCIOzlhuzhIqC79yeqAx3IBNah0ndABvTgq/rJ7xYx8HQWRqYBzuzqyk8PkvKFP22oHwd47IgaNPlQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732703670; c=relaxed/simple;
	bh=9DXyYO85vNEPVun2ol6SPIhvxU4OFn302vQLJCcuYKM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XaaBGXzUhTWsjimtFmVuKLa8kOERUwhkru9TbdcwnpglbCYurZiCwSBOfPMQ2avGxgUEdp1C3a4F3x8CEllrZjvbs+O7hLf0z2edUjZ+tr9YWcSWBmGokqrlZ1EeKqzkN90UALbE3DsMvaB+dLNKiH3QkaxniMIXlAXjENYvPGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b=PHOzXDV7; arc=fail smtp.client-ip=40.107.247.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJkNHaXngUwQymzttKatmIkFofb238IFELr4XAbWHuy+N5UfQ5qcdY+W0K3AMSQ825zTBgAv276LDyALctcJGxuGooO+oNKMMYudd6sxY0pm9vnmz1O9z/lvde+EWZaLdjduE9RfKvat8LT2Y/U7m5sEZDYbBkNucGKyeZLqFq8gDiaGwkgKlp+91SiODKb2T3A3bTbzOOkjZTQEXxZazlkojbNjZXTFNQBc2NYddyRRZsP4/3Rsowtul0sKyFTKu8jZXO6Iz3N/AZRB+WSpTIDDSXuBU5VmWgkFmvaLEXnY0YekBOMtFlU41zdYehMUuzDC2qqjLWxIq5OW/9NUjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DXyYO85vNEPVun2ol6SPIhvxU4OFn302vQLJCcuYKM=;
 b=IEme9TNqHouA3iLGKqwL/J7LxNqpX8/eS5LvQPNch00eVHNFGQ0Nut8Ngkr4aQi0Hz+FZe9KjQb6/J/+3yW1jqFH7hdcC6bH+RhXIjHnUHiLBjdZOvvX/cHD3CHtpy2Svy3Jvquv5QsGERYcgWnxT93f2sb/76vcVnv8KBVoMFztizQUBaHkSnAkBHRZVyTWR/2q2eQmPiafXPQTBRwS9LZ1zA8hly+OPM5gTRrMt1NxbWva5aAcJsGvg06cMrEFgXlWZ7sYuGyWaTcF+IQlzGnCqQSAvBfsn000ocIOBgo9ZgmWMgUR//g0M1cGY9seZer7FnHi+FNM7v1fZFun/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DXyYO85vNEPVun2ol6SPIhvxU4OFn302vQLJCcuYKM=;
 b=PHOzXDV71Z6Mq+zuPjTkz2weaeAH4RaRX9x2x42ryZvjt9CB7PwhfeGrMl2G5dnmPQ6+eEJ7ibpjVf6tXT2w/tZV0OiZfEanCVkn/PevXsKNcgxOKsQo9+IHmCXSiP94izVI8wuWyYKG5xkuV5FdTbE74OIIqtNqXv80CDuvrBg=
Received: from AS4PR09CA0004.eurprd09.prod.outlook.com (2603:10a6:20b:5e0::10)
 by DB8P195MB0647.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:15e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Wed, 27 Nov
 2024 10:34:21 +0000
Received: from AM3PEPF0000A78E.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e0:cafe::80) by AS4PR09CA0004.outlook.office365.com
 (2603:10a6:20b:5e0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.21 via Frontend Transport; Wed,
 27 Nov 2024 10:34:21 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF0000A78E.mail.protection.outlook.com (10.167.16.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Wed, 27 Nov 2024 10:34:21 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 27 Nov
 2024 11:34:21 +0100
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 27 Nov
 2024 11:34:20 +0100
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Wed, 27 Nov 2024 11:34:20 +0100
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
Subject: Re: [Upstream] [PATCH 09/15] arm64: dts: imx8mm: move bulk of rtc
 properties to carrierboards
Thread-Topic: [Upstream] [PATCH 09/15] arm64: dts: imx8mm: move bulk of rtc
 properties to carrierboards
Thread-Index: AQHbQLfregM3vA0FpE+zcnaGsHT4ZQ==
Date: Wed, 27 Nov 2024 10:34:20 +0000
Message-ID: <67e55b1f18f2a676b890c9a4133575e8b90f6019.camel@phytec.de>
References: <20241125081814.397352-1-andrej.picej@norik.com>
	 <20241125081814.397352-10-andrej.picej@norik.com>
In-Reply-To: <20241125081814.397352-10-andrej.picej@norik.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <085E60527F312C49AC3B060C855C54CE@phytec.de>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A78E:EE_|DB8P195MB0647:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fc96ead-dce6-4eda-11ae-08dd0ecf0e0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEVRdHRqVXVSQkNIZUZCL0FKbWtiMit2OGtIRG9CRlpnV0VQL2NUYVlxRmhp?=
 =?utf-8?B?bmoydEsrM3ZoNE90dmNWNlZDYTJkaUkrd09uODBqZHRoUTFmUkU0OWFvc3VP?=
 =?utf-8?B?SklBZ3djSGFsUzBlZFJQejlYS2dHaXkvcWVxbFNrcUlITC9RY1ArREsrR1pn?=
 =?utf-8?B?c25yc0RIeUoyZXVhVFZyYU1rVlBWa0d5Q1MrMFdRQWp3dXlUeHhiVDRyTXQ2?=
 =?utf-8?B?c2ludTZuZUFCd0RRVmliYzVqUlB5L25BZW9ndFBrK0VVRms2ZG9CMDY1VHo1?=
 =?utf-8?B?YjZCaVV0VllzeHFUMHlpcmcvL2FxWEwzUnBTdjBpTk9OWXdaenVMZjZxTGIy?=
 =?utf-8?B?aGNjV0ZKZksyeUVRR296SjFkcFNvVElweklqNmJUVGpNNExlSlpVRnA5WnJ6?=
 =?utf-8?B?RGN3WE9Bb2JIWjFxMnc0eXBaa0N3TjI5RFAvYW54Q2RQVVZUTUZQM1NiZlJq?=
 =?utf-8?B?OWhqRk9lbStHSVJURW9rQ2p0VHozMzFqUmJpMytGU1VPRFB5c21QRmlmY3hG?=
 =?utf-8?B?dnZnOS9lbVlQK3RxUFdKUWJPd01xbk5xODNzcGk4c294Um90czhiS1RqM1RK?=
 =?utf-8?B?UUptMDZGaWVsRElGNFZqeTZGbFdSNHVjTnowYVB6cHhtTnRpWklxbUNFVE1q?=
 =?utf-8?B?WW9yRFlCYlJJSEFsdk1DY0xOVHdzNEhlbm9VOG5seDNuSUVRWlpTbkRReTBp?=
 =?utf-8?B?WkUyeG1NVFU0OVI0YkZSVk1RUS90Mm9pRVFVbENreUo4U1h4MG5zM3k0V0o1?=
 =?utf-8?B?N3h2S3BzaXBNNlF5Z09OMGpzQ2F3MUFJV2RpNW0rdmJNZXdmUzBNaWN2cXBS?=
 =?utf-8?B?bU5WdkZiOW05RDc5bDRzUU85b0diUWc1ZGFxbTE1dUwxeWpvYlo2RXduamVh?=
 =?utf-8?B?a0Nxb0F6Q1RIODRyYjdUK1ltejhLTDQ2S2h1WkJFelIvVTVNK09oZjY2aVZ4?=
 =?utf-8?B?UXVIdjBJZVdBbGg2VlQ1MU1UU2NDckFONGxlNnJKZVN2QVpHaFpHZEM0WDFU?=
 =?utf-8?B?VEFJNCtSY3hRMmE5T0lQK0VWMjJaVTZYODB5SzRUM3lFb2ZKd2hBN3lDYmly?=
 =?utf-8?B?c2crd2wrczRETWV6MWFWcnRlVHM1ckgrOUxmZnpUR3FzdUJVbTFabEE1Q2F4?=
 =?utf-8?B?R3piSjVzZEZjbGg4OUViSW42QnlpQWhCdDR4ekVoTTAza012WGpubUJJdUVu?=
 =?utf-8?B?ZFZtT0t6VERLSlVnWW1UVjJZUWg2RkU1bnhaUGd3N0gyMW1ISmFTVGRubmZO?=
 =?utf-8?B?dURYM3UvMG1ETmkxd2tGOE16d0haSjVJYUN5aXhZeHZHUWFydFhzNWdSU25l?=
 =?utf-8?B?b3V2VjZobVR6eVNjcTRwbGkzWXlpMzRrdE53aGhLRTJiQktMWVduajU1TnI2?=
 =?utf-8?B?cG5pUS9iU2R1Qk0zeUMzY0JXVktKS3FWbzl2TUd5MlZoUklZVW4xZmNKcEJJ?=
 =?utf-8?B?aERWbzQ4c3FhZGhMZU15SndKcVFSVWZSQ2ZDYkVQaXhNenprdS96T1dqRHRR?=
 =?utf-8?B?dnBXVityUTdqR0JEUG1UU254NGtkd2dyaVRRVVZ4Z0NsUjV6NDJoRVNhWHFM?=
 =?utf-8?B?NEJYL3BrTHRJY3RuMjM3dERXYy9xbnVZWlo1eHhUL3h3ZU1FeGs2a1F1T2ph?=
 =?utf-8?B?NGt5eFg4ZmxDQXAxVXgrS0FNVCt1bGNzNkJiMmllUUpVQUJRSVNDWEFlZEdu?=
 =?utf-8?B?TkpjblZud3NRQzlkNkxtQ3g2Z0tWalRjYnRFZks5Ung0bjY2bEFiK282ZzhP?=
 =?utf-8?B?UU92YmJaNGRPbkc1Q3lxRTV1STNRWE1CWW51YUNRb21ITkliTUtEOFIrYSs0?=
 =?utf-8?B?cTU0WU9FU3RXRGZWZStTMUh4YWoxb2w2cG5kZkVPZlN1MFlTczBqZ1NGN3V6?=
 =?utf-8?B?bjIvekVCQ3FJYUE5MHY0TnU3TkpKckZGU1lOVkRub3ZmeTdZaXVSMzB4M3k3?=
 =?utf-8?Q?07eOTRmuTdkOMIhKNTXF35WiE8XTx36S?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:Diagnostix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 10:34:21.2922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc96ead-dce6-4eda-11ae-08dd0ecf0e0d
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A78E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P195MB0647

SGVsbG8gQW5kcmVqLA0KDQpBbSBNb250YWcsIGRlbSAyNS4xMS4yMDI0IHVtIDA5OjE4ICswMTAw
IHNjaHJpZWIgQW5kcmVqIFBpY2VqOg0KPiBGcm9tOiBZYW5uaWMgTW9vZyA8eS5tb29nQHBoeXRl
Yy5kZT4NCj4gDQo+IE1vdmUgcHJvcGVydGllcyBmcm9tIFNvTSdzIGR0c2kgdG8gY2FycmllcmJv
YXJkJ3MgZHRzIGFzIHRoZXkgYXJlDQo+IGFjdHVhbGx5IGRlZmluZWQgYnkgdGhlIGNhcnJpZXIg
Ym9hcmQgZGVzaWduLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWWFubmljIE1vb2cgPHkubW9vZ0Bw
aHl0ZWMuZGU+DQo+IFNpZ25lZC1vZmYtYnk6IEFuZHJlaiBQaWNlaiA8YW5kcmVqLnBpY2VqQG5v
cmlrLmNvbT4NCj4gLS0tDQo+IMKgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1t
LXBoeWJvYXJkLXBvbGlzLXJkay5kdHMgfCA0ICsrKysNCj4gwqBhcmNoL2FybTY0L2Jvb3QvZHRz
L2ZyZWVzY2FsZS9pbXg4bW0tcGh5Y29yZS1zb20uZHRzacKgwqDCoMKgwqDCoCB8IDQgLS0tLQ0K
PiDCoGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1waHlnYXRlLXRhdXJpLWwu
ZHRzwqDCoMKgIHwgNCArKysrDQo+IMKgMyBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyks
IDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvaW14OG1tLXBoeWJvYXJkLXBvbGlzLQ0KPiByZGsuZHRzIGIvYXJjaC9hcm02NC9i
b290L2R0cy9mcmVlc2NhbGUvaW14OG1tLXBoeWJvYXJkLXBvbGlzLXJkay5kdHMNCj4gaW5kZXgg
N2FhZjcwNWM3ZTQ3Li5mNWY1MDNjM2M2YjkgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDhtbS1waHlib2FyZC1wb2xpcy1yZGsuZHRzDQo+ICsrKyBiL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1waHlib2FyZC1wb2xpcy1yZGsuZHRz
DQo+IEBAIC0yMjEsNiArMjIxLDEwIEBAICZwY2llX3BoeSB7DQo+IMKgDQo+IMKgLyogUlRDICov
DQo+IMKgJnJ2MzAyOCB7DQo+ICvCoMKgwqDCoMKgwqDCoGludGVycnVwdC1wYXJlbnQgPSA8Jmdw
aW8xPjsNCj4gK8KgwqDCoMKgwqDCoMKgaW50ZXJydXB0cyA9IDwzIElSUV9UWVBFX0xFVkVMX0xP
Vz47DQo+ICvCoMKgwqDCoMKgwqDCoHBpbmN0cmwtMCA9IDwmcGluY3RybF9ydGM+Ow0KDQpZb3Ug
c2hvdWxkIGFsc28gbW92ZSB0aGUgcGluY3RybCBzZXR0aW5ncyB0byB0aGUgY2FycmllciBib2Fy
ZHMuDQpBcyB0aGUgcGluIGNhbiBiZSB1c2VkIGRpZmZlcmVudGx5IGFuZCBzaG91bGQgbm90IGJl
IGRlZmluZWQgYnkgdGhlDQpTb00uDQoNClRoYW5rcywNClRlcmVzYSANCg0KPiArwqDCoMKgwqDC
oMKgwqBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiDCoMKgwqDCoMKgwqDCoMKgYXV4LXZv
bHRhZ2UtY2hhcmdlYWJsZSA9IDwxPjsNCj4gwqDCoMKgwqDCoMKgwqDCoHRyaWNrbGUtcmVzaXN0
b3Itb2htcyA9IDwzMDAwPjsNCj4gwqDCoMKgwqDCoMKgwqDCoHdha2V1cC1zb3VyY2U7DQo+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tcGh5Y29yZS1z
b20uZHRzaQ0KPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1waHljb3Jl
LXNvbS5kdHNpDQo+IGluZGV4IGNjZWQ4MjIyNmM2ZC4uZmRmZTI4NzgwZDZmIDEwMDY0NA0KPiAt
LS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tcGh5Y29yZS1zb20uZHRz
aQ0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tcGh5Y29yZS1z
b20uZHRzaQ0KPiBAQCAtMzAxLDEwICszMDEsNiBAQCBlZXByb21ANTEgew0KPiDCoMKgwqDCoMKg
wqDCoMKgLyogUlRDICovDQo+IMKgwqDCoMKgwqDCoMKgwqBydjMwMjg6IHJ0Y0A1MiB7DQo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29tcGF0aWJsZSA9ICJtaWNyb2NyeXN0YWws
cnYzMDI4IjsNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGludGVycnVwdHMgPSA8
MyBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
aW50ZXJydXB0LXBhcmVudCA9IDwmZ3BpbzE+Ow0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHBpbmN0cmwtMCA9IDwmcGluY3RybF9ydGM+Ow0KPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHJlZyA9IDwweDUyPjsNCj4gwqDCoMKgwqDCoMKgwqDCoH07DQo+IMKg
fTsNCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1w
aHlnYXRlLXRhdXJpLWwuZHRzDQo+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14
OG1tLXBoeWdhdGUtdGF1cmktbC5kdHMNCj4gaW5kZXggYzliZjRhYzI1NGJiLi5iN2IxOGQ1YTRm
NjggMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1w
aHlnYXRlLXRhdXJpLWwuZHRzDQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2lteDhtbS1waHlnYXRlLXRhdXJpLWwuZHRzDQo+IEBAIC0yMTUsNiArMjE1LDEwIEBAICZwd200
IHsNCj4gwqANCj4gwqAvKiBSVEMgKi8NCj4gwqAmcnYzMDI4IHsNCj4gK8KgwqDCoMKgwqDCoMKg
aW50ZXJydXB0LXBhcmVudCA9IDwmZ3BpbzE+Ow0KPiArwqDCoMKgwqDCoMKgwqBpbnRlcnJ1cHRz
ID0gPDMgSVJRX1RZUEVfTEVWRUxfTE9XPjsNCj4gK8KgwqDCoMKgwqDCoMKgcGluY3RybC0wID0g
PCZwaW5jdHJsX3J0Yz47DQo+ICvCoMKgwqDCoMKgwqDCoHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVs
dCI7DQo+IMKgwqDCoMKgwqDCoMKgwqBhdXgtdm9sdGFnZS1jaGFyZ2VhYmxlID0gPDE+Ow0KPiDC
oMKgwqDCoMKgwqDCoMKgdHJpY2tsZS1yZXNpc3Rvci1vaG1zID0gPDMwMDA+Ow0KPiDCoMKgwqDC
oMKgwqDCoMKgd2FrZXVwLXNvdXJjZTsNCg0KLS0gDQpQSFlURUMgTWVzc3RlY2huaWsgR21iSCB8
IEJhcmNlbG9uYS1BbGxlZSAxIHwgNTUxMjkgTWFpbnosIEdlcm1hbnkNCg0KR2VzY2jDpGZ0c2bD
vGhyZXI6IERpcGwuLUluZy4gTWljaGFlbCBNaXRlemtpLCBEaXBsLi1JbmcuIEJvZG8gSHViZXIs
DQpEaXBsLi1JbmcuIChGSCkgTWFya3VzIExpY2tlcyB8IEhhbmRlbHNyZWdpc3RlciBNYWlueiBI
UkIgNDY1NiB8DQpGaW5hbnphbXQgTWFpbnogfCBTdC5Oci4gMjYvNjY1LzAwNjA4LCBERSAxNDkw
NTk4NTUNCg==

