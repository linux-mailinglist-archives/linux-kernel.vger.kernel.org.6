Return-Path: <linux-kernel+bounces-234218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABC791C3E5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0F31B21946
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8251C9EC0;
	Fri, 28 Jun 2024 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WeFuKJe9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27DA14F136
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719592915; cv=fail; b=gxXbaM4wgAzXfTro6SSONqIW32qDTcoegwSzTsMgtCMvO3N6hm54LZ/K/FF4kxvjezOwZCaLfWejpaFt67IvGBpJNkJFwIqbKbTdyE6294jUp96r5YgctcaE/hia9DEXJQzF4k6vIoAq3T6aPDrRyJFn4+mTYMhd5UiC3fFpNDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719592915; c=relaxed/simple;
	bh=rd2gVIk5e69eN+aWF34wNFvPE63yTCFtjUM9lJqWvrU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iqnUo78Y7cTMEiuNFmJoCQxxq3WSHycJf6CKl4p6Dhzk60L3/A1erW8gkQ8M5416w0e8V1JwENlTKxuTzLLkbiyOZWh2kMKMtvPAJE6ZL5HmrNvQf74Q56BlUGHIs+bWVVOLJFVgASYkPfRGSRv6QC1cv4hbIgVzOSdBmusJFiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WeFuKJe9; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719592914; x=1751128914;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rd2gVIk5e69eN+aWF34wNFvPE63yTCFtjUM9lJqWvrU=;
  b=WeFuKJe9AfXERVTyhdDBSk5iL93z1YP5RDHqRICo/OpMQS0QdU8kEehD
   8dTdjAb7vd8Jq2cPW54UXKjt/UrhWdtMhj+mFnB2J289wwWQbQG2UCr4u
   mrZfcmGhLXXyLVqnIy61VrMfNzSw5kCVfsdLpfMFEV0a2HsqhiIfvbJ/q
   Y0Vth53tHyeEHQyDTTDrax2JKPg73FhCW2PzSacbIQlZZtl7PxyGnli8K
   pfyBGb1BCGkwmhmuU159W4BrUEesjAhM1mXl9aOuaJ6bNM53m2zbLlF8b
   mvrr7aZ6EvI4xTkwKTgETvfERd8FmRWnjcFgsgTbis56B9jxPKROMEdxd
   w==;
X-CSE-ConnectionGUID: 9uVdZSfgRDepoJ0EQ+eRNw==
X-CSE-MsgGUID: 8Rx8AgULSMuZ9X2D0OvBow==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16606479"
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="16606479"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 09:41:53 -0700
X-CSE-ConnectionGUID: wCeNVppDSmqvBdO4UFWGng==
X-CSE-MsgGUID: UEY9nc3OSk6expMyg0XoBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="44906688"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jun 2024 09:41:52 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 09:41:51 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 09:41:51 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 09:41:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkrnlwBlWpirCV/GleTyoQulWEZFVbABrC13wOZFrFo2CEnlCNbzdCKgk6T7IOamqp3XWdIlwSBRgu/wB6/iS+IUnjB0IqbgtvfB3Uj2WMT/eoMn3eEcA924VXEi+pKW9wU9R4FeYuqhZmsG0galjK+t8WwvvQ78GG5k/ddrPtHOUlIjHVtWPjvvO3dd5qCW/1UOexHaosPduflbOIr4BvpD/c0WWODpMBd908lTzgo8jxVeWfA0WgZaPwwqk1CEHGQL+9QJQqZQoZO9ZWc/RJJuorwNlGbOFmGliH121GOu7/qAJPw+a7n2IhCESv5UzPFJGYi0DazK+t53HjTsNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MiB63Pg7PIUdecTVVJSp4eZGqqgok1XMB6+SHmxtHAk=;
 b=fj4EQwXFvKyXzEkKz38qhE4/4HbmxmpUQNYShgqdtp41EWwZXiqBj3EIWixfORr87G5bw1k6p3iIlQVNmEhkQv8DlkfRJMMRIR+TIIl2O6LGOns7lGB3Ghzc0AUpNf455IXmPx14Fwc3OblsNbMCErHV/juPbTaMFWFC2G6l0fkwPzMmq0IOLCB7M2g6lyf7yy5YVvG56918dvbXHXNa5GcWCq5auZXBjb86o0VvTyy3Mn3/F83v2oswcYcyB3ViRyo6g00vbgrjnTM8lW3Nsmq5qFj71wPQHHVJ0+GPcM0KKWacm1MCU9VMFD2MPM4D9LoidcDZ6auP1d8s24HeVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6348.namprd11.prod.outlook.com (2603:10b6:208:3af::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 16:41:49 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 16:41:49 +0000
Message-ID: <28f474e7-0bcd-45ec-b50e-6708f97d6403@intel.com>
Date: Fri, 28 Jun 2024 09:41:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/38] x86/resctrl: Fix allocation of cleanest CLOSID
 on platforms with no monitors
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
 <20240614150033.10454-2-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240614150033.10454-2-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:303:16d::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: 39f98cd6-591e-4461-77c3-08dc979134d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NjdKQ1YwR2l6WmlUSHZQQzJXekJWLzZlY3QvVkFkWVJHMnVIWFFReGE4Skhx?=
 =?utf-8?B?cTUyZWkyd29SejIzRStYNVplTVdMeVFVTVF5T0dwS3hra0VJcTRWWlRPQWgz?=
 =?utf-8?B?czVVVDZ3KzJrR3lwQnNmdEMveWdWMXQ0K1V6NTIveGN3UmNqdmtrM0tpZXZj?=
 =?utf-8?B?SG5JUnk3SzZEN1dTa1J3YWhieXVkcis1MUdUL2JRR0t1bC9ydjJVRWZWRW0z?=
 =?utf-8?B?cUJNQWpjbjg3TEZWZjIrbUg3S3ZPTmdKY2pIUlZxc2RKKzYydkJsNGI1OHVM?=
 =?utf-8?B?UTRqQzQzY3hldzBjcXBiK3JVOVk1YnpKdFd5VzZlN0FSbld0aUl5R0hKY1RT?=
 =?utf-8?B?dC9NY3FYRDRHeUNFU0ZRc2VuTTBCTmQ2WU43cmYzSTQ3REdTT3N1dkw3ZUVk?=
 =?utf-8?B?dnE0c2VDdHd4UlcwNG03Y1J5YmIxMG1CcDdnMzhXOWdLZ2JhNFlTMUJicU9E?=
 =?utf-8?B?RHdnNWZGMGwvcGw1dkozMU5DZlRXcW5HZkVUdWxmMDcyN2txUk04MUFqQUNa?=
 =?utf-8?B?amQ5Tlc1R0lRRHV0M2N3NDU3QVQydWh2cUIwSDE1ZVk1NGMwVkE3Z3ZkOWpE?=
 =?utf-8?B?Y2JveDRFaFlkYVI1bWlaTHJYMHFFS243VnFTNXhDdnRGWDlSVmRRL1NZYjhZ?=
 =?utf-8?B?MThSTEFBaGtXd2lGdUFzSEF3Z1AzaElpbUpIUFdLeVdUaWhUN1YzOEJCbTJE?=
 =?utf-8?B?eTJNWWI5b3dMalJwTC9iNTlnUkwybnNTaHV6MExFRE15YVB5MjRkMDE1Z0JY?=
 =?utf-8?B?ZU1FOEhVSmU1WXhaRGNwcHhKQW81NUJhT1lwWkJVOE15ems1WG0yakVPWjA5?=
 =?utf-8?B?L2R1bUpScWU5WTJlZnN4OUZRSjNxcDN4ODlpb3p1YjJid0Z1cTZkSG9mWjNC?=
 =?utf-8?B?SU92b3RCSm5UTWJ0SzhTTEo5eU04ZDlMak1MNjdHTG16WnhUTW1sQlRZWlR4?=
 =?utf-8?B?TEpXVXpTVXFxT2NqVGkyM29FUlpQR294YTltcmpxemdRZmZ2ZmxieXdRUnJt?=
 =?utf-8?B?WVRYak0veU1UelE3YlV5bndidzl6VWM3dTdZNUxRVU5mYVl5dlROWWc3djNl?=
 =?utf-8?B?ZEd4L2hjRGlkTjJpNWhobzhhekZiUXRkZHowcDdKNVJDdHhqL0JmZmkvYnYr?=
 =?utf-8?B?TzJzL0NYSXJCd3Q3cmtuWGMyRnUzdDhKU3JUZ1VuYUk2ejhLYi9zTUgyZ1d6?=
 =?utf-8?B?bmliMG5GdVVDNU1OZG9xcE14bWFOSkZ6OU9Sa0JSd1V6Smo3LzV2SWZpcUY3?=
 =?utf-8?B?eHJPMEJzbnJzKzRYa2tMUE00TFNVUWxSMURjNzh2cHZndjIxRXl5Wmh0d1Ar?=
 =?utf-8?B?VW5hUmJNTUY3L2oxTGViMmxIRG9FbHFjaitJMkdzS3lkRDFZQlZiTDRMTzFu?=
 =?utf-8?B?clU3VHBMSWtkOGdKbFlrUXhrNlJQSWxWWXVGa2huM3B6akVUcTUwUUFxUU4y?=
 =?utf-8?B?ejNXQzF2R25xbmpNSnNSbXdrL0VlM1ZBZTNjK00rR1gyZ0tkdU5aQUF6SzB4?=
 =?utf-8?B?L3ovNUR0aEcxTEU2K3JpUElybHRWbmQzeU1xdWljSTNHL3BNc0NEb1grdFlk?=
 =?utf-8?B?ejZ0WEZLNjVjcXQxNUZaNkpNQXVsVThxMzhaN3l3VW0rdnB2aFZCVlV6ZDR3?=
 =?utf-8?B?cW9pbXFyeVNmaVptS3pIVnYrSCtyYldhUUJGUFhPbFZWQVlHK2hRRHZrSHNj?=
 =?utf-8?B?NFdvalM1SjhMT1dSd2hMVUZiSG91TWVWUE9KYkc1eHRkWkxhUTlkamlGN2Iv?=
 =?utf-8?B?dkFNUlRnZEtlMTBYN2VwajFlMHpncmZmcy9ObFN2ZmVZY1Qwa3VRaU1vOCtt?=
 =?utf-8?B?bElsNjJoTHNlSnhML1poZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekNGSnVrczZYNTcwSlhRcjUyTGl3QlpGUm9DUm4yVWZqayt0cldUK1dtd2h4?=
 =?utf-8?B?ZjZRaG8zcVNVb3NOOGFUQ3JCa3JoTUFhcENKYW1IZ2d2OXI2RHdESWRWSlVZ?=
 =?utf-8?B?dkdGdG91M3V6TFBiK1o3WFh4UkRSbmF3aUJpa3Fjam1FRk92K2NxMUN0UUh2?=
 =?utf-8?B?NHRBZDl4enRTbFpoTURQRExCYVlGYStKQVMydld1VXZaM2RKY0wwdDFCSEJy?=
 =?utf-8?B?WXZYSkZoMVZ3ZzFYVVBlaXU3M2RRUFJ5a2l6bk1PcElrdW45MzFrbkNObDVC?=
 =?utf-8?B?WjRMUjhuWFJPM0h5b2NQTm5Ma0NwM3VMWnIwNXpxMzcwV05OWENSenpId2lk?=
 =?utf-8?B?WTd0YUxGSC81Ny9BeGh2R0hYYkwvL0pxSFhKNUtUVnlrWlorVVVtUXg5YmM4?=
 =?utf-8?B?MStXQ2Y0TkRjWFh2V3lENDVNMzEyRVE1eTZncDlETWduMENETlVyVlEveWV3?=
 =?utf-8?B?UWozZXpXdDlMWTVQb0hTMDZDUjN3Qlc3V1ozTWJKOXJHU0psQ2NJZ1RRK05p?=
 =?utf-8?B?TmJScUJMd1pLRVdIaE1HUnM5ZTNZK2ZRdFh2Mk12WFBBbnNXWHMxU3pidTFH?=
 =?utf-8?B?NjFrUFFKdlVuaU1jZW1JQlJObXJrcHpJYUU3WHRtWG5rNU53VG8raFhjTjhk?=
 =?utf-8?B?TWV2T3dhZnV2QkFDcHltOEtJQUFBUGk4aWo2S0NwSkV6V3J3ZHRQaWxlTVhj?=
 =?utf-8?B?TEduMkI5VWJ1b1hiK2hWcTFOMitaMDlvSmpab2NxNTRDUHQ1OGxEdTNnU2pu?=
 =?utf-8?B?VlNHZE4rUU4wMVV5ZnladTNHUGRXVHhjaHdNUDFVVGlYVG5uNWZlZFhUNXkr?=
 =?utf-8?B?V3NhQlBpUGoxdFNPVWlWYlJwd00ya2pGbzZlc1VQcmxiWFBNQXUrTW1BRDQz?=
 =?utf-8?B?NG1SUHZ5NENDbWthTE9jWDJ3ODNUU0JBY2hVRmlmWVBQYjN6MEt6ci8zVEcx?=
 =?utf-8?B?bmNmd09pNVJKdVlaeGxmMmRQZERyR3YvbDVtR2VJOWdXekdUNU5Iaklyc0xr?=
 =?utf-8?B?VnBkc0RIT1pXM3pHelVXWHRPeGYvRTIyR1J0OXlNVFRuSDE2UktFWkhabkhs?=
 =?utf-8?B?cVhXbTBNRUdGR2FMT0s5c0FZcHpnbzBwMjlBbVZmWWJpaGxsdTFiNDQ3cG9o?=
 =?utf-8?B?ZDZmRzFVcmdZb3BaN2gzVlNRZEpLRzdaOXJWYmNhTWczWDg1R0NMeFAzeGpE?=
 =?utf-8?B?Y3V4WHd0RFpyNUpHNG1zRXRqdUxFaFVEbCtxVWZ3UzBNMmM1YVVVNHp5cmwy?=
 =?utf-8?B?dlFydUExcGp3bjAyaGhzME4wV1hCZGN4OUlEdE9VZkNjc0dWSGtVd2w4eWhB?=
 =?utf-8?B?YmN6YzRHTkpPUitrV3BPSlBQWjA0WDcxd0Q3d21lQTRidXllTnZ5cEsvcG9D?=
 =?utf-8?B?RmUydFB4Rk9nRXpMYlY4UDJ2dWl2LzVqZG9xeTBrVHJRaVY4NnRNWVdUeWRL?=
 =?utf-8?B?a0R5RlJDNjlVN3FqcEVuZWYyaHFrS1puTWZzaENTWGxLeGJkdTZoZ3MrRFpq?=
 =?utf-8?B?Vi9QUm1MOTM2c1lyd1JCUjlvWDU5RTIrZlMwQnFoSG5rckg2cnNFRC9KSU9h?=
 =?utf-8?B?a3YrTnU1TmFVbFNTN0hsdm5QL2N0bWRYRStMS2c1bHZ2Q3dxaWZZNkhaTjg4?=
 =?utf-8?B?MU5HaGg2TFZmUmI1WkFFTG9Sc0oxRURsNVl6THZRTzh6S1pYR2hzejY4cjE3?=
 =?utf-8?B?RXpkS3hQQjlMSkZ4RjQwQmRoam9ybHA4VElhbHlxcUNkZDhGYjRqZWo2ZW4y?=
 =?utf-8?B?QlVSZmtucWh2TlpSNzVhR0dQOHlNa2IyMDM3U2ppRFdSdDZDd0g5cmZERXFH?=
 =?utf-8?B?bnlGSzV6OE16cDFLNUN6cDJqNWFXdHUxY0Y4RjNnQjgvbXcyTjBPRm9hQ0NV?=
 =?utf-8?B?ekFxR3o4ek1aa09CbFg0NmhXalZ5eG1TeUttanZlQVA0Z01FOGNUMjBDaEFT?=
 =?utf-8?B?ejAwSHN3ZEtxN3pXT3pwVFJjUnFsT21IbzNYdElVUWFzVE9qQjFsQVkyQ29U?=
 =?utf-8?B?blVOd0NLWHdadjE2ZndLcXUvQTVqWjZOTUpwbDA5YStDbm1PRVBNV3NWS0lO?=
 =?utf-8?B?T3ZMQ3ZXeXNrcFY3cEVUbnM3OEk0cm53WmxEZ3JoVlBQN3lGR0FvL0c2UHBt?=
 =?utf-8?B?TGlrOE9kaGtaMnl3T0lFUUVxYjc1N0Mya3laQXNWYTRGRGF0T0YvckdkY3Rj?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f98cd6-591e-4461-77c3-08dc979134d1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 16:41:49.3917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8qjC80F0CfVZN1rVn+8UbJhnpYetUYLGThft5Faz4Da1a8DSqGDg56sXe9rwwcV4Wwb8Gj+ZXai3A0GzApxejl7G5ZpblmXOu2DCpGkwyPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6348
X-OriginatorOrg: intel.com

Hi James,

On 6/14/24 7:59 AM, James Morse wrote:
> commit 6eac36bb9eb0 ("x86/resctrl: Allocate the cleanest CLOSID by
> searching closid_num_dirty_rmid") added logic that causes resctrl to

There is a custom in x86 on how messages containing references to commits
are formatted. For reference you can see how the recent fix
739c9765793e ("x86/resctrl: Don't try to free nonexistent RMIDs") was
reformatted before merge. Applied to this patch, it may look something
like:

	Commit

	  6eac36bb9eb0 ("x86/resctrl: Allocate the cleanest CLOSID by searching closid_num_dirty_rmid")

	added logic ...
	
Looking at, for example, commit e3ca96e479c9 ("x86/resctrl: Pass domain to
target CPU"), it does seem ok to split the name of the commit.


> search for the CLOSID with the fewest dirty cache lines when creating a
> new control group, if requested by the arch code. This depends on the
> values read from the llc_occupancy counters. The logic is applicable to
> architectures where the CLOSID effectively forms part of the monitoring
> identifier and so do not allow complete freedom to choose an unused
> monitoring identifier for a given CLOSID.
> 
> This support missed that some platforms may not have these counters.
> This causes a NULL pointer dereference when creating a new control
> group as the array was not allocated by dom_data_init().
> 
> As this feature isn't necessary on platforms that don't have cache
> occupancy monitors, add this to the check that occurs when a new
> control group is allocated.
> 

The snippet below does not belong in changelog and can be moved to
maintainer notes.

> The existing code is not selected by any upstream platform, it makes
> no sense to backport this patch to stable.
> 
> Fixes: 6eac36bb9eb0 ("x86/resctrl: Allocate the cleanest CLOSID by searching closid_num_dirty_rmid")
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> ---
> Changes since v1:
>   * [Commit message only] Reword the first paragraph to make it clear
>     that the issue being fixed wasn't directly associated with addition
>     of a Kconfig option.  (Actually, the option is not in Kconfig yet,
>     and gets added later in this series.)
> ---
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 02f213f1c51c..d02f4c97e40f 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -149,7 +149,8 @@ static int closid_alloc(void)
>   
>   	lockdep_assert_held(&rdtgroup_mutex);
>   
> -	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID) &&
> +	    is_llc_occupancy_enabled()) {
>   		cleanest_closid = resctrl_find_cleanest_closid();
>   		if (cleanest_closid < 0)
>   			return cleanest_closid;

With changelog updated:

| Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette



