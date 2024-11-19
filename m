Return-Path: <linux-kernel+bounces-414877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D93CB9D2E97
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66CDB1F23A49
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B4A1D0DE6;
	Tue, 19 Nov 2024 19:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="43yZ9e0r"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659A41CBA1A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 19:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732043483; cv=fail; b=qtMiY/gF/Q4QDtcwAE1QN29kwzphmAIX49FkCdSMezNg4yMPIo9/XhLO0W3/44qFPW7U+oQWbZz7kJR18ogcPmHaFSQORM3GGntFw8a1MImZQJBVvI1qV/EbLVL38CRKJOSXJFjceuVInwyaAKoQr8vHaeJmlxwuKl8ld4U7Ci4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732043483; c=relaxed/simple;
	bh=j8Z13mPVhNdaq2oIBD9I3KQaeYG497qVvwl99AdYWeY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DzM+I8BblzgfvurfTiT3caEtkLgKqR/3u+qZzq+x1pHvgbgoRN5UnpHZifO6XL/IeNomWkjI+2uhctrnrZ/i2IbKw8g5mFLdEPFtwKM+KQ2OU+8HvrW4zx4orZ8B06+bSCox1MeeA4Pr9L4XrtU8bUYWT+iJKiIE1kOJIpChsps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=43yZ9e0r; arc=fail smtp.client-ip=40.107.101.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTvhe3OT49cchPdquZhf1YxpR0J3/Mqtnx+wN3DwUNDJjg5cSSKxaIb4lgrKOJ5mRmAzH83ybyKz4jOplncvFclBCYzfRjPtE63WcdWdF3XtTIButadQ5k+0ifgOHOp9u+IC7eM0QdU803NJAUFJoMVzTFyA0xzA1Hts2B+gUPlSTNZ+ivo39PJ1v3a2Tzd3OPlk0aaOgMDyOVY1BrSBoJtUKoHMFinVuyrhlyOT/y6q95vopC2oIafDd6d9YJM2ToU1/RtUSO+z/pi3Jb35RPoP8GOy6TcRVEWEzx1N+Bogujy0GuL1Dschmqw9rSNUaV3z3GzAXyvUz4b1BvvPFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdWbgl5i6lT4RtsJ8cGln87p44BqmchYqMmqBN/kzqs=;
 b=JemP+CaC+DWweQE05jGs6bzBSfWcaZ+Ks5dahFe6CLlaIC702Fnb5lTPYnUicqS4JVIqF6FjzudboH7n6oUAHldYg4KLQxUVF8BBL0HMUHdl5Zs56aZl4jVhc5d651BXGVfDCbvsSZVNGzpg70TgF6FcYZKZq/Fhkz10QPvljxpbC0PDYpldvMUKZqGJJ20oWybMMTh+oihS8uk9tzfx66cPZ0IgxtWbM9XueoV78SW+r6M52j4IM+GWdhNPUb5Uf1ME54TBNjAlh3d2+NwwRr4fA+/aINiwaIFrMD91FcJ/KVY/j5H8d9zWm/Ty7KFXzwyZDSrWH14yTYetPdL/wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdWbgl5i6lT4RtsJ8cGln87p44BqmchYqMmqBN/kzqs=;
 b=43yZ9e0rHSfJk9NzjJsF4ZQBHRuDV9zDmZCNPYHnpzYrDaf7Y297p9s6BE6UXdqkhplCEf/ptadTCcIdXx7CxXN0xuFm8SS83bvAtW0eB2t3oxS8Unu0Xe9gXN699ca/TeM+Dgg9xEbKRifT0A+jgazT7N36dgEQYb7dH1QB7Fk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by PH7PR12MB8107.namprd12.prod.outlook.com (2603:10b6:510:2bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 19:11:18 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 19:11:18 +0000
Message-ID: <b3b0f19b-b138-b386-ece0-a1f14a1e2f66@amd.com>
Date: Tue, 19 Nov 2024 13:11:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] x86/sev: Initialize ctxt variable and zero fi
Content-Language: en-US
To: "Ragavendra B.N." <ragavendra.bn@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, ardb@kernel.org,
 tzimmermann@suse.de, bhelgaas@google.com, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <20241118225828.123945-2-ragavendra.bn@gmail.com>
 <fc2202de-595b-f561-dc59-08f32c56ff73@amd.com> <ZzzMeHFyWTVT0-cI@desktop>
 <c5292bcf-4e9b-289d-c6f4-c587a879e07e@amd.com> <ZzzUJpF5wNk0dEOe@desktop>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <ZzzUJpF5wNk0dEOe@desktop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:806:f2::23) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|PH7PR12MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: 58273319-6954-4494-ddca-08dd08cdf24b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WktwN0JZRWhDUUZNNGR6V1YwUW1rTXJ5YWIxQm1FcTRSMlFXWHU4ZEREV0hp?=
 =?utf-8?B?R0ZRWGpoUUI2VU1Td24zZXlXeG95eVhNMElZVER1NXRzaDBvQXVDQ3ppT3Jk?=
 =?utf-8?B?aGEvQUgyc2VEajRwdjVRcVZlLzBVaDBwTk9EMDZJS1hlaFR3cUhXTFpJeHdu?=
 =?utf-8?B?SUhkYTZNZ0JkNUNKVHdDbFN4Zk5ibDAvdVJ5TWZKTVpWM1BTRVNyV0YvcUcx?=
 =?utf-8?B?N2doUmZJTDZ0NGFKcTRXZlBUT1pVT20wRXpHUVBuRFZKTGZybWF4L0tOb3RU?=
 =?utf-8?B?NjFOVTU5QzkxQmlWZHBvTlczTVJTVjZlMFlLY2JlR09ZUDc2anVmcWxRYUVN?=
 =?utf-8?B?bHRjZVNpM1hmVVJCOUxkRDRVREhEK3ZXVmJlQStJUGYyM2c1QVVMTm5vZG9W?=
 =?utf-8?B?L1NNTmxBOWtkbGt5K1pYSjRIZ0pST3p6bVhTYmNlRGNBWXZVZTdEMEp6Z3BG?=
 =?utf-8?B?WkNyTnVKN2tDeFpVNE1SMllBaVEwaUsydzBEZ3NIZmY5aThvZ2ZBLytabXRh?=
 =?utf-8?B?N3QzWmVnTDdMNlRWOTRiNlNjaDdhdm5Ha1RTdkwrZFBLNkpva2JNcjg3d3Ru?=
 =?utf-8?B?MTdlZDZhOW9xS3g1Vy92RG54NVYzOVFNb1ExN3Q4MFhEZVBnU3NhR05rTzFE?=
 =?utf-8?B?K0hoUG4xeUNZNUxYdkVTb3VsL2lRSmZHVWNvdHNXNHhEbmxLUWhMTDF5eGFj?=
 =?utf-8?B?TEptVUNBTkNPSStOY3NseERRdWxaekdOemR5a0JBbFZ2aTRyU2szcnk4a00x?=
 =?utf-8?B?cTlYV2gvKzZ4bkhzdFBnSnVNT2xlME5POXQweGRzRm1NemMzUi9GZ1g2aStB?=
 =?utf-8?B?czFEcTQ2VGh1L1pEdkFNUkxjK3lUVFlkb25XcUxEdEZVYm9DeHdDamhQOXEz?=
 =?utf-8?B?SmdpZnh5eUdhS25CL1hiYUxrRUhzTWI1dEVkRmp1KzVvMnJ5TFhJcGpaZjla?=
 =?utf-8?B?aTVIaW5rRGtUbkR5YmhZRVZiSFhwMXA3RlVZaWxsYlhVY1hUeGU2dHdTbVVs?=
 =?utf-8?B?YVZhTjhZdzA0T1RUeVJSdG1rMDRXUjFIUnh4Zlc0Q1BaMnptRUxNQldoODR6?=
 =?utf-8?B?REs1UGNnbHdpNFhEZUd4S3pXQXE2THZ4N1dvUStqMnQxUjlGbnVwMmQwR0Uv?=
 =?utf-8?B?QjA3d0VpaUtSMGwxY29rdHFMYjZiTWRDRmovbUI1Mit0aGJFZ0RzNzV5UElW?=
 =?utf-8?B?OTI5b1lOeG9JeHhNVDRiZlNwSE9CWWluOWhJT2dJZzVTdE11R0JXdUszYi9m?=
 =?utf-8?B?YlF2YU5oT3FjTDF4NC81SFMrTFR5NGl2dzNjeDJ1eFcydmlzT1Brc0NPQlBw?=
 =?utf-8?B?dnBCVXZHbEE0R09HaXAyczZ0VnhjNndkVWNIbG1TZ2RTem5XRHJSa1g5SHhH?=
 =?utf-8?B?YkwreVF4Z3Q1RDFCUis2c3hvaG1zTjRScytCRHV4UjRYQm5DbTNYdHVoSnhz?=
 =?utf-8?B?SkRhWHcwcUpEeUswVlFnck8vNnJwN3dqd01teExCWlV3b3pQcHk1cG5jbnlq?=
 =?utf-8?B?RkhMdTRTdXRZNUdpQndMdEI5ZGJhR3dJMFl2bzFzTVduY2ZZdDBGQ0F4Mzlx?=
 =?utf-8?B?dEQwMXZKN040ZmJ2aXNnYUlSTC96NE82Zm1OMWVWZ3Vid3RnamQ5Z0wvUUFV?=
 =?utf-8?B?dHJDMmRVQ3dQREJWQ2tjMmY1Z1JnWFdxaytmMDYrVHhwZW9TclQrQnVCemwv?=
 =?utf-8?B?K1lCR0I0MHlUbjFINHgwOHRNdmVxbG0xRDlQcGJmeXlSeWVDYmg5VHB0OHlV?=
 =?utf-8?Q?7XX3md0MbU5xLrXHt7WhJip4+U4nEYZmygoT5vF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUQ0dWVxRkUzWTRPM2JnU3VzRHJvazVvelZVNUt4VTVpSnc5dHlaSThZVkN3?=
 =?utf-8?B?cldDdlBUOVNzMFVQNS96MzEySG1waFFBbEVwaWV4OUdpc253L3c1cVlTYWFG?=
 =?utf-8?B?L2p6UFZmbWw4ajhxZEhuN3ZXSXA1SFhmTXYvbjdVR1pLMWtmbnRHRjFCS2tB?=
 =?utf-8?B?ZlAwc1RiRXdCYU1NZTViL1pMcWFWdE5pbFRoNmNBamo2eHVrTG5tOVRQUTJP?=
 =?utf-8?B?ejVpSGQ0dzM1WmREbnhoZVRFOHZLWnpud3FjMnVPNmVSRjlkcGJmcVdCZEJM?=
 =?utf-8?B?M0NYb2s2dUJiVTMyZjlwMnJTcTVFaGU5SUhnM1R6SzBJTXY2Rk02YXFMSWhn?=
 =?utf-8?B?Z09qZzE1ZEgzUVlSNTM4ZXRCcFpzUXBncjlXZytiVVlpVEwrNHRYRHVjQS80?=
 =?utf-8?B?dlZFRFdaTnpXYkZXRzVWb1pFSno1UjdGeE5FQVhxNk9ETHJyeGNSaktueUZR?=
 =?utf-8?B?U09sLzhuenlhUjA0aXdlbjZXZjFNYXF0SldMRHYvL25SeHlxWWdZMHRWZmJB?=
 =?utf-8?B?SUwzS0VVWXVONTkrTy8rbkVGd3pvd0VoWHBQbE5GZHA5MVRuNGlUSVprTFNO?=
 =?utf-8?B?cXAxMkQrVjFCUFIwMDh2YkFDVXNURUw1RnQ1cGx2WG9wMW8zQWZUNWNuUm9i?=
 =?utf-8?B?RmplTk5CNXg4RDNpWG1sN09YYXp2MkRkTTZBN2FhaUNVRThiYXJQQUlUbnJs?=
 =?utf-8?B?VElnR1gvb3REZ2o3WitmNHdqMFp6ZHJvN0V2V0g1QTg2bVpPbnB6a3hvUXNZ?=
 =?utf-8?B?aEQvamNVTXNqaXhaQ1BaQytKRkFKNVdnbVFiTUN4dm1id0tTeHF4cEpRVUc3?=
 =?utf-8?B?MVV1MHNwM3JCeEJjTDI4Rjlzc3BIRWtQQ1JMWFRSL3Y0WW9yM1d4YnNDcHNE?=
 =?utf-8?B?cmNxQ25XTmFES1ZYT1I3NnhheXlxRUUyVVhQaVJseEhDSFdFRmJiTVkybG5m?=
 =?utf-8?B?enZTb1F6bk41WnZVMVZPKzJVbDhRTXgyUllRR3h0RkltZFZsTmV4a0V0UWxD?=
 =?utf-8?B?dGtsaWlhd29CVlBSdEpya3czdE9kQmxvcmFlb21WV00vVGlJUGF0b0F3SEIw?=
 =?utf-8?B?WG5Na2ROS0NXUjNkRWdFeFRCTDJXd3Vxa0E4VVJFVFRiWjdibFhSM0o5Lyt0?=
 =?utf-8?B?RDUwcDRyUXlWN0psZDNjYTRtNzYvdjVGRVZoelRCU2xNdUZkWm52QkFiK29Y?=
 =?utf-8?B?d3ZaTlhrM3Fyam1DVlh0SHpXZ2M4OWVyZnpkV2I4WncvL3dXbEM4aGFBR21p?=
 =?utf-8?B?Y21rZnFhT0hsT3hTTStzSEpTMm1Xb0x6c2NyRmtGT1AvZEtQa2lVSFNjWmM2?=
 =?utf-8?B?ZFJXMXI4NXJIUG9wWVE4WDgzVGdudEZrYm41YVRGdzV0WFo3cVhvaVExdllR?=
 =?utf-8?B?SWlKS2NpcjBCZkw0elhPZFdUZXZGYlEvOFArUHVnNmtPVUJBVGRObTh2dngw?=
 =?utf-8?B?b1Jid1VDWmVkMkJaUEhBeFZiUW55ZmE1SC96b0kzcjh0MFl5ZnFwcnF0MW5L?=
 =?utf-8?B?QmlwdjJNZC81VElob29EbGYzMmljNzY5eHJoT1E5T0MzVElsbDN2VEFaUFZ0?=
 =?utf-8?B?M2NyV0J1dm4wR3JxNFNQZlB0ZXJHdmFxcGdNVFlnT1VWdTNIc1FXYll5WWpS?=
 =?utf-8?B?M1pQZWNZQmdBeTVRZkZWOTg5cVJ3WjZlZTgwQ3VWRlJqV2JBUGpERitSQ0NG?=
 =?utf-8?B?UzBlei9PNERqMzRrRzRRQ3ZxMkZpelM0SHd6WGNNNUFrNnNTL1VrZUZXMGZH?=
 =?utf-8?B?WmJKajB0a1M5OXRVTTZkOTRLSnA4QWpDbWJVRVE1NmU0Ukt5QXVicjc4TS9L?=
 =?utf-8?B?N21xQ3BGejRyTGd3QXlteG5jMUQ1aktMOXZJeUpzT3UrbnUvWGtMMElDcElM?=
 =?utf-8?B?VmQ0bWJoMlhWS1pTdVN1WnVna0tuK2hncTZUZGtSZFJUOU5qbVhnRDVNOFA0?=
 =?utf-8?B?KzZmSGFqV09URjEzenA5UjZPUTZ6NCtwMG5NWjdUWWFUbGk0aXlwM0hhbWpB?=
 =?utf-8?B?VFFuVFhXU1FTTzhPbHkyVmIrMW10ZktDbEpBWE85MHZWZHNRcnp2OWh3eUtJ?=
 =?utf-8?B?RHB4R1RQVjNVLzBHL2lUTDZST2ZPU2dvc0tEQ0JzREdXL3A4dG52Ty9NRHQv?=
 =?utf-8?Q?Tf/4h88xfZfr4eAcva/ILemj+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58273319-6954-4494-ddca-08dd08cdf24b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 19:11:18.4317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3FRVQ8FX1xmyRk9VB2/h9dUvKKqHJ+cmgy9NdwohHrtOlQWjYVDy0D3Vr7m2rI8ZwmHAeCoLSmHNpvhaR84zxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8107

On 11/19/24 12:08, Ragavendra B.N. wrote:
> On Tue, Nov 19, 2024 at 11:51:27AM -0600, Tom Lendacky wrote:
>> On 11/19/24 11:35, Ragavendra B.N. wrote:
>>> On Tue, Nov 19, 2024 at 08:23:14AM -0600, Tom Lendacky wrote:
>>>> On 11/18/24 16:58, Ragavendra wrote:
>>>>> Updating the ctxt value to {} in the svsm_perform_ghcb_protocol as
>>>>> it was not initialized. Updating memory to zero for the ctxt->fi
>>>>> variable in verify_exception_info when ES_EXCEPTION is returned.
>>>>>
>>>>> Fixes: 34ff65901735 x86/sev: Use kernel provided SVSM Calling Areas
>>>>> Signed-off-by: Ragavendra Nagraj <ragavendra.bn@gmail.com>
>>>>> ---
>>>>>  arch/x86/coco/sev/shared.c | 4 +++-
>>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/x86/coco/sev/shared.c b/arch/x86/coco/sev/shared.c
>>>>> index 71de53194089..5e0f6fbf4dd2 100644
>>>>> --- a/arch/x86/coco/sev/shared.c
>>>>> +++ b/arch/x86/coco/sev/shared.c
>>>>> @@ -239,6 +239,8 @@ static enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt
>>>>>  		if ((info & SVM_EVTINJ_VALID) &&
>>>>>  		    ((v == X86_TRAP_GP) || (v == X86_TRAP_UD)) &&
>>>>>  		    ((info & SVM_EVTINJ_TYPE_MASK) == SVM_EVTINJ_TYPE_EXEPT)) {
>>>>> +			memset(&ctxt->fi, 0, sizeof(ctxt->fi));
>>>>> +
>>>>>  			ctxt->fi.vector = v;
>>>>>  
>>>>>  			if (info & SVM_EVTINJ_VALID_ERR)
>>>>> @@ -335,7 +337,7 @@ static int svsm_perform_msr_protocol(struct svsm_call *call)
>>>>>  
>>>>>  static int svsm_perform_ghcb_protocol(struct ghcb *ghcb, struct svsm_call *call)
>>>>>  {
>>>>> -	struct es_em_ctxt ctxt;
>>>>> +	struct es_em_ctxt ctxt = {};
>>>>
>>>> This isn't necessary if you are doing the memset.
>>>>
>>>> Thanks,
>>>> Tom
>>>>
>>>>>  	u8 pending = 0;
>>>>>  
>>>>>  	vc_ghcb_invalidate(ghcb);
>>>
>>> I can go ahead and undo that, I fear that Coverity can catch it. If no harm I can leave it.
>>
>> Well, can you remove the line and run Coverity and see if it still
>> thinks there's an issue?
>>
>> If it sees an issue, then it could be that Coverity can't follow the
>> flow completely in this case. Doing the memset is enough, as far as I
>> can see.
>>
>> Thanks,
>> Tom
>>
>>>
>>>
>>> --
>>> Thanks & regards,
>>> Ragavendra N
> 
> Sure Tom, I have updated the change and sent the new patch. Please let me know if everything looks fine,

So does that mean you ran it through Coverity and everything was ok?

Thanks,
Tom

> 
> 
> Regards,
> Ragavendra N

