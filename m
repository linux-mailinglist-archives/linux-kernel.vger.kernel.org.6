Return-Path: <linux-kernel+bounces-220203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7197790DE05
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04913281D75
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6F5176AC8;
	Tue, 18 Jun 2024 21:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WpZqxB0Y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F2A16D4E4
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 21:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745124; cv=fail; b=JAqnnEKeIno27HGE2OdfHp3avBZTZnjZT2cGzFh2qT2JBlV8XhSj2oK9H5VnOzKef2nRGqtxV6PSakPVv3QHweOm1HtXtvO9b2/mdu6UJuMJaGvFEsbqn9zYrE0+3wLvJFaCuL5dtU3q8qWGsRIXykYSz9eKFmB8HqUeUKJ1Irw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745124; c=relaxed/simple;
	bh=PsMSHbOKhAgfkEvhNnnaW6AUlFSCjK3/7z5DZtxzqJE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YIwvB5Pkqos+tEReI2NrDQI5MmLkoA2OeL1XZ89ln7v5VOVF3GiNzqzv2ZjVrWn8w0DJ3lzaX9TmVhIco2tMzQ7N3pH/DKISsYvrOsT+ii8Rh4qg9jUeBm/qeTf3GuY6y7d/UC6AGdWwKIxVFktfywW+vEiHQDXAA7b3PnvVXO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WpZqxB0Y; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718745122; x=1750281122;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PsMSHbOKhAgfkEvhNnnaW6AUlFSCjK3/7z5DZtxzqJE=;
  b=WpZqxB0Y2mqVmC1tH8FvJ2kwkQXIzJJebbP4ndPaziT1DUtnQbBINBoV
   F8KIgpOtSctZ8vuFM/VXBrBvPGBAkKvl/ftqL/FjhDlUVWjhHTwtgM9Lp
   tYNw3j6/EMzaFodyuYrS4SHGJYkBs3rR9m7egCPrK1MvxrosaMC2B9ZbQ
   oe2bE/uOgBUQ8tej5eJ5oM8N/OA9cD4fh2+VIolSbIW6eJGn4gSWdUP6H
   EQEjw0B2efa+w5sOzRkKUERL6gPK+j/BotWXFqrAoveuQYYaMhaCVB7Gn
   2l+6QFpFedLhuNTkGg9slugidbzCQByRIiqvhV80o9X8YEqRUsORm1G3J
   Q==;
X-CSE-ConnectionGUID: WUg+o9gcTTWVNqmHdXiFZQ==
X-CSE-MsgGUID: 9sIJp0k0QXe9qFurPkl+BQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="19437165"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="19437165"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 14:12:01 -0700
X-CSE-ConnectionGUID: 0Rexg7cuSS6ybmliQlZ2dQ==
X-CSE-MsgGUID: zBul2nN6SWqfBo6GC6yXPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="46635147"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jun 2024 14:12:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Jun 2024 14:12:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Jun 2024 14:12:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 18 Jun 2024 14:12:00 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Jun 2024 14:12:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5U3qt8+pxHnwzsvwW/AB0t+nhouIaK+9RvbZKkJEG0lpmSb/E+XRJd3+7TavLwjhWUdeWKhSLt7EeTR+QZSFDWYhj5MtI8q8IEHS5PcmXTJemlgiC3pjBgMBiZSeZApjTZaIGs4KQ+FDztxIVVDaqhgZqgzemsauC9e5JKo4BBrfmExgKAElaP2l+A+ymkB66O8rHL7TQjmN5BEpKlNR8i2T27V7ypgHcy3Y0NrgeXsK6vodHCLsdSGpED7sKRpsG1izU3PTrJhDyq6BslB2A+6UCwHAtZeH6HfvZcnpFQg2VpvvKxCkpWVyMALjDjHoEfYadCJcHlpQoHWDHx59A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YC8656kN+CKUEXR6beAVqULs3Iq1gnUG1d4/LBQhRis=;
 b=mH6dimXWkp3aCHN6Zt4g6UrlrkApLTfmjTQR/HzfGOVPeGoDb2VW0fzc9bbShnRo4xxGEIinQMVqf3nyPIVWzdUPuUlpwkpDbLOXGgY/KbkZgaAJgnqstYpKG2A25xiP2Q9V5Fxf8tyEwgYTlK3br5SlvzkK8YvMDp+fMFYuk/2BW7XiO3Iwx0TrhX55KHbMTZWQmxSgF8Q0Eh7AD4qPFj/PBhcjrqSeLwrtC+/ZazbkHjKewMil0TcjkBVCtsr/nfh//RvDv0AmGrCBbAx0Qt6vnyNHVfgDIN99UEBgKlKnOL9jxp/AuCiCrj1zJ4K3cJ5tpVqE9586vmqU1DwRMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DS7PR11MB6224.namprd11.prod.outlook.com (2603:10b6:8:97::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.31; Tue, 18 Jun 2024 21:11:58 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.7698.017; Tue, 18 Jun 2024
 21:11:58 +0000
Message-ID: <5e231a57-a9c6-40c7-9115-5a809b104ff2@intel.com>
Date: Tue, 18 Jun 2024 14:11:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/irq: Fix comment on IRQ vector layout
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
CC: <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>
References: <20240618201320.2066726-1-sohil.mehta@intel.com>
 <20240618140222.13086b0c@jacob-builder>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20240618140222.13086b0c@jacob-builder>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0087.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::28) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DS7PR11MB6224:EE_
X-MS-Office365-Filtering-Correlation-Id: b799772d-4602-48e1-c3ff-08dc8fdb4a2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VENnMUxJdFJsTVptUW53WTZwdEVyT1FNSklaZjNNK0F5cVRmRjF2OFV6a2Vo?=
 =?utf-8?B?cisxYzhXQ2ZwdmRaZU15ZDRjOWhNdTBSZEczbWtHZGNjUjF6dGNvc2Zkc0Rs?=
 =?utf-8?B?RHU1QlljcDk4S25SL0U2UU55cWxCMVlra0tqaWVuNmJiZ250TUpMUmNEYUhF?=
 =?utf-8?B?TGtUdkl5OU4xU01ENlRjdXFyNzU0eG1ub3VISXUyOGphNXpZQ3hQZjNHdWtJ?=
 =?utf-8?B?Y3gxREFKQVgrMGVwbGVYeTYyS3JRVUM1ZFd3bE9JenNJV1JwN2hXZkt6Q3ZO?=
 =?utf-8?B?bkUrRCtIUDc3QVg1V2l3RUhHbDNXZ3E0bWNOQVFkUDlsQkJCdTQvbGRHbER5?=
 =?utf-8?B?UExxR3dmOStpdzk3bzZxZFBnR3hNQ0Fydk1Rc2J5NGdYaDhNRXhYd1Brd0g5?=
 =?utf-8?B?QWxjQTBHOTRneHZvQ1ZZc3F6VGJYWWJJeUJSbUV3NEVxaUdHWG1hMi9tS2tp?=
 =?utf-8?B?SGx2c2JMelF6Vlc1VytxSWdhdUs5a3dsSTlLV0o4RTZEcGFLTlFzZERIbTQy?=
 =?utf-8?B?dXVrUXl3aFlvQjB5T2l6K2ZFOFBUSnMxcmdUdDJFM0JzYmFseWNRSUlpbnVQ?=
 =?utf-8?B?UTdBUFFNWndSWStnQ1FhaUdvRzRCTTJzaEtYS0VPMTVJU1M3eTNTdGJEUzNr?=
 =?utf-8?B?WkRWR2gwSEJyY3ZzSmZtL1JXQXlPRnVjWlIvcVV3MHg4ejJoR0VYTWlkTUg3?=
 =?utf-8?B?NFVmYXRCUDBDdUpxeCsyVDltaGhlK0dZWnNpZ0grN0JORWkwVmFXb3VkVWpW?=
 =?utf-8?B?R0JhRDQzY0xUSG9SUFlzekc5OFh6NEIvaVd0V1o5aEZSSzZuelh2Wllyd3BN?=
 =?utf-8?B?ZkFYZWhWZUFyS25DNXVRWS9uSUVZZHBjT2QvNUhnOHo0Y2Z1bCtDaTJrVlBh?=
 =?utf-8?B?ZW9jOW1nR2s1T2lsd2xRSTB5Z0tjWGYyWWQ0TUxvSDNXcTRZbWNycjZFVFlF?=
 =?utf-8?B?Z2RIRWxsZE5STU9qNGY1RkdWYVhSazdSOHQyRmVjUjJNd2lWR2Z4RlFOaFE1?=
 =?utf-8?B?bFFMdjI1N2puc0Y2dEFVb3puQ3BURWFXalRVOWI3UlVnTHRLTmFYZUxIUHRh?=
 =?utf-8?B?UG52b0hWNkVQd0dwRG0rSkhCaEtNY0l3TFFFc1VSZVNLVGpvYTZRbUhLR0dJ?=
 =?utf-8?B?ZE82aEVnYkJEV1JMZzh2NnZ5eWhzT1dDQWNDTzNVT0RBcnBrSXJzRDd4cy8w?=
 =?utf-8?B?TUxFeFlqdnlrZXA1ZW9xMUFpYkUvTWxHdjhXQWx2Wi9GUFErMko2L2pFNkF1?=
 =?utf-8?B?dE0yZXdxeHM5bVdqSlBpcEJtWmZ5V0F2K3lYV2FKblByVXNSWFh3UGNlRkV5?=
 =?utf-8?B?U3NMeVhndzZCVGd0WkJlUDBvQkx3RkdWNDh6MDA5VzZNS1UzaGNhWEw2YmJy?=
 =?utf-8?B?R0RjVENGdmgyNFM5ZHB2eHcyYkNCaVhIR3ZXMGZPZHBJUVpJczY4OVVkT3k3?=
 =?utf-8?B?QmZZcmd6LzJQYk1CUUcrb29TSzFoWnZDWDVsa3BPUll4ZTdpREFjd1J2U3JE?=
 =?utf-8?B?SXpzYjhkandVamJzdjNMVXhoZ21kVyszbUtHNlE0SURlUmVFZDlsZW9NR2Nv?=
 =?utf-8?B?ZDIwOFNQVnQ4MHgzRURWSFJOSUZ2V3doaTU5Y3ducVhYVG9yQ0NaTitaR0NU?=
 =?utf-8?B?dVBuRDcrb25JVEdGTnlRem91ZTlLays4SzFvUHZWaW91b0RFOFlHSFIwMUQ2?=
 =?utf-8?B?K2ttcnFNOGx1T3hJOWJ3V29rT3RmQld3enlsOFBpcmQ2SVQreXlUL0J6ZGFO?=
 =?utf-8?Q?7H54IypY/s05ivrX2IxGBmfdEsmjpplMKFzRFxw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjJHYUNBT2F2eGNya01iMlpwQ0d6Sm9uNmQ4Y0hON0ZGNnZKd3haNkZOTi81?=
 =?utf-8?B?azhCT3ZjWFU5NUMvN3lHQWFBek45NnlES0RiWjBXak8vRzNlSVgrN1hGOEVi?=
 =?utf-8?B?K2VYZWhMWlJnY3ZkTUhKaG4wQU42ejdRbzZncXBvaFE1MG1NTXBJZGJDOG02?=
 =?utf-8?B?LzZjMzkxZzBuNlZGR1pNcDRvU3JXZTM1VzNYaHYrbkpnUW5FS3gwQmRkdyta?=
 =?utf-8?B?R1E5U0p6dE5QcHphVlZsR1hWdGtQMlhLWkdJNmJwaFR0KzhReURqRTFod2VF?=
 =?utf-8?B?QnVYZEx2MmowSjJxbFhLd0c0TGJLNHNnSEhDZmFQb3JOcC9hSTVEV1o4U0Va?=
 =?utf-8?B?anppS1lxQXoyVmRxMCtTQ3RCSGhCdTM3VWxod1I1S0Iwbk5GbHQxeUU5cUhv?=
 =?utf-8?B?Wi8wdjlRWGdndFlxQTFRdWdaYkpndWxSTUpFVFZIQXI4cVpzcXBTSmhLOEFx?=
 =?utf-8?B?dFhOYTVWMXFiSWQzZnE5TU5JWWVnOW1EVDNvUFFnVDdWcDBsZ011TE9ORFIx?=
 =?utf-8?B?UW1MakxRTXBRcjJkOVVRTStyTkJHTU9HQzRrbE5KUFdrekZ6c2pQTXFDMlZ1?=
 =?utf-8?B?Y21CYjdiTm11U0p3QnhLSEJnLzRRaHBkakdzcGdHWURYcHRzWDJraGh3UDFS?=
 =?utf-8?B?MFZNakZqeXFiaGl5WmNDQlhuS3NQM1RHd2pKQzZXUTBUeFBSY3drYWxqb3hh?=
 =?utf-8?B?bVN2VjJlcmhDbTFKVjFlUzczZW85L2VySGJRbTFXeEMzMWtvYjNyUGN1VVc2?=
 =?utf-8?B?bkdXekJkRTJDN3BBZEowTVdSUTk3SVd1R25qOXpMYzNIdGtCdkZoWWpXcGhL?=
 =?utf-8?B?WGozbTFoOWszT1lzdVJPTWVXeFU3b0pya2pORS9YMFZLY1BPbE5xVmtsM3pR?=
 =?utf-8?B?ak9Md0E3dVhqVTVFdndmRVluYUN5bk9tNENKU0pPUGZlWnNxMjVCMkZwREd2?=
 =?utf-8?B?RGt1QkRiQjZ3dHBGYjVRYmVkeG9EcGtQV0w5Zys4ZFRHbWEybFdTTFdBRnQv?=
 =?utf-8?B?NjRONlJyREEvVmRiNWU5aHFTTFJwTFBqcEpjaFNxUzd4eS8zcWNycUVpRnFw?=
 =?utf-8?B?YnM4bTBjU2RIZjJzWjI0UUdocExZaEIvanhCVlhoUGhaUEg5Z0xZQnl6eGdF?=
 =?utf-8?B?VitFVnpyaDA5QW1hRUpBT2c3dU9zdEs4ZDdzeWpyZzRMdTYyRjNJZHVTNGV5?=
 =?utf-8?B?SzB6elhjNWVRRWplbFRTTVVab21VV2dvbGlic2FpelNpMmhpbHMydjFxMUFU?=
 =?utf-8?B?aDZUSmtQTlNac3FYQnVMSW1XNzhRYkdGRzlIMnZlV1A4cjIxdkQ4dG00YnhE?=
 =?utf-8?B?SU1XdjBock1wWlVKaTFtanl4YlE3eDR1UlNlWHFHbFlSQW1XTHRTc01Tb2tt?=
 =?utf-8?B?TDdXNVhKNlJSbzkwU2Z3V2svaEk0VWR4V2M5akFacUoyYm5ONi9uNmxQb0Nm?=
 =?utf-8?B?cnJKQ3RHeVZ5Tmw2V1BNS083TG1JOEQ3R205L3NDdEdCeVpXTjFqTHp1dVp5?=
 =?utf-8?B?NjRpZE16ekxaVnNBOHJ1RW94QkZxd2o2ZytnV3BSYUhFeHk2aGN0SVUvNEx0?=
 =?utf-8?B?R0RaKzJkQkZua3JmNHlQSnZEdUlkaVpuWno3ZUdrOEY4SUlaS1RlcUljeGpt?=
 =?utf-8?B?SHd3TzVwbDh0bnJwWVNRS1BkODJNZFErYUpwa0g1R3R4UTEvUnJYYTM2WnhP?=
 =?utf-8?B?MnhZN2NtakE3U3NUMWQ4dGJ5eGFTZDlmUDlUYkZtUjJjaG5Cc1BNQkE1WTU2?=
 =?utf-8?B?NWdVMHAvMTN1Z1NwZFhUM2RWc0J5Y09FUjJTVTFlZzc2YWFCQ3BOTzY3bmpk?=
 =?utf-8?B?TEx2YWZGdHY1S1N2cFRXSXZ5MnBjSXZHMXdPTmtsR0ZDMFp4MzVoZmNJS0JM?=
 =?utf-8?B?Rm9Ca1hkdCt5T3dxOVVzcitGVEcxQzd6YW43NG91TlhYaWJEeFc4V0x4REJ2?=
 =?utf-8?B?aThldytqT1VIODhyV0t6U1dtMjVEajVNNHQ1YlFQUjhBZ213ZUEzWFpkRTh6?=
 =?utf-8?B?b0tkS1U3WGRoSStTMFZtaHdiTUI5S2VQVDJ3ZnVMeDRPNkwxRWxjVGtobVo1?=
 =?utf-8?B?VXZXNVZPSGJ1ZGNEdXNmME4wZW5JeEp1czVxOE40U1VISXQ0WG1vR05RMzNL?=
 =?utf-8?Q?voar9lDxJNukKTvRxC/Xn+A6/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b799772d-4602-48e1-c3ff-08dc8fdb4a2b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 21:11:58.5784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PwWjlkYIj8KBItzp+ZsarzOKjp6GLfMgzIzsV/e9UVaVZdL6yFMvDUDlRDdj/1s+byfL3FWDLExeqIiFWKIDFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6224
X-OriginatorOrg: intel.com


>>   *  Vectors   0 ...  31 : system traps and exceptions - hardcoded events
>>   *  Vectors  32 ... 127 : device interrupts
>>   *  Vector  128         : legacy int80 syscall interface
>> - *  Vectors 129 ... LOCAL_TIMER_VECTOR-1
>> - *  Vectors LOCAL_TIMER_VECTOR ... 255 : special interrupts
>> + *  Vectors 129 ... FIRST_SYSTEM_VECTOR-1
> Should this range be explicitly labeled as "device interrupts"?
> 

I thought about that as well. I wasn't sure why it was left out in the
first place.

Will change it in the next version unless someone suggests otherwise.

-Sohil



