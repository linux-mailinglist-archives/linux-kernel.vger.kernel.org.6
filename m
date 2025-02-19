Return-Path: <linux-kernel+bounces-522654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B8DA3CCFC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4AF1898B55
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7518F2417C3;
	Wed, 19 Feb 2025 23:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NnJgGl+x"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EE21BD9D3
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 23:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740006185; cv=fail; b=ecTP7CssHuAJVrKGA2XxrxW48H8CgsPHFuGa/F5gYLZhLQ9CaBEAZNkrID5WYmfZHb2R/VaKKyc6E3KNKFSXCmXu4yVmCbntcuv1I7U+zqnQBSwjWJMXRI4MI4GZUNYK4vBIxK+8kFtmgs1nTeSOw7Bl7PCX1uOE/b/C/Q/I76c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740006185; c=relaxed/simple;
	bh=aX5qzw/4JGOv91RzrGVUm3JzzY4G2ZBvrMdzmbufmP8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nz+kSdr9rUvD+T1Lu/NG88n2yrQtT9lhP3GN6twyxgWR+HSWR/TH21JFDqh6C/hgp4R5mF+ZR8UhEOg/bHmZu7pWK2iS0E8+xNX1PQnT1dTs/pASRALOgHvbK1Z1BxqRpYow80mICdj+aaOV6841Cj2WkvSl11Wj9Itthvc9xOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NnJgGl+x; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740006184; x=1771542184;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aX5qzw/4JGOv91RzrGVUm3JzzY4G2ZBvrMdzmbufmP8=;
  b=NnJgGl+xkj+bm3UvkaLkwiLHJWpa3bOtwuWZoBG6Yx04wGCg0WDtp81B
   TsJ0ZGqRyvHQVYcEc09TQf4V1TOkN0E1YRe9vvwlDz/3ZAFbSPg3PgYHJ
   v3BEkM9cBXv1SOX758qlV+qpT7JWDIolaEfH4FyAMc+oX5PDmfxIZLH1m
   Jj2r0PeCi4xcskIagpfpXcVR+OaBpcomFRQaQ1jvWWV07pHXcNOt7FZEr
   RTbKT4xwO8tLmCBO2n3rSzMFTm58obDaFj4iAfAd+PoEDtJT8+rYygz4w
   o6PwLnrKGHzwPbmu+59kXN8nIKTD94djV8UkWKgxcingBIaCVHD8pi7Bf
   A==;
X-CSE-ConnectionGUID: kNTt/dlrTuyYs36z3wKCMw==
X-CSE-MsgGUID: wNaxlqCYSbKvkLbZd3DWSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="66122444"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="66122444"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 15:03:03 -0800
X-CSE-ConnectionGUID: OnX5UwjISeqlIdiYfOk9dg==
X-CSE-MsgGUID: v++JoAOCS1qzxQ6Iv5sQug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="119797129"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2025 15:03:03 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Feb 2025 15:03:02 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 15:03:02 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 15:03:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rq04ua6tcJWVL7lLmlW/KKGVH61UD1aET7+/C2a8tzKsQWL1YGQHEgBoV0dkI5rGPUVUzS6GuPvyZwiKIky8O5g1G3tg+eu4hY4QEDjqfa6n9pU6qnQ2qz0vRvT1HdxbPWk7U/WRfCFNz1KKgvDcd44uSuwxGAFUJk1GeWafebgS0Q2uOJyyVjyKe+PYTV1UDL3xQemHVsrGcOJZVhGLj6pXaZBVC6xwxVhlw9LXHk5N/0gw2z+A9pIKeGyIzChQxugXkrKnq7FGmghmVeBQa+91oTZcg5FuPAdFony0fxB/CJ9t1rbbSOrIwN3vGXcicwUoDsTl3WLLGM6+Ee07Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjVfrobXCS//YU0BumWmvA/XbnqavJ/aOuNHetNuwp4=;
 b=TdQxmXdxjplCTrMp+h3E3PyinJq0dhYrw/GLFXQu9b9XauzEIRdaAHo2HKUMFzstZxS10WHJnqQekLVpXmvPwZCMas0z5jTUQZvIEFVKOULGSrke3WnyxiWcJnSG/IxSJ2zSJg9G7tNZO8104m2xQjziEkVCUwp78MPZX4/ZAgRRkhclChr/N2g4c4c9FgTBNnjSrgvh1WG+S8/+5h/0ICeRt3OrgzGbgkJ4rRerStoaZFKEz4k00J2idDkdOb/aTRZaCBnDVM3+ZgOMRh9Hhb11KxZLuznjuzuAwhQwjFcWbUMSmjHX/B/57bmsK9dALHKIegGB7yC1WkTcku3pNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB4884.namprd11.prod.outlook.com (2603:10b6:303:6c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 23:02:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 23:02:58 +0000
Date: Wed, 19 Feb 2025 15:02:55 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>, Dan Middleton
	<dan.middleton@linux.intel.com>, Dionna Amalie Glaze
	<dionnaglaze@google.com>, Dave Hansen <dave.hansen@intel.com>
CC: "Xing, Cedric" <cedric.xing@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH 0/4] tsm: Unified Measurement Register ABI for TVMs
Message-ID: <67b6631fc7054_2d2c294f1@dwillia2-xfh.jf.intel.com.notmuch>
References: <01fc0997-a0e7-4086-b0aa-67b4a51b328a@intel.com>
 <12ed2ab1-e97d-4a20-8370-8c60cabffc77@intel.com>
 <ab2036d5-5b6f-4fa9-995a-fba63c0a5209@linux.intel.com>
 <f4d344de-70c2-4fd4-bb18-2912cf0f3f98@intel.com>
 <CAAH4kHYq7_3vLXQaCA7iKF+mC5Pg0cn-1FsB-iCbN7Jim9a-OQ@mail.gmail.com>
 <650b6236-50d3-4932-b5bc-056fd29c93a7@intel.com>
 <CAAH4kHYye2ApqYb3GmHSt2Ge4B1m55mA54Ch-f1RCzh3GZuHOw@mail.gmail.com>
 <cccce005fc19dc05caf67c454bd669d524c862bf.camel@HansenPartnership.com>
 <8009a9fd-c7b1-48e3-af8b-8f481328c597@linux.intel.com>
 <6e773bfd1275d4f8c7df1ca65e22ec42eba12a8e.camel@HansenPartnership.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6e773bfd1275d4f8c7df1ca65e22ec42eba12a8e.camel@HansenPartnership.com>
X-ClientProxiedBy: MW4PR04CA0188.namprd04.prod.outlook.com
 (2603:10b6:303:86::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB4884:EE_
X-MS-Office365-Filtering-Correlation-Id: 0043fce9-d1fa-481a-6415-08dd51398d7f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hB3ftbujNiRFpaBircPWz6q2Y7P0MOdwDBfqgVOhyc9z1xoyqBb6imd+4f9Q?=
 =?us-ascii?Q?effqwt1JmP1FWaBmreu01BoD3s2GPJoDud4J2BNh9WIR6lyjNdmb5txObXLQ?=
 =?us-ascii?Q?kxI3xh1gIIOJLPy3+kPWhf7SRuySOd4WmBXnVIzFIgBct4f9qQPiPpNGk7Ey?=
 =?us-ascii?Q?+LH32SspNCzgrIhA8BRzHU/NRNFOBQmC8ua3xgMw4AUVa6eCpauQd+1vCvxI?=
 =?us-ascii?Q?Kv31EvVBLZQIQvtczMX8a/Y8ow/NsA3/ZhD29bVmeJk94ZnYxe5RhcAKbb0a?=
 =?us-ascii?Q?46GqeAaNwNnckxb2lG+gmAgh2gCkJ8IXvhSvmCJOeRZGGqAMSxPc9j5afKDc?=
 =?us-ascii?Q?0924mzGXJzqmy+1EqERiwh6vyCFkxGmkB6IuAaE42clYayd+72D5C7LqU6C0?=
 =?us-ascii?Q?BCgBB2+HU3HQ3hFgT+DJoxxMPwHfhYl44RRZoFbD4LmYlJAkQuSa/E0tMSE1?=
 =?us-ascii?Q?Q0UqkNMJczG16HGZzayGFN7wZmRrsfn5GwzWfszyJLluQocF8IEWu9QBP9oQ?=
 =?us-ascii?Q?ouaDWUmCoUrKGy2M8nuPsyW4K0X9ID3YcrZpNSkfwHxlJtBzEekJHZkixZgT?=
 =?us-ascii?Q?N9D8/gFWHRlv9oNAdWLAQta+Ui8MRzlTaLPMAPfsfXOUe5forUsaHhN1LM5m?=
 =?us-ascii?Q?p+5lWz4HORa0z4ybGlwd3qWU/SHz01xx8XxlPBsDcoR9p0djWuk35XkLhZfk?=
 =?us-ascii?Q?S7YtCAZpzDrd3hu37pK4KjpAFfaUY88SJmPCMMMgIeazqv7oCrr0zjyIzpOG?=
 =?us-ascii?Q?SpbflUQfqjNhX8XO1phhXiB1lFoQN39roJDqTgZssiMS+UAfWsi6I79Txcmh?=
 =?us-ascii?Q?J2iPhIPibZkUL1Z5F/43hfjQtfKYXGPCON7vxnWyu3gJZFuyR7+qJZzrsWJx?=
 =?us-ascii?Q?Xvkan6DfI1GwbPgBpNKjHRWx/BMVgwuMwZrZsO8qwtRKPweVQZ9D2CK1lSAh?=
 =?us-ascii?Q?ij/snwFdk2od/16LlQ3q9Q5UZABXLOKdqeR44zHrtwlywAFsa+k14l5w8SEq?=
 =?us-ascii?Q?QrFSEx9uyYyEVXGePHUElIBeqrJwED3/nQnz5JObtfziQ5BdjvVkC4y7he6G?=
 =?us-ascii?Q?p+o3+J6otrjeNTEl1V5I4U1lYMwYp3HeyfM4ZDfBeM1nr/RE+iP6+nb3Ti0c?=
 =?us-ascii?Q?XGBFqJNfCfQaBis0Q8xN/kNjKu9tuvuZckn8outYk0CdZGX1xgoaXMp383Kf?=
 =?us-ascii?Q?pSBC2aC3byVUPunGmAfn44ubcceg673sglNGzEuiwOpcju8sIgxkA3KbAkRk?=
 =?us-ascii?Q?htyL+fPV6jUkOJJKxc7xAp5yw7kEI8c0NPhNdMpufa1K3b9cpZLAtKb72AyS?=
 =?us-ascii?Q?AvvgKGvA4pHhbHPY78FkzsbhIQz0dEimNUVE16kQTW2bDgtqGzXKHRq8yLtL?=
 =?us-ascii?Q?NZ1LiByD7EiRAOgnzCcYQwMRJvR7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5cp/T7uOiV2q/ADcp3wNHNaspbTgxh0pyA60Wacl04raInLD6UKA9fPNRxn8?=
 =?us-ascii?Q?ze4n10D0dDcaiQB0uAdfAEU81suqKiG+B1Gq0bcc5F76Xu66+Dad8Vr21vT5?=
 =?us-ascii?Q?ArjVTO8QubuSE627wkPEMLat3trKp4W7qXxQn3hM9An2XgwCEnbnIPqBypK6?=
 =?us-ascii?Q?KA9qOZDQn263JYNZjbCfXeE77NrsfsFu2hW+/NnafLs/A65GolDX8bH2U/CV?=
 =?us-ascii?Q?rGd4TnML6TCqmZATjI8o1lWwND7yhp1I73+DEQTegfEK8NVf72xAZMR8mF9H?=
 =?us-ascii?Q?FFS/gDsz7+Aymjracch34QVRLwNlZ4hge23RYJzoyV7jfaJdYJOWuj0mqOOw?=
 =?us-ascii?Q?Vb3LwzuwYaFDg7Dfp3wVS99/6rS5OMJ3A/UlNKPNzONqZnVst2rmu/YvyxVA?=
 =?us-ascii?Q?c0x7DIaZWvwbOxzxShagCPkwtfXX0/BiOhEc65amneaA3pjbW/WgZFzHBlrt?=
 =?us-ascii?Q?tyy4q2gcIGVcGZ74uHHmbhEOWVGoavhgiYKDAQy+LWlX2YeBYtlEtpZDSAsI?=
 =?us-ascii?Q?0v3uOixB7mJMIpENpOO6a4HLD5ChpD2ODPSKq4qCBiEIkyYK9ppiHPlYjG0c?=
 =?us-ascii?Q?IOgd9clAWFBz3a75s+NhFV0KCZdkyEJQYCM0x1jCDRxOqW7l8MDp2x4Nx0jN?=
 =?us-ascii?Q?HnacNw0eu+WYy9TLYznZseocITzZowpZwhCn8MXU8F+olBaFsz4gJkWIGy2B?=
 =?us-ascii?Q?NDjYvtU0IKOO0ibakaCikuw9TDZTNuZwG2e6mNKhzF0b+wWt1IuknAykVQzs?=
 =?us-ascii?Q?UkH1TkS6Kowf20pgg9xn7vR0s+8FXThaib6ZguR9MNpsrDdSB3XSH8ycunp6?=
 =?us-ascii?Q?BXIDL6Ebp6NKd3ed/02B9B3JqX1QZxGpZFDz2WqFpmkkvskxokFoklCgLPGG?=
 =?us-ascii?Q?VMXhbDExBxpUKVnv9XUFkqEyIBjVBhHIE1/48aJfBfPrFoI5WuwA+IZruRz0?=
 =?us-ascii?Q?1TkWkf2QH79Gk8fkUFsQPLtfYlygKZeZAMPkCWt5u7bQYIs01XBJf5Bs2Wu0?=
 =?us-ascii?Q?qu5H53InzYgr/0/FJ3k81OQkRjGyI9LO9Y/ipa5XNUlPEJZZ1mKVpl1L7tgD?=
 =?us-ascii?Q?vWJM2Y8nPxcNDPWjmY8EeyfUU5Lnv3nI3kk5Q9qaZufuJx6Fj+OBKq68TUYO?=
 =?us-ascii?Q?e/ni1/4bXKgk6lo9pcUy3eARAdXrKK0XtAa3mOxYCrVfoRfdWG6SD7tRmKty?=
 =?us-ascii?Q?coZU5S4tmmV47YmfrzeiUSFr8bEN0Cs3rjqXDwysmpmL1g+NVJtTLJ/XCTz4?=
 =?us-ascii?Q?k23rUEBDLpwf8tMnkCb+0boQ/syQjJRyTxXr5g61n0hTZzHwtO2VStRIVQLm?=
 =?us-ascii?Q?dJDjDZhFxNsLw9F0lSl30sbF+pRPEGMSbuaRWOuS4rj7iJ8TdWrRUTxwNisp?=
 =?us-ascii?Q?XLBfKlmyBIuQAM+pbex8lfWUxs8TesMHkWXSMWhEyj8I6iEqSDQgi04mDiD6?=
 =?us-ascii?Q?xFuQltDa9iTbPi4a4HN3bin2czH2JgO5i/zbmEC9GBPwFNky+YRw7mYu7FTv?=
 =?us-ascii?Q?TFh4bgMyiT1tb3QaL5CgH9+e6QcSaoCPkPGXTfnj3AR/IFoLWLR1aQG1ukxO?=
 =?us-ascii?Q?xbn3JAeIY1/bo4IVOhJYOVNOfk7Sr1qwJSeL7xgA1LNqAGcGspyrLdO9mFHe?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0043fce9-d1fa-481a-6415-08dd51398d7f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 23:02:58.7989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LF9OT2bg79lgccA+5/3DK6UAvTRbHYFrH0R1+lwQ6y0CfZws9RUAYN5yGmUX8k/6WF+h7unVT9jeWlqE3EHMBOJkgJSYc4PSlyT8UWEa5yk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4884
X-OriginatorOrg: intel.com

James Bottomley wrote:
[..]
> What I still don't get is this.  The difference between RTMRs and the
> subset of TPM functionality that also provides it is non-existent. 
> It's like a distinction without a difference.  If the SVSM authors had
> written for a pure RTMR implementation (just usng a CRB API) would that
> have made a difference?

That is an interesting hypothetical, "would things be different if the
authors, that were forced by SEV-SNP architectural necessity to push
runtime measurement functionality into an SVSM layer exclusively, had
considered that some architectures would include runtime measurement
functionality in the CVM technology directly?". I do not think it helps
because that presupposes that vTPM for these other architectures already
exists.

When I look at the proposed solutions for TDX-vTPM based on service VMs
and other complications brought on by architectural differences between
TDX and SEV-SNP, and compare that to a potential vTPM that wraps RTMR I
see a net reduction in complexity. In other words, a path to a
cross-architecture RTMR-backed vTPM without requiring SVSM and
approximation of the VMPL mechanism. It follows that userspace, not the
kernel, needs to wrap architectural RTMR differences to build that vTPM.

So to me the question is less "RTMR vs TPM" and more about vTPM
implementation choice where RTMR-backed and SVSM-based vTPM solutions
are not mutually exclusive.

For the kernel this mean leaking architecture specific RTMR details into
its ABI and punting the vTPM interface problem to userspace. It also
means that software, in some cases, could forgo vTPM and use raw RTMR.
However, I do not think that ultimately fragments the ecosystem. TPM
momentum and portability concerns limits how far raw RTMR usage will
extend, but in the meantime for use cases that "don't want to have to
depend on the vTPM", like the one Dionna mentioned, are enabled.

If those use case ultimately melt away and transition to vTPM (whether
RTMR backed or SVSM backed), great. If those use cases persist then that
is also a useful system evolution signal from the ecosystem.

