Return-Path: <linux-kernel+bounces-234229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A4191C413
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F387B22268
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B457C1C9ED1;
	Fri, 28 Jun 2024 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KtI3FXCD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D7BD2E5
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719593136; cv=fail; b=TFhyok1JWY8Hyv9R64Z/c+yPPtyMwH3ilVBa9MEXkEHIZuCuf8eXqF8RbhSUrszTgeFqcirrYHmN5011X6SEignVKUbDFptfK/orrI8DZqhWfDiWFeOvpQEz9Ouq5RgeBvbAxism/MKh+YGGQ+zEoALKh3ShnLtlzQy6rISnyVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719593136; c=relaxed/simple;
	bh=ndyFCmLFFsoTk9fZpO2JZoJGFu8wNuwF12BY7ie2Gcw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r2h7qTz1YIcYFfy7XdqiOs/IOAy9K7QssF9TDUR1lHHh+7bhA0kI8q3ZQE9WyVrMw2wpCO5iaWlj1eOrsVKdPEH1Sf9826jk0RBiDrnhAxuITTOTKGO/OucbKj1egls5V2pHZcvd1WBEwPNgDuv4tzz+Mnf7toJ8HP5fh0z7SZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KtI3FXCD; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719593135; x=1751129135;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ndyFCmLFFsoTk9fZpO2JZoJGFu8wNuwF12BY7ie2Gcw=;
  b=KtI3FXCD3HnqTIzAC2ZDgjPtUBhgLlxWFd2LDYLoGKQKape7SCpxEv7e
   wMbjlR38djZM+cRUa9GnW2HESC0Z6VvpDVESj7+0gSHlH8Iy4zLRlPX3f
   fO8zRJikgwXxS9KyHEJm3b558IZbOgwE+X6OZXwv5LejvWv/+gNduBb8p
   DOrh7xaEeFisgn3xhYB5tzjw1TZODc8IWii1AXo2/zie/in3T6cndH1wH
   y8mfDjcQ9UK2tKi/5yoSSJUR0fcV8JghASnr4vq8wVBb+R7r9XWlC66oi
   86EtHGFHRhpJ0CTvyj0gib0HKId8QhZGceMZywWFVZkJ6M/Dcwq57Zff/
   g==;
X-CSE-ConnectionGUID: cVPUZssPRxucEf/YOEhsWA==
X-CSE-MsgGUID: PDTN9ADYS9OQi8PnT+0a8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16521339"
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="16521339"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 09:45:34 -0700
X-CSE-ConnectionGUID: BRK94mEGStewXl5x+pEeYQ==
X-CSE-MsgGUID: Ue7U0e0lRse8jntDEn2k9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="44873674"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jun 2024 09:45:34 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 09:45:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 09:45:33 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 09:45:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nb8jRdgxZzjW/0zrglAB5p2bivRYNdnqusuQUl5JSx/oIxiN5YFdztpbQUPg3vGeriFO2vO/xA+VYSGtAaR3mxmYBAUJlby0YlmT+XHhFpED/9t4rxnEWnz+VBTWEzFb9jUSbO1eaGqddW0r3rLx/IEoQex+cON18mI//PoRiiaSy3U+rZLMkOK+V4SYuYA/SWe5s6jTcfX78c4Rj6oHsAoy2KMZV3uHBoHNnpeJMindGK72au5/cMPHFd/mgarkXxVZG5Rrgh8E7LxqnW3xW8sy96DU4MMrl2g5/fDZFauHaUCReFd6qOVXc2SQfFfdDMWIWyMX225+vBnZldICVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7pvx+Cor+SecViQ2aLr/+3V7dkt5hA8bAcU3kLiBy0=;
 b=VX8EA4yNUSMhT0l8KjvdCmCt+T8VPZ8sraU9Um1xtyg+juLoF7zmTOmpjZOvWfdbYf228AT1n9yDzEmpNp6eSrkSNMRnZfdn8h0kqRQ1nGablyFeeIRdK1C60cCMAlZDrkHMYx3mLEzydkrF0aTTkd+ohxf4zsC4xOQMIfv0ewvp0b+lNsTy8oabGL58QqdlTY4Uf54W+jhmf3vzijOFMC9A67G8+XfVPADBqCRl8+gkEDqp3sG60+Ldg19tv1C7HbSpqUvHAWHDseqh2IQylEuiU3uo5VKH7pN2BNUKaNj331q+u68L1kkK4S9ndunWY9gGAkmn0JfbQtVEMY+TaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS7PR11MB6173.namprd11.prod.outlook.com (2603:10b6:8:9b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 16:45:29 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 16:45:29 +0000
Message-ID: <d9568ea8-08cc-4e3b-9951-78acbcd54075@intel.com>
Date: Fri, 28 Jun 2024 09:45:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/38] x86/resctrl: Move data_width to be a schema
 property
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
	"Dave Martin" <dave.martin@arm.com>
References: <20240614150033.10454-1-james.morse@arm.com>
 <20240614150033.10454-7-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240614150033.10454-7-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0024.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS7PR11MB6173:EE_
X-MS-Office365-Filtering-Correlation-Id: 78ae98f1-616b-4e94-28b8-08dc9791b84c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bG1GMFhRRklqSmU0QWd5MGRTUlQxWGdxNFhrVWx3S280aTh4bG1rRXRmQldN?=
 =?utf-8?B?NWVwVDQrSU1CbkJBOGNQTS9iTVZIaUpvZWRQTk0xWk5oeHBFeWp4SG1EVVpj?=
 =?utf-8?B?NXpKbGxObEo0Q0FJYVFsei9sOXc5RGVFNDVGSnpibmFJYmdFQjNFMjlxZHRy?=
 =?utf-8?B?UnhjT05KZVh5a2w5NmhZTWEzdlZndWVLTGlpRHNwNVQ5UWNIU0RXMXBvczRD?=
 =?utf-8?B?cTZ4ditRMGg4VTIzV1BESWVPVlZQSkp4cUcvSVFNS2ZPYW51UnpQUGZPc0Ja?=
 =?utf-8?B?b3VwQnBIc2h2T3dZOVhlL1YxUFR5Nnl2NG9VM1M2TjYveGtYOGhlRUpFbHd2?=
 =?utf-8?B?Z2s0VWpUZXI1U2lVcWdIcHQ4a0dsN21sQ09XQVprUmpWRFpKVGEyZE82TmtY?=
 =?utf-8?B?VlArU1VhdlJiOGIrWkhrNGpmL0Q3NTRVRWc1NnVTMmcvWmR0M1lrblpScnBi?=
 =?utf-8?B?V3I1VTF0Y3E5azZ6b3hOeSs0MjdZaWZIYTJTV2VaeTIya250ODJuWlRrSGNF?=
 =?utf-8?B?eU5ISE0yYVZRbWRWaTY2YVVCRGVJc01KYmNjeE9QRHJGN3g5eU9lWUo1blpW?=
 =?utf-8?B?UGJBZFZvczZVUEg0YkhnWTBoV3QwRGRuUE15WW5RRmZIdURVRHB0RUtGS3J1?=
 =?utf-8?B?clZFQkpxL3E2ZUNkWXZQZUM0czFuZk4ydXNyZjlLNG5IR21lbUx3cnkzTU9w?=
 =?utf-8?B?MFlNYUZnN1k3SS9zM3dYM2kzWUYwVnJFR1BrYTMwMXI5M2k0dGR5eGVHU0FB?=
 =?utf-8?B?ZVBWd0FPSVhraWdQT21uZkVOSHVEN0hnck9MMzdrUm1wVHRkQ2E4cUROZm5m?=
 =?utf-8?B?ZVJnODBPNXVDMm1HL1dKUGhzQStsbUtMYWxuUlNTNGt5UFRoelM0cmFzeS81?=
 =?utf-8?B?aUVOR3N3WjExN2c2NHFiSTR1Znd1SEtySEx4bUF1bDcxeWNSd0JQMjVtcDhK?=
 =?utf-8?B?dytSU3hocnlrMjMzMDlBZTF1ZlZiK2s2MC9ZN0YwZHcxdEovWStMYzR5V3NC?=
 =?utf-8?B?cHgxeEI0Wnh4OFFJNDgxYS9QbSsyanBFUHhFUDhtK2U1L2I0WmV2RnZjYTJp?=
 =?utf-8?B?dWhGTUpQNHVuSEVuYmxNcVNZSEZ1dTVpY2hQOEFodFp4aWNtMXhQYjRHeE9w?=
 =?utf-8?B?OFllOEMxSEMwOUZPR05KdHJRVFpWdzNDLzhMN2lVVU5USUw0b2FTR1dNTzRZ?=
 =?utf-8?B?YnJ1Y1FIZnZBSHMvcnFDUnZwMkVLN25ZUG5pSnBDTjlqdmJUSU9jcjN1YjVF?=
 =?utf-8?B?VlpUOUZWZVdJdjlqUlR1cHo1MlFhbG1sQzh4WGxIVjkrUXFuWHBBOTNBYXAy?=
 =?utf-8?B?Z05BNks3dDVEdlllNHFzdXNlTUo2dGkzckVIZHBTb1FQK2IrOHY3MENZMHYz?=
 =?utf-8?B?SUNqbzFnb1RjbjBpWGpqeHRaS3F6eHJtaU8rNkxLQ09KajRDMVpiMzJOM3dK?=
 =?utf-8?B?QmJFa293cFIwMndYQ0tBcXpMV0pWeGxZano3NnQzeGo1ZFpKVXM0ZE81QkFh?=
 =?utf-8?B?cGY2c0kvWFFJNEdMTUJ5aTVDaEJ6Yk8wKzZYdDJzWm5YMlhCN1FReU9wTFMv?=
 =?utf-8?B?MVBqbW9PNUROclpEL2wwQ2sva0p2ZVgzdWlYTW50RTIzdGppOVhNSmRjelRH?=
 =?utf-8?B?WHlsVVkvTjhjS0V3REU4WVl1clYrWjlEQ1p1Rm9tUTB4VUYvS1REaGVITkFm?=
 =?utf-8?B?cFI5enpjTUtkQURPaHJRQ2tITVoyNFM1QUdXZmNxRFE0TWsxODBlTTlQZHFV?=
 =?utf-8?B?MXAva1N1czZoQkR2dHd3ODRLQUlaYzBEKzROcVVwbUlDUXBWeFdab21yeWN6?=
 =?utf-8?B?cjhTUkQvd2NKZVdvL3RSUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czFHak5hTDVsMys4d3VGbTZNRDRFSkdWeU1JZ1dYZFExQWxRdXFYbXhBblJp?=
 =?utf-8?B?RFFOeWVwcEkySURvbFpMUDh4SytwckkwVHB4NGlZWlVjMzc0ZlFZdWNKeC9E?=
 =?utf-8?B?RHZhOTVCTVVYVE1jYmtSNGVYc1pkWFZUcTU0MnZuVDhDR0tuandYdHB5MTJr?=
 =?utf-8?B?M3ljcVZZL3g2WnJVT1pUbnlzVUhmZjhVSERlT09oZFNTc2NuL1dhZ0FlT1dj?=
 =?utf-8?B?Kyt5NEx3UCtUeFhlZ2VCZVRoNXFlUWlwQlNwSHZZcHZ1SitvVDJRWlYwbTlO?=
 =?utf-8?B?YlNBMlVIaSszbG5qaW9kY1hUUDZITFFLLzcrSi94OWxsd3pmZFlab0dMellT?=
 =?utf-8?B?RHhKdzFpcjdTaFBEK2pYSHdVVlRQT05YWHgvRjVsTGRQNWNRWHlGTU1jVXZO?=
 =?utf-8?B?cnYweEo5UHAwRCt0dmdlL3hhRWZwZDZQZVFYOWJGbHNObk8rbmVNNHU4L0VX?=
 =?utf-8?B?bllOSEVQcWp4SXFnOTBzQXRCc3N6MHRpOGJjR0E0dlBKVlZyZkxvd25hc2ZT?=
 =?utf-8?B?WTYxQzY2K1FGWmZjTHV1b1F3OW1RWXlIRDVQY1crRjE2S2NQZUhGR1RjSHRl?=
 =?utf-8?B?Z1JlNFEvcXVIcUg0ZGZ5YkZZV2VCeExabTlLMUg1TVNFVHNEaGx4UW5qK1Ra?=
 =?utf-8?B?ZWV6TDFvOUFJaElIS0E3M3NVY2V5UFV5ekVNd21GNW1GRTFJdWpQd2MyRlY3?=
 =?utf-8?B?ZU9VRFAvZ21GZTNYTkdEdDY3QWFXZGFyek1VcE5YS1dOSVowU0N0RVR1TVdq?=
 =?utf-8?B?RHRzSXc0TnpxM0hVZENaNm1iSnNCbHZzY3hncVZrTDZKejVFOEJ0K0hEMmY1?=
 =?utf-8?B?NTZlK3gxWTUydW9oTWErWFNmQlMvNHQxNUNQY0REZnAxZTgyZzkxc1lzK01O?=
 =?utf-8?B?NDRxalBpNmV4MmZPdFAwU1h1ME5jYW1sbmM0OTZSMXF3RWRCd0RiY24vVTdY?=
 =?utf-8?B?Um1qeS8vN2trbWl4WlY5eEJaVUNpSm85bm9WemI1M0g1ZmswQmZwcVdqVGFp?=
 =?utf-8?B?cDZMMUNYejcwYVZWV3EvUzdKOFJUaHVWMDVTWXgvMkhxYmtaNDZ0d3NvajhB?=
 =?utf-8?B?KzdIN3gvY2prS3FSejVEODFjNW9iRExnUnlscWpFcHBvNzhIS29hdnhuamQ4?=
 =?utf-8?B?ajNvSC90dDcwVWJ6NzNhYjVYaklJSi9WSlNOR1luUmJKN2dvZUx1anYrdUtZ?=
 =?utf-8?B?d2h3RWpCYjJ4eXM3cCtMVFBBclQ3VXNaVS9DcUtJK3Q4UmIvWUF1aVVXdDFQ?=
 =?utf-8?B?d1ZBNTA1Y1VaTzNUYzNCSmVMdmEzWEgwa25jSXNycW8zalZWVFJnOHplRFRo?=
 =?utf-8?B?ZlpHeFluY3BqNFZxczlzd3dyUlVMbEM1c2JHUXgzMXhTZ05kYmJua3JKdDZI?=
 =?utf-8?B?SE13SCtFN3Y5RzhTeUpOenJZdzdxZGJHYnYzdjNkbFA0bkpuc3VXZlJOSjdz?=
 =?utf-8?B?a3k1bitaZi9hVHFpUG9YWTJ5MzA0d0lQaEJIbC90Rk40M0dzOUpvblVSS1NC?=
 =?utf-8?B?QVRZRUNJNHNubTl0SHFoZ0hwN2EvckVTK2Vub2lyOHVqS2Rjc1liMG51TVp3?=
 =?utf-8?B?b1JtNTl5Y2VUTUdHYWYyTk44bDZMMWpxQTJWRzMrSHIxdDlTNXlBaWttWE5Q?=
 =?utf-8?B?L0JheDN4NVo1S3FGaHpodXoyN2VUbW1kYUZFMGE0Wk04eHFhcHIzRk9RZGFZ?=
 =?utf-8?B?L0JzMk0zd1d3ZXRzejcrT2hJdjhZbjVndUV6aVVRVVpKeURNYWE3cWtoRVMz?=
 =?utf-8?B?Ym5LMWpCY3F6Y3Zwbjh3eWNGVFozRWpKVTZWNmhzU3JJclp0ZGVESEZycmds?=
 =?utf-8?B?ek1rVDNwZlFiSU54S0VsSXBtcll3VWxaUzNuVEZjQjRtblVqaEc0NzU5NTFC?=
 =?utf-8?B?VTBzTXJwQW1IaGQ5V21EOE00TnFOeHNNaVJUdzE4SDI0VUhqbm5FSWdmM3hO?=
 =?utf-8?B?S28zUWsvTlBkakVEZmhvTlBEeTBXSzAvSlEvc2VZQ0VSZ3R2Q1I5bTlqQ1ow?=
 =?utf-8?B?cVdIZlBhSGdvbVVwaGU4T2hZdmllUUtrNzFHakJVeEtKb3F4aUg2R2IxMU5l?=
 =?utf-8?B?YTVlZ1JIY1RVdlh1VDYwbjc1TVcvbVRHSmtIWnl1bU9vR2NYWnJ5OWhBQk1W?=
 =?utf-8?B?cnpXMGZDeEhHNlZOSlo2WWcvU3NtNnpqSU55bVlFOTVXK0krbFAzQUUxcDZn?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ae98f1-616b-4e94-28b8-08dc9791b84c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 16:45:29.8626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSASBrgBzSLJWKR985TAMza2Ep7OmN2vQKh3B7lipIM6F65022ThKLNluJCWNEqc37AasADMgX+l3mYlGUuoPFdZntfkZwx/7VusVdy7X1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6173
X-OriginatorOrg: intel.com

Hi James,

On 6/14/24 8:00 AM, James Morse wrote:
> The resctrl architecture code gets to specify the width of the schema
> entries that are used by resctrl. These are determined by the schema
> format, e.g. percentage or bitmap.
> 
> Move this property into struct resctrl_schema and get the filesystem
> parts of resctrl to set it based on the schema format.
> 
> This allows rdt_init_padding() to be removed, its work can be done
> by schemata_list_add(), allowing max_name_width and max_data_width
> to be moved out of core.c which has no counterpart after the
> move to fs.

Please do write commit messages in imperative mood.

> 
> The logic for calculating max_name_width was moved in earlier patches,
> but the definition was not moved.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v2:
>   * This patch is new.
> ---
>   arch/x86/kernel/cpu/resctrl/core.c     | 26 --------------------------
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 11 +++++++++++
>   include/linux/resctrl.h                |  4 ++--
>   3 files changed, 13 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 4a5216a13b46..4de7d20aa5aa 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -44,12 +44,6 @@ static DEFINE_MUTEX(domain_list_lock);
>    */
>   DEFINE_PER_CPU(struct resctrl_pqr_state, pqr_state);
>   
> -/*
> - * Used to store the max resource name width and max resource data width
> - * to display the schemata in a tabular format
> - */
> -int max_name_width, max_data_width;
> -
>   /*
>    * Global boolean for rdt_alloc which is true if any
>    * resource allocation is enabled.
> @@ -222,7 +216,6 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
>   			return false;
>   		r->membw.arch_needs_linear = false;
>   	}
> -	r->data_width = 3;
>   
>   	if (boot_cpu_has(X86_FEATURE_PER_THREAD_MBA))
>   		r->membw.throttle_mode = THREAD_THROTTLE_PER_THREAD;
> @@ -262,8 +255,6 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
>   	r->membw.throttle_mode = THREAD_THROTTLE_UNDEFINED;
>   	r->membw.min_bw = 0;
>   	r->membw.bw_gran = 1;
> -	/* Max value is 2048, Data width should be 4 in decimal */
> -	r->data_width = 4;
>   
>   	r->alloc_capable = true;
>   
> @@ -283,7 +274,6 @@ static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
>   	r->cache.cbm_len = eax.split.cbm_len + 1;
>   	r->default_ctrl = BIT_MASK(eax.split.cbm_len + 1) - 1;
>   	r->cache.shareable_bits = ebx & r->default_ctrl;
> -	r->data_width = (r->cache.cbm_len + 3) / 4;
>   	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
>   		r->cache.arch_has_sparse_bitmasks = ecx.split.noncont;
>   	r->alloc_capable = true;
> @@ -631,20 +621,6 @@ static int resctrl_arch_offline_cpu(unsigned int cpu)
>   	return 0;
>   }
>   
> -/*
> - * Choose a width for the resource name and resource data based on the
> - * resource that has widest name and cbm.
> - */
> -static __init void rdt_init_padding(void)
> -{
> -	struct rdt_resource *r;
> -
> -	for_each_alloc_capable_rdt_resource(r) {
> -		if (r->data_width > max_data_width)
> -			max_data_width = r->data_width;
> -	}
> -}
> -
>   enum {
>   	RDT_FLAG_CMT,
>   	RDT_FLAG_MBM_TOTAL,
> @@ -942,8 +918,6 @@ static int __init resctrl_late_init(void)
>   	if (!get_rdt_resources())
>   		return -ENODEV;
>   
> -	rdt_init_padding();
> -
>   	state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
>   				  "x86/resctrl/cat:online:",
>   				  resctrl_arch_online_cpu,
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index af9968328771..4f8e20cc06eb 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -58,6 +58,12 @@ static struct kernfs_node *kn_mongrp;
>   /* Kernel fs node for "mon_data" directory under root */
>   static struct kernfs_node *kn_mondata;
>   
> +/*
> + * Used to store the max resource name width and max resource data width
> + * to display the schemata in a tabular format
> + */

I understand that you just copied existing text here, but since you touch this line
could you please have this sentence end with a period?

> +int max_name_width, max_data_width;
> +
>   static struct seq_buf last_cmd_status;
>   static char last_cmd_status_buf[512];
>   
> @@ -2600,15 +2606,20 @@ static int schemata_list_add(struct rdt_resource *r, enum resctrl_conf_type type
>   	switch (r->schema_fmt) {
>   	case RESCTRL_SCHEMA_BITMAP:
>   		s->fmt_str = "%d=%0*x";
> +		s->data_width = (r->cache.cbm_len + 3) / 4;
>   		break;
>   	case RESCTRL_SCHEMA_PERCENTAGE:
>   		s->fmt_str = "%d=%0*u";
> +		s->data_width = 3;
>   		break;
>   	case RESCTRL_SCHEMA_MBPS:
>   		s->fmt_str = "%d=%0*u";
> +		s->data_width = 4;
>   		break;
>   	}
>   
> +	max_data_width = max(max_data_width, s->data_width);
> +
>   	INIT_LIST_HEAD(&s->list);
>   	list_add(&s->list, &resctrl_schema_all);
>   
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index abecbd92ac93..ddcd938972d2 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -182,7 +182,6 @@ enum resctrl_schema_fmt {
>    * @membw:		If the component has bandwidth controls, their properties.
>    * @domains:		RCU list of all domains for this resource
>    * @name:		Name to use in "schemata" file.
> - * @data_width:		Character width of data when displaying
>    * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
>    * @schema_fmt:	Which format string and parser is used for this schema.
>    * @evt_list:		List of monitoring events
> @@ -198,7 +197,6 @@ struct rdt_resource {
>   	struct resctrl_membw	membw;
>   	struct list_head	domains;
>   	char			*name;
> -	int			data_width;
>   	u32			default_ctrl;
>   	enum resctrl_schema_fmt	schema_fmt;
>   	struct list_head	evt_list;
> @@ -218,6 +216,7 @@ struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l);
>    * @list:	Member of resctrl_schema_all.
>    * @name:	The name to use in the "schemata" file.
>    * @fmt_str:	Format string to show domain value
> + * @data_width:	Character width of data when displaying
>    * @conf_type:	Whether this schema is specific to code/data.
>    * @res:	The resource structure exported by the architecture to describe
>    *		the hardware that is configured by this schema.
> @@ -229,6 +228,7 @@ struct resctrl_schema {
>   	struct list_head		list;
>   	char				name[8];
>   	const char			*fmt_str;
> +	int				data_width;
>   	enum resctrl_conf_type		conf_type;
>   	struct rdt_resource		*res;
>   	u32				num_closid;

Reinette

