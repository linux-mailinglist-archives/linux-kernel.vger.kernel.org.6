Return-Path: <linux-kernel+bounces-197247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047748D681C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 19:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44A028873B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 17:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14570176AAE;
	Fri, 31 May 2024 17:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d5h4mC78"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2A955E4C
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 17:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717176184; cv=fail; b=occXlYYDBB3YoLgr+viQgTDiL5MngNsRbhXCIm/VXhPYQHn9I5F/zDtJMVqobH7zw850wS9tAkcH54HdkWkpg4ShELQND0Rlgd2+s0Y4M4REY9f7eXCb0F3fUkoVOq/rBluphHjT2Ntkpz0RcBvqWAY/4YrYkdRduPqqKoVc+RE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717176184; c=relaxed/simple;
	bh=4KRDR15bRFooA8mk1gjh0ATGtDFZXMA/UWH5yI/HTOg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CenC22Oa6MF8kDwvWkHn4cG7s9oOP8JN/D/BoH9ARUHxnvQTqNeyzqrgWCFYUihYu4CNf69DU+8GrosFZpT9J5/YlZCiAkanlW9Xkb8y3fLJ3zchDj2OXGKB1ScrtMz5W0D+WjY0At8esKEWkYbkbCwYWv8JK0qNDIC4s9m+XFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d5h4mC78; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717176183; x=1748712183;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4KRDR15bRFooA8mk1gjh0ATGtDFZXMA/UWH5yI/HTOg=;
  b=d5h4mC78cg/U8Yrb73/N2o5zi0kNq6IaTsImFsDEGgujHwwVANIXC/G9
   bwG3L00x7l+2eg8VHR5MivlzQdOSO+xdLgWuIpHdMhL8bDLiIysirPdH6
   qeSkEj8Zzs9c5tOtB0xW2POX2i9wvQNegCnPMvKly+uI2+/0MsBgnwjzF
   M5IPJrgl7pTowjOTZcGYg9LBay7951CY1YsPpnu4slTJeg5oISqtHaACT
   fRzM3KdvD4ZUEQOysn+AaGa6MrH01W9+PkblG1nopbKhmq8+mnHoJahz3
   67GALq4Mdc5G7Ok+2UVkVlNiyljSOn/21x/LxkFxBx/2JpBnZl3KGa1Ax
   w==;
X-CSE-ConnectionGUID: r3Z/zWuHT6KgyH45Vd5GUw==
X-CSE-MsgGUID: h6naeHdISYyv0R2x4uJYLg==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="31225666"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="31225666"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 10:23:02 -0700
X-CSE-ConnectionGUID: AANV8DXpSm6+gOgRcTwSLQ==
X-CSE-MsgGUID: NgQkOpLqQtqGSSXEeznoOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="36169200"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 May 2024 10:23:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 31 May 2024 10:23:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 31 May 2024 10:23:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 31 May 2024 10:23:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8GefymfQ6h74LDtb4N0RD/iyyu6N9n7c36g5FWHYJ31Zux1zjG8YkeAoKIzK2rr4UiNt4np6tfm66kEsP7GKYFUidqFb8yKvOlR58J3YBL3adYPMtAwZXXXuBLf30tsZEdGDHJA8UrQdTFIOsaBk/6d1voDRSjcnno10cvWiPxNvyKkv1YDGX4fFWWj0ZDjVL01DLq6HRJ4pjO8I2RPwlrCkIMzEhxui5oybdUlTgKWhTNZ79J0HwyZZpMi3w8rTbludHJdM5eyofMbHDbntpqI9i/BybBuTWQuov6H5LihCcNRDbLT2qZGHDMvbP/mHRJxkd0CfJcZxnkikTGOlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLTgrGNohf5YP4THJNk2AyniQTsNEf4awZdVD/7MvbU=;
 b=eny26x+ujjNKFM2a89pTO3LjZyEMTA1aIXDEHhGOapNHmEHkUR9se4u2xzEsme+bNWV7kySMt0hn6P7dDLL47D1cE/nnoLKQsBxXHj6PWF1upaWR+6Ia2erklpa5Mq4YoaZXrDdiyARg6V2vfwHI331AIFmG6f62MnNcG/cU7u8pBVK18/wPKoGrq4jcsbclqrq9294dsGriO/Fj4rNY82xPWyCsZh1jY/NMZr2UxBdumr9qXBQAvAuTg0zHxRZGudVsza+EtWmBXX91CawNgcbq5oV3FgkDtGLeV33+jCp9kNUbEPhmd9YJjAhnqOlSkfi1lSaude+rFB9dDsnVfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB7164.namprd11.prod.outlook.com (2603:10b6:303:212::6)
 by SJ0PR11MB8269.namprd11.prod.outlook.com (2603:10b6:a03:478::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Fri, 31 May
 2024 17:22:58 +0000
Received: from MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::a972:1395:dd49:1dc5]) by MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::a972:1395:dd49:1dc5%5]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 17:22:58 +0000
Message-ID: <97a50b05-3909-4988-9181-f98e3c9c661a@intel.com>
Date: Fri, 31 May 2024 10:22:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fpu: Remove export of mxcsr_feature_mask
To: Nikolay Borisov <nik.borisov@suse.com>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
References: <20240530192751.172597-1-chang.seok.bae@intel.com>
 <d143cc4c-8f8e-48e5-87f1-dded3272433a@suse.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <d143cc4c-8f8e-48e5-87f1-dded3272433a@suse.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:a03:100::40) To MW4PR11MB7164.namprd11.prod.outlook.com
 (2603:10b6:303:212::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB7164:EE_|SJ0PR11MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b2a9a43-32ce-4a2f-1036-08dc819650b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MjkySzZHRmpmUEYvbmkzZUh4Q2puNDdGQTZ5MzlXdGNTTDBxQVN6Y3ZYYTFZ?=
 =?utf-8?B?M0orWGp5NUl5cXozNjJWcUcrVzhpOXE3ajZjZ1AvRVZFeE1EcnpWSUlsekRt?=
 =?utf-8?B?bSthakExeU5BV2ZLK3BXL3cxbXRpc0lTa0VQQnpSWjdyYWhQL2FMOS9iazdu?=
 =?utf-8?B?ZFFYOGs2Z2ZaajZIN0FVUk9FaWtnQlNPZUt6Y3ZyYUFUKzExQnZwaTFPczRu?=
 =?utf-8?B?Ni9rc0RlOW4zbjhOcnRKTVZYc2kvSm1vNFgrclFHeDNOZVZSeFNobk5CQ1pK?=
 =?utf-8?B?eTdTTUtsR09RelZtSzUrSHdzaHZydS94c1RmQmdGYkJxNkZxTHhvME82Njln?=
 =?utf-8?B?eG1VZDVhWVZobysvaldEa1hIYWcwYWhlUjV4aFQ0QUVuZzFkemFVWDA1c045?=
 =?utf-8?B?VGNkbGF0OGxSWmhFRXhqTFVYck8zdmp2dDltMzNQd0lDZVNZeHhqY1J5ZVV1?=
 =?utf-8?B?ako2THJxNTFJMFM1NE5aTTY3UnozdGJUZ1JvQkVaWC9jNjVRYVVXRzVTNllY?=
 =?utf-8?B?Unp1RzBGZXZSZGcyYUE2THVhSmdCOC9mTHdLc3YyZDZtU28xbXgxc2RUT3g2?=
 =?utf-8?B?RnhUcFhQbTN2RmRmQ01DcUQwVFBpajZpNVRSV0FSY0c1aEtrMml2alIxUC9H?=
 =?utf-8?B?UHZQUWdTSDhEMWFrYnM3azl3WHI3RW5zanJLdk1xSGFpZ1cwS1QrR3pkczVn?=
 =?utf-8?B?L1hMSjg3T21Zb1pBRHkrR2hXYm9nc3pjM3Z6djVUWXNzYVJ2cS91WGhMOFN1?=
 =?utf-8?B?ZU9YZ3JWMjVzbzBnM0lZOE1mTHpWMFZzUHN5clh6YkVlbTNYY0w3eFFpbjU3?=
 =?utf-8?B?dmE5dkRGWnZ2aE1zYmM5Z3F5WEhLMjJsd3JQYUxpL3VNRlhlSjJGSXZYb1FX?=
 =?utf-8?B?bjFicjQvMGRQU0dhNjZRZmhhQnhydW41OGRaUldyaG50M2ZnWCtkRndmdmp1?=
 =?utf-8?B?T2JNamF5c1Y5NVFLbEwrM1BlTEZxN29BTEZnTkJjUExBRGJTT1Bac2FDOVNF?=
 =?utf-8?B?RWhxNGxkWHhYb2VGcitRTitUdWRHK3Y0VXZ0L0daMC9tU1cyRXBUYTBWQ2tL?=
 =?utf-8?B?VHJlWDArZlg3YnV2SUZjeThnNi95cVlyTklCQmJCNkdmdnpHYm5wZHh3cEhX?=
 =?utf-8?B?YW9pZHdrSjZtb3ZtWGRDdHlWMVFHelRUSlRoaWwxbE9vcXd4dGRYQzExNTdh?=
 =?utf-8?B?VVJsR0ZnVWtHVE9tY2NoSnVmY0xEVEtOZjVESzMwVWlmT0RMMGcyaktOZllu?=
 =?utf-8?B?Z3d0S0pPam40UVdvbXNOVVd1cXhSZEpqT3VIaklGTXZ2QUlaL3V0cmdBR0h2?=
 =?utf-8?B?bG5uMlZoTHFpdzg1ZFRCVTBYOTVRQ2txbk5SZ2kyelkxVXBNbkp5YUZGVmZG?=
 =?utf-8?B?QmdGRG9iYWdqOUFITWx2RDRKRVRxb3FqY3NsSlBaZnh0TWRxZDhPREFscjhG?=
 =?utf-8?B?dUo2djJmQnBIemp4VS9ycWE4N0J3ejZTOEpwMDExa2Yxemh6RE5xK09sYWd2?=
 =?utf-8?B?Y2RrRU80TjBVc1NnbTRzYStWUXdLclNRR256L1lTaUs1Y3Bwb000MHdXWnZn?=
 =?utf-8?B?Q2Rzb0N1eXVZc053WkM2bnhSTWhWVHdablVIR05KNjZqWEd2S2tYc2U0Tm9P?=
 =?utf-8?B?TU5tMlRZR3FUUnpjQ1BUdW4zTzNaR0xLZjdIektMWGdxNnFaTTBXSHZCeVl1?=
 =?utf-8?B?TytJaXp6VTA1VWpxV0lua3VuL0V1dkpGeGhydDRGNTN1OE94VlRUTjdBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7164.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Szg0NCs0eGhrbm1QajVaRk1sTUJEbFQ3bGJadkFTNVd3T3N5ODJlTmtnbm1M?=
 =?utf-8?B?NGxYVW0xSEg2a0krUW1Tc24wZVFTVDM4MTNhbGZyblV0cEc3d0Y0YmRmQWQw?=
 =?utf-8?B?OUVPdUFqWC90MHhoaksybExZQkF5bnk0SmdzMGlDOVczKzF5b3ZMKzB4NDBy?=
 =?utf-8?B?YUZDNk5QZXl0MHc5SkozZnlMaFJnNStGYTNwbEk2OFBvMXloV3BFdXZqTW03?=
 =?utf-8?B?RGFYZDFJSTNLNVpEaERmNzlKMkE4aHZPWkMrVkE3MUxnMytOUzZ1K3NWYXVu?=
 =?utf-8?B?MG0zMTc0SitKZWtrSEpzSUJUL3pXakpyNWlVazg5WTFhZjRJSnNXWFlsTjBx?=
 =?utf-8?B?UGYzcDFvOVRKRDJ3Vzh2STFMWFlUdkZZRkxTUTJjZVVjdmp6d0ljR2tjMHdx?=
 =?utf-8?B?Y1JSRUJqWjQxNGJ2MUMxelNEUWVBS2M0VTlhL1hTR2xpYmpUQnpwNHF1d3pV?=
 =?utf-8?B?RExuVjFYMkNMK1M2MFpYM2F4dlF6SmtMbitRNFBaVHliUmdxNXdWVHpYVDZn?=
 =?utf-8?B?Ky9iUFVBSmVrZUtJSTRtKzJ0QVNDQTBSZ1E5TWhOenZ5K29YbzNWTmw0azFj?=
 =?utf-8?B?QU5YVUI4OWR0aGo5em0wZmRSMUs4MVBPbWx2TUtZRTZEYjJkbzJGMjlYejhu?=
 =?utf-8?B?c3dYR1BucDdtUFp4YXBDUDRwMEJUb2dtYU5DZiswTml2Y1dsck1qbWw4K0lr?=
 =?utf-8?B?Z3hXRG8wMXRzTFYzVDZtaEJkSlFubzdFVUNaeXNKV3N3QUZQakE4ajN5SnQz?=
 =?utf-8?B?R0ZmczRvRjRNSE5ocEc5TTlXSzMxQlJmVzc1a3BJcW1uK1l1N3Z2aS8rdjhV?=
 =?utf-8?B?Z2V3cEs4Zk5ETTFWRjg5THJmSVVYUEViL200U1VRR1ZON010K3VsNEpFUitS?=
 =?utf-8?B?b3UzV2ZBaEZBcHBHSU5YNzNyZ0ZVNXk1dGU1SnlraVNUNFplMnVaZGNXWXU5?=
 =?utf-8?B?N21BWGlzY2RQMHdITDhvYVZDUnJjVEtheHloRDUwMkdZT1lSWXhLcjVpYURF?=
 =?utf-8?B?YWpaTHJXWWRCcDRqRmdBeEpKVmlmbTRVcVQ1UFE4cU5iQ0xRRnJXTFV4UG13?=
 =?utf-8?B?N0ZRdzZyaC9Rb2ZNck0zZk44aVpnanFkajI4bC9LODVYOUVJOVc5NXJtN3lv?=
 =?utf-8?B?Zmd6eXV5UGt1cG1JRHFDSTNiTVZYYlordDRaU3AzU0dSVC9lWmE0SUNIRW1w?=
 =?utf-8?B?Q0hqeFhqaTgxRXNjYkZEdUN5bUxLaEdFN0Y4T0RJekFKK0NXNThhMFpoVGxB?=
 =?utf-8?B?dHZrOVhDWjFiVGYxdTViUlZreU1PNkF1R3M2MDI0SmZBVFoyTU14aExQQnoy?=
 =?utf-8?B?ZEo3cDVJYVBBbVlsSS9kdGYyVkpVZ0VYKzBOUzlzM2RZbjRqeWQvRUdvNEtz?=
 =?utf-8?B?QU81OExEd2hsUHVnRUpQeUczZVNLS1NOTGwzZnlpWjJnUmg1QzZnZEU3ZmVz?=
 =?utf-8?B?VC91aW43anR6MkJKVzJRYWZSUnlPUnRDd3ExdmlxM1RCV2MwdmRhU25Qdnp3?=
 =?utf-8?B?a3dDUHBDNEh3YnJpelhyWkVvdlBBdFdJVDM4YlVIdldENm9VTnNXYmkvbGg4?=
 =?utf-8?B?SHVjRm5wMnhCaVZKWHJlUm1TMUhrM2xXRzFVRnhQS0t4K25jeXo3T1NQSWlC?=
 =?utf-8?B?TmpDZ2VvYkROY0psTkkzNkRGZDc5NWVGSVUwK3V3UW5hR2xyUGRYZUNwa3hH?=
 =?utf-8?B?alJDQm1LUVdaRHB4NmZoR1lqL1NDdDVDNGYxNVBrZWlOUUpqUnJxaFJWRm9w?=
 =?utf-8?B?SUFmaVhOVnBia2QxY2Z4TG1pQzl5L3RMY1czTmpJclkzbGFRbkthK29ZbmNk?=
 =?utf-8?B?Q3gxSkg5ZFVWVVo5RTVudWw3MTdCN3BhNTBoaVJkcTF3R1ZzbnhtL2F4VUhv?=
 =?utf-8?B?eWhvZCtabk5Ma3VrVDY0UktXSklCQlFSMW5mQ2Y2VlpxSFNyZXJUZDdub3Nm?=
 =?utf-8?B?ZnpyZ3FhaDU2Tzh0ZGxRNFBIMFkrNlllcURpbUppUEpSTFp0VEFUVlNvZkNV?=
 =?utf-8?B?S0RLYzdRb0lId1pnUGJiUXlXc1hrYUlxRGcyR0lJU05zank3TGJvUzU2VXl6?=
 =?utf-8?B?ODYrMGVuR2pob0sxWVhBeDRPNEhPeVo0SHBWeEd4dGxiZGY0ZWoyTHVnUlNl?=
 =?utf-8?B?VE9pZ005QXFSNEpKWnJUUTdYKzJmc1ZaVDI1WEY3dVJyZ0V6SnpOZ0JXK3h0?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2a9a43-32ce-4a2f-1036-08dc819650b4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7164.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 17:22:58.0827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTMZnzoRi4Wdt4jT3J/pHIys5v30BnVephgBezeQywId7XL/NIzwCCMomkB0M0SdOWzJa7teCYU/yeu5AlAzAR1fuHcygdYQwuGtEjKxNbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8269
X-OriginatorOrg: intel.com

On 5/30/2024 11:43 PM, Nikolay Borisov wrote:
> 
> FWIW the usage of this variable got removed in ea4d6938d4c0 ("x86/fpu: 
> Replace KVMs home brewed FPU copy from user")
> 
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

Thanks!

