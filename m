Return-Path: <linux-kernel+bounces-395648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F809BC0FC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 23:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DE34282F5A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE18C1FCC7F;
	Mon,  4 Nov 2024 22:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VP9DIm8M"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1DB1FC3
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 22:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730759766; cv=fail; b=fJx5Lf+W+JJqQxPivm7LKZgSILbjjqJfNHHbqixJXaHN9VDCXkmJmzUjyHjzbiFy3Xu1JylwvgpTCFZCQHBbnP2q35F/el5+5NxcnonSvMAIG+oAaJmiMMgEdHrCEtGS8dYEad2SAgLLvGLWFUU8pUee/ll9JZn9V+r/sM3vZKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730759766; c=relaxed/simple;
	bh=FL8ZuT7nqUb7wpPHo2elXLvgzJE9WtofoFYNtHV9BR0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=in7jVMI7Tg7nXxIukTFj+Spl4+Ef9ZKnqapSpeDgrsUdLfEVN6aRAya9PAl114z4nVidB80ZaGLlT2yYmwg+sCu4eSodOxQ/Z1j5pzREBhJdSLb3ZK5R+6znoVYRZ+6K4W0jZTsM6fiFUm56UF0FpFG45ZERezwiha2BS42nNS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VP9DIm8M; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730759764; x=1762295764;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FL8ZuT7nqUb7wpPHo2elXLvgzJE9WtofoFYNtHV9BR0=;
  b=VP9DIm8MZ+GaRrl3Hg1OZ8qczcgBSAq8Wl+5nCx8ELA5TemYI5TeATXT
   WE7Pwt7RRaVjWuEXXNq4T77/A7kDMu9TS2dB0Sq3UPtSkY4kulenUAbfH
   pkRNGXhInkUJiGql4FVOtWD5SBnRUzp6awj1RvisCWfT5N6aipT3xAmlN
   7xisAnMCYe7nW7zUoSRncn4fgZfFGN/ORDuC38iFrmSRJI4HT26sHW7YO
   KmNi3vw+SWFVIKSF6gesQVQ5zM7ACII66D5yGz9lfc+Cpadtnv8GSp3Yo
   zzCGAjzi/rmqBngzRLBFZrm8m7+jSXQStfJ1vTdtRfe8OitQVrMbOZNyU
   w==;
X-CSE-ConnectionGUID: 5JIKKwpiQ2qgwGUPPIY98A==
X-CSE-MsgGUID: KThRvmARQAGfkYG5erRs6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="41112723"
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="41112723"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 14:36:03 -0800
X-CSE-ConnectionGUID: GAwwujKBRk2FcmXsdzONqA==
X-CSE-MsgGUID: VEcdZlnsTq6DCRjCCCzqgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="87727715"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Nov 2024 14:36:02 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 14:36:02 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 14:36:02 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 14:36:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zjin7I2+wMHdkAJzH5mFE97X8BCG1P8/S82OMqNS+A5+VOHuipklrv5V3DMkJBilcjaT+wMlQVz4RbyKcXFNgAehpiS2uwfoN1FkW9OINnAEsVqTFzpOOgoWgcEXs/snty+yrPm6dXLALobDPRxtmsSyCIetvDdHZsF1VbnnuqxyXf6E0h7ve1w7rQ68ijUluoIaJ9UTMOMYeMBXgzwD3smisBHm7gSeWuB/5r702UeiQDGop3cK+mcIXx+mmiDpArK1XQME6IeDF/UH7Ue+p5aFY7dnS6yU5y9mVRIAYCEqnWihQwxbidVPnA5bksS3vN89R2mFV3ocmeM7NA7MCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/w5UHfxIXVS6NAiu3MquhQ0bI4XAVzup0c7Kp4Q8EV0=;
 b=wppk6X9XvzqR8kcb06+m0BElLZTrSCw9pBOeIjKxD/0A5DsPVowJkvhhlmaC7ubRv9JG++S6dwub1vvmMJ4i42fG1TWs7qjC4gmTN1eiky7wXXXpe7Oe9+/m/5I9haos/EOs6WNAoNDrNqrevDe52MBFHA/tLQNX3lIMqc6kD1Z4NmRmO212h8h3UZUsK6rZyTPHtnWMwV8TtlbEOs2d/tRPgIXpyQzZjocVx5NiX8b6IaCThMgQNUCAk9QbwtEu7eRZtz8wmMSBac+g7fBxnyMAowfMLh+mWJt6kg5agNp8euj7mto2kPo5Y+2D1rwgzKtpIW9KJasJTpqlUKiMew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SN7PR11MB6703.namprd11.prod.outlook.com (2603:10b6:806:268::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 22:35:56 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 22:35:56 +0000
Message-ID: <b3a52af9-e298-7baa-19b3-8931d03731d1@intel.com>
Date: Mon, 4 Nov 2024 14:36:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] x86/resctrl: Don't workqueue local event counter
 reads
Content-Language: en-US
To: Peter Newman <peternewman@google.com>, Reinette Chatre
	<reinette.chatre@intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Tony Luck
	<tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>, James Morse
	<james.morse@arm.com>, Martin Kletzander <nert.pinx@gmail.com>, Shaopeng Tan
	<tan.shaopeng@fujitsu.com>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>
References: <20241031142553.3963058-1-peternewman@google.com>
 <20241031142553.3963058-2-peternewman@google.com>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20241031142553.3963058-2-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0274.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::9) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|SN7PR11MB6703:EE_
X-MS-Office365-Filtering-Correlation-Id: bb96c1ae-3c80-43b6-5f14-08dcfd210c6a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?My9LcjhoZSttNVBXNTRRcUZETEZ6UFFtMmtMVTlmVXBKY2ZrNy9mTGwyeUxV?=
 =?utf-8?B?Z3k4cE1OMDR3M1FrSXhwRUZDdWliTWhYQm44VldoV0hGQmZkUEVVN2VscFpo?=
 =?utf-8?B?V1k3aXhxOXlSQ2swKzZtVVQ4ZERCNGhLWlgzS3QxMmhNZldMSTRsRGlTMWV3?=
 =?utf-8?B?dlhCZTYzalowUzZ1aUNqWGVOV3dEWU4rQitzSVpjMXY3VUN6amlaei9GQm1P?=
 =?utf-8?B?ZWxpYlNERHlhOG96TStkOURqdThlaXMwc0pLN21LVDg0VzVjMDcrTS9QakRM?=
 =?utf-8?B?ampXUks3Z3JiWWlKdEF6M09pdFQxc1lMTVhnY2RDOStGeE9YeFFKV3dOY3c5?=
 =?utf-8?B?QXRHS2VwQTU2dnJRVDNMZTRCc3NmaGV6QXA5WlRZRmxlYWpib0tQVFlPbEM5?=
 =?utf-8?B?SkNBUVMyUXR0YTEvczJaVVpsSzdrV1VFVDQweGJFbjN5Vmt4ek83Z1JkL3ZQ?=
 =?utf-8?B?UnphQWtTR1dSL243dkFUbGFNd1M5eXRlU0hKTm9sQy82MkpIcUxKajIxYkI1?=
 =?utf-8?B?WHJXMENUSkY3bjJkdFlIY2N4ZTl3cE9Sb0VOTW5kTUVOLzNyQ2ZwVnpxSk5E?=
 =?utf-8?B?eWMrWWVtVXlyZW5CbmZuWHZIbGllOFhYL2h3bzdIVHc4L3QrTGFHSTNEaDN2?=
 =?utf-8?B?N1AveTJFZXlHYzl2VXNwUGYwVXBiQW94b0oyU0FjNlZZM3hESy9iV29BL3FO?=
 =?utf-8?B?VkNvRCtDbEdvM3E2am9JdDZRb01Hb1NBSUFCK25yS09lNEhCenprWThuSUlu?=
 =?utf-8?B?a3F5SUo0QjJQZHJWSmFHV21KUGZtTUJsQnV1LzkweXRDY1hhc0F5bjQveVMz?=
 =?utf-8?B?TDdFWTQ2cU5kSEo2NjhLd0RJSHhvekFYSVlNSVgrQUlUUFowM0NoSkhLV3NJ?=
 =?utf-8?B?ekI1ek04OFBaV3I4MFZkSjBBUGZjNmNFUk50eHlSZzZWVWE4L2ViL3psQVFT?=
 =?utf-8?B?OXR2MUZtYTFicEdpWkxCK1JHUlk3TlZyUllOYStMWFYrdDRQVDdnblpxZ2hY?=
 =?utf-8?B?dXkxSTA0T3RmL2pCemJyQkJ2ZHFMQjJ2U0tQdzk0LzE1K2NjZkgvb0RvSGNX?=
 =?utf-8?B?QlJUeTN5V1ZmcDFaUmRaVlFkVFlsMVNZblRlMmRYN2ZaMHA0VkNuaFArSTZw?=
 =?utf-8?B?WkhIdGFzOHk2K0dPRGowbGZwK1FQOXd0NGNTRmZOemVYRWtiSDh2V2wvdDBS?=
 =?utf-8?B?bkxGWndsWFkzempIVU5HL0d4TytaeEZJdWwxRXlEKysrSDJwNTMwS2pRanF5?=
 =?utf-8?B?eEluaGZNMkkra1puQVNoWDhEenBXaXZJbG5wSkRtdi9OdG9ZZDZkWDhFa2Na?=
 =?utf-8?B?TXBrWWduQVpaSVh3N2F3dUMzb3p2R2hNQXRralRoUmZYdVI4dmY2YlhXbEc5?=
 =?utf-8?B?eG9wYVBaQXowbTg1NndGcEI3cWM1OUVRMzJrdjVIZEpDMmFOQUcrQnA1N0Fh?=
 =?utf-8?B?Q01jcVB3Q1RnYkRpVGFaZkYvenNrZW1yU1ZJNkE2ekxlbGhneUhKQlpzemZK?=
 =?utf-8?B?ejBHWTFTWHNwODBzaElBM1RqTzNvWGtBR3hsOVp3R3RNY2w0aW5CRGw1d0dR?=
 =?utf-8?B?Uk9qdjZ5TlduMUFJbzEzZ3NlSy9mQTcxVGpiclM2VjRKcXVMM3VDNGpCdy9X?=
 =?utf-8?B?KzIxckZxY0ZOY1UrYks1S3ZKY1NROHJpL0ltSXN3VEJDMER3TnNycTRhYXZC?=
 =?utf-8?B?SHZEaVp2MjNaSFowVldqd1VuVDVlOXF4Uk8zSmYrcW5sV2U1ZTMyMCtuclpa?=
 =?utf-8?Q?wdyasuuMawTpWjC0jSxKyzksqkUM97qBNP9RBwp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnExZDk0THFSbE1SVzZxZFVNQk1RQzFQWEt6R3huODRMcmJqSGQ2OTdvOXND?=
 =?utf-8?B?VG1sbFNuWmNEQk1oYlNlUlhlUE5uYmpkcVlZZFByTVBJTjhWMmNzRzJCRXdQ?=
 =?utf-8?B?dUk2dGI3Vmp6VHY2OE5lYm5jZkM5aXdZOW5oUE11TlBFQ0p6NnNuU294M2My?=
 =?utf-8?B?Rm1DenhXYnBENUFCK29mUlFpZkgyNnlvbzBlYUU0TktOVXFEYXpHc01ORXVt?=
 =?utf-8?B?RmwwYm9ZMG43ZU1MWmJMTFFIeXhRRnYvM3ZtcGlqYkxrMnJDV0plckYwcFhy?=
 =?utf-8?B?L3phY29lUlR2SzRPKzVkU0l5c284MTg3SXhlZzZQeHVrbDI4YTNRanlyY1NS?=
 =?utf-8?B?aEZJOHdueVJreEJnT1pvV0FOVjlIU3p6WXFxY0s4N1FMTEpwbHRGVkhYeFBJ?=
 =?utf-8?B?OHg1YVZMTHhHdVpQRE1TSVBDVHY0TzVGV2l3SmpvREpSTk5nczlaT1l2UXY2?=
 =?utf-8?B?Z25tZ2FFVnBwVmtuQ3RodXNPTHhrckFKSmxWemhUd0dqSTVicmZZa3ZEWVNk?=
 =?utf-8?B?bHFjNXNHRTE1REdYbW5iNUVic2JXREFyR1lxeVY4cE1wM1orMFpzMlhMVUlN?=
 =?utf-8?B?SytDUFJXMmpRM25EMEF2SjBoN3hhc3dOT3ExWW5yN1k2OEFBbEFsbDYyZlJl?=
 =?utf-8?B?MFhUR1llVnBKNS9QR2Y4Mzluc205QjJwSndYL0FnczlpVzhYem9HNE00VDNL?=
 =?utf-8?B?WWtxSXhwNnJuRUZ3Z1kzTVRVeDlWQ1hQRk9UTkVzZjhoWjR2eUVKOHdJekNY?=
 =?utf-8?B?SGovZXluS3JDNjJxQ0VPNTV1N21iWkxVK3lEbFRsNEVlVkNRRmFCY1pCdkRs?=
 =?utf-8?B?SnVEZEJMS2NyR1RESzJxSS9vMkJab1U2SVBwczhiOCtyZnZUcXdwSTVBaTE3?=
 =?utf-8?B?NkVJdFN3a1pMcWk4YWpsSEFRa1EvQkx3L1A0bStOblpqbjcrMDQ1WGd4ZitF?=
 =?utf-8?B?YUZBNDUzOEpxUW9pTm5BeTlNc1JjTk53eVl2emNMUUlreXNLdDJpM1psandp?=
 =?utf-8?B?QTlRazYyQ2hsWlY0cHlMaThNMngrZ0poYUcvMGpWdUdDbWNVaTZ5K3V3TTNs?=
 =?utf-8?B?aVlIOUZ3TXR6OEhERzFZcWdiTUY1MlUxaVFLc2k2OEFYWjV5ekZKUVFRT0VZ?=
 =?utf-8?B?SVdSRVRtcXppaEUzUXRUNUFEb1BOQWo5czN3Yy9ucmM1RHVodkI4YmtvSFhW?=
 =?utf-8?B?Q0tGTEEreTdmdGREVkIvNThsSXhzdFBRK0huc0VlQXNEQjlzUHJSNW9jWjZ6?=
 =?utf-8?B?alMvSmp0L3dSdUJpNXBQQ3VpYWgzVzRlaWpTWTlyYllsVVRmNE9nNGwzdHh3?=
 =?utf-8?B?eDNGL0RJQlkwWmgzejV3d3BlcnBXV1NaQTJZUjJVSmZsQ2JSVGNrSXRGS2h2?=
 =?utf-8?B?NmNCV0pnZkZpSzNwSFM3LzBoUTByb2RVbWxKTFJFTGVTbXZzQVJNRlNPZlB6?=
 =?utf-8?B?UzRYZG9mODB0b2JaTS85U0hsM2QrWTIrb1lVQ1ZVUlE3VmRiS0pUSDlFSVEv?=
 =?utf-8?B?QUhxUmpSd3VpN21Nb1B4ckxhMWF1Z1hKb3VnN0lKcCt6aFQzSW9nUTZQVnRB?=
 =?utf-8?B?Z0xQTitlM1NManRPdHI4YlN6bUNnUENRelFnUjh3SkQ3ajhFcjBDYXdvLzRm?=
 =?utf-8?B?RjdnV1I2TWZoQkIvdmhxS2xzZW1NaWVsSEZKYjFJUHJpZGpHeUhmR2JCcW5v?=
 =?utf-8?B?NkRwc1l2Mm94UXdBNjZwZFpzYVIwZ3pGVmxPWllvMXEzc0lUeE0yYU56VkVu?=
 =?utf-8?B?d1NqdWNLaEdUOTRkdjhxaXppV3BCMENraHYrSHBwRzI2WG9SZTBJUXQxU0F5?=
 =?utf-8?B?YW9iOWJjMERiYXU4UW1ZSEJIYWIzemtVUDJ5Vll3VWdoK0FVTjA1WTZIdGd1?=
 =?utf-8?B?Q2xLVmdGOU5kQ21GVGluVUJaeHFnM1RCOTIzK2I1ZGxoN042VzI2K0pBejYv?=
 =?utf-8?B?S3VhUDZQY3lpN1Z0N1BPTWZCeEVPbFVpYkdMc0w5VDlTKzJIdVVaK252SGZy?=
 =?utf-8?B?UHluMy9uK0E5ZU4wUHQvd2tUdU42MGNLcHpUeWdKcjZyNlg1UnlWWmthM2JB?=
 =?utf-8?B?TWlLd25OdHZUc1NyV2ZYZHRCV1laTktueUVJQzRyRncxbHFRNGhoVER6R2ZU?=
 =?utf-8?Q?SHUE3OBpWIU2/dCrxGZvmX9bV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb96c1ae-3c80-43b6-5f14-08dcfd210c6a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 22:35:56.5860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qDoyMuElQTDZvnxqNWb2R2AF5+2kDfNA3KZkNROZLPpbhLSvmfDHx8poq/PQdhoR68ASbL54w/1dskXz6jtAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6703
X-OriginatorOrg: intel.com

Hi, Peter,

On 10/31/24 07:25, Peter Newman wrote:
> Performance-conscious users may use threads bound to CPUs within a
> specific monitoring domain to ensure that all bandwidth counters can be
> read efficiently. The hardware counters are only accessible to CPUs
> within the domain, so requests from CPUs outside the domain are
> forwarded to a kernel worker or IPI handler, incurring a substantial
> performance penalty on each read.  Recently, this penalty was observed
> to be paid by local reads as well.
> 
> To support blocking implementations of resctrl_arch_rmid_read(),
> mon_event_read() switched to smp_call_on_cpu() in most cases to read
> event counters using a kernel worker thread. Unlike
> smp_call_function_any(), which optimizes to a local function call when
> the calling CPU is in the target cpumask, smp_call_on_cpu() queues the
> work unconditionally.
> 
> Add a fast-path to ensure that requests bound to within the monitoring
> domain are read using a simple function call into mon_event_count()
> regardless of whether all CPUs in the target domain are using nohz_full.
> 
> This is significant when supporting configurations such as a dual-socket
> AMD Zen2, with 32 L3 monitoring domains and 256 RMIDs. To read both MBM
> counters for all groups on all domains requires 32768 (32*256*2) counter
> reads. The resolution of global, per-group MBM data which can be
> provided is therefore sensitive to the cost of each counter read.
> Furthermore, redirecting this much work to IPI handlers or worker
> threads at a regular interval is disruptive to the present workload.
> 
> The test program fastcat, which was introduced in an earlier path, was
> used to simulate the impact of this change on an optimized event
> counter-reading procedure. The goal is to maximize the frequency at
> which MBM counters can be dumped, so the benchmark determines the cost
> of an additional global MBM counter sample.
> 
> The total number of cycles needed to read all local and total MBM
> counters for a large number of monitoring groups was collected using the
> perf tool. The test was run bound to a single CPU: once targeting
> counters in the local domain and again for counters in a remote domain.
> The cost of a dry-run reading no counters was substracted from the total
> of each run to remove one-time setup costs.
> 
> AMD EPYC 7B12 64-Core Processor (250 mon groups)
> 
> Local Domain:   3.25M -> 1.22M (-62.5%)
> Remote Domain:  7.91M -> 8.05M (+2.9%)
> 
> Intel(R) Xeon(R) Gold 6268CL CPU @ 2.80GHz (190 mon groups)
> 
> Local Domain:   2.98M -> 2.21M (-25.8%)
> Remote Domain:  4.49M -> 4.62M (+3.1%)
> 
> Note that there is a small increase in overhead for remote domains,
> which results from the introduction of a put_cpu() call to reenable
> preemption after determining whether the fast path can be used. Users
> sensitive to this cost should consider avoiding the remote counter read
> penalty completely.
> 
> Also note that the Remote Domain results and the baseline Local Domain
> results only measure cycles in the test program. Because all counter
> reading work was carried out in kernel worker threads, the total system
> cost of the operation is greater.
> 
> Fixes: 09909e098113 ("x86/resctrl: Queue mon_event_read() instead of sending an IPI")
> 
> Signed-off-by: Peter Newman <peternewman@google.com>
> ---
>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 28 +++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 200d89a640270..daaff1cfd3f24 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -541,6 +541,31 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>   		return;
>   	}
>   
> +	/*
> +	 * If a performance-conscious caller has gone to the trouble of binding
> +	 * their thread to the monitoring domain of the event counter, ensure
> +	 * that the counters are read directly. smp_call_on_cpu()
> +	 * unconditionally uses a work queue to read the counter, substantially
> +	 * increasing the cost of the read.
> +	 *
> +	 * Preemption must be disabled to prevent a migration out of the domain
> +	 * after the CPU is checked, which would result in reading the wrong
> +	 * counters. Note that this makes the (slow) remote path a little slower
> +	 * by requiring preemption to be reenabled when redirecting the request
> +	 * to another domain was in fact necessary.
> +	 *
> +	 * In the case where all eligible target CPUs are nohz_full and
> +	 * smp_call_function_any() is used, keep preemption disabled to avoid
> +	 * the cost of reenabling it twice in the same read.
> +	 */
> +	cpu = get_cpu();
> +	if (cpumask_test_cpu(cpu, cpumask)) {
> +		mon_event_count(rr);
> +		resctrl_arch_mon_ctx_free(r, evtid, rr->arch_mon_ctx);
> +		put_cpu();
> +		return;
> +	}

This fast path code is a duplicate part of smp_call_funcion_any().

In nohz_full() case, the fast path doesn't gain much and even hurts 
remote domain performance:
1. On local domain, it may gain a little bit because it has a few lines 
less than directly calling smp_call_function_any(). But the gain is 
minor due to a lines less code, not due to heavy weight queued work.

2. On remote domain, it degrades performance because get_cpu() and 
put_cpu() are both called twice: one in the fast path code and one in 
smp_call_function_any(). As you mentioned earlier, put_cpu() impacts 
performance. I think get_cpu() has same impact too.

The fast path only gains in none nohz_full() case.

So maybe it's better to move the fast path code into the non nohz_full() 
case? With this change, you may have the following benefits:

1. No performance impact on nohz_full() case (either local or remote 
domain).
2. Improve performance on non nohz_full() case as you intended in this 
patch.
3. The fast path focuses on fixing the right performance bottleneck.

> +
>   	cpu = cpumask_any_housekeeping(cpumask, RESCTRL_PICK_ANY_CPU);
>   
>   	/*
> @@ -554,6 +579,9 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>   	else
>   		smp_call_on_cpu(cpu, smp_mon_event_count, rr, false);
>   
> +	/* If smp_call_function_any() was used, preemption is reenabled here. */
> +	put_cpu();
> +
>   	resctrl_arch_mon_ctx_free(r, evtid, rr->arch_mon_ctx);
>   }
>   

Thanks.

-Fenghua

