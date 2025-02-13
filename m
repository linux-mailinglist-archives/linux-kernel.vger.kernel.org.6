Return-Path: <linux-kernel+bounces-512602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE18A33B6A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3634B3A6147
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB3420FA9E;
	Thu, 13 Feb 2025 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="K6iYytJ6"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2060.outbound.protection.outlook.com [40.107.105.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880AA20E30A;
	Thu, 13 Feb 2025 09:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739439665; cv=fail; b=X3s5ImorjTTxSlgA8wSsuu302YzwjlGPbZmYGoLKlXOmH988dhWacs9c0mKr82qLWBkFNE9DbmGwYR6wJh+9vqor05NdUacEJoXhUjhhHxfbWAzA0v5CUXO6hLiVxfxcJBpmvpAbm/EK94fPhotMyBod/+wIBX7gVe849OxECAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739439665; c=relaxed/simple;
	bh=kkQmeAdEZq2i+7g1WX1GGAtlORbnl1hxywKAqAyU/U4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ex5i5URctT9Jpj6wkGAuyADV7ltXBJggyjsDl2xH2280murS9j3VZQvbPw+MpXoBP+3qMdOnpmKlT9D+ODKyENO5t4AWc/DsVACO4uGOYP9wvCumrrKWLO46EAPKp1Xgrvez+Iqgw32RBMt96ApmWxCc9IM85qrH/l2B+jGv8w0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=K6iYytJ6; arc=fail smtp.client-ip=40.107.105.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yNXface4eeKztm3TuSWKlF/JCZpNQ3fYOBFPq+AgrRYpLVlMpGVoTCZCWa1VZB0w4ccjjwSrDEH/Un9GjInbMujfF+49EI7Wa4RGSX2apeAmQ1j7DaTK8oDE60OtbyggsPax44c66yQ1VvU9QqCuesAXJ+MIS1vvfXOXbzKwSY6JZrgCMQsCseHtTZhJgiSrkvnLjZyJZrbTI1SmflmlqDNRculjkD4LVMVNOp3qO4H4xF9xeWUmGW4LfWo+w/vMGWWubpMcOQF0g2bHIvhzCPfMeyZm0c3rKowLA4fMi1PlsuOX/3vE2GcjXi3zQALQ9vgLDhJtGZvpLnxVEbKeJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkQmeAdEZq2i+7g1WX1GGAtlORbnl1hxywKAqAyU/U4=;
 b=cmSiwqpjy5bbIFd0KXzVP0jEZmUCD7pF+DgbrvJOaZwaJU1zkP+X5VqElm1F/yYPGDtWHF9ZhSB01fxlQb/XDuP9lLGYOwfd+1ITsQRCFDeAsCtZ1U2eG5sZpSUYOWI70/M+n3pQdoSuUXHGf2xkxKkMKWoMfRdE0ocjMttUJrYk7yr+WwVhFGTMkqDwmKzjUMQdZHu3nL+/bYFq2xK96Y0zuPEuZQO3IPI6wpTUXzWJS6LZMX18uUtgNu7pyBI8xItk36FSAKhVhYXIl5z8G/azbtTEj5cE0JHq8icEVA2hUEosxDjXLiZDN8vDL/eUMO/v9bqz0InvN6JhSMM9fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkQmeAdEZq2i+7g1WX1GGAtlORbnl1hxywKAqAyU/U4=;
 b=K6iYytJ6c/x31GEo4/LrI9vS23diAfvZxHyKECn+ZxHCt9zjLEQMhir5xfmD+vuuJ+eom1G9+Hr9BHuodAQHPHraNsxwdGSLj91OHSmXWPjzpFL9UhZWyjnnpExpsRZ+TgEv8dcE721lrupnxkY8WZ/X0pkCm91KuWvfq/SESXg=
Received: from DBAPR06MB6901.eurprd06.prod.outlook.com (2603:10a6:10:1a0::11)
 by AS8PR06MB8165.eurprd06.prod.outlook.com (2603:10a6:20b:3c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Thu, 13 Feb
 2025 09:41:00 +0000
Received: from DBAPR06MB6901.eurprd06.prod.outlook.com
 ([fe80::3988:68ff:8fd1:7ea0]) by DBAPR06MB6901.eurprd06.prod.outlook.com
 ([fe80::3988:68ff:8fd1:7ea0%7]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 09:41:00 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: Conor Dooley <conor@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"festevam@gmail.com" <festevam@gmail.com>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "m.felsch@pengutronix.de"
	<m.felsch@pengutronix.de>, GEO-CHHER-bsp-development
	<bsp-development.geo@leica-geosystems.com>
Subject: Re: [PATCH next v2 1/3] dt-bindings: usb: microchip,usb2514: add
 support for vdda
Thread-Topic: [PATCH next v2 1/3] dt-bindings: usb: microchip,usb2514: add
 support for vdda
Thread-Index: AQHbfVX6WeHlqh8NckmqOrqAOFgnNLNECgIAgADyGQA=
Date: Thu, 13 Feb 2025 09:41:00 +0000
Message-ID: <b0df1565-46a5-415e-b01f-822762c523b4@leica-geosystems.com>
References: <20250212135649.3431570-1-catalin.popescu@leica-geosystems.com>
 <20250212-dullness-wreath-8d934b09576f@spud>
In-Reply-To: <20250212-dullness-wreath-8d934b09576f@spud>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBAPR06MB6901:EE_|AS8PR06MB8165:EE_
x-ms-office365-filtering-correlation-id: d4c893dc-4f1c-4d90-abcb-08dd4c128658
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d3lVYTRYRmpPRkdwWFZMdEMxSjFiSWhaR3RaUGFMNGJJSjAveDV3NTl0S2R2?=
 =?utf-8?B?RnFmcERiaCt3NzdqTmQ3a2xZR2lMUGw2S3VRdEVRa285czRoY1MyRG5vdWpZ?=
 =?utf-8?B?UkdHNTNGMXgvQWxRQ1B6Wi82NmpVaFNENG1ma3JRY056MG5VbFhyVWpVaWFG?=
 =?utf-8?B?MXdCeVBIMkczcndyV2VPZ00vMy90UUhlckJ1amY4S09QQVdla1N2K3dnNDNj?=
 =?utf-8?B?dGprSkkvcVBNeDd3Z0FQcTVYZ1dpa0F6a2NFeE1RcFJVelhIV0gycmErb0hk?=
 =?utf-8?B?SWNXSlBrUXh4dUEyWjZyZ1NvYytaeklwT08wTUNoTTVzT2JKdnpuejBxcTlC?=
 =?utf-8?B?Q1IyYzNPVWVkUk9pNnBCVlQ5K2RCUERlVG5MTkpyK3B6QzdSdHdVSDZsSFhy?=
 =?utf-8?B?bVVKZmszSXNTN1ZDSnhBNlJhVW4vTFMvVlZJSTJ0aEVoTStDa2JjakdLRWZ2?=
 =?utf-8?B?ZGNUZEZwcm1OTWE2clpMUnEybG5KS1Z2U3hkdjNzRVNUM05tbVFPYzNpZmQ2?=
 =?utf-8?B?VXpmQkprL0J1SVFhT1hvdDdDVHlDVS9MWHA0VXRXcGNTRnorak5jVHRoWXMr?=
 =?utf-8?B?YmgyQzdoK2N2K2FIK1g1OW96U2tSUjlBZHBlMU5NaEE5N2hQZnp3OUMzQ2RH?=
 =?utf-8?B?RlA3dmd3clUyUmt0RWUybzVZdHg4ckd0SXpVSW91Uy9lakNGMjJDRkpnNndI?=
 =?utf-8?B?OUFlWmtpU1dNSVFJcFVMbllJUlVHeVVCTm8xWkw0cDlMZnJyNCtXTGJ2WmdB?=
 =?utf-8?B?cjd1d240RDdRSDhWbmhHWk1NSGpmRVNXRzB0R0xsU0ExUW5LRGg1VUd0R0ps?=
 =?utf-8?B?eGp0UDVRM3dyYWZlNlY3cFA4T0c0bXA1b0ZPMGlWWTB5YXVqdGl0NEhqQjFH?=
 =?utf-8?B?cWdpMlZhcldhVktmZlJLUUdHcllmK2QzblN6TmMxakxNajJIZ2x6STNLeDRU?=
 =?utf-8?B?anI1YklPaXNJT0UvVkh1VDZMUDF4d2pVNzNUd09WV2RPM2wya2RONFNEb2JC?=
 =?utf-8?B?ZWViVHpwbloyNVg0SDJKQlBHS2FMODVHaUliSExyendNd0xYNTRxanlPYWVo?=
 =?utf-8?B?QmZjRHcrVk04QVFFUG1WU1l1RUhVMG02dkdWZm9oM2NpWmk4VjBBRExwOHlw?=
 =?utf-8?B?K2NwNVBpOHJZbzJRczR2ZEdmK2RObjk2ZDczTTdNcGZlMEt1dlE4UTRpYTZu?=
 =?utf-8?B?NG9uTU1MMjQxV2thOGR5Z05rdVAzV25KVDFhNlVER2orRXdYLzdNbHpVdE5E?=
 =?utf-8?B?NHN1Rm44OE5sU2tZZkZOSE5qYmVzWnpML0FqcENrRlEwanBRNnJUT3hQU2Fy?=
 =?utf-8?B?MmFJL1A0dWZoTDNRVVFRN1kyeFVXZmtPZXpNZG1adDFXSzRqVkdJVHlYSGE0?=
 =?utf-8?B?Z0RmbWJUaXppck5XY0hCNGJoZEJRQVo2WFJNQ3E2WW9IZ21ucGw1YWFVUVRG?=
 =?utf-8?B?RG1YU2QxR0lzT01rdTJKeXEva3lLVVJJd0FIQjdRbjlVYjFaak9iTGlSb3dp?=
 =?utf-8?B?Z2tPMUs3ZXJIMTIrSEYwS01FaHpPKzBJTzIwdjJ1UWNLMTBMSm11ZDhORFlM?=
 =?utf-8?B?K3NrU2dTcFhXQWpXditQNGJ4bHhua29GYlZHbzdxOXNVY1BpbmRYWnJBRElP?=
 =?utf-8?B?Rk4wK01sUFE3OC8xUFNoSHlBOGZweVRHbjFIRUdpZDNCdkJQVjFRdFBCZzlr?=
 =?utf-8?B?Rzl6eUJQeTZkL05say9RQXowSWRPUElTWWpsWXYwTGR0UklYeE9WQmtKcHlX?=
 =?utf-8?B?bVBaMjF6NVp1Q3hXOGxCY3pXMFFGN2JaenNNVDVaQWNmODRjZm5sVmZwakhL?=
 =?utf-8?B?ZXVrcTdUNlRzOElDQmZBWVpBSmE0MVBRVk5QbXFmRGJZY3VZQ2pzeVJybHB5?=
 =?utf-8?B?blM1cnFKWHROU3pyd2pvOHZDZ09mMWJXS0NicGs0ODEycEpmQWRlLzRidVNU?=
 =?utf-8?Q?OTynaLCUE88+x69vZONu/KVcq6/wjDZQ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR06MB6901.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y1NIc2NkN1VvV1pjUjAzUi80OUlnNW4vVnRBYWxlaFRPZHdyS2xrY1BQRjZZ?=
 =?utf-8?B?blRkbkl2VmdrWHBXWGdkUXdxdWlOM2R5UDJlN2FOS3FzMlRvVkFlMjBUYmdJ?=
 =?utf-8?B?RWZpMWtsc054ZEMvRlpkUFJ6NkJaTUJSMXZSc003b0EyZXI1MnhzVUdMUTBi?=
 =?utf-8?B?cU5qemVEMHpJeCs3UlZybVhRTTBsV0Y4TDlqRmlRaFlNak5tUWFKN25QWHpj?=
 =?utf-8?B?SHVuYVhJb3JRT0xGSUNYekNhRTdZUFRtMVVYSjBGemFhYkxUdEVxYlhjbEFD?=
 =?utf-8?B?VDRkSG5tcGY5c2VoVjBvQTdMbVpUKzJwNERiK01OR2p1QUE4NVZFb2c5Ky8y?=
 =?utf-8?B?NnRCMnBKcVdiRlpiRzlpQklLbXl6OXVTekdxNFY4UEFBbm9wcElNVjZoUUIv?=
 =?utf-8?B?cHdJRTRMQ2hRRUdoakFFcklQa0VnZE55M3V0SVZsRnVUbHZVUUc1cENiZnVw?=
 =?utf-8?B?Z1IwNUI1ei9vNkFjWGxOeW0wSjhYY2JMNWJyYXM0S0dpNk10ZUErMlNEQ2pL?=
 =?utf-8?B?RGdtdEgwYXNjbTZIM2s4bXl2cjZpZjErODhLZEJjSmFzMDZmeHowMDVvM0Zi?=
 =?utf-8?B?cUlJbGx6TnlzS2Z6OHJIWEFEY0I4UGVuQSt6c0NneVlIMU5mSDNQc1RUVTVz?=
 =?utf-8?B?YTVaSlRvQkR4NEh4SmhlM1BtWnVwNTRiL0ZHa01jY1g3QVZvanNBdjFzMC9t?=
 =?utf-8?B?aVFjWkt5WWJoaTM1YmI0di9ZbGlWUGN2a2ExbkRTS2kzS29JcGVNR2M5cHFu?=
 =?utf-8?B?NUJkVDFYMDlTK0ZiZXR3YWJGOFdaNlkxbEZFNDBBVlltUzV6Y09qVXZQbE9x?=
 =?utf-8?B?a0F6WnM4b2ZXWEpzTEt5UDVDMXpCWnBmaHpxSGxIYW5Td05LSkVuMUs5aEUr?=
 =?utf-8?B?ZXMvVUJMd21ndzhZeWx6SWJIVnFpdjBqbWl6eHJSWFFkWWM1TmN0eUlMQmE5?=
 =?utf-8?B?M2M3NFczcU9ROHNQUjBwZVNTNnNESFhqNFdiTVpBV29PVHJ6T2xkTERvVVgw?=
 =?utf-8?B?TlI5dTRGZFIrRURJNmlvcTlza1NDNnRwYnd4aHhtQkY2dDVXOTJOWU9kVmNK?=
 =?utf-8?B?MWtOOUExZ29kZkdJNTM5SzZpaUtjY3pTandBaXNjUldvQUEvYXJWWGt2R1lw?=
 =?utf-8?B?SEx2c05XSlNuV0RYQ1VsZEhOcXl6bk92UnlnSUFGNTl1WFVXMjBLQkg4SUhH?=
 =?utf-8?B?bGF2RGU0TnRVK3F4b1Qrb1Z3NWppblg5U3gyMXNjZEpaRDRBZlBEMnhKM1VZ?=
 =?utf-8?B?M08yNlEzZ1RDZ3lSRkU3ZldDMEl0TU5ITkFGNFZQeXRiUVliSHYvWkVnQ1hY?=
 =?utf-8?B?ZTNIYk5TRXFyTm1pcm1XMjJKRSt5MmZiai9lbTNwMmdiTGVRVnMrV0MyRTBC?=
 =?utf-8?B?Z3I1TU81L3JtWlJUd3dVbDRFNWU1aCtwNHZLcUNza05GMEJRRUJ1Q1FlSlFp?=
 =?utf-8?B?dTJab01haVZ3Smo1L2pvOEx6bDFUdEdqM0tuN3VRbndZN1FPeWZId1gyR2FJ?=
 =?utf-8?B?dUxvTVZyR2ZBdHJBcG8wdksrWWdUSVdwYWpRN0ZLQW02VmdqdHN2bUNIK1la?=
 =?utf-8?B?b2oySFgwMVJXaTRVaWNDVUtQSkxhWW1DZ2NSTk1XMnd5UTNDaG56N3ZoR1or?=
 =?utf-8?B?OTE2UCtFbmpDSVdlclJVQ3dzREdDbStYckllSURDU3J1N1ZudjNzT0hYeTZJ?=
 =?utf-8?B?dWFPR2VGWVZWMHpkaW4xZ3JybFB5QlNwa3NlQ3lxTHNOM3VtOFRKQTkwdzRL?=
 =?utf-8?B?VHB0TXd1Rm9jcHlUQ1poSXhzYnJVOVJ4KzhEN242ejlEZUcrSml6cWZxUEk4?=
 =?utf-8?B?ZUpVK3Q5V1RjUkloYXU1SzJsMkhFekVLc0tLeUwvKzZobzRiT2lXakhDYU83?=
 =?utf-8?B?S25udmh0eG1DQ3hmNVpLbUlIanU3dzE1RWVNY1BpSUpCbmJEbGFwcFZuVEcr?=
 =?utf-8?B?QlVOcTdPS2NBcHI3dGtCd3NuQmJCTjdyNlprcHNCdTcrUlZ2VTVKMDJYcEt1?=
 =?utf-8?B?L3VIL1RRRkUyTnorSk9sWFNtYWhGQUNkbk0zcndpOWRqSElpTGhpZk1GV0kx?=
 =?utf-8?B?WUVpdjJEZm9rajhsM0x0SzhQUU5JbG9aU3JZdSs5T3UrQXFuSE5NREkyYmhN?=
 =?utf-8?B?VXhnbEIzOUE3TVZWMVQrejFIZVJ2cDhHUmxSSm1VaTBzQ3ZTbkZJbFBMU21n?=
 =?utf-8?B?WlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A8095E319BB764399E677AEA156FF60@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBAPR06MB6901.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c893dc-4f1c-4d90-abcb-08dd4c128658
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 09:41:00.3522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rGtgaAglyVAhv175goU3mMV1hlI+mz6rot3k+mnB2miyOHsHt3csh48k/LR35ER4YebzOi5XKRg43mG2gZ4DKYiccDCIn4lZnwznRTOFqgw/lqDhgbIT38zbB5AxcHyN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB8165

T24gMTIvMDIvMjAyNSAyMDoxNCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBPbiBXZWQsIEZlYiAx
MiwgMjAyNSBhdCAwMjo1Njo0N1BNICswMTAwLCBDYXRhbGluIFBvcGVzY3Ugd3JvdGU6DQo+PiBN
aWNyb2NoaXAgaHViIFVTQjI1MTQgaGFzIG9uZSAzVjMgZGlnaXRhbCBwb3dlciBzdXBwbHkgYW5k
IG9uZSAzVjMNCj4+IGFuYWxvZyBwb3dlciBzdXBwbHkuIEFkZCBzdXBwb3J0IGZvciBhbmFsb2cg
cG93ZXIgc3VwcGx5IHZkZGEuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2F0YWxpbiBQb3Blc2N1
IDxjYXRhbGluLnBvcGVzY3VAbGVpY2EtZ2Vvc3lzdGVtcy5jb20+DQo+PiAtLS0NCj4+IHYyOg0K
Pj4gLSBtZXJnZSAiaWYiIHdpdGggImFsbE9mIiBhbmQgbW92ZSB0aGUgd2hvbGUgYWZ0ZXIgcGF0
dGVyblByb3BlcnRpZXMNCj4+ICAgIHNlY3Rpb24NCj4+IC0tLQ0KPj4gICAuLi4vYmluZGluZ3Mv
dXNiL21pY3JvY2hpcCx1c2IyNTE0LnlhbWwgICAgICAgfCAyMSArKysrKysrKysrKysrKysrLS0t
DQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0K
Pj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNi
L21pY3JvY2hpcCx1c2IyNTE0LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvdXNiL21pY3JvY2hpcCx1c2IyNTE0LnlhbWwNCj4+IGluZGV4IGIxNGU2ZjM3YjI5OC4uYWVm
ZmRmMDM2MmMyIDEwMDY0NA0KPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3VzYi9taWNyb2NoaXAsdXNiMjUxNC55YW1sDQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvdXNiL21pY3JvY2hpcCx1c2IyNTE0LnlhbWwNCj4+IEBAIC05LDkg
KzksNiBAQCB0aXRsZTogTWljcm9jaGlwIFVTQjI1MTQgSHViIENvbnRyb2xsZXINCj4+ICAgbWFp
bnRhaW5lcnM6DQo+PiAgICAgLSBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+DQo+
PiAgIA0KPj4gLWFsbE9mOg0KPj4gLSAgLSAkcmVmOiB1c2ItZGV2aWNlLnlhbWwjDQo+PiAtDQo+
PiAgIHByb3BlcnRpZXM6DQo+PiAgICAgY29tcGF0aWJsZToNCj4+ICAgICAgIGVudW06DQo+PiBA
QCAtMjgsNiArMjUsOSBAQCBwcm9wZXJ0aWVzOg0KPj4gICAgIHZkZC1zdXBwbHk6DQo+PiAgICAg
ICBkZXNjcmlwdGlvbjogMy4zViBwb3dlciBzdXBwbHkuDQo+PiAgIA0KPj4gKyAgdmRkYS1zdXBw
bHk6DQo+PiArICAgIGRlc2NyaXB0aW9uOiAzLjNWIGFuYWxvZyBwb3dlciBzdXBwbHkuDQo+PiAr
DQo+PiAgICAgY2xvY2tzOg0KPj4gICAgICAgZGVzY3JpcHRpb246IEV4dGVybmFsIDI0TUh6IGNs
b2NrIGNvbm5lY3RlZCB0byB0aGUgQ0xLSU4gcGluLg0KPj4gICAgICAgbWF4SXRlbXM6IDENCj4+
IEBAIC00Myw2ICs0MywyMCBAQCBwYXR0ZXJuUHJvcGVydGllczoNCj4+ICAgICAgICRyZWY6IC9z
Y2hlbWFzL3VzYi91c2ItZGV2aWNlLnlhbWwNCj4+ICAgICAgIGFkZGl0aW9uYWxQcm9wZXJ0aWVz
OiB0cnVlDQo+PiAgIA0KPj4gK2FsbE9mOg0KPj4gKyAgLSAkcmVmOiB1c2ItZGV2aWNlLnlhbWwj
DQo+PiArICAtIGlmOg0KPj4gKyAgICAgIHByb3BlcnRpZXM6DQo+PiArICAgICAgICBjb21wYXRp
YmxlOg0KPj4gKyAgICAgICAgICBjb250YWluczoNCj4+ICsgICAgICAgICAgICBjb25zdDogdXNi
NDI0LDI1MTQNCj4+ICsgICAgdGhlbjoNCj4+ICsgICAgICBwcm9wZXJ0aWVzOg0KPj4gKyAgICAg
ICAgdmRkYS1zdXBwbHk6IHRydWUNCj4+ICsgICAgZWxzZToNCj4+ICsgICAgICBwcm9wZXJ0aWVz
Og0KPj4gKyAgICAgICAgdmRkYS1zdXBwbHk6IGZhbHNlDQo+IEhtbSwgdGhlIHRoZW46IGhlcmUg
aXNuJ3QgbmVlZGVkLCB5b3UgY2FuIGp1c3QgaW52ZXJ0IHRoZSBvcmlnaW5hbCBpZg0KPiB3aXRo
IGEgIm5vdDoiLiBTb3JyeSBmb3Igbm90IG5vdGljaW5nIHRoYXQgbGFzdCB0aW1lLg0KDQpTdXJl
LCBubyBwcm9ibGVtLg0KQlIsDQoNCg==

