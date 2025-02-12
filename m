Return-Path: <linux-kernel+bounces-511614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F471A32D4E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 206A03A807E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A8F2580EF;
	Wed, 12 Feb 2025 17:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EjXQSA7S"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE98210186
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739380970; cv=fail; b=UD67zLdrnyzps1h5acAh7b8Rtqi2L4VfEQPkhbzNQtaWADAjx27OEgr1QKNUCFxTTvNK+qZZTDWN9VdwyHWGcgOR43AzDGSuj5ACtEG28HW/E+UuPZhIyoSvTqJxGgaKdAimUdbgbpNMWE9TkG0bTejo/+ytHOadzZBjpLNEeVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739380970; c=relaxed/simple;
	bh=aYP0p+lKRMq8aPavI/M3pNvfmqOo6eH3spgTsSrK2AU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m6TKwqLskkIjH8JnSwVVSYFcsWbnLRRr1cs6sOhFnUAUYUt6mkM/XN8KZVQeExGi0OaBtBiOQLNihguIjceK7e2t/oJnGpOALT9XuM1O5FF3PkLiE6udiqqp1+Y+9oRX9+jus3pIisbqr/tkbuN+l3V0SP0XMZYqc6TZnMrBYSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EjXQSA7S; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PuM7malPE2j2DSbnSFqhGFYtDimaCCwW6yH57rHh9WDl2RzqYgNtAvwxM8WT7x5BY9WjTCZh3dAXE1Ai4J/NYjh+kAD/a2bIeP8mJAmujiCrppQViyamEQ9rJunXrYQIMoYtvcZmbYSBW8nDS/ajVkc2tMSl/gsyrMyEwrZXYWOZOpheNnpm/RbLbFS3J+W0A1KQFC7+k+1d+73AxtY+QNjNEYw27/L0DiP5SckUzgTx+YmGPD/EIUR5S42LTUqzJ7/j0FLhBWRSbChpoOPSmvCl++i6WMNCTfcWccad7aJcy8Hf5MAuQidQgYG+RZNDcDx2WpRMVipHYkV3LzvasQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYP0p+lKRMq8aPavI/M3pNvfmqOo6eH3spgTsSrK2AU=;
 b=pxXYTNA2utrXRuA2GUl4bcr2YrbXyZdL/kWWU6I7J1YYhw+ij/gXRgBwx0VLYD06Ax1vk9r+AB8PoWGbVSasbI60eh6D1jmAXFAdvn+PbkMAIEEVbquPHmF/U/fOkESMco0VkfBmnphVddyXTgSzWS0vIooKsRSOaTU8j2bhGSDWeExLSU6NYAFXywB7omWbebr6hVnqS5o91x6vEc7jpQjzuid7q+5qIZIFYT6LNkFlD/pj9Ac+1Exdd/k3hCJMPg17apjCWoeGHjW+7T5h/FpKWPp1n6xM4VU9KAFzZ5IPzVh9FrJgOFZQXDy4vUIDD+jYimgJmAfYxEW4ex04UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYP0p+lKRMq8aPavI/M3pNvfmqOo6eH3spgTsSrK2AU=;
 b=EjXQSA7SUHub5sWRtpox0ujmNWj0IYtyFXBMhXiVIOmiR5Xrv9YPBlGtHDxp06Tmx5VPLVWwYZBKvBD6pmjDMrYBpd2f7jkpFclkbJ6Jj4HBmUxuTVRt2FssRMJFFvliclMXaOdH4DiOzMitWp9sB/qIy2j9SiiEUWeVasLe9Tg=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by MN0PR12MB6341.namprd12.prod.outlook.com (2603:10b6:208:3c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 12 Feb
 2025 17:22:46 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 17:22:44 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 30/35] x86/bugs: Add attack vector controls for
 spectre_v2_user
Thread-Topic: [PATCH v3 30/35] x86/bugs: Add attack vector controls for
 spectre_v2_user
Thread-Index: AQHbfLed7NO2sQ77IkuenItZp3YDj7ND6/Lw
Date: Wed, 12 Feb 2025 17:22:44 +0000
Message-ID:
 <LV3PR12MB92656AC510522E800F93DFDE94FC2@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20250108202515.385902-1-david.kaplan@amd.com>
 <20250108202515.385902-31-david.kaplan@amd.com>
 <20250211190307.g36lotfyi6dmc3cx@jpoimboe>
In-Reply-To: <20250211190307.g36lotfyi6dmc3cx@jpoimboe>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7ea18f94-2a7e-41bd-9774-73440717375b;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-12T17:22:28Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|MN0PR12MB6341:EE_
x-ms-office365-filtering-correlation-id: 1ef436af-2019-42d3-e5cf-08dd4b89dcdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U3UzMkxNV0xvaGp6V2kwSnJyTG0zNnRuS3ZXaXFuS2I2dXkxWkVWNGRhRHhL?=
 =?utf-8?B?aWJIQzZWY2VlZG5JS01BUDQyNTUrTGhrOXRIckdLREN4TUhIQ2wyMytnbWR3?=
 =?utf-8?B?aVFXZU15QmhraVV4TGtTU25XUjdWOENpbmYvbFBlVkMwMmk0NndrbmFjYTZo?=
 =?utf-8?B?Z3VxQ1VSSS9ISmRNU0RNdFhzZlhmQWd4OEU2cDkwQkF4ampkdU5ucnR3YmMy?=
 =?utf-8?B?QloxV0ZtTTUyUVJoYVl0SU1kSVR1WkpYcW03RVRQT1FTSGRzYTJML2paK0NF?=
 =?utf-8?B?WFNkM0IrTGJlM3pYcy9FREpmNVdadm51dkp1WU1TbXl3UTc4K0xkK3cxdHI1?=
 =?utf-8?B?L1VZWktibis5R1p5bVBoaWc4dzBNOUE3eGpPY2kyUk5wZDYxWGlvTURnN3Bl?=
 =?utf-8?B?T1BWM3RXVVhETjdyYU1oVytUYWFCNTE1eTRaSFFiUjllcW5vWVQrbmdGZko0?=
 =?utf-8?B?UE5EdXBWOFVPS0lKaXBBUHo2eXVHODlhbUFFcWpiODNJbUZWdDVmaGxodG5G?=
 =?utf-8?B?ZDM2SS9oSXN2MXVwYmhqSkErZ0dZV3BKZUxVZ3p0ZTlFYm11bkVvQ0VFNkZZ?=
 =?utf-8?B?WjVxekVnTERPZDVCdEdnL3NTNDJ4YzBnT1BXNUR0azZvNEZ6OUFkMUhYUlY2?=
 =?utf-8?B?Um14SnFQMFVrNUp0a1d4WlVVVjB5azVLQnZVeUZjaUJnZ2dyODl2TmtKVHNX?=
 =?utf-8?B?ZFYzMEE5cTlOSE9MY2FKYXRvd0pSRENvZmtpK2Jmcmd1dmlSZm5NRk5td09I?=
 =?utf-8?B?UTBHWjNRcG1PNVJ2QWxxcTBWWjNNeGhITnhWZ1pPZ2VVWjBDK1pPNUhpakN2?=
 =?utf-8?B?U2pyd0NKUXhpVFBaMzZzd3lId0d4SnE1RFJIbGtPcWdHZ0NXRmluTFN5T2xo?=
 =?utf-8?B?bWRNdlZpNTJsLzFRNHVHQ3ExR0loajJwWFhuRlpVZXl4VHppdkhTdnhPSTBI?=
 =?utf-8?B?dHNwTVFpd2t1dXpMYU1BQjFaaDNTQXJDQnBhT2h0TmFHSEtKTFlVNm5RSzRB?=
 =?utf-8?B?a1hpTjhvakhiM0Jycy94WVE0aGc0ckFsbGVtQ0dybmx5OXB5cEEzeXRnalhS?=
 =?utf-8?B?WnZmMXFMSHpNaU5jRXMxcncxVk5wTU0zMzF4TXl1M2Q5S1QrOTR4cVRjaVpO?=
 =?utf-8?B?cHlJYzA0YTdGU3NJV1kvdDBmUER6TTIwTUtqaXp1eFBXaGZYZ0VrcHhoT3I5?=
 =?utf-8?B?YjlvYkFWdDVvaE5sWFVxV2FJTDhhU1oyQWhFRXVTQ21JVVVKYitUR0pZM0o1?=
 =?utf-8?B?VitWbGQyYkJIRWVFTFBFMFNHVDYzbkc4TWlteVAraWNuQ2VLc1RHNzcrdURM?=
 =?utf-8?B?NHIyZHYxeStSeVNCang0b1RkK2lBbDNHRExRUFU3M21wbWlXdmdCbDZEd3h0?=
 =?utf-8?B?Slp6QlNtVGJ1ZTgrMUs2RmFDa09qV3VLTlF4WXZVQmZWRHMyRVpoMW9adUMw?=
 =?utf-8?B?aVNCc1d1ME1RZTEzeTZDdjV3UmxMbG1wb0NkdE1YMlFwdWE5dE1Nb0RyNklV?=
 =?utf-8?B?VzRIaG9uc1BIN2JjMm5VY0hjek52NFM1R3V1eFBMdWduSGJjS0RkVmV6Nm5X?=
 =?utf-8?B?VnVHdVMxVm5QZ2NoUkt0QlhscTNwTkg1WmcyWTZ2eFN4b0U5dUlyZi9QQlVq?=
 =?utf-8?B?Y0w2NHBybFNpYVVtKzYxWjFuVElELys3U1VYTXJJdm5jdUdsaHAvSEFLbGtz?=
 =?utf-8?B?eGZEYS9UNnhnSjEyQzdlT2ZSNC9OMmJkWmxHaE9YVE1YTEFKTU9zM0E2aDBO?=
 =?utf-8?B?QU5oUThZaE9EajZPbTNIakI1TytpdEMzSUJNMFY0M0ZDbXVGa2dJME9hZmt4?=
 =?utf-8?B?VmJpR3ZTRkxLaFFCYUp2M2xYemkxOXNVcmRBZkgxVnMwcVRlSlBXTzZ6cm1w?=
 =?utf-8?B?QkFIMnJDTVp6TkJ2TDNYOUFvMmhZOHpnUU9kVytvQWNOUjYxc2FhNzF5Qlpv?=
 =?utf-8?Q?Y9oCov8C5nFNzWJZXReq4ILktOtTzInP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bzQ0aktrZEpLNXNWR0FibVBsWFlPay9JVnB4eDByT1VTSFhYdDlkQlR2NTBV?=
 =?utf-8?B?c29HaW4vSkNBUEg1NzVpVUMyRXRHOHl4d2MyOFlQdnh4Rnk0SnJZa0JmN1NH?=
 =?utf-8?B?LzJES2VnWWxYbHhZUGwrVlloaUF3OEorb2Z3SmprQTRGSFk2LzFSNGtWeEht?=
 =?utf-8?B?ZElWQU81RFp2VEVIUmNxd0xGV0hwakNMeVNPejBVWndQTzJ4K0EwTjY1czE3?=
 =?utf-8?B?Yjg0NGZqME5xZSthWGtaMzM5akRNRGlERU95THNlYXJvQXJzMnlDYmtjKy9R?=
 =?utf-8?B?U090NW8vN3pId2QwcDZxODdNMmRwMzhQLzhHU0svZGo5OVpadkZ4WXpKOEhp?=
 =?utf-8?B?Q2I3OFViYWdnODgxb0dOdW94UW1hWkJVS3daekRCUGhkMXpUVTBRNTVJQitn?=
 =?utf-8?B?aFJZRkZDeXN5aURJbElYVDRhdUFpMkNudHJBSVdCMDdPMXQrT0xWRGFjV3RD?=
 =?utf-8?B?dkFkbzNnV0NuTHJlZ0dHdmU1N0RVOG1DM0trRGtQTHJ4SlFkOGdTTFQrRkhG?=
 =?utf-8?B?dmt3K3lsSTZpSzh0OHJnREFLUWFiaU5sZThBRG5vdUlGdVdDMEhKSExYaEpI?=
 =?utf-8?B?czduem9mR2dGQjhXak5LNUkvSm5aN1V4VVJqaWZWcUR6Zk8zQ3ZqelhTTUQ2?=
 =?utf-8?B?UzNoU1N0ZnBBc0xucEhIdk83OHVjS2lIK0E0SEk5OG9rVlNoSzNneW5sVVZp?=
 =?utf-8?B?dkJadklzbUNSSnhqdUtKbjVFN240WDA0b2VzQmR2NFJvN0JqclZheFZjRS9r?=
 =?utf-8?B?WG8zM2FqZEt5SkRZODZ3R1dIMmxoM0VYTnZSanBIL2RJVGxsdFA4TWZVanpN?=
 =?utf-8?B?ZzRFc2hUQnMwR3R2NFQ0akJ4L20yUHVaZWx2NG1DZXloM0Zhak1yNjFFMDNB?=
 =?utf-8?B?SFhBUU1tWUtwS0VsdEFJaVJvZllPOW5na3ZxNTF5T202aXhtSm1GTngwcW83?=
 =?utf-8?B?d0RhUXRlZHF3QzNGSjdCTHk0cWlwSU1OSy95ZHFsMzJjUWg2Y1J5MzRQSWlK?=
 =?utf-8?B?YnlGeVJGRWdNVjJWTVR0RjdHTHQzL2ZVbVJRcG9RVHh6bm81OThxUW5VcWRn?=
 =?utf-8?B?azM0ZlpvL040V0ttdUNESlByUXdUSnMzb0UyTzlZL1FPMUcrQjR0M2QrMFJN?=
 =?utf-8?B?dkk4MkNqdms3M3F3bVgwQVE2OU8wV3RteTdPTUsvaDYvcHVVdlBrQy95aFVs?=
 =?utf-8?B?T21ZZkt5RG1kWkxsNXAvazdEeGxseFZPZjFSM1lwUFVuOHlvbkoyYXkwcHpY?=
 =?utf-8?B?SVAwVC9yZE1rbG1XNTg2NW00TU9LK0c0UStDK01HaFFtajRTb2prWkhSTDVO?=
 =?utf-8?B?Z0hhMHdwZjFIcTFOaEFySFdWbkI4V2t3MWFsejdNdTNOWWZhcE84M0dKMEZ5?=
 =?utf-8?B?aEtDS25zMTJhdjA4SFMxWUY5NWV0TFo4QmZKVFFuNUJmRFA3cC9CbEloTHYx?=
 =?utf-8?B?SUVCaWJ6bzRzZWZhN1pYRERzWkZjWEtCUXpyK0xNRXVYSHdyZ212NHBncXpH?=
 =?utf-8?B?bVFvZjlNUXJWQURYWHpwTlRnZVBob1FiaHd2SXJMOEp4d2NIQUJqdEkvWi9q?=
 =?utf-8?B?bjFRVjdPMVhRSTVkbkZZQ2Z3dWhHUVhkcnlOWUtEMHB4SmVXRmdjazlSTHN4?=
 =?utf-8?B?NEwvK05tNmNZMGVQZmREdmUwZHlUaEtGeW9obHlWQ082NXZjOHZjOU5tVUp2?=
 =?utf-8?B?S00rTllqMDFXUlUyMmJVd0d2Vkh2TmI0KytHNy9DNzBzaHJ6Z0lmS25lMkVZ?=
 =?utf-8?B?dEUvQXkzU21kVDk5bXIzaXpvWHkxOEhqWUV4aTBEbEpjdHBpN1VYWGdvTFVM?=
 =?utf-8?B?MkZXME5zMVBuUHBHdUttYmcvd095QmtISFJhZ1BLMFV0dXRtWWZmVnJ6QU5B?=
 =?utf-8?B?Uk51TTFrZ2F6c3BWOE1KUTN6SjMxaVkxRmliS2tNZHBqNjdIY3hockxobm9J?=
 =?utf-8?B?OXN2QWV3aGdvZkpIN0JlOWh6WDFjOXdDU3hiUDkvaEZGVkdXaFFWOVVlU1BU?=
 =?utf-8?B?aVFaYk44NjExOHdReVdieE9mSTNLdHViUmhSdjZDTGUzSUxIWS8yNElBQlZK?=
 =?utf-8?B?dS9oVEl6TkttVk5INEpuNENYRWJGVjYwTVpIZm5Qa2ZPcWZhOE1sd25GTWVV?=
 =?utf-8?Q?tSCA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef436af-2019-42d3-e5cf-08dd4b89dcdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 17:22:44.4138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +jIxYKHg1WmDaj6iH1eboKGLmRKHJkn3P7pwnbjP6lTA/EWKX99rpFNn71y2o7M2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6341

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb3NoIFBvaW1ib2V1ZiA8
anBvaW1ib2VAa2VybmVsLm9yZz4NCj4gU2VudDogVHVlc2RheSwgRmVicnVhcnkgMTEsIDIwMjUg
MTowMyBQTQ0KPiBUbzogS2FwbGFuLCBEYXZpZCA8RGF2aWQuS2FwbGFuQGFtZC5jb20+DQo+IENj
OiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT47IEJvcmlzbGF2IFBldGtvdiA8
YnBAYWxpZW44LmRlPjsgUGV0ZXINCj4gWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPjsg
UGF3YW4gR3VwdGENCj4gPHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbT47IEluZ28g
TW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPjsgRGF2ZQ0KPiBIYW5zZW4gPGRhdmUuaGFuc2VuQGxp
bnV4LmludGVsLmNvbT47IHg4NkBrZXJuZWwub3JnOyBIIC4gUGV0ZXIgQW52aW4NCj4gPGhwYUB6
eXRvci5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjMgMzAvMzVdIHg4Ni9idWdzOiBBZGQgYXR0YWNrIHZlY3RvciBjb250cm9scyBmb3IN
Cj4gc3BlY3RyZV92Ml91c2VyDQo+DQo+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVk
IGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24NCj4gd2hlbiBvcGVu
aW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4NCj4NCj4g
T24gV2VkLCBKYW4gMDgsIDIwMjUgYXQgMDI6MjU6MTBQTSAtMDYwMCwgRGF2aWQgS2FwbGFuIHdy
b3RlOg0KPiA+IEBAIC0xNjE0LDYgKzE2MTQsMTMgQEAgc3BlY3RyZV92Ml91c2VyX3NlbGVjdF9t
aXRpZ2F0aW9uKHZvaWQpDQo+ID4gICAgICAgICAgICAgICBzcGVjdHJlX3YyX3VzZXJfc3RpYnAg
PSBTUEVDVFJFX1YyX1VTRVJfU1RSSUNUOw0KPiA+ICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4g
ICAgICAgY2FzZSBTUEVDVFJFX1YyX1VTRVJfQ01EX0FVVE86DQo+ID4gKyAgICAgICAgICAgICBp
ZiAoc2hvdWxkX21pdGlnYXRlX3Z1bG4oWDg2X0JVR19TUEVDVFJFX1YyX1VTRVIpKSB7DQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgIHNwZWN0cmVfdjJfdXNlcl9pYnBiID0gU1BFQ1RSRV9WMl9V
U0VSX1BSQ1RMOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBzcGVjdHJlX3YyX3VzZXJfc3Rp
YnAgPSBTUEVDVFJFX1YyX1VTRVJfUFJDVEw7DQo+ID4gKyAgICAgICAgICAgICB9IGVsc2Ugew0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICByZXR1cm47DQo+ID4gKyAgICAgICAgICAgICB9DQo+
ID4gKyAgICAgICAgICAgICBicmVhazsNCj4NCj4gQ2FuIGp1c3QgZmFsbHRocm91Z2ggaW4gdGhl
IHNob3VsZF9taXRpZ2F0ZV92dWxuKCkgY2FzZT8NCg0KWWVhaCwgSSBjYW4gZG8gdGhhdC4NCg0K
LS1EYXZpZCBLYXBsYW4NCg0KPg0KPiA+ICAgICAgIGNhc2UgU1BFQ1RSRV9WMl9VU0VSX0NNRF9Q
UkNUTDoNCj4gPiAgICAgICAgICAgICAgIHNwZWN0cmVfdjJfdXNlcl9pYnBiID0gU1BFQ1RSRV9W
Ml9VU0VSX1BSQ1RMOw0KPiA+ICAgICAgICAgICAgICAgc3BlY3RyZV92Ml91c2VyX3N0aWJwID0g
U1BFQ1RSRV9WMl9VU0VSX1BSQ1RMOw0KPg0KPiAtLQ0KPiBKb3NoDQo=

