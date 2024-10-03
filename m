Return-Path: <linux-kernel+bounces-349177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A51C98F23A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C00FB21B1B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA0E1A0B07;
	Thu,  3 Oct 2024 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z1ozsgHm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52079197A65
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968392; cv=fail; b=OoYi7ffrixPalTFXUgcEO9F4d2CPAbhbeMAiDAvUhs9F+ZE4QKwujEmpTjbkiTLHy7TgNZe7OBdAePkCd1JZqBxA6GTI90kPAEKG/fWWw54y8/Cy5mopiZqZgtjDgg9gtjnMaSLlXzkkit/Zj66F2qPL19rsDvhiXi/47Fp8zqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968392; c=relaxed/simple;
	bh=R+1lnUrxWP8cM9NnRXv/tt0VRWwkhhe4ZlV8b0YDTng=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mSHM0xg4mgrGrbiPvUJXQqb4kyKBp+Sow6BhhoyYG7xGP1OqviYvV4JIVLRf9LGYWiN3EhHvaQsdXkUdqLOE2dfZ2jcoWqK1iz4aORB3PkHme1NggWL2BY56A8VfBvfd/SI9fU+BlwIJsVRJepHI1Lufg8zi82oZRx0XcHGlVRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z1ozsgHm; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727968390; x=1759504390;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=R+1lnUrxWP8cM9NnRXv/tt0VRWwkhhe4ZlV8b0YDTng=;
  b=Z1ozsgHmtB1IeFfOJaiHFJuMs2c9rZb9WjCATqbtG9llP0eX+z0rNF/M
   ll+khkK4dtdhtdnm6XSVdNtPmFv44HY8nEwAxSzAJdeZfs0E0uNHTcFmv
   oxW4jE+TjyMayxFv2POhmK0wsinhQXWXMaXmh69hHbANv9iNO6P8JTqbZ
   CjK2CkmTudEouVBycZ3xPZjRmp2weuGBQpqzY05xi4ZlBAdRtp5mjaWNo
   nmY2bnEog6U3GMM9SWtoFuKvuFZkI8z6H5XA6SIw4NuQAv37Eq40GFLPS
   Y2VicmHxE5Ov+j7pdVcdAdznjAVHfFv65v0DArU7k57MF3Xo4O1v7RgHU
   g==;
X-CSE-ConnectionGUID: eiZrX6ruTeOB+15FR+gKZg==
X-CSE-MsgGUID: WE2TE67BT2Sf8S27hNWPwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="30876004"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="30876004"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 08:12:00 -0700
X-CSE-ConnectionGUID: mZiz9t7/S/6kDq/U2UVAjQ==
X-CSE-MsgGUID: nz8gx0rUTpqbHgBjAPiEDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="74623640"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2024 08:12:00 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Oct 2024 08:11:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Oct 2024 08:11:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 3 Oct 2024 08:11:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 3 Oct 2024 08:11:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ve4CaEWCN/hIAJ7/LKoT5iMrlg0yMMmP48wXub6G1pnqjSsUUIdcaZfrL6obb+SFayK1H3Os1HMoaG/2y8260Q6RqyebbtBtU2puBphRvcnkRanPEJ5G7UH0MfTmXPsnkAn5k6m6Ngsop1MWObXu2AatzNngyv/CG3JJoKjeDdR6aM6SD1n8Eqm7m5r2vVH14J4dcT+7lVdYnA56797EDODZPM+UOsCELzjQWzzdKNUDkjWR0ZHWbWEY7CBliiPPok465JbInVeP3LhxHwF7kzW1nAl3ujVXIk42ihNNmxs7OR08byUEm4aige7E3MYE57baC/INb/UOEtOqw1YAZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cpa+jI7gpVDySuh7M+qmQ3bSkxKyeg2labuk0O/JEwY=;
 b=xhZNDdj0sZ2b8owrA1OwS01nFvDORSCBVSIaQD+ys0kQTIKcG/xDkuZ6i86w7JxDZFWsRyfnOKcJbUM9dOZOd08f7iXhC9MwgaM9kiaj7UmhUrkY/WJzAeZGswASmarHq6s/ufVD4dIhn2KYYr2m2pbpaRmIAEk3wCAWhpr9J2TPYYaLkt0FcF3F+zxn/shthQpit0ivXsYQGnRvLgVPK5ItDqbCl+9UYR3FDluFWbMQb0Qj+tUKRl3gFR5uSnLNIGiog8mpllAV7m7fGp3uDNW5hyo+qrdn34iKcCOodFdSAQmpoX/lw5/sIxEW10T9AWdyvhpalEI5D96a01csBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by PH8PR11MB7071.namprd11.prod.outlook.com (2603:10b6:510:215::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Thu, 3 Oct
 2024 15:11:55 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%3]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 15:11:55 +0000
Date: Thu, 3 Oct 2024 23:11:46 +0800
From: Philip Li <philip.li@intel.com>
To: Nhat Pham <nphamcs@gmail.com>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>, Yosry Ahmed
	<yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Chengming Zhou
	<chengming.zhou@linux.dev>
Subject: Re: mm/zswap.c:744:52: error: 'struct zswap_lruvec_state' has no
 member named 'nr_disk_swapins'
Message-ID: <Zv60MrJ8jsmRTCwp@rli9-mobl>
References: <202410021530.DnNbPqfN-lkp@intel.com>
 <CAKEwX=Ma9usQBge8uKvin=+GsuRDgJrDYTthzLg7zhtbLMPc8w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKEwX=Ma9usQBge8uKvin=+GsuRDgJrDYTthzLg7zhtbLMPc8w@mail.gmail.com>
X-ClientProxiedBy: SG2PR04CA0154.apcprd04.prod.outlook.com (2603:1096:4::16)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|PH8PR11MB7071:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c706284-08e2-4889-621c-08dce3bdb7e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ci93cGxLNjhRYytwbHhPU2FuanF5OFUvUHk2TzB4S3VuZW1nV0JKejQ2bk9Y?=
 =?utf-8?B?NndGNExwWTFWRUdSbXo3cG5IWmxjbXRMeG1Wam5xSS9PSWZoaVpDOHZFRnRX?=
 =?utf-8?B?YlFDN1lxeWJ1S0ZBL0tPeTFiMTZiVGZKNU9NSFdJeVVQNVU3TnQwQmI5K2sx?=
 =?utf-8?B?Y0FYTWdQcXFUeGI1Mkh6T0xNRlFMazFseUh2aDNXZWRBQkorQnJNOFFMQXhE?=
 =?utf-8?B?N3FDMmtHQSthV1kzbk9BZkt0eFZHb1V2TlhUcG92S0k1cjhJOVkwUGJVZzZL?=
 =?utf-8?B?ZDlhT1VDb3B3VnVqZmYyM1B6UEIwbThEZVNqdmdjelVzaUZLbCtIRWZnUXhn?=
 =?utf-8?B?cDJOZm5OVHdleUhzL3pjV2RteWNCVGVwZGFLZGJ0SzR1RlhwTXQzNU5OUzls?=
 =?utf-8?B?RWxNUHJjVDZxRmNTdG9vRnVKeENkc2dYd3NKVWxwTHhHZ0h2WGNYdC8vSmo4?=
 =?utf-8?B?aEpMa1Y3Um5iaG1LSGNXSElXcnZQK2RnazhGZVNTdjBqKzdjOWViWFVhYjN0?=
 =?utf-8?B?SVA2eUROV0JsRURYQzZPVTRneC9GR0RyTnVGZW5hRUx2b1U3WWtUNTY2d3Nh?=
 =?utf-8?B?UVJpRWJwdGJSek9IK1Jmb1NURVRuNmFnNC9qRjNpL2NDMkVVaHpCU2c2Kzc5?=
 =?utf-8?B?NmRFY2FXN2ZGWHNBVTdVR3M5N0szbldoYVFGNkpUdktjUW02eHV6MTN1bU5y?=
 =?utf-8?B?RlZMVjJPSnkzNU9sWXFaaG9MYVI5OWhxdVNWRGU5UlJOQjFsZWRib25xWVU0?=
 =?utf-8?B?Sm5PU1BmUloreWFPZWhpM1ZvU1NncmFzUW1lWlJTM1Z1UE9qQlVUMzhqZS8z?=
 =?utf-8?B?TDNiUncxNlFhZEk2Q1A3REc4QXZQRkRQbVp5b3RSVTdxcTNWVzhnRXQ1WlRL?=
 =?utf-8?B?RTlJQmJYS0RIU0VjSzgyTVhGQzhPdWZlTFhreTlMN2hhM0JraFdReit4OFk5?=
 =?utf-8?B?NU5qR2ZJc0NtN1RHWDd0eUx3cml4aE5MUWRIN2dqSmdIZ3lOWFVBckRjL25R?=
 =?utf-8?B?cjdQblc0cEJ5NVU5SW1ieGlYRzJWQlkybElobWJzZE1pWksrUzNjdm04b3ZE?=
 =?utf-8?B?a1FrR3k2Z0Myd1Y0WTVkQnZsNEY0WE80N1F4TkhDSjV5ckNML3hGalc0ejVw?=
 =?utf-8?B?bEJzSy9rRTRNT3BXeUlNRlBkcU1oenBFTW0vMmVsZDhlay9Va2VjcjhMcHd6?=
 =?utf-8?B?aG80MW5aY3E2TFVuM1ZZZm5UUnhsRnBZcmtUWkIzM2xQYVNEY2wxbTlMbU1k?=
 =?utf-8?B?OWNWMm96cWtOZTl3TnlYbXVJZDdWMi9UQTVWOWhUaUZxU3g3YWVkMmphS1hh?=
 =?utf-8?B?cFR1dStEclN3eEFtSG1Pc2R4MW1PRmViNEhYNXRpcVB0V0VieXBOMHlHT1U5?=
 =?utf-8?B?ZVpGdmpReXNhaHlUeElRK3ZIVkdhSDA2RjAxUzBZMm9mTE1FQ3orUDNpdVVw?=
 =?utf-8?B?MWx2UUdEVER4LzU3Tm5UQWlNazlRQnp4eldzTjdxTFhsbThuU2Q0OTkrMHVX?=
 =?utf-8?B?ODhVcWFnd08xaHNqc2dmSGpnVzQzSk9DZ1FQL2JMS1RQWW5xbThxR2FGazMr?=
 =?utf-8?B?Qm9LOUFGZUo3b010elJNQkJXOEQyd1c3SWFCdmc1bG85UHgxYXZmK2k1aGsv?=
 =?utf-8?Q?YJZYOWCdXD87JH1u1Aj5v5n6rt4t1eOjVMTPD7S/dNQ4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enQvWStkMkxKYXFBbCtCSHBuMk5LbForMHU4T1d3MDBuUm5reVdSNExoS2pZ?=
 =?utf-8?B?S0QvMDVtaTduajZ5QkszQkNCWHF1dlhjbUpjVjE0Zm1JOXNEN2V5Vzd4aS9P?=
 =?utf-8?B?bWlxY1VEQTFsbldJR1ZpL0hqZlhaOGoxY3BneTloVEkxSzNCNTllaE5tM1NZ?=
 =?utf-8?B?bGxKTStGRFVPdGx0OCt3OEg4ZG1BNXNOU2xoczBWaDFoVUV6ZUxjMG1QR1hX?=
 =?utf-8?B?Z1lOUnFXTm1LUlpZUVZCRjREM2pHcE9aZTYyU0VZV2tHcWpKK3h4Wm5ja2JR?=
 =?utf-8?B?QS91emhtb2czUVFrUUk2QytsYTBldzZwMWhKcjdnMEc5SVhUSUthdHZvK1p1?=
 =?utf-8?B?RzdDTzltdHdGUUg0eUdFVEZnZlhYZ28veTBldnF2VEhPSzdJeHhWVkxnbHIr?=
 =?utf-8?B?bCtFcEJZTGY1T0Zad0sxWE05TVdORnhTVFE0Y3VTUmVWSzE1VG1GNEFWWUJQ?=
 =?utf-8?B?aFd1VnByOGJYWmlpS0ZnZEdna1RSMzB2UThYM2p3V1FUUFR6ZXdoZFVRVWZZ?=
 =?utf-8?B?RzBMSExRTVZrOUptOFVRdkovWVcvQllHaGsvS2hoV3ZGOENDanZBdWN0eTVt?=
 =?utf-8?B?ZmRLZmYrRVVWa2RWQkxqMUptUUllckJtOSsvcmRqZ21jM1dTN2FtMFFIckZp?=
 =?utf-8?B?NzBpZkY0MkcxMU0xMWN1aTB4VnBHL2ZneWcrRzVlMStWSSt2akxqTnRUcDhG?=
 =?utf-8?B?cTE4a3lYcDdNWDQyQXFtSWYvZThUaEoyL2ZZZHQrQmpvMlBGU1Z4bjgrRElH?=
 =?utf-8?B?aGxRK3FlYkFZZUh4dWJQR2lTdFRhZVZRbjVaejJaUTdKN0czeFJId0RBYlVt?=
 =?utf-8?B?eHlFL2dNR0NmeWJ4ZVdyUzluUTJNVmNocGdDbjdNeENSVHJnOFAxeWY1RGdF?=
 =?utf-8?B?VDk0eFh0THhINVFYc0VQbmJJRTBhWlZzSjcydTRSbEo4VnBXQU03RTZqRC9x?=
 =?utf-8?B?NitkdHZjNFp2Q0NRUTlWUlMxMi9SditpclFoa2xXQnNqRFlwMFFEbVhXZWZw?=
 =?utf-8?B?b3htUTMwQXZoSXpSOFFSMDlWeXNBQmNnZ1p4VGc3MWNVN0Vhejc5ZmxUNnkv?=
 =?utf-8?B?TFJQYUdVT2JMdGR4YnpVQ2ErWFdXMnFEMVQrSTFrcHIwQjIvT2NTNDRyVWt2?=
 =?utf-8?B?b1RZZlIwczdETlB5WkZENEF3QmFPME5ZL0IyaHArY1l6K0NFUVppaDloVnkw?=
 =?utf-8?B?amhKa2QrYXZod1l1Z0NyL2pyZXFRa09TeHduNHhFdmJFTk1nTDZzZVlIQUNq?=
 =?utf-8?B?aFIxaW9DSTFOQU44TGJFVUM1d09Zbys1WjV6SHJLWXZteXIzZEcrKzJpbkJm?=
 =?utf-8?B?MFJsNlAvenRZa0VPQUlTL3kwTTRqRFNVanJHdUZJZStHSE5QM0s5d0JoYWVC?=
 =?utf-8?B?Z2pULzdQRTZoSmVZeXE0WkFWaU9zeEVvWEljaFJLY2tGMktCWTRMWEZZYzNI?=
 =?utf-8?B?U0JyTzQvdjFmNkFkb3FIUWRXbnUwNld6ZkVFRWZGbjk3Y3pUbktQNXlKaUds?=
 =?utf-8?B?eEhES0NxYWxzUFIwbStudmVSeHFLbzBjcitRb2hKVmJhUWM2UTJnS3RBTzgy?=
 =?utf-8?B?V2tYM05ZWGJsSUtNQ0lnTXdhNW9uMWFPbmoxTWc0Tm5rSWl0a2VXTDMvUXlO?=
 =?utf-8?B?MDhjQy93QlhYd0hObFlCR1R3TXU5NTkvMk1sREIrWS82WUhGcFRteEJYeHJh?=
 =?utf-8?B?bGFCN0Q1SU42WHF0VGQ5TWlMRC9Xajk2VzJveGJDT1NQSHZJWGczWFFCSlVN?=
 =?utf-8?B?eTdvUytFeTFYMkJpSGlLWmhpcGdLVXgrSDVQT0RLZzFMSVBZZDJLTUhGVlBy?=
 =?utf-8?B?OHpJS0RETm9CS2hMRjBESVp6TDhTWUx6ZFFSa2JHR3AvVEE1MkdZeWVVY1Jq?=
 =?utf-8?B?RUExNkdpQWxNaGZGdFFtOGp6VnMvaUdzUm1RMVhXNjBBS2crem9ENXNNNERJ?=
 =?utf-8?B?bi9sbDZ5UnhSM3g4elJ2YngvRHhPMTFOZCtaK2oyS2RaSFlFdFBWbnNyUjVo?=
 =?utf-8?B?SGpBTWVRTFdCV0hNWGtqOUl3anNMTm9LTzlyMUZlRlVhV0ZRUDNvMFVGY3FS?=
 =?utf-8?B?enQ4T2JoZVdXeUJ1R09lVUMvLzRLSy9ocWZoNDdiTWxvOWpKUk94cE4xcys2?=
 =?utf-8?Q?hftfOXJm0d2QN1p/VX1CYicFp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c706284-08e2-4889-621c-08dce3bdb7e6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 15:11:55.7184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AWi3efWkpeADni32MH0YK+Yzf0lDfI8j05SrZoM6x0lRYfY2o5GIjCpU2nsaS5kYBnyo+rM+7LWFmgit03HsPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7071
X-OriginatorOrg: intel.com

On Wed, Oct 02, 2024 at 11:13:24AM -0700, Nhat Pham wrote:
> On Wed, Oct 2, 2024 at 1:01 AM kernel test robot <lkp@intel.com> wrote:
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   e32cde8d2bd7d251a8f9b434143977ddf13dcec6
> > commit: e31c38e037621c445bb4393fd77e0a76e6e0899a zswap: implement a second chance algorithm for dynamic zswap shrinker
> > date:   4 weeks ago
> > config: x86_64-randconfig-r133-20240215 (https://download.01.org/0day-ci/archive/20241002/202410021530.DnNbPqfN-lkp@intel.com/config)
> > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241002/202410021530.DnNbPqfN-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202410021530.DnNbPqfN-lkp@intel.com/
> >
> 
> I'm stumped...I downloaded this config file, and used the same
> reproducer build commands, and it built successfully for me :(

Sorry about false report, kindly ignore this. The bot side will look
into the detail to resolve the issue asap.

> 
> Fellow zswappers, anyone managed to reproduce this? Or is this a false
> positive...
> 

