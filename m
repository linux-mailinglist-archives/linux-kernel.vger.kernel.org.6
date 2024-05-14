Return-Path: <linux-kernel+bounces-178891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 990248C5924
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AEB21F22F8C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 15:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD11D17EBB4;
	Tue, 14 May 2024 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bYALMb2Z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9A017BB2F
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715702209; cv=fail; b=ZLUeIoZjv0vdEC/TLXic0J0fqlsPXJp0x+c/n0SzS0e7AmibkU4+THVRP36NmbJkqhQJ4Ok5f8IGxmdNmyStDwxwBsOjTzTO3cip3bBPxhUJCRmwdin0ece+W/H3+B2ibhqtbShsC/QnObCWTn3tCK1yGu3gCCXO+7nAqhU7EjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715702209; c=relaxed/simple;
	bh=VTaDUdgohkps+OMOeR8WG+T6S3wGvFyzrcHlBqOaN6A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L4pxsl2MGaqrEIynPw2y1fRDGAZaR/y9ccyBWlWGgfVNp2HzrQg18m6IGZqb7RmT5Y0zq2E9YKMz8V0Jwv6S4O3Wq3TheITJRmPk1q2t6B9qLDk6q3SvGGLQGe0i/7QB6cEHj4ckuVvchd8pF7AMknfSJcn4GY9rG9m3T/51yrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bYALMb2Z; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715702208; x=1747238208;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VTaDUdgohkps+OMOeR8WG+T6S3wGvFyzrcHlBqOaN6A=;
  b=bYALMb2ZNP6AxbT+OYmgtB6kLVtyKhnbapqevjJLJZZo4rW9BUc+6+Q1
   twJMrFjacRatQgLU5OvOTGCdLS0H8omGzuJh9jX0BImGjTmF3xQ7hXwxk
   HMLdLcZdz7M5uvVjRA8evHAhnVey2/a2JG4sE074WoOyjWOq+zadVO0qu
   kNVGxFqbyGqOBCWg48S1xqRT07q3HOocydpP/ff9F0G6xUa3lB71oAmno
   Nq0ogq/d/u//2BpKhb2koTf7cJZA0alZ4l9PJhvP0/Yvb8sMrBolKFXbM
   rjsGUJFXwry9x6yk2jCo18uvNWaLRTlj6J1PvNAnjT8JPlTS+zLLW5KnQ
   A==;
X-CSE-ConnectionGUID: 8tx3votjTMaqeGi5BbUK2g==
X-CSE-MsgGUID: qbyRI/RKSGe9P2RqA9eKog==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="23098256"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="23098256"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 08:56:47 -0700
X-CSE-ConnectionGUID: FqOjBgTBTGSJcFPD0IieMQ==
X-CSE-MsgGUID: pxTrJYwlS8mEXlt+CLiurQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="61547744"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 May 2024 08:56:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 08:56:46 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 08:56:46 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 08:56:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTB6u0Lca2Hj9ppcSHNXzqFYpOI1r6OygJ9kWjf4K0GdWcD7MkADBY4UBZrEKQqWQaUt2U8MDm4w1hO8gbZZ1XsVzrf+JnSAlHwZnyJmHG0UUpU+snZhEQFG+X5dMptLnjuPRgW5TMincTd3a4BTgcropssGRdwgAhuONaKbYDqdVNjv9DUm9gCQXrKvAq5QdLDM/bddPypgbIDWSLNQBA58ZBOkeK2dKynvwoC6CJekvkxpkGHTLG1pgIhN7xo+fIrv0e30Aw0V0ccW7AGjqBS/RD6lGuk30eRdIVDkbh6lvZ+jacAMarudd7t8/9PcixloXUvzcndgAU7xnssd6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0p2SQkptOJ8L5wISTHqqyd2zQREpAIjgp2gGXm1964=;
 b=eJLeT/mNgxjm0Y73hLNtft0iwgYI3HV6X8cM12q0/x47cDn3gyXIRqM9zRxsXnHYGdhE+lB4TvOHuRyfNbWspXoG0yVme1ne4mdHfuf31UsOKYWGrEwCbuTfKLZCX1eWY9wyLRJknW6kcVd9/TRcJwJs1rYLMfzFgCocMP+g/I3No0jATyU/7sFaBvE9vLbnQ1HklV/6VKbVI8ubRuw47Ix80ozwvPoPpxLQ/g+J1em5ZTbhbVwP2ehg7wqNY9J9argsekwAizWRdII4UDI6YpCxDbB12jbNP6u8yD4Q/lL1V5MMlXCmX7GBL2TYNfKQsSI7LNaOknDkcU4E+d1BdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB8290.namprd11.prod.outlook.com (2603:10b6:303:20f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 15:56:44 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 15:56:44 +0000
Message-ID: <64113803-e4b8-49a2-a217-e1be790872fe@intel.com>
Date: Tue, 14 May 2024 08:56:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/35] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
To: Dave Martin <Dave.Martin@arm.com>
CC: <x86@kernel.org>, <linux-kernel@vger.kernel.org>, James Morse
	<james.morse@arm.com>, Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>, "Shaopeng Tan
 (Fujitsu)" <tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>,
	"Jamie Iles" <quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	Peter Newman <peternewman@google.com>, <dfustini@baylibre.com>,
	<amitsinght@marvell.com>, David Hildenbrand <david@redhat.com>, Rex Nie
	<rex.nie@jaguarmicro.com>
References: <20240426150537.8094-1-Dave.Martin@arm.com>
 <b60aa6cc-7396-42c5-9a42-db8d6e8bfef6@intel.com>
 <ZkOAhH6tm1NXpre2@e133380.arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZkOAhH6tm1NXpre2@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0282.namprd04.prod.outlook.com
 (2603:10b6:303:89::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB8290:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fe91b3d-93fd-4ddd-f47b-08dc742e73f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnU1Smd1TEFNRk81bUpLekZlZU9Yc2pmS2Q0KzdtVm1DZ2JGMFVkMHVaczVV?=
 =?utf-8?B?Z2pEeHJWenkxNjFZZnk0cVZFVDFLRzZIWExUVXBWMTlWTElYMkpnVjlQS3Yw?=
 =?utf-8?B?ZXRaQlRxM2RrY3RsN2FCck95NDc0NUxUbmwxeG9IQ1lZTnR5dWplMjJEYU9Y?=
 =?utf-8?B?ZTJNVWlxQVdtVGxVd3d1cCszcEZYdmh4amp2b3BLL2ltTU9UTStmeUczT3Ry?=
 =?utf-8?B?a1k1SWZiSzEwMElYaGM2UlAwMnluUFVyWUUwWGFKWUxXTEJxLys0WFg2ZVlm?=
 =?utf-8?B?UjNsY2J6MkNpWjNtTnR4UlRNVXhHbDczM3RFT2I0dzJWVkVZT3gxaEFaS2M2?=
 =?utf-8?B?dndUNXVKVmFUTG8rMmkyd1ZpZ29tNVdITWRPWXJBZjVQcHVENjYzdmxiV0U4?=
 =?utf-8?B?QUprcStPbWxGOXdRYzVxb21rOURhVjhXcDhXOVJxOW4raEMxYnJscDhrbjBs?=
 =?utf-8?B?NVFzUDBrQ1NKaEtYa2puOGc0RS9OMHZNeE1zS0I4cVlCYisyT2xFNlZBYTlN?=
 =?utf-8?B?MzhlM3c0NFUzM252bTQvMVpOTDFPbFBzNFJQazNzQk1sMXlkeWlGSDFBV0ZE?=
 =?utf-8?B?UWVCcElXS056OURwSi9NZkJISlNzcFFRYmNTVCtvY3JwQnB3WmsrU2F4VEVa?=
 =?utf-8?B?TEp0OEs5cDh0Z2JjTXpXZnlKNC9WSE5jYmw4M1ZsNDhaTUJTMXlmeHRISktH?=
 =?utf-8?B?Nm1CRU91RnlqQXprV3plRitNTWdTYndiVWpaaXV3aHRKTG9kS0sxcTBtUWJ2?=
 =?utf-8?B?NzQwaEI4NTcwbjlmK3Vrbk9NNXJ4VjEzT25kc0pTYWlLanNsYUhHSkxRS1dO?=
 =?utf-8?B?UFZqeXIxU09RNzNmeWE3Z2pZYVloblByZ1lSNjFZcnlpOFJxT29LeSt1MnVK?=
 =?utf-8?B?UnpkUG5NaDdnRFBSN2FZdkRRNnZvTWFBT2pWaWxCR0srZVFLTXdhZjUxc0wz?=
 =?utf-8?B?aUFQQUNWT0o3dGxxUE1wT016QXAwWEZCM0hHaThNeXFlSkFrcW9Wdm5DZ2x4?=
 =?utf-8?B?Z3kycWdzNlhvTkZJdVE1R3diWnBmSXEySnJDL2lvbURkdFJJUWw5SVA3cG9P?=
 =?utf-8?B?eUtYRi90THFyMHdSdGlhMjQ4TWFuVHJEckhTSldQWnU3MEN5cnFhbzAvakQx?=
 =?utf-8?B?TUZ3eGtkMitnMUNzVzdmaW00ZlpPbW8xeXM2Q1lKUU9MaTZkSFlMdmx6SW4y?=
 =?utf-8?B?NDVpVlI2Tk8wcGp3YTZ0dTFjcnZKVmIzUTFDbytlZTZINjJBU0lXeFEveHNK?=
 =?utf-8?B?MER0N0VYNzF6eTRxM21TeW0ydkRxOVRpNzhBTFh5TE9DREc4WTg4dEtWbStE?=
 =?utf-8?B?S1hnVWxzMkhTVU1sQXl5dFhXRkhZYjgrMnc2cmg5bncrZEpJcHhWUSthOFdx?=
 =?utf-8?B?cWNPcmRCdEMzbmdnMlk2OVZycVEyZC9udjc2Y01zb3F3ZGNPc3o1NnZXNXgv?=
 =?utf-8?B?V00vMkJxQmFtVW9ybTQzdTJZN1RLTGt3T0pEbURHQlo5U3hoWmZWTG1nbisw?=
 =?utf-8?B?MHk5WVdYL1hzS1lBUUNjNGI5K2N4bGtFRXNXUGlhSDBjelgwRi9nWUw1Zk1o?=
 =?utf-8?B?a0pVTyt6R0tvSmJmZDVxRUlwTlM3MVEzeWtzK0V6bmw4eHMxTWZ0cmhDSXZ1?=
 =?utf-8?Q?KkgiotREewuHn//RbjNOXBzOJiXy5MmDzX2mKAfU5pJk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmJpbnVCbGJoQlpnZDFteHVyek9UT0xqUmFxd0xUd1NZZGxnVFZQSWswdFpT?=
 =?utf-8?B?d3NqQWxpUDRqRGNJbURjNVJBMjg1ZTErbUNlRm95TXFFZ21XeWJOLzAyRGlr?=
 =?utf-8?B?QTdwZlBudE1iQmk3bzdxNndCdXMwM0dOWVJvQUdqa0RLMmo5ZzhyMWdZYWt2?=
 =?utf-8?B?TDZzaGd3eEtvQlVSQVlVakNGYTh0ejFwaEI5YW0veTBFZWJVaVc1L0hjVWlG?=
 =?utf-8?B?RXZTcFd2cHc5MGFjd2paUEczZ3dlWUxyMzVid25peDE0MFpNQWRiVnc5d2ti?=
 =?utf-8?B?UGl5dG9Hd0xveHpiWDdwRGdTWWZXM0tSWWJZcithQkIreFhuUXNqd3ZHY1Na?=
 =?utf-8?B?ZmdwTGlQTjdVd2JWQWNyWFdVeXBLQkNScDhjdlZUeDVzQlIrTFd3UU9YZ3dL?=
 =?utf-8?B?ZG8wVFJ4NUtCRXRST25uTloveVJYaXNNTkVSdy91dFhQOG4rNHMwMmMyTUNl?=
 =?utf-8?B?K3owdUN0YmJsbmlzQzdOZU56RS9IYlZMRHlvTWxCNjgybU5oTUY2K25hZjhG?=
 =?utf-8?B?YmdRbUU0SkdiVzBaSWpYSXFueElQUFRoeUF6ZHFyaDlidHRsN3dqWEw4cFh6?=
 =?utf-8?B?bjZlTXgvenFaMUlLcE5sMFhqK2tCc3BId2Y2cnppT25GeWNJdnlja010bGZL?=
 =?utf-8?B?akxRUGdVcTVnMDdyL250SzI0NlpUNkUzNmF2dS9sd3hmNlBobkVaUmF5c1Vo?=
 =?utf-8?B?YmJSR2JMR2E3MGkzcm9IaHNHdWVMNUliaVRCZWRRbW1qUTVSUlVTc3VGeDlO?=
 =?utf-8?B?VDFWbDVyTGRIL3crZElzQTA4RS96TzBuS0w2OGcvNmdrbW9kdVNMVlVBc05p?=
 =?utf-8?B?L0wwVVBBazBNdjFBN1VkYlFveXNQYkRvbFFRU1M4MVowTlpkQkFCS3pkSHpo?=
 =?utf-8?B?eGNkNnJVUXhtVkN1Nzg2bmZ3M1dtUGpqMVpLa2dHUVFiZk5LdndVUkFHOUNv?=
 =?utf-8?B?a1dyU0JYVThjajhVSDJSUEkrVWZySno3SDViVXJVOVFaZWVFUXBiNSsxTWF5?=
 =?utf-8?B?MTFSSzQ3bTZoWlZXS1lra1VsYlZFM1Q4V2RPeTFiYzJoVEhRbjg3aXpKa1JN?=
 =?utf-8?B?VzZ2eWVKdUY2Vkx3QUR3SXBVb3EwY3JKbGdzQitJbWtnY3RGN2lSKzdIbTFz?=
 =?utf-8?B?NzhVeTMraGxqQkRWZmRHM0dVU3lFWTYzeXlCNjYxQ1U0UjJhTXdBRk56Nytp?=
 =?utf-8?B?WlNwRHJNcG82T05CZEFnc3htRHZOc3FPMGhyNmNpdmg1V1JtTXQ1WitDaVVK?=
 =?utf-8?B?c3FGc3JhU29VRVptWmFwOVpjMU5VbnZHQmZwcHk1ZlRnNWh2ZTBhc1hPR2tE?=
 =?utf-8?B?MGJONyt0eHRGb1F0YkR0OEZHeTdYNGQ2c3JNMEYzaUkvdGRiYXZCSGxWNlFS?=
 =?utf-8?B?dFIxQlVZYnNaemFJYThqbGFud0ViaWtGNlFNbEdPc0t2NUNEeDkrUzc2U1M2?=
 =?utf-8?B?aGNDeHd5bU5keVFHVnp2Sk9tNEhXaU1DTzRXM3h2S2NMYzg2T2JzK0o1WHB0?=
 =?utf-8?B?RHFrRkdQNHpWeWNraHpLS0NuZnk2ZkZIMmoybVREMWpXWUpVdm5heGg5NEtZ?=
 =?utf-8?B?ZnAybTlSdUhWTUhhTTJ3cHNyc0U3RG03cVQzT3htbVQvT0hEOFBXRFBaZ2U5?=
 =?utf-8?B?UG1zcWFhZk91K2QxN2U0Sm1XRGdud240UXRqS2lzY21paUlpQ3ZTQitPZy9W?=
 =?utf-8?B?UE1wNHRlSUkrZHpZdURpTkowSkY0Uk1HUjQ1MlFkbVVIR3dCcXVERVV2cEZi?=
 =?utf-8?B?ZGkvblVNSmFPZGw2cCtuME4wMlRCeVVLQmxMd01kNzVIZURFMy9MT2FJUnQy?=
 =?utf-8?B?ZEtwckxpTkZ2Qi80Q2tKVS9yQTl5T2dUVWo0ZUQyeFIxS3BoNHg5a2QzSlp0?=
 =?utf-8?B?emExdHdJRzVUQ0JKMXJKcFFEcml6c1NiV2puMFgwSlR0aW5HcnltaVNWV2t5?=
 =?utf-8?B?Tk9HdnpUTlNpVjBobjA0N3g4UDRJZkVrYTJ1VGVMMVJvdHYxWDZZWmR6R3Zp?=
 =?utf-8?B?bmVralgyRVBJR1RBS2FwUUdIVGludEtySDdUUTJLTDJuenF4Y2RROVdKQWNo?=
 =?utf-8?B?NnczQjhTYmV4OSsyTUY3VFI3ek05K2laQ2dQbEh1cDhqRWVYdWVqc29IZSt6?=
 =?utf-8?B?aWFSbmhMMHQydm0yTTVVdXBaUEVLTXNlOG1tZ2dQSGlkZldsNEF5REdxeitl?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe91b3d-93fd-4ddd-f47b-08dc742e73f3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 15:56:44.4171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MC9N+KDkTE6fAK0Tgx0ldyvHIS+f7P7uYUQzZG0wcEwWT15TZM3WiIvAmgoAZ5DoJ4AoWMqSc4fXtARM1za8ntpfrtFUuyOLl0YtdBUO0ls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8290
X-OriginatorOrg: intel.com

Hi Dave,

On 5/14/2024 8:17 AM, Dave Martin wrote:
> On Wed, May 08, 2024 at 08:41:37AM -0700, Reinette Chatre wrote:
>> On 4/26/2024 8:05 AM, Dave Martin wrote:
>>> This is a respin of the resctrl refactoring series described below,
>>> addressing review feedback.  Many thanks to those to responded with
>>> feedback on the v1 series [2].
>>>
>>> See Notes and FYIs in the individual patches for details on the changes
>>> and outstanding issues.
>>
>> What are your expectations regarding this series while considering [1] and [2]?
>>
>> Reinette
>>
>> [1] https://lore.kernel.org/lkml/ZiE8%2foXyjBef2qTy@e133380.arm.com/
>> [2] https://lore.kernel.org/lkml/acce93e6-4c8e-472d-a2bc-5cbad2950661@intel.com/
>>
> 
> I plan to propose a reworked version of the fflags and string parser
> stuff, and take a look at the other more minor outstanding issues.
> 
> The series does need rebasing, but otherwise I don't anticipate much
> change to the code from the Arm side unless there are further review
> comments.
> 
> Do you have a preference on how this series should proceed?

I believe that I already answered this question in [2], hence my confusion
about this posting. 

Reinette


