Return-Path: <linux-kernel+bounces-357490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9579971D3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB6342814AE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1989F1DF759;
	Wed,  9 Oct 2024 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rcqqAMQA"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A47918FC83;
	Wed,  9 Oct 2024 16:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491782; cv=fail; b=dkMUXy9z5tzn0061AAsEFFX8MQQfe0OqtU0SDW197QPdw5C8ZQwL5S/uWE+GvrLE/hZxcy8PRJsmpuEO9+6UX936jHjE5MLhtZ8nCSuDQB0FuTkfvNViYQvH3ixwUzpr/GqvlFEKRcmU6zXVZ1s37LWkutrrUM/AmxhPT6vMjgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491782; c=relaxed/simple;
	bh=Cb1ZPU0LcvHlZmn8XdOVf6VHxnMhMvm+CbQo9elUUx0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rQqeBGCFOZiC2GGdEIFBLFBJjfPuysTMlZBdt7wTjbwc7UgZ+RQAFVGMNCLDAyEpM1eNLhiYPH9VZrIDRHyaIx3P4ceTmSWoaohbZtAOoF8LrM11ZTasyO6enJQkWKA2x8gQEAGC40ZeM57L8oSfaMpkGB/jKizaom5NEzil0E8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rcqqAMQA; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUfpEcA1vhuPMrdJtMXnKATE2TUuN5wDZYd8QmVJG/OLFS5BbXrvhhtK4WGY0gu1fkmwc6hw7i+dA0pacVc0EIH9d+5oN7jTXi5FROHjPCK70cMpo0IivZP1Fbv9sautHijrBXO6Vw78d5IzA5NZKWAA1nB/iS9kVKJ0efjwNCW0rD8yP5E5heBaZvDZeE4pFXfD294q4763CpRzVl6Q4vD4IuFinMcSzLdWjgu9f3Y3TtxwtpYvXDxIF2RJD0pqMHtylFffuLfJLn7j/dVBw44iSPxNmTj0evxIhRlcOcerZTM6UpEMwDOgq3DyexvFts3BrweqdWODzCoCFq6yQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cb1ZPU0LcvHlZmn8XdOVf6VHxnMhMvm+CbQo9elUUx0=;
 b=nNdiKF2WZJvwexZuAyiDRchJjYqx01y8MWRoDPgkctPVu/2mY+tYml9uEQRxh4l/1PtX8mGOzNEabtahk/TxVBKVDuvfXyd5DwyktkeFSBIt8z2gRPa/HQxWc5XbrcbYiFQp3+eq4eVmG9JStou/+Plt7gMNEfyIgdExRd7vUbX/rtV9S321QvaUwjf0UmOO2mUzZCF4CZja8/JKParuFiTMmMtayvEVBboSITwj/jgtqIKiUHQOdi7HhofOP4ujJl+esXfejfoHDp6CrH2BpPKBgS84yKQVfkwAyLjZxgJrQt6Ii4mz75woqLNdBJxujUTqYs1Z1dFd751pJGpPiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cb1ZPU0LcvHlZmn8XdOVf6VHxnMhMvm+CbQo9elUUx0=;
 b=rcqqAMQAaZBlB7MWG9Y1PO8iKzONFkjFv2SAdh8XBNHvPi75bvy2n63NUVl9HZkvstJD+nOsTR/pNChZuQLMW6kdwdW9u/I00WxEr4XAZo9gC721SesTApI+roYZM+lpgrTVMy/uMUz0W2NZjID4DuGRo2DovwbwbvWDW6ixxgA=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Wed, 9 Oct
 2024 16:36:13 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%4]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 16:36:13 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Daniel Sneddon <daniel.sneddon@linux.intel.com>, Jonathan Corbet
	<corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov
	<bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf
	<jpoimboe@kernel.org>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "hpa@zytor.com" <hpa@zytor.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pawan.kumar.gupta@linux.intel.com"
	<pawan.kumar.gupta@linux.intel.com>
Subject: RE: [PATCH 1/6] x86/bugs: Create single parameter for VERW based
 mitigations
Thread-Topic: [PATCH 1/6] x86/bugs: Create single parameter for VERW based
 mitigations
Thread-Index: AQHbGbegzRZsFOFa5keXyvP1YFB3hbJ+mhYAgAAASzA=
Date: Wed, 9 Oct 2024 16:36:13 +0000
Message-ID:
 <LV3PR12MB9265A30309277CBB4A9B81D1947F2@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20240924223140.1054918-2-daniel.sneddon@linux.intel.com>
 <LV3PR12MB92651F4DF654C886B9F2BCF7947E2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <879b3437-c706-47c4-b1aa-b2def940f569@linux.intel.com>
In-Reply-To: <879b3437-c706-47c4-b1aa-b2def940f569@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a33802f0-778d-4c80-812b-04107e263761;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-09T16:18:42Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|MW3PR12MB4460:EE_
x-ms-office365-filtering-correlation-id: cf3779e1-8f22-42c1-1e9b-08dce8807d4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YVhpVmUxM2MxalY0bDlXek8zL0E0emRBVlJremIvSnZJYVhMOUh4QzJFRFJq?=
 =?utf-8?B?OWl2dFB4OXhCYkRZak9UQktVK2pFS2lSWDRFVUhmdjhtdkF1RWJlbVQvemE1?=
 =?utf-8?B?KzhOVEoxcHZtOWdrTk8vK2VZbGdHRzlsenZIaEhXMElocFBBTzNZVU5jajRH?=
 =?utf-8?B?dTNYckdUVXVqcFkwbGxVdjZPbFVQNXlQM2xnRUJTSndISFFmM2VOVDJjSWVr?=
 =?utf-8?B?UWdqeTFYejhQd3Q2NUdZaVQ2VGxPaW1zdnUrRGg5UzkyUHpqQXFqVjVZdGtS?=
 =?utf-8?B?aGMrd2MraHVQNzQwV2ZHL0cyTHp3WnNEN2RnR3l3MmxaMEk3K0ZsZ2VLdUsx?=
 =?utf-8?B?QmhSWllFbjFpcFZZanRwRUxZMmRLdVhwSlpiZ1VVaytraGVOS3Zma3JmeGRs?=
 =?utf-8?B?KzdpRHdJR2tVY2pXLzJZZmZyRXhmcTkwQ003eDdHSmRMdDVjZ08zb1JtMDVh?=
 =?utf-8?B?VDFDdjFEVzkxbHVmd0ZkSGVVYnJVS3VlelNsVzhUS2J4MDFONGtPRVZSZGN1?=
 =?utf-8?B?WVVmcU5FeUZkMkZwVkYvRGlucE5ZR1ZPQ1dGTXZINUQrUXpRT0kyUklZTGRs?=
 =?utf-8?B?dG9SblpmdDE3a0VwL0VqK0VjY2k5RkJwUytJUWFXU1dLMGhKYURxbVl4SXVT?=
 =?utf-8?B?QS9qRTBtNkR5U01lMFNHNHFIamxCaUhITGIyL0U4WjN0bGt0OGRYMkFRNDl3?=
 =?utf-8?B?cmI2Y09ITkVGeXNITVZzdnlkMGc1dTZxZ29DS0FrM1pCcWJXMUluV1B5U0ps?=
 =?utf-8?B?RGpHYU1EZ3hodjd1VHl2YldnaVkyTjh2NnRlZDF5KzgwYXFrQlJ2WHdFTHMz?=
 =?utf-8?B?bTFrSTRWSllVblJaK2VaRlNmOGx6YWJkZ2NiQnRIR01ucDlmZHAzVFF5SXNj?=
 =?utf-8?B?ZkwvQWRjS2U5R3I1ajR0OHFqc09vNGh3NkE1eHVHVjJKaFBoS09VMGFwM2Mz?=
 =?utf-8?B?ZU1SNUpqQllGU3FmT0JSc1FhN21XMThDdGZwNVpiYndETmZGODRpV2tYTDFN?=
 =?utf-8?B?Y05FK0hGblkwTGV1YkVBYXI5UFBVSzN4eDY0WnVwZUcycmlTNDcwQWgrT0Z6?=
 =?utf-8?B?dFJLbkh1SmFPeUU2emhVRmw2Yk1lYk8vaE9kdVVjZFowU25BRHdKZlU4VXNO?=
 =?utf-8?B?eGlNY29zekNDckg4VkcxRzdEVzY1RWdEN0lYbkNXdnM2c3JYTkpWTWxKN0xl?=
 =?utf-8?B?NzVyVThaazR4UCtZWHRWTTlXN0RvcUpzWndDdURlRGthMXJmd0NVMlRpYnQ5?=
 =?utf-8?B?dDRmNWF0bjRUM0ZyTGRqMzNJaExrRTg1YzZYREk4d1dnMlNiN3pFOTVlMDZV?=
 =?utf-8?B?aEtFMlJUdzJYQW9BUTRXSkdob1VjNXhTSlpzbFRhT2V4NzRyWFRtcis3V3Vn?=
 =?utf-8?B?YWtUcXlGYVBYeUc4T0JkMlBwRUM0ODloTmdNZWJlVExONEVXdFFZRm55bXR5?=
 =?utf-8?B?SG9lQW4zZTNZdnpNMi9UQi91L2tIRzFoaFl1Q0FsVmRXSytRbU5OcU5yZHFR?=
 =?utf-8?B?U1hmTVRpeVoxYnVvRU9SYVorbWkzV3hDMkZmNUhNYjJibXFNV1FhN0NIQWtO?=
 =?utf-8?B?RmdmWW00YUJ1ZWJ4aENJMHlwRk5JSi8vSDdESVlpSU1ScWhRWXhKV0VjMjVz?=
 =?utf-8?B?WlI3MWVMZGQvWCtFVE5sZi9lOXZkalViMTJZVU5TUi81eVhDbFBYdGdsWHNS?=
 =?utf-8?B?Njl0dGpHSHJFUHJKM09kOTlxMzRFai9hSmszaUM2K1dDZDUrYW9SbjJhUWdj?=
 =?utf-8?B?U2haeHhwcDNiQ3JoQVVRcWJ2YmRxaStTY3ZYbkFpUWMrK0hEKzBjd21PbllG?=
 =?utf-8?B?Znc5K2VPakdtQWlZNUlyUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RnlzbitZM2FMbTlJSkxuRkdZem5JR01UczNaVXBGRytCaWtWK2pua25YTzVD?=
 =?utf-8?B?N3lXUGlkQThrYlF6K2ZXdlZrVnRqNXA3cCtkbmRFTnhGNWRRZmk4UDhhV3ha?=
 =?utf-8?B?Mkc1TXJNL01LTzVPcHVoWlhSeTBEVHVjWEdzcXVYWFBRSmpyT2FjZGtFMGM5?=
 =?utf-8?B?QTdnWDVNMm4zam9OTjNUanBXc2ZpdjkzalRHdzVVZXp4TDgvanh1VWtpUFkv?=
 =?utf-8?B?WEY2U0hsR3dvWXNOK0FtdHFScGJiWFRRR2ZjZVNuek91ZVFHNEdFdDlmWUZY?=
 =?utf-8?B?MkNkRURCYVoxc3NQRThKcUNKTFhoYW56MXdWemhhSWY5TEx1b2M5a1dYS0J6?=
 =?utf-8?B?QUtaQWpNRFUwbUxvRHNLOTllOWlOVm13L2RMU1ExTGxiZWlCZTBMd0dSNGlJ?=
 =?utf-8?B?dzR5V0pDeS9HVW9Eb3h1R000WlVEbDNSNVo3VTZwRmllSmoweEhmOE5hUkhi?=
 =?utf-8?B?NExTNzBDWDUyS1dEQngvZjFLbCtHenpLU2RrYTAwMFZjaEdiVGR1ZkxjTW1E?=
 =?utf-8?B?NThZM2dqTlY3ZGNVSkRmZUdJUU9Od3lzTVQzc0FIUHFMVEdLWTgzS01DTEw4?=
 =?utf-8?B?aUE3RUdlS3JiaGw2elFsVGlIOVlqNmtSZWpCYlFaT1NzNk5kd3BNRkVUYjdx?=
 =?utf-8?B?bmZOQWNiSTAxYlFtTythNk1IRGtTQjRXSFk3dUZaWmhZK2pJWUdGMFJuRkJ1?=
 =?utf-8?B?dVh1d0xpN2QvU01HZDVGYkNlMkN6dzNDWmNmT3MwMW5yYjYxaXZQUmRHbmF1?=
 =?utf-8?B?N0FCTkQ3elgwNHZMTFdRUVlDazFObnVNSXlZRnBiMW0vamo5bmpCZTk2OGpr?=
 =?utf-8?B?a0owRzFQdUpzMnNpTUJPNmJlNFFBWGxnM1VmTWZlOHR1UUhtYmQ2YzZ6YnRL?=
 =?utf-8?B?SHlpSTk5RkJhS0Z3L2N5WmM1aW1zeEdTd2E0OW5vblZ1M083MzFReU4xcXkx?=
 =?utf-8?B?Q3VCOHY2eVM4RG9LeGdsU1dDditqV1J4R0JpWVUySVMwUXRGd2UzbzBGODUr?=
 =?utf-8?B?WllwOFVyVndZNGF2U3FNUk9LUDNPRzlFZzR4MlFtVHhuWFl6QXFYZ0ExcXVx?=
 =?utf-8?B?MUFJZHpieTd4T25oSWpOWjJqMHRiZEIyTkpzWExIVmpjNWRsejFPbTlORlRv?=
 =?utf-8?B?MWp0Mk5OOVhVUnhWYmJXSGlQeWlFdVNjRzJMb0dtUmZENWdnYkFnc1EvNURX?=
 =?utf-8?B?dFJJbXJTUDhPbE5CRW85TkVhQkJCanlBeFh2elA0Sm9PYTQySklOTE84M0ZO?=
 =?utf-8?B?Ui9oVmdpOTZNR1cvVW5rZ2JvZEFMQVRxcjgvUjFXcWN5ZTNub0kvTDVCZGJ6?=
 =?utf-8?B?N0hCWnJwMC9MU3BsWXFRL0d2b01UU0lrZFBEbk5VZWdIYVFXOHdidFdrWmNp?=
 =?utf-8?B?QlQvQjZDaitNQVdYVWdsTDdMcnlxeU41VmVRTzhkdVZvQ2dJNFA3WmlFYmR6?=
 =?utf-8?B?MWdlWFJUN1kvWnRGTnlJUWYyRjlKQkRqL0FtclVJaEczUUhrU2hmWk9YNjRu?=
 =?utf-8?B?ZEFZZkRCY2UzTlRvelF4a1FNUCtBMW9HOU5vemxSbW9BVXJrS0FLUjlxcFJ6?=
 =?utf-8?B?VUlwV1NUUWF2SVZTV0d6WFVJRFVKbDVtMVRMMldVdXczbll2bVE2eDhqbzd0?=
 =?utf-8?B?cmdOSVdzYSt6T1dvMWpEYkZGOVFSTm5Jb3c2dHdIaEpaaXl1WitzaE0vemw2?=
 =?utf-8?B?V3JNYTlsMEluNUprckZBRXE1SmNOV3d2UWp0QjBySlorLzBBVDFSNjkySHdq?=
 =?utf-8?B?dXNjRTFBWW1malVhTS9sY0c1c3k1ZXBCU0ZFK2s1Yi9xRWlsRWJyZUg1MEpv?=
 =?utf-8?B?YWNZUVRjWVg1SWt5TzlTUFFYZzVUUDFwTldXZkRVeVFoQndmU29meEY0SzBu?=
 =?utf-8?B?Nkh1OUNkSFFBNUdMNFo0OWsrU3VEbldBMDJUS3M0VVdFTDUwVkhNU2QzdDNh?=
 =?utf-8?B?ZXpRV3R5ZDhlcUwzR1RXbFNDY2tJUEgvbWZXTTZMdDlVVGZ0QmI0YjNkK3Fv?=
 =?utf-8?B?RnhiQy9ya1NEcTRLTGZrK2RURGl2dEVwdVNRdEtqVnhBUDR2L0lvQnVwY2pr?=
 =?utf-8?B?UXl3VHBDaEdrL3A4aGp4ZzJOazRyTlVDdllLbjQ1UHYxdlBxcUJ6QjE1dHRI?=
 =?utf-8?Q?pPJQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3779e1-8f22-42c1-1e9b-08dce8807d4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 16:36:13.4912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4VUQ05ZjS8CrYLVtZwEjUOGbQFc6nviHcs7wG8WT+bKfM7zqqjdNgrpRVA6A9GTh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4460

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW5pZWwgU25lZGRvbiA8
ZGFuaWVsLnNuZWRkb25AbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE9jdG9i
ZXIgOSwgMjAyNCAxMToxOCBBTQ0KPiBUbzogS2FwbGFuLCBEYXZpZCA8RGF2aWQuS2FwbGFuQGFt
ZC5jb20+OyBKb25hdGhhbiBDb3JiZXQNCj4gPGNvcmJldEBsd24ubmV0PjsgVGhvbWFzIEdsZWl4
bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+OyBCb3Jpc2xhdiBQZXRrb3YNCj4gPGJwQGFsaWVuOC5k
ZT47IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47IEpvc2ggUG9pbWJvZXVm
DQo+IDxqcG9pbWJvZUBrZXJuZWwub3JnPjsgSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+
OyBEYXZlIEhhbnNlbg0KPiA8ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tPjsgeDg2QGtlcm5l
bC5vcmcNCj4gQ2M6IGhwYUB6eXRvci5jb207IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBwYXdhbi5rdW1hci5ndXB0YUBsaW51eC5p
bnRlbC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzZdIHg4Ni9idWdzOiBDcmVhdGUgc2lu
Z2xlIHBhcmFtZXRlciBmb3IgVkVSVyBiYXNlZA0KPiBtaXRpZ2F0aW9ucw0KPg0KPiBDYXV0aW9u
OiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHBy
b3Blcg0KPiBjYXV0aW9uIHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3Ms
IG9yIHJlc3BvbmRpbmcuDQo+DQo+ID4NCj4gPiBBdCB0aGUgeDg2IHVjb25mIGF0IExQQywgc29t
ZW9uZSBhc2tlZCBtZSBhYm91dCBpZiB3ZSBzaG91bGQgaGF2ZQ0KPiBjb21tYW5kIGxpbmUgb3B0
aW9ucyB0aGF0IHdlcmUgbWl0aWdhdGlvbi1mb2N1c2VkIHJhdGhlciB0aGFuIGJ1Zy1mb2N1c2Vk
DQo+IChsaWtlIHRvIGVuYWJsZSBTVElCUCwgSUJSUywgZXRjLikuICBUaGUgZmVlZGJhY2sgSSBo
YWQgdGhlcmUgYXBwbGllcyB0byB0aGlzDQo+IHNlcmllcyB0b28sIHdoaWNoIGlzIHRoYXQgSSdt
IGNvbmNlcm5lZCB0aGlzIG1ha2VzIHRoaW5ncyBtb3JlIGRpZmZpY3VsdCBmb3INCj4gdXNlcnMg
YmVjYXVzZSB1c2VycyBhcmUgcmVhY3RpbmcgdG8gYnVncywgdGhleSdyZSBub3QgZXhwZXJ0cyBp
biBtaXRpZ2F0aW9ucy4NCj4gQSB1c2VyIHdhbnRzIHRvIGtub3cgaG93IHRvIG1pdGlnYXRlIENW
RSBYWVosIGFuZCB0aGUgYnVnLXNwZWNpZmljDQo+IGNvbW1hbmQgbGluZSBvcHRpb25zIHN1cHBv
cnQgdGhhdC4gIEl0J3MgYW4gZXh0cmEgc3RlcCB0byBzYXkgdGhhdCB0byBtaXRpZ2F0ZQ0KPiBN
RFMsIHlvdSBoYXZlIHRvIGZpZ3VyZSBvdXQgdGhhdCBNRFMgcmVxdWlyZXMgY2xlYXJpbmcgY3B1
IGJ1ZmZlcnMsIGFuZA0KPiB0aGVyZWZvcmUgeW91IHNob3VsZCBzZXQgdGhpcyBtaXRpZ2F0aW9u
LXNwZWNpZmljIG9wdGlvbi4NCj4gPg0KPiA+IE15IGdlbmVyYWwgY29uY2VybiB3aXRoIHRoaXMg
c2VyaWVzIGlzIGl0IHNlZW1zIHRvIHRpZQ0KPiBYODZfRkVBVFVSRV9DTEVBUl9DUFVfQlVGIGRp
cmVjdGx5IHRvIHRoZXNlIDQgYnVncy4gIFdoYXQgd291bGQNCj4gaGFwcGVuIGlmIGh5cG90aGV0
aWNhbGx5IHRoZXJlIHdhcyBhIG5ldyBidWcgdGhhdCByZXF1aXJlZA0KPiBYODZfRkVBVFVSRV9D
TEVBUl9DUFVfQlVGIGFuZCBzb21lIG90aGVyIG1pdGlnYXRpb24/ICBXaXRoIHRoZQ0KPiBleGlz
dGluZyBidWctc3BlY2lmaWMgb3B0aW9ucyB0aGlzIGlzIGVhc3kgZW5vdWdoLCBhcyB0aGUgbmV3
IGJ1ZyBjb3VsZCBmb3JjZQ0KPiB0aGlzIGZlYXR1cmUgYW5kIGRvIHdoYXRldmVyIGVsc2UgaXQg
bmVlZGVkLiAgQnV0IHdpdGggYSBtaXRpZ2F0aW9uLXNwZWNpZmljDQo+IG9wdGlvbiBsaWtlIHRo
aXMgb25lLCBpdCB3b3VsZCBzZWVtIHRvIGJlIGhhcmRlciBhcyBpdCBtaWdodCByZXF1aXJlIG11
bHRpcGxlDQo+IG9wdGlvbnMgdG8gbWl0aWdhdGUgb25lIGJ1Zy4gIEFuZCBjb3VsZCBjcmVhdGUg
Y29uZmxpY3RzIGlmIHlvdSBlbmFibGUgdGhhdA0KPiBuZXcgbWl0aWdhdGlvbiBidXQgZGlzYWJs
ZSBjbGVhcl9jcHVfYnVmZmVycy4NCj4gPg0KPg0KPiBBbnkgbmV3IGJ1ZyB0aGF0IGlzIHVzaW5n
IFg4Nl9GRUFUVVJFX0NMRUFSX0NQVV9CVUYgd2lsbCBiZSByZWxhdGVkIHRvDQo+IHRoZXNlIGV4
aXN0aW5nIGJ1Z3MgcmVnYXJkbGVzcy4gV2UgbWF5IG5lZWQgdG8gYWRkIGFub3RoZXIgb3B0aW9u
IHRvIHRoaXMNCj4gcGFyYW1ldGVyLCBzaW1pbGFyIHRvIHdoYXQgd2UgZG8gd2l0aCAiLG5vc210
IiwgYnV0IEkgd291bGQgaG9wZSB0aGF0DQo+IHdvdWxkIGJlIHN1ZmZpY2llbnQuDQo+IFdpdGgg
dGhlIGV4aXN0aW5nIGJ1Zy1mb2N1c2VkIHBhcmFtZXRlcnMgd2UgaGF2ZSB0aGUgc2FtZSBwb3Rl
bnRpYWwgZm9yDQo+IGNvbmZsaWN0cy4gV2hhdCBpZiBJIHNheSAicmVnX2ZpbGVfZGF0YV9zYW1w
bGluZz1vZmYgbWRzPWZ1bGwiPyBTaW5jZSBtZHMgaXMNCj4gb24gcmZkcyB3aWxsIGJlIG9uIGV2
ZW4gdGhvdWdoIEkgcmVxdWVzdGVkIGl0IG9mZi4gVGhlIGludGVudCBvZiB0aGlzIHBhcmFtZXRl
cg0KPiBpcyB0byByZW1vdmUgc3VjaCBjb25mbGljdHMuDQo+DQo+ID4gSSBkbyBnZXQgdGhlIHBv
aW50IHRoYXQgdGhlc2Ugc3BlY2lmaWMgNCBidWdzIGFyZSBhbGwgY2xvc2VseSByZWxhdGVkLiAg
QW5vdGhlcg0KPiBpZGVhIHRvIGNvbnNpZGVyIGNvdWxkIGJlIGEgc2luZ2xlIGNvbW1hbmQgbGlu
ZSBvcHRpb24gZm9yIHRoZXNlIDQgYnVncywgYnV0DQo+IGlzIHRpZWQgdG8gdGhlIGJ1Z3MgdGhl
bXNlbHZlcywgbm90IHRoZSBtaXRpZ2F0aW9uLiAgVGhhdCBtaWdodCBiZSBtb3JlDQo+IGZ1dHVy
ZS1wcm9vZiBhcyB0aGUgc2NvcGUgcmVtYWlucyBvbmx5IGFib3V0IHRoZXNlIDQgYnVncywgbm90
IHRoZQ0KPiBtaXRpZ2F0aW9uIGl0c2VsZi4NCj4gPg0KPg0KPiBBcmUgeW91IHN1Z2dlc3Rpbmcg
YSBuYW1lIGNoYW5nZSBhd2F5IGZyb20gImNsZWFyX2NwdV9idWZmZXJzIiBzaW5jZSBpdCBpcw0K
PiBjbGVhcmx5IGFib3V0IHRoZSBtaXRpZ2F0aW9uIHJhdGhlciB0aGFuIHRoZSBidWc/IEknbSBu
b3Qgc3VyZSB0aGVyZSBpcyBhIGdvb2QNCj4gY29tbW9uIG5hbWUgZm9yIHRob3NlIDQgYnVncyB0
aGF0IGlzbid0IGFib3V0IHRoZSBtaXRpZ2F0aW9uLCBidXQgSSdtIG9wZW4NCj4gdG8gYW55IHN1
Z2dlc3Rpb25zLg0KPg0KDQpZZXMsIEkgdGhpbmsgdGhhdCB3b3VsZCBiZSBiZXR0ZXIuICBJIHdh
c24ndCBzdXJlIG9uIGEgbmFtZSBlaXRoZXIuICBJbiB0aGUgUkZEUyB3ZWJwYWdlIEkgc2VlIGl0
IGRlc2NyaWJlZCBhcyAic2ltaWxhciB0byBkYXRhIHNhbXBsaW5nIHRyYW5zaWVudCBleGVjdXRp
b24gYXR0YWNrcyIuICBQZXJoYXBzIHNvbWV0aGluZyBsaWtlIHRoYXQgY291bGQgYmUgYW4gdW1i
cmVsbGEgdGVybT8NCg0KLS1EYXZpZCBLYXBsYW4NCg==

