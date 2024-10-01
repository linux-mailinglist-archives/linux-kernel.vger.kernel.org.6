Return-Path: <linux-kernel+bounces-345334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B4F98B4D4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDEC01C23BAB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 06:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297171BBBCA;
	Tue,  1 Oct 2024 06:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AJF0idfT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1D28837
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 06:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727765138; cv=fail; b=m9DPYPqcuqMd5cZVbrWy6VooAVZJ5XUsFg4b05dd+LRL6oK7FjXgSFAdBaxDk2MYBhkqd46MRAT173KEGo+rYba61rBiCRU5r34KoOE4sygCe6NNzi9EodtK7qqR7iOjnbmS34k3OKckoOou0bSZmLXSwioghcxObP7gZapJkss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727765138; c=relaxed/simple;
	bh=iSw/AaJYjK+WtPajXxUmww+FHxwkpd0qY4Ebn6969mc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AEcYFKuPKtgUkPbCqqMVrWi0mxAFuYk/Vf4Dr9d0HUraooc0wvlTwsEPHqOqLeVY5T1jBdh2GSwraXUhdRAASoxFWO+BZSnBG6M+f69c8Xi7j1KUNMdfSqQKpmi9XRMaKRQJ9PnC0pjYS6F58Ixr26l5lFPFSM5sUDKmpEQsDpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AJF0idfT; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727765136; x=1759301136;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iSw/AaJYjK+WtPajXxUmww+FHxwkpd0qY4Ebn6969mc=;
  b=AJF0idfTILFHmamjMwLoVwTjl1DqKz7z/38Zm4/p6vutQbBnq0ktBwYA
   aIBGRIDX1hsvs2MqQy1+MJgKm9fbNwWk69MMxms6W2PnGG1pBWmVRbThi
   T02hRiHwlTWfX+P3GPVx4NLkn6OP79r4DAitUp0bNx6IBsuiWnCvRDLDS
   TOITbpwGu/zsYPtLZhBLIafr5AxtOIhot7VoYmUhEzZfhRMBZTFwqM0J9
   Ytt7mAvKtFbrtnSTBiB08kZ4D9o7geJHAlOlDzX95uEcBFXNYGf1nAWBf
   hPl2am7WbvuW3JhB/lzOIY9v4gbPB2pLZ2up41809G6q84dfHe7wA7gVL
   Q==;
X-CSE-ConnectionGUID: MIGJ3BLJQ5GBG5kHQfmECw==
X-CSE-MsgGUID: geOc0sCwR2CsIvOvjEgqOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26337557"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="26337557"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 23:45:36 -0700
X-CSE-ConnectionGUID: bn+6XB6YSAOkVdTKCZYtlg==
X-CSE-MsgGUID: bp4LpZtiSw+Mksn7jkhZNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="73596835"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 23:45:35 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 23:45:35 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 23:45:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 23:45:34 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 23:45:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ec8gUmwlFYWTn2ZkV35mUujpJmg0Bx+2gcASpmnEkyq813DbmsDFhRtpvlFbqkmO9O2ZCLz/Q/kkfrKiz5nDDOp9lOxI8K50fHSADHSEaNzmwjqf2W1MY09dgkovcir47ohnTi4JfQATgrV9Jm75PlF5X+/kjGCPzLu2djc3Xp1ivwLTocjj7Glvz8lIaq7thRnL5jDLbWijRyKMyKYmnInK94slbk5oFsOpWMorsA5WMEQFo1/HOT7dAyAAmkRXcj60yAugK/5rqhnEphlCzQ+aJYGNjtdiTaeViz7BaOCKF5tdnsU4GXZjFqtFNn1HYRrIa2IwIt4BTOIBKfW+1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+BdjGAKR8FkjzlCN3Goef0Z6bvNFk1xmr4kNpo2Zfck=;
 b=WppcdMOe0Xa7lhiToABnPxu984ogM/dkvjOcnt7FFhg6rqON3FiWRLyu6PD/1bk4fBbSZ1PgbzCpYBULm641J8YiEDOmCWuVa3Nie8EsOGkwUlUZep6hvhOymg5jzly8P3poX3Vvnbc3hurcEZYz5OGW03ezE9BrxaiRJG1R1oNvGQufLCJCxKpBbZvthnuWS6FF9KwOWOUjGC+421cI/dGC4VItOArlu4cx4ID0t59QLb6Ob1Is9o0Q8sxvKpKCcDM8DcujueAbrptzt7E1dWbhijtx4wJZMH95PfhfwkkZPMc7GCaf0+tDyhhMIVs6fW53doImxClCZF+++QeUlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB6325.namprd11.prod.outlook.com (2603:10b6:8:cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 06:45:32 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8005.024; Tue, 1 Oct 2024
 06:45:32 +0000
Date: Mon, 30 Sep 2024 23:45:29 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: David Hildenbrand <david@redhat.com>, Huang Ying <ying.huang@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
CC: <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Oscar
 Salvador" <osalvador@suse.de>, <linux-coco@lists.linux.dev>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, Kai Huang <kai.huang@intel.com>, "H. Peter Anvin"
	<hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] tdx, memory hotplug: Check whole hot-adding memory range
 for TDX
Message-ID: <66fb9a89dd814_964fe294ed@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240930055112.344206-1-ying.huang@intel.com>
 <cf4a3ae4-deae-4224-88e3-308a55492085@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cf4a3ae4-deae-4224-88e3-308a55492085@redhat.com>
X-ClientProxiedBy: MW4PR03CA0206.namprd03.prod.outlook.com
 (2603:10b6:303:b8::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: 7196875a-febe-4efb-fe6d-08dce1e4a572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1gIRDFCAUA/rTtCXGaAU5rMLO8wxuXV9u/BLRtEI9NgaxGpva/ICFuvkehAa?=
 =?us-ascii?Q?8MqWdc4Cxpsfu6zxDlbm2Tl42wHCWosz8zc8E8zor2lIWx/tPBkACO/FZJi0?=
 =?us-ascii?Q?gSm6ck/Y8UzWruQ7nLCq4CAJG5O/SCj5lQKrY7xM8dbitTA3NHiNiLm7Rhl8?=
 =?us-ascii?Q?i9M8HChDFkL5/SXFUOclVshm4w6DG9m89a5Hq+8aTF/6JpeNL/45gyVHAKf4?=
 =?us-ascii?Q?l0IR79hV20ZY9eUtiaRhE6I8rXVFKpDTJlNBgfFrTTFExW80HZXEMb0yh0OQ?=
 =?us-ascii?Q?w5IKOmEqraJnOQMCAxr99/KpkQPAYu4mgJB0M7+6J6gG4/Pu/APc28Kf13V1?=
 =?us-ascii?Q?0etednymQf8NfNJh6xQcQdJkg9Y0q5Q7TYlTFgbMzSCgrVC9Z55OOJjEO10E?=
 =?us-ascii?Q?jr+PUDmFRUykea97HYcaVyPZlxAQUCxtz+rHvvnvFOTc22dmMGxjcnz6XWx8?=
 =?us-ascii?Q?k+jZ0TQ2krKI9Y3BlKapGFODfqwJ2o9OolRFFlHQQsrYOsNVn3WHuzC51Vhq?=
 =?us-ascii?Q?uX5a/OIaKbC1pWEA6j6VBav2cWOZ7t/BqylZlswpyAjRRL1cfYiLvqnUmzrt?=
 =?us-ascii?Q?673vcUDowEmrvgXosgFwUEkTEvzesVRRgV7kyUuqK2J18Vvy3GTEcoQY9iCo?=
 =?us-ascii?Q?gmYVGOid7g0LonlribzGd4shr7jy9Gf0kZ2bPVFxZ2IPhgxV99al3tcEB5/t?=
 =?us-ascii?Q?g948P3syTtNgfDB53ykaUST+nXbDDzEDACX27dI0bPJ7fNK+NqyslkX9TMzD?=
 =?us-ascii?Q?5HnKSCOIm+MpfSsZTAttEbcvwlHMbh0lM7grpqbyHZ4rkxdbj9lFkC6d9DFj?=
 =?us-ascii?Q?am/4ZztvN6jiGoUBORxWAiFYNsPr2F3x4FYPP3NlmkYgGTh+h6Zg+6tXlY8c?=
 =?us-ascii?Q?4bEd7N647MLIob/IwICy4IxezziCmLTQQ+k01Iv5V+/BAkqQR5PB8LHUTF4h?=
 =?us-ascii?Q?tqMfpTxQ5uQB1UnJh/YTni7Ur9d9OQo6wY2oi95+O4CLkkMCXX8okRNlxJNV?=
 =?us-ascii?Q?iZoCaDsM7BtcJ4O1SGTKZDrAuKA6TfFJvkMUtwf+qXmd3pbjmfGyPb4qstYh?=
 =?us-ascii?Q?PWE0cKpla66/aj5lyLNlHmV+AsRSIkqa9Pt118hq1HUcpOu/6ms9hwnkpxl4?=
 =?us-ascii?Q?u9uvXgx0URZzYrY5ObWoMtt/zkY8kO3iyHZsk19aiZTLG0iVaUBpQH6p0yep?=
 =?us-ascii?Q?w+zn5o4bG60CTSOLEpW2T6z2lKLtq0pchJavIgFwFwSNNuSa+FXsyR/m/rF0?=
 =?us-ascii?Q?m7ukkMHzkcwQNpXTpSsQPfjy27s8GraDnfI5Wj9FxQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T0UC8IYUAX/tFV8y+zYaLoGW6Yal/cRla3TC5QCof9lDl1xV7EG1Rda3kjv+?=
 =?us-ascii?Q?KDn8/kDuqJfW2Bm6yB1aucssxAqVhWiJPH1p87Jguii+xr+/bk+UG1MLvusg?=
 =?us-ascii?Q?WcWaWXeXg4MR0gIX0qRCurz/8RUmFkk7R7DPGZEV6Xk0vNwXgvFj54GSsRxv?=
 =?us-ascii?Q?fEFRgfoQEf0KCnxTJPVydZYzlEVP2pxMpJd7bDGH37E/zU9n2K6IoGVZ+MEO?=
 =?us-ascii?Q?7L46uYRMp1QAGKjFjSMCOqe4j5AMcjcAIsuFpOzQ20JsaXJz2qe3lZ9AoFgM?=
 =?us-ascii?Q?DI9zBX3UMO0yyzZaD50Fqz3P84uGSNWrptJGtD0cgPXD0Tk5CYqzVebtRP+s?=
 =?us-ascii?Q?cxRu5SB1HVjBWXyUNeQCJQUwasPQ7SJJ65YlHwbO4IeZ8bIssuiEIEzcKsmH?=
 =?us-ascii?Q?d/yqwCc/GQpyhxfvwoU+2XaHEkM/roxaIBVceU69mBaT9zqxSxKTmGZ2h+Mr?=
 =?us-ascii?Q?JjvkcQsxdfDwTp9LL+2EGhz3UaBV1WZsuFDHKRzBMZXiOG0XaZTHJDsWIT+T?=
 =?us-ascii?Q?GRYJnEVteI60FRVUPqzVZbvn8FwFs//XcVhf3cZhiPGnBFVp5D2RNyJ+vrmk?=
 =?us-ascii?Q?8zmyX/9T5MPJDmQ24z5YZF0k+91fkKC45jCKZdZFUFtUw4qTlTI6MjKPdegk?=
 =?us-ascii?Q?IfOC+ibBHRDq8Jna/VwINsYc61cvP7GAvnNNCN/m9nS4Ni8SfFSfLn+76tbV?=
 =?us-ascii?Q?ypwcImI5opdAsT/XQRO47OgKyqO9RZXGIT6jm2L0Q3Gf7OKucREASqnp4oPc?=
 =?us-ascii?Q?oggPN2hWmeWjaYJjPkv81du8PiSi60NUvSzxxIMB7d/mXcsIy8Ymdinn/jkt?=
 =?us-ascii?Q?FCxOo3EMNTXJ1B/vCgToFq9CJqjAnEh+yDXA2bjXl+zHbYms76B0+reu2nbL?=
 =?us-ascii?Q?il3M6o6twQnjps0KIg3pS783qxqXgKOSIUJ+G4i1kj2aUe4rPBWwVKNgKc4F?=
 =?us-ascii?Q?mNb7A4WBxDnhXA4vO3zkEwhwvcdVEBV0sWCyfImNBsb+Db0TC4fQE2nLJiVN?=
 =?us-ascii?Q?klgKEIcco6ps/loshaLE7FBVYxWrW7e83nfXM3lg0cG1/nK8RPP1GbFNDedE?=
 =?us-ascii?Q?mbfB9hWLaBV2GwZO/+YhyEl53QKRvAS/nturMtowHbdGsApMmjsAU/qb4z19?=
 =?us-ascii?Q?gdcJ/5eMdyn1TgPI3Wxgl1ioxIvvXdi0mNs1lCqFAg4LitckvIYkL9yhLr0P?=
 =?us-ascii?Q?fCS4oXdThHIm+si1otYaA4V+jlOIRFWzCQdsEOPvNiBJXcUxR4APzgpzKzNH?=
 =?us-ascii?Q?UQm0tsOACOOENNfIGLEbst1E/QQzpjDVDwlmIDQ5JdLuY1q340k/YLxYqPIJ?=
 =?us-ascii?Q?j9xoE8/wjP2cB61B/1R/I0cZzCC809FUo6j/DGrCNciivjB72gaBuB9XOxvK?=
 =?us-ascii?Q?UzAn4Wj8SEzyf1EG5iIEKBUCXzhn/Gp2yQ4pH3eoOMyMojLuYlJw02F9vNAM?=
 =?us-ascii?Q?aw2lccnSFaTfu2YRVgmLpLxRdOKOEVin43kEYEeMH6MAq9vq478ITc9bX2Hy?=
 =?us-ascii?Q?pyvav4ia3ggaIA7lKKx2eC7m5IlIlom1METq56BGG7FvsBcfTcLEHAhbHzcy?=
 =?us-ascii?Q?lV3vW1Usb41KvHoIg0QcX1+jHhyqw7NIBtVew/F5P/QqSQ8ZR9feiC/N8pXA?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7196875a-febe-4efb-fe6d-08dce1e4a572
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 06:45:32.5637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cIFBMc9o2z1KdxeAGlhnB+GwRZFcF5YS38eU9Ait/t3XJX6oHT38zHmu+wpV+mkItRLVSUwDSB1Uh+AWKSMw/gYyGFUTrz9VlBmeMrAq/kg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6325
X-OriginatorOrg: intel.com

David Hildenbrand wrote:
> On 30.09.24 07:51, Huang Ying wrote:
> > On systems with TDX (Trust Domain eXtensions) enabled, memory ranges
> > hot-added must be checked for compatibility by TDX.  This is currently
> > implemented through memory hotplug notifiers for each memory_block.
> > If a memory range which isn't TDX compatible is hot-added, for
> > example, some CXL memory, the command line as follows,
> > 
> >    $ echo 1 > /sys/devices/system/node/nodeX/memoryY/online
> > 
> > will report something like,
> > 
> >    bash: echo: write error: Operation not permitted
> > 
> > If pr_debug() is enabled, the error message like below will be shown
> > in the kernel log,
> > 
> >    online_pages [mem 0xXXXXXXXXXX-0xXXXXXXXXXX] failed
> > 
> > Both are too general to root cause the problem.  This will confuse
> > users.  One solution is to print some error messages in the TDX memory
> > hotplug notifier.  However, memory hotplug notifiers are called for
> > each memory block, so this may lead to a large volume of messages in
> > the kernel log if a large number of memory blocks are onlined with a
> > script or automatically.  For example, the typical size of memory
> > block is 128MB on x86_64, when online 64GB CXL memory, 512 messages
> > will be logged.
> 
> ratelimiting would likely help here a lot, but I agree that it is 
> suboptimal.
> 
> > 
> > Therefore, in this patch, the whole hot-adding memory range is checked
> > for TDX compatibility through a newly added architecture specific
> > function (arch_check_hotplug_memory_range()).  If rejected, the memory
> > hot-adding will be aborted with a proper kernel log message.  Which
> > looks like something as below,
> > 
> >    virt/tdx: Reject hot-adding memory range: 0xXXXXXXXX-0xXXXXXXXX for TDX compatibility.
>  > > The target use case is to support CXL memory on TDX enabled systems.
> > If the CXL memory isn't compatible with TDX, the whole CXL memory
> > range hot-adding will be rejected.  While the CXL memory can still be
> > used via devdax interface.
> 
> I'm curious, why can that memory be used through devdax but not through 
> the buddy? I'm probably missing something important :)

TDX requires memory that supports integrity and encryption. Until
platforms and expanders with a technology called CXL TSP arrives, CXL
memory is not able to join the TCB.

The TDX code for simplicity assumes that only memory present at boot
might be capable of TDX and that everything else is not.

Confidential VMs use guest_mem_fd to allocate memory, and that only
pulls from the page allocator as a backend.

This ability to use devdax in an offline mode is a hack to not
completely strand memory, but the practical expectation is that one does
not deploy CXL on a platform that will use TDX at least until this CXL
TSP capability arrives with future generation hardware.

