Return-Path: <linux-kernel+bounces-322321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B5F97274E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 04:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F16F61C22F01
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 02:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2A413B28D;
	Tue, 10 Sep 2024 02:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bsyxUM+q"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DDB4A1B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 02:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725936374; cv=fail; b=jdH+oEkdIuLHSBD0RbnxpkoYL4OUNYlmQdnUv398XZy2EihmhzVrJj3Rvqzji0iWakA5mGEDyiENYMpiFQtiPNFBHjBqdPq0PE9Mpx74Qei9zxYDmT3imEbXSflMMN0jkHFWugE2kmdt2oRXXevALaN19S8kwYuPfGypvLPZBE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725936374; c=relaxed/simple;
	bh=SNUiEd3nhiq5+wm7V2086GWI78/AoLLEw0d1+TS0BLk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nW7cvFWRNHjI4yKGuh89kCIutZ/tC/mwTAu50TTKT2lDFh6nn/iGqLMcGnQ5cj9m/75MaDPZGx4Akz425s5lFZNu/PGLTkej7QvKOcgLFqaftCcUopDscAxQoQ42pGuiLdxHLfpSJ5lzioYvNIIszz9eMHnZsCVQeBOaxs6eL48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bsyxUM+q; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oaGePeTRzA+JGITrtri+sWDaXTeBMggCWo//YgLEy55GoiY0eSN/ouDBcGwx2EqjyiZENfjz+SZsBItbMBoUS8h52QdFdvc6WYG1jG/zKiQF+LjjFcWeaebhZZjZ0ejrGoXYod++mnfuBRaDGRRqA60o2pAioEl3YANqagUgEpyK1HNDt+MI28rFax5fnVG3XSuI0EDpYe3ps2SfOdg00sYLlHEUZyQf9MRbAV7H3Vf/0TdbE3EOfOhZ4IYbThbDJgL/bUjSSMRzxFiFMr2e1xo7tPHGFinR0QuYk5VA+JhvwBurbAyVotIo4kSJPlSiUoHgCfj1ImAFKd2eF9O70w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNUiEd3nhiq5+wm7V2086GWI78/AoLLEw0d1+TS0BLk=;
 b=YGFYwJdhxZ7v4vZsZQIGlBm29X2BVnSswazxIygGLdTCZBcR97x4nHTCvrMxHlfB+of1lziC1FdT09W20e6TshTL8LAHNn8vZL19cNZFhoaEByGsL6Cuh5Zav8XgGC6oxAXkKRLlRxDh6OeYZR1+7ELvLHDhZmmFwjO+s3Ez36IgAs2DKscOaB/ZwphHcEtgxzfGnwsUcBz1RtrAA8udJySXUvxKQUA+PvXxkTh+4e8OcZz+c4cXtuNibSS8Afbg+Z8oKFovRVw4dsA743TUDR3vpWeUf6sPv5PeNR7UeoJyaOawEVE1UJANyhGV36tKpJ+EmXy4JYPzXlkg8hSEvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNUiEd3nhiq5+wm7V2086GWI78/AoLLEw0d1+TS0BLk=;
 b=bsyxUM+qsluHp8vr39mTQ6omgAX8C0Xofb5Z1ThryrWDY0IG4rrIqDZkx3r+dk4CWkIL0pHtW2emJiXnuJd05gdWKafOeyKYFWDWwbNP9XJMMuJee3vxYh+3dfVP5f9WLtFO2edHRVGqRhlrE42OTshlPG6JVnF782wrHbhWzYY=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 10 Sep
 2024 02:46:07 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%4]) with mapi id 15.20.7897.021; Tue, 10 Sep 2024
 02:46:07 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: "Huang, Kai" <kai.huang@intel.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "bp@alien8.de" <bp@alien8.de>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "peterz@infradead.org" <peterz@infradead.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"seanjc@google.com" <seanjc@google.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Yamahata, Isaku"
	<isaku.yamahata@intel.com>, "Kalra, Ashish" <Ashish.Kalra@amd.com>,
	"bhe@redhat.com" <bhe@redhat.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "sagis@google.com" <sagis@google.com>, Dave Young
	<dyoung@redhat.com>
Subject: RE: [PATCH v6 2/5] x86/kexec: do unconditional WBINVD for bare-metal
 in relocate_kernel()
Thread-Topic: [PATCH v6 2/5] x86/kexec: do unconditional WBINVD for bare-metal
 in relocate_kernel()
Thread-Index: AQHbAo9GtMXQ5J+L60GdV3fxNS9w/rJPeZbAgADXaACAAADYgA==
Date: Tue, 10 Sep 2024 02:46:07 +0000
Message-ID:
 <LV3PR12MB9265900A6564C22E9F6666ED949A2@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <cover.1725868065.git.kai.huang@intel.com>
 <79f0de36a2a4f33e6cea8f0bf6419a6dc09ba94c.1725868065.git.kai.huang@intel.com>
 <LV3PR12MB9265B4512DE5F2D580DE3CF794992@LV3PR12MB9265.namprd12.prod.outlook.com>
 <3f419ba5-7b95-45f0-adb3-d7397949c14e@intel.com>
In-Reply-To: <3f419ba5-7b95-45f0-adb3-d7397949c14e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=1d327956-8384-401e-aee8-ea6ad93dc159;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-10T02:45:20Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|CH3PR12MB8728:EE_
x-ms-office365-filtering-correlation-id: e8b3303d-fbdf-48c2-dbbb-08dcd142b8b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NjBURkNlenA2WkVNa3R5aENOaFZjNUlNNHQ3QUVma0djaitmZU9BMTdkazBh?=
 =?utf-8?B?Q1laYWZSVDBoS2tLaEV6OEEzVmg0b2FUMkI0dmFtTmZyYjB4aXhsQ05JYWUz?=
 =?utf-8?B?RnJOS2ZPNjRJbkh3YXQ1Q2ZxUFFxVVgyVUtkOGJSZFlXQ0Ntclk1RHdFTUpP?=
 =?utf-8?B?dklpVGR1WThmbWEzMmR0R0o3d2llMU03dzFuczJQblZwSFNjbSt5aEZ4NDFs?=
 =?utf-8?B?enRSMUQzcm9MNytIR2F3ei9CSnhCcjF3Si94WEFINVVyU0NqYzhPVWRhQ0F5?=
 =?utf-8?B?cmFrZnYwT3Z3QkVOZmdNSHdxUlg5V0JtOEZuNWxvODBWWnVFQTlnOGVNaUNm?=
 =?utf-8?B?bTIyTVdjQXhseDg1YUY4NFVxYjdCYTM1TmVRZFlaSk9zUFFZeXI5MDBJazAx?=
 =?utf-8?B?WUFYUytRdEZKVTkyRmtESXhSckg2UUpCOGk0VXJFVzJZdWVvV2czL3dORkZN?=
 =?utf-8?B?VllvQWpTNlFVSHZ2Zks2TWhRZUxlbldtMHpOZzh2aVVJMHdTYkVrTVdKN3Z5?=
 =?utf-8?B?eG56ZDZEK0JPeC96TytRVDdVcEx6TmJIYmtQUnJhU2JiRjI4L2pWM1dBTlFs?=
 =?utf-8?B?SWNWSFVLRHJzT1NzQks2blI1SnhHN2hZVWJUNm4veC9sUWFmSW9UOS85bjVi?=
 =?utf-8?B?WFFaampnS2ZqNmJQbEIvb1ZxK2lZMEpzU1MrdmE5emQwMUhKc0Q2enFGU0lU?=
 =?utf-8?B?aEg0a05HdC9uN1BMaVVFYlEyajVWUWxxZmo5eTJzK2dPQXNVc3hEV2FKb1Rk?=
 =?utf-8?B?K1JRVlFhMWJYRzVtQkxOaXFaYUZ3Ti90Mld3Wk5sNGIxdmp1bDZaWDRoT0dO?=
 =?utf-8?B?T2pPbDhvWkhnazZjTzY1cCtEUlZQVDVVNkloKzRiUEh6c3E3SkdxdEhtbTE2?=
 =?utf-8?B?SjJSRThwbHc2WHpoV1VCTDJ2dGJudTM0OGUrOHBPVHVMSEtDdFBKbTFRS3dB?=
 =?utf-8?B?eXNtbHBCaGF4TUI5NzJuREZiNXpWSTlCMGlMOUpkZ2c1RXg5eEhZN0lWeDgr?=
 =?utf-8?B?ei9RVThueldVanh4a3BWRUliOXN6RUc3SElFajM0QlJYVjZNa3cxNGl0allS?=
 =?utf-8?B?VTlTZmgvR3hYTXIyVHE2Vm1WbGYzUmdBdGNxYlBMYklrOWJUNlVJakUrYzBH?=
 =?utf-8?B?TWFNbEtkYitpc29wMkNyUkdPdWZxaHNET2NEWmM4aUdPUWRaclByMFhmbDFW?=
 =?utf-8?B?STYvZFZ1WFNjaUU3cHZXRy9NcXBXRzBaeHpIbHBCYVFVOFpRTFF2MzI1ZDR0?=
 =?utf-8?B?bUtSS0t1d1RDUmp4Lzlta25yMXZyc0pjZ3VWMEllem1rdFJhRUkzMG45WEha?=
 =?utf-8?B?WEwzRmFzRWdNQlorQ0xFQ0k3dmRmaVZTVnVvOTY5UmZkS09wSHB2ZTRZSmhZ?=
 =?utf-8?B?OVdYayszeE41VkVjT1phbURVemJUNDZsWXJzY1VzMHcyRmt1eHIwcXFSanRq?=
 =?utf-8?B?R2N0MnVLZUlJanVLeDJmWWs3aUswR0N4Q29MN2lreUZvMFUySG9GT040T21C?=
 =?utf-8?B?cXNjeVh0NGVobm81QUhtUWZVWXpGOU0rZlViUTY5UkZmWHBzSDBlTGVyQ3lo?=
 =?utf-8?B?MkV6RzVKQThpL0t0cTRBNVFIaGZiSVVzc2x3UWI5T0V6TGdkMDZsVTU4ZjNo?=
 =?utf-8?B?Y0xZdWprdk15UFZmTlJVMnl4T25MeGlxSDRpYnJwZTRMY1lHSjNWY255Y1o1?=
 =?utf-8?B?SjFTczByeUdXaGszT0hCbXBXdDVNVm82SFlseXZVK0NhL0V1b3NZeUpQTWZK?=
 =?utf-8?B?MGRMRU8vMjlCc3BoTUwvMzNrQ2hXTnNGZmdYa2pid2liMWlMUElSRGV1WlBT?=
 =?utf-8?B?cUhXYTZtd0ZvU3dXOUorYmx5aW1rRXI3b2xSWkpERXdNd21jYXhJVExkczJs?=
 =?utf-8?B?Wk9jbll4Z0lqeXNSdStVZlZMc2dLK1F1QnFocEYvNHQ5Rno5ZjViNGwwYS9t?=
 =?utf-8?Q?nKCOrkJC2U8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TzJQMW1ER2dYZkxCNFk0akN3cXVFZyt3VWl6eVYrQ1JSZ0Rld2I2cktQaHFO?=
 =?utf-8?B?ajBUZnVkZnJldVdsSEhGWUdadURnaWtYR0J5SmFWQkkwUXRKNUErRHI0d3lz?=
 =?utf-8?B?Q3VOQlVrZy9nbGVuZXhnZ0hyVmdKQVRMcnh2MWFwcTVBbk5oOVY5RGQvNGp0?=
 =?utf-8?B?cG0rMUREU0dSWVhpQm9UWk15ZzNvbmg5L1NqcjczY0xLam9uRWlCNEF0SytQ?=
 =?utf-8?B?MXFpcEpWOXRzR1hmZ3lTbm9RTTcwMzZoZ2RQa0JoR2NEZ1VuaGVhL1VZcGpm?=
 =?utf-8?B?bnpUSjVJZ3N5QnBWMFdaaXFXeG1CczZyMWpoeENCMFVMbmN1cHVTNTYzVlZq?=
 =?utf-8?B?U2haeHo1UGRFU09tSDZWc3p5aUI2L3JzRnNEQk1GZGtCZzluM0thb0FJWEpB?=
 =?utf-8?B?cHJvSmFvbGdxSUUyUW43Y3MvUkVoRS9TdWdSU25zRzFDOUJmVGEvcHNYRTln?=
 =?utf-8?B?QkRTYnVxZVBPYUdkQXh3Y3FHc0szbktQek1CdVNlaUNGSGJUcTJDSnJuZ0h0?=
 =?utf-8?B?czVmOHJpcVpCRjE0a1hSKzhvRHpkZGNRZ0FKMkRIcmtOTFpkV29rY3h1M01E?=
 =?utf-8?B?WjZJeHNQNTZUdHFwSjZiUTNRTFNTYTdVcU9GZkl2SEUydEN4UHNIdHBJSGhw?=
 =?utf-8?B?WEtzVE5CcERjRUZIaFFxVlQ4YUVFenN6U0pKbkIydE1SWGtBZ1lQemxUSUhG?=
 =?utf-8?B?NkhINWhMcUEzYWlyb1FzK2ZnK3p5NEw2WVdnT2puZmV6dG83c0tRUkZvWDRh?=
 =?utf-8?B?UVFlWmhzMmNmait5NWgxYUtsbGZkRmJrdmRGc1dDRGt4NjlTd29wajc4QVFa?=
 =?utf-8?B?UTlkbDdrOTcycHBidlQ3OVRMOU1KZVVuWEc5MFMyb2FMVk53TmFDSE5DYWJZ?=
 =?utf-8?B?cnJoV3V1MlZnSkdHZ3IyOTc5Z2RIanNXU0lENGxnNTA4YmZBTW1vM1lNYU1S?=
 =?utf-8?B?UHA3RGVKOHZ1dEFjTHFJUGhYdlBoZVlXVEhRRlVMU3Nxc2lIUXJSeWI4S2hK?=
 =?utf-8?B?b1F3RkJndmMydm1uY3dXMlNKaGtKaHdwYWJoODVJc1lDdUhidy9uYnByeC81?=
 =?utf-8?B?dHdZYWZBL0VaeFRNNW1XUDNVR0hMeWEzRWFna0JWMzZ2Y3hIMCtnWmE2aDRt?=
 =?utf-8?B?L2t3M1ZmcndSUEx6SnhNbHI5WFFzalFNYmpOeXFoajNMMXdVdEprRmpOcVNr?=
 =?utf-8?B?dUUzU1pKeC9sRkFiTnVNRzZySlZEampBTjVyTTNvTDlxUmFyS3VmT0hpR3JT?=
 =?utf-8?B?MG5GbndrbFVYQm1WSkVmdW1kOVBXVUEwenNZYjBKR3dQVzgzWUpSZnQ4MU5R?=
 =?utf-8?B?MVlGSms1aGpNbktxSitva0hzdnhwdE5hbXZXUVZRUGZsRU9yeVQrbEFld1JY?=
 =?utf-8?B?R1ExQ1JiY1ZDRVpDUExEYkQvZGx0MnNxWlhhWUZBUm1XNXBvS20wUm5SM0R1?=
 =?utf-8?B?VGU0WVptR0k2YmxzLzdHb2M5NCt0VTdFeitLeHhYWlZzUmVxejhDendHanhp?=
 =?utf-8?B?a1F5MlJGR25uM2NOcm5oRTVaTzlYV1RkYmtPNFkyK1A2VWVYK3ZMbXgzRTBz?=
 =?utf-8?B?S0VmdWt2OGx4RldNMXBFVG1tTmt1aE44QkxqMkpTMXltUENOTmFkbEtodFFU?=
 =?utf-8?B?VDRveUU0WHZxanArd0toVFpkMmRiRGFHVTBXRGkxYUNDSk8zRFVMdXJnMjFw?=
 =?utf-8?B?K05jT3JISnBoTHc0VkVwL05XdlROU2RrcmJGTjFET3p2Rkd2cFRNV3kwMGhl?=
 =?utf-8?B?bEJYem5oZEhxSitqOGpZNDM3QVkwWnkzK0UxR1NSMTBDVjgxQlZxc3RyY2tZ?=
 =?utf-8?B?QWFjYUlhZTNheUprempKNlJ4QlNQOE15azdCai9mK3pOdzlEamo3YkVGek1V?=
 =?utf-8?B?ak1XNEVZNXowa2NrMjUrUnJrMTVMcUFGOXR0Q1VueE1qZmpzMFlMVFYrL2hr?=
 =?utf-8?B?RnJybVVkM1NsR3FKcFU1MDE3MlhsT29iRFNVMXpPZENoc2xaMkNzZUFIY2lu?=
 =?utf-8?B?bHBDZTRVNC9va3pOVXRGT1gvWUoxR3U0ek1WVS85SkkwbHNqNUN4VFpCVUMx?=
 =?utf-8?B?d0o4Sm1oTDBGZHo4SkNJTE5NMERYQk1rV2Mwak5ad05NdG1MMFJNYysvWGoz?=
 =?utf-8?Q?QTxI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b3303d-fbdf-48c2-dbbb-08dcd142b8b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 02:46:07.6518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QxubITHu/n/wCMa//CLS8XUWzBXVrKyGKPZP9ds1i8JDrouFB087YBW+9HEpHh/y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8728

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIdWFuZywgS2FpIDxrYWku
aHVhbmdAaW50ZWwuY29tPg0KPiBTZW50OiBNb25kYXksIFNlcHRlbWJlciA5LCAyMDI0IDk6NDIg
UE0NCj4gVG86IEthcGxhbiwgRGF2aWQgPERhdmlkLkthcGxhbkBhbWQuY29tPjsgSGFuc2VuLCBE
YXZlDQo+IDxkYXZlLmhhbnNlbkBpbnRlbC5jb20+OyBicEBhbGllbjguZGU7IHRnbHhAbGludXRy
b25peC5kZTsNCj4gcGV0ZXJ6QGluZnJhZGVhZC5vcmc7IG1pbmdvQHJlZGhhdC5jb207IGhwYUB6
eXRvci5jb207DQo+IGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5jb20NCj4gQ2M6IHg4NkBr
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBwYm9uemluaUByZWRoYXQu
Y29tOw0KPiBzZWFuamNAZ29vZ2xlLmNvbTsgV2lsbGlhbXMsIERhbiBKIDxkYW4uai53aWxsaWFt
c0BpbnRlbC5jb20+OyBMZW5kYWNreSwNCj4gVGhvbWFzIDxUaG9tYXMuTGVuZGFja3lAYW1kLmNv
bT47IEVkZ2Vjb21iZSwgUmljayBQDQo+IDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT47IFlh
bWFoYXRhLCBJc2FrdQ0KPiA8aXNha3UueWFtYWhhdGFAaW50ZWwuY29tPjsgS2FscmEsIEFzaGlz
aCA8QXNoaXNoLkthbHJhQGFtZC5jb20+Ow0KPiBiaGVAcmVkaGF0LmNvbTsgbmlrLmJvcmlzb3ZA
c3VzZS5jb207IHNhZ2lzQGdvb2dsZS5jb207IERhdmUgWW91bmcNCj4gPGR5b3VuZ0ByZWRoYXQu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDIvNV0geDg2L2tleGVjOiBkbyB1bmNvbmRp
dGlvbmFsIFdCSU5WRCBmb3IgYmFyZS0NCj4gbWV0YWwgaW4gcmVsb2NhdGVfa2VybmVsKCkNCj4N
Cj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3Vy
Y2UuIFVzZSBwcm9wZXINCj4gY2F1dGlvbiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNr
aW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiA+PiAtLS0gYS9hcmNoL3g4Ni9rZXJu
ZWwvbWFjaGluZV9rZXhlY182NC5jDQo+ID4+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9tYWNoaW5l
X2tleGVjXzY0LmMNCj4gPj4gQEAgLTMyMiwxNiArMzIyLDkgQEAgdm9pZCBtYWNoaW5lX2tleGVj
X2NsZWFudXAoc3RydWN0IGtpbWFnZQ0KPiAqaW1hZ2UpDQo+ID4+IHZvaWQgbWFjaGluZV9rZXhl
YyhzdHJ1Y3Qga2ltYWdlICppbWFnZSkgIHsNCj4gPj4gICAgICAgICAgdW5zaWduZWQgbG9uZyBw
YWdlX2xpc3RbUEFHRVNfTlJdOw0KPiA+PiAtICAgICAgIHVuc2lnbmVkIGludCBob3N0X21lbV9l
bmNfYWN0aXZlOw0KPiA+PiAgICAgICAgICBpbnQgc2F2ZV9mdHJhY2VfZW5hYmxlZDsNCj4gPj4g
ICAgICAgICAgdm9pZCAqY29udHJvbF9wYWdlOw0KPiA+Pg0KPiA+PiAtICAgICAgIC8qDQo+ID4+
IC0gICAgICAgICogVGhpcyBtdXN0IGJlIGRvbmUgYmVmb3JlIGxvYWRfc2VnbWVudHMoKSBzaW5j
ZSBpZiBjYWxsIGRlcHRoDQo+IHRyYWNraW5nDQo+ID4+IC0gICAgICAgICogaXMgdXNlZCB0aGVu
IEdTIG11c3QgYmUgdmFsaWQgdG8gbWFrZSBhbnkgZnVuY3Rpb24gY2FsbHMuDQo+ID4+IC0gICAg
ICAgICovDQo+ID4+IC0gICAgICAgaG9zdF9tZW1fZW5jX2FjdGl2ZSA9DQo+ID4+IGNjX3BsYXRm
b3JtX2hhcyhDQ19BVFRSX0hPU1RfTUVNX0VOQ1JZUFQpOw0KPiA+PiAtDQo+ID4NCj4gPiBGdW5j
dGlvbmFsbHkgdGhlIHBhdGNoIGxvb2tzIGZpbmUuICBJIHdvdWxkIHN1Z2dlc3Qga2VlcGluZyBz
b21lIGZvcm0gb2YNCj4gdGhpcyBjb21tZW50IHRob3VnaCwgYmVjYXVzZSB0aGUgbGltaXRhdGlv
biBhYm91dCBub3QgYmVpbmcgYWJsZSB0byBtYWtlDQo+IGZ1bmN0aW9uIGNhbGxzIGFmdGVyIGxv
YWRfc2VnbWVudHMoKSBpcyBhcmd1YWJseSBub24tb2J2aW91cyBhbmQgdGhpcw0KPiBjb21tZW50
IHNlcnZlZCBhcyBhIHdhcm5pbmcgZm9yIGZ1dHVyZSBtb2RpZmljYXRpb25zIGluIHRoaXMgYXJl
YS4NCj4NCj4gWWVhaCB0aGlzIG1ha2VzIHNlbnNlLiAgVGhhbmtzLg0KPg0KPiBJIHRoaW5rIHdl
IGNhbiBhZGQgc29tZSB0ZXh0IHRvIHRoZSBleGlzdGluZyBjb21tZW50IG9mIGxvYWRfc2VnbWVu
dHMoKSB0bw0KPiBjYWxsIG91dCB0aGlzLiAgQWxsb3cgbWUgdG8gZGlnIGludG8gbW9yZSBhYm91
dCBjYWxsIGRlcHRoIHRyYWNraW5nIHRvDQo+IHVuZGVyc3RhbmQgaXQgYmV0dGVyIC0tIHJlbG9j
YXRlX2tlcm5lbCgpIGFmdGVyIGxvYWRfc2VnbWVudHMoKSBzZWVtcyB0byBiZSBhDQo+IHJlYWwg
ZnVuY3Rpb24gY2FsbCBhbmQgSSB3YW50IHRvIGtub3cgaG93IGRvZXMgaXQgaW50ZXJhY3Qgd2l0
aCBjYWxsIGRlcHRoDQo+IHRyYWNraW5nLg0KDQpUaGF0IG9uZSBpcyBleHBsaWNpdGx5IGlnbm9y
ZWQsIHNlZSBza2lwX2FkZHIoKSBpbiBhcmNoL3g4Ni9rZXJuZWwvY2FsbHRodW5rcy5jDQoNCi0t
RGF2aWQgS2FwbGFuDQo=

