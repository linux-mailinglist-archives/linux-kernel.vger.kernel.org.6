Return-Path: <linux-kernel+bounces-341215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FBB987CBF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 03:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED541F23FBE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 01:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E2D166F32;
	Fri, 27 Sep 2024 01:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nf7H9VAw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7930D165F01;
	Fri, 27 Sep 2024 01:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727401993; cv=fail; b=uPhDLLOjnpo/mdej5/g8R8cdNvFLRoWT/8+3B/HsLYa/aa8E6RdlssPSPZUmUgO6Vv/XaE4dNZ1/Ba0Pc3Fok6zBi+oV3kFib5Ap7Z8mrF+dc0GrT52zINh+4Ry07ye6FoOinASC++N0vdtjQdA+pY1+mTExHdWbfbzCkMnD7AE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727401993; c=relaxed/simple;
	bh=aycC0PNeXq0EaS67B+bepvLUGrKUJXBKs7kDRXY3YCM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AKsWpzKC1HboAE9RRRw3ByCeVl7BRcEuK2FrsuQaHXEqOs6OZKye+ijvBUDoGYrHIC1qr+TrAavKzzNgGg+SCrPoY15HQzCDuSAFcAAvOByIAwp5rDkAMzYvMrATIsbTXy8iSc3IgBoq6g76igOZTJDtkyFXuO1OvWYFCLvuJFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nf7H9VAw; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727401991; x=1758937991;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aycC0PNeXq0EaS67B+bepvLUGrKUJXBKs7kDRXY3YCM=;
  b=nf7H9VAw+kXiSz6ckSAbRUwGSi5kGPZDx8HoeTvzSt/Ie1T3zocGuXZ4
   qhHJSQ2bEzYAKP9OqgBr2WmW/MguJFiNb3LQjnhMHLA55kwFiTrl8KfkH
   Ag1CrskpgjTHmI4dSxrlh1yESeXif87WcI4F5FtHiaDs8dJ8HQFircAUX
   zsEgtT+GHbzbedBBQdj09BWXfapkxnwjhXu0Q9KCaiXDtSo+vu5Iolj1z
   xPAMAQhLvDsBA7fvQSYJ6i2ylu1CjPmU606f5I3dogQeAxKeLZiKit2TB
   8bz+YaeBdD+LAU+VM7z0YhjYJzCAwxJFK7NaS8+K9FfVI/547uwwmxkXc
   A==;
X-CSE-ConnectionGUID: +ykWs/JwSnaN3iGT2XIE0A==
X-CSE-MsgGUID: AhhFEMa9S2uKKhkoNXoOjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26403163"
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="26403163"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 18:53:10 -0700
X-CSE-ConnectionGUID: xCGT1FpJSZ2ZV+wK+gIbqg==
X-CSE-MsgGUID: 9PGczmbiQkOuHjmuP2Mieg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="103177391"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2024 18:50:30 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 18:50:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 18:50:29 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 18:50:29 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 18:50:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VytHPjr5nM2uLni0gPU2g2VILlkuX02Vn7p7rZNkoFY00M3uBATkgsc1MR3n0HXlfXyAcUsqngxvA8/c+qWDVoDcy34ljawFeGtM7ttHtxyK8p1F1a9+ei7PuK7k5A0OvT7/MWEzp3pw6tvQKgdK5/afP7tEFpOTDNpMH7qrciDeZLa0//jfgbaR1pnoZqcfFBzu/W8mctnkW0M1AR8X89+guDZhZj4pOx2Q+hbau0JbLr/vMm65n2ESFF1pIztSj00k83Xwtx6NmyEL2ZbTMkcSTeBoKCa1Y9vwZlisytUBCdzJhuhE0ihSNlmiw56JrxD5vDJmaajI3V1yporLug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cey9+bduFxD7SbIG6ZAkf5JEZZiz+CojlqT4jzc4/ig=;
 b=GFfBKROKnwSh7HRT8PQoWczJoZuyBCv93kKLRfENy/47BgAGl/R/HLRQtaqEm7J5xpjXCJB7ygcpAGEEdKtT87rasTutH5p6NoaVTAV/fdosNGDBSszjJmYwdo1tcrgNxfbbHoAFlZ/QYXclMo/m/cjViF4hpZr6L/X2VqpVb8gQSTjaREf3dbIRrh0tuCl8RX0NktuTXshPXI5rkaSumYsOdgmZxfnY63BowQ2FmXwOzkBVm1U2GXEK5tUAzWWvKWIH5rQDVek21QZW28tnzOC3y79y5QA26m4JM0xJqA5he6MX7DQmZdVGKGFW7MUcJ9RZ571TYJ1NAx/7mQg2BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7)
 by SA2PR11MB5211.namprd11.prod.outlook.com (2603:10b6:806:fb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 01:50:26 +0000
Received: from SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15]) by SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15%6]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 01:50:26 +0000
Message-ID: <eae45121-e0bf-4076-a189-948531b89374@intel.com>
Date: Thu, 26 Sep 2024 18:50:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 19/24] x86/resctrl: Report "Unassigned" for MBM events
 in mbm_cntr_assign mode
To: <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <1c5b054d8fbc3f7ad22c686d0d5e21e6573187bd.1725488488.git.babu.moger@amd.com>
 <f5f61804-3743-42ef-83ed-6c198c4eef74@intel.com>
 <3734ee4d-f0ab-41b1-8f5d-42642760da8c@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <3734ee4d-f0ab-41b1-8f5d-42642760da8c@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0164.namprd03.prod.outlook.com
 (2603:10b6:303:8d::19) To SN7PR11MB7566.namprd11.prod.outlook.com
 (2603:10b6:806:34d::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7566:EE_|SA2PR11MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: ac9ac9f2-1b26-4880-6d13-08dcde96c24b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEVnMVk1cEUvSzlzdXVYa0NyQ1dLYjg2RHRIcGZia3hmNWFIWVhPNXFzQkJV?=
 =?utf-8?B?Qjk0ZWowaWF3dk1oQy9jRWlXSDhqbzRHWUcwUVhzVjR6R0xpNFJ2ekdNSDh3?=
 =?utf-8?B?WHpiNlZSTTI5SmtuSGZNR0ZNNjdlR0lSaTV2SUFkdEJBS3JFWkJiNWwxdUt5?=
 =?utf-8?B?cG1ySXpkNzlWNURvc2tSTzVKVmI2TlpmeUtkNThlVnZjRHFSVXdhTVpqQmRn?=
 =?utf-8?B?WG9zVlJ6R3gzOGlRdEI1YzVvaWloM1B6WGdodnc4eXhRUFpSMDFmRlJQYzlo?=
 =?utf-8?B?bERKREZzK08vMXIzY1pnbnlMM1ZHY2hPb3F6WnVkdWFURFlVYktmQ0xWczFN?=
 =?utf-8?B?RFVBTDYybWMxNWdZUDYwS1FiYVlWelNTMlM3ZGViYjlzOElaNWVKTnBaWHQ0?=
 =?utf-8?B?THZvc1hpbDdndXpGL0FLVHRIeUJQOEZONXFCZjNMQStEWCtxZDI0K0Y2d3ly?=
 =?utf-8?B?WkxBSi9iYi92cFdmdjlZMEhqazJ5Uis2MlRtcU12eGNhTERkQUhLZVJaY2FO?=
 =?utf-8?B?dkw0RFdXbEhSWjdxdk8za3UvcE5xWTZ2VEZSU25DWHNId2VNYzloVUQ2RUQ2?=
 =?utf-8?B?ZWhITmNIY1RiN3l2SWV6dkF0eE9jcTVVUVdweGFIeUVqeFdERTZXZjFGakJp?=
 =?utf-8?B?bUw0eVdqaDZIQS92U1pRTVJiRitEMzRPL3l3K0dGOUxjc2E5TU9HUDN2SG1E?=
 =?utf-8?B?dXFpUXBSbTVXaHhkOTlDMk1EZHE1QU5yR0cvdndRd0RRZmZYMnVlUU5US2Nu?=
 =?utf-8?B?b0Z6M0wzVWFvRGY4TVZEck44KzRLc25aN2ZFOHNRTkxuR0cvU3J5MjROTXJy?=
 =?utf-8?B?YzRQd0MwNVE3ZHZFeDNtZit3SGQ4MXcwZXlsdTFuTnVteHZrdXc4ejM5ZkYr?=
 =?utf-8?B?RSs4aWJRMTBtNTZ6d0JZTDFvMDFRUnAxcDY5VnR0MWZCU1BFbllIVE83Q2Fi?=
 =?utf-8?B?K1EzNTRuM2hoTFNZSkt0NWJhT1pTZ0ZoMFpSK1FGSjBHZkM4VmFQTW1aWWpR?=
 =?utf-8?B?dTlXWFRrRi9zdTRLWXhwQ0sxcE9IZzhRekoxRkhFeWw2ZldlRlFsNWIxN0Na?=
 =?utf-8?B?SnM5ZUNtTVhzd2FXcW5HMmtScDNJMkRRb3lVZDMwQ0FSaURwZEJicDI4RE4x?=
 =?utf-8?B?NEcvUDdVZXBnNmhFSnhROFlaSDRVdVdtTDRnWDVmWFpOcGZiblpVL1ZmNmhS?=
 =?utf-8?B?OXl0UWNNWThGNytNMW4rRXJ3WjhIZ2I5UXYvUmtUYm0wQXZqR3Q3Z1QvMHpX?=
 =?utf-8?B?Z2NJank4T2RaL3d3R0ROdjBJbUNtR0g0cDNaMzB4d0pRa0Nhd1FEazdiUTJU?=
 =?utf-8?B?L2JINm14d2NjbExJMXN1N2hLKzdUaDJXZ2ZDbXFtTWh4R2FDQ1FrdHBEU2p4?=
 =?utf-8?B?NDFSZ3JJOUxrVGppOW5IUVFKV0I4VVhJU25sSm5rMUg0QU9ZYlZIN3N3TFNm?=
 =?utf-8?B?UzZwcHhiR0hQZWc0cTVNYXlCVy9xaXVGWHBYRnc5UTNBSS9xcC9YRjdmcFg5?=
 =?utf-8?B?RllNYzFvcFREWlV6ckNDS2lBdUhRYVFqaWVWT1JaODlEdTgrcnowZGtrOXUr?=
 =?utf-8?B?WEgyV2I4anFqaTVFdzJvVjFVZjJrQjJRTVlFZzgwTlRJeVJPZWZZcGQ1MWI4?=
 =?utf-8?B?RHpaRE04WmR6S3M5NlRKeGNGemVIUGJqUFRyUWltaUpwT3loazNtamZGYmZk?=
 =?utf-8?B?MEtFelpJbzFITWFxcEJidmhVWFo5bDdXZUJCeVkxbzU0NWJBWVBnVXh2N2p4?=
 =?utf-8?B?WHNxbVdZSFVSS1ZGS3N0NU5UV1NSaTVEaWVDZ0prMDVReDdaM0pjN1I3UGRz?=
 =?utf-8?B?ZGwwelp1YjJ4TnQ1c0ovUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7566.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnpEZS9wL2hCTmplR3E2S0RtTU5XZkZZeFdXV09BR2JqUzdFQkt5WmJJRk9T?=
 =?utf-8?B?ZWdVaFQzOE1hNTBabEVPUUNDcnFHd0I2d0dTZ1pwWUwrbnozVWxkbFgrR0x3?=
 =?utf-8?B?M2VFSzVBTnNpZUR1ejEzOHlMWmlVRHZ1OWQ0Q0lOYkI5cmJYLzFyWjljMU92?=
 =?utf-8?B?L3BmSWpONjdTS2hTU0RPWTNJak5jZjJVTFNneG5mZzA4TmYzaEkzeGJEL0Y5?=
 =?utf-8?B?b3Y3UDMzYkVHczZSWTBYMzB0ZE93VC9xandBVnJUbWYza25mRVFyaTJqaWMr?=
 =?utf-8?B?b09VL0tNN3Nhako3SmdZRTVpbkNhQk5xMElGQU1ScElQUnhhcE9SVmJDQXgx?=
 =?utf-8?B?QjVMODczbWViSVlLN2g2dXA3c3FISWhlMzJmb1R4UkR5dzBnQzdzNGwzSjFQ?=
 =?utf-8?B?clZ4UGtDcmlIQk5MVDFRMlpFdVJ3NUlrT1VKVldoSVdyNGlvaWZ2d3E2WU80?=
 =?utf-8?B?YS85bW03L0daMzRCU2xyZkEwN2xVRzFUL0lGT2hja25XWGVSMVRtdWxPQnZv?=
 =?utf-8?B?dlZmd0hoZjBabW5PaDVPNmJEWTFyTWI0bzlGdWFqenJZVnpyRjBJdlNyencr?=
 =?utf-8?B?VVpvM0pKbTltOEFGdzVmU2hLZGFkR2lFR2J0cklVdGRyS25iSExWMnNDemxn?=
 =?utf-8?B?WWRkT3dPbzk5ZmdiYi9OV3cyanBaeE9kK0V1VHNxZ3p6blBuTFJtc09qM1cz?=
 =?utf-8?B?WDR0MC82Ky9OYjJRenhlamVBSjBVWDFYdjROSGh5RDUwbzk4K2dRc2VMY0Zr?=
 =?utf-8?B?RTdvNlEwcjBEVWZzODdYcERBOEx0NzRNWG1vMkxuQzJSN05oajFaMmMxQ01R?=
 =?utf-8?B?SVNzK0JyQ2VUWTArd1d2L0tuL01LN3lOelk1UFc5NDhRUy9ySi9hdnArWWJJ?=
 =?utf-8?B?RGtWcnMrdnExNjZ6RzBYa1hUYjRvcENUWjRqb0Zrclh4aDVIZ3VjSm9JVzdT?=
 =?utf-8?B?Smw2b1ZBZm1iWllxT2Y4VTJYc2JFeFdacW9RTGRJVU1IcENlLytoMXlKdmxT?=
 =?utf-8?B?SUNmaVBiTzMvL3h6N3dsdWxpMnNPVTJFWjkzYVpsZGxBV0UrODBvV0tkQlpi?=
 =?utf-8?B?OGxMcTE0b0JSSXF5Tno3aUplemcyNkRFdUJ2MXdpdXNoTWtPdTQ0ellRYXQz?=
 =?utf-8?B?M2xVRkt0Z01lYzFWNVRVV241STVsRXJNdlBvK0hFYkJERjh6bjFsKzJUY1hp?=
 =?utf-8?B?Umh5dUxTS0dqNCt6RTQ0cXVXQmp2WnFVU1l0cHQ3RWJqdTFLcmNMTDBWcVRR?=
 =?utf-8?B?UmVmOCtVQmdwNWpGSm9vRkUyVS9Ya3FObkU0WW9DaDNNYXdReEFKeGFhVy9P?=
 =?utf-8?B?M01FMDZqOXhub1hWb3BBZXViNkthNGkzOWJ5OE5Pd3k1c3J3UE12clJSVGxH?=
 =?utf-8?B?d3FJWElKeUN6L0JwT2EzbmVaVmxCRFkwV2pBZEpOSjFGUldWMDBKdjBEY2Ew?=
 =?utf-8?B?RVprNk9wU3o4Z29LSnREdVhzUFY3UnQyVC9mbzNNTEdIV2xlUEkyQS9adVNt?=
 =?utf-8?B?TGpRTWhTTU1NUGtUSVBqNElIUzRQYmhVWExHQlpoNG0xN3lpUDhtdVV3Mm40?=
 =?utf-8?B?QkNQdmZqWW9RTU0wYzFUaTRDSHlGc3JDV0pBYmFZNnJOTkM1M1BQN0xuekJm?=
 =?utf-8?B?Rko3bDJEVjRuWVdXSWJEWlRqbzJHMHh3Q3c5ZjVKS0RFeE1ReGx2T00weFAw?=
 =?utf-8?B?eHk5SzlJVkR1ZjVpT3FDNW42dlhzSG5tblgrck9CR2haT3lkVDMxcUhoNjBI?=
 =?utf-8?B?cUhpWXdXUWhpSmpXbmJndUZkZm9DUXpvUkZzdFNVTWdRZ1ZZeDRLM1RJWElP?=
 =?utf-8?B?M0xET25YVkFQell2RmtobEV0Q1E3TnE3SjU5K0xPSGVJL1NoUmRzcnJEY2py?=
 =?utf-8?B?R3dUQlhjTW5IbWZjdzdLRW5ubW1DZW5tMVZyZHUzd3FRTS9UQWl4WVlJejVD?=
 =?utf-8?B?SDVKaEJMNUFFYkcyUkdxNVVKN25ndldERHBlcThjUG5UUm9hc0hvR1BsMFFl?=
 =?utf-8?B?U0ZobXl0Z1dIZk12UVE3Z1Izd29NWkozY1Job1I1aDZVRHo1bGIxMUx3QlVw?=
 =?utf-8?B?VVo2Zy9CdE1PUnBLa1F2ZjdnUG9KVG5tSWZRS3Nsbng2WEltS1VKWmVVS2Yz?=
 =?utf-8?B?M3dtUW1nbEpCUGtpR1BIOW8zT2w2dWFEVWFJVDlSb3Y5eGVmL3JEZkhkZmVE?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9ac9f2-1b26-4880-6d13-08dcde96c24b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7566.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 01:50:26.7415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLtDwqA3OFnlk0VCgMieM2OJh7by6kkFpE+QJN1mPUvn9SHR0Q/ZVEfXPCS3RJuK2/OSrScGr02Y5P/vZkhhMvJlzBuHykmYrJSgJH2GWvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5211
X-OriginatorOrg: intel.com

Hi Babu,

On 9/26/24 12:16 PM, Moger, Babu wrote:
> On 9/19/24 12:31, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 9/4/24 3:21 PM, Babu Moger wrote:
>>> In mbm_cntr_assign mode, the hardware counter should be assigned to read
>>> the MBM events.
>>>
>>> Report "Unassigned" in case the user attempts to read the events without
>>> assigning the counter.
>>>
>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>> ---
>>> v7: Moved the documentation under "mon_data".
>>>     Updated the text little bit.
>>>
>>> v6: Added more explaination in the resctrl.rst
>>>     Added checks to detect "Unassigned" before reading RMID.
>>>
>>> v5: New patch.
>>> ---
>>>  Documentation/arch/x86/resctrl.rst        | 10 ++++++++++
>>>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 13 ++++++++++++-
>>>  2 files changed, 22 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>>> index 3e9302971faf..ff5397d19704 100644
>>> --- a/Documentation/arch/x86/resctrl.rst
>>> +++ b/Documentation/arch/x86/resctrl.rst
>>> @@ -417,6 +417,16 @@ When monitoring is enabled all MON groups will also contain:
>>>  	for the L3 cache they occupy). These are named "mon_sub_L3_YY"
>>>  	where "YY" is the node number.
>>>  
>>> +	The mbm_cntr_assign mode allows users to assign a hardware counter
>>> +	to an RMID-event pair, enabling bandwidth monitoring for as long
>>> +	as the counter remains assigned. The hardware will continue tracking
>>> +	the assigned RMID until the user manually unassigns it, ensuring
>>> +	that counters are not reset during this period. With a limited number
>>> +	of counters, the system may run out of assignable resources. In
>>> +	mbm_cntr_assign mode, MBM event counters will return "Unassigned"
>>> +	if the counter is not allocated to the event when read. Users must
>>> +	manually assign a counter to read the events.
>>> +
>>
>> Please consider how this text could also be relevant to soft-ABMC.
> 
> It mostly applies to soft-ABMC also. Minor tweaking may be required.

hmmm ... seems that I still have mostly the "soft-RMID" model in my head.

> How about?
> 
> "When supported the 'mbm_cntr_assign' mode allows users to assign a
> hardware counter to RMID, event pair, enabling bandwidth monitoring for as

hmmm ... so soft-ABMC also assigns hardware counters?

Also, we should aim for generic text that will cover how this may look on MPAM
also. Considering this, it may just mean to replace "RMID, event pair" with 
"mon_hw_id, event pair"?

> long as the counter remains assigned. The hardware will continue tracking
> the assigned RMID until the user manually unassigns it, ensuring

Please do double-check all usage of "RMID" in user facing interfaces/docs where
mon_hw_id may be more appropriate.

> that counters are not reset during this period. With a limited number
> of counters, the system may run out of assignable counters at some point.
> In that case, MBM event counters will return "Unassigned" when the event
> when read. Users must manually assign a counter to read the events."

"when the event when read" -> "when the event is read"?

Reinette

