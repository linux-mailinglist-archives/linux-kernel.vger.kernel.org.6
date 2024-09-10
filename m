Return-Path: <linux-kernel+bounces-323682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6E59741B0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EDA8B21912
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBAB181B8D;
	Tue, 10 Sep 2024 18:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XUf9vsTC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D722C18EFCE
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 18:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725991659; cv=fail; b=fxnonPdHDZPQcjZGepkdvggevqtBqc8j/Pk7nSQohy5OrHvEEJZ+8PfnLecBN0K/mZh8d7gxS4w3jNgJ6O/Y5OFzj4VrHt6EmPL7oIjcl007MPOZxvev4UQD/bH+oEBmIsa6fxkahqavKlMyJVcJR79XuDuJKFb36FNrbkdlpOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725991659; c=relaxed/simple;
	bh=FtWzislpwsWu1+naYvc52ssDXK9zIPiYpWDXoHmTrn8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yso51R8cQA0NBA7kUTsdktNVWrwcX6emDlNh+xO43GZQg7G8e7UoesvhACY9puH+Op+KdXnGwwdOfs/gZ8EKPT4k1n/cNzEiOyS8XQyJRvnZCyag95G9Da3MmA1T6qCXqo2wYTsXA1n9OzkY9TyBwe7o6ZUbdbf5H4UzaadX+Fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XUf9vsTC; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725991658; x=1757527658;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FtWzislpwsWu1+naYvc52ssDXK9zIPiYpWDXoHmTrn8=;
  b=XUf9vsTCsLlz2YLWRYZCdNrMLQhZnEBC9uN8xnaKww7K5LuAyQOuKoxa
   sruZ+d/l7H5DyyXV6fVWpn7sHEXJMZLPhprOiNxCpQ5jYSe5cBSYbf0dW
   mFs3vWmWY0E4OV4tP6bCu+Tfld1Q0og89JT5YQKKmqpnsJ9DeWTpFA1F+
   f5vmvFwEFccqTp0qTiMEl3K24ICY3lI9fZ0P4sw5y37ghGefOdYXVgXtH
   sEuOgqvq0RxXu9DvOfav1wL0mzaFIy1RlV6RpQkRLmaeHHRep1GC9ptWc
   ub+8DvEoT5I68lxAuIs+Y08lyH7WWN5CTQxrG4DNxJD/GaH1pBPdf8pRU
   Q==;
X-CSE-ConnectionGUID: 9SUVOMj0TNmaC7kCoJ08Xg==
X-CSE-MsgGUID: N9+vG7kdRHWFO8aWUQ1ZmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="42236483"
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="42236483"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 11:07:37 -0700
X-CSE-ConnectionGUID: WOJLJSMtQN+qRhGpOx91HQ==
X-CSE-MsgGUID: aNrI5PaETYW9I5eYQmb83A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="90387380"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Sep 2024 11:07:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 11:07:36 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Sep 2024 11:07:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 11:07:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBhaBFgOA/J7tZLRDoGNZxk96wGSRAvBH4dJp4hzr5CMQgJzhW0nZVobq9MS33PW9yPbK1APpiowi9Bwl3q16GNbh9LZTwtb9Ytqeyaz8AipbyOXHxISEdAmlt4bPKiHHr/mVoJKSSzImNGPKoZ+8gUqCX8+pGhDfiQmHPr5IWaWe4rGeLlcxZSQZABfz7t2pkiMgpQ0HLLqpyE7gRyR182+XuHYKP5G9MMKBgXcvAtCkpT4pmgRMUS8p4vanls0kMnZJHQMgkIL2UIIKPSjEVDFYeVbiKMhbI39pb/uFJ9RO/mPFHVceCtZGYr4qgTwyXYxXIwtn88Mn2Okcn4PAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+a+R/5mZeEkFdLv3HB6vK8nwFiu/t1Dc9QIxxGNuEk=;
 b=A0PbvkbRm+2HXiWgESjEAXyjHxJgx9v90r6p5QTe+dVp+La9cNDnH6JJ5WJ5K40StUVvT7CBOOgtpU91CqlxFT5yGIVY/jGILfCdz/gtkO/Z1iTaOO18ccbOQSQKW+sJBYF6zqrCPuEM+ZLIPqd98VTbYKXnpRnQ0AV6G/FT577TuggW3QVNlW5pQIT2zjmEuXRrtQb3EMXiFwHyJ0m4rSsGKWjd42kREmV8ZEP8KzoH2lLa4JFC5ohb6qoTED/mU/5YHAlJE0pCgtyPWk35b77q+XAkCY2kH5vGOtzSJ9cEAR8GQxUWyqn33Zu8ZodP3YrTpGfipqZ6wkMkN1zQNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 PH8PR11MB7966.namprd11.prod.outlook.com (2603:10b6:510:25d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.25; Tue, 10 Sep 2024 18:07:32 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26%4]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 18:07:32 +0000
Message-ID: <2d459da4-03e7-4233-9c93-cd6b88886a85@intel.com>
Date: Tue, 10 Sep 2024 13:07:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] tsm: Unified Measurement Register ABI for TVMs
To: Alexander Graf <graf@amazon.com>, Dan Williams <dan.j.williams@intel.com>,
	Samuel Ortiz <sameo@rivosinc.com>, James Bottomley
	<James.Bottomley@HansenPartnership.com>, Lukas Wunner <lukas@wunner.de>,
	Dionna Amalie Glaze <dionnaglaze@google.com>, Qinkun Bao <qinkun@google.com>,
	Mikko Ylinen <mikko.ylinen@linux.intel.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>
References: <20240907-tsm-rtmr-v1-0-12fc4d43d4e7@intel.com>
 <10ffa4f1-e3f9-4b7d-9a6f-e4dd843f6d44@amazon.com>
 <b1965018-6663-4bf5-b8e0-8210d0429333@intel.com>
 <d49a9768-fc9c-4df7-ba11-5b25470f6feb@amazon.com>
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <d49a9768-fc9c-4df7-ba11-5b25470f6feb@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0193.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::18) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|PH8PR11MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: 750bfc42-85c2-44ed-8da3-08dcd1c370bf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aHI0eHEra2R3eHZHalE2eURERVBRdlQ0ZGZwOGZaTDg1Smw5YlErNkh5MTR2?=
 =?utf-8?B?NjFzaTNkeHFXdkVhdUoxZGw4TW9wditDOUNZV1ZrT2JTMk1ZdU42Y2ZJekJm?=
 =?utf-8?B?RnhPOGtqenhqRmEvZ1JuNmpGM0tFK0FEazJ1YlBvTURTbHVSVjNXVWoxc3JL?=
 =?utf-8?B?a0J1R21PZ1BsdnNKTWxRVWJXWVFoSkcvVzArMzRpcWtJbk05Tyt3Z2lNc2ta?=
 =?utf-8?B?WHltcEV5cldpYnJ6bnJrREhUdWxFWVlhTWFpTTY3SUVVSmJMdGJjMEwrMDU2?=
 =?utf-8?B?Uk5PM25BUkZzWWM3bHVZeTdFMTBnVitvQmlkYjRYWXR2aVBObFdvRkRleTRN?=
 =?utf-8?B?eS9YV3lYVHZla2NGTTg5Uzh2QUpWSXhhSzdwbndJS0xTejZLN3EvSGNmcTRD?=
 =?utf-8?B?MWlSRDdqUHRiQithQWNvUGZQUjJGK2JTM3djVUtqaDVSelZvR0s1UFZxZkhC?=
 =?utf-8?B?TVNrTnNqbHhzalpyNVNOQVJOYW9YRnI1M2RZMUZSS2QxVFJDdFQ3T1BwQUto?=
 =?utf-8?B?NzJnc21yMTEyRVJzTktGRWx4SVdWejBuU2NScmFUUERQT1l1d0ErMldTVFl1?=
 =?utf-8?B?d29rQ0ExQWU3RjNLMVJMNnZ4NTF4My9sTExlRnRqS0lUamNPbDhKVnpLYTBm?=
 =?utf-8?B?bHQwcVgrUEg0SENCRmR6cU1UOXRLb1ZXQjJTNk5aYVV4K1Q5RGErVTdLd3o5?=
 =?utf-8?B?NUlWV0VXcUpJTWRJK05XTCs1cnJJZ3dJNGNGYUViR3pzN0pKUzAyUzRjSXQv?=
 =?utf-8?B?QjhLTCt5WXhqZWVadkt5SVRBWEZjTkxCRlhQbVhmZHhiVTlXRTBHdlROVTcy?=
 =?utf-8?B?ZmdZc09zNFFXOGhCdUZPOEptVy9BTitUSFBTUXp3UGMvYmVZV3ZNeSthWUtw?=
 =?utf-8?B?akhQakpxMHhaVmZGNlhGSjVPUzU0bTluazhiUlZJSXFMOUJVaDQwTUVLWE1P?=
 =?utf-8?B?NjJ1QjFLS21NSExhQnRDaUxmUkJvWFFZc3ZicVpWeXhhcllqdVJOSnpCZnll?=
 =?utf-8?B?Q0ZRelUwNHBNOFU5QmN6VzU3YjRIaDVZZk1UYjhiWExrUm0vN2dHQWxGL0Nt?=
 =?utf-8?B?QWhjNWVtMEQ5RUh1VmhVNmMyeUhuMG1IeDhTUDhjMngzZ3JoTnExU2VLY0RB?=
 =?utf-8?B?YjMyWU5TWDBra0hobWdHcC8yVGprYkNIb1RVRFNpVExJaW0xVlVOQUE4SXdE?=
 =?utf-8?B?OVNMdkZOQUpITFRSeWtEMGt5c3B6WlJONGg5cVprZ2dyMlg2NXozWE9EVm5l?=
 =?utf-8?B?aGhEdDlaKzRpdGhDR3hvWWFoMUd2YXgwVjRLZ0RFZm5VSXJlK0J0aXcrT0RC?=
 =?utf-8?B?bzEzMWo2UzVPV0hHN3dWRjZGTzFMRjI3WlZURENMaXhqdXBxSjJqRkhoVmh2?=
 =?utf-8?B?clA0N09rR3pweFo5NS9Tckd2ZmdWSzViUHJ2N3N0YmN2dHV3NFFkYXpYU1c1?=
 =?utf-8?B?dEQyMFVjais3M2p5UTVQUlppVU94aDdVVU43RXR2d003S2RWdjdIenN0Tmlv?=
 =?utf-8?B?T3A0dURua090ZmNkWi9TMDR0djgrdmpHWkRvYUxMSkx2aXMzWGhRQlJJdGlX?=
 =?utf-8?B?RTdHejVxNFJVa3JSd2xYdVIrWDI4Rjc1MnFncWwzWlRLVzdZOU9vcnczZE5p?=
 =?utf-8?B?VWlSVW0zaDE2b2wzRGt4WFZoWWFCWXkzUXBsK2g1b0VIMDlBNjdnTlBhVTFQ?=
 =?utf-8?B?RU5iU09aK3VyVHpwWGdTMjI4amtTOFRoMmJxT0VzZ1VmTW9TY3NJa090WHAr?=
 =?utf-8?B?UWl1V0hzS1E3ME5XZTZPMjg0UUV1YUJlNy9EMkdoTDc3eW9KRW1hUW94V2Uv?=
 =?utf-8?B?T0RPSHROeWZlZkdvUngzQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDV2OU9yRlVuTGdZa2x3VEtmUy81ekdkZlVoODR2MjZwNWdKU0VUUnQrMjJB?=
 =?utf-8?B?Um10S28rcGtCbTBhSXdkOEhKM1AyY0d2RFZRekpEMzhxMUoyUFh3Mm5CcHVH?=
 =?utf-8?B?dVpoaUN6dzZWajFuWFhwY1RibUdtdUIwMkE5aGMvZERGMGRHYnhHeERzL3RQ?=
 =?utf-8?B?YXE4VjZlUjg5UUFINVdYc0pOVzJpVm5aUHI3NmdRT2diWDI2TE01Y0dsNXZD?=
 =?utf-8?B?dGhsc2JwN3RmK2UxUDR0bkFhbS9kaCtMQVRYc3o4M1M4REFab3EyOXZuZDRW?=
 =?utf-8?B?ZDVCWXh0OEUwb2VqYVJ6aFYvSms5WFBQbWVyQURKeXhnSWQ4eTVmL0NmMHpP?=
 =?utf-8?B?ZFdNcTdJVmJOQ1M5UU5ia21IZzhZR05UaTBZUE1WSFRoNGtTRnN2N2ZwNlRa?=
 =?utf-8?B?M21BQmIzNUJtZENlckpqelVtMHVja2x4b1pBUExTOG1ScWxUZ0toRVZJRUg2?=
 =?utf-8?B?bk0vUCtuYW1ZYVp4cFpqTjVkdUV5amFXcnlvQ3pLa3lJT01mNHdSaFRUUDBl?=
 =?utf-8?B?SGhteWFiWjN0MDZBT1cxK0dmM2c0cGVxRE5sd0RvNHhTQVlMeHI4d2RiK0t1?=
 =?utf-8?B?eVhCeTFEKzNiQzl2S2JRSkg0T1lpUUNVZVI0NGV4VGJaMDVFakkray9KTTI3?=
 =?utf-8?B?K21WU2FKQXR6Z2s0cWxlNVJHYlVPSXZZK2kvbEpwT0cvVU12NWV4aDJSZ0pU?=
 =?utf-8?B?ZWNTZlZmeTdiMDZEZ1MvTnBlSTl2Rk5mQXhDQmxheG5hQWRxSzgzL0cyU3Na?=
 =?utf-8?B?M1pscUVQdWxoVjRkK3BLSkZZbWl1T3BHNko3cE9mWG1DTHl3ejVMOGVPUDdv?=
 =?utf-8?B?dzRJTFV6d1JCUHhiQTJuRVRDUzhLSjFhQlp4c0cwU2NkNTNwZ0ZEU2Ywem5U?=
 =?utf-8?B?eDhQdnkrMDh6eWFpMTRmWk1Pb0RnNlJqMlVneUxWU0l0WkJSMXFqcFkwYW15?=
 =?utf-8?B?WGVjT25JYjNBdGk1RFE2NW45U3RzeWltMjZaamFiOXFUMXdXR3pidmZPdG9q?=
 =?utf-8?B?a0swZ3ovdXlKNGovQms0czBiNndUTmV1N25UWE1UT3BYYTgrY0Q3OUFYR0VU?=
 =?utf-8?B?WklmdHVMM3A5Q0FCTm1Xb0JXSWlVYjgrdk9yb294SHJhVnhoWEpBSERtcnFy?=
 =?utf-8?B?ZlB5Y3BRZlhxSnlUSHp2NURtVjk4TlZ4QmlsWjNTU3dDeWZXQXZmS2M2WTh5?=
 =?utf-8?B?cEQvaEZDby9TUU1ORWwxZkJQUnBOcG9wSWJqR1FQQUp5VldLZHByVWZ5cXFZ?=
 =?utf-8?B?MTdwN1dUcUNOL3ljOE8xSmVlZXkvZzdkbGdWNmJXOSs4U3FLK3FXWUVONXI2?=
 =?utf-8?B?T3RVUG1JeHRmVUVlWDVQL1B2RW0xV1R4OXVmWFp6UnNaTmhsTDdQR2VaWVN2?=
 =?utf-8?B?WUtCU1FKbjM4UW9hK1ZBOXlaT3JYbFh3UFBTRVN2SmhKTTdvR3RIL2RZaTMx?=
 =?utf-8?B?N01OZnZma1ljZ1NpNHhUSGo3a3ltVDZ4TE5EZEtKK09CNUh3V2pwbWo3WFhZ?=
 =?utf-8?B?ZkcvOGxaZjBydmhXVEtYUkx4dlNMblJvTE9JdStPWmhOUHp4KzlOd2hHZU12?=
 =?utf-8?B?RTA2dVhVcXVlRDB0WDdmTmxjTXg3QlFqQnBOcnl2TG1VWFdMQU1yaXpVWWh0?=
 =?utf-8?B?SGxkZFd5Vms2SDA4Z1pNeFV5N2ZPYnBOMHBnMmpKbUpIelNiQ1hzWVV5aEtZ?=
 =?utf-8?B?MHFkQjVRVlQyRlBhbndLLzB0aGx0OGFpUTJBT2JNKzZnbk94ZDg0Tmc2Znlp?=
 =?utf-8?B?dnRZY3ZKdDhzcVdlT1JUbzZoWW1MUDZaV3d6VWlrVlkrMmpTUTlDaVRKaWhv?=
 =?utf-8?B?V0hGV3dDWXEwUlN2QTZseTR6T09ad28wWU5EYXB2UlZtZy9qUGhhc2xFOUJt?=
 =?utf-8?B?aHg3NW9GbEtoamJMRk9wMk94WUxkVFBsMGxLd0hPMlVlcFhtT24xa0trTllZ?=
 =?utf-8?B?WmN1OWVaMnJxQVcvamFUVFV0ckdRQVB5Q1BMOERXYkEvL1ZORm5SOVlTVTVC?=
 =?utf-8?B?QXExck5PcFlNUVFkSlhyYjgycWVqa0pqa0pmTEhKUURrcTd3SktkVXhZRnZz?=
 =?utf-8?B?OHd5cTk0dWlTcXRFMnBwcTBUYnZYcGlTT2Urblpmc2NmNFRHQU9SM0dEK0hI?=
 =?utf-8?Q?J/dMtK2kywfPfCOC8GJ+xpfkz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 750bfc42-85c2-44ed-8da3-08dcd1c370bf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 18:07:32.2467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AcKL5S0aSGufSBumE58Unyv2baJsV77ck6mKHivi6tozbcWcGiwyfrCHktIStLrgdsScgki6b+zVAn1lTDScfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7966
X-OriginatorOrg: intel.com

On 9/10/2024 2:47 AM, Alexander Graf wrote:
> On 09.09.24 16:55, Xing, Cedric wrote:
>> Distinguishing them in the user interface makes enumeration of RTMRs
>> easier. Also, there are RTMR specific artifacts that static MRs don't
>> have. The most obvious is the `event_log`. `hash_algo` is less obvious
>> but it is in fact applicable to RTMRs only (the only thing that a static
>> MR has is its value). Adding those to static MRs would confuse users.
> 
> 
> I think that this statement is looking too much at the problem with TDX 
> glasses on. Conceptually, measurements can happen at any time by any 
> component and then get locked going forward. Let's look a bit at what 
> different solutions do:
> 
> TDX
> 
> static - special registers that get written by the secure module and are 
> locked at launch (?); SHA256? No event log; order defined by platform.
> dynamic - special registers that are mutable at runtime
> 
> SEV-SNP
> 
> static - launch digest generated by ASP at launch time using a SEV-SNP 
> specific algorithm. No event log; order defined by platform.
> dynamic - not specified, would be implemented by an SVSM
> 
> Nitro Enclaves
> 
> static - PCR0-15 get calculated and then locked by the boot loader. 
> SHA384. No event log; mechanics to reproduce are defined in docs.
> dynamic - PCR16-31 are up for customer use and can be locked at any 
> later stage. SHA384. Event log is undefined and up to customer code.
> 
> 
> All static calculations are based on some algorithm. Yes, the algorithm 
> isn't necessarily a standard digest, but they can all have a name. I can 
> also absolutely see how any of the solutions above gain event log 
> support for static or dynamic measurements. At the end of the day, an 
> event log for static measurements is just a matter of writing it out at 
> launch time.
> 
> So what I'm trying to say is: In the user space ABI (file system 
> layout), please treat static and dynamic registers identically. There 
> really is no difference between them apart from the fact that some are 
> read-only and others are read-write.
> 
You are absolute right that all MRs are the same thing, and that's why 
they are modeled in the same way at the CC guest driver level. In fact, 
if a CC guest wants to expose all MRs in their own dirs, it could set 
`TSM_MR_F_X` for all MRs and returns an error from `extend` for 
static/non-extensible ones. For example, PCR0~31 may all be exposed this 
way on Nitro. I hope this addresses your concerns.



