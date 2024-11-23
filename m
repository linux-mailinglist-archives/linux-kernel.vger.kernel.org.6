Return-Path: <linux-kernel+bounces-418879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC5D9D669F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 01:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2C0BB21B68
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 00:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B051FC3;
	Sat, 23 Nov 2024 00:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kgotgtLl"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D7E6136;
	Sat, 23 Nov 2024 00:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732320591; cv=fail; b=MExDPcx4a6kJocLRjphO8gEn3BYJXsfpGsl2K3oG8AVjnM/FgOoQUXmWFityjKUIUEcpDy8Zn85BY2juRdJd+6YUeq85bdbEFyDEOqOeFp8e+vt45yiooeyMAZ02EZM/5dEuxf2nwc5jHp+dUJJSxV8kxi+eXdtoIRJ4pXL0Fx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732320591; c=relaxed/simple;
	bh=z7q27yiQNF1bINNhp10MQG4qWM9gEYNNwKxhaGWiUzc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m3ZMLE+CEpceF66Z4925KWlAccd/YoHYB68Gm2JbgwkeWQtZSxqvgyTFnD19DVmbKUdVTdq6j/kFjnvJer1TZjOhhO+r8gW9F6c4lzjX6YEVFfqtqyNpP87SPPySX++/tejlKwBAjYPbRNAyKTFBzSpBd9w9oXTJWMdQZLxjpm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kgotgtLl; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UcQAmfup03RB82xwtjfSSOeQ6oWVf6AvesVMG+S/iaEB0gN6+c3+sYjZQCsDsNfixYp2aELWYEJDhrltZ68SrTDgi7McCfANkyjPUTR0UVvgyPJaEgBQGxLkNMdVCOxZPe0f7GpQHzB7QwNBvY5Op43AazsAwqeXUXvCKolTFt6N8AdI/TakxRL++/FLhtWEjkBjQfe6R+bc7U3GqiSZ6BtmORXTVr0wrswQ6o1ioyFQyqIgol2aGmIrjcSSuAbkVDjZXWWPXAHoiWywBtal0xEEneYt1gaKxlruw05PrCXQoq00PVPrlSmW9JT5oACQxIdyTb62Srr/IjnvS7vZpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Q4tQ/47/Vf8dnTdVznxsGa3dnvJ+dQ1/fQNpP/bWsg=;
 b=L0TCZVQRb2otMUBleBC2be3z3n58auBqXJxH32hiHoOWBPfvOLAJqgAMYqf4H7CTFvih2TJfL2U/YHiUeeVroIuHrV/EC5Z5GVHp3X7YT1cOoQsyBv4OchwH20m+T+sBDA1N3dcJnTBvAj0sy5ceHlXd2Ny6Ccy7F6Fu+DQAa/m7I+zmBHqUOe7QDREuLuwMN0ZJyBeSPEEo7IRKe1bsxIIT+9ONl4aDVY6YlC19DjpXrC6ibgovqzJjfXW2JO/nmAvWJDOwyYSOqgLNV/3WHVY+zyEng/qV3MPMFkIPNPJtxZlrqTkaRebS+13FqmeqihYIjwhIbRSgIz/ybHk8qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Q4tQ/47/Vf8dnTdVznxsGa3dnvJ+dQ1/fQNpP/bWsg=;
 b=kgotgtLlkItS6SsCvZL2VsZslNoSKjI4Lmd84VLHjnC5GJdbvFgJHly+NO3tQtcW3mWTibVwUbaJysnQDQHRXR+xvP3THqv6abra8Us+BDp1S70llP3LtBUx9TD+NpyjVojlSRBVDEUg57+ScSqjlWoF6GwNr8p/7h6nflX/Y3M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB6209.namprd12.prod.outlook.com (2603:10b6:208:3e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Sat, 23 Nov
 2024 00:09:45 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8158.024; Sat, 23 Nov 2024
 00:09:45 +0000
Message-ID: <3d162f99-2fa8-4034-80a9-ea7ea43fda0b@amd.com>
Date: Fri, 22 Nov 2024 18:09:40 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 18/26] x86/resctrl: Add the interface to assign/update
 counter assignment
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
 <3851fbd6ccd1cdc504229e4c7f7d2575c13f5bd6.1730244116.git.babu.moger@amd.com>
 <1757cedb-e5b8-45fa-9b70-4c78b5770624@intel.com>
 <77f808e3-1dea-4a85-b574-dcdcb03697f9@amd.com>
 <7fe1298c-d026-460e-aa0d-76144abce524@intel.com>
 <2e774d31-d63c-4bc8-b88a-1cee74533a5d@amd.com>
 <f4e2012d-8f1e-4d01-bab7-178575028db3@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <f4e2012d-8f1e-4d01-bab7-178575028db3@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0161.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::16) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d72ebd7-5a7f-41bf-cd2a-08dd0b5322c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGg3NjMxNnlITm9ZQm8xQXE5KzhLNjhSdlBxOEFDVTAyKzFacGZyQXRDeTZ5?=
 =?utf-8?B?YlJteDZqeWp6eU1VYUVjZE91QnlsaEo0R0xza0NlQUNIdzg5SEZBZ2xtZTdj?=
 =?utf-8?B?UnNmMkkrREsyTmx0eDc3VmlLTHhjMnBpYkJhUHF2ZHRjK21IUi9QTzJXcmZs?=
 =?utf-8?B?dGlrWTRWVG9ZaXlTa01kaUpXdU4rOGpzYjhWYndPMWoxQnMrQVlSOUhsQlRT?=
 =?utf-8?B?Ylk1TVNMTndiYmFlOHRTbVFxUzg4eFBRbXZ5RlQzSWh1WEpZWDFhbUZhVHNa?=
 =?utf-8?B?S1VHN2FnSEhqdmJQeEdoQkV2bGV3cVo5dkZ5WjJ1UmNlWnliaTI4T2s5d3gz?=
 =?utf-8?B?dnN4S0ZPMzdFNWg0UFdQSktHbGRuOGFwNHhIQjlGMzVaM1dNSzY4dXlpaUZH?=
 =?utf-8?B?a2JEUHEzeFo0ZlVjUGZpcTN3Wk0xMHBaU3dRakhSdXUvVC9QNDRLVDVTZDlI?=
 =?utf-8?B?d0tOK0IweE9PSlN4YURUTEp0UWN1ekcrM0lYR1owblFWZjZQRkoyekIwcTNP?=
 =?utf-8?B?VXU0QWNIK2krOGFFWldSc0JSTU9ldUk2RDR6blFSemZRakdGcmxYdVloSWVF?=
 =?utf-8?B?SWRaTlRIMmcrR1lHejZSVDNjUkVRUHBZZklIeE10Vm04Y0J2UnR2dlpsU2pE?=
 =?utf-8?B?U1I1M3NvajcxRVB1aDNmcVlxenpGZ0VnV2NQWURTcXNiTk10Ykhta0c3clN1?=
 =?utf-8?B?TGFUa21RSHpnL3MyRXl6ajVhREw3Uk54N0hFNnovM011TmpJWmhtSy9vcStD?=
 =?utf-8?B?RGZ4SUN3Q0hrcSt4bUFlczdXd29zeVZ1QXRVV1JVUnZ1UzJHUyt2dE1ZWWtL?=
 =?utf-8?B?b2tiQVIyd3YvVHdudFlLYXZuRDd4azloLzNFNWZqczkwME9nV2NYRDkwMkM5?=
 =?utf-8?B?NFgvQ2hJdjlmUGFCSi93bm5yR21KQWtWbG1TTDhnQXU5QUduUnc5b2NOcmdy?=
 =?utf-8?B?cTdEa2MrdGcvb2E4NXdOMzJCbTlSejlOR1Y1VVV2SEF2c1RMM1VZRjhTVkpx?=
 =?utf-8?B?ZGZUbjZZWVRCditoWlFxMVVhSGJ5RDBuend1OTd1N2hDVjRoMTZSdW5OT3Ru?=
 =?utf-8?B?TFFQMUpwWXh6a085blB6eGYrUDF1YUNPODhVcGZJdkhzdEtPQ08wUWlodk5j?=
 =?utf-8?B?UlovdmtFUkNRbVZ1NHliVVpzd3h2QzJSSGpIMVFuZXp3cFVURVRXNW5aVWZG?=
 =?utf-8?B?WlB2Vm1sYk1SOGlGeFpEMDdjQzlFZ3g1VGZuMHdSSEFUOHE5amN2aGw4dmF2?=
 =?utf-8?B?dS9WT0p4ZVo3NG1QU3huTXhTSzNVbXQ2RkdCMGdaM2tHZU9SbE1SUEc0YWNr?=
 =?utf-8?B?V1F5bkZHOFJpRFVpSzkxY2V1MjE2ZDZRNWRPMG5wdkN0d09qWUlHdU1ZMUYw?=
 =?utf-8?B?MmtLS3ZQclVCbWF5ZXZnclRhZmRvZjlHLyt2T2xYNUZLZlF2MDUrclZJaGhM?=
 =?utf-8?B?THVQbTJXajJiRUJaZVBQTlpVUnZFKyt6Y1k5TFBTUG5RbFZxUFhDdlFRT0dR?=
 =?utf-8?B?ak5IWHBzNThEd3FSb2tZRlIxdk1STnVlbDlzVXNIR3BpMm9xbXh5VlprdUdN?=
 =?utf-8?B?ZkRheS9oQ0tEQTFWK1BqdTVNM0w5RjlCYlNNNi9iS0YzMEZPaUtJTEtPcS9J?=
 =?utf-8?B?N2JobHEzSmhHS2lZWUlrRm1JNnRSVUsyVlRxdDkxWERuQml3UzM0QVVsYjVj?=
 =?utf-8?B?WTVFSUh5c0tnRFVZaitlN05ZaVZ1M3BWUnMyK3hTZkF2RDMxZ1hmUEpSamhL?=
 =?utf-8?Q?VNs/P/V/fVgA3zWfaAy8YuTokFQ9atlZgTkZCM1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWNaaml0OUNVVCtGeUt3UU9INTA2Tk9WY2lnTDlnRHJyaE11dG9ZRCtUakt0?=
 =?utf-8?B?VnJUaUpOUHBLdVk2cUt2YkJpVEQrUGp6NjNGQmlQUzVpQnRxdkM5a3g4K1RN?=
 =?utf-8?B?b3BvVE0vNEZUWTlraFczd291Q0JzMk5NdkRaV3d4akc0aFhyR2NoVk1LcEd3?=
 =?utf-8?B?aURqTEVYZzQ3Zm9BQ3RxYm1nZjRvMDQ1NzVYNEM1VVM4MFNJUGpXUUtaaWg0?=
 =?utf-8?B?b0hIbVJIMU9JR1hSUW9YWm1HbjUzeGxyZmlZU3IzdWJMaDFKSFRPZ0dxZ2t2?=
 =?utf-8?B?ajhkcTkwNVY2TkhySUh1dWNBa29rMXJjaXZmRGRveVhlRVJlbHl3MmVsQlJi?=
 =?utf-8?B?RGFmbGgzbVd2V3hjRkh4U2dmT1ZieWhFY0ZoSDVSazRQWEV6UzROSjdIYUsy?=
 =?utf-8?B?bnlwTmY2cmNyNDRFMjN6dThQYjF3ekw0SlFlaFYvOE5Hb0dKRFdQdDgvbHNR?=
 =?utf-8?B?KzlLdCs2NjFGSTE5Q01BVFVqSzByM1lFaHBTQ1owZUlhR1VGSTJ6NVVlSm95?=
 =?utf-8?B?N1ZGZmpWdnJyNEhKVCt5SkVoamJIYks2d1pHeUlXYkJVZGUwdkwwN0ZGZmIw?=
 =?utf-8?B?ZEJmUlRScWZ5NmdZM3RhdTlJLzIyTE9HSWFLd0tiRHIrWmREZ0FTQUxwdnJN?=
 =?utf-8?B?VGkxMnlHZGJVM0FUdm9ac0l3aE8rQVRJS0JSbWhvdW84Nmd6aytvang3ZkFX?=
 =?utf-8?B?N0hTalBJUmpnS21YNmVRdTRoTDFCenNpOEx6bmZNN1JPTHgyQlJmZE5KNWlU?=
 =?utf-8?B?OEJnRjRyb3doci8rOWtjbXBoWVpiRi9maFZyUm1EMmlmS0xjNnl1VkREakFs?=
 =?utf-8?B?RjRRU2lkMnIwdVhQZk5QR3pUNXFvSGVhdHdaSVI1bzFUY2UwWDlmQ2JlUE9I?=
 =?utf-8?B?TGRzSjAyMDlSeFhFU1Y4RFVwTTVkTUlJaXd4Z0paanM2UDd3UDFVWWtrMExt?=
 =?utf-8?B?c1pKQVcxMmwvUG5jYWJTdDJ2VEllc3FKQmlGVWhkWFNMaU9JK1ZtbnJMc1lx?=
 =?utf-8?B?OTF5NXJFUTNJT3hyTW44SDBkNjdabEc5b21nSE1MMk8wMCtzU01zM3EvM08r?=
 =?utf-8?B?K3UxS3hWQkVWWGFqcUFNbHJDVHYxMEF1VXhvOUxLTzdBa0hSUDhPS2FWNW8w?=
 =?utf-8?B?UnF6cW1YSCt5S01tcDlwZ0VGWjJjekpEZUVQRTZrVExGbGdaZXpMbUxBWi9X?=
 =?utf-8?B?UkZ6ZE9EVFhnYmtrcGRNbHkyYS9EMEZwUjkrTGxQWTJ1ZlBrdktKT1B4VDJU?=
 =?utf-8?B?anhOVkxRUCswVHZraWZmZzZtK1p2anhXTVorQUJsTHNzb3ZYZ096RS8zTFE1?=
 =?utf-8?B?SGxXZDQzUjh2QzlhMmVXcFZWQVNEZnd1a2ZaNnpwNTlDRFRRNFJIL1BXUGhT?=
 =?utf-8?B?UjgxRFJXSnpmTlZ1RGpGVm1tK3J5Wk5qeitiUVIzbzVaRjJIUTZKbnU0Z1NS?=
 =?utf-8?B?eTBvQyt0QlZqUWs4bXpidzduekN2d1BjTzNxcXhvWFl1ODc2blNqYjhFWE1U?=
 =?utf-8?B?RzN4NjJ2RmZTZll0eFRTdEg4RW1ydEc4eW0vam1yR3pJQU4rWWVlRkQzQkIx?=
 =?utf-8?B?MFplUTdJSmhDblZCck44UmVoQUtoK1RsMXVsYlJybVVqVlJCUG00OGhpRmhp?=
 =?utf-8?B?dzBqV0VZMkg2QTVTazNSdm9Xazlyb2YvaTQwOWo5LzU3LzFkajhIeHZneE16?=
 =?utf-8?B?MUJnV0o5TVZPcGVjOGpBWEZOT3dmeWFLbnMwNURhWUZiNE56YVN6VHEvakly?=
 =?utf-8?B?THVFeTVBM2xLV0Ftcm85dTkveWpzamJsSVI1bnBBelRhSEQ5YURnSFJCME4v?=
 =?utf-8?B?OExUVnhlSDFKWVAwSnB3bklvNW0vOEtsbndxQ3hwbnE0ZEh3b1ZuamtkVVBP?=
 =?utf-8?B?c0tDTVZkRUhBRTNRMStKdFhLYXFVM0JBK2oyWDVtTzdTVHlqVlpkbmxTejZF?=
 =?utf-8?B?c0NFZk1JT2kwN1pqVUtLTjVnVDNBYW03d3NJMGl4TkxPVlF4ZjdQS2hvbE1M?=
 =?utf-8?B?UnZBRFF1UDByK3ducmtwU2FHV0UraTFDcGJwSHRmbFcyalU1OTluWENqNFhU?=
 =?utf-8?B?LzBmTWxlb3phaUtlcDl3VUxhNklObTNjZXRrMTBVby9CZjFzcWViQktCOXdR?=
 =?utf-8?Q?+bnk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d72ebd7-5a7f-41bf-cd2a-08dd0b5322c6
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2024 00:09:45.2701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SGeqjNyaJbptfDhQmlmczFSE01oRS1ISTqrqc1GjchZ2mGVJ38C7BrB4ZSAv2YXc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6209

Hi Reinette,

On 11/22/2024 4:07 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 11/22/24 1:04 PM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 11/21/2024 2:50 PM, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 11/20/24 10:05 AM, Moger, Babu wrote:
>>>> Hi Reinette,
>>>>
>>>> On 11/15/24 18:57, Reinette Chatre wrote:
>>>>> Hi Babu,
>>>>>
>>>>> On 10/29/24 4:21 PM, Babu Moger wrote:
>>>>>> The mbm_cntr_assign mode offers several hardware counters that can be
>>>>>> assigned to an RMID, event pair and monitor the bandwidth as long as it
>>>>>> is assigned.
>>>>>>
>>>>>> Counters are managed at two levels. The global assignment is tracked
>>>>>> using the mbm_cntr_free_map field in the struct resctrl_mon, while
>>>>>> domain-specific assignments are tracked using the mbm_cntr_map field
>>>>>> in the struct rdt_mon_domain. Allocation begins at the global level
>>>>>> and is then applied individually to each domain.
>>>>>>
>>>>>> Introduce an interface to allocate these counters and update the
>>>>>> corresponding domains accordingly.
>>>>>>
>>>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>>>> ---
>>>>>
>>>>> ...
>>>>>
>>>>>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>>>>>> index 00f7bf60e16a..cb496bd97007 100644
>>>>>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>>>>>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>>>>>> @@ -717,6 +717,8 @@ unsigned int mon_event_config_index_get(u32 evtid);
>>>>>>    int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>>>>>>                     enum resctrl_event_id evtid, u32 rmid, u32 closid,
>>>>>>                     u32 cntr_id, bool assign);
>>>>>> +int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>>>>>> +                   struct rdt_mon_domain *d, enum resctrl_event_id evtid);
>>>>>>    void rdt_staged_configs_clear(void);
>>>>>>    bool closid_allocated(unsigned int closid);
>>>>>>    int resctrl_find_cleanest_closid(void);
>>>>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>>> index 1b5529c212f5..bc3752967c44 100644
>>>>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>>> @@ -1924,6 +1924,93 @@ int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>>>>>>        return 0;
>>>>>>    }
>>>>>>    +/*
>>>>>> + * Configure the counter for the event, RMID pair for the domain.
>>>>>> + * Update the bitmap and reset the architectural state.
>>>>>> + */
>>>>>> +static int resctrl_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>>>>>> +                   enum resctrl_event_id evtid, u32 rmid, u32 closid,
>>>>>> +                   u32 cntr_id, bool assign)
>>>>>> +{
>>>>>> +    int ret;
>>>>>> +
>>>>>> +    ret = resctrl_arch_config_cntr(r, d, evtid, rmid, closid, cntr_id, assign);
>>>>>> +    if (ret)
>>>>>> +        return ret;
>>>>>> +
>>>>>> +    if (assign)
>>>>>> +        __set_bit(cntr_id, d->mbm_cntr_map);
>>>>>> +    else
>>>>>> +        __clear_bit(cntr_id, d->mbm_cntr_map);
>>>>>> +
>>>>>> +    /*
>>>>>> +     * Reset the architectural state so that reading of hardware
>>>>>> +     * counter is not considered as an overflow in next update.
>>>>>> +     */
>>>>>> +    resctrl_arch_reset_rmid(r, d, closid, rmid, evtid);
>>>>>
>>>>> resctrl_arch_reset_rmid() expects to be run on a CPU that is in the domain
>>>>> @d ... note that after the architectural state is reset it initializes the
>>>>> state by reading the event on the current CPU. By running it here it is
>>>>> run on a random CPU that may not be in the right domain.
>>>>
>>>> Yes. That is correct.  We can move this part to our earlier
>>>> implementation. We dont need to read the RMID.  We just have to reset the
>>>> counter.
>>>>
>>>> https://lore.kernel.org/lkml/16d88cc4091cef1999b7ec329364e12dd0dc748d.1728495588.git.babu.moger@amd.com/
>>>>
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> index 9fe419d0c536..bc3654ec3a08 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> @@ -2371,6 +2371,13 @@ int resctrl_arch_config_cntr(struct rdt_resource
>>>> *r, struct rdt_mon_domain *d,
>>>>           smp_call_function_any(&d->hdr.cpu_mask, resctrl_abmc_config_one_amd,
>>>>                                 &abmc_cfg, 1);
>>>>
>>>> +       /*
>>>> +        * Reset the architectural state so that reading of hardware
>>>> +        * counter is not considered as an overflow in next update.
>>>> +        */
>>>> +       if (arch_mbm)
>>>> +               memset(arch_mbm, 0, sizeof(struct arch_mbm_state));
>>>> +
>>>>           return 0;
>>>>    }
>>>>
>>>>
>>>
>>> I am not sure what you envision here. One motivation for the move out of
>>> resctrl_arch_config_cntr() was to avoid architectural state being reset twice. For reference,
>>> mbm_config_write_domain()->resctrl_arch_reset_rmid_all(). Will architectural state
>>> be reset twice again?
>>
>> That is good point. We don't have to do it twice.
>>
>> We can move the whole reset(arch_mbm) in  resctrl_arch_config_cntr().
> 
> This is not clear to me. The architectural state needs to be reset on MBM config write even
> when assignable mode is not supported and/or enabled. Moving it to resctrl_arch_config_cntr()
> will break this, no?

Yes. The architectural state needs to be reset if ABMC is enabled or not 
enabled on MBM config write.

> 
> I wonder if it may not simplify things to call resctrl_arch_reset_rmid() from
> resctrl_abmc_config_one_amd()?

Yes. That is is an option. I can try.

> 
>>> One thing that I did not notice before is that the non-architectural MBM state is not
>>> reset. Care should be taken to reset this also when considering that there is a plan
>>> to use that MBM state to build a generic rate event for all platforms:
>>> https://lore.kernel.org/all/CALPaoCgFRFgQqG00Uc0GhMHK47bsbtFw6Bxy5O9A_HeYmGa5sA@mail.gmail.com/
>>
>> Did you mean we should add the following code in resctrl_arch_config_cntr()?
>>
>> m = get_mbm_state(d, closid, rmid, evtid);
>> if (m)
>>       memset(m, 0, sizeof(struct mbm_state));
> 
> This is not arch code but instead resctrl fs, so resctrl_config_cntr() may be more appropriate?

Sure. We can do that.

> 
> Reinette
> 
> 

-- 
- Babu Moger


