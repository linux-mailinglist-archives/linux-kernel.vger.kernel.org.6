Return-Path: <linux-kernel+bounces-378862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C97299AD66E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAA7F1C20E03
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD3B1F8EFB;
	Wed, 23 Oct 2024 21:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lWSaDK32"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2B11EC01E
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 21:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729718068; cv=fail; b=pMc0h0eXXOBi/p4fIetXR2ZGdYuIDhmETzCYk5RWxDgK7g3Z0zdE+Maa7rDN88ickqsCkqbXDzcqk2Zo1RcR0krMuAZW0r1J0H4uSgKB5gqhLppp6smcD223c/2o6yjw2UY6OPDP+JjPVK+Rok573d6ZYasG4ij2iGzC6uMozuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729718068; c=relaxed/simple;
	bh=rELT9rhdnjy5ePjSzKIWDOF1x9KjCReA7MwmIN+Y73k=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iVkYGten902NUj/DziaQewRGxNYg4WBAsqF6ir82J+Aiq+AiYrFhpU3pLHPUM2AnZ4YyNVsNrULqcO3HoydbIz2jD0pSa9509K2FPz6uXQNuOw9oKReTsfeUv9C3XMpiXskLLc0T17J3ysKDyziVSJAbxTWWMJ1nsSmMpwIm960=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lWSaDK32; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729718065; x=1761254065;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rELT9rhdnjy5ePjSzKIWDOF1x9KjCReA7MwmIN+Y73k=;
  b=lWSaDK32ZRylUmQdpuhm8dkx07Ndj4PxA5Nql3zOtjSHtn5FAix0n3C9
   aBQJkunxCAxvNa9A79ljVaZT+zfWNcnemgZFkBUObVSY8N6HH4xdQ9IDE
   NEyKtDHu/t+SAmjsBYMTPO3AzNQHzruH7li4GBj6NEwh56YblanHLkTWT
   5mrT3LjJjKvSXnSBK27KUSWO03bqpnJAzFBG/Kg9sXoxRtsg64I/3HYk2
   +ZTzFooX+Sh1Dcziv28t3SMN2LoL411VEGSqI32YSa9JTEIk28rgj8Hrm
   Xp35DVBQu6ljMOxnRedBuwZxYJqKei2701jfyWkqE+A+PzT5aDUOPTMEe
   Q==;
X-CSE-ConnectionGUID: GKXIUOilRpybXd9/+aAnpw==
X-CSE-MsgGUID: vpMJVxx0RTycS8mP2oW0DQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="28767398"
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="28767398"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 14:14:24 -0700
X-CSE-ConnectionGUID: VKf3130xQTqizSzH3FPelw==
X-CSE-MsgGUID: 2Fs2Hxy4QAWAEu7ASF0TXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="80300540"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 14:14:21 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 14:14:20 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 14:14:20 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 14:14:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEs7lzKP6FSZdDY017Womyv5vLrzoRlnsXJJG39KRv5skrLyFYKSxSm8hdSTuhMqWioNO80yk7WRGRe7fGmVj3sbFPhURGRtey8FG5WovAubtuaY6zmXq7q05rY5ApaaHVateURSdrwNCyTgIAMaAyEB4jO311RkU9VzkOxzsnze33RQPjbO6z8ZrD85NfmKKhuhz5DY7zr8SVcWwTl2p4tm7k/kIHpOAwMg4ssjHDjNYjM9heHrUkPwbL4V9L2BWf1XyP5K+1dRSvT55gSQGQDLDBQGvNzARisH/wLVbVvyQydrn8K9k37q//hQYHX3oP9vGzbKpxk7PMnC1u4MYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OM6uEqJS1hSR82Vy/WHEJXqQ7St/PwJnzD33zDOJmY=;
 b=DCtLHdOCp7IOpLQ6K2HLC1+h71W5kDW4Anm0FHzl6NHEizdeZjolz35zor9j6ecGN9cUPgy2eaPnRdeqj4K9oLYJLFmrAwQwegLeXRkD/JjAooPeqq2KlcklW4dTajpW2QY0yy3cKADBJFSCDQ9b6xyRIT33BuRqTmaNz2i3fioVu6bBooVeiQNjWt2bssl59ApC4i5Uvu3kLSAlVq+CCBg8FC64Fut2nNePk3I96Y/CVAzuB4r9dD3PHDRFD3/vX5FqiK6nstYmi6k4RChKwTeL/t4plYsS5U+3BvXQbO0V9oiwSBKyeYw27T35kqE3/vfIOkeHZt/aWxGosEZjkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH8PR11MB6830.namprd11.prod.outlook.com (2603:10b6:510:22e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 21:14:14 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 21:14:14 +0000
Message-ID: <7f7db029-2e94-4cba-9019-70810ad43b48@intel.com>
Date: Wed, 23 Oct 2024 14:14:11 -0700
User-Agent: Mozilla Thunderbird
From: Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v5 04/40] x86/resctrl: Use schema type to determine how to
 parse schema values
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
	"Dave Martin" <dave.martin@arm.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>
References: <20241004180347.19985-1-james.morse@arm.com>
 <20241004180347.19985-5-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20241004180347.19985-5-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0308.namprd03.prod.outlook.com
 (2603:10b6:303:dd::13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH8PR11MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: bd67f7ce-02a6-4676-f6fc-08dcf3a7a555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVFRVGFtelJzb1FTSFBtenE2SVEvRjJtRGd4bUduNlV1MmY4YytraXBDbzJw?=
 =?utf-8?B?cDZjbkNBdGRZSzVsU2lCTTFCZUFGbEU5eVgrWHZzNmFWMVRIWllkUzkvOUFz?=
 =?utf-8?B?bUgyOWMrTWZYUHRqVUdpZnR6SHJpRnZ0cWhPdUxRUk1JcWR4c0pmNG14TzZZ?=
 =?utf-8?B?dXBWVGNXeTV4R1BURkVYNGdVZmpFQ2ZaRHRaODVYWWNmVnJnRm5GWDNGbkJa?=
 =?utf-8?B?aEZoWEYwVlQ5b09oUnZ6MlJGajFWYnp0THNoMjFoS09GbkJ3NS8rRDNLRG5T?=
 =?utf-8?B?d3NPUHpUWHd5bko0WHdmVU5ibnNEUVBvMVExOU5OQkZrczRvWWlTeEZsVDhK?=
 =?utf-8?B?Tkxnc2ROcFVNR1pBL2pPUmM0SCtNZGp2UXRNZ09aT3JoWVQ4NldXYm91Yldm?=
 =?utf-8?B?UXRvSWlkOWZqaENnUUVmM05WcUJOdTh0T2I1ZkhJQncremFsaDJHNk5kTWpS?=
 =?utf-8?B?UDlvL3RZa3NSNGRFcGRaUTdMYnlUSnBtT3R6b2trcXhYQTZ5cCs1T0dodngr?=
 =?utf-8?B?UzdwRDQ5eHlYdm1aNUYrSlExWi9pemRzSzA4a3VaU0kwUnI0UVgzRldtbXBH?=
 =?utf-8?B?Qlg2WXVCNUJkZ3FxT1hleEpITXlPN1k0QXpjSFo0OEVQeGZoSzFzWTVxeTJN?=
 =?utf-8?B?WjRySEpIODhlQkVaTC9LUUxCZVlLSDNNM2thaUIvMVl2cWhEYjlZcVdtWDRj?=
 =?utf-8?B?QVRUcWdQTUJ0NEVMS2NBMGIxbGZhbExrRllEOXFsNWJTbDNCOWFrQmJEQUNP?=
 =?utf-8?B?MEFOVGRGcU80RVVjS1ZteFpYbzVzYzZ3WW5qUE9qYk52akFKcnNreVFKYzkz?=
 =?utf-8?B?WDhFN2JzSWxyMmgvTTVtMkJJMjVEcmd2Mnp2cllJbDBTU1d3MlBlTFh0MkxU?=
 =?utf-8?B?TWZ6ekhNMXBndEYvMXVzL0dpOW01ZCtocC84d2FEV2xNbGtNVGU4NlVyenE1?=
 =?utf-8?B?RW5LMW1tS1VWdG82NUNuWTdxTlRkSlZRb0ZvM2JzOXBhb3VkWXdIRUR5UlF1?=
 =?utf-8?B?cUI1UnlMUzhIaDhzMDBabGpSY0VDeHovbzJRL1ZBb2xscmxMc3VXbmgwOG9h?=
 =?utf-8?B?VFQ4eVBmUnJjc2lyU1dRYjByRGhiUWN2c3ZPeHZCOVoyLzJaS2Uya1JhT0F1?=
 =?utf-8?B?ZDM0UjNOY3JjU2pVUmJtRW5SS0cvQ3lnYzhZSmdSMXFLQVBtcG45RTI1Nzl1?=
 =?utf-8?B?OG9icURHa2hkSWxiQkEydHNMMk9hMmkvb1dBQmVJa1ZQbDVXQXNlNU9ESXVX?=
 =?utf-8?B?WkZ4WlJpR3Z5dk1mREZ3VjNxb2ptRFlqbERHTFE2TEdLWGEyTEVDTkhiL2Q1?=
 =?utf-8?B?cnE0alB5RXBJSXB3WmVMVDZYQjhDbDFpZnpoSEZlU2RyUjRBS3JGQ0MvR3Rs?=
 =?utf-8?B?NUtSbGRFTWo0eUtuZnFDVGpsejdpVmp5NmE0M2ljcittejhubU4xbUt6NEtG?=
 =?utf-8?B?aWtiVmVFSm9yUExhUHdDejRialRGc1o1UEdTN1hhQzhVeTNlcWxXWVpEM3Nr?=
 =?utf-8?B?aEFBSExIWktTSjU2RWFlNVczZzN5ZE51bTZ2UmJqejRvcm1Ra3dZaVgzbVNa?=
 =?utf-8?B?UHlKNGluNG1zOGtteTFRdzNPT0NXRm84cDB4MGduTHJaVjBubklFMlc1RVh4?=
 =?utf-8?B?Q2RKd2laSHdpeHUvQURZUFdFenR4OEdTVzh2VEptbW9oMC9Od0lRWXJCbDdR?=
 =?utf-8?B?MG1uVEF2YkVzZzNpOW83aWFhYmdSbjhGd05jZ2pKa0xIdFBpUTRKeW1LSndk?=
 =?utf-8?Q?jWv0By1KLhTSk8So1w51iXKRHrqYX/0p8A1dLDA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q09yZlo2c08xOExybS9YWWNpeVd1SUlXVE9OZDVNN3ljZWtWMDhyVHlRQm9N?=
 =?utf-8?B?T0toS1h3TXo0N0NqK0pmMUx4N0NsOWdUdkZVS0tEOS9wakwrN2hOVUdGa0JI?=
 =?utf-8?B?YVp6bkcvbERoRHlTUG1rRDNZS0NaSnhXZitFTW13aEtDUXNwVTJBYmlZbmRP?=
 =?utf-8?B?Qy84QTdkZkVqY0U5WUllS0lRanZPZnhHczZmR0w5QnVkSTY1Y2c2ZlJMdUZ1?=
 =?utf-8?B?eW1ZM1dPSGtwUzIxSW9DNW1kNmxyVVRiZVUrY2xqb01ZYllHeXIrYzhWRU5h?=
 =?utf-8?B?SXNwOGg0Yk5GRkpaRndTMUNQVTVXd3E2UWVjVnpwTUNBVG5vRzNUZEFDZFVP?=
 =?utf-8?B?eGxzOTZoWUNEMURiY0JQNlZuaEpqWVVkam82V3dkTEtkbFRXWUtsZWtySDN6?=
 =?utf-8?B?UUhhUDJ2NTZUYk5LcWFOYTB5alo3L0tlUlZ4bXlIa295WW5uKytqUEZXRW9t?=
 =?utf-8?B?NDhrTW0yWUFDeEE1ak14ZmVoenhxMnJzMDRnRmczSW5TNzRTdEE1UHUrbnRI?=
 =?utf-8?B?VVZmTkhMdDZDSU83bCtZZTBFTUtIU2pycFBDK3A2QWNQQ0RJVzNicE5oZ01p?=
 =?utf-8?B?d0dFUUtaZGFVVFptcFlaR0pmcGFDOHloMlArU3hZUUpjZURzZEdpSzk5WS9R?=
 =?utf-8?B?QUJxS1hvbmFoZHlQNkozR3dIRlRSaGs5NWRxVzNTT1VsbEpiL1llNkM5WG1x?=
 =?utf-8?B?R2NGeXNBQXM3ZXQxTURhUVZFN2UzUWlqc2w2Q09pOUlXeEdFYWZHOU5oZU9p?=
 =?utf-8?B?dGZrOU9hMjdVQXR1UjlwWjFIZU8rNkVMSUFjUXkyUTRkUDN1eFNJUXhNc2RS?=
 =?utf-8?B?U1dxM1AzczVJT1NvT0lhTU4rbEpZVDBiMlV1dzRxaEtMaDljaVpPL2JqMG1z?=
 =?utf-8?B?VHdHY0FyYVlteTZnZ0dmYkwxcGpPbE9TaThMNE5tc043UDl1VlNxT0xtUUZD?=
 =?utf-8?B?TTlHb2szdzRldWQ4S0FUcktwSGYxNU9obS9MaDRxdVh6ajliNkJLMHVYYlBD?=
 =?utf-8?B?eUZ0aVo3U0ErNkIwT0lGUEthMHVSV29ad09hSm5zT0VvZ1MyRjUya2lRcWRU?=
 =?utf-8?B?T09MU3IyYkxzTXUxWFJhYU1aaE4yMXorQjcwc2VCWGZ4K3hKNlZuZXVpZHhM?=
 =?utf-8?B?T2laZ2xIT1pyUDllYWdtUFdBZzJsZFFkT0ZtakJzWkJhN2xOWkp1b0JxNC9q?=
 =?utf-8?B?WG5IUk1MQmJ3d1Q5dEU4cXBnQjlMZy9sRlQ0NGdxZnBtSndrUjFPZm1VVnhV?=
 =?utf-8?B?WnhLSitqc0VYOUcydmEvUEJDQUw0UmVrYkVvSk81TEptSnozekQzTGxJRHZ0?=
 =?utf-8?B?ZndMdDZpTGxSc0pweHdYY3Bua290clJ0RmdmOXZnMHBLd08zNjZ6T051Y2ZD?=
 =?utf-8?B?OFo4U1AveEJKWnJYZjQyWnpvV0RXRzMvMXVybGdLRXF4SDdmalNmUldKUVI5?=
 =?utf-8?B?QTVXL3hNK2VXeW1VNGRkRklIMHdGaUpGdUxqUzg2Ym1PWjNIWHV0bEFvL0ls?=
 =?utf-8?B?OTNtSUZCOUUrU21SZVNFdGs1MytGQmpiVHVMSHN5alBPQTBPSVRvd1JudnhG?=
 =?utf-8?B?UndocjAvdXJTaWVYK0M4Q3JVWGFac3VsMEQrVFlQb2MvUlNZaDRhUFIzaVBy?=
 =?utf-8?B?ZWFDWWI2dDNyQ1RlR25zaTNwUkVaTlloUkU4MFREWGFpbFF5MHlCQXJxVVBL?=
 =?utf-8?B?U210OTM4LzVYU1duMTU0bGRNWmJ5R1JYRGJ2Rkc0UjF4MzEzVWoydFZwTzJq?=
 =?utf-8?B?MFk2NzFXVW5MS2Rab3I4RXNTL2xlWUgzYWVubVNVdWpqMmJyRVpPVm5HYTIy?=
 =?utf-8?B?R08zb1lGWVZEa0R6UERDbkl3RlhJMTJid2tZd3gxUHlQSHRWYlpXbExYcVVZ?=
 =?utf-8?B?WGFrS29VQno3dzlFYldQaGVlZFRsOFljSVRoQTkxNzBKS1FTNG13Q1dvOVpP?=
 =?utf-8?B?RzhZVVJMcWpDSXZNcjJXd05ReW85emdTQjhKOXZEbHAxMFY3Y3dEa0d6MTM4?=
 =?utf-8?B?QkVYemI1dm0remxPSnBWSW1kbUxTRzdaaEhkV3BVTU83TEt2RmNWYUx1b1dn?=
 =?utf-8?B?TTc4MDMwL1JsODkwWldTVkNOOHZIYWJnMmRnRlVnSDNROXBDaG5qcHBSWTBY?=
 =?utf-8?B?WWxNaFloTjk2SEw4cXpvZ3Njajc0SW5xenBsck9saGptcXdZSWdweVI3Yysy?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd67f7ce-02a6-4676-f6fc-08dcf3a7a555
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 21:14:13.9909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oss2bEDaoxX2mKHMu9MurPDJih3lWQ1jPNUVOGzcwAvKgv4eC+tlqi82rViuP5TbWvBcVgra34KkpWut49sGG8hlLHK4sR3HiQnCVpVb3qE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6830
X-OriginatorOrg: intel.com

Hi James,

On 10/4/24 11:03 AM, James Morse wrote:
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 2abe17574407..11153271cbdc 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2201,7 +2201,7 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
>  	}
>  
>  	for_each_mon_capable_rdt_resource(r) {
> -		fflags =  fflags_from_resource(r) | RFTYPE_MON_INFO;
> +		fflags = fflags_from_resource(r) | RFTYPE_MON_INFO;
>  		sprintf(name, "%s_MON", r->name);
>  		ret = rdtgroup_mkdir_info_resdir(r, name, fflags);
>  		if (ret)

Stray hunk.

> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 496ddcaa4ecf..54ec87339038 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -183,7 +183,6 @@ struct resctrl_membw {
>  	u32				*mb_map;
>  };
>  
> -struct rdt_parse_data;
>  struct resctrl_schema;
>  
>  enum resctrl_scope {
> @@ -192,6 +191,17 @@ enum resctrl_scope {
>  	RESCTRL_L3_NODE,
>  };
>  
> +/**
> + * enum resctrl_schema_fmt - The format user-space provides for a schema.
> + * @RESCTRL_SCHEMA_BITMAP:	The schema is a bitmap in hex.
> + * @RESCTRL_SCHEMA_RANGE:	The schema is a number, either a percentage
> + *				or a MBps value.

The description of RESCTRL_SCHEMA_RANGE appears to aim to be specific. Considering this
it should also include the "multiples of one eighth GB/s" input option used on
AMD systems.
The software controller is the only user of actual bandwidth and for its
use it should be "MiBps".


> + */
> +enum resctrl_schema_fmt {
> +	RESCTRL_SCHEMA_BITMAP,
> +	RESCTRL_SCHEMA_RANGE,
> +};
> +
>  /**
>   * struct rdt_resource - attributes of a resctrl resource
>   * @rid:		The index of the resource
> @@ -208,7 +218,7 @@ enum resctrl_scope {
>   * @data_width:		Character width of data when displaying
>   * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
>   * @format_str:		Per resource format string to show domain value
> - * @parse_ctrlval:	Per resource function pointer to parse control values
> + * @schema_fmt:	Which format string and parser is used for this schema.

Please fix alignment.

>   * @evt_list:		List of monitoring events
>   * @cdp_capable:	Is the CDP feature available on this resource
>   */
> @@ -227,9 +237,7 @@ struct rdt_resource {
>  	int			data_width;
>  	u32			default_ctrl;
>  	const char		*format_str;
> -	int			(*parse_ctrlval)(struct rdt_parse_data *data,
> -						 struct resctrl_schema *s,
> -						 struct rdt_ctrl_domain *d);
> +	enum resctrl_schema_fmt	schema_fmt;
>  	struct list_head	evt_list;
>  	bool			cdp_capable;
>  };

Reinette


