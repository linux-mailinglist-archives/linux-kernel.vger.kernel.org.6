Return-Path: <linux-kernel+bounces-340941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27437987942
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 20:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC20E1F22628
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC90161319;
	Thu, 26 Sep 2024 18:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ig7UXu45"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7641D5ABC
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 18:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727376351; cv=fail; b=rxw19K4K6Q0dbkVzFQyo6fWNVGRFWeoYtUvhqk40FD+o+Qn/YX+pPqdTNgY9lm2aalbkFUWC050ZTCvbC1WiHenuAyfFSLRD2BuQ5lFtNGfZewnzVLAJvp/WimroPz1Ex07tJ9cWSPk6pwSoAhfxQjuiZzgOzdr2P4MBhmhjRTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727376351; c=relaxed/simple;
	bh=Y9p3B5gX3TNOAMnWmeqqrvz/aK7j9xDfCRzkba5aX2o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bFakcSAvlNKwXaNj/r8cdLuQijKpQO9tCsO83Qk3piQ9VKpn0k/k9ZmXKuVK0XE3mvXO9OubNShKQNwKtMb0cPIBx2NsWPB6jmYbQHRhuaFz+6dxLESqDRS3atD4tYIncHWr8B0pUugIAr7gcR5AhyfBQ5mncZBKC69CFMZivuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ig7UXu45; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727376349; x=1758912349;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Y9p3B5gX3TNOAMnWmeqqrvz/aK7j9xDfCRzkba5aX2o=;
  b=ig7UXu45U+o90Dnkovecj7aE3PUQnNlweFaKMxS5MhgaAV3Q6+G2bo51
   LO9U8Xlt8tA53KOoQP7vIxrjYWdTJjcvYqpPTDI96hfr6tzMHzDUlLhiF
   lHOwLPEca0GMPn+BB1k2hbjP1mSUYMkvlPDINr/TAACiIXq3hwdhi8Rnm
   Nh/PlunwMAI317THy7FcPN/srBcIcFf9H4Ra2FFHA6ZpaIq/KkBvC9Qva
   17jJglk/ZyAYW/cUbxO6ebQzNTkFFBPVc1PjRZPYPgAtz2PbiAbFlZyY/
   q7m4Q5+ADOSS8vlUHG2HhQWtnFEU+aZEHTG3qxJ9DaBKy3o1kZzmB0Oa7
   w==;
X-CSE-ConnectionGUID: VvDtDngWR7C3+B81h3aZ0Q==
X-CSE-MsgGUID: jy7bjWCcSICD+8cRGUgeQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26372287"
X-IronPort-AV: E=Sophos;i="6.11,156,1725346800"; 
   d="scan'208";a="26372287"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 11:45:49 -0700
X-CSE-ConnectionGUID: 4ScpWmWYR9ut+9keYYmi9Q==
X-CSE-MsgGUID: 1D7izXQPSdy9LYZizbfxKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,156,1725346800"; 
   d="scan'208";a="103070231"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2024 11:45:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 11:45:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 11:45:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 11:45:48 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 11:45:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v03M0rIZwAkxH6czZ9nmTKdLfbbAizvUa1NfgqCcKamdn+ojTONZtXplp+Vek2P4DcdF0sW/PW35SMdOI4NtIEQg7FY1VBbFsAnNRXrOF0zjbuMTEWRTBQ5+K9VUKcWl/UJ5fDjTd3Aczqz2Zxi7gp4RY9YfWSH6qyUKvYP8I4gei6NYmsyQKEQ0cJ030n7dX/LTUThP5YvsfLddzb/e2eRvA5adBwz5caUMFEWmwrQ3+Xi1RcDiTM4N/iK2wVSvj4I7NW2CvrdT9xDzav0W9EfPQlfkEpaMY88MdqCde0Gx8z37N/U5VYydUBWvr8cd0Yq8VQdoFph1/DcaJUF1ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IGMIlixxzR4Ad+bpBAec4DDUDeFq0jp45YpH4iC40o=;
 b=V8E0ppxCdjfcwdOeG11CZxVN/ICQIHxEpXPFjyslNGlZ41/dNv2qsAYHPSud4TLAcpijs7NYrI4HwZ1ChPWkYk0Go+cGNuxU3LjU/BoiOrdH4eMc4DTKKggtvyIGsurHcBTTE4OYsHApYj6gXenDn7x3+qU3p1h5rSttW/qC1RN/NubYrYyZ9bJXroZhbVLDNcgClIjUC9BMR+tS3z9zRtNsS4yLetRHzjWVQzJ0itkFRCNG1hhdhpDWD3DqRVtbpi3LB1VyEtjN1Fx6Yygtp9hpvZMwKp5rKFf4kn33PAnRejJ+u77SfArsewD9FwwavpMN82cVRReR++KuW43D3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7926.namprd11.prod.outlook.com (2603:10b6:8:f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Thu, 26 Sep
 2024 18:45:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%7]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 18:45:42 +0000
Date: Thu, 26 Sep 2024 11:45:40 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Huang, Ying" <ying.huang@intel.com>, Geert Uytterhoeven
	<geert@linux-m68k.org>, Dan Williams <dan.j.williams@intel.com>
CC: Guenter Roeck <linux@roeck-us.net>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>, Linus Torvalds
	<torvalds@linux-foundation.org>
Subject: Re: [PATCH] resource, kunit: add dependency on SPARSEMEM
Message-ID: <66f5abd431dce_964f2294b9@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240922225041.603186-1-linux@roeck-us.net>
 <CAMuHMdWAuQcFQaQNy2EP_u9vk13g2C3sb3FFBCMAUPyGMgZ+hg@mail.gmail.com>
 <435dc218-f7ea-4697-b3ef-6a786e8d1b2c@roeck-us.net>
 <87msjxu9qr.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAMuHMdXBbBKskY+TXswaw-oHvLANzoVJGWAjWQDy4HPMuZwasA@mail.gmail.com>
 <87a5fxtqbl.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a5fxtqbl.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: MW4PR04CA0230.namprd04.prod.outlook.com
 (2603:10b6:303:87::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: a7b312cc-de25-48de-a93d-08dcde5b6c9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ek5nUUlxTzdkSnYweUhJdVZYaUJGWlZXQmtRejJ4TnRGaFJGQ3g5eGU3dTFK?=
 =?utf-8?B?R0JiL21NeVZROGdZSEpsZ3p0MkVmcDhvUm9wWXJ3RkJhZDJkR3pCZWJWZW4w?=
 =?utf-8?B?M09EWkp3YVoveS9JaFIvZGlCN2ttOWlFZ2NsTGt0RW42VHUyTzlCeUI4YXNL?=
 =?utf-8?B?dUd1QXdYNG15TXp6cTRJZVlHWGFQM0t3dW1kWnFwNkZoKzNuMHVaM1dTSjJZ?=
 =?utf-8?B?ZEF3R09QVDhqS3dEZE9kNDl0dUlkVERsa2NCcitua0hLMkthQXhCZGJrUWhQ?=
 =?utf-8?B?K0pBRjVvcEszbVZPOTFTWmJPU0JpOG85OUVqOWlkNUNvYjRFbGVqamtUeUcz?=
 =?utf-8?B?S0NEbUhqZlMzQmxVcU0zcTcxL2luOFNJR0NPcFVRTm10amsvSUlLS3JyVFdj?=
 =?utf-8?B?YW5vSkhReXZKYTlUY1ZzY3ZBL0tNOXUwVWZ6YUR0ZENmK3hiYUhjWU9uRmtn?=
 =?utf-8?B?NUxjS0taQVJQMXJKVEQrYVIvTzgwd3dXSTlpdUc5eEJLNFhsMk8zMHRvWUE4?=
 =?utf-8?B?N2FnNXRpL1Fpc3lSSGFJcDNLNHpFQU5PQ2VncXBaTDFLcWwrekprSEJManI2?=
 =?utf-8?B?QTNFQXJwaFFrOFZtcFRrM1lRemlzSDhwdWV0U3pmelY3V3NjSHhIbVZOR00v?=
 =?utf-8?B?VUs4dEVoSTdqTzN1UnVadXRjWHJ1TE80N1U3NDVhVEErQ0owcmNsUWcrak1J?=
 =?utf-8?B?SCtYZFBYcTB1c2U3ZmRlc2JwRGYyQ09RSEprQTFrKy95RlRzU1BGc2ViZzYz?=
 =?utf-8?B?OHhjYXZOR3p5Ym5HaFQyOXhUN0hhR0VVOVFtTGtOQy9iTmtCYWFqaWxoaUFu?=
 =?utf-8?B?U3UwSEJxSElIOThJbnIzeFAwSU84Q3cxZklMZGZzUWN4L00vWlZtVVh1bG0x?=
 =?utf-8?B?RmMrVDlhNTZBdGtBdEZKdFRObkY4VG1vc3BxVnRidG5iREh5cmx5bXZOa0dH?=
 =?utf-8?B?WUlkdzFnRlQ2aHB4VFZScE1HcFlxdGt1eXhvTVJha2RvdGNYeGZEeXZETzh5?=
 =?utf-8?B?R0NLcFYxUG5lWjhmdEpxKzRYRklQRFZ2YlZSdUxpTW03eFFob05lUkJBY1Vl?=
 =?utf-8?B?NTAxTmlNNnpORTZIU1hJRTJTblZ5WVhmaktHM1hSakppcU5heEFOZUs5cjV1?=
 =?utf-8?B?bFM5ZStkaHB0eXc3YXVGcjZyS1djT0ZlRVkxVnhxNmhFdVNERGdVYmZWZnZk?=
 =?utf-8?B?YkJEbWxITXZQTC80d2dxUDFNbjZkYmw3R1FtbmRySUcxU0l0MWx5R1NKRjRs?=
 =?utf-8?B?SElNbmhCZDNaVUo1VFQrWERGUXpmVkVHcmV3cXJ2czJUWEFlVWtZbTM0Tzkr?=
 =?utf-8?B?V1BOOWRVV2RXZVZOdytWRmF0VjI3V1puS3ViMjlRQjhoODQ3MGVNakJOWkdu?=
 =?utf-8?B?VG1wMERVayt0NnBnQTIySDVMSHpDYVZ0bVRveW1ZTytUbW1CeFdEZFdDLzdV?=
 =?utf-8?B?LzllcmVxQmRFSlYreDhQeTl4a1NibGgwQ1Zab3U5ZDJHNHNxLzkyTHFOQ1Nw?=
 =?utf-8?B?Y2hkOXZ5UjJXKzEyQ1g1Qm15MGJFa1BrYXRhNklKVUltRGR6d2NjRnpXWWhG?=
 =?utf-8?B?VXUxL3A5Yk9adzl1TC9DWFFQN1pNMVB4NkMyQ0hadTJseEJubjJQVmxzOGlU?=
 =?utf-8?B?Uko4SytVZ0pWVmVBZkFZbTBCTkJPVEFvejVnOXcrR1BFeVdRQWZGZkR0cGdn?=
 =?utf-8?B?ak13K3hFanNJdlhCc25SSU05aXFxSGxHWXAvNzRESE9PeTRjQUxjZnU2T29K?=
 =?utf-8?B?Umh4NkJNSUFuSEt3NzFBL21lSWpCWGNkQnlHcHJaQ2NnSCtTbFhGTzh4dFli?=
 =?utf-8?B?Qmk5b0NNNGlQOVFTY3VZQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWMxbHdqa0ZMdHUrL0xnUWFxWlZaQUVpd2VET0ZMNkRTVWFCY2c2VnZ6Q1Qx?=
 =?utf-8?B?blpKUW0ydDJLVVJMd3pHNFc4U05TMFQ0cXpLWkU2Vnl3QlVGRzBYQ094TDBJ?=
 =?utf-8?B?a2Y0TDh6Ujhkck9QMDJjdEwxQXdvVytxaUUxYkxicTFoWmpaczFSbEFtRyty?=
 =?utf-8?B?Q281SFhrbU1HZzQySUNNOGJ4OG5uVDRERXM1UWhzL3RaOG9taWdCYWE4MjlD?=
 =?utf-8?B?cCs5TGdLYlc0QUQzMmo2QWhIRDdWOFViajl4dkdLdGYzMmRLWHlCTVZ4Y1kz?=
 =?utf-8?B?NFZzQVhmdHhRT2VDZlc5QXRKcCtXQW5LSmhHZTdNOTJaN0k2VWNVZllRWW1I?=
 =?utf-8?B?eENHL2haUjBuZVJNY1FSV0NKYThUdmo1YjFGVzZzdUN0MEhHN1V6bVU2dUZU?=
 =?utf-8?B?OEJhS0p3dHJsaEJQZE1QT1lzeVBJQTZvUEVORmxVNWFvNDV6djJOZ0x1amg0?=
 =?utf-8?B?b1FHK1Nnam5JeUVKU3NuK255S1A4WHBIMFlINEF5c2lhNi93OFJ1L0dOZWY0?=
 =?utf-8?B?bVp0bWR2ZmQxbXRGVy83RW9LQW54N0hZMURxbVRCT054enE4WlBDMUlzV1pZ?=
 =?utf-8?B?T1B1cVlhbUNsSEFBK3hVZVhOSUp1MEFhSlVXd1ZnRVlhQWdsaU04ZDFyS0Zh?=
 =?utf-8?B?SXpUV2pWT1d6VDJPRzNJSzJUN1Z4S1AvMlRneHRtckg4Z3g5Y01NazIyeDcw?=
 =?utf-8?B?Y05RVVQzNVhJY2NHTmJjVjJhQm1GWFFDRzQ0VmVueTAxanhRZzVERk1KQWt5?=
 =?utf-8?B?OW9UNllNYTJ1OGplTi9NTGtBb1BVd0lDL25IKzYrOGJWakN3T3dEaFZVZ0JW?=
 =?utf-8?B?dzNHWFNRNDBKeEhldjdxejREanRZYWxVcW5mcHlyZGJSYlJYeXArRWtFMkx5?=
 =?utf-8?B?RlBQTHZIRDRDOC9KN3pEQmRqMU9EYitkdC9uQ2o1eXZHVFp2QlpLNVlKQ2sr?=
 =?utf-8?B?aHFseWFZenBBMkdCK0xUTnJ4V2hoWHBiTWxRaXpWM1ppejdkakJhOUNDZ1pt?=
 =?utf-8?B?QkNmNnFITzZ2ZDZ0aDhsVm1uMGZUSGRXb1JYc3FxUFRuMFhuSzNrTlVLVnRs?=
 =?utf-8?B?bG5wVkkwbU9EdjcxZ2ZCdUtXN0plYmdsbnNaeTBmVGhBbzZyMFNDcDYyZ3lM?=
 =?utf-8?B?V0l5RW50Vk11N0ZjMGY3WGJYUzBraFpYVFNlV09Db3cvZmY5V2p5ZkVoL0Fj?=
 =?utf-8?B?d09vVFA5N1pTbUlzZXBOL3A5MTF3akwrZnZ4b1lCd0ZGZVJyQlVDTEQvaVFS?=
 =?utf-8?B?R3lHcDJSWGNiTkZmZ1E5bS9qSUhKSEpSWVQrSGxxTFpweEFWVHJKdlZBMmVj?=
 =?utf-8?B?ODZtdndGeGZ6VU5TYTU1MFNDUW1YbTNDVm5BWnEzcUJyRzlNTENBdzNjOGZT?=
 =?utf-8?B?YzFuMzRMbmVEM0Y2U2Y2TVlRUzdYRnNVUnliVG1HbkE4QUNrcnNYT0VkdWVL?=
 =?utf-8?B?cndhOXg1T0lYM2U0d2hPc3YxUXVBZjd3SW9rbjVjaWNOTUF3eWVMOFF1Y29t?=
 =?utf-8?B?RDlkZ2xyOEhReTU2bmpwSHBKNjJlSkNXR0FsbVRQamcvK0hCdHczUEVGZTdG?=
 =?utf-8?B?UGV2Q3dUcUtoR2k5NE0xZW45RGwzODU4eXFqd2Z1Tm51QUtmTmorMXNsLzJ4?=
 =?utf-8?B?S1ZKYUlQVHRwdFI4TFc3TGR1cEhvQXk3YlJzVGU0WDIzZFZFWkFhTERmTlFU?=
 =?utf-8?B?Qm9SSjBwMWpQcDRFNkZWMVl2dWpyOGZqMm1xK0VvcXd4aWNpOVJNaU9jbWxU?=
 =?utf-8?B?RzhIVW4xSm5oUVJpcGJsbkJ0UjUwL01pNWRTTE5qL3ZnQlJML2JHRU0xcStp?=
 =?utf-8?B?bzFjMGprMGdaRnhaaGRrUWdhZUlFWVdLNGhVcU4xbXJuUFpSNHk3MkFlS3RC?=
 =?utf-8?B?TzJpS21DTVM2YjNxcE53Z0RwY2RRQnFqYUJzR0xrRG1WM3FCR2QwNWJLdmEy?=
 =?utf-8?B?UEJ2c0FldkVtK3R3c2svQ01Dd1FYMU5GdDFyYWVLZVBSL0lFdGhLSUZGc2Ft?=
 =?utf-8?B?aUo4OG5QeDBQdE1lUVdNQi9vRzh0WVFhdTFsZ1ZkcFJ5SXJJYTBYQk5kZmJu?=
 =?utf-8?B?b3krY3ZxSUU3TEJUajkvVUhONis4U3NrYlFZNDJZTnJUd0lkaTlncmVNT0xP?=
 =?utf-8?B?Tnk0bkliMmcvMlI4czRHV3RjMjRVS0kzbzFSc3NWT0xheTdHdHNUSkpKVlox?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b312cc-de25-48de-a93d-08dcde5b6c9e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 18:45:42.6703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wTjiFBUwh4F91XMEYg5smhkmW9pdHRPNNPWwqW0eJycoXNQxAx5/R4Xn5Sd7bhu7eBQWQQswx1t8/ahM9Qmaw2iIHhbNvy3s6UT84h/WM5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7926
X-OriginatorOrg: intel.com

Huang, Ying wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> 
> > Hi Huang,
> >
> > On Tue, Sep 24, 2024 at 3:25 AM Huang, Ying <ying.huang@intel.com> wrote:
> >> Guenter Roeck <linux@roeck-us.net> writes:
> >> > On 9/23/24 05:58, Geert Uytterhoeven wrote:
> >> >> Hi Günter,
> >> >> On Mon, Sep 23, 2024 at 12:50 AM Guenter Roeck <linux@roeck-us.net>
> >> >> wrote:
> >> >>> Building allmodconfig images on systems with SPARSEMEM=n results in
> >> >>> the following message.
> >> >>>
> >> >>> WARNING: unmet direct dependencies detected for GET_FREE_REGION
> >> >>>    Depends on [n]: SPARSEMEM [=n]
> >> >>>    Selected by [m]:
> >> >>>    - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]
> >
> >> After Linus' fix for PHYSMEM_END, GET_FREE_REGION doesn't need to depend
> >> on SPARSEMEM anymore.  So, I think we can remove the dependency.  Can
> >> you check whether the following patch work for you on top of latest
> >> upstream kernel (with Linus' fix).
> >
> > Yes it does, thanks!
> >
> > One remaining issue is that RESOURCE_KUNIT_TEST selects GET_FREE_REGION.
> > IMHO merely enabling a test should not enable extra functionality
> > in the kernel.  Can the individual test(s) that do depend on
> > GET_FREE_REGION be protected by #ifdef CONFIG_GET_FREE_REGION instead?
> 
> After checking GET_FREE_REGION, I don't think that it's a special
> functionality.  I guess it's selectable because it depends on SPARSEMEM
> and to reduce code size.
> 
> Hi, Dan, please correct me if I'm wrong here.

Right, the only reason it is selectable is just to be mindful is
micro-bloat in kernel/resource.c for the small number of drivers that
need that call.

> So, to reduce #ifdef in .c file as much as possible and make code
> simpler, I prefer to select it for RESOURCE_KUNIT_TEST.

I agree with the result, but for a different rationale.

RESOURCE_KUNIT_TEST is simply another "driver" that needs
GET_FREE_REGION. So while I agree with the general idea that "enabling a
test should not enable extra functionality", in this case the *test* is
the extra functionality and GET_FREE_REGION comes along for the ride.

