Return-Path: <linux-kernel+bounces-573384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0180A6D698
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE8F93B1888
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B3925D219;
	Mon, 24 Mar 2025 08:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fpyXxT6P"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B641DFF0
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742806233; cv=fail; b=caCAKsFuT3AFNPxGCgysu1jrOd1EY5BqpyL7Ai8EV+ZH1llnXfWffGhwku4e7voZ5QtP8wCZiBgqvm+QmPY5U1hUoTb2qlZmhgEu9lsKkOsmhFz9v0zs/JYi2onbubL8RrGaxPCkYeOa9wDhEReF9HH4Z6JpIE0ILpG3xJQ+KQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742806233; c=relaxed/simple;
	bh=AZoTVSEEFwJfJgClD/+26D6AF8shAF+6rjEGzsTEmYs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=CRPpEkZidwImXh+dxy13vbzmsjs1Knwlr9ej8cwgNtd7BKg/+RjKINH71Ow7lxze9VR1sZQSCJcQ4h03Zo0MR8o8eEAwxQiVOw6GCglyWaI7E7mLJK9oihGTJABBn2rUy5azNF0mx0ldWbM5c/HK43ilnS7w37gygcs9TkIHR/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fpyXxT6P; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742806231; x=1774342231;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AZoTVSEEFwJfJgClD/+26D6AF8shAF+6rjEGzsTEmYs=;
  b=fpyXxT6PtTH4Xd65c0anUarRs66Y5iI48MmcjDtf2ma+OX6nf/eocsW1
   jTSKNJ/zuCE3aFLGz3dy2FArW6IWfW+8p+AFZhsDiBrAjSTfq2NJNQtH2
   x/URBXDe/ko7YTkXpD/WNFpQFjz03WRhuYjWTUOiZ0Cwlcky62JPCfVrc
   CAelT9J6JwzHRUOQHSV+6NhdfUEL0fLrcQUxSY0br0J4KjgHNOjNlUFM2
   5202f+FL12WHgVLRKe36Siuw99UBqeIO8/6Hkt6vXFz+JL7Ynbf6HryUt
   Ux0UwQYhV+W1P0QJPU7/HpGIFIBBI1yzyjxxDo6Cls67S4x+HeDOgRv7g
   Q==;
X-CSE-ConnectionGUID: kU/P1zK9SX+uqsdam9tYJw==
X-CSE-MsgGUID: JpY8U36zTGCKEmI2x0Ol8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="54665228"
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="54665228"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 01:50:21 -0700
X-CSE-ConnectionGUID: 6XR4BQYLTtG05SCr/O5ODg==
X-CSE-MsgGUID: A/Y+8e30TJq/D3OFQOP3BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="123788670"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 01:50:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 24 Mar 2025 01:50:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Mar 2025 01:50:19 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Mar 2025 01:50:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JfAGOL5d5/j0E/btii8gNbAqiaPNck5xHkDCyRJB3mrrksEd8ekmPiG6iJehmaoLJkexyiC6Ya4bZEoSCjtXCTmZvzUfkndECmQ3Ip8zWifxVy9llisP1AGgccutVd/lbFxlYnm9SDsfuG61+CKFsrQ5x+eeZt6JQBN9zt+bHwazI7xd/tnalW0TwnpV/7RiIZ/v3sdi7uQwrxG2rJVq6SN9VR4AyZ9dWXjg9vTg6Y1xk3kohgouxCbtUapHv25uO5EY0wpoCTRPyH/WhBXtqtWA1DZuHWfpzsqJl9xSHnuiai+GoIb/8cUqpNbpEMvfh8S628qD/MYhgyWzYWfTXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VueueoxJ573B1Otx8gp2lLI8SWuKzkrVHcQG4Js8mRQ=;
 b=rlmsrWcYfTiEAxpxMPt8cjof3tEW8/qfaditmNpq2F3OdKvP4HVxZx3AROSE6t5h1LC3vRbZHU//4U/W63W0W1Hxd+nrI3Od1g2WwlTKKA2l9XKrOnw3x5HijXN7xdgLfvSIImw2s/92wIRcnrR1nhWK4RYaKhKooVPK8ykEpGnp1SsDup/oZErAtz7U8MteGBnNSWH2WFBfnl4lHTXjBdwwhCgZa3p53OeLmcm1FGm4N1Hf4v92hEBmAl2Fp3nDvR8tbitpi5IzL8Tm+hx73RHcYNf2wksZvu5RiBhdgb7dOWFUBS6p//O0yQD6iFEnmVLZjppKjW8M+Xto40b4QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB6334.namprd11.prod.outlook.com (2603:10b6:8:b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 08:49:48 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 08:49:48 +0000
Date: Mon, 24 Mar 2025 16:49:33 +0800
From: kernel test robot <oliver.sang@intel.com>
To: David Hildenbrand <david@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, Simona Vetter <simona.vetter@ffwll.ch>,
	"Alistair Popple" <apopple@nvidia.com>, Alex Shi <alexs@kernel.org>, Danilo
 Krummrich <dakr@kernel.org>, Dave Airlie <airlied@gmail.com>, Jann Horn
	<jannh@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Jerome Glisse
	<jglisse@redhat.com>, John Hubbard <jhubbard@nvidia.com>, Jonathan Corbet
	<corbet@lwn.net>, Karol Herbst <kherbst@redhat.com>, Liam Howlett
	<liam.howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Lyude <lyude@redhat.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
	Peter Xu <peterx@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	"SeongJae Park" <sj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Yanteng Si
	<si.yanteng@linux.dev>, Barry Song <v-songbaohua@oppo.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <ltp@lists.linux.it>,
	<oliver.sang@intel.com>
Subject: [akpm-mm:mm-stable] [mm]  c25465eb76: ltp.swapon03.fail
Message-ID: <202503241635.4c94156d-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB6334:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f94ee72-250c-410e-eaf1-08dd6ab0d578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Lf4wXFWttgvKtgbo+kdj4a0l/l5UIIdX/BYW3P22jAOdCX1JYsBKdYgwZOZG?=
 =?us-ascii?Q?C0z/aWyULyZZUxmTJnJ+Ow8UL8CJAIgQLZsRHGtkXSDj1fCE9p/ggVLXgbdY?=
 =?us-ascii?Q?yFSvEWIeYf5Jrxm+VyEnTNi1BSPhvb08rna7kkoxM0GmQDfCB9MGxjyq4E+Y?=
 =?us-ascii?Q?c0lMZugCtH4JEs0gUBkB8Sx4JWX+N9xUXZGoXUDyqAVcDBbukKgIDeRdT9ha?=
 =?us-ascii?Q?Fjyf1yM52YDeY4khbrN9iRVarUP+ZD8h6gFL43oh+OFBsNTJx0Fslsy/FIUg?=
 =?us-ascii?Q?qmWfsnRbW62zDwXQKbFJrdonoFpN3UHVWAOeAtAi29TP02EUf1NvfoDBqjqg?=
 =?us-ascii?Q?4+8YTrGnFJdMtERqRbcyBUWQ4xVMRNP1eic8UKJ69vqoDG9TQusOp0+v5rfz?=
 =?us-ascii?Q?II0ZsQUMMbmC7NpG5Rj96/XANmuMs0ogRiLurfAd6fx83lz6QVA2uI2vvHdl?=
 =?us-ascii?Q?YXPIXCHLojnh46TcTFwzZ5ZRf+Bw2LIsMDjKV5K7rY2AHQEn5p5zdjLWB+hd?=
 =?us-ascii?Q?NaMxpd3kXEX4554UoiIX9EYHzSqKO9Xp4zlVCDX0wmmQvUGpWUintvxj8q6C?=
 =?us-ascii?Q?psjUgLKUIMI69ps4qpbAYKSC8g5Agv1/KUER1plafNn7vb0F6EOjP/WAtI0s?=
 =?us-ascii?Q?wpUD2LhXOH6xoI6iZkCve1uXb5DQhoauSsmNXYXv1jG2kh+U2Fet/d3T796S?=
 =?us-ascii?Q?o1U13MD41o2f96YMILpKl9/lZuzRWfYg2CGlf60MahxXr/i4wfkfoUXdvgQb?=
 =?us-ascii?Q?S/A0gnU3xWcKF8MidHZtljtwiNfVlV6T+jzGjLFsW2AlIZAORSDtPDBgr+QB?=
 =?us-ascii?Q?RQlcPv/PU98sVkSM6QJNjhipVlv4ogFkpuDJcqHGmsTsGCS7jYo/IAUYBFeF?=
 =?us-ascii?Q?vriqOwCUtvNTp6Zpm2p/I113ppcZY7KNhJyRSYmp9NZRtm7DxGHc6pXgban6?=
 =?us-ascii?Q?uMZ4EKx00a9pz7J04qGVhisyja5zhsLTv2zum8TKYduFnuQIzTp9mqkssxYb?=
 =?us-ascii?Q?VjVOGEQKJohEV1/XjlKV5cgSzeDUnSGAZ2Uwz85KAwJF7sYtKFyxO0ye+FfY?=
 =?us-ascii?Q?+xUcvmhH7rIr7nVCQw7S1bBTVgwbM8IloSVRPrgKvPmwftqoLxnrxT6oGNg5?=
 =?us-ascii?Q?vN7X4C2CPW0QQd07W6VgnE0BlihKz1yA8tZQxc/1pa5kwcKVROxtji9TJv81?=
 =?us-ascii?Q?svc47PJUUein/ayVSYFm0Z6rGxjExI8BdTWHsrF1ryr1YFi+sBAmvAGk0uL0?=
 =?us-ascii?Q?+6OXq1nWKMiWERHkZWHqALmkn/Sx4CoK3L9AUkUoz0Kg5l9ngvXP+wuehTqy?=
 =?us-ascii?Q?4O8s7mFgAWQj7mH8Ow4UPLCLQ36y7NCzN8r4LwPOd2jyfQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cc02qzV71GSOhYDQVt2WNIS7Rk6x9vVCC2VFFP6R8pGtgPecJNvyxl2/ipeI?=
 =?us-ascii?Q?8IlsdmGDJL5BtHrNjcZuPxlhFPio4geiE/NaBwRM1K1CahnsuUS7+nTXaVLm?=
 =?us-ascii?Q?Zp4gKbagzky6qEDhjaRtXPK0ctRwKqweBSKvpUeiZOJ3zZUuQ1aOyOLnrFGw?=
 =?us-ascii?Q?KW6F0BiryvvCny6lXZ3g2JliKHY7Qmw/TGvgeOzjTq/qdIQ13t5ePekUEtTG?=
 =?us-ascii?Q?cylKDHWd2CJZVpsOnyNRJijK/l/xP4UJfS38/5wcmNTqHrCP+VyCjQx2skoT?=
 =?us-ascii?Q?qfoz7PpRaK6j+5+5Yp/XgxgSosoKiT48EB7DVJPJP10Wb+OqnlQK0QJEIhI8?=
 =?us-ascii?Q?SgHcRN6KzJ+MkDXmZqCt3fFxvAzk4Wb54uQQB91erP6r//qtcSCyyvls4GNj?=
 =?us-ascii?Q?Va53/99Loc/aQSSSoL7+PBE/tXv3Lh2dRy3CCmbzBV3GuF0KuHnfoLaarV/I?=
 =?us-ascii?Q?cGkCD6lxXjIjy66XJRokDo3PVP/nwW3a05iXuEJGjp4szhlwYGTFikmt18JW?=
 =?us-ascii?Q?XZZbGG6x9OMFeKvXqFrZoqhOu86iRG3WmraEk4EaD2VQa+dkDwKkus0sNz5b?=
 =?us-ascii?Q?s5ynoUQCjW038iDzmN9cLx+oqGcF80fJBECy3FwF7UfKOR6MkzvPOL1RZDkw?=
 =?us-ascii?Q?cjWMeO+kOQrH12HC2gp/MiDKhoChkJy/Yl8me3ZPQ/4G9TmBaFc54r3jtF2V?=
 =?us-ascii?Q?z4TN2ig6plQ5X1RJwq5Kfc/e27KM8pZs4k0cEpbBYudVLsmxLTrWL+8l8rUY?=
 =?us-ascii?Q?KJE27PIiXbRvg97yCDJes2TIOGsF2yHZfMF1SjNjm655GDhOF0ptUOhhvcFe?=
 =?us-ascii?Q?EYLXGiUhQGhnEVY9htdmMbxKORNwVTuVe6TgptNjcJkFmkodOVMj9xjUy9lz?=
 =?us-ascii?Q?FR8xbRyN1Z5BXmKExvJwPf6KiW9HoIL3JZfoWMks5Ekhrw720jS0+NFrD4/x?=
 =?us-ascii?Q?gsFVpAO42J7l2WhdhWXfiqLQewoU0OKFqVbVOrwwS7abgeTd8fGub+RSNRHO?=
 =?us-ascii?Q?kTc090NSXkQHPKftU7t7XrW5P5Y0rUqQHiTfI0Q1rkpHgD7DqJCNosWus8Ok?=
 =?us-ascii?Q?qNr2krJPM3Lzd4Tj3NrEFozL7HeUmgvJzdqQbtAd9CaltiFn+XfDiZXvjarM?=
 =?us-ascii?Q?HbA43MP/j/0Sidx96sfYPSRGq3EIzHeizQ7EViOCjEEaQPtVVW6eu9Acy7Kf?=
 =?us-ascii?Q?ICCQ1t3Q7XiTCfL9qkyJhAJt0MfCI/RmhQvoY33p1OApArlBFcYVo7CDRmJX?=
 =?us-ascii?Q?8RA7aJ9JfAG8iGxTDKRvJgxbJ6bKvZFXHbzfCKL4cvMPQHQ3/UZx8IN/35QK?=
 =?us-ascii?Q?hhzXuWVrp2MRXndaTZvwoZAkdIupixg5K5EYQQAwspryhLdE6bjiTCeHmZaC?=
 =?us-ascii?Q?hNO6N2Yy4oVwLxrIhtF5pROGyPxuEe6PkpgIN1dlxUVtEtMr+53zs16hktlz?=
 =?us-ascii?Q?ByoxfGcx5bmHogXRo06A3K7FI690hTRYMXGhzdHKqC04SqzL5g5BhQUhAYyn?=
 =?us-ascii?Q?BZT5ZPbgir0CAYerOtSkPCTLC3KtUqZo7W9QoBTfKkc7WsLgEJgfvOS+mHkz?=
 =?us-ascii?Q?JWG+BVnillnE4NWDXIV/nREv3BlaZOYBdH0NBewh3mmrpBvEwUv/Lm5NaLlV?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f94ee72-250c-410e-eaf1-08dd6ab0d578
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 08:49:48.7779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Vgzt6umHznFY2KTRnP8cx1ziJpa54ZDQ6q4eBkNlT9i7AZmGhWPxJNne7RQbZoB10oaMp9LHzYlsZHnc82u8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6334
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "ltp.swapon03.fail" on:

commit: c25465eb7630ffcadaab29c1010071512f8c9621 ("mm: use single SWP_DEVICE_EXCLUSIVE entry type")
https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-stable


in testcase: ltp
version: ltp-x86_64-042eff32a-1_20250322
with following parameters:

	disk: 1HDD
	fs: btrfs
	test: syscalls-04/swapon03



config: x86_64-rhel-9.4-ltp
compiler: gcc-12
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202503241635.4c94156d-lkp@intel.com



Running tests.......
<<<test_start>>>
tag=swapon03 stime=1742744454
cmdline="swapon03"
contacts=""
analysis=exit
<<<test_output>>>
tst_tmpdir.c:316: TINFO: Using /fs/sda2/tmpdir/ltp-N0rQjX9YWD/LTP_swarbcULG as tmpdir (btrfs filesystem)
tst_device.c:98: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:1905: TINFO: LTP version: 20250130-167-g042eff32a
tst_test.c:1909: TINFO: Tested kernel: 6.14.0-rc6-00040-gc25465eb7630 #1 SMP PREEMPT_DYNAMIC Sun Mar 23 23:05:21 CST 2025 x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_KASAN kernel option detected which might slow the execution
tst_test.c:1722: TINFO: Overall timeout per run is 0h 10m 00s
tst_supported_fs_types.c:97: TINFO: Kernel supports ext2
tst_supported_fs_types.c:62: TINFO: mkfs.ext2 does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports ext3
tst_supported_fs_types.c:62: TINFO: mkfs.ext3 does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports ext4
tst_supported_fs_types.c:62: TINFO: mkfs.ext4 does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports xfs
tst_supported_fs_types.c:62: TINFO: mkfs.xfs does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports btrfs
tst_supported_fs_types.c:62: TINFO: mkfs.btrfs does exist
tst_supported_fs_types.c:105: TINFO: Skipping bcachefs because of FUSE blacklist
tst_supported_fs_types.c:97: TINFO: Kernel supports vfat
tst_supported_fs_types.c:62: TINFO: mkfs.vfat does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports exfat
tst_supported_fs_types.c:62: TINFO: mkfs.exfat does exist
tst_supported_fs_types.c:132: TINFO: FUSE does support ntfs
tst_supported_fs_types.c:62: TINFO: mkfs.ntfs does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports tmpfs
tst_supported_fs_types.c:49: TINFO: mkfs is not needed for tmpfs
tst_test.c:1833: TINFO: === Testing on ext2 ===
tst_test.c:1170: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.47.0 (5-Feb-2023)
tst_test.c:1182: TINFO: Mounting /dev/loop0 to /fs/sda2/tmpdir/ltp-N0rQjX9YWD/LTP_swarbcULG/mntpoint fstyp=ext2 flags=0
libswap.c:198: TINFO: create a swapfile size of 1 megabytes (MB)
tst_ioctl.c:26: TINFO: FIBMAP ioctl is supported
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
swapon03.c:51: TINFO: create a swapfile size of 1 megabytes (MB)
swapon03.c:51: TINFO: create a swapfile size of 1 megabytes (MB)
swapon03.c:51: TINFO: create a swapfile size of 1 megabytes (MB)
swapon03.c:51: TINFO: create a swapfile size of 1 megabytes (MB)
swapon03.c:51: TINFO: create a swapfile size of 1 megabytes (MB)
swapon03.c:51: TINFO: create a swapfile size of 1 megabytes (MB)
swapon03.c:51: TINFO: create a swapfile size of 1 megabytes (MB)
swapon03.c:51: TINFO: create a swapfile size of 1 megabytes (MB)
swapon03.c:51: TINFO: create a swapfile size of 1 megabytes (MB)
swapon03.c:51: TINFO: create a swapfile size of 1 megabytes (MB)
swapon03.c:51: TINFO: create a swapfile size of 1 megabytes (MB)
swapon03.c:51: TINFO: create a swapfile size of 1 megabytes (MB)
swapon03.c:51: TINFO: create a swapfile size of 1 megabytes (MB)
swapon03.c:51: TINFO: create a swapfile size of 1 megabytes (MB)
swapon03.c:51: TINFO: create a swapfile size of 1 megabytes (MB)
swapon03.c:51: TINFO: create a swapfile size of 1 megabytes (MB)
swapon03.c:51: TINFO: create a swapfile size of 1 megabytes (MB)
swapon03.c:51: TINFO: create a swapfile size of 1 megabytes (MB)
swapon03.c:51: TINFO: create a swapfile size of 1 megabytes (MB)
swapon03.c:51: TINFO: create a swapfile size of 1 megabytes (MB)
swapon03.c:51: TINFO: create a swapfile size of 1 megabytes (MB)
swapon03.c:51: TINFO: create a swapfile size of 1 megabytes (MB)
swapon03.c:51: TINFO: create a swapfile size of 1 megabytes (MB)
swapon03.c:63: TINFO: Successfully created 23 swap files
swapon03.c:64: TINFO: create a swapfile size of 1 megabytes (MB)
swapon03.c:105: TFAIL: swapon(mntpoint/testswap, 0) succeeded
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try  1...
tst_device.c:420: TINFO: Likely gvfsd-trash is probing newly mounted fs, kill it to speed up tests.
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try  2...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try  3...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try  4...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try  5...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try  6...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try  7...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try  8...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try  9...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 10...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 11...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 12...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 13...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 14...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 15...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 16...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 17...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 18...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 19...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 20...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 21...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 22...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 23...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 24...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 25...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 26...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 27...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 28...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 29...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 30...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 31...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 32...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 33...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 34...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 35...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 36...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 37...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 38...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 39...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 40...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 41...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 42...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 43...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 44...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 45...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 46...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 47...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 48...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 49...
tst_device.c:416: TINFO: umount('mntpoint') failed with EBUSY, try 50...
tst_device.c:427: TWARN: Failed to umount('mntpoint') after 50 retries
tst_test.c:1833: TINFO: === Testing on ext3 ===
tst_test.c:1170: TINFO: Formatting /dev/loop0 with ext3 opts='' extra opts=''
mke2fs 1.47.0 (5-Feb-2023)
/dev/loop0 is mounted; will not make a filesystem here!
tst_test.c:1170: TBROK: mkfs.ext3 failed with exit code 1

Summary:
passed   0
failed   1
broken   1
skipped  0
warnings 1
tst_device.c:271: TWARN: ioctl(/dev/loop0, LOOP_CLR_FD, 0) no ENXIO for too long
tst_tmpdir.c:347: TWARN: tst_rmdir: rmobj(/fs/sda2/tmpdir/ltp-N0rQjX9YWD/LTP_swarbcULG) failed: unlink(/fs/sda2/tmpdir/ltp-N0rQjX9YWD/LTP_swarbcULG/mntpoint/testswap24) failed; errno=5: EIO
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=13 termination_type=exited termination_id=7 corefile=no
cutime=5 cstime=124
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20250130-167-g042eff32a

       ###############################################################

            Done executing testcases.
            LTP Version:  20250130-167-g042eff32a
       ###############################################################




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250324/202503241635.4c94156d-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


