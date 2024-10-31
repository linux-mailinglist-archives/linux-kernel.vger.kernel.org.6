Return-Path: <linux-kernel+bounces-390317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAF59B785B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F047C281790
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D01198A25;
	Thu, 31 Oct 2024 10:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xEYUOyIu"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4403212C478;
	Thu, 31 Oct 2024 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730369279; cv=fail; b=hnhmh3RPNRzFHD8I00jnG60EXSf1kppP0JkWQlyL6vQIE+z8NHiO0w6XA3NWlHfPzAmWmcqzhAOO/ZgXX/Pe3vkgKF3a9uKHJPlnaLdGxNn2bfsbfM/Aw24Alw+dJt4ovra1LI2ZhNSKJpLsJ185MnIPRYPYi30oNc4gkST70XM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730369279; c=relaxed/simple;
	bh=iOoWJolYKgQIkpVHwDLuszQtS7zHVoCKbF5cKDBZ2xk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lfFL4Mrjv3q1/2T2hF0LBNrJUK3bTcNdw5MrUQgrSG1bYQPiivcB00aukV41oSc1vqkrasQSSKjU9q+k9Ad/hEGlJ3M65FxcaFIhihiCtGPwMODg38OUN03nLJxiOg+6q3KibR/emcWdKEp2MCMtz//Eydz8jeIoUmEO2Nv6g3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xEYUOyIu; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHygljCAly79WOOEqCT9C/hJiZYk4HiB53t+WNWAy5P5WgpQsSSd9hnI33DRNR2oNiSv8t+wtixxwT4MEHkaQoPjdK1A4aXKGGi29Hw1LPMtOnejZO1oXevk//g/0RZ04vVXdD+bPxdH4ek2y9sK3eLl290oT+vEBlLzEZRyVbbZyKVem2nJ5h0JlVlI3i6KWIzPNgHat4TX8Hq6GUM1tEtMycJryww208nK/JGNiYaVgv1PxXueBWm0J3hPzTsi5QcAB7YcMBiE2Vn3DQsAnYfXL1MKVky+85SrpOVYOc+68Voxq3U+pDg5rW3jsaw3tKeh1BvWadR83XP2+A6Uew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOoWJolYKgQIkpVHwDLuszQtS7zHVoCKbF5cKDBZ2xk=;
 b=FAmlHAQs6s/w+W5Z2wo4iVaG1Bfs51iffJtV1nC+DzKJqmTKb1Hgb48MzDfbutkaNoSOAqqJvhrP+pGD7UHGFjhMIxl523ozmWQEM6bQiQHSwL6iEZG+Qh/7IUu3CtBdbXZbK+C+DQDypCYOXKAD3+6FBLekV1Ehc9Q7RClSEITfvZOk2xV3ASSfwoqBCI+Uomw8lQaQO+gkh/EJ+wUQjoMYecNStSgnCWg8mhTWONnv5TSwV28JAEORt43QqCaKlXbRtio4CftQl9OaEy6l0dvo5CTbJRZrjcvGpRParlYlKPSaEtaDIUziGvvFOtCLGx++IMsn356xsYW+lxuXyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOoWJolYKgQIkpVHwDLuszQtS7zHVoCKbF5cKDBZ2xk=;
 b=xEYUOyIuI2QetpRNa/43fDaTJbUJYfor5diPRLCo5xnVExeg20Hfzaft/KsQQaNlLk5xKco+/4alyxjKOoVlyOqOPH351shc1Q8+vkhx5+cus/9P3J2KnzD1y3IwZYaTl0r1Nk3CJUAnYd4eTDLPlA8pin005X4qq/P1RZZSzUPFFzDkrb/EqDqNQqYNPYAjVwR+2MdLyRfU35Cquyy12FhM0oligLUCvEppq0QJsUU748P4Srs9y7Jnxv3ExzIeZFohlJmZmTYzLfgjIuQkX1zL+QRGPg21f3F1RY54spsY48Cn2Gsx9DOBSUtZqja6nM5GlQdNDt0LUi5sdjtYkg==
Received: from DS0PR11MB8739.namprd11.prod.outlook.com (2603:10b6:8:1bb::19)
 by DM3PR11MB8734.namprd11.prod.outlook.com (2603:10b6:8:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Thu, 31 Oct
 2024 10:07:52 +0000
Received: from DS0PR11MB8739.namprd11.prod.outlook.com
 ([fe80::f0f:4a3f:e3a3:d3ad]) by DS0PR11MB8739.namprd11.prod.outlook.com
 ([fe80::f0f:4a3f:e3a3:d3ad%2]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 10:07:52 +0000
From: <Valentina.FernandezAlanis@microchip.com>
To: <robh@kernel.org>
CC: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<peterlin@andestech.com>, <Conor.Dooley@microchip.com>,
	<conor+dt@kernel.org>, <ycliang@andestech.com>, <dminus@andestech.com>,
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, <jassisinghbrar@gmail.com>,
	<krzk+dt@kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: mailbox: add binding for Microchip
 IPC mailbox controller
Thread-Topic: [PATCH v2 2/3] dt-bindings: mailbox: add binding for Microchip
 IPC mailbox controller
Thread-Index: AQHbJtpv+KalYhPYdUuFNx/W8axCB7KdtAMAgAL3xgA=
Date: Thu, 31 Oct 2024 10:07:52 +0000
Message-ID: <f5c6e45c-a224-42b6-a479-aa90fd6aabed@microchip.com>
References: <20241025125110.1347757-1-valentina.fernandezalanis@microchip.com>
 <20241025125110.1347757-3-valentina.fernandezalanis@microchip.com>
 <20241029124832.GA1314513-robh@kernel.org>
In-Reply-To: <20241029124832.GA1314513-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8739:EE_|DM3PR11MB8734:EE_
x-ms-office365-filtering-correlation-id: 25aa2e56-9e40-46f6-3949-08dcf993e1f4
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8739.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d0p6VjJaZW9IcHZhazJaY0hsNGNVZFptUGFURnp4dkFtVmxuYUx6KzZMYjM4?=
 =?utf-8?B?cGVKaE9Mb1hhSEFUaWhxZ2ZZQ2d2TFZzay9acHJaOWtFakRwQ2ljRk1UQ1pu?=
 =?utf-8?B?OCtUbHhnOVlsU3pqNkNlVE1USU9VK3Q2ZGV0SHJkZGgzRWxTZG9zcXB3ekhH?=
 =?utf-8?B?bXoyTVBoNVBVOHF2dHROYnZxQW9OVlBXSzZ1Z093Zlk3Z2FzTGFBUWR6ekRU?=
 =?utf-8?B?bkwyTmVhTEV3bysrWkdJYnhhTW1VR1UyZE9qWEJ1VGRDRUY5UC9vbCtJVmZG?=
 =?utf-8?B?Wm42SDBHVDZINTN6QlFuU2JyZmpZdW9DSmc1aFV3b1dpS0xOTFl5TDdlcEgw?=
 =?utf-8?B?WitHdDhPNFV2K2JNamJPd0VZVXh1alM2T1dSTWtZZEhGeXFBNGNmMEdlNTI1?=
 =?utf-8?B?L0Zjc3dpS1U0Nlo2dGtoMUg4Q2YxeXU0V0J4REg0TlVyU3NYZ2pLb09qYUJD?=
 =?utf-8?B?anVDdWtVbnpDcHh2TjZxa1JBaU5LSEdteGlkUEx5Nm5WaSsrZ3RlSXVSRUhj?=
 =?utf-8?B?SkhmRXkyQ002MFpDMytHZksxYVZVcjRoNEFsRGxJR1F5MitraGE3RjlmcjM1?=
 =?utf-8?B?cEUra09uekp3cUFPVmlHRUtvdVN4blZJY0s5VkZTWlpwcmFPTWJSRUxlTHpR?=
 =?utf-8?B?OWpZODI2SXMwbWtSZ1l1d1o0QkJTTE1TQlVDYjJjY3NQcXI3OVVSV2VUR0My?=
 =?utf-8?B?MTVuRitFb2ZkazlmUlIrM1MwL2tuck45UzVPWXV4UmVlaWM3c3BlTzlaQTlB?=
 =?utf-8?B?elYvb1RyWWJqUkIwQmZ4NGF5RVptUXZHMUZmQzJ1VlU3dnNLS2d0aVVXV2NO?=
 =?utf-8?B?VzJyOSttdGYrVEJNRkl0VmVWNjY4S0o1bis5YnArSjVNazZaek1OOFBkMFBM?=
 =?utf-8?B?UjVXMnAvVXJ5V05XUDRXaHNVR3FXSzVSVVowdGFRNzJiN0EvcitVOWdMbk5R?=
 =?utf-8?B?UnZGTGprb3Zra3hqbUpEeTZUeEJaN1hvMTZqM2R0bWN6amN3OVdjaGRSbmF5?=
 =?utf-8?B?bEJ5RHljWTdsSDBoTmhjUmprU1kvRUErZEIvbkIxM21JL05EdklGQ0pNUVIy?=
 =?utf-8?B?eTI1NnJsR1lyYTBKRENKcENKZVFNakJRYjJabUM5MWU5TzFqZFAzMGExZDZC?=
 =?utf-8?B?aTlIMmd5MUFFNk5YOXRhOTA3aWFvYkI4eUQ3emhKRmk5WUpCM2NVL2hiM09s?=
 =?utf-8?B?OE8yWVZ5ZVphNVRwSStJU0VHSEE5dHUvU3g0cjJRSkNPZThCMXF1WHpUZ0o1?=
 =?utf-8?B?QWJGd2E2R0lVNlhEajdwUWs0NmovZzdFM1BValllMWFIR0IrbDFOOEk5cENk?=
 =?utf-8?B?NlZYRjlRVEVFZHNvQldPZkxqWkJMd09kS05La0dkeXEyRTVITlVkR2N5Sm54?=
 =?utf-8?B?cXE3QzlhazBnQVJoWjBrdThzZTdxRFpDUkRPTFJwcDdOUVY0TnZ0cDFNZHJt?=
 =?utf-8?B?cENkKzVYcnEydktKK3JpUHN1RG13dlRPc2pWOTNCVXNyVU1SQnFnS0tWbk1Z?=
 =?utf-8?B?cWpQQ2I0UEswdkdRcEFjR1FxbW1pQUlsWFN3bGIxM2xkalA5VlVJWklna3JJ?=
 =?utf-8?B?aXlaVVhpNC9Ia0RyN2FkTDlzVHZFU3NHczJUS2tIamthTGx2aFJYdTNoNUVK?=
 =?utf-8?B?blU2anRCOHN0ZEFITjRzb3B6VCtjTTZ0ZzFXYXNrTUR0UDlsdGtEU3hkaDJW?=
 =?utf-8?B?VWxWV21wczUvc0tPeVpsaklndkVzVCtqaWxnM21HdlRISjFraGZGV3V5SjZn?=
 =?utf-8?Q?5+FNRs22uN7jlmmpW0Pczq0q31E44GztycvAycn?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eGV4TzBINHVia2pkT3ZKTXhtMkxYcVNlQWRMQUk0My9ITFFaY2dxWEowQUlz?=
 =?utf-8?B?UHErUk4zQ1hLUHRXbDBMWGlJdC9HWEhxOTl2TG16U3U0ZlhMRUdlcSs5amox?=
 =?utf-8?B?V0RIL0NwMVVkU3Fhc1YySmFnMnhzRGY4WHJrMVZHbUkwZ08vNml0NnI2Wm8y?=
 =?utf-8?B?OUExYWhlT2labTREYmdYNDVSNjlQTDhCa1FoM3RJRkN2R1A5czR4M1dxd2JO?=
 =?utf-8?B?TjRVNUltRzEwTFMzbk1xSUlPRVQrTDNSUlMxNUN1WmVGbXo2WTNWM1RDZWJm?=
 =?utf-8?B?S3V6LzlIaHJMQ0RaZVZIUmh3b2FVT1VuUk16cVJaVUVub1d6SllvOE1lUnJZ?=
 =?utf-8?B?bHpsd0VoQzVrcVZSTlIwSXQ3bU4vazU4c29leUxzenVoTm84R3ZaSlFpV0Js?=
 =?utf-8?B?NGdjZnZabmxYNFhLMkovc09tTU5TZFQ3YVZBakpMSlE5elYyaUQ1WlpDNVFG?=
 =?utf-8?B?Zi9SMSszTWk0QkJqRVJablhUUEo1WUxNSnlocGJUSWJzby9OVmxDaUVJM0VX?=
 =?utf-8?B?VStTY0diWTZyeDRqZStQWDRpSHlReWZUVnpDaVNmZlA4TEdhMWRvbzZIU0lq?=
 =?utf-8?B?cEJ6REcxdlhMOWlaUjRHWnd5OHc1czVwTU5ZL0NiNS92cTkvdVhXY1NSc0ZY?=
 =?utf-8?B?UmFpbk9URWpMOTRzOFdJdU9xYjU0ak12L0haU2k1bW5vVlNQWWI5Nk1iYUJF?=
 =?utf-8?B?NnBHdk1OWDNnSG9JRG1GWnJVcE1JTjQvYkYyYUNNbGxVVWlyQmhVRzJRRmhm?=
 =?utf-8?B?VW9oZSt3bXNvK0hENVNZSkpUZEZXVU42Zkh0YmhvMmpBSHlaM29IMitQaUV5?=
 =?utf-8?B?dGRPeUxBQXpwSkl2VS9ia0MyR0RKaklSU1U5ekI0TUpOYzdHenhYVnc2WXZp?=
 =?utf-8?B?Yk1SdTNnd3N2WThzZVhVcUJ3RE5TeThZenVCSVZ2QTFYVWhvQ1FYUWpiTDUw?=
 =?utf-8?B?WGJhMCtWYTFML000ZHhxS1ZsaFNVM2ZKSm1sN243dFArSmJSaU92TlcxTkJZ?=
 =?utf-8?B?amUzUWhacnl0dGMxMSs2SlNJcGNKSVdSOHI2WXdlUy91VWZTbHUwQ1dGbk1F?=
 =?utf-8?B?anpiMnlSMHgxLzBmOG5oMWFobCt5QUxkZXNVQndYTzB2NTZ0R29yN2NrRGhv?=
 =?utf-8?B?WkhRTHNQdEo1RVVZREFpN09vTlRGeG5xQTR3Z3FnWmtmd1N6aFI4cENGR2F3?=
 =?utf-8?B?UkVPblc3WDhyRG5lVUZZWkNMOHJJSFFvbU9ueFRRc0ZCREhRRkZ3akpjR2Q5?=
 =?utf-8?B?NStmdDZrRURsYnJYZ0pHSFA1TkZhTmJSYTduZWFVTFlTSFMzdmtldjhGL281?=
 =?utf-8?B?bVlURmNFZVBDVVFLVGZhMDNuY1JObVU4TDN1K3ZRaFlvcWhKSG8rUG45cTV6?=
 =?utf-8?B?UHRuWHViY3d3OHFaTFhKY0o1U0hRV09JbUhjWXdOUGdIM3M1YmpBSG5wbm11?=
 =?utf-8?B?dEV4VE55TjVHZkUwSnhtOG1mbVRwWWZQYWtibnptaW5ZYnp4bllPcFI4Nmkz?=
 =?utf-8?B?citHWm01eEk5UkU3Z0dQdStjM1A4Q2JwV0tUOXMvZVh0VFJ3Rlo2QmVCbkJC?=
 =?utf-8?B?aDN6cWNrY2VIb0RkMTVMSkFNd2hsU0VTWDN4OFFoNmF5a2xVbXBnekthVDgw?=
 =?utf-8?B?OEoxazBwdHJJYlBSMjBhcFNaV1kwT0ppa3dXcmFHdFdaSlAxWG9xODlwcTVU?=
 =?utf-8?B?aTdKSlpnUnVFM2kwMXgwUDkvSzNsTFRZcVZaZnU0dEt2VlV6SzFqRVNxNlJt?=
 =?utf-8?B?ZndLRDk0c25udDZVb2xhL3YrWGx0R3JuMGNCMStzZnBrYVFNcTdWbWtNREsw?=
 =?utf-8?B?ZTdwTEs4UkQzeTR0NzgvMHVqWjVxSW85TmtJd0t2cXpxOWxJaXVvQUNYaVBV?=
 =?utf-8?B?Y1pMS3h4TXlGYkRTR1hHOUxCZTZ1VDV1LzgveEZiZ01lN1JpaW8xNlUvRWtD?=
 =?utf-8?B?YmZsSDNrUFVMYUNuRmgwRzU4ZHpJMG1veVJyQ3ZlNkMrUWVKWUdlWDIrR210?=
 =?utf-8?B?U1JMR1V4c3ZuL0hzLzAwK3RKTDBsbW93MmZXYlVmYW5tMHdvQTRva0xnYkQw?=
 =?utf-8?B?S3BYQXEzRDNXL1hScjF4VzVTL3hoVWRWZ1EwQjUrL3l5OHU1eUk1anFRUFJH?=
 =?utf-8?B?WnczYUhwdTh6dXJ0RWxDQ293RFJ1UDB4UmtXaFBDY1dJL3M1UzdzL3RlVVA0?=
 =?utf-8?Q?ojE0Fratf8jhab+aJy0i+zw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C795B0D5C7B3AB4A828E1BCF8FC569C0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8739.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25aa2e56-9e40-46f6-3949-08dcf993e1f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 10:07:52.5864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9BvPzCt01nVUNvXIvEJVg3tPmX+4tooYCGjNg2MWKF6fvu+WqaAJ1AbQxVeFvB3+Rl0WonXiOHPivrVJZAcpcMw8SngOIqhBQ9FBt7ajvr2yX1YqF/hdy1bnvr6ncBNX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8734

T24gMjkvMTAvMjAyNCAxMjo0OCwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gRnJpLCBPY3QgMjUsIDIwMjQgYXQgMDE6NTE6
MDlQTSArMDEwMCwgVmFsZW50aW5hIEZlcm5hbmRleiB3cm90ZToNCj4+IEFkZCBhIGR0LWJpbmRp
bmcgZm9yIHRoZSBNaWNyb2NoaXAgSW50ZXItUHJvY2Vzc29yIENvbW11bmljYXRpb24gKElQQykN
Cj4+IG1haWxib3ggY29udHJvbGxlci4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBWYWxlbnRpbmEg
RmVybmFuZGV6IDx2YWxlbnRpbmEuZmVybmFuZGV6YWxhbmlzQG1pY3JvY2hpcC5jb20+DQo+PiAt
LS0NCj4+ICAgLi4uL2JpbmRpbmdzL21haWxib3gvbWljcm9jaGlwLHNiaS1pcGMueWFtbCAgIHwg
MTA4ICsrKysrKysrKysrKysrKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMTA4IGluc2VydGlv
bnMoKykNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9tYWlsYm94L21pY3JvY2hpcCxzYmktaXBjLnlhbWwNCj4+DQo+PiBkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gvbWljcm9jaGlwLHNi
aS1pcGMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L21p
Y3JvY2hpcCxzYmktaXBjLnlhbWwNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAw
MDAwMDAwMDAwMDAuLjkwYTc5MzIxMThiNQ0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gvbWljcm9jaGlwLHNiaS1pcGMu
eWFtbA0KPj4gQEAgLTAsMCArMSwxMDggQEANCj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4+ICslWUFNTCAxLjINCj4+ICstLS0N
Cj4+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL21haWxib3gvbWljcm9jaGlw
LHNiaS1pcGMueWFtbCMNCj4+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1z
Y2hlbWFzL2NvcmUueWFtbCMNCj4+ICsNCj4+ICt0aXRsZTogTWljcm9jaGlwIEludGVyLXByb2Nl
c3NvciBjb21tdW5pY2F0aW9uIChJUEMpIG1haWxib3ggY29udHJvbGxlcg0KPj4gKw0KPj4gK21h
aW50YWluZXJzOg0KPj4gKyAgLSBWYWxlbnRpbmEgRmVybmFuZGV6IDx2YWxlbnRpbmEuZmVybmFu
ZGV6YWxhbmlzQG1pY3JvY2hpcC5jb20+DQo+PiArDQo+PiArZGVzY3JpcHRpb246DQo+IA0KPiBZ
b3UgbmVlZCAnPicgYW5kIGJsYW5rIGxpbmUgaW4gYmV0d2VlbiBlYWNoIHBhcmFncmFwaCBpZiB5
b3Ugd2FudCB0aGUNCj4gcGFyYWdyYXBocyBtYWludGFpbmVkLg0KPiANCj4gRWxzZXdoZXJlIHRv
by4NCj4gDQo+PiArICBUaGUgTWljcm9jaGlwIEludGVyLXByb2Nlc3NvciBDb21tdW5pY2F0aW9u
IChJUEMpIGZhY2lsaXRhdGVzDQo+PiArICBtZXNzYWdlIHBhc3NpbmcgYmV0d2VlbiBwcm9jZXNz
b3JzIHVzaW5nIGFuIGludGVycnVwdCBzaWduYWxpbmcNCj4+ICsgIG1lY2hhbmlzbS4NCj4+ICsg
IFRoaXMgU0JJIGludGVyZmFjZSBpcyBjb21wYXRpYmxlIHdpdGggdGhlIE1pLVYgSW50ZXItaGFy
dA0KPj4gKyAgQ29tbXVuaWNhdGlvbiAoSUhDKSBJUC4NCj4+ICsgIFRoZSBtaWNyb2NoaXAsc2Jp
LWlwYyBjb21wYXRpYmxlIHN0cmluZyBpcyBpbnRlZGVkIGZvciB1c2UgYnkgc29mdHdhcmUNCj4+
ICsgIHJ1bm5pbmcgaW4gc3VwZXJ2aXNvciBwcml2aWxlZ2VkIG1vZGUgKHMtbW9kZSkuIFRoZSBT
b0Mtc3BlY2lmaWMNCj4+ICsgIGNvbXBhdGlibGVzIGFyZSBpbnRlZGVkIGZvciB1c2UgYnkgdGhl
IFNCSSBpbXBsZW1lbnRhdGlvbiBpbiBtYWNoaW5lDQo+IA0KPiBpbnRlbmRlZA0KPiANCj4+ICsg
IG1vZGUgKG0tbW9kZSkuDQo+IA0KPiBUaGlzIHBlciBjb21wYXRpYmxlIGluZm9ybWF0aW9uIHNo
b3VsZCBiZSB3aXRoIHRoZSBjb21wYXRpYmxlcy4NCj4gDQo+PiArDQo+PiArcHJvcGVydGllczoN
Cj4+ICsgIGNvbXBhdGlibGU6DQo+PiArICAgIGVudW06DQo+PiArICAgICAgLSBtaWNyb2NoaXAs
c2JpLWlwYw0KPj4gKyAgICAgIC0gbWljcm9jaGlwLG1pdi1paGMtcnRsLXYyDQo+IA0KPiBUbyBh
ZGQgcGVyIGNvbXBhdGlibGUgZGVzY3JpcHRpb25zLCB5b3UgY2FuIGRvOg0KPiANCj4gb25lT2Y6
DQo+ICAgIC0gY29uc3Q6DQo+ICAgICAgZGVzY3JpcHRpb246IC4uLg0KPiAgICAtIGNvbnN0Og0K
PiAgICAgIGRlc2NyaXB0aW9uOiAuLi4NCj4gDQo+IA0KPiANCj4+ICsNCj4+ICsgIHJlZzoNCj4+
ICsgICAgbWF4SXRlbXM6IDENCj4+ICsNCj4+ICsgIGludGVycnVwdHM6DQo+PiArICAgIG1pbkl0
ZW1zOiAxDQo+PiArICAgIG1heEl0ZW1zOiA1DQo+PiArDQo+PiArICBpbnRlcnJ1cHQtbmFtZXM6
DQo+PiArICAgIG1pbkl0ZW1zOiAxDQo+PiArICAgIG1heEl0ZW1zOiA1DQo+PiArICAgIGl0ZW1z
Og0KPj4gKyAgICAgIHBhdHRlcm46ICJeaGFydC1bMC01XSskIg0KPiANCj4gSXMgdGhlIG51bWJl
cmluZyBhbHdheXMgY29udGlndW91cyAoZS5nLiBub3QgImhhcnQtMCwgaGFydC0zIik/IElmIHNv
LA0KPiBkcm9wIHRoZSBuYW1lcy4gQSBuYW1lIG1hdGNoaW5nIHRoZSBpbmRleCBvZiB0aGUgZW50
cnkgaXMgbm90IHVzZWZ1bC4NCk51bWJlcmluZyBjYW4gYmUgbm9uLWNvbnRpZ3VvdXMgYmFzZWQg
b24gdGhlIHVzZXIncyBBTVAgY29uZmlndXJhdGlvbiANCihlLmcuLCAnaGFydC0zJywgJ2hhcnQt
NCcsICdoYXJ0LTEnKS4NCg0KVGhhbmtzIGZvciB0aGUgcmVzdCBvZiB0aGUgZmVlZGJhY2ssIEkn
bGwgaW1wbGVtZW50IHRob3NlIGNoYW5nZXMgaW4gdjMuDQo+IA0KPj4gKw0KPj4gKyAgIiNtYm94
LWNlbGxzIjoNCj4+ICsgICAgZGVzY3JpcHRpb246DQo+PiArICAgICAgRm9yIHRoZSBTQkkgImRl
dmljZSIsIHRoZSBjZWxsIHJlcHJlc2VudHMgdGhlIGdsb2JhbCAibG9naWNhbCIgY2hhbm5lbCBJ
RHMuDQo+PiArICAgICAgVGhlIG1lYW5pbmcgb2YgY2hhbm5lbCBJRHMgYXJlIHBsYXRmb3JtIGZp
cm13YXJlIGRlcGVuZGVudC4gVGhlDQo+PiArICAgICAgU29DLXNwZWNpZmljIGNvbXBhdGlibGVz
IGFyZSBpbnRlbmRlZCBmb3IgdXNlIGJ5IHRoZSBTQkkgaW1wbGVtZW50YXRpb24sDQo+PiArICAg
ICAgcmF0aGVyIHRoYW4gcy1tb2RlIHNvZnR3YXJlLiBUaGVyZSB0aGUgY2VsbCB3b3VsZCByZXBy
ZXNlbnQgdGhlIHBoeXNpY2FsDQo+PiArICAgICAgY2hhbm5lbCBhbmQgZG8gbm90IHZhcnkgZGVw
ZW5kaW5nIG9uIHBsYXRmb3JtIGZpcm13YXJlLg0KPj4gKyAgICBjb25zdDogMQ0KPj4gKw0KPj4g
KyAgbWljcm9jaGlwLGloYy1jaGFuLWRpc2FibGVkLW1hc2s6DQo+PiArICAgIGRlc2NyaXB0aW9u
Og0KPj4gKyAgICAgIFJlcHJlc2VudHMgdGhlIGVuYWJsZS9kaXNhYmxlIHN0YXRlIG9mIHRoZSBi
aS1kaXJlY3Rpb25hbCBJSEMgY2hhbm5lbHMNCj4+ICsgICAgICB3aXRoaW4gdGhlIE1JVi1JSEMg
SVAgY29uZmlndXJhdGlvbi4gVGhlIG1hc2sgaXMgYSAxNi1iaXQgdmFsdWUsIGJ1dCBvbmx5DQo+
PiArICAgICAgdGhlIGZpcnN0IDE1IGJpdHMgYXJlIHV0aWxpemVkLkVhY2ggb2YgdGhlIGJpdHMg
Y29ycmVzcG9uZHMgdG8NCj4+ICsgICAgICBvbmUgb2YgdGhlIDE1IElIQyBjaGFubmVscy4NCj4+
ICsgICAgICBBIGJpdCBzZXQgdG8gJzEnIGluZGljYXRlcyB0aGF0IHRoZSBjb3JyZXNwb25kaW5n
IGNoYW5uZWwgaXMgZGlzYWJsZWQsDQo+PiArICAgICAgYW5kIGFueSByZWFkIG9yIHdyaXRlIG9w
ZXJhdGlvbnMgdG8gdGhhdCBjaGFubmVsIHdpbGwgcmV0dXJuIHplcm8uDQo+PiArICAgICAgQSBi
aXQgc2V0IHRvICcwJyBpbmRpY2F0ZXMgdGhhdCB0aGUgY29ycmVzcG9uZGluZyBjaGFubmVsIGlz
IGVuYWJsZWQNCj4+ICsgICAgICBhbmQgd2lsbCBiZSBhY2Nlc3NpYmxlIHRocm91Z2ggaXRzIGRl
ZGljYXRlZCBhZGRyZXNzIHJhbmdlIHJlZ2lzdGVycy4NCj4+ICsgICAgICBUaGUgcmVtYWluaW5n
IGJpdCBvZiB0aGUgMTYtYml0IG1hc2sgaXMgcmVzZXJ2ZWQgYW5kIHNob3VsZCBiZSBpZ25vcmVk
Lg0KPj4gKyAgICAgIFRoZSBhY3R1YWwgZW5hYmxlL2Rpc2FibGUgc3RhdGUgb2YgZWFjaCBjaGFu
bmVsIGlzIGRldGVybWluZWQgYnkgdGhlDQo+PiArICAgICAgSVAgYmxvY2vigJlzIGNvbmZpZ3Vy
YXRpb24uDQo+PiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3Vp
bnQxNg0KPj4gKyAgICBkZWZhdWx0OiAwDQo+PiArDQo+PiArcmVxdWlyZWQ6DQo+PiArICAtIGNv
bXBhdGlibGUNCj4+ICsgIC0gaW50ZXJydXB0cw0KPj4gKyAgLSBpbnRlcnJ1cHQtbmFtZXMNCj4+
ICsgIC0gIiNtYm94LWNlbGxzIg0KPj4gKw0KPj4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxz
ZQ0KPj4gKw0KPj4gK2FsbE9mOg0KPj4gKyAgLSBpZjoNCj4+ICsgICAgICBwcm9wZXJ0aWVzOg0K
Pj4gKyAgICAgICAgY29tcGF0aWJsZToNCj4+ICsgICAgICAgICAgY29udGFpbnM6DQo+PiArICAg
ICAgICAgICAgY29uc3Q6IG1pY3JvY2hpcCxzYmktaXBjDQo+PiArICAgIHRoZW46DQo+PiArICAg
ICAgcHJvcGVydGllczoNCj4+ICsgICAgICAgIHJlZzogZmFsc2UNCj4+ICsgICAgICAgIG1pY3Jv
Y2hpcCxpaGMtY2hhbi1kaXNhYmxlZC1tYXNrOiBmYWxzZQ0KPj4gKyAgICBlbHNlOg0KPj4gKyAg
ICAgIHJlcXVpcmVkOg0KPj4gKyAgICAgICAgLSByZWcNCj4+ICsgICAgICAgIC0gbWljcm9jaGlw
LGloYy1jaGFuLWRpc2FibGVkLW1hc2sNCj4+ICsNCj4+ICtleGFtcGxlczoNCj4+ICsgIC0gfA0K
Pj4gKyAgICBtYWlsYm94IHsNCj4+ICsgICAgICBjb21wYXRpYmxlID0gIm1pY3JvY2hpcCxzYmkt
aXBjIjsNCj4+ICsgICAgICBpbnRlcnJ1cHQtcGFyZW50ID0gPCZwbGljPjsNCj4+ICsgICAgICBp
bnRlcnJ1cHRzID0gPDE4MD4sIDwxNzk+LCA8MTc4PjsNCj4+ICsgICAgICBpbnRlcnJ1cHQtbmFt
ZXMgPSAiaGFydC0xIiwgImhhcnQtMiIsICJoYXJ0LTMiOw0KPj4gKyAgICAgICNtYm94LWNlbGxz
ID0gPDE+Ow0KPj4gKyAgICB9Ow0KPj4gKyAgLSB8DQo+PiArICAgIG1haWxib3hANTAwMDAwMDAg
ew0KPj4gKyAgICAgIGNvbXBhdGlibGUgPSAibWljcm9jaGlwLG1pdi1paGMtcnRsLXYyIjsNCj4+
ICsgICAgICBtaWNyb2NoaXAsaWhjLWNoYW4tZGlzYWJsZWQtbWFzaz0gIC9iaXRzLyAxNiA8MD47
DQo+IA0KPiBJbmNvcnJlY3QgZm9ybWF0dGluZyBhcm91bmQgdGhlICc9Jy4NCj4gDQo+PiArICAg
ICAgcmVnID0gPDB4NTAwMDAwMDAgMHgxQzAwMD47DQo+PiArICAgICAgaW50ZXJydXB0LXBhcmVu
dCA9IDwmcGxpYz47DQo+PiArICAgICAgaW50ZXJydXB0cyA9IDwxODA+LCA8MTc5PiwgPDE3OD47
DQo+PiArICAgICAgaW50ZXJydXB0LW5hbWVzID0gImhhcnQtMSIsICJoYXJ0LTIiLCAiaGFydC0z
IjsNCj4+ICsgICAgICAjbWJveC1jZWxscyA9IDwxPjsNCj4+ICsgICAgfTsNCj4+IC0tDQo+PiAy
LjM0LjENCj4+DQoNCg==

