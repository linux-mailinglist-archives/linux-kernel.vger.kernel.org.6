Return-Path: <linux-kernel+bounces-234262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB64291C45E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D7528106B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F0D1C9ECF;
	Fri, 28 Jun 2024 17:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gp4GA4kA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A223B1CD15
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719594295; cv=fail; b=i/2U/E8ERQlz2XhFQZhCIjeOtxFSmLacHUFp3N6LvRd9r1inRaCIyqXT0kOnIhQYA1vZ7nrFGEwI1OnbZ6wavMvE9UF5EkNO8mZev5qCHpcKvXhSIOrqHJh6+y2+VVF4hEYIGmzjb8LB3a9lfQs+y2J8Fw5Yw5yuFiZU/fVHVMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719594295; c=relaxed/simple;
	bh=uFvT4phbuxywE4QOeqwgk19QKvSOcJDpVr1Nji6Gqqs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a5KPgrSqJ4bGcrnkE68ru38g60Kw7QTY6K5aQ5Z08ny3JIkh4C0qzWigevxSoHAmZqo/uQvWejI4bq/75xSRdNpbbd+9DMHacoLFJby6OGWuYI0q5CdDvWLsxdMqULuL+eugJddpevB1WjOmayTj2VyRTEYinJKmypgGdjrQBsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gp4GA4kA; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719594294; x=1751130294;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uFvT4phbuxywE4QOeqwgk19QKvSOcJDpVr1Nji6Gqqs=;
  b=gp4GA4kABga74d9Rpo49067EKVS1xhfnIbte0VPvtnrsb5m6edvVOuuC
   M4cd9f3A0tKjUbF1Mxp+d6xureMa14mCF+DCVEzqE0xEXm+WtfefdWjMk
   78CcTYbhewYRqT8Y2hDw/1Pk1icBPIw6gt2wZwJllrJw5rwi9BvrmThcJ
   dnIk6DXrY41Hf/H0bnmqY52E95G+Quq+ibi8dYyrackTgTEdcbc4CFpQx
   ejF8JtKl5HQhfe0XixYQa1o2EuUtVN3WcvPfqBUn1HNAh+7JX6iPjQE15
   GzAY0nnhgeFlg/toIxFfTwuzJ2DmQpGRvXJ4k3hXHa5h8eaDdFcAk3FKr
   A==;
X-CSE-ConnectionGUID: J9gKJEp9RX2z/hyp+g38Fw==
X-CSE-MsgGUID: 0kBM3DzpQ6C2gj4U3tKWQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16622746"
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="16622746"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 10:04:53 -0700
X-CSE-ConnectionGUID: Bnuex6v1SiCBpNBZ3bpqOw==
X-CSE-MsgGUID: t5Ddfv+wQPWgshT/Pw8MJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="75524605"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jun 2024 10:04:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 10:04:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 10:04:52 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 10:04:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBmjnWGf40IGrklfSnbm61tVh9Oga/q/DFWOFNe88CA7J1bt+ckWeS+NOPKucJURWOKz1VO7XL5mS5+uZfXF7dZJsDrR5Yf6Wfv1EN6xzzAjSkdOORalqEzLDmYcyOAcUve62y2RagbP9DvpPuW09a/Ovg6iCJhes5DTlRuW7teKXexrEpqe44V5RdLu6rPE9c1ujLHyLCt93f5lU9w2lEq/zmf4ExE33HBJ6LrBz/GcQMZv3jEHCOzeSQLNFtIujIei136x9YrwSgqG7BgTpbNvMJ6lisx+W+FOWP7+SGmzbrO0zkJn/7UWNsyhateOpdF2hLmglZ4e39/a/YaDXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acKNt+K4smspTx9Byx49ug2ab9YTq9XtLODMai7MfkY=;
 b=FKVVD9NGTvEmQXUt6Fut1sUKKflYOichJFljzsHGYs6spSj7KlzhxoyYbLFQFASo+cZ6txoJVagaRkelxXUtij+NLFZOAT72C61O/YPLSTBYX4dgGCy3hUPQQntOneym85xYeq29WS5wYHQRtXXfqBDcH0JfbVoOIPGHymvWlEQoOE3oOaIJ2kFKwpCFnassnOY0VjoeMnsvifO6wy+6y8uHEwHspPpjSovzm84ZpPQok820ewa5q7sjNJUBgR+SDyU7YMeVPWf9ThgC8u/oEaBCiHUoXsm5cCvIlIrJ+1VAudZG6xsVttEp88Zoa6DoZ0ws05uGkHQPFdNxMVdbcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB5162.namprd11.prod.outlook.com (2603:10b6:806:114::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Fri, 28 Jun
 2024 17:04:47 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 17:04:47 +0000
Message-ID: <17b614c0-29e4-44a8-823d-2ac62619bfa0@intel.com>
Date: Fri, 28 Jun 2024 10:04:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 37/38] x86/resctrl: Move the filesystem bits to headers
 visible to fs/resctrl
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
References: <20240614150033.10454-1-james.morse@arm.com>
 <20240614150033.10454-38-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240614150033.10454-38-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0026.namprd21.prod.outlook.com
 (2603:10b6:302:1::39) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB5162:EE_
X-MS-Office365-Filtering-Correlation-Id: cd420eaf-1ff9-4f50-18f6-08dc97946a4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0ZaQWJCY0tST0phTHoycnl6eUdYbm9nWUNRQWNvSmRTbHk1bmM5V0N0MGJV?=
 =?utf-8?B?MWU5WFliSFFRcW1rR2NuamFNUWwyOVV2WGhycjBwY2lWVWkxdXQ5T3lOOVZY?=
 =?utf-8?B?Ky9mSkhVVHZqQVIzU3g5bjA4RGpDdnA2RXlramkwV24xUmFsSmtySUwvSjlL?=
 =?utf-8?B?blRSbUp1bSsrS2FnRHhFNzhFMVBndEswYXh6emxmMWtZemxZbXR5eEZCNm1P?=
 =?utf-8?B?ZWFQemZ3VjhkSFdscjFnamMrc1dNT2VNOVhYbVRkbmp5S3VHOFBFaXpzTFZ2?=
 =?utf-8?B?SnArS0RYMlNheVQrREhzRmdmV2dkQWMwYkhmM1pYdlkwQWYxcTRYaGpYMk9S?=
 =?utf-8?B?bHV4NUIzUlVDQkp0QXMxZk1JQjBPRWFMTXFtYVBZaDNjQkZWWnRhd2lXR2F3?=
 =?utf-8?B?d0ROeVFERTJ1b0VvK1VSazM2cDZmMElSVmsyY29JcEFYQTArWWtqSWhldWZp?=
 =?utf-8?B?cWNraEMzN2JoYkRmRTdDSGw1R0VybHFkcXZCdmxQYUg1TVJ1MU1nY1UydDla?=
 =?utf-8?B?M2Zod0FSVzFmQW9BNGZUSVQvS2xRWHpmUXZLQWtiMDZRVzFlVUlUNjJYblJJ?=
 =?utf-8?B?YUhRMDJidkFFZlg0MUNnZHE5dUJGZEVXa3dSQVY2bHEzWi9XTW5hNkcyWHFO?=
 =?utf-8?B?OU1sQlNmcVEvZ2FWcHdhRWh2R1E3VFhGNmNhR2NzUEFtN2ZHNXRoZHBoUHVm?=
 =?utf-8?B?aE5lYXdNY3l3WHNjbkVGYitBUU9FRXcvODBNVzkza2pjUnFSQ3MxekxXTHZP?=
 =?utf-8?B?Z2JYa25JZ2d0UjNUSGFXZktDSVpLTmoybmhQb0NJVzVvSDExT2NsU3BDNVh6?=
 =?utf-8?B?cjNOZWM2UTdMYWdIR0xuam5oQmIxVCtzQ2xybk9zU0cveGVZY09JQU5ZMVBX?=
 =?utf-8?B?ZFBwYTlvcm41eStQb1hxTjZRL3orY0t0SjlDNHE0QVhQbmRPQ3lxck5jNU5x?=
 =?utf-8?B?cEhydW1CMUMvMUpHRlVWaUMxUVM5cHhwMnkvanMrV3pwL2pHVkJUWVowMmND?=
 =?utf-8?B?Q0V5NHBDeWd4V0s4UzBSSWRESVM4VTd5U09GRXNuYjBnRCtXSW9uVncrL091?=
 =?utf-8?B?TFBDZko5UnRCSG9SWEljOVNMOHpxRTdLRWtUSmk5NlVtUkNqQkorcUdhenI4?=
 =?utf-8?B?ZFlTNTVPTW9DUlV0UHBSbHJpQ2EvUVRwK1JhL3p4RndPbm1zUXo2OE9KK2Vz?=
 =?utf-8?B?a2xXOFVzTldEbFZlWjVFZUp5QWorN2ZkTlVPZWtCWjd0UHhlTTkzbkIyVUEr?=
 =?utf-8?B?MTl0dHRJVmNUWnNNdFJnOFNuYzBBQ1VzdlVTbjBmbGJlK1BtbU1EQTV0NkZE?=
 =?utf-8?B?WFM3N1NHTEhEZC90SkI0S3JhSTdKUTFoZXpXVkFKN25UQVcwcHlBeUV4cjhT?=
 =?utf-8?B?U29mYUZtRHFDQ081MHp4V0UvUFcxbUpUYThITkJKcFlmbStrNitCclh2Z0Zs?=
 =?utf-8?B?bUNicWpMbjdmdHlTcVIvQWwvZTNES01oOGpDd1c2KzI2YjFlSG5hNmRoRC9R?=
 =?utf-8?B?cFg1U3czK1RqMlM2bExEUTNZZFkxbkNIcjBWVXl4OGFoSjNoNWpZQVFDYXpu?=
 =?utf-8?B?RmZ2TmFFNkU0MXo0MXdCTnh4dkxvZ2pDeGpWUEh0akoxeHRNTWpOR094ZHlS?=
 =?utf-8?B?WUpxVGZGRjJ2TEdPcTF5ZTZvYUNPdjdqMTEwYmpUeXYrVWNqOGhZd1E0aU5X?=
 =?utf-8?B?Qk1kS1QxcCtLNlF0UG5JZ29XblRiVi93SXllVE11c0RtL3owMjM0a3ZHeGs1?=
 =?utf-8?B?dXNSTldpb3pTb1lNeStkbzNnVWcrM0lkTDZiclA0a1lSVGxuellMMldscytl?=
 =?utf-8?B?ZlJsZXgvbC9BMXc2ZExEdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGREKzFRVkVLODA4MkNCdHo5QndtWGJqZUwzYzlUWjl4ZFgwcWVvNHlTMGRq?=
 =?utf-8?B?eHB1T2pNeHg0bkJaZjRNMW5Rc3RsWUtWSXhCdHFlanFmTjBOb3pja3prOTJP?=
 =?utf-8?B?Q1dOSVVMK1lGZTBZQmg2cC8xSzg0bVpyeDdHYytmcytqR0RSczlDZ0ZZcVYv?=
 =?utf-8?B?K3ExVGRSY1VNTXFaQ3NGRUxDays0dnVkNTlISHRydzU4WVZyTllsejhxOHJV?=
 =?utf-8?B?SEV3T2x5NlpBOWI1WEVkOXQ1Y0tSQWVTSVlya0NDSytPUXFwZUVWRXU4d0R3?=
 =?utf-8?B?cjkxMzlsc1NBajlmQkFWTmNqNENFeUNpWGFrcWcxNU1VT1d6Y3FvZGFQL1Vs?=
 =?utf-8?B?N25vVUVRU2NYU3VEY1lLOUx5TVRZVk9zaTEvR3g4NGk1QXhIUkNURGtKUVFn?=
 =?utf-8?B?V1NZM3pKZkk3MS9OSUQvLzVFVGRzZzhOWkx6Y1o3VDE0RG9TRUdNTnZwbnhs?=
 =?utf-8?B?QnBtMmFzSThtZ2ZiTzlNcEd6d3grV3YxNEQ0MU10WkxXM2U5Qm5Gd2lVWTRO?=
 =?utf-8?B?ckJpeWhZSGR0U3BUY2IrMW9xYndoR1l2bXlIa2VpMXF2ZUhXRjZHN1BhQ2w0?=
 =?utf-8?B?QkxRWkVGOHAyeDJxNE5oTTBmRWRlRUQwSTNURVFla2RDTDNLMGR0THUxb3ov?=
 =?utf-8?B?Zy9vUDI1QWZaNjJmdGpWd1EzL3lDTFhRSlQ5dzJzWEFjZ0hLeEIzYnlyT3Bv?=
 =?utf-8?B?MERWREhtT25JdEMvK0RFdDQ0TThKd3F0VjNSdXBDVjliWGtMVXZlSlhSRTkz?=
 =?utf-8?B?ay80bm42N1hGSTM2SnBZakpyZFFOWmpqdG5mR3VqZW9aSm55eVZHQUo4Sm9x?=
 =?utf-8?B?QjFvZG5USUY5NkdDUDJ4VE1ZMTNVcFVaMVZ1eWlPengwc3A4dExCMy9zc3Ni?=
 =?utf-8?B?cXRaVmZPMmZmT2IrVzY4L3I3emtLWkFmWGxtT1RQYjc4ZVJmOHR2OGJ3QlEv?=
 =?utf-8?B?YjdzVVRsNkZlVUJVTi9HNmZENndrWForTGJ4cmRhWFMveDlTQ2RORzlTQWtC?=
 =?utf-8?B?Q3p0N25EUlRpWkJFR1hIVHFFckw5U3duL0Z6Z24vMFBCWWZrWmk1dGxPS3hU?=
 =?utf-8?B?UG5aYVdZditJWUdzaEhwWmxPeTFNTHVmQ1BlQUw1WjVOQjl3Q2sveHhXUFEx?=
 =?utf-8?B?NFJwclFtZVZxUGtLWFhhMkVCRHdwclV1aEhjRlJ6SGRIVEg5Z0RsQVp1Z2F4?=
 =?utf-8?B?SVZLSm5VL0ZLc0ozZzRvcTMyVFRDMFRvUnhYRTA3M2xhTU5wVDZmMXVXRFh1?=
 =?utf-8?B?UUE1TWxUUXJlRXZGWllsb1RacTNETmJGU3hWeFMzcnMrMVpoSXFSUTZ4UXh5?=
 =?utf-8?B?ZXgxME02TDA0NUtnUmpXeVF4bVB4NWlRakR6eTVNQnlZaFhyUWhZK28wTWsy?=
 =?utf-8?B?aVJ0Z1JIdHFkQ3R6dGVOWXBJQ2JwWlEwUXVyY0c2dk9uTmhrK0xYMFBGNGhn?=
 =?utf-8?B?UmdKbWZQaWpOSER0RFc3Tmd0VC94UExPcElrSjJUb3RjN2Rac25mZFlyUG5z?=
 =?utf-8?B?NThKNXFRS0k0dlJlZks3UUQ2YTduOW1FQkVneDB1M0NTR2ovczJCZ2JQY09H?=
 =?utf-8?B?d3c2dFQ1WDFNZHIydlpkSGlPQytzMzMzWFZNOFNPVDAxTElZNGJnMDg5ZXhk?=
 =?utf-8?B?S1VWM2c3RE9vU2Y5KzJMaXpRZHBvcWprZEVvak8rQUZhMExrM3p2UDN2OTZF?=
 =?utf-8?B?bTFUUTlmay9vUkNvZWxqWFhBSXhlREROL2l2L3hINXJHbUNwZlNzcHIwOThX?=
 =?utf-8?B?R21QT2IzWWRmTEpvejVhMkFDVzI0R0dwV0VqbldzdzFTZ0RhQVVoejdVRGti?=
 =?utf-8?B?eGxRbWppaStSY0xRM0Fnc1dBbHZJaGF0UWdKS3UyWnRDTUJuME5IRWNjQ2VJ?=
 =?utf-8?B?OURXamhYWEtIa3d3L2N6S0pFQUNNdlRpanhPTkxhQlhlOWZRU3lDZGZKMGw3?=
 =?utf-8?B?Nm9sem94VlFrempxamlWdUlXdCttOWFLL1NwVVhNbFhEMldpaWtFaHZEWUxG?=
 =?utf-8?B?NHBjeU9hY0NxTHJaNm9OeUZVN25HMUVjMUVlNmkwd3pkVnhKNEFFRkRSdXYw?=
 =?utf-8?B?QUJINlVrcUFXdkpwdkxLZ2lEVmo5bnpGL2pQLzFVWkozSkxaVVF5TmZSaXdJ?=
 =?utf-8?B?aExlbUsvcUVLSnZtVUsyRldvTUVLZGdld2FYU0FjaGFJV1QyUkErZzRTbnUv?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd420eaf-1ff9-4f50-18f6-08dc97946a4b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 17:04:47.5436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cTca6GJ+HTKH7jShPxXohCHUegvMs2EFR5yiXOjwZtGUUit4ki43flNs6Ojumsq15EGu8Pa2WaGVl8ap8+3xHMMpNEh7HluBGVhxEw0flQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5162
X-OriginatorOrg: intel.com

Hi James,

On 6/14/24 8:00 AM, James Morse wrote:
> Once the filesystem parts of resctrl move to fs/resctrl, it cannot rely
> on definitions in x86's internal.h.
> 
> Move definitions in internal.h that need to be shared between the
> filesystem and architecture code to header files that fs/resctrl can
> include.
> 
> Doing this separately means the filesystem code only moves between files
> of the same name, instead of having these changes mixed in too.
> 
> Co-developed-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ----

"----" -> "---" to prevent following text from being included in changelog.

Reinette

