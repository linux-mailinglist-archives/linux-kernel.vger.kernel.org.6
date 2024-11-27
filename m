Return-Path: <linux-kernel+bounces-423281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31DB9DA54D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82D711657E8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A95194AD9;
	Wed, 27 Nov 2024 10:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EQEtnu2d"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA7A19413C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 10:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732701832; cv=fail; b=op4dD0ElN9kaLtKEX08rWvJ3+PYYrALFYTes3SsNQQgolXgF/j7lUui7jJ8UkFW56AKAua8tNNviQNpYpS5iJdmPojDkNmL/BhEtf1rrmhDj1KMgm+iNci7RYvrdANZDUVBRsF32Wyk0Q20hBJfI1SZDizocuXzNNCtmBz01UvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732701832; c=relaxed/simple;
	bh=QYJxnbinFYIQx3eLf7fKCOuXp9z4GQ3oqNLN3Nvbq9A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uokbkk+HrrhtAj7EpWGVtsLZiEQabMcBVdW6KpC8inAdGWRk6ln7ZwnHg0TfZNwx55e/J3LVz86Sxf6kbZ3hBWfGE/WV6xX7J9oNTb9IXuqKJPyebdBzehsagxwqq5Pj7SohUYCXOIZ7cWCkh6AeCWf1+k5HyOWpjcCu82HU66M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EQEtnu2d; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732701831; x=1764237831;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=QYJxnbinFYIQx3eLf7fKCOuXp9z4GQ3oqNLN3Nvbq9A=;
  b=EQEtnu2db7NtD3J6vKLtkanB69qUm6NkOF+ydblRD0772DWYaCEczJHw
   opUgtmChe4UawumAUSrzUt6GIJ6Iruv+BjEzs9vWETUk0/W36AViNRl7X
   X2l6wWghJp+SnTntUytqpSU7P9OlFr6EF6uwYpfuGutQvOg11gulakk9C
   vox+UmtSyXNkH1nM/0cj71507Ly0yOE3FzkqtncP2od5WjhF+G+qoXt96
   wq1elUkJUZt7oty9ozIH/eMszxDxDchwpva7fRRrTZZ8baWH3gwvzI+BT
   9m1BhhUu2T1zlUqqFjO8XXvWkQrjCxnrWa3p9lVBZ5m6QFrqBmmyzPLi0
   A==;
X-CSE-ConnectionGUID: ANdR+2VfTOuFNi9Sr7aKRg==
X-CSE-MsgGUID: rwwlM/aSQOyTOKqsclNtmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="33148235"
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="33148235"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 02:03:50 -0800
X-CSE-ConnectionGUID: nT3oAauwQw6gIY6B5pU5Tg==
X-CSE-MsgGUID: b+LFYolbTGWAy9lFuryC1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="92044615"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2024 02:03:50 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 27 Nov 2024 02:03:49 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 27 Nov 2024 02:03:49 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 27 Nov 2024 02:03:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NqzTMWF2F3xCHzqy2Xbdy7E6D5M7o8+3PQ1H05T2JRXKLFsBRVgpGYdL5fquSs1HRTc8XI45x/6P7yxpsTTq3e7kZXLbQISgsAJBDrkhcL8BS8fFTlBzTKIlL63e6sjewMr5+NTwn1B/59M/z6ZEs9klG9R+pmhKI4YE8v/8rC13JAkBTgSQavQRUOsFaUUqJp3nM+J0NIV6puDVW1WlpXIyiD2COhiPiYzw3TTi2oVHSO90CDxAqp5YViG7mORB/d9i8AG9JlSDEpdj4VruuIafsVruZiZPvdW3XZpTnXGbbQG8cUZvjmTlaE4/tB13xXi8qfxcDyGHk2G1nesQmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaTZcNgjVpnlvi7ycnJW+VaezI4KbEwKoz411nEoP0U=;
 b=xyoABFR+2Y/A0cA1W+6m+WAqQT16A/CMk6yPJK90VWRa7wnazrZLW+ntPxb4JtNBnamnEi4PdslpAMqGmlccgf8YsKavicWyYDZ9XaYWl/z7r18aa0zU208ik6C36sMOmKNhW6JQlBP1QCV1H/LvDresrKJu9tUx9yc7TDSFg7lLjmLB8pEEryhm3VnrRrfD3RK3A9usCe0AsfPFi7h3thZheqvI3SwnRDbek2YUW/1J84gSTSSthf7DgH1KD3T3wylvtTKF/X9LrvdmqbBbO05LkmAqVtZWKpjOam4tqCrwnKX9wni9B8QxPgAfuKaDmyi1TJOdyg/CyFVq5j/xPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 DM6PR11MB4610.namprd11.prod.outlook.com (2603:10b6:5:2ab::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.13; Wed, 27 Nov 2024 10:03:47 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%5]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 10:03:47 +0000
Date: Wed, 27 Nov 2024 18:01:04 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Baoquan He <bhe@redhat.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, "Kirill A. Shutemov"
	<kirill@shutemov.name>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<x86@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] kexec_core: Accept unaccepted kexec destination addresses
Message-ID: <Z0bt4HXAKqM3C1ZW@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20241021034553.18824-1-yan.y.zhao@intel.com>
 <87frop8r0y.fsf@email.froward.int.ebiederm.org>
 <tpbcun3d4wrnbtsvx3b3hjpdl47f2zuxvx6zqsjoelazdt3eyv@kgqnedtcejta>
 <87cyjq7rjo.fsf@email.froward.int.ebiederm.org>
 <ZxmRkUNmx863Po2U@yzhao56-desk.sh.intel.com>
 <Z0WzHZ+fNn6WuH/E@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z0WzHZ+fNn6WuH/E@MiWiFi-R3L-srv>
X-ClientProxiedBy: SGXP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::23)
 To DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|DM6PR11MB4610:EE_
X-MS-Office365-Filtering-Correlation-Id: 0246f1aa-0eab-4a54-41c6-08dd0ecac8b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/3vAXnajQcpqGmSpnz1Lv/Bv8hCds9vAO8yE9DAmjPgru8RqPxmhYpbuGRsa?=
 =?us-ascii?Q?8ujCQ9bQdpoIuhsz8tgsXhBkITX8lRLOW/0wrYZpHmiOVihEWOA8lmWFGubD?=
 =?us-ascii?Q?sJpZUjIpf7bgEyU441dUluiWg6SGQksz6uq0RtoEva7mGHJH9zng/O6yAhU+?=
 =?us-ascii?Q?JCEheB8ux2Bs9bofGnGv1chMLLl3TKeAJOnZLLKAKZgK+us0fMZ0rvf+2bGy?=
 =?us-ascii?Q?VQ2HJJDe/c1Di0MOi6J3OnZDhaknqOZBF5akjMs+XGeT57I8J7Ll4H1KEb40?=
 =?us-ascii?Q?B4thOA0mFzeaRFQFl3ybtena9TxA+WwjF/pBe9ryEPcPrfZINFxZBRBTOXrL?=
 =?us-ascii?Q?L2XUKEtqrIFNBc9g76aNsAxd0hDHbrDFUcO5bq4iE/oVt7rtD/LUp7ucqyP0?=
 =?us-ascii?Q?Kyc07fwWb4y4MfIhIw2iiZS4wJtaQlJFjEWTIt1WGS1jJOI/JJq4qaHJdjkM?=
 =?us-ascii?Q?lX2DujL6VPQhFkeXDELWH98fWahPg56cBZqa6Q72APNouBvu+9G2yzRJeAwa?=
 =?us-ascii?Q?oHXzBOCX6InEFqrw/r8HGdiW4Gq3tw525o8C3qK28lRZiWUZg+Ms010ybjKK?=
 =?us-ascii?Q?WE/GsZN7m9sOgBwhi8M4XpcB6yF0Oi3C3doFS5gEk+en0O+qxTQ4664xiMWf?=
 =?us-ascii?Q?mrkNkK/bn0ed4jwD3d5nj4vC5irMEnDMMKs0S30oHv0PGlSqxvhGYOheqQQe?=
 =?us-ascii?Q?FlJHEwPnHSqSbiE9qetag/8VmTRjNwj//3UMHr8W0LuSJSGk+j0P0rO/wGMN?=
 =?us-ascii?Q?d1XJ43yKrsHERNuT9e9pFRJiHbq7tps4R7nbvMhBo0LqzZ7x4jEMmHjgCvmq?=
 =?us-ascii?Q?yHfQDtY+7jQNMGlZasNNYt2f3pIE24Rx8mxjpP64rnWzf6lbDpUKBy2JWT8l?=
 =?us-ascii?Q?HOc27G+sNjlnaKERS0BJvY2wY3Sg0cqO2QYgqDra6Cpuw/TJEX2MFtK5OVTX?=
 =?us-ascii?Q?ZA4xCD6y/lgu+grBeM6Z9mG7PKT2eykHEwuEAmmkRh5zafUmLf2p3C9iHOR3?=
 =?us-ascii?Q?auBGFVNPMwrElZ6yhqCCflGT9TNvWU9tK4OZvGKLUbwcH0VCeYczZHWm6wj3?=
 =?us-ascii?Q?dj0j8BX4hXX7l2xaq5ex9ggsCPCgw8ccCfrQjrSrXi2Mg4iyczpe5OLlpNuy?=
 =?us-ascii?Q?c2Iu+Ik0LqdUBLKdNzohWS3Myiemsb2v+CMjkgGqN9k8W9K4koFLuQEs0j+0?=
 =?us-ascii?Q?soBO1sJX51cOpVOI4aWfPKyeCWEeC/RWqbRDY7yQ3lQ37D//GULK1Aaw7d7+?=
 =?us-ascii?Q?FU0ju4xczxeBB9HSU9cpwJbmo4UeC7jfCxgPlZaVpBbW404geiITBv8E9G/l?=
 =?us-ascii?Q?23xILJmJmyZLyUdhagRSDsfRqDkefTmUuQ1M/kVSwXnpvg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XpC3gvRZHbbZWgbFfsUFZIvCpruf3DipeYlVafdf0KKfzjnQAu89zCHkPD1s?=
 =?us-ascii?Q?j3R8dqgMMFHJbedLaxu+ltGJrtT4pBiFVk27LGMM52vUM2i264lkac/yeZCO?=
 =?us-ascii?Q?kQh1R8LIM4iDheOtMVMgKXz2SqcNJErAUNwJO9NJjHEpwSYVAODsKaK954Kr?=
 =?us-ascii?Q?ORF9vP1ym070MgoqC9K8mTa/wR+4j7Vk+nkLws3xLHw4qtdZh5tQArpZkXYo?=
 =?us-ascii?Q?K4wcriPe9WsM6Pco6HSU0Blf/ryMI5mYFh5EUwJhVzt4GZQY+qPxuVLNLiSV?=
 =?us-ascii?Q?pvuDNyU+YXXWnQh8ygJpL5YNcuH0zgj0Tp2amBRmDjwdd1L3eiNMuTxffxCV?=
 =?us-ascii?Q?3Yyznuw5+3+DluMkNvAYZMfJLd22Z9aNLyPJBOPsKZjejzCLpks4p2GEGmQl?=
 =?us-ascii?Q?DlkgfEuPwgTbIissb54NQMKjVF+et900+beBdJFZ1RdX/Ns3591m632ezsxo?=
 =?us-ascii?Q?XpVbivs6ls9/Jk+b9LT3FZFgF08XndW646BTfm0LoMx8AkkW6CATPHPKbFH4?=
 =?us-ascii?Q?jNis7QoWCjVV2XSK36a6pIPWUNIxtATld675hbAP/VZR6eMCtNhXv0c57CKe?=
 =?us-ascii?Q?TBCX2FDp4af6M5tdLPlNFaGszdUqn7Tb9MCD1vsBXZt0qmuxuauLyB2c+dDH?=
 =?us-ascii?Q?/MfB0bHY9iUNDHPz2SkMjIYWRkDly5jGZAWkmxqPuSQ17XzeYRvfHaxVC70/?=
 =?us-ascii?Q?Xw4gta5+aL/8fWIVQA9Lbh/4E/WkW2oPDSQfePGJZf7wciZCmotc7QGySj1t?=
 =?us-ascii?Q?gEL7UfFC2OPZGHyO689yfP3igQFVdSMt3fw1sN+zz/cqiwIi3UEiJGEzvDch?=
 =?us-ascii?Q?fXdHnTtKOTzLkoFhLZf8FEy24+OwjHvYhCA2zXOTdX1hJadsqKabqI07hPHS?=
 =?us-ascii?Q?Ale1GkaBQAwc1i9QqflRkO/i9nUPNmWmocJVLe9s0hKUkBmZAUi1/tFAsIv2?=
 =?us-ascii?Q?+VAcyjJsXaARrpZ4exGpAOzbNWR5QLN10C74o5VYXzKqXDGkWXqSrfARGpn5?=
 =?us-ascii?Q?5/AjwegugqlzDD+C74FJBgVCNsU0J4N6zQPmZ7saCUvi4HrMmSL7yGpXeasH?=
 =?us-ascii?Q?fstP7WaJ4h1KhjZN8dhgaxIyoBT/FIej8FL/wvCFEbI2JpHsOC+oF0li4sAL?=
 =?us-ascii?Q?1omYTTJZbM+Tj88HASvOdNgJtb7Y7GgWoKCowTzK1nn95LNFsusELqDTmpXx?=
 =?us-ascii?Q?FzK3E6U2Z2HJ/bKUnQ5deigNDFtWZfdAdMxuICYCglfy5/qhup2KHmXp8k7R?=
 =?us-ascii?Q?0tqCnUkGSA/kuQHdJdLTC1w2H3C4yo5HC6rQk29NXieHWNJKaP57zDKjPkMA?=
 =?us-ascii?Q?dsvz9AGsNnH4tXchRNKs+5/lUj0JOEOlVAinGY2x9g7jRF1bCw0UXnF7YDWW?=
 =?us-ascii?Q?N/lZYERukhNsgNje9O/V7WRBohF/2NlBe49RmayGSHiU95yMXr7a0HVWwM4+?=
 =?us-ascii?Q?zx600LIcFr5FKeIlAovX9tPFC19bacMMrKFA9JR0yiTZIE9hxCSw8IJ7fRvy?=
 =?us-ascii?Q?gXnQXpFfWSuQ3sDufAXeH/2wWY9Uyy9AdFSnjgm7yBFms4hrk4qDbvI1Ijnw?=
 =?us-ascii?Q?dcp72MhhZKUiDO0nDsTJlBewtsB91WcRkkEWiMHX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0246f1aa-0eab-4a54-41c6-08dd0ecac8b9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 10:03:47.2137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubbYqOevz/8kRAAlzuio16l/srJDIkxbNrFuNpi4eaNaHawVEzzNzkpPrWRz87Oc57LPqC9YYW3CrCSRuCx//w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4610
X-OriginatorOrg: intel.com

On Tue, Nov 26, 2024 at 07:38:05PM +0800, Baoquan He wrote:
> On 10/24/24 at 08:15am, Yan Zhao wrote:
> > On Wed, Oct 23, 2024 at 10:44:11AM -0500, Eric W. Biederman wrote:
> > > "Kirill A. Shutemov" <kirill@shutemov.name> writes:
> > > 
> > > > Waiting minutes to get VM booted to shell is not feasible for most
> > > > deployments. Lazy is sane default to me.
> > > 
> > > Huh?
> > > 
> > > Unless my guesses about what is happening are wrong lazy is hiding
> > > a serious implementation deficiency.  From all hardware I have seen
> > > taking minutes is absolutely ridiculous.
> > > 
> > > Does writing to all of memory at full speed take minutes?  How can such
> > > a system be functional?
> > > 
> > > If you don't actually have to write to the pages and it is just some
> > > accounting function it is even more ridiculous.
> > > 
> > > 
> > > I had previously thought that accept_memory was the firmware call.
> > > Now that I see that it is just a wrapper for some hardware specific
> > > calls I am even more perplexed.
> > > 
> > > 
> > > Quite honestly what this looks like to me is that someone failed to
> > > enable write-combining or write-back caching when writing to memory
> > > when initializing the protected memory.  With the result that everything
> > > is moving dog slow, and people are introducing complexity left and write
> > > to avoid that bad implementation.
> > > 
> > > 
> > > Can someone please explain to me why this accept_memory stuff has to be
> > > slow, why it has to take minutes to do it's job.
> > This kexec patch is a fix to a guest(TD)'s kexce failure.
> > 
> > For a linux guest, the accept_memory() happens before the guest accesses a page.
> > It will (if the guest is a TD)
> > (1) trigger the host to allocate the physical page on host to map the accessed
> >     guest page, which might be slow with wait and sleep involved, depending on
> >     the memory pressure on host.
> > (2) initializing the protected page.
> > 
> > Actually most of guest memory are not accessed by guest during the guest life
> > cycle. accept_memory() may cause the host to commit a never-to-be-used page,
> > with the host physical page not even being able to get swapped out.
> 
> So this sounds to me more like a business requirement on cloud platform,
> e.g if one customer books a guest instance with 60G memory, while the
> customer actually always only cost 20G memory at most. Then the 40G memory
> can be saved to reduce pressure for host.
Yes.

> I could be shallow, just a wild guess.
> If my guess is right, at least those cloud service providers must like this
> accept_memory feature very much.
> 
> > 
> > That's why we need a lazy accept, which does not accept_memory() until after a
> > page is allocated by the kernel (in alloc_page(s)).
> 
> By the way, I have two questions, maybe very shallow.
> 
> 1) why can't we only find those already accepted memory to put kexec
> kernel/initrd/bootparam/purgatory?

Currently, the first kernel only accepts memory during the memory allocation in
a lazy accept mode. Besides reducing boot time, it's also good for memory
over-commitment as you mentioned above.

My understanding of why the memory for the kernel/initrd/bootparam/purgatory is
not allocated from the first kernel is that this memory usually needs to be
physically contiguous. Since this memory will not be used by the first kernel,
looking up from free RAM has a lower chance of failure compared to allocating it
from the first kernel, especially when memory pressure is high in the first
kernel.

 
> 2) why can't we accept memory for (kernel, boot params/cmdline/initrd)
> in 2nd kernel? Surely this purgatory still need be accepted in 1st kernel.
> Sorry, I just read accept_memory() code, haven't gone through x86 boot
> code flow.
If a page is not already accepted, invoking accept_memory() will trigger a
memory accept to zero-out the page content. So, for the pages passed to the
second kernel, they must have been accepted before page content is copied in.

For boot params/cmdline/initrd, perhaps we could make those pages in shared
memory initially and have the second kernel to accept private memory for copy.
However, that would be very complex and IMHO not ideal.

