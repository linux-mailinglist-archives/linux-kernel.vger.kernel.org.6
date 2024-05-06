Return-Path: <linux-kernel+bounces-170324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C6A8BD52E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 21:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 195B2280D78
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C6B158DDA;
	Mon,  6 May 2024 19:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="myOF2MKf"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D36A4AECA;
	Mon,  6 May 2024 19:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715022589; cv=fail; b=kvVXPtX8m5wI5X3UR9ZEP2ofYN9dcBadTc9yvnNu2ZzuLegGzbli9+QPthjw7QjUHnql6+qA5NxKuAb4m0zSqby4wHdu2ixi1HA6DCLdxU2mEfEXYNM3CrRPTatm9CLvza8CX+rqm/ZhY56mLhvmKVNSjukjcB55gTlwbPZNGJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715022589; c=relaxed/simple;
	bh=XD5ocvELCx/RlxYRhRLZx3pzTjdHHzUXupDAKUjISg8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AlHOYDpYpLpsf8u68Me+73135BYTd00bzwdBx8fvL3yWOMH3r1hV6aBc70viW/FU7rvUfZuhbSxwX6dBnDDvIMq1FaZOR3bvzo1a951o1KLZfyOMN1hzjrf13DxqGUYB8U9T4YtKrbujofExQR/uitGf0//mvXgJ9ZglIWY0oLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=myOF2MKf; arc=fail smtp.client-ip=40.107.243.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KnjFNeV0vjl82xNXUL1bFNqMVHqfn0ZJfrMaXKoiPm9LxdjJf+ibO1iFtJFkAHtb8A/HbcCoP38zyysWM4txWVg0Hs6nmqrVdK+BO7xEyAqmwEM863KmbCf7itZKHRSN9JflNP2NRz9GKEYrf2pmEcdWLs1Iub3ctes2yBuT/bRhM1f9k9YfGgpO/G9AoAoZbABOkZRwgpDwsa5Phk+E0DuFabqw/Q3hGw/5fyBPp6B1j2ZkKCum9J7Z1LLzG3NQhrtwHs5w6UhTAqEUFlz4oFV/HwPVhFzAWBYJgRlfQ9pWc/+nVuaP6eXNpTN8xWC5+SGFgOIVThpkVzQGvRCz0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFVcikOYIpb75opAWJW+qSQGk/YXp2AVAPBYETmYC5Y=;
 b=TZeM0xl7nL32zQUAANGX4F7Qua+WNjYOkYMRz7RCcLQDa/NBNdztvv5UdGRTntKKXzSFQ0cQzsxOuSs3LfJ27V5YE4+qKFhiy6ozPmJfv8VUpv9kMy6dgxTxwYlG7LqD2KiKYRRQ2InmQ2NyXfezwP7kWLqx2/cXa432DguqZJoST4ZBrffSk+j00vNH2HR7Pb5h0lgJErD6PgPy6vZgpMURuQyhOgscuFniwIQO+uWtbBOWPxW8QrrziYHR9r8kGiRJG7Uz+CDkFzJmLjXuLSHfOgzestcDastXLIrC88fbfCJ6nhOucM8HKj06gjWZTDIcqIISzoSuGzIr50W6fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFVcikOYIpb75opAWJW+qSQGk/YXp2AVAPBYETmYC5Y=;
 b=myOF2MKfJxWTHwTM74QK2CcGTN3u9ZftfLUuQkGBxMVbT4nPEV01UVQ/ebmNSUHcdBK6ZYDaoDk6VSvZd6fp+OUDtSdcOhvX+7fVafh09jJymmI8+y2m9PWk+FY+qcALmgE2mbExnAmMjRUVz9N9R8KM5AdgAZ+QJgbcMGWxWT4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB8428.namprd12.prod.outlook.com (2603:10b6:510:243::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Mon, 6 May
 2024 19:09:42 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 19:09:42 +0000
Message-ID: <80b33bc6-7b70-4853-92a0-718c2d8728d3@amd.com>
Date: Mon, 6 May 2024 14:09:38 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH v3 03/17] x86/resctrl: Detect Assignable Bandwidth
 Monitoring feature details
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1711674410.git.babu.moger@amd.com>
 <63134ddf18208bbd11bcec0ec75c33ef6e5635b2.1711674410.git.babu.moger@amd.com>
 <ac22b96d-c4bb-42d9-bac8-22b9e032b59e@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ac22b96d-c4bb-42d9-bac8-22b9e032b59e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0021.namprd11.prod.outlook.com
 (2603:10b6:806:6e::26) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a3595e5-aec9-4d17-5d47-08dc6e00159d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnIvQ2xOUHRzU1FhUHJhVEhIdDl3Nytzb3NlRm91WjFLUWE1T3gxQUFDTXMw?=
 =?utf-8?B?Rm1lckx0V2dJeGF3amF5T3BWdS90OGl0MkxiWjBKWjB5QVUxZ1pUS2h0UlJq?=
 =?utf-8?B?Y0V3Rm9DVWtSRm90ZGJCMGllY1E2ZFBwbVpkVS82aGFldXgySmhOYi9rRXRU?=
 =?utf-8?B?ZDk5RnhkbWZjalVSaGtnMnBpUHBiVFVWeFlVdG9sRE5VTkFQRzJhSWV4aVlF?=
 =?utf-8?B?RVFxb1Y2b1l0MmRsYXovNlpsajA2elFmRENVRnN2ZW1HOVY0TUJMUmJJWUxh?=
 =?utf-8?B?WGR4a3k2cElnTXdWTklpa0tTZHErbHl4VjlGNEw1TFQrTGI3bm9QemFsSnlD?=
 =?utf-8?B?QnEzT1lqK1oyeGFjbngzUUp6YlUzUlpqcnBoL01xSUI3OWlDK2ROVlY5ZnJH?=
 =?utf-8?B?b2lHQmZVa1Jackp5bnpEdTBIaUU0Rkl2cU82UGRpemxud2tjdkEvR2pFb2VW?=
 =?utf-8?B?SUFTUXM4aWtsdDVoN202TTBxMEFSTFBVd3JEZlZkamVyU1BReUZ1Y2RkQTJQ?=
 =?utf-8?B?d0hGNkNHRy83VFNZbFRIemFEblAzbmVWQUtoRG9Oc0E1eUN0LzZLVlN3Nk9F?=
 =?utf-8?B?QUpDbkdSdTF6ci94VyswUGlnQzdDbCs2VnFnV1BZeG1NWENSSEpteUczMDFR?=
 =?utf-8?B?WXVYdkZLZ1dMUVhHK3NtRk5pVndRbG5sVkFOa0pjWEoxSHNmTmwvbER4S1RN?=
 =?utf-8?B?WEh5RE9VQms4a1dkbGM1L3o1TUROUHpWNW51cmdmU0d4RDI3V3MwaWtLZ1d3?=
 =?utf-8?B?RHY4NUZmdTVGalZUSWNOVWtZa2JrTHZJaS9qWTZoZ0M3eXY4ZHJic2tvQmJ3?=
 =?utf-8?B?TmY1UHBMY0dVRUYxMjRHQ1B4WnB0amIrS3BBNnhOaDZtclVobVVZYkpuTkth?=
 =?utf-8?B?UFVHcHo1OG80bFdQaXJsclNJKzZia2JidVZSeWErRmlVZ1BvZXZRMkUxemRC?=
 =?utf-8?B?ZmdhM2Z5bW9YYUM1MkVpKzNtUDEyb3VnUUxoYkZxN0lOSXN2L2txSzJuZ3hI?=
 =?utf-8?B?WGt4b2FjQU1Qd0xacDE5RmhWV3BHMTBCVExYSiswTU1WcjVwSDcvR0JlaG1H?=
 =?utf-8?B?VEZWalVSeTRTUWRMaWJPMEswOXFzRjFlQWxoR3dZWFNBaXpCb2NZb3A3aU9P?=
 =?utf-8?B?TndKUlVIMXdDNWxodXo4MDZnM0JoTDJNVEZhb1k3VWcwWU95V2JjL1ZVVFla?=
 =?utf-8?B?dEJDVmhRVXpoS2FjS1EzL1ZXV2F0S3ZjV1lxY0Jodnh0QU9mdENXSFk5S1Zm?=
 =?utf-8?B?RDdlTkpwa01XN3A3RXk4ZTBIcERTcS9EdjJ5QSsrT3FmaHlOWFRTK2dtdUJu?=
 =?utf-8?B?cm1xRlc5Y0lkVkd6QTRQOWpzR3hHeEcwSkx2cm1ZODVaN0pTQ3hiSU5rUFBE?=
 =?utf-8?B?SkRxVlZlVUcxMXV6N3RWMXhoWDVWeVdsQU5wOGtkUG5DTllnbStmaEljM2Rv?=
 =?utf-8?B?bC90aU45aVljS2EyNVhjWi8xQ2QzNEVXcGpjK3RVRStwdGZ0NVI0RThkM1Iz?=
 =?utf-8?B?M3FTYXl1bTJ6WEFrYzllME9uZVBJT1BuY0ovWWNFN0N1TXE4UFVlSGNyREc4?=
 =?utf-8?B?ZFZBNXpWZlQwNXM5ZmNmRGdvRElVcFM0NVorQmlxNXhabVZHbU5zRU4vZ011?=
 =?utf-8?Q?WD2gl2jKN5W0S6rLei/sSK0sXc9C1ipQ0Xk3cWlx8eEQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkpqQm5xQi9pclJwVkdYeWtmQkhheUhLa3dSZXFNNURnbGs1eUQzVWFOcnRq?=
 =?utf-8?B?Qnh1UlZsN3FhMkdnS1FVUXZrRTYxWWJIS2x5aTNKUFlmMFRXTkJsU3ptSExZ?=
 =?utf-8?B?cjlZaUNPbGY3WVk2c0ttaUJ1OVBrakVZVFRkRmNmWUxsZFJXaHZLVWhrRkpZ?=
 =?utf-8?B?MDFEZU9VMXQ4aW5Vdkd3SGdTZFVNcUFVT0pEMnJiSGgrVWtlU0dCeGdPTkNW?=
 =?utf-8?B?MDRmYlhHNE5mQVZsQlpzdEV4WUd0dStyWjNJcnFsdi9CT0lWQmxhUWpxR1Uw?=
 =?utf-8?B?MXJiMWZlSjFJUTR1UXBLeDcrak5wRHlBNFRJZ0Uxa1ZRNzQvSnhwYXpwbmNC?=
 =?utf-8?B?YnRmWFEvRUNPRHpxc2gyZUpsNmFlRXJkRmxmUWJ6YjI5WVZaNVdEYWxFVDBu?=
 =?utf-8?B?UDBXTlpWL01pMFBhWUhleGg5M3RuSXV5MkRscXBrblhtMll1UWNiazRmK1B3?=
 =?utf-8?B?WDRUL0lGc1dtMk84c3NFMVREaWhPRFhLN05sMzQ1TW1TMXpBMkpFSWoxUEhG?=
 =?utf-8?B?Y1hqcHNKSmZJUXAyc05GejJxKzRXSFlSbUp5RjJjS3QvTnFMeEprQ1ZlOEFX?=
 =?utf-8?B?TktGN0NVc3FldUV1S2tSclZFdHFXUTY2eWxRN1MyS25JZ1V6Vm9lWU90ejdN?=
 =?utf-8?B?K0E5bkNnVGFRMjRJRHBWNDZ5ZTJoUjhFcnJZZW51dW8wL3J1bWZSaHJaOWN5?=
 =?utf-8?B?Z3dYa2dQNmpZbVVrdW5kcGtvYi9oL1BGbjRpcVFlZDV4UGRZVnRvYWNDVGhB?=
 =?utf-8?B?dUo1YXNrS09IVkNOb3d3blRSbWpLMXB5NGpnWkp5ZW0rTDZYcmJVZFBuKzFj?=
 =?utf-8?B?YkF2b2NzbmIvNkN6WThtaU5FVFh4Ry91UE5UUkU4UUQrREFLNU94aUE5NFVH?=
 =?utf-8?B?MjFiYi8zVTl1eVlCNUZQRkJpekFnWjVVQWhzSkhJS2hsZUoyNDRWajhNK253?=
 =?utf-8?B?bW5aQkRIT2JITitXa2d0MTc3NnkvR3dxWm1pSzZsSkFuZnVZTkZYSFhXNnhS?=
 =?utf-8?B?TDRtZDJ5N1Ywc0RoSzNoKzViM3dOL3Vjb3p3d3pyeDFiZ2dtR0NWN0YyMHF1?=
 =?utf-8?B?bWplNE9vRS9yb0kwSG56d3NDVWJ5TFNlL3BOZFE0MGNXUHdRaEhTSnBWeUZk?=
 =?utf-8?B?ZnpmN1hwcHlCcUdYZ215cHlGZUxsc0FwQ0NONk1CdEM3dStqRnZ2bDN1YUZQ?=
 =?utf-8?B?bmNWY3ZZZVp6aHo0Sy9vTTRZTE11UERDSXlRRElzdEpwbFR2Q0xraEltNi9t?=
 =?utf-8?B?bnRXTmlldEIwRlA5ZjVkdkdZekVzSXFIVStLaGkyaGZRWDZLZHp4NUJ5Tlkx?=
 =?utf-8?B?N0RvTHZBcUcwOFUwYklqVS9ERFloRUM3bHB6OXhOMnEzaDAvenA1U2FMazZh?=
 =?utf-8?B?WkZHVzNKeEc1aG1VNUVUMVlqV0ZYWDdQN2dvUGM5YisrbTJlMFpRMlpsV2NS?=
 =?utf-8?B?WUhKcm9yS3R6VGc0VHdZb3lXV0Q1UGVvK3lSWTFGbFRldzhGbTVGYmZFR0pQ?=
 =?utf-8?B?SHhHUG52YUFlV0Z3T0Y0d1B1ODIvYmliNnlmRml2MmtrM2xIWGZ6VDgzYW1h?=
 =?utf-8?B?QStwSVNXRVRBRW9UVUh0ZXZaTHlOeFVjRUl6SDN3Vnd3OGZUZVNYLzlvY1E1?=
 =?utf-8?B?S3MrV1Z4SkVicjFEQkNlZExML3lpQit5VWRpcFB4Uy9GdXh0T3MxdGlMczJP?=
 =?utf-8?B?Y0ZGV2N2eTlIRkZCZjRWZTlFMGlKdENpYXVBcGlNRm5UK3h5bkxRb2FQUDA0?=
 =?utf-8?B?UkpJSFk5cUNHeWxZM3E4UjJ1bXJmeXhTdFhKYm5USWhja2F4TGp4bjdUby82?=
 =?utf-8?B?T2IydjEyekFUNEJTenp1L0gwQWEvMFlYWlk3S08rbEx1ZTM3QUExR0RzMGtS?=
 =?utf-8?B?c3JYSTRkUXZSRy84Yk9oTWd2WkU1RVVGL2p0NWVQOC9KUWZnWStlaUN6THBL?=
 =?utf-8?B?SlN6RVptUHYrbm9LNmNUS3FkamZrQkpEOTcySjJkNjVzZW55aEtyRWo2ZTJH?=
 =?utf-8?B?REg0RlhLU3RBRE1vaWVDdTdISFBZUnA1WXNPTSs5RktiRzNZc0o2blNMQ0xl?=
 =?utf-8?B?aFA2dWJWdWN6cmpSZGFIdmFVVjVGbXAwWDVCU1FFS1BlT05rR3V0VCsrK3Az?=
 =?utf-8?Q?Akjw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3595e5-aec9-4d17-5d47-08dc6e00159d
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 19:09:42.2674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dnkd9+EbqWE1hDHyATm5ovPwcDz1p5jFM6Y/h5bAOM9dacD5IUQwFDqEru9/9eiT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8428

Hi Reinette,

On 5/3/24 18:26, Reinette Chatre wrote:
> Hi Babu,
> 
> On 3/28/2024 6:06 PM, Babu Moger wrote:
>> ABMC feature details are reported via CPUID Fn8000_0020_EBX_x5.
>> Bits Description
>> 15:0 MAX_ABMC Maximum Supported Assignable Bandwidth
>>      Monitoring Counter ID + 1
>>
>> The feature details are documented in APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>> Monitoring (ABMC).
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> ---
>> v3: Removed changes related to mon_features.
>>     Moved rdt_cpu_has to core.c and added new function resctrl_arch_has_abmc.
>>     Also moved the fields mbm_assign_capable and mbm_assign_cntrs to
>>     rdt_resource. (James)
>>
>> v2: Changed the field name to mbm_assign_capable from abmc_capable.
>> ---
>>  arch/x86/kernel/cpu/resctrl/core.c     | 17 +++++++++++++++++
>>  arch/x86/kernel/cpu/resctrl/internal.h |  1 +
>>  arch/x86/kernel/cpu/resctrl/monitor.c  |  3 +++
>>  include/linux/resctrl.h                | 12 ++++++++++++
>>  4 files changed, 33 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index 57a8c6f30dd6..bb82b392cf5d 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -740,6 +740,23 @@ bool __init rdt_cpu_has(int flag)
>>  	return ret;
>>  }
>>  
>> +inline bool __init resctrl_arch_has_abmc(struct rdt_resource *r)
>> +{
>> +	bool ret = rdt_cpu_has(X86_FEATURE_ABMC);
>> +	u32 eax, ebx, ecx, edx;
>> +
>> +	if (ret) {
>> +		/*
>> +		 * Query CPUID_Fn80000020_EBX_x05 for number of
>> +		 * ABMC counters
>> +		 */
>> +		cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
>> +		r->mbm_assign_cntrs = (ebx & 0xFFFF) + 1;
>> +	}
>> +
>> +	return ret;
>> +}
> 
> It is not clear to me why this function is needed. I went back to
> read James' comment and it sounds to me as though he expected it
> to be called from non-arch code ... but this is only called
> from rdt_get_mon_l3_config() which is very much architecture specific
> and will remain in arch/x86 where rdt_cpu_has() will be accessible.

Yes. That is correct.  I will revert it and move it to rdt_get_mon_l3_config.

> 
>> +
>>  static __init bool get_mem_config(void)
>>  {
>>  	struct rdt_hw_resource *hw_res = &rdt_resources_all[RDT_RESOURCE_MBA];
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index c99f26ebe7a6..c4ae6f3993aa 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -584,6 +584,7 @@ void free_rmid(u32 closid, u32 rmid);
>>  int rdt_get_mon_l3_config(struct rdt_resource *r);
>>  void __exit rdt_put_mon_l3_config(void);
>>  bool __init rdt_cpu_has(int flag);
>> +bool __init resctrl_arch_has_abmc(struct rdt_resource *r);
>>  void mon_event_count(void *info);
>>  int rdtgroup_mondata_show(struct seq_file *m, void *arg);
>>  void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index c34a35ec0f03..e5938bf53d5a 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -1055,6 +1055,9 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>>  			mbm_local_event.configurable = true;
>>  			mbm_config_rftype_init("mbm_local_bytes_config");
>>  		}
>> +
>> +		if (resctrl_arch_has_abmc(r))
>> +			r->mbm_assign_capable = ABMC_ASSIGN;
>>  	}
> 
> This is confusing to me in two ways:
> (a) why need different layers of abstraction to initialize r->mbm_assign_capable
>     and r->mbm_assign_cntrs? Can they not just be assigned at the same time?

Yes. we can.

> (b) r->mbm_assign_capable is a bool ... but it is assigned an enum? Why is
>     this enum needed for this?

Enum is really not required. Will correct it.

> 
>>  
>>  	l3_mon_evt_init(r);
>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index a365f67131ec..a1ee9afabff3 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -150,6 +150,14 @@ struct resctrl_membw {
>>  struct rdt_parse_data;
>>  struct resctrl_schema;
>>  
>> +/**
>> + * enum mbm_assign_type - The type of assignable monitoring.
>> + * @ABMC_ASSIGN: Assignable Bandwidth Monitoring Counters.
>> + */
>> +enum mbm_assign_type {
>> +	ABMC_ASSIGN	= 0x01,
>> +};
>> +
> 
> Either the resource is mbm_assign_capable or not ... it is not clear
> to me why an enum is needed.

This is not required.

> 
>>  /**
>>   * struct rdt_resource - attributes of a resctrl resource
>>   * @rid:		The index of the resource
>> @@ -168,6 +176,8 @@ struct resctrl_schema;
>>   * @evt_list:		List of monitoring events
>>   * @fflags:		flags to choose base and info files
>>   * @cdp_capable:	Is the CDP feature available on this resource
>> + * @mbm_assign_capable:	Does system capable of supporting monitor assignment?
> 
> "Does system capable" -> "Is system capable"?

Sure.

> 
>> + * @mbm_assign_cntrs:	Maximum number of assignable counters
>>   */
>>  struct rdt_resource {
>>  	int			rid;
>> @@ -188,6 +198,8 @@ struct rdt_resource {
>>  	struct list_head	evt_list;
>>  	unsigned long		fflags;
>>  	bool			cdp_capable;
>> +	bool			mbm_assign_capable;
>> +	u32                     mbm_assign_cntrs;
>>  };
> 
> Please check tabs vs spaces (in this whole series please).

Sure. Will do.

> 
> I'm thinking that a new "MBM specific" struct within
> struct rdt_resource will be helpful to clearly separate the MBM related
> data. This will be similar to struct resctrl_cache for 
> cache allocation and struct resctrl_membw for memory bandwidth
> allocation.

Did you mean to move all the fields for monitoring to move to new struct?

Struct resctrl_mbm {
          int                     num_rmid;
          bool                    mbm_assign_capable;
          u32                     mbm_assign_cntrs;
}:

-- 
Thanks
Babu Moger

