Return-Path: <linux-kernel+bounces-254441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAAC933338
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 23:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B01B01F229C8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8931B61FCE;
	Tue, 16 Jul 2024 21:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KD7+vrdG"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4AE1DA4D;
	Tue, 16 Jul 2024 21:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721163893; cv=fail; b=JhbYdYVevUanwHOHrAFumvvhwnUGZBdiU9VXSgmpK8J+RqhqxBjlJsb63Mv0eOg7XiU8wECcezXlVbKz/GLTqQlCDCpH27uBUYQIh6JDXcSmsFLe/K96nsYfKC4McKEaFNBeOiWcgw7i5U+1ps9ct5XUsIOwc0xepyymshjpdnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721163893; c=relaxed/simple;
	bh=YvYxe0UkWlAjNWoyhwqUsQ5ZSw1KbEv7mOOT2yDS8Ew=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zx+7kaMnJ0Axf+PE4rPJAEyC6zmbhWIKTvIulaby3R6equo9Hg9egcOH7wOEjMN4g5Bzsxpmt5ciLLlrEveztbKdfdxvNjHY3RSS06Vyesk5DVgkjCiKE7TnxRmqfuSJahNiejH1rsjzxz7Ahe64kU6+rghrmdY29dBfeTvpO6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KD7+vrdG; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fRo02oP7XXK3hl39cerQRLo4DoC194ph0trf6jFYwZd4ocyItGP/UKKF9V+42Ony4X+6CUFwpZdlmJkRdvkB/hE8drNvj8xSrLjkHgqP6IWVlasUc9x0aJLFM9cIKGevqB6DJcP3cHi1vr3BXK0PLuwv1BMvuQE5dqzNevFp1/Wwb+YSW8ASVotB8x08qoNecWP1b8Oj7QLwf8D+pa2DOhsZkuvbwNg4fLkin0PSQRbAz52fmh4aMSOVWUEvEO7v5YDgzaxlRx4DG1KM4ieMqNVOGJnsN7DyS46qRFvBrG17gk8T8kkdPNDlMRxGWP+4BwcxuUWqzKJ3UTLMDWQD/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5X3rr7aAU8vQqb5fTxHHVmrwfUBV2AkZQV1CgDZfwM=;
 b=VJ+ud+nNAKXbZx6yQQOWlFy6jctQVyoIRKGg62IiCWIrTv1LcR3CCH7qaqW0jyDhEYb0UI0vlckog4/+9FWsjKIvaLkWbG7P9xz/wlzR6aFA9rS/i5A3yplYhAtac6DrPq4sliq7tMH6c+oXbfopUaJPAVF3q+nzR3fVlTdzVHOJ7y6mnfrBMtn9F/HobhqeWATKBXt+ZfuYyyeBk58naoka5TAdsyQpRVpmVFp6ZEWg+HjURKHrR2dF8n004K8Y/XsWlitMJlxtP+qSofXuzL/rWQiwxvQzIKWNNNxqCbGdRbFkw5nlg9KTxGFb30yOX61DleanF0zvGFKE1dJhOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5X3rr7aAU8vQqb5fTxHHVmrwfUBV2AkZQV1CgDZfwM=;
 b=KD7+vrdGzZWUp4nz2/qqSQK1LWKY/7Lix0FrvPc+i6HOs/ASR8UAQJ2m7DoySKp1lrAKCB3EM2uATD05OMbjta4pqXjuvuu4ji2yUx/0Q6L3a4d62COewOI0WtwH2gj3olgywJeoL7+fmO2FWJWZcG7A9t/gc0RyXWN2DaEHcGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH0PR12MB7094.namprd12.prod.outlook.com (2603:10b6:510:21d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.30; Tue, 16 Jul
 2024 21:04:45 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 21:04:45 +0000
Message-ID: <2ef41d9a-b0a4-4cd4-a63b-8e79a42872d4@amd.com>
Date: Tue, 16 Jul 2024 16:04:41 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 16/20] x86/resctrl: Report "Unassigned" for MBM events
 in ABMC mode
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
 <81ca60c0029ba63fab7cfd6903ad115fad1d29fc.1720043311.git.babu.moger@amd.com>
 <826860ab-e87a-4d2d-8b41-3487a951f759@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <826860ab-e87a-4d2d-8b41-3487a951f759@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR16CA0043.namprd16.prod.outlook.com
 (2603:10b6:805:ca::20) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH0PR12MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: eaec830c-1f4c-4545-e7ef-08dca5daeb5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTFaRzlVcVp3aU1Qb2RjM3N1ZmJqRHBqSDY5WXUyZ3VMRE5VQ2FSYTM1U2J5?=
 =?utf-8?B?KzErQ2JIOHMyRVNoN2tCUm8xZDFwQnFIZU1IUXA2RzhNZXFkbXIyLzRyK25k?=
 =?utf-8?B?STZxUmdTN1pFUnZleFpBeHJrZjY2SmE1bFkwM1BsZEJuTTNxbUR5ZjcxR1NM?=
 =?utf-8?B?NnRoUEkrcDhMclFpT1dnZVlGdDlabXEwZEhFbnlHY3YxK3MvVDVEQjdmTlRC?=
 =?utf-8?B?QmMrNTAveEF2ejNBU3NsWGJEc0p2bnd5S1VRdU44SDBzOFppNXh4SmY0MERz?=
 =?utf-8?B?T2Fha3RnZ2x1MDBGOEFXcFA0U0pZZlFZeEUxamVmVDJycTdkNWVZejdCYXp6?=
 =?utf-8?B?YlZtdDJ3TjAvMFcvd0NBTVR5eThpYVA2UUtLeGl5c051NXU4NTAzUXc1em1x?=
 =?utf-8?B?NUtVSjBBQTJSZFJUOVBRMlZydmV6MFV2SVZ1MU5RNWdQL3JpWDdmMlNsU2hu?=
 =?utf-8?B?Vld2TElkeVE2T3dXVmFRdEFMZmRzN2g5K005SEVDWUJIUmxheWpzaHdBVExv?=
 =?utf-8?B?YWhTaWMxL3FBdjdLbXpxK04rS0lWTlVzeHF2UHl4eEgzTlg0N2dFVXp5bjha?=
 =?utf-8?B?L2RDN0EwRDExcXVlUlErNi9LVnlCbjhvVUQ2RW1ZM2xBRlJtVFhzK0tYcEVE?=
 =?utf-8?B?K2hzYUoxa2ZoeWkrUW9zQmlSUzVJd25QOW1vMi9zRk9udUlvdFkrWkU5QmFH?=
 =?utf-8?B?dmhDdzVHMXFKWVBzaUtIVTRaZzdLOG9RQTd4blhUcGJoUjliWkZ1akl1QnlC?=
 =?utf-8?B?N2xaWVF2RjBCWjFZZEJlZTJ3NnRjbG1GY0ZiZXp3MVdsRnJWTmltMnFiUCt5?=
 =?utf-8?B?cFNPM2FBc25mQ0FxQ1ZhQUlRVitBQmZkUmlVWWpKNDYya1lQVE9ydmhVZlM3?=
 =?utf-8?B?aXNkVmNYWWlYVUR1UTYzMHBVTk9OQjlIaHp0SzM0QUUrbU05OGo1THhqUkV4?=
 =?utf-8?B?aDRxNHV0RUdKZHdUWnhMOG83NXROdkkyUloxNlBmV3NIbXo2WDBZTjh3ZCtC?=
 =?utf-8?B?WUFTL0NyNzhiZXJMcHR2U1FQejR3cEJaZ3NvNkRsREFXQU1SNStHcGdaQ2RE?=
 =?utf-8?B?M1FNYlM4akVNeUVRSVF4OWxaOEFsNmtLTjQzNnNhUDFTWWVrQ2xYVm1aaExi?=
 =?utf-8?B?dmQxZ3ptaTdyMEZiZkVaMElvMm0wWWFMWEJ0WDRtUWZiVG80TUpkUElkS2J0?=
 =?utf-8?B?aDhYL2FyN2E5RUpkYTVOMkFjUDJUMlhjMU9XaFRCZ2hZTEhFdXFrcG5QaE43?=
 =?utf-8?B?c20wekFBSElncnMwWlVmaG5MWG4rWG9PRUp4eWJUVW9JcEsvNmVDcUN4d1VC?=
 =?utf-8?B?TXB1MzNOelM0aGIzUThoY254eEYxckQvRUpoMGZRb2ZJWUtEREIrazEzL0RR?=
 =?utf-8?B?eC93QzBZSG1jeUZyVXFjb2ZhWG9JVUVVWEltNUlFRHExeWdKcy9IWlJ6VlZQ?=
 =?utf-8?B?bm14QkJuZzBKY3UxbmZZU1NSdnczcDZPelQ4Z2RXK3AxaWVhUHU1YnNZQXlF?=
 =?utf-8?B?Um5QYlJSWitKQWVaMU52U2NQY1IvdmduczdUYTVDSVczY09aUWViQnF0Z0dr?=
 =?utf-8?B?QnBGUEVoWHRYaHNqZmVBWDdSd0g5QklaakJIVWF2TzVUbHoxdmgrVFFrQ2hU?=
 =?utf-8?B?c1NLdVVhQlBhODV1MVRmT3gzMTZNS25ma0xLZ2tyU1dWamxHZWR1a2R4QW9h?=
 =?utf-8?B?dWNuOVFYUng1Vllvb05TU2k4aTNTbkZsYzJhRE9jcnBTRjM4cWVyQUdjN1Bo?=
 =?utf-8?B?UGdnRXI3V2E3dXk0RTRsTm1mTUJwNHYyZU1KQjRTUlk2cHZqZHRudTBrYjlF?=
 =?utf-8?B?cHlCWS9JbmJuMFkvOVR6QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVZXcEY1azhjWFVVV2Q4T0g4WHg4ZFRPbGZlcVZsZ2lVdnQyOEpIdkhubWpD?=
 =?utf-8?B?c2RzRGxZWmtqdnNVTkIzVFRHdWdCUXV4U0phVEFWUGJCKzUxQVl3MVhHUFRL?=
 =?utf-8?B?eXdHdkx4K3hiM1RPUVlKRmZ6dTU4cWRQVFI4dG1ZYnFKdnJBUVIxUmtYL295?=
 =?utf-8?B?THd1ZXhhZnJldXc3K1NXaXZmRk85dWtuZ3I0b1BTSmFmTnluUXJGMjNJYmNk?=
 =?utf-8?B?M1ZnZjFUY01PNW90b3NpaU91UC9wY3MyeUpPNzRtT0FmSEs4TlQ5Wko4d2V5?=
 =?utf-8?B?cEREeFFUbVJVd09TVWM3bDZ3TXgrazZkWEFicmNlU29UWE1ESHBjdG5YWFU0?=
 =?utf-8?B?MnNIT1QvWFlEQU14bkgzVWhPdHMrTDFGc0dSUUFRa1NkbXNDeXVlcXd3Vi9V?=
 =?utf-8?B?TFM0RUhWeSsyazgySitRb05CUHdtUTNuaVdWL3dLYWJBWXNMQWtVME1EL2NJ?=
 =?utf-8?B?NEY2a1BpR2E2bEs2dW5HRGVhNnpzTjhRYlU3YVNoNnYyOHhWZXpud0tMb3Vv?=
 =?utf-8?B?c2U2VERQeEp4Sk93RFJiNGRkb3FndnVad3gvWUx3U0tkQzBZSU51STRHWEY4?=
 =?utf-8?B?Y1FreGtJU0tRaHJ1akNJT1YraW9qRTBFNTdmYjB6ZmJxWURFbkgyNTNvc3FV?=
 =?utf-8?B?T2w1NFFUMHJJUVhKeGwyaEU0eTJIRE1NcDh2cEl5TW1YTk1Ndk1JWm1ndXJw?=
 =?utf-8?B?Q09qL2ErZklJOEVqZnFVSFdBRHpKb2xDUm1mSTdiVTFSRUJKRUl5SmxmanIx?=
 =?utf-8?B?QjRwUFdGN25zd0FMZnU3U3UvQzB6eUhnbjA0TkhTbzRNQkpuNTJQZHExdzZ2?=
 =?utf-8?B?V2czc1pvd01XNU5DbWFMM0laa2FhV0hTZXh4SjZocGFJOGlLU0hoengxREUw?=
 =?utf-8?B?MVpTb21nbDFBYVBtRkxma2cyc255MExsdGNsRTNLakpmVkN5eFVJWVJBcVpI?=
 =?utf-8?B?V09oQ3N4VDh5ZDUzdjFwdXBZVjU5MW9LMy9uYndNelppYXJYYTNvS2xLNHN0?=
 =?utf-8?B?dGFEdHlKd3BDRHpMSmZqczVBZWtlcVpuYVI3VVMyZUl0RlZTSjlJdU1RQXVo?=
 =?utf-8?B?d0FJV2h2NGJRRTJLd2JRVW1rWitLNEpzc2pTUFh0aXlma3VSUDBOVzV6cHBX?=
 =?utf-8?B?RlJRRno3Zlk3WG5nYUFJaWcyNldVMVVKTnNOM2ZTcEVkZ3hjRWd2bnhSZmJj?=
 =?utf-8?B?RFlXWWRMQlZ6YjVWR1pHN3FZTTBMUE45cmxjVXJCWWxjcWEzcVdwaW1hRlpn?=
 =?utf-8?B?Q0ZPWjFLWmRPdXY4TmM3dUV3RGJDR2dNcTZBUVpOQnp6cTNFdWVNTDRjSXA0?=
 =?utf-8?B?WGVHNHBtRTFNK0tHNjhRS2MwMFY5WVFNbkQrbUZTTU0yQTBJV2JvejFaVmxq?=
 =?utf-8?B?SUJDRnBFZlhpSkQzN3loZjVkUTQ4UjhHb0VTT3pWUk56QmRGWmdUSDVtUXpK?=
 =?utf-8?B?SFpOUStLSXBJRjFZK2RxRkVBQ1p3eUhBeENoVVpyQmprWGlKTU82YnJGMDRQ?=
 =?utf-8?B?T1BURSs0Q1BYUjllRjFHK2lYdndtdXZ4QnF3WlA4LzFCaTFFbVhLTzYxU2hH?=
 =?utf-8?B?ckFHZUlreFdGaENGT3NXUFJUL2I5VGxrM2h3QXRFODA2VlBoV2U5ZVQxeVZm?=
 =?utf-8?B?UC9YSjd5TnJCaTBzTERQSmFzV0d3OGYwQW1wOURCTG5uN0JlcHV2UUE0SmMx?=
 =?utf-8?B?YjVZdUlUcGl6MElMTDVJT3JsSE1IbEYrQXpoSzFqcERsUklhUXFrNjZGMHR5?=
 =?utf-8?B?R0ltbys1VXk1L2RBR0FobzVUeUc0OThzelZSREQ1RFYwdjdWeTF2WWJXZFVq?=
 =?utf-8?B?dFJvamRoTStnVnU0dkMxNFZENG5qTjJ0MDhJUDltMlgwOVI1RjJzRDkyS0F6?=
 =?utf-8?B?L2NNM0ducWdUaVQwYXVkamQ2QUlFNDJzcytiOERkVStXUjBEdjNkUDFGbEoz?=
 =?utf-8?B?RFRIQkEzVTF2Vk9KcUt0ZWx5bXJCSFRIT3NvbnBMNDliZElxMml3S0xycS9t?=
 =?utf-8?B?OUFNNGFhS2lkbVhEUHB3RmVvNzdabEdrZHh1L3NoMGhTWm00eUQvL3NtZjg5?=
 =?utf-8?B?Vy9kREhROFAzRG5sb0YrUGtwVkdrYm9KOGlYYXdWdFE3bVc4ZkJYNnpUYjlX?=
 =?utf-8?Q?JNGQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaec830c-1f4c-4545-e7ef-08dca5daeb5c
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 21:04:45.1378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nLuz50U6XBctlygfu4CyMClGKuG8lPcLl3MEJRgcu2X6r4RF2/UE47FMHA6XOqWF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7094

Hi Reinette,


On 7/12/24 17:13, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/3/24 2:48 PM, Babu Moger wrote:
>> In ABMC mode, the hardware counter should be assigned to read the MBM
>> events.
>>
>> Report "Unassigned" in case the user attempts to read the events without
>> assigning the counter.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v5: New patch.
>> ---
>>   Documentation/arch/x86/resctrl.rst        |  4 ++++
>>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 19 ++++++++++++++-----
>>   2 files changed, 18 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/arch/x86/resctrl.rst
>> b/Documentation/arch/x86/resctrl.rst
>> index 4907d0758118..11b7a5f26b40 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -284,6 +284,10 @@ with the following files:
>>       until the user unassigns it manually. There is no need to worry
>>       about counters being reset during this period.
>>   +    In ABMC mode, the MBM event counters will return "Unassigned" if
>> +    the hardware counter is not assigned to the event. Users need to
>> +    assign a counter manually to read the events.
> 
> This no longer seems accurate with counters assigned by default.

But, there are still cases where counters are not available for
assignment. Users can create more groups than the number of available
counters. I will add those details here.
> 
>> +
>>       Without ABMC enabled, monitoring will work in "legacy" mode
>>       without assignment option.
>>   diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> index 50fa1fe9a073..e60b469b7d12 100644
>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> @@ -562,7 +562,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void
>> *arg)
>>       struct rdtgroup *rdtgrp;
>>       struct rdt_resource *r;
>>       union mon_data_bits md;
>> -    int ret = 0;
>> +    int ret = 0, index;
>>         rdtgrp = rdtgroup_kn_lock_live(of->kn);
>>       if (!rdtgrp) {
>> @@ -609,12 +609,21 @@ int rdtgroup_mondata_show(struct seq_file *m, void
>> *arg)
>>     checkresult:
>>   -    if (rr.err == -EIO)
>> +    if (rr.err == -EIO) {
>>           seq_puts(m, "Error\n");
>> -    else if (rr.err == -EINVAL)
>> -        seq_puts(m, "Unavailable\n");
>> -    else
>> +    } else if (rr.err == -EINVAL) {
>> +        if (resctrl_arch_get_abmc_enabled()) {
>> +            index = mon_event_config_index_get(evtid);
>> +            if (rdtgrp->mon.cntr_id[index] == MON_CNTR_UNSET)
>> +                seq_puts(m, "Unassigned\n");
>> +            else
>> +                seq_puts(m, "Unavailable\n");
>> +        } else {
>> +            seq_puts(m, "Unavailable\n");
>> +        }
>> +    } else {
>>           seq_printf(m, "%llu\n", rr.val);
>> +    }
>>   
> 
> This still attempts to read from hardware that is futile to do knowing
> that a counter is not assigned. Why not just print "Unassigned" right away
> without trying to read data from hardware when knowing it will fail?

Yes. I will we can do that. Will do it.

> 
>>   out:
>>       rdtgroup_kn_unlock(of->kn);
> 
> Reinette
> 

-- 
Thanks
Babu Moger

