Return-Path: <linux-kernel+bounces-285837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C1D951354
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD821F23C63
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 04:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508BA48CE0;
	Wed, 14 Aug 2024 04:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QWTQZUmi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D3D2D638
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 04:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723608036; cv=fail; b=jsV9VtBRW3sVHPkR4SpOzinGXe93BI9ZlLzhnEbktiiBRPl6wylV3PW1jcEq8bVWSw1N65wQL6L+g8rV1tyAPjfpGYY0PIJ3MmvEYwqu3vDhy/heeKiNXJnvbwhcuyhO4Xp36xbHAGIqukkMto78e2Z5b3L87SNlVowApvlDccU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723608036; c=relaxed/simple;
	bh=Ir4027Et/fGyv3s3r+JSeOJQ7PqVw6adBtDNxKfmFHg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kUtSa0n809C8/+yPoT/6OWP7PHDBiQHoQx4p/RYmm0BOzs4tZs3wR+XR34+Gu3bwa61WgaZqBjv6sgUkM3Kke3SL7UlIbcud78IoQ3sJc4ICarnnKeA/GM/4V/rAKbOz+zI7bEOtmFLCdg6wu5+Lol/5ylKLsWfA8NWAyCqjpVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QWTQZUmi; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723608032; x=1755144032;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ir4027Et/fGyv3s3r+JSeOJQ7PqVw6adBtDNxKfmFHg=;
  b=QWTQZUmiSj2V27aRVZWauhFuh9mEPvSsb0ZWlknGqR7SV8DA6VSS5ys0
   gl7mSLfBKESPq/CN790AsI9lDKpC/zDQmoWxjY6iWcCe/rAiDOotscJme
   LLd/R/kYO57k76sNJ+duDmUu2xL+xk3W1NOfWkUjpHERGiz5Xy91+xP3a
   /gncVEYBA2ZFuxT/y9zy9UwLnHw9BTnSnVlK322Zy9vNv0vMGjWSNmII7
   x42GRqE82UD3eyAix8uqMB0heko2DCZB/HWj/DohJfHvZ23VioMl09IG6
   DqcxQSBSrLIlCYmLF8dJ/4RR4i0o6LSDkzW5283NeNYPJpY51OLwVbyIX
   g==;
X-CSE-ConnectionGUID: RI0GQbQmSHyvKfQBw3soWQ==
X-CSE-MsgGUID: rGLmqBhKRs+AMixO43zPSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21360707"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="21360707"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 21:00:29 -0700
X-CSE-ConnectionGUID: aA2scX7XQmm0p6HGCDLfMA==
X-CSE-MsgGUID: PixhaZuwScKLO3oGS3VdZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="58872707"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 21:00:29 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 21:00:27 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 21:00:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 21:00:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6MN5H/i3u3Y24xOLaQ8TLN9c5cyBDQDihAAGCAPdEOCzoyA7z07GYTn5Jqj+NZgHSZS4foUqDpLDCTe21X0X/YqL9yDadLcKdMAKObldT8uDEZd/quxwMuQC4uVogiRg3JHNgKtXc8RsxqZG/Qict0SScljlENguVMKk2r60SuIQSCwrUz7j6xJMohZ0dAz/TKqn6vLbfVc64OPjhs+I3fGKUIwgqC5qG42M3tkZgTK0leOkMRMG7IU5E6BT68/2bimfxYoXZOI/1OOoYtvSu9hKUgASfZW5BX4rjDYTlsFOQIDf6FYwrTm7fr0ds4IGQwOPw00+z8kYALW9J9OaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9KNnzse89qRf1tkoUBnNHPxU6XBbMLRaPFT1przaz8=;
 b=XmcQ69ue5upCPgiGZC1k7aBUYYTNgvJsRfTQ5RHQfoYRPI/WekgFIfVUgGVIY1Q5Mscsr2Jhr/USQdmJOG35+bv8Y8F1FNU3N+NmEckhcqB6idSeo4x0R78DfBZm7C2IXv3dLX1rQiLJMsIdG5zIBXBAlr5nl8OWH9wsSUmWi/tK5j8VKXOlyGMZrS2zRO6JWUcta+XBsodwGyS2bGnwwfBhTVb901Udisitb+XCzdiDoYBHRdb3X0G3acTu19kI7cf8UjLDrmSW7xfcT+TtkiCS9vE9fEIu8VcNM5AyPwnmlKs19hRT1owXlm2TtBiLELC/8BUWUS7hKRTL+l95jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB4955.namprd11.prod.outlook.com (2603:10b6:806:fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31; Wed, 14 Aug
 2024 04:00:26 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7828.023; Wed, 14 Aug 2024
 04:00:26 +0000
Message-ID: <ca528ebd-fb76-40cd-a495-88c2de443cd8@intel.com>
Date: Tue, 13 Aug 2024 21:00:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/39] x86/resctrl: Add max_bw to struct resctrl_membw
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
 <20240802172853.22529-8-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240802172853.22529-8-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0141.namprd04.prod.outlook.com
 (2603:10b6:303:84::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB4955:EE_
X-MS-Office365-Filtering-Correlation-Id: 6744b4c4-d53e-45a9-f550-08dcbc15a0eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VnBPRTdEc3ZDeXkwS1IyWHNteHV0b2hjd2U5OHR1TndiL2sxbFYwTGQrN25t?=
 =?utf-8?B?ektBaDM3WUdkT04yTW9jYWdPWVZ1TkNiZE1vQm40enpMRmN5OFZRZUt4MWtj?=
 =?utf-8?B?Wmx6eWd1eUFPZVUyU0poWW4ybm5BSGRmeGtHblN5Uy9CaGY5d0hYdkFadXFa?=
 =?utf-8?B?WklveW5MVzJ4SENMMTVPVlc0Q2NJS041VEJoalg1OEtzZG8rY1U0ek5GQ0RH?=
 =?utf-8?B?RFZXaDlyWHozTzNIMlY0VURYU3ZMQ3hQWks5dndya0pnaklyc3hncEk5WnNi?=
 =?utf-8?B?dTNhdlVmS3lMMnU1eGhBVGVrYmpkZzFVdjArc0V3RGhwUVhiTmI0UDN4eXho?=
 =?utf-8?B?WXNhVXYxaTVwNzNYeEhSQ2o3dmNuR2RBSzl2czZ0cFdTTkE5azQ0aG5iVVRs?=
 =?utf-8?B?NWY5dllLUi8wU1l5eStXQ291RHdKaHUxcW4vaGtoNlZaREMwUTU0c09BUmhS?=
 =?utf-8?B?cXNsTEtrVHlCMEVNaVYyN3dsNWtkSzdFeS9DV0ZZSjFkU2ZRRGkvd0Znd1pD?=
 =?utf-8?B?VnQydStVQTNFeU9TaUNaV3M3b2d0enROY0pVY2JJZmVsbHZ0QWZPTTUxN3BX?=
 =?utf-8?B?TGFlWTdpUzdPTWYzWVd1Y2UwVEw0ZmJPQzhzMGRFUk53cnRjRTBIWXAzbGwv?=
 =?utf-8?B?bWgzaWtIODB0Vjh1NUU3dnNTM0RFK3VOMXdyclN4YkxwYWxqQ3VRMXBOUmMx?=
 =?utf-8?B?ZEtxdFVRUEhwbnMrZzBOLzhkQlJSRTFtbkhVUUt4MDk0Z1h5SEVJbjlzbUtn?=
 =?utf-8?B?M2xwSVFXbmdFVzV3Nk5hdGNrUEYvQ2RETnRiNmR3ejJCMVBnTFdkbDZRTStO?=
 =?utf-8?B?Q2ROekZYZ01SSksrdjlialZTTytnTjV3SVMvNnhmS0hDTzlzSXpKR0FCNFhL?=
 =?utf-8?B?Wk9Ud2pMM2ExM0JwWnpTTm1zWlNLTkR0MjNuaGZLeHYzUGZqdStjekgvT1Nq?=
 =?utf-8?B?ZEY0RzNzS2hTbitUTkdBVmhwcm05ZU9qSllDeWtIWnJUR3NJNEtneE1HN1RJ?=
 =?utf-8?B?RWRqVkQxNnlmOFl1ZW9OWklVSFFKZCtYWkNDVTVLcTJQTDNiNXBHQTM3bmt1?=
 =?utf-8?B?SUhJV1pkL3cwdjJ1ellRVDdEaEwwMkcxK2VYbkV6QlBnUnV1QmloN003UXI4?=
 =?utf-8?B?aUtaZDNuR1FwZVYrbWd4THh3ODRnSStLYUoxUUNDQi9TaVpROG91ZjZGMk5M?=
 =?utf-8?B?L3FLaUF1ZlBMdWt1VTIyVWJTaXJQQUlGd01vU3JxcHAwVm5tYVpCZTlhSnQz?=
 =?utf-8?B?S2wwcDdhUmVkTjhFcWYrTnhXR1ZjalRFNmZoSElJMVd1RThaQ2lyYXVkT1dk?=
 =?utf-8?B?TU0xM21XTjg1a3IwcldRaXZaNHM5RnFpa0NZSjQxNVdPOVlGd0NLMnFNUGhx?=
 =?utf-8?B?dThIUzNZcHFFSlgzbEFpTHRyWXdXZElpbjFTM1VteEVrbllsS00vR1c4YXFW?=
 =?utf-8?B?UE50RUJwVHRsMk50RlpYMmsrcjZsUnA0d0hJbENRR2dteGNsQ3pHN1N2REE4?=
 =?utf-8?B?aXlhM1I1TTdlUUxhUkt3bjNUaWordGRqYTNPeEljbkdJMmRQbU1DbzBYaFAw?=
 =?utf-8?B?b0RtcnRaMWtDTTJBSzRhajhucXZKd1ZTTFFjQjdsaVNJNjhYVjU4N3RSRTY2?=
 =?utf-8?B?OXZKUUFnSVpXQ0R4OE8rTE93YlF2emFuajVla00vSDAyOGRONS80S0hlU0E4?=
 =?utf-8?B?aWdhT0VMdEZBSjhsNlFDa0E0MWtZaWZBdmpmeEVlblJub2U5RnZtMDBqWmVT?=
 =?utf-8?B?cGw0cmNKNXZseVkwTnhLeVhtMEVESDlrYlF6YzYrK2JpdE5ONmJkMExyQldh?=
 =?utf-8?B?UVVtazIvaFFJWXoxUmFkUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUJySFFiNlhhZ2l4NS92ZUtmSndXTDJIZ2cvSVlvaFRLTkJQU0tEL3ViUzNC?=
 =?utf-8?B?Ti9hbEtYWUxRU3BiTzNya0xhQzNpRzNQNkNvUDRIUlVIUWtqMzdwN0dmY1Zq?=
 =?utf-8?B?RFZIZWRock9JcXozZW5Dc1NnSjd5U3lxcFREM3VydHlYQ0xSUzhRUmlkZHox?=
 =?utf-8?B?RWRNQWdrZEZrQ2MrejExTGJIVmRia0xwK1VUSG5CZGU2UE9Cc0ZyM3RNeVhr?=
 =?utf-8?B?WWlVT01DZEpYTmN1cytCWGYzTzF1dGxqTDZmbnhadDJ2YjA3aGRTUUM5cWNv?=
 =?utf-8?B?dUp3UzR6c2xpb0R5dFFtRDRrQ0hWam5wMmtkTkExemFXTDhaTGVZcEgzSHZs?=
 =?utf-8?B?QlJ0M2VDUmpDUEg0VmVHR2REZFZ2cjliSWVxNzZ0c1VqS0JERDZZeHNpem5O?=
 =?utf-8?B?Z2F2bjZoWWw5b29OSTNXYlB2QmhDaTlVMUFUWDVnOHdyL24wTTcvYm5vNmNn?=
 =?utf-8?B?Nnc5by9xR0YySlBpSnB2Nkl2bVptR2FOMFZwYnpZTlpPUmpjZEZLcnNsMlZx?=
 =?utf-8?B?UDhqM0Yxc2gvMVRoR3JJN2E2MnNrV1p5aVFzdXI5d1A3aGhzRVNXekw5SVdW?=
 =?utf-8?B?SWNyclRxdFZrZTE2aVZLc2l3UjBKS3dxTldWTVFyVTl3TFpYMThMSGVFZDJE?=
 =?utf-8?B?bkVxdGdEWFJSQTBMZ3hYRVJqYTZNOUREZGpVWkViTlpidGVNd2NaanJkWVVX?=
 =?utf-8?B?c3VXZHNWRHRtYnJhcytPRTdINlFlRm9wMnVaaHloUFdMMVlwQ1J0NDRvR0lq?=
 =?utf-8?B?LzRhd3JwV0M5YnpDb0pWaktIRDhVZzA2bXFEblRXc3dEeElEc0ZMVWVmN01u?=
 =?utf-8?B?aGcrUlNWUVRlSGhHQ0hnV1ozV0lXYmRNYWE4NndCZDUzaFRZa0ovc24wOFph?=
 =?utf-8?B?bjNpcTRDRHpISEJLOVp2czFxWHhlazBoYUw0dDZwRlVMTjNjYndRTUtnSE5J?=
 =?utf-8?B?VE1ja1Jnc3VTWXR5L1A3UHBaeHlBWklsKzlCYmNEQmxBemprS2V5RGFSQW1o?=
 =?utf-8?B?QWtheHB2cUthYTBtdC9WbTZjRlB3NUozM3EveEJsVkJOdk80d0c0c1VYeHla?=
 =?utf-8?B?TGVJaFBDK3haOE1ScFVTNXlMNGlkb2FESjlkVmZzSUQrSDllTjQ3QjdpS1pT?=
 =?utf-8?B?MzArdnZMeHZjRGg1a0oyeEdKczQ4YVBDUEtqaTRuT3FwbDZaQUF1Uno2OUFZ?=
 =?utf-8?B?LzFwdDgxRDFtUkJoYXZpQVJmZHRUKzFsa1Z0aXB5Mld2SmNJWDhtWEx1Y2g1?=
 =?utf-8?B?NUV1YVBQS3BDTWRvOUNLOU9UMi9idUVRcEg1cGM2eVhSOE8vamNWUEVjSjVu?=
 =?utf-8?B?Nmd5Rmo3emVFbHZhUlcwVDFJcGlqYzNUL3BmMERpZG5KNjhOcVBNemNDN1BD?=
 =?utf-8?B?QnZYMkM1dXI4V0dqNWxSTm1nRm10djNnRmVRTGJCTklwZGx4eUlCcHl4ZXph?=
 =?utf-8?B?Ui9FV1NGWFhDeWFLZG5Na0pyd05FZDJvak9DN1YwZDdzNm81bHFmVEw4MTJF?=
 =?utf-8?B?MCtKc0hOemtacWJmUDlPNzVVWSszcUxmRlNaTGZIVGlEd0VCUFdOVEErcTRh?=
 =?utf-8?B?KzVKU2tDYUtSdlVRQVJnQVV0Mk9rWHphc2Uwd3RRdXFKeXdsNVl1MGh6ZHRS?=
 =?utf-8?B?TzF6a3hvMlB4TXpLeGVmdHJWWU55a0laeDl5NHlDaHl3ZXRWSGFZbE1VRVk1?=
 =?utf-8?B?eXhEaVZqYjJuMjQxcDk5Wm9NeTVjYkhGcFE0clRqc0ZEVzM0M1JpOXg5Uk9l?=
 =?utf-8?B?a3M5UnRtaFluWmMrdUwyeHhWNG1ONEpscHN1alkyS1ltdzNKNGw4ek5MeGZ6?=
 =?utf-8?B?b0tHak1HME03RUhJeFd2MVRRVmNTdkVRbU1IZVE1TzdYdWJrMEpBY1BFU0FJ?=
 =?utf-8?B?V2hoVFFQV0hDeUpMbWtWeG9HVkJheUNLYXFWQTl3THcyemhwWjBEWEhJcE10?=
 =?utf-8?B?V1FMUGNsR0dLVUdjbTgyZFoxT2dJYTZHSklycnBPZzRFdXJWVmt6ZGsvbzBR?=
 =?utf-8?B?Y3JTYm80UDZzUmNkMGEycHJZSWM0UFMvdjFkMUNQMnM2dSthY29RbDhWSzhV?=
 =?utf-8?B?Wk9veHJjVnlnanU0Qm5QNkhnbUE4WUgwM21QdVdocE40SFIvUlF2d2ZEZzZu?=
 =?utf-8?B?RnhNUFBDaUNUNjJZRTlzWUJucFdjZU9rbTluYnNMMXgvVkRtU0dBbVZSN2p0?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6744b4c4-d53e-45a9-f550-08dcbc15a0eb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 04:00:26.0850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7a4RLbo5Qe0XdoecEpP/tBMQ7r5hToCGThiuZiObCPxrgMaiWZ1eMfE3h4PpZLzeX3uTq1ZLh5IUk2/MPDGW2kg1nBBRTIo74AfwdP8nRHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4955
X-OriginatorOrg: intel.com

Hi James,

On 8/2/24 10:28 AM, James Morse wrote:
> __rdt_get_mem_config_amd() and __get_mem_config_intel() both use
> the default_ctrl property as a maximum value. This is because the
> MBA schema works differently between these platforms. Doing this
> complicates determining whether the default_ctrl property belongs
> to the arch code, or can be derived from the schema format.
> 
> Add a max_bw property for AMD platforms to specify their maximum

"for AMD platforms" -> "for x86 platforms"?

> MBA bandwidth. This isn't needed for other schema formats.
> 
> This will allow the default_ctrl to be generated from the schema
> properties when it is needed.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64

...

> @@ -108,8 +108,9 @@ static int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
>    */
>   static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
>   {
> -	unsigned long first_bit, zero_bit, val;
> +	u32 supported_bits = BIT_MASK(r->cache.cbm_len + 1) - 1;

hmmm ... should this be:
	u32 supported_bits = BIT_MASK(r->cache.cbm_len) - 1;

Reinette

