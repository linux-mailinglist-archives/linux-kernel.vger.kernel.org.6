Return-Path: <linux-kernel+bounces-395693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35399BC1BC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 00:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F323DB2193D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 23:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B7C1FE0F1;
	Mon,  4 Nov 2024 23:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M1mm0s6m"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED10C139CFF
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 23:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730764735; cv=fail; b=fBjwJUbg2G9Nx97ZWS2xuTocxzcNLV7Q11U3I2VlaWy/7AbnylQCujn+8f/XuMA0SXvMHGm+F6vfYiupzBpDayFQRnGXbPU2SySTBBLo5QwX0jkup6d9UEMw84P9M9AAHvvcLLvPc8kGHSf8ZN9/JYYGplPdDkVvbkKyF2bgHFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730764735; c=relaxed/simple;
	bh=zTth3t04Asu92xfZwzvla+HUQa5doSY+Bz4u4GztWlU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JkebfjKGsZ+etW2em7buSOSVGOHgKtovEui5ANub41ZENXdceHZsEd08KgI3NJjWFEy53mv4PP2hsSOeFD5WN687yoSCi8cYoczvgSU0t9RrfOgePZbXYhKgdcTJz07nQGuQYXOGLeh2hal4+t3AnEOepIoCNUEzlSxUpTOItdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M1mm0s6m; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730764734; x=1762300734;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zTth3t04Asu92xfZwzvla+HUQa5doSY+Bz4u4GztWlU=;
  b=M1mm0s6mNovc5X/RzBNMkN4Wfc65rpi09zTQEIn6DtDlRRYcbi3hQbTg
   ORC+Uupvj89lbOFJYqkhqH1ZIfV/E/1Iyeb5wXoNxU4QkIIFlouI7sC3k
   oWsarW0rIdPCxJ1qYmQI8z+JjUAz9VeILW0DPPPXOhWYggiHfOZDRf0WV
   JvF7FIGzMtfo/1KQHqZlNorJvh3HEjaYHsgLDNcQZwP4f4S4TxOn5vdMA
   /JvLRw/hFz1kxlMO4n71Dmapk8toq4FfuzIPpe+HYyESzFE4s9gUb1fp9
   IlHVFwvHzbhBmTJSu3e+OKyYUpbTEIDnmu53YJQXyoYTRiqvN65YhU5kz
   A==;
X-CSE-ConnectionGUID: UPOea+naSpaQB638dQpISA==
X-CSE-MsgGUID: myYw4eikSJS+zs9N1V4Fvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="29907977"
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="29907977"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 15:58:53 -0800
X-CSE-ConnectionGUID: U+inBHMvRhKuYnex5w8Liw==
X-CSE-MsgGUID: Bu1N0GxbT7yHseQXbUuqIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="84236540"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Nov 2024 15:58:48 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 15:58:47 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 15:58:47 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 15:58:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MY9r9sYK/xuVf02haCsPhTkko4xeYRwWd/5qzgSIUPu2sjtiH9aV92iA+shfgfrQ/b2JS3xvKbIH8y+Jow+dNNZXpWDZl3b14Qr3x4dbiMWw6grUsH2rA2ScBbj/E6PR1IXiX3iJs47ganbfHNTqr83Gk8I9+rsF5m02BoRZ/1CcKtgwrkjqmJtkjS0VRNgasV7voSBgQoVRbMax5HOxQwDrpmgQHoFSSTN64wbZOrKc5L0B6mp2Q9nhfRAkF0V690q9Y74HLJcTVXTNSSz4g8lm/y5VhmIWn97kergSOxZPsjedkQOAcLslmuBDAriea8gxlPb/cZqZkd1HD0xhoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kr1kDJmahJ44ibGxut+U1kvJveRm1mCk22C+HkA3FDQ=;
 b=r7S1pfRpJi+bvLT3KqwIi1sqgzvWp/2nfDfIay/2vl0nGCqX1lDrgdXpR/WUGBswnvUxb8B1wQ8xLGvsQOYxtO8Nosvri49U9BJXAyUcjyHRl8xOFXJJAYbH2gCmtGSczIZFAmyQzpjTaPmqP0nV/KcIDjaMENaU7q49+WjKk9ilP/cMu4zoQ9GlUZJR7RXQiITD8yf8ayFqbTK49coRVrZSA/VibQTK69R+T4rglH++XXEhUjD24Foz6TGPXfoJfP0AT/4aqiTT0rwIgPFZ0UZLPS90pBL0F9vYfFrAvzSosFwyd8MKkQwbc9W6r6v0T1Efarq9m63sn3t/4rHBGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by CY5PR11MB6464.namprd11.prod.outlook.com (2603:10b6:930:30::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 23:58:44 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 23:58:44 +0000
Message-ID: <8a76c5df-3982-c53a-9643-4b6b1de290e2@intel.com>
Date: Mon, 4 Nov 2024 15:59:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] x86/resctrl: Don't workqueue local event counter
 reads
Content-Language: en-US
To: "Luck, Tony" <tony.luck@intel.com>, Peter Newman <peternewman@google.com>,
	"Chatre, Reinette" <reinette.chatre@intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, "Babu
 Moger" <babu.moger@amd.com>, James Morse <james.morse@arm.com>, "Martin
 Kletzander" <nert.pinx@gmail.com>, Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Eranian,
 Stephane" <eranian@google.com>
References: <20241031142553.3963058-1-peternewman@google.com>
 <20241031142553.3963058-2-peternewman@google.com>
 <b3a52af9-e298-7baa-19b3-8931d03731d1@intel.com>
 <SJ1PR11MB608357ED39FA4FA1C85C6DB2FC512@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <SJ1PR11MB608357ED39FA4FA1C85C6DB2FC512@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0169.namprd03.prod.outlook.com
 (2603:10b6:a03:338::24) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|CY5PR11MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e9513a9-2546-45f5-c00d-08dcfd2c9d34
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2h6cnQrcEJOZ09JTG9LS0lkK29YcjFBUXVqSEViR09WVnRHcHdSbVA1Tm1V?=
 =?utf-8?B?ZmJ4MWh2bUlLM2xGb0ZlUVg4NW0weG4yUkI4WXBWQUdoR2s5WU1NemhJQ21k?=
 =?utf-8?B?NmJ6ZGFLQjhlRFZqdTVwWUZ2SDNmRmU3SlNBY3FVNVhsQTltdEtnT2hsaE5I?=
 =?utf-8?B?Q3RDNThXZzFwaTU4Y1E5bGRpREF3OEt1elA5ZmRVN0IwOTVpY1I3blpvSGJs?=
 =?utf-8?B?YzZMeGhKMlpyTERPc0R0Ym9ycEh2alhNT294b09vRDlXZE55WXhPeDJPTGFJ?=
 =?utf-8?B?UE1HeWVRWXppWUpVc1BCR0FzeW5Dc1VBOE5QMFMxVFVCK2hOdFhBMVM5MElF?=
 =?utf-8?B?MmFvWVBsSC9LZDVIeWYyQWlEQVdVcmlGcU5qTFZOWDNUU1NMdjZXa0FXeHc2?=
 =?utf-8?B?WTAzWmQzQUgvLzF2bnQyQ0NCOXFNY1grSnVqMnVHL0x3Q1oxdTBHRk9zdHlw?=
 =?utf-8?B?c2JnNkIwZGh5VGcrS2U0Wnc0YWI4dCtnQlBMcVcxWkJCZU1MZCt1QjZaellF?=
 =?utf-8?B?WkYzNTRCVG5rVm9Hc3EzV3NnRHJkZ01saHQ2OUgvZUNYSXkwcmdmdVNYcGd5?=
 =?utf-8?B?RERRSnRaQzRlVGQ5U1J1SThHWGRZT0hTWDRrM1BXZTJHUkNxYkdTTzZ4T3kw?=
 =?utf-8?B?eWkwYlJCWjI4WEx4K2J6N0FJamZQQlVZY0dEUVFWTHFwemhDeWd2N0F2RC92?=
 =?utf-8?B?c1pVQkVqN2NMT3BFNE5OZDVkbkwyWEpaQ1V2QlJ1aFNEbEVhY3U2dW55T1ZP?=
 =?utf-8?B?aGlJK2RBT25OdExVMXBxUE9SRDQzSHpDZ1RLWmtmeHlOZ2xKYmV1VXhwbUVW?=
 =?utf-8?B?dmVWUUxWaDFsVkN3VENVem4wR2ZyZG9ldDdjM05Ua242YXdMdEkyYnJxSEs2?=
 =?utf-8?B?QjV1RWx0VlhsekFJdUhWQ1FpT0wwenplTnZiM3RUZjd2eW5UVDN3STlEYWdo?=
 =?utf-8?B?VjE3K0x4ZmYvelk3NUk4KzQxZ1lNWkNYck5ja2VnL1loZE1XS0ZnV0pHeUIw?=
 =?utf-8?B?OFA4YU9BcjZCOFpwTEJCWnhOYzNhNktSMmpXQS9TVndaS0tvbGJsM0gzaW9z?=
 =?utf-8?B?QnFSTGNTU1I2dHJHWHhoR1VCVkdpKzFTd3NBVTgxZzlPSkQ4T01Vcmo0aTY3?=
 =?utf-8?B?TG1QREozN3ZyamZUK1JZOWp3Um5WcFlzUlBCbDZtTmxvTGxXaEozWDJYRXBV?=
 =?utf-8?B?OXJXamdRN1htSnAyaGkwZENGMFl5UDk3SFEzU0JMRVZSemVxbFFvMWVaaVR0?=
 =?utf-8?B?N0RtTXYyY3VWZnJjZ3IvRFVTR1U5cDZ6ZVB1NGRFeE56aXc2VTkzbWgrWFk4?=
 =?utf-8?B?RGNERVBocVc4MFdMK0NvcEkwNmZ4ekRzYm1YdDRYOWxUUUwvZHJCeUlzUDZ3?=
 =?utf-8?B?Q0xra1J0OXpPVGJiR2svK2c4cDdWQXlLMklHb2dTZHBFem9tRlFOMjd1Z0ZN?=
 =?utf-8?B?Nklxd0kwZ2QwdnBzbktlWHptK2pPbmJTQzk5eTd0RlFBYjJ2Y3JjdDJuRlBz?=
 =?utf-8?B?Nm54SXExcXdMWjhpTnkrWjFLVFVQa1FtQnVOTnB2V2liU0NMaVgwcGVadUVn?=
 =?utf-8?B?Um9od0xYZlBFZXV2ektJeG92d1JyMC8vUnBVNHZNc3VaK1RvdktLTnBVRDQ0?=
 =?utf-8?B?U3k2S2xLRHZEZDhXQ3A0OHZFQXIrMEpDdHY1M0Eza0FvQXlzbmlUdm9sRWg4?=
 =?utf-8?B?VXRLNjNHaEhTOXVJeTFYV1FoWUdLU3FGTktCZ2l2UXhpdjVyN1ZGc3o5aVVv?=
 =?utf-8?Q?yXwg1tuGFEHxQJRuI/f/MfcpYCxuKbQNb32mJy9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkQzcE12RHBkdGJ4ZWlKdFFIWEVXRGRxQmk1TTUxTTYyV0FmY3dzZXBJcEhR?=
 =?utf-8?B?cFJvZmcyWkEwNEltSDE1eHNwYzJWZ0lqbExLUndXbi94ZEIrbXpxSUo1NUlC?=
 =?utf-8?B?bTdyN3hlWkI3MVlJVUV4M3VjT25hNmdJU0pmMGFGdHhHVmlKaHZhempDWnUz?=
 =?utf-8?B?enNwWGVOYzh5cEZxWmx6Y09oMEtKNnhZaGx2S0pwREFzT1ZHVmR2OU50TFhz?=
 =?utf-8?B?eGdmZDhPSndQQnMrU2QydERnbXVJb2E1cmVWVEFicVJnQ2kwRUk3cFdXcTc3?=
 =?utf-8?B?NEp6aFZIVEQrMVRleTJIaXhFTDlHVi91ekhrTWIrb0xYUXJNMGJJYmhpdy9C?=
 =?utf-8?B?SE1ZSXc4enRRR3ZJaVNPeWc3UGFOZU5FakFOUmU1YjFMVkVqV2hESmM2TGJp?=
 =?utf-8?B?aFZYdkxCeXdKRCs1aE9NRkVFKzVRclBIR3c2Y05UZWppelFySkZNa2g2OUNu?=
 =?utf-8?B?TXE3aXBkeG54NlVyV0EyUUVyUHFVQStqeklSSVhqN0JOZHR3aUh5K0pXK1Vz?=
 =?utf-8?B?WmxTK3lDSENVbDk5YjNUc1hWb1pXMnIvOUVBQlRWVUhqbVY5NnJPd3NmRDA5?=
 =?utf-8?B?c2tqSWRoSzBWeUZGUldPb1QxVXU5dUJoem9iejRLSkhtQ0ZkUGdYd1Y5MDJk?=
 =?utf-8?B?N1JwU21uaFFSSW9JMlpML1NKTHB4SXN2VTdVSmQ3ek1weXdjWU00Z09hM1pa?=
 =?utf-8?B?ZUhVeWdhcnhGdzlqR3hmMWl6MEhXR0VLTFkxVWZ3QmNJaTFra2wxYVA3Mzcx?=
 =?utf-8?B?L3hRRWpFam5tNXJ0cXhpK3NmdFVFYy85Mkh0SVRiZTJ2aFhZOU5lYnR2QTFl?=
 =?utf-8?B?bzZENm1WempOU1ZhVHJKQnM1KzF3TXE3ZzlkUDJHUDJKVk14NlVyb05RZVZj?=
 =?utf-8?B?YnozeXlITkxVWDVGUmUyQmVqRnQwdjBJRXlrOE1PNEhZblFQZVh4ZFhjWFVP?=
 =?utf-8?B?Y3pSRU9NMGFlaEl0aW9JUXZHL2hTajJjWXVlR202cG1kMVd2QldGY0h5Witw?=
 =?utf-8?B?bkVHa1BnNTY3L21uL2dnMWFPSzZuazBpc0IyNlkwWmM5MUQzSEJoVmlaMCtz?=
 =?utf-8?B?OFl4K2JFR2lpVXRGenNMcy9LemNpZURzSDhLaDEyQWVSSnlNajBvcHZjS2hk?=
 =?utf-8?B?NnhnWStOV2NBaGJzcXRkTitUMHA1Z2l3Qi9FOWJLNjVoc1lNNE5HcXRjSS9i?=
 =?utf-8?B?WkZRZkFsRzU1aWpjOVlBb2hkdHhrYmt0RVFFWVVXWXhiemNkVHZJeW11OXNW?=
 =?utf-8?B?dGpMd3ExdU9QREZHT01GU3UyOEpvdEd4TmhwT0MwYUR1QUJxdmoxQkhRb1hP?=
 =?utf-8?B?K3Z1aEV1K1lnSnVudjZ5TjVDUkVOOEVyWW94WFVSbTJDTnNydHBHZ0RnZGVF?=
 =?utf-8?B?YzVBMkN5cjB6bjFxTzhJRTV0cnoxSldIV1FXTnZwRnkrc2R2cDdoc3BScGhW?=
 =?utf-8?B?alYzUUpuZ1lLNnZhWDg3ZjNwRDU3U3dHcWhPTzE4ZytXWVZneUxkVHk0Q1lm?=
 =?utf-8?B?UHVuN0p5YmhvZTRzUUc3OUZRbXU5bjZlc2I2Q3FRYktQUXRVTWtWcDg1NUdC?=
 =?utf-8?B?UDRZV2VJQUFrOVRsdHMzN09oWUFoQitwM25XSkJxdktlZTA5MnRzS2l6UEFQ?=
 =?utf-8?B?NDc5YlA4M25DeitNRjd4N05yRTJocVU2bVNvTkZVeklvZlh4aGhPNEcwMVRm?=
 =?utf-8?B?QWd5dko2OUxvL2JUdEtrRTU3Sis4OW10dWNVSjJ2RzVKcHRhUTF6cmFKMXNE?=
 =?utf-8?B?TEk3TnhFdjJCb1FZQjR2SjZieXp5UW5JK3AyMWppMnNNcUZ6SXJOWmJOcTRk?=
 =?utf-8?B?dFpLL1pXb0I0YnVLTHYwcVpOb1hFWnJMbk9Uek5hOFkxUEtDQjBCVXRVUjNs?=
 =?utf-8?B?NWdPZ1Vnc01tN1dGaVZCT1RtYVIxSmlPNEQ0QlBvcGRKVUxKVGkvekJTRFpO?=
 =?utf-8?B?RGhPRWM1Q2lKWk5pUE5lSHJ1VmUwamxBa1ArTE9JUmhKcEwxcUVwTmc5RW16?=
 =?utf-8?B?VVNhVlRLSk84N1piMzZtUDFibkt0VnlEY2ZsdVJpQjNVbmJVWm80blhiQ1px?=
 =?utf-8?B?dTh0VzZ2bTRtL0dnUlNVUkhtdHBDUkFzUmFFLzZ2cFczMWgrMnNEUk9CUnM5?=
 =?utf-8?Q?c4Nw/pGGY3wK8ysQ89npaCcUR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e9513a9-2546-45f5-c00d-08dcfd2c9d34
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 23:58:43.9586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: twGCq5eczvss0iEiKOCLWctUM2SRoH1b67T6GPT+As7iwmHhkBpzRRjtzFnvhCeX/RQ4I/oSh9lHRLZUIoX6aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6464
X-OriginatorOrg: intel.com

Hi, Tony,

On 11/4/24 14:56, Luck, Tony wrote:
>>    	cpu = cpumask_any_housekeeping(cpumask, RESCTRL_PICK_ANY_CPU);
> 
> To a large degree Peter's is working around inefficiency in this housekeeping
> call.
> 
> Code may be running on a suitable CPU from the domain cpumask, but this
> call will very likely pick the first CPU in that mask, rather than the current one.

Agree.

> 
>  From that point it's all downhill unless you are lucky enough that the first
> CPU is a tick_nohz_full_cpu() one and you take the
> 
> 	smp_call_function_any(cpumask, mon_event_count, rr, 1);

Whenever this function is called, the performance is degraded rather 
than improved because extra get_cpu()/put_cpu() are called in the fast 
path in the current patch.

On platforms that have less housekeeping CPUs (e.g. a RT platform), 
there could be a higher chance that the first CPU is a nohz_full CPU and 
run smp_call_function_any().

> 
> path. It seems that on many systems you'll take the
> 
> 	smp_call_on_cpu(cpu, smp_mon_event_count, rr, false);
> 
> path and make a pointless IPI to get the data.

Yes, that's right. But it's not conflicting with my suggested change.

What I suggested is to move the fast path code to this case only. So the 
fast path is always checked/called in both cases if condition is met:
1. It's already checked/called inside smp_call_function_any() in 
nohz_full case. No need to call out the fast path separately.
    - No extra get_cpu() and put_cpu() are called.
    - The performance is better than the current patch.
2. It's called out in non nohz_full case. No performance difference from 
the current patch.

Thanks.

-Fenghua

