Return-Path: <linux-kernel+bounces-434211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 617399E6358
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 02:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE61D2841A7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF9313B5B7;
	Fri,  6 Dec 2024 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y06KU1bX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4B82F855
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 01:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733448028; cv=fail; b=WvOKDaL/d75VDlxHwzobCdUJTnw7rC4LxtGlcq1pIBGhLI1y5AyOvOXwmkwjabVOnWbfg2l8dU2sLZlvyRBvYNeZeQcFPTqWgDmHsrTHood6pC3qaL0rFQRkw7iBLqkCy/88O/r1Ey6ezlkVb5v+ofc5OP2SO7n1aouMvr4W0YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733448028; c=relaxed/simple;
	bh=dJYCgg9e4wbL2i8UAYCW+5OYGSm1umnDtbsRrUljfBI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=doZ4B9U86xO1olXWuJI43zIRYNV4T6Xp/x5e/gfoC+8WapoNuJiKmcAujK9Q2GGI52+MgfNOTFuPgbzMsBSqV5HlmpuYX7T9gb9BH2L84ofJFJ1j7RZvhv3UZyQS431rkz0i3/w53stVAWXlES9Wl2LO0He4s8P1sg29l3rGpME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y06KU1bX; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733448027; x=1764984027;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dJYCgg9e4wbL2i8UAYCW+5OYGSm1umnDtbsRrUljfBI=;
  b=Y06KU1bXQsVw276FmM069v6otpT9N/v54ZqNUssh1nuhahDyAKciR3Gl
   uETfCyGEo0V614JLY4+mFVzB2os5Z1FTzkB/+mwRRa/5DdC+o3u9+4cF8
   NyR6O2Rr+gR9l/zhW+SNsQQLlV8DJ4VqppsAfG7/1Gc3AHejbr18r21vT
   TOGk0v7/xe1KJhdvDcGRfv5CB7T5xEuCOXW1N9F8ShoQEjxz1/nloxAP5
   tblMGM+gNKMOqzDF5WIVBmpRhaDXElEwR31HC95feOUM8Pe6rE4HxLzkV
   vLG0D0km6i6oNd3LXYzlJQjm1po2MVYyeXnxfZrFZzQTIcmCmOTrPPj9t
   g==;
X-CSE-ConnectionGUID: 4jCCau4nTz6MOj2+iT3U7A==
X-CSE-MsgGUID: Qu6WNHvXRy6fRtwn0G/kXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="44455812"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="44455812"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 17:20:25 -0800
X-CSE-ConnectionGUID: 19B1dRRKSUWF9TK1ySlbqQ==
X-CSE-MsgGUID: YkEBm5x0RN6Y6WQqIq+fGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="95082750"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 17:20:25 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 17:20:24 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 17:20:24 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 17:20:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LVWyw5YaaFas4CjqzZtbllt8jfSloWpTV6FzVPrwxbL6MhtU789d8HNIQ/icn/QHP+Z1doHl1bzZMhkTDyov3DuzX0BoX86xVCeoqqdk6QERoLaG+QkV9SYuGapv49zuBdaFuQdl09Hj98SoGMtUUJESwlQuvJ4a2owRJGy5rtDJFrUDp8GDLQM2KKcSAjICWaThxg/JdfD2a1MDVmitoz7DoQzcbOV8GgEAqNBvn6GB3znQIvVkljqvc8dcyT6dBHhF3+UpuG07lGjJJ1qkVmxo77xZcyMd65mcUkVUluaxtPaNlf0tD6wHEKNtPgZ92dOtArzD3YO+AQR9FX2htA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l23DKnsha+m5VIeI2xKYIncZkIE5rG0AXRyjvgOvsUM=;
 b=i91rgZfvftWMp1Ej4Scwp3oTl8xeAq5YnmQyMQSlqnKMvelP0Ip6P6BlDq1Svh20VKlq2JD1PtVIqWtFC2uZK1J5B1wBXWGnbTsWG3tj3c4w570JQ5+P3YmOGL4o3RLwKdvua8XE4BOa6QHkGTYMv294f6YN774yczdY0CIZQc6gfsjBK0AufEu3lLg35UJIxXL9ABk6PR24XnUZGe8D9V5ym5bVMcMcMc99xMYmzNwO7FQr9m4XyNHGGIFClA6eQpGszP0gouWX2A2bwaW57kewy4VMJgZpYg6ET+ldZaOhn4x+mfmoj/MlB6LRdBMfOnBLevbXCjXrWWxgMrcIpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB8455.namprd11.prod.outlook.com (2603:10b6:510:30d::11)
 by DS0PR11MB6495.namprd11.prod.outlook.com (2603:10b6:8:c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 01:20:21 +0000
Received: from PH7PR11MB8455.namprd11.prod.outlook.com
 ([fe80::e4c5:6a15:8e35:634f]) by PH7PR11MB8455.namprd11.prod.outlook.com
 ([fe80::e4c5:6a15:8e35:634f%3]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 01:20:20 +0000
Message-ID: <42d0a757-fac2-48f7-b6fa-3f7c35037081@intel.com>
Date: Fri, 6 Dec 2024 09:20:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] net/ethernet: fix typo in annotation comment
Content-Language: en-US
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: <linux-kernel@vger.kernel.org>, <anthony.l.nguyen@intel.com>,
	<Shyam-sundar.S-k@amd.com>
References: <20241205065218.1288394-1-jun.miao@intel.com>
 <37e7bcc9-d9c0-48fa-b4ce-fd543defb929@intel.com>
From: Jun Miao <jun.miao@intel.com>
In-Reply-To: <37e7bcc9-d9c0-48fa-b4ce-fd543defb929@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To PH7PR11MB8455.namprd11.prod.outlook.com
 (2603:10b6:510:30d::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB8455:EE_|DS0PR11MB6495:EE_
X-MS-Office365-Filtering-Correlation-Id: f5036d44-0374-4bdf-80d8-08dd1594265c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWdsNklkbVAxWFVqTzQzZlVZN0ZlcXpqZW9ZODcvYkpjdjdCa1ZKQjJ4cU9N?=
 =?utf-8?B?Ykg1a0h3WkxxbStzUGd3WUpVZVZaQXd4aXZUSnArajNveTZJeDBNRnlkQU5H?=
 =?utf-8?B?UUJGNk5ldXJ6a2o0cFQ1UStYek1PTm1oeU9YNWY4S0pxTWw2VWRhb1g1bVRH?=
 =?utf-8?B?aFU3TkVtKysrZkQra3poNkVWZ2hhQS9ORHU0OTdqNkZLNmFaSkJVUnpUcFc4?=
 =?utf-8?B?RGhmbm9uU3RIMldzQTdnNkk4eUFRZldHZFJkaUNsTm9sb1RwNDNyUEtWU0V6?=
 =?utf-8?B?QTN2aU9tWFZ3bWprdmtZakpEM05lSG1UQlB3Y0F6aTMvQnhwUlB6eXNpd1Zo?=
 =?utf-8?B?UEhpa0hFbUc0UmxYcFNkTXc5eU9wd1hseG05dHRmam04SkFNUklGSE1WZjNw?=
 =?utf-8?B?YVpKWEFuK00vUWd2WXNiSEt3dVY4OTFTZzhWVWpSdFVaYkR4T2VzN3Uyc0pi?=
 =?utf-8?B?VXg3b2NOS0FJZTNqckpnVFQ4MnNkVHNvRisxYmJyYjd0enNDU01QRU11VFhu?=
 =?utf-8?B?SHIxZ2VMNXVYU2ZuR2pyQ1QvaFlhMHpUand2VS91OXFvNGFxNDFPbi8va0l0?=
 =?utf-8?B?eUVHSUtYOFJZRWhoVkdjb0txdWVBd1RpSFArZk9mdFJYZVZib0tGUEhneGJX?=
 =?utf-8?B?VDZTU2hhcnFPSWFjOFdHYXF3UjRrdmtaUUZuU3dhelBGYU9sMnpCcXZ4N3RH?=
 =?utf-8?B?aUl5RzF5OVJ4Z0g1YlgzSzVPaHUrYS9QdTVDYlozSmZMMThnSnM4N0Q3Y3kz?=
 =?utf-8?B?SUZpYXJFWHJJSGt4ZG52VmZFeEF5V2VoaU5IZlNsMktta1B4bDVKNm1xYlkv?=
 =?utf-8?B?VlJmeTlyUE1MS2tNaFM1SFpDbzFOTUR2ZmYrVUo1cDhyUDNTaXAzbk96aGFq?=
 =?utf-8?B?WGxpN0k3d0ZHckRINUpNdmo0UG5PM3FXcTNmOS96ZGlUOE0vVkVmS1RsUUtk?=
 =?utf-8?B?eGFwNjlXczFkWTRwZWg5VDQ0KzZvWUc5eW1wTzdmSUc4Y0p4T3FXZ3RPc0E0?=
 =?utf-8?B?K2N5UGpNbmxadktFTzZpWWwyK2pnWXZIa2R0MGVNNjFkaG4vdnJ3cm9WVDdz?=
 =?utf-8?B?UlpNalJYWS9VV0hveXErY2tvM2wxWDR5dCtaNklnWVRkMWx6UVFOZ2VjWWNU?=
 =?utf-8?B?WVFsWWgrcENHSmpxcWZIRnMzZzJhNXBHWmJzWUFrbTkvcHBGSWNNRWxlK1RZ?=
 =?utf-8?B?ODlQN1pvMGlyWXovYzNnQXBVdHQ5bStMMklDYzVyQzltcGJRN2JmMEVzZFYv?=
 =?utf-8?B?cHAxUFpmZ3JXcUU0RVhoQ25zL2lWc3c5ZlZMcVk0Q0xiMVNvVmoxMlNGZ25L?=
 =?utf-8?B?MTZ0aFlEYW43R3lvcnptUkNxN2wvcmFWdEFLcEJ5VjRjT2J2d0pGakJsQVl5?=
 =?utf-8?B?ZWRBMmZMa3BYZUd3Uk5RVGw3djFmWDRzNEE3VU5UaVpwY2piRjRmMjdzbmZt?=
 =?utf-8?B?bGdHc013SGw2VmFNUWgvRDBEbVRYSytuekJBTC9MZ2NNRDRObkVFbE9YUDVG?=
 =?utf-8?B?d1dsQjFlZWhPRWxQTEpJNFg3WnZSa2JUL0s5M3MvYmZHNVhpOFA0aWt5VStU?=
 =?utf-8?B?NHAvYW94YTZNbHFweitYUXQybHk2NGhQd1Z0UXZ2Vy91RkZWUWNQVmJIYWln?=
 =?utf-8?B?SEo3cUFXSk1RMHN4N2U5b2pBU0tMN1lpZFJXbzBqaE04b3pQM3hsYzk5aVlp?=
 =?utf-8?B?ZFNCZ2Q1NzRESWlxTGFSbElzay8yR2ZILzhiWUhINlRDcC80S3BsQS8ybVUr?=
 =?utf-8?B?NGVyTHN0NkFVQlZrTE5rRVhtREdrVGNRZ1c0aFFMcmpUTitFY0Jhd2F3WmhO?=
 =?utf-8?B?YmhZNUQ3OTBYcHpzSTAxdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8455.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTRWb2NuSWVwcGMxTWtUOWJIWEZwZmxLZ1Q1VEx6cm9HbTNIdyt3dVhyQUtQ?=
 =?utf-8?B?TGpWV05GWi9pUVBJTVlaVC8wTHhCR3p6MWo2MGNCcEM2MVY5RGJGRGwrYjBW?=
 =?utf-8?B?TlNGQVNNckRXaWxFYy84WlE1b3hTVjA5YUVXMDhhYWZQSG94TjgySUlOdmxX?=
 =?utf-8?B?TkI5S0Z2cU1ud0czY2xCeVFBWmc0Z2EvNEtybnZTTno1aU5SQ21nbk9SNFRi?=
 =?utf-8?B?QWFyZk5MTEg2cWQxL0w5QTBsWklzd0xSWUhjalNuWHhTTE5CRlM2SlRoRksx?=
 =?utf-8?B?SUx0THVEVndDdTRyUW14VzRhTWlJdkc4SUZLR0s4ZFNwYnFxZGU2UFRHMUtZ?=
 =?utf-8?B?N3VYbFRlZ29LenNpVzBkRjZSUUVxZ1V5NzhlWUJ0NUxwTHpKOVFvT0Y2VFpE?=
 =?utf-8?B?disyODR3c1ltMkVhanNyaTFTcFNjWmR5V3g5ZVIyKzBRaXdZWnFRYVBGWk5s?=
 =?utf-8?B?QXA5QmdwcFlONEpjM0tING5SdTlCV2Z4MUxQWXRsc2t2c1RKa3JNcnhLUkty?=
 =?utf-8?B?SUNSaDNKV2xZS1JHc0w4VFd5ell1ZHkrVUJQT0M4ZGFKd2EvajZYRTBTNisv?=
 =?utf-8?B?YVJuL3lMRTNMTEhkTWlKY0JYTUFjcFIzakJ3UWNEa2g5eHlTUGxHU25yQXRj?=
 =?utf-8?B?eGxOQzdqcXQ4Q0VscjVGV082QXAvSWM0Lzd4NnVmTHBEdDF2S0hhVFppdnFu?=
 =?utf-8?B?cjN5UURxcG9KcEl5TXJ2T1NORm10d0FBeEltTWZUV3lVK2lOQSszSkhIUEZU?=
 =?utf-8?B?YWRtS0FpTFBocXRCQXNQY2VsVTlhbmVvUjBSZ2xhTFhHZ1NaeWl4bWJ3dHpN?=
 =?utf-8?B?cGlyQnNYbGF6RVRVRTM1TmwxaUZDRkc4YVVOV1YrNlk3MVVvS1pQOFdSbzl4?=
 =?utf-8?B?ZXh1bjNZVk1RUnQ1SWVZNHNEUk5JejZHbnlVNG9CUk0wbGRtbDIvVFBDSTBC?=
 =?utf-8?B?cTRNa1R6OWxwbnRPalJZdzVMWGdsWktiVGErbWREWFRrclNFVWdiWWZ0dUo5?=
 =?utf-8?B?TkZsRkVTdUxYQUw3TVp0U0dNRXRnZ0RkZ3hMNHZhand0REpCa0hONlNBTW1Z?=
 =?utf-8?B?d3hYbElxdFBDTXV4dGtMTWVIRTFoeXBsZHJOaGlENzlGUFFxWHRENkY0SURh?=
 =?utf-8?B?N1h6SUdJOWtnYlNGK0hZTHNSQnJZb1NlaHpvUFk2cVp6dFoxRnJ2a0hKdUVw?=
 =?utf-8?B?Z3RneVl4UUFlalIzVEo4L2hwaFZkdWRPeUdPUk9xVnRuaGcvR2tjQU4wRGUx?=
 =?utf-8?B?SmY3LysxWVlBbXJvZi9TTE4zMWl6d2I3K2RSZ0tHMjBld1h1QjJiYUhyR1BS?=
 =?utf-8?B?Q1RpdERhczlCTjFpSHZpeUJ3eWFOMWVuN1NGcFVZUVdaVzQ2TGNjd3JYSzFQ?=
 =?utf-8?B?VmN5emJ3WUhjQ0ZScllGNXpSMmFkcXhESEpsaUJXMUdEbTZreWJIWXhrU1JP?=
 =?utf-8?B?Rm4wY09rRUJ0a2Q5MXdDQmdJZGFnSHdKeTFPcEp6OHlQdVc1aC9FVlVCOFoz?=
 =?utf-8?B?QXNFOWd5UWJyYkY2YkcxWFVGTStQSGdzWlBkVlJzM0w3elp1WVJURXFwbHox?=
 =?utf-8?B?Mkp4L3pGMDhBYlZsN29hTEpQRjE3QnRrRzdRb2NLeE1mRWdEd1h2cFFUUmhZ?=
 =?utf-8?B?Q1BPcHBjWGQ3ZUJpTkxuWWsyOWVTVnBqZ2FQWW5OUUpMcktZVkc5Yk1vS1Zt?=
 =?utf-8?B?ZEFlUitvK2IyTkMrajk4dUxrcll0b0Y1UDFmZ29zeGFQcVZoVnhkWThUa1VK?=
 =?utf-8?B?TndDbDdTYzhBR0p4UWF2M3NiVzgvY1kvUUxxZGgxZUl4eVkwTXkvWGZ1VkFO?=
 =?utf-8?B?UUNPQkhqanozV2NpaTFzbEZLUFRMZ0ZXbUsvQjlMcG5UNVA5Z2xkVkVNbVJP?=
 =?utf-8?B?ZVZaM3VYNjNmL0NQcVN3MEZXU2NQMFNTWmo0OVQyTG1uK1NjK2t0Y1ZLc2hY?=
 =?utf-8?B?c3hIVHpFYjBIR1F1NVNSdGJieStLYThlb0tNT2M3a2J4dU43amRkZlhtamE4?=
 =?utf-8?B?TlY4ZFFrbHFoZDZJbkdvNXBrUFgyaHJRditRc2RON2ZiUG9WVlo2OHMvSi9L?=
 =?utf-8?B?cjFPMVJXKzBFejdGdmtRbmJza045RU9IOFlqK002ZjZDd3J3QU5KV3lHRkkz?=
 =?utf-8?Q?k83PyUmE+5TyOnpYOgQh9dqNJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5036d44-0374-4bdf-80d8-08dd1594265c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8455.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 01:20:20.3039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZSODU/mFdYsX6aOt6woMpCDoD1qLRkJEVVo2fgi9j8/Qq9oj9J0Vizh75PIadC0pzigrCkkGo51jXsNtgA3UUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6495
X-OriginatorOrg: intel.com


On 2024/12/5 18:21, Przemek Kitszel wrote:
> On 12/5/24 07:52, Jun Miao wrote:
>> It`s "auto-negotiation", not "auto-negotitation". Let's fix that.
>>
>> Signed-off-by: Jun Miao <jun.miao@intel.com>
>> ---
>>   drivers/net/ethernet/amd/xgbe/xgbe-mdio.c  | 2 +-
>>   drivers/net/ethernet/intel/igb/e1000_mac.c | 2 +-
>
> for the igb:
> Acked-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> you could fix also (perhaps as another commit):
> arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts:273:     * SGMII 
> Auto-Negotation is enabled by bootloader for
>
> nit:
> I would also put "about auto-negotiation" at the end of commit message,
> to make it unique

Nice, thank you. That is perfect to add "about auto-negotiation" in commit.

---Jun.miao

>
>>
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c 
>> b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
>> index 07f4f3418d01..5597e7df0aba 100644
>> --- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
>> @@ -1264,7 +1264,7 @@ static int __xgbe_phy_config_aneg(struct 
>> xgbe_prv_data *pdata, bool set_mode)
>>       /* Disable and stop any in progress auto-negotiation */
>>       xgbe_an_disable_all(pdata);
>>   -    /* Clear any auto-negotitation interrupts */
>> +    /* Clear any auto-negotiation interrupts */
>>       xgbe_an_clear_interrupts_all(pdata);
>>         pdata->an_result = XGBE_AN_READY;
>> diff --git a/drivers/net/ethernet/intel/igb/e1000_mac.c 
>> b/drivers/net/ethernet/intel/igb/e1000_mac.c
>> index fa3dfafd2bb1..2bcce6eef0c7 100644
>> --- a/drivers/net/ethernet/intel/igb/e1000_mac.c
>> +++ b/drivers/net/ethernet/intel/igb/e1000_mac.c
>> @@ -1581,7 +1581,7 @@ s32 igb_disable_pcie_master(struct e1000_hw *hw)
>>    *  igb_validate_mdi_setting - Verify MDI/MDIx settings
>>    *  @hw: pointer to the HW structure
>>    *
>> - *  Verify that when not using auto-negotitation that MDI/MDIx is 
>> correctly
>> + *  Verify that when not using auto-negotiation that MDI/MDIx is 
>> correctly
>>    *  set, which is forced to MDI mode only.
>>    **/
>>   s32 igb_validate_mdi_setting(struct e1000_hw *hw)
>

