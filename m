Return-Path: <linux-kernel+bounces-306138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C3F9639CA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F28A51C21EEF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 05:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194B8148825;
	Thu, 29 Aug 2024 05:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VebazKok"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF9E43179
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 05:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724908587; cv=fail; b=ggXoO6aQ89/5cW4Lo2On74rsMi6Fs9zv11k5uR58i6SxWecPm7dS5tztSbTC7Sdw5eeiNV8SH3Q2eYbw467m3jjyDgxCi9XVQrTPjgQJ4dMCzM0yIJgF65v9NiYSgJX1rGnFpSit+IeYPSLE/3MrjCFiwVoN2Bm5n2pgzpoomGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724908587; c=relaxed/simple;
	bh=yqVJRLgpeL1Ph/vtli5VVXhQGETEig4dNPSWii9y6jg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m3OXUSE64SDODg+w3qOLwLDbvdO0tDk0j3cYDED96NjFJ5v+ZGzPg5XofXC3NLoWl6XdXdgAYcbfzIpmBZi4wnogOxzvgIjkPYKa4/jKN0e+ajKJohrjMMd3CsN1tXS2E/K5Nxul/8XUG5Hojcy5GoHFPNrDHiaQsVVMbqn21T4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VebazKok; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724908586; x=1756444586;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yqVJRLgpeL1Ph/vtli5VVXhQGETEig4dNPSWii9y6jg=;
  b=VebazKokxPVlxHp5yAWi3MswbKUJP9m962iwYgEhNozHJjczBV3kkJtw
   f9kPRNUPYGQzQzqqZiYtCrNUOFqaSFa6Ns1rLcSbmfHVuzu6J2Y+MxMdm
   lWBGppTNLm2Lv4i1Rfj1jkEQUbujfl6K+A3H1CEidVmEL0tdc5G69mUZe
   EGf4YMNpsTfGbI8oqq/nBtXvUgZmTU13XcffZWvplkyk0abyRAyrommy0
   R0KqJ1odxNZwVgAHmZePMo6DURzPwCFAwfkNZLuRkmWgz3QhxpzwlLUDc
   x5U/1iQaUTnDF8JrTrLZRUsrIK6DUqwePDOBlwvtXrUOFpa9ftMZuK/l5
   A==;
X-CSE-ConnectionGUID: 8CDu8KUDS9C9c3wsaHFxLg==
X-CSE-MsgGUID: f7KjIjdbQ9aDxUilOrMklQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23339772"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="23339772"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 22:16:25 -0700
X-CSE-ConnectionGUID: q3cYfzA7Qladtq4D0WOv1Q==
X-CSE-MsgGUID: ZOVM+F6RT7q8nDkHZ1a/Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="94262266"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Aug 2024 22:16:24 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 22:16:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 28 Aug 2024 22:16:23 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 22:16:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=szb6Jmm6MDU0RcOh6x5Rik07uUGx/Lmw4QnkbrUV4Pn3J0vy7TLid1X479aNEM8mx6hJN78L4BOjs6PMONZkfnwCauOEgCwdmVl2CpTDTiOOPzuB0PV/KWZntapqvOnY++dezreaW0LmAjigVa8WRXFk92HDzwdEqM1fO5MY+VjO/wpxMyRRv4/nlRefhZPAu28iYIRFXUtk43B5HD8WJctzbfxO33yfxk83PyeokQRp5B76r7k66B8fQfzt5fgYo44683gOkBhqQoJm80/5CFQ2RkbpjkkAEBsPxBAUjKiJRYbVb3ZEaGRlwJOftV8/IGwaEzTPcBL0uf24uNcYeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y03/Zuaf7AMvKc7eEeXPhkrDqHhLxbjNwr0Aj7Hga+Q=;
 b=fZvy3kJTfby2C6Hdh+qPIz9OkNjxnYMoI9mCle9WMyZ9dM0XOwks0pCH5yuA+JYXt8PajEi2vdsjjm6c80X16VlwUMLv+wavF6LQEc74njTEDVjQgG2qCA54jiyudunZlkEjLGP1+LOAgj6t8RXJo6tnUan68XH6Ca0FGrZBeeUbEbbDo1PDRL6o/d94ejHLxSMhhzyksqJNi1vyG7TY60zErHnxOHLSikVxBO9xW2EEpcAF5ZkUl5ADgyXJwGfkaIb7ZJMSDEMGASWU4Rb9jXowFDUhKxbOvPSVgxWYxj7r3sW+h2Lv7XT/VOHQa0DkZAGyIzbRs008beAMocgsTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CH3PR11MB8155.namprd11.prod.outlook.com (2603:10b6:610:164::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Thu, 29 Aug
 2024 05:16:19 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508%6]) with mapi id 15.20.7897.021; Thu, 29 Aug 2024
 05:16:19 +0000
Date: Thu, 29 Aug 2024 13:16:07 +0800
From: Feng Tang <feng.tang@intel.com>
To: Vlastimil Babka <vbabka@suse.cz>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, <nicolas.bouchinet@clip-os.org>,
	<chengming.zhou@linux.dev>, Christoph Lameter <cl@linux.com>, Pekka Enberg
	<penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim
	<iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"open list:SLAB ALLOCATOR" <linux-mm@kvack.org>, open list
	<linux-kernel@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V1] mm, slub: avoid zeroing kmalloc redzone
Message-ID: <ZtAEF0WLfMr8LYLL@feng-clx.sh.intel.com>
References: <20240823062415.3632189-1-peng.fan@oss.nxp.com>
 <ZsssFS68lfFR2yJU@feng-clx.sh.intel.com>
 <7c0d1d9f-f233-47a4-87fe-d01c348d7787@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7c0d1d9f-f233-47a4-87fe-d01c348d7787@suse.cz>
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CH3PR11MB8155:EE_
X-MS-Office365-Filtering-Correlation-Id: b1329e69-caba-453e-5c5b-08dcc7e9b6eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GMAFudKlsCb6d1JzYjXovFB6RfzOMis647nb8kWvoH7DGAY0MwHU6WnDK82c?=
 =?us-ascii?Q?zj4PpaUTLuPfGs1NlyVvOkeYlx7XdA0EaPZRSJkEUlM+hOg75TMjXB1E6jTL?=
 =?us-ascii?Q?yijAvvASuTEnkHWQ/lensUvPLQwNSJbwm638GDmB5avobiMr+7RfmVs87u5c?=
 =?us-ascii?Q?J+PI1iTJpudNtBr7NLdy+Cc+wvJqjXe3w9uDwDP7GQmjg3xUoAmtqPlofdsR?=
 =?us-ascii?Q?irtvtpK1ITdzdbQFoZkxFzpAs45m55nllKRY4w7aElrAKOOSdO3QMtMYp9JC?=
 =?us-ascii?Q?P3YNVV9RZtMeZL0VQAWJRAXRVjtUAnAQenvgiB8vd7XWL9qVfHZZwnVE2mDg?=
 =?us-ascii?Q?ixPvckSWIZnAsB6dTD/ogXIQOk67m8DpvTPhOlY1rX/cWXpDXUn44Ctpu9kI?=
 =?us-ascii?Q?5CLuIcmxqO4pSwxn4NxxEVrQQwoevqULVEhO0djidQUopf2ln8mfU0nhvzYr?=
 =?us-ascii?Q?0A8oKDwrfhCz26wvYdFliH5zlxSr2K9r93vs6YHV2oiICBJteAexbguNgFJW?=
 =?us-ascii?Q?2Rt0q4x9NakCr8/q+EmwP/IFr2D4tZKaECjc3sQWn2UqL1FrefoDQjlNm3U0?=
 =?us-ascii?Q?LofEDh7jjw99ZJXrdkIDGYSUAOlrZeNFcwjKVI0Get9T8Hfz926lXAOCycU3?=
 =?us-ascii?Q?aHB61gFwX6jxb2Qnu5LtmALUxC1tK4PWCmfH9dlx/hoftol5nD4uohTgP54Y?=
 =?us-ascii?Q?yqF+vQr39nfg8mJThTLF8rKamhc1Eaxa9e1fTXt9hotK44NJWG3q8qn5t1zE?=
 =?us-ascii?Q?Ul3mV2/LAOPB2IwvcHtLqJK7oYNur+yjOvhwtqS3IjPsdvQAWYvaCHKxNUqT?=
 =?us-ascii?Q?WE5UaKFynHYMsdNT4Ixon6foN9iiAjnbD2BEFSi2uz5oqxjbcFJsrasmIBzr?=
 =?us-ascii?Q?3dIamFGM1b/w0nHZG088AOYRfsFjF6qFfZDRezJaLZxmtc0z+7sx2s83cHF1?=
 =?us-ascii?Q?DftngNcAtyfnbTC6Sl+OZaDUHxrqCDmRmWpA5rwhCXPS+JYQ0uCMQozzceGX?=
 =?us-ascii?Q?tfGBGaknMc3x9nGSawrbSF/U26kLu8Y/vpsc2uP82or4p0Uq2IvJ5c9WlMEV?=
 =?us-ascii?Q?31QCCuLLvRgGbw5q5VNOY1x13PpF+SR5c+v+btQiUHdjAgnFjVR4pl3kVi7f?=
 =?us-ascii?Q?VG5JzLZOPNBr5Fpp0qqq89oj7Xu7J1mftNk6z6KYJB+XiNUuAWjY36D+R35s?=
 =?us-ascii?Q?gS7bfaT1FglxKXECgQROWlkSsbZcR1f9/8Kuu+YcxRfjVGop3YRChG49Ys0C?=
 =?us-ascii?Q?eGCp4gYp6DeZ5Nzw/6uoT/sC3Xvc9GWcHgdoaTdGBs5NQ0kAIMXmpxPZ5wqY?=
 =?us-ascii?Q?fDU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lCeLbitnPcZ/l8BppT4fxf6NmaQSohZ2ZByNouceekAsMZXPdUNyXMBF+GVC?=
 =?us-ascii?Q?Jw/Ee2oh1FSCaeDHA0gFJuOVRkUUTp+CdEv52A7AGT/3nQuiZHlFnroWLpeL?=
 =?us-ascii?Q?SEOpG29j6QNW1B7fA5nPSQVjml2/fkJqLyoHXqmVWHjnLcXvy4uEu/HtfI7e?=
 =?us-ascii?Q?iqF4Zn7ra5UyTDNh3pyYSX9AuJc7s8WXJ7Cwxo0uRKkRQcOdLwYpaZKwBn6B?=
 =?us-ascii?Q?4gUmIi8DeYi4HCC2x/NkAG3TsEnWnX47vIO7fp/LJPtwIKEd86a4jZo667ma?=
 =?us-ascii?Q?lY75mepPSPFNJv4t1i9mT2dPQYqbEmwP07Eg7n60NixcElKb2bORp5Hy+c51?=
 =?us-ascii?Q?/JoPh6sH/XijHo0Vm2Axgy5UI35nLYis0dNe21qVGXDboNkgMZFh0kOfuOGz?=
 =?us-ascii?Q?Ri0XHVW06DXbaUfdGmAYRS0gfuOdRkb1D93z7jS/os+W/AgGiaI3NeCPHmni?=
 =?us-ascii?Q?renfB5HLhk2BCKwU1RI6PILs0xtuG+XYW3JRUm1g2kyeG2j4YXVytnbKAKVn?=
 =?us-ascii?Q?yVG4NOsfLioM6kkCNA0Pk3DJjPnsq57DsvvBMbVPI3fGiN2m59hbUCjEoxwI?=
 =?us-ascii?Q?j8KROXS2uVho1A2TYWHPtzLA17NuGO4rMlUArujgxbRTaX1nbEx5hT5650f5?=
 =?us-ascii?Q?pypI4d3H4bbey0nmfIjotKgOBmjE1b09/vBer5h7KuTT9y681Ar2OxU99P1e?=
 =?us-ascii?Q?9YT7Pxsrx8X+6rJaCvucPTfhmMXuoGTSqh/gsv/B2lR0onA+qxgOjblgAzL3?=
 =?us-ascii?Q?QAhh807dAwep/8B6dhqnaTORGI4he9YgVPh/fKjCZSsgjF+9KrrkK16jJuvG?=
 =?us-ascii?Q?V6m1vv29BZIntsutq9HM6HB4rxQ3NYZVTw/TyTj08ncDf8t70c1yjEerd9vR?=
 =?us-ascii?Q?YAuF/GGwan2XjIiK5Avz6Hsu1If1q+mv6ygQDRRJLx3gtQA3b22PRM2eFiJo?=
 =?us-ascii?Q?ywi9Bnh3XtwWp0H63V8eT+f5OBGRYf/ugtSwwO1yGwnvN58mJRO5GiEALJI6?=
 =?us-ascii?Q?eF7Xv3J6eQkSPWVv77qW2cdvCYjVqjqSYYm44hX8Ab7V4A6aOIeo/SKErtJt?=
 =?us-ascii?Q?vwToLPfrygywRRfWWsbRLNAdb5NPm6bZZflX7v7GCn67J2vTTXM8vvHU0ccD?=
 =?us-ascii?Q?C9e9JEKhgN8Sjz8S5Ibvy/1uuczScDGCz4nym8K0DDUSRtWFK/Saj6IFNMaT?=
 =?us-ascii?Q?+mObRG/QC1OAmkpMZcoVYLTkLM6CUB0rcHFiTSmd+9UHbRCP5cpRU8g47kEy?=
 =?us-ascii?Q?lhElrYfIz6e49rHRmMsn8Zx5MNG4ydvzQQja2vzDlyy2RkwAP844Qupm3PdP?=
 =?us-ascii?Q?cLxcHq+PtWRsVrqCWiPROwyWRKRPEZvdWKYDsgS6jCpk8sQ61DMWv2jfTPZt?=
 =?us-ascii?Q?pB0wZfzwysuP14reB2naf1iw/tz9W/hvr0q8cI4IP9MAG2dPyOkx9Dt0yQn4?=
 =?us-ascii?Q?0JJizAQRbClO+eqtaDPn0qXXQtnDriDGnUG2M3DcZQkqU8g5aBmwTyAM7vLC?=
 =?us-ascii?Q?0kqez2KLd5DowoU/i3q0VK66oYetDSG6kD2D4eztjz9p1O9pKEVopGbrrFxe?=
 =?us-ascii?Q?/aXghiTuk3w2SmrWzmwvG7C0lY613hpvTwNtIZH9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1329e69-caba-453e-5c5b-08dcc7e9b6eb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 05:16:19.3028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P6tQJcDfY0mu05SobK6fseBfbl3BJYwIVOdh/e4a5qVC4jL6GzWYWr88sDrhBsKMghuewuokw6+feGWlyDxryA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8155
X-OriginatorOrg: intel.com

On Wed, Aug 28, 2024 at 06:53:11PM +0200, Vlastimil Babka wrote:
> On 8/25/24 15:05, Feng Tang wrote:
> > On Fri, Aug 23, 2024 at 02:24:15PM +0800, Peng Fan (OSS) wrote:
> >> From: Peng Fan <peng.fan@nxp.com>
> >> 
> >> With commit 946fa0dbf2d8
> >> ("mm/slub: extend redzone check to extra allocated kmalloc space than requested"),
> >> setting orig_size treats the wasted space (object_size - orig_size) as
> >> redzones. But (in check_object()) when orig_size is set to zero, the entire
> >> object is perceived as a redzone. To a valid allocated kmalloc space,
> >> when init_on_free=1, the wasted space and the orig_size should
> >> not be cleared to 0, otherwise there will be kernel dump:
> 
> Could we make it more clear?
> 
> Since commit 946fa0dbf2d8 ("mm/slub: extend redzone check to extra allocated
> kmalloc space than requested"), setting orig_size treats the wasted space
> (object_size - orig_size) as a redzone. However with init_on_free=1 we clear
> the full object->size, including the redzone.
> 
> Additionally we clear the object metadata, including the stored orig_size,
> making it zero, which makes check_object() treat the the whole object as a
> redzone.
> 
> These issues lead to the following BUG report with "slub_debug=FUZ
> init_on_free=1":
> 
> >> 
> >> [    0.000000] =============================================================================
> >> [    0.000000] BUG kmalloc-8 (Not tainted): kmalloc Redzone overwritten
> >> [    0.000000] -----------------------------------------------------------------------------
> >> [    0.000000]
> >> [    0.000000] 0xffff000010032858-0xffff00001003285f @offset=2136. First byte 0x0 instead of 0xcc
> >> [    0.000000] FIX kmalloc-8: Restoring kmalloc Redzone 0xffff000010032858-0xffff00001003285f=0xcc
> >> [    0.000000] Slab 0xfffffdffc0400c80 objects=36 used=23 fp=0xffff000010032a18 flags=0x3fffe0000000200(workingset|node=0|zone=0|lastcpupid=0x1ffff)
> >> [    0.000000] Object 0xffff000010032858 @offset=2136 fp=0xffff0000100328c8
> >> [    0.000000]
> >> [    0.000000] Redzone  ffff000010032850: cc cc cc cc cc cc cc cc                          ........
> >> [    0.000000] Object   ffff000010032858: cc cc cc cc cc cc cc cc                          ........
> >> [    0.000000] Redzone  ffff000010032860: cc cc cc cc cc cc cc cc                          ........
> >> [    0.000000] Padding  ffff0000100328b4: 00 00 00 00 00 00 00 00 00 00 00 00              ............
> >> [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.11.0-rc3-next-20240814-00004-g61844c55c3f4 #144
> >> [    0.000000] Hardware name: NXP i.MX95 19X19 board (DT)
> >> [    0.000000] Call trace:
> >> [    0.000000]  dump_backtrace+0x90/0xe8
> >> [    0.000000]  show_stack+0x18/0x24
> >> [    0.000000]  dump_stack_lvl+0x74/0x8c
> >> [    0.000000]  dump_stack+0x18/0x24
> >> [    0.000000]  print_trailer+0x150/0x218
> >> [    0.000000]  check_object+0xe4/0x454
> >> [    0.000000]  free_to_partial_list+0x2f8/0x5ec
> >> 
> >> To address the issue, use orig_size to clear the used area. And restore
> >> the value of orig_size after clear the remaining area.
> >> 
> >> When CONFIG_SLUB_DEBUG not defined, (get_orig_size()' directly returns
> >> s->object_size. So when using memset to init the area, the size can simply
> >> be orig_size, as orig_size returns object_size when CONFIG_SLUB_DEBUG not
> >> enabled. And orig_size can never be bigger than object_size.
> >> 
> >> Fixes: 946fa0dbf2d8 ("mm/slub: extend redzone check to extra allocated kmalloc space than requested")
> > 
> > Thanks for the fix! I missed to test the 'init_on_free' case back then.
> > 
> > Reviewed-by: Feng Tang <feng.tang@intel.com>
> 
> By the way Feng, have you noticed the other issue we have, with krealloc()
> and redzoning? Want to look at that? Thanks.
> 
> https://lore.kernel.org/all/44fa564b-9c8f-4ac2-bce3-f6d2c99b73b7@suse.cz/

Sure. Will check that thread (it might take a while as I just came back
from vacation). thanks

- Feng

