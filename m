Return-Path: <linux-kernel+bounces-515708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDCFA367F0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 23:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4813AEA4F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98461E3DFD;
	Fri, 14 Feb 2025 22:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U4KdX392"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1885E1FBEB5
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 22:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739570404; cv=fail; b=rXPJ8JcwbRsUMeR+vdlMnmIC/K67i+5kkDLmuLqjyVCxc3HICkmkyFpfMMTpSDOWU06LD1AhqcGnkfBTyvt1Hxf0KXmUIvfbTmmQ3I1hYagYiIQVUXeFGxekrzyKD3Mc4HpWFHCs408gvbucvZSbim3eE0qI2dM1a0at00xALSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739570404; c=relaxed/simple;
	bh=48902MydtAI3pnWfosPUiEWihwADgPaNMG1SpNlt6tQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b5/Pe5zFaEjXKb/pT3nuyiHjBhh5PH0r5KzAzKd8w6mW2INq2DklmH3FWAUkAmYx13+18idKEJgNbOMaGt4L1HiD+ZGQORkj65cwg+kEChnRqN3hpQcj4LWi3vsKOBxOtJtoavuJXvdFgSH+jzVbtcxBlgjtz5wHuG2bjmhX2Xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U4KdX392; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739570402; x=1771106402;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=48902MydtAI3pnWfosPUiEWihwADgPaNMG1SpNlt6tQ=;
  b=U4KdX392Hct8G3JzS1vNg9U6sRDwkYYjAKKYKp6nw1pEiz0dUDaUNwdk
   HrqtWc3EvHqqmb4vQSrju9b0ZCKd5Yy322qZjPIYHNXuL5LRcw442JJQU
   psI+GG7MXfhEw1BWiX3ZLIP1zs5cnjquzhORA49QSSgiIWUmGtSgUDrar
   ymvAqqHvvfUkIWHCoWt4J15Pc7IvaKv1K8NlOH2WG6Xo0a7lbaMo5+q5Y
   wrutA4Qy4cnavscua3kZR0RGDpM5tgluQ3S8jqY0HX6VxOXnRg6YJQph1
   9Rmeqtnu+Ac8/YjqZqMp3p7RDMaFEMthXLZ3AK4wNXF166fIMfqMtrep4
   Q==;
X-CSE-ConnectionGUID: TwfkhzEmRMmjX/eFa3rFmA==
X-CSE-MsgGUID: h4a/wWNpR0m3WS3F7zHkAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="65685288"
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="65685288"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 14:00:01 -0800
X-CSE-ConnectionGUID: D12urSl8RMCHnDFeA4t2sg==
X-CSE-MsgGUID: rT/m8FjHRcOZePFsGaus7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113429345"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2025 14:00:01 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 14 Feb 2025 14:00:00 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 14 Feb 2025 14:00:00 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Feb 2025 13:59:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJMHre9d+ogOqNK4/HKoxI0pjF7l4rJ91HaT2Wg/seTCWF1HuQKPwG2sMt1t9FEK21c6LitUGWTImD0+RsWhsj+QvJS7qvc3tSKkETGb3RCwsVM+uUzAJgX5+mn9tsMWaISEqYAuFLakbaFaomJmDBn/zbVH3yFEZjOs7hkD06Biu4bjDN+lgOWmenk+i7F6xbWF4dvPwa+PbD9vrqpPS39ScnzEnDM3/tYoZy/wTKvgzIVjZzQHa3LX1kcYUUPdgzclRVS2x2gxUYol+alEH2fJOtAxeZQT+xVJ2lmbKdPenpaKu2W1zTgeBEaFYFA9QJQwlJy63CFY+f/UzbBjZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n481rG78dgPqfAMCoQbvaMreY9fh+dNwYQsgBdmTYyw=;
 b=OQCn/BdVCR4a8cNpTaJEkkOnGbSkyWfYAqFecdFhYLiRAdjp/i7mGwBnKKmkE2Zj2F/DgywnC1ve6uDwqTz99z+OparbMtsS06X6C4ujmtXkXgiiGEG4DTIUwjO4qdamTEsQT/O9w4WvglXRsotyn/KGuWdv3zAM/zYJtc8U3bzJ0W1IG14OLUXisfgo2IlbBh/RaxAoTXNDe7m5MzxyqHfMf2Q3vywpMlLFDkTLI7aooz5wMFFixOJOGzjyjUzEm9JQ8kP/8xBk960li/4JnL/Jm4bB+gmRYympv95IDm+DbLI1hWeJ8FOcvBEOkZXWAJ/rWS+Wu/zupb+BW6RtCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 PH7PR11MB6547.namprd11.prod.outlook.com (2603:10b6:510:211::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 21:59:56 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26%3]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 21:59:56 +0000
Message-ID: <12ed2ab1-e97d-4a20-8370-8c60cabffc77@intel.com>
Date: Fri, 14 Feb 2025 15:59:52 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] tsm: Unified Measurement Register ABI for TVMs
To: Dave Hansen <dave.hansen@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20250212-tdx-rtmr-v1-0-9795dc49e132@intel.com>
 <15c69d57-4ffb-4ea1-8cbc-0ba6d3d7b14f@intel.com>
 <be7e3c9d-208a-4bda-b8cf-9119f3e0c4ce@intel.com>
 <015cdddb-7f74-4205-af8a-b15cad7ddc22@intel.com>
 <d8f3eb33-d902-4391-adc7-005e4895b471@intel.com>
 <c7894df2-2b27-4f67-b428-3eca312503f9@intel.com>
 <c2cf2184-7753-454e-ac99-8c4f3c9c3d16@intel.com>
 <01fc0997-a0e7-4086-b0aa-67b4a51b328a@intel.com>
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <01fc0997-a0e7-4086-b0aa-67b4a51b328a@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0146.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::31) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|PH7PR11MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: b547fbcd-faba-4885-cf9b-08dd4d42eae1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHlZN0lHSGxLNXZzZDBKSlljQ3Q3N0N4WTU5Zy90eGZ3cmJKM0RublNmMDlT?=
 =?utf-8?B?SWVJZXBOTHM2Um5qd2tlajVBNHBRT1p1aThaV1ZDVk9KVlVRYkRWTUlRMVND?=
 =?utf-8?B?VWdOU3R3MDNEcDR5WnVPODlhMlE0SGR4cUpZSkRkVHpjYytuNUQ0WHpBU2VW?=
 =?utf-8?B?cHh2b1F3TDU2eWZYTTRaVnFxOWIzRS9BNW1UUnNyTGpsbmRIdE5Jc1JZL0pD?=
 =?utf-8?B?eUpUZzhBSEVSa01NU2NXRVVnZmpsd3JkbGNaRnlyODhLblQrenc3NmJqYmdR?=
 =?utf-8?B?WjRhaUs4V2lsQ3VBWjV1cVBDcnhST2VtRzJ1YUNkcmNWOElNWHFQUGNFaGty?=
 =?utf-8?B?TXc2Z0xVQnYyaTZvSURvdTkzOXAwdFA1cXoxa3l1Z3lLSWtPRWYvQm9IRE56?=
 =?utf-8?B?Z2xnUktPbDlSWnhmbitwajZMRUhGVDhtVEdUcUdqWTQ1Z1Nqd2tRSTNyRG9s?=
 =?utf-8?B?L0FVYVh6THdteVRvZVQ3N09QQlptK0xhNHcxZHZqZjFSZDZTTk5sQUFDczVW?=
 =?utf-8?B?R0NyTVBoMDZoUE9NR2ZPc0pCQmVwVlRSV3YyZkdBdUgzcHRwQVR4RTRSUCtl?=
 =?utf-8?B?MGdVcTM3VXpLZnRSajg5MUROT04rdjYxM1hXUlBGdGJ2VzNQUXd0R1gvR0ZW?=
 =?utf-8?B?SXVhWWxZMDRNeE9DcVFWdktUbkZlZE9WZU9DQzBDWWJOSy9kQlduREVPck94?=
 =?utf-8?B?MGxTcE4wUEdwNmtVVkc0YVlYN0xHS1hmeVU3NG80MlNCd0VFMEVHZDA3QTZs?=
 =?utf-8?B?dko2aWFCRXpvMWtNRjk3Zkp3ckNmeW5LNU9Rb2lvNHI5TlBESUJuS0VPMTV0?=
 =?utf-8?B?VVZEbjdUZDhsOFNRc21qYTFKSFJaMW9FMnpyeEhFVHBwNERBNFllUjBhNURP?=
 =?utf-8?B?NGlYLzJJa2xGT0pvY2Z5L3I2aHhWR1dwYmFySmpKV0pUeUtCVm1tZmppTEI0?=
 =?utf-8?B?amxzZWQ0eHdCeXp4dUJ4dFFUdmNKT2xmbXUwLzhFa3gxVUc5VTZNbmRNMnlQ?=
 =?utf-8?B?M3VpSzVCeUpPV3lrc2l6NXhTb1lqWTh6cTdSR2p5dU1GMzNMbUxqNGcySG4y?=
 =?utf-8?B?UlIxUFJtZnBoektlTm5xTFRqQ09FK013SU5vdTNNckttSk9JNmVOcy8zWE9o?=
 =?utf-8?B?WG5YY2Zrby9sUGt4dUlPdlE0Si9BRUxLc1dxY2hzbCs1U3FsL1E0YnBpdHYv?=
 =?utf-8?B?TXdnWGNaczRvQ3JSN0FDLzh6TEV2ZUVFNDZ2V01QYnpNOE5yMnlGcmZmeWF6?=
 =?utf-8?B?dEVqZm9wTENDK0wyTW1uakxDeTdIclNxNVdtTXd0MzNHWms4VHdxcmhkNEZl?=
 =?utf-8?B?S1h0M0lDVDdFRitZWERVcXRBME55bjRaN1RZMGc2YkdJUWpiNlBoU2pnczJj?=
 =?utf-8?B?dit3Z0xON2NVcTFUSVVJTVUzbkdWU2VETHJZVjJMOEd5Qm85SkdoT1hEVFZv?=
 =?utf-8?B?bjV2V0VKTC9aVXVWV2tIK1NvYmswSUIxQWh3YitJNzU2aUtpekxMMlNUbmRi?=
 =?utf-8?B?M3pJelNqeVE4MVVXMldpUEZIVVJBTWRsUDJlTERNamF6SXZibHFvUWd3R0Qx?=
 =?utf-8?B?dHdrald0eTB1WkJRRThXeDB1UDVldjlZbTJ1Qmh1amVwUWh6TitDakc3Qkt2?=
 =?utf-8?B?cC9tNy9yRkFRSXFyR1pRZEpNTFhVNXlHR2JwUFg5VFh2VHgvQUdvQnJEWVJ6?=
 =?utf-8?B?MWxER3RWdnIwbzNLVXk4UDMwODVUZzhjQ3BQS0pvMVlEQ0g2SGpzNU9EblZX?=
 =?utf-8?B?c0s3dHM2VE1JSmxERXIrLzRVVGF0L3Z0MXFjME12R0cvcnFVYUJtWHFaRXVI?=
 =?utf-8?B?L0x3VGZyZW85UTFuRkxqK0ZZb1BHSVpKTTZRUTJ6Y1piM2R4NHp5c3ZVanBx?=
 =?utf-8?Q?UbGAN8CUunE1T?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGx1TmlFN0lBRSt4ZjBoV2pQcHRaMnBacXVSVm9TUE1nbFdyK3ZVcnpxV1dI?=
 =?utf-8?B?UDEyaEY2d3lGRDlibG11d3BRSnJSdnNrSGZuVVdpa2RhOFF5TjZ0aHVWMExI?=
 =?utf-8?B?OE9IWlMzMDF6aDhDMHFGUytvdkJaYU4ybzhVMHZGbUI1alZRUWMxbkdrdFJI?=
 =?utf-8?B?eXYvaStCTnorQ0RIelZ1SmpOc3YrUkx6UmZObG9UOHpHY3lZM25QUDJnWnBX?=
 =?utf-8?B?dVQ0eHI1MFA3YTBLbHBjNUR2TW1VanFhUEdvTldsYU5iV0FvcVNNb3RnYUJ3?=
 =?utf-8?B?b3ZKcnhrMUNyeVRlWXpWUG9pejhGRWM0aXFxN2VRZmZRb2lwc3Y0RlhEWC9T?=
 =?utf-8?B?RjU0cTNKaTAwdk9qQTNjamxhVktwNndtcGV3Q0JwZ1JWNnFTVVlMdzZoMHd3?=
 =?utf-8?B?aVdway9aY0FyYytiOG9VV0g2RnZ6akNhWWk2NkdlU2pkcGROb1daODdzWTNm?=
 =?utf-8?B?Yyt5R3RmdUcwcFNQSnRkcGpVT3VvcWJxR2w2UUMyUUxLWWxWdXhVaUsvbzR3?=
 =?utf-8?B?aU9ua2JGSlk4aGVlNGplcUY1YUdJUkNTQm4yNlNSUHhHYzRWK0dLQzVBbE5L?=
 =?utf-8?B?RTBiVDhKNW5aUEJOdDNhRktBZkQySk04QnFBbjdrLzRBMHRMUU1YaHdiajM3?=
 =?utf-8?B?UVFYdHMzVG45bnNtMU4zUURnWDREZFY5Qi9mQ21ZQysrYnQwNHUyZEdOaHpm?=
 =?utf-8?B?RGpUV3FIMGF1U1dZbGR0Zld3bjBmQXRNU0dLN1F2M2hNQ0FQRWdGZWN3QlV2?=
 =?utf-8?B?MklxZHhYcXYzZFNmQmRkMFFTYUxQdEl6RWlTbnRpMU96c0M4R08zR0hkMWZr?=
 =?utf-8?B?dlUxSEZWOWwxcjV2c1Q1QndKME04VmNFeG5ZT0ZXNklSUE5lbld5T29mTWhB?=
 =?utf-8?B?cXpIWHVPQ0NRc3lqR3QwdDU3MHE2RVE1RVJrcnFOWEZwYzhIZ2tTTGNVTjNZ?=
 =?utf-8?B?ZXUvQWtFVmlkNjBVOXJ3RWRjRm5BQTBIdWQ3KzJvYUxMUkZwRG8yTWxOWTFM?=
 =?utf-8?B?ZzZUSEZkQWpGUWl2ZjF3YytWMDZMaUY3L3cvbU10VEFCSWZFQUlvMjAxZmh6?=
 =?utf-8?B?dERmRFEvZjVKYXh3M0xXR1FQV08rMFlkWmovMUt4NDNCb0NUdzNLc0lHS2J4?=
 =?utf-8?B?VWorbG9rbFljajFvSWwxVWtxam11bWV0ZnFoT1RjT2YwQXlJWG81V05hdUZl?=
 =?utf-8?B?MTFlN0JmZXZPejZ0bzFuWGtreWMrOHVoVHZBZWY2TUJUTHd3Y0l2Nmh6TmVo?=
 =?utf-8?B?cVNjbUdpRElXV1BqVnkyaXpEOGNzbnhWTjNlQWdoZVgraTdjUGFjL0xtaXNv?=
 =?utf-8?B?SENSWExmalBROVJaSnM1Z0hXNVNSa3VuOWFuMHJlOTR6QTRld2VES2VxZ0ZT?=
 =?utf-8?B?QldpRnJ0ZW9yTFZSV2wrTnc1UVVncjFuTGMyNm00Y0phOUFHSnhEWkg4dThm?=
 =?utf-8?B?eUo1RFN1Qm9lVHcydUhxRzhpTTlmQ25TY242MlgxTjdIM05xbFNTK1MvaGVy?=
 =?utf-8?B?VzlCOG9WOFlGcVlFUkE0K3Vvc0tDM3pwb0dSUVNYUFZEc1MrTE80U2dFNUxx?=
 =?utf-8?B?bUIrRDcrZ2hLUVc4UWJ0eXBqckFTRUlnQUdrVkIxWUoxS3NoTFVQVFNxNi9z?=
 =?utf-8?B?MEx6NHRHdW9NTC9DWE1ac29ncjRCOGhMV3FEb005Qk11enQwZDllTll2VXZq?=
 =?utf-8?B?S1RaZlNmMW5kVmlWSGtLbHV2TEFidE1YNDFSK3VOTk5KQVpPK1k5N2U1S3NF?=
 =?utf-8?B?VGpPa2VpVTg4QW9RNWhiWVNPWmVTbC8xelpoZ2dVMWgyc2Z1aUYxeXhxekx0?=
 =?utf-8?B?eU15WXU5eTRhWnRXNkI1STlKQmpmWHFOWmc0cjZKdVVQNVVpTWdqM1Nyalpk?=
 =?utf-8?B?NFFQdGFjMTZXdDVOVjluRmZ3L0RvZWljSWpSditSVmJoK0xnbDc3OG1RSzc0?=
 =?utf-8?B?bU1OZGx5NDVLakh1Y1lIVHRsTUxpekVUNnNYbGVjZGR0OUF5MnI3b1ZMcFJp?=
 =?utf-8?B?SVBXWTRZMU5JTktZeVcyS0JDUngveXdweGRwWWFZTHhSRGFMY3drMWZTNGRu?=
 =?utf-8?B?ZXc5SkszNGppeEJMWktvU0hwTjFTTHRrWjJpUk1GQlprOFZFeW1ENDB1UVpw?=
 =?utf-8?Q?4UkAivuPqBmPOb2f5dWD8Jmm8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b547fbcd-faba-4885-cf9b-08dd4d42eae1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 21:59:56.2346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+cd1/OEdgcXxJs9ODPAT+pQabY5PaCr5lkt/5sOaTexwin2AKuvVqLtpCfMal8acYQ9iC4kjSmX6OCIdxyKIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6547
X-OriginatorOrg: intel.com

On 2/14/2025 10:26 AM, Dave Hansen wrote:
> On 2/14/25 08:19, Xing, Cedric wrote:
>>> But if this is for debug, wouldn't these belong better in debugfs? Do we
>>> really want to maintain this interface forever? There's no shame in
>>> debugfs.
>>>
>> There are many other (more important/significant) uses besides debugging.
>>
>> For example, any applications that make use of runtime measurements must
>> extend RTMRs, and this interface provides that exact functionality.
>>
>> Another example, a policy may be associated with a TD (e.g., CoCo) by
>> storing its digest in MRCONFIGID, so that the policy could be verified
>> against its digest at runtime. This interface allows applications to
>> read MRCONFIGID.
> 
> The attestation world is horrifically complicated, and I don't
> understand the details at _all_. You're going to have to explain this
> one to me like I'm five.
> 
> Could you also explain how this is different from the hardware and
> virtual TPMs and why this doesn't fit into that existing framework? How
> are TVMs novel? What justifies all this new stuff?
TVM (TEE VM) is a broad term referring to encrypted/protected VMs on 
various confidential computing (CC) architectures, such as AMD SEV, Arm 
CCA, Intel TDX, etc. Each of these architectures includes hardware 
components for storing software measurements, known as measurement 
registers (MRs). This patch series aims to provide the necessary 
functionality for applications that need to access these MRs.

There are no real/hardware TPMs but only virtual ones in TVMs. Virtual 
TPMs can be built upon the native MRs provided by the underlying CC 
architectures.

If you need more detailed information, I'd be happy to discuss it 
further offline to avoid cluttering the mailing list.

