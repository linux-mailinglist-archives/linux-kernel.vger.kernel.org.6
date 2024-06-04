Return-Path: <linux-kernel+bounces-199888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D188FA746
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 02:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 456C61F23ADF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 00:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1538BF7;
	Tue,  4 Jun 2024 00:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WFeLU/Hx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD7B8472
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 00:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717462685; cv=fail; b=ZSF8bsm/J6zITJG89Te4oMa31rOGmDk0YOlprTqiyqMp6dfIkunkZpLbDOvUmstxalmlWUwe/24Ql9wl7W9C8j5cFRAQAisfXAEq9TzUdA/t6paxJMEWF1nb7eC17b+wNvSVlaLGuftlxiNic5GrNX8s7HQgwIg88AkHSFrsow4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717462685; c=relaxed/simple;
	bh=blei7m+ISYCcyndSq3bvRrdBjHH4ryYwOO3Ul09khGQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hizQdAUDmTNNH57VVV3rg+evptD1draYAIo4hlL5i850mWQJu8aFsyt/kmFo1bg1OMmlM4aetipjZTtuIpGflrAKtBr0PRHfqo10Z68ib1lPTXTxl1uYFj2+RFs5u3E0f21opS81UIwI0yEQ5z+2m8fQtAR0diiQ9TlqXKUV0pY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WFeLU/Hx; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717462683; x=1748998683;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=blei7m+ISYCcyndSq3bvRrdBjHH4ryYwOO3Ul09khGQ=;
  b=WFeLU/HxnqDVhKo6bijUkKJ3gTzsDnFdv6aEL+hW0t5NySzNxODSjpNQ
   BQmIYb+vrEXP+Z0FvC99EFuZyYM63GIJWgKhbix/pIE7Ee+UchSPIdlu5
   FGMFN1nop3Ln19zZxuH5ZbyykdiT++3ZeVtMcuTEa3QJPXvbtLrYZz5nL
   JbuJ2oH6C82Cqn2xWkjfB1PLsSlcLBPFNbtFZrQPevlD8yQbd3FbNesR7
   Q/8DMjxc3xrVAn2N+gYdkXWSrSoa5mH8LU471qsAWNxLHVaPVe72qTv6x
   FJIrIKmf+mU1yR3x1HoS9v/5TsmB1TJ9Ot3yWYBmHqfnEMI4WJa5fwxpO
   w==;
X-CSE-ConnectionGUID: TOuhOEFkSdCBEcWexKZ6yA==
X-CSE-MsgGUID: bPlPWsBSSiq1aluqMCY8tQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="14170653"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="14170653"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 17:58:03 -0700
X-CSE-ConnectionGUID: 3bEpRYOKR3OxqGHyYAZM+g==
X-CSE-MsgGUID: t/FPV2w2SBeW6cHfHj/vAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="41484425"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jun 2024 17:58:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 17:58:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 17:58:02 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 17:58:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkdkHZ8U26RJy3mMzt9jETs+tOgBXyfrUISGpYu46fNJrOufG+uBVI501ff/eBhSlaePUhi3BFwAzewr3Vmv8kAMKm9BT3vpbZLAcXGtdcGK3rvoKwfoZaL+fp01nIQdmY1tsIVW3BmrbHqyWs4MfXM89NQ/EepZUy9e1dCHuaJ4bf2z2NHNGngzsH/oklFNw7awUtwa/l0tsxKobXiCcom4c/8tdUj29oBMpzEIgNCiPKUUOWMTLkedFv0vR4aIviWaZreluM7M1PzB+KwuzTsrfYEWdREFza7khNaNkej6+9mdeeo4EWgvEr+O5HpvdaxdxEfKZ1PtdvrJqfAqoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1EieKwcwPC7hEuGjVOfTDrYtI1j2ofISqU+tX+wMus=;
 b=Go79Ir0GMgg9elQtByArJEPteGwspXDfvvHJpb8vfRayUX1xEWy39/1A4IOgsr+pE3/ykNtjQB0nFc8xq0YKjf86ril0QKsN+I0dPq47ZXhJ5JL33rJrMd+8ZlWXetBcrVL1CBiU7K+msUhvkSOcVTtFYvDJci7Min244LXkvhmlMmqt7Cq1mLsjzTEDs1OwTeNk5uhtan26Wui5gTTc1GmtZG40MKr6YQIfk4D41WRYFrHVeyT3jYiYyxBM9+KsSZRjuoxARHVNUmDiWMU2jmpWtOVUTqTa+2GjR7s6zAKAgadH2Hd8EVEoTIqcTfjq/svOUcAUI5BBD2e3Md2dFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CY8PR11MB7688.namprd11.prod.outlook.com (2603:10b6:930:75::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Tue, 4 Jun
 2024 00:58:00 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 00:58:00 +0000
Message-ID: <e54d68e7-3d57-4128-8c07-dd6c66196a7e@intel.com>
Date: Tue, 4 Jun 2024 12:57:50 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] x86/kexec: do unconditional WBINVD for bare-metal
 in stop_this_cpu()
To: Tom Lendacky <thomas.lendacky@amd.com>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <dave.hansen@intel.com>, <bp@alien8.de>,
	<kirill.shutemov@linux.intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<hpa@zytor.com>, <luto@kernel.org>, <peterz@infradead.org>,
	<rick.p.edgecombe@intel.com>, <ashish.kalra@amd.com>, <chao.gao@intel.com>,
	<bhe@redhat.com>, <nik.borisov@suse.com>, <pbonzini@redhat.com>,
	<seanjc@google.com>
References: <cover.1713439632.git.kai.huang@intel.com>
 <327899e13c4dbbfbe8ca95cab83ba229d17fb74b.1713439632.git.kai.huang@intel.com>
 <1ca2c140-8ab5-46a6-a26e-6840d7ba051c@intel.com>
 <90ee763e-e059-12a4-d7c3-9a710a1c5db4@amd.com>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <90ee763e-e059-12a4-d7c3-9a710a1c5db4@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR20CA0032.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::45) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|CY8PR11MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: 595856ad-1702-4e79-743e-08dc84316164
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2djSy9MVlNnMTlKbHdKd1EzVnk4UisvSzN5SXZWTXFmbkJ3KzJjZXBiNHk2?=
 =?utf-8?B?SDl0SndvVW1RTXlCYzZoelBOMU9DRVJ5Rlh6Sit6TnIwUGd4VEhqTHlkSjZy?=
 =?utf-8?B?WjYreGhaQnVFbTEzSElLYjFnOTF0QzVDTFl6ZUxJWUlTZjZOeUFYRGJlRWta?=
 =?utf-8?B?SzZSSmJzRVN5VTcvVG5Od0g3YnI2RWp1QytFMFlCMUVuSDlUaThrTWJMdjZw?=
 =?utf-8?B?RDI4TWxjWjhTRXk0a0c0MEZLbGdubEx5Mko5eGFjQVNyMnFPOUJxYkExMW9q?=
 =?utf-8?B?Wi9TaTN4MUtvZFVXQ0FTUEJFaVl2ekl4WnJGUDZKSDQ4U1d3VzhnMnRFczdS?=
 =?utf-8?B?ampnKzZtYTlJZDYxd1BUZlV5QWxLV1ZIckJudVREdVQxUXFpYVU2RTJvdGxl?=
 =?utf-8?B?eVFCY2IybFZhRnN0VnlLK2hPTFJZSjlhRUpURWd6QllLQWRvQTFUa1l1Vm5Q?=
 =?utf-8?B?WHBuK0VXQXo1THZyRVl6MnFMUldzQkhOcVA4N3p1bFJleE5ySmttUkk0RDhH?=
 =?utf-8?B?S0tHRm4waG5GaXFPN1ZxaDBENjVEWDU5VU5yR0ROWm93MjVuUHNHcmdsNkg4?=
 =?utf-8?B?UkhMV0g1bndtanUvdGJzVTBnYmp5cXVtcnVPSWZPTGNwbVUyVk9vTVB5bThG?=
 =?utf-8?B?SzBsZkFkNnBzM2hYYVVza1Y1OW9lSVl1Mnh0ak9ma1ZXM1d5c3NjOUFLRlQr?=
 =?utf-8?B?SDhYTEtyNWxQbEpLc1lQTXY1L1VJZU5EQUlsZUE2Mm9aMXVOdmVhYVFnR0Mr?=
 =?utf-8?B?MHNGODlUaDV6UHZVV09OWk9ud0ZOK3hneXdjemxYQ3k1KytHWTNDVWFJZjZ0?=
 =?utf-8?B?VzJ3ckRDSlIzNFdzT1d3b3NDei85MFpDaFQxSG54RitKSUJ0YitocUFJVW9s?=
 =?utf-8?B?YURMT3lFd2tlQWZlSkpmcEtoVmovVnl3MkpiTjlKcHpHY0FVMDdKU1NxMllx?=
 =?utf-8?B?TisweFdhYjVoUGw0ZTdQdFc2OWFsTXJTUWgwR1JHbEFEU0xTcTJ5WlB0cHVE?=
 =?utf-8?B?UXhyS0REc3RJR3NRdUt1a0dFUVZ5NDlRVFVWK2t6cXVmMzdGam5PQkFTc3My?=
 =?utf-8?B?RTRXZjREL3orNDhaZ1NOcHdiRkdoZzd6YS9ld05GbUtPSTIzNDJKbVBwSk82?=
 =?utf-8?B?U1VKQUpraTJGMUwvS1Q0c052U2I3NkFCeTZCNjhETWNrbStUNlR6dzJPYWRo?=
 =?utf-8?B?dlBGOHhFNFAydWJ4RWpibkt2elNCOXMzV2UyYUVZd0lGWSt5aUk5amVHc0xi?=
 =?utf-8?B?a2JkUHlnZDlsVHNXRFFPdExVdzFhWVNOZGNNQ01uTHgzWlNjcURGY1JjdGxJ?=
 =?utf-8?B?VlZ0WU1SUUw4NkJPWDQvZGFjd3JScm9pczBVQ2dqUzd0YlZyNTQ4YkZ5SEF2?=
 =?utf-8?B?TVd0QzdneHN4ZjEvbDlEMUtrSnd5eS9zaGdlcmVRbXVHcmlpRFdiZGN2dXMx?=
 =?utf-8?B?MFNwWmpIcDRnWlRhUk1YWkFRcUdTajd4c3hFQUZ2YTZxVUVaMDJlcXBaZkF1?=
 =?utf-8?B?V0c1c21WYmJrN3oydXdWSmtWSFNDdmZGRUVDbjdHRWhPbDRHL2ZQeUJMeEdI?=
 =?utf-8?B?RktpSFppcjVtTW9zR3VtUkRnMGlmd29nRUxzUWFOTXEzQ3R3c3pjclBrSkxD?=
 =?utf-8?B?aktVT2p3cGVTK010aFBEcjBKSVVJclRyTmtDTWRYUnAyZ3ltdzk3dEhackhY?=
 =?utf-8?B?MDlKTXcvTEF4MlhhNHJaRGxFNDh5YnN1UEhzQjFmemJMQTdmYVNYSUtBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2FtcmVnMVk3ZmFMTXBNdWxQL05PQ1JKdjRRT29FSTY1Vkh5N2NHSzBkbHd3?=
 =?utf-8?B?QXFEa1FjYW1hU1VzQVJmV3hoa29LaUhTK0h1OUVtRStZWkphWjZrajB3ZVc1?=
 =?utf-8?B?ZVdLUXo2VjVkRTZ0eUxwYVNJbzE1NjlCUkZ3QnNSOExEUHpZU3FnTVZtRFA3?=
 =?utf-8?B?c0VHMW9qRUNST1hmcVRFUFhJRVlISU9RUm92Nkc1L0FucEZ3N1hLQWNveVFz?=
 =?utf-8?B?SlZ6ZkJjL1E3YnE1SU9ZQWlKK0tjNUNQam1NWWxyUkhraE1uc3k3T0tTZDc3?=
 =?utf-8?B?STBYdGpSZVZTKzk4bEVndWlUN0dpMmNxbDN2ejFWSk9MOHpMVFY1RzRDVEJL?=
 =?utf-8?B?Zkc2ZnQ0aWg0SFI4Y21zT3JDckVFQmxPZDJ4eDRGS2tlK3UxSEZodktMQmxn?=
 =?utf-8?B?bUFzQ3AzczFvaXNTQmd2VStmRm53OTU0RGtmMFNlQUkxcXcvUHpHOHZVQVR4?=
 =?utf-8?B?UjR1QVlEWGY2clhtSFhYdlRWVzNWWnZFMy9nSjZHMVN1bStITzBwK3huNHRQ?=
 =?utf-8?B?bXJVNnZUaGFKbDdjNHQ0OUlmM0ZCRWNYZkFzNFhUWkdHQ1R5eEliUExaRFNX?=
 =?utf-8?B?bjQvUGpNb1k2SmJuRHk3Q2JVMVVRVi9STHI1bDRueDVIS2YwMzNTSy9tb1pU?=
 =?utf-8?B?ekt4eUNnZWppUnJFQUoxd0ZNcmNPQ1ZCMjhLNnliS3BqWkhpWHNkd0EzSldS?=
 =?utf-8?B?OG5MMFZ1cjlJb1RKOUtKQUZLSnhjY2o1RFpYZ0dhN2FwdktFSU9penRKMlc2?=
 =?utf-8?B?M1VYc2YwR1ExczVGS2pwajc4WndlYUFuQnZRZGY0NXhiaWUxZTljMTFFTzZa?=
 =?utf-8?B?RkVBQmpoZ3pFS0FnRFVtSDZ5djR6ZktrZlZrZlBzUlh3N3R5cG14dXRXTGNy?=
 =?utf-8?B?VFEwb3FSSjhmcHBBbjdwbHBjczhCSHg3MkY3TERHMVpZYnRKajVIblBYY0k1?=
 =?utf-8?B?VU4zQUpyaGJzK0h1SzVrRjUxWld0NGxuOHFZNHRKTzRRY0hpYkxEMUlzQmZF?=
 =?utf-8?B?WDRWdXdZOGI2clF6b0RyRjJIaENSSEJYeGdPS2RwWEJKMDdBSkVOR1JBeHdr?=
 =?utf-8?B?c0wxUzNadytVNi9UeDg0aUR4WCtzaStiWC9od1BXb2lhR1ZYVDFwazJOMDEz?=
 =?utf-8?B?a3ZSWmZzVE5GdG82TkViS1oyUFFTWjR1L0lUejNtbzlRV2RHdWJpcjdZTzBT?=
 =?utf-8?B?SFdrbmhJbHErRHEyenkvVjA0Z2ZVNEdrUjExVG8rZkYwSlZJTld1Unowcm9X?=
 =?utf-8?B?Rm8wdHE2alFLejV4aUkwZHZSbGNnY3JTV1pxeXF5Q0RUWFZSRmlORWdQYmV2?=
 =?utf-8?B?cCtyNEZlZnhKb0hTUTQwR0I1TTZocWRobXcwMGs5aGZtUHRCVWF6TTI1VEFz?=
 =?utf-8?B?ZE44U3hzbjdvaEtGWXp5SXBybmhwT1F1dlFPMGdtb0JNQU5rMi9NZDNhazZp?=
 =?utf-8?B?OTRZQjRyd2gzVUovemxxRjBZTit4ZExNSjUxYTc0a3pEY1h3SmJHaHNQamsv?=
 =?utf-8?B?OHRrSTJxenF2aHRjQ0tRL0FsUGNpR0E2MENuaFVrRFUyYVJsZFdKQTNwZUNT?=
 =?utf-8?B?OVlnUlp2cndIa1lHcDhjWVNldFdaSUhCVk90aXN0TE96Tm9saDJOYXRxWFlo?=
 =?utf-8?B?dFZNQk9HZHY3VGpuTEZQMUVaYlFnTncrbHNJZzBKalRZa29RL2ZKQjZTMEpN?=
 =?utf-8?B?dzBLTk1VZldCMGdGSStvY1BWYnV4UDliWUdsQXlNY3c1aUhaanY5SE1WWFhn?=
 =?utf-8?B?SUdVL09zeW5USkNNY0RwWlp4Y1phZERMK3hHWHQxTDNtTzJ4em5uSlVJam1w?=
 =?utf-8?B?QVNXaXpoRXFyUW94N0Y2RUlPV1FuRjlkK0hhQkNEZWUwYmJlYUhXQzRzVnlO?=
 =?utf-8?B?RnhzaGdhWjFkeUFFbHNpQW13c2JJeGtJU0NtdGNkTUpTdUNkVWV2SFNsck1y?=
 =?utf-8?B?SHRRRURjbHN1Ym5JdEpjVG9VYjhlOGF1eTNFcmIzQ3gwMUkreE5FOUFlS1Ay?=
 =?utf-8?B?RkJyTkRGRldqWnhEeXpyVFowWDBmaUhBVXZKSlo1R2tzdjVlb0VsL21JOTNV?=
 =?utf-8?B?VWd2UjIwdHp6RC9IRnc5NmpLY2kzUVNMeElrVUNkc2NWcHA0enZBdWpwanJU?=
 =?utf-8?Q?29vCfCr9jrAkbi07+l1sMZAp8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 595856ad-1702-4e79-743e-08dc84316164
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 00:58:00.3515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wmOAWQGx3OSFKvSCsiEfbmU6zVbEePKdJMNcfaCS1Wqk00WqPZIfDEt9diEnf2CZXYmwgTkhi7h7cKdO9dID+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7688
X-OriginatorOrg: intel.com



On 1/06/2024 8:45 am, Tom Lendacky wrote:
> On 5/22/24 21:49, Huang, Kai wrote:
>> On 18/04/2024 11:48 pm, Kai Huang wrote:
>>> TL;DR:
>>>
>>> Change to do unconditional WBINVD in stop_this_cpu() for bare metal
>>> to cover kexec support for both AMD SME and Intel TDX, despite there
>>> _was_ some issue preventing from doing so but now has it got fixed.
>>>
>>> Long version:
>>>
>>> Both AMD SME and Intel TDX can leave caches in an incoherent state due
>>> to memory encryption, which can lead to silent memory corruption during
>>> kexec.  To address this issue, it is necessary to flush the caches
>>> before jumping to the second kernel.
>>>
>>> Currently, the kernel only performs WBINVD in stop_this_cpu() when SME
>>> is supported by hardware.  To support TDX, instead of adding one more
>>> vendor-specific check, it is proposed to perform unconditional WBINVD.
>>> Kexec() is a slow path, and the additional WBINVD is acceptable for the
>>> sake of simplicity and maintainability.
>>>
>>
>> Hi Tom,
>>
>> May I ask how does SME work with kdump in crash_kexec().  Looking at 
>> the code, AFAICT the crash_kexec() path doesn't use stop_this_cpu() to 
>> stop all other cpus.  Instead, kdump_nmi_shootdown_cpus() is called to 
>> send NMI to remote cpus and crash_nmi_callback() is invoked to stop them.
>>
>> But the crash_nmi_callback() doesn't invoke WBINVD for SME AFAICT.  It 
>> does call the kdump_nmi_callback() callback where a WBINVD is 
>> performed for the SNP host:
>>
>> void kdump_sev_callback(void)
>> {
>>          /*
>>           * Do wbinvd() on remote CPUs when SNP is enabled in order to
>>           * safely do SNP_SHUTDOWN on the local CPU.
>>           */
>>          if (cc_platform_has(CC_ATTR_HOST_SEV_SNP))
>>                  wbinvd();
>> }
>>
>> So if I read correctly, what's the reason the WBINVD is skipped for 
>> SME in case of crash_kexec()?
> 
> The system is rebooted after a crash and doesn't continue directly on 
> into a new kernel.
> 

How about the kdump kernel itself?  Would the stale cachelines 
potentially corrupt it?

And how about /proc/vmcore, which reflects the system RAM used by the 
first, crashed, kernel?  Is it OK to have stale cachelines for it?

