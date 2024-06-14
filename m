Return-Path: <linux-kernel+bounces-214187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7582C9080D5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CDF91C21803
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC502AF0F;
	Fri, 14 Jun 2024 01:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AjA1OTEk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B89565C;
	Fri, 14 Jun 2024 01:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718329350; cv=fail; b=UtlUrSssMtfU5coZquKznZnBDhxyYR2+z2FIYPhGs+GaFnCHi+MKLfN1NFq1BEimlZZQxp2ucl3hGkqrZxlb/NCZkcObcO/2n5YhccLR9iW0AjIcC4HYphnwO0qjVyprnfgB5NeBWFnvavap7Gv10NO+QdsbJuwxY4q3S0I0MHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718329350; c=relaxed/simple;
	bh=/2L/fj5zEDtpz2ggpcmSv9LtzEzIGJKuQo/podJb/tw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i8C683Ue/5pJM6GAZvid7BLLsq/44SmhkQE/azcLRDER5SA/7ZG4E1ZnHwm5fshvzox0itlZ1/m5j/n0hX9JxJbiqkxtYsVtBNs56tf+atGfsrJxCm27W+EFIMQIhbdqX9APfYrM9uHQHn24yCVdSiiCPAB/DBsB1q29kS1QjNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AjA1OTEk; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718329349; x=1749865349;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/2L/fj5zEDtpz2ggpcmSv9LtzEzIGJKuQo/podJb/tw=;
  b=AjA1OTEkttRMGQtQOfbJ/024hEZkRyl1rNko9y7MiVKtCuNslrPMNf4D
   5FfjyWYhJMXmRxi4nhkx1unOm6W5Je6G2P+HWNwKmrJ8ClC8jmX51uYtO
   T4C0UG+C8GcbFtGWxigWlaF6wFtVGHmOBvcxka9kTEnS62Cij3gKTGTvC
   JQ11oOMV6XoVWTBAPBOQgNRWE6043fd9Jnz5apUXzNA55X/PGld2L3SSZ
   kiv9y3XSEgjDUducqLXCPYoMGQADgGZiTmYtFEjm6L2Bxqi+QrGGBlApd
   arqHtSHmQ54nJDgDs8uhU1M6JGVmiYPxjFiGdL41pC/QAdAtmGDx49iVD
   A==;
X-CSE-ConnectionGUID: O0Psb4WQSY6uGphSJSUuog==
X-CSE-MsgGUID: Q4UoQlHwTPS5ILtZK1yr0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15358943"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="15358943"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 18:42:28 -0700
X-CSE-ConnectionGUID: pQbcA8g4TLi8cifk7I0Mhg==
X-CSE-MsgGUID: DNPaHnBaTIeCWrVsyRq9oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="45475855"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 18:42:27 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 18:42:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 18:42:26 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 18:42:26 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 18:42:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1mNqMGChb4H3Rb/R30woKmDn1/G402HqjOGoYyeZc1rCj2Ha5C1W1y99vGQKrVeJPqtLu+sSvpyIewlNB+jH/AD/8Y9ufVeTX6KOM/ho3XRgDRWRjjlKHPk5K5iK8pHDCKvIIYqqgpND+rFDqzHXLmJ+tguU0qyNS6gBBAH3ncoZGJrV6UAXA71YxOiYCPoxnT1nL4DOMmWxbOLDRnP69pCe+oWmd3/s6pQ3hLOfsf6nsoPOu3IkddgYgTLhvZqX1otH8oLA1A1nTdxYobsmIG3iJfk7IU8+4i/WfcsKguUC0DigObrJHTKJ/TkqZiEf9MqaoD0TxoXAMRMe4xzwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rndtwi5HlRaqiH6PhqL/DsId0Y70r6JjVY6fFu3be4=;
 b=ke79HPIfOboOsMYOW9BqULzWH0Tx6YOymkDgV30ll1cbtZN3EPDynXlrMkh1L9rfM/Lsc61jYaTXVXi5dla5Jr4HoA9LQZGU4/mzK/TF/wZrzOEMvKu6hBbVtdxxgqB2aMHAlRSFvvo7NSf2GHPMAcXtpe0Y6+B47Qw0FXG9FK68qKJqIsbfbCmbZbLF9anABiWlOrQDG+xATHke4Lc0gWIFTrw9hmig2+zbPOmjQGBVIWvJYgpE6WJkii39KmTctokURsBM0+c3f7oZU+RD9w9m94KjcGsgJe4zk6T8HG42J/tB9ei6acbyIB0ETZG2baDZeVPrgLItMYIUCPuRFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB6885.namprd11.prod.outlook.com (2603:10b6:303:21b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Fri, 14 Jun
 2024 01:42:23 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 01:42:23 +0000
Message-ID: <915bebc0-03bb-453f-b468-6cd8aec08de5@intel.com>
Date: Thu, 13 Jun 2024 18:42:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/19] x86/resctrl: Initialize ABMC counters bitmap
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
 <395f8ad5bba4e572cb8bcee11fa19b02cc950253.1716552602.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <395f8ad5bba4e572cb8bcee11fa19b02cc950253.1716552602.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0382.namprd04.prod.outlook.com
 (2603:10b6:303:81::27) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: d5fcbf1e-9885-43d8-9033-08dc8c133cbc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|7416009|376009;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjVJODZrTGdOb2JpcjEzNlZCdytGVFhxTkwzRnYyamQ4MlNnUzRndlFWMUpq?=
 =?utf-8?B?cjd3YnREZU96NHo1T1BxaThtUy94eDdEQkdZeHVRdGlDcWh4a1VtWWtoMHpX?=
 =?utf-8?B?anlmZkFuM21yYjhtbkY5M3VkSTVIbTJmN0t3UHhGZzNMUGE1ZzViQnhOdnNR?=
 =?utf-8?B?UmNYUnJKWWlSNHRzaGtYZHVNZkY4ZWdvR2lxNTVpaFZpODNsUHY5Zm5RRE9u?=
 =?utf-8?B?L2JTbzNPWUk5MEY0aWJGWmtEUHkvUTI5TUhiOW1TcU14cndMR0tjVGNYYTB3?=
 =?utf-8?B?YXFWQ0tnWVdaWDRaNGV5R0FDZ2FHeFZFbHc4eHdnbVRCM3BPUmVwc0I4eWZI?=
 =?utf-8?B?aUlndGVWUDJ5SmhLaFlQL1h2Q2E2SkNGYnR1SlVYVTAxYUZ0UmJkWTFJaEhO?=
 =?utf-8?B?OU9QT0FZVFBsNnI2VjhLMFZ3RVdzYXhoeE9zZjRlY2hGVTZnRVJxclB2NE11?=
 =?utf-8?B?eU5wYlg5NGZMZjFUdFl6cTlReHAwRFlFTEpkMzJ6cHIrQzEyOE9ZanhYZ1hs?=
 =?utf-8?B?U2wzL3hxQmZYQlpXTWx3NGNPS09XT3lSS2dMdDlNNHN5RzNQTEh3MG00dTE5?=
 =?utf-8?B?TWNSdG1LUEZUOS95VjNmZC9ObEZIVndLZEEzZER2dHNXNmJSRE1ob1VrK3lE?=
 =?utf-8?B?aWxGZG82a0RsWER0c0lvMzg3K1A2ei9QZ21CYnVUQW1WaktpcU5EUlpJYnFu?=
 =?utf-8?B?V1N6RzQvbTArOFhFeStEaWE5K1FLNVNCSkxPNEdQOXh6bjl0OWZDZFM4dXV3?=
 =?utf-8?B?Q2xKa2NKQWY3UVYvTTJWd3cyMUVTK3NmOFFFVGQzazZmNzlzZlU4c0NmUERr?=
 =?utf-8?B?U3VhbHJXTzl6aUZvUERCYklKMU5RYVBkZldpdVlmZjFjajZycHQ2SXNrZ25C?=
 =?utf-8?B?TVZkSnZWeVIvUWVCVHdETVRkUXVoRWQrTnZwdTN6SGU0WHlRUXlxTFppa04r?=
 =?utf-8?B?Y3JLTVpsZ2FxQk1zZ21VeWJjbjhUZmljMWlUMmtXekwveFNsOXUrQ1lyS0V5?=
 =?utf-8?B?K3VnOGpCY3hvZjRmc0kzcnp6NFhIY0xQNnBUYmZyL3BTdnZyUjYxYXVKZndn?=
 =?utf-8?B?cXpkK1ZrSG9sOWNrRm9oZWZ1REJkejN4UXFPeVFFS3FVMWtQSjBrTlJmUUVX?=
 =?utf-8?B?b294UW85bWkrdDlKR3Y1dGZCR1NuMzl5cXdyTHpwUHV5b2lTYkludlkvVFBK?=
 =?utf-8?B?VWxGODNmam0vQy9uV3Vyejd6bWZNRTdEWkZYS2lVRXlvL09Pc0lobzhMY2lM?=
 =?utf-8?B?OTg0NnliTTh2MnZ3NkVGYTI2a0J0Q1NyZGlyWjRMQmZTSDdSOEdWM3JHUGRj?=
 =?utf-8?B?ZHRGRmtGakxaaTg0bldNMmozRzBRc2Zwd2dtREpYYlY0VVFYUldxWUd0QlJz?=
 =?utf-8?B?OVY2Y2IyaG01WWczNkpncDFpMlpveTRCTWxQQ0MvTXltVHlicHF4dmR0bzI1?=
 =?utf-8?B?WDgyS2FlVmVVWHR5THJKZVdrejc5UlBCU3hYZzcvUzJoODBoVHpCVExHcGFB?=
 =?utf-8?B?bEdVN05sUWtTQUJSTHFCa1pHWC8rcUJzRVV4Qm45TXpnTVZ0MVpubFhNVlhq?=
 =?utf-8?B?RTJvZmVYSHNEbUZEV0lKU05DaVpBTGo2QTV2N0pjcVRQVjQxQ2RwVHRMNVl0?=
 =?utf-8?B?UmJxQU9KYjhTcGtGVlJFMmlpdFpVd0xLWTdkalNHaUFvN3RNcWpMZS91TmhS?=
 =?utf-8?B?ak9PT0phVDdnOXhOck4rRUpmRVF3bU1XeDg2S1RjVUpKVk9oSTBjWFB3cVNF?=
 =?utf-8?Q?Ts8ykyKXsPnnSNeCbSSzCNS098P7lSIaaCGk+De?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0hUcXYzRCs4RE1XZEg0clRpTjZtNFBxNnJaYWRTd243bmdxNjlDNlJQd29V?=
 =?utf-8?B?eHhZZ0RIV21jWFg3TVZ4NjJtMGhvY0gvenpNSDdnUU11TjM1MHlBKzFGVUFS?=
 =?utf-8?B?RU5GRDRzSFVZWmJIUVBWSjRNMUlTUW5ELzlxZGF4MCtBWEJpSFhxbnUvUkFC?=
 =?utf-8?B?S1RybU55VmVkRmxIZWt2WVBNL2FOb29Fa0tCaW1GQzkvT1Ftcks2Q2VtTEth?=
 =?utf-8?B?T0EvaW9OVkJ3enA4QmdSMEkwT2swci9TRCtJTUF6c0FTcXpOeTA0SE8zZFgv?=
 =?utf-8?B?ckN3REd4SUhKNm9aaUhIeDNPZXU4dm5IWXdnRysrNUZhUEdUQ0hCclhaVDB0?=
 =?utf-8?B?dnRBbFF5S3gvdW1mZkMvN21ubnM2TGdzWDhwdVF1QmhXUVZLZW1HZzUzemFM?=
 =?utf-8?B?blh0TUxUQVNZckNiQzM1MXptejRlWHhlREtLM1dXL1d4bi81OTFOR3Jza3RU?=
 =?utf-8?B?cURBOHJqTjg0b2lFNE9IVlordXpFelFEaFY5ditwRzVLRWF6U01DbnpOZWlS?=
 =?utf-8?B?enZXcnJ1Qy82bUlLYXpwb05MOHZsZDBNNnRSUXdTUzUwZE1xK1pTMGE4akZZ?=
 =?utf-8?B?MDN4eWdteTVNUFlDbG9kUmdCdG9QNmdxdVk2VVdjM0JOanRjNGY3Mktrd0k2?=
 =?utf-8?B?eGFPcnpPZnF3OUFrbSs0dVViNkpMaDJZMGdFMUgxTU1uVFFGcWh0OGlEaFZ4?=
 =?utf-8?B?V0g2TDFTVGhpemNYTmRPY2ZGSXA4MVlHSndCRVBiTWF4VTFUOVpBVE00aVBW?=
 =?utf-8?B?RVd6VGdKdjRyRldCay94dVdWdWZEYTNZdWEwNis2UlIzalZhR09BM0lBdFV4?=
 =?utf-8?B?S0MxUDR0VVgwOXo3ZEErY1JEMm5aV0Rzdmt0TUtEZ25XblBsYlpYZFY0OXh4?=
 =?utf-8?B?OVBpajN2cWZaYTlnS1VNM2QxbHJUa2FwMFFxclZNQmptVGdETTlsbnJ0RXN0?=
 =?utf-8?B?VTZxQjE2VWVBcnZUOWt0c0lscm1nRWt0NEVqL2pLZ2NGNHZhclJ1MVdmbG5i?=
 =?utf-8?B?WXA1dHRkYU83bVMvRWFkTVlWQUU0WkMyUVkwUVlQZE1YT01GYS9WbC9sWGdK?=
 =?utf-8?B?U2pNdjNSTlhmejlzZ1pPRXZSVjRHSmppWFB3blZuemJPYWpMaTdOYzhHRm9m?=
 =?utf-8?B?dEJFV09nNURmY0ZHMU8xNk1Wc2lseWpaSjU5T1oyaXNRcnBtQUJnek9ZbnlN?=
 =?utf-8?B?NTk3VEY3V3I3M3pVeU9Ic2RpUUpVMUwxR3p3ZWNVbUZud2krTzI3YXNxbzNo?=
 =?utf-8?B?R0xpdGErdm9QWHBCdEJ2cnB3OGlyb2N5ZnJMa0ZkdDNlMExRUjNycUhkdnpm?=
 =?utf-8?B?U1BQckcvMzArQk1vSW85Z2RhODVwU3NMNE1WS08wRUpGcmJQdld5YVJCZEZR?=
 =?utf-8?B?dHFmU2JMNG9nK0NoL292eW50djBMaDlwTTI2NmdVdzA4bjNRNzhsbmVjTU1r?=
 =?utf-8?B?YmkyZ1JwWG91N0pwWmo4ZHhpTys2ajF0ZHVNTUsza0w2NU5LRSt4UjBCaFZ4?=
 =?utf-8?B?Ni92azc1NktvYTVvR3hESTRnbFNyVTkxMXRMSEZ1WXFBam93RTN1eXJmMkxQ?=
 =?utf-8?B?Y1p0WTZhYVY1NmFKSEJuKzdkTjVKUUlvbEdrSDdMVUJJSVlkUFNvV3RVN2Zz?=
 =?utf-8?B?cWVRUlp5c3NTMjBZQU1lWU1aRzdOS1ZXT1k0SWhqMDJucDNtM0w5a2c1Y2hz?=
 =?utf-8?B?aHNMZTZFR01ITXFaSFlnTEZDQWtXdTdJZ0U1OGF4c0VJbjUxbzRQTWtNeGQ3?=
 =?utf-8?B?bzkrL0ptSVNPTXA4NmV2d203NG5VMytnV0tIWUV0N3lhd1Q2WkwxcTlTWEhD?=
 =?utf-8?B?bHo0UU1kL1lkcGczbzFaYWJaa0hyTzZ3ak9haGdURjBXeEJKQVVCNjNrbXFG?=
 =?utf-8?B?ek9wWnRJWThaUkwramZXY1hHS0h1NVdhZTV5OHR1UUFySWFyNGRIWW0yL3Rz?=
 =?utf-8?B?WlhsaDIvVWVtRkN5WTJCVmdZaTgvTjJqclA5cTNmb0ZBbG1hVXRvUU93blFh?=
 =?utf-8?B?Q3ZIUHlUMldJRHlROUdrcEhQT1VXT3U2Yi9iUFRZajJ4NGFVYVlqVTNqUVpa?=
 =?utf-8?B?UUFNSGVlT21SQ21LNTlrWGtBdUx5UThIa3pkTDJjNVFQQzdRdEZKdHNqY1Nh?=
 =?utf-8?B?QXhkVnd0UnJNckZpN3BtQ3V5WGkyYXBLaWhUakJIL2gxMEtPMVoyTzI3MmZt?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d5fcbf1e-9885-43d8-9033-08dc8c133cbc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 01:42:23.2252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8tOWMHroDeElFwYe0o0GqZbVjjtdhT0a/Mj9ZAJQETzlKhba1qu2d6+/dgH5L5FC6gVOgxZVLqEKhVe5LTxzynbvsgYXVVI758BeWdcXPWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6885
X-OriginatorOrg: intel.com

Hi Babu,

On 5/24/24 5:23 AM, Babu Moger wrote:
> Hardware provides a set of counters when the ABMC feature is supported.
> These counters are used for enabling the events in resctrl group when
> the feature is supported.
> 
> Introduce num_cntrs_free_map bitmap to track available and free counters.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v4: Changed the name to num_cntrs where applicable.
>      Used bitmap apis.
>      Added more comments for the globals.
> 
> v3: Changed the bitmap name to assign_cntrs_free_map. Removed abmc
>      from the name.
> 
> v2: Changed the bitmap name to assignable_counter_free_map from
>      abmc_counter_free_map.
> ---
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 3071bbb7a15e..400ae405e10e 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -186,6 +186,23 @@ bool closid_allocated(unsigned int closid)
>   	return !test_bit(closid, &closid_free_map);
>   }
>   
> +/*
> + * ABMC Counter bitmap and length for tracking available counters.
> + * ABMC feature provides set of hardware counters for enabling events.
> + * Each event takes one hardware counter. Kernel needs to keep track
> + * of number of available counters.
> + */
> +static unsigned long num_cntrs_free_map;

Why does variable have "num" in its name? That seems strange. How
about just "mon_cntrs_free_map

> +static u32 num_cntrs_free_map_len;

Same comment about "num" ... also, any special reason why u32 is needed?

> +
> +static void num_cntrs_init(void)

mon_cntrs_init() ?

> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +
> +	bitmap_fill(&num_cntrs_free_map, r->mon.num_cntrs);
> +	num_cntrs_free_map_len = r->mon.num_cntrs;
> +}
> +
>   /**
>    * rdtgroup_mode_by_closid - Return mode of resource group with closid
>    * @closid: closid if the resource group
> @@ -2459,6 +2476,12 @@ static int resctrl_abmc_set_all(enum resctrl_res_level l, bool enable)

resctrl_abmc_set_all() was initially created as a complement of
resctrl_abmc_set_one() ... but with more initialization added to
resctrl_abmc_set_all() this relationship becomes vague.

>   	struct rdt_resource *r = &rdt_resources_all[l].r_resctrl;
>   	struct rdt_domain *d;
>   
> +	/*
> +	 * The bitmap num_cntrs_free_map needs to be reset when switching
> +	 * the monitor mode.

This comment puts in words what can be understood by just looking at the code.
What would be useful would be to explain _why_ this needs to be done ...
what happens to the previously assigned counters?


> +	 */
> +	num_cntrs_init();
> +
>   	/*
>   	 * Update QOS_CFG MSR on all the CPUs associated with the resource
>   	 * Hardware counters will reset after switching the monotor mode.

Reinette

