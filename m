Return-Path: <linux-kernel+bounces-423320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9589DA5CB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D3012828BD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BB3197A7C;
	Wed, 27 Nov 2024 10:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="Sl+hXjI6"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2122.outbound.protection.outlook.com [40.107.103.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875D818E0E;
	Wed, 27 Nov 2024 10:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732703466; cv=fail; b=mob20HebXR5dSRZG9MayUkiGVSrxwnAB67vixQAcx7MahvfoefXAxTOSGmz3YgUB8vDQjUQY5VLo7W7QOUUip6QnXPLupxRQFFnVLfxwM1DktXjilki5kQze8KQfbMztw7oOIr/5bp2SAq0IIHt38n1gelvn9ZUQqQ1/LG9SzdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732703466; c=relaxed/simple;
	bh=Qy+dhxen4yTDiMlNJFaLvtpC+ptnmxqLd3TMuA71ME8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uSGSm+fZHdEVSqWo5CMtHYKc95d+HLcBJI0EOdhoUm5pCmz1z/UD7ndpNKRNMpMqdQgrU9zvYvnkkHB8Y/NSeVQrKk3XiuMnjkELzxgCHId37PQGrLJ4xd5XDCUR9O5cvUfdEn51EkkRy6sK3XHHermwjkmOX/IsLFxNTCyaoLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b=Sl+hXjI6; arc=fail smtp.client-ip=40.107.103.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HuFLJ+kXT0AnFM7bcBdvfl5PinTxwxn0QqGw5Yz+7qQ0SRjB1gR7+g8Mo1nWVZc+cGyHIi9XTlWCo4DvTbqIWlKXpfruwGbOSuckucvkBR+6hK9iraeYppuC+e8VE/VIKcX3wBToJtXr8g0+FBE8T07IQFWop+noFRLEfP9ZXna6osERUzgOcQm1KaUUxIkUWqzfUWJxEoiythVnFU7YihZnq4Jz402QsOJS/HiT7TyINCYmyEIozQWqm0X+ra6zPdoYN0KBAAtFjobYYqX/XblMjzNzO8D2+dHMA0oXHObM/OdnbIrNcxEKM6m76k4PlcIvglNqxn4TrJH7ybM2fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qy+dhxen4yTDiMlNJFaLvtpC+ptnmxqLd3TMuA71ME8=;
 b=L3875mNg3P9wqd2nuYmkTrdwy9U4lpEj5qUoVoTfJoF/9/YvN8qi56aGkBv6Z8YJmsLtGrmQC1xDAGWZ5zBKqZ9kSv+PFtXzwTQk60H+NoZEp0uisnxSxlIMrPLldD6x/yDciLbWbo0vmwzD9e7H2XJu04ZgOMZLPrlHnov+6Asv6N76Vff++qPv16UDpJgJPdUQ45E+6Ef5FM8P+uFJekQml6BPFL8rV7oYtsxUXG1L/Dq8YF+sOK44r9Z10ohzchYf0GXAxznQj9jRpWfSMeLmxwN3CraTSx9NDyIHvPFFkT8CTKzH8lF3tzgfPS0itfRO0cpTDkJCcLZLlRBhIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qy+dhxen4yTDiMlNJFaLvtpC+ptnmxqLd3TMuA71ME8=;
 b=Sl+hXjI6rPYt2MAcNXvj10ygGPS65+g3GnA+I01KGWEj0dJheDguz4vQbmNhyYs57HGJiNsaIDS2v9LF+CqNS9oG5gqCOm+Z5Kdhe2OCHZ2uOsN5oBZg3KOanwhLIqlqUKGCYYGA4DOxL0C/zrZR7LWhuQHkQ62SITaw7mv4sIQ=
Received: from AS9PR05CA0309.eurprd05.prod.outlook.com (2603:10a6:20b:491::12)
 by AS8P195MB1655.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:523::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Wed, 27 Nov
 2024 10:30:59 +0000
Received: from AM3PEPF0000A793.eurprd04.prod.outlook.com
 (2603:10a6:20b:491:cafe::47) by AS9PR05CA0309.outlook.office365.com
 (2603:10a6:20b:491::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.13 via Frontend Transport; Wed,
 27 Nov 2024 10:30:59 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF0000A793.mail.protection.outlook.com (10.167.16.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Wed, 27 Nov 2024 10:30:59 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 27 Nov
 2024 11:30:59 +0100
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 27 Nov
 2024 11:30:58 +0100
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Wed, 27 Nov 2024 11:30:58 +0100
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
Subject: Re: [Upstream] [PATCH 08/15] arm64: dts: imx8mm-phygate-tauri-l: Set
 RTC as wakeup-source
Thread-Topic: [Upstream] [PATCH 08/15] arm64: dts: imx8mm-phygate-tauri-l: Set
 RTC as wakeup-source
Thread-Index: AQHbQLdyhaCmK/71Y0i8+RCXR/gehQ==
Date: Wed, 27 Nov 2024 10:30:58 +0000
Message-ID: <372ed3850b41fdca1b985c0fc7b778e8a3007dae.camel@phytec.de>
References: <20241125081814.397352-1-andrej.picej@norik.com>
	 <20241125081814.397352-9-andrej.picej@norik.com>
In-Reply-To: <20241125081814.397352-9-andrej.picej@norik.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <058998BF6D9F1341842411D02646D600@phytec.de>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A793:EE_|AS8P195MB1655:EE_
X-MS-Office365-Filtering-Correlation-Id: 651928a7-045a-4dc3-6534-08dd0ece95d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjQ2NkpxZFFENzJ5UWxiQ2NLV3kyNzFvWTYwa2hyWnZpRWJkU3A0V3pQQ0pU?=
 =?utf-8?B?QkQ2REFzQ3Rxd1grMy9YampNYjBha3llNTBMRytvMnlmUDUvQmJzZjVIRVll?=
 =?utf-8?B?aDEva3pRWWJoa1lCMTgrd1lRWk4wZlZTMGF5SGdKa2poSk1hd0tMOW1uVmxC?=
 =?utf-8?B?TEtjS1FRc2h0V1p3bHIrYzEyRDJzV3pNeExNbVZBWjUwdE9kbjR1bUpRbXQ4?=
 =?utf-8?B?RDl0UlpZcEVJL1lRcnVmL1pScDZrZFVMWGNZS2N3S253TW9tQ3RTZmI5OExY?=
 =?utf-8?B?VzJTZGhUNTRWeFl1ZENJZEhlM1ZSekRJQndNVVgweGtSbFNGZG5RRTNqS2RW?=
 =?utf-8?B?UEhtNFRIV2Q2T2NTNDkvVThqMGIwUmlDTmZFZWZGR1I5b0VHMGJiVGM5N3pz?=
 =?utf-8?B?T2d5U1dYVStOdGppYzV2SlU2cmlLbWlGajVZWk5ZV1dneVpucVBmMTM4U2o0?=
 =?utf-8?B?ZDd5TnN3T1N2eWw5S3E0YkdwUHlucFVOZFNMeDBmb01qUlRZMUdZa3FJRFND?=
 =?utf-8?B?aWFhZG5Uc1g1d1MxRm1xa3lsWm1QRFIzWXFhNWxPdk05Z3VGcFVqWFVHci9m?=
 =?utf-8?B?S3lQVzZkWnhJYzRMM0lDcTZhWmNYTzdxSG1RdnlIVmhTWGlWYnNCNmZHNXlF?=
 =?utf-8?B?bUNQSTV0Rlk3VklBd3VzZmdrRlpaalpMTFZzUldXTFBXRGlwSDdCZjk5cE9G?=
 =?utf-8?B?YVM2SGV0eCtVOXU3R1lJK09taHJSb1B0Z2UvSE9oWXR1Qm5BWUxsLzQ0cHBz?=
 =?utf-8?B?YnRJVzQ1Y0pLMjZVN0pjZ1c2VkVobkhPMmEvSE50OHRNMFYvaTY3dGVERFlX?=
 =?utf-8?B?cUNTQXAzNmMwT0hYSjliK2hoeG52M2FUL1lzT3ByL01Sd3d6ZUFSTTRoc3h0?=
 =?utf-8?B?ZWJsWXdXTURhakRyVmUzblVoMENqMFRlUmJadUFGdTNFN25qQysxaXFURFBR?=
 =?utf-8?B?MFNPNjNzK0QyOXd1NTkwZ0tvZnVNdTh2dHBmNjVZTXdmS1F2OVlnazBhakVT?=
 =?utf-8?B?MFNEYWN0dHVtL2JFdklRYUdtODNJTERVMElld05DRGg4eHBsbjRrT0RjNEg4?=
 =?utf-8?B?NHBaSkJOdXhhL05GOW9WNFYvYW9KTEdHcDJjSWk3YXRTeTlBUkRVUzhzV0s1?=
 =?utf-8?B?bVZ4eVZkdVYrV21mSmx3L1FYVkcwRzVlL1FLUmNHWFJkNnhSUjdwVzB6TTNU?=
 =?utf-8?B?UVVIMzRmS3lLRW9mOEJZeUxBWE5UWnZvWExtaDNpUnFqUndybWhPS3hWeXNX?=
 =?utf-8?B?bXpnYytiVnNTVVZBTkpONEpQSDFjUStJVzlzdlRWdXFGZXlUeWFLOGJ3MWhv?=
 =?utf-8?B?QUtxY1BmL3g3NWdPNEVWNjZLWGhuT01oZTJnQWpTVlI3a0hOdHJscVpBa0My?=
 =?utf-8?B?aG9PamMyd01DRzNqZ2p4eDM2YlhOUnJFTFNrZUlNZ1RHZi9MOVdGVDF6NExn?=
 =?utf-8?B?UFExV3pnWVRLV2hoWG8wazdKdzJxSzkrSnVkRHFEZU1iTDFxWWJoQ0RwcGVj?=
 =?utf-8?B?aVFjRzZXUmUybzFMOHhDREh4eklQbzNzNjQyTWV2akFqeG9pdU9KbkVsVlJa?=
 =?utf-8?B?WGlkWlVDa2Z5K2Q3RXVJTTFGVGlMMDRvTVEyKzJpS05hRWFWakkwUy9sY0po?=
 =?utf-8?B?OTgxN293Uk04SCtrSGtPanAwVXBOVU91YTN4UHVjRVY5a3d2ZmZOQ2FvMXp2?=
 =?utf-8?B?UFJYblN4OTJDN1pncTNlcnJaQzhRdWNyVTJ6d3NiWmxkZ1I3MjR3cVpQY3hl?=
 =?utf-8?B?c3ZyemNqMlNwRmR0cGVxTkhwTlJhZVplWmVlQkFmazlGck5RbURWdUZJeTM2?=
 =?utf-8?B?V1hmdXRKbFNaazZXQUxMdnlzai94d3ZmeWsybDdYaXU3dk9ycWE1dDB6VGZQ?=
 =?utf-8?B?NEplb3B3a2xVM3haRXVMVVZJdzR2TExxZGVVMjUxWnlzbWR0SDJreG5zNms0?=
 =?utf-8?Q?dbm+vQ77TA+rQNGgn+pAM3ErDZeCxSBe?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:Diagnostix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 10:30:59.5811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 651928a7-045a-4dc3-6534-08dd0ece95d2
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1655

QW0gTW9udGFnLCBkZW0gMjUuMTEuMjAyNCB1bSAwOToxOCArMDEwMCBzY2hyaWViIEFuZHJlaiBQ
aWNlajoNCj4gUlYtMzAyOCBSVEMgY2FuIGJlIHVzZWQgdG8gd2FrZXVwIHRoZSBzeXN0ZW0gb24g
cGh5R0FURS1UYXVyaS1MLQ0KPiBpLk1YOE1NLA0KPiBtYXJrIHRoZSBkZXZpY2UgYXMgd2FrZXVw
IHNvdXJjZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZHJlaiBQaWNlaiA8YW5kcmVqLnBpY2Vq
QG5vcmlrLmNvbT4NClJldmlld2VkLWJ5OiBUZXJlc2EgUmVtbWV0IDx0LnJlbW1ldEBwaHl0ZWMu
ZGU+DQoNCj4gLS0tDQo+IMKgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLXBo
eWdhdGUtdGF1cmktbC5kdHMgfCAxICsNCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4
bW0tcGh5Z2F0ZS10YXVyaS1sLmR0cw0KPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2lteDhtbS1waHlnYXRlLXRhdXJpLWwuZHRzDQo+IGluZGV4IGMzODM1YjJkODYwYS4uYzliZjRh
YzI1NGJiIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4
bW0tcGh5Z2F0ZS10YXVyaS1sLmR0cw0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9pbXg4bW0tcGh5Z2F0ZS10YXVyaS1sLmR0cw0KPiBAQCAtMjE3LDYgKzIxNyw3IEBAICZw
d200IHsNCj4gwqAmcnYzMDI4IHsNCj4gwqDCoMKgwqDCoMKgwqDCoGF1eC12b2x0YWdlLWNoYXJn
ZWFibGUgPSA8MT47DQo+IMKgwqDCoMKgwqDCoMKgwqB0cmlja2xlLXJlc2lzdG9yLW9obXMgPSA8
MzAwMD47DQo+ICvCoMKgwqDCoMKgwqDCoHdha2V1cC1zb3VyY2U7DQo+IMKgfTsNCj4gwqANCj4g
wqAmdWFydDEgew0KDQotLSANClBIWVRFQyBNZXNzdGVjaG5payBHbWJIIHwgQmFyY2Vsb25hLUFs
bGVlIDEgfCA1NTEyOSBNYWlueiwgR2VybWFueQ0KDQpHZXNjaMOkZnRzZsO8aHJlcjogRGlwbC4t
SW5nLiBNaWNoYWVsIE1pdGV6a2ksIERpcGwuLUluZy4gQm9kbyBIdWJlciwNCkRpcGwuLUluZy4g
KEZIKSBNYXJrdXMgTGlja2VzIHwgSGFuZGVsc3JlZ2lzdGVyIE1haW56IEhSQiA0NjU2IHwNCkZp
bmFuemFtdCBNYWlueiB8IFN0Lk5yLiAyNi82NjUvMDA2MDgsIERFIDE0OTA1OTg1NQ0K

