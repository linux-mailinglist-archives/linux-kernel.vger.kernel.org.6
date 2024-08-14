Return-Path: <linux-kernel+bounces-285824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CB795133C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 05:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7D11C225D6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558373F9D2;
	Wed, 14 Aug 2024 03:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WfGZQq38"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E44B64C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723607633; cv=fail; b=gWa/Y582eC3r+XwgxgaNnz+j5q1sR83KYMO58WCvPV+luQjrDkTBmlc9V8H+mEMmGfjJh2R3cqNoYuLJ3PXDApCRCggwDWIvuOcW939s6zUKNWTONsHnpdxPh5jREld1QnDUmRwQHA9bKHZpG7f+BuJ9vfKgld3GzWlVNMq0reM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723607633; c=relaxed/simple;
	bh=ns/V+2Kzq4Lx/EeXTBF8Tbl0biwiU0GY4UuYJYXr7oA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PDMf8NtO94OBPpIzf3VB3zxjLH0bcfPgN7MowiL8Naw97TX6ZQM5r8J6NRxEux4AASB21G+LXZ/NAMQyXJvGQTkl641Ee78DTG6TKOotCMu8J9Q5cq1qNZZ+rP1fepHyeFM+jtb+duMi2V27Ya5/IwAsy0XQBjPuE/z/4qACGrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WfGZQq38; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723607631; x=1755143631;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ns/V+2Kzq4Lx/EeXTBF8Tbl0biwiU0GY4UuYJYXr7oA=;
  b=WfGZQq38/89KyObbjxwX1dhLW3q9jTUwqFd1G7sgKX7vEm9sWOs9pcnB
   AvkSqyP+E7shHdZ2f4mEdQH0H8ePsNhqdKjZQSmMwz522+5y5JKOIyyvH
   FN9DTsbg6B5G7zTXJTHFGuzhAbHXoTqq0msyFXIXj7E8cQrp1ux+ofH4N
   IWd0UB8fVFvWdaxc2fywYUwUxAZH9zLq3rUSAc1xJBIjkzILhBHGzi6us
   oehDck+Qq/t3Nj3HC44Lzmv6LGJuxR6tRQiAwdOB7JyZSO3ZoIWFEYeeo
   Owt6QJzzG6okHgdcOf5YV/g999HL25XPQBlnCrn7WLqZ788pmz5niwmoW
   Q==;
X-CSE-ConnectionGUID: 2yVVtaXSRiyCVVLU7aFxzQ==
X-CSE-MsgGUID: iHE113wMSYigjsXqzy7aFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="32481214"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="32481214"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 20:53:50 -0700
X-CSE-ConnectionGUID: oDSHWRE+S4eV5ugkuLCiXw==
X-CSE-MsgGUID: Dt6HLutHSiCcNXwm01Ia3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="58813337"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 20:53:50 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 20:53:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 20:53:50 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 20:53:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gcz7yOBQKDb3WkNqwL7gghKMLIHqt9mrEHdz5f2gaP1HoRtGYRNo5PDeAycqeI4B7OWfohdBMoZcuMkKzK9M2ipF7ROaw+Qp6VGzaTtJHEPx57aYd9lTRp6+wygutidFd/YnX0pG8BdORHXkNK/nV8DIbBY/uVqipjnGDK5p5ib87cMmDsQ8lITlINuAncKGnOdT7MuvhxLEZZTXc8BgyKNSpIMQc+Qona2CCrge9rTdDClj9wAQjfJ+ZNY4lkj83vfbA+OfVfgg8N1FgIbO30rTnAk6RroDrV/4VZK/e7ZSHdw/QapwckNr9wN9FFb/tGn5x/Pg2YiK/POSkiSWXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckMD715fmspSvrRhcUTmUQ/OhFzg/8qbD6vSehQKkpg=;
 b=wgAm1JGGhKOYEe6w2/O8IzUjmaLukcFoavalz08To5ch7RojtkXn9dVKJpDCXwD81ZQW5F4bWSWueg8Av/5eSTCRB736FivQngYpBhiNK8FHpIa+4nwFBjCw4WT8noeMqvUsYYBNQfuYRL9XnQmxuHFrTkP6+Xmw2d82114NXQV0eruDu1nfeHHjOp2+44C3CkiyTTRbg+xt1xQi5VADDazkJMPmULgDmOg+EdQnBopd9MKI5G4sReBYDKpos684Z/ntLdgFolpuuMo6g7tcuTb9K0C+XAJ2RxcdWnbLv/enu08X5JmczmfuGOKYKozIZX8soU8pu5+WnxCCmilI7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Wed, 14 Aug
 2024 03:53:47 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7828.023; Wed, 14 Aug 2024
 03:53:47 +0000
Message-ID: <703898e4-fa50-4950-bf65-68893d4aebc3@intel.com>
Date: Tue, 13 Aug 2024 20:53:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/39] x86/resctrl: Remove fflags from struct
 rdt_resource
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>
References: <20240802172853.22529-1-james.morse@arm.com>
 <20240802172853.22529-4-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240802172853.22529-4-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0176.namprd03.prod.outlook.com
 (2603:10b6:303:8d::31) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB6020:EE_
X-MS-Office365-Filtering-Correlation-Id: f9566c8a-c13a-47af-14d2-08dcbc14b32a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHlEYUZ4b0Z4WWtkYWxwV3ZXZ3NjOFZOZVdKMGFGcHBXdC9VQjFEc1ZMRXVy?=
 =?utf-8?B?UFRIeWNsTE5ZNy96ZVFQVWlVemJqOEUzcHprY2ROVGVnQUJTckZteU1FblJJ?=
 =?utf-8?B?amFuSEZXTk8xRG9aNXVhVzhFdFdlY01aU3RWZkFXTG9xMTJsekd4NjFaeUl3?=
 =?utf-8?B?b2pKT2dNVTUzMnpNQlVDUk1GYVVPUGFRYURXbkQyNmlNcnlDeTN1MDNkTi85?=
 =?utf-8?B?Mi9PYzkzNGdPaS85alBWcnVpZFFaZ2FJTWordUtoZ1F6dWo5bngvY2hhbjlu?=
 =?utf-8?B?bUVVZzkxdWV3S0RxSXhQTTRaK1kxcENJOEJDNXNPZWxDZVZqcmdZKzNwVGVa?=
 =?utf-8?B?UFZ3enhtN1kvWVR4Nk52NU1kMk1MemhNc3EvYjBDQlAydTBuS3Byc0JPcFBW?=
 =?utf-8?B?cmVaZzZoK05jWEEveUdqRGFTcS9hTG5XVE5XeEhFQ01MK3orNm9GeU9VU1R4?=
 =?utf-8?B?WVJLR0hlblB5cm1WcW5BOE51UENzTCtnRmdneklVYkZKeWRMci9BRU80VnlY?=
 =?utf-8?B?MTR6VHY2c2VWaUF1aGUyQnJSbmRIWUF4Szlka3pwVzdLbG4wZFVSOE1tWlVH?=
 =?utf-8?B?UnNLeXdUWXRza1QwcE4rdndRTWhJRDRzTHEwblBZbnY3NmlNQkVpU3hpb1lV?=
 =?utf-8?B?aFVmekJGMDg2blBjd0Q4NDFxTzVwdVV5MVNJN3lTd1VuRmtHVVhhNTFtZ0xq?=
 =?utf-8?B?ell1bDN3N1o4d045ZXorb3hld3d2OHFHbVVGUUxDTm42ckxDQ3E0VnFqbXpL?=
 =?utf-8?B?M3MwOVk0RWIvZXpod0tzZDFzaWFOZTl6bGRhL0VuMmVnZ0ZhSlFEWHpLQkVP?=
 =?utf-8?B?L0dVY0VEWlVhdms5NXllRWxsVzNhMXNIUnBTbkVXSnVVUmlqYUpaN1pJK1Yw?=
 =?utf-8?B?UWFGcGVjOURiL0cvM1BkaGZyTnphcE9zNTBvQk50YnpjUnZFMTEyeXZYVTl0?=
 =?utf-8?B?VlJpd1ZCRGFHdnRaVGNVeVN0NjdYVFFXaWNIZGUvdnNjQy9xaC9nOXZIUVpx?=
 =?utf-8?B?MEhCWExSTytQTWdXNUhzZDc2V2NhdVdTa21HeGVjbGJaMUtHck40US9Oa2Vm?=
 =?utf-8?B?OWRMS2xiMnhnMmk5emllMjBpRzRTNDdaT25ZUkRkZk85M0prZ040V1pkc3lp?=
 =?utf-8?B?eGJXOGVwZnB2QlJvRURxc096aU4wVGZkY01oT2t4TFIvUkdMQ2hOMGFKL1Av?=
 =?utf-8?B?REJCRXZxNGNuQ21nWktyeEhZZDA2WFExKzVxMHlWT3laelY5RlRkTnNsRkRu?=
 =?utf-8?B?cE54R0w2dzNRWk9wRDFuUWRkZXE3cjcwcUZBS09rS1dLMzVOakoyRHdZSlhp?=
 =?utf-8?B?Wmw0WitHUlVVZUkwUmY4WjVJeERzOWpXSnRSbk5VZmtUMG96VytLRlNDdmcz?=
 =?utf-8?B?Q3Y1V01EZlRpQUZPc1cwYnI2Zk9Ud0JKR1RSTk9JUG1ORlQ4ZlhONitLZzJN?=
 =?utf-8?B?KzlHWUhIYlovOHZpbkppc2xiMWVtRWcrZjhHNWlrMXdQYzQ5M3F5S0RGNXVv?=
 =?utf-8?B?ZmFXVHJDMGlzYlU3WS9PdFQ1bEI2U0dnaDBjUEZIdnd4TVNLVVUzT05YTW8w?=
 =?utf-8?B?UHBlZnVyMlZlcTFEUHFmWWxtQkp1WG9IYnhFbmVHa21sNzIrNHBmZ2JVdkFX?=
 =?utf-8?B?NmlMckVVcm1lTmpzVTZNNkRwTUIzemJ2aVd5UVh4R1VpQzUzVGsyQjkrbkt1?=
 =?utf-8?B?dDVtRzdrb2FSR1NCQUtxNkx3SmhiUUN0VDRWMXlkUm03YWFQQW9RckRZcE1y?=
 =?utf-8?B?UVJxWC9zQlZobVRsaGZhVi9RaDFKK0VTWTFOdjl1Y2hVejZYSWNvemZnNTVI?=
 =?utf-8?B?UkI5bkNScUxROU9OQUJsUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlhEOEtBOERjTE9COG1KZ2xWQWtZSjVGWVFlazcxS1ZhMmUzZmNWSEI0Nzdi?=
 =?utf-8?B?VEVtZnZvY2hmSlNPYXdFdEp1SnZrWFp4emtxMlZ4Vk10UCs0WEI2VDBQREMv?=
 =?utf-8?B?MFVWVjFyWU40bWNnWFNheWhWVHlXN05GZkQ2Z21WSW5IRm5jbWtIcGFUUTRK?=
 =?utf-8?B?ZUt0Z3dBSncxU1pOWGEzQXpzalhzelNiakk1N2QyOWk2VmNaSUxtSXVBL2hZ?=
 =?utf-8?B?cFU3eDlTUnNOYUpiaTd2aHBaYURZYkhpZmRVZXovUzR6eWIvUExUY0c1cDll?=
 =?utf-8?B?UEpWK3lLS2VTRWp4MGUwbGdiZFdxYjlyMVZ4V3J5M05Nb1QyQ2UzaWhVNzVD?=
 =?utf-8?B?RlUvVVdHUUtDcVhDLzV2RXhXeDRGN2RYSDM4Q204MDg5V3dIOHJHTHlNcU9T?=
 =?utf-8?B?VFgvdGZDR096NnNIeWVhbVRFMU55NEVLSFlieEVMYVVONmZmVFpEUEdvMG91?=
 =?utf-8?B?Unp1Zk9nOE8yVUFnbHZZeHlReEV3OWd6V1h6aDg2a2Z0WFVnUklERldwMHJx?=
 =?utf-8?B?YmNTc2tCM1FWN1lHTnpHWm5YUS9MTHUrY0VqMkxJeStmbEpRUjk5OUh1RXI3?=
 =?utf-8?B?M2Fhd3ZMK2N0THNjWXlXQlI4dUNPaHFmQ0VacnR1eG10TU82M0hkSG9SN0cz?=
 =?utf-8?B?S0Z1cDgwc0N5bEF1MzQ3ZGhQMkhKWEtMMTF5emo0OTljbEkwVHNLTGhHQ2Qz?=
 =?utf-8?B?dnNEVXBhelgyTDJTQlZLNEJLTlR2VFplamNYS0E4M3h1elRTeWIzbGRiYkFY?=
 =?utf-8?B?Q0xOUndEaklYbURsVCtnUGlVOS8xVDh2WTJJZnZiRUc0NlhiL25JWmxRc1BP?=
 =?utf-8?B?K2NJd08vbWJ0ekRSeW9HbDNaU0VPK3pNVzNQbVIybGhDZEdCK0hmUUtRNkRr?=
 =?utf-8?B?emhHcmVGY1ZuUG9UN2FiR1FJbDdGb2h0RFQ1cmh5cllLcjh1dmN6dzIrOEM0?=
 =?utf-8?B?cVVhNGtnb3hlRXlrcFA4Q001cE0raU1YZXlnWXhJWnhGd1J5R0ZmSG9CN2NS?=
 =?utf-8?B?eG5ibGNabjFYZHVQRTFpNDBwOVZCbldYc3ptZ0dWcHhlZkp6YnVJaHRjaU5z?=
 =?utf-8?B?akRkUTR5a1EwZ00ycDFwM25XeVlaTHpSNHZrYkVEVnk5MHFKM1JndlRGZlFj?=
 =?utf-8?B?azNYbHNRZHRlRmpMUU4rUzg3QVlyQXhJWHVsVE93YmRybzBsdGZzMkNKSnp6?=
 =?utf-8?B?SlMzdnB6WVEvNUhWazVJSy8zYnJqNURwNU9TWEo0K2hNUTFjdEtqczRGNEha?=
 =?utf-8?B?WFgrSU9vbVBlL2JUYVhiMDg0bWZzQzA2amROSm9uL0krQWZCT0FpSEIxTmF2?=
 =?utf-8?B?WGlZZFZzRE1zY3d0MkJxOTBDb1A0Ymo1OTQrTFVDeTI4YzNBcXhkRGVYWnVz?=
 =?utf-8?B?d2tzSU5wdTVnZHRaVVBySWxscGwrYnBUVEhLRmxVM0pMdjQ2bkI5bllrckd0?=
 =?utf-8?B?UlB5VExjV0VQRzUyZjdka0hnZSsyQ2Y3U3dLU1ByTEFnVkVOZ1poQnFpZnZ4?=
 =?utf-8?B?Z05XbWUzMEl2bjNidWdYOVRqZjM1WTlsRitLY3BJOElRWEE3TnVVLzVCTzU5?=
 =?utf-8?B?QjRteVYxbGVtWkQ3eFJNUUdFZUNkMm1UZjBoc3JmeHVHemhEeWFRZWlRajFr?=
 =?utf-8?B?aitVSSsycEU0cStYZUtJRXVRR3k1b0dFczRpRWlJSGY5UFoxV01rLzEwR2Rz?=
 =?utf-8?B?WkpXSGdRVXZ2ZVNmVkZYQUlOeHJzWEtIRFp5OXRqcU9uNENjb20vVHozOE5l?=
 =?utf-8?B?ZUlhWHRSRlhwL1dsNWJOYjVDMmlXUkRqME1aYmw2L01SV1BCcFhWaTQzQ0d0?=
 =?utf-8?B?M2t3b0JEOFNVRXNZenNRUTVqRS8xT0xuV1RDa3BlN3BmYmUyRk1lUzNWVUxx?=
 =?utf-8?B?VEQyS3pDQkhrNVBYb2F3c2MvcW5yZExOYlRkdmRDeXlxWDQ3ZGYyWXJSb1lL?=
 =?utf-8?B?M1pIcnhNNHpFZnBZZmFXd3UrcW9zTkc4YitpVnEvc3NBM3ZzamxCMWZRUXpq?=
 =?utf-8?B?YlZSejhGNTcwRXFFbU0rd0JYdmxHamRyQUxhWXN1S01iN29MOWo4NCtBaDNF?=
 =?utf-8?B?NllnaFFoSVpEdCt2eERCc0dJM2svNko2SmlRV1lwcGRiSG1ZbnZ2ODF2MXJu?=
 =?utf-8?B?NS9FREUwdWhibFNHbkJURFl0NVRUZEdpU0N1RGtUeHk5eW1KVlVZY0ZIWlNw?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f9566c8a-c13a-47af-14d2-08dcbc14b32a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 03:53:47.1990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKuyYC0W5dx18xF09mpq4kD0FSjlOPU+aDg853Y7IpbBd3pv0xpbbMasXjOSIRTdtp57eDGBFZI05QiIC/093B49VXMifej5l3mi300sRoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6020
X-OriginatorOrg: intel.com

Hi James,

On 8/2/24 10:28 AM, James Morse wrote:
> The resctrl arch code specifies whether a resource controls a cache or
> memory using the fflags field. This field is then used by resctrl to
> determine which files should be exopsed in the filesystem.

exopsed -> exposed

> 
> Allowing the architecture to pick this value means the RFTYPE_
> flags have to be in a shared header, and allows an architecture
> to create a combination that resctrl does not support.
> 
> Remove the fflags field, and pick the value based on the resource
> id.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---

...

> @@ -2180,14 +2194,14 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
>   	/* loop over enabled controls, these are all alloc_capable */
>   	list_for_each_entry(s, &resctrl_schema_all, list) {
>   		r = s->res;
> -		fflags = r->fflags | RFTYPE_CTRL_INFO;
> +		fflags =  fflags_from_resource(r) | RFTYPE_CTRL_INFO;
>   		ret = rdtgroup_mkdir_info_resdir(s, s->name, fflags);
>   		if (ret)
>   			goto out_destroy;
>   	}
>   
>   	for_each_mon_capable_rdt_resource(r) {
> -		fflags = r->fflags | RFTYPE_MON_INFO;
> +		fflags =  fflags_from_resource(r) | RFTYPE_MON_INFO;
>   		sprintf(name, "%s_MON", r->name);
>   		ret = rdtgroup_mkdir_info_resdir(r, name, fflags);
>   		if (ret)

Please squash the change in next patch that removes the extra spaces here.

Reinette

