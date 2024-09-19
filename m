Return-Path: <linux-kernel+bounces-333723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DD697CCEE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 19:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2C111F22CEC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6C61A0B1D;
	Thu, 19 Sep 2024 17:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pnx4ahzz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD44719D083;
	Thu, 19 Sep 2024 17:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726766006; cv=fail; b=Hk5n8gDGb6UYbEOX8GlE7RH+WiXS+7jhgsLZwJNPx9O1QyjqIvheFXODYbTG73gxIgC0Vc16eh8TONslXcHycQBHmzFUHo3bNT4caSLF0FMujkiRizIc/pG7MIX5ajebwVzbDOkS/nTkCvYbRqLte5VCg0x25x4IaFsU5RH2USI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726766006; c=relaxed/simple;
	bh=IfpbkhP7IZn0Xlj9/ae9TjdcZgHp4a0Zko//q9tTLV4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jr2b1pg+BKX991o1SKF90adbf30SKMI0SKqCFI+mWWPBoXuw5DpGZ3GgL4rYMXW1O58EPsm6Br5k4NnD/Q+Kco3iU35QTFBIMQMiTXK5ei7OfhJ7JUyMwOBqC/martshvwvS9JoJxjgk10v0P3R72Cx5QmiCON9Scp7WL1A+KoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pnx4ahzz; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726766004; x=1758302004;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IfpbkhP7IZn0Xlj9/ae9TjdcZgHp4a0Zko//q9tTLV4=;
  b=Pnx4ahzzM8pHjP+TP8TqOi6EJswIWhJ+uy/dV2xAtNzgwrKar99C3qXU
   Vjh7cKTmPJMHfXumIAZlfLEPBrau8ORrGEPNJHCgCJDpnzIIam8PYTgJq
   /MEKUsxTR+6FF9mhUdGE73MIRcH2tv0ymmrs3pdvDxpdtC65KTJJ10mym
   zjVcmoTUSCK2DIg1PgX4rges77lhTikJcsTDavoLfZxujJslYwtDtPZH/
   D6TSIJMqAQb4V3PB4sJcGPYco8FPfODhxFntdP1Ygzzi2UL0RDUwLvH9V
   uDVmkUWzWfRbdQPa36zeScrWjwKrjJQRXdXYAEpPBpJyfAO/PkFTIqVGe
   A==;
X-CSE-ConnectionGUID: QRXB4ANYSiaPgfqk9fxmow==
X-CSE-MsgGUID: 9nQheo4ISR6+gInj5jebAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="29534282"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="29534282"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 10:13:24 -0700
X-CSE-ConnectionGUID: 69P0oLe2Sq6MLriYj7p8KA==
X-CSE-MsgGUID: yRlMWRi4TgWL1jDDc9e3/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="107480350"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 10:13:24 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 10:13:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 10:13:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 10:13:23 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 10:13:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RPU1Og93oG2y8lWlLNH7ZFQ4I4yUCjsGSlTbbM3jhKxqgRoLpfpj5OsnrOV+3VOoLW1oDv+aO5xPfXNutwEr4grkk/i8GgwfqO1DY1eETvbXl4tjfA8lcdSeAKFagHz4S3us+1Jsb6X7QEzKxK8b/0w9rF5AkQb1VP0rv5m0V4taQX0ufgzVPO47JZvJsn6ApxP041vJjZtEXJvkozgpgqHlBKWn9LAxGeXf93PcCy0cCmKh+GmEnI8fEz4e5D6/vUlRLg0YdD+4LlWeJRjYmyshcHidqBCLToCyf7qdnqOxH6vAiNcG1Y0akynmBeZWJZLge/KrQUb2Dn/VUAEKbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cU9dxwUxmyZoGu7D56ZWz8vkXs+Yf/fTIMMRhJ1ZKM=;
 b=fN+6Epg9kXcaJVyB6OqcWrvBaXo+9CHx7rwvgF6Hh5UOkD4COOFRryAX/5PHiunzVXSw8AbQSXxVAhzKa9XR0Iim+hwRg7EObiLUbsLuHw5SFrMX1wAmDVKZbZMEbLeCT+RzJwuGDU44EsMa7mlS173l4XlTs/I4r1ti8K3PLRVn5kZqLDvnf8zm8SWWKc1852hrfMA+G2GlT+fUVQugq3Wi0/am3Dkjm4yLxDDdWULo8sr/iuwHd37MtpttmXDgJ0TG0q0pST7a9gZ8RSVtuqhWSPjuMjpA3DG88veORg7stJcUNBw7xHWRqOSv5U+4WY9FsIYzRcERgwRdyR3xig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB7749.namprd11.prod.outlook.com (2603:10b6:208:442::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Thu, 19 Sep
 2024 17:13:19 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 17:13:19 +0000
Message-ID: <710c3d2c-ef18-4534-982c-a62761a09f96@intel.com>
Date: Thu, 19 Sep 2024 10:13:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 15/24] x86/resctrl: Implement resctrl_arch_assign_cntr
 to assign a counter with ABMC
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
 <2796f9514d9763d40dffbbfe651541d28bd4d995.1725488488.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <2796f9514d9763d40dffbbfe651541d28bd4d995.1725488488.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0022.namprd21.prod.outlook.com
 (2603:10b6:302:1::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: bb6ec9bd-3e3c-4a92-7266-08dcd8ce5bc1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ak05Z2txL2ljQitlT25lZUdGZ29MbDJ3Y3EycUlQZ0hvR2RLV3Q4RFI4aXdo?=
 =?utf-8?B?akJXRGpJdzJwdHh2cDVTQzQ4R3BLTDJwWTFoMWNIWHNJSWFJRm9NdUV2SUh4?=
 =?utf-8?B?SjU1ZjNlU0RmNCtMV3l2TmhlTkJGSXFmT2tENXlZTFMyUWx1dG4wOW4xWHBT?=
 =?utf-8?B?dFJyZEF0TXdjSGRYT0NmQ3lzSW80K3JobUhzQkxCSVMzbWRTdEtSWXBJNkRv?=
 =?utf-8?B?Z2JoUTN4QWVTdlFTWDBYcVRrSEMydTVFeUNHS2hDbkZOVUNnRjJiNFJJWHVL?=
 =?utf-8?B?SUo0UmtxcUUrc0M3ZC9UdC9ZT1cyRG9CRnorRVpaV25nUitTeFZUSml1UFhF?=
 =?utf-8?B?MXBrOVh6MXFHU3Rrb2NnT3BLb0Nma3ZkOFdwWnBqbG5uVVhHNkdmdFNwd1Bh?=
 =?utf-8?B?ZHBWVlZBWTNpVnIySEgvdG1jejJ1MnFRWDVzQ1ovME05YjV1RE96cEVnMHlC?=
 =?utf-8?B?VmN2M0M5cnFaZXlhMjhOUFdSMWcxMGU3RjRJOVFZYnp4QUlTa0RMVXVvcUdR?=
 =?utf-8?B?bEtzM1BZYW40ajFoRGQ3NTNNVWRIcVBNK2QxdjJmbnBCRFhYRE9NUm51U05h?=
 =?utf-8?B?VWQyanluNVlKdEt4c0ozbk9TaXNEdkNPbUQ1ZVlDOHhzYVlFc2YzK0U1UlVw?=
 =?utf-8?B?NnFSMXBqVXA1bnpWa2dFR3BWalVYOCtSVTVyVlNFRTlOV3Rnd1p0cHpVQVV4?=
 =?utf-8?B?WXcxaWxYdXg3azV1YkRhMzhOUU8reWdNS0NDa21YUEVpNCtLU2t6cWRXYVZp?=
 =?utf-8?B?elVDNFJ6QWx4V05KVmViZXM0V3FNcWVSaHlVOThWY1V2TnRla291RUxuS21M?=
 =?utf-8?B?WUYySHgrcWFEdVRKY2hpaVR4QWNvZEJMZ1ZBTG1sTFc2VkpZL0h4cUxnVEJD?=
 =?utf-8?B?aWFPTHRhZTFPeXdMajZEOXBRUVZJNkRlYjRGMkRwQUczSGpLaWlrcUIvNUlM?=
 =?utf-8?B?a2dqSktXbW9yWWM1Z0FKOHA3QkF2UjdJMjJQUWo1OGRsdDgxeDhWUm1HVWlZ?=
 =?utf-8?B?dWxEK09OYnVaZ2w3bUMzcUFsT010SnplRzVuRXRWOC92NzRXWEhnTm9wRlQz?=
 =?utf-8?B?RTNpNnZlM092S0JDaW1WR2xPenpWNUlWRHRZV0tJYW56eEltckhLbVIyTERj?=
 =?utf-8?B?MzVQa0R5VGl1VEJhZE03MS94WXZ1aVJOeDVoNzYzNzd3VGQvWm5SYUM2bFRB?=
 =?utf-8?B?S1FYdENVVUhjelVDVFl0YVZRUlYvKzkrQ3lidDlEbGhYK2Z2Vm5ZendzSGs1?=
 =?utf-8?B?QWNDYnI4aitEc1NDMDZnY0hBU1U3TEhXUXpnNDJNUVpxL3l3MzRBcUJRS2RV?=
 =?utf-8?B?L3RQOS90bnNCdnBETk12b2xwS1pvK0hzUmFrZmd5Q1NWNmZRNGhjUGo5NHRU?=
 =?utf-8?B?d0x2bmlTTDNqQkl5ZllTVXFDNEx4c1BZelI3YXJxMVZGUFpEbG54UlIyZVJs?=
 =?utf-8?B?UDYrRzhlNHpNbG4reEJhZHFwMXEvdnliRFJGVTVQSVVOSWtlOVRsTEZwUGtS?=
 =?utf-8?B?ZlRsZ0lQcGU3YnZCWk51NFRhamF2a2U2MjVSU09MY1EzVzdYOTA5RXRWRmF0?=
 =?utf-8?B?RmlIVmVQNGw2aStGaXhSVFFTVnJGR2VRK00wU1UvSlo0SEY0ZHdCOWxyajRX?=
 =?utf-8?B?WVAzZTRYK3dJb3BoSnc0b291OGFKZWxHSHc4RWhzSEdYZ2YwS3VNUXpjbkwz?=
 =?utf-8?B?MGlON0l4c2NHNExjOXJBbjhmN1ZBbFZKWi85cTN1R1BRZzM2TytrTHAwWkVl?=
 =?utf-8?B?MXRDU0ZuSHRWMER2aDhlNFdadTY5WXRmMUV0aTArVTV3YjhUQnFuelZ0T0Nv?=
 =?utf-8?B?bXZHcms3Mm9PTVQ0OWZLZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekJjcUNENENkY1VGd0FDNzNnSEIvcm1JTGszOXVpQloxZEthN1ZSM2oyRExy?=
 =?utf-8?B?R3Z0eUx2RkR3eUhMNGRYeDNHeWk2OEdlN0VKeGVRUXh6aFNDcVlCenV2V1dp?=
 =?utf-8?B?SGdhaTdjK2FvTHdZcEwzS1g1REFsRWJTUVlHSWowVHp0bENwZm9FTVBobjZ2?=
 =?utf-8?B?c1dORnQ5bS9hdlpaMVgxNW55S0gvWDJ1RitiZjdPS1NHdDNwUDZWWStvOVR1?=
 =?utf-8?B?L2dwUGJhdjd5SGpwaGJuT3VFMDIxck5Pc2Q2cDZZczZOVTVnOU0rZThrdG8z?=
 =?utf-8?B?UWpLV1d4MGRpK3B1cThTNERta2VCN093UGcraTUybTZGUUFyN25qNlRYOFlr?=
 =?utf-8?B?Ky9aZkoxZTZwUlBOMkFXbXI2dWJrQTExM0JDbWJha01vSHdieTNUMFRWYTNB?=
 =?utf-8?B?SFNSN2VhMjVDL0JwV3JTMmtoQ1haN2dwaGpkS0RBcFBqUDdvdzVqTFRLT2hh?=
 =?utf-8?B?NytMK05BMUJSSDQ0eWprK0t6Zi96K0tWSDlJT0JuTG1MMG9KOGZVamd1dzh2?=
 =?utf-8?B?OTl5L3p5Mko4NzZ4YXFmc0luUXIrVllTVG5pczBaVFY1UUhQTk5nb2h4ZGRX?=
 =?utf-8?B?Qzg2bnNSd0VYZUJ3QVpiOHJuMVBoTEY4UDhhK3RROVZZcnc3akNRT2FRT1ox?=
 =?utf-8?B?SnlvSHFObEw1TzI0NzVYRk1SYW1jL3hLYTlGbWlIeDFGQ0NqSUYwUnJYeUtF?=
 =?utf-8?B?VzlWOVROb0xOM2F0bFZBd2NqOTQ1cFErckpOS1pKRXV4U0ljWnd3eitFSnp3?=
 =?utf-8?B?OEgraTMzbFFINzVBRlBldS9FUXl0a3hMZG1iREhRMTRlanJZODB5TGNqMXpm?=
 =?utf-8?B?eUNGNTdscTg0NTBSckliWVZoVEdWM0I0TWRBbVNLcHI1S3RmWVV5dThZTUpN?=
 =?utf-8?B?SWJ5M016NmxwZnQyYTFna1hmNVdtNmg5OG5JR1hDREJLaldUQjdZdXI3TTZl?=
 =?utf-8?B?ck9CNEthcWc0SVBCZzFiU29kcUo5eTF4VkJCMWtrNURBRi9sOEVUbnF6ZHRN?=
 =?utf-8?B?bXZ4ZzU2YmR1N0lhYUN0RDhyalRaeU0wTFhnSSt1dVJWT2JkSDkyQTJ3bmtH?=
 =?utf-8?B?d0RsU0praG5BYU9KTjh3dC9MMWJ4RDg4U2NHTzZpSnhQenYweURFUFdqYnNG?=
 =?utf-8?B?VlJUblhwU21xc2doWE1XV0N1RDJFVDB0TkdQL2lIZ2tOUS9HKzl2ODRMMUdl?=
 =?utf-8?B?OU1aSis1QVJwUTA0OXZscDN3VXNCWlRTdUIvcjNpSk85WDFTTEExNUQrdVp3?=
 =?utf-8?B?clQ4Nzc4UU4rLzBLaFNJdC9VT2g0WktaRXhBeEh0Ung4MjZYNHpLRjkzdHhw?=
 =?utf-8?B?bXpnR0ZwRWw2NE9ZdGorMjlWZzN4SWtac2Ntc2puWWovNFZybE5mbHZ4MitM?=
 =?utf-8?B?UGlaanpXbFZQSExvSkxLNFdBWkx4NWRFRnFOdGE4emFab1dWZURNdjZ2S0Qz?=
 =?utf-8?B?aGVveHFON3ppLzh6eklVcUxkdEZ1VHpaNjhLTnU1czlxK3hENnFVQmtYZnF6?=
 =?utf-8?B?Q3hCeWo3MDRxSjdaeVRHTm53VTA4MDVGaCtCQ3ByN2ZHbDBTeXN1ZTIrVEoz?=
 =?utf-8?B?bUVEbGlmdzZuNjV0K1pHajdacUtPOStvaU4rL1dOTWVtK2pEd01OL1NJTFF3?=
 =?utf-8?B?dTVXMHo0Tm1KS3ExbGx5cWlsQ2QwdFQ4b2ZhY0dvdkc2Smw0b2ZzSThRZWdq?=
 =?utf-8?B?UkVteVBqaWN0cndObU9MWDRnVWNtUm80a1VDTU9lRG5ubHdsVDVZTFRkZzJs?=
 =?utf-8?B?YlhMMjZtQThjRFdJS2xNSldOd2xUdEdVREdyTWZWQitVOS83VUVIK3duV2lx?=
 =?utf-8?B?WEIzSHJyQ0IxV1VzMm9NbDRUMjY1ZEw3VUhxaW5nM05oa25qdmlPNkx6T0cx?=
 =?utf-8?B?TXN1Q2V2Rzd3RzBqYnA3eStEWDczSS9xZXUvUDk2b0I3ME9OTGFVTGdUa2d0?=
 =?utf-8?B?dnM0SlVxcFNEUlBFbmpuQ0RZZ2s1bDVRYy9oaEVYYWw4VVlnWFhrQXdLKzdV?=
 =?utf-8?B?ekVmeC9XaVBRL0Yxa2UzQkhkeVhCNUtIb2Nwb1QvTWhkNlJKUFBvNGZKRUll?=
 =?utf-8?B?K083a0J1MFF1L0JXV0N1UXVrTDFNWG15L2srZGNwZ096eW94aEt1eEdvaFVY?=
 =?utf-8?B?VE9YQzMrYUc2bkhFbmM3UzAwdGJoSXAyU2NGVmppQnlJYWl5RmlSV2V6MzA3?=
 =?utf-8?B?U2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6ec9bd-3e3c-4a92-7266-08dcd8ce5bc1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 17:13:19.6009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+ZNTwdvza5+ocqB9Md0a9bbKQNbWmUirMZjwElIHh7mqHmsCGpaJlunL8CC+MnEe5Motq9bygGoTOUmgMXHw0u1T9SQH7Rt+rbq+R9wF/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7749
X-OriginatorOrg: intel.com

Hi Babu,

In subject, please use "()" for a function.

On 9/4/24 3:21 PM, Babu Moger wrote:
> +/*
> + * Send an IPI to the domain to assign the counter to RMID, event pair.
> + */
> +int resctrl_arch_assign_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
> +			     enum resctrl_event_id evtid, u32 rmid, u32 closid,
> +			     u32 cntr_id, bool assign)

Looking ahead this is also called when config of existing assigned counter is
changed. Should this thus perhaps be resctrl_arch_config_cntr()? 

> +{
> +	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
> +	union l3_qos_abmc_cfg abmc_cfg = { 0 };
> +	struct arch_mbm_state *arch_mbm;
> +
> +	abmc_cfg.split.cfg_en = 1;

Just to confirm ... a counter remains "configured" from the hardware side whether it
is assigned from resctrl perspective or not? It seems to me that once a counter is
"unassigned" from resctrl perspective it needs no more context about that
counter, yet it remains configured from hardware side?

Reinette

