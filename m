Return-Path: <linux-kernel+bounces-340761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D03A987788
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFD301C22190
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8A915A85B;
	Thu, 26 Sep 2024 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g2LsPEQM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE67522A
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727368113; cv=fail; b=Q4RalbyNQ3hQYpmAYim99avDY+CAOVNnwx4VWZtAJloa+v64CHxrBIHP1xuRjRmzY4pSsVQVv6EsG+ljloJ87PFuT1sBjuiLG/epM3VR0+Bo+AEIRJSOJ9+NkwMZnrbJBQ1Drtxz8k83XztUQgFGF4vuSOrdRIO94MfFWTHMWzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727368113; c=relaxed/simple;
	bh=Hw5mPXBvHE1V+6yG85+9iTHZEAwUL1X13u2DPczdWmc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k2e9eNW2gz7nzRrCMzpnhpJ1KR5OurdbGgemExyDBRcW4EHcyQrcT2EXz/wuqmnVeblUGbaaGirqXUoQFf/DEyezBHwbj/AOOjXslv6CO01dqG5XCjvGnKVjzXir5HfOMm3icEs2I1Yz3Rna5uCSUMLWZs4TKEPfKqHh+fV3d+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g2LsPEQM; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727368112; x=1758904112;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hw5mPXBvHE1V+6yG85+9iTHZEAwUL1X13u2DPczdWmc=;
  b=g2LsPEQMIp2VfwvTmcFrtvD0oYd+Efe3vZFLzmEqcoYu//uICcqGXDqx
   WS0o5U+E7gQF+QsFWCetkfJFWdQZbfWE/XSoE7Y4Z+W6cxX8yQuj2Ec/a
   AVcyRtZpMsERFBG32Q+7l4mi7R3/Rbiw7lt8Q+qQu+54iejSUCBX4Esdl
   5FWg8C0hVrNLSE+49v7hNMQQOqjHXqdokxRz/N6A/TPK9b8KAcMsyfWsB
   IE6XkB4T+r8j0OJRFOvxvzDSlNetLj0qPWgAfhnRbK3VRGShzyOx94Lmz
   avCrdShn15MSnO4x8Tq+hZYHFlfm4JYBPm6ZEvDPKSP0sNyxnVYIrZFBV
   w==;
X-CSE-ConnectionGUID: bYrravx/QAeEM9KnUfJhMw==
X-CSE-MsgGUID: heniq3hIRtu/j2XGSb8Xag==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="37621873"
X-IronPort-AV: E=Sophos;i="6.11,156,1725346800"; 
   d="scan'208";a="37621873"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 09:28:00 -0700
X-CSE-ConnectionGUID: d4TrCOtMRUy1fRuyVBspzw==
X-CSE-MsgGUID: ajVYwJXpTP21HYotMuZKzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,156,1725346800"; 
   d="scan'208";a="76728708"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2024 09:27:59 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 09:27:59 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 09:27:59 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 09:27:59 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 09:27:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dj7FE6Jkh2L4onggtFSD/bvx0XqF8OeIMbivzDREvd/rY7iucaGVhsYlQbrwCIJKSLcDf+aaKq3NfWQx9HkCML0sx09CSWFAnSCXItpZ/tfPjeWYwscR8aDOI4wA4zxALKTP1NewwdlEq6a3krigtZ47V6rELqHKbu1SL/1MShVUUmNVeoXLvyMVCvZ+pKwSZmpfLC2ahovuz108fJgJanxLrPOPG5ZAoyN3sZbRsNZcCn5pNZ7mc04Jsw7MUBcS2x1kX6p3e1yTLznHi973cNze6sxaKxn7sTc5ELOkC+V6y+3aMB/aVn1X3NuckmmPn+RIMnxrWh4ED5ASyiU2Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bf9PGGEk6+ruJQTX8eqe0V+dey6nqJs+l1fOzd9fK5o=;
 b=ooYIaJKKeHfRQBhhrrRzJaTw/DkM+5ulbJfav6gD0Cse6lOElYnVPpLepzBGcVyOWq3qUhz4DndA7oUd1ikdmcxTaO7usA4aM5ZJxsBVYQ3CVsvGCc2PD+EQFqBs5PDCcJmYj3yB306uUrz0/T5UW39umtU/Q5nsF0MfQgVWTyZF0GBFbjIb+iWC0lEEfSSoMyD5Ca50UlFdNzFoP9xPtedmaTIGIJsfsfFIlgPg2F3s+LhYgBMCvBxxiYoaPsInbm/XEqvq8uJ3atSXXitsSmF4MzNiMTqk00gHDpdEijT546mGDb5huo+myhLe8sAqxSkJBU8kCAxRlSF4irVBnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB6767.namprd11.prod.outlook.com (2603:10b6:a03:47e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 16:27:56 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 16:27:56 +0000
Message-ID: <6324595f-99e6-4eb4-ae40-af1bb765079c@intel.com>
Date: Thu, 26 Sep 2024 09:27:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/resctrl: Avoid overflow in MB settings in
 bw_validate()
To: Martin Kletzander <nert.pinx@gmail.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <8d028c5f6f23e92fb83cbf20599366e896abc5b5.1727167989.git.nert.pinx@gmail.com>
 <a7c80676-0761-4618-ac07-0b53434b1a9b@intel.com>
 <ZvVZoOm7R-dZ4N0_@wheatley.k8r.cz>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <ZvVZoOm7R-dZ4N0_@wheatley.k8r.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0165.namprd03.prod.outlook.com
 (2603:10b6:303:8d::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB6767:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f38aa1-81af-44fc-dc17-08dcde482d59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bG40Qkkrb1JNUXBDMlVtZFUzZk9oWTFZRXIxU3B5NWZjNVE1MEl5Q0ZmWkdh?=
 =?utf-8?B?Nm9oKy85YU9hWG5HR0x5QThDaTBZZ2JmdUdmUHlVanFrWWhlRnVRWGFMNFEz?=
 =?utf-8?B?a2JkdnZMOGtpTFJrazJxQnBISlZlejIycStPY1FXalRBcWNHZllNMVQrbHBQ?=
 =?utf-8?B?N0g1OGtDWHd2dWkxdjVTbnV3cEg1MStPbEJEVWMwRXZGaVNpclEvc3Jzdnpj?=
 =?utf-8?B?bndsS09HOEN2L1FmMUdlTHVldG5SaCs5d0tnMmRxbS92eXgwWnZlQTdUTzlE?=
 =?utf-8?B?L0lqRmJrMmdNOVBFelFGTnRtU0VmM28xd0RsTjZJbTNpeTltb1F6SkZVc2sr?=
 =?utf-8?B?MUlBcVRsR3BjSmtKWEtpSWFoSXR4aEdvTFZRTysyMWgzQ2I2eVdEMyt3cW5H?=
 =?utf-8?B?cXE3SmNLMWFxTUJwOFJrdTVkV2RkZ05LVkdJWlVvTFJscDI2bjVzaDBDZDA3?=
 =?utf-8?B?V1REMlNDc3FqcGJqbElEWDh4aWVzbXpmK2JVQ2NFM3N5RW1zWTBwSVo5MllR?=
 =?utf-8?B?dGltVDd4WVlwQ2gzU3ZHNk9qUkJ6L0hMbnc1YVlNZ3o5Mi9uU3J3ZDlhVkFQ?=
 =?utf-8?B?azZ6N0pxZm5VemlKVlFHQ1NPWEpNUm5GTDBldXZwMUlEckRtZjRiVUVDeTF6?=
 =?utf-8?B?RjRhL3p4K3hyT2JBU0RJN3hXT0lHSDVMTG52NE1zeU9ETld5SHhWM3Y5ZlBi?=
 =?utf-8?B?cUpLb3hyK0lVYVVBN1FZVlVtMVVENHlRN3FtdHppeDcyVUlnaUlJZVVkYmJl?=
 =?utf-8?B?WGZvUXBZSXRrNFMyNm1rSTVUYnhXdFBjM3Q2MjVmbEJPMStZamp4Ti9WZUV0?=
 =?utf-8?B?SlVWdEduekJkTnB0U1BNc0lhcktmaHMwV0xUVmJiUzltR25nUkNlaWdwOHpj?=
 =?utf-8?B?YUVJdFcwZWdKek1UZHMzemR4WDI3VjhLeThaeGlQeDJWMU1XakdmaXVoQlNv?=
 =?utf-8?B?eEZMc0RxMndkRk9ZcWhxdms5Yk12aVY2WThDcHMrZkc0Yk5EZTgrKy8yVnlU?=
 =?utf-8?B?Rm8zbmdtTEVMUE1tZWFsVUxOeXJZdGtCek9ibWwrZE01SFZrNTNTOU9nR2di?=
 =?utf-8?B?M3M0K1crZ1I3MEZqL29tRzBFQ1NwQlpWSCs4Z2lUOWRhMEZsYzZ6MnVZdzF6?=
 =?utf-8?B?Q1cxbUJTc2ZDKzdwR1BVMnZvdW94a3pmak9FckVUckd5djJYbktHOHNQODll?=
 =?utf-8?B?NmVKZ3c2VEd1MUdFV3RzN2NsWXdsZjBMeHZ6ZHBaK05sWDZuM25PY0tBS2tF?=
 =?utf-8?B?MlNLamE1ZGhwQ1M2ZkNteHoxUjlQNXIwa1RlMmtGdllxUUlZalpOY2hYUlB5?=
 =?utf-8?B?eVQzSDRpMUpUOW9veEZOdHJUWGYrR2RUQmpzUmlsR3lCVXUwSXdURnFrSnZq?=
 =?utf-8?B?VHAxYnV4Rlo5alZFZnNQRGpld2hPWW4zZkw2L3lTby9rdnZ5VDdYOWRjc0cw?=
 =?utf-8?B?bHBnQzNXbWFsRm5JYm42N3pma21rRUJZM09yd3FyREJiQnBOYkhXM3V6d09q?=
 =?utf-8?B?ZDlSVjFFenlRb0M5L0NOMkkrdHAraVd3TkNEbDI2dnNTYTNXWlRnUjJ5c3lN?=
 =?utf-8?B?MHlwSTZmNlFsOXJ4RkQ5VzRCZzVqdk1oL2pibFM4eXJpZWRITk9TSEo4OGU2?=
 =?utf-8?B?R2sxRlZwS1hUNWs4Q25pZENJZmZ1a1FqbStjMjlCTnpNVXY2cEFNdm1wVDMv?=
 =?utf-8?B?S214eVN1eHpjTW1TRG55UUpHbDVDMzl5M0ZyZmU3NkRjUTZLZ2xzTEswbEo5?=
 =?utf-8?B?YUVQZGFLWDhybTg5WXVMZHcyYVBGa0g5MWV5bjhQV0NZelZDRi9RSkc1dXRk?=
 =?utf-8?B?UlJlS2lUVm9lMURjOFF4QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHlNMzhnT20wQWY4eGhwSlVmYkFqd055VUhQN1JaQzYwYjM2d1ZzU0hYVWNq?=
 =?utf-8?B?bVBJdVZBS1lTWjBOTS90YlQrTzBGTW82RXhocmdxRkhwdVdRQjhhTEZSOWVL?=
 =?utf-8?B?eTRVajZVVjNJM21Ma0FCbWVyZW5pOEV0Wmk0QTRRQjNQRkJISW1rUXVIcVR4?=
 =?utf-8?B?VmthMGZ4b2xLajROWmwwY0QxeWg1MExZSDZlQ0hMZU10OHlyeGc1N3JTVVRH?=
 =?utf-8?B?UHdVdERWcjN6bzRWeDAveUhYVHdZVDkwRElOc2xUdlhXeWQ1YW0wa3l4TW10?=
 =?utf-8?B?bUxrZ29va21hQWpsVjdXSFRFVHZyUUNtYk8wTnBsenRHdk5GQnhTaUw3aEx0?=
 =?utf-8?B?VFV3Y2ZwWFZSelhhSFczVGF1NVkxalRaRWVsWkdXanNHT2N6SlY0UFlkbDk4?=
 =?utf-8?B?dHZ2TlliL3dXZm5yQ1NwS3VzYVNlK25LSy9PTXFtYlVXRXJYaXFxcGp3WDYx?=
 =?utf-8?B?UStDaEduME9mQVFDUW1WWjAveXAxb2h2aWZUbDQ1bVpHbkdBK3daUExNbzhp?=
 =?utf-8?B?N080WTRCSEdzZi9CVG1Gb3NaZUk4VytuR2dzZ0V2WGUwaytrQnVDRnJVV2ZJ?=
 =?utf-8?B?bG8ybUJhazNXbzhhOXNlalpMamhJUnhYazlXdXh2VmNwTFJTaGpNdlNwSzMx?=
 =?utf-8?B?OGFmUG80MlFGZFZ2V0xqQkJEaGdRNC81R2VtaGVMSExTa3pMMURvYUdmT1cx?=
 =?utf-8?B?emZKZTcyUU96aFlMS21VMWRzNm5UMUowZU5WQU1rcEovRFhzQ2ZkRnAvV1Jw?=
 =?utf-8?B?MTg5eDFveVZSQnhpNDRlMWYrSGw2K3NtU1paekpnNThLWFQ4Q2U5ZThXUmhC?=
 =?utf-8?B?RkpMUm4rZnI0TFNJVnBrcDN1dWJWaGVHT1oxS1RYNFM3Uzl2MVNKWlVQaGZP?=
 =?utf-8?B?OHQrb2JiRFhoTjRlVjUwTWgwRTU4QzR5QzEvNks5OEY4NWRrcFl2NWdWenNq?=
 =?utf-8?B?K2xmQWRSQVRFMklNaHQrMzdIUzlhKzFpdDA1L0VodExjTE9EQW5NYWJ6R0Z5?=
 =?utf-8?B?akdEMDd3TDVxQnJXL0xLSktFWTZZV3MvWTVVM29xdldLRWlCaENaUVFpTHVY?=
 =?utf-8?B?b2dZaDFOcU1aNkhJSFBDSURjU1Y4eUtwZ3VWN2cyRjdDdFBNWnRYVi96UXNn?=
 =?utf-8?B?dlViSGtLcXV5aTd6OTZiVExrK2U3c2c5UEUxVmZibVlmKzVEUlQvNUdDbmRm?=
 =?utf-8?B?ZU9aUFZHYStxbTZJbENjdWdJZitFZFFZbi9zWnZzZnhISTgyMFFoTXdLaDFX?=
 =?utf-8?B?c25WbTEyRWxxOWY0dTgxaHhERG9xVm1GQU4wQ0V3Vkx3T0U4RVcxR2t6MWJC?=
 =?utf-8?B?SkM0U1JvQnhlVCt0UnZXa3Y4KzEySjBpRVkvU2NOMTQ5alJPSDl6cXpwRklH?=
 =?utf-8?B?WFN5ekc3aTV3UWxyaGhsRjhIa005eXpUTzVyeDh3Vmpza0VRcE9OWDZZcExH?=
 =?utf-8?B?aktxK0pjWk1NUFlQK0FSNkoyTU5DRkNyK08vOEFPUFBEQmFTeFZXaUVlUyth?=
 =?utf-8?B?R0U3a05Ibm9pUGtTWFFaa2YxM04xV1JNeFUyR3FRbWdTWDNZSkxpMENMZklx?=
 =?utf-8?B?TFdjcGVEQW5Obmx3QkRUQWN0VWlTR0xTRVFLYkM0RDFycXg1dVcvNFFzdjdp?=
 =?utf-8?B?WXZmOVROY29TaVhpRndLVWFHMkcwYXp4R1MzVmhxV0FWWGo4b1lDRUJkMlc0?=
 =?utf-8?B?TEgxdTE5V0hCVFZqNkw0Ri9aeC9KdUk3S044TDk1RU5ZU3MzMm8vMUNpNm5r?=
 =?utf-8?B?Y21GRG1Ub3pqbWRkdC9lR1J6T2Izb1FsSXBVWTRId2FQNzE0U1ZQdU10WVBU?=
 =?utf-8?B?ZWkyMnVjc3Jhby9WRWtKYk4vdk9pdkJYY1JRMkZrSSszK09nTnFrZHhhUlFJ?=
 =?utf-8?B?RThmdWQrMEVWVVd4VUVZR09MdTRZeFdjUkJaQlpkZ2FIWmxBM0tDYVNHaXlS?=
 =?utf-8?B?UnF3VXNaRVBhQWIzRm5tTU1HdlNHTzMyUEZQaGJ3R0VoSnBzejA5STFYRW5q?=
 =?utf-8?B?YjlXdVVjZDAyS3dFdE05MHJsWFBHbjk0T3RwZWtWNDRZOHo3aHhFejdKWUFq?=
 =?utf-8?B?dDZ2dGIrWHVZRERLalRDT0ZXTktSSnFZR1gyYjdRaUpseHh5WFVza014R2xz?=
 =?utf-8?B?WWROQ1dSdExVZk5BbFVnWUhGcjB1eFpucDZBNUw3aWhENTVmQyt0c0QrYWxH?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f38aa1-81af-44fc-dc17-08dcde482d59
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 16:27:56.0657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWbg4Rw/C3/YXuyWQvYFcmg56z3ZWA3KLjktpFK874jI0myLi2tEZ8TqjLaAjqmh7d49KFJQYJBy3MslOOj4XZXAE99VXtRYXgB2imB/RJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6767
X-OriginatorOrg: intel.com

Hi Martin,

On 9/26/24 5:54 AM, Martin Kletzander wrote:
> On Tue, Sep 24, 2024 at 10:46:10AM -0700, Reinette Chatre wrote:
>> Hi Martin,
>>
>> On 9/24/24 1:53 AM, Martin Kletzander wrote:
>>> The memory bandwidth value was parsed as unsigned long, but later on
>>> rounded up and stored in u32.  That could result in an overflow,
>>> especially if resctrl is mounted with the "mba_MBps" option.
>>>
>>> Switch the variable right to u32 and parse it as such.
>>>
>>> Since the granularity and minimum bandwidth are not used when the
>>> software controller is used (resctrl is mounted with the "mba_MBps"),
>>> skip the rounding up as well and return early from bw_validate().
>>
>> Since this patch will flow via the tip tree the changelog needs
>> to meet the requirements documented in Documentation/process/maintainer-tip.rst
>> Here is an example how the changelog can be when taking into account
>> that context, problem, solution needs to be clearly separated with
>> everything written in imperative mood:
>>
>>     The resctrl schemata file supports specifying memory bandwidth
>>     associated with the Memory Bandwidth Allocation (MBA) feature
>>     via a percentage (this is the default) or bandwidth in MiBps
>>     (when resctrl is mounted with the "mba_MBps" option). The allowed
>>     range for the bandwidth percentage is from
>>     /sys/fs/resctrl/info/MB/min_bandwidth to 100, using a granularity
>>     of /sys/fs/resctrl/info/MB/bandwidth_gran. The supported range for
>>     the MiBps bandwidth is 0 to U32_MAX.
>>
>>     There are two issues with parsing of MiBps memory bandwidth:
>>     * The user provided MiBps is mistakenly round up to the granularity
>>       that is unique to percentage input.
>>     * The user provided MiBps is parsed using unsigned long (thus accepting
>>       values up to ULONG_MAX), and then assigned to u32 that could result in
>>       overflow.
>>
>>     Do not round up the MiBps value and parse user provided bandwidth as
>>     the u32 it is intended to be. Use the appropriate kstrtou32() that
>>     can detect out of range values.
>>
> 
> Great, can I use your commit message then?  I wouldn't be able to write
> it as nicely =)

Sure.

> 
>>
>> This needs "Fixes" tags. Looks like the following are appropriate:
>> Fixes: 8205a078ba78 ("x86/intel_rdt/mba_sc: Add schemata support")
>> Fixes: 6ce1560d35f6 ("x86/resctrl: Switch over to the resctrl mbps_val list")
>>
> 
> It seems to me like this should've been handled in commit 8205a078ba78
> ("x86/intel_rdt/mba_sc: Add schemata support") which added support for
> mba_sc and kept the rounding up of the value while skipping the range
> validation.

Right. That commit additionally suffers from the overflow problem by, after
rounding up the value, assigning the unsigned long result to a u32 (struct
rdt_domain.newctrl).

I added 6ce1560d35f6, not because of the rounding issue, but instead 
of it switching the destination of assignment to struct rdt_domain.mbps_val,
which also happens to be a u32.

I included both commits with the goal to help anybody that may be looking
at backporting this fix.

Reinette

