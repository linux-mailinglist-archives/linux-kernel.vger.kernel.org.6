Return-Path: <linux-kernel+bounces-400919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29ED49C13F7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 03:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D7101C227E3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 02:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDAD1EB56;
	Fri,  8 Nov 2024 02:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qx3SJi8i"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB83DA41
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 02:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731032251; cv=fail; b=kpoMU4x9rV61BGoUtQztqk41gp++NYuePNc1eoDmvDK7GSLhLcpfGRil1lgQomXvzOFRy3qaN/PCCs98KBJdFzi3oUcKtlp6ifdhIfI1JjkdyXG98s8f+//HuthzCHtjN4KimjLYhdhofLbJ5JX2JYPp//GiZlWpznmqCMLYChM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731032251; c=relaxed/simple;
	bh=EbvmL0muQIv34l8EDnry/0zvHc+N8Lc5V8hWTCFglmk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=de5MCidlvVrx3W9rIwjdct9ei+vpK9uwWDjNBIgn2d00rxgoF4f4Bqw7ewqnB/R+eGIRrzrMt2VlkCSwrz+lHHBzBZ7TDw2Ukusn2dhqMcqR4uzhhx7zPtRhfv9G4bTgErc4NaAvAbU9FrlZIFjb9WoMQrQV4fpuZGa3rThsf3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qx3SJi8i; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731032250; x=1762568250;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EbvmL0muQIv34l8EDnry/0zvHc+N8Lc5V8hWTCFglmk=;
  b=Qx3SJi8iMVmUUQ6+eX3OI4RSaqPlrMS37gktXbEyMlfIgTuV19ZjKttI
   NEH/q3x1YaFYUzwZ4qcZXLTPRmzmDk6VLg+krnJW6S0PFWCVfOrBZWQyw
   wvQkkdyM/srgRjMwAk5WJ0dE6Sspq7L3EGBkKrJa/61ZvEjK9l95qCOqb
   0/tC0QtdjU9CNsxeRALNg+gQZYXa2Mq7xkEgCuTdI9Lph5/PAJ+NSshgQ
   +WcZ+xMxfjqj7CHPYqkVzRaEq69pp73STzDJZ6lZpnrUfDvABGU66J8Ln
   Zct9q2QS7wMbCeGj0MskcywPG1U754uY4wGS2yulEAtVSCTKR++QySCDt
   A==;
X-CSE-ConnectionGUID: 2bq5yxWERdixavY0Qm918A==
X-CSE-MsgGUID: uUgaXmlSR/GgAuVrqJccWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="31008232"
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="31008232"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 18:17:29 -0800
X-CSE-ConnectionGUID: hJtEc6U6QnOgKVWTKQePJQ==
X-CSE-MsgGUID: z/MUKGMEQVKy7jwqdKZLEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="85247962"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2024 18:17:29 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 7 Nov 2024 18:17:28 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 7 Nov 2024 18:17:28 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 18:17:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3aP2MOpAW/5lTL1D1/GS5Rku4ppKphA6lt7OrfL72ExCkAtmskUjhv+tWjjRb3DC1/mv7uqBje3AY9N0lsPO5qX2fKYl1ijySmbqHClRI9y5MdqPEhVkm+Lglo2EbbQ/pWVRBrAwFhim6qfP+UL+FE2KJwB6l79X82ASijOtIp2dyHO/KFWGpbTbkaiHd985WrK/0obWMmtu+JW/n6nwp20M6Zaj8tAUmCclajYB4wXP264c8a2USpCKUdN6gKWh3RPoCQqUbdo1ot3A38utQk9unkx0mHuk+7xKOfW7PVT0w8ucryJnDD8iUT/91q9kXNN+E3OMBvExg4mBuABHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmGCYm4SzVT2u1tXUPKNIXCJ/3zAJtuxW9PrmMaTDS0=;
 b=cyILe2wBXiWguBE/lh2duSrUuSzmOTUKaOd7VYRKTmnCUxbey5Ka5iN80iNiy6E7cCp7GLTEZP9DizpEGZCxbcQqG2RiLDITUNa3cMcvx9873FjA6rmBcqMA7bJyO2RFJM9bbZJmvRK/JYssZjgaI/d+HTiRjPQONsdNNOCUuIUSK5VPyF43lN4oELyFOqyQZvZbWLg6CkxcG7LdHeXQoCo7oT0bQctS8L3eT/+bSxB3H2WmIQTLm09HRGbDLBpAmT/V/kIJyPcQ4aTZEEetiY+DlIqKbMVGwjK1/0BE8yaAv+kKMK4+3ee5zdht46vago/yU0LPrQZKTX4oOLhS3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by BY1PR11MB8056.namprd11.prod.outlook.com (2603:10b6:a03:533::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Fri, 8 Nov
 2024 02:17:26 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8114.023; Fri, 8 Nov 2024
 02:17:25 +0000
Message-ID: <c6da4742-4c08-4375-a9ce-f7dc6308cb71@intel.com>
Date: Thu, 7 Nov 2024 18:17:24 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/cpufeatures: Free up unused feature bits
To: Dave Hansen <dave.hansen@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
	<x86@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"Sean Christopherson" <seanjc@google.com>, Tony Luck <tony.luck@intel.com>,
	<linux-kernel@vger.kernel.org>
References: <20241107233000.2742619-1-sohil.mehta@intel.com>
 <7ff32a10-1950-434b-8820-bb7c3b408544@intel.com>
 <3492e85d-4aaa-4dd7-9e6a-c8fdc2aa2178@intel.com>
 <74338393-4F39-4A04-83B1-BA64CE2D2FDA@zytor.com>
 <4c01a30a-67d9-4918-8781-240b78944c42@intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <4c01a30a-67d9-4918-8781-240b78944c42@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0072.namprd08.prod.outlook.com
 (2603:10b6:a03:117::49) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|BY1PR11MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: c17411c3-2442-4862-a53b-08dcff9b7cc1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SU1UUDV3ZnhZa2dneU5WV0tSWU8rRnhoUU90QTdvM056Q3NCZWRuUFFOazQ2?=
 =?utf-8?B?TDRqVytDTDdpaG5oTzBNMURQOUVLb2loa0g1V0NSTjhnRXlvYmI3enV1aHd5?=
 =?utf-8?B?YUdsU1NWRkNVRmRDTnRBYXBobUN3NUJNMEtFbkZka000ZXZlQldJcWVuY3hS?=
 =?utf-8?B?SUlVYkRTanRxekJJWW9hM2svUkc3NmY3UUYwRGVQT0JLaWdIUjFaNzllMXN0?=
 =?utf-8?B?MTAwc01vZm9wOVA3K1lzQ0d5WmVla3o0Q2szMmgrTlZBVHR3dHV2aytnMEdH?=
 =?utf-8?B?S3A5dDBsdDh1M2gxeTBrbjUxQjd6bW42R0M5TktGT1pWcVU3WGRRVG82dzZC?=
 =?utf-8?B?dExWY05SZGVSVFdadGFtQ3d2VW1sWVRLVGdyYlphWGwvRHpNdWFicHlXYnZ6?=
 =?utf-8?B?d1VQQk9NVm9Fa1BLd2ZiUEw0T3gzTWF2ZlY2Z2pNTXlDMnhNT3FTSXh6U281?=
 =?utf-8?B?UjV2aldEN1cwMEVhbW1UZjd0U08xMmlMVklIVGJaK1JkNEpOTGxYUTFmVG1K?=
 =?utf-8?B?bTBrNzdNenRTSHp1VWZITVFoWElIRk5oOTdrdnNzTE43d1p0ZkQvZXBmYno5?=
 =?utf-8?B?VTNDa2RuOGhYWU9Cd0QzM1pxaG9xTVFnb2NsalVEeEYxUHBkN243NTdjWm8z?=
 =?utf-8?B?emU4dUxncTB2YlAwWkQ4WmdyUHFIcnZWQm9ieXdsZENibUF5NkwxRXlVb2Vp?=
 =?utf-8?B?SkMxQ1NrYVltdGFUMWkySS9mS2RBYmNndGdPejNrYUlNeXpPQ3VSdXdmOG0v?=
 =?utf-8?B?eUtRdXppc1FBODQ5S3pja1dCV3E0UU9lTkEvTDBYamxGa3grbDZSWklJME5S?=
 =?utf-8?B?QldXSGJlUUtjTW1uVVhuREI3NktncEZ5aDlzKy9YZURYNklUUkp2N01Pc0cr?=
 =?utf-8?B?V1VYYTlpTmFBZnpGbnVGYWtnbmw1VkFwSlliKzNmSWZGbS90L3pRMUFKK1Ix?=
 =?utf-8?B?alg5enM1UkdQb2ZYMjBCb1VWVGVXalNTSjN5M0w0aHhuTHh1SWIvbUUxS2sx?=
 =?utf-8?B?cFJCdW00SDNGSlpZb21PT2RpMU85Tkk5ZGUxUzJsSWdXSmJPWVd5YVlxUkVW?=
 =?utf-8?B?L3IwZ1hPWjhTd3dXV2V6ekJhbjBoa3VSaE5naFJKMTFpbm53VENwaHEzM3ph?=
 =?utf-8?B?T3p0bGVPSVNHc3NWb3RLYmV4dlR0Tml4ZzNoVGxTWmREa2d0dEZVeS9kdjdU?=
 =?utf-8?B?K3RBcHBRenhUd1E2NVNPNnFxVmIrZEpERERnQVIxK2tTamIwN1RXZDRkelQz?=
 =?utf-8?B?ZzJGVTQ3VHhuMU5QSE1YMENVSkNYNTYwR2c2RmVUNTgwdEt1TFl0LzFhUWdK?=
 =?utf-8?B?VTh0b0lsZmM1WndveEZHQ3g1MzJIZEJsZ0ZpTFh1bnRmZkpMZjFUOFMvOHVG?=
 =?utf-8?B?VTg1ZEFaVGRTWityRDJDY3c3dnozQnVlR2J0Yk5FcUtUNHFRTGR4NEdueExs?=
 =?utf-8?B?ZzRGb0FhbGlqK0VwM0tHNzhEQ3VlT2twOHlOaHQxOWpmUDlGZmNaNWJ4cDdJ?=
 =?utf-8?B?UkdVSFdxelk2UDUxdUhqd2VVY3A5NjgzS3JILzdTSS9DdWdEdXVYejdKMTZQ?=
 =?utf-8?B?ck1maC9GelUya1ZnVUY4QWxnUkpRVDRXdVJKZlpHTHp2cDB5N25keHdlMGpF?=
 =?utf-8?B?eWZiZ2J2dzIwOGxJamUzWGRFYXlVZlF2eWkvOVA1cUEvcWc4UmFVQVdvbEI4?=
 =?utf-8?B?cWdGT3A5bCt0ejA5cDUxdHNia1poQ2xQRHBLdnhWaVIzeHU0VWRJa0ZYYkxR?=
 =?utf-8?Q?eequQAL+3seoV5bTSG9FPaU7TEvczAtExWU8B8w?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzdaSDNRYVord3hscWp1NE5XS1hsTWt2R3JTKzlQK0cvcStvU3lvV0FTVDZ6?=
 =?utf-8?B?N2dGejRoUVM4anZSSkdsUHBrY0VTQ3VKNW1ZM1M1ODFhUG9DbFczbFlMV3Np?=
 =?utf-8?B?ZXNmNE9hZm0yck5IYndZWTlPTndPRkR5UGd3TCtsQWlzR2s0VzVYTW1rTzg3?=
 =?utf-8?B?aFhncTBjWEt1T21PNXdXZ1NsaGZzUW1OZTAyRXFJVmRYZldvK3dPWXIrOXBN?=
 =?utf-8?B?cURkMXcwSmdNb1RIanVTZGJ3L1YwMHpPNHZ5OGlvbm1ZbGcwc2I4YmI0SkRa?=
 =?utf-8?B?L2hhQ2pHaHppSmsvTFNhV2RTRERPK0gvZEcwZjhRRlBpQ2NlV054TGQrK2RT?=
 =?utf-8?B?RVZpYlJUVVhtb2VoYStlZ29PdDRmTmlYdVBGM210NlRMSkxSak81VnhvQ3JI?=
 =?utf-8?B?MWUzekwyQnd4ZEY1cmM2T2s3VGdQZCszM1JGbDFqcDZxOUlQN3orOVlBMEhX?=
 =?utf-8?B?aEFvVW8yOXJnNlIxUG02TUtqblRRUVg4SWsvcURvNmdXTDdNVUJlWDBzZG5t?=
 =?utf-8?B?dHJRUHUwMUU4SHljeDdXY3dpbDJSc2dLOWFHRjRyemp5VWZtNzdXdSsyWDJn?=
 =?utf-8?B?MXpTVjUxaXdaRmJGWThCOE5ONTR1Q0w3NktKTVdYM2FTb0NDYVYzc0lYWUFL?=
 =?utf-8?B?TE4vZ1ZUMSthRmw4UUQ4Yy9wYmdEUzE2QzNCbUhFbHlJRXlIcmUrbGxta21J?=
 =?utf-8?B?OUUyandPdkZiU09Zc2dvU0Ftd2UzUTljdmpDd2ZLLzlUeUJacHdoT0oyekcx?=
 =?utf-8?B?OThFeDZxdVZUVFBCU3VEeWcxZlFqRVY0WG5wU01FOGlJc3ZWNlBiTmdvVmND?=
 =?utf-8?B?REUzSWJndjFXZER1ZURhSFFrR3lUMm91aGpJanBFZlVBblc5YUFtL1pnYkN0?=
 =?utf-8?B?akxCdENWdGNwMWIrVGp1enkxbVowRmtBU01XQk1xMjJUMno2TVRQeWZEVFRq?=
 =?utf-8?B?QjFzaDFvWGxHN0o0Z2dXQjdEK2ZVOHl4VE1veDFJU25zMGt4RzJ2U2VWRW9W?=
 =?utf-8?B?N3E4cW9ObkE3N1pjcjVzWVlTOUpuNTY5VTdDamNJcytXVDZFRUdObUFDemJt?=
 =?utf-8?B?czZNNVpYZU9hNTdaVE9rb0swRW1nOVpvS1VnUDZuekZydCtGQ1N0RW1Ca1NI?=
 =?utf-8?B?RmZ5OHlHSllmaHVnalVBUWxjNFczcXNzaUVhZHJ0eTJUL000aGFjOTAzeXhp?=
 =?utf-8?B?cjNXcVVSaHlZZmVOaE1meEFZWkR0L2hBNHJ4ZWVseE1la0hiZHliaC9tdmFx?=
 =?utf-8?B?aXNjTFdPNzhUWXFZakFHbVJtd29XN3FMb1J3WU90Yy9GeWJ1WFcwMWlzaStI?=
 =?utf-8?B?OXIwbHNVZ0FFRXU4QjFXcnhLckJCcVh2S2NBN1hNdFRsYnF2cXN5ak9aQjFt?=
 =?utf-8?B?WjFlaXBvS05kclA4V0VVbzlSTXd6K1paSEdpQXh1QlZVNG45MnR4K255UnFk?=
 =?utf-8?B?TWJ6czRRdWg2UjF4eHNicmpIZ1NtUlZvOVBveUkyYWpWS25xeVFpNmRYM3Zv?=
 =?utf-8?B?SGloL2E4NEhZNXl6S2FaTHhCam54SkpsRW43SkZGS21xQjREaU1MZ0tFMkVp?=
 =?utf-8?B?UFl6MXZEdDRoOElFUnVPMXd4QWVZcXhMRTNpSFNHWFZoQXltdmczVVhma1Qy?=
 =?utf-8?B?K05aQS9ITzh4b1hGNnRKM3l1em40TFBseW5XK2RxdFRVWU1kdk5jcTU4VWR6?=
 =?utf-8?B?R1FRSlY0S2ZGYm5iVjFCV0cwR0xLUE1TQ0IxYS84RmFmWWQ0bktsaXlwdTd2?=
 =?utf-8?B?WlhqTFY3TGE5ODB0QWtDVE1FUy85TmFMN0ZXNlBYazFDd0gxY3VlUHFRNGJi?=
 =?utf-8?B?YjlXZUNIN2kyYjJ0bWFFM2lmTEtoelNvOVVEQkRPQ3ZQZ3c4c3lnNnA3NG84?=
 =?utf-8?B?eWRGeEg2Y0JkYTFVT2Z1V21YQk9TYysvamdRdU42Y3RsV3FoOFNWTmxOSEUx?=
 =?utf-8?B?MGpxQ1NNeW1Vc1JJNFJBMmdYQmgxQ3ZLM1lyVmxVR21QMU1sZlFrczdHMDl6?=
 =?utf-8?B?NTNxb25HZ01YQVlLdEl1eE9kbjdHclRvaDZ6YWpPcUxhVTdRcTRIOG5uZUJ3?=
 =?utf-8?B?R1dsUVo1aHpEdDArY01hUXN5UVZYRGo0bFhwcDJ0TTUrQlJ3K2NVRU5NQStj?=
 =?utf-8?Q?Nytk/N4nDqslZrubMtmTik8g3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c17411c3-2442-4862-a53b-08dcff9b7cc1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 02:17:25.9213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dAbMDfa3dg7b7khOJF7a2rtTERVYHnk8QsKQVZdErjCCSbQHx7GyB2bYMcduTTPMs5EBb4WkwCL8Wxj2AToI0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8056
X-OriginatorOrg: intel.com

On 11/7/2024 5:12 PM, Dave Hansen wrote:
> Sohil, go look at:
> 
> # cat /sys/devices/system/cpu/modalias
> cpu:type:x86,ven0000fam0006mod008C:feature:,0000,0001,0002,0003,0004,0005,0006,...
> 

Thanks for the explanation. Peter's comment makes sense to me now.

> 
> I sure hope we haven't been using too many of these synthetic features
> in MODULE_DEVICE_TABLE()s, because we tend to move them around, but I
> guess it's possible.

I found at least one recent usage that matches this pattern.
Look at commit cbcddaa33d7e ("perf/x86/rapl: Use CPUID bit on AMD and
Hygon parts"). It defines a synthetic feature bit X86_FEATURE_RAPL and
adds it to the rapl_model_match[] table.

	MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);

It almost seems like some of these bits are now ABI. We probably need to
mark them and keep these mappings pinned to avoid future issues.
Recycling these bits seems to be very common.

