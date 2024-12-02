Return-Path: <linux-kernel+bounces-428298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C749E0C89
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C442821E4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7311DE89C;
	Mon,  2 Dec 2024 19:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="elYaRcS9"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EA01632FE;
	Mon,  2 Dec 2024 19:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733168950; cv=fail; b=Enm/eZgj37mnlUqE/XZbuix8hbv/xNwHA1m4828F4j6S8IS+0WLJH5VA77hrzAtFDB/lVx/aOilteHJlP7AmMAyPkZVBVto8yaelNDrf7dfFIIvwgEydi1ZTGaaqlBZhPXagpk//8aXS1ePdtdi0Uo/dTFSGcYRE6mNzRtqlsBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733168950; c=relaxed/simple;
	bh=a/q/61sXQc9KGpsWYHeVjQmUDVbOsXASUVg962H+2Lc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i5c1vw6NfuJsaTfqnRRS4NF834CWv9govKPJ8vcgCQWRBBhPbnZfyQise6obAIZDHnQ35GpbL+N98rz5ZPb0Cj6v1+ClRbZrZnhl+Ky+zzc2JMJhAKOlRyvyfoZT166QTZDruiF3NsHDCNwoMrU0ysrS2Roh4EnGIOHZXH74dqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=elYaRcS9; arc=fail smtp.client-ip=40.107.220.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9EKfdV7Bj5bKGCEk5t5kfANoQOTK4TBprNdIvD2oLnPKlliANLneiKMMfjCqoOU4zdvWnTlAD2CQFv1AdQf+54+ntg74mEkqx7ruFk2u4rKTKvYTrPcCdNGvlXhPto+nFSJ7/3ETEQWi6dmcucrZAYQmZD8k205W+V63b/GyKk2xZK4DQfZLISSJ1IkWLbTgF145pFW+umvllbhiLZnLkw3K5RScdBTYE28VigxUOI4WvJxNEznK6g+NOUGolHuzi6dE+Hq/n1xuGAbCgBQ6qFRGBagTBrjY9T1yortwW9LF8utkduKbUxY/VZgtm8yD2GBZDgBxMH64naKfOXWyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CaGj0yZtlI75dsuHnim3fOPcdGu+4FIHWXE1+LMKNI=;
 b=r2wUeRSFVSQGfLM7y31VJJMDc4Tfb9TGzOhIRPTzfZUDYWjgdXYcoFe71bj7w+L3on4hxLsS4x6x8BixCbMwKe6pREslSpj9dsCit13gYIBH5t29GOtTepD77hWfwp58JEYDS48mODgUFX9A2TNaI3YFH4lrZcPcDVpKOtLwu/4BO//1Wx9cmMUGru7Hh+ynAaYaHzjCfgHvK6p2nxVn9dzt9WpuRzx8pvd+W04CYTh3wX+DGxr1zUo0FxBc8fmreCeTtbzvZpItCu/gimnmx5WdYvntidgi/DHbwQ+LuRgRfH6F6Z7lc+xAPRwy5Zgs9s+fOodzll7kW72wc49Qtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CaGj0yZtlI75dsuHnim3fOPcdGu+4FIHWXE1+LMKNI=;
 b=elYaRcS9/VxyRqNg/rXFSHUTAz8OWyAoedZT1JBsQ8pkQJOrC3HcYXM3ki2iIZ9sWMMC68XdG2Z6Bcpgv7NlTvIPTvsVtrYyshhoOTZURuRBpQgnfm8eOMp40nFTnw9dPAH9HqLGFJhJv9/E9vDPkAcDq3taLjkUSALI5B0VoZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB7317.namprd12.prod.outlook.com (2603:10b6:806:2ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Mon, 2 Dec
 2024 19:49:03 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 19:49:03 +0000
Message-ID: <5a8eaf67-baaa-4278-abe5-cf68f795d4bf@amd.com>
Date: Mon, 2 Dec 2024 13:48:58 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 14/26] x86/resctrl: Introduce interface to display
 number of free counters
To: Reinette Chatre <reinette.chatre@intel.com>,
 Peter Newman <peternewman@google.com>
Cc: corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, fenghua.yu@intel.com, x86@kernel.org,
 hpa@zytor.com, thuth@redhat.com, paulmck@kernel.org, rostedt@goodmis.org,
 akpm@linux-foundation.org, xiongwei.song@windriver.com,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 perry.yuan@amd.com, sandipan.das@amd.com, kai.huang@intel.com,
 xiaoyao.li@intel.com, seanjc@google.com, jithu.joseph@intel.com,
 brijesh.singh@amd.com, xin3.li@intel.com, ebiggers@google.com,
 andrew.cooper3@citrix.com, mario.limonciello@amd.com, james.morse@arm.com,
 tan.shaopeng@fujitsu.com, tony.luck@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, maciej.wieczor-retman@intel.com,
 eranian@google.com, jpoimboe@kernel.org, thomas.lendacky@amd.com
References: <cover.1730244116.git.babu.moger@amd.com>
 <265f3700ac0c0d33703806fdc3d096b08c992efc.1730244116.git.babu.moger@amd.com>
 <0dc08082-0f3f-4acc-9285-b925a4ce3b02@intel.com>
 <5d426af4-a947-4115-b7b7-4eeecfa13fec@amd.com>
 <c587f94a-7920-49cf-94b1-4c52140db914@intel.com>
 <ef92f1fb-086c-4ee1-b8ec-e08ed68f963a@amd.com>
 <e065b193-dbcc-451b-98db-68a5a69e6ae0@intel.com>
 <20959b58-a882-4ef7-bd11-e8bb0a998945@amd.com>
 <1a93f4e3-d3d2-4764-90d1-728b9cb70481@intel.com>
 <36d8fe9f-0000-4d0d-a097-efddc3881a2a@amd.com>
 <5aa7924d-b27d-4ee6-b8dd-4bae0e25267b@intel.com>
 <CALPaoCj+zWq1vkHVbXYP0znJbe6Ke3PXPWjtri5AFgD9cQDCUg@mail.gmail.com>
 <4bf82744-da09-43c3-b8f1-7fc203d1c1c3@amd.com>
 <CALPaoCjL6FEmVgX-h3_GQEVZNAT3FcH34t9o1PwbUacVzXjZPg@mail.gmail.com>
 <18adb251-b340-4820-a808-e1583b44480a@amd.com>
 <5a08b85f-af79-4294-b953-5957503e2caa@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <5a08b85f-af79-4294-b953-5957503e2caa@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0063.namprd04.prod.outlook.com
 (2603:10b6:806:121::8) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: c5c5e2c5-1cf2-4d0a-ee28-08dd130a5fbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGZwVmZkNmJzUFVhL0FCSWtxWmtBa1NDWWhUYkFNVld3blJLSlBqbEZJN0hM?=
 =?utf-8?B?NXdjaGo0cWVNUWFNYjFsVlJtb1MvYW82K2FuUm5CcDdLMnlJNjRQL0h3L2o2?=
 =?utf-8?B?V2UxSkltYkdwck93bGNycy9ITkxkMmtkUTI2QmxqTEd6TUtWcnBKWTN6SUcv?=
 =?utf-8?B?U0xSc2ptZjNjVjNQWGRWbTRBdkJZQ2FKdHhqdUtrd0JxV2hGQllNaXI1S0Mz?=
 =?utf-8?B?aHNsaHdGZEo1ckRWcDRBcFNkRDJPNFprc29IVkZkWGpTeWNzaGtHR2hyOGNi?=
 =?utf-8?B?UXdVVEx2ZnVPVkxFUlNXZi9TQ0JWVExNWUFwKzJiYkY2SjBDaWI4bkJvY1lI?=
 =?utf-8?B?RVdhazBKeWwrUEFsVGI2bTFQSEtoZEN4WEhLVkhoM3dMUHEydFc2Vnh3cU5M?=
 =?utf-8?B?M3JLdWsrS2ZhaDNxY0V5bFZvZ1pPb2hmY1ZHcUQ2L2hRcEZaNllZNlRTQmQ0?=
 =?utf-8?B?bWEvT2t6TmsyY2FOTDIwYUpmYlhDcStRNjJ6NysvdGhlV2R1eVZOQzF6LzRS?=
 =?utf-8?B?WHF3TDBRcUQxbnpxaTY3cytrc1ltNkhEK255TFZiNlI5MWRKVnRlcXNTM3NI?=
 =?utf-8?B?M2ZqRnBvcHBYV3c2a2tPU0VNK1hpKzJVcFNZL2pGL3ptZEpxQlBJRGhvb1Vq?=
 =?utf-8?B?MEV0R3A1QVFQb0kvaGtnOEl3d2xnbWVoWFlha1kwMXM1QnZCaGkrdFFidnZv?=
 =?utf-8?B?eGZVazZHUDVYUXZYanlieU1XTDdHUW1jbFRab3pORVlPK0Rzb2VvMUZkdmhC?=
 =?utf-8?B?NzFjWGlNZjdMczZTalhGNVgyZ1ZndWF0ODF6ODU1cnBMVFIzS3NFNTkrYTNk?=
 =?utf-8?B?VUE5ck0vQUJkenEyS0dzeGx3SnBkb091Z3BCUjM0R3VxUkpyLzI4dDl4a1Aw?=
 =?utf-8?B?NGlYS29hRkZHdVhaNHFJZXZvKzcvTThpNit3OWtmb3VtU2o2OTBUSW1UVXAw?=
 =?utf-8?B?cjdlbEthQUViYm1FVys1OHYxNGxhZi9SQXZqcWgwM0tqaCtWckxFZW5jcUVJ?=
 =?utf-8?B?OER2ZEw4WCsyMk90THJmR3NIcllzOEE2d0lhb3BJTVN5bFdKQjM5ZXV0ZldY?=
 =?utf-8?B?QmgxM013bG5BUENZcWNKREgrTjBLWDBvaUlLaUFNSTRJWUNuOEJVMHR4L2RW?=
 =?utf-8?B?RVVFUTdZaEZ1SXNqNmlUYmQralJBQzNyVXRBanVmbHc5ZThPMlh4clRBUllj?=
 =?utf-8?B?STYzSzhQNnJpWUNYd0FnVTJ3SEQwOTVGaXhVdmhEVHpTNi9LZmZGYzJyWmdX?=
 =?utf-8?B?bkFac1oyRit1YWRGd0VHUUZibWFyOGs0dGkxRjROOFhKUDYzR0JBMVNsdWVs?=
 =?utf-8?B?aHpJVHR4NyttbmZmZUtFZ0p2MGl2ZFdnOXVKay9QREJaeituVFJxSVVGWnlM?=
 =?utf-8?B?a1RMMURCdzN3UmdTMWx0T29xUkl0MzhTV0NIM015WjdzZ0UveXdyWFVTQnht?=
 =?utf-8?B?SVpDZ1hsalNIZnkwUVRIVjhXSThOaC9MWEpIU09wM3MweGdmNm1tT0NvSDJy?=
 =?utf-8?B?WTUwb0h1aTdMRURwVTR6cG1ySnMxblNPTjVxT2hGUjFKL1BVSDM2KzNkVUI1?=
 =?utf-8?B?VTFMQ2REMXF1TUNWaFl6RVFTMW9LOXdPSnRyNTEzdStzWnIycUZQK1hPM3lr?=
 =?utf-8?B?YzExejlORlpRekYzaC8vWTNtVm92bzliNE9PZmo5RGo1aUJ2SVNpS1BSYS9u?=
 =?utf-8?B?NlZNc1dJcUllaEdiU3ZoK2tFQnZxeVZ4VkYyeFhyTHBTbmZNdlJ2NVI2OUJn?=
 =?utf-8?B?Vmh1ckNLelFiYTBEaGVEV2dCeUVPRG1qUFQ3OW9hSWxtbzBTRkRDS3JObnZG?=
 =?utf-8?B?ZC9lb2VDeU1RT0x0eEQ3UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1RpY054U1VyaG96bUIyMDZBREJwNFBDV3lUZlM0ZjBUVDBpVGpiVnhqRjV2?=
 =?utf-8?B?bjAxN3lMbHZFdUJDK1I4SXI5MUl2MjMycGhMSlV3SGEwaDdQWlVoaE5BZlhq?=
 =?utf-8?B?N09zUXBSaEthNW5GaW1XdkYzNnVEZkw4NEk5OXFucGxlS0VuUjlPa0xOVzFp?=
 =?utf-8?B?cWN4ZmlzVDB1Vnc3ZTB4WlFSV01nTHltUnppbTJId05Na3NsYUlzRkMrd2hT?=
 =?utf-8?B?Z3ZCb1huZERseUppRE1zRjJpMzNTRzhjemxwYUJBVmZYWDg2NXpTSVNBSWNo?=
 =?utf-8?B?YWt4MHZYWmRtN3NuZ2Y5ZE8zRjF6QTVicmdraEN6T3kxbVI3d1ZNSjdHaG9E?=
 =?utf-8?B?Nmw2cGRrSlZVOWNqdVJKZjAvNjh0cmI2bWtzYTR2RVViUTZrMDE5N3gwLzZp?=
 =?utf-8?B?c3c3ckZwNnNRRDNSVDFpcEtSaFk3Wks2Q1lENks3bE5hZzVJclEwam5YT09V?=
 =?utf-8?B?ZWtyZVQ5VmduTER2bk02d3l0cHF5UnVvek1XNzdIUk9HR3g4SDhjZW9hOEpQ?=
 =?utf-8?B?WVNvK1QxSDZqQnlaSTFSdWN4aGxyRVJVNGtWYzhuQTB0c0ZQUVV4YnAvZzdI?=
 =?utf-8?B?dm1CTE5qUlVzWEhvcTQycGdCMFEvMlloUnpYcHdaMEJTaVdCTUhMUXFub0Nj?=
 =?utf-8?B?bmNsSEZXdmlmSk5GQWNVMmgxV014d2M2bHdEckJEYWt0WHNkWXFUSStqUTRn?=
 =?utf-8?B?TXI4Ym1NaWJyZWRhOUhzM3oyS0N4UHBjUjRhMnJGQ2VwZzFtU3VNSG05Q1VX?=
 =?utf-8?B?VUhyN1lZcWRIM3NPVnJrcUVyUDR3S1haMzVoS3NwcXBHZ0IwdjB3WnVqNUFw?=
 =?utf-8?B?dTRraXhINzhDOVRKejMrbzFDNVNFOCtZSVdEZlBUeVBhbW5QdmF2Qzh5am1N?=
 =?utf-8?B?QnJ5dzVPWFRYeWV0M0JHakwyZmZUMTNnM0IvdGgzcldJN1lLbEMrZElrYWt0?=
 =?utf-8?B?akNQcFo2MUhJQjlBVTVnanBJU0I1d2pYeVhJZU85NTZOMGZNUitZNmRCWDdH?=
 =?utf-8?B?UDRFWjZWL3JrbEtCamxUTDZXQjdKQzNMd0lhSGRpc2NyRnB2ZHRvWGFNcTcr?=
 =?utf-8?B?VWJhTC9aQXJoVnFFNmJUbzEwdCtrNU1YZnNlcjJlRUExQWdBT3JYNkUxVVRw?=
 =?utf-8?B?aW9lSE9rTU5iS0V3cHNSYTk1QU5uamtMZGxkTmk1ZUsxSlJpR3lDbEUxQllY?=
 =?utf-8?B?ei8yMi9oRDlsMFhWU01ZWnc2Ujh0STFBSWRpeEhKZS9HRVUyZmw1SlR0ZkFZ?=
 =?utf-8?B?MDVnaHhIQnVPamhqWUJtN3FKZlJlQW9hcWxlMGFUZjdObStNMUt6cnRiY0Ns?=
 =?utf-8?B?NjBCTk5MQ09kZEFJNEVXQ0szVFpSbWtMK0h5MGpBZVpNQ2JkdmhyQVpSQW41?=
 =?utf-8?B?R0JaNkFlUlhsdHViRDMwYTN4c0loNy9CN0hZQWxLU0RPRmJMd3dwZXFadXdY?=
 =?utf-8?B?WTBuNGRpKzAvZFdSRUgzL1FMQzBOVXdpY2FEQng5QzduY1dxa29STjkvTEJN?=
 =?utf-8?B?SE1tekpQeWVrSFFNTDM2N0l1ZFM2RHEyMXFGM1RkNUJqbFBBUDV3dVVidklz?=
 =?utf-8?B?bWhMT012TFh0L21DQmpzYlVIcEMwY3RzWmhYTk1GV3BMYUxCZ3dhbTR5aHp2?=
 =?utf-8?B?T1JDZTNvNXovRFJyaW52WTRCSm1BMnlaRHN1aDgvMm1oS3U3N2V6WjQydlQ5?=
 =?utf-8?B?elVwT2tHdnMvS0tiTHpPRVE4cE1NZmpDTS9HM2l5MDhJRkFuSkpra21qcDYv?=
 =?utf-8?B?cTUzWjBKV0pxcFI0Mll3YmNpaGpIcTduTzlGeVhuMHVWanBKYnBFNWtFZnFG?=
 =?utf-8?B?dzlUdXJmc0o2ZEdyMnQ1MTRvcmNWK3BaYjNRZ3NGeTBYTFhyN2x1L3haK3FD?=
 =?utf-8?B?a3JsRGVoNlh4cmR3bCsyY2h0NVB6RERjamdDdDg3VDFyN2JyRmFuT2pxS0Mv?=
 =?utf-8?B?SlNHd2JoV293bTBUSDFxN01UYUVyQzRjQ3U3UDhncjV3SDhUQUY4ak9SQUUx?=
 =?utf-8?B?YnVQZENkRU0rOFArN2NsMC9ickhpdmN0OEpKdFExUmxsMTFYOHR5TUU0bnZV?=
 =?utf-8?B?SXNpRXpIYWVJZnR4VmZuZHRaMzRtNVRYU3hpcjNBcSt4aFE4K3FKTHgvNVhm?=
 =?utf-8?Q?As74=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c5e2c5-1cf2-4d0a-ee28-08dd130a5fbd
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 19:49:03.5164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMVI8WAV2A3OIcilHdl/Ezm/v9jLWQjnqzItq5MIpiaZI88cUj6Yg9iQD2+s3hMD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7317

Hi Reinette,

On 12/2/24 12:33, Reinette Chatre wrote:
> Hi Babu and Peter,
> 
> On 11/29/24 9:06 AM, Moger, Babu wrote:
>> Hi Peter, Reinette,
>>
>> On 11/29/2024 3:59 AM, Peter Newman wrote:
>>> Hi Babu,
>>>
>>> On Thu, Nov 28, 2024 at 8:35 PM Moger, Babu <bmoger@amd.com> wrote:
>>>>
>>>> Hi Peter,
>>>>
>>>> On 11/28/2024 5:10 AM, Peter Newman wrote:
>>>>> Hi Babu, Reinette,
>>>>>
>>>>> On Wed, Nov 27, 2024 at 8:05 PM Reinette Chatre
>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>
>>>>>> Hi Babu,
>>>>>>
>>>>>> On 11/27/24 6:57 AM, Moger, Babu wrote:
>>>
>>>>>>> 1. Each group needs to remember counter ids in each domain for each event.
>>>>>>>      For example:
>>>>>>>      Resctrl group mon1
>>>>>>>       Total event
>>>>>>>       dom 0 cntr_id 1,
>>>>>>>       dom 1 cntr_id 10
>>>>>>>       dom 2 cntr_id 11
>>>>>>>
>>>>>>>      Local event
>>>>>>>       dom 0 cntr_id 2,
>>>>>>>       dom 1 cntr_id 15
>>>>>>>       dom 2 cntr_id 10
>>>>>>
>>>>>> Indeed. The challenge here is that domains may come and go so it cannot be a simple
>>>>>> static array. As an alternative it can be an xarray indexed by the domain ID with
>>>>>> pointers to a struct like below to contain the counters associated with the monitor
>>>>>> group:
>>>>>>           struct cntr_id {
>>>>>>                   u32     mbm_total;
>>>>>>                   u32     mbm_local;
>>>>>>           }
>>>>>>
>>>>>>
>>>>>> Thinking more about how this array needs to be managed made me wonder how the
>>>>>> current implementation deals with domains that come and go. I do not think
>>>>>> this is currently handled. For example, if a new domain comes online and
>>>>>> monitoring groups had counters dynamically assigned, then these counters are
>>>>>> not configured to the newly online domain.
>>>>
>>>> I am trying to understand the details of your approach here.
>>>>>
>>>>> In my prototype, I allocated a counter id-indexed array to each
>>>>> monitoring domain structure for tracking the counter allocations,
>>>>> because the hardware counters are all domain-scoped. That way the
>>>>> tracking data goes away when the hardware does.
>>>>>
>>>>> I was focused on allowing all pending counter updates to a domain
>>>>> resulting from a single mbm_assign_control write to be batched and
>>>>> processed in a single IPI, so I structured the counter tracker
>>>>> something like this:
>>>>
>>>> Not sure what you meant here. How are you batching two IPIs for two domains?
>>>>
>>>> #echo "//0=t;1=t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>
>>>> This is still a single write. Two IPIs are sent separately, one for each
>>>> domain.
>>>>
>>>> Are you doing something different?
>>>
>>> I said "all pending counter updates to a domain", whereby I meant
>>> targeting a single domain.
>>>
>>> Depending on the CPU of the caller, your example write requires 1 or 2 IPIs.
>>>
>>> What is important is that the following write also requires 1 or 2 IPIs:
>>>
>>> (assuming /sys/fs/resctrl/mon_groups/[g1-g31] exist, line breaks added
>>> for readability)
>>>
>>> echo $'//0=t;1=t\n
>>> /g1/0=t;1=t\n
>>> /g2/0=t;1=t\n
>>> /g3/0=t;1=t\n
>>> /g4/0=t;1=t\n
>>> /g5/0=t;1=t\n
>>> /g6/0=t;1=t\n
>>> /g7/0=t;1=t\n
>>> /g8/0=t;1=t\n
>>> /g9/0=t;1=t\n
>>> /g10/0=t;1=t\n
>>> /g11/0=t;1=t\n
>>> /g12/0=t;1=t\n
>>> /g13/0=t;1=t\n
>>> /g14/0=t;1=t\n
>>> /g15/0=t;1=t\n
>>> /g16/0=t;1=t\n
>>> /g17/0=t;1=t\n
>>> /g18/0=t;1=t\n
>>> /g19/0=t;1=t\n
>>> /g20/0=t;1=t\n
>>> /g21/0=t;1=t\n
>>> /g22/0=t;1=t\n
>>> /g23/0=t;1=t\n
>>> /g24/0=t;1=t\n
>>> /g25/0=t;1=t\n
>>> /g26/0=t;1=t\n
>>> /g27/0=t;1=t\n
>>> /g28/0=t;1=t\n
>>> /g29/0=t;1=t\n
>>> /g30/0=t;1=t\n
>>> /g31/0=t;1=t\n'
>>>
>>> My ultimate goal is for a thread bound to a particular domain to be
>>> able to unassign and reassign the local domain's 32 counters in a
>>> single write() with no IPIs at all. And when IPIs are required, then
>>> no more than one per domain, regardless of the number of groups
>>> updated.
>>>
>>
>> Yes. I think I got the idea. Thanks.
>>
>>>
>>>>
>>>>>
>>>>> struct resctrl_monitor_cfg {
>>>>>       int closid;
>>>>>       int rmid;
>>>>>       int evtid;
>>>>>       bool dirty;
>>>>> };
>>>>>
>>>>> This mirrors the info needed in whatever register configures the
>>>>> counter, plus a dirty flag to skip over the ones that don't need to be
>>>>> updated.
>>>>
>>>> This is what my understanding of your implementation.
>>>>
>>>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>>>> index d94abba1c716..9cebf065cc97 100644
>>>> --- a/include/linux/resctrl.h
>>>> +++ b/include/linux/resctrl.h
>>>> @@ -94,6 +94,13 @@ struct rdt_ctrl_domain {
>>>>           u32                             *mbps_val;
>>>>    };
>>>>
>>>> +struct resctrl_monitor_cfg {
>>>> +    int closid;
>>>> +    int rmid;
>>>> +    int evtid;
>>>> +    bool dirty;
>>>> +};
>>>> +
>>>>    /**
>>>>     * struct rdt_mon_domain - group of CPUs sharing a resctrl monitor
>>>> resource
>>>>     * @hdr:               common header for different domain types
>>>> @@ -116,6 +123,7 @@ struct rdt_mon_domain {
>>>>           struct delayed_work             cqm_limbo;
>>>>           int                             mbm_work_cpu;
>>>>           int                             cqm_work_cpu;
>>>> +     /* Allocate num_mbm_cntrs entries in each domain */
>>>> +       struct resctrl_monitor_cfg      *mon_cfg;
>>>>    };
>>>>
>>>>
>>>> When a user requests an assignment for total event to the default group
>>>> for domain 0, you go search in rdt_mon_domain(dom 0) for empty mon_cfg
>>>> entry.
>>>>
>>>> If there is an empty entry, then use that entry for assignment and
>>>> update closid, rmid, evtid and dirty = 1. We can get all these
>>>> information from default group here.
>>>>
>>>> Does this make sense?
>>>
>>> Yes, sounds correct.
>>
>> I will probably add cntr_id in resctrl_monitor_cfg structure and
>> initialize during the allocation. And rename the field 'dirty' to
>> 'active'(or something similar) to hold the assign state for that
>> entry. That way we have all the information required for assignment
>> at one place. We don't need to update the rdtgroup structure.
>>
>> Reinette, What do you think about this approach?
> 
> I think this approach is in the right direction. Thanks to Peter for
> the guidance here.
> I do not think that it is necessary to add cntr_id to resctrl_monitor_cfg
> though, I think the cntr_id would be the index to the array instead?

Yes. I think We can use the index as cntn_id. Will let you know otherwise.


> 
> It may also be worthwhile to consider using a pointer to the resource
> group instead of storing closid and rmid directly. If used to indicate
> initialization then an initialized pointer is easier to distinguish than
> the closid/rmid that may have zero as valid values.

Sure. Sounds good.

> 
> I expect evtid will be enum resctrl_event_id and that raises the question
> of whether "0" can indeed be used as an "uninitialized" value since doing
> so would change the meaning of the enum. It may indeed keep things
> separated by maintaining evtid as an enum resctrl_event_id and note the
> initialization differently ... either via a pointer to a resource group
> or entirely separately as Babu indicates later.

Sure. Will add evtid as enum resctrl_event_id and use the "state" to
indicate assign/unassign/dirty status.

> 
>>>>> For the benefit of displaying mbm_assign_control, I put a pointer back
>>>>> to any counter array entry allocated in the mbm_state struct only
>>>>> because it's an existing structure that exists for every rmid-domain
>>>>> combination.
>>>>
>>>> Pointer in mbm_state may not be required here.
>>>>
>>>> We are going to loop over resctrl groups. We can search the
>>>> rdt_mon_domain to see if specific closid, rmid, evtid is already
>>>> assigned or not in that domain.
>>>
>>> No, not required I guess. High-performance CPUs can probably search a
>>> 32-entry array very quickly.
>>
>> Ok.
>>
> 
> This is not so clear to me. I am wondering about the scenario when a resource
> group is removed and its counters need to be freed. Searching which counters
> need to be freed would then require a search of the array within every domain,
> of which I understand there can be many? Having a pointer from the mbm_state
> may help here.

Sure. Will add the allocated entry pointer in mbm_state.

> 
> Reinette
> 
> 

-- 
Thanks
Babu Moger

