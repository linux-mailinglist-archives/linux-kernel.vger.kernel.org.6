Return-Path: <linux-kernel+bounces-384129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BED9B248B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 06:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B55F91F2149E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 05:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822151885BE;
	Mon, 28 Oct 2024 05:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TkDMxJYT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED29880B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 05:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730094334; cv=fail; b=rvwBfokVI+Kw18m45CoXs9cHX4lpY01/niZVnI4/5NmhI7UAx5PZ5sspTAOCguy1DrH+TG9ttmqMpPI0h4h0ii+wfjRpLHVLCo+kiBik1kbZrsmiqInH2g13Dz/3pXuEh1kDVm3PpnUW97ccNijHax3Gt55n0CQPIyOTucB9yVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730094334; c=relaxed/simple;
	bh=AdBBy6hjjJe3YqMUlwAL6XgdWGjrE+5FEYNnZN/MhMs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xaoc0xE3XbFGKGD5/4tqfkAGwY3Mtrpc6NnEUGy+AJEYGJ0Pyn60xVdT5xhOt/RtiQk+Rkc+TY/QtZJ2ZzOunG2t3+aIMFPS7Asvd2OMPSgm+tXzjEjk5CEbezytP37dBInkCtj5JXBs6GeNn66TIHC6dBIqy2rK8bKSO+DMdoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TkDMxJYT; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730094332; x=1761630332;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AdBBy6hjjJe3YqMUlwAL6XgdWGjrE+5FEYNnZN/MhMs=;
  b=TkDMxJYTGYsZ0ciMh7ErudyBsTAZHwW16883LCjRrLWbJdtzJae7jL1+
   4CtHSkyzJFkSSL/vvLsF+XrZisOm/yPlQPNm9lF8IeAt77l/V+ffKiTxh
   8UOJmfncIubWuNRMLv7gb4K+D4g48Vw0p9KQi4laAi9n5DpBNZicybKye
   0sl7vQ6K1emRCQnnqHze78/yJNAWGSRSeOENUqYsUEI/SpfmW5jU3H/jV
   5C7Aoy2jg8yRyR7lnzW+jMXvmgwNKmEUsPQJwze3EgtLCLuRjHQD0yQZs
   MkQiVS4nSKNkksOA9rLbARlMDNePyCPLGWI3WI0ytkCx8O0tQrA8UXJn5
   g==;
X-CSE-ConnectionGUID: tuPPL1XDQha+Xe2BkpqZzw==
X-CSE-MsgGUID: bm/dUdMcQJ6Qu1lnLzZwzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="32542596"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="32542596"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 22:45:31 -0700
X-CSE-ConnectionGUID: pnjRgZUbSp23JJcP94MP9Q==
X-CSE-MsgGUID: acyIXU5TTQuKl0qaJr+5Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="82332845"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2024 22:45:30 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 27 Oct 2024 22:45:03 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 27 Oct 2024 22:45:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 27 Oct 2024 22:45:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xSI/cGWASXrhkZpGLCkoVhHY9IQWBNJ5jl7wE7Da36l2USgV/C4RoTnVAmfulkVPrVtjLmiFqGTgYQ76EL+jcBBJA/b1c3wAsxZVf/B9bxmJJ+htbTDPDKoDphSTwQXBlMZDLTjOM1isaZafF9Cx1XpYDaHQXTCZoQVMMv5ysVAkqo3jj44zeeAKyDvjn270KDtlEH9h2tvsA8YlqkDWTjVGxka0h6yU2H8e9NTJtsOwFaIPqAcWgbs+lcLksvSzTpVUsZHhpopM9JOB/iK6sb3ND1qs+tHm0WpdGiY0cWg1IkhOoYxosFiUWFGhbTdezryFBKWrqiN5w8bKaNHYCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nt1+aym81BVpkuJc3WTcrYdloFGlcoI+u9CNz5gTtsA=;
 b=qzH5fFa5KRK8UNAvMqP8d+7I7vs7x3h6NXUOuxyQMM1WxaBRsSfijwSMAt+GUJWh3sYm69VSnzx8C6+4wHXdkjxnc72b5GPU9yWkF0uLYxmWeCh45Aoh4Whc/3SAhHPes4UfYNb1EyTB+jc2Qj91eJvBDVrQOD+Ocd3K49jxUOfAZiYndwetJIPQCZ36YaQvef2cZDLjoLhz+Pb4KTQLCqwePuCGXnHy5p3TW05RSPXAKXHh4xvlqWQMeHyvAlFnqhrxlRHiAXMCvcF8q8gXzYJQ/Ev+RYoY5FDsk4BAW/w2PRICvDIsGwlXIo0O2QWeQY13xVNTdvJqE1eIlmHhcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7572.namprd11.prod.outlook.com (2603:10b6:510:27b::13)
 by DS0PR11MB8181.namprd11.prod.outlook.com (2603:10b6:8:159::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 05:45:01 +0000
Received: from PH7PR11MB7572.namprd11.prod.outlook.com
 ([fe80::16f9:b81c:54a0:76ac]) by PH7PR11MB7572.namprd11.prod.outlook.com
 ([fe80::16f9:b81c:54a0:76ac%6]) with mapi id 15.20.8093.021; Mon, 28 Oct 2024
 05:45:01 +0000
From: "Constable, Scott D" <scott.d.constable@intel.com>
To: Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf
	<jpoimboe@kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Milburn, Alyssa" <alyssa.milburn@intel.com>,
	"joao@overdrivepizza.com" <joao@overdrivepizza.com>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"jose.marchesi@oracle.com" <jose.marchesi@oracle.com>, "hjl.tools@gmail.com"
	<hjl.tools@gmail.com>, "ndesaulniers@google.com" <ndesaulniers@google.com>,
	"samitolvanen@google.com" <samitolvanen@google.com>, "nathan@kernel.org"
	<nathan@kernel.org>, "ojeda@kernel.org" <ojeda@kernel.org>, "kees@kernel.org"
	<kees@kernel.org>, "alexei.starovoitov@gmail.com"
	<alexei.starovoitov@gmail.com>
Subject: RE: [PATCH 14/14] x86/fineibt: Add FineIBT+BHI mitigation
Thread-Topic: [PATCH 14/14] x86/fineibt: Add FineIBT+BHI mitigation
Thread-Index: AQHbERadYk3U+uX1BkqvGSF6S+TS1LJsb04AgAC/pgCALp+gAA==
Date: Mon, 28 Oct 2024 05:45:00 +0000
Message-ID: <PH7PR11MB7572CA5A7558B2B8F2BEAEE7BB4A2@PH7PR11MB7572.namprd11.prod.outlook.com>
References: <20240927194856.096003183@infradead.org>
 <20240927194925.808912874@infradead.org>
 <20240928015006.agymb4decrujal37@treble>
 <20240928131602.GC19439@noisy.programming.kicks-ass.net>
In-Reply-To: <20240928131602.GC19439@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7572:EE_|DS0PR11MB8181:EE_
x-ms-office365-filtering-correlation-id: 2460442d-7451-495e-cae6-08dcf713aa13
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?fI8TCQplTkAqqmF4NqIqA2suq7h9f812BVOD5PMdaIKLiaI1bHNTFRFT/SjG?=
 =?us-ascii?Q?gWxozIGTGk2sCvpm9oSInXYU9OojSpCW9K4e+wLDxGbuqshKUa9dTnRZXcev?=
 =?us-ascii?Q?dXd+/LrJ+1FM38xZaMf94H6O4iImurkrH77h2YdopfJfPa/Q+5eCuJwR6fuq?=
 =?us-ascii?Q?5DstBBDSc4zBua7lzFfwu+mirJ2f1N0KOVK0dknSJBVlvFNRw1E/bHSXd1YA?=
 =?us-ascii?Q?pDDJILVPrq7DbxYgqy/AK0TfTAisM8D5cEvqltsWBTDqhzwF6ubHHDuyURRe?=
 =?us-ascii?Q?lz40+pQPc1ZA4eBHzR3rDOerp9lryUaNDJ4j+//4sWVT6GVbjrIJytevQybn?=
 =?us-ascii?Q?Xb2zoiI45Jjnqi3UycJYwRdstaw/rH5flVLZNSjcRABJ/FGEhbm3LjhiYcSo?=
 =?us-ascii?Q?GPcRSTBEocZEMajpY/pxYr6NVKxSZmVZFuzTMOgca9mcFclq/BFfiU1sqrJF?=
 =?us-ascii?Q?IufD8qvGLq77BmXG2k0cgrBcxTsYGYcpspSoFGKrQHzz8zUBzgfuGYBLVmcI?=
 =?us-ascii?Q?GFwWD4XSDx0DH9XN2w7QuEmFAzu5FUBJZA/HqUZVGwsHlIemBrP8dy55bceU?=
 =?us-ascii?Q?SY9mLo1K3ULrnZqeJqFJcFCcQoRBu8HGLEkYBjL8uDrynumgdlYs9W+2SeQp?=
 =?us-ascii?Q?70aBakwwn6HkB1vpQRyUpOStm0zI/aCynZm/oO+llQXjM/VsZCkDQ5FUuKsq?=
 =?us-ascii?Q?ccGc3aP+TwMMF6tamzzniYKr35DDovxRMdO6/GFxuPb2mxQTDbueUEGe+Cvn?=
 =?us-ascii?Q?RXCxS8iAfk4VwFaSjpncMoYRxFPDx03FdMLTPeaGpFim9H+jDiNpDWK9WVr0?=
 =?us-ascii?Q?cwZUYIkjnqnub4zrWsdZiGGuCL1Uj4KReGHqL5rTkAI4eNSNQGizpDwh6euZ?=
 =?us-ascii?Q?cxmJiXIx7boelabUly6EQmVUvFYke8L8AxLCgj1KHpw/h+bsr02yJIxfCZdo?=
 =?us-ascii?Q?IHo/Enz+q5BlEkWC3asFJ+HTEmwuK3PgH2yXlWwskv9hvpzEMfgQ/NSheveH?=
 =?us-ascii?Q?hOVRUXTNcJB6/EsLxMCImn/mYoL1Y5i5F4jgffh8SC4o5uOf7QmKOUwN2m7E?=
 =?us-ascii?Q?aXv05idIjEQSEkopY4HuMOn7w4eh1t5Usgcnhiewvn0ErmyJHHP8pjpQsvV+?=
 =?us-ascii?Q?TVX6M5m9rtjGSDK79vhQIo9ttAyRnFhr9iK71uptyNysWBI9vj0Eq4rXW2hP?=
 =?us-ascii?Q?AehHazD31zh/3jKjBLlNf9kXrGViBZyNE3S5bo6oJzeiMk36ZPOc2DLYvc1j?=
 =?us-ascii?Q?DgcH09jrpeRvMFJGcG1EGsN8G+GrbVmbna2Y1G0mPg9uD7oS0zYw/qyNyswQ?=
 =?us-ascii?Q?BznZbivvcbU7fkyHAOaFYzHI0tcO/UWBclBT6gpRr8aQzGWNFtGo3nleZEZ1?=
 =?us-ascii?Q?Xg7+lK0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7572.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LTtLP3VdaWKB5CZejh9TVkUuPDfW4VxN6V8jZpFG92OOjFzvCf2H8Ax1S4Hi?=
 =?us-ascii?Q?QTHR7xAnpXg9fk2Tlqd1p7gGrNrxuNbDNqFWz3DWlJRg4Krp6m7SQB7g5t7S?=
 =?us-ascii?Q?MPYF/n2FG0T1rusnNAp6GHnu0ua0NhdN5VNai6z3hA3QV6qGoU+ZcZ7aaM9i?=
 =?us-ascii?Q?LbkBi0enNsUdCoUTtaG61fvOtgI8flSEKK+1TJ8BlKob8I+8mDZxdG+0LtxP?=
 =?us-ascii?Q?xU/WQCrhIyRzjIrv6xOK2emi8yKjLIHA0B0GQPCIVgo1fbL5oHyi/QDhRCky?=
 =?us-ascii?Q?lc3YM9s0MXvE90t4GODsGNov2g0lCk97Ck+qyiW64lO2GiF5npUfovg96WdF?=
 =?us-ascii?Q?SHFotgIVL/vognRQz7HBwjlQclpQ3fhcGnu0Ky/s9Pgo7WZ1t1lbdMRvH4lJ?=
 =?us-ascii?Q?w+sVBDR+6UIrhSN3nFDGRU59We8f/zuJxltXMazD0p8wASDCipCt0/kH/pas?=
 =?us-ascii?Q?AloSFA7IS5RAm6ZlVlttiom7l/UVya5rPn4tuSB8jQRd5BPbuw/EvQC1IfYw?=
 =?us-ascii?Q?1aBoRjNsjycOjuGjPSano0u5hUQQpYWit83oMJDAEO7lzgKFjDSy5HuUchgc?=
 =?us-ascii?Q?FsqwSExXJR8SMsIAe1KnLbr4I7wHlnPf1q9ra2VN/DNYMmv4sEXFLYn8iKC5?=
 =?us-ascii?Q?ByuqAUEnL+v+r9vUjgGHDxpZt5nOGlXo3ua/+TX8tqPa3lSALf0UC1bJGCr9?=
 =?us-ascii?Q?XtpDbf/vKKlOxEcIVXyQSiQ000Kg1c+cPmzljbVVBMeUAhCg4fQeacKp/B4r?=
 =?us-ascii?Q?LT57AeDS50R+2uLh6DTI7h8mcEWgRYdsAUdRwycVfMkxjmG4Xv5bUO/HERfN?=
 =?us-ascii?Q?xnpQaxuKLgRjTEa/vMghH5yIui4duMQC56lFP8U/03zB6newk+TRu2+iv3EO?=
 =?us-ascii?Q?/R/i6+w3kCd9yRgOmFt7KiI6zjREnlZGIQZm4k2Pkw3iRRF0YLp+ybU0lyeN?=
 =?us-ascii?Q?6oErNwmkXoDi/eXAWyxG9rvF4q9PovOI4c4g0hlIE/xbOv71na/TftDT+kDk?=
 =?us-ascii?Q?k94uMLrZz955hPTZqTIH9oCGsXjAB+hpTVcg0kzaniIVQ4AURaVaiCLEhNzv?=
 =?us-ascii?Q?drK4keWu9Uk1ats6Yy7xyDLgLCuM/yCB+Jj9ZyfLylu2aflFvrT+IRZvIJEX?=
 =?us-ascii?Q?ZpyrQXuRr2jl2XyQ250qUEyyx34M61R9luqpJ3qM+qZHubX1YjxjUHSyGSph?=
 =?us-ascii?Q?LmGLwueVJJfA4E4m0eIG0LWee9vBMmC7X2Y8IWLQrOWQvCnAqdGcmc4u7Avz?=
 =?us-ascii?Q?sAfPZdFUHqv6x/P3y46wi3iPeaCvTojRpHhZdD5R+SCmOO652CnF9KRPUBsT?=
 =?us-ascii?Q?smh4yF9Yr5hjGAoPf1mC3OAmRzLUyzpRJUc+Tsw9zys5h1yKg61uqnNmBGzD?=
 =?us-ascii?Q?9J+TyklSJVxE/ddyOao9rIwyQq7wt3ocDSBz4K4K9af9uc2Y+Poz8PBhHFWT?=
 =?us-ascii?Q?K2j8ikOfHJisp41c9C4duoRuMz3g1jSbT9tQgMIOE1EOWQMlTOSpaaCPSTqn?=
 =?us-ascii?Q?AeY51uz8M45m6B2L9vVxh6J98OGWEFbqlXiN2SMrlg3fVFshoJtJrmPpLEXP?=
 =?us-ascii?Q?bAJgPGlTYmFVLeHe5LUWzNsIkL6Zors4k2LoVtp6wRH9jzwNFcH6T+ZjjjdC?=
 =?us-ascii?Q?xw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7572.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2460442d-7451-495e-cae6-08dcf713aa13
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 05:45:00.9103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 85WGy1Juc42EIc45sJsXK9TWy1D3nEjN1rRtiiN9tdtfKrgJNwNeYK7RT6irD71jxVhMIY5nvm1LESwv0F4IpeX4DlhDhscXQ9eHTxHube8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8181
X-OriginatorOrg: intel.com

> > On Fri, Sep 27, 2024 at 09:49:10PM +0200, Peter Zijlstra wrote:
> > > Due to FineIBT weakness, add an additional mitigation for BHI.
> > >
> > > Use the 5 bytes of the nop at -1 and the 4 byte poison to squirrel in=
 a BHI mitigation.
> > >
> > > Relies on clang-cfi to emit an additional piece of magic in the kCFI =
pre-amble, identifying which function arguments are pointers.
> > >
> > > An additional u8 (next to the existing u32) is emitted like:
> > >
> > >	movl	0x12345678, %eax	// CFI hash
> > >	movb	0x12, %al		// CFI args
> > >
> > > This u8 is a bitmask, where BIT(n) indicates the n'th argument is a p=
ointer, notably the 6 possible argument registers are:
> > >
> > >	rdi, rsi, rdx, rcx, r8 and r9
> > >
> > > Single bit can be inlined, while 2-4 bits have combinatoric stubs wit=
h the required magic in. Anything more will fall back to __bhi_args_all whi=
ch additionally poisons %rsp for good measure, in case things overflowed to=
 the stack.

Hi Peter,

Instead of:

	movl	0x12345678, %eax	// CFI hash
	movb	0x12, %al		// CFI args

Can we do this?
=09
	movb	0x12, %al		// CFI args
	movl	0x12345678, %eax	// CFI hash

The latter ordering does not affect the kCFI hash's location, whereas the f=
ormer ordering shifts the location of the kCFI hash backward by two bytes, =
which creates more work for the compiler.

Also, when I build LLVM and Linux with these patches, my kernel crashes. Th=
e root cause appears to be a call from bpf_dispatcher_nop_func:

   0xffffffff813e69f1 <+209>:   mov    %rbx,%rdi
   0xffffffff813e69f4 <+212>:   mov    $0x9b5328da,%r10d
   0xffffffff813e69fa <+218>:   sub    $0x10,%r11
   0xffffffff813e69fe <+222>:   nopl   0x0(%rax)
   0xffffffff813e6a02 <+226>:   call   *%r11     # This is the problematic =
call

to some function that I don't see in the kernel image, and that I suspect i=
s being generated at runtime:

   0xffffffffa0000794:  int3                # The call instruction lands he=
re...
   0xffffffffa0000795:  int3
   0xffffffffa0000796:  int3
   0xffffffffa0000797:  int3
   0xffffffffa0000798:  int3
   0xffffffffa0000799:  int3
   0xffffffffa000079a:  int3
   0xffffffffa000079b:  int3
   0xffffffffa000079c:  int3
   0xffffffffa000079d:  int3
   0xffffffffa000079e:  int3
   0xffffffffa000079f:  int3
   0xffffffffa00007a0:  int3
   0xffffffffa00007a1:  int3
   0xffffffffa00007a2:  int3
   0xffffffffa00007a3:  int3
   0xffffffffa00007a4:  endbr64                # ... but it should land her=
e
   0xffffffffa00007a8:  sub    $0x9b5328da,%r10d
   0xffffffffa00007af:  je     0xffffffffa00007b3
   0xffffffffa00007b1:  ud2
   0xffffffffa00007b3:  cs cmovne %r10,%rdi
   0xffffffffa00007b8:  nopl   0x0(%rax,%rax,1)
   0xffffffffa00007bd:  nopl   (%rax)
   0xffffffffa00007c0:  push   %rbp
   0xffffffffa00007c1:  mov    %rsp,%rbp
   0xffffffffa00007c4:  endbr64

Regards,

Scott Constable

> On Fri, Sep 27, 2024 at 06:50:06PM -0700, Josh Poimboeuf wrote:
> > On Fri, Sep 27, 2024 at 09:49:10PM +0200, Peter Zijlstra wrote:
> > > @@ -1190,6 +1214,8 @@ static __init int cfi_parse_cmdline(char
> > >  			cfi_mode =3D CFI_KCFI;
> > >  		} else if (!strcmp(str, "fineibt")) {
> > >  			cfi_mode =3D CFI_FINEIBT;
> > > +		} else if (IS_ENABLED(CONFIG_X86_KERNEL_IBT_PLUS) && !strcmp(str, =
"fineibt+bhi")) {
> > > +			cfi_mode =3D CFI_FINEIBT_BHI;
> > >  		} else if (!strcmp(str, "norand")) {
> > >  			cfi_rand =3D false;
> > >  		} else {
> >=20
> > Do we need to hook this in with bugs.c somehow so it skips the other=20
> > BHI mitigations?
>
> Yeah.. those didn't exist when I started this code :-) But yeah, once we =
get to the point of doing this patch for real -- the compiler(s) have the r=
equired features implemented properly and everyrhing, this should be hooked=
 up better.

