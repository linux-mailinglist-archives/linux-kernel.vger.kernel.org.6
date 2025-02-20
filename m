Return-Path: <linux-kernel+bounces-522754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A66E2A3CE33
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95AA5189C692
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF39013BACC;
	Thu, 20 Feb 2025 00:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BYJ45Dvl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62802AE6A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 00:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740012202; cv=fail; b=r8MkEhZoWKA15pBZ1+S1lj/syjOuSf+zxv7hfsfXUMVpnJ1KhuRIH0uVr/FjKVi5J07gtSi9nh4fCBV3ZUEZ67zgjPGRAvniKowsaanQ57mcSmPq0iR5O9C3Gzt3rnhHSzjVdjF7S+d3GD0z2ErJZY/CUmnygflFUtF3OBbNt6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740012202; c=relaxed/simple;
	bh=RUVRxBrvQ6h3zJlGzcMxLkJmfy1wdryxJW0yfvSESI0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T/jnPMX/adOkx96///Qa+9pj5jDv1TDWJtcEoHDejQwUB/IucTq10aoLIoHZChv6WPGzCS5znU/6ZLub7dWP5L8QGxur5DvC9lNZ4cs3X2PrAEpR/Evj+bhV4BsOdPAcgNLwArlsjA+Qd/gahUD1dwFiNUTtWctu/8RZuRJnHTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BYJ45Dvl; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740012201; x=1771548201;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RUVRxBrvQ6h3zJlGzcMxLkJmfy1wdryxJW0yfvSESI0=;
  b=BYJ45DvlvWzilVr+dHGFpiMMbrK4UhPlSN+MCBNQyEjrBavRcvPWd7bV
   hc9Bk8tlKWq2M/hIKOADxu81Nx9BARyQe/3EN0S+tGeG+mJ2kYL5YCiE7
   VdeNZWe2MQPQLzdA02vmnxTwV8+4pZnOjdRVypbpdKHjdLFxstKqsesba
   R3Lwg7X9cgBJEMYyWAua2ei3/ROnjLimgFrTeDN+ZU+i2em8zYL2XwpMl
   p7iKd60Hm1GxEdx1URACkDCBl2bWg6G/x4XP8o9M/xB8zMVU/CVRTFHxd
   jCm4N+y85GlmMJbAcavHMinHFrPtPcZGJcxCH3TdDpWT30dRugn7hR1C/
   A==;
X-CSE-ConnectionGUID: NfOqeRe6S3aSqLknewuthA==
X-CSE-MsgGUID: 5zaUZkycRV2unPr0CpgbSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="44422696"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="44422696"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 16:43:20 -0800
X-CSE-ConnectionGUID: RKoVLrvjTriO7/s+/IjBaQ==
X-CSE-MsgGUID: g2HdImewQzyc8ofUj8w+Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="115554800"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 16:43:19 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 16:43:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 16:43:18 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 16:43:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SC1Ep9UHXWs0gqZ9/1z373UbQYR0Ff2KMbDSze26Q5w8afzIPJWr1kkuRzBiToVNjpF9cc6f1aGZe5x6HI+AdbEj05JCVr5K2km5AWWB8+ilDhLFjWGQFdGNbDd7h0BoSLxXrrBK0B8NPlIXY8SOkdi0Po9Ofjv0TXyjD6TpCWED3khbOXpggBXG4HIR2SNnck2ec5rGf1Zti4AuW58XLAHC1wcYIJnCaaoYAGJRhCRXKbUSKPw2fAbVe+lrwGQVOfgknrAJvwiHg2wi3s0wG3HzGjOftC5c/nO8ZXnCqILIwJtO0MhtKVjX6AcztXkF6O0yAVNvdEvE0S4DbkhioQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOxir+nVYM7WvZgmG249F8+1cUSjSNltpxcuIA9iHMU=;
 b=XyFi9TSFeNCNZnNXL0BGKikCLKTzGidMHSWClJnL6/cwsUFVJNRy9sIBkdUd4T5eLHoKxLeQii2KWWw0Rm0C40NCkZAeWxyjZ8kn5HJH8mhcdHr6Qky9xoC+Wh9b0L9W5InprhP+L5NjQSoWoYoPWkDAxHVTfsUEHqnPuyAxD2j3/3PcOaXktj1h7hoKzb0fzdqEGuaBVqbXP2gSHYO+9gVra3kMlc8UWMh3g+1ZNmC9SXDx+ulzvrjuriNUVqHmEsnm5RE9qlAbucoR31nhpmV771lTMOvyu81WjV1jSOon6OIn0tHHoZ047yld1lsZBCVfHQSnlAwa4fQKzP6t6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV2PR11MB6072.namprd11.prod.outlook.com (2603:10b6:408:176::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 00:42:32 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 00:42:32 +0000
Message-ID: <94b7c22b-7079-4b08-863f-0875657ec39a@intel.com>
Date: Wed, 19 Feb 2025 16:42:29 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 21/42] x86/resctrl: Move mba_mbps_default_event init to
 filesystem code
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
 <20250207181823.6378-22-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250207181823.6378-22-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0364.namprd04.prod.outlook.com
 (2603:10b6:303:81::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV2PR11MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: 89b7d626-f1df-403d-a92e-08dd51477629
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TnBvR05KZTJUdmRKZDR5di9BMGtXdG9EOHVhTnB6U1pxN2NLN3Bxb2NXYnZi?=
 =?utf-8?B?ODA5cXRySVJXMkdHUWZiMFNnck1OSXZuYU0wKy9kMzZJeG45cGowbmRqLzNS?=
 =?utf-8?B?dXp0ZFcvMDZ5TlFndjY3SU1vQ1BIaFRJSDBFcFFKMENwUmtPQlo3Ry9oT1Nl?=
 =?utf-8?B?SXVKZnBKKzl6ZXE3VnRSSkhiQTRVZGFvM204bjdaOEwzNjNHVlBZWGc4WU1j?=
 =?utf-8?B?VUY2YzB6cEp0U1JwLzBwazk4VEhySTBoV21wa2dPd2tMdVh6SXFxK3FJUnAv?=
 =?utf-8?B?STF4NytZdndEWVRvR1d3ZSs4eEl1SlhDdERTNDQ5a2dOYlhaS2dyOUhnWTRQ?=
 =?utf-8?B?ME1GaU1RNVZxQWluaU92NkxXWjhrKzB3aU5yaUUwUTBBMXczYzlycSt0YUVY?=
 =?utf-8?B?anZFbExieEFZL0tic1VzdmNMd0VudEM4WUY2SXhxaTlwTzBjT2ZZMjR1YnBr?=
 =?utf-8?B?RXBTVDc4VzhoOXNqRmdZQm4rM1k3S05UNWVnRUdZU3Z4KzlmalpCQ0R5T0sr?=
 =?utf-8?B?TU9kKytTeHQxSklYWUdZVkhhYkw5NWE2d3hSdit0OUtkSUdtMXlIelp3SXJm?=
 =?utf-8?B?ajFhZGp0eFcvZFdFajh6d2ppUVREdXBnMUVlOVdVSldlMjlza2RMb0dnREZu?=
 =?utf-8?B?Y0FpWWNWQnZwTkp6VXVnTjJoY3g3SnZibzNRN2gwcHRhd0c2S3gveFpsdWxO?=
 =?utf-8?B?c1ZiKzhzdnlLampqekJad2pwZ21ibDRSUm5XUXpwcmhIWG92ZWNhbUo3bXM4?=
 =?utf-8?B?a0NZSE51N0ppRllsY1BzcmxXSkRwZWptSlBFQ1NBYWRGSnQvaUNJMWlqS3Zh?=
 =?utf-8?B?Ync4aUdtMmhtRmVPRHA5azZSeWZveC91aEJ5T2dhYklHc2JCNlZ6YkV3dGc0?=
 =?utf-8?B?ZUw0ZW5DajFtWCttM0dhR3lPWnR1SXVUMXRMaXV6by85SXU3dVJ5YUF4M2tZ?=
 =?utf-8?B?RGprT3kzTm8yc2Q2WEQ3QzhDdWdpMlYrc0QvbVZzYSs0NVpsZE9iSEJpMjlS?=
 =?utf-8?B?OEpYbkFjenpBcUhBbzhjR3c2MitrSVR1bUdtS21mdDZ2WUc5a3ludFFEWW1F?=
 =?utf-8?B?QVlEKzgwTGYzZUJiY2pxMFc3ZSthaEdzeFpHbnR5S0oxSHZJc21JMWYvMzY0?=
 =?utf-8?B?NFNmRUhDeHUvSnNJWHRTcXVHd2xoS1R5SEFrenU0NHdSQVRoYjU1YUtCa05x?=
 =?utf-8?B?T1k4c25vSGY0bHh2dkl5WXNUTWNydFc1dWdvU3c2M1ZjbXJQaXptaXRwOUNS?=
 =?utf-8?B?YXRmaWJjRUQ4YVFmTGtOcjhhaHJvaEFmY2pJN09ZdlFLTjl5azV0eFBEeFVh?=
 =?utf-8?B?UUwrN3pteVRlVFpOckhoVmhkUFY5WlE0SDZPZ1lyRDAxcGZnSWxiTk9lWXpU?=
 =?utf-8?B?QXlTZldUT1o4cVU1TmsyMHo5bFFMWUVOdzA0RzI4Y0Q4VDRQNlNiaTR5UGFR?=
 =?utf-8?B?dmlzbDVCQnlwTllzVlNaM0d3enNLc2puSCs1TEdUeXdPajRTUThnQ1lBanhE?=
 =?utf-8?B?L25NZVdhc1cyNlcvN1EvSG5KZ3REeHJmbG1rSER1NlVRUW1BWU1FSTZwLzVw?=
 =?utf-8?B?RG9aN0VlbG5iNFVLQXhZK0hwOTBCeFRpMForS1NqeGxpcDVqWkZnWXBwRlJE?=
 =?utf-8?B?SjA4RmRGcUNQeG9MY0ZjbUVLVExDWmRMNFZJQ2RWa0IrTXhWSmZJbldhdlc0?=
 =?utf-8?B?OFZCTXpWTjZwa1BocDB6RVRzT1ZRNXZpV0NMS1RORHU3TjNvcGFoK0dyYjJn?=
 =?utf-8?B?NDdmMEM1SVQxVld5eDNZZjcyQ3oxb2t1bkd5Z01Memo2L3BRWnJPa0k1WlBn?=
 =?utf-8?B?c1lyYyt4R0N4Z0hsaTdNUDJHaEp2MzVrbWd3ZVFTSmJ1MEF5a3JyVnU0YVQy?=
 =?utf-8?Q?VJzFAif5f1Zta?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eCt6TzNXNDQ4aUVZd1BmWndrN2lVYm5kK0dZaElYdHRCZ1dIOVBlVksvUUJL?=
 =?utf-8?B?dC9wSlJwdWtoV2R2Q3piczNDUEY1U3lwQmVucnBoRVpVd1RqTFdMVmJscXlF?=
 =?utf-8?B?b2tRc0JGckdpOHpWenkyU2hvcW5NKzVUNUgxZ1RGaWJGTE1VT2hkdFdJMWVG?=
 =?utf-8?B?QytkWEZMamV5QTdwLzNRSzB5UkJvQVJYdVR3cVp3cmVmc0psa0xSRFNFWStL?=
 =?utf-8?B?U3VXZnI1NGZFQnYzSzRvQWJXNlYyN2EyeXdXU0RBNHc2U1BVMnRqZW0rYk9s?=
 =?utf-8?B?cEV5UzdQNmUvbHdiVlJMbDlxemlFTmxnU0FVenJKbmFWbUZtZlVTZ255TG5W?=
 =?utf-8?B?NTJaclB2MjZVREFINWs0TDNGUjk4cldNMUpSNmkvRTlEbFluSFVGMDBaWHVr?=
 =?utf-8?B?cWVubTUwejU5ZUcxbEdTZG1acjVKdldiTU9sTVMvekZ5NDIyUi80eER0Ym1P?=
 =?utf-8?B?WE5KbnJVMkZSazRTcUk3QWdJeXAyWHNiTDBveUNPZ1EzRnhBS0xmeFVoQzY4?=
 =?utf-8?B?ajllV2ZoVEV4VEhTOW9WbHlnVnZBbVNaZ0I1ai84Y2hoRUUvb3ZSRW5yYkl0?=
 =?utf-8?B?RkhKVlNLVUFhTTRXNDVIWG4yTnlFbzJ4SWs0MTZjOGN1MC8ycG5VZHI4U2Yz?=
 =?utf-8?B?Q2xYbHZVV1ZTNThBUTZlYnBZMmU0ckZvVkxibG9hV1JUNnl2N2tkTm5ib2Ns?=
 =?utf-8?B?dU5IRkJTR2ZVbEM0UFhDL0svUHVVZ1cwdFFBT05zU0U0NklVSDU0MVhRSXE5?=
 =?utf-8?B?blJYWElaN29xdnRZTEpGWkxHYmNwb3hrY3VzZ3FPNU56SXFIc3BwRTRtTHdy?=
 =?utf-8?B?amxEZ2R5YUIxZTdMclY5UjZoc3ZyVW95VnRwbGZ4cEU3QXQxc0dUcURybis2?=
 =?utf-8?B?K0lQS3BnbGp6dHRPWTNIaTVXcnBzU3NIcWRYU1JObHBUS2g2cW5KeFU1dmJx?=
 =?utf-8?B?ZlgzdXhBdGNvYWVqQ09JY0xmdzVzeU5uK2lJbEMvTXlFZG9yYlJQM0hJT3FO?=
 =?utf-8?B?SFJaeEJNNkpKeHhxbGhuMUZoZUM5QW5pRGF6bTNzWllCTG45RTAra3drKyt6?=
 =?utf-8?B?YjI2NFE4R0JTeHVvblV1NFBwYm5FOXBGUnNPeTk5cTIxNnQySlE4bnRsZm4w?=
 =?utf-8?B?TTFOVFNsTXc1Nlg0Zk56Z2VDQm9DbGpNTkhiTy9SUHJSQ1lQU2NUMzR0ZVBW?=
 =?utf-8?B?cGZJd3kwQkpEMkhYTW1lNUh0R1d1V2xHOXg4RkY4ek1zZ1liaHhBTW9CTFhO?=
 =?utf-8?B?NVFBVzFNd0RzRWdzMExVUkZDeHdGQjVDeUR0NVF0eFdNRmlBTE1tZGRzanU0?=
 =?utf-8?B?NC93ekp4bDRMWnFHYTNhZmJLeThDY3hVUDZGRHIvWnNtNUNxUytlWlhpU1Fl?=
 =?utf-8?B?OWhkTFFkNW9QTVU3N2wyanRLbE03WXVTdE9iOE5oWm9mR0hHdytkZEs3MmN3?=
 =?utf-8?B?L2V1NEJOQm1oM1pWa2thZFBQRlEwV2wwNzI0c09TWFBkZUVDejkxSHVLYVR4?=
 =?utf-8?B?cFBQK2VXWmNkSkZMcUl1dC9XU2FuS0R2WlVmTVV6azVINFVjek43cTJzcURY?=
 =?utf-8?B?N2VYd1M5UlJoSkNBUmhaOUY1aStjZ3NjWkZNQnUxNHBRTkY1TnBsWmNoc1NC?=
 =?utf-8?B?MkY5RG9Cb1JicjArcW54T1dPYS9qdFVOMGJ5L0w0cDVZVk9xblVKaFJnOENa?=
 =?utf-8?B?Nms1NWRQdkE4MW5SRzZvVnRoYVlnTm9KanRSbzN3RnFucjYxaVN6MXJMcmln?=
 =?utf-8?B?a0dIeUx4cnJ3Tkk5Z1d5VkpwSzZsVytGbHBnZ0FPSTcvSThCVTBiTXppcERt?=
 =?utf-8?B?TzZ2TjNVZCtwMzdmOXVUZjUzTlpORlZyYWdPYWhzZ1pQcHg4a3BjUjBnUDFj?=
 =?utf-8?B?L2ZnbGhJclVuTnJMcFRtZjM4WHovcDV3MnB2c0ZKMkFVeE9ZZUlzZU1YbkRZ?=
 =?utf-8?B?WW1LUjBvZVRaWXVBRzVKMnBWQWR3L2ZJNFB4azVSa0RsSTVtelBEdXF5UWNB?=
 =?utf-8?B?NHpXMGZhTlZBL1d3T0RHb0xrZHcvcXlZYmhOV3pVVkluMHRvVVljMnRKRklu?=
 =?utf-8?B?aXNFN0dKSS9EcjBwQVJQdkpBUUZIdUd0UHNXNVhSSndyT1ZLY3d6a2RMOVYr?=
 =?utf-8?B?NHhuSmZOV0g5bjAyemdrZU5lYkIrb21KZS95V2VndWNPUm9lczdoKzc1dmlw?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b7d626-f1df-403d-a92e-08dd51477629
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 00:42:32.4699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/ExGdac+uGlzN+RKrpHEJ1KlVwVSzKuD2VP6TDB4a8d2eGVKAtB5MZThAtuSMdlexjklA3G3gDdrT9XdOUV88zw3VbothA6vdEu3juidys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6072
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:18 AM, James Morse wrote:
> mba_mbps_default_event is initialised base on whether mbm_local or
> mbm_total is supported. In the case of both, it is initialised to
> mbm_local. mba_mbps_default_event is initialised in core.c's
> get_rdt_mon_resources(), while all the readers are in rdtgroup.c.
> 
> After this code is split into architecture specific and filesystem code,
> get_rdt_mon_resources() remains part of the architecture code, which
> would mean mba_mbps_default_event has to be exposed by the filesystem
> code.
> 
> Move the initialisation to the filesystem's resctrl_mon_resource_init()
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

