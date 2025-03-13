Return-Path: <linux-kernel+bounces-560223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4FAA5FF83
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 777423ABA64
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C421EBA14;
	Thu, 13 Mar 2025 18:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RvWXg1qJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0BC77104
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 18:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741891243; cv=fail; b=QfLFkVWJjiwAafKdzF8m6oXnqQS0qSwae4VazivSl0YZpAEBS8A13AuBNVlt7W8oBG4/jrPtPfe+I5ppgb/qZYe+DqUojvMQP09UFpv6GP0oHB/lxlN0RfkRteln+/wfcyuzW5/a7R+kN41R/dvZ6kvNsSmUSTIM9ITBhd0P8Uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741891243; c=relaxed/simple;
	bh=TwWDTowsBmgmnIpFAZzjGNzFqAaVwE17v1I/JTfhVDM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uckslB0z7iXTvL+hlLkcXJlWzsU/RI/qLDmf3W9vTSgU9k8KTHPJ5u0KENYmTDE8DZ9sSDohB6VkdldAfmLt/38HQ8Fx8gfPFzxIxJl9Wxyc1nm45p8aNzPDvh4v9PMOLMwUufIYjaV8uu8xy2Eez4TFSYu/F0LJEk0Ifg/M+Zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RvWXg1qJ; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741891242; x=1773427242;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TwWDTowsBmgmnIpFAZzjGNzFqAaVwE17v1I/JTfhVDM=;
  b=RvWXg1qJ5Xxd+avzPZ87P0/uyLzidsLfFG+KyoLw2ONTii3OjR+T1kIv
   MMssdC23KLLI+Qz6eA9UtawKeZ7fz1Qyf7lOg3gUHKBYyTLo0i4R3Jt9j
   ct24FrvJ4vWG4pvm9rUHzYcbzzheWX7VAYKpdy700oGyffU89ZymZX55O
   EhGW4y8J4vxPZVqWxEHEX9ITtiWPHDWmIT/68oeoOdGpWtgxQZgV/KYRE
   eZxBRoVHFwDMFujRokAC7kDoA5No6q2yR/wtCwiwgK0rPQ5YgBuDkxhRk
   EJl5M8fRN+yjL4zGM2f+RUYS2AfmxDPGYro8k/ffnm3eGJSLMr01NrPty
   A==;
X-CSE-ConnectionGUID: YNyTgkwFTUK37JPZ46GEfA==
X-CSE-MsgGUID: /IfVhdk+QQefF+WS8DsgkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42912090"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="42912090"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 11:40:41 -0700
X-CSE-ConnectionGUID: 0kVMKYtBQgSbITGi00wnOw==
X-CSE-MsgGUID: M3R97m6UQA+09Tk9gu3/qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="144240157"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 11:40:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Mar 2025 11:40:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 11:40:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 11:40:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbB3JWkoA0i9Jm2auoUPGWvQrtg7df6ezTleTm26Uu8jYxqCUibfvnH4nXq6xuvr7LFx7dTiIQ5M7A1IfMUYXmONU/5KUa7H281vtndAekdt+O9ewaO9sNUIqNlnORqntSloglbHHimyk1dzEqF2MZ3flhEOlkpsx+U8OvQepuKytvNyJXwtkxZQ97DLEeLdvYEJqua7flDpZrusNfrKb4ngbAypzn0kKWJX0QBwdi8LYE1ZkheO/RmTI8ohVlK+SORnK7mHuNClfek9Q8GzaM5+vohCUrsJnJH2MlrNq8bIdGtVDZHWc5QbC0yxNFFbu2upaYfP48CKNOuMKKVoLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwWDTowsBmgmnIpFAZzjGNzFqAaVwE17v1I/JTfhVDM=;
 b=tjzqIVXjWCw8HtVdMb80TK2gKC4RXeN5VMwafl4ID45RtxcYEUPOlGaFiRG6ymw461YoWyW6cmR5fm+sjd/Aj0KdlSTIzzX83O1P+s+pUORZrlUaw3x6miBp7XyfJidQSqPTDFnJq3/RmrkkyddDO6wthaagiT6dsGzSD7wYayJ4FmsbwDIyNhO/P+GRBXOXbigyr2WRKdMr3CJmpp10EwyXErWUhawZiNTezccwf3YreR3MjjDkYxfwxzzCzne379K9xQofJtxxW+97mYvel0sODmOXVxjhh8ao1E3mzPBlGEycb0Bk+dLkNyqyphgQkj8UNeNp9jSh08viZNMIyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by LV3PR11MB8727.namprd11.prod.outlook.com (2603:10b6:408:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 18:40:09 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 18:40:09 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "peterz@infradead.org"
	<peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "Huang, Kai" <kai.huang@intel.com>, "bp@alien8.de"
	<bp@alien8.de>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>
CC: "nik.borisov@suse.com" <nik.borisov@suse.com>, "bhe@redhat.com"
	<bhe@redhat.com>, "seanjc@google.com" <seanjc@google.com>, "x86@kernel.org"
	<x86@kernel.org>, "dyoung@redhat.com" <dyoung@redhat.com>, "sagis@google.com"
	<sagis@google.com>, "hpa@zytor.com" <hpa@zytor.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
	"Yamahata, Isaku" <isaku.yamahata@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>
Subject: Re: [RFC PATCH 1/5] x86/kexec: Do unconditional WBINVD for bare-metal
 in stop_this_cpu()
Thread-Topic: [RFC PATCH 1/5] x86/kexec: Do unconditional WBINVD for
 bare-metal in stop_this_cpu()
Thread-Index: AQHbk0LE9xNDz/BUxUyAtvW7JgE+xLNxaCeA
Date: Thu, 13 Mar 2025 18:40:09 +0000
Message-ID: <e0d9a3d599025c92fce5e159e8acc1af32844912.camel@intel.com>
References: <cover.1741778537.git.kai.huang@intel.com>
	 <e9ee3c7ffc3ba6feb97247faa40789684e39ffd0.1741778537.git.kai.huang@intel.com>
In-Reply-To: <e9ee3c7ffc3ba6feb97247faa40789684e39ffd0.1741778537.git.kai.huang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|LV3PR11MB8727:EE_
x-ms-office365-filtering-correlation-id: 4b137859-d18a-4e59-681f-08dd625e7b70
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MWgySC84b0tlMnhKTjk5dEtLRW5PL1F3UTJac2lwSVRWRUVZS3lQQVBxTHdh?=
 =?utf-8?B?UXNiSWlQT0twajNvaTVybFREejJIaTdZanZTK0grNkw1ZDNXYXprcFZHSWF0?=
 =?utf-8?B?YnJMM2xNVTBZME1rcW5yQTNwUjVNanBkVlBVb3FpcFlVMVcxZ1pWdzBKUVp0?=
 =?utf-8?B?RXVHNi9XeXBFbmJ0cEt1a2Nqd0xhUXlmS1VSSnZ6YkNjRTlMNnBZR1cvbVNL?=
 =?utf-8?B?dTVleG05enlkaTJxbmRNaEVwbThHR2VjUmZXNTA5c0ZXcEkwbkNwNUN4QWJF?=
 =?utf-8?B?czM1REpJN3VmNWpQdnYrdkpxZENoREZ6VTRBdSs2SDArSDM1aldxUWc4N0dO?=
 =?utf-8?B?eTBRYmJhZkFybUlFVXRuSnJlZ3dxR1IwVFl0SFo2b01iNmJCaGZSd3ZsZ3ZJ?=
 =?utf-8?B?cGVrWlZtbGtqdDhFcEZiUUhnV3IrRVVBUHNkNTRXUS8yVnczK2FMTlBmM1NX?=
 =?utf-8?B?RFYzcDNlKzFTQTBkemZ5UjZEUEZ1YlFrLzB4NXBSSjlFRDdMVUhmQzRBcm5v?=
 =?utf-8?B?L1lqanBBbnJmd3VGSE0weTZCVlJlUnBYNFNiOFM4M0ErSHpJS3RYa3gwNFVJ?=
 =?utf-8?B?RUZNOE50bWVmT2Z1OEgzUGY3NkMzUy9xL3Y5eDk4UWpxMWtuV3NXMHBUVUFu?=
 =?utf-8?B?UlZDdHE3d3JPMml5cFR3bWpaVnBCNWVuZ3RGaXNyOXlwYm40UXJKZ2prOHVk?=
 =?utf-8?B?V080Q3FSejl2dyswNEtQSVdtY2M2MVBHS1JINXdiL2VqOWtHaWNYRWJ4K2Iw?=
 =?utf-8?B?QngzREZ4U0RXaEtSS1BHUUVNMk0wTCtNMWJJNlBTZjEzU1Jxc1AwNEhnVEQ5?=
 =?utf-8?B?UWp3d3h3TVgyVGo1ZjJzN2d1T2NqR25LRFNZbHpxWXdwTXJlS3FsWkV2cGRs?=
 =?utf-8?B?UDJjTnlhT1Y4bXBBeVNTT1YyZWF5T3BBL04xTTQxTmF6KzVJejlRREdRT3o0?=
 =?utf-8?B?dy9UcEZhL2RDd2NlSkdQYUJybERnRm9XeXRpT0ZaWGpISm00a1FDNTM1Z3NT?=
 =?utf-8?B?SHB6dGs0R1M4VW40QVZmcTVJYWVCaXlVV2RrMklHMjBPWGZhYS9TRWlRMlRv?=
 =?utf-8?B?T3JvSTJ0cEJEQzVXL0JkYWJmZkM1eVowMjFFL0N0VDlqQUJxRnN0U2xpZFpz?=
 =?utf-8?B?YzdGc3ZxR21mQ005dThoK1FNcVJRZmFKR1grV3YycGZHZFVVcHlPMjJBUjZE?=
 =?utf-8?B?a3ZHVDJ4SEpkZW9LaVJVL051SzRDQlYveFl2RUk3b0FBUk9lMFBReWxLWG4x?=
 =?utf-8?B?YW9kSmhqRktkRXFrVDFjU3Q3VHJIUkJPVmRMbVRHeHZrbVl3NklYR29Vei9L?=
 =?utf-8?B?YUs0L1lObVdZcUlQc2VRcitrRU9ETkk5YnhwWThqZVV1SXNVRzV6QmRlQ3FG?=
 =?utf-8?B?bkFkdjI2RTMrR0kwdFlBTlNpa1owdkRxYkFqSVhqcTgrOWtWY3YyZzhScnVC?=
 =?utf-8?B?RnpLYWtMeGNuMDRtMm1aRUV2ZFZaSHQwOTB3Q2FIaGtack9zd2JEeXFScXFx?=
 =?utf-8?B?b2ZHcVV6VitsOVV6dWxkV3ZnS040L2NLOUpEY3pQN3l1QUxmM2R5UEZhSGd5?=
 =?utf-8?B?WU51OWFuaHdqcnRsQ2NMbFExb0Y5Y2xoVk5yaHU2bWwxdXZyZWJMVHhzMDJp?=
 =?utf-8?B?d1lzUm0xc3g3ZkJEdUdoWjVydUk5QzBQMVR0TkNVZ0RsNFVXeUZDUm9kc1Jj?=
 =?utf-8?B?MFNzTTdNcTdMZXRFZGlxTFl2emlxRzFFZEMvVGNRRS9MTXp4VlRya1hrT2di?=
 =?utf-8?B?WWRHa2xzZ1VTWjRCZ2dLekZCMkxKYTh5dkdvRDgwdlpvRnU0OXl2WnplRnkz?=
 =?utf-8?B?YW9qWWp1OXpiUEg1T2hGVHdmbmFKUFQ4ZGQzRTJLeDByVVZPUDFGQlBCblFk?=
 =?utf-8?B?NnBOYXAwLzNGUS9mbzFBT0pFYmlydnlUMVpWQ1pZVi9USnFuTkZpeDJhU1cw?=
 =?utf-8?B?MXBmQU44VkNsRkg5NHhyWlN5RERyOE4xL2RvbjBJT1VQM2FRVjdIUXI4bjZl?=
 =?utf-8?B?REJHWkorMzVRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzFEYy9GeFRtSTc2cG11TnVVcEJGSnBGSHZ1NjFuaHhYQ1VVaHhITmowczlU?=
 =?utf-8?B?eWVtTzZPcXBVWlp6aXVyOEZGS2FaYXNCSmo5MktKZGhVeUFpcFZ1L1cram5R?=
 =?utf-8?B?MjI1dEZQZ24xc08vRDdKYldteXFFeEYxUFJTMDg4RXVjRlVxYVNVVDlndVlU?=
 =?utf-8?B?MTV5Y1pDQUtxVEtWMjhmQWZORE0rd1BNKzBHcUQxN0VaNzdPOU1RU3UrQkxr?=
 =?utf-8?B?bldidjF6SU1uc3lKd1plTkNscTBKUWptalNRcS9uZXdtaUtYa0xqN3RaZTRr?=
 =?utf-8?B?NVpLT2FCM1A2QW9EeUUwdmZKMXovWFlnOWRpcS9WSEZUSjlFTFFDTWFWZlJM?=
 =?utf-8?B?TzdaTnowdkNkWWF0S2R6bmVuaEhvZHJhejBXYk1QUmx5RWw5akxndTg4Yitk?=
 =?utf-8?B?MUJrdnhLTVR3enJaN08vb1k4VW81OHc3SWRsUUtBcVFYbFVOUU55bXBtc1Qy?=
 =?utf-8?B?TWx5eVNVbjNDbnlxOGd0QTYvYUZ2cjU3cjBJdmMrVzNWMGcySHdFOEVBUnVq?=
 =?utf-8?B?MGFlS2xhRTdTQWU1ZGVKUmtDSVhhanc3dWVFZ3JHUC91eE92K2NKMWNoRnhE?=
 =?utf-8?B?YVM3SDFJT2VxK3FwMXVET0VnVnB5TFFleWtnTnNxRHd0YkIwaUtUajNVKzBt?=
 =?utf-8?B?cTgzcG1sVTNxYVpaLzNBTkYyRWZmeGlqaGZLVzlXc2p5b09JSlozOGtySXpJ?=
 =?utf-8?B?ZVVnUVEwaGtkUDFWUDRKVjV1OFNCeTJkeHNNZk1wZWMyUExDQ1ZjeWRUZkhV?=
 =?utf-8?B?bm0ydkh5b1lwQWJYWFFobmlraTh0OHhscUl3aUhueGFRaTRDMjBvcnhrZ1Aw?=
 =?utf-8?B?Ny84azFLbmpBbUxweVR2TXM1dXpLejd6SGlpOHVJektVUXAzRmF0NzRRMzhU?=
 =?utf-8?B?OXFqK09NbDltbkU2UmthZVdsSmNLbnhWUGNMZUdoY2ZtSXV1VnJ3cnZCY1Fa?=
 =?utf-8?B?UGxHT0FMQnBLVEtCNk9ZVWJ6MTRoMmFEZEdZUDFlYXgxOG9LRGVkSUtZeVdB?=
 =?utf-8?B?UzFBc3lhTjAxTzBTQVVHR3pOTmJZclZXM2FJYVNuNmFrejJuUkFPRHIzNnFT?=
 =?utf-8?B?MTlPVDNNVXVMRldYL2ZHZ3dyQUZMTHVQSWZEcXFFQW4xU2NXbk9WdlAxTWFq?=
 =?utf-8?B?TmNnRnhVREVyVGlvaUVybjVtRnFrMlR0VVc5RHZ3L2d1NVVHVDZGVGZNeU5J?=
 =?utf-8?B?eHl0MnBvTlBSQ3A1bUtmUEFIOG1qRjNPRnREM015ZWNNU2hJTXBhRnlWOWta?=
 =?utf-8?B?aWkyTW54QThVT3QxRVhWSm1qY2NMWEtRUTFFUmwrNEZOY0twL1ZPaG1XR1dy?=
 =?utf-8?B?TWhSVGRmcFhDaEhzSTd5dGRxR2V4MlJwVjBmQ0JhdCtqYVhscDU5a3d3TGt0?=
 =?utf-8?B?b3NFR2MvNS9HQldmMGVva2lMMlhoWG56VHdmcFlqR05UcVowUThuNVdCY0di?=
 =?utf-8?B?ODVQRytIZjhZR3R6bDZyZXRZd0ExUDIxZzN2L0xMSEgxRmpEeTFoOW5xTkVx?=
 =?utf-8?B?NktxeVh1dFRrS2dTeXFjdTk0ZE4zUXBkL2JtamhadDIrWmpqWllpWXNBQmVQ?=
 =?utf-8?B?Vyt2WDBXNStOaTBNVFpBaTNJMVBrd0VpRjl5bUZIUU93MWR6ZW5xUld0aENW?=
 =?utf-8?B?dTJMdURQbFdrVXdpY3B4Ync1L0cvRmtDSGVlVE54b3ZIU3JVTE43UHJIWmFr?=
 =?utf-8?B?VkdVUzI0Qm13QnNNVW9LVm55RE9vOFBQaXBNUE96aDdybzh6aEJLR1dERGtx?=
 =?utf-8?B?c2FKZmFacWJrRzVaQ2J5SWhYcDBJdjZnVGVKOUxDbEFjSXVHREFsdmc1dVlE?=
 =?utf-8?B?eVRhaGFxRGt6cEl5ejhtdy9VZWovSEVGZzNCTXl4aG5BbWJjVFNla2oyOU54?=
 =?utf-8?B?ZVhKM3FqSksxckJlMW9IQUYvN0ZyR3VCMGtPR3Bpd2JMeWk5ZHN4d1B4UlNw?=
 =?utf-8?B?K1ZjbERZRnloMzFRSDBkaHg3Rjl4VjFFVUJxU0RXeVpOSmlacUkyWXNjektT?=
 =?utf-8?B?WlIxVk5tbktBV2w2WjBTMGF5blBpYTRNdmZ4WGdQUk1KeFRaa0lOTXVGOWVY?=
 =?utf-8?B?UUVnblpvWFJWQXpKdHhuMUU1RmZLZVUwOUs1U3MxcWhldW56Ymw0eHlmYmFJ?=
 =?utf-8?B?REhPd0tjRUlFY3dEMmpROHY5MVhUNVplVjBjcS9QVGd0V3JWTFNlRkJLZHly?=
 =?utf-8?B?cUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AA461C654476A4780FDDBD70DBB4BAA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b137859-d18a-4e59-681f-08dd625e7b70
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 18:40:09.3464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H8dJLWZfzqIguwYJSxsR2uyTJCyN9nk3fYQgH4ktgVRRRPE1hRWTgQsLR4aD8o0FIuC4iY0vLiIf9Bn1euSmWyq8eLYDFwwf4rfIJQMSU3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8727
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI1LTAzLTEzIGF0IDAwOjM0ICsxMzAwLCBLYWkgSHVhbmcgd3JvdGU6DQo+IFRM
O0RSOg0KPiANCj4gQ2hhbmdlIHRvIGRvIHVuY29uZGl0aW9uYWwgV0JJTlZEIGluIHN0b3BfdGhp
c19jcHUoKSBmb3IgYmFyZSBtZXRhbCB0bw0KPiBjb3ZlciBrZXhlYyBzdXBwb3J0IGZvciBib3Ro
IEFNRCBTTUUgYW5kIEludGVsIFREWC4gIFByZXZpb3VzbHkgdGhlcmUNCj4gX3dhc18gc29tZSBp
c3N1ZSBwcmV2ZW50aW5nIGZyb20gZG9pbmcgc28gYnV0IG5vdyBpdCBoYXMgYmVlbiBmaXhlZC4N
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXiBBZGRpbmcgInRoZSBrZXJuZWwiIGhlcmUg
d291bGQgcmVhZCBhIGxpdHRsZQ0KY2xlYW5lciB0byBtZS4NCg0KDQpXaGVuIEkgcmVhZCAic29t
ZSBpc3N1ZSIgSSBzdGFydCBhc3N1bWluZyBpdCB3YXNuJ3QgZnVsbHkgZGVidWdnZWQgYW5kIGl0
IGlzDQoic29tZSBpc3N1ZSIgdGhhdCBubyBvbmUga25vd3MuIEJ1dCBiZWxvdyBpdCBzb3VuZHMg
bGlrZSBpdCB3YXMgcm9vdCBjYXVzZWQuDQoNCj4gTG9uZyB2ZXJzaW9uOg0KDQpJdCBtaWdodCBt
YWtlIHRoaXMgZWFzaWVyIHRvIGRpZ2VzdCB0aGlzIGxvbmcgdmVyc2lvbiBpZiBpdCBzdGFydCB3
aXRoIGEgInRlbGwNCnRoZW0gd2hhdCB5b3UgYXJlIGdvaW5nIHRvIHRlbGwgdGhlbSIgcGFyYWdy
YXBoLg0KDQo+IA0KPiBBTUQgU01FIHVzZXMgdGhlIEMtYml0IHRvIGRldGVybWluZSB3aGV0aGVy
IHRvIGVuY3J5cHQgdGhlIG1lbW9yeSBvcg0KPiBub3QuICBGb3IgdGhlIHNhbWUgcGh5c2ljYWwg
bWVtb3J5IGFkZHJlc3MsIGRpcnR5IGNhY2hlbGluZXMgd2l0aCBhbmQNCj4gd2l0aG91dCB0aGUg
Qy1iaXQgY2FuIGNvZXhpc3QgYW5kIHRoZSBDUFUgY2FuIGZsdXNoIHRoZW0gYmFjayB0byBtZW1v
cnkNCj4gaW4gcmFuZG9tIG9yZGVyLiAgVG8gc3VwcG9ydCBrZXhlYyBmb3IgU01FLCB0aGUgb2xk
IGtlcm5lbCB1c2VzIFdCSU5WRA0KPiB0byBmbHVzaCBjYWNoZSBiZWZvcmUgYm9vdGluZyB0byB0
aGUgbmV3IGtlcm5lbCBzbyB0aGF0IG5vIHN0YWxlIGRpcnR5DQo+IGNhY2hlbGluZSBhcmUgbGVm
dCBvdmVyIGJ5IHRoZSBvbGQga2VybmVsIHdoaWNoIGNvdWxkIG90aGVyd2lzZSBjb3JydXB0DQo+
IHRoZSBuZXcga2VybmVsJ3MgbWVtb3J5Lg0KPiANCj4gVERYIHVzZXMgJ0tleUlEJyBiaXRzIGlu
IHRoZSBwaHlzaWNhbCBhZGRyZXNzIGZvciBtZW1vcnkgZW5jcnlwdGlvbiBhbmQNCj4gaGFzIHRo
ZSBzYW1lIHJlcXVpcmVtZW50LiAgVG8gc3VwcG9ydCBrZXhlYyBmb3IgVERYLCB0aGUgb2xkIGtl
cm5lbA0KPiBuZWVkcyB0byBmbHVzaCBjYWNoZSBvZiBURFggcHJpdmF0ZSBtZW1vcnkuDQoNClRo
aXMgcGFyYWdyYXBoIGlzIGEgbGl0dGxlIGphcnJpbmcgYmVjYXVzZSBpdCdzIG5vdCBjbGVhciBo
b3cgaXQgZm9sbG93cyBmcm9tDQp0aGUgZmlyc3QgcGFyYWdyYXBoLiBJdCBoZWxwcyB0aGUgcmVh
ZGVyIHRvIGdpdmUgc29tZSBoaW50cyBvbiBob3cgdGhleSBzaG91bGQNCm9yZ2FuaXplIHRoZSBp
bmZvcm1hdGlvbiBhcyB0aGV5IGdvIGFsb25nLiBJZiBpdCdzIHRvbyBtdWNoIG9mIGFuIGluZm8g
ZHVtcCwgaXQNCnB1dHMgYW4gZXh0cmEgYnVyZGVuLiBUaGV5IGhhdmUgdG8gdHJ5IHRvIGhvbGQg
YWxsIG9mIHRoZSBmYWN0cyBpbiB0aGVpciBoZWFkDQp1bnRpbCB0aGV5IGNhbiBwdXQgdG9nZXRo
ZXIgdGhlIGJpZ2dlciBwaWN0dXJlIHRoZW1zZWx2ZXMuDQoNClRoZSBleHRyYSBpbmZvIGFib3V0
IFREWCB1c2luZyBLZXlJRCBhbHNvIHNlZW1zIHVubmVjZXNzYXJ5IHRvIHRoZSBwb2ludCAoSUlV
QykuDQoNCj4gDQo+IEN1cnJlbnRseSwgdGhlIGtlcm5lbCBvbmx5IHBlcmZvcm1zIFdCSU5WRCBp
biBzdG9wX3RoaXNfY3B1KCkgd2hlbiBTTUUNCj4gaXMgc3VwcG9ydGVkIGJ5IGhhcmR3YXJlLiAg
UGVyZm9ybSB1bmNvbmRpdGlvbmFsIFdCSU5WRCB0byBzdXBwb3J0IFREWA0KPiBpbnN0ZWFkIG9m
IGFkZGluZyBvbmUgbW9yZSB2ZW5kb3Itc3BlY2lmaWMgY2hlY2suICBLZXhlYyBpcyBhIHNsb3cg
cGF0aCwNCj4gYW5kIHRoZSBhZGRpdGlvbmFsIFdCSU5WRCBpcyBhY2NlcHRhYmxlIGZvciB0aGUg
c2FrZSBvZiBzaW1wbGljaXR5IGFuZA0KPiBtYWludGFpbmFiaWxpdHkuDQoNCk91dCBvZiBjdXJp
b3NpdHksIGRvIHlvdSBrbm93IHdoeSB0aGlzIHdhcyBub3QgYWxyZWFkeSBuZWVkZWQgZm9yIG5v
bi1zZWxmIHNub29wDQpDUFVzPyBXaHkgY2FuJ3QgdGhlcmUgYmUgb3RoZXIgY2FjaGUgbW9kZXMg
dGhhdCBnZXQgd3JpdHRlbiBiYWNrIGFmdGVyIHRoZSBuZXcNCmtlcm5lbCBzdGFydHMgdXNpbmcg
dGhlIG1lbW9yeSBmb3Igc29tZXRoaW5nIGVsc2U/DQoNCj4gDQo+IE9ubHkgZG8gV0JJTlZEIG9u
IGJhcmUtbWV0YWwuICBEb2luZyBXQklOVkQgaW4gZ3Vlc3QgdHJpZ2dlcnMgdW5leHBlY3RlZA0K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXnRoZQ0KPiBl
eGNlcHRpb24gKCNWRSBvciAjVkMpIGZvciBURFggYW5kIFNFVi1FUy9TRVYtU05QIGd1ZXN0cyBh
bmQgdGhlIGd1ZXN0DQo+IG1heSBub3QgYmUgYWJsZSB0byBoYW5kbGUgc3VjaCBleGNlcHRpb24g
KGUuZy4sIFREWCBndWVzdHMgcGFuaWNzIGlmIGl0DQogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXnBhbmljDQo+IHNlZXMgc3VjaCAj
VkUpLg0KDQpJdCdzIGEgc21hbGwgdGhpbmcsIGJ1dCBJIHRoaW5rIHlvdSBjb3VsZCBza2lwIHRo
ZSAjVkUgb3IgI1ZDIGluZm8gaW4gaGVyZS4gQWxsDQp0aGV5IG5lZWQgdG8ga25vdyB0byB1bmRl
cnN0YW5kIHRoaXMgcGF0Y2ggaXMgdGhhdCBURFggYW5kIHNvbWUgU0VWIGtlcm5lbHMNCmNhbm5v
dCBoYW5kbGUgV0JJTlZELiBBbmQgVERYIHBhbmljcy4gKGRvZXMgU0VWIG5vdD8pDQoNCj4gDQo+
IEhpc3Rvcnkgb2YgU01FIGFuZCBrZXhlYyBXQklOVkQ6DQo+IA0KPiBUaGVyZSBfd2FzXyBhbiBp
c3N1ZSBwcmV2ZW50aW5nIGRvaW5nIHVuY29uZGl0aW9uYWwgV0JJTlZEIGJ1dCB0aGF0IGhhcw0K
PiBiZWVuIGZpeGVkLg0KPiANCj4gSW5pdGlhbCBTTUUga2V4ZWMgc3VwcG9ydCBhZGRlZCBhbiB1
bmNvbmRpdGlvbmFsIFdCSU5WRCBpbiBjb21taXQNCj4gDQo+ICAgYmJhNGVkMDExYTUyOiAoIng4
Ni9tbSwga2V4ZWM6IEFsbG93IGtleGVjIHRvIGJlIHVzZWQgd2l0aCBTTUUiKQ0KPiANCj4gVGhp
cyBjb21taXQgY2F1c2VkIGRpZmZlcmVudCBJbnRlbCBzeXN0ZW1zIHRvIGhhbmcgb3IgcmVzZXQu
DQo+IA0KPiBXaXRob3V0IGEgY2xlYXIgcm9vdCBjYXVzZSwgYSBsYXRlciBjb21taXQNCj4gDQo+
ICAgZjIzZDc0ZjZjNjZjOiAoIng4Ni9tbTogUmV3b3JrIHdiaW52ZCwgaGx0IG9wZXJhdGlvbiBp
biBzdG9wX3RoaXNfY3B1KCkiKQ0KPiANCj4gZml4ZWQgdGhlIEludGVsIHN5c3RlbSBoYW5nIGlz
c3VlcyBieSBvbmx5IGRvaW5nIFdCSU5WRCB3aGVuIGhhcmR3YXJlDQo+IHN1cHBvcnRzIFNNRS4N
Cj4gDQo+IEEgY29ybmVyIGNhc2UgWypdIHJldmVhbGVkIHRoZSByb290IGNhdXNlIG9mIHRoZSBz
eXN0ZW0gaGFuZyBpc3N1ZXMgYW5kDQo+IHdhcyBmaXhlZCBieSBjb21taXQNCj4gDQo+ICAgMWY1
ZTdlYjc4NjhlOiAoIng4Ni9zbXA6IE1ha2Ugc3RvcF9vdGhlcl9jcHVzKCkgbW9yZSByb2J1c3Qi
KQ0KPiANCj4gU2VlIFsxXVsyXSBmb3IgbW9yZSBpbmZvcm1hdGlvbi4NCj4gDQo+IEZ1cnRoZXIg
dGVzdGluZyBvZiBkb2luZyB1bmNvbmRpdGlvbmFsIFdCSU5WRCBiYXNlZCBvbiB0aGUgYWJvdmUg
Zml4IG9uDQo+IHRoZSBwcm9ibGVtYXRpYyBtYWNoaW5lcyAodGhhdCBpc3N1ZXMgd2VyZSBvcmln
aW5hbGx5IHJlcG9ydGVkKQ0KPiBjb25maXJtZWQgdGhlIGlzc3VlcyBjb3VsZG4ndCBiZSByZXBy
b2R1Y2VkLg0KPiANCj4gU2VlIFszXVs0XSBmb3IgbW9yZSBpbmZvcm1hdGlvbi4NCj4gDQo+IFRo
ZXJlZm9yZSwgaXQgaXMgc2FmZSB0byBkbyB1bmNvbmRpdGlvbmFsIFdCSU5WRCBmb3IgYmFyZS1t
ZXRhbCBub3cuDQoNCkluc3RlYWQgb2YgYSBwbGF5LWJ5LXBsYXksIGl0IG1pZ2h0IGJlIG1vcmUg
aW5mb3JtYXRpdmUgdG8gc3VtbWFyaXplIHRoZSBlZGdlcw0KY292ZXJlZCBpbiB0aGlzIGhpc3Rv
cnk6DQogLSBEb24ndCBkbyBhbnl0aGluZyB0aGF0IHdyaXRlcyBtZW1vcnkgYmV0d2VlbiB3Ymlu
dmQgYW5kIG5hdGl2ZV9oYWx0KCkuIFRoaXMNCmluY2x1ZGVzIGZ1bmN0aW9uIGNhbGxzIHRoYXQg
dG91Y2ggdGhlIHN0YWNrLg0KIC0gQXZvaWQgaXNzdWluZyB3YmludmQgb24gbXVsdGlwbGUgQ1BV
cyBhdCB0aGUgc2FtZSB0aW1lLiBBcyB0Z2x4IGltcGxpZXMgaXQgaXMNCnRvbyBleHBlbnNpdmUu
DQogLSBEb24ndCByYWNlIHJlYm9vdCBieSB3YXRjaGluZyBjcHVtYXNrIGluc3RlYWQgb2YgbnVt
X29ubGluZV9jcHVzKCkuIEJ1dCB0aGVyZQ0KaXMgYSByYWNlIHN0aWxsLg0KDQpIbW0sIG9uIHRo
ZSBsYXN0IG9uZSB0Z2x4IHNheXM6DQogICAgVGhlIGNwdW1hc2sgY2Fubm90IHBsdWcgYWxsIGhv
bGVzIGVpdGhlciwgYnV0IGl0J3MgYmV0dGVyIHRoYW4gYSByYXcNCiAgICBjb3VudGVyIGFuZCBh
bGxvd3MgdG8gcmVzdHJpY3QgdGhlIE5NSSBmYWxsYmFjayBJUEkgdG8gYmUgc2VudCBvbmx5IHRo
ZQ0KICAgIENQVXMgd2hpY2ggaGF2ZSBub3QgcmVwb3J0ZWQgd2l0aGluIHRoZSB0aW1lb3V0IHdp
bmRvdw0KDQpBcmUgd2Ugb3BlbmluZyB1cCBtb3JlIHBsYXRmb3JtcyB0byBhIHJhY2UgYnkgdW5j
b25kaXRpb25hbGx5IGRvaW5nIHRoZSB3YmludmQ/DQpDYW4gd2UgYmUgY2xhcmlmeSB0aGF0IG5v
dGhpbmcgYmFkIGhhcHBlbnMgaWYgd2UgbG9zZSB0aGUgcmFjZT8gKGFuZCBpcyBpdA0KdHJ1ZT8p
DQoNCj4gDQo+IFsqXSBUaGUgY29tbWl0IGRpZG4ndCBjaGVjayB3aGV0aGVyIHRoZSBDUFVJRCBs
ZWFmIGlzIGF2YWlsYWJsZSBvciBub3QuDQo+IE1ha2luZyB1bnN1cHBvcnRlZCBDUFVJRCBsZWFm
IG9uIEludGVsIHJldHVybnMgZ2FyYmFnZSByZXN1bHRpbmcgaW4NCj4gdW5pbnRlbmRlZCBXQklO
VkQgd2hpY2ggY2F1c2VkIHNvbWUgaXNzdWUgKGZvbGxvd2VkIGJ5IHRoZSBhbmFseXNpcyBhbmQN
Cj4gdGhlIHJldmVhbCBvZiB0aGUgZmluYWwgcm9vdCBjYXVzZSkuICBUaGUgY29ybmVyIGNhc2Ug
d2FzIGluZGVwZW5kZW50bHkNCj4gZml4ZWQgYnkgY29tbWl0DQo+IA0KPiAgIDliMDQwNDUzZDQ0
NDogKCJ4ODYvc21wOiBEb250IGFjY2VzcyBub24tZXhpc3RpbmcgQ1BVSUQgbGVhZiIpDQo+IA0K
PiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzI4YTQ5NGNhLTMxNzMtNDA3Mi05
MjFjLTZjNWY1YjI1N2U3OUBhbWQuY29tLyBbMV0NCj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGttbC8yNDg0NDU4NC04MDMxLTRiNTgtYmE1Yy1mODVlZjJmNGM3MThAYW1kLmNvbS8g
WzJdDQo+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyNDAyMjEwOTI4NTYu
R0FaZFhDV0dKTDdjOUtMZXd2QGZhdF9jcmF0ZS5sb2NhbC8gWzNdDQo+IExpbms6IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xrbWwvQ0FMdStBb1Naa3Exa3oteGp2SGtrdUozQzcxZDBTTTVpYkVK
dXJkZ21rWnFadk5wMmRRQG1haWwuZ21haWwuY29tLyBbNF0NCj4gU2lnbmVkLW9mZi1ieTogS2Fp
IEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29tPg0KPiBTdWdnZXN0ZWQtYnk6IEJvcmlzbGF2IFBl
dGtvdiA8YnBAYWxpZW44LmRlPg0KPiBDYzogVG9tIExlbmRhY2t5IDx0aG9tYXMubGVuZGFja3lA
YW1kLmNvbT4NCj4gQ2M6IERhdmUgWW91bmcgPGR5b3VuZ0ByZWRoYXQuY29tPg0KPiBSZXZpZXdl
ZC1ieTogVG9tIExlbmRhY2t5IDx0aG9tYXMubGVuZGFja3lAYW1kLmNvbT4NCj4gLS0tDQo+ICBh
cmNoL3g4Ni9rZXJuZWwvcHJvY2Vzcy5jIHwgMjEgKysrKysrKysrKystLS0tLS0tLS0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL3Byb2Nlc3MuYyBiL2FyY2gveDg2L2tlcm5lbC9w
cm9jZXNzLmMNCj4gaW5kZXggOWM3NWQ3MDEwMTFmLi44NDc1ZDlkMmQ4YzQgMTAwNjQ0DQo+IC0t
LSBhL2FyY2gveDg2L2tlcm5lbC9wcm9jZXNzLmMNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL3By
b2Nlc3MuYw0KPiBAQCAtODE5LDE4ICs4MTksMTkgQEAgdm9pZCBfX25vcmV0dXJuIHN0b3BfdGhp
c19jcHUodm9pZCAqZHVtbXkpDQo+ICAJbWNoZWNrX2NwdV9jbGVhcihjKTsNCj4gIA0KPiAgCS8q
DQo+IC0JICogVXNlIHdiaW52ZCBvbiBwcm9jZXNzb3JzIHRoYXQgc3VwcG9ydCBTTUUuIFRoaXMg
cHJvdmlkZXMgc3VwcG9ydA0KPiAtCSAqIGZvciBwZXJmb3JtaW5nIGEgc3VjY2Vzc2Z1bCBrZXhl
YyB3aGVuIGdvaW5nIGZyb20gU01FIGluYWN0aXZlDQo+IC0JICogdG8gU01FIGFjdGl2ZSAob3Ig
dmljZS12ZXJzYSkuIFRoZSBjYWNoZSBtdXN0IGJlIGNsZWFyZWQgc28gdGhhdA0KPiAtCSAqIGlm
IHRoZXJlIGFyZSBlbnRyaWVzIHdpdGggdGhlIHNhbWUgcGh5c2ljYWwgYWRkcmVzcywgYm90aCB3
aXRoIGFuZA0KPiAtCSAqIHdpdGhvdXQgdGhlIGVuY3J5cHRpb24gYml0LCB0aGV5IGRvbid0IHJh
Y2UgZWFjaCBvdGhlciB3aGVuIGZsdXNoZWQNCj4gLQkgKiBhbmQgcG90ZW50aWFsbHkgZW5kIHVw
IHdpdGggdGhlIHdyb25nIGVudHJ5IGJlaW5nIGNvbW1pdHRlZCB0bw0KPiAtCSAqIG1lbW9yeS4N
Cj4gKwkgKiBVc2Ugd2JpbnZkIHRvIHN1cHBvcnQga2V4ZWMgZm9yIGJvdGggU01FIChmcm9tIGlu
YWN0aXZlIHRvIGFjdGl2ZQ0KPiArCSAqIG9yIHZpY2UtdmVyc2EpIGFuZCBURFguICBUaGUgY2Fj
aGUgbXVzdCBiZSBjbGVhcmVkIHNvIHRoYXQgaWYgdGhlcmUNCj4gKwkgKiBhcmUgZW50cmllcyB3
aXRoIHRoZSBzYW1lIHBoeXNpY2FsIGFkZHJlc3MsIGJvdGggd2l0aCBhbmQgd2l0aG91dA0KPiAr
CSAqIHRoZSBlbmNyeXB0aW9uIGJpdChzKSwgdGhleSBkb24ndCByYWNlIGVhY2ggb3RoZXIgd2hl
biBmbHVzaGVkIGFuZA0KPiArCSAqIHBvdGVudGlhbGx5IGVuZCB1cCB3aXRoIHRoZSB3cm9uZyBl
bnRyeSBiZWluZyBjb21taXR0ZWQgdG8gbWVtb3J5Lg0KPiAgCSAqDQo+IC0JICogVGVzdCB0aGUg
Q1BVSUQgYml0IGRpcmVjdGx5IGJlY2F1c2UgdGhlIG1hY2hpbmUgbWlnaHQndmUgY2xlYXJlZA0K
PiAtCSAqIFg4Nl9GRUFUVVJFX1NNRSBkdWUgdG8gY21kbGluZSBvcHRpb25zLg0KPiArCSAqIHN0
b3BfdGhpc19jcHUoKSBpc24ndCBhIGZhc3QgcGF0aCwganVzdCBkbyB1bmNvbmRpdGlvbmFsIFdC
SU5WRCBmb3INCj4gKwkgKiBiYXJlLW1ldGFsIHRvIGNvdmVyIGJvdGggU01FIGFuZCBURFguICBE
byBub3QgZG8gV0JJTlZEIGluIGEgZ3Vlc3QNCj4gKwkgKiBzaW5jZSBwZXJmb3JtaW5nIG9uZSB3
aWxsIHJlc3VsdCBpbiBhbiBleGNlcHRpb24gKCNWRSBvciAjVkMpIGZvcg0KPiArCSAqIFREWCBv
ciBTRVYtRVMvU0VWLVNOUCBndWVzdHMgd2hpY2ggdGhlIGd1ZXN0IG1heSBub3QgYmUgYWJsZSB0
bw0KPiArCSAqIGhhbmRsZSAoZS5nLiwgVERYIGd1ZXN0IHBhbmljcyBpZiBpdCBzZWVzICNWRSku
DQo+ICAJICovDQo+IC0JaWYgKGMtPmV4dGVuZGVkX2NwdWlkX2xldmVsID49IDB4ODAwMDAwMWYg
JiYgKGNwdWlkX2VheCgweDgwMDAwMDFmKSAmIEJJVCgwKSkpDQo+ICsJaWYgKCFib290X2NwdV9o
YXMoWDg2X0ZFQVRVUkVfSFlQRVJWSVNPUikpDQo+ICAJCXdiaW52ZCgpOw0KDQpJIHNlZSB0aGF0
IHRoaXMgYWxyZWFkeSBoYXMgVG9tJ3MgUkIsIGJ1dCBJJ20gbm90IHN1cmUgaG93IHRoaXMgd29y
a3MgZm9yIEFNRC4NClRoZSBvcmlnaW5hbCBTTUUgcGF0Y2ggdHJpZWQgdG8gYXZvaWQgd3JpdGlu
ZyB0byBtZW1vcnkgYnkgcHV0dGluZyB0aGUgd2JpbnZkDQppbW1lZGlhdGVseSBiZWZvcmUgdGhl
IGhhbHQsIGJ1dCB0b2RheSBpdCBpcyBmdXJ0aGVyIGF3YXkuIEJlbG93IHRoaXMgaHVuayB0aGVy
ZQ0KYXJlIG1vcmUgaW5zdHJ1Y3Rpb25zIHRoYXQgY291bGQgZGlydHkgbWVtb3J5IGJlZm9yZSB0
aGUgaGFsdC4gwqBPaGguLi4gaXQncyBuZXcuDQo5IG1vbnRocyBhZ28gMjZiYTczNTNjYWFhICgi
eDg2L3NtcDogQWRkIHNtcF9vcHMuc3RvcF90aGlzX2NwdSgpIGNhbGxiYWNrIikgYWRkcw0KYSBm
dW5jdGlvbiBjYWxsIHRoYXQgd291bGQgdG91Y2ggdGhlIHN0YWNrLiBJIHRoaW5rIGl0J3Mgd3Jv
bmc/IEFuZCBwcm9iYWJseQ0KaW50cm9kdWNlZCBhZnRlciB0aGlzIHBhdGNoIHdhcyBvcmlnaW5h
bGx5IHdyaXR0ZW4uDQoNClRoZW4gdGhlIGNwdWlkX2VheCgpIGNvdWxkIGJlIG5vbi1pbmxpbmVk
LCBidXQgcHJvYmFibHkgbm90LiBCdXQgdGhlDQpib290X2NwdV9oYXMoKSBhZGRlZCBpbiB0aGlz
IHBhdGNoIGNvdWxkIGNhbGwgb3V0IHRvIGthc2FuIGFuZCBkaXJ0eSB0aGUgc3RhY2suDQoNClNv
IEkgdGhpbmsgdGhlIGV4aXN0aW5nIFNNRSBjYXNlIG1pZ2h0IGJlIHRoZW9yZXRpY2FsbHkgaW5j
b3JyZWN0LCBhbmQgaWYgc28NCnRoaXMgbWFrZXMgdGhpbmdzIHZlcnkgc2xpZ2h0bHkgd29yc2Uu
DQoNCj4gIA0KPiAgCS8qDQoNCg==

