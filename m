Return-Path: <linux-kernel+bounces-359516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AC3998DCB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDEDEB3D2E8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC38C1CC8A8;
	Thu, 10 Oct 2024 15:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RqDb6GXe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C041C3F34;
	Thu, 10 Oct 2024 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575912; cv=fail; b=GKJKLjkce8I0YO1mmOwYSZGOfeixJZVfeARfZ5K7zS5vQlImtnbvS3za/LD4y6u49Nxjmuchxk49CiAMIxGhPJkGK3lj2OqK1q5kwe576nvOELXkQK/PsiFackaFXPO9Zb52KCOr0srK7sAa9OZ1RPEvRqljiH7yVILp6LplEvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575912; c=relaxed/simple;
	bh=Aow6ckO2zsXzJa9Ucy/2F9/YTuMBgYrp/NxnwjLbsp4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k/Wv6uyxQ+Npm8Cpuh0JbjVBq83NKIYJo3r2ZqqnzrbVJ8tEOtgUal55GhJCNKCX3zqzodgXOGF+0vvgD1ddaEv9lgUPOnYsCjJ6o5D7P/OpcgJfELp3Xb1MUU3X4NJ2YLSqCXNZWVIwBDqxZmK/nei7mGl3MH5Y71WYcgWqEjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RqDb6GXe; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728575911; x=1760111911;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Aow6ckO2zsXzJa9Ucy/2F9/YTuMBgYrp/NxnwjLbsp4=;
  b=RqDb6GXeJqLUSj5WGvKwzJC8uP0qJ2fZhjesxQFU4Jk6OdoLeUR0PxTO
   J2UL9/H/N8UGw4IXQi2WNEkh6BHUI2lud5dxcquMugBdbskRUpcAeONYX
   vaN9flC8BUgG7AI0ZDMbi/5NCUGP5yvmd2zYZ0mW30Hk/LA492k0rfIXV
   GbEtApdS/rTth9ee210ZeQ+qd4NVzl1lDgBoSy/2k9BjloLr2a6pAMxeT
   IFSN8EcTViP5A7jHFhJJ8Yf9q9YfYTD7nbSX5jtuU0X1Jx0pbfXHQH/YE
   PeXSDL52YrzvQrEaj4mlmPlOWF7Hxv3U2guKTgLU+VWf8dNYFFvoEDo+C
   g==;
X-CSE-ConnectionGUID: yNxWBkEmRhiNqcldoDgN8g==
X-CSE-MsgGUID: unyCbUf0Spue3QTeXbU9/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="28033383"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="28033383"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 08:58:14 -0700
X-CSE-ConnectionGUID: 98LH2asPTZCMmLSkEYDLLA==
X-CSE-MsgGUID: AFMloyPZRIiPhXUj51E8Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="76557842"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2024 08:58:14 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 08:58:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 08:58:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 10 Oct 2024 08:58:13 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Oct 2024 08:58:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhT86T97Rzpv2kbZrLCD2pdkVxSBItbgHBQSCP9N5M7W4tXFYE/8qdDH/Xwki211DpTtNzJv5c2nD3PVjT0SWBaNow6IAaO5Oj7CE9Xyc2smEOfjr4+QgSMtUePPZq47BWxhwJglUyccSza0g+6SPb3Sn8wsmS1InomJstszr8VFqWk4o86ekCiUj6YN4UAKrVjl8V3Gb0rj6s29vwSN1TxtrO48JblEZj3nMaL62ATihVbpv9xAa0dl0ZmLid2PxQAaB6CPbbUpXdaXG+xdKFHBFuCKpOVTvetCO4zuKJNzrkljEVoUg8yo18hzIpOwFinFfphCm9QyyPLo6ya6Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aow6ckO2zsXzJa9Ucy/2F9/YTuMBgYrp/NxnwjLbsp4=;
 b=q+tBMgZXjxqeuLCpw0Xo7T/PQUrFJoBBrB/TTO0k0hTHGnUYg66b4XQ1TZho8z8c+1jXjblfVpaX3I6pKMOYCot0b/jT6UvclpaLmOv6F76QShM3J/Iud5ql0HLm+Edod5k6AR9WiC2O7R9ajGO4DbzNwMzlG7LwuVNIAsryQ0PCG2dkarPU7S5dtb/HY5CAs+Pxp0lR1jzeTWWWBMDf99J0V+sFMWv+qYZXwD+NizOJeTgeTn6ceNFQHI+GObMH7tPXD8YC40+A/OnDlrWGM/Vw5xnganctIFalxqHMcpXUdXt0+poW+L1OdNZ89+GDI42okf/Iw4KUrh/JVVpeVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH0PR11MB5300.namprd11.prod.outlook.com (2603:10b6:610:bf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 15:58:08 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 15:58:08 +0000
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
Subject: RE: [PATCH v8 08/25] x86/resctrl: Introduce interface to display
 number of monitoring counters
Thread-Topic: [PATCH v8 08/25] x86/resctrl: Introduce interface to display
 number of monitoring counters
Thread-Index: AQHbGybdEonESjxpIEK+MSvEee6fXLKAG/3g
Date: Thu, 10 Oct 2024 15:58:08 +0000
Message-ID: <SJ1PR11MB608381B9DA3AE26749070BE8FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <cover.1728495588.git.babu.moger@amd.com>
 <c79fdf4196d974325df995eb334221463747689e.1728495588.git.babu.moger@amd.com>
 <ZwcIkf_oy2oKByNu@agluck-desk3.sc.intel.com>
 <8ceeb50a-70d7-4467-b7c1-4f62b1a1eec8@amd.com>
In-Reply-To: <8ceeb50a-70d7-4467-b7c1-4f62b1a1eec8@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH0PR11MB5300:EE_
x-ms-office365-filtering-correlation-id: fcad8923-cad7-4938-19c8-08dce94455c3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aDFpNnV4SEdSNzNHcHZROWRuZ0RBckJhczN0OEYvVVV1ck1MQUQrT21LdHpp?=
 =?utf-8?B?alo0S0gvellkdWsvSU4rclg5SDJ3eWI2YzFUaTJJMVptTGJyZktUV2dWakUx?=
 =?utf-8?B?RDgzcHdkSHQ5bDExVHdWWWxxQ1REcnJsdVRyczQwaW5kRFFGN3NNdXluWEZU?=
 =?utf-8?B?ZWZDL013THJjM3FwaytPNGZGU0EwVzVFdUhzakRvUGpJWlRpeXpQcXdLcDBy?=
 =?utf-8?B?T3lHWHlQT0N0SzVhUHUrR3ZKU29wbTFDdXlPQkh3dkJsZVdlNzNXVmFpT1lo?=
 =?utf-8?B?UWdFVWdCU0hhdWt0TXBETXQyZ0NDRVhUUFZZL0NLMGNpYWtacjJCTDhkV2VD?=
 =?utf-8?B?V05oc205RDRvRkdTTHQwZWllTStYMldIU0lkem5yWlZCMTF5a1VrNTNrR0c0?=
 =?utf-8?B?bzh0dUM0ZVZUa0xpbllyMlMra01mSUFDK3l5UXNyc25DakJmVUZwaWhMYTJF?=
 =?utf-8?B?YllhQmJCa0hiRHIrT0ZCU215bFR4b1k1T0dESmdNZ2dZbTJHTllCL1Bldmp0?=
 =?utf-8?B?ODhsSzgwL0crTWZjVzluK3JZSUh3VVczYVd5TktBd1dqKzJxTnlNd21Cak1i?=
 =?utf-8?B?cHJzLytiYUNncnpmOXNZaTBieGYrUVJsYnhmQ3E2NnJZOXFIR1pVbTlHMzBY?=
 =?utf-8?B?TnpxWGs5NGxTUUpuSldRa1NIYW9oMlBXOWNjOHlMYmswSkFoeTk1OU9yRmFG?=
 =?utf-8?B?Z3ZZYjZDMFhHSENOMmVCV2kyVDVwQWx3YzdQNXBrZTJRend2VU1YamxWWFY2?=
 =?utf-8?B?dDdRM0w5YVJnOGJPV2Q1RGZRT2ltMkxCU0lMdnJsSFVvaElHMWJXM0dkN3BQ?=
 =?utf-8?B?NUg4WGJPaHlKU0YwNzgrdXN5d1dpOEY3YW5rWnBKOGlIc3p1UnJnczV5Q3dK?=
 =?utf-8?B?LzhlZnhGeGxoZTFtdUpGMUdINWhaM09NRFVOTE9nZzN2M3I0c2o3ck5sUzZq?=
 =?utf-8?B?S2VUekZRZk1uUm9yWnR3SVcwZ0ZsVVhnbWFMeVNUeVljYWdxSHVOUUlLYk1R?=
 =?utf-8?B?VVVxcGNISkNTbktONitsdUxYdXdCdE1zUzFhdm1zd0tsMzk2SmFhQU5EWmRo?=
 =?utf-8?B?enZFcnBxdDZUWHhyK0VLY1ZOemJiZEVVS3ZISm9jdG94RjdpUWtCbXJNRVky?=
 =?utf-8?B?MjRhdTRqeDBHVTFaL3YzakdjbmpiblRzV2hDdENVbHpqQ1hNQWJzQXdXWDV3?=
 =?utf-8?B?L1dZeHpHSUs4bU02STJpbTZvWjUxTFpzYXNENEtvcWo2RnBYRFBlczRlK293?=
 =?utf-8?B?clkxTFVaOUQwVkRoT09HZHdEUmo2ekdtYTc3Qy9jK24wSWdtcCtUaFlxZEQz?=
 =?utf-8?B?Y0FBaVFnM09sR1NVWTRKaUFTaldsWEFzQmdMSDBOWmRleFBWYWlLdzY1SHdH?=
 =?utf-8?B?Y2twOWFJSXRLZElVV29SUmpYdUdwa1lFMVJKNU9QaHREQ3ZvdlkycEgyWlk3?=
 =?utf-8?B?SlBtNnNIM3JjVnN0Wm5PVE03K2R0V3hGWkNaZWdIZ1AxZzhsTW83aHNPeC9K?=
 =?utf-8?B?b3pLb1ZTbkRud3lKdW9TN3lOdlZGWTFJU0NCM0pvMXNqZDdTaGJON2kwWHV0?=
 =?utf-8?B?b2R1c2p3Vi95REpqd3gwamZBYjlrZ1d4djVKeDZiQkduK1ZWRlMwOFd5aGNW?=
 =?utf-8?B?QkgrQ3NobUpacCthWHY2aEVXU2tnMG45eElDUS8zakZ2aXRlbDg0NVNGcGNo?=
 =?utf-8?B?ZlZod2hyWTE5QmRiNWM5ZmVXMlpZck16bnF4c041ektDNUszSVBJRlJjSjJL?=
 =?utf-8?B?dVVsalYrYzJNUU80M3NWUk02OEw5SnhUeC80RXpTdm9MUW9DbUwrV1JDdDdE?=
 =?utf-8?B?eDk4Sk4yb0s3VzBMd29BUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emFXbkdDSzVabWk1N1p6YW5lMTlIRzF3Q0dnQWVoMnh0aVd3dWdwZ2FUNUVm?=
 =?utf-8?B?aVdaZWE1OU5ya2tLWU5YQkoreTIwVkd0MktBbndZRDhoK3ZNTFNhczZnaC8z?=
 =?utf-8?B?SlF5eFYxanFRQ09ZdXNQc3ZyYVlya3kvTnpNYTd5V0NyYUlHVDNRZEJxSStP?=
 =?utf-8?B?dHp6M1FDZndHQU9Ob2txTUlEMzg1dlNhSzBiMjZWRDNSMUZKOG80Wms2SW1B?=
 =?utf-8?B?NnUvRFBuMHhXUXp2aEV4bExVT0daVTdvQ3V4eVpsR3pkbkNWVUY3U05vcyta?=
 =?utf-8?B?dTBOWm5FY0lYTTIxY3ZvL1JaWWF2MUFYZjdzS1FmeEphSlNadGZDMllHMytj?=
 =?utf-8?B?ZWhMZTl4OXE3aENKamNpb1libzRKQmJwR2M1amYrMW1qWGhnNHZGVy9vdmhI?=
 =?utf-8?B?UEU1SE5PVHpOMllPSlZ3RjRicEJ2c09WN2taN2Q1R2FWTHd4RExEa05adkF2?=
 =?utf-8?B?bnZxOXl5OG9iRERmL0pvMGhLbXJUc0xmMEFPMkF2RXJQUjlidkR4Tjc4QTMr?=
 =?utf-8?B?U0RQWTFjNW9TSUZqUWdVZEpYOVllTVpKbDJQUjFZb2J5NVRaTTBHZXhveFAy?=
 =?utf-8?B?TEg2TWk5MWxCblNPVk5ONnVzeWhiTHRaTXZISWd3WjE0eFNvYTRtRFJZMlZT?=
 =?utf-8?B?UzNpaHhrVW9QNW9sNllmSFhQRkV1MkhXZ3U1R1ZiVHdjSlliUEgrb2p5NGRW?=
 =?utf-8?B?UUhiNGZLNHhUQml2QWk1Ny83dGZESGlJK3kvMzZneG9YUTQ5U3I1Y29BeFRq?=
 =?utf-8?B?eWYvZFczYUN5WUZYck16QUF0UnYwYmpaMnlXdTFVekY0ZnpRRThyOEdnVm1l?=
 =?utf-8?B?dUIrc0xCMUoyWWdkVE93UjR1L3E2V2ZmVWdmYXNHOXpBVE1kWWJIbDdaQ0p6?=
 =?utf-8?B?RWtiL094d08yNlo3eTZVcEsraEtZZThmWUVNaDBuSjNRNCtIRzNTcGF0Vnpu?=
 =?utf-8?B?MEs0SDdXT1gvbFFVU1lmdDk4em5mQkliSVFLQlBHVE5vdXBqT1FTcFdraklq?=
 =?utf-8?B?ZHoyT1N0YUZIdnJxNmdlZk9GMHNuY1hqbXBZSXQwN3NxR0hOSEMxWkJnY0lF?=
 =?utf-8?B?VXdRZFNBbStOTzZGUzR3Vnk3TVhiV1loS0k1cUJmdlpZWHRGVWFGY3FXZDNO?=
 =?utf-8?B?YUpjSTl4WVFqNHpBRTd0MmhKOU5UK0ltaEdUajJJcFJvZ0VpMVJreC82RW95?=
 =?utf-8?B?aitCSEZ3RkVjemM5SXBMTHhsWlFYaWxwSFRpMjQ2eGFFa0Q1bzExMjRuRG9B?=
 =?utf-8?B?VGVmVlBqRDlvMVVBZzM2OXVJS1ZqNkRmWDhscHZVR2J0bkxGQ3MyVkJlMW43?=
 =?utf-8?B?YkJUN2h2U3p6K0MvVUQvbVNVRzRXbmFWNHpLR0dHcUNGMWluV0ExTE1Qc05D?=
 =?utf-8?B?Vjk0U0VnRVZTNDFPRWgrY1lxMU5UNStTK1piUTM5UkpQRFJVNVBjbjR3SFdZ?=
 =?utf-8?B?ekZUNXFlM3FrbXpYZyt3WGxWSDdRMkpiN1RHdkc4U0w5NkxldjNQU3pWbHJz?=
 =?utf-8?B?Q1JSZ1owNmdCTCtHaDRTOGxsUWxmS2tITjg0VHFDdHJwS1VFQUE2NmpwNVB2?=
 =?utf-8?B?RzlZN2RubXFFa24vTnBTN0FjSWdmbDV4V2MyNU0wNEVMQ1hleit3NXZNVURm?=
 =?utf-8?B?b3R1clk0ZUVuWDZMSy9pYzB3dHhOeEJqc1dvdXpDa2s4cGdWUzBUVkg0cmV2?=
 =?utf-8?B?S1RnK0tDMEFpbkdWamNXSE04NHhnQlpmWlVIM3ZoVEZaWWhLaGFJRThyOHdj?=
 =?utf-8?B?M21PNVJQc2tweFpRcVJBTENCdXJoRjN6cCsvS2gvQWYwVW96UitIcjd0YzQw?=
 =?utf-8?B?Qmh0YkZ3Tll4N3lPeVlMVjVHVFhKd1pUNDByTXpRNW95RStWcnl1NkhiOHAz?=
 =?utf-8?B?bHlhYU43bitrZzZNVTBLUVV1UEEvVC9YRHEzbDh4MnY1ZUpTSTQrSmxuOVdm?=
 =?utf-8?B?WXlaNWljaGx0cm43SnRJZ0U2QmRyWVVzMFd0QTRsWXJkSzJDU3k4bkxIQ0Y3?=
 =?utf-8?B?R0xDeURTaEE1MXhDd3lYcm9weTlKV083QW40UjZ6eU0yWWNCVEdNT2MzZlBO?=
 =?utf-8?B?T2JCc0lUYVhYL1ZFdEVTNkRCNWRjMTJBWEtuSjA3WGFDejVPckVSclU3VEhD?=
 =?utf-8?Q?BQYUB6sZzYpVhP0TgNKaVYImE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fcad8923-cad7-4938-19c8-08dce94455c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 15:58:08.5249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1xsshTu0EruP1gaoBODsU6GgRBflAGtb0CNBe3XolDj0+eHHJvQWcZy7axF4xOarUfmBGBmTXn5ndeOM0p2ASg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5300
X-OriginatorOrg: intel.com

PiBBbGwgZ29vZCBwb2ludHMuIEhvdyBhYm91dCB0aGlzIHRleHQ6DQo+DQo+ICJudW1fbWJtX2Nu
dHJzIjoNCj4gVGhlIG51bWJlciBvZiBtb25pdG9yaW5nIGNvdW50ZXJzIGF2YWlsYWJsZSBmb3Ig
YXNzaWdubWVudCB3aGVuIHRoZQ0KPiBhcmNoaXRlY3R1cmUgc3VwcG9ydHMgbWJtX2NudHJfYXNz
aWduIG1vZGUuDQo+DQo+IFJlc2N0cmwgc3Vic3lzdGVtIHByb3ZpZGVzIHRoZSBpbnRlcmZhY2Ug
dG8gY291bnQgbWF4aW11bSBvZiB0d28gbWVtb3J5DQo+IGJhbmR3aWR0aCBldmVudHMgcGVyIGdy
b3VwLCBmcm9tIGEgY29tYmluYXRpb24gb2YgYXZhaWxhYmxlIHRvdGFsIGFuZA0KPiBsb2NhbCBl
dmVudHMuIEtlZXBpbmcgdGhlIGN1cnJlbnQgaW50ZXJmYWNlLCB1c2VycyBjYW4gZW5hYmxlIGEg
bWF4aW11bSBvZg0KPiAyIGNvdW50ZXJzIHBlciBncm91cC4gVXNlciB3aWxsIGFsc28gaGF2ZSB0
aGUgb3B0aW9uIHRvIGVuYWJsZSBvbmx5IG9uZQ0KPiBjb3VudGVyIHRvIHRoZSBncm91cCB0byBt
YXhpbWl6ZSB0aGUgbnVtYmVyIG9mIGdyb3VwcyBtb25pdG9yZWQuDQoNCk11Y2ggYmV0dGVyLiBM
b29rcyBPSyB0byBtZS4NCg0KTmV3IHF1ZXN0aW9uczoNCg0KMSkgU2hvdWxkIHJlc2N0cmwgcHJv
dmlkZSBhIGZpbGUgdG8gdGVsbCB0aGUgdXNlciBob3cgbWFueSBmcmVlDQpjb3VudGVycyBhcmUg
YXZhaWxhYmxlPyBUaGV5IGNhbiBmaWd1cmUgaXQgb3V0IGJ5IGNvdW50aW5nIGFsbCB0aGUgJ2wn
IGFuZCAndCcNCmluICJtYm1fYXNzaWduX2NvbnRyb2wiIGFuZCBzdWJ0cmFjdGluZyB0aGF0IGZy
b20gIm51bV9tYm1fY250cnMiLg0KQnV0IHRoYXQgc2VlbXMgY29tcGxleC4NCg0KMikgRXZlbiBt
b3JlIHNvIGJlY2F1c2UgZnJlZSBjb3VudGVycyBtaWdodCBiZSBkaWZmZXJlbnQgcGVyIHNvY2tl
dA0KaWYgdGhlIHVzZXIgZGlkIHNvbWUgIjA9dGw7MT1fIiBhc3NpZ25tZW50cyBhcyBpbiBvbmUg
b2YgeW91ciBleGFtcGxlcy4NCg0KTWF5YmUgYSBVSSBsaWtlOg0KDQokIGNhdCAvc3lzL2ZzL3Jl
c2N0cmwvaW5mby9MM19NT04vZnJlZV9tYm1fY250cnMNCjA9NTsxPTkNCg0KLVRvbnkNCg0KDQo=

