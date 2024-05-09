Return-Path: <linux-kernel+bounces-174786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EEF8C14F3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D991C20FEF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 18:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309E47EEFD;
	Thu,  9 May 2024 18:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dcnDadaH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346A27E58C;
	Thu,  9 May 2024 18:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715280093; cv=fail; b=A0fhqYZYr4yUSqtYJLK9qMYO1wagbS7/X2yS0f5dTPJyymaqMU3Gf9iZWWNjeYAzRR7HTJ8tQAV5tH+bVibfLHU2G0DXGqx5ps6EzGvAIAGYWd9JKGkQ7OQtto/DnTFv5LuKk/ohScltFO+vnvuy5PTsbVKbsOR9uGr+KBU95ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715280093; c=relaxed/simple;
	bh=5iAmVDe4Pbp6QFb/W76qvnZ7b1pTMEyGIO/VYkCC4Is=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I9B4q9fbB+3TyoPYDo1eYKYbDsxdM5vmphOzoip5HfPpBwcpC7U28rqVCed0OhUw0iJfWzlP3ANUeMyZsjiuQY96DaBnWeqS2RgaKGU7j63gxm1x8CvljgRqRkJ0I3wNB/AY2gm8DWMChnye0nUZiFm/V9HsAMc99kMHcQzpxRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dcnDadaH; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715280091; x=1746816091;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5iAmVDe4Pbp6QFb/W76qvnZ7b1pTMEyGIO/VYkCC4Is=;
  b=dcnDadaHfrBp/yPpDGhdgSYKOkernhRVtWatu/13CSzYojlc2IlOC5MJ
   1lfjskdudeAEDz2N7VAUGxYqboZmtXCZ18AaD9x6kskU1668lvDNRTm2y
   GNzFpoi9XNaQrbK9Is+F4EAGJghgbGlF2WmhAkTl3400ToAvJzNKlZXCb
   Pc46zf+ct93PoLWvH3ttPI+k4csXhx2Y5ID5E2zm1qtPwQdkvJVMitemn
   N3UBKUkTZAxIOZwFXASwD3LZBUyyBVRTRpOCur7aNlgj0FVQ4fWXivwBS
   XGT5iLU8A+X6tDLAWAV9UJbqffua3PxHXnGh7u2Y/aEwDqwqeQanym6gT
   w==;
X-CSE-ConnectionGUID: 48Y6KoyuQH6jpYogaBYhiA==
X-CSE-MsgGUID: Ui931ZhNQieU3g0rwFY7lA==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="36604127"
X-IronPort-AV: E=Sophos;i="6.08,148,1712646000"; 
   d="scan'208";a="36604127"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 11:41:30 -0700
X-CSE-ConnectionGUID: ydzKphvMQMqDJdzhKXv8ew==
X-CSE-MsgGUID: UbitXb6URbqqUS6OyqRYTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,148,1712646000"; 
   d="scan'208";a="29205898"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 May 2024 11:41:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 11:41:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 9 May 2024 11:41:29 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 11:41:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQgd0qlyu+ZHQwGSh+A8qAdG/8lI/AEeNrbGAiIw6jeArLCnAfEW/hzd3NJMGj9gwdCsTv6oob4vc58qtnzkF04vnoQBQxz9r6T5iUXDIWeLmWeX5vBM2XHB37nBkwG/pY+SbCm2QeJVrm2S/Qhayy8jYff4hTNvIBxEHgYhp+6yednKtdLVvMIoEtodAF9NdsdMtJaC+a40xUX229etTVm55cbmbz38FwbNMbvJ/55S1P8dFZ/2Q7+EoltvJIXTQJVcLqMktZR1IO6dfNM2bi5i23Bz4MbT0ApRoHx8456eX5ItnqPpPlNFrU7gvvoQWe7j88quip388QP2crcvXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyrXFBImVMkTCV8qzDbGJr7DjnzPJZSuU1roICm0Tek=;
 b=JCrkP0VhyKznDRERwDKj7HfkDhzes5eGtatxmoASezYnryiaf7n/acHX1PTEsSvCHFUOa6ipILtleEwvdKIMqimJoc8ULmfEXMCPQ2K+o+4cvy9F7LHX4azxFOn8vWTKJ00bEZYae+qKaGzLqFfjiOSItqaVXs0r54sx5Pp18ZOMswpQ570E3Ujy+uHSw4ZPXFwe8EJ1U56vrndvfM8mNQiHeoY4krTPkX22hQmgWLZQqbW7Ayas2dUUabk764A1es4MVmNUt4CogUhfJUKIwjx0TK5D0o2LcHRh/aKc6h2KzOdC/Occ1foFt3sm41oMImGnXiSXIb/5DTKbLay8iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB7164.namprd11.prod.outlook.com (2603:10b6:303:212::6)
 by MN2PR11MB4517.namprd11.prod.outlook.com (2603:10b6:208:24e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Thu, 9 May
 2024 18:41:27 +0000
Received: from MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::a972:1395:dd49:1dc5]) by MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::a972:1395:dd49:1dc5%5]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 18:41:26 +0000
Message-ID: <758089a4-52d5-4649-8aee-89e60044918a@intel.com>
Date: Thu, 9 May 2024 11:41:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/fpu: Extend kernel_fpu_begin_mask() to
 initialize AMX state
To: Dave Hansen <dave.hansen@intel.com>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <platform-driver-x86@vger.kernel.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hdegoede@redhat.com>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>,
	<ashok.raj@intel.com>, <jithu.joseph@intel.com>
References: <20240430212508.105117-1-chang.seok.bae@intel.com>
 <20240507235344.249103-1-chang.seok.bae@intel.com>
 <20240507235344.249103-2-chang.seok.bae@intel.com>
 <f82879a5-f3ca-436f-8c4a-96d4c5d90354@intel.com>
 <7e589b35-4ff8-43fa-99dd-d3b17f56d3ea@intel.com>
 <fde6149c-7ddf-488f-98c0-04f336b7092e@intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <fde6149c-7ddf-488f-98c0-04f336b7092e@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::35) To MW4PR11MB7164.namprd11.prod.outlook.com
 (2603:10b6:303:212::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB7164:EE_|MN2PR11MB4517:EE_
X-MS-Office365-Filtering-Correlation-Id: 86a9202d-d91f-4122-cf28-08dc7057a1e9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFNlUWkrUlNJSEQydytWK281ckU1VEVEeXlYZUh6K3g4VVFuaFVNdHdmWlFZ?=
 =?utf-8?B?cFJhaWtIRXQyQlJ0QWp1NnJkNitVZFlkVmRmSFM1WW5Db1k3NGwyVVEzZ1du?=
 =?utf-8?B?NEdiTVlINlRWbVJWQWwxS2h1ZERjaFFheFdpMDdGMlE5YVNHNXdzZDVXQU12?=
 =?utf-8?B?R2hFTVZ5cWpHUEtoMFdVSkMxTUYvSEhjdkVKVEs2alNaNmozYmpBK2kvaFVO?=
 =?utf-8?B?T3YrNitPRm1ZWEhjcUFSRnVTYXdOeXBKV2dENCtVOE9mQ3VLejF0ZVprcVNH?=
 =?utf-8?B?NWFTbjVmdEZkaksyRnVjVTk4WEsyM285YW5pUlVJQndPWlpBVGxZdklqcUZL?=
 =?utf-8?B?bWJXVUM2WEVUajY1d1V5bStuU0xsalI5T3ljRzcyMnlJbHhONEN6cENVaXIx?=
 =?utf-8?B?WnBjblZzWUpPTmxSbEl4eDl5TWsraFpDTXE4ZCtkWVVVa2hPWEtaVmhvWmdD?=
 =?utf-8?B?VFFXRHdMYVpZQitETXk5VE14UWdPNzMrb2lvUjRXZXdpTVNEQUloa3VGYmF4?=
 =?utf-8?B?UWFMZ0x4V1pKMFFnYjF6d3NRbUxTeCt0ZGc5azZWU0w1eUYydGtWVFFvWDlw?=
 =?utf-8?B?RUx3a2xHZFJnRHJYdVdmWXkyVHRPSkx6NTA4a0ZDbkU5Qk42dFZoQllOeXRk?=
 =?utf-8?B?QjBYVng2QnhXR096c0VOZGQyTXllMVR4ek9TUXZXVXpXd1lGc2svc09JVno4?=
 =?utf-8?B?ellUTkxqV0hLNWI4dGd3VnRaWGhxb1pYSUZXdWZpYlZycDNEcC9QTUZRSW9J?=
 =?utf-8?B?bkxDZ3FkdUlEYmFSN0l5M0xZYXFBQWRsVTBGK2ZFSXM2NFJYVUQ3T0xCbUVy?=
 =?utf-8?B?L0NiNUhxaXlZNnNySEt6SWgxVmNibysrSXlnbWpyZ09qckRpRE9DNmpsNkgr?=
 =?utf-8?B?U0VpZkpJWkxIbUgzN0xBeEZmRlE3R3diQkpRTGtmMGowQXp3bkIxMkl6dFBM?=
 =?utf-8?B?dmtSdkpCTVhWZURrZXcyN05xbS84dTBUQ0NRWEcrc2tiYXZqMlU2S2Y5U05l?=
 =?utf-8?B?SFVpN0V2WU1QUXRhTm5TTzgrdVNtK2czSkh5OUhERTd4cXdadk5Qc0QzM210?=
 =?utf-8?B?SDQrRDlpMHN2QW9ZUkdKTjlsbWh0K3ZWdDdhSzg2RkVvQVY3NVdKZ3NERXNi?=
 =?utf-8?B?azRnaWVTcUg0S1FlM0ROMDEyTzdHb1MxSnJrL2NjYnJUb2JLM2VhcWpnUy9O?=
 =?utf-8?B?VUFJRm1xb1JndHBxRy9ER2pmN01teDE3NnBVZzI5TGN6ZzJ6bmVzcEpORlhw?=
 =?utf-8?B?UFl2d0w1WU1YdWM5VVl3U3dCZ0RHa1RTYzJ1OWZPd3ZjbVRHcGw1V00rYlE2?=
 =?utf-8?B?TmlNZEhwc215Q0g1aDhrWFFac2VJVkdiekZQL0g1dGk5ZCtZK205d3piUllW?=
 =?utf-8?B?KzJac1o3Ui80R0FLdGx5anNNTUFTUDRvcjg4cFNtckpSMWM5Z281VGxSVTht?=
 =?utf-8?B?QkhoZFhmVlE5V0kvTTE4SW9OMmVjRm5tTDZWTFFMRzA1bHdtemRMbmFlZEF3?=
 =?utf-8?B?NlRuOXpNSit6TlU0QkJOa1pkd3F0OUJDdG40ZU16S0tvdGFwVE9VdkdmMHBk?=
 =?utf-8?B?Z0Z2a2ZDa3BwSGE0c09pdjNyS0paY1hVWWZWbmw1NCtwenptQ3FORWN4Uzcx?=
 =?utf-8?B?SGd4bW4rdFQ0SVFVY0ltanFYQXFsZEEwVVJsTWl1M09TMXFQTkJza2dzMFZ4?=
 =?utf-8?B?bHNyeXNZa3dTQ3cwMVdObzVzRzNHME5kT0RUZURFQTI1bnoyVWY4ajRRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7164.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0E2NmZQMVVPa21kWGx1WkFKUGdMV09iU1FZdnBWeUJnMWI4SHNnOGJkK1pX?=
 =?utf-8?B?U0hTYWhPRTR6eTNpRDNzdUpUVTdXRSsxYTlObkZJOEhvdE9xYVJLK1JLN3Jk?=
 =?utf-8?B?cHhaWk9iRXZpMkkweWtMdklCT2xMWDI5TkVITUxLTXBmQ3U5b0szb05UZnh2?=
 =?utf-8?B?V216N0FoOTErUWMyY0htWHU1dlFNcGQ3UDIzdld0ZVBOQmZLajFhZ3VWSU9X?=
 =?utf-8?B?V244RHUrQXZQdmVFQ2RSOTcvaUZKZHZ3azlMQVN0T3V2eVRMcStpYm9KcFh5?=
 =?utf-8?B?OHk0UXoydnRHcExFWkc5OW81NkhPanZ5ZllJVFNMVWNacGJZQllaSVJONUVq?=
 =?utf-8?B?OXR1d1RGajFscU5uZ0JCM2Vqak50RzdRREV4clF1K2VGVk0vMjRqMm85NnFB?=
 =?utf-8?B?UXliYk9SUW5sek9zVnZnbFAxTWZUQk5iSFZDUnZKa0ZPN0drOHZZSXdyVFQz?=
 =?utf-8?B?R3FpekZSWTl6M0d4dEJHQlVueDJCTmVoT3Q4SDdMcnJTOHViSWNqcTFTeWpY?=
 =?utf-8?B?UGhzSC9hRG1WRkdwSzhBbkZuM1ZSd0xsRHoxejZQdWtJWkxEc2VkZVpmN3E2?=
 =?utf-8?B?WDNoK1o5b1pHYmtwcEdVYzZJNTJiYWhSakVjTmRKeVlCYTZab3ExQWh3Zko5?=
 =?utf-8?B?K3Z1Z0lEb2NQYlVLUzMrTEJZME8weG9jbVRVZmtZeG13ZnZRYXBhR3Z6Szlw?=
 =?utf-8?B?WUcwSEpzUXB1K2xaQ25ETDJtYk1rQVMzQ1llL2tGVXZLdWl6eS9wcVhYT1Fp?=
 =?utf-8?B?amZ1M1J3dTY0dTRKdmczcEtIMjhZcytlSDZjdjJyZ2ppNTlkVmZ4andYUEdK?=
 =?utf-8?B?dVJEV3BkN3BsYUNtOFFHYjJPeDNndzVLV0tFUHpoMHVKYWZBRnYwVkxUZXE0?=
 =?utf-8?B?Mk9JUjRsTkx3TDg5ZzBya0IyMmkyMVZqRlhzdjFiUXlOWWxSVEtlRk1Ha3pP?=
 =?utf-8?B?SjRJYVdWWE9xaEZucU44dkM2QzVpMWdWUytVOHBsUGh6U04xTHZ0YlpYblJn?=
 =?utf-8?B?aTVPSDhPOFJpY2FaYVF3U2JSZk5DR0hwVGNWQXozOWxOZ1dFQUtJaUE1LzJC?=
 =?utf-8?B?WEgwMGZYalZhWmc2L3BQbkhIU25zYkRtM1kvSWNkazdqRW4zR2tENW42RVdM?=
 =?utf-8?B?YXJQeThrZG9RZFlCZ0RLbUFXV1ZzRVJXanlhaTNseFhrYWZJYU4vbDhKUzVP?=
 =?utf-8?B?bytMQzE5SVN4aGZhZlArYTJPSXNLakx0RGdTWXZ1eGpQWXJJb1NSRHVkUkJo?=
 =?utf-8?B?TE1NVjdkOGJ1b3orcFZ5SVo2NERBVCt3RHRnMVUrdGV5MW5KNVViUTZ0NFpm?=
 =?utf-8?B?ZUkrbEcvNVNES21VelhZN2xMSGxHeXJYbHhTWlRtQ011RHFVaDJCVUh2VDNU?=
 =?utf-8?B?QmxXV1BVM3YvNFQ2bHVHM1ZJTGxkcWhtY0F4MVNuWUZENUhFZVZ3R2NpNzBJ?=
 =?utf-8?B?clAwMklpRDZsQmxlcXRCZnNPNE1yakZiL1BBR3dUcUhjOVJTYnVJejJORlhB?=
 =?utf-8?B?YTZTM1didFhlamNmZHBPeXh5bmI2R1dEM3NvaFcwTjNlWEM0MzA3NlBUbjF2?=
 =?utf-8?B?ZmExOWVPRGU5akJPQ0VJV1p0V294WEQzTVdoUVRDWU4vU2RWQzZFM2srNm1Q?=
 =?utf-8?B?WURlRzcrYnBhMjR1aW5tRXNxOStUUUdXeXROSzBPcG9iMUZ1K3hDaE43REpE?=
 =?utf-8?B?RTQ1Z0FtcGsxRm8yZW1YRndLOGNOdUEzN0sxSXpSd2F1b2hkK1BoNk9wWTQx?=
 =?utf-8?B?aHprSCs4TUNUYTR0clhNRnBpTkZ5ZVZtdkw2aXZHVnpqVjdPVGo0aC9MWFAy?=
 =?utf-8?B?MVdwaGpkWGdLRUxpRzZhenNDcVd0bVo1NkJxbHNTZE92M05LbXVqdzg3UlVO?=
 =?utf-8?B?Q1NTWVdmUHZ3dnoxR3pYUTc4dEplTk90bVJYMFl6M0VpSXFzd2kzT2RTaVA0?=
 =?utf-8?B?dU1kNGZSZnhORjRVdWh4Rkd0RldkbldFZVVSZWtZMjExYXBORHh2ekpmVDVC?=
 =?utf-8?B?eldWYVNpYmJqWit3RW1sUnd0NDQwbDhpWDhGRHNYRVMrRHNzRHVEb2JKOUxn?=
 =?utf-8?B?TUlVanVZcVd3TnJFMmtMeUJRd2dNY0JodUtqM0t5RDhQOXZIK3ZzNWNvRnlB?=
 =?utf-8?B?eXJFZ2IxQjZZZFRmUERTSGNqKzVmSGNURTBLYy9EeFRmQVFjMWkySDFSQ3Q3?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a9202d-d91f-4122-cf28-08dc7057a1e9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7164.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 18:41:26.2402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w6mc3xM+Yzdqf6q1xfqb9GLqXs7T3FtKUjo6zV/DoqjgxQTG6rz+vDLuOBKa0yT/WMiZqLhuof1EqYWb1i1dI3nyKc0NBH5/JrDcdJlUE1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4517
X-OriginatorOrg: intel.com

On 5/9/2024 10:36 AM, Dave Hansen wrote:
> 
> I'd probably just do this:
> 
> +	kernel_fpu_begin();
> +	// AMX *MUST* be in the init state for the wrmsr() to work.
> +	// But, the more in the init state, the less state the test
> +	// has to save and restore.  Just zap everything.
> +	restore_fpregs_from_fpstate(&init_fpstate,	
> +				    fpu_user_cfg.max_features);
> +

I assume that this snippet goes to the IFS driver side. Then, we need to 
introduce and export a new wrapper for this. 
restore_fpregs_from_fpstate() and its arguments are not accessible as of 
now.

Also, I think we should encapsulate them. If we follow this style, we 
could have invoked tilerelease() directly from the idle driver, right?

>          wrmsrl(MSR_ACTIVATE_SCAN, params->activate->data);
>          rdmsrl(MSR_SCAN_STATUS, status.data);
> 
> +	kernel_fpu_end();


