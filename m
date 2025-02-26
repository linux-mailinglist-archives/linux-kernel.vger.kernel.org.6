Return-Path: <linux-kernel+bounces-533175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2AAA45677
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58405172D21
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E4F1A00FA;
	Wed, 26 Feb 2025 07:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MvZl3+SO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0B5610D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 07:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740554134; cv=fail; b=QnamkKy1l0CfGj/79Gum7DQt15YmSFYwxqBLKXii8uYIGC4hiQBylOAbIqoRDCQAw/4W/YeGjjuO+eD1Y7ruPlBrA1V0eVlmUTQV4rd5eNHXjPBA+l2GzFX/ZEG2kHMZufp11JMXAiWxn0I6Y0L8ARlRLh9/UyFeJPkQwPrYoKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740554134; c=relaxed/simple;
	bh=VC88HXE5HRC77rO7ggO9yFAyvZCU2cg9Dx1d17e3gPE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=CYxiXcjXUxyNmdgKeV5YZHr0qcKEndnqWL8ZId3Nc01OIuVPMveItkraC8CX9tdORMK6kXRV+xQMNyRKbnz4cI3lz2LnBrnZnw14d/x6Ngkz8CcRI+4rCrXikdgKMgG9IQEmsese3Z71aSaPRwn/WVETuO27vIfk7M6mFRQcc94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MvZl3+SO; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740554133; x=1772090133;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=VC88HXE5HRC77rO7ggO9yFAyvZCU2cg9Dx1d17e3gPE=;
  b=MvZl3+SOFVgcZuZSsQ19nzvFfVdGujQ7o+6TlYKvKqUlJvOn+tnBWybx
   m7Q8uS+0+hTC8YRtNUTHCNRgfQAASZW9DEPX2d4xKf0e9Wdb2GFguae/9
   tS/TYsFFHCn1de3cwYXGfK7PEuVkE3SXVimgtha5FJxO4GyKhKghPWuQA
   Epi3TFP07KWdzeJoCXCOdiXe2rvggP5Uv3ZHQ/hXhD6ShVE0gGz7SI4F6
   NCzc8NW/rlXw6OuoED6xbqyD3v68GV0LMvlXe8LDdKxZud6rNbtUtQhcy
   mR/SRz0bLWoDTq5K0uUO17TmQlGPb2r1Hd40/0oXsaoq2qxPwKdubd0tZ
   Q==;
X-CSE-ConnectionGUID: lq7JwgJeTe+zXfzitzMaNA==
X-CSE-MsgGUID: QPx/8eujQZiLoUn7WNns/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41586198"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41586198"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 23:15:32 -0800
X-CSE-ConnectionGUID: RJWZIqHLTYGzyNHmmOcHGw==
X-CSE-MsgGUID: 7HKZvox8R6WtEp+sYKkfhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="117106983"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Feb 2025 23:15:32 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 25 Feb 2025 23:15:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 23:15:31 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 23:15:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZV+RJBlOoXa1NZ7Ctw7jOJwQ/0i+YcG5+CdYmn/37nE0BogriygC/h6xKFSqleLo3BFBIQQQ/SV2o8xe8xE8jpcUu8ftJLsgx9pGfYDm6oLn+rHnjuk0rPaGe6nHVyUiLyU8SRAX26KZxIIoenl34AfTZFadoQmC0ItNLMfoVum60fH8jIoSMaH+McS7gvOu89VIk+vg49oGGu3gRMjkzAC/yDthjzUa0DYDGaUdRXSPW8EGs589Z9koZFpzK3TspwRQkAHRhFjt4zt2r8kuctRhxgqR7M9mykyjo/nXp0e1HgyweR93BptO3eNSYc+ugsbx1ie7Mb6zTd8DQZ/IBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=he84NAFrLa2Ab1ZO7ZBELg8xOHTuL/PcEGSNzxzuQFs=;
 b=qeMYCyvD8hroPAdFt0J6DESd+u7vnbBTrD7gfCNIxyT2YO52SXZAgjpH/qFhxeYOx/gPHWot0KoyPmkS2gDK6bp6fSyvBV5lYBV5N8T5p5pNEzTmaRE9QTDdjE4aC+BQx92rXkiO8JDG0mPZdemwns71msvAuuId4pub/E+RCJ1/EUpVzAQCzEZV7NhKbClU4f6sX6JWnf+1irMHgAE+IjRKR8gV0duBhVZikWcUp8muYF7pSyNA2YVP4T/qrZOVgmKh5MBYIDzM8/VJVU0sTGke4zTyttVkwaiXhdmo+dbBKtLOVApntl6JCDpchSTqz/ENUPYr/cI1NWckG/owbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 07:15:13 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 07:15:13 +0000
Date: Wed, 26 Feb 2025 15:15:04 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christian Brauner <brauner@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [selftests]  d3238e8944:
 kernel-selftests.pidfd.make.fail
Message-ID: <202502261412.2a25ee21-lkp@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV8PR11MB8509:EE_
X-MS-Office365-Filtering-Correlation-Id: e20e860a-a6d7-4c89-93aa-08dd56354fc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGJXMGV4NUZXeVZUc1pJZm1NREJnUDQwYzduNmorZ1lCaFc0Y2g3c3BvUmtm?=
 =?utf-8?B?dnJYY3pRT2F4Yk1xSlpEbWVpL01xRTNmcXJQTGdUdlpCdVVIT0h2ZmpWaWJR?=
 =?utf-8?B?SElCUmZVY29ydkZjdHVjUy9ML3U0SXZQeEFPR3V4SEt3ZXI3ZHVJNmlCMlBV?=
 =?utf-8?B?QmtaOXlhdmo2ZEdEcjFUYVJ1TGk4a2RERFhzRHJ0NW1yYmk5VWZIU1ZZSm5k?=
 =?utf-8?B?b1RCZGFkYU85ZnViRTRGVmVXTDRXYnVKNTljbjRTL0NNbVFBVlQ5NUE5a3Fk?=
 =?utf-8?B?QmIvYUJnNUNJS3VGNUJKbndhUWE4eVAxek9qL2RXMmx0V1Y4U2txRk4xanY1?=
 =?utf-8?B?cnMwWDVmWWx6ZWQySXpMN3M3Zy9BbnREakoyd2R6S2U1QTFCRHhVM0xvMzMx?=
 =?utf-8?B?ZlVzL1hycG0zejBBWCs4SjZuRllvN3Y5R1lSL0cydEE3YS8zQWdXTHphcFlz?=
 =?utf-8?B?amxWa2hzbTJnZ2FLb1laY0FrekV5SFlkQVpKa1llb0RRNGxBczZaNzVuK2tE?=
 =?utf-8?B?OHp4bG13ekdxRFFjSTB5ZFRsZ2x3bVRaUnNyU3ErbkphaXk4NnBxTDRoaWJK?=
 =?utf-8?B?bjVmak1sTGRnTzJuQTBhRUZ0c3Q4MGxiT1JaQ2x2NmdXdXFEMmRvd3hFUDdx?=
 =?utf-8?B?aHQ5eHNVSEVtWkc3TTk1WnJnQlY3TCtaWnhzSldldXA0dW44R1FPMWtvKzlj?=
 =?utf-8?B?WXdDa3U1U2pIZmtCcE82cXZDVllnRGZOZDdDMDNBZjBsam1nSDJDOEFJUG1S?=
 =?utf-8?B?aHR3cjBLbDc2d25Ra3BWcXZCMllMbE5KZGZyeE02YW5UdEJSOXJHZ2tBSHh0?=
 =?utf-8?B?SlFWcFptVFgxZm1KKzhLSngrRHV4MzRyakdtU21Sd25RdTA2SGJ6TEthbWly?=
 =?utf-8?B?Z0hEZEhMMmpuSEo3ZmwrZWNVYkVIbXhVb2tYTFNvODlFRGpySVE2OGFvUkJy?=
 =?utf-8?B?YUdkcHp6Rm44ZTdTZzhHQkNEZUUyNWZDWkwrWFhvc01ZNXA4Vlo2bzdsS0Jl?=
 =?utf-8?B?bDIyUWdoc2JlWU02blI2OXd0RnVqS3YyWDR5bTZNYTNxS1pURnhpaXR3S1Jr?=
 =?utf-8?B?VG1pU2p2RDZQTWlHUjNWVGZyMWk5OTZJZlJub2YyMm53Mys3c1JOaE9vMnVq?=
 =?utf-8?B?L01RM2JJdEtVWVI1V25maHN6WE9yeWJDQzlORFRWREtPMGtwU01YUDRiSVZv?=
 =?utf-8?B?Y1IvSUNSaUlDNHdPRno4eFk2UDZ5YXVPd3hWVCtmQXB4REk0Ujh0bkphRmZY?=
 =?utf-8?B?dmRCbjd2Ky8yTUtURVJwSmJINXVzYlhETTJ6VGd0UFp0bEN4VTBUZzNmbG1R?=
 =?utf-8?B?RDFWaUcrQU83eUtFUUFjVjJFTmlSVENtcHYyVUkzdkdmT0tNL3hsa2FBd05i?=
 =?utf-8?B?SVUrdUZkR1hxdVVQcVBIM1krWTRzWHZtR0J6NXhSN1NwM0lxYjJkQlZyR3Rp?=
 =?utf-8?B?bER2WnRaa08zeUhLZ1JJNnJyYmMyTkFldnZXNWZkYVhwc05BOUtoOXlTRm8z?=
 =?utf-8?B?KzF0V3RuNUI2VHlLeURqeHVKdkJRODRVM2hZTEhZU2NuUzd5M2pWWXNJUTI4?=
 =?utf-8?B?M1d3YUx0SndkakVhYm1jL2t2WVBrSEp0ZEN1VFgyWW1HQVZqN2Q1SThxUktN?=
 =?utf-8?B?cmErOHBBMXdYTVl4YlFYZTVCOWZBOFlmM1hRd3hGVW5iU3FRQ2NzOE1SbDFM?=
 =?utf-8?B?WDZidnlMTnppcUVoNkpTRGd6UnhvSVg3K3hzbGVwcEpLZTI0bDcva3R3N2JL?=
 =?utf-8?B?SHc1TTBlQ0RHaENYb2Z5WW1aZFN4SVVMbGVjTUZJUVViRFQwQ0FkM0xwZWdP?=
 =?utf-8?B?Z2JlSTBKcCs1Zm10UEY2QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1pqUHUvUDNjOVFZanBLNzNQQnQ4cHBlbUpLa3paVkVpaDhJU0RGeU81dXg0?=
 =?utf-8?B?L042QXN1dUUybWdGLytLZnM3ZzF6dTVENWdCRFBSUnM1YXhGSUlhSnhmNzNC?=
 =?utf-8?B?WUR4NTZXS2JlWGNpYXlSWFA3cWdkUFh0ODkrbjNSV0tWcVNsK0w4b09CelpK?=
 =?utf-8?B?RVB4WFhQUnhkME13MVVCaXhGNGp5cnNHN25SUWkxTCtPdG0vcllGcm03d3B5?=
 =?utf-8?B?Z1NKVEtMT3dHNlhyWmdJN2JrblhSVkZjK3FoK2pMODB3WEJLSWxpbjgwdlFF?=
 =?utf-8?B?OWhiTnVRSTJXb0hSemtCNlJ4N01WNkk5YkxzeDdxanhHSkw3WVFaSm1XLzdV?=
 =?utf-8?B?cGxLUzUxWkVUdjNWcTd2d0JoYzUybU9jMVhvZjVsSjFZb0RONmRtZmJ4REg1?=
 =?utf-8?B?N2YrQlBvcnJ6NmFlMzZkUTJNR00xeUk2UFFJVml6NjRNVm9kSkg4M0tha2xp?=
 =?utf-8?B?Wkdxd1hFLytLWm5jYWJQaVhBY0xaa1BjS2UvUWg5aE00a2JLYjkrR2VmY3NX?=
 =?utf-8?B?RTQrQnQ3ZHVrTndkVkJDYWFKNGwyeis2SEVCYll4V0FJdVAyS21BN3M0U2M0?=
 =?utf-8?B?dk9ObnpteFp4aWg3RGFrRjVRak5JU0NBdXZ0anN4ZmNTbXIzRi9USXVVenJ3?=
 =?utf-8?B?VzgzQVN4b2ZMYWZLT3dnd0dFTitxbkhyTUFlYUNDcGcvRkdBVUVXSjNBeVV0?=
 =?utf-8?B?S0FJZTV4RTdsd01NN3NYWTY0d0dJWC83UktCMVhkWUpMZ2F6ZWw5cTRhUzY1?=
 =?utf-8?B?OXFXSnladFlha1JpWlpkeDJVZHpOeFBXcWtsWVpWbjRVcFN2Rlh5YTJKWWs1?=
 =?utf-8?B?L1h5QkVXbFpDclZIK3JobGg2YkxJMkFYUEFycFQvZjR4Y2F3enl0SC84aERn?=
 =?utf-8?B?aGtLNU9Xbm9DZ3dZQmtoRTBFQm1hSS92Q01FOVN6TU1JenVQVjVUTi8rQUE2?=
 =?utf-8?B?czE1eGM2bCs2UW1zeURMU3ZOaDJHaXVKV1Qwa0FhZ3hvZmR3dkxaaUN1SHg0?=
 =?utf-8?B?KzBoTGxvUVdocFBCMVRaWWZZNzR4WldZdkVKL3ZyOGNHaTR4cjdnSVZjdjJS?=
 =?utf-8?B?c3RHMXBUOHVTSjYza040V0toTllPWWQzRWVKMTJJOTE5S0k4czV5dlNwQ1da?=
 =?utf-8?B?ZThzK2JOcUdHZ2dveU5wWnE3bmR0WGlMTVJreGZ1M1E2ZDRUTm1ESXFQOHZ0?=
 =?utf-8?B?K0lrNDZYaWJJLy9QRDBSMXkrS2RUc29mbS9SZElabGFyVWY3clptNnVFOERo?=
 =?utf-8?B?bXdIdmtzcCtKNDl0L2JkS0tYbmhCazBUR0NDT1Y1cGdTUlo2bWYyTDVUaEtD?=
 =?utf-8?B?ekxXUSttWDY2aWM3cFNJMkt4dEsrOVdTSFp6azRKZ2J3TnBrMTgxbVpGVkgv?=
 =?utf-8?B?a2xlWmFJN1RvdWU5NlNBUWE4Z2Z4R21JUmppTFIyNERNWkkwWVdHTkFnL2dm?=
 =?utf-8?B?eGRINmU5KzA2blh0bWdJMU9DcVZJZzVQQm4ycnFHU0YxQmJFdE1VQjBDaTYz?=
 =?utf-8?B?OHAwMSszNUo3d1JhNlAvOGRXR0lkaEgzMER4emNxem1BdTRORDltZVFnUC9V?=
 =?utf-8?B?cDg5NDZ1NFJvMGdiY3NjZ0IyMkREMU9MSkQxeE1MekFnaTFLTFV6UzlhZmlj?=
 =?utf-8?B?SmVRZDAzUkFEVTN5RFJGOUxVendjYU1DYVlBb3I3eFpJRFJqUVgrNUxVRXJl?=
 =?utf-8?B?ZjdiVHhGSDk5UWx2VGdQQThScXorblN0MGRDd3VJVGVuek1CakU4S0x5b3VP?=
 =?utf-8?B?L0pIdDBzQ2tMdVNKZlY3cktmU1pUcDc3ejNsbFd0NkU2emRVNlMwVmtjeCtD?=
 =?utf-8?B?RmZUTGsxWFMvTHkyY1I1MDhBUkkxVC82VzhUQndRV1BPWDJjR0N6Y0FRWU1j?=
 =?utf-8?B?bForVHRzdngyNFpuRUNybEc5SUFMbnlhRkRmbTNpNGRXcUFKQzhYaUQwSmth?=
 =?utf-8?B?K0V4TFl1UUYyN0E5RWEwL1ZEZTVxV0VPWk5IODBzelhrYWpGbTl4WElIVW8x?=
 =?utf-8?B?b0p5dkJaQWxudUVicGVwNS9iZ2VDU1o3eVdtanpRdmJZclBPY1dGalFUUHdH?=
 =?utf-8?B?SlNyOE52T25pdlpTd2RWRHZ2bUdvNkxJSWdjM1J6L0VJOWRpK05Tc2JUbEJz?=
 =?utf-8?B?OWJseVhlbEF1RDFMeDVwZXpZNTFqaURGaWJHMVhybnIxTTRodmtwR2UxR25q?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e20e860a-a6d7-4c89-93aa-08dd56354fc0
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 07:15:13.0788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vej+V8wYBWh3pj0vmWeJO0SMu0bWvnbujZSCrg6i8fiT7meyp9LIpCUaaPXAu1uWnwva69kQONRKHYN6eByBIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8509
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.pidfd.make.fail" on:

commit: d3238e8944e2bd1d6a006d35850e86fa80469751 ("selftests: remove unneeded include")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

in testcase: kernel-selftests
version: kernel-selftests-x86_64-7ff71e6d9239-1_20250215
with following parameters:

	group: pidfd



config: x86_64-dcg_x86_64_defconfig-kselftests
compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202502261412.2a25ee21-lkp@intel.com

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-dcg_x86_64_defconfig-kselftests-d3238e8944e2bd1d6a006d35850e86fa80469751
2025-02-23 19:26:51 sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
2025-02-23 19:26:51 make -j36 -C pidfd
make: Entering directory '/usr/src/perf_selftests-x86_64-dcg_x86_64_defconfig-kselftests-d3238e8944e2bd1d6a006d35850e86fa80469751/tools/testing/selftests/pidfd'
  CC       pidfd_fdinfo_test
  CC       pidfd_test
  CC       pidfd_open_test
  CC       pidfd_poll_test
  CC       pidfd_wait
  CC       pidfd_setns_test
  CC       pidfd_getfd_test
pidfd_fdinfo_test.c: In function ‘child_fdinfo_nspid_test’:
pidfd_fdinfo_test.c:230:13: warning: implicit declaration of function ‘mount’ [-Wimplicit-function-declaration]
  230 |         r = mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
      |             ^~~~~
pidfd_fdinfo_test.c:230:36: error: ‘MS_REC’ undeclared (first use in this function)
  230 |         r = mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
      |                                    ^~~~~~
pidfd_fdinfo_test.c:230:36: note: each undeclared identifier is reported only once for each function it appears in
pidfd_fdinfo_test.c:230:45: error: ‘MS_PRIVATE’ undeclared (first use in this function); did you mean ‘MAP_PRIVATE’?
  230 |         r = mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
      |                                             ^~~~~~~~~~
      |                                             MAP_PRIVATE
pidfd_fdinfo_test.c:236:15: warning: implicit declaration of function ‘umount2’; did you mean ‘SYS_umount2’? [-Wimplicit-function-declaration]
  236 |         (void)umount2("/proc", MNT_DETACH);
      |               ^~~~~~~
      |               SYS_umount2
pidfd_fdinfo_test.c:236:32: error: ‘MNT_DETACH’ undeclared (first use in this function)
  236 |         (void)umount2("/proc", MNT_DETACH);
      |                                ^~~~~~~~~~
make: *** [../lib.mk:222: /usr/src/perf_selftests-x86_64-dcg_x86_64_defconfig-kselftests-d3238e8944e2bd1d6a006d35850e86fa80469751/tools/testing/selftests/pidfd/pidfd_fdinfo_test] Error 1
make: *** Waiting for unfinished jobs....
pidfd_setns_test.c: In function ‘current_nsset_setup’:
pidfd_setns_test.c:211:54: warning: implicit declaration of function ‘ioctl’ [-Wimplicit-function-declaration]
  211 |                 self->child_pidfd_derived_nsfds[i] = ioctl(self->pidfd, info->pidfd_ioctl, 0);
      |                                                      ^~~~~
make: Leaving directory '/usr/src/perf_selftests-x86_64-dcg_x86_64_defconfig-kselftests-d3238e8944e2bd1d6a006d35850e86fa80469751/tools/testing/selftests/pidfd'
2025-02-23 19:26:51 make quicktest=1 run_tests -C pidfd
make: Entering directory '/usr/src/perf_selftests-x86_64-dcg_x86_64_defconfig-kselftests-d3238e8944e2bd1d6a006d35850e86fa80469751/tools/testing/selftests/pidfd'
  CC       pidfd_fdinfo_test
pidfd_fdinfo_test.c: In function ‘child_fdinfo_nspid_test’:
pidfd_fdinfo_test.c:230:13: warning: implicit declaration of function ‘mount’ [-Wimplicit-function-declaration]
  230 |         r = mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
      |             ^~~~~
pidfd_fdinfo_test.c:230:36: error: ‘MS_REC’ undeclared (first use in this function)
  230 |         r = mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
      |                                    ^~~~~~
pidfd_fdinfo_test.c:230:36: note: each undeclared identifier is reported only once for each function it appears in
pidfd_fdinfo_test.c:230:45: error: ‘MS_PRIVATE’ undeclared (first use in this function); did you mean ‘MAP_PRIVATE’?
  230 |         r = mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
      |                                             ^~~~~~~~~~
      |                                             MAP_PRIVATE
pidfd_fdinfo_test.c:236:15: warning: implicit declaration of function ‘umount2’; did you mean ‘SYS_umount2’? [-Wimplicit-function-declaration]
  236 |         (void)umount2("/proc", MNT_DETACH);
      |               ^~~~~~~
      |               SYS_umount2
pidfd_fdinfo_test.c:236:32: error: ‘MNT_DETACH’ undeclared (first use in this function)
  236 |         (void)umount2("/proc", MNT_DETACH);
      |                                ^~~~~~~~~~
make: *** [../lib.mk:222: /usr/src/perf_selftests-x86_64-dcg_x86_64_defconfig-kselftests-d3238e8944e2bd1d6a006d35850e86fa80469751/tools/testing/selftests/pidfd/pidfd_fdinfo_test] Error 1
make: Leaving directory '/usr/src/perf_selftests-x86_64-dcg_x86_64_defconfig-kselftests-d3238e8944e2bd1d6a006d35850e86fa80469751/tools/testing/selftests/pidfd'



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250226/202502261412.2a25ee21-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


