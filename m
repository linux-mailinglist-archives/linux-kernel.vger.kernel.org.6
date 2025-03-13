Return-Path: <linux-kernel+bounces-560531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D316A60624
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 00:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81299169EE3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847631F3B91;
	Thu, 13 Mar 2025 23:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mfLVKSCA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524EE1F30C3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 23:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741909706; cv=fail; b=kN7F0O9/KB9wa8biwqHVAgHOe264wwB4DwyLMfgsUYd+VgL21sC/HGyLj5LVU68nuftA1eYLAPeB1z485IzcHF9CgwqYEY/aV+SoqLbtNfStRRcrBsKjO5cn1VWzu0Vh3snuZH3rM+ES/hmopDPIbljYtkdVC4qZJGrh2TTHq/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741909706; c=relaxed/simple;
	bh=ArF3F6C8DqQtR1UHTPiByRu8vvdcfPKIQsRDx1p+o38=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qHwbDO7XB8aS0f5iNOPgAbkW3VAQlMOzttGp9hnxoq0EaOwePrgrBdCj1HlrkdXNbDnXfBBgvspK3D5HerZPnvJeUCZmONf/dke1yEfbonBYfc1+dnhhSAyLcb+kGnxrGycq3PnrnfkV9l4SgMH6UFOAP2T1r+BAfBwNbvx3ccg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mfLVKSCA; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741909704; x=1773445704;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ArF3F6C8DqQtR1UHTPiByRu8vvdcfPKIQsRDx1p+o38=;
  b=mfLVKSCAiDHVsv29yweziYhaG4wphAjSmzz/zVmrvlrLRbsFusuhS6rK
   QSGA544DfUw4qWapWCIwmzsa/HDUBWvtzgLJoy21HIKRLP/CoyMoizMvA
   sWLdMkoPmJr+aBv4vwEJZYFy0/hxCg6Yibub2wdH6oLUjcTlEWQ2fgvVs
   IO68fB/XO3OiL6AmKd2/+2GVYwctDQWCByya3ObPyjSa7KEW+4J8h4gPs
   487Xh+9o47UIwnyzoBw6+xSw/eP31aSC46YkE6++5CyuNsyb1dKCveNzC
   HwUvsgF8zFzd78SCGikTkHmSw3bd0F+pnaMI/TvJpbaFPeTGYHVbPYQQs
   Q==;
X-CSE-ConnectionGUID: 5gBqQE4xSRermqzB9ce+7A==
X-CSE-MsgGUID: zEqLbfUMTy+gueKk43juww==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="53705418"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="53705418"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 16:48:23 -0700
X-CSE-ConnectionGUID: ZY2/Y7mzSMeOFxPLoisXEA==
X-CSE-MsgGUID: CFhpIeT4Rx6Qh54du7F0kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="125297153"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 16:48:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Mar 2025 16:48:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 16:48:23 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 16:48:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0vyw/nQCvmJgKrk5AyqW7O1NXl1DTRbTq5Gy5JXbaIzl0+3PRSwRkaP9vJd07n2d7S8jhNUMYXL8Lg6QUNE6iDq8C/ZqKFugILqfGlt4FTPX6xlbhdzp0pwfmGcuZRWE90uj2a0rOf2ZSGoM7CR/mRTkZZmZbQy+Jzkae50ZunA9C87OsU92Mkc3UgADEBSwvCbl0HNjGwrb7OTAASDFIC0qPtuog3KlY6VZ0548F/p5p12rGeBRorki8CPSbbjDpWoEum/98EZtCn1kx+YUedcDcXmv/nv5TFBW17ht58vmWa7V/PtBONt+/BXmbVxrHZyod/CloBz/9dl8SXSxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4yX1AXeZo9rYRGE/t2reSHj0aHk0KWoApiYPl2Y+5c=;
 b=sc1cwvaFoNQvNmfEToyBGnhMGFUQqjn/bvD3Z6J1J+KtfNJSnfE+7/DcOkzBe5MzgDY2BS/lX952q6KIoZFOx/W/D0OAFvn/B9QISc6jKqpUp2xAuNeo1xBJdimffzpZz2c8KZ77UA+hfs+OZ7ZkLav5LhMuZy/Nt70ePVUW2k4n3XkcfcgtlzFPfChmt9XlksqS42A+kbml7s5P0G0eXsw2OUghaDGJJvZTiLg7DdeJvtQZyeVI8OzQA9cCWNlldCxPth5fzlb5DlUMWkO6iff3zK/sxQaZRBu/FlGDOPEdm5oCA3T6x2KaIvV26RXcTAHzfrT4liVG1vvswTz7fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by PH7PR11MB8252.namprd11.prod.outlook.com (2603:10b6:510:1aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 23:47:52 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 23:47:52 +0000
Message-ID: <a30872ce-3acf-4d6a-8d96-c073c6f33895@intel.com>
Date: Thu, 13 Mar 2025 16:47:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] x86/syscall/x32: Move x32 syscall table
To: Brian Gerst <brgerst@gmail.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>
CC: Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, "Andy
 Lutomirski" <luto@kernel.org>, Juergen Gross <jgross@suse.com>, "Boris
 Ostrovsky" <boris.ostrovsky@oracle.com>
References: <20250313182236.655724-1-brgerst@gmail.com>
 <20250313182236.655724-5-brgerst@gmail.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250313182236.655724-5-brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0042.namprd02.prod.outlook.com
 (2603:10b6:a03:54::19) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|PH7PR11MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: 222ce090-0f14-4496-fe85-08dd628977fe
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWNvbkMwS3c4TjFoOTdTVGpwQVVQaENqbE1ZcGxEWDJvVmw3RXhCbEJmMm1j?=
 =?utf-8?B?dUhBQVJFaTM3VjMzTlVrbitLVTdmUWlWYVpMV1BXNmpVd3hOaStmNkJ0UFBn?=
 =?utf-8?B?ODZEb2NTOVJ4L3ByLzFxOEhQOU0rR1lyNW5EbU0vUFRBOG8zbExhcFBEMWJu?=
 =?utf-8?B?TWxhamtRSlk2N1h5YUVUWDRINUFMYk40cDBlUnVnK2tINUU3cnNpOXdvbGRZ?=
 =?utf-8?B?MGtRa05FR2ovSTlRalBDaWlVWlVBQXNRSGVUVSttRVd4MHJtM1k1UkRFcVF6?=
 =?utf-8?B?d3FKZmk2LzdhVVYwSnlKdFhPb1pTQXYvNjkxQ0ZtczZ2dWVNdS9XMWdyeHVQ?=
 =?utf-8?B?QWVJa2NDcWFWWkptS2M1QkRxMUhPdVhjcVA4NVNDRU8wUXBTUWRZbGw1dFV1?=
 =?utf-8?B?cVZzNStjSDJaVXQvMnpSMnpYTUJDeUVtQk1WVnhEZ0U1NlM3bUtZcVFoWFhS?=
 =?utf-8?B?VmJ2VzJLWXNUUGRaVFd0TlN3RWZOcVAwenJRSFJ6dlhkczQzeFNtV1FacGlZ?=
 =?utf-8?B?eUNhaUdlR3l3aWt4eFJpV1hRZTZhTStoUzVSVEtVYU9NNEJMZXZJTHYvSlN1?=
 =?utf-8?B?UEg5RWx2clBkNFR1dGxONm9QYjJZc1hQcXdkSlVXOGh0cGxvTWNDbkQwdExU?=
 =?utf-8?B?TDVwNzY4WDFiT0ppSW1FL0RhTWoxWHVUYUw3aU56cVpMZHY4T2xQOFhnOUdJ?=
 =?utf-8?B?dEdIOVJlcm90Y1VjUDV6Tm5QdHlJT1BYclc3STdtNmo5dnU1dllUcVVhOHRu?=
 =?utf-8?B?amZ2MGJtcnJ2cmd3bm1ERFlNaVBzME1qWWdHZDJRWlJIZmlldTF4eU1YT2lD?=
 =?utf-8?B?WG9idGZjclk3VW40Y015KzFXb0J4bDVtMmJ6Sk5rejFjRURENzNwd3hxTFU0?=
 =?utf-8?B?OEtqTFY0MmpVMERaMEp0Z2xpWkZtcGZOQWl4SlBhOEpLR3o3cy9rbXRHUStp?=
 =?utf-8?B?YVNzOUJ2QTBjREJmV0J5NzdBZnVGVGk3V3BpYkE5SVUxcE94eFZvWlBFbml6?=
 =?utf-8?B?RzE5VFV4ZDVLTEE1c0VEZThYd1JWV0FpelVIVHdPNVUzSjFzVS9lYzhwc2dZ?=
 =?utf-8?B?SjFaNk5tbnJlM1o4RGhLYWtvUnVvcTNYNkJGYXhka04rb1F3bmZRMDM5M3JH?=
 =?utf-8?B?Y1FPNjNVZDVJcjR0SXFubWZnRXlWQUJNU1ZaV1dROFpQdzFwVlFqZzByd0Y3?=
 =?utf-8?B?QjJKV2JrQlk3U0xZQVpqVlBnSmJvK1lXQVVOMlVFQUN6cHhFd0xabTlkMi9V?=
 =?utf-8?B?QkJTdGJROG1BQXZZaXZmYm9CMGRaWjd1YmJUckxMUFhLVkZMbEt4OEJ2VmMr?=
 =?utf-8?B?ektIdGxJc1NQVlJwWWc1dlF1T25YUE1zRGhXcGxNQVBUajN2eGh6dUlUR1Ay?=
 =?utf-8?B?K1hJdUxWQjVrTTV4TWhodkdNdTh3OE5HSkpCbTF3SU96REwwWFNuYnJldE0z?=
 =?utf-8?B?cEpLeW5hSWxaZDJ0V0hZZXZBSnZqVHJ3K1U0QXIrSzRUL1dGSTV5V3RhUmFN?=
 =?utf-8?B?dGkxS1RQL0NHMlVCOS9hM3lRTjlQNndLVUdIeFFLNUdpZkEzSEZ1U3FYR0lq?=
 =?utf-8?B?VVB4SFdtY09TVnFQdW1mQmVoeHFzMHJWazc1dUhHTWxvMFFLUHN2d3ZmRXBD?=
 =?utf-8?B?Z04zTjVyM3hETlhWQnVnWkpRcGh1aXhPVWVBNHAzTlZjUDhQTW5haWpTb0I2?=
 =?utf-8?B?TUp0ekNxVXphaFhtcDV4SjhHdTBYWCs5Z3hQR3hucVZidmNaMUlicE55aXBs?=
 =?utf-8?B?cittOHV1SEF5dU4vVGoyRHFNbVp2L1FBa1pqM3d1L21GUVVVSjdmSUpCb2Rp?=
 =?utf-8?B?YlFlQ2ZOMXpDcDAweFZid0lTNGRucWJ5T2pnVHdYWU1JOG1kSXM5dWRySFFV?=
 =?utf-8?Q?FacT57D1yvexD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkJES3QxbVRiNkhNU1l2YldzRVErOU9kc1A5ZjZNRTQ2T3ZRMWhFNTBuQ1Bw?=
 =?utf-8?B?QnljMlZYRWdLS2xKNmZJbjU3bGpmNkIrSHdoY3pUa3E3blNuL0ppdzQxNEpJ?=
 =?utf-8?B?Tzd6NzFUUkpIcXlKb1F6VVVxb1R2d3RsLzkyRVNoWG9wT2xOWlc0TWtmUGdZ?=
 =?utf-8?B?ZjcxYU1qRnpWMm1jWEJPNkN0M2xzZDBrWkd1SUlvL0w2T2FRamRzVTFtOE41?=
 =?utf-8?B?MmxjVThTMlIyRGRsb01nYVRpelpSL2JyUFZhYW9YQS9YdEVzQ2JwL0RKTWc1?=
 =?utf-8?B?SVFGQStrWnE2WVkvWVAwTzdPVkhESDlkWEt3Wk9WRkpsMWxEZUdhcGpMcVJl?=
 =?utf-8?B?WmtudEw2VCtydjRpRTQ3a3I2ZCtjMWUzMTRXUUQyaG1YYzd6NGhnOERUVXBZ?=
 =?utf-8?B?SEZtZGpEa2RLZ2NSUEMvZDgyQ0JRQm53T3U1QjVjTDdiOVo2MjRBK1lxbVEz?=
 =?utf-8?B?TW1IVFpmQVNkNTZJVU8xbmVUa2d3d25IS2xFY2JmNWR6Y092Y2JGWVczSUNB?=
 =?utf-8?B?VHk5UzVqZW5NTi85SkRNVzVGY3VSanBjbkR2UFI1L0xqaWh5RmJyN2ovRTRa?=
 =?utf-8?B?cTQ3Y2toeGUwalpoNWhKOUpnc3lVeXdnTG02OVh1eWptZTgwUXMyclpiZVJk?=
 =?utf-8?B?bDZCRGRKMEhicW5BR2grSlRHNXhqK2JqL0ZFY1dxbmRETmVLajhGeFhQMUlY?=
 =?utf-8?B?YW00aGtwSStZeWVVRVRSMFpRVnl2STRSRGkrdm5vdCsvMkdsaW4xSml6cWU0?=
 =?utf-8?B?RTBDRmFYc0wzQS9QcWlOdVl3bjl3MndtbnBRR080NTg4K1ljZFJVdms2eVVO?=
 =?utf-8?B?Q1o4WWRWZE9lcVl5RW5aeFIwU2FFa1ZwRGJnWXM1SVNiTCtVdUUvWjdHWXBI?=
 =?utf-8?B?R2NKdEpXR2wzeDhxdzRST1ZBWENNRm5hR1krd1lvOUJiMm5adFdERkpHZC9n?=
 =?utf-8?B?R2pmOGtvaDdQZXRPQlRuNUYwRy9GQm1IUzBzenA3dzVLOCtCTE5KaE8waGdI?=
 =?utf-8?B?R0hsajhvTVA3UVlrVElFbWhob2xESjlRUlR5M25HOFJUWGx3WU13MVdyZkhu?=
 =?utf-8?B?T051RmxPMjhiaFJIRUpjTnVYUjlWblN3R0Y0eEM4a05mV0hiaDYzd3pGb2pS?=
 =?utf-8?B?eC9vclBQbGZuS21BMnc3K1M3RVdTazJ5YmFpK21tSDdZWmtGUUFrbzRZOUZs?=
 =?utf-8?B?UWc0N3NtWWxYUFIwank4cFlGZ0swU2Q0czhja3RoTVZ1RERGd3hwUWFxY2xz?=
 =?utf-8?B?MXQ3Z3dzNHprR1luamNOVDdxU3Q0cWRPenlxcFFCMHBuL2ZSUjF4OEhScjlu?=
 =?utf-8?B?OURwTGg3emlDc3EzZGtpdzdwNkZEU3diVVBYeDJSSFlvWnhlK2hYRkNaaUxC?=
 =?utf-8?B?WlBNdlRsSHJLQ3N4MjZRelAwMmlPYzY1d2FxMHU3NUNEVFhhaTNobGJ0UnBv?=
 =?utf-8?B?NXV1SlhtSnIwSllRVEZZclVoMC9GZUNrWkw4VGFHKzZ1L211UG5iaFRYdE5N?=
 =?utf-8?B?WnBBczNhK1dGRFpCaFF4M0tnM2ptR2U4N2JKdFFiWTZLcmlLRXlLR3FMMzlX?=
 =?utf-8?B?alVNa2U3Y3VYRlphVzRlY1hPYVhuZkt5VXloa3ovMWVqYVhHOENlak1IZjYw?=
 =?utf-8?B?NkhtbU16eWFBQStWQWxUQ29TcFF4eE1UK0tQb0RYR3lxdFRKRnBkLzdUS0RK?=
 =?utf-8?B?NHcvN2tKbWxMNTB2WGhHbU92b2tER3ZmMGdhT1QzR25Wd25ucGpMR3BaTFdl?=
 =?utf-8?B?OENOaTR6T2dyN1BNUE9uOHhFMmJEajFuQjRFUGs5RTBiTEg4VkJwNjdkRGpV?=
 =?utf-8?B?MHQvN2tyR3AwQ08rL0ZBZlJFc2w2eEl6b3FPeVF2ZzVWcEkrVExZZ2IwVEhq?=
 =?utf-8?B?MHpHbjFXMU84UGg3NWJBM1pQMEtFSmdvMGZ0WkdOUjZCOW83M3lTbVVXWXUy?=
 =?utf-8?B?ZFJYd3VCY0FNUVlWaEkxRGhWZ3h5QzcxeWd3Vm1YMnNvbDRTVExkNk1CYm44?=
 =?utf-8?B?WmYzK09iSDRWZnFLNnBxNk41c0hlZ1J4NkRjOVp0Wlp5RDJ1T1EzVkhSaTJD?=
 =?utf-8?B?eUdoMThSWjhwSktOMTBhcThnalJtaGtaWUY2ZGp6cWhBdE94TisyaHJ4OUgx?=
 =?utf-8?Q?UADHF0mTj78l6GytFKISWmy8Y?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 222ce090-0f14-4496-fe85-08dd628977fe
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 23:47:52.1651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oa4mpxQOhGrS0ymiad3jA0ssgEcVrqH+0sJQSE2vcehwALnlr7RRz+LauS4xrvQgW70koeQdPPvP9EXMypkAWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8252
X-OriginatorOrg: intel.com

On 3/13/2025 11:22 AM, Brian Gerst wrote:
> Since commit:
> 
>   2e958a8a510d ("x86/entry/x32: Rename __x32_compat_sys_* to
> 		 __x64_compat_sys_*"),
> 
> the ABI prefix for x32 syscalls is the same as native 64-bit
> syscalls.  Move the x32 syscall table to syscall_64.c
> 
> No functional changes.
> 
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> ---
>  arch/x86/entry/Makefile      |  1 -
>  arch/x86/entry/syscall_64.c  | 13 +++++++++++++
>  arch/x86/entry/syscall_x32.c | 25 -------------------------
>  3 files changed, 13 insertions(+), 26 deletions(-)
>  delete mode 100644 arch/x86/entry/syscall_x32.c
> 
> diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
> index 5fd28abfd5a0..e870f8aa936c 100644
> --- a/arch/x86/entry/Makefile
> +++ b/arch/x86/entry/Makefile
> @@ -27,4 +27,3 @@ CFLAGS_REMOVE_entry_fred.o	+= -pg $(CC_FLAGS_FTRACE)
>  obj-$(CONFIG_X86_FRED)		+= entry_64_fred.o entry_fred.o
>  
>  obj-$(CONFIG_IA32_EMULATION)	+= entry_64_compat.o syscall_32.o
> -obj-$(CONFIG_X86_X32_ABI)	+= syscall_x32.o
> diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
> index 9e0ba339013c..b96f5621a2aa 100644
> --- a/arch/x86/entry/syscall_64.c
> +++ b/arch/x86/entry/syscall_64.c
> @@ -19,6 +19,9 @@
>  #define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
>  #define __SYSCALL_NORETURN(nr, sym) extern long __noreturn __x64_##sym(const struct pt_regs *);
>  #include <asm/syscalls_64.h>
> +#ifdef CONFIG_X86_X32_ABI
> +#include <asm/syscalls_x32.h>
> +#endif
>  #undef  __SYSCALL
>  
>  #undef  __SYSCALL_NORETURN
> @@ -44,6 +47,16 @@ long x64_sys_call(const struct pt_regs *regs, unsigned int nr)
>  	}
>  };
>  
> +#ifdef CONFIG_X86_X32_ABI
> +long x32_sys_call(const struct pt_regs *regs, unsigned int nr)
> +{
> +	switch (nr) {
> +	#include <asm/syscalls_x32.h>
> +	default: return __x64_sys_ni_syscall(regs);
> +	}
> +};

There seems to be a stray semicolon here. The original code also has it
but it doesn't seem necessary.

> +#endif
> +
>  static __always_inline bool do_syscall_x64(struct pt_regs *regs, int nr)
>  {
>  	/*
> diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
> deleted file mode 100644
> index fb77908f44f3..000000000000
> --- a/arch/x86/entry/syscall_x32.c
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/* System call table for x32 ABI. */
> -
> -#include <linux/linkage.h>
> -#include <linux/sys.h>
> -#include <linux/cache.h>
> -#include <linux/syscalls.h>
> -#include <asm/syscall.h>
> -
> -#define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
> -#define __SYSCALL_NORETURN(nr, sym) extern long __noreturn __x64_##sym(const struct pt_regs *);
> -#include <asm/syscalls_x32.h>
> -#undef  __SYSCALL
> -
> -#undef  __SYSCALL_NORETURN
> -#define __SYSCALL_NORETURN __SYSCALL
> -
> -#define __SYSCALL(nr, sym) case nr: return __x64_##sym(regs);
> -long x32_sys_call(const struct pt_regs *regs, unsigned int nr)
> -{
> -	switch (nr) {
> -	#include <asm/syscalls_x32.h>
> -	default: return __x64_sys_ni_syscall(regs);
> -	}
> -};


