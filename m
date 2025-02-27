Return-Path: <linux-kernel+bounces-536672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CE8A482D4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15FC21894064
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5991F26AAB3;
	Thu, 27 Feb 2025 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TgU9fw+K"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69E126AAAE
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740669733; cv=fail; b=AA0bL3LOfJNY9L4/4bpyOOw8j1iJRwJSLftTMdTjs2NYGQYq5ELILyp8WKSJUx+uUfZV9YmGUXhRDolmlSMI9TFNoquCXc7MA2igFgkVwHlZhN4g6CEyrQFG3x+OZ3/R/ekspK2XWUu9NOthG5xOY6A/0bXkD+uhxjx0ku/XJd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740669733; c=relaxed/simple;
	bh=GT2+jq26vap4ILqJ8ZhH/tdTUTeV3k5/f0Lemulxmi4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gmJGg38MzE9Jt9AW+u3Tr20dtqs7q0hWr/RYgCDnFj1/dLLcVVk9ouSyeWIwkDlz6bhG2Hb/0QOCO2vrPzTEgfX5Lz9PljvTZnCB8NkJxtXZXQPoonIyGVCHfCruac6Ap2pZF82OUKe2jv3ehukOOlNc++9mVbOB31sVMK1rZl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TgU9fw+K; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQjcV6W2NUvNNcJY8qMvDiP+3DLqH2512B2ZrN4K8eG+px3mNswGIZrN+J2O0A6RSEbQLXUVgjIqKeAZZ4vU9UcnHUCv+OojxwZMMYIOrHZanXKFHGRNiqltDcdyP4xsB4MBn3EuijWrvu9fEnJ6RP7kxCWO1KwJD+/ii8IEl1yoW3Dl3W5QP6MFMcBOn2NO+VHoQxwqjYS/drilWaHvqHBqf0ndLxMw9GMmtnxAsZpbC5IEwZSERkJVS5m4jb63BuvAoOrkaIvRfqdns9VUOps44dgLBEBLytKqQ4O3H7uNWCUtWHHbQw3lx/wRIp+XQGtX29qz0jdK5XJNTrc+HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GT2+jq26vap4ILqJ8ZhH/tdTUTeV3k5/f0Lemulxmi4=;
 b=fut50J2lGqoxKV88gC6xLYSfsw/efw0J+mOJvpbi0mHLv3BmvAfWu6MJSnAg7CowkRkXfc1tQwOiwj+sI8Q2CQM0AzkeaLF2pwyEFd//oyPLA1ZS2w+XXu6cmcU493wFPjyS2b+xPokGrQAOpcUqWgyRALfBwPzHWGCvtfry0hSelRmTi6UbXms1yLKUR6Dl9bkMKqVVjU83LY5Qpq7l3m+U2iu6SPCHxCz663UC5XopyBBOBGu37CVyarqjZyCpC2v6rt7xQPzGBVHHfSh4aezB6UMfliRpRT78BcLv7mm207mpSBigY2lou7c3iXCu09HP2z5gemD66x6iwa/VSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GT2+jq26vap4ILqJ8ZhH/tdTUTeV3k5/f0Lemulxmi4=;
 b=TgU9fw+KLRw3M8hgulgj8VtEOBSukrwG5KtkbzN4qrvgI8f6+i7/QTEdIseGmPrQLuEqzmxTrgqAThEe5ltxxvkjlHmjBoJKB9dKudv37ASzlhaG6fZ5ez82BEE87+fRZfYIc5rFTa9C5j2dp5vYeZDlQU/6NzUTpQZZ+cxrDNY=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by CY8PR12MB7561.namprd12.prod.outlook.com (2603:10b6:930:94::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 15:22:08 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%4]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 15:22:08 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Josh Poimboeuf
	<jpoimboe@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H . Peter
 Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 20/35] x86/bugs: Define attack vectors
Thread-Topic: [PATCH v3 20/35] x86/bugs: Define attack vectors
Thread-Index:
 AQHbfK/msIIkfjoqOkyd6FXsW3bSnrND631ggAfdInCAADBpAIAAAIOwgAA3cwCAACLxwIAAWYuAgAAd6ICABAIeAIAJN77AgAAXk4CAAAqGMIAAFpcAgAAZgACAAA4xAIAADWqAgAApHQCAAKzDAIAAAyFggAALnICAAAQqkA==
Date: Thu, 27 Feb 2025 15:22:08 +0000
Message-ID:
 <LV3PR12MB92651F3CE777A3723B61835594CD2@LV3PR12MB9265.namprd12.prod.outlook.com>
References:
 <LV3PR12MB9265DE3082FA0A7FDF9B587594C22@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250226201453.jgg6kucaathzmcvs@desk>
 <LV3PR12MB9265F875F52317BBCDF953EC94C22@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250226221324.hq2nevnnnrpgo75n@desk>
 <20250226234440.4dk4t3urkzt4zll7@jpoimboe>
 <20250227003528.hnviwrtzs7jc3juj@desk>
 <20250227012329.vbwdmihjlqu6h5da@jpoimboe>
 <20250227034813.booxbhxnff66dnqx@desk>
 <20250227140858.GEZ8Bx-tTaQF8D5WBj@fat_crate.local>
 <LV3PR12MB9265B1854AB766EBB7F098D294CD2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250227150143.GFZ8B-V8nIdSlV7ng7@fat_crate.local>
In-Reply-To: <20250227150143.GFZ8B-V8nIdSlV7ng7@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a2c30edc-b5a2-407f-97f1-d07aaa62798d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-27T15:16:36Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|CY8PR12MB7561:EE_
x-ms-office365-filtering-correlation-id: 69a2d0d9-ce71-43d4-1723-08dd5742800b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?THo3cTBTTU4rTjRUQ2p3VXQyZzNZczBzUlBnK2taN2dpWWpPRmV3c0hsaEJP?=
 =?utf-8?B?ZkJxMnY2QnVzVTBPUVJhQU83UnVxR0xHMC9VYjFXZ3BDSkY4VUp0enlCYWZD?=
 =?utf-8?B?QWpqRU96OGFTREZuT1Q5OGI5bnZOQWR2N1pHMzVjdHJnamswMUhiblpubDRJ?=
 =?utf-8?B?Rm1Gb0VyQi9xeGl3dUwremE0RjZsNlZsbmFRK2ExSDlMRGlLT1pUK2EzeURB?=
 =?utf-8?B?VnRpOGh1aWNDc0RkS0V2YmlBd2VHdkowdTMzU0UyUDR4c3NXMVA2b0hvc0d1?=
 =?utf-8?B?OFlMTEwxZmNaVGFoWDZpMTJWVU9Fa2RjTUVQRUpxOFRpZjZaMWVIbDZBNWhM?=
 =?utf-8?B?OTB3Qk9pNWIxd0g0Mi9TSjBHOGFGSFNDRER6cDVYdW95ZG04OEw2em5qdDVD?=
 =?utf-8?B?ZFBMazcwZEFlb3gyZDV3cDh3TXA1K3cybUljeW9zaFhEcDBCR1FIVWFRaGJM?=
 =?utf-8?B?ZUorLzNhcVl1eTlQZnNHVkZvOXhMdTE1ckpCdHBCYzYySjlUck5TZnExSnVa?=
 =?utf-8?B?Z2NrakVMMUZJS01YM09OaEFzaW96K0NJcWxSZmhjd2MwQzhJS3poSzVqeEhK?=
 =?utf-8?B?OXM1U2QxMG1LS0tWeEM2cW5vVzdjdEpPWGJhQ0FmYzhZNHZMUjNCTkFBU0tB?=
 =?utf-8?B?TTF6cU5kR0Z0Sm9oVW9yOEdpT1VmN0R3b1RwY0JheHh0S0dzTENmSGhXM0Ra?=
 =?utf-8?B?a0RudnFKWWtlcDZmOVUzTWZoOFkveWJoc2FnOTY2YnFjU1J6YUlRbTZiZVRV?=
 =?utf-8?B?WjBadG1UQ2dYa3JCWGpnZXl3dm0rSzR4ZUhKTU1DaXRpbTV6K1FJRFFPeXBx?=
 =?utf-8?B?RGk3ek8vcTFjUEU3UnhFS1pTV2VNRDdUZTBIQTZUOWsxQUZiZmtqYnN5V3dk?=
 =?utf-8?B?TEpyZ0NGckZoYmNhazYrN1B6dElPbHFkOXZQTVByVFNDQkt2NkpmZkpnaWJB?=
 =?utf-8?B?MmhIcmFoTkdtTUlQWGVxd2NPZ3pSd1VjTFpzVTBjd0JUZ2NBSXlPTStZZjJk?=
 =?utf-8?B?RkswUEd2NENqS3JOK2dOaDB6UEc5ZlpsZUtyaEo1MGRBNnVnWlR6Y0lXU1BW?=
 =?utf-8?B?SXpOUit6RnU5UWdEazdFQ0xtRXNBcXU2S09EREM0cUpiaFFIQUhTbGFua0s1?=
 =?utf-8?B?OUZ5TzdoUzRBdFV6aWlGdnV5bHV6MlJYY21UbUVzRjlMWHZWNERrZHhVb0h2?=
 =?utf-8?B?Yk4veDQrQTlYWWw4OUJ6Mmk0R1UyNGthVTROSG1OcGV5Y2pVMDRuN1ZjQlMx?=
 =?utf-8?B?Z0JpWVdvbFNQYVMwNlBpOTFxcXJJOEdVMFJncjh2OXhZVURLdmFxNFpwYmhP?=
 =?utf-8?B?ckYrUHNsbmF3WUgyalF2MVA5MTlEaTFpVWRDZlFNbHR6SW1oaVdSUmxlUnFx?=
 =?utf-8?B?amhLaHliaVpNUGJXWk5SaHpDakUvUkluVlVvUVdEKzhzT0w1K1hCSG9kbVpv?=
 =?utf-8?B?dngyTXQzYzNmRlFyZzlUSnhEZTQ3Si83OXlsbFN2dXNzUTRTalI3OXVrakFC?=
 =?utf-8?B?d29HL1FQZkw1ZGhYek1OSUFCVG16T0dZV1V0cDZlSmlUSmlGY1hTMm9kd1NS?=
 =?utf-8?B?Yzg5d3FLM2dPMTdPNzdlVDU5bkJUM2lKZWFGbGo1TGUrQ3dZVkQxRjdnVjZ0?=
 =?utf-8?B?VVVucllnZXV2V2d5YUxUQXMzczRvRGNaa3hNanVNdThuUUVsWWRvcDhkY3V3?=
 =?utf-8?B?a3RFK1FrWVk5bkgrYjFHaG1aM3BVL0RxRmF4SklsL05Rc2ljZEZqZ0RveXVi?=
 =?utf-8?B?YVNwNzhSbmpPQ29KYld4OVRnWjhSM2N6T1VvMlFGOVBZclBuU1ZzV0JkQWVY?=
 =?utf-8?B?dmVnMm9uV2tuOWVNYkJZdmVwRHp1RDM4VUtpQ1lDT0xJV1JCQ1BDbzZoaEZn?=
 =?utf-8?B?TlZoVnBoWDVHOHJaVEp4NGNzbW9HVExQOTZZbUN6ZTY3ZEtYMmVpeFNrWHVw?=
 =?utf-8?Q?Vo1Vp9pwpay/KAaJHqawfkHPPfDgNB6k?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SlArTUtRM2IyWDVURkdkU0hIb1dhRHptQVVWSWtLQno5TGhhM1J4WVk2dy9V?=
 =?utf-8?B?MXVQR2k3VU12YzVWTDl5YXhIdG5QejVHRVRkVjZuY2ZYUDVPTlA3WVJZYjYw?=
 =?utf-8?B?Q1ZWd0xqSGUzYUxaWUwvSFZzTzRxb01ZMElDdkxpem9RWmh5TVEwd21rN3pI?=
 =?utf-8?B?anVOWkhCU0V6SGd2UG5kTUNCZEVxOGJBZDAyblVRYlFZQkVjMXN1Z2tKK2Zj?=
 =?utf-8?B?eE9uOEE1Qyt6SUpFMnMydkYxUnl4SW1hSDhLRFJPK05PZzdXTDdWOTBXcUEv?=
 =?utf-8?B?ZDdXbkZseGl1NWdXNkdtWmtJM1BRS3U0VHZKTFNpUGd2UEUyeFVmdURVVXg5?=
 =?utf-8?B?YjJRSGpXVDVGd2RWdytQK29rTlVacHg2blBQRHRMSGpqd05xKytkbjRNenJx?=
 =?utf-8?B?RFFSOXQ3UUg3b2JWRWNjVGJqUGxkUjI3a0tiaG5VNFJVZHRXVkFBNkdaV3dl?=
 =?utf-8?B?bndoR3ZCdE5BTG5TS0Yxcy9uOWpVQ004S1d3QmZOVWJFZ3J2VVRuRzJGOStp?=
 =?utf-8?B?VE1HaGdmT0k0MTdTYXZuQkEwNzlBRVhjSUlPUnlTVzRHb05VR053K2R5MEQw?=
 =?utf-8?B?VHpzUFVoYkpvMU5Jdk1HSTZxeWY2ckxyUG9YTU1GZzdaMk9aUGR5cEE5NzF2?=
 =?utf-8?B?QXFxUll4Q3dSWnlLL0JiNWw4YmpvbUxsRHZ3eUJ3a2d5cmhveTdBaENtbjVH?=
 =?utf-8?B?aWhVQlR5MzU1MmdUMng1clFiMXpnSEYzSDNCclh2Wk9UbURMSFJUT0ZmYmhi?=
 =?utf-8?B?NkdXOE5EZC9XemdSMEJyd0ZHY3E1WXpGbG1iNU42YUpDOFVMbnJ1MjFuRUFv?=
 =?utf-8?B?RVEzTi95RGlyZkVUZVcwWTlvcVpueWVBOHJBeE8zT1JRZ3BYUlpTWUZwVUZy?=
 =?utf-8?B?TlRjK1J3VW5TbktGaEk2YjdEdjRieVcxcnRvaHA2UlpqWGQvYmRrUEQ1S3Rs?=
 =?utf-8?B?K1ltdEJBMndnS2d1RGlLMEZPQW9FUkVsYTEraFpIRDlRSkdNWXhWWGpkSnVi?=
 =?utf-8?B?MHl5dWZpb2lONTBDY0lKTCtQOGkzWThGZ3AvVnNST2dGWjN1cm9KNG5uOVBH?=
 =?utf-8?B?TkRIWHl6NXBod1haZHBkNDYyNnNrZEJtM0Zuc2ZkV1pGR28vaXBTODRhNDJU?=
 =?utf-8?B?bUdRaWNiYUkwTTFMNzl1MlM3QmtwR1d5ZW91MHBzU2QwMkdPNGd2L2E0OW5y?=
 =?utf-8?B?MzlUZWFUVnNsVDNxemxvVlZhTEpoSmYvcDk3NGlKNTFORG9oY1NYTzVFOXZF?=
 =?utf-8?B?emU0am0zdGhIRkRkb041N0FKZGgzeXFZMG5XckdqV3Y4S1FYbWwxcmZhYnJk?=
 =?utf-8?B?RTRZM1NkY2Y4LzZIa1FyTlU3OGdtUmdaTGU3MkcwVkFHOXNXNWhuL3Vsb1hO?=
 =?utf-8?B?OTQ1M01XbVJUOFdPKzM2Q0p0dEVhMWFUdnFZWTRCQ1BSYnhUZldPN1h0ODZD?=
 =?utf-8?B?MzVBNFVyM1FqYURhM1FiL3NLT3g0aFkwOEdWZWhhRU14R0poK3JJWXM4NTdm?=
 =?utf-8?B?cW9HNG5wU0gwQlFSWE9FazdybWNQL1UzUzIvbDFuTDErUWh3b0R1RGd2T2dx?=
 =?utf-8?B?SzAwRVFPSGppclZtV096eDZ0SFBFd1BzK2x5SWJpWmxZVS9QdU9oN3RLNytK?=
 =?utf-8?B?eU9PTk12OWpWUWhhQVNUZGFva1o3S3dpblBmMmxOVmlXSXlyanFTRm9ZbDdq?=
 =?utf-8?B?anpTWlBCbWxaUkZmM20vK2xOUVQxaHBXM1czNUlmbjRVM0Z4bmF0WFZWWmRH?=
 =?utf-8?B?NmpaTTNUV250L254VUZ0ak9JTVl6UFpSa3I3OUNZSHR3QkN0UVp2NWxvaGhN?=
 =?utf-8?B?emNPSnJmM0lXY25KYUNLUWtLZlNybXR0Ungrd1paOG5GU0ZBeGZUSHNBNi8z?=
 =?utf-8?B?RTRoQ01XWm5Vd2ZyUUFBVnNlQ0ZnTGZFQTgyUzU3ajR1cmhxb0VGcUQ1QWlD?=
 =?utf-8?B?RzhxeFFQdTBkSHY5aVl3Y2NkdlhiUUVjbHZQRlpzNmtpckxxOW45VlJ2WENY?=
 =?utf-8?B?M2pnbDBvMjltOXdiaHlQNndwY1BkYTd5aFlkZ3ltNHdNRFNHZTFaNGYrajZE?=
 =?utf-8?B?a0txeFZ2V1YyVXVEWWt5YmtqZUlXTU1KaVBRMDMzRDZFV0lYSzZLR0U4YTFQ?=
 =?utf-8?Q?6bdY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a2d0d9-ce71-43d4-1723-08dd5742800b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 15:22:08.3701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0nK5OxNrpeIQSvECA11ou9Dgq/yVEsTHUhGSvES+Zw5DtVxJ4GOJt0Bb5Zf4xq/3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7561

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3Yg
PGJwQGFsaWVuOC5kZT4NCj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDI3LCAyMDI1IDk6MDIg
QU0NCj4gVG86IEthcGxhbiwgRGF2aWQgPERhdmlkLkthcGxhbkBhbWQuY29tPg0KPiBDYzogUGF3
YW4gR3VwdGEgPHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbT47IEpvc2ggUG9pbWJv
ZXVmDQo+IDxqcG9pbWJvZUBrZXJuZWwub3JnPjsgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0
cm9uaXguZGU+OyBQZXRlciBaaWpsc3RyYQ0KPiA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBJbmdv
IE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT47IERhdmUgSGFuc2VuDQo+IDxkYXZlLmhhbnNlbkBs
aW51eC5pbnRlbC5jb20+OyB4ODZAa2VybmVsLm9yZzsgSCAuIFBldGVyIEFudmluDQo+IDxocGFA
enl0b3IuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYzIDIwLzM1XSB4ODYvYnVnczogRGVmaW5lIGF0dGFjayB2ZWN0b3JzDQo+DQo+IENh
dXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBV
c2UgcHJvcGVyIGNhdXRpb24NCj4gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBs
aW5rcywgb3IgcmVzcG9uZGluZy4NCj4NCj4NCj4gT24gVGh1LCBGZWIgMjcsIDIwMjUgYXQgMDI6
MzY6MzdQTSArMDAwMCwgS2FwbGFuLCBEYXZpZCB3cm90ZToNCj4NCj4gPiBNeSAyIGNlbnRzIGlz
IEkgdGhpbmsgdGhlIG5lZ2F0aXZlIG9wdGlvbiBmb3JtIGlzIGJldHRlci4gIFRoYXQncw0KPiA+
IGJlY2F1c2UgSSdkIHJhdGhlciBlcnIgb24gdGhlIHNpZGUgb2Ygc2FmZXR5IGlmIHRoZSB1c2Vy
IGZvcmdldHMgc29tZXRoaW5nLg0KPiA+DQo+ID4gRm9yIGluc3RhbmNlLCBpbiB0aGUgY2FzZSBv
ZiAnbWl0aWdhdGlvbnM9b2ZmO2d1ZXN0X2hvc3QnIHRoZXJlIHdvdWxkDQo+ID4gYmUgbm8NCj4g
PiBndWVzdC0+Z3Vlc3QgcHJvdGVjdGlvbi4gIERpZCB0aGUgdXNlciByZWFsbHkgaW50ZW5kIGZv
ciB0aGF0PyAgT3IgZGlkDQo+ID4gZ3Vlc3QtPnRoZXkNCj4gPiBzaW1wbHkgZm9yZ2V0IHRvIHRo
aW5rIGFib3V0IHRoYXQgYXR0YWNrIHZlY3Rvcj8gIEluIHRoaXMgY2FzZSwgdGhlaXINCj4gPiBl
cnJvciBsZWF2ZXMgdGhlIHN5c3RlbSBwb3RlbnRpYWxseSBpbnNlY3VyZS4NCj4NCj4gV2VsbCwg
Z29vZCBxdWVzdGlvbi4gSXQgY291bGQgYmUgdGhhdCBvciBpdCBjb3VsZCBiZSB0aGF0IHRoZSBh
ZG1pbiBvbmx5IGNhcmVzIGFib3V0DQo+IHByb3RlY3RpbmcgdGhlIGhvc3QgZnJvbSBtYWxpY2lv
dXMgVk1zIGJ1dCBub3QgdGhlIFZNcyBhbW9uZ3N0IGVhY2ggb3RoZXIuIERvZXMNCj4gdGhpcyB1
c2UgY2FzZSBtYWtlIHNlbnNlPw0KDQpJbiB0aGlzIGNhc2UsIEkgdGhpbmsgaXQgaXMgY2xlYXJl
ciB0byBzYXkNCm1pdGlnYXRpb25zPWF1dG87bm9fZ3Vlc3RfZ3Vlc3QNCg0KVGhhdCB3YXksIHRo
ZSBhZG1pbiBpcyBleHBsaWNpdGx5IHNheWluZyB0aGV5IGRvbid0IHdhbnQgY2VydGFpbiBwcm90
ZWN0aW9uLiAgVGhpcyBzZWVtcyBtdWNoIGhhcmRlciB0byBtZXNzIHVwLg0KDQo+DQo+ID4gQnV0
IGlmIHdlIG9ubHkgc3VwcG9ydCB0aGUgb3B0LW91dCBmb3JtLCBsaWtlDQo+ID4gJ21pdGlnYXRp
b25zPWF1dG87bm9fZ3Vlc3RfaG9zdCcgYW5kIHRoZSB1c2VyIGZvcmdvdCBhYm91dA0KPiA+IGd1
ZXN0LT5ndWVzdCwgaXQgd291bGQgbGVhdmUgdGhvc2UgcHJvdGVjdGlvbnMgZW5hYmxlZC4gIFBv
dGVudGlhbGx5DQo+ID4gcmVkdWNpbmcgcGVyZm9ybWFuY2UgbW9yZSB0aGFuIGludGVuZGVkLCBi
dXQgdGhlIHN5c3RlbSBpcyBtb3JlIHNlY3VyZS4NCj4NCj4gU3RpbGwgZG9uJ3Qga25vdyBmb3Ig
c3VyZSB3aGF0IHRoZSBhZG1pbiB3YW50ZWQ6IG1vcmUgcGVyZiBvciBtb3JlIHNlY3VyaXR5Pw0K
Pg0KDQpNeSBhcmd1bWVudCBpcyBpdCdzIHByb2JhYmx5IGJldHRlciB0byBlcnIgb24gdGhlIHNp
ZGUgb2Ygc2VjdXJpdHkuDQoNCj4NCj4gPiBCZWNhdXNlIHRoZSBleGlzdGluZyBrZXJuZWwgZGVm
YXVsdHMgdGhpbmdzIHRvIG9uICh0aGUgYXV0byBzZXR0aW5nKQ0KPiA+IGFuZCByZXF1aXJlcyBh
Y3Rpb24gdG8gZGlzYWJsZSBtaXRpZ2F0aW9ucywgd2h5IG5vdCBrZWVwIHRoZSBzYW1lDQo+ID4g
bG9naWMgaGVyZSBhbmQgb25seSBzdXBwb3J0IHRoZSBvcHQtb3V0IGZvcm0/DQo+ID4NCj4gPiBT
b21lIHNwZWNpZmljIHVzZSBjYXNlIGV4YW1wbGVzIG1pZ2h0IGJlOg0KPiA+ICdtaXRpZ2F0aW9u
cz1hdXRvO25vX2d1ZXN0X2d1ZXN0LG5vX2d1ZXN0X2hvc3QnIC0tIFJ1bm5pbmcgdHJ1c3RlZCBW
TXMNCj4gPiAnbWl0aWdhdGlvbnM9YXV0bztub191c2VyX2tlcm5lbCxub191c2VyX3VzZXInIC0t
IFJ1bm5pbmcgdW50cnVzdGVkDQo+ID4gVk1zIGJ1dCB0cnVzdGVkIHVzZXJzcGFjZSAoY2xvdWQg
cHJvdmlkZXIgc2V0dGluZykNCj4gPiAnbWl0aWdhdGlvbnM9YXV0bztub19jcm9zc190aHJlYWQn
IC0tIFVzaW5nIGNvcmUgc2NoZWR1bGluZw0KPg0KPiBJIGd1ZXNzIHRob3NlIG1ha2Ugc2Vuc2Ug
aWYgeW91IHdyaXRlIHRoZW0gdGhpcyB3YXkuDQo+DQo+IFdpdGggdGhlIG9wdC1vdXQtb25seSBz
dHJhdGVneSwgZW5hYmxpbmcgYSBzaW5nbGUgdmVjdG9yIHdvdWxkIHJlcXVpcmUgeW91IHRvIHNw
ZWNpZnkNCj4gYWxsIG90aGVycyBhcyBub18qLg0KPg0KPiBtaXRpZ2F0aW9ucz1hdXRvLG5vX3Vz
ZXJfa2VybmVsLG5vX2d1ZXN0X2hvc3Qsbm9fZ3Vlc3RfZ3Vlc3Qsbm9fY3Jvc3NfdGhyZWFkDQo+
DQo+IFRoYXQnbGwgZ2l2ZSB5b3UgdXNlcl91c2VyLg0KPg0KPiBZZWFoLCBJIGd1ZXNzIHdlIGNh
bid0IGhhdmUgdGhlIGNha2UgYW5kIGVhdCBpdCB0b28uIDotXA0KDQpUbyBtZSB0aGlzIHNlZW1z
IGxpa2UgYW4gdW5saWtlbHkgdXNlIGNhc2UsIHNvIG1heWJlIGl0J3Mgb2sgdG8gYmUgYSBiaXQg
bW9yZSB2ZXJib3NlLg0KDQpBbmQgb2YgY291cnNlLCB3ZSBjYW4gYWRkIG1vcmUgb3B0aW9ucyBs
YXRlci4uLndlIGp1c3QgY2FuJ3QgcmVtb3ZlIGFueXRoaW5nIHdlIGFkZCBub3cuDQoNCj4NCj4g
V2hpY2ggcmVtaW5kcyBtZTogb24gYm9vdCB3ZSBzaG91bGQgcHJpbnRrIHdoaWNoIGF0dGFjayB2
ZWN0b3IgZ290IGVuYWJsZWQgYW5kDQo+IHdoaWNoIGdvdCBkaXNhYmxlZC4NCj4NCj4gQW5kIHRo
ZW4gaGF2ZSB0aGF0IHNhbWUgaW5mbyBpbg0KPg0KPiAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS92
dWxuZXJhYmlsaXRpZXMvYXR0YWNrX3ZlY3RvcnMNCj4NCj4gb3Igc28uDQoNCk9rLCBJIGNhbiBh
ZGQgdGhhdCB0byB0aGUgc2VyaWVzLg0KDQo+DQo+IFNvIHRoYXQgd2UgY2FuIHZlcmlmeSB3aGF0
IGdvdCBjb25maWd1cmVkLg0KPg0KPiA+IE9uIHRoZSBTTVQgcGllY2UsIEkgdGhpbmsgdGhlIHBy
b3Bvc2FsIGlzOg0KPiA+ICdhdXRvOzxhdHRhY2sgdmVjdG9ycz4nIC0tIERlZmF1bHQgU01UIHBy
b3RlY3Rpb25zIChlbmFibGUgY2hlYXAgb25lcw0KPiA+IGxpa2UgU1RJQlAsIGJ1dCBuZXZlciBk
aXNhYmxlIFNNVCkgJ2F1dG8sbm9zbXQ7PGF0dGFjayB2ZWN0b3JzPicgLS0NCj4gPiBGdWxsIFNN
VCBwcm90ZWN0aW9ucywgaW5jbHVkaW5nIGRpc2FibGluZyBTTVQgaWYgcmVxdWlyZWQNCj4NCj4g
V2VsbCwgdGhhdCdzIHRoZSBxdWVzdGlvbjogY3Jvc3MtdGhyZWFkIG9yIG5vc210IGlzIHlldCBh
bm90aGVyIGF0dGFjayB2ZWN0b3IuDQo+IFNvIGlmIHdlIGRlZmluZSB0aGUgZm9ybWF0IGFzIEkg
bWVudGlvbmVkIGFib3ZlLCB0aGlzIHNob3VsZCBiZQ0KPg0KPiBhdXRvOzxhdHRhY2tfdmVjdG9y
cz4sbm9zbXQgb3IgImNyb3NzX3RocmVhZCIuDQo+DQo+IFJpZ2h0Pw0KDQpCdXQgdGhlcmUncyBh
bHJlYWR5IGFuICdhdXRvLG5vc210JyBvcHRpb24uICBTbyBJIHRob3VnaHQgd2Ugd2FudGVkIHRv
IGxlYXZlIHRoYXQgYWxvbmUgYW5kIHVzZSBpdCBhcyB0aGUgYmFzZS4NCg0KLS1EYXZpZCBLYXBs
YW4NCg==

