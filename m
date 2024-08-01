Return-Path: <linux-kernel+bounces-270624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF78D944244
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 06:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF201B211CF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 04:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBBE13D899;
	Thu,  1 Aug 2024 04:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pk/+NGY2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505D91366;
	Thu,  1 Aug 2024 04:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722487573; cv=fail; b=mOjDK6IdtrfPLIRXe+biyc7Mkb6xQXDVtyAwNiVYJ4TqvjnmxpIkU94H9c5P02AcuWUCXI2pojQfaktTHZWFGXlisN+DqZUvpUIlDP0m6AjDjaOYA7se9qL/YVydC4q82KXAKTbbVrymkRQD84Dfr2YTd8QGZ9mipFC4Oi1EECM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722487573; c=relaxed/simple;
	bh=HqXy/kokXTFBcL9wIQGBsbch+dMcICbmNjSlahIoMMI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QxK0QfRoXuu+OBrldA6rQcPHGRZfp1Lhd9Nb8AtrrFIq8AY1cECii/rtIS02wD8AZJp0rS8nhvbDcDe2xvTVLiX6muMxA9MWyhte0eNiiyB9bS0w99RXyds56GJju/bSMNHtwIbfFRAy3WZxohS92JlTJLukXSYdqYjqysJmikA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pk/+NGY2; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722487570; x=1754023570;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=HqXy/kokXTFBcL9wIQGBsbch+dMcICbmNjSlahIoMMI=;
  b=Pk/+NGY2qd1eZq33QztHUddWbXKjlMC6DcZxON64HKR6obzi/eI/fJhk
   BQ53pZ1nqThNFjBi3dd8N/Q+JeaLn14A0EM7qocDxpXDdJx0zj+UYm23g
   00JC0wamel3RKMp6U23T3h3/y0oxfDt+sexC5lNlAPuNKn03NFqTVJgF7
   /qexSXe2IfCSmRI1QzVEwzCob8aDw/10ke7m7s+AyBIPruNu5Wmma9JoS
   CLmegq5Xe/GN0xnPD/JKnathQhqHlZSX40xsaj918iQAkUaQWHw7C1fpD
   6Y1Q0era3cmOuPYo4WbnVDOxPwIygxbp2T1hyJjGun7GWRrTJpYATQYa7
   w==;
X-CSE-ConnectionGUID: No4Xct4ASwGCkujTaibc/A==
X-CSE-MsgGUID: BcO1OvETRwqUyOM6dluVZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="20100804"
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="20100804"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 21:46:09 -0700
X-CSE-ConnectionGUID: D+vqZCRzSMeYON1hbneZiA==
X-CSE-MsgGUID: xEkNplZfSrGw8NFJmYrC6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="59555431"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jul 2024 21:46:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 31 Jul 2024 21:46:08 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 31 Jul 2024 21:46:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 31 Jul 2024 21:46:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 21:46:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZTFUq9VZi8r62gp7fRiwHdg0E6X52VtuCuNshy/eI8BMi0ucxT0njqzdXrC/9DwU3DApDU8lsQYwBShJalbi5SrsiSbaKWlK1Mg5K80/Ak6uRdyfm/1/wiGoy5qIiqw6KBABK34N0Ah9AumYqN0Otzh1WGyinhQi/DrWeexPgC1FjW2J5kCeqeVqqo6HgxX5ErGIYAWBHAFF8yaw/NH2WGRw7yzEX67rYH1VWMKDdvm2xnCPa8vAYm3b0hWz5WtR1pdRVOi5Q6NxK5wQWID5BYyf7FHZwRYxrF/UqOj3Xdko3sT3F40FR4LJocE7nVKJfKhQ9M55Jo+YS/bBauAQZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRNi6bx+IDv0G5k/WBcRspTe68Q0XuXtByz6rrIG3Ao=;
 b=HGF9/TBMYxswj+wt7yEdfJ1VdeEw5vlimIGWz+AC7Pg7NcgEcpSdIaGpzEKOrkbDzeUP9AQhZsatElslrihmj4a8TKmKVg4c7a4JtvjGNsGPM1KZPoTuYIg+EcFOcgJA+ghLwH1SzWxP8+f5iwFcvOvS9czgaCyaK5HmsLwR0Be9C7LHbo4M3otGCKYuk2KsgI2C6sxHgLdr17hAvvrc1zbiobGunH/XtUzmNamDiuFQSt0uMSFTPYfc7zbsBzUtUN0fAzDUujm1SZsmet3WU76v8OXc+Sb0BYH9NNAYxoUZweXGmDqUqdDv6xaWZRk77zKtdyPyq3g9O6cG+RXNGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by PH0PR11MB4965.namprd11.prod.outlook.com (2603:10b6:510:34::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 04:46:04 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%5]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 04:46:04 +0000
Date: Thu, 1 Aug 2024 12:45:51 +0800
From: kernel test robot <lkp@intel.com>
To: Usama Arif <usamaarif642@gmail.com>, <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>
CC: <oe-kbuild-all@lists.linux.dev>, <hannes@cmpxchg.org>, <riel@surriel.com>,
	<shakeel.butt@linux.dev>, <roman.gushchin@linux.dev>, <yuzhao@google.com>,
	<david@redhat.com>, <baohua@kernel.org>, <ryan.roberts@arm.com>,
	<rppt@kernel.org>, <willy@infradead.org>, <cerasuolodomenico@gmail.com>,
	<corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <kernel-team@meta.com>, Alexander Zhu
	<alexlzhu@fb.com>, Usama Arif <usamaarif642@gmail.com>
Subject: Re: [PATCH 5/6] mm: add selftests to split_huge_page() to verify
 unmap/zap of zero pages
Message-ID: <ZqsS/1ts8leyUeEQ@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240730125346.1580150-6-usamaarif642@gmail.com>
X-ClientProxiedBy: SG2PR04CA0157.apcprd04.prod.outlook.com (2603:1096:4::19)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|PH0PR11MB4965:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b9a4ff2-181f-4188-867b-08dcb1e4d9a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DkIx+E/+KENp4Wr1xJuJWhXJlMiSUGSHGhS0SHQHCkb8YHCM8uqepX2hVxo9?=
 =?us-ascii?Q?JPRzqfLLG7OYubL0EcWmm7xmncfbigvKaUYNK3oWu/PV7sxdMXn0we0F3axv?=
 =?us-ascii?Q?ZlV/M31Yd8I3rSCPJ8P/4O1Tv61B1dkxOP0ShDKBkqbpdMyS9TE3ztg/dKc+?=
 =?us-ascii?Q?vhmIPrH/Ml6Wi2N2iN/pA/K1NTZJy0Ci6PkDmKPowrmcbl/OmhHIeNHSgS6P?=
 =?us-ascii?Q?CJh7XHu1Q4Sy6sP8ih/mXPJswqSzkVHidlg6jiy5s2eqiYdUGaonFj39BIll?=
 =?us-ascii?Q?eOQunoAfWVF1BmuGIqcK0uH9jUAEFRNyuAzfDLORwkp7hfjRJHx0EhwbV0l/?=
 =?us-ascii?Q?0XyrwfqzuXtkZmrQwT3KBMw8381BFnn9owY5yGxX2/+3MpWyIe9wvps+ttHg?=
 =?us-ascii?Q?1Fv6mDPVzjOQRxCFSRQmHseI7NyqG9BX3INVuTc4rZ/I6GKHtMHDvqf3hbYJ?=
 =?us-ascii?Q?lZjLFDA8OPr5KVUe69ChrpjeBBbYCFaxOZbYfiuRHi7z+/yoZvcOihCE97ps?=
 =?us-ascii?Q?ZKK5iVFAGR5RefEAehpu/ptoogzVP1SDUdVJ2KOrT9XLN8TNRUVbLC/IUKQM?=
 =?us-ascii?Q?oGjH/lxBBP/4HqqlrwXq31aXn95dMT5swpHPgESWiEUoBfVSzzZgOElpGnPG?=
 =?us-ascii?Q?x8IROodBDbukHBlGqT0pXgflZOyvc7nl7EuCYoSLgvQR6BMCVoBJzNP6Q1Kb?=
 =?us-ascii?Q?iKhzBDqEWfdL+4M40T4Rsq3046gUXnAHyJZYMD9IwlfY3A3XUdyU8ozYBcx3?=
 =?us-ascii?Q?j+6jELKEIvC5Y2F5gRQRn9GF0zChUKRr4vae+/pMwYIATxksb4c0C6qYJnt8?=
 =?us-ascii?Q?96DvY+MGSYBUJtsdzxaAyTx/kvXuZoUHutPwhHiAMtCLvG3iFMggwQcZytwX?=
 =?us-ascii?Q?R8ZrRlvCgioPDByN5W5zUOP1OxPdJ6yhwJ5Z+VEr2F2LxBSMqkS7+ey9FvIe?=
 =?us-ascii?Q?AyVQB9MHu+UcK73y5xJ6kuvC1owT8ek9jcUwGOJv3Na6f6A2Nu/hVkr3R2mm?=
 =?us-ascii?Q?UUgePdpnwSNvSz6j1YLo4hANu3g/xBrktdD2zvjXbKNJhLJ44jTOLfS3XB/Q?=
 =?us-ascii?Q?7qvOH1C59Z6bGORbKDaDJItIJg4JVRb2ZeIoYwY6QvOvAeb+jsLiF1xbB18h?=
 =?us-ascii?Q?xlhxGSs3NAbUAUC1FvttrA4z54DRmkYWf0Oe612Z20Bq/pNsSS4ABW+zRins?=
 =?us-ascii?Q?frGB0P/dzqshOWLxik9PQDkLCRhhx8On/KQ8aXJ667svUmQuuA9lPwjdrdoP?=
 =?us-ascii?Q?pahku/SQSN9ATydRMDcn131yjtv4a7CTKfjsWhfgS11Wmj+CCMqzBnqNoPx4?=
 =?us-ascii?Q?3Yg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mKN692owGirLvk//k2YUYviBp8JgPbuLsHC7B4FAhevz1qDXgnNHbsb4ZSSu?=
 =?us-ascii?Q?QhnvvaCAavK7nuz5p5Afqi22z/mAj8AJDL3omurrPKdOVLdR0Ds3RPTqYk6D?=
 =?us-ascii?Q?S2gdmhzrVrZC6S3NU1RwdpWJhHMl5Aq4uqqXHUoXOU5rMZGO0OvpVJy4fKDR?=
 =?us-ascii?Q?cWZlG/hCP3P0N6T3qsMJovIceYpnoL1awAJ5BhZoTDzmxhW7AUXW3m8h2uWZ?=
 =?us-ascii?Q?pL4BLs+5DdKZvwEFDJgVgx+/HLe4SeNLJ+EzBh14Pu5jra/TPTjM/WX6yPEk?=
 =?us-ascii?Q?dXCQvpO9Gj8LLa0jiTevivvSIt9a/QfSN4+AICh3lexWL0B/Qdb9B+cXQ9CS?=
 =?us-ascii?Q?kql8dPR8Qjvopy/O4zQq5Yj85V67vzvRJRxaeTGY9IuBjN4UBWHJZMqX2oPJ?=
 =?us-ascii?Q?L/I9MH2VduI121whqu868JylefeqyBzNxq3/UYyj90zEVw8iqbZfUHGl6lYB?=
 =?us-ascii?Q?eKx6TICUh6kHM5Snouu2BloWnzYioWFLaMO+jE/afAb5D1ZPfFqyfBJYmZ2k?=
 =?us-ascii?Q?O+6m5/Ndb2AU+RBxCDDylA8O3QAzRIkumTsL8lm8RT9afIIHTgq2fwRI2peC?=
 =?us-ascii?Q?YzSWNmCukgVA6dKJLj9VaOWf99IQWh432bvukXY/u38RnnPiTWqudTqkcoiR?=
 =?us-ascii?Q?lOI2BxY/Jm2ckacTqKc3sjfADbKUy2YYZxSTquFRRZ0ilRwXlQ4pKjmbe0UB?=
 =?us-ascii?Q?PNSZs+TUE3fSCLbpDyPY5P80nGJda5JU58sU8m8iW9caIX5IeCeKst//aoyV?=
 =?us-ascii?Q?ZBvMIRNAEs4Q40t3i4oaXVxQFZ1ySw0iroNIPlTDYiLkJ5WnU0Cl9l5rX7Ow?=
 =?us-ascii?Q?uHSqNvyPLlW98x+9W06po3waZEpo3aIqaPLT+4vUT61zfhVux/QnG25ES/Zp?=
 =?us-ascii?Q?pKKtkjzs5eNaN7dO12DOz6ZbZ8JY2NZxxjRq6SAXZTxX+Bo5/QhvJowipAVw?=
 =?us-ascii?Q?7EFIIvQYGkkgvYw/kKe1fRktJ9XyoJnoTDQGO9ly+n1cM/o2S0C9hBplWtA+?=
 =?us-ascii?Q?/cpUnoTy0czTm1ZaVbQNueCBZWzkthjeHvk0MXB0r3Qu+je3Zy4sPkQcsQ3P?=
 =?us-ascii?Q?0UPFqwoTD0DS6WMCoVK3REkA3ec3nON2Zqq0m48yz+tah2zWrL/9ra90ZytI?=
 =?us-ascii?Q?MbO4SCKxN7Zr8MKp930DhVXUz73U2SI2kwwuL984hThHRXE7vrD05G6kwZhy?=
 =?us-ascii?Q?/4b9R0SlRZMdDyf0Pxkv0gIvjNxJ59qp8wxgxAr3Ft9Uyp4dLQa6DqORpU3s?=
 =?us-ascii?Q?bLK16kCC/2N35d+C9pg9vK9qK8G856ZvamX09n5/FHOBqzqVfw7bfVHzPjiU?=
 =?us-ascii?Q?WcjsBEMSjOxaXCo0rChv0DlCkPB9qMkG510hr/x4UxnI8BJ6jdieY+Zvqusj?=
 =?us-ascii?Q?jcZSf64HRh/0a7FCGAhtv6wlBbEtbz5jrIr0U1ad+MC/by9ztdV95aqc2Aip?=
 =?us-ascii?Q?mghi6ZXcuFlFZ5PQPj6lFhlLbiILVE5mJqrSybB/aGKWIzYFMUuIZfVVtWtR?=
 =?us-ascii?Q?BJVTwxDELpeIGXTi3mUkuL3ItW0k++IaN1cuLaFoB9lH99OA4RIUsZ0EqgKL?=
 =?us-ascii?Q?GzEFeKtnsC7E6NldzDeqrn4qPL1vggJxGV0+/7Gy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b9a4ff2-181f-4188-867b-08dcb1e4d9a6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 04:46:04.6111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJBzKcxYpRDdiWkvBi6gqZo0ZrDBtR51lRf1op2kXd6ugd9bPRlbLNePp1BGMcCwQRSaOgYgTJUGwt5eK6XNDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4965
X-OriginatorOrg: intel.com

Hi Usama,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Usama-Arif/Revert-memcg-remove-mem_cgroup_uncharge_list/20240730-223949
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240730125346.1580150-6-usamaarif642%40gmail.com
patch subject: [PATCH 5/6] mm: add selftests to split_huge_page() to verify unmap/zap of zero pages
:::::: branch date: 32 hours ago
:::::: commit date: 32 hours ago
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240801/202408010618.lgnamdZd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202408010618.lgnamdZd-lkp@intel.com/

All warnings (new ones prefixed by >>):

   vm_util.c: In function 'rss_anon':
>> vm_util.c:188:41: warning: format '%ld' expects argument of type 'long int *', but argument 3 has type 'uint64_t *' {aka 'long long unsigned int *'} [-Wformat=]
     188 |         if (sscanf(buffer, "RssAnon:%10ld kB", &rss_anon) != 1)
         |                                     ~~~~^      ~~~~~~~~~
         |                                         |      |
         |                                         |      uint64_t * {aka long long unsigned int *}
         |                                         long int *
         |                                     %10lld


vim +188 tools/testing/selftests/mm/vm_util.c

642bc52aed9c99 tools/testing/selftests/vm/vm_util.c Muhammad Usama Anjum 2022-04-28  174  
15bd39f288be91 tools/testing/selftests/mm/vm_util.c Alexander Zhu        2024-07-30  175  uint64_t rss_anon(void)
15bd39f288be91 tools/testing/selftests/mm/vm_util.c Alexander Zhu        2024-07-30  176  {
15bd39f288be91 tools/testing/selftests/mm/vm_util.c Alexander Zhu        2024-07-30  177  	uint64_t rss_anon = 0;
15bd39f288be91 tools/testing/selftests/mm/vm_util.c Alexander Zhu        2024-07-30  178  	FILE *fp;
15bd39f288be91 tools/testing/selftests/mm/vm_util.c Alexander Zhu        2024-07-30  179  	char buffer[MAX_LINE_LENGTH];
15bd39f288be91 tools/testing/selftests/mm/vm_util.c Alexander Zhu        2024-07-30  180  
15bd39f288be91 tools/testing/selftests/mm/vm_util.c Alexander Zhu        2024-07-30  181  	fp = fopen(STATUS_FILE_PATH, "r");
15bd39f288be91 tools/testing/selftests/mm/vm_util.c Alexander Zhu        2024-07-30  182  	if (!fp)
15bd39f288be91 tools/testing/selftests/mm/vm_util.c Alexander Zhu        2024-07-30  183  		ksft_exit_fail_msg("%s: Failed to open file %s\n", __func__, STATUS_FILE_PATH);
15bd39f288be91 tools/testing/selftests/mm/vm_util.c Alexander Zhu        2024-07-30  184  
15bd39f288be91 tools/testing/selftests/mm/vm_util.c Alexander Zhu        2024-07-30  185  	if (!check_for_pattern(fp, "RssAnon:", buffer, sizeof(buffer)))
15bd39f288be91 tools/testing/selftests/mm/vm_util.c Alexander Zhu        2024-07-30  186  		goto err_out;
15bd39f288be91 tools/testing/selftests/mm/vm_util.c Alexander Zhu        2024-07-30  187  
15bd39f288be91 tools/testing/selftests/mm/vm_util.c Alexander Zhu        2024-07-30 @188  	if (sscanf(buffer, "RssAnon:%10ld kB", &rss_anon) != 1)
15bd39f288be91 tools/testing/selftests/mm/vm_util.c Alexander Zhu        2024-07-30  189  		ksft_exit_fail_msg("Reading status error\n");
15bd39f288be91 tools/testing/selftests/mm/vm_util.c Alexander Zhu        2024-07-30  190  
15bd39f288be91 tools/testing/selftests/mm/vm_util.c Alexander Zhu        2024-07-30  191  err_out:
15bd39f288be91 tools/testing/selftests/mm/vm_util.c Alexander Zhu        2024-07-30  192  	fclose(fp);
15bd39f288be91 tools/testing/selftests/mm/vm_util.c Alexander Zhu        2024-07-30  193  	return rss_anon;
15bd39f288be91 tools/testing/selftests/mm/vm_util.c Alexander Zhu        2024-07-30  194  }
15bd39f288be91 tools/testing/selftests/mm/vm_util.c Alexander Zhu        2024-07-30  195  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


