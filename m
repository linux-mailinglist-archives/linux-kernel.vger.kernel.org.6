Return-Path: <linux-kernel+bounces-299628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC38F95D7D3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 22:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4ED1F2466A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 20:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE88A194AFB;
	Fri, 23 Aug 2024 20:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jr9hzqzM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4BA18FDD6;
	Fri, 23 Aug 2024 20:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724444959; cv=fail; b=RH2/lxAkA5kqsMMDusSI5i0Drf8DWZa+31R715+J/tlxk6TucKEUOWCcFk38yTADV4ZErdQRSJg5iAHKyusJNWfttzALIDHvGB9LbSAAenV3zE405tssrekTOGfNa7c5ReB3v0JIweEBtwPVDr5+DyWqIHmvTMpgumz9d1Nvnes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724444959; c=relaxed/simple;
	bh=J2XMhExkJNDpLTfHRb961PGXVTQru7xWAp7WLhe/4UE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fWng2gHd2gO2hJc9pbTzspQG90keSR7Ij2CkHzyelD682VUptRKDba1A1HbdSSM8quK43EYD/Duu9JnBgoDso2r9dSjZ4lp1c8qpd98oYXE/dHsRehNY1uVMdwm3yVISaldFWea+SK5+6fsYfQXoSOIrxXx6xonyYn4AVqaaGgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jr9hzqzM; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724444958; x=1755980958;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J2XMhExkJNDpLTfHRb961PGXVTQru7xWAp7WLhe/4UE=;
  b=jr9hzqzMDLNKdR5z0KW0tH9qHkNXDVBuzUtxB2n9CwLRlmtJgWihJkIp
   fK779bcy87bWOEE6yre7mpukk06koHG/pLH0FBI9lfycKAsHXtZgU9Dzx
   p5xst7pMzQOXNnL1lCt34l5Zknoaz0VAJgxgqjsbpW3KPorMxn/xCMrV6
   qoSpOsiGnFQoRwu7AJn2jNHuShqVavoOxop/mGLb18bPOisWOPSO6tfXH
   EADUNHBzRrgxg7q6gC/0b1YqOMrL3t293Urtdb39LEmN/MRqo9FxHRoZ1
   WQkVH0qvrz4ysD/jP1BjCLztLS/6eMUINuAbquYmXq0C+QIXH2EW/f+Hz
   w==;
X-CSE-ConnectionGUID: +Rwfhe+9Q9+/dmlxQHZaXA==
X-CSE-MsgGUID: eXF80Nj+Ti+1O5gU2kYejQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="33495251"
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="33495251"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 13:29:17 -0700
X-CSE-ConnectionGUID: oww0iDRRQtON8hX5o+47yQ==
X-CSE-MsgGUID: +Bramk7TSMSL0mawoA5eng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="61604553"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Aug 2024 13:29:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 13:29:15 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 13:29:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 23 Aug 2024 13:29:14 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 Aug 2024 13:29:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIufl1mAkIjSk7MTC7ajJbJc9nbYqqev2a1yOR4P05XLdkdVxRjl/NtcKQBIa+DJNs9ThzlzfNkS48ESBuPBynVh6IBocb6g0wiUvT13ByLbS4BULwJTxJr9TH3jDNuZkq3oRP2gedoWcV9xS2UroOqsy5Ou1QafEbglh7CrGdDDbiL+FhVrEi/dWb8jcuZKRGpRScFldiznz9F9lVIgHjLBQOVxQihe6KZPnY9vrZd3t/E2t2uwicKaCsQ1IpNHg0fmfu5l1Bl7z+r8B+UppzTTRgmDmUTlKymlJwCDdIyeTt9uMZo2e6Cl0r3euXuSbnGj11aE20WQLMzwr47sUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ot2EFo1HoUr5fmlJeLzyfndHJSPVkzv8d6dNFIn7YJU=;
 b=DWV2ixyaDy+FNjy6BSQG6IZ3dLqxQbtaXgcdb8OfUWRmhuywWn9yRJ5/K3myu4Bjty6fU17SOyRxPn+ZGZxJ/l6+5rWeCoWqcNOBVy0NTZzxCDiPf21zFdrsltHlXdJ7oPNlTPE372ymO0gF7QDE0V96dcPduFFZDNO2ftVBajEK4FCNQS8pwhJOxa5GDfUn8WSIjpGajSuHYB6HM8mS6ZrK4/6XGEpGTlJ+O2ZYBRKaafBlZpgQioBAIEsaznyeSVSKxY7Mg7TovFREn0ITwsYR/zYlYuW54gZJ+iAJLzY8CnKfy9RcfDFa8tTSh/F0ye0frbYCDHRSZNXXkuUtSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY8PR11MB7107.namprd11.prod.outlook.com (2603:10b6:930:51::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Fri, 23 Aug
 2024 20:29:11 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.019; Fri, 23 Aug 2024
 20:29:11 +0000
Message-ID: <0dcb775e-7214-48bd-81eb-22b14d5605d1@intel.com>
Date: Fri, 23 Aug 2024 13:29:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/22] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
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
References: <cover.1722981659.git.babu.moger@amd.com>
 <d093c0bc-dfd2-422a-9d23-2bde68dc6f73@intel.com>
 <3223bd31-2112-0c5e-08d4-7e4942d031ec@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <3223bd31-2112-0c5e-08d4-7e4942d031ec@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0169.namprd03.prod.outlook.com
 (2603:10b6:303:8d::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY8PR11MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fc51549-f5dc-40a9-903b-08dcc3b23f7c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TTQ3MFNVNmZ6ZmVkcHQxMFUxcEpoSmcrcEUvSjFyQkpFeTR6d25NVzRvbC9V?=
 =?utf-8?B?S3pybk1JMlAzNFpBczM2NmRNUWhSLzZvZ1Z0RHpkT0h3M014em5wc3lEcXlm?=
 =?utf-8?B?WTk3WnlhcE5ZSUwvZng3OFpXRzlwTk8zWWpTKzh6d1EwT3R3aS9ZQWo1eVcw?=
 =?utf-8?B?S3NqR3JmUjFFTTdYeUJTQTRZcEczZnAxSHEzR3dxaG1RVDgybFBEMkRKUmxu?=
 =?utf-8?B?NzRLNW9TYW9JVVkrcVptMzZKQTRBSDNkQURwSzlmVktWWTlEVVE0L0o4RHda?=
 =?utf-8?B?WWI4eURTejNLRzU1VWt4ZzY2UHJ6cksrV0pvVXRGSFE0RWtYK0RPbkw1Z2xL?=
 =?utf-8?B?VVNuR1FWelcveDNJeXcyU2hVQU5CSVUydlVYRDZWMjNNNGtNQXF6OUZGeUJo?=
 =?utf-8?B?ZjZnNk1xUzV5MEplYnRZUElNMU1IMFZpUU5MSzkwbnhwOTRQL2pHVFZNcEd2?=
 =?utf-8?B?S0pLaGwzMHRMVUJ5V0x6enJ0YkJPc3BNaHhSbUZQQnNHSGcwdnFsTjlzamxS?=
 =?utf-8?B?M2NOWFZKblk3SThIdGxQb3VUc0RjOTJySEhtRWRsc0k0eW8rVmVjZDBXeHpE?=
 =?utf-8?B?ZjRQekZ4aUtWRGxFZ2NxR2hpSWVpTmdSL3BOR0RTd2x0V28zRlBKbVFVV3lK?=
 =?utf-8?B?MDJMNW9PN2FhZjdlM3NFMzdEZ2JML0R1dlBSSE5yMnhtOU5vL3E3SXVEQks5?=
 =?utf-8?B?T0crZG5rTkdEZ2tPMHdrZElTVHJ6b2hQYlFSV1Y2cjhVbjZlVklJQWZQNFhn?=
 =?utf-8?B?RkJNRjA3eVNuQVpKaXd1NG1JaTlrOG5uejRGZEFwVnJCNWt5VFFvWWhTQlY0?=
 =?utf-8?B?RHY1SFRiUHBlQmVwanZkR3dSc2h3VnRtRDY5ejQxOWdDMTNUeFlldm1obG16?=
 =?utf-8?B?ZS8veTgwOHZ1bWVIRDhkejlJWkJ2eFgvSmZnMWdpMXNtc28vV29aTHR3RVJU?=
 =?utf-8?B?MUsxeks0eXRidmNwTmFHQmRNb0VpZVVDZkcwRldJbytCZnE0emMvbWZFN3d3?=
 =?utf-8?B?cTNBek9OaTd0VDZkZXZqeUg5a000dmdGUFFTaXNhd20zanFSbUZDMnJtRHlr?=
 =?utf-8?B?L0xSMnpzWFIxVE5qaEhLNFV2K0NYSHJnZmt3ek81aWdSMmlDOTlCSnVFRjRP?=
 =?utf-8?B?K1dtUXBnY3ZueFRJNHBrMGlBdEd2RVk5TW9TZEUzdi9xbEtscmFBU0dvVWlS?=
 =?utf-8?B?UTc4dHo5MjlJeG5tUE5uQ3kzL1JuOXdha0lYYkhibXQyT1Z1bXN3MjBtbHVr?=
 =?utf-8?B?MkJaRWtRa3F2Wk5MYVpFWGQ4WThZaWk2WW5nYnRpRzlMbk1Md3lWMitmY1kx?=
 =?utf-8?B?VFdCV1pvQ1FKdHRYSVJjWFhyaDBqODBqMHlpcWlpdlJNRGt0ZENvL3cxVGZZ?=
 =?utf-8?B?WkRmcTdYM1VtWW1zK0hWeHdCUDlpK3VXalZUUlFRNXdoR1p6bzJESTkrU29q?=
 =?utf-8?B?dWVIU296QjJubGRuT25IS0VSeGI1NzNRQ2p4WWljblBqR1BjcnJvWUd6aC9D?=
 =?utf-8?B?a1RIaStWWDRuY0JvaUpmb0R6V0ZsMUhMTGxiL01GblpkZDZDM0twREl1eE05?=
 =?utf-8?B?UXRNU1R1K0RQRFdveUNPWUs1NU9sc3Z4aGtIQ0JEUXU3T3VpRWtDNDJjL1JR?=
 =?utf-8?B?WC9nSnhJVzl6QksrZFYzSUhkcWxXRXB1RjY4MGRocFVRUStJa3ZtSXozc3h3?=
 =?utf-8?B?dmFCZjBwSlZsWWFzL01uTzlQa2d2VldBRGRkUnc5Q25HMmJYa0FjYzZqMzhY?=
 =?utf-8?B?Rnp1Vi84eUJaUTFKSTVJVmpLSWF2QXd4TkZrWnk4d3RYRlRJUEEzbTVhL3dl?=
 =?utf-8?B?dTBKZDI3NGdMUVUxZ3l4dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmdGdjRRNUVxc3AydWhTVkgzdy90L3JUL2YrcGlnamF1TTdkNEhnVGJrMDJ2?=
 =?utf-8?B?Qk1IeTIxaE5xMFRRRDV5OTFiSkRKUW9aRTF3MGlnNXNyRmxqamdMYW5jMXF6?=
 =?utf-8?B?T3JsVlRnRWF4cjNTeUZYampTcmZsZkdDUEZuandlMnkxNmdNa1Zmdm83SWhB?=
 =?utf-8?B?TVNPclpOcFcwa2JtODdweXNPWlpBVmtZdEQ2RVVjMUdaSi9xVDlqTmpiNlg5?=
 =?utf-8?B?SmRBUEh4SVI0bE9XeUtFdi9taWpiSnVCd2x3ekpIcXNGaVJMMjBDRnA5VUFl?=
 =?utf-8?B?Sm91WlR5S1IrN0RrOW5ob2VURmxORHVQTnBrUk1ERGt6ZFg1ZDdaZHZtR3or?=
 =?utf-8?B?K0hJNGNVMDJtUjF5dXBsQmNrNkFrRW9Sd3NCeG5sTHd4ekZFN09NMHNxN1Zw?=
 =?utf-8?B?MTJCdGdZLzNjdy9ueUNFVUpqM0JJY3loRjBIYlVoRWRKQ01lUTNwdUwrbEQy?=
 =?utf-8?B?Qkl4ZTBjWlhUUlBtUHNlalRKNVdVTmxqTGVjckk0M0lTWnlNR0Rtc0JmdktP?=
 =?utf-8?B?UStDdG5DMUJlTzd4QlNkZ0tKWVJZQjlxKzQ1LzhKYnBQdjZ2aStDMWw5WXFD?=
 =?utf-8?B?RlVRU0JqeSs4L0lWYWFWRmJKN2UySTlhR0pHcGNGWEtkWnpuclB3OWEzTmhp?=
 =?utf-8?B?bkdaRVJkVTRubUlBVWR0cjVGSTU2aHltTkNUbjl3VHArZEkvUFlRUlZmWGs1?=
 =?utf-8?B?Qkdma0FXQWVJTWRzbU4rcUFWQ3JaTGVsUVNWbXR4RVUvVk8vcDVrdTZweHhM?=
 =?utf-8?B?OVp3dG1LK2JtSzJKMys1RVh5VkdaQTNxWkFHdmJxYUduamlqRWNxWHBsMjhh?=
 =?utf-8?B?VStTc1Fqb3o2MGtwdklCVW96Y1kyeERBcFZoZ3pzZDhtak9rc3NFRms3eHpk?=
 =?utf-8?B?T1RlMGZ0QldxM3dvN0ptUlJKNklaK29JSk1iNC9sQXlyYWtmd2F4Q1dwam5C?=
 =?utf-8?B?dklobGNOS09oZ3NlcmJKSW5sWkNDbG80eEJUV0ovdEY5Mko2Tmc2V1RrREtF?=
 =?utf-8?B?c01DQVlZVzRnQTM2ajRQYTUraXdQdDBWeGxUcllycEtzS3E1SDdQckRpZkI4?=
 =?utf-8?B?S0JQdTlFaTkva1VFM0lyVDN5c1pzK2R3cHljRXZpcmcvSHBFQnFaY0cvQ0JD?=
 =?utf-8?B?ak55V1VKZU9KbWd5YTcreXB5RzNHNXhJTHRYWFMxcWRlVjdKdmdPRUZGVHF5?=
 =?utf-8?B?Zi9IaFRzVktDUjVVcEVhY2lqUFYrY3Mva1lTRUdWWDZLcTAzN2lqdzZoeWRT?=
 =?utf-8?B?SWt5cE5nbGgvTFV0UWZYRCtidEF6MllkSHJXajhIRzliVXpEZFVCYjNiODZU?=
 =?utf-8?B?amNYWHVFSGRrbkVJelZPa3k1YW5SeDJwY2I5Y2lpNjhaVjhlZGVYVWJEMEtY?=
 =?utf-8?B?bTMzNi9PMXR0eGcxZlhZT1JrdE9EaUZXUXlnMWMwOW5Ycy9sNVRZVkNENnZn?=
 =?utf-8?B?RDM5K05lSk94R2VHSmQ4RlhUUEZiZXkvMjQzYW1jWTdMTWJkcFdrOCtmUmg5?=
 =?utf-8?B?U2pPdGEyeXkrMUNJcVcvNVl0R1hvRmdDZVo5ZGNIOHlpNWpwelRrY2RHSjYv?=
 =?utf-8?B?T2Z6Y0Z4K1ArS09MUjladkxsa2JOYzIzbktMRkpubEJGRDNZMFlNTVpWK2o4?=
 =?utf-8?B?QUdFUDVQbFg1VUZoWWdZcEZWN2E3VWNvekFDazNtUzBraU92NUx0WFQvRzRO?=
 =?utf-8?B?eG9IQTlFOG1HQmpuSlphRnJwQ1BjU1BPSkEvNmt3ZTh3cFNKT2dVajdBeFQ4?=
 =?utf-8?B?dTA3TmpvOEZ3aHc2L0dzZmFoRFlOWGdReVphWndBSXhNTjlCNlNQeFR1akZB?=
 =?utf-8?B?c0lKOElCbTM1SXkvK2twVUszeEhRQ1ZzRWplcytjNllZNjE4NHZjNUJQSllR?=
 =?utf-8?B?NXphUG9IYm85UDBWTnJIUXpUbWpSeFlUVXdRTHU3UkhvMjFROVVWQ2Nza3ha?=
 =?utf-8?B?UHYrZ1BtWU9MaFdHOXY3OFpid01ER0oxcWVyUEg1eXBYdFc0UzBNTUIvNDZM?=
 =?utf-8?B?ejZDUkc0VmZlSjFMTk1lelhESHd3blI4bW40bThwbW5oVDJNY2hjeDlidFkr?=
 =?utf-8?B?d3F4NUdweE1LeTVqSWl0WkEzem5HVWlZVTBDcGFiZTc1TXFoM1BaaW1XQ1p2?=
 =?utf-8?B?cWh2TmxScE8zNEllUExsSUtic0lUTnViekpjaW9HbitFaHUrOFNxQVFwZG4y?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc51549-f5dc-40a9-903b-08dcc3b23f7c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 20:29:11.7438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hXihi3R/V0rvMGQ6tTJzPJQw0L6oaIgx7rxYN/++LeCc0RPhzMvuGloX2NvVeEsY2ArORJEkJRJPYDtYbyZSqO9e3XGD4lxAbiujIzS9TRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7107
X-OriginatorOrg: intel.com

Hi Babu,

On 8/21/24 6:31 PM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 8/16/24 16:28, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 8/6/24 3:00 PM, Babu Moger wrote:
>>>
>>> Feature adds following interface files:
>>>
>>> /sys/fs/resctrl/info/L3_MON/mbm_mode: Reports the list of assignable
>>> monitoring features supported. The enclosed brackets indicate which
>>> feature is enabled.
>>
>> I've been considering this file as a generic file where all future "MBM
>> modes"
>> can be captured, while this series treats it as specific to "assignable
>> monitoring
>> features" (btw, should this be "assignable monitoring modes" to match the
>> name?).
>> Looking closer at this implementation it does make things easier that
>> "mbm_mode" is
>> specific to "assignable monitoring features" but when doing so I think it
>> should have
>> a less generic name to avoid the obstacles we have with the existing
>> "mon_features".
>> Apologies that this goes back to be close to what you had earlier ... maybe
>> "mbm_assign_mode"?
> 
> Lets see:
> #cat /sys/fs/resctrl/info/L3_MON/mbm_mode
> [mbm_cntr_assign]  <- This already says 'assign'. Isn't that enough?

It will be enough if "mbm_mode" is intended to be used for all current
and future MBM modes/features but this series instead dedicates this file
to just "assignable monitoring counters" feature. Doing so prevents us
from, in the future, expanding this file to, for example, contain
a new entry representing a new feature.

> 
> default            <-  Default mode is not related assignable features.

If not assignable features, what is it related to? "default" being the
absence of assignable features still seems related to me.

> 
> I would think mbm_mode is fine. Let me know.

If this work is reworded that it is intended to support any MBM mode then
it is fine, if this work remains to dedicate this file just to assignable
features then I think its name should be changed.

...

>>>
>>>     Flags can be one of the following:
>>>
>>>          t  MBM total event.
>>>          l  MBM local event.
>>>          tl Both total and local MBM events.
>>>          _  None of the MBM events. Only works with '=' opcode.
>>
>> Please take care with the implementation that seems to support a variety of
>> combinations. If I understand correctly the implementation support flags
>> like,
>> for example, "tttt", "llll", "ltlt" ... those may not be an issue but of most
>> concern is, for example, a pattern like "_lt" that (unexpectedly) appears to
>> result in set of total and local.
> 
> Yes. Should we not allow flag combinations with "_"?
> I am not very sure about how to go about this.
> 

This topic seems to have moved to patch #22.

...

>>>     # echo "legacy" > /sys/fs/resctrl/info/L3_MON/mbm_mode
>>>     # cat /sys/fs/resctrl/info/L3_MON/mbm_mode
>>>     mbm_cntr_assign
>>>     [legacy]
>>>
>>> k. Unmount the resctrl
>>>     #umount /sys/fs/resctrl/
>>> ---
>>> v6:
>>>    We still need to finalize few interface details on mbm_mode and
>>> mbm_control
>>>    in case of ABMC and Soft-ABMC. We can continue the discussion with
>>> this series.
>>
>> Could you please list the details that need to be finalized?
> 
> 1. mbm_mode display
>     # cat /sys/fs/resctrl/info/L3_MON/mbm_mode
>       mbm_cntr_assign
>       [legacy]
> 
>      "mbm_cntr_assign"
>       Are we sticking with ""mbm_cntr_assign" for ABMC?
>       What should we name for soft-ABMC?
> 
> 2. Also we had some concerns about Individual event assignment(ABMC)
>     and group assignment(soft-ABMC)?
>     Are the flags "t" and 'l' good for both these modes?

If I remember correctly the previous discussion ended with the need for
"modes" that indicate to user space what to expect when interacting with the
MBM flags in the "mbm_control" file. The term used by ABMC should reflect that
each MBM flag/event can be set independently, while the term used by soft-ABMC
reflects that setting one flag/event makes the same change to the other
MBM flag/event.

Reinette

