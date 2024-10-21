Return-Path: <linux-kernel+bounces-374859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E519A712D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C183281678
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1711EF93A;
	Mon, 21 Oct 2024 17:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KW26HTTR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B55126BF7
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 17:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729532373; cv=fail; b=aK2rGe6jW7QoANBr4+w5vavDNmsWzgDM8sLDlsTaqcghTjZSTxnapTNXKZvrXcGG9IlaK4+wmD+WVWnlrHj4b+rOxsgw0vd1nQdz5v0OlLqfUVSF7EEZbHaKD6R+KhTEav/+0NBq5Oasj2p/Mu5IsgRrEw+Xoili14+uxMWvyT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729532373; c=relaxed/simple;
	bh=XLG5p/7RTKZkwkZxMpYsMiKzJWFY/BNJRjRDnhr7klc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Evmi8HRCMVYRtqFRu1qcsrnYkmDRWkk/zdlyt3u8pDccSG5Ox8HIrTDHxCuB3f547TOdoaMOBVhViWMM82z2NOyDPEQbb2y5w4QHKuPsntyKlrWySNqpsq6JZ+TPjYOLfabWHlRD7NoeR4AtO9vEGXcxKJ7qHSdnsS9/rMG40VE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KW26HTTR; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729532371; x=1761068371;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XLG5p/7RTKZkwkZxMpYsMiKzJWFY/BNJRjRDnhr7klc=;
  b=KW26HTTRyF0e+CXBrqqZFX2sBrcxdH6iKQ08S/2PBDNyxoXEajIHO/oa
   oIu5KJ8Ugn/P/LnOe6IiWGDYUZRpxI/Ihu4Xsm8uKQw01GXUwTZbjhhXc
   dzbZMEx4imAWin8KvJ8iqq2pS5FyexinkM+4EhAoNRw25tyberfyIr8/7
   Q9bvObfOYDpO5OjBC9QMXwIyUJh6vo//laLUzpcXcb9Krv6FpN+rpK32c
   irVGE8dfsx7wYBFzE3lqxH96JWCDNLJ3GG0xj6+1K5iYReHyF1cLWgKkx
   OFNVKgc4ufvmcg6bIOkXkm9RODTy0i1FCbPoxutVjQE9eUv0SVXLsWKRw
   A==;
X-CSE-ConnectionGUID: bFLhTFA4TGKxEOOchBJ7EQ==
X-CSE-MsgGUID: HiH3z5T6QM+Rvt/UkhxcmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="32959940"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="32959940"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 10:39:30 -0700
X-CSE-ConnectionGUID: DFYb2r4oQMueOAJgjIVozA==
X-CSE-MsgGUID: FXBHnxMIQl6yolzzGCzB2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="79939182"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 10:39:30 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 10:39:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 10:39:29 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 10:39:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fxkx3UNzDPPMj9PQu96lnzbwH2dk8Byp6V8w3UYHwUbDqt/UHhpQB3RFbgs3tmn5KgYaGdyeHx9+TluPvzFfa7R+t0Eo8kD47KsUFitbzoFYL2wecadT4F8hgP9hB39izddvgW304XEe3Uod1kq2nXaYz4vmjpHD7PL/Md0PvXRTB+52wCYjA8xncm0V9CBDNsMgKaS+sEgJR+eerXGrlYAmF6dQzB3BKIvmV+Ua+RhwvvTjLgouenA3H2v/WxPeScRNkNVXntJnwF2WJkTMT6qC1+1m2AMLDpftkKzZZSyc2aqWe/haHgZTabZdiNEeoeMYATICKM234iJkW+KpXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7iP0zQNoIwG47Dz9jJNI+ZHn86Dl2VQOZc9qtqJCSmU=;
 b=w6eEVuROCgQDhPOpqUPPBUy55JsCE4MD3X5dT9DMlL1d0FKa7wd9PylgmyzYF7PaDkK2N2B4oSBoZJOzPEG2U0tDX8udep60/CFiW2/8hGzcghAdDzn0fXxW/+P7MyaNUcjFuXdymB2pBMV0UNbljCus9aw5/NymgeKoLIemXdYDHQVoFxkhR57IWTEGJMEdlqzL4Fud4dM3UW7lmP4uIvtTWhF3g7FlTnCdCXTJqh+5/UHUcgKQnWf1/Z1v33UORe34nXb8rUeLXXtPzTr76a6CmJ49/URGPINDx1RckETQ7ssWYt7su1aN5Lt6Oqsn1o+X852z241ZuK7cD3nNOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS7PR11MB6150.namprd11.prod.outlook.com (2603:10b6:8:9d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 17:39:25 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 17:39:25 +0000
Message-ID: <54b4d6a1-fcfd-404b-bc36-930f7785a7a5@intel.com>
Date: Mon, 21 Oct 2024 10:39:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/40] x86/resctrl: Use schema type to determine the
 schema format string
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
 <20241004180347.19985-6-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20241004180347.19985-6-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0025.namprd16.prod.outlook.com (2603:10b6:907::38)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS7PR11MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: 22ddef5b-0b45-47c5-9f46-08dcf1f74e67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHVoTHVkSk1XSnRXYXVMWENRK3liQWJkU0JDOG9kZk84Wk1ncWZkR3F1VVBH?=
 =?utf-8?B?MlNWUnNXYkJCNzMrelRmOHRxN1I5bjJpZ0NMNS8xRERCQ25JSWYzNjExdTNC?=
 =?utf-8?B?a1pPRHdSK092S1lpaXpNTUUrR2Q0UTRONUZvM2Z5Vzh4NWhVSnFKNkhkUEpP?=
 =?utf-8?B?QkdzUGhWWXI0VWQybFcycERlS3did2VNbnBEWml2NVJ6eGRPM3cwZHpvbkhP?=
 =?utf-8?B?T3RGNG5mY080QmoyeG5vcDAwVi9Ja283Nk9TYW1NZjNPcjBXN3ZidWt0STNl?=
 =?utf-8?B?RTJvUXNFQkJqZFp1dkxmRDc0Nmhoekt2bmpQL2RkOFF4RXVXdjFnMGhIdGtU?=
 =?utf-8?B?ZkdBRzZ3WHRKUzMvSjJrZm5pc2xwSCt1TXp6RFN0SU56S3JkbklaTHZqWmhy?=
 =?utf-8?B?N3lWVXFwKzBqM0JWTEZ3aDcyWCtkMmZFanFqVHg0clR2WkFKVCtOQWJHRFZH?=
 =?utf-8?B?ZjNhMVkxclVsRjY5VFhWWmp5dlRDWEs0eDZiRm9QZlRwbm5jM0lleEJNc0VD?=
 =?utf-8?B?UUI2THNjcXRlWUpuaUFreDFOS2FtRFkrdXR5cmsrQTRETElmZDBvT3dIOWtW?=
 =?utf-8?B?YmErMjlDVXZiTHdGQkpxSmgwMld3dDhyamlsTHdXaHpxbjduR1BtYkxRaU5G?=
 =?utf-8?B?S2JTbVEwbS8vZk91SWhYOHpGMmV2TGdYSjJIcENDQ1ZML0pSeWF5NWpXNkRo?=
 =?utf-8?B?b1Nzc1dNVXp4L3RvOGg3K0hBdVBtcUI1THRkQlVCTFV4aGdIR2lDWDhzM053?=
 =?utf-8?B?UEVaSE9UZHNsR1ozOXRmaDlqWmtVNjBnWGkvQWFNQ2wwTG9kdDE2QWMybDdP?=
 =?utf-8?B?aGdJa2NrN3ZpcEg4SUpEbzVydWZFaEFWNUxoYW0vVjJqblMzWWM0TENpelFU?=
 =?utf-8?B?dXJuUWt2b2NUMmh2WDFzWDNaYUtQV04zcmEvVlZ5SlBNV29VREdwYzBKSCt1?=
 =?utf-8?B?cElUS0R2bXdDd0hiVERBL3oyQ0tlcUpKUDh1SmxVOEYxbDc3WmlTOEZkN3RG?=
 =?utf-8?B?U0UrdEI1LzBXVGxseEsxa3ZNZGJNOFdOZFFIbWJmV0F2Vk5VenA3c2pKZksx?=
 =?utf-8?B?andCakowNFBuY1ppa3JYUytoWFZzaFp6SDgyQ0NYNm96SzZocGdxOTYvK0dm?=
 =?utf-8?B?cDd6ai9FRVdUdWdKVGo2KzFOaGVMSzFCZ1F5WkNwT09mdFQ3K3FuSnpVMjJz?=
 =?utf-8?B?TW9rU0Nod0U4R2ppN3ZzSmFUSTNmSm5mM0dVbVpGd01ESC9PVHZaaHR4Nmcv?=
 =?utf-8?B?ZHMySllJZFlIbkNJZmpNQ2ZyRzJIelhWZlpvTi80YVYycUJlbHFiWDYzMldJ?=
 =?utf-8?B?VUdFMWhSSkJIRTNQNnFoZHJXNEhLVTQ2M3pXMkljZ0U5c0Vmc0M5WjVHNVpM?=
 =?utf-8?B?UzN3RmZ4SEROa3FKdGUyQ0xqbE1pUThjL1lmUjV4Kzh5U3pPYmhkZG1BVCsx?=
 =?utf-8?B?M3U3djRuMmZJZ0EwRHlLUm80NFNOM0N2SXBpYi9yY3VaVWZINjFtb2tydXZS?=
 =?utf-8?B?OEl3RzBCYnN0RzF5bFNVNkU4QXpFOVExbDhJV1p3K0JLTTkrUkpmcEEwOTVU?=
 =?utf-8?B?QUljVHlDUFkzSFZOa0RZblpwMWRtWVg5dXp6ZGJMbFBLTU1pSHdaKzk2NUl1?=
 =?utf-8?B?RWUrOEVHY080Y3NqcE1XbmVTZTlQa0hXMWMyYlFORG1OQ08vSVZ6ZVVtZVdn?=
 =?utf-8?B?N3NJV2hBWDVZL09sdEp5ZEUxWFhBajhKVUdlc1hudGExUlp5RGhETXRvVnBH?=
 =?utf-8?Q?cQ9764TiuIUeJMIjGtqydvSBp07guctUo7ffy7T?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2E4ZXVYeG1RWFZRQ2d5ZGZGb2ppVDR2NFV2YzIrWnAwM0dEWTR0ZEVhZi9P?=
 =?utf-8?B?U3dVNWcwWVA4NW5uOVRkR2RvV0V1a0hmK1Q1VVhBTU1ielhrNjhCMS9KbDZR?=
 =?utf-8?B?bXYzWHB6cDRFRjNhTkpGeWZUcHJSdDR4clRjcFdhS2tKcExrcWVnWXhYaWtQ?=
 =?utf-8?B?cEhWTW1qUDh3QkRlYllkYUhyeDd1UWpCNmVSL2xGSlc2eVVPQmF0dWtjU1Yr?=
 =?utf-8?B?Zk1WZXgrQmtCZEFEeHBIYnJQWUpFdE5BWmJvVkYyNkVnY0M3a3ZabnB4bWZx?=
 =?utf-8?B?ajFrdHdNakl3YmdxWks5M1R0eFR3WUN6a2ZUVFhremlGa1pJWWsrNkFkVlV3?=
 =?utf-8?B?OERiRHorcDhaeU4yd1FZZ1BoT1RVQjBVVWhYbm51bDRRYzl4cUMrdFptenlR?=
 =?utf-8?B?VVp2MEppbVVVV25RYkg4VVpEWkNFYkFmbFJERDRTZmRXU2Z3dThFOE5wUzl4?=
 =?utf-8?B?M2xKUHVsNlFxT3RtL05NbnZCeTE3TW5LUG1wcFd0NGdTSlN2WEh4UHJDV3pj?=
 =?utf-8?B?TG9UazIwU0NXV0FrZktFOU81V0dyL1RkekhIV0hGTnZsZ0xzR2FNR1hTVkVH?=
 =?utf-8?B?TjFEZDFmOGYzWm5FVnhGNjVVWGh1N01nN1hqRkgzQUJ1UGdiUWNURXVsQXZs?=
 =?utf-8?B?YXlSQVdteTZKWER1TlZ4SjRtOFRQUVdEZmhLcis3NWFaMzdkSlpEWVRBZWpr?=
 =?utf-8?B?QWJ4STRORjhNeTEvajN4WnRDa3dENnBSbGkwZE9SQmpDcUxNTERySU03TXc3?=
 =?utf-8?B?NnVJbkQ5YWFRQ1JjUWtWMDlLUGw5LytCU09rT3NnYWNadEZ2UHVXTzNDOW1H?=
 =?utf-8?B?eStsKzY5alg3NzdRbUR2ZU8wMXhrdDlIQnljYVA5Z3JVOHhvYjJkWlNISFdR?=
 =?utf-8?B?ZTlHQUFqWURUV1YyeVZHZ0pJZHJUZCszaEdhVXdCb2ZjTVY3L0RQRVBnWThG?=
 =?utf-8?B?NnlwR1Mwc1p6Uyt3UXFlMW8vWUM4ckQvaFVRZWhvT3lFVEpiazBHRnJjL0ww?=
 =?utf-8?B?Y3dwRjI3YVVBUjNwd1U0YXNiRWRCTXZ6aGpzWFVuV1ZiNVFMVDNSWWVXNFVx?=
 =?utf-8?B?TmZCd1owcmZYbm03ZUtKUEpwVjV4b0kydkUwL2gwYzZURWZiWmVtNXEyc3Bu?=
 =?utf-8?B?T1FaUlFCUlZ2TllTSlA1Z3VLUTVMM0lvS3AyMEpXOCtUcDNHMXB4aEhOTzUx?=
 =?utf-8?B?amlJWnNlYUJtcHlLZmdDWWxyM01DVC9jNTlJUmtXdEpWQ0VvR1daOGUrVXNR?=
 =?utf-8?B?anJJZkJmZ01HU25ZVC9ORkQzZ1dIU0tFaTk0OXh6YjVsYmN0MzFsT2FyazlX?=
 =?utf-8?B?N0lOdmNEUXJyaXBIZHl5dnV1b0dJczB3TE5CdkIzYVRoOVhGajYyaUs3b2JB?=
 =?utf-8?B?NG94djNZS05Ob3lXOURSYnlJeHhOd1orOG5qVmE0cEh0ZVRJZU9PR2NJMjh5?=
 =?utf-8?B?T1B5b2c3ekFkYnBsSGlkZms4TDd1dnBSckJIZ0h5b3I4UjV5Wm03MmFRSThm?=
 =?utf-8?B?NmRUWW4zcDhTbFhGTDlPek5WOHZOaklNaW1WZjAvbFFKclltMHRqOGxaUko5?=
 =?utf-8?B?OVI4U3czeTlHTUFPNzZHT1NnbTZXMGZJSlpTWHQzVDVscUlFcXRubGR4UVdW?=
 =?utf-8?B?SDE2T2tBNml6UVdUVUlORWtjRFRkeVFPOHRlblAxcFFmbWtGbjNuc3kwZDNB?=
 =?utf-8?B?SkhMa2N3ZHRMS3BCYlhERmxsc2NVQ0VldUdkNDNXRmVvN1R0YVM5aTVqblQw?=
 =?utf-8?B?QkNjZlNvazRVcWFIWmtmdEN6T3hNaGNKTjBqanlGbmdMSEpPaDFGRzA0RGN4?=
 =?utf-8?B?dk16d0ZaSG9UNWVxdDBBQ0NBTnUvQ2RiTkU1NnE5dU5obmZDR0Nja1VlKzVH?=
 =?utf-8?B?YTdwOWhJZkMwdWNNaUxERXNkWjBXZi9rS1lBL25XVHZXOHVPbDZnWlNTQXkw?=
 =?utf-8?B?bFNBeGNYQnRnQW1Rd1hwSHpmditmZlZ3Vm1tYm9TOW1zV1JzQ3QyTFNqOWxT?=
 =?utf-8?B?VlR6dWVyR09RZWpoNkRTTENvVGM0YjFyejkvZVkyclR4cGN2Y0Z3S3AyN2Vk?=
 =?utf-8?B?bzRHeFJNV1VRdEV5VFVzMkNnTmc1eVcrT2ZLUmo1a0krQXNtamlacmdKZXlO?=
 =?utf-8?B?dnhwUWFzMXNSQmN3bXFaOUpQZjA5azVFZkE1REk2VlBIR04rVmVVRzU3UjB5?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ddef5b-0b45-47c5-9f46-08dcf1f74e67
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 17:39:25.7329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m90tQ6fxArit4cR3ZqgLmwgxjLvzdsH5IG/cpI3KAkVc21pvDaWzT2ElyFyO8VvbPa2gwEmQgZLzL/LsNcWAatQr3eD9E8+q/7B5Xgkhrak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6150
X-OriginatorOrg: intel.com

Hi James,

On 10/4/24 11:03 AM, James Morse wrote:

> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 11153271cbdc..896350e9fb32 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2600,6 +2600,15 @@ static int schemata_list_add(struct rdt_resource *r, enum resctrl_conf_type type
>  	if (cl > max_name_width)
>  		max_name_width = cl;
>  
> +	switch (r->schema_fmt) {
> +	case RESCTRL_SCHEMA_BITMAP:
> +		s->fmt_str = "%d=%0*x";
> +		break;
> +	case RESCTRL_SCHEMA_RANGE:
> +		s->fmt_str = "%d=%0*u";
> +		break;
> +	}
> +

The parsing of user input happens after the creation of the schema list. If the goal
is to protect against incorrect arch settings then I think schemata_list_add() initialization of
s->fmt_str needs similar WARN_ON_ONCE() treatment as planned [1] for parse_ctrlval within
parse_line().

Reinette

[1] https://lore.kernel.org/all/d48e65cc-3c7b-4a93-80a2-fa0d676e88c4@arm.com/


