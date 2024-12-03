Return-Path: <linux-kernel+bounces-429214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E3B9E1A80
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A623B2736E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6431E0DFF;
	Tue,  3 Dec 2024 10:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BXsODuKs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1430E1E0DD3
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733220563; cv=fail; b=C4nyEwHJB1t9xzSEJlgC+rrLoGmI/sPrvvLaGiUIW11qA0mIPDGp/7TF/t79fHjBJkQSvNjUmO3DMcU2RARA4M498fu3MxJuY35dPqdPdwlqU4OK84XkfJBGaLor2tvfBZTszbFURLpeVqaLr8mONh5nuy/USCW3KD31Gy1fi2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733220563; c=relaxed/simple;
	bh=i5OxSxtlb2gJH4dvB3iLHAdnMLjn9VvumzDk3AKrWbY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cseCyQh6JWRz8o66xvwdGqaQvEALqGyWUHrtCG5dmAYMhd1VauevW1qULJzDqGHn9zyZAf9F4vPQqwx1D0TgGmxf0prxncpw1HZ7jzQ6Y3ckHs0Wu/OfpjUD1IXFHRoUuivc80bQ8t5akpylbxtoHf1fvb25Y+2tKZgqRaTGY3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BXsODuKs; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733220561; x=1764756561;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=i5OxSxtlb2gJH4dvB3iLHAdnMLjn9VvumzDk3AKrWbY=;
  b=BXsODuKsggG1J+M5cYXoDp4W3zwOwKQD4lscQZ3MpNYsga1ZTHlZZI2T
   4tRGorj3QspnTsSBAaLfjzlTF3dglz6BH07WCFQ5QUNazgVozPF+nL0ce
   3kIbtUaxmVbLBQph01KF3Mu3LbQrDhMg+QDqtluOmPt7LekfZcQ0lGHcM
   zii8BcWdjl/O+IOrC5GwE0gXvqjzI01uEKw3tLYn7o9FzrmxcI09wDZvO
   UVFlSYYsUAKmSpPLHbkyGcbqHbcFrbjNU5Yad9Ar+Gr8Bvr1R+yJvG+N1
   WWF9uUcdMIfZqvbfaiH5pSgHUM+ClNat9pAHFIIz2CzaRsxaXc2ptRNT5
   w==;
X-CSE-ConnectionGUID: NSQH1QReTCCh+B4l+vtSXA==
X-CSE-MsgGUID: W3C9PfgcR9qCABSSm6bGMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="44036001"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="44036001"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 02:09:20 -0800
X-CSE-ConnectionGUID: HOsD5ql7QJ28ApUHcGuurQ==
X-CSE-MsgGUID: 53Fk0f8lQtuflyYcmmHoKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="93848104"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Dec 2024 02:09:20 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Dec 2024 02:09:19 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Dec 2024 02:09:19 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Dec 2024 02:09:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djSsYDdO4k8hCb5T8hm+/6Jiyr/d/oA8IEs58H27rCtR9uEnlLOKolIs2UeZW+p85Gkdc2aYsUS1aiVqTH831VqCxBPHIA6YxUpwbp0R6yQk9fLIaVsi28lzpJXmSEZfFENQ9lgBEXZuR/+R9cxE6Qo1qe3jk6McTIR0oANzMq3qFKbnAgPKicshdYU+cx3SCna5Mk2QpTJUNqSpPOQSG+cvPj7f6my8KN36XPhZ5x12o14qyIOyYg82H0NvCoQf16Y3EXFDoIBsdrT9UKqewCpdtQ4HkLDEwkqVFkEQGzH9okhzgHFzPOr3nXxV28MTTZku7SiTw4bDUtVzjNpvZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdiU+5k0CRTkXPq+pS7QVMPDTiqJM8Dkdl0sWBxXrNw=;
 b=xo1z7+PtHTEV3/mRdEU0CFBhWw2iIftA+eqTL72Q1ZoKrEKdWCj37qZxiM+YhWPvdkNUGZLBtMjgW92xD8wdAT+J8rK7B5h17nB9Fm93jb6dlGCgPrBWQeeRS1CSwtQ7+/P1lTwgJdaKXcHLm2p8tSfZmsuslvvOe8u2fDCIcnav/fHoNLqXfvCpbNi44stSDtTR3bmZcno4JG1tIh/+5gNVyIRKTCaD1zpetD/V+PtyQQAmA5rWg4ga7r1z7dTRck7nypVP+xMSAD2eNynlohXt/nl48CUWB7+uGPPKOZS2+9/r/vKJZT+FdHqGIY42XzbiQG8glxN+JCHp7xc4Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 CY8PR11MB6892.namprd11.prod.outlook.com (2603:10b6:930:5b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.15; Tue, 3 Dec 2024 10:09:17 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 10:09:17 +0000
Date: Tue, 3 Dec 2024 18:06:30 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Baoquan He <bhe@redhat.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, "Kirill A. Shutemov"
	<kirill@shutemov.name>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<x86@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] kexec_core: Accept unaccepted kexec destination addresses
Message-ID: <Z07YJlxK9/piXLhK@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20241021034553.18824-1-yan.y.zhao@intel.com>
 <87frop8r0y.fsf@email.froward.int.ebiederm.org>
 <tpbcun3d4wrnbtsvx3b3hjpdl47f2zuxvx6zqsjoelazdt3eyv@kgqnedtcejta>
 <87cyjq7rjo.fsf@email.froward.int.ebiederm.org>
 <ZxmRkUNmx863Po2U@yzhao56-desk.sh.intel.com>
 <Z0WzHZ+fNn6WuH/E@MiWiFi-R3L-srv>
 <Z0bt4HXAKqM3C1ZW@yzhao56-desk.sh.intel.com>
 <Z0iJ+DTPA2IkVDx7@MiWiFi-R3L-srv>
 <Z0lWkrsXSpDVfW72@yzhao56-desk.sh.intel.com>
 <Z03BbH5PgNrE81dz@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z03BbH5PgNrE81dz@MiWiFi-R3L-srv>
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|CY8PR11MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: 32772069-c170-4058-0eb8-08dd13828c18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NV7XjDBphue9w/t8zrEt/VIlz0D1Oz2WUO6UEn7dC8FW5cYj7UldYlFLWomb?=
 =?us-ascii?Q?WXTkWikCR+Ww7nVzCFeXq9XgU9LkxydBG6G94+fiYfV3hAHYghTto5E1y0Fc?=
 =?us-ascii?Q?Fp//5nXSlgvXl38k1Sss9/frwdKNB03oltYMBW6/BOYm/eJZXwsQBQ0AKudP?=
 =?us-ascii?Q?5CjRVesU/tEjK2+KrUllCB4xMOaocQvJRRXD+WXOs0jHtlA6QvhIwWuIYxnw?=
 =?us-ascii?Q?kWG1xvqZk0sbRoDYrVWZWWaidkDGExVL4iRWUoZOuyg2rqaQDvKcATJZ1ZZ3?=
 =?us-ascii?Q?dgZSk/Dvxul/twibUiPLFMsuRgsyr0irmXO0zAqYqyegDBZF5CN1/Vo3ICR3?=
 =?us-ascii?Q?d98vUTW5buwRli49t/wvnWYixwFiz2fqOROcNivVckrkwCqW3Ah7SJhlN8AQ?=
 =?us-ascii?Q?61sVH6gActHKrUfQJHcXtTUsXNr6xxdf+k5LeZyEgFqvN3IZuClCnmgLqSWN?=
 =?us-ascii?Q?xfEYrf3ykCet25D7LQNwtbBY6FeOFng43vZX2HBp4/tq61XsJwj1dq2OUNv8?=
 =?us-ascii?Q?TPX5hJOlqD4Sfxcqiz2mWJTkrvnDDyY6PxL7KviGQny9rB3jKqOAHv3zYt32?=
 =?us-ascii?Q?xsYhe9Ty2iriLpaJVAs+CqO1/YfoW+HWrhGnAp1igwJINDbYfHWEja6OiAY8?=
 =?us-ascii?Q?eiYhYLeDIKssFIe2xnXiV8NDPbuAhTnxG4InRmNk++iqOCD6HwkLGcqHfyWA?=
 =?us-ascii?Q?pKc0np32vhR4CwiFIv4LUGIraqdBzrX30/kxahicJLsJsIvtW4k6NSTzif/H?=
 =?us-ascii?Q?dOoCweHOPtwrFWkT26LPZ2iY7joM7wkGWjPlL8d5cy21Goymg4Mujsbdvlfl?=
 =?us-ascii?Q?5kFq6LiqBXv7OYUHGOOAOmrPi5Jc1ItaP3DtBw9LNRl6JwN/X19UvA/cpKx9?=
 =?us-ascii?Q?QEc+Rk8URjzyqU06MvPM9xDFA7p6oKkxEgyG2xrP21Fex2bPDswWFueKvsKP?=
 =?us-ascii?Q?H0ErJMv9+ovXJiqmgDyCQ/hVdIh2gLmQUYWTjn3ReX+/H3weiwKbcPZvK1DW?=
 =?us-ascii?Q?xjLxubpUALc8pB2i6oOz7xm8eQIZ81JSBP9w8inihSA7+aXW2/BOsNVGGGdr?=
 =?us-ascii?Q?OenyzYqIHtoUgFTMLB+zlwiNrfbMP55wMLKrUx3RBCmPGhE21c/xEVrurf81?=
 =?us-ascii?Q?xUntCdl+ILIJL04t3jsLJHogk9xJLNKHbhZszbR5ciZtmxnOde+eDHgwk5If?=
 =?us-ascii?Q?Mn/OkDcwJABOM0nZxXDQbqFbyOaZIegBLtDrbBqz+8YmRBCqSGKkWYyL9pgs?=
 =?us-ascii?Q?H9gJDYZkGOEOhLulJQUkV6Ddcl4SF+lJ9sRDLkyiuGvK7/NHfoBXm69BT0Ac?=
 =?us-ascii?Q?hEQ3sSRDwWuy7dAaOrzVDZ5BLurxW0JfaU6pN3tGjG6g1w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mPZ23bwbhPdZ1/18eMqgAMiWe7BV78yMRdF1z2un4p+pfLh4ycBhuBPIxTBE?=
 =?us-ascii?Q?oaNZ6t4gxGjKeWB3D3uM9TVgXJq6urGR4K4BqS61fA2qb88uJGNPoEPFo7Hn?=
 =?us-ascii?Q?sUohiEPUbslKLQS/qTyIhFwhSlAXNuGiDgyb7nPsLN+xUkoC7w9EzjpvYXwF?=
 =?us-ascii?Q?EVVTdn4MYX/4XjeMi9mTZYdVNs77KH27ITNRfhzlgom8TN0hu/HxdQzEZfH/?=
 =?us-ascii?Q?RKfkM+49i1WNVwv3T6QOEXADCrurLWhuWAEdAP9/Fe4aR+vpDfmNE1QyAzOa?=
 =?us-ascii?Q?6/4UTNOVdgWkQGnaMS6/ZZ9pqf1gxog2QcC/pY6xtMjAA+ifbOCH2NvAlSya?=
 =?us-ascii?Q?m5ULDTsadjhEpYH7EI945i0LLZSUN+yBUr3TJCQAoyFstYEvLY2Sas+2yKVW?=
 =?us-ascii?Q?VsQ9c79eGoefaQXxSVENpUQ29/7z7PlENhGj5b4sPKNoneIRMi99ZGkAR5Z7?=
 =?us-ascii?Q?mr773DM+KlwxsgPfcU30WEuEP3ieJlRPPF9dn98hOnCBmkOqrJjTac7ONt6i?=
 =?us-ascii?Q?k/IoYx5l8YQMxbmh465SEDQRjdgSEv+xjDWjSUDZ/FJh/4nP/RWeEWbAMbXi?=
 =?us-ascii?Q?dBa5jvtzvm6VNJ2b0cyi8LL6bM3T1z/WKKq+YuW/uvs4F89/TIQJz52zh7EM?=
 =?us-ascii?Q?Ig3+KO1depqZNm4d+vwuScS0nW6U1tt8w3pSE28tIqHb6dYD/ELKUjLM+cTX?=
 =?us-ascii?Q?oJFma2y6kwdMujxxyJiBs5XmiVNZIVVLpHHVJGVu+C81njSoejS7GvQTmf/+?=
 =?us-ascii?Q?/rsD0I5wdtOOiO8XmmMS499c5MnloAZEC3ewH59X4lN8UhUakSkIRsCkmYSk?=
 =?us-ascii?Q?HloUU71G+aLNceb/2boRi7ZOA7K/FcZ3qrtLnyq0EwQK5ZOSxmwxTdsPRmpi?=
 =?us-ascii?Q?+1iyz0ZwA35mHjOvGgPNkyKOoRwX4LS0RBM0mACazA8jN92/BYVIvVWpEaWC?=
 =?us-ascii?Q?79bEYD1bA3DorL9Fk8uZzpqfdJ9EjGBpoRxnrTAGJ2PN6t471x6fTWS/NK+9?=
 =?us-ascii?Q?JFgSr1lgjUYwljItqVsl2SckfOHCZ0ZLJ8dMgISmDzmtc/MhALW5txTBaol9?=
 =?us-ascii?Q?tMIcxmNPUJ91LnxfTORn7qH1PntIaB/00yxMXqRH8rEAVAGMQTwfmxOTI/pe?=
 =?us-ascii?Q?59aV2KBJOeF+az1SbjuG4yC/++3reGvGGGP1Zn/kLS0ZdNNJATg3avSZvEwa?=
 =?us-ascii?Q?Fc0hPn0Q0NoE7E5UccjYMo54KdvpvVbK7oRXzzyS8Jr6QcxHHuiVEyTYP+xM?=
 =?us-ascii?Q?le12t0Q8eICnA1nQKn2CiVNPIQLvxS++W3o9C1Wv543KSHSCd7UFQhF6DIAy?=
 =?us-ascii?Q?qAdbN0ouN9WIzxNA4iyC221RIJ7fgI7L9Gru/h6aYBGlCS2VcjCZYdIBA6Wz?=
 =?us-ascii?Q?V84DMFk0wyjPGsJ1cw8fwyDw8C18e5i/intXn7lz7etlYjWU5FcU35YBFQUE?=
 =?us-ascii?Q?71nfFc3I9i55sGQbiNmr8z3jOiOYk1wklMr7+SXmnuHmRJGhRlIjky/nZxqH?=
 =?us-ascii?Q?Tq/JXTrlcur/MQ7tt7dIyS/EO9yv7rNxRDIDkln9cONtwDMAlRYu2iftGsa+?=
 =?us-ascii?Q?pMCv7Aj/5UpligIKbsCPQJUlnaJSx7MtKtj+CQe2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 32772069-c170-4058-0eb8-08dd13828c18
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 10:09:17.4963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxyi/0MS4252vEWa97FrI6VkNoUgfjEXqbV07zdECqKaWMqu1WVs1z5JmDx/mYuocjg9wBAwBnTHUacfpxS+fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6892
X-OriginatorOrg: intel.com

On Mon, Dec 02, 2024 at 10:17:16PM +0800, Baoquan He wrote:
> On 11/29/24 at 01:52pm, Yan Zhao wrote:
> > On Thu, Nov 28, 2024 at 11:19:20PM +0800, Baoquan He wrote:
> > > On 11/27/24 at 06:01pm, Yan Zhao wrote:
> > > > On Tue, Nov 26, 2024 at 07:38:05PM +0800, Baoquan He wrote:
> > > > > On 10/24/24 at 08:15am, Yan Zhao wrote:
> > > > > > On Wed, Oct 23, 2024 at 10:44:11AM -0500, Eric W. Biederman wrote:
> > > > > > > "Kirill A. Shutemov" <kirill@shutemov.name> writes:
> > > > > > > 
> > > > > > > > Waiting minutes to get VM booted to shell is not feasible for most
> > > > > > > > deployments. Lazy is sane default to me.
> > > > > > > 
> > > > > > > Huh?
> > > > > > > 
> > > > > > > Unless my guesses about what is happening are wrong lazy is hiding
> > > > > > > a serious implementation deficiency.  From all hardware I have seen
> > > > > > > taking minutes is absolutely ridiculous.
> > > > > > > 
> > > > > > > Does writing to all of memory at full speed take minutes?  How can such
> > > > > > > a system be functional?
> > > > > > > 
> > > > > > > If you don't actually have to write to the pages and it is just some
> > > > > > > accounting function it is even more ridiculous.
> > > > > > > 
> > > > > > > 
> > > > > > > I had previously thought that accept_memory was the firmware call.
> > > > > > > Now that I see that it is just a wrapper for some hardware specific
> > > > > > > calls I am even more perplexed.
> > > > > > > 
> > > > > > > 
> > > > > > > Quite honestly what this looks like to me is that someone failed to
> > > > > > > enable write-combining or write-back caching when writing to memory
> > > > > > > when initializing the protected memory.  With the result that everything
> > > > > > > is moving dog slow, and people are introducing complexity left and write
> > > > > > > to avoid that bad implementation.
> > > > > > > 
> > > > > > > 
> > > > > > > Can someone please explain to me why this accept_memory stuff has to be
> > > > > > > slow, why it has to take minutes to do it's job.
> > > > > > This kexec patch is a fix to a guest(TD)'s kexce failure.
> > > > > > 
> > > > > > For a linux guest, the accept_memory() happens before the guest accesses a page.
> > > > > > It will (if the guest is a TD)
> > > > > > (1) trigger the host to allocate the physical page on host to map the accessed
> > > > > >     guest page, which might be slow with wait and sleep involved, depending on
> > > > > >     the memory pressure on host.
> > > > > > (2) initializing the protected page.
> > > > > > 
> > > > > > Actually most of guest memory are not accessed by guest during the guest life
> > > > > > cycle. accept_memory() may cause the host to commit a never-to-be-used page,
> > > > > > with the host physical page not even being able to get swapped out.
> > > > > 
> > > > > So this sounds to me more like a business requirement on cloud platform,
> > > > > e.g if one customer books a guest instance with 60G memory, while the
> > > > > customer actually always only cost 20G memory at most. Then the 40G memory
> > > > > can be saved to reduce pressure for host.
> > > > Yes.
> > > 
> > > That's very interesting, thanks for confirming.
> > > 
> > > > 
> > > > > I could be shallow, just a wild guess.
> > > > > If my guess is right, at least those cloud service providers must like this
> > > > > accept_memory feature very much.
> > > > > 
> > > > > > 
> > > > > > That's why we need a lazy accept, which does not accept_memory() until after a
> > > > > > page is allocated by the kernel (in alloc_page(s)).
> > > > > 
> > > > > By the way, I have two questions, maybe very shallow.
> > > > > 
> > > > > 1) why can't we only find those already accepted memory to put kexec
> > > > > kernel/initrd/bootparam/purgatory?
> > > > 
> > > > Currently, the first kernel only accepts memory during the memory allocation in
> > > > a lazy accept mode. Besides reducing boot time, it's also good for memory
> > > > over-commitment as you mentioned above.
> > > > 
> > > > My understanding of why the memory for the kernel/initrd/bootparam/purgatory is
> > > > not allocated from the first kernel is that this memory usually needs to be
> > > > physically contiguous. Since this memory will not be used by the first kernel,
> > > > looking up from free RAM has a lower chance of failure compared to allocating it
> > > 
> > > Well, there could be misunderstanding here.The final loaded position of
> > > kernel/initrd/bootparam/purgatory is not searched from free RAM, it's
> > Oh, by free RAM, I mean system RAM that is marked as
> > IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY, but not marked as
> > IORESOURCE_SYSRAM_DRIVER_MANAGED.
> > 
> > 
> > > just from RAM on x86. Means it possibly have been allocated and being
> > > used by other component of 1st kernel. Not like kdump, the 2nd kernel of
> > Yes, it's entirely possible that the destination address being searched out has
> > already been allocated and is in use by the 1st kernel. e.g. for
> > KEXEC_TYPE_DEFAULT, the source page for each segment is allocated from the 1st
> > kernel, and it is allowed to have the same address as its corresponding
> > destination address.
> > 
> > However, it's not guaranteed that the destination address must have been
> > allocated by the 1st kernel.
> > 
> > > kexec reboot doesn't care about 1st kernel's memory usage. We will copy
> > > them from intermediat position to the designated location when jumping.
> > Right. If it's not guaranteed that the destination address has been accepted
> > before this copying, the copying could trigger an error due to accessing an
> > unaccepted page, which could be fatal for a linux TDX guest.
> 
> Oh, I just said the opposite. I meant we could search according to the
> current unaccepted->bitmap to make sure the destination area definitely
> have been accepted. This is the best if doable, while I know it's not
> easy.
Well, this sounds like introducing a new constraint in addition to the current
checking of !kimage_is_destination_range() in locate_mem_hole_top_down() or
locate_mem_hole_bottom_up(). (powerpc also has a different implementation).

This could make the success unpredictable, depending on how many pages have
been accepted by the 1st kernel and the layout of the accepted pages(e.g.,
whether they are physically contiguous). The 1st kernel would also have no
reliable way to ensure success except by accepting all the guest pages.

> > 
> > > If we take this way, we need search unaccepted->bitmap top down or
> > > bottom up, according to setting. Then another suit of functions need
> > > be provided. That looks a little complicated.
> > Do you mean searching only accepted pages as destination addresses?
> > That might increase the chance of failure compared to accepting the addressed
> > being searched out.
> > 
> > > kexec_add_buffer()
> > > -->arch_kexec_locate_mem_hole()
> > >    -->kexec_locate_mem_hole()
> > >       -->kexec_walk_memblock(kbuf, locate_mem_hole_callback) -- on arm64
> > >       -->kexec_walk_resources(kbuf, locate_mem_hole_callback) -- on x86
> > >          -->walk_system_ram_res_rev()
> > 
> > Yes.
> > 
> > 
> > > Besides, the change in your patch has one issue. Usually we do kexec load to
> > > read in the kernel/initrd/bootparam/purgatory, while they are loaded to
> > > the destinations till kexec jumping. We could do kexec loading while 
> > > never trigger the jumping, your change have done the accept_memory().
> > > But this doesn't impact much because it always searched and found the
> > > same location on one system.
> > Right.
> > Do you think it's good to move the accept to machine_kexec()?
> > The machine_kexec() is platform specific though.
> 
> I am not sure if it's appropriate to accept in machine_kexec(). 
> 
> > 
> > > > from the first kernel, especially when memory pressure is high in the first
> > > > kernel.
> > > > 
> > > >  
> > > > > 2) why can't we accept memory for (kernel, boot params/cmdline/initrd)
> > > > > in 2nd kernel? Surely this purgatory still need be accepted in 1st kernel.
> > > > > Sorry, I just read accept_memory() code, haven't gone through x86 boot
> > > > > code flow.
> > > > If a page is not already accepted, invoking accept_memory() will trigger a
> > > > memory accept to zero-out the page content. So, for the pages passed to the
> > > > second kernel, they must have been accepted before page content is copied in.
> > > > 
> > > > For boot params/cmdline/initrd, perhaps we could make those pages in shared
> > > > memory initially and have the second kernel to accept private memory for copy.
> > > > However, that would be very complex and IMHO not ideal.
> > > 
> > > I asked this because I saw your reply to Eric in another thread, quote
> > > your saying at below. I am wondering why kernel can accept itself, why
> > > other parts can't do it similarly.
> > > =====
> > > Yes, the kernel actually will accept initial memory used by itself in
> > > extract_kernel(), as in arch/x86/boot/compressed/misc.c.
> > > 
> > > But the target kernel may not be able to accept memory for purgatory.
> > > And it's currently does not accept memory for boot params/cmdline,
> > > and initrd .
> > > ====
> > Thanks for pointing this out.
> > I also found that my previous reply was confusing and misleading.
> > 
> > The 2nd kernel will accept the addresses before it decompresses itself there.
> > Since these addresses are somewhere "random", the 2nd kernel (and for the 1st
> > kernel for itself) needs to call accept_memory() in case that they might not
> > have been accepted.
> > 
> > So, previously, I thought a workable approach might be for kexec to map the
> > destination addresses in shared memory, perform the copy/jump, and then have the
> > 2nd kernel accept the addresses for decompressing and other parts.
> > However, aside from the complications and security concerns, this approach is
> > problematic because the 2nd kernel may clear the pages by accepting them if the
> > addresses for decompressing overlap with the ones before decompressing.
> > 
> > That said, would it be acceptable if I update the patch log and maybe also move
> > the accept call to machine_kexec()?
> 
> Hmm, I think a repost seems necessary, even though this patch looks good
> to me. If I do, I would add a cover letter to present with several sections:
> 
> 1) background information: to explain what scenario the accept memory is
> used for. And why accept all memory in kexec reboot case is not
> expected.
> 2) the current problem: a brief description of the problem and itsroot cause;
> 3) How to fix it: here we can list all possible solutions we can thin of
> and what drawbacks they have so that they are not chosen. Then we can
> come to the final sotution that your current patch has to resort to
> take.
Thanks for this suggestion!
 
> As kexec maintainer, Eric's concerns are very important and need be resolved 
> with as much information as possible to let him be happy with the
> change, at least let him not hate it. This is my personal suggestion as a
> reviewer. You can put them into cover letter if you think it's not good to add
> them all in a standalone patch.
My apologies. I will first repost a new version with the current implementation,
including more background and explanations to address Eric's concerns.

Thank you!

> 
> > 
> > New patch log:
> > The kexec segments's destination addresses are searched from the memblock
> > or RAM resources. They are not allocated by the first kernel, though they
> > may overlap with the memory in used by the first kernel. So, it is not
> > guaranteed that they are accepted before kexec relocates to the second
> > kernel.
> > 
> > Accept the destination addresses before kexec relocates to the second
> > kernel, since kexec would access them by swapping content of source and
> > destination pages.
> > 
> 

