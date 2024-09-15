Return-Path: <linux-kernel+bounces-329678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015E49794A3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 06:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 388D0B22681
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 04:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D11F171AA;
	Sun, 15 Sep 2024 04:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PVqW+aES"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE93F1B85CD
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 04:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726376052; cv=fail; b=jRJIHUQ2C5p1WPwIKtOtSHmrDx0PRonhoMhOiWoXgZPi0vL6ycIeF5xA6cZoPDxKg2LPiPkr6kN0P9F13N1H/n+xX7K407aFoq0bBgHLet8+X067daN5Bkk++Ou7Syl7mKXV63VELAUG0Bi5Of9c3sJRzeCbVEK6wrq66x0jn1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726376052; c=relaxed/simple;
	bh=EWEInMR84ZEgAjK+BcPhD46RUiszHUOm32LtFcustec=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wx4X1umcETNbULvmo44clRkfilnLtRF7U0aYi0db9BkuCca8/eUUCFuDHnL+myEmEh0V9J5iwP68wkHyrVqG5rNNwgwW4cfhKSQtFVbVV4nagVy1707TAntgNvp1eCL+65pSgbHoqAttapGSRDMyS8z+s6ZfIxttnFry3Mnkhdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PVqW+aES; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726376051; x=1757912051;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EWEInMR84ZEgAjK+BcPhD46RUiszHUOm32LtFcustec=;
  b=PVqW+aEShdUMjg0hjfeUE2n3Smann4E5Q/ROFvg1zNhekqGyLlEg72og
   RoEzW5+ldtOVx/qFlTZEa7ln/HyLUP5RL1xLa72/VFG8ZApJuEZTKKHTn
   86hWvUbHy5zv7iXdG9/plWxKyAWkSGHsxE7E0Hl3SQIlGU5NTEPC1IX+a
   bOVnHJJbx2J/VjUgVoIHWvjH9dD6HJOr3Z40EkoNldjtdRfeiUlTtGcIT
   E3pHkdVNAUPcJrsb5v7dOj/SBol70WIcSh+18Bag9o0oUoy1OBhnOv03k
   MLXTs0ONmLJc+ctq75regkpfGN7AMxhgGSI4dhq2b99L9pmbh6fKoOGPf
   Q==;
X-CSE-ConnectionGUID: +5kjcvXnQEWzt/Ye4vgdvg==
X-CSE-MsgGUID: I9pexFx3Tk6ddvcufFOIQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11195"; a="25124191"
X-IronPort-AV: E=Sophos;i="6.10,230,1719903600"; 
   d="scan'208";a="25124191"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2024 21:54:10 -0700
X-CSE-ConnectionGUID: qiS0eNgnTEaLIJHdW5evvw==
X-CSE-MsgGUID: L/H3X+kZSG6rkGvoJZIifA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,230,1719903600"; 
   d="scan'208";a="68168130"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2024 21:54:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 14 Sep 2024 21:54:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 14 Sep 2024 21:54:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 14 Sep 2024 21:54:09 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 14 Sep 2024 21:54:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBWZlC+7IuTLsZL0hTGtUf2DDhC2YHW0rWiKK9ev7a1VjLZaQSAJy79pjw24NKg91O1j4mDfW67lzmg6Hm3vKhPub4mv4dHeqcSuQ/lnlfwpZ0kxRFRZoH4ctRV5JiKtQ5hYZHyncFWiar7wXzknyQ/kAKKneJMSfYw+AbDZiJ8gNKyWmUbO7lzxmNEneUSChH5DIliMqwEhWF8+gyz7jKZgVGlfdLd7hub+bVCV8mLQyLQqOgsKWEjLS4AesvVxcHbGbE9PGiEVZeInoQz+o4pukvf8Ns1UiHNlr5gUYmXx0GyjnEq2PJ3iQWE62IcjgEysHwyXN1ctJlfDNxPKNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmFO/4v8YiUMK2TlIJy0GIqd1nUm+w1L8YBFYRfObW8=;
 b=I8upp1orLb/7F2azkRpwXsmI6j8hKOQao6QdO+I0lsd/fmqhSNNBxohdhx01ktUJ6LYXTgke5m/ZxSmeuvTThU85mX1Htld7+lBtqFzTywWNYozsZfaEMqHpYYepGQ20gSmQejDsggqCEiObgh+8MZGG0+y/nzOSONnv/wjcQbh86Z52mdn2SpMuQEWLhYrhePtX3nFnE6oufdYmbvVwNLzLVj8yHjTuXCH7Qwbljz4aITB8nDBhr7zw16cTqAMPzo4mSRQRFCfSlvAi+xpobukx4KT4+GdYyscPFbQqPGRtEBNQ+Vmx/MMnRhYoiEPomkuXf7PciYH8DPGi/n/HFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 CO1PR11MB5044.namprd11.prod.outlook.com (2603:10b6:303:92::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.21; Sun, 15 Sep 2024 04:53:57 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26%4]) with mapi id 15.20.7962.022; Sun, 15 Sep 2024
 04:53:57 +0000
Message-ID: <f1597630-88ad-4530-8f3c-5437b297e268@intel.com>
Date: Sat, 14 Sep 2024 23:53:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] tsm: Add TVM Measurement Sample Code
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Dan Williams
	<dan.j.williams@intel.com>, Samuel Ortiz <sameo@rivosinc.com>, Lukas Wunner
	<lukas@wunner.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, Qinkun Bao
	<qinkun@google.com>, Mikko Ylinen <mikko.ylinen@linux.intel.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>
References: <20240907-tsm-rtmr-v1-0-12fc4d43d4e7@intel.com>
 <20240907-tsm-rtmr-v1-3-12fc4d43d4e7@intel.com>
 <86e6659bc8dd135491dc34bdb247caf05d8d2ad8.camel@HansenPartnership.com>
 <796ebe16-86a4-4109-9b80-91a238f975f0@intel.com>
 <529689b46df6a99a4a284192c461d16f7bfbb9f0.camel@HansenPartnership.com>
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <529689b46df6a99a4a284192c461d16f7bfbb9f0.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::22) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|CO1PR11MB5044:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd3c7d4-da22-49b5-33f4-08dcd5426842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VkZoaVF2Ymc5aDJHWHR4OXRzU2NpU2ZMNnd4aTJjNllrSWROTCsvaXhaeGhZ?=
 =?utf-8?B?dCtnWGhaeGRuRmNtcnhUQ0pUY1JJdnJuSmpFQktjdFFJc1BEYXhHTFdpa1hB?=
 =?utf-8?B?aDZDMUdiYXduY2FyVGFBemw1QVJFVHF5bFRYYkp5c0JYRDBZV3RTTkRCY1RO?=
 =?utf-8?B?d0pNV3M0WFpTTGQyWktBQ04wQUdzNTRyUUw1RjJmdnJTSEtLOEhzLzNHdFdT?=
 =?utf-8?B?S3E3aDRLSllGZTVDY0E3RjhTWllvUlJOR21CRU9VanZ1UUJWY0FrTnRlYnlG?=
 =?utf-8?B?YTRvQU43eldoekhTdCtWVkNLL2FRSlJtL2lISnBnMjJzUyt0VE0rL25hM3l0?=
 =?utf-8?B?dkdjZ3pTZVNWTWR6Zlp3alkwbDRaUE9JMkZRRkNXR3NpaWdwdTFxMERrVHhR?=
 =?utf-8?B?NElTYlVBQlZLdGIwL0MxZW9zQWNrMUxuUmJDaWxwUWFVRG9GWktMQ1RJSTRq?=
 =?utf-8?B?WWVZVU1yOE96dEFrKzVoemNlUDZobFN6a1kxT01Qa0hzdW1tRnpqWnVoZ2Rz?=
 =?utf-8?B?VXZRQkpLK1o2aXVZMHRsUEViNERaZGVjUVpCZ2pCdGtYRnJtcjJhT0JSa1hl?=
 =?utf-8?B?OFQwQmpYQ2R2aVYrek9xNjh2T0Q3MmMvRG1sRnNiemt5RkYxTUVJTkhEbm1C?=
 =?utf-8?B?eGROaVpPanNZeGwwbHFMSDdSaVQ1MTBQM0tsay9SNWxxUW1rVVNlWlZieExo?=
 =?utf-8?B?M3BtWEtvWkN1Z2ZqY21DcXkzMFpYSExhd2JmWk5WYWZRTzJ5MjBsTXpBeW9S?=
 =?utf-8?B?bEE1ZGptekd3WmRKcVZXNWJtK0pXTTZBTTk1OXZmMkVHc1FzVHRHMjh4Qkdj?=
 =?utf-8?B?SEtuMTQ3OTdYNFpTdFpTNVB0R1dPeWpZaWdsZG1kbldNeldNVm02Mm56MVhv?=
 =?utf-8?B?am01RURodUtyRXVxWDVtWGM5bDJYTTc4czhMNmg0akkxa2R0VktxS2x5SnBC?=
 =?utf-8?B?ZlI3QnU2cDNEeWRWVjNuWC9QcE40K3JnQ3d2UHF0T0NXRnpEVWR4aUxObXE0?=
 =?utf-8?B?QjArdytVWGROLzlTOFNyZFlZRk0xVWErQzJReWtXVUZEaVpxMmZ1UTlVNHBx?=
 =?utf-8?B?cjBmdjU3Sm52VU8vNTBwYzhZcWlTRDFaMldmYU96aTV5cVNFL0xXS09iVlhB?=
 =?utf-8?B?Qy91MXRKYWk0UTFlN01VTUpqaWFVYm56dzUybXE1TXhBSmVPVVNNL3p0dkVy?=
 =?utf-8?B?dVZmQkZSWVdSck1naUlmc3RPenlhN0lSS3dBUWwxNmRZMUVsNWV6RnZtV21y?=
 =?utf-8?B?d092ZUpLTHEzTTRpR3pmYm43UEtLZmZUYTRBZWdkcy9wVFYrSjR3VmMzYmcy?=
 =?utf-8?B?Y3VtZEpmMy81dHdLa1JVWDhJZGhTMEJvdWZURFhFTldSSWNuak0wRHZqdnVH?=
 =?utf-8?B?TitxMjJ1b2QvanlYVHQvY1cvamNseXhyaEtnYTVhdE92eGVPaEJiaVlBU0Vl?=
 =?utf-8?B?TnRjYVBieG9TY29CSk5zelZnNDUzazFxcjFZV0pHN2xSTnZEMWs5WE5qdTNK?=
 =?utf-8?B?cmg5MTY3Ky9Ic3B5OGx2TnlwYXhuQUFQRDlkU3FCd1hNVzlTT0ZPdFAxdmdK?=
 =?utf-8?B?WFJmcmNWU2Z6RjNtRkxOV0dUdGE3MHFJTG5sUjE5dlZmd21xbUtZVWhhVEFZ?=
 =?utf-8?B?WS80d0pKNlBGSWpSMmxndm84RmlJdkJ5RmhRVXlVS0lpWnkySEdoelVzNWV4?=
 =?utf-8?B?Z0I0UmlqZVJ1ZWFmMDYwY0N6bXZWZjBaUlBuRHQxN0JreEwvWDNWbXJpRGhP?=
 =?utf-8?B?OHRiaHNna0hRRWNIZkJ2QkNLeElGM1k0SE5taTBlK2RzTEw5TDRWNEp2OHBU?=
 =?utf-8?B?elAzRG5VQktPZUdzaDU1dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0I4NFpXbjZwU0NNeSs1bS9KUno1Q05DMW5oY2JYYko2TjBlOElDeEtadE9V?=
 =?utf-8?B?VkFQemxEQVlxK0UyWFNTajRCT09DUkZVaWdTOWswbmF1K1U3Zkw1Tk1QWERO?=
 =?utf-8?B?NUR1b2dGUGU4UjhreWJHNS9lc2dzZ08yaUVsaUExVTVKdFoyNmFxKytMa1hO?=
 =?utf-8?B?akV5ZkxWbllnczV2VDJ2VDBzcWFza1RRaXl0V0ZKMldSckt5dVEwaEtYWWc0?=
 =?utf-8?B?NXVQZCswcXcwN2NDQmNESzgyY0wvNFZJazNEdmxTbW9RbjhWNWsxekhZdlhw?=
 =?utf-8?B?eFZkVTNDTFR1WFo4dFc3ZHByM2tJWjRodmpDQlRycFVFYUhvamxRMmpCb1Mz?=
 =?utf-8?B?VzQ3ZGJBVTNrWGFUMHppUVFRS2JRNFp1aXhXNWQ0eWFNYSt2Ky9QRW9pMVUz?=
 =?utf-8?B?NjZVdmZPdEtEZC9FaytDVHN3NVN4MWJqdkliK3I4OXQxSUpudTRZZXpQS0Jp?=
 =?utf-8?B?ZVQvODVlL0lQcjRwbkpMNVlGenY0UVpVcVFwams5UDFEVzV5NVZrS2lTZnov?=
 =?utf-8?B?Umh2ZUp2Q2orc1dXci93Yy9aZHNqSmRDUzFwcmhVa21Sa0xpeVhCZ2dUSGtH?=
 =?utf-8?B?dkxNUHltUHBYN1FPWWZzZCtFR20xRVcwUUJRVThkMFkyaFVpSWI3N3FaQXkr?=
 =?utf-8?B?d0lWNUZLNGlyMWIzVWJkcUZxTzIyeTQrMFZUcVpFQ3pKNlNSQlNMR2N0MU5I?=
 =?utf-8?B?Mmp3bSt3SjgzNTVYTzUxSFF1VVZXYzBZa1M1QndMNlAwTDZYNXhqTUVBakRr?=
 =?utf-8?B?Tm45QVFhMGlmY0paVW1jeGF2V2FnRjd4N1lEb0tUdnpkbEhFSkFuRXdUTGZK?=
 =?utf-8?B?SmlPdzh4Wmgxc2JtT1ZKR0VCdEZjazg5QzBWQWxJNXcrRUE1RHlrVkpGS2dP?=
 =?utf-8?B?dDEvTHBPYmlnWHk5VGRhN2tyaWhreU5GUWpiSFlvMnZ4a2J6Y2tBRXh2aHBj?=
 =?utf-8?B?QkJxVjBTcHV2ZzQrUG5WNUxQRFJ3ZlNMSFpJZmNpL00rWXVXRTB4amNRYXh2?=
 =?utf-8?B?RkV4SnN5UHRoLzl2Z3QzOWMwRWx2Z2NBbk1jcm4zZEhTRVFtYytra0R0eGpr?=
 =?utf-8?B?UVBVUnUvcUJsbHNZTkxLMi9uQlUzWmQyNlpSN2R4USt2LzIvbUd1cUtLYnp4?=
 =?utf-8?B?SDlFamRMQUt3YnVUTWVSWDhCS0EyZVlwcmtZUmd0bDFIUS9Td0xSWStHdHNM?=
 =?utf-8?B?V3FWVmluaHBzQWhzY1hHSzBpaFJ2UUgrMWhWaDZmRGhjM3RzWjQyMXRsd3cx?=
 =?utf-8?B?WHhBdG41c2NMTGNpZS9veThGVk1oMGhTMVlVR2Z0TU5PckRCTGxDQVNsTVR5?=
 =?utf-8?B?YVhySHFIR0piSE1XMkluYURYN2wrUGUySVNhK0p1djNHL20yaEVCT2crSjlM?=
 =?utf-8?B?VmI5b2gvUGhVaGVSc0xUQ2pVbmUxUG44U295UUFHcTl3dUtuT3dPTkdhM24w?=
 =?utf-8?B?Y0hwa1AzYW9JdXBZZG9qOXhCTy93aW0yZFhvYjk0dXByQk5VR3luVXhOVkJq?=
 =?utf-8?B?aFlEQlVUSlF6SURwclFHWWh1VHQxR3ppRlBBZGszQVFwK1BXeVcrYzY0MHl6?=
 =?utf-8?B?eWxDdk5zdFlwbVpmYXhZZEMyejVZbmowTnRPUTNBdGxDVmY2NWl6b25IZzhY?=
 =?utf-8?B?alBrZUJqMTgxQ3JhT0pDYXZaTmdRQnNFVTJVbDhTZUp1ZE9zdjJ0MGFTdXJF?=
 =?utf-8?B?cmtQSU93SFMzM2lEUHliNFZFMEd2MG5qMGN1Q0dpS2puUGwzV3RLQzZXYSty?=
 =?utf-8?B?OENyTXUzUHRUWkM1V09XV3NnWXFhWnF3ZTlUYmhmWG5zYkZHTjJPMktwUHFG?=
 =?utf-8?B?RHZRbkhJeTRZSHlBQURpbFE2amhKWWNZakJmdkpqR3U0d0lzd2pnVTRwbVdD?=
 =?utf-8?B?UVAwNzVWME12bEl2cVlGTUw3aVM4U1gzcjlZUE5ncXBDNGhTc0VWeWdVd1hU?=
 =?utf-8?B?UUI0N0k5MVNWZXU4MFBxR29YdXJhcnFTNUpIL1NIbHdaYlF4THlKWGxYMStV?=
 =?utf-8?B?U0dZKy9SaEVWUEo0bXFLSThoRG84SzI4c0RmcmpsT29hVGpLRDBKcHhzSXhZ?=
 =?utf-8?B?bUMwam9UQ2c4dnVyWWdra2JxNjUxbC9jVExWZXFmMEx2b1ZibldmcU9IalR6?=
 =?utf-8?Q?xGuN3UT8H+vXR+dW8NQ4rlTgR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd3c7d4-da22-49b5-33f4-08dcd5426842
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2024 04:53:57.5273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0SWDE20qkm0aVUZrldGoIrBKgu8OD7kP+zRwteCv+qYzsuEKoybXFSv0UJlmglL3Rq2upXxOia+TquwPoC0sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5044
X-OriginatorOrg: intel.com

On 9/14/2024 12:10 PM, James Bottomley wrote:
> On Sat, 2024-09-14 at 11:36 -0500, Xing, Cedric wrote:
>> I have considered this before. But I'm not sure how to
>> (define/describe criteria to) match an MR with its log format.
> 
> This is already defined for every existing log format ... why would you
> have to define it again?
> 
>>   Also, MRs are arch dependent and may also vary from gen to gen. I'm
>> afraid this might bring in more chaos than order.
> 
> I think I understand this. All measurement registers are simply
> equivalent to PCRs in terms of the mathematical definition of how they
> extend.  Exactly what measurements go into a PCR and how they are
> logged is defined in various standards.  The TCG ones are fairly fixed
> now, but if Intel wants to keep redefining the way its measurements
> work, the logical thing to do is tie this to a version number and make
> measuring the version the first log entry so the tools know how to
> differentiate.
> 
I’m not sure if I understand this correctly. Are you suggesting we 
continue using the event definitions from the existing TCG specs with 
just a simple RTMR-to-PCR map? That’s exactly the issue we’re trying to 
address. The current specs don’t cover new applications. For example, 
how to describe the event of launching a container measured to a 
specific SHA-256 digest in CoCo? Defining new event types would require 
revising the specs, which is a high barrier for most applications. While 
TPM has been widely adopted, its use has been mostly limited to pre-boot 
scenarios. The lack of OS applications leveraging TPM is partly due to 
this limitation IMHO.


