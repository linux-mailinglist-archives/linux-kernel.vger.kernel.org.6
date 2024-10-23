Return-Path: <linux-kernel+bounces-378863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D939AD66F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1671F22843
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4281D2207;
	Wed, 23 Oct 2024 21:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R7XHNo9x"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C8F1CBEB5
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 21:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729718108; cv=fail; b=f3OQZoNoFgNLaVJvj5iYD8o0OoB4IOQ/1AaG9ngm4U5DtyfTFZ3T2c/LyA6xvKtCZMzc4ZQ9ymnhposkDhItLtADyksaYVpzYL2TcSrkmYhjfalASoeZB6fN1yvXT0F9oEvKvevHBYpqGj3NIo+7zaSsCjnV077ZjVZk6aIeMAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729718108; c=relaxed/simple;
	bh=kFuiahsLz/VUJMtFnVgelU3isJNLM9zckzylj7+DMq4=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c7nOt2A/0ESjCsdZUXHKCzGtMta5soTNMpuJWkBs9rTdZzfLieLfBZcPZGE2jgJ92dIRXNxPmzJe3fUBk+4K2jPa16dxmHRLXpVWQwxsryJjHqxxEnjCn3R8avU0PSCa9NaLV/aSdAErgHcY2ug3wMA3SbWqOJsHFvFgvDgv+OA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R7XHNo9x; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729718106; x=1761254106;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kFuiahsLz/VUJMtFnVgelU3isJNLM9zckzylj7+DMq4=;
  b=R7XHNo9x0LrzwPOvAceP6dV/oNgTUB6zLGWeEpBOP590not3mKmBuFqT
   GUpU3wAGVldnc+Hdh6BNg2XwZS35RGabZrPRp8E1i81cSAkxFIqFJG9R4
   /jYF0qrHOjf+zafBxV1wGjYurpRHO3dDx46qHVFnhyCjod/iXyfbyO2yN
   tslsOx3BwUrAL2hW2/oBS6kGm4zx81uBGBTOknkGR8XxzqBMGG0bvsTGf
   rDyE+FBma6MUeu8WuAwqsXWH8Nf9K3UgjJ7xNt6dlARkoenppPtscJYIb
   WBWSIDkxFshLv63bGIPj23/sanqz7WbOYvEpU/NZFGFosYUyrsZO2E5GY
   A==;
X-CSE-ConnectionGUID: zigZEGzWTUKeorxWkSmJ7w==
X-CSE-MsgGUID: 2s3mz3hlRpqinqpCS2ckJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39875456"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39875456"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 14:15:05 -0700
X-CSE-ConnectionGUID: RlY/1S+XTfC5xRe6Rdx7QQ==
X-CSE-MsgGUID: fnpPJbGlSWOkk11/7S1gBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="80699067"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 14:15:03 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 14:15:03 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 14:15:03 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 14:15:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AO+A/Ph4V5KCZ+Vd29cckdyUwccxkE9iuGNZd7iGWEpEuzuK1+kP13WbTjJXr/JUMZY0/056sF5dbhzn2fZpvo8UNoUUyugLMVy/RtuK2aGT9ekzv7MClPSK7LpBbMT/0cujp0iGZELhVnnKxgYDCUS2Vry/VPqKzd6ktEH9NaxpMrkXBA+UATbT1II7iST+uy7rjNQs0J49ZtecbheEYIjua3vIA79QP4SMzYTPLfPfjlY+zapEU1LRShfhk1WfIpqdVISec+u4QIBoLqHGIQhysJb7R5aufRV1iV03xBYGhw0vbbD4q2lFh9PpQfcmKHXwh3OzkFeO8QGu821FSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=go92QFL1+aux56BEEQjIQErQbHU+TEBb2GF+nLxETzY=;
 b=LCyzCBh2ALcBhk84UyXF4ZmsuQIM9OQw7WOP9GmfE/tvZ17BPfaR+bImyVaBeC34AQZKit6yYCt892av5qebW1YnfXOt2RBc1i2eGI5dfkgPj3ELbVvORqj8N+RhHn+1hN4UqeYohZUICH/NPdBRMbvshl070PNCjcqXIgmP0NUJ2AVCjGxb/Jc44LRwnivl3OdhDGJy9vgCt8a5eQvZEjDHOwjjpwHwCIKM9qmQdMabqBEIJVoR6Wjz8A8/p2fC+dlSkAngUNZGKdWOPmIC4WoaMZS5LJ5M9FasbueuFdFrsihfdNfpSvLEMrpBbrMEFi4iHkzAzck8OpIZhBNShQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH8PR11MB6830.namprd11.prod.outlook.com (2603:10b6:510:22e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 21:14:57 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 21:14:57 +0000
Message-ID: <8d035aca-b417-42ab-9c42-759c2695b45a@intel.com>
Date: Wed, 23 Oct 2024 14:14:55 -0700
User-Agent: Mozilla Thunderbird
From: Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v5 07/40] x86/resctrl: Add max_bw to struct resctrl_membw
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
 <20241004180347.19985-8-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20241004180347.19985-8-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0315.namprd03.prod.outlook.com
 (2603:10b6:303:dd::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH8PR11MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: d2679422-125b-4a97-42cd-08dcf3a7bf7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2dhQksrK0JMU2NXUXNsbW5Sb0ZWeTBRZTFnTTF5dzFBYlZVTHVVUGlPWllE?=
 =?utf-8?B?ci9CZWpzNkw2QkxJUXEwTjMybVNVcW52OWJiMTkralVvZkMxekN1dmZtL0xs?=
 =?utf-8?B?NldZeElhWk11S016Ynk0KzJHWlVXVXl2TW9TM0tPYk1LK201OGpmMWFKRnY1?=
 =?utf-8?B?RHQrUElGbmFFWXhVQ2FBSWN2dWhWWHJsSkJRL2FTMmZEdGprU0Z4ZndrZkxZ?=
 =?utf-8?B?S2IrOW9rNldHbHBBNmxmUm5Za09OVG1NanBIQzVjeGFEeXJKVytGNTZ4Zndl?=
 =?utf-8?B?MnhNZDZ6RHFnWXFLd0xpWFJMOTIzNkJOUmJCc1hFZUZsNllxK29SY202VEJz?=
 =?utf-8?B?TzdWWUdmSWc1VC9Cbkx1Z3hnZGtZNVBFRkI5eG5pSXFZMEVjZnd1UlFkRTRy?=
 =?utf-8?B?RjBVemhweTB0K1o4WmZtQ1BRRTIyaXpZTnk5L0oxQWJnUjFib0tUb0Npc2hT?=
 =?utf-8?B?OTkvMFJrb0dPUHdoOWZxYjRWRWROL29tUVF4SzVBQnlRYjloZDJxNVNhbXRO?=
 =?utf-8?B?Ukw1dGZMZkRMcGtBaGdyUE1YQ00rUk5pd1NtdmNRdGF6NURKRWc5VUtOTXZW?=
 =?utf-8?B?Q2FiUTVJRDUrbTVGUnE2YSs1OEdSZ0lJWHU5YTN4TnBtNGQzWTZiL28rYVhV?=
 =?utf-8?B?aGxleUdYYklPODlSSUZqNHlGWVpGZTY2cjYvMnM1SC82QTc1SVZTY1liN0NE?=
 =?utf-8?B?TlFybCs5WWNlUng3QVFnSmhGdU5oZ3ZKNWFHdUtGSHF5T2V6LzFvRDNMWFJy?=
 =?utf-8?B?ajFWVkNLdFFrZWtWdTBUcnVNQjlGQlpJQ2JOQVJBUzkxVTQ1dTFjamVzTWJM?=
 =?utf-8?B?cHArZWNjSm5qdUFDdk1ZNCtYbUFRWmF2a1pSbFNwSDVReFgrVmJQVDB0TnFo?=
 =?utf-8?B?ejNjOFdZMm1DRmFlZDZVbUZWMUhJN3hvSmlVcGlzeDByUnB4NEtLMzdRMnFh?=
 =?utf-8?B?ZkVubkQ1VE1Tam9GMWE1Q1pEU1hTVURyc09XOFNBcFlaVTdoblZ5SEh5RVRP?=
 =?utf-8?B?alJDVTdyYVIwLzJuVnhsSkYxc011TFJGNTRzSlZ6WkNxbCtpS1NMa1duQyt2?=
 =?utf-8?B?SVJpdFlHVEtYYU9Dem1FdzlqaCtQQjRDbnZXY08xaGRmYjBpSTE1cHVxSThi?=
 =?utf-8?B?U1VjQkl2blZjL1M0SXBpTk5CRVBmWlhOVngxbWVKaTdCUmVsMWVQZ016cDNV?=
 =?utf-8?B?YW9vN2s0Z0pkdGxpbjVFbGRSdms5d2Q4RzV3THJtQXJxbHZieWZvY1hFVWs1?=
 =?utf-8?B?SVRIZDZFNnJ1YlNJK0ZGME0wbG5zTUdvNU1mVjhxTHd4cHRiNVJLbWpSeWRX?=
 =?utf-8?B?ZC9kS1NrUkNyYlllOFlTZVJOM2NtYml2SnVrSUxmbDZodkhSMTFTOXZmVENm?=
 =?utf-8?B?U0pjR3JQbXlZNUVxdkV3L1NmZk55ZDkvUDlxbHREUzFHdnAva2VoZmV1QmhY?=
 =?utf-8?B?NndyYTA0dW9hTEdaR2lFTFFLbzc4eEhlSFhxY1pyd29DZ2pha1UyMUMvbHd0?=
 =?utf-8?B?YnQxYUdLcmZzeGNyNFdqSzJBTE4rWlFhZkJoaG55dzloZUhUazJEMDhKNXho?=
 =?utf-8?B?SFhXWGZTdEIrdHdFU0dyWGhtcW9yOTAvSU5uOXUwQnlwSUhxMDVuSzRxN1gx?=
 =?utf-8?B?TXpoYmtqcDVhVEtaMGY0dUlWOUlHdGlLRmN5K0plZlFSRGZ2d2dUQWlNVjZQ?=
 =?utf-8?B?eUh5akRDQ2lTdnRubEl5Q0l3bHNYQklkR1VCU2wybFI1Nm9hd1YrNEtKMDQ1?=
 =?utf-8?Q?qwtyzVbnCwh/sHxzMoIOpHTM/rws0zdYTLP7a9V?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnVmTXAvdkY0OE51NDNBcHVlakZqdnZSVVVWemlDUHdtLzJ6cytjcHp4R2sw?=
 =?utf-8?B?OTF2dC84bnFtdzFqQ1J2VXBkL1FoQ3lua1dyVEZVc0JKVWZFMTVUVUJWSjNU?=
 =?utf-8?B?Vm1iZHc5eVo1cm1meVhvSE5QbEYxcWg4OEQvdTdOeXgra3RoRFJJMTF3VDV0?=
 =?utf-8?B?K3hFTzlZUEc3T29wVVBiYUMzMTZRcVNydWhxZ2NRTGozQWdWWG53TEJSN1oz?=
 =?utf-8?B?bnl1TUVPQ2c1OXd5aHhWaXZ4K21GeUN0UGlBN3lGTWxFMHprVzdrTVNhamZt?=
 =?utf-8?B?UmNzcVI1TFUvRWVoR2laNTFwQWo5UTk0NmRiQ3NINGJLT0JOM1BjTkdDK3hJ?=
 =?utf-8?B?VC9hb1lsVHRMN0luOUdtd2Mydm1FTzlvb3FKQ29PSmF0b3lGKzA4emhaZFdE?=
 =?utf-8?B?MmdOV25MUEw1WXFNYXpWMGtWM0FoOEpzeVNxNXJUWUF4dTFEYWhjeXNtOUpi?=
 =?utf-8?B?dXJqMktING52SjRwT3NTbmhVOFd6ZHpuWlR0UHBheEVBWGdLZWhPMkdQdC82?=
 =?utf-8?B?R2EybHh5S3dFUGVSR20vT0VHZU53UWJFN0wzdTRKc1M3UWRsVkRjOS8wY2c1?=
 =?utf-8?B?SEpBY0paeTRaMmJkZ0ZSNnhOSUcyNFUzTG44aDBmSnBtV3lnM3BkN1JKeGxV?=
 =?utf-8?B?QmwvZlg0ZTJIS2FNQ3p4MElHOE1mbkg1aC9KRnQ4bWpjaUJVc1lYaENaZzMz?=
 =?utf-8?B?SjFqdDZ2WDhmVzBtSWJxYnJ5TXR6Y0NJWlp2eFpmRW9oMW5Ib3hiK01odkIx?=
 =?utf-8?B?amNMalZ0a0I3ZTV1TGRqRy9QU2d2dDYrL0N5MHIxSHNIUUJtTjBFYlZzek9L?=
 =?utf-8?B?QlZsZ29yQU01VVZyY1hJS09zSXRwUURNVUJmZTlYM05MelpYcmZCcWI0cVpG?=
 =?utf-8?B?YXZ0dTNwcXNFaFUxSW9EMWxiMGd0UTE5QW9tVXJYR1hBaS8zTXJGVzQrSlQ3?=
 =?utf-8?B?WG85anZnUGI3NmxyUzFENzh1YVA1aVM1Y3F3d1VpNjNHL2dQbk1NMU10WW5Q?=
 =?utf-8?B?MWZnNDcvdnZEa0RnbkxtaXJxdnF2dS9ibDlzTDY0bnoxTmNWekdjVEpvclk4?=
 =?utf-8?B?cVU2ZTltcExUUStEV3J4V1kzRWxiRnZlRkYycWs5MzllTnBWMGpZcFZHVlRM?=
 =?utf-8?B?RktjOHZGb3VSMUdVejRaQ1ZxbEt0SGRpNE12WGVJSmdLWTRiYjdIVTB6L0ZJ?=
 =?utf-8?B?a3hPR0ZjUDUvTm1PeGkwTlA4R1NUdDFsc3JzUFFrY3MwdDQ5Z3pVdFlwZVdN?=
 =?utf-8?B?dVltOWxUaTRlM3N2NzhUcGFQdmVjc0Y0RVhwNWRrQW5NZTdmMURvNWI2NEpF?=
 =?utf-8?B?SWZ2UjR3UlZCdy9zaEltNDRFVzYxRHl5WFB0QVNudzkrNEg2MGU1cHhRWVNO?=
 =?utf-8?B?NVNueXBJc25LV0hMQU13QUxYNnBKeEtwbkJhRmNVdTN3VEZiTXN0S1FQakZR?=
 =?utf-8?B?Sm1nbUNJZ1JHeXNlQVdxZzNHZ2plaXpjYVpKVTlWU2tHMWpSeklOZnhJQmhU?=
 =?utf-8?B?UkNtU1ZQQ3RsWU1hdmpzNVoxU0VPVEVFdjE1ZE5qWFBkaDFvR1llUGJxdzJD?=
 =?utf-8?B?Y1VPL2ZuZGZHblNWVFJtU3o4SFRqR1hhWUhYd1pCTHRZTzRtN1pjalozczlv?=
 =?utf-8?B?UjhKVXY2aGpsMHZFS2RKZS8xWG90SkVzQW1kTDRnVjl5YmZOU3hmbERnKzZU?=
 =?utf-8?B?RGQwYUNNclZFNVpjNXRsTTNRMjZXVjI0RzF1cWU0eG5WNWk2elhycTBPLzRL?=
 =?utf-8?B?b3g2NHVuMEUydWhYb1c3NFJUNVlsUFdicnJQMTltQUFuSCtLMFZ6YnNNcXR3?=
 =?utf-8?B?SWdaQWdnS1RTVGZBblR5OFlHY29KOFk5bEgvS2tQeDI3aS85bHBMQS9tcE5l?=
 =?utf-8?B?RTk2Y3ZVWkdoWjFVSXBISW00dmhNL0R3ZDM4NGxxVzlPYTJLT1VDdURaQTJZ?=
 =?utf-8?B?eHBtbGFmTzgxNzlnSVpna2lPRllVKzhXVzhSNUNmU2hqYVlwK0FBbU9aSjM3?=
 =?utf-8?B?WFRXQklyT1YzaktZek1nUDZhblMreHhmc3c5ZkZNMVNXNHVLS0JKVDF5VFF1?=
 =?utf-8?B?M2ZObGJMcE84QzVWSmEzc2JVZUh2clR1azM0Vk5kUjgrdzYvT2JINTY4Ynpp?=
 =?utf-8?B?blFkelpzOXRDVERWN0Z5MXpKdVJqTHVLUy9TckhkWDNvUWxYclR4Y044WEp2?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2679422-125b-4a97-42cd-08dcf3a7bf7b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 21:14:57.8465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xMSz2Pt1GuelbfQozkrP2ioIYur+IkT0q5iJjFojQUxBdNgmY9chDFGrRzYAoK3TInypeD/oJ7K4FXOXJ83VwEOlFYItDES3kRZrT8kaJ2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6830
X-OriginatorOrg: intel.com

Hi James,

On 10/4/24 11:03 AM, James Morse wrote:
> __rdt_get_mem_config_amd() and __get_mem_config_intel() both use
> the default_ctrl property as a maximum value. This is because the
> MBA schema works differently between these platforms. Doing this

The schema works differently but they can still use the same property
as maximum, is that a problem?

> complicates determining whether the default_ctrl property belongs
> to the arch code, or can be derived from the schema format.

So instead of Intel and AMD both using default_ctrl as a maximum this patch
introduces a new max_bw with both using that as maximum instead.
Unclear how this change fixes the unclear complication.

> 
> Add a max_bw property for x86 platforms to specify their maximum
> MBA bandwidth. This isn't needed for other schema formats.

It is not clear to me how replacing one value with a new value that is
used in exactly the same way addresses the initial complaint of complication.

> 
> This will allow the default_ctrl to be generated from the schema
> properties when it is needed.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
> Changes since v2:
>  * This patch is new.
> ---
>  arch/x86/kernel/cpu/resctrl/core.c        | 3 +++
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 9 +++++----
>  include/linux/resctrl.h                   | 2 ++
>  3 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 4c16e58c4a1b..e79807a8f060 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -212,6 +212,7 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
>  	hw_res->num_closid = edx.split.cos_max + 1;
>  	max_delay = eax.split.max_delay + 1;
>  	r->default_ctrl = MAX_MBA_BW;
> +	r->membw.max_bw = MAX_MBA_BW;
>  	r->membw.arch_needs_linear = true;
>  	if (ecx & MBA_IS_LINEAR) {
>  		r->membw.delay_linear = true;
> @@ -248,6 +249,8 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
>  	cpuid_count(0x80000020, subleaf, &eax, &ebx, &ecx, &edx);
>  	hw_res->num_closid = edx + 1;
>  	r->default_ctrl = 1 << eax;
> +	r->schema_fmt = RESCTRL_SCHEMA_RANGE;

Stray change?

> +	r->membw.max_bw = 1 << eax;
>  
>  	/* AMD does not use delay */
>  	r->membw.delay_linear = false;
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 8d1bdfe89692..56c41bfd07e4 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -57,10 +57,10 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
>  		return false;
>  	}
>  
> -	if ((bw < r->membw.min_bw || bw > r->default_ctrl) &&
> +	if ((bw < r->membw.min_bw || bw > r->membw.max_bw) &&
>  	    !is_mba_sc(r)) {
>  		rdt_last_cmd_printf("MB value %ld out of range [%d,%d]\n", bw,
> -				    r->membw.min_bw, r->default_ctrl);
> +				    r->membw.min_bw, r->membw.max_bw);
>  		return false;
>  	}
>  
> @@ -108,8 +108,9 @@ static int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
>   */
>  static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
>  {
> -	unsigned long first_bit, zero_bit, val;
> +	u32 supported_bits = BIT_MASK(r->cache.cbm_len + 1) - 1;

Same issue as V4:
https://lore.kernel.org/all/ca528ebd-fb76-40cd-a495-88c2de443cd8@intel.com/

>  	unsigned int cbm_len = r->cache.cbm_len;
> +	unsigned long first_bit, zero_bit, val;
>  	int ret;
>  
>  	ret = kstrtoul(buf, 16, &val);
> @@ -118,7 +119,7 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
>  		return false;
>  	}
>  
> -	if ((r->cache.min_cbm_bits > 0 && val == 0) || val > r->default_ctrl) {
> +	if ((r->cache.min_cbm_bits > 0 && val == 0) || val > supported_bits) {
>  		rdt_last_cmd_puts("Mask out of range\n");
>  		return false;
>  	}

The above two changes have nothing to do with memory bandwidth. They are unrelated
to the changelog.

> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 0f61673c9165..b66cd977b658 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -165,6 +165,7 @@ enum membw_throttle_mode {
>  /**
>   * struct resctrl_membw - Memory bandwidth allocation related data
>   * @min_bw:		Minimum memory bandwidth percentage user can request
> + * @max_bw:		Maximum memory bandwidth value, used as the reset value
>   * @bw_gran:		Granularity at which the memory bandwidth is allocated
>   * @delay_linear:	True if memory B/W delay is in linear scale
>   * @arch_needs_linear:	True if we can't configure non-linear resources
> @@ -175,6 +176,7 @@ enum membw_throttle_mode {
>   */
>  struct resctrl_membw {
>  	u32				min_bw;
> +	u32				max_bw;
>  	u32				bw_gran;
>  	u32				delay_linear;
>  	bool				arch_needs_linear;

Reinette

