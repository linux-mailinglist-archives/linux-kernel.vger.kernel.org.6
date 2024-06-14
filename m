Return-Path: <linux-kernel+bounces-214162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2886A90805F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 02:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD378283F31
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 00:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8A14414;
	Fri, 14 Jun 2024 00:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l3WQap/V"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BEF1854;
	Fri, 14 Jun 2024 00:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718326658; cv=fail; b=N2UA4qHm6EucNjXtgoO9KxkrFOXaTiLBiwSSIlvLtCsT9N+elmvU6EbYDdiv51Z8mUDrePNJARKHvByTZKVkMvkPMFv2XOBEkZRL0dTtwVaTsEmQ2bFFYRU8U7ZR2cm4DZVbj2lLXBOUP18vqQPAdaCuUj5e1PEcGi7W/RtmKKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718326658; c=relaxed/simple;
	bh=VoXVcwrhWI11wJZDJCVcCjKmG/oz3HxzazyWTRIRgZs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gY8unV2NygSnPsJIQ4vw+mQNdpQxQXtRg78y5nLO9MSbjqo0lt94utiTRLGcgld6drs1/oxyOLP69Y5PE98gJ6LJZ1UPP0zU2BPvQLFoWutkO1lRT3OPQ/2RYcNHC7ggI7uA2ghU8A0N9sN1Ovc+M4wzReMmA63utYlVLPiYeO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l3WQap/V; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718326657; x=1749862657;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VoXVcwrhWI11wJZDJCVcCjKmG/oz3HxzazyWTRIRgZs=;
  b=l3WQap/V7cVbcaFfek3h55BrcL6ScdbfwEi1DafJ9f3NcSxwZRf12Nwq
   n611xxbCP40sU2wmn0RYPF2aHHrSoWTI0dvt8DR2WzQCA6/cUGf2gw2pE
   jUPs3ISent+XU2jmfxjLJC5BSWtfAE0Io4o4diJ+HRjTxZsTI6IZ9M1om
   A+JNxTJM/vHFJBUTikNVzrb3pJH2aK2Jes9BkneEM0+RSBIC0Fw80lDJ9
   hnm1PM6SaTX3wOpPppumbt1Kefvohcib4qL4LdxD4+S2OzS+pMnLxvRBB
   YLc1LKdPwYwfDddLA1jb54C608+sslkytReVQWs9TxxbAP6FCyKTi1MLR
   A==;
X-CSE-ConnectionGUID: 8NAlx883RFyhI7aRibwr1g==
X-CSE-MsgGUID: FBG278NZTqmxOgjFP7QHHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="25870480"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="25870480"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 17:57:36 -0700
X-CSE-ConnectionGUID: EMeyB8+4Qeah351d7iJbTQ==
X-CSE-MsgGUID: ZNcGjX0RSWaR0iU/jdRUZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="44759286"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 17:57:36 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 17:57:35 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 17:57:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 17:57:35 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 17:57:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIjO+B8EhV3owx2zQxtjPBYDu6AsJaazonAtU7xMj/N1iOj/xOVBWUNd6n+1135ZpFm49Wj6cdlEkhD8UeZRFznVCALo6j5o+dUFclePjxNYg3dDUeAdTaiVogmwJV/6nWRmk2FaMH2GnpC2YV6pB702R/+rxxVU0/+ATamFJV/BmpliG9sw9ct3qInICZ2ETgP2MpV3xW811dFPetVZyoTm4mJRMNFynD7Nq2gkWoiGkiNbcXosxtHdo/O7qhQ2B9DE42BHkMFwujy/6qgP/bl4dQQaZl+E4iAIDON4KpPa6nG/h6kOAttLzEH+I19XIWiRnRiO/ELLuYxcH6jcng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxr6ag7YRAizOEo70c4INkT8XqJqidhFwMGfG9i+Wyk=;
 b=hgGHUhdZhYwAjCv+vDpFvQhkmofo8vI/06o4oAnB4NooOVatPpgeUW0fq7yJZRBmyTSwMinBrZdhZGfGKYGA74tKGrEJZa+TsZjIaIYj9KqtCz1x5oQlwArdLTYC3EiXJ1EWDJpc4rQ+c6AkgjTmLczOYjB9bL+CSJ6q3XMkIivHZKuo1WnYoG+/oHRITU/a14LkEj9O0RRC9OYZNOP8XORf8Y4lWI6OxHA1Bqml6umU1GmBzYfSrsbI7p07wQdHejxTJ/TwKyXwLVYlOwEGFu2eZQrfxgX3Fl5qiiD63IKxxg0fYJBRUPAC9JcKgFjuUrO55Q6mta8PZJ2YheZ5sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB6861.namprd11.prod.outlook.com (2603:10b6:303:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 14 Jun
 2024 00:57:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 00:57:27 +0000
Message-ID: <69c72f43-6b1e-4c83-861c-375fe15a74b9@intel.com>
Date: Thu, 13 Jun 2024 17:57:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/19] x86/resctrl: Introduce resctrl_file_fflags_init
 to initialize fflags
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
References: <cover.1716552602.git.babu.moger@amd.com>
 <67c8cd614925496971496a8fab7459cf5c037652.1716552602.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <67c8cd614925496971496a8fab7459cf5c037652.1716552602.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0010.namprd16.prod.outlook.com (2603:10b6:907::23)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f337092-938f-4307-e234-08dc8c0cf5e0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|7416009|376009;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZDB3MWhpMlMxQ3dzcmV4MlI2cGdOdlhZWjhxVWgwSVJoeVg3UHErV01BdDdX?=
 =?utf-8?B?ZVlkc25aQmFqZG9kSXZFcVo2Rm00bWJqTDNLVFM3eTUzcEFCYVlOcWZNQ2M0?=
 =?utf-8?B?dTQyM0xOc3luVnczRktQaWtqYkxUKzhtWmk5WHRiTHpKb21HK25QZUtEK2da?=
 =?utf-8?B?eUpiem9QOGQ5TWlXUjNhQjNSRkg4NU1Zdm51OVlxdUtFejNudldKSDZnT1p5?=
 =?utf-8?B?d0wyaEt2bEdOV05HdHErQWdMVUpSZzdNbEhiT0JHRUM3c0JIYzFlOW1DeVhz?=
 =?utf-8?B?VUZvbjJKQUVqLytSdCt4STd6d2diRzZiK1RZaElUZktmVHJhdGZhdTZkQksy?=
 =?utf-8?B?RklJUlc3bVFhMWJxOS9paTg5RzFYTHdCbVhYUDFNbUtxU2xKZ0ZPOWpQT2xz?=
 =?utf-8?B?OU13MnppZFlCS2MxUlp3c21zMkd4OHZaUGZmcm5QZStFTitINHk2THJ6RFZT?=
 =?utf-8?B?V3pTdWxXT3FpakxsL2xkck5KR2dKSE80cldqL29GUFpiMFVjakhER09ZdHYv?=
 =?utf-8?B?ck1QUWVSYzVSYXF2ZjBPNTd4TmIvVWxsdmVGMFlrQ00xNkJTeWxkQWdZSEZR?=
 =?utf-8?B?Z2svNjRmdldNL09MVlVVbFgyZjBuZHhuL0VxQk12aW1CTDJpVmg5QjJ4UHlH?=
 =?utf-8?B?aTREOVptTnNtVDVtSm9SQTR5Q0NBc0I2dEpzRVZaa1MzWW9FWTY0d1I2dTRy?=
 =?utf-8?B?NzFDZDNCaUhMNDJiR3RrREdaWU43UGJpTjYzWjRPQ0hvTHQ1RnBHMlBiN1dO?=
 =?utf-8?B?RnF3Zk40NUNwWUUvSEVTNlRuQ0tkMDQ2dld4eW53RUl0a0VnWnByUlpiU2dO?=
 =?utf-8?B?Tk5FM285ZXBwN2RRQzRkOFJnMTlpUXhIR2l3QlhidElKaklNd2VGMkpwTEZP?=
 =?utf-8?B?K1d6bjNXTGcrazZUb1YwNktaTklZM1IyeTAwdmJpMnAvYlYxZm9aaWN2d01Y?=
 =?utf-8?B?Q3JaYmZjK3ZCZUsrbWVEM0h6UGEzNGsrTGQ4d0tCTEFSTkh4dk1mVW5mdmNq?=
 =?utf-8?B?Q2xHR3FuSzlKb01WSkNYQ2NxT3RBeUVHdFd2R3hkS1pTbWtEbGpkZGR1RlEy?=
 =?utf-8?B?QzRiMjNvTlY4WitPTkE3ZkhGczg5VEZtbmdQSWpFZ0xWQ1pjRGdyYm5mQkov?=
 =?utf-8?B?Mk1oZWZOdjYwbDl5bjl5dWk5SkhPM1BkWTB0LzBwdTc3K3RLSllCaGs2N0hX?=
 =?utf-8?B?cFFnZEUvdmx6Z2poSjFJaldpMVZkSUNXOU16TWVLaTBxUXA2RzhwU3lsQ2lU?=
 =?utf-8?B?V3RsU3lWWnAxMmpvbEZKdVhRNXkzNCtEQkZRRDdVaENtMDlnMHhSeGtPSFRk?=
 =?utf-8?B?YktSK0ZhdW03Uk9PQmVSL1pGKzBpcE9wOXlUcDVsMFlzS2x1NzFuTXc2ZXha?=
 =?utf-8?B?dmJpYjl3b0V0VURaSnNQTElrOXk0MzRJaGgyaFdRaHVha0cvNnBwSlNSMndi?=
 =?utf-8?B?Qi9XOFkzV2JHaXVjSWp0ZEEwSko4RVlhdXRuSUZMRW4zcUV6cGk0aEQveWNt?=
 =?utf-8?B?dHNQcHNvQkZ1NlFBT2t1TjcvekErRWRsamdRZkdzSUw1bTB3VlBSRFp5T2pL?=
 =?utf-8?B?enI3cW9acC9nVHZBTVBCVmM4QVNhbm9XZlB5Q3JkL2wyRVFxRi9aRzRKTk1s?=
 =?utf-8?B?aHhsNnpKaWFPbmtoVWNUck80SDhCU0NUV2g1NmV4ZEdXcUYvVEpPb1hHVHF3?=
 =?utf-8?B?WlF5Z0Q1T3hFbDJZQUxVem5VWVdUd1NzWDRnSE83YjF0WUE2Qi9Ga3ZTTzRB?=
 =?utf-8?Q?IH+Er80I0TbpP7ky/Fm60LmRyeDZkOqUIyfunpl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWlTRU5UNUFmc1ZNYVd4NnVROUtqV2xWZDZDQlBOWEw2S2dkS2poNVpKY29R?=
 =?utf-8?B?OWZ1UXF2WmdEQkJqNkxxNzZNY2ozLzBkaXdsWkpqU3JIYlg2c0FlWDBxc0lZ?=
 =?utf-8?B?Zk1icEdjTXptdzh2Qm1YNGFTT2M0a0ZjSWFQbU9WKy8rTXFneHd0N1BqOU9M?=
 =?utf-8?B?b0FreTZlSDR2bjNLbFFlMW9WTEVNNlgvRFV0SXJVT29Xa1pTeFk1NnNpZnBY?=
 =?utf-8?B?NnhnaWNTTEpKMlp5WXhEaEtRNi82WVk4SXQyUk4xQ1lQRmJtTks4RVJ5NTZH?=
 =?utf-8?B?cHVqOWVieStCbDRhaS9yclgyUjN4VW5UV3ovdGFIOUljSWRST3hmQ0tTM1dH?=
 =?utf-8?B?MSs5QkdmUzdRaks0SEVEZE5aeFJpK1VyVkIvVVpML2xtdUhCMTdibXlvUjhm?=
 =?utf-8?B?TGpQWHdsMXY0c2JGaU1ib010SEtJNlpoZWJhRE5jWlMxVmw4U2c0SXA0SGxi?=
 =?utf-8?B?Q09FNXJWQkMrZG1nNXNBUnlQTkV2RmhPU2ZraU4wclNtR3JDVU1XcFJ5NFNv?=
 =?utf-8?B?Z3hqa2laSEd2OTRQOW43Ynp2cmxnYVBCR2xTMjgveTBzL0F3Q0RmNlpOVGJ3?=
 =?utf-8?B?VU56LzlVNXhYNEMzelNxdkZEdmpyY1pxVFI0dS9rcVp5R09jR1R4OGdxR0dK?=
 =?utf-8?B?b1dZU0pYOUxRWXZEUjc5Z2VTRVNkYW5OZG9NSjhSMDU4Z25oc20rb3ZtQWlY?=
 =?utf-8?B?ZXV0RmN3Ymk0YTVSVTBrelAyU2RtcktQVzdJQXhkdTFCYit1c0lSdWxRRzNJ?=
 =?utf-8?B?ZHJBbWoxN2p1T1lhbEx3eXBCTEpJYWdBR3ZBUFFtWWJWQy9vdDk1aGNzU3Z2?=
 =?utf-8?B?ajB3Q2s4UmlSK2JBdTlCczhUY2dmYWVXOGlaWjh0WkE4S25xeDZ6YmhvdmYy?=
 =?utf-8?B?NE1zUUFaUW9odTY1MU02THE1aVl4WWVoL0FtUG9LZTU2SGY3aittbTFzbFNN?=
 =?utf-8?B?UmJGU0dnR1lENDR3dDRwV0RSWTYwR3Y4UWVoVXc0S0gzeEtKMkd0V09VL0Zu?=
 =?utf-8?B?TnY3aWFibDBDYVlKajVRd3NBS2k3aWdZVUlyRklFNnM2M2YrcnMvQld6Z2VO?=
 =?utf-8?B?OGVuYzF5Z2NkUXpGTWY1TmNReTdnaDcvUERSTTlaNjhSWFpNV21lc0ZPQ3FH?=
 =?utf-8?B?b0VRS3ljcFZ4cVIyMklBRlFQbmlNYVhrenVaKzN0bnNwcHBqRWNkdUhZR1Rq?=
 =?utf-8?B?cXBTdllvNk13eW9uWkg4MjBQbGMrUE1TUWxDcG1KNEJsTENUKytsWHhSbTE4?=
 =?utf-8?B?aVI2enA1V3FGWElwMVZwOFRnMnFBSS9sOEk2c0Nta1ViV04wZjRmNUR4UHJz?=
 =?utf-8?B?VjlTeCtiQmxCZ1daQU55UlRXN2ViaTF5OUJPWUMrbkpmVnh4OTYrODVYUVlG?=
 =?utf-8?B?VlhqVmdkcmVHQ1FpbDRNV3U5WmxvZ29wQ2RNdngzMkY3elIySGhXYUR6YzlW?=
 =?utf-8?B?cHJFRVNoUWRKODQ1bGFONERMQUEzdzlVL2Jra0FhcHd4akxDb09TaFRmMHBY?=
 =?utf-8?B?cFNmM0E4dlFtUjFLYjI4ekp4RGMrK1N0dmdCVG1aOFcvejF1VDNiM3hYYWY0?=
 =?utf-8?B?OVFPdDhGY2JTSnZ0V0l0emQvTG9OdFdpL1VhYWZnYjFZS3h2KzRQUVE4eTVG?=
 =?utf-8?B?MWRCc3V3K001L3RpNExxRjY3WnU3V0wyTFFLeGFUQnFwYlNSaUJDMHN3SUVr?=
 =?utf-8?B?ci9UclFabVRkbGsweU9GNkFzSndTM2hlN2NpUk1MV0JUNExrL2hqNE5HTXlF?=
 =?utf-8?B?Wk5qdGY5SnRPa2huQUEwTWU3MURiYW45RlNpZVIyRC9LaFZRbWdPaS9DQU5R?=
 =?utf-8?B?SGx4YktTVHNmSFI1WDhmVjV0QkZaRkduU1NJYUVuMzl4TGRJU0RJVlBBQWN1?=
 =?utf-8?B?eFF4dG96SSs2Yy9aSytiMmtoTlZFQ004b2t1RnhhdHB6N0VLckdKeXV4M0hV?=
 =?utf-8?B?V2JCL0Q5ZGVGR0swbGxVd0hTTDcxSnN0VkhFQ1IzbnN3RFRhZm53YkNHazlx?=
 =?utf-8?B?dGhWaDZlOVcyclQ1dysxWlJqL2FlbzNWZHgyWXNxV3d5aVBEbkkzNDY0OHp0?=
 =?utf-8?B?cXNQcVVPS1A2VjNxdUQxaStKVmRxVzRkWjVRcG5UODBMSFRPTzl3eUJYSWJL?=
 =?utf-8?B?MnRoVXpudm9XM0lSaUV5Y2kxNldHWS81ZTF6dHNocDZUVzZzR0pBY3VoMlNP?=
 =?utf-8?B?N0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f337092-938f-4307-e234-08dc8c0cf5e0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 00:57:27.3864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mrrCghDFuHnh5oKN0TzdAKtruFBLxBzEuORPvFivfY3lVqvDnimdMIwdt7aYqGLGcvtVYVgRHoJN2DW/kIC7pvz5B5710ck/nsYE8Wg9h98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6861
X-OriginatorOrg: intel.com

Hi Babu,

Shortlog: "Introduce resctrl_file_fflags_init() ..."


On 5/24/24 5:23 AM, Babu Moger wrote:
> The functions thread_throttle_mode_init() and mbm_config_rftype_init()

You can drop "The functions".

> both initialize fflags for resctrl files. Adding the new files will

"Adding the new files" -> "Adding new files"? (this should be in new
paragraph)

> involve adding another function to initialize the fflags. All of this

Solution should be in new paragraph and written in imperative mood.

> can be simplified by adding a new function resctrl_file_fflags_init()
> and passing the file name and flags to be initialized.
> 
> Consolidate multiple fflags initialization into resctrl_file_fflags_init()
> and remove thread_throttle_mode_init() and mbm_config_rftype_init().
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Patch looks good.

Reinette

