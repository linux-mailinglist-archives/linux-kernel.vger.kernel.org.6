Return-Path: <linux-kernel+bounces-217894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C01D290B5A7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56DE828375C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B5050285;
	Mon, 17 Jun 2024 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E3WWr0j/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7126A353
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718639633; cv=fail; b=pNagThynR8qrqx0fJX4fVSw31SeeFN3Z5qqGroGIZP8pMj4S7eTiM7+iuLv0Hzwi7wAtSAhnw8agR6blJ22egnmK4oUh7ARbmz9XOVVsEDl9KV19i9jkZdfUdyCQ7zozr4LCPwcCuBBlNxsnieB37Pz7uB3VfeLUskkFV9CvdgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718639633; c=relaxed/simple;
	bh=qfOrVli52KEY3I4NHHCvBkKPMt2+mVi6p8l5CByZw5Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QVflmq/SOiYC777kbxX6WlNJ+OZGgyZ/dPSJsgKFfxIhJytG40UR82g266cX61WXMh3RUym2brnAm6VTxBFqJtaCjoYnUijxaGce54tWqu2SFylibwKiHzGEidU2vXYJcckURNkGiV4x5m4mhiRkI9tKrg4/YWgl8OeVQbGbhM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E3WWr0j/; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718639631; x=1750175631;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qfOrVli52KEY3I4NHHCvBkKPMt2+mVi6p8l5CByZw5Y=;
  b=E3WWr0j/la0NqRihmKSxXUFN6KI5FkKlzzxHsKgWmBuSy1ErPs8V8TKo
   FGl/QlrAFwpCKbw6/jPAuD2Jm68Mrcccp5Z+gEmUh/V2A9HuUgnVXSnOA
   i8vkA5KFo8Harai+buSNwMTdhU6J0aiXMKN3hIg+vab7p2upd0l6Bh7O/
   NpBS65WQrqsOUCwjwL8fnCrcfJr/lo8DAZSmpTR7mAAJo7PamsPAVkWVz
   O8K0zDWUCoWppUta+QKmYriKmLN5k9RiexVQN9QAJ1K+rpREd0bgiAGlf
   9eT3H8G+iiAOD6o96VkySJzot+8xOTLnFUPaiyBy1DgkmAR2PlhvwfOno
   A==;
X-CSE-ConnectionGUID: JJoSAg2wTlibWyCf31ZW1Q==
X-CSE-MsgGUID: CLcBZ+HOR6qLYDdtAaZdrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15190134"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="15190134"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 08:53:50 -0700
X-CSE-ConnectionGUID: wfKOi6FZSK+FT5pYjFY+7w==
X-CSE-MsgGUID: o9vwb6IhT0iVoYHisg6+6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="41943249"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jun 2024 08:53:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 08:53:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 17 Jun 2024 08:53:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 08:53:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNMjnVCmG9U7ugPS0+oO09aUx05+DaJLkFaASAZkYUlkn+mTQIYdzIAec6wqY/joNFT8iZSIAc/CVsLIGCGkHAKk8KkJ6vxF9FlQMHqGvdcev870/7Pi4zH2qjqNmM0B2cRlEhdkUASy72WkEzqo1l/05cY9SV4cocOlvUheF1OjxTR4bQ+6rxhhjV6f720d2sJhlYJmeEkzLPPHHxBw99/N5JWVqamALNHLKnc5lV9g7+EhW2BWffBx/5E8EMQGqJJ6HNFQrpRuGFp+RX/FW4gcPrnyB9fzctoUBXCGo8PQhMtIrLm0iLAtYwjbEBEoX31030/etjqiKR8SuAQcdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qytQItuCg2oYKK9s/wt/2mO+GESF4xguSZk1EZ0u0XQ=;
 b=nChgbj3WmUQOoFPPuchWxOZZwjUNoQH0qduE0KNvN7MahKSltd+iJ24QQd1IRiOVwUmqCh2LnmTT0jLMg3eIXCbzeY9OkCyEHZkvHFWGnAAql/JeJGlbdl7kSLQ4p4ya6WyVaGESw9vivYVloIG1ZGMmbPgKo97Oi4DektLsoz67bJGBi/BujcVhBMLPjzcwL07RKTx89nPO0BZmVPFFiqEEbwiSy7pjrfNYDQ9NbkHTEFYRMdgj2HWE6e6mDKjAst7OX3CeT5ySWdavlUL7EL9DQ7MaeNrX0IKf+OBlf98bC8NXZ2h3IEWfhsSNrGauTJU9UifdiwK7mSivNA04xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV2PR11MB6024.namprd11.prod.outlook.com (2603:10b6:408:17a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 17 Jun
 2024 15:53:42 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 15:53:42 +0000
Message-ID: <a37917d2-8ad9-4192-a3f8-9789193d53d6@intel.com>
Date: Mon, 17 Jun 2024 08:53:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/resctrl: Don't try to free nonexistent RMIDs
To: Dave Martin <Dave.Martin@arm.com>
CC: <x86@kernel.org>, <linux-kernel@vger.kernel.org>, James Morse
	<james.morse@arm.com>, Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>, "Shaopeng Tan
 (Fujitsu)" <tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>,
	"Jamie Iles" <quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	Peter Newman <peternewman@google.com>, <dfustini@baylibre.com>,
	<amitsinght@marvell.com>, David Hildenbrand <david@redhat.com>, Rex Nie
	<rex.nie@jaguarmicro.com>
References: <20240614160843.11006-1-Dave.Martin@arm.com>
 <1e3bba2e-5cf6-4a77-b92d-5c7ab1661d17@intel.com>
 <ZnAkOhFWzDqhlSyt@e133380.arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <ZnAkOhFWzDqhlSyt@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:303:2b::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV2PR11MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: dc919eb0-3b01-4bc0-503d-08dc8ee5a9a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|7416011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zk9hUEVmT01EYTVTa3BpT2ZFSFMvT0d5U3NLbnNNVzh5akFRYU4ra09PbnlW?=
 =?utf-8?B?dkhnMStqb3U4cVNKRlJ0cmJic3lZazByRWlqQlVBb2Q2c3kzRU16dUE3aDRk?=
 =?utf-8?B?R2JWeUlqdzFZVVpOZlVEQ0JZaXgzVm01ZEhneXdzajh1ZHJlODltaWpUOGNh?=
 =?utf-8?B?ZXNaaS9TZ2x0eUZPeTlBK0pIdURJb3NsSkFXL3psNEI0c3g4T29VcDFBZ1hM?=
 =?utf-8?B?NWg0dHlBK09mVEhSdEtZWnh0dDF1alg5aGtqZjJ2QTl6WEswWE5VQ28rRDdH?=
 =?utf-8?B?ZFlQSGxsV1dQU3JWMzBpNXRCb1lIY1dqcWgrNTM1U1BGbFBpMUhZS0ZRckds?=
 =?utf-8?B?YlY4OXJRMmp3YkdHQ2FnSlVEdUY4TkpYeDF0L0tRS2dmK29nWStXZ1Y2d1NX?=
 =?utf-8?B?WGphendzM1JKb2VyeUthclVpSDNONUdydkFDbzdqWVEwV0k5cEdyaHpRRVVV?=
 =?utf-8?B?K1ZkODZnTmdTdTFUQXplem50eWpNVENLWUJYcGlHamE4Tm96c3ZrVUdwMXpi?=
 =?utf-8?B?eWl0MjMxcHM2Y0J1byttMWpNTEJ6a0w0ckJJOS8rVy9FZmNZMjVuY3Y2aEtj?=
 =?utf-8?B?WEptd1ZsMUZvL0pvY200VDVLb3NlZUN0YXp5MzM0QkFWaHozVE9XclJJV0Vi?=
 =?utf-8?B?YU9QcDVaRk1yMUs0MitSaURDcWEweERUVGFFSUh6UkEwMVRIa1ptb3IvcWox?=
 =?utf-8?B?N21ld3BCSFMvVXF4c3BIYnNhbEZLeUZWN0lsWmd4L2xrVlhWenZldXFmNEtp?=
 =?utf-8?B?VHBoaDNJeTkveHVBRTlTQ1lvZVhCMXdwUXd2OWIzNnRvT2lFbEhHbTFvWEF5?=
 =?utf-8?B?RkZjenp4WTVXZDdJblNxWTk3N3VjMEZoK24vQkNSQyt5WVVWK0UzUmNnWUdl?=
 =?utf-8?B?KzVQNEVORHF4M2JMVVVuVVRSTVVEZ3FRblNraFp4Yzd0ZUVwTUorY25WYnlY?=
 =?utf-8?B?c1B4YmFubGRpQ29CT3h4RXF6MG1FcEdQMlZvVXlLL2RsQXFtcGFjZHQ3QWV1?=
 =?utf-8?B?R0cxd3hRMVBWYzd6bEx2MVRnU1NDaWFyQm11ZWZmZDFZMkw4WFlOUFB2cVB6?=
 =?utf-8?B?TndobVUybWdtcm9Kb1ZzYUFDRjQzSEZwVjNzUXA2d2phbDhSUG0xNnhYTEgw?=
 =?utf-8?B?WldHZVhuSHZnV3UvMjFBTXFTY3ZLQUZYSXZuTXp1VWNteFN0NXo0ZjZNQ0J4?=
 =?utf-8?B?aXY0czNrY0hOWU9uL0Q3K3BVRS9vR2VOOXZzZE5wb0JwMkkvL0MvMGdvT1dG?=
 =?utf-8?B?YVV1WElYc3I3Rm5KbXJWSGlNSFpGSkIvcjh5dHVpTklaa0JTc255VG84M2Y4?=
 =?utf-8?B?RTdyaDlGMjVwODZTR1Z5S2hmZVoyNDFiNW1RaHp0TWhpUHVSYU8vdWJ1bEhN?=
 =?utf-8?B?eVZqNWl3Rks3cTR2cHVWVTBEWTRkdm1walZQcnFpbXB4ajBadVJCc04vZUtz?=
 =?utf-8?B?UUxBcE0vTFNLWXR4NEVKdVdkdlIrTzI1YjFjemtJVlFkclkwZzNrMWMwYzVZ?=
 =?utf-8?B?SUZXYTBLN053WkJVNCsxUnMvcndoTnFIY0Q2WTRPaHpwMzRKY1lpL05TQ3lh?=
 =?utf-8?B?dlFYZkRJVDZ1c0s4cWY4ODZlQml4RXZVZndvcUE4aG0zaFRjeStoZkh0alZo?=
 =?utf-8?B?RFlqaWpaS3N0a1F3V0x5bG1NcCtGMVpabUFqWHFWeEZNejVrMHpyMU15Tjdp?=
 =?utf-8?B?VmpmNXpkS1ExZDZDOU1MNitiaUkrUW9OeGU2UDFycVFhK2p1eGIyUzRhSnRW?=
 =?utf-8?Q?Q0eSDvsHFn2Swbtg58=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(7416011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXhGdEtrd0kyTmZybTdidHBrQTZCaERlMGtTQ3FuMXQ5SWtTNWttajMzcFhi?=
 =?utf-8?B?L0lhTkJBeVVuNTBFNnlxTG9PeTh4dWt1NDR3c1NyZFFJY2dWRXRBZTFZV2c3?=
 =?utf-8?B?MWZmZkcxVjZva2RFUGdvSlpUZlh3bGhHbkJyNzBBZFEvWlB5UHp6UUtNeEt2?=
 =?utf-8?B?bytqUDQvSXZjZzY1eGtQajZ5cWp0TVJZaHg5dlU2emg0NW9tYm1ielFEalVa?=
 =?utf-8?B?blZlK2duaFVUWkh5Q1R5WGhENk9iRzg2UzRjampjWDI2SGtMRzVYK1ZuRXZ2?=
 =?utf-8?B?YUpTU3FnTmI5Y0lwK1lPZnk3VGVjcHpGUExQMG5ORTNvSW5PY1hZSjc5SWhm?=
 =?utf-8?B?UkhreGNGa2lqMDlvVS94ZE5jV25lTDM4R3daQ1lvSGxST0l6MHFvOFVZdzlN?=
 =?utf-8?B?bVFBNFRyTGlHbnp5ZFpLZzVvREM4N05PaDNLK3VzRUl0dWZvS2ZQb0cxeERS?=
 =?utf-8?B?bUFJcXV4dFlYdlZrQmNlWW1LOGhqWGFXZ25Cb2Y0dnQ5cEl1d3VvUUpLbWp6?=
 =?utf-8?B?RmdSTXNYcEY2ZThDazA2NDhpdThIazhvY3lNVlBkSEhNa2Mrc1RhamdsdEky?=
 =?utf-8?B?TVV6OW00cWJsUkQrMFhuNEtJY0YvVHlXQ0xjeWg2UUxXNVRnV1R2b3RQS2Q4?=
 =?utf-8?B?enQ2NWRlMzIxa04rOENubWhyK0c2N0cvd3c0M2tlWUJMVlNHcEJqTkNHT01v?=
 =?utf-8?B?MnloOHo3Ym1sUW14bDRKVXNxakY1c3JFa2FIb3hyYlNjbnorcHVmdG84NTRw?=
 =?utf-8?B?WUhFdVphaE52TlVPbEhNM0tpZnVNRjd1MG1vcGkwYUJoejV0TmpjVjBaSGQw?=
 =?utf-8?B?Z2k5US9WRHJhTUV1TnV2bExENzRzVkVBNnpRd1RUNWhJckZuZmVITFpUb01N?=
 =?utf-8?B?V212U1NFQzduaTF5Qjk4NTBoMEtneDkraXNUczI2UWVaVXRoclArZ3cxdVVn?=
 =?utf-8?B?QUhWWjROOTZrY2xDMkRTZWhZZDZPbDNzZnEweWxjUnhtcy9HL0NuYXd2bnFP?=
 =?utf-8?B?ZVR2RDlBK0ZrV085KzBsck11L1NURURISGw4aytkc1p6aDQvUGoxNE5KWSt5?=
 =?utf-8?B?MHBsUFV6YkdtRmlDNGNoK3BydUxRMm56RXQ4Y1JhZVBHeVBEbG9tMW4xaCsv?=
 =?utf-8?B?U3NUNWhWSjdZNExRUC83VU5DclVtaVRSd2xmUVpqZFE0ZkVJclBSbFRrZ3Nk?=
 =?utf-8?B?NnlieE11UmdLMW9kU28rdmo4NEJCVjRIcjROMUg0b1NDZE1DSnB3d2JBWHMv?=
 =?utf-8?B?MjJQWFp5U2IxeDFMd2YwTTJmN0NCVVBGMG5PQml0c1M2cm5HWnVwQ21RWURI?=
 =?utf-8?B?RDFXTTFhNXM1bHh1b0NPT3p0dGYxOWFVUnBOQWpaNHhYUkY0WFJXbnRHbUpy?=
 =?utf-8?B?MTJYTzV3SUU5TnEzL2lEenNoaHMzWUdESld1OEp1WGlKK2VVbURSYkV3NzJl?=
 =?utf-8?B?N1U4bndwNjhCWVBwdU9JK0dRVU84MG1vVFFRdU9IMCtTZHoyN0ZZWDZrNGV2?=
 =?utf-8?B?cFUyYkR0SjNFRXNCZnQ1NkJWQXV4emVpNDlBb2JXSU9MYXU0aWdMWXFXTDRI?=
 =?utf-8?B?SXFDODJ3NDd4VDFsQ1JRTDdYTnQ1SCtWOTBRZmx2TmFNb0VrTmZEUmhKNHBS?=
 =?utf-8?B?VE5QanZOUVBxOXBPcWVSdlZkK1JUejJ5UE9wYnRnTW9kUzNicSsrd1Q1b3lK?=
 =?utf-8?B?ZHFLVUlhS1FRVk9jSm4yNTJya1IzREJFRHhYSk80eTY5Z1BjcnAwMktJTmhY?=
 =?utf-8?B?bXJ0UXRiK3Q2Y1dPalppYzEzbnY5U2RYSnREMzRqZW9veDVCVFY1VmRxTWhD?=
 =?utf-8?B?WGhrZlYrSHRKc1dCZEJ1OUFIc2QrYTQvMXNUWXhYa2E0S1VId3pSL2l4RUE0?=
 =?utf-8?B?Wi9wYUovZjdJdjVCN01QQWhibUlPVGNUdXBiZ29QME45eHRkZ29scUttb3pN?=
 =?utf-8?B?ZTU2Qkl0WEtla3VDeU1LVXZ3UEg0c2dsNk84VVF4dDhXcVIvWmVZNUxFSUNT?=
 =?utf-8?B?Ylh3cHpUaTF2dmhHaThQTzdaZzV4cEt5VXYyR1F5Yi9ISDh6c004UzFKQ3ZG?=
 =?utf-8?B?MWEwYmJNNkNaVTV2ODBPeXFvYlBXdkN2YVhTYytrTktlL2tEL0RLczdCZGI2?=
 =?utf-8?B?M2V0alRkS2UxUHkzUlk3UmlMVkNlUHZrZzhNQUVxUWQ1RC9YemN0Q3BkbjFD?=
 =?utf-8?B?T1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dc919eb0-3b01-4bc0-503d-08dc8ee5a9a7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 15:53:42.6219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 27oOHWSqV9a7ElxSAhzqHsMk5zvEosKTiCpYkuZfbaEfcD0hWMZChbh8tPLg/xHkysqX+DSghsG4h26tHyLqJPjk/Pd5AXWk/RMowIxEFrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6024
X-OriginatorOrg: intel.com

Hi Dave,

On 6/17/24 4:55 AM, Dave Martin wrote:
> Hi Reinette,
> 
> On Fri, Jun 14, 2024 at 03:47:58PM -0700, Reinette Chatre wrote:
>> Hi Dave,
>>
>> On 6/14/24 9:08 AM, Dave Martin wrote:
>>> Commit 6791e0ea3071 ("x86/resctrl: Access per-rmid structures by
>>> index") adds logic to map individual monitoring groups into a
>>> global index space used for tracking allocated RMIDs.
>>>
>>> That patch keept the logic to ignore requests to free the default
>>
>> keept -> kept
>>
>> nitpick: I actually do not know if "that patch" gets same hate as
>> "this patch" so to avoid any potential feedback about this I'd like
>> to suggest that this is rewritten without this term. Perhaps
>> something like: "Requests to free the default RMID in free_rmid()
>> are ignored, and this works fine on x86."
>>
>>> RMID in free_rmid(), and this works fine on x86.
>>>
> 
> How about recasting the first paragraph into the past tense (since it
> relates a past commit), and rewording as "Requests to free the default
> RMID continued to be ignored in free_rmid(), and this works fine on
> x86."

Please keep it in the present tense. I do not see this as relating to
a "past commit" but instead it is an existing commit responsible for
current behavior. Documentation/process/maintainer-tip.rst contains
some example changelogs created by x86 maintainers that captures their
requirements. The beginning "context" portion is always in present
tense.

> 
> (I agree that "this patch" would have been ambiguous.  "That patch" was
> an attempt to be clearer, but felt a bit clumsy.  Naming the commit
> again felt worse, though would have been clearer.  I've noticed that
> people who do not have English as their first language tend to use
> "this" and "that" a little differently from native English speakers, so
> there is probably more scope for confusion here that I like to
> assume...)
> 
>>> With arm64 MPAM, there is a latent bug here: on platforms with no
>>> monitors exposed through resctrl, each control group still gets a
>>> different monitoring group ID as seen by the hardware, since the
>>> CLOSID always forms part of the monitoring group ID.  This means
>>> that when removing a control group, the code may try to free this
>>> group's default monitoring group RMID for real.  If there are no
>>> monitors however, the RMID tracking table rmid_ptrs[] would be a
>>> waste of memory and is never allocated, leading to a splat when a
>>> free_rmid() tries to dereference the table.
>>>
>>> One option would be to treat RMID 0 as special for every CLOSID,
>>> but this would be ugly since we still want to do bookkeeping for
>>> these monitoring group IDs when there are monitors present in the
>>> hardware.
>>>
>>> Instead, add a gating check of resctrl_arch_mon_capable() in
>>> free_rmid(), and just do nothing if the hardware doesn't have
>>> monitors.
>>>
>>> This fix mirrors the gating checks already present in
>>> mkdir_rdt_prepare_rmid_alloc() and elsewhere.
>>>
>>> No functional change on x86.
>>>
>>> Fixes: 6791e0ea3071 ("x86/resctrl: Access per-rmid structures by index")
>>> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
>>>
>>> ---
>>>
>>> Based on v6.10-rc3.
>>>
>>> Tested on x86 (But so far for the monitors-present case.
>>
>> Tested by booting with "rdt=!cmt,!mbmtotal,!mbmlocal".
> 
> Thanks (I take it that's your test, not a request to be more specific
> about mine?)

Yes, I did test it with those parameters. You are also welcome to
add:
Tested-by: Reinette Chatre <reinette.chatre@intel.com>

> 
> As it happens I tested with rdt=cmt,mbmtotal,mbmlocal,l3cat,l3cdp
> (though I made no effort to exercise these features other than running
> the selftests).  I can note this in the commit if you prefer.

hmmm ... those parameters should not be necessary unless the system
has those features forced off by default because of errata. Doing
functional testing on these systems via such enabling is fine
though.

Reinette

