Return-Path: <linux-kernel+bounces-290352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A249C95529B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 23:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6A701C21750
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96841C461E;
	Fri, 16 Aug 2024 21:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cTHxtRMt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6404315D;
	Fri, 16 Aug 2024 21:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723844515; cv=fail; b=h/EXNzAvxcNKwgLuwg0oJRzD8v+G2eoONxyiXgRhw7vfpwmgl+kAwmtrY3mLu9HF7ZHisN5qHaAxgOx1a/dGa3ADslImtLHqA+gb9agErNlJUsP0wRbcZiVmScbFs671vxdUJaiPpSGt6TLSz7fml+Q/mDxPEFfQc5cNC8m9es0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723844515; c=relaxed/simple;
	bh=ndE6S6JQcsDMMMVVGUzU14Dt7YV6pUyT+cIJdYh68v0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=de3hTt/X00x2tl2HESkQ9tR4bZk5cXW7cbznZjIa/gEmwI53PLsRi5jjbAG2Q6FNsrG9jOqOgmAiGB4nhROC2xFKBmPQZdKkfPxHtSvn44jtalTAGFq/X0bhM4KlpAwEDgz6WakXamuyIndygBjof0zLH8jWuDMxDucrXxOHqkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cTHxtRMt; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723844514; x=1755380514;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ndE6S6JQcsDMMMVVGUzU14Dt7YV6pUyT+cIJdYh68v0=;
  b=cTHxtRMtXD/QPk7nwzA4/b2Jbek8MtaFsLngYN6JZW+ZCvIQ0yL12yvb
   QzWr/JrpZb/BNb6GFBbSrjVNbREWZKy7ovA30VjtNC7LVtUzwvy10/TxS
   4iw27yGLvG3s7RXnDNTZx/IkkAX+OPgR4WdFNW9oqycrlVpYMZUUVXjyO
   dyixWw4VDzGNRBOnacPuTqBXS9gi0TUK+MUneRa5Sswi0OxakTNoLnar+
   uTF8E1VLTHijKCQx8G4Y2wMfElvcx/Xuzldh5JXA0Y1luSlKnOZP42oyf
   9BwovOPlO3GRdf+nZXWDbjhclxdKqvau7tGCy4ff5shTlpiQ0zUxDy899
   w==;
X-CSE-ConnectionGUID: mi0x58voQ6GOv+bQH77l6w==
X-CSE-MsgGUID: 93KhmS8vSm24ujaRrPhONA==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22325554"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="22325554"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 14:41:53 -0700
X-CSE-ConnectionGUID: Bv0MVAraRti6qu/AfQVnoQ==
X-CSE-MsgGUID: FD1DZ50iRty7oMIcwVY+RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="60066736"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 14:41:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 14:41:52 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 14:41:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 14:41:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ugMb0inJyl1bNBGRVuWUfVF73TvvLm4XtZazDzflqynLLtjTMya8meMAPy5hG97lKMCkZUbf0+FW0GlJdP8b0gc6kR9o8sHLiq4MYkB55jF4xoH4pZWyKOJvJJCzaD3nKj2hJRBxwht+CwzEVXArrBu4PiwatMpsUStVZT70Nc0yVugX5f4xDKVx/6fZpnm0/0IsRlVOusKqARcrqWrQjTH8SmIPpQhFBU3523910J+/z1TE1X/Fugqewi5B9VnoAEOTVHOUnLzBCW39M2tocwZUdFClfXN6w8WYOsN7W0kySgiWE6eubSk2TF1zapItYnmZfwBwHx5aqJ4ZzY+wmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/5UWE8U2Pcpsrg3+TQyGmDTvPf43dGywdxiGMqLTDc=;
 b=pcG/x9XfOXoEYN1GlacgbzUcYiZHpiBz47f6/TgJSYZtmLHvxJe/nNsprpuIY5EW+A+YDxtG7E5rFx9XoY8rwjE9dDM9t1rXjJyXrHI1a+OwYPCLBozebFv9aMAB62uw7U8qswl5+hFCB7Kypt8krPJtyCFBbTEu4CvNVB1OeXQrqJASgfCAYKpqt1kYMWvPHCLNqlZ8wTtdKm92kLfwvfBuLGIAUWCQIcihjeKKd6iAOEaImM1U9oOeIKrsub2T4tq0omGDZ04aVI85w5/7EtqZ3a3e/qFUaCxXQul/kJBkHgr+WIy/DyQRVPEXasFVhG/cT2gf1TfJ9Aw/UcJo9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB4976.namprd11.prod.outlook.com (2603:10b6:a03:2d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 21:41:45 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 21:41:45 +0000
Message-ID: <e2b9bcd1-4b5d-4eb9-8e3c-604a4c5cafe8@intel.com>
Date: Fri, 16 Aug 2024 14:41:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 16/22] x86/resctrl: Add the interface to unassign a MBM
 counter
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
References: <cover.1722981659.git.babu.moger@amd.com>
 <09da6e20b695086558d6cadefbc4830961e6e60b.1722981659.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <09da6e20b695086558d6cadefbc4830961e6e60b.1722981659.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0197.namprd03.prod.outlook.com
 (2603:10b6:303:b8::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB4976:EE_
X-MS-Office365-Filtering-Correlation-Id: 59a6cc97-21df-4909-5f25-08dcbe3c394f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1pTZFVvalVVWW4vS25kY21lWVp4QVZWMFBBaUg4SUxRWCsvalZNMEJKVjBx?=
 =?utf-8?B?VTZBRFpsR0trdVRHdURWWnp5cnc0SGZoU0hPWVJZbFFxMWJrTmdoWEpSdTBy?=
 =?utf-8?B?WkdJVDRSMG5neFVkSlYvbzlFc0N5Tm5Ga2M0OXcrZkUzN1BJY1B2YWs3K05Y?=
 =?utf-8?B?SzJQODdCSXhqM1VFaGJLMW9TZVV3aFFjRmU0R1JQcVptaE5GdXNoazQxTXNq?=
 =?utf-8?B?R1Nxb0JTaXJXdmswTVI3UCtYT21lWFc4aXVDc0lRZURGM1NmZWdaZ3k3NHdL?=
 =?utf-8?B?MzRQTjZUdXU0S1RHYTcva0ZBbzZXWGl0RVJmZ1hudmkycTBVcUlKKyt3V2kw?=
 =?utf-8?B?c2hzQ08zaHFocmZualRGcnEzM2FPKzEzVHBGYytja2VZUGVJbUhFbU94djY4?=
 =?utf-8?B?L1JXMGo1RW1aVURqY004M2FGRzZDdHlzTEI5eStHRzdiMFBydy8rWTg1RDly?=
 =?utf-8?B?SVhKTGFoZzNzSndNMUl2czJwL2EyMElBTmFVNzVxWkVXWk9hR0xEUmhiM2l2?=
 =?utf-8?B?VGoxa3dLS0ZieWRDaEhQREZ2YlFlQk5NVVRMcHdrR0svZlkvdEFKUitrd1pW?=
 =?utf-8?B?cEc5OE9iVVNVWEFDSTFOSGNDT3k1ZllsK1BJV3Z1NzZENXp1ZEhoWTE2b1dh?=
 =?utf-8?B?RUd1dUljd0tPVEFMY0JpNXZvUTh1Z2htd292SERxbnRZWUpmT1ZmNnBHZUJs?=
 =?utf-8?B?SU96R2g2Wm1hUGJOeC9iNDhGNEtMK01JNXk4NnM4Vk80SVpyKzZ6UEJDVzNX?=
 =?utf-8?B?aWdnWlA4L1FnV3d1QmMzVEY2UDZsWWt4SFBkdDdWU0NIalZBTmFSM3JpL0VN?=
 =?utf-8?B?Z2dvZzd3dXhTUVArWEFOUlJrYVdtNGxndFA0YzhOMHo0ZHQ5S3BkT3QrSE16?=
 =?utf-8?B?LzBsNUtDNjVJR29EaURPNEtkelRzWG93blVpMjJXVlRVNUVkcldFenJHWlE2?=
 =?utf-8?B?eXFnRHFHeklWckNNOWJDanFUc2dTVEFXZTNSY01KU2l2SGpub3J2ZWtPOHVi?=
 =?utf-8?B?WGUzem8rWlFOSmpHbnI4NFZaeXBNSVJ4RzVlKzhWVzAwWFN2S1FvSm5UZklI?=
 =?utf-8?B?Y1lRRHJ1YzRoOENKNGtrM2w4bWtsSGowYzAyaEw2bFcwb05YZGFGRG1PQlFJ?=
 =?utf-8?B?Sko1YlRnQjJkdVYvdEwrdVpnWmhFYnU2ZEMxZU5VdzFnWmo3b29aWnM1V1JG?=
 =?utf-8?B?UUdpeWRqK2RUMm5LTGROUkFNdTdKTC9laUVVM1FXdVZBTXRNa0RDRVNmK21Y?=
 =?utf-8?B?UVk3M2VROUVBZ3gwbXVFYjdDMnpWOXRSVlU4VVl6TGYyNVBTWjEyY012STRj?=
 =?utf-8?B?VDRzbkVNaWkwdDBGSzBqclh4TlJLcmRJd1dVZUtsQmV2NTZ3MEV4NERtMGNu?=
 =?utf-8?B?M3FpdW9YWXlmOUY3OGI4TXhKSWdENUZ0SG0yRGpwVjJqdFdGTmthaVR0MEQ1?=
 =?utf-8?B?TDBuR3ZvaTl0TEhsR1V1NDhSckRvZDFOMXZlL2I0UVpQQTdLTW0yUERhc0xN?=
 =?utf-8?B?b3NMZ3NTWHBSTGE0aFR2L0JVeUY4bnZxU3NvNlFDdG11V0RkT0pKQVgwQmZT?=
 =?utf-8?B?V3JUQzNXZGFwVTN5Nmw0WTAraUd1TktrNzNNTHA4QTJkV2NYanA3ZWpuWEN2?=
 =?utf-8?B?QlFzUzdydE96dWJ1K3ZSeGE4S2licjg3c3RjRWxxM0FwdklucFdPcDlnbFdx?=
 =?utf-8?B?dnlZVHZ3UXdOclovbUZxZkEvSXg4NmdqK29QN1k4VmM3NTFQK21RcXBsdGQ3?=
 =?utf-8?B?TWhGS2xCQXBQUzcxZlgvOXJFMkxXTzhTRGIxVXM1bUs1Wno0dEppWUJLYUtF?=
 =?utf-8?Q?cB7kgr8IuiCde3yGRjSQ+2ShJNmJFHaimK0Rg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWdBTFlaeTNDUDkxSHFFeVpSbzFVNXhNSnBBRGZOUEhJMXRoUWNicFh4VGhJ?=
 =?utf-8?B?NGY0SWpJTlBoY1pjUzhOUGYyU0JMRmFROWpUdlV3QWhOSHVqQm9OWGpRMzVN?=
 =?utf-8?B?MGF4ZTljNC9ZNGRpdk5iWVFvaXI1QVlZcUhpSkhPZW4xREVpODBTV0lnemda?=
 =?utf-8?B?aFp2eHArai91TjkxT2dOQjBmZGR6Z3Jtbml6dkpKZ21QV1BHK0d2bC9WaUo5?=
 =?utf-8?B?MnZpMWQ4SGlHSkxNK09KMW05dElLSnJrSFYvSXliV05BRzc3UDIwOEllYUVy?=
 =?utf-8?B?ZlJKSVA3TmErbUV3b2xxSGlxUmsvOTBCdlFCRmJqTEwwVmFtdjdVUmVUTjBM?=
 =?utf-8?B?eFdwZmhOZkxxMzh5SE9VK1BHQnFBN3VyZmpXcEJ0Q0lUTmk1WkdtYS9jeDZG?=
 =?utf-8?B?WFBraU1wZjRtQ2s2dTJqVUF0bllDV1R1TzczYStNNEloVklMMSsyNGk0VEcy?=
 =?utf-8?B?RHU2KzRBMEMrZWtQZElMWUJ6UW5JMjlhVkdETFVqNzM0MWNmbm9Qd0loRFlY?=
 =?utf-8?B?WFNlZHA1VjVrbUV6eE9VQ2tpTUxLWTdHVnIzQXl4TUNhTzdaa2FkUHpyVTFE?=
 =?utf-8?B?QVNJbHhHbmREaFU5WStUZXJzYnBLYUkvaDNkS3ZzNnZmdHVScTdwTkM4K1FY?=
 =?utf-8?B?Z2FDTUlSMXpmVHRadWVIZG1qWUxEbjRyN2xMU3loYkE3SGdrUFRWck9aRTVD?=
 =?utf-8?B?dVJwaEl5ZktXNHhjbDl3Vm1yZklETjZWRWhEVktlV21heFYxWEJWNTV3MHcy?=
 =?utf-8?B?MGVBY0U5NUUxQ3JsWmk5eXRUT3pzdUNCblU1ekZVN01uNVBnTjFubE1LYURn?=
 =?utf-8?B?Z1h6SkpyYU9xVCtIR3A4YUNHTVNyQ0hqR0tVbWx6Zm5KNG81NEpic0FoUzdh?=
 =?utf-8?B?QUxjRi9yM0l6SjRMODZsZFAxekthc2N3QW93eFpha1hpeSswSGYwMkJoZFN0?=
 =?utf-8?B?ekt1Z094QzFGQ1VXTkk4dXFCZUI2RW1ZaGNlV0RFZGVmY21sVGNFajZqQldh?=
 =?utf-8?B?U284UzM2dUo4a1lEZ2hRK1A0ZkF1WHJKOTJwYlQ4Y24zR0VxVjlTVlhWdWtw?=
 =?utf-8?B?Z0Q0K000Wmo3bFlEaXVRaHpmcTJhVUJzckVvbGNVekEzanFPeEtnRVo2Y3Zq?=
 =?utf-8?B?MGZ6ckY0UzBEYnNpcTI2ODdrZVE2cUZBSGhTY1dIYzBpN0EvNHNLUnhHbVNK?=
 =?utf-8?B?VkVUbW03TFM4S1RCS002RFVMN3BKZEpmWCtUUzhMZ0lUNFdYakFsTXcrUXFa?=
 =?utf-8?B?VktDcXN5OWRuV1hWbUdOWktibFgxSVBXV3YvQnUxM2VFL3ZZaHFsWk9VQWsr?=
 =?utf-8?B?Tnd5RGV6Z0VpQjh1RmpaZ25MTEJNNzVyenY1b3VweUlJME1Id0lNeno2VFJQ?=
 =?utf-8?B?dktkS1h0b3ZraDlzazdXeDBvYkNicU9VVFVHR3REWFJkM09QRktVQTk0MkM4?=
 =?utf-8?B?Mk1BcFhrV2YxNkQrYS9CU3BOdHZkZm5MWXg3WWd6OTdxMVZmTmg4Nk5QSURi?=
 =?utf-8?B?cU03Q3NQckJhYytUOVg1NUJPR0xkQklEdXNHb3o0bEJhVjBUNDRqM0FjSVQw?=
 =?utf-8?B?QUtyYis0OStxTWRqdkhqY2Yxck96b0xJODhjU3JiTFdOWGpQakVCTmNxVE1U?=
 =?utf-8?B?NStFWHFrR2hkdkZ6T3NmQjRZY0FqdzJBb29JNWlaR3FiWk1CaXQwMkRXUzFp?=
 =?utf-8?B?OHZmRlphTmN2QUNiTXlzRUQxMHlrbnJXVk54NGFnMkhSb3M1ZFZnbDlyWHI2?=
 =?utf-8?B?RVFoa1p4WmxQYXpEWnNwTzdRZFZaRXM2ZlpLL0NObEpiblY5Y0dMSitUbXlR?=
 =?utf-8?B?a3hYUm1kN2svZ0dwdnUrQVNSQ1hRZXZHMzF0QkFWLytheWNVa2NyL0xmbmQ3?=
 =?utf-8?B?dkF4ZkdoR2gvdDJZTVlVRWlYcUVNSHQ3L0R1elBmam9nMW1VSXI5VU9wSjhx?=
 =?utf-8?B?bWVHbGFvUVdRYUliaEVRYzdkRHYreS9xcjdlMCtRTTBocjQwWkZhV0ZQM01X?=
 =?utf-8?B?Vlk3bThrNzdqbVIwV3JPb0JVdDFqdlZwMi96Nncybm5kOE5saDAwSHlSMVhH?=
 =?utf-8?B?RXN3Z212NnpSZXdremVMVXRjQkpIMFJVaXhxQ2N0YTRrNlM0MXBjcllqV1NW?=
 =?utf-8?B?blFnRWdyOE40eU54VHA4ZzZ2eURVc2VmL0J2ZDFZRmhObjVlUVlTVjZPWXMx?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a6cc97-21df-4909-5f25-08dcbe3c394f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 21:41:44.9765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sot9PwLLTEMeB81AkcNUoPCqSkbflUMNiVMSVuq5shK3iklUhijOqPfwGM84B7VQ5xRXdo6+qIACTjCQUmRe/xV6LXv1OD0KvXuxsmyxcPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4976
X-OriginatorOrg: intel.com

Hi Babu,

On 8/6/24 3:00 PM, Babu Moger wrote:
> The ABMC feature provides an option to the user to assign a hardware

This is about resctrl fs so "The ABMC feature" -> "mbm_cntr_assign mode"
(please check whole series).

> counter to an RMID and monitor the bandwidth as long as it is assigned.
> The assigned RMID will be tracked by the hardware until the user unassigns
> it manually.
> 
> Hardware provides only limited number of counters. If the system runs out
> of assignable counters, kernel will display an error when a new assignment
> is requested. Users need to unassign a already assigned counter to make
> space for new assignment.
> 
> Provide the interface to unassign the counter ids from the group. Free the
> counter if it is not assigned in any of the domains.
> 
> The feature details are documented in the APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>      Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>      Monitoring (ABMC).
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v6: Removed mbm_cntr_free from this patch.
>      Added counter test in all the domains and free if it is not assigned to
>      any domains.
> 
> v5: Few name changes to match cntr_id.
>      Changed the function names to
>      rdtgroup_unassign_cntr
>      More comments on commit log.
> 
> v4: Added domain specific unassign feature.
>      Few name changes.
> 
> v3: Removed the static from the prototype of rdtgroup_unassign_abmc.
>      The function is not called directly from user anymore. These
>      changes are related to global assignment interface.
> 
> v2: No changes.
> ---
>   arch/x86/kernel/cpu/resctrl/internal.h |  2 +
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 52 ++++++++++++++++++++++++++
>   2 files changed, 54 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 4e8109dee174..cc832955b787 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -689,6 +689,8 @@ int resctrl_arch_assign_cntr(struct rdt_mon_domain *d, enum resctrl_event_id evt
>   			     u32 rmid, u32 cntr_id, u32 closid, bool assign);
>   int rdtgroup_assign_cntr(struct rdtgroup *rdtgrp, enum resctrl_event_id evtid);
>   int rdtgroup_alloc_cntr(struct rdtgroup *rdtgrp, int index);
> +int rdtgroup_unassign_cntr(struct rdtgroup *rdtgrp, enum resctrl_event_id evtid);
> +void rdtgroup_free_cntr(struct rdt_resource *r, struct rdtgroup *rdtgrp, int index);
>   void rdt_staged_configs_clear(void);
>   bool closid_allocated(unsigned int closid);
>   int resctrl_find_cleanest_closid(void);
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 1ee91a7293a8..0c2215dbd497 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1961,6 +1961,58 @@ int rdtgroup_assign_cntr(struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
>   	return 0;
>   }
>   
> +static int rdtgroup_mbm_cntr_test(struct rdt_resource *r, u32 cntr_id)

Could "test" be replaced with something more specific about what is tested?
for example, "rdtgroup_mbm_cntr_is_assigned()" or something better? The function
looks like a good candidate for returning a bool.

Is this function needed though? (more below)

> +{
> +	struct rdt_mon_domain *d;
> +
> +	list_for_each_entry(d, &r->mon_domains, hdr.list)
> +		if (test_bit(cntr_id, d->mbm_cntr_map))
> +			return 1;
> +
> +	return 0;
> +}
> +
> +/* Free the counter id after the event is unassigned */
> +void rdtgroup_free_cntr(struct rdt_resource *r, struct rdtgroup *rdtgrp,
> +			int index)
> +{
> +	/* Update the counter bitmap */
> +	if (!rdtgroup_mbm_cntr_test(r, rdtgrp->mon.cntr_id[index])) {
> +		mbm_cntr_free(rdtgrp->mon.cntr_id[index]);
> +		rdtgrp->mon.cntr_id[index] = MON_CNTR_UNSET;
> +	}
> +}
> +
> +/*
> + * Unassign a hardware counter from the group and update all the domains
> + * in the group.
> + */
> +int rdtgroup_unassign_cntr(struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	struct rdt_mon_domain *d;
> +	int index;
> +
> +	index = mon_event_config_index_get(evtid);
> +	if (index == INVALID_CONFIG_INDEX)
> +		return -EINVAL;
> +
> +	if (rdtgrp->mon.cntr_id[index] != MON_CNTR_UNSET) {
> +		list_for_each_entry(d, &r->mon_domains, hdr.list) {
> +			resctrl_arch_assign_cntr(d, evtid, rdtgrp->mon.rmid,
> +						 rdtgrp->mon.cntr_id[index],
> +						 rdtgrp->closid, false);
> +			clear_bit(rdtgrp->mon.cntr_id[index],
> +				  d->mbm_cntr_map);
> +		}
> +
> +		/* Free the counter at group level */
> +		rdtgroup_free_cntr(r, rdtgrp, index);

rdtgroup_free_cntr() is called right after the counter has been unassigned
from all domains. Will rdtgroup_mbm_cntr_test() thus not always return 0?
It seems unnecessary to have rdtgroup_mbm_cntr_test() and considering that,
rdtgroup_free_cntr() can just be open coded here?

> +	}
> +
> +	return 0;
> +}
> +
>   /* rdtgroup information files for one cache resource. */
>   static struct rftype res_common_files[] = {
>   	{

Reinette

