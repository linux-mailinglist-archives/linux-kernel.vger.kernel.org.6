Return-Path: <linux-kernel+bounces-394844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 309E39BB4C2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546021C216FC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B181B6D06;
	Mon,  4 Nov 2024 12:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JP67M1uy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6B95680
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730723863; cv=fail; b=QchX74JAXo/fkx4zeoGuFWc3VZQbDxN5UMgqKZTUNHfqrCIzp/hgRJnB8QX/Kl7dA4vC8w8K5b2xkkMkhgt+4wYHN9nSXNqZ3JSOlCbuv8MMYm1t5wwzsqhkVsIszq0HmWxVTcO0ljh0CkWhg0p7FDdT/swsDwPhskE+60oBw2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730723863; c=relaxed/simple;
	bh=U2OWHCZ4asjuWHZZz9ZXXaiLwGVe3kdSljGnAXMVDhk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ajilXi7iywbrrBiTygcJ942DGJhGifExgdtGKcreNx00CWdxnC5TyOYFcji+fNUE4Smxd8c/BXwTD70rHjEjDb7tjd8yWHnUNUiu7U8PldilCDpb3wXeG5vLT5YMYYG892YIZ6mwbzfQlw8wIFtenu7IUaih/aFpq4PJlP0l+v4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JP67M1uy; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730723862; x=1762259862;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=U2OWHCZ4asjuWHZZz9ZXXaiLwGVe3kdSljGnAXMVDhk=;
  b=JP67M1uylDolWuglFGEZ0mCQVEzSU8nPSgo+oO3ExCqTCQKwtq5OmXC4
   nmi9CnYzTjhzQ/wHVKl3/aEzKvo5iJxyQaWbGBbmGQ/a2vFC+nqYgDJQ/
   ri/DhyfnUQ+SLYCfczWDg7k47hhpXIoC5nrJyLFGeLKhd7rkN8wvYUdEJ
   WXJa5CVDWo0Yw24JvD8MXtxOfwnQgRa0HBbFKLdI8TsaAPMbSJwjBA076
   bp3ML298uDw5OdAHgutlMA4UMjShoR+4eA17p6Qauwonb1HdXXf2oMzeY
   n9wZDqVypMoj8CP3nKWxQYmmB+1kIiYvmPk6OkVIB1/luyK2xVU7a1cy3
   Q==;
X-CSE-ConnectionGUID: LxK9vJggSFeAxMJJhA3f9A==
X-CSE-MsgGUID: hJCKExqtQwS/vrXW2TVghQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="34205695"
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="34205695"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 04:37:41 -0800
X-CSE-ConnectionGUID: LqBhMYS3T2mxI/nmGmSq9Q==
X-CSE-MsgGUID: xojA7UPCSKqE80ZqHRflgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="87579859"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Nov 2024 04:37:39 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 04:37:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 04:37:39 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 04:37:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDo352FPX8KvlpcjOgWWxZKLxLoON9/pxeOA5K+a+OALGfFryHdSf2dd3wgQk6JOG60dRevvC1dzGp+8kjto7QAxtHMYknVMpN0Asm2CGSaWP1R4XOL3uQ4rlxi+UMRNzsx3MIqtIRZSIrGPL7YWbTpU4Cj/mWMw5iYG/T2Ftu1sinQfouQK3r7RzQIiTTOjA0mmjjHogOqI2hfpEE2VcWvUyXdHRqy2AZwf/hamZA3A0a6Z5XQKEZ/u1yxIWgERmgffKxykmJhJwCBJGi/N7mudfnAM+JP2mA9V60vRDgZ8JHQ11lacgjRU1ubez2GvDmnEIjllEZ8qyR2dfv8ifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXKU1Lq4/EGm65q7pWaD3L9PHzFLnRArlOExKq3KG1E=;
 b=T4zla0qh3GppOmIed7j3xUH1K972ZzBD3yc+vUxUYQSgVqW7cUktKWQBLkHB9dDisTANy2BTW39v2bUnBFh1iF+LZ63/dgb267gtcr0VjXBN0/jGZFpr9dtEDPzRXE+ovMjEoB4ATBeMnEe5yDQ0PKBU39zD79bIcfjVPRkAKIroWEw1QpjaijMXMexZbkYjWe/cnix441K1gV2+UaLVlQP67J4nU8rIUT2G9lZPx97ueqhZQzsjfjFTfX0tNbY3xPXrdZFzoaA6oUS4uRwS+hXB0jJjnA0DYF5qR7ypy3VHC17ZZBb3wOD/b9gbsmeX0SgKZJ63M0LgCSRmDs0L5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CO1PR11MB4772.namprd11.prod.outlook.com (2603:10b6:303:97::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 12:37:29 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 12:37:27 +0000
Date: Mon, 4 Nov 2024 20:37:14 +0800
From: Feng Tang <feng.tang@intel.com>
To: Vlastimil Babka <vbabka@suse.cz>
CC: Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, "Pekka
 Enberg" <penberg@kernel.org>, David Rientjes <rientjes@google.com>, "Joonsoo
 Kim" <iamjoonsoo.kim@lge.com>, Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Andrey Konovalov <andreyknvl@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>, David Gow <davidgow@google.com>,
	Danilo Krummrich <dakr@kernel.org>, Alexander Potapenko <glider@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "kasan-dev@googlegroups.com"
	<kasan-dev@googlegroups.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2 0/5] mm/slub: Improve data handling of krealloc() when
 orig_size is enabled
Message-ID: <Zyi/+gogCHVPtKjZ@feng-clx.sh.intel.com>
References: <CANpmjNM5XjwwSc8WrDE9=FGmSScftYrbsvC+db+82GaMPiQqvQ@mail.gmail.com>
 <49ef066d-d001-411e-8db7-f064bdc2104c@suse.cz>
 <2382d6e1-7719-4bf9-8a4a-1e2c32ee7c9f@suse.cz>
 <ZwzNtGALCG9jUNUD@feng-clx.sh.intel.com>
 <a34e6796-e550-465c-92dc-ee659716b918@suse.cz>
 <Zw0UKtx5d2hnHvDV@feng-clx.sh.intel.com>
 <0e8d49d2-e89b-44df-9dff-29e8f24de105@suse.cz>
 <Zw0otGNgqPUeTdWJ@feng-clx.sh.intel.com>
 <Zyiv40cZcaCKlGtM@feng-clx.sh.intel.com>
 <79335db3-4528-446e-a839-272645133e19@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <79335db3-4528-446e-a839-272645133e19@suse.cz>
X-ClientProxiedBy: SG2PR02CA0065.apcprd02.prod.outlook.com
 (2603:1096:4:54::29) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CO1PR11MB4772:EE_
X-MS-Office365-Filtering-Correlation-Id: f8c69e53-cbd2-4e84-fb6b-08dcfccd70d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KTVSlbGb3ADPwYAAJ3PS5XQnDHXo/NotD/He9EwSj+E8LiIH0qd+45/caajh?=
 =?us-ascii?Q?eWBMqKX40a9mLF/OCXfUDj3RULMj2b6xss1Qh+pqraChJUJSilG9K4U8zpV8?=
 =?us-ascii?Q?qpfMfABSa0Wtri9eQKMRCihOPaHvnWrtZkSiB6liQyG905qMZgVWFoV6H7r3?=
 =?us-ascii?Q?BZMkptC14ZnF23lKLm4iD054hZ3bozdeNZ0jJuddUw0JAWOL7263VsfbzFzC?=
 =?us-ascii?Q?s51YUCJrSo732l+FiYZwfHiYx85aQaTRbCSrgQGahmGr/GBDrdcxbcNQRBBD?=
 =?us-ascii?Q?I01HDn4FXSAtGV/VTkZC4ae/hLc1XK3Txh2aONgQzSvjSCdoxTQq+CvzRWhP?=
 =?us-ascii?Q?gLatgtSDVEZ4mPel+WNLilKHjSGw2YyKzz8ZtIZ5/VRebpIkYPVqifGqy5c6?=
 =?us-ascii?Q?4Xh04H23gaZ5vbOW9/cM/zSikW/xtsMcuu7hQpv3w8qQvucMVeLn3SR5kIg3?=
 =?us-ascii?Q?Gtj/+H4BrXxdefeH8z3bHgUHZK6RDnGiVFPGSGZeNzW0mItM0xOgUs2e5tSK?=
 =?us-ascii?Q?OB8Un/DcbtUyX/Eq1DTsNZeDZXEHtJNWVJE2IxA72ld2OZMws1/GGg+ctGcH?=
 =?us-ascii?Q?Ej4xWxft2sLyqqr5W581JQeBHyn4/dzvJUxM4MnFgWbLqOxZhepCk84x7Q8y?=
 =?us-ascii?Q?b7gXSxAqfBifIFhsUK/M7jd0GjncCl4YyeH5lT223m9IgD4xYixapL7M6Zam?=
 =?us-ascii?Q?uR2M5fuF/fyHRdDLCohcFowewbye6cpsNtdAL+sAi+3Y0ZsZHIKha1mbZMAv?=
 =?us-ascii?Q?3thG+nksrvDly2IlNP87YOmXeEUJjMpHgE0xZQAjll9NTDqEwUDFosnewlF0?=
 =?us-ascii?Q?gj1Llc2zdkbNTPBcUNY5zy1lpaubnTz1c58w1G9SffkjsgNqFNHEE8BXivY6?=
 =?us-ascii?Q?0Efc/3/Ckoztac6FKgN9d5bfJ0xIsBYzbWuEsprZicB2ycZ39yLK1EVWYjmv?=
 =?us-ascii?Q?xnBMA2WR3m9G53/69xBitbF92zdDS+m4OwdTCtOVouZJI55Tgq6i7ci8Mpu3?=
 =?us-ascii?Q?i0o8rRC4hA1C0r71eHMfOdnidwJ6iYbB3aTEQZ73ukoY+MZXtMKpYvLbRilg?=
 =?us-ascii?Q?1rQxtQ9tdWqbV/AGSjcbHbOu5N280zUkQ8FtwFLW2ZcRJjHrj7BCTuigSBCk?=
 =?us-ascii?Q?oVeosMvu60SN+IxeOuthmIChgm2S4X58zruweGe+nO/O63dntAISq1Q6AMlB?=
 =?us-ascii?Q?dOE+qDNsnsGA/OA8o8sh2v3mfWngbriCsgex2ZEuDrRod1zcca4djIbwou/m?=
 =?us-ascii?Q?1Pb6/0Uf9zZG6kbP8Nun0cuzHln+U0n8MTVjcNek3sb5NJyHuw9XEu1h/2qM?=
 =?us-ascii?Q?S+k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yCH2oE7110EsOtbQnnBQrrtJvwBSUZCrODG1oLi74O3/c7DJ7ZHAjB3v1sWK?=
 =?us-ascii?Q?6IwoQRCFsVBtF8YZx6TxZ6daUvnSwSPW2W+ohWpnRb4wJ+oE/jypQvbmRWw3?=
 =?us-ascii?Q?dzYWjoqFCyasyyu74kGq6EeD/IpA7DnXQ4bEvipCn6z7wbnzvHKej9h+m2ZC?=
 =?us-ascii?Q?9vvcEBHOuSuLjrbsw/xgwR/Te2TjiwmS4HXXaOl56wKBnLwjO6+lspxf1HrT?=
 =?us-ascii?Q?3D6LR5Vk2gqlzFh0fhzRnspXskNd///mYRZprnHxtApKc3gxpnGF0H5eEw9F?=
 =?us-ascii?Q?FQsTOVRJZ2FdTi+lQGTSpMQWJBF0J8nDjQdQhryvZvUDu++UZJfze0iLiiW+?=
 =?us-ascii?Q?IqMs/k5Me8ADDxLwI+bmkkLBNxk3XMGYdRoWzSenCNyIiJ02Siew3UIdRPhY?=
 =?us-ascii?Q?D32TucVgGo6WoWdOprgG0cjAN/DG/UNaFvzfxT0KKO4OYG2zb2jy4qN6b+Pl?=
 =?us-ascii?Q?ojjq+sIR3PMhBqIh1yCO9z/MThJTMYkkjv2UQ4tBN/LqsRTAGclaFiG6CcLq?=
 =?us-ascii?Q?iDnwNcvQkWhtYHzO0ttA5ZgWab+HOby/53dkxmutVHWuI4SILerT6Fv0rHRe?=
 =?us-ascii?Q?NEP+3xuDr3/of53OCjnDiUSTrsAqUwaGqet0Yno2OTp0RRp48dTgigZZbQW8?=
 =?us-ascii?Q?01qs6i0TcqJ3jdH9UqKx7eJ87dIQFTa+J1Kzf+dfZloyRNgnnx7QP5NJKJgj?=
 =?us-ascii?Q?cUukL3/7rj/jYszuCp5p1ZYnEaI2pjTj+MxLyVVNChjrkdJT9BPlEb5FyQuB?=
 =?us-ascii?Q?mUZZy5AWXBIfHOTmDim9K7ZBzJFocWWMYVonjO2NmEp/+BXlZy4aVjSRjhaV?=
 =?us-ascii?Q?qWjq79KFBeHCtcBODS0vXGAKQ0lG9UdZYCFSmNEO9ho/PfLx6MGVJgWn2net?=
 =?us-ascii?Q?752gbMEnzFPAvIosidXStXibsO6KVyxDQkPqXMNpxCRIKBK28wOGkbqpVb+P?=
 =?us-ascii?Q?kYw6WLHjLlTDEVFEzHU+L3XOLMM75xJKqmbbjROmJS2ibEzrFRySY5AZvRlw?=
 =?us-ascii?Q?7YxF+VXC4hSweOrXa7XNZyYwA4MPJx6CLyz1m3DMFOxMt/sk+D8tz2CQALmD?=
 =?us-ascii?Q?JrU7GQHU53v5ImJUNgs2Ky4AawUtBKwGKsmiSLEgJVPOH4B1AZcleLfeQK8C?=
 =?us-ascii?Q?WlnHF7AKKJmbjfgoQiY3hyFTIp6uCXau+XZyIF9PBySKZ8+8eQ4UTVULPSbF?=
 =?us-ascii?Q?ToSWZr06yrgZvEWGRlujUg8AwKJfz6rennNoy+K+xQPMsqeZaWsR8xNGiSqD?=
 =?us-ascii?Q?4H342lJo7PpVgqa2vrzLUuvTK1Noqj9sDrjUcdc4C/13Nl9lTL1zMhh2xgtC?=
 =?us-ascii?Q?KnMZh5CcJkc6qjSbHnLqAH+YtjpWReVmgppTobw0kR2zaTOnBCyIQQ5UmzjI?=
 =?us-ascii?Q?ESdTg+LWrRuzOTIsyFX4e4W94W2ZH7lG9tUbmPeUiQmeSNe/F47SN1slChhD?=
 =?us-ascii?Q?UGcxRfTA6QcapJFoNBcG4jNucOAvayx1GeFkw6hEXon/sAp7wVebiHpOSQVy?=
 =?us-ascii?Q?F44Z3j339zLKKFFCez2GiRat1LIRjwuLCWZyZ8+qSHzNDt4wARZxCv4v8xMh?=
 =?us-ascii?Q?xpi+C/NkKGF2T9nvxmOVB/QGQHK8B0yKXAkZFd+o?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c69e53-cbd2-4e84-fb6b-08dcfccd70d3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 12:37:27.4698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TWhatLe5d8HkGaSX2EQT0Q723aPYUQVTTt6A0ZC97dvON4NHNgBxFr19OYpI9WqAn73k4PNzIxWRKrlAdOA3hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4772
X-OriginatorOrg: intel.com

On Mon, Nov 04, 2024 at 12:45:51PM +0100, Vlastimil Babka wrote:
> On 11/4/24 12:28, Feng Tang wrote:
> > On Mon, Oct 14, 2024 at 10:20:36PM +0800, Tang, Feng wrote:
> >> On Mon, Oct 14, 2024 at 03:12:09PM +0200, Vlastimil Babka wrote:
> >> > > 
> >> > >> So I think in __do_krealloc() we should do things manually to determine ks
> >> > >> and not call ksize(). Just not break any of the cases ksize() handles
> >> > >> (kfence, large kmalloc).
> >> > > 
> >> > > OK, originally I tried not to expose internals of __ksize(). Let me
> >> > > try this way.
> >> > 
> >> > ksize() makes assumptions that a user outside of slab itself is calling it.
> >> > 
> >> > But we (well mostly Kees) also introduced kmalloc_size_roundup() to avoid
> >> > querying ksize() for the purposes of writing beyond the original
> >> > kmalloc(size) up to the bucket size. So maybe we can also investigate if the
> >> > skip_orig_size_check() mechanism can be removed now?
> >> 
> >> I did a quick grep, and fortunately it seems that the ksize() user are
> >> much less than before. We used to see some trouble in network code, which
> >> is now very clean without the need to skip orig_size check. Will check
> >> other call site later.
> >  
> > 
> > I did more further check about ksize() usage, and there are still some
> > places to be handled. The thing stands out is kfree_sensitive(), and
> > another potential one is sound/soc/codecs/cs-amp-lib-test.c
> > 
> > Some details:
> > 
> > * Thanks to Kees Cook, who has cured many cases of ksize() as below:
> >   
> >   drivers/base/devres.c:        total_old_size = ksize(container_of(ptr, struct devres, data));
> >   drivers/net/ethernet/intel/igb/igb_main.c:        } else if (size > ksize(q_vector)) {   
> >   net/core/skbuff.c:        *size = ksize(data);
> >   net/openvswitch/flow_netlink.c:        new_acts_size = max(next_offset + req_size, ksize(*sfa) * 2);
> >   kernel/bpf/verifier.c:        alloc_bytes = max(ksize(orig), kmalloc_size_roundup(bytes));
> > 
> > * Some callers use ksize() mostly for calculation or sanity check,
> >   and not for accessing those extra space, which are fine:
> > 
> >   drivers/gpu/drm/drm_managed.c:        WARN_ON(dev + 1 > (struct drm_device *) (container + ksize(container)));
> >   lib/kunit/string-stream-test.c:        actual_bytes_used = ksize(stream);
> >   lib/kunit/string-stream-test.c:                actual_bytes_used += ksize(frag_container);
> >   lib/kunit/string-stream-test.c:                actual_bytes_used += ksize(frag_container->fragment);
> >   mm/nommu.c:                return ksize(objp);
> >   mm/util.c:                        memcpy(n, kasan_reset_tag(p), ksize(p));
> >   security/tomoyo/gc.c:        tomoyo_memory_used[TOMOYO_MEMORY_POLICY] -= ksize(ptr);
> >   security/tomoyo/memory.c:                const size_t s = ksize(ptr);
> >   drivers/md/dm-vdo/memory-alloc.c:                        add_kmalloc_block(ksize(p));
> >   drivers/md/dm-vdo/memory-alloc.c:                add_kmalloc_block(ksize(p));
> >   drivers/md/dm-vdo/memory-alloc.c:                        remove_kmalloc_block(ksize(ptr));
> > 	
> > * One usage may need to be handled 
> >  
> >   sound/soc/codecs/cs-amp-lib-test.c:        KUNIT_ASSERT_GE_MSG(test, ksize(buf), priv->cal_blob->size, "Buffer to small");
> > 
> > * bigger problem is the kfree_sensitive(), which will use ksize() to
> >   get the total size and then zero all of them.
> >   
> >   One solution for this could be get the kmem_cache first, and
> >   do the skip_orig_size_check() 
> 
> Maybe add a parameter for __ksize() that controls if we do
> skip_orig_size_check(), current ksize() will pass "false" to it (once
> remaining wrong users are handled), then another ksize_internal() variant
> will pass "true" and be used from kfree_sensitive()?

Sounds good to me! And for future wrong usages of ksize(), we can fix
them case by case when they are deteced.

Thanks,
Feng

