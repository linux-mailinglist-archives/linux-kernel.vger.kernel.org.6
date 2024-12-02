Return-Path: <linux-kernel+bounces-428380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEC19E0D8C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 548DD2832B2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 21:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6651DF261;
	Mon,  2 Dec 2024 21:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XbjA1XQw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CB71DEFD3;
	Mon,  2 Dec 2024 21:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733173793; cv=fail; b=soCH0/ZRAf3DFv3UiHX1t/jEfq4oucR3/qobGxvZVYNFlJ68MecvsqwXhCjA/lv54Y9zHAmoQ+RRka7/hQwD6VsZ+L17H7kbd3g/QLD0SDpGnTTL+UmUalLZNauKJ4h+m/mIs1tUXS5BCNZ7YT5/JJqfDWgFeSFTdx1qFxpdTNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733173793; c=relaxed/simple;
	bh=iHsKcHRDcZci1EbbuXuz6rpsKi0nYJcIPpSKiZGU/PI=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=thuK1KdvgkvjEzbWOrl93VTdPBd/Qtc1KV8SSx10TVsnYT/DQVoVGeSd8s2DMjtFyWdxCY/HP8+qq3LW4rboByxpFhrTmQ4Vn9B+kScTrR/THzirY546eCP9yoSWP4vvsDagi+EMAmgDUEZS+3qiqjdJVVhgjrtPODhrhpYmilw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XbjA1XQw; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733173791; x=1764709791;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iHsKcHRDcZci1EbbuXuz6rpsKi0nYJcIPpSKiZGU/PI=;
  b=XbjA1XQwmXVV2It3O9KMFPfR0ZYQySvfSBGjFmU5MsaJfqMgOf43fYSU
   nSfgvzhmDPBIqaVOCIPMvfFsIBSazm2/K67tmhQer0N/cW3qfxX1LjkeK
   zVj+ZEgazNiVs6GoXwFhwGAncXqkaI2UWWAJ6XTmd3yfsRVKHDYWwQaK3
   LJ/HEQmTyg7/sOdVglMqPqAqgOjqgmAU8G80oigaGlyXO/ZdTctEtBqPe
   NOUOGVN+y+xbD6qOqyspWrhYw6thl0Y3wJSRsoAFNtuiSxBOpCSieuokw
   CNKqLCztd58U9qmAXeHOtTyVgpWuqmuyMCnoCHF9Lm5uUGkxeneeane1j
   Q==;
X-CSE-ConnectionGUID: lPqIUsXKTJif3G4+dvpxIQ==
X-CSE-MsgGUID: tSkzO75hTTK7x6PyAbhDvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="20953175"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="20953175"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 13:09:50 -0800
X-CSE-ConnectionGUID: w+n7XOZUQlWy/daGYtpIOQ==
X-CSE-MsgGUID: hZwRRFrcQAqXakRk8Laeng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="93312170"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Dec 2024 13:09:50 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Dec 2024 13:09:49 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 13:09:49 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Dec 2024 13:09:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scqDDiGIVeXF5dcmD0wr7CAPh/Kg4S6oQ6Txa5oNH4YHxqw+wW9+q2dv8qHdWHQw+RQnu9mUuJxn4aD4Onq3gf0qHW5iM+suXKbYuM+VJYfhU1MGCgEg4Kqj9mbUupSzRBo/HSZ/TjNz9hkch3U69k/me1GaO4SEQzKti9OYG/1HCVnjZyLTl0ShFdccNGSHR7i8nMNmyZkEZEyP1HgBvXTrsgyU79N78ysjRKHSxsH/WoNJWgY0INdSqYfoBZx0BAlXEG3hc05LcPhOMKyjLMfjDqF+Va8ARAE8p9W52lWhomcLkMDe8FYM8KEAdBqAKKtPm2CHWFMgZ8cwWwn3Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGth9Pp+0zs55kbrQ184LJ3rCm6cPll5IJ9gACi8ng8=;
 b=SliVZjuItFc/z9+bEwTHB8URi/vDnCebUqgFHW+/o4acSPtoe1apwE9TgsMj8BxDS5SxWH/gvKyVwfAcIv7Vg+yEivDp90TJ12FnyZd/8AfrogU97MYm4+3dq6dg+UgHB63hEVsNG6Hmb0+yVOHey/bzJ91tJDoA0nvb+CtNN8hVl0yOBB2vgIio/dJ+AgWXLM7Y//p3yPKVGWGYhOPtUROVkitLIcgeeyacDKb5gWZARFbPTgd+v/jeRg/SNpYZMyoNrFalcmpDm25gU3M71KIizxSk4Dpt0Gh4DtJ22EjO4/7m1N2m7udCXPD7K33nF/VLqJChEKLC6PeevP7G3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW3PR11MB4761.namprd11.prod.outlook.com (2603:10b6:303:53::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Mon, 2 Dec
 2024 21:09:45 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 21:09:45 +0000
Message-ID: <83abb31a-c2a6-4319-8b56-174b7848f4ec@intel.com>
Date: Mon, 2 Dec 2024 13:09:42 -0800
User-Agent: Mozilla Thunderbird
From: Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v9 14/26] x86/resctrl: Introduce interface to display
 number of free counters
To: <babu.moger@amd.com>, Peter Newman <peternewman@google.com>
CC: <corbet@lwn.net>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <fenghua.yu@intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <thuth@redhat.com>, <paulmck@kernel.org>,
	<rostedt@goodmis.org>, <akpm@linux-foundation.org>,
	<xiongwei.song@windriver.com>, <pawan.kumar.gupta@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <perry.yuan@amd.com>,
	<sandipan.das@amd.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<seanjc@google.com>, <jithu.joseph@intel.com>, <brijesh.singh@amd.com>,
	<xin3.li@intel.com>, <ebiggers@google.com>, <andrew.cooper3@citrix.com>,
	<mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <tony.luck@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<maciej.wieczor-retman@intel.com>, <eranian@google.com>,
	<jpoimboe@kernel.org>, <thomas.lendacky@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
 <265f3700ac0c0d33703806fdc3d096b08c992efc.1730244116.git.babu.moger@amd.com>
 <0dc08082-0f3f-4acc-9285-b925a4ce3b02@intel.com>
 <5d426af4-a947-4115-b7b7-4eeecfa13fec@amd.com>
 <c587f94a-7920-49cf-94b1-4c52140db914@intel.com>
 <ef92f1fb-086c-4ee1-b8ec-e08ed68f963a@amd.com>
 <e065b193-dbcc-451b-98db-68a5a69e6ae0@intel.com>
 <20959b58-a882-4ef7-bd11-e8bb0a998945@amd.com>
 <1a93f4e3-d3d2-4764-90d1-728b9cb70481@intel.com>
 <36d8fe9f-0000-4d0d-a097-efddc3881a2a@amd.com>
 <5aa7924d-b27d-4ee6-b8dd-4bae0e25267b@intel.com>
 <CALPaoCj+zWq1vkHVbXYP0znJbe6Ke3PXPWjtri5AFgD9cQDCUg@mail.gmail.com>
 <4bf82744-da09-43c3-b8f1-7fc203d1c1c3@amd.com>
 <CALPaoCjL6FEmVgX-h3_GQEVZNAT3FcH34t9o1PwbUacVzXjZPg@mail.gmail.com>
 <18adb251-b340-4820-a808-e1583b44480a@amd.com>
 <5a08b85f-af79-4294-b953-5957503e2caa@intel.com>
 <5a8eaf67-baaa-4278-abe5-cf68f795d4bf@amd.com>
 <c9b0115e-d994-4239-b2b2-12359878ec7a@intel.com>
 <03b5f7f2-d347-44de-85bc-0a346651d487@amd.com>
Content-Language: en-US
In-Reply-To: <03b5f7f2-d347-44de-85bc-0a346651d487@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0269.namprd04.prod.outlook.com
 (2603:10b6:303:88::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW3PR11MB4761:EE_
X-MS-Office365-Filtering-Correlation-Id: 198f8798-1df7-4511-6884-08dd1315a5d6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFY0dkV4WFo1L1pEdUpEcjZqcTlxK0svZk5ISERXbytCQzBLVDFjeUdJcjVa?=
 =?utf-8?B?UmpBK20weDlOMFo3MnpzaGRaOU1MMkJYSGhibnZxL0VQeU1TM0paMGtXMW90?=
 =?utf-8?B?QXFRKzhQQVc1QW9rSWZrc0ViTWl1TU9KdHIrLzV3QllPOVY0YUtpcTJ4V2pS?=
 =?utf-8?B?SzJyOWdKcWdCeHdsWFptaDMzc1ZEUVNjbXArcnpNQjRXVkdyV1NiSlVwSkdE?=
 =?utf-8?B?M2w1MmtIeS9LZjlib2hTWkYrc2dVTWk3Tm1ZVk9XOU5wVlhMWFV1b3M5RHli?=
 =?utf-8?B?aUJ6SXFmN25sZWFCd3pMdG5CTi9YaWpMRlhvTlEveDl2cWI3ZjlKNmxMZlFv?=
 =?utf-8?B?WlRaV29MellHL29NYVdTdzBqcWxkL0VPR3FNdDdoUzIyRFZmdC9WNjhYcWpH?=
 =?utf-8?B?TEJ3R295MHA0U1I2MDZlRXdIdXU2N2FvcjdtRGxVdnozT2pZQ0NkL1ErTSta?=
 =?utf-8?B?UWpJcDc5Q2J5VThsVVNsTnVLNTJXcHdMRGR4MHlIbFRmT1dWOW1rZmc3SzJq?=
 =?utf-8?B?MVJBVkttSHN2U0wxTnpmSDJjWkFYb0toTWUvM3haSFZxQnI5Qm5yUzlCWnJW?=
 =?utf-8?B?blJzRzY3ZHFVM3UrRmQwVDZrMHY5Q0dXZUNoL1Z5R3VzK1g1UGtmZldiN1Y3?=
 =?utf-8?B?WkhQWThnU1JSdXc3RmhSUkljdDFhdlZNcUtzNUxFU0VLUThtNzl3Uml4QXk1?=
 =?utf-8?B?RWcxM0R2N3ViOG80bWlxcnpSdmtDQm0zcVpwMTgyUUdQQ2szN0hQK0dsS1k3?=
 =?utf-8?B?Q2RoTmZxRjQ2SlBKcUx1Vkc5OGZXcU1zUVQ4KzdkTlY5cTZNYlpvUG85M3RU?=
 =?utf-8?B?dWlpdlR6QkJ4d0h4UXlQbyt6R2d3RjBDaUlOdmZ3eHZzTWQyeXNWS0d2M0xQ?=
 =?utf-8?B?bDZqTGFtZmJtU3BBdjNhWENFMWViUkdXeWFNOFJySGFtYkZ0c2xtTVd4RkpQ?=
 =?utf-8?B?ejVKU01KNzE0M3MwY0tPYXBLNS9KV3Z2WXY2blVDNi9JWllDODZSV01PaHZt?=
 =?utf-8?B?Q3pQcjhxN3dVYURNdmZrRlRXYVVxdHY0bUxIVllIcG5qcG1vVm8rZDdYQWV0?=
 =?utf-8?B?ZklRZ282eHY1NnQ5aUx5b0dJRmY5b0J2NGFUeHh1RnoxNzB0cnF6ZDFnR1J4?=
 =?utf-8?B?U21vNlUwZzlCK1htbFh4TWNGUiswaHpBNGZYamhGNHNIYlF3VW1UdkxwWEIr?=
 =?utf-8?B?VXhPQjJFcHd0YThmWjlDUjZNcHhhTGJ1YjlEWW43UlVnSVlpS0owdjhmT2tZ?=
 =?utf-8?B?TGFGWnRXN0QzbTV2TThpM29YNkFyRjVPanJCZGE2UGFLd2F2NDVQMXZXdlNo?=
 =?utf-8?B?bWNwM0dBS3p4c2JuNlR0Wk9yakxFak5sTnBWVm5uVlRiUkNIK0pYWG5VR2tt?=
 =?utf-8?B?U0cxYnVOYlE0N2pHd3cvYlRKTGpwZjh6YTI2dUYrYy9UWkhLTEtET1dxRGpL?=
 =?utf-8?B?TVcrZjN6bWpoV2dab056SFloT0E4eFUvaWorakFOV0FlcUN5ZnowRkxuNlI1?=
 =?utf-8?B?NWNtUDJ1SGE0MjFWRGNhS3REUGowM0l3MnZJR2NGMjYrVTN4Z0hNVzBXVllK?=
 =?utf-8?B?OGJoVlpSWVZKekpsMXRhbGZGTFlTU2lIaFlYZ000U01hWmhEU1B2eWNGemYv?=
 =?utf-8?B?ZWZNZHdGN3h2YjlpWnM4cXo0ODRYTU5hY1VhWnUxSHdyT1pocXFuemNPeTdC?=
 =?utf-8?B?NTRmZnFJdktFM3pmNHZnZzFlNytpWWx5SHRhb0UyRVprRFJBRVlZVXV0aDBv?=
 =?utf-8?B?enJNRFZZYXpET1UwbGdTSGNCYmp2OHpYajNHTFdtenBDRHpsV2JnZTlDRjY1?=
 =?utf-8?B?Zm5KY29RbDl4Y0lOaGFyZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUNaY1BRRnh5TlBQdWRUL1d1SVIyenJ0SHRvSk1FKzBEYkVIN1NZeC9ibzkz?=
 =?utf-8?B?VGdZdnU0NWp6cTZWTWUxdmZmQTVnZGNPc0tIcHdRK0dHMVVUaEdJWUpaNDlK?=
 =?utf-8?B?RTgvZWFCLzZqNnBvWTFRMmxZT3RKT25pSUI2Zmt4eEZ4Q3VVQk94RUZMUzc4?=
 =?utf-8?B?aEJWTUdnMmRXOUF5SjFEU3lCZ1lzckV3ZEJPSWl6OXRJcHFwSDNXK21nY1lt?=
 =?utf-8?B?L2NvUVhXQXRvaGJ4VGNxYjlaL0E1eFNnekxyYnhSNi9YNWNmM2xVbER3UmdP?=
 =?utf-8?B?amdwUVBUSHMxWjhIb0ZVT0tTUC9Cb2trSlNzZGNPQTV6RWdFSncyK1piNEtX?=
 =?utf-8?B?MjZhRmZqbmI5SkJFR2hveXhnL28xajNtM1AyOHhtdkRKM3NPN3MrNW1MNUhp?=
 =?utf-8?B?WTVBZXVGSTNFZ2F3SVhCTFBkVkh3U2ovYUtJSnEwcTVQaVl0Mk1PMWt6RG91?=
 =?utf-8?B?RDdBeWxERXdHclhxWld6TFBsb3dzb0NGeWRwdmtJUCswK3RyZjVPZERtMUsx?=
 =?utf-8?B?RzhmN2JwbVRhUWRoSkJlRjJzMWtrTVhva1dDOUV5blpab0grVHphYmU5WGdJ?=
 =?utf-8?B?cGRsTE9DRE5pT0pBL1htTkNTcE0rNDVKY1pIdjBTT0hOZGJRaFNzWUJhRkl6?=
 =?utf-8?B?V0RhcE1xaVVEMWU5VzdoTlpmclVMandSK2xya2h5ZCtDZWNaYW1NSUYzb1ZW?=
 =?utf-8?B?S3dJZ2NJczFwRTVyOUZsdGxPREU1Sk1WUXRqZEZlNk9zbWxZdy8yWGdGTVkw?=
 =?utf-8?B?cU1PTW5FRW90S1FoK1BEbTdDS0xTYnhWSDluVzJ0QTM2UmlNNFovTUpZRmJI?=
 =?utf-8?B?eGY0bDRkb21FQ25JTlVucDNnWTROQ215a2pML3YyVkhVcHRRNFhDSldzS3Qr?=
 =?utf-8?B?bE01YSs4cU1CdVZaeVN6R0Zqb01ZaVo2UE12TzJ1Y1VOWXF0eXZwVXB2Ylp2?=
 =?utf-8?B?NS8vb2M5dDBkWUtnUjlSWGMxL1piem52dmtUNmVZeXdLSW9EQ3FwNDh2dUxW?=
 =?utf-8?B?RWNLWEEwWlV4Q3AwYnJGOUpSQ21RTXlHTVAzbHVNaWs4ekkvTXNMQ25tVWdY?=
 =?utf-8?B?Slpwa1lFNERSKzJzSU9lYXY4RWxBM0srZGdMYmlQWjZqeHlTZEc1VmJKVndh?=
 =?utf-8?B?b05lemF0WU5wd3dCbXd0RG5QeHppd2VHRFFEc2Z1L3ByTlhRY3pWUFFKdVlm?=
 =?utf-8?B?c2VSam14RXpJeWkzcENhV25hSWcxTnRhcGMvQ25NeEdZc2hqM285UEEzbEt4?=
 =?utf-8?B?d0VBNmpmdzFMdmsrODBiZkRDV2o1cXEzQ0pQbEowbVRWdUVkWTZJeU5DbTIx?=
 =?utf-8?B?YXNFQlhDMkN1YkpwQ3lIWERqSElHdkFqbjFRMWp3d3lGVmR6SFBSbi9jWXBW?=
 =?utf-8?B?R1JwZTdoVFBQWkV4Y2xXZkJuY2F3MDRaK2FpRWpWbExFajhTQktJT29JUlRE?=
 =?utf-8?B?YVVQaVE5QklaZE1qcGpleFdnVm5vd3pKYmhPaStFUFVSNCtKa2J0clBrRUF2?=
 =?utf-8?B?TStvUTdwWHRKMDUzRWw5T25RaEhOeTgyUmxEUXhJU3Q2R2RackRUbG5kQUJk?=
 =?utf-8?B?UzVXcUUxK3pkcGtMMWQ4L1UxcXE2ZE03NFBjQ3d4aklEZG9wWVpNWWxNbVRW?=
 =?utf-8?B?V1JyUGZPaVA0STVIUy9JYXhiODJhbWM2TnRuZ3dFZSs5NnEvM3FHQVVHelBT?=
 =?utf-8?B?MW92Tmx1OFl6QWhUdmlQQVdmSVVUWHVUSmtDbjcxRGVuaWwrNU1wOGpsODZq?=
 =?utf-8?B?WU5hSEVEbU1ONTY5YXA0TThydXBvOHQrbjF6K3pyWlBOTmZVVE9YNy8vYVhq?=
 =?utf-8?B?V2Q0Tkh5ZE1JU0tzVFFHNWQ1Ny9vc2VpWnZOQ3JVM0VkRnh3YjJDYTViMWc0?=
 =?utf-8?B?Z1k3ZlBGNjhUeExnSiszWUZXUWcrS2FUZTdNczFISFhLRlY5R2xBZk0rR2ZQ?=
 =?utf-8?B?ZlNLZndxRTlDOFRXdFlVc2hRMTkzdlJvUjFHbEQ5bjlnSU4veHJydkdMU1B2?=
 =?utf-8?B?WFZ2RTBTdnFTNVdQSVpKTjNwMXRnSkVuZG5ETld3UDlPYmtydWRQbFo2dXZC?=
 =?utf-8?B?UmRYamhQNG91MmV2T3lQdGovbE5Md01qbDkweVBaaXhKT0wzR1o1anBUMnBD?=
 =?utf-8?B?VWtNVHZDVjI2TmNHQXc5Yk9wdVNQbFlwY3hZcTM0bHEvUG0vcEg2c0ttUTFW?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 198f8798-1df7-4511-6884-08dd1315a5d6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 21:09:45.6059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bilZ4plSX2MkXz5yto5g2p38pTaGgykAfYn6tNF5MTFSEpMnc6pBTxYVv1bZoz9jgpTurGh84AQTWruHyfP7DZH8u0d0KXat0wSaLmCJwXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4761
X-OriginatorOrg: intel.com

Hi Babu,

On 12/2/24 12:42 PM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 12/2/24 14:15, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 12/2/24 11:48 AM, Moger, Babu wrote:
>>> On 12/2/24 12:33, Reinette Chatre wrote:
>>>> On 11/29/24 9:06 AM, Moger, Babu wrote:
>>>>> On 11/29/2024 3:59 AM, Peter Newman wrote:
>>>>>> On Thu, Nov 28, 2024 at 8:35 PM Moger, Babu <bmoger@amd.com> wrote:
>>>>>>> On 11/28/2024 5:10 AM, Peter Newman wrote:
>>>>>>>> On Wed, Nov 27, 2024 at 8:05 PM Reinette Chatre
>>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>>
>>>>>>>>> Hi Babu,
>>>>>>>>>
>>>>>>>>> On 11/27/24 6:57 AM, Moger, Babu wrote:
>>>>>>
>>>>>>>>>> 1. Each group needs to remember counter ids in each domain for each event.
>>>>>>>>>>      For example:
>>>>>>>>>>      Resctrl group mon1
>>>>>>>>>>       Total event
>>>>>>>>>>       dom 0 cntr_id 1,
>>>>>>>>>>       dom 1 cntr_id 10
>>>>>>>>>>       dom 2 cntr_id 11
>>>>>>>>>>
>>>>>>>>>>      Local event
>>>>>>>>>>       dom 0 cntr_id 2,
>>>>>>>>>>       dom 1 cntr_id 15
>>>>>>>>>>       dom 2 cntr_id 10
>>>>>>>>>
>>>>>>>>> Indeed. The challenge here is that domains may come and go so it cannot be a simple
>>>>>>>>> static array. As an alternative it can be an xarray indexed by the domain ID with
>>>>>>>>> pointers to a struct like below to contain the counters associated with the monitor
>>>>>>>>> group:
>>>>>>>>>           struct cntr_id {
>>>>>>>>>                   u32     mbm_total;
>>>>>>>>>                   u32     mbm_local;
>>>>>>>>>           }
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Thinking more about how this array needs to be managed made me wonder how the
>>>>>>>>> current implementation deals with domains that come and go. I do not think
>>>>>>>>> this is currently handled. For example, if a new domain comes online and
>>>>>>>>> monitoring groups had counters dynamically assigned, then these counters are
>>>>>>>>> not configured to the newly online domain.
>>>>>>>
>>>>>>> I am trying to understand the details of your approach here.
>>>>>>>>
>>>>>>>> In my prototype, I allocated a counter id-indexed array to each
>>>>>>>> monitoring domain structure for tracking the counter allocations,
>>>>>>>> because the hardware counters are all domain-scoped. That way the
>>>>>>>> tracking data goes away when the hardware does.
>>>>>>>>
>>>>>>>> I was focused on allowing all pending counter updates to a domain
>>>>>>>> resulting from a single mbm_assign_control write to be batched and
>>>>>>>> processed in a single IPI, so I structured the counter tracker
>>>>>>>> something like this:
>>>>>>>
>>>>>>> Not sure what you meant here. How are you batching two IPIs for two domains?
>>>>>>>
>>>>>>> #echo "//0=t;1=t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>>>
>>>>>>> This is still a single write. Two IPIs are sent separately, one for each
>>>>>>> domain.
>>>>>>>
>>>>>>> Are you doing something different?
>>>>>>
>>>>>> I said "all pending counter updates to a domain", whereby I meant
>>>>>> targeting a single domain.
>>>>>>
>>>>>> Depending on the CPU of the caller, your example write requires 1 or 2 IPIs.
>>>>>>
>>>>>> What is important is that the following write also requires 1 or 2 IPIs:
>>>>>>
>>>>>> (assuming /sys/fs/resctrl/mon_groups/[g1-g31] exist, line breaks added
>>>>>> for readability)
>>>>>>
>>>>>> echo $'//0=t;1=t\n
>>>>>> /g1/0=t;1=t\n
>>>>>> /g2/0=t;1=t\n
>>>>>> /g3/0=t;1=t\n
>>>>>> /g4/0=t;1=t\n
>>>>>> /g5/0=t;1=t\n
>>>>>> /g6/0=t;1=t\n
>>>>>> /g7/0=t;1=t\n
>>>>>> /g8/0=t;1=t\n
>>>>>> /g9/0=t;1=t\n
>>>>>> /g10/0=t;1=t\n
>>>>>> /g11/0=t;1=t\n
>>>>>> /g12/0=t;1=t\n
>>>>>> /g13/0=t;1=t\n
>>>>>> /g14/0=t;1=t\n
>>>>>> /g15/0=t;1=t\n
>>>>>> /g16/0=t;1=t\n
>>>>>> /g17/0=t;1=t\n
>>>>>> /g18/0=t;1=t\n
>>>>>> /g19/0=t;1=t\n
>>>>>> /g20/0=t;1=t\n
>>>>>> /g21/0=t;1=t\n
>>>>>> /g22/0=t;1=t\n
>>>>>> /g23/0=t;1=t\n
>>>>>> /g24/0=t;1=t\n
>>>>>> /g25/0=t;1=t\n
>>>>>> /g26/0=t;1=t\n
>>>>>> /g27/0=t;1=t\n
>>>>>> /g28/0=t;1=t\n
>>>>>> /g29/0=t;1=t\n
>>>>>> /g30/0=t;1=t\n
>>>>>> /g31/0=t;1=t\n'
>>>>>>
>>>>>> My ultimate goal is for a thread bound to a particular domain to be
>>>>>> able to unassign and reassign the local domain's 32 counters in a
>>>>>> single write() with no IPIs at all. And when IPIs are required, then
>>>>>> no more than one per domain, regardless of the number of groups
>>>>>> updated.
>>>>>>
>>>>>
>>>>> Yes. I think I got the idea. Thanks.
>>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> struct resctrl_monitor_cfg {
>>>>>>>>       int closid;
>>>>>>>>       int rmid;
>>>>>>>>       int evtid;
>>>>>>>>       bool dirty;
>>>>>>>> };
>>>>>>>>
>>>>>>>> This mirrors the info needed in whatever register configures the
>>>>>>>> counter, plus a dirty flag to skip over the ones that don't need to be
>>>>>>>> updated.
>>>>>>>
>>>>>>> This is what my understanding of your implementation.
>>>>>>>
>>>>>>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>>>>>>> index d94abba1c716..9cebf065cc97 100644
>>>>>>> --- a/include/linux/resctrl.h
>>>>>>> +++ b/include/linux/resctrl.h
>>>>>>> @@ -94,6 +94,13 @@ struct rdt_ctrl_domain {
>>>>>>>           u32                             *mbps_val;
>>>>>>>    };
>>>>>>>
>>>>>>> +struct resctrl_monitor_cfg {
>>>>>>> +    int closid;
>>>>>>> +    int rmid;
>>>>>>> +    int evtid;
>>>>>>> +    bool dirty;
>>>>>>> +};
>>>>>>> +
>>>>>>>    /**
>>>>>>>     * struct rdt_mon_domain - group of CPUs sharing a resctrl monitor
>>>>>>> resource
>>>>>>>     * @hdr:               common header for different domain types
>>>>>>> @@ -116,6 +123,7 @@ struct rdt_mon_domain {
>>>>>>>           struct delayed_work             cqm_limbo;
>>>>>>>           int                             mbm_work_cpu;
>>>>>>>           int                             cqm_work_cpu;
>>>>>>> +     /* Allocate num_mbm_cntrs entries in each domain */
>>>>>>> +       struct resctrl_monitor_cfg      *mon_cfg;
>>>>>>>    };
>>>>>>>
>>>>>>>
>>>>>>> When a user requests an assignment for total event to the default group
>>>>>>> for domain 0, you go search in rdt_mon_domain(dom 0) for empty mon_cfg
>>>>>>> entry.
>>>>>>>
>>>>>>> If there is an empty entry, then use that entry for assignment and
>>>>>>> update closid, rmid, evtid and dirty = 1. We can get all these
>>>>>>> information from default group here.
>>>>>>>
>>>>>>> Does this make sense?
>>>>>>
>>>>>> Yes, sounds correct.
>>>>>
>>>>> I will probably add cntr_id in resctrl_monitor_cfg structure and
>>>>> initialize during the allocation. And rename the field 'dirty' to
>>>>> 'active'(or something similar) to hold the assign state for that
>>>>> entry. That way we have all the information required for assignment
>>>>> at one place. We don't need to update the rdtgroup structure.
>>>>>
>>>>> Reinette, What do you think about this approach?
>>>>
>>>> I think this approach is in the right direction. Thanks to Peter for
>>>> the guidance here.
>>>> I do not think that it is necessary to add cntr_id to resctrl_monitor_cfg
>>>> though, I think the cntr_id would be the index to the array instead?
>>>
>>> Yes. I think We can use the index as cntn_id. Will let you know otherwise.
>>>
>>>
>>>>
>>>> It may also be worthwhile to consider using a pointer to the resource
>>>> group instead of storing closid and rmid directly. If used to indicate
>>>> initialization then an initialized pointer is easier to distinguish than
>>>> the closid/rmid that may have zero as valid values.
>>>
>>> Sure. Sounds good.
>>>
>>>>
>>>> I expect evtid will be enum resctrl_event_id and that raises the question
>>>> of whether "0" can indeed be used as an "uninitialized" value since doing
>>>> so would change the meaning of the enum. It may indeed keep things
>>>> separated by maintaining evtid as an enum resctrl_event_id and note the
>>>> initialization differently ... either via a pointer to a resource group
>>>> or entirely separately as Babu indicates later.
>>>
>>> Sure. Will add evtid as enum resctrl_event_id and use the "state" to
>>> indicate assign/unassign/dirty status.
>>
>> Is "assign/unassign" state needed? If resctrl_monitor_cfg contains a pointer
>> to the resource group to which the counter has been assigned then I expect NULL
>> means unassigned and a value means assigned?
> 
> Yes. We use the rdtgroup pointer to check the assign/unassign state.
> 
> I will drop the 'state' field. Peter can add state when he wants use it
> for optimization later.
> 
> I think we need to have the 'cntr_id" field here in resctrl_monitor_cfg.
> When we access the pointer from mbm_state, we wont know what is cntr_id
> index it came from.
> 

oh, good point. I wonder how Peter addressed this in his PoC. As an alternative,
could the cntr_id be used in mbm_state instead of a pointer? 

Reinette


