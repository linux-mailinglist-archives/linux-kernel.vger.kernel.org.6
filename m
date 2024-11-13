Return-Path: <linux-kernel+bounces-407744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4099B9C72AD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C539C1F219E9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD390200CAE;
	Wed, 13 Nov 2024 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F/AQ49D+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8909C200C82
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731506839; cv=fail; b=OgtpjMAkzBB4r3um1zSe9TllUEEpn+9lWZbLHWCTM+LjtoS+1N6SNpvw5oYaKCmhvk6hBsBIK2Dpuyxzb7uMhfF9BbWrhGc4VWZDN0giGzG5X4oJQVpxEcd3cZSc1wGeqwDUkq/28wjP2cHlCs0i5AMLON2hfRu2O9sf2exyTHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731506839; c=relaxed/simple;
	bh=UuegM7QOTetEOmg3iduiwfKkFKC477WX6+D+FjxxbGE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=tJDk9uKw6qK9fzIqfmATNoZbr99dRV/G+Rms1ZUFAJaC8M9BafwZ4eZQ0YWtEYDLXoax4xRuAHxkF31oPtKI1Ar1A6J7Tu3iGxhaQJgYlnYd8ofWsfomtKmVH22M4YXPklvV8lydpssdxj4JFPk57xscjcZAj5H6L1hU4ug4AQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F/AQ49D+; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731506837; x=1763042837;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UuegM7QOTetEOmg3iduiwfKkFKC477WX6+D+FjxxbGE=;
  b=F/AQ49D+cJV9A6UJbT28DpymPN5tazTlFvNs6aGIxVdxHLfpCk7PJS30
   JQWXEs5dbQahPVSVKw+koWT1zeImRFLbxLcvA/tERgU4KrC/pFkxvJolr
   Tr4eCPiKw2IdXf7dk7tZ+Nu483fPmmLuSuYPP1s53mp6vKAJUvgWjP63E
   7m7VAQ7KBsKxHaB3CWNeQytSNXHzQjcdAfR1cx67SSvUZzahM2kkFjQyw
   a7YsmgUXZYHiRXcFdasO1D4ZJWBMVuEEM75OTAQ23mw+w34M70LhyS1DI
   vY6m6dD0n4qM1ItetEwa2buD3xSA576LqtA+Rgf5byVpAXPPgywdr+jSf
   A==;
X-CSE-ConnectionGUID: IMlH7OyTTI6N3kHL7kcBew==
X-CSE-MsgGUID: 6Hje8aBkRkuMbRjApBIlrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="42808541"
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="42808541"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 06:07:14 -0800
X-CSE-ConnectionGUID: NDzsOI23QE2kV9WHvinbuQ==
X-CSE-MsgGUID: QTysrjtLQbWjLmlMqhRv4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="87874243"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2024 06:07:14 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 13 Nov 2024 06:07:13 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 13 Nov 2024 06:07:13 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 13 Nov 2024 06:07:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKq3UNsG0o9oyw4XG/2evKyXNI29aMtJ8nIF52N0/m7af73G5teBr/4t4oSb0Je8e6DGqCBVP8HDOlJOzNGFWRji5fO8ZYE1OdAt/sq9lYEDu3kZzHc8Xcr+1HvMK0TIw6NLaluW6o3XPatW6tWsF/Ynra3I1wkUJTT9uV0bVD0eIqZseXvPA++ikioi2WWM8y3KGnNH+h6xNlilS0/c5E8mT4FtJN7B6GRo3aJ4zCsguwFXQQjh+882cEjjYX/+xdavWtWi9iOC4Cvzv6wU7CyFLEsdSgogUXHX73lr6TD/KBMEPVJ/oVsE7aDLCFc/K18rKE3respFRSlWIzl6jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Morgqi6/m7Q+qxizJuegkTtuxcv2kh00W8j8dGB1Yb4=;
 b=u0VqM+xEfXNRc6yVIh/9wXwe8VBNSdSUPRg5sQQtie1Qt2hCqXDT1jOBBAcVObRFx3UF2Vrj297Ez8LzRmOsU35oBrI3aA8DiQHxX5D1pRKT30NZTOQArSqrJRYqbilGuC26DyYRjKVd8isuT/NPYRch1oqrwSVCA6hsPII7gvAvppdZtDVqhXfaRqAHHgkQtMrlSAqI+tzs8/MsPdyjphPFEGr9HCHdzqsif1va4liXmuZubnHWaUIoGwwwQ84Un/pQ9eOOjZle3QZO/Y8L0+Rqy+47SGyyvOf70P/HSNWofB+uMbsgl4hjYyWXsRh2eyrg0r9v6C10LCBQDAA8Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS7PR11MB5967.namprd11.prod.outlook.com (2603:10b6:8:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 14:06:57 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 14:06:57 +0000
Date: Wed, 13 Nov 2024 22:06:38 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Suren Baghdasaryan <surenb@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov
	<bp@alien8.de>, Christoph Hellwig <hch@infradead.org>, Daniel Gomez
	<da.gomez@samsung.com>, David Hildenbrand <david@redhat.com>, Davidlohr Bueso
	<dave@stgolabs.net>, David Rientjes <rientjes@google.com>, Dennis Zhou
	<dennis@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, John Hubbard
	<jhubbard@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Joonsoo Kim
	<iamjoonsoo.kim@lge.com>, Kalesh Singh <kaleshsingh@google.com>, Kees Cook
	<keescook@chromium.org>, Kent Overstreet <kent.overstreet@linux.dev>, "Liam
 R. Howlett" <Liam.Howlett@oracle.com>, Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, "Mike
 Rapoport" <rppt@kernel.org>, Minchan Kim <minchan@google.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, Sami Tolvanen
	<samitolvanen@google.com>, Sourav Panda <souravpanda@google.com>, Steven
 Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Thomas
 Huth <thuth@redhat.com>, Uladzislau Rezki <urezki@gmail.com>, Vlastimil Babka
	<vbabka@suse.cz>, Xiongwei Song <xiongwei.song@windriver.com>, Yu Zhao
	<yuzhao@google.com>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [alloc_tag]  0f9b685626:
 BUG:KASAN:vmalloc-out-of-bounds_in_move_module
Message-ID: <202411132111.6a221562-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG3P274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::21)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS7PR11MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: 89e6bf29-0b47-417a-75af-08dd03ec6f63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V1okDt6T3IQBO9qnQIx6ok14AC1eD0N6zwfjQ1NjDW54WFcBOKjCiH+QGoHy?=
 =?us-ascii?Q?OHxNG986r+K0P7BdsdrEoB1Jdm76fq4jzlmz5/w7zo+vTc7+OZk1bYwPqZeR?=
 =?us-ascii?Q?gb4xJ693sS3oYgyvDUeXcowLLAwShOzIpTA4e402UAFVW9dDE+Glp5G7H7y+?=
 =?us-ascii?Q?FX2SMWesv0OrOxqWa0yB58g/EtOdQgSyZ3Xb1OZ9f2dXnhRtLabI9MeHVPhn?=
 =?us-ascii?Q?SuDV/eM/ydtkIGBpAvO3BA2/XirF9DJuqi2l9T+BuQuMEf+b9m+p5NTujehp?=
 =?us-ascii?Q?xu/s0UaWOnsUrmCnE7XdqTfMUOpkCY6VmFqJNxUO4kYNy3MVfVABTKjIyXW0?=
 =?us-ascii?Q?kS/0BFibI70fe3oUEGBY0L4zQ5v0IDpRJbN10wajcuxquGnhjzWLK/U4PZqv?=
 =?us-ascii?Q?cXo7V8fN2yuBH7ZJ5gPnBoUouuun3CYIjhtnSj9hGrou11SlJnuDsK4wnxmG?=
 =?us-ascii?Q?lERpRD3/gJoEII0OrfJ6poqM5r2dPpxgu9v0kflWDw2S55Xb/kkOYVpcjyqJ?=
 =?us-ascii?Q?h44GVuI4huEDStL2lTkDkvbQB7sURu5pKxTXaN7jWtII/2unLJAUiwKET0Nx?=
 =?us-ascii?Q?WuDEbMx5S992hTtRu9F0i8vevSjIVjafNO3ioziydBpeJbhFihCHcDis0X2p?=
 =?us-ascii?Q?O2qW5+m1yxsO2lMacXEuxNDfr9WvHvoA60V3Vx1KI8xzU1URguNjdNEv7nIg?=
 =?us-ascii?Q?9SgSHKjXH+ojhP6k9TVDwC/KSRluAa96JVH5tcAhTqOj0JDadNsuJrQhiG/g?=
 =?us-ascii?Q?wztHs2hUriilx3p3Op0aGNez0QUNhyjQfy415s2T1TTVuQ4M0uTNHa1rb92/?=
 =?us-ascii?Q?tXmJmMSDDJUaWfKURaQ9HbCsh+vr0g7UutNoZjdZYm+Ocw6ObfNuAWmMAah3?=
 =?us-ascii?Q?+4sisvO4N9zkaitKu+iXApZJLwr73ulbalZd5yhL85drqulCRjIIq0rhhf+u?=
 =?us-ascii?Q?Em5o4kCXlY4zC3nuMxgRgTh64vFt89DMuDF2jjm1uqaO1R2lzclyLpZbZ9gC?=
 =?us-ascii?Q?iMirvSPxrkJOWv7t7Xgm9tJy14eqPyW0X9M7h2j6j0u3YWlcJkPnzdsG7l6O?=
 =?us-ascii?Q?2NYPyaUxBn/p8qegLzToBTHjLn4P4zy4lyWJIfmJy7e6loLoUnY3qj+WkQCJ?=
 =?us-ascii?Q?Hj0ZLK94GLq/ahonTgCv2e/KVmng9V9si50q/UXKm59FebZyx4PxQQv2eb2M?=
 =?us-ascii?Q?/rrpDjmijT58btjdf6gPAJyvejore5Hki0ffzpAsVXCytQxw6EFZwBF2QAah?=
 =?us-ascii?Q?nEsWw93qk7ZYvoS0jNosceybWNzDE9h1f9kCOjhXpw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0K0lnDTHJKt4MaLBGqJtSWPyODD4W1p1AgxINowjkXS0Ijhxjxtau6Wl6h/4?=
 =?us-ascii?Q?vDcPu048nYpodfFXN5Tkv7o2cAtREyuFy6tRFeo2cdiYiJwbZgnXLpdmYaIZ?=
 =?us-ascii?Q?37/dlV4u1UW5a+Dx1TIrK41fGe9t+S8RuzGToxXc4qCtrDLs2cefazXezC3g?=
 =?us-ascii?Q?JiHy0cD8oAvU+bhhL3sl1sAjpGEPchbzSYMwQeG45W13T0CvI+rriqx1mYW6?=
 =?us-ascii?Q?BAbp+PBtKvirUx/HXo58WfJRIrENtyTjCRbubSk9hUqQzU89VLs6xm3CozAo?=
 =?us-ascii?Q?JyXXLbxRWwf8LJh5iX/Q6hs1FuUhi8znX39gfNbPs5u8wjFnv1G5hIIq0cUc?=
 =?us-ascii?Q?7AkEeIyGwhYAHlwcAxXUIpQzxIUF3s7h7W35uULWSKekCYAwl1cDKmCsR3zg?=
 =?us-ascii?Q?TBTGdMkUlarRWvPC2MXHmwQgZEgT9ZFZCkNnsv/5N2FFDJZ7y121pa1cTpaC?=
 =?us-ascii?Q?IZiKOibaWeSfm7giUaHrJznk5xDKrnyKaSLSDheCsmbonjIuqqKSzxmxXxcK?=
 =?us-ascii?Q?0s7FNczQrOIl0RTU701sw40HW8InhSvb/SaQjj+AopKzGlGyLV4sNSHsC3mk?=
 =?us-ascii?Q?EQrajUgJ2bh3Wud/2d8eCgOVExv5t+hgWGd0Q9iT9sw0rk3ROECCJVP2cn4p?=
 =?us-ascii?Q?frCeuq456ZgLVR8LmR7MbICiyPc2DsHYUk3JLMmEpqeATH7Ld6YF5W9evqXx?=
 =?us-ascii?Q?Bd7mTc+mCzvmyU7r34Ea/RU1kLkJwnw+teACDcQxXvavAypUx+1gfofakKpX?=
 =?us-ascii?Q?YvnXZLrx5e7NO8ubTQusTZfTlHZ2qQIcVyV0SmaB86gQGJjelttJ52A7dm4+?=
 =?us-ascii?Q?+HgbbEwGVGDUxLlvDOqkAu7jQWKoZzybF9H/GbxerKQezLTMa1VuCbfY3SaW?=
 =?us-ascii?Q?93mcKwLqzXgTuAMUmFC05NhVaJY9oMl/v6m2NIJEs6uK4T20jJ8RZumxhmUH?=
 =?us-ascii?Q?I8VLd8Daym0Y4VWQb45y5i+38JoQ51PhFJzAQLcS7B61U6k5O2JEgQx4kN0e?=
 =?us-ascii?Q?t3GAC4RvY1+Jc6twgyMBktQrWVwDdLWhLwALToRSN0xmmwehSXk9Qd0HnGmg?=
 =?us-ascii?Q?vPqLvPwatnKhFt20lh5O6IYKhaXbV7x0C6FZIep3SnztohsGj3VB9hz17qwF?=
 =?us-ascii?Q?y0pgVJTnzKNRjrIXfzyctkDU2X3p0X0jFI1EcjBIB59E+fvAAovhIzxaGrOT?=
 =?us-ascii?Q?tvZ4/vUSF4hwicEd2uzw7XAQ8j+1b9EvmYpSFtx1V+LIZ9uIIPW2z8lmi3S+?=
 =?us-ascii?Q?V0VKZ5ky9DYwp6MSpydREGzo1uDn/aGODHUQVD/anY7bD948lPRNjhl6/UHS?=
 =?us-ascii?Q?3H0NajehDLZ5rWKWgPgOdh8ekeOeN48aWwEAq7E5ky793ncHMird64Wsdptj?=
 =?us-ascii?Q?IzsyugMSdEMK+s5P+2SdO/J6z7iz5jWJzjJXs82ACylBw/2CUXLUm6smSnKV?=
 =?us-ascii?Q?fyDXJR8PzI0AoVAXq5EDMyz7WpjlXiBI1yRw9tr61hBk0mUB6rJAXaZHk0wA?=
 =?us-ascii?Q?jAXF5DeVVSDxrEM19Nd/h31DE52exsV0L088e8zU/GXDBo/PK1jDIcZEwQdS?=
 =?us-ascii?Q?zQLRcRFWpiR21TYT4xEGnaM5A2xaF6t8Yhnq7QnEww74244WsDoNcHn81sTV?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e6bf29-0b47-417a-75af-08dd03ec6f63
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 14:06:57.6184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYqqpAjT75Q9nPcHN4xRUXHzR/udlAZAllXIF+gXjZF1D8bTMyH+ZsS+MGV+uvIN6DIBWWuumG4LYyQjLDWdfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5967
X-OriginatorOrg: intel.com



Hello,


we reported
"[linux-next:master] [alloc_tag]  a9c60bb0d0: BUG:KASAN:vmalloc-out-of-bounds_in_load_module"
in
https://lore.kernel.org/all/202410281441.216670ac-lkp@intel.com/

we noticed it seems there is following patch.

we made below report just FYI that the commit still cause similar issue on
linux-next/master and not fixed on tip of linux-next/master when this bisect
is done.


kernel test robot noticed "BUG:KASAN:vmalloc-out-of-bounds_in_move_module" on:

commit: 0f9b685626daa2f8e19a9788625c9b624c223e45 ("alloc_tag: populate memory for module tags as needed")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 929beafbe7acce3267c06115e13e03ff6e50548a]

in testcase: rcuscale
version: 
with following parameters:

	runtime: 300s
	scale_type: srcu



config: x86_64-randconfig-014-20241107
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------------+------------+------------+
|                                                | 0db6f8d782 | 0f9b685626 |
+------------------------------------------------+------------+------------+
| boot_successes                                 | 18         | 0          |
| boot_failures                                  | 0          | 18         |
| BUG:KASAN:vmalloc-out-of-bounds_in_move_module | 0          | 18         |
| BUG:unable_to_handle_page_fault_for_address    | 0          | 18         |
| Oops                                           | 0          | 18         |
| RIP:kasan_metadata_fetch_row                   | 0          | 18         |
| Kernel_panic-not_syncing:Fatal_exception       | 0          | 18         |
+------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202411132111.6a221562-lkp@intel.com


[ 153.897376][ T402] BUG: KASAN: vmalloc-out-of-bounds in move_module (kernel/module/main.c:2357) 
[  153.899141][  T402] Write of size 40 at addr ffffffffa0000000 by task modprobe/402
[  153.900837][  T402]
[  153.901496][  T402] CPU: 0 UID: 0 PID: 402 Comm: modprobe Tainted: G                T  6.12.0-rc6-00146-g0f9b685626da #1 87c8486a909ba2f90eff061a4c9c1fa5c9cd90ea
[  153.904537][  T402] Tainted: [T]=RANDSTRUCT
[  153.905500][  T402] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  153.907702][  T402] Call Trace:
[  153.908510][  T402]  <TASK>
[ 153.909241][ T402] print_address_description+0x65/0x2fa 
[ 153.910663][ T402] print_report (mm/kasan/report.c:489) 
[ 153.911771][ T402] ? move_module (kernel/module/main.c:2357) 
[ 153.912825][ T402] kasan_report (mm/kasan/report.c:603) 
[ 153.913821][ T402] ? move_module (kernel/module/main.c:2357) 
[ 153.914904][ T402] kasan_check_range (mm/kasan/generic.c:183 mm/kasan/generic.c:189) 
[ 153.916029][ T402] __asan_memcpy (mm/kasan/shadow.c:105 (discriminator 1)) 
[ 153.917057][ T402] move_module (kernel/module/main.c:2357) 
[ 153.918071][ T402] layout_and_allocate+0x446/0x523 
[ 153.919459][ T402] load_module (kernel/module/main.c:2985) 
[ 153.920457][ T402] ? mode_strip_umask (fs/namei.c:3248) 
[ 153.921557][ T402] init_module_from_file (kernel/module/main.c:3266) 
[ 153.922825][ T402] ? __ia32_sys_init_module (kernel/module/main.c:3266) 
[ 153.923992][ T402] ? __lock_release+0x106/0x38c 
[ 153.925173][ T402] ? idempotent_init_module (kernel/module/main.c:3301) 
[ 153.926364][ T402] ? lock_release (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5848) 
[ 153.944053][ T402] idempotent_init_module (kernel/module/main.c:3302) 
[ 153.945164][ T402] ? init_module_from_file (kernel/module/main.c:3294) 
[ 153.946268][ T402] ? security_capable (security/security.c:1143) 
[ 153.947421][ T402] __do_sys_finit_module (include/linux/file.h:68 kernel/module/main.c:3330) 
[ 153.948495][ T402] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[ 153.949540][ T402] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[  153.950855][  T402] RIP: 0033:0x7f0f37df7719
[ 153.951869][ T402] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 06 0d 00 f7 d8 64 89 01 48
All code
========
   0:	08 89 e8 5b 5d c3    	or     %cl,-0x3ca2a418(%rcx)
   6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   d:	00 00 00 
  10:	90                   	nop
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 8b 0d b7 06 0d 00 	mov    0xd06b7(%rip),%rcx        # 0xd06f1
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret
   9:	48 8b 0d b7 06 0d 00 	mov    0xd06b7(%rip),%rcx        # 0xd06c7
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
[  153.955810][  T402] RSP: 002b:00007ffccd7f7198 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  153.957666][  T402] RAX: ffffffffffffffda RBX: 000055cc9f9fddd0 RCX: 00007f0f37df7719
[  153.959411][  T402] RDX: 0000000000000000 RSI: 000055cc9f9f24a0 RDI: 0000000000000004
[  153.961142][  T402] RBP: 000055cc9f9f24a0 R08: 0000000000000000 R09: 000055cc9f9ff250
[  153.962910][  T402] R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000040000
[  153.964665][  T402] R13: 0000000000000000 R14: 000055cc9f9fdd80 R15: 0000000000000000
[  153.966393][  T402]  </TASK>
[  153.967209][  T402]
[  153.967856][  T402] Memory state around the buggy address:
[  153.969123][  T402] BUG: unable to handle page fault for address: fffffbfff3ffffe0
[  153.970807][  T402] #PF: supervisor read access in kernel mode
[  153.972036][  T402] #PF: error_code(0x0000) - not-present page
[  153.973220][  T402] PGD 417fdb067 P4D 417fdb067 PUD 417fd7067 PMD 0
[  153.974560][  T402] Oops: Oops: 0000 [#1] PREEMPT KASAN
[  153.975758][  T402] CPU: 0 UID: 0 PID: 402 Comm: modprobe Tainted: G                T  6.12.0-rc6-00146-g0f9b685626da #1 87c8486a909ba2f90eff061a4c9c1fa5c9cd90ea
[  153.978853][  T402] Tainted: [T]=RANDSTRUCT
[  153.979851][  T402] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 153.982008][ T402] RIP: 0010:kasan_metadata_fetch_row (mm/kasan/report_generic.c:186) 
[ 153.983368][ T402] Code: 40 08 48 89 43 58 5b 31 c0 31 d2 31 c9 31 f6 31 ff c3 cc cc cc cc 66 0f 1f 00 b8 ff ff 37 00 48 c1 ee 03 48 c1 e0 2a 48 01 c6 <48> 8b 06 48 89 07 48 8b 46 08 48 89 47 08 31 c0 31 f6 31 ff c3 cc
All code
========
   0:	40 08 48 89          	rex or %cl,-0x77(%rax)
   4:	43 58                	rex.XB pop %r8
   6:	5b                   	pop    %rbx
   7:	31 c0                	xor    %eax,%eax
   9:	31 d2                	xor    %edx,%edx
   b:	31 c9                	xor    %ecx,%ecx
   d:	31 f6                	xor    %esi,%esi
   f:	31 ff                	xor    %edi,%edi
  11:	c3                   	ret
  12:	cc                   	int3
  13:	cc                   	int3
  14:	cc                   	int3
  15:	cc                   	int3
  16:	66 0f 1f 00          	nopw   (%rax)
  1a:	b8 ff ff 37 00       	mov    $0x37ffff,%eax
  1f:	48 c1 ee 03          	shr    $0x3,%rsi
  23:	48 c1 e0 2a          	shl    $0x2a,%rax
  27:	48 01 c6             	add    %rax,%rsi
  2a:*	48 8b 06             	mov    (%rsi),%rax		<-- trapping instruction
  2d:	48 89 07             	mov    %rax,(%rdi)
  30:	48 8b 46 08          	mov    0x8(%rsi),%rax
  34:	48 89 47 08          	mov    %rax,0x8(%rdi)
  38:	31 c0                	xor    %eax,%eax
  3a:	31 f6                	xor    %esi,%esi
  3c:	31 ff                	xor    %edi,%edi
  3e:	c3                   	ret
  3f:	cc                   	int3

Code starting with the faulting instruction
===========================================
   0:	48 8b 06             	mov    (%rsi),%rax
   3:	48 89 07             	mov    %rax,(%rdi)
   6:	48 8b 46 08          	mov    0x8(%rsi),%rax
   a:	48 89 47 08          	mov    %rax,0x8(%rdi)
   e:	31 c0                	xor    %eax,%eax
  10:	31 f6                	xor    %esi,%esi
  12:	31 ff                	xor    %edi,%edi
  14:	c3                   	ret
  15:	cc                   	int3
[  153.987254][  T402] RSP: 0018:ffffc9000218f9f8 EFLAGS: 00010082
[  153.988595][  T402] RAX: dffffc0000000000 RBX: ffffffff9fffff00 RCX: 0000000000000000
[  153.990325][  T402] RDX: 0000000000000000 RSI: fffffbfff3ffffe0 RDI: ffffc9000218fa04
[  153.992086][  T402] RBP: 00000000fffffffe R08: 0000000000000000 R09: 0000000000000000
[  153.993786][  T402] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffffa0000000
[  153.995554][  T402] R13: ffffffff864b4994 R14: ffffffff9fffff80 R15: 0000000000000028
[  153.997305][  T402] FS:  00007f0f37cf5040(0000) GS:ffffffff86989000(0000) knlGS:0000000000000000
[  153.999133][  T402] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  154.000578][  T402] CR2: fffffbfff3ffffe0 CR3: 0000000128853000 CR4: 00000000000006b0
[  154.002367][  T402] Call Trace:
[  154.003318][  T402]  <TASK>
[ 154.004087][ T402] ? __die_body (arch/x86/kernel/dumpstack.c:421) 
[ 154.005074][ T402] ? page_fault_oops (arch/x86/mm/fault.c:710) 
[ 154.006242][ T402] ? show_fault_oops (arch/x86/mm/fault.c:643) 
[ 154.007368][ T402] ? search_module_extables (kernel/module/main.c:3369) 
[ 154.008525][ T402] ? fixup_exception (arch/x86/mm/extable.c:321) 
[ 154.009629][ T402] ? exc_page_fault (arch/x86/mm/fault.c:1479 arch/x86/mm/fault.c:1539) 
[ 154.010771][ T402] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623) 
[ 154.011853][ T402] ? kasan_metadata_fetch_row (mm/kasan/report_generic.c:186) 
[ 154.013072][ T402] print_report (mm/kasan/report.c:466 mm/kasan/report.c:489) 
[ 154.014122][ T402] ? move_module (kernel/module/main.c:2357) 
[ 154.015238][ T402] kasan_report (mm/kasan/report.c:603) 
[ 154.016231][ T402] ? move_module (kernel/module/main.c:2357) 
[ 154.017255][ T402] kasan_check_range (mm/kasan/generic.c:183 mm/kasan/generic.c:189) 
[ 154.018379][ T402] __asan_memcpy (mm/kasan/shadow.c:105 (discriminator 1)) 
[ 154.019400][ T402] move_module (kernel/module/main.c:2357) 
[ 154.020435][ T402] layout_and_allocate+0x446/0x523 
[ 154.021792][ T402] load_module (kernel/module/main.c:2985) 
[ 154.022822][ T402] ? mode_strip_umask (fs/namei.c:3248) 
[ 154.023928][ T402] init_module_from_file (kernel/module/main.c:3266) 
[ 154.025069][ T402] ? __ia32_sys_init_module (kernel/module/main.c:3266) 
[ 154.026265][ T402] ? __lock_release+0x106/0x38c 
[ 154.027496][ T402] ? idempotent_init_module (kernel/module/main.c:3301) 
[ 154.028688][ T402] ? lock_release (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5848) 
[ 154.029766][ T402] idempotent_init_module (kernel/module/main.c:3302) 
[ 154.030985][ T402] ? init_module_from_file (kernel/module/main.c:3294) 
[ 154.032192][ T402] ? security_capable (security/security.c:1143) 
[ 154.033310][ T402] __do_sys_finit_module (include/linux/file.h:68 kernel/module/main.c:3330) 
[ 154.034478][ T402] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[ 154.035532][ T402] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[  154.036819][  T402] RIP: 0033:0x7f0f37df7719
[ 154.037865][ T402] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 06 0d 00 f7 d8 64 89 01 48
All code
========
   0:	08 89 e8 5b 5d c3    	or     %cl,-0x3ca2a418(%rcx)
   6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   d:	00 00 00 
  10:	90                   	nop
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 8b 0d b7 06 0d 00 	mov    0xd06b7(%rip),%rcx        # 0xd06f1
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret
   9:	48 8b 0d b7 06 0d 00 	mov    0xd06b7(%rip),%rcx        # 0xd06c7
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241113/202411132111.6a221562-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


