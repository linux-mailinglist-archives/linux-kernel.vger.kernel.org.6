Return-Path: <linux-kernel+bounces-372098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A75AE9A446C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3652D1F20FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE599202F8D;
	Fri, 18 Oct 2024 17:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WfqEyP7+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A42E204007
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729271715; cv=fail; b=M6P1JnGPrM0qKb6cED3FGOXo3F12tfPIf8z3VDFrxpVbPFcE3Su4Oled9cr4kgfx98vZljmfqr+Q5lk95+JH0DCkD5/qEBBhgtFsoRa3Y+DbyuQMbF+bgSl4QpX6lRmRu9ivl4Uf7mtJ6kN9T/SGcNj9BKMXuHTsTWfmmy61/vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729271715; c=relaxed/simple;
	bh=synfe1p0T9UACTHxGovM5fvxDLmPYntx5vpJY1Z3GZg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YRc7VgDjOldhMjtcOaH9d3MKxfh3B2G+yf87GGZMuO6c7Xq7sO7ozF2wt5yBfjRh1TXUPeQyn6lWUCkVONXXyTI/vs6V36Tuh+RXMqsTUIufCJcRwf0BA0HBf/zjHQ27A1FVBSh2l11kc5FnFfwMdntMoV9X+mEsEtIpKX+2DeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WfqEyP7+; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729271714; x=1760807714;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=synfe1p0T9UACTHxGovM5fvxDLmPYntx5vpJY1Z3GZg=;
  b=WfqEyP7+DRNc7rEn181zXyvm8RRJpJJNufy5+ZYqD8HAS7MWr22gCfN7
   gJ3Tvo10Pl9AQW3smMh86FeW2tQfGSig3Li2PhNOUneqwcU34PL83gdUE
   jvHg195ZN6PskIzsbj6sJ5NHHiAQzD33wrnoyy34ZX31xMXEPHK3xqGF+
   jJnIwRMHsSH1sFN8aueZt1tDP8jExtTK3sfnaD6uOI89cn8bxr/QUUreC
   uJ9U12SpxH2t7+NHbSHGE2qLbZK5CLuaki2rVZFyF86KvzLPFSFhKbJ/Y
   +GVTzejAM0NJcOeivw1CpWABHYw7dtElfOksM0Jf3RW0JAx5XNgISDiWl
   w==;
X-CSE-ConnectionGUID: CIWDU1TBRpqb3zScNDN8Vg==
X-CSE-MsgGUID: i4UjZ4zMTae6P4KGgw5xig==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39358482"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39358482"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 10:15:07 -0700
X-CSE-ConnectionGUID: 3mViifPETqqJXrOvWc7RJQ==
X-CSE-MsgGUID: RHv+PJE3RsWHJgYB7AsB5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="79260893"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 10:15:03 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 10:15:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 10:15:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 10:15:01 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 10:15:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIbhnkV+IBu5ayUJN7wrPePoFjc7bh487d35jIyGM6UKAxpEF/ETcpN1ry7Xa47dAmgKi6GPeUXcwt+PSdV3se6GCzdJqP/J40ANBONjc8pBsivQ6xXw9MUi01bh4NVDKqxXRauFo5mt8KrkQRd96gLDmunlXUN/pgUWgjpa9fE89rUoMGe2zuQp+JSNuT+Qs41N5YAhNlhPYhQ40sdploJDfcoxGCyWT9naqJM4qNlT0tis3edKdQnxPFSQy67WVWY6FRJFL6xXPd8uw9KMlPSBQzloHOLI3hWuWXtO2l85quZiBrOqwTri2aB8srgxb3Fwn+0ABLabg7dOFNziDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=synfe1p0T9UACTHxGovM5fvxDLmPYntx5vpJY1Z3GZg=;
 b=IypubEBHiIsXXOntJT8LKVkF6OSygge5CT1fLNlgZTE4gcPMSFU/HdcMyaCBdEqai0FdwaYQir0j9Jzt2G8i2F8VUTo23FdS+0qN2BUQvWN4UOBDawo28btHKq9jOCP+T0pjEIa8YoZeqRHbN03p74zNw7sKrdlqsoFo9hCzlYWZLH+SqIjauRbi24JsjC1pzE9LYdbgsQWcKJJkOyR1zhGb8LZMmYm6qD8X7htv96mPUbj0jnb97Pe1idQyle949pZeWKqiGSnwYzi/hRMQU9e//4/043KD8t4hvjUfKNmG0eoL1PNv/51xb5KSvDp0KZ9a23L40aIyPK+YfncSXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS0PR11MB7877.namprd11.prod.outlook.com (2603:10b6:8:f4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.18; Fri, 18 Oct 2024 17:14:57 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 17:14:57 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: James Morse <james.morse@arm.com>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Yu, Fenghua" <fenghua.yu@intel.com>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, "carl@os.amperecomputing.com"
	<carl@os.amperecomputing.com>, "lcherian@marvell.com" <lcherian@marvell.com>,
	"bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
	"tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	"peternewman@google.com" <peternewman@google.com>, "dfustini@baylibre.com"
	<dfustini@baylibre.com>, "amitsinght@marvell.com" <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>
Subject: RE: [PATCH v5 02/40] x86/resctrl: Add a helper to avoid reaching into
 the arch code resource list
Thread-Topic: [PATCH v5 02/40] x86/resctrl: Add a helper to avoid reaching
 into the arch code resource list
Thread-Index: AQHbIYBPHEK7GPLyxU69kJAkPjrI87KMvs3g
Date: Fri, 18 Oct 2024 17:14:57 +0000
Message-ID: <SJ1PR11MB6083433FFE5E0312B98FD7E0FC402@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20241004180347.19985-1-james.morse@arm.com>
 <20241004180347.19985-3-james.morse@arm.com>
 <Zw7za0Cp0oH6v5w6@agluck-desk3.sc.intel.com>
 <94cfdf5c-cd52-41c1-b5c3-7ac6b2f84f23@arm.com>
In-Reply-To: <94cfdf5c-cd52-41c1-b5c3-7ac6b2f84f23@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS0PR11MB7877:EE_
x-ms-office365-filtering-correlation-id: 03fe5c60-d513-470a-fb3f-08dcef986421
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TFhkSHFrcWhTYXpxQklCeUFJY25ONVU1MnZneDh0czc3aDl0aWtYN3VnTFEz?=
 =?utf-8?B?TktsSEhOckZhUlAzZWs5aWV5clZtL2c1VWYzdUtlTlRXNFdhVExmSW1zbXFz?=
 =?utf-8?B?Tys5QmNUbzRZc0VjalA5RnNEV1FUVVhGOFlCSnhNbG5PT3NueDlZMi9uRzBu?=
 =?utf-8?B?TUx5MUVtYVFhdDJ4Wm42OVYrS0tWZFNCSHRxOG92ZmxFeVhQbDh0cmlUK2la?=
 =?utf-8?B?SnhDdjU1d2huQWpoTTNEdDFibEdJQ281UFAwbmZ6NnhBVnFWdVorc29IbXh5?=
 =?utf-8?B?ZFlTSTBFMWhhbXh5Rm1IN2V2WkkrZjdjRTVHM0l1bHRBMVRGV0lzU1ZTSXpt?=
 =?utf-8?B?M1RhaG45V2pJcWtBRTVDaG1oblV2TGxLUUZ4NktrSk5Kek1obGZ1T1RKYm02?=
 =?utf-8?B?QS9ERmhZUE5hbDBmY2h2UVpySGZpVHFheGwzQXRMcUcrWFhjTzlrbGp3NmIv?=
 =?utf-8?B?STBIMU1FUThVbVZGUGdiYVk2cGN6SnNPcmY4VGVBVzM1aHZoVUlkZ3dEdXFU?=
 =?utf-8?B?Vy9GYTUzcmVWOW0vZ2ZaS0pub0Z3MkVpMk1jUXJPNWw4V2lrWXdRZDZtTUds?=
 =?utf-8?B?bHNBM1hBajFDelF6b1g5SnNCLzlOSHhTS1FoQmRMa3YyTStLQlo1V3BtVnMr?=
 =?utf-8?B?eVhoUUIwQk1hOW9lcm5kRXc1Mk10dm95Zm5jY09YZ1Q1b3g4WFlsLzRZLzBT?=
 =?utf-8?B?Z0NqSENHS2g0WktlVHdXWEp3b0k0K2tna1kyYjdkYWFWNmsvMzZMNGczNW5Q?=
 =?utf-8?B?dEJZV2N1YmxLMktwRVdXdlcvc09tZXNEdlU2T05ORm43WUNaN00zeHlweDA2?=
 =?utf-8?B?RG9hbWcyUGx1OTlLK3Q3WlkzbU5OZWdFeHpWMkNTRGFYRm9VdTk5UURQYWd6?=
 =?utf-8?B?R3RVdmJaYXE2KytCQ0pBQkRacUxhbHFxbXFoaWJiM3RuNDVnSHFBcis0aWdH?=
 =?utf-8?B?OWhBRGNLbFpkL3V6YnM2Qk83VnZ1YzBtbXZ1S2o4M3d1YjhPN2pWQ1FMMUc4?=
 =?utf-8?B?a25lTEo5dmRGSzBybmFBdnIyakJob0JiS1d4cWtNaSszNldiQ21hUHlIVEp4?=
 =?utf-8?B?WU5PTXdNV0QzT0txSFNadHhSbDFiYmRXRWFUb2hBdEt6VmJGd3BqM2tqVWZs?=
 =?utf-8?B?WGJjUWZXZXFFUkRTZWFxamJYV01mVFBXVmtLOWV0S3dNd1ozbE9nOU50aUFs?=
 =?utf-8?B?aHdvZ0xteEE0alFkcDR2ZDJmejVRQlRJSHZEZUVoaDlvSWdPYUprQkY1RC9G?=
 =?utf-8?B?M3Nwc2Y5WnZ3bzYrU3FjMi9ydzV2SjFtVlNBWUJXS0tFUi9Fd0RFajcyOWkz?=
 =?utf-8?B?ZWFxV3RCYXVQdTI4RElYS1Y4WkY4WFRSOEIxdTdRb1BvMzIyTmtWK21OOEt1?=
 =?utf-8?B?SG9CeTR0WGhJYkltU2tpTnZHR3haSmFpL25yMURPMGFZTGlrZDJST0F5T0k4?=
 =?utf-8?B?aG5PSHM3VUoxTFVwU0pBL1ZIWTVZZHh1L3BMQWdxSUxOSHR1bVYwZzdtcVZV?=
 =?utf-8?B?R0FMQ05VM25aVUw2K094cTAvVXZpbjJrSmhHYmZBWmRQb3hwRHFFdHI5ZFlr?=
 =?utf-8?B?eUFzL2hZVWhPU2pscmZvYUN2R3poWFhjY2cvNjZvY3NWNnhxYkJ5MXlBbVdI?=
 =?utf-8?B?K3pGMnFpV3QwZjNCMFluQXAvTWZsemZQN2hTMk1nOEhkM0FnZ1N2OFZMVURM?=
 =?utf-8?B?bjV2UzVuMDgvclNndWJ1WHUyVXBTa2xSdHRGYUk1UjV4SFRCai9EWFNoTkxj?=
 =?utf-8?B?dGFjUDFGTmoyMnFzbnRMMDFVZ05iTHI3bVYzazF2clBqSThiNjRUbktBa1Vm?=
 =?utf-8?Q?ObzBplZQH46kuXgx5DcCsS73sazPCtpRHlRbE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGhiMXEyMXh3SXlMeUd2N3FMbU1MY3RnYm13U2dJUzJrUjAxdVh2aG5PbDJk?=
 =?utf-8?B?SFkyQmlQZEtuMGIvMmhOYmwxUk1IUmRLQU16eThOWTNMVmJrelFvQkJhdFl3?=
 =?utf-8?B?ZDNGNVBydkVUK2Y0Vi9GL0xjN2N0VE1vYThTODhSMEl5a1V4eXJ0VUQrTGRD?=
 =?utf-8?B?amo0ZE9qVVRrMlRFdkZ6cVN5ZkJCVGpjTGFmdkMvcmRTWXI0dUpLT0haUnRH?=
 =?utf-8?B?UDBYbHJ2cmlZdlorTlNPc0diZnMzVW1JZEFYNHJ3WDdmc2c2ZmhwNWpZMllB?=
 =?utf-8?B?V1dlQlgxbDFoWFVOa1N4dTBvQzd1NkFvQVJUMTBHZEJTSFR1dzdGOHFpNlV3?=
 =?utf-8?B?QjBuNDNBYU41N0M5NFBvTi9kNlN4LzZXaXA5RVIxWTVoNHg5Vk9VR0FZeDZO?=
 =?utf-8?B?SGlvTWFwYnpvRElPL2RIVktIWmZsdi92Nm9LV1NxT3BubHRYTUZsbW5SZHAw?=
 =?utf-8?B?K0xBZFQ5dmdkdjZaT2FhY3lEY1BNMy80M2lHbFM5aEFHTGtUYnBhc2NuMmRo?=
 =?utf-8?B?RzhJa2hLSm5OdWNnNERna2VKb1NaZVRFU2JZRlh5dWQ1RlpvQktJNUQwZEcw?=
 =?utf-8?B?cE9TU0JFYWxDVXlPUDg4TzJqMzNGL0VZZ3NjYVdBSmNDdWRUZ0gyTHFsNHpn?=
 =?utf-8?B?RGdObjZVamo5UlZSdi9ZUy96OUVlcUlLUUJKL2I5dWRqbjRSbTdzb1lUNzNl?=
 =?utf-8?B?c0ozekJLTzNBZzBzeEVabTZIdU1mdzNBaEpPdU95bk1yamxGTlVuZG5lTUEr?=
 =?utf-8?B?UmdHNkxhWUR1RFVpOGdBOW5FQnI3WnpOcFhycTNlRTBOdlhkSHhGeDNDdnpj?=
 =?utf-8?B?QlM4MThxRFFNdFNxZTVLT25RNDBlZHpRZVlLS0RsY09PeXRKcHZFeGVNR21q?=
 =?utf-8?B?UVk1V0JBODZuWnVkZ0dTQTdITFltN09jcEhmQktSUUR2RDVETG5uMnNnSGRw?=
 =?utf-8?B?aU5zT2lFVENlYnIxWVZkdVRRZEwyaEpOdEZUTEVBUWthOWFYZkp4VElmTW53?=
 =?utf-8?B?aGZmYUtWZ3NoYTk4MWNDRGNDWXlDMk1EbU9GSmRvaEVHczJZdmtIaEY0WThq?=
 =?utf-8?B?elZSMG5kU25nbTl1Q0xaQjZEOWFSTGcrN3pkR2hGV2FLa1VnZTUrNWhsNkhs?=
 =?utf-8?B?Ykc3UjRUdEtTamhJZWRYakkzSzhWYXNveTJOMGhpNWUxYTBtWDhpK1lxWUVr?=
 =?utf-8?B?OHpnY2dqdlJ1cVJZbGJnTUtCdGtnTzY2T0QzZklxUG9UY3BHWXJJRlB3WVcy?=
 =?utf-8?B?SldKU0RTczJyRFpjdUFQVzZpNk1xdnV5NkVDKzhkdEFGdTVJVnV6ZjV5YlJa?=
 =?utf-8?B?ZDd3VUxnQytPQ3hSOUo2VGJ1VUpNYjVTYzI2Y3BsWExsNVpWWkgrVEVuMXVx?=
 =?utf-8?B?REFGNTErVW9HckJVUW1jS0Rna0ZIeGdRMzZrcUxGOUxCZ2RlQ3FWc3JSeS9O?=
 =?utf-8?B?S0JhUUxrdnloa0YycFVONlg4WUROYWdycUhqSzV4Zy9oTkNvZG5UWXlDMVhQ?=
 =?utf-8?B?bUU2Qy8wVjVIY29QRlZuenVKK3BXZGhaYXFyc1VnZ1RwUDMrby9Gd1RmRzJO?=
 =?utf-8?B?VkVib2tuWDFwV0ZLeU4yNnp5Ui83aFFRSkxTSFNDcXQ2TmlmZUhHck91aVpu?=
 =?utf-8?B?UTRnaStaQ3hTMDdNUm5FY054MS9EV0ZITE9Bak5NeFN3S2pBajlwVE5FZ3VS?=
 =?utf-8?B?V01zN3ErSmszZU96bnFDYVQrd3pxY2YzU1lqSXExaVBlQ2lDR0ZZWEY2TEZ2?=
 =?utf-8?B?VGJPZTZhSmltWGpvMmlSOFo1bG5RbTVtUElpaTM5NWdkbUtzY0JnS0ttT21S?=
 =?utf-8?B?NkNYM2k4V3Fza045NUVJNUVvQjZXUlNoWWxQc3RmTUxtV3F3Q3RZRWJhb3p1?=
 =?utf-8?B?eWFoMDJ1cWZvdVYvOFdqOW90SWsrdkhrd2IxOHRKOXRObzR4RXdnbGcxbkEr?=
 =?utf-8?B?b2gxTG5rUWZDYWVMVDR0U25FbllzVis4WmlHQUdOR3BJQlpsS3JWeXRkRHNy?=
 =?utf-8?B?Mk8ySkoyMDkvK0NQS2dDYkhNZ2ttdXdvY2FqVENnSDdlK2RFTkxmOGg3L1NJ?=
 =?utf-8?B?emdTcWcvdkZkQ2ZMTmhWcGg5MEExVWtDdnFtTTJSSTY1eVdJeTdzUjhmQTZ1?=
 =?utf-8?Q?7oGKWypo1fhOoJ33IamxujQIS?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 03fe5c60-d513-470a-fb3f-08dcef986421
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 17:14:57.3488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4AENUfS6xvWVVWerQN8f/rgDTs/UxlyXjlBdoPj49wmFHGuvIDygWsMUmysDfiJGzDfF98VYv08UdSEQkqIFkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7877
X-OriginatorOrg: intel.com

PiA+IE1heWJlIG1ha2Ugc3VyZSB0aGUgYXJyYXkgaXMgcGFkZGVkIG91dCB0byB0aGUgcmlnaHQg
c2l6ZT8NCj4gPg0KPiA+IHN0cnVjdCByZHRfaHdfcmVzb3VyY2UgcmR0X3Jlc291cmNlc19hbGxb
UkRUX05VTV9SRVNPVVJDRVMgLSAxXSA9IHsNCg0KVGhpbmtvIG9uIG15IHBhcnQuIFRoZSAiIC0g
MSIgaXMgd3JvbmcuIEFycmF5IHNpemUgbXVzdCBiZSBSRFRfTlVNX1JFU09VUkNFUy4NCg0KPiA+
ICAgICAuLi4NCj4gPiB9Ow0KPg0KPiBTdXJlLg0KPg0KPiBJIHdhcyBwbGFubmluZyB0byBkbyBh
d2F5IHdpdGggdGhlICdtdXN0IG5vdCByZXR1cm4gTlVMTCcgYmVoYXZpb3VyIGJlZm9yZSBleHRy
YSByZXNvdXJjZXMNCj4gc3RhcnQgYXBwZWFyaW5nLiBJdCdzIGRvbmUgbGlrZSB0aGlzIHRvIGF2
b2lkIHRoZSBjaHVybiB3aGVuIHg4NiBzdXBwb3J0cyAnYWxsJyB0aGUNCj4gcmVzb3VyY2VzIGFu
eXdheSwgYnV5IHlvdSdyZSByaWdodCBpdCBjYW4gYmUgbGVzcy1jaHVybiBhbmQgc2FmZXIgYXQg
dGhlIHNhbWUgdGltZSENCg0KLVRvbnkNCg==

