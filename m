Return-Path: <linux-kernel+bounces-361843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB9E99ADB6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 22:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBC211F21AA5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 20:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F971D14EE;
	Fri, 11 Oct 2024 20:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EyT5KOhx"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1061CFED3;
	Fri, 11 Oct 2024 20:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728679798; cv=fail; b=A4dDh2uBEaElE/E4hbWDGuqgJODQWKxaAD+dzDDvAzcoSS0rJ2gCL/MmhcWOH+Y0R6G3iNrS/I66DTey/GMafHPrXBgr+teycNDgNuo3PMOhiw9engI94ZVC5SEchL122E6zNKekjgJagBhs0ZBp3NUHNWVgaX+74CZf+3VV7pA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728679798; c=relaxed/simple;
	bh=/fyO5ASg6uvO2qwFbk7BS0t1LePhNh8lNjpZmAmRTps=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uctiQlh4Fv3K/Fda4d22Jagd4TYG0RqLuRM/TbgKZxieFAsXAois7V9XXhSNl5y+h4UlYrHsPdmkXhrCiChB2HyB1/Wi3gAXk2mXPgO+72Y06O+Bcybxk29kGglyR4rmZCTr79BRRa/LHWPrJW0kQtGSZs9hfCWpxvmZHjJ5OqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EyT5KOhx; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIjjBEbNxHFzYc61ZF6YNZSEGYCiQiR6Ug2fKHVyyindAs6GTYt0+4KTnoYcOv5YH/g+9WYlSEwRN8kESIMgC7g6y+Wwuf6679scqKIKnVs1R3OavbwEmZoHdV8T4M9iNEsbM5gGb+df8+vxb3ZJWcGQOeOiIanaJyc/1CwkRWhiLauipm/m77Thz3ePM/xNbs9XofukXbZoto+IPENDSeBnyWOoJKHmXNJEfqsbe/hr1/ZuLKrgoNFcQiIRNBwu9XLHgNShQkOF5h3yC5cvmX/H4reb1X7TmnJX9MiSztlrJasMgA1V1X+1pUIUrKdyX20whZYqjHb+2kaj45Rcow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sM20q83q22l031Pv2E+NTZZAttmeSy8ft6Vtn8nfBlU=;
 b=LzW4uOq9bPFj9efY395Lsw8lkUs2jCaKlUyeAEdb53hF15kw3KueQUO6mHOreJe7i8M8fs7h5yBUmEbQCMtuSDnvGZ89chFMiLKtIRtQJ6gj0yhlUHZfhcL2UlJkQmcV5A6Jb3gTd/SX3g87AexArgHutk5CbyqCBuqn7kjJ7VWCzQmb6/oQgrpXXJpM4vLMfbCLKXdS9PETaB2JGPukUnL0hzzRDdPoA+KcBo/gdd6bWyJgOGe0QDXiAXFzAfRw8WBMaSebjtzs4eVTaAdWuOgi1IlBsca33b3fO1EByAOqIY6D4zKfGd5IabkZrud6W25592XvKgnyYiUKvmJJ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sM20q83q22l031Pv2E+NTZZAttmeSy8ft6Vtn8nfBlU=;
 b=EyT5KOhx/jZioRJe77cT6xyqTtUmE1pYU/rVPWpGZ8pt9krlwYNn8rM0XAplooEhFHe/mC32IqyMgulkU7uqm7Ttqg/lafY4Xc0GRdPurObFv1oXOigFd46w/RoJ23snqWd+tAykAq/XPSahWUSvBp5a7+eGdLoniok6fDDNHqw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ2PR12MB7989.namprd12.prod.outlook.com (2603:10b6:a03:4c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 20:49:53 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8048.020; Fri, 11 Oct 2024
 20:49:53 +0000
Message-ID: <8af0ce3a-1327-3ffc-ac5c-e495f9cdf5d0@amd.com>
Date: Fri, 11 Oct 2024 15:49:48 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 08/25] x86/resctrl: Introduce interface to display
 number of monitoring counters
Content-Language: en-US
To: Tony Luck <tony.luck@intel.com>, "Moger, Babu" <babu.moger@amd.com>
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
 <c79fdf4196d974325df995eb334221463747689e.1728495588.git.babu.moger@amd.com>
 <ZwcIkf_oy2oKByNu@agluck-desk3.sc.intel.com>
 <8ceeb50a-70d7-4467-b7c1-4f62b1a1eec8@amd.com>
 <SJ1PR11MB608381B9DA3AE26749070BE8FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0fedcbd4-487c-4d55-8151-69dc34f41f1d@amd.com>
 <SJ1PR11MB6083FFA19F9387F21C058A09FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <d1986f3f-9db7-4ac9-9fea-56878548ad61@amd.com>
 <SJ1PR11MB608382EB9F40FBDC19DF71C4FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <1baa07f6-0ccc-4365-b7b8-09fe985963cd@amd.com>
 <Zwlj5TQxZphcuDSR@agluck-desk3.sc.intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <Zwlj5TQxZphcuDSR@agluck-desk3.sc.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0144.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::22) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ2PR12MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dbdc5f6-9592-4e64-7784-08dcea3641b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGdmaFZOVDJNNTNRaWtvaWtiZ0k2QlNPeEhscUlXdHYyN2FvejNJQ1pXMjhu?=
 =?utf-8?B?OUdRUDh6ME0xaTdKM1BiWngxWGpOUTJHcjJyd1pnTmpGN3UyWm5UMEZMZ3pi?=
 =?utf-8?B?Qk83UFVic2FsSG1XOUg2ekhXdFFjZnZKN0VmTlI1WGZPcUZLYVNDMTlVQ3VU?=
 =?utf-8?B?S1hhMWxMK3htM0I5N2I3OHl3eVdCOHAyZzQ2Tm00eHR4Vjd1SFdwRFcyTGdu?=
 =?utf-8?B?dWpmdklxSCt0ei9XdXBKQmhHam9selNMa0xFRzc2elRHMUFNMUZlNGFFOGJP?=
 =?utf-8?B?NDd5elp3aUdvNEdhclJvbUFKNno3NGdvU0tZU1lPL3pEVXY2VVhzVkNGWUpV?=
 =?utf-8?B?bm5MVERzbkRMYmlIVXVaOVhxNXdmaFh1bmxJQlJ6TTZleUxoYmoyYlVyZUhR?=
 =?utf-8?B?Ky9CcWV4SUd2akN2aHNKTXZDM1J5RVNrdGxwMUFjN3FhSmQrRFZyUFNIc28r?=
 =?utf-8?B?M1ZJbVo3cndTV1ovVnVDdkhCb2dSbkFVUnZuVDFaUk9FV0lLanE3bkNqZ3Nw?=
 =?utf-8?B?and0VVRDNXRUUyt1K3F5RThIYmNFT1JLSTFlZFdOTGUrMFZaYlB6enNOSVFJ?=
 =?utf-8?B?TDFBelc2K29GWUN0VHlMeXQySTVYb2JITm5nMU9IaGw1MDNPNy9xL1ZTcURx?=
 =?utf-8?B?Sk9peHVYQU1YTEZtTWlZdkJvR3VvbUNadlBqeE9KRzI0alpReU4yVVdCcjFy?=
 =?utf-8?B?dkQwM2hCUENCMXluQzFlQlc0dklWMWpIOHJ4bmhLQjBUUEFkejlPYm4wUGhO?=
 =?utf-8?B?cTNrSHYwV0x6NlgzY3N0M252UHY0UE0zMFBzSHljemxHcG5RbFdHN0I1UmhC?=
 =?utf-8?B?WStKbWlSTGdjZW9tblkvekFxYUMzcUkxVDlxakhCREltSHltZDZiK09XVjFv?=
 =?utf-8?B?VTBHTlBITUlsNmZ2azZza0VzS2RyUUFCME1Tcy9zVSsyMWZzR1FKaTdRK2Jp?=
 =?utf-8?B?djhrVkRGVHNtZWNuY2g1VXA1UjFnWE1nWFd0bHJHdW1VZW5DQW14eTg4U003?=
 =?utf-8?B?Y1U4Q281NHYybTYrcU1aa1RqK3JlU3RFbWt4RGc0eDQ5WTNSeFdHeGpoeklK?=
 =?utf-8?B?NCtnR0RORkltdUhuZmU2Zk9vbkNIbDlLSThPd2xaNW1zeWRTajMyNHk0V1E4?=
 =?utf-8?B?TWI0a3dEZnNlMldQak0rVUpKV2RZTkMwNGttb1BhUVJQK055YkU5VkVYYi9V?=
 =?utf-8?B?SnRTdlRIWnhhL3hsdHZOUFNnbFdCSVRnT1F1T3VVMnZVbmtqSzc2ZGhHWk15?=
 =?utf-8?B?WEJPejdnUUwvMmpieFV4clkybHQxVk9PVXpsVjgxdHRkZ29pakhta2lTbGtW?=
 =?utf-8?B?MzBIcm1pZlhiOVB1azJvb0dwTDhyNFE5S0tuTjYvaDlMNEpOcVlJQzhMR3Jz?=
 =?utf-8?B?TkY5M28yZ2RUa1gxSmVJTGJYeDY3bWhUVWV5aXB4L1hGT1JHb1lTV3dqa213?=
 =?utf-8?B?M2xnR0g3RlhhbHV6Q0F4VnU4ZHRRVDFoZkpITTNoWHpHS2JmM2tZNGRrL0tM?=
 =?utf-8?B?b3A3UlpqN2U0NWdxSHVnSWZ2bEVOeHdibzhGZ2M5SjlDaWswOTZMQzlYUit3?=
 =?utf-8?B?bDk1VUlmbjI4MUJKQUsvZmlmbXhONkhXWGJqcWM5cHZnckRwSnBhTDFwV3lk?=
 =?utf-8?B?QnpsRUlwOVVtV21qNFBBZVZQWThrS05NVkpNemY5VlFYQU4xRDNZVlMrb1FM?=
 =?utf-8?B?TVBJSDdNVUZWaDVPQUtnVGFmZnFIK2xJUlJVRzJCY1EzeVFFem05cFRRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzdKZm9hek12VFozZXFUZDMwVzhwZXpVVkg2dUs1ZEhCaGNWRlNDM0o1WURU?=
 =?utf-8?B?SGFiNXhLaGJDeS9yRlFrR0pycFVFdmlvVldjUmhMVXFiQ3p6MXBqY3hGd1ZC?=
 =?utf-8?B?Z2RJTTF5UTQwaEVvUytNQmJ5OWJpbWtWb1l3S3hWSlJjdnBjSDJDN3FzODFJ?=
 =?utf-8?B?VEwySjhNK3pBSHFwOEtndlNGaGJjek1uTnk0R1N6L1BQaWtZb2VNQi9MeTZN?=
 =?utf-8?B?MWM2OUJFTW9KWExKUTFDMlo5UklublV6dXR2UitZdWMxZWZWNVN3NXFRZjZm?=
 =?utf-8?B?SGN1MjNxU3dLdVNJMi9WU3JxZEhqRkRrc3BNZS9jNjd6YlpUekozeXpHQy82?=
 =?utf-8?B?VWZyaVpodjcydHNsby90c3VUTjhwblpLNi9DMEE1NjRzVy9TaU9HZ1VGWm1w?=
 =?utf-8?B?YUVlL1dGVlpsL0p1Qm4xMWVMY25wa2ttSDczSk9uYzRVWXhEazdvNUVVQits?=
 =?utf-8?B?N2hTZDJ4U0s2YnRKQlc0cUxrUCsxRlZBQS9WT1ZHeVcyWXd3SlFZdUV5Tzg4?=
 =?utf-8?B?WUZCR0lmcUQ0YkdIQzJPdko3Ni9jUCszV2xaNisrRFFnU0ZNaGZJcm9XMVNC?=
 =?utf-8?B?YWpmMTFmL2NwWFJBc1dFTGh1eFpQZ2VIZnd0SjB1eWpaZkU3NUtJZmlXTFdS?=
 =?utf-8?B?Qkp6ajExdGoyVlBGcFYxL1F1SG8zdEZYc1hEU0l2SDBjdDJuRENSc3ZoY081?=
 =?utf-8?B?Q2V4eVp4bFpnbnhwdjk2ekowbjc3Mmx6d09tVFhUelo3ZjRmdmxmSlIxWHlV?=
 =?utf-8?B?Z2szOEZQcHFZOXlkRWxvelh0bWY2M1pKU3g4N1p4cUovazNndmRpem4vWUJK?=
 =?utf-8?B?ODRWN2QyYTZPRGE5Q0lENXdRQXMza2N3YzZzQ3FDZGNCTjl4S2NrUGZVUy9w?=
 =?utf-8?B?QjdYWk9leUVqNGIyeUlYdVBKUEdWbndKY0ZxREdJZkdxMjBXb0QvdnZGNFc3?=
 =?utf-8?B?SE1YdUtHaDJPQTc2VDdPT0xnUHc0YzAvbzkrYnVBRm9aa01XeEdSY1F0WmRa?=
 =?utf-8?B?YWhuVkl4UkFQNUhJTEFUR24vOHgxU1hZbWpxdncwaytYUTJvcnAwZlZPOEpl?=
 =?utf-8?B?ZWdSc0tyNVJQWjNyODIrcnhiV29ablpNUkRlcGNkUUlsa29EamhBUDY4L2ZS?=
 =?utf-8?B?MjVLU0FkazNKTExDb3E4L0IxbTNmNzBZd3lzU1dpeHJpclo3ZHpHbHliNVZl?=
 =?utf-8?B?Z0VFSDZGZDBKeHlVaDMzSFVVa1ovdXJURUE5M05QTkFGTHNrbDl2MVZ0ZElo?=
 =?utf-8?B?Y1dYVkgrL1lEUk5jY3NEZllCdkV0cmJMNjNwK2lJdFpxNE9LRmhoTmNQM2J3?=
 =?utf-8?B?Q2dYMHpReXpPRTRTT2lKTVV1bUVlazFWTUxNQjJDcXptZGtiMmhmZm40Rk9v?=
 =?utf-8?B?RnhMeFdmSFA0RzR2MHErYTNiVHRLdXN0ZkNUblNmUTltUW5PMDlTaXBjWjI3?=
 =?utf-8?B?OFN4d2VTNFFJYkRSeVBkYW5BUklGcERPRzRxaDY1UmNINTZrT2hqaUl2eHJq?=
 =?utf-8?B?a1I5U2hZK1pmNEFtSzFUTzRubStYeTAzM3l3OFpSM3daLy9YMHlTR0hhUkcx?=
 =?utf-8?B?bE5jQStma0xqeXBPUnpwQ3RncmFUVHViNEZsOGxtNGNJUjIwL2Noakh2aDhy?=
 =?utf-8?B?WGgrOUlUNkRFQUtHd2NxZTR5UHIxK3BVeDV2RUpqNlhsdVVzeEw0OCtpMUx2?=
 =?utf-8?B?ZUsycmxyUk4xUFRSQjhId1Y5TUxERWZKcGNuYStXa2xVcnFWQ1ROaEhCa0c3?=
 =?utf-8?B?NmJyMmRXUkw5UFNMeXFLeXl3VGFkeWhMU012VHlIOEN6OVFLejJscHVKcDM5?=
 =?utf-8?B?OVZFalBIbENTRUVMRTRHb3QvT1RCYytDL3BZaU02OXZpS0tyWlQwL3JkVXJ5?=
 =?utf-8?B?RGdOMFFhbkdHWUZqSU1HNEkzMzJBYUNJaVlLaXNycTM1YjZNSHJOaFFBQk9a?=
 =?utf-8?B?VEtZeTVVaVhNQUl4UTVFYyt1SlR5MkVUNVl4WEpKckJLMk5KODAzNzlSVm5F?=
 =?utf-8?B?K0NZTDQ2TUdmWS9HclpDUTIyN1RMd0tZa0NMWDUwSHRXNXZJcG1ReDZoZTdi?=
 =?utf-8?B?VlFRN1pyM1J1VWplcVFYK2U5RDJXZHhKdEJvT1F2aEdOWVg2YmhaYkZDUGNS?=
 =?utf-8?Q?AWKQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dbdc5f6-9592-4e64-7784-08dcea3641b8
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 20:49:53.3025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6afFghRhPX8l4pipBm/rwVrZ+/0XBDFH0ijNCzv74oFdoYut8U7mGYirbAji7Lh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7989

Hi Tony,

On 10/11/2024 12:44 PM, Tony Luck wrote:
> On Thu, Oct 10, 2024 at 03:32:08PM -0500, Moger, Babu wrote:
>>> # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>> //0=tl;1=tl;
>>>
>>> there aren't separate counts from each of domain 0 and domain 1.
>>
>> Yes. There is. Each domain has its own count. I am not sure about your config.
> 
> I've been reading the code and see better now.
> 
> There are a bunch (32) of counters per domain.
> 
> But you have a system-wide allocator. So when making
> a group you may allocate counters 2 and 3 for total
> and local respectively. Then configure the local instance
> of counter 2 on each domain (recording that in the per-domain
> bitmap) for total bandwidth. Ditto for counter 3 instances
> on each domain.

Yes. That is correct.
> 
> If the user updates the configuration to stop counting
> on domain 1. Then the per-domain bitmap is updated to
> show counters 2 and 3 are no longer in use on this domain.
> But those counters aren't freed (because domain 0 is still
> using them).

Yes. Correct.


> 
> Is there some hardware limitation that would prevent
> re-using domain 1 counters 2 & 3 for some other group (RMID)?
> 
> Or is this just a s/w implementation detail because
> you have a system wide allocator for counters?
> 

There is no hardware limitation. It is how resctrl is designed.
In case of Intel(with two sockets, 16 CLOSIDs), You can only create 16 
groups. Each group will have two domains(domain 0 for socket 0 and 
domain 1 for socket 1).

# cat schemata
     MB:0=100;1=100
     L3:0=ffff;1=ffff;


We may have to think of addressing this sometime in the future.
-- 
- Babu Moger

