Return-Path: <linux-kernel+bounces-198363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFE88D772E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 18:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63DC62818FE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 16:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1B254656;
	Sun,  2 Jun 2024 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iFfX0L05"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2B721362
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 16:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717346442; cv=fail; b=u+XyhYzQJPwx0Kwf/RP5sdD3OC5TLZoU/0kyGwVkwOEU/EshI9TJPGufAVgD35DN+IBUpJpBRKBzWH+C0saqpdEoZZzSwDJgSpY6UneN8cE8x3HENfLe2EzkFU9KnjGCqXMntvGLCSKpk4OY3hW8X9a4iFDLvAnjUqA9m0mfVx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717346442; c=relaxed/simple;
	bh=H2Zw6EDUJZ/lEh9xU2jQ+6OdUo22X9p+5w9FipAfiSk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q8NnhWp217BhiAcLsOBMOc5xMMhYd7h0LunJMMRtVl9dnkqIWl52rCLHNOZHw/9dY/PPveJGN9S6mzCZoRBgcH6me3DbScuhYk1wb7U/B1rpNnUpOXyk8MH2b6WJr6f10zUULT6qiCBnLigajbcTII0BmJCd/7mUeei4obFMVPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iFfX0L05; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717346440; x=1748882440;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=H2Zw6EDUJZ/lEh9xU2jQ+6OdUo22X9p+5w9FipAfiSk=;
  b=iFfX0L05PUsfxuymEu+5kfa5DzgYkPXDhLK5oPUuT46cmAr8WzUv/ZP9
   W2wCGLY+enaOqFoFLq4AxVqc5jbnCtnXTQ/+CJyHnUMN3D0MUt4mmKfNy
   kSLUkct2LuXy+mqSL9QjudQObvpL6RBqiO93O5PCgcm+ClMiGp6RTUsab
   KBZTfF83um8kR9Wjrxx5d91Bp3WwkvY7xwvmLtQjcyvkezAl0d7safsMt
   nRfI40Z9b3v4xXShHe6btLW80THCwA7hMTHe5+chQ0++WST6Xli+RjGGE
   g9NQXmq+agSWh1y+svFDAa1bylbYRqVYUn7eiPUpXxbQMeocAAzUSoAKk
   g==;
X-CSE-ConnectionGUID: jDFAlwVNSHGnBKBnVX7DmA==
X-CSE-MsgGUID: QLBC4eeuS5OlbTKtyJBjhQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="13593802"
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; 
   d="scan'208";a="13593802"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 09:40:39 -0700
X-CSE-ConnectionGUID: 3pvCavhSQuqjxKIYitHvHw==
X-CSE-MsgGUID: 5mT9lHtGTTeY1pXT3fz/rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; 
   d="scan'208";a="67492110"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jun 2024 09:40:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 2 Jun 2024 09:40:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 2 Jun 2024 09:40:38 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 2 Jun 2024 09:40:38 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 2 Jun 2024 09:40:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDhVfqiR2snf71P3q4YaW3rrCl2gia0zhPr+S8wwIdv7E4PA/r3sH/hsucreOAGk9goZd28Oh+wcFrZRI8A3NK3uoXxTmZN4j8xY3FqVWPfP0LcwZSlspRL7pV92rJcZDlGB7u3dfeiUsQ/9PVGz+TAyaLVOad9IctveIOq0Iahmp7zXWDOVjxrS4IgT5LYxvAS+ADP8erNQSkuV2fVZxFxXzO+gXvFjNxLeI+C4Crg8mhJ6YrSzIML+IpkoOg6sEQl39l2tMVcPZcV9CaS8RM5tw+C6Ph5MMBFL8/YEzUvRdjUg5dHKHMvCKaA9RdPPOfE+kPBuwCNK7gVkD0Du9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdcOJWAFE7m3wIk+mcM/RCETJcfFuVSvXkqgQahW5TU=;
 b=HY4dMy7zb6q1ItF1nD0mp1k4MB1clV1ALwg55EixmslqnVyYSU72v6nbGorfU2SWNo7FowrNPlx/91/Ww8azPduMCWzxZzmEXbvxAwbwejCuXvZ0Tbdvn7rbz2tyLshBalaGspVaK6Y2+GGiDMjboT5iK7/qMnkAK31wck/9CBn2Zy+VvNTlep40cM9VStCaoGNujoV7guctQpI0IgmaTiZ8821K2/ZYA5B0bn6dCPx73sqExm0YtbjxW9aIwwOs46DXlMANX6bHsBpkxeEcSS417Qt+I5d3a4wVNkmemk66WCUi4kaOGb/OLup13m6UmtTObUWzvbvlwQDH3bgLqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 CY8PR11MB6843.namprd11.prod.outlook.com (2603:10b6:930:60::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.21; Sun, 2 Jun 2024 16:40:36 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.7633.018; Sun, 2 Jun 2024
 16:40:35 +0000
Date: Mon, 3 Jun 2024 00:40:26 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Tim Chen <tim.c.chen@linux.intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, <linux-kernel@vger.kernel.org>,
	Vinicius Gomes <vinicius.gomes@intel.com>
Subject: Re: [PATCH] sched/balance: Skip unnecessary updates to idle load
 balancer's flags
Message-ID: <Zlygeqy+SVs1KZYW@chenyu5-mobl2>
References: <20240531205452.65781-1-tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240531205452.65781-1-tim.c.chen@linux.intel.com>
X-ClientProxiedBy: SG2PR01CA0141.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::21) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|CY8PR11MB6843:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dda8cce-aefc-47c2-6c32-08dc8322ba45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MFRSdUlFb2hCaS9jTWphK2h5U2FBYklLK3dYeVBaZVJDVFRwWXNnNUtyV1BP?=
 =?utf-8?B?Tk4rR05GQ3BXM1ZKSXRBK2FGbXdkZGZBbDJ3c3JLbXY3NytMRkdwK0M0VlND?=
 =?utf-8?B?OXB5WUx4ZTBnTmxISElNSTF4UnhvWnhMZW1PMXpDVTFHWGh0U2U2dzNTYXBG?=
 =?utf-8?B?NzZOZFl6SjNSYnFZMjVxVjVKdnFhYnlpSC9JdkppT0ZuWEFSNktBWGRaSVc1?=
 =?utf-8?B?cDVYZVpsbmhnTDFYbHJyb2M5WGJ4Z21TTGRmMkpjVy9yaU5vUjFtNU5FejFU?=
 =?utf-8?B?WGF1S2FTeW0xWWZEZ1hmOTJXM1NMZ1VlRVNNL3Y1czhkamhEaGZPUVlwVmJm?=
 =?utf-8?B?VVJobzM1NEwwR0tRSWRRanJnS1JFSTFuQXF6TXF3Yy9SZndjNGV1THJmNytL?=
 =?utf-8?B?TEpPazJCK2c1dUFEYjYweEtEUGlnbVYya2FKNHlRVlNBTCt5MGlhVXJJQ2s2?=
 =?utf-8?B?UmhQOE8zOXp5N2VGRTEvdXZlWmpOcmoweldvZERJcjdaM2ZnT0Z5Slhvdjlk?=
 =?utf-8?B?SkRjWE13RE1tOWNzWW5nbXU3OWc4aTNRclJUcXIxSnpEajZHbE1BbUp3YzBH?=
 =?utf-8?B?MFVnVGNrWUU3M0pXNGRxdGwzdjNhdStHN1BvdlVZSFdyeVJ2dTF5QWNZK0I2?=
 =?utf-8?B?SU4zU1NMcDZLMTltVHdWc3pCVDN5cXE0MFBzaDJiQkc5RGJHVXJsbGtxSzdu?=
 =?utf-8?B?ZkE2V1BqY3BnUlBJRE9VMmFtb25yMEF6bEVaR1NCeENnVmpLQVl3Z3BJMThw?=
 =?utf-8?B?alo1clg1SXdLcUFUTzRjUU9hMmRNRk41bVJWbmFJNmNOZUdPcnBuY2Nhdzlt?=
 =?utf-8?B?U2F6dFREandIQ01SVHdOVWZjYi8wRlAzNmo1Y1VReVEwU29qa3RKbU5iYjZt?=
 =?utf-8?B?akIzL215ck8yWmFGNzJBcVdwSytGRzRCTEY1ZkRtVXJOVVJ5dTF1YmRnSWFt?=
 =?utf-8?B?WGZiNDkyb2J4MDYxWEtRejZYTlNPbDJrOFhKU1J2ZDBiN2o0OHA4cW9WK1pp?=
 =?utf-8?B?UWlQWEsrT29CMTNQUUNBQit4WkhRU1EzN1NRNlZGK0hHM0phdjg0emw3WmZS?=
 =?utf-8?B?YzhJQy9GcXJXSDZmbG9NbnFoVWJRNElBelNSUUtUVkJwU1ZEWWp1b0hIZkht?=
 =?utf-8?B?U1hEeFZWSDRoTmR4WXcyVy9IY3ZFblhKQ1grbW5tbEtPUVpCUUgrcDgvZW1R?=
 =?utf-8?B?MDU5R0JsMnB4VDNWc2pkcFJyUFQwamVhSFZ1V3RMQzRuaHdzbTcxblVRNm4w?=
 =?utf-8?B?aHlYMXluN0hvN1NOREV1SWNrN0h1OGJTK3dmdm9jK1lLWGhWWXYzMXBGMHBz?=
 =?utf-8?B?YzdVVGxxYjBxV3Q0TzE0RTZaREpYUXducGlFZllOYllLM1ZYdG1DdWUwdHMx?=
 =?utf-8?B?SmgxYXh5YXFXbHlCSVh1dXRMeGJPS2t0WmVjTVI3Y011WjVtMm9QS2Fpb2pt?=
 =?utf-8?B?TWsyQVN6R1RFRS9TZ2NUS3BVV2h3ZEVxWmpaYTJtaE9aV00wcTNRdi9PQmlO?=
 =?utf-8?B?eW01WEN1TmNzdHdpdFZhNHRGR3prNk5aZTRzd1l2Z0pjaFdGcnQ5VW9yQzM3?=
 =?utf-8?B?Nlo3K3NBTFlmMDJRNVA1TklKZUkrbXUvelpaSFBRd3RZdEFReTdxSFpqSzUz?=
 =?utf-8?B?NzJaUjBtdzRTNkRUSENXSk1Ca1Z5Nm1RSmJjdWRWa3NxWXd2Vk1iRXh1SlQ5?=
 =?utf-8?B?c0ZkZ2hKS1FsWmRLMm8vL3dIU0k3ekdWSDBQdTBvUlE1T2h5YW1INGp3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDFvTzFySjREZitWS25KbXRsWWxoTjZ6SEFka0kvcjlQQ3Byc05pUlZxL01a?=
 =?utf-8?B?cW93S1kxbEd0ZndRaHgwQ0JLL2VjSUwvaVphNFlPK2orRys4eDJKeWNkUGQv?=
 =?utf-8?B?cWhsWjlUMXM1Tm1FYlV6NzRXSkVncjlOVE1hdWlCcU1WSXM3Q3RBYUN5RzZC?=
 =?utf-8?B?WDM1eHFEbTdEbHZNV3dUU0tuTmp4blVLNHNXeE81dkdGUTUvUHJUUVhsWm1E?=
 =?utf-8?B?dzM3QldITWZ2anY0VTkyQUplWThwRFRJVmJYeVN6SVpRdDZzR2FDSHhaQ29z?=
 =?utf-8?B?UXJMajZpbk14cXR4NVdXakxsbHR0ZDRxajJudjN5MUdIOUY1Q1RCaFRhOURF?=
 =?utf-8?B?ZkVjZVM2NXBiS0V3Zkg3bFNRVUViODJjNDRmTWwzeFpHcDJmTm04OEl6U3Ru?=
 =?utf-8?B?V1l6Y0JiYkhKWXh2NlZla0Zpakt6UG80cVNFRGR1dXpEY0trdUtSejVNWUh4?=
 =?utf-8?B?cWxwSmxkQUdHcUVBUGtJbWxOZHVnZGVaVXhXNmdzZnIrb2hhM1FlbzRLTUda?=
 =?utf-8?B?MnA5TnI3YXV2bDJWWXNHbzJtbmpKRWphMGdBU1Y3SVI0M25qSDllcGE5dmJR?=
 =?utf-8?B?YzArSnZpVlZlWllsayt2LzN1Wk8ybXVmalprUWtRd0RCZFI1ZlllNElrQVBi?=
 =?utf-8?B?VzZNUW4vOS95Tmp6OE9tZHJXWG1wTy9KTTF1OCt1WHIyVkc3R1Z5ZTBvYS84?=
 =?utf-8?B?c090S1plam91WVYzc3RPMFBzMFBDSFMxMTgzd2lQQXdzUUNYYlM0Q3FCcWwv?=
 =?utf-8?B?dTE5TTdXWjFNS1JEOGFTUEI5aTJ0QmI0V3I4NjVoRkdXVURYY0E4QjNGWFdD?=
 =?utf-8?B?THNQTHp1TWFYSXNKVCtqaVJ6aEpnRDd6MlNmOGVKSWY0SjF4WWcyZ1FEUlZ0?=
 =?utf-8?B?eGpWcC9POW0wWFhWUzhKRVk2bUcra0pUOW9ZcUVJVFVPMlYzT3J2MzJiOGN2?=
 =?utf-8?B?Qy82RTMzV2prYU9abWIycStoQ25vVWQzV09uekgySTV5Q1F5RmY0dzBKNzY3?=
 =?utf-8?B?eGVEWCttRDJRaFJET0pnc0RXMGlxL2lWblF5eTVJSVJyZlBOeVBmUjc0c0xs?=
 =?utf-8?B?aHg0V2VZZmt5dVR6TUJPWWRpL2o2cTdDekNuWEtmN1llY0dkQ1pmcHlYd3RO?=
 =?utf-8?B?bEtRVUZsY3NoS0pwZ3cyUE1mc2pmbmR2QWFXLzZRNFpxZzBoZmx1TE5UREZ1?=
 =?utf-8?B?VjljdDFvbWhRU1JxWVVuSitOak4rZEcrRjdka3NVVzg2RlNNT2xrUTk3R25U?=
 =?utf-8?B?NGtUNkNGazVRZndwb0JpZWRvZnFHVHZHK0RZNjhxY0czNmVxTXhmSzZKNmlI?=
 =?utf-8?B?YnlOZDRJMHc2ek9TN1orb2crRUNjTDUyUmlUZHR3WUFVdElSVUZCQlBoT052?=
 =?utf-8?B?dllvMnV4NWdRSEp3U3RBQ2YvWVhMWHIrNk1nZDM3RlUrT01yVGZpY01sOVVF?=
 =?utf-8?B?YWp0aDE1VUNPa1FsaENHQno4dzljWlQ4QjFIOFNSdnhMNEh1Q3BXVjlad0R1?=
 =?utf-8?B?NWhJekF0WXlFaWhzNGhSUE9KUTlUNURHV2xHNmIvUTFENUQ3endBYldIQ3Qv?=
 =?utf-8?B?MG1kRXZ5NTNCSHQyUkZ4QzZJRVFFbnhKS1ZQbmtyd0R5UHZCdklaRXlhVGlO?=
 =?utf-8?B?SWpJdERocXVzekNxbW1VZktGNisvbzFIWWRnd0N1V1FlTXBrZVBVUVh0Z2Jk?=
 =?utf-8?B?SFk0ZkhLZkpuallBdmhwWkpGeXhwa0pDZ1NEYlA1bUpvYVQvSU1lQ0tjSlJD?=
 =?utf-8?B?K3ZVY1lCSXJVam43QjJudU5Md1U0d0VubFNqSWdPbmVkM1lKbnVTa2M3OEs4?=
 =?utf-8?B?eVV3ZjhXc3ptVlJNWVR0UDVhdVE4WGRkTk9tZ2gwamR5S3NoY1F0ejdpaXoz?=
 =?utf-8?B?eDlrbUV4NEFDcU5QdERLa3EwdEZBNFFXcGd1ajEvUTVMLytLZ0dKclRabjNG?=
 =?utf-8?B?SThxeXp4Qmd1RllRNmdQN08yZS9BUy9pb3h2V1ZMR3hqWkRTbGNxejV6eWVB?=
 =?utf-8?B?UGd0VjM0d1k0UkhVNVY2ZFhCNiswVXBHcXRWczQwb0E0cElXN2wvclZZL1Fz?=
 =?utf-8?B?bnozcG8vaE15bGl3S2w0eUYyV0lkcXd3OXl0SHpPT0dCVmE5cFZQK2tPSWt0?=
 =?utf-8?Q?Qs3vzyPZro1B+HMPKW9SGlTEg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dda8cce-aefc-47c2-6c32-08dc8322ba45
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2024 16:40:35.8434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fLCVp3WvQHa9lP/MxxEtiWXOR1/tufWOKJlNLZuUpKBP1R+aBVyZEdIm7AItNDfgIyITUZDimRSB+oxtmF4IrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6843
X-OriginatorOrg: intel.com

On 2024-05-31 at 13:54:52 -0700, Tim Chen wrote:
> We observed that the overhead on trigger_load_balance(), now renamed
> sched_balance_trigger(), has risen with a system's core counts.
> 
> For an OLTP workload running 6.8 kernel on a 2 socket x86 systems
> having 96 cores/socket, we saw that 0.7% cpu cycles are spent in
> trigger_load_balance(). On older systems with fewer cores/socket, this
> function's overhead was less than 0.1%.
> 
> The cause of this overhead was that there are multiple cpus calling
> kick_ilb(flags), updating the balancing work needed to a common idle
> load balancer cpu. The ilb_cpu's flags field got updated unconditionally
> with atomic_fetch_or().  The atomic read and writes to ilb_cpu's flags
> causes much cache bouncing and cpu cycles overhead. This is seen in the
> annotated profile below.
> 
>              kick_ilb():
>              if (ilb_cpu < 0)
>                test   %r14d,%r14d
>              ↑ js     6c
>              flags = atomic_fetch_or(flags, nohz_flags(ilb_cpu));
>                mov    $0x2d600,%rdi
>                movslq %r14d,%r8
>                mov    %rdi,%rdx
>                add    -0x7dd0c3e0(,%r8,8),%rdx
>              arch_atomic_read():
>   0.01         mov    0x64(%rdx),%esi
>  35.58         add    $0x64,%rdx
>              arch_atomic_fetch_or():
> 
>              static __always_inline int arch_atomic_fetch_or(int i, atomic_t *v)
>              {
>              int val = arch_atomic_read(v);
> 
>              do { } while (!arch_atomic_try_cmpxchg(v, &val, val | i));
>   0.03  157:   mov    %r12d,%ecx
>              arch_atomic_try_cmpxchg():
>              return arch_try_cmpxchg(&v->counter, old, new);
>   0.00         mov    %esi,%eax
>              arch_atomic_fetch_or():
>              do { } while (!arch_atomic_try_cmpxchg(v, &val, val | i));
>                or     %esi,%ecx
>              arch_atomic_try_cmpxchg():
>              return arch_try_cmpxchg(&v->counter, old, new);
>   0.01         lock   cmpxchg %ecx,(%rdx)
>  42.96       ↓ jne    2d2
>              kick_ilb():
> 
> With instrumentation, we found that 81% of the updates do not result in
> any change in the ilb_cpu's flags.  That is, multiple cpus are asking
> the ilb_cpu to do the same things over and over again, before the ilb_cpu
> has a chance to run NOHZ load balance.
> 
> Skip updates to ilb_cpu's flags if no new work needs to be done.
> Such updates do not change ilb_cpu's NOHZ flags.  This requires an extra
> atomic read but it is less expensive than frequent unnecessary atomic
> updates that generate cache bounces.

A race condition is that many CPUs choose the same ilb_cpu and ask it to trigger
the nohz idle balance. This is because find_new_ilb() always finds the first
nohz idle CPU. I wonder if we could change the
for_each_cpu_and(ilb_cpu, nohz.idle_cpus_mask, hk_mask)
into
for_each_cpu_wrap(ilb_cpu,  cpumask_and(nohz.idle_cpus_mask, hk_mask), this_cpu+1) 
so different ilb_cpu might be found by different CPUs.
Then the extra atomic read could brings less cache bounces.

> 
> We saw that on the OLTP workload, cpu cycles from trigger_load_balance()
> (or sched_balance_trigger()) got reduced from 0.7% to 0.2%.
> 
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  kernel/sched/fair.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8a5b1ae0aa55..9ab6dff6d8ac 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11891,6 +11891,13 @@ static void kick_ilb(unsigned int flags)
>  	if (ilb_cpu < 0)
>  		return;
>  
> +	/*
> +	 * Don't bother if no new NOHZ balance work items for ilb_cpu,
> +	 * i.e. all bits in flags are already set in ilb_cpu.
> +	 */
> +	if ((atomic_read(nohz_flags(ilb_cpu)) & flags) == flags)

Maybe also mention in the comment that when above statement is true, the
current ilb_cpu's flags is not 0 and in NOHZ_KICK_MASK, so return directly
here is safe(anyway just 2 cents)

Reviewed-by: Chen Yu <yu.c.chen@intel.com>

thanks,
Chenyu

> +		return;
> +
>  	/*
>  	 * Access to rq::nohz_csd is serialized by NOHZ_KICK_MASK; he who sets
>  	 * the first flag owns it; cleared by nohz_csd_func().
> -- 
> 2.32.0
> 

