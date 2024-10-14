Return-Path: <linux-kernel+bounces-363412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5CB99C205
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCB751C222AA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E43E14B946;
	Mon, 14 Oct 2024 07:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AEEHqVxF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A46214A092
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892359; cv=fail; b=JnacCYDn7AUca3lcUGV9OGc0sAi4d6+eBSeh0NeAqHKXdM89heEBtxtDPEgA5eXQX2HmoVl+Yns4cocIG84s9mA3zW5+h31ygvOVovUpKNDwiZgsz+4N8+nJ1JnlcburCD+YKS/2XFJ1xUI96h1iqyQr/Y+Cykdu+l51CQjPQ3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892359; c=relaxed/simple;
	bh=yBg4u8JlG9rMdtoxaeS+R7hSGr+uOqe7lFUgn2/G7kE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hT7K3cOxw7v01BaP+pRiwKryQw6SeEq3hi/4aqbgyI14PprZpNRahyixPAPDWSDNgafz9auh16W7iTARYCBF28ILufR0VllmBs15RLLVj9aGZsYarKNkJKxSY9NIHYN1290W1ZMexYU8gk80rMtrJ1G5vh5HhGAz19MBP16G9O0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AEEHqVxF; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728892357; x=1760428357;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yBg4u8JlG9rMdtoxaeS+R7hSGr+uOqe7lFUgn2/G7kE=;
  b=AEEHqVxF9DbQ0kV81hYwc5+W1HOJVPFgqeoh/92ikAG/5CONlgvvu92F
   qX4ik+sntz31924MNj1e8qwM7GNNV6yenNIdlvBp+rbN1d14soq5TNCA5
   Ai7Nk+f8UbJYEK4nf3wmvElpxduBfGgRgVrq2bCcGB8IungHyA1VO+OP9
   gTn4gC3vK7JZtGwMp0hMs9xDlJ+pewuBp/HO0+F4BVOmJ84w09Ud+WmMr
   Ahyzuxl8cr9tOCVaPRKp6AGjUdrlKPRIR1DWAFuJMGn0h1QmOqdeWQQAR
   gebtOfeadIsjyZuvjmjCV5e3V210ZvLGTPFUGDfxAoC2hiF6HJ9hiqxVb
   w==;
X-CSE-ConnectionGUID: 9DA9fgASQ7mGdmT3NTfDQg==
X-CSE-MsgGUID: XhT5/FPNTm+Mrxd/9ifnFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="28112135"
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="28112135"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 00:52:36 -0700
X-CSE-ConnectionGUID: l3flFRs8TXiOCtSCxy6vvw==
X-CSE-MsgGUID: 5DjYl/ixR6O+0UBsvHqmnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="78323107"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Oct 2024 00:52:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 00:52:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Oct 2024 00:52:36 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 00:52:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gw9BRC/0OyrlXz6MtOupyxXmg31yjrELDbc5r7e6QwZF5nSlCyI/l8rSrTBX9M58VSi4Cw/0tuAtark9EDSsHNmlL9JXa7xh4MHYXDMUvpD23tx3EzvAypuw57GrU1z2e/gNnZ2SxGScZX34lccesRmL0+LPGyHQyiAMhuwptEGd6zBBmV4Yzb2Wkw3fvK+pJajO1h7dB75fme5copuTiDM1bP6oaf3apgO/EKgCNjaYyt8FIl4qQwDC80Pk1+lDtMskTsWnpfPD6wIUHh4TrCxiWaIVI6QrSzJmtV5Qi/5zj2NAtOdslzu8dt0XOEXNVdX5ETY7wkjVf/wWvKYY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciBrbD9ozIynR0PPo4542+UZSLUTpjlqSyFh0/k8dB8=;
 b=ZZnpX0MC8TShJ6wJMciKNHtyjLYpddo2fuuWO9/CnF0WWTp2x7w8Rcyvu49l92DothCm+OVfqOmvXOJzb8qCjqETPFhVRDdB2T85RQWif0zq6iyb2akzoirK7mpL9A/WxEp8e94LevKErKaQhk+cWGf5Pzl4NCpgSVOCp4OZHMTD/Yz2cqN24MvBlApptz6IiUTNbY9z/+q4XzA8rQyFkDfQbB/AUiYwJ90HNsdiB4wctmTQ3C0H8lRSIt5LnrAA/hfSBj72ZiqO+Ri/t+iir+GtV7Nbo7e3HhpeJtwIrjdN9Qo1pXLFyT9lixlBip+QU3e4jDmGyjvvjMQDtQzAsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by LV8PR11MB8461.namprd11.prod.outlook.com (2603:10b6:408:1e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Mon, 14 Oct
 2024 07:52:34 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508%4]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 07:52:34 +0000
Date: Mon, 14 Oct 2024 15:52:20 +0800
From: Feng Tang <feng.tang@intel.com>
To: Vlastimil Babka <vbabka@suse.cz>
CC: Marco Elver <elver@google.com>, Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, "David
 Rientjes" <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>, Shuah Khan
	<skhan@linuxfoundation.org>, David Gow <davidgow@google.com>, "Danilo
 Krummrich" <dakr@kernel.org>, Alexander Potapenko <glider@google.com>,
	"Andrey Ryabinin" <ryabinin.a.a@gmail.com>, Dmitry Vyukov
	<dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "kasan-dev@googlegroups.com"
	<kasan-dev@googlegroups.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2 0/5] mm/slub: Improve data handling of krealloc() when
 orig_size is enabled
Message-ID: <ZwzNtGALCG9jUNUD@feng-clx.sh.intel.com>
References: <20240911064535.557650-1-feng.tang@intel.com>
 <d3dd32ba-2866-40ce-ad2b-a147dcd2bf86@suse.cz>
 <CANpmjNM5XjwwSc8WrDE9=FGmSScftYrbsvC+db+82GaMPiQqvQ@mail.gmail.com>
 <49ef066d-d001-411e-8db7-f064bdc2104c@suse.cz>
 <2382d6e1-7719-4bf9-8a4a-1e2c32ee7c9f@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2382d6e1-7719-4bf9-8a4a-1e2c32ee7c9f@suse.cz>
X-ClientProxiedBy: KL1PR0401CA0029.apcprd04.prod.outlook.com
 (2603:1096:820:e::16) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|LV8PR11MB8461:EE_
X-MS-Office365-Filtering-Correlation-Id: 08cf16f2-1111-44fc-7b94-08dcec2529d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b7rvTjWvLExwln4ZTDGeso19ar5rYD5wmqpNJMfpsoQOufHeoBfZJIUQQSoI?=
 =?us-ascii?Q?d2MgYgg5XmBNa3aUSEKQmWXaPwL6T9rHvuno7fngQVpSXn1pFfJhJMLVoS80?=
 =?us-ascii?Q?EBGYPJY6TP1xcSCUObHawtf9J/Dhi6tD7yQ/5cJRZb/NmI/g6SUdRDMDdOPc?=
 =?us-ascii?Q?vvVuuysRbxXfPraIwan7TWw2AmcQVsyyXcE5f/rZn+D36RT9f5uySzDBZh3j?=
 =?us-ascii?Q?K4imWslGswkjAenjFQB7Ypy//3kI7KsboUeX/+ZlU2S71QmCwFC9Izua4+eq?=
 =?us-ascii?Q?LcJcjlqN8OGC3PTXkVj0a2wLpGDA88iqsrGmB3WgeVMEeI2sTzNal2ikLd5n?=
 =?us-ascii?Q?ump16hYpimYKaxrLwZMxs9FM2tOkumehxb79z/T/ZQMqmEYD+AM31SsWG5C5?=
 =?us-ascii?Q?I6jJ1mEBlcx1xNOL9YNoyiSw6Y7ruYrxxYbfaVq4CZP1z4m0QD4aKFxpieEK?=
 =?us-ascii?Q?wFMNKCRNXHd9qkOzaA/2aA8HNICnGrzWbzS0AK7uSud4rnhXtPmNfyYfUu1R?=
 =?us-ascii?Q?ostYojQ3P99fTwRQXuuF03+r9Qffpb2ivC49e8b7SvP7V2Mkw0CAN83VXRh/?=
 =?us-ascii?Q?GM7zfl75F2T2luNZCFCnmPKp9It+raBDoxoJFKd4pbRQRX3SBzZXlj3UJhIq?=
 =?us-ascii?Q?a2BJ30udbchr/HhZcRLqY7cCE2gWcfMr+fOIY8EvsSUU1f20Z4prm9zXDwpa?=
 =?us-ascii?Q?7nwlPOw2FpxJ+/AWQeOcLfIaOlULHPGXwLoeYeqqOarS5OdxVKFM9EQRpkoJ?=
 =?us-ascii?Q?rOsdArc4VyEpPO/SuNy/5BjlwifAIBcoCfY3w0DlDv4rsdpSqbedhEgm8x2S?=
 =?us-ascii?Q?fsHekhHjvSllQAf8eLc+D1hrxqBjt9urRisLNRDZRsrOdmIEYnQgyB/Oo0VQ?=
 =?us-ascii?Q?H9Li6xusLVe7r7N4W0GkgeeJoGAOBGJBUlouOFt31hxsoUcUIcyHmMJX4Mnp?=
 =?us-ascii?Q?78G9KymQdmI2oxIORKl+tbyhnorzY3E1gHjC4Nyc3wxXRsMqhhTjvxNdK9BW?=
 =?us-ascii?Q?+RwqI8OkKtTKzO023KKZElpq6ekOm6ZG4ZAvSLUKcK4R51ur3CEMcCZe2g9U?=
 =?us-ascii?Q?W0kG2vmZb1+KPryPLQUVbxk/cPosIYmd15yKE+dApHDmKwwGZAWba1F7hb27?=
 =?us-ascii?Q?qxje2Zvf/uODym1a1S5UOcPTllNx0tKggXEV/BlswKcSgWqtvqXr9JiEQ0xa?=
 =?us-ascii?Q?9xISl9LeY7No0nj3nG2r0kEBkzFTGZS3d5+fsqbzFOW5U/0fZXNpRww5Hso9?=
 =?us-ascii?Q?GzSeoydbiu1Lvb/83mhmyCOaLc3zWZc6ahIvuQgZhA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YxeOb/V8pA2lhAq34G7acqiDRD5BDIy/KnYFWPkgEKi1BREdxvLjr6R2O9Po?=
 =?us-ascii?Q?CgELG2rno5PfM5O8RcGbvWrX8lveMSQxwihWm0BTF3Gx9OE2hY/A8hDFNZsg?=
 =?us-ascii?Q?VFVWGHrO4r2VO0yXuUkolOdS2OhbMBKC2APIDAjJ11/aGrfcV8gHdbFFo2iD?=
 =?us-ascii?Q?d0/MwlspQ1kf7qsOHToJ7uWlEIw+/ZINT227y4nsDsjr9YiAXB88YIuJv2w9?=
 =?us-ascii?Q?Gpm3euyx2RR4nhX+ovWUYXJZwq6lEmV8358jDQMIa0B+qw/DBVj74ivizLW1?=
 =?us-ascii?Q?LaNTS76RYT3qFIBam1Cb83+IfJ4CvnD14ngkT27UhbYuP7BSKovyUSCPN5YL?=
 =?us-ascii?Q?9LAM7BYLn9FegdtBdXKZ7nlIqqAEXVQPPI4cZ5t5jSX2p1UtWRzrO7mAV0Er?=
 =?us-ascii?Q?77D/sAarsoEUSekfIpb34aqRa/pSWfSyjcB0H8hyDYEwI3jOC0M3HKNIM/db?=
 =?us-ascii?Q?8oLNe6cCex7rbzL7la7teApEAkn81eRY2UEr5hx0hwTrRXrkAmgHKEe00ech?=
 =?us-ascii?Q?J5A1biwmnisZ2DwQCGqCZs3bCalCNvfz280BXdWolcuoPCEoyPkxRaEI9YiH?=
 =?us-ascii?Q?pd/74eYFFg3B3WtWDaNyjyGK0DAAipEadQu2yyCborb88BTqEIFI4VDLjUio?=
 =?us-ascii?Q?mnwbc78FetzlDF+8+JTZuqZKbApeqrq6K0XQEE1dOqVaUjOHsPAqNbQneUDs?=
 =?us-ascii?Q?unpCxgoBKT5MMO7EB7FyyT4erZ8geqHOSAzqzNd16Cao41a+KXtwrTOc+DIX?=
 =?us-ascii?Q?/AbDC8G6rtkJmW6wyDVuB9MzmB0VoKTC9ObHScjnUZka5M5Hx60nSz6GqxFR?=
 =?us-ascii?Q?XDNl9QaqaHxHyO9p6zYSbR4GfpaUQYrWudrYAfOx+OzhuBfdI8MdgFyrw6uW?=
 =?us-ascii?Q?C6V+zokTv6y6Nmc75ihgc91qwqqOp7HPnhTUk6jErGRlvva5JJP5BU5RZ0/R?=
 =?us-ascii?Q?ZSiUUWMPOk+hZNPA/ODZWB1jqzpClkU+/dshn1+2/lP+fhl8ovTk9PSfa/L9?=
 =?us-ascii?Q?hPvI/D/RuEjCIaP14BcsrdW0BuBB+jKtvLdInMQOM6/eGhwEvXDR8J8mwBsB?=
 =?us-ascii?Q?8NsmXfXsU/l2laCgIqYAo8scU79GFNkiZSfUxjYLcyy+JJp3kMUE8Tsca7eV?=
 =?us-ascii?Q?WClDtwz3mLf/AJSOeb5H36OkEvwctYJ4ZPKPJHyFOTXh34OfeOQWhXgFhMeM?=
 =?us-ascii?Q?JpZ5h1ZUul25Q4tdZ46QGuZ0pzt287MCD8+Axw/DRhHTksUabfvrw/2ftO3W?=
 =?us-ascii?Q?oEApvcWEzEBRiqldE4/BNTTepj8WZ5VlRBfvaP8pBnC7Js8qzaqSfaX0CoMh?=
 =?us-ascii?Q?/SF7PW3KIo8JMzg1kuSM0MG5KUl6K6uDm7+Y17esBN39P1kgb3Q2zw9QEuk1?=
 =?us-ascii?Q?gI8J0sEtJhIMcbO47Be65vuq3IeVVOg0HtnhSMa72b6XVP9JfJf9DwMaHx2f?=
 =?us-ascii?Q?E4pmA+EJ5HoZUxwG6Kn4vjg9F8/GYjOdaca3i6nlCFa9f+w2EBDsOVlFa0pK?=
 =?us-ascii?Q?j9wYt817mw4JdMA8yJIT/whbJwhOQWZaTtCaDxdPUIVI1Ze6RLJstzsgatxN?=
 =?us-ascii?Q?RgPOeTdxF5vbljIcP9o13fj6RytSdgyAKnVY8J3d?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08cf16f2-1111-44fc-7b94-08dcec2529d4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 07:52:34.0673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xp5wt1M9e8fyyhOKgGmx2B03haYu7dBYQuyxk1ZIIn1sKWU3dW3hInGvo0cJLOesvtFQQPetvqwrYfVNLXfwMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8461
X-OriginatorOrg: intel.com

On Fri, Oct 04, 2024 at 05:52:10PM +0800, Vlastimil Babka wrote:
> On 10/4/24 11:18, Vlastimil Babka wrote:
> > On 10/4/24 08:44, Marco Elver wrote:
> > 
> > I think it's commit d0a38fad51cc7 doing in __do_krealloc()
> > 
> > -               ks = ksize(p);
> > +
> > +               s = virt_to_cache(p);
> > +               orig_size = get_orig_size(s, (void *)p);
> > +               ks = s->object_size;
> > 
> > so for kfence objects we don't get their actual allocation size but the
> > potentially larger bucket size?
> > 
> > I guess we could do:
> > 
> > ks = kfence_ksize(p) ?: s->object_size;
> > 
> > ?
> 
> Hmm this probably is not the whole story, we also have:
> 
> -               memcpy(ret, kasan_reset_tag(p), ks);
> +               if (orig_size)
> +                       memcpy(ret, kasan_reset_tag(p), orig_size);
> 
> orig_size for kfence will be again s->object_size so the memcpy might be a
> (read) buffer overflow from a kfence allocation.
> 
> I think get_orig_size() should perhaps return kfence_ksize(p) for kfence
> allocations, in addition to the change above.
> 
> Or alternatively we don't change get_orig_size() (in a different commit) at
> all, but __do_krealloc() will have an "if is_kfence_address()" that sets
> both orig_size and ks to kfence_ksize(p) appropriately. That might be easier
> to follow.

Thanks for the suggestion!

As there were error report about the NULL slab for big kmalloc object, how
about the following code for 

__do_krealloc(const void *p, size_t new_size, gfp_t flags)
{
	void *ret;
	size_t ks = 0;
	int orig_size = 0;
	struct kmem_cache *s = NULL;

	/* Check for double-free. */
	if (likely(!ZERO_OR_NULL_PTR(p))) {
		if (!kasan_check_byte(p))
			return NULL;

		ks = ksize(p);

		/* Some objects have no orig_size, like big kmalloc case */
		if (is_kfence_address(p)) {
			orig_size = kfence_ksize(p);
		} else if (virt_to_slab(p)) {
			s = virt_to_cache(p);
			orig_size = get_orig_size(s, (void *)p);
		}
	} else {
		goto alloc_new;
	}

	/* If the object doesn't fit, allocate a bigger one */
	if (new_size > ks)
		goto alloc_new;

	/* Zero out spare memory. */
	if (want_init_on_alloc(flags)) {
		kasan_disable_current();
		if (orig_size && orig_size < new_size)
			memset((void *)p + orig_size, 0, new_size - orig_size);
		else
			memset((void *)p + new_size, 0, ks - new_size);
		kasan_enable_current();
	}

	/* Setup kmalloc redzone when needed */
	if (s && slub_debug_orig_size(s) && !is_kfence_address(p)) {
		set_orig_size(s, (void *)p, new_size);
		if (s->flags & SLAB_RED_ZONE && new_size < ks)
			memset_no_sanitize_memory((void *)p + new_size,
						SLUB_RED_ACTIVE, ks - new_size);
	}

	p = kasan_krealloc((void *)p, new_size, flags);
	return (void *)p;

alloc_new:
	ret = kmalloc_node_track_caller_noprof(new_size, flags, NUMA_NO_NODE, _RET_IP_);
	if (ret && p) {
		/* Disable KASAN checks as the object's redzone is accessed. */
		kasan_disable_current();
		memcpy(ret, kasan_reset_tag(p), orig_size ?: ks);
		kasan_enable_current();
	}

	return ret;
}

I've run it with the reproducer of syzbot, so far the issue hasn't been
reproduced on my local machine.

Thanks,
Feng

> 
> But either way means rewriting 2 commits. I think it's indeed better to drop
> the series now from -next and submit a v3.
> 
> Vlastimil
> 
> >> Thanks,
> >> -- Marco
> > 
> 

