Return-Path: <linux-kernel+bounces-257099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA357937533
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18639B2202D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2374C79B7E;
	Fri, 19 Jul 2024 08:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MZNIjbFM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789186F2F0
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 08:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721378654; cv=fail; b=GB8cKMrJFy9uWg81CRJSO+/hPuQ2shymvQtnPDpqk88C02pX2RJBruKJ9WAy9zJLzspLHzqiBLJuJL0oeCctXVw5KYSEiuvHHyDFE71lf7eR8+tdWNxoIFR8CSTftNSsHgA8Eyy5HTgO1AO/paHE5i9ImBUfRyCInqrNwBFdnVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721378654; c=relaxed/simple;
	bh=HPUizYKBlfoQzL5DHzArn5hIaLop/hgdXtnPAYrZp9Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EcrZennUuOStf3xOcdczb2bG15ZvadtqqMLGQIyEnlpHD20a1ziBGBijfXsLVFDgDj/+xNT1GXHRi+eGkHLRIStaW3xdp7HsjWAbeeHWYBLEKOHeRrG4p/PpK8g0Y9stWbEf6SOoQXiIvTsfhjfAmxX6wI5HzzpdNKEawi3IISM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MZNIjbFM; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721378651; x=1752914651;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=HPUizYKBlfoQzL5DHzArn5hIaLop/hgdXtnPAYrZp9Y=;
  b=MZNIjbFMq2sjF2nyoTd6HpNuNGh5imuZ4msLuo5FDf3agPBvTMNW9qon
   SKyrJFY+n6i3OtuHh4yMKNVE73nhb+t4OQkuao/XEpLO6kaEoAsRfleN5
   DZ8AXhKYOFfdHrSBotHaw50pnBNA5xIAg8nXPkIzkf2Z1M0sDVywoEA5E
   lbQg2lzolbkFikF9/YI/U+SvFQY0yNtyrOfWX7Ok0yrV26GzliIWnw+Yr
   wgbIW20xCyNnVmZ/XsJcmLPnYUslDiIrgJS/UUdazgT1rQKPOqKQZOI58
   ZaN0ptculWdxp/sLuq5xydgFoMDhhTFEAMiRLc9+fNCOeIs9eS7wHj8St
   g==;
X-CSE-ConnectionGUID: IctaCX3yQye9lEz345mXjg==
X-CSE-MsgGUID: dNwMSgiOQkO1E+lk6lCREA==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="29592741"
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; 
   d="scan'208";a="29592741"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 01:44:09 -0700
X-CSE-ConnectionGUID: te0Lt9OSQbSHqgbha4k7qQ==
X-CSE-MsgGUID: MyCPxJEdSzGuE2SNxVTMtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; 
   d="scan'208";a="50740310"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jul 2024 01:44:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 19 Jul 2024 01:44:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 19 Jul 2024 01:44:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 19 Jul 2024 01:44:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 19 Jul 2024 01:44:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stYStlGSL09d/7mbCdTF4zmOcDmO+EBy3raCgKDwHNtIP9BBqpnWC1fQ8KxhjJzdov88BtV8YEUBxKb+pmoKJwW7pv2tEHEQgCSYFUeySSy+UepwIpgVYte/GFD7CD0SIIl2YPXa2TKU+1qSsOStuWc+v7WFBZCP3l8RI+XtW57fR8EmXJqc+UjpWv+3N/RkyWx74cWseERR2jbtIVBw8wnXxmRSV96BDL/bZt9XYgTLIY+z8qVRgSQZhHUxDjptZTFdMRdz1vGCyrJWonqoShV+QpJnFFQ75pLm+0nkiJxCq3hnuzRJGyyZ1Nm1xTcBi4+BQVDa41SA/y3GucHYsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DF1uPS4rAycCYcxlGmpbCY3GkP5kD4l3Pzdj4D8xsvI=;
 b=g3NOVifF2F9pYHOmh7sckoOOFknMwvRZ8ZiVX8GMkgvkFITfcjW8zgx0ctGahpzAqw1F00pk1RCwN1nJDFSHjdb7xIZhWrpjN4/fixJFT20cBWqixmRdWI1siSNcmdw/E/ln1SilrzwEOVDdYa1Q0h/S6xMYnTXhSr6OrmHpAmZSYLalT+aGWS7iWAZcEp/irCKFxwDgCAmJ/unnCna48jKO7+BBP/0tffrb0tzPT7Vk/yOIAZBpzfcO4BSlr5uO6vme6eyOQm6/O1MWbWGblnGIcx9p8npi40NxUq3iJYcaVXHHwPn9RkgM8IWkPIFfOnZpBnEGvbK8RB3QC8SXlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB7292.namprd11.prod.outlook.com (2603:10b6:930:9c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Fri, 19 Jul
 2024 08:43:07 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7762.027; Fri, 19 Jul 2024
 08:43:07 +0000
Date: Fri, 19 Jul 2024 16:42:51 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Yu Zhao <yuzhao@google.com>
CC: Janosch Frank <frankja@linux.ibm.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, Linux Memory Management List <linux-mm@kvack.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>, Frank van der Linden <fvdl@google.com>,
	Matthew Wilcox <willy@infradead.org>, Peter Xu <peterx@redhat.com>, Yang Shi
	<yang@os.amperecomputing.com>, <linux-kernel@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>, Claudio Imbrenda
	<imbrenda@linux.ibm.com>, Marc Hartmayer <mhartmay@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, Yosry Ahmed <yosryahmed@google.com>,
	<oliver.sang@intel.com>
Subject: Re: [linux-next:master] [mm/hugetlb_vmemmap] 875fa64577:
 vm-scalability.throughput -34.3% regression
Message-ID: <ZponC7ewZeq62UzS@xsang-OptiPlex-9020>
References: <202407091001.1250ad4a-oliver.sang@intel.com>
 <3acefad9-96e5-4681-8014-827d6be71c7a@linux.ibm.com>
 <CAOUHufYvCeiGGa+3PbPDfFx__aV2XxyS7TMHMicws4aNTg4qmQ@mail.gmail.com>
 <CAOUHufaO-hxdEJZtdN-5EHEs-wOJoGQ1pVGeHaa89L7hSz8grQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufaO-hxdEJZtdN-5EHEs-wOJoGQ1pVGeHaa89L7hSz8grQ@mail.gmail.com>
X-ClientProxiedBy: SG2PR02CA0087.apcprd02.prod.outlook.com
 (2603:1096:4:90::27) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: 386ebb76-0d2a-487a-4bbe-08dca7cecf8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RTlFa0tuZXVaM2cxVkJ2MTVrMURmU2lXcUV6NGMyc2tBOGRCbW8zU1hjdlpQ?=
 =?utf-8?B?cGozM3JIcjlsN09CSEpuMExoTDZ2MHJNbk5oZi9hZVczdXB5ZG9adWNuWGRW?=
 =?utf-8?B?OVZWK0hqalZUK2dHbS8xWGFENHErN2l3Smt0YnUwQzhhV08ySjFMNHBpenFG?=
 =?utf-8?B?RzBkaHpxdGFCdmxaWUIwbis2WEJtcmJWUUpiQ25vaFpnLzA4bFNqS29XbkVn?=
 =?utf-8?B?NlRNcTNDL013ekUxM3pJUFk3WXlabFJ3d01TUzB3Q3R4YzlYcVRHYURLdUoz?=
 =?utf-8?B?aWZ3azJUZWZVZFJVSElhZUphRDZoejdjZkIzaFJkMlpPUU9rNGNOSDQ3WVl4?=
 =?utf-8?B?enhaV0ljbmtlNEZIN3JIU2hwNGY1WGhka2FJNktsR2t5cElKZ0wxbTUyQmFU?=
 =?utf-8?B?NHlYT3FRUUQyNkxwUnhGWjFUb1o4aUFLaFBFdnR3SmtPa1J5R0dEZnpoVzY4?=
 =?utf-8?B?aWNKL0F3UTErekdzOTUwUmlJUVFRcnBBY1hNS3VQc0Z2ZStIM0RZRloreGlH?=
 =?utf-8?B?RXByNWZXZlBtd2hiNXhXOW9xcVFzLzg5WWloS0tMcFJ2RCtQb2dHQXFxS0c2?=
 =?utf-8?B?WDVjbWljQ0pmWUc5Z0dvUTIvNTV2SDNZbS93STZubXVuV1A3aW9zT1c5QnEx?=
 =?utf-8?B?Ri9uMDcyeVllbHU5MG8rR294aHE5ckd2WGJ4YmtUc3YzcERPL2x6OVNFc0JK?=
 =?utf-8?B?Qm1VK1hyRW5CSVdnMlNYVlhac3hCZU1YdkIzbklwdjgxNGtiNGhxSG9VcXpr?=
 =?utf-8?B?MnRGQlFiWFlnamNIRTBaelpBQ3UrWVd6dHlkSzZLUGdHbURkdG0zd3ZjOFls?=
 =?utf-8?B?ZWdkSWdKSDBGTDBFR0s0NG1vQmZVc3ZWak1TM24vbTgwQ1NBbDhQeWh1WGov?=
 =?utf-8?B?eFhPQmlTcTNrSGhaLzJkYjZQUmNRaVRuME5MMHRBcG0yVUpNeHhjOUlQbmdk?=
 =?utf-8?B?TnMvNGJRbVNidzRNK1RxWFFTUlVSWnVWOW5tL1JTZnQwVjNFTjlaYmZ6ak1t?=
 =?utf-8?B?UjJJZVVYSkpZa0l5eERwMDhJU2thNnJSME9QRkpjVXdaQ2V3c0V4QzB1V3o4?=
 =?utf-8?B?aHljeU5hd25pejJiRXVEQjJJSlRJVU1jaXZnYTBKaldFRXlmMWFTUERleDgy?=
 =?utf-8?B?MGZ1cXZaeHBCWUJMVnB5V3hyZDhqeUdhcWRFY3Eyd2hHNFdZN1Byb2d3VVpo?=
 =?utf-8?B?OENWUDZiUlpaaU55RFhBcXpPQ1RxcTBQa2FycEZoQ2twcFVCbEtRTk5RaVBy?=
 =?utf-8?B?R2tkb0JtdHhFRkdON0hTbEoxdlZ0dGFyN2hwMDNvNEdveHNFaUk2Z3U0N0Rk?=
 =?utf-8?B?dytGZWc4cnJuNnl4Y2luR0Z6dzlIalY0aUxFdzMyZGRFbmdMeGtOdEhQT3p0?=
 =?utf-8?B?Q0lTTGlJUHV5RzQ0U0FlZC91dFdEV3Z3NUlJYksvNHhVeDFBSTB6RnhLSll6?=
 =?utf-8?B?dDdHRVlkZTBWZ2RDRkJGUmx5MmxjY1JCbVlpdnRySzVUSGpXWTEwOGdBS1ps?=
 =?utf-8?B?Snd3TjVrQitIaVZXT1JDSGhVS2kwRURtcDJTeDcxWU1jbXNXbHdsbkVyVldX?=
 =?utf-8?B?ZkRlZ1pUWmx0TDJGUEw3eG9NN1hnYys1NVVGaldyei9DTlJpd1B4YlJhNS9X?=
 =?utf-8?B?Wk4xemt6blVkaGZ4UTNOM05BMXJPMWkxUVZDVTJqWEhzZkRqTjZrS2w3eVRF?=
 =?utf-8?B?VFJvaTJma3pndHVjU2ZtVWFIbVpFMmpvdndmTmZXcXMzdHdWbTFWQ1RtcG02?=
 =?utf-8?B?RWp3TkNoLzRYTTJKYU1UVFlObnYvcTlJZG9wSTl3NlhDNmxlUXRlRXlrSlk0?=
 =?utf-8?Q?d4zDXsQDCr1cDaYTfMmwqTDbbQhcCRxvnNtDk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWJoZEMvdEhhelFlcVFPQVlMODBhTzM5N2x3M2NPQmhJOFk4V0w4UUgvQVhM?=
 =?utf-8?B?R05xMW1BclFuVTU1a3hpbTAwMnRuZEJrd0o5d2tDZDVzTmxUMFV5Sm00NHJQ?=
 =?utf-8?B?ZjdWNzM1TUw0eDVvQUpDZEdMTDRjS2xTWklnZlJORnA2N0dXR280TGUyVHp5?=
 =?utf-8?B?dzRLbzZzRlh6ZlhoaldVbHBKMnZDb1pNZnp0ZFhhT0Z0aVFqazFXK2JIQ3lK?=
 =?utf-8?B?aGVoRVp4QUFESXpOS0Q4TmpDSEpYeHpEcFgyUUdwbUZacmd5Y1hCblpaSTVs?=
 =?utf-8?B?NHFGKzhHa0JESDFBNzJJVjRPVVdTSUZuMUZFV0FNU2hsOWNuWGhjUmtSa0lN?=
 =?utf-8?B?bnlEV2dtbUFtSGJGaE85TDBCcVhnaVpzT0NTaGt2SG5HQTRKcDBKMFUwRTUy?=
 =?utf-8?B?aE5LTUkzb2JzWmNYQU80Y05lM2cxV1lDbVY1MHMrQUFKdVVWc2F6Rm1hU3pr?=
 =?utf-8?B?eFVkUWgvUk1GVkJ5WjN6dGhiK1pVUHdQQmYwRU8vLy9CWnJlanJROTg5RE9M?=
 =?utf-8?B?ZWhaNHcvZEVtNUFYRndFeVVCWjhNMnNZTDJOL1AvOFE2bTdwbGV3VjZaZFVX?=
 =?utf-8?B?OFY5RzdFSHVPUXJNV21MMVpSekFOOGlqNXdQU1FGak1jNVg3b0gyVHZxM3Rr?=
 =?utf-8?B?R0h3T0E0UHcwNVN0Y2lZV084bk5Eb09BMGxWU0EvWVllWFp6M0dwOUdmaEZ1?=
 =?utf-8?B?SG52dy94Tk5zWU9wUndqREpsWUYrTHVTWVd1Ynh1OFoxeGl0NCtIWFN4RHRy?=
 =?utf-8?B?NHltU25tWjdORkpDdElUNW1teUdnTkZObGRXMmE3Um1IUGNlNkRHaGlENWhP?=
 =?utf-8?B?aTc4cG94TEhXY1JlZ1VMdVkzZ3lsNGF1dWpxUVVhTS9rNWNPVUQ0cFZJaVNV?=
 =?utf-8?B?Y0doeG45ZENrLzBiOGRoU3Z6V21RNllNWnU5Wm83SnJmak0rSjhvNVlvR01r?=
 =?utf-8?B?Uko3N1NjMEk5bHM0U09ramFEWUU2b01ZWldnL1RpVUJqcHY5b3A2ZVBCY0s4?=
 =?utf-8?B?SUM0MC95Zy9PY1lZYWREaTB3Y0JNRmJYTktKd29zR1I4LzdYUmdvUTBCeGp0?=
 =?utf-8?B?U0lkRFo4Vk9GRWd5MFp2QTUveUJYM2FkZU8xVnF3V05QcXYvZ00rV3ZKOExu?=
 =?utf-8?B?dTRPenhxdDhUc25qNmJLVTh5RUxSaFozRzBLNEsyOGlUdm9NSEZDMmxGRW1P?=
 =?utf-8?B?RHlHb3dvRThUVlA2RTFxV2FLNWxZS2YrUE5LQVNPUUhPRk9nbkkxMFMrRWtX?=
 =?utf-8?B?MDFHK0NnNzRVdEVQWU5jb1hSeDJJWThaa3NnbTkzaFIybC9FdGZVMUZaKzNp?=
 =?utf-8?B?SkRLbHJHRGpxcEowcHhsdFk5M2tDckZ4SmtKcWJuMnR6cVFSaHd1WmFsTTAr?=
 =?utf-8?B?Q2lVaGQ2R2crem02dkVWdVlNeWVHWGZySFdVNGQzMFBqa3MxTEdSc0ZhU2J5?=
 =?utf-8?B?OHc4MC95ZmhMejRKOHFsZFFMM0ZTRlR4Z0hpZTBtK3NCcGk0K2tnNnR3elhM?=
 =?utf-8?B?bkd1VW52MGVTNFZDK3Y2enh2TzUyOHgzYUQxQ0dyVVRwbUdxcmE4dUJLS1M5?=
 =?utf-8?B?YUpFNVcrZlA3OWViZ2N3Z2MzdnA4RDl0OEJoakM1UngxaFU4cjV1L1U5Qm95?=
 =?utf-8?B?TnlBZVNlTmFJL2JjaVBoTlkvc2ptUUhSWGRSVE1Wbnc0Z3VuOHpSUTVrK2Nm?=
 =?utf-8?B?L2hIUjc3bm9lV0JMSjU1TFlRSnI5MEhUVGNIZm1RVnErSWd1TFBTL2tHL2Vv?=
 =?utf-8?B?Z2dTS2E2ZFlmN1R1WDlod1F3cHI5ako5bURQSXl3S2Rmd0w3c21CeDZJMUxK?=
 =?utf-8?B?elZ4VDRpOUE0UjdqMjdUSm9ITm5yb20rZDRiYWRPSmxpUWlMZDJKMzNsTERs?=
 =?utf-8?B?TnNhdlVySjVGM2VwWkljcUJYUjZjL3krakh3b0FWV2FqSUhsQ1FORFZqaFp0?=
 =?utf-8?B?MnpBT3VNSjh4Vjd0dzhRTlJ2a1VrWFpJZHlOVVgzQndhS3F5aVh3dE5BZGxX?=
 =?utf-8?B?T05INDJ0WmRpLzBpSnRlV3ZZNXl1SzNNcEc3ZHBISXpVOXN3YTl1dzhVZ2x6?=
 =?utf-8?B?dDJKUlFOQjQ3WUQxaVAyV1lpL2NwT3Q3dUxOeVVMeTl5MjMxam51S2VxVisw?=
 =?utf-8?B?VTAxYTJReEFhV1A2djg4WmtyamdQcG1wKzJmcGMxWTZUL2JiamdkNERLMlUz?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 386ebb76-0d2a-487a-4bbe-08dca7cecf8a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 08:43:07.0194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKDLD9PI+RzOlQDUOAJRTIIIrqdWpXl9856mwf1JUC2YLphzY08Dd/JGHzoRhSoZVabOB/xacSsYcINfPm+kIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7292
X-OriginatorOrg: intel.com

hi, Yu Zhao,

On Wed, Jul 17, 2024 at 09:44:33AM -0600, Yu Zhao wrote:
> On Wed, Jul 17, 2024 at 2:36 AM Yu Zhao <yuzhao@google.com> wrote:
> >
> > Hi Janosch and Oliver,
> >
> > On Wed, Jul 17, 2024 at 1:57 AM Janosch Frank <frankja@linux.ibm.com> wrote:
> > >
> > > On 7/9/24 07:11, kernel test robot wrote:
> > > > Hello,
> > > >
> > > > kernel test robot noticed a -34.3% regression of vm-scalability.throughput on:
> > > >
> > > >
> > > > commit: 875fa64577da9bc8e9963ee14fef8433f20653e7 ("mm/hugetlb_vmemmap: fix race with speculative PFN walkers")
> > > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > > >
> > > > [still regression on linux-next/master 0b58e108042b0ed28a71cd7edf5175999955b233]
> > > >
> > > This has hit s390 huge page backed KVM guests as well.
> > > Our simple start/stop test case went from ~5 to over 50 seconds of runtime.
> >
> > Could you try the attached patch please? Thank you.
> 
> Thanks, Yosry, for spotting the following typo:
>   flags &= VMEMMAP_SYNCHRONIZE_RCU;
> It's supposed to be:
>   flags &= ~VMEMMAP_SYNCHRONIZE_RCU;
> 
> Reattaching v2 with the above typo fixed. Please let me know, Janosch & Oliver.

since the commit is in mainline now, I directly apply your v2 patch upon
bd225530a4c71 ("mm/hugetlb_vmemmap: fix race with speculative PFN walkers")

in our tests, your v2 patch not only recovers the performance regression, it
even has +13.7% performance improvement than 5a4d8944d6b1e (parent of
bd225530a4c71)

detail is as below

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/300s/512G/lkp-icl-2sp2/anon-cow-rand-hugetlb/vm-scalability

commit:
  5a4d8944d6b1e ("cachestat: do not flush stats in recency check")
  bd225530a4c71 ("mm/hugetlb_vmemmap: fix race with speculative PFN walkers")
  9a5b87b521401 <---- your v2 patch

5a4d8944d6b1e1aa bd225530a4c717714722c373144 9a5b87b5214018a2be217dc4648
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
 4.271e+09 ± 10%    +348.4%  1.915e+10 ±  6%     -39.9%  2.567e+09 ± 20%  cpuidle..time
    774593 ±  4%   +1060.9%    8992186 ±  6%     -17.2%     641254        cpuidle..usage
    555365 ±  8%     +28.0%     710795 ±  2%      -4.5%     530157 ±  5%  numa-numastat.node0.local_node
    629633 ±  4%     +23.0%     774346 ±  5%      +0.6%     633264 ±  4%  numa-numastat.node0.numa_hit
    255.76 ±  2%     +31.1%     335.40 ±  3%     -13.8%     220.53 ±  2%  uptime.boot
     10305 ±  6%    +144.3%      25171 ±  5%     -17.1%       8543 ±  8%  uptime.idle
      1.83 ± 58%  +96200.0%       1765 ±155%    +736.4%      15.33 ± 24%  perf-c2c.DRAM.local
     33.00 ± 16%  +39068.2%      12925 ±122%     +95.5%      64.50 ± 49%  perf-c2c.DRAM.remote
     21.33 ±  8%   +2361.7%     525.17 ± 31%    +271.1%      79.17 ± 52%  perf-c2c.HITM.local
      9.17 ± 21%   +3438.2%     324.33 ± 57%    +270.9%      34.00 ± 60%  perf-c2c.HITM.remote
     16.11 ±  7%     +37.1       53.16 ±  2%      -4.6       11.50 ± 19%  mpstat.cpu.all.idle%
      0.34 ±  2%      -0.1        0.22            +0.0        0.35 ±  3%  mpstat.cpu.all.irq%
      0.03 ±  5%      +0.0        0.04 ±  8%      -0.0        0.02        mpstat.cpu.all.soft%
     10.58 ±  4%      -9.5        1.03 ± 36%      +0.1       10.71 ±  2%  mpstat.cpu.all.sys%
     72.94 ±  2%     -27.4       45.55 ±  3%      +4.5       77.41 ±  2%  mpstat.cpu.all.usr%
      6.00 ± 16%    +230.6%      19.83 ±  5%      +8.3%       6.50 ± 17%  mpstat.max_utilization.seconds
     16.95 ±  7%    +215.5%      53.48 ±  2%     -26.2%      12.51 ± 16%  vmstat.cpu.id
     72.33 ±  2%     -37.4%      45.31 ±  3%      +6.0%      76.65 ±  2%  vmstat.cpu.us
 2.254e+08            -0.0%  2.254e+08           +14.7%  2.584e+08        vmstat.memory.free
    108.30           -43.3%      61.43 ±  2%      +5.4%     114.12 ±  2%  vmstat.procs.r
      2659          +162.6%       6982 ±  3%      +3.6%       2753 ±  4%  vmstat.system.cs
    136384 ±  4%     -21.9%     106579 ±  7%     +13.3%     154581 ±  3%  vmstat.system.in
    203.41 ±  2%     +39.2%     283.06 ±  4%     -17.1%     168.71 ±  2%  time.elapsed_time
    203.41 ±  2%     +39.2%     283.06 ±  4%     -17.1%     168.71 ±  2%  time.elapsed_time.max
    148901 ±  6%     -45.6%      81059 ±  4%      -8.8%     135748 ±  8%  time.involuntary_context_switches
    169.83 ± 23%     +85.3%     314.67 ±  8%      +7.9%     183.33 ±  7%  time.major_page_faults
     10697           -43.4%       6050 ±  2%      +5.6%      11294 ±  2%  time.percent_of_cpu_this_job_got
      2740 ±  6%     -86.7%     365.06 ± 43%     -16.1%       2298        time.system_time
     19012           -11.9%      16746           -11.9%      16747        time.user_time
     14412 ±  5%   +4432.0%     653187           -16.6%      12025 ±  3%  time.voluntary_context_switches
     50095 ±  2%     -31.5%      34325 ±  2%     +18.6%      59408        vm-scalability.median
      8.25 ± 16%      -3.4        4.84 ± 22%      -6.6        1.65 ± 15%  vm-scalability.median_stddev%
   6863720           -34.0%    4532485           +13.7%    7805408        vm-scalability.throughput
    203.41 ±  2%     +39.2%     283.06 ±  4%     -17.1%     168.71 ±  2%  vm-scalability.time.elapsed_time
    203.41 ±  2%     +39.2%     283.06 ±  4%     -17.1%     168.71 ±  2%  vm-scalability.time.elapsed_time.max
    148901 ±  6%     -45.6%      81059 ±  4%      -8.8%     135748 ±  8%  vm-scalability.time.involuntary_context_switches
     10697           -43.4%       6050 ±  2%      +5.6%      11294 ±  2%  vm-scalability.time.percent_of_cpu_this_job_got
      2740 ±  6%     -86.7%     365.06 ± 43%     -16.1%       2298        vm-scalability.time.system_time
     19012           -11.9%      16746           -11.9%      16747        vm-scalability.time.user_time
     14412 ±  5%   +4432.0%     653187           -16.6%      12025 ±  3%  vm-scalability.time.voluntary_context_switches
 1.159e+09            +0.0%  1.159e+09            +1.6%  1.178e+09        vm-scalability.workload
  22900043 ±  4%      +1.2%   23166356 ±  6%     -16.7%   19076170 ±  5%  numa-vmstat.node0.nr_free_pages
     42856 ± 43%    +998.5%     470779 ± 51%    +318.6%     179409 ±154%  numa-vmstat.node0.nr_unevictable
     42856 ± 43%    +998.5%     470779 ± 51%    +318.6%     179409 ±154%  numa-vmstat.node0.nr_zone_unevictable
    629160 ±  4%     +22.9%     773391 ±  5%      +0.5%     632570 ±  4%  numa-vmstat.node0.numa_hit
    554892 ±  8%     +27.9%     709841 ±  2%      -4.6%     529463 ±  5%  numa-vmstat.node0.numa_local
     27469 ± 14%      +0.0%      27475 ± 41%     -31.7%      18763 ± 13%  numa-vmstat.node1.nr_active_anon
    767179 ±  2%     -55.8%     339212 ± 72%     -19.7%     616417 ± 43%  numa-vmstat.node1.nr_file_pages
  10693349 ±  5%     +46.3%   15639681 ±  7%     +69.4%   18112002 ±  3%  numa-vmstat.node1.nr_free_pages
     14210 ± 27%     -65.0%       4973 ± 49%     -34.7%       9280 ± 39%  numa-vmstat.node1.nr_mapped
    724050 ±  2%     -59.1%     296265 ± 82%     -18.9%     587498 ± 47%  numa-vmstat.node1.nr_unevictable
     27469 ± 14%      +0.0%      27475 ± 41%     -31.7%      18763 ± 13%  numa-vmstat.node1.nr_zone_active_anon
    724050 ±  2%     -59.1%     296265 ± 82%     -18.9%     587498 ± 47%  numa-vmstat.node1.nr_zone_unevictable
    120619 ± 11%     +13.6%     137042 ± 27%     -31.2%      82976 ±  7%  meminfo.Active
    120472 ± 11%     +13.6%     136895 ± 27%     -31.2%      82826 ±  7%  meminfo.Active(anon)
  70234807           +14.6%   80512468           +10.2%   77431344        meminfo.CommitLimit
 2.235e+08            +0.1%  2.237e+08           +15.1%  2.573e+08        meminfo.DirectMap1G
     44064           -22.8%      34027 ±  2%     +20.7%      53164 ±  2%  meminfo.HugePages_Surp
     44064           -22.8%      34027 ±  2%     +20.7%      53164 ±  2%  meminfo.HugePages_Total
  90243440           -22.8%   69688103 ±  2%     +20.7%  1.089e+08 ±  2%  meminfo.Hugetlb
     70163 ± 29%     -42.6%      40293 ± 11%     -21.9%      54789 ± 15%  meminfo.Mapped
 1.334e+08           +15.5%  1.541e+08           +10.7%  1.477e+08        meminfo.MemAvailable
 1.344e+08           +15.4%  1.551e+08           +10.7%  1.488e+08        meminfo.MemFree
 2.307e+08            +0.0%  2.307e+08           +14.3%  2.637e+08        meminfo.MemTotal
  96309843           -21.5%   75639108 ±  2%     +19.4%   1.15e+08 ±  2%  meminfo.Memused
    259553 ±  2%      -0.9%     257226 ± 15%     -10.5%     232211 ±  4%  meminfo.Shmem
   1.2e+08            -2.4%  1.172e+08           +13.3%   1.36e+08        meminfo.max_used_kB
     18884 ± 10%      -7.2%      17519 ± 15%     +37.6%      25983 ±  6%  numa-meminfo.node0.HugePages_Surp
     18884 ± 10%      -7.2%      17519 ± 15%     +37.6%      25983 ±  6%  numa-meminfo.node0.HugePages_Total
  91526744 ±  4%      +1.2%   92620825 ±  6%     -16.7%   76248423 ±  5%  numa-meminfo.node0.MemFree
  40158207 ±  9%      -2.7%   39064126 ± 15%     +38.0%   55436528 ±  7%  numa-meminfo.node0.MemUsed
    171426 ± 43%    +998.5%    1883116 ± 51%    +318.6%     717638 ±154%  numa-meminfo.node0.Unevictable
    110091 ± 14%      -0.1%     109981 ± 41%     -31.7%      75226 ± 13%  numa-meminfo.node1.Active
    110025 ± 14%      -0.1%     109915 ± 41%     -31.7%      75176 ± 13%  numa-meminfo.node1.Active(anon)
   3068496 ±  2%     -55.8%    1356754 ± 72%     -19.6%    2466084 ± 43%  numa-meminfo.node1.FilePages
     25218 ±  4%     -34.7%      16475 ± 12%      +7.9%      27213 ±  3%  numa-meminfo.node1.HugePages_Surp
     25218 ±  4%     -34.7%      16475 ± 12%      +7.9%      27213 ±  3%  numa-meminfo.node1.HugePages_Total
     55867 ± 27%     -65.5%      19266 ± 50%     -34.4%      36671 ± 38%  numa-meminfo.node1.Mapped
  42795888 ±  5%     +46.1%   62520130 ±  7%     +69.3%   72441496 ±  3%  numa-meminfo.node1.MemFree
  99028084            +0.0%   99028084           +33.4%  1.321e+08        numa-meminfo.node1.MemTotal
  56232195 ±  3%     -35.1%   36507953 ± 12%      +6.0%   59616707 ±  4%  numa-meminfo.node1.MemUsed
   2896199 ±  2%     -59.1%    1185064 ± 82%     -18.9%    2349991 ± 47%  numa-meminfo.node1.Unevictable
    507357            +0.0%     507357            +1.7%     516000        proc-vmstat.htlb_buddy_alloc_success
     29942 ± 10%     +14.3%      34235 ± 27%     -30.7%      20740 ±  7%  proc-vmstat.nr_active_anon
   3324095           +15.7%    3847387           +10.9%    3686860        proc-vmstat.nr_dirty_background_threshold
   6656318           +15.7%    7704181           +10.9%    7382735        proc-vmstat.nr_dirty_threshold
  33559092           +15.6%   38798108           +10.9%   37209133        proc-vmstat.nr_free_pages
    197697 ±  2%      -2.5%     192661            +1.0%     199623        proc-vmstat.nr_inactive_anon
     17939 ± 28%     -42.5%      10307 ± 11%     -22.4%      13927 ± 14%  proc-vmstat.nr_mapped
      2691            -7.1%       2501            +2.9%       2769        proc-vmstat.nr_page_table_pages
     64848 ±  2%      -0.7%      64386 ± 15%     -10.6%      57987 ±  4%  proc-vmstat.nr_shmem
     29942 ± 10%     +14.3%      34235 ± 27%     -30.7%      20740 ±  7%  proc-vmstat.nr_zone_active_anon
    197697 ±  2%      -2.5%     192661            +1.0%     199623        proc-vmstat.nr_zone_inactive_anon
   1403095            +9.3%    1534152 ±  2%      -3.2%    1358244        proc-vmstat.numa_hit
   1267544           +10.6%    1401482 ±  2%      -3.4%    1224210        proc-vmstat.numa_local
 2.608e+08            +0.1%  2.609e+08            +1.7%  2.651e+08        proc-vmstat.pgalloc_normal
   1259957           +13.4%    1428284 ±  2%      -6.5%    1178198        proc-vmstat.pgfault
 2.591e+08            +0.3%    2.6e+08            +2.3%  2.649e+08        proc-vmstat.pgfree
     36883 ±  3%     +18.5%      43709 ±  5%     -12.2%      32371 ±  3%  proc-vmstat.pgreuse
      1.88 ± 16%      -0.6        1.33 ±100%      +0.9        2.80 ± 11%  perf-profile.calltrace.cycles-pp.nrand48_r
     16.19 ± 85%     +28.6       44.75 ± 95%     -11.4        4.78 ±218%  perf-profile.calltrace.cycles-pp.hugetlb_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     16.20 ± 85%     +28.6       44.78 ± 95%     -11.4        4.78 ±218%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
     16.22 ± 85%     +28.6       44.82 ± 95%     -11.4        4.79 ±218%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.do_access
     16.22 ± 85%     +28.6       44.82 ± 95%     -11.4        4.79 ±218%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
     16.24 ± 85%     +28.8       45.01 ± 95%     -11.4        4.80 ±218%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.do_access
     12.42 ± 84%     +29.5       41.89 ± 95%      -8.8        3.65 ±223%  perf-profile.calltrace.cycles-pp.copy_mc_enhanced_fast_string.copy_subpage.copy_user_large_folio.hugetlb_wp.hugetlb_fault
     12.52 ± 84%     +29.6       42.08 ± 95%      -8.8        3.68 ±223%  perf-profile.calltrace.cycles-pp.copy_subpage.copy_user_large_folio.hugetlb_wp.hugetlb_fault.handle_mm_fault
     12.53 ± 84%     +29.7       42.23 ± 95%      -8.9        3.68 ±223%  perf-profile.calltrace.cycles-pp.copy_user_large_folio.hugetlb_wp.hugetlb_fault.handle_mm_fault.do_user_addr_fault
     12.80 ± 84%     +30.9       43.65 ± 95%      -9.0        3.76 ±223%  perf-profile.calltrace.cycles-pp.hugetlb_wp.hugetlb_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      2.50 ± 17%      -0.7        1.78 ±100%      +1.2        3.73 ± 11%  perf-profile.children.cycles-pp.nrand48_r
     16.24 ± 85%     +28.6       44.87 ± 95%     -11.4        4.79 ±218%  perf-profile.children.cycles-pp.do_user_addr_fault
     16.24 ± 85%     +28.6       44.87 ± 95%     -11.4        4.79 ±218%  perf-profile.children.cycles-pp.exc_page_fault
     16.20 ± 85%     +28.7       44.86 ± 95%     -11.4        4.78 ±218%  perf-profile.children.cycles-pp.hugetlb_fault
     16.22 ± 85%     +28.7       44.94 ± 95%     -11.4        4.79 ±218%  perf-profile.children.cycles-pp.handle_mm_fault
     16.26 ± 85%     +28.8       45.06 ± 95%     -11.5        4.80 ±218%  perf-profile.children.cycles-pp.asm_exc_page_fault
     12.51 ± 84%     +29.5       42.01 ± 95%      -8.8        3.75 ±218%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
     12.52 ± 84%     +29.6       42.11 ± 95%      -8.8        3.75 ±218%  perf-profile.children.cycles-pp.copy_subpage
     12.53 ± 84%     +29.7       42.25 ± 95%      -8.8        3.76 ±218%  perf-profile.children.cycles-pp.copy_user_large_folio
     12.80 ± 84%     +30.9       43.65 ± 95%      -9.0        3.83 ±218%  perf-profile.children.cycles-pp.hugetlb_wp
      2.25 ± 17%      -0.7        1.59 ±100%      +1.1        3.36 ± 11%  perf-profile.self.cycles-pp.nrand48_r
      1.74 ± 21%      -0.5        1.25 ± 92%      +1.2        2.94 ± 13%  perf-profile.self.cycles-pp.do_access
      0.27 ± 17%      -0.1        0.19 ±100%      +0.1        0.40 ± 11%  perf-profile.self.cycles-pp.lrand48_r
     12.41 ± 84%     +29.4       41.80 ± 95%      -8.7        3.72 ±218%  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
    350208 ± 16%      -2.7%     340891 ± 36%     -47.2%     184918 ±  9%  sched_debug.cfs_rq:/.avg_vruntime.stddev
     16833 ±149%    -100.0%       3.19 ±100%    -100.0%       0.58 ±179%  sched_debug.cfs_rq:/.left_deadline.avg
   2154658 ±149%    -100.0%     317.15 ± 93%    -100.0%      74.40 ±179%  sched_debug.cfs_rq:/.left_deadline.max
    189702 ±149%    -100.0%      29.47 ± 94%    -100.0%       6.55 ±179%  sched_debug.cfs_rq:/.left_deadline.stddev
     16833 ±149%    -100.0%       3.05 ±102%    -100.0%       0.58 ±179%  sched_debug.cfs_rq:/.left_vruntime.avg
   2154613 ±149%    -100.0%     298.70 ± 95%    -100.0%      74.06 ±179%  sched_debug.cfs_rq:/.left_vruntime.max
    189698 ±149%    -100.0%      27.96 ± 96%    -100.0%       6.52 ±179%  sched_debug.cfs_rq:/.left_vruntime.stddev
    350208 ± 16%      -2.7%     340891 ± 36%     -47.2%     184918 ±  9%  sched_debug.cfs_rq:/.min_vruntime.stddev
     52.88 ± 14%     -19.5%      42.56 ± 39%     +22.8%      64.94 ±  9%  sched_debug.cfs_rq:/.removed.load_avg.stddev
     16833 ±149%    -100.0%       3.05 ±102%    -100.0%       0.58 ±179%  sched_debug.cfs_rq:/.right_vruntime.avg
   2154613 ±149%    -100.0%     298.70 ± 95%    -100.0%      74.11 ±179%  sched_debug.cfs_rq:/.right_vruntime.max
    189698 ±149%    -100.0%      27.96 ± 96%    -100.0%       6.53 ±179%  sched_debug.cfs_rq:/.right_vruntime.stddev
      1588 ±  9%     -31.2%       1093 ± 18%     -20.0%       1270 ± 16%  sched_debug.cfs_rq:/.runnable_avg.max
    676.36 ±  7%     -94.8%      35.08 ± 42%      -2.7%     657.82 ±  3%  sched_debug.cfs_rq:/.util_est.avg
      1339 ±  8%     -74.5%     341.42 ± 24%     -22.6%       1037 ± 23%  sched_debug.cfs_rq:/.util_est.max
    152.67 ± 35%     -72.3%      42.35 ± 21%     -14.9%     129.89 ± 33%  sched_debug.cfs_rq:/.util_est.stddev
   1116839 ±  7%      -7.1%    1037321 ±  4%     +22.9%    1372316 ± 11%  sched_debug.cpu.avg_idle.max
    126915 ± 10%     +31.6%     166966 ±  6%     -12.2%     111446 ±  2%  sched_debug.cpu.clock.avg
    126930 ± 10%     +31.6%     166977 ±  6%     -12.2%     111459 ±  2%  sched_debug.cpu.clock.max
    126899 ± 10%     +31.6%     166949 ±  6%     -12.2%     111428 ±  2%  sched_debug.cpu.clock.min
    126491 ± 10%     +31.7%     166537 ±  6%     -12.2%     111078 ±  2%  sched_debug.cpu.clock_task.avg
    126683 ± 10%     +31.6%     166730 ±  6%     -12.2%     111237 ±  2%  sched_debug.cpu.clock_task.max
    117365 ± 11%     +33.6%     156775 ±  6%     -13.0%     102099 ±  2%  sched_debug.cpu.clock_task.min
      2826 ± 10%    +178.1%       7858 ±  8%     -10.3%       2534 ±  6%  sched_debug.cpu.nr_switches.avg
    755.38 ± 15%    +423.8%       3956 ± 14%     -15.2%     640.33 ±  3%  sched_debug.cpu.nr_switches.min
    126900 ± 10%     +31.6%     166954 ±  6%     -12.2%     111432 ±  2%  sched_debug.cpu_clk
    125667 ± 10%     +31.9%     165721 ±  6%     -12.3%     110200 ±  2%  sched_debug.ktime
      0.54 ±141%     -99.9%       0.00 ±132%     -99.9%       0.00 ±114%  sched_debug.rt_rq:.rt_time.avg
     69.73 ±141%     -99.9%       0.06 ±132%     -99.9%       0.07 ±114%  sched_debug.rt_rq:.rt_time.max
      6.14 ±141%     -99.9%       0.01 ±132%     -99.9%       0.01 ±114%  sched_debug.rt_rq:.rt_time.stddev
    127860 ± 10%     +31.3%     167917 ±  6%     -12.1%     112402 ±  2%  sched_debug.sched_clk
     15.99          +363.6%      74.14 ±  6%     +10.1%      17.61        perf-stat.i.MPKI
 1.467e+10 ±  2%     -32.0%  9.975e+09 ±  3%     +21.3%  1.779e+10 ±  2%  perf-stat.i.branch-instructions
      0.10 ±  5%      +0.6        0.68 ±  5%      +0.0        0.11 ±  4%  perf-stat.i.branch-miss-rate%
  10870114 ±  3%     -26.4%    8001551 ±  3%     +15.7%   12580898 ±  2%  perf-stat.i.branch-misses
     97.11           -20.0       77.11            -0.0       97.10        perf-stat.i.cache-miss-rate%
 8.118e+08 ±  2%     -32.5%  5.482e+08 ±  3%     +23.1%  9.992e+08 ±  2%  perf-stat.i.cache-misses
 8.328e+08 ±  2%     -28.4%  5.963e+08 ±  3%     +22.8%  1.023e+09 ±  2%  perf-stat.i.cache-references
      2601 ±  2%    +172.3%       7083 ±  3%      +2.5%       2665 ±  5%  perf-stat.i.context-switches
      5.10           +39.5%       7.11 ±  9%      -9.2%       4.62        perf-stat.i.cpi
 2.826e+11           -44.1%   1.58e+11 ±  2%      +5.7%  2.987e+11 ±  2%  perf-stat.i.cpu-cycles
    216.56           +42.4%     308.33 ±  6%      +2.2%     221.23        perf-stat.i.cpu-migrations
    358.79            -0.3%     357.70 ± 21%     -14.1%     308.23        perf-stat.i.cycles-between-cache-misses
 6.286e+10 ±  2%     -31.7%  4.293e+10 ±  3%     +21.3%  7.626e+10 ±  2%  perf-stat.i.instructions
      0.24           +39.9%       0.33 ±  4%     +13.6%       0.27        perf-stat.i.ipc
      5844           -16.9%       4856 ±  2%     +12.5%       6577        perf-stat.i.minor-faults
      5846           -16.9%       4857 ±  2%     +12.5%       6578        perf-stat.i.page-faults
     13.00            -2.2%      12.72            +1.2%      13.15        perf-stat.overall.MPKI
      0.07            +0.0        0.08            -0.0        0.07        perf-stat.overall.branch-miss-rate%
     97.44            -5.3       92.09            +0.2       97.66        perf-stat.overall.cache-miss-rate%
      4.51           -18.4%       3.68           -13.0%       3.92        perf-stat.overall.cpi
    346.76           -16.6%     289.11           -14.0%     298.06        perf-stat.overall.cycles-between-cache-misses
      0.22           +22.6%       0.27           +15.0%       0.26        perf-stat.overall.ipc
     10906            -3.4%      10541            -1.1%      10784        perf-stat.overall.path-length
 1.445e+10 ±  2%     -30.7%  1.001e+10 ±  3%     +21.2%  1.752e+10 ±  2%  perf-stat.ps.branch-instructions
  10469697 ±  3%     -23.5%    8005730 ±  3%     +18.3%   12387061 ±  2%  perf-stat.ps.branch-misses
 8.045e+08 ±  2%     -31.9%  5.478e+08 ±  3%     +22.7%  9.874e+08 ±  2%  perf-stat.ps.cache-misses
 8.257e+08 ±  2%     -27.9%   5.95e+08 ±  3%     +22.5%  1.011e+09 ±  2%  perf-stat.ps.cache-references
      2584 ±  2%    +169.3%       6958 ±  3%      +2.7%       2654 ±  4%  perf-stat.ps.context-switches
 2.789e+11           -43.2%  1.583e+11 ±  2%      +5.5%  2.943e+11 ±  2%  perf-stat.ps.cpu-cycles
    214.69           +41.8%     304.37 ±  6%      +2.2%     219.46        perf-stat.ps.cpu-migrations
  6.19e+10 ±  2%     -30.4%  4.309e+10 ±  3%     +21.3%  7.507e+10 ±  2%  perf-stat.ps.instructions
      5849           -18.0%       4799 ±  2%     +12.3%       6568 ±  2%  perf-stat.ps.minor-faults
      5851           -18.0%       4800 ±  2%     +12.3%       6570 ±  2%  perf-stat.ps.page-faults
 1.264e+13            -3.4%  1.222e+13            +0.5%   1.27e+13        perf-stat.total.instructions


