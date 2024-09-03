Return-Path: <linux-kernel+bounces-312085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5F49691B6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 05:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11C131F236B1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 03:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA161CDFA4;
	Tue,  3 Sep 2024 03:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mpS+ID7O"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D3715E81;
	Tue,  3 Sep 2024 03:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725333569; cv=fail; b=d54S77vp8TGePjA8WHeZDH10yboyEU8VLn4I5y/DSLVxtgxo/1qQhinwaorrHxL5KNka2GYH/AGsexrEKQ6GuSimkFMPJAdnv75S3d2OEzbftw+FFS9GABAIqrV0PxxYw2L9D0Sqw/yFwZ5EGRubbgVd82vPJ3/u1uYZSIxIfo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725333569; c=relaxed/simple;
	bh=wk1UFtkpQp2GXRWRs3OnZQ4a40z5hb1wNXYbf4crKYw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lRScYu8x0knBNNUEXIcL5RuxtWXm0HQIjIAa+GV1oddSsiO8SONnPBJL52ofArGQ/5MKFCuAlTI3jfCpiUDafjD7+p5tUSC+C9+ENFR+lUC2Le6VNWTC99h+BiUsm0BMwHMkeQh+P13ukn2WA56uHBNJfTib8yR2/6ztnFyBNwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mpS+ID7O; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725333568; x=1756869568;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wk1UFtkpQp2GXRWRs3OnZQ4a40z5hb1wNXYbf4crKYw=;
  b=mpS+ID7OVJgioFOZJfsjFOxMpRWEjKMCm4IYJW8KbstQios8n7lfdY4f
   6MqYVpJ6IUMH22ZmRUHLaApGqpaiMV9RFKfPh9oi0ZTMyn1CNl6Ymktdl
   kCpGJkiIXFnEICIitwr0fMr7G5iRwqeS/dtSv/hYjzuWcNVvJ8r/2MVOU
   oerp6xDkZTS8lfayWgeljq6j9jqh1fNWuTpef0rCI4pkrBGnRlciWl9Pt
   zMCh9aHErfofHqGXGv96bQwLYKEXo9A7Xrnu4bEqntHm2//N/G5gyiMJv
   aG8q1vWrYMlOXU6RvcBuUkGos3mYQX3r+SvqiSFe4An3+ZZAIgEhcfG6j
   Q==;
X-CSE-ConnectionGUID: TXr5/LRPTuWb/GOo3YjMfA==
X-CSE-MsgGUID: 1nX5gMkLRsK+YyKNP8aJJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="35067855"
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="35067855"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 20:19:08 -0700
X-CSE-ConnectionGUID: wbI0JB/CTlqil8EsmKLz2g==
X-CSE-MsgGUID: sKmcxe8VQWuvAHswhEtqoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="102205693"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Sep 2024 20:19:08 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Sep 2024 20:19:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Sep 2024 20:19:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Sep 2024 20:19:07 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Sep 2024 20:19:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Udwr8n4fOkmJBL3gt3RNiI/hS6WedPSGAnOes+gmKTwXpCK92oWtaPJHkhUjcc9Upb587fVmWhIKxViujm5O3iLWt71H85EB7lgtf8FLub0u6EuIG3DRo4Suil7Tsq9vMy81GeSaMVgDl9pYKWRI3WNoD6wakawjRx79yLvc4Kg7822jZ+aJj4La75WgXmz/+uaRYZoAF22xOV1AALJ19/mZ8YXSp+QkEAoYTl5tUkaSbo7FpJTVsGe7NsmcYSwsxk/rLScwE09nHN5xc1AOunPHNxWIJff2nJy40MgJblLvrTfMoU1e7VFW7iekgRLDcV9L/lKhAfQg84X8p6N2PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxIHpiXB5jMMEPGbpwFrjgZiinCMWaBJwK3IRz/DvQQ=;
 b=nC0+6YmK0C0p7yeZtdG5ApU6xwwHhmjcznTfWy/PAzlqBxiDsuEi+6cSTJlfc2fxBKCUnZgEu/DkpGkAZdZZnUA4ZaRp7ja3wwGfZDFBwqMjX6FZ6UIWhbjQbipDL4d7x8+2sweSKb91+LN0xxMphFglBBsW8l1JjYHEiJHuUMTAdzyjCX0KyAVJLzLZjmzFE+Ce3FOY2ORCVvFKBjXE6kyVlZ7i8uE0GYWIMPOQVOrqEYz1eR+Eg2PJUFWk9xRzlo3Pp3CAonc1G24u+sY4QbQHn/3qOw4ltZ6l+PorWcv9m74lABpCp3hY2K8Hue6AXiES6TiylKEQdHU+DQki3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by MW5PR11MB5930.namprd11.prod.outlook.com (2603:10b6:303:1a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 03:19:05 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 03:19:05 +0000
Date: Tue, 3 Sep 2024 11:18:48 +0800
From: Feng Tang <feng.tang@intel.com>
To: Vlastimil Babka <vbabka@suse.cz>
CC: Danilo Krummrich <dakr@kernel.org>, "cl@linux.com" <cl@linux.com>,
	"penberg@kernel.org" <penberg@kernel.org>, "rientjes@google.com"
	<rientjes@google.com>, "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"roman.gushchin@linux.dev" <roman.gushchin@linux.dev>, "42.hyeyoo@gmail.com"
	<42.hyeyoo@gmail.com>, "urezki@gmail.com" <urezki@gmail.com>,
	"hch@infradead.org" <hch@infradead.org>, "kees@kernel.org" <kees@kernel.org>,
	"ojeda@kernel.org" <ojeda@kernel.org>, "wedsonaf@gmail.com"
	<wedsonaf@gmail.com>, "mhocko@kernel.org" <mhocko@kernel.org>,
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>, "chandan.babu@oracle.com"
	<chandan.babu@oracle.com>, "christian.koenig@amd.com"
	<christian.koenig@amd.com>, "maz@kernel.org" <maz@kernel.org>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH v2 1/2] mm: vmalloc: implement vrealloc()
Message-ID: <ZtaAGCd/VlUucv6c@feng-clx.sh.intel.com>
References: <20240722163111.4766-1-dakr@kernel.org>
 <20240722163111.4766-2-dakr@kernel.org>
 <07491799-9753-4fc9-b642-6d7d7d9575aa@suse.cz>
 <ZqQBjjtPXeErPsva@cassiopeiae>
 <ZqfomPVr7PadY8Et@cassiopeiae>
 <ZqhDXkFNaN_Cx11e@cassiopeiae>
 <44fa564b-9c8f-4ac2-bce3-f6d2c99b73b7@suse.cz>
 <ZtUWmmXRo+pDMmDY@feng-clx.sh.intel.com>
 <ZtVjhfITqhKJwqI2@feng-clx.sh.intel.com>
 <ec7bca4c-e77c-4c5b-9f52-33429e13731f@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ec7bca4c-e77c-4c5b-9f52-33429e13731f@suse.cz>
X-ClientProxiedBy: SI2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:4:186::13) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|MW5PR11MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: 8267b0be-dd5d-4d0a-1dc0-08dccbc72a7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ln3tabYeCcAh/gMPmDu6orlPwEaYLUWdQXOVqRK8CD2cYMuJoWKDE9kkcOwz?=
 =?us-ascii?Q?7dy/tGL8LCL0JdjNBv8wW60dcn1du6lCZjJIxQPC8oU9C2kthC4+S/FgbNvz?=
 =?us-ascii?Q?oP2k8XXGodrsCQOn6lx2nIBXPtPNkwt4ZZzWmuy7TVWd3v/+PoApi6coPsI5?=
 =?us-ascii?Q?mVv4FYxNL3wy+t84DUuiMZ6lsunVQtssEMlTTRv+oXBEwfhm7Fq/B+7dni78?=
 =?us-ascii?Q?QpQruURODlVeTptZc4gonUjfrOmzhwKWW5n6J3HG7+Jzjd8ZuypuKcltsYwZ?=
 =?us-ascii?Q?ugTFiQAoAQ+JJ1gnOwngrBXjz2xs8gs3hN1knKaiaHkBuf5LOCCi8AywqJSA?=
 =?us-ascii?Q?lNdrN5+z4aLQclLnH4ESAHcwoNtIjC7tprlkRVGwKPvV3SMkQ/76q7B9aD4r?=
 =?us-ascii?Q?L8Uvn88biYlywW3yHOFQQqlIP2GnBdwv8yLmDNVH0nnTfQbTuaZ7OoDKWJY6?=
 =?us-ascii?Q?Q0QBNoUp+0psdqmUKS24ytItDfEX8LEM3AprUY74IUKdB7RL/ZiteDyXWwAZ?=
 =?us-ascii?Q?ntTE7QtTOgq/2I11beP8A7IEK7pp1tiLi4mUwNE12zqqDT7M7AxT9bP6VXHC?=
 =?us-ascii?Q?GQtd6d61ld0sDcRwgfFuyj0mYp6eS7wXwOh4afZly66nnPZ+KZG6Ebh9h2Bm?=
 =?us-ascii?Q?l4pbOITBdA2YWGWl6zCXQN6xns4eSoswdQCdo1zsZxCek7hVBbM6+cdgQ8Ef?=
 =?us-ascii?Q?eRRvnx+0630Fy5D+oFJ8CfUEVatqWwpZjNFZQkTvjDzDE1ptBxMMtPGbu3jl?=
 =?us-ascii?Q?k/sp+CBBATun4wrX8wKrYyQ0yPB5tsZV5U9ItnXMoPz/rx5sqCliVg6yHYnP?=
 =?us-ascii?Q?ss7EVcNvmgfGHxVppB6CIXCRRu47x8oB8vExmpc28mXu3SqCXl/Yu1rUk10h?=
 =?us-ascii?Q?Hi3QdMWta1fGkXH5pwdbLje2YJslVS9h3L90Y/Kh1QFP3gbKEHf3luxRtKMZ?=
 =?us-ascii?Q?sHMir0K6YMA6pi8+XCvC/WIj2sYJJnT3ANRp2c4rKrBnowosrru9XpHzeQ6V?=
 =?us-ascii?Q?D5pY4AtXdVYk7pL5OgC5v7ndkFPxx+RAfcatlTHmC698WcuOmi+5zBRMRBLd?=
 =?us-ascii?Q?FIamtg3835eNEv7B5/QoBr1qiZEAgYJxQ2P9P+bjJfjkezbili+tFcR2ievH?=
 =?us-ascii?Q?ymjDKZvI4XpnIjY6ApndufZV1hdsjKFyNoJm66kyOj4HvdLes4GFXKgdex1g?=
 =?us-ascii?Q?Efk76I8sdUQ3e1EP7qByYxztsImESkA3+n1cUPQE36Y5QXmGmZGTS7Mi1l4s?=
 =?us-ascii?Q?FVF2kJtxmEY0pMzzJE6XnYOzg5Y5sYTMqpaH6axqzAK1MipDfI3tpb+FMZUk?=
 =?us-ascii?Q?LRf/3xrewJ0rROqByWP5Ys1bS/jAcs8dNvWMdyBuQ7FeCg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c2mkxwHXxhvhnBsdj5S902WBepyiaTWrSHDCoykwsmdKhLEGMa7CWoBLUHVl?=
 =?us-ascii?Q?wqM+dVV58wZciDladWFC8GgNazLh2qNIJA6gx2Gc/jYp6MYdllAbjv+pom5M?=
 =?us-ascii?Q?vEssGXrfa0nDBvr6O7eZHjyzV1IUReX1NsBHsIdbla5mAUv1yBDMFlnd7Wuj?=
 =?us-ascii?Q?R42g2O16rw/molnjN75tIVEMVxmOdo0aXsDtJB8HPoqrn8MkRZ/Q+qXkyFvV?=
 =?us-ascii?Q?cDLYu8sK24ESZHzVzoJ1wmWBGr5d4cPvVAn4rCivlkjz2Z748YP67dDGKvUD?=
 =?us-ascii?Q?+2s4bjltVegEiRUoBQMaUStbqeER7JvY7vNR2ZnPtNdiQAUh9RZC+pMRI9T7?=
 =?us-ascii?Q?CVgmrOHF/a+iUpeeszFaKL9laTOAVVva346Seo23NpJ9Yiegvpe/NEuXIKGp?=
 =?us-ascii?Q?4PqzceGTGiqwoNNMmuEv8flMmHqF9mu4SmL6oYHmqm7RmBAAnqT0xgoTqoFi?=
 =?us-ascii?Q?EamlhKUXzlLdUSM4WIQMAVk/S/IM8VNHoPdxwWkZpRfxbuNgLWcT1QgA9f9R?=
 =?us-ascii?Q?KSWCyaxa3pUngO5pzzDL39zqENCypklzFD45gyrBUSeM6ikV6IqN2U0gkJpt?=
 =?us-ascii?Q?88hwTkknJvzOAchvxpC6pIxnXm0tZXjPy3GgNKz1uZvUfz7jzrfeGLJ1qepe?=
 =?us-ascii?Q?9HR3rFPj389nzLFOMt+H6c1O5TJQt6Zi5CSxVX0rNSOHDUQpuNPXvXOxh8nd?=
 =?us-ascii?Q?SFqOzQD8RMzSg9/qF4hJsMCFYcAeVNQjMy1tWU0c9vkmcn60QhouCLlS19GY?=
 =?us-ascii?Q?lZmuKIg4/dA47GEBr7m9gJpMQ/xcK2/Gcj8psocIABj4S0/oLhLYAIzt6WBt?=
 =?us-ascii?Q?4BohNEWC17LMpX35sbm2E22K4q/odRhkYFDiY3MrFDRfjraWkqFH2v1Ubkva?=
 =?us-ascii?Q?/HjG2UstwdSZawrh0l6WRvdsZYniI+T7X8eHmdo7ej/Kz0xeI4Sb1lhWShyq?=
 =?us-ascii?Q?f6UjyLg2hu8BnJQjHctaZacsZ/w1VD34oV4t4NMkcRc6v0E7Pjik/bj/cxSv?=
 =?us-ascii?Q?pFSb6sRcXY6V66jau34bw2GatmdTqVe9mu0yikIK0SQxUNeEKSEnAP9HNlWN?=
 =?us-ascii?Q?TnW1XUfST9y0nhC2xxhQH1QgUHGiIxQ3RBie5tOgacm7ss2QoggYUGPoCuu+?=
 =?us-ascii?Q?3ZAlaZvPa/qa/EpTOk61khoQW04NFfHd9s/RItfscQrI9TmNWwuxdr3L8JQH?=
 =?us-ascii?Q?O1XSP/l5OKYXQxO4orhMni2Ph5D49qNuD9D8M/WFLNTdcd2+19X0usWWXry4?=
 =?us-ascii?Q?z9cPkK2Y9FHsQ3DlyMdmdChgSI06RMQEKCJTgT/Y1358T80i4if2J63FLIad?=
 =?us-ascii?Q?2T1XeizwG8LfcXuD/jLe9rGg/D01xUC8s7a+qDg+jxnhosg7949B7TLGOAFV?=
 =?us-ascii?Q?8s7x2izEZPWH7yxsLRch3Cl52ZOcwxgTsowwSO2hHqSXSGkA9iFRyLJrWmdX?=
 =?us-ascii?Q?W2fZd4zrhsfQqWG8tAy8XhvgWSXNznmdn1UMp+/YCBBO5Ah/WGBkAUFRbz3s?=
 =?us-ascii?Q?dryXlcoCAj+mTkdU3NS0NGwvS8uetS+pKJCxtI0Ky4AAucYNvv/0fugeVTNF?=
 =?us-ascii?Q?/2FkvSQvd6cIuQNf2H81Jkj1wX8nHjIToKlxmXMM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8267b0be-dd5d-4d0a-1dc0-08dccbc72a7e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 03:19:05.4964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 57mTbFF3BgA3RnvS0s1/GauJNLj39Z//KRJlIkv1Uf88kX+zBmjultHApDBB+mbAWQfpDaqL1kG93OpALCO9aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5930
X-OriginatorOrg: intel.com

On Mon, Sep 02, 2024 at 10:56:57AM +0200, Vlastimil Babka wrote:
> On 9/2/24 09:04, Feng Tang wrote:
> > On Mon, Sep 02, 2024 at 09:36:26AM +0800, Tang, Feng wrote:
> >> On Tue, Jul 30, 2024 at 08:15:34PM +0800, Vlastimil Babka wrote:
> >> > On 7/30/24 3:35 AM, Danilo Krummrich wrote:
> > [...]
> >> > 
> >> > Let's say we kmalloc(56, __GFP_ZERO), we get an object from kmalloc-64
> >> > cache. Since commit 946fa0dbf2d89 ("mm/slub: extend redzone check to
> >> > extra allocated kmalloc space than requested") and preceding commits, if
> >> > slub_debug is enabled (red zoning or user tracking), only the 56 bytes
> >> > will be zeroed. The rest will be either unknown garbage, or redzone.
> >> 
> >> Yes.
> >> 
> >> > 
> >> > Then we might e.g. krealloc(120) and get a kmalloc-128 object and 64
> >> > bytes (result of ksize()) will be copied, including the garbage/redzone.
> >> > I think it's fixable because when we do this in slub_debug, we also
> >> > store the original size in the metadata, so we could read it back and
> >> > adjust how many bytes are copied.
> >> 
> >> krealloc() --> __do_krealloc() --> ksize()
> >> When ksize() is called, as we don't know what user will do with the
> >> extra space ([57, 64] here), the orig_size check will be unset by
> >> __ksize() calling skip_orig_size_check(). 
> >> 
> >> And if the newsize is bigger than the old 'ksize', the 'orig_size'
> >> will be correctly set for the newly allocated kmalloc object.
> 
> Yes, but the memcpy() to the new object will be done using ksize() thus
> include the redzone, e.g. [57, 64]

Right.

> 
> >> For the 'unstable' branch of -mm tree, which has all latest patches
> >> from Danilo, I run some basic test and it seems to be fine. 
> 
> To test it would not always be enough to expect some slub_debug to fail,
> you'd e.g. have to kmalloc(48, GFP_KERNEL | GFP_ZERO), krealloc(128,
> GFP_KERNEL | GFP_ZERO) and then verify there are zeroes from 48 to 128. I
> suspect there won't be zeroes from 48 to 64 due to redzone.

Yes, you are right.
 
> (this would have made a great lib/slub_kunit.c test :))

Agree.

> > when doing more test, I found one case matching Vlastimil's previous
> > concern, that if we kzalloc a small object, and then krealloc with
> > a slightly bigger size which can still reuse the kmalloc object,
> > some redzone will be preserved.
> > 
> > With test code like: 
> > 
> > 	buf = kzalloc(36, GFP_KERNEL);
> > 	memset(buf, 0xff, 36);
> > 
> > 	buf = krealloc(buf, 48, GFP_KERNEL | __GFP_ZERO);
> > 
> > Data after kzalloc+memset :
> > 
> > 	ffff88802189b040: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  
> > 	ffff88802189b050: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  
> > 	ffff88802189b060: ff ff ff ff cc cc cc cc cc cc cc cc cc cc cc cc  
> > 	ffff88802189b070: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  
> > 
> > Data after krealloc:
> > 
> > 	ffff88802189b040: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 	ffff88802189b050: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 	ffff88802189b060: ff ff ff ff cc cc cc cc cc cc cc cc cc cc cc cc
> > 	ffff88802189b070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 
> > If we really want to make [37, 48] to be zeroed too, we can lift the
> > get_orig_size() from slub.c to slab_common.c and use it as the start
> > of zeroing in krealloc().
> 
> Or maybe just move krealloc() to mm/slub.c so there are no unnecessary calls
> between the files.
> 
> We should also set a new orig_size in cases we are shrinking or enlarging
> within same object (i.e. 48->40 or 48->64). In case of shrinking, we also
> might need to redzone the shrinked area (i.e. [40, 48]) or later checks will
> fail.  But if the current object is from kfence, then probably not do any of
> this... sigh this gets complicated. And really we need kunit tests for all
> the scenarios :/

Good point! will think about and try to implement it to ensure the
orig_size and kmalloc-redzone check setting is kept. 

Thanks,
Feng

