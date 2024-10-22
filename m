Return-Path: <linux-kernel+bounces-375382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1069A954A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FA391C22FA3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 01:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C6482D66;
	Tue, 22 Oct 2024 01:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s21MBkif"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34474323D;
	Tue, 22 Oct 2024 01:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729559584; cv=fail; b=cCUN5h2N4ks19n3RVw9taMTcwFDvkrVyGkz8ctzquCjpi93RvKtFoZm0yjbPorL4gqMWfzIkV2iHxt7iZE3SY/SFAPgm+QTeBigTNUQ/yHbMbitHF1zovlmbfEDbShUD5ChPu1G3H+G/mhGpnOtVdlszHjtQ2vjH9YJkPgQ41Jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729559584; c=relaxed/simple;
	bh=zWlbO7Ey92zDiH4njuUemzVp0fknRnqayW/NCZAAVss=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V9HY/GHPnaV1nUvD66yGv2oPQB3xRO99XFIZ1Eq+5Zea6SWSeYQbwityvyCXiNwmNoFNdyAQohhfl3BmgCbw0lgCkyOLdrhOqyVXYeK20yXuE0GsHw0nDkyyoFHMfKyCtH8Ih6QRG26YxlVLZRNFNF5z7XC8MYDws6lDXAjzIZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s21MBkif; arc=fail smtp.client-ip=40.107.92.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBhl3svjPBh9xXe8L45pR9gGPXmyxtMCcMlSvNsIOQJRW2ZKHnyClfy1UWEC13KfJPYEdlTnnxjUvRRkEV60rehcmbrrdZW0wOLWCHXYWP9PNaBw13sDufqo4S3+L7/q4eR/6P7T3LKmaLi2glI7V+93lcmwoiwY55AiOlAQcAwe/hvBiX+MErticoCr3IxHn+1ynPDL5JdSyML9GnZbpN2hrZBQ0iLByI1Hh82jj1SqufW1+HROfp5aSv59Ng8QHwHgVjzw6If5UlT8xN0+818c4hVgxIcTUZZHKY+BgVdFGSMYrfNEJvaDO8X/7W3c09Ba/+O9Vhh5iCx8f2WqlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uwvGxJ8hzsIe2XGc9lRK30QlpWgpgifAntE8eFnVXs=;
 b=vzYYuD55A3BSkkGrbwMiBFoH2NCbSn3ZTB2yMQvrUtdzX3x6CNDLnDQOvttu6Zzkbklh4TXLkghWEIkKSfhrAgeaotxT1ojBfgasyGdLxS4bq0izg831VrGsn299KkRa6rvVqHi7v6pR9KTqygvQ70178mv/26lmnwNr8iZLcOsqnZNF+/4LOxaDEVE+hkrxhAWCiH9AvsYZHnryK2OaRZbbxZrgNTIPW3EZ9yFVFq4gSJLWYogIJ4h1Vm6XfyyiArxSlDcq/4p6/Ix/bEpRyTQBTiT2sPKJTv3tOFn9o8tEEAqvP95M7jl6em54ZaZy/iBwlPRbv9Xsz302/U7Low==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uwvGxJ8hzsIe2XGc9lRK30QlpWgpgifAntE8eFnVXs=;
 b=s21MBkifucLsIiLepQgu2ZHMW1eycZrimrBpepDWfzhzwWBsxi9YkM1tKPdxqR53SbssO9QvEaDxdV6blKppFhOBNNh775YE78GA6sGxszp7q5lw7yJUkbGzjIkXvnSM8nVA89LKCqerwkib57Av2kgxKta0vGgiT7AdxpRP9fg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB6006.namprd12.prod.outlook.com (2603:10b6:8:7d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 01:12:59 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 01:12:59 +0000
Message-ID: <8d9792fa-1d81-a5c3-5c45-2f1f86ee5cc9@amd.com>
Date: Mon, 21 Oct 2024 20:12:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 25/25] x86/resctrl: Introduce interface to modify
 assignment states of the groups
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 corbet@lwn.net, fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com
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
References: <cover.1728495588.git.babu.moger@amd.com>
 <c3c12e970a660c32088a447f9961826ec3a9fb24.1728495588.git.babu.moger@amd.com>
 <faf0b49e-b379-48d2-a14d-ad931bb46883@intel.com>
 <d5d7706c-0c12-46bf-9a4d-9bd80db2c83f@amd.com>
 <9f3ab90b-0f35-4dcc-9996-4d6e941cbf2e@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <9f3ab90b-0f35-4dcc-9996-4d6e941cbf2e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::20) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS7PR12MB6006:EE_
X-MS-Office365-Filtering-Correlation-Id: 092bea7f-7559-44fd-1580-08dcf236aac1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjluL0xrWUVTYSs0TFRWbmVKazBZUVNrcWdzSjNmNXpiLzNpWTdYaXBlaHo3?=
 =?utf-8?B?TTVCM3ZHcmt2NGVWMXlObmlNNUNubU9KRFZZOG95Vzh4TklyU3czM1RQbFpQ?=
 =?utf-8?B?Nk41eWVkVEVObEVmb1F5ei8wVUxqUmV4N3JkZ2gxSFBCOXRsc0NtRTNMaGRY?=
 =?utf-8?B?bkI1OHozTFhtcHRhYUFNaFpHRlgvTEVObzdXdzFlWWp2MGF6cHhUbGxGWGtv?=
 =?utf-8?B?VUovTkxPaDZVWXZxVkg4bGhvbnhnT1JQMCtKSlE2TzhHMzhSVDFFMmtCM2p1?=
 =?utf-8?B?VU1KRmFtZzBSREVzQmVXcGI3dEpYZ04rWjcwR1kxclhWSGFPRXVud2ZFbTY5?=
 =?utf-8?B?ZlA0ajRKdkhUYnhRVnVDVTJyRmt6ejUwUXhwSUlTWWJVZThhbzhyb1Q4UGxP?=
 =?utf-8?B?WXh5WEJZTU5PZHpPb0hvQVVLdXN5azBsT2tYM2FUTVFHcDNQNUhVOXVFallm?=
 =?utf-8?B?SVlPNkh1akprUSt4ZWkvQXo0emlhQjhzOXRLZ2NCZG8waVViWnJOMFVQTHg1?=
 =?utf-8?B?R2ZtNVhsTWZmbGdBcUJnL1VPTngxWmgzd3NOeUpHU0dLZXU0UVZyd092UU4v?=
 =?utf-8?B?ZE1saUR4YjNnTVV6ZzdTSytZaGJTYWVkcmJrNWdvMENzZExwQXBIeTFDNGFj?=
 =?utf-8?B?SU9qazdLRitmQXl6YmZhSVlNKzBEOWJPUEpjYVhVWHIyMXJVZGNLV3o3endV?=
 =?utf-8?B?dzZ6NnhScUlzY0ZvSmIwS0FsNWwvU2pYNDhzNUR1S2tqNXZZdlB5eWpPalNo?=
 =?utf-8?B?TnA0WkFuQUw5S3pQcHEzWFBDMG41bHdQVWplTE55c0NDNnUyeEpVYnV0VmRm?=
 =?utf-8?B?Uk1NV2hhazFOUFJjSDZBRlhZTkNJd0tuVlFuRVBoSHg1MythclZjeHMrcy9a?=
 =?utf-8?B?VG1xdEZEeEpaNmlmL0hmY3dtVXdQWG5OV3Q0SkQ2V05ScUQ0emlWZ1BmOVZG?=
 =?utf-8?B?VVZpV251NitINkFQcm9ZR2ozMTNTQTNzMUZUVTduUUdvczVUdGtUeXNtNEd0?=
 =?utf-8?B?QjVieHlRUGZ4ZEJ3UjhjQ0h1cU9mMlNTQmg4K3pPcC9RcDIya29MRWVyMU5I?=
 =?utf-8?B?dFBEZUxBQnBrd3hHdkpwT0pzN3FFVWU5Z3lIVUJyUjZTRFloU2lxSHpMaXZu?=
 =?utf-8?B?SjRjUWZSeUU0Z1haZGFjc1M1YUNRbXNqWnBPL1FjSXBCQ0JUMUc1TWxZM2J4?=
 =?utf-8?B?MWJRcVNMRExiaE0rTVBoQzU0cGVpNFkrcGpkcXN4TU5CQVVxZlRvYS81Qy8r?=
 =?utf-8?B?ZFhiTkZZWnIwUmRPNXZ0czBuY24rZHRVd0NwT3l6M21pS0M1ekljeWhIWllE?=
 =?utf-8?B?YXl5aVNqRUIraDBoUkZGTVMzRGI0VWxqR05ycHlXR0Nyd3JrdVl0b05FTW0z?=
 =?utf-8?B?SE9tN2RWQmpZMFpGWE1tNG8xc1lGQjV4SUNGaDY3SldVWWU5RXBvQ3hVSytv?=
 =?utf-8?B?azJzL3FUVGRDRk4zUkVmMVU2MDlzOUsvSGYxNlAwV0NmRVVzL1BOR0ZQUFFw?=
 =?utf-8?B?bURBbUJ1elg5cDNEaGpuOGhvSTNsUkkyZ295OWFLOWRaZFQxQVdwd3N1c0RZ?=
 =?utf-8?B?a1p1ZVB5QkRGbWorMjdwVC96aHpLSFc0bmNOS2FIOVQyQXNFN3VlRmJtS1Z3?=
 =?utf-8?B?WFJ3azJvM3FZejFLWmRMSWJNbUs2ZGg4MC8rdVNLZWI4S1hja3BiNm9yTDZJ?=
 =?utf-8?B?bFJ1SG55di9HeWNGaWtJQXB0NzcyVGlaQUgxSGx2czhMVEQrazhIVkUvcjV2?=
 =?utf-8?Q?6h7VfB11YbgDc7IGikYLiX0XbFUiJptNUY8JVYs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHpTWUNGUVpwblBTMVdsWEdIL002ZEd6THNJUll3UEcvOVZUeXpzeFF2Ri9C?=
 =?utf-8?B?NkFCcERNZ3Q1L0VuWnpyM2RtNTZ0bU85eUp0dExHQ1RHUUx3UHBpeTE5SFZE?=
 =?utf-8?B?VFZVSHlwL1VkU2VDZXlGKzN0OUxCdWh1TERJRUlMUFlFaVJGVHJFeVZWTEJS?=
 =?utf-8?B?QTE1NGdhdVBpdjlJV2VjVjhqVXR5cmJ2QVV5OEhhL2cyN29sSVQ5S1RjUVRj?=
 =?utf-8?B?dTV3Z2JDT0d6RDBUZ05HUkJFQ1NuTXBCNngrVGpNeGVmZ3RYeFJXZy91Tjl0?=
 =?utf-8?B?d01BQWtuR1B2YkNZYUNCYU93S2FuR1IyREJsbVM4cG9MUHZaMGVhbHppS25n?=
 =?utf-8?B?c2F3OE4xR1VYVEFiZFBIZnRqOUlrcEdrL04xSENJMWhoYlRHS0xPTUNWU2I4?=
 =?utf-8?B?NkhWSVFxU2dSVGpGSlNEL3RLcnR1K0tNdzVzTHEyUTQzMGZWQWJkRWorNVZC?=
 =?utf-8?B?OWJlRm14b1pldG5JazBjeGh6SWdzVld4dUJVaSsvVzc2TU8rNEhyUG01TzJ2?=
 =?utf-8?B?UWVlcFh5aFR6QmFURVc1Z1ZPV0NOamVuVGQ4K3lSVUE1NWI0ZzlCYS81cTI0?=
 =?utf-8?B?Tmg0VFYzbks3RWxaSG5wcnRCMkVSSDhIZTVNb0JybHV6NGhDYTU5RmlINGJF?=
 =?utf-8?B?OXlEUkNkSkQ1WUEzbGJENHVIZ2hlUkJvdjZoZVI4VUZaSDltYmdhcEJLd2tn?=
 =?utf-8?B?dG9URHZWRFhyVTlNYTJOcUo2Vm9GYXloVlk2OXFCL0lidlZRdUFZdjhMbm53?=
 =?utf-8?B?L2J3d1dqeVlkbDZrUkptRWQ4cGdHeGpneXpoSUxyQTNPQUJIQ2loYk1jQWhJ?=
 =?utf-8?B?Y3hraVNjSUtmcExFOEt3MGIxM0hXSWVuc3N0S041Z0JFT2Q2TVhWeTJ1N1A4?=
 =?utf-8?B?S0pSaUZhcUFZdVozb0J3Q20zRU1naUs0d1lEVDlUWFFHa2Z4bTJ5TENhQ0FK?=
 =?utf-8?B?SDA5clJUbUJabEFzRkl6Sld3QVIzTC9xd0IzWXg4ditPSWlEeHJpNVlGVW1p?=
 =?utf-8?B?UDFkUXR2OERTbytYVm1sOVJPTFN2dGhJQ2V4aWZlVHBsMXp6K1VmN21FVjlL?=
 =?utf-8?B?dzVId01EVDc4aGRhd21lMWh0S0Q1THhwN3ljYXBqZ1NjZVVCOGxoT1R2MlhH?=
 =?utf-8?B?WHhPeEZuUzUxa0I3ZjFrUjNlR3o5dHQ0ZkFrMWhiVUZXZk9aY1hVbEVPS0VI?=
 =?utf-8?B?em9tU1FJTDYvRmpTSTJVb1kwd1dTbW9wczQrQkZCZUptOGRuQllWNUZENXB4?=
 =?utf-8?B?VUtJQXhES0NPTURJQ2lySHBOVEdLOEtVUldhNjRRRlJvRy8xbUtpUlFBczNK?=
 =?utf-8?B?WHFnTVdmV3pmSWU4SDBEcFpZN2VFdnk0Y1FQR1JxZUJ0YXl2UXVGMXJCcWU1?=
 =?utf-8?B?c3pDTngxK2VQSkpoTEFiTS81L2tlU2YwNklzNzJPUkFoSTF0K3NLWnltNlQ0?=
 =?utf-8?B?dUc5Mlk1UkFnVVVaTW5kTkUwOW1PeE5lWG1FQlkyUUVMK1ZKMjkrdnJBSy84?=
 =?utf-8?B?WGtiNFpOd3FoeU92NGI0MDVMc3Nkd0EzU3BCYzVSRGRsalkwYUNkQW5ReHZu?=
 =?utf-8?B?WFRKODNDS21FQyt5SnE0d3dhTHRTRm95Mkh6RmdZWnJCczV6cmcreFdORzJi?=
 =?utf-8?B?QllyN0IzcHlRbDIyTE95eWUycFlaZU0vSVFFeDN4RlhSc0NxUWVzQzR6bTRu?=
 =?utf-8?B?NlR0emZHVkJMc0krRS83WDV6ZTl1Vm5uTk1UWGFLZ0ttUWtDTnFDK0c2dm9l?=
 =?utf-8?B?MVBZZUFqdEQ2ZW1OR2ZhMU9mWmg1dUZxUXpLM2NFMVB5OVlHbEZLTHlRV3l5?=
 =?utf-8?B?MHpITlRHT0ZaOU5mTUhqT2JkelFueDBDalQvTnJiTWhPZFR1d3UybjRlU1Nh?=
 =?utf-8?B?S1pXcFNBdnBkc1dvQlpDK3NISUh0dVc3ZFVkdXVTVVZuLzZmb3N0ei92MWtJ?=
 =?utf-8?B?Tk10dnc2Qi9nWHdsNDBnNkZ2eEFWQ2JodEowcGxaOWl0RjJzWTJJTkdGTnRj?=
 =?utf-8?B?K3NCTzdpc0dkZUVkT2dhQTRFT3M4ZWdndmNEQzhKR09PREpoNEUzQXdkb0R0?=
 =?utf-8?B?dDh5Y1JFL0JoVkMrMW5SeWVDU1lBd0Z6T1hNcElvRnZET2hQYUVwQVdLSW8r?=
 =?utf-8?Q?ExFI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 092bea7f-7559-44fd-1580-08dcf236aac1
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 01:12:58.8678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJPq+EjJ8Kpeer0FxrA0P2V4IpbQkfjkDJGuK5KMDbvTykmFnG5Ql1d2XKU8Egtz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6006

Hi Reinette,

On 10/21/2024 12:20 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/21/24 10:04 AM, Moger, Babu wrote:
>> On 10/15/24 22:43, Reinette Chatre wrote:
>>> On 10/9/24 10:39 AM, Babu Moger wrote:
> 
> 
>>>> +static int rdtgroup_process_flags(struct rdt_resource *r,
>>>> +				  enum rdt_group_type rtype,
>>>> +				  char *p_grp, char *c_grp, char *tok)
>>>> +{
>>>> +	int op, mon_state, assign_state, unassign_state;
>>>> +	char *dom_str, *id_str, *op_str;
>>>> +	struct rdt_mon_domain *d;
>>>> +	struct rdtgroup *rdtgrp;
>>>> +	unsigned long dom_id;
>>>> +	int ret, found = 0;
>>>> +
>>>> +	rdtgrp = rdtgroup_find_grp_by_name(rtype, p_grp, c_grp);
>>>> +
>>>> +	if (!rdtgrp) {
>>>> +		rdt_last_cmd_puts("Not a valid resctrl group\n");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +next:
>>>> +	if (!tok || tok[0] == '\0')
>>>> +		return 0;
>>>> +
>>>> +	/* Start processing the strings for each domain */
>>>> +	dom_str = strim(strsep(&tok, ";"));
>>>> +
>>>> +	op_str = strpbrk(dom_str, "=+-");
>>>> +
>>>> +	if (op_str) {
>>>> +		op = *op_str;
>>>> +	} else {
>>>> +		rdt_last_cmd_puts("Missing operation =, +, - character\n");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	id_str = strsep(&dom_str, "=+-");
>>>> +
>>>> +	/* Check for domain id '*' which means all domains */
>>>> +	if (id_str && *id_str == '*') {
>>>> +		d = NULL;
>>>> +		goto check_state;
>>>> +	} else if (!id_str || kstrtoul(id_str, 10, &dom_id)) {
>>>> +		rdt_last_cmd_puts("Missing domain id\n");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	/* Verify if the dom_id is valid */
>>>> +	list_for_each_entry(d, &r->mon_domains, hdr.list) {
>>>> +		if (d->hdr.id == dom_id) {
>>>> +			found = 1;
>>>> +			break;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	if (!found) {
>>>> +		rdt_last_cmd_printf("Invalid domain id %ld\n", dom_id);
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +check_state:
>>>> +	mon_state = rdtgroup_str_to_mon_state(dom_str);
>>>> +
>>>> +	if (mon_state == ASSIGN_INVALID) {
>>>> +		rdt_last_cmd_puts("Invalid assign flag\n");
>>>> +		goto out_fail;
>>>> +	}
>>>> +
>>>> +	assign_state = 0;
>>>> +	unassign_state = 0;
>>>> +
>>>> +	switch (op) {
>>>> +	case '+':
>>>> +		if (mon_state == ASSIGN_NONE) {
>>>> +			rdt_last_cmd_puts("Invalid assign opcode\n");
>>>> +			goto out_fail;
>>>> +		}
>>>> +		assign_state = mon_state;
>>>> +		break;
>>>> +	case '-':
>>>> +		if (mon_state == ASSIGN_NONE) {
>>>> +			rdt_last_cmd_puts("Invalid assign opcode\n");
>>>> +			goto out_fail;
>>>> +		}
>>>> +		unassign_state = mon_state;
>>>> +		break;
>>>> +	case '=':
>>>> +		assign_state = mon_state;
>>>> +		unassign_state = (ASSIGN_TOTAL | ASSIGN_LOCAL) & ~assign_state;
>>>> +		break;
>>>> +	default:
>>>> +		break;
>>>> +	}
>>>> +
>>>> +	if (unassign_state & ASSIGN_TOTAL) {
>>>> +		ret = rdtgroup_unassign_cntr_event(r, rdtgrp, d, QOS_L3_MBM_TOTAL_EVENT_ID);
>>>> +		if (ret)
>>>> +			goto out_fail;
>>>> +	}
>>>> +
>>>> +	if (unassign_state & ASSIGN_LOCAL) {
>>>> +		ret = rdtgroup_unassign_cntr_event(r, rdtgrp, d, QOS_L3_MBM_LOCAL_EVENT_ID);
>>>> +		if (ret)
>>>> +			goto out_fail;
>>>> +	}
>>>> +
>>>> +	if (assign_state & ASSIGN_TOTAL) {
>>>> +		ret = rdtgroup_assign_cntr_event(r, rdtgrp, d, QOS_L3_MBM_TOTAL_EVENT_ID);
>>>> +		if (ret)
>>>> +			goto out_fail;
>>>> +	}
>>>> +
>>>> +	if (assign_state & ASSIGN_LOCAL) {
>>>> +		ret = rdtgroup_assign_cntr_event(r, rdtgrp, d, QOS_L3_MBM_LOCAL_EVENT_ID);
>>>> +		if (ret)
>>>> +			goto out_fail;
>>>> +	}
>>>> +
>>>> +	goto next;
>>>> +
>>>> +out_fail:
>>>
>>> Is it possible to print a message to the command status to give some details about which
>>> request failed? I am wondering about a scenario where a user changes multiple domains of
>>> multiple groups, since the operation does not undo changes, it will fail without information
>>> to user space about which setting triggered the failure and which settings succeeded.
>>> This is similar to what is done when user attempts to move several tasks ... the error will
>>> indicate which task triggered failure so that user space knows what completed successfully.
>>
>> Will add something like this on failure.
>>
>> rdt_last_cmd_printf("Total event assign failed on domain %d\n", dom_id);
> 
> The user may provide changes for several groups in a single write.
> Could the CTRL_MON and MON group names also be printed? It is not clear
> to me if it will be easier to print the flags the user provides or verbose text
> that the flags translate to, that is "t" vs "Total event".

Yes. We can print generic messages with group names and flags

"Assignment operation +-= failed on resctrl group ABC with flags = lt"

> 
>>>> +
>>>> +	return -EINVAL;
>>>> +}
>>>> +
>>>> +static ssize_t rdtgroup_mbm_assign_control_write(struct kernfs_open_file *of,
>>>> +						 char *buf, size_t nbytes, loff_t off)
>>>> +{
>>>> +	struct rdt_resource *r = of->kn->parent->priv;
>>>> +	char *token, *cmon_grp, *mon_grp;
>>>> +	enum rdt_group_type rtype;
>>>> +	int ret;
>>>> +
>>>> +	/* Valid input requires a trailing newline */
>>>> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
>>>> +		return -EINVAL;
>>>> +
>>>> +	buf[nbytes - 1] = '\0';
>>>> +
>>>> +	cpus_read_lock();
>>>> +	mutex_lock(&rdtgroup_mutex);
>>>> +
>>>> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
>>>> +		rdt_last_cmd_puts("mbm_cntr_assign mode is not enabled\n");
>>>
>>> Writing to last_cmd_status_buf here ...
>>
>> Sure.
>>
>>>
>>>> +		mutex_unlock(&rdtgroup_mutex);
>>>> +		cpus_read_unlock();
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	rdt_last_cmd_clear();
>>>
>>> ... but initializing buffer here.
>>> Sidenote: This was an issue before. If you receive comments about
>>> items in patches, please do check if those comments apply to other patches also.
>>
>> Missed it.
>>
>>>
>>>> +
>>>> +	while ((token = strsep(&buf, "\n")) != NULL) {
>>>> +		if (strstr(token, "/")) {
> 
> What is the purpose of this strstr() call?

This is a carry over for v6.  Not required. Will remove.

> 
>>>> +			/*
>>>> +			 * The write command follows the following format:
>>>> +			 * “<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>”
>>>> +			 * Extract the CTRL_MON group.
>>>> +			 */
>>>> +			cmon_grp = strsep(&token, "/");
>>>> +
>>>> +			/*
>>>> +			 * Extract the MON_GROUP.
>>>> +			 * strsep returns empty string for contiguous delimiters.
>>>> +			 * Empty mon_grp here means it is a RDTCTRL_GROUP.
>>>> +			 */
>>>> +			mon_grp = strsep(&token, "/");
>>>> +
>>>> +			if (*mon_grp == '\0')
>>>> +				rtype = RDTCTRL_GROUP;
>>>> +			else
>>>> +				rtype = RDTMON_GROUP;
>>>> +
>>>> +			ret = rdtgroup_process_flags(r, rtype, cmon_grp, mon_grp, token);
>>>> +			if (ret)
>>>> +				break;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	mutex_unlock(&rdtgroup_mutex);
>>>> +	cpus_read_unlock();
>>>> +
>>>> +	return ret ?: nbytes;
>>>> +}
>>>> +
>>>>   #ifdef CONFIG_PROC_CPU_RESCTRL
>>>>   
>>>>   /*
>>>> @@ -2328,9 +2558,10 @@ static struct rftype res_common_files[] = {
>>>>   	},
>>>>   	{
>>>>   		.name		= "mbm_assign_control",
>>>> -		.mode		= 0444,
>>>> +		.mode		= 0644,
>>>>   		.kf_ops		= &rdtgroup_kf_single_ops,
>>>>   		.seq_show	= rdtgroup_mbm_assign_control_show,
>>>> +		.write		= rdtgroup_mbm_assign_control_write,
>>>>   	},
>>>>   	{
>>>>   		.name		= "cpus_list",
>>>
>>> On a high level this looks ok but this code needs to be more robust. This will parse
>>> data from user space that may include all kinds of input ... think malicious user or
>>> a buggy script. I am not able to test this code but I tried to work through what will
>>> happen under some wrong input and found some issues. For example, if user space provides
>>> input like '//\n' then rdtgroup_process_flags() will be called with token == NULL. This will
>>> result in rdtgroup_process_flags() returning "success", but fortunately do nothing, for
>>> this invalid input. A more severe example is with input like '//0=\n', from what I can tell
>>> this will result in rdtgroup_str_to_mon_state() called with dom_str==NULL that will treat
>>> this as ASSIGN_NONE and proceed as if user provided '//0=_'.
>>> This was just some scenarios with basic input that could be typos, no real stress tests.
>>> I stopped here though since I believe it is already clear this needs to be more robust.
>>> Please do test this interface by exercising it with invalid input and corner cases.
>>
>> Agree.
>>
>> But, tested the cases you mentioned above. It seems to handle as expected.
>>
>> # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> //0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;8=tl;9=tl;10=tl;11=tl;
>>
>> #echo '//\n' > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> bash: echo: write error: Invalid argument
>>
>> # cat /sys/fs/resctrl/info/last_cmd_status
>> Missing operation =, +, - character
>>
>>
>> #echo '//0=\n' > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> bash: echo: write error: Invalid argument
>>
>> #cat /sys/fs/resctrl/info/last_cmd_status
>> Invalid assign flag
>>
>> #echo '/0=\n' > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> bash: echo: write error: Invalid argument
>> # cat /sys/fs/resctrl/info/last_cmd_status
>> Not a valid resctrl group
>>
>>
>> The assign state did not change.
>> #cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> //0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;8=tl;9=tl;10=tl;11=tl;
>>
>> Sure. will test some more combinations to be sure.
> 
> hmmm ... these are not quite the examples I shared since from what I can
> tell it adds a second \n that impacts the processing of string.
> 
> Could you please try:
> # echo '//' > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> and
> # echo '//0=' > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> 

Yes. You are right. Above cases does not work as expected.

This should fix. Will test more.

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c 
b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 6095146e3ba4..cccce991d2d0 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1044,6 +1044,9 @@ static int rdtgroup_str_to_mon_state(char *flag)
  {
         int i, mon_state = ASSIGN_NONE;

+       if (!strlen(flag))
+               return ASSIGN_INVALID;
+
         for (i = 0; i < strlen(flag); i++) {
                 switch (*(flag + i)) {
                 case 't':


Thanks
- Babu Moger

