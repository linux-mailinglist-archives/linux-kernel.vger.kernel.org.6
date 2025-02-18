Return-Path: <linux-kernel+bounces-520522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D08A3AAF7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400103A41C0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 21:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535AC17A31C;
	Tue, 18 Feb 2025 21:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CORErOo9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7C61BEF7D;
	Tue, 18 Feb 2025 21:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739914389; cv=fail; b=q3jE5cIAnemIyKpDUP5tgVI/ogsZX2CafhcHOQTJlUMdXdy9iM6CdYGJ6Bslj3OgZIfhFvBiWSe9+5gLhyHX+FFttAt9ZkN81Q6mcoEsaB/Md2KYiS0Djt9gZnwgsg0BJnFBdDtf1YXhWzWV5EPMl9J2+4RLrFV1c8ln2O2qFUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739914389; c=relaxed/simple;
	bh=aN1HYqVJi36uEwXe64qhtTpKaO5rGETvWAzhVd13qdA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dlMEPxK0APocOUjbpp29zZ39pyb+EpHUy6zsg/l1wQolxNoFeiCPbHIT7jD9sw80xnm5EW6eu614nTdM/brX1Bd4N1avB9A4imuvXgM4dQa9Osf955u3FnwiUIw7CLMqC1VRW2FCk4n2fy6+au++T5PzD9i1Z/dFLqdn5qu1l9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CORErOo9; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739914388; x=1771450388;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aN1HYqVJi36uEwXe64qhtTpKaO5rGETvWAzhVd13qdA=;
  b=CORErOo9o+PvkRjk1PhYjS8z5DhGOkpieeGzk732s9mCcqKRd4j9bAHc
   X4WSpphgmb/ETN8GHeIdn/QetS9tSfC015Xf/tq5waOQfKI2xpC3g52xl
   LrVCcMzg81nsZGp7UEeOMEO2O29YBA1Op+NthvlMNl4QzjpUYTtMn5Q/q
   R1uC9yxiD+5rJDuzFZX3AqKSulw2fMig8Eq5KtA4xXHaO6wbxQFcuXLLk
   yLarj8l1SsjFCGUD6kQVir5/jpN+SGPLOydLMlbxsPFvezL1+l8KZh1VH
   e0HkN1SvtpnwSr2N7BWT4O0LDgHrXEB8orhnY79GzvYmkpMYTiKXeGEfj
   w==;
X-CSE-ConnectionGUID: 1ajWFwkiS2ijeMKqfbxEyw==
X-CSE-MsgGUID: U7wLN3DyQRSvydgdrIKh/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40840720"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40840720"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 13:33:07 -0800
X-CSE-ConnectionGUID: 8mGbWo+VQuGNWly6iJ+1Cg==
X-CSE-MsgGUID: qdLWUXLETF6mj9XLH8wr9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="119628982"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 13:33:04 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Feb 2025 13:33:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 13:33:05 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 13:33:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Haz1zPwUqiJOitVty+VWViR0Z2sHatfZMSVR2nXTbAvTkfmZyaSOMMc+Pu2YgCjlvJ6u3pKW6jxmVJ+GeRLJLk2LoqaeUd47B5G4SE+4h+BnGDYOC5S0I0vtAlhS1ogILXD6iaQPCiu1WwGkM2vSWiNiZZiL/XxIXMbPf0hRD46F5UzreWRwZpKBtGulc+hEd1uMHK8AuXwq5iv+E7gW7mUPX/lyIDXrsYEbIQjRkYBMWg/cIIFMtN2d7g1+smYYCDnimvjE52kcclBx4hLGV4w00uecNVShDD5LuCX1OB3+fH5p0mAg8bAFlCTR8qXBkcGuPsxx2XJrtkGckJb5IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+DGe8Cfn5gpTfH+kN7d0YsVpQT6h9o8sxt/3a1xPo4=;
 b=KTeyb5MDeB0R54les+3Rhzd1yBQJDmBi4RASjSzgoAO3gP9tk5L79e6uokOf3hJJtvCIAIlfs2kXWdRc2lIWxMMHcgMyXuu/Xshe5YbEusqpAn+NNxBWkwx/JdPcW9WF0YW+SIzEsKE3b5pZkHh7YMuMp2MgvfFnp6VDtCQOyw6gvA0D1+JQUvIxIB2OeVqZRntEHMLVN2IKAIqJ4u+lfx+Arpe0kaJJAaw4QcGmF1XSh8LiSkoHabD96Qz0GX3lhQRCEislC3QqOtdvwlLpWW0j01P599o+6aM0PLoBuz8ODVwRDMwOVZpLZxaUniZNwxmEHyZbV1bNlzgDIQzhVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB7371.namprd11.prod.outlook.com (2603:10b6:610:151::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Tue, 18 Feb
 2025 21:32:33 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8445.015; Tue, 18 Feb 2025
 21:32:33 +0000
Message-ID: <a94cc266-c8b0-4fd7-a4b9-e23213c5b0a8@intel.com>
Date: Tue, 18 Feb 2025 13:32:30 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: "Luck, Tony" <tony.luck@intel.com>, "babu.moger@amd.com"
	<babu.moger@amd.com>, Peter Newman <peternewman@google.com>
CC: "Moger, Babu" <bmoger@amd.com>, Dave Martin <Dave.Martin@arm.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "thuth@redhat.com" <thuth@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "xiongwei.song@windriver.com"
	<xiongwei.song@windriver.com>, "pawan.kumar.gupta@linux.intel.com"
	<pawan.kumar.gupta@linux.intel.com>, "daniel.sneddon@linux.intel.com"
	<daniel.sneddon@linux.intel.com>, "jpoimboe@kernel.org"
	<jpoimboe@kernel.org>, "perry.yuan@amd.com" <perry.yuan@amd.com>,
	"sandipan.das@amd.com" <sandipan.das@amd.com>, "Huang, Kai"
	<kai.huang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "Li, Xin3" <xin3.li@intel.com>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"ebiggers@google.com" <ebiggers@google.com>, "mario.limonciello@amd.com"
	<mario.limonciello@amd.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, "Eranian,
 Stephane" <eranian@google.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <Z6zeXby8ajh0ax6i@e133380.arm.com>
 <9e849476-7c4b-478b-bd2a-185024def3a3@intel.com>
 <Z64tw2NbJXbKpLrH@e133380.arm.com>
 <76b02daf-1b45-473e-9d75-5988a11c6887@intel.com>
 <8ef51f28-e01a-4a7d-ba86-059437edb60b@amd.com>
 <a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com>
 <CALPaoCh7WpohzpXhSAbumjSZBv1_+1bXON7_V1pwG4bdEBr52Q@mail.gmail.com>
 <bdb48b29-92cf-4f98-b375-25ec84f0941a@amd.com>
 <SJ1PR11MB608314CFF36D167483859044FCFA2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <feb03d13-e82e-422a-ba5f-ff9a937aad99@intel.com>
 <SJ1PR11MB6083DDA12763F210D4378CEBFCFA2@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <SJ1PR11MB6083DDA12763F210D4378CEBFCFA2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0029.namprd21.prod.outlook.com
 (2603:10b6:302:1::42) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dfeaf39-f591-43e2-7c6f-08dd5063c13e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T2lXWUIvenNSaXRQdFlhTStWaGZmdEFLeFRVUElNUEZIMURYT1VDZXZkb0J4?=
 =?utf-8?B?cSs5Q2o1YnJicTFNZ2doYjBvTFBJbjdCeFAybk0xMHE0THVpUm5tN2RycXBa?=
 =?utf-8?B?NTRzdXZpaHNZSDZUNGd5eDZlOUlDMGZZeHJucVpxeTk0d3E4aStKWXRtNnA0?=
 =?utf-8?B?YlU5VVZHcnRkK0w5WDYraW5hbGtwVmJPYVFBbldzQnN1N0JJZDBaenEvTXAy?=
 =?utf-8?B?WDhiclBEMjM5SURHUzZ1cno4MEw2aGE0eUZzR29uK2I0M1JFYzJuempMaEp4?=
 =?utf-8?B?YzFIMWIwcUNmcjRjdk5YUGJNcFI3Mkx5MmF3RUR5ek92Q1RRd0ZNcjFYTmN3?=
 =?utf-8?B?bmc0U3gwMVpZdWZZUXZ3M1JlR2pzdDNNZm9yVm5RZWNTMmdSRGhYcThqaW1p?=
 =?utf-8?B?OWZpby84b0Yzb24xQnpCVGxVZUc4L29ybElTNURaUml0alZWRzV1Ly9Ha05x?=
 =?utf-8?B?dXVIYlRETFhKaklCakJSUnNNYWIxV1YyTkgyR2p1am1OblduZnYwckNRZXZF?=
 =?utf-8?B?MjMzM2ZGT1RKRTZETm5XWW5WeGNTT0MwN21WWktQZkdMbGx6dFUyWjhIcHZI?=
 =?utf-8?B?Y3h1SDZNSW1Nd2hpd2kxS0RwdEFWR21tWmpVR0pnTzlBMG1CZXlaZnVHdmR1?=
 =?utf-8?B?aDUyckdUcFVmYlJPOFJMWTk1MXdsWmVIS1g4NWtjUXl1M082ak5PQjZYdy9B?=
 =?utf-8?B?ajM1VEhaMU1BQnBDTlRpVTUrL1NTdVNBSnQ4aEZrSW9sWS93eDB4S2RNancv?=
 =?utf-8?B?a1liczB5TmthcUJ4MUdHOFlzRFFrei9vMVpYbDJKUjFDcTNUZVRocGF5WGFs?=
 =?utf-8?B?aXBUQ3h6STNBSkpyOXZVNjNVdS9iZ2JhM3V4cnA1UnNmMzE0UE55L2QxUUFM?=
 =?utf-8?B?ek5VSDRrMXZiRDk3dVZWTUhkMEtVYk5lVkNRQWZYeXduZTJBNVk3cDloWlRU?=
 =?utf-8?B?YU1wUkQzWGtZaXVRb1RQU1pnSU9VaHlqcXdQeEl5RG1STHJ1eWo4cS8yVWtq?=
 =?utf-8?B?eEtuSVJTRXh0NU1LZWJGcDlCM09FZkx3WDlMOHg3N2xwWndIRzJVNHVTeEY2?=
 =?utf-8?B?UlFGL0VZRTFnVjNZWGI1MFdpcjFpWVgxRlpOVDRqeUhVVEV2S2xQeUNUTXFZ?=
 =?utf-8?B?djNCU0dGeHpUeTdZSkxVNmNDdjI4cXRIMWhISzg3aTE5aG8xSXhvVHFiNGxx?=
 =?utf-8?B?Z0QxK1hEem1XblE4bmh6R3Z6Q29Kck9UQkg0c2NvNVd4M3NEd0U1Q3V0RmM4?=
 =?utf-8?B?YmxmcFlTK1RTVU9JR0FMTk55RGFzUE1ZZ3UwU1NyTGxXTFBIUW5nbG9BU2l3?=
 =?utf-8?B?a1J6MHpCU1JrWjJJWnFvUHFHaUpFb0g3ZnVqbldrL2xtYmx0NGZYU0dhZ0J1?=
 =?utf-8?B?Rm5namc4Z1dWb2xBMWI4TkVjVElFMEtaSyswdGY1VThiQTNKVjZOcTNOTnlB?=
 =?utf-8?B?MUFzMmRBSkQwZDd5UW5jV1JkR280MGtKNDU1eitTck5OSklSRlBPbSs4bjJY?=
 =?utf-8?B?K0ZqRnBCTy9LTVJEOU5BMWdFd25sa041MXFrOVl1T1dncitZYzhVcWJhdTRC?=
 =?utf-8?B?aTBkQU5MYUFYZ283U0Q0UXZIZTRkY2hIODhpalBpSTNnSG5ubHBLUmlFT3Y0?=
 =?utf-8?B?eWRvemdkRWc3YnFnUTR3NHQxTjNsdGtwT21Ra2pnMVN2RFU2WEFTcXdOUlNy?=
 =?utf-8?B?em1CemtiTk1ORldYL1pEaFFrdHFzQVlTMkNUdFR3OEZKQzEzS0RUeCtSdlJk?=
 =?utf-8?B?QXdDeUhIcDFjQ21rSmVpblRlay9DNmhWQUtZZXZsZDFkSFhwc3U0ZHVDZ2NN?=
 =?utf-8?B?ZVIzYStQSTBSSVlUZFNjeHlYYkh3WUhVL1RNUHFrOGNBM0hTeDQ2aE9rQ0p5?=
 =?utf-8?Q?K/QOvIl6nYtfz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWtnYU5PeU50OCtPM0Jzd0laMnJwTzBTRFhka3hFaVVjUHRKd25FT1JBN0FR?=
 =?utf-8?B?RkFvd3JjRS9PTHhmVGsxOERJeExDR2JlUTNVVmw1dDlSbFBTNU5hSlM1QXln?=
 =?utf-8?B?a3NObVJpWklOR2l2d1Jnckl0cnR3SlJzWUhoWFZSLzVMalcxN2JpQTlkUk1w?=
 =?utf-8?B?RnN3dm5yQ01sc2lWL2JXTE85Zk92d1lwNEp4c3kwZTdYT1VyVG81YXBkWnox?=
 =?utf-8?B?Nzk5bFVNTDFkd1Q4NVdyK2N6UGlRb1dVbHpZQWtWVDVuWVV5YXZxb3g3WHZN?=
 =?utf-8?B?aEM5ZWRxc1FNdGJNblg1NmVWeGN4RUFVd202c3BoMS92UGZDNmhWUEx2Tk5E?=
 =?utf-8?B?RjAraEpWQ0dacFlOV2MyaG9aZDhpUjY5VkRndmd2MkR3QUVUQ1ZsV3pQN2RT?=
 =?utf-8?B?TW5GTnlJYmE1T25kT0ZDNmhOVHFuYXBpakszQlBHdmFLZGQ1bFgyUjJwT1pR?=
 =?utf-8?B?ZHpXZHV3OVJMSEpYME5wNktnTnI1ODdJMDJNRnUrR0lkOWJZcVUwVEhGOGtR?=
 =?utf-8?B?cGFPZGRPMFFQWDFwanF4VkJNcUJWR3VUZTczRitjbE9yY0t2YldxMldLUllz?=
 =?utf-8?B?ZDVPQm80TzlVZkZWc3hlcTlFRVZaalM3TWxndjZzSTVHRTB3b1M5bmhkSmtq?=
 =?utf-8?B?T2h4azZCamdLTmczcVFYZm1JYXhQYTFnM1JSblZybUVTSGxPSHFLY2JBVjJa?=
 =?utf-8?B?dEtXV0FNeEdRZStzdXdOTlBYTnFEQTN4NGhEczFxQ1dkQVUxNWF1UzlaOVpx?=
 =?utf-8?B?ZTJ2bjQ4YkVJTWhIdFUzMmYwblZLTS9MQVBxTjJnR1g1MTFzUzQyMURORkQy?=
 =?utf-8?B?eFAvUHJZUXBwUjF2Q28wRmdHK1hMeFh1dGhBaHpBZ3hjM1ZjM0wrN0dSaEdt?=
 =?utf-8?B?WjlHR3kzVXYzYTdjVjBHV0J0aDkrRlpoNERKcG1MSFl3RUF0dS9DM2hwajFT?=
 =?utf-8?B?aEkrR1JNM2lWZjZDa1BJUEFYYkw5WE1EZFZCcWZYTjNXeGxlek4wMkR2eld5?=
 =?utf-8?B?TGszVEFQK0VOUzdxbGhDa0VNMFhNUGhHQmdKdDNTVFZaeVlBbkdYQldVOU55?=
 =?utf-8?B?WlYycFBoNXNjZzdQNWtYWTRZay8xQ3loeENtaVRaTzV6QkR1YXZzNldZQzgv?=
 =?utf-8?B?eFAwUjViUGRmREo2OVR0UE1RL3hsSTdRc2xxTHliZW5NZG9hamF0ZGJKNUNX?=
 =?utf-8?B?NmZITHZGamtDd3JCVE11UHM3ck1PbDVkUEFzK29zYlRLVTRoOU9YRklndE4w?=
 =?utf-8?B?ZHQ5ZlVkZ1R5bmY5bG1EdnhESkJWTFdzR0kvTDNaQjFCQkxlNFhXaStPZDZk?=
 =?utf-8?B?My92QXB3bUtnZEN3N0pWbHY1MW5XSXZSVU5tZ3hNMmhoV2FjZ1pESjN4Um1W?=
 =?utf-8?B?aVpFUkZ2TFgxVzNpY3pRM2tzbG5XRnI3NUt2WS9lbFZpNjNFOFZKUVBZWGor?=
 =?utf-8?B?R1c0SDNBNitoOUluN2p1dFFIVEp1L2ZXZlB4UWpmejljZU40RkxzU3Bjd0ho?=
 =?utf-8?B?QlhOQkRYTURtVnpXN0ltZlZlSzcrNmM0YnR5RktVSVNWNzQyZE1pMENWLzRv?=
 =?utf-8?B?Vjg1K3A0am1aK0dqWWJTT0w5M3ZFd1ppQ0YwZ1hOaVdHaWxUUmxXWndpOXcx?=
 =?utf-8?B?ZFdVdCtUL0JGeDE4dzA2VWFGQnRtSy9kQXBTRDBmdm9ITDlzd1dtOXdzVmw5?=
 =?utf-8?B?VzZwRDFlU3NTVkRYTXY2RGpiSk9pcC9LNXpNMTVLWWFSRXJkWGw1akRZNTE3?=
 =?utf-8?B?VmZKa0lTWEJJcUxXWlg2UGVSUTE5S3ZPb3VhVDVHdnYwR1BlR2U3OHQwOXlW?=
 =?utf-8?B?Z2ZDUHRFb0wycDBBa3A2bCtNTjFVSWlZUWRQT0JFSFpnZUZCS1lwVU1tS0pj?=
 =?utf-8?B?Rk5NOUhwZlAzRDQzUDhqeWN6Uy9HSXF4NEhCVzNnakJiWWVSTjBCWnAwOXlj?=
 =?utf-8?B?T0plOWRuR0pMY29KUzFvdmtuaHhTMStHeUFoNDlWREhNUUNqZExtbVQ2a0kx?=
 =?utf-8?B?TVJnckR2VFp4RkVOd2FuR0tzMEZyRFhNRGQ3NndNWU93RmhOZHcybERwT25S?=
 =?utf-8?B?U0xvSjlxRExDbG4rVzVKQjdjZWtrYzVGb0c1bHhDZ2VUTUxQVmJGUlVITnBj?=
 =?utf-8?B?YzFRbENZRWRDaUJvL2NkMzNPdmpkQlcyT2pzdnpmV3ZKQ3N5ZkQ3bmthZ0FR?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dfeaf39-f591-43e2-7c6f-08dd5063c13e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 21:32:33.2677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kCZG2bMvKY5XfuXT4wB+Jd97NRQLZ+VBGMiTQiCM+bEncdzYNGDOdI7AlwcaqOWNn4gcnBvMUgiHVI/MTKf14wI8oM6j0DKcYzDeQI9gqBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7371
X-OriginatorOrg: intel.com

Hi Tony,

On 2/18/25 11:08 AM, Luck, Tony wrote:
>>>> Based on the discussion so far, it felt like it is not a group level
>>>> breakdown. It is kind of global level breakdown. I could be wrong here.
>>>>
>>>> My understanding so far, MPAM has a number of global counters. It can be
>>>> assigned to any domain in the system and monitor events.
>>>>
>>>> They also have a way to configure the events (read, write or both).
>>>>
>>>> Both these feature are inline with current resctrl implementation and can
>>>> be easily adapted.
>>>>
>>>> One thing I am not clear why MPAM implementation plans to create separate
>>>> files(dynamically) in /sys/fs/resctrl/info/L3_MON/ directory to read the
>>>> events. We already have files in each group to read the events.
>>>>
>>>> # ls -l /sys/fs/resctrl/mon_data/mon_L3_00/
>>>> total 0
>>>> -r--r--r--. 1 root root 0 Feb 17 08:16 llc_occupancy
>>>> -r--r--r--. 1 root root 0 Feb 17 08:16 mbm_local_bytes
>>>> -r--r--r--. 1 root root 0 Feb 17 08:16 mbm_total_bytes
>>>
>>> It would be nice if the filenames here reflected the reconfigured
>>> events. From what I can tell on AMD with BMEC it is possible to change the
>>> underlying events so that local b/w is reported in the mbm_total_bytes
>>> file, and vice versa. Or an event like:
>>>
>>>    6       Dirty Victims from the QOS domain to all types of memory
>>>
>>> is counted.
>>>
>>> Though maybe we'd need to create a lot of filenames for the 2**6
>>> combinations of bits.
>>
>> Instead of accommodating all possible names resctrl could support
>> "generic" names as hinted in Dave Martin's proposal.
>>
>> The complication with BMEC is that these are the underlying
>> mbm_local_bytes and mbm_total_bytes events on which configuration
>> was built. Specifically, by default and at hardware reset mbm_local_bytes
>> counts exactly that. The event is fixed if BMEC is not supported and
>> configurable if it is.
> 
> Would if be possible to rename the files if the config changed?
> 
> I.e. initially they are named mbm_local_bytes and mbm_total_bytes.
> 
> But when the user changes the config for mbm_total_bytes using the
> BMEC config file, that file is renamed everywhere to "user_config1"
> 

The motivation for doing this to an existing interface is not clear. On
its own I think it will add confusion. It sounds to me as though there is
some future (similar to BMEC) feature that needs to be supported for which
such a change would make things compatible. For this I think it would be easier to
discuss that future feature and ensure everybody is clear on what interface
would work for that new feature before making changes to existing feature to
be compatible with it.

Reinette



