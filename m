Return-Path: <linux-kernel+bounces-367171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A8399FF7A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 809161C266DC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA15D17622F;
	Wed, 16 Oct 2024 03:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="maRY0VG4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F2713D53D;
	Wed, 16 Oct 2024 03:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729049140; cv=fail; b=XxP/gxS2+kYFK0iQTDm4xi92j6fk7qgXAYbqvqJDUmhYPKxb9zK2MV8oFF0JvOzeTJiA+jXc9IMQW77PKIKYFuUewtesro01hQlRwyQ/zF4XEjlPmyvIJxplrBQFLaGWohz4+itz4NPSQDHANVj850Rh+qCErT0dKhq2VqSoGgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729049140; c=relaxed/simple;
	bh=dxVoNwtJJ4e1ZQHOzB/Zz7Dvuq37b2+2xU5X8PY8veY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lwSd5oz7Chf9rHB71qBmZfT6zYtwBp2pNFWvkdm6eR8NmIz9Yk5w/YHWl1iwO/ya0cFEdJy1R+6VNYMDGQm6y4RlShsgHykFxnm5czQREzRU3M6LPq+uUjM7Ca17AluN+h7qJN0QCGCGIr1ZjSgR7VGZ/qwVhN30h4NocQr9yYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=maRY0VG4; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729049139; x=1760585139;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dxVoNwtJJ4e1ZQHOzB/Zz7Dvuq37b2+2xU5X8PY8veY=;
  b=maRY0VG4lXcqmV+ICc+KRc306M6KlfRzWrcegZ3XuHaR+aiHZuIZJJGp
   4doKZI5+4o8MVpDbdK3ug5VJgW7gDbMcYbCpHzjKnlZO8gMx+cQxAOE3c
   0tzdGrcOF4XcEKWXsJRWar9qMpDduaCvrcspQkwTp3cn+3ac1uAtQIGNB
   G+FRiDpKqeLgHYX5ayVnoG0yn+QSciuZXIrBksHHLXyacUbZ6a4Qq8K6x
   tagw4vfq75hQMllQ9+8iefIeYECjFnQwbPCkfu8Kkw0NiEb6y3W5ujAhg
   8nb9O2k4d6oNs/0S7IgtDjkVml8cIf93DXyaXhSSvRj/HeGoGtsyoFOOf
   g==;
X-CSE-ConnectionGUID: QEVsdde9QceqjHf413jF5g==
X-CSE-MsgGUID: AcMZSSs9Qo61hfvfKtqRQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="45976806"
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="45976806"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 20:25:38 -0700
X-CSE-ConnectionGUID: Hk890r/bREuK0gz6Xhtq8g==
X-CSE-MsgGUID: uJ3O6kkwR52G/XMU6LGTqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="78443806"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 20:25:37 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 20:25:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 20:25:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 20:25:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ui45Q1T+rsRzpy7aUB3XSangbx//uTt/UFsg2gUuyzzFAECk8f6RsgqpZ+jienYozao7irQK9FiiI8CqGriyQmoWVBFc0IWCMJaHdlfTzhoc7czzn2+Uo9z+2jHC1L8GhGAqYnlO4cUXVfdPd6bLAzt1nGdsNwhgdpWJdDJAmw7oc8CH81vmcy+SzissI+WdP3Q4mf7VpilxnN1CWH80eTelDJQq0gB2G+KFVKd9hQ2AMpm6dJoMcSoi1pFrrnO6UIW14h7omIuHVwp1RM3TMXC4LLtrl5ZK89NRzRYwnjR2mtq4IZgo4lUrSF89WcckC+b/ry9mgtpc2MLF1HWPGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IS8SQZzfTb6+jVHR8JGt9xIv+95/JXu0NdqMrmuohPE=;
 b=x0NL6CgZtS4ny8vucdMMHE9rxIwCk5q7nsfZYPmQIm3dyVDcCEiRvTcn4YUOmtF/vtg80SjDFAZMBhqC23/IX8w5ycb6UShw63CawudJNa0gjWblDWoYOaF4U9HYJcwJl7CcWeg7U2yHulvHMh4mmRgMlOCrBhFbYpRLRMxbBFQJe8UhPJusyvYC9D8IM9bn4VKaPH6gs57evrJAG2Aag5Ksy3YEBmF86iO3RAo4ftvGo+aPSFBbGSYGKfavTZiV5Y3H4jPrUJM4j4kxDLs743vbLY4kFE5uNKtzX1I10FglUChMKNrBwnJj7yaNjLXsZt+boxh35omae9zLk8Gttg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM6PR11MB4723.namprd11.prod.outlook.com (2603:10b6:5:2a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 03:25:32 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 03:25:31 +0000
Message-ID: <367f3877-e23c-4115-a004-1480ad2ab17f@intel.com>
Date: Tue, 15 Oct 2024 20:25:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 17/25] x86/resctrl: Add the interface to assign/update
 counter assignment
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
References: <cover.1728495588.git.babu.moger@amd.com>
 <86c8fd4db89f264b1382cd22d7cf53c4510bf07a.1728495588.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <86c8fd4db89f264b1382cd22d7cf53c4510bf07a.1728495588.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0154.namprd03.prod.outlook.com
 (2603:10b6:303:8d::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM6PR11MB4723:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c765b55-2b47-4e53-8d09-08dced9230aa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2N2SWRIdkpaTko2aS9jVFhvekE3SC9NTWpnMTJ6MVg5NytCQXdUWXRoa3Z1?=
 =?utf-8?B?MVg2QVo3K0lDWFpvT3hwOWJiZXJ1cVNFZndHSi94dGNOK2UwKzB2N3lnOHdX?=
 =?utf-8?B?QnBWTEJwbTZtS2ErYTdaOEVvQ2NwV0VVN1ROMXdDZ2lsU2k1NloyMTdsY1hZ?=
 =?utf-8?B?cmh3NkxKRFpzbHJFYWRBeVdFb2ViOCtJSTdvZldGU0prRHBQRStHZ2oyUEdL?=
 =?utf-8?B?c0lBOEdvck9QYzdsd0VqR1lUSy9VZDhIU3VsQS8wV2l0QUE0VHdYZFg1eksx?=
 =?utf-8?B?azZNQnEyYk9veE1mbVIzdXhRVVdtb1daK3ZNTzArd24xaDlYWDNsK0hYSjRL?=
 =?utf-8?B?b2NCTjFxTTBuck9uTzhLdEVlWEhOcThWL3hlMUJwMUVHUnNlWitmUUJNb1VS?=
 =?utf-8?B?WmhJSHRJS0QvWDFyVnFJdnY2VHVvQTlDdWwrZ2VCWG0wTHZWVGMzSTQzWm1V?=
 =?utf-8?B?Z2JMSlNRVVBtbU9VS0ZTZWszVmxjYVZsRHhsdnFmcUtqNGdyQ0NnYnB4ZlFk?=
 =?utf-8?B?d21xNGNpbEo4cVRrN29YSlRLblU5clJTNXlTRXdnVTB6eStPbGg3bUU4a3Z6?=
 =?utf-8?B?RE5yOTJ2SllFcUJRbi9aMWtJYjEzcmdqclBWNEQ1aFErL0prVHo1YXdLa2ZW?=
 =?utf-8?B?c2JBYjZnVlEvTkdqY2x2R3llLzRHeTBQZWwvQXZBcU1XbDJvZ2poYk9YTUZU?=
 =?utf-8?B?RkRENTVndkxtWGhyUXhJc3ljTi9XQVBmckRXcnJKVlZaNjlZWFFnUzlhYWRy?=
 =?utf-8?B?dW9YSFNFb2pLMmxnOFNEZFVtOEZ4NC9veit3OVZ4bThWK3Q2dlJ0bGczS1pS?=
 =?utf-8?B?ZnpxT0ZCdklWR3hTallIcmV6Z2pVcHlENldVN2hEREVXckduZFBIZlg1NDdL?=
 =?utf-8?B?T0VjNUt2WGpxR2w2Q21mME1UMnF4YzBQZm1SWnREZ2htM0xUTCtsYnF4UFp3?=
 =?utf-8?B?cTNOVDZ6eVoremJLUUV6dHhxWmI5U25PQlpZTFRpRzB3dnJRdjAzRGdHU2dT?=
 =?utf-8?B?SUJ2QmNSblVTclNmcWVKQTNlSVBYaDg5cDFlZnJ3NGQxbC8zT1l2TThVTHlI?=
 =?utf-8?B?bS8wYkRsYTdFZXRtck9JSUZKYmU2TXhmNGFwSVVLRWpkcjlqbzlpUGl6eTZT?=
 =?utf-8?B?bTZMeW1EOXZBcnJOMisvejhsSkd4YjZuNlpLd0QwVDlvSW8zeFdCc1N6SVli?=
 =?utf-8?B?QThaRHlXSnd3THNDaXlEQU9YaWtETUpQUzdySUNvVHRRYXR1WE41MHhMUU96?=
 =?utf-8?B?a2lQZTkzbHM3KzI3U1RscUNuUWV0eHI2V01hd2hxekVGMlVkMnc5dG11dksy?=
 =?utf-8?B?K3dtMTJjWm5CWXRySDJmdFZRb2NobG01T2cvN0JGSG02cHZPLytqUWZhNEpq?=
 =?utf-8?B?Q0t5V1g2cGZRVWxTd0lKMUJLeEcvaloweGNxc25yd042NXk2VEhnMnI1VmZC?=
 =?utf-8?B?dFFDdmhVckw4UWw2TWI3TTVHNWNkOHJaV3ZSMUZCUk5UU1VyeXA3c1hZVExy?=
 =?utf-8?B?MkJrT2hTTXp0SVpKeVc2bWpVNDFLSkcyTU45K2xVdWZoMkhVaEpXZks5bnZY?=
 =?utf-8?B?WjNBdTVRL0VXUWE5V25vS1pWMEdJVUs0M25KYUNieXZMem9SQXhwbHhjb01v?=
 =?utf-8?B?dXlXMVROcTQwWjhtQ0RhbUhNQW5YRVpZU0kvbjh0ZVVJTVBQS3grTUM3RnEz?=
 =?utf-8?B?ZDVESURwZUdVWUNHNUxKTCsvRTdGT29BSDJpMHB6MHVrTnlleVRPbnV3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEZLSDAyWGdmTmVEcWc4UDllQ0FFeGhHcWoxS3hVZ1l5dHYzd2xXT2wvaWxQ?=
 =?utf-8?B?b013aXJXRm8wbTdqTUxpK1pOMWxZcGtBOUhkUjZXdlpad2lRVmo5NWZJWCtQ?=
 =?utf-8?B?eWJZVGV0U1BHWElhdkt6ckl3bVQrZXJlcmxWaWJnOElXcTZmbW9rOHdFSFV2?=
 =?utf-8?B?dWN3czQzSVRCMVFldFdWYk9PUnVLRlVqUDZkckxvVGZDMTlTUzJ1a1B0dmww?=
 =?utf-8?B?R0lRcTFQRkJkTmFzb2FZU1ZxSXVITndoUDhlUDJQS1J6Tkw4Tjh3K2dDSlRa?=
 =?utf-8?B?anhzT0lnYlVjRFN0SE1DL3JxamFocGlPNzU4ajFDaXBNbmxwakR5SitsOG5N?=
 =?utf-8?B?K2hNdmpUQTZYMlorU3U3ck5JT3FVcjZDZ3ZHT1lqSlRHV0ZFNkZGYXcvNGlT?=
 =?utf-8?B?RGVNU0poZkNsUDJnU0hLMkNiRFJPSjkzY1FUdWlzSkIvWGpaT1JqT1NCaXQx?=
 =?utf-8?B?NG4wNXIxd2F0b2NqY0lTbzZDRFZnaHNXTzVQSHNhSXZLVUYvcm51VExBclV3?=
 =?utf-8?B?bDZTSUxacnZHbWVaWnN4RzR5aGhoOTZjRGNaU2FVZ2w0MFFwMGluL0l1M29w?=
 =?utf-8?B?Y1p3NGFFNGp6bHI2Ly90bFlkYStpc2d0VjBGeFhJOXBWRUFGK3oxb3IrMmNS?=
 =?utf-8?B?RXFQMEJzK0loZm5UVDhWTnY4MmtOTFN4MmdpVFhWNHhBckU4ZjM4R2ZZU3Vk?=
 =?utf-8?B?aUNrR25iZXlsRDlzbThVYTZvSEhoUFBPN21PS3p5VlFzQ3hoODVkN2hmbHhm?=
 =?utf-8?B?T2d1aEd6Ymh6TCs1S3BVQ3pCY1RJRkMyckdSOU5DZXhoQ0JaZGRIbHVjMmdJ?=
 =?utf-8?B?VXVTUGxobm9RQUlLQnVUallBRDVOUXFBQ25kM1ROejJIY2tUQlgyaFJ6K1JQ?=
 =?utf-8?B?TUJYTEtsRGdiSndURXpnd2FCWnZSNnFMN2ppdlllcHBRb3M2RllFVTNFY1hC?=
 =?utf-8?B?K2ZzVTNuSnVWK3RycHhvS2ozazdBaWNkcnFVa3lDb1B5WlJiRXU3c2ozM0NG?=
 =?utf-8?B?VjU1b1IrbTJ3cXdzZ3h5dlFLdnNqVFhUMTl1aEtsbTBiOHZnb0s3VVdkcFQ4?=
 =?utf-8?B?WVIrcG9jb0hvbWNyMmY0aUJqOUZXSXVIcmxzcmVua2h3Nmp0aUhkanh1ZzdJ?=
 =?utf-8?B?MldZa2ZPM284RCt2WkJKc2tzSjVyS04xOWt4ZEhpa0JRVGN2SDcyKzVHOGFB?=
 =?utf-8?B?VnJTR2xnamN1WnlySFM4NFZtTmphWDJKU0VOdXZldG1kUmpGQitiRmowRENU?=
 =?utf-8?B?UVdPYnU4THB6SkFQMytNNzZnNTI0TzRtVnB2SW9sdjRPQU9yc0VIZkRIOG1k?=
 =?utf-8?B?SVFoenc4Z05xRkpIVWYxTVpSV1MxeGxHMVp0ajNvVzIxY21ydFk4bElhOXVI?=
 =?utf-8?B?aG9OTVJUVU5Qamo0QjJxM3RkWDBzVEpBUDVnSlM4WUNtcWlqclFHRS9FeFVV?=
 =?utf-8?B?N3BqU3QrRjIwNHhNcVVIcVVHSzRtZDcrZlZkRXZYR2Nod3FxbWpuOUdGYmZK?=
 =?utf-8?B?WlZqTlF6ODh2dmJQOGlIMlVVQmF3VWw5R1JPRG9sVXo0OUl6Q24vMEU1aXRa?=
 =?utf-8?B?cWNJYWJFbE5aZFNJVGs5czRuQUQ5MnNTWmUycmtFU25YRVBCUllVRW9LdHlX?=
 =?utf-8?B?T2FTOU5PcW1ldVZRWVJIc25vMlNEY3FqM2NNajZRQ2Vta2NQeEhNQTBHV0Zq?=
 =?utf-8?B?N3c0YWtYRUFVemd2MmJ5WjhmL0d3YndUUk9rcmUwYStNdit4aGVLb3cxeC9N?=
 =?utf-8?B?bi9xTVZNMVd0Y2hXMld1R0d1Nk83VDdiV0dLLy9HYVhoaEFkNUw0YjBIaUx3?=
 =?utf-8?B?Sk5IR0RXYnFBdFdRdUZEU0R1bE1abUcrK1NmKzgxQUwyVFVZZVV4NjR1bXNv?=
 =?utf-8?B?S3Q3VHNwQ2hQU09UNkZEVjcrb3RvVlMrdXFldWhnTWNJT1d5Qld4dXRQUytN?=
 =?utf-8?B?VHk4VkFBRkpwNjNIektHeWFwdllvTGhMZFR3Tjc0VVgwNTR5d1lUa042bXhR?=
 =?utf-8?B?OStieWRnWTdML2ovcEFwblE1Q2ZXeVNQdXBrZ1plWVhNTTFzNkFVWEdNVXBs?=
 =?utf-8?B?OFJuRHhCdkdxNlVVeGV1ZzVqZ1UydnI4RGVSeXFnN2M4VCtoTFdRTjVMUlZH?=
 =?utf-8?B?OEs2dUx6ejBCbFFZNnpDOFdHWlNZcVp3SDhBV2lOQ082d0tORU1JYUhOYW9Y?=
 =?utf-8?B?TVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c765b55-2b47-4e53-8d09-08dced9230aa
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 03:25:31.8409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uilCea52gpv/KERNUrTCV5epYUwIOm29YuLAwrxbC1/7+YmJTfX7dOvuvjEZC6WBolUiTtwrdAxv9tFNdSnCUJpu63FlC4+NnygwIk5yZ+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4723
X-OriginatorOrg: intel.com

Hi Babu,

On 10/9/24 10:39 AM, Babu Moger wrote:
> The mbm_cntr_assign mode offers several hardware counters that can be
> assigned to an RMID-event pair and monitor the bandwidth as long as it

repeated nit (to be consistent): RMID, event 

> is assigned.
> 
> Counters are managed at two levels. The global assignment is tracked
> using the mbm_cntr_free_map field in the struct resctrl_mon, while
> domain-specific assignments are tracked using the mbm_cntr_map field
> in the struct rdt_mon_domain. Allocation begins at the global level
> and is then applied individually to each domain.
> 
> Introduce an interface to allocate these counters and update the
> corresponding domains accordingly.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v8: Renamed rdtgroup_assign_cntr() to rdtgroup_assign_cntr_event().
>     Added the code to return the error if rdtgroup_assign_cntr_event fails.
>     Moved definition of MBM_EVENT_ARRAY_INDEX to resctrl/internal.h.
>     Updated typo in the comments.
> 
> v7: New patch. Moved all the FS code here.
>     Merged rdtgroup_assign_cntr and rdtgroup_alloc_cntr.
>     Adde new #define MBM_EVENT_ARRAY_INDEX.
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |  9 +++++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 47 ++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 6d4df0490186..900e18aea2c4 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -67,6 +67,13 @@
>  
>  #define MON_CNTR_UNSET			U32_MAX
>  
> +/*
> + * Get the counter index for the assignable counter
> + * 0 for evtid == QOS_L3_MBM_TOTAL_EVENT_ID
> + * 1 for evtid == QOS_L3_MBM_LOCAL_EVENT_ID
> + */
> +#define MBM_EVENT_ARRAY_INDEX(_event) ((_event) - 2)
> +

This can be moved to patch that introduces and initializes the array and used there.

>  /**
>   * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
>   *			        aren't marked nohz_full
> @@ -708,6 +715,8 @@ unsigned int mon_event_config_index_get(u32 evtid);
>  int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>  			     enum resctrl_event_id evtid, u32 rmid, u32 closid,
>  			     u32 cntr_id, bool assign);
> +int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
> +			       struct rdt_mon_domain *d, enum resctrl_event_id evtid);
>  void rdt_staged_configs_clear(void);
>  bool closid_allocated(unsigned int closid);
>  int resctrl_find_cleanest_closid(void);
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 4ab1a18010c9..e4f628e6fe65 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1898,6 +1898,53 @@ int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>  	return 0;
>  }
>  
> +/*
> + * Assign a hardware counter to the group.

hmmm ... counters are not assigned to groups. How about:
"Assign a hardware counter to event @evtid of group @rdtgrp"?

> + * Counter will be assigned to all the domains if rdt_mon_domain is NULL
> + * else the counter will be allocated to specific domain.

"will be allocated to" -> "will be assigned to"?

> + */
> +int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
> +			       struct rdt_mon_domain *d, enum resctrl_event_id evtid)
> +{
> +	int index = MBM_EVENT_ARRAY_INDEX(evtid);
> +	int cntr_id = rdtgrp->mon.cntr_id[index];
> +	int ret;
> +
> +	/*
> +	 * Allocate a new counter id to the event if the counter is not
> +	 * assigned already.
> +	 */
> +	if (cntr_id == MON_CNTR_UNSET) {
> +		cntr_id = mbm_cntr_alloc(r);
> +		if (cntr_id < 0) {
> +			rdt_last_cmd_puts("Out of MBM assignable counters\n");
> +			return -ENOSPC;
> +		}
> +		rdtgrp->mon.cntr_id[index] = cntr_id;
> +	}
> +
> +	if (!d) {
> +		list_for_each_entry(d, &r->mon_domains, hdr.list) {
> +			ret = resctrl_arch_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
> +						       rdtgrp->closid, cntr_id, true);
> +			if (ret)
> +				goto out_done_assign;
> +
> +			set_bit(cntr_id, d->mbm_cntr_map);

The code pattern above is repeated four times in this work, twice in
rdtgroup_assign_cntr_event() and twice in rdtgroup_unassign_cntr_event(). This
duplication should be avoided. It can be done in a function that also resets
the architectural state.

> +		}
> +	} else {
> +		ret = resctrl_arch_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
> +					       rdtgrp->closid, cntr_id, true);
> +		if (ret)
> +			goto out_done_assign;
> +
> +		set_bit(cntr_id, d->mbm_cntr_map);
> +	}
> +
> +out_done_assign:

Should a newly allocated counter not be freed if it could not be configured?

> +	return ret;
> +}
> +
>  /* rdtgroup information files for one cache resource. */
>  static struct rftype res_common_files[] = {
>  	{

Reinette

