Return-Path: <linux-kernel+bounces-392742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEB79B97A8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106C21C21035
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946821CEE97;
	Fri,  1 Nov 2024 18:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L7l9YDNN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40D91CEE83
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730486132; cv=fail; b=lwx8HwkiUXmBMDjfV0pjLpNpYauW+jXJ7J/GXvyPJsOWWqxKbQUIcBDyn8Uc/NJb0WTO+qm+5KBkpiAL4T3MFTw32QeLSEmPxyNEwipwBgqOhEKxKfBTNPPb3iyZgbHr2eIdj7idpMkrMjZeZQ4jVirtQAhJNAvJuw9Zft9TbLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730486132; c=relaxed/simple;
	bh=jp3YNSrirqCr3KQvrWfknPrIatOLTHjWnG8l85pWPBc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sIF17na8bgO4k3j7Lm6qPa0ESSkSWRJy/agWyJh7Ah+VlIiO9UKnzh/SHaH2QkHOdqNJ359Ih8SXm4AJXHPBCtWA5SyXeulQa7aHydTdkOLw4RN8AwF8W/M7SI7YCXBQdOqI6flcpeDzXPkx64izvzuhgbFHPCLQZnh2BBebU4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L7l9YDNN; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730486130; x=1762022130;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jp3YNSrirqCr3KQvrWfknPrIatOLTHjWnG8l85pWPBc=;
  b=L7l9YDNNz8FMt3+6PXUIXTMTRtDN7BgV3rfLE8QMlc7pzQhs8Ws9PK1D
   eIzOoycl0vZPMzOqBPPvKZmt9cREGR9U3Ges/dIzZHiueeZw8YBn3d7d1
   4bd9IKUFCTZnVsJuae6uncSqiWdjYtf2YXUynn9gs6xeJnHcv2CWSanDk
   er86bYsKjIFYrwyYyppI5kyNhKbRi+BLsIF1/9eJT0M/uo0jjJw9eBPzL
   KQaZjI5KMt6it511k4GO1hGLE+F8g9W0RTaVia01HiDPU5adFQAsRmmpF
   KRKGaWXxFpbCa5qyeCbB3OEN0GMfvQiP6J1677T6QYDat7n/mebCqB794
   A==;
X-CSE-ConnectionGUID: DBVFNXGDRLqgbpXFS6Kjzw==
X-CSE-MsgGUID: 62S+Cw1bTeWQPm2S4dsTcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="34190678"
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="34190678"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 11:35:30 -0700
X-CSE-ConnectionGUID: yq4uDVtxQWGP4f4TdBYCxw==
X-CSE-MsgGUID: hIgP5Z4JSeG3T0k09oDBDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="82719238"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Nov 2024 11:35:30 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Nov 2024 11:35:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 1 Nov 2024 11:35:29 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 11:35:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dkWkwWlYI97w1+eFm9zZjB4A5uQZkA+1X0n6Uk5TDteKBqoPknk94+0aQDIhIUf7ZIEFOxvV+OqDqgRuKUxvlBfoMvo2uvBRMcQHY0J1BbEv3Eq2L/tL/sV5N/yk4z27FnCtWMsyRxQTcpTg2yGumMc6cC7TXx2GgVuV4om5E+HV+8698R0IcbFQaXt8urPH5Ok4+JSAxI0LbXSLCHt8+6L7m0vju92Tg8ReQPRAAbIFw+F4yCZDW91y508hMAgAntyPVaZQpheAqB48Xdv8Qfpe3vLaSRcUiLnh/tdGxiaQKYyXzSPaqweGM6SJK9SlvwIRGcYkAiQjREUUztGJ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jp3YNSrirqCr3KQvrWfknPrIatOLTHjWnG8l85pWPBc=;
 b=eRLGMrwvBNZ3CsqfswQS8M1dS0yxkguOPf2+tKOerH9/t4ZTaAa9MkAZS5T6fKlTbewJ1BeCiuIA7u8I+gNy7KmBIxYMgKq0VkdKU1jlDoAYcEg9visOSOjkP611i5If0MT8omdVEZYFyMNU66tdBPiRll42K4hm9zPfHxOm+QbBwgx8If9Nj4uQG+Z4TQLa5iCDkvsbQsJ9NDeGfC/n8CbKbuo+eZpQA4uBusf+WebWWOvHT4HfzgC7WQny6ZlbGRPcO1CSGeYAU7IQsblyIQuDkp08NebEk+AU1GiyZ0v5eZzZOGqZsXfMhzcgYroZZg1eewuce1O6aZqWkk1eIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CO1PR11MB4961.namprd11.prod.outlook.com (2603:10b6:303:93::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.26; Fri, 1 Nov
 2024 18:35:25 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%3]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 18:35:25 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Peter Newman <peternewman@google.com>, "Yu, Fenghua"
	<fenghua.yu@intel.com>, "Chatre, Reinette" <reinette.chatre@intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, "Babu
 Moger" <babu.moger@amd.com>, James Morse <james.morse@arm.com>, "Martin
 Kletzander" <nert.pinx@gmail.com>, Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Eranian,
 Stephane" <eranian@google.com>
Subject: RE: [PATCH 2/2] x86/resctrl: Don't workqueue local event counter
 reads
Thread-Topic: [PATCH 2/2] x86/resctrl: Don't workqueue local event counter
 reads
Thread-Index: AQHbK6DbACO0R1VGa0C5nUIcf/5WR7KiwaBg
Date: Fri, 1 Nov 2024 18:35:25 +0000
Message-ID: <SJ1PR11MB6083EA70CB81A8E9B602F3BCFC562@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20241031142553.3963058-1-peternewman@google.com>
 <20241031142553.3963058-2-peternewman@google.com>
In-Reply-To: <20241031142553.3963058-2-peternewman@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CO1PR11MB4961:EE_
x-ms-office365-filtering-correlation-id: ad8881ce-0e4d-40e9-92a1-08dcfaa3f3c2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M0MrMXZwb280Y3JoT2F4WDJhSzJXaXRDclJzQlh2KzByWEVPazNtUkROdWNM?=
 =?utf-8?B?REVmYUc4RUFJRjlMYmpxYWF1OVp2L2JFaFFYUHlDUTBIeDYxcWdZbTFvNUNp?=
 =?utf-8?B?bVoxa3d6Z0ZVVm5ybmVSdSt6UlhMSDJDM1NjU2RSR29uNXhhc05OMWxqZWFZ?=
 =?utf-8?B?ekRpYlVHZGlVeWxsdjZndG50bE5yeVpHc1pKbW1wcjdUMnFhNHhJclBBVGRo?=
 =?utf-8?B?blIrVm00cHFLQTkvaG1CTWc1UHNVa3ZPeXdjRk9IaTJ0QVIvbVFlZ092aStm?=
 =?utf-8?B?TFJGalNXUm1vQkh4RXYrTG9VTTZUaFRqR0xPTkdCcVJFTWNZYVVEbTUzTmNk?=
 =?utf-8?B?bFRBc3JoTXQydFhRcnhwSHo4c0RmVVd5MmR2Ymc4Q3EzQUFxWFJjdXNqVm9M?=
 =?utf-8?B?ejcvZElkQ2R5cnRXTElZSExOZHpDbU1HTEF1d21sYUlJTEU0SDlzM2VDWHVZ?=
 =?utf-8?B?b1NpZzl5M3RFb1c1TytFSHVPdVdUVCt3WDlSMjd0WmdlcEdsVytKRUR0VmpV?=
 =?utf-8?B?Tldrd28rQmJLL1E4cHZRS3pEWUovQ1ZmMkpucjUyUG9ubGNlSjZGa2lSZHlj?=
 =?utf-8?B?cUhOV2R2Z3hXdHZFV2JyY29ZMW5GTzc0UHZ2R1hEdEVjMC8xS1Y4NTF3WDNP?=
 =?utf-8?B?Rjg5emoyZEtxNGxac3YyVTRTKzF2R2l4VVAxYzVLeFdieG4rVUVDQWZ2UHRx?=
 =?utf-8?B?VW0zaHZVT1lSaEh3WW56L2xJa3YwU3hNRkFFVTQ3KzRsK0dWZy9FM3BMcC9M?=
 =?utf-8?B?Y2ljTGh0NWJqcVM0U0M1Wnl3S0JFNnQvQTBEeHNndnFnOU4xeThINkNnOUJn?=
 =?utf-8?B?RTEzU0pDZ0VhSVF4ZXNLaUhjSktxekpFZzQ2aE0rK3dCcjg4SmY2cFNCbnBo?=
 =?utf-8?B?VjR4MUpoTGxCVzJ2bks3dUZYS3Y4RzlMQTNHcUpaTEpLRWNZTURmZHhKanVI?=
 =?utf-8?B?cHlYeW5MTXBHQ096R0xwWlYzeEs2dmIwM0xwclhMai9UdVR3ZEk5WjNmNnZt?=
 =?utf-8?B?VTBWeXFsMENhMlBnRWtncDk3SlVjNHRsTldaUW0wNE51WFRIeFMrVDdOeFoz?=
 =?utf-8?B?eHdtQkRaOWdJd0lkeXVGM0tCc2MzcjMycTI1c1BIUmthV3NzNXJyQXdaM21Y?=
 =?utf-8?B?cXVEN3ZKOThmWTNBQkJNNUNlSmxlVklFaEZqbkNWcnBWTGgydEdkajN4SHd6?=
 =?utf-8?B?UTc4b3d0V3BrQlpOcXR0bVE2eUVkeGdHdEpCWEtHaUhtOUllemNBalBYMHpU?=
 =?utf-8?B?azRDNXdwTHQ4am9LemI3SkNhNlhBMGJ2OXFZcDBaQ0ZVNWtqYXRCbXVhZkcz?=
 =?utf-8?B?WWFBc291Y2NMQk1INFFGQkI2RUlpRXNydmNxRlZaZnU5MHhPMDFSVHlWN3Fz?=
 =?utf-8?B?Rk1McnVxWHpaVVB3WFBiY1IrY0lHM2hUbWc5dEFlWEF0MHptNzFJU0hQVjBw?=
 =?utf-8?B?QzhQRS9UaTRrTEs3aG1YUEdyUDZSc2hlSnhZRTNSU2F3dzhPYkdNK1dhdWJ4?=
 =?utf-8?B?ZkVwWkVKaDVaa3A4bDZxWTkyd1RIZE13Tk1KSnhhaGkxWU45QnFMeXZvaG0r?=
 =?utf-8?B?TDliYjZCOUlRTWZiY1YwYkd4cUFMRmV0bkxsaXhNRXNncXkxRHRUdG9EK2pn?=
 =?utf-8?B?Y1BZdmpjNGtteVQ0b2VWa3JCQm5ka2NXU3kwUWZMTTMvbEcxSTk2ODZyYWxC?=
 =?utf-8?B?RkxxcmZKK3lzOVdSZVdFTktWNXViOGtPNnNzOEpkRy8vbjRReEVnM2JGMU4r?=
 =?utf-8?B?SjUyRnRaVzd0d2JNdHBaNjRKWUxDcEM4clFWN2JnMTBickpXMHBrQjZkY3or?=
 =?utf-8?Q?wmG+Bh5+W+ZIsSY0vUXitbFuT8+upSWbq7mX8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1hPaXNnaG9BZngrQVFQSmJySE5IMHpNK3dEYTUzOE9WbTVrdG1KN21GWEZ3?=
 =?utf-8?B?NFhYWFI1ZDBLSDh1R0JUOGpKdHBJalhmSHNNZitQdGpQSVZMY1IxT2hLa3BZ?=
 =?utf-8?B?TWE3VVA5RmRpS2xoVFlPdjZ5Y1ZzRFN4clBVbGNVQThKOFBMQUdPNk9BQkxa?=
 =?utf-8?B?cUJ5K0xKRGpXUVRWZnY0MGhueU9jdC9TS2RweUZKUGlUOUNNWXRLUDY5MjdW?=
 =?utf-8?B?eGYyeDkyTHB0UHlBMEdzUDYwczQzSWZWRFBSMzJEbG9jc1lsSnVsNW03Q2Zz?=
 =?utf-8?B?cmdFVmZyU0NFbUtlYzg1a0FiMW9QbHRvb1l4Qk0zTXlTZmF2MzVNeHJnM3Vv?=
 =?utf-8?B?QVRDTTlDaDYzNzVlOGQxUGtUendjWHBOcUxYYWxiZ1I3aXVmbG9xeWFRbHNp?=
 =?utf-8?B?WlVkSmJVUVZUa0lnejIyVW5uV0xEa2JoYktSQ0syaUlVSGxnajQvbWgyblkv?=
 =?utf-8?B?MjNuZ1BnZ2MwVXdDQktrYmlvMzRBeElLSHAxZUNERlhDRkJzRXZiL0ZEb2hY?=
 =?utf-8?B?WGVaZ0VUODJRQXVMQkxVU0trR2NwSTRDeVVSZ3VUcmhtSms2WVY1UUdpODdp?=
 =?utf-8?B?TmEvN2FnZldCaGRQdStsOW1WMGZjdEZ2YlN0WWJPSElFMkdIenFodlIxK1Yr?=
 =?utf-8?B?N1NMTGpPUGxnZ2NBNFVxRnd4WUdvTkxSNlpoSlI4T0pIeUlCL2UvYVQ2UjRM?=
 =?utf-8?B?cHB1NlBsYXAyNlpPblJWNHg0UXZuZHF6eldmUmNoU0YrZy8rSDF0S1hzdXRU?=
 =?utf-8?B?Y3ZIV0lhUXZxeUFWU0czcXZxbCtCMHN6eGpmU2ZYMjAvK0Z0ckNjVk43S2dN?=
 =?utf-8?B?Q0ZXN2xrZTBjejd6R2IydnBTMXl3T2pXSTZGODh4YnlQZUU0K202eFlIQTFI?=
 =?utf-8?B?b2hFbHcxTC81YzRSRFF6bURoU09HdXRRWG54eCtHblR1aktyZE4zSjNqbkxQ?=
 =?utf-8?B?R0dlVXZyNVl6LzBqMGJIMFZzYjZIbExNRzkvcjVYMllNZm1UZ3IzRGN6dmFq?=
 =?utf-8?B?cTdwM096Yk5FeXJyRnMvaXF2a3JicnA1bnV0ZE05eFl1TUJBN0NVUVJTRXEv?=
 =?utf-8?B?VzV6K1Y0QUxlVjNtbDJNbW9ZVVdub2ZiV3BPenArbGdWSnVqVkpPQzNxNmdW?=
 =?utf-8?B?ZzVxRFFDU3IvQ2IxbVNhUVNZT0V6UG94YUM5Y1hDQTUrdzZzNzlHVGREMDhk?=
 =?utf-8?B?MlJ5SkJHZno2RSsyOEVMSnZtWWw4bk9qS1FDV3lxU1ArN1hFdnNoK2phMVRx?=
 =?utf-8?B?Q0F3RWwzWkFqMWU4T1E3L2c0OU1xV2NlekkxWkVOMG5XbTcwRlFzc0VadUN6?=
 =?utf-8?B?M0Q1RjRuRjFYNEp6ZUI1VFpZR0JvdWJXRWRBNENoNlNDYTdFZytGeXFSbTlY?=
 =?utf-8?B?MHR6S0NSNFdvcUt0R1IwT2ZHZ0cxREtXVXdQK1F6cVlSak8xdkNmMWp5L3Vh?=
 =?utf-8?B?bGFFT0E1aUFMSExZZmxMUGVILzhhWFhHSDdHcW5NZWdDNEw2d05EMzhhTFd6?=
 =?utf-8?B?Y1doMFp5eEViR012Z3paYk1ONzVDdTBZOERDRDRrck4xQW03UXhWV2xmaGVo?=
 =?utf-8?B?bWR3VytaeG9GYTZGR1Nqc1NlSVd1WkwwVTQ3bFZqMkdlOHpWWDV4NTBzOVlL?=
 =?utf-8?B?TU5pVnUwclB0Z2J2Y1p6bEpNbzNHY1lLbGFTTjRYbW5aRXFoUWpzMUNrNngr?=
 =?utf-8?B?U3hQNkorOFRUbk1kVkphTVZyZWVRR3pWUG1jaDRNa3Q5aFhrTGlCZ3l0UVJr?=
 =?utf-8?B?ZjJBSjZ0S2RKSXJsellzZzN1ZzF3bUxhbEkrNVdWWk8xNGhXL2J0V3JQYS9O?=
 =?utf-8?B?cnFnM0dLeVVxTG5BeTUwVkZCZDFsNnVZQ04zbk1jMGpFSUdFWG5FSnNTc0pH?=
 =?utf-8?B?MUlsdzk5bmZSa0JFV0FqSFgwM2ZVMFBOZStaMW5abmkxTjJRZmRKOUdmT3Rv?=
 =?utf-8?B?Y2FzSmZlRzF3cDVWTFljZE1xZGUvbmFmMG81amNicmt1dll5Z3RSYmtCdFBk?=
 =?utf-8?B?VGZqN3pJcDB5MVdubU4xK1MxTjBuOFdxRE5vbU1FTWVNZ1R5b1ZhZ0N0ZFlR?=
 =?utf-8?B?Vis2MVNpT3FHVElnOHk2eW13aE85dkMwZnJPZGdJck5QY2tNUlJqTDIrdmxi?=
 =?utf-8?Q?dwBa3G54TdZt6CFf7JJg+PP5D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8881ce-0e4d-40e9-92a1-08dcfaa3f3c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 18:35:25.5663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XT6OARMd8k3mXxCZiVm/lRjHaF3SjPeAV+deeXDDcktPNT4EqVQgyPuJvwNy0qCKhErP2i1xnA7HSQH1ef3S1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4961
X-OriginatorOrg: intel.com

PiAgQWRkIGEgZmFzdC1wYXRoIHRvIGVuc3VyZSB0aGF0IHJlcXVlc3RzIGJvdW5kIHRvIHdpdGhp
biB0aGUgbW9uaXRvcmluZw0KPiBkb21haW4gYXJlIHJlYWQgdXNpbmcgYSBzaW1wbGUgZnVuY3Rp
b24gY2FsbCBpbnRvIG1vbl9ldmVudF9jb3VudCgpDQo+IHJlZ2FyZGxlc3Mgb2Ygd2hldGhlciBh
bGwgQ1BVcyBpbiB0aGUgdGFyZ2V0IGRvbWFpbiBhcmUgdXNpbmcgbm9oel9mdWxsLg0KLi4uDQo+
IEZpeGVzOiAwOTkwOWUwOTgxMTMgKCJ4ODYvcmVzY3RybDogUXVldWUgbW9uX2V2ZW50X3JlYWQo
KSBpbnN0ZWFkIG9mIHNlbmRpbmcgYW4gSVBJIikNCj4NCj4gU2lnbmVkLW9mZi1ieTogUGV0ZXIg
TmV3bWFuIDxwZXRlcm5ld21hbkBnb29nbGUuY29tPg0KDQpSZXZpZXdlZC1ieTogVG9ueSBMdWNr
IDx0b255Lmx1Y2tAaW50ZWwuY29tPg0KDQotVG9ueQ0K

