Return-Path: <linux-kernel+bounces-234234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3991F91C41C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF60A1F21EDA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F32C1C9ED9;
	Fri, 28 Jun 2024 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PvBI+VhS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D8ED2E5
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 16:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719593328; cv=fail; b=iEZC/o+sU0fU1Q0Zo/8XkL/YNeURJHnf7uz4c7ETZpJxw2UMo9liDWT+QHnbT8YgHKt5hVUlct234NOKLN4opAzRypBTOC6JBTA5JvCX3C+2IH5IvDXxwfw8PEBhKfP9xTgNgDWyk7IT+faizpLnNaGQDzcovBZFtuqJwcV2dsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719593328; c=relaxed/simple;
	bh=ivwYhiWXBZ/nplTvXCkwMlMQVraMd8XUBCnGLAc57o8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nk7YLhthpwsabPhFFCMf33XXHm2XkbWbNHPCUrimuyeqEq4TK/OZbVm5I1urKS3Mqvc+VzRm46F7P3YJ+G8umaviKCh8k9aIBqrJf1cYpi++lOj5AAEnx8+Qq0J8v7qwZAPfRlARBK1ksZnwLStEdoG7u8wiyy5rJtPNGkpbo8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PvBI+VhS; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719593327; x=1751129327;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ivwYhiWXBZ/nplTvXCkwMlMQVraMd8XUBCnGLAc57o8=;
  b=PvBI+VhSYDnIok1XhDXaq18xIP6y0++AGNxxzJPz0Jnwq6So9iwnxiOO
   7japYt0ExR7ZJ/1dX9LPYz03S0W9ekEATrHBJboXPsRO22xWaFBL5mKpL
   oMmdHk3ggeIaSwJmKRYfAtZY9bHuC/uc7v0Z4qcuLH5nGn5k39O++suDy
   fEcVeVyKhOdS9QmYDoHW7+8obZLvNZ4+eZdX+dzQGS3lGqXucHNT8zxEm
   SHz460fCyNL9uOmYPTiCW6sV3X84QXJxfjdoQPBrIGYYkl7na7/cN0+BQ
   t1IeLJItVki0Kou1T41xNxkpDJ+JUsAgny88GgynAVZvjMUMkmlwVeYg/
   g==;
X-CSE-ConnectionGUID: QDmNxGtsR6OcViESC0ynrg==
X-CSE-MsgGUID: rOW6Dl/0SJ+YVbdyRRypig==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="20601252"
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="20601252"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 09:48:45 -0700
X-CSE-ConnectionGUID: /HszP9S2QRGu1+isVbHudw==
X-CSE-MsgGUID: x5KZ8OKcSE208EFNGHH2DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="49752135"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jun 2024 09:48:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 09:48:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 09:48:44 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 09:48:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJudlqzDVDDX8h4Hdzt9+Tfy70HytH2q5sQaEvmYeVc2cYzmlhxQUWEk6rKNo0H6Jk0hLyjZAAh/JtzjX3glhRZMLlpZxQiniylPx6i+it3gY4AFUwbnJZFeoOVLzKO/KQmo8TtFt3ThzQYZGBKmM3gIoZ5V2M8tjTYqFagmiZQElz/9tI7ijXp0BJ0GtUBsLqoFeBrVomEysIM+VvTbP/xRn0nCVnXlt4rUv+a7XLbbyCiIC7y14abGG/Pf+42jEmc03+DRFkjkINZE9PSew2UeGWrCGDeO+tCcfgcIyUgiuoIsLFwy4dDZNwFzT8CWeSX2+5KrUIqcCh1bCu+2yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1MwQWr8g++ZPmJFbXhvFRvjpmHhoQVKhk9XfSawq2Y=;
 b=n5muR8aNmNYstVfO841eTgFVbr3vuIwNXG47NuijY0fNCnAdAz8x0jGxZ0foZ9avbGba6ZRzLJ8jH+XvHzUTijzoF2fhuQqMArVySJZLtPd26ocBkbVbBSecIOOGpkr06VycptHQuYQJmAC2hYKiyZ/eY5WHnOWW0ID+JilvzYlj1ibEpa0oSMDQ4oHtS+/qSdY6x2wlytUnUAEeIYTHspxtXIWmr5n5RkZ8lzd/eUOLCQbFbSrDYT8ifTWmct3XyyGyp3aFHZTNEUxm1ZroOy2OgfR2Atn01EFuD+TcRSyI/OmbwlA1AinsIgNZcH25w2L8cyblNDaG11dVu/AXmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB4840.namprd11.prod.outlook.com (2603:10b6:510:43::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 16:48:42 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 16:48:42 +0000
Message-ID: <2b163af7-12d5-443d-a302-22d98c1facf1@intel.com>
Date: Fri, 28 Jun 2024 09:48:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/38] x86/resctrl: Stop using the
 for_each_*_rdt_resource() walkers
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
	"Dave Martin" <dave.martin@arm.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>
References: <20240614150033.10454-1-james.morse@arm.com>
 <20240614150033.10454-18-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240614150033.10454-18-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0160.namprd04.prod.outlook.com
 (2603:10b6:303:85::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB4840:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf63cae-b23d-4ac6-77f9-08dc97922ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHU1Mnpkd1Zudm9DSnVKRzgzRzNiakZIdDRQRXQvNHRWb1FFSUxMSE85VnRr?=
 =?utf-8?B?Q3dDbms2Ym4vb2VvNnBaOFYwM2pRVU9RMVg3VWxldXI2QkZVR09SVnFhWU1Z?=
 =?utf-8?B?QmFDVVBjY1BHUnpEVWJrRXNta1BHRmg1VnM1eTVNQU1KV3l5QjFIVUtURUVS?=
 =?utf-8?B?eWp6Y1grM3hQUDYydmJja3ZBalZQc1Z2MzdvTFpkUkxRNGs4YWExT0srTFpC?=
 =?utf-8?B?RS81dG13ZkJWV3ZTTGlkOUVoaHVYYVRPRlVFZURZUDJ1SjAzRDI5T2pKbXQy?=
 =?utf-8?B?NkFtTFNLdy9UVDJTRno5Y0Q1SUxYWWswOVUyTlhRNXV4Wm9NOHViNnZ4VlJE?=
 =?utf-8?B?QmZVWFR1c3N6dkhqVk9MN2RMVzV6UTBZdGYySVFNd29vK21LbUZCbjNJYThz?=
 =?utf-8?B?ZTZKMVFGK3pramlGNmMycVdGZm1vL1Z0UjVjRkx1dkFFT0pPNlNYWXB1elhI?=
 =?utf-8?B?V3hSbjFzdDFpb09WV2hpRVA0NzV1Y2FONHF6N2NmU3Y3RzBpWXlQNW9hQ1Fj?=
 =?utf-8?B?K2Jpak4zL1Q0OVNxdDAyTEFjbDVPdEVtenMremU5VWpXTkMrMDRVbDlDcVhX?=
 =?utf-8?B?eEorSWhYSHZnY09Tb3FIZzMxL2ZydWx2MTRHTVFCMUxLS0NYaFlXNS9lazIv?=
 =?utf-8?B?RjRVTm8xcGVuMktXVmd0dW13bS9ISXRFMTc4MTl0c0N0cTJqVUNJTG9YYmpk?=
 =?utf-8?B?KzNzVUdMOGVwRllERWhoeG1aa0FEbnpWcFFsMm8xTDA2M1Q4K1Vkc0lBMkRx?=
 =?utf-8?B?Z2xDZHJadUxXZlhTWHFnd0t0UXJNcUc3cFhrdlVmd1dpRnArL2VLUmt1QkFR?=
 =?utf-8?B?M2tJVzhSVTFDV0hXczFxYUF4TEVobEpPb09QS3R5ckFoei9GcnBuaGVmWjky?=
 =?utf-8?B?U01GUmljWW9taHVMQ0w1ejlkM0ZCWE9XRDVVNW9BZm5ib3M0UFJVWUQ2dTdy?=
 =?utf-8?B?cGcrMGx3Z1RKVHhkZFZiWXpCWFlSbDZVK3VFOHRrbDkraUNqYVV6ZVJaK1Y2?=
 =?utf-8?B?Y09VcHpIbjJKdFFFKzcwTDRpdzlGVWp6ZFZyY0VndjBxbVhqYWd3d0FkdTd1?=
 =?utf-8?B?RkROc3N4Zk1mcGZublB4UG9zL043RTdNQk5ZakhrY0NsdjdJaHltTTJaSWhC?=
 =?utf-8?B?L2NCN0tSWVZxcUlvWVk1OVNnN3lBWlVHQTBmdnRHcG40c0pWS1U5QTVIcUN3?=
 =?utf-8?B?ZVA0cDQyZEthUXMySTNGRlZrUGNYenJrR1NRdnVwNTBJc1EyN0lVOUlHb1VP?=
 =?utf-8?B?bUFrcmcrTC92cWRGTC93OTEzWTBLWDM4RDVQaWMzRmFyaXlZRzBZcHlmbUha?=
 =?utf-8?B?S05GK3cxRXFHb1pqQUltWE04aHhOMklocDdxT21oNjN1YmlPbWZSekU4OUR2?=
 =?utf-8?B?MWU4dFBYOE5SWjFXTkQxNjcyMmJWWWE5a1MxTm5zNzZsTjYydzRvbUp2K0Za?=
 =?utf-8?B?L1FCeVY0ZFNRSU1mRm1Nczk0dEFiV0JDSytjaXJGR1lxRE9QSjRZdlppQnJF?=
 =?utf-8?B?K0lQU3lXTjlVamN6K3kzSHhHOU8yS0lUbHFzMndOamZjcktLUmlwQUh4emFG?=
 =?utf-8?B?TkVpS3M4UUpJaWJLM0tVRGgzUlFJbVVkaGZHdnZOMTBGNHdBVDJjMkhyTXlL?=
 =?utf-8?B?VUZEWFBzSEMycE1jamVqNHh6clVYTVdIOGZvOUpSVk5HYnR3NTgzQzIrVTc3?=
 =?utf-8?B?VWtFK29mKzJSR3lDdk4yQVo3QmRwaUN5WlI5VjBpQTdYV1EzNzRseUxlL1Er?=
 =?utf-8?B?ekt4czdHT2RPUTJXeEpPYUxac3dYY3hNT243OVlHc3NZWGpzQ0VzNE5yKzlS?=
 =?utf-8?B?VmVSUE5wbXo3Yjh5YjFkQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0JnMzBOVDdKT000WUVvTG1FT3lGRXlFcmxJTTgzeHRNM1VBVXZkNk9TREQw?=
 =?utf-8?B?aEF2S3h5REF0MzhPekpnSEtFT2t2bC9wU2drZnQveTJPTGp5MlJsQjNsT1Z4?=
 =?utf-8?B?YUpaU3Q4ajZrdXdBYVd5Z2hWWFlYdGd5VWRodDUwTzAxRElYbUpKU1N0QXNw?=
 =?utf-8?B?ZU82cWI1M1p1Y1d1UitFa251OFJaVkl5MnpPbDFteGt6YWtweGJIaE8zT1FS?=
 =?utf-8?B?b3Z3dHdkbkFxT2s1ak1BeHQvNVJneEY1eXQyU3J6S0JVOGRMVmhSWDIzSE5y?=
 =?utf-8?B?VmZNcnBVNnlxYTJyWmdjNEZnTDNlWCt2SERlbkxiWlh5VStRVWF4S2FEUDl0?=
 =?utf-8?B?c2hRL1JOTHpzOUtkU3g4ME55NkJtNXdWclY4VExPWURUc2trRDlOYTFkcWYv?=
 =?utf-8?B?VGtrUlFKZDhxYTN2c2xHaDZCSHdRL3kzNEpaN2NsUExaQ1RJQ3NkaGdheits?=
 =?utf-8?B?d3NQM0s0VHFWWEE0QjJHRW8wdGpXMUxiUExhdzBybUNxOWowbXdpYXNhRE1Q?=
 =?utf-8?B?SXo1ZWFrYW9sQlM3MGtkTXdLQnJsMndoWHhsVjdCSzVxZWFGVmpJRVRUZWFF?=
 =?utf-8?B?UFdBZ210R0VBaStuRHNaeEFDdDNuaFYwanUxN3VXZng5OGErcVY3MXlLdGRi?=
 =?utf-8?B?VHhsN2xxd0kwU01kSXRaYm95ajExOUc1dHFEWll0c2R3Z2ZDaWJTOGk0d2l4?=
 =?utf-8?B?VGRKaWxvd1RzanhwMWJTbFpDK3dWWkhybzhVczZjdmt4U0o4NS9KbVUyMTd5?=
 =?utf-8?B?VitoYWdIRFZZSlV0ZTRuaG1RYW03MUVOb0RMZVdTdXlQWXdOOUcyd25WckNn?=
 =?utf-8?B?bHlyTU15bklLU3luYXVPNG5MRGlwL2xhdTh6ZEIxS0R3VjY1RXJBbXBEY3JD?=
 =?utf-8?B?aEZWNVFpR01LcXpSSzhVVXhLUmQ5ZEJNeGpFTCt4bS9ERHVZTFEvQnhCa1N6?=
 =?utf-8?B?cFBXNDhaeUNQNzVKTG9ORE5CNEZaOUZidTBNSWhpTnFmaTJlQnpsaHUvR3lC?=
 =?utf-8?B?a2pKMUllOUUvUjhaNVFrLzdINFBKL0lKUHdlSFVGbnRpeXY4YlJCbkdWWHor?=
 =?utf-8?B?SVR6VThVNjhXVWtzQlp3b0cwbWZQK0RzaytQV2k4VFR5ejdYMjZtOUM3dHox?=
 =?utf-8?B?enhNQXhtUkptTjhlNXRVdGtwZXRzNlpaSW9tUE12Y0NZeWNZaEJpZ3RiRnB3?=
 =?utf-8?B?Y3l4RU5FTG9XdWZJNjNtVVVLMWNBZ0RTeHZPaFo4ZlZpVE5vSzJlZDkrc2sv?=
 =?utf-8?B?STM5SFZMaDY0VCtYZFJaQUw0Kzk4RUdEZ2pSZEdQRE9WUHlWQ3NBY080SXFa?=
 =?utf-8?B?Z2E5TUVkY2JXcjU3ZHFEdzA3alJmcDJSdldFbmoxMDFsdklKRG5CakpGRDAx?=
 =?utf-8?B?bnF6RGNnNS8vdlJ2MFJGTUtzWEN2aXRxSHF4clZsT2NTZ3p4NU9lMDBERURs?=
 =?utf-8?B?RTZ4U3Rxd1ZCck55RXlvc1JsV2RpNVVRUStueDUyTCtQNEFqcDVGQXNoR2JM?=
 =?utf-8?B?VWVXUW5sMkdjVW5laUppUllqMTlqY1o5MkVNN1hlMmF6THVSSkhSV2QyOERG?=
 =?utf-8?B?SGhJb2lacFNpVmlpdWNEY0ZJTm1uYTBuSTV1Wkdna2JEUWx3dFczUHZZeW1u?=
 =?utf-8?B?TXZabllvL3p4a1crOEFOV2hySllLV3ROUjBNMy8rV00wSmFSVTNzMlRaYTgy?=
 =?utf-8?B?dFJ1a0lvRHEvRXM0REszQmN6cmoxQi9mS3p2SGRjVURhOW5ibHF0VFBLYXAy?=
 =?utf-8?B?V2hud1pkcnZ5dXkzNVJpUHk4eGdIRG5meWpCR2J3NnJ5UmtJd0pnZ1BPR1Nr?=
 =?utf-8?B?MExpODVhWGFTaVUvZHA3UXU3NElPR3c2N2dvL2NCVFNnTWV3R05ZVUc1NWV6?=
 =?utf-8?B?OEZJTFBzWDk2bS9abFpMNXltUEJGTHRSSFNTNkRYdis3WlpxK0dBSVNRekhx?=
 =?utf-8?B?NTZaYzFZL01mK0RkaGtMTXdxb3lNR1RKbHZBQW4vdlo0dUg2YWVTSU9Kbyt5?=
 =?utf-8?B?V1ZJRWJWcEN2Ry9YclZWUGJTbG9NVytPTC9kZjFBOWs2MVBpK2VTbyt3bjdz?=
 =?utf-8?B?ZkNRTnhKVFJNNGZrZlNsT01MRWE3SVZEb0VBT3NWZEpHaFE2VXJxK3V1SUVa?=
 =?utf-8?B?SWNMRUMwV1QwSTBaempqOXUyc3dBMXpTcUt1TlZYa3B4a3p6SE5LTlZlNDQv?=
 =?utf-8?B?N0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf63cae-b23d-4ac6-77f9-08dc97922ac5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 16:48:41.9859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUXctXJAn4you6C/qCF8wAipqGRAJr+WjC28z3F4P4hssGHTdW1oqopykTTDEJF2jeZhd2ra2MS+Pg8G02Om8XIF8ErpwrlI+eO4zKmLWB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4840
X-OriginatorOrg: intel.com

Hi James,

On 6/14/24 8:00 AM, James Morse wrote:
> The for_each_*_rdt_resource() helpers walk the architecture's array
> of structures, using the resctrl visible part as an iterator. These
> became over-complex when the structures were split into a
> filesystem and architecture-specific struct. This approach avoided
> the need to touch every call site.
> 
> Once the filesystem parts of resctrl are moved to /fs/, both the
> architecture's resource array, and the definition of those structures
> is no longer accessible. To support resctrl, each architecture would
> have to provide equally complex macros.
> 
> Change the resctrl code that uses these to walk through the resource_level
> enum and check the mon/alloc capable flags instead. Instances in core.c,
> and resctrl_arch_reset_resources() remain part of x86's architecture
> specific code.
> 
> Co-developed-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
> Changes since v1:
>   * [Whitespace only] Fix bogus whitespace introduced in
>     rdtgroup_create_info_dir().
> 
>   * [Commit message only] Typo fix:
>     s/architectures/architecture's/g
> ---
>   arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  7 +++++-
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 28 +++++++++++++++++++----
>   2 files changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index aacf236dfe3b..ad20822bb64e 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -840,6 +840,7 @@ bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_domain *d, unsigned long cbm
>   bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
>   {
>   	cpumask_var_t cpu_with_psl;
> +	enum resctrl_res_level i;
>   	struct rdt_resource *r;
>   	struct rdt_domain *d_i;
>   	bool ret = false;
> @@ -854,7 +855,11 @@ bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
>   	 * First determine which cpus have pseudo-locked regions
>   	 * associated with them.
>   	 */
> -	for_each_alloc_capable_rdt_resource(r) {
> +	for (i = 0; i < RDT_NUM_RESOURCES; i++) {
> +		r = resctrl_arch_get_resource(i);
> +		if (!r->alloc_capable)
> +			continue;
> +

This looks like enough duplicate boilerplate for a new macro. For simplicity the
macro could require two arguments with enum resctrl_res_level also provided?

Reinette

