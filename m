Return-Path: <linux-kernel+bounces-331844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE3697B1EB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56C4C282548
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B58F1A3A9D;
	Tue, 17 Sep 2024 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bvx+z+oo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70DA1A38F5
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726585886; cv=fail; b=hNd/HXGLNX60zqUj6ayEM3Je8FS5tP7syUOWEIufjiHbgKrQVs+OBoKAB6wd0/oGmCjLhvCyq1K1ilEC7mf+8oKH/lb96xjf7VyjsOueLQPrpm7qCPHvD5GfsPT1f/bB6ebgSM8HmqbQfWmmxzRbLg23MAvfdjWl0XC1xJe92Xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726585886; c=relaxed/simple;
	bh=kH2UTCin780JCBIMjejFuon89pz9VXAK2se5FEAYhHw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SzGntVAUpzxONXpufWpMzj0Z9aB2bk5ELl6SvfDX2WseXsqA1SM413p932upoAQwP3JMpnXX2benrBUJu0ooVnBUxfq6tHzJxkzehbx577olEEY35MHTOGrk7IFDWdsQUAGHAHtgRAVjayygyW818s4ALO7kkeSREh1Pp2Hr4ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bvx+z+oo; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726585884; x=1758121884;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kH2UTCin780JCBIMjejFuon89pz9VXAK2se5FEAYhHw=;
  b=Bvx+z+ooOp0dhyQiZ/4uMEZmvXK5mxd2w91x/Ht8FXsv7vsXXoqHb/o2
   qeUO6Z2T0SFrMVpmACXmyIfnwoAk1/5+bOsUHICRyLz+JaNiXdRdEoYlS
   MpNDU6ALZ+siIh5Nje7dqJvT743S3imEqoEyNUU/zaFJMZzpWRKYAIZmH
   LgkJz73TiNtEzpTYRpzGAX8aNkgqYn6m4OV1D2k1LsFYj0A1MNsbMdQuo
   J0OC8f5lDTdK+rXAvl5NwE4OsUJmT2fRjGwuyOnI/nWQPITDCCzDrWU0o
   9FrWj+yEXP665ytJkuATdKPVv7ZMA2dO6SULRI6h9mABXV5Wbhk25OkkB
   Q==;
X-CSE-ConnectionGUID: 6++5wYLUTmaGxtBg/s2/vg==
X-CSE-MsgGUID: j9c9QOpQR8SvqcX/7xjt2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="25547915"
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="25547915"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 08:08:55 -0700
X-CSE-ConnectionGUID: 7JBy1o+JQGCfc8Dtc/Zn+w==
X-CSE-MsgGUID: 8JyO7eQOR82I7t/gxhKB3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="69190257"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Sep 2024 08:08:55 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 17 Sep 2024 08:08:55 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 17 Sep 2024 08:08:55 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 17 Sep 2024 08:08:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DB0PTNHwUaqgX3C6NlsKIevVfH9Jb31yb2IJeCTQt+LCeZlX2ZZe82SoKOJJKEo9rEV4e/rZzdVPurSkfMJiVcKH/r/MB06Nq+HFJsNTuFPoMY6AUx99ZKycr4wkCDteghHOD2szUggS+X+gH77+sPztjjGh7fJ9lXjXipqO22XE/i/bjmd480GQvxKEQVKaTC1B/Lg3Z46U02Ei67oGwLmRvuLlyCJI22YHeePOZZC/Z5B/T6kCYbYaXBdQppFq81uSOHFmqnFNuUkQkBFaMOOcHq0pelAWTS7gc6StxJ3kIeG+kf/Ghr5Mv663PLC/vXkJnBw6zKNH0rbIc7sh8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Ucpv/44yNwNiQYIqVFxE83sOXuf235pQ2QY+WzHfRQ=;
 b=yu+IdrUi0nGPFP5IxR8aTu1hQ51MKn/AZpHfnVwbs6kMgk4hLdcxj/J3q4Bevuwwo/CPNdmTj7PHMMZsbufpUx8d7E/CQlLttPIx/eJKXtQJhJPwWQx419RK7TNhbeeTvQA1ykZ+mhZR0/u2QOs6PZJ+XUPn3BapNBuRtJxnmIp36xCP+T+cAZ1sX2evrRQa6C+iobdRHWWFmCmNw6e+0snwlhzE7CHhGWxodDdVN6WerzUpwSd/xYigGR8hfy0QueX1vWpZstfprw/riDI5ZyYzrMhz1odDCOiE2AmqjndsPLrc2WMZTgZ7pxZTT9pBo6ZEkxg/1ZYrBU1uKqAEhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7383.namprd11.prod.outlook.com (2603:10b6:8:133::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 15:08:52 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7982.012; Tue, 17 Sep 2024
 15:08:52 +0000
Message-ID: <7467f313-761a-42ed-ae2d-cdadfd93db90@intel.com>
Date: Tue, 17 Sep 2024 08:08:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/resctrl: Avoid overflow in MB settings in
 bw_validate()
To: Martin Kletzander <nert.pinx@gmail.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <1723949d8053aa74da907165dbdc26755f341736.1726492059.git.nert.pinx@gmail.com>
 <abffe9bc-4c2b-4d44-b521-f138179033e3@intel.com>
 <Zuk5_3qzSfld5dvD@wheatley.k8r.cz>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <Zuk5_3qzSfld5dvD@wheatley.k8r.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::31) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7383:EE_
X-MS-Office365-Filtering-Correlation-Id: 858f8c0d-baec-49ab-f096-08dcd72aa428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXRRZ0hmTWRHS1pWWlFSN0F5ajVvMnB5NDhhTnpicjlqcFNTYWZQTEk0NVNp?=
 =?utf-8?B?WSs0UWtWQk0wWm53amRRQTgrZHpqVmMyaFdIQTJzdStZMFd0OUJYYTRJREJz?=
 =?utf-8?B?NGFHdjdld00xelZSUWZpeTFUOTFSa0Z0NllnKzMwSk4rMnNXL0tuZTRveWVZ?=
 =?utf-8?B?dlQwajBySzZLRlE3SjdUZktzSE40QUpLaWg4Q1pXbjU2b3BVYXpiUkl1cysx?=
 =?utf-8?B?K2lCNlQ1R2VSSy9uYmtFKzQyK0dLOHpDV0VHbnJDR3VQQXV0TTNkOXJMUHZ6?=
 =?utf-8?B?aTI1N3dqUjdhV0tUNTkwNEV3NUNYandldUtmOU41N01hcDZlakhTQ25xV3lI?=
 =?utf-8?B?cjlpTXMwVTZTcXYzOElNakdmd1N0NFhCU01qNGpYbkc5TXNCR3ZJSVpxRjJq?=
 =?utf-8?B?MG5kUjBoamlVVE5EdVF4dzhHMWpmOGZlUG9uY1pxRjRMR0ZzekhlOTRhd1l5?=
 =?utf-8?B?MkZIUDRLVUhWRElZbUQ4Yi9vblBqTTlpRnNWOXRBMXdQRXdyMFRoTzNxdmd4?=
 =?utf-8?B?Ky9jcTlUdlpBREw2cklSYjVKclFOeHJTRlYxeCtUOUlkRHRaTkljV25nR0o0?=
 =?utf-8?B?OExIV0gvS29VbUs1ajZoVGl1bVVlK2hhcmtLODNRa0dpTW9iSGxYMWI3TGR2?=
 =?utf-8?B?TlZYcmdhdVcxYk11L1A3TTBSVDRhUUNXRkVpcmoweHArK2hkWDhaYkZnOHp5?=
 =?utf-8?B?WUgreEhKbHQyNjkxUVRqZ1FicUoyeFl5MjJWWEpuZGRYc2VXWVJ1THVTdDhs?=
 =?utf-8?B?QUdzcmVGa3FDTlh0QnFjUkFIR2NXclJKeUZRUFpCY1lyNHA0MVcwVFBiWkVo?=
 =?utf-8?B?ck14c3lBRVFLOGFHY3pTaHA3NlZyNzRnMGorUjRXR0RSVFp0QTVOTVQwN0Fo?=
 =?utf-8?B?Ry9vaDNhSTEydkZLbWpSaUFkeTdvU2lzQmExckQzV2dRVmdrT1lIbW9DOGhn?=
 =?utf-8?B?Nm9kR2ZSdXlNa0h1bVdYUDVmVEpmaWN1YmtUd1EwU1Vjb2ZhM25HeEgyakYy?=
 =?utf-8?B?S0wwL09CdEF2YXkzTisyNjZHeFBaWVgvVkxJZUZIU2hKNGh0S3hvSmJqRFRD?=
 =?utf-8?B?MjhHaUkyL256VzdoTmxZREpyY0VoNUo0Yis5ZFpiWjJLRWpSNWZVTXAya1BS?=
 =?utf-8?B?dHh5Q2k1VWZodlo2UjBNd3UvT3hKUWVZazd6OGFVVERZUG8rOG94U2FoZGpL?=
 =?utf-8?B?cXU3OVMyS2R5cW00cVVPR1ZOR09yKzQxcUo1OUpoVmVoclNzM1NiV0hsZGo0?=
 =?utf-8?B?bFkxYzcwQ2FFMWNKTkdxeGV0dkhPOEJMUlAyMWp6TU9Hb3BJL1pUR2RRS0NX?=
 =?utf-8?B?ekRCL2J0a29ubVF4bzVjNFNUK0FkOHJ3Z01YdldCV0lVdmZLam9peGZqV0Zp?=
 =?utf-8?B?RmRGYTd0a01CWFRWVUhDcDVKd1k4Y3hBUFg5Ui8yMndBNUFrMkN2eXBTaVU3?=
 =?utf-8?B?Q043ZVBPRHhoT1JGK01VdDlwZTB2bWlMOWV0OUl6eW1GT0g2ZmRGbjRuaXBQ?=
 =?utf-8?B?ekZlY2tSdGVhdmlIcDV2Z1pHcTR4VE5yMGc1WW5rUkU2M3VtUVdLaDVOOEkz?=
 =?utf-8?B?MmZhMjk3MDhnSStHaWRaejl4NTZVbDlDZjlwbjZVb0pXdE16MCtHUXNGb0dl?=
 =?utf-8?B?VExSaDV3ZDFzMEZTT2pyQTd2Rm8zUDI2RTVGVTlpcDdaQ0dRYXh5RVFGMUpX?=
 =?utf-8?B?SkVvU1VsQngyR3V0NSsvRVBWU09YSW9yUm5iVHprT2dObWJQTERvUkZDcENF?=
 =?utf-8?B?M3FpWEkzZEdZMEl6QnVJZ1MvdkFSMUtqYll3Q1BKTkNkTUhDTWNGY3dlZC8w?=
 =?utf-8?B?WStLaDFESzB1THA3engzQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHNkbVNyWkw0SWQwNEdJY1gxS2MxdlBqdDJ3UlNFRDllLzRYWTdjRmNhbmh6?=
 =?utf-8?B?c1VkR2hpbDM1aXdIU0N1MC9YTDA2bGY0eXRMNTVOcXFFbWR1RFoyUkxxVC80?=
 =?utf-8?B?Ujdpc3gvS2JOa2x6K2k3cWo2MlhTQXUvbmtyc1hUT2M0clVRTVBKZGNqb0Fs?=
 =?utf-8?B?Yk5JcUxHeHFFT1NleDVORzgxY01pOGJiQUFKZFo5UmZWdlJhYU1YNzV2aTZM?=
 =?utf-8?B?d0Z0cWwvN2Z2b3VrSTZjR2ZXYXE3M29sakZtQVV4aUx6MURzN01MRVlwbzB3?=
 =?utf-8?B?NkhWbVdVc2Q0TTBoVnJ5YWxGWE42UkUzVUQ0K3dxRG51YnlZTXZPbjA2Z0x6?=
 =?utf-8?B?Nm4xTHpUWjJNNktyU2M2MDdQWWxXdFBDajZVblg5R1hxMVNublA2Rjd5UUh6?=
 =?utf-8?B?Y21aTlRhRXo5SmNUaTl6aDh6MVZZQW1SZk9ka3JETklEZFI1a2NlV1N6NUsx?=
 =?utf-8?B?K2QrM1FVOEp5MzJwNlBaeFo3NlQ5TGErUGxsNUxZMkt3dnlFM3JsVFhza3d4?=
 =?utf-8?B?NXErd2JlT1ZhRjRMT1A1ck9Ha2lUUE0xRk40R0ZyS3kxRHlpNVlXVU1KTzhu?=
 =?utf-8?B?dk5XRVpkclNJeVhiOG9MWWRWQmllOWZsYWs0U0ovZS9JWEFwZ0ZLSGRNVVhr?=
 =?utf-8?B?V0ZOdWNnUnduOWprR3pTUmRjYVRWK2NZbUgvakdTenpwb01Ja0s5QXFBT3pW?=
 =?utf-8?B?aDcwMTJKaXVqYmhKMGZxbDhDRW4rNE0zVGkwYmRMZEtCQ0tEMUlvRFA2TExL?=
 =?utf-8?B?SnFXczZXS0xwVTVwY2hEbFIvNStXSG5abTJTbDVaaXdVVWtGcjNyaTlzbnNH?=
 =?utf-8?B?Tk5DL0RyaVVCMlhJdWhKWkJnYnFKYzkzaDlkT3J4bFc3WFFma0o0NHM4Z2JT?=
 =?utf-8?B?aFdWcXBsNGNZUXkwc2FSblpodjQ0ZXVPRzg1d0FVUnRsOTVhbkRMY3JmVDRN?=
 =?utf-8?B?enphdlBSOGxjeDJjOW9RRmdtNHFsVTNXbkZOR3g3OFpSdFE0NjUvNU1vUEoz?=
 =?utf-8?B?a3ZPd1BCUjBNQUR3MjJ6N1dNVEFad0ZJaEZSZmRwT1NvaTdJTE9DZ3gvbjBn?=
 =?utf-8?B?MGxQM1N5SnRTTEplay9qYkNnVldrZU9DNW1EWXdzSUNFQjhJTmlLV1N3L2dZ?=
 =?utf-8?B?S0kxWkx2THVEUS9qOHRwOHpsTlFMbi9TekdSbXZWV2crdTVhajN2VFpuQ3g3?=
 =?utf-8?B?b0ZzV21IM3lINEF1TTZ1UGtGZFZnUU1mbFJHY3d5WjVDQWlMNDBYM0tFYnJI?=
 =?utf-8?B?YzltOWJ4VExNcnRqcmVUU3crdzlwRWorMDkyOE5reE83b0NSY3F3ZXg3TkZR?=
 =?utf-8?B?MzdSdG9pcHRDQ1IyRVN1Z1IrcVY2aEUyMTFyOEFFRStabHJIcW56Sy83RUho?=
 =?utf-8?B?VmpidHhyL2lYQlZwOFoxeThGT0pCNmpUbXBDdVR3MFo5czY0ZUNjdVhJbnN1?=
 =?utf-8?B?VTlJcmN3TnlwNkV2WHFuOE1ldnhZaWNiS0dwanFhWS9WSXgvZkFuVHNreWFO?=
 =?utf-8?B?VTBDcEc3MGdDVE8xRWo1cTJsSDltcUhxSUg0WnJ0Rm9GTlJyR2dmTDV1anFL?=
 =?utf-8?B?c3FFOW1laVJnUXdnSWYwSGNFZHByZUJxSmJ0ek5lNzdIb2JUWlBjcWt0MVd0?=
 =?utf-8?B?ZU9MRVkzRFJ4ZmJ6elI1MWxjaE1tWkFwTVpXRHdqQTFhWTZZSERVRmlIeWpT?=
 =?utf-8?B?VUZqRmRDMmRvMHpRUERUZ2JyaEpHN1hwS3JQaDAxQzMyUmY4TTlNMk9STGhZ?=
 =?utf-8?B?QlpDNXlPRTdYUXA0ellWY2duRUdHZDJxWXRKd2pSQVFGdmhBSzc3RFVFbXpM?=
 =?utf-8?B?RmVxRjRvc2VZTitRdFFLMXczZFFpYlpFeEk3QW5wa2h1YVNaZGdGbTdKU1RU?=
 =?utf-8?B?MitsRnJaUkE5NFpMcUJlVnlCamlXc3BTNEVmVEVINmFCZVNPektSTFFGVy9Z?=
 =?utf-8?B?RngzVG5McDBQRnBNazhVaFF4bk1GWDB1YnIzV0F0Z3I4VTB2L0Q4M0MwaWxO?=
 =?utf-8?B?VTRabWtsR1NyWjIvME9rSUREZDhPZ25KN1IvWG5IcitiSFRucC9rWHYvUlBO?=
 =?utf-8?B?L29BcGxYUGxETXNrekZCenE5QWltV01lYkFtYm5kaWU0NjJYWGZPZDNEK1gz?=
 =?utf-8?B?ZTZ3SURUM24wRVBWMWRjRTdxMWR4c2d2eFd6QXhYNkVkN3VLdFpxTGNXRFRw?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 858f8c0d-baec-49ab-f096-08dcd72aa428
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 15:08:52.4448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/z3bB7ljvB8IPP0Cz5lmlbBZ7fu2YFJGx6W7d+KhIYqTDXFjMFua2K3SlA7DKer1JBgvtHqrhNRHRdgGulz4c5Y3DP31U9z0CEJWlxVf2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7383
X-OriginatorOrg: intel.com

Hi Martin,

On 9/17/24 1:12 AM, Martin Kletzander wrote:
> On Mon, Sep 16, 2024 at 09:56:01AM -0700, Reinette Chatre wrote:
>> On 9/16/24 6:07 AM, Martin Kletzander wrote:
>>> When resctrl is mounted with the "mba_MBps" option the default (maximum)
>>> bandwidth is the maximum unsigned value for the type.  However when
>>> using the same value that already exists in the schemata file it is then
>>> rounded up to the bandwidth granularity and overflows to a small number
>>> instead, making it difficult to reset memory bandwidth allocation value
>>> back to its default.
>>>
>>> Since the granularity and minimum bandwidth are not used when the
>>> software controller is used (resctrl is mounted with the "mba_MBps"),
>>> skip the rounding up as well and return early from bw_validate().
>>
>> Thank you very much for finding the issue and proposing a fix.
>>
>>>
>>> Signed-off-by: Martin Kletzander <nert.pinx@gmail.com>
>>> ---
>>> Changes in v2:
>>>   - actually save the value in the output parameter @data
>>>
>>>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 9 +++++++--
>>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>> index 50fa1fe9a073..702b1a372e9c 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>> @@ -48,8 +48,13 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
>>>           return false;
>>>       }
>>>
>>> -    if ((bw < r->membw.min_bw || bw > r->default_ctrl) &&
>>> -        !is_mba_sc(r)) {
>>> +    /* Nothing else to do if software controller is enabled */
>>> +    if (is_mba_sc(r)) {
>>> +        *data = bw;
>>> +        return true;
>>
>> While this would fix the scenario tested I do not believe this fully addresses the
>> overflow issue. As I understand the test wrote U32_MAX to the schemata file,
>> which triggered the overflow because of the rounding and is fixed by this patch. Looks like,
>> after this patch, writing "U32_MAX + 1" will still trigger the overflow.
>>
>> The overflow appears to result from some inconsistent type use and not using
>> appropriate parsing API that is able to detect overflow.
>>
>> How about something like below:
>>
> 
> That makes much more sense, I have not considered changing the data type
> as I wanted to keep the changes at minimum, but your solution is even
> better.  Should I leave the fix up to you or do you want me to send a v3?

Could you please try it out to ensure it works for you and then send a v3?

Thank you very much.

Reinette

