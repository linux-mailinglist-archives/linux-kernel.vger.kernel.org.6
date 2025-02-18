Return-Path: <linux-kernel+bounces-519892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA95A3A339
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 507487A1A28
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C9D26F45A;
	Tue, 18 Feb 2025 16:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dZUCYjwa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9D226B2BE;
	Tue, 18 Feb 2025 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739897543; cv=fail; b=sjxMulpOREim5ELyNR4fxPO2tLi0EEOFXhEiXht3HOThrIPE5V9R5aEQlrE7TSqKZP0B8IpDwkBG4I1tGy1k8YVhoijT2TZL6DIqEDivfVAmXFE1XzQXul5mmJdTSG+7YXsHl9Ac8vG2LVMrDcDztjowQ+JowrXhybJKC6V7ygI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739897543; c=relaxed/simple;
	bh=/9zJVRvJCCZdxbgMvYxB7Lyuyb6oTvFOtYhGsr2CGKM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YbAUCf8Q9UAPpZTlAdOPtkWcVl0D+PpH+KymtZ7xALuSleATPCbfO790USSo8Jy1qqF8raJhj1KISc7rhFndOSrBt8LZGkUn88sGcanBrblK0vKuLPCZiXZpIZnnwxY51gVf+ZDubkcSQfuKV/z9e6If2CNRDy1wL3QHO+ErIEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dZUCYjwa; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739897542; x=1771433542;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/9zJVRvJCCZdxbgMvYxB7Lyuyb6oTvFOtYhGsr2CGKM=;
  b=dZUCYjwaExV7DXhJKG3ynwFIm4hhhX0MfFU08D+aH9cOpLN7Xnn6o4t0
   /dKiCNn6lrJZn6lSCLrb736tFfu41Ti8bhSyq/QMc60VeF0hOMZ/AVTf5
   7K9oZ6Cjsfkc/EKJr1I3Xs+4XaD4wEM1mlFGw9qbNwUaf4YoU2L67+3j4
   ll4La10XjN3BpAwC4to/5k6A2GTABhBtG2xmvzqVIdksYV68VHxDAed2q
   YV9cKndmIBNjmO01yd7s41mIue3sEnrjCrNmdN3GC2sUydEPfLjTc0QDY
   Fcb1Jd/83OV1uNSBaH8WpobQrgQLxJoIeqkNDjSChgWGiOyVjIJk33UC6
   A==;
X-CSE-ConnectionGUID: HcAol3anRZabqxlYXhvpDw==
X-CSE-MsgGUID: CvZxK1jmTaa6FP3Ja7ASqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51246315"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="51246315"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 08:52:21 -0800
X-CSE-ConnectionGUID: v083kZzQTSO6Skz9px1e0w==
X-CSE-MsgGUID: zeNcvs1YRGCXWPw3Ti3Piw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119093011"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Feb 2025 08:52:20 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 18 Feb 2025 08:51:30 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 18 Feb 2025 08:51:30 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 08:51:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQmdE8I7SdezpwskxHuEthQPan2frIIk24+oCOweHeffiGy4CyLlqEwQ9PAXmJABtoGYGwJ97KmwsVQY8UQ3mcsXlPeaFGeKzCOfoebJecW/AQnMhcROtxJyt3Cs03jP3CE5xLQYXRu0Ao6jZugEgpaBRSeuBgIG6C+jTNBvqzIzSvZflFtstjP60cXRKJXz/7CRPBerK3JrlONFPii0YDUw5yzVcbqSHtB90s1aX3OLiS6rrm7vXpuhCfcOrpi5YiEgnM3x561NyGKwFKDp1QxVqghp04oyZF008xKM3/xQ1fLWriHOv6Aw9s7UsMfFd6uU3/6OLFuxG775heHrKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9zJVRvJCCZdxbgMvYxB7Lyuyb6oTvFOtYhGsr2CGKM=;
 b=Z0QHQrW+vs0XLCWHSigQfM78BxMvDtChw4MQ/EKk+jWmc8fVd6DBxnsakhBPrbL8G8+UpRaF2u28UP6fgLlHrtmC+Bv5xK/Gm4L3lDKwefGtaPLo7u4bfnL7zeFXFJ6GyAnMA0isA7mN9xQ2gBlVBC9jlSPLqNNj9VZOLJVKGrfujy6Pikmhx0fEiEQBDOS/GKcuof54MTODOtuAnAvZnDdAUHG80xxXSb+hqRPhYE7lPvJodWOzfqssLcArb/vsyrKYmGbWzCXja9LLrOl7gjQcWIh8MkprqGTu1aUjTtFuBG1qFHT9XgRNEpdGYgxLLycULnJWJoGc0iJkeg2Xhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA1PR11MB7085.namprd11.prod.outlook.com (2603:10b6:806:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 16:51:22 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 16:51:22 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "babu.moger@amd.com" <babu.moger@amd.com>, Peter Newman
	<peternewman@google.com>, "Chatre, Reinette" <reinette.chatre@intel.com>
CC: "Moger, Babu" <bmoger@amd.com>, Dave Martin <Dave.Martin@arm.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "tglx@linutronix.de" <tglx@linutronix.de>,
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
Subject: RE: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Thread-Topic: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Thread-Index: AQHbbQsur7YXoEmn/USrZUfWgYnla7NEEeSAgABhEoCAAS7BgIAA1twAgADKhwCAAA0qgIAEIo4AgABpy4CAAZG4gA==
Date: Tue, 18 Feb 2025 16:51:22 +0000
Message-ID: <SJ1PR11MB608314CFF36D167483859044FCFA2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <Z6zeXby8ajh0ax6i@e133380.arm.com>
 <9e849476-7c4b-478b-bd2a-185024def3a3@intel.com>
 <Z64tw2NbJXbKpLrH@e133380.arm.com>
 <76b02daf-1b45-473e-9d75-5988a11c6887@intel.com>
 <8ef51f28-e01a-4a7d-ba86-059437edb60b@amd.com>
 <a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com>
 <CALPaoCh7WpohzpXhSAbumjSZBv1_+1bXON7_V1pwG4bdEBr52Q@mail.gmail.com>
 <bdb48b29-92cf-4f98-b375-25ec84f0941a@amd.com>
In-Reply-To: <bdb48b29-92cf-4f98-b375-25ec84f0941a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA1PR11MB7085:EE_
x-ms-office365-filtering-correlation-id: 9fadc4da-835c-49fe-84cf-08dd503c796e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dGE0Yk1WMHlEU054YzgrRFV5V0hIQlozVm56M0dCOGttUkFHekx6OG5TVE1q?=
 =?utf-8?B?TlgzMnVPWWJaSFFTNjNUQ05rZlcxVkNZR3JGL3prNXg5LzZQVTFRbTlaUTJB?=
 =?utf-8?B?a0tRTmVBY1ZJTTRhbVpZYXNPRmw1T1JQZTEvR2ZocFlJL0pKanBoM2NNYy9R?=
 =?utf-8?B?VElDTDdKcDVDQmlDUEUvTlRQYVZWdm9hb3FyYkdFdFpsQjFNUEc5RHgyVFg0?=
 =?utf-8?B?Q011RVNZYnNQcXRnbWVNaStYVWpJcmE0R0NzLzFpQnFvSjJsdTZRQUR4azYr?=
 =?utf-8?B?eGtNZTM1ZWRIZlAybE9DZ0NQSjlPVXJvR0ZPb1VmSU85MzJqVHhkUE9PUVhp?=
 =?utf-8?B?aE54enlsSGxqNElxdFNQMW8rUmlXR05lQ2k1TzBCdktnNUs5NzVaVkJjcjJy?=
 =?utf-8?B?citZd2JuUzZTOW42NnhzL3gwalN6dnkzdU9ZMlc0dlJSVXJBVElRbUVGMkI2?=
 =?utf-8?B?VktXd0c5cDFUWUYrSHlodU9yRHRLbzRKRm13SStVQ2gvK1VlK0g1YmNnaktQ?=
 =?utf-8?B?S1dnMDVxbFFpK0ZlSXc2eDV1U0o3VUVlUlEyRWU3dXAwcGkwRjEvL1pyb0xO?=
 =?utf-8?B?WS9qQ0h5bnYrOXdKVm5UeUVhN1BUMThGTmc4cnRXUUM1T0lndWpnVmJpMHp4?=
 =?utf-8?B?Qk1OcTJyREZQS1F6WlFMQ0V5OWJVN2hkNlI5TVlLT3hsdUZqdGFxc3crMDc3?=
 =?utf-8?B?bmROYllBd2pUSXB0K2ZwY3ZtZG1nYWdtSlE5V0dZMVN5cXNwNkdIQ2hPb01z?=
 =?utf-8?B?V0YxOEdnWitJVmhLRmcrcGc3Z1R4MlJ6aktpMG9oa3EwclNqb2NaNVdGUDhV?=
 =?utf-8?B?c3dUMXhleWoxY3p5UGcyUyszWmNxTDAwRFlFRGUvMU12bHJLVmVOa0RLUVlh?=
 =?utf-8?B?YnRKKzBZR0prWExnR0hCR1BRNnBZZ0JkdklHWDFQL21OWk1GR1lvRjh6elNv?=
 =?utf-8?B?d2tzZW84ZmJ3dDBBUU1BZWtWRTVKSTR1TldzYStVcUVROGdWcldSeitkQjl0?=
 =?utf-8?B?S1NPajNOOE1QYW04RmFqTVZQMlE2QUVsSGNCdlJqclFCRlBhUGdKU21od0Z5?=
 =?utf-8?B?TkRqR1NuSTlsZCs0cCtVNGxnb05Benh2V2lsZFlDOXpERW93L0dSZVdscVlP?=
 =?utf-8?B?TGhLMWxTbzNKQXdJWEtDZWtrU3ZuaktCNXBpbTVvQ0lBTmNNeFFHRUtxTW9n?=
 =?utf-8?B?cjNzZVRyUVc5OHpBU2JkbVdHeDg5ajllOW1GZTNIZzRnVHdaMENxY1NQNkwx?=
 =?utf-8?B?UUQ4aXVhKzVacXd3cUFZWmxWTk9TeEZrWkFkUGdZMSsrV2lXUU00enhXR0lq?=
 =?utf-8?B?bU1QaDVwWjhSQmZSZkZDQTAxeGo4NzJiOFYxSHRieXlkS21IY2ZvaDNCMXdW?=
 =?utf-8?B?YmJQWHRXL0ZrVVphQ1RHUkJSNlF5dEhjN0Yxa2JBU2Fja2Q0b3NYVkoxZzVS?=
 =?utf-8?B?aG1NSytwenVkejRiVFk1WXd1VTlwazhIMCtBRURZVTYrWUk2QVNaY0lVdHZw?=
 =?utf-8?B?Nk1vMXVvdEJuMzhqN3AxSHAzWTE3ellLVmNJQmpob0grOUI5aXZyMHZUSEll?=
 =?utf-8?B?YjhCbFdOQ0w1VDh6QVZvRXltZzlRd2djSjEzdkErYUdiVjlqcStrZStMelh1?=
 =?utf-8?B?QU1ZTG1qWTV6N2E2ZUxnV3l5SkJqM2JmWVl3UmNWdWJLQmpRVlU5UFVDSmsx?=
 =?utf-8?B?WGM1SWhjMWJaRlFZQUJDQWdKYk1sdmViQWhSQXBLczNGYUd0NXpWV1lsZnFx?=
 =?utf-8?B?aTZFN2xoaWlBdzhxM3podDE4bXVWb1NMLzNEMG40RHp6ZWE2czdOVjdtUStO?=
 =?utf-8?B?SnBGS3JMOWRvYnEvNDROYVBvVDJSUFRadDFCTTBDOUpOWmowT0pGUW5BMUxY?=
 =?utf-8?B?L01OS1JYS2RVVFE4K3Z0QmlpbEFZemV4cGkrVDl0UzlhUmY4VjEzN3I4enZu?=
 =?utf-8?Q?7FH5uP6XWSycRhG2Ruw9rzgQIsDJy4zp?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEZaMVZoNEI1UzI3WkZ0TVBwSTR2ZkZ5RWZNRGJlL2JCS0orSWhydGxSSm1s?=
 =?utf-8?B?T1N4bUorV0thYlBabzNPMzQ2bUREM0hqbHAyUFJ6RTVNbXdHcDFBdDNkYXp5?=
 =?utf-8?B?MWdVekpUb3FYaGU4VW8zdkZEMzJGTS9ubm1VYmFpc0RyN09Cb1lwK3lubm9B?=
 =?utf-8?B?WktlSVNuTjhpUnFEZXZsUEljaFEySDR5MHRMOVFyTVlqOXdxYy9NNUd2TWRL?=
 =?utf-8?B?K2dPNWJ2OWlXc1ZzMkxFMkVibnZmUDRRSmEwdmp5OEp0bkR3Sm8wMGNPdHpu?=
 =?utf-8?B?K0tMVEl1MUlLZ0pHSzd2cjJPeGpqdy9jdFlpeFpyYmlMQkNMM2E0SG9pbFl0?=
 =?utf-8?B?S3dWd1pKZWhhM0U4eDc3WE9xNEdWRE1id2NIR0xNWDE5cXFGcnJUZmxYbHNs?=
 =?utf-8?B?cFJTWEhVSHBTZkVNbHpzNXhyeXkvejZjcWdWZGFOY2h4ZWk4UzBoTTZMamFo?=
 =?utf-8?B?Z3UzREV4bFEvZUw0ZU5SOE5tcExPY2lobG92dnYxZjNocW5uV0Z3UWhBODNW?=
 =?utf-8?B?R1JNMmVSQnRSUE5nYlpsVEJVeE9jdEkydVBTeGZSS0FnUFBRZy9vOFFDY2Fz?=
 =?utf-8?B?cFpPc0tZL3l2QzZWQXArempvcC9MRDk1NVRORjRIS0YwaThOdkdkYVovNHZV?=
 =?utf-8?B?SE0zMDJzenM3UnJFanl6RkZoSTFZdWc3V3RCeUNnZzBJcW5XVG81WjYrYzhH?=
 =?utf-8?B?dG5QVk1mVVRraGdCMlVuWEJZTWpsMDFuZ3ZxNjVQUlhScENwUG5lRmtPeXJp?=
 =?utf-8?B?cXhPSjg0MDFIbEovUWFkRXhMK3hVYVdUOUVkcGtKTmd5SlVzcGtWSmhIZmh3?=
 =?utf-8?B?K05TdkY4WE1GVFkrOHA1Tmg0TFBTSmtnb0hpUEw2d0JyeHZpdUYyajdlOEdG?=
 =?utf-8?B?VlR4V3JzcnEwaWU4UHkrSXFKZEJZOS8vempFT011K1RsSjFsTVplVFBvdDFp?=
 =?utf-8?B?ajF5YWZwdGk4ZS9vNlpENTMwUTZYMG5kTmw5dHhHUnViQ2ZrbjlvN3JRdDM5?=
 =?utf-8?B?RTNmNWsveUxQWmhjMzQxUHFhZ3Eya3hOVVJwN1JZZDZncEZYVk9IYmtnRGli?=
 =?utf-8?B?Z2IxN3JEMndIcU42QlZ6bDJWcktyaUdvT3NvVEgrNDc0SVVVNXA2amtvSi9D?=
 =?utf-8?B?cnVsakQzODFDRlRHUXI3ODhFWWNaUkl1anpqK2UxRHEwWlRaSkpKVVQwaDMw?=
 =?utf-8?B?RmpWUkswbldVVXJDS0tIUzRzNHA2TmowWU5vRGJGSnIrbURmYU11L1Y2ZU9p?=
 =?utf-8?B?eUxaRXhYNnlsK3VuUE5SOCtneEN0anlsbGpmZEVJeEtxS3daVHg5STBHcWJa?=
 =?utf-8?B?elRDTys2WS9WSndINjhrUGg3ZXU0bk1LaHRtQjVkK3FWcEkvWkttT3BxL2Iv?=
 =?utf-8?B?dGlnWmlFMjFOZWxZZTFZK1FUR0dHTDBhR1dKWVVQOWRXekRHU2s2UDZoZFJn?=
 =?utf-8?B?YWNZUUNwWHdnT056U1dNdkYrT2h2NmFMdElwakR2TDBWeVZBMStyVXBBUFJq?=
 =?utf-8?B?UTQ1YkVxY3dSeDJBQVRpNTJhOEh5dVpySXlKUjR1bm5HU2g5OXp0d3RPeVEy?=
 =?utf-8?B?T09lbDg5RDVDeXZCUmU4V3cxeHJsdVNvRHRGS1FSSlh4dUFmTXdxMEJ1L0Ux?=
 =?utf-8?B?MTVETnZHQzA0ZWoveThOSm5hOFE1aWZ1UGhvUEt2c2RudjhKdk5Sa2pFc01G?=
 =?utf-8?B?cjVQMTI2SDB6YTk1MVpZL1hFR0JxS2NBSEdXY3JtU0FQWU9WcVZROVduZnBW?=
 =?utf-8?B?eFN3T1A2dFpUN3RoSkpMSHA3aU95QlNkby9kbW9iTzBWaTVtTEs2eWQrbUdB?=
 =?utf-8?B?MjNDV2pFNXZwRk85OVZrSEM4NVFOQktibGQwSjVDTGd0RWF6K29zdFZDSjhR?=
 =?utf-8?B?RU1kMFAvcTRsYVFCdlpTYkxQZzdySXpUeFA5UTJ2M1Q5Q1BFNTV6UFo4bjJJ?=
 =?utf-8?B?Tkc4SFlqWjlaZmR2Y0RCcGh0Rzlpci9PUXN1TnAxZkFxZE5OL011bTNDelVY?=
 =?utf-8?B?dklPOG1qbThBTVFRTlZFRWN6SDUxbjZ1Z0JSd2ZweFlwOGthcFlNT0pIU0d2?=
 =?utf-8?B?d29ZZUx2ZmRqN1hKbXZIZzRzbFM5ZjRYbmJjRVg2WkNQWXhxOUZMYW16RFFF?=
 =?utf-8?Q?FrTq81g8k1ALoMSBxMPElJ0rd?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fadc4da-835c-49fe-84cf-08dd503c796e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 16:51:22.1600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JwwaUtBsku+CwlNSX74tKSHgBG1rfznEK/ySe0yxqxojF8Xtt5P6E+Y9zM5Y/Ph4Czh6hcjH3kl5EGJIe3B4VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7085
X-OriginatorOrg: intel.com

PiBCYXNlZCBvbiB0aGUgZGlzY3Vzc2lvbiBzbyBmYXIsIGl0IGZlbHQgbGlrZSBpdCBpcyBub3Qg
YSBncm91cCBsZXZlbA0KPiBicmVha2Rvd24uIEl0IGlzIGtpbmQgb2YgZ2xvYmFsIGxldmVsIGJy
ZWFrZG93bi4gSSBjb3VsZCBiZSB3cm9uZyBoZXJlLg0KPg0KPiBNeSB1bmRlcnN0YW5kaW5nIHNv
IGZhciwgTVBBTSBoYXMgYSBudW1iZXIgb2YgZ2xvYmFsIGNvdW50ZXJzLiBJdCBjYW4gYmUNCj4g
YXNzaWduZWQgdG8gYW55IGRvbWFpbiBpbiB0aGUgc3lzdGVtIGFuZCBtb25pdG9yIGV2ZW50cy4N
Cj4NCj4gVGhleSBhbHNvIGhhdmUgYSB3YXkgdG8gY29uZmlndXJlIHRoZSBldmVudHMgKHJlYWQs
IHdyaXRlIG9yIGJvdGgpLg0KPg0KPiBCb3RoIHRoZXNlIGZlYXR1cmUgYXJlIGlubGluZSB3aXRo
IGN1cnJlbnQgcmVzY3RybCBpbXBsZW1lbnRhdGlvbiBhbmQgY2FuDQo+IGJlIGVhc2lseSBhZGFw
dGVkLg0KPg0KPiBPbmUgdGhpbmcgSSBhbSBub3QgY2xlYXIgd2h5IE1QQU0gaW1wbGVtZW50YXRp
b24gcGxhbnMgdG8gY3JlYXRlIHNlcGFyYXRlDQo+IGZpbGVzKGR5bmFtaWNhbGx5KSBpbiAvc3lz
L2ZzL3Jlc2N0cmwvaW5mby9MM19NT04vIGRpcmVjdG9yeSB0byByZWFkIHRoZQ0KPiBldmVudHMu
IFdlIGFscmVhZHkgaGF2ZSBmaWxlcyBpbiBlYWNoIGdyb3VwIHRvIHJlYWQgdGhlIGV2ZW50cy4N
Cj4NCj4gIyBscyAtbCAvc3lzL2ZzL3Jlc2N0cmwvbW9uX2RhdGEvbW9uX0wzXzAwLw0KPiB0b3Rh
bCAwDQo+IC1yLS1yLS1yLS0uIDEgcm9vdCByb290IDAgRmViIDE3IDA4OjE2IGxsY19vY2N1cGFu
Y3kNCj4gLXItLXItLXItLS4gMSByb290IHJvb3QgMCBGZWIgMTcgMDg6MTYgbWJtX2xvY2FsX2J5
dGVzDQo+IC1yLS1yLS1yLS0uIDEgcm9vdCByb290IDAgRmViIDE3IDA4OjE2IG1ibV90b3RhbF9i
eXRlcw0KDQpJdCB3b3VsZCBiZSBuaWNlIGlmIHRoZSBmaWxlbmFtZXMgaGVyZSByZWZsZWN0ZWQg
dGhlIHJlY29uZmlndXJlZA0KZXZlbnRzLiBGcm9tIHdoYXQgSSBjYW4gdGVsbCBvbiBBTUQgd2l0
aCBCTUVDIGl0IGlzIHBvc3NpYmxlIHRvIGNoYW5nZSB0aGUNCnVuZGVybHlpbmcgZXZlbnRzIHNv
IHRoYXQgbG9jYWwgYi93IGlzIHJlcG9ydGVkIGluIHRoZSBtYm1fdG90YWxfYnl0ZXMNCmZpbGUs
IGFuZCB2aWNlIHZlcnNhLiBPciBhbiBldmVudCBsaWtlOg0KDQogICA2ICAgICAgIERpcnR5IFZp
Y3RpbXMgZnJvbSB0aGUgUU9TIGRvbWFpbiB0byBhbGwgdHlwZXMgb2YgbWVtb3J5DQoNCmlzIGNv
dW50ZWQuDQoNClRob3VnaCBtYXliZSB3ZSdkIG5lZWQgdG8gY3JlYXRlIGEgbG90IG9mIGZpbGVu
YW1lcyBmb3IgdGhlIDIqKjYNCmNvbWJpbmF0aW9ucyBvZiBiaXRzLg0KDQotVG9ueQ0K

