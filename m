Return-Path: <linux-kernel+bounces-337728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B64C984E0B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD462857F6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D44176242;
	Tue, 24 Sep 2024 22:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kLldV6W2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3004117A938
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 22:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727217924; cv=fail; b=d/UmrfcUOSh7ciGDtGmhaCG6ihYpMGySWae8cfrR8p65b9n1WHvgBX+rW/MjWFKi3xbO83QjZcMGYV4uWg8xcV+i/iXENha/fgI8KpqP9XC/ARPqtjWUsODvvjKnFcZQqmeRZJMv/C/NNaH3u098shXy34gZFuCosUwNd0Girp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727217924; c=relaxed/simple;
	bh=lPZZSlOOjdl+JIZT+kFJ+INjMHKH6TU3V2YJWpbPNBw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D3xULZpdpwFHEdu0r9cJ6Vow4ykNrzY4Goq2I9JZMMr1HGEWhCp+1FAldWWd/yTELMJ4dAi+vSl4fWbMo+tZLf/VrmUIeNQNz+AMlQOb0LpIisGdnVB3S/seLahErtwUNpLO2tN+Z9HfgnpVBuFz5AneJRB+DU51W8VKoSDXN20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kLldV6W2; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727217923; x=1758753923;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lPZZSlOOjdl+JIZT+kFJ+INjMHKH6TU3V2YJWpbPNBw=;
  b=kLldV6W2N7bprgFmSTgMaNJ6ofSYOvIkI/SeStof7ey0dLTPT4DEQfrn
   n5OK6V3kRvo15Df0P3bzFDh40dwVn7iB7GDJCHtJLI0vfknVjp7B2K2kM
   0j0eQh9/i8ZtJbeilqBUpTxL4m3NKNs6CUyLpy3VcMmyv0q5mOZvG3qWA
   74T8GS/I+EOEp4QJIZksgo/q9eEMXVgH3fd5PGywPSAATW4SC2dyWWSLg
   sSnJuWPmA+Q0oodHsdoeakGwIYm89F75tukbw0zVK7Yhv8BOU902T2Y5X
   6Hhw+Em/EgavntsD3XXo2toC0W/YrV3OEm1sIKOjmCDBS5YfTqpkJ/LR8
   w==;
X-CSE-ConnectionGUID: a8jqmgHqQbWJfxADD3LyRw==
X-CSE-MsgGUID: PJ2Bk+dlS52ZZPjz9a7+0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="37384289"
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="37384289"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 15:45:22 -0700
X-CSE-ConnectionGUID: dVOZ7+YDR6edaOhRil5qAw==
X-CSE-MsgGUID: zXfnAqe0Sj+WWH7j3uoa6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="102335259"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Sep 2024 15:45:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 15:45:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 15:45:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Sep 2024 15:45:20 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Sep 2024 15:45:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n0Hm0s0SRl91RDwwfeGpwzNUz2o78p5Ch6mc2B/maByN9/klQfdyJJJsn10rW7yU1n62xIqjuuJCDfyxbxw35h4eEOwcOTWHtXvHblKJtesLWvhophcF5spaNkOLM8kXr9cvnEMXXtTniSHV/UhpwRKShrUonQysOr+0oNOqpxh9e/K/dxxeBNWOJNOSmTW6ppoF8UcTaohASAgGcNmC56vRAO+w2rFSrDI/JXaFJ6XxEIGlQAAhEMJc5VFjDg3GfKaWVNjeCE3wrl6dwH0hixzpZ6vTZoCPPX8w2t/fPOPi2t/o6VRX1cJTNRNcHWHMLrjZXhisYD4Lbz7KDCajmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPZZSlOOjdl+JIZT+kFJ+INjMHKH6TU3V2YJWpbPNBw=;
 b=HretzfF7ci9q7B//EPV7OIB2ObC17dDahu4SXIuHvHEW01dnq8Z+3ivNSuI9o+qvc1LmAqUicwAs6gqh/JCPTIhJz5ITL5fEzbgE6ops+CNEKCKExrGze3AZNv0jCHA74yZKPD2z663Dwqp80DYsbSzOZHqDCd4oQIP5BvPeQuo75rXeqQubyTb9WNGVjr6t6z8P823F16MNlcONvhIuF8UNQrh6wftY+SeQ3LlZjKi0oay/gHTW8Y0iWdW1hVJTda/ITI5yH9KzGMOatk6YSotnAeK3my4Re2SmqWyNDw2DnKOrpXOCr+Ln93ltGoMprH0Rj7MmSx+aoKLF/XbjJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by PH7PR11MB5819.namprd11.prod.outlook.com (2603:10b6:510:13b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 22:45:18 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 22:45:17 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v7 5/8] mm: zswap: Compress and store a specific page in a
 folio.
Thread-Topic: [PATCH v7 5/8] mm: zswap: Compress and store a specific page in
 a folio.
Thread-Index: AQHbDh+BiNTld7AyzkaqOvKNL8+CcrJnU8CAgAAzUCA=
Date: Tue, 24 Sep 2024 22:45:17 +0000
Message-ID: <SJ0PR11MB567887AF292EC178BEF1CF43C9682@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-6-kanchana.p.sridhar@intel.com>
 <CAJD7tkacF3hCXiZHy7_+E7xmdojnsUewDeP=BsamcZReHxCTtg@mail.gmail.com>
In-Reply-To: <CAJD7tkacF3hCXiZHy7_+E7xmdojnsUewDeP=BsamcZReHxCTtg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|PH7PR11MB5819:EE_
x-ms-office365-filtering-correlation-id: b3144631-2ac8-44a9-def1-08dcdcea8ff1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cFJLb1k2d0dZeXlSNTVHcTRQcHg5a3p1d0VMQ285TVNmd3YwVjZqTUphUkYr?=
 =?utf-8?B?ZExuK3kxRko1eGdrM0x2ZGVpNHJPZjRiaDk5a0F4M2grbGFObXBYRk1iVU9k?=
 =?utf-8?B?cmFudHVTTE8xN2Zwa3lVbnliN0tBQ284Vm04MEE1ZTQzOEg0d0JVdlJuaXhJ?=
 =?utf-8?B?RHVrWjJPQUE2a2VmQW80Mzl0cG9CajRCS2VzZ0Z0ci8rTWI0b3VCUnZlWkFY?=
 =?utf-8?B?ZHk4SEJqTjJoSGxXMlZOOHNRVUVRaGV4QzRjTXlqNjlPOG0zRXBVTDlOSlVV?=
 =?utf-8?B?WXp5QmprTzdTNlZjOWlxbGd5K2hzRmEvZ2FaRlZlZDVzcTI0UXBYdmtRN0Ru?=
 =?utf-8?B?b1NXZjBGbnJSODhpZ3hneDlNbTJMY2M5bjEvNzREUTNTZUVnOUVQcHRobDUx?=
 =?utf-8?B?c2I4VEdTT3FLUi9ESFpkU1JwVjBPc0xhcFdEanFRNS9LejFSRDBidStVY0pX?=
 =?utf-8?B?RWZtL0pKYjQvR21XZzRjeDBzbEhDeWNVdjhsYXFrbEJod09FSy9JS1EwWHZO?=
 =?utf-8?B?Y3Zhd2d4SG1yUU5YQXdrc2lFdEoxc3JJdTJMeG04c2M2UHNLb0VHNEhMdU9P?=
 =?utf-8?B?d3VoU05JbVltT2R0NUh4OHpDS2toQ3NoY0RsY0lPOS9wZGYwdjlObHZmbFFm?=
 =?utf-8?B?cHpNZjJNM1NveHhTT3lUc0gwRFRpQ2RLbVZOOVdqR2ZqZlVTRWRYN2VIMWgw?=
 =?utf-8?B?SXZHNktMUEF0bjNSY1pWb0ZnNmZlcFkxWlpjcFRaQ2dDTkJvL1V5Z2VRVlJz?=
 =?utf-8?B?aWdVVXl1b1poV0R5cEVFZ1FJVGF2UzVVdDNHaWdtd0pJWkNXR2lObnRydTJn?=
 =?utf-8?B?SnYvSHBqMUlPOGdNcFMrb0d6aGFEcU1NTjNqK1NyU0FXaXRvdnhDN3N5UmlV?=
 =?utf-8?B?dlJiQmY2UE1WK0RScE9uRk82OVo4L2lpTjA0Y3poYWxKeS9mOTFFLzdrWWR2?=
 =?utf-8?B?R3k2ZUNtdUpHYzF6NmZmZERybDR3TlpKcm53ZzdKYXlMaDlncjdMbXUzQXF0?=
 =?utf-8?B?eG9ncXcwVEpmKzJQOFZMVlhCUDdTaXBjekl1R0ZnUHY1dUlQeHMrd256R1RW?=
 =?utf-8?B?VndDT3VVK0VsaTVIeW5sL3AvSFNvbkRXcXZmaG1uYS9ZYnlzYjlZVys3YU0w?=
 =?utf-8?B?QVVRblYrRDduMkJPVlhaaXR2eUFXY1dVeTYzN3BjcEpMZmR2cWo5TTN2RWJB?=
 =?utf-8?B?MUdxMC9JQXVaYmZzb1VXREE0eTVkRFdJeGRaLzFSdXMybGJOK21kaVFwVEhn?=
 =?utf-8?B?dURqQWhzcXBWVC96OXhLaFBta0d1UUJteUl0cXdPVDNRaTVweG5LYVpHWE94?=
 =?utf-8?B?WE5JN2pHMlZvUDR6L1loNlJraDMyeUp1eHBtdCtiYWZhMHlaRXplMWduemhs?=
 =?utf-8?B?aXBmUVBNeUN2TFpyMmZydm5MWDhqSlhSUjFFNTl4UkpaTWZLTWpZNXZCUjBk?=
 =?utf-8?B?cUl3ZzBrWWI4Wnp0a1Fnc1kvSHNwQ1BHYmk0L0RPS29FbzRic1d3OWhWU1pK?=
 =?utf-8?B?ZzRxTjlERzc5VzFwWElTb3NSdzMvT2dyMkw5V3RpMGd3eGRGNkNiL25SRWtr?=
 =?utf-8?B?UGNZZzJBYWVLSWZhbXBGTGtXenlBZ1dqVEdZRHEvVm1uQlpSNzRmcFl6YUxJ?=
 =?utf-8?B?RDMyakNDZm9JR2ZSckNHd05YbVl6SnZkd2VDNXV6WDI4Ym9pdkJ0WjJndWlq?=
 =?utf-8?B?RDJ3QXBaVTdNV2ozNnQ0cUFWS2FnRWxiMUZOMG1pcWg0ejJYSjE5NzdRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzMwV1hNYXFKaEVhK0RRUEFuL2llUzY3UXp0cTBYblJpdGNNVWNqTXY5dS9q?=
 =?utf-8?B?bXR6blhzc25iZ0VwUFhXbWpyRDl0ZEdrNEt2bXRXQzByUGY0YjYvVmw2U3FD?=
 =?utf-8?B?Tm1KOXhUTFJkWXA4emI0Z2EwTUdXQzhBejVYSU80WEdOeU9HZ0g3azhza0wx?=
 =?utf-8?B?M3VzcVFkVEdBWjV5UjdTNGcvVEJxRzRONTZQUW03eko1VTBoNEk0c1N5K0hv?=
 =?utf-8?B?OXhLR2liUUFjNGdmcVJhalpvQnhKOHpKbWdMWnRlek5TTnNCUlB3Qk9YQ1Ba?=
 =?utf-8?B?Y040VjZHOHhwcXdDT1NTTTdLNml0b2hOR1BBRVJWWVMwbTlJNzVxSkZpQ0ZR?=
 =?utf-8?B?alN3dnB1ZGUweGcyU21xZVFueGU4T1NCVjRtSXVhMHNsY3hCZldxbzduczR0?=
 =?utf-8?B?Y3RLT2Z6elI5VHZBUFlxM29nL0RpSWlnejZ4T3ZOejNaQ2V1V1VobkhNYzh1?=
 =?utf-8?B?azVxK1k4VXVnSGwwMXdRZUQvNmtmNGVmSHNWc3Q5WldoZjJjYnhGOUVEWkZQ?=
 =?utf-8?B?ajQ2SHF3aS8rYTBVckxvVTlpck9mZnp0bjlFSEdvbXE2V3RVb0pVUVRNSjU0?=
 =?utf-8?B?ajZFNHVpZjhrSjlyL09ZSnEzZUlSK2tnNXRBZEQ2U2N4VmFucUQvUGFVWnov?=
 =?utf-8?B?VllEY0dVU2xWYnRnTmkxbi9yYVl6MGFVR2ZoRi8zZ1VURHdRYUlLOXN1MEpL?=
 =?utf-8?B?bXcycmtXYllSVUJtUmVOWnMxQ3F0VldpY3ZCc1E3L3djZG9lU21lMlVDN3d5?=
 =?utf-8?B?Qmdkbmxqejh1NWRnbSt4WElFaDlta0J4cGdUWkJuNU8wWi9TaklxVTdNc0hL?=
 =?utf-8?B?QUprUWRWY2Fod3I0VmFzMFVHSDhNb0pURytDK0xvREtRMW8xdFFycG9uVWRw?=
 =?utf-8?B?VmVES1BlazlrTnFkU2F5ellweGUwL3MwUjVhZmRXZloyb3pla1YxUVQ5RmFS?=
 =?utf-8?B?TG1jNnBlMnprVkFOcm96Wkk0THlNbjJKdk0rTXBFVnI0ZmJibG5aYnc4VzQ3?=
 =?utf-8?B?dUE0R2ZmWXUrVUYySzNrTURxSHFhR1JZeWJuNTF1Uy82ZSthSFF6ZW9mT3NH?=
 =?utf-8?B?YTF1V0R3UTFDVmduWEhOSXlkeDlUMnAyYWw2eGRKTjh6TDh3YWdnUjhQdzlz?=
 =?utf-8?B?bnVkUGI2MU1nemdINFlmQUtKeXk2eDZONjVMRHg5d3pMdDZJbDVnbjhGZlVt?=
 =?utf-8?B?ZVlSenRaQ0RWa3V3Rmw3QnpYWlNRWTU4dUF6NUpveHl0MldESzlaZjJQSFpo?=
 =?utf-8?B?MFE1cHo0eXhpYm5yalk0REh0aUw3ZDRYeG9XM0Q3cUh4Zml5QVBQZnNJYXE2?=
 =?utf-8?B?eWNHK0JqQXp4cmtPeUc5TGpPdlZmMW0zTVFIdFFkMGJ5cTlpc29yRjMzbWdv?=
 =?utf-8?B?M21GOXpNem5vazRmb3J4aHBMUUx4TkErZ0JjVDk0YmkxUE9lM2tYYjlHQkty?=
 =?utf-8?B?b2lud0d0S1RHaDlJb1dBVVRhb1dDUVpPR0ZyRnUzV1NKQmk1eUdCVU9Tb3ZP?=
 =?utf-8?B?M0hhNEswZnorem1hU1VXOCttSzFVb3gzVXYzM3J1eS9Yb0ZxTE1LU2dhelFT?=
 =?utf-8?B?RlEwNk1EWHluZUx1enM4cWcwVnRMcGJJN3hHdnBSdW1yRmlxTHpUVWo0elFn?=
 =?utf-8?B?MitrNjhRbHdkV1plM0NLV1orR2xUWjIzUTRxRW5lK24rUFRPa2puL0ZNdVpv?=
 =?utf-8?B?K3diK2FOSXc2M211VEpmZWYwYVZKTmRBR3hnUzA3OFBnbUVuT0JKbCtnV2Rr?=
 =?utf-8?B?SCtTb2hBV3ppdUl0cVJDOEJzQzF6ZnZmc2VzTm9abHNxQjRSQWVHOC83dnlW?=
 =?utf-8?B?LzhQTjRZQnJHZHNHOVBobS9yOHoxdUhMaFBKbzFRb2E3SnpXRUlZRFVyZHly?=
 =?utf-8?B?MUlwckhzTmVmWnY0UWkwSkhOTHJvL1NFY2F1T1E5dlhKR0g3eUpxR3B3engw?=
 =?utf-8?B?Mlc5Nm1WRFFyWGdzUCtWOCtIeXVKYjdJaXdDaDAwdEhqdTVkVksxRmNHL3Bo?=
 =?utf-8?B?SHE5Ulo5MVlIa1AxMTErN2xHVWI2U2ZqZTBIR05IWXBFUHZiNEx2a04wRDRj?=
 =?utf-8?B?L0hxZkdkdDhyQktDV0pKU2JWOUxFZEN0TGtTd0xEOGRyZTQxQy9zdFBsblJT?=
 =?utf-8?B?U0RoN0ZQekFSRDhqMGFOTWhKUlJIR0FjanlJWXNwN0J2dG0xOHhBVzJNTWZ4?=
 =?utf-8?B?SGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5678.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3144631-2ac8-44a9-def1-08dcdcea8ff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 22:45:17.4778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KTxK2tBpvlAW8C1SkXY+uXkdevpSauo7yiMUPD0DpA1fvsJk7obcXANo7G8Ug8GtG2oagUeUKlU/g1f/2pOdqSEnkO+bnftfC5lIBblW8BQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5819
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZb3NyeSBBaG1lZCA8eW9zcnlh
aG1lZEBnb29nbGUuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMjQsIDIwMjQgMTI6
MjkgUE0NCj4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRl
bC5jb20+DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFj
ay5vcmc7DQo+IGhhbm5lc0BjbXB4Y2hnLm9yZzsgbnBoYW1jc0BnbWFpbC5jb207IGNoZW5nbWlu
Zy56aG91QGxpbnV4LmRldjsNCj4gdXNhbWFhcmlmNjQyQGdtYWlsLmNvbTsgc2hha2VlbC5idXR0
QGxpbnV4LmRldjsgcnlhbi5yb2JlcnRzQGFybS5jb207DQo+IEh1YW5nLCBZaW5nIDx5aW5nLmh1
YW5nQGludGVsLmNvbT47IDIxY25iYW9AZ21haWwuY29tOyBha3BtQGxpbnV4LQ0KPiBmb3VuZGF0
aW9uLm9yZzsgWm91LCBOYW5oYWkgPG5hbmhhaS56b3VAaW50ZWwuY29tPjsgRmVnaGFsaSwgV2Fq
ZGkgSw0KPiA8d2FqZGkuay5mZWdoYWxpQGludGVsLmNvbT47IEdvcGFsLCBWaW5vZGggPHZpbm9k
aC5nb3BhbEBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgNS84XSBtbTogenN3
YXA6IENvbXByZXNzIGFuZCBzdG9yZSBhIHNwZWNpZmljIHBhZ2UNCj4gaW4gYSBmb2xpby4NCj4g
DQo+IE9uIE1vbiwgU2VwIDIzLCAyMDI0IGF0IDY6MTfigK9QTSBLYW5jaGFuYSBQIFNyaWRoYXIN
Cj4gPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRm9yIHpz
d2FwX3N0b3JlKCkgdG8gaGFuZGxlIG1USFAgZm9saW9zLCB3ZSBuZWVkIHRvIGl0ZXJhdGUgdGhy
b3VnaCBlYWNoDQo+ID4gcGFnZSBpbiB0aGUgbVRIUCwgY29tcHJlc3MgaXQgYW5kIHN0b3JlIGl0
IGluIHRoZSB6c3dhcCBwb29sLiBUaGlzIHBhdGNoDQo+ID4gaW50cm9kdWNlcyBhbiBhdXhpbGlh
cnkgZnVuY3Rpb24genN3YXBfc3RvcmVfcGFnZSgpIHRoYXQgcHJvdmlkZXMgdGhpcw0KPiA+IGZ1
bmN0aW9uYWxpdHkuDQo+ID4NCj4gPiBUaGUgZnVuY3Rpb24gc2lnbmF0dXJlIHJlZmxlY3RzIHRo
ZSBkZXNpZ24gaW50ZW50LCBuYW1lbHksIGZvciBpdA0KPiA+IHRvIGJlIGludm9rZWQgYnkgenN3
YXBfc3RvcmUoKSBwZXItcGFnZSBpbiBhbiBtVEhQLiBIZW5jZSwgdGhlIGZvbGlvJ3MNCj4gPiBv
YmpjZyBhbmQgdGhlIHpzd2FwX3Bvb2wgdG8gdXNlIGFyZSBpbnB1dCBwYXJhbWV0ZXJzIGZvciBz
YWtlIG9mDQo+ID4gZWZmaWNpZW5jeSBhbmQgY29uc2lzdGVuY3kuDQo+ID4NCj4gPiBUaGUgZnVu
Y3Rpb25hbGl0eSBpbiB6c3dhcF9zdG9yZV9wYWdlKCkgaXMgcmV1c2VkIGFuZCBhZGFwdGVkIGZy
b20NCj4gPiBSeWFuIFJvYmVydHMnIFJGQyBwYXRjaCBbMV06DQo+ID4NCj4gPiAgICJbUkZDLHYx
XSBtbTogenN3YXA6IFN0b3JlIGxhcmdlIGZvbGlvcyB3aXRob3V0IHNwbGl0dGluZyINCj4gPg0K
PiA+ICAgWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW1tLzIwMjMxMDE5MTEwNTQz
LjMyODQ2NTQtMS0NCj4gcnlhbi5yb2JlcnRzQGFybS5jb20vVC8jdQ0KPiA+DQo+ID4gQ28tZGV2
ZWxvcGVkLWJ5OiBSeWFuIFJvYmVydHMNCj4gPiBTaWduZWQtb2ZmLWJ5Og0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEthbmNoYW5hIFAgU3JpZGhhciA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgbW0venN3YXAuYyB8IDg4DQo+ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgODgg
aW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL21tL3pzd2FwLmMgYi9tbS96c3dh
cC5jDQo+ID4gaW5kZXggOWJlYTk0OGQ2NTNlLi44ZjJlMGFiMzRjODQgMTAwNjQ0DQo+ID4gLS0t
IGEvbW0venN3YXAuYw0KPiA+ICsrKyBiL21tL3pzd2FwLmMNCj4gPiBAQCAtMTQ2Myw2ICsxNDYz
LDk0IEBAIHN0YXRpYyB2b2lkIHpzd2FwX2RlbGV0ZV9zdG9yZWRfb2Zmc2V0cyhzdHJ1Y3QNCj4g
eGFycmF5ICp0cmVlLA0KPiA+ICAgICAgICAgfQ0KPiA+ICB9DQo+ID4NCj4gPiArLyoNCj4gPiAr
ICogU3RvcmVzIHRoZSBwYWdlIGF0IHNwZWNpZmllZCAiaW5kZXgiIGluIGEgZm9saW8uDQo+ID4g
KyAqDQo+ID4gKyAqIEBmb2xpbzogVGhlIGZvbGlvIHRvIHN0b3JlIGluIHpzd2FwLg0KPiA+ICsg
KiBAaW5kZXg6IEluZGV4IGludG8gdGhlIHBhZ2UgaW4gdGhlIGZvbGlvIHRoYXQgdGhpcyBmdW5j
dGlvbiB3aWxsIHN0b3JlLg0KPiA+ICsgKiBAb2JqY2c6IFRoZSBmb2xpbydzIG9iamNnLg0KPiA+
ICsgKiBAcG9vbDogIFRoZSB6c3dhcF9wb29sIHRvIHN0b3JlIHRoZSBjb21wcmVzc2VkIGRhdGEg
Zm9yIHRoZSBwYWdlLg0KPiA+ICsgKi8NCj4gPiArc3RhdGljIGJvb2wgX19tYXliZV91bnVzZWQg
enN3YXBfc3RvcmVfcGFnZShzdHJ1Y3QgZm9saW8gKmZvbGlvLCBsb25nDQo+IGluZGV4LA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IG9ial9j
Z3JvdXAgKm9iamNnLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc3RydWN0IHpzd2FwX3Bvb2wgKnBvb2wpDQo+IA0KPiBXaHkgYXJlIHdlIGFkZGluZyBh
biB1bnVzZWQgZnVuY3Rpb24gdGhhdCBkdXBsaWNhdGVzIGNvZGUgaW4NCj4genN3YXBfc3RvcmUo
KSwgdGhlbiB1c2luZyBpdCBpbiB0aGUgZm9sbG93aW5nIHBhdGNoPyBUaGlzIG1ha2VzIGl0DQo+
IGRpZmZpY3VsdCB0byBzZWUgdGhhdCB0aGUgZnVuY3Rpb24gZG9lcyB0aGUgc2FtZSB0aGluZy4g
VGhpcyBwYXRjaA0KPiBzaG91bGQgYmUgcmVmYWN0b3JpbmcgdGhlIHBlci1wYWdlIGNvZGUgb3V0
IG9mIHpzd2FwX3N0b3JlKCkgaW50bw0KPiB6c3dhcF9zdG9yZV9wYWdlKCksIGFuZCBkaXJlY3Rs
eSBjYWxsaW5nIHpzd2FwX3N0b3JlX3BhZ2UoKSBmcm9tDQo+IHpzd2FwX3N0b3JlKCkuDQoNClN1
cmUsIHRoYW5rcyBZb3NyeSBmb3IgdGhpcyBzdWdnZXN0aW9uLiBXaWxsIGZpeCBpbiB2OC4NCg0K
PiANCj4gPiArew0KPiA+ICsgICAgICAgc3dwX2VudHJ5X3Qgc3dwID0gZm9saW8tPnN3YXA7DQo+
ID4gKyAgICAgICBpbnQgdHlwZSA9IHN3cF90eXBlKHN3cCk7DQo+ID4gKyAgICAgICBwZ29mZl90
IG9mZnNldCA9IHN3cF9vZmZzZXQoc3dwKSArIGluZGV4Ow0KPiA+ICsgICAgICAgc3RydWN0IHBh
Z2UgKnBhZ2UgPSBmb2xpb19wYWdlKGZvbGlvLCBpbmRleCk7DQo+ID4gKyAgICAgICBzdHJ1Y3Qg
eGFycmF5ICp0cmVlID0gc3dhcF96c3dhcF90cmVlKHN3cCk7DQo+ID4gKyAgICAgICBzdHJ1Y3Qg
enN3YXBfZW50cnkgKmVudHJ5Ow0KPiA+ICsNCj4gPiArICAgICAgIGlmIChvYmpjZykNCj4gPiAr
ICAgICAgICAgICAgICAgb2JqX2Nncm91cF9nZXQob2JqY2cpOw0KPiA+ICsNCj4gPiArICAgICAg
IGlmICh6c3dhcF9jaGVja19saW1pdHMoKSkNCj4gPiArICAgICAgICAgICAgICAgZ290byByZWpl
Y3Q7DQo+ID4gKw0KPiA+ICsgICAgICAgLyogYWxsb2NhdGUgZW50cnkgKi8NCj4gPiArICAgICAg
IGVudHJ5ID0genN3YXBfZW50cnlfY2FjaGVfYWxsb2MoR0ZQX0tFUk5FTCwgZm9saW9fbmlkKGZv
bGlvKSk7DQo+ID4gKyAgICAgICBpZiAoIWVudHJ5KSB7DQo+ID4gKyAgICAgICAgICAgICAgIHpz
d2FwX3JlamVjdF9rbWVtY2FjaGVfZmFpbCsrOw0KPiA+ICsgICAgICAgICAgICAgICBnb3RvIHJl
amVjdDsNCj4gPiArICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICAvKiBpZiBlbnRyeSBpcyBz
dWNjZXNzZnVsbHkgYWRkZWQsIGl0IGtlZXBzIHRoZSByZWZlcmVuY2UgKi8NCj4gPiArICAgICAg
IGlmICghenN3YXBfcG9vbF9nZXQocG9vbCkpDQo+ID4gKyAgICAgICAgICAgICAgIGdvdG8gZnJl
ZXBhZ2U7DQo+IA0KPiBJIHRoaW5rIHdlIGNhbiBiYXRjaCB0aGlzIGZvciBhbGwgcGFnZXMgaW4g
enN3YXBfc3RvcmUoKSwgbWF5YmUgZmlyc3QNCj4gYWRkIHpzd2FwX3Bvb2xfZ2V0X21hbnkoKS4N
Cj4gDQo+IEkgYW0gYWxzbyB3b25kZXJpbmcgaWYgaXQgd291bGQgYmUgYmV0dGVyIHRvIGJhdGNo
IHRoZSBsaW1pdCBjaGVja2luZw0KPiBhbmQgYWxsb2NhdGluZyB0aGUgZW50cmllcywgdG8gZnJv
bnQgbG9hZCBhbnkgZmFpbHVyZXMgYmVmb3JlIHdlIHN0YXJ0DQo+IGNvbXByZXNzaW9uLiBOb3Qg
c3VyZSBpZiB0aGF0J3Mgb3ZlcmFsbCBiZXR0ZXIgdGhvdWdoLg0KPiANCj4gVG8gYmF0Y2ggYWxs
b2NhdGUgZW50cmllcyB3ZSB3aWxsIGhhdmUgdG8gYWxzbyBhbGxvY2F0ZSBhbiBhcnJheSB0bw0K
PiBob2xkIHRoZW0uIFRvIGJhdGNoIHRoZSBsaW1pdCBjaGVja2luZyB3ZSB3aWxsIGhhdmUgdG8g
ZWl0aGVyIGFsbG93DQo+IGdvaW5nIGZ1cnRoZXIgb3ZlciBsaW1pdCBmb3IgbVRIUHMsIG9yIGNo
ZWNrIGlmIHRoZXJlIGlzIGVub3VnaA0KPiBjbGVhcmFuY2UgdG8gYWxsb3cgZm9yIGNvbXByZXNz
aW5nIGFsbCB0aGUgcGFnZXMuIFVzaW5nIHRoZQ0KPiB1bmNvbXByZXNzZWQgc2l6ZSB3aWxsIGxl
YWQgdG8gZmFsc2UgbmVnYXRpdmVzIHRob3VnaCwgc28gbWF5YmUgd2UgY2FuDQo+IHN0YXJ0IHRy
YWNraW5nIHRoZSBhdmVyYWdlIGNvbXByZXNzaW9uIHJhdGlvIGZvciBiZXR0ZXIgbGltaXQNCj4g
Y2hlY2tpbmcuDQo+IA0KPiBOaGF0LCBKb2hhbm5lcywgYW55IHRob3VnaHRzIGhlcmU/IEkgbmVl
ZCBzb21lb25lIHRvIHRlbGwgbWUgaWYgSSBhbQ0KPiBvdmVydGhpbmtpbmcgdGhpcyA6KQ0KDQpU
aGVzZSBhcmUgYWxsIGdvb2QgcG9pbnRzLiBJIHN1cHBvc2UgSSB3YXMgdGhpbmtpbmcgYWxvbmcg
dGhlIHNhbWUgbGluZXMNCm9mIHdoYXQgTmhhdCBtZW50aW9uZWQgaW4gYW4gZWFybGllciBjb21t
ZW50LiBJIHdhcyB0cnlpbmcgdGhlDQppbmNyZW1lbnRhbCB6c3dhcF9wb29sX2dldCgpIGFuZCBs
aW1pdCBjaGVja3MgYW5kIHNocmlua2VyIGludm9jYXRpb25zDQppbiBjYXNlIG9mIChhbGwpIGVy
cm9yIGNvbmRpdGlvbnMgdG8gYWxsb3cgZGlmZmVyZW50IGNvbmN1cnJlbnQgc3RvcmVzIHRvIG1h
a2UNCnByb2dyZXNzLCB3aXRob3V0IGZhdm9yaW5nIG9ubHkgb25lIHByb2Nlc3MncyBtVEhQIHN0
b3JlLiBJIHdhcyB0aGlua2luZw0KdGhpcyB3b3VsZCBoYXZlIG1pbmltYWwgaW1wYWN0IG9uIHRo
ZSBwcm9jZXNzKGVzKSB0aGF0IHNlZSB0aGUgenN3YXANCmxpbWl0IGJlaW5nIGV4Y2VlZGVkLCBh
bmQgdGhhdCB0aGlzIHdvdWxkIGJlIGJldHRlciB0aGFuIHByZWVtcHRpdmVseQ0KY2hlY2tpbmcg
Zm9yIHRoZSBlbnRpcmUgbVRIUCBhbmQgZmFpbGluZyAodGhpcyBjb3VsZCBhbHNvIGNvbXBsaWNh
dGUgdGhpbmdzDQp3aGVyZSBubyBvbmUgbWFrZXMgcHJvZ3Jlc3MgYmVjYXVzZSBtdWx0aXBsZSBw
cm9jZXNzZXMgcnVuIHRoZSBiYXRjaA0KY2hlY2tzIGFuZCBmYWlsLCB3aGVuIHJlYWxpc3RpY2Fs
bHkgb25lL21hbnkgY291bGQgaGF2ZSB0cmlnZ2VyZWQNCnRoZSBzaHJpbmtlciBiZWZvcmUgZXJy
b3Jpbmcgb3V0LCBhbmQgYXQgbGVhc3Qgb25lIGNvdWxkIGhhdmUgbWFkZQ0KcHJvZ3Jlc3MpLg0K
DQpXb3VsZCBhcHByZWNpYXRlIHlvdXIgcGVyc3BlY3RpdmVzIG9uIGhvdyB0aGlzIHNob3VsZCBi
ZSBoYW5kbGVkLA0KYW5kIHdpbGwgaW1wbGVtZW50IGEgc29sdXRpb24gaW4gdjggYWNjb3JkaW5n
bHkuDQoNClRoYW5rcywNCkthbmNoYW5hDQoNCj4gDQo+ID4gKw0KPiA+ICsgICAgICAgZW50cnkt
PnBvb2wgPSBwb29sOw0KPiA+ICsNCj4gPiArICAgICAgIGlmICghenN3YXBfY29tcHJlc3MocGFn
ZSwgZW50cnkpKQ0KPiA+ICsgICAgICAgICAgICAgICBnb3RvIHB1dF9wb29sOw0KPiA+ICsNCj4g
PiArICAgICAgIGVudHJ5LT5zd3BlbnRyeSA9IHN3cF9lbnRyeSh0eXBlLCBvZmZzZXQpOw0KPiA+
ICsgICAgICAgZW50cnktPm9iamNnID0gb2JqY2c7DQo+ID4gKyAgICAgICBlbnRyeS0+cmVmZXJl
bmNlZCA9IHRydWU7DQo+ID4gKw0KPiA+ICsgICAgICAgaWYgKCF6c3dhcF9zdG9yZV9lbnRyeSh0
cmVlLCBlbnRyeSkpDQo+ID4gKyAgICAgICAgICAgICAgIGdvdG8gc3RvcmVfZmFpbGVkOw0KPiA+
ICsNCj4gPiArICAgICAgIGlmIChvYmpjZykgew0KPiA+ICsgICAgICAgICAgICAgICBvYmpfY2dy
b3VwX2NoYXJnZV96c3dhcChvYmpjZywgZW50cnktPmxlbmd0aCk7DQo+ID4gKyAgICAgICAgICAg
ICAgIGNvdW50X29iamNnX2V2ZW50KG9iamNnLCBaU1dQT1VUKTsNCj4gPiArICAgICAgIH0NCj4g
PiArDQo+ID4gKyAgICAgICAvKg0KPiA+ICsgICAgICAgICogV2UgZmluaXNoIGluaXRpYWxpemlu
ZyB0aGUgZW50cnkgd2hpbGUgaXQncyBhbHJlYWR5IGluIHhhcnJheS4NCj4gPiArICAgICAgICAq
IFRoaXMgaXMgc2FmZSBiZWNhdXNlOg0KPiA+ICsgICAgICAgICoNCj4gPiArICAgICAgICAqIDEu
IENvbmN1cnJlbnQgc3RvcmVzIGFuZCBpbnZhbGlkYXRpb25zIGFyZSBleGNsdWRlZCBieSBmb2xp
byBsb2NrLg0KPiA+ICsgICAgICAgICoNCj4gPiArICAgICAgICAqIDIuIFdyaXRlYmFjayBpcyBl
eGNsdWRlZCBieSB0aGUgZW50cnkgbm90IGJlaW5nIG9uIHRoZSBMUlUgeWV0Lg0KPiA+ICsgICAg
ICAgICogICAgVGhlIHB1Ymxpc2hpbmcgb3JkZXIgbWF0dGVycyB0byBwcmV2ZW50IHdyaXRlYmFj
ayBmcm9tIHNlZWluZw0KPiA+ICsgICAgICAgICogICAgYW4gaW5jb2hlcmVudCBlbnRyeS4NCj4g
PiArICAgICAgICAqLw0KPiA+ICsgICAgICAgaWYgKGVudHJ5LT5sZW5ndGgpIHsNCj4gPiArICAg
ICAgICAgICAgICAgSU5JVF9MSVNUX0hFQUQoJmVudHJ5LT5scnUpOw0KPiA+ICsgICAgICAgICAg
ICAgICB6c3dhcF9scnVfYWRkKCZ6c3dhcF9saXN0X2xydSwgZW50cnkpOw0KPiA+ICsgICAgICAg
fQ0KPiA+ICsNCj4gPiArICAgICAgIC8qIHVwZGF0ZSBzdGF0cyAqLw0KPiA+ICsgICAgICAgYXRv
bWljX2luYygmenN3YXBfc3RvcmVkX3BhZ2VzKTsNCj4gPiArICAgICAgIGNvdW50X3ZtX2V2ZW50
KFpTV1BPVVQpOw0KPiANCj4gV2Ugc2hvdWxkIHByb2JhYmx5IGFsc28gYmF0Y2ggdXBkYXRpbmcg
dGhlIHN0YXRzLiBJdCBhY3R1YWxseSBzZWVtcw0KPiBsaWtlIG5vdyB3ZSBkb24ndCBoYW5kbGUg
cm9sbGluZyB0aGVtIGJhY2sgdXBvbiBmYWlsdXJlLg0KDQpHb29kIHBvaW50ISBJIGFzc3VtZSB5
b3UgYXJlIHJlZmVycmluZyBvbmx5IHRvIHRoZSAiWlNXUE9VVCIgdm0gZXZlbnQgc3RhdHMNCnVw
ZGF0ZXMgYW5kIG5vdCB0aGUgInpzd2FwX3N0b3JlZF9wYWdlcyIgKHNpbmNlIGxhdHRlciBpcyB1
c2VkIGluIGxpbWl0IGNoZWNraW5nKT8NCg0KSSB3aWxsIGZpeCB0aGlzIGluIHY4Lg0KDQpUaGFu
a3MsDQpLYW5jaGFuYQ0KDQo+IA0KPiANCj4gPiArDQo+ID4gKyAgICAgICByZXR1cm4gdHJ1ZTsN
Cj4gPiArDQo+ID4gK3N0b3JlX2ZhaWxlZDoNCj4gPiArICAgICAgIHpwb29sX2ZyZWUoZW50cnkt
PnBvb2wtPnpwb29sLCBlbnRyeS0+aGFuZGxlKTsNCj4gPiArcHV0X3Bvb2w6DQo+ID4gKyAgICAg
ICB6c3dhcF9wb29sX3B1dChwb29sKTsNCj4gPiArZnJlZXBhZ2U6DQo+ID4gKyAgICAgICB6c3dh
cF9lbnRyeV9jYWNoZV9mcmVlKGVudHJ5KTsNCj4gPiArcmVqZWN0Og0KPiA+ICsgICAgICAgb2Jq
X2Nncm91cF9wdXQob2JqY2cpOw0KPiA+ICsgICAgICAgaWYgKHpzd2FwX3Bvb2xfcmVhY2hlZF9m
dWxsKQ0KPiA+ICsgICAgICAgICAgICAgICBxdWV1ZV93b3JrKHNocmlua193cSwgJnpzd2FwX3No
cmlua193b3JrKTsNCj4gPiArDQo+ID4gKyAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4gK30NCj4g
PiArDQo+ID4gIGJvb2wgenN3YXBfc3RvcmUoc3RydWN0IGZvbGlvICpmb2xpbykNCj4gPiAgew0K
PiA+ICAgICAgICAgbG9uZyBucl9wYWdlcyA9IGZvbGlvX25yX3BhZ2VzKGZvbGlvKTsNCj4gPiAt
LQ0KPiA+IDIuMjcuMA0KPiA+DQo=

