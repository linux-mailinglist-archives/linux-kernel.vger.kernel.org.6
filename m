Return-Path: <linux-kernel+bounces-181553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C908C7D95
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 22:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2220CB21BB5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 20:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FB4157A58;
	Thu, 16 May 2024 20:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sHW/dems"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FCE147C72;
	Thu, 16 May 2024 20:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715889822; cv=fail; b=AI9PaofuQUYP12C6x+qDblqz2PUxxV0pOzmke5hfq3gf04P8x5nqKHjQFvljIralXGjrkaqjzZSH9Et1pOtTgC3uRO6RTeijPWS5Xl1SeH3JhD52vo8gKNL3cToQUx4HXVIlNh9Y0chGsjN4ZzwSEif3hFOAoEEnHDresSpFwwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715889822; c=relaxed/simple;
	bh=ts7qU6WrLTFi2vh+TmLjVFoyblVYA8cgmiou5D3Q3Jg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X0guT4t7Khmlmdc2kqbRz9QgsnRE36MVZv9EQoUb725RRK5xXH8gVDO+2P5kSnlPrhO7Y5WTv7lnkeCXPTVoT9/twAxwPApI0805u70NoGU1DO2aD/NLuOI4OvZRZj11nnLce+TtMkT8ihNw9PFv2FQ3lmopJrjYv/to5KBzGP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sHW/dems; arc=fail smtp.client-ip=40.107.93.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgOMc86Q+TbgWun2zduKALKWD8/tMCJlysXgsEjHwtp6zmQ3rhugrjCQtWdxFV2ZFs8+S6rXNb9Xv7CgY0t/xXDCT1J3ok5GshOybwdukaiKqHEIin5ofwIODKS8zuwT7+dbyb5/2R6Pg9nDm3qgE8rNPROLSnQN9U2a3uUn+N3LkpWj93lZxFcBIPm11t/Q4/XUAS1BP1RFtq79X94KZ0KEH4qFtaEZXiZ6naExDGa3cqtEXvejYs/m4l1ridt8WW04/FxqeSkGCQG4KK8L/OnmN7MGI1Yyer5nojBR7yzG888oQMT1AjVMqMMO3S1KPZfnT8we6mSq7yMD61Zu6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0zOg9/0NkMGNDsP+Oil5qlSWxIlLONXySDqh8xYxeU=;
 b=XGkQE+WmllSVrEo6xbax/47vHX47lSk+V5a1Y7ffEYIiq8Wcu7NK1TAOZlT2VQgo9IiV2q9XDm2MuxfX/TO5EtHzQhBf+nL+Tyz1F9VBYZ4wCh5XuPkJDc52evS6DrIy2TEcXkaqFe5DPOzNOMnTQiUoEZAKJoKn2cXybc6JYZ7/wauypJhD2x+lbb0Foad3ZeC4/WqGHnTBYH2AfEdJMNKFRCXZd23DMDfYX66zm/u4P5I2K90w9z72tSM7nqyLlBcyqXSWGMhKQIQWGhTPbKtnsG5AZXfEn7BlR7hBsc0eH0dUMOOpC6Zx9EWvlPtnPd8Tn01WZejQN9SKv7ijsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0zOg9/0NkMGNDsP+Oil5qlSWxIlLONXySDqh8xYxeU=;
 b=sHW/demsb0zeZtzLsxUq1AtEln+gVbuuyvZyRCTd0ljXSUeUwaMQ8powOln1J8kKsAay7u/AKgHVDGMnDCYpt9grMDmKWzqnwE9NnKVD182Reoa8HsqH2w8gKNdrE5i/ENJyYvEaBx0/FkgURQHtYJE0T9WfIILdRh+dm0vWDaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CY8PR12MB8339.namprd12.prod.outlook.com (2603:10b6:930:7e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Thu, 16 May
 2024 20:03:37 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 20:03:37 +0000
Message-ID: <95b0ee31-8746-474f-a15b-91c893fdce28@amd.com>
Date: Thu, 16 May 2024 15:03:33 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH v3 07/17] x86/resctrl: Add support to enable/disable
 ABMC feature
To: Peter Newman <peternewman@google.com>
Cc: corbet@lwn.net, fenghua.yu@intel.com, reinette.chatre@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
 james.morse@arm.com
References: <cover.1711674410.git.babu.moger@amd.com>
 <0db75c94886da62b8da498ef159d8fe27b0b3811.1711674410.git.babu.moger@amd.com>
 <CALPaoCgRtYLnzpkL6uVjb+LvBbxD8ANRuzACP1UQ=rkzk8TCqg@mail.gmail.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <CALPaoCgRtYLnzpkL6uVjb+LvBbxD8ANRuzACP1UQ=rkzk8TCqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0186.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::18) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CY8PR12MB8339:EE_
X-MS-Office365-Filtering-Correlation-Id: 73ae8c33-3713-433e-9806-08dc75e345da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1Z4ZzlVY003TWI4SFdVM2lpci9Xb3JrRWNuSDl2ZUFVUFpYQThQTTVxKzBF?=
 =?utf-8?B?bTljaTVxUGxLNTVZL1lYNDNjSS9DSURsSFFYa2RRSC9vSm1wT3Z4ZU5vdnN4?=
 =?utf-8?B?NUI1MWxoclRReFU0Q3RpdG03UlBKN2FndHF5UExMWEtuVkNTUnBkV2JWQ29Y?=
 =?utf-8?B?UTVyQ2ZsK091Q0s2eitSdDNCaDN0WSttKzM1ZFVHczNaeEJKZ1lOVkp6ZUxi?=
 =?utf-8?B?RjF2MXBIOVVsSGdlMldJOVNFSFBJZlQwQkZPWDFReDdzUG9WeUpwS1g2V3Z3?=
 =?utf-8?B?N09rR1VRbi82b1N0Wk13V0w3dGxTNi8yUU51emREV1BhY0FPTmhJMm5lc3hw?=
 =?utf-8?B?TXc5R2xDeUQzd003eGJUZXpYaFI1WDBNclpyblhPa0RiZUF0ai93emtqYU9w?=
 =?utf-8?B?bGw4aThsNjZFbk1nVXRrSmhTT3phTklBQkFXOUZGUE95S2EzT2MxdEJjM0Zy?=
 =?utf-8?B?WFR3aHd6S1ROdVp3VjVCaG5FTE93NmsvOVJ5N0VvU09WSEVFQ0ZjMm82L2g0?=
 =?utf-8?B?b3FNbWhUaG56UHdCRFh4S0lGWDNhMGJSZ25xbk9vOGhvNWZmanIxZmRXaUFS?=
 =?utf-8?B?VSsvZ1lTeEs3NUNuOStPWU5CeDhLcUpkdEdOLzZSTFF6Kyt6d1dpUHhQYzdk?=
 =?utf-8?B?SS9jc2Q5Vk14S3BHVjJ2VGdXbENib2FXalJjS2U1aFJFTm9jRG5mL2ZMOUdV?=
 =?utf-8?B?czNOSXRQbkwzdXVDREF3OHg0MDZFbVFKYzRBcFBneE1aOHlHMXE0RUJXVUVt?=
 =?utf-8?B?emViN01SR1NZSTlRN3NjSm0vWDROQ1ZtNDVIU1JRaXhUU2M4aGhWWnVpOGU1?=
 =?utf-8?B?cS9PWTVadFRTL0lZOGgwU0RjaVVybUVTVEVHemNkMHJXdFUwVjZQVTRGOGY0?=
 =?utf-8?B?T3I0UGFYZXdJRy80b2I5djQ2d3JsWHI0YVh2S0lndVZGQjZvN3djeDJNVSto?=
 =?utf-8?B?U1R1WHRIZU5BMmdYR3MzaG5CVTQ0Y214U2tsN3k5bGg2bUpJaVd1YzQ0WXpu?=
 =?utf-8?B?SUFnNGQvRi9GQ2F5OHptdGhuM1dWa1dLV1dHdC96OUtBNVNVUnpqRlFYSi9W?=
 =?utf-8?B?aHRWS25adjBPTnptNEtTMUx6VjJCWmZjUHoyNi9mbkJGTy9zK2tvMWQ2MEJx?=
 =?utf-8?B?TDhYNGJ3UlZFWWlFWDEzRVVFSUNneUtqQ0hKZVZCUWtPUExiVjJ3cXBJR1NY?=
 =?utf-8?B?a2lxbExuT2hmRG04dDJzTDJEVnJNelJYNXFxN2tZTC9FMENsTE95VzhEc2d6?=
 =?utf-8?B?blRMTUsvNHRac0NlbkI5d08yV1h6OUNWcVRhVVJGcHo5YW9WUjdBb3B6bUVF?=
 =?utf-8?B?UmJ3NkxORXFBMllsa01LTjl3ckYwb3lUMytVTGRIODZILzBaanpMaWs2TEo4?=
 =?utf-8?B?MzdRZ0FYQjlSVG5SZzR0TmEyWExtREp1WG41b1E1cUJ5N3ZGQ29MY2YzeFY0?=
 =?utf-8?B?M0hCTzJDREQybVI3OUQrUVY4cXFXbUFkZzVRS2luUWxWS3U0eTVoYS9tYkVS?=
 =?utf-8?B?YVdheHJreVg0TC9zZUlYWDVVN1NWZU9wa1JSOTM0UEdmK3VKWTZmOEFEbExV?=
 =?utf-8?B?dmVvd0tDS1l3emo3c2FrVCtmK0NWR3dLTGJvQVZ1VnViK3QrRE90eDZGTXNF?=
 =?utf-8?Q?WGZnqoMGyZtYoFpB6PvREfcVlwbxFJGAJ83j7TOdM5yg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjdYYnVjSlNkcXVwU3FPaWQ0SnpucW9jd241cE9yTkQ4d3czL2dsTy95blhn?=
 =?utf-8?B?Y3MxQ3prN3NuNjFMTU9BZDltU29WWk1wUW9iWU40ZlNYQktqTHpFcGtyRkpn?=
 =?utf-8?B?QTgwUU9QdUhKWkp4a2IvMFJlS1ZQdDlWalJYSkJoYnM5ZHVxa1BEN0N0UExm?=
 =?utf-8?B?VUE2bUYyOThGSXNTb0FFenpES2lzVG9zN3N2aXE4SGljSjdUbkFIeURyT1Bx?=
 =?utf-8?B?UmRXRDM3dnhub3ZvK3VjU1N2RTRnbXMweVdLYXVHQzFOeDFJNk5aRGg1d09q?=
 =?utf-8?B?aTYzbE5yTGNkZGRyWkVUdUsybXl4OWhYa2hDOS9ya08yTW9TOGJ6dzVRdUVI?=
 =?utf-8?B?NXFiaVdKclFrZWJwc3BocEpwZHVuaThBbWRIN29SSTJXNEhtQ2Z4Tmo2RnU4?=
 =?utf-8?B?Kzk0ZUhHeS9JeWpFeTZBY3h1TVRVYy9BM091OTFXVElOMXp1TFAvV3lJTmlm?=
 =?utf-8?B?V1V5NnU3ZnVITC9FaXBYbkhsaWU5MmFIZ2piV1Rva2MwOTdpakJDQjZ0d1Nv?=
 =?utf-8?B?VEUrYlpCd2NJUUwzMlRVenFGeUFQY0FuT3RXWVUzVkQ1Znk4eUhlbVZpeXZN?=
 =?utf-8?B?K0ZOWmlXeHgzdTFHWGhON3MwNXMzMU1mUDNkL2ZVTUhVSmVGczRJSnI3ZThy?=
 =?utf-8?B?SHRIVkFnQ1FyRWlGem0vcXVMbmJpdFg3T2htUWR4OFFOZWR6R2ZiOVV4eDdT?=
 =?utf-8?B?UmZRNXJsb2MxNkQ0clh0M0RBb01veDBXR2NaWnJkZjk3b1B6Q2RnUHlRSllh?=
 =?utf-8?B?cEJNMU02bVZxRk4zb29tU2RDRVczQlU4UmR6V2twVlltZnJWWVVMT3VZK3RC?=
 =?utf-8?B?SVlyc3RPUkZrcnlkRmN4ajlQMmtlMjYydGVXUUFVU1dORnFSaTd5QlFWNE9a?=
 =?utf-8?B?d2J5alFVZ0FwYlRYVmZ5RlFQZkR3S0JvT1VPN3lnZ1JFcVI5MkMwNHFacHM0?=
 =?utf-8?B?NFpyWk5ESEdoa3U0K1dlTytwdkVEWC92cUROMG92NlVHa2hVZ1RmWWZQQmZu?=
 =?utf-8?B?ZkxIQktnR25QZ0ZOeWxSWmkyTkQyMHFZSU55cms1aXZaL3grSzZkSWZTNEw0?=
 =?utf-8?B?MnBiS0pVeVRMckgwa3B1b29TdldtYUw0VjJ3Z0JMbU1KTnNtL2R1Rm1yU3Aw?=
 =?utf-8?B?UHc0VnJRSkpoeVRtUDFWUDJKMm8zTWNPNUxkYmxleHZTWmJHM1k3ak5wYmFR?=
 =?utf-8?B?eTliVU1jZFdkdVJFaUV6QXVWS2VSOEQ3bUhaR0dlK3lhR2lhZ3c1R0tLZGow?=
 =?utf-8?B?RUlKUjlFVmZpQUpjMTdyVjJ3ZU5pajFzOGViMEI0ZkFGZXdhVW9EWkovaTZ2?=
 =?utf-8?B?UElqUDJ4RkRGNTk1YWtwbmJlWi84dThCWm55Y2JMU3pOa3RTamZvL0pIdE9S?=
 =?utf-8?B?dmN6KzNzQk5GSnFtNWtQSFVYWkVQRk91K2FyeTRNQ215c1lmc3Bud1MreVBL?=
 =?utf-8?B?bmVoS1VCYVYyNWNSVDNZejVJVkV4emV4VjM2aFRSQjBXZmtwRjNneEc5WDV4?=
 =?utf-8?B?QksySjhxOVpNNmdFMDRhWktqQ2JvUjdDVzRKUHdqVWM5dnZzR0xITExZQk9R?=
 =?utf-8?B?d3VUMENrSGNnSmJGSjRFR3MzeXl3REF0Y3VFRzNzQUgvYWFXUTRUMnJZeS9V?=
 =?utf-8?B?SEdwWktFWUZxRlZJcVBVTjZoT3AxcFN3ZnVCSzNsczJnV3JkWi9rTS83bkFy?=
 =?utf-8?B?ZDBKaFdVV2laU29DMjBveFFmWUZ6bWVYbnVzV3hhTGc4U0kxN1lnMkJjdFpY?=
 =?utf-8?B?dUFOa1ZyZEltSk5PQkZ1eTRYNEg3RFYzamNvSG1WMjI2dFEvNG52MzB4aDRz?=
 =?utf-8?B?Vy9GdWVLM2tPRThZaWN4aUxKMDJoUGpVOUd3S1pYTlZXL0Q5OWJlWjBqdy9a?=
 =?utf-8?B?Tmp1OXNENWE5ME1TUUl0N1BXQ29Zb0tmZTdCUUNFL0V5T2ZQVXgybkRsNjc4?=
 =?utf-8?B?WkRQbW1VOU1XekhtREVtdE10M0dDTDFSOUpXdlYyYkZSSSs1VXFOek1ENFdq?=
 =?utf-8?B?eGR6N2FEd09TV3NsZEFLV2RoK1laZXk5OFJ5TS84NmNGR0ZqUUhtY01OWEMv?=
 =?utf-8?B?ZUx2dkJFaU1icnRKRkpOMFZVV01BakJYMWJlTGxaRThKeHFSWElyZnVSUGhi?=
 =?utf-8?Q?/Qfo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ae8c33-3713-433e-9806-08dc75e345da
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 20:03:37.1014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M9C8DliQ57p4ppWmyQICUVQSMufKAB5gbv3RH5Hwi7Lf2NO6z9QlTXqc5zBs84JS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8339

Hi Peter,

While working on v4, found few things. Just wanted you to know (mostly FYI.).

On 4/3/24 19:30, Peter Newman wrote:
> Hi Babu,
> 
> On Thu, Mar 28, 2024 at 6:07 PM Babu Moger <babu.moger@amd.com> wrote:
>>  struct rdt_fs_context {
>>         struct kernfs_fs_context        kfc;
>>         bool                            enable_cdpl2;
>> @@ -433,6 +436,7 @@ struct rdt_parse_data {
>>   * @mbm_cfg_mask:      Bandwidth sources that can be tracked when Bandwidth
>>   *                     Monitoring Event Configuration (BMEC) is supported.
>>   * @cdp_enabled:       CDP state of this resource
>> + * @abmc_enabled:      ABMC feature is enabled
>>   *
>>   * Members of this structure are either private to the architecture
>>   * e.g. mbm_width, or accessed via helpers that provide abstraction. e.g.
>> @@ -448,6 +452,7 @@ struct rdt_hw_resource {
>>         unsigned int            mbm_width;
>>         unsigned int            mbm_cfg_mask;
>>         bool                    cdp_enabled;
>> +       bool                    abmc_enabled;
>>  };
>>
>>  static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r)
>> @@ -491,6 +496,13 @@ static inline bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l)
>>
>>  int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
>>
>> +static inline bool resctrl_arch_get_abmc_enabled(enum resctrl_res_level l)
>> +{
>> +       return rdt_resources_all[l].abmc_enabled;
>> +}
> 
> This inline definition will not work in either this file or
> fs/resctrl/internal.h, following James's change[1] moving the code.
> 
> resctrl_arch-definitions are either declared in linux/resctrl.h or
> defined inline in a file like asm/resctrl.h.

Yes, These definitions need to moved to asm/resctrl.h.
Moving that will involve moving few data structure as well.
It is better it is done during fs and arch restructure.
> 
> 
>> +
>> +int resctrl_arch_set_abmc_enabled(enum resctrl_res_level l, bool enable);
>> +
>>  /*
>>   * To return the common struct rdt_resource, which is contained in struct
>>   * rdt_hw_resource, walk the resctrl member of struct rdt_hw_resource.
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 05f551bc316e..f49073c86884 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -850,9 +850,15 @@ static int rdtgroup_mbm_assign_show(struct kernfs_open_file *of,
>>                                     struct seq_file *s, void *v)
>>  {
>>         struct rdt_resource *r = of->kn->parent->priv;
>> +       struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>>
>> -       if (r->mbm_assign_capable)
>> +       if (r->mbm_assign_capable && hw_res->abmc_enabled) {
>> +               seq_puts(s, "[abmc]\n");
>> +               seq_puts(s, "legacy_mbm\n");
>> +       } else if (r->mbm_assign_capable) {
>>                 seq_puts(s, "abmc\n");
>> +               seq_puts(s, "[legacy_mbm]\n");
>> +       }
> 
> This looks like it would move to fs/resctrl/rdtgroup.c where it's not
> possible to dereference an rdt_hw_resource struct.

There are two rdtgroup.c files.
0 arch/x86/kernel/cpu/resctrl/rdtgroup.c
1 fs/resctrl/rdtgroup.c

I think this should move to arch rdtgroup.c. It is better it is done
during fs and arch restructure.

> 
> It might be helpful to try building your changes on top of James's
> change[1] to get an idea of how this would fit in post-refactoring.
> I'll stop pointing out inconsistencies with his portability scheme
> now.
> 
>>
>>         return 0;
>>  }
>> @@ -2433,6 +2439,74 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable)
>>         return 0;
>>  }
>>
>> +static void resctrl_abmc_msrwrite(void *arg)
>> +{
>> +       bool *enable = arg;
>> +       u64 msrval;
>> +
>> +       rdmsrl(MSR_IA32_L3_QOS_EXT_CFG, msrval);
>> +
>> +       if (*enable)
>> +               msrval |= ABMC_ENABLE;
>> +       else
>> +               msrval &= ~ABMC_ENABLE;
>> +
>> +       wrmsrl(MSR_IA32_L3_QOS_EXT_CFG, msrval);
>> +}
>> +
>> +static int resctrl_abmc_setup(enum resctrl_res_level l, bool enable)
>> +{
>> +       struct rdt_resource *r = &rdt_resources_all[l].r_resctrl;
>> +       struct rdt_domain *d;
>> +
>> +       /* Update QOS_CFG MSR on all the CPUs in cpu_mask */
>> +       list_for_each_entry(d, &r->domains, list) {
>> +               on_each_cpu_mask(&d->cpu_mask, resctrl_abmc_msrwrite, &enable, 1);
>> +               resctrl_arch_reset_rmid_all(r, d);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int resctrl_abmc_enable(enum resctrl_res_level l)
>> +{
>> +       struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
>> +       int ret = 0;
>> +
>> +       if (!hw_res->abmc_enabled) {
>> +               ret = resctrl_abmc_setup(l, true);
>> +               if (!ret)
>> +                       hw_res->abmc_enabled = true;
> 
> Presumably this would be called holding the rdtgroup_mutex? Perhaps a
> lockdep assertion somewhere would be appropriate?

Yes. I have taken care of this.

> 
> Thanks!
> -Peter
> 
> [1] https://lore.kernel.org/lkml/20240321165106.31602-32-james.morse@arm.com/
> 

-- 
Thanks
Babu Moger

