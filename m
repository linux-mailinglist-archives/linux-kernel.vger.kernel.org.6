Return-Path: <linux-kernel+bounces-348208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD5B98E421
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0C361F21B63
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6762E216A34;
	Wed,  2 Oct 2024 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A4v8Js1K"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE78F1D0DE9
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 20:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727900782; cv=fail; b=VUhlWKPq3D71bUN1wwhOTC9VcGIIXCuOA1omYPHG/rNvqfRTFtoMQ6km9GN2hoobMYN7UxsAlKvXzh/LIqBnCukq1WaiRe1kv+DoO3z4o3I7iToCDOktIpC0FFrwyTtEpRcpo60s8EgXBg7E4yZJEgnP3/sPuBdOEA/EGpbV65M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727900782; c=relaxed/simple;
	bh=9MpZVPJ6/BNbvliJgxxcJIAemMumPiGXgCLaUl9NNMk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A3goDJZO80lqq2xgDJfBRGThhbSnL8vTKUoMHUvPYf18+KNz/d5EaH/fsjFht8jCgdy+lRRhKKHI3+bkX7Fu1JZXf6o8I8r+DsIsmBDXip51npu7/2yBsesPpn57Tn9fV5EdAF83Iwk4tt0IqaWO5naGdrehD//1OKlRdk+dwW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A4v8Js1K; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDHi4NArqmPmnyohNwXo9yHxiZfUdUZP5leezIn3nyEJ4UCXuMA0ifHDxGgfZgf1Wg9mrbYdG0eYQ6emSNLjKrI67BjtVLPiiyZXWWNqBnj+HciOgrFms8jWuPtf7mmosBjmz/nExfeQmUAelAuLfVBrjO5v6qQj7ydXLJ7mZwsa/IqhowYC9JcR87BtodJ0WvFh7a+VlYAj9+ozwOFtjxAHsZzwtxFXIcQ8nUToyot84IMr6Z3MiJLyJdZqv+s6wttE4+aavSXauwW4DgfZhm3Jq8kXJHVTcN7dexWMIYvE+3syC3qcoN+1RpbO5IUKlc8xXS1GIB9rCTfV/T029Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MpZVPJ6/BNbvliJgxxcJIAemMumPiGXgCLaUl9NNMk=;
 b=dR1u6Zb5tlPXyeUScd51p4Lu+ob4IC+kBZ9qkUCr7lznq2PqnUny81mT/rBke9kMQwVkuLM8Kf+yv/wfDRwTdJ4+8tw+iP47yKO6pqnPUAH6UagPq5aUah6++5NCgTxlVSnMwRQWphSdUKepyIZQyiU5+xQNE7/eGD5gjb+bRANhWkNSy0NkJMSvThPWBVJbHSB00VlkeCZwGcLc405J8k95qVCpgPiiSsdKiA8Dl9ntndHbNT5V4kJpvtuxN5tIgeepINgyjbdX/QH1KyZ0b7dBb8h8oXuKODDMD2M6sTwRw4PRPwtIC0wZyWcDSYud3MVYsBUnpYW6p94/6hkHmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MpZVPJ6/BNbvliJgxxcJIAemMumPiGXgCLaUl9NNMk=;
 b=A4v8Js1KzV3XhqnK+2USmSwNL7I/uIk0SEhoWoOIbADdfwuVyiaZXJdc/eOrOCBJc8JuY8O6z07ANO5Wn/CF5JaIe+IKtyLvcGqRybOBwBdYVzN4gm6B67QDRgPaU10p+boJkj+jhwngTiO2ue5W0bVCOfXlLzJHpf+d1fqjpAo=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by SA3PR12MB7781.namprd12.prod.outlook.com (2603:10b6:806:31a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 20:26:17 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%4]) with mapi id 15.20.8005.024; Wed, 2 Oct 2024
 20:26:17 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: "Manwaring, Derek" <derekmn@amazon.com>
CC: "bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>
Subject: RE: [RFC PATCH 21/34] x86/bugs: Add attack vector controls for mds
Thread-Topic: [RFC PATCH 21/34] x86/bugs: Add attack vector controls for mds
Thread-Index: AQHbE5vjP+P7SIr340akC9fyjBzcW7JxIhhwgAFbm4CAAPwREIAAbZ+AgAAAkcA=
Date: Wed, 2 Oct 2024 20:26:17 +0000
Message-ID:
 <LV3PR12MB9265967C195B64DACCD7CBF094702@LV3PR12MB9265.namprd12.prod.outlook.com>
References:
 <LV3PR12MB9265C353BEB73FA98A75681794702@LV3PR12MB9265.namprd12.prod.outlook.com>
 <f4068cdc-2522-4730-b42d-991e886110ba@amazon.com>
In-Reply-To: <f4068cdc-2522-4730-b42d-991e886110ba@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4718946e-0133-4f74-af30-6f53919aead8;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-02T20:13:46Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|SA3PR12MB7781:EE_
x-ms-office365-filtering-correlation-id: 5f4719a9-38a7-4e8f-eb52-08dce320786f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L0R6Y2pSUkMvZjFuekVlVzRUMTNoMTZ1REppZU5xS1JNRmtKZXluaUo1ODZY?=
 =?utf-8?B?cFI2dzJINWhJUmlvZXFxZmFtanhWVUpnclpsVThsSlc0Z1ZLMnI3QjYyMHpP?=
 =?utf-8?B?S1M1bGNUWjVMZmZRTUV1S3QvaVhCc21iNnlQY2ZwMFh3QUhLNTFFUmhQbEJi?=
 =?utf-8?B?ZmhKOGM0SlhqWnorY1dPSThnSUtkamFmMlFTc0lxTml1RURDU2dnaVdXdHZz?=
 =?utf-8?B?anAvWTVTSFBWam45S1ZhUW8wWE81dWYzcCtOeVAxditIL1kvYkExa0RzeGt3?=
 =?utf-8?B?S1Rsa0t1cXZCaGJSelJWMVpvTGRXL2hqNzZ0bVF1d0M2OUYyMTB1Z3dEK3E0?=
 =?utf-8?B?QnlRZkdTTDE5cUFYYjd3RlBaWkdwZ3dVS2pnZVB2cnhYSlpIcHhSS0Rpem5z?=
 =?utf-8?B?R1hqN0xtb090SXpvS0VPRWE4NUpiTDRZVWExbUVZRUhPbWVrWUZyV2R6V0oy?=
 =?utf-8?B?MHhLL0U5SmZ0NmkvWFU5NUFJcDVRR2NuaXJzaklPbk12SmNBS0JETzRXNENt?=
 =?utf-8?B?dTlUU1JxSDFXdnZNVFdZSnNTdDNOK1pjNG5NTU5oajZvcFY1K0gwQlBIWitH?=
 =?utf-8?B?eTUzTTd6YTNzdThNQ3J6WlUxd2xhbHIyNGhyVWptbHYzUzhmT2pLSkk0ejRG?=
 =?utf-8?B?SGNGR3crVThEem9VN3RWM3hZKysyTWQ1N0RqNUpxa0pqWmJQNjBDUHlvQVIy?=
 =?utf-8?B?anZpaFB2OXJRUUQ0cDRlUnlvcEZ4NFZBMjR0ZnJac3RmSVY4NFY1S3ZGRUFx?=
 =?utf-8?B?R0FMOU5IaVJIWU81QlNuUXVOTjNLaFhWTDVpbU5vcVFwamc3djlQMC8vQ0tR?=
 =?utf-8?B?UldYTm9Xb1ovcWdRTmJveUM1ZjVUZ2RBMWhRNFlsSlkybTMwc0dCem5IVDYy?=
 =?utf-8?B?YWpRaTREOTRZZnNLNUJjelY5NGlwZ2sybXhySzB4eStSSmpTYitFZHV6UGE2?=
 =?utf-8?B?eU5DdlNFREQwREJLWk1oSzh5VU00OTZtaVJkMHd6VWw2dzhzWGcvVHV3c0JK?=
 =?utf-8?B?NnVRdzd3TU0zb2tWMTBCQUI3UkJWZS90NFBISi9tY3BhSEQraWxOalpsNE1Q?=
 =?utf-8?B?Z2pwY0loaG9aRDR4MStYL2JWTmlrR3Vkdm1uQnJUaHJSMVNQcUljWUZQR2tZ?=
 =?utf-8?B?Wkx6dzRFZ1JSZEQ3L21OVW4ydTcyYklOclYvekpPbGJhL2o5clpSV1lualJO?=
 =?utf-8?B?aVRkQWZXU2xuK2RCTUYvWTl6WURhenBaMmZDUlRwWm41d01hTnc1SXpsTGpY?=
 =?utf-8?B?bXpTTllvdnRteDFUR0ZKSVNuSDRrRzRXWGFlTkdQSkFPU0F5Z1lnUHJtYk9h?=
 =?utf-8?B?RUNNY0pRa2kvdXhnc3J3c3huR3NRMW4rb1pudFM2YTlGYTFuRnJHdERMaVJD?=
 =?utf-8?B?M3Z1MDBTRC9BMUJpL1BScVV0dkdIcjFzazhtVk9vUG05bXZWVWVRaHA3S09v?=
 =?utf-8?B?bS9Nc0t4OGJURjY5Qk83dGlHMVR3SnpkWGViY1ZteEZxRGtIWWpZVW8rd1dt?=
 =?utf-8?B?TXllL1J4WTlIWWNSQXRFbWNHRTdzb1czTVR4QklBa0Y3cWc4YlFGYVR0OWlv?=
 =?utf-8?B?UXRSQWIxRjJUZlNmaWtYUVhoTzRNQWM4Tm16L3VLZTdQaFF0ejZ0MU5vM2hX?=
 =?utf-8?B?enVMUkdIVHBPZm93YVhqZUdlWjdwamhicy81NEFIcFozUi9jQ3U5cmJxb0x1?=
 =?utf-8?B?VkJLY2p6TFdvNjc3SW1MWlZnUzN1eTBzaVhEMlR2cG5DNXd0aUJQaEFkdWxK?=
 =?utf-8?Q?9ELk3u+lEOKC3dHvNARTZD6JZWw/oZ3fXrbdFUd?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dHVvbmFMNTMybnIvOG12MXVNcS9Xblg4K0t0eTkxK2VqT1psZmkxVGp6b1o2?=
 =?utf-8?B?MzNKVkxJcGFBeW1NUG8yenY5akQxMmJwZGlZSVFwb3BGSGhRWEhMUy8xWGtZ?=
 =?utf-8?B?TnZNTkl5QVYvMFNLYjRkVVpVMWlLS1dZVDZZVEt1VVMzRDFBYnc0WnZBY29T?=
 =?utf-8?B?TXMwOWVteWlHQXJqNUpsQm1MVDA4RTJUVkhWYmp1WFp1bzIzUDJRdi9FVDc0?=
 =?utf-8?B?TDFtd2xIaWxiR3l0aTRVRXErMzR5NUZkbVh5Z3d0Ui9yMk5TSzdwTFFRWEda?=
 =?utf-8?B?UVQ1WGpXcHg2WHFHS1djVytLQWpEdHNDMGtmdEZ6RlV4T2RUK3ZJSEZXRERq?=
 =?utf-8?B?K004WStvcm9TVGNMRzV2THRmcXJlcUdkVmpoQTQ3QWxOb3hVZ1Z2Q0pKSk1q?=
 =?utf-8?B?M2hqNUlhaHd5SFpQSktMOFYyUGpUMTVOZC9Sd3ZPbE9VRmlGWGlWVXNxWFNG?=
 =?utf-8?B?aTYya1h0MXZ5QUJwL3ZMK1ZTVHZteDhVRk01TWRNQ0JNc0VranoybGFGY3p0?=
 =?utf-8?B?aFpuRjd0RElFd3JGTGFtS2VUV1l0UWM1WlRsU2pacC85UFA5VkhhbExCdW5x?=
 =?utf-8?B?WkdkcHBqTzVvWGVZVlRUZHVJbVVTN05lQUFLbmFnWEwxVGNKb3U3UXlyTnRY?=
 =?utf-8?B?TFF5TDEvZzNraUMvNHdWWDdnTEI0NjNrT2paSHc5RDkxTytKVng2bUFWVjNZ?=
 =?utf-8?B?S2RmeDFkaG1yVU1CZW13aFpnZEpXeHprMmx4cGYwVm95bFIvZ2RBUE9ad1hY?=
 =?utf-8?B?VEtjZ3ZFRkV0NWpLZlVsSnVWN2p5VGQrd09MM29NYm1iTExicS9EKyt3eDd2?=
 =?utf-8?B?OXR0a2U1ODFqNXFWQ3lWU1NxY3JpMEE1ZVgvWTRiYWZJbHUwdUUwK1VjajZ1?=
 =?utf-8?B?T2hVQXh3RUF0Z2FMM3ZtMXdRVUFXNFQ1Tk5YQ3lWbDVuaThqKyt4WVNMdm5u?=
 =?utf-8?B?cURsQnF0UTg1V3VTSjhmYmpNNGp6aDdPWGlMR2tiUytpU3lFNklwR09kQm15?=
 =?utf-8?B?ZjhrajhMdHZGOTZZRk5hclY1NG8wU0RKVWpqcElmMWJqQTdsL3M4REd0S2Z6?=
 =?utf-8?B?WndVUE5BWXduWUtPcElBeHc3MDNTRnJpZEJQa3VGWE5FQkN6TlNxcWZ5S1p0?=
 =?utf-8?B?NUFrZjlhRHBHWjdaZTRaa3hQN0RXb1ZMZHU2QnhtU3ExZFZWdnN1MmtiaUV6?=
 =?utf-8?B?YXJxQTFDRW5xYmRhUDBrQm11WHVmdWxlZUhPRkszL1dCZnFna2dQRUNaeHFO?=
 =?utf-8?B?amgwdFFWWnpla3hHMTBTbjJLRDFxSWRVYkc1WWNJYVROR1VMM0xIQnNOODc0?=
 =?utf-8?B?ckJobk1oaVlyRGJKQlhOYWkvUFBiV0tQUGZqRngxRFIvU1REdHQ3U2lFSjkw?=
 =?utf-8?B?UENlM1VCc3g3Z2pUZ0pNZlc2V1BEMnRiTXUxVkIzR1o0M3RrMXB6Zngza3BE?=
 =?utf-8?B?dDZaV1dVdmhXVlRDTnBjOTk3Y3VFT3laUEo5UDZLbENDeW4rcmxRVFpsMnYz?=
 =?utf-8?B?SW80V04zMk5ySnA5SjNLQjFUMll1bGd2eXR1VzdoSUQ4dnBZZXlDM2dUQ1BC?=
 =?utf-8?B?WnVRRzY1OHVpWXRlL1BaaHhSM1M4TkJUSlZDSHhrK0JxY2lyZkVPVlZBVUNF?=
 =?utf-8?B?MlVCNjcvN05KZ2NNeDU5dGo3akJYRlEvZnlJdzc2RGU5WGNvV045cWgxQldJ?=
 =?utf-8?B?akNUWG14WnVObVFLckdkaGpoNE12YzIwMHBUY2s3WDMzMzZmUWN5SURvQXZn?=
 =?utf-8?B?dGl5T1JUL2pweWNqSVBIUjVCcitBT2RrYXRoQVRjeUVoYjVPRkFlM0JHNEZr?=
 =?utf-8?B?NGpzTFQ1aHAyZXlXUGxGQ0p1bzJIL3NMMVRNckxjL2NzaGtGWEpBaTczTWtN?=
 =?utf-8?B?MnJxbVFSa0hKdVdxeE8zMUlaZWJ1azVDTE1UamxuOTZOdkw4dkMrM3RQcFlS?=
 =?utf-8?B?a2dBV2pDR1ZzUzV3Mk5leWs0YXpEeEZVOUw0UDhGZW1vNUdJOTBiWEg0UDFC?=
 =?utf-8?B?SW52SzM3amJTNzRoOFRKRUh3aUM0cmpsVENBamd0ZUdKSmVyN2RZbERvcWQ2?=
 =?utf-8?B?Z2d2RjJrSHJlYWhKVnBVREVPeEhZUFBtOFdWL09zcTdiNTltaE9kUHBZQnVk?=
 =?utf-8?Q?mfBw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4719a9-38a7-4e8f-eb52-08dce320786f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2024 20:26:17.8480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SmcTKMUp7HhGRluTXRX7YTWSnUgT/LxDpyxIUxpfUwVlbwv4keaCAq9eHrZbeKHY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7781

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW53YXJpbmcsIERlcmVr
IDxkZXJla21uQGFtYXpvbi5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciAyLCAyMDI0
IDM6MTIgUE0NCj4gVG86IEthcGxhbiwgRGF2aWQgPERhdmlkLkthcGxhbkBhbWQuY29tPg0KPiBD
YzogYnBAYWxpZW44LmRlOyBkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb207IGRlcmVrbW5AYW1h
em9uLmNvbTsNCj4gaHBhQHp5dG9yLmNvbTsganBvaW1ib2VAa2VybmVsLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbWluZ29AcmVkaGF0LmNvbTsgcGF3YW4ua3VtYXIuZ3Vw
dGFAbGludXguaW50ZWwuY29tOyBwZXRlcnpAaW5mcmFkZWFkLm9yZzsNCj4gdGdseEBsaW51dHJv
bml4LmRlOyB4ODZAa2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSRTogW1JGQyBQQVRDSCAyMS8zNF0g
eDg2L2J1Z3M6IEFkZCBhdHRhY2sgdmVjdG9yIGNvbnRyb2xzIGZvciBtZHMNCj4NCj4gQ2F1dGlv
bjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVzZSBw
cm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNraW5nIGxpbmtz
LCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBPbiAyMDI0LTEwLTAyIDE0OjI4KzAwMDAgRGF2aWQg
S2FwbGFuIHdyb3RlOg0KPiA+IE9uIDIwMjQtMTAtMDEgMjI6MzcrMDAwMCBEZXJlayBNYW53YXJp
bmcgd3JvdGU6DQo+ID4gPiBPbiAyMDI0LTEwLTAxIDAxOjU2KzAwMDAgRGF2aWQgS2FwbGFuIHdy
b3RlOg0KPiA+ID4gPiBPbiAyMDI0LTA5LTMwIDE3OjUwLTA3MDAgRGVyZWsgTWFud2FyaW5nIHdy
b3RlOg0KPiA+ID4gPiA+IE1heWJlIEknbSBtaXNzaW5nIHNvbWV0aGluZyBoZXJlIC0gaWYgeW91
IGNhcmUgYWJvdXQgdXNlci91c2VyLA0KPiA+ID4gPiA+IHdoeSB3b3VsZCB5b3Ugbm90IGNhcmUg
YWJvdXQgY3Jvc3MtdGhyZWFkPyBJdCBzZWVtcyB0byBtZSBTTVQNCj4gPiA+ID4gPiBzaG91bGQg
YmUgdHVybmVkIG9mZiBmb3IgYWxsIG9mIHRoZSB2ZWN0b3JzLg0KPiA+ID4gPg0KPiA+ID4gPiBJ
IGJyb2tlIG91dCBjcm9zcy10aHJlYWQgc2VwYXJhdGVseSB0byBtYWludGFpbiB0aGUgZXhpc3Rp
bmcNCj4gPiA+ID4ga2VybmVsIGRlZmF1bHRzLCB3aGljaCBkb2VzIG5vdCBkaXNhYmxlIFNNVCBi
eSBkZWZhdWx0IGV2ZW4gaWYNCj4gPiA+ID4gZnVsbCBtaXRpZ2F0aW9uIHJlcXVpcmVzIGl0Lg0K
PiA+ID4NCj4gPiA+IE9rIHRoYXQgbWFrZXMgYSBsb3Qgb2Ygc2Vuc2UuIE15IGJpYXMgd291bGQg
YmUgdG8gdXNlIHRoZSB2ZWN0b3INCj4gPiA+IHBhcmFtZXRlcnMgYXMgYW4gb3Bwb3J0dW5pdHkg
dG8gbWFrZSB0aGUgU01UIHN0YW5jZSBtb3JlIG9idmlvdXMuIFNvDQo+ID4gPiBrZXJuZWwncyBw
b3NpdGlvbiBiZWNvbWVzIG1vcmUgb2YgIkkgZGlzYWJsZWQgU01UIGJlY2F1c2UgeW91IGFza2Vk
IGZvcg0KPiBwcm90ZWN0aW9uIHdpdGggbWl0aWdhdGVfdXNlcl91c2VyIg0KPiA+ID4gKG9yIGFu
eSBvdGhlciB2ZWN0b3IpLiBJZiBubyB2ZWN0b3IgcGFyYW1ldGVycyBhcmUgc3BlY2lmaWVkLCBT
TVQNCj4gPiA+IGRlZmF1bHQgd291bGQgYmUgbWFpbnRhaW5lZC4gV2hhdCBhcmUgeW91ciB0aG91
Z2h0cyBvbiBkaXNhYmxpbmcgU01UDQo+ID4gPiBpZiBhIHZlY3RvciBwYXJhbWV0ZXIgaXMgZXhw
bGljaXRseSBzdXBwbGllZD8NCj4gPg0KPiA+IEhtbSwgSSdtIG5vdCBxdWl0ZSBzdXJlIGhvdyB0
byBkbyB0aGF0IGJlY2F1c2UgbWl0aWdhdGVfdXNlcl91c2VyDQo+ID4gZGVmYXVsdHMgdG8gJ29u
JyAoYWdhaW4sIHRvIG1haW50YWluIHRoZSBleGlzdGluZyBrZXJuZWwgZGVmYXVsdHMpLg0KPiA+
IEl0IHNlZW1zIG9kZCB0byBtZSB0aGF0IGV4cGxpY2l0bHkgc3BlY2lmeWluZyAnbWl0aWdhdGVf
dXNlcl91c2VyPW9uJw0KPiA+IHdvdWxkIHJlc3VsdCBpbiBkaWZmZXJlbnQgYmVoYXZpb3IuICBB
bmQgSSB0aGluayBtYW55IHZ1bG5lcmFiaWxpdGllcw0KPiA+IHRoYXQgcmVxdWlyZSBTTVQgZGlz
YWJsZWQgd2lsbCBhbHJlYWR5IHByaW50IG91dCBhIHdhcm5pbmcgaWYNCj4gPiBtaXRpZ2F0aW9u
IGlzIHJlcXVlc3RlZCBhbmQgU01UIGlzIGVuYWJsZWQuICBPcGVuIHRvIGlkZWFzIGhlcmUuLi4N
Cj4NCj4gWWVhaCB0aGlzIHdvdWxkIGJlIGF3a3dhcmQuIE1heWJlIHRoZSB3YXJuaW5nIGlzIGVu
b3VnaC4gSXQganVzdCBtYWtlcyBTTVQNCj4gc3VjaCBhbiBleGNlcHRpb24uDQo+DQo+ID4gPiA+
IEluIHRoZW9yeSwgY3Jvc3MtdGhyZWFkIHByb3RlY3Rpb24gaXMgb25seSByZXF1aXJlZCBpZiB0
aGVyZSBpcyBhDQo+ID4gPiA+IHJpc2sgdGhhdCB1bnRydXN0ZWQgd29ya2xvYWRzIG1pZ2h0IHJ1
biBhcyBzaWJsaW5ncy4gIElmDQo+ID4gPiA+IHRlY2huaXF1ZXMgbGlrZSBjb3JlIHNjaGVkdWxp
bmcgYXJlIHVzZWQsIHRoaXMgbWlnaHQgYmUgYWJsZSB0byBiZSBwcmV2ZW50ZWQgSQ0KPiBzdXBw
b3NlLg0KPiA+ID4NCj4gPiA+IFRydWUsIHRob3VnaCBJIHRoaW5rIGl0J3Mgd29ydGggbWFraW5n
IGNsZWFyIHRoYXQgZG9pbmcgY29yZQ0KPiA+ID4gc2NoZWR1bGluZyBjb3JyZWN0bHkgaXMgdGhl
IHVzZXIncyByZXNwb25zaWJpbGl0eSwgYW5kIHRoZSB2ZWN0b3INCj4gPiA+IHByb3RlY3Rpb24g
dGhleSBhc2tlZCBmb3IgbWF5IGJlIGluY29tcGxldGUgaWYgdGhlcmUgYXJlIG1pc3Rha2VzIGlu
DQo+ID4gPiBob3cgdGhleSBtYW5hZ2UgcHJvY2VzcyBjb29raWVzLiBKdXN0IGFuIGlkZWEsIGJ1
dCB3aGF0IGlmIHVzZXJzIGhhZA0KPiA+ID4gdG8gYXNrIGZvciBTTVQgdG8gcmVtYWluIGVuYWJs
ZWQgaWYgdGhleSBoYWQgYWxzbyBhc2tlZCBmb3IgcHJvdGVjdGlvbiBmcm9tIG9uZQ0KPiBvZiB0
aGVzZSB2ZWN0b3JzPw0KPiA+DQo+ID4gSSB0aGluayB0aGUgZmFjdCB0aGF0IHNvbWUgbWl0aWdh
dGlvbnMgd2lsbCBwcmludCB3YXJuaW5ncyBpZiBTTVQgaXMNCj4gPiBlbmFibGVkIG1pZ2h0IGJl
IHN1ZmZpY2llbnQgaGVyZS4gIEkgY2FuIGFsc28gYWRkIHNvbWV0aGluZyBtb3JlIGFib3V0DQo+
ID4gY29yZSBzY2hlZHVsaW5nIGluIHRoZSBkb2N1bWVudGF0aW9uIGZpbGUuDQo+DQo+IFRoYXQg
d29ya3MuIFBlcnNvbmFsbHkgSSB3b3VsZCBzYXkgbWFrZSB0aGUgU01UIGFuZCBjb3JlIHNjaGVk
dWxpbmcgYml0cyBjbGVhciBpbg0KPiB0aGUgZG9jdW1lbnRhdGlvbiBhbmQgcmVtb3ZlIG1pdGln
YXRlX2Nyb3NzX3RocmVhZHMgc2luY2UgaXQncyBub3QgaW5oZXJlbnRseSB0d28NCj4gc2VwYXJh
dGUgZG9tYWlucyBsaWtlIHRoZSBvdGhlcnMgYXJlICh1c2VyL2tlcm5lbC9ndWVzdC9ob3N0KS4N
Cg0KSSB3YW50ZWQgdG8ga2VlcCBtaXRpZ2F0ZV9jcm9zc190aHJlYWQgYmVjYXVzZSBhIHBhcmFu
b2lkIHVzZXIgY291bGQgc2ltcGx5IHNldCBhbGwgYXR0YWNrIHZlY3RvciBjb250cm9scyB0byAn
b24nIGFuZCBrbm93IHRoZXkgYXJlIGZ1bGx5IG1pdGlnYXRlZCBhZ2FpbnN0IGV2ZXJ5dGhpbmcg
d2l0aG91dCBoYXZpbmcgdG8gd29ycnkgYWJvdXQgY29yZSBzY2hlZHVsaW5nLiAgTWl0aWdhdGlu
ZyBjcm9zcyB0aHJlYWQgYXR0YWNrcyBkb2Vzbid0IGFsd2F5cyBkaXNhYmxlIFNNVCwgaXQgZGVw
ZW5kcyBvbiB3aGF0IENQVSB5b3UncmUgcnVubmluZyBvbi4gIElmIEkgcmVtb3ZlZCB0aGF0IHZl
Y3RvciwgdGhlbiB5b3UnZCBoYXZlIHRvIGJvb3QgdXAgYW5kIHNlZSBpZiB5b3UgZ290IGFueSB3
YXJuaW5ncywgYW5kIHRoZW4gcmVib290IHdpdGhvdXQgU01ULg0KDQpQYXJ0IG9mIHRoZSBnb2Fs
IHdpdGggdGhlIGF0dGFjayB2ZWN0b3Igc3R1ZmYgaXMgdG8gYmUgZnV0dXJlLWNvbXBhdGlibGUu
ICBTbyBldmVuIGlmIHlvdSdyZSBjdXJyZW50bHkgcnVubmluZyBvbiBIVyB0aGF0IGRvZXNuJ3Qg
cmVxdWlyZSBkaXNhYmxpbmcgU01UIGZvciBtaXRpZ2F0aW9uLCBidXQgdGhlbiB5b3UgbW92ZSB0
byBuZXcgSFcgdGhhdCBkb2VzLCB5b3UgZG9uJ3QgaGF2ZSB0byBjaGFuZ2UgYW55dGhpbmcgYXMg
dGhlIHN5c3RlbSB3aWxsIHJlbWFpbiBmdWxseSBtaXRpZ2F0ZWQuDQoNCkJ1dCBJIGRvIGFncmVl
IHRoYXQgY3Jvc3MtdGhyZWFkIGlzIGEgYml0IGRpZmZlcmVudCB0aGFuIHRoZSBvdGhlciB2ZWN0
b3JzLCBib3RoIGJlY2F1c2UgaXQncyBub3QgaW5oZXJlbnRseSBhY3Jvc3MgZG9tYWlucyBidXQg
YWxzbyBiZWNhdXNlIGl0cyByZWxldmFuY2UgbWF5IGJlIHJlbGF0ZWQgdG8gc2NoZWR1bGluZyBw
b2xpY3kgdGhhdCB0aGUga2VybmVsIGtub3dzIG5vdGhpbmcgYWJvdXQgKGF0IGJvb3QgdGltZSBh
dCBsZWFzdCkuDQoNCi0tRGF2aWQgS2FwbGFuDQoNCj4NCj4gSXQgc2hvdWxkIGJlIGNsZWFyIHRo
YXQgU01UIGlzIHRoZSBvbmUgY2FzZSB3aGVyZSBzcGVjaWZ5aW5nIGEgdmVjdG9yIHdpbGwgbm90
DQo+IG5lY2Vzc2FyaWx5IGdpdmUgeW91IHN1ZmZpY2llbnQgcHJvdGVjdGlvbiAodW5sZXNzIHdl
IGNhbiBmaW5kIGFuIGludHVpdGl2ZS9sb3ctDQo+IHN1cnByaXNlIHdheSB0byBkaXNhYmxlIFNN
VCB3aGVuIHJlcXVpcmVkIHRvIG1pdGlnYXRlIGNlcnRhaW4gdnVsbmVyYWJpbGl0aWVzIGZvciB0
aGUNCj4gY29uZmlndXJlZCB2ZWN0b3Igb24gYWZmZWN0ZWQgcGFydHMpLg0KPg0KDQo=

