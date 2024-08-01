Return-Path: <linux-kernel+bounces-271870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4766C94542E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 23:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADAB9B2208B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD88C14B96F;
	Thu,  1 Aug 2024 21:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JiftHiRv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E0C19478;
	Thu,  1 Aug 2024 21:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722548430; cv=fail; b=jpWzh+1BDgSXp+CIaHA6JphMeFxtp2MLR0EjxUGcl3ywNd9Fn5hz9pmYFjn+mYz4gNNprwZJicxewyi7XAPi1JsVn/MUQ7x/xvBy4zPI3XUo2m+B6H7vek71Va0SMkOoueMWnDQA5+yV+jw/uUqRFVdrqnj6oGFWSPX5gTZrFEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722548430; c=relaxed/simple;
	bh=7sBORWfVZAT3+1xn35x3WOmflW/cUmjs1Us2j84LfsA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LPP37CF6pEVEWXjYlI/it6aaHItoEKaXYDm0FNjqfB3paJoWhm5Nq3IxAA7qoBdT4dwEtzXEK9k/KzHR6xe1+PytbfbPvxNnYa+FOvOD6aYQ+JuPWYGMH+cjGoqwJmyojLnENywg1yTk+1La97Pby3RirCUrUPiIPF2qHAHtxiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JiftHiRv; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722548429; x=1754084429;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7sBORWfVZAT3+1xn35x3WOmflW/cUmjs1Us2j84LfsA=;
  b=JiftHiRvLpzRH+CoZQaxHeNRMIyOAUIDycCbltgalB2JU9jGf44tSiwR
   oYG22VfEDzWnFAYQqTN+W/dkVEN2WUwuip6wrMIIdSKcK2h/bUeYrSpCA
   v3Hf2FSfIS2Ulm1qNiW0h0njnF2TTkAkOJeKu423q7urQCCfnWhXmIylo
   D1ZKay3CB+vqb1zUgeU34YxL0PR9kZ3y4U0JYXjYyLPfNK67ZAikLpIiC
   jkfu/b1oruCl2oBxfjf8+mnIc6cQe0oyB7hPBgTIhuHinAcOzMTuT30t3
   UX2NfS2gPNrtFdDkqLkSaeYq4yLAQXse62GIhCzMbuu6YTjWlfWWtBVYG
   A==;
X-CSE-ConnectionGUID: TR+oUlikR1KaSHwk9mdLtA==
X-CSE-MsgGUID: 8hMLnWRkQAaNudH2QAUbXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="20382231"
X-IronPort-AV: E=Sophos;i="6.09,255,1716274800"; 
   d="scan'208";a="20382231"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 14:40:27 -0700
X-CSE-ConnectionGUID: EelxzUEmQ2ie9LTCAOVwmA==
X-CSE-MsgGUID: +faZI9CISRWXdZnpU98qBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,255,1716274800"; 
   d="scan'208";a="55962019"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Aug 2024 14:40:27 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 1 Aug 2024 14:40:26 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 1 Aug 2024 14:40:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 14:40:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWEjUv1O5/0ntsKbfTGOhy+DZJ9lpqGwsBog7RO1BIJrYYjFQ4a1fFiRJiXfexGG95qCWFBG4ChlrZDmKbG80F9NIHi/EDeAHf/U5ot92lIhVnYkSNSdF9SsLuYlLdxczSvpUq2PPXe417/lLVW6FXR1CR2If8SN6fQaU4QZMbmmYAPYJ5IFeVvPO+nsFPY6FJUGwFHRxSpQks679qU2hKY5EhfYdILZdClZrkmQVqtcPrKTm5Fw+2BPWRYcdB93iPTp5B9xvODt6RvZrMmS8+2BN5qDqpBY5+2F792E0MhYXHH5PJNH0PtxM1wSvUm6myRWGN6Hjz/0tYovyW+NPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoRGyrEvrj06ySdSOR7nwcoBFKQqEiHbc0gFjSE5fIM=;
 b=l7Nj+MkOYdUI2qeWjz48mgAgdTQTNRINCUeEirZIesGFelmy/GpoRNhqt9KLnSxRI5J/y+erRfb1UjREs0SawvU634Ia6GSb3+RsuA17gBYX3t7aaD/rscDvn5baw/okOEb6X7BYbCCxR2Czj0hynh71cSR1Zdw1aELV77WSDAly7lFR/x4/4W+Z7YH2xqGpYF4AvpDePkqx+Ya0tw9kubNO/rTFDY0KLS3TW8UnMei9e2gMk09dinELyJj4x5EX9SXiWr+Lu6bNVo5uvJmlvTsg+jdpESCyZWVVNiBn+6Gx26X/vQBefUpT7zA1+5693/MxsoxnK6T3AFyEqN3NQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6513.namprd11.prod.outlook.com (2603:10b6:208:3a3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 21:40:22 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7807.026; Thu, 1 Aug 2024
 21:40:22 +0000
Message-ID: <156f0807-964a-4980-8ad8-aa6735f9ffb6@intel.com>
Date: Thu, 1 Aug 2024 14:40:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 18/20] x86/resctrl: Enable AMD ABMC feature by default
 when supported
To: <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
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
References: <cover.1720043311.git.babu.moger@amd.com>
 <9f03d5661a4f054124cc7ae1903207714c5188ee.1720043311.git.babu.moger@amd.com>
 <d9de1a56-8b0c-484e-bf44-69891a2e9894@intel.com>
 <eb7f2b83-8d2a-753e-b7ab-9b004af2592d@amd.com>
 <9f46a7c1-818b-8847-1676-a86a31feedae@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <9f46a7c1-818b-8847-1676-a86a31feedae@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0116.namprd03.prod.outlook.com
 (2603:10b6:303:b7::31) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6513:EE_
X-MS-Office365-Filtering-Correlation-Id: fe330fea-a318-49b1-f655-08dcb2728bb1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGlJNXFnM2ZjU0srcmVvWXJFS1hQVGwzdU1YejVQVXB2UE8wRGcrNldlUGlB?=
 =?utf-8?B?anNUaDJLVEkxd3d6NjlIZTBFSWkzWU5XSXNIOHpZbGVpaHp3RlpyMmYyMDFx?=
 =?utf-8?B?K04vOHV0ZUdGcnBwZnFUalBQeU5KWVV6OWZMY1VzUHdwekVJSE0ySmhPUERa?=
 =?utf-8?B?LzVlWm9VdTdJOVV4aU9haFVQVDRwcUFJQWhUditvMkFsQ0pZcTVpdjJNMlA3?=
 =?utf-8?B?NGgrVnc3Yi9oSGZlRUozU2oybUFQV3lDR0ZuVFBhbXlqQTFsSUlpLy9GK0xh?=
 =?utf-8?B?ck1EMmVIcnRlTmduRmlBSklxRCs2Q3hoOHo4UUVFQjNFVDFjcWVPSGdJc1B5?=
 =?utf-8?B?L3ZTQlNmR2hBaUM4Q0tEVzczR1FNNU03KzliemFadjNZK2x1d3FQdThUZmlY?=
 =?utf-8?B?Z1F2VnRkeFNEQlZiSS9vSkx0eEhkYURMKzYrQ2VZUlc3N1BFcUNvRmlwUHVB?=
 =?utf-8?B?WURWL2FGRnVrSGFsUE5yd1RJSmJXOHJpcW5UcE9MYndGWWhzcEVPdDNuQ21J?=
 =?utf-8?B?dFlaK0tKQk9PT09OalpJa1FnaURsVWFsS0hkLzEwTnFTQ09PYXM1MFlwY1Rz?=
 =?utf-8?B?b0RvNlhTdE05TDVQZDIycE0wTzBGa3lLU09TaFI5cjJkTnBuSEl0ckhTQzhC?=
 =?utf-8?B?eEozTExQMXRIQXY4MDhDK2xOdWZTTldrZHJqS3NDNkRuRUdLK2JSQStLK292?=
 =?utf-8?B?a2ZmRzJIQWh6eEU1dEtpSTNIRDU2cUhHR2pHVVp6dllUM05xc0F4djVCMkY2?=
 =?utf-8?B?MnFFc2U2dlUwVDJQU3RJZUtFRlZKZW5yTHZQenV3YzJKcUlvTkJ4blh1bjgw?=
 =?utf-8?B?QXRmNUg3Q0JvUVdQbklEWVJpZktuYmVwczVqQkY5cy9NL2d1VnFSbnArUS9l?=
 =?utf-8?B?YXNJSnhhRFk1S2pmSjM5enY2bnpvZFQ3NmlzNjZSK0NydzMvenFFb2l6Lyty?=
 =?utf-8?B?dFdZMEZVK2VhSjlaWWI1M01aRVRXSjhvdU96czBBSTdlV3pkeEZQY3R5N0ZD?=
 =?utf-8?B?STJXckxXb0wzV09EbXltTU9XbmpDMWRmRmk4ZHhmZVkwQWd5QzRtbFlzMGk4?=
 =?utf-8?B?S2RiT29qVmp2UHRhMFIwaSs3ZlBqVkNNZ3lKR01VS0VsUFc4ZzJQZWkybXIy?=
 =?utf-8?B?b09INEZRMzhhbFJNdDB0ZEZFWEpScE9wVW9FdklJZWEvbGRVcEtiRWdZRGxM?=
 =?utf-8?B?YVhWbVJkVnVuYzNlM2RyN0lweXNmYXdVQUt1UGpHMlhvOFhlNU0zMENwZExU?=
 =?utf-8?B?MkJGdStTOWtEcUo1R0YyTXlacVRpSUFKK2FSMkVyaXFoVk1na3BlUndYMlpY?=
 =?utf-8?B?VGYzOUpxZTRoQ3g3eUtvMld0SFVSUS9UWFdNVWg0eDVSYXdOWi8rVXRqa2g5?=
 =?utf-8?B?UnU3YmQxa25VL0FkVUlvQlZFTzlCaXoxeWt5Q1JXR3ZBYjF1UGdvenF2TFRY?=
 =?utf-8?B?SUZhWEdUYUl4NFpkTWU5dUVYWEcxZXNzUzQ2cE1YbFRDcTJ2T2ZPbUdXVG5i?=
 =?utf-8?B?R2preHIyZnFFdk02R2I1M29IZHVQbC9DT3RCK09USEhwUG0vZnRjcUhiUTJw?=
 =?utf-8?B?dkZYc2V6K3NpRThCNjFHdWhZYUJuaXJMOVcwQmVsanJZYS9CV0RsNC9XQkxK?=
 =?utf-8?B?Qk1WT2pKZTZ6cVArTjY4dmhSaUVoSG56SkI0L2w5N0QzU0RUSkQzWDdpZFdN?=
 =?utf-8?B?T1oxTHFhOXdOUlIyVEloZ0E0SGNOaC9tTnJrWXlGbkhYdDBzK0lZWklCbmdI?=
 =?utf-8?B?aHRwT2NiZkg1Y1RQRDdtT0pPVzk3ekxVcHBSUWdxMFVXVE9wUWpQRDJGKzIr?=
 =?utf-8?B?VHVoOGhFOTZIYzR0dC9kQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2VQd1gvY0dRcmZINmMwZEtPWDg5ZzhZNjJIZWdVRm5JSkttaDV4d0hPWk0y?=
 =?utf-8?B?a3dBMStzUHdiM2VtM0tocy9ZOE9DbzdaN0hMc0hFazcwd3FUc0U2d3dPbCtP?=
 =?utf-8?B?QlEvR3c4N1Fod3g1d2RVTnF4bzdXaUpZSytERE1UME45SUNiUU9nbHJPcWpB?=
 =?utf-8?B?S3lPUmg2R2NUc2RNQmFJMjFDM1JkbzUxcXN5UGlEWWU2MkozNUxTa1dHYnQw?=
 =?utf-8?B?R2FRRGI2RDdxd05QQ0o2NVFIVjQ3dktrUzJIWWRLekRoSi9LeEk5cGhvRG84?=
 =?utf-8?B?a0hnelo4c096M29OL0pMLzlROERXQjQyeEVrZWVsNnoyWmQ1NmtINnRNZ2E4?=
 =?utf-8?B?V3ZnWkpselpCVEI1eFdHaVVIRU5lZFVhTk43VUJ5M2NPNDZYOWlWZllzNDJq?=
 =?utf-8?B?MU9hYlJCTlo1NzZFZ0loaDhyNkk2SndsRWJVb0IyRW1GSnlYcmoyNklVREt0?=
 =?utf-8?B?cytYWVFCKzVnQ2J0blVCMWtGWnlDVzlISGtlTnA0ZXlBc0syMjdwMEhCcjZR?=
 =?utf-8?B?bUQ0T0RTZUY5RHpGMVRDS2dOYkJlSVYzbVBXc3Z2eDcyZkRwZTdhdzU3dmQ2?=
 =?utf-8?B?bzVhdyt1RFVaNStlcnJIVUlwQ0xGdklzZFhGaTJhY2pWMUxaN2NoMmhyMnFM?=
 =?utf-8?B?V1QxL1VVb3dRU2l6alMyZmNnRVp2S25kdThLRlIrM1JwUFNxV09SU05yV01h?=
 =?utf-8?B?UlM1TnpOWXRkeFdPa0RESEFyMzJvUmczNUl5dWwxa3cxVFNqS3ZWV0gyeWQy?=
 =?utf-8?B?OTAyLy9uclZxd1gxTzdpTnYxdFpwS2tIYllwUkVDbThZRjBkcFYyZ2QzajNu?=
 =?utf-8?B?MisvVlBMNFJjZ25pN05KVUkzTmRXbC9YSHIwb0dyYnhuNFdDek1wRjRTdUQz?=
 =?utf-8?B?N01CbnVzM3I3cVEzN2lSaUVRdnAxOEhnNFFoLzg4UTh2Z0RVSXRGdFdLMmJV?=
 =?utf-8?B?TWt2NFF4Q093WkVtVmpva3R4SEhNaTBLdDRnQk50OWErSkZaU0Vla01pUkQw?=
 =?utf-8?B?SFpPWWQvbDhiMU5Gb1pwZmhNeWxpek4wWStDdTYvMFEwYnFhYWZ5ZmEyL05M?=
 =?utf-8?B?Mm9mM3VVUThjY1BWNkxnUG11VGxaQStxdnFiOHVLMUR0M2NVVUFFa0p6Y3dh?=
 =?utf-8?B?QkY3d0psV3VqTEwwcUlySmJtOE9uNlUwYVZiK0pWZmRBZlFDeEVQblNnMnU3?=
 =?utf-8?B?MUhyRGJ4cXppTUlNOFRCVDMvb2hMTEZCZHlWSHZDYVo3bDRkcDNlY0s0U2xR?=
 =?utf-8?B?VFA1ZWtWd2ZabEdBbGJXaDBVSk51blIzTHBLR2szeTlka2FURUZtTWtoL3hs?=
 =?utf-8?B?bGlyRVplancwSUZvcUhHVGs1azN1NnI4TnlsLzRZcUV4KzRxTWVrYmtHOUw3?=
 =?utf-8?B?bERFNS9mbzRLa2haMnoxZlhpdFpWa3BYbU0vclhKY0FXNEJrUGRjeEpKM2Rw?=
 =?utf-8?B?SlZXYzEwKzltY1lqZjZHNjBHcHdBSnFQTFphZHdNWjc2MHBqUGF6cGFvakgz?=
 =?utf-8?B?UVR0aDFNN1RiSnlINmthV2JiMEViTzlQM2RKdlVwWS8wQlFVYWhpYWF2Ulo0?=
 =?utf-8?B?b3hnSHJWQlhLWUV3Z2ZYNmZCTUx5UFRWem5jYzEyL0ZTWlNkNUYvdHpNL29a?=
 =?utf-8?B?Zm5LNnYvbGlveWJBTGE3d1Ryc0ZVTHlQL2trb2JmeWtvNW9qcTZnNHR1M0tQ?=
 =?utf-8?B?MTRKWjVhVGdFVlZ4QmN6eTYrbmNHam5OMzFMaUlJWG91N01pK25QM01Hd0FC?=
 =?utf-8?B?aStDSzBZMkUveVFVaDMyaDBxMURQS3FUVG15OHJYRkg4dnNTOHE2SWJIclJF?=
 =?utf-8?B?ZmFTbFpJZVlYbU1qalpCZlZ2MGhqS3g3NzFHTVlvMk5oY3lJZEdYR2Q3L3NB?=
 =?utf-8?B?ekM0WUQ2bVQzRmpFNk5HSXE4LzlzMUZ0OU1yZG81Ui9wR2JtUEJHNklPeElv?=
 =?utf-8?B?UUdrOVlreFVYdkJsOW40MmxiK3JacVA1WHkwQ1NnbWlzcG1RQXMwaHoySUty?=
 =?utf-8?B?NUhLVzlRNGtTbHBodEV1dXJyOGY1M1FrMUR1Z1pZYzJ3V2h2UE5oZHllVHJC?=
 =?utf-8?B?MzVObk55czVmQTdUdUk2SWFXSE9wNHlJdG9HNlVsU0NvQXB5eW9DcVRBakZB?=
 =?utf-8?B?c3BwMC8wT3NaVFA3cndaSkczNms0Y2xZc3c1Zy9Dc2dDeUZJQlZmYjZySXQ4?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe330fea-a318-49b1-f655-08dcb2728bb1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 21:40:22.0624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K3Hy4fYa7pMLcbds6uKshbFcjTZrFKixYKi72yg/BnNVARoxmLjw6dNHI0Uwsynzp3K9eEbirN4htoyKjASX8ac37I+OnljJxgev++Xf1pA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6513
X-OriginatorOrg: intel.com

Hi Babu,

On 7/25/24 5:16 PM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 7/16/2024 6:23 PM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 7/12/2024 5:15 PM, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 7/3/24 2:48 PM, Babu Moger wrote:
>>>> Enable ABMC by default when supported during the boot up.
>>>>
>>>> Users will not see any difference in the behavior when resctrl is
>>>> mounted. With automatic assignment everything will work as running
>>>> in the legacy monitor mode.
>>>>
>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>> ---
>>>> v5: New patch to enable ABMC by default.
>>>> ---
>>>>   arch/x86/kernel/cpu/resctrl/core.c     |  2 ++
>>>>   arch/x86/kernel/cpu/resctrl/internal.h |  1 +
>>>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 17 +++++++++++++++++
>>>>   3 files changed, 20 insertions(+)
>>>>
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>>>> index 6265ef8b610f..b69b2650bde3 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>>>> @@ -599,6 +599,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
>>>>           d = container_of(hdr, struct rdt_mon_domain, hdr);
>>>>           cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
>>>> +        resctrl_arch_configure_abmc();
>>>>           return;
>>>>       }
>>>> @@ -620,6 +621,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
>>>>       arch_mon_domain_online(r, d);
>>>>       resctrl_arch_mbm_evt_config(hw_dom);
>>>> +    resctrl_arch_configure_abmc();
>>>>       if (arch_domain_mbm_alloc(r->mon.num_rmid, hw_dom)) {
>>>>           mon_domain_free(hw_dom);
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>>>> index beb005775fe4..0f858cff8ab1 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>>>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>>>> @@ -707,6 +707,7 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>>>>   void __init resctrl_file_fflags_init(const char *config,
>>>>                        unsigned long fflags);
>>>>   void resctrl_arch_mbm_evt_config(struct rdt_hw_mon_domain *hw_dom);
>>>> +void resctrl_arch_configure_abmc(void);
>>>>   unsigned int mon_event_config_index_get(u32 evtid);
>>>>   int resctrl_arch_assign_cntr(struct rdt_mon_domain *d, u32 evtid, u32 rmid,
>>>>                    u32 cntr_id, u32 closid, bool enable);
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> index 531233779f8d..d978668c8865 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> @@ -2733,6 +2733,23 @@ void resctrl_arch_abmc_disable(void)
>>>>       }
>>>>   }
>>>> +void resctrl_arch_configure_abmc(void)
>>>> +{
>>>> +    struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>>>> +    struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>>>> +    bool enable = true;
>>>> +
>>>> +    mutex_lock(&rdtgroup_mutex);
>>>> +
>>>> +    if (r->mon.abmc_capable) {
>>>> +        if (!hw_res->abmc_enabled)
>>>> +            hw_res->abmc_enabled = true;
>>>> +        resctrl_abmc_set_one_amd(&enable);
>>>> +    }
>>>
>>> This does not look right. It is not architecture code that needs to
>>> decide if this feature is enabled or not, right? The feature is enabled
>>> via fs (for example when user writes to mbm_mode). If the default is
>>> enabled then it should be set by fs. resctrl_arch_configure_abmc()
>>> then checks if feature is capable and enabled before it configures
>>> it on the CPU.
> 
> Looking at the code again, I think it is fine to do it here. This is arch initialization code. I am checking if the feature is available and enable it by default. The fs code is not initialized yet at this stage.
> 
> Other option is to move everything to rdt_enable_ctx which is during the mount time.
> 
> I will keep it as is now. We can discuss more on this in v6.

I will take a look at v6. At this time I do still believe that this should be
controlled only by fs code.

Reinette

