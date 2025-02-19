Return-Path: <linux-kernel+bounces-522669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82375A3CD17
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50E4A3B72E9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B6D25C704;
	Wed, 19 Feb 2025 23:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X5m2b1zY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BCA2144C8
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 23:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740006610; cv=fail; b=rfcsm2EAH392jGIbX8dLOlsRglhlNKwle04jMo7Etq0sqBT2or2woXM04h8T3MzMJTJl4p+ReTWr/aOXYJnOfRlVoyoV28GVsZvfVyRMiu8MkL7wbb7Qz2+MOj856PKAmSZO1VCBc/CgXkaLXWwYYBXee9owuatQOLedXLQwjvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740006610; c=relaxed/simple;
	bh=6R4LbKJz5eqWneLipu83OhU0h0w8YUGQewbrHor4gWw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FHiUjIfGczuZs9MKbTrt6Cbt8bhQZdmSuOvYuAQ2WWEYQ37cSwVvT1WZ6hafeL1yUCuqSM2QT2DCtExTuM8V+/qRYMj/nsSb0iQDr+mcpTC+dnm0Oq8R1AL6/KGkXd1ET67xBT2wVchlSawMLOP802W68UhpAZyjGP5bXTVWAKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X5m2b1zY; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740006609; x=1771542609;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6R4LbKJz5eqWneLipu83OhU0h0w8YUGQewbrHor4gWw=;
  b=X5m2b1zY9JYVvab+e7IaE1H9o3XRQiZDYUa7ek46aYEeUbM3VCGopCiD
   XL6sf+GX3i6p0LubjCuM8dYMGC+s8IaJU1Z6jGwZfIo8WFWMmi8Vx2tXT
   wY9SnHTfN4rDtjJUVjprDhvEwzTRB5AF0OfSe01ALw7PE2MDYRRCeEUwd
   lIi6nZpy0Nw2ByI/Noudvq3uDsrLZ4AQA/KpXTWjV3EeawbpmwqDBKEcO
   /1S7p1Pv1bxBd8pTNB5ASa+vmgABKOp5un2XjhcrCDSZm8SEyOjsAStA9
   6PjhH5rM1ZjksPbi0LV+koBioIrN8jpLb5xzD5+6Qy4X10kCc3ju/fXSL
   Q==;
X-CSE-ConnectionGUID: 3mNhU+xKSMW+T2W/RGR5/A==
X-CSE-MsgGUID: Fssjef+6QTWd18R3QxBmtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="39954273"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="39954273"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 15:10:08 -0800
X-CSE-ConnectionGUID: q1RU1GnVT3uii5r2ASEthw==
X-CSE-MsgGUID: ZWb/sdKCSdy1RxkacL4oig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="138059081"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 15:10:08 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 15:10:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 15:10:07 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 15:10:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zi/gutHqyn9xdSK0JJSRLVArDOe+slT0scvtuWuwrUEBGBumjqNeDXhj+CCYMVIXJuFHwBxAmA0bB6i/az8MMcoMctQzrj+374VE5nE3I1ZTC8xvkqJuZoBsYMWavUdJnuxxsaTWJsLdLKbCqmlUTuspAqvH5kDO7ip8iAEDqkoJo5fZxmt5AagR55XTaTYV0sN0i5aTCPYObXPTQZRewfr+pVqOzXbqbaltMoJ1Um7q7HRbI3vIj0y/SbZgeM091UEOsf0hNnyu1PwASjbFGnPpeIYacY25XqI8jEJVek7b6oaDkRcvp/XejGXlShZeP4xTX33ySUd1KsKwTry7Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4dJ/F8uPWaGnY+AEZ+XM5fRqGF7Bda37qZ5Du+ojPI=;
 b=hx5iqjDw5kzVL2Qo6CjlGUW5sDs2ts/Xyz47S4MVt0BFoBzTI5kqZ+1PAH+CKkajGSeURIiTW7CELtkRwOvyQ+3TsbsyUPODeEhdvYQONqpW1ZkTaO/Q+7nAgE0gc99I1OWoZtGGrkqNCZZ1hShqYgVs5vri02eNdNDexRtgR2evokUL10ixsPatwxK1evlKTadJF5sxKt8nFyzrJXYvWJz8YNL4ck8cApG0kAuVu4uDjKVRVNdaaG0PFBfeSxXQEUvNr2C3nkBXFhfzjFesrp89xbqBOWRadCKQxSPBnFVJqPb53s9wdwT24ij0ZwS3JgCatlQ0xKArYet2vKVSNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6674.namprd11.prod.outlook.com (2603:10b6:510:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 23:10:00 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 23:10:00 +0000
Message-ID: <108eaf29-495f-4f73-ba31-928ce2d75192@intel.com>
Date: Wed, 19 Feb 2025 15:09:56 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/42] x86/resctrl: Add helper for setting CPU default
 properties
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
 Donthineni <sdonthineni@nvidia.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, "Tony Luck" <tony.luck@intel.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-10-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250207181823.6378-10-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0231.namprd03.prod.outlook.com
 (2603:10b6:303:b9::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: cb95a106-e583-45d7-1c98-08dd513a88b4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmFLYno0dFJEdFRsRkM4SGFrZXAwL085cGN1Q2ZZNitjNlVQN0kzdTczTjN3?=
 =?utf-8?B?elAwY3o3Y3FRNFQ0d0dBdi9QdUlsSHh2Qm9JbmlVbUxDay9wWElWYkpkdzVo?=
 =?utf-8?B?ekFqUXlZRUlGZnptMk04R0NubFJSNzVtdmowNmhycEhsdnFXLzNkRVpTK3pH?=
 =?utf-8?B?ZW9sTUZOUGh0RVU0dXduVGRFR05oNlRNSWtDR2g0aUJRY2lLYXkrcDBrd2Rr?=
 =?utf-8?B?N3RhZktOdE5ZN2JzY1RWcmFMRXZvMFVwZkt3K08zc0pFL0FGaEpVVEVWOXd2?=
 =?utf-8?B?YXJGZXoxODJJd1B6Y0FUNXBzc0R2L2VORDJEdkFmS1I1ajlOcWNBTTZmdEpY?=
 =?utf-8?B?aE9wZFBVRUlSOW1uUU8xSFBnL29ReFdrenlvaXE5NWw4NGhUMFNkZFVBaFU0?=
 =?utf-8?B?NzhzMkx4dFJPcFM5N0FhN2toazF6bGd6SmpaNlg5Ti80R1R2bS9vTWxKMnRD?=
 =?utf-8?B?bGlVeHQwOTFOZWlmTlRGQ0trZXkyUi9JNnFadlNLcUhRbXNORFB2NTZHMk1y?=
 =?utf-8?B?S0FjQ21CT05uZVlIaUJrMkY5WHRpaUJjSlV6blhSZmUzbkdQUVB1SjNjblhn?=
 =?utf-8?B?dFhTb1RoTEoraXE2RkpQT2dqZk5lN09nSHRXc1J6OXF5YXRQSExoZm1LYWJP?=
 =?utf-8?B?NVgrMTNRUU92SGxqVVJnTzdZLzVlTzhYQTA0NnZJUDFtNTFFbStPLzZ5MzBz?=
 =?utf-8?B?dnFwbDhtQWNrcjNKMlpFS3FjOEdubkkwckJMYWxYUmRUbkgwczB6Sll0Z2RR?=
 =?utf-8?B?d1NNN2FhcUVya2hySHV5a1hqa1ExcXg0ZzNlaDdBdC93TE9SWnRPaXB5cUJG?=
 =?utf-8?B?Z2hPTmpxbWIxenRIZlR6RVdOQkhqckYyaVpmWG1RcTMxc2paelhyd0tQWTZQ?=
 =?utf-8?B?MGhuQUVBVTB6NUREckZ0WFpsYXFpZXdOcCtkNVpuemNqdG5pb2dQK2orZnlh?=
 =?utf-8?B?eUFoTG1jb1RSZXZZZEJLcWdUeXRSZGxqRHJ4L0RWVThkWU54Tkd4c2lnUExH?=
 =?utf-8?B?dG5lcFhhR0gwUVR4NlR6QW9TdCsxU0dvYnRlVERiZDJ0MzBWQVE0KzNGY01P?=
 =?utf-8?B?U09xQVlpKzJ2Ti8rYUJveHB2NUVLQzFydlpXdnh6R0JVYXo1WEczcjAvVnVy?=
 =?utf-8?B?ZGtmOUUrWHMrUVFHUWFycWUzWFZGa3FXZmo2Nk9TcWtGZFJrL2FlRk1vd0l4?=
 =?utf-8?B?UmlHUjY3OWpWckpIdzNJVEVrN1ZtaEVveXl3M2VvUWdLeXpTUmsvWXArcERF?=
 =?utf-8?B?NjNXenpVTExIR2NzcWFrb3Q0UVRBMklZTmpkTlVsMlYyeGpNRTVyd2dOWGhG?=
 =?utf-8?B?VllHNXg2UXU2VDBxeGVVTE5sM2VnSzg1dElMM0pkMVhzVlI0d01wby9ta0JZ?=
 =?utf-8?B?ZzYxMkxkazBPbzZ5NTF6aE1uQ2R3UVVFY1U3VW9sQm1hN29kaEQ2MnhUWndR?=
 =?utf-8?B?clkvYU4wYTVpYWxUcmFzS3RmTnVsR1Avdm90YnZaUUZ5K3I3UEsrci8xRlk2?=
 =?utf-8?B?Zlp0YkdqaW8ydnJTUDZoUWEwL2NhQXpPQkVnT2ZpaVJ5MDAwZ21TQ2RadHEy?=
 =?utf-8?B?NXhuY1ZZcVozVEUyYTU4NEw4NkRJVXQwYkJ5TUp6VFFFbExUVlh5c1ZSenhh?=
 =?utf-8?B?UjBMU1duQmkrYm13UVBJbDZqVEt5ckJkT0lJZUpudWFOYTcxdzdhVXhSODA1?=
 =?utf-8?B?R0ZMbWpveTZBaVp3cVZ2dEN5S0prT1RLTXZDZE44RTd4Y095Q2NEOHo0Y0dn?=
 =?utf-8?B?MHVOT2ZrYWF2cGRzY1Q4Y0pGb2czNiswSGNVV3NkNjZ6Ni9URHBRR1RUNWY3?=
 =?utf-8?B?SjlwQVZBelgrcm1HMWFPQU9XeFFvaXFnbVFmRk9UVmNsQ2M3OWZMWkQrcFRi?=
 =?utf-8?Q?KTpFgUxBdCLs9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekJXVnFNemp3UHF6UnhQbjdPQmZvYkVDUFdOOTYzY1dMUThpd3ltTFlRNFh4?=
 =?utf-8?B?ZGM0OFhIUmlPaWlsQnRBeS9yMUZtZHRoTDJpcVdTVHRxWlpnUy85ZWVMV3Zs?=
 =?utf-8?B?L0c5d0RZODRFM1pqWkxrMXl0WGtGSWtON1BZbE5LTDhwMDUva08zNmJLQUFM?=
 =?utf-8?B?c2Y3b2c5T1N2M0hYemJsTWllN1MwUmQwQzdmbGhWZGhJekpGS2NTYWNsWGJ3?=
 =?utf-8?B?MjN2M2EvZFljdDdyc1A1aXphdm5zUmZvaWNUR21MSEt5ZFlTMWZrOFRJb1I5?=
 =?utf-8?B?QWJidXpMN0d2K0VkczQwbTU4WmFZRkg1c0MzdDI2VVpSYVAxRXJNWG5iL0tB?=
 =?utf-8?B?dXR5MlNGMWJLUFBjVVFIN3IxVTVVamROYlEwVFVkV3c4VGd1NSsrd1lSS00w?=
 =?utf-8?B?em4vSFd4MTNZLzRwRGQ1Zk55bDhlUDBoanFQeTZmZnpWL0hlcllWVFBEVnB4?=
 =?utf-8?B?MHY3RmJzMDdGcEI4WTk3Q1c2eWpWcHhyUmF6RFRJK2NJdks5NW9MSk1xMU1k?=
 =?utf-8?B?QnlXY2l5TkNac1Fwb05pdzh1UmtIM3FLOU0zUFVBZXErbklFdkwxb1R6Z25V?=
 =?utf-8?B?L3IzZHZ5VTYyeU81a3pOVGd0b3RnRU83RnhZUHM5clZlVnZNSXVGL2Y1d0d3?=
 =?utf-8?B?M1dUeGZrL2pZZ1pINDAyMWI4aWlJam9OQTY4cG05a2xhLythWFJ6STJXV2wz?=
 =?utf-8?B?cGtmNnNLOC9NM2dkT2owMG9obDRxWWFkNHJMWWJlQTVpT2x1YWFMdWtjeUNK?=
 =?utf-8?B?SU9rQXoyRGRzQVlpZ1FVeEdPUDY2aWhDT1Arbm9abFY5MU1YTVBjbHQ3RGlj?=
 =?utf-8?B?cVhHQmtGeHVsbCt6RjdsaENoTGFwSjB6aTg1OTQ2NzdwQkEzOU9xOVRSNTcv?=
 =?utf-8?B?bHVoaXBGRXVzWm8zM3RjVlRhZDhhVUk2UG56bUJSdDhzelNCMjlXOUdiVjFw?=
 =?utf-8?B?RGhsNVJESUN1ZjhIWXFRQS9rRUNoR3lobWYvRmUzeVd4dXI4SjQzdjF5cjR0?=
 =?utf-8?B?bWZYT0dBZGdpcTBFZmN2OVhSRUdWWkdjSmw3dUpLdE1UNnRCdC9uQkxYTFBC?=
 =?utf-8?B?dS82dkVRc3NXRW92NStKSktlNStaT3NjK2QvYktYM2Z5QW9hdlA4SHJsMjZy?=
 =?utf-8?B?cytkb0xLNjZIVzFsLzFLUUpMWVlBWXZmK1R2MUR1eVg0N0diRmk0M3Y3OVRU?=
 =?utf-8?B?NXFhYU9mS0htcG4zdHg1YUMrbHZ0WDNUaW1UOWEzMHh5L0tzWjNXM2RaNkhn?=
 =?utf-8?B?YTVxaThVRXpPL0x6ZGxTT0RBZUdtY1ByR3BlMEpmb1Y5YllrS3BQc29qMFN1?=
 =?utf-8?B?cmV3WDB2VTA1Qzc3SDBhTWZIVUljRkIvaEtUZlVGV0lTczNXZyt5cU11bHh6?=
 =?utf-8?B?WXp2Y2FxQXFLdHhtSGdCMXlCbHBBY3BjZ21rd1o0dGZZQ1FEYkxGN3BQZjBQ?=
 =?utf-8?B?MjU0UGg2d2ZtSm5wWWtMNjh1SDhzNnF0TzVZSEhIeGIwMkkxOXR1ZVYydFI1?=
 =?utf-8?B?VHpla2ptajhndm5jYnNXYkl4U3VJckxGNUZNaVB3U0NkT0pIL09kWkVyY1FF?=
 =?utf-8?B?cjg0cEtqS0Y1emRoSS9scHYvbDJsWXRPTUNlS2hKajR5UU5Ic1BmNGIrR20x?=
 =?utf-8?B?T1Yxc2FqbjhPSTZ6L3JzK2ZpMFF1UFlPaVVRWGtQUzZ4Wkw0YXVnOXlGMVUx?=
 =?utf-8?B?RmwvMlIwQTJzWTB4MWkrMWs2eFlIcEJQclhUbFpFOGxScjgxOEZCakRUelMr?=
 =?utf-8?B?cWprZ1RaUnFGMU4waTJuUlYxNlhrM1QwQU1sSDNydkwyM01zcVcxeWpwL1Zo?=
 =?utf-8?B?MzVRN1BseW9KUkZBT0RUVk9GTkFtaXVPL2U5TzRyV3F4ckM2anFQM1VMenJj?=
 =?utf-8?B?anpJWkhXMDB2K0lsN2F1OUdKMmtWOVFMcExRNDlqdHRJOWZ1TDNhb1ZEWUJ0?=
 =?utf-8?B?RFFsTTdVaU9qY3Q4bVp5MnNOSlZjTWxjaHJqaGpQV21hT0UxZDhTem52ZjVz?=
 =?utf-8?B?cTNDQS80Yi9iWHhLVm1iT1QxYmFHcWZ0MUlZUk1zM1FJa29sWmhWT2pLUGdM?=
 =?utf-8?B?K0Z6U1pQdUU1VVRPc2NTY21xMUIrRHI2Q0RoaXNBVjdtYWR3K2g1L3NtZjBH?=
 =?utf-8?B?Rk0vV0hqRWdiZncxY2R4QWF0N0VCakZlbWU3VDBKcXJNTXVUUFkrUmdTRHhx?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb95a106-e583-45d7-1c98-08dd513a88b4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 23:10:00.1532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76df3+jenukBnM5nlZhznb0XvK28lWO7+ENuGAFbB/7ZyrPyPhYnKzT3idFPawQ+OWb+4M+03shbs0t4Lyvlh9TIEbshT5DuLjkmy1mqxUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6674
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:17 AM, James Morse wrote:
> rdtgroup_rmdir_ctrl() and rdtgroup_rmdir_mon() set the per-CPU
> pqr_state for CPUs that were part of the rmdir()'d group.
> 
> Another architecture might not have a 'pqr_state', its hardware may
> need the values in a different format. MPAM's equivalent of RMID values
> are not unique, and always need the CLOSID to be provided too.
> 
> There is only one caller that modifies a single value,
> (rdtgroup_rmdir_mon()). MPAM always needs both CLOSID and RMID
> for the hardware value as these are written to the same system
> register.
> 
> As rdtgroup_rmdir_mon() has the CLOSID on hand, only provide a
> helper to set both values. These values are read by
> __resctrl_sched_in(), but may be written by a different CPU without
> any locking, add READ/WRTE_ONCE() to avoid torn values.
> 
> Co-developed-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


