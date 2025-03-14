Return-Path: <linux-kernel+bounces-561109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7C3A60DAE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7316616806E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352C51EEA2C;
	Fri, 14 Mar 2025 09:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bPV+wh6E"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E36415666B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945521; cv=fail; b=WlnApCgPAqyXkbUO1xUpGTRUaD52/TddV0BxFVSFmjKtTe05sFq8rfdqnoRMMijiBHqIKd2GJitdoQqM4hdVC+8UgJq1ejIntj+hMO129EN9BDcUsaOh0jcd204EZLGUh4RMdF+hCtXKkDU19KY9W53tLr73SG9PL417mi+Qnik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945521; c=relaxed/simple;
	bh=DHgS37gbqVeV+WCJArL9+yv/tBDQEobgMHZHbyHelVI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CZc9Pa2VJdBrEf4zLyo8N/kxo5iZiOgAxFythgNCwiQoedL7V0iuptZEuraPerH20pWvdBQzDuCQHudn08gz6Rcn6/yaKKp1zoVOCQhrh1GvMFzzF+qm/OzQ9G2iW9kybqD6XSQnFBe1aObcuhtnJcrptt8fyXSbODXJMt20of4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bPV+wh6E; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741945519; x=1773481519;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DHgS37gbqVeV+WCJArL9+yv/tBDQEobgMHZHbyHelVI=;
  b=bPV+wh6EPdTM9kBFq42j2cJZi/ob6lznvSOmaOhCXXrwuzPJZcQcLHID
   +cQ2l+MaD9Ozq6NIeLrsSlqnrlLeLRbzHhdJkBeRMAeWEwYImXHvJnx/0
   gST1mwRMWhOD6XSswgzOMhKqZ2slmM4jrT6XIIZaCEHkbto8ondF+mrZF
   O20NvHDKlDvkfCFrcy5/1y1r/khLojFlWwwBu4Tq7x2SxtEtd12idX5qh
   LJK4kElYjC5Q0SiTAvdSrFhtQ4mAsjHglBseqeWjR7p+7GOZ5UzMX5DLg
   iJYUZnH0joH4IZ0fSY8H6pchEIfg6j8f4JF/bP9IN9tkqmHGsdRpjt67m
   g==;
X-CSE-ConnectionGUID: GJ0TvtXeTtGJYoOCc8y5Qw==
X-CSE-MsgGUID: 7r8zroeHS9Kacwj2VB1GsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="53744186"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="53744186"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 02:45:17 -0700
X-CSE-ConnectionGUID: bdJ228eJRdKlvsZjmRe5ig==
X-CSE-MsgGUID: +Hin/OjJRoC9ppFweZUefQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121259923"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 02:45:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 14 Mar 2025 02:45:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Mar 2025 02:45:15 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Mar 2025 02:45:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMQCb9w0m4pQISVeQEbaybrCNS/ZnSfC7H0V65cmrfMoehEk9Xkf+dqcfMUizvyW7N182oGUZANlUegBt4AC9RHBoNS7p/70KVUGc8dPYSA2PAb8YxhfrUYxr0K1Rmli6Vxl3IDbzuyA+htKjZz9cA+uQzAf70ESyOio7b0tghh87M9iKIDChTVTCtkkTyi46yyJ7RKcW3Cx4ZvWgPPGKMpMGC1lPWmayE7LMSJhUi7kzh92Dq/FN24dql4WhFRpjcquGMxgannAUEftJrlPMGB0qJzD1QuNnEsOhktfVKXdmCtOB/0+KLqnFZ4BB8wGMHrW2yMt7ebb8/OgimlT9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHgS37gbqVeV+WCJArL9+yv/tBDQEobgMHZHbyHelVI=;
 b=QYLqnZHSzuCMsynTctM4EfbfteehJ9oCmTB2FOK55TmR5VdUzmIssyPJigRvBWQMd+anZoI4gfJoetLcuyB6M3ofh/rWq8cdXJoA5YYlW87p+WTEZ9LrCJrlqekoJOWvpjq1TCC9ICEd0fGTTa124eQGFj63R4J8OIQdsdWPPiHmOEAHPekYr5E4qCMoUINstOUyy7IHzdb9IaBnBTcEmURN0ve9gdAysuQ3f0spvnWkfa+5nmaUNC8XnhbV+/eOj4iP/q5mgyWSQ6WRVhxTt/geQkNk35D/K52bHY5equi6IToOefoPhd0X+tR9VtbvfvP+Rskq7aDHKzLOKqYaIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CY5PR11MB6416.namprd11.prod.outlook.com (2603:10b6:930:34::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 09:44:53 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%6]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 09:44:53 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "peterz@infradead.org"
	<peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>
CC: "ashish.kalra@amd.com" <ashish.kalra@amd.com>, "dyoung@redhat.com"
	<dyoung@redhat.com>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"bhe@redhat.com" <bhe@redhat.com>, "Yamahata, Isaku"
	<isaku.yamahata@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "sagis@google.com" <sagis@google.com>,
	"david.kaplan@amd.com" <david.kaplan@amd.com>, "x86@kernel.org"
	<x86@kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 2/5] x86/kexec: Do unconditional WBINVD for bare-metal
 in relocate_kernel()
Thread-Topic: [RFC PATCH 2/5] x86/kexec: Do unconditional WBINVD for
 bare-metal in relocate_kernel()
Thread-Index: AQHbk0LVFxyjNnYqNkeu66oD/Vuva7NxtaGAgACvUIA=
Date: Fri, 14 Mar 2025 09:44:53 +0000
Message-ID: <40b14084af8a35af4e07fbd394821f92d0973d32.camel@intel.com>
References: <cover.1741778537.git.kai.huang@intel.com>
		 <ebe4c0e8fe1b78c014bbc18832ae0eec8fef419d.1741778537.git.kai.huang@intel.com>
	 <1050a84caa9036e3ddb580fb510e634a216e692c.camel@intel.com>
In-Reply-To: <1050a84caa9036e3ddb580fb510e634a216e692c.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CY5PR11MB6416:EE_
x-ms-office365-filtering-correlation-id: 427ac535-a639-4292-348b-08dd62dcdf75
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eExRRnVsQnNtOFpDdHl3THp3WFAzbEdGQjl6b09SSnZCTUpvVGpNMTZnYnZL?=
 =?utf-8?B?UkN1WEJmL2NBdFVXUTczZ2sydGZ3T3RVMW9uV0F4bURKQjRuUFliVGRaOExh?=
 =?utf-8?B?b3dBZWlzRXVvV0UvZXRRdjVZNnVkcVdCZVFXTkUzRlFzZEFaOGZpQ3ozcis1?=
 =?utf-8?B?QU9kMDN4Ylh0SWNrL0ZsOWVVK3FqdXB4d3ZPcDIvclNNcTdxZGE0NDcvaW1O?=
 =?utf-8?B?THlWZ2N3QkxSL2tJQVpHK0M2R2hBMGlLemR1YmdPRTNucW9vRkd6KzRLQzd4?=
 =?utf-8?B?RnFSK3dTakJ2U29pQUloYkVCcnRHL1padkE5RHBqc29kRnM0UG9EeithVDY3?=
 =?utf-8?B?U3g2cTNrY3NZT2xpL0YrWWU1blgxNDdKRjJiWFRVL3pNR3NORDk1bi9JcGdD?=
 =?utf-8?B?NHJOQ2pnTWpuTFVOaVVOQi9qWW5TTXFMVEJ3U2w1MDRTV0RWK1ZkaWI0N0VB?=
 =?utf-8?B?bktTUkJQWE9mMTRkcnlRdnE5Qm5NNXlFK0RJb2l2dFcyVmtFMmo1c2dpcEI5?=
 =?utf-8?B?T0UyaWh6Z1ljaEhrMXY1TkFtQktQRXh5UDJINW1rblNKaDN3dHlQZzIrc1NS?=
 =?utf-8?B?TlQ5b29DdmlJV0tkWW8wZ3VwV1ZydWNqa2FQUVFHY3lRZHUzVmMxTEx0blFK?=
 =?utf-8?B?M2tZT3lDSkJTeFljUFlFdE9iUXovL1hkME04ckYwdThzZmVaZGVVcG9zOUlh?=
 =?utf-8?B?S1k2VWUzVlJ4TnRWbnpxWWVqMFlVQWppRUtQTERZWXhKYUtNRGF0U2pkbXda?=
 =?utf-8?B?bkFTQlJGaEdmcXU4WlJ0V3RVbEU3bi9IZ1NYcTNNdXNCQmgzS0xaYnB5K1cv?=
 =?utf-8?B?YXhYS0Z6ZGV3VkI2VzF3S2lYUFJQQXU1UVNmMlFxT1hJOTFwc0dyZU1DSTRJ?=
 =?utf-8?B?Q0Y0ZFpVSE0rd3doU29zdU0rUTBKclFHV0FuVTVtbTRpUmtnWktXZFM3K2pm?=
 =?utf-8?B?NWRXbWpFaGlzenprTk0ycWZXbEh3VTVZak5LQm5Iejd0Qmw0ZkJIeGJVbU1h?=
 =?utf-8?B?S0JQU1dvbDROYmZDd3FzVzh1RDRjUGhvODg0dHlaKy9tTnV4MzgrM0pzQXpi?=
 =?utf-8?B?eXg0cjJlVjlqMjZRaEROQW5hTDVEVGhYbjREZ1BCY0lYZGZLWDNmcXM0QWll?=
 =?utf-8?B?dlRnOGZJZXZDbVJJZjkrU21YN2g4cnFlaWhoSlNWZ1dId1JLUkFseE91MzZL?=
 =?utf-8?B?UXF1b3Radm5kV01qNGdWN3lmZVYwVWcwVnV1ZnVPOUNpUEwvMHZWdnlJcWdx?=
 =?utf-8?B?K3lGU0RHQmtNMWJHQm9vMmFwOGFjQkRJbzlGQXN6TGFOKzNBaGZkcVJHVUxY?=
 =?utf-8?B?QWJqZHpQUzlDVGUza1pCY0sxZ2JZMEd6a2c1dkhhSm1XMU9qek1EZ004VjdV?=
 =?utf-8?B?UFQzaTJVb3RIcHhlZXYvekZCWGxRcmZRN1B2RmhsMEU4RVFMTGk2TFZaK3Nu?=
 =?utf-8?B?UW1uTjZpMTB0cndCdUZrZWdjREdVcys4L2JDMko5L1lkNm5aN2pMN2FWZWE1?=
 =?utf-8?B?OUI4VXlXWFVvcWRTK3hGaWh1SVlEdmttaEtEMi95V3pHcVVvejd6L3drdWxl?=
 =?utf-8?B?a2MrNEVCZUlJWjRsZnJlT0pPc1huYXZKQkZucDQ2VVNIOGUyNTVVUlZYeWlY?=
 =?utf-8?B?TFlNbWt0Tk02YnZwR3YrYWxTZ0hhYkY0MXVmMVdTYVpSOXRoSVJhWmdMNjBu?=
 =?utf-8?B?a1lIcXFrajZkVEtFOEExNTQrWmVnd0RTWHhFYVVSbVdSRDl3ekpGZ3R0T3F0?=
 =?utf-8?B?MFFvOWNYcCtFVjRUMGU3SEFQSEdIZnpuTDJ2WlJqL1RFd3BUeDdpVUtsdTJn?=
 =?utf-8?B?ZElQZjJuU2xVY1hXSzhyL201QzlQUVdBWDJsb2FXSWhJTDBYQlozL1hWMUsr?=
 =?utf-8?B?UlVXaEY0WXA5MzdWTXJ0N2ErZXpVcUFPa0FRelJiZVN3VzNaVEd5MDd3ZVp4?=
 =?utf-8?Q?midkjVeRcij9I588RVqkHnX8FsHG7pOa?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3hWcmY3eVJLU1pjczJzUk1oMUVqOE1sNGNLR3p0emFUN0VZai9zMUpKSmFE?=
 =?utf-8?B?ZXBKNmk2dVk2aW16bXNLQTBwQ1VqL1gvOXg2dzczeGVDd0VROW42eWZnTXRO?=
 =?utf-8?B?L0ZRWnJQOERpS3VtaVFMMHJyZnpkWEV5dkZSQkpNakUzU1dpYW1MU2l2N0ZW?=
 =?utf-8?B?NU5hcUF3TjRZZkcwNG9RNW5XUlFZV1RuWnRCMWFBUGtIampGajJzcjlOMDhu?=
 =?utf-8?B?WDJOUU9ld2Z3bDJSU0NBS1hiTUc1QkcwV0FDSksrNXFza0NGQVl3bzFhUkpp?=
 =?utf-8?B?eWIrNlNxc01PZXhtWjhOYXhUMUFOMmN6RWRtVytGUVFJR3pzT1phanZxaTRE?=
 =?utf-8?B?OUxWMzdkcis5aXJYWi9VUFlxZXV4SjdIVVJRK1MxUmF1NFZFd245ZWNHTFNU?=
 =?utf-8?B?L2Y5dlZEV0pPMlovaDV0Z0M3aUoxdmdHRXo4MEFFTWJmTGFVZ2QxOW1wQU95?=
 =?utf-8?B?dGUxanZ2UkZZTXEyY0l6bzQrSnpzR1NJR0FnSnBkOVZIS0pPYVFGZ2dpSUdF?=
 =?utf-8?B?NlRtUk4rMGJEM1d2U05Hb21qWTk4ZFNybVFLd2J6cVlFakVZTGRWRmNEaXZZ?=
 =?utf-8?B?V1QzSzJldktyZDdETWJlR3cyOWJkYkpWMGFBWWh1OGN4eUk2Tm9Rc2U1Zlpa?=
 =?utf-8?B?YU9peTB2ZUJwbnBQd3QxcFlYOGNBVGFSSHVjdG9nS2NtT2RDUmpnOHZoOSsy?=
 =?utf-8?B?NzBReDYveWdyQnR6ZEk0ZVgyeW43UmtwbW5uQzRxdjI2NWJGUXJMYUhjMkpy?=
 =?utf-8?B?UlFSOW1FUzBOU3RqM3JrSXhOc0MrbjRWcU9SNndmU2UxZ1c5bk90cFNGaHpZ?=
 =?utf-8?B?T2RPcm1uYmdGZjVGdElUZ0FpNVJxOUNMRVhVYmNNdW5vSHZHQld1dU4zK2hI?=
 =?utf-8?B?UnErMTYrQXV6c0RkOFFyMkE0eldZaWM2a1pnUGhPVHFrdHpNU0ZPUlY2eURz?=
 =?utf-8?B?eXF3MzArTVJFKy9TV0RrQy81ZmZtSnNMQXJQN0Z3U0l6eXBhNzlaRk9DdFRH?=
 =?utf-8?B?dUxLd0N2VERqUGhxaUpNV3BtVFFmejE5ZGVlTkJBZkp1elV6ZnFHdTRwMUkv?=
 =?utf-8?B?Y3VyZ2RCanZJb3RFZ3hydm1zcjNSSllhamFNeC9VMWErNWszMzJEUkdXMEEx?=
 =?utf-8?B?cW1vR1p4MlZ2cU9jNlBaSllNTjFHSFo0dkdqNXRzdGV5WkRENVp5QzVEampX?=
 =?utf-8?B?TFp4dDdnQVc0ME1NbVM5bHdJNDhtZExTRmV1b21KMUFRNmFSU0RLZUViUC8r?=
 =?utf-8?B?ZGQ1SXF4RU1Cb1pHNXFzaGpNOVJVSldKYlB6YnorWERUdGdYZEZ1eFNQbDBv?=
 =?utf-8?B?aXg4cFh0K09VMGpMdzVnNkhzT2pYZldXb3pWcStiUHEyZzlCTE43NHEzNUhm?=
 =?utf-8?B?ZWVDSkx6NG5wSTlRYUhkR0YyTXdnNkN0VnpxTHdoQXFsdFV2WWdTdFBTNTZU?=
 =?utf-8?B?MmJrUE1XMXcwcm1hb0h5YVBzTUhVODgyUjExaGpsMkdBb3RIaExPZk4zWHI5?=
 =?utf-8?B?SnRwbnJoVjFKZ3I2RExmelhHb2pxY3dQdW1rWWN5aGhKajlOeXZDYnM1NGhP?=
 =?utf-8?B?d3Rpb2gxWEdaQnR6azI5VWVRUTdYcytKbWcwbENEQkI1a01KOEl3K2dLS1Zu?=
 =?utf-8?B?bmFibXR1RlpoditSRjZ4amhjR3p4RDlrRzNXZjdwM1pGVWI1UFdKQjFNRXVY?=
 =?utf-8?B?ZXZKU1YyNU92UFhreE05ZUNrcUlyYjNEOXY5TGV6blpveURJTHg2cm9OTWhk?=
 =?utf-8?B?K0d0N3dFMytqUWJjUEswSXlzU0Z2ZzFNTEhPbjJUVkoyUGgybHIrbWZqK1VJ?=
 =?utf-8?B?YXVNN3hKK2hna2FUbXBZTTRtY3ZJUVJjQ1kzcmpxTmZOcWU1eE51bWJOSnpo?=
 =?utf-8?B?OEMwMkc5ak85UXNubGtsMytDbS9COEc5bzBZRlV4SFVPWkN2bUhHV21MeWFt?=
 =?utf-8?B?cUF3Y2hvNG16cFdYOEp0d2FDSlc2Vyt4SEJJUk53UU11Y0xJdldvSkpzM1Fo?=
 =?utf-8?B?MGtKdnBsVUw4QkJES1hxazB5SmZxRVQ3YktLUmdIMURYWjRwSmJxUlRpRjNN?=
 =?utf-8?B?amF1d0xiMFpPb29BOXpFdkh4S3d4L3RxMEpNNFhLNFhxRjdDdFhwYUt2VVc2?=
 =?utf-8?Q?SPqD1AqjZzC9fGdFTUjzqnh7C?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00ED75989A42D1468F18211A885052C1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427ac535-a639-4292-348b-08dd62dcdf75
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 09:44:53.7342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8jPEtjgqu8nI+ObfYYA+mkAtskgB2LXsSZVVx/YHkKyV1SeEkU+/YA++VOV9dq30nfZiIuSMe4XsnHjZPEvupg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6416
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI1LTAzLTEzIGF0IDIzOjE3ICswMDAwLCBFZGdlY29tYmUsIFJpY2sgUCB3cm90
ZToNCj4gT24gVGh1LCAyMDI1LTAzLTEzIGF0IDAwOjM0ICsxMzAwLCBLYWkgSHVhbmcgd3JvdGU6
DQo+ID4gRm9yIGJvdGggU01FIGFuZCBURFgsIGRpcnR5IGNhY2hlbGluZXMgd2l0aCBhbmQgd2l0
aG91dCB0aGUgZW5jcnlwdGlvbg0KPiA+IGJpdChzKSBvZiB0aGUgc2FtZSBwaHlzaWNhbCBtZW1v
cnkgYWRkcmVzcyBjYW4gY29leGlzdCBhbmQgdGhlIENQVSBjYW4NCj4gPiBmbHVzaCB0aGVtIGJh
Y2sgdG8gbWVtb3J5IGluIHJhbmRvbSBvcmRlci4NCj4gPiANCj4gDQo+IEEgbG90IGdvaW5nIG9u
IGluIHRoaXMgc2VudGVuY2UsIGhvdyBhYm91dCBzaW1wbGlmeWluZyBpdDoNCj4gDQo+IEZvciBT
TUUgYW5kIFREWCwgbXVsdGlwbGUgZGlydHkgY2FjaGVsaW5lcyBmb3IgdGhlIHNhbWUgbWVtb3J5
IGNhbiBjby1leGlzdCwgYW5kDQo+IHRoZSBDUFUgY2FuIGZsdXNoIHRoZW0gYmFjayB0byBtZW1v
cnkgaW4gYSByYW5kb20gb3JkZXIuDQoNCiJtdWx0aXBsZSIgaXNuJ3QgYWNjdXJhdGUgYXQgbGVh
c3QgZm9yIFNNRS4gIEhvdyBhYm91dDoNCg0KIEZvciBTTUUgYW5kIFREWCwgZGlydHkgY2FjaGVs
aW5lcyB3aXRoIGFuZCB3aXRob3V0IGVuY3J5cHRpb24gYml0KHMpIG9mwqANCiB0aGUgc2FtZSBt
ZW1vcnkgY2FuIGNvZXhpc3QsIGFuZCB0aGUgQ1BVIGNhbiBmbHVzaCB0aGVtIGJhY2sgdG8gbWVt
b3J5wqANCiBpbsKgcmFuZG9tIG9yZGVyLg0KDQo+IA0KPiANCj4gPiAgIER1cmluZyBrZXhlYywg
dGhlIGNhY2hlcw0KPiA+IG11c3QgYmUgZmx1c2hlZCBiZWZvcmUganVtcGluZyB0byB0aGUgbmV3
IGtlcm5lbCB0byBhdm9pZCBzaWxlbnQgbWVtb3J5DQo+ID4gY29ycnVwdGlvbiB0byB0aGUgbmV3
IGtlcm5lbC4NCj4gDQo+IER1cmluZyBrZXhlYywgdGhlIGNhY2hlcyBtdXN0IGJlIGZsdXNoZWQg
YmVmb3JlIGp1bXBpbmcgdG8gdGhlIG5ldyBrZXJuZWwgdG8NCj4gYXZvaWQgc2lsZW50IG1lbW9y
eSBjb3JydXB0aW9uIHdoZW4gYSBjYWNoZWxpbmUgd2l0aCBhIGRpZmZlcmVudCBlbmNyeXB0aW9u
DQo+IHByb3BlcnR5IGlzIHdyaXR0ZW4gYmFjayBvdmVyIHdoYXRldmVyIGVuY3J5cHRpb24gcHJv
cGVydGllcyB0aGUgbmV3IGtlcm5lbCBpcw0KPiB1c2luZy4NCj4gDQo+IC4uLml0IGRpc3RyaWJ1
dGVzIHNvbWUgb2YgdGhlIGRldGFpbHMgZnJvbSB0aGUgZmlyc3Qgc2VudGVuY2UgaW50byB0aGUg
c2Vjb25kLg0KPiBFYXNpZXIgdG8gcmVhZCBvciBubz8gSSdtIG5vdCBzdXJlLg0KDQpJIGRvbid0
IGhhdmUgb3Bpbmlvbi4gIEkgc2VlIG5vIGRpZmZlcmVuY2UuDQoNCkkgdGVuZHMgdG8ga2VlcCB0
aGUgb3JpZ2luYWwgd29yZHMgc2luY2UgcGVvcGxlIGhhdmUgcmV2aWV3ZWQuDQoNCj4gDQo+ID4g
DQo+ID4gVGhlIFdCSU5WRCBpbiBzdG9wX3RoaXNfY3B1KCkgZmx1c2hlcyBjYWNoZXMgZm9yIGFs
bCByZW1vdGUgQ1BVcyB3aGVuDQo+ID4gdGhleSBhcmUgYmVpbmcgc3RvcHBlZC4gIEZvciBTTUUs
IHRoZSBXQklOVkQgaW4gcmVsb2NhdGVfa2VybmVsKCkNCj4gPiBmbHVzaGVzIHRoZSBjYWNoZSBm
b3IgdGhlIGxhc3QgcnVubmluZyBDUFUgKHdoaWNoIGlzIGRvaW5nIGtleGVjKS4NCj4gPiANCj4g
PiBTaW1pbGFybHksIHRvIHN1cHBvcnQga2V4ZWMgZm9yIFREWCBob3N0LCBhZnRlciBzdG9wcGlu
ZyBhbGwgcmVtb3RlIENQVXMNCj4gPiB3aXRoIGNhY2hlIGZsdXNoZWQsIHRoZSBrZXJuZWwgbmVl
ZHMgdG8gZmx1c2ggY2FjaGUgZm9yIHRoZSBsYXN0IHJ1bm5pbmcNCj4gPiBDUFUuDQo+IA0KPiAN
Cj4gSSBtZW50aW9uZWQgdGhpcyBpbiBhIHByZXZpb3VzIHZlcnNpb24uIEkgdGhpbmsgeW91IG5l
ZWQgdG8gZ2l2ZSBzb21lIGhpbnQgdG8NCj4gd2hlcmUgeW91IGFyZSBnb2luZyBiZWZvcmUgeW91
IHN0YXJ0IGxpc3RpbmcgZmFjdHMuIExpa2U6DQo+IA0KPiBEdXJpbmcga2V4ZWMsIFdCSU5WRCBu
ZWVkcyB0byBiZSBleGVjdXRlZCBvbiBlYWNoIENQVSBmb3IgVERYIGFuZCBTTUUuwqANCj4gDQo+
IE9uIHRoZQ0KPiByZW1vdGUgQ1BVcyB0aGlzIGlzIGNvdmVyZWQgaW4gc3RvcF90aGlzX2NwdSgp
IGZvciBib3RoIFREWCBhbmQgU01FLiBGb3IgdGhlDQo+IGtleGVjaW5nIENQVSwgU01FIGhhbmRs
ZXMgdGhpcyBpbiByZWxvY2F0ZV9rZXJuZWwoKS4gVGhpcyBsZWF2ZXMgdGhlIFREWCBjYXNlDQo+
IGZvciB0aGUga2V4ZWMtaW5nIENQVSBzdGlsbCB0byBpbXBsZW1lbnQuDQo+IA0KPiAuLi5pdCBm
aXJzdCBzYXlzIHRoZSBvdmVyYWxsIHByb2JsZW0gdG8gc29sdmUsIHRoZW4gZXhwbGFpbnMgd2hh
dCBpcyBtaXNzaW5nIGluDQo+IHRoZSBjdXJyZW50IGNvZGUgdG8gc29sdmUgaXQuIFRoZSByZWFk
ZXIgaXMgYWxyZWFkeSB0aGlua2luZyBvZiB3aGF0IHRoZQ0KPiBzb2x1dGlvbnMgc2hvdWxkIGJl
IGFuZC4uLg0KDQpXaWxsIGRvLg0KDQo+IA0KPiA+IA0KPiA+IFVzZSB0aGUgZXhpc3RpbmcgV0JJ
TlZEIGluIHJlbG9jYXRlX2tlcm5lbCgpIHRvIGNvdmVyIFREWCBob3N0IGFzIHdlbGwuDQo+IA0K
PiAuLi50aGV5IHJlYWQgdGhlIHNvbHV0aW9uIGp1c3QgYXMgdGhleSBhcmUgd29uZGVyaW5nIGFi
b3V0IGl0LiBUaGUgcmVhZGVyIGNhbg0KPiBmZWVsIGxpa2UgdGhlIGNoYW5nZSBpcyBhbGlnbmVk
IHdpdGggdGhlaXIgdGhpbmtpbmcuDQo+IA0KPiA+IA0KPiA+IEp1c3QgZG8gdW5jb25kaXRpb25h
bA0KPiA+IA0KPiANCj4gIlVuY29uZGl0aW9uYWwiLiBOb3cgSSdtIHN0YXJ0aW5nIHRvIHRoaW5r
IGFib3V0IGhvdyB1bmNvbmRpdGlvbmFsIHdiaW52ZCB3aWxsDQo+IGJlLg0KPiANCj4gPiAgV0JJ
TlZEIHRvIGNvdmVyIGJvdGggU01FIGFuZCBURFggaW5zdGVhZCBvZg0KPiA+IHNwcmlua2xpbmcg
YWRkaXRpb25hbCB2ZW5kb3Itc3BlY2lmaWMgY2hlY2tzLiAgS2V4ZWMgaXMgYSBzbG93IHBhdGgs
IGFuZA0KPiA+IHRoZSBhZGRpdGlvbmFsIFdCSU5WRCBpcyBhY2NlcHRhYmxlIGZvciB0aGUgc2Fr
ZSBvZiBzaW1wbGljaXR5IGFuZA0KPiA+IG1haW50YWluYWJpbGl0eS4NCj4gPiANCj4gPiBCdXQg
b25seSBkbyBXQklOVkQgZm9yIGJhcmUtbWV0YWwNCj4gPiANCj4gDQo+IEJ1dCB3YWl0LCBub3cg
SSdtIGxlYXJuaW5nIGl0J3Mgbm90IHVuY29uZGl0aW9uYWwuIEkgbmVlZCB0byByZS10aGluayB3
aGF0IEkNCj4ganVzdCBldmFsdWF0ZWQuIEFuZCBJJ20gZG91YnRpbmcgdGhlIGVhcmxpZXIgc3Rh
dGVtZW50cyBiZWNhdXNlIEkganVzdCBnb3QNCj4gc3VycHJpc2VkLg0KDQpEbyB5b3UgbWVhbiB5
b3UgZ290IHN1cnByaXNlZCBieSBzYXlpbmcgInVuY29uZGl0aW9uYWwiIGZpcnN0IGFuZCB0aGVu
IHNheWluZw0KImZvciBiYXJlLW1ldGFsIj8gIFRoaXMgaXMgbGl0ZXJhbGx5IHdoYXQgdGhlIHBh
dGNoIHRpdGxlIHNheXMuICBJIGRvbid0IHNlZSBhbnkNCnByb2JsZW0sIGJ1dCBJIGNhbiBtZW50
aW9uZWQgdGhlICJmb3IgYmFyZS1tZXRhbCIgcGFydCB3aGVuIEkgc2F5DQoidW5jb25kaXRpb25h
bCIgYWJvdmUuDQoNCj4gDQo+ID4gIGJlY2F1c2UgVERYIGd1ZXN0cyBhbmQgU0VWLUVTL1NFVi1T
TlANCj4gPiBndWVzdHMgd2lsbCBnZXQgdW5leHBlY3RlZCAoYW5kIHlldCB1bm5lY2Vzc2FyeSkg
ZXhjZXB0aW9uICgjVkUgb3IgI1ZDKQ0KPiA+IHdoaWNoIHRoZSBrZXJuZWwgaXMgdW5hYmxlIHRv
IGhhbmRsZSBhdCB0aGUgdGltZSBvZiByZWxvY2F0ZV9rZXJuZWwoKQ0KPiA+IHNpbmNlIHRoZSBr
ZXJuZWwgaGFzIHRvcm4gZG93biB0aGUgSURULg0KPiA+IA0KPiA+IFJlbW92ZSB0aGUgaG9zdF9t
ZW1fZW5jX2FjdGl2ZSBsb2NhbCB2YXJpYWJsZSBhbmQgZGlyZWN0bHkgdXNlDQo+ID4gIWNwdV9m
ZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfSFlQRVJWSVNPUikgYXMgYW4gYXJndW1lbnQgb2Yg
Y2FsbGluZw0KPiA+IHJlbG9jYXRlX2tlcm5lbCgpLg0KPiA+IA0KPiANCj4gU3RhcnQgd2l0aCB0
aGUgcHJvYmxlbSBoZXJlLiBJdCBqdXN0IGRlc2NyaWJlcyBhbm90aGVyIGNoYW5nZSBhbmQgSSdt
IG5vdCBzdXJlDQo+IHdoeSB3aGVuIEkgc3RhcnQgcmVhZGluZyBpdC4NCj4gDQo+IEJ5IHByb2Js
ZW0gSSBtZWFuIHRoYXQgaG9zdF9tZW1fZW5jX2FjdGl2ZSBkb2Vzbid0IGZpdCB0aGUgY29uZGl0
aW9uYWwgYW55bW9yZSwNCj4gc28gaXQgbmVlZHMgdG8gYmUgY2hhbmdlZC4NCj4gDQo+ID4gICBj
cHVfZmVhdHVyZV9lbmFibGVkKCkgaXMgYWx3YXlzIGlubGluZSBidXQgbm90IGENCj4gDQo+IEkg
d2FzIGp1c3Qgbm90aWNpbmcgdGhpcyBvbiB0aGUgb3RoZXIgcGF0Y2guIEFjdHVhbGx5IGl0IGNv
dWxkIGNhbGwgaW50byBzb21lDQo+IGthc2FuIHN0dWZmLg0KDQpDYW4geW91IGJlIG1vcmUgc3Bl
Y2lmaWMgc2luY2UgSSBhbSBub3Qgc2VlaW5nIGl0Lg0KDQo+IA0KPiA+IGZ1bmN0aW9uIGNhbGws
IHRodXMgaXQgaXMgc2FmZSB0byB1c2UgYWZ0ZXIgbG9hZF9zZWdtZW50cygpIHdoZW4gY2FsbA0K
PiA+IGRlcHRoIHRyYWNraW5nIGlzIGVuYWJsZWQuDQo+IA0KPiBUaGlzIGZ1bmN0aW9uIGNhbGwg
dHJhY2tpbmcgc3R1ZmYgaXMgYSB3aWxkIGNhcmQgYXQgdGhlIGVuZC4gV2hhdCBhYm91dA0KPiBk
ZXNjcmliaW5nIHRoZSBydWxlcyB0aGlzIGZ1bmN0aW9uIG5lZWRzIHRvIGZvbGxvdyBkdWUgdG8g
Y2FsbCBkZXB0aCB0cmFja2luZywNCj4gYW5kIGV4cGxhaW4gd2h5IHRoZSBjaGFuZ2UgZG9lcyB0
aGF0Lg0KDQpCZWxvdyBpcyB3aGF0IEkgaGFkIGJlZm9yZS4gIERvIHlvdSB0aGluayBpdCdzIGJl
dHRlcj8gIEkgcmVwbGFjZWQgdGhlbSB3aXRoIHRoZQ0KY3VycmVudCBvbmUgc2luY2UgUmVpbmV0
dGUgY29tbWVudGVkIHRoZSBvcmlnaW5hbCBvbmUgKHdoaWNoIGNvbnRhaW5zIGhpc3RvcnkNCmV0
Yykgd2FzIG5vdCBuZWNlc3NhcnkuDQoNCiINCkNvbW1pdCA5M2MxODAwYjM3OTkgKCJ4ODYva2V4
ZWM6IEZpeCBidWcgd2l0aCBjYWxsIGRlcHRoIHRyYWNraW5nIikNCm1vdmVkIGNhbGxpbmcgJ2Nj
X3BsYXRmb3JtX2hhcyhDQ19BVFRSX0hPU1RfTUVNX0VOQ1JZUFQpJyBhcyBhbiBhcmd1bWVudA0K
b2YgcmVsb2NhdGVfa2VybmVsKCkgdG8gYW4gZWFybGllciBwbGFjZSBiZWZvcmUgbG9hZF9zZWdt
ZW50cygpIGJ5DQphZGRpbmcgYSB2YXJpYWJsZSAnaG9zdF9tZW1fZW5jX2FjdGl2ZScuICBUaGUg
cmVhc29uIHdhcyB0aGUgY2FsbCB0bw0KY2NfcGxhdGZvcm1faGFzKCkgYWZ0ZXIgbG9hZF9zZWdt
ZW50cygpIGNhdXNlZCBhIGZhdWx0IGFuZCBzeXN0ZW0gY3Jhc2gNCndoZW4gY2FsbCBkZXB0aCB0
cmFja2luZyBpcyBhY3RpdmUgYmVjYXVzZSBsb2FkX3NlZ21lbnRzKCkgcmVzZXRzIEdTIHRvDQow
IGJ1dCBjYWxsIGRlcHRoIHRyYWNraW5nIHVzZXMgcGVyLUNQVSB2YXJpYWJsZSB0byBvcGVyYXRl
Lg0KDQpVc2UgIWNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfSFlQRVJWSVNPUikgdG8g
Y2hlY2sgd2hldGhlciB0aGUNCmtlcm5lbCBydW5zIG9uIGJhcmUtbWV0YWwuICBjcHVfZmVhdHVy
ZV9lbmFibGVkKCkgaXMgYWx3YXlzIGlubGluZSBidXQNCm5vdCBhIGZ1bmN0aW9uIGNhbGwsIHRo
dXMgaXQgaXMgc2FmZSB0byB1c2UgaXQgYWZ0ZXIgbG9hZF9zZWdtZW50cygpDQp3aGVuIGNhbGwg
ZGVwdGggdHJhY2tpbmcgaXMgZW5hYmxlZC4gIFJlbW92ZSB0aGUgJ2hvc3RfbWVtX2VuY19hY3Rp
dmUnDQp2YXJpYWJsZSBhbmQgdXNlIGNwdV9mZWF0dXJlX2VuYWJsZWQoKSBkaXJlY3RseSBhcyB0
aGUgYXJndW1lbnQgd2hlbg0KY2FsbGluZyByZWxvY2F0ZV9rZXJuZWwoKS4NCiINCg0KDQpbLi4u
XQ0KDQo+ID4gLS0tIGEvYXJjaC94ODYva2VybmVsL21hY2hpbmVfa2V4ZWNfNjQuYw0KPiA+ICsr
KyBiL2FyY2gveDg2L2tlcm5lbC9tYWNoaW5lX2tleGVjXzY0LmMNCj4gPiBAQCAtMzQ2LDE2ICsz
NDYsOSBAQCB2b2lkIF9fbm9jZmkgbWFjaGluZV9rZXhlYyhzdHJ1Y3Qga2ltYWdlICppbWFnZSkN
Cj4gPiAgew0KPiA+ICAJdW5zaWduZWQgbG9uZyByZWxvY19zdGFydCA9ICh1bnNpZ25lZCBsb25n
KV9fcmVsb2NhdGVfa2VybmVsX3N0YXJ0Ow0KPiA+ICAJcmVsb2NhdGVfa2VybmVsX2ZuICpyZWxv
Y2F0ZV9rZXJuZWxfcHRyOw0KPiA+IC0JdW5zaWduZWQgaW50IGhvc3RfbWVtX2VuY19hY3RpdmU7
DQo+ID4gIAlpbnQgc2F2ZV9mdHJhY2VfZW5hYmxlZDsNCj4gPiAgCXZvaWQgKmNvbnRyb2xfcGFn
ZTsNCj4gPiAgDQo+ID4gLQkvKg0KPiA+IC0JICogVGhpcyBtdXN0IGJlIGRvbmUgYmVmb3JlIGxv
YWRfc2VnbWVudHMoKSBzaW5jZSBpZiBjYWxsIGRlcHRoIHRyYWNraW5nDQo+ID4gLQkgKiBpcyB1
c2VkIHRoZW4gR1MgbXVzdCBiZSB2YWxpZCB0byBtYWtlIGFueSBmdW5jdGlvbiBjYWxscy4NCj4g
PiAtCSAqLw0KPiA+IC0JaG9zdF9tZW1fZW5jX2FjdGl2ZSA9IGNjX3BsYXRmb3JtX2hhcyhDQ19B
VFRSX0hPU1RfTUVNX0VOQ1JZUFQpOw0KPiA+IC0NCj4gPiAgI2lmZGVmIENPTkZJR19LRVhFQ19K
VU1QDQo+ID4gIAlpZiAoaW1hZ2UtPnByZXNlcnZlX2NvbnRleHQpDQo+ID4gIAkJc2F2ZV9wcm9j
ZXNzb3Jfc3RhdGUoKTsNCj4gPiBAQCAtMzk4LDYgKzM5MSwxMSBAQCB2b2lkIF9fbm9jZmkgbWFj
aGluZV9rZXhlYyhzdHJ1Y3Qga2ltYWdlICppbWFnZSkNCj4gPiAgCSAqDQo+ID4gIAkgKiBJIHRh
a2UgYWR2YW50YWdlIG9mIHRoaXMgaGVyZSBieSBmb3JjZSBsb2FkaW5nIHRoZQ0KPiA+ICAJICog
c2VnbWVudHMsIGJlZm9yZSBJIHphcCB0aGUgZ2R0IHdpdGggYW4gaW52YWxpZCB2YWx1ZS4NCj4g
PiArCSAqDQo+ID4gKwkgKiBsb2FkX3NlZ21lbnRzKCkgcmVzZXRzIEdTIHRvIDAuICBEb24ndCBt
YWtlIGFueSBmdW5jdGlvbiBjYWxsDQo+ID4gKwkgKiBhZnRlciBoZXJlIHNpbmNlIGNhbGwgZGVw
dGggdHJhY2tpbmcgdXNlcyBwZXItQ1BVIHZhcmlhYmxlcyB0bw0KPiA+ICsJICogb3BlcmF0ZSAo
cmVsb2NhdGVfa2VybmVsKCkgaXMgZXhwbGljaXRseSBpZ25vcmVkIGJ5IGNhbGwgZGVwdGgNCj4g
PiArCSAqIHRyYWNraW5nKS4NCj4gDQo+IEkgdGhpbmsgSSBzdWdnZXN0ZWQgeW91IHNob3VsZCBj
YWxsIG91dCB0aGUgb3Bwb3J0dW5pc3RpYyBjaGFuZ2UgaGVyZSBpbiB0aGUNCj4gbG9nLiBEaWQg
eW91IGRpc2FncmVlPw0KDQpJIHJlcGxpZWQgdGhpcyB3YXMgc3VnZ2VzdGVkIGJ5IERhdmlkIEth
cGxhbiwgYnV0IEkgZ3Vlc3MgSSBmb3Jnb3QgdG8gcmVwbHkgdGhlDQoib3Bwb3J0dW5pc3RpYyIg
cGFydC4NCg0KSSBkb24ndCB0aGluayB0aGlzIGlzIG9wcG9ydHVuaXN0aWMgY2hhbmdlLiAgSXQn
cyBhIHZhbGlkIGNvbW1lbnQgYWZ0ZXIgdGhlIA0KJ2hvc3RfbWVtX2VuY19hY3RpdmUnIHZhcmlh
YmxlIGFuZCB0aGUgY29tbWVudCBhcm91bmQgaXQgd2VyZSByZW1vdmVkLg0KDQoNCg0K

