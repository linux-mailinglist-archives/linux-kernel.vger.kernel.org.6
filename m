Return-Path: <linux-kernel+bounces-514451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B18A3572F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BE593AD6A3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690F42054F0;
	Fri, 14 Feb 2025 06:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q0qDhHle"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0B2204086;
	Fri, 14 Feb 2025 06:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739514901; cv=fail; b=YZnsyez2qGBB4bheAcGWEqexJGNmZad8+b5H9Jt7xGDrxgnfdOCXnM7XxU1gw+gcHRV8OKFi1nv5uzl/CVLAa5WZD1uiwjVhFHg6tAjxKDZCRNjYfZgNF3YCttiACY0kUTSHC5ncs++Uwv1x6FbzVVoKpAcJqbpyyCqTSN8O2h4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739514901; c=relaxed/simple;
	bh=pGLz8ROMyTXcBfONScGRmKu3edvMbpg7hdi0Ua9b78k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZsBn+FMxt0iCiGsT23U3D0E4jdRLq1Pe+MWBT6mjXKXmgo4bHEEbkh5HurI1suuENopM9qBlcqjgH1lj/lZBQ62TvrIQ1w49NxHrvRZyp5/lYx6oB3YetWp4F518BLche7cWPObyfI7EPYLNkZ/JU/Yggp2I7oJkrhVnB38+Tck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q0qDhHle; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739514899; x=1771050899;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pGLz8ROMyTXcBfONScGRmKu3edvMbpg7hdi0Ua9b78k=;
  b=Q0qDhHleLipti3uZcu9wqGn+KnAwFZbJ+qFy9mPEmkPfI+u9rQi64u+C
   jQS01eMoVQ15KQ1SOhSNHaUJ/FhIY7SjWZG9uFgFtMYFzxFisyQU03h3U
   J7fBfQsDadVEbZcKPZAaYY7Vaqs7lPnUtXyAHagXDfHXN91nteQxzcnPx
   3iCn53s34xpgsDH3YncayDc+d//E7QLPmL4KI3u1Kp3gliMx0fo+yHpQC
   DOmQ9yLUPrej+FOPJlNZwL8UcPYMRWzfy/duqoBFnloarYF0zkhiQYw7N
   yaCxRwTgJcAbxKjecDhqxDe44ExQblWwRoNTr43sA2P6OYXgq2t4iIY2H
   Q==;
X-CSE-ConnectionGUID: Zc1vnN65RX+Gn97AaKhyXg==
X-CSE-MsgGUID: wXrJVE9TQ3ykwxwngOvLow==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40286631"
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="40286631"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 22:34:58 -0800
X-CSE-ConnectionGUID: Uil4LmKBRl2RRDkVbXX7WQ==
X-CSE-MsgGUID: CTUqN6d0QpCgfxw4R1MxmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118302397"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2025 22:34:48 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Feb 2025 22:34:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Feb 2025 22:34:47 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 22:34:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QV4WSMh0UY1x1lY4EFMCEqOwWp1vkzBJK94nJnYXWGdvSLbmRaEgjihPFVyW89tBALJPyOy7V7OWKfuuejaflhdj8xWfY7mVlzuVaH1UUhMTjXTsH+CbU4G+jp3Cu97/u1UMGbdOjVsyhXsYcsMojIRVs0rXvO6qR2whsxtY/prFgfLGSkPe4E5aMaK0Syw8sRfTlmJgYE9MO0KgcvICnregcv1LA8BIfD9BAUAxQ9GPzZBp+AJbSctMHOLh64pXlVHnnMSJ4WPcOZMqMAajA0AiJd6sIsAICo9rdAmWsutzc2Y4SQrKTRt7+Mb2kriNVzbEusfwYBFEfVWD+p2usA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mESl0YKexdIQHQ/2kfwHOF+oTP06qhFnMWsTwwdLuRE=;
 b=xe1RD0vdItxC8iUCIKEYPrTB6b3ptSaDCdmmdUEqoRzpcEcJDQ89ao8LT2zGnAD6gCE3psefIkNgmy8f/dEfV/khuj/ZQsUBUhJaaqcxuqLFgxgQMP5wckpN6cVQDr3shM22LfWg8xvcDSOhodfhz4vCwYnCmOctAYQjExCcgUl8M/GCFAeveqRDN9heh6tlgeYrGKlcnfyEJ2iDLYuX+rRNqrBz/r+9UGnb7d9v274a5QuWOxUyTp7b4q+RnbQujBb116Rrlwiq4mzuvbWr6oUzBadX7sqGXJyrKLeboqtUdzVmVd0hd7fpmmZ215fsksxVEBYDnV2/cteguWacWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6066.namprd11.prod.outlook.com (2603:10b6:8:62::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 06:34:41 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8445.015; Fri, 14 Feb 2025
 06:34:41 +0000
Message-ID: <b0380521-75f8-4f88-8dd5-c4746748e628@intel.com>
Date: Thu, 13 Feb 2025 22:34:38 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: "Luck, Tony" <tony.luck@intel.com>, Dave Martin <Dave.Martin@arm.com>,
	"Moger, Babu" <babu.moger@amd.com>
CC: "peternewman@google.com" <peternewman@google.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "tglx@linutronix.de" <tglx@linutronix.de>,
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
 <5e9a5b3e-793c-4873-a1d2-33b62614ec31@amd.com>
 <Z643WdXYARTADSBy@e133380.arm.com>
 <SJ1PR11MB6083759CCE59FF2FE931471EFCFF2@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <SJ1PR11MB6083759CCE59FF2FE931471EFCFF2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0013.namprd06.prod.outlook.com
 (2603:10b6:303:2a::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB6066:EE_
X-MS-Office365-Filtering-Correlation-Id: 123d7e4b-9a34-4c55-e9c2-08dd4cc1a969
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVRyZTNNOHI4QSsrWm1lUysrUDE5emVtTjRPN1AwZytBK3QyeGRLb0lVeDlZ?=
 =?utf-8?B?blpsbzdPMG5WSE0wcXB1cUFVWlhBQ3lFMUoyK241eElkeHEvV2VUS2p1Wnl2?=
 =?utf-8?B?elQ4WjhWb04yZk5iYlNjK29hTmo1bnNia2NnRW9vMmRLdXJCTkZDelFnc2Ry?=
 =?utf-8?B?b2ptOGtBYm9ORmE1aVV3VzhGbHVpUXJ5c3dDSUZHZFlLc1FiNWt6QmprOGts?=
 =?utf-8?B?SEFreEhLK3c1d0UydHB6OG9FVG5CeGlpUzlZdjI3cU9vaVRTVlN2bURjZ0sz?=
 =?utf-8?B?QzdXOTFRUEZ4bTNjTjVxSXU4azNyMlQ3ZGd1T0VQd2wybk9iL1R0T2NmV0h2?=
 =?utf-8?B?VElBcDlwdlA3MmR3N1creTNjUytLNGdJdDFPcXIxdDIwellRa2N6aFAxNi9S?=
 =?utf-8?B?NXRtYTBuZU5OQlhOemw1Z2lNQWpWMEttRkJxdlRmYjA4VDVleXNzUldBaFM1?=
 =?utf-8?B?SG9UbjVlYi9vZGcrdU10cVJyRkdwaGNzMGZIOVVLQWszaUxEalhnU0M0dGVR?=
 =?utf-8?B?a0k5N2hEbW5wbC92dHJ3NlJZaDN5VzBhRHEyb0lESmhXVGQ3aS9ZV0tPRlVw?=
 =?utf-8?B?Sjc1Wm1OUCtSRDBiSHUxdmdoUFFleHUvWkxHZzRkQTdtWDFBTThLd012TnlR?=
 =?utf-8?B?cjBMc2dSYi9DVnFmN2FTS2N0ZjZ5bDlrQVRLb2hVRTh6bm5VaWFTWjRJbFJU?=
 =?utf-8?B?K3RJYzB6T1NIQ0htNkpldC9WcjRBUW5BTDVvMGFGRGRZeTJhT1ZBaGRrTTJS?=
 =?utf-8?B?K0tRSVVXQnJBUTVOeldlRnVuUmpJRnVyd1g0WDlVek9DbWVXVTZOM1FJUHBk?=
 =?utf-8?B?ckttK2NIWDYvOWFodXNKeDVxNUhKK05sQStRNEh3bEl5em52Wm80RWpGeDdx?=
 =?utf-8?B?SG5sanAvcE0wcW1JWWNBZFF1bDhjenJ2QTgvbzNJVFFRRlpVTFJ6SmN1aHg4?=
 =?utf-8?B?UGNuZ2tDMy80OVd5aW5PTEY0L3YwR3lSS2E4a2dKTlBXZjBqczBsK3d2UzV4?=
 =?utf-8?B?WVJsNkNRcG1pbGRydXFlZHdMejJwQVNMYmFUZU1FcGZlbVFseVNGWGZKUmpn?=
 =?utf-8?B?RWlKb2MyR1ovM2prK2dqWGZnZktKWmtobENpWWdiNFJmZUYzK1IrWTB4czJC?=
 =?utf-8?B?K2N3UWgrajU5dndjV2NscnNLTjB3YzVYZXQzQ2UzaWlEUERydWJURTlrL090?=
 =?utf-8?B?a2hqeUpISk9aeURPYzBCejJjK0k1U3AvdlpQWmhtc2ZaNFhkdHdRSWIwYjVw?=
 =?utf-8?B?UXg2MWZJYXRMdnF5NW5PM0gxZHR1dFM5bFl5OUZMMXRDa28yMzhocWVNNUdH?=
 =?utf-8?B?VzBtUy95ZU5DRXlrc1diRExpaWt1TStTY0k4cG8vNjMzUEZma0srQVFnUCta?=
 =?utf-8?B?TmtjWU1pRk8zRzNwaEtqYjN6QnRmdGJJUm92SGNLQ0cyc2ZNNGE5a1JSSDAz?=
 =?utf-8?B?REwvR0VTMlhrbDV6akZuUFRhdjhleGo0Z05rdjR0bTJ3UTB1SFBucmJ0Q2Ir?=
 =?utf-8?B?bVZjZ1RSS0labTVGZDFaMFowaTE4UkpvcmZXWTlvd3FsUGhSaFF4THMxRVh6?=
 =?utf-8?B?OVN5cEFUWFF1OFJRaHhLc3VSeXdiejdWZFZjMzFsdi9jaHZLb3I2VlVHOTdB?=
 =?utf-8?B?WlZvRnExb3FiR0VORGVEUkpsRGFWL0Q2b3FnSDhFWVdNME5TK0xsbFFzaHV2?=
 =?utf-8?B?ajUrZ2tyVkpFMy85anZ1ZG90RXF1MkI0RXo1Smd5YS9vemhLTEh4U1VRNEN0?=
 =?utf-8?B?MjYxT0lxZ0M3RU45aHZuQUlKY3VqV3FESkYzdSs1Vm5Sam5ocWxBSnp5Uy9t?=
 =?utf-8?B?TTlWYi8yQmxtdUc3aG90VDhvTHU3K3VZd0JEK01jZW1OaTc1bEFGRE9SZXhx?=
 =?utf-8?Q?Mfa4DcEeYSB4R?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVpBa2d3OTlLemlhOXBWdmJFWUI1NlJKV2VCYjVONmMzRXF1UXBVQ21iMTBU?=
 =?utf-8?B?S1oyN0dKMlU5dVRmWDBWNk5GdUFmTkkrcVczd3pQU0NqSStTMXVQQ1ZJaWVB?=
 =?utf-8?B?NTRpSHZsaHJ5d3pDaCtkWTJIQUxxbkNMdVFDRURoSnNUc1V4MGthWFRXVFAx?=
 =?utf-8?B?Wi9VelNhZ1JWdEpLZVVoemU5TWxKT0dwUHA3SFc0ZHpldmxaNGNTcDRTMW9i?=
 =?utf-8?B?WWtmWmVSTGJoek1sMHRreTdRcDIyYTI0ZXNhakpJV1I3NjRRUWFhUVhVYkhn?=
 =?utf-8?B?RW50SHRzMzZxa3NLTDA3RWtDR3AxcUhIY0FtZmdUWEd2UUJvR2c3ZmlWaFp4?=
 =?utf-8?B?MU1sbjlaWXI1ZWR3bmhpaW9laXdST1g0K1VyZ3BQYWhvSWpicXkvR1ZOTDcv?=
 =?utf-8?B?M09JaTVKaVdmeFljWHZpR3cxQ3NHYXNjR1ZtbUFlQnJQOFFEVmhFcGlnR1l2?=
 =?utf-8?B?YzAreHdtcDQzUkpsVlYvUXFHd3ZWYjJ5dk1Kd3RHdkJaNndCOE9yWVI2K2t4?=
 =?utf-8?B?bklRbTRycFp0Y1ZmbEp3MU9meHFQblR4cHFBUUFrcnJPMnZqUDFMTEtXUEZW?=
 =?utf-8?B?Uk1CVnM3V3lUcjBmS2pyekllZ1REQkUzNVJERSttZkxLd3VianNxSnBHNE9L?=
 =?utf-8?B?dUZzeHNoN0lhNGdTREM3ZWdhbmRmNElNTVNHZExpNE5Gdm1aWk1HNzJyeEt5?=
 =?utf-8?B?Wlc4SFpTOVRidWdhL1pHWjJ4UzFqb1V5OG84Y2VmM0svQlVuYktjT0FnQ3pj?=
 =?utf-8?B?UURBeURyTTBqR3QyMTZYVGNqWEFIeDkvQmliV0crRzMvaGxNL29QemR6OGgy?=
 =?utf-8?B?VUJJUE5mMkhiSjJ3YVZOc3ljbCtQWGNuNVVPUUhTcWR6bE5uMHZtTmE1Z3Zw?=
 =?utf-8?B?L0dUS1UzckpzT3RQYytkZmhRbDBHSXVLbVB2SjBlQW1rbjdaUXl0eUlzUDhB?=
 =?utf-8?B?QWJGUUJKMTF4UWRaQzc3VitIQUN6Vk9UL01BQkVmc1k4MlBYcC8vc2poZnBn?=
 =?utf-8?B?T0dWRXZJcm1BcXduclVLRnB5THZEQ0FKaXFCOWdMdEpsNGRreUFjTHVCWUN6?=
 =?utf-8?B?bENIMjgrMjhFR1c2bURvNG1pLzV2OUdVck05STVvSzBGYndZbVQ1NlhWeHpG?=
 =?utf-8?B?KzhvSnM5SDJKS3NPeGg3M2NZdHVkMGp5c2NNWnZpdGY2YXRvd0RFd05lOUlF?=
 =?utf-8?B?RkUvSU91bFYraU5LV0t4WGRnYmg4VUhDbDltRzUxSEU2YldPTTBLdDEwaERP?=
 =?utf-8?B?aFRmSStEZVpNNWZkUitweTZMTlBFMkozaGVNRFdJdHVZM3ZuYWQweERTbW5N?=
 =?utf-8?B?ay9TOER4SW1IYzF1enVZR054TXgzVkIzRXZyRVhHWktMNDNUN1c5cjZXcEV4?=
 =?utf-8?B?OHRzNWgxRGZsdm1vclRxR2JIa1NMRjV6TWRnRUhMUHB4MnFzWHgvYTJ5eXA1?=
 =?utf-8?B?K09DUUNqRWNSd2l0eFV0TDVVZ1FBenh3WTFIU3BJNUQzZktkelpldjM5OU9y?=
 =?utf-8?B?OGx6Q3ZDN2ROTndNMHNZUmZxK3RYMzEycUlCSVJqd2piSFNPZWxQY1lMaFR3?=
 =?utf-8?B?ZjBUTXhNVXdBaTFaRHp0dkxMQmNTaDhITUg5QVU4UEF3VXJuZTZaN0tkcEts?=
 =?utf-8?B?UEhIdUwvbFcwMHhrd1ZLczNHTjBWemZvZmgyZVBWbm93YnpjNy9XNHR1VTh2?=
 =?utf-8?B?dC80T3BLSWVRWnFFSitXcGw4VUk1cG5RbzNiZ2ZoVTF4c3EyYWlHZndKMlM4?=
 =?utf-8?B?MXdnVjVDTWF5a1JTRkV5dXRjQmJsVG9TRnZFL1RSS0lrOHArbEo1ZFo3MFRn?=
 =?utf-8?B?VUc3ZXJHTFd6QXJGNmZORUZqbjBrR2MwL2JRaEs3dTIxbkxhb1gwTXVTUmJD?=
 =?utf-8?B?N1R0bzY0R2RKZ1lJblRSMmVMWC85elJBVE0zMmNHNWhPV1pEK3dNS0F3emla?=
 =?utf-8?B?ZEpIZkFEMmpUcGNlODNKbTYwYitITzNsaXhhb0hBMUJJUzRENzBEZ0VVTjhy?=
 =?utf-8?B?UDZ5TFlYV3Qvc1dNTFJJcVhRVHRIczVPem1NRDBSa3c1SUFCR0pobE5WOEpz?=
 =?utf-8?B?MEZmekVDVUttZHdTeWdRMUFNd3prMk1icXFidlRVQ1N2V1IxbHlxY1EySmwr?=
 =?utf-8?B?Sk9tNzAxa0lYNlcxdGxpV1hVZk9nbVM4dHdpZW1tdDk3am1GYmVQaU8vTFpm?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 123d7e4b-9a34-4c55-e9c2-08dd4cc1a969
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 06:34:41.2556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6FYqjbWPM2z4rBzEhNotDzXhkESf4ti1azf5dHUKAFQnVjZ2dXDarb3xtShfGEd/qAqkQTIsh832twiMvhKXncEhufZW/gco7kcKofb8r4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6066
X-OriginatorOrg: intel.com

Hi Tony,

On 2/13/25 10:39 AM, Luck, Tony wrote:
>> Yes, although there is some hard-to-avoid fuzz about the precise
>> meaning of "local" and "total".
> 
> Things are only getting fuzzier with mixed DDR and CXL memory.
> 
>> As Reinette pointed out, there is the also the possibility of adding
>> new named events other than "local" and "total" if we find that some
>> kinds of event don't fit these categories.
> 
> Not just new names, new scopes too. Patches coming later this year
> that would present:
> 
> $ cd sys/fs/resctrl
> $ cat mon_data/mon_PKG_00/llc_stalls
> 779762866739

Thank you for catching this. To support this would not be possible for
the current plan for mbm_assign_control since it does not have a way
to distinguish domain X of the PKG resource from domain X of the L3 resource.
Sounds like we need to include the resource name in the mbm_assign_control
syntax?

Reinette

