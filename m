Return-Path: <linux-kernel+bounces-378847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEE89AD646
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A41B81F25C4B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAC01F9A98;
	Wed, 23 Oct 2024 21:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V0Uq5Q/H"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DBF1E8828
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 21:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717405; cv=fail; b=uUMJuQqBOgCbbz7o9lz0rqnVRf3Rzat6PB2jFW31D7UxgZUxWpzPOWnpYMjcU8tmZGWiqYTzCwuJepYiJBfg1HKwq+I/xiYt4wOR7EFcgdJYLygaOLX9+4l4EOk9ODKVLBjOqxCFsgQWZNs4uV5Uu5pvJVLYNxdMMLrDivrE+08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717405; c=relaxed/simple;
	bh=Y1w0GIL29YSWzaWzDh5PMNL1SqyZRtzByIEf11Mrx+g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PqUDfJPW1/lZZxWVvk6xnVYG0GtkoUMsRf2jdCD7VVuBGPWvWYhzNsT9y4TVknSYL5PjzkrIh+LlXYN/aT3gJg7ZGhoIpPFW5II7fKLCnBRG+dWL6smCKRYewpq2rwpKTG4aVtBp4ZrhjPfrRy41g+uXGn83hI3ZxGEgj6K/TU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V0Uq5Q/H; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729717404; x=1761253404;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y1w0GIL29YSWzaWzDh5PMNL1SqyZRtzByIEf11Mrx+g=;
  b=V0Uq5Q/H/f+ldk8Z5g8sPu8DtfnOprIKggD8ocAElaQBfPVVRWLw5GaF
   YUQjsIyk1GurF61Vo0DomUH8GEpJwUp3pQkPhSuEeKv1bAGanfjWCY8hQ
   yXsE3+MHhoUsNYobs+mxkmDHT0cqPVxuhmWpCmJdG3r5Pb5ap0bv+XY/l
   s63XxiVT59X1/5g2PmfrIOlKV+870rbJggxE1lDeJcpKyU5RrvWgFt0yM
   OgnqpfixXxpvBFKBSpERFsZMNgewC5JZ1iqMuwYw/cez52/PSrBsNQvT6
   Yge5C1tmOHboeLORv1OOyvbIu9uyZi8fGzBp4WZ45GobKjz24WpBF08po
   Q==;
X-CSE-ConnectionGUID: qTkn1Rv0QxuYcOuZhgHvMA==
X-CSE-MsgGUID: I4bU3cDQRfGsQ/HU6wbxrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="40718530"
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="40718530"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 14:03:22 -0700
X-CSE-ConnectionGUID: svF8dlR/QZWzr805lZY3Sg==
X-CSE-MsgGUID: oqUyQAHsRDihPoaqhAJqWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="85498308"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 14:03:22 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 14:03:21 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 14:03:21 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 14:03:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Busw4bnkpRdQTIVNpZhhZhNmDyiQJ9Xwdx0lDvN/A+IRlevc9131vD2wrmBKaWCDsGXNnYXAMoj3GrGGeaJQ8ljOJZWFeoR4+P+h39p7i/6oLjQX6aNpTSc9/mLiaMgCmpLPK4FeLA7CkDFN3DwGMNhioOWONuSr3v5UEB/EY7X+tmpNHv5zzsOsu3X3PTlhcxKtJsP4UTYxmQmkX+nm7umVBkQYMrcmnI0wo3jCvt89/zy4Cuqx7x5EWdsqX0Ecl4+30DgL2uJ5ch4BDJVf8Fzyz1VNv2OD81UCTlFKEeFVAy5gqUeQcLFqNXwgQXrirTtYLxhHQ5fJLED/tMVQag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YS4xuNu4lLcDgyNHdkg3ATXzryYV1ohDsMMPAS8P77I=;
 b=Zo3vFl6h1pmxrJveUwkJI4APDD/3x2YHhrGsre1N3phuMZ0zwHT9O17/LWr5viSr22Mi1yLKYpZsMG/hmqQG7OEVus9/eLCqCm3ePRa4Vi1ryngYeHZJPGzasK2iJ05cQjNEfMwBqWWrVjAQQSSpMeyf1lqmQCPAp4UTstdRgMiepnXVdoRIvTG89pB2h/kPi6zYz3QPI0xDvGAe60X1XDNaCuXIZ2el5sGIEWJSIUphRd4VDhTtSmS+JE7ZqKXyaFSXAfvCEx3pL6gotHNXF3ex9lkk4miuhvyrRm4bXK22to4KU2smJX07+aNE99XqnmD7nYkZOc+Bqt09yWo94w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6833.namprd11.prod.outlook.com (2603:10b6:510:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 21:03:13 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 21:03:13 +0000
Message-ID: <ee50eaf5-9a21-4183-bef3-d2c34ef82375@intel.com>
Date: Wed, 23 Oct 2024 14:03:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/40] x86/resctrl: Add a helper to avoid reaching into
 the arch code resource list
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>
References: <20241004180347.19985-1-james.morse@arm.com>
 <20241004180347.19985-3-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20241004180347.19985-3-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0090.namprd04.prod.outlook.com
 (2603:10b6:303:6b::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: e9b1c94f-dccb-4be4-569a-08dcf3a61bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmtzVEw1VlhKR25VRjZhc2V6YzRnbGF1cDdRRXRJcDUzRVBvbTBZbmdlYjVB?=
 =?utf-8?B?QjhXT2Jjd0ZFdHhwZFJJc2pVOG1CLzlVbzRlSDR4R2ttSjlsYXd3N2xGL083?=
 =?utf-8?B?TVVZTmJ2RGRNUSsyek91STRKSnlsNDlIYjlkQjdYT0J0cUNBQ1BuUUhnQ0o1?=
 =?utf-8?B?LzAzQVJTK2Jvc3lZZXJFY0FMRGNuUnFOUm50RFY2WkNQSGNvcmtDS3NjSjhy?=
 =?utf-8?B?aG1UbDFzZ1p4b2ZGVGVhVlpGQ2REdGRlQWJUZmFweXJ4Y1F2eXBtWWg2bGt0?=
 =?utf-8?B?M2xXVmpIaFY2Q2FsVVNyTEdkTG8zNDh6RndNMVN1ZkVSa2p4T21UNlFnTUJ2?=
 =?utf-8?B?dkVMaENKTCtjc2tCZ0QvU0ZxOWpjTlFXQWtQc3pzMW1OZ2xGT0RpaUMrd2Vr?=
 =?utf-8?B?bUxjREVvaHBXZ2pybGVheUNXR2psYmljL0d1UytYRENLTko1aFQ4Nm84QW5U?=
 =?utf-8?B?ZmgrWWVWd1NQeWVRNGlBNFdBUytubitNRWJvK0xuTDJ4cmlxRWExRitoTjBw?=
 =?utf-8?B?OG5jOGNtdGE5bExKZjY4cWs1QW43Wi9mYml6Wks3L2tjMXZWVWhUVkRyUGpQ?=
 =?utf-8?B?U0JuNC94WjRXWEUwZE5VaW94bm1PZXNZUWxrTStjZzJWL0p1NG5JT3NiT05v?=
 =?utf-8?B?RSswaGphMG9HQ3I5VzRxa21LSWpPckd0TGFmbnllNWlKRThFZlhOWGFxY0Fu?=
 =?utf-8?B?dUgvS1hNTkE4U1lIb2VTYStKMGozNWJidmZrUWxLaXBHaDkxQzVtMzVmZ3hv?=
 =?utf-8?B?d3cwdG5EK1VXSlJ0VWJicDdlYzhEd2pEWHlzcjBRck11UHM3Z1ZjREgvNGw2?=
 =?utf-8?B?YnJ4anZUaUd3eXNPbFBpcjN1QWpScStnSk43cWJUWklOSVM2MUZoRkNCdWVv?=
 =?utf-8?B?aXpzSDZsMjB1VjJLOTBvUmxKNVdjc0g1dzZzWnM0R24rZVErK3NmVDk2RG1G?=
 =?utf-8?B?MytFc2VGQUJXOXZxL0VDYnlsTzdqb0RyVE1Za2hYTkxTeUNHREFYN3N6ei9L?=
 =?utf-8?B?TVdaU3pac0FCL3ZXb3N2Q0YzL3hjdG52ZWZ6b3lYaXdmTXNPd0N6VWRhalBX?=
 =?utf-8?B?T1psb2E2N3JyRlBoT0M2SnZ6YVJNSWVkc0c4QVY1MmRiZ2RPTjFFQU91SVdW?=
 =?utf-8?B?RlAybXBxaWwvTEl2bVFrenlUSWU3T2d4a2ZPbVc5S1dxV2RWYzJkcVRQZitJ?=
 =?utf-8?B?c0d4czRRMG9aRnBzMlpwK2xlK2Zpek5DT1kycE9kSmZKQU5TcWxCWXVtb2RT?=
 =?utf-8?B?VTQzOTV4amxZbTMzdWdMbWdwbktiN2tXQlFuKzlWVi9pRXE1UnhqaHFlQXc5?=
 =?utf-8?B?dm9MTFJ3bG5uZG9ua0NTMDQrQk9aYmRYWjY2UFUxWWMvSmNQa0oyYnp6c2Ux?=
 =?utf-8?B?Z0lHVFhTbnBxSkRocm0xUWk5VVJQUFJBVjl2dG9ISkMrU1lkYzVoMnNERDF5?=
 =?utf-8?B?NXdNQ25OYkNPcEhOcE1FVVVXaXlEcldESkN6MGJmaXcxVjhMY3FCUlBGV0tQ?=
 =?utf-8?B?R2dNazlYVmpZczNuRG1ISXE3NWZVUnZhTmJpN0kvM2pENlJicU41MFkxN3By?=
 =?utf-8?B?dks1eG1vRzNkcVlKYkdxYXFxL2F3SXErMmF0clYzZVowRk5BN2NKaWJpdFlw?=
 =?utf-8?B?bFpqWHpmODdqOTJTNzIydXBnOS8yZWJnSjRnSklDWEtvdUwzK1k2ejlvaTZC?=
 =?utf-8?B?bVp5MnovTWN4R0Vkd2VuYlBVcVlWK3VOZFVuZEduUDZBU0o5SnlSMW1CQVJN?=
 =?utf-8?Q?2MwNc4yw/Ac4r6doJpaNqpAJl491VT38S2dUa+X?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3FYa2thcTF6d0lRRU5od0Q0S3ExV3BHaUVzaXc0V1U2ODEzT05lc0JxT1Y2?=
 =?utf-8?B?dk82UElqZ1ArUzF0dEFTKzc4MUg5S1M5STlTQzZidWN2MXdybTdVaVVnb1Qw?=
 =?utf-8?B?RTVjMm5BcDlwRDlQKzk4ditRRE1YRXpGV1VDaXYrQXNiVXQweDlONWN5eldy?=
 =?utf-8?B?VitDeFZKQ1dJaTlNR0Y3UzYzNlIySDhzdmRLbkExLzVUQU0reDdaQlpUQUk0?=
 =?utf-8?B?QU5SNTRKR2dhZjVQMDJiWE13ejRuczl4U0tFREJDaWxVNzNreEdqL3FiSjcz?=
 =?utf-8?B?eTRZMGpMQjlFajJZUkEwSHM5RkhhZTFnSjRsYUhXRXVpS1Q1VlVhaVY0TmZo?=
 =?utf-8?B?bGs0dEVkWmh6VWo2UmdJclBMbnFiOFlGNytlZVpLNjBhZ1lINlY5bjZUb09t?=
 =?utf-8?B?d2tDUUFsVWpNbnZ5c2ViNVU4UGQzK3c1Zm52U0VEL1gramZkNUtiVk9ML2NC?=
 =?utf-8?B?SXNWdE15ZHU4NmF2U3NUSkEzQXhoNHhqS1lUbU1xbi9QZTBzdHA0WUZ5ZWdW?=
 =?utf-8?B?ZWFldTQ0VldxTG82YkhTS3NGUjVPdldPK2w2S2NxMno3OS9hUUtwdzRrTXRs?=
 =?utf-8?B?bmgyNWRlV3l6T1dkY1RyRnNIMUZ2bk95TUVkdnlwYlFCeTRKSFZha2tKNWpv?=
 =?utf-8?B?ZkYxS0RieHNocnZJQUdFOE83dDZVVmVhLzFva1Q5Ry93WVk3Um55SHEvclV5?=
 =?utf-8?B?emRSU3V0Wk8ydmtqcmRUSkhiQU1RUjhmV1BmSlNybjdjdi85bXJ1ZW1rTEQy?=
 =?utf-8?B?Y2QzVC9RZjVJc1dkSVBRVENaNytxMlQ5czNSNWlGRmhKVXdtTFA0NHNFQzln?=
 =?utf-8?B?akR4Q1ltZXQ0YmIvL1Z0clplb0RqaDI5QW4ydWhTSHltN1gvQ2RheDNtVXFo?=
 =?utf-8?B?d01HV1lHa0txYVlxV242RGVRK0FkS3EyZ2kyRldqck1GWUx1cG1MV01oS2ow?=
 =?utf-8?B?b0FTM2pEYlVTSkVjR3BZQnlqS2QxQW9ONUR3QjdSYWxoeGs1Mi9Hd1dTY3ZN?=
 =?utf-8?B?OWVQNW9zazg4b3BLaVpEZHVZbkhDTWJWNkhCSFQ1TXVhNXd1SURrc3Btd05D?=
 =?utf-8?B?ZjcraWQ5N0ZXWXgzNEdVb1JiMlhPM1FmYlRjeFpUM3lkaEdvSElkTGhIeUlR?=
 =?utf-8?B?Tkhpa2M0RDZDSnBRaW01dnVzNnZxcWZ1dWlkSGtZN1hMeHl4QWRqNDl2SXVP?=
 =?utf-8?B?QjBNZWJ1b3ptSnJVNW1jbVJPUnRVeHh1dDFXV0E4WkRmUmk0QXZxU2V5bnRM?=
 =?utf-8?B?N2VVbnNBVnFKUG8vWVpublJLRDZtZXJVZWJkTVZabHhiR2U2SkFsM0pzMU1D?=
 =?utf-8?B?d2t2a21SS3llNmRxTHQvMnNEMldiR05YZmRYQmdnOFlvT3FQTnV5bDRtVVpP?=
 =?utf-8?B?cnIzYTZPcWJSajBTOExtN2tSZFJGaGdtV2xPbTJPbnpiKzlmSHNpaURIejN6?=
 =?utf-8?B?ZWU1YXIyNk02ZC9QL2t0ZTAyNW5aaUowRFhpc1ZVUGtvb1ZYSXZGQUJrb3BO?=
 =?utf-8?B?Tkg4a0o1RGFZSlU2c2Q5SUp2VXZZWG5KVVpMWTcvUmlUT3UyZlhrbDRuSEhs?=
 =?utf-8?B?SytzYmJ2QTVpelVKdzdUVzU5QVBmdjUzM042eE9PZnZMUS9ObjdHR2R5Ykph?=
 =?utf-8?B?T1J1N2dtUnRITnhKVW8rcElOQ0ZteWpQOTdpcmZKcXBoM2FSalBxM0gvQmZl?=
 =?utf-8?B?cm5FMlMyK0ZsY3FnQXY4bUVRL2lmcVBqT1VwTk9NdThRUmxVeXZxdjBMU0xY?=
 =?utf-8?B?VGJaSlBiUUF2WE9GY1U4ZzdvZzlTdUxSeEpmTnZldWc1YVg5N0NzZ3JHTUFI?=
 =?utf-8?B?QU1XeXMwVWVYQnVNQklIQ0NuZlNuUDVOekFkVEswUThrbGlPaTdlano1Qk9p?=
 =?utf-8?B?cnJhbVhJYUoxZEVUZHBaZ201L1VjRmQvZ2prRSsrQ3p1UGRFQjZzZDExWStK?=
 =?utf-8?B?ODlWdGNmWDByKzhlQmpsM2xGM0NSeGxHeERiNVI5SGlBTDNocEpRZFZTZEZY?=
 =?utf-8?B?ck9jZ2NpL1U3bDU3TFd2ZGUrdFlERkZDRnFEREdIWVM4am9jS0U0TlJBQmND?=
 =?utf-8?B?b2ZVRk1BSHJhOFRQQ2M4UHZsMnFiMTNCczErbUV2a2dwYkJ6S1dRdGgvQi90?=
 =?utf-8?B?QXVpTnB5T25PWWZxWEV2dnBybU12S1o5SS9jQ1FFblptNUNPMnZvZ0FyUm1K?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b1c94f-dccb-4be4-569a-08dcf3a61bca
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 21:03:13.7366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0KacfJC9UKPBcMhaoydIU0zztJWoS9ADm80u5m3eVxBb5md6h2Q1HdNe364v7dqhqBSD0OFWdC/jXz0PlWu11vS/awe/F5rKwBhpbMpN7sU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6833
X-OriginatorOrg: intel.com

Hi James,

On 10/4/24 11:03 AM, James Morse wrote:
> Resctrl occasionally wants to know something about a specific resource,
> in these cases it reaches into the arch code's rdt_resources_all[]
> array.
> 
> Once the filesystem parts of resctrl are moved to /fs/, this means it
> will need visibility of the architecture specific struct
> rdt_hw_resource definition, and the array of all resources.  All
> architectures would also need a r_resctrl member in this struct.
> 
> Instead, abstract this via a helper to allow architectures to do
> different things here. Move the level enum to the resctrl header and
> add a helper to retrieve the struct rdt_resource by 'rid'.
> 
> resctrl_arch_get_resource() should not return NULL for any value in
> the enum, it may instead return a dummy resource that is
> !alloc_enabled && !mon_enabled.
> 
> Co-developed-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> ---

There are duplicate "Tested-by" tags from Shaopeng.
(found by checkpatch.pl)

Reinette


