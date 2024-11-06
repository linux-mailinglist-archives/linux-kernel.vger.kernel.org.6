Return-Path: <linux-kernel+bounces-398726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 904879BF539
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F1F4282B0B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA224208202;
	Wed,  6 Nov 2024 18:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BFH7ccka"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD55A201104
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730917713; cv=fail; b=cjyB/wbFfUnJ/a3BjP6fHzRn8MMtM+7i645PqqySL9qR4dIKBFhEXqLSj/U59m4uI1xBM702clzGP5ID5WrWzEUeHvYj1lYvpAlCBhTnQES46V0q3ow7A7MTBOYILFbH+0fQJ9Wz5bKTAkBEgP+k/b6sotpgwsKKhsLwIWqseOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730917713; c=relaxed/simple;
	bh=RqXeMiM0CtE2h8eT8SAab2GzmkiDJ+2EE/eFU6Cq5M8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XJytb9uO5P96R8P0t2UsYabKwV0FL/gRZ6mmx+PFQ4Sgxzz6Upu8WpriuHAIQo4cPq00ZaWPkt4wZDfyeo+1ZBV7dq/O5r/AMQWhvobShRkLQrtUj1S+d0AYPhgWhmmU/ZQflNdo55lcrWT58aQyaD3Ly5Y6bf9vt/Z+N04SmvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BFH7ccka; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730917712; x=1762453712;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RqXeMiM0CtE2h8eT8SAab2GzmkiDJ+2EE/eFU6Cq5M8=;
  b=BFH7cckahzmYL0TDzBvYo5HJyLYL9z+xbP9aLheXMDg2UDW1x0imRVRt
   lR4rv8QIW+hokKdm/Nc2ocNFHtqrMMmMdoyJWNeBpFJfned2RG9Osgv4I
   4Gee+PmRxTGmxYVcq8a/vjtw209eHxq5MWH/k7KlBj3gJCu79cKB4pQ6p
   Z5oZzYslRh5tpYN+KkThmaHsGhKdwMcM2bRQi3kz9I40une33kv88sF+P
   c4ezT4YpzSmwzG/qAWyZdeeegx74Vdk3WGPRMakyRHOf9bm6U7Cir6Rbl
   9dHCDLzS4tuHIMifdBM2G1evbrLzVqwDdN4cLiFXDrzqMEPucLVrPiFab
   Q==;
X-CSE-ConnectionGUID: 94frMXXIStW4Yc+af/bjNQ==
X-CSE-MsgGUID: Fdq5uEwvQEi/wZ0clfunGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="30851856"
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="30851856"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 10:28:31 -0800
X-CSE-ConnectionGUID: kuWWKgW8S9uMS6aF6h52GQ==
X-CSE-MsgGUID: lhhzMuVEQVaAZmJ0n+RRSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="89482986"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2024 10:28:31 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 6 Nov 2024 10:28:30 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 6 Nov 2024 10:28:30 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 6 Nov 2024 10:28:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xyhlvbtFH8dqXIvPH7Dx67R2bRyU9WQt9UkU1aPpJl+1qx3gNB0rK+7DrMvHrNh5PcKkYNY5tf8HhVW9TnQyCTYJVqgjnD7rZisRtADw6UgKtmBN9Xehl4iUb+v2Fupenob5imzbBxhSlN5jEwm4Eb8QoRy7zSMMxlGNDaSMErhNuhhR6q7cWzBwVVdQUP9l0+uDE0AdffCKMkDf8wJJ3c0JVwWmbnkk2dmtSOe/PVnYmr/QJ3w+sK7a+kddwAr2OV3qFJcv3LLjYbOiLO8ixo5XlufnQEesx5OaJ09nWNPBoAiIJuiWDf6AW38N3Yb0MyfIidOyv+fMPFBw0zQTXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQtaUkVXBfW81moX7o74EolCWGqpp2QYHYL0dgyeQAw=;
 b=ubq5unfzue62EabaWtUIVChIqEsfS1/xiYD4I9tmRzJ2kVGVXVjHnC6JaEyI4CycgyXW9JFsqJ801SBO6Nv8NSAC4mM3iVbJKfRL9Vdweq9DKWGOIHO174GI83SLp/heqrEzZ2wGOEt+THQmRcSqyAtXkgsiN/XoKOS5pLQLzd7tw27XLE7LVCJ/6vCuF7gzSZB/qrCQwb75I9Pr5HR9ZAN0t9+RQkk6ywTHipPfMdjSTpljlb7lbqvxkXiKIOzYPH84er4MYJKvqm3AWWt5tN8JARBoy7me9M1iq256bolK5uUzUuVQxnTsAsVt4GzBAfzq2UUVIi8VxaYp/Tlf7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 MW4PR11MB7077.namprd11.prod.outlook.com (2603:10b6:303:223::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Wed, 6 Nov
 2024 18:28:28 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9%3]) with mapi id 15.20.8114.032; Wed, 6 Nov 2024
 18:28:28 +0000
Message-ID: <d8d3959a-8c38-4ce4-885d-6a1e40219831@intel.com>
Date: Wed, 6 Nov 2024 10:28:25 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/7] x86/microcode/intel: Prepare for microcode
 staging
To: Borislav Petkov <bp@alien8.de>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <dave.hansen@linux.intel.com>
References: <20241001161042.465584-1-chang.seok.bae@intel.com>
 <20241001161042.465584-5-chang.seok.bae@intel.com>
 <20241104111630.GSZyitDuXnBYmEFxvo@fat_crate.local>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20241104111630.GSZyitDuXnBYmEFxvo@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::10) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|MW4PR11MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a194680-438a-411a-755c-08dcfe90ceb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXdqc0FrRk5Pbzd6aWRXK2NCU1duNFpleklEb2hsbk1vZHFpT0FvNVArZjdy?=
 =?utf-8?B?R3ZDMmptN1FHeTBOck9TVmJxd2hYY0REZzJrSjMxcHVueFd5QzdiY0E3djF5?=
 =?utf-8?B?MnBGekovTHdMcTMwU201UG1jUnlYSzdjMTNWelpvTVMxeTdHbjQyUlBtT3lt?=
 =?utf-8?B?NVBwdzBrejRvYWFnaGxOc29sQmFxaUY1MytocEI3RnQ4dnowUEdvaG9kME9M?=
 =?utf-8?B?ZzBtUWQ1NWtJZGc0VnVvaG1IQllYbHZXSG9SeUlTa05kelZ5N09pT3BwOVBI?=
 =?utf-8?B?YmpqVCtRUkY1ZU4waEdMV2V1ZzcwM2lVYkxnV2dhZ0NaVWZ0a1Z4NkgwQlor?=
 =?utf-8?B?S01oMXRnZkxNRU9RdHVFV3c0K1pab0NNMkFGenU2NXVuUGhudWZqTzJMNnFV?=
 =?utf-8?B?UVJEdWozQW5xcXYyanhYMVZtaDJqRjFUZ01meW5pSWF0VDljdlNkc1oyWGNZ?=
 =?utf-8?B?ME80KzNtTnpxV1BkTXduejdzOHBwVXU2dUJJdTJaUjV5ck5ZVU5EZWN1Uity?=
 =?utf-8?B?NHpUd0RHNm9sNkM5czlBQnRpWVlDTWU3VDlCa0M3clNoeTM2SEc0QjlZYU44?=
 =?utf-8?B?R09JeWRrK3BzV1AwT3ZlOHpoZ1B2ZFI3OW1rbTdEclFuZEkrWkdGMHE5QU9n?=
 =?utf-8?B?M0hvRVgzaFZ2ckVYT1J0eTVPeWRCZjh4MmRPUG5na3hqSVJ0OVk5bjF1L1Y4?=
 =?utf-8?B?YTBGaCtMSS95ajhmbGJocitOcURYeWNvbUJGY1BUS01uZGZMTi81amRGOFpl?=
 =?utf-8?B?RFYrK3BqQUgxSlBsdDRUTHluVFY4YnNoVzhOcHVFL25tbDBwZTNNK1JZb3ox?=
 =?utf-8?B?aytvVnZtOWZEVFY3amo3eHo4dDF3UGZscE8wM3dtSzVZRjBXdmFsb2FpaFU4?=
 =?utf-8?B?VVFyUnpkOWxSSmJqek5QNk9veE1MQi9ocS9wNys4Q0dyOTlYZzR4MTZ4ZlI5?=
 =?utf-8?B?NXBFTkJsSC9LMnJ4YzR1UWRBaHpiaitWSGlwMzJ2QkRLK1A2MGlSZzNWbVhs?=
 =?utf-8?B?eXFRS25Ba3hpRGtGYThLTzFGeU5ERzZmc1FqWnI5Z1VHZXp2SENxaXo3SWpU?=
 =?utf-8?B?QjhiZTJISFpXcTlCaU54UVVDSlRvWHRDKzlCT1Z6WVdpMEZoWWxuM1hJaERU?=
 =?utf-8?B?MUxqOExlTGxUYUhJRjVOSVhZd3VhaEtHbDRpZXdybHZqMWJOeVQycmM4Nzlq?=
 =?utf-8?B?TUZsallVNkFlQlQveVNueCtSd0xvb3d0VWxvS0RDZ1JXL2VBR1owaS9zY04v?=
 =?utf-8?B?Qnc3RXRwaDFlN2lsZTVpUzRReWFsb1k0Z1RQT3FGNTFZcndFYlZrVnJSMHda?=
 =?utf-8?B?NG9pSWR4SGNEVHhBN3I3cElQNGdKcHpvVVJkckxrTFEwWDhOQUZjemI5dHFq?=
 =?utf-8?B?TVlvYldMa3A1RFdjZ1FUUjBVRm1yclowa2ZkdTJGK05WaGwzdkEvVHFHSExh?=
 =?utf-8?B?WVdKR2lPaU4wOS93OHFwV3BxeVBWYXlBOGl5ZEFDRmtNbFFIUytGYSs4K0lH?=
 =?utf-8?B?Ry9lb0hpV1FzbmFKSEFkalFjVnJxNGRsWE8vaG1GaXYzbnRlN2EzV1NBeExi?=
 =?utf-8?B?ZmlHbFBTNGFkYWdaQXExemViUTFhVHF1MjFYTVR3bzZjeHo2cE9NaGtoN0cr?=
 =?utf-8?B?TjNna3pIaUk3VmJnRm9nNGlQS09QTGZXdC9OZnF4ZkRVRDA1MnNBcVVyOXlL?=
 =?utf-8?B?WlcxRG0wY3NzbmhFSnlobWxjVC9ZOURHUzh0T0lLTGp5a2ZMTnhhaEl3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1hBTjd1eVUrZkpKVkV2amlHcjY4enU0cEJoZlljbWJ5ajMyUnNwekpKUUYy?=
 =?utf-8?B?c0l3MEFmeERmZFpteE4ybTNpVGRBNTc4L29sQld2bWZZb2MydGVGSkV4WmpV?=
 =?utf-8?B?ekIzamFnVFJBdE5UYytIRE9ycHVwQmU5aCtnWGJ1ZVBpMEp6c1paN0JtWjdo?=
 =?utf-8?B?cDRPTk1VRGVRWFl3K1JxeG9ZUGlvc241cXd1ZFlKMFVZTEgxZWl4OHBFd0Fa?=
 =?utf-8?B?OXFQOHNZbzArTXZkTG1HelBDNVVxUXpSQW1hVmlvaGN6VGRxakU3cmxKbDVO?=
 =?utf-8?B?Tlplc1NLdnpzbFVDRVgyTTN3aTlIby9ZMXdVR2Fkd0JxQTJVOFlVV1MvU2t2?=
 =?utf-8?B?RlltOTBNcmFibndRL1lZb3duM0hTSmo5SjVuaTRBQWhRbDZBUVN2NjhXcldJ?=
 =?utf-8?B?SVVOY1BnMzRObGtvUWl4TjBjY3YydWtUOFNFT0toUVArbElpSGIxWUtzejd3?=
 =?utf-8?B?VE5xSDNrSlhNK3NQT296QkFQOWJyVFBnVTNkN1Z3QTRTWkdLcFJSaGxRV1Fh?=
 =?utf-8?B?TGV1dTlKelJua0hueDhpM2RWV2gxc2ZsYWt4NXlZUFVvUFQ5NFF3OUNmQjk0?=
 =?utf-8?B?bW5GQ3lqTUJkTkNrbmJoeTNaSFVTSTNnTXVpUmxiMVZrcVhOcktSQS9ybFJD?=
 =?utf-8?B?S0F3Nk5mVHZ2WU9sc2huQkpjOTFUR3NFanQ5YS8wWEZha1NqVC9tL1hSbUNS?=
 =?utf-8?B?Q3ExTVlrbTFnSmIwd3pnbjY4MW80S0h4ck1XTW1ac1pQR1pGZE5SRFpKaHVa?=
 =?utf-8?B?c3c5OWNhL0xnV2NBT1dNaGNHN0JvVVIwSVB5eTR2bXdjTXp0K3RCbk41bUFz?=
 =?utf-8?B?Ry96eFh4Ni81WDdNU1JQeUJIUXVHd0hzYUxXUjg3VEdFTGxUY1pYSW0zaWd4?=
 =?utf-8?B?NjFPRXR6VVY4andLTEVtS2VCQXhtNHhFNjlwTmFXSFc5c0d2citoMXhLVVZX?=
 =?utf-8?B?eEIrclc3Qlp6RXJIc3NwcmI3c1NuRWl3VVlSWWQ0bmVmcHpzRk1BaFJZdHlj?=
 =?utf-8?B?eDg4aUhURnJmb0xScnpzY21VVjhTbTgxZTlkOXQ0aG9OeWwyUG53UGFpL2tB?=
 =?utf-8?B?VmVsZmpPdmRYQ3VNNUpGNlkza1dwekxjb2lIVmhLTUVuYnZoUytvQU1RZVAv?=
 =?utf-8?B?eFBIdG9weFRwYUx5Q3FLWmtEUE42WHBOdEY0SFpSVjlwbVZnN1pCYmtuN2dk?=
 =?utf-8?B?Q1JIVFJ3MmlrMy8yY1RFdmxqdEkvRlMrS0ZBL3ZaMjlWTUVkZHJBQXZmY3Fk?=
 =?utf-8?B?MURrUUtGQkVWNk5uMVhPTVBxM1duc3ZOSVZoUW5rZmdiTmZEWDBYd29wcXNp?=
 =?utf-8?B?MmVLL0wxZVZiRk1MOTE2YjN3RGZoemdFNldqdW9uM3daNzhsSXVCa1laMmZP?=
 =?utf-8?B?bFZBbXJ2Wjdwakk1VStoS3MvbzRrcXVBU2d1QVJPTlM4VDE0OU5xQ0hyeHJr?=
 =?utf-8?B?SnBkdjVWeGg4dkc1enVqZU9zNFh3SE1Pem5TSjJyTGZOQ3E3citMYVEvaTE5?=
 =?utf-8?B?amI0SFF2bDh2TEwzRzl2Q3p2dVlDMTduME5lTGU3T09IMnEvbU12SWxMNnVL?=
 =?utf-8?B?RHFtRno2MGZyR2tyUjVoUnVnU0JwYVNreDZERXNIZENoVTZaQjlYalNVbU9M?=
 =?utf-8?B?cVV4VGEwSEtSdHQrUnNhN3J6ajRtNFhFRmxVWTlMZ1FicVIxMmtLWWNJbnJs?=
 =?utf-8?B?VWtXRGp6clFVVDYrWkVsNGxzTXk5b1FOaE53UEtSc2ViMktQcFNJeVRTNTR2?=
 =?utf-8?B?YWdpcDZHWmhXRzU5c1NabmpXaUhPWkw2T2pkZE85eVVhT2JwU0tpWXlnUjhj?=
 =?utf-8?B?YkpFa08xTVYrVjF1WVU0b3NKenFGd2xLdTZaYXFNbHVzNTY1S2NSNUFEUmox?=
 =?utf-8?B?KytWVkZUSzRreUt4VVNGckdpc2MrTk1uZ08rc1FXNDZIdE0vM3U2ZHFVTjVR?=
 =?utf-8?B?NHhFYVBTaWRYRCtvRm9HWWMxRFVvMEhZb0Y4QzVJK2NZU2JlNmx1aEhVbnox?=
 =?utf-8?B?UTBXa3lwb2xiRlBwWkVMeFByVFVQUkJQaGdKUFM4MUMvWGZZVXZVOW1DVS9I?=
 =?utf-8?B?cTBHNVdWaXpHSXZRNXNQQzNEbHR5SlpMWEs0ZHRhMnJtYXRoTEFxMTdkZU1o?=
 =?utf-8?B?ZG5kZDB0RzNrNW4rRkYzNTlWRXpUY0JoNWpVWmx5RUVYZWljcktMa0lzVDRP?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a194680-438a-411a-755c-08dcfe90ceb8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 18:28:27.9024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVaKI28Z2vh+kS8HXADqX9qO0UKh9ZV/Unu7ZztKr3ywDzLTrmBZzey4CJofvO0hxlI2hO2t4ZNDPDGdZprNocjw7kLwxvTLnvQzc+I+e1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7077
X-OriginatorOrg: intel.com

On 11/4/2024 3:16 AM, Borislav Petkov wrote:
> On Tue, Oct 01, 2024 at 09:10:39AM -0700, Chang S. Bae wrote:
>> +
>> +static bool need_staging(u64 *mmio_addrs, u64 pa)
>> +{
>> +	unsigned int i;
>> +
>> +	for (i = 0; mmio_addrs[i] != 0; i++) {
>> +		if (mmio_addrs[i] == pa)
>> +			return false;
>> +	}
>> +	mmio_addrs[i] = pa;
> 
> This is a weird function - its name is supposed to mean it queries something
> but then it has side effects too.

I think I've carved out a bit more out of the loop and convoluted them
into a single function.

Instead, let the helper simply find the position in the array,

         static unsigned int find_pos(u64 *mmio_addrs, u64 mmio_pa)
         {
                 unsigned int i;

                 for (i = 0; mmio_addrs[i] != 0; i++) {
                         if (mmio_addrs[i] == mmio_pa)
                                 break;
                 }
                 return i;
         }

and update the array from there:

         static void stage_microcode(void)
         {
                 unsigned int pos;
                 ...
                 for_each_cpu(cpu, cpu_online_mask) {
                         /* set 'mmio_pa' from RDMSR */

                         pos = find_pos(mmio_addrs, mmio_pa);
                         if (mmio_addrs[pos] == mmio_pa)
                                 continue;

                         /* do staging */

                         mmio_addrs[pos] = mmio_pa;
                 }
                 ...
         }

Or, even the loop code can include it:

         for_each_cpu(...) {
                 /* set 'mmio_pa' from RDMSR */

                 /* Find either the last position or a match */
                 for (i = 0; mmio_addrs[i] != 0 && mmio_addrs[i] != 
mmio_pa; i++);

                 if (mmio_addrs[i] == mmio_pa)
                         continue;

                 /* do staging */

                 mmio_addrs[i] = mmio_pa;
         }

Maybe, if this unusual one line for-loop is not an issue, this can make
the code simple. Otherwise, at least the helper should remain doing one
thing.

    >> +	for_each_cpu(cpu, cpu_online_mask) {
> 
> Oh great, and someone went and offlined one of those CPUs right here. Fun.

Yes, offlining matters. Let me summarize a few things related to the
patchset for the record:

   *  The staging flow is tiggered by load_late_locked(), which already
      holds cpus_read_lock() [1].

   *  When any SMT primary threads is offlined, setup_cpus() makes it
      exit right away [2].

   *  When an offlined CPU is brought up online, it follows the early
      loading path, which does not include staging.

[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/cpu/microcode/core.c#n705
[2]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/cpu/microcode/core.c#n658

> 
>> +		mmio_pa = staging_addr(cpu);
>> +
>> +		if (need_staging(mmio_addrs, mmio_pa) &&
>> +		    !staging_work(mmio_pa, ucode_patch_late, totalsize)) {
> 
> do_stage()
> 
>> +			pr_err("Error: staging failed.\n");
> 
> 							... on CPU%d, err_val: 0x%x"\n"
> 
> perhaps?
> 
> For more info debugging something like that?

Maybe, either one of two ways:

The work function remains returning bool value, then it can print the
error message from there.

         bool do_stage(...)
         {
                 ...
                 pr_err("Error: staging failed on CPU%d, with %s.\n",
                         smp_processor_id(), state == UCODE_TIMEOUT ? 
"timeout" : "error");
                 return false
         }

Then, this function may simply return on error.

         static void stage_microcode(void)
         {
                 ...
                 if (!do_stage(...))
                         goto out;
                 ...
         out:
                 kfree(mmio_addrs);
         }

Or, let the work function return a value like an enum ucode_state
indicating the status, and print the error message here.

         static void stage_microcode(void)
         {
                 enum ucode_state state;

                 ...
                 state = do_stage(...);
                 if (state != UCODE_OK)
                         goto err_out;

         err_out:
                 pr_err("Error: ...);
         out:
                 ...
         }

> 
>> +			goto out;
>> +		}
>> +	}
>> +
>> +	pr_info("Staging succeeded.\n");
> 
> 		"Staging of patch revision 0x%x succeeded.\n"...
> 
> more user-friendly.

Yes, that seems to be useful to put it on:

+       pr_info("Staging of patch revision 0x%x succeeded.\n",
+               ((struct microcode_header_intel *)ucode_patch_late)->rev);

If successful, users will see something like this:

[   25.352716] microcode: Staging is available.
[   25.357684] microcode: Current revision: 0x1234
[  136.203269] microcode: Staging of patch revision 0xabcd succeeded.
[  137.398491] microcode: load: updated on xx primary CPUs with yy siblings
[  137.427386] microcode: revision: 0x1234 -> 0xabcd

Thanks,
Chang

