Return-Path: <linux-kernel+bounces-367152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E44999FF2C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3229D1C24424
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0F0170854;
	Wed, 16 Oct 2024 03:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oaeuab3N"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D964713AF2;
	Wed, 16 Oct 2024 03:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729048448; cv=fail; b=XDTdOJQyftiTT7/ms2PuZVX73GRu6joSnJS0yUwKQsuCjO1eXwkoqe27U0ke0t02DzxBb53qFJevs321WL/PxTVH7MYvQzUVoTMH9gzl7M6PYc3UK8cK5SNi/6Fo2Vnkk4KHZ9AGPrIt8HioH+0bRAnS/U0+8dt2a543MqYbTQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729048448; c=relaxed/simple;
	bh=6GiJ6A+6tbDuHuhJR1hfy8Ffwg+K2ydpiQGTPOPJN/A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OFlWV+g/qHUtrGF6ck9w2ab/807thD+SaRnd0fPRG1ZZVfFNCNWq+012VrCSRh3iTAmzDev+8t8pFjy02qr3BbCEALCI7RjbVoXfVCVUiB++Nwgl9x5EET9uzvnckCQAv/Nq1V6d5zTQYtIK98J+rjfR86Gh/Nqsm1toQrCjRXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oaeuab3N; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729048447; x=1760584447;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6GiJ6A+6tbDuHuhJR1hfy8Ffwg+K2ydpiQGTPOPJN/A=;
  b=Oaeuab3NLpyrLQ28tsUJRbvABrGY1dwP8eCifR2wlYTYOCK3tqqBEjFU
   1qlrSb64bV8JFLMjMFAxRInjI6ixAi9NZ/4oKv50idREsgc+AXnia4K2S
   UsaFDDHEmDjWoF4Os3BwbFZ24iFpVu8J23Tq/cqgSudkzBdYfL/MeSAhx
   ElqXfYkouJ2PshJn41lDfuWvpE2SySIlFl7ci62RnzkOZ1KlTKEMdts1n
   y8Cz6R4rHDu4uxUdtiBB6D4DVMGMkUsqTd/uJnt/o3Z/Ka29XW5A+K4nx
   mFok6UtY1MVG95T6Nj5qK+gCFZvr4Lk9KwMHBb5nnHyqjNSapkOue/xtZ
   A==;
X-CSE-ConnectionGUID: GddKSjRrRDqSJTcAhUjVvg==
X-CSE-MsgGUID: jFgXEyIVSmCpgELFXTxBPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="39055524"
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="39055524"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 20:14:06 -0700
X-CSE-ConnectionGUID: LPQRNnWAT0ud+8uf/lyiCg==
X-CSE-MsgGUID: TtYGEtZPSY2DyBKhZhBh+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="82067379"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 20:14:06 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 20:14:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 20:14:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 20:14:05 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 20:14:05 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 20:14:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPx5Du7uiFa338h5G0xPJWqDCde7i2NVYRmWCtGFA0tEArvzR7IDoXuZax9BM6jcZOgD1QH3nuF7+BrAOrtU1AVxjLRiBGCwSFYv1NKFzQNiI/NI8+J+Ojg9ciMg9iT+Mxo6kqTxfiW4qs5n55feevXFxgPm1IMnHqZHOOZixrM/++dw+LPPPfN0gqoBhkP/Dcb/e9H2QhwzphFl5Sgkdl1pjhc9HcjjJyYN9je2z2vGdOJW8Xb8eMYsEsNwZ4Bjbs9TNWgkAgrNhHTBHBIkpSBbloIBeqPjiJAFBtrdsRqloFPA9VDt7GiBjtNrH1DvbRY1LE4QbbYEPEat8n+Frg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmOssaTu3qhGjsxtqc5G2X0JAeXtlE+6/60tgwLyXOY=;
 b=da3M1YJVXnzC1NFbk8c3bA3DQNsUwPfrGicFb8MtUCcyNk8nMXJ4VC5sWmyQ3guf719c8oNjv88LtAGBc+DAw9vACjw3tmLsTnwVAUJlCBUX3jP2jpa0BbyCWCU5tI6qTIwvWZQzqM6M0ekgytn+k+crasp4Y2eKqO/dbItsBt1Z7AuevLMkZTvCKAApNZ+YGSPt/11OWrp2kvcpBq51jCSV2nhfS9lcxwINCDWjylt0k7HX6J2DvGsFkeV+amQtPbCHCui4HLj6wTeZn6S6eFon5j3e8XyFW9de+EQbiQq0Lt6ToiVGath1NJePlW+yxmLNawQi9eWd8m4MQN7VjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL4PR11MB8823.namprd11.prod.outlook.com (2603:10b6:208:5a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 03:14:00 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 03:13:59 +0000
Message-ID: <b19af235-7ad5-4897-8082-1eabfee849e8@intel.com>
Date: Tue, 15 Oct 2024 20:13:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/25] x86/resctrl: Add __init attribute to
 dom_data_init()
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
 <03077cf67cea1b3ebb00495fd40d1535db27ff8c.1728495588.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <03077cf67cea1b3ebb00495fd40d1535db27ff8c.1728495588.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0190.namprd04.prod.outlook.com
 (2603:10b6:303:86::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL4PR11MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: f6cb63fb-c5aa-4772-0259-08dced9093ea
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmR4UGhpM2JrVlJwdkpheXRzS0ZTTUhqUTJZNFNKYUpIb1BEL203cHF2ZGk2?=
 =?utf-8?B?MGpiZk1FR3UxZ2ZPT0t2eStoMDBpTTBaWUdmSDZjR2hFdi9SRTczMHMveU9R?=
 =?utf-8?B?eWlBaWJsQThYc0QvempoNFVVWjIrNGxZQytKME42QWt0bTgyTHlpbVlqeEtO?=
 =?utf-8?B?aEhvSStKMUg5eWJCTGJTSUp3M2NSRGRhTG1ZdHZGVUJDOHhMMFdUYUVQUkRm?=
 =?utf-8?B?OWtqNzRTM2Z6eDM5LzMvTG45MGUxZVpqeEtHUENEOVU4KzEzSENtN0EvVU14?=
 =?utf-8?B?dC9UNjlRbGsyRGJDbWNEVXBKZTlzWE1hRmtKQkZOME94a0xycFBPdElKby8v?=
 =?utf-8?B?QmNtQ0xPSjNRbTBxbTNRYkdQcVZwWUlRcGhLcThTRDlEc0lFSTFDdmNWQUkx?=
 =?utf-8?B?Nzg5MDZpQnY2a1pjUzMrdlhFNWJmb2lsYnR0eG9JNEJPMWVJd0Y5S09IRjhV?=
 =?utf-8?B?L0tzdzRPa2YyWmtEYUJ3elVHZHJHTkkralp0U2pYRVZGUXU5OGhaTWNqZHVu?=
 =?utf-8?B?SW5wOEVpd2piaFovSnZ6cC9SMmY5R0NQTmJJTi9oQUdibVlmK0hSbDNYc0tE?=
 =?utf-8?B?cEErS0ordDRLOVoza3RkVHJtZy9IZXRoNnpYTk5qYVAzRGpxQUxIRHNYUkdw?=
 =?utf-8?B?Z1VzalRNQmZKcU9wcHNvQkFLdTNzRm54cG4xaUc0NjJhZTA4bDVuQWJkZEhK?=
 =?utf-8?B?YWRlbDZHQVJacW5OWmZFV0ptR0RmUWdFNnVUNnB3WXVzL21jQ3B4NWRHTHdP?=
 =?utf-8?B?NGlnQkRkZUhvaEYybG5UU0xNV2E4bTZyK1R5VXNtQ2pzazkzZkhVeXkxZGJo?=
 =?utf-8?B?bTZCNU1BNDZ5cmFpR1dVRWdMUHBVMUF5UEsrYm1uN240TjFFR3JRZFZNYUZz?=
 =?utf-8?B?Zm0wdnJXVDQ0ek5tVWRISS9LTGROWGM0NWE0OGNoUkpJcE11S1U5TUx2akNu?=
 =?utf-8?B?L1ZGMTJWZXhmdjc0MUlveE5wNEZ0ZWk2ckM5ZGVUQjJRRTRZNEY3ak1ZWFVo?=
 =?utf-8?B?UVVJNGZZdUJpQXFjcVNSQ1o4elkvOG1CSnIxR3ltc1R1RFlQUjl6S3FoeWpJ?=
 =?utf-8?B?TFlDamU5MjJRVEpJc1JWTmx1czc0TkpMRXRydkc3ejFwS1QzTkJCUWtqaVoz?=
 =?utf-8?B?Vk45ZWlucVhzeXJXYUpDa0xtNUU2NU9yN29KZmViTjIzMm9KS0ZwMUhjZyt5?=
 =?utf-8?B?KzZBSVZSVUczd2ZzMkJSMHVoWFNqUTdpWWludkNZZjUycklZcjFDWGZ3RDFL?=
 =?utf-8?B?aXlCUzVNOGx2VWgyeFl4dHorWGRkVGl5TnR4OHp1QTZCUllWWUlDWHo2aFhJ?=
 =?utf-8?B?QjVLd1E0SE42QzZxcktlNkNsVkxISVFpMlAyZDlvUU5VeG1TTlRDYkdodWJY?=
 =?utf-8?B?VnZXZnpESW1HeThxOFE2UWZJbzcwbzR2VVM4WGMySEhvMytBckJoQTlEZS8w?=
 =?utf-8?B?RmlIRHBjNVcvbC8zbW5CSkJYbkhFbWx2RUttQmp1bzZ4enplVkFtY3RybGpT?=
 =?utf-8?B?SC9ZNUQ0cFdEdENWL1NTclBkdnRCTko1N1luUUZFOUYycGUyWjNwd0twQUJy?=
 =?utf-8?B?L0hRZ2toWEp5NjJ1bnNGY3JzWHI2bVE1Sm9uVzU5ZzNWa2ZyNWxOaC9QcGQy?=
 =?utf-8?B?QjFVcEtTRUdvcHdlUFVwQkZwZU9leVFJVlVGTGhMcVlVRWtERkJuZzBsaFBl?=
 =?utf-8?B?SVgxdS9KcENiaytoNHAwL0h5SlIzb1ViajFKODJVR0o2N2ozaHlZVTlnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkNHdWNHSzNMUHZvcTBCWUQyZSsvSk9NelI3aWhPQWZueGlpcnE3MDBaK01w?=
 =?utf-8?B?TFNaTUNGZlQ1RWsrc1V4dXlXMllEOGJ1RGxTaFhHN0Q2YnFzUWViMWZYZzhK?=
 =?utf-8?B?ZGlLcklqbVYzdm1zSUlDSWJ4UnU4bGJ3NmdKSXJKUkFGa3F6YlhKS2pxaUFm?=
 =?utf-8?B?ZXhjc01vcDhCSFNPOEw0NkRzNjc2SjVSNUIvL2NKYWxndWhweGFTZzZDdDRk?=
 =?utf-8?B?VWJCSVBqTHBNR1JjY1o5N3Bod2Vvd042R081Wjd3MnJIckNERlIxejVwUDlN?=
 =?utf-8?B?OXV3cGRpb2dUMUVxWWx4MmdWZlRZaTJrS3ZlMWJwbkJxUFgvQWxUOHhHdnpE?=
 =?utf-8?B?akJEMDRFdklROWhiME5NdTdXaHJ3L0w1aEh3Yy8ydXlNbUFyNHRib1dzd2Nu?=
 =?utf-8?B?WG1pZDVMcmY1NkNOWDFNdUthekZnSXpqYWtYckZZWjB6VmFnczBZamx2YTd3?=
 =?utf-8?B?SW5xRUR5S3VDMkdWa0dVVU1PK2x6WndnWlIxTGk5L3IyZnVtaXMrZFc5VURB?=
 =?utf-8?B?NzgraDBRa3NtakF0SXF4Y2RHTjJZcTdxdWxSN3F5SklUVVU2SzlrNzJDR0ps?=
 =?utf-8?B?aU82eENIT3RONWFHVWJWQjl1SGlqbVpJb0VVR3duZ214emhWYUhoenJaWFIz?=
 =?utf-8?B?VUZJUTJiQ3B5WnRGWnJ1Y01hbTVSdzQzRVZVUWNvZm1YNVorSzlKeXF3c1N5?=
 =?utf-8?B?ZDlQWnpBb0trOXJROW8yY3NwaWhrTFBiYzJUaFdBOXlTSEhCSkZWbENtU0hy?=
 =?utf-8?B?bnB0aGdvVll4cWEwZEhOOTlSVktOUklxQ1R4OEthYUE3aFdCb2RhWldEbzZT?=
 =?utf-8?B?dThlWktxbXR4Nno0eFZWVHVaTVVETEJiWWVjc2R4UHF5bnVhdVdyWGRCOEZH?=
 =?utf-8?B?R2Rxb2tGTnkyZ2YvT2dFcjJnVEZnRFFIVjN4S1lFQk1GTWlqbFFObnFNdEV0?=
 =?utf-8?B?dDYyZlVmZWlKV01ocE51N1hTNExxMitYZmxXTUpEMjREeUdLQWxQZ3VzWk1q?=
 =?utf-8?B?d1Q4SUpMQWFraXRwak01K3pZWlplYVIwUVU3TGlpS0ZPR0pVYlJoMWp3cENN?=
 =?utf-8?B?VHpzZVhpbDFqS1pQMC9YY0lGSDRuV0g5SGpXMmMwNkZHTWlIOUNMQ1VlYU5H?=
 =?utf-8?B?WEluNzgvWjhaZXE2RGlucUFkbUovWmtIMC85U1hDTE5CNkJsZlM2NnJyMTgv?=
 =?utf-8?B?amVTMncwWTg0ZTlXMzRla2c2eEREVnlKOXhqWnBPSkdBdGJMRCsyNFF2UG1k?=
 =?utf-8?B?SkdBNlM1R295dzl1T1RqMk1HdDFXdHNndGxZVmhDT1A0a0cydk5WZHlRbk9p?=
 =?utf-8?B?K0tOODBnd2s4a0RzMVJiOHQ3aTkvdVdvenVsdTlWUjRVSXBwY2puM3JGeVll?=
 =?utf-8?B?c0xRYVdwblBYbUd6dHVNVnd4TjgvdUJ6SFFDbkc5R0swRSs5WHhOQ3JOeFE4?=
 =?utf-8?B?ZWk0RVhOR2k3dDBjVzBYZ2FORG9HRWh4WjVZams0RlFybnRQc05OL1VFQll0?=
 =?utf-8?B?UXluSGFvRHI4aWV6ZDNwZjFJZUtmU0Z3aUh5Z05HNlFxb1BBekpXN2tRdnk2?=
 =?utf-8?B?NWVxYVFJaituZ0VlS1JuUE5FTTRtYk4wa0NxbXhtRVJFN3NUOC9NbmcyU1p5?=
 =?utf-8?B?Y3RrUitVRmtTWmx5ZHNVR0NITEhhUUtsaFB4Ty93Skg0eVRUSnNoVmZhYkV3?=
 =?utf-8?B?dm12MTA4c2NhSElYeHM3WTU1ekFQV2RrSWh3dnBFbUExZ1VCOE9CcTY1RjBa?=
 =?utf-8?B?Vlk0cUpNNzRUS1p6U1o3dGpFZUoxWUwxVlRRcDhSLzZXTnNRVVF5bUU4U3c0?=
 =?utf-8?B?c0FyZGJnLzRwZWVEUzJSWitZeFIzdjc4NVZ2NVdLRTRFRit6SkRXOGpoZTdC?=
 =?utf-8?B?YUNFZ1IyTm43WEJjNEw4dlRRbktNeU1rSi9Kcm95RTgxV3JJQkFEKzNmUmNt?=
 =?utf-8?B?YkhmV0pxTUpRYmNCb3Z5Vm50MlFqajQ4eU5GWURva25MbmFuV1lpditmZlNW?=
 =?utf-8?B?aDZYVzlxNHo0VDRzUGhDNk8zdTN0L3NnWVB1Vk1Kbi90Z0NWTFh1Z0Z4aU80?=
 =?utf-8?B?U2tTc2lqRE1sZmpYUER4anBqeU4xWW9vSy9XOUVMZWxYMDFObWFxM1FiakJs?=
 =?utf-8?B?K3JkSTdRb0QwMTFpTlU1YzFhYm1heGFacmVkc3pER1JuQWx0SU1WQ3dQNUYx?=
 =?utf-8?B?aFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6cb63fb-c5aa-4772-0259-08dced9093ea
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 03:13:59.3464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yKjhJ6HM02FzfCQ/e1LjjGJl4ieuEAtY3qgTKG7OYzE60J5uPOdk8wznPEJoue9mXdBR2dfiF5vzzdCy17yYptwGMUl9cp14CRDD/Ryhs6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8823
X-OriginatorOrg: intel.com

Hi Babu,

On 10/9/24 10:39 AM, Babu Moger wrote:
> dom_data_init() is only called during the __init sequence.
> Add __init attribute like the rest of call sequence.
> 
> While at it, pass 'struct rdt_resource' to dom_data_init() and
> dom_data_exit() which will be used for mbm counter __init and__exit
> call sequence.

This patch needs to be split. Please move fixes to beginning of series and
move the addition of the parameter to the patch where it is first used/needed.

> 
> Fixes: bd334c86b5d7 ("x86/resctrl: Add __init attribute to rdt_get_mon_l3_config()")

For this change I think the following Fixes tag would be more accurate:
Fixes: 6a445edce657 ("x86/intel_rdt/cqm: Add RDT monitoring initialization")

I think for a complete fix of the above commit it also needs to add __init
storage class to l3_mon_evt_init().

The __init storage class is also missing from rdt_get_mon_l3_config() ...
fixing that would indeed need the Fixes tag below:
Fixes: bd334c86b5d7 ("x86/resctrl: Add __init attribute to rdt_get_mon_l3_config()"

Reinette


