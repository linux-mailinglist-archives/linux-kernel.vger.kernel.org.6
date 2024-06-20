Return-Path: <linux-kernel+bounces-222232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F2090FE9E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5F5A1F22647
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531A319FA8A;
	Thu, 20 Jun 2024 08:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gx9AWQNK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A619C19F482
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871408; cv=fail; b=kAWpcxYHor5feM0rEsJwmq+avSodS+NTWt3x1vwN1gBE/V4YICusfthPcBjcuaF8l3ldGKL8KS4doC3JCJoylO+UgBOgmwQc7QZBFaIfGC1iR+ewkII79WVFE7klPRkxo5KFuOGSQXk4ouCM8f1okxtFxCq5VL3nYMf1Wdxlj1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871408; c=relaxed/simple;
	bh=zNUdYTPXCYmvijuNUvDV63ILanZkQVzRW7av18wI0LI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I7QKlQyoFZwziEzbzXBKuCAKFlpLXfG+vieGjVlgDlv2/gE48my8ID4Tj2yT9WuhK3FIpK9abaVI5DDcPZ9dpD9TsLeiSrDA/q94ALJh6BuJpqOUw9sRRS1dDDy0uabKTmwwdRgTSCWQMyL+4NqgQ2t1cyqITSZE8SaHaHFsPvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gx9AWQNK; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718871406; x=1750407406;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=zNUdYTPXCYmvijuNUvDV63ILanZkQVzRW7av18wI0LI=;
  b=gx9AWQNKPBU9iai5lSmvwhqr3iI6s+6NXSr13gMuyFsp6UecVbB86P8v
   kiArKvH9mnOXbIZe/lMqPlCGNF86dljbix8jCo3aj3HQmpOG72wRBjPG8
   AcB5l4qojer/FuHHtEc1KndZDDtNsrrHSaXxh7zFEQfv8+GB0vjVsih4C
   aRQmsz9Wsa3Q/MoIehb72XsXM3ak34L/ET6d0SFU1vYRYw2poXkxi4bvv
   0aOkdMDIwo5euSdcmO507xz4rOcXE/Har6jWIA2HIRETFxXesO4Ja8uvb
   jePhG04n8fXgvey5bFj9I6od0gIn/MTNvJefI1clJuAzpywqsgDL5sJ6q
   g==;
X-CSE-ConnectionGUID: 7VQ6AoPDSDi7PbwAa5jrkQ==
X-CSE-MsgGUID: qLtjJXLUS5CAAdJ8gKuYBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="27239238"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="27239238"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 01:16:45 -0700
X-CSE-ConnectionGUID: oIPlSNLYTFq7hUz1/BTTgg==
X-CSE-MsgGUID: 1wJ/fyAYS0qBYrMVkk62OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="47073984"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jun 2024 01:16:45 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 01:16:44 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 01:16:43 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 20 Jun 2024 01:16:43 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 01:16:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hzm1AiR20PSNvLlyF8/m1Ny/wFId5sUzrRhpZDYO7h3siF8pqPKhvVLuWTZCd/NVfAKnU5R5DGutvLzYXJQ+J3DX7ftR0hRSXPqQTJIreAK5d/zVTUE7vhwMGtnzDXpv4biuNDeZO9/zOgdc8zyd3i+CufZEKUY1ITUt0N5wuMyFyfsGXc6TrzYnK3cNI/cfIsUygoEecT6ycYVi1PfZyYI8/3KFttQCDJ+UvRclsjKxvS7XvpaHnyadV5SUNcquEte81BAQFiWjL2TqW/gQxudYeJ70+/49hzm3LNizmYRHoq83FoIdYVCl0bAR63n1EinskUZb2VYg/h3Lbz5hag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUO45iHVbWOcI5L36OGoWJ4vblZ9X0U00LJVsceqJac=;
 b=ZOHZQ6U8xHMvG3vdUjHL0+DbsC6Bo5q+x2EswmURgTAiszub0tJJtIiGRKqPHS4Y2QSju8d9NL24U1gzwEyK7f8uKQ4wFsQgnt7Gn0m2dsxgECnJ3k/o+BEdtR7QWzpeLMum67u+dF78jOsCE2TnC+Z+wFYDT45MaQ4XjU2cF//tE2HfHFugZVbY7AvJQJF6hBAfPmCO6cuu/Q+U8affm+XC9V5lKIRXW1JnPgtfo13wFdMKEysofWmoYVE6UFVMT2qEckQei1AjmqINAOdlI7ce3VYK2hH9z+d1KDqPxJgCN9cf4NgqpRH7KRVZjxDkGDRx02yglIfvINyn8OkDHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB6783.namprd11.prod.outlook.com (2603:10b6:806:25f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Thu, 20 Jun
 2024 08:16:41 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 08:16:40 +0000
Date: Thu, 20 Jun 2024 16:16:28 +0800
From: kernel test robot <oliver.sang@intel.com>
To: <zhangwei123171@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, <mingo@redhat.com>,
	<peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, zhangwei123171 <zhangwei123171@jd.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] sched/fair: prefer available idle cpu in select_idle_core
Message-ID: <202406201547.f5077fa1-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240612115410.1659149-1-zhangwei123171@jd.com>
X-ClientProxiedBy: SG2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:3:18::27) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: bff5509a-8fc0-4f0f-0ef6-08dc91015024
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?gf87nWcKXqHB/qbNbChOd/eIQ9d2J3FhOvX8nB9CrHlQENYIMajJIXAvqr?=
 =?iso-8859-1?Q?EN6yzuN3396aD7HuOJuMEUgVDdHqg6iWyH6RnSPNgIF3shyVF84PnaR6mE?=
 =?iso-8859-1?Q?xzcqqMgqmBt+tJO1ARR+J9ihnQyAPIaBRsv2XEM1fQz3E4dY3PnjwVQC+w?=
 =?iso-8859-1?Q?3dDIixoYCa3Ah4sRK9ieIyakvWJURqQzX8gMRxwYAvpH9CelD58mqDSOCh?=
 =?iso-8859-1?Q?3LeMs4lph2R61XEOXgWV1We6NklWq0OW5LGVzYYRMD1ITvNO5loTMwL69o?=
 =?iso-8859-1?Q?IEqhUduAJNVsWlyFoDnXZAoVdRSBif6eKiONGzYSi9tLolQpFic3iGq50u?=
 =?iso-8859-1?Q?2oyua1N68Aj5VRBQHEAV30TzRW1aAd4oOUL9knbzNZ4m5jQC+iB4ccQK36?=
 =?iso-8859-1?Q?9us6G0ElqaLE+ck4udH8AY4stgT2nC33lkkvwF/MoLV3kWloazVXI8KIeK?=
 =?iso-8859-1?Q?VmJkVGlTsTMf70fyWvKCbaR69gSCWwO/jNqQcS5E7h04axej/Tsv7PQ8aQ?=
 =?iso-8859-1?Q?pEMlUrJ7GGBYTM3Lv3D6YQE4uE+ScIUDTbvhNe3IOqrJfeIHE4gVVUvepw?=
 =?iso-8859-1?Q?hcIiWRxGyKXn1413jlxQXWeQW/A8bwaMtrIpTfsanYgXTRhyq0GUtkGX4I?=
 =?iso-8859-1?Q?VtFo7aBxI95YWYP/74RpX5vt8CD4Jr3DCwcmtm9S1RF6f7onBVbmnefpj0?=
 =?iso-8859-1?Q?8JIm8v1HUQzK3VVJFTlberIa+fxYhooQ5H3NtqGGRXJ/dL0LYNL4vbONX6?=
 =?iso-8859-1?Q?nP+gQAg7JMkVUZuc5cwGxpew5vOboxVrqnAysfzJgGyhn6LUYOynvv63pz?=
 =?iso-8859-1?Q?95XJreoAGCwbgl1ZIL3o0zrmO5qrc2H5PQ/tylx+d6mS3erbnmrgzhLAzZ?=
 =?iso-8859-1?Q?G6yJ5CLV0ns1p6VmGkKHwyh/Eof83dia8GYFWqtSTK8zNKz1Ko6B+Fa9XU?=
 =?iso-8859-1?Q?1588dA/+exNCffCWYcAHfplgrwG07VZmUHjrgjy6B8dZ/JMBzalgvw/28y?=
 =?iso-8859-1?Q?AcB0BTKkyfaujnmqw2i9yOQhMZJX3xan1kUKvagtTFhgVi8JVIZUk7zeM9?=
 =?iso-8859-1?Q?l+9txU53PxcV1tXZ0CaIUJ3Sljv6FqrJmabQ82jIsasgTprBlevErJuIwk?=
 =?iso-8859-1?Q?wHFVdbwm5Fj01EJhxOTjJ420WmJ8j+VdLspQhteKoXXm9R/A6remFkmw0y?=
 =?iso-8859-1?Q?eOsbAvJWvWPl1b08M5jnNApF76N0ul45KVFL0AqNys0G3Z7eXbAnfGoPIM?=
 =?iso-8859-1?Q?6Fd5Id4q3ulNmcTaxUzbhZm9SGeTEPd1VZzEkkfqu32UTvyfdwnvuXEPPg?=
 =?iso-8859-1?Q?IbXVgh9/8YkWXc7PH577VxkaBg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?x/C3kIlYU5ywgSSK8uPNQNq4g8euG9gdS1bUE5iIYuCP+YediYh+Z9Se6/?=
 =?iso-8859-1?Q?q7jE+9b3J2RHmMSo1j7ZCTVaWt6bCYyUFAuw4BERY5J7f0r02mZyNMAwuR?=
 =?iso-8859-1?Q?5ldg8+Q7wKYVHNTitwrZLetN2ko/H95ZnAy3n5e13YMY3Xydbw1fAhdS0L?=
 =?iso-8859-1?Q?wJOj8iRT9feNWBd+3GfHh8lCUkEPzb+0MrbtK8aLjN6uu/4cEUShcLYU9c?=
 =?iso-8859-1?Q?DodLlaF0oVYGLo+QTCU+Daj06wYhQv/uOGKONC7kflkTxI8dFQd8dgD5Jc?=
 =?iso-8859-1?Q?DPkoMXxWao3uN5hZdv0FAeznt+0bAT8nAKROXMkwU56W+MedhU3HZMyyFf?=
 =?iso-8859-1?Q?frzCN54cB9GJTV864qiUaYxR1L+PwwovraOHGjCn6eigbjSfY7wA57izm9?=
 =?iso-8859-1?Q?o4WeIZx8STia1NcvN7CbxoCKqFva4BQr5M2o2siZQlZMtEo0zxbt6MHmsK?=
 =?iso-8859-1?Q?a4dl6qF2j8CzUN45zAo6q0WxlK0vqBI8WTWwPQy8hRCN5wm1DqB4COGTDM?=
 =?iso-8859-1?Q?GkZy77i+Jk1Kk0OsGzS8TRhvgrRaiUMFyKMtgK7Rg4Vnh/h4lTyOmHZbrr?=
 =?iso-8859-1?Q?mHr41pozgJm42vVjDzRtw2d5MvOdEw5yW4r9ya+2pCa/Hvs8LT28Lrmiyd?=
 =?iso-8859-1?Q?EkusBESv4gyihfopWg3O8rMXMKu5VOpekdUSQxvdMmMhbWrGiTgBHDSmQh?=
 =?iso-8859-1?Q?7vl2w3Q8lP9MrSEiMrHp/2kna6gtXzk8sWRoTzpErO+rECqVW/jgIBClv5?=
 =?iso-8859-1?Q?p3Nsqu1WuMsGmztOebtEDCdwOQkeWDylfHCs/VynA+n7W0JJ0tydQjCX7X?=
 =?iso-8859-1?Q?V9ajYDzKQ6aVhoN73DLU6jvKu7fjYP6o9+3A0mJBvew3FDYkuy+qA8HfRA?=
 =?iso-8859-1?Q?RpTQMuEw14jHbbeMCVHaLqBGfyblrCDnwPaWbE14YfK05/X1tl9ZV7SPTq?=
 =?iso-8859-1?Q?Cuicl//Hvf82OUz4ISfSiHSmr7oVhl5ViHACS9VJ6Iqwfr0+WXAISQvpyh?=
 =?iso-8859-1?Q?koX1KB9kKuoQ3U/v0JKqC7wGQ4PUNOMPihPoZNt1z9kX6UkLIEBjmHnOf2?=
 =?iso-8859-1?Q?jY+UIN+ARqL2pLus/RgyP2pt7pc0wFCmSVAqjnQinzmSV9gD22pk+WxPho?=
 =?iso-8859-1?Q?pqBuweDYXE7lIAIOOqhqAw3gMwfYnRLy2qGGqY7kp/PaP8SyL3cIK3Xxht?=
 =?iso-8859-1?Q?gLahK2+1vc0pI6u4ZlbGGxYMN/L4F9coDItJbmTzS5lZ9IFTiuYvtUWH6a?=
 =?iso-8859-1?Q?GU3pMa259wX4DfjNZOH0Rw5DWSTEFZecFpCL3H0LQHgN+Ru1ASEc4/bd2T?=
 =?iso-8859-1?Q?uoNyfhf28+NEX6bx6RjvCRtJqX0C6yn7i0ufzSDRUmD9d9m3BTMaixQZ1X?=
 =?iso-8859-1?Q?c534Qe0b71xy3REhJfPNXVXLEoaCgjunXL9TW/0f/bE9pCR7EBcg5Q+SQW?=
 =?iso-8859-1?Q?S6z79cAw/0BjSpU2nJVrpsq3pyl/pK9IQ9xAyxkdXpgq4OEL29KoEkvx1a?=
 =?iso-8859-1?Q?geodua7Sx5EoOWYxPqb1wiwXtMg4oP3Fl3wxQDPHuZSMnPGHBo35rKSajN?=
 =?iso-8859-1?Q?MrWigotw2M8AVjm+sTlFUlHJKx7ZmordckWiV5cmrcH0Qa4oRdHzUgKp4w?=
 =?iso-8859-1?Q?xTEQdlvwpC3vjh7DEixDMuBn7z0kqVeUOxE+zxVk10nhaozw7t26HoAw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bff5509a-8fc0-4f0f-0ef6-08dc91015024
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 08:16:40.8796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+5lHCtJsEbnJ8p7Ke2ubJ7kjDL8/24SImISJ3QSqH7zabJ0ZzSH5tq9DaT8nMASHjh6baMg8IdkGlwojm5rNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6783
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 2.9% improvement of stress-ng.vm-rw.ops_per_sec on:


commit: 9f2e02ee19cda318b3889a27c13aee04fdbeb179 ("[PATCH] sched/fair: prefer available idle cpu in select_idle_core")
url: https://github.com/intel-lab-lkp/linux/commits/zhangwei123171-gmail-com/sched-fair-prefer-available-idle-cpu-in-select_idle_core/20240612-195645
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git c793a62823d1ce8f70d9cfc7803e3ea436277cda
patch link: https://lore.kernel.org/all/20240612115410.1659149-1-zhangwei123171@jd.com/
patch subject: [PATCH] sched/fair: prefer available idle cpu in select_idle_core

testcase: stress-ng
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: vm-rw
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240620/202406201547.f5077fa1-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-spr-2sp4/vm-rw/stress-ng/60s

commit: 
  c793a62823 ("sched/core: Drop spinlocks on contention iff kernel is preemptible")
  9f2e02ee19 ("sched/fair: prefer available idle cpu in select_idle_core")

c793a62823d1ce8f 9f2e02ee19cda318b3889a27c13 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    295657 ±  6%     +22.8%     362935 ±  8%  meminfo.Active
    295610 ±  6%     +22.8%     362887 ±  8%  meminfo.Active(anon)
    150724 ± 21%     +67.4%     252378 ±  3%  sched_debug.cfs_rq:/.avg_vruntime.stddev
    150724 ± 21%     +67.4%     252378 ±  3%  sched_debug.cfs_rq:/.min_vruntime.stddev
  10941857            +3.9%   11367018        vmstat.system.cs
   1076455            -1.9%    1055781        vmstat.system.in
     74324 ±  6%     +21.9%      90584 ±  7%  proc-vmstat.nr_active_anon
 3.512e+09            +3.3%  3.626e+09        proc-vmstat.nr_foll_pin_acquired
 3.512e+09            +3.3%  3.626e+09        proc-vmstat.nr_foll_pin_released
     74324 ±  6%     +21.9%      90584 ±  7%  proc-vmstat.nr_zone_active_anon
    760031           -70.4%     224972        stress-ng.time.involuntary_context_switches
 3.948e+08            +2.9%  4.062e+08        stress-ng.time.voluntary_context_switches
 1.975e+08            +2.9%  2.032e+08        stress-ng.vm-rw.ops
   3291726            +2.9%    3387191        stress-ng.vm-rw.ops_per_sec
 4.035e+10            +2.2%  4.123e+10        perf-stat.i.branch-instructions
      0.67            -0.0        0.65        perf-stat.i.branch-miss-rate%
 6.491e+09            +1.1%  6.564e+09        perf-stat.i.cache-references
  11493579            +3.5%   11900089        perf-stat.i.context-switches
      2.41            -1.9%       2.37        perf-stat.i.cpi
   4817773            +1.7%    4901418        perf-stat.i.cpu-migrations
  2.16e+11            +2.2%  2.208e+11        perf-stat.i.instructions
      0.43            +1.7%       0.43        perf-stat.i.ipc
     71.91            +3.6%      74.50        perf-stat.i.metric.K/sec
      0.62            -0.0        0.61        perf-stat.overall.branch-miss-rate%
      2.38            -1.6%       2.34        perf-stat.overall.cpi
      0.42            +1.6%       0.43        perf-stat.overall.ipc
 3.903e+10            +2.5%  3.999e+10        perf-stat.ps.branch-instructions
 6.286e+09            +1.7%  6.395e+09        perf-stat.ps.cache-references
  11123522            +4.1%   11584380        perf-stat.ps.context-switches
   4664338            +2.4%    4775066        perf-stat.ps.cpu-migrations
  2.09e+11            +2.5%  2.143e+11        perf-stat.ps.instructions
 1.266e+13            +2.8%  1.301e+13        perf-stat.total.instructions
     16.29            -0.3       15.97        perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16.70            -0.3       16.39        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     14.46            -0.3       14.16        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_sync_key.pipe_write.vfs_write.ksys_write
     14.53            -0.3       14.23        perf-profile.calltrace.cycles-pp.__wake_up_sync_key.pipe_write.vfs_write.ksys_write.do_syscall_64
     13.71            -0.3       13.41        perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key.pipe_write
     13.73            -0.3       13.44        perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_sync_key.pipe_write.vfs_write
     18.54            -0.2       18.31        perf-profile.calltrace.cycles-pp.__clone
      8.93            -0.2        8.76        perf-profile.calltrace.cycles-pp.write.stress_vm_rw
      8.77            -0.2        8.60        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write.stress_vm_rw
      8.71            -0.2        8.54        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write.stress_vm_rw
      8.78            -0.2        8.62        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write.stress_vm_rw
     62.61            -0.2       62.46        perf-profile.calltrace.cycles-pp.stress_vm_rw
      8.39            -0.1        8.25        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write.__clone
      8.40            -0.1        8.26        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write.__clone
      8.32            -0.1        8.18        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write.__clone
      8.52            -0.1        8.38        perf-profile.calltrace.cycles-pp.write.__clone
     13.62            -0.1       13.48        perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     14.30            -0.1       14.17        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      9.69            -0.1        9.56        perf-profile.calltrace.cycles-pp.schedule.pipe_read.vfs_read.ksys_read.do_syscall_64
      9.59            -0.1        9.47        perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_read.vfs_read.ksys_read
     23.18            -0.1       23.07        perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.process_vm_rw_single_vec.process_vm_rw_core.process_vm_rw
     23.42            -0.1       23.31        perf-profile.calltrace.cycles-pp.copy_page_to_iter.process_vm_rw_single_vec.process_vm_rw_core.process_vm_rw.__x64_sys_process_vm_readv
      9.04            -0.1        8.95        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read.stress_vm_rw
      4.71            -0.1        4.62        perf-profile.calltrace.cycles-pp.available_idle_cpu.select_idle_core.select_idle_cpu.select_idle_sibling.select_task_rq_fair
      9.05            -0.1        8.96        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read.stress_vm_rw
      7.79            -0.1        7.71        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read.stress_vm_rw
      0.63            -0.1        0.56        perf-profile.calltrace.cycles-pp.read
      0.70            -0.0        0.67        perf-profile.calltrace.cycles-pp.prepare_task_switch.__schedule.schedule.pipe_read.vfs_read
      0.58            -0.0        0.55        perf-profile.calltrace.cycles-pp._raw_spin_lock.__schedule.schedule_idle.do_idle.cpu_startup_entry
      1.42            -0.0        1.40        perf-profile.calltrace.cycles-pp.switch_fpu_return.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.84            -0.0        0.83        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.read.__clone
      0.71            +0.0        0.74        perf-profile.calltrace.cycles-pp.update_load_avg.enqueue_entity.enqueue_task_fair.ttwu_do_activate.sched_ttwu_pending
      0.87            +0.0        0.90        perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule_idle.do_idle.cpu_startup_entry
      6.19            +0.0        6.22        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      6.24            +0.0        6.28        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      5.16            +0.0        5.21        perf-profile.calltrace.cycles-pp._copy_from_iter.copy_page_from_iter.process_vm_rw_single_vec.process_vm_rw_core.process_vm_rw
      2.76            +0.0        2.81        perf-profile.calltrace.cycles-pp.pin_user_pages_remote.process_vm_rw_single_vec.process_vm_rw_core.process_vm_rw.__x64_sys_process_vm_writev
      3.50            +0.0        3.54        perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      3.36            +0.0        3.41        perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      5.35            +0.0        5.40        perf-profile.calltrace.cycles-pp.copy_page_from_iter.process_vm_rw_single_vec.process_vm_rw_core.process_vm_rw.__x64_sys_process_vm_writev
      0.66            +0.1        0.73        perf-profile.calltrace.cycles-pp.sched_mm_cid_migrate_to.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue
      6.76            +0.1        6.82        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      2.15            +0.1        2.22        perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      7.38            +0.1        7.45        perf-profile.calltrace.cycles-pp.select_idle_cpu.select_idle_sibling.select_task_rq_fair.select_task_rq.try_to_wake_up
      9.00            +0.1        9.08        perf-profile.calltrace.cycles-pp.select_task_rq_fair.select_task_rq.try_to_wake_up.autoremove_wake_function.__wake_up_common
      9.37            +0.1        9.45        perf-profile.calltrace.cycles-pp.select_task_rq.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key
      2.58            +0.1        2.68        perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue
      9.08            +0.1        9.19        perf-profile.calltrace.cycles-pp.process_vm_rw_single_vec.process_vm_rw_core.process_vm_rw.__x64_sys_process_vm_writev.do_syscall_64
      9.71            +0.1        9.82        perf-profile.calltrace.cycles-pp.process_vm_rw_core.process_vm_rw.__x64_sys_process_vm_writev.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.48            +0.1        8.60        perf-profile.calltrace.cycles-pp.select_idle_sibling.select_task_rq_fair.select_task_rq.try_to_wake_up.autoremove_wake_function
     10.27            +0.1       10.39        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.process_vm_writev.stress_vm_rw
     10.12            +0.1       10.23        perf-profile.calltrace.cycles-pp.__x64_sys_process_vm_writev.do_syscall_64.entry_SYSCALL_64_after_hwframe.process_vm_writev.stress_vm_rw
     10.24            +0.1       10.36        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.process_vm_writev.stress_vm_rw
     10.10            +0.1       10.22        perf-profile.calltrace.cycles-pp.process_vm_rw.__x64_sys_process_vm_writev.do_syscall_64.entry_SYSCALL_64_after_hwframe.process_vm_writev
     10.64            +0.1       10.77        perf-profile.calltrace.cycles-pp.process_vm_writev.stress_vm_rw
      4.31            +0.2        4.46        perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      5.36            +0.2        5.52        perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      3.40            +0.2        3.57        perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle
      4.81            +0.2        4.99        perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
     16.66            +0.3       16.96        perf-profile.calltrace.cycles-pp.common_startup_64
     16.57            +0.3       16.88        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     16.54            +0.3       16.84        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     16.58            +0.3       16.89        perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     76.34            -0.4       75.95        perf-profile.children.cycles-pp.do_syscall_64
     76.51            -0.4       76.12        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     16.31            -0.3       16.00        perf-profile.children.cycles-pp.pipe_write
     14.46            -0.3       14.16        perf-profile.children.cycles-pp.__wake_up_common
     14.54            -0.3       14.24        perf-profile.children.cycles-pp.__wake_up_sync_key
     13.74            -0.3       13.44        perf-profile.children.cycles-pp.autoremove_wake_function
     13.72            -0.3       13.43        perf-profile.children.cycles-pp.try_to_wake_up
     16.83            -0.3       16.57        perf-profile.children.cycles-pp.vfs_write
     17.16            -0.2       16.91        perf-profile.children.cycles-pp.ksys_write
     17.70            -0.2       17.45        perf-profile.children.cycles-pp.write
     18.54            -0.2       18.31        perf-profile.children.cycles-pp.__clone
     18.78            -0.2       18.58        perf-profile.children.cycles-pp.read
      2.91            -0.2        2.72        perf-profile.children.cycles-pp._raw_spin_lock
     13.88            -0.2       13.71        perf-profile.children.cycles-pp.pipe_read
     14.54            -0.2       14.37        perf-profile.children.cycles-pp.vfs_read
      9.93            -0.2        9.76        perf-profile.children.cycles-pp.schedule
     14.70            -0.2       14.54        perf-profile.children.cycles-pp.ksys_read
      0.24            -0.2        0.08        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     62.61            -0.2       62.46        perf-profile.children.cycles-pp.stress_vm_rw
     23.98            -0.1       23.87        perf-profile.children.cycles-pp._copy_to_iter
     24.25            -0.1       24.14        perf-profile.children.cycles-pp.copy_page_to_iter
      3.16            -0.1        3.10        perf-profile.children.cycles-pp.enqueue_task_fair
      2.61            -0.0        2.57        perf-profile.children.cycles-pp.update_load_avg
      1.78            -0.0        1.74        perf-profile.children.cycles-pp.prepare_task_switch
      0.28            -0.0        0.24        perf-profile.children.cycles-pp.update_rq_clock_task
      2.31            -0.0        2.28        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.38            -0.0        0.35        perf-profile.children.cycles-pp.wake_affine
      0.82            -0.0        0.79        perf-profile.children.cycles-pp.update_rq_clock
      0.89            -0.0        0.86        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      1.43            -0.0        1.40        perf-profile.children.cycles-pp.switch_fpu_return
      0.10 ±  4%      -0.0        0.08 ±  3%  perf-profile.children.cycles-pp.cpuacct_charge
      0.21 ±  2%      -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.task_h_load
      0.13 ±  3%      -0.0        0.11        perf-profile.children.cycles-pp.wakeup_preempt
      0.95            -0.0        0.93        perf-profile.children.cycles-pp.prepare_to_wait_event
      0.16            +0.0        0.17        perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.62            +0.0        0.63        perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.29            +0.0        0.30        perf-profile.children.cycles-pp.nohz_run_idle_balance
      0.92            +0.0        0.94        perf-profile.children.cycles-pp.mod_node_page_state
      0.25            +0.0        0.27        perf-profile.children.cycles-pp.update_min_vruntime
      0.77            +0.0        0.79        perf-profile.children.cycles-pp.__switch_to_asm
      0.46            +0.0        0.48        perf-profile.children.cycles-pp.llist_reverse_order
      6.27            +0.0        6.30        perf-profile.children.cycles-pp.cpuidle_enter
      0.48 ±  2%      +0.0        0.52 ±  2%  perf-profile.children.cycles-pp.pick_next_task_idle
      0.47 ±  2%      +0.0        0.51 ±  2%  perf-profile.children.cycles-pp.__update_idle_core
      0.81            +0.0        0.85        perf-profile.children.cycles-pp.sched_mm_cid_migrate_to
      0.09 ±  6%      +0.0        0.13 ±  5%  perf-profile.children.cycles-pp.generic_perform_write
      3.52            +0.0        3.57        perf-profile.children.cycles-pp.schedule_idle
      5.40            +0.0        5.45        perf-profile.children.cycles-pp._copy_from_iter
      0.00            +0.1        0.05 ±  5%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.09 ±  6%      +0.1        0.14 ±  7%  perf-profile.children.cycles-pp.shmem_file_write_iter
      5.64            +0.1        5.69        perf-profile.children.cycles-pp.copy_page_from_iter
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.ring_buffer_read_head
      0.12 ±  6%      +0.1        0.18 ±  6%  perf-profile.children.cycles-pp.record__pushfn
      6.80            +0.1        6.86        perf-profile.children.cycles-pp.cpuidle_idle_call
      0.12 ±  6%      +0.1        0.18 ±  6%  perf-profile.children.cycles-pp.writen
      0.00            +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.perf_mmap__read_head
      7.43            +0.1        7.51        perf-profile.children.cycles-pp.select_idle_cpu
      9.00            +0.1        9.09        perf-profile.children.cycles-pp.select_task_rq_fair
      9.37            +0.1        9.46        perf-profile.children.cycles-pp.select_task_rq
      0.18 ±  5%      +0.1        0.29 ±  6%  perf-profile.children.cycles-pp.perf_mmap__push
      0.19 ±  5%      +0.1        0.30 ±  6%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.19 ±  5%      +0.1        0.30 ±  6%  perf-profile.children.cycles-pp.cmd_record
      0.19 ±  6%      +0.1        0.31 ±  6%  perf-profile.children.cycles-pp.main
      0.19 ±  6%      +0.1        0.31 ±  6%  perf-profile.children.cycles-pp.run_builtin
      8.50            +0.1        8.62        perf-profile.children.cycles-pp.select_idle_sibling
     10.12            +0.1       10.24        perf-profile.children.cycles-pp.__x64_sys_process_vm_writev
     10.80            +0.1       10.92        perf-profile.children.cycles-pp.process_vm_writev
      4.92            +0.1        5.07        perf-profile.children.cycles-pp.sched_ttwu_pending
      5.43            +0.1        5.58        perf-profile.children.cycles-pp.flush_smp_call_function_queue
      5.54            +0.2        5.70        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
     16.66            +0.3       16.96        perf-profile.children.cycles-pp.common_startup_64
     16.66            +0.3       16.96        perf-profile.children.cycles-pp.cpu_startup_entry
     16.63            +0.3       16.93        perf-profile.children.cycles-pp.do_idle
     16.58            +0.3       16.89        perf-profile.children.cycles-pp.start_secondary
      0.24            -0.2        0.08        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
     23.76            -0.1       23.65        perf-profile.self.cycles-pp._copy_to_iter
      1.59            -0.0        1.54        perf-profile.self.cycles-pp.prepare_task_switch
      1.31            -0.0        1.28        perf-profile.self.cycles-pp.update_load_avg
      0.36            -0.0        0.33        perf-profile.self.cycles-pp.switch_fpu_return
      0.24 ±  2%      -0.0        0.21 ±  2%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.70            -0.0        0.67        perf-profile.self.cycles-pp.update_rq_clock
      5.43            -0.0        5.40        perf-profile.self.cycles-pp.intel_idle
      0.21 ±  2%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.task_h_load
      0.10            -0.0        0.08        perf-profile.self.cycles-pp.cpuacct_charge
      0.17            -0.0        0.15 ±  3%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.27            -0.0        0.26        perf-profile.self.cycles-pp.try_to_wake_up
      0.13            -0.0        0.12        perf-profile.self.cycles-pp.pick_next_task_fair
      0.22            -0.0        0.21        perf-profile.self.cycles-pp.set_task_cpu
      0.07            -0.0        0.06        perf-profile.self.cycles-pp.wakeup_preempt
      0.16 ±  2%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.menu_select
      0.78            +0.0        0.80        perf-profile.self.cycles-pp.__switch_to
      0.49            +0.0        0.50        perf-profile.self.cycles-pp.call_function_single_prep_ipi
      0.84            +0.0        0.85        perf-profile.self.cycles-pp.mod_node_page_state
      0.24 ±  2%      +0.0        0.26        perf-profile.self.cycles-pp.remove_entity_load_avg
      0.24            +0.0        0.26 ±  2%  perf-profile.self.cycles-pp.update_min_vruntime
      0.46            +0.0        0.48        perf-profile.self.cycles-pp.llist_reverse_order
      0.55            +0.0        0.57        perf-profile.self.cycles-pp.enqueue_entity
      0.76            +0.0        0.79        perf-profile.self.cycles-pp.__switch_to_asm
      0.37 ±  3%      +0.0        0.40 ±  2%  perf-profile.self.cycles-pp.__update_idle_core
      0.81            +0.0        0.85        perf-profile.self.cycles-pp.sched_mm_cid_migrate_to
      1.12            +0.0        1.16        perf-profile.self.cycles-pp.select_idle_core
      5.34            +0.0        5.39        perf-profile.self.cycles-pp._copy_from_iter
      0.48            +0.1        0.53        perf-profile.self.cycles-pp.select_idle_cpu
      0.00            +0.1        0.05 ±  5%  perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.00            +0.1        0.06 ± 10%  perf-profile.self.cycles-pp.ring_buffer_read_head




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


