Return-Path: <linux-kernel+bounces-511428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC45A32AFB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA3D1883519
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8F7212B31;
	Wed, 12 Feb 2025 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="druTi4rb"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AF71B21AD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739375984; cv=fail; b=sJ6764G/+o7ziwfY1EMvKIhQTQIgdKr6WNLaD7ghNeGTzezajdr0trH6ho3TLpN42pL+iB4EelSMw9Z8qER/ud5/X1SV6wxuiCfWG9VKhL6bIplYIxmTvyDxnivvEOcLK7tdIHaBFSJYllYZ6+Tr1af+RFPzm+OobcOk17G4tIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739375984; c=relaxed/simple;
	bh=c9QenRlTwwldKNM1dkeQi/Zq4Y8M2ffPa6hxlTS2xbU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bU+rvBTRe1XR5JzwmtH/bdr/1z4NdwsAHBOhMWzRMdLoANQazXOAsLyocj7wx9bhaPK/LycY4aEXdsccTJWQ8mEH/9uNZghIX2L8to+CEkuNEHQqC8KsFsOPW337WsLya9+TqnfT2kwFIKPDFIljtDxoW5MT1BFDzhqzwF5I6Pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=druTi4rb; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUaaatAxNgZ4Csw6sD8+qx+LbQm3xEvngdaw2kzQoBXnvzxBlMdTZQjC5olXFnrgSczZGnPyIHIWZ+HhYvtdITakfR9IdRw8q8ry/O0xBEDtPlxaswr3RUizN8vHFksYJRTXkQAbdIiYWaN4B+3fHaf2Q+MrkPLAzulA2K7+9svOnxaKe5ZVUWkCp0/OTSZ+xNTPPab6hpD6RPgYEl2NyM9xxl/c1rc59IoNaFRq5Ao6JUWis7aoFLrOlXxRGa/7VkEEeXdQGBXLAFQov95ZtwLNj8TQPM9s5gwZ460OIaauOLHZUDWdWcqNPiUMLWibo4bMnh0Akj+Spq/y/7/0bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9QenRlTwwldKNM1dkeQi/Zq4Y8M2ffPa6hxlTS2xbU=;
 b=mu5dnlB2FSEEWaIkN31TZxwD+kjHM1fKJq60gysn+AA8tPBrUs3gNnACyE///kY3JJabgb0bcMbvffmGxC4JKmZguZw3skZ9djRia5s4k08DB/WqzoINWSZdv+B0ZzsJO3cnmdDCuc7/W36KA6Z4xtU6ygxaX30FYbf08rD5hr6v3wnp32bAI3LjZodMmXWOaJuotGjHF7nwc3dtyu+t4IG8cLMi8q5LFUKj5UlgY7KA0oCKHlGe3tZ/EfnWqmoVsoE78FEmkSYXpSbFj20nnTNBCsyuuhRjVKMM3H/jhizapzgE9dtMR44/YIzVtm15edun2puPoHL3rKJPDZt7FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9QenRlTwwldKNM1dkeQi/Zq4Y8M2ffPa6hxlTS2xbU=;
 b=druTi4rb9zWraEOVr2GRJmbCFPaUTqfSBMe2UBgoEiMjXFfQ37u2KZBOIZ9AaQ43/dWt02WVwR8S1pZ400oY1fOuKUNqtv7/uK68XVoAZsHeWI7v3h6W1HF/OqGfuMGRgPYa0BJQD8T2/lsYGV+Oe7elx0j/vVePQPNijQbu8c4=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by DS7PR12MB6357.namprd12.prod.outlook.com (2603:10b6:8:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 15:59:39 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 15:59:39 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 13/35] x86/bugs: Restructure spectre_v2_user mitigation
Thread-Topic: [PATCH v3 13/35] x86/bugs: Restructure spectre_v2_user
 mitigation
Thread-Index: AQHbfB9nfsnqTbCmf0+h9Vf7YisaD7ND0m/Q
Date: Wed, 12 Feb 2025 15:59:39 +0000
Message-ID:
 <LV3PR12MB9265E26EEEA0670ABF7E9ABE94FC2@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20250108202515.385902-1-david.kaplan@amd.com>
 <20250108202515.385902-14-david.kaplan@amd.com>
 <20250211005338.dqj5sg5sj7repdu6@jpoimboe>
In-Reply-To: <20250211005338.dqj5sg5sj7repdu6@jpoimboe>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=982fd92b-6028-4b22-b0df-80f7ab0bd3dc;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-12T15:46:54Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|DS7PR12MB6357:EE_
x-ms-office365-filtering-correlation-id: e030ae9d-2d9d-49bf-28be-08dd4b7e415a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bGFrOXZzMTZJYVAwZEI4bXE3ZzdmdXpHdkQwbkxOL3dCVys0QWxoR000eXho?=
 =?utf-8?B?V3RDRzVlaUxvdTBBcUlJa0NrRitodGtud0lnM25SZGRVNzZXekZvMGY4ei91?=
 =?utf-8?B?ajBkcXFvVXZadnN4OVhWUkh2YXRKUlF2eTQ3RnRBK0t6cTMzaUVpei9Ib3Bw?=
 =?utf-8?B?SGFzWkVxWTNmejI4SitFaXRJUVZwUTVSS2gyWXljWXdDT2JyeXFUYTYwcUU3?=
 =?utf-8?B?YWE4N2g0TnJ3YmFiK1AzNjVhNkVmZW1wREZRQjBscTFrbGkyaGlQM3RoeXpk?=
 =?utf-8?B?aFBBUDVydjN0Y200MnJQSHpGVm10UzBURGtqK055NFlvREVQK05Ja2NwZUVB?=
 =?utf-8?B?Z2o3VmpkekpsaTRFOVpPWmw1NmZ1TWhkOXVuSlYwQUdqcW9ha1pyNngzVzJ4?=
 =?utf-8?B?ZmZBY0xYbmYxK0RobE9IWUJ0TkQ2MElzeUN0RE55NE0wakV4akNaY01tNXFt?=
 =?utf-8?B?RENEWlUxcmIyMUp1Qk9qcUZaVGlkUFlsdDlVV3p2N05LR1luRUVobVJrenJy?=
 =?utf-8?B?K000aEVLNzJMbVFBSVU3aEViSktQdjRFaDVsTm1kMW5Qazg4RW9LUlRtd05x?=
 =?utf-8?B?YWRaT3YzWitaSXBDUlF4NnNNaS85ZVc5c2ErOGt4Tkx4N0I0WVJUTDhYUEZP?=
 =?utf-8?B?Qk5sRWxXNlUzai9zVFRJRS9mT3Ird1JTUDBTN0JFYUVRU24xZTZhZlA1cGtp?=
 =?utf-8?B?bXFNS3VFbDFSa0wyelNvWEFxcDErMWo4NWdUUkhrRGFENTFvNndSdzlWRU5H?=
 =?utf-8?B?RnN0QnNWcEQrak80VjdGTzhxa0lieFBjdk8vUndtVnU1ZXNOVGtobjR2ZjhT?=
 =?utf-8?B?TFpsKzVjZ0taTzRhMkJSMEthd1dJU2ZBNERLMlNTMlpmd3NJMXh6V2loRnYx?=
 =?utf-8?B?dktJRlQ1MVJaMnJvSjlGQlcrQm83SUVRUEl0bWNRK2hWYWRvU0IyTHNMVlhX?=
 =?utf-8?B?RUo5MC9QZThkNnBZZllOeVJDWXVQU0FHMWx0bXlrQVpTZWMyeG9zTHZJaTJv?=
 =?utf-8?B?M0NHTGlMckhVM0tKNS9CL1lwa3RxNWN3dzczaUxzUmd5cWI4amZtamVNY0Jx?=
 =?utf-8?B?TzJSY1VPUE1vdHMwQldNdHVTMldSOUoydEV4a0VJM1MvdzdublhSbGh0eHVy?=
 =?utf-8?B?NlZQamxpeW45bWkzVGx1dmtpK1N6UjJIdGdwcU1OU1FwcFV1eWllbS9XWVVh?=
 =?utf-8?B?ZXpUdGlFcUpXelE3ODg5Y1NMT0NzYndIcGNPS1I2Nm8yeWJrMEJ3VUZSUlY0?=
 =?utf-8?B?UFIxb2Yvdks3K2UyVnU4QW91VzF2WW9MRlArR0lScFk0aVlzVU1lNlYzRnBM?=
 =?utf-8?B?UFhLc20vOHFFWkpMTm42eTlHQXAzMEZoZS83UXlEWjFyVHQ3d3MwRENJdHl6?=
 =?utf-8?B?Sm01QkpkV1NKMDAxU1UwQkJvY3paR09CdThQYTdsYS9tWjdxRTBLQmpaZDZY?=
 =?utf-8?B?Z2pyQnlnOWxieGUvUEJ4aWdNbnIyYW4ycW5vWG9tN05GZEFnYnNUMWlHNk9K?=
 =?utf-8?B?eWF1ci9GYWl6OGZ4YkdrSVV3MVlhV0hmRUFIbFdEUXhFdFg0TlJSQTFXZml1?=
 =?utf-8?B?bjdqWEtQWVJ4NHZCdnVqSXhuTlBJTWNLei8yVFVEQVNzV2VNdis5ZVJERERL?=
 =?utf-8?B?My9yTXBTSmxWS3hBS2dZZXhOdk0waXEzVUZPbExaMC9Ua0N2U2x4dUlOVjEz?=
 =?utf-8?B?M2NJNEl4NVN4R1FaMGtFYzB6S2tIcGpmY1NjSm5FblMxcTFQdGdlR3gvNFFB?=
 =?utf-8?B?aXlZMlE1Yi9Rdi9KM05SR1QwSnp5UjBqcCt2MkhkVHpFVEhMMWNDa0l2S1Ay?=
 =?utf-8?B?dXUxYTVOdnNreTFqNlNybVpPdmoyNFRyNlhDT2NHS0c1WDdBWEtHVXBqUnVE?=
 =?utf-8?B?WVpVSVNZRGdNVld0UXlMNCtJM01aMEJHRjhFbkNyZy81MlpsWERVV2FOMlVt?=
 =?utf-8?Q?6sqL3c8G9YFNUcmhsFfzjYAW+UGTEV9t?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VkVBalJMaU5ZUGE1R3dpL1UrSzJjaEI4OVowdEM3aHArWFNTTE9LWDZjbjR6?=
 =?utf-8?B?eFg1WFFDR1Z0ejNsZS9HVUEzL25kcVpZTm03V3JNRVlPKzdvcm1VSDN2NVl1?=
 =?utf-8?B?V2RBSGdhcGN4UWF6Z0xjcWFXamN2eDByRUZPT1lFSFRrdkRzUXFQQTRmd1BC?=
 =?utf-8?B?eG5tbHJhRDRiRm0rTzc4c0l0UnE0VEJmcGx1cC9MR3krT3VCY1lSK29ZOTdS?=
 =?utf-8?B?NzFWMERSdzhEaDcxWHBUTkR4dlI2Mm9IM0ExWGpzKzBKMDVNM2pXU3paTVcz?=
 =?utf-8?B?YTAvS3FXZkJXSGM1VHRIVEFHemRqSmZGcGpid25FWklXdFdDb1kxUVB4clRa?=
 =?utf-8?B?SEVNRFhBVkdPbERjREZpYm1YUlVjTlJEVVV3dU1aMldDZWZuWU1ES0Jpd0dU?=
 =?utf-8?B?NXYyRjY0WjZqSTlmNXRBM1BaSzdPQTlvNGJMbDJBQlNhaWFscXNtaWVJQWQy?=
 =?utf-8?B?VDNSOVArSU1mMmtWbU8vVDhaVEsyVUxlTlRJNlFhK2E1UytueEkxNVByR1R2?=
 =?utf-8?B?OTJGNmx3TytTU3VaZFVBRzdFTHorU1VocUlISFRWK2FteGQ4bm1LbzVUMjlr?=
 =?utf-8?B?VTdWd3VBT2FROWJoSFdIUlB5a1FpZGhMTklyNGo5MDFOaFpTNFhRbjgwdUtY?=
 =?utf-8?B?RHZ3a2dnRXpzSkF0ckxveFAvNHY0MU1DQk1sanpPOEVUVE01SzhoY1JHdEow?=
 =?utf-8?B?K0YrdHI3YzgyVkdnM05KcXNNTk5qcG1Oc2JWZ2FwTCtuMlRvS1gzVnk2T3p4?=
 =?utf-8?B?S0w2bTh5VXNKRTRpUzdiSnVsRTZQRk1oekJLeUtTenhMWENNMEdpS0xURzV6?=
 =?utf-8?B?dDlzdlQ2NDNkejgvTWN0MGVFQW1CdXc3TWliVll6bEhCOGVXSTdwZkZYczg3?=
 =?utf-8?B?SDYyS0JSUVJrSmtNemhkdkRCc0NsWmtzRFNyaEVBSEhRTmRlSldRckhQVXkv?=
 =?utf-8?B?NXF2K0trZzMwZkZxMDBPampQMTMvSDY5SXRxNzBRRDY4NEJEYVNzRFlLbXpj?=
 =?utf-8?B?QzNpUGJBVUdxODlabEhjL25TY1VrT3NLYWhqbGZkbzdBLzVtVzZ3L202RzN5?=
 =?utf-8?B?V1N2OWhqS2Y0MlFKSFA5TXZTSjQ2WThXVjg1aGtIVGs3TG4xaTF6MWRpbGZj?=
 =?utf-8?B?V0l0bVZrNTVBUjF6Ni9VR3NPNmtIM0VWeTdBb1htZjBaRy8zT096Vk03bGN1?=
 =?utf-8?B?eE15RHl0Vm1ZYngrQzhiS29OQWJhWENDSXBvbmpQYnoyZTlkQ1Biak9MMlhn?=
 =?utf-8?B?aWp6VmUzVS9hQWJWZFJEN2VnckM4SzQ2MHNaam41Z3k4U1ZVTm9QbkJZVS8z?=
 =?utf-8?B?Y2l6eUVpZG43TlQzRmRSZWdXMWpIcmZjNzZwY2ZZSDlXZlhQVkx4NWRPZmhk?=
 =?utf-8?B?MU96TkJWd25Ramw2QlptZHNjUEdLa2E4VjZDQ1Z4ajBDNXA2SC9qVTMzSWRm?=
 =?utf-8?B?ODFuOVpFN0w5U2ZrZnhLMXE4NjYyV21qbXh6d2FtbHd1ek13ZjlsaUt6RXl0?=
 =?utf-8?B?OENDcU45K1VEYk4vR0dGQ3lGdGdOVmZtMTJSZjB3Z0VyQkhKbDBieDNiNWFr?=
 =?utf-8?B?SGRkVlhQWE1xcjdpMWZJZlR3a2l5WFBzQStxUEhESkFjNjJzUld2MGxlQlh0?=
 =?utf-8?B?SzcvUkRoTDR0RytaUE4vR3NXVzFoTkRVSEJkM0dQZERkMUxROEs5UERNblE5?=
 =?utf-8?B?c2xGNXhOY0JEd0o1TnFaVlMrbWl3eVEvRDUrRDI4WmxpcFZDWU5UOGRPOTVi?=
 =?utf-8?B?QmJQSjZnYlJRbGE0UnNTa0VoS01CTU9yWFZlb2dVZFlwOUJiU1AxNDlwQW9U?=
 =?utf-8?B?elNGUlIzRUJqb20ybW5tVmkzZVVrL2tMYnVTbUw3Q01sQXlFOUdUZzZlTWdi?=
 =?utf-8?B?YjJmKzB0ZVJaWkMwK1lLR0pZcjUzQVJXcmt2MkxLRXVNcVNoVnc3V1Iwem54?=
 =?utf-8?B?WGhWUzdMWEc4VWVJSXNRSjhVOE1kTHlzWW1nNkdkMnZ2MkJEaGk5RGJpMENM?=
 =?utf-8?B?SFpQTW9NaGJleEdkMkNKcGhBT3pwOWxuSW4xcGVxbTZHaWtweGdmalBVaEtK?=
 =?utf-8?B?bnVkNnpRNHQxRlBTWVpWdjVna2xKUlltZGFzbXlRZE5jU0RMMkd3b2M1NVQx?=
 =?utf-8?Q?WUKc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e030ae9d-2d9d-49bf-28be-08dd4b7e415a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 15:59:39.0692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G/Ha3fMehr1Ff72qDTtksQ7DoAKGKgmDmZvh4/9HSlPSPPAGrVzMWm+qmamQsL56
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6357

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb3NoIFBvaW1ib2V1ZiA8
anBvaW1ib2VAa2VybmVsLm9yZz4NCj4gU2VudDogTW9uZGF5LCBGZWJydWFyeSAxMCwgMjAyNSA2
OjU0IFBNDQo+IFRvOiBLYXBsYW4sIERhdmlkIDxEYXZpZC5LYXBsYW5AYW1kLmNvbT4NCj4gQ2M6
IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPjsgQm9yaXNsYXYgUGV0a292IDxi
cEBhbGllbjguZGU+OyBQZXRlcg0KPiBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBQ
YXdhbiBHdXB0YQ0KPiA8cGF3YW4ua3VtYXIuZ3VwdGFAbGludXguaW50ZWwuY29tPjsgSW5nbyBN
b2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+OyBEYXZlDQo+IEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGlu
dXguaW50ZWwuY29tPjsgeDg2QGtlcm5lbC5vcmc7IEggLiBQZXRlciBBbnZpbg0KPiA8aHBhQHp5
dG9yLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MyAxMy8zNV0geDg2L2J1Z3M6IFJlc3RydWN0dXJlIHNwZWN0cmVfdjJfdXNlciBtaXRp
Z2F0aW9uDQo+DQo+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0
ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24NCj4gd2hlbiBvcGVuaW5nIGF0dGFjaG1l
bnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4NCj4NCj4gT24gV2VkLCBKYW4g
MDgsIDIwMjUgYXQgMDI6MjQ6NTNQTSAtMDYwMCwgRGF2aWQgS2FwbGFuIHdyb3RlOg0KPiA+IC0g
ICAgIGlmIChyZXRibGVlZF9taXRpZ2F0aW9uID09IFJFVEJMRUVEX01JVElHQVRJT05fVU5SRVQg
fHwNCj4gPiAtICAgICAgICAgcmV0YmxlZWRfbWl0aWdhdGlvbiA9PSBSRVRCTEVFRF9NSVRJR0FU
SU9OX0lCUEIpIHsNCj4gPiAtICAgICAgICAgICAgIGlmIChtb2RlICE9IFNQRUNUUkVfVjJfVVNF
Ul9TVFJJQ1QgJiYNCj4gPiAtICAgICAgICAgICAgICAgICBtb2RlICE9IFNQRUNUUkVfVjJfVVNF
Ul9TVFJJQ1RfUFJFRkVSUkVEKQ0KPiA+ICsgICAgIGlmIChzcGVjdHJlX3YyX3VzZXJfc3RpYnAg
IT0gU1BFQ1RSRV9WMl9VU0VSX05PTkUgJiYNCj4gPiArICAgICAgICAgKHJldGJsZWVkX21pdGln
YXRpb24gPT0gUkVUQkxFRURfTUlUSUdBVElPTl9VTlJFVCB8fA0KPiA+ICsgICAgICAgICByZXRi
bGVlZF9taXRpZ2F0aW9uID09IFJFVEJMRUVEX01JVElHQVRJT05fSUJQQikpIHsNCj4NCj4gVGhp
cyBhZGRzIGEgaGlkZGVuIGRlcGVuZGVuY3kgb24gcmV0YmxlZWRfdXBkYXRlX21pdGlnYXRpb24o
KT8NCg0KWWVhaCBJIGd1ZXNzIGl0IGRvZXMuICBJJ20gbm90IHN1cmUgb2YgYSB3YXkgdG8gY2xl
YW5seSBhdm9pZCB0aGlzIGlmIHRoZSBsb2dpYyBpcyBrZXB0IGFzLWlzLCBkbyB5b3UgdGhpbmsg
aXQncyBvayBqdXN0IHRvIGRvY3VtZW50IHRoaXMgZGVwZW5kZW5jeSBleHBsaWNpdGx5Pw0KDQpU
aGUgb25seSBjYXNlIEkgdGhpbmsgd2hlcmUgdGhpcyBtYXR0ZXJzIGlzIGlmICdzdHVmZicgaXMg
c2VsZWN0ZWQgZm9yIHJldGJsZWVkLCBhbmQgdGhlbiByZXRibGVlZF91cGRhdGVfbWl0aWdhdGlv
biBkZWNpZGVzIHlvdSBjYW4ndCBkbyB0aGF0IGFuZCBpdCBoYXMgdG8gcmUtc2VsZWN0IGFuZCBt
YXkgZW5kIHVwIHdpdGggdW5yZXQgb3IgaWJwYi4gIFRoYXQgY2FzZSBkb2Vzbid0IGV2ZW4gbWFr
ZSBtdWNoIHNlbnNlIHNpbmNlICdyZXRibGVlZD1zdHVmZicgaXNuJ3QgYSBtaXRpZ2F0aW9uIGZv
ciBBTUQuDQoNCk9uZSBpZGVhLCB3aGljaCB3b3VsZCBpbnZvbHZlIGNoYW5naW5nIHRoZSBsb2dp
YyB2cyB1cHN0cmVhbSwgaXMgdGhhdCAncmV0YmxlZWQ9c3R1ZmYnIHNob3VsZCBvbmx5IGJlIGFs
bG93ZWQgb24gSW50ZWwgYW5kIGl0IHNob3VsZCBiZSBjb252ZXJ0ZWQgdG8gQVVUTyBvbiBBTUQu
ICBJZiB0aGF0J3MgdGhlIGNhc2UsIHRoZW4gdGhlcmUgaXNuJ3QgcmVhbGx5IGEgaGlkZGVuIGRl
cGVuZGVuY3kgYW55bW9yZSBzaW5jZSB0aGUgcmV0YmxlZWQgbWl0aWdhdGlvbiB3aWxsIG5ldmVy
IGNoYW5nZSB0byB1bnJldC9pYnBiIGR1cmluZyByZXRibGVlZF91cGRhdGVfbWl0aWdhdGlvbigp
LiAgVGhvdWdodHM/DQoNCj4NCj4gQWxzbywgdGhhdCBsYXN0IGxpbmUgc2hvdWxkIGJlIGFsaWdu
ZWQgb25lIG1vcmUgc3BhY2UgdG8gdGhlIHJpZ2h0Og0KPg0KPiAgICAgICAgIGlmIChzcGVjdHJl
X3YyX3VzZXJfc3RpYnAgIT0gU1BFQ1RSRV9WMl9VU0VSX05PTkUgJiYNCj4gICAgICAgICAgICAg
KHJldGJsZWVkX21pdGlnYXRpb24gPT0gUkVUQkxFRURfTUlUSUdBVElPTl9VTlJFVCB8fA0KPiAg
ICAgICAgICAgICAgcmV0YmxlZWRfbWl0aWdhdGlvbiA9PSBSRVRCTEVFRF9NSVRJR0FUSU9OX0lC
UEIpKSB7DQoNCkFjaw0KPg0KPiA+ICtzdGF0aWMgdm9pZCBfX2luaXQgc3BlY3RyZV92Ml91c2Vy
X2FwcGx5X21pdGlnYXRpb24odm9pZCkNCj4gPiArew0KPiA+ICsgICAgIC8qIEluaXRpYWxpemUg
SW5kaXJlY3QgQnJhbmNoIFByZWRpY3Rpb24gQmFycmllciAqLw0KPiA+ICsgICAgIGlmIChib290
X2NwdV9oYXMoWDg2X0ZFQVRVUkVfSUJQQikgJiYNCj4gPiArICAgICAgICAgc3BlY3RyZV92Ml91
c2VyX2licGIgIT0gU1BFQ1RSRV9WMl9VU0VSX05PTkUpIHsNCj4gPiArICAgICAgICAgICAgIHNl
dHVwX2ZvcmNlX2NwdV9jYXAoWDg2X0ZFQVRVUkVfVVNFX0lCUEIpOw0KPiA+DQo+ID4gLXNldF9t
b2RlOg0KPiA+IC0gICAgIHByX2luZm8oIiVzXG4iLCBzcGVjdHJlX3YyX3VzZXJfc3RyaW5nc1tt
b2RlXSk7DQo+ID4gKyAgICAgICAgICAgICBzd2l0Y2ggKHNwZWN0cmVfdjJfdXNlcl9pYnBiKSB7
DQo+ID4gKyAgICAgICAgICAgICBjYXNlIFNQRUNUUkVfVjJfVVNFUl9OT05FOg0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICBicmVhazsNCj4NCj4gVGhpcyBjYXNlIGNhbid0IGhhcHBlbiwgc3Bl
Y3RyZV92Ml91c2VyX2licGIgd2FzIGFscmVhZHkgY2hlY2tlZCBmb3INCj4gIVNQRUNUUkVfVjJf
VVNFUl9OT05FIGFib3ZlLg0KDQpBY2sNCg0KVGhhbmtzIC0tRGF2aWQgS2FwbGFuDQo=

