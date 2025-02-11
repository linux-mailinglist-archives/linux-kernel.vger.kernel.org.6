Return-Path: <linux-kernel+bounces-509881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9013A31571
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 20:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 207103A4C9D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 19:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4925A26389E;
	Tue, 11 Feb 2025 19:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mv/Skupy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A31B26388C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 19:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739302171; cv=fail; b=LKlIF4ZQl3a40+/kRdfKpUKCrPTxfu7xxoEU7+0zXUTrJK2zn4KE098toEqW0hVkEl/5rcc1e8PV5Cyqnpfqa8AibbP5HT7oKLi4IxAdbWOxJGMdjXdRUDkK2V9NT1MIAm3u4/Qd+DHETEHoQZc14CEMkrNfZxWiLJFwVuyHKjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739302171; c=relaxed/simple;
	bh=y+hbC1G0t9YGJOB1BujbXFJsL7It9QFBJmCJP3RXwvA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HkUUxx9WZ5+9SKqoabkVcTUhKMw3GLXmBVPv9KwrdTJ5+0pFJzIA3wHV9XE/j8Zb5e0MbdshQ9OoY/kFIk2o+Ac15BNTi+NztYmpk3bT2QgXxYwmWMhCPLqaIyrnjkICLe5+dX8amQWkavLXdi4XSDBxlc35YRNmAn3P3SAtYos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mv/Skupy; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739302169; x=1770838169;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y+hbC1G0t9YGJOB1BujbXFJsL7It9QFBJmCJP3RXwvA=;
  b=mv/Skupy+Z356uPfh/15zBgC4TEJMuSsTHaq0qShTAo68744jwAmDFRN
   ms17jwtFT11tX8EHz5Ddcghr2L0fmytvFIInTBZIpKH5IRLNjfYs4WvBW
   uk/98Fim2vuVbG6xzk6oWraRmO8HxC3G7qcFmRcgC7Kijj+iqrcRAqdC0
   hNnb8m88cPPVoalBkGKNXgFPQfjH4DQCD0VcKm3O8MtkMOqZ1GmagpvnH
   hJ5n+b5Yn3cZ+Sclgyts2Jr5GydcaBld1/2VK+f4ipAdllqctsJVSEgP2
   mZU/mnQ2ZngibbDiS90K9Avyi0fjrhwd2bqUxDBwBfVSP+g8sGOUMF02G
   Q==;
X-CSE-ConnectionGUID: uUT1vstqQwCMtAlPoDTo+g==
X-CSE-MsgGUID: sQpfHwX5Sp6A5xOkMCIRqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50578552"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="50578552"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 11:29:28 -0800
X-CSE-ConnectionGUID: t35o054UTFCjtqlJkIWQ/Q==
X-CSE-MsgGUID: 5aCMFZvqQ7yBLid8fBjXMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="112582678"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Feb 2025 11:29:27 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 11:29:25 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 11:29:25 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 11:29:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3yB1NTPiEW47g1AHri+0Fe44PQAL/NfKj4J5qLvUkmIcxR9OEi0nXgxP2U664dngy6141ePTRPAGOEV6ubvIZqQNjisB6UtA4pn3eNEyNqhsJ+P8Ppvx7v5Hl2CAtcfSbgsgnYQ8AZTU997JlODwtinEI+4C3Fr5QxAZ93XIJjqz1V+S+ZK40kXI4cp/bVTR6oohVQ9YF/sxDt0kllKYS5/WMOVHEtAQNrMx5gVd22z3vH085DK39k384WjqqHEek7ot+B/FU3etykaYWNklEx0iXSDy1uqyNnZ7adEs+fL0BdWS+NZ5VWG1I2ft/PkSkJUm8cEQcj6gQbhkve3zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoU9qyQs3CAl0Pz14cyDTxD+HdWS6jFgBN5qsynn+dY=;
 b=Q8YBax+6rOin0jggC9UwQThAHIg5kJQdiFGvir2ERPS4v/pQrKbDD5dlSdRa0NEdpPfm9U8fxsAKwZSS8FkgnatWicew/COd3KwHYYip6BuHbZq9fUaX/XcSP8MxBTIGYkpr9CLKeAnPTerynrAdCNnto+AIoKux47BsmlEn4fooM8J7swhH4pylB3Hh/1mYLRiJivqGFSoat7xvDu8i1azcQXTJhFPKGfYbn7jzJhOY04PlL9uteje65caPsTBTH34aE0/AQUa22a3WaA/R2YKCN8jnydoZw4iSGgpdibbVCW6XQuckDDKA6hVV8H92hJvs3qAvV8GaNUXW5ykpDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB6893.namprd11.prod.outlook.com (2603:10b6:806:2b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 19:29:21 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 19:29:21 +0000
Message-ID: <1e3f655f-3e94-4da8-a5c2-0fbbffdb1d40@intel.com>
Date: Tue, 11 Feb 2025 11:29:18 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/42] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, Shanker
 Donthineni <sdonthineni@nvidia.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <f600712d-d089-4285-8d04-e12f53a61572@intel.com>
 <0a7cf2ef-55d9-470f-a2cb-03655a6329d5@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <0a7cf2ef-55d9-470f-a2cb-03655a6329d5@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0237.namprd03.prod.outlook.com
 (2603:10b6:303:b9::32) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a9f8d70-79df-4ae9-774b-08dd4ad26251
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0d3eSt3UmxZbllubkZacDY0MVYzWTMxSHl1Q1VMRzArbkFHWjROWHRKNGdZ?=
 =?utf-8?B?bFdCblYxQVcwQ3YvU0ZyWUg3R0NEMGFCcVczMzRWREFRcWhUMDFmZjFpSCtX?=
 =?utf-8?B?TmV1Vndrbll3ZXdyYnBnOTF5cUpvdWVpbDVVVWpsL0tWc0FIWHZ3ZkxlSEMr?=
 =?utf-8?B?UDBERzFEUi9Hb1lOUFczaVZsWnZ2OFUvZC9OTlo2cU8xaW9nZFkrZmFXb0cx?=
 =?utf-8?B?OE5SNHBZckZrQWRFUmtxN05NeCsyYzlNdHE1RER3bjVDWjRpcTFuemh0U2Jp?=
 =?utf-8?B?Nk13WmEwVkVCSWs3TkNiREFoTU9mczY0WVhNWFE4YXBjNU1XTjZPcE1zcXZV?=
 =?utf-8?B?L0tuRnJXSXczbGkwZDNnQWxOOUFtWmtlTGJ5ZGxHN2dLQmZ6WVR4RmV3cVZJ?=
 =?utf-8?B?U25uU2oxTEtWZmxHM0FES1RSSzBQa1g1OURkblBrWGJuVHlFUzFsaklmRUdQ?=
 =?utf-8?B?RDR2ZTZwY1ZtODdSRGhuSXRMeEZkSjg3OW9lOVBiRGl2ZWhLMnc4bU9qclVB?=
 =?utf-8?B?dVBiZGZrbnJpakZzRHByN095MXMrNGVjUjJlWWtQL2EvYnRRZVRFODFxTVZT?=
 =?utf-8?B?aUxLVkMvWnVVOVFtcDA0YWVOQ2Z3MUxOOG1TaU9QbzkyRHh4UHlTUnJ2UXpN?=
 =?utf-8?B?dkcrQTZTTlRHU0FqWGdYcUlyNE1IM2RzUUlnNlUzZVVDRmdmTGRIOXZBTkhH?=
 =?utf-8?B?WGlmYkJ0bmFWaEVDUkpjS1h0V0ZSaTBnYjZUSWxPSjMySEhOTnNCdUJabk8x?=
 =?utf-8?B?b1c3WGpJcnRGMEpzTi9oeXhtVGZFejlPaXVxN3FQVVZZQkZucSs1Wmg4bksy?=
 =?utf-8?B?V3pVNnY1NGYwb1dBYWx0ZnpVMEtYNmMxNXdSc1U2N0UyUDRkU2NnaERBcnVT?=
 =?utf-8?B?MmJ3ZHJyK3FweGRtWUgrWXQvV29vT256REY4YzBCTzcxYkhKbkhHZGp0M052?=
 =?utf-8?B?VUJXRHNMUUU3dXp2NkYwS0w3ZTNqbW1waWdsZ0VoOHArdkpEcjZrZlFjUE9z?=
 =?utf-8?B?aFZRKzBXaFVCNXZ3TkdsNkFJdm9UZER3cVZ1Y0JNdm02Mk53TmVMK2pSZmht?=
 =?utf-8?B?ZEJ6bll2N0JTR1hYdUZKbWhrTFFuTmNnNm16L2d4RHhHc21tSXpYMEttTFpN?=
 =?utf-8?B?MTFkcHlLOTFGWEpUdXYzQ3hCT0lDU3IyNnQ3WVVSU2hRVWFjK2xSa0d2SEwz?=
 =?utf-8?B?TFZPcGFEYk5JVXY0ZG9RTG81WVV1aGFxZ1dQR2E3NUVldHR6S3IyTG9oMTBY?=
 =?utf-8?B?cGl0MDhZQmJwWTZKNndBN3JoRnFRY0dwOEJma1hqRWtYMTRoTnY3YzJyTGtv?=
 =?utf-8?B?SWlOR3o3VUZpekRJRnBLdHQxamVxckJTNzEzbDAzM1B3dFFOM0RYTjlQMXVp?=
 =?utf-8?B?VzhrKzhZOFRaUWxLUVBsbXFaMTZNVG9RRWQ2MlJLOGJhd2RSTmJybW5mbXRC?=
 =?utf-8?B?YmJONU8vWk1IOFBwaTE4d3Q5YnVQWCtrMmQxK092ZHVkbi9UZ0FEMDZUbmph?=
 =?utf-8?B?cGtxMzNmUk5IMmlDZWlWcVp6Q0VWTHludHRBKzVSUXBTT3hPdnNWMUxMTW9U?=
 =?utf-8?B?MDloT2tSUFRqVUViRnc4TWVyYmJyU0poOW10U1hwZW5QaXhzOTlVd0FOWDQy?=
 =?utf-8?B?RlRUWWRDcTE1NFhCY01RajBhYjgzbVNLTVlPRm1iTk9xRFVhSzFXbHo0eVFv?=
 =?utf-8?B?czA1QVNjeUpkZTVoUDUzTEF0aUU3cVI0ZWNFaDhSdDRtQ0s1Zk5tYmNTaVV6?=
 =?utf-8?B?RlRMNHBGc21GZ3p5dEl0WC8ybHhKWjdPUjdFSytrVDBsNEtncUFmL2RqVlE3?=
 =?utf-8?B?VnFEZlhlakRVazR5Y1ZLaGhaWEE2em9kWjlPWENqQ1FwdjhESXZUSGwweVVF?=
 =?utf-8?Q?HKicUzqyO0vqA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVRWN0RnQ05ESjVJOHRJVmhaYStybGtjYno1eDlHTUF5VUdEckFsM3p1NC9G?=
 =?utf-8?B?WFYvT2EwZWJzVkcwcFFhTEwvNDZkVEdVU3VPajJNQjBBa09UOU5DcGwva3pJ?=
 =?utf-8?B?R1ptM21jc21WT05NMU0xVTF4cnNlbmdleHVXcUh1QU5FUExIQk1VeUR4Z3Nw?=
 =?utf-8?B?dXBRc0F0emVwUHNnRG13S0NhUmdaSlBuT3RtdC9FWFZZdmgrMkR6Q2NQTmNN?=
 =?utf-8?B?cUs1aVUvakRzTGorWTN2cTZ4OWZKRHZ3V2pWbURuUEJXUjFFT1k4WndzZzcv?=
 =?utf-8?B?TWlEZHZ4eS9IaWNTWkNnMUg0SVRCNkRnRVJlODY4Wk1iQ2pCQk9NamRWcUN5?=
 =?utf-8?B?WWlWNEt0VzJkbkM1blh3cW5kTE1oS2xzMnRobTF3Z3h3VG5rY1lRMzBFVFRl?=
 =?utf-8?B?YXFZK0VmL1RjWCs4aXl1cFJoWklkV3gwMEJzZDBqNVdBR1E5QkcvaW9YSitC?=
 =?utf-8?B?bVdTVWpzNWwvOW9LeklBcGRtTmF0bzdDNnYvYU81TElhZGlmazR2VFRza3Rr?=
 =?utf-8?B?Y2liOGcyL09vL09HWDU5TnphdFRTSEpSSS8rQ3pEY3djR2VDZDlXTzM3bzlX?=
 =?utf-8?B?bkNqNlVndnE2Q2MxTWIxS3NsU1ZyaUN3djNHNDE1ZGFweGZ3TTFJUlZ0dEJs?=
 =?utf-8?B?aVpmVUhHd1ViTWRGeFJWQXpVejV6U2J5YUJkZ2F6TzhNNGw4OVhBSVhCcGhh?=
 =?utf-8?B?MVJZQisrb2JRY2h5T09EQXU3VDgwVkgvQ1o3YXdUaGdNcWhDcnZCdVIxZFJC?=
 =?utf-8?B?TGVKMm84Rlo0Rnk4Nzd6UWpTQVh2c1lFcHQxS2RvdVdzVjhVUzJLTXE4aDY5?=
 =?utf-8?B?bWRaTGVaeEpuWFZzRVVTKzNyaUlHK3FuYVZXT2FvQnEzdGZ4V25TUEpLazR6?=
 =?utf-8?B?YlZJdkVoWjJ2ZDdpUHYvL3VwOStEOWRuOFJLOW9HT3RyMTF3aDVaK3JXL043?=
 =?utf-8?B?NHlZRzdwRnBtbDcyREJIM25XS2lwUWxOVkRQQms4S0ZPeThLbmZ5S1YzS0ha?=
 =?utf-8?B?d0lUSWxBcEVBWGd1Nm5UNWxRUmVRVFYxK3ZWYU4zS2FkMW1jVWhBNTdiTVJC?=
 =?utf-8?B?endlZElkRERZVDh0VDBNMFJpdmE5Nnd4T0RHSk1nNlpRRWhiVzhVRGN0VEpH?=
 =?utf-8?B?WnNnL1UzYTNmeVdFTkZkTkYvVVlNNjU0Nm1rNnlod21lMnNKVkpKcGhHK2lK?=
 =?utf-8?B?WmxqYnlldlM0L3gzdENqSlgxZTBYajdDcnFSRCtlTWpLMWcyTnRvR0p2T2Z2?=
 =?utf-8?B?eWZrMk12NnkzWHhvcXkvTy9SN0lmS3FvYmtRZndnMkNpNmhxTDZpWGhVSnls?=
 =?utf-8?B?TzFlSFFscy9qdXA5U0JxbXdDVm9KTmJScmloVi9ETlZnVGVhTTgxcnBsTFQx?=
 =?utf-8?B?ZkRrM0FSVVNoaXJqSTBTeERQNFA2cGdsZjFSQ2dlVmF3L0dGem9CdXdwYmtN?=
 =?utf-8?B?NjE5aXYxR0ZiSWRuT2tqUEVrOWZwWU0vcHdQYkh6Z04xckd6VDc0KzBoV0RX?=
 =?utf-8?B?bHEvSlhJYVBUenl0MDRYVlJjcmxqUUEySTRFazVQdkpVYnpQNXI1ZVdoMFQ2?=
 =?utf-8?B?QjRuSzROUkZmdTFsb2NTL1BHcnN1QWhxTG4rTEZLRW1kVjdPc3dZNGQ3M25W?=
 =?utf-8?B?U2pOSzVwRkxTZTZXS3Q1NVYrbXk3amJhYzRDWmVIMzloaGdPQXE4NlNpTzJr?=
 =?utf-8?B?M2crZUVqdjJoYlVHRkY2ekdUUmF4MnkzaloyQlYwWllzZ3ZtNy90UlR5eTY5?=
 =?utf-8?B?cFp5VGQyNVoxOUVYS1hzT29TbldoNWUwZjRoVStRazM0T2RUSGhhd1R5dDY3?=
 =?utf-8?B?OURZVitnalBKTzA4cmNyRUpaUTdFTnJXN1Q2NkMyY0VvbjFHRFlGL1RFZTNi?=
 =?utf-8?B?VkgwdjRQTXBGRXErSG1vTVRseUlsVkxuUENOcThOOVc3UFVraXZkdEYySEFN?=
 =?utf-8?B?RlZkVEdrbko4YXNHS2MzeWt5RTFuMEFaK3I5WFZOZ0tqVC8yZDNZYUcvQ0dX?=
 =?utf-8?B?OHNmU2hYQ0Q2RURpc1I1cGRJME1FcTBUSTBtUFdCMGdlMlJZNTNvNHBVZGJr?=
 =?utf-8?B?Yk1ybkFtNzBOdTZDK2hud1VhK3p2VVdYRCswS3haeGJydWpjS1JrM0E5MVNT?=
 =?utf-8?B?d1hLcHJWQnBKdGsyMjYwc3NyZEVJWEdTcWRNUXI3TEpOWHRGcG1IdGdBVU45?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9f8d70-79df-4ae9-774b-08dd4ad26251
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:29:21.0851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n0kDy6g7pu+wzcgfoAkGGXO/aSOVqph0PWCiXmQbFRfF+VHkqafkzKsJgChnP4C0Pg5WuZMQD5zhiIGZNp6TUs+wUxhBSjxBYjw5EVRGaQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6893
X-OriginatorOrg: intel.com

Hi James,

On 2/11/25 10:37 AM, James Morse wrote:
> Hi Reinette,
> 
> On 10/02/2025 17:24, Reinette Chatre wrote:
>> I'd like to check in on what you said in [1]. It sounded as though you were
>> planning to look at the assignable counter work from an Arm/MPAM
>> perspective but that work has since progressed (now at V11 [2]) without 
>> input from Arm/MPAM perspective. As I understand assignable counters may benefit
>> MPAM and looking close to settled but it is difficult to gain confidence
>> in an interface that may (may not?) be used for MPAM without any feedback
>> from Arm/MPAM. I am trying to prevent future issues when/if MPAM needs to use
>> this new interface and find it confusing that there does not seem to be
>> any input from MPAM side. What am I missing?
> 
> Shortly after that some 'new' Spectre issue turned up - unfortunately those rapidly
> consume all the time available, and predicting them is, er, the nature of the problem.

I understand how these things go. At the same time the new version you sent hinted to
me that you were able to come up for air to give some attention to resctrl upstream and
I grasped the opportunity to get your input on this item that moved along while you were
busy elsewhere.  

> 
> This is still on my todo list, I think Dave is planning to look through the ABMC series
> too. I had previously sent some comments, (words to the effect "works for me"), and shared
> a branch with the MPAM tree rebased on top.

To me the primary concern is the new resctrl files introduced by this work. To get an idea
of the work and the new files you need only consider Babu's detailed cover letter. These files
have changed since your previous comments so a fresh "works for me" will be appreciated.

> 
> I'm part way though rebasing the MPAM tree on top of Babu's latest version, and still hope
> to give some feedback based on testing it...

We tried to separate the arch and fs code logically but I am sure that it can be improved once
another architecture actually tries to use it. To me these internals seem a problem that
can be solved after merge of the assignable counter work, but addressing issues with the new
resctrl fs user interface after merge will be hard.

Reinette

