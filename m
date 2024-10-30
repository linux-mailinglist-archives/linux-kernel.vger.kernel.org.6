Return-Path: <linux-kernel+bounces-388186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5E29B5BB7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 07:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BE9A283A2A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 06:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288D71D1E8F;
	Wed, 30 Oct 2024 06:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EhR00n9p"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DBD1D14FD
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 06:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730269772; cv=fail; b=BtskEiIVbNNUmn+flBg5tsv/ZrV1eE9vGunt0r5IeEejNj3TTHt24Wy1mop1lZqppSBizDQPC/w9eujijteRyxJ7rRpUfF3N6IwpDI8/VoQ3S1L0HQl29RB40oE2iUmVLDjCvancCRbSmoriTplkCuEahSiZZ6mpLykOgxf4EyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730269772; c=relaxed/simple;
	bh=Wkt/gUzTFfNRChW9xxy0SqJxb96qWh1iC/cdA4CVa64=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uBG4OX+1uqpRx9qwFRRr8vv9sFq5hYWY31rmpTfcmCS9/yliqorfK2I7zdO1Fa69mmnZTBzRpYe4/263znAuPfObxOh8KZpex1RSEAGqmHNW7yq347S6+H5lFzSz8Xk0NE2BGXt5un6wsF5WTwGMNsUomi3IKgyabJbATFfDmxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EhR00n9p; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730269770; x=1761805770;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Wkt/gUzTFfNRChW9xxy0SqJxb96qWh1iC/cdA4CVa64=;
  b=EhR00n9pLhZFB3lvwbcVwwgcpbb3cH5fCfQVt0dfdw0cMmrlsuUK6bcb
   4xh/TAo2PRpTRZMN2FS4rDNQhz+3oRr5znNfaHwKQovQwgYc4vngW5W1v
   5D4/8cc85P9gvDcM6468/OrFfhbM/MtsCbf8q7b8XDMrsKqHQYf+rp2LJ
   BEiyH6so97QT3egUAHvcTHrOBF4nOGV8XzgJft0xt0fj/67UWLzi3xgLY
   7PUiYIUILKhBgOFegfOC+l2HBgYF/pnWMttVbpEsmY45hRx0A7iopQ2Ik
   MIebGnhK8uFsbB3l54TjWa+2sLlwcwk7wPzt7RrrSrX7HxrqWeMxX/5ez
   Q==;
X-CSE-ConnectionGUID: m8JCpvIDSACmQmmOiGK/qg==
X-CSE-MsgGUID: ZPl5wawOSfyaewwwey01mA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30099989"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30099989"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 23:29:29 -0700
X-CSE-ConnectionGUID: kvCGaxFNTrOFd9JG137JxQ==
X-CSE-MsgGUID: jCnZUIlsSRKKCWN9/WX38Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="113051461"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 23:29:28 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 23:29:27 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 23:29:27 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 23:29:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lKr3Jl8hkBKPLZDNUMJ4V3pY/AS3A5muPUipS8cbBqtgK+qqCKSzMKxLCzlm4Wmng7YR/p1fqZh00OtDddDqn4HdEqwNokDRWXMDMdOpWTUGnr5sKYfzZo1QF8ncKYjuUTy/hUXdTHDLwivsb71wEmTf34QfF9KfF/8CXDkWEQsL/ccUKSCGo5bbxYT5psReSlV+QkBpIdoYkb77zdA5b4BQkc7CpUkRNHvFUaY2Fmg99r5zWY2s8shJE/NVYSfOry14MhssujKWk8OTbqv5lJ8Fj7GpXw6Mm/mpKAE1ELoMCHzKQLXCydEajid8YJjzPDNXXgn7LyZju3wXHFbNPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wkt/gUzTFfNRChW9xxy0SqJxb96qWh1iC/cdA4CVa64=;
 b=ZuwUQ1RXPktY7Ik5ZHWm+CB5/ar4vp+qOVyGaRar7T5KSF/+U/0omVsa+Pyn9EcQH5bP0T/CE+9TyYjUn3P4VGVuUaEqrrjiS3XYRCNdPUDjTVOduAPWLUZkavYGoBWVajgld7kyUubP9XNmO+EwBYCZf0WIbnX5Xyi6ku0e7evxkInh1MU7XmuSeedKrTSE73HMlsK8XAsiqAQ1F2l2pTv0pHfbmj93np7A6qMxOcJUPstpbn3sSyxLei+WxmTeCBX7I/BIbx0m7S7uW5VvSCZcduD1hx13CHD2yABZfNtdudt/KX9J7A8YE6OiqC3WOW5fN3rRBq9nYZH4O8iYUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7572.namprd11.prod.outlook.com (2603:10b6:510:27b::13)
 by PH7PR11MB7961.namprd11.prod.outlook.com (2603:10b6:510:244::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 06:29:21 +0000
Received: from PH7PR11MB7572.namprd11.prod.outlook.com
 ([fe80::16f9:b81c:54a0:76ac]) by PH7PR11MB7572.namprd11.prod.outlook.com
 ([fe80::16f9:b81c:54a0:76ac%6]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 06:29:20 +0000
From: "Constable, Scott D" <scott.d.constable@intel.com>
To: Peter Zijlstra <peterz@infradead.org>, "x86@kernel.org" <x86@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Milburn,
 Alyssa" <alyssa.milburn@intel.com>, "joao@overdrivepizza.com"
	<joao@overdrivepizza.com>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"jose.marchesi@oracle.com" <jose.marchesi@oracle.com>, "hjl.tools@gmail.com"
	<hjl.tools@gmail.com>, "ndesaulniers@google.com" <ndesaulniers@google.com>,
	"samitolvanen@google.com" <samitolvanen@google.com>, "nathan@kernel.org"
	<nathan@kernel.org>, "ojeda@kernel.org" <ojeda@kernel.org>, "kees@kernel.org"
	<kees@kernel.org>, "alexei.starovoitov@gmail.com"
	<alexei.starovoitov@gmail.com>
Subject: RE: [PATCH 11/14] llvm: kCFI pointer stuff
Thread-Topic: [PATCH 11/14] llvm: kCFI pointer stuff
Thread-Index: AQHbERaYDzK8jBVcnECFIEYLVO29VrKfA1eg
Date: Wed, 30 Oct 2024 06:29:20 +0000
Message-ID: <PH7PR11MB7572C2DD0A7B5963D1ABA77ABB542@PH7PR11MB7572.namprd11.prod.outlook.com>
References: <20240927194856.096003183@infradead.org>
 <20240927194925.498161564@infradead.org>
In-Reply-To: <20240927194925.498161564@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7572:EE_|PH7PR11MB7961:EE_
x-ms-office365-filtering-correlation-id: fe1e19b5-7295-49f5-e712-08dcf8ac3051
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UDAxMjYzZ3RjRDQ1TUJWd2NXam9IdGxNM1AwSmdZRkFIeFgzSTlka3ZweTI1?=
 =?utf-8?B?NzZ1YWpCbEI5cFMvRUZhOFV3UjhhUjJVN01MbTMvZzdDT29xTmtzVGoxdyt3?=
 =?utf-8?B?eWVEMm9FUU5uRWZZMlM5RWFwZzRiaWw5US94NVhNQTBRN2grSG41U2JtbGRG?=
 =?utf-8?B?dzhXRmdobWxQdzZoVnlLK04wZUpBa0tNVG4rMER4djBKdUIrY25BNVQ4UXJI?=
 =?utf-8?B?aUVLTDNaSEtqQXROUDJFaG5KZk8zaTRZTm5jME9JSERUOERXOTJFbGdpN3lF?=
 =?utf-8?B?N1M4TmdNSVJ3TElVS0lLTHJiekFlVjBBbGdONytsaEljemxmRTNLdGlWNCtP?=
 =?utf-8?B?Z3ZYNEMrRkZJK2FSaW9QOUJRUkg1S1hmdUptbFpXQjRsM2FiK2J3MjRtc1BF?=
 =?utf-8?B?Z21uVzAvOGVUMjlvMHlSQU5MNk1ra1FaaW00bnVzYnhhQU8xMTFLNmFoaWl1?=
 =?utf-8?B?a05ncS94N25SRjNSVTF2bkVONzRIdkdYVDd2R3V3TDNDVE5lUk04ZE4yai9h?=
 =?utf-8?B?blpZREFGVFJDekZGZVhDd3h0NTVFdmdTZytWUUdvRkRXeGFTZzBIVUlOZzVG?=
 =?utf-8?B?T24wcHNQbmlGUWhzT005d1hDOXIyTXE3cVgwZmczZjgzUnA2T3BLcUZLQitC?=
 =?utf-8?B?MmtSNTBXRk9HNXpqc0s5ZHl6dG9RYnBPT1ZHNC8waXRTVGlzeG5vZ1lqdzVV?=
 =?utf-8?B?aDdlZlFES2tYRWN4c3V6MGpranV0OTdxWGsvYjhmV251MjlKQmRQa0Y0bC9F?=
 =?utf-8?B?Zzh4ODlhazVhNWRxYlRTTVZueHhrZllOSzJnb25Ma2NLOGxSNUdlWjZyZzc0?=
 =?utf-8?B?eGJkTHc1QUdsNUxZOWc1Y3gyNnJWaGRzQnVBZFJPM0luUVVkd2VIamFqWjJU?=
 =?utf-8?B?cG5vUWVvS2k4TmFRWHFUb1V4MXNKdnpBdU1HY1d0NVdyUkFSTllmUDhaK3lM?=
 =?utf-8?B?YVBnT1ZOVjBxWWk0MHpHOEFzU3hTbjZGL0RHRStDbnNvMUE2ZVJHRFJ1dWtm?=
 =?utf-8?B?YzJWdFVLMTVaQkdadVh6N0xzaW5neUxSTWd4cDk4ZGdlTjBpOGV2Q2xWWU4w?=
 =?utf-8?B?YnNJUUdHWnpEdnlwVTJxKzliK3c5UmxqeWgxMkJMRUdEaGU3QlN5N1JZb3Q5?=
 =?utf-8?B?a3RBRm05MWhZWG4rOExOcEFJNzZBOXNmclFqZmlNU2dMNnp4VSt5UXRuY1Qx?=
 =?utf-8?B?MDV0UnFuSmZWSm1nUHcyQ3FvYVBKeHhtSnFQemFmajVkMDN1bW91d1ptSnBm?=
 =?utf-8?B?LzFOS0FYZnFQZU94bEtiMVhKTlJveWVsQlpVS2ZJWGI0aDFhcTZDejZtaTFo?=
 =?utf-8?B?cXI2UXBlZUcvMER2TDdYK0lQN1F4ZEtaaFJxaitZSmdGdXhRWStQUzFpMGsz?=
 =?utf-8?B?OUkzYmluU0k3NjhpRFQ3VGttOThpV0d4SHRSSitNdjJRVGwxQWxORm03NjBF?=
 =?utf-8?B?bDBYYi90R1k2ZUkweE9CdXRjcW9CNjJ6b3JhWmtFeFFwNEl6YlJ0TFV3MVZa?=
 =?utf-8?B?bTZ3RWk1QndFVWpoRFhxT1JQM3FYc1lSNVpDMlpWRzNPSThhellWdzlENGhY?=
 =?utf-8?B?c0tuMlZmeVRBOVM1WWliQ1ZTTmtJSzFlNWxHaWsvNktPTHNBQksybXkxdlZl?=
 =?utf-8?B?QVZtWStUaVJ5L0RxRUdEdTJTdFVsRVplWmlYaWdDSWpaMWJkcVorakdrRFdE?=
 =?utf-8?B?a1VMUDAydURKY0RYSWJ4Y0N3N2ZDTTJxQ2p4OTdYMUR2aVVVenN0MWNKSXgy?=
 =?utf-8?B?bTNoZVdNL0RDd2xsMUZqVy9nbDFVTmw4b3pUa3VhTDQ5ZnZsUjN3YXJQNE1J?=
 =?utf-8?Q?j1Z/KoYYGAmLMG57ZNY0JCqBQm1K229nBaz6Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7572.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDVKRzhNc0N2cnZNVEtjM0FsNW1kd2hWTTh2ZEtNb0FUdmhDeG54V2xSK3pF?=
 =?utf-8?B?QkJtem9oUS8vZTlSNnhneGRaYlp3NVIrSDhDMzgwdENmci85VFVYa0ZaUkVu?=
 =?utf-8?B?YVRHQ29pcU5neXFSZnVUM2NMZHVmOTNIQ0dDQzR0REw5emRaMXlzUWJMcFR1?=
 =?utf-8?B?VVlwRTJZWEdnUStCcFVOaTNMeHI4d2wyYkdDaVBZOU9HY0dETDVVbVdVTzhF?=
 =?utf-8?B?bXUyeXVzZzlWcEtXWTF3OHNzajhHSFRKUzVCS0R3OTVMVW84TEI2Z0xWNWtV?=
 =?utf-8?B?WUpTMkpSUVJmZ0Vja1B1T0p5cWk1ZjVVYlJNTUd0OWFRd1VPVkxJY3lIWUpD?=
 =?utf-8?B?Y1JVSnZrOG9pZjRFVVV6Q0NjQjdRNWFzZ1pXMjZaeml6YTQvckZvN3hZY2RM?=
 =?utf-8?B?YXpOUktiS2pZbzVIa3BFbE0xNTlsY3JENWpLL0Jta3RweWhBVlpxbGpPRXYz?=
 =?utf-8?B?RlJiS0hkT2ltV2QwY2lzdUJYNzllSkNrNVRhSk1JVHd4UkpTQmlqSC9TZHJr?=
 =?utf-8?B?Nk5wcWlXNXF1QkJWbjA1L1J1cDdCREFqNUk5WFNEMWdNTTVXaHZJSEdtTGJ6?=
 =?utf-8?B?eGdKTjlUUFhDUzNEV1E3aXdVSCs5OTJJT3dmeDhhaGN5Q1BPNElreWI4cDc0?=
 =?utf-8?B?Tjg0Y0pUVmFObVpuSThIUldLWVJlWDQ3RHFhc2JrVGR3MVVtQTRaUjEzamxh?=
 =?utf-8?B?YThwKzZtSjh5SkQweSsyYnZPZkNhUytzelBUOENoaDFPLzQ0dUlHOThoWDJ2?=
 =?utf-8?B?VTlxR1pMdTRzV2ZGQ1g4NW1md1Q0dUs1Qm8xM0VlaG1EOGlna3g4cUpkeDZW?=
 =?utf-8?B?UGREWlk1elAxWmdkcUZZYXdvSmNoTW81eHNubkhxZHpsWjRLb3hEVG5SN3ky?=
 =?utf-8?B?RlNiRnFubndWakRpaTBBOTd6T0E3ZkpoNlczZmpXeHg1ZS9kMFIzY0pOK1Yw?=
 =?utf-8?B?d0syRmM5TWVXNEVOeVpuOTBjSVZzVzhkNnNDTUk5b243SGlmZndYby9YWGkx?=
 =?utf-8?B?SGdKUExYSVpNcTQvYm5GYkprOERkOStOUGxVdWxFVDkwekpFaU1wOUpGSkN4?=
 =?utf-8?B?YmV2SGQ3NytvSWxLd2pEcWJxRTE1M0k5ZFA5ZTFuaFRWQW9TK2NvcVZRa3lC?=
 =?utf-8?B?TEthZ3F5cTV0N1JER09PK3M3d09jSXgrTkpCVDdQZTFuWEpUYVZSYW0wTmxt?=
 =?utf-8?B?aGcyR3V0WXFRekVrdEd3dnFab2hiTDdYcEFYYmErMSsvbGtUVlgxZFdxZGc5?=
 =?utf-8?B?aHVVcHRBU2k2a2hIU3RmSW0vQmlYbWFkRTcrcXZnbWJxUDZlbklITmdFdjBX?=
 =?utf-8?B?aForQWkwWnpDaHFGOENRYlIyN2tWd2pCbVAyZnJKdjBXc1lWR0tFTTc2b2E4?=
 =?utf-8?B?M0V2T3F2NjJBZHgyWXlNTjEwSEVTL3Bna1RhdWdGN1NZa3lsME5ZUldEbC9H?=
 =?utf-8?B?djZpUDRlaEtOS3NSaTM0OGtFanBRY1NuckhlZmh6dTFGeUJDRXV0WHpFYVNj?=
 =?utf-8?B?a0IwQnVYMWxGd3JlbHdKdng5cHBsd2wyZ1ozS3JYdUpsUUg3Z3RMcWE4WlRm?=
 =?utf-8?B?eElRODBWRUUydjk5RE85TnlqSGQwbzNYMUpqMGpaN0tkUGYzbUpIVDZPcjNC?=
 =?utf-8?B?U1cycWcwV0JpQlIwdnk1L0g5WHdFTXl1L0dDb3IyRksvcDJoRXZBdjNKSFVa?=
 =?utf-8?B?elhrY0p0ZlZ4TEpaMVZINXg0bzV4OHRyMUFYTVFEY1dOZERFTlVYUWl2ZlNy?=
 =?utf-8?B?ZHdPKzcvcGczcFZ6b28zQTFTWWtlK2JuMU1PZEVZU3lVRG00T0Q3OUJqUmF0?=
 =?utf-8?B?Nk5WT2d5b3JQR2lQSExUbVBBc3JyczEzWGM2UnZvdEdXdW1IbVlheW9iT0hO?=
 =?utf-8?B?VmwraEJwMzNTenZ6eXBKQ3pWclFrQ2wrRUJ0UUJPeGU3Uk4zRElzdlp4VDh5?=
 =?utf-8?B?cVNRQVJRVlBmZ1R1Z1ZWNW8weXhEVmh3R1BsUUZJNEJ1VFlRWCttd3hDcFNN?=
 =?utf-8?B?T0x3TjFmZGkzWTd5TVBWMm5TMGFaYk9tZFVIVDg4K1FPeVVOc01SWVkwNFdy?=
 =?utf-8?B?L3lGVzAxQUNtNENGSlJNYXZXcXFuVS9UcDlESnIxMURzTXpLWHo3MU9XV2xK?=
 =?utf-8?B?U25kWmVLVW9MZ1IxcHBMblc4Z3ZOV1JEU2ZickhBbUNMOTZaUFF2WTdoTGRG?=
 =?utf-8?B?NUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7572.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1e19b5-7295-49f5-e712-08dcf8ac3051
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 06:29:20.8067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 78xhT6ZgRK5II7h+Wl4tu3mRIUaCVu+gnoOVAcF6Pl8p/Jif3eQ5jKXvnnrLg7+4bSsItPvqaiGLeUZIgsiidvnAm2bFH2hnf8DsADomCYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7961
X-OriginatorOrg: intel.com

PiBRdWljayBoYWNrIHRvIGV4dGVuZCB0aGUgQ2xhbmcta0NGSSBmdW5jdGlvbiBtZXRhLWRhdGEg
KHUzMiBoYXNoKSB3aXRoIGEgdTggYml0bWFzayBvZiBwb2ludGVyIGFyZ3VtZW50cy4gVGhpcyBz
aG91bGQgcmVhbGx5IGJlIHVuZGVyIGEgbmV3IGNvbXBpbGVyIGZsYWcsIGRlcGVuZGVudCBvbiBi
b3RoIHg4Nl82NCBhbmQga0NGSS4NCj4gDQo+IFBlciB0aGUgY29tbWVudCwgdGhlIGJpdG1hc2sg
cmVwcmVzZW50cyB0aGUgcmVnaXN0ZXIgYmFzZWQgYXJndW1lbnRzIGFzIHRoZSBmaXJzdCA2IGJp
dHMgYW5kIGJpdCA2IGlzIHVzZWQgdG8gY292ZXIgYWxsIHN0YWNrIGJhc2VkIGFyZ3VtZW50cy4g
VGhlIGhpZ2ggYml0IGlzIHVzZWQgZm9yIGludmFsaWQgdmFsdWVzLg0KPiANCj4gVGhlIHB1cnBv
c2UgaXMgdG8gcHV0IGEgc3RvcmUgZGVwZW5kZW5jeSBvbiB0aGUgc2V0IHJlZ2lzdGVycywgdGhl
cmVieSBibG9ja2luZyBzcGVjdWxhdGlvbiBwYXRocyB0aGF0IHdvdWxkIG90aGVyd2lzZSBleHBv
aXQgdGhlaXIgdmFsdWUuDQoNCkdpdmVuIHRoZSBvbmdvaW5nIGRpc2N1c3Npb24gb24gW1BBVENI
IDEzLzE0XSB3aGVyZSB0aGVyZSBpcyBhIGdyb3dpbmcgY29uc2Vuc3VzIHRoYXQgYWxsIGFyZ3Vt
ZW50cyAobm90IGp1c3QgcG9pbnRlcnMpIHNob3VsZCBiZSBwb2lzb25lZCBhZnRlciBhIG1pc3By
ZWRpY3Rpb24sIGEgZGlmZmVyZW50IGVuY29kaW5nIHNjaGVtZSB3b3VsZCBiZSBuZWVkZWQuIEkg
YmVsaWV2ZSB0aGVyZSBhcmUgOCBwb3NzaWJpbGl0aWVzLCB3aGljaCBjb3JyZXNwb25kIHRvIHRo
ZSBmdW5jdGlvbidzIGFyaXR5Og0KDQowOiBGdW5jdGlvbiB0YWtlcyAwIGFyZ3MNCjE6IEZ1bmN0
aW9uIHRha2VzIDEgYXJnDQoyOiBGdW5jdGlvbiB0YWtlcyAyIGFyZ3MNCjM6IEZ1bmN0aW9uIHRh
a2VzIDMgYXJncw0KNDogRnVuY3Rpb24gdGFrZXMgNCBhcmdzDQo1OiBGdW5jdGlvbiB0YWtlcyA1
IGFyZ3MNCjY6IEZ1bmN0aW9uIHRha2VzIDYgYXJncw0KNzogRnVuY3Rpb24gdGFrZXMgPjYgYXJn
cw0KDQpUaGVzZSBwb3NzaWJpbGl0aWVzIGNhbiBiZSBlbmNvZGVkIHdpdGggMyBiaXRzLiBJIHN1
c3BlY3QgdGhhdCBpdCBtaWdodCBhY3R1YWxseSBiZSBiZW5lZmljaWFsIHRvIHN0ZWFsIDMgYml0
cyBmcm9tIHRoZSB1MzIga0NGSSBoYXNoIChlaXRoZXIgYnkgdXNpbmcgYSBzbWFsbGVyIDI5LWJp
dCBoYXNoIG9yIGJ5IHRydW5jYXRpbmcgdGhlIDMyLWJpdCBoYXNoIGRvd24gdG8gMjkgYml0cyku
IFRoaXMgc2NoZW1lIHdvdWxkIGFyZ3VhYmx5IHN0cmVuZ3RoZW4gYm90aCBrQ0ZJIGFuZCBGaW5l
SUJUIGJ5IHBhcnRpdGlvbmluZyBDRkkgZWRnZXMgc3VjaCB0aGF0IGEgai1hcml0eSBmdW5jdGlv
biBjYW5ub3QgY2FsbCBhIGstYXJpdHkgZnVuY3Rpb24gdW5sZXNzIGo9ayAob3IgdW5sZXNzIGo+
NiBhbmQgaz42KTsgdGhlIGN1cnJlbnQgMzItYml0IGtDRkkgaGFzaCBkb2VzIG5vdCBwcmV2ZW50
LCBmb3IgZXhhbXBsZSwgYSAyLWFyaXR5IGZwdHIgZnJvbSBjYWxsaW5nIGEgMy1hcml0eSB0YXJn
ZXQgaWYgdGhlIGtDRkkgaGFzaGVzIGNvbGxpZGUuIFRoZSBkaXNhZHZhbnRhZ2Ugb2YgdGhlIDI5
LWJpdCBoYXNoIGlzIHRoYXQgaXQgd291bGQgaW5jcmVhc2UgdGhlIHByb2JhYmlsaXR5IG9mIGNv
bGxpc2lvbnMgd2l0aGluIGVhY2ggYXJpdHksIGJ1dCBvbiB0aGUgb3RoZXIgaGFuZCB0aGUgdG90
YWwgbnVtYmVyIG9mIGZ1bmN0aW9ucyBvZiBlYWNoIGdpdmVuIGFyaXR5IGlzIG11Y2ggc21hbGxl
ciB0aGFuIHRoZSB0b3RhbCBudW1iZXIgb2YgZnVuY3Rpb25zIG9mIGFsbCBhcml0aWVzLg0KDQpS
ZWdhcmRzLA0KDQpTY290dCBDb25zdGFibGUNCg==

