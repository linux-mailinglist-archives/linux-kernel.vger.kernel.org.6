Return-Path: <linux-kernel+bounces-534910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2D4A46C8C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182AE188D524
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16DD1E1DF8;
	Wed, 26 Feb 2025 20:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MEBG4SZY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD702755FD
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740602199; cv=fail; b=mN1h2HoVVfjVmcFbW6bH+NYGUwietk8TtN+sd/iG6YWUJfb0IZt/ICJB+n9wPOYGnZyfzqbFGAWYm//C8RgiyzLKnumXpcReZWd47ZQSmo2eEQ2vqx8wPk/ez8dwpNOijzxinImS6359gI22jgJSjeb4w4R9tbUqsqXBKyRPHng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740602199; c=relaxed/simple;
	bh=swb4dIl43BX3kPtDBwN9O+esOtubOGtSaBP6OqznN8U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oKbeTt71uJYXm7ufV9Zy3Zqhyt3GjCwZUNyVBklIiN+jiBMM4tgxyz63YaPGsKVxnjj9QFlfB5FydZIcgL+BAsp6h/eNMVSr+mSfduID9RKekAwUmcFRBfcwNlPL/KLm54J8ZEZiLfiXIGd85nu67emj8sqTFFZ081hG6t9Qamw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MEBG4SZY; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740602198; x=1772138198;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=swb4dIl43BX3kPtDBwN9O+esOtubOGtSaBP6OqznN8U=;
  b=MEBG4SZYfbdZS88HSb/g9GvgNE0MNWkPr44Pi7LSbILsP9XPo5FAAhkI
   mdBILtisro+PRxD6kcszaedx/5xUog+GsmfzeQr40cW5IjOOS6yX/qdvl
   IaEstyhGsx+fTLEll+FkcoR907XGSdyaTQAK3F65Uiw5ryoyoHXO/Mybb
   JcoPFX1+rxNJvjXDQUZqd7b748TTxSz3h7gn5fcIEwxTfm7hoj4ahOxcT
   yc4PX8E6JhbfK8AuTBX9VbeiaKYQiwwgrknxzyLZEzB3frnM1a4YriEM0
   RhjIeIhXq5jvzsvID4x5Cjy+WVF7iKo+jBrYtitR8uLWHV6SluHO1YIes
   A==;
X-CSE-ConnectionGUID: TFSELDPGR3Ovp0bnrDYhbg==
X-CSE-MsgGUID: 8KchmLrfR/OVbJMG9fY4mA==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="45252992"
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="45252992"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 12:36:37 -0800
X-CSE-ConnectionGUID: +b4HmiiuSFuiE09TBzlNTw==
X-CSE-MsgGUID: knWBCFL/QiedSHQ66LoJ8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="116988820"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 12:36:36 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Feb 2025 12:36:35 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 12:36:35 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 12:36:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3S00rdq1Fzv3FlGk1cFN5qmFKH1vvuLNeOKSQ5lImh0c8GHWxEV3J2pLLbAfnZaKIFdsA+hh8s6c2NUXfw238S4dnYUKgqhELJqOI+m9121rpIj15bY4un78diIb0SE7jh0vhxPldlhQWzQKhX97m+EOr65cj7TlVX5IlgLfkajlmxFUWTCMTUXknscJKjebuwO3ZcOagDLolqkEYDjhhdxEB9WDoXjb3T9qvJQESOfBj2b/A6Wo+oKD68w7cKnKs7bX/8IEN2t6g3pC3LVk1rE/jtp5PKaCFzTZ7hLfCvwZ860ykbZJICxuPb/I7SDSlB92SvMZKzATu8zXEzsfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvwIFrcwv6Sp19iVlIlP3evIuSWISMysTG01dD3Urwg=;
 b=quQjtjM2WpUn9fW1RmEX3aXmtjBThy8UdCqxKSlv5QMWZjE4ftSZdmSzHVHumeeu2T/bAWub/NS+Ji1bIC7YfQ6ErpWPz2UIafI20H3/kcWaD69+NzK29pCo9eeuOPkCcrCfJ4Xdd6naFzBhcbJbk6lll3xaOOd/cJINk6ZrqlXNcDmBWvNbytNCDtOdqE58R5CjvGn1x94uZoyFCuvxmiFrCl6255GjweaW373SqGLaIXG3olvBodijICjtMZrtgI5yF96jgHOYXhz9Tun1s/rG++aFfnLwOfKEMV8tFrveSDN36gaWzkB79RV8RzxXUBUmEqIzfdIlyKN29K8mqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW6PR11MB8390.namprd11.prod.outlook.com (2603:10b6:303:240::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 20:36:32 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 20:36:31 +0000
Date: Wed, 26 Feb 2025 14:36:33 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>, Ira Weiny <ira.weiny@intel.com>
CC: syzbot <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com>, Barry Song
	<21cnbao@gmail.com>, <akpm@linux-foundation.org>, <chengming.zhou@linux.dev>,
	<hannes@cmpxchg.org>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<nphamcs@gmail.com>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [mm?] kernel BUG in sg_init_one
Message-ID: <67bf7b5167349_41ae429437@iweiny-mobl.notmuch>
References: <20240318204212.36505-1-21cnbao@gmail.com>
 <0000000000009221d60613f58726@google.com>
 <CAGsJ_4xdKbH8v0WaBFo_kDOHPXQnX7zrc43D=+irfzM-=2RxGw@mail.gmail.com>
 <CAJD7tkYA0ZjdjXAx3ZcFtFzAAbZ2+57QLh99o3JVBVSWNtZM7A@mail.gmail.com>
 <Z7ke871WFkYuwYl1@google.com>
 <67bf3ad9ac2df_41ae42942@iweiny-mobl.notmuch>
 <Z79FJ5t5Ed60w--U@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z79FJ5t5Ed60w--U@google.com>
X-ClientProxiedBy: MW4PR03CA0163.namprd03.prod.outlook.com
 (2603:10b6:303:8d::18) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW6PR11MB8390:EE_
X-MS-Office365-Filtering-Correlation-Id: e7d03d7d-bc2d-4500-2e3a-08dd56a540e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dTMvRy9BZmhkUnRYakpwSTVaNXJPM01zdlBEUDlwM2tqdEVpT3BhNG5UWE85?=
 =?utf-8?B?Z1VhMExSWkdKb3lpWGNISG9iVW1xWmJHQjFURTB1Q0N1bEtOMjRxVng5WTBI?=
 =?utf-8?B?ampncXdLN25qWHlmLytIYmRmVkNxSytJN2FVeUFkaFV2RU5sbnEveTZFMGwy?=
 =?utf-8?B?VVZIUUt5YkU0TDlGYldpV2Y1aGl6UnVLc244Y3pyaFpGRGNWOVljOGpMVThi?=
 =?utf-8?B?M0xzaHFreWFEZDM5QncxZERxa3ZzdXhhSjFZTmVpYlVYS3l0bTdmdWpuYm9p?=
 =?utf-8?B?blBBNkZVL2hyM0JMcElBVFI2emU2RlF1QmE5NGVIY0tUN3N3TkJzeUZDcWE1?=
 =?utf-8?B?YjE3SThjMFY5UFN1ZkNsZElTWkw4YjNqSXVnVWVWaHdPSGwvTEhrc0hSN0k3?=
 =?utf-8?B?eDFWN2I3bEhYSnpEWWU1Q0RJVlBZMEZIVG1PUS9oRUhSWVlXd0lqS0VLVS9G?=
 =?utf-8?B?akV5VFNGei9HVitMUTNDVGVENDkrQ3pwZEhiRzN1bVdmTE5HcEJuaUFFR1VH?=
 =?utf-8?B?a0EyY2ZSSlJTMmNPbk5VYnpYUURLZ0VteXFaUW53cWJ1U1QwR0FZMk1rUnRK?=
 =?utf-8?B?eVZYWEVXMDJhNGZYaDlzaExmNmZnT2Q5Zld1MHZtQWttaDhpMWY1TFhJbUNv?=
 =?utf-8?B?WDJZRGg5aFVSZkN0OVhmRUtscTlzN2VRY0d1TitTUDlPcjI1eklxMzNjbWhx?=
 =?utf-8?B?ZUZReWdIcUxITUk3eERhRG1OY1cyOFlpOXRwc1M3Z1h1K0dFZzZYdHBCb093?=
 =?utf-8?B?ZmpET3dnRjBoV09uL05CSUlYRktKQWw3Q0xqUHMxcy91cDRLV2VHNHRwOXpP?=
 =?utf-8?B?TjVkZ2tvWFJWMWk4U2xkVzhwRk5GbmE1djd2RzJ1RUFjSEwxYVV1TzRqb21P?=
 =?utf-8?B?K2tZdEo0K0tQZzR5Y3lhUE5UZTR1NnpiQTJ4VHZYdFVTUmZtL2lSakJXbysx?=
 =?utf-8?B?aVRYcUtLWllWM01DMkFXQS82YTAyMlFtUEVFeFAyQ2puZ3B6bm5tUHZNOVJa?=
 =?utf-8?B?YjRqdWJIbkNoeU5kOXF0ZFpjdDJtNUNubjFoWlhMbjlOSVpNdFdnUHBWdlc3?=
 =?utf-8?B?aHloQVNJcU45dzFRVGNNaHNYb00yM2s4WlFoWFMyWURyWmF3aGt0MU0rQzRv?=
 =?utf-8?B?QmR4cXZ3WEVXMEV1RFpQa3hsWmpGM1ZqdVpPZjRkbjd2VmVLOTZSbTNYaTMx?=
 =?utf-8?B?V2JQdm11WXBkRGkvb3U2blBETWhhcGkxdmdNZ2k2V3crb1lOalRTbnZReGQz?=
 =?utf-8?B?LzlEQnJwWjd5N3ZIOFJDY01rMGhDQzl0UldEeDZCUEprc2lyUWZEbkR6Y0Jh?=
 =?utf-8?B?d3NxeVk2YWFsOHZXNElac1owV2VpWFVCd1lsbDJ0anphcmU1cjI1bUFmb0dC?=
 =?utf-8?B?cGhlSWhKbmlKVEVzZGtrQWVSWnhpUEp4VHkvY3V2VS90WEtNOXNENFB2akJP?=
 =?utf-8?B?TzkzMmV3TktmanYyYzFCWkhXYkZpSUN0Y28wczZLZTJjSkNkaFNpeWExZUV3?=
 =?utf-8?B?ZUwxaDkza1FyMTNmL281N3cvZjZOTEhKcmtLUVdpTmRZOGs2RFA2WXpOZkMr?=
 =?utf-8?B?dlgwSWdYZ3VTS3pSblVSclBUaXdTMzVGcm9uQmpER1E5VXVsV1NPRDkyamRT?=
 =?utf-8?B?T2s2NEM5djhsQTkzWWEwMXU0QVVUVzIybm1TVUdrMUUzOEdmYWN3dmF6dU1R?=
 =?utf-8?B?YVJRTnlZUUl6Z3g3QjVGSDM2aFZJS2pKZEtQRGptenBrK3h3dVdQdGd5Qko5?=
 =?utf-8?B?K1dyN2RiMitCQ3lqZkJjQWZtOWNwMzl3cGdudjJJVzNUc1pXWTljcG5JZnpz?=
 =?utf-8?B?NVpheWYyQ3ZZODM4ODljQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWsvVktFZEcwZW55NmJVS3JnL3BHTDhOR29rVDd2ZWN1N1BWUElXMndiQ09Q?=
 =?utf-8?B?NGc0WEtnS25sUm1SZ21zblZDS0RKT2tCT25EdWFZcEk4K0VJbmN6TjdUMVM0?=
 =?utf-8?B?M1lzUFB2aTN4a0hSZStCa1h5SUdPWm10UGUzdVYzT2RzRjFWZDg2eDRLNUdo?=
 =?utf-8?B?NFd6cmh3ZVJsSnhaVktrN0djaTlIUlFEQkYwcXZXNmQxZGxQZjFqUHZrSnVD?=
 =?utf-8?B?OXQ0bld5ZXBYUGdOeEhFd2dPU0R3ODdnQWNVcVU1T1FLKzJXK2VHTXlCMjZu?=
 =?utf-8?B?REtIUUZBbzc5WEJ2SklaUHRKSE5ZSnFiYUJXZU11d25ub3JkU0dNWm1NcHhS?=
 =?utf-8?B?allHQjJiZDVhU0FBM0toaVU0TUJnWS9NTDh5VlUwQlZOTXdPZnVSR0R6dFlW?=
 =?utf-8?B?QUllVmlQTjBXa1VlTHlFQ0FoR01zbnEzUkZ1M1ZtcjhOWGI1am53aStIZ1JP?=
 =?utf-8?B?UHVvSktYeEs5N2Q3SjBrYjBKQWdrK09YY1lYd3VrSWVpQUh6UWNwcUlLU0VT?=
 =?utf-8?B?MjhqUEM1Q0IzVEFuUzhEUG4zUTljWmZTMU9PV0lIU01qWXJhSGtLYlY1S0NC?=
 =?utf-8?B?RllkK3A4eTdxTW1oU0x2a250R25SKzNDNWNDYkczS0ZOWmhhQncvRFc4R2tq?=
 =?utf-8?B?VGhxUSt1Y29HY2hHZTUzZURTeGVKa3NaaEZqajBMZVJ2V1kyd2ozc0hMTGlo?=
 =?utf-8?B?RE5mT1lmUFpnUUQ4UWdwcXQzcDlpbVR6bi9nVFhGWVduR0s1ZEcybDNtUTZG?=
 =?utf-8?B?a0djV0xVcVVRNldwOS9ONUlEdk5mTzlRRUY2anppQnlySUo4bWp4NEtHVHFr?=
 =?utf-8?B?bHBPRGxPVFVFMDVaTk9RejlvaHRoL25jQno5YUJxcno2RFFRR3Zhc1U2OWNh?=
 =?utf-8?B?VVkxdzc1OWZrVm1PM09JY1VDVmV6SlVSck5Mbm0ybmx6RG0yMDZ3cldxTE9L?=
 =?utf-8?B?VmZiNlRpUG9Ddzhldi8yUE5Ma3B5MWUwaHVaVGJSUUQrZGlWWWo4OVh3WSs5?=
 =?utf-8?B?YThicCt3dG81a1RMVkNqSXB2ZEcvaUxGQkRYWmRnTDUvem50V0wwaEcyeXlh?=
 =?utf-8?B?STdpbjFaY0hKR0JzRmIwY2FpWXJmdGxrZ3lBZVcxTFQ0NkN1TCtTT0pEVERT?=
 =?utf-8?B?WHdHZDNZYlM3TGFZWmtGVUVXZ2NXVzNsUHRtbkttSVZ3d093UVRieFViOTNL?=
 =?utf-8?B?L3B6YUN0bnUzWUU2Z0NtSnZNb0lBMEdDSUwrQW5IS0dSKytNTzVXNC9JT2ls?=
 =?utf-8?B?ZGVhQjBGVHBzRkNzVHFGc3Bhcllaemc2SzFDZzBVR2ZReVEwcDArR2YzbFF6?=
 =?utf-8?B?R1ZBOHByOUY1bm5Nem5nenRWZzVqc2pRSHRHRlFtMlZqbTRqRzgvdFJmQWZH?=
 =?utf-8?B?OXlvdHIycXpoZ0VxYVkrY2pvaDM4R0VUbi83ajNhYytuSFY1TkJZdGdLd2ZO?=
 =?utf-8?B?a1ZEYXcwUVVySDUreXdQMXc0dmp3S0Q4aUZuMUVxU0l6Zk8wQVU0Wm96cDF1?=
 =?utf-8?B?RUVkOGtGNGM1a0UwRzhxa3FGRitWTzZ5Q0UyRFd5blBvaVBDMm5YVFp6cGtM?=
 =?utf-8?B?TTUzaEJHYWh4ZmFVRjYyVG5QNmp0Z0JRdGVwbzdmbkNZQW8zaUI5MDM1Vis5?=
 =?utf-8?B?amU5L1RMMWNWQTdPS1RheWNiN1NzUzFqS2dLcHFOSXJoYnFyVEduaFdiT0Zv?=
 =?utf-8?B?UERWOG9jcFNTbHoxV1ZNR0RxTmgzTlBpdkxQaHFRVlVueVVpNzkwRUdHK2RG?=
 =?utf-8?B?ekFlb2phM2h3dTlHTk9hdFpFOVFnUlU4T2VGQ2VJQ0pMc1l3aHVHYUZMaDZp?=
 =?utf-8?B?dFp1bHU0MHJuQmc5SWxaQjB4clpjdEZxRUl3b1FMU3Y0cmhYWWxlOFAxamdk?=
 =?utf-8?B?WlpFRkd4Z2dqaTNKQ2JEWEpBMUd4QnQ1SEw4akNCT2Z5d2FJclhSWW9EYW1R?=
 =?utf-8?B?OGJkeHU1TCtydGp2SG5nM1d0Sm4ySCsyVHA2YXlGZFlUbXAzSWNaT3hOaUF5?=
 =?utf-8?B?c0d2RjlobkNBb0psNzlVSTB2SSs2S0c2UThNaWl4Tks1SGh0M2JTUnRHVEgx?=
 =?utf-8?B?bTNWTW96WTJKbnVybUM5THE4Yzg5U3JoRHZ2bjIwZXFZY0FKT1RJMHhMeXhy?=
 =?utf-8?Q?K0sBAezfDBOAS9NJhBtC9fvca?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d03d7d-bc2d-4500-2e3a-08dd56a540e7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 20:36:31.5870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZE6pNiw7hQc6mpMj9f6Bly3ZLLXSe/8mHxrgGl2c8R4XAUblj0BPx8HJYLQF4V7un1Zm1+WZegZjgYqn9eyB6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8390
X-OriginatorOrg: intel.com

Yosry Ahmed wrote:
> On Wed, Feb 26, 2025 at 10:01:29AM -0600, Ira Weiny wrote:
> > Yosry Ahmed wrote:
> > > On Wed, Feb 12, 2025 at 09:20:24AM -0800, Yosry Ahmed wrote:
> > > > On Mon, Mar 18, 2024 at 2:03 PM Barry Song <21cnbao@gmail.com> wrote:
> > > > >
> > > > > On Tue, Mar 19, 2024 at 9:52 AM syzbot
> > > > > <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com> wrote:
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > > > > > WARNING in __kmap_to_page
> > > > > >
> > > > > > ------------[ cut here ]------------
> > > > > > WARNING: CPU: 0 PID: 3529 at mm/highmem.c:167 __kmap_to_page+0x100/0x194 mm/highmem.c:167
> > > > > > Modules linked in:
> > > > >
> > > > > + Ira
> > > > >
> > > > > Hi Ira,
> > > > >
> > > > > I noticed this warning is coming from commit ef6e06b2ef87077.
> > > > >
> > > > > you have a commit message like
> > > > > "    Because it is intended to remove kmap_to_page() add a warn on once to
> > > > >     the kmap checks to flag potential issues early.
> > > > > "
> > > > >
> > > > > Do we have a replacement for kmap_to_page()? The background is that we
> > > > > want to pass a highmem buffer to sg_set_page() but we only know its virt
> > > > > address.
> > > > 
> > > > I am reviving this thread because new zsmalloc changes will make
> > > > mappings sleepable, which will allow zswap to drop the memcpy() in
> > > > zswap_decompress() -- except for the !virt_addr_valid() case. We can
> > > > get rid of that too if we can use kmap_tp_page() in the scatterlist
> > > > code.
> > > > 
> > > > Ira, could you please answer Barry's question above about
> > > > kmap_to_page()? It has been a year and kmap_to_page() is still around.
> > > 
> > > (Trying again with Ira as the main recepient just in case)
> > > 
> > > Ira, could you please help us out here? :)
> > 
> > Apologies,
> > 
> > No there is no alternative to kmap_to_page().  The work I was doing has
> > stalled out and I really don't know if it will resume.
> > 
> > There are a few folks, like me, who would like to remove highmem but every
> > time the subject comes up someone speaks up about a rare (mostly embedded)
> > platform which really needs it.  So I don't see it going away soon.
> > 
> > Removing the warning could be justified by saying that highmem removal can
> > be done completely within the kmap calls and only when that has been
> > completed can these calls go away.  But generally kmap_to_page() is not a
> > popular call and it might be seen as a step backwards by some.
> > 
> > For example:
> > 	https://lore.kernel.org/linux-mm/20221216070621.GA24832@lst.de/
> > 
> > The patch with the warnings was a stop gap to ensure current users did not
> > break.
> > 
> > Do you have evidence that the extra memcpy is bad enough performance that
> > you could justify using kmap_to_page?
> 
> It's not about performance, it's about cleaning up the code. Currently
> we have a special memcpy path [1] with a huge comment in
> zswap_decompress() to handle zsmalloc not being sleepable and the kmap
> case. The zsmalloc case is going away soon, and we'd like to remove the
> special handling completely.
> 
> Using kmap_to_page() will allow us to do so. As you mentioned, this
> would not be blocking to removing highmem. The call can just be replaced
> with virt_to_page() once this is done.
> 
> If this is okay with you I can send a patch removing the warnings in
> __kmap_to_page() when I start using the function.

It is fine with me.

I was just thinking it would be easier to justify adding a caller if there
was something like a performance boost.

Perhaps Christoph is not as concerned these days.  :-D

Ira

> 
> [1]https://elixir.bootlin.com/linux/v6.13.4/source/mm/zswap.c#L1012
>  
> > Ira
> > 
> > > 
> > > > 
> > > > Thanks.
> > > 
> > 
> > 



