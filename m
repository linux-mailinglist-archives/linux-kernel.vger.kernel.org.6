Return-Path: <linux-kernel+bounces-407965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D869C780A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6991F1F25108
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E988216132E;
	Wed, 13 Nov 2024 16:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mZcmNK/3"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DC613AA4E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 16:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731513609; cv=fail; b=NzV/fLz9RueEEwATjM2d6iDdVXblySHv4M45Ul3hm2LF90fLP1XU2YFyDIX1DRb+p2Rz5QZoj7GyTxHx6WCO7KOZIttuAVI+O0br7PbFzPvAU9t7ks4VAW6m840RGZEZqlWcunIU2kUk//ZvN4QZKaHLzoHyRbdvSHDNNbI87KI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731513609; c=relaxed/simple;
	bh=Xkmgw9fYDPJCzr/qkQsJ1ZeQmS0WHizA8mBPJ056NrQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FoWWCJjNp54/LBCsKPFJQyWJeXGgggQ6dRtQUFA5vXW7jEN7+aYkAKqleIj3iUrFOoOl889utHAF+sctBuallE1+nIddy0/Fgy+p58JokkP7HfPeDJmdDwGUbxhWoIQ6XmFKFNy1UfyrG+NgX13YBGR8+KMzh6ocxIeIkYT1G4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mZcmNK/3; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJVzTY9c4OM/uoupR3cHznbNkhTCp24k5+//Lz4Xwq/R4H+xcsOYn+zotvxAKL5HKIt07hT35BaVw+IF0GeyEFV23ePbErk3zKRba4+hAfH4l4t8h6aglxaCG5ujMO47JRU0/xWfGZeC8ai/uN1rANdQ86cBOlQsyUcXVJE/3pkgdsWgBEUAo0X3nXhLzzJ+3jg0Cds8MSweTx8VpZPeMvAX/Z954B5r1UOJkJIySqTEUk2fAX2lYS/j4gcdT8Of4DgVRlRb8T771G3m5IlLFNu2Vc5Uq6/FHVspujuCZfhDhjSJlkEcBjaBdJMQ5kb2U+cQCe/OIV8LrZVfqU93lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xkmgw9fYDPJCzr/qkQsJ1ZeQmS0WHizA8mBPJ056NrQ=;
 b=cG6TXGcplcrw805O3KTQIhnQxAy3KrWzqb2PtPfU/N7H0CB6qgDe1qrNqFffDovekLpkr9/c8W4SyK+zDL0lO77U1AxhOUlSytp8AfAs5/pNx7E7zdxnV333+Hejx1f7pEU6WmEzjjsuyQcHd2yIJmg2557Ybq4tGjYMEnHh4y3rmrjVlnMRTaLqOER9UuvsM3P18JnvCL1ju/VKIsOOObmmUHgxf5UI+2t1qqbiXRG+lciGPuJmhmsB81ddaz/aLi/CFLOexVVVemlcKabbwBFVVDCNYmQw6pwK088ygCDxGmUiLZF5Gl3mmo5kDE+Tpk2JhRG9xPGz9AyK2/9G8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xkmgw9fYDPJCzr/qkQsJ1ZeQmS0WHizA8mBPJ056NrQ=;
 b=mZcmNK/3722i6dizfNkWqLSaGBLoHdrGfHHG+fJ7UcKASIdGqPmP3bhMLgn4EMWTc3HPKvZHy5pJuxWTzg0/E6KCgKwolG7cuwi75yhGAGHqG/ynMTwUeaImsHvu/MqFnsuk9j9XPaJCGfyJuCylE/FJeGyBl4a5eCY8pH+rNfw=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 16:00:02 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%6]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 16:00:02 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Brendan Jackman <jackmanb@google.com>
CC: "Manwaring, Derek" <derekmn@amazon.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "pawan.kumar.gupta@linux.intel.com"
	<pawan.kumar.gupta@linux.intel.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"x86@kernel.org" <x86@kernel.org>, "mlipp@amazon.at" <mlipp@amazon.at>,
	"canellac@amazon.at" <canellac@amazon.at>
Subject: RE: [PATCH v2 19/35] Documentation/x86: Document the new attack
 vector controls
Thread-Topic: [PATCH v2 19/35] Documentation/x86: Document the new attack
 vector controls
Thread-Index:
 AQHbMDg1JLBBlMsMQUStBRLaO7h7dbKqT+jQgApQQICAAKyDAIAACV4ggAAL0gCAAAL+UA==
Date: Wed, 13 Nov 2024 16:00:02 +0000
Message-ID:
 <LV3PR12MB92653337C2377D640BF81F84945A2@LV3PR12MB9265.namprd12.prod.outlook.com>
References:
 <LV3PR12MB92658EA6CCF18F90DAAA168394532@LV3PR12MB9265.namprd12.prod.outlook.com>
 <f3ddabdc-39fa-45fa-97fd-d8508c2229c9@amazon.com>
 <CA+i-1C1zN_GcLagTRgfJqT6uFoZaMZj1NUfxkvP7eG=VGQ0GGQ@mail.gmail.com>
 <LV3PR12MB926503BA63C616562E508D8C945A2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <CA+i-1C2JXYUBnE7fn6df0=KR4KeD0VgwO5Cc2xRhO8rBqC_p+Q@mail.gmail.com>
In-Reply-To:
 <CA+i-1C2JXYUBnE7fn6df0=KR4KeD0VgwO5Cc2xRhO8rBqC_p+Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d56291da-733e-45fa-a737-18bdeb93cbfa;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-13T15:42:28Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|PH8PR12MB6914:EE_
x-ms-office365-filtering-correlation-id: 20adad8b-78ad-432e-44cb-08dd03fc3bb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cStLMmF6REdjbmRQWmlIQk5pNjRSUXV3Sy9PREdyQjdxOGsvdHBLeEtaN0RC?=
 =?utf-8?B?RnJ6V3Z2bWRwUmpTTi9pTS9zZFNVR0N3OE5tWlBiMlcvSkIzNnhXK3RKYzdu?=
 =?utf-8?B?TStLakZMKzNoUEZWMEtLaHhyV29hOGpzMi9nZjkxV1RoZXJnWjcvVFlWU1RH?=
 =?utf-8?B?UVVTUk5EV0RxdGZCK0NYZmo0M1NrS3FwNDV1YVlkS1BUbFpOMWdLbzVyY3ZF?=
 =?utf-8?B?S3dzdk80SnJ5YW9lbXBvR2dUQlR2d21uU1l6VG90R01GNU40WnFvVzNuUm10?=
 =?utf-8?B?VFlRdWlvVGpYR3hOV2JvMk9UamNVRVlHOWczWjlsbXk2MHJWWnBIbVN6Q1Zi?=
 =?utf-8?B?SjdkR09vYU15SjJ0ekNsRjR3RDJPVWUxVkU0eFNjWjdtZFMzb1JySmdNV2tB?=
 =?utf-8?B?MGpLSlM1WjZqNlFaRWNuSlU1QXAvd1dDNnprNjhCNzkvRG5zbkRLb2s5N0Qv?=
 =?utf-8?B?WngxUTZaOSthVnBzVUVYakNYY0t0Z2EwY09nblk0VHNnb1M1TDl0VFBwejUv?=
 =?utf-8?B?c2FNaVNWQTFVMU13R3owcDViY3dDak9xcUlxMFB5bG1jMEpDMWxLWndQSzdh?=
 =?utf-8?B?STl5Z2xVekEwQ3BBN2dHL3FpZ2lYVnpaTXVrMmREWVFRZ1U3T1pXUVJadThY?=
 =?utf-8?B?cDFZaHZrenhlTEgycGRlWXlqcGdQeWRpbmdCN0tpall4MFFER1g2NHV1Vm9R?=
 =?utf-8?B?RTc2OHIzVkEyb3FKczNVaFlNK25GSnhkaGhqR0NNUGVQNENTWHBnVU5oeGNJ?=
 =?utf-8?B?UXJ3MHAxSWFVRWpHeWM2WGUwL2FRWTJWVVRPU2NVbnZuUlRoNFFBanpIV3Q2?=
 =?utf-8?B?eCtzcy9kdnoxc2JValJ0cjRnNzZJSGhXanBMVE5RbEp6bE5QT1E5SXgrdW9I?=
 =?utf-8?B?OGc2NW5UaGVuUnI1OUFJdG1Jb2NGbDc0L2VuOUlFak9iNXFTMWFrbmpIL0Vm?=
 =?utf-8?B?bkxEdjA1YTcxS2tYeUltRUJwOUNYaXZISE4rM2pWNTRKd09oYW44OTVRWFRH?=
 =?utf-8?B?RmZidHhBNUtUa0R5N3orVlEzaWJIZkkzWUJXSXpYWnQ4NHM1cG1aWm1BQWFm?=
 =?utf-8?B?OGlBT090QnE2WFl5UkZITHBMdmt3dEtLM2RGT1BCL3BnL0VtcVZGeGRVM1pn?=
 =?utf-8?B?SERncHVTL25xY0Qwd1VHN1VqUlNpK3ZWQWRDOXJsekRaZWVROCtienFMTmZ2?=
 =?utf-8?B?dlk4Wk9PbmUxWER2eXp6Q3J4TExlSDljeFBZTjFkbDBCYUFnNmM4YmtoQmxk?=
 =?utf-8?B?dnNJMlJwYVFWcFRBeWpLeVhpUlhVN1Z3VVBMU3dkQjc2SEhOVGRMYW1Delcz?=
 =?utf-8?B?VFN0d0xOSFRkazBSOFJCb2ZVUjVXMFc1Q0JFTWFweVBHeSs0bmZZVzlIZnlS?=
 =?utf-8?B?blgwUmwraVBHYVZZOWdqSURMMHA5R0RsS1pMc2s3bUtXUDhMS0Q3aU9KT0kr?=
 =?utf-8?B?SXJ6Ums3Z3lHSjlCems3Y1QvV0ovVDg0b2l3NmFZVnFSQnkxZE4rZFZzUEZl?=
 =?utf-8?B?akpuNzRGL3VhNW0zdCtrN2FhRmlMUnl5UjV1U3U1aXlJRlVEY3NwSzAwem1Q?=
 =?utf-8?B?NlhRamNjZStmSkk5bkVPY0t1Yk1iME5YTTBoc3JPNllIazNaZVFsNmppOFhx?=
 =?utf-8?B?Qm5mZzZjcGVPNEdIaW1BVHBGbmNvMFZkMGVvZzlpUW1CQkFaM2dFUXRwcThU?=
 =?utf-8?B?NXA4N0dnSHF3MDNWU1JvdGlEZ0NVT2lud2srMVZEZ1M0R01JVjFxdzFpY0I3?=
 =?utf-8?B?cGxZM0hqMUgxdFhYMGpVWVNtaHEvTVE0bHcyZmlLVHM1OThiK0JJVkY1V05F?=
 =?utf-8?Q?Mof/Arj/PRGHsfc16IrlIZhkD8zV13lNH4nq8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M1pWZENFN0hkWnlLcTJSbk1UakRTTFRZY21DRllqS3BXV0NnVkVuMTFGK2ht?=
 =?utf-8?B?QkZ5TUJWUXdrcEFZZERKRHpNc1MrNDAvL2tVRVkwMGZDN01JZzRwR1lxbVA3?=
 =?utf-8?B?WEcxUzhVRlg4SUQvN0F2bUlIZmZERGxXMitMQ3JySTM1elplbVJwUy8wbHJK?=
 =?utf-8?B?eTdlZTV0UDNLOUhMNmdqdTQvRHNIYXBXR0RLaTNhTTE2Z3RibG8yR2FQbVlT?=
 =?utf-8?B?bkZDQ0dBMHBVWTlrU0IrRDlxb0tZaUtCditVQnJLYkF1R3NGcDZScUR0UXFC?=
 =?utf-8?B?bmc3N0lVZ2pOcDVDRWFSYkhCZ2Y1ODRublVab1J1NVljT0NLSysyeS8rZWti?=
 =?utf-8?B?Z2liTWJsY2VPbksydTI5OHVTK3ZCQ052NW1wOGRpQUlZNlA1b0xXeWpxMHEr?=
 =?utf-8?B?U2xXOTNCdzIwRFZYZkEzdS9wK0NXOG1pY2dyaXFVaVRHT0dHUW5MTXEzSkhU?=
 =?utf-8?B?U1pTM1pWNmRUVzQ2SzFQSW9sRlAybEdtTFhMelM4RzkxYlh1Y2d3U1RJYU5M?=
 =?utf-8?B?VGd4UGdCSzdGRXVsYUJlR2lnQVRUM2RmbGRaVDJvM28xTzBLMngvdFRMTUlQ?=
 =?utf-8?B?K2x3OXJPUktlZ3c2bVhWb2szblI5Rm4xTWs2Rnh5NHo2b21jd0ZydGk2bzIy?=
 =?utf-8?B?MG5uV05MTlVzc3RuWDZ1d2twVHJRV2hEY2t6UFpqOGdZMlBiVnBQbWJmT0Nn?=
 =?utf-8?B?T3ZVUkhuL1RQRzNFcitMTmJtK2MvT2ZUOWpLWGxXUzlTSGFTQ1ZpVGFvQXhq?=
 =?utf-8?B?cWlaM1MrQ0I3WlBuREk0eDVGcEVEc0RuMVJnUUFhL3JoS0wxSHUvZnBwWlIz?=
 =?utf-8?B?eTJkK1J5VVdjSHVBTXVxMVBxRktUblJqeWtYTzNFZHpyWUFpMGFJMHYyOHp2?=
 =?utf-8?B?dzB5MmVoaHdDb3gwdyt5S2lISnUzcXZmWDhKRFVpUEk3OC9LWERGTlQ0dmlj?=
 =?utf-8?B?ellNMGs4T1d2SXhqNmlVRUVqeEJCaFg3SjVLZTlvMERrMWw2LzE1SSt0b0Q1?=
 =?utf-8?B?QTdqV3FFcVgwNXV0QUo1ZWxoMnBudGUwQlRyUklvRi83dzV6WHU3VGlGV05y?=
 =?utf-8?B?OTlSUVBWbis5SFFKOUFaekZTRjJqYkFiNVRsK29wRy80bHQxNDBoKzczaXh5?=
 =?utf-8?B?K3J4b2NUZ1JNWU9jNW5jY3FIU29HbWgxZzVxWmN1a2EzTUE1ZGJQSzAyY1dF?=
 =?utf-8?B?b0tBVGpFUWFjTklrUzRqbzd1cU5PcWNZMzJWYjkrY3oxd3ZoVSs2NExpMVlo?=
 =?utf-8?B?ay9wUUc3aTJTOE4wak5zbDR4Y05CR0xjdEdGWDcvSXhTcFVYSC9KaFN3SW5i?=
 =?utf-8?B?elkzYlY5RGlQR2pFQzZEc1lNenBXWWhtNUswZDFmTG9xcmN2TjdvSUw0ME9t?=
 =?utf-8?B?L3VhTWdJbTVwcnRiYkxDVThkRlcyZU5JdzdyemgwUVVNUlhQb3lJZDl1MU9M?=
 =?utf-8?B?eHdkOTZyRGRMWXJtb1hHWDNhcW1jQldNVTlUMWdiKzFaY0dUYnE5Wk55V1Vp?=
 =?utf-8?B?cDAzRXJkeS83b25Nem9FbDQ3R3Faa1A3cHE3aTM2Y3FvVktEc0M4R0VCNFl4?=
 =?utf-8?B?SWJFbWt2Uy9HckZRdGxHTlF4Z3Z6MzhTMk9xbkpWN1FheEcyQ0ZtTjJ4elBq?=
 =?utf-8?B?WEQzNXM1OFdjWEhJMDY3YllPODBMN0xOV1ZqRFZUb0YwYXlzY3hPYTE0dERF?=
 =?utf-8?B?ZUpFRWxLNlM2M00yVUI5ZmJEZlp0NEx6VmNGNDFkbVY2MWFtWVhxamJib0ds?=
 =?utf-8?B?NWdkSVhqZ1R3U3c2NW9MaFMyL3BEQjlrRFdjSjhDQjBKU1h2MFZmcnlHQWc1?=
 =?utf-8?B?Z0xFeUltcGdnTzk5SFZhZnR2NjVaSmk3UW5nd3g5SzBQa1Y1MWZ2WjJmMUNX?=
 =?utf-8?B?YVczOElJbGs0VWYrYUFxL1lVcHBhaENIK3BSZnFQT0N1Y3NEVmQ2THBpZ200?=
 =?utf-8?B?YmV1ZHFRTkZZMHZLTDdCeHY2UGFYcnlINVRETHdSQjhVYVB4WGNxaHdxa0Jz?=
 =?utf-8?B?Nm5FcG51L1RFNnRQdU9MMjVFWmI4ODhYa3JuYkZrRjlSSDlvTVE2WjlmVkQ4?=
 =?utf-8?B?Y1N2WHpnekhMclBKUlNBd2xzU0VZR01tVzFZdHo0aDhGNGI5VzBHY3RiQzRG?=
 =?utf-8?Q?/SwI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 20adad8b-78ad-432e-44cb-08dd03fc3bb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 16:00:02.4925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ir3aGOYDYeeGWTnVMK8EwJZTFy9Aa/lDh8ncXTfguPFRYr7LQ4p8unLOiw4vxhHR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6914

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCcmVuZGFuIEphY2ttYW4g
PGphY2ttYW5iQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMTMsIDIw
MjQgOTozMiBBTQ0KPiBUbzogS2FwbGFuLCBEYXZpZCA8RGF2aWQuS2FwbGFuQGFtZC5jb20+DQo+
IENjOiBNYW53YXJpbmcsIERlcmVrIDxkZXJla21uQGFtYXpvbi5jb20+OyBicEBhbGllbjguZGU7
DQo+IGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbTsgaHBhQHp5dG9yLmNvbTsganBvaW1ib2VA
a2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG1pbmdvQHJlZGhh
dC5jb207IHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbTsNCj4gcGV0ZXJ6QGluZnJh
ZGVhZC5vcmc7IHRnbHhAbGludXRyb25peC5kZTsgeDg2QGtlcm5lbC5vcmc7IG1saXBwQGFtYXpv
bi5hdDsNCj4gY2FuZWxsYWNAYW1hem9uLmF0DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMTkv
MzVdIERvY3VtZW50YXRpb24veDg2OiBEb2N1bWVudCB0aGUgbmV3IGF0dGFjaw0KPiB2ZWN0b3Ig
Y29udHJvbHMNCj4NCj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBF
eHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5pbmcgYXR0YWNo
bWVudHMsIGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBPbiBXZWQsIDEz
IE5vdiAyMDI0IGF0IDE2OjA1LCBLYXBsYW4sIERhdmlkIDxEYXZpZC5LYXBsYW5AYW1kLmNvbT4g
d3JvdGU6DQo+ID4NCj4gPiBJIGRvbid0IHNlZSBob3cgQVNJIGNhbiBldmVyIGJlIGEgdXNlcl91
c2VyIG1pdGlnYXRpb24uICBVc2VyX3VzZXIgYXR0YWNrcyBhcmUNCj4gdGhpbmdzIGxpa2UgaW5m
bHVlbmNpbmcgdGhlIGluZGlyZWN0IHByZWRpY3Rpb25zIHVzZWQgYnkgYW5vdGhlciBwcm9jZXNz
LCBjYXVzaW5nIHRoYXQNCj4gcHJvY2VzcyB0byBsZWFrIGRhdGEgZnJvbSBpdHMgYWRkcmVzcyBz
cGFjZS4gIFVzZXJfdXNlciBtaXRpZ2F0aW9ucyBhcmUgdGhpbmdzIGxpa2UNCj4gZG9pbmcgYW4g
SUJQQiB3aGVuIHN3aXRjaGluZyB0YXNrcy4NCj4NCj4gV2VsbCwgaW4gdGhlIFJGQyBJJ20gY3Vy
cmVudGx5IChwYWluZnVsbHkgc2xvd2x5LCBzb3JyeSBhZ2Fpbikgd29ya2luZyBvbiwgdGhhdCBJ
QlBCIGlzDQo+IHByb3ZpZGVkIGJ5IEFTSS4gRWFjaCBwcm9jZXNzIGhhcyBhbiBBU0kgZG9tYWlu
LCBBU0kgZW5zdXJlcyB0aGVyZSdzIGFuIElCUEINCj4gYmVmb3JlIHdlIHRyYW5zaXRpb24gaW50
byBhbnkgb3RoZXIgZG9tYWluIHRoYXQgZG9lc24ndCB0cnVzdCBpdCAoVk1zIHRydXN0IHRoZWly
IFZNTSwNCj4gYnV0IGFsbCBvdGhlciB0cmFuc2l0aW9ucyBvdXQgb2YgdGhlIHVzZXJwYWNlIGRv
bWFpbiB3aWxsIGZsdXNoKS4NCj4NCj4gSW4gcHJhY3RpY2UsIHRoaXMgaXMganVzdCBwcm92aWRl
ZCBieSB0aGUgZmFjdCB0aGF0IGNvbnRleHQgc3dpdGNoaW5nIGN1cnJlbnRseSBpbmN1cnMgYW4N
Cj4gYXNpX2V4aXQoKSwgYnV0IHRoYXQncyBhbiBpbXBsZW1lbnRhdGlvbiBkZXRhaWwsIGlmIHdl
IHRyYW5zaXRpb25lZCBkaXJlY3RseSBmcm9tIG9uZQ0KPiBwcm9jZXNzJyBkb21haW4gdG8gYW5v
dGhlciB0aGF0IHdvdWxkIGFsc28gY3JlYXRlIGEgZmx1c2guDQo+DQo+IChCdXQgeWVzLCBtYXli
ZSB0aGF0IGJlaW5nICJwYXJ0IG9mIEFTSSIgaXMganVzdCBteSB2ZXJ5IEFTSS1jZW50cmljIHBl
cnNwZWN0aXZlKS4NCg0KQWggeWVzLCB0aGlzIG1ha2VzIHNlbnNlLiAgQXMgeW91IHNhaWQgdGhv
dWdoLCB0aGlzIGlzIGR1ZSB0byB0aGUgZmFjdCB0aGF0IGNvbnRleHQgc3dpdGNoIGluY3VycyBh
biBhc2lfZXhpdC4gIEFzIGEgdGhvdWdodCBleGVyY2lzZSwgSSB3b25kZXIgd2hhdCB3b3VsZCBo
YXBwZW4gaWYgdGhlcmUgd2FzIGEgbWl0aWdhdGlvbiB0aGF0IHdhcyByZXF1aXJlZCB3aGVuIHN3
aXRjaGluZyB0byBhbm90aGVyIGd1ZXN0LCBidXQgbm90IHRvIHRoZSBicm9hZGVyIGhvc3QgYWRk
cmVzcyBzcGFjZS4gIEkgdGhpbmsgdGhhdCB3b3VsZCBtZWFuIHRoZXJlIHdvdWxkIHN0aWxsIGJl
IGEgbmVlZCBmb3IgZXh0cmEgZmx1c2hlcyB3aGVuIHN3aXRjaGluZyBndWVzdC0+Z3Vlc3QgdGhh
dCBtYXkgbm90IGJlIGNvdmVyZWQgYnkgYXNpX2V4aXQuICAoVGhhdCdzIHRoZW9yZXRpY2FsIHRo
b3VnaCBidXQgY291bGQgYmUgYSByZWFzb24gbm90IHRvIHRpZSB0aGVzZSB0b2dldGhlciBmb3Jl
dmVyKQ0KDQpBbmQgeWVzLCBwbGVhc2UgZG8ga2VlcCB1cCB0aGUgQVNJIHdvcmssIEknbSB2ZXJ5
IG11Y2ggbG9va2luZyBmb3J3YXJkIHRvIGl0LCBpdCBzaG91bGQgYmUgYSBiaWcgaW1wcm92ZW1l
bnQuDQoNCi0tRGF2aWQgS2FwbGFuDQo=

