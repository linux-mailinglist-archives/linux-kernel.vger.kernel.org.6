Return-Path: <linux-kernel+bounces-184045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 835D18CA1C0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 20:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39C81F22447
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 18:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B9A1EA84;
	Mon, 20 May 2024 18:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pd7oT945"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2052.outbound.protection.outlook.com [40.107.96.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B7B136674;
	Mon, 20 May 2024 18:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716228214; cv=fail; b=TOEcpRdqLUYm24ccP3xqPv6ff1UcPqJdZHBvQPROw8D1p2e+FjyNNLkKfUyhniFplTPivhpwa/aMWro50xhB27z5XEmvwqLFVuUY2rjmihbB42rok6NE7mZEl3oJeI0NuJ5Og6b+vBZK37dTOAJaztYotULuvhKIOg8KXoVp9Gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716228214; c=relaxed/simple;
	bh=W+NQc299PhW6SzvGUnOchWuoxaaUfHnDdInvnnlNXb0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ppWt7d7K7dpgTpW5iTu1T/D903I1J3hq4f81KE0RooIaPKVC9klha7UaMM21+HiPzltNLK+pVJajdERMDLGM/1JlLNoYwDbmWZRe9Gm0wZx3LebQ9Ffzcn8O3GkvKeMBClhuBM2TBru0twTvTKYhZf/5delC5JQwLERX8e/sH+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pd7oT945; arc=fail smtp.client-ip=40.107.96.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltcgwJjrIeFquupEP/dsx6FGHfIFJW88KOcKani/iUWgfhGL/7TBZPONifI13EG7uJ22x0dfA91sWUphbNVD4ToSEE8YjLQfKSm1hRuBDkR3MOGB678yhMqO9wW9T2myp1CGbnmV9u9M0UAGVZ1wMYkztDMNK0WdRUxOu2etVywJ9ji5BsAx6/YEEqm/9GMPrq3EuMJgICmQYwm0JW/PacLDye6c1GEXYju8ciNx2ZzUMzsxwdzM00KXTRCZ4qJqu9uab/MuPfM3efXs7a9hfJUxcM4y2EhYo1yOM6nr9hKRMEIKztPZ6BOplRxOPVqu/dL8eOyZhcIKz1G+5nt7GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Og+rz7bC05iJ/Q3DVe2DIGzFVyk9dPE0tEGDzgd9Q7E=;
 b=hmqNz8htcQ6UmRJZ+JNbeioi20uKvL5kqTZD+qS+oYVUIRvL2xcofFN1ZLN3XnX8btdJO4G8uDASu8DijCPk3HuhoyxqiFhbu7SgR2rwxpZiSnUadCDD8K4ASrejts+I5miaWIrlySsYBJtqR0ssSeYKo330PkMmGyHNzt5tx40Q10EfdsW1vwswMe4TqnBGv+ZYBkXx8erNMWDX/vhwET3fParqxKRL8nFxyeLg312vZ7HWuwrT0Gs2I3O5Gl4eRX3HqhH5T4ruKMTgWBQMcIgmpuTBNX3c0ybqQAZ6Nj+TX3bE3fYWEd+SeuqkVzndw02mM8JeZIR1wCzVeegu5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Og+rz7bC05iJ/Q3DVe2DIGzFVyk9dPE0tEGDzgd9Q7E=;
 b=pd7oT945u1gjfFISh1jSG3jWVL8LOMhtB+SsSgXkulsHGRJo3HyraZ84+4G/M1Do54e9o9by20PDPGln0XmMvZSucX/DsJ2luSaN1SKrSQszy+b4ij9aFilJ1ibZlOkyjHYx+ZIVUe1KS6hN+DKGpThv/UWadRZxy0nCT/exIOI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM6PR12MB4169.namprd12.prod.outlook.com (2603:10b6:5:215::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Mon, 20 May
 2024 18:03:28 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 18:03:27 +0000
Message-ID: <dda69695-0de4-4d0c-936a-128c6c1948f0@amd.com>
Date: Mon, 20 May 2024 13:03:23 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH v3 00/17] x86/resctrl : Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
To: Peter Newman <peternewman@google.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
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
 <CALPaoCjZ3oLdKymJjASt0aqtd0GGOme7LavvYOtPYTb_rA-mYQ@mail.gmail.com>
 <b35dc4e9-7e8b-42ed-9a51-ae50d521cf4b@amd.com>
 <CALPaoChxYoJx8eR48EkSKf-hu2p2myQJLZEhj_Pq6O4R15-=5A@mail.gmail.com>
 <6edffe1b-e9a9-4995-8172-353efc189666@amd.com>
 <ab2a6a4b-3740-47c6-9443-e6bb7a0c1adb@intel.com>
 <CALPaoCiYFKeASPMDwzzaHLw4JiMtBB6DTyVPgt0Voe3c3Tav_A@mail.gmail.com>
 <b725e4ca-8602-eb26-9d47-914526621f52@amd.com>
 <CALPaoCiu2_UHyGjsyitz28BL1N93TSn28E1r-6nhXg--bzmU+Q@mail.gmail.com>
 <d7f3c5b1-c39d-4c66-92c3-5b096b9e0579@intel.com>
 <CALPaoCiJ9ELXkij-zsAhxC1hx8UUR+KMPJH6i8c8AT6_mtXs+Q@mail.gmail.com>
 <fae7fd93-27b7-4f94-964b-9c909f85f2fe@amd.com>
 <CALPaoCihfQ9VtLYzyHB9-PsQzXLc06BW8bzhBXwj9-i+Q8RVFQ@mail.gmail.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <CALPaoCihfQ9VtLYzyHB9-PsQzXLc06BW8bzhBXwj9-i+Q8RVFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0129.namprd11.prod.outlook.com
 (2603:10b6:806:131::14) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM6PR12MB4169:EE_
X-MS-Office365-Filtering-Correlation-Id: 736a1845-c4a1-45ae-7aa1-08dc78f72677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWdMekFsaHVzdXdwc0M4ekhTb2RGNFN6OW9YZnIrTHNlQTRGbWN4QWtwTHNu?=
 =?utf-8?B?b3RER25QTEMyZXpZeCtIWEZxS2l2dmdGNzdpV2pVMjJpbDlvam44aTVhbGp3?=
 =?utf-8?B?V05NdkJEbldaWkViRE84eHZmYTlWaGlFT3NEOHgxV1pjODB0bWNidmtXMmZr?=
 =?utf-8?B?NVRDYXQ5L3I2SXRpR0hmVWNvdGVSTlkwMDVzVFJEVXgvWXJxV1ZadVljZ2gy?=
 =?utf-8?B?WjNFbzhiNk1QSGx6U2sxZFRvKzRmaGoyREgvejI3a3AwSzhNSmFwYS9qNy9l?=
 =?utf-8?B?N3k4d1dPRDB1Wko0eStPbVNueEYwMVBIVDJZekxjSFlpcjRnTEErdlkvOTQr?=
 =?utf-8?B?SkRjTHdvMFJ5dWUva2swdFFEaysxb3JCQThscTVNNkQ5RHUwVkNlTThvRE56?=
 =?utf-8?B?YUNOVEgrMS9rUzB2cVl5R0o0M0hObkpVMEczYTFTVHVLQlY3U0d1UXlIZ1BJ?=
 =?utf-8?B?MXQ1RUhwaUpDLzJCOExIbXdYV3BtV0R3dHI0OWpFd0Y5SHhLdFR0WlpmTW1k?=
 =?utf-8?B?UWprQ2JYVURGNUxZK1pXQTFvSTBWcGhLNVBqSjNoT3VGYlQ5QmtUUXlrQ2ZK?=
 =?utf-8?B?ekVuNHpHRUpDL2NadG1QUGQ3UXB1LzdRQUJ4dTcvcTVWUEx0K3JQR0Zlem4r?=
 =?utf-8?B?cFY0VWZxVkF1c1kzVWphZkFJcnFlS3pzcWtQc3JKNDhFZURTOHNVdVE5cmRJ?=
 =?utf-8?B?WW9TT3k1N0pzTHNySWRmV0ltdjg0NG8xTzUwZnZxbklsaEJBZ1cwWFBpM3Qr?=
 =?utf-8?B?aTV2WmVscTJpK0pabVJzQlN0ZlpDUDNUY3NjZlo1UGdjdTJIcENhTXZQTkZO?=
 =?utf-8?B?dDhpM3lET1VneXI1K1R5dnRWSUVjTFBOZVVvMDMxV0hjNVRja3JCSEJvOHdj?=
 =?utf-8?B?bGw0aGYrSzVySUlpZ0VRZEpLOEduWWNBRm5UQ1E3N09IbEVETVV0QVM3amt1?=
 =?utf-8?B?OEdGM2JhQ2k0elFDcHRxRHV2bHc0Yy9aMW5YMTh4NFF1QnRaWjdkVVJId0hJ?=
 =?utf-8?B?QnRVdjBGaGR5MDdpaWNOdUhJVE03cWJXemlVSFZ5K3pEOVN0cHcrYS9Cd29o?=
 =?utf-8?B?SDVyNkxUQVZjVGVxOGlxVk5ndTRna3hpQzdIMGtNYjlWVEZJeWd3blh4YjZl?=
 =?utf-8?B?amw1TTdUU3JOdDY0N3lWSVRZK1VVc3Juc1ppL3VUOWtJMys5bEU3OEtabWhi?=
 =?utf-8?B?Z242eUVCelJ5emUvN1IyWUwwTHBFZUloNUs3dWFncWJoRmcxM3NHeDFxeDlq?=
 =?utf-8?B?aDQrS3pLWk9PNTV6VDJoMzUyVGtDMzV3YUhBTXhrdGI4VjgrQjQxUXVmeXZP?=
 =?utf-8?B?ZE9PYmdsS0xBZmVGREFmN2Q5YUpJb1pJdUlUK3BseGRlSW5JSC9GRDFNV3Z2?=
 =?utf-8?B?U1BJQ25OdnFKYWl3MjYxU1dLaUloNjZqTVhvQVVzSUdwenJONVB6b3FJTnlD?=
 =?utf-8?B?OFJjK3QzNHZVUHpacFFsa3ZrWklpVmFYMzlUUVhXbEVSREV6aW42RkNQbmww?=
 =?utf-8?B?ZFZqb0dTZ0hJRlY2ZHN1TXovbGxPVXUyMWswdTNQTzRPSkhKWlZCSDhEb1Iv?=
 =?utf-8?B?WXJGQnZFeklRRERERlB5K1IyQjRuckxYbFF2cFk1RnNUZndjeCtYbHo4b3Fp?=
 =?utf-8?B?MjVKMThXMzVrZ3Vab0VoeVdBRWkzeW5xNnIzdXl6cTlyTktUUXp0VHQyVEM0?=
 =?utf-8?B?Y1B1bFIzQ1Y3Y2JvWm1VeldudUJOd3FLbml2ZkJpK0Fxdjc0RzJjTEFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFNSUENFRTduZFhBSHFUQTllU2thUzNBNHY3ME02cmdvaTNNQ1NxOFBiaWRY?=
 =?utf-8?B?aVFKSFcwZWI3Vm1BZmkzZjVWNzlGaU04T0J2VUpuU05wNmpiMkFoaXZMSWNo?=
 =?utf-8?B?Ymd0b1NndlFnT1Bkb2QyUGx5dGE5bU5iTXRuQVZ4bUttUS93V2V0UWN3THYv?=
 =?utf-8?B?SlQ2R1VpeGNZTFBVbGxETW81eHFNOFR2Rk85aHkxbjJkUEpEb0ZJWVVJcytD?=
 =?utf-8?B?enE4VEtZK2ZxQmN6MVdSU0YzWGZ5Y0g0ZTdZZ3dLY2Y2UTFvekg5YlhEYnVU?=
 =?utf-8?B?SGRyOENoRVpJc25PQk1xZ3l0di9VVGd6ZVZ3TEJmbGxwbm8zZk45bG5TSTlU?=
 =?utf-8?B?KzJGaDNWd1pEWloweWE0Y1EvbTZGNkNtVWZ4MC94NC90a1NTNS93TkN4QWZn?=
 =?utf-8?B?czkrTkdtTXZzZTVtcnU2em1NZERzbjBhWmxmbDFUMWZFOW4renhoSGY0YkMy?=
 =?utf-8?B?NzBaTnNYMkJYMldNT1VTajFkUGNoNnJqNHlkQk9lSVI0OWJicE8zL1dTMjU4?=
 =?utf-8?B?VXZNQ2dmaHkyaTFURlFBelFOL0MwN3psenFYY2xWUk1uazZPK21EWEhZQ2xl?=
 =?utf-8?B?OWF1RXEwS3lZS3RkRG1nb0M0Skl2ZU5QWEl4NjRiVDAvczZKVXdWT3M1ZUxC?=
 =?utf-8?B?aGpqamVQelVONlJTei93M2lGaXlxdFdyVEJLMXVJMTBZb25XRW1OWmF0c1oz?=
 =?utf-8?B?czVyZGplV3hycHNuaG5ybWNES1BYQnlvSVc1d3FrSDZmTTM2dVJ6UU9Mbm1E?=
 =?utf-8?B?S3pON2x6VW9kaVh5YXZjR0s2Tm9NQmFHUjVRWW9QTHJ3ZWQ4UFE3bTNrVHFT?=
 =?utf-8?B?YStORGZuc2RHWEtUb2ZNbGlUVW1OdmFoZjBuelRxREhzWmtWeGp0b2pBZFZz?=
 =?utf-8?B?cWZhTWtSZmRVSEFKTGl4alFRMzhaS0Mrcy9NTWtWU2NEQ2NjSGRiRU1hVjlt?=
 =?utf-8?B?Y1NYZmI2YXh5TmM4dThuSzVGZHRKNlpZRTZzVnh0TE4ycmg2M1pEY3dCUHdM?=
 =?utf-8?B?amZKVFZPYytqUHNwRWtEQ0lwVURMM0liSXA2Vkk1UVk1SkxhdFdmQlNoTi94?=
 =?utf-8?B?MjRVMDk5eFN6MmV5eCtiZTFCMldVZmI4QS9VU2F3M1Jla2JLWStPUlJmQWhE?=
 =?utf-8?B?c1F5T2VOQ1Y2ajFjYVVqRjJ2ejVIWFRneWRQKzNNR2E2ZGh6L3VvOVR2MVo2?=
 =?utf-8?B?MG1zM2ZMUVNTNTc3VEdrTmJHTHl1RzVha1FYRGdiZE5PSGsxV0YxT3FXTVJP?=
 =?utf-8?B?ZlVKSHdOeHV1d2pCa0Fqc0ltSE02WUlpWTVIOFA2R3pXNjRLMEhDR1M4Ylpi?=
 =?utf-8?B?a0pkSFVqYklRRzVrYmxSVTEyUjNQeE5ocDErNXRFL2c4M3BjSkg0RG8ySHRZ?=
 =?utf-8?B?ZEQyYTdsRzBVS0k4VHd6c3FuNkF2bjdqc2dXV2xQRHFlSGgrK2JTdytJMFd4?=
 =?utf-8?B?MXVvWi9QUURJM3hNSVdsL0RnT3ZkakhjQUw2YXFJS2VWcVFYQlFPOEFYai9P?=
 =?utf-8?B?UERES3QwU0g0Y0NNaTcwQXU1N29Od0RHOFJYc2VPODVnZ3A4V25LRzM1TVMr?=
 =?utf-8?B?NXFGQ2E1VGFiMnZsOFE1NllIRkJqcXJTUGFaWmZ4OWd6bFNxTi9yL2N5dkNG?=
 =?utf-8?B?TExxSjZRb21pUEpKcEx3U1BqeVpMOEpMN2ZmcGIwZVhvMnFaVGF0dWlHNm1I?=
 =?utf-8?B?K2FNdUZzeUhmMStNUE1lWE84dm9oMHZqSjE5TWxNbE10WVNpMzh2eWN2RzUr?=
 =?utf-8?B?d0lpQ3pRUDIyMEx5R3pRZHRKVUNrTEtpMVcwSDRxVjl1bG1uS3lhbExDSVFZ?=
 =?utf-8?B?ZmNDNmxhdU9CZGcxNW1ENkR4ejFNNGpRdkFHTHI2ZGYyeDl6ZkY5Q1l1cjB2?=
 =?utf-8?B?c1hCK1Y3eGIrT3ZPd3AvSFJpb2drZmxSYkNpa0w0c3U2ZTQ4eXB2a0ZkWDF1?=
 =?utf-8?B?RnhtUXptR0ZaRGQ5YSs4V0hhSWNmSTBLbEtwU2JXd2Y1cjk0RllWYVF1ZzIw?=
 =?utf-8?B?Zkdlb1FWZVJXUFV1TDJmNC9wY2tjendRYTRwdlB4Vi9QcWV3aDY2T2oxMkk0?=
 =?utf-8?B?WEFWU1Vlay9TdytRWk03bVpYdzdiZFlzcGFUdXlVN21oSTB5bVcybVIzNEo3?=
 =?utf-8?Q?OIEY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 736a1845-c4a1-45ae-7aa1-08dc78f72677
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 18:03:27.9077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XdTKoCzjx4/yH3paYEJsetkQzwiZz8EA2gY9uQq9EhAfYc+Hr7CS6Nxw/4chatZY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4169

Hi Peter,

On 5/20/24 11:00, Peter Newman wrote:
> Hi Babu,
> 
> On Mon, May 20, 2024 at 7:25 AM Moger, Babu <babu.moger@amd.com> wrote:
>>
>> Hi Peter,
>>
>> On 5/17/24 16:51, Peter Newman wrote:
>>> Hi Reinette, Babu,
>>>
>>> On Fri, May 3, 2024 at 2:15 PM Reinette Chatre
>>> <reinette.chatre@intel.com> wrote:
>>>>
>>>> Hi Peter,
>>>>
>>>> On 5/3/2024 2:00 PM, Peter Newman wrote:
>>>>> Hi Babu,
>>>>>
>>>>> On Fri, May 3, 2024 at 1:44 PM Moger, Babu <bmoger@amd.com> wrote:
>>>>>>
>>>>>> Hi Peter,
>>>>>>
>>>>>> On 5/2/2024 7:57 PM, Peter Newman wrote:
>>>>>>> Hi Reinette,
>>>>>>>
>>>>>>> On Thu, May 2, 2024 at 4:21 PM Reinette Chatre
>>>>>>>> I do think ABMC should be enabled by default when available and it looks
>>>>>>>> to be what this series aims to do [1]. The way I reason about this is
>>>>>>>> that legacy user space gets more reliable monitoring behavior without
>>>>>>>> needing to change behavior.
>>>>>>>
>>>>>>> I don't like that for a monitor assignment-aware user, following the
>>>>>>> creation of new monitoring groups, there will be less monitors
>>>>>>> available for assignment. If the user wants precise control over where
>>>>>>> monitors are allocated, they would need to manually unassign the
>>>>>>> automatically-assigned monitor after creating new groups.
>>>>>>>
>>>>>>> It's an annoyance, but I'm not sure if it would break any realistic
>>>>>>> usage model. Maybe if the monitoring agent operates independently of
>>>>>>
>>>>>> Yes. Its annoyance.
>>>>>>
>>>>>> But if you think about it, normal users don't create too many groups.
>>>>>> They wont have to worry about assign/unassign headache if we enable
>>>>>> monitor assignment automatically. Also there is pqos tool which uses
>>>>>> this interface. It does not have to know about assign/unassign stuff.
>>>>>
>>>>> Thinking about this again, I don't think it's much of a concern
>>>>> because the automatic assignment on mongroup creation behavior can be
>>>>> trivially disabled using a boolean flag.
>>>>
>>>> This could be a config option.
>>>
>>> I'd like to work out the details of this option.
>>>
>>> info/L3_MON/mbm_assign_on_mkdir?
>>>
>>> boolean (parsed with kstrtobool()), defaulting to true?
>>
>> I am thinking is not a big concern. We only have limited (32) counters.
>> Automatic monitor assignment works only for first 16 groups(2 counters for
>> each group). When the counters are exhausted auto assignment does not
>> work. In your case(with more than 16 groups) the auto assignment does not
>> work. I feel having a config option is really not necessary.
> 
> I'm not sure I follow the argument you're trying to make because it
> doesn't sound like an argument against adding a config option. What
> exactly do you mean by "work" vs "not work"?
> 
> Also it doesn't address my original concern about needing to manually
> (and non-atomically) undo the auto assignment in order to account for
> where the monitors are assigned or ensure that creating a new
> monitoring group will succeed.
> 

Sorry for the confusion.

Auto monitor assignment works only for small number of groups(15 or less).

After that point user can create more groups. But auto assignment will not
work because the hw counters are all exhausted. You need to manually
unassign a counter from another group and use that counter for new assignment.

I assume that you are dealing with more than 16 groups. In that case, you
have to manually assign/unassign anyways.

Having a config option "info/L3_MON/mbm_assign_on_mkdir" will not be much
helpful for you.

-- 
Thanks
Babu Moger

