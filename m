Return-Path: <linux-kernel+bounces-364533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C117899D5CF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F719283E60
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4DC1C727F;
	Mon, 14 Oct 2024 17:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tm7hj8Jy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660D2231C8A;
	Mon, 14 Oct 2024 17:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728928150; cv=fail; b=QMyCzVuHOkSj3gaS3F3pR3cEuV76nlBLjBrkAHJ5cGtQK7bk+niBUoOX7I4HOTpzN/IQqqT7gQsqn5AfY/pRhTkr6ZVfZku9umsOj3dN3aYNk8duvQHEkTpownV4fxzGEme3ipV0mlNc4hkCrNFpQzKWx7DkAoXbeNI2iB5YUbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728928150; c=relaxed/simple;
	bh=/nJMIiLDzWLql29HNEeDzbwRIVu8azWf/s+UnkzWvDY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QFLFuLh7WGc/5nQgW2QI5kL7Yv/CM2uzYjl5LdHWk83si+nvzhz/o6Y4VB4dtWOShxeetZHAAg6LFzoR2JbsI9GATCZlx5RBAXHaxesG+3PMxVOorYGd6iHF4ht+mIJ/4jtzwHWJVQlLmZ9G1y2TV147KUke9VzJ1YYlQ7Ojggc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tm7hj8Jy; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728928148; x=1760464148;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/nJMIiLDzWLql29HNEeDzbwRIVu8azWf/s+UnkzWvDY=;
  b=Tm7hj8JytlOFVtkovVO+0zeyBaixEn6oAQ2SsAdtM/xFZzOV1/ua7PTm
   KW1vbVmSCyPvHPk8MtkxsDcQi/eENUkBnOhv2MCYRuVs0WZDTOqvYuvku
   Q1WJnMMzVt/YXDRRm/ZPO2p/LkVZjz+CYNgBcQjmSeKMU2Q8VT4JKye7D
   4kgaBoXXNf7XAzxddegGHbLvVCw/znnUBOebEMmdjzJddSTHhoHp+rmXk
   0O4USxVhN3hi4UrQIxCvdORDm3T3wv5nipc37EXhdmOxbjv2izc6z02DU
   rA8X3ixuLpSXupg4Q56VKA9RVTC7T9w3y3j3sup7qd2vgNsjfb55Ikr4Y
   Q==;
X-CSE-ConnectionGUID: zGGoIRoYR0mmzGcDwRgLeg==
X-CSE-MsgGUID: WtdwG9LwQLicuEdcPHG9uQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="31173913"
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="31173913"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 10:49:08 -0700
X-CSE-ConnectionGUID: XSDkMlMfTRKfmClqEg3Vyw==
X-CSE-MsgGUID: BjNGkxBgSSKZuemGP1WDfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="77982190"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Oct 2024 10:49:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 10:49:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 10:49:06 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Oct 2024 10:49:06 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 10:49:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5u3LI3e4kDnoNDL0sxn/tPUgbAb8wtMmE2UF9ZoPKo/DrQagzIS7fg5JaJ8MCwPn7Ba99suIZ4R6AH1xCdcwC1EfMYIEyFEMWVkX6c+FxopRBJQ9LZifmHhRbkxcdWNLpZFjTR8/3PnO/VS+0kgduD2D634vIGOHx41ZDMZ9yVvCxoR+NxgdBaB3kMT50bXle4rQC8U3j0LogBTGXfA2mhj9R/I6H9xGM+EbK3S0DIVmokWnrdsaVaUe/Rz8m3DnBzF5Yl+LxY/i6KiaVcyLKMWfxGwQq5yz6p2Zdl+k/sDoKrbFVpQcKWqso9neqrthds/vidmUvCAO/KCrSTOmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nJMIiLDzWLql29HNEeDzbwRIVu8azWf/s+UnkzWvDY=;
 b=ggwD0Jths9AGFWKp1LDiY9K7LLbDJCtzMYoLrwA0h8BBTUATIG1P61f8l+TZsmlCtgkL8JtUK4cn8a6v0GkwrF9UtPTSxFahir1PdfUJZWFfCCtIOjC33eQxdPl4FKPhYU+JaLoLCuuNCoYoeo0J8RnsRETjGo2SqejSUbVUgYtsMbcyvPzHNyJdX3Sh+h4tUZQa235Nzurcy8AWw09DucnabVZdIb5DhIvmuxPuVTvRhefwddqNPeV9aIjh6F1q4a017h+0Pju2uBWwLWPT0hldMABKVhGSvGVdlqRHvuixz3AAjFfK0+gYYaCaJZAU0Dar9DpPCXgA1U/Ew5mlVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA0PR11MB7815.namprd11.prod.outlook.com (2603:10b6:208:404::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Mon, 14 Oct
 2024 17:49:02 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 17:49:02 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "babu.moger@amd.com" <babu.moger@amd.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "Yu, Fenghua" <fenghua.yu@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"tj@kernel.org" <tj@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "yanjiewtw@gmail.com" <yanjiewtw@gmail.com>,
	"kim.phillips@amd.com" <kim.phillips@amd.com>, "lukas.bulwahn@gmail.com"
	<lukas.bulwahn@gmail.com>, "seanjc@google.com" <seanjc@google.com>,
	"jmattson@google.com" <jmattson@google.com>, "leitao@debian.org"
	<leitao@debian.org>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>, "Edgecombe,
 Rick P" <rick.p.edgecombe@intel.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "Joseph, Jithu" <jithu.joseph@intel.com>,
	"Huang, Kai" <kai.huang@intel.com>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "daniel.sneddon@linux.intel.com"
	<daniel.sneddon@linux.intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "sandipan.das@amd.com" <sandipan.das@amd.com>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"peternewman@google.com" <peternewman@google.com>, "Wieczor-Retman, Maciej"
	<maciej.wieczor-retman@intel.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Eranian, Stephane" <eranian@google.com>,
	"james.morse@arm.com" <james.morse@arm.com>
Subject: RE: [PATCH v8 08/25] x86/resctrl: Introduce interface to display
 number of monitoring counters
Thread-Topic: [PATCH v8 08/25] x86/resctrl: Introduce interface to display
 number of monitoring counters
Thread-Index: AQHbGybdEonESjxpIEK+MSvEee6fXLKAG/3ggAAYpoCAAACqQIAAGxsAgAADIiCAAB0cAIABl1/agARyzuGAAAmagIAABNZQ
Date: Mon, 14 Oct 2024 17:49:02 +0000
Message-ID: <SJ1PR11MB60833A1571413763DE36B538FC442@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <ZwcIkf_oy2oKByNu@agluck-desk3.sc.intel.com>
 <8ceeb50a-70d7-4467-b7c1-4f62b1a1eec8@amd.com>
 <SJ1PR11MB608381B9DA3AE26749070BE8FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0fedcbd4-487c-4d55-8151-69dc34f41f1d@amd.com>
 <SJ1PR11MB6083FFA19F9387F21C058A09FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <d1986f3f-9db7-4ac9-9fea-56878548ad61@amd.com>
 <SJ1PR11MB608382EB9F40FBDC19DF71C4FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <1baa07f6-0ccc-4365-b7b8-09fe985963cd@amd.com>
 <Zwlj5TQxZphcuDSR@agluck-desk3.sc.intel.com>
 <8af0ce3a-1327-3ffc-ac5c-e495f9cdf5d0@amd.com>
 <ZwmadFbK--Qb8qWP@agluck-desk3.sc.intel.com>
 <ee7771e4-3768-456c-9990-fcd59b4f74af@intel.com>
 <0ee2e67d-c1dd-489e-beef-1f255c5629d6@amd.com>
In-Reply-To: <0ee2e67d-c1dd-489e-beef-1f255c5629d6@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA0PR11MB7815:EE_
x-ms-office365-filtering-correlation-id: 4232761d-5ccb-4855-c23a-08dcec787d8c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aDNIN1dQcDBLNWJXVlNOVDdkVHY4MXI2b05ESGErNEhkSS9NWXlLSWJnMVI1?=
 =?utf-8?B?YzAxd09sL2d3MVF4S0YvQThPL3BrNHg4MU5oYUxIaVJsUE1FYTdYZUNvWjQy?=
 =?utf-8?B?a0FiWGtRRDlZZFNIdW11TWRQQThQSHF1alBXMllLeHZsNTB3VXNiL2grSG9Z?=
 =?utf-8?B?TEVWY095UVArdXYvWXF1TW5wUXJnR1NERzY5UzY0bTZzLzJUVHh5QVZ3L05I?=
 =?utf-8?B?Q3ZhRFJ6RlFpdmlZcHpyVlJFd0dBc21xLy9ncVlXQmRBcVNMaE5NWjNvT2NI?=
 =?utf-8?B?ejNCNFdTNHJrK0FUd2ZsWlNLdjc0VXVFZUN4QTA5c2xZSVJmdmVaQlcvamE1?=
 =?utf-8?B?c05qRjZ5RzI5T282eC95LzNNZHZXQlYySVNlTTljZitZRXBJbGdWSXptM2ln?=
 =?utf-8?B?Q2JMeGRaRmU3bVh6cm9PWUhRMnR0MHpvMU1aM2NjYS90K2lxSllFTngzeURs?=
 =?utf-8?B?cGFnSzVMNWVBWUt3Sno1S2Q1cFd1UHVEMzhiTkh6OHhWNGtTMXRVam9NMlQy?=
 =?utf-8?B?bUtRYW02eHlrbndsSnI1TUZ2R0Z1M2wrZVMyMmZhV3dlcWhMQ0dsU1p6RmpW?=
 =?utf-8?B?TjRGOXczRTl2a2I4K3JEUUNPNTRCVTBkSjBFWHdCZWc5eTFUS29lWDg5b1hk?=
 =?utf-8?B?STlJME03bytBOS9Cc2lBMGhubVlSSW1uZEJLQm5oSmQycXVGRHNlSkVYMWhX?=
 =?utf-8?B?NlVlSUdXSWp4M2dwaVJTck5aWkg3VVFCU2xWY0w3UjNVeDM5aW1tRllHcFRR?=
 =?utf-8?B?VnVvR21PdGYzTUZUY0ZKNlQ3TzltR29CN0VJQmF3YnlPVE43bTN0dm0ralRp?=
 =?utf-8?B?UmhOczBYeEt6VFFXcUJoN0Y2bklLalRnTlRSNURIcEo0bS9yalJpa1BuMWZT?=
 =?utf-8?B?VUVqMHQ2eVJ0MjZOOXVYZ0E5Q1QweEVWWUJwaWxJNVlqQmpBVVNULzNEQ1Bu?=
 =?utf-8?B?QnV0eVdBU1g4aVVVb2liSi9GeTlpYTVneE8yTDN6bk5TRmppcWo3SStxN01h?=
 =?utf-8?B?VmtzdTVSTFowbmlDYStRRkNEa1FIRzExVUlIY29ncDV6dFpKSXpPUGhrdW9i?=
 =?utf-8?B?RTRiNmhjNjhSMmNmblpGUG5LUFlnQlByTnlTME13WE9wdkY5ZUtmczlhZTNF?=
 =?utf-8?B?WE95UVVhOVJxanVNYlRvTGd6d1BUUENUMzFWYXJEbzBaWFRXb1NRcWx2TzIz?=
 =?utf-8?B?a1BySkQySFp6eHg2eUxoSUhna2lsOGdmRmpLbWlrUTczUVhyU1hJYklNZGVS?=
 =?utf-8?B?WkVnUUhrVFpyN0d1L0hvTTBCRUc5b3FoNlN6Tm5SUXB0ZFlSMDBqYWdNWSty?=
 =?utf-8?B?eEZpOU15bDFEVHJ0S3gvLzNZb29aNEQrM1JLQ1VObWIxNWNyb0VsKzB0WS9B?=
 =?utf-8?B?MHZFTkU0MjFnYSt6WVlOZ1VCNm5YNDB4dFVUTEh4SkVIQ2poQ0ZtbVJWSFlN?=
 =?utf-8?B?SFZVektrbkpDUUU5MTc1cS9lQWdPTU9ORGhPZUhUVW5DQkVtOUNlVnpyclpr?=
 =?utf-8?B?anJLQUtxc0FjOGZTVFluaU11dWw3SUpsMHBzM1VQWTNyOXd1ZThkckxEWktN?=
 =?utf-8?B?NHFQZ1lWOGJjRERxS3VGS2kzVm1CVVcxdE8yWFlPZDN6VVVBdktNS3BNdUtC?=
 =?utf-8?B?MjRaTFd5TzExZXlLclBFUHlwY2kwRDNNa1pFaGhFSjRsclFCczFhZmttWHJv?=
 =?utf-8?B?WjBFNitId1lOajlrOW5nS1hxTnl4NkQ1VWM5MDlRS2svUkE5b2R5eER3NE1I?=
 =?utf-8?B?NWxNSXE3dU8rbXd4MGJpZjl4YlAxZXNTa0diMXM4bGNkRWxzOVRxQThSS0pr?=
 =?utf-8?B?a0NzZ3Y2ZkJrVUV0SVlhdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWtHL3FIa00vWSsrNUdnbjY3dXJQcldoc0JPbFo0MVVXdW9qZmdXaTNpdWZ4?=
 =?utf-8?B?d2ZaWUpwWHZTWDZJSmxFRWh5M0taNHJxWk0xR281b1RiZC9RMjgvbGYyZHla?=
 =?utf-8?B?WW96bFFYYndyb1Vic2VHOFFxRXpZNlZjbC8wb3JaYnZNakRUNnNpdmRuTFUx?=
 =?utf-8?B?VlNrUFlNcjdOVkI3TmlnMVpWMmwvL0lESWwwK0dIdVpyQm5wYXFiMDl2SDFz?=
 =?utf-8?B?OGxaYnpmeis4Wnp6SnF0Y1RGKy84Lzk3dkVjdjYrRk9LcUxQWVpxbzRGTVhU?=
 =?utf-8?B?bXlSdkUvWlQrUlFmN3N4b0ZUK3FRcW03cVlFSmJwMU1KM0ZuY3pLQW1Da3hW?=
 =?utf-8?B?YlJUOU05V1RIT3JadUxUSjhFV2s3eUdWK1I1cGNNTzc4bE92ZTI3OStPbWYv?=
 =?utf-8?B?N3M1UW9acHh3VkN4cmJ1b1JZQzl5b1R2UzdpNkIyTmJuMzl4VmQ0cklHR2ZV?=
 =?utf-8?B?bytKOVp4bm9pU3RoV3hWb3VmZEhQSkdxUDh6QnFXdjhRMFlKSXM4Z2oxajda?=
 =?utf-8?B?alJ3dzBYS0FkRitCWnBQVTRhclo3cWlzTzMrakd5b2NSLzJSU3Zhay9sSHV2?=
 =?utf-8?B?UTBzdHZZenpDTFdML2VRNHJZaUpDaTR5WUtvKytmK2tkVkJwK2tDKzB1NS9t?=
 =?utf-8?B?cFZtcHlHWVVHajZUV2wyWTNQZVlUUWg3MzNoS2dGS2FRUWJGQXo1QlNaNjJh?=
 =?utf-8?B?M3hBeDNKVWJKRzFlM1hxMDk0bzdnTFZReXowZzFaV2xZY3dNb2tJZmM2YUw5?=
 =?utf-8?B?SVZUTVRCUmJSazNGUE5ENGlBcjJ1WjBUejltclR5OEMxQk93Q2xXbGJqWjBF?=
 =?utf-8?B?dEdXQVcyUXNnY21QUHQyUnVpcVhENWlpYkxyVWJ1bGh4NFZSZXdNYnJuRFIy?=
 =?utf-8?B?cjMrbjhSb0NrVE1yTENicWd3YVRxelY2aEdlMWR3UWt4YkFjSk03UXVJSGFH?=
 =?utf-8?B?VEJsd1lqRURjTXFONDRhclJnY3d5K1lqZlFOaVJWR3BSc0NjZzcyZEttWklp?=
 =?utf-8?B?S2pKZnBHenF0MzJvQjE3d1A2SHk1ZFZ5TE1VWGVqZlRKeGVDVS82T0ZvNldX?=
 =?utf-8?B?ajBzaGRmTVJIOWl1QVVmS3E2R2xkeUJRemtPSEQreFpLTGlOQ0Z6czZ6Njd3?=
 =?utf-8?B?cGJGV1hHU2x3bnJ4Y2FSYU9iWFB5NzIxTWdvMFgwcW8xNXphczJwMGJGWUtH?=
 =?utf-8?B?TWJ4YU8xSWZFQXhLMWhGSmV5ZmpYeFBKc21VbEFoODVrVGlhK2FOdXFPais5?=
 =?utf-8?B?V1Y3Mk9BV0RPdHRFRHVUempLM3p2SjZnaUF5cTk3RVRGUlZjQXVyZVJXak1w?=
 =?utf-8?B?dExLdFB4NStMRkZyVmhzL0NxOGZycGxHU3V2WW9BUjdzZjBRaHFTOWFxYzJP?=
 =?utf-8?B?RjZYamVtTEFCd3g2QXZzaityUFdZZ05GbGR6M2hhWUtzc3lSa1BzdTFtZXlm?=
 =?utf-8?B?ZTR1OXJhVjF2SzRwYWM4dFQ4VFArZ2FBS3lVR25NUE1EdXYwckMxcHpBd3ho?=
 =?utf-8?B?eEVGeGgxSmdHT2UyVHU3Vmg4bERNWWhVbE5QM2FuNU5DWG9MZVg2bHMxVEtl?=
 =?utf-8?B?WFFyV2hNQlFqZVh6d3hVL2V2Uk5zeWN2YUYwVkRWM0Vub0JleDBia3lSemRm?=
 =?utf-8?B?MEFaUTVRSDFFMlBLUVJ0UHNNSVdVREViSjNSYkRHeUhyU1p1ZUZCUlRtUlNx?=
 =?utf-8?B?YWVXRHhZZHdxK1I2azdXNjg3am42OWptMzVQalBPREVQaEI5MDdqblNYMnNm?=
 =?utf-8?B?WisyRUVYeDRUS21waUc0T01QdHU4NnZNc01zZUNVaENiQkcyRHdkY3N1OFF6?=
 =?utf-8?B?Ym5CUW5qVUc4SEt0eldSRWVWci90UEFGUlp4RWl5Tm54a2xBTm9sQ2pDZGM3?=
 =?utf-8?B?NkVUT0gyZllSQmJ3cTUyNU9PcjY5L1phb0RYVkpSUWZkSXAvamVGQXZ5NUEz?=
 =?utf-8?B?cmxPYW9JOEpob1c3NkN4TkNSSnRWVXRaRVl0bTdCVmxsemdvMXRjQ201K25G?=
 =?utf-8?B?VXM3T3pBOExRZ3VrRTRpZ0ZwZU9ydDJ6bHo3M1pmWkNGMXM0ZXpUcjlCNUZi?=
 =?utf-8?B?NjF5VjllOHU0S0VuT1FJcjlEZGpELy80aXd0M0pjT1VXMXFGYzVvcm83bzE0?=
 =?utf-8?Q?phFenptQE685mJJGyXdJ9c6IL?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4232761d-5ccb-4855-c23a-08dcec787d8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 17:49:02.5987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PyMbmAeRNhu9cgWCoeYS3cdpccfrgFf3vP6hIFdzREm3xGP43abRoCjtdfUsUoTosBh+SYhJNCbqvjEY8F+7Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7815
X-OriginatorOrg: intel.com

PiA+PiBJLmUuIHRoZSB1c2VyIHdobyBjaG9zZSB0aGlzIHNpbXBseSBnYXZlIHVwIGJlaW5nIGFi
bGUgdG8NCj4gPj4gcmVhZCB0b3RhbCBiYW5kd2lkdGggb24gZG9tYWluIDEsIGJ1dCBkaWRuJ3Qg
Z2V0IGFuIGV4dHJhDQo+ID4+IGNvdW50ZXIgaW4gZXhjaGFuZ2UgZm9yIHRoaXMgc2FjcmlmaWNl
LiBUaGF0IGRvZXNuJ3Qgc2VlbQ0KPiA+PiBsaWtlIGEgZ29vZCBkZWFsLg0KPiA+DQo+ID4gQXMg
QmFidSBtZW50aW9uZWQgZWFybGllciwgdGhpcyBzZWVtcyBlcXVpdmFsZW50IHRvIHRoZSBleGlz
dGluZw0KPiA+IENMT1NpZCBtYW5hZ2VtZW50LiBGb3IgZXhhbXBsZSwgaWYgYSB1c2VyIGFzc2ln
bnMgb25seSBDUFVzDQo+ID4gZnJvbSBvbmUgZG9tYWluIHRvIGEgcmVzb3VyY2UgZ3JvdXAsIGl0
IGRvZXMgbm90IGZyZWUgdXAgdGhlDQo+ID4gQ0xPU0lEIHRvIGNyZWF0ZSBhIG5ldyByZXNvdXJj
ZSBncm91cCBkZWRpY2F0ZWQgdG8gb3RoZXIgZG9tYWluKHMpLg0KDQpJIGhhZG4ndCBjb25zaWRl
cmVkIHRoZSBjYXNlIHdoZXJlIGEgdXNlciBpcyBhc3NpZ25pbmcgQ1BVcyB0byByZXNjdHJsDQpn
cm91cHMgaW5zdGVhZCBvZiBhc3NpZ25pbmcgdGFza3MuIFdpdGggdGhhdCBjb250ZXh0IHRoaXMg
bWFrZXMgc2Vuc2UNCnRvIG1lIG5vdy4gIFRoYW5rcy4NCg0KDQo+IFRoYW5rcyBmb3IgdGhlIGNv
bmZpcm1hdGlvbiBoZXJlLg0KPg0KPiBJIHdhcyB3b25kZXJpbmcgaWYgdGhpcyB3b3JrcyBkaWZm
ZXJlbnRseSBvbiBJbnRlbC4gSSB3YXMgdHJ5aW5nIHRvIGZpZ3VyZQ0KPiBvdXQgb24gMiBzb2Nr
ZXQgaW50ZWwgc3lzdGVtIGlmIHdlIGNhbiBjcmVhdGUgdHdvIHNlcGFyYXRlIHJlc2N0cmwgZ3Jv
dXBzDQo+IHNoYXJpbmcgdGhlIHNhbWUgQ0xPU0lEIChvbmUgZ3JvdXAgdXNpbmcgQ0xPU0lEIDEg
b24gc29ja2V0IDAgYW5kIGFub3RoZXINCj4gZ3JvdXAgQ0xPU0lEIDEgc29ja2V0IDEpLiBOby4g
V2UgY2Fubm90IGRvIHRoYXQuDQo+DQo+IEV2ZW4gdGhvdWdoIGhhcmR3YXJlIHN1cHBvcnRzIHNl
cGFyYXRlIGFsbG9jYXRpb24gZm9yIGVhY2ggZG9tYWluLCByZXNjdHJsDQo+IGRlc2lnbiBkb2Vz
IG5vdCBzdXBwb3J0IHRoYXQuDQoNClNvIENMT1NJRHMgYW5kIGNvdW50ZXJzIGFyZSBibGFua2V0
IGFzc2lnbmVkIGFjcm9zcyBhbGwgZG9tYWlucy4gSSB1bmRlcnN0YW5kDQp0aGF0IG5vdy4NCg0K
QmFjayB0byBteSBxdWVzdGlvbiBvZiB3aHkgY29tcGxpY2F0ZSBjb2RlIGFuZCByZXNjdHJsIGZp
bGVzIGJ5IHByb3ZpZGluZyBhDQptZWNoYW5pc20gdG8gZW5hYmxlIGV2ZW50IGNvdW50ZXJzIGRp
ZmZlcmVudGx5IHBlci1kb21haW4uDQoNCiIwPXRsOzE9XyIgcmVxdWlyZXMgYWxsb2NhdGlvbiBv
ZiB0aGUgc2FtZSBjb3VudGVycyBhcyAiMD10bDsxPXRsIiBvcg0KIjA9dDsxPWwiDQoNCldoYXQg
YWR2YW50YWdlIGRvZXMgaXQgaGF2ZSBvdmVyIHNraXBwaW5nIHRoZSBwZXItZG9tYWluIGxpc3Qg
YW5kDQpqdXN0IHByb3ZpZGluZyBhIHNpbmdsZSB2YWx1ZSBmb3IgYWxsIGRvbWFpbnM/IFlvdSBj
bGVhcmx5IGV4cGVjdCB0aGlzDQp3aWxsIGJlIGEgY29tbW9uIHVzZXIgcmVxdWVzdCBzaW5jZSB5
b3UgaW1wbGVtZW50ZWQgdGhlICIqIiBtZWFucw0KYXBwbHkgdG8gYWxsIGRvbWFpbnMuDQoNCi1U
b255DQoNCg0K

