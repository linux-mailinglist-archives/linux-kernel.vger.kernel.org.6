Return-Path: <linux-kernel+bounces-547262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DB9A50510
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44011885CCE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1A718DF8D;
	Wed,  5 Mar 2025 16:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xdpeiy1U"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875F2FC0A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192537; cv=fail; b=YC6gmEgljWJr4vzbLF1R0pbPYari6tdpKTCIcrpiCjhwaakOWCIglzs28TissoxcjbImo6LVOMxsC6Z5we/g4QoAfkT4jYN5GY69ZI1DIc6h1GvtDU1wA3KiIvvgdNX04/QXTgIQxJHukpBwgp1r6sjIMNZKq2h/ZPj0vVDum+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192537; c=relaxed/simple;
	bh=NkhNrih/GdI8c2um+MwY06MddTBtrsuhmHmeNmfmpQ0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QlZqXpBEHqBwXAkfe3Stt6ua153JPTmv4/KTVZVHLcL2io8ddGvg+VeOtFaG839PwOa3K7TnnN2NdobWZv4seceLBbAg5ljW2pS9U3eAG5CfAHtKryForP7R1R70Jb/qlqjUIB3dOI9jM9lW1Y/pf1rub8MOc6tfaQHTyLM9UoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xdpeiy1U; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741192536; x=1772728536;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NkhNrih/GdI8c2um+MwY06MddTBtrsuhmHmeNmfmpQ0=;
  b=Xdpeiy1UrmjE6o5pTlLAQHA9snIte/TErpx1ePy1nEYbttqEr4K97g2y
   hmdRxFjYQ6RtcQNjSjr7CPDO+Vg1M7UK3Po+bQAuLWSbcCW4fieI+N/o7
   EW5LWXUlgZoIjZ9bOhr+39CflhkbnbW2BTM9sQiY9d0K/aB8Cq4gd77cg
   u3Nxn9kD/1DJaFZfM/EsLTucngIpXkv6n4M8B0sBhL78t9GnYmsWQje6H
   PkXdUYWuoAqFolqdbA+7Sxp4QZdNL9OZzE0YK9bWM8EeF/17kxHbDLkRp
   HgbgxIx2tcbP8aHjz2ntXIO8LiNxJVkJLd9ViwR7KLlxP1zUrBOejcep0
   A==;
X-CSE-ConnectionGUID: 9gR1ltbhQeOk/w3KNaLlbA==
X-CSE-MsgGUID: AwrddikURQibmecfkT/FYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41414077"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="41414077"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 08:35:35 -0800
X-CSE-ConnectionGUID: LI1C+aUgTl2j3jAOzY7UZA==
X-CSE-MsgGUID: P0XrvA0JS1eGma5gSA0Bjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="123660266"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2025 08:35:34 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Mar 2025 08:35:33 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 08:35:33 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 08:35:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RK7tcc01pLYOo9tyuNzeChO78F/G4D532QaBTF0VjLpxs0D1kWVHPabSGpIi40BAEhqcE/bG2a/leq1BBlfJjqX2z3EmspBpXkJoP3HrvjaHbXfpXDrO0KWhuZbqwwFViWSWhtujUlPnC9wIAnuYyEzSF0/uv6qPqXEC4m/YV7KlYbaUbrLRaxyK1zRxMLs7VYSY+dJt8jQ2FhI7zk6FqGSI6diCPQLovxrkl6up0jKvUo+3Tf7cyxTlBSlA3llkh5IMWLUv1nCz6ihZdI5pbwBJW2yFsYDxPpwHO5khiLjVCTvELfHoRSJekTzBuVeiyw7uSFFg9lQo3B2w91mShw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oG0fK9J2J5FphMp7VRUo6ZoR51RZVU9ZFU3uXIFNFtM=;
 b=rbPy/PSik+D2MNfDsqQTgt+3gu/VQwMFiOgA/PNr6SvasGikg8LPzPTBCiyxuDJT3Hb2GVnYQzUybx30gEmHTNGLc9objnU6lknW7G1HzcRAvU09tI4JVo29E8yFw1inSiyX2MTp2RE9mIBHZdSaS3cAjSrOOv1Pauw1khxBlKKlLXEYaIdC+NnsCuduyh8HUSotHVJu0QXsxzszSxGLY8UGM6FhXHKcIkYpu5XclPoN96Bwi1FUIDWRbnTE83j1fJabaCKL41WVAfEJDTwGEMWRQJBO943yYJDTPowcexh/NKzp+vJirMc00cHMtHkqdSQYetH/a48kQPJjyvLHzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW6PR11MB8392.namprd11.prod.outlook.com (2603:10b6:303:23a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 16:35:31 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 16:35:31 +0000
Message-ID: <372da3ca-c11c-47c7-bf9e-c2fa0a91a1b3@intel.com>
Date: Wed, 5 Mar 2025 08:35:28 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/49] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
To: "Luck, Tony" <tony.luck@intel.com>, James Morse <james.morse@arm.com>
CC: <x86@kernel.org>, <linux-kernel@vger.kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, Shanker
 Donthineni <sdonthineni@nvidia.com>, <fenghuay@nvidia.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <Z8d1AjhSVuS4wRP5@agluck-desk3>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Z8d1AjhSVuS4wRP5@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0106.namprd04.prod.outlook.com
 (2603:10b6:303:83::21) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW6PR11MB8392:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bc8d154-061f-48de-7c21-08dd5c03be8d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MEt2Yi9EZDlLYWhja0FFaGJNczhkUkJvb0wySElXQXd1UVRJRjRMZG4zYmY5?=
 =?utf-8?B?WC9lWHVrSHhybVZBVDIvTnVDb3UvL3U4YjNHVzhsK3AyNTMrMUZOdnhqOVh3?=
 =?utf-8?B?UDBOVzdWQ21MWVFLSTdFZ2IveGsrVkswMVYvNWpEQnIrelJ1NW5uaEZHdGhC?=
 =?utf-8?B?MW1hQXNQZXRDOVJtUXVZTEZMN3Ntczd5UnErbG4zakt6VFhrMHdZTGEzZ0lm?=
 =?utf-8?B?VCtvb0R1ZzBBV0M1Z1ZsZGsvUXNubkt0azNMaTR3LzFDSjNoZzNhcnZHaEJx?=
 =?utf-8?B?V0RScm9yajhzdUlzN2FxdjdyMSsxM1RmMmtkcnhBQ2VUTGlhZGhMRDlCMkQx?=
 =?utf-8?B?Y2dmODBmdlRPNHpPbEVpM0ZPc3FGNVdNOW8rQVRiWjBhV2w4T0RFdkJPdit6?=
 =?utf-8?B?bFdqLzF5VzNoeUV2NjgvZGdIdjR0ZVJrdXZJeml1RUxGNkFWTGtCcFU3Qjhm?=
 =?utf-8?B?RnlWd3g2UVV3V1htQk82RWcvU3RkOURVcEgvalJvb1MxSW9yVU5MZHVKSnpL?=
 =?utf-8?B?aGhlRGNkVFdoUnJWTisxZlZIZ0tORmdaZ1FyTjRWNFl2dFVnRWlFQ2VFYVd0?=
 =?utf-8?B?bnFqczhXL3NBN0RsRGxTMHFESU9XdEx5UUh1MVNHdExGZXh6Qmpnb1RSTklQ?=
 =?utf-8?B?NStPNHNEYTdZelMwTGVXdnREeHN0SUc5ODZXb0hHbFVPUmZhYjBESDl0Zndk?=
 =?utf-8?B?VlJuM3llalNwVHBLMHUxZVJpWUVnMXFTcEdoMDhpSGZzZEphRlBoTWJXTUlD?=
 =?utf-8?B?a1lYU3NWQUhoS2pyeFVRaXFBY1hJU0V0SGlJbzg3QmtTazFnS2hrbVhVd2ZY?=
 =?utf-8?B?cUFMSmRxM2JyNWJXQjhhbEp0aUpuMVVxb2tqR2lUWGFLdmlTcnNvOHB2ZFl6?=
 =?utf-8?B?RWc0cmY5NHFFM3NkYVFkTEh0OXdtSmowaUtVUkp5UUxPa05ZcDk0WkdMeVlq?=
 =?utf-8?B?c0p1Q2pHRzVYMGtDQnN4SjJsaHZyQkpmMjlMaDIwRkJ6eGNmZEJnbXpRcVhX?=
 =?utf-8?B?L2kzWkVIVzVGRUcxb0xJZTNRUXJZMTZ1SnpyQkxUVXQ4Mk1xN0RTNjgxVXd1?=
 =?utf-8?B?cVlmVU51aDRhb0lqRjZJK3o4WE1IRXAzbHJvQWZNeDVCaUFQN3dMMTlpZnBy?=
 =?utf-8?B?eWhoT216eVhmUTh4djZ0WldUbFVMeDU3V0hVSStLUTFHRFhNWXhCSWJXYTdq?=
 =?utf-8?B?bTAvcVV4Q3REQjl2WEJDb1hhREtJUFJKWmZyUHg2NEhBaGF4WVJqZ3dYYjBY?=
 =?utf-8?B?SWdTaUZKZzhvUnA2WXJxYkc5dUFGWFF3WEI5MHdtUVp5SUs1VkJab2YyMWZi?=
 =?utf-8?B?dEZPZjFlaWJOR1RnSkZMNndFY0t1c3M3UWEzb1JaTU5ONldtQVJsNExaSHdF?=
 =?utf-8?B?bjVMbUt1aGcwZTRFeXBDbTJxOE9TTS84c0xKMTh5TzFBMDExNnF5aEYxckVk?=
 =?utf-8?B?S0ZxelhZTFZFZmUvaUptbVhGMExWM1BCaGI0UDZ2TFI4L0kyTlEyOE9xaU1m?=
 =?utf-8?B?S0JPdzJwQitLWTl1YnRlU3QxbkxTM1BLRVlrYjRQY2t1VmkrZXMzRFRjM3Ft?=
 =?utf-8?B?R0xBWVpnMTE1bS81c0g5VDgva2tRNjBCVWRnSEZ3aDF1TStpSjJ0dlUzY1NP?=
 =?utf-8?B?M2swWVlmQWQ0S1l3aFFwa296bjgzalcreE91M3p2RDY0eUlMeTRmNXNJNW1i?=
 =?utf-8?B?cUk2QzdUZUYvRkhEdjBlVGFwL3VQRUNIYUJLMlM2RmUrYWh2aDdjSmN2cDZT?=
 =?utf-8?B?V0NNa1N4NlZHVWFiZ2xRTnhybnpSeS9wTlArV1ZXK0dNSGhKaHFGb0hiWm16?=
 =?utf-8?B?bzVjSHFtQ0FLMFBhQXQ4dHZGa0xhRkp5TTVJYVZyRWE0NDU3VVBCbmhzeU5G?=
 =?utf-8?Q?yUeDx7Zt0KeAb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDJsaHVmaDdqeUsrdzVYekxoV2ZXL0ExYnhlekxEYll6MXQ0bzEwZ01NZzFC?=
 =?utf-8?B?S2ZXdDl4bG9kOTFPZlRmdStZZ0dtelY2bVhPc2hIRi9nUC9nMzMzSDBTcXlB?=
 =?utf-8?B?V1ZnaGsvaWhOcitXeEtjbktGYjN4S1hGZWJ4bzVDNWExVlIvNGtyM1lqWXpR?=
 =?utf-8?B?K2xtUzJCVmYxbytOSGN6cWJhRUswSGZtc0hrOVV6WlpseFZkN1AxdDN3blRt?=
 =?utf-8?B?eWNHZVhxRzJzN1crbjBac3RQd2YrRzdGcTV4VStrZ3dvOUd3Qi85bE1UZzZx?=
 =?utf-8?B?cTY3K3ZucHpvY0orYXNMSXhpOC90dFcrcmxSNFlmRUR2ZnArQ1l6Z291Tytj?=
 =?utf-8?B?eEpsYTVSdEJWZjRpSWhNOGF2V0xGbHJLOWpFVThFTUF0ajEwcUE1NlJEMVVZ?=
 =?utf-8?B?cVdHMzhWWDJTK09FeG9rQkJBQldmVWdTNVphN0o1TDJkei9zSlVuN0J5TUJw?=
 =?utf-8?B?WGFIc2ZTa0svcU5JdVo0SlhwWExsOTBXYTZXM0ptYzdDanFBQkdWVW1EYXdT?=
 =?utf-8?B?SmVvV3IycXMrTy9QSC91WEJpeVl2dHlWeU9OUEVTVCtHN2E1OUk1WURNUjM3?=
 =?utf-8?B?eTE2eHBoMjJDaldJaVc3K1dSd1ZiWFFPU2tZUG1EYzIyc2Nmcm8xc2xURnJi?=
 =?utf-8?B?bVA2cWxQaHR0VFJNdVlSWVFwUE9iRm1ta2dUdnNBT0hKQVZkc2tRMitMSmxu?=
 =?utf-8?B?NEhHYll2QldJOU83UFZtM1BmTjZQWDQwR2lnakcrS3hwWmoxclFka3oyYjFV?=
 =?utf-8?B?YndSRUNoTjJMV2NUV3hTK2dIcVVuUGxidjZHVXVKV3k5bnAyem05U29QdjR2?=
 =?utf-8?B?MnBNYlRsR3kvQ1B5bXAvRk5NWkRRRjAwYTVUb2NKUE4rZ3dOYVlpSXMwR04x?=
 =?utf-8?B?ZlArUjlodzhlcFVENG1FdXJkWTA3ZlhpS29UdlZOeHFFSjNFL0l4dEY1QnJW?=
 =?utf-8?B?QW9FTmNLU0xFTS9pZzR0bHVlQ0cybU4zRDNoRTdNVzJJVmVtVkpyY0xyeHpX?=
 =?utf-8?B?YjRnYkhnOW9JdGVMREFGK2M5eG81WnRFVGllSG9hQTJ4Z1dNWStyMXN2WW1j?=
 =?utf-8?B?ZDZweGNmWll5dUVzWmdNV2VnODdhaFV1RXFvVnNrMUw4VnVEdXB6aWlDNHhX?=
 =?utf-8?B?Zk10djN4WFlDWTFlRmd2dzY3TjltTjZyVmNvd2t1YUlDbXAyM0txdkxKOHAr?=
 =?utf-8?B?bXNWZkVvM0lNS29xR2lHL3VrRGFzWDhoVk9pRFpYaEM2Q244ZUZTdUIwalZ0?=
 =?utf-8?B?QVBHVmpQUUdQbGFGdDd1VG1SWjRQQlI3ZHhBZjUrRVBKeXkxUFJYWUFPRFdw?=
 =?utf-8?B?anNGVm9tREcrOXVJVXg2UXZmNWRYN0czUndwWmg1dUZjd1lucGYzeDAxSXR5?=
 =?utf-8?B?dXoyRTZwWkRkNXgvR2ZWZldlV29xVGhYZXVNTmxaVjJIRkFaclpHQTUzYU9Z?=
 =?utf-8?B?dnVOaGl0cUdSU2oyR21od3hubkM1NmxzV0tkVjRuTHB3QXN2UFRBQzdTWDR0?=
 =?utf-8?B?ZjY3NGhjbWxRcVcrZ1ljT2VzYzFCd3BKRzB0ZC9LMUJ2RnBCZDBPd2NNNDRk?=
 =?utf-8?B?bCtzV2U0WlRCSEE4SVJ0R3hvSHJSdnRHYklRSWpkaTVKaU96RWZXNTJqejYx?=
 =?utf-8?B?VE1SYVd3NHhrbHJoK2JoREpNZjVkdDRJZ3orVFFaY0p1ZmhGWEJRakk5akxv?=
 =?utf-8?B?QU5rSVQ2NCsrOWFQeHE0WXZudUExSldkVVhSM1RIemgzeTEzdHVaT1lZMlBU?=
 =?utf-8?B?SStpOHI4dmdkamFvNzhkOE5IWHJEZUZSRTd4SFpwSXpwZVZsbitMa3FqcWt4?=
 =?utf-8?B?WXA0WlVocUJMZm1SNUFVc2xhb1BJb1FGZ3lpOVkrY25kSzc4K3ZZeE5zMmpi?=
 =?utf-8?B?a3FOdHFZR0s2QmgwendSdGVwdm5qWENBSXhXMGsvRXdkV2k5anlPNWczR3lG?=
 =?utf-8?B?SDJUaWZidzZqMWhjY1F2L3hRbjIvSnh3cU5PaXREcmI2VkY3WWYxVHgrVEts?=
 =?utf-8?B?VkdPRnMvaks0dlJFdWs4MFZBQXh1ZllncFBKdjA4Q2tqNEo5bkdxOTZ4Z1cr?=
 =?utf-8?B?Y09WbzJZb2lNU0QvUmdLS3grdHdaQ1hsdTVmVzdiYUFYdytIL3BPSkNXNDls?=
 =?utf-8?B?em5LbE5SSFFjcGRQK0I0NVl1dUxHaTJteVR2VHo5ZEJaRkJtbDhkUmxhUlpK?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc8d154-061f-48de-7c21-08dd5c03be8d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 16:35:31.0066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5YJsrTZfM3KKZ9T9w7FXOU33LxUgb0f1LWGzg5Rt0JmjOUVONt1gDAG+qnwhylA3BfQc4ss8sOKpiPNFbxQTAhu874MnWGcLX4/a3olEUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8392
X-OriginatorOrg: intel.com



On 3/4/25 1:47 PM, Luck, Tony wrote:
> On Fri, Feb 28, 2025 at 07:58:24PM +0000, James Morse wrote:
>> Changes since v6?:
>>  * All the excitement is in patch 37, turns out there are two rmdir() paths
>>    that don't join up.
>> The last eight patches are new:
>>  * The python script has been replaced with the patch that it generates, see
>>    the bare branch below if you want to regenerate it.
>>  * There have been comments on the followup to the generated patch, those are
>>    included here - I suggest they be squashed into the generated patch.
>>  * This version includes some checkpatch linting from Dave.
>>
>> ---
>> This series renames functions and moves code around. With the
>> exception of invalid configurations for the configurable-events, there should
>> be no changes in behaviour caused by this series. It is now possible for
>> throttle_mode to report 'undefined', but no known platform will do this.
>>
>> The driving pattern is to make things like struct rdtgroup private to resctrl.
>> Features like pseudo-lock aren't going to work on arm64, the ability to disable
>> it at compile time is added.
>>
>> After this, I can start posting the MPAM driver to make use of resctrl on arm64.
>> (What's MPAM? See the cover letter of the first series. [1])
>>
>> This series is based on v6.14-rc3 and can be retrieved from:
>> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/move_to_fs/v7
>> or for those who want to regnerate the patch that moves all the code:
>> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/move_to_fs/v7_bare
>>
>>
>> As ever - bugs welcome,
>> Thanks,
>>
>> James
> 
> Upstream is at -rc5, so it's time to pick what to ask Boris to
> apply to tip for the upcoming v6.15 merge window.
> 
> There are several open issues for Babu's ABMC series. So it
> isn't ready at this time.
> 
> Also several against this MPAM series from James ... but IMHO the
> first bunch of patches look to be in good shape with a
> full set of Reviewed-by and Tested-by tags on parts 1-7,9-11,13-17
> (things get murkier in the 20's and maybe more likely to have
> issues due to skipping patches that don't have all their tags).
> 
> So I applied those patches on top of v6.14-rc5 (all but one applied
> automatically, patch 10 had two line "fuzz" due to skipping patch 8).
> 
> Resulting kernel builds (with W=1), boots, and passes the tests
> in tools/tests/selftests/resctrl.
> 
> In the interests of making forward progress, should we ask Boris
> to take this subset of the MPAM series?
> 

Sounds like there may have only been about a five minute window for
clarifying questions about v6 before the door was shut on it.
Since I missed that window by a couple of hours I'll move to 
v7 where the MPAM pressure has so promptly shifted.

I'd be happy to work with Boris and other x86 maintainers on
any mechanism they prefer.

Reinette







