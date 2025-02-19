Return-Path: <linux-kernel+bounces-522495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD1EA3CB16
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1F813A8161
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44367253F1B;
	Wed, 19 Feb 2025 21:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VQT7r4w2"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248C624E4BB;
	Wed, 19 Feb 2025 21:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999401; cv=fail; b=mVSN2+x1RRmku/NCXFT38Q3la7NcHCLyOL9W5eICEPRym6DFIQ2FcdoeQTwo5cpuplzSXPxECj1La/6z+pkrVPy7HeyF9cbbfIUNPt/cU/Ta+rU2S7Fbd7Ktbm8ZTqkcIenr83TNGXVkSnDUmd4KsXM+sRmsfWSHOmCSfLaxKc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999401; c=relaxed/simple;
	bh=RPfSY3uhN7vKYL12UUxaeMQBQiacIGZIr1PMIkQN7m4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=quE0xJcFHTwWyrMuG2kGMJf1lv6a3joc5T0ijt/GfV8FEbRL8Ovu56s7wGPTcWlnfbUHtxMHbVKnVoFYMioLwUOzRsbH9HBWyKThfkJdSpzo8E/Jqk5om765dJlvWaWupqxJHxbd3aLzqe0Uq0MpiQr/5YGROT16fCiqPxkjHy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VQT7r4w2; arc=fail smtp.client-ip=40.107.100.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7b4eezGr2sK9pyPX7sMvoFX2bzuFky5Zz3aIzWAa8XvSnbw+o0TiBzfpVuKaN0E1jyUZ9EgwLdUjMlfgUAPvb6QMj8nF1gPpVV/ErMUqpFbS6ca+8cn3ASgP0FGcTOdeNmafEK1nsu5C2bgbCoQHxeboGAL7hUhaTHsB0TpVOTKvPLAVZaGiqUxy5pqbpnK3+tCK3iVphDIdmYi2zpzD+hyHBlburEO6Vrf2SDiHA1Sadk9b0D+GIqYa9+u7IZ3JyWIQTeewMHM7jDP/Xo6RxYkO4xySkhFNGymV3a/Y9ZijHT82rIBbW6NSgIHuKAm/VmT4UXh333Q9YT5wjmiXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxx+EeAp9kLqRSgWAqUOIkN3npm+JQUuVZ5zadw137s=;
 b=N+0s75tH9zp/38LIR8xISAGEtpFBw1ginCFAdDOPxx0eXwIJqwxn3AMnBVJ+OZSDjXh7ruaymbcf+daZb+Qh8CwHNq8/06zm+VBKuluwU1amIsp/BwTUScd9ZFKpBjaAtM9WeUViehcueIoDC/fwTEh2RwahY2qAZ+m8+uxNHbnIjdmdYMZtZ/tCX227qdUekiXEMJNXWx702sBdM0ozdnZh8gySIthNikEST3E7/3FyoRNHa7B6lMbe4jc5FYbfAI7QVcRRzn9JrT9aveb9GQkrg+/zVtB0iyhvw5vMd75poFplOWrE4V/U1Vgl43RXa2q/nKsu0mJX+PCVN1cgdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxx+EeAp9kLqRSgWAqUOIkN3npm+JQUuVZ5zadw137s=;
 b=VQT7r4w2Ef4Jl8ygusHB/kph3OmUvqjCJjPDO9mK8l695BIRLZfkgqUDNLGA1GzeOgCluR9Zv0w4oH60S5ErkhhZgXKMrJeKtJSRw3+MpdUm57LQSNJ9VMN2NbE7kHPd7ham9okpxGH1PMdGDYILuVDTgub93ou4wtNAnU6RFR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by PH0PR12MB7095.namprd12.prod.outlook.com (2603:10b6:510:21d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Wed, 19 Feb
 2025 21:09:54 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f%2]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 21:09:53 +0000
Message-ID: <45a0a88a-b31e-447e-9d62-bc0cdedf06f7@amd.com>
Date: Wed, 19 Feb 2025 15:09:51 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 22/23] x86/resctrl: Introduce interface to list
 assignment states of all the groups
To: Dave Martin <Dave.Martin@arm.com>
Cc: corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 tony.luck@intel.com, peternewman@google.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, akpm@linux-foundation.org, thuth@redhat.com,
 rostedt@goodmis.org, xiongwei.song@windriver.com,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 jpoimboe@kernel.org, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 xin3.li@intel.com, andrew.cooper3@citrix.com, ebiggers@google.com,
 mario.limonciello@amd.com, james.morse@arm.com, tan.shaopeng@fujitsu.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 maciej.wieczor-retman@intel.com, eranian@google.com
References: <cover.1737577229.git.babu.moger@amd.com>
 <52c66bf98480c0ab6bb0f0762497e328fcbdeaac.1737577229.git.babu.moger@amd.com>
 <Z7XiQ+u3Pc+uvJCK@e133380.arm.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <Z7XiQ+u3Pc+uvJCK@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0033.namprd08.prod.outlook.com
 (2603:10b6:805:66::46) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|PH0PR12MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: ba14fc0d-67bb-4068-e9e9-08dd5129c179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDFBZC9YNHVVY0Fla2kyWlJaTDFCTkN2Si9hR1RIbUsyNmZXcTlMbjZzSVZ6?=
 =?utf-8?B?eXMvaldtY1c3dVp3ZWZRdmVxUDZ2bE5ibzFhNjZRa0JCN2tMZ1hYVWdrYXlC?=
 =?utf-8?B?QUd5aUtRS3hQdXdWdGsyU1RVZTdvM2VkWlNwRnd0Snp4MVpxbjE0NTVSdnYx?=
 =?utf-8?B?d1ZITjR1dHp4Y3pyekJIMXFJRzZQWDB0bkZhUjZkTjVsV3k3OFF6dUc1L1V3?=
 =?utf-8?B?dVdrWEsvc1d1ckhMWFZJa1VzTjVtTXBaeG1oVkZqQ0NybnJTdEcwcm1UUFYw?=
 =?utf-8?B?TWFydDZyUWhnM1Q0YjZMZ05BVlQwbzgvM3lRT1hOL3d3bzFLeGRUUlF5dGFJ?=
 =?utf-8?B?N2U0ZUFKU2x1ZWtMQUJNRFFDVHFUVFl5NGd2Z1hjNS9SUHBYRHZ3NXhMU0lS?=
 =?utf-8?B?NjEydzZoQmtqUlVoeGpVYlRNRzh6TVNNRnJiT050NSs3ZWliNWFETnpFSStl?=
 =?utf-8?B?cmwvYi9nT2NtWEVJb292Rkk2YjBMRUhpUTBNUklKWDY1cTdBU2x3bWwxWHUz?=
 =?utf-8?B?ZUZVM09xa01QSUw0RjBBVVVZc2orR1hDSjVHc3plUWljRWM3MjRLN0E0aVR4?=
 =?utf-8?B?SmFrTVRJVUF0NWlJZndCQUxoR1V1Tlo3c2JpZTRWcUZJaEhnVVVMTjFpZGNI?=
 =?utf-8?B?N0JHaXordDRVdFl5SzUwMnF0WnV4QkFjTFVWVTFxcGFkdkJRWDU2L1M2RnAw?=
 =?utf-8?B?c0RHQ0VkSExlcU9kUkVJcHVqYVl6bHVwaGlodTFxcUg1QkZnWXVJeTFmUnQ0?=
 =?utf-8?B?byt2REQrVlBzTnBhc2VIS3lsZWF1a0lBOVF2TmozT3lRRmlHeEl4Q05QM1Rl?=
 =?utf-8?B?MW5kVXEveXBMVG5haEZBNmg0SzJNcnZBMkUrTmhCZ3dWSVlBMWt6L3ZlY1Rk?=
 =?utf-8?B?YzZKNXJtdVpKMmQ5bHMwb0FZZktJd0QrVXVJK2dZczJYbjZqSVZiYmxFQTVv?=
 =?utf-8?B?c0taWHU3djBiY0t5T0x0QVVrMmF2MC95T0RDNGhVbGJCNnQ2dU54TE9xbXgv?=
 =?utf-8?B?SFltQkVRT0N5SkFPWkx2Z0U4ZUlkWWl1eU9EcW1SZWUvMFR5NHlNYU9rUHZu?=
 =?utf-8?B?U1k1TUVDOE5SR0NCaVdRclhhblh6YzdoTjcxOFFCZGxtdW8vbmYvcXhyTDZy?=
 =?utf-8?B?ZXMwZUh6MkdMbXh0cHZ2N3Z5MGJ5T1lMRkdXUHd2ZHhYaHhIK2RFNE5PdTJR?=
 =?utf-8?B?eGp1ZXRCaHpTSkxpMFNweDZuR25ycFV3S1I0L3pkV1crY2ZDQlVvdFZkNGtv?=
 =?utf-8?B?OEpuR09UaHRFVGRjMzlseThJUjF2ZWNZamRQaUF2d2oyRlUxR0g4eGhEVGRD?=
 =?utf-8?B?bmdOQ0JqaDNiUDRGWEpmV3JHcWRob2xlRUlsNE5BRkdDSHM0clBqOGJMQ1kz?=
 =?utf-8?B?bnd2cWhRRHkwelVpUElVd0EvNlM1elBpd0JaRjN4bm5RSVphTDJLS0x6V0py?=
 =?utf-8?B?ck5ydklzd0pzOWExYXdtbjNHOGlUNnNxQ0ZLZnF2dGxEVThvU2Vmb2dQNkRm?=
 =?utf-8?B?Z2psR1dGamltZ1hIWnNTV1JXSytvWEh6VU1hTnJ4YXpoSS8rL0Q5MFdzcGZk?=
 =?utf-8?B?K1dLWXMvcW5CcEZvQy9uVG5tTlEzTnRmYmtKVUV0UGdPY3Q2ZmtxSG5pem9C?=
 =?utf-8?B?bXlheWE3K20xOTN4NUhjanR6Nk5DRGpYdndkT1JaRk9wNTM5Q3lqQy91N2Rx?=
 =?utf-8?B?WWJQN2xZQ282Sk15Nk1RZnppcEJLLzNYVm9ZeVE3NVE3TDMzR3U4TXdVaDFL?=
 =?utf-8?B?MnlrSm5ocmVZSHZPMDVMQXk0M3hBam1sZWExWGhRUGFGNkVRWkkxKzdKcDE0?=
 =?utf-8?B?VURCdXJRaURhb29WQis3dXhobGlhZmtsbXpJUGVVcW51bFdFZjhUdmZra3px?=
 =?utf-8?Q?9tjosCueAU9hc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enFEcnczV2swcHFLQUtSYy9DaHNjd1cwaFJHNzh2czUzMzVVekdkRm5CU2dj?=
 =?utf-8?B?NCtjQktpLzhodlN6cEFtTERtTHJVVk1hTHBLa1FnRnVVUUNHdXA4VU5HZ3Vp?=
 =?utf-8?B?QUwyUmxIdC8vZDR0QlJqRDc4Y3dIczMyY0Z5TkVWY01MaEpOd25XNkVZbTYx?=
 =?utf-8?B?LzM3YkFvdGNBMFFxUWZOM25nTGpDNThuc3lvNGhsTTR1dzlzTGM5SUFxb0x0?=
 =?utf-8?B?SVRUUXAyTHc1NUxYbWswYWdOQjNqSi9YOGRLRk10QXFCY1c5MnV4eERQeW1N?=
 =?utf-8?B?dTVDTm4xZE1KYVh3cTZndXFiU1pGRnhXL2xhRW5mMlQ5clFkVExZZ1diTnd5?=
 =?utf-8?B?OHdSTUpVZ2ZUamFHSWFPNmlpZU9OYjRReXpmaWh6KytFeHl1R1dqK2JEMW1m?=
 =?utf-8?B?VHVlS2QwSWlvSEkrOUpaNER3YStNL1pmeUQwdkhIREtaLzhrcVZhQzA2NnJQ?=
 =?utf-8?B?ajc5K3ZlRkEvTWlsdGNnbHRaUHVpTkFHTUNnZGY2c0hYZjVocGJFbUprbjFL?=
 =?utf-8?B?TjFtaUhuWm53ODM0RlJTWjVsL3p3T05NNUgraXAyUld3TlhENmJFbldUNGJR?=
 =?utf-8?B?Z3E3bUNoV1BocFhIOEo1bEV2NUFLQnVLekRqNnFBOEFFclJyUjViLzQxdkFH?=
 =?utf-8?B?MkFDeUxRdVA1TEtFaUhPYWk2eVBOVUpsKzhzY212N2R3OU84MlJiMm9wYTly?=
 =?utf-8?B?NzJubEx2NVRmS2o1ZGJ6VGk1Q1hlVCt3MkQxS1FyazJmSndKcWRhZHp0YTlU?=
 =?utf-8?B?SDVtMWlpL1ZobU42Z1k1RE1kUDlOZlQvMHBYOHg4aDRtM2xtRUQ4eElsbHBY?=
 =?utf-8?B?M0Y5Ymt6N0hMQldJeHVXTytWcVdUbnFoVzFwV3FRNEMyUjNvdmlhVE81QmNM?=
 =?utf-8?B?VDB2Z0NoRnVncXM0emxZTTIvaDA3eUpQY3VnSGJOeWFNV1dDUnpoUzVTTlRS?=
 =?utf-8?B?eERTaGRiK01FbStHREMzSWJ1eWN4bEJUS3pOcjZEVW5GWXBKaHdLeDd6eUR1?=
 =?utf-8?B?Qm1xQzdjSUpKa1QyWHgxYVhDamR6WSswQjJHUExoTjNSR1YwVjFxbllOeHh6?=
 =?utf-8?B?a1kwczZXamN3VHdOZlZ0TmhoRVJyOXoyNGVwdzVYU1hxd0lNY0x3MVVVTEFp?=
 =?utf-8?B?MU8vUzdoc3NoRUZYNEVoaW8rM05sS2JFbmFJd0NwRWllWTI2c0ljdHhSeVJp?=
 =?utf-8?B?ajJuTnpKMmdZZTZ6V0RLc011YXkySjNKUkdYZzQrb1NOUU1DSzJ4ekY1eWZS?=
 =?utf-8?B?aTdaMmRjK1JJdXU2c25XbzBnV3BscU1KWUpTd0E5SnpLc3daNGZwbm45QzNP?=
 =?utf-8?B?SWhPaFhRQndKRElTdSttN0xnYzNBMzdXMUxrOXV6aEFHZHV5QVkzbkZpdWJB?=
 =?utf-8?B?SER4OXZxc0o1cHZqbmVpOTRTZWdHVE9Bamd3ODBXZWNaaUo1NVhjWUtSaWdS?=
 =?utf-8?B?YlhiZmRiTVpTZFhzUndGR1BDeU5EZDlvbDk3bXdqaUpwcG50REZNSzRrbzhv?=
 =?utf-8?B?d1p4ZUNBTWlSMEJCc0pIUTB5bFpXS1VvbDhBdEhZK29xRGh2U1RtMittdWNN?=
 =?utf-8?B?b2tWOGE1czVIZEFRUXJ1YkVRTHZQMTVXbnlpZ0NUdDlVVkpSNW9CalFkS0VK?=
 =?utf-8?B?aTNhd3IrVEhSZ250VkNzeHIwVm91Qk9qNEV0MCtmbjFBeEkvVW1XNGFQOHFN?=
 =?utf-8?B?RXZTU1QvdkRJR1ZFUi9lTUtkTlNGNzJ5U0FlMnlhWDE3ck4ycWx2MUpFZkhH?=
 =?utf-8?B?YkxEVFB6S1hKSUFFOFg3K2hWWWVxQjhsZWY5L09EYkJNc1AyZnE2cGpXaXhU?=
 =?utf-8?B?cW16WFNRMFU5UW5YK3ZJTlJMendBVy84NGhaQkdiRWRXUERadGtaaXBzaTJ0?=
 =?utf-8?B?U1dvQTB6bGpaaEw0NGFNOFU1Ym9hcjE5NVY1VENrOURmUlJ0K0hydEpYWjJs?=
 =?utf-8?B?RnFZUEkxeXlra29ST3N3bEVoU1loNUhsUHRESitCcnFrQmJyamlhS2JYemtz?=
 =?utf-8?B?b1haUnozR3FQbWU2QS9zRTdDbUFmMkt4dVJLZDdJQWp0YmtsQXcvWG1sanlO?=
 =?utf-8?B?QmpDbEpNOURxbmhHSFZBbTUxZG9SaHVkQUpFNlhyMEFNZFhRRm9Bd0tkMmFw?=
 =?utf-8?Q?vcSo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba14fc0d-67bb-4068-e9e9-08dd5129c179
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 21:09:53.8987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UE4DbKIRSe242+Jnbtyn78cgHFAC5Do2fYwSL27EvFHQlxWQ2NpiMXhDVui3Mn78
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7095

Hi Dave,

On 2/19/25 07:53, Dave Martin wrote:
> On Wed, Jan 22, 2025 at 02:20:30PM -0600, Babu Moger wrote:
>> Provide the interface to list the assignment states of all the resctrl
>> groups in mbm_cntr_assign mode.
> 
> [...]
> 
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 5d305d0ac053..6e29827239e0 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -975,6 +975,81 @@ static ssize_t resctrl_mbm_assign_mode_write(struct kernfs_open_file *of,
> 
> [...]
> 
>> +static int resctrl_mbm_assign_control_show(struct kernfs_open_file *of,
>> +					   struct seq_file *s, void *v)
>> +{
> 
> [...]
> 
>> +	list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
>> +		seq_printf(s, "%s//", rdtg->kn->name);
>> +
>> +		sep = false;
>> +		list_for_each_entry(dom, &r->mon_domains, hdr.list) {
>> +			if (sep)
>> +				seq_puts(s, ";");
>> +
>> +			seq_printf(s, "%d=%s", dom->hdr.id,
>> +				   rdtgroup_mon_state_to_str(r, dom, rdtg, str));
>> +
>> +			sep = true;
>> +		}
>> +		seq_putc(s, '\n');
>> +
>> +		list_for_each_entry(crg, &rdtg->mon.crdtgrp_list, mon.crdtgrp_list) {
>> +			seq_printf(s, "%s/%s/", rdtg->kn->name, crg->kn->name);
>> +
>> +			sep = false;
>> +			list_for_each_entry(dom, &r->mon_domains, hdr.list) {
>> +				if (sep)
>> +					seq_puts(s, ";");
>> +				seq_printf(s, "%d=%s", dom->hdr.id,
>> +					   rdtgroup_mon_state_to_str(r, dom, crg, str));
> 
> Unlike the other resctrl files, it looks like the total size of this
> data will scale up with the number of existing monitoring groups
> and the lengths of the group names (in addition to the number of
> monitoring domains).
> 
> So, this can easily be more than a page, overflowing internal limits
> in the seq_file and kernfs code.
> 
> Do we need to track some state between read() calls?  This can be done
> by overriding the kernfs .open() and .release() methods and hanging
> some state data (or an rdtgroup_file pointer) on of->priv.
> 
> Also, if we allow the data to be read out in chunks, then we would
> either have to snapshot all the data in one go and stash the unread
> tail in the kernel, or we would need to move over to RCU-based
> enumeration or similar -- otherwise releasing rdtgroup_mutex in the
> middle of the enumeration in order to return data to userspace is going
> to be a problem...

Good catch.

I see similar buffer overflow is handled by calling seq_buf_clear()
(look at process_durations() or in show_user_instructions()).

How about handling this by calling rdt_last_cmd_clear() before printing
each group?

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 484d6009869f..1828f59eb723 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1026,6 +1026,7 @@ static int resctrl_mbm_assign_control_show(struct
kernfs_open_file *of,
        }

        list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
+               rdt_last_cmd_clear();
                seq_printf(s, "%s//", rdtg->kn->name);

                sep = false;
@@ -1041,6 +1042,7 @@ static int resctrl_mbm_assign_control_show(struct
kernfs_open_file *of,
                seq_putc(s, '\n');

                list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
mon.crdtgrp_list) {
+                       rdt_last_cmd_clear();
                        seq_printf(s, "%s/%s/", rdtg->kn->name,
crg->kn->name);

                        sep = false;


> 
>> +				sep = true;
>> +			}
>> +			seq_putc(s, '\n');
>> +		}
>> +	}
>> +
>> +	mutex_unlock(&rdtgroup_mutex);
>> +	cpus_read_unlock();
>> +	return 0;
>> +}
> 
> [...]
> 
> Cheers
> ---Dave
> 

-- 
Thanks
Babu Moger

