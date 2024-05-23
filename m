Return-Path: <linux-kernel+bounces-188120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA8C8CDDB8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 01:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C6D280F44
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 23:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16962128826;
	Thu, 23 May 2024 23:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iq1Z1K4S"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2482127E1F
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 23:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716506946; cv=fail; b=u5qg+UuytRWp0xWJes27MJAhJngsTbhoFcVbkBnkN/LNM360HznmYDyYWSz9TneNjed8hnVOabHr8wNwhvVEekrZK5WMWFyezJflDlD52CIkVrFLpBO8O5fN+Qjn0E7bxwON13qRLT+JCfF4NSWM1RINJtOFHk0Y/Z4XQ87Hh4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716506946; c=relaxed/simple;
	bh=Qf7Mb0rXEUjscCrzEGDm4cVRljuaFRJiLFdkzYu8OPY=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MnaY3Fi6kgSwRb2SkaS/unJSnGWwHD/yECoka+ToWoMRwAU5uNbv0RhNnzyayi8K6FIL6FM4Uoo1iiBNRfyj1Q11m9j3LotpPXGJutTG+p15FYyXs/6C5pceW93Ggc074A+9mvtBP4cvc/kf/4NqPsyw215oAlWolYwozfCtvTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iq1Z1K4S; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716506945; x=1748042945;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Qf7Mb0rXEUjscCrzEGDm4cVRljuaFRJiLFdkzYu8OPY=;
  b=iq1Z1K4SS0jRrtk1LD7uNu5XauuPeMGcgnw/mxpOs6fB1cUgt8EX8adK
   PidckAxIZRk0Hmv5hvDZQjZFL9/ELguwKwHNW1+/c6FMv99TLgx/xRaxM
   uUzhsAnHRyaz22nvCEJjNUIpL+QrQdBA2vD7kMYbNFDc5PufdYAk3/dkD
   ypRNkwt/MuKIj9nhzAlAtqiocCO1caa1cDKmmiytO3PBDYvO7LOPkWhhr
   Q/l0KALI8Isv4Ep4szCRUqzhbC50PV6gaqQiaPo8o1FujtHQKxgCTqQXi
   Y1EgyYyNoqTcvoDrh1gYeggU0UN7IZPXeSgzx65G6c9YNu5/FcOZVxZE4
   Q==;
X-CSE-ConnectionGUID: fshksUpiS9Wj+PpwKa/X4Q==
X-CSE-MsgGUID: Wch9e3GKR1+ht5orWYjOPQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="13094946"
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="13094946"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 16:29:04 -0700
X-CSE-ConnectionGUID: MJU5lSqKQmazsz7wI3UIlw==
X-CSE-MsgGUID: 5O5RIWeFQHm+BiYgb6z80w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="38685012"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 May 2024 16:29:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 16:29:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 16:29:02 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 16:29:02 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 16:29:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7X/QCsaAu6hqHXE2qvwL8BiEh9N8OtGY5ZHcOKg6Ty92xSBYuD9ZXkrBG4cD/0QPxCmLosxn1+5/bg8LG8C2xc/4//834awt0+UuSFPiBYoniQ55MFKWFeYTQb80n/xLe+wFoE7kJ1Q+7JZTDGO8/l3Tn/Qympozl6lTz00hd5pJgKcpxUnYqD4z4T6LFLGlfZASm4+A6hHX/4pw/Xrwijjy8WW7EsUFpmYBKnyB7gYlyPl1GEvChcDpIVjb1HA/0Z3JvtoavQ2/gAi+KuH89cbOW/tip6cmjdu8HzGpGzFwDXv9o3N9cIzc4IDF3Pzixi+n2excO6zC3hOT+i9uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMZlCEdMfsfW9Ja4zOK6LXpfw3beIJ4zNZww0SMRrUw=;
 b=B7crQangZMm3fmK7uJsGna1UVWBiEli1fIXZVvSLZ69RTZGi0Btjs0vBKVX+4DCzNxeCut1lkADwHl6nVksUWyQovj7kxCh4iOqiqtM1bjeLjpMTZnaEjagSdOJdQ4dP5qJNE5OMVuXeu+qocdh9mrINzD0vJzGQ0zWW4+8h7uI5elDTqO+Rb8lyyunQ1rE0NlQRBI8OFj0gHyHF0oqbx271lE4ky0onIAUqxhhFdGBIX/cFPPukTM2Y3RnIGc08cX08l1+b6IjlhLg5/5gt8Th6uUbKgMDgCW3Lm+0zFXeFXtN9/w2Qa8O1B9wa3HHeMDHcNwbRijHsdroRgiZF2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB8159.namprd11.prod.outlook.com (2603:10b6:8:17d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 23:28:58 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%4]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 23:28:56 +0000
Message-ID: <62231ebd-9ed9-464c-a4db-f8c79fd3ce5e@intel.com>
Date: Fri, 24 May 2024 11:28:46 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/kvm/tdx: Save %rbp in TDX_MODULE_CALL
From: "Huang, Kai" <kai.huang@intel.com>
To: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
References: <20240517121450.20420-1-jgross@suse.com>
 <ohvjbokpaxagc26kxmlrujab7cw3bekgi5ln7dt46cbsaxcqqh@crvqeohfazmf>
 <f63e1217-3dbe-458d-8c14-7880811d30ba@suse.com>
 <2a2guben2ysyeb43rzg6zelzpa57o24ufai3mi6ocewwvgu63l@c7dle47q7hzw>
 <03d27b6a-be96-44d7-b4ea-aa00ccab4cc5@suse.com>
 <fc0e8ab7-86d4-4428-be31-82e1ece6dd21@intel.com>
 <c0067319-2653-4cbd-8fee-1ccf21b1e646@suse.com>
 <6df4fb48-9947-46ec-af5a-66fa06d6a83b@intel.com>
 <86ca805d-7ed7-47dd-8228-5e19fbade53f@suse.com>
 <f7edef9c-5eb5-4664-a193-3bb063674742@intel.com>
 <f02d9ebb-a2b3-4cb3-871b-34324d374d01@suse.com>
 <4b3adb59-50ea-419e-ad02-e19e8ca20dee@intel.com>
 <c7319c0614c9a644fa1f9b349bf654834b615543.camel@intel.com>
 <e2d844ad-182a-4fc0-a06a-d609c9cbef74@suse.com>
 <2e07ebc774bf176ebfab40e6ba8bc14ae6a94e0c.camel@intel.com>
 <a9bbb31e6660343e95d3351febc6e3b9661a7944.camel@intel.com>
 <c188878d-ff67-45da-a963-e643bfb927a8@suse.com>
 <cc57bb62-be80-4c97-a8f8-5cd0548c3c11@intel.com>
Content-Language: en-US
In-Reply-To: <cc57bb62-be80-4c97-a8f8-5cd0548c3c11@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:a03:254::23) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|DM4PR11MB8159:EE_
X-MS-Office365-Filtering-Correlation-Id: ef1de8aa-9e9b-49c9-20ad-08dc7b801d75
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OW5VWEx4N1Fyd3JsSVZmYkQ0YUVITlZCZDk3d1NmTEZqSmFPNlFxQWR4TCtV?=
 =?utf-8?B?YWluelBBTEVodWZQcVVodG5QdUMzNjlBQjB2S0Y3Y05CTTZOWW5velY2R000?=
 =?utf-8?B?VXNaellMc1pHdldRQzRPdGc3U2szd3NxMWpvbHBXdmRhcmJObGpVN0EzOU1Y?=
 =?utf-8?B?NHp2UGdiL0krTUt2c05yZGJvdVVjUi9hcEJaaVEzQlBYaDJGRjVtMVlya2Q5?=
 =?utf-8?B?dmF5eDg4dnRPeGo3OU90c2Q2b2VXd0pQSTdpQzVPNUxIM29RclE4UC9BMzFi?=
 =?utf-8?B?MzFvM1JzQmhWNWxFeXFvc0JEOFNwSnhKRkRWYzk0NjBoODdtaTNDTFkrS1F5?=
 =?utf-8?B?Ui9lUGNQTjE3K3p0emNyWW5GSGVjWU41dlRvMUxLT2lKeFE0YVZBWktkdDhU?=
 =?utf-8?B?M3JUOFBjOVNQU0xFNzlROWxnVlFpTkYvSjBKY3dlczkxQjJpSjN6V1NTK3Rt?=
 =?utf-8?B?YzBXWi9ZWVlRVFc0cnlOUkI4SEpUWXZpNkQxc1pndXEyM3pTamZJbnVmUWV3?=
 =?utf-8?B?L240RFRqeFJiNjFtdHlJb1VhTHdKQTVhYkZ2QnRETUtCOHF3ZW45UUtIWkIz?=
 =?utf-8?B?blc3S2Z3SFhoS25hMmlHSktwSlQwYnUxL2h5WjBkcTBoNUU3aWdDQ3hicnda?=
 =?utf-8?B?am93cGhtMkp4Tzk5TEVOdHhEVG91aXRJVFNNVnBxWGtBbU9LOUw0ZExnNzNu?=
 =?utf-8?B?eWlBOEFtRTczVkZRUVBqQUJGaHdSb1pjV09ZL25lYUlmckhDNklEeGRhMWsy?=
 =?utf-8?B?NkMxY0N0M3FoY09odW5CWTBTbUZJckZ1ZFFBeUZCWlV5cTZDYVE1NTVBc0JY?=
 =?utf-8?B?dzJDU0NibWZRaFZnOWFEcC95WUFOT3RkYjRjR3hpdGtLMkUycVZBajZDK2x0?=
 =?utf-8?B?SVVpS3pDbG5BV0NLa3B5YlpFR1FLcE56ZWpxRlNJNG1pQXM3YWh4Y25JVWxB?=
 =?utf-8?B?TnMvOTJEcHlKZUZjYTlvakdFM0tudktJSWYva0RTbDRhK2dzanFlV2V1eTRk?=
 =?utf-8?B?R0tCSTlKQWo0RitmNnh0SG55Rk8yWjYzTTl0QXRiSDlCd2ZUQTZQZzdiUGVU?=
 =?utf-8?B?bGR3U0VnOUtEa0xPUkNXK3pzOHBEMERveHJOME5Td3I3SjljcGpEaG1iM0ho?=
 =?utf-8?B?bkhjZUJscWRqTWxlOUtYZXJIMk1rbCtVcExoQXZqZUMxZTVsTnNUaTlMY0ls?=
 =?utf-8?B?a1Nua3BLQW05YnQ1dkRnbXNieXVjSVdjNHVQWE4zODYxNlRuTExhbFFCeEFX?=
 =?utf-8?B?RUsvSkREYzJrTmpITHhsSUhoTVRLTVcyU2plcC82Q3VXS2JVQXB1S1AyYlRy?=
 =?utf-8?B?VFRQWGJlTUhPckdjNm9LSkIyOXg5UjFUZjVVc2Zoc0hRUjBwMHNuMjBuTkxi?=
 =?utf-8?B?V01maDQvMjNlTDBESnVtakt3VU9zOUNoRm1PTlJmRm9XSFljOUZhelZqYjVG?=
 =?utf-8?B?VVhOV1Y2WnFPczdTV2Y3djZDOGhNZTA1NmNoZVcyS2dWWEtUZDJqNkw5STlO?=
 =?utf-8?B?RXAyTjNtdWlZMHc0L2t4SnkvS0l6VmZpYldQMFhEVjk1MzRELzhZSWowRG4r?=
 =?utf-8?B?bHp5RWg4d2U0ckxqUUkwanZZckdXRDAzNTlvT1hvbXVqMXJGekNDVGJxVks4?=
 =?utf-8?Q?cX3ZMqwiv9i31LOSifAjQ5VfMG1sHuZlAU/gGZ3xWIS4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFpsQ29IVkp5OGE0YmJsNmd2TlE1bjY2b0F5c1ZPR2Iwb2xnUjg5a3FlZjBH?=
 =?utf-8?B?TnhHcjBIODVUQThlTkorZC9YNFJkbGlITktMTnJ5ZS9iMWJkQ1V0V1VkVnRM?=
 =?utf-8?B?ZGJNTFhmNVpSQ21YZkM2VUVXVllNSzdqTVl0bnR2QzN6NVcvZHhxUzVLM2dE?=
 =?utf-8?B?VUREMGptSEhnblpwMVBUcEF6SzJSRXVxZWEwcFRFL0FxY1dBODdNQ2VXbkdh?=
 =?utf-8?B?aDJLT0NIY2MrTTVoVklRWjVZVk9nRnhmamJ4bm1BWmp1bVNwVHpVNktPQ0k4?=
 =?utf-8?B?dnllVldQL1pvc0JGL1pPNGU5b2tCaXlKWmVuNytXUmRrWlp0MDZFWDg2YnFl?=
 =?utf-8?B?YWd3TitJVk9IYWlKMXR2b2tlOHpJa2dwSUhZRkdhWkpYZ2RzdEVmek0xaEtk?=
 =?utf-8?B?RHpRVzRsZFZrVzR4YVMyQVhoNlEzcCt3dUc1NE5pLytRSjVYWkhERzY1b0Zt?=
 =?utf-8?B?WkhqNFZmbkNjRXdHUC9qK1ZySDByN2ZUTEw3RTRyYTNFZHNSR0lKb3FhV3Rz?=
 =?utf-8?B?SmQybVBiaDQ3ejhPZ2tWd1cwZGtzbUtuRjY0N2RVc1JJNTNLbTZUcHlNdzhL?=
 =?utf-8?B?R0ZpY0dlNStkai9QeWFVN0VVSmZ5bVlBS3Q0bFpaSTJZeHFUcDNGYlg3RCsy?=
 =?utf-8?B?Y1E1NDRnNkZ4K0hCbmc3dnhYSTZWQVJZK3FZd2xrUksyZWQ1MldFVDV3ZEJr?=
 =?utf-8?B?a3R4VWsydzh2STcweGZkYVZEc015Y1owV1BjTC8yQm5PNXI4MXBhWHJJd2Fw?=
 =?utf-8?B?MXZleTZiaVM5dU11U0ZWUEhMc1duTGx2ekx2K2xNRWlNUUwxMSt2OGlKaXkz?=
 =?utf-8?B?ck9Mb2l4cVNVKzBVSzIyU1pWMzBCbldXWkRYcHh1Kytrd1pVWE1kLzFaenlp?=
 =?utf-8?B?VUlEYnFFaFh0NXZCTVpOQVF5TmxoZjNPRVY1bVRmNzZ4b0dRWDUzREtFYldy?=
 =?utf-8?B?SjB1N0lFNDRxcWZJemswam9UMzJGTldtWWNiYXpQWlg1ZmpLV200MUR3Lzg4?=
 =?utf-8?B?RzkxOUpqVG9UZTlpU0Nwb1luc2UrcUw0b2RtVXJEVEpvSVpjNGtYQ01Xayt2?=
 =?utf-8?B?MHZ0K0s4Q1hMMFdzcHBNdFNHRWNCMHluaEVrdTB3RnVTV1FrQWZiYnk2Wjhq?=
 =?utf-8?B?ajNabDBzVUxLc2UrdVBrQ2t5TldsUnI0dWhlZUU1bEZBVFdHZER2d1FkZUtG?=
 =?utf-8?B?YXBKRndib1FIc3FnSE9HUnAyb3BJN2h5TGVncnZhODNGTU91OHJuTkN5ekxJ?=
 =?utf-8?B?UXBOZmtseEV2dmZlZmFOOXpwT2kwcXVJaU5kVm1RRXRqL2xTazFyVTZaU2F5?=
 =?utf-8?B?eEE2NWY5R3IvTnlmb2xPRXhZeVd5dGJlK3kzNDR5NEptc0JBb21jNWZrTUdo?=
 =?utf-8?B?THVkbmZXTStVcmlnaVNkZFFYYVI1RDA3WE9IUGYrV3pVN3Z0eWZvNXVtVTJ1?=
 =?utf-8?B?VWlNbDFUSjJyOEY3VEdDMkQ1TFJyVUwrNC9iam9wWEs2NTBVRUJxMUtwdnd4?=
 =?utf-8?B?VGxreTJ0dXRLTkhnaTg4SllnaTl5a1A3V05HUTFQalErcFVMNlo4OGgxWEh4?=
 =?utf-8?B?NzVVRkRGUkcxOVBDbmlwZzBnbWRLWTdEOVNzaVhFZHdGek9Sd1lRR0EzTnRi?=
 =?utf-8?B?WjM2ZVJHVXMzUU9nSjB2NS8zanhHcHU3S2ZGa0tRSHhwOFFCSmo1bDl2cVhU?=
 =?utf-8?B?MUMyaEtHb0U5NjkxZGhJSFpjMlU4bDU5L3p5WndsVkkwL0RYSURBNVQ3WXEr?=
 =?utf-8?B?S0NSRXd4SlZ4UStuVDRlVWxHRGxiR0E0c0NOKzczaTU0dHR6Z2ZsbU5JNXpy?=
 =?utf-8?B?d0IvVDhHekJia2IyQUJzSXJJWXF5ZzNmd3J6MGoycStyRUhCWnMvNmROT3hv?=
 =?utf-8?B?aFFxbmN3dVdMZ1F2OS81eENMeWFsUzlQVEZrZ2NqdkU5NVh3dHc2MzJCVHMy?=
 =?utf-8?B?RnhBbUJjMHZjS3ZRN2hNbE1TS01IL0JMV1NRam9ESHpZYVVJbTBhVk8yTEh0?=
 =?utf-8?B?UEVnNVkxamZJWDdzRWRacHZqS21TUExBVFRJbjQxVmUyeEtoYkl0OVZ4d2V4?=
 =?utf-8?B?UlBFZmRpTlNBL1dxdWpMcTh4UE5aQXR1dVVmczFIMTlKS1F0QjlMaGZpckRV?=
 =?utf-8?Q?8BXJmPDMhnkct4L5y8NUaEYua?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1de8aa-9e9b-49c9-20ad-08dc7b801d75
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 23:28:56.2017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zu8wMYN+wC0rTgqEsWtfDtKc6/UDYLLphcGmWZyPx+74UvNtaAzyzf6NOx0uAFCJZVr0VDRuGj9J1zT3htSDww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8159
X-OriginatorOrg: intel.com



On 24/05/2024 10:34 am, Huang, Kai wrote:
> 
> 
> On 24/05/2024 12:43 am, Jürgen Groß wrote:
>> On 23.05.24 14:26, Huang, Kai wrote:
>>> On Thu, 2024-05-23 at 10:30 +0000, Huang, Kai wrote:
>>>> On Thu, 2024-05-23 at 07:56 +0200, Jürgen Groß wrote:
>>>>> On 20.05.24 13:54, Huang, Kai wrote:
>>>>>> On Fri, 2024-05-17 at 09:48 -0700, Dave Hansen wrote:
>>>>>>> On 5/17/24 08:58, Juergen Gross wrote:
>>>>>>>> On 17.05.24 17:52, Dave Hansen wrote:
>>>>>>> ..
>>>>>>>>> Once we have the specific TDX module version, we can go ask the 
>>>>>>>>> folks
>>>>>>>>> who write it if there were any RBP clobbering bugs.
>>>>>>>>
>>>>>>>> Okay, how to get the TDX module version?
>>>>>>>
>>>>>>> You need something like this:
>>>>>>>
>>>>>>>> https://lore.kernel.org/all/20231012134136.1310650-1-yi.sun@intel.com/
>>>>>>
>>>>>> This one prints TDX version info in the TDX guest, but not host.
>>>>>>
>>>>>> The attached diff prints the TDX version (something like below) 
>>>>>> during
>>>>>> module initialization, and should meet Juergen's needs for 
>>>>>> temporary use:
>>>>>>
>>>>>> [  113.543538] virt/tdx: module verson: major 1, minor 5, internal 0
>>>>>>
>>>>>>>
>>>>>>> .. and yeah, this needs to be upstream.
>>>>>>>
>>>>>>
>>>>>>   From this thread I think it makes sense to add code to the TDX 
>>>>>> host code
>>>>>> to print the TDX version during module initialization.  I'll start 
>>>>>> to work
>>>>>> on this.
>>>>>>
>>>>>> One thing is from the spec TDX has "4 versions": major, minor, 
>>>>>> update,
>>>>>> internal.  They are all 16-bit, and the overall version can be 
>>>>>> written in:
>>>>>>
>>>>>>     <Major>.<Minor>.<Update>.<Internal>, e.g., 1.5.05.01
>>>>>>
>>>>>> (see TDX module 1.5 API spec, section 3.3.2 "TDX Module Version".)
>>>>>>
>>>>>> The attached diff only prints major, minor and internal, but 
>>>>>> leaves the
>>>>>> update out because I believe it is for module runtime update (yet to
>>>>>> confirm).
>>>>>>
>>>>>> Given there are 4 versions, I think it makes sense to implement 
>>>>>> reading
>>>>>> them based on this patchset ...
>>>>>>
>>>>>> https://lore.kernel.org/kvm/6940c326-bfca-4c67-badf-ab5c086bf492@intel.com/T/
>>>>>>
>>>>>> ... which extends the global metadata reading code to support any
>>>>>> arbitrary struct and all element sizes (although all 4 versions 
>>>>>> are 16-
>>>>>> bit)?
>>>>>
>>>>> With that I got:
>>>>>
>>>>> [   29.328484] virt/tdx: module verson: major 1, minor 5, internal 0
>>>>>
>>>>>
>>>>
>>>> Let me check TDX module guys on this and get back to you.
>>>
>>> Hi Jurgen,
>>>
>>> I was told the module starting with "1.5.06." has NO_RBP_MOD support.
>>>
>>> And I think I was wrong about the <update> part of the version, and we
>>> need that to determine the third part of the module version.
>>>
>>> I was also told the 1.5.06 module hasn't been released to public yet, 
>>> so I
>>> guess your module doesn't support it.
>>>
>>> I did another patch (attached) to check NO_RBP_MOD and reject module
>>> initialization if it is not supported, and print out module version:
>>>
>>> [  146.566641] virt/tdx: NO_RBP_MOD feature is not supported
>>> [  146.572797] virt/tdx: module verson: 1.5.0.0
>>> [  146.577731] virt/tdx: module initialization failed (-22)
>>>
>>> You can have another try to verify at your side, if that helps.
>>>
>>
>> [   29.362806] virt/tdx: 4071192 KB allocated for PAMT
>> [   29.362828] virt/tdx: module verson: 1.5.1.0
>> [   29.362830] virt/tdx: module initialized
> 
> Seems your module supports NO_RBP_MOD.
> 
> This feature is per-VM and also requires to be explicitly opt-in when 
> creating the guest.  Could you check in your code whether the 
> setup_tdparams() function has below code?
> 
>      td_params->exec_controls = TDX_CONTROL_FLAG_NO_RBP_MOD;
> 

Oh from another thread I saw you mentioned you have the above code 
enabled.  So from host's perspective the TD should have enabled this 
feature.

It's possible it is a TDX module bug if you are not able to see this 
flag in the guest using the way Kirill replied.

