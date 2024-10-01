Return-Path: <linux-kernel+bounces-345091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C51798B1EF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 03:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AA481C211A8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B55D2263A;
	Tue,  1 Oct 2024 01:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AobD8Okw"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA15BC8C0
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 01:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727747586; cv=fail; b=X0QU8kXl/gazPJxKr4Hf2xrEl1Eg1ts3GBnKaGyR3laq7eitxzFHzDKygJgU0o9dX1JYqrDQDmLOoyjZ0YtRZao+w681DoiEEsdQ0wSWU1l7hDmgKA9BV/ErffRNxnEzCXiMzbzVIVIwGmbjWczQyhJx0Kd1naaV6cnbSSaJn9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727747586; c=relaxed/simple;
	bh=JBstvybXKX92MLwgLcJRtIQKADWtLnkhoFDtSQlV99g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c4dtqfo5KbxbgzKlEX5nnnkfC7wf8lo8ss1Zvq5l/hYjbPFUu18wjJs98CRpgJZ8vR8vxtUkm0WDQMBGhX9AMpTh7zpiuCBNFshPhz+SATI8HPly/Dhi7WUXUa8JkgPSk54bJ5cEwty0nA7F1zRFdlvZ+c625Wkm3MSI+Iifw+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AobD8Okw; arc=fail smtp.client-ip=40.107.92.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KhbGKY4KF1mqsalruBTzo6P8OsH9qOYrAU+jSqvEKHlw53oU9rhW2txCk7qd8J96UUoEE0wKrq8VkVaFN9Ql5y5Djny2XeCVs7IJ+jrVnTF3xpKl02ciIuYnCu9F0j0RfptsmebwRa+GNNQGazl6PlEfxG4EIp7olWFbN9k40ffaB3adKIxxpt3nQ3yfl+B+39XfkBPKM71EinnVJd4EKWhoLw4e2mLtEMeZMJ3b905e1/CJxlfYQ9hbuv4yHH6B8ay2Rp6s6GfzMG3W3m7la/vwRYxOSKh55jzxAqktatSPaVbUUTu9sX8+ADaF+YdySPUC8WqTzldGa45wY+1Pww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBstvybXKX92MLwgLcJRtIQKADWtLnkhoFDtSQlV99g=;
 b=TbsowW6VouBZZiv3QRuDANVlu6WwI8EBdy3donRdUuOQIbf0CiZTh8w10WcasoWiHuOnZ0lvrvHYa+/u0o0SnKYVhEQ/deBBIxYWn/n3Lg8bQhm+3VrFSHCD4DwRLYnCbX9AlPhgkw8Tz2wVOss79vIqGcrG7yMxZIW5w9g5R0Hf93uux2hsifD2BJXsNKo831Ja5ucZ3kyoqkl8nuR5lh58Vd1e7K5OXrGAIT1XO4M8PYG+aXliaLh4aBss1FSyVFqJ3f0B0SMkU4IIyUQ+OSkeSIoa0SUJz7cvAdGWIzcfou0HMQqDKPYfLK9I2nNuaHVUcvjF0sJdCOQZp9r8kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBstvybXKX92MLwgLcJRtIQKADWtLnkhoFDtSQlV99g=;
 b=AobD8Okw1Ddu8TPbIiZTHWJuESBy/yFJXSEr4qt26DhqoZ85+P93/GZxEKaxFLVmpktEgdieezFjAQmWzgVbWuAApwIhc+Fzvno195v1YHPCQ9yJ8kgeDkXmgjmjwwB3aztNOYCFYi4I26Q5Qsw52rtX2GkorJY3dDIA9ljtd+U=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by DS0PR12MB7927.namprd12.prod.outlook.com (2603:10b6:8:147::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Tue, 1 Oct
 2024 01:53:01 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%4]) with mapi id 15.20.8005.024; Tue, 1 Oct 2024
 01:53:01 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: "Manwaring, Derek" <derekmn@amazon.com>
CC: "bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>
Subject: RE: [RFC PATCH 18/34] Documentation/x86: Document the new attack
 vector controls
Thread-Topic: [RFC PATCH 18/34] Documentation/x86: Document the new attack
 vector controls
Thread-Index: AQHbE5sLFuUSTCp+ykSJ7EQ793vS4LJxIFVw
Date: Tue, 1 Oct 2024 01:53:01 +0000
Message-ID:
 <LV3PR12MB92651C6977B4F6F701416ED294772@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20240912190857.235849-19-david.kaplan@amd.com>
 <322d7585-44d0-42c7-bd45-8896b88e7882@amazon.com>
In-Reply-To: <322d7585-44d0-42c7-bd45-8896b88e7882@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=2af0d44c-7299-4165-8fc4-5f8b596ead86;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-01T01:46:45Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|DS0PR12MB7927:EE_
x-ms-office365-filtering-correlation-id: f4bc2fe8-b66f-4882-d930-08dce1bbc862
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S2Uva29uYzJwSWd2TVlOQnRGUGRkVmI0V1Brd1F0MGFQT0JlQXJ6d1hKWGw0?=
 =?utf-8?B?TzZxT01wVlRpVkRvL01PM3o5VzlZMENreUUwQk9LMGJyaVFTOEhSNmJVL3Q2?=
 =?utf-8?B?TTd2RWo4KzIvZXUreG5NK2lnMzB1YmxoZ21QOVdBYTQ5TTk2NWxZUWliRGpZ?=
 =?utf-8?B?SXpJYmtjT2xpeU43dStjcXBKYjRQOEovRUFCd0NFMndubE9rS25nNXpOODV0?=
 =?utf-8?B?dXJhVUx2cnc0SEg4NUZ1VGhvRzQrQitaa3ZYVDVId0pNVVdlK1ArSlI1MVVV?=
 =?utf-8?B?c3lOSGd5S2xmd1UrdzBzYjdTYjhJV095U0QwaW5pQmF1VTd2VXBoM0xRQTgy?=
 =?utf-8?B?UHdka0JoendzaU9PN0FlU1lXTWt2VnNNZ0xLRkRxZHVmTzdVZVcwZjhGWmUr?=
 =?utf-8?B?L2YyVTBxVjhBN0tjRGJXWmZSaXZsOWw3S1JLSlJ5cTRKTkFrN2tBTGEzVWtJ?=
 =?utf-8?B?MTVuVExqSXRMUytvb1N3SFFjbVR0TWhJd2dDaldFNWJreDFVT1d2WXpWODkv?=
 =?utf-8?B?TmpVcDJFZWcvT2VtbmQ4S09NVjVHdmE1c01hb08rZ01DZmpsOFV0VlR5RVFo?=
 =?utf-8?B?YzFLci9FNkVxODZGRDNML2RCWVZaeDY4eUVwN3pibHZVSnJBVVVzclRqMno3?=
 =?utf-8?B?UkhvNWdLTm01c2FaNmdkTHNlaFAyYThUaGhNbWRpTXJuY3lMY05OTHdoam5X?=
 =?utf-8?B?MmlsZWV1L2o5SzBjWU92SzZ3Tmd0Sko1VjlqejkvQlB3YktvZ2E4bXEvZnJL?=
 =?utf-8?B?ZlJGZXRUaGJXSG5CNmRFRXVQMkVTK2l1WmFzaTdOY2JldFQrSllMYmNQaHQ5?=
 =?utf-8?B?cVFVRmM0bmNUVmtmcVpLc2wrZ1UveUdPaXJNcUhEelhSaXVDaGpzeHZCdDIy?=
 =?utf-8?B?YVhIZXNtM2tiQjdVYjFWUFVPYllKZkZZelhLeXk4cDliK1Fobk1IYUU0RFc5?=
 =?utf-8?B?WWNJWVNMWnh4NDNpRjBiTjNwYTBwSGN1bjFQOUZ2Y0JtemRwSjlRNUwyVnVn?=
 =?utf-8?B?RFdHYjlrMkMwZ1Vsczd0dkRDUTBpTHZtejUzQ3gwazZXdFFBV21FQ1lxVHZq?=
 =?utf-8?B?Q3VoQVd0RklkNW55a010WFBIYy9BWHA3TnlETm9hb2prbTJBajVNcXhlVFFY?=
 =?utf-8?B?RDVjVGk5RVBmM0xxY1d3S1pqT0lheUpmb3ZmWW14NlpwbWlOSU9Zb1pQb3RI?=
 =?utf-8?B?NE9teEpPTkxGdDBEaVNKRGRCS3JSQ0tDRnlzY1hoQ0Z0VHRRNXFmZEdnSnVO?=
 =?utf-8?B?S2dObTlTblQ0NW5CUDJTUHBxR214L1B2dHpWVUNFZFJ4elludkVCOE94N2JJ?=
 =?utf-8?B?Z3Jka3A0YVI2RHFpYnNzN01UTldBMEl2aUY3OTd6L3lvRm1kMGNYaGd0TXYw?=
 =?utf-8?B?OFR6MmRvSGFnLzlPZ0tQZ1FybDhtTE0ydXhSM1IwS0F5OHZMbnUrbHhmZWN3?=
 =?utf-8?B?ZlhLWkhxRjJtREViS2tnV1EralpBc01LdjEwZ2JhZ2JvamE3MmhjbVkvMXR5?=
 =?utf-8?B?bnlQTFphRXV2QWRLQlJReDdGaUkxSTFSb043RVE2Slc1ajFRdzcwV0ZwVkpV?=
 =?utf-8?B?ek9FcWhVMXdVK01jNXJKd0wvUlAzQmF6SVEwZ2xDMVpHaEhadHBqV0NCWXl6?=
 =?utf-8?B?REJwUnh1QUl1Wmt3aGV3V1ZENGF6ZUlFQXZrYlVjM2FISXhRK1pWdHRidGtw?=
 =?utf-8?B?WlgyMTBEUTFueFhJd2ZYcjBaM3E5STJKd1dUamNydG5FeVdGTllPeEFZcHBU?=
 =?utf-8?B?aEFIUkdUZ2t2ay9GYjdPUmlVZzFKK0JiTkhzWmFoSEoyUTZadjFIMkNxaWRp?=
 =?utf-8?B?NEdEV2lnaHAvM3JOcnhoQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TE9hU0Y1VVZKVW5XdlZTL1NoVlJBRDRiMTBmTTQ2NXJPYmZQVFEwTHF5NFpP?=
 =?utf-8?B?aHpNY2NZcmtCQVBuZEp6S0RJWVpkdXVLY1FnY2JZZDBycm1US3dqd1RCL0R6?=
 =?utf-8?B?ZzhqcTdpVWdwYW54Q050Y3NnODNISHFLUWRjcXpLUFBVTlBuVlZnRzBBZ1F6?=
 =?utf-8?B?ci8vcG1lc0V5S3hZT0l0b3N1N295OXg0S08xd3ArSzdjekt2REphRlc4YkNF?=
 =?utf-8?B?TUQ2K1RpdnNGNkdqNmtOckFsVk45cmtreEx6c3MyNXJoMFRPWmo1Y2d1VVZX?=
 =?utf-8?B?MjlveW0vZUZ6VXpjWEc5VFRFRU9LZkVMUWdkOXczT0NSTUJWUm9jNlpzdnhs?=
 =?utf-8?B?c2kwRWJKYWhwWllGb1JlWVlMbU12bGFrRVFIRW9YWlZsamNaUnR2NkhaTVNZ?=
 =?utf-8?B?eUoybEdJR2VRNDF6b0VVK3RtRHZvQ3JZZHRvcnhNNkhxQm5ET3hxS3VKMm5p?=
 =?utf-8?B?bUJFc3J2eGFvaDAvVGR1Q1c2MGFJRGhPTkgzL2F6bGpqY3grQXBMajMxRFRU?=
 =?utf-8?B?K291anNHc0tkMGFwenlpWGhiKzdvZ201ZU9mWTErZ0ZEOStDOFlhUjJaK1Ay?=
 =?utf-8?B?cFVmUlRxTWJHY05pVFhpbU8xTndFeG9taWptbjFkNytoa0dnSlgxZE4yME1D?=
 =?utf-8?B?aGQ2Wmtsak0rWDJDenJpWThOd2xPOTc3c1NpRWI4K0o4L0Nzb1pvczA1clBH?=
 =?utf-8?B?djh3VUZ6eW5ob0U0SDlJbVlHY0FuTEJlU3hHV29wVSttY0g2bnNqOWQwcXIv?=
 =?utf-8?B?VnlQaW5pdEE0TzRYZ0lKQ3hhVnZEaVZtOUZVREI2dThEYlhpNGtRb0dQdXRS?=
 =?utf-8?B?eHNuM0YrWXpkQVVQd2pXM2I5TVVwOGcvR1VyZ3RTT3NpckV3d2Z3VjVzNnZQ?=
 =?utf-8?B?S2ZjMTZ6dUdOa3RZaTlSM3JneWJ5c0R4Z0V0dVdRMWxtQTVCUjQ4ZkdheFdT?=
 =?utf-8?B?WEt4MDFTc2hWNTBxbFY5VkM0Z2ZWQU1UbTRoV0lIZm1xNDh6VTFrQUg1MWhH?=
 =?utf-8?B?L0JzcGRaOFQ4VmIzSzB0U1duSDZ1ZWJyM0ZPZHB1UjRZeEJCMm1mbWlFNFZv?=
 =?utf-8?B?UG5PdmhlNlZNTGtrQ1MvandkbXpFQkttUEhDYk5LbVVJeWlVMVpGRkYzYUNj?=
 =?utf-8?B?bDNubWdQWnNDVXdwV1Q5RDl5WktJNm95VGdXelZyVndHVXF0aTN4MHFxbGgx?=
 =?utf-8?B?UFQrRXhNRHJpUkx5TW5oMk5BdGUzN2xacE1MaTJNKzUxbkZVTjR1SG5LUUox?=
 =?utf-8?B?bXF6bjBNR1M2cDlBRkdtNXRrakp6SzVRK3BrbktZQVpvcTF2dDltRHRZVUtP?=
 =?utf-8?B?WjZrbURhRkdtZWNnM2F4UVRBUUtqK242a1ZpNkFtUmI4ZkFHMzdzQ2huZjJ3?=
 =?utf-8?B?b2tyMUVxMjg4dlhCNHR6bkRnT0txbzV2b2VPUGRIcndLMnpyemYwTnE3NTh2?=
 =?utf-8?B?d0JYMTUxYVU0WXNGNlRHblZQSnVMd1ZkSitYb1pkaXQ1L0VSb3lHUmpPYmhF?=
 =?utf-8?B?U29xSWhidXk5OHdMNG9BVU1mdllTclc4VW8rL1NhU3hvM1R2TDRkV2JjREZ2?=
 =?utf-8?B?ZHVVQXdpejQwaG9EU3lzeWl4TUFxSlNORUVNV2ZGV2xwRHdWditOMDh6TTAz?=
 =?utf-8?B?a2k3QlErMThNSHlkTzRLT1l0NGlIYVg2ZGIySTNaRC9IamlJQVVsWmZUYjh3?=
 =?utf-8?B?V1Jsd2c5dHpJaWw1ejY2bzNubVNtUzhQNVltdjJCOUFFZkY4cTAzN1l4QXgy?=
 =?utf-8?B?RTlDTU5JSDhhQ3p3cWpVaHhsREd0Q05vTnowRTRTUTJDSCtZZHc4NzJ6b0gw?=
 =?utf-8?B?ZGR1TG94ZXlEbnlXWmtsYTRUQkZpMElJdVhQbHFiRWFzU0dkNEdhVjVRUDYv?=
 =?utf-8?B?dVdsc3B1SjMyTEwxOWFwS3FOakNhRVJ2d21RKzNmb3YyOE5qaW9DYm5QRDJ2?=
 =?utf-8?B?Q2x0SEJrd3JXRm0veCtkcDNhc2FxamVvdmgyemp4WlZrdVNieUtUTWgwN3J4?=
 =?utf-8?B?VEdocHNTeGlqK1hneWVCOXRaczNicW10bytId0IxOHJ1bEQyQnFaVXRIaUtt?=
 =?utf-8?B?QWtRd2oyNGM4aHFqK0RHRWpFeWJFSmtuUVNIRHVkVXU3Zm1MRW83K1JaQ1Bu?=
 =?utf-8?Q?pdXM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f4bc2fe8-b66f-4882-d930-08dce1bbc862
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 01:53:01.6597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: afAGon20N4QYWsjqPwn5ukBtkQtdlUJ4mTQj3Ob0zkAEcqGu49sclOcTyX2gHrA3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7927

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW53YXJpbmcsIERlcmVr
IDxkZXJla21uQGFtYXpvbi5jb20+DQo+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDMwLCAyMDI0
IDc6NDQgUE0NCj4gVG86IEthcGxhbiwgRGF2aWQgPERhdmlkLkthcGxhbkBhbWQuY29tPg0KPiBD
YzogYnBAYWxpZW44LmRlOyBkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb207IGhwYUB6eXRvci5j
b207DQo+IGpwb2ltYm9lQGtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IG1pbmdvQHJlZGhhdC5jb207DQo+IHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbTsg
cGV0ZXJ6QGluZnJhZGVhZC5vcmc7DQo+IHRnbHhAbGludXRyb25peC5kZTsgeDg2QGtlcm5lbC5v
cmcNCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggMTgvMzRdIERvY3VtZW50YXRpb24veDg2OiBE
b2N1bWVudCB0aGUgbmV3DQo+IGF0dGFjayB2ZWN0b3IgY29udHJvbHMNCj4NCj4gQ2F1dGlvbjog
VGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9w
ZXINCj4gY2F1dGlvbiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNraW5nIGxpbmtzLCBv
ciByZXNwb25kaW5nLg0KPg0KPg0KPiBPbiAyMDI0LTA5LTEyIDE0OjA4LTA1MDAgRGF2aWQgS2Fw
bGFuIHdyb3RlOg0KPiA+ICsNCj4gPiArU3VtbWFyeSBvZiBhdHRhY2stdmVjdG9yIG1pdGlnYXRp
b25zDQo+ID4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICsNCj4g
PiArV2hlbiBhIHZ1bG5lcmFiaWxpdHkgaXMgbWl0aWdhdGVkIGR1ZSB0byBhbiBhdHRhY2stdmVj
dG9yIGNvbnRyb2wsDQo+ID4gK3RoZSBkZWZhdWx0IG1pdGlnYXRpb24gb3B0aW9uIGZvciB0aGF0
IHBhcnRpY3VsYXIgdnVsbmVyYWJpbGl0eSBpcw0KPiA+ICt1c2VkLiAgVG8gdXNlIGEgZGlmZmVy
ZW50IG1pdGlnYXRpb24sIHBsZWFzZSB1c2UgdGhlIHZ1bG5lcmFiaWxpdHktc3BlY2lmaWMNCj4g
Y29tbWFuZCBsaW5lIG9wdGlvbi4NCj4gPiArDQo+ID4gK1RoZSB0YWJsZSBiZWxvdyBzdW1tYXJp
emVzIHdoaWNoIHZ1bG5lcmFiaWxpdGllcyBhcmUgbWl0aWdhdGVkIHdoZW4NCj4gPiArZGlmZmVy
ZW50IGF0dGFjayB2ZWN0b3JzIGFyZSBlbmFibGVkIGFuZCBhc3N1bWluZyB0aGUgQ1BVIGlzIHZ1
bG5lcmFibGUuDQo+DQo+IFJlYWxseSBleGNpdGVkIHRvIHNlZSB0aGlzIGJyZWFrZG93biBvZiB3
aGljaCBhdHRhY2tzIG1hdHRlciB3aGVuLiBJIHRoaW5rDQo+IHRoaXMgd2lsbCBoZWxwIGRlbXlz
dGlmeSB0aGUgc3BhY2UgZ2VuZXJhbGx5LiBJIGFtIHRlbXB0ZWQgdG8gYWRkIGV2ZW4gbW9yZQ0K
PiBpc3N1ZXMgdG8gdGhlIHRhYmxlLCBidXQgSSBzdXBwb3NlIHRoZSBpZGVhIGlzIHRvIGxpbWl0
IG9ubHkgdG8gaXNzdWVzIGZvciB3aGljaA0KPiB0aGVyZSBpcyBhIGtlcm5lbCBwYXJhbWV0ZXIs
IGlzIHRoYXQgcmlnaHQ/DQoNClJpZ2h0Lg0KDQo+DQo+IEkgdGhpbmsgaXQnZCBiZSB1c2VmdWwg
dG8gZ2V0IHRvIGEgcG9pbnQgdGhhdCBpZiBzb21lb25lIGNvbWVzIGFjcm9zcyBvbmUgb2YgdGhl
DQo+IG1hbnkgcGFwZXJzICYgaXNzdWUgbmFtZXMsIHRoZXkgY291bGQgZmluZCBpdCBoZXJlIGFu
ZCBoYXZlIGFuIGlkZWEgb2YgaG93DQo+IGl0IGltcGFjdHMgdGhlaXIgd29ya2xvYWQuIE1heWJl
IHRoaXMgaXNuJ3QgdGhlIHBsYWNlIGZvciB0aGF0IGtpbmQgb2YgYQ0KPiBnbG9zc2FyeSwgYnV0
IGludGVyZXN0ZWQgaW4gaGVhcmluZyB3aGVyZSB5b3Ugc2VlIHNvbWV0aGluZyBsaWtlIHRoYXQg
Zml0dGluZw0KPiBpbi4gSWYgd2UgY291bGQgYXQgbGVhc3QgYWRkIGEgY29sdW1uIG9yIGZvb3Ru
b3RlIGZvciBlYWNoIHRvIGNhcHR1cmUNCj4gc29tZXRoaW5nIGxpa2UgIlNSU08gaXMgYWxzbyBr
bm93biBhcyBJbmNlcHRpb24gYW5kIENWRS0yMDIzLTIwNTY5LCIgSQ0KPiB0aGluayB0aGF0IHdv
dWxkIGdvIGEgbG9uZyB3YXkgdG8gcmVkdWNlIGNvbmZ1c2lvbi4NCj4NCg0KVGhhdCdzIGEgZ29v
ZCBpZGVhLiAgT25lIHRob3VnaHQgY291bGQgYmUgYSBuZXcgZG9jdW1lbnRhdGlvbiBmaWxlIHdo
aWNoIGNvdWxkIG1hcCBDVkUgbnVtYmVycyB0byB2ZW5kb3IvcmVzZWFyY2hlciBuYW1lcywga2Vy
bmVsIG9wdGlvbnMsIGFuZCByZWxhdGVkIGRvY3VtZW50YXRpb24uICBTb21lIG9mIHRoZSBpc3N1
ZXMgYWxyZWFkeSBoYXZlIHRoZWlyIG93biBkb2N1bWVudGF0aW9uIGZpbGVzIHdpdGggbW9yZSBk
ZXRhaWxzLCBidXQgbm90IGFsbCBkby4gIEkgdGVuZCB0byBhZ3JlZSBpdCB3b3VsZCBiZSBuaWNl
IHRvIGhhdmUgc29tZXRoaW5nIGVhc2lseSBzZWFyY2hhYmxlIHRvIGhlbHAgbmF2aWdhdGUgYWxs
IHRoZSBuYW1lcy9hY3Jvbnltcy4NCg0KT3BlbiB0byBvdGhlciBpZGVhcyBvbiBob3cgdG8gcHJl
c2VudCB0aGUgaW5mbywgYnV0IHRoaXMgc2VlbXMgbGlrZSBhIGdvb2QgdGhpbmcgdG8gYWRkIHNv
bWV3aGVyZS4NCg0KLS1EYXZpZCBLYXBsYW4NCg==

