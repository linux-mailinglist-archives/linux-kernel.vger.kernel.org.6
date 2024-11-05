Return-Path: <linux-kernel+bounces-395846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC59C9BC3DA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 04:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0B21F21B8D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 03:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D00185924;
	Tue,  5 Nov 2024 03:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PO6NPK7o"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF537183098
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 03:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730777333; cv=fail; b=FDETExcYrrRPxaGHu4sv3avN9rYW5cs1UyzDhZQSnAytdy3TIaO79L550xXo8hIJHmG0CWu44Dx2n0sG9GfVy1CS/JlwC1SvFCtHKV+ASE0SPJnr7nDWGlcRwCEoVmfu7+svst2Sp7knd70wcHSvWtLIPRRnb0StDusVb2nvJKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730777333; c=relaxed/simple;
	bh=XHGk1eH9wNsfuIUjXCj/6y0dyTm5CurD9Q+Ka3bzpY0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RREr1+FRub6G9Oa0P22YHpesHUOe24EUAHUK5isEEQx/mvQmT3KSw0BERAm0W7eSxuJ4bidJI/MK9FyT/aHmzAXWrO3t5r19+6zzuzqRWOq+CU/oCsY/rswxwXsQaWah4VxdN4OO8nlnd9Sgj9bYwkqC/fUQYTw67rwEX/RttRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PO6NPK7o; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730777332; x=1762313332;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XHGk1eH9wNsfuIUjXCj/6y0dyTm5CurD9Q+Ka3bzpY0=;
  b=PO6NPK7oRSYWsZSbRj1U6MWNlfx9gf/Ok3/K8f2yTUe2b8szkUPsAXV5
   rjY1QHaWhKRmBZvZBasjL7jAcyIZbtwf+cpdmIX9NI0n1Y//oBZ1mclAi
   DWIehS/cwH0D/7zvHD6mZA2cO09uzFdXToRrkWO/iPmwpGyC3nwCkJGgv
   QYWsDxAoX4AOwPMk5t4mCLmFSLi2pOJj/kQNCbFnmWZ84nQ4I9UqVbiFa
   JH31EvNffSBLKEssGtWnYMSrw/hmyFAK34a2ZSR2zApTY+36maK/pci6R
   nIZFS1M3tHIynz47LUONggnalvdIbJnNgWIxtGGLDOgPQ8DLJbqmNjUum
   g==;
X-CSE-ConnectionGUID: zj0s7ybDSQey0KYpIvQOqQ==
X-CSE-MsgGUID: /RqXFXGGSyaz4w/NHbxUNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="41134577"
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; 
   d="scan'208";a="41134577"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 19:28:51 -0800
X-CSE-ConnectionGUID: D/rqsbcjR9iDYDX23C4rVg==
X-CSE-MsgGUID: FxS3hDkjQLmBacQonzFChg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; 
   d="scan'208";a="84189286"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Nov 2024 19:28:51 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 19:28:50 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 19:28:50 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 19:28:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SX5KhoFnlwBTGr+okaO4gze99h2Yovqb1ss5BVFRN5mNwndbdbI8FVWb2i4QuTiU6qHaAPavwzVersTNrj2BekqWffWwehrkYBs7kABmcDuldFCOpwGSGzVV92RfGWIA24CQ7+K9AA82t8aPmHxbWYt30zDLKw9iP9fMuQ0wI0jtfw/UOmrkOvEjyaXW3U9p6TB4R/fmPNbDlYv8lCA1cyHM5CYu5O+I9tv/m0lpB2htx6+fXmnklIyRZ82fg3fOs4RLEDvnGsedk39wcujMrMi18ajzDwOIuFiQq+TjM7PUHKuG+t4eEUf+ps8siAuH3B3B8Q2j/ZIswMz6gS6CvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bnNBwoSoqrVSE5SpNFw6snyPT5fwR2asUqdYumt52g=;
 b=cr7E9iA1bQ9rDJDR/gWOhFuDTRC0mphb/azEJaSgA3qA6obswVJjTHGNpxmfnToguiwp4LI/BZ64iZCh/w+TEB5BHphX8YchqPXf90qB6Ib6X1OQhEXhji5I9GhCUB6VRXMj7BFV4JFUwJzrcjNn5cmbK37WJp/4eX/of1BMy1q+Dvqea/5CwFB7fis0hP3QtZ+9pw2j2YPehVUtQd9vQy7b9/jCJA3DvfC2QDbClDiclnyWiQnpm12QL9qf/GOKbwH2KQwe4h7nHC7oOjeuzkw2f9lZEE75lOhFUxdk8ncTLpD4VMK79dd7wvysz+pVKFjXhQMc9GMIt0RHBtLULA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by LV2PR11MB6022.namprd11.prod.outlook.com (2603:10b6:408:17c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 03:28:41 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392%4]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 03:28:41 +0000
Message-ID: <2e2636ef-eb0f-067d-ef8b-a95e762dbf9f@intel.com>
Date: Mon, 4 Nov 2024 19:29:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] x86/resctrl: Don't workqueue local event counter
 reads
Content-Language: en-US
To: "Luck, Tony" <tony.luck@intel.com>, Peter Newman <peternewman@google.com>,
	"Chatre, Reinette" <reinette.chatre@intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, "Babu
 Moger" <babu.moger@amd.com>, James Morse <james.morse@arm.com>, "Martin
 Kletzander" <nert.pinx@gmail.com>, Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Eranian,
 Stephane" <eranian@google.com>
References: <20241031142553.3963058-1-peternewman@google.com>
 <20241031142553.3963058-2-peternewman@google.com>
 <b3a52af9-e298-7baa-19b3-8931d03731d1@intel.com>
 <SJ1PR11MB608357ED39FA4FA1C85C6DB2FC512@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <8a76c5df-3982-c53a-9643-4b6b1de290e2@intel.com>
 <SJ1PR11MB6083901BDDB4B6F8733977B9FC522@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <SJ1PR11MB6083901BDDB4B6F8733977B9FC522@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0052.namprd17.prod.outlook.com
 (2603:10b6:a03:167::29) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|LV2PR11MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: dee7679b-d721-4794-b0ce-08dcfd49f19f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0MyNnFWRXBwRjFzUGV4M0VzaGVUQVExMGFmb1J5NDVibmdDbmVXZXdTWjNk?=
 =?utf-8?B?bmppSENQcytkSE5PK2NWbmpjR3Mvay82eWFyN0dwc1JrK25LUVd3WWlzb2gr?=
 =?utf-8?B?NFZiWXhpVW13alZXejNOeVJUbFhBYkV6MXk1cnkvaDBiMCtua2hSVWkzUnYw?=
 =?utf-8?B?M2dmQUxKRW5uUzcvbVpwRGUrQ05jblJFK253UGpZVTJ0KzJJTDF1dVpySzJG?=
 =?utf-8?B?SzRqNkpITS9rQWc3Q0hWdGxrVEVicmFoU2xDZUMwTWhISDFPSU5IamNhWXlI?=
 =?utf-8?B?TlZWT0dpYmJpNFlzUm90UysyTGFBRldCdWU5ZHhJbCtkRUUxRzlEWkJzc09P?=
 =?utf-8?B?ZGFCdSs3Yng0cFhrcWtPdlpSdEtHSk1QNmY4OWdWV3c2bzY4dlZHQllyMjc2?=
 =?utf-8?B?anFEMmM0SFVOYmxUaVBzUTZEeTlKV2c4eW1UQldtRjVZL2plc25tYWdQeWZC?=
 =?utf-8?B?ZGoxRlEyRzBMek5EdWZQdzd4V1Fjbm9FUEFGQ1lQTmdCYXVJc0Q4bGllT2Z0?=
 =?utf-8?B?NkxtOHdiR01ScXNERE5YdUl5UzZyc0krajJJQ3Q1emV0SVovejQwM24rbTFV?=
 =?utf-8?B?N3VmYVdNNFhhUEFXb0owSitrbTNyZ2lhTUNOcllBeFFTd3hWTGNYcjcyV1VN?=
 =?utf-8?B?eWk0Qm9nRUk3d1ZoRUREQmtScVJDL2tEU1A2cDRlRUJ6RXcxMzJhS3VyRk9E?=
 =?utf-8?B?bi9wNkFWQTQxbW9GdlhlL1VaT0J3WlhCOVBJOFNTQjdpdU5xb0NCeVJFbmNE?=
 =?utf-8?B?NkQzZzN5RUNScFN4WVdOUUhnRWpLOGJFS1pUUmVFbWNMVGZyVUo4OHc0VHNT?=
 =?utf-8?B?TUJuZVB2N1B5Z1hWNUtTMTF2dmFuTzQwQnNKTjBFOEVYdm1ldUQ0UE55Z3Bn?=
 =?utf-8?B?U2J6Z0JMOVhHdEdmb0tOaDIzMDh1MjFOcDFSRlVPZ0N4eEJlVjlzWktPK3R5?=
 =?utf-8?B?SSt2UHIrZ1RCS3Zpd0pZQWMwNVRHK2FSUE9NT0RJd2ZkRWMwQkNwMmViWnE4?=
 =?utf-8?B?Tm9EbWMvSm1BN21Va0JjMlA0eW9oT0p4Qmw0ZTNPNFpyTlZTbVlRaXRkZm5p?=
 =?utf-8?B?am5GbGFmWEhYWFJoc2xjU21GNDJMMzFFcU5PeGF6Qy9HaG1UeFlOb2FkTUQ5?=
 =?utf-8?B?bURSOFo0TVJPNExnbzFnQzJSZTFidUY5RHcvUnh6Y2ZuSW5iQVN0MnNoSzl6?=
 =?utf-8?B?US83eEp0eTZqVDVpTDRiR2gxN01SRXhES2VubkFlWEVVK21uNkdqUjE1UFo1?=
 =?utf-8?B?Sy9sazJaajdtWXN2b25EY2VNcDhFUTdLRi9tZFZuZUNuYUhJK0g0bGRySDl3?=
 =?utf-8?B?VVllTzVTTXJXZUhuaHJtRStHVk1RVSt1RmxHOEJHcWpodEIyNXJxS3ExcUs2?=
 =?utf-8?B?QTJkbW1nOExxNW1EMUNVNUxadDgwc0VEcXhNQUFLRjV5blRTK29BTndhNUM2?=
 =?utf-8?B?WGZ0SzZ3TWQ2WlFHejRxbkg5amVtb09kOW90dlJ3WVNMVFBRYWF3WTlvMC95?=
 =?utf-8?B?VHpPTGhTUVFxSjhNbXJCRlk0dEtnS2d6OHVreVByV3lSbXhMWkVBU3lsNkFq?=
 =?utf-8?B?dkFvODlLN3hidzBzM3FlVWl3N1grMFJDckhDWTc2RWxxa09tSExlc0w1K0RT?=
 =?utf-8?B?ZUtUSFZFRWF2eFVsZnkwQXVxeGtuT3I3djdlSjRCaHI1SXJoU1lZa1BGVEVJ?=
 =?utf-8?B?RG9FZGlPSlNYVFlBTXBnaW5iYlNxaEwvWjhIOGVPMjJVNUtOc3BhY2cyUlFs?=
 =?utf-8?Q?WfIpVCEsmPi+UJDMa44s6MbOrUP2S4omOLbw5Nq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzFJdHMzOHIwNnltei9yc016UzFCVExhTytpWjZaZTExYUVWd053VVZ4NUNp?=
 =?utf-8?B?Z2hQcXhuMnZ2bWY2VkdBWDE5Y242T2FFQktEbnVHU3E2VkpYdjhqNnZ6Y25G?=
 =?utf-8?B?SjBSN2JjVW9XbUFVeWN4Z1o4VldUMkxkKzdOeGV1UFcwck50a1dkV3dNN0tF?=
 =?utf-8?B?MEl0T2hyQ2lOYkp5R29qaDlwYWhPUk50a09kQ29VQm5MZ3c4YVBRZzJUdThh?=
 =?utf-8?B?L1g1TWdGanJtS3VSWjNUUWRWSkpITmtpWjEwbm1PbkExeDltb0dYMkRoODZq?=
 =?utf-8?B?cytmM09LZXIrUDUyOElJMDMydGtIU0ZNNjhVZzdISWJiYm1GR3ZHMlhzOERm?=
 =?utf-8?B?bTNJTGpTTXBTZUFSTW8yMVFqZmF6VHBZKzc5SjVQT1prOGZMeG5kNElMUU8w?=
 =?utf-8?B?S0d0VWwxUWl3Qm5LNVhHZ0hsZmIwQTFLcTFUY2JqbXQ1SDFDTEg4NHFvZnNm?=
 =?utf-8?B?TVJTTTZqa1BnRzdTdFE5SnJ4NVhZZnNpZzJsRkNSUW5JTmNRemtibWJCcGxv?=
 =?utf-8?B?TGp2ZWNESmVUcEFhZ2d4YXFtSWFMM3QrcndNTm9XVllBSmQ0YlV0L0k3eUJz?=
 =?utf-8?B?Wm5UTUFtR0lwSDh4MERNTHl1NmMzL3Z3NE85MUUvM3MvZ24yOTdXVnUwcEZY?=
 =?utf-8?B?dGZYYmI5RWxIZnNkdGNRcG1LdW9IMHJGbW80S01EMTZmVFl1OXhIMlBGa1hD?=
 =?utf-8?B?dzdnS3plUHBlSGdRc3FXQkZuUEdDQ0ZIdTNlVjFrQmt2SkxaUjJ3ekVreUhi?=
 =?utf-8?B?djkxREl4cFkyeWhQY1MwVWU3WDBQZnhOcFN2Ym1XZnJhc2dyUU8yaWhBdWZZ?=
 =?utf-8?B?dUJPR1RZMGhtZitmVWtQaFZiVjlLRkxSczJoYUcwK244VHRoY0Z6ZUNxQUdZ?=
 =?utf-8?B?bk1QNCtuUlprTUk5YUtrT1o2STdBc00yNGFiNWFTRkJqMGQwcnZzNTdPdGZu?=
 =?utf-8?B?UFd5WnEwQno4Y2xZdGxwZDBQSXJSMEs3d1Y4N1ZRL2FuM2xxSWo1M2VRK2hj?=
 =?utf-8?B?RUJsWlBwVHJjOFlGc3pudkRERWg0bEJ4dlpMZ3VyNklwb2puclBELzljMDhO?=
 =?utf-8?B?VG51OGZHWHlCZTc2MnZPL0xSdTdPUjI5OXYrMVdUSEJyZW11UkVzTithRVBj?=
 =?utf-8?B?RTVSbGc0Z21PRzBPTlRSYnBpWjJhdEFBNVhKekdLdTlzTXJIb0V1UUxuMFhn?=
 =?utf-8?B?MXd3dERXblpCUXY5WWVjMmJZOXZkcFhmUkNsKzE2SjJTbXY0ME8rRE5qQlMw?=
 =?utf-8?B?TDNuWllwUW9IVzVjUDN6SVhtdGZ3Q0VkdmtCMDVqWDUvSlRTNTZwcEhZMHlI?=
 =?utf-8?B?bVVkM0wrVXU3bjNFRlZkVWplWmY4SWZ6ZStzZVJBTS9YVWVOTVJrY3BFSU5P?=
 =?utf-8?B?TVZNeFc5NFE5THh4K3BnUEQxd1pCME1ZbGxBSmRmOC9rNytOcHFEZFB0ZW8x?=
 =?utf-8?B?ZllYYVlTZHBzOXErSGc1c1NpcVhiczk4c2dNdG1RMXVGSE9tSlpjZTk1WERZ?=
 =?utf-8?B?WEFzM3kzUzJMMWZycGlXQm5TN2UxcGY1Q2t3YlhoVXRTdXJiSm1IblZ2em56?=
 =?utf-8?B?L3MvSjNIK3dmWSsyRjNneWVtY3pOMXVOWkg2TVNPbjF1UHlkYnAzdWlnZ28z?=
 =?utf-8?B?MUszNm1iYWNONW9jaVdhNnJvaDlPMTVCOXozWU9VTUhzWHpBdUR1NEMwQVhH?=
 =?utf-8?B?NGFZaFpzSHpUQVl3SWp1Tm1WQlhyWHJJbExqMEp0ZENtdCt2SXljWldQRGlh?=
 =?utf-8?B?OHB1SXVUcUE1WWRMM2tiSGdzTVVBTGh3WUc0bnhlKzYxNUZPdDk2Rmt6VDBk?=
 =?utf-8?B?RFdZdmFzT0FLbUFnd2U1dFV2dlpnMEVGUkFwWGc0VUhHajVNUVJxaXF2WXdW?=
 =?utf-8?B?SmJ3N0x5emtNYUJaOG9xdDlPdlZpVmV4a1p4RjJTZzBSeUVJSFRpR2hLSkdF?=
 =?utf-8?B?cjhnMUpvSVFkZDdySWY5K2V6T2IzZ0QyWFFZTDZ1RWZXeWhwRkF1WDNicEtk?=
 =?utf-8?B?UW9FaHlGMUtScjhnSkRaeWVDcXkxOUJIRTA3UE9oRms5a2tPNlVzY09nbHFQ?=
 =?utf-8?B?VEpxTWlJUzRRMFF2L25YYmRCQWFFZklIRFJYM1Z5L1Ewa3VPcHIzMzVST3NE?=
 =?utf-8?Q?/bfbQdd1+6KVCppPYp0KFESt2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dee7679b-d721-4794-b0ce-08dcfd49f19f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 03:28:40.9915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ra6HLaawPWp1p5Rv6iDQB3Di70h0957wF3WPRPoAghf05kwnEttfr8KpZcrOy8o7c1TyWVZVHv+KARkgrFagGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6022
X-OriginatorOrg: intel.com

Hi, Tony,

On 11/4/24 16:12, Luck, Tony wrote:
>> Whenever this function is called, the performance is degraded rather
>> than improved because extra get_cpu()/put_cpu() are called in the fast
>> path in the current patch.
> 
> But get_cpu()/put_cpu() aren't high overhead. Maybe costs less that the
> cpumask_any_housekeeping() call that is avoided by Peter's patch.

Quote from Peter:

"AMD EPYC 7B12 64-Core Processor (250 mon groups)

Local Domain:   3.25M -> 1.22M (-62.5%)
Remote Domain:  7.91M -> 8.05M (+2.9%)

Intel(R) Xeon(R) Gold 6268CL CPU @ 2.80GHz (190 mon groups)

Local Domain:   2.98M -> 2.21M (-25.8%)
Remote Domain:  4.49M -> 4.62M (+3.1%)

Note that there is a small increase in overhead for remote domains,
which results from the introduction of a put_cpu() call to reenable
preemption after determining whether the fast path can be used."

As his data shows, if the fast path is not taken, the extra put_cpu() 
itself costs +2.9% extra time on AMD machine and +3.1% extra time on 
Intel machine.

And this ~3% overhead is on top of queued work, which is more expensive 
than cpumask_any_housekeeping() IIUC.

> 
> Note that if Peter's patch doesn't take its fast path because the calling
> CPU was on the wrong domain, then the subsequent code is going to
> do an IPI whichever of the if/else path is taken.

In this case, actually IPI is only taken in smp_call_function_any() and 
smp_call_on_cpu() invokes a queued work instead of IPI.

My proposed change logically doesn't change Peter's fast path and 
performance for nohz_full/smp_call_on_cpu() case. It just utilizes the 
"built-in fast path already" inside smp_call_function_any() to save 
extra get_cpu() and put_cpu(). Hopefully the saved extra get_cpu() and 
put_cpu() can offset cost of cpumask_any_housekeeping().

 From Peter's commit message, seems nohz_full case is not 
called/measured a lot if any. If only one or a very few housekeeping 
CPUs on a large system, the nohz_full case will be called frequently and 
fast path will fail most of time and the extra get_cpu()/put_cpu() 
around the fast path might impact more on both local and total domain.

Thanks.

-Fenghua

