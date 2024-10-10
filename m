Return-Path: <linux-kernel+bounces-359402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 966DC998B05
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B01711C246A6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FBE1CBEB1;
	Thu, 10 Oct 2024 15:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QIPzFo/T"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33343D3B8;
	Thu, 10 Oct 2024 15:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572852; cv=fail; b=KDFNXggc/fMojLZzL72xWHKga3mmpDItrF3FBCGTCxn+uJee/PeUq6d8ay9/6oplR7eDE6fnkKbWm/t2KlQMMJrMO/TSJVaSBanFEqNX+VOK6ac/Mule8rLWzRuoKmpGhNZ6rEZx78hk3ayrYmGbIzbacZ/TZ01bWwF0cAgykSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572852; c=relaxed/simple;
	bh=yR7A4ylx85pKzGg9zqioPrbunxtamDpUTjchH9hDG3I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iGeJH2JoaS7hgLqMSUFvjRtsmQJ8iwmtAfx0BdeyYxu27hLrn/qN65B1KCpQwMoosDRoMzJLiOwWuprg68ytHOY05hBiWjIrqIQU3p3fdfRHFoxy93OL3EeaVqKl6IPmyyXsgPYv3k93YSD1hiCVdV6u6ovhHaZm12V3SsTKx3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QIPzFo/T; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728572851; x=1760108851;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yR7A4ylx85pKzGg9zqioPrbunxtamDpUTjchH9hDG3I=;
  b=QIPzFo/TKC+61fHRyAPEolCuBelTqFjU+WmbLNFhEaEDEf25/6Aveg3P
   HSLPEIgSouDEa3xhFTKoJwpTzWbmsOKsLkjxMtnU76OVVBQb/aMqejNbF
   pAXCEcluIAsnqabJ1eTdtlC0GvWHQ75h1yJl88DTTfo9lV0NG6xA2p/Jt
   G58HqEis1x1jLvXrdUCOY2+5Cw6Lz4gLL0/7axuU2mhap+h35WUWWfo85
   gEoCBIEUFypHntfBOq3I15o50oWdn5STgAOkWJgNeuMM9F9+ueMLXta9k
   d9V9wgUTlRnBBsQgbtqfLrxNmA6iEFQdetc+V4nnNk3bqUCGTdpkJNNTh
   Q==;
X-CSE-ConnectionGUID: lTL32WPGRyiN846ObXrWcw==
X-CSE-MsgGUID: KsAdoIqyRB+PeQFX6dqJdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="28092279"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="28092279"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 08:07:30 -0700
X-CSE-ConnectionGUID: kH21je6hRreOgYpjwvAomA==
X-CSE-MsgGUID: tbfVhVuyQqSEZwo18+piog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="80617987"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2024 08:07:29 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 08:07:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 08:07:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 10 Oct 2024 08:07:28 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Oct 2024 08:07:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k13tnOhwrXhfUepFtEyOFS0wk3DhKMj2F9V1JcVSpCXZhOw62fTpJhS+ptC0cK/D+TBWEirbW8Xv6t+v1Yxzis7qNkALIew5+QpU6UK7VtsP8a5T/AJRNdWgdxr6QMapqft64P/dk8M0R6mMATghIYEdqKHGGNDJkMX/tC0/qK1CaFqKdp0PPgMR3ArMPKvTBQoGjJNCEdWjsJjJTQicfZPCYwXtwlQBL5igp8w4k7UaHv7vfA9WBNG74AlL37lblaCB5H0RN3gTmY5k+CdtjfisS3q6G1pD8N8oNZJZcRpzSb6Mw84y5ZC4beZ01c/HGDbmYh6vq3+DepM2MzsE8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yR7A4ylx85pKzGg9zqioPrbunxtamDpUTjchH9hDG3I=;
 b=tuJEmogDuQPzdnRN72KEeMNEnlFtRp414MzEoyvPSGwF0IF/uEyhj248V2gleyzjElbwVCBqkehnFcVyISCwZQqcti8YgBQni45yLyGMImRe0YTn2Bo2B5VIr6Oz73MVQ2yNm/83jeXmjFxpvWQONR9PbpBbuKMRQquDY6YUYT8FBYiTrcf0wzxuAz9AZRc7L6R46/zuWGVuWMfcES9XqkiTeugxnn5hgt3Fqk2Lh7t4TpOFRoDzFXx+XKqXTqlXl16Z2QKmmavDjBp+WVvwOzSHE4KSrhglKp4g8jK+CpkPOvfU57cWyaT7epZXsP10V0Fj5TluuvanS4aE/9E5jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by LV3PR11MB8743.namprd11.prod.outlook.com (2603:10b6:408:20e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 15:07:24 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 15:07:24 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "babu.moger@amd.com" <babu.moger@amd.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "Yu, Fenghua" <fenghua.yu@intel.com>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "rdunlap@infradead.org"
	<rdunlap@infradead.org>, "tj@kernel.org" <tj@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "yanjiewtw@gmail.com"
	<yanjiewtw@gmail.com>, "kim.phillips@amd.com" <kim.phillips@amd.com>,
	"lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>, "seanjc@google.com"
	<seanjc@google.com>, "jmattson@google.com" <jmattson@google.com>,
	"leitao@debian.org" <leitao@debian.org>, "jpoimboe@kernel.org"
	<jpoimboe@kernel.org>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "Joseph,
 Jithu" <jithu.joseph@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "sandipan.das@amd.com"
	<sandipan.das@amd.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "peternewman@google.com"
	<peternewman@google.com>, "Wieczor-Retman, Maciej"
	<maciej.wieczor-retman@intel.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Eranian, Stephane" <eranian@google.com>,
	"james.morse@arm.com" <james.morse@arm.com>
Subject: RE: [PATCH v8 07/25] x86/resctrl: Introduce the interface to display
 monitor mode
Thread-Topic: [PATCH v8 07/25] x86/resctrl: Introduce the interface to display
 monitor mode
Thread-Index: AQHbGyRlovSriR6pykSdEbFsw5Xe4bKAFJqA
Date: Thu, 10 Oct 2024 15:07:24 +0000
Message-ID: <SJ1PR11MB6083410D8FF053823F0BF884FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <cover.1728495588.git.babu.moger@amd.com>
 <dc8ffd9074123320ceeecdc8e0b36d1ac0780e02.1728495588.git.babu.moger@amd.com>
 <ZwcG2e90vXHlIVan@agluck-desk3.sc.intel.com>
 <4da658fa-3cea-4388-86f4-d4b0fb5f0903@amd.com>
In-Reply-To: <4da658fa-3cea-4388-86f4-d4b0fb5f0903@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|LV3PR11MB8743:EE_
x-ms-office365-filtering-correlation-id: db3493d1-641f-45dd-4dcb-08dce93d3f6a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OWRPajRVMEI1VzBVSnFYbmF0b2lURGFQSmN1eWRJbkZCVnZiUjdxc0hvZzF6?=
 =?utf-8?B?bUtrUnhOR1F0Y2JWdy9BMzdTaVgzVkpXRm1UQjc1c09Ta2JjR3lQVWtqN0Fo?=
 =?utf-8?B?emQyOFZyaWNOQ2VyWU84a3pmd0RJMGZKNkZQTHNXWG1ZczZQTFh0bXdUeFNU?=
 =?utf-8?B?SUpWb3Y3REsyVnMvNlV6OGF3a1hmTThDZWY2dGxJazJoVzRDSFBkKzllaFAv?=
 =?utf-8?B?eU5iZVBCUXRpaW5lQVV0ZGo1QmNRWDJPNkVmYTQvUXVZR2dEUHlMYWpIb1pC?=
 =?utf-8?B?NmgrNTY2YWJtT1NwU21ycnVyVGxFRjFRYnNCMSsvN2lKN2xkSXhybDdRbWhT?=
 =?utf-8?B?WmpuanZ2alFVd1NYV2FCaTBPakxRNytUeVdSK0Ixc0hLMWFhVmhueHJaa05Y?=
 =?utf-8?B?NFQ0aXYwMW1jVjF3T3lsa1dGWGk2QzAxVlJqaFFZM0tXNk5ZZlFYdDNicGtp?=
 =?utf-8?B?RGR2Y0Q5ZWNscGN0Q053ejRZMlpQUWlJUGVzRUptQXpZY1I5K1ZrYjN6NEZR?=
 =?utf-8?B?dkQxMGRTc3BkNjNxWURvdC9xL1BrVVR4NUFJRTM4bWN1cWJna2ErSmxxcGxp?=
 =?utf-8?B?OE94YkJtdENubVZVeC9peExtanpnS21CZUE2alpBcnFraW93VzdUNG5GWU03?=
 =?utf-8?B?Rk1KdnkxK0FReEJEc1RSenNCTEZjTUhWU3ducTZFQklHMUNtVm1yUUtjMlJn?=
 =?utf-8?B?S04yZE9PNGFSYWk0MjV3U01EalhoeWpHQXdHSkNEb0d6SkdlOU9vZGZZU3FF?=
 =?utf-8?B?bEFKNkladWlvK1kxOEp5Nm5hTDY1eDFnODBadTRKb3QreUpXNWFVaWpZUmNN?=
 =?utf-8?B?RHpzK2tNclB0UzdBa21CNkNtOFR4bnlyUUtIdVV6VUduSUpDVzdoZzVjdlQw?=
 =?utf-8?B?ZkZVdmR5VzA3T0J6QmlRQTFwa000YzA2QUN3UFdITTJWZUNma1ppUUFKdThJ?=
 =?utf-8?B?ODkzcjJQaGs1OTlNRmtWRGtZdkpuSUYvYy8rVUR4bk8vMSsrTk5ZUVQwRk5G?=
 =?utf-8?B?VkwydVZjOGxxM0t4bnU5Mk5GTnJtUHExdkwvVThJbklKdWtlZFBqeWt1MWhu?=
 =?utf-8?B?NkNBMDJPNW1QcDdwb2dvU1BqUE5pY2dXcFpnTktxUWlOa0VCaTE2Vm9iK3JO?=
 =?utf-8?B?MjFtSFlCRGM5MUp3a1BjbER5d1lNa2dXRUZkem5ZanU5UUVJczlxVjFRRTVs?=
 =?utf-8?B?WlpZdzFSeXdtaHIxODcwOXdOQUpiak1uV05IYlVDajRUMFI4OXhvb0ZMUlRQ?=
 =?utf-8?B?dEFSVWYxVzhlcjlKN2x6aWtiamwxbGZIYnFOVDdyOVlSMy9RYWF6VzBuZkJt?=
 =?utf-8?B?OGd1QjBBT0JXenVsUFlsNmRaTUcrbXoxOGxJZXJFaHRPZW9ZZGlXdzB4MkVI?=
 =?utf-8?B?Z1VzMTE2bEpkbDVxcVBYd2dtM1d3eFBXckNTVzN0cERpZFcvRHpSRzIzTUc3?=
 =?utf-8?B?UnB6cmpmSmJLVEt6aVVEVlExTHNOdG5xSjlFaU54V2E0OWZ4cWYxYUtXOVVX?=
 =?utf-8?B?UXNlZWx0WjZrNDJuYms1TGhOVzdTeDhEQjZ2bmlHRk9sUVNEdTJyblNqMlR4?=
 =?utf-8?B?dnpPbG50eUMybEhPSGRNemg4L2dKTk9malA1TVQ0STFVUXdLeTdGNzNTQTY4?=
 =?utf-8?B?Vy9INllGZzdxTTVKNUZNWUpJZ2xhT1BSUXdXL0VTSms5WjZMb0duK01VdHJG?=
 =?utf-8?B?N1lCaVlnSEVKVEtuUFE3N0VpTElWY0dLaG5EV0thYnVXZ1V0KzVhQmoveFdm?=
 =?utf-8?B?TTlVYk9vV1dFSTk3dnVlUzZKdnR4WmdqRWw3UDFsSCtjR1RMdmwxWGN0alZV?=
 =?utf-8?B?WFJwczlQUHpDSW95VkxIZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHFleFJydGoyZ1hVZElsTVFxMXdYaFJIOXJQTjUwYmdQTHBRd0dzaTVndDlP?=
 =?utf-8?B?R2RwUUFFSFNSZEg3VGl0UXpzbUswbjduZzVueGs0R3JFNS85UDg4UjYrMWRa?=
 =?utf-8?B?SG85S3BPOXNjQ2dkY3VyVUpMa3JHeWRhT05JTEJyU2hBUlREdStuYldWNTlO?=
 =?utf-8?B?eFBKU0J6K0xpYno1RitRekNwbkpxd09XYmhkbHlEQjh2MlRKV0o5UHVpenBn?=
 =?utf-8?B?M0t0eFd6L0VIMWFLbnRtVGRoMURUOEl3dHQ0NUJRVURwVndvb21nUW5SSjQ3?=
 =?utf-8?B?U1h2UHZSMVBJS000ek0zYjZnT0lQbXduazdscHNXTGRKSFBKQTlnSHcvQjJy?=
 =?utf-8?B?b0ZReGZhWkFPbW5vV0FOTDRVK1BoVXY0bHhIMVRaWWl0a05KTGk0TFBRYWN1?=
 =?utf-8?B?cVdBMGN5RDB4QlkzZ0Q3bExaOUhIcDg2MGMwY01GdElZaU80UHVSaTVXZ1U4?=
 =?utf-8?B?NzRtZTJleFBvWFVBdVVJNndnUFYwaHUxb3Fpd2NlbWlvNUdRSHFSOWZKSUt0?=
 =?utf-8?B?VnNIdENWL0xFNXhqZkpaM0dCQk95TitmTzBDR1hmR1czM1V4a3FSMlpoQWRh?=
 =?utf-8?B?a1YwOHNrclhhemFPTUpWV2hTRERwMnQ5czFoN3pNSFlvUTlzY3RuZm91c25u?=
 =?utf-8?B?bGlKSkpZbWFNUkVva290QkQzMkcwTGo5TW1mTTVHNlY4RkpMRGM3aTh4dU5R?=
 =?utf-8?B?aVdSSDJVNGo2OHlUbS9acmJYUHFQYXIzQi82dy9DZVhSY1BZSmIxYmptenJJ?=
 =?utf-8?B?a2g3ME8wcjJZSkxZUlFhVmh1NjVFd3h1S2pSNHFBbk0yalVPcDE5cVluUjd5?=
 =?utf-8?B?VVQ3WGk3dnd5N0FJUnNhNW85ODFLdm9XYTRCaVdGVGwzTCtDMWdZZHVCNWh5?=
 =?utf-8?B?ZzlNb3hqUE5GZEVaS0RQQmVZZDl3VEZLRzY2c0pDNkF3Z0JMazgybm15bnMr?=
 =?utf-8?B?SEIwQjFmWjBjLzlCelhKdkZVYmovcUl5RUtPcXdZMXBaNDlOY3lHNlBUUGRH?=
 =?utf-8?B?WDFTVEVTMlNSVTlSVzMxc0lYZUNyaHBYall5VkR1QSs0VzdCWVFUazAzbEQw?=
 =?utf-8?B?aDA2ZUt4M3F5NDQzK1YvNFJnUDJLam9sY0liZnczekMyMGxleVl5QmQ4WnU4?=
 =?utf-8?B?QnlkUWNhNFFKS1hBNVpqRVF5NHIvY1I4bHY0NU1OMThBQWVySTNxNHRrcWx3?=
 =?utf-8?B?Y000M002Nm9Dc0ovYUFyNk5EeFhKWjNldUJhY0UyMnNJK3lZUjAzamhVZjZo?=
 =?utf-8?B?U0Z5NjQ4bmxSbnRjUHdURHlNRGRxRUdtMHhDT3diQTRSZ2F6MUk0bTV2c2xL?=
 =?utf-8?B?bE9Eb3laR1ZpSzdJd2Y0UHJTN0N0WUUyZ0hNbGF3SlhwZjVrTGFSK0dkclcw?=
 =?utf-8?B?TXJrNmQzb3VzRkJGaVpsY0ZaYkwyWHhhTXgya2wzOEtSQ2dic0NobUZITTMz?=
 =?utf-8?B?T0J5U0dJVllvYUtrb3phdCtrWG4zejJuZ2R0QStOKytsNUorYnhrRGlMUTA0?=
 =?utf-8?B?eUlNTG9ZbE1URlpidE91bTd5QTFHSEtjVWZxVHNYQnloT2Qrelk0Z1YyS0M1?=
 =?utf-8?B?cmtnM0xxQTYzSVE1ZUhXTDlXZy94SW56NVVBOWllVjUvZGlSK0JoZ21WVjBl?=
 =?utf-8?B?bkVmODVvS2NRSUYvWXpMeU9xbGlwWmZIcjEwOW5CT3M3bFR2SlkwKzBSOWxC?=
 =?utf-8?B?ZW80QXZkQkI3cGJ2VTA0M3lFbHZ2cFBkT2VMZ2VTa0ltcXBkQ0p3c2FJK0RM?=
 =?utf-8?B?MnpTQTZ2dkNjSE5ER0plWm12djRMSk5jTk01Zm1SMkFKTDl6ZjVNSTRIM0Q1?=
 =?utf-8?B?MXRhTTd3WjZsU0tYUjlYc2h2YUI1NWZvSWs2L0NiRVkrTHlZcFV2aTlZNFUy?=
 =?utf-8?B?SCtBQ0VZL290bncxYTh0OUN0dE4xdnBoRmQ2cHFmY2VTTVc2Y3NRbnhpUnNi?=
 =?utf-8?B?aFg2ZTl3a2VlcE92dXc4UngzL2Fsci9HdXAzMHFmSG5VR1V2R2w2VUJHWmh6?=
 =?utf-8?B?aGZwVzRDR2ZxeWVBcTdQUStWMVJkYVVUMERIcXdWK0dGbVlJQ3lnTjdRSzRt?=
 =?utf-8?B?Sk9oWnJjek5QbUt3YWdlVVFDU1IvNU9GYlZzTnJmUnhNYm0xNjl2M0lueU12?=
 =?utf-8?Q?I5rMCmxqzDfqRPW9TQ3+85/pa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3493d1-641f-45dd-4dcb-08dce93d3f6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 15:07:24.5631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5TXS/KTCzQaG4QZS/RuUy4IeKEA4nuaur0bkR6UPfENdFsl3nDJyjcUerkg2aHCc1LSKIA3O5qw+ET5MRihdFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8743
X-OriginatorOrg: intel.com

PiA+PiArICBCeSBkZWZhdWx0IHJlc2N0cmwgYXNzdW1lcyBlYWNoIGNvbnRyb2wgYW5kIG1vbml0
b3IgZ3JvdXAgaGFzIGEgaGFyZHdhcmUNCj4gPj4gKyAgY291bnRlci4gSGFyZHdhcmUgdGhhdCBk
b2VzIG5vdCBzdXBwb3J0ICdtYm1fY250cl9hc3NpZ24nIG1vZGUgd2lsbCBzdGlsbA0KPiA+PiAr
ICBhbGxvdyBtb3JlIGNvbnRyb2wgb3IgbW9uaXRvciBncm91cHMgdGhhbiAnbnVtX3JtaWRzJyB0
byBiZSBjcmVhdGVkLiBJbg0KPiA+DQo+ID4gU2hvdWxkIHRoYXQgYmUgcy9udW1fcm1pZHMvbnVt
X21ibV9jbnRycy8gPw0KPg0KPiBJdCBpcyBhY3R1YWxseSBudW1fcm1pZHMgaGVyZSBhcyBpbiBk
ZWZhdWx0IG1vZGUsIG51bV9ybWlkX2NudHJzIGFyZSBub3QNCj4gYXZhaWxhYmxlLg0KDQpCYWJ1
LA0KDQpUaGUgY29kZSBpc24ndCB3b3JraW5nIHRoYXQgd2F5IGZvciBtZS4gSSBidWlsdCAmIGJv
b3RlZC4gU2luY2UgSSdtIG9uDQphbiBJbnRlbCBtYWNoaW5lIHdpdGhvdXQgQUJNQyBJJ20gaW4g
ImRlZmF1bHQiIG1vZGUuIEJ1dCBJIGNhbid0IG1ha2UNCm1vcmUgbW9uaXRvciBncm91cHMgdGhh
dCBudW1fcm1pZHMuDQoNCi1Ub255DQo=

