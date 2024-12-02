Return-Path: <linux-kernel+bounces-428305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C0F9E0CA5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5591616562A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116EF1DE8B4;
	Mon,  2 Dec 2024 19:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fgNe/+ty"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AE71D63CA
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 19:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733169563; cv=fail; b=YLSiZJV87U42eb3nNTJ3KfhUwklAvuP6NXT9JruGmYuq7GoSJuqS/sf280fbhn2FQOQgoUPnCrqhnANRZBR23ei+4rEc6uGDAXCLfn8lyuwxdA4zO3+SKNKffiy6iAG7Uq/+MdIU5Vc1Hsi6M7tODErvCMZRuJ1RZKSuE3zH8oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733169563; c=relaxed/simple;
	bh=alzKPiMBJoNRPTVISDa5uQiAr2EU0/VBHs6DX9i807s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NuhBRCov3+I3qinRWGEySorEKs3r6te+BkaWXKigROEH/lDC28CzxSNkEENqs6r+ZygdUcsEN4Xkdhz2m5qu2A1J8bDd/02cRylke9679S+7u5qxgMjInVdvs3vaywxbRinRO5Upi1noJQWbvDi1PRYx4C1KQ/1dznc3g1WgNhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fgNe/+ty; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733169562; x=1764705562;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=alzKPiMBJoNRPTVISDa5uQiAr2EU0/VBHs6DX9i807s=;
  b=fgNe/+ty4vOecMDgt8GFChZNGplaFJq84rMX38kuul9YCcp3LyAnfhHl
   CE94XS/AlS9Wh10+VUUCCw03bWhoWiJXuYRdbYQZpMbXPuuB4o3SXVY7K
   rY80va3Ogw/PlttgFKZ3azuJKk6mmCDD8x4tdx79jief26JqHnf/Csha+
   At2EQFby4DYk/mbES6EU1iu7jA892pPUilPxDMBvj5/sZqTWFhTZzOZEr
   usO59C8v76/Tvi18nF2CD18mEvpI8Pz230ZumBP+pp+SkD+L/F/d7Dbdq
   BNpyB6MUWWSk00/+SpB2g+D39x1ZsuN2T/RGU5XCKNunWdAQROQyP2Q6q
   A==;
X-CSE-ConnectionGUID: 6IqGNtsbRvGsC5H+1Awtwg==
X-CSE-MsgGUID: P/hqoiDjSLa/1jFTz6RQ8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="44741274"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="44741274"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 11:59:13 -0800
X-CSE-ConnectionGUID: AV+xvuFtT4KDoeYfm5f7sg==
X-CSE-MsgGUID: KFFqtvHjR9mNYzQGnTFCsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="93044688"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Dec 2024 11:59:10 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Dec 2024 11:59:10 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 11:59:10 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Dec 2024 11:59:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gv8txJWTUxMyntH6B/BBLtg+XalrgFH0HoBB6Ua+V73kE1ha9PAJ4BK/LK23X+udITe981M/EJo6fOSP7oAg4q7zgHzQGuD43yT9VFsw2aCyzClnu8XfAdJA/PMRWi+YlRkPXaJtNUvg5HlN+Fwijx8lrTW8RdAXZ6sDlWpW/R1V4uYtFDx94H6rzvXyxOqvYJxA5Fc11iCoeS1JUZoNc8mf/pSIt10yrOcBm2XDdZrNzqLCe9sahf0CcxCXqdqM04Nu4bkUeiDs29mnlxZ9rzU6mfbB+khtB2FkCZ+vWqNJAlot8+AuT186CtUduhORAZ8AyWAMgXnJZHvJI/TwIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQb+nddoqxd3YC61bVZrzraWRyk8ZANZ5RBTHMV/NbA=;
 b=dvdGLAnwXxRGlSMn0abH7AKyQy89GKuS4bXS1C5Gn4aID32LuVpq9jNOGKsPbgjRVsCY0kBLVXSqyEcAsSDjIuQ7pkD/M6H3qPSvDMHnUK9ysU7PD6mUnUAYX4YuVtzxSAoQqxe8qQQVKIzudySy/Wn5N/XSQgPxafdbYgnvNxdkmdY20oiHPWwqW/Sw99Z8BGneSrh5mcgpG8RBrXriYQN370RN98iZ54TUHEi7QmrLmo8N4VdqwDOdxHTglwHH5dTs8HOWhkD4JSGuABBE+KFQtS9YFt526QbUUBbw+DyPQUYaOphjP0tszhVF2XM2PSLX6L3GrA3yTcUV9udzzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 19:59:07 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%6]) with mapi id 15.20.8158.017; Mon, 2 Dec 2024
 19:59:07 +0000
Message-ID: <eba3eacf-5c83-4730-b12c-a9b8328ef19b@intel.com>
Date: Mon, 2 Dec 2024 11:59:04 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Documentation: Merge x86-specific boot options doc
 into kernel-parameters.txt
To: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, "Borislav Petkov (AMD)"
	<bp@alien8.de>
References: <20241202190011.11979-1-bp@kernel.org>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20241202190011.11979-1-bp@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:217::22) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SJ0PR11MB4798:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f9047e-691b-4727-4a67-08dd130bc6bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjBTczNLVlBxM0syK2xSRXhFek81YXB6NkYzcDExSUQvbUpiL09qWXVwN2hW?=
 =?utf-8?B?cnp3THl4MW5BRkZzTVIrSTVLUERGNEJCTnNlbWhTbThMRDRYTVE3WUJhOWlJ?=
 =?utf-8?B?MHZrRkZLenIzdnp6enpPRHBRRWVlNVFxdWVkNHByalhTZjVHWkFXd21RaDZm?=
 =?utf-8?B?azFwdlpSUFowdk90UnNuV2ZwQjdNOXJ6SmxNbWdLaVJzYWRUeWxTMjhxTms3?=
 =?utf-8?B?bmxMYTYvSkxpRWJuMmtISkVyLzNGSS85bTBwS2JoOHBDQjhjc2FrSkpLZG9C?=
 =?utf-8?B?dldIa2RtbW9Hd0h0WnFCNGsyaldocWhiVDFnYVdKeHZadGRmL0gzM0RIditk?=
 =?utf-8?B?NEpHcms3MXlLVnlocUVYRzRaUlBTYStEV0RGM2pkYW9FU3pmbm5mNy9DNXly?=
 =?utf-8?B?c01IZ25GcmxJK3EzMkEvL1ZYMWE3TTBBQ0FmdnErTmhETTNjcU9oR3NwRkpD?=
 =?utf-8?B?a0pYT0QyWml2NGN2U1ROUkVreVNLSk8yRnVoNk1lRXJzREJLczRFV1FobEdC?=
 =?utf-8?B?MGZYaTNzNkxqWUZVaUpaMFdTMSswdXlzWDNPUGpWMncrWW5NREo1ckk4SllF?=
 =?utf-8?B?aUpraUlZeVpHU2tOa3FobXFLZXVBak50YXR6dURFMzNvNTFkbTNlemxFY2Vm?=
 =?utf-8?B?WGpkWkRRaXcyR2hYZWFBbEtRMzlxem1UWXRwd2Yra1VsT3JSeW5uZmwwdVR6?=
 =?utf-8?B?NFNwbUlvWS9EQy9ITUJVeDd2c0pMNDQ5YjQ5MVUxT0UyMnlkd3ZvdFhhMkhH?=
 =?utf-8?B?UjI5ZTliWkw2QnBialZZUSs3bHFIMzNBMnkzdWhHZnEyK3FBV1VGRWppWTN4?=
 =?utf-8?B?OFRFTmRxeDBYek5mVHdsOFdaT3Y1LzZBdWhoTHMrSXZDWnhWL2pJL09hblZz?=
 =?utf-8?B?TDhRSmRwcjJxQVNpQ29LSHJvWjNmb21ZTm9rVEFkSVpVNG9OQkxNZ0ZsRlh5?=
 =?utf-8?B?SkVUSmNQWkk5SmxrTmwyeUgwQUV4aGNXVjZPeWhCRHg3MFM0OHpCMW1GcWNH?=
 =?utf-8?B?LzRiZis0aTJxQlpEcVJLWlRxY2VmQmpHWmxGMXQyZ1RtZG5ldXlIcXhNRVpt?=
 =?utf-8?B?VzFPaHkrS3Viam1hdDhRMTZoNGtEYWRtTzI0T3BxYklodlJ5dllCd0paVXZy?=
 =?utf-8?B?VUFvVVNkNHJWdWpUVVNGTGZaSTJMSEN2UFM5b1hiaHk2VHVZRjNhUG1zRTVG?=
 =?utf-8?B?bW1zN2JqbjBUSzhIUmYydm5qQjcrU1ZkOGFBeFJ4R1JlNG44bkR5WS9qektE?=
 =?utf-8?B?N3NiQ0tESVJMMFBWUHh5bm10L1pFQ3ZmVjNvWHhqNmg2dDQ0Q2o4cTZHbG9h?=
 =?utf-8?B?RmJldExUejR4N01JNHk2dVJJL3B6RCtSVXVxbzZPY3FKSHRKZnFmeWozOHha?=
 =?utf-8?B?N3NlRHdPZ0tuU1NjSHlxdHIyT21GWkxoMVNaTStYcXl6amFLOFd0SW8ycHpl?=
 =?utf-8?B?MTJnaXJSYU9sR1pPU1ErTGJGbEcyTUJDM3FzblB1ajQ0bG1NbTdnNXRLaXhh?=
 =?utf-8?B?KzRMRWI2QkdTQVNMVkRnM0lLUytOMGc0NTY3c3VheDc4QW81cXVKSFhCVzZm?=
 =?utf-8?B?V1BXaGxvVnhqNXVxZ01nOUZSMTh3K0JnR2tEeG1xci9YbS9ObTRNN09mUklx?=
 =?utf-8?B?ZTFKcUNidk9SUmtFWUhBZnV5SEQ1ci9UVTA1OEZkUmVlSTJKWEpFSWJ6dk5n?=
 =?utf-8?B?WFVWeUlDVWVTMTVoS3lNMkJ3cUpsN1RlVUVWVVAwdjRYbGI1T2t2YnBkVnI1?=
 =?utf-8?B?YlpnckxvK3grZWw3c0lWQUI0RngzYWZXQ2RlU25EK0xZOVF1di8xRk9Ud0k0?=
 =?utf-8?B?NHdPcHdPd1hza1NsWkE5QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGphanEwc0dPY1RML2hEeW9YWDcwOSszSGpKcEtKQlVDT09MOTdjUldjeVRB?=
 =?utf-8?B?VklwTWJhK3hxRS80TGFucW91ZlNhbFc3RFZ0b1ZRZm93bUxNS1VNQkVKNVdM?=
 =?utf-8?B?d3dCR3BxTjlSTGUrSERRclFuOS9XR1FJTDhzUXJiT3B5V2MwMTAyS2lnYkQ5?=
 =?utf-8?B?T09JTDJ2QlpDa0QzNW84aE12a242dkQyUXFNSGs3U05veWRYQWE4YlJkcGVR?=
 =?utf-8?B?RnhmTHkwT3FqK09tVDhNZVpEYnp1UG4xQnBWZ09BaGsrWlFyUnJ3cFhrRFdY?=
 =?utf-8?B?R1h6aHZSM2dlVDlnUFNmQmE3Znl4elR5WlBha1EyL3d2N2hKQ2lXZ3dDWXh3?=
 =?utf-8?B?K3JPcnRtdFJ4M2ZwSjZwWEw0Z0hhNUtlSUlrMG1oY0ROTVNZcStIakEza0Nv?=
 =?utf-8?B?SzF2NjRvejlNVlZWa0gzcFkrUDByeExDdXpjWWlVN0VPM1E2alpwM0U3VVVl?=
 =?utf-8?B?S3RhTjVveTFYUWNBT3hIWnlCZWd2bUdjUk1NNXNOK0FNRE00WUM3cGdDZXNl?=
 =?utf-8?B?UXFVZy9DVU5sM3F4U1J5M3dzS3hPUVdrRGdGR3hFbTA0NVpMREY1ZXkxQ3FM?=
 =?utf-8?B?K05UMUcxY2VueVkzdG9rcFhXNDA5cDEyU3RwazgwRUdJcTlQYWgxWE9Pb2lk?=
 =?utf-8?B?RjdZb2NCbVpqKzhZS0wyZk1mWFNLNGlST2o1KzNpQnQzRHZ0b3pVUzcrSy9Y?=
 =?utf-8?B?MlhMaitxcCt0VjNuNkVhdWlQWEZ5aU1hUCtMcWRzY1hXaS9wdXRaa3lrNVF0?=
 =?utf-8?B?ZXdVdGRJbVVnM3RBUWVoeUora1lSR05YK3BPU1BybzdqYW5tdmMvdE41TEUw?=
 =?utf-8?B?RysrNEdYNFE5N2NDRU0xVlM1OEJSa1hrQ2VLVFJqN1E0WlY1WVEzYy9MMUFu?=
 =?utf-8?B?VUlUSDRoOCt3dEpvbU5oWW0zQUlHNlB4YVgwM1VRSmpCOTNtOHpBVlU1MVVX?=
 =?utf-8?B?VDMrRmkyV3lrY0xWejZwRUxHdndBcjhQYWk2UllzZFdqQXRkZXpDWVBVOHha?=
 =?utf-8?B?NGhwb1N4R3VoUWlYWVIvZ21hb1JVdG1BdElUcmRBa0ZsR0NtOGZxZmJjenJD?=
 =?utf-8?B?d25HRjRoM3NzbjJ6V0pzQjU0QUhFK3RTTFVGQkllK1FWUXJyTWFnVnFZZmRX?=
 =?utf-8?B?a25PNFVITWZ1M3hNVWV0WksvcERjN0ZKdjRuL1AyQmJPVCtxbzExenFyQVN3?=
 =?utf-8?B?WmtnZWtLTFBxckI4TUp3aGZhb3Q2bkRLZnpXcU5La25CZHJOYmpRbXAzRFlp?=
 =?utf-8?B?ZTluMlA3NFJzT0szTXZ6THM0UnBHWHcwbjBkSEc1Y3lYUC9VdnRMREtaYU9m?=
 =?utf-8?B?R09ta21ocTJoczZZN29DWjVlQUd1R2xGR2pvR0p0YzJCOVUrZkhXdndobTN0?=
 =?utf-8?B?ZWNUQ1V3bUVKSFA2QWJsQTUrZWQ3SFpaSW1BWXJEbk1wQkhoRTl5eDRtMlpq?=
 =?utf-8?B?TXB0ZVlYTjB2MGN0ZC9rNGNjL0NwYkNwUzF2WUxaakw5NmxxaE5USE9kQ1hD?=
 =?utf-8?B?RTBaSWVkR3ZQQytnVnB5NFN5WHFRbmpCMkxiZHlWNGZ1Ly9od2VuR3RvU1Rl?=
 =?utf-8?B?OTdPQiswdW1WY1llcTUvQmY5L2ZOR1pCQ0wzTnhqdTNSQkZhNDVPdS81dGdq?=
 =?utf-8?B?eHZDdEo0M3h3SWdmS2crRlMvYkI1cHo4MDFvTjl3S2dJVEZtaTVERlF5bzNl?=
 =?utf-8?B?YTlsRnZYelhabzdGUC9wTTVUMERXMTZNaU9SRlJlNGgremUvVFJpSEFHWm5D?=
 =?utf-8?B?eTl1L1REaEYwaTZsaUFLY0lTM2h1NzJMMFZ0NXA2TVR2blk3UlJKOXlmNUtl?=
 =?utf-8?B?U0dtVFFDTFNtYkwzZVRYT0kvclRHaEExS0hSWWppRmRmUy9oOWpCcU5ialpF?=
 =?utf-8?B?ZXBJNDEyVm1XN0toU24wK3ZqTFZqWjl1SmxGMEJnN1JMNW4xNCtTVkdBLzFX?=
 =?utf-8?B?VGJMTTlpMjhjcG4xTTd1Yk9vUDVta2NCQURjcFJMN20ycXZFSnhrVjRqOW5P?=
 =?utf-8?B?OEdDL3NWMXlaaFo5STRGc3hwcHJWd1hhSkdKdVhjSkxSWk5oVWpTeXRKUXVn?=
 =?utf-8?B?TXdqN0xmQWxDVHdXQ2w1SWVuc0Y3MXVTTU5BTVd1VURCRjJybGJFM1VnNDhJ?=
 =?utf-8?Q?S1cL/5JRfGudRNCAj0iUn7q9y?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f9047e-691b-4727-4a67-08dd130bc6bc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 19:59:07.1349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J3uRT7OYQPccf6Gh2hEi0bRAVQnKUHilHts178Nfw19pZO91Ei9PjvbqmVfljZSvz6L48V88YvC2134a/MU7gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4798
X-OriginatorOrg: intel.com

On 12/2/2024 11:00 AM, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> Documentation/arch/x86/x86_64/boot-options.rst is causing unnecessary
> confusion by being a second place where one can put x86 boot options.
> Move them into the main one.
> 
> Drop removed ones like "acpi=ht", while at it.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  .../admin-guide/kernel-parameters.rst         |   3 -
>  .../admin-guide/kernel-parameters.txt         | 237 ++++++++++++-
>  .../arch/x86/x86_64/boot-options.rst          | 312 ------------------
>  .../arch/x86/x86_64/fake-numa-for-cpusets.rst |   2 +-
>  Documentation/arch/x86/x86_64/index.rst       |   1 -
>  arch/x86/Kconfig.debug                        |   2 +-
>  arch/x86/kernel/pci-dma.c                     |   4 -
>  7 files changed, 227 insertions(+), 334 deletions(-)
>  delete mode 100644 Documentation/arch/x86/x86_64/boot-options.rst

Thank you for incorporating my feedback.

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

