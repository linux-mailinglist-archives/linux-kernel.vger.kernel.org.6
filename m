Return-Path: <linux-kernel+bounces-367177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDF899FF82
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67461F25A08
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3272185B4C;
	Wed, 16 Oct 2024 03:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GoQiRUSA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32558184522;
	Wed, 16 Oct 2024 03:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729049390; cv=fail; b=mhhN4g/GY9+jeQR7c4NcAQdTuiAOtlBISwpesr9zQngaR2lLeCe0g/6X4hgKBy1EJdBhF6vwbomExojHjq7ePK/BYoJPSldLOShIjKyjDV+kaTEsLZZzhJ1aAnXey/3S1Spag8o7PWSKH+C2fPDPFhD2HoIDZu4sYHL0smZV1G4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729049390; c=relaxed/simple;
	bh=4HxkkC/fBS4d6XC0daJrM5xTF7NN4w5YL/W8YHJKXJI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dDghwjULpDoz08/zetQuO+A2+BJ1Hog6je7i54NhQE9pMNWS719GR59imgQwdLcbqhq30QbqGU/mfd7kNbVfd08QUBqpuFWpU+hU0QG/rvO8UdEywS45f/vw75eE/u7N9Q78gMqrj7+1Ri3edQFT5Gn4vNUgxYLY98gjHVfaIuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GoQiRUSA; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729049389; x=1760585389;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4HxkkC/fBS4d6XC0daJrM5xTF7NN4w5YL/W8YHJKXJI=;
  b=GoQiRUSAykhlJTReIXOEn5xAA1gG7sqKAreVtsihW27eCK45B/i6AEu9
   81xiEs3bNBqzljognLkD3lHPhoWKAFv6rQQpkWjruf/WHpXX2HOPdo3Ex
   LifHyyYpiqKs1cUXm2XVDASayk7BN44hrppGBF9EICojT5z7YcYiFYX7s
   x4okXIyYqwCh4MDMQXp4HjXVVnOXLIsS0FzWkZrxF7O6pg/yBq1Nf1Bol
   IGz+DDeApN2cQv1tuplyN4PMEocoNdD4PhUKJ1ZnH26maLryzK/OsbL7Z
   z+a7fnDL/cPg2hlqenjlxMuugMQQ/J9MYuB+f7i6axHrjygVY7TDSvLYV
   Q==;
X-CSE-ConnectionGUID: bSs/FgWLT3uK0KsNYx3l6w==
X-CSE-MsgGUID: KEQ31CaoRtudRZCwyoXfng==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28576731"
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="28576731"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 20:29:48 -0700
X-CSE-ConnectionGUID: A+7RJKWOSoinwFK8GEoCgw==
X-CSE-MsgGUID: J1Pcg3e/RbqnzOrHbck0Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="78162474"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 20:29:47 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 20:29:47 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 20:29:46 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 20:29:46 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 20:29:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MvGtYDPZsU2QbCv7o5Mes92wKOxPWaJixj9kCKzPg3L5XcK+BJbMeH+jKbnp1yPAqAr8sJJt4bQzsB8y3LqqUEvsxUPaZHIi6L6PCH9eywq7bS+j34P+JDuAPb915774u0uCYBb+d3NZAAPkUxNFr/QuIITKIWkOnc6MHR2mYxjs445gdJDUOQhAFo9slQ4o2BPfGtndPGTt3lAFuZJj4hr6K+yM13riCWH6mr7yWopamu621bftf+pYV37QreHYO6NW8JC68rXw3d5L1b1bBPHOcA8LuTcqMmrGV5MpWADTHCUFf28qhudbsDLox/ezLWyrcp8j1Lpc7E4+zsPupA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/AygAxIo6+j/N01F5Au4Bdbvg+WBY4RICfSMK/CXzg=;
 b=tw3EzKAvto2XNNx+xhhiPPJdlUNRZXXwBYYMBZt+h3NZebdtMrEMNBpwNxhAVnXYsApXv229C3D6Zv4jDn4BGlfFwxkdyF8BmH62yjk5R5xh3ZL7zf56fnsnhGjqEo+wspMv/f/tnAVcqDzn/i1o88N8G4t/TFfxo+XmhQnADYqIkuyWTm0DVoEpl6fUbb1RpC0Nwf3PB4vCYol4W77LisPWpCKxRoioAx1+fjZRzMt+j9TLaatVTMaBTFJ24ggUEmYDezrtbAAUtDme9xMZ2V80nGjfExeVA3zgTgsryfCyvXpV1pc2Bw3BVq0Aj6iB0uqvhTDEPoDJCaQHYFfEAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM6PR11MB4723.namprd11.prod.outlook.com (2603:10b6:5:2a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 03:29:44 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 03:29:43 +0000
Message-ID: <a74315f3-9250-4e52-823b-dfadf87a6142@intel.com>
Date: Tue, 15 Oct 2024 20:29:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 18/25] x86/resctrl: Add the interface to unassign a MBM
 counter
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
References: <cover.1728495588.git.babu.moger@amd.com>
 <a06e3f9b975bc3743ed8b8df04b6b52229d62bd9.1728495588.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <a06e3f9b975bc3743ed8b8df04b6b52229d62bd9.1728495588.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:303:2b::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM6PR11MB4723:EE_
X-MS-Office365-Filtering-Correlation-Id: c45bbca7-cfb7-4ce2-80c4-08dced92c6e2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTAxZHhYTDBMcW5DelpmSmhWSDROTisrcXFhbkxaaFZVd1RaM2ZweHpRSkgv?=
 =?utf-8?B?STltUXFjUERXZkpYdE1wSEpBallkUEw2NWpGc05ZZUhNSlhseFNIMnRTUUVs?=
 =?utf-8?B?QVUzald2WmI4TWNIM3Z2ckdFeG5qaXBndm15ay8zTFB0TW5HVkRmVWJVN0Jx?=
 =?utf-8?B?N0lXYjRwUG1GOTJ2bXZkM1VqMjJoOC9KeVJaZVJVb0xyQ2pKTVFpZDlkNkR4?=
 =?utf-8?B?d2NUZFUrYU9HL2dRZ3lYcjZldWpQbkkvbzNGQVdWejNsTHdxYUIyejNzTFZH?=
 =?utf-8?B?am42b0g5b0ozcURTdzFVeElRRlhuekdJN0l4Ulc0bW9rOUp3ckFsTmJibkhw?=
 =?utf-8?B?aUorRjBINDZ1aExRSC92Mk9LbFhiL3dOckZLZmVZQzVYRHE1ZGZFUnM4V1l1?=
 =?utf-8?B?cXl1VmtkK3hzdDNTMDEwd2VrVzNqT25VblJORFMrdDBnUEYrQnA0Z0NOSWJC?=
 =?utf-8?B?YXZFbU9GMmhZTzlLcXhpNHVCcXIrMXBNbG8xN1Z4aG5kbkJDZGk5WVE3R05T?=
 =?utf-8?B?a1dQQytzaFFhalhSRFhuMHNFYXR5dWtsaWZDMlN6RWhOYlBYT3JYUzExcFVJ?=
 =?utf-8?B?MTNIV0RGT2daVDRLNy8zenp6MkdYZHJkNVZHZnExVEZYdk1uWXhPamh3WjB3?=
 =?utf-8?B?RlpuRTdTM0JvT3dZS1hCT0MzMW1xUitGVXdZeGdLemZDUW9zRUowNnplWFhZ?=
 =?utf-8?B?RjB2akF3ekVOZ2pHekxqTXJTN0t4NkJkTVFHMFpFWDNDbStnUk8wYlg5M1NW?=
 =?utf-8?B?YXFSaUpWTjEvVkxLVEFkbFdJaHlWSnFCSVJBbDltbW1kcUZXKzRHKzdkV0ZZ?=
 =?utf-8?B?ZVVNbDVXb2hUYkJlZzVielBJNkF0OFpxNVk0eGdIUzJzUUszTHcwaDc0Y1pH?=
 =?utf-8?B?QytwWEZUVDFNTlVlMlpSUGZWSXJkTlJsZkNkS3RCWTg0TzdUWkRQRTJTcGZo?=
 =?utf-8?B?OWY4eDRJaXdjM3l3TFordlVad2ZnelArNEtoOFBreXpmNVhoQnlGbnJ6M1JG?=
 =?utf-8?B?blhDOHV4SWllWGUxTWtKN2xsc2U0cS9uSkgxb2w0RE1DdmtielJnWTJtSFJh?=
 =?utf-8?B?S0t5RlVPVEg0RXRDWlhwNUl5emhyVDZmM3plVno1cWpORGtkbk0xekdKTjFR?=
 =?utf-8?B?cmphMWMzdDJLWVU5TVhJV1IrNWpvNmNvelpiVUtjRUp6Wk1YV1JEVUZVNlV1?=
 =?utf-8?B?VytKT2FDNVZCQ3hmaCt0alpJK1pYeW9aY1VuUG5rUGZUKytZb2k4ZkxhbThF?=
 =?utf-8?B?cW1jNzhURjNQdXc1WGI0QzhZUXNhVnk2emxBUHd6ME9ydWMyNml0bzRNTjdW?=
 =?utf-8?B?alArSUpuOUZjVitMa2hIM3l1UkVJQ085YlluYldiait2dGd4Y3ZqMWdSaWx1?=
 =?utf-8?B?a2NPUWJsTHRpSWRvU3cvVGRhZTl2b3RoWVhyK0JvcyttalNGSXZqb3JVLy8v?=
 =?utf-8?B?aUwyMllFWXhoYU5Tb0tQRkpjOFZPM1dlTkUxdHVlMVYwVDJHN3lKemN1bEI2?=
 =?utf-8?B?azR2UU1uWStSZVZzVWF0S3l1ZHU0R015NUNFSXJSMURibnVhT045REZ3VDFC?=
 =?utf-8?B?NVA4NHlXaWVYOHdLcnZrMElnYkRlSDRBUldWdStJbjFJeEFJQ0NVcWpjK3pV?=
 =?utf-8?B?dm1ST1VzdjdGZUlmUHQvSllZdlF1M1g2Vjh4eFlwR28rRFBTaHBZMFBCZmlq?=
 =?utf-8?B?MDlIZFgybnNpNEFEWWJwRjYrRy9xRWJIaXpVUGV5dm8zZlMzdDd5YjJBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXVObkovYjZ5Q1lUVlRlTnFMSGJyUm0xYktRYm5iZHZkUWZKY3R0RGkvNXo4?=
 =?utf-8?B?cVdZVGp0SjlLaStKNWxUNVVJdjhhWkc3YStzRXJ3akd6OVJNOGdOQU9MbzBH?=
 =?utf-8?B?ZjdxUUtZQUxJdWVSc3IvYWpjQ0V3UnAzNEdFTUdDeGZ5SUFWQUlZTVhrS3cr?=
 =?utf-8?B?L0x2bWx0ciswVjhHbVdYZ2crNWgrV1c3MUx6TEJoT3VncXpaQ1FIbjk2dVF0?=
 =?utf-8?B?SlEyOWVub2JrV3NNSHV0VmM3QmorY2NHZUZOVndEbGw5WFpTVVpQTEowSTNM?=
 =?utf-8?B?UW5nUGdYR2UrRWtnREFNbHR5VjVRc0NnM2YxVTJFWE9mYVd1bHpUd3B2YWw3?=
 =?utf-8?B?WHlhOHVMNWNIb3NjRGorRXEvb3pGdWtrMVhNRWNaZzU0RUVXdkxYQTVTY1Zv?=
 =?utf-8?B?OTVxMUJ2UEZEdGZjRDRRUEZCWjMzdmlBa3hyVGpCeG1Mc1N3ZWsrV3pXUklG?=
 =?utf-8?B?eDh6bzlmMXpiOVAwV1daS1hjZ0ZvRE9HOXV4TzNGZ0lnWG82NHdPVWdCNDVG?=
 =?utf-8?B?WTVmNVhmOU0yK1VrVWdKRFRTTEFQbldyeXhSOE1EWko2b29mZXZXSUY5MDhW?=
 =?utf-8?B?em9YUmVUeVQyUFFzeHNJak9jbTBxSDFCMGZwZ3ZTQk12VXhaU2hRSFZLUEs5?=
 =?utf-8?B?WXBENC8vZ0FkamFRa2k2RVlHMjhGbjIycTh6ejIyeHg2TDZPV0VNT1N3dGVl?=
 =?utf-8?B?QVpNaGxQK0dIaFUrYUEyRTRCay9iMStCUEZNZnlLcEdGb3lSUXl5Q1g4OEwr?=
 =?utf-8?B?aDB3Z0dxZWhzaFdSNUVnNkVLNE9YaDRrbFdLa01BSHorWDJZT1hIaG55aHBI?=
 =?utf-8?B?R1lVa1F6Q0lkM3JtaFppeHBqa2twSE90VG5aN0tERUtPYStmZmNKcGM0WUJq?=
 =?utf-8?B?ZnJmRytFNFZJeVRRRXhLK3VERWZSb3JLTDZobS9JYWl6aXRTUGQwTGRTSFVL?=
 =?utf-8?B?NmNzSnA5a01jdE55VkZrMWU5VFRLZVRMQ3FwMjFvYldFcWJaMmZqV290bncw?=
 =?utf-8?B?ak10UG8vZ2JSR1QrOXMydVJDNitRNzFWb3RUTDc0aWhHTUY5ckxHSXZvdk13?=
 =?utf-8?B?ZlBEWE1ES240c0wzdHczak9zMHB2bzJBaEtQZUZkUmxQS1pmT1R4TlkvRUJS?=
 =?utf-8?B?QmlBUmEvVXdXUWU1QzZ6bXdIVkNJcGRBZUQzZUtjczlhMFhzV2YwdjFmTFVi?=
 =?utf-8?B?ZjFTNzJqUVhUQWxScUUzYW5Vd3ExOVNJdkhxVUJqcGtkd1VNTytqRE05K3Jq?=
 =?utf-8?B?TElpVmVJKzVBNFJjWkVBOGFFTlBMZFFWaE5pM0Z6YUVKeTVkRFYrMTA0RHhJ?=
 =?utf-8?B?M2JZTjkzY1NsZ01naWp2Umg1MTZGS2ZWQVpqQWxlYUtzd29CY1pTUTRXUStp?=
 =?utf-8?B?a001ckV6RFlLTEpCTUxLbFR4NUp4NFVvVW9teFpZYlFwK1FEUjc4T0hJMmRD?=
 =?utf-8?B?UTU5MlpSeFFHaDM3bFQ5WEFQbEUyMGtQeFM1eGJIZXBYMWRkU0xGcEJEU1E1?=
 =?utf-8?B?cnY1OXhrL01uWDFZRWppVnJBVDJRb09TY0srT2RvR0VSN1VQdE5uSHAxeTZ2?=
 =?utf-8?B?WmRkNEhNS3czMk5UUEE4S0hXODRmQlV5dC85MU5WY093eFVtbjZyd0VPSEFZ?=
 =?utf-8?B?RS9uZ040MVlOazRhTk9OSnZaV09XTlo1djhkaTFETWJNV1VzTWNsRHRwWUhE?=
 =?utf-8?B?ZzRSU1VFaFJscnpibzNaOERtN2VydmRUMXo1SDQwUFJaQ3lEWmZSTU1iN3dS?=
 =?utf-8?B?bDZxRHlDRFk1WFhxcHFKR3ozVE5IaGxoelo3WE9vaGN1cmdnUUthSzQ4RmtR?=
 =?utf-8?B?SVZnMUFzM21ZaTFUZ0JRcW9NQjlZN1l2eTBrNzRlb3hDM1ovdm90b3JBVmRX?=
 =?utf-8?B?WnRCRXEyZldVRzlmTFB4MUdNd2R2SFRwaXpnRm1LU0hTZEhPaTJ0Q0ljSWx6?=
 =?utf-8?B?Mi9iankyOHAyWE9PVDQrL1RmYzJ0TVIrOWVVaURZbGExUjM2NWpLeXhzODFy?=
 =?utf-8?B?dldVS1lKQ0hWaWZRb0hoYVhwMUljNGRzUU1KOEtYeituODhqVmhnK1NWcmN0?=
 =?utf-8?B?eXU5WmRmT1RPL3BYa1JYcnArakprN2JhMHRzRVd3NFo0ZnpmMlYrNmdjVHh6?=
 =?utf-8?B?MWRnNHBLTXFpeWhteEgzQTMyTElTaHNsaW4rZDIxNU1pTHZpNGp2S1RwSzEv?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c45bbca7-cfb7-4ce2-80c4-08dced92c6e2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 03:29:43.8610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wGynl4mXrn6oNBRO2SjrgwRb20oqLMAwZwnLC0pAVvx6nd7qwSTlP3+HP3F14ojsKcvO3yo8Vvt9w3iZhE03NN44HgTiVzEnnAsvadrHP9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4723
X-OriginatorOrg: intel.com

Hi Babu,

On 10/9/24 10:39 AM, Babu Moger wrote:
> The mbm_cntr_assign mode provides a limited number of hardware counters
> that can be assigned to an RMID-event pair to monitor bandwidth while
> assigned. If all counters are in use, the kernel will show an error
> message: "Out of MBM assignable counters" when a new assignment is
> requested. To make space for a new assignment, users must unassign an
> already assigned counter.
> 
> Introduce an interface that allows for the unassignment of counter IDs
> from both the group and the domain. Additionally, ensure that the global
> counter is released if it is no longer assigned to any domains.

Needs imperative tone ... "Release the global counter ..."

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
...

> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |  2 +
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 56 ++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 900e18aea2c4..6f388d20fb22 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -717,6 +717,8 @@ int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>  			     u32 cntr_id, bool assign);
>  int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>  			       struct rdt_mon_domain *d, enum resctrl_event_id evtid);
> +int rdtgroup_unassign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
> +				 struct rdt_mon_domain *d, enum resctrl_event_id evtid);
>  void rdt_staged_configs_clear(void);
>  bool closid_allocated(unsigned int closid);
>  int resctrl_find_cleanest_closid(void);
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index e4f628e6fe65..791258adcbda 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1945,6 +1945,62 @@ int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>  	return ret;
>  }
>  
> +static bool mbm_cntr_assigned_to_domain(struct rdt_resource *r, u32 cntr_id)
> +{
> +	struct rdt_mon_domain *d;
> +
> +	list_for_each_entry(d, &r->mon_domains, hdr.list)
> +		if (test_bit(cntr_id, d->mbm_cntr_map))
> +			return 1;
> +
> +	return 0;
> +}
> +
> +/*
> + * Unassign a hardware counter from the domain and the group.

Not sure ... maybe "Unassign a hardware counter associated with @evtid from
the domain and the group."?

> + * Counter will be unassigned in all the domains if rdt_mon_domain is NULL

Please use imperative tone: "Unassign the counter from all the domains ...."

> + * else the counter will be assigned to specific domain.

copy&paste error?
"assigned to specific domain" -> "unassign from specific domain"?

> + * Global counter will be freed once it is unassigned from all the domains.

Needs imperative tone.

> + */
> +int rdtgroup_unassign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
> +				 struct rdt_mon_domain *d, enum resctrl_event_id evtid)
> +{
> +	int index = MBM_EVENT_ARRAY_INDEX(evtid);
> +	int cntr_id = rdtgrp->mon.cntr_id[index];
> +	int ret;
> +
> +	/* Return early if the counter is unassigned already */
> +	if (cntr_id == MON_CNTR_UNSET)
> +		return 0;
> +
> +	if (!d) {
> +		list_for_each_entry(d, &r->mon_domains, hdr.list) {
> +			ret = resctrl_arch_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
> +						       rdtgrp->closid, cntr_id, false);
> +			if (ret)
> +				goto out_done_unassign;
> +
> +			clear_bit(cntr_id, d->mbm_cntr_map);
> +		}
> +	} else {
> +		ret = resctrl_arch_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
> +					       rdtgrp->closid, cntr_id, false);
> +		if (ret)
> +			goto out_done_unassign;
> +
> +		clear_bit(cntr_id, d->mbm_cntr_map);

Please see comment to previous patch about the duplicate snippets. Snippets can be
replaced with single function that also resets architectural state.

> +	}
> +
> +	/* Update the counter bitmap */

What is the update?

> +	if (!mbm_cntr_assigned_to_domain(r, cntr_id)) {
> +		mbm_cntr_free(r, cntr_id);
> +		rdtgrp->mon.cntr_id[index] = MON_CNTR_UNSET;
> +	}
> +
> +out_done_unassign:
> +	return ret;
> +}
> +
>  /* rdtgroup information files for one cache resource. */
>  static struct rftype res_common_files[] = {
>  	{


Reinette

