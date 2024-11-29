Return-Path: <linux-kernel+bounces-425159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6E69DBE47
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 01:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FF1B164A77
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 00:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7B5C8F0;
	Fri, 29 Nov 2024 00:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aR9Pen4p"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3B4647
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 00:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732841336; cv=fail; b=VP8S9360TzHknZXi/rDAtHzU2e5m5QGkjOcH6fUu1zKLZIPr/v7ggyoy5pP0jXzxmQrsmfFeZ1WjOR3PwHp2PBND2IVbqqiTSukWIigxZSahL3mZr9ribPDW5XPCgzj9/C47Zq5fU1qybS66QdMDapvq5eLO2Gv1IObjuQNPGQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732841336; c=relaxed/simple;
	bh=NSU3ihmTwVSnX3tn6TR2/Ee7TlXH1avxVs2qI7FhMaQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s0FERd1YG8/TOb6sLK812PQ7NafIz+zNZ4x6NdjyvbuyOWvHUqbRBM+6nRwpdIU4Fvo2Fagh1lvr6j8h8SqCUHTARSJtyxhsthPSnGs7yrYEaEgYZAVJRWDrI8JJTt0Q/HZhHLDnldTlP/zgN1GDiIUk1RDxqvm8bZ38dA+wJ7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aR9Pen4p; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732841333; x=1764377333;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=NSU3ihmTwVSnX3tn6TR2/Ee7TlXH1avxVs2qI7FhMaQ=;
  b=aR9Pen4pgQkyIE4KQ5sRGcqGbxA4DMojNcP6VhsSDv+d7aCAo3si3Y4l
   UCjXakR3kz24ZBCUtNiomr3JKDK/c3G9//w2+haf7AU07E+YvpA57za9y
   xn9RfJPjcIN0OHYdeuBrRuDl6YODbG0y7TYol+efwxQg/nfVSoUHg+hLJ
   YN77Jr+BFtHXMieDYGZAiQTpC1Hl/XTBaiUC4WjNLLfyjkavqRfTBWOQs
   JQBcXVbzTbjlRG/8qMVFKZ7xlu9j1JlxsXUIUjcebq4SLCEyoyUQ74QPJ
   4TwxZSdqgPy7qDg3HK8pJXI2CkAlH7B9xWvwKXlZQ8sxGQA3JKc2IQ71z
   A==;
X-CSE-ConnectionGUID: AcCT4S7iR7+hAnj2dX2qGA==
X-CSE-MsgGUID: qt0jp04ySI+r4Z3FYgMnGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="33206158"
X-IronPort-AV: E=Sophos;i="6.12,194,1728975600"; 
   d="scan'208";a="33206158"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 16:48:53 -0800
X-CSE-ConnectionGUID: 61bTPHtsTs+hukuLfy18Pg==
X-CSE-MsgGUID: H98t59LZTkyZe8S1GLZiEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,194,1728975600"; 
   d="scan'208";a="96780228"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2024 16:48:53 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 28 Nov 2024 16:48:52 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 28 Nov 2024 16:48:52 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 28 Nov 2024 16:48:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DV5aGIzxlqp3aCiJkWsC6cMr+5a0daGtjWOGpe2LlL36O+Go/36K34xoZw6sEmztRiO+6NBS9DRvw3qzSCU5cfh0HatUyES0XbaMjpKnO1ZY5Ahcq2pCUlN/JH03HN96LigJRNkYQTjQSxabFMbS5Y7BisoShTduBCrngHoUC3a2bcW2cFmvdi+cBS5c2/+uZ7b+6ydtVgSXgmx/w4kVK8X66pQmTT1WHmSYXOItd+UqKkDkrPntcwhtYVQ6cVPEfGimMo1Bqum61GsYMIkBqscOc2rt65XTMCp/zWZr0lMOiELLlsciY1FskhXIVWNPwLKsYwE8zyEFXc3TKNxXVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HHI6weu2xj50WVXkIsbP4zIvJFKTyQGyYVQuO5WwyU=;
 b=Hhv3Z6bcu0Uv0JNcEv+w5SJvdwVLyLoYsW9ezf9W15duXNs3mbZ392g7Z6FILBuHYtH3CsD1J7sM0qkFVR37rSHaUrt7D09+EmyetCvK+Y9h8hDkPV8i4xctvDff1s8NHn19lZo3VpkdheinLFOM88G3sujknpB5v8PsP4YRdiIXN0mVPzD2+ARvugHUT6iuDCK4sKdJqkjJep1O18N6woi+dqN1RT1XWZjRx0W8V5m1we7+71AICP4fRNnrCwUCqvf64H1iKzRPWYQABtMwVLuexML7V8pCjJGzPdk24v4x/qzIJPClqfNUnwCKGGZGDw+dQGyR4O4uE0Y4w7Q9Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by SA2PR11MB5097.namprd11.prod.outlook.com (2603:10b6:806:11a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Fri, 29 Nov
 2024 00:48:48 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%7]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 00:48:48 +0000
Date: Fri, 29 Nov 2024 08:48:39 +0800
From: Philip Li <philip.li@intel.com>
To: Alice Ryhl <aliceryhl@google.com>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, "Steven Rostedt (Google)"
	<rostedt@goodmis.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
	<gary@garyguo.net>
Subject: Re: rust/helpers/jump_label.c:10:5: sparse: sparse: symbol
 'rust_helper_static_key_count' was not declared. Should it be static?
Message-ID: <Z0kPZwipai5thnw3@rli9-mobl>
References: <202411271011.gFsgMWRv-lkp@intel.com>
 <CAH5fLgiH+hu-VA4GTCWRaEBVXoENX36P16EQzDadJptNi=vk8Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgiH+hu-VA4GTCWRaEBVXoENX36P16EQzDadJptNi=vk8Q@mail.gmail.com>
X-ClientProxiedBy: SG2PR04CA0153.apcprd04.prod.outlook.com (2603:1096:4::15)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|SA2PR11MB5097:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a245b64-c687-4261-a072-08dd100f9593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eC9seVpIb0tweERGNWlLOHRWRC92N3Y2YTdlUXk1dVZhcSs0NmU1L2JsdGEz?=
 =?utf-8?B?NkZXWUJudXJJQW16RDY2bWFSYnRtM01pbjJuMFEvNTFub1h4UTU5Q1MrbnFJ?=
 =?utf-8?B?N3k3dzFpZ1NqZ3lLVDUvVytpeXR0cm5pSjRpRDk0Rm84NzF4MFNycGV2eUNz?=
 =?utf-8?B?OWN1UUJvYVliTjJFc3NqUDlrYS9rRnIxYlA0Uk1OUTdTTXMzMjhXMGNWY2xH?=
 =?utf-8?B?TEZpakVMZHhLRndxeTJXYmtCaWkxR3hyNk5oUmhKY3Zyb2JZVHFGWU5FUyti?=
 =?utf-8?B?aE9kbUpmYU5jUnVpejdwa0F1c0VxNUQ2M05HZkhXMXkrYU9EVjljb1FNVkUv?=
 =?utf-8?B?dnpxLzlrcG5zVFFtbXFMVDY0bGdMVzUzUWFLQ2V3MnE0SEFRd25nNEZUU3V5?=
 =?utf-8?B?dW4vZWVRY3NyWlB0dkhoRHFMY3NnME1qaU01RS94MUVJcEpydk4wQ2ZlRUxk?=
 =?utf-8?B?RVRMTkRRcVZ2b3F4ZUdSKy92YVQrNnNsdzd5OEdTeWpmRkxlZWp6eUlGVmYv?=
 =?utf-8?B?T3JkT1p2UWU0RlhVb1ZvYkg2VEpQK29XeDFzU2hBMG5pV2Vhc21qb1J0Z01o?=
 =?utf-8?B?Nm4xMTBlQzU3TmwvWHk5QnNOUEtsK24vVUw5MkpFR3hSSEVrMUdVaFNTNTlO?=
 =?utf-8?B?dytZRzRmM1FTcnB3MmNla1ZOQUY1V1JkbkZHQ2dZWlc2eG1UK0dTandvYzdQ?=
 =?utf-8?B?Y0dmUHpEL0xBYnNhQ0ZwM3VkRU1VVlJwQlZVY0U4NE1DbXJyRGVraS95RWhl?=
 =?utf-8?B?cVFjajR4MEwxa2pLTVRxa3AyOWdkL0FGdVFqdUdhUHhKVFdubzMvdnFpa1Q0?=
 =?utf-8?B?b0NGbVZIVDlocStvVHcrVzR2UXNpVDloMmhUZmNSNnVUT0JaNDc4RTZoeEZz?=
 =?utf-8?B?cm5OOTYrYmlIV0pSaHc2TDBibTU4S285Wk51TnMwM0FMay8yRjZET0dRZ2Y4?=
 =?utf-8?B?S2xMc0JGcUJsZDFsMUlSa3pBcGUzc3g4MkRhY2lhSGVINzNjWkRwbWZHUjlv?=
 =?utf-8?B?cjQwR2hhcnhySDI2SnkrVitGOXlvMUtMeFR4SnNJck9tQ0hwK3EvUEZPSERo?=
 =?utf-8?B?SHk3RUtZejhOV0JLQThTQUpkekdaS0E1Y0lLa3Q0cEhHRUYxVzcxcmQ0SmVK?=
 =?utf-8?B?Q1QzVnhiY0hGanVLS1B0cnJRY00zZlNTQUQxVW1kc2liMG9MMUlBeDJVcFlp?=
 =?utf-8?B?dzdjeXRmTkFIb0I2SHI3YjlDTG9qclRSU1FzeDhlWi9ZNElMTWhPbXVYdVZH?=
 =?utf-8?B?ODg0TW1Ea0dLTkJOZTJydFVGVXB0S2Q2N0RFbmtGUW5WYXUvZHRNdUNvODJj?=
 =?utf-8?B?RTdyQmhoRnlmdWR0ZEViNkJVT1pxYWZsMjlNcXY4S2pORnpQaTIwZTlkTmMw?=
 =?utf-8?B?RVU5QUloOWZYOEtKY1g4bnY5ZzFzRGtyVE9iZ3JYNytWenA5K0Q2Wit1WTBV?=
 =?utf-8?B?NFB1NkNmdVhSQ3VQR1pPcXNzYm1KdCtFVmorSVg2VUJEU1JJUVovNGk3SS9J?=
 =?utf-8?B?SUE5aFNuWXpuTm50Umljbkd3TmIzbmtsWUYvd2xqeDQ2eUFTaDF1QzA1dmJZ?=
 =?utf-8?B?VU4wdHZMNzBCc0N5SDlJd3ppQVdHOHNaam5nNzl6RjFmTnhzS05KWVRTbjBZ?=
 =?utf-8?B?VlNiTEg5bUZJNDJpM093M3pJWGxoTjVxbHZNL09wdGVRVG53NnZwbkpOdVhI?=
 =?utf-8?B?ZWkxc1pzcGpGbHdhK003dkU3QWVtcC9oVjFUUHhObTM1R0lORTJ5RVdmVjU1?=
 =?utf-8?Q?JLCn25p6F/ziESAHLp6HivAURziPX+Pg++IxTsx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWM3cmM1VVMwMllwaGpRYm5KVzU2blk3Si9IUHl6L3lmTjVndnBWeWMxTEtp?=
 =?utf-8?B?VENaVEM4Y044dHNmTWxXQXczNDNDOEhjc083K1IzYkpPK2NoQmxHZVlyNG9u?=
 =?utf-8?B?dXVkL01zYndVWmZQSTZob2kzNmV0WG9uc2VIV293N2YvTGtWdXJUZnowRlBP?=
 =?utf-8?B?aVkrajVoMU5SSEs2V0pEWXJLVGNDemk0SjFrSTNKTXlUQ0RoT3lMaU1EeHM1?=
 =?utf-8?B?bmZjdmdoSmZXSTBOZVROSEpsSzBia25sQ3pPbmowTWlXRWdFNG83cVRyRm1D?=
 =?utf-8?B?VjNUTzNhRUZCMUVldm1ML3VNVFFDVU4weGY2TVl4c3lhbFprZlJiTEd3SDZT?=
 =?utf-8?B?WWJ4OFp0UEYyV25ja0RWd3pSbmRoMis1eDB1QzU4VlZONG5IN291Ty9rTTRj?=
 =?utf-8?B?V1ZaV0IzVEoxdHhXSHRaUGlxM0pDbzV4RWVhZDMwQ3ZMcnpHWEY0S1BGNWRN?=
 =?utf-8?B?ZkhnN0hVUUVOdE5DcU8xUlFaMWFrQ3JtNXE2ck5taHpZT09kQmJUQmdkbCtz?=
 =?utf-8?B?UkpLa1lsYlVEaGZScjQ4YjdDY1U1OEJrckdMUHZYMlB1Z1dYaWE4RU8vZnl1?=
 =?utf-8?B?bzdOdG9ONllMR1VVNjJWK2twN1hNRDUwOW1aZVRwcmt4ZXcrZDJ1TUZ5S1A0?=
 =?utf-8?B?c1VvVXFkcitHc0JjUlRMcU44QU9lTVJaVEVHS1pILzhDeFl0SUFkNkR1anMx?=
 =?utf-8?B?aU1nUVpFVVByUERwZE8rbytBdngveG1GbmdRVDV2eHd1ZVJBSGx3RHlFd284?=
 =?utf-8?B?Mk15QjcxbWo3TWVoVW5DVHRhTGhIUXFzZjlCbFF0U2k1TEFaU3VUSG1wSWhl?=
 =?utf-8?B?LzVlNkFhK0pmVG9hTC9zYTNpTFpKR1gwVWVsK2xFZXVBQXB6Mnl4TmFUVWZM?=
 =?utf-8?B?UzIzT3NFTGVJMklYRFFuV1dTRXF6dkxtcFJyWHhQUlA4MjNjbC90SG0rZGw3?=
 =?utf-8?B?QWF1elBVR0wvYWJDdGErN0J6Y2RiejlUaDRRZkIwYytCYzl1UHdCT0l4Um0x?=
 =?utf-8?B?RFFwdSttclJReE5oaXd2QlRoREk3RXpsUVZQWjFPQnI5TEZ6MVFSZ2poTVNU?=
 =?utf-8?B?anY1VXNzVVN5dERjWEFPQkxDRlZIVzdwVHpKLzFUbmZYVU9hMkN3MElRWTAz?=
 =?utf-8?B?Y3BZTXVpTkpqWjFycTRFVjdUaS9kWUM1a1VjbDM1eDlYNWJtK3p6SkFZSzUy?=
 =?utf-8?B?WS9NTjEwTUxkalIramV1ZWlpZW5KdlorcDBiWVFOdmRReEVpbFV1T0ZpdVZ1?=
 =?utf-8?B?NjdXdW10YW5mSytEdmJ3Q0tJdXF6ODBQMXV0aTIyOWpJNVVNUUFveWkvRzFE?=
 =?utf-8?B?bWo2NDVBUWNKd0JJNWxMaXBrd2dKY1NodHNVRDUzTHBya1RuV3dHbjc2Z3ho?=
 =?utf-8?B?K2U3YWpjT2tZRFZ6Tm84dVcvRlZiTlVIOFluZDhnNUFUTURuN29mQndtTmFX?=
 =?utf-8?B?L09wb1A5allRb3dqU0ljOXlteElkSDE4OWVPWHU1OEw4MlZlbHNHSk1jQ2ln?=
 =?utf-8?B?eTZ3UjNvaDJNV1pVdHN0aFg3UVZaMG0za0lWaFNmeGdHdng1TG5DbDhoTEJs?=
 =?utf-8?B?U0Z4VEFMS3VFMjM3U3I0WU5QaUpvU2F4SjRWQjMxQXg4U0l6UndVRUZsWlBz?=
 =?utf-8?B?MXk5UDNDMncxQ0xkZ0VOV2xtbXpDY0tieWNzVXRaVUdCZnM2cWU2ZEtlSnlN?=
 =?utf-8?B?WVZHeEtPSEJnSEZWR2hCMTJwS1JvMVpPaTNnWlJad1QxT3M0ajA5bGQ5ejNV?=
 =?utf-8?B?Q1c0dUVIb3JzUU13N05WNW93Ly9sZjE0a2NoUEtMZFdUMGQ1MHRvVTBFTisw?=
 =?utf-8?B?aHZ1REU2UWZheGV0MWFjUDZKZmErS0drOWZrd0MrbitrMEc2WGg1L0NwOEdP?=
 =?utf-8?B?dHM1OVgvclZVemd0UWdsL3pDa3R2MkN1RUdiQjJGQU5jOWQ5UjFzRE1FeHF2?=
 =?utf-8?B?MW1vZXlvbFRBb0hicTBQS2JxR3lzbURwVWdKbG1veTl6bXNoMnhnMnYrTWtW?=
 =?utf-8?B?NmNWejg2eEZBSDVUcEx4RkNTMFpVVlQ0ODJPMjl6R0lqYk1Bb05IL2JmSEo1?=
 =?utf-8?B?UElVY2hvN3FyYjlGZE44bFlrd2poUW5ZQy8vZVJDR0UzbTFXR29HdFNiSldL?=
 =?utf-8?Q?Kp1wVw3TTwXCRYSrzZ24VWnwC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a245b64-c687-4261-a072-08dd100f9593
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 00:48:47.9732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +9izmQ42yvPbKOnvrM5dLSwfXIzN6+57jAAM9gkj2gUuceJdBDuzAOYI/7flm5fkA3d0O0ATdl5v+nEmGK4vww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5097
X-OriginatorOrg: intel.com

On Wed, Nov 27, 2024 at 01:07:24PM +0100, Alice Ryhl wrote:
> On Wed, Nov 27, 2024 at 3:38 AM kernel test robot <lkp@intel.com> wrote:
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   b50ecc5aca4d18f1f0c4942f5c797bc85edef144
> > commit: 6e59bcc9c8adec9a5bbedfa95a89946c56c510d9 rust: add static_branch_unlikely for static_key_false
> > date:   3 weeks ago
> > config: um-randconfig-r111-20241126 (https://download.01.org/0day-ci/archive/20241127/202411271011.gFsgMWRv-lkp@intel.com/config)
> > compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241127/202411271011.gFsgMWRv-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202411271011.gFsgMWRv-lkp@intel.com/
> >
> > sparse warnings: (new ones prefixed by >>)
> >    rust/helpers/helpers.c: note: in included file:
> >    rust/helpers/helpers.c: note: in included file:
> >    rust/helpers/helpers.c: note: in included file:
> >    rust/helpers/helpers.c: note: in included file:
> >    rust/helpers/helpers.c: note: in included file:
> > >> rust/helpers/jump_label.c:10:5: sparse: sparse: symbol 'rust_helper_static_key_count' was not declared. Should it be static?
> >    rust/helpers/helpers.c: note: in included file:
> >    rust/helpers/helpers.c: note: in included file:
> >    rust/helpers/mutex.c:11:6: sparse: sparse: symbol 'rust_helper___mutex_init' was not declared. Should it be static?
> >    rust/helpers/helpers.c: note: in included file:
> >    rust/helpers/helpers.c: note: in included file:
> >    rust/helpers/helpers.c: note: in included file:
> >    rust/helpers/helpers.c: note: in included file:
> >    rust/helpers/helpers.c: note: in included file:
> >    rust/helpers/helpers.c: note: in included file:
> >    rust/helpers/helpers.c: note: in included file:
> >    rust/helpers/helpers.c: note: in included file:
> >    rust/helpers/helpers.c: note: in included file:
> >    rust/helpers/helpers.c: note: in included file:
> >    rust/helpers/helpers.c: note: in included file:
> >    rust/helpers/spinlock.c:16:6: sparse: sparse: context imbalance in 'rust_helper_spin_lock' - wrong count at exit
> >    rust/helpers/spinlock.c:21:6: sparse: sparse: context imbalance in 'rust_helper_spin_unlock' - unexpected unlock
> >
> > vim +/rust_helper_static_key_count +10 rust/helpers/jump_label.c
> >
> >      8
> >      9  #ifndef CONFIG_JUMP_LABEL
> >   > 10  int rust_helper_static_key_count(struct static_key *key)
> 
> Can we turn off sparse warnings for rust/helpers?

Got it, we will ignore the sparse warning for rust/helpers at bot side.

> 
> Alice
> 

