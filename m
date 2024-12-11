Return-Path: <linux-kernel+bounces-440775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790729EC411
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 05:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 472071686DE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 04:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624681BCA19;
	Wed, 11 Dec 2024 04:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UyLx1dwl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8404854740
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 04:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733891718; cv=fail; b=Q43q77byd8B/4ZccdSs16zemNC7W91QS/zEkHYeJIwsWuLQUmR2uD0QIMaPVVpJ97Gs4Vo5TCj0qV5F435JIT0EeHCQJF62yO/nFw/er1lCd9224miN2QTjxs82xnLH2uZ/hDH2nAQ8yNvldeVflyc+bL5XRiKKA0HYIb9HhrMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733891718; c=relaxed/simple;
	bh=kxXQbs/zi9rP++8h8oleEXtmzvZpqc1UuY/Rb8tVwdA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gn5FWLqlZunlG4AgEFvm7TRwLvqPYj/NRIMW72yRGhFUm31RuGpDMrndB2kRXyOwkwgXMTDwmtnv03V+jkyfiOtnGV3hiWlgVyZO+pZ/LQ0dl1CpVNLvl9gfYFMv/YOMvcUmgo0FPnuRxjM84PBNltFQSl02D7PfK0WFfHM0euU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UyLx1dwl; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733891716; x=1765427716;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kxXQbs/zi9rP++8h8oleEXtmzvZpqc1UuY/Rb8tVwdA=;
  b=UyLx1dwl7+njA4Fr7mwMJbnjEvauuh71bIxQKkRL7sKmI2EdJfsMVpH0
   lTEL+F/SF3W2CPdLnp8MJcVficU085xf753Hjs2NEhcVFMGl2vqgPXZf6
   z6MY3/3Sroi7o8SFyZl7/T8PafiunoIFVAWmWojZpDSbNVF+kPPRR8+xi
   23KU1VRaJTUpQ0IkTga3lhOpF+jmRIuc6xlS49eD+vzMDEr8cfJX536KU
   PEOmvlOtDoh9eWSPfPXfjAac6OxP1kWJT1D0uqTf7/alaALaQFsbBVM/m
   TDk1MieJ6u0o5R4a8pJsQpVDqffCJ1UxWuFD4zWhiy+gLbznCmhV1uoyG
   g==;
X-CSE-ConnectionGUID: 1AyHoUk+ToG+vtcPnZPV/Q==
X-CSE-MsgGUID: 7JqnUOoDTfykmRYIXs39ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="37094274"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="37094274"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 20:35:16 -0800
X-CSE-ConnectionGUID: dksAo5YaSBK3gj9VJm9eZQ==
X-CSE-MsgGUID: OK4Ftq8nQnifK6tpei2P1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="95350415"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2024 20:34:54 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Dec 2024 20:34:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Dec 2024 20:34:52 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Dec 2024 20:34:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUu5IkOcg/3nxh5/Z18xsrbF3NxhTbyqp16WNS4qPh+q61cUCm6okNe+4FDAGxUSo5GpYCdZ0xdrDJRt53Oel70aoFwpITTvj0alvfM0qiQ3GOjvofAbce4MSrryihzED0qXwx7onPds1bOWF1iMEOWFHqThrNC0pTq7jSGwAXhW8QNN0By4RHWmL5x+lkMQOE6t9fHHx4Ls5621n3s9FXAan4bQq+zu9TWXzuIZfOUZPi5dbmNsHDjcAuT89dh9sbfLY6BSWVt60Ntn2N5JicKuwbsKs/dXxWQ8U9rmhSBH6E1N3Hlj/92wKxktok7BBQMx3I1G6cXlIFK55OCYeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxXQbs/zi9rP++8h8oleEXtmzvZpqc1UuY/Rb8tVwdA=;
 b=knbv7Ew4WNc2Ku9d3g9jsHQwgCNkvSiMnUXTdUSbcB34xZR8SEeExPUfl3h7v3Xu5tPKekhsblWa/y7Azv/D1sBHjQPsxnoYNSFdOjnz4ZCfewLBa6TwWPbdLtuzVve86vAogKH1y+8YEPCm95vW6pNgI1hdGnxr1dMDtxdmnafi0u9YjOnyoNmumac7S2tldADZwS6WwgKUFfjuWTtsrDCqMF2CQqvu7nOKyFHr6uUW2aFDfWk59eSq5d1vn6kS6vHm2HZnzD2cZ5GkSdiPT3emfiEEsLOeUkJPPt6mYcHN+ENerTk1KLymZkTpTydxFMqG/7qyUAVRa8E0U/XUDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BL1PR11MB6049.namprd11.prod.outlook.com (2603:10b6:208:391::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 11 Dec
 2024 04:34:35 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%4]) with mapi id 15.20.8207.017; Wed, 11 Dec 2024
 04:34:35 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "bp@alien8.de" <bp@alien8.de>, "peterz@infradead.org"
	<peterz@infradead.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Yamahata,
 Isaku" <isaku.yamahata@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v8 8.2/9] x86/virt/tdx: Reduce TDMR's reserved areas by
 using CMRs to find memory holes
Thread-Topic: [PATCH v8 8.2/9] x86/virt/tdx: Reduce TDMR's reserved areas by
 using CMRs to find memory holes
Thread-Index: AQHbSgauk8tDTyGydk+95/xr5jtt27LehpMAgAA7QoCAAAWsgIAAGzGAgADSvoCAAMJ0AA==
Date: Wed, 11 Dec 2024 04:34:35 +0000
Message-ID: <8d2292e69a1076604176e6e8573f26c6cd590075.camel@intel.com>
References: <23bb421e9bf5443a823e163fb2d899760d9f14a3.1731498635.git.kai.huang@intel.com>
	 <20241209065016.242359-1-kai.huang@intel.com>
	 <78a359f8-5a0c-463c-b886-ff4165b395d2@intel.com>
	 <83df85a3b318e6578628692ce0d28b9cf736061e.camel@intel.com>
	 <6757aba1e072f_3e0fe294a5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	 <5bbdf95daad0fd5178b50eb50ba95eb6de801c29.camel@intel.com>
	 <86302cfb-7272-4477-b311-e10958ce096f@intel.com>
In-Reply-To: <86302cfb-7272-4477-b311-e10958ce096f@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.2 (3.54.2-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|BL1PR11MB6049:EE_
x-ms-office365-filtering-correlation-id: 203a133f-e25a-4003-3051-08dd199d1d99
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?L0pWVzZqenMwU2tncWxKQzRkcU0xb3Zrc0gvRHdzUDlCcHJMdklYQWQ0WWxG?=
 =?utf-8?B?LzRKd2xNdGJXUlduRWdiaWIzSllxN1dtQURNOHJwbU5KdU0yYW1uc2NRUnVL?=
 =?utf-8?B?VzBIbkNVdmZBTkR2TnFOS2FjZHcxYSt4NWZ6S3FDVCs0N1FMWE1sVi8xQmtt?=
 =?utf-8?B?YjVobTVIUW1LWTUyYzhQSVFYT3loR0NuUjhjUjBzVm44cHQ3N1BSR2dJcGov?=
 =?utf-8?B?RTRmZkNBRnNJS2RNbFE1SjdTM2dUVzlIMVB3ZTJESzN1MCsyaTBRUWVvNHVC?=
 =?utf-8?B?endhb01nRGlIVDhMTHFjS0NSa0p5Y1Q2eU9ERFJyZHljR3N5bHJxMWRiYVpW?=
 =?utf-8?B?Z2llcExOZUtEUGh6VjdwSzNpVmJMNjJhNGhGeEdUTEFWS0RkcWtiVys1U0tr?=
 =?utf-8?B?SjFCcG9XakFsNGp1YmVrODdSQnNBV2djekVWZ21RZmR2YldmaFdUYzFlYlps?=
 =?utf-8?B?QSswdldraGQybXlIWVA4OWNIZ3crY0FPYkJWU0Q5ejkyQlFBRXllNzMwWGxj?=
 =?utf-8?B?b28vdHNweDV0V3hXNkQ2OWRIaTVFN09Ib0dPZVdld0hjZ3ptVURaVlFTeWpD?=
 =?utf-8?B?b3FJVGt6dGtPOHpaaGxuamFxZ0hNWVN2NldxeGowSzRsMm9iWUJHOGU5UjQz?=
 =?utf-8?B?UXpVaVVqUElLWnV5Q0JNRytoZjE4aWg5SXdOeXFDY2gwWGNJZEhGdU9DY2hG?=
 =?utf-8?B?U0R1bFl4ekhUbWIydmtVSU96dkJRMjR4Q3dRWGNNdGJFaStwYzhVTDRjbnk5?=
 =?utf-8?B?K2ZvVDFNcTlkZUtZazN5bUMyM2dlN3dkdVczMzZ1ZlJHU0llNWJsTUx3S0wv?=
 =?utf-8?B?VFQ1dmd3K3FFL0taRkhzVEdTVEYzQndjRXlSR3F5SENCREdPOGYraGJkTmlh?=
 =?utf-8?B?bU5OOThhbHNBNGEzYzdEZk9qNFBHUXJFendxN1l4RUJwL3plSzNwdWZhaVpX?=
 =?utf-8?B?M0Z5RGZsK05LZ3YxVm5Xb1RyS3p6d05xaW9PYkNaSmVscEJQTXc2ZGsvb3NS?=
 =?utf-8?B?NTRwYnRqeXFycXNtMnpqTExRQnNLbW1nMVFMVVM4NXFyUFRUelVLZjlwOHVz?=
 =?utf-8?B?STdYNGhWWVdJbk1HUUViWXdzeENON01OS1JWLy9jS093c1UrdC9ZdndYZmdp?=
 =?utf-8?B?elF6QkpNUVhtb1pwdGdMeGdaelhYbVYvMlRjZEtqRjE3M0YzODVPWjVtUnBs?=
 =?utf-8?B?OEpHYStrVGZkSk9TcUQ3L0diOUNRL3VldTFlNzdNYi9FbE5iQnhRU0tycExm?=
 =?utf-8?B?WTVRVzFqK1ViNGtJU2RkNGhuWDJ3TklzT1dlYmJ1NjQyNmxPaXZNenRCTVVo?=
 =?utf-8?B?UFduNFkybTlDSlVmVURoRGlTVjcwZ3dIRlpldGp5TWovOFRnWFFaTTl5Znkx?=
 =?utf-8?B?ZTh5SmlpREhEeWFLWk9KQWxJQkJlN1RrK3NaTGFycE5OZVdReEZSTHNXTlFt?=
 =?utf-8?B?Njl6U1hlMHA2Qjk1dXhaVVlBWTdNdVdQRndFTThiZVFIK1V4VkZFTzFkSHpi?=
 =?utf-8?B?L3FydEhPb01KK09uN2Q2VzZwZWZjSVlCSHptTmFtbFB3YVBXSmx4a0FLOCtt?=
 =?utf-8?B?MTE4NDUwZlp4V21EYzA0dEZUSHpTZkdPVklLS1FzVHFqeFhLZEw3YlI5czI5?=
 =?utf-8?B?TGdtTUtza21lTFloRVNNN0h6V0wwc3hqNmdLM0FySzgrYTc3ZXJlNWZjbVZl?=
 =?utf-8?B?MEhGSE5hbmpkWjI5VmxqOWtsYmlyeXBQdTdMbmRVQ3FqZEE0V2p0cnFieEJN?=
 =?utf-8?B?dnBjNkoyZUIwdDMvYzRHSTdZUU1rTnVSTTIvMDNIUDBJdlhGamhaYkNwUW5m?=
 =?utf-8?B?aE5abjEyR0EyWlpGMTRJQ21hNkFjYzhEc09iYlVGUkVSYkYvdVRZeHBJejMv?=
 =?utf-8?B?QVdOTjVDRm5uQUJtK0o5enZXSkJwcTJXTTVhMit5MGt2SWQxUWpkVnZubjdt?=
 =?utf-8?Q?jgFSgEsoH9g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3VZT1lxV1I5UWs0YkthRFRTbmhIQlQwOStYR0V5OWZtWWVqcERReXQrTWZN?=
 =?utf-8?B?bytENkR1NS8zYnVXWktEQjRxdTBPM1FJbzRNWVZndGJUTldtOExPSzJhOVN3?=
 =?utf-8?B?d1B3WFBQN2crT2RQOW9WVTNoN09mTlJQRm5naExsN0F1dERrc295Y3dLRDdZ?=
 =?utf-8?B?c3o0aFNTaG9pSmJiSHBaSW1XbDc0Q2x1T1M2NS81L0V3MmJZS2JHWEJwMWYw?=
 =?utf-8?B?dFZQcmVncjZOUmNDZ2dtRzlCNjBHTnlHWURPSDRsWVE5d0t3by9kSVR5Yyt0?=
 =?utf-8?B?R2xRVXdwYlNhMXkwREs0ZmIxMUVvSGpuazJpOG5FZHpSMzRwNCtLZmdLNXFC?=
 =?utf-8?B?b3VQNHpMRXY2Y1JUeCtpYkxxUjBZcXNpdmNXc001bGJnbm1xLzlxZ2daeTBh?=
 =?utf-8?B?ZS9yMUpsY25zY0xsMzdjR1BZSWxKOGE3K0hMRVZ3bHVWakY4cGhUMjB3ZHc3?=
 =?utf-8?B?OGVFNENIWnFqb21PdkhGNktYRmpHd0VCSk1VM09ydVFtbFlWOG54UVJnbkNN?=
 =?utf-8?B?QVJ6OTV3cDlJRFVCQjduUFBOOVlQV0E5cmZFTmZnWlMvRzZFL3pBMzRaZmVG?=
 =?utf-8?B?KzU3TFpLb1lMcXZBSzBoUS9Fbm5tekxqOFBXVG5tZm4wQkpiMGllOWozaVJM?=
 =?utf-8?B?SFZsb1BNeEFPNUhyczZudWxEUFMweTlqQ3JJSHl5UnlpdTliRTFyVmdBQ2RN?=
 =?utf-8?B?UkpySTV6aGd1eVpVdnlVL085SmZRTnUvalBObzBiamZtMXFaS05xMy85YU94?=
 =?utf-8?B?NjlBdVhWZ1ZmUmV4b01mcitRQVo5cUo2NUJlRDZmMGdzbHZKQk90Vk5DQ1d4?=
 =?utf-8?B?blRWN2k2cjh6TWdhM0RBdFl2QWNLb2xtZWt6dHBSYnRXSGdXWW85Sjllc1da?=
 =?utf-8?B?TGgweFFwaWd2U2dwS2JZdGtZWHd5UXZSeWRLYWxoU1llNUtYUGVUSVJ0SGIz?=
 =?utf-8?B?U0g1VlF5eEdUeXN5ZVpuamY1cnhjY3paR2xWOXljMy9OeHlwd05JZjJCU2Zp?=
 =?utf-8?B?eUwrNU5FY0hIWUFtRTFxWSs1enZYRkNQOVEycWF3N0VhSUhxOWFpZzNSTFgx?=
 =?utf-8?B?VGw0bkl2bjFFbENNQ0dmSU1wUVVBWHNualJ2MXJuT242RU5BSUQrekVGdEtv?=
 =?utf-8?B?TnBjN3JQcXJaVzlFSkNyT05kakZSL1htV0xhN094T29uVGNxcVgvTHRDSEM4?=
 =?utf-8?B?K08zU3crQ3cwTnpQWlZ3ZW9RRXlMTlBCQkx5REUzYmFHU2l6b0RJYVdPclFu?=
 =?utf-8?B?clBVcWQzeVRjM1NpVUZvUHFRREZvWVBSRnRYRjdjYlhtK0srQitDeW1FRDg0?=
 =?utf-8?B?RkZCODZRaHZ4QnVSbUtvcVI1emppMHl6M01ZVUJpdzNxUG5OWE1TbEhTdkhV?=
 =?utf-8?B?NTZCN0VDOUNtaWwwNHdOTm5jZjRpcCs5VTZYVjJrNFdZWVpBRnNlRlR5aUVQ?=
 =?utf-8?B?Q0VmbWZlT2V4alVtMm9sWVpwVzZqa3M4eW9BeStJK1p3cExxY2wyNURBNDl1?=
 =?utf-8?B?Unlqamlqd2E5cGVwNlNvVExaVnl3WjhYOTArM0FYdjE3Y3J1QWhQc0pEaUcy?=
 =?utf-8?B?Y1dSTmZRNnB5bjVlOG9FUHpjcHcrVTQyV1J2allTSGhURUozbCt1UnlPZWIy?=
 =?utf-8?B?RkRqQlNVcjlEYVZIZ1hrYjZCQ29zM0RtWG0yVktaU25VYjdNdUMxUEZmb1lL?=
 =?utf-8?B?TlhWV21lamZ4S05sYlNyTytHdkxld0hZWGgwN2ZaN2RJNndQcGxZeGttUzNo?=
 =?utf-8?B?WGd6T09YRzJaT2NSSThiTWo0aEZ2NXZDay9UM3FrQnhSbU5LMWQxeFpEV3R6?=
 =?utf-8?B?Yk1vcG1yY2ZOeDk5TWdJeThoZzNTVWMwRURiWkpKcDBVS1NFWlE3VUdOSFll?=
 =?utf-8?B?Wk00YTFSY2dGUHpiVWlza3ROdWFrRk1UUUJFSTNWTVJrWGhjeVJNNm5WRXA0?=
 =?utf-8?B?LzFjS1RQd1FibDNxeXJNSVlFQW5xOU1HcXE3S2dqWGlqcy9LVnh4a2lwL0Rj?=
 =?utf-8?B?VHVZcXVGbUt1OHBnVHE0eXVPejk3MUR3MWtRbElwTEtJdGJublNTZmhlZzJ1?=
 =?utf-8?B?cGtUUDFSdHpwTHEwendwMk1CdEVkRC9XNFExYjIrcmNJOVFidFNHYmhOdUVV?=
 =?utf-8?Q?pSfP4V+3qzrSBx6p8PIbmjTor?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5B897B6995B064A992D2F8D9D2F654C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 203a133f-e25a-4003-3051-08dd199d1d99
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 04:34:35.3335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cvxX505AEun9EknvHLxOtLR4DHxhmRyaAfBHUyFvUgiNoEEAYOq2zJP4CjQkoNjceIyVGnL4wqAUJcjGdRrCow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6049
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTEyLTEwIGF0IDA4OjU4IC0wODAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gMTIvOS8yNCAyMDoyNCwgSHVhbmcsIEthaSB3cm90ZToNCj4gPiBPSy4gIEkgd291bGQgbGlr
ZSB0byBnZXQgdGhlIHNvbHV0aW9uIGFncmVlZC4gIElJVUMgeW91IHByZWZlciB0byBqdXN0IHVz
aW5nDQo+ID4gQ01ScyB0byBidWlsZCBURFgtdXNhYmxlIG1lbW9yeSByZWdpb25zIHdoZW4gY29u
c3RydWN0aW5nIFRETVJzLiAgUGxlYXNlIGxldCBtZQ0KPiA+IGtub3cgaWYgSSBoYXZlIG1pc3Vu
ZGVyc3RhbmRpbmcuDQo+ID4gDQo+ID4gUGxlYXNlIGxldCBtZSBrbm93IGlmIHlvdSBhcmUgT0sg
d2l0aCB0aGlzIHNvbHV0aW9uPw0KPiANCj4gSSBob25lc3RseSBkb24ndCBrbm93Lg0KPiANCj4g
V2hhdCBJIHdvdWxkIHByZWZlciBpcyB0aGF0IHlvdSB0YWtlIGFub3RoZXIgaGFyZCBsb29rIGF0
IHRoZSBjb2RlIGFuZA0KPiBkZWVwbHkgY29uc2lkZXIgd2hldGhlciB0aGVyZSdzIGEgc2ltcGxl
ciBzb2x1dGlvbi4gTXkgZ3V0IHNheXMgdGhhdCB0aGUNCj4gOC4yLzkgcGF0Y2ggaXMgdG9vIG11
Y2ggb2YgYSBiYW5kLWFpZCBhbmQgYWRkcyB0b28gbXVjaCBjb21wbGV4aXR5LiBJJ20NCj4geWVh
cm5pbmcgZm9yIHNvbWV0aGluZyBzaW1wbGVyLg0KPiANCj4gSSdtIG5vdCBnb2luZyB0byBrbm93
IHdoZXRoZXIgSSdtIE9LIHdpdGggdGhlIHNvbHV0aW9uIHVudGlsIHRoZSBwYXRjaA0KPiBsYW5k
cyBpbiBteSBpbmJveC4gV2hhdCBJIGRvIGtub3cgaXMgdGhhdCBJJ2QgcmVhbGx5IGFwcHJlY2lh
dGUgaWYgeW91DQo+IGNvdWxkIF9leHBsb3JlXyBhIHNpbXBsZXIgc29sdXRpb24uDQoNClllYWgg
dGhhdCdzIHRoZSBwbGFuLiAgSSBkb24ndCBoYXZlIGFueSBzaW1wbGVyIHNvbHV0aW9uIHRoYXQg
ZG9lc24ndCB1c2UgQ01Scw0KaW4gbXkgbWluZCBub3cgYnV0IHdpbGwgZXhwbG9yZSBtb3JlLiAg
VGhhbmtzLg0K

