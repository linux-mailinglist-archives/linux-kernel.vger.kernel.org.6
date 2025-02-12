Return-Path: <linux-kernel+bounces-511379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC03AA32A2D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A993A5A4A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC09121149C;
	Wed, 12 Feb 2025 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="htlaNnVb"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5008320458B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739374579; cv=fail; b=QQFd+GRXUCigupU3dwzmfFM3tGtW1J11bVr5sihiEqwkHZUR0yADNVZZRs+h/nBSHSPH98pm3ZQZ1anPCQIN5EU5dAVsSchyeHeYiwMiPnRlpIzcGqy3Iv0Zx3QdrPpsuv50kYjKnLysJbITQhbkPIWYd5ZOQpGLuaTNM+bWy68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739374579; c=relaxed/simple;
	bh=5JURavbIX4YLsMMz/ba99Qxz72cRax1ysR2m/VTYKLk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CFdc7SDpOKcDeAmcHlhvl3ER+XlUEs5OTVBMYG7goGY7qZZezHC12lqGV1EeXpo4rhIZJyPmmIqH1EA/Vu9ntXZWx5tb+iEA2ywJ+dKFu1atKgxNaDu+rEcmXmVBM4jIaIXqydBvG5gFRDt+iFZfmqSMwx5rU9ZpaAidDQ1WPnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=htlaNnVb; arc=fail smtp.client-ip=40.107.101.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=haUw+jdf6tXcvQ+latoStHMvYBFGvitAQW5pqb2Fv/QQhDHwvGMx9j34XrJBr/Gf4IHcdYRkNreZbkmKFQjfQKmqBvLXZU/tXY7bo0PO/AefM7Yrh5i9pqgKqGR+4Y/V7jdAcrEZiJ+2vRktSMwiD66jL/TgJQ8KyLfq2/7E6JJtDne7yPRX19McXNXh/QAcx6MmO2pN8zpohukEhfvEx+ND4S4USQQT0CFEJr+EnTH6msj+1iNW1DkfQgyTkvhoE3k+VQ0Mx+7kVbYFbdSZj2aIcwjx4cOE8Sg9xC3x2qZn3eWwyzN/HPhVLM0g4QwKzmCoD+V6QVh4CBa8NGmLQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JURavbIX4YLsMMz/ba99Qxz72cRax1ysR2m/VTYKLk=;
 b=T3znPOTHTzkDMM1vywNrGWWL6tFB2uIRzyHIUIWYHAFy8VdETlPGqhZa7DdwZFBH488H6qvfkF3zeQqOyceOvJb3l+uqWTtRA+czyl1zzKAXjA88lTae+Pg0C69nuef2s0AmyXqCIcwnqGbHhX+XfqQJ2OK4To5LyxEyJkH1nDWrvDPBNo7f/SSCVtmNM0/dQhaJgoUJFJhMpTumzHPTrfzEHv2OgPUbMPpRWOPjHHQB9GRrKcPmVDYeIn2PrxXuak1wH1Ys3SPCxQ2m+cFLBw2sLXSV9LNnBvL55K06U0wfa0Km+Ef3xoESN7I1g1HAoTAtFDLZr03V/BiDxWHU7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JURavbIX4YLsMMz/ba99Qxz72cRax1ysR2m/VTYKLk=;
 b=htlaNnVbJVSaCmwTSjkQ6ltn8E528QQdWR2mM5ko3x51/hFZb8ctlLutJcX7PK/D3gAozvUXPZ4qSIlnX7eMl0rkHy1knQy9eTCtrdGtfQC0VDoLnjMmcjq8pPaq95C6H1n2RmH338Hfia8IRqwONF/TVbW3U4SaATNNAd5KyyI=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by MW6PR12MB8662.namprd12.prod.outlook.com (2603:10b6:303:243::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 15:36:15 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 15:36:15 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 10/35] x86/bugs: Restructure gds mitigation
Thread-Topic: [PATCH v3 10/35] x86/bugs: Restructure gds mitigation
Thread-Index: AQHbfBbmugT1ZdFfDUe0wp2agygcN7NDz3OQ
Date: Wed, 12 Feb 2025 15:36:15 +0000
Message-ID:
 <LV3PR12MB9265D6AC9934414447D5186994FC2@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20250108202515.385902-1-david.kaplan@amd.com>
 <20250108202515.385902-11-david.kaplan@amd.com>
 <20250210235254.s66vwnh5fvxhvjej@jpoimboe>
In-Reply-To: <20250210235254.s66vwnh5fvxhvjej@jpoimboe>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ca4ca567-3ab8-4029-964a-b6c3388fe397;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-12T15:35:59Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|MW6PR12MB8662:EE_
x-ms-office365-filtering-correlation-id: e2eff7a7-6472-411e-36cd-08dd4b7afcd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TVFVL05kM0ZUTjBDOE9CdFJhRmRWc1FON1FWWW1nbm9GNGFQN0crN1kwMzYr?=
 =?utf-8?B?ZjhDWExPTDRHaWQ3c1huTkhMNmhSOUJEUnhha3dNWTJFK3ppUW9tQUt2QVk5?=
 =?utf-8?B?N3NwbFpEbG04RVR5YlRVVG4wQlZVbk1WYVhYckYrVEJmRjVCKzQ4ZEFXTXBK?=
 =?utf-8?B?MUZXZit4ZWdkVDdHRUNuNVYvQjd5dzZxMS92cmVXVWJCVzd4MkMyZHFZNDNo?=
 =?utf-8?B?OGYyNlB6NHFDTys4dnBqNUc3ZktqWlFpbzJ2UmtkY0dJemFjRGxpK01sTmhh?=
 =?utf-8?B?SzZRMTZsalRYY0pCYXJjSzJNNEFwb2RGY3d6YTh3QTIzNTRwRnB4NHh6VXVj?=
 =?utf-8?B?S0V0VU9pVi9PbW5hTEt0TGNVZnh1Z0pnWlNSUFdpRXQ5RmJnWXBhQUhJMWNI?=
 =?utf-8?B?NUQzNER1NUw4aktPRncyMXhMck9pRlMwbExtSHBITlJYbkhlUzdHSjcvMHdH?=
 =?utf-8?B?bGFUVEdSbThlR2p0dkZwK05QQ3QxUEUwOTlNY3pBN0ZRNEZwVFptRHNObCtO?=
 =?utf-8?B?Ylk3Nk5nT1UwOTJWWkQwOVNmSytibFZiU0prQ1VRWlVPdjJmaEh1TEhmUzB4?=
 =?utf-8?B?N1hiRVBoL2tHYjRFTmxMNG1ubmk3c2kxR2o0S2wzRDExamxxYUIvd1FaMkY0?=
 =?utf-8?B?UlNzUVBSTlB2WUswMWJ0cXMzZi9CalZTVmdncXdVTyt6MlEvdktUeVBvRXl5?=
 =?utf-8?B?V1BQTklXZ1haaGc5TTQ5OFZPOVpyUWpsWFJSeXd2Q2dSUmpYTnhGZ0pNUnFt?=
 =?utf-8?B?cWZ5MUcwV0NlaFl1bUZrcUxMNG1RcmtMT2VrcUlld3l6L1U4d1c2dlRyTnFJ?=
 =?utf-8?B?OGdxTGhDN1FaeFgvTGNDcFFPdHI2dmpVc3U2eGRROStZWFpNRTVPRnNwWnIy?=
 =?utf-8?B?RDJ2QUQ1U0NzZ0JYc1hMbEZvZFJYYzFIaFdSL1BseDVUSTJEVUE3M2Raa0ph?=
 =?utf-8?B?VGRyL0dsb0hZN2NibFEyTlE3R2Vmcnk3SktLRSt2NmlZb3J1ckxISHExOVJ6?=
 =?utf-8?B?Y1htZklQdjhsZlBjVU50aUJvZmNBNVhHbUMrQWFQQW1XY0F0a21YYjc5eHZR?=
 =?utf-8?B?elVYUkM0b0tSdWRWOFM2bXZBdE42RUNyRkNyQ3RaUmdTUWY0NUs4dmRQVEQv?=
 =?utf-8?B?dUJwZUtaZmUwVnc4ZTNDdXNINDFqUnNURk9ocmNmTVlOMFFRRktlbmNFaVVa?=
 =?utf-8?B?TWR3N3dYSFNCVHRFbGg5cXJFUU9pY2lNRVcxVTEydHUyLzhVZlg5OXR0elRn?=
 =?utf-8?B?ajBycitQcW1HNWtFSlhOMFMxQ1MxWVFILzdsRlVZSFlNUEJ3MDNyZFppbWV3?=
 =?utf-8?B?TmZMbE0vU252RjB2ckdYK1NKa0FBditnZDBBRE5WUDlxYnJvZitZM2tDcUUz?=
 =?utf-8?B?bm8rNEtLanRET3JSQTF0K0ZNUVdrcEprTWFjQ05SSkoyTVI4TG9PK1RQSU51?=
 =?utf-8?B?UWxIMkVac280NlQvQWcwMWxWdk5XVmRIMXdBMkZZSjRnckRrN2p4L0RTdzVs?=
 =?utf-8?B?RWtsZ0NMeFlQWVIwZHgzKzBDNGN0VldqR0tVdHZ6Y3lielF6R0N2MlZCZXFW?=
 =?utf-8?B?S3lGZDNlMTcyVnozeTBHMTM5TTk3aEw0V0tWVHBiVXFaYmpUNktHWXYxOWJl?=
 =?utf-8?B?QUlpY3J2d0lUZ2I5elFoZjhUcHpPMnJkYStlaXNzZjhlUDkxUnFtRHVHNnF6?=
 =?utf-8?B?d09KZU5KUmw3c01UR2dhMWczZnU4NEQ1NTN5dElvWFl0d0RSZWZPcFVYNDR4?=
 =?utf-8?B?M1VOK1VEK3gwRUZEWmQ2U25rTzlldlZlbUJJRzFBQU9Ld214TWo3U2orL0t0?=
 =?utf-8?B?SWo5YStSd2t1SWhuakZSb1UrSUd5Qkhkay9QWXhRWjMrZis0Wi9PNmpQS2ov?=
 =?utf-8?B?RDhORjJ2c2xaZFlNcGlIUW5iNFN4N0VDb29pRVJWL09VVzRFc3NtL2grMysx?=
 =?utf-8?Q?8H9PCTwiRwKIwlY0+NvD/OD8kiiWA/KW?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K1dwRmdSZXZ6bFBZclNkWWpWT1RpNDNlV1dpRjRsNWdoY1NML3ljY0lZeFVW?=
 =?utf-8?B?RzgxYlZ0QlkybVRYM2lOaVBEVlJlaGxNRUMzT0l4V0lBREJjcUFlUzdDZlVk?=
 =?utf-8?B?U29PTjk2MGxHUi9XYnEvMmV0ZHNwWE45QjBudDV0UFZ6Vkk3OUVTekIxSUxV?=
 =?utf-8?B?Z09WSFVSL1RZYTFtZk0yT0RrT1Z4bW9BTEEvTEo3ZTRuZ2JNcmxtZmdvMk9O?=
 =?utf-8?B?amFoaDN1UzhFVUlFWmdCTTFlYXMydXlqSVVvMmNWcGlwOVBCc1Z0aXFoUzl3?=
 =?utf-8?B?WHc5NWdtYmkyMzdIUG84Q2tHQXZNMm9IWWJPQm1QdVZTQ1BRSkpvMWFmZlNL?=
 =?utf-8?B?S25mcWp4S2EvaEYxM29LWU5VdTdrLzRDVXNwZnI3M2wwK2tXNXFHWi9CeUpk?=
 =?utf-8?B?WHlFZUxmTDhHemRkbElLWVF6ZHFScmd5Vk8wS0NNVWpOeWFybmRDcVhNRXRt?=
 =?utf-8?B?Nk50cU9aUXY3cmpGbzhhblp4c3VuTFJodmNOcHlzVmpJMkdBRG1VSzl5eDJz?=
 =?utf-8?B?dkFNZllTRlc5Y0Q2REFCaVZyNGxDTTVVd0pIVXJINGxPNCt2TCt2Y1J2bmhs?=
 =?utf-8?B?QkIwUWVqVGhIN3hHVjlVaWFSYmlLRXNNWkQ0R0V2Y3VRaEdCNFhMTTZVNWxS?=
 =?utf-8?B?TjRJZS9jK1JqVlRhUklUOVFNb0E4bm53MzhtQWVYWUdIZS8zTzI2enRuVTZz?=
 =?utf-8?B?Ylk0Nk95UktWcHU3SDkwRGhLL1VmL2ljbU1UYWFjcW8rNnFoMzh0T1UwTmRw?=
 =?utf-8?B?Mkp5LzBoS1ZhejFGU215LytOS1prZ08yb1pRMXlHMnlsem9IZzM4akRoclFN?=
 =?utf-8?B?THVKS3VERTdicitjaytRWG0wcTU3bXJyTlpLdXBoVjhMQ3piTnhvNFVVajlB?=
 =?utf-8?B?d2FtM2NIVmdoUzdsZWMxbUN1dUJwWk1wUzM0N2NLbHFjK2VqZWFaNDVMbG9u?=
 =?utf-8?B?SXI0N0ZFQkViaHpDeG5UdiszWjZoM0M0cnJUVVd4L0lsWTZCajBsanY3UHUz?=
 =?utf-8?B?VFdwKysxQ3p0WTF1Rm93eVQ4SFpVUXhjc1loM0xXSTVPV3oydUpKQjJZTXpO?=
 =?utf-8?B?NlJFQTV2RkROZUNIdWx5T3g4S2NpdHVhRWVVTGw3S2RhR3BYVHBhN0dvY1RD?=
 =?utf-8?B?VW9wcVNGSTVneEZ0cURFcC93M01nSWc5WjR0WGhZQ0JkY0ZMemI5RE5ZelNM?=
 =?utf-8?B?MmFxMzJRaE01Z0xsQytOZUVNMFlRcUZ5Tk1KNVg5SzBpT2dyS2hKaDZtbGNn?=
 =?utf-8?B?bVg0WkgySkdqbXlsTWpvUXZaVlcvWUIra1pEbkQyY2xWTXlmN3g5YkRlUlhL?=
 =?utf-8?B?TWNHWm1WWE9OVjVnSGFqNE5oZ0pIK0F6YVAyWHdpMUExL1pDZUtsK0JITHg0?=
 =?utf-8?B?MVVtbHBheE9UTHlwc2cvQkp6L203RiszWXAybVBjMVRBbjlSWDNkTDdmQUZE?=
 =?utf-8?B?WjIvaVhzL2RRZXR6RGhqcVVFYkdTam5qdUxGcElXTVdBYzhJNVh0SEhFZnM4?=
 =?utf-8?B?UkR0cVlwSEhsWVlvYnBUV3QrbWRQejJ4azF0ZlRsQy85RFpMTlluMEZteEkx?=
 =?utf-8?B?UkcxbmwwbkdoZnlNRC9HZC9GVENrWUpWMHJwTCt6ZWFxZVVUdjZWeHpxdDZv?=
 =?utf-8?B?QlhyeHlPMlJjNm5qRUR1UTBOTkRTbUhIbnpTOXdxR3dHRjNZejc3cUU3Y3hk?=
 =?utf-8?B?dUpFdjRYUVlxTWtpNEI1dHRzNnhZN3BGVXJ0bnRTRUkvQUJvWVJCcUFiRUsr?=
 =?utf-8?B?N3Qrc3RFWlluTjF5bVdJMnhpZTQ2Q213eWhEcXFZcXNFQjJhNWtodHByNEVO?=
 =?utf-8?B?S1FLZ2pTNkk3R3JJL21aeU5RWmVZR1B3OCtoTStjV2o5UlBaOVhNeVJnK2Jt?=
 =?utf-8?B?RjRkY0Y3OXZHbDM1eHluTDdTVFBMWlhVYjFPSmlZS1pmS0poVjMyYlBBTDB5?=
 =?utf-8?B?eDgwL2V4N3dyUTJnY2MxdFl2amFsZHhKRjdpa0JWYmRkVi82dUhHaGJRdFdZ?=
 =?utf-8?B?N2FRZUV5YlVPckFEdkliWm9Cc2dtUm5yLzJuUjVuYnZ4ZlVabWJDTU1xTHN2?=
 =?utf-8?B?SjFpWWUwSm56UkduNTdnSkl0a0tBL202aHRBTFI3NTZkOG54V3pia1gzZDdS?=
 =?utf-8?Q?g4xg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e2eff7a7-6472-411e-36cd-08dd4b7afcd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 15:36:15.6175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6PoKEGQ5jPZYAkd+B7uof3bf0/Re3TOlttNGEOy71MOTDtNddpVVMYtlJttSZcTi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8662

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb3NoIFBvaW1ib2V1ZiA8
anBvaW1ib2VAa2VybmVsLm9yZz4NCj4gU2VudDogTW9uZGF5LCBGZWJydWFyeSAxMCwgMjAyNSA1
OjUzIFBNDQo+IFRvOiBLYXBsYW4sIERhdmlkIDxEYXZpZC5LYXBsYW5AYW1kLmNvbT4NCj4gQ2M6
IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPjsgQm9yaXNsYXYgUGV0a292IDxi
cEBhbGllbjguZGU+OyBQZXRlcg0KPiBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBQ
YXdhbiBHdXB0YQ0KPiA8cGF3YW4ua3VtYXIuZ3VwdGFAbGludXguaW50ZWwuY29tPjsgSW5nbyBN
b2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+OyBEYXZlDQo+IEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGlu
dXguaW50ZWwuY29tPjsgeDg2QGtlcm5lbC5vcmc7IEggLiBQZXRlciBBbnZpbg0KPiA8aHBhQHp5
dG9yLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MyAxMC8zNV0geDg2L2J1Z3M6IFJlc3RydWN0dXJlIGdkcyBtaXRpZ2F0aW9uDQo+DQo+
IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNl
LiBVc2UgcHJvcGVyIGNhdXRpb24NCj4gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2lu
ZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4NCj4NCj4gT24gV2VkLCBKYW4gMDgsIDIwMjUgYXQg
MDI6MjQ6NTBQTSAtMDYwMCwgRGF2aWQgS2FwbGFuIHdyb3RlOg0KPiA+IEBAIC05MDIsNyArOTA5
LDcgQEAgc3RhdGljIHZvaWQgX19pbml0IGdkc19zZWxlY3RfbWl0aWdhdGlvbih2b2lkKQ0KPiA+
ICAgICAgICAgICAgICAgfSBlbHNlIHsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgZ2RzX21p
dGlnYXRpb24gPSBHRFNfTUlUSUdBVElPTl9VQ09ERV9ORUVERUQ7DQo+ID4gICAgICAgICAgICAg
ICB9DQo+ID4gLSAgICAgICAgICAgICBnb3RvIG91dDsNCj4gPiArICAgICAgICAgICAgIHJldHVy
bjsNCj4NCj4gU28gcmlnaHQgYWJvdmUgdGhpcyBpdCBjbGVhcnMgWDg2X0ZFQVRVUkVfQVZYLCBz
aG91bGQgdGhhdCBub3QgYmUgZGVmZXJyZWQgdW50aWwNCj4gZ2RzX2FwcGx5X21pdGlnYXRpb24o
KT8NCg0KWWVzLCB3aWxsIG1vdmUgaXQuDQoNCi0tRGF2aWQgS2FwbGFuDQo=

