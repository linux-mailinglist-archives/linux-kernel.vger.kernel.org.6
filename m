Return-Path: <linux-kernel+bounces-344109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1971F98A4A0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F046B25587
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BD118FDD0;
	Mon, 30 Sep 2024 13:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mv5ftN+l"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D222AE8E
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 13:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727702341; cv=fail; b=ODf1b0aw+oTCTsm9IK+y8fohuz1/uH1Rt3wNkfgadATTEjaZlq3O1xZcca0hDxAImWeXNdhI5ZBb43HcTDTunGVL3ltTi7LwOuM8FeYyDvJHP5y4IKjEzfDdkQ9wu980pPVjoGXldFd5htDsR+JxQUwRAgFi30NqOtnpdY37E0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727702341; c=relaxed/simple;
	bh=cVF1b4u5PlSVcEt5Xp6zIZFDWAkY09kSnUVfel5KI20=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZtVuibIhxpByEFYwspxd9pjfAHJAMFmT4NqIW19/EwqxuOktY1wRSHLCpCxo09zhoaSgYpQoQ/M6CLALGkc1x9OdtyRClc6mTelcS11Bb53hep5vp3ygBIiTSC4E4/ZhdZQaJPdBOR2Ci/XDTpYncsiBCJhX3e2hme1Yf0FFSZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mv5ftN+l; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727702340; x=1759238340;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cVF1b4u5PlSVcEt5Xp6zIZFDWAkY09kSnUVfel5KI20=;
  b=mv5ftN+lXd+5MEXiPT3ctAMGn0b+30g5UucbHGRwNdRJXngG23+jU95E
   WG/CoSiDrBrXfSln9RR9vFQnC3tVmCGcBu9bU9HyjSDa0gtciTl+tYbDy
   dH5DTASNNFNR2LcbcdzQr6g9a8A6V1/cwJHV6GO3QcJ7lZ8ZjWNzAqQJC
   vso3dxTO6rJ9Z66A1LvE45AgGtrZoTspXq0xe3H9AhBx8a3LhmQ9vfsFH
   l/V69Z5MxUk6Wf+2A187N2pJR/3Vp99HNiguz1A1SIQiBy+hkDeGSbrj/
   Z4fwftgiSLvTnYJnloXgbfLVXbR/FYsdtLs0uTX4MU7GWdW0+Gjdu2aKY
   A==;
X-CSE-ConnectionGUID: oGHuwoW5S1CcxkFCoZ+LUQ==
X-CSE-MsgGUID: ncD3hRE2SY+K4iGzfAihEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="44308988"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="44308988"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 06:18:57 -0700
X-CSE-ConnectionGUID: VWWTVxEOQ6OkHdurp1yAMA==
X-CSE-MsgGUID: ssPeysA/QdqPq3WV33jTFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="96631445"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 06:18:57 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 06:18:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 06:18:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 06:18:56 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 06:18:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jHpOzfYJT05LSraK5gcLrraVQCtIuMjGM+0WmKKqu7nCdnw3/PWNFQSWt8Jx5/Nnh6dNy0DmEYF1vtxY82TQ3/qUQTa3JG0cPvWKvaEcjzevCIeu4Y9WBmsocqIVIHcYOq7hmXwGD7sDCq6hnV74bYrRbGAzcAZ8+XOJ1Tc/KPkzHfeF5WindTtSdOPWoR7ul2v0xRWpRF7lxiIHbH3zmLqM2c6ZE0Sbiyl06faq07MoshsD9KE9uW5S4YInGNqadZ7EfRhOs1nazG7hmjbBousRkyBEkwOqA9/f7HmNezule0/DBlgerOVSzfWRi5rL+DrFjxcRb3js7YsYUVGwzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sH+M7z6Pi2hv4ZyM0vtOz+3BIrrEtEsYuyEIfF8E4I=;
 b=jvS9SrHPz7SIrUreAJoJneF2Wt2OR1JyYAIKMwp1By71noezYzTg6sa7LAUUFIhES/LKwDHasUauOcSeHFhEkGq5S7Ha/+c7wXvER1eXBAZY2+5MWnT25XqchE/B8NckP1QY/h9lqLqvUyzcIOVuaCRGDKvVqbk/08w1BgwaQoMk+7AbKABAay2lxjadHaD7MwRpxHqaFc32GS+AU6F1tWwXLZuko33EZSw+QC7MOHGtGU4xJXgGtcLU5wMcZTLhI6Ikfp1vm5BjEndEzZLoRD8uoMzCbNLlf1iA39r9ZF0paWFlPAdmxUpCDOTp7H7YUN2BmXIhF2nhKpRUjtX4xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6204.namprd11.prod.outlook.com (2603:10b6:a03:459::19)
 by MW4PR11MB7151.namprd11.prod.outlook.com (2603:10b6:303:220::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 13:18:53 +0000
Received: from SJ1PR11MB6204.namprd11.prod.outlook.com
 ([fe80::fd8d:bca9:3486:7762]) by SJ1PR11MB6204.namprd11.prod.outlook.com
 ([fe80::fd8d:bca9:3486:7762%4]) with mapi id 15.20.8005.026; Mon, 30 Sep 2024
 13:18:53 +0000
From: "Upadhyay, Tejas" <tejas.upadhyay@intel.com>
To: "Bhatia, Aradhya" <aradhya.bhatia@intel.com>, "Vivi, Rodrigo"
	<rodrigo.vivi@intel.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
CC: Intel XE List <intel-xe@lists.freedesktop.org>, DRI Devel List
	<dri-devel@lists.freedesktop.org>, Linux Kernel List
	<linux-kernel@vger.kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>,
	"Roper, Matthew D" <matthew.d.roper@intel.com>, "Ghimiray, Himal Prasad"
	<himal.prasad.ghimiray@intel.com>, "Sousa, Gustavo" <gustavo.sousa@intel.com>
Subject: RE: [PATCH] drm/xe/xe2lpg: Add WA 15016589081
Thread-Topic: [PATCH] drm/xe/xe2lpg: Add WA 15016589081
Thread-Index: AQHbEzGuDi/TXGXrFESgTdQNp4+HjLJwTv0A
Date: Mon, 30 Sep 2024 13:18:53 +0000
Message-ID: <SJ1PR11MB620489928FA87A8C73FAE2B381762@SJ1PR11MB6204.namprd11.prod.outlook.com>
References: <20240930120602.1720218-1-aradhya.bhatia@intel.com>
In-Reply-To: <20240930120602.1720218-1-aradhya.bhatia@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6204:EE_|MW4PR11MB7151:EE_
x-ms-office365-filtering-correlation-id: fd3c1538-6a5d-452a-6b81-08dce1526e38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?T0Abvokz5Cf4qsAcYI9ehszyvmsbhE0vRhU19Yh9wQrffhHxQo0uPDowjIGC?=
 =?us-ascii?Q?f+cTR1yohnV6NfKwpnpX1Blx/ViRLOCYmTmq7ZYJVWQZRIJnvrz5nMZWF2pe?=
 =?us-ascii?Q?Wn3TB9olJhX0zw192eOsPc3wR1Hsy2XR1+67tG0p+VY37KwLGf//vrQahLFe?=
 =?us-ascii?Q?xscLyWDhA8YxFZXXKqEits0ZW7IaqsQqkyOSeeOteOrU0mlW/2vQBkzCX2GH?=
 =?us-ascii?Q?uyqUT7L/hW0rLKMZEnLT/m0tWh4mcH7L9PI0W0Qx0hWucy5Tp7cHyu8Dcwhz?=
 =?us-ascii?Q?2Lgh1ugpkfJo3SAgoCEPmTq/npI/qDCmaZ72/3rpWiUSH53mj1Jrfht24HwZ?=
 =?us-ascii?Q?8yfcZ5yL6eWnT5CND4vkS28RMh8hzEQ1ixU4/tXEW9qPL8IE4z4O5qZgsybm?=
 =?us-ascii?Q?m9w9yMSn9vnKI1OTwgWVr1N4VKxwSOg1v9/uPWZv04sNRyS/16FfznTG0+sy?=
 =?us-ascii?Q?HU9P51TfNTWUivj7gM6WAvZQOesZ2kwd3IDCIgCk5dtS+wbxNBew8XC5xJJv?=
 =?us-ascii?Q?TGu50+jvreUP/z/U8NxGRFedgDwFsK/lM5yu+LTXv2VqTqzA4hl7pXXgTwG9?=
 =?us-ascii?Q?NcPsKf+jFVP70GWXaQsvaaTuhLT0DwcARbbkal/Bkjy3LY+yuNndiKMLiv4N?=
 =?us-ascii?Q?ii/DlwwKljqjEMhlB2AZ3B4kvZbB/yYmRVyGPYIWD7seKzTy8L+MTO0Xu/uO?=
 =?us-ascii?Q?tXOXzYiy9H2FjJO5FgXxs0ggEySqGPFnekFHsdh8pP/xXG0Yp3ZyjppbbQZI?=
 =?us-ascii?Q?+jTEJycSH0O6AloAPE31wNqhV4aVolIVeM/DqwIExMm8wKwyxmGE+oVWdMBK?=
 =?us-ascii?Q?H0+JZI4NIGfu1xKLweGthpWLsHrntIAMBnJcDSQS0SrbgQVanufGoEfTjOXE?=
 =?us-ascii?Q?xUeOlMTbF+9K8eHtoO3l/7aF75bx2D1NBDaeXjv7Ly1nMtubz6ujYzxoBs1X?=
 =?us-ascii?Q?ZLB7b5mV1Yzr2XcoLo5F01qBZPN8wqE2c2UbeVJVzA0xz4mwbAyvw3CEYcHn?=
 =?us-ascii?Q?T5yye6PhO/98EmmIh0rHjZaA2r+S9plAgBNpVh9BWcBPQYO/+iJVwAmL0M63?=
 =?us-ascii?Q?eqpl5G5P5GDWA707uEJU9qerx0sXnx4QtuFPHHnUfT2fGoPzQU4pp6imOtlw?=
 =?us-ascii?Q?KBh8pUbD8MwWO/pHv8JxM4o3ERXPYfkBrmFeyouUBXJOa7/fmypATlk1m+fj?=
 =?us-ascii?Q?rtSletL5WpV195FCI9VutwkrdvazCEFMlJlV5k7rWxY6ids2ARgpoDC0vpi0?=
 =?us-ascii?Q?FEzcz4onEe5oWBM5JOF4xNcAJPSuJ2Vs4uljW/mvlhEshlXnTsCcw2/KHVoZ?=
 =?us-ascii?Q?V7rJVPQcYfwAGGip71pCGfCBZdD/FmjY3Ty1kRrH766R+Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6204.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gAg98YrxkecIOmerCxnycckrcKJs9lmcgE9mX7j9C6Vcw8ITh2nvbQHl1XED?=
 =?us-ascii?Q?dI05wbUa2VCJSzVxtFz4hJ/vyZHXZBrK6oaeEjZWqyAzzjMUpCMS3C4bHG6y?=
 =?us-ascii?Q?0nFeNBCpbsBKdlb1q1/hwsTWtFBMvKlgaoq/pn2EUtlK6GtlFd7i4hal5ple?=
 =?us-ascii?Q?Llv/e7ZgjQmAE/50PBrVCMcpyMaLCXNv32iGPLil7U3K1osQjc4HNqhZVfi+?=
 =?us-ascii?Q?BKRvMroG6GprjxXgSoODUEY2ZFLCqPi5kAdL6k+d6pgdihDG41pzM2AkKLkU?=
 =?us-ascii?Q?0aoLTFENqGVwGI+1k9WZeVGPYbx12DeDyptlDMFsdVPgijTQZ6vTkd4OqLRp?=
 =?us-ascii?Q?nKaTabsLIopwJT62rmdg0fr7/2x51q45F95DxgimQZ3SqTbCnmytx4p5Eix0?=
 =?us-ascii?Q?5Xaleg5tFAbEOej3/+0foytBZnLM0d11S1efyNL/RFyT41zusFj1RwlFlS3Y?=
 =?us-ascii?Q?iJQY4zkCio394lHt87VtvzD3n0ma6BDJIFENS63fpFwznLDI0sqaN/d9ZJJw?=
 =?us-ascii?Q?0IKARu0AEvj92SzSI5JhN0EFSXA9agYDURqrVBFmyiNs/eqhhA0n1pt3GvvR?=
 =?us-ascii?Q?v+Z4v2e2qSWOxTsIuhRNh6rh8BxG1PJP00ecnOiqlUXyjiEBXnze4+zUXa9p?=
 =?us-ascii?Q?EOeP6SGz3t1GhrYX0joaIkT5hwC+ROraXitePCMWYqtAPJtULzz/xgm1Wm+v?=
 =?us-ascii?Q?wQwRDrWRPfXO5+Y/ZpWpPSn23fK7UKRvdBpcfbLh2KgltJ0JXs1sj65uPKte?=
 =?us-ascii?Q?ZizP6a+S6IKD68N5MYBV5PipLUwqpLlXzk5xqciemuDgqRc+hUxdoeCvRmiX?=
 =?us-ascii?Q?Mi7J0tdOeP9PN0eWC7+Owu/wWArn7DJG/v1vE86lSaYDOx5zOBBorVhBozlv?=
 =?us-ascii?Q?9LP+oA31Oc4R9hwAMHFwVBRZcRKfHgUQWcktRUPoYoEHfsncEI8qF8oVRmJx?=
 =?us-ascii?Q?nVDFUnAhq7BSreECjL1UyvRFPFN/1amQTZO90IzTSsNJjSDoxdYMFgAsz78x?=
 =?us-ascii?Q?1yDl+UvqworvImvfxwsiL7fdCYkzi1zEuVti3caKCLcPEy3yFUhtRcOgp8y0?=
 =?us-ascii?Q?Y86jctwl7+LUmI0fOb73NLIwwp+qipJpKZ9ct5qaTcjGlbN0lO3WR24yfCXG?=
 =?us-ascii?Q?kXGWhS4LcIUtq30bZPUWaJGdr7ESJSxALFKRag/m6Op1gCWz4ywh4cbta/Sm?=
 =?us-ascii?Q?xsSAoMOQIXvqhBaTh3Nd+/6da4evmMXoGHfHPro8kk9b5uY59czwaICMRTOA?=
 =?us-ascii?Q?jpC++KGfcG66kZsgxIaXoR5NJqYWblBC3EJCMkzvskrNl+4H8ggLudF9IWLp?=
 =?us-ascii?Q?UkYsqMok6fOD7t3SD6hNlh8yZYV9DQ2VdR+hx6kpmdmC1LhRIGoIhoAlpQKw?=
 =?us-ascii?Q?b1wLzLhMiSXq/B1Oy3TwDODlYvEKqQrWrk4uu3EmrhZBopLk7wN/0aKjBNW9?=
 =?us-ascii?Q?KFXaK0c/nPOpqZUvGIaEoO5ByR6Jh0KiyuElsS4XumrV39W5FmFtPgGTbbIJ?=
 =?us-ascii?Q?xV+nu+pIsktCoT60VDmv1NPY3nRKfuQcJdiO6bp8nxxUPB/AaKfjTzyvAKVk?=
 =?us-ascii?Q?f8BSSDZJcINWIovgl/FF8MsVQiuLIWi63lEsGhbs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3c1538-6a5d-452a-6b81-08dce1526e38
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 13:18:53.2139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FyXcHFZ6m4/WOGz3MIFIfCBJPxx8R03yjWRCTHKLxqeEOv7ubsxFfKhaT9U9pMzn/4w2PEibbxnL/L1ejdBb1NOjTnuEPWbaO6ALGhbx4KA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7151
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Bhatia, Aradhya <aradhya.bhatia@intel.com>
> Sent: Monday, September 30, 2024 5:36 PM
> To: Vivi, Rodrigo <rodrigo.vivi@intel.com>; Maarten Lankhorst
> <maarten.lankhorst@linux.intel.com>; Maxime Ripard
> <mripard@kernel.org>; Thomas Zimmermann <tzimmermann@suse.de>;
> David Airlie <airlied@gmail.com>; Simona Vetter <simona@ffwll.ch>
> Cc: Intel XE List <intel-xe@lists.freedesktop.org>; DRI Devel List <dri-
> devel@lists.freedesktop.org>; Linux Kernel List <linux-
> kernel@vger.kernel.org>; Jani Nikula <jani.nikula@linux.intel.com>; Roper=
,
> Matthew D <matthew.d.roper@intel.com>; Upadhyay, Tejas
> <tejas.upadhyay@intel.com>; Ghimiray, Himal Prasad
> <himal.prasad.ghimiray@intel.com>; Sousa, Gustavo
> <gustavo.sousa@intel.com>; Bhatia, Aradhya <aradhya.bhatia@intel.com>
> Subject: [PATCH] drm/xe/xe2lpg: Add WA 15016589081

We can say, extend WA 15016589081 to xe2_lpg

>=20
> Add workaround (wa) 15016589081 which applies to Xe2_v3_LPG_MD.
>=20
> Xe2_v3_LPG_MD is a Lunar Lake platform with GFX version: 20.04.
> This wa is type: permanent, and hence is applicable on all steppings.
>=20
> Signed-off-by: Aradhya Bhatia <aradhya.bhatia@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_wa.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_wa.c b/drivers/gpu/drm/xe/xe_wa.c inde=
x
> 22c148b1e996..2f9cde4b7d45 100644
> --- a/drivers/gpu/drm/xe/xe_wa.c
> +++ b/drivers/gpu/drm/xe/xe_wa.c
> @@ -710,6 +710,10 @@ static const struct xe_rtp_entry_sr lrc_was[] =3D {
>  			     DIS_PARTIAL_AUTOSTRIP |
>  			     DIS_AUTOSTRIP))
>  	},
> +	{ XE_RTP_NAME("15016589081"),
> +	  XE_RTP_RULES(GRAPHICS_VERSION(2004),
> ENGINE_CLASS(RENDER)),
> +	  XE_RTP_ACTIONS(SET(CHICKEN_RASTER_1,
> DIS_CLIP_NEGATIVE_BOUNDING_BOX))
> +	},

Change LGTM, If CI results are ok, you can add,
Reviewed-by: Tejas Upadhyay <tejas.upadhyay@intel.com>

>=20
>  	/* Xe2_HPG */
>  	{ XE_RTP_NAME("15010599737"),
>=20
> base-commit: 0c8650b09a365f4a31fca1d1d1e9d99c56071128
> --
> 2.34.1


