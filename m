Return-Path: <linux-kernel+bounces-173688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573998C0415
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE1928AD51
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4698112D754;
	Wed,  8 May 2024 18:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jN5Rze4/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687B312C464;
	Wed,  8 May 2024 18:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715191422; cv=fail; b=R+k+FICu/SU5Ks75fzs6xiYi2tCrdCdZvjR6XG4PkHlcDgc9LLh5c2WrH6nj0XV1pK3L0cnQ3Lc4MmQNkBy3ZNhTVjiEuWsXRx+SbQCMBChjxbZBjx8oRUw5aa3t1MmecM6ri2g2ObOaZ7ChPoPt7IE6TmqlDUXoCAKd6j9wiHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715191422; c=relaxed/simple;
	bh=QyY5F0VSgUStgAHe0tdU/ccRkKh5w2BsFAVR8HeGgqk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QZ/TyotCx6F/re48643nmjn4CyCJMrGlkSqi9fP46WaFGzZ8Nz/evy+p4IzljzUf9H2md8rvh8AwaXQTk+akX72Mdr4DWcBn3A+x+KrrKObnxAMQ5aIuxsiPz6rcqnf7vW9ytfWZcQt4VF1hSyvm6FpjVV38NxNY+Z5BzXfQjyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jN5Rze4/; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715191419; x=1746727419;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QyY5F0VSgUStgAHe0tdU/ccRkKh5w2BsFAVR8HeGgqk=;
  b=jN5Rze4/bmtG+rHNeUzJr/7l14UKDF4PZ/9aE84+ydirxlr/t81Md0nH
   ZtzLthgnQsGD67ljaM3cYDOhR1NUCSh+aR1SbiSrKqzHCUNaSWxn+1qU5
   iohZRw5a5g6LMs84qtYgdxmQ5eBrRl1P5KZBixj9judKzprx3EMXgYS61
   8z5N47m7CNF+bZfml8K4bMhxkz+k6v5g3dKUrNQhRCW2kdAPqW5vvKS1X
   zu+J35XtP9IXZ6ojWV+A2ASen+cg4Q5kHZ3AHtR1TVtyax0FOh061DCPt
   EZIVeZq3Y6rpwB9IUlxyXjht6GrrFBvwyBGe51gzVNVq+6tA/cK+hWfI/
   g==;
X-CSE-ConnectionGUID: 2TAnLrXASEGpqXncIuAPzw==
X-CSE-MsgGUID: 45KtPJEYSQeL1hhch3ISKA==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="22477228"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="22477228"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 11:03:38 -0700
X-CSE-ConnectionGUID: f/I1Vvl1Sq6Ula4YFRAjsg==
X-CSE-MsgGUID: Bqo9Bob0SaeGb9vR3uUi5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="33519841"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 May 2024 11:03:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 11:03:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 11:03:37 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 11:03:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZC1v3E/PgRjJ347Q+9uR/utj49dbxeAbp31OTsKGqaa78tFgK46WfquWAP838FJtd3Hw6pV7JSBCEq4G+6FgEOYYIwrf8JenO0XX83+7QzXdyi6YlL7oNpPnNrPf6peBcFxfmhwKhWmhZzrEfsXA/HMwVZD3PiWOG9a8iuAU+3x+jSbZH6WPcT/5VJKYBQsnZee8eLSC8Nywi/oXFAe6MTZ81XdZbHGZev9ZlrgjniWKJ0EKVE8dVyQdMlGhr9sVu4La8v403alMW6rxupd1EY/hfnUe+p5s2K7q8iuIjFRhZO30JDGP4WdnGBR6LM84MGdfoOeCyx8b205B1IY1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlOCdtorIX4MwEiit8CWCUgW1cmrgs6RiWoATIpSq8M=;
 b=lwi9Lqynrr1EZnY9U1dvZD7uUPosB44uDT+99onBud6OXHpaTkDMInZi25amhTbNRSOX3Q+Cg1hCJOZCdJQI66AeU5nPbm43kE4pHpKxtjW6/dlBo3ci7pDN80HTdUcu+mlt1ErsmbDji3CdogmMTMxDQPzynH6kBjpW3uGNuuioVg0erqy1kHE0YNZg1yKxxlyj8wVCnTGILe1nxNX2HKkuaoxAVnKdx3mabnM74MtgRn4CrPNv5FmCNbXD9dryW/NRe+Et6x82I7nhABZxgO1o+qCgSzxAnEPQ3oun6s1tauSkMDbYlkH6lEjtE+Pe2+jsLuO9Be+9BcbGjxL2oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB7164.namprd11.prod.outlook.com (2603:10b6:303:212::6)
 by PH0PR11MB7471.namprd11.prod.outlook.com (2603:10b6:510:28a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 18:03:30 +0000
Received: from MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::a972:1395:dd49:1dc5]) by MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::a972:1395:dd49:1dc5%6]) with mapi id 15.20.7544.045; Wed, 8 May 2024
 18:03:30 +0000
Message-ID: <62e2ebd9-4afa-4bb1-a30c-5ba34bc6b94e@intel.com>
Date: Wed, 8 May 2024 11:03:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/fpu: Extend kernel_fpu_begin_mask() to
 initialize AMX state
To: Dave Hansen <dave.hansen@intel.com>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <platform-driver-x86@vger.kernel.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hdegoede@redhat.com>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>,
	<ashok.raj@intel.com>, <jithu.joseph@intel.com>
References: <20240430212508.105117-1-chang.seok.bae@intel.com>
 <20240507235344.249103-1-chang.seok.bae@intel.com>
 <20240507235344.249103-2-chang.seok.bae@intel.com>
 <f82879a5-f3ca-436f-8c4a-96d4c5d90354@intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <f82879a5-f3ca-436f-8c4a-96d4c5d90354@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0129.namprd04.prod.outlook.com
 (2603:10b6:303:84::14) To MW4PR11MB7164.namprd11.prod.outlook.com
 (2603:10b6:303:212::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB7164:EE_|PH0PR11MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f5bde7f-6793-4368-a03d-08dc6f892abc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yk9sQTdkY3QxOWMxeEZyWjFRbXZPZ1FuR3VJWDB1MnQzNFdIRElxbHRCTGhK?=
 =?utf-8?B?R3RwQkRGYXlZektoOUdDVkVlQTA1VFp1bTRLenVvUzI4ZlJjZTlVcmxEaEJ4?=
 =?utf-8?B?YTlxVEJ4bUlEVXRPdUQwYWd6MUhiU2ZOOHJ2WWZjblhCU05uQWZLTkZZUTBu?=
 =?utf-8?B?ZHJHRjJyRHlrNSt0RFFTM05WRDQycUdNbWpXNFFkT0Y5U2VLNTZpb0NWcmdy?=
 =?utf-8?B?MHVIUW0va3ExUWRnUXhjY2Z0NHRiVnQwNkhJV2xWakJwUmNBOUN5VDhHSmF6?=
 =?utf-8?B?eGlDVFJyWnNOZEhkS0lPR09CUGRmOFA3R2c3WEZWTDBiRENZY1B3amg0VnVI?=
 =?utf-8?B?M01taEN2czlSa0JUdjlkWTZxQ2Q5WHdCRlVpTnIzRWJjRE8zREcxL3pBUEVq?=
 =?utf-8?B?QTNFSjVzREI0QUU2aW15MjFBTndYTjBmWTlUQjRDSFA1TEJ5VmZvTmc1dEoy?=
 =?utf-8?B?bU1wN3pjM1F2SUZ3bXNVYXJURENoRnVaK2pPR0lmeW5uN0lkWVF1eUpOUWk2?=
 =?utf-8?B?QkhOSlBrdC92T0ltbGpqdWF1NCs4dUVzcE9ORGF0NmU0TktPYlBLU3VGZSs5?=
 =?utf-8?B?dlhrcHViM0RkSzY1WE1kME1nQWNwWU1iQWpRbklWMTJTdWVIaTU2MEI2T0Mw?=
 =?utf-8?B?SGhuWGZjajJ1aUtoWHVKV29VcWoxUUdBRWhCbnlia09lU3U5VUtWYTBhbWh2?=
 =?utf-8?B?ZTlXYnJTWncyNS9nSTNhUVduZXlsaDRucVh5T2Rna1hnWVhuaFkyNGJ0OHAw?=
 =?utf-8?B?eXBuMUdtWWRnZExJMWlOUWZha1hJSjhES0ZBaS9LMm04aDZWbDZGSnVUbTIx?=
 =?utf-8?B?d1ppR2svb0tQendWVi9BemRkdTE3N095Tk1xWVdsQ1plRHBpWEJRUnYzdTBs?=
 =?utf-8?B?TVNEZlE2RW9UMFdjZTVlZ2pLYXVIS002aE9zSE03bFhlUmRwWmpVTEdQMWwz?=
 =?utf-8?B?b1BEU092cVVtWjhTTG1hVm5pVEpTaWNEMDNSVmJaZEJ0UVlMVTh5d3UwODdU?=
 =?utf-8?B?NDR5WkVqa0NDWlZNcjFWZ2pEUk5tcUZyOHo5TWhMczlVUjNpVmZDaFJNYkJL?=
 =?utf-8?B?d0c1Zmt4R2Y5emVzY0hONDJoNFU5c3NhY0hTeUJsa1NCTUppVjEzY0ZZcnlP?=
 =?utf-8?B?YnhXTWlkT1o4dnlPd0d1MlczZEIxbHNCa29KbmFlZnU2Zkl2ZFdYSnpHNmw0?=
 =?utf-8?B?UjJMRkZ1aCszNThibHBVMWVrNFp4TzBnYWNVZ216RkxJYWtNekhhRHhQR2V5?=
 =?utf-8?B?YzY2bmR0a3doWGtBTWlVVUtkTUpyaG1zZ3l5VVZRTXIzbHVVem5HOEtSQ1Nk?=
 =?utf-8?B?aUNsT1dJM2FKNjZvSHE4ejVoYzNXcDdoQTRKNm55cGsyMFJTNU9Ha2N1SDFj?=
 =?utf-8?B?dldGckRZQWRTTWZVYzRROEVIWFo1cW9vVzA1RTVNSGtSTG1TdVB1M3F4QjNQ?=
 =?utf-8?B?K29EN0NSanBobGY3Y2RobFNvNndjc09KN0tNcHd0N29YN3oyWWpRMTVBRFFS?=
 =?utf-8?B?bVBMWmk0NHRaVUdFUU1CeENyNU41K1FQS0pyRjlRdVF6amN5MHRBR1V1akRU?=
 =?utf-8?B?ZVdUR3p6QkJaSEdxQkQrUldqd21acWl0NjhhaFdERGhGbEJGUFpPY1gzUEFa?=
 =?utf-8?B?S0ZwemxLMnJ0WWtucVQ0UkpoQ1RZTVIrSkZ2Yy9kV0VzUUFDQkJjNmszbUh6?=
 =?utf-8?B?UU96NnFsSDhRelNqVFdXSndyd2t3MTlYTk1TSmF3bWJVeTVsbDVnMUd3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7164.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0NIWEpsdXRqaWZNcFFtWW1lazJKa3d0Z0VLRURsUDk1b21tLyswTXdHdEVy?=
 =?utf-8?B?d2N6ZlYzeDRiVnBHUDVURW1icmNRbS9KM0tKQ2Q0NFZhQ09ycWRELzFYVHJy?=
 =?utf-8?B?MWVla1hMYmRkdnEwWkF0elRPc3p4UkRzYXRjWUdtWndaUDFqcnhHc08vSVI1?=
 =?utf-8?B?emFWT25XSnU5SWl3a0NvRmRyQWNLQzh0ejdQUmMvODBWL0NIK0ZCUzJXQ3V6?=
 =?utf-8?B?cXNaRnZTbXk1MWhXdVJsd0wvVCtQVW9EcXBacXJQREZKZjdnM3o2TnhaNEdn?=
 =?utf-8?B?WExwMGpSdDNrSzY3TTFDM3lyT3E1bFFxZGFrWlFVK2NRbWRsbTFBenVtVXA1?=
 =?utf-8?B?NkZFcUs0U0tMaHJ1NDZMWm9GbWdzWUZwdXg4MXJWVkJ3bEI5VFJ3ZmhvR2l3?=
 =?utf-8?B?Y01sVTBKV010SjY5WCtSL0dwT2RSNlBpbktzZ2VEeEl6L0VFZkpNRVNHTXpC?=
 =?utf-8?B?ZnhvRVg3VHBsOHJOUDFVcFRqRlBlYmN1dDZUQ1I0NUhRZXViWkRvWXZCWS9q?=
 =?utf-8?B?ME5ZSW9TaDF2QWZSWEdidDdvaXlRQ3YyRkU0M0JpaUZPL1hsUDlKUXNTWWFN?=
 =?utf-8?B?ancrV291VkRoeEdRUTZlUmdBQVFjcTlNTzVNZjNhQy84ZllCeUhRRGkrcEVM?=
 =?utf-8?B?VWRZR21IZ0RJVWlxQWYzenJBUkxabDdCNHhiYWhPem5JMzNjcU5qWFlwUE9U?=
 =?utf-8?B?SkFucTdhRUJmeVdPUEF5Q1dNWFhGS29qU09RY0ZXQnRnWVRCOUF6ZG1ZQXFK?=
 =?utf-8?B?UTBFUU14c2V2NklpR2t2Ujc4N3JYQWZrd1k1dS9zTEZPa25DbFArVk5CV3dX?=
 =?utf-8?B?M3R4UXVEVElkOElZQWpWNFJudmdLWU1ia1hiYitTTTNzYlpnNjcxOU03dThl?=
 =?utf-8?B?T0tYVkJrYXdlb3FYclo0UmYxRjIzd3BIa0ZPNTRNNTB2bW0rYUJFdGExSlUx?=
 =?utf-8?B?NjZxNkl6aXRYVTNsb0l6S2ZGV2tGNFlxUkZoZFZNa3doeC83TzFrdkVqMytw?=
 =?utf-8?B?SDU4VzVIL2xkYWlrcDhiZ3piSUh2cjY5SGVneEpWaXJuV09uenZzeDl2dCth?=
 =?utf-8?B?RTFkRmcrR3plVmtYREN2RFZFTnBxbHVuYjNkeVpSdFRHZUhXRDE3QW44Mzgz?=
 =?utf-8?B?VEdKV0QreFc2OXh3eU5HQ0tXRjdEemUvYXdoRTlRellzOURtemROMnVxRnFU?=
 =?utf-8?B?QlNNQXpJOFR3MWYwNFp5YTBpRWpEM2RhWjljdkNtUldwUEsvcWVkRU51MGFp?=
 =?utf-8?B?OFd2dmxqUEMwS1kzWXBjTXoyZS9GVk9vb1ZwS1ZLcTd3NUpDNUQ3OC9wTWdI?=
 =?utf-8?B?cERoajFDRStRS1pVbTNJRVdkUnV2VGRCWWtBNmw0a09yVFVlTW1ob0ZBZXFX?=
 =?utf-8?B?VG1nY0NiK0lKZStuRVppZ29SQkxyR2hyTU1wV2tFbkc0U1BEWkgzRWtIc2Q1?=
 =?utf-8?B?dEdPNGRJKy9Qc29yQ1U1N1JLU3B3dHUweWk1YlV6cHRhTkdvbXkwRjc1NHA0?=
 =?utf-8?B?WlpmSHdhZjBoZGtrQkEvT1luQUxxU0t3eTgxbkhoTUU4c3Q0eFVJNUU3dGty?=
 =?utf-8?B?MjRFNmRUYjZ5QW9iekFnaEQvYmJZY3F0bkF3SjRWS3N1WFFhckZQd2NTWmJ2?=
 =?utf-8?B?Zi94cGlkUWwyeFVaSnAwelhMMi8vd0Z0eEZxQ2x1Y1NzT1EwR2kzNlgxTW40?=
 =?utf-8?B?NFRQakt4elJ2aVQrQ25ZM3luVkVZSU5RQkJrSUhXUHkzS1BUeHp3YVcveWtO?=
 =?utf-8?B?TURETTcyN3U4R3M0ZTJNU3BzS1dORE5ka1hWZFNWejlaZ1RqeW1ZZTc1dzJH?=
 =?utf-8?B?RVBIQzFKaFQvK3IvVStxYTZKOUpBRVlFYXdrRTdIODBjZE1WQTVjb3BiTG95?=
 =?utf-8?B?S0xqcE1WNERQZDNpWkdTNnd0ZlFmR01sZ2NMNGNnWXdTenF5VDBGSmR0L3pw?=
 =?utf-8?B?bW83cUtlNVhQdnFKSi84RkZpL05VZ1RZS2ZGK0JFaTJlZXZRS1RzWHMxbzNr?=
 =?utf-8?B?RUhmYXhqTDR4NTJtekExVFBvYU5LSzY1NDgzRW9Tc3FsY3o3SmhEc0MvdW5P?=
 =?utf-8?B?VnJIcjVvZHpYS2VnbXpjL0Y0Ym5PdUQ2enY0MEhRclA1NzFTS0c1RXlHK0Yw?=
 =?utf-8?B?Wlorc0pVdTE4UlZyazAzbDJvMnZuVUorWGsyK05DL09DK3d6Tnc1RFpIVmtj?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5bde7f-6793-4368-a03d-08dc6f892abc
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7164.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 18:03:29.9358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wXXu+TWZjDi/qQGaakEiAoyJhgJ2rPGjWj0fIoZCt2oYRE2oKGafaManqeU42oX6paihsGIHMHeB0Sdh2AaYAAdzs7xUfEZTERka4pm1yVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7471
X-OriginatorOrg: intel.com

On 5/8/2024 7:40 AM, Dave Hansen wrote:
> On 5/7/24 16:53, Chang S. Bae wrote:
> 
>> However, due to resource constraints in storage, AMX state is excluded
>> from the scope of state recovery. Consequently, AMX state must be in its
>> initialized state for the IFS test to run.
> 
> This doesn't mention how this issue got introduced.  Are we all bad at
> reading the SDM? :)

Ah, I'd rather zap out this SDM sentence.

>> When AMX workloads are running, an active user AMX state remains even
>> after a context switch, optimizing to reduce the state reload cost. In
>> such cases, the test cannot proceed if it is scheduled.
> 
> This is a bit out of the blue.  What does scheduling have do do with IFS?

$ echo <cpu#> > /sys/devices/virtual/misc/intel_ifs_0/run_test

Then,
run_test_store()
-> do_core_test()
   -> ifs_test_core()
     -> stop_core_cpuslocked()
       -> stop_cpus()
         -> queue_stop_cpus_work()
           -> cpu_stop_queue_work()
             -> wake_q_add()
             -> wake_up_q()

So, the CPU stopper threads for <cpu#> and its sibling to execute 
doscan() are queued up with the highest priority.

queue_stop_cpus_work() has

	for_each_cpu(cpu, cpumask) {
		work = &per_cpu(cpu_stopper.stop_work, cpu);
		work->fn = fn;
		work->arg = arg;
		work->done = done;
		work->caller = _RET_IP_;
		if (cpu_stop_queue_work(cpu, work))
			queued = true;
	}

Those threads are created during early boot via 
smpboot_register_percpu_thread().

> I'm not sure those last two paragraphs add much value.  I'd try to
> banish most of that content to *after* you talk about the solution.  Or
> maybe put it in the cover letter.

It looks like lots of distractions coming from bunch of alternatives in 
different levels.

Thanks,
Chang

PS: Let me respond the solution discussion separately. I do want to 
experiment the init-track behavior a bit.

