Return-Path: <linux-kernel+bounces-285841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EDC951359
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DC101C209DD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 04:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05AF3DBBF;
	Wed, 14 Aug 2024 04:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PB37G8lC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD40A376E9
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 04:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723608123; cv=fail; b=JWpcBNyov/dhQQcJOMWAdnV7dl3iso42Cxk5loj0ZlLNtX+DQFRNEkxbr+7+1htfpgVk/4Z6dNKjurxb0olmEXWd/CoTdx5hZNSWCQtOHzOAj5sAc+eUWIv+o5jnwMf3g+49cIjSYSTbj/gcxJj1g4vg8H//Cc/gGO0KWf6MXo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723608123; c=relaxed/simple;
	bh=4Rcd0xkwlrI8ZmJxU0QRAntSw3lY2O43Wn6oKV7knyo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iSp2QbFuw4gohk2bFJrFanN9OFi7FufKJJKVEqbYwUFjhGNTTeesCA+P493iHjFZEXWPoYKX9NHmW0CRBG8smXCCLYroP1kl3rANsiyZVQNcZeKw7t+XTf9cD2fprDEWkUZW/T6XIX1LtEdTU821tb4Yu5317k1IKowA6jNZcPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PB37G8lC; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723608122; x=1755144122;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4Rcd0xkwlrI8ZmJxU0QRAntSw3lY2O43Wn6oKV7knyo=;
  b=PB37G8lC4IzREo+0t7d0AiEGt6dZ3WadXVBq7dYQjjv3ewEuMpagNoMD
   AfVNPu8ouRWc4OIZHz9Ln+JuONP9ht6ltLTcsm7eVd1WB0e1xnrHcn5lD
   9sd+ccqRP3JTsuzrfvw9Qjyoyx9udJU7SpO54uyuv9zEsAdBAR5wShBFZ
   Fhu2URlB6KuG6Mz/nOChxSkkdFRDzv+lIRV7RvUDVjAt0H+bMXRaKc8Ty
   t/Or0EXThUJfJ12TqAR4ePNs6GE6UVKw5mLjUazVB82SeBidxMABBimcr
   HlnTblzV+sqTDR4tivqszRP0srBYOVaj8glS3TRqx8uKknqELAxMoiwaI
   g==;
X-CSE-ConnectionGUID: RjVaVT5rSnCJY6bsbfOsGw==
X-CSE-MsgGUID: bJGzxiWJQniYoMm2T9jLeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21360909"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="21360909"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 21:02:01 -0700
X-CSE-ConnectionGUID: 0LmshQQFT2G6w2oJI4F1Bw==
X-CSE-MsgGUID: MEhW4LtKTyKSlBD6luhvig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="58873088"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 21:02:00 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 21:01:58 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 21:01:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 21:01:38 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 21:01:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UT3jMQimS4KBd6nwXVUpugYthLw5bUfvqbvrOBu0SXi4mlad7FTorzx30wAb5hlCBJBj7zoOFCjuWlaww/oPmdQCTb47SQ2FMVQhXyoY+PDH1wp+a8A1T9P9lWTY1INGW/pwOUz79E8+cwR7mG+OyjxYYx0hNibXLfUaQhW6h7pD3kaahhy2XEAhtkcCikL91rTVc9ksFhYQx2RCGaz+aq31FgAeNvek6OOIV2hZcJhRxYLcyZuzO8MC0fsVaeTKcPiitV+Xg7HVLq17kx9AlHkyyWrGqIwgDP2r07wOX7npFz1p3bGDKxSi/kmWKA0s6pAanCD2CEXSwrF4DgFGuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QetVCT9jgBfvRno26uMAwHvPPf6VjAmSplksATlr5cM=;
 b=bC3zG6hPYzO+RDjEDVdaRgWFrIWu8TZ4SYtHMMXZ8tq2Eu+Kn0GGmLdhkAgjY9LAnOZd3Cecs4s3qcXuVos0APfDHp8j4/g60Z2v/EszDIAYnaF+TrdTroaDKS8wJES3VrEPMhrgjmF42asVMWngM65U5ODzsSMsPM/pFue3z3x/yWZSpIBqkk1CtKGA/8FF/k59x7aevJec9SwVQdt9n6e/wPhV82b4zCbSZERP8y1ULnLiPWNy04XZGVFlMEBBwVTCM1AMzUF0Q3P5qK0TuN5aQGFRlFCNS//y9/sN6x2UzgHNnXHlX8EoLWT9w5cWiTz5MobobcY3blgHImMuEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB4955.namprd11.prod.outlook.com (2603:10b6:806:fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31; Wed, 14 Aug
 2024 04:01:36 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7828.023; Wed, 14 Aug 2024
 04:01:36 +0000
Message-ID: <c4807d24-10ea-4baf-8477-4d876deff4c1@intel.com>
Date: Tue, 13 Aug 2024 21:01:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/39] x86/resctrl: Move monitor exit work to a resctrl
 exit call
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave
 Martin <dave.martin@arm.com>
References: <20240802172853.22529-1-james.morse@arm.com>
 <20240802172853.22529-16-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240802172853.22529-16-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0002.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB4955:EE_
X-MS-Office365-Filtering-Correlation-Id: 21eee0b8-663b-4456-22cd-08dcbc15caf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHdtNWlHVU4yMkRBajlKNDVMbVpFdUVPNUJVZkp5STUxeGYyWUxUK0s5c3lR?=
 =?utf-8?B?NzdmczdBSnp3c0ZsNjhNV0dRUUk0THJ3WFVBVFN6SDkzQmNUaXZNUCtlL0hN?=
 =?utf-8?B?WnpCQzNYVHlvQzcwN2wzeWlSekwzR3l3d3FsZmRZNVpleXYzdXpoUHVIOGc5?=
 =?utf-8?B?cVRGM0lkV1pQbzB3ZFdsVG9DSS83QkFrVHZBc1RiNFp0YTFtVjFnNitiSGZl?=
 =?utf-8?B?UWo1R01Nc0w2RXJJOXZCWllYbk1qN3phUTF5V3p2VkxpWHNNamtvd1c1Q2Zi?=
 =?utf-8?B?aWdsT0lmSms5K2hJZkJGeUVuT2FCNUtzMXNLQ1Boc3JIY0oxc3lzREIzTHpk?=
 =?utf-8?B?RGR2RCt1ejgzaE0vOFgvRnoxTjNsTkkwYWVMUXNwN0hXV2FYbVIwS1NGL1lC?=
 =?utf-8?B?WmlTcCtLR3ZHc0JPNU5SQ215TzNvak9ZNlN4ZzgzZE1lS2dTQVUvMS9nb1VK?=
 =?utf-8?B?UUh1dElYeTRzNHAweEZib3VYaTZkd0RxZVZla1JjenphVWxIVTJob3cySWJq?=
 =?utf-8?B?SWdPQkUvRlcyMHI1VjFLWVFScmpNVlYzMVQ2QVhZYXRQcEZTNHZSbUlxWnRn?=
 =?utf-8?B?aGhTTktzNXhnbzl1MEdxOVYxSkMwdmxENmx5Z2cvNS9HeHkyYjdRL0U3YTd0?=
 =?utf-8?B?MnFlK2NxRGhORlhiU0pOYTFpdU9oN1dQaWFWVXhIMGYxM0xhdGgybGVnUi90?=
 =?utf-8?B?RHM5bFNkVFEwaDdVbnJLL0l1SmZ2SlYzaW9wNlVnRG5WbDVveVBMcFhDUmxr?=
 =?utf-8?B?b3R3YWEzSXMraFNUOWx1eExiRFRxZThvZEdGK1pwTzhSRERjdG5oNDZhWi9o?=
 =?utf-8?B?NFI3TVJuWDFCb1dnYjVhakZjeGVPM09LUzhxUTZ1QTdBM0ZNaC8rMEtoOGRO?=
 =?utf-8?B?UEFCRWVOcGx4TWJrN3JUSlpVYXUyREJWK2c0UXJKTWF6OCtyQUZSZG9Kamdj?=
 =?utf-8?B?eGNQWFNwTHNDc085K0JNQTVMdUdoSmFwdUticS9TYUtQQzV1WnJiNDd4c0Nh?=
 =?utf-8?B?djQ1YW1SK0lxdU8xakZRdnlmMFNGVDdqQXFwbnUwajBHR285R2hGTEp3eU9D?=
 =?utf-8?B?NDNBck5LMHcvOTUyOTlQelVxNW5MbytjUEZjK3daZzlhRGszUWZDcG1GV2N3?=
 =?utf-8?B?ektzT2MvL1puUFgrUGg2cWZ0RmZWNUZRbURPb1RmSGw1VUhiQWZXaXFQYXM1?=
 =?utf-8?B?aEFJZkFWbnd3MHppUGMrZ3l0NjRkUGZlaGtvZk9WdU9jN2FLU1RUaDdNVFV6?=
 =?utf-8?B?R2VwVUErSGZCZFNXcFRDVXU5WlZBTUdxK1BBMUh1b0EyV3o1U0lrd2I5OHFB?=
 =?utf-8?B?UnBmU3k0QVk3WkFSaUZmNFY5ZHhMMzFuTWlmVklOZm9HSXVZaFc3QTVla2Rn?=
 =?utf-8?B?UHJPMUZJZk5hUXRJUE5iejhCNW0wVjI3TVdSTmp5dWJvc3NmSzEzTStXMDdE?=
 =?utf-8?B?dU5xdE9BOE8vYTRBMllUZmpvZFg2V1lIREE0RW5mVHZWR2ZldzZ4N3p4M0hy?=
 =?utf-8?B?OXB6Zi9XS2RvbGJQUnpKaXhtdVFwVkZHcmlSS0hwRkZKaUJaVGxjWUZQaFVW?=
 =?utf-8?B?WHpsSnZDZThPMnRmcWo1RFNKTlN6M3pkYjdnZG9Jc0VvSGY2RkRvcU1ZaUFz?=
 =?utf-8?B?ZjlTekVaTWdja2Uwak1idFVEY09CZDUzZ0E4SnVRQ0M3NDlmZDI1Ujc2OVlH?=
 =?utf-8?B?bXNIMUxWUjJlcFZkOVFNK3k2am8wby84cFdKR04rc2VCY2tCTlRsd1N1YXJN?=
 =?utf-8?B?VldGWWREYUZlZDg3c2IvSlNFemN3VDFxMmNxQldqcFdOT2Q1U05CQVZiQUZZ?=
 =?utf-8?B?OGdOM3ByeElZMFNHbyttZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmhUckYwS2xuanJmWHhMYjl5dGlqMDZPb0hDTWd0c1JwaXpGYk5FUmRXcXVJ?=
 =?utf-8?B?cUFDT2NVUlRDdFhDU0oxajRtVXRieW5BUUZNRExLZ25IVWxWT282SW1iWEw1?=
 =?utf-8?B?ZjZzekdBS2NMRlkvMHRuWWNXb25PU1Vleit1ZVMyWTdCVi9sNlo1OStreEd4?=
 =?utf-8?B?b3hMb2FmWlFEYmpzQng5eEJDN1IrcE1pdFM5Z1Jkams3a0l5VEw2V2NZTkt5?=
 =?utf-8?B?eU84YnRNTVdORDQrRzdrMEVIamJ5cy9wRXQxWTlzVS96MkV2aU5QeEswcFpY?=
 =?utf-8?B?UUIzSCtzbTBuKzJZbTBUbVY1LzRiRGVvZlNjS0tuM3FEc3NpcE5Jb2Y4L05n?=
 =?utf-8?B?MVJ1eUFHT1NQaUI1M0tYaEZaZlcyUDBHMXF3SmQ5VUp2dEFHaEtQQ2x4SUtF?=
 =?utf-8?B?ZEo2RDBPbjNDSHNBcUlpWlYrTmxVRWNUbm9IWXhiQjJiZVd0clVhOFByUkZ6?=
 =?utf-8?B?WE5ZY3ppNDNxcVk1bmlzcm1PNmR3akhsMGtUSkxyV0YyVDNRRngyc1hybUha?=
 =?utf-8?B?R3NxTUNLTS91UG45R0h3NXhYWnZ2VE10S1p3cDRZNEM5RjI5K1UxMjAvK2ta?=
 =?utf-8?B?Qm1UUXlLdDZSVjhpMTQzVDMrdDFLUWhWZTVUNFh3eG5NL0dEWVZXMy9ITlV0?=
 =?utf-8?B?TXUyQlgyNWEvQnUyWDB3OFU5ZFBOaGtkcjRxUDBHS3FOQ0VJL1ByVCtjN0J0?=
 =?utf-8?B?UXpRYVBYSXBMTGJCVm5LVE4yY2dtNHRleVh2U0xtVlhSUTMxeUtVQ1N0SC9Y?=
 =?utf-8?B?Uk15TkNEQUQ4WGdVM3Z3SjZCaHYrQnI0WDFCSy9JU1VBVzJIb2lzaEZzUmk1?=
 =?utf-8?B?YndpNXJmeEhETm9oZHJkTnFvL2UvWk51ajh3Q01XZkp4WmRPZVJYK3Fodm9i?=
 =?utf-8?B?TkRuN2FBZDFVdVQzRkV0dVlQR2p5SWpGTDdSU2ZGdG5oeFlwa1UxMUM2S2E2?=
 =?utf-8?B?Rk1lT0FCRkNYS1RHcjNhUEphVFhveEFCT2Fod09hMDFYQ2MyTmlBNHMycGl2?=
 =?utf-8?B?QWdrZGN2NE1aVDdCdDdTeGpzSnI3ZXFRZlgzcEozWmlYNnN1cy9zQnVUdE55?=
 =?utf-8?B?NTBsd2tGL012RVJpU0hPZWpsdkJ2NmQ3RTVBNERJTy91QTZXQzR4Z09hTkth?=
 =?utf-8?B?S0FQY0VLeUhBMXZBMmNzc2o0US9nSXB0WUxUNkpGaDJLRjVPRy9JSG50MUd0?=
 =?utf-8?B?TkZ6cTg1V0dQTFN0WlUvQ2JZM2ZVTXdkaXN2WEpvelRhMzdHYytkL21ndWcz?=
 =?utf-8?B?N2Y4WkhJYVpNUTFZNHhnZDh5eXlhejExM29aYzNZZGdZTnFUSWpVTHdyOVlT?=
 =?utf-8?B?b0hFdjBKYUptRkI5SkZ0YTI2a1I5eXg0RXpRUmw1bTFvNUhmRG5KbWhNWkJF?=
 =?utf-8?B?dHkzTHJ4VStZTzNncWxpODVIMHZEdFlMRDUyQ0RNaCsxMS9QQ3lCZS9OS1lQ?=
 =?utf-8?B?OTBtdmZoK1l3N1FJTWJ5YmlkY1Rmc3ozWWxZMEhScmt6Zmt6VCtiZTNlQnFt?=
 =?utf-8?B?d3dPRFdFUUsrRUxBWUJiaXZmdmE1ZG5tKzJ5Um1odTFVV3E4S3o2eHNKcTRu?=
 =?utf-8?B?S21Uc2V1TWJ6NGJ6aXRwUllicERXdGFKQ3hMcW9NZkpPMFNpWkkvODVPdWd3?=
 =?utf-8?B?MEtjRjhrZVlVMWkwNFVJVUhqaGFEYTI5MWZkazJkT3NFdjJSU3o1TCs0K29x?=
 =?utf-8?B?WXMzd1JZTW5QcWlOdjlCY3hoNythOVFOOVFWR1JrazhvbG5HMGtFZ3I5Wmk5?=
 =?utf-8?B?NnlHeitQYjQyaE5YZWl6SUNlNXp0WDlmcXdYWDVQdGxHTE5tNnMxN2VKRk1j?=
 =?utf-8?B?TVg0NVgweStFOVBVT3c3S01lb3FiTzcwUmlqNUtLSjIwUHhaSU5od0pSZFBv?=
 =?utf-8?B?TFFKVHl4UDhhdVFzNC96bmcrMncrTUoyUHh5M0xBUkNVWnNvclJHVHJYSm5G?=
 =?utf-8?B?OWFXd2p1WTVpT1pNaHpWVlpqa2k0cVNvLzBVb2pRSS8zck55em9LYWp5TU14?=
 =?utf-8?B?WklwL2dpSzErWUNDVzNPVW9UaDNBbnZUT3ljYm1iOHgzem1NWGwrdndGMGp2?=
 =?utf-8?B?MGZzUVFmNjZ3RnJ6TTFPejJBVDN1Zm9mMUNPS0pIemVFM1A1cGRDOXdCR3FL?=
 =?utf-8?B?VlpuZ2Z0cGdiVklObVlJeXprU2MwbThscjdOZnBJYzFBTGNNMDhxNExiNUxO?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21eee0b8-663b-4456-22cd-08dcbc15caf0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 04:01:36.5475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4bF6rtNk4IKuKHUAtH3WZPBSotupKyh36aIAmE1kGTo91ddQHksztzPj2wRtpE+eprd/5bBKdb7Nglq+hLOIsGo+JyQD8W+mDYkB3GBGHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4955
X-OriginatorOrg: intel.com

Hi James,

On 8/2/24 10:28 AM, James Morse wrote:
> rdt_put_mon_l3_config() is called via the architecture's
> resctrl_arch_exit() call, and appears to free the rmid_ptrs[]
> and closid_num_dirty_rmid[] arrays. In reality this code is marked
> __exit, and is removed by the linker as resctrl can't be built
> as a module.
> 
> To separate the filesystem and architecture parts of resctrl,
> this free()ing work needs to be triggered by the filesystem,
> as these structures belong to the filesystem code.
> 
> Rename rdt_put_mon_l3_config() resctrl_mon_resource_exit()
> and call it from resctrl_exit(). The kfree() is currently
> dependent on r->mon_capable.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> ---
> Changes since v3:
>   * Moved r->mon_capable check under the lock.
>   * Dropped references to resctrl_mon_resource_init() from the commit message.
>   * Fixed more resctrl typos,
> 
> Changes since v2:
>   * Dropped __exit as needed in the next patch.

Is this still relevant? It is unclear to me why __exit is dropped here.

> 
> Change since v1:
>   * [Commit message only] Typo fixes:
>     s/restrl/resctrl/g
>     s/resctl/resctrl/g
> 
>   * [Commit message only] Reword second paragraph to remove reference to
>     the MPAM error interrupt, which provides background rationale for a
>     later patch rather than for this patch, and so it is not really
>     relevant here.
> ---
>   arch/x86/kernel/cpu/resctrl/core.c     |  5 -----
>   arch/x86/kernel/cpu/resctrl/internal.h |  2 +-
>   arch/x86/kernel/cpu/resctrl/monitor.c  | 12 +++++++++---
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c |  2 ++
>   4 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 4a0dbdc2da4d..9d4d64b4e357 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -1101,14 +1101,9 @@ late_initcall(resctrl_arch_late_init);
>   
>   static void __exit resctrl_arch_exit(void)
>   {
> -	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> -
>   	cpuhp_remove_state(rdt_online);
>   
>   	resctrl_exit();
> -
> -	if (r->mon_capable)
> -		rdt_put_mon_l3_config();
>   }
>   
>   __exitcall(resctrl_arch_exit);
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index d355aa676158..3fdeca6e3d21 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -579,7 +579,7 @@ void closid_free(int closid);
>   int alloc_rmid(u32 closid);
>   void free_rmid(u32 closid, u32 rmid);
>   int rdt_get_mon_l3_config(struct rdt_resource *r);
> -void __exit rdt_put_mon_l3_config(void);
> +void resctrl_mon_resource_exit(void);
>   bool __init rdt_cpu_has(int flag);
>   void mon_event_count(void *info);
>   int rdtgroup_mondata_show(struct seq_file *m, void *arg);
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 9cdca9d2bbde..afbda09aacf5 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -1044,10 +1044,13 @@ static int dom_data_init(struct rdt_resource *r)
>   	return err;
>   }
>   
> -static void __exit dom_data_exit(void)
> +static void dom_data_exit(struct rdt_resource *r)
>   {
>   	mutex_lock(&rdtgroup_mutex);
>   
> +	if (!r->mon_capable)
> +		goto out_unlock;
> +
>   	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
>   		kfree(closid_num_dirty_rmid);
>   		closid_num_dirty_rmid = NULL;
> @@ -1056,6 +1059,7 @@ static void __exit dom_data_exit(void)
>   	kfree(rmid_ptrs);
>   	rmid_ptrs = NULL;
>   
> +out_unlock:
>   	mutex_unlock(&rdtgroup_mutex);
>   }
>   
> @@ -1238,9 +1242,11 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>   	return 0;
>   }
>   
> -void __exit rdt_put_mon_l3_config(void)
> +void resctrl_mon_resource_exit(void)
>   {
> -	dom_data_exit();
> +	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
> +
> +	dom_data_exit(r);
>   }
>   
>   void __init intel_rdt_mbm_apply_quirk(void)
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 1597add37b97..576f6b183980 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -4291,4 +4291,6 @@ void __exit resctrl_exit(void)
>   	debugfs_remove_recursive(debugfs_resctrl);
>   	unregister_filesystem(&rdt_fs_type);
>   	sysfs_remove_mount_point(fs_kobj, "resctrl");
> +
> +	resctrl_mon_resource_exit();
>   }

Reinette

