Return-Path: <linux-kernel+bounces-445148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD57C9F11F9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 686A6280C10
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D222D1E1C1B;
	Fri, 13 Dec 2024 16:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H7UMpAly"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560D11E3DF8;
	Fri, 13 Dec 2024 16:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734107091; cv=fail; b=N2AZtBd9pC1Jm0ncLnzX4QcwM7ROa14xopY75HRvyZ/p68bp96U6CfW64nuz0ETcmfrZ+k9sKM9fdjCzVn3nrlX3h4uKS9hhVKJZW2Ml/KASiH2s1yIByCg03YRWcNzLd2QS6ptuVAONhBsgc8Y335XRZZV7bBlMzxOVTksxRaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734107091; c=relaxed/simple;
	bh=WpnfH1sQbXqZNrFAaH6HEDV5Ar5sXJb9oHmTEWgttSw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gJaGQOmlW/iaM5bbHM/kn4bsyQlkkNwLMtLDwyKUiknEqAlfK4ksK8cyeGzqX/j/bosQp5PCkPnz8IVvOr4dNloXw9qOoBKqrBoACvJvasf2KRFaDYptIgCGHiZEnREiu0H/xO9b9a4qGwTlXKw4uwect722CE0ZfUgeI3xh5tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H7UMpAly; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734107090; x=1765643090;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WpnfH1sQbXqZNrFAaH6HEDV5Ar5sXJb9oHmTEWgttSw=;
  b=H7UMpAlyUMQfZMhgAhEyFpfQeT3HZ0QuMhakTBrLCw3HW/3r82BLgNyG
   IK+cvCoXAYqn0A8LlPHA0YJ/SNuIvExON5AO2/B2NkaQRHy7iQwuc1MqC
   ukJ1pEPBywMDGw8zFNd3CMve3CTFNUSyb31oKKPKihkCusAgQPHfXuNUy
   9NwKy0YlnYftKrbOM/cMs6hDdRU2AKaXNs3AWUE+rZdJuNDkKrOis6sqm
   nxhdB2dq0HoKUEnYl5abSN7VvYLklQnHSs7rrALdAwiIvs2sTFG4BGXa9
   oYQyA4e1fbUxklsJN9PW9LJu1PDFzbHqDJ3kTVs4EhMiT6Zo64JguWH7g
   g==;
X-CSE-ConnectionGUID: DArX3wM1ScqR6teCiq7IKw==
X-CSE-MsgGUID: Hz0FJAaDTVuKWa7GW4ShlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45974827"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45974827"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 08:24:49 -0800
X-CSE-ConnectionGUID: PHz5KniwQiS83In3c+Z6yA==
X-CSE-MsgGUID: 1Of4+/w9QvO2Z790SKWn3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101542336"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2024 08:24:49 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 13 Dec 2024 08:24:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 13 Dec 2024 08:24:48 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 13 Dec 2024 08:24:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXNv/S9zQtBQKE3OsPGxpRp2mjQd+fqjsvzMxLu4SfHCevJhkKOpbbkPMxo5zQV1hPW1hDkw2GvnBrRHIRIhk/rqHvbWJBI46UeCLc9QGznXqyvgzMlZj39RYQZ0MvlAG8neHsLBDRgQhTLe5GA+QbU48FYQhQxQ7u7SCjeRjUJi3xqbK2x6wpS0OMcvikeXtTbDLh379nxOqdHFixFZUiMnKq0Pzm8RxGR1j2HZmy7LTN8JszYZp0dSG2yCINB9O5N0BNbzZC37J+Zzt0dld2YU56+Te7nQfZQtFr6H0pXrWl+VTJEzR1FTWA/+Q+D+CmTAOpEczRvVEBK4C3dxyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpnfH1sQbXqZNrFAaH6HEDV5Ar5sXJb9oHmTEWgttSw=;
 b=nvthzvSRdoCqkje87scjaLjdr04/1DndUW1nj5gKSZ0/1u8eS/um4u7z78FVXrrirLNpCgR3bnnPKAKyIS8eiQzv0Z9lLWjOwlbjV99ciz8nGy2bwlvgagymh4/NJC1JBujX06lh5lmZFmqRFPdouox/6+aWka6keD+dQdMGChAbmR35SNX7ViYgZIt8j/aFowef/i+ZyO4fkgedrwOva5/0wihzi4hIhtrEfOv66H3GCNpOsqnfgLgfjTb+9RgUQ6t1EKytkXjsan1SBUFuT84Z50/8rYw4ylBZFt6KO3V5hhVmOz5V57uxDombmorHR/Bw+fvcilh1GpUW5ki7Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH2PR11MB8779.namprd11.prod.outlook.com (2603:10b6:610:285::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Fri, 13 Dec
 2024 16:24:43 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 16:24:43 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Moger, Babu" <bmoger@amd.com>, Babu Moger <babu.moger@amd.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"peternewman@google.com" <peternewman@google.com>, "Yu, Fenghua"
	<fenghua.yu@intel.com>, "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "paulmck@kernel.org" <paulmck@kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "thuth@redhat.com"
	<thuth@redhat.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"xiongwei.song@windriver.com" <xiongwei.song@windriver.com>,
	"pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
	"daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "perry.yuan@amd.com"
	<perry.yuan@amd.com>, "Huang, Kai" <kai.huang@intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "seanjc@google.com" <seanjc@google.com>, "Li, Xin3"
	<xin3.li@intel.com>, "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"ebiggers@google.com" <ebiggers@google.com>, "mario.limonciello@amd.com"
	<mario.limonciello@amd.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, "Eranian,
 Stephane" <eranian@google.com>
Subject: RE: [PATCH v10 16/24] x86/resctrl: Add interface to the assign
 counter
Thread-Topic: [PATCH v10 16/24] x86/resctrl: Add interface to the assign
 counter
Thread-Index: AQHbTNME0+qEIh+rBU+JljrzPBTS+rLkVfcAgAAEbBA=
Date: Fri, 13 Dec 2024 16:24:43 +0000
Message-ID: <SJ1PR11MB60831C44DEE7711F93C3C26CFC382@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <cover.1734034524.git.babu.moger@amd.com>
 <a72e23d8fe43038cd319403ed68b657fb36e23df.1734034524.git.babu.moger@amd.com>
 <Z1tzyrUYTFR_iHuJ@agluck-desk3>
 <e43b10b7-60b0-412a-b55f-96271764faa1@amd.com>
In-Reply-To: <e43b10b7-60b0-412a-b55f-96271764faa1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH2PR11MB8779:EE_
x-ms-office365-filtering-correlation-id: 4b6840e8-2690-4922-d711-08dd1b92a6f2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MERlTktMTEp1cGxucHg5ajJPN3oyN2pGMjVLV0UyZEJnNWQ4QVR5UXhxSkxn?=
 =?utf-8?B?NGsyRjc1RExUYTlXbStKaHZoSHlIcXgvWnROVy9uODNic1R0UEgycG1MY09y?=
 =?utf-8?B?RGF2T1NpQVpEMkI1UWZ1VGtJRlVxYkM0aGdQc0gvUWx3NlB2QUozYU8xTmdF?=
 =?utf-8?B?NU50d3Yyb1VKSFFNSWJzaEl1WkxRNlpESWZ0eUVDU1ZpWE5nRjNraXhmZHR4?=
 =?utf-8?B?SDdKcTArU0J3NThJNzA1UjNYMlBVUzBVV2k4eHAwcHRPVE5mL0k0bXNnWk1R?=
 =?utf-8?B?ZWZJUm1aQnpseElLZmNsUnoxanNMR3U1VHg4U1VCcHRFTVNpcm10QU9oOG4r?=
 =?utf-8?B?anNDY1FLUWRDMlhzZlNKQVhHQXhqODFGc2t4cVllS2xEUHFBbUhJaTEwSEs1?=
 =?utf-8?B?Y29WQkEzWTB2UHU3YU9GaDB2S1FNTkM3eDBhVUhoY05nUWcwUWZwRnNST0dw?=
 =?utf-8?B?NmxnWXc1aXQwYVRGN3RSWXZ1ek1jSFprc0pFN0lQTzlNTnBIV2NYMXNSWWFP?=
 =?utf-8?B?SXhlelR6Mk03TW1zVDJWVVBzQzJLdE9rN2tXQjh6SDBETTlUTnl4a0ZoQkJQ?=
 =?utf-8?B?QkMrQytSYUtmUDNoeS9GZzBaZkYvM3hOaE54T3hQeUZXQjg1Z1VHRGF4dStF?=
 =?utf-8?B?dlRzSzYzdHY3bXpKZTN3NkVZcVIzZlI0MmRHaTMzTTFGeitldEt2UFYvK2l0?=
 =?utf-8?B?ZWd5UWxpV0tmSG9oeVg0NVR1N3VoTjFSYkVHVTFmTzgrcW1BbjRLbm9vM1Q4?=
 =?utf-8?B?anUySktRRWFsNUQ2RGhJb0YxbzMwWnE4SHpDSXBtS0NkamVMUzJYUVRNU3BL?=
 =?utf-8?B?OFhnNnJQMjFCV2NuWm9taUw1RGZzRmdiRVF5YjI4NG9ZRGdUZWkwemRtVlJR?=
 =?utf-8?B?NGdMN1RCOGs1MkNOdlBYanhsdkxVWDA4b055a3R0T3dFTGhyZGFBU1Ird1c3?=
 =?utf-8?B?OHpsSDFYNHVRQk5mZTYzNWtXUnZzT1B3RzdSWG5mMHlnMnpSQVM3UXpTd0Zq?=
 =?utf-8?B?a2dOZ3JpNzRKL2NCYmMxZDhNbzBhcVZPOWMvNnhsVVVKQVZDZGIrWmhiS3RB?=
 =?utf-8?B?TjVVU29JZEVrYndjeWNvTWl1dnVRbGhUTVVWb3lNV0lsRXBKdWtxeGxTRzRq?=
 =?utf-8?B?a2ZpaVgzTVk5dGo3R1IrZHAzVjZsUUpGUXlONGE5d2xzK2p6S2NOZlJCWVFS?=
 =?utf-8?B?a1drU0lSYWJYU3h2TStMQ1l2TkgwdE5henZmTlUxNk5HanBDUThQbEh4cElj?=
 =?utf-8?B?VHBETmhJNUpkeXY4YnB4bThKZHpMTnBxWk9RZXNwRE1HNHlOVE5waUNjSWJX?=
 =?utf-8?B?VllLdkJPNU9nWnFVZnBlckdDRDl1WkxPMmpjRVdmOXB6T3hRUlNrSTJKd1pO?=
 =?utf-8?B?eHBmWjRURUcwQ0ZrUG5QVklGRyt6cXRUdWx3eGx0Y01XeDM5UDNhbzg0UXZ2?=
 =?utf-8?B?VlFERVA2djAvRFpsclNQbHhoOXZ3dkl5NXd4dmQ5YkdBVU5xR0NwZzVITHVN?=
 =?utf-8?B?TjE4MldFcEdIOFBhdm5VVldTTVgvb055MnJ5YkgwV2JtTzlBeTBLemVoa2ZD?=
 =?utf-8?B?eDJYZTZHMGhESEViSFI0cEZ5MnRPSWtKTndmcEZUZTN6WFVJRllGczFjbTdY?=
 =?utf-8?B?YWtSenVoVEJsSkVUWkp2RlN1V1FDa2VaSFVWQ05NbldVdTNvNDJOQjZ2KzNh?=
 =?utf-8?B?N2VxZWNpVVdZWDdGZ1F2cWR6OGdEaGJzdXQyNnVWTlkzYlRna1g1TnBZeHV6?=
 =?utf-8?B?bmFYcmR5aTFrYVozL3JBZ2VoSmliZ1NmNklqU2pXU2JoU0tVRFRWQld0UGph?=
 =?utf-8?B?RGJlb0VEc1pUSXoyN3JvTDcvV1Q5YUt2QmdyaUZiVFFoM2M3SE5kZEcxcUZn?=
 =?utf-8?B?WUM0UG1VbDdXS0Fwd2ZzYWJ6c3F1bWtSbmdXYnRPaXZKVlE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ay9EUlRCV2ZIQXNzMXlwcnEvUXgvaEExT08zRUNXWC9DbnVlNkxYcHVCRDlj?=
 =?utf-8?B?MFcyNkIwcjFXa25CT2hkeWVXdlFuN2pzOGcwV0Z6cGNaU2RLK1V6TktZeEMz?=
 =?utf-8?B?RzZqbU9veEozNTI1ZzE5SDA2Um8walZhL3VXMkJhem5XczFPSVdoQXpBT3Vz?=
 =?utf-8?B?ZDJQWHM5cCttUE5iUW1GcWtTOEhtODJBb2lnbXc4S0ZzTHBwWWxJMnhIcnov?=
 =?utf-8?B?SG9RV0JmK2R4YldDN1pWaWlrcVFOMHV6SnZIRXBLZDUvVERwcVhRWjdCb1Nx?=
 =?utf-8?B?cHh3WmNDeUl6MjNFRCtSUGtJVFhrRW1QTWhpTkw3dU1GZS9QMHQxd1luVzhu?=
 =?utf-8?B?Q1pWaEM4cFJkS3VJd2hDS3dDa3NlSC9naXNCc3lEZER6Y0ltK1BubTEzVnlv?=
 =?utf-8?B?MGdqV1RtRGdFNmM0VFBUK3hoQVF0RkltdXFRQ0Y4Mk1FWVpPK0crc1lxUEd0?=
 =?utf-8?B?V3VEbnFicThCVitxUjVwU2s4L0dkc0JSRVFjTEJwRFZ5d3NWTjZ0N3FWdW1h?=
 =?utf-8?B?VWJmR1JVc0hZaW9VTkNnZUNUWlA1MkFtR0Y2SVpqQVNJRTdkZkdibExURHFk?=
 =?utf-8?B?NlJtR1ZNQWh5K3d3aGg1Mjcyc1NnaDJCZjNkTGgwT2pTVW9NbzV2U3NYT1Ro?=
 =?utf-8?B?KzZyaDZZb3BuZ1BlNng4UGd6NXRZY0kvQVoyMnZ3cXVaRGRoM3ZnVHQrTGR2?=
 =?utf-8?B?bUs0ZGdxUVovSGFGNm1KZ3R3M2kyWDI3bWh2eXYyVUxsNmduTnBXbzVQb0wr?=
 =?utf-8?B?T09RT25ibWh0TkVkcERJemtwV3p4QWdmSDlTUWZhaXJvMGxiZFN4TjU1eWtJ?=
 =?utf-8?B?RTRiL2tMR3dsWGVzeHhTenpWalEyZ0MyRklwa3FsczBhM2lqZGZKWCs1MG9j?=
 =?utf-8?B?VzUzeHlVWVFBZkdjRVlVUmliSUNxSnVwSCtqeG1WVDJJZjFLbGFTWGRCQTZ4?=
 =?utf-8?B?WDFiMmUyNTlWNVk1cW9zOHk0WFpFbzNYenRoOTUwemJYaXBYekxqWC84Mk1E?=
 =?utf-8?B?c3hMRURyYno3dHVCSFFlR3JIbWphUGpZMkxDZDIyU0Y5LzRSbUd6MkI1TEtW?=
 =?utf-8?B?L3hMNVdGYzM5K3RBUE5LUzMxL3IyM084NUdHMXBHWUZzNVdxVUdDcWo5OWZv?=
 =?utf-8?B?d2lyMTY2QXRrdWJsa1lxZEZTZllaVXZtWk4yUWRacG92Ry8wcFAwdGhKanFa?=
 =?utf-8?B?Tk84VEQvVUtIMDJxSGtpd0VqQUl1RzhNa2ZzWVJVVWVGV293V0RzWmdBNmJy?=
 =?utf-8?B?anVMRU1YSkEzRFRWWTI2UER4T2lDV1MweHpsL2dYNHA0VzhlUHRYSWtpYmE4?=
 =?utf-8?B?d3BTNUwvdVY1bEp1UE1TUFpWc0liYzEyc28wUG5WWGdlcUIzbzdlazMwaS9I?=
 =?utf-8?B?VHZYeVR4eTNZUmVPTExKTzNobHVzeG1NVXVaQWJTUmNuYjNtbFljTEFRcjlV?=
 =?utf-8?B?Z0R3REM2Y01Gc3VKRjd5UFJMZVY3bzMyL3IvVmNqWVBYdFZBNGRRYlMzeFkx?=
 =?utf-8?B?ampVdFNMYnk1ZFlqNks5eEwydzBEN3AzRU1sU2VNaWM5Z1h1L1dVMFQ4MHYr?=
 =?utf-8?B?SFRRTEVuVk9oYXlWNzRnSFNMUXpHZmUxRVE1a0dSZFhlR1ZVNHNqZXFzM2tV?=
 =?utf-8?B?TW90WVkyZzArdGtCNU5aeFpoS1ZVSXRqblJLQkdVZ3ppMVhEeUtkOGJZd1RO?=
 =?utf-8?B?SmFDcHl3cWs5eDZLUkRPTWlhSFpxeUN3diswbDhiclBQOU9INVVsM2hZY2g1?=
 =?utf-8?B?dUxhZ0RVSXRCL2NoMTdPdU5XWjZOalNPTi9mbnNNbXR4WnZhQzYxMzdTaHRJ?=
 =?utf-8?B?eklFY3BWNFlGQkFuLzNVQTBRbjVNSmxOa3FheU5EWEtEeGVFR0FRWnBjditY?=
 =?utf-8?B?c1VLMndKRTkyRSt5TElSSmpVcjJ0Rmo3Mnc0WElJTTJyTjRGUEZlSXNzdXNy?=
 =?utf-8?B?a25YdkZXWFFHOENGOVZOdkx0cGNjOXVXc0ZGcnJRRUNMTzNIQkFzQ2JlZmpy?=
 =?utf-8?B?WkVPbStLUGg3aFlmNGlTcmtjR3NscEdYbUpJcVAxVHEyejdudjZEY2JEbWgx?=
 =?utf-8?B?SWdsOVFlREpLUldjV3pOd0s4bDI0OWpFaVdxTG45bWZpVmFqN0UxOS93MGRu?=
 =?utf-8?Q?o1LOpcdtsKYqC9bT+eDxdSwgX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6840e8-2690-4922-d711-08dd1b92a6f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 16:24:43.6452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oE7XtOdY6bhGwaeJATyNr8ChCYMCdeK5Fwt/JoTu9XOvo/7H6jSD/D0vWURZuzdePpcanGPy8AUHNBfIE4Mt7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8779
X-OriginatorOrg: intel.com

PiBJdCBpcyByaWdodCB0aGluZyB0byBjb250aW51ZSBhc3NpZ25tZW50IGlmIG9uZSBvZiB0aGUg
ZG9tYWluIGlzIG91dCBvZiANCj4gY291bnRlcnMuIEluIHRoYXQgY2FzZSBob3cgYWJvdXQgd2Ug
c2F2ZSB0aGUgZXJyb3Ioc2F5IGVycm9yX2RvbWFpbikgYW5kIA0KPiBjb250aW51ZS4gQW5kIGZp
bmFsbHkgcmV0dXJuIHN1Y2Nlc3MgaWYgYm90aCByZXQgYW5kIGVycm9yX2RvbWFpbiBhcmUgemVy
b3MuDQo+DQo+ICAgIHJldHVybiByZXQgPyAgcmV0IDogZXJyb3JfZG9tYWluOg0KDQpJZiB0aGVy
ZSBhcmUgbWFueSBkb21haW5zLCB0aGVuIHlvdSBtaWdodCBoYXZlIDMgc3VjY2VlZCBhbmQgNSBm
YWlsLg0KDQpJIHRoaW5rIHRoZSBiZXN0IHlvdSBjYW4gZG8gaXMgcmV0dXJuIHN1Y2Nlc3MgaWYg
ZXZlcnl0aGluZyBzdWNjZWVkZWQNCmFuZCBhbiBlcnJvciBpZiBhbnkgZmFpbGVkLg0KDQpZb3Ug
aGF2ZSB0aGUgc2FtZSBpc3N1ZSBpZiBzb21lb25lIHRyaWVzIHRvIHVwZGF0ZSBtdWx0aXBsZSB0
aGluZ3MNCndpdGggYSBzaW5nbGUgd3JpdGUgdG8gbWJtX2Fzc2lnbl9jb250cm9sOg0KDQojIGNh
dCA+IG1ibV9hc3NpZ25fY29udHJvbCA8PCBFT0YNCmMxL203OC8wPXQ7MT1sOw0KYzEvbTc5LzA9
dDsxPWwNCmMxL204MC8wPXQ7MT1sOw0KYzEvbTgxLzA9dDsxPWw7DQpFT0YNCg0KVGhvc2UgZ2V0
IHByb2Nlc3NlZCBpbiBvcmRlciwgc29tZSBtYXkgc3VjY2VlZCwgYnV0IG9uY2UgYSBkb21haW4N
CmlzIG91dCBvZiBjb3VudGVycyB0aGUgcmVzdCBmb3IgdGhhdCBkb21haW4gd2lsbCBmYWlsLg0K
DQpVcGRhdGVzIHRvIHNjaGVtYXRhIGFyZSBoYW5kbGVkIGluIG11bHRpcGxlIHBhc3NlcyB0byBl
aXRoZXIgaGF2ZQ0KYWxsIHN1Y2NlZWQgb3IgYWxsIGZhaWwuIEJ1dCB0aGUgb25seSBwcm9ibGVt
cyB0aGF0IGNhbiBvY2N1ciBhcmUgdXNlcg0Kc3ludGF4L3JhbmdlIGlzc3Vlcy4gU28gaXQncyBh
IGxvdCBzaW1wbGVyLg0KDQpGb3Igd3JpdGVzIHRvIG1ibV9hc3NpZ25fY29udHJvbCBJIHRoaW5r
IGl0J3Mgb2theSB0byBkb2N1bWVudCB0aGF0DQpzb21lIHJlcXVlc3RzIG1heSBoYXZlIGJlZW4g
YXBwbGllZCBldmVuIHRob3VnaCB0aGUgd2hvbGUgcmVxdWVzdA0KcmVwb3J0cyBmYWlsdXJlLiBU
aGUgdXNlciBjYW4gYWx3YXlzIHJlYWQgdGhlIGZpbGUgdG8gY2hlY2sgc3RhdHVzLg0KDQotVG9u
eQ0K

