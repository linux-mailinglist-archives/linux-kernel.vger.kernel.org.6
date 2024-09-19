Return-Path: <linux-kernel+bounces-333695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D0997CC7F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 18:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A649F289ECE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1031A08AB;
	Thu, 19 Sep 2024 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l0zpbRgF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7354F1A071B;
	Thu, 19 Sep 2024 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726762949; cv=fail; b=IOU4B7rLkIH3ZJHBjGAibkJ2HF24plN81lYjTh6SUhLR0BSRTOQLGCcbUgcByAf9IU04IhEi4PvJ04btvI33g1lzEIiQ/utNYHnJP4z0+fV6opryS+zpmJozdSYSfymD80v1VeSiSdV/J1LWzBSdWTCWbCqnXDuc2AHPs8jkdfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726762949; c=relaxed/simple;
	bh=VYUhm2IDMaHDNqKFnk4eQa/K3fz4p3jP64VO+wTVE5Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZgA7mM7DJkw51bj45tzhNsAvsFJdcUuR1ZO/kKzOitCMpTVpsb1Gm8RW3pm5DmVz4771BiLrdbPONU1IfRriqaLO3pibtAPEGk2i2nZdkQ4md3JJh4bCPLJGk45kDCYj+1y+VY5I3Jq0WixY/cWC0Nv7StJrKd9YkZ159DVbDZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l0zpbRgF; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726762947; x=1758298947;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VYUhm2IDMaHDNqKFnk4eQa/K3fz4p3jP64VO+wTVE5Q=;
  b=l0zpbRgFYWtvNDv4vrI0WRyYl5SKwm3SmgUzvM677IIcaBlHWyIz8qV6
   kjdirrm3sV65EOGSh7w8RmrY+yswC8yI2zYeBsg6hbTm+QIt/tlcJb1BI
   W01Pm2I1nWaVwXSeVrFqB7ZHY3Bnpe30kOrdKMZb0Qcpod1FFGzCvWZv7
   10duaXkQVEBLnHrlogtc/TbKyZ/AX+W1lHB43W/xccSwf5CY7duyK94b3
   gPpPeEN8MJYfkX6uoVTrsKLZ8WDD0pdFCnvTD+B6J6MpzixnnKMzuTOw1
   BuhUxJ0bJqfiIe62s2AfO1z/T3JtmQyYbsNMX5ehytl1dsgdU0uadXH0U
   w==;
X-CSE-ConnectionGUID: 8UUfHvGbSxiIIxXVJRMovA==
X-CSE-MsgGUID: I82AEfHcTfaTxv6XRrrN2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25219924"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="25219924"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 09:22:15 -0700
X-CSE-ConnectionGUID: kED1DIVzRre+j5J8NdBElQ==
X-CSE-MsgGUID: rLRgaUflTPaHyzbkRjNLCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="70821566"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 09:22:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 09:22:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 09:22:15 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 09:22:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZB5KOEIC+F932GqibmQt7p5Y+U8zunb7UVYZRTYejM/BTGgjr7KK+NPE6gwlnPBQEJSwLKf5p45zG22BLpgVSf5lEyGIf/Kl35hbL2NY9A+EvJm6Djpm/I8aojQf4ac+RvsAAxmo7/0TVE+P1DU6f83MMzW1NCvVmOFXCtMTcI0Wy8fqfJyfHVkpCPKbu5QNMCmSYAnAGKcj13yNpy+9PSTB+OR7+Wr0lkjCnAHm9w54WN8re7aG/oh1poHdqg+AwIfS+pOWolWHsUn4T+1B89fIWMLYyOO0Wvzb7x5w9yMFHvCgPP4AyVSn4TbaQVNCmGfuYjrIf/kSRQektU4GMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLAHegZirN0Qa+RMuIB7T6D2q69DfRSmqVMYqSrqqR8=;
 b=GYPbUqbEe3ioNOzdcyJxcR+1jz3atUk8ZKv7+rkw9XBsl1WqsWcqFCr4hn1992KYdfpkP9gRA1ZITT67VltqXPeVtJ+aXPW34rAxe4J98082X1n9X059MtLj1de/MH4nm2WuX+tDNtr+8P/EWou3sJgZpIYVlV1J/ySoYeAvuqbyBCVVUExq5tCB1I1KTbvkOegjnh5e1VSNDwQ9jNue0DLKkT/AdhxTF0ss9GIpAuo+HeyghPXZcsJlz8/ZnY6vLxYpQYcIUMOIBrGlhitaXw6W8lRPi+v1F9BsfNkxUkfue3UZE3n5wTRha5R4tuS1fxkBR0tKOVavx6+mm/RfTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5079.namprd11.prod.outlook.com (2603:10b6:510:3d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 16:22:10 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 16:22:10 +0000
Message-ID: <56f1396e-8a51-43d3-9dd0-dc55a1623b12@intel.com>
Date: Thu, 19 Sep 2024 09:22:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/24] x86/resctrl: Add support to enable/disable AMD
 ABMC feature
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <556b3576ce076c8867795d4af1bcdaf883397304.1725488488.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <556b3576ce076c8867795d4af1bcdaf883397304.1725488488.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0064.namprd04.prod.outlook.com
 (2603:10b6:303:6b::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5079:EE_
X-MS-Office365-Filtering-Correlation-Id: afe12557-9f13-459b-86ba-08dcd8c7365c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzE4cFd2c1hkeE9IaWNlYTdxd25aSnh3MnhteW8rOFZqd3hyR053QllJTU9T?=
 =?utf-8?B?UVQvWFlaMVpsUGJpbm9EckF3S3B5RVU3dXZlczRuRjYyS1dzYjdJN1MxK2g1?=
 =?utf-8?B?SlFWeTRRdWFPOXQyVlUzS3NJSDFrVE5oaE9sOHdHRUhwVlJzM3RKZWZleXNZ?=
 =?utf-8?B?aVRWQXViVmozSEpIM3JVeVlNaXN2bVFEc29KWUpCK3pLOFREQlpaR0d2Mjc1?=
 =?utf-8?B?UnFmcENPRVRjL1dCNktpZ0h5cjhHbFFRaVhQU09SOWI4dndyZUR5SzUxTmVK?=
 =?utf-8?B?dDQ5alc2U3k1Q0J1VUtYWEcvL0hRY1Q1dlVyWktxV2IwYzQ0Q1dpQ0tidDFM?=
 =?utf-8?B?Z2s1clhLR1hHOG02bitSKzVWY2hzT0wxTkNPKzZIWXdNWkFJZXhZbiswdjdq?=
 =?utf-8?B?VDhLRnBYS0N1bEpGeXNrQmltSEp1akcxRS9ZTm5qTHRJaCt5aFJrVDdYVVFH?=
 =?utf-8?B?eDhmQmZCME9hRlE0VFhFdkEwbE5vZFJFSjgxOXp6amFjSkpqZVp0Tm1nTHR3?=
 =?utf-8?B?WWRjKzliOHFldFptZzgvTzdoMjRrc3N2aDZ2VWsrdUlSNEFiWlU3R2ptc1J1?=
 =?utf-8?B?S2dvbklyTFRZUlZ0YnpxOHgzRlcrcEVkd2c5bFR0VW5UeDlvd3l6L0JONFhN?=
 =?utf-8?B?cUhVcDVLNUlaZVlYTkk0VnNaUEIvYjIwbW5zTWRPSExhSEMrWSt5elg4elE3?=
 =?utf-8?B?OGhVdjhxckFmOE11dUNWK1NOSWphWktUZjQ5ZEVUbm5ZUERxT1lXTTlmcFBV?=
 =?utf-8?B?cnNuTTlRUlpDQktKT0h2TURYclBuL3RWendwYzA2WGZBSHY4MlR6akRFemZa?=
 =?utf-8?B?eXZQUFhBZ1VYQWRzL1h0aDRFdFR0bklWeDNRbk9yRlBEZ0picWU3cmhHS3pS?=
 =?utf-8?B?NlRYYmo4QTFJMVBHTmJza1JyWjg4YTFaaXpiK3dRSmVpTXdTT25UY0VIYllD?=
 =?utf-8?B?K0dZZ0M2WU1KYno1a20vckd4Zm81TlZhSUZTaEptNFoyYmtkZVVGS2N0US8z?=
 =?utf-8?B?L3NzNXZMTEZZc3hYUkRRVytBNEdYbVlHK0J1WkdlRUdQVjJwMFM0TEdjUHU2?=
 =?utf-8?B?RXNqUzFZcWNobkpaUHh5TXYxclU0WUd5SWliT3FWRnBzcFRXcDVOR2Fld096?=
 =?utf-8?B?MlBJMDFRTFV1Nkg3cjEzQVk3VW54QWJlbXZMMVhXbzIvYzRackxYdTg0MFA0?=
 =?utf-8?B?MVd5WVhCWVo2Q21wK1ZiWG5NY1IrbEs2bUJWOHozeDVkaVcvMVdLQStjYnpD?=
 =?utf-8?B?bUQ1VTBhNUZvT1J0ckxmelRTV2hSL1dvVjhPL0s2VmJPSk5LMnNHYWNiY0po?=
 =?utf-8?B?Smg2WkhGRmx6ODlFTnlFSXN0dHZyZ2hQRTU3a1BCOHJGaXIvVHpRNGQ2aUdp?=
 =?utf-8?B?QjhIcERkOGVLZExpZzNERCtXZXJZeEk1SmtXd1p3V2o0SnpsaW1oL0x6MnBG?=
 =?utf-8?B?S21ueHlxaFQrQ3EyNk42RGhKT2JSWnRMVkFGQXJyeFJMREtVZllhMmJCU1cx?=
 =?utf-8?B?eXIxOG1TMmYxNWZRenU2MDRoRTE5VDNaOUhuQjhTYlNtTHRzYjZnV00yTU9L?=
 =?utf-8?B?c1NPYVpDYXpIKzhQbUNjS2wrLzFjVE1pSXRjMTEyOWdMNGI0VHc4c3Nhblky?=
 =?utf-8?B?YXc3aXJhTG5wTmZrMlR2azNGSnZpcmRqOWRZV3hoK000OE01UmlPN1o0OEQ2?=
 =?utf-8?B?WHkwekNtdHBSdDRSUXM5Z01LQzRVdGdGT0hVSmNJTkQvQjZSU1AzSEo2aCtk?=
 =?utf-8?B?TVRBRWg2S2NOWHg3dVpLT3pPdEE5aFFLVVNCVzFnOW5GeEZoZHd1RnNTZGpJ?=
 =?utf-8?Q?HeUAvVJP+MJ0qk323PIgubu1fPDeCJl6mCAQ4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDFidGh1Y2EyWGgrQWQ0cmZObUc1R3ZjL0l2QnhVaGJZQVZ4c1ZMLy9iU3My?=
 =?utf-8?B?K0lpbWh4L1pvSWZBMnJvdktwSTdTVlRUVzk2M0tueEFWWjU5ekdSL3pQbzBt?=
 =?utf-8?B?ZHpncUU2U0EyeGc2YzJFbnNqRnBrcDFnR1R3a1ZQS0FPT216NlZaRklkeXpz?=
 =?utf-8?B?UUt0ZS9EMkljUUNrYjQwT0IzUFRHMUxNUkVYaDd4YmoxVGk5N05xVFkvNFJC?=
 =?utf-8?B?REFzRlhVcVFGS1U0WjQzcFpJV1dmUjdEK2hBVFptVklLdWRHRUhKRXdDZDZG?=
 =?utf-8?B?NVIvQjcxa0pKaEx5MHRyZTczMzhBUGdzM3pEczRpRUs2c1poekV6MnFNZ2Zk?=
 =?utf-8?B?cGxiaVU1RGF3TzNTL3Y2RXZRb2JNUFpwWFBnNnBvU1NaRjRYNWlWQXZLU2xG?=
 =?utf-8?B?WnZPOWJBWFoyQnpLQWRoTTV1VmhnMXNLdWRCMzdqQXMyU0Z2dWxna0FxcUJk?=
 =?utf-8?B?Wi8vd3p0allNUFR0d0RPUjlLcFZnQ3Y1b0RxdHpsTTNLYitpSEIvQjAvUjRk?=
 =?utf-8?B?d3ZZWTEwVkZLWUZrZW1QMmh0R1Ftd0JnNGJjT3VMNDVaL3lJSDQvRTF3WmFu?=
 =?utf-8?B?a1pNYVorRWFtTnRMZnZQWVdISVNKdE9mS1AyVXViTlRmdEFtUEwzeFc3d3d4?=
 =?utf-8?B?cFF4UHYzVWJsMnlTOHdkZW9sb3AvWFlGcEV4RjFjdUt2MWE2YWFncjBWN3pq?=
 =?utf-8?B?eFFNV0szSVdYZzhrV24yZkkxTmwwb0h3azIzUVlwVmVoUGtZSFZ1NUR0L2JD?=
 =?utf-8?B?aXJBRWFHYmh2Ymc5elhSUmUrTHF0SElWMmVRdG1ZTnY5M1l0cERDeTJBUklM?=
 =?utf-8?B?LzRUT2puUkI5TlkwVkN5VlQvZVpLeVBDYVpOVVV3bkpqb3dJL1kzRmR5ZmdZ?=
 =?utf-8?B?QnU1VGV3NVkzL0wrRHplSVZXVGdCWEZ0aXgyZ1ZlcDBkTC96WUwwMGdzSEs5?=
 =?utf-8?B?QXhrZno0OXNQTlA1ZzE5NmQ2TGVjaEdKdllJbGFVUmZ6RGhLbWhrV1U5QTVY?=
 =?utf-8?B?RUx4VDNjcFhZYi9RdjNXVHlETEM4K1dnNk5iWnFiMEt3Mjl3N3prZjBQTnhG?=
 =?utf-8?B?eE5pMGhmUUswcUx1RzhsQTNNTjFmdjN5czlmbnVQNFNjSjRLKy9yZVVYM0VS?=
 =?utf-8?B?c0gxZ084KzBPSzNySFdRNEVocGJjRyt6ZTBhd08zZmcxRTA1V2tsaGZhV1Z3?=
 =?utf-8?B?QzdNVUdFVlJWZDVkSStreW9sY2hyWFdWRGRwZy9leDhWdWlBMWZZR3BWenFv?=
 =?utf-8?B?anFUdVlKZjdkWlVkeVp0S212SDdVdW16OCtmWXBtdkJ5VkRGdlpyQWNxemtO?=
 =?utf-8?B?bmpETHBrWG55YXdiS2daS3Z0cHh5bDRNUisvVkJOaUJGQVgwK0xyUXJkaFNn?=
 =?utf-8?B?Y0lxRXhqSU5KOTAxOE1kZHZpdUovdWVFMHZrR3JrQi9Bd3g5L0pudEtGODR6?=
 =?utf-8?B?d084Q1c5Y1MySGRZQVZVMmtYMzEzY3owNDRLSE1Vb1R6eVlWQ2dDZDdFSEpN?=
 =?utf-8?B?Nyt1ZDE5aUxaVThsRDdnclBJazJBM0E1T3M1eTdheVNjcVMyUEtOQ0ZoVTJv?=
 =?utf-8?B?bFBmRTVFZ0hsQ0htL3RncmRvMkFSeGhCVGlFdUYvU0pLakVXLzNNRitDVlMz?=
 =?utf-8?B?dDdidHlSRmN5RStFTDhMdVdoaFlud2VaZDZpN0gzQUJwdlF4REpHY0NleHlB?=
 =?utf-8?B?MWVGNEk4ZDdmL2pEM0xPcmNWa3diWTcrVzQ4QzVCZTJYUVhQM1I2SEZFSUZu?=
 =?utf-8?B?ZUNURElHazZKd2NXeGR3ZmZKb3pGRWY0V3M5SmVSQzgybCtjckRtTFZRWXJO?=
 =?utf-8?B?K3FESUQrdWNQV0NmdlNoeWZyWkZzbEpVQ2czZ2ZDRWd3cEdFNGdFTENNaUla?=
 =?utf-8?B?RnNXMitjMWxFSWg0L1djRjVvdWRjcVBoZHdWaXRyRkVNTUd1ckpiaFlNSnlR?=
 =?utf-8?B?WE4vNmludnFsTlVrZmI0d3JkQ2NneS9WS1RUdlloS2V3MXdHZjZoeUlmM1ow?=
 =?utf-8?B?bk1jM0Zqa1JPQ1M1TWlVR3lraG1IcnhQM2pkN2F4MHk4citxamFvSDBCSnVj?=
 =?utf-8?B?RlQ1YkpScGYxUndJQU9OMW5vakZ1YkZnUyt5aUlncWU2dzlQTzY1MHdhN3Nu?=
 =?utf-8?B?eExzTE1QeldBazZNQTMyeHdsYUdub1A3UEd5T3Z6Yk9CTmtWaGxwWWFpMHlv?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: afe12557-9f13-459b-86ba-08dcd8c7365c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 16:22:10.2944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tZQmGB1D4aiCE1VNxDxdFIr94Lo7XZJwIIGp0Ct9IJmSjtKX6RLxbLTsQA+P6ULUbZtHctxLUTh71VTWDqHBfPLMZzsfEZq9WxR1R3kHmiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5079
X-OriginatorOrg: intel.com

Hi Babu,

On 9/4/24 3:21 PM, Babu Moger wrote:
> Add the functionality to enable/disable AMD ABMC feature.
> 
> AMD ABMC feature is enabled by setting enabled bit(0) in MSR
> L3_QOS_EXT_CFG.  When the state of ABMC is changed, the MSR needs
> to be updated on all the logical processors in the QOS Domain.
> 
> Hardware counters will reset when ABMC state is changed. Reset the
> architectural state maintained by resctrl so that reading of a hardware
> counter is not considered as an overflow in next update.

Above mentions that architectural state is also reset, but that does
not seem to form part of this patch? 

> 
> The ABMC feature details are documented in APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC).
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

>  static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r)
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 7e76f8d839fc..0178555bf3f6 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2402,6 +2402,41 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable)
>  	return 0;
>  }
>  
> +/*
> + * Update L3_QOS_EXT_CFG MSR on all the CPUs associated with the resource.

This comment is not accurate since the function below only sets MSR on current CPU.

> + */
> +static void resctrl_abmc_set_one_amd(void *arg)

Reinette

