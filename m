Return-Path: <linux-kernel+bounces-204622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F258FF1D6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FEE3B2F69D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B33198831;
	Thu,  6 Jun 2024 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OGT60GjS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBF8197A64
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717689364; cv=fail; b=ABlH7u/maCjwK+NMb/wL+qwx3smJcMNdQbnKTvT8f5r7QZkSUgPaBXyWfixWHOd38gNoawIRzNMuEhDLpC0iNfO2O8AtSt6m4UOVnOYRm9SHx9We4BD2HhAIF5S/7Zob1cmxkR8+XVa4n1Jl3Fkybc7iaJ8fXOasILi8A8XwioI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717689364; c=relaxed/simple;
	bh=aelf7YRjhSgTJ+2gIVa0C1dzIFpeh4rYIXJOE6fV2h8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N58mFvpJxiZMYohrzs5OBwAzhCvbJtn0RPz2mWqni3DyEpaSfDYUz4ERfa/r39+VSAuRpRCm7aIFXT4WfNDeWftTB4S2vqKkz0/MLTHF7UDs095V94mreJsOAmjdif3ByuzR8zrVZc7uIJnzP24UYiPJVVsh1xc4o2uDjp6Df6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OGT60GjS; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717689362; x=1749225362;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aelf7YRjhSgTJ+2gIVa0C1dzIFpeh4rYIXJOE6fV2h8=;
  b=OGT60GjS9ZCGqfLo1V/glEb0aCo+/fA4D/kJmc8OftNjm+DaMNILwHyP
   dextCLuU5KDD4TMu9o03BxuxB8Zqwl+eGe6K+roycS2p3gYYARtuZgAPG
   te4Lsco7Igy0SbljhHcrkoQTTgLlTsqT5yf63qBQGNRubbPhSFvjqA7Km
   d9ycRpIHgXOWOoDz+tjsu2u5htXxnU/G6PxFxZnRxDUzg1j1/YAu9woU9
   +d8GlngAtlysSi0mAlWnUNZ/IdUA/RDrqn8jtGTU8Ln/ZMkMQ7NrMplk4
   Mhwz19MqOjuoPTEzQGppvIvgMrqHvxzR7S4LYZd0/xAwZ1FGdAh7RYLvt
   g==;
X-CSE-ConnectionGUID: aWK7r6zIQ3qDiY9pvIvkKw==
X-CSE-MsgGUID: zug2BPkYSL6kzi8t028+BA==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="25775879"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="25775879"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 08:55:47 -0700
X-CSE-ConnectionGUID: 3sFQs+x7Rvmi+8NjQnmYCA==
X-CSE-MsgGUID: KJHY8LzPSkKwTFCu+sr1jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="38093806"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Jun 2024 08:55:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 6 Jun 2024 08:55:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 6 Jun 2024 08:55:46 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Jun 2024 08:55:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMXxHdzcL7exZiRcBiseAY1NJOWNUEB85Z34XgVpJTrqNDB6A0e4KisfQVzkXjsc39YKi35nWphhdf7BgWIBpCz3oX1RfMhwUuuljcwcXVKPPCAtIzCZBJO7XV/KsleIZEEHCXHUP7RETETYEkx+Mv0WHEhXgATQxklmZot0OwN0Th2wvzsagTzjs0ICvS25Yi7x7MF3ELLVyF1G2jY33VENN5Twsz4XyhMb2rfJq1rfXzS4GdIReK0IsK6fL4coS9whgBXH2bVrKlXYFi1F7J+c7GAR21WnkmG3T+9GCfJi1ZfVEOEB9cLeAM/GqtJpwtLM6Y8xtiiyAMSZrWZqvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kV79f8LhrvbfyBisaRm4jblUV1qMunt/KIP3g2NqvPY=;
 b=TarZRMFQwv8BVmfbWIf3g9Ls6EkfG+cUwqRkh/tYvKz1l2YOG8j9GQYHyiGMIdG+UGpIvPfFlmiX+IatZzXzrgkmNpenIHxffdn6T6VHPBc86GcEIYrDZpoJs7mRhApnCqdIUUXAjimlWWgX+qgsMEHp3Vxwfr2sEPUZ47rtsP48Pw7AITesKtorezp+i2Tkzm6cwU2W0Dcfy0TlAMcQ9zv/VCgd3JNmPPsXGcC0pMM5fU5d+5WYZLrbv2qTG5is57ikkAo6cUQj+2XaEpbdAZX/3KtECTpq8zEmwnD2dYjLK5YeLTfMpHIigw2jJPs+a29oKcnz+ibdkFwdc4L8oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB7164.namprd11.prod.outlook.com (2603:10b6:303:212::6)
 by PH7PR11MB6008.namprd11.prod.outlook.com (2603:10b6:510:1d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 6 Jun
 2024 15:55:43 +0000
Received: from MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::a972:1395:dd49:1dc5]) by MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::a972:1395:dd49:1dc5%5]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 15:55:43 +0000
Message-ID: <c6fba849-1e27-4f32-85b0-3b6f920ddd36@intel.com>
Date: Thu, 6 Jun 2024 08:55:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fpu: Fix stale comment in ex_handler_fprestore()
To: Ingo Molnar <mingo@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>, Dave Hansen <dave@sr71.net>,
	"Peter Zijlstra" <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, "H .
 Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	"Oleg Nesterov" <oleg@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Uros
 Bizjak <ubizjak@gmail.com>
References: <20240605083557.2051480-1-mingo@kernel.org>
 <20240605083557.2051480-2-mingo@kernel.org>
 <204e541d-ff48-487c-8f70-619f90f65635@intel.com> <ZmGBvsCCM-4H0Oml@gmail.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <ZmGBvsCCM-4H0Oml@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0356.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::31) To MW4PR11MB7164.namprd11.prod.outlook.com
 (2603:10b6:303:212::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB7164:EE_|PH7PR11MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: 18adf2d0-1fda-4024-a4a1-08dc86411f49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0pXZERyOUFabjZxSHJuK0Z1VHU0TS9yREJDSXBlTnhRaEVhRDh1cG9KbzVm?=
 =?utf-8?B?N2ZTeTRNV0hMbnI0dzcrTDh6QmQ5YitieSsyZEZaU3prVlI3b2tkOWRuWDRz?=
 =?utf-8?B?Q3NFL0VYU3RCMmZLYnFhQmRFUTV1SEVtOUhETmF6akhKTUV5dnNZcEZRbkdY?=
 =?utf-8?B?QlJhclpXNmhmNk43RGxMT0FDWnBaQ3A0ZGhFdWYrWG5MUlh4S1M1WXRQT2Fr?=
 =?utf-8?B?b1AxRVBPbVVWQy9zcmVzMHRQWFRoYjJlcFR4OGJnb1h5QS9UNDloUktVc0Jq?=
 =?utf-8?B?VWp0TkxPaTN2aHV3b0pCc2hXdm5Wc0MvU1NGUVhEOUgwWmJWR0tNTXBnWnZX?=
 =?utf-8?B?S3ZyMjlLTTJXVVJNU3loLzR2WmFpeW5jWjFTbHhqRXUzeG5YSnYvMXpGU3Jz?=
 =?utf-8?B?Qm0xSmlERnliYVBmUkovV1VwWElUWlltZFdmekZuMy9vWG1oOGdoOEZhTUZM?=
 =?utf-8?B?SEV6YzhSN2l4Tm94YmxWYmkwNmxUQ1lxSFJzTElIR25yNlFoS0EraHdidTRr?=
 =?utf-8?B?dnpEMm9WRGt0Ui9yQ3BoeWFVZW1hbXFwem1NQ2UvQXg4dHpPWjc2d1NYQUtw?=
 =?utf-8?B?OXNZVE9pLzg4dEJFUzhSbk8rU090NDVtRTUrLzRBcGFCazJmUVVNRmdzMVdn?=
 =?utf-8?B?bEJoZjc4V2pjRnZLYVRHeXpGTDJtd3QrTzdXRk4reS9FOGlzTms2Uk9jT2VE?=
 =?utf-8?B?RXQ2RTdCSHFWNVFMYXlWcTNNOEduRnRqdVhhOGRWS3RFb2R3WXgrTUI5TDBx?=
 =?utf-8?B?YXNnSkhtUk82bHBJQjJHcG41dXBHRGJMRy9NaTdkdkNvRUs3WWJoMXhKUkpI?=
 =?utf-8?B?WlJBRGd4cmdCd0I0YkE1MTdhakpDVDBtWWtMMzlhMllBYk4vTDZDNGczSHpW?=
 =?utf-8?B?UUxaVXFDRTlNNnJMeDIvZ2VjbXc3T0tKNnpDa3NpaitreE93a1dKQ0hYM0k2?=
 =?utf-8?B?b2sxMys2ak9WZk5ZQWE1MXFpWFE2cndsaEhLdUNpNWtBcXR2eXRFYjlHR1RM?=
 =?utf-8?B?TnNSbmIwcnYyaW1FbFpvdllsc25ySW5tdEZwL1NYbkZrdzhNM09sZ3RGWFJs?=
 =?utf-8?B?VW1sR2VBenh0cElkNzNYaUFydk1STTZrenBob2FqdG1RN1BZYi9NYW5xRlAw?=
 =?utf-8?B?bHdiWVZDQmM3TnB4TmVGc1F1R1oyY0tlbGtqY2NkVDhyNjJTQjUxUjVTYkR2?=
 =?utf-8?B?WG9OL0RxQnlBRVByK1FaM1ZrRG1PaWZzdWcxRFdiWXZZVmxxVzFla2F5VnZv?=
 =?utf-8?B?VSt5SXFDTEhGVTNhWXFxSnZ6QjFnaE9XSGF1Ylp1OFl1YWVsaFhXZmE2alZX?=
 =?utf-8?B?bTkrbVo0b1NwQVhVbEF1SlIxSjhXcklERFFkTk0rSHdKbk1ZTkR0dE5zdFo1?=
 =?utf-8?B?NDYxMzVRcUNsanI0dlY3ekZnTmZWN01taDVUaGlBSDJaNmlUN1BKQ3dqOTIv?=
 =?utf-8?B?REc0aDhBVmZlcitmOVpyQkV2S2J3REN5Q2ZsL0Y5YzRnV3NKZXNQWmMwOEFX?=
 =?utf-8?B?NnB3QTMraHl0dHdaNzFkdFRKWmdvVWVzczFVYmo0K1hUdGxKVHRPWFBqaDRl?=
 =?utf-8?B?Z0xtR1NaTkNCVGFOS1pLMStKVUYvYUNmelJ4YnNJQ2VWd25zTkNiVmZHRXpU?=
 =?utf-8?B?N1k2blFsUXZ6NGx6VVZUbm9Cayt3OExRTmlYdkZIcTNENlU5Ri8vV0hQRVNP?=
 =?utf-8?B?ZnF2dHFadUF1TG1BK3k3azV0WDF5eHlRM2NCYm9CY0oxV3ZETmRJNUJkMjg0?=
 =?utf-8?Q?+GqwcCG371dDs+p9dc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7164.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2JXTmhIbDNXSnFSdDNMeXdvSXMxR2xsWCtQWUdRWXhjSGVpVXhIT0x1TTBB?=
 =?utf-8?B?eGQyajlTcDdPSi9TYzFCNUI0QXBWWStsSFArNGZ6THp0cWcxV2R5WnhEby9W?=
 =?utf-8?B?Y0xIc0ZOR1JCalBFWFY5YkwrbExJY0N5YS91Q2YweUN3Z214Mm1jNTR4YU4z?=
 =?utf-8?B?M2hNNGthblUyZHBTY0ZVbzFMVG1Gd2RSN1pFTXlXK3lGdTVlTTVQTTFBMkR5?=
 =?utf-8?B?dGd1TldodlBWL3ZHV0VvdkxDR3Nxcjk5QzM1U012VFRwaFZJTDBEUC9IRlpP?=
 =?utf-8?B?YjdrTTlObTRmbGdhMFJHMUFXbzBnemNiVGYxL1VmZnVlbXo5OXllM1B5bGRF?=
 =?utf-8?B?RFZJMzNNSUhibmdFRis1SHRYVTdtbDZNcUJFYzB6bkx1TzkyeExjUjNwYTQ0?=
 =?utf-8?B?Uk43WWVKT05CZmZEZWZzQWMvcHpnQnVuT1ZCZjdmVS9wSmUvVWZzSkhCdzE4?=
 =?utf-8?B?em42cFlwL3M0aEpISk13dEl2dWs5QUF2dUJFam5oVDJNVUZvblFRckJ0dUl3?=
 =?utf-8?B?NGJqcEgrR1RPVzhNT2tITTNRZXc1S1p6Y3pQdEt1UVliZkFGaGx4K1A5Q1VD?=
 =?utf-8?B?c2ZNYkZoVTZ2K0dHU1cxQ3VnZUZVWVRTTlowUTZVOGNaaWdFS3U2SlFuekJW?=
 =?utf-8?B?U3dMN0lPMys4R0lIZHJRWktDOWNKUDkvbnhzdE53cU1kdzN2RklzYjhtQS9I?=
 =?utf-8?B?MGZuM1E4MW81ZjRZRHpIbHpIUzZCYzVtNHByNTlCOEtqT1RoOXJrdEZ1RTdw?=
 =?utf-8?B?TE8wYWFhVEdsczJ4dWdFUmpLZWFWNWdwd1lUR0Jta0E5aWswTHhtenhRR3NR?=
 =?utf-8?B?VzJnRzZWWUsySFp1ZmxpQ0dmbUtta0tOL1E4eDg5U3FkTlBwTzN3MXZyYTRv?=
 =?utf-8?B?VHJlMFVBRDJZRTc1cGR0L2oxZEhIWGV2dTlObHZzaXN4ZkYvS0JwQ3lOdi9W?=
 =?utf-8?B?VU9XNEoyWmtkMVQzMUJKaWV5Q1lVRi9WR1U4RlRrV3cwTUtOWFVpNE1EOU1L?=
 =?utf-8?B?dnJZbDVZSkFVNldNN1ZGMXdJQUI0cm00UldSdkJSYUw4bU5NVm8zWnQ0Z0kv?=
 =?utf-8?B?cFRLZW5naFRMMUhCNy9GdGhScUsxSUFaT3JpZnN4YS9DWk9wRFpXbUIzcXRh?=
 =?utf-8?B?QVVaOUdJZnpoZ09SLzJNa0NLU2JEQURCSXd0NXJUT05KU2hFNDBtWXlBamhD?=
 =?utf-8?B?a0VyMmxVaHlqNEdYb0lpdGt1dTgycms5VjUxQ2IxaEcxWGZoY3hmMURVU0ZH?=
 =?utf-8?B?NWVBS3ZWUHlEWld4Sjl5QS90L3RoMnJhMXVWNFArL1d4eWplVkVIakNicHh5?=
 =?utf-8?B?N0VCb3ArbTh5WDY5c3RrZk94TDdMYVpZWllOY3FleW04c2FVM2hJMW82dnlM?=
 =?utf-8?B?WDE0ekFOU2dIN2lqay9Yb2ZKWVlDNWZ3eXFUNklkSEg0bkt1REl4dGxKSkNh?=
 =?utf-8?B?RnF3dlNVWWhWOTBWb0VFS0twc29lRk5Od25zMzJucmlqWUN4NERXTHhUaERY?=
 =?utf-8?B?aVV5VWVwSzdud21pN3hWL1BDZC9uUCtXS0VSajBBd0FxMGVaMnJjM2ZVTmwv?=
 =?utf-8?B?UFRESUdwWHh2RUVtRldIQ3A1OURZZmJnM3pwVlNzUG5uODJuNzMxVDlseWQy?=
 =?utf-8?B?SlJ5TjlrTjN2TUZxajlLVjVxVnVsV2hlS1ViZjFJbzE5UjVCU012bG5sZkMx?=
 =?utf-8?B?amhFaHRqUmZ3ek5HYTdSNnZNcnl5bWo2U0ZTUngzb3BKejlBcmpEWTBvVUF0?=
 =?utf-8?B?VU10STJ5a29ZOUZWeUNheWtHYmRReVgwa2VaRG1Xc2V1ZE5tbmkveTF5UGsy?=
 =?utf-8?B?bGFBL3EwTDNHcEtHYzNkeXRXK203WEtHak5BUkNHTGh6cGdibHZ4SzM2cVlV?=
 =?utf-8?B?VXE3WmhvTXJaa1MzRWVOcXBFUm03STErSEdJM0pveUtTbDBXaU5kRXhadjA2?=
 =?utf-8?B?TklQRU5SNXlQZm90QkZ3S3dmSS9oMmJyY0w1RzFieUdJMFZ0b3M1OXlPZkov?=
 =?utf-8?B?TlBCcllCZnQxSHAxZG5pc2pqWGUyaWdGbGJXaWY2aERuVWFTQm13MGVKR1VB?=
 =?utf-8?B?MWFzeFdINW9NY2JhcmtGaXM1ZWNGWFk2RG9xVVA2eHRlZENsaDlRcDFPWFo3?=
 =?utf-8?B?NVNDS05NN3ZzcE8vSHB6NmJSWDJRSVRwRmFRVTkyUWJHemhjbU9KWUowdVA3?=
 =?utf-8?B?V0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18adf2d0-1fda-4024-a4a1-08dc86411f49
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7164.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 15:55:43.6924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dDJrl7d9jmh6lkgt2zhs1D4HfTLE1lvpAEev7zi+NcAQhFeN/FZdD37l3KJ75iVRkDjJQLMeNUC4Kqcry4wtkwfdNK1k0TUEd0qbMYCjNkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6008
X-OriginatorOrg: intel.com

On 6/6/2024 2:30 AM, Ingo Molnar wrote:
> 
> From: Ingo Molnar <mingo@kernel.org>
> Date: Thu, 6 Jun 2024 11:27:57 +0200
> Subject: [PATCH] x86/fpu: Fix stale comment in ex_handler_fprestore()
> 
> The state -> fpstate rename of the fpu::fpstate field didn't
> get propagated to the comment describing ex_handler_fprestore(),
> fix it.
> 
> Reported-by: Chang S. Bae <chang.seok.bae@intel.com>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>

Yeah, looks good to me. Feel free to add:

Reviewed-by Chang S. Bae <chang.seok.bae@intel.com>

Thanks,
Chang

