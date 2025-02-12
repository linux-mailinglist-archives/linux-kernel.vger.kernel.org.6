Return-Path: <linux-kernel+bounces-511522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ABBA32C37
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3091645D5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA2F253332;
	Wed, 12 Feb 2025 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EFmppLAW"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E674A20CCD0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378764; cv=fail; b=ZVoGST8t3bls304FcgLAVuwl/jBosbswtfUMNg03r3C4+JptDiTaOUI9mLoxo573V64OPwKGLOI3Gn3OZkONscloGPzGoO6lsD4CMWd8PJtym8+pj7iq8RORPj+TVSfrVC1ZzLg1J68lNlLQ1d3JrzC9jVaw14vmDfVGSnQW6cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378764; c=relaxed/simple;
	bh=pNOUtwC+bdis4vHniYq6s+BivKWjM9NQGHf82e2f/V8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S8p0XltjDwxN22ZzLspXAOjs8ZIEDnv+8OaIiAB3+UbLT6wDL/BV72x2zVxe/0aIJBHPapZTh3yVhePRKS0wCY0hmaWY5PDXfEJW0U0wQOBhN4hhVKezURt5A9G0Ly8OKi/DIGElD1uChZZNZAShNVZ3squbwJwki/7VR2bb7k4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EFmppLAW; arc=fail smtp.client-ip=40.107.101.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWLi/yXJErkz1ivFtuPrsZ3RU6wAjBGR3BzzyNsBAkTJVhb6NzkrtRJFszyMN6R9QgbWOPl3TQTVJKNZ9OiELGcy1Zg0tpyPSV0o26IsFIwma7cyIJfTaw6kbCRuWvEb0a1m40FMsQk2XflmLA4WllHeYMuZeSENvPaF/As8tQ5NJXrud1DRcjK9GbHkalGlCv4LWVelO9l6S7RlbEjrjMqma3TZ2+NI24vS/mtyyyCi8qNshdhZBnxiSWXuLYByJbxDX7yayzyZr8HWcQBYYZSqc1qyG/+fCGGz5JEwrI176NxpcbTMXhwDm8+6mtxFzAXAC7g0PKQHDt/M5UFIgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNOUtwC+bdis4vHniYq6s+BivKWjM9NQGHf82e2f/V8=;
 b=TtgHxOfa8CXU7ojne4zGpWwOFpa8/qEpi1a4LJdIroQ1g7JkHZFekXXP3tYlTzWO5OjPh3PFWs77rVhtGiSdSNrPqURC41dmK8VY4E3dQ4TFEm/hdOA2A65GVI0KY+urX+jDCCjpKc8NSHep70taV6fY8KHWDWOg9cEiwIfjzYpp9PVCRmBiYmng4mK9FeWNXNW7Q1aYZV26m5p1WpimZNiuPsw87v51aYGbUEiIgvIYtkTpI8Fv5EyJqMjbSZAbIuYpdBwk+1H4vD68PLsVX5pbY6rvHRz4x7blahkelVaDO+VKSV7uvPVvnJEpAZRlN0sPzMPalfj6ZHtRIUrgYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNOUtwC+bdis4vHniYq6s+BivKWjM9NQGHf82e2f/V8=;
 b=EFmppLAWb8PsuQ1sYtTwLikCo+Gs0eTDvse0uMce9zq5/aloh68R2p2m7MgyfnTxw6C8pYOnKMBkK++/nNJu+YHcCVKqAd39FpvgsFrYMblAk3UxIxA9V6FY/qnunjh2jbQf+3rI0xISKEApL36fyMnkUkttnYGDWwtVm2gxdjA=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 12 Feb
 2025 16:45:57 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 16:45:57 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 16/35] x86/bugs: Restructure ssb mitigation
Thread-Topic: [PATCH v3 16/35] x86/bugs: Restructure ssb mitigation
Thread-Index: AQHbfCG8PccMgB8TwE+0g6heuxP3q7ND4tsg
Date: Wed, 12 Feb 2025 16:45:57 +0000
Message-ID:
 <LV3PR12MB9265E8D4C0E5B437F675AD1194FC2@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20250108202515.385902-1-david.kaplan@amd.com>
 <20250108202515.385902-17-david.kaplan@amd.com>
 <20250211011020.2aopcvfav7nrshft@jpoimboe>
In-Reply-To: <20250211011020.2aopcvfav7nrshft@jpoimboe>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b2517f9e-e93e-4073-84a1-1b217d60f026;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-12T16:45:45Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|DS7PR12MB8202:EE_
x-ms-office365-filtering-correlation-id: 5ad6ebd9-a2ff-48fe-703e-08dd4b84b93e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V0oyUWxQZkliMGhwOUJ3Zmw2eUZJMGRpamUrRUlVVzR2Z21WUXVLd1dYMkds?=
 =?utf-8?B?VlRjNjRNdGlkbWZwa05aQ3ZBYklaV1U3MG92RXpNWUR3bVVPRmt5MDlXVmVU?=
 =?utf-8?B?NzhjQUhnWEVqeXZNMEVURlRyZHJsVjQ2ZGRDWHFQNUZNOU5jZ29jdFBha0Fp?=
 =?utf-8?B?czByVGF3VjJPTFN0cDFGNjhYVS9YS1RYMktmMm5qL0xibHhCYUpCTFpndnVF?=
 =?utf-8?B?NEI4RTRtUUduQXFSYWxHczl4ZEtNZlpiQlgvb2tIUm81MHdmNkxzVXNON1Ro?=
 =?utf-8?B?NjJBMjZmM2lNd2RBTWsrTVVVQ3NNd0hDLzcrMUNXb3V5YkxLV0VLUWhNdUhR?=
 =?utf-8?B?cUcxbVZpN0NlMU43ODhtcmFkOE5wK0w3VjZLeTJJTmtCWTZ2d1Q3MGxUa2RJ?=
 =?utf-8?B?MDBUV3pmYUNVUGZaVDhYeGl1bWVuYmxPOEhaUlNoSnhCdnJLeEl2Rk55aVJj?=
 =?utf-8?B?U0RWZmIrbHc5TGVrR0U5WGE3SkZOY3puMEd6ZzNYelZVTzJsb1I4aVQ3Mkh1?=
 =?utf-8?B?MlhaMlNydXRtRGg3TUJlMUx0SG1IWHN0M2hXSG9URmtSNnBybjZlMFExMGhY?=
 =?utf-8?B?ell4MlN1cDJPZm5TVmpLalRBOTJheU9FT09MWVZHTHpDendwbUViRzFtNXZk?=
 =?utf-8?B?ZHRXaCt6RnRHQlRFTWVlbFdLaERFWlo0Rjk5VFN3VjFUUTF0M2x2aEhlUEpv?=
 =?utf-8?B?cUxUa2NvazZ2TnVXSEVPb0lkNzRsRmlqZXZYRHN2T3ZsdXJuYjI3dkMwNC9Y?=
 =?utf-8?B?Nncva1U4amEwNlljODhta3pFaklDNjFhaG1kZ2twcnR3RHRlQ1NVMXAwSGxm?=
 =?utf-8?B?eS96cW40eVIzK2ZhTEoxZVZSZnNnWTd4dEF5UC9oK2FyTTlYNlRoNysvUzN6?=
 =?utf-8?B?NXZVMkpORU5TQTJ1TmlWZEZqWkZWSzVVVEFKWkpLWnpFSDQ0czFWS01ISGl2?=
 =?utf-8?B?VnlUQzNEckR3cHBNT2pQQnQzbkJrZ0pzTkZMWjJIRjFKajFUREVVUnlRRDJS?=
 =?utf-8?B?RUFEZXUvamorV0YzYlZJc1dWWjJqMm1Vemh3dUUrMkRFY0FaQ3ZtQ0t2cmUx?=
 =?utf-8?B?VkxlRG9nUStBQWJhOEQ4KytjUVVYamNBejlaSDZOMDluWlRkQ25GQXRCTHVT?=
 =?utf-8?B?NkZPbmVRSmpLZkx6UUIvalI2djFRRlZpc01mVkpZT0hHdzE0SzNiYjgzYmEz?=
 =?utf-8?B?SEQvOWtGYmdiY1lONjlTSlFBdUtxYUVEZ0t4RkRjdldYMlZSdExTOStUTGtj?=
 =?utf-8?B?SVZ1KytSS1V4SnRiS2RiVUtRY21Gb3IxSTAwWDhBNlhwUHhNV1JOcmo4djh2?=
 =?utf-8?B?WGpCQjBMMlNndWsrRzRIQzhHcEErVjRiOVBEUFR0VlJQTnk5eHVxWDIvakZW?=
 =?utf-8?B?djV4SmhvYThJbDB5VnVYZE5hc1E3QldyN1dDOUJpNDRYWnY3NXVEK1NMYWhE?=
 =?utf-8?B?UTd6eWV3aWV1ZEF4OCs5dDlxaGNIRUNiN2ljNm9icE9CdTZHZGxicDRnZ24x?=
 =?utf-8?B?UFB5aCtIZmNZdmlWMHp4SE9KQVQ2MkhBU0NOK0w5TUp3TlZORFN0cU1Tenc0?=
 =?utf-8?B?c3Rzb2o1aUZVWS85Y2V2YkxDZGxRbFVTbHZCcWtZTjJsVnJYV2VwYVpiakVl?=
 =?utf-8?B?NEZQNm93SThHKzNmWnZXN0NwQXVLYzNONncxN2hIVHJSNm1meGdadXB3QWlT?=
 =?utf-8?B?cjJFUDlaQUJtYTAvZkRSM1ZXa1Y4d2xGcHZ6MnR1TXZKWkhmQUZUeVlOWTBt?=
 =?utf-8?B?STEwVWxEeW1UYktGOWplaGI5dEczc2tNNW02VzQ3UjVMWHZsSjJkT2tuNC84?=
 =?utf-8?B?dTFKKzBIR2tNbk11ZGJHTWFtSVUxVCtBOWpaSy9CUDlEWE5wRGMydlJCekRV?=
 =?utf-8?B?TDdJKzc0bU1RTW1Fb1NKakNvdzhDTUhXeWUvV2JjTGFqYkx5TDFmeFdncDE5?=
 =?utf-8?Q?iUnWd0+EfkVurjFG71XQ622AHGYH8Abo?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q0U5SC9obzdmbUliZG9YVnZ6Y2hZcjdzcjYranFrTDZCRjBBYUlVY3JzODBZ?=
 =?utf-8?B?M3dIMTVoa0RFZkxXUWNBRGpjOHJqMGZXYkFsa0I5UURZbXJDLy9NRDEzeUk4?=
 =?utf-8?B?UEg0dVZCb3RnQmE4TEJWQnMyWDQzU3E5UkdMK3VJYktXQXUzUnRzam1wKzNL?=
 =?utf-8?B?K3BxY2ZWb29jMldseXAwL1pFdGRYaXc1aXdIRm9NRjBxK2RISlZIWWhUMFA4?=
 =?utf-8?B?ajB4Nm5tby93a3ZEeFkrVXVGMmI0UXBsUHlBR3dUWVM4RnZkdzNYVHhMdC83?=
 =?utf-8?B?dFJTYXpqMmlFRElMc21uQXMrbk92aDVKTXgxM3VsZWNrR0xHQ3kzYTB2UDRG?=
 =?utf-8?B?VVNBeUZleHg1SE9TQVNycnRuSHdvaUJJK21YS2VRemlUQm9QWEtOb0tlaTdl?=
 =?utf-8?B?aDl4VlZYZFNIUUdmU2Y4T1lvL01oRkk2MHM4aTZBNEdGdERteERIbExLbTk2?=
 =?utf-8?B?bUpkdnhFRENSL3ErVzl1RE9XaVBGUW9wM0w4L3diMVRBL1lmSjVuZ3A4N2oz?=
 =?utf-8?B?eGFPaVBubk96aWwrNW1vZWFVSk5kek1XbzFGNm1sU2x2UG5pclJweVpUTi9x?=
 =?utf-8?B?eEdJdUxHbCs2dlI1TExOUUZLTzFUMnZ0cmlsN1VldkUzaVJFeWZXb1NhVkRr?=
 =?utf-8?B?WEphUFJxMTVYMDVBZVlIWDNWWEZORHhtclpFT1NMMnNVWHVqWGpYWEg5YVBj?=
 =?utf-8?B?aHpVbEtFcXFMdWtlbWpPVnBxYUdJNTRGb1J0emFIWnU5WWRpMkkwNnNvd2tr?=
 =?utf-8?B?TlpQM2hadCswQXBFNm1JdFEwbjVCVy9nVkV1R3V2RUhEZUZTc2JJTVJLQnlG?=
 =?utf-8?B?UVhqa2NrZUY3eWZRSUxZV2FSOXUwWkZHZFpYQmkybnBhSWRodmFmYXVTZkFx?=
 =?utf-8?B?NGpIVkF0R1p6U3QzYitOZGs3c1M2U1JkVnh4R3lVNjMyeEhwb3plMkIxdjhS?=
 =?utf-8?B?bGI3OHRhdUxEQmtBejhPelBUZGVReDQvTjFSRHhlenRzN3V2YVc5SGowaXgx?=
 =?utf-8?B?Z0J0OFJFZ3dXYjE1L0p2UzMweWx1RVlXN2xDTTNOVENxM0UxR2xXUTBkd2JY?=
 =?utf-8?B?MjhDZGJlR2YxbVpDd1lkWERyYlpsQThrb211UXZ0VGZCZTliT3BvSnNDUkRL?=
 =?utf-8?B?TDQ1V3pMMlRjV25aRGMrSlRxQ0FWY3hTeHhuVFVwcjhVOE5kTUJsMnA5dGF0?=
 =?utf-8?B?QmdBeU03NTcrYzRpcVQ1TENCeitxaDd0Z1NjbWZBbEY0bk5pdFY5OVBSTUN6?=
 =?utf-8?B?Nm1UbXBjMXphWWxRb1BHKzBXV1prUUtzTmRGNmw3VGhtaUVLT2pMSWhITlVH?=
 =?utf-8?B?Y0Q3MXNxN3UzUHNrUVo2aHA1MGE2alVzRy8vd2I5L2d3ZE50S3kzN1F0dVVH?=
 =?utf-8?B?TGR0ZFk4UVd6cG5HSDRaYjRTMnF3Y1V0YVdaVDB4L1ZYRjlweTNWUkk3Vmgx?=
 =?utf-8?B?Q0s1d2dkdjRBTWtPUStjaWswZXlFNEx0YkxhYUtDbndnVWp4bGFrakpoOW1J?=
 =?utf-8?B?Njc4NXNnMGNPZ3RZQk9YaTU4TVA5UXI4VG9BYVlURHZaWVY0L2xFK0xCK3gy?=
 =?utf-8?B?S2cwYjJNSFhzL2tJYlR5NTJPV20rcUF2MFhHYWs2NW9zRmtjU0VVRzR0VEl3?=
 =?utf-8?B?UjZmZlBZUzlNb3pXNG1NM1BNUGk0Q0NHcitCUnBmTXFLRGlSOHkzd256VzRn?=
 =?utf-8?B?Vmw4MklaRVFwdzdhN2pZY3ZPSHJtbzBjK2VQaTVtalJjVThSeW8wZ1U2cCsz?=
 =?utf-8?B?LzRPMXpJU1B2Y09MZXFOYjJ4LzR3RjFWODRRMFlqdm96WmhrcjhsdUowWGpW?=
 =?utf-8?B?WVoyWUlpd3hzWTRYNWFVRzFuVlAxekV0SWt6ZHNQakZtcXF4R2FQRE1KZGxq?=
 =?utf-8?B?M0hTWWliZWQ2UmtoMVQ1bnB3VjlpallNWlJrbUQ3VmZJeWYrRmwzdHZzYmU5?=
 =?utf-8?B?Nk9zcnJlMmF1RjFCZkMwS283L1pWOHhFTlVBeXZlY21NMU5DNE1OUjdjbTda?=
 =?utf-8?B?cUhVdDNjaENhTXkyOW1QMVNmc1pBQThBZTYwOEpBMVJsTitMd1V4OUluZDZ2?=
 =?utf-8?B?bWZFVW93bmhiNTd5UGViQ3VGWU9reGtDd0hCajZXZDJCQVBMLy9JWWhZdkxS?=
 =?utf-8?Q?a8Q0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad6ebd9-a2ff-48fe-703e-08dd4b84b93e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 16:45:57.2029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dlkjzLp1wwicnFXnypgVRmeQvPaH8pCmIvGHsKYDj6OMbuDAAZEzPlr1cpKQsoyu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8202

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb3NoIFBvaW1ib2V1ZiA8
anBvaW1ib2VAa2VybmVsLm9yZz4NCj4gU2VudDogTW9uZGF5LCBGZWJydWFyeSAxMCwgMjAyNSA3
OjEwIFBNDQo+IFRvOiBLYXBsYW4sIERhdmlkIDxEYXZpZC5LYXBsYW5AYW1kLmNvbT4NCj4gQ2M6
IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPjsgQm9yaXNsYXYgUGV0a292IDxi
cEBhbGllbjguZGU+OyBQZXRlcg0KPiBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBQ
YXdhbiBHdXB0YQ0KPiA8cGF3YW4ua3VtYXIuZ3VwdGFAbGludXguaW50ZWwuY29tPjsgSW5nbyBN
b2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+OyBEYXZlDQo+IEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGlu
dXguaW50ZWwuY29tPjsgeDg2QGtlcm5lbC5vcmc7IEggLiBQZXRlciBBbnZpbg0KPiA8aHBhQHp5
dG9yLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MyAxNi8zNV0geDg2L2J1Z3M6IFJlc3RydWN0dXJlIHNzYiBtaXRpZ2F0aW9uDQo+DQo+
IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNl
LiBVc2UgcHJvcGVyIGNhdXRpb24NCj4gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2lu
ZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4NCj4NCj4gT24gV2VkLCBKYW4gMDgsIDIwMjUgYXQg
MDI6MjQ6NTZQTSAtMDYwMCwgRGF2aWQgS2FwbGFuIHdyb3RlOg0KPiA+IEBAIC0yMjcyLDE1ICsy
MjgwLDYgQEAgc3RhdGljIGVudW0gc3NiX21pdGlnYXRpb24gX19pbml0DQo+IF9fc3NiX3NlbGVj
dF9taXRpZ2F0aW9uKHZvaWQpDQo+ID4gICAgICAgICAgICAgICB9DQo+ID4gICAgICAgfQ0KPiA+
DQo+ID4gLSAgICAgcmV0dXJuIG1vZGU7DQo+ID4gLX0NCj4gPiAtDQo+ID4gLXN0YXRpYyB2b2lk
IHNzYl9zZWxlY3RfbWl0aWdhdGlvbih2b2lkKSAtew0KPiA+IC0gICAgIHNzYl9tb2RlID0gX19z
c2Jfc2VsZWN0X21pdGlnYXRpb24oKTsNCj4gPiAtDQo+ID4gLSAgICAgaWYgKGJvb3RfY3B1X2hh
c19idWcoWDg2X0JVR19TUEVDX1NUT1JFX0JZUEFTUykpDQo+ID4gLSAgICAgICAgICAgICBwcl9p
bmZvKCIlc1xuIiwgc3NiX3N0cmluZ3Nbc3NiX21vZGVdKTsNCj4gPiAgfQ0KPg0KPiBFeHRyYSB3
aGl0ZXNwYWNlIGF0IGVuZCBvZiBmdW5jdGlvbi4NCj4NCg0KQWNrDQoNCi0tRGF2aWQgS2FwbGFu
DQo=

