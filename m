Return-Path: <linux-kernel+bounces-512086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BCDA333E1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD0571889FB5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD1B8828;
	Thu, 13 Feb 2025 00:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LYrqkNcl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E613FEC4;
	Thu, 13 Feb 2025 00:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739405484; cv=fail; b=P9pjP9fBE+0fMGz0kvhgH44bB3gkfXVxpwFz3Z0h/9+9b2HZBPZpPVQB5yTjaSSKpU/YNh7wHtr/3yxxlAZv0Og6Ltr4Gh1zsaT7BIaEf6qmbT70Ua1l4bfOdIw0vdmxLA/56n/tdthNtvzOKnHllotpDtYpjyX+u+9QoXAGQ+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739405484; c=relaxed/simple;
	bh=aLpEPk0RobaTrYVbpC2KZQz6XrNYGmVHmBin3FfO450=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LW+ZBtiC+1T23Yc21RefMQ4iFS5jpBxNK3UbdUWzv0cVT0aPMa9RTHxzB7EeK27SzqkPiEmGMgViiw59LZ9L1fS5PwEMCY8ONpuiQqlraSuwUBTrMikxHUyDuXuRMIQVvSmx/Ni1VIte9n/Nx8N5lpN+klBVI0gQ0NzSMm2FSkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LYrqkNcl; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739405484; x=1770941484;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aLpEPk0RobaTrYVbpC2KZQz6XrNYGmVHmBin3FfO450=;
  b=LYrqkNclWkAsu5zbtn+1GRytM97z5Oz9Lw+TFPFAixY/RG6Xha/TEIHD
   vLEF0gquTTdL1KWWCmRa20vDkqonTInoVAQ4OqqEVKAPbvm29MJjJsBam
   +h5x/EAqFku/BnUuPvyARUFIjpV2p8ICVyH4agXZdEBH+Ja+sPPk/I2iK
   XHq12kjn7/b9BJX3vi/irGJoyIlH8LXIoiPO5SgtwmsLG5vl2/C5n9ewm
   WXepvvxPY6Hex50wbf3Gcp9J3Iq/zug9B+yP5rkW9/JQFxAWysvV+XumE
   GN7RxoyC87UzzlYurkjuPmw59DHPCp0RW5Bxv6AT6qtai8wW/m1HAUKw6
   A==;
X-CSE-ConnectionGUID: 2OV1PqsNQSim+rvk9p3vkA==
X-CSE-MsgGUID: G3LucsbvSIGJ1ESh0ozing==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="40121837"
X-IronPort-AV: E=Sophos;i="6.13,281,1732608000"; 
   d="scan'208";a="40121837"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 16:11:19 -0800
X-CSE-ConnectionGUID: XaWXfx1MTE6PoKiPlKRdaA==
X-CSE-MsgGUID: 2wqMW88WTWuT2Aryf2uAmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="143922703"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2025 16:11:17 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Feb 2025 16:11:16 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Feb 2025 16:11:16 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 16:11:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jvTyod6MNmSrzzabrajVPhIf5ltZL5vt6GcXjIeEQUMgCSpJEUR8DnNfEwGaQg+jEZnZuiwR+6SM0ix/2W3Hwx2bTCJkRJ8YWHZa6wvN8Ud4iFmNwcpM7FnyJeTQHO/mYVPuuVAW9bQ2oG6O63T8lf6gXFCx7uvmlCG/skg6pF/BsXdfpKa04GlLjr/VJ2l0yMwkddi9b9QcKv89qzefmnSSMdyBoFXqcS6zu/EGH4wzdbxRqJEwZG48nN43AXzy2BnAaXDIiDTHEPXzl5trdmjHa6fS76csrU5QHyOdOYw9CLOlDOUvIGpCZ08krgR2IzF35FOrWWCshJUHqRuIbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLpEPk0RobaTrYVbpC2KZQz6XrNYGmVHmBin3FfO450=;
 b=r5tSZBLZV62WfN/IGe/y0ysmm7vMgqSv6OCMydgyCLkR7/xqhLp/dzslAKRiT+N00ziQG68sXZDdpFc6TfggZ8ZBB01gZerpRJvp7P6olhrc+cz+7npCa0SmJp6F8TreOHwxdokHV69XLkmhg9jVFZwrBenTgh80dJ88+CVhBC3Jjq5XC3FwkZ2obSonvFg9TyQLBZ86AIXwpaUUaGesK38OjfJyuyXxPGJEKyz7iw7dQVwG1XwbOoOZwgzYqP1hgJX5r9ixEhKoomdcS3TySNqhLCim6gjKA6L0sKswkOPAdsBv5byZtWR7Hb5FxfuY3+DJirV3wqZvtkwA0VP+Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB6551.namprd11.prod.outlook.com (2603:10b6:8:b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 00:11:14 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 00:11:13 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>, Dave Martin
	<Dave.Martin@arm.com>, Babu Moger <babu.moger@amd.com>,
	"peternewman@google.com" <peternewman@google.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"fenghua.yu@intel.com" <fenghua.yu@intel.com>, "x86@kernel.org"
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
Thread-Index: AQHbbQsur7YXoEmn/USrZUfWgYnla7NEEeSAgABhEoCAAAlr4A==
Date: Thu, 13 Feb 2025 00:11:13 +0000
Message-ID: <SJ1PR11MB6083A2CD66FAE5DBEDCB96C0FCFF2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <Z6zeXby8ajh0ax6i@e133380.arm.com>
 <9e849476-7c4b-478b-bd2a-185024def3a3@intel.com>
In-Reply-To: <9e849476-7c4b-478b-bd2a-185024def3a3@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB6551:EE_
x-ms-office365-filtering-correlation-id: d5a77dcf-8391-423d-c37d-08dd4bc2ed73
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UGVTL3FvM3drYUFYOVc5UnUxYkJzb1lUeVk1QjBFMmhzNjN2dm43SzNUM1BY?=
 =?utf-8?B?Vll4bjFBNHVuRFZhZFBPb3pKOHpZbHZ2SXdHQWJIYTBmcnduTjFMZzBKeTFm?=
 =?utf-8?B?eVVmbnJXenJDNUVjNHgrcXJVWkkwM0h6WlRpTlRrWW5wR0xIOHRlV0w3b1ln?=
 =?utf-8?B?QTFSU1BIbHNxWGxkQ3Nnb09nSi9qZWxCVnQ4QjhXakxDekVwK2o4M1dWbTVS?=
 =?utf-8?B?czJaZFRtWnA4MHBQWjZaUEhXOFJtNjV1QXBSZGtZU2d0RXpzRjVFcEJIekVj?=
 =?utf-8?B?VEsvTmFEMUt0V0V6QnBTUTNkZVl2M0NMdWl6VWg1RDlPVlp5SEd2UHc1OWpZ?=
 =?utf-8?B?amNCS1ozVWY0RmczOXk5MldmNVJyU1pGQjdGRXlyMGMyLzZBaitieTBGbUdt?=
 =?utf-8?B?YUZjMmJqbjMzSTY1NWJWSXM4UjJlZ1dpQzZRaUdvN1hNenNKaWpRQUNvbDho?=
 =?utf-8?B?WmhlbFpqWlJlNlBYamdLSGI2QmVSOXUrZTcrbjJ4NmRabGJkWVFKZTJVRDZi?=
 =?utf-8?B?QXZpYVdCZnlqTjdybko2M29OQmJ5bVc2aVI4QWhhdTV0Y25lMjhBbXNpVS9S?=
 =?utf-8?B?ZFRidXppcXErOE9ZcnBuQ25nR3hocXFnSm5XWVdhUlpmNEpvMVpHUWJoNEY3?=
 =?utf-8?B?VU1STzNWaHhaUVhlbE1CVWZMdFJpVmRCYnRvMDRkMldSenZTcEVtTE0vbkV4?=
 =?utf-8?B?T3NZNVNGOXB1ZWhxVFpWRDZxQzZER0psbUZiaEUyMHZNenMxQlJCN3E3Y2pq?=
 =?utf-8?B?ZHFTbG9IWDF0bVZRdHdQcHVaSTd3OXNQTmpldThZM2p3NUxVS1hFdi9ITWll?=
 =?utf-8?B?SDZmaC9iZXVPUWlydzZHbHJGdGhaL0F5RTB6ZC9teVFnNXBJb0tqeFRmQkVX?=
 =?utf-8?B?VURXVXFHSkh6M0xEaTZUYkRSOCtFcVBiN1JCY1hkckhlV2tWZXVRcEZNc1cy?=
 =?utf-8?B?Y2o4dGpoODErTFJtbjUxdDhEeDFNTGdFSDJpdktVSnk0Vm9sbk5MUm1ibVd6?=
 =?utf-8?B?Z2Rnc0hNM0ZvVnIvQUk0Q3JXMDg2NGI2THpsWnNVZk50TUp4MU1RcFNnaFFQ?=
 =?utf-8?B?VEVBS2U1YU1DSGhXdjNGdlVEVXArc3RtMG9wWklaTC9BNDh6dlJLWEFOclQ2?=
 =?utf-8?B?STBqOXFOZW9wamg2cVhkTUdlKzk5Yk1HZXd3c0t6cy8rL3NpOXRNUEVIT0Fi?=
 =?utf-8?B?a1g1akdmcXkzdHk4MlJZVjczZk5xdkFiMjZEdk9iSWsxUkVaNzBabFNKc09T?=
 =?utf-8?B?c3dzTGhMVUxQbk5VUGU4Y0dROURmdFhmQkpsa0QrQXltZWNYbmQ0bHhZMlpo?=
 =?utf-8?B?Sko4TWdBTWRJeWp1ZDBFdFZkRS8zaWhscVhsWnhpZTVZSzR6UDFwTWdtZjR5?=
 =?utf-8?B?ZzhMOEJtUXFKYUg3Z2J3NVVveDRkUjBEd09jYWZ4TDlyWTBtKzUxcUNPdXdk?=
 =?utf-8?B?U3dtY0lZREoxTFo4WUQ0SHNDbDhXOGU2TTk0VjVZZ0tkQlpoQ0dYWnJQeVV0?=
 =?utf-8?B?NmZHMmsvUjkwSEpyaHhEcXdlUGh1QVE3MGlydjZ4TE1wNnczNWdyaXh6cVFq?=
 =?utf-8?B?eXFhU1lYTUxtMEdIMmgzQTY4aGNwc1pjV1pZNVJqanNxcGx4YVZYZkRKRVVR?=
 =?utf-8?B?Wkp5aXMzMkpsS2lwVmtJcFhFdlU2QlF3T09tOWJwOHZOc3djSzBmVXBRNzhK?=
 =?utf-8?B?UEhpYzN4a0d5NmR1OWZSWTZQSmdzTHd5OC9tSVNpeG5VNytxeEF3Z0hIeEpG?=
 =?utf-8?B?dEdOL2JuYU9oZEhBWEdYT2YzWkhpaGlhZUdPSkQyYUlCOE10bUZOMHBvYWRm?=
 =?utf-8?B?dUU2STRKdUZmL0FuMGhhcnZnVFQ4N2Z2RHF6dGJIRnRYQVdrbHMrZE5YdUlL?=
 =?utf-8?B?UUJHRTh6clN1Q3ViWE5mWDVTSXhhTHUwVWZhMDlHcnlBVFVzMmZpS0ZoRjRS?=
 =?utf-8?Q?DG9Rpgkhahz15hcQRkhM0MOWxJsHYXs4?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVRJQkt5aDRWUmZRTWVMZGVRcFdnaTk3OTNYN3RQejdzL2t0MTh0dlIvQkxX?=
 =?utf-8?B?QUNMQjdjWFVjSzNncUxmWERqUXZwUkJJclRjSVFONWlhdmF2bER4ZnNEODRB?=
 =?utf-8?B?ODl1MnV0NzZVQkRKV2tCUHFYZ293TWFxaGV5TU5LMmYvRC92aS9rL0FkbXVn?=
 =?utf-8?B?blFsb3BGckl0MVBUOThhZURrMVc3UlA3MEJVM2JWMnVubGR1ZE5hMDVpYTFZ?=
 =?utf-8?B?UDlZNit4aDZ2blo5Wlp3VVU0Smd0dURRSCsxRWlZMi9HTDB0VUdUT2VXN1I0?=
 =?utf-8?B?Tmh4YWF2T0NrNUVPZzBBcnhmRFZFcVY4TW0vWm5MZ2psTnBpdG0wSHFsVkQ3?=
 =?utf-8?B?UlpDRC9iOHlsOVUrRFpxQ2pEMVo0Z0dmVk93aW9HUTd3TWNpci9vVTR1bG9M?=
 =?utf-8?B?MWRadEt2QkpxeXlrSVZoUE0xTC94cm5tbExJU1E3MU1lZmw2YWdQeVgyZE1Q?=
 =?utf-8?B?cE9UazZnVVZVRTA4TUU0VFRjUk11MDVYTWhtQnlVeCtRdERJK0JaN2wzbnVh?=
 =?utf-8?B?UDNqYnBtY3JtcXlUd2paWWxzYllSWTNVMFFQRWgvSjcxTzVUMUZvVGxHMHVp?=
 =?utf-8?B?TWJ6RW9UU1Z0cmlLVmsvZ2JOY0swWkdmakxkZXk2N1o3TGc0VTh3ajRKdS83?=
 =?utf-8?B?TXg4YWFLbDlhb2VDbUJUZGt2clR4ZzBoZkxXbmpqQTZPTEF2dnFZYkx6dGR0?=
 =?utf-8?B?T2xyM0E5Z1A5aHJGd0h6UVZYSXBvdlFGNW9KTVFWZ1FTb2VwZUN3QVpzaGF1?=
 =?utf-8?B?NEZqMU1wN1cxenlqcXlLT2pZQ1pPb0NIN2NXZmpsaUd4aXdybStsekdLdDdk?=
 =?utf-8?B?a2p4SFU2SkVwUVp1V0RpZEM3bWZKZHlqZWNFQTNTME16OUJFU2tVQnV1a2Q2?=
 =?utf-8?B?TU4zV0s2ODZVMWtKMndVYmFGMTlkRnhsWnU4ZE9CYkxDaTNTWHNjMzcvK0o3?=
 =?utf-8?B?WXQ2eGNncGY5MXFVVUJKTU1uTTJENEVrR1pCU29VbVBMUUdTTDlCRm5XRU81?=
 =?utf-8?B?WWlVRHN5NU84elFmK1htbmc0ekpUdDdqMnd6NVdDYnZQWmQ0VlM2UmlYL1Va?=
 =?utf-8?B?WjlUZFk5UmJkQkZmS3NMOUhuVHhXK2JONDBINzlWZkZSdHEwV0lJb2RMTEU0?=
 =?utf-8?B?T3ZScFlUS1lwR1JrL25jTThqSzBOeTlZMEdxQkM4WGU5WVZodFczcXBVU3Uv?=
 =?utf-8?B?VzFhS0hrT2gxaHRSKzVKZjV3YXJtUlNGcnU0Lzd5OUpoYkNINVNkUGNUazcx?=
 =?utf-8?B?S3VYd05ibFo4Yy9JeTdaYno4aTlkenoyWnN4OEFqNkpaK01pNkFzalV6dFNy?=
 =?utf-8?B?YlN4eDk5NUl3NUNldEVEd0hhM2xrWkdDcVJmNUxQUFVPNERoalJ5YWJZdVNR?=
 =?utf-8?B?YkFiNm5iazBLWjFpWWlmaTFnb2JCck05ZDduMkFhTzM4OHdFQXd4bUlsVm0r?=
 =?utf-8?B?THpwTk9DME9Cb29YSUdBdzFBWjhoVnNXRzMyRW5xNmFZdTIzZlFYNmo5Q0Zj?=
 =?utf-8?B?Y2pLcDQvaURvZjY0TXJjWEdPbEovS28yRkE3cnN0Y2xkZlkyd3l0MUZCNzVQ?=
 =?utf-8?B?ZHpvUVd0M3hBQTNQcHJNZWh1bEg5eUJLakFxZFhDL3pFZzdxd00rdXk5WG5o?=
 =?utf-8?B?OUg2OFRoSWp6V0dVcXFXcjVjSkw5VldsMlBGZVNkbVlzQzA1RnRmVDUzVzVt?=
 =?utf-8?B?SCtIVGhLZGlnOWNzNDZqUkxJNGVia2h4YnlHU1ZtWUxpRndZMUcyK25jN1V6?=
 =?utf-8?B?SmNxMW5BZmZVR2VXUklEZUdLUHlvRmtDQ0RiUmdMN0MzRUNXTkhmbnB1SExv?=
 =?utf-8?B?amVoVlNobFdhTUpGYnRtc09SU3EyaDQvWEZTVU5wVDNUVDlSampjVGhTOURp?=
 =?utf-8?B?VmhESzlBMnpiVnJpckpBekJ4bU1sYWxxVDBqaWk1cHdIWEpKSE5KSXFuY2Fv?=
 =?utf-8?B?aUVlOUplcEFSMWxqbUhSc2xjcjVMV3AxZXJpV1Q3SW04YUw2TlJzZzdHdXRq?=
 =?utf-8?B?UVNIamFRSHZqSkUzc0JwY1F2eEkrRUJITEw5Zjl3R3BhTFU3THhNZDJzTTNj?=
 =?utf-8?B?Q01mOEdJV0VwcFJQdTdzQUtFdkV2ZXZZbVhmM1RMS2FoTC9FQ0pBbklETWF4?=
 =?utf-8?Q?pIKBHQ4I+oa4L7ZpSee4DpAAU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a77dcf-8391-423d-c37d-08dd4bc2ed73
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 00:11:13.5621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PYzAybV8AaCPTER6b2q1MjSOcsbo6b9kmcyvA4awU8bmF+ObF1E05NlQnzbdP6FfBRv79FgnKdq7ZVQw92ZZAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6551
X-OriginatorOrg: intel.com

PiBJIGRvIG5vdCB0aGluayB0aGF0IHJlc2N0cmwncyBjdXJyZW50IHN1cHBvcnQgb2YgdGhlIG1i
bV90b3RhbF9ieXRlcyBhbmQNCj4gbWJtX2xvY2FsX2J5dGVzIHNob3VsZCBiZSBjb25zaWRlcmVk
IGFzIHRoZSAib25seSIgdHdvIGF2YWlsYWJsZSAic2xvdHMiDQo+IGludG8gd2hpY2ggYWxsIHBv
c3NpYmxlIGV2ZW50cyBzaG91bGQgYmUgZm9yY2VkIGludG8uICJtb25fZmVhdHVyZXMiIGV4aXN0
cw0KPiB0byBndWlkZSB1c2VyIHNwYWNlIHRvIHdoaWNoIGV2ZW50cyBhcmUgc3VwcG9ydGVkIGFu
ZCBhcyBJIHNlZSBpdCBuZXcgZXZlbnRzDQo+IGNhbiBiZSBsaXN0ZWQgaGVyZSB0byBpbmZvcm0g
dXNlciBzcGFjZSBvZiB0aGVpciBhdmFpbGFiaWxpdHksIHdpdGggdGhlaXINCj4gYXNzb2NpYXRl
ZCBldmVudCBmaWxlcyBhdmFpbGFibGUgaW4gdGhlIHJlc291cmNlIGdyb3Vwcy4NCg0KMTAwJSAg
SSBoYXZlIGEgbnVtYmVyIG9mICJldmVudHMiIGluIHRoZSBwaXBlbGluZSB0aGF0IGRvIG5vdCBm
aXQgdGhlc2UNCm5hbWVzLiBJJ20gcGxhbm5pbmcgb24gbmV3IGZpbGVzIHdpdGggZGVzY3JpcHRp
dmVbMV0gbmFtZXMgZm9yIHRoZSBldmVudHMNCnRoZXkgcmVwb3J0Lg0KDQotVG9ueQ0KDQpbMV0g
V2hlbiB0aGVzZSBhcmUgcmVhZHkgdG8gcG9zdCB3ZSBjYW4gZGlzY3VzcyB0aGUgbmFtZXMgSSBj
aG9zZSBhbmQNCmNoYW5nZSB0aGVtIGlmIHRoZXJlIGFyZSBiZXR0ZXIgbmFtZXMgdGhhdCB3b3Jr
IGFjcm9zcyBhcmNoaXRlY3R1cmVzLg0K

