Return-Path: <linux-kernel+bounces-364367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A53999D3BF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC9E1C24EB8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAE61AB50D;
	Mon, 14 Oct 2024 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1bOnEkAX"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F451AAC4;
	Mon, 14 Oct 2024 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920589; cv=fail; b=gS+bifcQxfGZtIJHWM4ncrgqgEbgdC0UxZkButjYU8N3veEpi7vc2fqX1AEWXq0gkHY9Qc6i7ifB3c3mGcnyaHLtiJLMmWNCKLzU5ihhynHObeJS1GeYQhFqm+1BzcVp+FfaTgCkfE0UxRMa9eGe4tyO6L50hgtZjujmMesIZtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920589; c=relaxed/simple;
	bh=C1ZEqZkSyRUHYVyeU/mFegAu8xBKjnQ2GS2fCZPjHkY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lnp/aTl45+ebR2clx9NlAK2ThuUJ8jV6Kju3vpaNBrZk+C591gpXFS4cD/O+3rH2AN/bYFfsU/UQ/Ifv6C3zDGE6o8J4azQ2aY5GSnT4GMGTQ0G/laU7756OFaYqfCMKgvZKHWtUnGE6461/OlktW+QJXiKVmycun73F6speJ9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1bOnEkAX; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qthe3dINY5cKWt99Jciz/WySGHyQz8mPZ9EL+c/hFj2ftAhfubN9kZKZA1QTrCXzS9th14yT0itV1oA1JO56UnnMJZbj/6A6I526CyAW2hw13iH1HKpfJ5Zo66IiGOBM9CjjW1wl2A3lrm0ZkCDgUq5p4OBtJ2X/ICQrV8JDq6E87kcohj1APbcEz0jtS2ujOtZsMNu6HPo6EFv5UV057rLPxtJ0QPELLhTOUfMxE2O4DwqX1LbzOky75hpnhNjeNwWYpcoIZyaiQAEUl8KmrgfVrJhDwi1olBSFDpuDFT4ODVwOEu7zKMihCMAWe+viCHRZ5TowBn1S8QbItflMyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlh1fMDN0lykviNxloiOw5y3EbLI3UxcSupgphJ6MfI=;
 b=QhlN+FCXRME22Bwc/5iKxMhgRuAVp5VeY2nfYZ4965B0HXoinxd+OLq/ZzaqLiAsy+IkU3jV8zpntrxLh0OC8Qe7ahxbmrDsRGoaW8rzFbUWXLZ0bnczZ0icPPzsrv4xH0+xIMzERoQ0REl+dRtLKI0dLvvSHkMlzOzEPz7PxZD4caS/U48TrhKeqyahGHPfz/SUypsF2VqRIQhjbz0+xwswr+9NOHT3D8wXARrT5t9ofDqTdK+iLgeOJUpNJurTuN777Lkzy6IQN2g3XljOy55+yOaR38cV7WeHBYIVuoYo67HHz/quGYnrhVV7a43dFjP4yes5ZwqdFFw9NuQYWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlh1fMDN0lykviNxloiOw5y3EbLI3UxcSupgphJ6MfI=;
 b=1bOnEkAXmpD+PPoWR2W6LXoBvL7deXt9palDWMbWHDi37xPGhOaAvoGSu2Z3Bx48fVAL3HPF1YdYMRWkdPrH+ke1POf2ZQ4Mg0xXZ+scWCqF8xuwYjJ9otm7VBkBTqNzNbcu08UHaDYhIfGNR0hDRpbfTqEu6WpeUs1R/db5wcg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SN7PR12MB6692.namprd12.prod.outlook.com (2603:10b6:806:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 15:43:04 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 15:43:04 +0000
Message-ID: <43654ae1-c894-409b-bcb8-065940644906@amd.com>
Date: Mon, 14 Oct 2024 10:43:00 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: RE: [PATCH v8 19/25] x86/resctrl: Auto assign/unassign counters
 when mbm_cntr_assign is enabled
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "Yu, Fenghua" <fenghua.yu@intel.com>,
 "Chatre, Reinette" <reinette.chatre@intel.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "paulmck@kernel.org" <paulmck@kernel.org>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>,
 "tj@kernel.org" <tj@kernel.org>, "peterz@infradead.org"
 <peterz@infradead.org>, "yanjiewtw@gmail.com" <yanjiewtw@gmail.com>,
 "kim.phillips@amd.com" <kim.phillips@amd.com>,
 "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
 "seanjc@google.com" <seanjc@google.com>,
 "jmattson@google.com" <jmattson@google.com>,
 "leitao@debian.org" <leitao@debian.org>,
 "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "Joseph, Jithu" <jithu.joseph@intel.com>, "Huang, Kai"
 <kai.huang@intel.com>, "kan.liang@linux.intel.com"
 <kan.liang@linux.intel.com>,
 "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "sandipan.das@amd.com" <sandipan.das@amd.com>,
 "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
 "peternewman@google.com" <peternewman@google.com>,
 "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Eranian, Stephane" <eranian@google.com>,
 "james.morse@arm.com" <james.morse@arm.com>
References: <cover.1728495588.git.babu.moger@amd.com>
 <ce07d802260f537b24b3affec57c2d2e65023709.1728495588.git.babu.moger@amd.com>
 <ZwldvDBjEA3TSw2k@agluck-desk3.sc.intel.com>
 <541d6c15-ed5f-8794-506c-8fa4065ca170@amd.com>
 <SJ1PR11MB60838F3FFF40AE2718ED7833FC792@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <SJ1PR11MB60838F3FFF40AE2718ED7833FC792@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0018.prod.exchangelabs.com (2603:10b6:805:b6::31)
 To MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SN7PR12MB6692:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a3eed23-0046-4a6a-5248-08dcec66e47d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0g4Y09qdXROQVE0Zm1sVlBwbFplR3VweTNocURXT2Vzdi92a0FGVXp0aFEx?=
 =?utf-8?B?YXBWVU5zTUhveldqQmZvVWdyRDgzQTkzZjV6Ulowd1UyTjdCSDNqWWZwQjdP?=
 =?utf-8?B?M1U1VFhIeXlUVU9qSlVlZXNGSGJjZTZSQkdWYU16ZEp6dFRsZ3JuSW5mUUhS?=
 =?utf-8?B?bVlMNnhVQlpqa3g0OHd2aU0waFdOSUQvZGx4VUg2azNyRjB0bDB6blA1ZTFa?=
 =?utf-8?B?UWV3c0l6amkwT1lXOFVtV2tNR2dTVDNUQThHSkhJUW92WkZybllnSUJHM0Np?=
 =?utf-8?B?UHEyY3VUaE5nNnBVcEUydjlnRXEyUUlxTEE1WE00VURHNGRJMjVkWmlZS01a?=
 =?utf-8?B?QUl1aWpFc3Vad20yQ1g3QVBpNnNtNmhRN3hzMnNILzA3ODRnS2FHWVpzK3do?=
 =?utf-8?B?RjErVEFMNG1WNGwvSzhDWitWeEVCZmV3alAzcFRCaFdhSldoRDJ2Q0xmaFlz?=
 =?utf-8?B?K3ZzbGFTcFRQYmJSRnNBNk1qU0Z0OXNlRm9HZHV5YlBSdFFnSUIrZ3dlYXhL?=
 =?utf-8?B?T2ZscnVFaVJ4OFQ2WEo1TDNQbElLUDVSdmpmQ3NOdlQzMVgwSzBHUWVrallP?=
 =?utf-8?B?Mk9tWTRMSEZ4cnRGZ3FpOERZbERGMWtoaDF1K2RxWVJSQzVLTGt2eWs0NVN6?=
 =?utf-8?B?a203TURKWGNFUHNpVGNhcDBvUmJBOVhvTkMvTEpHZUFJa1RzaFR1cEd4QkZX?=
 =?utf-8?B?aE9VanBBSzRoK2MxV084bXhUSm41Y05MQjdtNmdxdTFseEpHVWU1bkd0ZHpv?=
 =?utf-8?B?Z2FmOGh2b3JpbVdnMU13SUdMK2ZyVmpneTBwVE5XTERrcHQ4Y0FNSmVSZ3g0?=
 =?utf-8?B?TFFYbks3ajVWZHJnUjRhWHVsa3crc005cndqcTRuZjRhMGFseGJFdDNjS3V6?=
 =?utf-8?B?eExqVXN1SjNobDNBSkpxUHFDR1JCUnlzbXl0cC9taU9tYUluMlByb0xNOUlr?=
 =?utf-8?B?enVEVkhmdVBSYW9xL2NHWVo3ejU2ejlIUmNjZU1jSEpJNENqbWxUR25zSVBH?=
 =?utf-8?B?bCsraklRcG9uUmFLUFBMVW9kZlRpR2ZCOFRrakFMdXVpT25qSXd1RG9kN1N5?=
 =?utf-8?B?VWIzNUFDWVM5VHgzK0xWQ3IzK1NkZHpMMFROWjkyeXZqRTN6eVNUanJxWVJq?=
 =?utf-8?B?eXFTcCt4cE9iaXpPMktrRVdSMi92TzBPMjdZOXVBVjh5THhaTWV4dGY4VFBC?=
 =?utf-8?B?cWtIMTh1LzRuVkpXRytGRzM1RkcwaWlnNWwzN0FSUTNZUE5rQjR4aXZxZk02?=
 =?utf-8?B?MHdDcFZhcUowckhlMzJDS3d3ZGhPNmZLK1o5VGNRYjJ6SUFVaFdDK240K0dH?=
 =?utf-8?B?U29xd2d0MHBKUjE3YytteDMxVmtPeVYwcCszaDEwSExWU0liOWtqMmdCNWRW?=
 =?utf-8?B?RmVncXFUZ3NKYnZRNUw5OVJvSTlHRGJrWEFOUXBvcHNwcHFpNnlWbEF5VE5q?=
 =?utf-8?B?MEpjQlh3b1VpZnMrQWlDSG92b3RQUFBaUkdHK09neEpYYkFESVkyamNISlRI?=
 =?utf-8?B?MlhjU0NYQ2xzTUt4TjRBVmVBYlZFY1hkd2FadmQ0cW9wdEpGOG5RVm1CUU1K?=
 =?utf-8?B?UDkvZjV3WGgvKy9YVFQ5Wno2V1NuUWZpMk9DcjVtTVN4VkpyZFU5R1J2SnZq?=
 =?utf-8?B?bG8zQTBoeUhvVG1YdFB0QkcwR1UzdmN0RHVmcjBnRENCbDI2ZXAzM3NPNVFq?=
 =?utf-8?B?K2VOSWFOdzk3Z0lFaXN4bWhjcEY2Z1dUSW1kdkNPSG90Y3lRTGtROVpBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEhlTTUzcW9NejlVV3ErR21HZDNSMk1YRjJmNWRtam9XYjZYSk4wZUs5Y1F6?=
 =?utf-8?B?d0M2SjE5aWNYbzRVZ2hXLzdDeGN2dFRQcitBRjc4STdYMVhQanBUSG94OU5D?=
 =?utf-8?B?dVVnTGxvMHBDWVVrZlc2aHJtaXcwY1llL0lncG5mWk9NbThnTTlnRnpzdVlE?=
 =?utf-8?B?R0Njdm1KemVoMlc4NXlySFZjRk44QXdNYmtRcERpUVpyQUNCTzhMaFU1NVNX?=
 =?utf-8?B?cnVjUzRiYjcvUEdKOWtkSG1LaEkxY3FFU0J0SW1GSnpYZEt1R215MnNUNlJ0?=
 =?utf-8?B?SWtoMWp0N0JLQmVmZkF5QXZtYjlNODQ1RUFsZ0Q1cWpUYkUrdGlFNU8yaC9C?=
 =?utf-8?B?a0VCdmNyUVJESEdCSlMwcjc5QUJEWW12MmhUY1kzb2NrbEdJRkJDbnplc2Q0?=
 =?utf-8?B?cFc1Z3R4ZTk2SDlEWEdBWUtjMzFUUFJtVkRHb21BVnpScE5rVHEvSlhVa001?=
 =?utf-8?B?OFNSWFlKKzR4SW1WbmdHR2Z1RVUrNy84aGI0NGJJdlNVaGtrM0hHL05HSWNT?=
 =?utf-8?B?Q0lNd2xkMEFUbmFPclZGajQ4YVpMRVNpSU1JSTAwcnBFc1JiSTBhSVBiaGVR?=
 =?utf-8?B?cVhrYjVaY2NLMVdHbHlVYUFtck1mWjFOTjVrRGRWZmsyR0RRK2orMzcwY0xw?=
 =?utf-8?B?Q29RZWxKYTZXTzVCc2liQmJ1YTA3ejJCNkE4MGEwSUZjRk9XWWpIQ1krY01Y?=
 =?utf-8?B?SHJIdGRSVzJVQUJadTM2ajdybWVjaWxIdjlRb3IwZ1RINEdHN05laHRBZUtB?=
 =?utf-8?B?c1NKd29xUUVmU3BqQ0hJL09nN3RKeFhwdkttV0RvVVNhNC9MUHZnNS9HOU5j?=
 =?utf-8?B?ay9XaFBsU3BrRkI0a3JnYStuZ3MxRmhLcTlCVmpId2FjVStXRGdtV2g2dnFx?=
 =?utf-8?B?RERkTk9tdG9kd21qUEdxSzYrVitveWZWWUZ6S3h1QjV2L0U1RVdoWGV3bDJv?=
 =?utf-8?B?bTRQd0tOSjcwRU1oMGxCdUcrVUlmSlBqNjZ2TEdIRDlsZ1k4R3J5VGRUSmtV?=
 =?utf-8?B?QmczUjBrUXF3bEFaNFBzeUVJdE1ER2sxUkMxSXc3aHlFK1lta3M5a3RIdlho?=
 =?utf-8?B?Z1M5eS9KM1FpSGYzT2QzRFNOZXYrb2t1V21JbVlSd3A3aG5EcDRoQjI4Ylho?=
 =?utf-8?B?NFh6bGMyTlQydFBaQ0F1QWRBQUZmT2twY2xMVFVmZGpLd1RxOXVaUVpUNkg5?=
 =?utf-8?B?bjhSdXgwZjZtSmlLaUFVUFIxeER1WmRGRUJzbDhNbWhCMmNZcTZubFFvMjFF?=
 =?utf-8?B?SXJBa2pQRlRIS2kxSXY1VkZLVUNhR3ptMkw3QjhXdEp1aVVWM0c0QTBRVTZk?=
 =?utf-8?B?SjRFMExtMUQzdnFrUXJuNndsWDFVd3pFN2NZMTNVYnoxcmsvcnYzeGJLdkxw?=
 =?utf-8?B?bzRETHBudmNHZFZFWG5nU0pFNDBmQkJiemlvbjlmU2VtczNPQkVEWFhjRGtN?=
 =?utf-8?B?cjQwWUo5NnBvMUxPaWtXTmRBNDlXV1NDYWpFenlyWDBCWmJCWm5RMWd5L1ZY?=
 =?utf-8?B?UWN1aWNtNXJ0NFhPWmFxa3gvWUZqVU0venVvT3U0Y1hKNzV4SzFKdnZZSWFW?=
 =?utf-8?B?bERON29XQ0pCc016U2E0K0ZKZ243bGQ3VTR1MXBFaDZ3NjNRNEFnUUFhb0RG?=
 =?utf-8?B?dFczZU8vN09WbjJWcGxuZ09lSThVOHdWbzNENVhMcFZYQk9KMGFsSjZuTW5a?=
 =?utf-8?B?NTcyOVRzSDh5SXFsbmdJdlNjZ2E4WkloL1ljYTNyMjNCbzBORGQyT2NrTWRZ?=
 =?utf-8?B?dVlhdDltZXdQdkFiaG95NUF6NzBpaGFLc1VSL0RrZGE4Y1dGT1ZhUGVnYlkz?=
 =?utf-8?B?UjNDMytQNlJPcWpRLzRBQkJhcEhIdmkvZ3MyVmhIZUlFWEdCeW9tNWxTT2xU?=
 =?utf-8?B?TUwyZGNHbDgwVDF4VTdYaDFhR0h1SEFoTXphRndsdVBmUmdxVVFLdnBxbUNQ?=
 =?utf-8?B?K3dCMlprdUlGN1JHd2xJeFdobVQweHlSWXppUjlMOVhmbWttaFNUUHltSi9k?=
 =?utf-8?B?STdveDdYdk9zSXMxdVAwSFpsaEtMWlIzQ01CSlZPV01JREZ1ZW9WZHpKTThH?=
 =?utf-8?B?YzlZVDZpandYMmIxTDNHR0o3aEh3NUNZSjlkaVJzS25VK0pJc040SnkzekdC?=
 =?utf-8?Q?yGgs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3eed23-0046-4a6a-5248-08dcec66e47d
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 15:43:04.5236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tGCYf5Cly1As60sODgWZvVEQzLqwET0ax6D9egy0Sghdc1Vr/SBKANTcZl9WNa5b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6692

Hi Tony,

On 10/11/24 16:33, Luck, Tony wrote:
>>>> +static int rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
>>>> +{
>>>> +  struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>>>> +  int ret = 0;
>>>> +
>>>> +  if (!resctrl_arch_mbm_cntr_assign_enabled(r))
>>>> +          return 0;
>>>> +
>>>> +  if (is_mbm_total_enabled())
>>>> +          ret = rdtgroup_assign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_TOTAL_EVENT_ID);
> 
> Consider that this call fails. "ret" indicates failure to allocate.

Look at this call

      if (is_mbm_total_enabled())
                ret = rdtgroup_assign_cntr_event(r, rdtgrp, NULL,
QOS_L3_MBM_TOTAL_EVENT_ID);


If this call fails, it will return immediately.

Lets say ret = 1; (1 if for failure. 0 for success)

> 
>>>> +
>>>> +  if (!ret && is_mbm_local_enabled())
>>>> +          ret = rdtgroup_assign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_LOCAL_EVENT_ID);
> 
> Now this call succeeds. The failure of the previous call is forgotten as "ret" is
> overwritten with the success code.

It will not make this call if the first call fails because of this check.

        if (!ret && is_mbm_local_enabled())
                ret = rdtgroup_assign_cntr_event(r, rdtgrp, NULL,
QOS_L3_MBM_LOCAL_EVENT_ID);

        return ret;

Here if (!1) evaluates to false.

Did I miss something?


> 
>>>
>>> This overwrites the value from allocating the counter for total event.
>>
>> Total event and local events have two different indexes.
>> Can you please elaborate?
> 
> See comments above.  If you want a return code you need
> 
> 	int ret_local = 0, ret_total = 0;
> 
> 	if (is_mbm_total_enabled())
> 		ret_total = rdtgroup_assign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_TOTAL_EVENT_ID);
> 	if (!ret && is_mbm_local_enabled())
> 		ret_local = rdtgroup_assign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_LOCAL_EVENT_ID);
> 
> 
> 	return some_function of ret_local and ret_total;
> 
> Not sure if you want to say success only if both of these calls succeeded. Or maybe if either worked?
> 
> But it all seems complicated since callers don't have to take any different action depending on whether allocation of a counter succeeds or fails.
> 
> -Tony
> 
> 
> 	

-- 
Thanks
Babu Moger

