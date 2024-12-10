Return-Path: <linux-kernel+bounces-438787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB6E9EA5F5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 03:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161FD161574
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 02:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E78619DFB5;
	Tue, 10 Dec 2024 02:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B8GHTeiO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C146427456
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 02:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733798826; cv=fail; b=NOpGyMNBDkgQI7pWaBRhp/Jdf6XR6cJG930GgTRALuEm9pbAHskpMI3u8bLPTHVVUi81Ku6PSmJ3FUOegyATzQZ4Aysn7fDDPG3Oa18wYvVost/Aool7GHlirS7rnisT2F3Os1/2OQ9eUIfkl9mu/93rH3kK2r1kp1RUYk8IOqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733798826; c=relaxed/simple;
	bh=+rIo+t4Hlc0UUzB1kmq4iFynd7et9TpIDRpEhbv7dGE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WahdyzP3B/3RinUehfrX7Ewjh8oB+yqjPeYgnPspuW0xQMbJJFpXSrI94Gudjw2hjoQp8Veg7zAZJLmVDIEPd6pg+oXRIG+fEvT1ZuR3QDLjOTZESJpwCv5xIM6uAcujR6wymoxWSsWB0FT3QUMDrxgXdO24SRPL8iEZndjjfoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B8GHTeiO; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733798825; x=1765334825;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+rIo+t4Hlc0UUzB1kmq4iFynd7et9TpIDRpEhbv7dGE=;
  b=B8GHTeiOea+Njf/L/GD/9sefdQyIVDTEDVdauWQ1wW6EFq309KSbBS9O
   8Gx6b+T1uSl0g4dZYe187aBHyMDYA/fepmAFQC6VDfrCAQWK1+NjrXMtC
   sXFM+RJjXRogWwxxCYCOU36LTr1QtzwlYh3HvFs6TxAvz1mU6Z0S7bdOv
   LxMR+e7oEOU8OIDTTlBeHU6sSUhpEWvdikS5nBqPE+OJXb9dFXtGV54iz
   uOC0PR9qFYxxAVr6d9dq8h0aaWw9UG489HHjOaXA0iEqAWCVUeyFNvvWX
   oWQS+u7fS1iJZVXzmwWGFxOarDC6fbNrtx7YvS3LTYy8QZhX8GRpPE98p
   A==;
X-CSE-ConnectionGUID: Tej8K0gFRuqeW77c7J+Wng==
X-CSE-MsgGUID: X4ClpJACQfO9c+TvuFdJnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="37909718"
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; 
   d="scan'208";a="37909718"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 18:47:05 -0800
X-CSE-ConnectionGUID: FrvhnaBpReSl2phZ/bHssQ==
X-CSE-MsgGUID: K0Xdd1JtSfijV/f0bjiUww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; 
   d="scan'208";a="100318096"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Dec 2024 18:47:04 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Dec 2024 18:47:03 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 18:47:03 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Dec 2024 18:47:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0Ts0yf4f0ocUAy4Pfjctm1FxwOMTvn8EAQwmeWMlYyD1Nj6YwEox+T37X1ulRJ2Sn6aNKKH5BL6VLqTJNURDiNwDRguNvOxr9OVcoze3tGL/MRMAXZmwNO+jq4ewiQtamIKlifDQih4zThqaPZMOBLcbkboCr8Two7Gpow8jxMP9scv9YmDX+M3EqMZU5jDyUP0iuw5IDovyLOGj/xpE2gLj/3BFwcVXDQ7DBN1zjEB6196S6DhyssVXfFqTe+Au8OPBOxi9j36LPuO97xOZyHXCgXMJa7f8mVstOBiGHnKIRFSgrpsTG1G5Wy2Zv3LBfhyKdU796G55TQH1CPnmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrL+L7Jf2kTWphpIDmePxMhiE5OQU9hVKmrDF2i1+TY=;
 b=UT9EXEkJNujk2NgTlYhjMxp8hSx3gjt1HTkF2cREjt4y/BULQlVhcaIKWdCqS72lm+0HqGdo3EIsuf4d6dp3SsN8HZygAC4hX1kY02Du+L4YL3LBs7CU6jX0fgn6KFkr984AJQnlL63qHS9+0GqGn7ntEibk03Txw0nFbUNf6N1GoIMMY0RHNomrTGQGroMt/FjsHs+fknxexQ8xsx49rzFHK8Xc6+8aQ/5hWnFAmK/HjPFSCJl5Uw9X97EI6FBv9pHPMDFE+VCuYXu+RgrI26EaMkuzZfwrcOp3Z9WmSf3xNUvlb1a6+9K2/GKDoH487X24/HVNg4LlIOdE/EzaUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6849.namprd11.prod.outlook.com (2603:10b6:806:2a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 02:47:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 02:47:01 +0000
Date: Mon, 9 Dec 2024 18:46:57 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: "Huang, Kai" <kai.huang@intel.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"bp@alien8.de" <bp@alien8.de>, "peterz@infradead.org" <peterz@infradead.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "Williams, Dan J" <dan.j.williams@intel.com>
CC: "nik.borisov@suse.com" <nik.borisov@suse.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "x86@kernel.org" <x86@kernel.org>, "Yamahata,
 Isaku" <isaku.yamahata@intel.com>
Subject: Re: [PATCH v8 8.2/9] x86/virt/tdx: Reduce TDMR's reserved areas by
 using CMRs to find memory holes
Message-ID: <6757aba1e072f_3e0fe294a5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <23bb421e9bf5443a823e163fb2d899760d9f14a3.1731498635.git.kai.huang@intel.com>
 <20241209065016.242359-1-kai.huang@intel.com>
 <78a359f8-5a0c-463c-b886-ff4165b395d2@intel.com>
 <83df85a3b318e6578628692ce0d28b9cf736061e.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <83df85a3b318e6578628692ce0d28b9cf736061e.camel@intel.com>
X-ClientProxiedBy: MW4PR04CA0058.namprd04.prod.outlook.com
 (2603:10b6:303:6a::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6849:EE_
X-MS-Office365-Filtering-Correlation-Id: af6b7978-4191-4097-962d-08dd18c4ec18
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AxxijF7kuQnY8FvGc6xUPddcxBkOiyz4ucPUF/uF7wTTUP3Dil6iiWFp+d71?=
 =?us-ascii?Q?iZbLQ05rm3NP1LPs3Zgzn/nIrPUXYXmAFIZbnQ0OyQQyzD15mx33632vbS5T?=
 =?us-ascii?Q?DErT22e4pL5F7L0IL++vIUarY5qs8R4IP9wPh2H9ALqaVZarZjzrfY4J40Qu?=
 =?us-ascii?Q?Ux/jmpfKB07/pfLcySRVXqKWDtooLYduhKsAzeGfDQ2hCYnAJ/xeqGfTTQRf?=
 =?us-ascii?Q?Y08Z3PAWPIJCPjj6G1BhpUp7viQU/2f726tXCPYt8IiMF24cvmMD9EWySP2m?=
 =?us-ascii?Q?lV/3K8/GhjhJkIwI9WPJtSaFJcdgrqdn04pdIJJqi1RxcCg1WLZnGzbW3q4T?=
 =?us-ascii?Q?FN8qfnCBoVVdhdOY58vb7a0YWO55K5nyxEz/2WjvGEe+rViE8nuviEpa/pZ3?=
 =?us-ascii?Q?4zjT0rtYkQ3eeDhVaEZh8mBD3SATkLdMvQs8Gv4h4q3RYnL1MxG+ct5c+6SX?=
 =?us-ascii?Q?03h7GiUmTQwHYRUYJnSyr2OXbODCMDHCUHYUKE7JNI17qkoKEWhhhbFYl+W2?=
 =?us-ascii?Q?ExhoH0uordBsVg1prXZph+g1RFq3Z11MN/kHax0iFKPn7njFRGACbC/n4rkq?=
 =?us-ascii?Q?CCaS9J4Jrpr+h1PHewKWXLFLugvFsGyZMqdgMmeAPtxt2znSWrtZyCUwrG8Q?=
 =?us-ascii?Q?E0dkBAclwmk/HPXjnB8JE+K8JjZoI+9zuYZfdO3JTVEQByI+GB7S+V33f6ya?=
 =?us-ascii?Q?AjG+QBGLnlZQlk4/LEwoiaNpIXQETPCp9v11ud80eETTl4DtgoqlSS9HZvuX?=
 =?us-ascii?Q?zDPVakR9OzBcAj7XzIbAOS0KLI5GWTCCsoyXDRyYGSoKhlqoSRJiTmwVpAil?=
 =?us-ascii?Q?lygU8gi11gznwiVES0c16U9GvQRTGdlRK+xhnE+d7lrVwnkCYt29qmR+EvQt?=
 =?us-ascii?Q?2Dyyh6QRdVH6nxyNa++PhPZczXiFaF1BRcZLTdkZTwkH1iWc0Rbgh7LnTZ5c?=
 =?us-ascii?Q?JXP409w/160aDYCpOeWAzFeaOj4cmyq6T4N6OImOG//WswmTNeh1NsxsqZNE?=
 =?us-ascii?Q?8kxJbIFCFWrVl9kk3LXO0IkB9A2MbneZHAvmrIT7K7/IRIZqIXdcqhcxGk64?=
 =?us-ascii?Q?DwYNMhmbPXNBGZi/Pp3L4u2e+BOm2vof30/SMo3V5mJA4IBtFyQyZ6xzWxFu?=
 =?us-ascii?Q?jU1B1MfVeXzviTZis//+X2ZxdhcbwakxBg9tB4BmjhtRWGop4NgCJ/SiM/3u?=
 =?us-ascii?Q?g5YU3OfFPP/2m2SJbkUP8wofK3+wMTvUvcPLNz0xeZkVv89f4Obs+do+4rdU?=
 =?us-ascii?Q?W9UzU7u0cFS7ybxDXgUmgEq3pkL34nefVMfU+KsSDXT7l6q0JZsk7tjb2YZE?=
 =?us-ascii?Q?oKSFWyIimaAnOPEZlVfgHIZOXmnFivtqt3ytgZEacAmZa9Rgb3R1wkuYmf7N?=
 =?us-ascii?Q?60IYQstGGW8709giRTe6hGAKCofQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4qF73FMv3B0b4e1FrsLJBThGzSCiR2xxXAXi4Is9ifnQai416i/NNkNpT7hc?=
 =?us-ascii?Q?o3EVTJ0gKLLWp+e3zDZU2pEay8V2cmG7/wa+HG/DMJPuWaNlhA61ZhKSHK7L?=
 =?us-ascii?Q?R9aBv9i2DwVUoKstRouvEMIw7bbTHpDd+1H4xX779yP234orzrYhRZR2S+Hy?=
 =?us-ascii?Q?gOm0TuKRtXCw3VgGyRc6KpWh7xLZe+VOdZ09LWj42ZO5q633ZyvjMthzwQJ6?=
 =?us-ascii?Q?nZQTvhu60dJv59+2AC0v6NTOTcHJuCHFyKq9joWwcDofxmxmy0Q/QxjENiHU?=
 =?us-ascii?Q?9Pa5fjPMNNyZODH31jXwYQYcpGAjVGBPEYusl6qE3tyNUrcI7RAJHjYyPUy5?=
 =?us-ascii?Q?G01PO6JtRE05Y/AMbzQd98zU7AI5JNj01pNgJUaNM4Jv7YR78mNflaTKDfsM?=
 =?us-ascii?Q?OACChLvkUamGtcOsZQEM56g9v+dpTACISaODWMlSqQVBz6ouJKLclxhVpOcM?=
 =?us-ascii?Q?i6Ii5YBgsnumwv90IydKANl0/Q/HRnlOK4SS++T/Up6HvJ+sgqz2pvVVI6Ap?=
 =?us-ascii?Q?ia8kmqIWPJt8s+UCN/5ybOktRctWxg8IU2ZN4p7ZTIvmu4lq9FC8lCp6h3nH?=
 =?us-ascii?Q?TYu2PJbouwI3xKGzpuoegl3lbHKhpUUBrTzug8mpCPyN2qf5RTJHlsmrvRl8?=
 =?us-ascii?Q?2c/x2U6Wxtl37W5VWGCHDDRSbk0hxqyNqD7VRsfXwXdmRd7eaX6lcLnRKeqF?=
 =?us-ascii?Q?keHiauQL9Wx9Le1h7COUXkKZSoUSrsdLuUw9eAw5HgjyJJtOD3jIeMbKw1M9?=
 =?us-ascii?Q?AVMAKzOTKKkcLOWdOCQ7xLGXPnR+vUhJs5++5NJeqVt3G2bdFfp+q/q+5+KR?=
 =?us-ascii?Q?+kNV+H4mbowuAKk0brqnRZQcVOMjMThnHMf9ogH3NX3kD06REXavswZW/8N8?=
 =?us-ascii?Q?SWwfTJVRnW1qHZ+B7rP2Y8dpe07RnKwSxZ4sFe9ZA0y3aI8i/sNYOv4dozxn?=
 =?us-ascii?Q?4HEhSOBZ0p3X0fqgIO/Aeyup9hlUrp/ATrGjl+sbrhqor71u3Aru52RTAtnK?=
 =?us-ascii?Q?bHgeJHRP5OAh3sTDw762bqXyWEOwFZCqvRSMm2+qO5H6cBvfgu8it8sO0wqY?=
 =?us-ascii?Q?WidovL01ljOkR6UjcbuwqbRyJ7M/T+zH3Of8WDOSIwJtUMfqi03mktxDHFSI?=
 =?us-ascii?Q?qcMeYd8sUFhAaiGAeVbaCDFDIuDAxTcJGo9P3ReIfSAkAUMBsikmGxj7PrTJ?=
 =?us-ascii?Q?aWQcIEOKm8E3VZE6Bpxmj4xFb41cgA1XvzUZ0piYUjxJF1NrmDZpaLfMIVkw?=
 =?us-ascii?Q?vPYSUSOG62SUYV8CEaQWl9ON+2EQJ+G8mEjZzgxivwm/YbZztDkS/wbLPFbY?=
 =?us-ascii?Q?GBkoKOK4Qafn6NVzkuaJ1O/lke+0qO6aI5XrvDF8Ttshmn0sKFNCqRb2aixm?=
 =?us-ascii?Q?nZ4OmXY+CwROEo2SoOsBmJTS3ROX8eoTgql2k6sbLBTb05iRgA/v5tb4nudG?=
 =?us-ascii?Q?T03Zv4Y9DA62IhIdhogVEc/UbLMb5djVKpUDeLtKAiUd6MvwOFNuChzuPJxG?=
 =?us-ascii?Q?zKKeRFW+mIJUDdMORvI5lXWc/gdNqcM4st44bcFhnWiyCwpXQXJDNdEaCZu1?=
 =?us-ascii?Q?XAaDK2/yfsC5Vf7p36ZaMe0SezwuCbk43NZBhnoeci3H2mc5ltkGxxazqLep?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af6b7978-4191-4097-962d-08dd18c4ec18
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 02:47:01.1636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgOkxBKTft911BTBRmOXvIQWHPR5oeej/k/Zi0yKKu8Djd2Wz/nYk8pdhVX+GW+OaeHS9rWRkB/kkraWfnxAEYoax0DBQv/co5jGgUFeFTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6849
X-OriginatorOrg: intel.com

Huang, Kai wrote:
[..]
> > So in the end, I buy that the CMR's have something to offer here. But I
> > think that "why" I mentioned above casts doubt on whether
> > for_each_mem_pfn_range() is the right primitive on which to build the
> > TDX memblocks in the first place.
> 
> We can change to just use CMRs as TDX memory blocks, i.e., always cover all CMRs
> in TDMRs, but this will have much wider impact.
> 
> The main concern is the PAMT allocation: PAMT is allocated from page allocator,
> but the CMRs -- the RAM as defined by the platform and the TDX module - - can
> cover more, and sometimes much more, regions than the regions end up to the page
> allocator.
> 
> E.g., today we can use 'memmap=' to reserve part of memory for other purpose. 
> And in the future CMRs may cover CXL memory regions which could be much larger
> IIUC.

Please do not point to memmap= as a reason to complicate the TDX
initialization. memmap= is a debug / expert feature where the user gets
to keep all the pieces if they get it wrong.

Please do not point to theoretical CXL futures as a reason not to do the
right thing in TDX initialization. The CXL TEE Security Protocol makes
CXL memory indistinguishable from DDR. It is layering violation for TDX
module initialization to add complexity and policy assumptions as if it
knows better than the published CMRs what memory resources are available
in the platform.

Please drop my reviewed-by on this patch until we have a solution and a
simple story for the recently discovered problems that CMR enumeration
solves. This includes reserve-area population and disambiguating
reserve-area enumeration from late-to-online memory resources.

