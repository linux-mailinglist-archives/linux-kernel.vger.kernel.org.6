Return-Path: <linux-kernel+bounces-254011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA71E932A22
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12D4288836
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B402019DF92;
	Tue, 16 Jul 2024 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UPa3huug"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B77A54BD4;
	Tue, 16 Jul 2024 15:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721142729; cv=fail; b=QwWld9QTYLH4xU61EsAhLPxvWRXQlYjGnyzAnWJLMToIZFEc50Cdowdwqp1BsQZuaxoPf53GLuymkQUaHNm6kiqFArSv2gw1V4SyDi3QVHq6RPJxCTohbB1mstblyrrOKrXlpFdlEjBsMMbl2dNmIGI4aHIAfre+42+1so26V3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721142729; c=relaxed/simple;
	bh=4CEopd0XU6I6CD8X/b8UHDeSoy8RLqIIKs17/thtr18=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fIlt0o8QzB2GE2MTjOTFSPNgnnPT82f4ar3FZVxYZClXGHfe+dwDCg5TMV360nCF/tac1Hl3aFjUu1tcEB7IRzWsuALYHNklVNGYSJp/rvNFlsYr44JzFKPLayczIlq6DsnfWTWg9hLoYgqPYNk2MtxcIwK7jQgWydzS0iF26ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UPa3huug; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721142727; x=1752678727;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4CEopd0XU6I6CD8X/b8UHDeSoy8RLqIIKs17/thtr18=;
  b=UPa3huugsO3eYosCv9BqnqAPx4F0y2eVnPaw2xImerrKqymj8oxpQ84+
   n1NhjsxSkbECIDKCXO4LTeu/gWjeGXv8Nr/3KsmD7cBrhMamqrQDfxe9S
   yEYxtJdkd7J+LheroJrlt2uOivnGMrEwaNmdi/FR9ae4tPIixFdpbzzi8
   hUc35EEr5qzUKsGFIVLsC8aDuytE2fnDrB/tXdD8F6PoQf+kUTX+uJl+x
   Xk8uNMEkL3AhCbP9XO6v2Jdl0P8YxoFcsMl68XfzsRg1q7eUUEEveNuaT
   t0cfCqAIQs6Z0qfOgIe2HFvUnXkd/XP/7O3/gxO0Rh8tx00745vfNRSUB
   A==;
X-CSE-ConnectionGUID: 6ICa8PsvR7mBNwCSp5l9xg==
X-CSE-MsgGUID: Zp7ZXgVhQc+M9ef4WSvFOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="36131980"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="36131980"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 08:12:05 -0700
X-CSE-ConnectionGUID: wZhaRju4TReT55dYdKnmaw==
X-CSE-MsgGUID: UpwtbJy7QJu8VviDitYuEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="87550721"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jul 2024 08:12:05 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 08:12:03 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 08:12:03 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 16 Jul 2024 08:12:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 08:12:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lxti1MGaF3RE6LpvEaUkIcmbp9fShf0tCujBhPKMJvXAak2M+1fAI5/aUS9OhMx3vG+kZlbmGtINEItndMMBqdn3e2CS1k1y0uOHP2Jm96MfH+KnHcm2yzx/tTi9+NK5bzEgJEPHF7cGsXIIJ3TUPXOzIPOIsfGM4hEOaXZFsyb+XVhgg1ws8G3X1XfrU/aark610PWc2NfvBB9X2W4fV0irDknvwah0ZL1JFlITd5qhpLyfXjzlYLVPvYlrX8v+5zBEoSchJWa7oNInP0uOZazD2zD5JglwHlGvuYn7Yl28QqiFeTBcqr6EPzhDIqVXn05b6Bz+H3drIqbSh3P/MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQ4Z4IldtiAPqyhM7Jr27Rwotj40N7KALsX+F7K5t1U=;
 b=HUtIYwfg7pyNDPdHPor0cxQWcA0a0PIu0SXB7tTOIZwEBc4azfaNpfu7BqtcHc/q96XqesQ5pyDJl80u8sLb+PUta5UAjsq3AxU1ktM8EeiivS++DyTT0V4WrDtrxVUfopPENBKwrK8tVKBsL0PDopVGLhsCHcRhenduNcmEyi2TfJZt007qZdJIKpeDn0FiyIzoQeS98F20hhicBSVp1gn6PizEsBC1YQHVOcLcjiLEEPc+xkON3eh/LEnpBH+fhWq+hnq5BcUUPBo9u6sRtuVXrOO+bs0w59YuwqU+1QOXNCDPivluRAY2vLFuicNxiXgeqsNipoU+5KaFIkMRew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB4864.namprd11.prod.outlook.com (2603:10b6:a03:2d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 15:12:00 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 15:12:00 +0000
Message-ID: <f7698ca7-e9f7-4e3f-80cb-44e154e94e71@intel.com>
Date: Tue, 16 Jul 2024 08:11:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/20] x86/resctrl: Detect Assignable Bandwidth
 Monitoring feature details
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
 <ea967681e5ed7a9c27771d60ef993616e7e1292e.1720043311.git.babu.moger@amd.com>
 <1d0af059-4768-48ce-87ba-7a9a213a3fca@intel.com>
 <e8a50a62-9974-4f1c-8ffc-0a1efa477824@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <e8a50a62-9974-4f1c-8ffc-0a1efa477824@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0047.namprd16.prod.outlook.com
 (2603:10b6:907:1::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB4864:EE_
X-MS-Office365-Filtering-Correlation-Id: 8720c198-2227-458d-0399-08dca5a9a405
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZU9KV1hyU2lRanZIR0RvTkwwdnFkdHZBZ090QndxMG5QZUxPV3paWXp0MEIz?=
 =?utf-8?B?N2pjamdaMGZvUFFQa3BrdHlCK0d1YStYdFZDWmhIMDFkbzZtWlgwUkQyaDI2?=
 =?utf-8?B?Q3pHUlRKOXhrT1RicHBPbW02OWZVd0tpWHZDZWlQdDhhMk0vS3Q1dmpoMkow?=
 =?utf-8?B?akYzS3dzcHZYY3Mza3ZxVDNET1dsNW1zOVI3Z1hkVnFxNnl1ZzcyeWhOSGNB?=
 =?utf-8?B?MHF5UlNoMHIwSUV1cXR6NVptWDRvUGVaQzdGSWhjOXlzamEvSEY4TEtGSFhi?=
 =?utf-8?B?MEVUMGg1MGl1c3NEZlEyaCtRYmNKVytCVXRuOTJzMG1nZzA4UHhSWGNjTlls?=
 =?utf-8?B?RWM4QnlaakMydi9kalMzWnlEL3NCNnVQQVpnelY5dDBmMC9VdjY5TDZ3TFo1?=
 =?utf-8?B?bGhDM3c4aVRjcDU0b2JlY29YOW5kZWpoZVRRVTBMakc0blZOWWJVbnlBeWRs?=
 =?utf-8?B?TUlWemxUVFpoNUF4SVZvUzI5eDdiOFBET3lORW5ya0U2YmlFdzRXdDdmUlJs?=
 =?utf-8?B?L3FLT1hPMUVJeEpkT3krUmVnMUFYV2IrOWpIU2dQUjFVNE5YSnY0VFdIMGdK?=
 =?utf-8?B?UG1Pb29KQzEyeUxsYlM0WjBpVWMvQnE1d29XcXpGM0lxend6dnJDbjd2cU01?=
 =?utf-8?B?dklVYVhGaXRpK283ZTJtRngvaXdkalZ1MlBEa1ZNaS9OdTM5WW80SFZ6RDR0?=
 =?utf-8?B?OWllbGUzb1JhS0JFYk1laDhJQkZ3M1haeCtxZVRYanhZSWVsK0crT2puMm1U?=
 =?utf-8?B?T3FtcnRwOEFiMExPOHMzWHNjb0gvbHlDY0o4Y1lURlByakdLYW5IUmFXUWc3?=
 =?utf-8?B?VER0NFJ4QlpQWDA0ajRPeHlpbHNUamVpOWU1dDB6MUhxMndnUWFxeWwvdlFZ?=
 =?utf-8?B?VS81cVlYLzNSRkdUL3RmaXpaT0xIaGRTOVkrYUxYOGJiTG1ST2F1YThaRld3?=
 =?utf-8?B?dEx0eW96cElMNmZVYitZOW14Y2h5NENLeDhRQUtmRTBFbzRPajZnY3ZuR2NL?=
 =?utf-8?B?S04rcVBFVFlCQ0ZhcVRKaVZLbWJiaGNsS1hZSERRazdnQk9tZmpYaHFndWJn?=
 =?utf-8?B?TzgxZFh5MERvRGNUY29MTGVQc3JyNUsxSUs1SmV3WXROT1c2VVFKQVg4c285?=
 =?utf-8?B?WTB1SXk2Tk9xaHh3Vmt3YmR0d21xVTZkeUFocExaVjF2b3lLOHlwRjFjMHB3?=
 =?utf-8?B?WThkdVhiTG9qOUw1ZmVpM2h6bWppYW5ZSDFldmpmb2tCQzh0cmdzS0NPVktv?=
 =?utf-8?B?Q1BUR3V6VnZuYnFicTNaZlVRWFRqVFAyOUtKVnZvNDd1UHB3ZisyYnZCcFlE?=
 =?utf-8?B?dGpKMzJvbGF1azlrZnNTTGp1NEZlc29ONHhSTUhxWWhOZzhzWjdxbUdmWVZN?=
 =?utf-8?B?QTV3dXZPc1d4UVU2L0I3ZmNpdFNZQTRIYTYrR3ZmaDlOTnViQmt1S0U2cW1Q?=
 =?utf-8?B?K01LVFpCR1NRRlBvVVJ5RmNGKzRoYXJzM01TVUlwckFDZE51enU2emR5NFg2?=
 =?utf-8?B?OXdUNytGUy8zNzhCME9IOWdPbjN1bWVwTXhwM1lSemJkMDM2UG9lN2RHTEFx?=
 =?utf-8?B?cW5CMmprYWRMUU1OVUFaRlZtR09wMVVVYW1pRDRzdWszWkgyU2RJdnFwaDNp?=
 =?utf-8?B?SFoxM2JlUU9FN2ZmWWovRU1WNEVJNDErdzlRYnBOcHhHUjlKVWtCZ1c5RVNn?=
 =?utf-8?B?SWhudUVaUnA1VWM0NTRJQkwvZHNnZnp6Rzd3Nk52bFFEOFdDWEVia1NEbm0y?=
 =?utf-8?B?VEhvVi9EU01DKzVtdEk0cVNKODVrVU5iSmZUQ2l2OS9vRlRmby9VRGF6TmVC?=
 =?utf-8?B?Y0tZWTJSZjNyendKVTRNZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0dxWUlsQ0dqcStpVWRHS2l0SklwYVhVK0NpNlp2MEZHN0J2OFRtS0VFbWVr?=
 =?utf-8?B?RW9NemdrTWRCQTJaYW4rbGlMOXNGNnZIM2pCdEZpWE5SVjNuUjdXcTVXQ1hu?=
 =?utf-8?B?S3ZLcjBPL3JjdFhiVFlyWEpNbU9sVFFiaEJoM0l4akRwY3BmUDEvWk9LbDFH?=
 =?utf-8?B?ZTBZYWdZWkFMTXdWTDBRQ0pqSkRldisyOStObUtaUm50OVZKSG55MFl1c1oz?=
 =?utf-8?B?SHl2ektlVVFqLzJWQnJ4M29Lbndyc1V2TlBIN0pJemdtM3MrT2F4emRHcmRa?=
 =?utf-8?B?bzFmUmw5VzY0aVlhUm5Yc0VJMzJGK1oyMkJCTWM4dGJodUdBK0llY1JZcFMv?=
 =?utf-8?B?WEgxU1J3Vkl5djRXSW45ejdnQ0ltT21uSE1OQW5ZcFE1Z1FCNWsyYmNLbEJW?=
 =?utf-8?B?ZGNrVWluTHNPaVpXTk9wcDVZdG1UWFF1TmFseXVNVHNidTNmQzJVcUdZVk42?=
 =?utf-8?B?Y3JPdXRGZWtvTmlBelAzaHcxWWFSSzhWZ0ltczZzODk0RDZPeDBNRFZ5YUh3?=
 =?utf-8?B?WFBlRStTb0hjYWlGbGszSzY1VVU2V21MVmZOVHZTaG1XUUdFY1daUHB1NnU5?=
 =?utf-8?B?Y2tIMFNDS2creWRNdVJyUkh6UW1FSWdYY0ZOMk1MVWJSZGFpKzNpLzN3YTJz?=
 =?utf-8?B?WkNzVmZqZHY4L1NFblZWbGY1aEp1NjQzUHU3WkoyZHNZdlpSc08rQVpJUEw4?=
 =?utf-8?B?ZnFnc3ZuWFl0YlY1cGRzVnJQTmpXdllOTzNlMjl2bkNHckdENW9rQ0ZoMDRM?=
 =?utf-8?B?bTF6K1U3RWV5WDdoSUJoRzc3TmY5K3NNZXoxb1pudSt0TEF5ZFo1MXkzam93?=
 =?utf-8?B?eEVzUDBzaU52c3h6U0hYR213YXIvNkhVT1prNXJKbmtlejhUT1Nlc2lnRUlF?=
 =?utf-8?B?VlliWXVBc0ZoUHY4L3VGQlMrSmlBWGFPaTRyWHZtc0p5SGZySUFFQjJjSTZB?=
 =?utf-8?B?K0dUTU9FYTJERVMyY1g5THRHWmV6cTM4TTFKS3BVcEdJdXRHenJCeUVnck1o?=
 =?utf-8?B?cUpZbnFaQzgxYTFvclpTck11Q1hrRnUwOUdCZU8wNlJzR2d5azdyRFdGMllV?=
 =?utf-8?B?NzZIcWtmaHhYR3Q3dXdadDZ0OUxaRG9EMldHTThPTDJJa1VsQ0VEaFUvcnBQ?=
 =?utf-8?B?Y1ExY0hnWlNweWFmZG1sT1Z4d2tGaTJsVUN6R1J2SDZIZ2x2aVpFLzFvZTRD?=
 =?utf-8?B?OEhaR3MvTFhWL2VOZVhoeXFHUzJRb2RBSktmS0c5ZnpTbDQ5OG1oSE41RE51?=
 =?utf-8?B?SVNvakROY285ck5pVmt3dnljUFhVakJnZUpjVUNBS28zSGVBQm1DcjBYZGx2?=
 =?utf-8?B?K3VUK1h1bzNnT3NZQUhPT21MOTlpTjM5MFZCakk2ZFN2cDFoWFZlZ3lRZHRJ?=
 =?utf-8?B?NENNbVlqT2FweWR6MFIwcjFZQzhhNFF4VXZlVk5tSVVZclV1cUFqMjI0RXM0?=
 =?utf-8?B?dnRYcW5TMHdxM3duRWtlZmtpenA4b3ZlL1JwNTAwc0hJTU5zc3g1Qm43NDlZ?=
 =?utf-8?B?WllxTzBQYzM0T25TNFNDMnhubEZYVkxkMk1FNzhvZ3M1ZnpoWGJlbnNJVkJa?=
 =?utf-8?B?UWhxczYxNXUwSi9RNkVCRGVjK0MyeVB3MGFHSHNmV0E5TE5sYUsxam95MUdZ?=
 =?utf-8?B?OFh4a2VhNVBuRnA2SVl6UFgvWEFIM3FzNzVWNmhwU2VNeEQrV3d4U3FqdWV3?=
 =?utf-8?B?aEtZdmNQSGZiallUOEhLTEdINU9Bb0VTMnNzMG1TMTZMc055NVp4aDNQSXdF?=
 =?utf-8?B?cmc1VEFFb0RFNU1XOVBTTmErUS9UblRvelhoTmMzM1VHdmZyeWNVUXd0alVQ?=
 =?utf-8?B?c05MTkh4U1FMUXF3TTlEK0ZzV0prSDJhWUcyejJSZnpEU1lwb1dsb1dwd3FI?=
 =?utf-8?B?N1FKd3J2b3RYSmozeEZpUnVraFdYbC9xWm5ZaUlsa2kyWWVMZCtPN1I4TUtp?=
 =?utf-8?B?enZRd0VINS9RdUtuZFJyY0d4Q25aNVdaeGZ5ZDVUZkp0QiswYlRHVjd2VmJQ?=
 =?utf-8?B?YUlkVTNRQThQcjBKQjZEOUcwS1hXajhxaGx5SDJIQTY2OGRNYVYxY09vSTk2?=
 =?utf-8?B?RlZpL0xqb28xZVRRR2Q4aFU5eXdqaVIwc0ZzWkhQQlhQOTJBbzY1dmpRNUYv?=
 =?utf-8?B?bytBTlZ3M3VmMjZOMFJzeXRZek9hMXE1YmhLK0dQKzV0aVFPZmwramV1M01w?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8720c198-2227-458d-0399-08dca5a9a405
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 15:12:00.1725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MG4iSdUftweOWGzAOoWoieIYk3/gdilzv1CstoIsKkwNLy2KcJdpqlXSJfsTW5bhlo7MVGO1eRKP8DoOH2/EBl6BtE7SzO6ayJ9w7ausnMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4864
X-OriginatorOrg: intel.com

Hi Babu,

On 7/15/24 1:04 PM, Moger, Babu wrote:
> On 7/12/24 17:04, Reinette Chatre wrote:
>> On 7/3/24 2:48 PM, Babu Moger wrote:

>>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>>> index e43fc5bb5a3a..62f0f002ef41 100644
>>> --- a/include/linux/resctrl.h
>>> +++ b/include/linux/resctrl.h
>>> @@ -185,10 +185,14 @@ enum resctrl_scope {
>>>    /**
>>>     * struct resctrl_mon - Monitoring related data
>>>     * @num_rmid:        Number of RMIDs available
>>> + * @num_mbm_cntrs:    Number of monitoring counters
>>> + * @abmc_capable:    Is system capable of supporting monitor assignment?
>>>     * @evt_list:        List of monitoring events
>>>     */
>>>    struct resctrl_mon {
>>>        int            num_rmid;
>>> +    int            num_mbm_cntrs;
>>> +    bool            abmc_capable;
>>>        struct list_head    evt_list;
>>>    };
>>>    
>>
>> How about renaming "abmc_capable" to "mbm_cntr_capable? That would,
>> (a) connect the capability to the "num_mbm_cntrs" property, and (b)
>> remove the AMD marketing name from the resctrl filesystem code that
>> will be shared by all architectures.
> 
> "mbm_cntr_capable" does not give full meaning of the feature.
> 
> How about "mbm_cntr_assignable"?
> 

"mbm_cntr_assignable" sounds good to me.

Thank you.

Reinette

