Return-Path: <linux-kernel+bounces-511516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8C0A32C0E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6B9D168C87
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56959244E8F;
	Wed, 12 Feb 2025 16:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wek/T323"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7B6212B31
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378454; cv=fail; b=MHSNUs4M4mR19O5h9hvWNaKXfcTfQDFmr1Fmvstxzy4QFewJuZ8XZn0QP8srK1F1dZWmMVRLFlY2zjkJIg1d79EU+GIxdd25vOrdZ5T4fFDfOAUiQsMtjD7YI6iO3MRzaaNd+PdZ1nFUKtf4d8Tf01pWHqubR5SHF/8NjKJwgZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378454; c=relaxed/simple;
	bh=hx6SZhz8YYnXc2qBpmfyzs0DjkdjKtIAP1/sMAL0M1E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NWybbg2V0NfUwCheF+78BtmWf/Z/Kf8DCgKOCdWvlibIYU/001ehW7ppEyzTL1GdPNxZMb8IWP3+JHL69QkWtKgq6YRZNNIgCIcmvvLix6WAzsA+HRtJqXFKPdGGJyVGy9FA1INtaf/Eyx8KFxImh/uIOdjuGVT+a5cYXdayx2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wek/T323; arc=fail smtp.client-ip=40.107.101.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qa90UXQRPrqJTEa1dgtO2oAV3c8xmXKA9q5rF8KPzlyOnf5oTDQXKZS0Mjj0kmXYHebRT9LYwsNlYGYKvyyahviwikbiTujC2zxwwtXIKgrfUNPn8C3exkqMBROWlBt0lKfZq7qgjkj5apz2cxtAGbSPCDeB1UGZa31KsETK+oMqoG4wYx1XYgmEdlYtlBOJbKxmqWZSoEM/3O91JJv2vHAb+OFW7jMmuYc3VXAno84me+InrtGHQr3IjzxdvCgUk3juC5SdLIva6xT0k3bRTn3JSudxuNNZPdzBHbEdzvKgvVlBnjfFJsDQtJipoZ8sV+BsC+1WkHYEWTN1KNW91w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hx6SZhz8YYnXc2qBpmfyzs0DjkdjKtIAP1/sMAL0M1E=;
 b=lR6NSaiptyYA8XnhFFIUoowbGJaP3eB2WbzHufxo4MbjqUljhBg6Cicwvy47/84ZmhzcwJQk9TUGCSxt7ti+gBUodDwVT1BH7zOEeU9RHlATW7XUgOznaZ8hjob/QWS3/neulSgBYOdgBwD1g7ju1xbczgtsja3kc3FVbpexQOLSeJEcGXnWImvMr0S7bq/DAE0KcW4IY7EXbrNSQ8TP5LoHJpEbfMX45MluiF2XQVvR3+GJ1eZA6JpYJ3AYPpT+J8jUq/JWmGJEDi1pEGYnVPJn8SIkDI5gPP5SLL1p13mxz/qzLYbBaj++CwaOI8YP8Hsbh6VoXE4EjN/P2zFI5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hx6SZhz8YYnXc2qBpmfyzs0DjkdjKtIAP1/sMAL0M1E=;
 b=wek/T323RSTIbNb2b3eY2Z7VlnQZZvdIo9Hg9bC7a3WOwrDhHnU3SRUwmJe7I+euxyH/NhH/m5w9LWco3hk1ZHuwbJrEEE6UYpWlp5VwujArkRMayBKTvhE7hrZcFeicFUYKR6G5s3WUiKwzrDTb0ZX9NVtc1rEh5vVlwn+6rk4=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by BL3PR12MB6548.namprd12.prod.outlook.com (2603:10b6:208:38f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 12 Feb
 2025 16:40:49 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 16:40:49 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 15/35] x86/bugs: Restructure spectre_v2 mitigation
Thread-Topic: [PATCH v3 15/35] x86/bugs: Restructure spectre_v2 mitigation
Thread-Index: AQHbfCFervOR19S6fUiXkI84H3iVdbND3uGA
Date: Wed, 12 Feb 2025 16:40:49 +0000
Message-ID:
 <LV3PR12MB9265DD4D99D05F4F64D7FBC894FC2@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20250108202515.385902-1-david.kaplan@amd.com>
 <20250108202515.385902-16-david.kaplan@amd.com>
 <20250211010743.75kzltegyvhdwkuw@jpoimboe>
In-Reply-To: <20250211010743.75kzltegyvhdwkuw@jpoimboe>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ac99c761-c891-412c-a49b-9138ce6983ce;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-12T16:31:30Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|BL3PR12MB6548:EE_
x-ms-office365-filtering-correlation-id: 69b3035c-c108-4d4e-ac44-08dd4b8401ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QmF0RG5QVDlseUxYUmV0WjZpVCtzZUZHZHdjUFJraUlMNmFlU3hnMjRqQUIz?=
 =?utf-8?B?amJMMTZxdTZiY2ZjblA4QTYrTTk4NEtaZTdkdWR4VXFHWXY0V2JRUmVDWCtO?=
 =?utf-8?B?L0RIQVFRN2NPcnpFbWJKQXViTWZVZU5JTE9IMFdKTmVXbnlQMjFRT1V1S2V2?=
 =?utf-8?B?T2ZnMUp2WGhsRldPSVFzUmwvR3hWZVNtR21vQ3lZUWl0NlVUQ0R5SnRsOHFx?=
 =?utf-8?B?aEpzVUZoa2ZjRW14UzMvaS9tSXBpU3hvUU01cmR2WnlkbUJpTmVOVStEcVpN?=
 =?utf-8?B?aVdiakNJRGNWOUN6c3V3QXFtc3dhc1JDcStJSmIzMDlDeFgvUmtUYnhHRC9I?=
 =?utf-8?B?NUdoaWIvMDBPellYNmFDQklNUVpnS0RSU0oyelIxdzVhVFBvZyt1QnBLT0ZW?=
 =?utf-8?B?VVpzb0pFS1BZZjhVY09ic0Jub2V3YkVLRDd0VHQ3TGFnQ1Fva1dPbVNISDJO?=
 =?utf-8?B?RXJ6Qit0UTByUVowRTRxTzgrNVdVaUo4SVprVVVXL0daam5UZVJ4d1ZXa0ov?=
 =?utf-8?B?U3ZPSm5RQmFoSHVsdGp4WTI0NUE0empzaEh0QnFxamxkRHFUeGJoRDQvdDda?=
 =?utf-8?B?TmN2WjlSU2tmR3RnTW9oaWFpbGhSbUZYSHR5U1NnMUdVNmliOGNaUmN6UEhC?=
 =?utf-8?B?NjZsTThNVnFiT21ZNnY1VnFuc1VFdktsN0UzVmVwUVRLNUZkUTRXeXhNMUFT?=
 =?utf-8?B?cjhBazJQa2hYbVRqdXdZNndUMjNiNE16dEhKYTBXRHdZb0NXTTZTSGVlTDI1?=
 =?utf-8?B?azZ1S2dBOGNTSGdzY3RtdjhrUTAwa1ljVkhWWVVnRUxUaVVUdEVDYkVDOGQv?=
 =?utf-8?B?QUVYOXh4M3V0eWs4czVxZEhlVUlRQnYzY3BqQTRyK1VXSVRneittTUpWY25L?=
 =?utf-8?B?anlWcGt1azVrUGJKMlVFMlZxdHM0ZDVrRjltZVEyVldDTjhRTXdaZXlGeG40?=
 =?utf-8?B?aWFXL1ZBQ2dPdFMrOEg4eDRVOVNZRTlQdnFjV1Z5ZG1NSEQyOWVIdS9NdHIv?=
 =?utf-8?B?RDdpclRsZk1XRW40UzNTUWZnVnpNZVRqdEFRV0tYcEY3Kzl3ZDBuUHN5VHFw?=
 =?utf-8?B?UU9TN0tpdVZnUjVpaXRoM0RBYUZVT3liSVM2SGx5SzFOK0x4M1FiYkJUMW41?=
 =?utf-8?B?R0JRb3NmOWhjR1JNRDJPUVZpcHRDNllmUFpLSmU4dkZmdFIzL2FtdWR0WlRV?=
 =?utf-8?B?NFM3MXRBQ29QYm5iRmdVNzJTWmdjL203MTFVUm0wNTVlMmgrQUN1V2NWVkdV?=
 =?utf-8?B?bCtyN1ZONkdiMnNnL1RNMjNNcm1UbjM3V1ZWcXRla2gxVDk0azBSR0IxYzBO?=
 =?utf-8?B?Y2xiNXlhZnJMS1V3czI4cXlISWZ3SkdNYXZtR2IwQUhnQ2ZIYVlNcU13UWdZ?=
 =?utf-8?B?bUN3NFNOeUtyOEhRSUNzeFBJdFVTZHdmMjdXdWNxWVc0Q2tybVEvWDJqODRs?=
 =?utf-8?B?cEk5OG9QN1Nib04xRnlqaG1OT0I1WjAxbjFzZWRCSlRBQ3FmbGhaSExSK1Z6?=
 =?utf-8?B?My9EWk5LQ0xBcVFxZ0p1TDBZc0xqV3Y1cmZIeURRd3hWMlJDZ1BlVDIvT3pV?=
 =?utf-8?B?ZmJ3amJlMlJoSWwwTDYrVFc2U21lWGVUWUJjLytNU1pRdThOcUdsbUptTGx3?=
 =?utf-8?B?Y1h2NWg0Y1dvdXFsSGJaZGRWaHBhWnNUMURkcFN6SWNFci9KRUpTNENIZ0h3?=
 =?utf-8?B?TWpSK0orcGZ2UTY2OHFpQVJzblJtNks4V3dkVSttbE8xK1d2bGNiYTRjbVdp?=
 =?utf-8?B?UlNZc3Q3V1plY2t3c05NL0cvalcwZXdEOTFDSW5IeFB3WFZyRmhzNUlzUG1N?=
 =?utf-8?B?YWpRcTVXTGtDb0ZWMlNaaUtPTWt5cjZaS3V3aUxKcVovRyt5VWtzQjIzYi90?=
 =?utf-8?B?ck5zZlRhZ3NIdStLVHZKcEwxRDZRaFlpTDYvRnAzUk1HanpNYUJGWk04Qnhw?=
 =?utf-8?Q?Sp0iQ90p5Ibp19EqCudCzEkmXNJUN+th?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aU5NbUJ1S1c4SVBIZC9QUlN6eE1QeVA1Wk42SFZia2YwVFJaZXVKczczbnhl?=
 =?utf-8?B?MTEzeTQ5c3l4NVJaenpuRXlGNjZEMzZEb0syRmZ3dzNUM2dPc3hpUkd4OWQz?=
 =?utf-8?B?dkJDeHZ0WWhkNlBGb25VVyt4bTF4Wlk1VW41dlN1a2FyNnc2RGNWMGtuU3U3?=
 =?utf-8?B?MEhBMDVlSGE3dDFNa1QxL0dvSTYrenZWazBOTzNmOU1UL0w4VitCZDZSMzhv?=
 =?utf-8?B?ZmdtQm80Q3NYVUVHV3BITTNOU2JYeE9WOVBudWsvMm9uRUxiZ3JQa3l5Y3BZ?=
 =?utf-8?B?aWJqUVZ6ZFA1c3psQlJnNW5PRU0yeTJXNXRiME00aGRmMDRYaUtjVlU1VE11?=
 =?utf-8?B?Si9aVEthS1I1TzJ3N1QrbkxNbmtoZHRRaWJhNk1UTHhQdGNvS2I2NEJJaVpU?=
 =?utf-8?B?QlJhSWFjdTRWVXg0aGJBWkpBQ0dyRXV0OGRDWmQrWGhhRDM3ZENUWmlpbFlq?=
 =?utf-8?B?SVg5SVZQT1pkN2RzNHhjUUt5d0o0Q1JMdFhJRWxaaThONlpqR3F5eFFIQ2VO?=
 =?utf-8?B?LzVmYjFqOE9HQnhaMlYwWlBIb0dMYUZpaDRKQVlZWlpHNUpHZHdGb3p4YnhU?=
 =?utf-8?B?amx5eHpNeU8zRHQvZy9MN080dFR3WkNVWndvNVJTMEw0Y0VaOFVUSHd6OXVQ?=
 =?utf-8?B?NE0rMFhSM1VPNU5ldE9tRXRZYXBZSHkzRDlXM0trTXVPaGVxODRGdkNOUkNy?=
 =?utf-8?B?cFFVOGkwVDBWR2hSalFESCtIK1FFTnFkVzBBSmlPZXF1Q2FkZGt4U3F6NHVs?=
 =?utf-8?B?aTEvTXJacFl1cUZzS3k1ZllnL0w2MzJIK1I0RDFzajNVNUowVzd3VXlPRFRt?=
 =?utf-8?B?NUxpcDhSZms1Nm9BLzBQQ0U2Q0RTWXJ6Y3IySzZRYXFiZ3VCY3FGSXN1Z3BP?=
 =?utf-8?B?K29XMGRSWlhubW9PWEd5NXYwc3FDUUVZN1Z6T0F5OCs2U2hCaWhMR2JSaGJB?=
 =?utf-8?B?TVVOeFNDZDVWeDlDa2YvQmlET3dBUXgySndZZUp1NEtEcUFMQTNDa1J4Mmpw?=
 =?utf-8?B?RmRyVkhFR0xHTmNtVWZqaHJFMW1VK1JqelNwLy9wWXhpUE1TcHQ0RlZCU2Ex?=
 =?utf-8?B?NCtXSnVLQzlDcVQzbytZQ3hiRE56c085UGczY3JSS2crbjJTcnR0VXh0SHpm?=
 =?utf-8?B?cy9ZUmE4NWFHWFo3N21hd05mY212K2thb1VVYjAwMlA3V1BGNlpuTitFUzc0?=
 =?utf-8?B?ZW55WGR6N1F0eGVLUzY4UnNSTngvblZWUEgxZEZGYno1K0lYdlFOcWd6NU1H?=
 =?utf-8?B?OC83dG9McWtxa1JWdnZXcWRFQ28rQzcrSlczRy8yVWZvZWlWRFFycWY3T2RI?=
 =?utf-8?B?OWRVdXpXbXo2U01GRkNZUm5Va2M3OWlsR1BvY0hCdm9iK0JmU2VHVDhnTmRu?=
 =?utf-8?B?SERjWjI0enJlMFBJR2x2Y1IxRVFOYzRBemN5YkIwMWhvbzRnSFBQMFRvZVF4?=
 =?utf-8?B?OHhmbjVITHg2WVg5V1NraVhGTUZSU3llVDZpcmR3NlA2TW02Nm54aDhkb0tB?=
 =?utf-8?B?MVhSOWZiTFpONVd1Y1lhZXgyWDNmM25XVkQwb0dMdW05dmJGNlVWTnQ2NlBs?=
 =?utf-8?B?enNoa2RZTFoxaEtMVVc1NmpTOFdkbEhWOXQ4czRQTlR4OU5DMVF3eHZGbHRR?=
 =?utf-8?B?WXhDUzRBeEpMQVVPYWNEcHFyRDl2eS91MnJhc0g5bHVTenZpRXpjMHBZZ3Rh?=
 =?utf-8?B?OHQ1a1NTNkhHODRQZENrcEVMVzFzRnErZ2RWcHNUOER1bHBxUzNjdkF2OWhS?=
 =?utf-8?B?YzYweDJLTVNSUzhJcmdrVE9DMTlZbGRXZHYyOWNPVUl4L1FNbldNVTBWaTg1?=
 =?utf-8?B?TU1sVnJpc1JQM1p0RUo0TTZSK01kajBwY0Z0dHAxM204KzF0cEN4ZUd6RW5H?=
 =?utf-8?B?aTEvdzN2LytpZENkNEF6VHJ1VnF3NElpWmlKMDI2WjF0aWRNbExDemozMmJQ?=
 =?utf-8?B?d3JOYjJ4QnVsVGxCNDhRL0JwSXNuMzJiQVF1RlhFdjVoV01SZFJNUVBvQUVX?=
 =?utf-8?B?MkpsNE85Y2RmTktoQVZJRHRkRGNtK012RVo3N0pLd2NoSDJCc2JEcW1ETk4w?=
 =?utf-8?B?dHE4S2MzSEM3dC9oT3Z1ZFhsQXpudVlJMVE2bHNIcS9ZUXdOSTBHNVJpSHFY?=
 =?utf-8?Q?PO3g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b3035c-c108-4d4e-ac44-08dd4b8401ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 16:40:49.7691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 70WZ5efN5Az5inMqwDFEjd9EB/HNitCDEPu69aSsoUnBaBID565TvInztwRip8/M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6548

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb3NoIFBvaW1ib2V1ZiA8
anBvaW1ib2VAa2VybmVsLm9yZz4NCj4gU2VudDogTW9uZGF5LCBGZWJydWFyeSAxMCwgMjAyNSA3
OjA4IFBNDQo+IFRvOiBLYXBsYW4sIERhdmlkIDxEYXZpZC5LYXBsYW5AYW1kLmNvbT4NCj4gQ2M6
IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPjsgQm9yaXNsYXYgUGV0a292IDxi
cEBhbGllbjguZGU+OyBQZXRlcg0KPiBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBQ
YXdhbiBHdXB0YQ0KPiA8cGF3YW4ua3VtYXIuZ3VwdGFAbGludXguaW50ZWwuY29tPjsgSW5nbyBN
b2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+OyBEYXZlDQo+IEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGlu
dXguaW50ZWwuY29tPjsgeDg2QGtlcm5lbC5vcmc7IEggLiBQZXRlciBBbnZpbg0KPiA8aHBhQHp5
dG9yLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MyAxNS8zNV0geDg2L2J1Z3M6IFJlc3RydWN0dXJlIHNwZWN0cmVfdjIgbWl0aWdhdGlv
bg0KPg0KPiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFs
IFNvdXJjZS4gVXNlIHByb3BlciBjYXV0aW9uDQo+IHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywg
Y2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+DQo+DQo+IE9uIFdlZCwgSmFuIDA4LCAy
MDI1IGF0IDAyOjI0OjU1UE0gLTA2MDAsIERhdmlkIEthcGxhbiB3cm90ZToNCj4gPiArc3RhdGlj
IHZvaWQgX19pbml0IHNwZWN0cmVfdjJfdXBkYXRlX21pdGlnYXRpb24odm9pZCkNCj4gPiArew0K
PiA+ICsgICAgIGlmIChzcGVjdHJlX3YyX2NtZCA9PSBTUEVDVFJFX1YyX0NNRF9BVVRPKSB7DQo+
ID4gKyAgICAgICAgICAgICBpZiAoSVNfRU5BQkxFRChDT05GSUdfTUlUSUdBVElPTl9JQlJTX0VO
VFJZKSAmJg0KPiA+ICsgICAgICAgICAgICAgICAgIGJvb3RfY3B1X2hhc19idWcoWDg2X0JVR19S
RVRCTEVFRCkgJiYNCj4gPiArICAgICAgICAgICAgICAgICByZXRibGVlZF9taXRpZ2F0aW9uICE9
IFJFVEJMRUVEX01JVElHQVRJT05fTk9ORSAmJg0KPiA+ICsgICAgICAgICAgICAgICAgIHJldGJs
ZWVkX21pdGlnYXRpb24gIT0gUkVUQkxFRURfTUlUSUdBVElPTl9TVFVGRiAmJg0KPiA+ICsgICAg
ICAgICAgICAgICAgIGJvb3RfY3B1X2hhcyhYODZfRkVBVFVSRV9JQlJTKSAmJg0KPiA+ICsgICAg
ICAgICAgICAgICAgIGJvb3RfY3B1X2RhdGEueDg2X3ZlbmRvciA9PSBYODZfVkVORE9SX0lOVEVM
KSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHNwZWN0cmVfdjJfZW5hYmxlZCA9IFNQRUNU
UkVfVjJfSUJSUzsNCj4gPiArICAgICAgICAgICAgIH0NCj4gPiArICAgICB9DQo+DQo+IFRoaXMg
aGFzIGEgZGVwZW5kZW5jeSBvbiByZXRibGVlZF91cGRhdGVfbWl0aWdhdGlvbigpIHdoaWNoIGhh
c24ndCBydW4geWV0Pw0KPg0KDQpJdCdzIGFjdHVhbGx5IHRoZSByZXZlcnNlLCByZXRibGVlZF91
cGRhdGVfbWl0aWdhdGlvbigpIG5lZWRzIHRvIHJ1biBhZnRlciB0aGlzLiAgVGhhdCBoYXNuJ3Qg
Y2hhbmdlZCB2cyB1cHN0cmVhbSwgYWx0aG91Z2ggSSBkbyBuZWVkIHRvIGRvY3VtZW50IHRoYXQu
DQoNCi0tRGF2aWQgS2FwbGFuDQo=

