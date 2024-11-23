Return-Path: <linux-kernel+bounces-418875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AC19D6691
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 01:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05AAD161285
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 00:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F3F4C85;
	Sat, 23 Nov 2024 00:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vtp5inNu"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A013E195;
	Sat, 23 Nov 2024 00:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732320134; cv=fail; b=oNCjwKrWAgjeBRXHsUozVO3Idt5p254cqEsDeBkCpHUaRAqO2QAkmMMp6zHFFxvnsV+eGFKh8kp7yxvGPPHNzoK54cWgQP1PZK7NXC3MwgoI7548vbj/G0l/oMmoTdu3+L84687ySwdR7/5wWk3xVmIYnA9PzmSB5Qkaj060/x0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732320134; c=relaxed/simple;
	bh=sI54N0Ylh28KXzJdi9Y+0JNoqACGavEOhgc3+Tbm7jQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EJfZsW/7J1An5uZDKCy0kBZiAsl6DEcrf68mmk6L2hyGJsg7TBrM7Bu++gRHeOZ6NTLtpcPl0c01JUNVfHWAbJFDVH3yaF2WPZlmPFic9yHHj9kedS5xG+r3DZ6cjtFkeWd+vwRtFw86HFj4EBNhEG2JmQinCftoU0xsPoL0Aj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vtp5inNu; arc=fail smtp.client-ip=40.107.223.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8DE3PZVb/evKvBCQX0Wq5pSCU3qDbH6F391PH5gjjaRnZirL1DQYLH1rhTddLIn/cHvXZsEXO5QKdg/soKaT3z8rConCXqGJ9/CT5o8ecdBUiar5WM3f5lfMncOxmfqeXNdZsaPAfNvpSzNIiRTeFE41EvDlGo9y2u35x4iavpD4H+7x1t0proD3y94u1xVt6XmFP+lgmGbRVQLvF4SKjvQf77Xtf2mx8sycJWBV5VUiAAcFwzOG+gI65SthWQpPYz5yAkVftHFHXUEci02zuSdurmA+Biv6zCOMhQn+685hr1JLY9BofMIew6qcGSY9Pi9GaMEyEYzBQ9nIXUEsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XQ6Q7gUWLhTFVD1yHlumSz1PvBE7LNh1ExoNj6GpaY=;
 b=he8oW/XdMX/pnG4W3My7BsITspVCJLS6EDyABXIhNEdM3qjlww3uWrcVv2sF+DtyQJm+PbfDft53hBJZNo7zv00m1ZE4g/ntqoeadrVhZvswSOnhFlcQdQsHbizhFYzpV9st75kKp08NXXabFX27DC/mpgmx50dxIAh1i1nRAT1D2Wpyzrg1fHEvzBTVfbyGiYJwvFtE7Fh+UdNNqv1QCCzTlUx+OBw0DN9jYYaa3uhgmt70IYSJpPSZGdOoM3KD1YHkQ1hgczYrO5eVHES4vfhmrUIblQuEsTq0Jh+7HjoxTyRZFMkWX16SljYSJC40XFal1naHat4WIIAGonBypw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XQ6Q7gUWLhTFVD1yHlumSz1PvBE7LNh1ExoNj6GpaY=;
 b=Vtp5inNuCfgAecW5kAWqA2mT583RqMghVcGSDCO/zS4BnzbIghqdNlTUpnd6ScnGE8ykKmonVhV472bXtwlzM17lXmvxshpCFLfoCbwWfueYKEbz7UE1w6N8F3DznROSEsVRMJLlVLCm8hTFkGQu/gnvBbB9s5tSohVwWV9Vq08=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CYYPR12MB8701.namprd12.prod.outlook.com (2603:10b6:930:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Sat, 23 Nov
 2024 00:02:07 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8158.024; Sat, 23 Nov 2024
 00:02:07 +0000
Message-ID: <9fc844fc-23e3-4b58-958d-75c96c98fad7@amd.com>
Date: Fri, 22 Nov 2024 18:02:03 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 08/26] x86/resctrl: Introduce the interface to display
 monitor mode
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: fenghua.yu@intel.com, x86@kernel.org, hpa@zytor.com, thuth@redhat.com,
 paulmck@kernel.org, rostedt@goodmis.org, akpm@linux-foundation.org,
 xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
 daniel.sneddon@linux.intel.com, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 jithu.joseph@intel.com, brijesh.singh@amd.com, xin3.li@intel.com,
 ebiggers@google.com, andrew.cooper3@citrix.com, mario.limonciello@amd.com,
 james.morse@arm.com, tan.shaopeng@fujitsu.com, tony.luck@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 peternewman@google.com, maciej.wieczor-retman@intel.com, eranian@google.com,
 jpoimboe@kernel.org, thomas.lendacky@amd.com
References: <cover.1730244116.git.babu.moger@amd.com>
 <121c79ea1abe6f21f726d086eba9fa61d31da3f1.1730244116.git.babu.moger@amd.com>
 <fe518638-a82e-4136-ae77-fa6a7abb4b2e@intel.com>
 <33cd0cc0-4f81-4a2d-a327-0c976219996a@amd.com>
 <d5bead60-6a38-426e-afa6-e7980a268d6f@intel.com>
 <0eff9462-e7e2-49a9-9538-c8907024322f@amd.com>
 <6c5f8c64-43f6-4145-b0dc-429603f8ee24@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <6c5f8c64-43f6-4145-b0dc-429603f8ee24@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR2101CA0001.namprd21.prod.outlook.com
 (2603:10b6:805:106::11) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CYYPR12MB8701:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fcdad15-a972-4bdb-5432-08dd0b521209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXFORDJvWGVISkJMb1gvUncwbm5WRWJjZWlRMVgzUDNEZzMvNDNFQUxUSlYz?=
 =?utf-8?B?SlRadzVaZzZFSnlCZVVlUkZqcjE4ZWZFWm1rUEhKbGlvdFI0WE5BL1dvOXd5?=
 =?utf-8?B?b3YxT0hPNWdiUjhwZmQxbmdETEhHeFpvUERqRnoxUlc4UHRrcjZPTlBSdGJi?=
 =?utf-8?B?d0h0MlVtaFBwN1hMQmE4R0JqQXYzeHdsck5LaStBaXNaek9EektxZ0pZV1F2?=
 =?utf-8?B?SldzM3dPdTM4TS9zTEQvMDNqbitQQ2gwL3lmM0Mza3NhK3J2ZHZwMnVIbUpV?=
 =?utf-8?B?citSWHlvd1BwbjFKTytjanBDRkJvVjhhTUdrUXVSWmJvM1BzcHNRNG9NTnZG?=
 =?utf-8?B?R3RTWjdvM08renE2d0QzUFBBMWFJbk1OWkFKektrclB1VEdUeWdaaGlpbTR1?=
 =?utf-8?B?emZtTENLcDYwMm9jUlErcnIxcEZ1TFNuWTUwWERPcjlpdDMvaE1zdXVLWnNF?=
 =?utf-8?B?TXRtZ2ZQM01OK0VoamZrQ21qL2RmVS9iTEV6SWhuem9JNmRsOXg2MjJIaVVw?=
 =?utf-8?B?K29CZVJPcnQvQmJZQlNtYjFlL1BPRWZWSVJ1a1Z3WGJRbDBWbTh3bVQzZmZw?=
 =?utf-8?B?K2dieFZHTFJCQlA3QmF3SVNHdGdTSzFQSHh2OTAzZ001VURoYTJwK1QyWnBl?=
 =?utf-8?B?ZkJxeXdoK1psbTZvL3RWVnI5VnpJVHRhaG5mMjNOMkM3a0ZFQ2JrajNrYWZW?=
 =?utf-8?B?L3dQS3FraUN6aEh2S1o2Rm1RVEwxMEdLelRzODdZaUdLQXJkVG15NTgrdkZW?=
 =?utf-8?B?UExEdzdjTEhrR0lVM2dia1I2VCt6UjJkUGZwMnkrQ0JMN1kzck9SRWYydFI1?=
 =?utf-8?B?L2V4cW43RXk3Q0IyVHA0WDZvTFB1bHZrVU5wMHRoTzNaTmZUeVVtbVhtdTVT?=
 =?utf-8?B?L3ZrOWJXakRQMlZONURWNGg0VGQzYXVnRG5HVlVSTDYwNVlHU04vMjNkK2NP?=
 =?utf-8?B?NDJEaDFXdUl3VnlZTWRLU1VkdTR5TWxjc0ZGYW02S25IL0IrUi9obk9tUkox?=
 =?utf-8?B?OGNWRTU2OGlsdzlmMTRndnE5NThjM0RvdVNKN2lhUkZkbDRBSVhEZFhQM2VM?=
 =?utf-8?B?OEFoSy9raXVpZUFNeXdoUGZndEZMWEtES0hSTUIvZFJqTlVMaC9HSSt0cUpm?=
 =?utf-8?B?blVGRFhua21RL2NHNDNnS2dSOXY3Y2Y4L1hSalRuZkJEcWUwK01ENzVLYXVa?=
 =?utf-8?B?dzlUNW5ZUkFKTkh1ekE3U2k3VlNwKzFGYVpjcFdlR0NpUkFNb0I0U093NW44?=
 =?utf-8?B?dWNZazcvKzkrZ3k3RmwvcWdEa3cyR0RaaFFoRWRyK25ISDk4RngxRGg0MnUx?=
 =?utf-8?B?V0Y5blRkNkxscmVKTFpvVTJxbDR0ZThQVXJnSWR6UEpTRGxneVJHcndJbDNO?=
 =?utf-8?B?OWdBWlhYNmVIVHpaTnlWV3JNK0dHdGZkTjMwZzlwSTBZSHNWWjJET3MvSEpJ?=
 =?utf-8?B?ZnBlaEFhMmpuMVJTa0t1OEk0NnNnUkFUYmhZbmFobEdkdjJLUmN5Wk1zSXFo?=
 =?utf-8?B?a1VyWjBmOXFqQ05pNk1LdytPTUdibUVaSHl3MVkxSGhZaGZENTIvczRjSHpu?=
 =?utf-8?B?OHd2dUpDZmVMdzRGdG40dm5GYlUwaW1mOERoU2lxS1dZQy9SUmd5Qys3YjV0?=
 =?utf-8?B?aUo1V0tHbFRJdnhoQ3JHTnpsOE5Hd2tGMkV1ZUtGTUZGdVBBQ3BKaHBrQXRT?=
 =?utf-8?B?QzFQNUZtS05mWEYrRXQ0K2RvYURhR0ZRNi9SbXJKMXFrSWpqbWwzemFQdW1X?=
 =?utf-8?B?VUFKN2t4QnFzZEwwN3VZd05KdkFxZWM5SGluYVJwMS9iSC80OTVqNlVjRTkr?=
 =?utf-8?B?VHdnTjRTbzhuejNtNlF5UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0ZSeWQ0MWh1UHYvSldGZHYvdjgwcThKVlFvTTgwT0htYkkrZ0hGa1g0L3lR?=
 =?utf-8?B?MlI4amV0eEhJRys5eFVIYXFkL003RVlmeGk5RDFhNDZKemhTcFFKWS9uTmsy?=
 =?utf-8?B?dWRGN0oyRzNhOE5penc4bkRUM3krY1BrZXRsb3BQWkplR05GOHlxT1BrMkxF?=
 =?utf-8?B?MzFyRFJvWFdwSGJwcVV5VTJtODRLdVgvaUYrNmxhZ05DTXRqeDVGOThvRnJJ?=
 =?utf-8?B?M3cwK25PajJld1JIdkEwYWJ3Y0lLMitQTHdsNS9lb3BMVTFtZzRzTTlLYXk4?=
 =?utf-8?B?dm8zZUVmUWpaZHRWVkN6ZmlvT2hIL05pYlZHUnNQTm9UbnRweldXL2VQMHpa?=
 =?utf-8?B?WWpDUUMzNEFobDdpSERscGlhZzVnMXNyM3RJcU1Uc3lwZmRIZ3NHN0Jyajl0?=
 =?utf-8?B?dms3NXBSTUJ1RlMrbzRnK0R0eTJYNlFIUTNYa2paL1QwL21UenBQbmhzSml2?=
 =?utf-8?B?MGpzekErcTlPc2R6K0N0YkZHcW5PK3U5bWc5ZUM0Q0ZRVXBVbHZnN0h4V0Nq?=
 =?utf-8?B?aUxRdmQ0eDVDN21yWXhkVE9ZQ25IK1doUk1lMkJrakpvNkFOQWhIRlZLRDIr?=
 =?utf-8?B?RGVDRXlNUXo2QkUxT0RNSlFTaytJTHUyWVhnNWY0anRXMjY2bVIycGFQbmo1?=
 =?utf-8?B?SHpyM01iYTVvRU5MZXdKMVRnWUt3YTI3OXN2Q1VwQWN6dktDa04va0t4cWlo?=
 =?utf-8?B?VnNMMXpZYkpnWnVkWWxVK0JxNzUzdFFVUEs1dmlJRWg3djE4ZWRQN3UxbDA1?=
 =?utf-8?B?NnUxdWNoNEtkQlZWOFkxN1JwWmxOMGlRUGpRaXdCb0pHc2RXZHZNbmhTYmpy?=
 =?utf-8?B?SU82aEVvazBCTEllbWZxS0w2ZDFlZ2ZGRCs2NTVJSzZBWmsvODNIKytveXJ5?=
 =?utf-8?B?aXEyOGo3ekZjMUx6aEJsYkRJaVI0TGd5SXhwWHR2d0dKWlo0NUxoT3VYaFJ0?=
 =?utf-8?B?UUV2SnNBaHk2ZzlLTVZNR2lUTTVBWnhJekZQSWJqZEc2c2hKUldoS00wZFJo?=
 =?utf-8?B?S0JTT0pNVXRMbkszNmxSTFFFcjRLZnhVeHRpbllpTVBXekswTFNYckpmR3Rz?=
 =?utf-8?B?UE9uSEtML21EWkdjMlpNeHFuT2RiekVScTZ3VWpkOWZ4SE5rM1pLblZrdlBh?=
 =?utf-8?B?R1Vubi9KdU02V1ZhRkhxYmVpWEhhNHZPejZ5S0dkWDRiR1lkb0FGblkrN2xi?=
 =?utf-8?B?Rld6U0hmZitZWFNQWTFtYThtS1I1R0JXTEIraVpHb3hvVmNsOWs4Y0dVdHdi?=
 =?utf-8?B?U2ZpKzA4cGVQZFFpeWZuTUd0RlRZRjcrU3l3VEo1cW9yMDVrdnZtNmxpK2pp?=
 =?utf-8?B?N3V5NkJObVFtUHRrazN5QTU5YzJ1d0FnS1EzdkFSNXJxMVI3cFF4anFha0FW?=
 =?utf-8?B?dUpDR0FBeEgzd2ZYYjBYZG5mdVlBTmxjVVlzdmdmdmZtbElLOFhja3R2dGxK?=
 =?utf-8?B?aDZuaWVyRnNndVBFNHJLL3ZZSjNMY2s3dS9LQ0pIUUNhSUMzVkJwTE5kSGwv?=
 =?utf-8?B?M2JhTmN0MXRBdW5KUjg2K0xMMWVTSCs5QWxjZmdSSmZLeWcwZU9hTXBMcEF5?=
 =?utf-8?B?Y2s0YzRXNG5KQmpSUmxHKzh1UDBaZGVrSTBGK2tCTFRYZ3F5L1FWaUdFaVQ1?=
 =?utf-8?B?WGlLWlUrU1dURzJBWlJ3MUhRU05xL243cFdiN0kvejl6MlN1Y1lOWXY1OVIy?=
 =?utf-8?B?UjFNak5YamtjSVdiQzc0Z2pZYVRlVHNzWjZHWHNXb29RU2NZaU00OEdkVVBH?=
 =?utf-8?B?T1dYcEFHUWZCSUtMQ05DdHdjUVJ3QWxia1BEbDlZTGZldi82cU1yWDVqbkZw?=
 =?utf-8?B?a2x6VW5XR3JsV0hKVllWWkVxdG1TUWpWYTB1RmtKNzdPTmk4Q1pLZVVia2Yw?=
 =?utf-8?B?RU1wUWNZM2FxUEhWV28zRHFWczNmcFQ5SlB0eFBYLy9sRStkYTh5SGZmRjBr?=
 =?utf-8?B?RFRDOVRJZWhZakN5V3FYK2ZydHdaRzljWi93dll4SXYrbTlVNzBDUXhlR1dG?=
 =?utf-8?B?MzJQNERsNC9kanF5c3FMVFlMa2dXZ2toYml6d1p3RkcxZm1LTS9mMlNyRWM5?=
 =?utf-8?B?eG9QRzFxRUlVcXRQaVNXM3FzNlJ0Q0lqekhZeFhsN0FUWWY2M3lHNU5xa0pT?=
 =?utf-8?Q?pp44=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fcdad15-a972-4bdb-5432-08dd0b521209
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2024 00:02:07.5748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2IbSZwcN12tbPZvDluj7T6fDkKpZjhHokW855cs5J7gqO7cwv8kHSB8ch7nQb6y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8701

Hi Reinette,

On 11/22/2024 3:37 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 11/22/24 10:25 AM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 11/18/2024 4:07 PM, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 11/18/24 11:04 AM, Moger, Babu wrote:
>>>> Hi Reinette,
>>>>
>>>> On 11/15/24 18:00, Reinette Chatre wrote:
>>>>> Hi Babu,
>>>>>
>>>>> On 10/29/24 4:21 PM, Babu Moger wrote:
>>>>>> Introduce the interface file "mbm_assign_mode" to list monitor modes
>>>>>> supported.
>>>>>>
>>>>>> The "mbm_cntr_assign" mode provides the option to assign a counter to
>>>>>> an RMID, event pair and monitor the bandwidth as long as it is assigned.
>>>>>>
>>>>>> On AMD systems "mbm_cntr_assign" is backed by the ABMC (Assignable
>>>>>> Bandwidth Monitoring Counters) hardware feature and is enabled by default.
>>>>>>
>>>>>> The "default" mode is the existing monitoring mode that works without the
>>>>>> explicit counter assignment, instead relying on dynamic counter assignment
>>>>>> by hardware that may result in hardware not dedicating a counter resulting
>>>>>> in monitoring data reads returning "Unavailable".
>>>>>>
>>>>>> Provide an interface to display the monitor mode on the system.
>>>>>> $ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>>>>>> [mbm_cntr_assign]
>>>>>> default
>>>>>>
>>>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>>>> ---
>>>
>>> ...
>>>
>>>>> I'm concerned that users with Intel platforms may want to use the "mbm_cntr_assign" mode
>>>>> to make the event data "more predictable" and then be concerned when the mode does
>>>>> not exist.
>>>>>
>>>>> As an alternative, is it possible to know the number of hardware counters on AMD systems
>>>>> without ABMC? I wonder if we could perhaps always expose num_mbm_cntrs as a way for
>>>>> users to know if their platform may be impacted by this type of "unpredictability" (by comparing
>>>>> num_mbm_cntrs to num_rmids).
>>>>
>>>> There is some round about(or hacky) way to find that out number of RMIDs
>>>> that can be active.
>>>
>>> Does this give consistent and accurate data? Is this something that can be added to resctrl?
>>> (Reading your other message [1] it does not sound as though it can produce an accurate
>>> number on boot.)
>>> If not then it will be up to the documentation to be accurate.
>>>
>>>
>>>>>> +
>>>>>> +    AMD Platforms with ABMC (Assignable Bandwidth Monitoring Counters) feature
>>>>>> +    enable this mode by default so that counters remain assigned even when the
>>>>>> +    corresponding RMID is not in use by any processor.
>>>>>> +
>>>>>> +    "default":
>>>>>> +
>>>>>> +    In default mode resctrl assumes there is a hardware counter for each
>>>>>> +    event within every CTRL_MON and MON group. Reading mbm_total_bytes or
>>>>>> +    mbm_local_bytes may report 'Unavailable' if there is no counter associated
>>>>>> +    with that event.
>>>>>
>>>>> If I understand correctly, on AMD platforms without ABMC the events only report
>>>>> "Unavailable" if there is no counter assigned at the time of the query. If a counter
>>>>> is unassigned and then reassigned then the event count will reset and the user
>>>>> will get some data back but it may thus be unpredictable (to match earlier language).
>>>>> Is this correct? Any AMD platform in "default" mode may thus be vulnerable to
>>>>> "unpredictable" event counts (not just "Unavailable") ... this gets complicated
>>>>
>>>> Yes. All the AMD systems without ABMC are affected by this problem.
>>>>
>>>>> because users should be steered to avoid "default" mode if mbm_assign_mode is
>>>>> available, while not be made concerned to use "default" mode on Intel where
>>>>> mbm_assign_mode is not available.
>>>>
>>>> Can we add text to clarify this?
>>>
>>> Please do.
>>
>> I think we need to add text about AMD systems. How about this?
>>
>> "default":
>> In default mode resctrl assumes there is a hardware counter for each
>> event within every CTRL_MON and MON group. On AMD systems with 16 more monitoring groups, reading mbm_total_bytes or mbm_local_bytes may report 'Unavailable' if there is no counter associated with that event. It is therefore recommended to use the 'mbm_cntr_assign' mode, if supported."
> 
> 
> What is meant with "On AMD systems with 16 more monitoring groups"? First, the language is
> not clear, second, you mentioned earlier that there is just a "hacky" way to determine number
> of RMIDs that can be active but here "16" is made official in the documentation?
> 

The lowest active RMID is 16. I could not get it using the hacky way.
I have verified testing on all the previous generation of AMD systems by 
creating the monitoring groups until it reports "Unavailable".
In recent systems it is 32.  We can drop the exact number to be generic.


There is no clear documentation on that.  Here is what the doc says.

A given implementation may have insufficient hardware to simultaneously 
track the bandwidth for all RMID values which the hardware supports. If 
an attempt is made to read a Bandwidth Count for an RMID that has been 
impacted by these hardware limitations, the “U” bit of the
QM_CTR will be set when the counter is read. Subsequent QM_CTR reads for 
that RMID and Event may return a value with the "U" bit clear. Potential 
causes of the “U” bit being set include (but are not limited to)

• RMID is not currently tracked by the hardware.
• RMID was not tracked by the hardware at some time since it was last read.
• RMID has not been read since it started being tracked by the hardware.

All RMIDs which are currently in use by one or more processors in the 
QOS domain will be tracked. The hardware will always begin tracking a 
new RMID value when it gets written to the PQR_ASSOC register of any of 
the processors in the QOS domain and it is not already being tracked. 
When the hardware begins tracking an RMID that it was not previously 
tracking, it will clear the QM_CTR for all events in the new RMID

- Babu Moger


