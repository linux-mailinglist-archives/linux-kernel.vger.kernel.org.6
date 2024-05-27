Return-Path: <linux-kernel+bounces-190380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A30D88CFD80
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 144B6B2139A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CA313AA2A;
	Mon, 27 May 2024 09:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dda/es4d"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCFC13A3EE
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716803517; cv=fail; b=Y5gJE0zHcqIKXW6jPUbDGvUAE4JvICjYjeERP1Hq/aMtZwvTdivViqsem51GjGVpC71cNuxFZ+1Iv3Gt+0Wke9z6iFKSQexytJPyBhbsL9id/yvyYh7LvY4AGfV533shARZ3ygjVxmJ5Ppwxj4cq3xpAhpLe2dM/dsOn+yplfEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716803517; c=relaxed/simple;
	bh=nhupowzfDIbCxAQjKSmQ/dOgWvy+j7WrDGCPoBMSPvc=;
	h=Message-ID:Date:Subject:To:References:From:CC:In-Reply-To:
	 Content-Type:MIME-Version; b=heyqYx/3+4gTrPn9JGbmO4cLhOPNtsM7HNSSbEm+j93ieo6V57AD0jo+TmcealhjTjtHFL0ou4Zt3wkJW2SXNHl2hgn9eETfdfXgBhjZqVMhqBDxL9FJFw8+08WqQHeR+C0j5XFlje03IQkCHPYBSukK88dOIPWjTpnGlc8q2iM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dda/es4d; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716803516; x=1748339516;
  h=message-id:date:subject:to:references:from:cc:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nhupowzfDIbCxAQjKSmQ/dOgWvy+j7WrDGCPoBMSPvc=;
  b=Dda/es4dFYZRhfBA1XPYnCKWgS6V57lBRrBSc2JW3RUEjqmJYOhaj4V8
   WqqaqdaIcTiXDwd6H0E/LC4HQX6zeyw0lbeacw5orbWtxRccYiddj8/if
   TeVEJ5DrTKvHQ0AtpQq2KnYCYAZgCu+xk7zr20U98b57ar4kLfIyhMWE3
   PYSPUbMk+/M7tG45TdphIz8LrJP+ckNwAgc2aPH4+9HmJ89Y2U8B4FBwv
   0+L6aK9wlCpC+RNsD05ourVxO8fxv9QXPR1QCZvi9hA/hkoNFvA6Pvpf/
   ipnORqwtbNChvIn4Rwi/VUvNfoNuarC6lkjVXAsDI9JayEX9VRLSBtru9
   g==;
X-CSE-ConnectionGUID: JQTm1INNQb2AMNHtcw3wUg==
X-CSE-MsgGUID: CdeKOqQDT+GQq4FVzneDAQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="13234988"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="13234988"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 02:51:55 -0700
X-CSE-ConnectionGUID: g5ecZinjSkGJPS//Be+BbA==
X-CSE-MsgGUID: isCm7VjORTO4/NRO+flVxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="34780406"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 May 2024 02:51:54 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 May 2024 02:51:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 May 2024 02:51:54 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 27 May 2024 02:51:54 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 May 2024 02:51:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VM9Xp+SAevoXPvpShE5639SAKQKY8/7zU+Na7Wzd5OuXaVKIv7LYh5e+94ga43v08vSg1XbQje0/N80HtgVgLimFxV5WZ0Qvmfn3P/wHFe4YemzWzC1lpzd7SkxfltFB38J+39n/zd4815IlBi+9jVjAXcqV1Eb0X204BqaOzIB5qo1Cj+Wni5NOw0o4Mayq+/16q1NJ+zYWbpiVVEXA6aoz+77ngHIbEEg4QHKYo6wdH+gE38GELC647OS8ouMzFzExQW+dwLIlCEGWwJd4+828MmXmaUdBTwWX5mTjExvjnBPvRjGkkJpeM5m3/doWNTeomrr8+OGighfnL1EsZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qddSYHWDi4FADlG8xYZIsGwCtDwJzYVtsaQpEB5/QI=;
 b=oN1T1dhp8TgjiT+/pjdahsodL2vwnT2zKaoj9xkMy4UeyQKsyitS2gmyrlIBrUhSDt6CyG+CoYFTHD6ttnugMnel7lNcZ6f435bHnLVgv5Slo9BlEC18vNmWVdHsuPCzzkh5YAMmKhOnng5xQkYOxjQc0kOvMSl1R6DF8pnqjBG9J3kgdWS5bICrWTf8hALTxo+ZsxjTL/i1ijv8si/dG3crKzN5IXEoRJF4eLprHfn/KiDnDRj/MpVXTrb4lEwXCvSBL63G44C80p7W3RHzsrVMULhf4uCv8/ks22ZbOTwo3lj8MyWEYbRarfFLdDGN1wPnAiqexaio+xkNbafNtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8722.namprd11.prod.outlook.com (2603:10b6:408:207::12)
 by DM4PR11MB8090.namprd11.prod.outlook.com (2603:10b6:8:188::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 09:51:52 +0000
Received: from LV8PR11MB8722.namprd11.prod.outlook.com
 ([fe80::314a:7f31:dfd4:694c]) by LV8PR11MB8722.namprd11.prod.outlook.com
 ([fe80::314a:7f31:dfd4:694c%2]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 09:51:52 +0000
Message-ID: <8a4efd9c-8416-4267-b5cf-b2aca80b03f4@intel.com>
Date: Mon, 27 May 2024 11:48:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpumask: introduce assign_cpu() macro
To: Yury Norov <yury.norov@gmail.com>
References: <20240524185828.1582494-1-yury.norov@gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
CC: <linux-kernel@vger.kernel.org>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>
In-Reply-To: <20240524185828.1582494-1-yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0061.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::19) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8722:EE_|DM4PR11MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ae0ebc5-f2a8-41e7-7f65-08dc7e32a21d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZEhHazdhRHd4OGZRY0NXZnZ1TEcwK3ZYdE1NaDY4Y3NHM2hOSGZCMHNPNGsx?=
 =?utf-8?B?dGV2eHU0d3BjbzMwdkpCSkgrUlJ3SitCZkphaVhGVTMvbCt2MGE3TnZlcGNw?=
 =?utf-8?B?R0N0RmM4cStwQnNBUlRXOWw2MFVFM0pCQUM3UGsrRkVwc1JySzdlVnNzcnpQ?=
 =?utf-8?B?bjVXV2YrNDRoeVJzc2JxR2VqYkNvTVkyS3ZkaW5YNmV1b0l1L29VT1BYWXcv?=
 =?utf-8?B?dkZBSXQzaXNkWWxDMmtMTkdKbXF1ZEJwWnFyWHdLMDlUTGp6aCtkS1JGMkVw?=
 =?utf-8?B?dEhUOTJQUytNblovUkFua3g3UzZlOU9nVmV6SXZpSXFXRzJlUGNTRDBaL3RN?=
 =?utf-8?B?WTJHZFpwbTEwYkxrNGMwWGlEcVR0ZEpJLzVIOHNoSFJyNFdDbC8zV2M2dlds?=
 =?utf-8?B?YmRzSWtma2IzZjl3WUxjVXFNRzhnK0Nab1llbHZ2bk1pcU10MUxIRjRkcWow?=
 =?utf-8?B?VThUOTR0OEVrVlM3ckdhWHdGZ1ZSYUgxaFdxU09sSUN1Z2h0TTVRdVdFRHla?=
 =?utf-8?B?Tm1MNkdmMWpJbXRXN0cxUmdNalk3aXdTVHFocXo1Nlp4blE2a2pRNjhBQ0hS?=
 =?utf-8?B?bW9SWUhtSFZ6KzNSWDRXMDY0OURibjJjcUdYL1dvSnRXYXJIamFsa3poREhu?=
 =?utf-8?B?eEJVZ0E3NmNNNi9CMytUdkI3NGNBbTc4VFFhT0N6S0xvNkN4eVpnSU1aYWFw?=
 =?utf-8?B?OHIxWmR3SEhQbkozWExvL2dSTkZUSDFuSkJOZ2V2VUs1alhFc2FlcGVONExP?=
 =?utf-8?B?K01QS29mUzMwcjhvaWhvbWlHczh6NzVzK2N2ajM1ZzduTkFpZzZoOUg2ejVh?=
 =?utf-8?B?UlpkaENQMFcyRjlSZFFuNGRBUTBLZWtJa2kvSlN3TFhmWUpPVXVNNHB3eGFM?=
 =?utf-8?B?M0cyb05WSFRDTHcrbThaTGdVeGsvZmFsWXRuNVpjNlFrM0paUTNxUHo5QTVS?=
 =?utf-8?B?Wm9TejNDYzZmMUZhZStqSjI4SkdJOHN1cWlnWWtnVURFY0cxR3ZaNE53Rk1a?=
 =?utf-8?B?TUhzZjBqVC9VU3ZnOG9EUVR4cENkZjlEVHo1QjFKMXdBRGF0TDZoTTY1Sk44?=
 =?utf-8?B?VDF4ZFBuVzhncnNLaHkrRkZWZmRIc2didE9lUkJQUFllTmVqUXcwTGFibUM1?=
 =?utf-8?B?RUszWFpHd0ZRQVRXQ0RHK0FMNWQySFZuOWpPeFBCV2pzcnk4TUFFeUF3SXA4?=
 =?utf-8?B?UFYyV08xY2lHWlRVYjVsSG5Uc0FUUGp5akVqSkdqdlZHK0ZrY3FIdmswb25y?=
 =?utf-8?B?MFZ1d0J2eXRXVlJrbml5WUR4SWE3Lyt3UDduN1NjWXVzWFp1bzJSVTk4OTJi?=
 =?utf-8?B?S3N6TXdZVDNlWTB3NDVRYVNLSDNhYzhuWHI2eGxxT2YreWtpU1VjRXN0My8z?=
 =?utf-8?B?WDFrQTVhOG10dzFxOFNZL1ZMaDhSZDEwWVJ4WkUzN3dYbzJTcVFoYnJOaUtH?=
 =?utf-8?B?RjdZUzBBSkJnNnFYWS8yaTB2YnNlMjZjZ08wcTJGcWd2ZXZ0WXNrYjdOYmpV?=
 =?utf-8?B?UzNFWngrWGhkdVp3Q3hnL2JkS0VONTFNbDJlUDM2SW1MNWVqUHdvb1lnVEVm?=
 =?utf-8?B?dXMxUUZxb2FLekRYT212WXdSWFRkTGs4clFpMlpWTktDVTdSVXJQUVZtZm84?=
 =?utf-8?B?M0h0NlRCUXVCc29mWWhhUUpiRmJzZXdKV3creWZSR2dvMTNKSzJHTDdyckQw?=
 =?utf-8?B?NTYzbFFjd09zdGJIbDFkNmx5R1VnUnRhQXltcEpVNDNBajdwTHdQRy9RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8722.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cExjYWprTDdDdEprejNqaHBpUlFsKzlCZnlIRElXOTdYdzhjY25IMGhnRUx0?=
 =?utf-8?B?WlBBV3JjTGhJMnZaN0FTOWkyR2Y0eEJ3M0xKOTVuTmtmbENkbXdSMWEzUWFj?=
 =?utf-8?B?bk1ENWFvaDdYY1owSDFabXQzS0RDRUpHSEtTMDJ6aEkwdHBiWHdkc2Q0dWZE?=
 =?utf-8?B?QnJkcm92SlVEQitZbkxOalBOY0lya29hRHIxYXVYdEc3bEVFWlp6M2dTQ2Ra?=
 =?utf-8?B?ZHZwTUk5Z25CeGNnbUt2NkEzRi9wR1pOYmMzTUFRTjV0SXZGMFFDRjZybHR2?=
 =?utf-8?B?bk5zT2VQbkJpU1c2c2Y5V3FFSzE1YndHeTlJbHBpV3VLemhPbnVYNWVhS1Iz?=
 =?utf-8?B?Yyt3RDBIQVdkYS9sT3NGSXBtMG5lYjBoZEJUS0dNYU5NOWZkRlFyNXF0eGF4?=
 =?utf-8?B?RHk1b29MRkpqS1F5TG9lWFBKYkhMZUE1UG5VTWNjb3R1NEhwZ2pwZVF3Z1BB?=
 =?utf-8?B?VStwSUdDTTF4RkFtY3NvS0VjUGVySkp3MXhzam1XTG9VbUJMdzhiUURwWmw4?=
 =?utf-8?B?U2FDOFhNMFZrQjRNV0Q1blpzTysybnY0RnZONExKT2d0bWMvT0pZRng5NHV5?=
 =?utf-8?B?UTI4QzZZSDV4Q1dLMi9UYUE2dnVGOG9JOUovcEZNRFFpRE9hVGE2VFl6MEs0?=
 =?utf-8?B?N2RTdW0vVkluMEJNTFE0b3N3djIva1lYbWFmdnlXdHRKYnhnTm16eEcvNWlQ?=
 =?utf-8?B?M1A1N0dreWM1YmZZTjZXZm9LdHhya2lzeE1UN1VlUXgyK0JtS0Vndll4NGdu?=
 =?utf-8?B?UVNUWlFCVzZESTllMzAwa0QvaDIrY2gxMSsxY3VraUx4K3orZUFXMjEvd2g5?=
 =?utf-8?B?THJJS3k3Qis1TXZzck1mZE56VktBMXd2RjM1eWZoYll4VE1lUlN5WXh4eGVZ?=
 =?utf-8?B?b25hMkQreFl3UEwzN2F2TVlWSkc2L2NFTXUxamV3RWk1TmE2bURlaDF5YzYx?=
 =?utf-8?B?WFRDS2gzMFRKTGo0NEVieTE1dmxPLzZQS0NaNG14OTdXU3Rqelh5NHFaTkFl?=
 =?utf-8?B?L3lsVjVxdXNuWmdHaUlWOEd5UGUxSkpGUlpkQnRSWldIU1ZJUUJFQy9JVGda?=
 =?utf-8?B?bWNON0xqM2ZsbWs3TE8wTExXU1hFRmtPbDZ1bVh3L01kbkR2K3BlUG05aEp6?=
 =?utf-8?B?RDJSdEhzWkZsTmp4eG9PTEJBeUNzTmNQdkdZVTg5OXdPZ1NCbmF4STJZZ1lD?=
 =?utf-8?B?K250bWEvRDY5NXM4cFd0V2dkd21LTHdqUjVNN3QxS0xvT3JJYlZBVUJnUDhq?=
 =?utf-8?B?QStEQTdPek9ZeFM0Rld5M1o3NnNBUjlBS01UT29Qb0Z4T1FaZ0lPUzRPWVow?=
 =?utf-8?B?Um1VWHBHczJ3cWlCcnBEN2ZraExFN0pjZ3J2bXkxeG0zWlFhcWs2THBUanpw?=
 =?utf-8?B?Q0RIbEtDKzZaNGoydkJkRERPQmd6dkR4SFpqSG1rL1M3TWFxcWlQMkJHemtN?=
 =?utf-8?B?UUJSM05UbURrWFJZbzBTRTVENWhlMVNRakd2ZjFXRXhEa2h2dmt5UXJCM1dL?=
 =?utf-8?B?cWRmMVhCV1EvT1FQWVVLb0JxRXNUT2hPQXZmSU9xMWNhRXd6R21QZmJ5Nkgw?=
 =?utf-8?B?NFNBNExuZE5LY2ZiWGNMZGVhd2Z0MmRNYzQwTzFGTDg5TzVIeGN4c2hEWUQw?=
 =?utf-8?B?SGpwbmxUOUpJcTNCbVozTHVxbkkwUlJuUlNtcHBqazFmVUJLQ09ZRjZ0dWZD?=
 =?utf-8?B?MnFvNTE3NFVPVkdRdytFRGVDWG9HL0lRYVdITThGMlpsVlY0Vlg3Tks5eGVF?=
 =?utf-8?B?aVlCT3h4eEpnNEJxNTkxMTlOMlMrYVNidGM0eHQ2cXpQMEhMMTgzODVnN25k?=
 =?utf-8?B?bVBtdUdFUFF0M3NwK1AwQUNtRE9NN3orUnRkbG9xQnhWQmtVdDYzREZtWUxK?=
 =?utf-8?B?NE5wdFZMRkZOMk8rNURCTExLRmIxT3hiWGRTdWZpNlN1QjYvbGg1dnd2NkNw?=
 =?utf-8?B?OG1RNmxlM3c4NFVoQUp0eWdvZHVaN2QzY1F6RTFSeXdNc25aWGVxVG9XUXVG?=
 =?utf-8?B?OUlEYjhDZHV4NmFLdGd3OTNSb3pzNkduYjB4RTNVQUtCc2QzNUVEWmM0YWhP?=
 =?utf-8?B?bmtVTHpDNkU1ZDY0VVU4b2tJT0hGanJHSTlsOVZYVU9VbW5lSEpJZW0yQkx1?=
 =?utf-8?B?MEc5R2VCOUtFaWlPbC93dTFMMWNWUmlvTm4xN3F5U3c0WHJSM2FsUmRjWHNI?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae0ebc5-f2a8-41e7-7f65-08dc7e32a21d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 09:51:52.4114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iI3j6UHhvwevTS2rC30zxWlItf+0qK/1vTibRPR1fxNhIjIh3vNkV2ocX1GMnbofU74hNaBibRD3hBrMNGUv3PRjtiqfpXpC3u7cP2VnksY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8090
X-OriginatorOrg: intel.com

From: Yury Norov <yury.norov@gmail.com>
Date: Fri, 24 May 2024 11:58:28 -0700

> Now that assign_bit() is a thin macro wrapper around set_bit() and
> clear_bit(), we can use it in cpumask API and drop duplicating
> implementations of set_cpu_xxx() helpers with no additional overhead.
> 
> Bloat-o-meter reports almost 2k less of generated code for allyesconfig,
> mostly in kernel/cpu.c:
> 	add/remove: 2/4 grow/shrink: 3/4 up/down: 498/-2228 (-1730)

Nice save!

> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks,
Olek

