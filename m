Return-Path: <linux-kernel+bounces-273087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDB2946471
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 22:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F337B21537
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CA44EB37;
	Fri,  2 Aug 2024 20:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BKHK0Aly"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AA733DF;
	Fri,  2 Aug 2024 20:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722631096; cv=fail; b=FLIZZaz7S75XKYpKhgyrEXaOXCkeHhETi6/CU1GpXwKjWR8bucx1AqleJlWx7jcw67NLmkjce8YY9G1Pj7cgnPOKeAGH9I79SPNb9lfEkKJ/V/cSv5CYEIYQJ686gNKn3gsWt7bQ8Hpw4xtGto721qrSc0Fa6DpkQamhzTQexSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722631096; c=relaxed/simple;
	bh=6A4JpvCjRnDVEw7D5iI7/4DHymmFdxx3YHusaOIfKgU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NModoQvABk1LPDh9bDlF7RR0UtVNDDum8XQR83HeKqKEZO1kDate2T3Wx3RQIe8HC+2y9nqn9qaZSPknVaEsEppmygcGL8KUsqzRvzWTXtOsl9Teu6uJeANw2bEEJ2tuXjwsxRVlYSqDsyC5OusIZwuW00us0wIxggh9gRO5kCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BKHK0Aly; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySCXj5vUySxCHMLJg2kPPruLn7oJTU46de09tHH6dHRLYw4SscwRYcsmb8Ajzi/jSZIJJTbmO+/gVYdJoyL63oll+dL6Vz0Hh2In9ua35cMHOE3DPh5QJY2mhniNmKMOU+Ln8zO5YVe6fZL55eLpmb7R91eQzxsIDeJgk2vQhi/e/KQGxaBCtR0Mj223ym5TGvrXROGNsIvkWiv7cYCR4HSZhXgcp8uZHvQN2yoDu7gt7/9oj37lztYnNVSVUuXskKrc9oUEQHJEzR9hJ59P9T4T5YSdJHr4AFA3yLf5zeP35bDpdbjGgdw7QmsKAV/QK0aI9I9Sy/DHYHj/+DYGGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wbDQb6ufSBPWm/BAboa3KRwcx56NWTxdsN/54dLVVU=;
 b=RSg0q8hy9+wtdnJoXHDHnsvq5ie+8AwwWBnq0tARPsuNEy2Wo7pJz0KvnGRq5EbjznDaqjCeO7+pDZMTdF6y4g2Ds3C3citlY/OUkhvK2ufnbWmFDG93FVD7ibR57tR+75VPBrGjPnEoBEQO0HrdjRwSUYakZXk93nK0VpzK3odSe4K1DITz+ZkcrnQyY9FihhsPLqJsuywUTatcXYgP99waVqKpSJhqv/V4xj6y7XBtBI0BO8ln5Ps8ZGT+7PJTytk510zZrgDxuLE+UVoQVOwt1KkdHoF9UBExh1e2ngB6GA67+Dkz8DhWf1qMQWCZN5eb+TVWCTpcpCi73LQ1KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wbDQb6ufSBPWm/BAboa3KRwcx56NWTxdsN/54dLVVU=;
 b=BKHK0Alyt29GTpudY7EVSlCNmVGpZ4WKXXcpRYAbdCGN3d+PlhktZwkqQvmO8Ts/1s0W85DhBAwiOnVu5r/iaAn4//XsEdNAKnJ/vD241FWDqvPuwzB5aZr6pdLTBNvXJdFrQCU8MtJ0aDvVu/Hv4BC0owiY2UjGTN4368aFH8A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 20:38:11 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7828.021; Fri, 2 Aug 2024
 20:38:11 +0000
Message-ID: <afb99efe-0de2-f7ad-d0b8-f2a0ea998efd@amd.com>
Date: Fri, 2 Aug 2024 15:38:06 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 00/20] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-US
To: Peter Newman <peternewman@google.com>,
 Reinette Chatre <reinette.chatre@intel.com>
Cc: babu.moger@amd.com, corbet@lwn.net, fenghua.yu@intel.com,
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
References: <cover.1720043311.git.babu.moger@amd.com>
 <e04b721a-b5cb-4089-a3ad-125a6247e5b8@intel.com>
 <1c50b589-a738-4ae6-8362-bd1ce0d0dc98@amd.com>
 <05b4e345-ad14-4ea9-a13f-2c9b3a6eb422@intel.com>
 <CALPaoCi_TBZnULHQpYns+H+30jODZvyQpUHJRDHNwjQzajrD=A@mail.gmail.com>
 <b3babdac-da08-4dfd-9544-47db31d574f5@intel.com>
 <CALPaoCi1CwLy_HbFNOxPfdReEJstd3c+DvOMJHb5P9jBP+iatw@mail.gmail.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <CALPaoCi1CwLy_HbFNOxPfdReEJstd3c+DvOMJHb5P9jBP+iatw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR18CA0019.namprd18.prod.outlook.com
 (2603:10b6:806:f3::30) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN2PR12MB4272:EE_
X-MS-Office365-Filtering-Correlation-Id: 12c996bd-8087-4a39-6c7e-08dcb3330689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTFIM0hzajNSUG4zZ0NnZVEzcWEyZCtyZlpHSUNsallMczZVYVhOamtFLytU?=
 =?utf-8?B?ZzMyZW1zWjlEOUdtdHZCYlhXcCtibkRabDFYQloxdkxEVWlTY1JQd01qUTZs?=
 =?utf-8?B?YjBjamJaenNMT1FHT0x2em9CQklyOUJJMm5nRmhtbG1oZ29maUs0Zi9ZS3JT?=
 =?utf-8?B?WTVIWHpNbTlFK2dtd2Fodnlyem83TDFkTUJKUEdsSm9vdm9rZk5kMGJIQ3FH?=
 =?utf-8?B?V0szYXJ0N1ovWkRld3V1dUY3RHJoOXAycWR4aG12V1Z0amFTQTJ5Vm9mZDlv?=
 =?utf-8?B?azE3K2V1d29QeU45WUlSZ1B6ekxNTTBOUXhmRjJPZTlDOE1pQ0NqOWNPVFhB?=
 =?utf-8?B?TFVrK0lWWGs5b0xyeFF1dU9CQWpaSFE3TTd3VlJNdmNyblJmZTZsUHRVdnhS?=
 =?utf-8?B?SXBONEpJVnpvci9rWXlpQ2Y5TGlrM2I1V21nblowUVZKaDcwM2NrOElTMFA5?=
 =?utf-8?B?di82RytmWTZPSkJzVGJhMTd3WmxNcUhBMkw4SkxwazNjeDhBblQxTXVjT3lU?=
 =?utf-8?B?b1RVNHRyQVFGY0dYUTBrdXhLT0xOb0RpOXdZSVkrczRqR3RGdFNRN0RzdzF1?=
 =?utf-8?B?VUNwa2lpVXE3MnJHbDdIUzFSM2RucktrNmJXN2s3ZXA5Z1FieUtIVjF3VXNF?=
 =?utf-8?B?UVdoYStQb3FFWmFaSTZvWUwySE81NHpqY01TWkxyaERuME5Jd0pMbXpWbnZH?=
 =?utf-8?B?NmdydzFwckFSSnR3NVdxSU11d0pBajlCSXlPczUvZGNkdUE5M05Zdm84Nlpi?=
 =?utf-8?B?ZzU5K0laLzMxaU5nZDhmbFJycTRTUXdMZG1Canp0RXBaTWNVTWc4UitlOURh?=
 =?utf-8?B?S3hnK2FESFBwaWlvcE45TjNhWkNpeDFPOWZQVC9wVjhFLytjTHB4UEpIbG5G?=
 =?utf-8?B?R0hxMDNkUml3WjFPQ1NyRWJxdVhOSlNZR0EwS1hHd3BCQ2xJRVpGMDdaZkU5?=
 =?utf-8?B?NUc1a0tIRk50WHdqdTJOcjViaE5OU0R3TXVNV1dZK2ZmeDFiWlp6VEc0bExz?=
 =?utf-8?B?NjlQTTZIR1E0VWs3VGk2QU1RNTFhN1pqbm5aRktCUnJKZUVZUzc2UXVFeGtn?=
 =?utf-8?B?U3YrcTI3NHB2ajFKL1U1ZE1ZZ093Y1cxNFB2Z0sxc3psbUY2WGlXdk83ZFA5?=
 =?utf-8?B?bDNrMStHb0xIMmkveUxsM3ZSTHMxdVhDR1lGSDJNaFN3RWw3MS9pcmpGa3dM?=
 =?utf-8?B?MUxNK1IzZTRSTVR6eW5rOC9TMXJBSlV6Z2ZLVllvVmZsRCs0aENIOUgwY2pW?=
 =?utf-8?B?VHAzaGNVb0R5bWx3Ui83NkJ1SjNobXpsczBIVGR6K05kNFlWS3VaLzFSQWYy?=
 =?utf-8?B?WUZKQndLSkM1eTdNdEtlbjNjVWFDck9vN0ZYR0RPbXAyclAzNE84RCsrclVw?=
 =?utf-8?B?RFdURjJ4MXFRRmxab2tTRkpNY1J2cC9GMVBBNStpZjhSRmt3anhmVGpKb2FG?=
 =?utf-8?B?YVlncHpnU3lsYUtsWklrMFVHbkgvalpMTGhsV3Y5Z2hLcVVqVDRHQllVTVh2?=
 =?utf-8?B?Wm9tME1Ha3RqcG5nSFNFdlVQZXcvSkJQNGJwVnB5NHFDcFFxUFArbjkycERG?=
 =?utf-8?B?RitJanROR0dqUitsdUtualQ3bmg1Ui9Ha0xnOUtXWkNhZHAvanVQRytIZ0pC?=
 =?utf-8?B?SDArSDF2WUtxKzZLb1NGRmtHaDdZTUMrc0tuK1FNc2NMYnQva2MxN2VuT0xu?=
 =?utf-8?B?bkk0VFBERTkyUGdzMEV2M3ZKbW5DRk9UTTJqanBKK3dBQWFuS1ZtS1VoOGVG?=
 =?utf-8?B?S2x5bTZIQm5Rd2RTYVNjaUt0K0p3dFRoK292WUwxWFhrNjBkNE53RTJ5RTR0?=
 =?utf-8?B?YU54TVh2UEJPYTllYVRGdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEtHbG9jK2Y3QkZObXFKa0RqQTRSU3pwZ0VHbnd2aFJjSDVQYnAwSEJTSlg4?=
 =?utf-8?B?MjhwY1ltWFpYWTVzNks4a1M1QkIzNE9BcmhheDNZcFVYMHhOb01ydGJNUnlX?=
 =?utf-8?B?aVRCbkc1cmpOQ3dRVFNseWVRRktXUUsxeFpjV05aOWtISDZIRkdrdmo1eDZx?=
 =?utf-8?B?T3F0V0kzMEVXbU1LMFRDaFpwblp1OWdaMHQwekF0MnRFQnN6UHNoWk5TNkdk?=
 =?utf-8?B?MG1raHgwU2xyeCt3Y2gwU1lnaDIvUWFyN1dmci9HL2hMWUFxY3JNd292bGx5?=
 =?utf-8?B?YnM3SlhxazhZeDlCdkZQRDloZkdXYmRTdmcyRDdMOVNIUEV3bzRvLy9hMDNo?=
 =?utf-8?B?SmdqMUNWTC9WRzdKbFFUM3BITmU4MTNNY2FOdXR3UjNwS3kxaTZSanEyQktZ?=
 =?utf-8?B?YTBwMzhoc21uVkNQMTdidithREFleEVCSDc1UGx5OVNwVXRJUVlmOUFIdGZW?=
 =?utf-8?B?dWlpOEdZUDVZYm9EV0ZzVThsZWkvYUNLOXI4L1lzcFFEWDZyTlk5MkQzLzdB?=
 =?utf-8?B?T2czODkrY2FuMlZGZU9aTEZzbEJVZmYwaWxrN0FkeEt5R0xicUw5Mkl4OXhZ?=
 =?utf-8?B?R2xDMGgyNVN1YTY5Q05LR3RSWVdySWZkQmhIdEJSS1hNbHAxNHBtWXRkbWl4?=
 =?utf-8?B?dGdKUmxoOVdSdWFBS1dXNDNaRHVEMnNVWG1jdGljV1VEd3hiV291aGFpK09Q?=
 =?utf-8?B?bVBPbUhsSXRJL2FNTDhqakdQRmMxWWt6ekZrVnVuWHQrRVpZUFhYV2M1clZ2?=
 =?utf-8?B?WHRyaVorclpvRWNIVHhJcy9CRkQyR3VubkV1RVB2UzFtQlpYVFM4M2NIZWZm?=
 =?utf-8?B?bUlPT3psb1pYcnA1NEJFMGxQczg1YkhCa2VFai96U1RySVE3bzdoQm1LaDJa?=
 =?utf-8?B?dlhUWG14dzVIQXBZNjR5Qng5TWdMc1FRenVLWFFhUURBWGlwdXVNZG9EWTRK?=
 =?utf-8?B?YkZzUWN3TTBuOHdoODQ3U0ZXUTRrdDFrU2hRc3M0UlFrRE1MbFZ1L2RHSEdn?=
 =?utf-8?B?WVpqcmoxVVFKSXNnNFlxN2xKY0ZNQlpJb1lOSHlKRmNLUnhiTDhmNngwRUhG?=
 =?utf-8?B?VGFja2NtWTVYbEpZQ2liOHpNYkdNRWhONHNZY1lEc0s4VGdNNHg3TW1xdGg4?=
 =?utf-8?B?c2h2WHVoeTJBNmtNYmkzbmwyaDhKYXl0QW9IekZLOHB4R09GUXZzUkI4ZEZH?=
 =?utf-8?B?T2llTzI0V0VxWER5UGh2TEV1OUU2ZDdxdHJOQmpHaWtsenBBWm51Y2hTOEQ4?=
 =?utf-8?B?cFM1LzBldWdwZUJjRVlYMUpHc245WjZuM25HUFVqeExvZW9kK1BRNlFPSnNL?=
 =?utf-8?B?NnlSMzZCSVBuVWtIeVpkcHVkOThidUtwcFZUMXgxOFd0emlLN28yQzNFR3NC?=
 =?utf-8?B?RWJsb0xiNkFsYXY2clFEWkNCdTlUeEMzUWRoWi9DWG53YkNhRjN1ZWR2VWxv?=
 =?utf-8?B?VWovZlo4M09pUXZONmVhRXdPTXZZYmJyS1JzYnk5ZXFETEc5bmtMUEd6L1RN?=
 =?utf-8?B?SC9VSkV3RXh3QmNRaW1KYkRNOTlzN0RqV2lJMjVhZEhFZ2Y2S1A5azg5ZW5U?=
 =?utf-8?B?dzd0dit3TXJNRy82UFJMMmwyN2syRkZQNGtGMVA1eVFaNzI4V3BJOHlvVWRu?=
 =?utf-8?B?bDEvejViMGFhODRCcENDZnRIUmRkMXVDYWhOYVpERitYekZMVGR0T2tjZnN6?=
 =?utf-8?B?eVB1b1lRY2VRZ0xSWUtyR1dLbjZzSzFBcHZjZDlibFIzZzBXQ0JQMDFhQUFu?=
 =?utf-8?B?UmNWT3B3eWFSdlpQWFBCVTBuK2hOcHlzUktpOTlKeHgwN2Zkc0psQlJ0REpJ?=
 =?utf-8?B?Z3hKNVNIL2U3OHhXd3FxQmJ6cW9nSWtvM1QrbTBaQWpINGVyemgrMk1RbU5D?=
 =?utf-8?B?OGNZZzhqQS9YVXdPZ2phdWxNSFpoRWdCTmR3U3JDbTJWeWQydDBSTVFQZkFh?=
 =?utf-8?B?elExVU5oOEZFSmQ4RTRVVm9OeXY3YnI0WXhZS1RxT2FmdSs0QU13TW1WL2wx?=
 =?utf-8?B?dlhqdnRWbWpDNkFYU3FSb3lWWENoU3VobmRSOWhHcHAwSzloaWYxeE52SU9p?=
 =?utf-8?B?b1Q3MExNM3JEM25rWCtpN3dxSFVsSjAvTS9wb1VwMlVXMExCTk9LVkw4Nkt2?=
 =?utf-8?Q?zDIk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c996bd-8087-4a39-6c7e-08dcb3330689
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 20:38:11.5287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vx9yxfSRyLOo3yRysL6rj0Dv0e+FyhB/2CkHl5PciFL3xnV6s4TL0wJyHao135zu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4272

Hi Peter/Reinette,

On 8/2/2024 1:49 PM, Peter Newman wrote:
> Hi Reinette,
> 
> On Fri, Aug 2, 2024 at 9:14 AM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>>
>> Hi Peter,
>>
>> On 8/1/24 3:45 PM, Peter Newman wrote:
>>> On Thu, Aug 1, 2024 at 2:50 PM Reinette Chatre
>>> <reinette.chatre@intel.com> wrote:
>>>> On 7/17/24 10:19 AM, Moger, Babu wrote:
>>>>> On 7/12/24 17:03, Reinette Chatre wrote:
>>>>>> On 7/3/24 2:48 PM, Babu Moger wrote:
>>
>>>>>>> # Examples
>>>>>>>
>>>>>>> a. Check if ABMC support is available
>>>>>>>        #mount -t resctrl resctrl /sys/fs/resctrl/
>>>>>>>
>>>>>>>        #cat /sys/fs/resctrl/info/L3_MON/mbm_mode
>>>>>>>        [abmc]
>>>>>>>        legacy
>>>>>>>
>>>>>>>        Linux kernel detected ABMC feature and it is enabled.
>>>>>>
>>>>>> How about renaming "abmc" to "mbm_cntrs"? This will match the num_mbm_cntrs
>>>>>> info file and be the final step to make this generic so that another
>>>>>> architecture
>>>>>> can more easily support assignining hardware counters without needing to call
>>>>>> the feature AMD's "abmc".
>>>>>
>>>>> I think we aleady settled this with "mbm_cntr_assignable".
>>>>>
>>>>> For soft-RMID" it will be mbm_sw_assignable.
>>>>
>>>> Maybe getting a bit long but how about "mbm_cntr_sw_assignable" to match
>>>> with the term "mbm_cntr" in accompanying "num_mbm_cntrs"?
>>>
>>> My users are pushing for a consistent interface regardless of whether
>>> counter assignment is implemented in hardware or software, so I would
>>> like to avoid exposing implementation differences in the interface
>>> where possible.
>>
>> This seems a reasonable ask but can we be confident that if hardware
>> supports assignable counters then there will never be a reason to use
>> software assignable counters? (This needs to also consider how/if Arm
>> may use this feature.)
>>
>> I am of course not familiar with details of the software implementation
>> - could there be benefits to using it even if hardware counters are
>> supported?
> 
> I can't see any situation where the user would want to choose software
> over hardware counters. The number of groups which can be monitored by
> software assignable counters will always be less than with hardware,
> due to the need for consuming one RMID (and the counters automatically
> allocated to it by the AMD hardware) for all unassigned groups.
> 
> I consider software assignable a workaround to enable measuring
> bandwidth reliably on a large number of groups on pre-ABMC AMD
> hardware, or rather salvaging MBM on pre-ABMC hardware making use of
> our users' effort to adapt to counter assignment in resctrl. We hope
> no future implementations will choose to silently drop bandwidth
> counts, so fingers crossed, the software implementation can be phased
> out when these generations of AMD hardware are decommissioned.
> 
> The MPAM specification natively supports (or requires) counter
> assignment in hardware. From what I recall in the last of James'
> prototypes I looked at, MBM was only supported if the implementation
> provided as many bandwidth counters as there were possible monitoring
> groups, so that it could assume a monitor IDs for every PARTID:PMG
> combination.
> 
>>
>> What I would like to avoid is future complexity of needing a new mount/config
>> option that user space needs to use to select if a single "mbm_cntr_assignable"
>> is backed by hardware or software.
> 
> In my testing so far, automatically enabling counter assignment and
> automatically allocating counters for all events in new groups works
> well enough.
> 
> The only configuration I need is the ability to disable the automatic
> counter allocation so that a userspace agent can have control of where
> all the counters are assigned at all times. It's easy to implement
> this as a simple flag if the user accepts that they need to manually
> deallocate any automatically-allocated counters from groups created
> before the flag was cleared.
> 
>>
>>> The main semantic difference with SW assignments is that it is not
>>> possible to assign counters to individual events. Because the
>>> implementation is assigning RMIDs to groups, assignment results in all
>>> events being counted.
>>>
>>> I was considering introducing a boolean mbm_assign_events node to
>>> indicate whether assigning individual events is supported. If true,
>>> num_mbm_cntrs indicates the number of events which can be counted,
>>> otherwise it indicates the number of groups to which counters can be
>>> assigned and attempting to assign a single event is silently upgraded
>>> to assigning counters to all events in the group.
>>
>> How were you envisioning your users using the control file ("mbm_control")
>> in these scenarios? Does this file's interface even work for SW assignment
>> scenarios?
>>
>> Users should expect consistent interface for "mbm_control" also.
>>
>> It sounds to me that a potential "mbm_assign_events" will be false for SW
>> assignments. That would mean that "num_mbm_cntrs" will
>> contain the number of groups to which counters can be assigned?
>> Would user space be required to always enable all flags (enable all events) of
>> all domains to the same values ... or would enabling of one flag (one event)
>> in one domain automatically result in all flags (all events) enabled for all
>> domains ... or would enabling of one flag (one event) in one domain only appear
>> to user space to be enabled while in reality all flags/events are actually enabled?
> 
> I believe mbm_control should always accurately reflect which events
> are being counted.
> 
> The behavior as I've implemented today is:
> 
> # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_events
> 0
> 
> # cat /sys/fs/resctrl/info/L3_MON/mbm_control
> test//0=_;1=_;
> //0=_;1=_;
> 
> # echo "test//1+l" > /sys/fs/resctrl/info/L3_MON/mbm_control
> # cat /sys/fs/resctrl/info/L3_MON/mbm_control
> test//0=_;1=tl;
> //0=_;1=_;
> 
> # echo "test//1-t" > /sys/fs/resctrl/info/L3_MON/mbm_control
> # cat /sys/fs/resctrl/info/L3_MON/mbm_control
> test//0=_;1=_;
> //0=_;1=_;

It enables/disables the events automatically("silent upgrade/degrade").
This looks good to me.

> 
> 
>>
>>> However, If we don't expect to see these semantics in any other
>>> implementation, these semantics could be implicit in the definition of
>>> a SW assignable counter.
>>
>> It is not clear to me how implementation differences between hardware
>> and software assignment can be hidden from user space. It is possible
>> to let user space enable individual events and then silently upgrade it
>> to all events. I see two options here, either "mbm_control" needs to
>> explicitly show this "silent upgrade" so that user space knows which
>> events are actually enabled, or "mbm_control" only shows flags/events enabled
>> from user space perspective. In the former scenario, this needs more
>> user space support since a generic user space cannot be confident which
>> flags are set after writing to "mbm_control". In the latter scenario,
>> meaning of "num_mbm_cntrs" becomes unclear since user space is expected
>> to rely on it to know which events can be enabled and if some are
>> actually "silently enabled" when user space still thinks it needs to be
>> enabled the number of available counters becomes vague.
>>
>> It is not clear to me how to present hardware and software assignable
>> counters with a single consistent interface. Actually, what if the
>> "mbm_mode" is what distinguishes how counters are assigned instead of how
>> it is backed (hw vs sw)? What if, instead of "mbm_cntr_assignable" and
>> "mbm_cntr_sw_assignable" MBM modes the terms "mbm_cntr_event_assignable"
>> and "mbm_cntr_group_assignable" is used? Could that replace a
>> potential "mbm_assign_events" while also supporting user space in
>> interactions with "mbm_control"?
> 
> If I understand this correctly, is this a preference that the info
> node be named differently if its value will have different units,
> rather than a second node to indicate what the value of num_mbm_cntrs
> actually means? This sounds reasonable to me.

Looks like we are agreeing with "silent upgrade/degrade" option.

"mbm_mode" will look like below(Replaced event with evt and group with grp).

#cat /sys/fs/resctrl/infor/L3_MON/mbm_mode
[mbm_cntr_evt_assignable]
mbm_cntr_grp_assignable
legacy

Does that look ok?

I am not clear on num_mbm_cntrs in case of mbm_cntr_grp_assignable.

Peter, How do you figure out how many counters are available in soft-ABMC?


> 
> I think it's also important to note that in MPAM, the MBWU (memory
> bandwidth usage) monitors don't have a concept of local versus total
> bandwidth, so event assignment would likely not apply there either.
> What the counted bandwidth actually represents is more implicit in the
> monitor's position in the memory system in the particular
> implementation. On a theoretical multi-socket system, resctrl would
> require knowledge about the system's architecture to stitch together
> the counts from different types of monitors to produce a local and
> total value. I don't know if we'd program this SoC-specific knowledge
> into the kernel to produce a unified MBM resource like we're
> accustomed to now or if we'd present multiple MBM resources, each only
> providing an mbm_total_bytes event. In this case, the counters would
> have to be assigned separately in each MBM resource, especially if the
> different MBM resources support a different number of counters.
> 
> Thanks,
> -Peter
> 

-- 
- Babu Moger

