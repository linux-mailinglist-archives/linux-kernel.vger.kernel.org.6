Return-Path: <linux-kernel+bounces-524151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E9AA3E003
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFD857AFB95
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37376204874;
	Thu, 20 Feb 2025 16:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QWk4mz/t"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7591FCF78
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067333; cv=fail; b=Q/O9YVFT/G7hmEIwAv5RO2a8OY/9j3jTgh1yaaOAnDASepvt5CulRu+tab0lnTpacL50BT4xD+l6n3KON/hCXQ8lR49E4Ya562DMNPRL4tvddNd3iuM9DCO+9Iv9oDiP2Wt2eNMpsneOsR3d9S0aUb2bgTUH+aMVSd/D5iw2rj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067333; c=relaxed/simple;
	bh=DQbVsCV1GB4A78apiqBjY0Ewla7uHPqSGgBqQ6Sfsqs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SrFqwMnCBw+co0s4fI0PbQlaPIOxHmTNnkANoIrc9GOYX75T/NaDL7OIIL9BVftVcocOBlZucITYBVUNBwrlG8MlTBoFb5l7T3RgnOxRbG7eMrlKQNj/ndHD+yDFGsY10dQfk+Vw8PZCOYAOSX9u1QTiYRlIfIJKrd/Gx9XFpzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QWk4mz/t; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740067331; x=1771603331;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DQbVsCV1GB4A78apiqBjY0Ewla7uHPqSGgBqQ6Sfsqs=;
  b=QWk4mz/tO9M/bBtWt8sIM5qieyJy/jWefZLc46QVSgUJ0KOHF1m7pXLm
   7Nrmb0oeFaTvhYBMSH7xIQpXvjo+M5ulGD2DWJVnCq4S4EBAUsPt3Xfdl
   zy1ekLN67Z5NK7fGQGGCwq2A1HUD1yWYIc/M09rNasP05xPK1wjFyzCfa
   uolQnBKajD18CQew2GAj/EqziQb+p0w1NLv7ASATFJYsE8U8Wu2rNfAmo
   uDzIX0J9dVVZLSxyUGlUXRd6DAJ2cBmCXenc6Xff/oiTmWh1pkVHRj4bc
   Q4a4IZcKG+KWy33d6lzpxkS6GruCRcBtOL9YoTCZYU7B+9tYM//gTUWgp
   g==;
X-CSE-ConnectionGUID: m2clP7VCTdyftw6pZGhdJQ==
X-CSE-MsgGUID: vDZKBPe2Q5KjW+a6u8VJog==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40990328"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="40990328"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 08:02:10 -0800
X-CSE-ConnectionGUID: XS4McL/JTTSxzrF0qGgJdw==
X-CSE-MsgGUID: IZcZzrkSR/GVNVBBPKLjlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="115293071"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 08:02:08 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Feb 2025 08:02:08 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 08:02:08 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 08:02:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZeusGrByMAgo5DiSDrFSsC0f4DPgv9iJDUDZgJBj7bE2UjX8EDCz56wax1acxIM3AThRZ5dPzXQXpQcVAsWhrxpGt4rxwTvUrR0bbS5e6kqgDeZdYVI0XyGmGnjV1qdScC8+LW7NmTByNoazsFC1getpRfVwLPxgRkgwUNJCz7EFkj7FrP+sm9G/Em9XKqqFn/2vwYlC4NtR+QJDLV6J0wck2U0lgREf0COEWHKivxl150+zSZJm8Dcn1SXkyrkfq++2GaO1CKwWT9UcmA38xAU3QSmzsDunSVCVRiCaCYRc/U3/cuEHtpZYX1NIBs5OPoHRrHsWNYNeyEACZaHuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dngw1uFnsTDcj364KjH9lRMQ2h4H0X30wk6Tr7Xhz6E=;
 b=tv2oiE3JZWxBqVCBUROBqlCH9Cj3uuBGQb1BZLVt/1G+fJ7O6EBXMwc3WtV2YCv4omgtwJCUK5n2rpiU5rAR5hPgE2UL9aiiZjRfCzJz12CKBaB8SOBa+DftX08aOEqn6/ipQTafdO16jpoBrDRhNDfO+nrKIjW0saBHu41Q0Huhsoq06XTnaunJR7JfpJ8wyi5FmzymqgprT7f0hYJPASFLN+VROBWB3vNcmw0/M4NNeCq5j9cYPx4Oi/STepXRyzcD7GdkTfi1s9vcgzIM+sqXV5eZDW5b07MTq7jgzyyKdRQV2ai3d6QU/C99Q5OyRrtDqRSUc+XFGfw0m3uXCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV3PR11MB8579.namprd11.prod.outlook.com (2603:10b6:408:1b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 16:01:50 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 16:01:50 +0000
Message-ID: <0672ad74-782e-48b9-8591-7e0bdec84845@intel.com>
Date: Thu, 20 Feb 2025 08:01:47 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/42] x86/resctrl: Move rdt_find_domain() to be
 visible to arch and fs code
To: Catalin Marinas <catalin.marinas@arm.com>
CC: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, Shanker
 Donthineni <sdonthineni@nvidia.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-13-james.morse@arm.com>
 <acdfa4ee-e293-49f3-8e53-900b9db63ddb@intel.com> <Z7cK1FpQCgBVSGHq@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <Z7cK1FpQCgBVSGHq@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0293.namprd04.prod.outlook.com
 (2603:10b6:303:89::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV3PR11MB8579:EE_
X-MS-Office365-Filtering-Correlation-Id: 74a9370c-0f58-4279-6d25-08dd51c7e2f1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vmo0dHNhNGk2QUNrT21BV2V3dUhyclRsQ2M0WUZCbUYyQ25aazFVMlZHT1Bs?=
 =?utf-8?B?TVl6RXg2eCtKVVJmRjJUSDdRQWh2SEQ1VldraGxGeEtoYnA2Yys4RXlxbnpy?=
 =?utf-8?B?aUQ2WWM5UVNDR0kzdFJSa1Z5MWhTOFo3V0loRmxDS0poMWVVR2Q5MXBhaTB5?=
 =?utf-8?B?bkNlRUcyVnpoMnNmbmplZTdLdmUxM1kvZjRyc1BwZ0FraUFtdHBuS2RBMEFv?=
 =?utf-8?B?QmZDRE1GRGlFSG5mMVVBc0M1YzRLUmJDT1pBYmRvTFZ0VVBYbkJmMHpmT24r?=
 =?utf-8?B?SVhVUjRyTXZJT1hVcTJDNkc5Z0liczhGZEtMVFEzNk5jN01pR2xJMDZtdGY4?=
 =?utf-8?B?bzBxOFBERnptSUs5VDlkc1YreTdiUWVlUXR4a2cxYmhBV2szKzBOd1F2eGpB?=
 =?utf-8?B?by96OWFCVko2Ym1MK21mbE1sTmppclk3bXo4alI4RnZSNE1XcU1hN2J4c0Vs?=
 =?utf-8?B?cy82c3A4Q1JYKzJEc1B5ZHp4S0lJdFY0ckRPUGZ3dkhkVzQ3M01kUzQ3MVNJ?=
 =?utf-8?B?bmRGY3p3bWtNZTdSaDJRYW5RMnA5NExkYTJjVUxpRldxaElYTHdWRnBMcmJY?=
 =?utf-8?B?QVBmc0cydXZRa3poWTJxMnZ3aFQ5VWVIZm8rWW5GUDQ0bUQ2MXZlU2EyOVN4?=
 =?utf-8?B?bHMzUFMwTUdsOFFRVlF6WllURmk5bm0zZDByK3VtMGdmZWJrb1drcjNPVjRz?=
 =?utf-8?B?cGR3bUtIdFhDU0dNVWZJZTQrQUgxTXlZNWhXVVE4VWR4bC9vZEVQSkZiRXhN?=
 =?utf-8?B?UXFTK1cyYk8waHhmcWxhcEhPaWd6REdaaHJNUStrOHFhOTBSNEx5bW5Idksv?=
 =?utf-8?B?cmhoQ0lSU0EydXlFOHFSdisrWTFpeTRmV3RZSlR0V1pDVlB2c2tTQW1ZVXlm?=
 =?utf-8?B?UzJQMFpZeEptaUNsYmZoOWprZjQ3MTJNbzkwYU9BZER6UDFVeHdJNDQ5RFFR?=
 =?utf-8?B?c016RUI4dUlZU0ZkQmNyOXRKSStDZmIzNjY2NUJHL3Zvbk9ydkpYdmVIa2Zt?=
 =?utf-8?B?RForTDZJNm1Vb2dQNzJZL2VkYXNEbWk3ekx1Um43L09heUVJSzcyN3J6MUEx?=
 =?utf-8?B?MFdDb1lWbDdLSXRVR1hYbGVlR0s3ejFBSnYva0R4N3lIOU4xaDBnWi9QTUFE?=
 =?utf-8?B?Z2I3MnNYL0VqTmI1ZHVYTVZleHI4ZUFQMWNqWFkyU3haUnIra2QxcEx6eWlv?=
 =?utf-8?B?Y3YwblFoUzc0QXAwNDgvRjRScDRmdG5mN054TVpsWnN5dkpZcGlBaWhDR2ha?=
 =?utf-8?B?STUvMGxnSFllNnRRZnNqUkdxUTY4UHFzckU1ajJjTXhnc1pmODZsRFdnVW9p?=
 =?utf-8?B?ZW5NY0lSU2dWU1VxMUFBaVZPQ0NiYnFneG1WZUhiNHV5clhzTFRRVUUzTFU0?=
 =?utf-8?B?SWZLa2NjbWtWckI3cWNmb2J0dXhKUlFGZStPODRPSUk1eUY1RWp6K3VOeXp5?=
 =?utf-8?B?RVd4VFNjTHB1Q1d1YXJIdkxRK1IxOGx0ajg1U3FCZ0gzOTVjMmxQUzd3OFBD?=
 =?utf-8?B?QldXdHZsWUQremhmaGR3MkxteXJqbVNaQ2taTE4ySFVBUXRUV0M2ekRBMHl2?=
 =?utf-8?B?R2h5aFNBM1NKME5VTXRLSTU4b1lLS1hJaEhWSkpzdUYxVzBnUDdtQkdWL1Ir?=
 =?utf-8?B?OTJrcndjQTZRTnZzZlpPSEJKMXNRek90NG9TTkNDaFhET2pVYjZpalZ5VlhH?=
 =?utf-8?B?a1ZuQTErSEZMNUFGUk84ZHBjUHdwZVgwWFJrQUJsanpZVjR2RVh2NTE2U2VZ?=
 =?utf-8?B?MjFiTFRTQTNDNXNpL0s5WGY0b0hhemhQN2lLQ3Nsb083NG1KQ09xQk13Z05j?=
 =?utf-8?B?dVdCY1BKS3JDTmgyTWlIdS9zanBsVlVSSVVmSDd4R0RwZjQzU2lyV1lqWXpy?=
 =?utf-8?Q?sQbYT60CdeP/M?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG5UOXgwVzRnWHVMNmk0TXFKbkdUcE13YmhsYnljekZjblByREhNWWhKbTY2?=
 =?utf-8?B?a08ydWRWOW5UditoZDIvekZGTDNXUFVmaXB0dkN5bjlFVXNVaHQzdi9iMmE5?=
 =?utf-8?B?QS82WDBKZUdKaVYxS3owMUVpVmRUVmxEVWRoeHNSNHVsM3lZdnZScURHK0xs?=
 =?utf-8?B?Y1ZXditSZDMzQlpLcHlyZkM1SWZDNVp1MzZXNjdwN0xBR3lqTmllUFJqY3hF?=
 =?utf-8?B?S29GVFQ4T0tGM3V3ZFJ6TlgrckhBU3ozNEtJM2ovTm5heUt5ZndFbERWRU0v?=
 =?utf-8?B?Z3RBSnpLV1lzU24wa3F2djZjOWpKVHZhdklmVE9DVDhKNThWOVZOVm84RWR3?=
 =?utf-8?B?SGtway9ZNHpETnZZUzBQa2VaYjlwajAxakZxRFRJeEtOZmpRQVRzaFdOK3pI?=
 =?utf-8?B?RTJwRlNKMHY0QkFVblhkMUYzQ2M3em81QzRTV2NRYzNzRFFjSXk2Q014TDhi?=
 =?utf-8?B?TFZydGJKK2h2Y0JVRDBvYktpM0lERDF4aUY1Sm1EUjAvZCs5MWRqbHlSQXho?=
 =?utf-8?B?Wmp3MVQzZXlkMkk4Ty9xOE5KM2lna0cwMDh0Yk9zZDhFcGRFSWRCb2dzT3pl?=
 =?utf-8?B?NUFzTy9oMHFnYS9tMWJVbjBmaDlmVldmcWdNbmJOa2VEcndZNllMZTdnZXdy?=
 =?utf-8?B?SkowajVHSExucmR6ZG1MeVI0ajhvZ29OOFFRZ3V0TmlHZ210SXVZcWpDNW11?=
 =?utf-8?B?RnZRaytadzU3YlIvVUJNcm5QRWxKTWVYcG4rMGZ5a2h3L04weUlaTnA0VXYy?=
 =?utf-8?B?U2lBWHhJd3ZuNURqQVdOSGVSZFloK3M1THdxSll0cGNkWjdIaXR1VDNiWDJk?=
 =?utf-8?B?eWN1VGsrM3hYdnRHd3JINzZySlh1eVJwNlFybUZGSUtDZU5mT2Z4bGxWQllr?=
 =?utf-8?B?ZkdBZmJPcjVBbGhpeTIzYU1iMzhpVFBNbW5la1p2MlNXbGg4djhWV1NPMWI1?=
 =?utf-8?B?YTJLNklhSjNYaDlDam5NWUJrY0RoQlRCVFoyd3pQMjMyRVFvY0gyMjJyR0VE?=
 =?utf-8?B?NHkydWNqQlNrUGI0Ri9STjlXTkwyWHRCb3A4M1dYYmZYMkIrckpWcUgvLzFw?=
 =?utf-8?B?aUlZUFM2Y002Rnoyd3RmREI1alUvTUZFZkYya3JBK2tvZmdUbDV1Z05YM1RK?=
 =?utf-8?B?T1lnMHljV3hpRVNhbStNWXlGT08zVjBxWnJuMWVLWE1GaENNck9IM0QydDhN?=
 =?utf-8?B?SS8vRXRsY09MVmlCKzNVZlJZNGg0cHpsaHY0TGJlYjltT01VRDRvNzkrSWNG?=
 =?utf-8?B?b1h4SUNQVzU2ZXVCYnZwbmdwMEhDTm8xU3pmcEp1emNEdExSMmExM3g3ZUFy?=
 =?utf-8?B?TGxLMFZzUGs3SnFxUkZwR25nMDQ2OXRnRVJHdWVXbE43NS85VjBYVk1IL3Ev?=
 =?utf-8?B?d1cxbTVyVHNPNTZuUnhsM2VYaVVlRzVOUWVSMTdMUmY5WDFyL0w4WlRPMHVO?=
 =?utf-8?B?M0trb0xtZElTNmx6Z3Vsbkc0VEJmL1RmcXJBeCtoaGtyVTVhTGVyS1ZUejVi?=
 =?utf-8?B?Vm1kTEh4Y3psQmsvdVZNN0szUG50c2dKTm54dHRSLzEreHVDK0gzcWhackRn?=
 =?utf-8?B?cW1wT0VDd3VBVTQwdTJtMUNYanhCS1daN1NFbFdwMUdkUHcrQmlzT3RIRGZU?=
 =?utf-8?B?RklRM3p6VTNUOC9tbWVwemJNdzM5YWxCV2FHN0l5L2U5dnNzaGIvNmdpT0VV?=
 =?utf-8?B?K1dWeUJUZVRIRjYwdG91a3MzY2d1Rmw0N1JHZlQxR2hwR0dwTjhtUkZKWkdW?=
 =?utf-8?B?RVZSYXJtMlM0a2JDL1hQbGcvaUp0QXRnY2dEWmxHd1NtZGJ4eC80eWtUQ1Jp?=
 =?utf-8?B?cG5NOS82bXpvQy92Rkh0STN3VmlWdUlPalErSTBKL1VxZ29MZXJyUVQ2dktK?=
 =?utf-8?B?N1JMV092N24zL0QzRkZBb0h5WWVpVndIdDV1UTErRUNxRkVod3VnMmlmSG5Q?=
 =?utf-8?B?Y2M0VnZNSGM4L21ZL2l1VWl1UHM2dFVUY0tKSFpZbC9uNWh6S0c5K2dlWmtl?=
 =?utf-8?B?blBuRXpuSndDU25nNjZlOTlNUG54eXQxWUF3SStSaFp1Snk2RzlycWsySHdh?=
 =?utf-8?B?bTZJYUpaSUpldHVPcnV6QzlGdmcwYXFBY3ZMbEJPRDZaNU1Nc0lEOEdPYmhz?=
 =?utf-8?B?RWNhdGNkQnpsaHZhU0hiY0NoMXpJQlRTd0RtU3dEWWpZSUQrUENOLzBLVDBX?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a9370c-0f58-4279-6d25-08dd51c7e2f1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 16:01:50.6179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wePIg7K2BGypuJVXJvSyXHFZe+dDtsfl5b7A3w6u1aRplRbkNDOug8H7VJoWFa1HN4RFhoxm6+6ANLLRVw1GFXZJCh42qWEWfjVdc2vNvb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8579
X-OriginatorOrg: intel.com

Hi Catalin,

On 2/20/25 2:58 AM, Catalin Marinas wrote:
> On Wed, Feb 19, 2025 at 03:24:06PM -0800, Reinette Chatre wrote:
>> On 2/7/25 10:17 AM, James Morse wrote:
>>> rdt_find_domain() finds a domain given a resource and a cache-id.
>>> This is used by both the architecture code and the filesystem code.
>>>
>>> After the filesystem code moves to live in /fs/, this helper will no
>>> longer be visible.
>>>
>>> Move it to the global header file. As its now globally visible, and
>>> has only a handful of callers, swap the 'rdt' for 'resctrl'.
> [...]
>>> --- a/include/linux/resctrl.h
>>> +++ b/include/linux/resctrl.h
>>> @@ -372,6 +372,40 @@ static inline void resctrl_arch_rmid_read_context_check(void)
>>>  		might_sleep();
>>>  }
>>>  
>>> +/**
>>> + * resctrl_find_domain() - Search for a domain id in a resource domain list.
>>> + * @h:		The domain list to search.
>>> + * @id:		The domain id to search for.
>>> + * @pos:	A pointer to position in the list id should be inserted.
>>> + *
>>> + * Search the domain list to find the domain id. If the domain id is
>>> + * found, return the domain. NULL otherwise.  If the domain id is not
>>> + * found (and NULL returned) then the first domain with id bigger than
>>> + * the input id can be returned to the caller via @pos.
>>> + */
>>> +static inline struct rdt_domain_hdr *resctrl_find_domain(struct list_head *h,
>>> +							 int id,
>>> +							 struct list_head **pos)
>>
>> Could you please provide a motivation for why this needs to be inline now?
> 
> It's in a header now, to avoid the compiler complaining about unused
> static functions wherever this file is included. The alternative is a
> prototype declaration and the actual implementation in a .c file.

resctrl_find_domain() is currently in a .c file (arch/x86/kernel/cpu/resctrl/core.c)
with a prototype declaration (in arch/x86/kernel/cpu/resctrl/internal.h). This patch
switches resctrl_find_domain() to be inline without a motivation.

After a fresh reading of "The inline disease" in Documentation/process/coding-style.rst 
I do see a few red flags related to making this function inline. The function is certainly
larger than the rule of thumb of "3 lines" and considering the number of call sites I do
not see how bloating the kernel is justified.

> 
> (drive-by comment, I don't really understand this subsystem to make a
> meaningful contribution)
> 

Thanks for taking a look. The idea is not unique to resctrl.

Reinette

