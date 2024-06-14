Return-Path: <linux-kernel+bounces-215209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 314F7908FC7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE87282E1B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CB116E888;
	Fri, 14 Jun 2024 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DYzCJNGX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E4115F418
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718381632; cv=fail; b=mpNh+EaGQP6I+ZMrL3znIZ3V+LhPTTD/isK13oGEKTpEFgoMKUrSuM1JuXQqOdb08dDcvkIy+jBycLAEGGPwLZk3B0pMhlzTJn1D8kKCdkUqi7d+aNcqeK9lzQHOLq5eqN+okP/R9JwMzsCvSIYY87AsZw7hiZ8k81dSMfoDSos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718381632; c=relaxed/simple;
	bh=44p+F/hefBY4jA4XpcwIyla821pZgc1ris7GS83Dvmw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ICvcZHrLNEXCuo/e14/hUCmlJ5nt+Dp4aywvBcb23RLRAOwVWUm3cczXhraOoMOWyUWgSAjP1ElFKTChaHCCS1mAi+y7twMg600pZPLO82uqiStuW3NzdDG7m+CqCF2uv2+I3jLO/3zmxq2fAxdiV7m+807nnQnTD7xugk3vnho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DYzCJNGX; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718381631; x=1749917631;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=44p+F/hefBY4jA4XpcwIyla821pZgc1ris7GS83Dvmw=;
  b=DYzCJNGXKT5UI8zAx69LV3kZY0x4z1aJcrqdbFBvXdcsGoo1toT53xXz
   ZZHcf3WnQWmgwbGch9hUU0KBZ0MQ0Rnd63o4URUDKZNrH834+adRU46GJ
   vRILSwcHmoxw+/VrqVBxnyqLYL4ScmjD0t5cyw8EvIKyp2sTaHVxC2PoP
   rC15xf5U7lnZ/10dlhYzMfvAOug88l2SX8CxXiynbMSucTTggQN/bBBtv
   BSMJhMLQfQDeLS3TvthBRrH8ytaGmmJUvbxD6dVCnMd0XKhU+9LmQcDxs
   6BTneyEiaegG00en5i8Eknxs65S6AoklGw/UD2Qft5i9B3g8SOvg4g40s
   g==;
X-CSE-ConnectionGUID: nLklvAgiS1eXzkeLd3mBGQ==
X-CSE-MsgGUID: 5LCNF+6cTW6m9IAqItzr2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="15408589"
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="15408589"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 09:13:51 -0700
X-CSE-ConnectionGUID: cEqDypA4Tl+YESRTSfQ07g==
X-CSE-MsgGUID: 6GU1vmFNRn6sKehuZDGxDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="71322334"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jun 2024 09:13:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Jun 2024 09:13:50 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 14 Jun 2024 09:13:50 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Jun 2024 09:13:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDaZLxUh+lLj7WY1NaS/2y4SrGmrs6rIy3D4GhRQZz8qMlyhxwd/ous6FEN0lrgeQeEh39w4pVueiqwffK8u8YZR4pv8a+rGkQfDmlcDHY2UkL75reIfVLaJITg4VRHsqJfM+aGt2zBSPSlSClg0EPl2SkfbO2j1fk79PaIRYNYBxwdhIWE8VEL4/p9NYolsYNIk+Mcs1YSFBlVtA6mPrxIxJoooArEK5pgrSyJk94bjP1VUjrezScfD+QB6Lph38tMeHuOukJVGTlLaXgpTUgpyVD1JldVQ5Q0cZEv6HLncfo1PP/Pc2lPk6xKwXEWGEOCnxAreqPQBV4Nnwl5Y4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44p+F/hefBY4jA4XpcwIyla821pZgc1ris7GS83Dvmw=;
 b=H/Nbsx76RE/BDaNsGZvwR8v9Qk7hRnq3lyr1+YvasD884F2SCtw0aDNtSJcNnddzAAtTPjIDw3CUeVUO6Lsz8NTbdfadKZneUNzbwA/z+bb4xOIIbrKIKNr+YJL1uL1uyBwLmOJqr1FhrXert2VINlcwvdLQlxCmxg/MbZaNWHIRVR5NHVESE7PW71kUhc0p1qqiJo/m37WoqeF7YOfDetUqobtu6t9+6csNTgRovo6XqXeYaS5IUWcJG6gBKe1bsXsrx0JDN//QXSDkTcGb9MroP4wuHBIWtMl5yPZPQnYpA4/Hbp4gK7raQXwG0LBxG1wG/UeffkX0fIV5+qpxNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH7PR11MB6555.namprd11.prod.outlook.com (2603:10b6:510:1a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Fri, 14 Jun
 2024 16:13:46 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%3]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 16:13:46 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"lirongqing@baidu.com" <lirongqing@baidu.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH][v2] virt: tdx-guest: Don't free decrypted memory
Thread-Topic: [PATCH][v2] virt: tdx-guest: Don't free decrypted memory
Thread-Index: AQHavhnWPWitpshurkqdy2O3JVNKpLHHb3WA
Date: Fri, 14 Jun 2024 16:13:46 +0000
Message-ID: <c209517e42fa83cbc3f030293f89813a6c1cfce1.camel@intel.com>
References: <20240614051452.14548-1-lirongqing@baidu.com>
In-Reply-To: <20240614051452.14548-1-lirongqing@baidu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH7PR11MB6555:EE_
x-ms-office365-filtering-correlation-id: 15a58810-e8d9-457f-f58e-08dc8c8cf80e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?RnVYdWFJcDNLem95a21INDFlOTJEWXpPV3B0SkRQYzBmM0hqeERUVEwvNzYx?=
 =?utf-8?B?ZnN2cm1lVVhPS1JLY3lIYXdyVXFpL1NIOXVOV3RPTnJYUXhuV3A3T0FmNkNK?=
 =?utf-8?B?c1hpZVNDSFRQaEhVM3B5TnRPMDhOd1RldDhJaUgxaVFTcnJnK2ZqY0l3aGl2?=
 =?utf-8?B?bHdnUHl4eURLSklISGlRUmdncGMzeTNNUFBCUG9haC95cG0xeXJFSHVzRG9h?=
 =?utf-8?B?VG9qOXA0L2IxK3JQNnVPK09qNjc0YitYdjJtYXVnaXRKeHE0WHpoaTdiRGtZ?=
 =?utf-8?B?U3hrWWIxK2xFTzBtaEU0N1YyYTVtZjdOZTVHZHd5V25sVTc5UnUzN25KSzlW?=
 =?utf-8?B?SlE2UDlsWXlRTmthdU1FNTR1cXVaSEJjMHF2bUZVc1FFejk5UUIvdzAvRUpC?=
 =?utf-8?B?azNVdTZlMm9hYVpaTm9SRWlwenE0QjhCMTV5bHdUdXRlMGR3a3JWd2w0cnQ5?=
 =?utf-8?B?OVp0Yis0L1B6MFNBclJWRDc1dGhZNEE3ODlaYWtOKytmYXZTcGc0YThrai9R?=
 =?utf-8?B?d09OcS9LRHRCT05aQWRtWDVsZWxjOUE0N09GcUU5L2RDS1hZNk56WUtyR0ht?=
 =?utf-8?B?VEcveFlSWkF5dk5yNTFnUFBZbVZnaUQrZm1ncnhFeWxmVUtORHBHc2xpREtk?=
 =?utf-8?B?Vkllc2ZCeSthM0xrTE1DSXdYMzR1K0FrckZLMWoxNnI1S0hpM0RYQU1iTlZP?=
 =?utf-8?B?TktLbDJQL3hSUFRScXdaTkN1T21vaHVjMnA2MVVKRmQ1bGg4bmNnVTd4MEsy?=
 =?utf-8?B?ZHoyY0lFM0EwT2JMQTBuZHQzVkZ0MHI3b0Z0Y3BpT0JkRFZOQXp3aFF4QUo2?=
 =?utf-8?B?eTcyTXdkWGt0ZkFjN1VsSlhsZjgyY2wxZmxTNzRyUTdFVVhIcFdzbHpmd2hG?=
 =?utf-8?B?a3FiYjNJcmRaL3NqdmxOQU1iQmpiMnBWQkExMFVuUUUyYUhMS2lIL0ZKTHA3?=
 =?utf-8?B?ZXRBSVNJSHJqUFAwS3ZHQXIyM2FZMTFRZ3o5cTIvT2s4a3lUdnptM2FzZzg0?=
 =?utf-8?B?L1VXWk11aTdKOHR4dHFSUkRRamF2R3AycUZ5NHJMQnIzZktWMUhCcnpLaHpj?=
 =?utf-8?B?aVBMcVg2WEd6bWloOTF5RWN5WnhncFJrb2RQVElqWUUzNjZEMnFVeEtnd2Vh?=
 =?utf-8?B?YlVGS1JtVm93ZkI1dGxZaHpqaE56bkhCS2txZjVwQlh3VEhMdHRlaEJ6V1dL?=
 =?utf-8?B?UzhrMUMwczZjd2ZyVEI5RTZ3Z3VNVjI0clVjMUEvNjVEMXU2MWlLc3VmYUZL?=
 =?utf-8?B?bmp0bFRjcVltbGY2V3VReElFM2lpclJvNGZGOGJEWlZHNlBQOUlNY0RZcmxL?=
 =?utf-8?B?amtybSsxL1BqVTdYMHJjME5ub2E0QlVFNm1iU0lNdlBhQStwQ1RSWjEzdFYv?=
 =?utf-8?B?c2hNZkRrUmZUT2dCaVNDVE1BcUcwYzNYOWNKWElWOWtVZlcwZDJJdnFIMEN5?=
 =?utf-8?B?QlhyUlVhbkczRC9jSVlFdWIzQlZDaGhkNzc4WHJXaFVueFZVeVZJREI0ZVM1?=
 =?utf-8?B?bWx2NFVHWDhZSDZ1cmNmeVdEOUxmQzE2RkgxaE1LWHFRV2N4dklhS1BTWFlG?=
 =?utf-8?B?MU9iM1FrMVd1ckNEOUNxYkpNT05BdEhzNHNXMzN6VzhaV3QzSXNQbWVCdnE5?=
 =?utf-8?B?RXBHWHFBelB4S2pObTd2RVlVSDM4aWQvYkRTYmZCc1VuUWxjcExaSm1qaE9l?=
 =?utf-8?B?NmZPa2F2VWExYXZPaTlsL0YzTCtZb2lQa0FkUWh3MnVmd2xQQXRSR2xjdC9p?=
 =?utf-8?B?K09hSEVMQVRUOWpLSWtad3VOTW1qcDJZS2hWUHpuZ2dSOGtWQ0ttYjFIdFZX?=
 =?utf-8?Q?XT+GAzrgfAppFjOj9QgY6+cChYooaHTniReQg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTFRMHRESWpCMGtTVTR1emVSSytRdzY3bWpZMDRRSkhRRFZ5VHZSbUMzaTNF?=
 =?utf-8?B?ZVlRd3RpcUhPNU03ZVBQcHZHNEhFRkROZUsraDFvNnBWeUZBaVNxOUJmRGRX?=
 =?utf-8?B?dE9Da2FvNVlQVGlkUEZJYkJxSVFsb24zOUp3TFp2SmhCWGVmU2xzdFlleE1N?=
 =?utf-8?B?WjFsWHp2T0MxekpmcjYybDd5cDhNdExNVGE2QWpKS0VlM0p6blZmWGlmYmtP?=
 =?utf-8?B?cFU2bWZhT0h1TXpqa3pQbnFBR0xrc09CZWh2bVd1SjhUTmlaYTRpa1FQZ3Iw?=
 =?utf-8?B?c0cxYmlKVzZLN0RScW5acXZXV2p2TzJBQTBvQ2N6dlE5UWg3MFNKWUtRdmdU?=
 =?utf-8?B?d3djSVBhTlBtNk5BTyswSDZOTEVyWDdBOFVrR05PUTN2M3lNbW1hR1NHakRi?=
 =?utf-8?B?OElHZkdHMU9XYVFNMHRCMzdSTmVjWXIrSjNHcWMvU0N6ZkFRRXI1c2JGeTVO?=
 =?utf-8?B?MXNwWHJwenNNTWo2L054bFo4bFp5TFFGZDRBeTRnd0F5Tk9kYVlKM2pUZ2ts?=
 =?utf-8?B?WjhxZ0VtM3NCQWtYWGNCTEZ6anVLRmFkNDV3Mm12VXp5YnBwaU1VR3RtSnE1?=
 =?utf-8?B?cjV3MzN6NUlIa0h6emh2TWllaWNMa2pmaFFyT2ExSHpicjZzaWVzNVk3NU9T?=
 =?utf-8?B?UHZqcG1BS1ZGb1BFTWJsOEZ4dFhId2RFMFdGMEZ5ZkVWU1FVNXQ0a1hRZWRp?=
 =?utf-8?B?b2NMN3B0Unc1K3V4cFpUeWZxdGV5MG9udmt1OFgzL2VjUWdTNXdCVzhURjkw?=
 =?utf-8?B?ejZBY0xmdm1VenptU0tuWTJXLzd3MWJrUGEyYlIwY2ZCK3FCUlNJR0g2cW1I?=
 =?utf-8?B?eHBnUVFXRXpseVBkMStjbUVCanZ6YkljQ3RyRWx1REg0d1Q1cTVaQ1ZQdWg5?=
 =?utf-8?B?T09ibStSa295aDNnTVFIVjBEWlExRkFJZ01VS0g4cTFTREQvU1FWZDVQMGwz?=
 =?utf-8?B?VlNTalE2SFI0ZEFuM2huaWJBajJUUVBHeGowbU9BRUo4K1pGdDViL25lQ1p1?=
 =?utf-8?B?QnJ1VTR6U0tHMzdHS3IzSWFUb2hqYVQxY2xLOC9hQkl3VlV2a1RFQjlRbklV?=
 =?utf-8?B?L0Vzc0xmRGRKUW44R3plMTJreHlzQWVLS0dGZ0lsU2puMUlCVzhpc0ZubDhH?=
 =?utf-8?B?S0pZckhydTJIdlhFQWM1NWJnekV6RTg4bnluSVlyR0dEUk1qSG5TeVJXYmRQ?=
 =?utf-8?B?RHZGbm5iSGxYSFM3ejRSbHZZVDRZME1BenpmVGVMWUV5dzY1UDNocjhidDI4?=
 =?utf-8?B?V3hyK3dFRy85cElDNCsrdUFrYWEvbFRLTjVMWGpqR0o2cEk2SEY1YTZzMFoy?=
 =?utf-8?B?NE9NRDBjaExPTGhycjJ1R3dKUU1VbzZiNTIwaXpUcjAxNzI2TS9ybHh5MlpW?=
 =?utf-8?B?Vk9RMjZJM0NBTU5BQ2xRTU5MdzdMb2p2RzByUnJOSjNLSE54cFFYRUxUQy9W?=
 =?utf-8?B?WkdrZ0xVM3gwSzhZL1N4Zy91WTUyeW9udGczd0ZnZ3ZsQjRpdGs5VDcrbUdj?=
 =?utf-8?B?bE91TGRoS1RSOXZzMU53UHRsVG16VndUUTc5bXdsNUd6aithZTlwM05uMkdV?=
 =?utf-8?B?UC9VeEQ1T1ZqdHlRbUJHSU1GZGtjOW9FYmp1Wm9WRnFxZWZNQk5ZbVdRMysv?=
 =?utf-8?B?VmdURERpQUZ5bjVReGtJKyttNlhkTFN2T245eTZ2TTJZRkp5WFdPbFhmTGF3?=
 =?utf-8?B?dWlpbjduSDdKV0EranpBVURXL01keWdkTGRiVFJVdzJNZjV2NDJiQmplRlkx?=
 =?utf-8?B?S2t0bno4amV1TWtlSnJVdWs5V0s5UWNYaGRUUFAwSUJLMzFyNXF4QzZBeXdT?=
 =?utf-8?B?Ukc5VHRGWVNCcTl0N2Ria0dtR0hBaEdOMnFDaml3NnYvaWxDNDd1U0FBb3JV?=
 =?utf-8?B?aGViQng0bTFaajZvMjhQa1hDdnFYV3o2dGhVRzBJRnhUamNXMWxFWDdRNWcv?=
 =?utf-8?B?VkFKVlBGQzN4Z085a2FYWUo4VnpqTUN2WXJEZ0tzNHl2YnBsUUFsZnZLT3g1?=
 =?utf-8?B?VzhnamUxTlJGQTk5cHhzUFcrWkR6V2kxTFo3S1dNSS9zdVpTaHltajkwbGMz?=
 =?utf-8?B?dC93aFFNVFFRTVNTY01ob3UyenI4dWxJelg4ZzRiYU8wcXdCZlB3MFBNVEYx?=
 =?utf-8?B?RFhCQzNuV2xGTXJOYzlwL0ppKytGLzVUTlBYak5xc2liN2ZKbUlYbE5iTzhY?=
 =?utf-8?B?a2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8CD14450B582A48A673C283FA352680@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a58810-e8d9-457f-f58e-08dc8c8cf80e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 16:13:46.4299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b45cS4ZMMvb+ot6PGv9u+29ZadV+xMBM2KJ0hs63IV5NJQ3vCr3PbNHwncwI7Ra4I7jmeu2H8p7foMq3JUncN2SkytIMlNAY5v1ri9AT+eQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6555
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTA2LTE0IGF0IDEzOjE0ICswODAwLCBMaSBSb25nUWluZyB3cm90ZToNCj4g
SW4gQ29DbyBWTXMgaXQgaXMgcG9zc2libGUgZm9yIHRoZSB1bnRydXN0ZWQgaG9zdCB0byBjYXVz
ZQ0KPiBzZXRfbWVtb3J5X2RlY3J5cHRlZCgpIHRvIGZhaWwgc3VjaCB0aGF0IGFuIGVycm9yIGlz
IHJldHVybmVkDQo+IGFuZCB0aGUgcmVzdWx0aW5nIG1lbW9yeSBpcyBzaGFyZWQuIENhbGxlcnMg
bmVlZCB0byB0YWtlIGNhcmUNCj4gdG8gaGFuZGxlIHRoZXNlIGVycm9ycyB0byBhdm9pZCByZXR1
cm5pbmcgZGVjcnlwdGVkIChzaGFyZWQpDQo+IG1lbW9yeSB0byB0aGUgcGFnZSBhbGxvY2F0b3Is
IHdoaWNoIGNvdWxkIGxlYWQgdG8gZnVuY3Rpb25hbA0KPiBvciBzZWN1cml0eSBpc3N1ZXMuDQo+
IA0KPiBTbyB3aGVuIHNldF9tZW1vcnlfZGVjcnlwdGVkIGZhaWxzLCBsZWFrIGRlY3J5cHRlZCBt
ZW1vcnksIGFuZA0KPiBwcmludCBhbiBlcnJvciBtZXNzYWdlDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBMaSBSb25nUWluZyA8bGlyb25ncWluZ0BiYWlkdS5jb20+DQo+IC0tLQ0KPiBkaWZmIHdpdGgg
djE6IGxlYWsgdGhlIHBhZ2UsIGFuZCBwcmludCBlcnJvcg0KPiANCj4gwqBkcml2ZXJzL3ZpcnQv
Y29jby90ZHgtZ3Vlc3QvdGR4LWd1ZXN0LmMgfCAyICstDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92
aXJ0L2NvY28vdGR4LWd1ZXN0L3RkeC1ndWVzdC5jIGIvZHJpdmVycy92aXJ0L2NvY28vdGR4LQ0K
PiBndWVzdC90ZHgtZ3Vlc3QuYw0KPiBpbmRleCAxMjUzYmY3Li4zYTZlNzZjOCAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy92aXJ0L2NvY28vdGR4LWd1ZXN0L3RkeC1ndWVzdC5jDQo+ICsrKyBiL2Ry
aXZlcnMvdmlydC9jb2NvL3RkeC1ndWVzdC90ZHgtZ3Vlc3QuYw0KPiBAQCAtMTI1LDcgKzEyNSw3
IEBAIHN0YXRpYyB2b2lkICphbGxvY19xdW90ZV9idWYodm9pZCkNCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gTlVMTDsNCj4gwqANCj4gwqDCoMKgwqDCoMKgwqDCoGlm
IChzZXRfbWVtb3J5X2RlY3J5cHRlZCgodW5zaWduZWQgbG9uZylhZGRyLCBjb3VudCkpIHsNCj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZyZWVfcGFnZXNfZXhhY3QoYWRkciwgbGVu
KTsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHByX2VycigiRmFpbGVkIHRvIHNl
dCBRdW90ZSBidWZmZXIgZGVjcnlwdGVkLCBsZWFrIHRoZQ0KPiBidWZmZXJcbiIpOw0KPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBOVUxMOw0KPiDCoMKgwqDCoMKgwqDC
oMKgfQ0KDQpJJ20gbm90IHN1cmUgd2UgbmVlZCB0aGUgZXJyb3IgbWVzc2FnZSwgYmVjYXVzZSB0
aGUgc2V0X21lbW9yeSgpIGZhaWx1cmUgd2UgYXJlDQptb3N0IHdvcnJpZWQgYWJvdXQgYWxyZWFk
eSBoYXMgYSBXQVJOLiBCdXQsIEkgY291bGQgYmUgY29udmluY2VkIGVpdGhlciB3YXkuIEl0DQpz
ZWVtcyB0byBmaXQgd2l0aCB0aGUgb3RoZXIgY29kZSBpbiB0aGUgZmlsZS4NCg0KUmV2aWV3ZWQt
Ynk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCg==

