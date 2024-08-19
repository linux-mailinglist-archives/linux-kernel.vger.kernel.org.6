Return-Path: <linux-kernel+bounces-292312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74013956DE2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BAEF286DA2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A039B1741C3;
	Mon, 19 Aug 2024 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TfP1x6vP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB3A16C6A0;
	Mon, 19 Aug 2024 14:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724079182; cv=fail; b=UcN3xiqp/u4No3B0vzVW/pUc4RwqQWTl3wyIsLBX9MvueHaStexa0qDSTUWwY2zEqCdgr584atKh5DuEiNxQ/ZM+n9vwB6At45MSJ3AoSPxN4YnKFtgCQBTDA6fPOD6wU04tiYn8lRCgVGVuH3DDtl1fvjY+SWWVAa7trS2Qs2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724079182; c=relaxed/simple;
	bh=VYq0NZsbB+RcHiQrEOeEIqX/54bTgFzjSQ3IMMKtZ9k=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kKN2CAbc1WxuzCzO7btDdwBtbcGEloy5Vj6DPWIWhZViQo+CX4sdCNw0lNAzVWuX7oLIHTQH35FclmbKqjQ/4Hm+XVY9fI/BoOR4TTp6GfOA1Isx9q/WU472E37vm96qHoHoXM61IbasFxAX6YrFub38RSTgAdSasa/LYmR1DeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TfP1x6vP; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724079181; x=1755615181;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VYq0NZsbB+RcHiQrEOeEIqX/54bTgFzjSQ3IMMKtZ9k=;
  b=TfP1x6vPdvKqy/02BeqI6Lf/gaprAf6FFdyCC2KAM+10PbSXUvJh+TZa
   GCIVCpASwsV71WXPuTjMJQbdWdaagublz2yWv0jZ+pZ8BQ1a8kokJ/CA0
   hIm9bxJkTolQBwY/10uOCgbWnv3Fz6SdghhPFkUrLlAQYOsupazZ0Reef
   1JZAzPd3Ubrfli5L9E+40XIHbiQBQRAQLwlxDQPU0aHTRdKr50ik5h2IZ
   m/t3htgffvTJnf9l10GMS3vOaQbO+nU7HXQcHPQwLn4ahEzfz9pj1/0HG
   B2pDAX1IjBLjEiht05PHshN3WB0ImEwCNMSO9Av67O4Dbbv9t9W+INqAP
   w==;
X-CSE-ConnectionGUID: gvK8rYG+SxWm/lFQI3+YWg==
X-CSE-MsgGUID: as17BoYAS8K05/s7LGG4Hg==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22473277"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="22473277"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 07:53:00 -0700
X-CSE-ConnectionGUID: jGzZNBSwSL2NSQqBkDKa6Q==
X-CSE-MsgGUID: D1rJgbt2SDetsbzav72aaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="60708926"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2024 07:53:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 07:52:58 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 07:52:58 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 07:52:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AItdsIEOzxjsyjOn92YLkb0M5zsKm6VvVFjCndNUumVEsU70MSdmEJZKzkZQs1v7lkqhlmdy4FBGXTUfCr2yt9YuRowPV4M5O7b/b/lR1RyS41zdDwB3Kdv8rpfkzfn5nBo32C22mH5g0AvS6hnNYMnc0+7owwiRtUhOAyS7S7LdHFA6nkbu37yZaAig72cmVoEVvhpMIyrGfxVTXK/oSmw+qIxvorsxP6asW/BMxzJo4/EuHRv6Hhka3WDViOnNDwaxICVkAusyy2hC2zjKm1rIABq2N53w+j4s7wnoEaLyAQTyrxNVtYDOMdZTjN0SbYMHODGLYxZjakq6LTZe9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uMLQbrFHUIFpFNQaGDDtgHV4ZtEXLaBwF0+Lqv4/ek=;
 b=Q2ruTaJC/DGcDCFjdok5E8NlO96CyaCPR9+sZQ9nDQxhfKSgDBUolKpAkgDPe+aE30nmqgWgA7MFYbv5+ue39LyOxxdK5obvaM1ZsIqsPSvcrOPySdEwFY9faYivZ+5hROzuplfhzMyFmKwzNC2c3TKTL7N/iL+LEPhVfKD8Fvprw1p2wvU13ae+/bBps5htd1NsHH7Wcu0YilblteRrU/kGbdmbRCq4HhzPJ3RQMnZhsPES1rDu53ePyE0P5eNS2zOY3je58tgnha9sUcZ4lAf42rPmSBwNe/NnfcQeeMW6JYykU+L8fXtXAHExuxUe4NGVZsos+CAD+40jI7qxkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6261.namprd11.prod.outlook.com (2603:10b6:8:a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 14:52:54 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 14:52:54 +0000
Message-ID: <96880c73-7f0b-4a62-8f9f-11042dec92c7@intel.com>
Date: Mon, 19 Aug 2024 07:52:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 19/22] x86/resctrl: Introduce the interface to switch
 between monitor modes
From: Reinette Chatre <reinette.chatre@intel.com>
To: Peter Newman <peternewman@google.com>
CC: James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <eranian@google.com>, <mingo@redhat.com>,
	<bp@alien8.de>, <corbet@lwn.net>, <dave.hansen@linux.intel.com>,
	<fenghua.yu@intel.com>, <tglx@linutronix.de>
References: <cover.1722981659.git.babu.moger@amd.com>
 <784eaa900b9e0778ddc534c04c7ded9466bfd19b.1722981659.git.babu.moger@amd.com>
 <983fded5-48f8-439d-8afe-45b60841985a@arm.com>
 <8c93c091-39b3-4219-b892-9df2747eb91a@intel.com>
 <CALPaoCjmRyP00b9rTCjpxwLDJ2rYkQ8HuNMYJA+qVNo5a4Q9JQ@mail.gmail.com>
 <56aae68f-b590-42ec-a6b5-de3af97a8091@intel.com>
Content-Language: en-US
In-Reply-To: <56aae68f-b590-42ec-a6b5-de3af97a8091@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:303:b6::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eb9d29a-2cb0-4cc5-bd74-08dcc05e9b54
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEpXTitrQmVXckM1K2IxWURhVmloZWNIdDRnc3gwNjlHVXpUbTdzNUJJQnFF?=
 =?utf-8?B?UjZWc29nWjEyM0ZzMVk2VnZpVytNaFAyS0RkRGI4WElpbmNYNUJScG1NdDNp?=
 =?utf-8?B?QXZVWmt1ZzVmRTMxejdpU3BYN04zZnVpNVNpLzEra3IvekNXSFAyZ3RyNmo4?=
 =?utf-8?B?K1hwTmdqdkVIV1drWWNTYkxSc25xWlpSTWM2aTdZMWFqSitXQXA5cW9WY25w?=
 =?utf-8?B?TVhTWGFRelF0T2lGNWxydFl3Tjczd2wzZnQvdXg5NXdYVHJZTFZSYnh0M1Bw?=
 =?utf-8?B?Y21PQnpOYjdDMWVNbjlHSWFKeTJNRWpCTnJIZ3Nid2psRXhnTUswVitsK3di?=
 =?utf-8?B?V0ZiZHRsZldHVGp1Y3hyZDFQeWMxMGxZMmVtM0dDOWNNQUxXZk9yYmd0bWhM?=
 =?utf-8?B?UEdUNm5TbVhqYXBwdVFmRHZ3SHBhZGRWdy84aXh5YzQ2U05qd2crMVBnSnFU?=
 =?utf-8?B?QXRmVTIwcHpuZk1hajJSV0RFZXBOLzM3QUZKakp0OVFnWU13MmhKYlBEa25V?=
 =?utf-8?B?ampMZTI5Y3NoQS9qVDBJR01POG0xOHltOXUxMG1ORk5QMStoRnV5R0pJYTZG?=
 =?utf-8?B?RXdsVnNQUCtxN3VyUTAwMS9lY3piTG9XcmZmcHUrTVNQajc3ZUR5S1E0OTlZ?=
 =?utf-8?B?RmhUdE5sZENMSzFxT0g0SUlJeDcwcFRGZkU0dGZjZENmVVo5VlZEQlJ0ODBY?=
 =?utf-8?B?Y2pKRVk5bS9jdVFzNW9KNnNJdkRIaUkyd3o4eU40Qy9iMjRoVzMyWVdYcDV2?=
 =?utf-8?B?UnFLWVhMcXlHYURuY3JaNCtGcmUyLzZTUnFCNkRFV2ViQ00zek85cUlXa3RY?=
 =?utf-8?B?N21MTkRjNlBTZXBaam9oQ2Q2MHR5K1hkZExSOHQ2NldNcmxSVkViNC9tQUZq?=
 =?utf-8?B?NDRyTWo4Y0xHcGJDb3BwSisxcDZGMmt3YmJQcE5vTU5yWSs1N0gzRzBXR29B?=
 =?utf-8?B?R0QxNGVCeFU1dlErVDRFTXppeEtsL0hEN0JWTEw0aytRQ2cyNjdJUm9VS3o2?=
 =?utf-8?B?bGJ4MzJkNTNSeFV2OWt5SklqZTZMR21vU3pKc2FCMGljOCtER0tvQXFiZ3ZX?=
 =?utf-8?B?cDBpUE51eXlCNlNYK2NyMUxuaUN5NWU5RGxsN0hpK0RyVnMyOUpHRHd6WXlT?=
 =?utf-8?B?aUQySm8yMmpRUnltT1REdFUzOWFtcGpEK0t6VXlJWnZWbzFodEY4N21GbEdh?=
 =?utf-8?B?Vlo4ODFsM3dFSWRpcitwQ1orbFgyZTdXKytDV3hqV2pWa0VZTjViYUUxbkJQ?=
 =?utf-8?B?bFNicm1Pcmt6NEhkSGp5dWU1VmJKU0hDYURaSGZxZ1A3b3JUQk1LTGRpc2x0?=
 =?utf-8?B?K2YrTFUvL0FGckkzNmxSbHJ0T0VuY0psNlRIb1hRR2tiNy9BeHdOUkxyVXNW?=
 =?utf-8?B?aExrZjA0WXhRelB6dmp6bitqc0pTOUxpOWVsdVh3L2xjU1d3bXZNTkpYQWZ2?=
 =?utf-8?B?Y3JoL244MzJtaVc5MDJuRVAxQ296cHI4WlZ3Z3d3MWFHVndpN1hUWG1xR2V2?=
 =?utf-8?B?bGJrRW1sZzlhVW11MVBJLzRzekMweGZXVG00WHczZWhOZVJlbk0wSXp2UFVz?=
 =?utf-8?B?RVR3emI5dFU1ZDlBM2VJMGRKakpqTDRCRmM4bFJqNE1DMW1yTnMyN1Y1WExL?=
 =?utf-8?B?Mk1BL21CMTUzSktSZW9ac0pOYUdnejBIMEZ5NUYrTDllNUMwVFRKTlJaWno2?=
 =?utf-8?B?bzVCaHhodS9WUTNORWZmQ1dtbEtMbHlZeFdCeHNQUllwM3lEZG9kRlN5Mnp4?=
 =?utf-8?Q?OIIVTku4h5AvHitbJw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1FrWEpvU3ZqVkFtTEM3ZGtldUhTL2N2Ri9PUTZBdGJKdk9kOWJPcVJja2xu?=
 =?utf-8?B?WUlCbnJjSExWY2lDSWROcXUvbE5GQkJrcTVRMUhFZHpJVWlFOFd1SlJwT3pT?=
 =?utf-8?B?VVpETUJqY1lzS2drbUE2dmlpR21YUTl5TXN1RGtZenkxSWFBQ2I0R0RPb2t4?=
 =?utf-8?B?YnVvMWc0MlBOOVpuOSthWlNyMTRrZzNCcWNubmZENHEwQTVVSjQwemErZElH?=
 =?utf-8?B?V0dqQmZHVUFmL3FsaSttQjRZTzVtLzMxcStIMFVtOWpqRk9mOTNvSjJqQUlU?=
 =?utf-8?B?dFgzSGZwemtHalkzRWVuY2tjbURtQ3NWbm9LZVc3cGlSVFdqNDEyaEJjSHlM?=
 =?utf-8?B?cVl0bElsNW5ZZ1RSeGJJbHNmc0U2MUF2aEVqdklnaTZwb080ZnZlR3EvVVpQ?=
 =?utf-8?B?SmVib2xJRHBIN0FqTGFHRGo3ZUdxSUE0bk1QZFpha2FvbUhLdmpmKzd1Mmcr?=
 =?utf-8?B?cTFLenRUUmt0dEN4Skx3RitqWDM1Z1NQRkNPOFJaRjVpTU5zaldhUjhMVlQ0?=
 =?utf-8?B?WEJuNVJDV01BSUZwVDBuSkdlTURHTFBsd0kyTnZOaWVnZWhScE5BNFY2UVFu?=
 =?utf-8?B?Q0lBZ2F5MXhFRGkyVXdVY1o3dXZSem5wOTRYTktFUzh2aTF0bHlYMitjSDdE?=
 =?utf-8?B?WHpWYzgvTTZSUlFadDM3VXpuY2Iva2NudllnejJUTmp3V3NKMEVQSHIzQUNZ?=
 =?utf-8?B?d0pTZk9DeW1zYkRCdjdOc0RUMnpMSGd4SzgrdEhSZXIwa2JjbEhVMzhrZ2xT?=
 =?utf-8?B?WTJwTXNPb2xwYlpVK3NOQStWU2hZZnFCRnp1bkw0SmNnbjUvbzNzODlmMXQv?=
 =?utf-8?B?djhoS0tCaUdRT2M0MUNwcVRpM0tMN0ZlRFdTUXFjSHIrRkNwZkdvNFgzUThX?=
 =?utf-8?B?U1kxRzFlQ2FWQmRZbnpnaVFRYnF0d1kzUDQxVWNVNWhnSzRYcTVOd3NWQkdp?=
 =?utf-8?B?NFZLOS9maEc0WWZKaDFDalpnUGZ2OWpMUVB6M1pUWDhxd0s3N2g5VW01YU42?=
 =?utf-8?B?SnZ0WS80SDhhdnpUNGNaVm1sRkRVeGRTOHdveFp5Y01pcmJlUEVJZGVhRE9Z?=
 =?utf-8?B?SUdvSTJOYzd2NzY2N2pjbUd3V2YxQVZwSlArRzNmclZtWGtBVmppbEZkQndD?=
 =?utf-8?B?NjZ1QmVmRERUazI4MHFVM3dsRWU2ZUVTd2E5b2cwa2pZS0FiQlJLdUQ5eVl4?=
 =?utf-8?B?QWJUaUFPanBtbU55bllGY0RqVEFiZEcwem1reDJkZUwxdVBBZUFmOVYrQlpa?=
 =?utf-8?B?am5ZbnN0Zy8ra1VTM2ErR2JZaG9vWTdFRTZURlc4SGJZLzVFbkRPbmhnam12?=
 =?utf-8?B?Ty9wZ3Nxdm5yblljYlN3TnAraDduV1RHSlBSU1V3UWkraXY0eTY1bmdWclAy?=
 =?utf-8?B?QVRZbVdCclJrcmZ4cVcxdTg5V29iL3BOaWRld2JmVmlVZWNQbFlwRmFDVGJ6?=
 =?utf-8?B?NmFMbVlUcUNBNnRqWnJNZm95YlRteWxmR2tBcXZHRkw0akpvZ3FlSWpQWVM4?=
 =?utf-8?B?dERVOGprMWxncUlMbVFZai9UMEJTZTYyZStRT1B1VGFaKzZhVjQwcU16Wlp4?=
 =?utf-8?B?NVBIS3dJbWhwMnNCRmNKcU55MHc0MGx0ZTlaNEdYK3EyVStrVVdnL3VzYjRC?=
 =?utf-8?B?VmFRRWVIYTVISnRBZXBCbEFEbitteVlYai9MTzRwMlZ4ZXJrRi8xTG1BOE1k?=
 =?utf-8?B?NFgwdGZPNVNBaXZoM3RZRWk3endmV20rdWFMZytkRG8vYTZjU0RSaSt2aUF1?=
 =?utf-8?B?MndKTFRzL1Z2ejMrV0Fyd3NzV0ZOK0d4YVlyZGJBcTBJdjlpT3dUWlM4empH?=
 =?utf-8?B?a3d1YlhFQThiZEhvbUVtZW05b3JFVDMwY1B1bVIrMktGWkpYc0dIMlc0K0Vj?=
 =?utf-8?B?VUtxSkNKSU1BUnJXMTBzZVpmbmo4YmNZRW1vbTAwNDBVVm8vRDhiYmErbStW?=
 =?utf-8?B?d0grOEJyZ29IM0RjbWhFRkU1dmYxRjY1dE03N3BVc3NUTUdTWlV3Y2lPdWFz?=
 =?utf-8?B?cEs0c3RyWnlhcWVtRmYyd0d0Nlk4ZEhuQmpLOGRNZGFZR0FYMEw2RC9SK3do?=
 =?utf-8?B?Y095eWFSUjdNMXBWZGtmWGlKMTVPUzJzRSszc2NZY245SkRoUUFrR1hvMEFt?=
 =?utf-8?B?dTQ2UzVyNDJrVkRJcG85dng3S0l3emVZKyt5OWhWSVRYZDdNL0l2OEZ1Ti9o?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb9d29a-2cb0-4cc5-bd74-08dcc05e9b54
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 14:52:54.6939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2VfGRDINZeBGs9458ah7+nDxcrdOTWLJVy1r6LP6/yOvLb2IHCPEZFmJ7SerqiSlD/TP3ETkKsA6DWCnqDchRFUHfxrC/mtpLZaKLFGWZUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6261
X-OriginatorOrg: intel.com

Hi Peter and James,

On 8/16/24 11:09 AM, Reinette Chatre wrote:
> Hi Peter,
> 
> On 8/16/24 10:16 AM, Peter Newman wrote:
>> Hi Reinette,
>>
>> On Fri, Aug 16, 2024 at 10:01 AM Reinette Chatre
>> <reinette.chatre@intel.com> wrote:
>>>
>>> Hi James,
>>>
>>> On 8/16/24 9:31 AM, James Morse wrote:
>>>> Hi Babu,
>>>>
>>>> On 06/08/2024 23:00, Babu Moger wrote:
>>>>> Introduce interface to switch between ABMC and legacy modes.
>>>>>
>>>>> By default ABMC is enabled on boot if the feature is available.
>>>>> Provide the interface to go back to legacy mode if required.
>>>>
>>>> I may have missed it on an earlier version ... why would anyone want the non-ABMC
>>>> behaviour on hardware that requires it: counters randomly reset and randomly return
>>>> 'Unavailable'... is that actually useful?
>>>>
>>>> You default this to on, so there isn't a backward compatibility argument here.
>>>>
>>>> It seems like being able to disable this is a source of complexity - is it needed?
>>>
>>> The ability to go back to legacy was added while looking ahead to support the next
>>> "assignable counter" feature that is software based ("soft-RMID" .. "soft-ABMC"?).
>>>
>>> This series adds support for ABMC on recent AMD hardware to address the issue described
>>> in cover letter. This issue also exists on earlier AMD hardware that does not have the ABMC
>>> feature and Peter is working on a software solution to address the issue on non-ABMC hardware.
>>> This software solution is expected to have the same interface as the hardware solution but
>>> earlier discussions revealed that it may introduce extra latency that users may only want to
>>> accept during periods of active monitoring. Thus the option to disable the counter assignment
>>> mode.
>>
>> Sorry again for the soft-RMID/soft-ABMC confusion[1], it was soft-RMID
>> that impacted context switch latency. Soft-ABMC does not require any
>> additional work at context switch.
> 
> No problem. I did read [1] but I do not think I've seen soft-ABMC yet so
> my understanding of what it does is vague.
> 
>> The only disadvantage to soft-ABMC I can think of is that it also
>> limits reading llc_occupancy event counts to "assigned" groups,
>> whereas without it, llc_occupancy works reliably on all RMIDs on AMD
>> hardware.
> 
> hmmm ... keeping original llc_occupancy behavior does seem useful enough
> as motivation to keep the "legacy"/"default" mbm_assign_mode? It does sound
> to me as though soft-ABMC may not be as accurate when it comes to llc_occupancy.
> As I understand the hardware may tag entries in cache with RMID and that has a longer
> lifetime than the tasks that allocated that data into the cache. If soft-ABMC
> permanently associates an RMID with a local and total counter pair but that
> RMID is dynamically assigned to resctrl groups then a group may not always
> get the same RMID ... and thus its llc_occupancy data would be a combination of
> its cache allocations and all the cache allocations of resource groups that had
> that RMID before it. This may need significantly enhanced "limbo" handling?

To expand on this we may have to rework the interface if the counters can be
assigned to events other than MBM.

James: could you please elaborate how you plan to use this feature and if this
interface works for the planned usage?

Peter: considering the previous example [1] where soft-ABMC was using the "mbm_control"
interface I do not think it is ideal to only use the "t" and "l" flags while
llc_occupancy is also enabled/disabled via this interface. We should consider
(a) renaming the control file to indicate larger scope than MBM, (b) add flags
for llc_occupancy. What do you think? I believe this is in line with stated goal
from [1]: "I believe mbm_control should always accurately reflect which events
are being counted."

Reinette

[1] https://lore.kernel.org/lkml/CALPaoCi1CwLy_HbFNOxPfdReEJstd3c+DvOMJHb5P9jBP+iatw@mail.gmail.com/

