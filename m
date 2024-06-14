Return-Path: <linux-kernel+bounces-215486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC1B909389
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 22:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D8381C22FAC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 20:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2089C144D12;
	Fri, 14 Jun 2024 20:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YcoAsVRi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE57A945A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 20:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718398074; cv=fail; b=Y10riWk8Mc4OY6MS2Aogq+KKhPcw2/2x6Ihw+KMngChBeKN8FqHqV2roq0I3Duf+O1bnHM0Jpb+/lVzn8n4lZfAitFjHLtY4EuluUgR5rkZaBHs0yOFoL4TsJipKCbmAUN0a4WGTPXNwA98nY0slf2mDYv/fd+Xi2c1OlJr1NKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718398074; c=relaxed/simple;
	bh=3FNJvr2/BDImACIcGDRWKatxyQqfTIjPdhEiJ/hII60=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RkKykHUSR7BO48pg0gOOmaea0POVK7SwU7lEVccjOlR+htY3Q+Aa/IF8o8cLxpSTeumRAsAhgMLTwJgQM7HdIEEjpPXXhENyyPLXG/PNSPwQPxQv/fiPla2V1OWoHzjEZSsMuWAsXAnfQ3UOh+f1u1PYZt8jhot2lolfW08R/5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YcoAsVRi; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718398071; x=1749934071;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3FNJvr2/BDImACIcGDRWKatxyQqfTIjPdhEiJ/hII60=;
  b=YcoAsVRiYOcvS8+Atm0Yq3V4BudTAtGuC944dKYw9vCPCK9ZnSLRgUwc
   tFh71C7aHyVWmoZyHjhoPon6AzFGQv4QXvg6eEQtqTvNLfq05gqNDCDLf
   5ouTAMBNz7jSoGm7UuP9YSfpbEc75PF4xOPOsYTIyHJ/3wXSupe2HSPhU
   ZcgaWApJPGVE8fU+edEvm1hzA4vfFjy4KDpDyNRtli3wb/ouewTkCYv8y
   bfkKMFJWq/78+O3C4Vi9vFh/LisC/SyQjhATpMjB0FFHZCdvH6czKVs+p
   hKrAKSGLHC1Iqxiy5lPgJbMSDNoPZKS7k8MQbEav7hDtK843NYlPTYNI8
   A==;
X-CSE-ConnectionGUID: gK+dHk53TPakI58z3sG7Pg==
X-CSE-MsgGUID: fMBuxSMVTpOFWBQhq06/yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="32849137"
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="32849137"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 13:47:51 -0700
X-CSE-ConnectionGUID: CwOhtshlSBOZhVIqRrBkcA==
X-CSE-MsgGUID: m9DmMCtkRHu85bHhqmDruQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="40712545"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jun 2024 13:47:51 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Jun 2024 13:47:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Jun 2024 13:47:50 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 14 Jun 2024 13:47:50 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Jun 2024 13:47:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GtVe88VjEITYeu+gvEbX0odXjAzDeptz0+/R+EQYHv7DJNC1bN3K5WN5YXzLtXc2ImWTmGkO15OVICSlY3r4POMsle2LV/EQYn69key3mT4nPpLbxebjOqq+19tiXfyw8ukSybqD92PP0CUcMyCTNmNJfM17Y0cz/ljuyENroN6ikDIIEbZatuvlNytqlTrZXDlA14HII3a11zFRtqGfK87mjLHX9fIpn7OXIG/d3G6IwflveKKLQ7IteA+IvwG3KWqt/HEplXLuhtcd2PVIbW6mRZ1hi0OSy+jgpZn72DIUrCj+19omg8OaH4Mj+tXm22Ma6F042sG/LzRjHZMmTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FNJvr2/BDImACIcGDRWKatxyQqfTIjPdhEiJ/hII60=;
 b=X6kukaLZMhmsu3ZGGaVyvBxQ+wewT5+fxrsUBriM+EasgCdyzG6TozYMh6UFC/sCjZ7Yys0cEW2EzeR6k2wDo/TXRiPgv8IJRztR0wgnYGIsf4bhlBcc08eQN7rbZxFKCpT2PUbSBSIFG9PA/8ve3HQYFf3JUyGm14+JvZQe5GO++MtgH5DCU+mTfHbrpa2XF/dMhv3+Wz81w991jKkKKIpUymWo+l4nuod/cenDJlknvsE5isv3MgMsPzyrCmb6RglpuHkRsxMlBWXQVD5VLEBrxYN5SZJ5kFzalDkiTIHtT1iZUSZSse1j/03YjItUFuwNu26R8A9AcBNSRlS8JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7166.namprd11.prod.outlook.com (2603:10b6:510:1e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 20:47:48 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7633.021; Fri, 14 Jun 2024
 20:47:48 +0000
Date: Fri, 14 Jun 2024 13:47:45 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v5 09/13] configfs-tsm: Allow the privlevel_floor
 attribute to be updated
Message-ID: <666cac711f1e1_c79a32949c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1717600736.git.thomas.lendacky@amd.com>
 <5a736be9384aebd98a0b7c929660f8a97cbdc366.1717600736.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5a736be9384aebd98a0b7c929660f8a97cbdc366.1717600736.git.thomas.lendacky@amd.com>
X-ClientProxiedBy: MW4PR04CA0080.namprd04.prod.outlook.com
 (2603:10b6:303:6b::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: accde41b-9785-427e-c1df-08dc8cb34006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|7416011|376011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EHdVyhnM+PtzImoB0ickFWP73RNI6q/LNdpQj3WLkmuM7A7BG8yiKYpLVu+G?=
 =?us-ascii?Q?0yB8SKzOsbyMgazvKvEj5xSi6XKxH27vgPvzFhs5HXSn1wIDwxq3IH+vB++C?=
 =?us-ascii?Q?YRtfkYgDBKbRLHXnXkSLnKKEWLX64Ggl8mdA1TOtTNohMdFup5+LQ/4k37Zu?=
 =?us-ascii?Q?NieiYVgNHNVo+ZOnnaPsOBn5qLhhchl9j4FvfJk0FWsm9iOfpgrd98sKIpIm?=
 =?us-ascii?Q?fsgGPTlUGR2I5T3IGZA7qFIMsK/LSPiD9vWSFoy7v6tGr03YO/r1UeOg2o7j?=
 =?us-ascii?Q?mC76oHpiPIaeLnV58XSZ+kM8kg4Eesuj2f58PsuLZeqQabPD21HQA9kTcQpF?=
 =?us-ascii?Q?XEoIcthwngwhBfMAoMt2QtYJadnm03zT5HeQV+/UMi4RHrNqSDbS46ra6/xU?=
 =?us-ascii?Q?VOb6GFKldKP5yzzB/88P6RW3+R82UHnCYSE4isja80T6RXxmk2wmawWnDuWs?=
 =?us-ascii?Q?SAGf+zKcxzhTB5bMpefGl8QfQLE0hkeHLr0bFM7et5+1b6QEkqLoiKfR7igi?=
 =?us-ascii?Q?DYEab3sCzHpdGJlfmnH2hN8ERP26wK02Xc/DZugSZOw+9Pg5Overtc/Fa0wA?=
 =?us-ascii?Q?IfsAMeZZtD2FqtpDrCvF57b9J7oi6iVV7kDzKxPkw04O04MKReqtW6V6WPHy?=
 =?us-ascii?Q?AWaO/duyookINa2XTXkB+Iodn1RE+fbt3hNnUfPqdHQMlVUuK4Y/BH2wPGTI?=
 =?us-ascii?Q?u+Kw2vdU72DeUUV/Q5FT2t2+36/FenXxfVjhQb89jwPvZ7b6X8DuRBBkOVta?=
 =?us-ascii?Q?eitvMTSnp3upbtk1ysF53rd5Z6CZUPla7Tm5L9D3iHXMOy/NcnOB54HgO86M?=
 =?us-ascii?Q?MN4HF0fq8nwSbZ3U65lVjQ6J+ZvHmnoC1I2IhTHfPsGPKT0Aj7wIGvx1vC74?=
 =?us-ascii?Q?80GmIKkW+uiwow73pGHvhHx6ZymMAJoQLo0NupvtxUONPqgERjFGlddHCLrM?=
 =?us-ascii?Q?2d4w1608nF1x3Rwu80L1CEQQFqGkXR3n0W4kKC1lrqTPvzyVn20GYvKVMTqE?=
 =?us-ascii?Q?LwPxiJvs4eyXsVAf31rggGCYf654TzhHDd2EakDRMqczpmxAvytjd7C80Mu3?=
 =?us-ascii?Q?nOnhwm86xJkTSpR5M4L33uRt2FYEGrnJVTFVk1beg4ZzTO0RAWY7/LJJoG4V?=
 =?us-ascii?Q?62CX63QlfqA4YvYc7m7FMTx6gymTtR9KeLbGyNlf6WVnoJHC/LrSs9ajUVfS?=
 =?us-ascii?Q?uCD0T50LOv64G5JuS3naJh0H/dniKZaty2+GbCRjqTbXDoO9+Q7AsiUmqA7l?=
 =?us-ascii?Q?RBHXU+XxTY3nCkb3RkRKgkSI4wq4fZC4ezv9GRiN9SSyHZN/razYlJ4jrl37?=
 =?us-ascii?Q?QT7K7Mc0bO4AOvQgTwp/oYje?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(7416011)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QDZxlGHRb/5XhZcXvGMmZgrcstO83LCVLYqg1uh2LDgfc+/WGsp9FH7EYKTY?=
 =?us-ascii?Q?6Pj3CRo+ZkIsyGnqhXZIOa1IqwewwpnsUsb8KiF0rhOkuhrDIv3o0Bt99p9c?=
 =?us-ascii?Q?hvXEeSW9uBZfVzw+wjjYm9jdQ50x/XTn2OLSi/JSA/TdosJu9rdsTSYgUO5P?=
 =?us-ascii?Q?f4dIBYK/FWsdiBdfwr8/IxNymBhgP3zecGbvbry76y6sO5xVJwz8E8Dc0V4B?=
 =?us-ascii?Q?f/q1Mkvywu8kP6kPGF9CpoG1Gm08id/bM88R+etKlV3FWpUbVvu/8zYv+Sf8?=
 =?us-ascii?Q?O/aOFDOa4FJ8nLs2jnogHQwu3nDFvSl2wM/gOsFd5WMXC5ChSgzWvX21d5M+?=
 =?us-ascii?Q?uE5Irbm1dqzPY9Dr6Ygw+j+dq8XBT2hg05a7QLHi2QERw6QQB/8aFJH4duCx?=
 =?us-ascii?Q?AMDr9Uda0VfGy/VsGAak8WVt/S0vv4il7hmMUvrIwpxTph4QGUdJoW/fMWgz?=
 =?us-ascii?Q?c1QnXeIGxPPWOKd7Inaz4mWIpxtz/C5NgV7ed92R18ku8Ts+444XwsLyeMPw?=
 =?us-ascii?Q?g9K3A1Z/IMGQbDQIg5HGfPMEa4Tcqzajag66u2SJvApG9q9fKpqxxDAuA72o?=
 =?us-ascii?Q?1Olrd0EwNeO35hfV2oNVhSEKsSNhQ8FIFhBzOpuD4vveIGwgHCvfNzkqLpqn?=
 =?us-ascii?Q?MXjJd1XMpUv1zZ2f7/injnYs03gFGV4Y7imLX+e7BVs4ktk3VhTXYODyH2L+?=
 =?us-ascii?Q?gC504pXh7RTQxiUpZvSiBtZI/e7kE+8yh9R9f/l0nyINqVeqTQFJ9k2C7JBu?=
 =?us-ascii?Q?VI2C86lOXOO2p6L9zzbyYjsBC0HGN5FI/2S1zSpGnxz2ZsNaRTw23JCWXu+7?=
 =?us-ascii?Q?EbBhkZxMQ7pzfdM5bAR4t+E6uvBYcdzhhMYJLw5hQ0CYGuDyaG7wZm5njkMN?=
 =?us-ascii?Q?On9rq8PdlWZc3+hhVG1BeCV7BYpANHEUj8FPqsKRmE4TWbjJLgGUcvdwuQ62?=
 =?us-ascii?Q?LNkMK1rj5G6DsLHq3oQexOhrgm5wUJhPdzo2eAyxLPPi7s83adN2x0sOd7KV?=
 =?us-ascii?Q?/XjJXoXKeHyxPP1gZoabqH9N40II0y0Rf2Y2KxmutP73CAiBzYaOkCJeRNN5?=
 =?us-ascii?Q?979jXWoSWRp0w/vFLqecLT7MtijyDQ199HG1lP1ugpgkHVNgRlVv1DgmiROK?=
 =?us-ascii?Q?guitznp4ncFoqtzIhAUhU/8yCM3G3FV432DlQt9ULP1/nAigTkFDQIXBU0o3?=
 =?us-ascii?Q?ifVAbmnPGwDy2Q1SZjRQhLT+Uv87o6Va7hKGXkJKBWrqVOQxhBJJ5WKMpp/n?=
 =?us-ascii?Q?ARBbJeSgeLj6liudAb4gYR7ejvSrkMh6A+2dl2NSNrBmfbHh/sq658eSJn8E?=
 =?us-ascii?Q?5GDtZFIT30dtQbrzGTeOeCRArA9qCzsjqUqBZN46wgkXkWX3ThEYOE7xDyW2?=
 =?us-ascii?Q?6IAD5ENIMeJNmYmfby5d/0Ml4xWqhS3LnfY1zs6K0i7xbwdBGgfyc3wCR4Oy?=
 =?us-ascii?Q?uIQwAHAEvIISCWhf0lvd03c/MBA+r7xgmV2ZeOZ2n/OgAXi+FQcuiadoO+O/?=
 =?us-ascii?Q?zWHU8GyIG8wtfRhY7JC8GbSpUftPxRjEunzDb6pQQXlvnxe9i0yfp5+Ttx2z?=
 =?us-ascii?Q?YR5ChGvPB0G4niQtNJBBNhtfdyXgQkkiZS5wcpiX3SGkWOMUWjEMM9qmBKkD?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: accde41b-9785-427e-c1df-08dc8cb34006
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 20:47:48.2334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U1Jv1zluokDARozO5YJ+D5SO5u0wh6HjzmN10eF0eosN9th2JMO45pQSb0tzEiq/rkzS0koHz6M9/xgPKJmLZNo59Vl2kR8alSk3Qo0IIUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7166
X-OriginatorOrg: intel.com

Tom Lendacky wrote:
> With the introduction of an SVSM, Linux will be running at a non-zero
> VMPL. Any request for an attestation report at a higher privilege VMPL
> than what Linux is currently running will result in an error. Allow for
> the privlevel_floor attribute to be updated dynamically so that the
> attribute may be set dynamically. Set the privlevel_floor attribute to
> be the value of the vmpck_id being used.

Makes sense,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

