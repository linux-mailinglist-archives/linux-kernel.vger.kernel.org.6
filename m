Return-Path: <linux-kernel+bounces-286625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75627951D8A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95EDFB2C8B2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4FE1B3F0D;
	Wed, 14 Aug 2024 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RxHgPkNj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1861B3744
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723646032; cv=fail; b=qSxqKCbA49/gR0MsfjiymvWWMx95U5FUZNUBVHlGofDM3A1PvauSvIGGDPoj2VvcJ01T0sQLbscG7v4UNTg9Sdj9anTzS+VK+yvCHRu4OjLIo3DYay7R0emBiMxCBorCCemIPfP6X6QAnexnqFWIJHL6MGVo1tILlqtacXg7NfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723646032; c=relaxed/simple;
	bh=s6sggYRWDdeuwa+cfZ2920hF21WbnZuHvcV5ipeFK74=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K2/cNJVqZFfs5w8/5u7qklCGhfY4QoGkrFKyLDAWxo+sVYLP47WeEgacKNuvs+4uk6kTc64/9CpU7dbcT9JRSWHUXTQ80IMxu6F0mA+tKiectxovEz/4IWK4CfJf4cz9U5foILYzmSxC9s71mUPraTTkGbHrsWNcQjz5ldvJ3Dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RxHgPkNj; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723646031; x=1755182031;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=s6sggYRWDdeuwa+cfZ2920hF21WbnZuHvcV5ipeFK74=;
  b=RxHgPkNjZW1nOdpOaCuOvLtEjxe9hECBsmx+NJL9AvP2ucbhfkmAyZ5W
   qx7UwcuukFnA0bG9Onyp74ywlM5DpdFz8GiQEyeFUohxk8M5AZUJ1Srg2
   n88zro6cwMck4qd/k95JF73J1LgbOHaUqa4Df6r1fqPUf4FqUfx3WRekX
   I2miNxjtrnbJl20i+CfkCzywwiF8YgEuW8eQcILaC3ZIeGEw1zUHBORrF
   INWzpgny7n+A2Xrncd+HrBA85IVWIfD11O5uZ4K5/EXtwncD8luOp1CK9
   7gMBTDfWC0AP73CUzBMA+ClFTOt0Bcx1X5Hzxhx4ATdo0K5svcmY/Cs7S
   Q==;
X-CSE-ConnectionGUID: zq4GmT37QD60VdWvA5bFeQ==
X-CSE-MsgGUID: sbkOWBjYRpiPvuGH6HgSbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="22018387"
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="22018387"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 07:33:36 -0700
X-CSE-ConnectionGUID: I7QKr/f2QHuF08gIhSO2cQ==
X-CSE-MsgGUID: dSwI/+moRqW7ta5az5n1Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="59008652"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Aug 2024 07:33:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 Aug 2024 07:33:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 Aug 2024 07:33:35 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 14 Aug 2024 07:33:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZL+9luwQIijHektMq1T0uD1sbGfBCgqTEgdrS0YD2WNCfqFrrIidI3Cej7XqTtJUViVwCLuUuulex/eYP3Pu4tiKtJJea9t7/OGpNiSK41Zm4Zpn5wO8StLvGfO5uxYRD8/nfjWoZSZW/zZvrC09vDDgNsrYZzkXS1t0LlQ/6BTGuExMkgJjGD2JZVgxW09E4b8mKDHTyAx+KwMPi/fY4L6+ueRhEljxEiWRNLRSS5oEOFEqU1G4r4uOZWE6UOZol4t9A/k/OqHEJKu5YlCGnNTlYIKzhobYPDonbcw2k+r56vh4tkwOAdIhSfyxQrzvR22WYRprvXVWED5t8ybLww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brcw+k/6fY7LynuZdBHhzlToHXwgmwgXpv32prFLblU=;
 b=tSeNUO9Lk53dwAKmHGQaEReOsijr8nRJRRpIx+fKUgY2WiiWNR1BlDDu9QFJkJIqD+f+hZL/Teh5t1lPJ2HOUXR/zoqYcokNUQ9eJ/1awZLSLkKin/wR9znDGyLQqr7uYfK8M4qEhPtwck62QKqgAWUuaWOHGLaswQ7oGMtFLwZeRQqVv/wyVmsBWdZoZxEZeQ8iqrb6qgeM3OHC2ctNx48ay7TUnBOOc3fsUG1zbEqvblXE6+fuwBHT6mkC82nHJ5GLjdnYsYx7OEeYvhGZ311badlbPnUX/K92VlO02ZNUC7xbRJNqOdkn9f0Qpx64LQ1cDMgu9WZinluvXwscPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH0PR11MB5219.namprd11.prod.outlook.com (2603:10b6:610:e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Wed, 14 Aug
 2024 14:33:32 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 14:33:32 +0000
Date: Wed, 14 Aug 2024 07:33:29 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Alistair Popple <apopple@nvidia.com>
CC: <x86@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	<dave.hansen@linux.intel.com>, <luto@kernel.org>, <peterz@infradead.org>,
	<max8rr8@gmail.com>, <linux-kernel@vger.kernel.org>, <jhubbard@nvidia.com>,
	Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linuxfoundation.org>,
	David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>,
	<linux-mm@kvack.org>
Subject: Re: x86/kaslr: Expose and use the end of the physical memory address
 space
Message-ID: <66bcc0396d8d1_1c182946e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <87seve4e37.fsf@nvdebian.thelocal>
 <66b59314b3d4_c1448294d3@dwillia2-xfh.jf.intel.com.notmuch>
 <87zfpks23v.ffs@tglx>
 <87o75y428z.fsf@nvdebian.thelocal>
 <87ikw6rrau.ffs@tglx>
 <87frr9swmw.ffs@tglx>
 <87bk1x42vk.fsf@nvdebian.thelocal>
 <87sev8rfyx.ffs@tglx>
 <87le10p3ak.ffs@tglx>
 <87ed6soy3z.ffs@tglx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87ed6soy3z.ffs@tglx>
X-ClientProxiedBy: MW4PR03CA0285.namprd03.prod.outlook.com
 (2603:10b6:303:b5::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH0PR11MB5219:EE_
X-MS-Office365-Filtering-Correlation-Id: e68819a8-ac6f-4716-2817-08dcbc6e128e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: aTSLqSmOvlR8rUK0hUD9+WHI5OvZl40NGBQQK230DwD0C1jqH6XDHUAWMrl/34qTM/4+4izipzyt38BFlAwf6w7o0OWXSefXTIG24BULT0hfnc3K6y7Sd2Srx/cAsJ3Hm27CsHZtVwzSYGIZ66ci4BERyjCUleKU3AkJiLKcGl2GRuPWqoxOybocGIes8e7+ZWe+8QweuKJ8Qw+dEESbWyzAIqCFQy4rqSQBL7q8uR0OQ9nZKOdaWXsGhOd4N5P7+VBeQFKh/UbyEbm7cfiUUVWskLHlbrtMQAGhYlGz9zMz7VRDS0LwZVpIplm7+u9kH8BSJd4pmM7vL1/2U9wb5KJQ1mzNUgAVusVyOTopUPH9Dmj3O1PCtTIah3Ej3rlD1gO7feQUULUBFoY6AdKIh4YgESYeL7GIQagJQPEDJT9uumTSzNlPXIP0uWixnJ6lxzPAWIQZq9BMArHmj9hdS+l5c3iSoqTu/SImAEoR5yBl7hR/miYF3Sqzt6iAPAdDU+b3ioUcNmEA8+XBwU8O+xgMOOYNOAdsA3RkEXvPkC3VMFcvdGDjI4zic1U13t+Ee2SOPI6gFvkZb6RiiEVk5S1eE9GGHpzcHvKV4CnUH9sS4OzrvkStPf2jJvietC4OFkq1K418JX6hSjYWU87EdtxEE5JPVI40y8HU1I5ch4I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8j7dwg64mfG8L9ZPvzEUb5knhO08IW+rIh7fjI8EyM+wANQC0kSKz1bop/rl?=
 =?us-ascii?Q?lhNHPzLnWd2UP/glhn8qc3qqgUeV7dr/WWIV0hqjWNDpZ+TRrM6xKLjuWOJh?=
 =?us-ascii?Q?uKY+VysPwSRDgiDSxaBldqBVToWoEz0TBNjTnP93MtPlSKAhAsgatgUXwW+H?=
 =?us-ascii?Q?Kqk72PBFWDg9aqMqZVVjtuGAzeM/kMkS2se+RqAv5NPsjWsEaAbtAaIiCxNn?=
 =?us-ascii?Q?IvX9dxnpgu6OfFh30oDNqn993flafsY88rOMRq5HNH1S6F/7l57ZGDPNyTfI?=
 =?us-ascii?Q?gZ/5Y2GO2OlGb7ylgg4jEMxMExwVSYulnKBCZk5isWwN+ZrbaiS8+XJi95xH?=
 =?us-ascii?Q?WqY45kvcor9EipxCKYxe5GrS3SrDxMrUSVuO7D/P/bbQlK6Yko98BRngjnKZ?=
 =?us-ascii?Q?OKF65AUaz+rUPQpSXkTkLolSp0wuSxEU22U43XO2Edz9CHrluwttBr8J0i7Y?=
 =?us-ascii?Q?ODnYvKJAxuaCoHz1NOAqNKPHpQ0Iyc39gd/395Sqmx4HNNf9Wr1iBCHNWFL2?=
 =?us-ascii?Q?+OJJuY83nQqZgPqToTOl5PX63fIi7bhrDDUVV80FV6JIOlc6aa7YEXFGQUet?=
 =?us-ascii?Q?/71NwyZSgX0gwRMsShwhjDa+B3nPhQgZKg/aF2c7nRGQxL9U4czWPjQw8VXZ?=
 =?us-ascii?Q?Zk/xf3WF9vEt/banUeXHEWXTmJ7H09DQKydMMk1yWxvusEkTPXghkODi9Rfi?=
 =?us-ascii?Q?rNsFovF1B96oIIq6bfYnPaObCHgt5R8+UPzitwoT2kNtG84UmNMtRRLTZfSr?=
 =?us-ascii?Q?vwFNNCuNsnGUNGixAUehTur2VQ7vFm1fo3vkHseZ6ceNUYWNS4MNCcs34CNg?=
 =?us-ascii?Q?3r4PVVxzSZth9ZRDmOmT2e68Av6ZACfSknbYBUqLVICKXl/HBCY1r+IM7Tl7?=
 =?us-ascii?Q?P/arGSbdc0PAPg4wpuswUAuVuxn8Vl4a8FbT4ihMfohOPhRi4tc1LhEOknoN?=
 =?us-ascii?Q?EQ1SSuvmzqZVdqX6PEuoGnIGgm3Wrvj7fViSlSU83wm+bVpkxxeRO9CrlSeB?=
 =?us-ascii?Q?s4N5sK+75zVge7WA5v06BfYtdCdjJAYuDLU3gyslBV+cz9+6VOsEnOi/K21f?=
 =?us-ascii?Q?JjTym1v1qsulWrCiD1EFLGpHwDVqRRERFGxQyFTqguwefd/Uqtm9X35YNP7O?=
 =?us-ascii?Q?/9hLs09FhMFyNM1HtTcUvkTHs3eecUks7oCzE8t08rj3NNKGBTvQlXpah9ft?=
 =?us-ascii?Q?0GiaCfVlbHQIi72dP3NGFstv+/igBwFFU/7SDhqg+IJQzYB5hkx1nhmLqXLN?=
 =?us-ascii?Q?WzvxzzngF9rlljW6pmk6pYmyMZC4fbJJVwsH7WM8wdXaMsZAXEjtdQnmD2RZ?=
 =?us-ascii?Q?Qrc1F0VlDNBhe3boConZ+4F5UbZQSk0rnfa8t9z86Lglm+J6JxoXN2MqzW9m?=
 =?us-ascii?Q?FbIZ53DLeRQytoM2hRJ2xnWq9/tIG8UZo7IQ3paD666Gdm5570Ld7PxJjM6R?=
 =?us-ascii?Q?lFi6mUWj8m8dw8T4wa8tiqBerwZC4Z2iQsD45RWuXHO+HwNAG3e80KVamAvf?=
 =?us-ascii?Q?hACHh2QpNnmO6Lj4c+iYWMYvkkzDUPQeW9rAO5UvvWMC1gzjvgD64aS3AyFf?=
 =?us-ascii?Q?ZHRnxY5p9RfAdlv/+YC5T/X93nbLN4++9H0S9gpJpQLo/8Ibkyxfprenu2pp?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e68819a8-ac6f-4716-2817-08dcbc6e128e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 14:33:32.5917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9K5wi+pBKYBfrRmVunhWbB9kkqubaCYpwDXbC56Mt0UUb5Fs+SuZCwOLXCo8pw4d3oD5yXd7OPw3pkhBeYuUa3+s9phYdJenElh9QA/jl7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5219
X-OriginatorOrg: intel.com

Thomas Gleixner wrote:
> iounmap() on x86 occasionally fails to unmap because the provided valid
> ioremap address is not below high_memory. It turned out that this
> happens due to KASLR.
> 
> KASLR uses the full address space between PAGE_OFFSET and vaddr_end to
> randomize the starting points of the direct map, vmalloc and vmemmap
> regions.  It thereby limits the size of the direct map by using the
> installed memory size plus an extra configurable margin for hot-plug
> memory.  This limitation is done to gain more randomization space
> because otherwise only the holes between the direct map, vmalloc,
> vmemmap and vaddr_end would be usable for randomizing.
> 
> The limited direct map size is not exposed to the rest of the kernel, so
> the memory hot-plug and resource management related code paths still
> operate under the assumption that the available address space can be
> determined with MAX_PHYSMEM_BITS.
> 
> request_free_mem_region() allocates from (1 << MAX_PHYSMEM_BITS) - 1
> downwards.  That means the first allocation happens past the end of the
> direct map and if unlucky this address is in the vmalloc space, which
> causes high_memory to become greater than VMALLOC_START and consequently
> causes iounmap() to fail for valid ioremap addresses.
> 
> MAX_PHYSMEM_BITS cannot be changed for that because the randomization
> does not align with address bit boundaries and there are other places
> which actually require to know the maximum number of address bits.  All
> remaining usage sites of MAX_PHYSMEM_BITS have been analyzed and found
> to be correct.
> 
> Cure this by exposing the end of the direct map via PHYSMEM_END and use
> that for the memory hot-plug and resource management related places
> instead of relying on MAX_PHYSMEM_BITS. In the KASLR case PHYSMEM_END
> maps to a variable which is initialized by the KASLR initialization and
> otherwise it is based on MAX_PHYSMEM_BITS as before.
> 
> To prevent future hickups add a check into add_pages() to catch callers
> trying to add memory above PHYSMEM_END.
> 
> Fixes: 0483e1fa6e09 ("x86/mm: Implement ASLR for kernel memory regions")
> Reported-by: Max Ramanouski <max8rr8@gmail.com>
> Reported-by: Alistair Popple <apopple@nvidia.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[..]
> --- a/arch/x86/mm/kaslr.c
> +++ b/arch/x86/mm/kaslr.c
[..]
> @@ -134,6 +147,8 @@ void __init kernel_randomize_memory(void
>  		 */
>  		vaddr += get_padding(&kaslr_regions[i]);
>  		vaddr = round_up(vaddr + 1, PUD_SIZE);
> +		if (kaslr_regions[i].end)
> +			*kaslr_regions[i].end = __pa(vaddr) - 1;

In the context of the patch it is clear that this is physmem_end, when
someone comes to read this later maybe a comment like:

/* 
 * KASLR trims the maximum possible size of the direct-map record that
 * physmem_end boundary here
 */

With or without that the patch looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

