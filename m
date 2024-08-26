Return-Path: <linux-kernel+bounces-301105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AED995EC6A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791FF1F21114
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C31413D532;
	Mon, 26 Aug 2024 08:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FrNDk+7V"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A7982D7F
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724662416; cv=fail; b=sFDbQWD3dIjQ3C0QxhYvih39TnwpmHsrL6ZhhBnkYA5LkzH1JdKUM/2ZmjOqOiMVO7V3/PS3/hgFesak2hGTTtNGeFw/2fqJp2lkrxCGFZNqea2/AzUK6LD0WA6fIofI4wi6YWIcJhlwLSDFNC4Ap3eZi6N4hS1XNN8g+obH8jE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724662416; c=relaxed/simple;
	bh=urZUbm0bDjr/G6Fob6J1Dwc36IcicB0ggGi6TToPBdU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=owbztGSZPQ1Z6vMyuz/jkX6iNffauj+/k6bIYMzON0mp0j1z0udSpr5/KooyfZSePh+MRZAJ1L2qUJVDr2+gYPjLTz6c6HffFYddEewTcdpDgu3B07XEsFtIs5c62CfdPRcb3ggSEtmIhr5CdcuxlZvaewF8PMIwxK5wz08CPIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FrNDk+7V; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724662414; x=1756198414;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=urZUbm0bDjr/G6Fob6J1Dwc36IcicB0ggGi6TToPBdU=;
  b=FrNDk+7Vr3Rw/58y/Txwk2uJTYJF8xixgqmjP/8ytnhbK3asVs2qUKST
   pJrUID7HBUHDWRKEPbs108araYjXSROuptSBNvkh9WBa/VR8+7dMjvuwq
   11kk5/D42Gc6UNa3WWaVHYptofbt58jJWHWUr3G5UiMywGadV007P0D56
   U0rhioT1I7hv3dXU27iHVylnhFGGcOZNTTwDsd+6SuouaqJwrp3jBSzpI
   S6IrLV7h5qTrCdBcu7sT/VKALrVcujrEi3dPwO3VTBVDR24hzDMFUufE9
   Qm0mIX4za78oB2Hj8psJ9oodzrEyO5IBV8VbGb+x0DIThsuCUT8sZivh1
   g==;
X-CSE-ConnectionGUID: P11Piku/SNquAx1WUBA1gA==
X-CSE-MsgGUID: c5M48z9KQIWx/a1TMhffGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="33691761"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="33691761"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 01:53:34 -0700
X-CSE-ConnectionGUID: miGpJUIFRvOcHq+xPu7mrg==
X-CSE-MsgGUID: UguGFzUYQoSl0+74dMprgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="93245250"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Aug 2024 01:53:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 26 Aug 2024 01:53:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 26 Aug 2024 01:53:33 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 Aug 2024 01:53:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IxhyqIF7p+BvPzbzfCgLyGLB9AMU6u/5mSlfranUkaocvWgzGrToZN0wNejRyMkNiKnxI2gIGEk8ngsMtDSTD8PfB7iteaZL+HiKaQJe02jr35JwYAs7bbaQAYYoTk8hZzs4KzXy2S1r19ks0pOL2kD9z2P6YVQIhJ0K4nVdgAdI+ABQvg4KeW3TIfyi/sK7wXFj7jCAb1ahKxZv3EvUCXzGWTe5C5Lzd2ZU3y7WYwlssDqMn33TgXtK8I1lmU6YMMgX9CoVkiKDH2cEOBtdQJh72cTtdB6whQKZRaEMNHFGEcQPRm0O+NqTP91+ffOGUjOohpxjOaUpugFL+izDlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dt0yEhVV7qQ2AqfQJDxPaPqCXepXidw/FsEVgbfqGYo=;
 b=o9tpdHn8fqIIDv75dvJdxt9dOwbGoqeMZOjbmp5UhxRz9he0P5GMrpS/9Ob1av6iz5UZR2NGx7Z+9bvzYLM2FI6yYfj5meSHe9MhE5pQ7H+DXceVeTwy2U9kOQMmHh6vGZZCIUolnxgV9wgFtDAXSccd5AKrVe5c1zRdxsKb7/n2Wf8FtFRsEf/teixJTw+CUxzulcsLoTZFaws3KE9zZItY0rAelHUPk7g5ui1O2baA588XdTX9JZ3xFZFHOyvklret6LD0lhaeNA+WVDTo/2ILr4c6Pf0JE69jWyw3cCcaoN64mqmv3bMDgau3Db5OOCMqSxxs16UDTqETffOo4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH7PR11MB6907.namprd11.prod.outlook.com (2603:10b6:510:203::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Mon, 26 Aug
 2024 08:53:30 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 08:53:29 +0000
Message-ID: <1ea4522b-6e7a-4a34-be88-cb70055e959c@intel.com>
Date: Mon, 26 Aug 2024 10:53:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: WARNING: [xtensa] modpost: vmlinux: section mismatch in
 reference: ice_adv_lnk_speed_maps+0x14 (section: .data) ->
 __setup_str_initcall_blacklist (section: .init.rodata)
To: Max Filippov <jcmvbkbc@gmail.com>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Pawel Chmielewski
	<pawel.chmielewski@intel.com>, Jacob Keller <jacob.e.keller@intel.com>, "Paul
 Greenwalt" <paul.greenwalt@intel.com>, Simon Horman <horms@kernel.org>, "Tony
 Nguyen" <anthony.l.nguyen@intel.com>
References: <202408220755.LlaA10C6-lkp@intel.com>
 <3ba6caea-654e-4dcd-a4a4-bfdcf808f0e5@intel.com>
 <CAMo8BfJOPNaHb0f3Rf2GyhApCDg5bFfCGETWU9-LBJWiJpLeFw@mail.gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <CAMo8BfJOPNaHb0f3Rf2GyhApCDg5bFfCGETWU9-LBJWiJpLeFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0419.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:83::16) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH7PR11MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: fb8f354c-6efc-4efa-5c5f-08dcc5ac8e6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rm5lTEhyVzlyZm83KzRFYXEycTJDdzhiREZLM083TVpUMjBSa2R3YkFIYktt?=
 =?utf-8?B?UTJTOTdOZFBhbStxamlMZEZoNXlhbWljZWM5aDBVWGhVeWRodUZ5NDVZOEta?=
 =?utf-8?B?eUtneWdsRmhhV1kxN1JBbmtVWTRzd0QvejVyMTNIVXhMbmdDc2wvN2pvYkFQ?=
 =?utf-8?B?NXgwb1Z6RWJ2QmMyYytEL0ZSUVdkQktrcFg2U0t2N1d6a2oxYUZ2ZU1RSjha?=
 =?utf-8?B?SElhbTBJUVZmT0RsdE81M1VYR3RwTTgvYVhyWFJjN2p5YzlGNitWd0RZN0JJ?=
 =?utf-8?B?dk9MRmwyeWczQm95Tjl2SnpDOWE5RDUvL2Fsd2VXakJ6RzZhTWJjUC9rUDVI?=
 =?utf-8?B?VnBWVHBFditrc0VDYVFYc0h5VUlscnN2UUc3K3pvQzV6Rlo2Njh4aFg0dmZl?=
 =?utf-8?B?cHVFVWY5SnEwMGh6MVl4L3hDRlJlLzd0M04zcjBnMGxXOFh5WVhWQkZZRk9F?=
 =?utf-8?B?MG5OZlJLMmFKVTljQ00wMHBqSmFGcXhYeUNGOFBSdkkvQVRwZ2JYNTcweFlz?=
 =?utf-8?B?dUs4RDhLNmp3UkpURUdZa0tYR25ielMrK2I5c0Nkdm5BM0JZUjhBK1VDK2ZU?=
 =?utf-8?B?MDhHOC9HQnljVTNoaDd4MElZWjNBRllITEJKaEgvTzUxSStqQmVldVczTERp?=
 =?utf-8?B?bHljbjcyNlBMMkF6cjZzeHpZbDI2N2dOV3dPb3d0N3oyaEs4VXJxUDRtb3Jw?=
 =?utf-8?B?OTExcGpsS0NVMUxEY25LalV5blg4TUprMWJXNDRzNElEdWY0N2JUbkNwNW5x?=
 =?utf-8?B?VVhINDVKQms3dTJuNHg3L0ZHTHJQK1pUMzRkaHZreTNqWHdUMTJpVDFobDJM?=
 =?utf-8?B?Kys5SG10QVg1RHFXQlVqM0h3OXJKYkdFTUhzenNzY3VDZWFYUjVPOWE1OHh0?=
 =?utf-8?B?cXdlamlDQkl1YWlsTlpPajlTSVlkMFZhL1B3RnprdXlrT0RpZlRvYm5sczVG?=
 =?utf-8?B?MWN3S3FBTlFhekM3cVEyVlg1TEgzZnF5U0FTZVp3bkFkaUNIbndsTmZDaEQ3?=
 =?utf-8?B?NnVxTUFPWkloRkdGQjNjSUx2RHVQMmU3aXJJK2UxSFBlL1YyQmxXRk9wZTVv?=
 =?utf-8?B?Ynd2V0JsRmREcS9TK1lNNU9tOEsrUzJ3WFFwbEZ5YjhiRDQyMjRyS3Vodk5v?=
 =?utf-8?B?d3ppSWRIWFFOVnEvZW0rREloY1AwTHpuSWlmdzJ1NCtMYWk2d3NoVGZuQS9K?=
 =?utf-8?B?WnRSMXFTZDEzeTIwRkJIMU9CZG9hbVhaT3ZrdWNJRS9nTkcxYWxGL0MzVUxk?=
 =?utf-8?B?ZnhVWU1HSlBWUnR4S2UwaEk0V0JZZ1lEWGRIZG9pVm8rUkJxUWZDNTRwNC9G?=
 =?utf-8?B?SFR4Nk82Mzg3MmdwMExhS1J2UnNWZUJSRjNqWnlJOW55cXlabTBrdHZEYlhl?=
 =?utf-8?B?Z3FmTStUaUMwTTFBT1Rwd1N1NkgvN1pGK29zL2tJV1d1aElicUFLY2x4OU1R?=
 =?utf-8?B?dnVkNm1rNExSZWRBWmhySTY1YXVXU0k5QndydzM2Q0NtZmpXMzJORk5LeVMz?=
 =?utf-8?B?RldYUlk0NzVuUzFDYzV5bmFZOWlQOW1lZE1STGs1Um42UG5LVitvU1o0R3Ja?=
 =?utf-8?B?NXlwR0tiU3lQWWlOQTlnU0l6L3NoVXVhc2tpM1BGeTBBQ1YzclArVW0zaitX?=
 =?utf-8?B?V1pmdU5JQVdYRFJTL3A4KzZoK01lbmFUdXFTbE5uTG1ycnNDaGszaWxkSWpX?=
 =?utf-8?B?eXR2MkdqK0dGNVpsVVdMeG9HeWxPR3kwdjVRNVhZSFRnUjZBeFIxUzVHZVp5?=
 =?utf-8?B?SERDK1FER3FCQUNlK3N3ZHlzaDY2b2NzRlpLVE55L2xxaHpkd0MrY3RyMjdn?=
 =?utf-8?B?L0hhU0IzTjFXSHhOTWVKZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGp2VGkrOTJTWDZHRFlVRFVKNmJwUG93OXR4TllKQUhZUEJQeGNXK05XRVR6?=
 =?utf-8?B?TmNiSDViSnhUL1FIMjBBTExrOXBCYzR3U0Jnd2VaWllWL1JmVUpVMWVCcUt4?=
 =?utf-8?B?REVrMDlNcW8xdTh6YmJXb2R3R0dYbUI3cjFOU0crbGZJdy9xSFVCSTJZSFM4?=
 =?utf-8?B?Z2g1a3R3REs5MHFkRGFyenZPTlUzVnJ0QlZFOURaQk00VUJJQ1dxUFlQQy9F?=
 =?utf-8?B?c1ZiTGF3UEExYkxtTHg1dGUrN0lHTXEwKzl2c2VJNHJVRTFLcnl1QnNqT2FU?=
 =?utf-8?B?a1pCOHB4MWYvVkpPVURqUEwxSC81NkJ3dFpNZnJBY3pzUk04UWhGQklMRmwy?=
 =?utf-8?B?bzhWWXJ0UCt5aFZEV0lKQUNnR3VSNWVaY3FQNlRGZjBadUpSazFvbnhJWXJ3?=
 =?utf-8?B?T0F0ZkF3V01ROXJUakIyV3ZzNU05ZTM2ZWRxaXp5UXF6bXkxL04vSm9wKzhF?=
 =?utf-8?B?amp4R2NDV25semF1c3NmQjMvQ045YmhHa1MxOGZ6Mm1JUWdxUGNIcS9IbzFW?=
 =?utf-8?B?ZnZXZ096R3ZNYmkxc2VvNnVxYWNTdHhDT0NFRE5IQTVkSEtEaFVUcXJhN1NV?=
 =?utf-8?B?ZFFiLzJQMHZjQWFyMCtUWEtmRzF0VThLYjU1YWY5ckRMS25vc0xwQjkvTnll?=
 =?utf-8?B?cTdURjhpN1lzQWVIRFBFVFVYQmhmb0xWUDg0OG9semd4NHgzQmdLT1k1NDlv?=
 =?utf-8?B?dlZBQnJxUEV5NFNIcVpPaXhudi9URmZHVUI4N2RjUGhmR3FiOU00Z1E1bUg0?=
 =?utf-8?B?Q2N3bzFML216TElUalluUm5TWkpva2JsQVlieDZ4OWIyVG44K01WNTU4aU5B?=
 =?utf-8?B?SFRqVVZUUzkvY0daazJnNVdsc0VIQXZXNXVUTFpnTDhTQzF1TnBtMHRqQlY0?=
 =?utf-8?B?dktJdkRNd2o4Y2JWbmY5R2FZTDhDRnpZOGQ0eXZGWEJteFlRQWlHbDhKbStX?=
 =?utf-8?B?R1Y4VDdwMkp1Y2xkejg0alNMNWl2RXRzcEEwS3FxNCtpYW13ZjZ5YkxhTS80?=
 =?utf-8?B?R3VwaEcxai9iYWM1ZHh5OWNCc21FcWwvV1p4L3RaellpeDArOEU1cm11SVVk?=
 =?utf-8?B?QVAzWGNFK1pVWEZEMFhOZE5mUVEvUmN2cFlITGJ3OE5ZTEZHeXcxZ2NUcXZk?=
 =?utf-8?B?cEV0emIxa3R1dzVJZEFHcy9UU2FHQW9ycnRVVkZSd3RmNC8zK1RSYkd6SVVC?=
 =?utf-8?B?VG8yYnJUeHpXLzUybXkwZ3E1dm9ZMThmdTF1RlphbFFnMDNpYysvUXh2SE92?=
 =?utf-8?B?WVkvYUdVQmlxaEFsUFdwenliYzAwb2RuWmQxdkVIc1NhMFlqQTlEOGM4RWRY?=
 =?utf-8?B?RjBOdmtkSU9tVEV5NGRjVTNUbHJ6Uk1yU3ppYzk1UEFzSzF4MVZKRndJbUpD?=
 =?utf-8?B?a0R6bWt3UGFkTG95ZDJyU1RyRnlVSGhnUm45aEF6Ky9LUDIxeG9lTEhMWlNp?=
 =?utf-8?B?bWRaak5DdjR0Ui9qeUw1ZGhGaDNrZjVkbGNqSE0xMGs0YlJod2VCOEVtdWlv?=
 =?utf-8?B?dVZxUnZGU1oreHA4L1pzQkZPOW4yaG1XRTBpVXJLeWp2MDJqU1NiYld3MnJ1?=
 =?utf-8?B?T1JoT1h2cFhpWUsrNFlsenFUalpMT1VIdVBPNzFXSExVSmRPYmlLYW0zNHhB?=
 =?utf-8?B?eGh3Z3JBSlMzWFU3OHgybCsySUtSa0p1TXVCUUszUVErY3JUaGZsYU5heUJ2?=
 =?utf-8?B?UDVtNGhXTWhJd09VLzV4YkM0YVB4ZjBRNkhGNHJlOEJFVjk1YVEzU1FYRkZk?=
 =?utf-8?B?a081OURsNmVIYUxKTitxbTVvbGFuRng2VUJiWk9yMjVqb2NqNzFoS2pOTzN5?=
 =?utf-8?B?OGxGbG44b0N6dEZnTURTT2FERWQyR2wzYlJaNWY3c2U1V1lGMEYva3JtTWxu?=
 =?utf-8?B?VFg1Y0hXQW85aWZWL0owVExINGRHQlBoSE9wUm1nNlBXM0F1Z1NWc3FZcW5r?=
 =?utf-8?B?QU9SS1Z2dWJYWVdQNUo4WlB3MjZ1YjlxbTlzVHM1ajN0b2MvZDF2bzRRL2JI?=
 =?utf-8?B?ZVVBMTNlaGhXVlY0WDJDWEw3Tk43WXhPMWVodzdBa0ZjakhiRjhMelpDejNa?=
 =?utf-8?B?NC9ZK1Z0cEd0eFJJN3lBRTRNYy9NeHBlRk5oUUdseUkrb3psdEliWlIveGJx?=
 =?utf-8?B?eldVakZLSHcyVG9YSnYxdGhGenlnTWU2OXk1Wk1rS0ZLRVhpSzFCc1Z2RFVV?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8f354c-6efc-4efa-5c5f-08dcc5ac8e6f
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 08:53:29.5390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WqrxQJQzqwv5ByFGBfdZ6g8IJ51+H5HHED3OrrgUBUi96PiPvmTJok/DkIUh0O7FJD1kcUw+7IMEEBsHPWWUBKuibckOWFTTqClb8NyuBPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6907
X-OriginatorOrg: intel.com

On 8/24/24 08:41, Max Filippov wrote:
> Hi Przemek,
> 
> On Thu, Aug 22, 2024 at 1:23 AM Przemek Kitszel
> <przemyslaw.kitszel@intel.com> wrote:
>>> WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
>>> WARNING: modpost: vmlinux: section mismatch in reference: put_page+0x78 (section: .text.unlikely) -> initcall_level_names (section: .init.data)
>>>>> WARNING: modpost: vmlinux: section mismatch in reference: ice_adv_lnk_speed_maps+0x14 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
>>
>> I have spent just half of hour on that and I'm clueless.
>>
>> For reference, the driver code is:
>>          static const u32 arr_name[] __initconst = {
>>                  SOME_CONST,
>>          };
>> and core kernel has:
>>          #define __initconst __section(.init.rodata)
>>
>>
>> @Max Filippov, you have authored much of xtensa arch for kernel,
>> especially XIP support, and touched .init.rodata back then;
>> perhaps you have any idea what is going here?
> 
> I see the following:
> 
> static struct ethtool_forced_speed_map ice_adv_lnk_speed_maps[]
> __ro_after_init = {
>         ETHTOOL_FORCED_SPEED_MAP(ice_adv_lnk_speed, 100),
> 
> that array goes into the .data, but ETHTOOL_FORCED_SPEED_MAP
> expands to the following:
> 
> #define ETHTOOL_FORCED_SPEED_MAP(prefix, value)                         \
> {                                                                       \
>         .speed          = SPEED_##value,                                \
>         .cap_arr        = prefix##_##value,                             \
>         .arr_size       = ARRAY_SIZE(prefix##_##value),                 \
> }
> 
> so the first entry of that array quoted above above gets the following
> initializer:
> 
>    .cap_arr = ice_adv_lnk_speed_100,
> 
> and ice_adv_lnk_speed_100 is defined as
> 
>    static const u32 ice_adv_lnk_speed_100[] __initconst = {
> 
> so this array goes into .init.rodata.
> That's a reference from .data to .init.rodata that upsets the modpost checker.
> I see that modpost incorrectly deduces where this link points (it's
> ice_adv_lnk_speed_*, not __setup_str_initcall_blacklist).
> I also see that this link is not used after the init phase, so it's harmless.
> 

Thank you very much for the analysis :)

