Return-Path: <linux-kernel+bounces-523021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DA2A3D109
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC04188D056
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A761DFE3A;
	Thu, 20 Feb 2025 05:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FzgY5aRd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5596BA930
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740030904; cv=fail; b=CpkPA8IcqKZ3BfJIFezxjsvwWo0PjWnk1wJpEV3OxrjtEuxzR14iFqFtSlm1ZyiavkpY52EmfEPA8dNDZa9XsaIKKBygQiTrWJAeXhq/KkuJuV3k4SSQy32tkjXt9MwrINgR77Bobu07Ymd0os54mh476K5A6Qb3RvcCF1VXJL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740030904; c=relaxed/simple;
	bh=M/P2xvIlLuuBJA/r4SL6Y0t27SmobO/6B0jbZjvEHm8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VFSL0QCk14dV3UHTAVwzetYpJ9y/M91xIPdIrjHwODIcgYgQI/i5FRcwt2XJJ2bbnaOq84ify3QdUpHUiYGrIaECx70nDfc6zzOVBxjjaD2rGIyd7K8LNHfLVny6oygaYATTRn+ba3sOWhQw+oTeTs28Hlmf0HbUhgfpBI22g0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FzgY5aRd; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740030901; x=1771566901;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M/P2xvIlLuuBJA/r4SL6Y0t27SmobO/6B0jbZjvEHm8=;
  b=FzgY5aRdMTVcaHfwKPnifWO1/TScuBuN9UgHd/FUtuuQjMPwfvR22ehN
   69FyFHG/vjKhI3JVpDXjD4nFdItEP5LoEtNyBWCUmhL0y8GbmS2eNUrap
   7czPr0yIE6jajd93+xE32SSRxGuTH6wa3Zp4R09vkVeYX6xMvnOiCR+fv
   tu6aMbqvpDFY9M/Km0979UDAR8VpBEgT8YmqfUpCHuU2IfV4HOL/fKFyq
   y3Rt8fPbLXoPTboV+xv7FSXmKO/6FBrHGQb0H7UCJD69R7rMtOO5jS7pN
   5zfoOAtAS2L+V6AfjLliuLerSHoGxFX8kl8Q60TVRgU0sjj35vSniamyC
   g==;
X-CSE-ConnectionGUID: HIAI7g7ISmegHYR7a/t2SQ==
X-CSE-MsgGUID: sa+SMSfrSVGqFtFxr/pNlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="51437903"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="51437903"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 21:55:00 -0800
X-CSE-ConnectionGUID: NTTnCEQZSWizEPLTEQwExA==
X-CSE-MsgGUID: lufcDIX1TJe4/Ys3VK+dnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114788608"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 21:55:01 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 19 Feb 2025 21:54:59 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 19 Feb 2025 21:54:59 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 21:54:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDMkfv8h0dAW39PiKCmp0cflDl+PkBizKLjRydDhyyYTgUhcK62ZHbekI+VKXQCp02WaGBY4WA94+2AEHWmLhVbsA7312mAoeFB2npFK/IOc/pLXXn4dkWVjxE+u4199xqZpiPD5gn9JOizxkSwMhooo1GS+h8l6zcyUXHQg5tkpzR9JWSQGph36b5NUl42pB/tnWVe9fkm8dePncuV8mBAIvy+ZW4puJxmPBPOKulzPiglQNTuW6IjRCzKwg84ICttgWZKsPmLvX6mszvMUDyNvxySfP3tWpGpL7SladOxPJOuWFEBXWwJXwH9arU5O5OAj63NXTVKi6WzJJb1d3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cxnxJgXhbnFykoPQaZYvFNf2mF7h0bIUlKbNaqWGY0=;
 b=rtd0bjArGIXa7evS4HpBHebDsGwTp8C1co1DbXyXfDlyaIWEORPDzzdECKbErNLqdAQk8DYirR6jLILrbhqvtxsCOhOWD6bKDfW1G+5X5zeHLo1LHdPR04WqWkwthQfCmDH7QH1CzSOzdr4xKgYEzCyk+tuI7B+ntOjfPiSDf0D0oprNqzjs+DnxI70+u7C5VSzN1+vWTY9cCg/1K0+UBOSa3N+oMOLaYcP5GYxbKwo/eHVuINJPrqxNSj4pAb3t7Xt0TBwdxMQEjDazbVYbPurG4toBSJCKguWUUGA0VhWIDm1EOvG4/OZD2JmNFLDbNfAZZPI3gikGM9HwKF7mRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA0PR11MB4573.namprd11.prod.outlook.com (2603:10b6:806:98::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 05:54:57 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 05:54:57 +0000
Message-ID: <67ef5b80-cafb-4e04-a66a-5f361a3d4f85@intel.com>
Date: Wed, 19 Feb 2025 21:54:54 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 40/42] fs/resctrl: Add boiler plate for external
 resctrl code
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
 Donthineni <sdonthineni@nvidia.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, "Tony Luck" <tony.luck@intel.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-41-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250207181823.6378-41-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0129.namprd04.prod.outlook.com
 (2603:10b6:303:84::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA0PR11MB4573:EE_
X-MS-Office365-Filtering-Correlation-Id: f7a66190-805c-4de5-dbef-08dd51731b10
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0MxTnJhUVZ5WmZrcmdoK1lyWWQ0eGNYMXZ3empySlFhMHM2ZU9FQVJIb2lP?=
 =?utf-8?B?Wk1UNFRjK0VTN0FsU3Q3Tm9tdksrandhRjFrU21oR09jdU5kU2pyeDI1eGhl?=
 =?utf-8?B?NllscVNIbXcvdWtaN3R0K2hhRWR2ODg0R1lFcXU1Q0ZaTW5yd1MxSlF0RVVO?=
 =?utf-8?B?R2NBKyt0YzIwN0JZbjJLcEFaMEhjMEh6TmZ6RUZ2eWxIVjFHSS84WFBSQlh5?=
 =?utf-8?B?NEsvQzFNYkE1bytOYkVXWjBLa1dUNWlyRHA3RGFlUGxiY0dNK3hreUJMVExk?=
 =?utf-8?B?dDdMU0NYdGQ0YmFSUDloZjBMTXpBUldvR1NjQjM2VFZkZWl0eENCQ3owYTRw?=
 =?utf-8?B?SDc1WkN6MDgwcXFnV1Q4Z1ZRYTVEaHV4YndyQVhlbkJmTnJHYytaZ3Rvb21t?=
 =?utf-8?B?MXVpMXdsbk9MY2lYazhhTkZqcUVmcllLOE9zRm9UUTJ2MzBHVCthSXBkSCtD?=
 =?utf-8?B?R0FZU21RUG9BWmhiOUhobERQcjJuZ0lmL0M1MGhTdXg2endaajdsWVQrMDh5?=
 =?utf-8?B?WWRya2pNaFdSNzE0Z0w0MDVCUWFuSDI3dWU2Q1hOSGNjWklLWkIxNkdmZGR6?=
 =?utf-8?B?cWFUOVhhSWVFQTl3aXQ5U0JFMUpnWHFIVzBjQkR5MzlHRXFHOHdUdWdnWGFw?=
 =?utf-8?B?MkIvc3UxM3Y3R1NETjB4YVFLSnBPYWJUN3FtZVlWNnczZUNYTXhjWWpkZWVv?=
 =?utf-8?B?ZzRzQ0NqakNCUnF2cUwxNGxTdXlwYmIrajMrcGR0dnZiNk5RaHlMUVdwajB1?=
 =?utf-8?B?UUV0S3V6OHNwOTJyWVFZYnd6RUdSQjA3aEg5YjBSZTNVREhrQzdTZ3RMT2hM?=
 =?utf-8?B?TUV1Q0R3RzIyZHJSaUhPcjVrWXF3VDRqeHl4L0pqMVYrNTJwdDBQNzZ1WlVL?=
 =?utf-8?B?QUcxWUIvSGEreEpYanREaUFaSGNFQ3p0VUxRR3N2a2dZSzF0dGFPd0EyYXI2?=
 =?utf-8?B?UThVaGhWSjZiVFF4RW5XUTZtM25HWmM4UmxzaHlHbTBMaHI5QjM1UVo3Njc5?=
 =?utf-8?B?T0dhVVJjNmhWdHUvM0F5WkxVNGg3aXcycUlVSkJEek42eVN4SUhwczdYelY5?=
 =?utf-8?B?QUg5K2l5djYxVkxDUFNIbmF4Z0RFZUhQYytBdzg2V1F4N0JTVnh2dndrcFFj?=
 =?utf-8?B?MTlleWxmajdoMUdSRXI4eWEwZWhEdGMwZDVaK3dZUHUyeS9qL2hCS1laWXh6?=
 =?utf-8?B?MlJmSDd0Unl1WGxYVGFBMzhOWFF4cXpaZk5yMkFhaUZDNjdqajYwTHlBUkJm?=
 =?utf-8?B?K1RsajhzdjQ2VGtOQk9CNTQrQ0hxckpEM3l4aEhXdGxBLzJYeXQzandpcGRQ?=
 =?utf-8?B?VzVPN1hXck5YR1Y2VzhnRDRtL0JNVTVwL2FLblJINnE1bGtJV0d4UEtibWhZ?=
 =?utf-8?B?bnVRZjJHdFdEN3NKNm9ZSGJyWlgyeWdlYVM5bno1VENpRTZwQm9HcXR4MGZI?=
 =?utf-8?B?WU4rVTNTWXhOT3ljNlBSUmR2L0xTQ1VNbUhIbFBkT041bFE3azNmcVkycHB0?=
 =?utf-8?B?OHRkNW5mZy85d2NPcDZHdlNJTFhvUzBmVXFWN0c1cCtrTkw2T0lDTXJPeXNC?=
 =?utf-8?B?eFd0NVJlbjRjSk10UC9KZHY3ODRzT2I1c2F5ZXVrZlM4NWNodmZzUkxXY0Vi?=
 =?utf-8?B?VkR0UHQ4SUQwQmttVkdvRDJWM0dSMmRPM3ExdDdCZm1xd3BCQTllRCtYYWtR?=
 =?utf-8?B?V0hXTWZaZ3c5TDFiRlNTUDZjbjRjZmUwMFpZTHFlb1F1N1RNYjU2b2VmcEZx?=
 =?utf-8?B?VHJKZG1ENFBzTjMwb3RUWFBQRkxXRlk4d1IvY2RJdTRmV25WeXdTS05sTWZK?=
 =?utf-8?B?eEVNU0NBU0VYc2orQW1sSE9qS2IzR1RNSDg2ZmN3Unhha0xaQ2pRVm4vRUtW?=
 =?utf-8?Q?jUomA3R7X2jqB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXh4R0FEaUd6WFIzRW5QWFJCb3duckZzV1BaN3lkem9HRU9xejJoNEh2Z0Rh?=
 =?utf-8?B?TlZMcUJOa3RjYXBWWjlUOFB3bXZJZGZTaWdCYXFQeWN3R21xWG1DSCtXL2Jj?=
 =?utf-8?B?RTlqalhOZ2p1SGxvZ3VSbWJqb3hFRVIvM0drKzdTYytaWXZzc3JtK2VJQU5O?=
 =?utf-8?B?WVBueGZvMHpYVHpxZ1JDaVlBanRvL3FLdzY4YWJJekZ3MkpuOEN2Qm5DdEhE?=
 =?utf-8?B?MkpFdGpaMWY5YnA1U0FnWGc0SHlodDhENytGQ3hqV0c3V3JnTGRIWU1qOFBG?=
 =?utf-8?B?amJNdFc1N0VIblRHNUM3Nk5qQStNN3NXbzBodS9mQzN6dGNJTC9vekdkODV5?=
 =?utf-8?B?WXEvUWw3dTBTQys5NkllUTVBcElJV2ExU01tcHhsTlBZKy93VE5VV2xRTWsz?=
 =?utf-8?B?VnpNVWhnaHhSWDFTS3VvM01ad25LOXFyOXhkYUYvKzBUaDFTb0tnOHJRaTVT?=
 =?utf-8?B?ZXU2NjdJV3FHbnVHMHl4VUZNbGdmWTd0T2puWUREMFdOZnB4bFJuSWpvRExB?=
 =?utf-8?B?TFJXQ0s5U1JmUFRFVXowWFlJTVRTSGZxckFzZUcwdFo4ZzN1OE5OemJiVUdG?=
 =?utf-8?B?UitHeGpmZ1FJNTNXZ0NJeWp4REw3QUt4TXpNRnFwU1c3RGRUcEhIbWdEMFNG?=
 =?utf-8?B?RWpjWXlmWlozRDNSclRoL1JiYkVQZGhVMXBOR0tGclJDTU5FZVRhdmY1cHBR?=
 =?utf-8?B?aWFRY29OVGNrNHhCWEh3cC9YNXB4a0YwZTJDRE1lQlJ5eVo4UjE4WDV4c0Zy?=
 =?utf-8?B?emhEVTZDRWJyaGw4SGJIZDB0SzcrS2h0QW11K2hzZ2xWTkcwY0cvY2xIMUtH?=
 =?utf-8?B?UmxSVnc4ZjQ1WjgzeXFTSUplZWFaNktlVzFZdTZxLzdtSTlKZ1hjV1VVRTY0?=
 =?utf-8?B?Z1FJWEV4cm1EUmVOMlZhcFNGakxNcW1ZZkxEaXVMN1dPaExrb0s4OFNsa0lP?=
 =?utf-8?B?NWFWN1B3R09DMHlrY1Q4NFNzaVlBZHVLL0hDNm92Y2dxZjdCOWdvSjdFaGtV?=
 =?utf-8?B?RGJRNmUzR1kzcmxjTmNCVHpKeTUwWVJIb2l1NDl2dHpheEt2SVVBa1pYZGYw?=
 =?utf-8?B?WWhSNjc4QU1MOUNGUzFUcnNweXZTRDN0blFUNU5Ia2dYaFFpMktybVRxb0s3?=
 =?utf-8?B?cDdoY1AxTGY0Z2lzemVTaXVXSCt5K1BVOEwwa2d3NDJZL0ZIU3dqcnFvcDZK?=
 =?utf-8?B?eEZ1UDhiWmhoUXR5WlpCS2xYcFloZXBjeEJUSWlOWkdVNW9HMjkzdlp3MlZS?=
 =?utf-8?B?aUVnSnJKVzhES0xvYjluWEYxQmIwQkZobDVHRFA3YVVqNFZsS0p2a0xFRmNU?=
 =?utf-8?B?TGFSTVNiVGpkL25jOVhOQi9yeFh3Uy85UkdBMGFyanVFZkZ6ZGlsdmFrWkFJ?=
 =?utf-8?B?aTlrL3p5OXFvYkVrNE90OUVWSUU2Q2NHaGtRMEhyWmQxbk8wbWRXSXpac09w?=
 =?utf-8?B?cksxVXVTVDVQTXQ5a0hhcUMzQVcvSkwrT0haVVNVV0pvWUQvSFBLb1NGVWlJ?=
 =?utf-8?B?QVJhamQvWEJFdDFPTXlnVFN1YkZ6ZDU3RnJBWFI0eThJblRRczhhSmRtSUdi?=
 =?utf-8?B?aHdpY3loVEhtOEM4V2dobEtqc1dzODU1QzRaaVlBMC9mdHV2bHZhQ3BjVEJZ?=
 =?utf-8?B?RHd2ZSs5ZGYwVmIzSzVBZGVZTUE5SDdFVUt5SU11bGZjdFI0RzZXcjYwWXBr?=
 =?utf-8?B?cnZQMitueEQ0RGFxaG82OVVFN3g1Z1JQQVhyYXV4QlZqeEJFY2RhRnV6TjRD?=
 =?utf-8?B?Z21MQ2dJK0hqS3VRWjdXTzNlVnVnbzJBL3RQK0RGUEJpbmJmWHJqdXVBaHV4?=
 =?utf-8?B?eEZjclNvOWQ4TlRNRGY4S2NOZjl3Sy95Y1RjZk14bXZOQklaQjVQaVpRaEtM?=
 =?utf-8?B?U3diMlZucWFWOHdlanF1Qk01VW0wb0tKSjU1K0prL1hEUWc3NkNYYVVERFVn?=
 =?utf-8?B?eTlnQUVVUEhMSzRoNEJSMFpRaEUyejFYT2NWbEtEeUczVjNOYkU2TGtQckY5?=
 =?utf-8?B?ZGRTOS9GeDhnRFU1anVLenFYT1M1UDgvOU15QXUzWWNsL2lCYWpoWGQ0OUMy?=
 =?utf-8?B?TGJZWnA5V2FXNkVXQ3hYdUJVN1o2dHQwcDdpb3ltQi9POUM2OXU5T3JrZ2tZ?=
 =?utf-8?B?MVFiM2F5V0JwZWVXczFsSXFnTnNKdmozRWpDZDZ1SGNCdEQ1bVZpaFU3ajFv?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a66190-805c-4de5-dbef-08dd51731b10
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 05:54:57.5118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vwqVA+P0csdfi6E7HbM+q/M66cTDLbxhbE+l7iMguoUy5n8ud9yW3zHEc3DN04yk0Hwbavu8sSzkR26U9DaRZNQBG2Gba3k6dkVZ3LIbpLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4573
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:18 AM, James Morse wrote:
> Add Makefile and Kconfig for fs/resctrl. Add ARCH_HAS_CPU_RESCTRL
> for the common parts of the resctrl interface and make X86_CPU_RESCTRL
> select this.
> 
> Adding an include of asm/resctrl.h to linux/resctrl.h allows the
> /fs/resctrl files to switch over to using this header instead.
> 
> Co-developed-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---

...

> diff --git a/fs/resctrl/Kconfig b/fs/resctrl/Kconfig
> new file mode 100644
> index 000000000000..229ca71a8258
> --- /dev/null
> +++ b/fs/resctrl/Kconfig
> @@ -0,0 +1,37 @@
> +config RESCTRL_FS
> +	bool "CPU Resource Control Filesystem (resctrl)"
> +	depends on ARCH_HAS_CPU_RESCTRL
> +	select KERNFS
> +	select PROC_CPU_RESCTRL if PROC_FS
> +	help
> +	  Some architectures provide hardware facilities to group tasks and
> +	  monitor and control their usage of memory system resources such as
> +	  caches and memory bandwidth.  Examples of such facilities include
> +	  Intel's Resource Director Technology (Intel(R) RDT) and AMD's
> +	  Platform Quality of Service (AMD QoS).
> +
> +	  If your system has the necessary support and you want to be able to
> +	  assign tasks to groups and manipulate the associated resource
> +	  monitors and controls from userspace, say Y here to get a mountable
> +	  'resctrl' filesystem that lets you do just that.
> +
> +	  If nothing mounts or prods the 'resctrl' filesystem, resource
> +	  controls and monitors are left in a quiescent, permissive state.
> +
> +	  On architectures where this can be disabled independently, it is
> +	  safe to say N.
> +
> +	  See <file:Documentation/arch/x86/resctrl.rst> for more information.
> +
> +config RESCTRL_FS_PSEUDO_LOCK
> +	bool
> +	help
> +	  Software mechanism to pin data in a cache portion using
> +	  micro-architecture specific knowledge.
> +
> +config RESCTRL_RMID_DEPENDS_ON_CLOSID
> +	bool
> +	help
> +	  Enabled by the architecture when the RMID values depend on the CLOSID.
> +	  This causes the CLOSID allocator to search for CLOSID with clean
> +	  RMID.

With RESCTRL_FS_PSEUDO_LOCK and RESCTRL_RMID_DEPENDS_ON_CLOSID appearing at
same level as RESCTRL_FS all three configs "depends on MISC_FILESYSTEMS".
Should RESCTRL_FS_PSEUDO_LOCK and RESCTRL_RMID_DEPENDS_ON_CLOSID
"depends on RESCTRL_FS" instead?

Reinette

