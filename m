Return-Path: <linux-kernel+bounces-418153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3699D5DCF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4F54B26130
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F06C1DE4D3;
	Fri, 22 Nov 2024 11:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KmFrB1pm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B401DDC39;
	Fri, 22 Nov 2024 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732273868; cv=fail; b=PN88usn4tOpJI4RKHAgaVJuR6POg5nb6BMykkAHDSq0jfYUfrOjcDynHx6O6NlyyLCjzLgXm9ZU8l/DwZ0Rhd+7GQOusCYNinp2sxcHxq3Te/EAmlQ0nJQySBOupI1+NHqSzzPUtAEjAaLbj/EBf72ccNampjw4J2zRrXNJ+fWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732273868; c=relaxed/simple;
	bh=IkL7xdzXPVkpMNBXOzV2PmhuwVfv55JE9Ul/A7lMP/0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fQKeZ1Ku80x3ABA+6jTJN85l0K7XQ1ryW96VI8fN3jlk9RPkMOxPr8uuLlggDlSIvMmMkmHc+lHPS7teJDJbbfoCZQGfzHm7UzKWy2U+nMAA7eMb5P/MbJQYxBSJ5AY8aU41TPnZVl3g2s3P2G9lgwFFto8s9JfBNYzOAKJK8fA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KmFrB1pm; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732273868; x=1763809868;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IkL7xdzXPVkpMNBXOzV2PmhuwVfv55JE9Ul/A7lMP/0=;
  b=KmFrB1pmgcj6iFhgG0ZoIpc+eHADcir4INu/WniWdxWfP/+DWoznXdLb
   XCV8vjACx4Z39wIQFHH/PLQTRNuCa+h+yBF52VgHSYT1HcFi+HbMN6tRH
   LnoHtEe8N0X0pEKE8EUwKbT7mkoKroSkRbSUhtShwqdsVoIRJHqI9qLS7
   EBqGUjgWdu3G9nbAL9WsZ+cVhcOc/AIpyz5fJrSC2LsjJ/DvdjK3C2+Dk
   fsMVPMIl5ZZWPKlBLuch+ip4o21BXTutizwrSRqKWCkJYS+jCpnx4oOEV
   9LCMntlIoID5PDWEjApu0Ry4Zp+7JY4I727iG4RDi8fHOSRg6wTDmbA1Q
   A==;
X-CSE-ConnectionGUID: KXQjLmWMRKeCDDvu6O9GlA==
X-CSE-MsgGUID: TqeI/os1RRiku+WyD0581w==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32284538"
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="32284538"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 03:11:06 -0800
X-CSE-ConnectionGUID: Fqs/jd1aQPKK47rJC2+lGA==
X-CSE-MsgGUID: S6X2s53UQLK79u9D9u4wPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="90968448"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2024 03:11:05 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 22 Nov 2024 03:11:05 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 22 Nov 2024 03:11:05 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 22 Nov 2024 03:11:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4u785etFdDpP2MMhgblQD/tYcKi9yy5I8U5amVtHB5ZayCz2E1WiJs3cCI2ZSOO6ia9zVOef3h4040p3BkK5PTuzRcWqCS+yw5Un87deBT1R+yW+B0T1ZNYhTuDR55awEFtNOCD0V1dFLo22m34K/nP4Ocdry74MRjTm3hGoH8bbzVDXKBe8fmwyjUZKsYWhTkR1us67HUIbpUQJWq4QdAPSR3BJQIoDt2drIsnJZNAsyEQgAxMYt7jnd44taouKfQufbjQ59CyfIiLaAhe/an4/9Bj7g4T7wsSTlyiikkB7DYUaJhZ4p/rECxUhECRX9QVc+um42VbnpKVheSL8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrGhVXupMPfTg5Y1ARik5UiitdRRrryco9QhwkIMA/o=;
 b=W5k6tRtnOYUQrfTAoENTq120AOMH/E2DboUnrd31452WU7Vs/ysUz7ZEltTBSA4SZlwATfAaW642pPzfVkOT+DEmV2UzYEvmG3W0405adJNyimGAbYgxwCxeXTveZUoH99qLLBxZnO8ydJuX3VjE84P+BPz63bKFkQfzB5S/s0p7JKTh57BaW5vNz/NGrER2EnDjhmnDLAG9aPBz6m2C3lZWl2DV1b/dwos+XsFeIX1roL9nIZFmvEGX6aI6yiIRIlQsUm4TZUcyy+McqXkAh3/WQNuXNgGVFJGkzqKR0Ec/+gmNt+LOhgByPe28K+WaNESP0AQw1qqM10tENF122w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 LV8PR11MB8487.namprd11.prod.outlook.com (2603:10b6:408:1ed::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Fri, 22 Nov
 2024 11:10:58 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::cd01:59f6:b0f8:c832]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::cd01:59f6:b0f8:c832%4]) with mapi id 15.20.8158.021; Fri, 22 Nov 2024
 11:10:57 +0000
Message-ID: <970b517b-f1c7-4c18-88a8-aba5c2b6200c@intel.com>
Date: Fri, 22 Nov 2024 12:10:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: Intel: avs: Add error handling in
 avs_tplg_parse_initial_configs
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
CC: <tiwai@suse.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>, Mark Brown
	<broonie@kernel.org>
References: <20241122063257.4419-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20241122063257.4419-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0018.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::15) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6375:EE_|LV8PR11MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: 924ed49e-ee66-4d17-d31c-08dd0ae6570b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWdoMW0vRUk5TFBLS3VlMEZNWU01ZDJoTG9NK3lHWTFKZDY5WEVwcnlGOXBk?=
 =?utf-8?B?YlEvY3ZQeTh0OHFvWUNITE5tQ0lyM3VLQVN4bWUxVU8xTDg0Ni81MVpjUkxv?=
 =?utf-8?B?K1VoV0JtN3FFOWttaGxMSDZwOWpTY0tvQlpaZUg0TXI3MkwwWGo3RHJyYWl4?=
 =?utf-8?B?VmRnMTFRVU5CcUx6V3FpaWJBbVVna2RXOFdoL05Sbjg2WnM3NUI4bTY2S09P?=
 =?utf-8?B?R1FnR2FsTlBDTUw5VlRjTUtiSFp3dVN5TVJTRnZVTk1DWXVmeGNuSklseGw4?=
 =?utf-8?B?UFpLVitwaUpaQnUxcFJYNElyby9hWGYvVnpxVDhhaFJlSTdlSk5GcjF5V1Rk?=
 =?utf-8?B?c0NlR2tWcklxVXFWNHQyNFpEME0yUUlra0xta0R2VDJIbWgwOHU1Qmx5MTFr?=
 =?utf-8?B?VjNIU3pKZDZmazhTTW1nK214Yi8zcHZYdTNVQWtjYmMzUnprQVNVcnU2ZE9V?=
 =?utf-8?B?THRxNVFlNXc1bW8xOXdlVmpEdkUvbHpiVjNQSU5jZCtheU12emtreUxyZXp1?=
 =?utf-8?B?UDZhRXQwekZlM3Z3b3VYaDBiaHpLVFNTOGpYWDY0VE5KMDAyOGpDOVpLZnVG?=
 =?utf-8?B?ZTQvdis3N0t2RzU3TVRSMG16Z2RBTFdpYktXQmRJdS95Z2VoZnlGWkVFUzRa?=
 =?utf-8?B?bDBnUjZzY3pMcUQ4amZPaEdjdzFZSVlCdHdNV0k3SnVXRnVOUFdJekNmeklx?=
 =?utf-8?B?ZytmbkRTWGdabWRQUTZiKzhsMktVbitLU0ZVL1ZYNUlBTTNDWTNhN0NwVlBx?=
 =?utf-8?B?aHJWbVhkZFBVbFdlajF0L2FoRnEzTTBZeEFmOXhpYlYvQzlPalRTWDhnYlRT?=
 =?utf-8?B?WGIvdWtnbjhBTWJpYVVSdi9Eb1ZmSWl1N09OYmtTQ0xwSHlVTjFuSm9sMWFT?=
 =?utf-8?B?b1NPZGFISSt0YVd3dkxpazBwZUpVNE53U3kwNllBV1E2RjBUVC9RWU1XYVN2?=
 =?utf-8?B?UnJmcWlMZG4vWXNIb0FOU0x1STNCajc3TGRzZTliS0kybnlKem16SzlHNHBp?=
 =?utf-8?B?bjR4dHpzdG8wcnVncUl0T2k0dW94MDVlVk9TZG9BTHUrV0dxSVBnak1IWVFY?=
 =?utf-8?B?ZkFJbnR2R1MwclFKZnMwTEluV0Q5YXMzS2w1SnJvM1h3dlZqYTNPL3lya2Vu?=
 =?utf-8?B?aXA1WWthNzcrNVExaU1rcnlYZjhFbHdEYVVIZHdNSmdvbWxFclRjU3QveFc5?=
 =?utf-8?B?eE4yKzZXRW9JVlY1YmFpTlBLc3NSbVZXaFNiUXY5a0w5RVB5dDZJQUxZZFlQ?=
 =?utf-8?B?dVlwV0RxSEdCL3ZaNy9YWHZHZkl2TjNKbjlnSm5PZ3ArUWdPeHo5OEdFVFFE?=
 =?utf-8?B?Z2I0RFo0c0I2RnlRZmVMd2lDYmEyelpPSno5RlJrS0JSY3ZsckRyV1JRUzMr?=
 =?utf-8?B?aCtoKzFQM0kwRzdDSGEzNFZmdFVHZWRwY255NDhiQnd1RGV0ZFl6MUdaVEhs?=
 =?utf-8?B?ZjdHWjFNZ1hHTDV5am5PYkF5OFVNK1Ridkd6eERSa3JvTnp1WmRINGRpS0I2?=
 =?utf-8?B?WU96aEtpMUd6d1dBd1BiQkFVczZOYkVvS2xBdVluZzRRYTdsZDBXWDhyM2hh?=
 =?utf-8?B?c3ovcFdpWHlmRnd4K3pnaHVmN2h3N2dlbTBrZC96aDJRU01tUEVqWXorWVYz?=
 =?utf-8?B?MzFacXcvZWN6RS9BcnkrbUR4eHBSTDNCSnN4Tzd1OURJU3dNL1crTG9VdlU1?=
 =?utf-8?B?U0xTQ0ZrN3l4TllvNFp4ekthall6VVQ1bHhST2FSMUdTcFJiYWdrRXBJbUo1?=
 =?utf-8?Q?i5DaVS3lgXG+c5D0IDRLoEekCohg0ALC1RhfvLN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFhGK3NPZGR5Z3AxTmdXZ2RGc25kUFVlYUx6cGhKNUZaUFNiNE5Hb1NET0tx?=
 =?utf-8?B?YitpRzA5bGlwc0xSdDlTMjhXdzJvOGVDbDdINVNMc2laelBUZ0NQdFdSSnpz?=
 =?utf-8?B?Rm9wL240RzVkazBCWTdxcXlndHJ4TVMwQzFMaFJiUWRyQmJqTkR5cGJjdDZx?=
 =?utf-8?B?cDBEQVhVRHd6SVB3d1U3NGhQU2U3UkZjc3Y5MVpYR0h0TkZ6RFpWTDk1Q1dQ?=
 =?utf-8?B?WlhzTkZhTWFud3huNkZvZEZBMG0rc1lhbEw0RnREbmpIeC9yekJnNXJaMXZ5?=
 =?utf-8?B?WUNpcEQzTkwxV0U0bE1GYXpKd3MzYUk3cGFlQzMxRndoeWt3UnF2THU3d095?=
 =?utf-8?B?d1ZHRW5qYThRS0xWVllyZVpldTF0SWx1Y0NYd3N1eVcyQUVwdFVDRFh3eGZ0?=
 =?utf-8?B?VlBnV1RoM1FQM3BjVG5TczcrYUFEZ011QXRnb0pFZDRJRCsxRG1Mdkptc0VX?=
 =?utf-8?B?cS9TQWFtakNIVkNxYy9INzFJOGVJNS9ZTnZqUTVIOXUrNGFKZkRwS3Y4MUtx?=
 =?utf-8?B?R1g1NWkwQ1BHajVsZHB3L3FpTDFXbGZaVGpNdnVJYjNRTUZobk9TczEyRGZs?=
 =?utf-8?B?OCtJNU1yaWNQVkdib0l1MjA4TDVMaWszSnJaQnRTWXQxWGI1cVJXVnpoczlL?=
 =?utf-8?B?MU1Da0xRdElRTER3MW1Ha2M3eUZLelBIdkFtTjJvVzFNNVdmUGtScm9RZFJu?=
 =?utf-8?B?N0UzNm1EbUpKZE50M3I3U1FDa2NIemVjRXdZNjVvdXF0TjRaa3lsK0hONmhL?=
 =?utf-8?B?RVRFNDk1Tk5scUFZdzY2aUt4dGJRNWR2dHIrQkx2Vm1wWHJsTHphczNzSjd2?=
 =?utf-8?B?dnp3U1JLMzVvb3BiMjR1OTM4UHI0emllQ3hSLzFMcVlPNlRTSVkzOHhHRSt0?=
 =?utf-8?B?ajg3MVpRbk0ycGROdnhBS1dHSFZpQzZPVXowK21PZzdyeGNiVHNacGZMM1lt?=
 =?utf-8?B?bzJROEVZTkV6WjJ4Y1RPbytUZS85Z2ZnMTZTT2o3dU9KclMyWFoxMENOR2pl?=
 =?utf-8?B?Q1diWElVcTNXMHExMER4Ris1TzFSSDJmS21vUUhiRG1mQzZqbDNPMzlaSWlR?=
 =?utf-8?B?TXNzL28wc3k4YXdnZXlBUElHamdQc3F3VXJDV0NIeDRWSUZpVS9YdHFabENQ?=
 =?utf-8?B?NEVJZlMvdWkyakdocjRBcFRuaGU5TmpQRk9XMG1BR2dWbTdkWkNxNUNQZ0lW?=
 =?utf-8?B?Rm83alZhQS9MMW5pZCtHM3J4M0lOaENVK2k3cG55YlVkUC9wZFVqRnFKQzh4?=
 =?utf-8?B?RU1EZTlLd01sVFJjT2hQTFpCYUhnd0pDK01vZDdnVWFwV1RGKzBLWjJXNkpK?=
 =?utf-8?B?Y084SEdCdGVBZWpXN2ZjdXlxdThoRjdMdHRLSUJNTFpXa0ZCY1Jic0FHelhv?=
 =?utf-8?B?THQyNkdTSGlZbUlrWU4rWDVIK21ScHZXNFRqMjdQOFdpWFVwcUVROEZ5U3Bk?=
 =?utf-8?B?RFcraFlROFdTbXpPQXFTZXpOWlVCR1Yxak4xUFdHTDZFMUoycUVCQUtrTnVy?=
 =?utf-8?B?Y01ZQ2F0dGJNZzZpSE14S3ZVNEhLVGFqYW92TTZsWnBsSDErRkZYZjlSZlJ5?=
 =?utf-8?B?SGtQYVNWVDBvc0VUZlM4cGRad3RVQ1YwY3pGS1cyekw2bHlYVlJ6RXBFUGFT?=
 =?utf-8?B?b0haZzRNVnZ3R0w2NURKWXVVK2RXbHc1eHJzWURaUnhwTTdJdHNQd3lQa3c0?=
 =?utf-8?B?MGFUVEN5Z3JGQXlkR3BSMkVGRUJQSmJEV0YxK3FURTNxOXJTUTlhejZCWmVi?=
 =?utf-8?B?dk9ZeEVOTXNEbGFiQXNGcUFqYTZyQzRWc1NHV2RydzhHME9TOTcybUxtUmQ1?=
 =?utf-8?B?NU9nM0NwMlB0Y0dmUlBCUHI5NVFrdnVnbXkrTXROemw4aXJMZy9aTm45UllE?=
 =?utf-8?B?dGEwdW5QUzlzZEwzY25RSFB3Z29TbHR3VEhoTHBVeTQwNGh2bUdHSjRlSHIw?=
 =?utf-8?B?K1dBY2hGUzErTm91ckxnTVpvbWgrcnZMK2IzWWlrUGw4eEVlTmNXQlFlTitp?=
 =?utf-8?B?WnN0eUc1aVdya2Y5cHMzTk82SEVrRkFBSXczbGoraXhoTWQ5QzFGNEhHTW8w?=
 =?utf-8?B?SDNuQmpEa21IY1BPTE04TmlBUWFoM1pkTEs1QmUyeWEzVTAwWk82d0FkTkJP?=
 =?utf-8?B?QS9CamRuQytiYXVFbUR3dTFOeDBOeGg4cGtsMHdielVsbm9RR2JpL2tzeUVT?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 924ed49e-ee66-4d17-d31c-08dd0ae6570b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 11:10:57.7031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZbFfI2h8ngFvZ383he9MIaKE3an4byrwRP2IXx+SBCsZu4GG+mswGUSjZ1odKDfwPAyu1guzniDo85ZQyy4g+6opyTpc8BsKAH081CsgLoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8487
X-OriginatorOrg: intel.com


On 2024-11-22 7:32 AM, Zhu Jun wrote:
> Introduce error handling in avs_tplg_parse_initial_configs to ensure that
> the function returns immediately if parse_dictionary_entries fails.

Nitpick: mention functions with '()' to make them stand out next to 
their struct/field friends, e.g.: avs_tplg_parse_initial_configs().

> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>   sound/soc/intel/avs/topology.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/avs/topology.c b/sound/soc/intel/avs/topology.c
> index 5cda52702..3f76581af 100644
> --- a/sound/soc/intel/avs/topology.c
> +++ b/sound/soc/intel/avs/topology.c
> @@ -1500,7 +1500,6 @@ static int avs_tplg_parse_initial_configs(struct snd_soc_component *comp,
>   				      AVS_TKN_MANIFEST_NUM_INIT_CONFIGS_U32);
>   	if (ret)
>   		return ret;
> -

Spurious whitespace change. Please remove.

>   	block_size -= le32_to_cpu(tuples->size);
>   	/* With header parsed, move on to parsing entries. */
>   	tuples = avs_tplg_vendor_array_next(tuples);
> @@ -1522,6 +1521,8 @@ static int avs_tplg_parse_initial_configs(struct snd_soc_component *comp,
>   					       AVS_TKN_MOD_INIT_CONFIG_ID_U32,
>   					       mod_init_config_parsers,
>   					       ARRAY_SIZE(mod_init_config_parsers));
> +		if (ret)
> +			return ret;
>   

Agree, outcome of parse_dictionary_entries() shall be verified.

>   		block_size -= esize;
>   

Jun, in future, please remember to add Mark Brown to the list, he's the 
maintainer who governs the ASoC subsystem. If you are unsure who 
maintains what, ./scripts/get_maintainer.pl should help with that.

