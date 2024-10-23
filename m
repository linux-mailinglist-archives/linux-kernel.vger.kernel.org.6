Return-Path: <linux-kernel+bounces-378903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9BE9AD6F3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D43B11C23863
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF241E2604;
	Wed, 23 Oct 2024 21:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lf7j+UOe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D6922615
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 21:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729720294; cv=fail; b=J3mTmjVEu0GN80swK8Kac2nTcYHuBSEFAMTY53fqFvmofbECrlDTJGZChjjexVgjS3c6RkPFNnoaSjxvdboWmRQ9CHEPPPiYx0EuLINTFOIdvPBQPR1Q3P7NVNZ8KGQr5PxQVEUBjwUM6uYSYi0v4sjDReIJSJXYtObwKs0RmW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729720294; c=relaxed/simple;
	bh=aH2wRKM8kPazbDtfSQPt9n8o+vM+LbcwzS352JLtVa4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SK6gOQdZIIQ68JBeYFiEiGkQIUeJi08omeZmL74KPLyDAM54u9JYK3NdtlqO05AUrAwVeCcxZ8mEBcj5AlIaQffOFMwu5+pR+ONfj/2BgdKAvA4JEZHvGmQ/u95dW+Qxm7Sfc8fBy6u65JOQURM7M3BoUz89p24pfpbUSv8gYhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lf7j+UOe; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729720292; x=1761256292;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aH2wRKM8kPazbDtfSQPt9n8o+vM+LbcwzS352JLtVa4=;
  b=lf7j+UOe/AFG7JyeYZyQF2bBCtY+fm6ssgYYYz0hbHNADzJP2GWAubtT
   raQnoMm/6lB6DFo+XiVytE9GK6RbxDuesrmKW9COk125Tjc9VXjyrZp+8
   asVpmllGcIfLdQPZIXQfmebp3GbJyRlL86SHy9vcU0RDUT+tbSig3V8V7
   q3+crMibtvNk74hTuZlZTtK6a77sSZJ3+y6AkELONRDgBpy1hNmXJ/3GR
   DeqUSbbVVUW+gM3KhMgxPwJC34d0zm22hqa7ps+FawYFizUBGLQw3qq/T
   ohnvU1Aw2qh2Vrg9AIuDOM45IkvSTB+vBO1DKov1kiH70NZ9/aKU3DEbs
   A==;
X-CSE-ConnectionGUID: X+Qn/J8PQJW0XyPOukHyfg==
X-CSE-MsgGUID: RNocCGnSTHCcFZ3phD/0hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="40699944"
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="40699944"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 14:51:31 -0700
X-CSE-ConnectionGUID: 5pLwfEspTjauTMG3/+HaYA==
X-CSE-MsgGUID: rez2r8/OS9i2/sVZZyOvtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="85510397"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 14:51:30 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 14:51:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 14:51:29 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 14:51:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0Lpc76hl2oqDnDNqQ0bkmjCxCKuvHgJl/+zasnL4vOS0Zt/iMu8p4eQ/FlmwWiG4eO6jQP/1WEgUYq5Ex3d/qbA5JcB0/WOBRCXavZvRv6WD0EU3RmWxX/eSQe/73atI+nBUTOzMgb0t7RJcHW0sZYveHoLEBsGgRn7ygbsUUaKP9AfUJ2cHl9lbrw2v8URFtvle0jeiwpqqQsMSDN5na1DmzJdSTxBl9bhfUa9rWVjFldbb/PVBNFKEs6Y6ogI828lxobf0ZczQE5LvhiaF2kgEDfJKBeqvZW2Fr3e9kVbreV2F2FVMgF6CHo71RfnG9/7DlQo7HfRBdcjjpHG1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gbv0hOoF8wdGcoMo5t3Xql02Izr35QgSbJoU4/YkrPw=;
 b=lIrJgAG4xxV4UMdrjrXZ4xkC//k5oqJPf45RSfnubjbfi4R6OasQnooXEWuJotPrjj/M6pIEvwgiFnjZUaKRpzigHPvVxgo3ak5/QDIHPMQb8ttTuPO4LZ1r+IH5+inuSho1XZijg1KpotYnvrqDEOHBRyZZnGsIZT5m8jTkPADyMaqUfnbXMFPX48X6om8f0GbjBxB8y2lX6/Vof20Xsr0FgxkaADl5edLI/yneRi9wGhqiMt1QEc4tZbU79pteCQOf40gQVQkFlJMDUiuUW38/TTzQNI7KlKoOJKhxIgAP9ZAlOrh2+H8dwo5OSUcyKKug/dIIBprqOjw7lkSiLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY8PR11MB7394.namprd11.prod.outlook.com (2603:10b6:930:85::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 21:51:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 21:51:27 +0000
Message-ID: <441b7021-a423-4689-8330-c6675c4ece60@intel.com>
Date: Wed, 23 Oct 2024 14:51:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/40] x86/resctrl: Rewrite and move the
 for_each_*_rdt_resource() walkers
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
 <20241004180347.19985-18-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20241004180347.19985-18-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0062.namprd16.prod.outlook.com
 (2603:10b6:907:1::39) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY8PR11MB7394:EE_
X-MS-Office365-Filtering-Correlation-Id: e6563865-2f23-41e6-8031-08dcf3acd8ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVhoTS9TOFQzSDlLMXFzZmxhZkluLzdwMVhpaHRMcFVWeFp2a05YNnJVbnV1?=
 =?utf-8?B?aGlXNkxuYTFMcUhlbEExc2Z6NmRSeC9TdjczUmVLbnhMTG1NVVVwMkd2L0s0?=
 =?utf-8?B?RHY3dms0Ukk4R2tJZktvUDBXeDk0aHBvMkE0MDBiMkJnRzlxSUFPNVhDU1pv?=
 =?utf-8?B?Y2U3VFJmK3cvcVBlK0l0WFBtVkNOY2lpZVJjNkU2OEE1d1Y4L0draityTXVs?=
 =?utf-8?B?MGV5VENLMnd0a3NmU24wb0l1RlNpWXlwT3BtTFhvWG9aRDFMd1hVTDdrUzR4?=
 =?utf-8?B?dVBKbjhNOWNLR3Z3NFJ0b0J3amRibVBCVS9jRHVTTnRqbm1kWjhvYTNrcUlJ?=
 =?utf-8?B?VXdnL1hVWUdpaDFaWU11aStjYytEdFhPNzArZEdMU0lmd1Q0NjRpNVd2RHNZ?=
 =?utf-8?B?bFJvNjU5bXlrbjhzR094c0FWQndHQU5WdGI5VTRqZGdqWGsxVllhYlpXU1ZN?=
 =?utf-8?B?a2tyVkZFSzd1YU1NZUhrNXh1ekxFUlhYeWZHM3dWT2lhTDRvZll5WE85UFdY?=
 =?utf-8?B?MGdrYVczdWNYUWN0YzhjdWZzbzU0aFdjWHdNdDdjM1IyTTloUm9WOFpUc0NT?=
 =?utf-8?B?ZXA0WGV6eHZFWnFFRDg0MUFwSHRuWUZ6UVA2cm5hZWVrSVMxZTNZRmgvKzhq?=
 =?utf-8?B?VzZHV25lVk50TUVHT2dSK2M5S2RMM0hmTlVaMUFlSlI4Z2NiTUJtMEFPelVE?=
 =?utf-8?B?Ynh4a1I0aFVZUFRQQmJ6bnk1ajRLL2ZZZTdBeWZrMUlaTDZ1Z0ZwV3FPZGNC?=
 =?utf-8?B?OGVhZ2pkTFcwajN0RU5RRVRTSm1NUjhHcGl6eW9mNjlJSGo2TUFCdk9wWmVw?=
 =?utf-8?B?ZldSWG91R0ZaTGJpcWhCR3Q1VkpCeWFKVWRWUGFLc0ZJYjc3bms1VEp3Z2pW?=
 =?utf-8?B?Uy9uaUV2QlFTYS9oVGRHRWdKMnd4RFM0cVBoSFBWM3cxTzZTNlBPM0xadmRx?=
 =?utf-8?B?T2VQUFNnWGdvSWdlTUpTRGVuT0lYZlFoaldMbnNVSWp4OExFTmRXcHhEamFV?=
 =?utf-8?B?QWtzd3lDSi9KWVFTQzhaMVVIZ1A5c0JXUUs2MnBWRDJRR2lGeUZtQVdFd29Y?=
 =?utf-8?B?WC9aM0tlSmdZVktNUWVGYmVvVWRNZUxDNDQ0RyswUEhLVEdHblNBNkROQjVh?=
 =?utf-8?B?ZFVDN3NrbGpqUEd2ZGRSd1U5em1zUjloaVczQTdsQWZ1V0lqVURPMVR1Qy9G?=
 =?utf-8?B?Zi9LdExaWXJBMEVFRzFmbE5NaGlZNUYvWjd6NzM4UmJkZUxTSGpHcE0rbS9T?=
 =?utf-8?B?MVNvTzd0d1NoYnhpVlc3T3J4Y3FpL1VZZ3czODJuN28vTzM4eWFaK2ExTysv?=
 =?utf-8?B?b3BjWnp6ODJHZEF3akprb1NjOGhrbVE5ZVQ1RVdodTZERGFDUS84c3orV0po?=
 =?utf-8?B?bDg1Rkl0YVR3L0VVZHNIblZ2SWFqZ2FwUlNCbXVEazNNejhrZlIyVE1KTnV5?=
 =?utf-8?B?WGVoWUFheXVhRDR6Z2FtODV4bG5YaWk2TGFBRm5VKzN1K2puZjdOR0FiTk1r?=
 =?utf-8?B?QkJNRlNHK09kdURjQkp1eC95aU4rd2ozTUxYREhmTCtETmNCNzZPaTR6Sktx?=
 =?utf-8?B?cFVnUyswMEV5Nm1Vd2dUblAzWGRTS3J0ajN3czFQMzllYXlVblNxSExVMHFC?=
 =?utf-8?B?L0NxcGs0U0tVUWcrYm9oK0NyMzZ3eFlreHdOMk85N2d4YzNZT3lBWTJFdzIy?=
 =?utf-8?B?NW1CeXBUdG9rV2FLTnVlQlcrdlFkMmtYODVNc2lLcCtJTGxXUGtqZHlYVGJ5?=
 =?utf-8?Q?Lfj19cJWURMdPO9H5Lw/aCPkceKLP9l+ytU28fW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ty9FeVlzL1FqWmVpeWIwaHBqNUt6WHA2cG5DRlBQS0FoNHBJMjI4ZlNpSCt3?=
 =?utf-8?B?NmVCeUJFMkdDN2JBNFIvYjJDUXNXNWxtOWhmQ3lyanBGNzcxeFJZNzVTcjUr?=
 =?utf-8?B?d0NJdDhYbFVyVWVndEZTdHlHSzlsRW8rdVdpOWxqRXpUZ1ZaSTBUSGc3ODdi?=
 =?utf-8?B?RjJjUWZEZmw1aXFudUJyMkF6dzNzQnAvQUZjQ3lXMmtsWGtLR01Fc3o1Rll4?=
 =?utf-8?B?M1VPYWU4S2Z6QlN6YXhmN2MvNWcvWXNFT1BqcDE0aTBFZzVvcUtzcW9aNzBB?=
 =?utf-8?B?dk1HdUI4QzlPRFZhcEUxQ0s1SGpnTy9VeHRUUzFVU1VXalFGRm10dWpLelM5?=
 =?utf-8?B?NUNoREFZNXhVUmFxVENXZTVqS3dheUFSUUpjZ1BxT3RYN3dHNjZlQWtmTDlZ?=
 =?utf-8?B?bFRkcll4b2RCS3NxRVBUR1prMW5lV1ZUeVIrbmM3dzI2THZQNHJvbjFPZXE3?=
 =?utf-8?B?eWR2SVQrMDVYRFlqalBBaTdPb1ovd2JSdDI3MXdLWitKeSsrekQwTVVhYVBs?=
 =?utf-8?B?dmJrNFdKMGVkeThpb0Y2cHJlcDFKMlJFdzdmWnA4QU9sYzdvUHdLNTZpaTc2?=
 =?utf-8?B?THlOVU1hS1BEL3J0NEFYNzRYb3dlZlJrVENId3I5QTZzbWdsUTloN1F5RHNO?=
 =?utf-8?B?WHFNcUl1eFNKUHJRQjMyeC9HU2lQT20wamhseDFjQVFyb1JLT1ErbDMvY1Mx?=
 =?utf-8?B?YzR5YStDWVcwREFwcmloVGRLanpvNGYzdzNub1pGdU50UFcrK0FRditBQndU?=
 =?utf-8?B?dkhnS0UrQTNIaUtOMzBsK0puRGdkT2pGa0ZsR3EweUdxMTBnNXFCMXQ3TUF4?=
 =?utf-8?B?eC9UOE5vckRiNmVaRG93RUVGSHh1Mm9GMzdtODR5eURoQzZwMkFnNGNiank0?=
 =?utf-8?B?Tk10K3ZMWUpxWW9EQkdKT2lNcm1zdzRnSGRRdXpWL2QwYVExbXNpRG53V2hZ?=
 =?utf-8?B?UGpCRloxVlpuQlZ3eDNGRXIxRWFrZmY0L2VmUFdBL2dpdlJvNnNSNmw0R0Ni?=
 =?utf-8?B?elJyNi9yRGRQN3RqUTJtRE5CbGR0NnI0dkhvcTVSUXB6NXpQaTVtOTJLWGNQ?=
 =?utf-8?B?RlpCVjAvUVZ4TDBhY0xVZ09PRTg4a3ZQenVmbG9HL3BkOTR0bGNlVjJCZmh6?=
 =?utf-8?B?cHZPNWpzYzFMY2RqSEx3UGRnMW5DV3RWVTNJQkk1UDJvcFRUS2YyWWFIM251?=
 =?utf-8?B?dGtHSmR2MGlONDl1YXRBeDljTkFVN1FQQlZrQzhKbHYvZyttSzVjRGNjbUZw?=
 =?utf-8?B?K2pmRnBzRklxSUpyK0JvM1R0eWhINis0TkorNWZ3Y3k1WVhkRUpqYmtoZCtZ?=
 =?utf-8?B?NWtUQzhaNXhPc1MyZHFQWnZUUTNwdEVmSk9HVDc2ZVRmMElmaDN5NjRYVTBV?=
 =?utf-8?B?cGpZdEhuNmc5ckk5ekVYOGJ0dGI3bm4wWTBtSDlTbUtuTlIvNTRJaHpneHl4?=
 =?utf-8?B?VzRtelZPS2xYTFdWMU84NVdSUUpuc2YxQ0dpaWsvbFBtNURKR0xWR20xNnFW?=
 =?utf-8?B?VC9vcTQxVEVNd2h5Z1FiYTJWSHBpbDRpRERQbmZFRk0wU3F2c0dhbnNYc0RX?=
 =?utf-8?B?bldTdkY2K25yb3EzRlhiYzdyY250akJWSXluUHV1M3FESzg2ZHY0R2JaNXBH?=
 =?utf-8?B?VUIxOWMwMS9Sbk9qY2xRZUlpQUh6eXo1K1JNajdNYzdNcTZ5T3JmREN5b2p6?=
 =?utf-8?B?ZzVoQlBtSnBvUGhrUFVxZldDMG80NkJzSkc5ZUhQR3ZPVnVHZlJnTVJFaUZD?=
 =?utf-8?B?VlNVNzV4Z25WWWdMRjhtWUZUOFBHM0J3Nlp0TDducXJIc081U0x0eUFrUy85?=
 =?utf-8?B?ckdjcHFEZVRSTEhNRjRBZHRyRytQWkdrQXRLTlcyWmMrZEdkajY3YmNjRFVm?=
 =?utf-8?B?TjcxY1FsdThvTk9ZcDBvaGlhNG9LK21iVjFjWm8wL29sQWVKQ0ZlVkxVd3pM?=
 =?utf-8?B?Tnc0UnhrbEZ1cG9IVjBJcVZJOHM2ajN2VWlIMVFxRDE3L3hGeXh2QjcwUFNu?=
 =?utf-8?B?YUdxTVpZSGVlWHRydGJLRW9qanRBeFhUL0Jxc1VOMGk5SmJuL2RKRGxnZVhY?=
 =?utf-8?B?TjFndkN6MEd0L3h6aTdyM291Vm4wUUVnNzNjZnE1OVFDMW9tQUMwd2pJSUpR?=
 =?utf-8?B?Nk9Nb28wckR6b3RMRGYxVXRRU0JrNmJqZm9MZElsanFEZkZrOWkvZGloY3hY?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6563865-2f23-41e6-8031-08dcf3acd8ac
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 21:51:27.5956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g2I/aWfvLb0UjDrSmXZYlZzkTvaUl2pzUIHs3sF0pdaOKcc8IauqunIOdVye8gAPjsvW/hf0mJNEVfrQVnrX9VM9e77z4msP8nASlYe/Y/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7394
X-OriginatorOrg: intel.com

Hi James,

On 10/4/24 11:03 AM, James Morse wrote:
> The for_each_*_rdt_resource() helpers walk the architecture's array
> of structures, using the resctrl visible part as an iterator. These
> became over-complex when the structures were split into a
> filesystem and architecture-specific struct. This approach avoided
> the need to touch every call site, and was done before there was a
> helper to retrieve a resource by rid.
> 
> Once the filesystem parts of resctrl are moved to /fs/, both the
> architecture's resource array, and the definition of those structures
> is no longer accessible. To support resctrl, each architecture would
> have to provide equally complex macros.
> 
> Rewrite the macro to make use of resctrl_arch_get_resource(), and
> move these to the core header so existing x86 arch code continues
> to use them.

The last part is not clear, why does it need to be moved to core
header for x86 to use it?


...

> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 8894aed3c593..f75f0409ae09 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -26,6 +26,24 @@ int proc_resctrl_show(struct seq_file *m,
>  /* max value for struct rdt_domain's mbps_val */
>  #define MBA_MAX_MBPS   U32_MAX
>  
> +/* Walk all possible resources, with variants for only controls or monitors. */
> +#define for_each_rdt_resource(_r)						\
> +	for ((_r) = resctrl_arch_get_resource(0);				\
> +	     (_r)->rid < RDT_NUM_RESOURCES - 1;					\

I do not think this reaches all resources ... should this perhaps be:
	(_r) && (_r)->rid < RDT_NUM_RESOURCES

> +	     (_r) = resctrl_arch_get_resource((_r)->rid + 1))
> +
> +#define for_each_capable_rdt_resource(r)				      \
> +	for_each_rdt_resource((r))					      \
> +		if ((r)->alloc_capable || (r)->mon_capable)
> +
> +#define for_each_alloc_capable_rdt_resource(r)				      \
> +	for_each_rdt_resource((r))					      \
> +		if ((r)->alloc_capable)
> +
> +#define for_each_mon_capable_rdt_resource(r)				      \
> +	for_each_rdt_resource((r))					      \
> +		if ((r)->mon_capable)
> +
>  /**
>   * enum resctrl_conf_type - The type of configuration.
>   * @CDP_NONE:	No prioritisation, both code and data are controlled or monitored.

Reinette

