Return-Path: <linux-kernel+bounces-254410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0641F9332ED
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9134F1F23CF8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40F51A00F7;
	Tue, 16 Jul 2024 20:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CIAPx4rN"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE75249F5;
	Tue, 16 Jul 2024 20:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721161507; cv=fail; b=S+sPPM9rF4rfNpglgV7pY2EgFgWYfZNOM2OTgQ9uURsVyyfCDWZ/IrvQXWvpMGCjJn0LpdTM1+At4weFnrp3e2LsL5zQ9mOfqh2PO1OB8iHpIr/KLd5UbCXkPeQpYU6kKJAOR3NIVWUR5eYB2d15HkEuHubY/e2xgE3aMT+0tqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721161507; c=relaxed/simple;
	bh=NBO/5rcdrD/1ftrBLtpwABqbRp+SDKQwv6RjnVZ/LEQ=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=krhoCRx7pii9N0twGSeva1q/sQzspqPloM8brT/+YITmh/9PJQTkEI9D0YAZ8eOocJ0g5iEPb+vFpzH5a9V7mvSOHgXxszGhTm1yxAzw0XwpwbXPH5mrE1TOKx3Rkl47yumDwCPGRe5CUzYoko39e10HeaGy09FkQMMdufvPpoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CIAPx4rN; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vksyzCfk9hSvfvuJz8XuevlD0A33T4A1VoGRd0tCN9oshzEEEX7NABPj8yvfoOf91S/BXSbxgTdnt70UqFhLDbbhczsbz7icKXfQW4hlAlOARuYDUm2BPA8eEt9PxZxtJcLeZwtqxP4wZbVm2idFGoMnfkvgwhhY90W69WSPt3DavfzsrxZlxeSEU59fxDYECQjshbsGl/MeRK1+i1hqdk1PmtuNa2Gh9z96h7O8KWQe9sWb25EMAAOWg0Ue7edjh+NxE5/w702Ug7/ofCE/VVJlxuR6CJztDYP6AwQdkM1q6ufMyIfKiVOMFMY8tdA09JJl015Ts9thpKY5rUlUqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guow2YY9Sp9m/qS9iKduCmEVLZ3VdpI815VvRqYZoGY=;
 b=Xo+uIGaPhXU/PuELqnybEsQMZCwro+RgiUFADWeGzcHD6WPoDSSUt7S0+qrp4ruYnfKTIosPitwDpUWMmNyjbp984NGfw/MNkHvztRvdtib/Y9u+RA+VNhPYURwdEMlIKSEFKGOXaYQYDcNaz+nEVeMixnHQBrOFL0Zl0Gd9NCJE9uf4GDkHoNDc2PeX16Wdy92zvs3CWC4pS7h2xoE46aBDeyc0gEnP6sXyhh3liKEuoBM7pG/YuxgVAMwQymCdzOIKnHbydTDRCoNtVL855GE05rJ6rI5xJgj79fZ6JgLYLoCgs+GYk9RRjyTp27fgZi5ZzLCcZ9LZtRdfNuy68w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guow2YY9Sp9m/qS9iKduCmEVLZ3VdpI815VvRqYZoGY=;
 b=CIAPx4rNnoTO2UomNdWzVy5Z58YcluMa25t6u50Kj17MPOjDdoMcb875odnzhtLhaZlHz5g9IuvbxUD77CElHScd9Py6bXxMwv1uiVCvOw4DRuzxZN9zEkQDEsK8uLQpRj5zwTWmNXq2oEHgnEMFXX6VY0VkmewLYGGPduUr9NM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA0PR12MB8375.namprd12.prod.outlook.com (2603:10b6:208:3dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Tue, 16 Jul
 2024 20:25:00 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 20:25:00 +0000
Message-ID: <18ffa140-f7f9-450c-89d9-c833ff5763cb@amd.com>
Date: Tue, 16 Jul 2024 15:24:55 -0500
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v5 12/20] x86/resctrl: Add data structures and definitions
 for ABMC assignment
Reply-To: babu.moger@amd.com
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
References: <cover.1720043311.git.babu.moger@amd.com>
 <236652202801ad8760d6828ee4d4c6f91d009884.1720043311.git.babu.moger@amd.com>
 <9d0bf9fc-f100-45f4-b266-47786f1b8aa3@intel.com>
Content-Language: en-US
In-Reply-To: <9d0bf9fc-f100-45f4-b266-47786f1b8aa3@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0052.namprd08.prod.outlook.com
 (2603:10b6:a03:117::29) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA0PR12MB8375:EE_
X-MS-Office365-Filtering-Correlation-Id: 3191e5e7-496f-474f-2fed-08dca5d55dd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWtOc2pReHpGek1GSWkyTzlFQ28yR25IbVBVZTlCak1UK3ZqUTdQQ25GVHRi?=
 =?utf-8?B?KzlxRjNSZDNNdlpYdHk2eUxMcUJlb2VCb2R2OFJmRXQ2S1QwbTZselQ1Wkpw?=
 =?utf-8?B?QVNHOURCSG5hRjA2OTYvTVRVRzlTSmRtTSt4Q2Z1dU9iYWxQQ3VNb3NYRVA1?=
 =?utf-8?B?dWNLUVpVMXBYRVV0YlZCVGJNUXZqd05IUytkdnJITklDckhBajJPWlZvYlZO?=
 =?utf-8?B?dkc4TWp2clNsVnIzd01WSEdiTTlMd0pDdm9EQ2M2eFlaWjhheHZ0TThUeTdO?=
 =?utf-8?B?bmFSUU9ra3NpL0JjQWk2UzF4QThZSXVrSFdHNmZoMW4xK3pTRloxcFhBeVFx?=
 =?utf-8?B?NUJkSFErcHNtTXgxcTRwalFpN1BLREZqR1ZIUU9BWVM2dm5NZVZ6YmdoenRq?=
 =?utf-8?B?RXQwSXpBY25yNnhXa1lVbEs3Q3g3UEp3MzdTdmZCczBpMmVkYzB1Sk5pN0p5?=
 =?utf-8?B?YnJ1TlUvYjQ4TjFRVW5WeGp0azdIK0VrOEIxZ3g4OWQxSTZ1aGNha3FMSWw5?=
 =?utf-8?B?OVZ2SCtXNDZ1cVNHQkt6RHRWL0VDcGVwS0l3RTViSWlPNHRxbDBVdCs2MVZ2?=
 =?utf-8?B?Z1FvbVBUb09rSk5HdjBnU2FJR3A1SjFWK3VUTjMrS1lqdG5JUGxZNXFZYlVF?=
 =?utf-8?B?Vm1la3ZMQnMvSlRORTRVeU5WcG9icHprRGdHVTM5bFhqREMycFpSWHhQaHNJ?=
 =?utf-8?B?MlYrR2xFZzZhV1Q3QTY4QlloM3ZnK3VrcFl2Yk5HYTBBOXAyZU0wMVYvLy9Q?=
 =?utf-8?B?QTg2OXJYZWlGS0VKOGNnOTBjK2ZBTFFrRWxxMlNUb09lR294MW9nWWRvZS9Z?=
 =?utf-8?B?TTFYdTZ0VnhwL2g0Y3ZHOXFWUXcwWGQ4S3VPd2hESWRVZmhMaENDWUdSZUVy?=
 =?utf-8?B?UGc0SGRMN0xWOVQxNmtPTVZINlNCKzNtblFGdWJ1NE9ka3FMNXFaSlR5bjN0?=
 =?utf-8?B?eVo0Sk1vNG5rVklrRDl3Z1hQR2JZMWFZc2dlb2RvdFhmMFRKSFdwbmFXdUdv?=
 =?utf-8?B?WGtPYnp1c3loa1haOGdTRlRlVW1HdDNINGw2d0FRRXJuRGJjRG9yOUwrZ0w3?=
 =?utf-8?B?WHp6WEFXVXhZRWNVcUt1OUVNM2hURW14L0FVcm1OSU04RHZOUWNuL3pPZzRP?=
 =?utf-8?B?d2ZwSzBLRU8xL2ttSk9TUmF6aDIwb1F0d0pNY01lQy9IWFY1K1RjVUF3L1pP?=
 =?utf-8?B?bTQyblN4anp1bTBVbU9ueStFWGQ4eXllQ0FmNVdHT1c1REYrU3M0WVBjQWgy?=
 =?utf-8?B?NmVVTTd1Umhpa2dlbVBDQnJkenFHMTA4eVlnK2JtU3MxRVBZZzhjZHZhUnNL?=
 =?utf-8?B?WkNIZVVNb0dnU3VJanRzbzJVNHN2ZS93K0x0ZUlDYzh4eDAyYldxVmhET09a?=
 =?utf-8?B?Z0VNc0VhVGx0cUt4S0w5RXdzWmIyYjkwS1cveSs4NEpwWDU3TXAxS2l3Vm1K?=
 =?utf-8?B?VGdMTGZXNEVubkFEUUlGQkFLNHoxWk1wRkRJSk5QUUlwYks3RndQTnl4bDc1?=
 =?utf-8?B?Q2xCSUVISkhPN0dGUCtERHNYRzAreldVVDhZOS9yL1Y3MndTVGVJc3V6NnlB?=
 =?utf-8?B?MmFlSlZLSitoOTR3aXcrSERad2hoQzNqcFJIcXBMUHpOa1Z4WTRaRzVZRWZO?=
 =?utf-8?B?UjF3TnZTYnpMa3Brc1RVVnNkSVBQZTdOVDg0VGpjYWJaTUUzRHUyVGJhM2lk?=
 =?utf-8?B?Y0VvenBCV3A0WnExYktVVXVEYi8xVVhGNUdVUlE1VTFkYkUzTi9LUERLU0s4?=
 =?utf-8?Q?PUhuMuiOcA9J3rztAE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzBjeWs2REM5ZGxkU0QzczBYQVNSTjgrV2UzUEFnWDE1QXpicW5aNmRTemVp?=
 =?utf-8?B?TytQOC80MjVDNVdxSGxDMENUS3NlQ0R2aTRPSkYyRVRreWRFVldScVpxK3VJ?=
 =?utf-8?B?NDRraFVSNzYxdmNHTjZqamNMaTJPVStRMkZDMTc1dFRiMkptQWd1Q0hzUUw0?=
 =?utf-8?B?Z0lXQmxtUnVKZXNmL1NISFJXRnp5OE5NTWQydEhJZldtc1h5QlRBR2xMZ01C?=
 =?utf-8?B?dExTZVJJbm5YOVh2OEV4UnkrMWZpbXpwVldYSGloU3NsY3VNZWo2WDhoaS9X?=
 =?utf-8?B?UEFCczFlYVNTSWdNdk5HVDhVaENQd3dyVlhwc2xHM1RUVHhDM0MxY2VVOGR0?=
 =?utf-8?B?T2tTenU4SjQ4TGhyMmgrRUJhR3psMnQrbGJXdnFpQ1pGYStyTzR1MnkrK1Ux?=
 =?utf-8?B?ZXhuVDJqcEovRHFQQmVXNWhWVjZ4enpmYkdTZUxFMTFUYVd1NlZFbjRTaTMz?=
 =?utf-8?B?N0cwWXA3RlpNcHdLa01Ka2F3aEU3amZEbWoyWFZhcUZtdE1YWW1jM0l1OHp5?=
 =?utf-8?B?TXZnbTVaaGRNYS9GaVBmS1hOQWV1WFZWdzhaV2MydWFqaHdXVzk3Sk56Vm1H?=
 =?utf-8?B?M2s5YzJNRFlwcXQrcGZsaUlxRlJESG5yc1lSQ0lmNW84Zjc0b29wb1lDRnUv?=
 =?utf-8?B?dGo3WWFFYWZIa0l6aDdBaDZtVWEybXdIS3JkUGY0MDdCVWc3dHMwdmdTODFO?=
 =?utf-8?B?NG1Hc0taN0NWbUJaMnVpNVV2REs1eHNTbCtVS0hQNC9EVVZwYytFNEhBMGda?=
 =?utf-8?B?V05Vc0lXanpveFhxSHZGUjZXMUY0bWdSWFhTOElDSDU1d3dIRnVRNVl4ckdt?=
 =?utf-8?B?R1lzL2hMeWRUaVFIOWR3eTFyRGV3WlNOd0FDY0JDSXBPVGxxZGsxRkpSRDJ2?=
 =?utf-8?B?a1VFa3ljTmFEN2dybnFUK2NETkdxbWk5OGMvc1dSSmJGalh5VXcwVmRJZkY2?=
 =?utf-8?B?c0s5SjYyelM1UWJKQXVUWDgrajZNaUQwS1BwckNoTXBIY2wycHFodkpKbHJj?=
 =?utf-8?B?YmxibWRVbDhlZGhCUjRDSU5LaHlaKzBnODBGZUhZOUNPaVBPRWtkY3ArVHpj?=
 =?utf-8?B?NEVlbnVaWU91TmhXWXllV2lSVXNiMXVUN1JOSks4WlhxTEY2aTNRSzIvMFVF?=
 =?utf-8?B?SDBkVW9PbUxseEhPci9ERVhwRWgrL0t1ZnlWMnZPT1czQ1paY3NTN0NaUFFQ?=
 =?utf-8?B?bW5mQVRnSEFGaEpzNWJpZmNseDlSQ3oxdDNnRmNjZjRCOU84azlQL0Q1VTNK?=
 =?utf-8?B?UUxXWGpXcjVlRmJTQW53TVQ3QnBkWEIzYS9uMDk4MlR2Znp6UHh6RXhld0F5?=
 =?utf-8?B?aFhMamd4SG5rdko4dlA2RmhwNUpkVTFtSE9wZ2dIV09qVnJWeGRzMjMvSWFk?=
 =?utf-8?B?d3MycXl3VzBOV3M2SlhBb1Y1ampPMGgzTFp2emN1R1ErSk1PcnJSSXMwWEhW?=
 =?utf-8?B?bG9xUEJGTU9rWk45N3I3SFZxZ0NGR1BzSEZJRnl1Z1kvNXROYWNRZXVNS2U0?=
 =?utf-8?B?OWdsOGhoajhqa0VZb1h4djZnNTI3TlBKOUdGNDJsRy9EYmg1U1MybnJreFdy?=
 =?utf-8?B?cnQ1N29aNjR2VGM4emdRblVHWDVqbGtJWllJRkZmOFlNbjI2R3pxVnVpZ0Fm?=
 =?utf-8?B?TlFwcm9Sb0xzV0ZDV1dNUGY4cW5NMjFtdjUwUUEwdW42eEpYZ0FUWXhCZm5F?=
 =?utf-8?B?NlVDNjdjdlozVU9HeEJ4UTkvOWc3VWxLQm9OWVlPY2lZemEvdkdDb3JYemJV?=
 =?utf-8?B?ZFJuanJWaVRoT2JlVXJPTnZhRFgzdmpTVHVzRm5uKzdZc0JpUzdlL3lCWmk1?=
 =?utf-8?B?SFFoOXYxTGNpV0ZIT0YydXE2aHBxNDZGa2wycTRhTkxaOW5nbXljV0QwZHZD?=
 =?utf-8?B?eFREQjZqQlA1RVBja2VSMjRUQUx3ZTc1cE5haVdKeXdYUVlXZ2xwMVM4dklm?=
 =?utf-8?B?TXpJRHJEMU5BTU4yTEdxdDFNWG1aRytNSmNWQ200V1BNWUI4NEppRHlPZWhJ?=
 =?utf-8?B?K0NqbVM2a2hJd01iVUFoT21uNm9HTnRwMjBjaEhyVHhpcnh3d3UxdnpUWWpi?=
 =?utf-8?B?cjVmNHgxUWVnbGdQQ083MElGWmZwZUE0ckw5NUJ1cWNLOWxnUC9FSGJieVk4?=
 =?utf-8?Q?xrp8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3191e5e7-496f-474f-2fed-08dca5d55dd6
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 20:25:00.2249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +vYUrvFrlskpxW8Yd7srHLIyTQc1X6K5dp4/zmAY9ECmdRzDbKyMint74YwLKB1Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8375

Hi Reinette,

On 7/12/24 17:13, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/3/24 2:48 PM, Babu Moger wrote:
>> The ABMC feature provides an option to the user to assign a hardware
>> counter to an RMID and monitor the bandwidth as long as the counter
>> is assigned. The bandwidth events will be tracked by the hardware until
>> the user changes the configuration. Each resctrl group can configure
>> maximum two counters, one for total event and one for local event.
>>
>> The counters are configured by writing to MSR L3_QOS_ABMC_CFG.
>> Configuration is done by setting the counter id, bandwidth source (RMID)
>> and bandwidth configuration supported by BMEC(Bandwidth Monitoring Event
>> Configuration). Reading L3_QOS_ABMC_DSC returns the configuration of the
>> counter id specified in L3_QOS_ABMC_CFG.
>>
>> Attempts to read or write these MSRs when ABMC is not enabled will result
>> in a #GP(0) exception.
>>
>> Introduce data structures and definitions for ABMC assignments.
>>
>> MSR L3_QOS_ABMC_CFG (0xC000_03FDh) and L3_QOS_ABMC_DSC (0xC000_03FEh)
>> details.
>> =========================================================================
>> Bits     Mnemonic    Description            Access Reset
>>                             Type   Value
>> =========================================================================
>> 63     CfgEn         Configuration Enable         R/W     0
>>
>> 62     CtrEn         Enable/disable Tracking        R/W     0
>>
>> 61:53     –         Reserved             MBZ     0
>>
>> 52:48     CtrID         Counter Identifier        R/W    0
>>
>> 47     IsCOS        BwSrc field is a CLOSID        R/W    0
>>             (not an RMID)
>>
>> 46:44     –        Reserved            MBZ    0
>>
>> 43:32    BwSrc        Bandwidth Source        R/W    0
>>             (RMID or CLOSID)
>>
>> 31:0    BwType        Bandwidth configuration        R/W    0
>>             to track for this counter
>> ==========================================================================
>>
>> The feature details are documented in the APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>> Monitoring (ABMC).
> 
> The changelog only describes the hardware interface yet the patch contains
> part hardware interface part new driver support for hardware interface.
> 

Yes. I may have to separate this.

>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> ---
>> v5: Moved assignment flags here (path 10/19 of v4).
>>      Added MON_CNTR_UNSET definition to initialize cntr_id's.
>>      More details in commit log.
>>      Renamed few fields in l3_qos_abmc_cfg for readability.
>>
>> v4: Added more descriptions.
>>      Changed the name abmc_ctr_id to ctr_id.
>>      Added L3_QOS_ABMC_DSC. Used for reading the configuration.
>>
>> v3: No changes.
>>
>> v2: No changes.
>> ---
>>   arch/x86/include/asm/msr-index.h       |  2 ++
>>   arch/x86/kernel/cpu/resctrl/internal.h | 40 ++++++++++++++++++++++++++
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 18 ++++++++++++
>>   3 files changed, 60 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/msr-index.h
>> b/arch/x86/include/asm/msr-index.h
>> index 263b2d9d00ed..5e44ff91f459 100644
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -1175,6 +1175,8 @@
>>   #define MSR_IA32_SMBA_BW_BASE        0xc0000280
>>   #define MSR_IA32_EVT_CFG_BASE        0xc0000400
>>   #define MSR_IA32_L3_QOS_EXT_CFG        0xc00003ff
>> +#define MSR_IA32_L3_QOS_ABMC_CFG    0xc00003fd
>> +#define MSR_IA32_L3_QOS_ABMC_DSC    0xc00003fe
>>     /* MSR_IA32_VMX_MISC bits */
>>   #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
>> b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 4cb1a5d014a3..6925c947682d 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -100,6 +100,18 @@ cpumask_any_housekeeping(const struct cpumask
>> *mask, int exclude_cpu)
>>   /* Setting bit 0 in L3_QOS_EXT_CFG enables the ABMC feature */
>>   #define ABMC_ENABLE            BIT(0)
>>   +/*
>> + * Assignment flags for ABMC feature
>> + */
>> +#define ASSIGN_NONE    0
>> +#define ASSIGN_TOTAL    BIT(QOS_L3_MBM_TOTAL_EVENT_ID)
>> +#define ASSIGN_LOCAL    BIT(QOS_L3_MBM_LOCAL_EVENT_ID)
> 
> These flags do not appear to be part of hardware interface and there
> is no explanation for what they mean or how they will be used. They are
> also not used in this patch. It is thus not possible to understand if
> they belong in this patch or is appropriate in this work.

ok. Will remove it from here. Will introduce later when it is used.

> 
>> +
>> +#define MON_CNTR_UNSET    U32_MAX
>> +
>> +/* Maximum assignable counters per resctrl group */
>> +#define MAX_CNTRS    2
>> +
>>   struct rdt_fs_context {
>>       struct kernfs_fs_context    kfc;
>>       bool                enable_cdpl2;
>> @@ -228,12 +240,14 @@ enum rdtgrp_mode {
>>    * @parent:            parent rdtgrp
>>    * @crdtgrp_list:        child rdtgroup node list
>>    * @rmid:            rmid for this rdtgroup
>> + * @cntr_id:            ABMC counter ids assigned to this group
> 
> struct mongroup is private to resctrl fs so it cannot contain an
> architecture specific feature. Having it contain a generic "cntr_id"
> may be ok at this point, but it should not be termed "ABMC counter".

Ok. Sure.

> 
>>    */
>>   struct mongroup {
>>       struct kernfs_node    *mon_data_kn;
>>       struct rdtgroup        *parent;
>>       struct list_head    crdtgrp_list;
>>       u32            rmid;
>> +    u32            cntr_id[MAX_CNTRS];
> 
> This is a significant addition yet is silently included as part of a patch
> that just introduces hardware interface. This is how resctrl will manage
> the hardware counters. It is significant since this is what dictates that it
> is resctrl fs that will manage the counters, which makes it important which
> interfaces are made available and from where it is called. Through
> this series I have also not come across a description of this architecture.
> With this introduction counters are maintained per monitor group, yet
> the new interface supports assigining counters per domain. There
> is no high level explanation of this architecture and the reader is forced
> to decipher it from the implementation making this work harder to review
> that necessary.
> 
> Would it be possible to present the fs and architecture code
> separately? I think doing so will make it easier to understand.

Sure. Will separate the two parts.

> 
>>   };
>>     /**
>> @@ -607,6 +621,32 @@ union cpuid_0x10_x_edx {
>>       unsigned int full;
>>   };
>>   +/*
>> + * ABMC counters can be configured by writing to L3_QOS_ABMC_CFG.
>> + * @bw_type        : Bandwidth configuration(supported by BMEC)
>> + *              to track this counter id.
> 
> Does "to track this counter id" mean "tracked by @cntr_id"?

Yea. Sure.

> 
>> + * @bw_src        : Bandwidth Source (RMID or CLOSID).
> 
> Please do not capitalize words mid sentence, like "Source"
> above, "Identifier", and "Enable" in two instances below.
> 
>> + * @reserved1        : Reserved.
>> + * @is_clos        : BwSrc field is a CLOSID (not an RMID).
> 
> Just stick to @bw_src.

Sure.

> 
>> + * @cntr_id        : Counter Identifier.
>> + * @reserved        : Reserved.
>> + * @cntr_en        : Tracking Enable bit.
> 
> Can this be more detailed about what happens when this bit is set/clear?

Sure. Will add it.
cfn_en = 1,  cntr_en= 0;
  Counter will be be configured and tracking is not enabled.

cfn_en = 1,  cntr_en= 1;
  Counter will be be configured and tracking will be enabled.


> 
>> + * @cfg_en        : Configuration Enable bit.
> 
> What is difference between "configuration enable" and "tracking enable"?
> What is relationship, if any, to @bw_type that is the bandwidth
> configuration?
> 
>> + */
>> +union l3_qos_abmc_cfg {
>> +    struct {
>> +        unsigned long    bw_type    :32,
>> +                bw_src    :12,
>> +                reserved1: 3,
>> +                is_clos    : 1,
>> +                cntr_id    : 5,
>> +                reserved : 9,
>> +                cntr_en    : 1,
>> +                cfg_en    : 1;
>> +    } split;
> 
> Please check the spacing in this data structure. Tabs are used inconsistently
> and the members are not lining up either.

Sure.

> 
>> +    unsigned long full;
>> +};
>> +
>>   void rdt_last_cmd_clear(void);
>>   void rdt_last_cmd_puts(const char *s);
>>   __printf(1, 2)
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 91c5d45ac367..d2663f1345b7 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2505,6 +2505,7 @@ static void resctrl_abmc_set_one_amd(void *arg)
>>     static int _resctrl_abmc_enable(struct rdt_resource *r, bool enable)
>>   {
>> +    struct rdtgroup *prgrp, *crgrp;
>>       struct rdt_mon_domain *d;
>>         /*
>> @@ -2513,6 +2514,17 @@ static int _resctrl_abmc_enable(struct
>> rdt_resource *r, bool enable)
>>        */
>>       mbm_cntrs_init();
>>   +    /* Reset the cntr_id's for all the monitor groups */
>> +    list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
>> +        prgrp->mon.cntr_id[0] = MON_CNTR_UNSET;
>> +        prgrp->mon.cntr_id[1] = MON_CNTR_UNSET;
>> +        list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list,
>> +                    mon.crdtgrp_list) {
>> +            crgrp->mon.cntr_id[0] = MON_CNTR_UNSET;
>> +            crgrp->mon.cntr_id[1] = MON_CNTR_UNSET;
>> +        }
>> +    }
>> +
> 
> No. The counters are in the monitor group that is a structure that is private
> to the fs. The architecture code should not be accessing it. This should
> only be
> done by fs code.

Will move this code to FS part before coming here.

> 
>>       /*
>>        * Hardware counters will reset after switching the monitor mode.
>>        * Reset the architectural state so that reading of hardware
>> @@ -3573,6 +3585,8 @@ static int mkdir_rdt_prepare_rmid_alloc(struct
>> rdtgroup *rdtgrp)
>>           return ret;
>>       }
>>       rdtgrp->mon.rmid = ret;
>> +    rdtgrp->mon.cntr_id[0] = MON_CNTR_UNSET;
>> +    rdtgrp->mon.cntr_id[1] = MON_CNTR_UNSET;
>>         ret = mkdir_mondata_all(rdtgrp->kn, rdtgrp,
>> &rdtgrp->mon.mon_data_kn);
>>       if (ret) {
>> @@ -4128,6 +4142,10 @@ static void __init rdtgroup_setup_default(void)
>>       rdtgroup_default.closid = RESCTRL_RESERVED_CLOSID;
>>       rdtgroup_default.mon.rmid = RESCTRL_RESERVED_RMID;
>>       rdtgroup_default.type = RDTCTRL_GROUP;
>> +
>> +    rdtgroup_default.mon.cntr_id[0] = MON_CNTR_UNSET;
>> +    rdtgroup_default.mon.cntr_id[1] = MON_CNTR_UNSET;
>> +
>>       INIT_LIST_HEAD(&rdtgroup_default.mon.crdtgrp_list);
>>         list_add(&rdtgroup_default.rdtgroup_list, &rdt_all_groups);
> 
> Reinette
> 

-- 
Thanks
Babu Moger

