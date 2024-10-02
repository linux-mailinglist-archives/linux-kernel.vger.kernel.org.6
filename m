Return-Path: <linux-kernel+bounces-348334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D3898E60F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 00:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCB951C23DBB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7982119924A;
	Wed,  2 Oct 2024 22:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ObJ12WzB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FA78F40
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 22:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727907800; cv=fail; b=sAX2hkFid39nRtdjC5kpwNsC4h2lRoJFoopB1KY9EIARPFozEm/NaIKL54VFny1xW6yURQ5b1/YLH6LEySL7SOWe1z0/Dq3+ZyQwzuuKFeYYR4BKZtnkq7lHoSOUgxjsH+XninKlu+AhlG9CXctciDH3AAxPz8Wqh8lJyUO0JdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727907800; c=relaxed/simple;
	bh=g2VfsBaCjX9g7MRh/SEt4nhwGg037VDfU6ZTz03lYms=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l1vtopD/aNtlOeQ/+m3bewlVH+zJjiwGpBj620c5fP3ai2/ipvHvJyWSxdXeVTNbsK782/pUInZrD8wf25e3+Vl7rNvy4bhQWnpqsdz4iCLILGkOnWcMrTG6npThgRSXw4psVaqWWDWcjIODfrc5kWkvudjAuhQt28dJLuQZDdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ObJ12WzB; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727907797; x=1759443797;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g2VfsBaCjX9g7MRh/SEt4nhwGg037VDfU6ZTz03lYms=;
  b=ObJ12WzBNIbKdEd/stb3Gh2ePq5oqqvFXZ4dgXAM87rZHXfzV4twmSCb
   VYyIqfbMMMPrJyR9p2VzcCud/8BDiH467e3s5kLNlEflcpefHPqHdC+CA
   IlUkjFENel3GbP9PwLmRYvU2y5cfwIgjvmS8iBkVV8fsf+baBfqtJqWmp
   8DiJlHXvbhYVQLgMpWRo79ohrRBiw72YaWmcLuKNb943W8Dg9ziz9kEaY
   avgyzSGpxckNLQ5wg6IpIx7jTN9GjoQmfVCoWPnVuReqgFYtZdXPnUZ9+
   7YwLJ4ZE2vQjLXVmwDuyUhpNuq94BFNxYxL/8+bXxIJJk94Eop8fvc2Ib
   A==;
X-CSE-ConnectionGUID: B+/MLa8xSnWtCTnCe3jeBw==
X-CSE-MsgGUID: 45RRQuBBSBSpSNWxELEF9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="14709903"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="14709903"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 15:23:17 -0700
X-CSE-ConnectionGUID: n9A/T6VMSC+7XBe7Gn/fBg==
X-CSE-MsgGUID: /KsN3Z0HQDaTmeGRRDXLfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="78684130"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2024 15:23:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 15:23:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 2 Oct 2024 15:23:15 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 2 Oct 2024 15:23:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMOSK7y1lMt7kIQElnhZY2U6dWQXGw4NV1iNyN7bXG2KX+z7UVtB3YSTtEeCVrRAJ+rK28ykdAoyPTjoJ5fjwpXbhjFXOuO2LR3aHkvNuxCUEC8fbl4kvuJYepjB/kY574k+5A/XESAzRn9gsjEm7Fr3y5A0DAJrkO85KrbQbXaRthyS2q62vankhrFTBPaOVPXIWWEv2u+PKnumjoFvdwr21RS5Az0QKnRmuTQH5TrNZsuQDww5s0gZopO6m1KwFchXKHifY4qSsfZIugzcWiOWPNQvzB9Pq4ZodsnRXbA2WR/yQVrn49e/2kz85WysafbFHHI5mG0XX6wG+0RY5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZ3r1xN3aRKurEhWIs1SmSHQuZeyRPQxcEd6vy3Fscg=;
 b=aAtAMf9HKj+PQW1Fe7m+XxnlOcl6xhlKAjQNkY7Z2MbTOCm8ZxmKfuuQuGTg9DEp8MI/38DKCmpLWYLrH+8h1iB/AShWoNSTP8CTiVIn6Q/D+csdEzWLagkVDPL/MSpg08XnHJAVF+HZnAPT0gSlm8vzleYqBX382adlg598zJumN7oSTQCUZK7aQxzY5XlmdhWUHHZ/ZiAA7gcU3+tSDpATPcxNwmY4BWVwYE+LFYztzSkJJqJUWj0gtxlqQBHjYnZylrhXnYAM0D/tR8ljrswXc+FFHnwL+zxnTBlRtMmO56XZIV42/jf5nGzrwceQmgc8yWo6/s+hA5N46en9Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by DM6PR11MB4513.namprd11.prod.outlook.com (2603:10b6:5:2a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 22:23:12 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 22:23:11 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>,
	"nphamcs@gmail.com" <nphamcs@gmail.com>, "chengming.zhou@linux.dev"
	<chengming.zhou@linux.dev>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal,
 Vinodh" <vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v2] mm: swap: Call count_mthp_stat() outside ifdef
 CONFIG_TRANSPARENT_HUGEPAGE.
Thread-Topic: [PATCH v2] mm: swap: Call count_mthp_stat() outside ifdef
 CONFIG_TRANSPARENT_HUGEPAGE.
Thread-Index: AQHbFQUd/oOHdET0XkqafTbffH43wLJz64kAgAAdNVA=
Date: Wed, 2 Oct 2024 22:23:11 +0000
Message-ID: <SJ0PR11MB567833DDA6E0383096EDEA3BC9702@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20241002195547.30617-1-kanchana.p.sridhar@intel.com>
 <20241002133642.9e9b82e53f2ff14f541d7864@linux-foundation.org>
In-Reply-To: <20241002133642.9e9b82e53f2ff14f541d7864@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|DM6PR11MB4513:EE_
x-ms-office365-filtering-correlation-id: 1d902a67-7719-4393-39dd-08dce330cd26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?LrXGMV8ryhqzRYmylMMi8MoHU+y1zcC5r6vKYdSUei/MXG2fLL7hBkX/s2WN?=
 =?us-ascii?Q?meZoQ9NoKafJzXC35Rt34kxLIwpfoY2WwGGcE01UG9poSB7DBcnPTzYnUSXw?=
 =?us-ascii?Q?3LMNmJol1Hvc+1DKhi6sVg//VFtBIdPXFpNf/w380457tHZV7QrKHBGy7OXz?=
 =?us-ascii?Q?gFSpMZrkiGVpMbYHUMsfWDNsKtRyxjgw7A9jiWoz8NAtTHVAcuErU4Bo7byk?=
 =?us-ascii?Q?qtSby5ZW4dqELGe/GsekmOKVQ9m0JK+wpYCCO725RIIFZTA+2FRV0/WQJh+y?=
 =?us-ascii?Q?JA0KeXsblC1T50zA0zZd9E2HdOPApeah8m6pgGEYGahmfkuzDopaZf5v3oFV?=
 =?us-ascii?Q?uRPUq4HzgGN8w13MY8J/f67A276dtzMJ0YEcQZcAFrcr32kWe1G+EXiyXTJM?=
 =?us-ascii?Q?v4VipUakMs1CBrqqwjoTCMWwTcLP193Q6SoCHMpd0UIiNh3D450zcRorkdFX?=
 =?us-ascii?Q?tDjgdHaFSWhEhlzQOsr3D3WO3Wl1op68CmlBSQTXIqxs2asR56hIGZ0NAWPP?=
 =?us-ascii?Q?kXxddTiNR+HTeajAbVxPf+IUttAw4TEaSyyOldZys3iigB80aKcUxdDq0MxR?=
 =?us-ascii?Q?dTxV3VXYZVcJJaHKF0scBM96ebaiUFrOKW84UHRG6Yq2om+hLYUW1KRxLELV?=
 =?us-ascii?Q?OQCJSPTD+9ruLkUJOywy9y8x8fIjZ8fRGxdP8TFebi6FlEWbrHLsxWIeXgcA?=
 =?us-ascii?Q?N2WJSLdw0PC49OWfIAGvxMyUuGBoJjuPfmUt/xf93flYM6dfqaX+F0REtX9s?=
 =?us-ascii?Q?jwf+WoY4YI6K06SkkdyXXsuiVnZk1xR5MPe8IIA1pTen7bRLQ/pynZLT58za?=
 =?us-ascii?Q?bUnaobKaqD4SoWam1sFL8eIXK/bCXOtpUdL4OG5L9Vg7VYbzrzHRxEBxskGl?=
 =?us-ascii?Q?uVznDzG3Aimm56LeFvWH4fg+M6TlocKAp7vhiFA2WRWmNeMWHyvtqsGtlDRD?=
 =?us-ascii?Q?W01ru1m0J20DoAg4ZxtA9ZzOJlA+DH7LJj27Sh3XbWn6TtDNmI6/A+xyu1Ek?=
 =?us-ascii?Q?uJQnvde59+UJMJlE6Pe2CGQucg3elLSP2861MgSK58V6gtDAKCvSu33xLAvq?=
 =?us-ascii?Q?NcT30RgWK1rBk7Uk/x9hWGeYKAN55WpmTa7hypwlegQe8OHdInUihFtYzukX?=
 =?us-ascii?Q?YPf0hzdCvSE4/STYGdMeffLWOzExETNhkkBLt2RALIYilYhRiB4/cfyDruOX?=
 =?us-ascii?Q?Vg3+HWx6FQDcDTnva33hDYRpdf3PwaxFPHwXgpB7HUz6ZkFy+zw9nIg0kRb2?=
 =?us-ascii?Q?7pyuE3V1f1COUI9v9qs602Or+6NpYlEekLQhA2s3963IMmV9PY22PIycLYAI?=
 =?us-ascii?Q?Ec5lSHfzS2OAQdolQDp8sSL2++VC2rfRB7q54F/odBu9Xg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RZ1XudlkC3+K5sZxwOUad5Y1hDaFaRK3vGSrCrs7p2bUt1dDYNMc2UdK/k4C?=
 =?us-ascii?Q?yHvzIBRwlqOGCj5GYp6sG9FjXZyJBEbL/0/M2uW/cE2gvmaeRn7OLNt1Ob9q?=
 =?us-ascii?Q?BNdKpdndl+S1gUOBhH3cKg5Bs85QqHqmMLi9ryrnx4LBhqBRBSxcBfs+5ryq?=
 =?us-ascii?Q?3TDNfgvhNVdJnMkITXSkXZ/cNDBZZkYPJdu1IqCpfjKGSf5Dv1vYjzVDFrJs?=
 =?us-ascii?Q?DsgzNeTJCS+Z5f1ghJTd9rrH76AKxIgRm9VoB0LahX1Aiu4tbJxtOs7onrUQ?=
 =?us-ascii?Q?OJFqrCqnz0iKv+01YMieTzWfee/c28OZ974sfYn5Rd9PZWBgowpJOe7v7rPg?=
 =?us-ascii?Q?LKtxf4GOaqMSz/co9I5ou2HAS/FbtTzcyySgk0lf+7DtTnLjnraSyDoguQl/?=
 =?us-ascii?Q?RWZzOqPqfsdDz0cFWvBpaQX8gTEu6tHF6o/RhafWoM+gLRi0scpwLBb6zR4K?=
 =?us-ascii?Q?8fowzYUx+p2J1B/l5HotevwMA7extOODVSI0cd/ETeSGuQf8cnoiONyghb7+?=
 =?us-ascii?Q?Ym7SLB1YUWg8xeC4hhVRGPh+HzXEc2G6W+qclUYY9ykfRlTQwuvmYSZ6A20b?=
 =?us-ascii?Q?EfciSuy7u6r9PiOESKqbQIL272k9aXRfySdFdcWbaPRZ/1OI3+hYHKMX86jw?=
 =?us-ascii?Q?dlzTYqbGX289mC4Yg1oyubXZr70qtoyKmME5wsWxKEIqnFvjOP/I7C7z76VJ?=
 =?us-ascii?Q?vKkBCgPAcjW1gyMPCgbe+JCD13wnKTxQPmHAzCbXcjqLzTOMfYcGccM/gPQH?=
 =?us-ascii?Q?LHDUQUBbMjsXsxQoLJutvTWiIzwnNvdRjok3KrH5EmbsvOLsjxcO77OubxDv?=
 =?us-ascii?Q?son1RIOaAsHzRrhNn9RwL9EvFhIfy42GJoU73NffTLoh0nz9jn38yqvB6NI8?=
 =?us-ascii?Q?ex/l1k8qu5SpWZBu/mxnSE2Q2vkMCYueOLX0YzQJXQmwdpdvSg5sfTF/DDpb?=
 =?us-ascii?Q?lvx0GVWX0mYAcvLAIIWpaogc4hWjU/wnmDaHBPJWnBYaskoKPf+UHhdym2QH?=
 =?us-ascii?Q?r6F0hg3IZSCYHG64QxOeZeU/agr/Gq4J2houM6iqkDSJo58S9cpxBcnOEi78?=
 =?us-ascii?Q?HfXKz+QcaQ+f7JlZxHX3AZYamxJyK+F9i3eS5BirMzKS6Jge93S6fULcf6Cb?=
 =?us-ascii?Q?0bjaq+GXuZY6zkWROiVpYFrgVkwtV7WhQbYpLvtoWSvMxn5/Oe+jF1jKx/X3?=
 =?us-ascii?Q?QECnd+v63k74AKGzhoJijoSdo8gzSmz/wu8pS5nlcbzNHnOPiJkjtQMuj6Hm?=
 =?us-ascii?Q?3UCT/BuDdYWL5SHSj7K9HZ7eSZIFLZEFVAUY53CS2De/AKwIpicxD3iNTZJj?=
 =?us-ascii?Q?2D1xye3CMydIemXNP34fk3lySq+EOsYPa2818ibFln383uBIhnafPnA26Qi9?=
 =?us-ascii?Q?83f1AkxibH+tG7diFNqpxjLXfBjgdeTHb9BCJ5/0+4WlhseIgMwN0b3R+PzI?=
 =?us-ascii?Q?niR5an448uVXYf1q96Zot/HbX9qpWIMKTgk+bSpn6rq09De0wSjBzV8uMmKQ?=
 =?us-ascii?Q?3ypH/q8SR7nabTGreWyuOOn6reMXbEZR21FfVWt2lXHbBIKR2D+sigVeReXL?=
 =?us-ascii?Q?cYNbkZtYp3kLs5Sv2uoGDUJViLtVVFJQYADBbc9Agv7wtsMyLN3rtkJTMe72?=
 =?us-ascii?Q?og=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5678.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d902a67-7719-4393-39dd-08dce330cd26
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2024 22:23:11.8931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8PP/OcsZMAWsZPuRRA3oh5Wo3VYNcE5+5mdsybzyUwLx6uj2PC2zy4zRXeNfpqmXE8t37ggfgX6mrsCZIkPVC0sZz7yVc2WzjsDQDu/ryM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4513
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Andrew Morton <akpm@linux-foundation.org>
> Sent: Wednesday, October 2, 2024 1:37 PM
> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> hannes@cmpxchg.org; yosryahmed@google.com; nphamcs@gmail.com;
> chengming.zhou@linux.dev; ryan.roberts@arm.com; Huang, Ying
> <ying.huang@intel.com>; 21cnbao@gmail.com; Feghali, Wajdi K
> <wajdi.k.feghali@intel.com>; Gopal, Vinodh <vinodh.gopal@intel.com>
> Subject: Re: [PATCH v2] mm: swap: Call count_mthp_stat() outside ifdef
> CONFIG_TRANSPARENT_HUGEPAGE.
>=20
> On Wed,  2 Oct 2024 12:55:47 -0700 Kanchana P Sridhar
> <kanchana.p.sridhar@intel.com> wrote:
>=20
> > This patch moves the call to count_mthp_stat() in
> count_swpout_vm_event()
> > and in shrink_folio_list() to be outside the
> > "ifdef CONFIG_TRANSPARENT_HUGEPAGE"
>=20
> This is very apparent from reading the patch.  Changelogs and code
> comments should explain "why", and avoid explaining "what".
>=20
> > based on changes made in commit
> > 246d3aa3e531 ("mm: cleanup count_mthp_stat() definition").
>=20
> And I don't think that explains the reasons for this change either.
>=20
> So please resend with a changelog which fully explains the reasons for
> making this alteration.

Thanks Andrew, for the comments. Sure, I will resend with these
suggestions incorporated!

Thanks,
Kanchana


