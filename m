Return-Path: <linux-kernel+bounces-560528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBC2A6061F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 00:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91820422DCA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251AA1F9A8B;
	Thu, 13 Mar 2025 23:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a5JR+oZm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DF31FC7EC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 23:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741909517; cv=fail; b=d4fTQfuniP8k4PrU+ip9p8V/4Ak92PWvobfmkumr01h1m0H4Oucj2TN29+HJ7zSgG/0BNBFYwjyqFP5hc9vhhFL0ZiAeWDa3DieEXWeMe0giuST14ZKkg2RhNhoyX7qTlpilRfo5tTfnLJfOLJ4jL0cGZ97s8Mk9iM43MxJSdC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741909517; c=relaxed/simple;
	bh=W1etOO40Y0oyZMbP6/rkvBnlO3XTqAOpSojV/sl8B+A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EhgMCnWx7A6PLtasPqm+sHcehD7x6k2c5J/c3UedP5+4s2DgnP2rMdIlOrmkb8KsnczgWdsgEVUdlQEw10WAoDihSAov4OIwkUrdvJnZW55XVzHSPSLyYDaIJGER4wDhFxrwepab6JAXmrucCcUS2dCGS/qgigIkI+ISTKvT2FQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a5JR+oZm; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741909514; x=1773445514;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W1etOO40Y0oyZMbP6/rkvBnlO3XTqAOpSojV/sl8B+A=;
  b=a5JR+oZmfpZw/y3G1Jz1lyDAaXyV1tkkObGUv0fGeWOcLQRxppPDtk3S
   9nnQ0Hg5z+9HPzg5CMwwuX7Swq75ZYrgUVAr2C4wns57mXqj/mAhXE69L
   ucfrpwlDvWiwKF7rxFPb17ZBZw4sGzZ50jApr1uPtdTwSMCuMoBqGz60l
   yx5wCMoVkxKarrQiX2I4Rr/SndRSR62izRgo7WlwXB33FutIvgq90Bbzs
   YJUJ1FrhX3iEzJPruH9KBxGm/x1iSgymo6wYnWDyYKxQB6NGnEhhVNsPD
   t4LZBenMNfAYOCVW2WPoLfmWpUWIzxsANxmnbgT5ECej6lMszs+NNLsk3
   g==;
X-CSE-ConnectionGUID: rk0YwDaSTSmNoLfJ4iDghA==
X-CSE-MsgGUID: k1rO+VABRhCpa/yNIE1moA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42779633"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="42779633"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 16:45:14 -0700
X-CSE-ConnectionGUID: vQLjAH+xSWKhnYkoc/IgwQ==
X-CSE-MsgGUID: hXCZRPKIT1yTNYTh0kJ+Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121613761"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Mar 2025 16:45:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Mar 2025 16:45:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 16:45:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 16:45:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kDxrZvRXpzboRbRqgT7LjV9lF43U26qQ2VU439ylRogo7b7OarpMid6d7CrTNp0ry7ElE9jC0YuBn2mHOZBi/O9YfeeO/TeV413byqG+aKrlD1gIFwYAH0wewIy9fNhcsBtu6fAdSmPhVkTbpU08By6D7BiSlMaTf/I6T0uKXpLouuVg3CIzHHSYEM7XeVjWMU9uyw/Arb5H+lrRTxnIe6y4OGV5SMP7SFYwDRYyzy3SPFusV8KNJXXweyNzhii0xlbLXdc6A/nAC4yCyzBZalxOfitAFZUZTYcD+Ep3c0EtniS667BxVnVvQcHpVxkQKjtjsfaGtRt9Xnrmkj4srg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYyIHA0SeGwDB5oIvFa+BkosuseBl+Lrg6uANSvKUiQ=;
 b=d6WwL5A9aH7jdQxU5/3m1nmcIig1H6l40/km7MtrRKoNcaJs0isybupA1LZLSSBm1Xx1+eUQ3crs79wIMBgPfFBHREnONIf8EjzSJsr3jbTPlb8QWRkRiFrjZLje4sjgtdLDmLGtH3uvZsBb4aZzhiPzLavcd8kuzF6szeDcr3+jQECZUHNq6Fl63dkHkEXvptQDiZHFL4HPzod7UWliilg4gMOyiP9oIxd4J7XLoUnWWtNGNSP6IX88dXQRxhrodJXF+i0jSxW0uvmBRbzfbg+POHZFU85YsPoT4DmUJEpxM09AWptWPQ32laf5YYwd3LfW7JQhKnurx5zgqecT6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SN7PR11MB7975.namprd11.prod.outlook.com (2603:10b6:806:2eb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 23:44:43 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 23:44:43 +0000
Message-ID: <5ac97442-78b1-40ce-9282-06cd62d97a67@intel.com>
Date: Thu, 13 Mar 2025 16:44:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] x86/syscall/32: Move 32-bit syscall dispatch code
To: Brian Gerst <brgerst@gmail.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>
CC: Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, "Andy
 Lutomirski" <luto@kernel.org>, Juergen Gross <jgross@suse.com>, "Boris
 Ostrovsky" <boris.ostrovsky@oracle.com>
References: <20250313182236.655724-1-brgerst@gmail.com>
 <20250313182236.655724-3-brgerst@gmail.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250313182236.655724-3-brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0159.namprd05.prod.outlook.com
 (2603:10b6:a03:339::14) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SN7PR11MB7975:EE_
X-MS-Office365-Filtering-Correlation-Id: 17792094-dcb8-4970-588e-08dd628907b0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TTJOK3hlZ1ZYWEJmVjhtYWE2R1d5VUlZZTU4ZFdxb0h6WGg0U3ZsdWNUSFFC?=
 =?utf-8?B?TDdWbzh6SmFoN0pycDBFZTlTbXI5djF6TWJzSW5HRmpnL0YzZkVpb2ZsMXVn?=
 =?utf-8?B?cGU5T3U1MnJGN1QwZWFoMmJpc2dsRGVzTE83cm84VXdUYjdnTnNYK3BuTFVj?=
 =?utf-8?B?U3ZMZUtWTjFjSVdNLzBMMEFvcElKUmRVamZ4TmYwajBvZUVTaVhTazdBVGM0?=
 =?utf-8?B?VDROSTFGT2pBTGtFckVtUG1iTi9Mb2xwYUNkV1c4Z0Q5aS9SSWJEMjR4c2Zi?=
 =?utf-8?B?c2pEamdrdHVSMW5FRTN2Y3JaTFgxTXUydTV0SFNuM3dwUmFhYTVENSt3NDFT?=
 =?utf-8?B?NDdaMElMVElkVEFIV2g4eUxFSGFXc2t4TTY0Q0UzbGJ1MGJBM05xQk5ZcEVL?=
 =?utf-8?B?R0Q2OGJvSGdDSXRJR1dlMURONjUrY0tSNE9KRi8xVFM1YlNybE9tb1pWOHpv?=
 =?utf-8?B?cUNCdmdaa0RveUs0S0JObVBHN0FYQ0RrKzMzdGN0ZmppcFhacnlLSEtDbzd0?=
 =?utf-8?B?YzhuN0hZQWR0RGRrVnFQaDVKTXQ1Z0xxNW85ZSs3QXZFbUhQMXFrV2dield2?=
 =?utf-8?B?dWRQcE4xZG9DMjlhc1pkMWlVdzZYQ0tBV0dVbjEySnpzMzJIdVpndmJUT0Za?=
 =?utf-8?B?ZTRuSlErZVR5UlhFUndHTlNqbDVIZVlaSzlhWEVmdkZCV1hQQUY0UG51Zm9m?=
 =?utf-8?B?aVpmMkNJZUc2UWltaUhSRzZnaE9ETHBPZFBlWEhnOW5xbEI2MTJwYUhxaHd3?=
 =?utf-8?B?ZjlCeThZYTFIcmt0TmFMSndPa05KS0lLWmNXa0lHdjE4Z3BkdkZ3RzhLVHpp?=
 =?utf-8?B?MHBYT3lqOEZwSGUxQmZYZVlWYkhYL1FybURtUGxOK1NIT3pIWUNvMHh2b3Jv?=
 =?utf-8?B?NTQzUXJrbE0xa0ZwT3p4cWxnc204VFQydHlEOFFEUGhlSWZpS21ReU1kNzhy?=
 =?utf-8?B?TjNzYXZHN3d3OXh4Z0lEbG15WWU5SklROHJzLzV3SEJWcmlocWp6SHAxMVdu?=
 =?utf-8?B?WjVYdGxDYlhiSTJKdy8ySHFkT3dRN2VrSXNGeTFSeHk2bTdEcGZ0a3lRZWM3?=
 =?utf-8?B?aU5ENzdIKytkeklTRnhHOXQxc0pmdW53RUtOVUlkNy8vV1crRlkyOEdoeFdk?=
 =?utf-8?B?L1ArdjIwMTFSQ1Z6aWtoR3NsODBiemUvYlhpcGhCTURtU3V6NzNWSEMvNFdx?=
 =?utf-8?B?dEhIY0FrK21sbUxUd1hzY3drcW8vSXRsYzN3NjRNdWJWSmRXTkVhMHZXWjFC?=
 =?utf-8?B?eHVhcFNBK3Z1MWd4Mm5kbVZjRDVRQ0ErZDJ6OVJQWk5jVUorOUM2RjVWY1dx?=
 =?utf-8?B?ZVFad1l3SFNjVUh4M1BMeFg4SDRUTVhGQkR1Nk15KzJvaXl6OHViN3lDUVh5?=
 =?utf-8?B?Tzc1WlFyN0RadE5yRHRhRWc4Um1wWmxIa3lycit4L2E1aE9QbTd4OEF2am1t?=
 =?utf-8?B?RlFMZDY3SzFUQUd0d214VHYzU000RGFCaE0wSmxxelRvdHVmWG1SMXB6VzRx?=
 =?utf-8?B?cmRvdW1Pb0UvdXBRSndnbHFGMG50NUwzVk00bXhJeFVjWWpPN1BKa0NSOFp0?=
 =?utf-8?B?TmZnQzcvRGsrYWhXbkVqa0ZHckcrV0E1TE44VGNUQzFzZEVBdmV0QU1pZE10?=
 =?utf-8?B?b1psN1ZGUkc2dlNXcmRYREZuVVZMNVFuK242ZEJ5U3VjVmdtYUlPVmo0RFdM?=
 =?utf-8?B?UkFhdmRocmE1YXFrblBHS0Z6dExUZzlsQ3BPYnd6TjFRSDE4MkI2NmUrMXcr?=
 =?utf-8?B?VHVmMXIrV0xvbVdVeHhZWVZmK3F5UGR0dld4V2lWVlRqS0lDK0JqNHllSlky?=
 =?utf-8?B?VXdYM3RJQzg2WTd1WlFXNnEwRWFUTEx2c2NwRjh3V2JEalk2SnlUaW9JZlJi?=
 =?utf-8?Q?q5J/gO35W8tYW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3NyL3BFek1tTS8vVzRzUW04dFVwdFRZb1NRMUgwdlBkTjBPdXlyY1hUVk9T?=
 =?utf-8?B?TFJYc1I4RkhNSzFhSmthOGVhYUZaL0tQVUpTOUE0RWc3ejI4a3hCcDhWWkN3?=
 =?utf-8?B?VGhIS3ZEamxSWjcvRjRSR3AzMGtiZUhSYkVyOVQ2djFYU0ZRQlkzYnBsZC9a?=
 =?utf-8?B?VDZDdDBVelV6WXNVUFVheE93bTBXMnRkTURPNFJTQ29tMVdiNzJCS1BIa3dM?=
 =?utf-8?B?bDhMbFZDTWlibVB5YWRrSktVUG12alJIeFF5bmZ5L0pyQ29XYmszYWtQSWNr?=
 =?utf-8?B?YndCb3RVKzhDM2hXVXV1eXFNUzVBeTBLeUVPMDZVak15NDZoK1htbmMwUS83?=
 =?utf-8?B?clVVTGxQZFFHM3poYWQrY1RTWFhRVDBJdE9iZ0xoajFQWmFWT1hkQTh3VVBt?=
 =?utf-8?B?aVVsUEx0azJrU3NTQnhXWE5hRmZQUHMwUE1pUEJSS1VrTjRCTnpaTDVJSm9K?=
 =?utf-8?B?MjkyeGJPWnN3ZVRuL3dydzVIaVE4alN1RW42U0J2MnlNekxtNEFra1ZpYXF6?=
 =?utf-8?B?a0JtM1FYbmxsMG5Xc0Yramd0WGJlcVZzcmlmQm1jOTRrSWEzTWd3bEJuOFpq?=
 =?utf-8?B?Q2ZJR3A3Ny8yVmQxVXVVd2Z1SkpQOFlJRTk3dzk4bUF4SnluU2MrSU9JdlUw?=
 =?utf-8?B?SDRpWm5yTFhEWFhONHVWOVdOeE9HQzl5M2VnZThBZUN3MUtOem9seldqVkIv?=
 =?utf-8?B?REt3b1kyekRielJVb2tWM1loaVNpWFVRRFNNQ3A1ck1DNUppeUVHc3pJaEln?=
 =?utf-8?B?WjkzT2hZOWFnRWpNN0FWOHVZc0RhckxxSWYxVkd0WFVjR3NPZXlQVm0rcG0y?=
 =?utf-8?B?WVhBQWM3V01tNFB3WmpHVEluaTRHVzY0MU9UOHVxaDNQUEZvNTVpVTAzUHZJ?=
 =?utf-8?B?V2tBMXg2TWZzQXEwSzVpalBySVNHc1ZiOHB6cW5zUndaZkx1SlFPOE00R2x4?=
 =?utf-8?B?dFpsMTg0dkZOMU84RzZOcTlLMjJKUEJ1MGtORkJ6NEY2WjJhQXZtK09LcEZE?=
 =?utf-8?B?Qnd1OFR2b0lQeEdqZVhlYXlLNGNNRlRGUDBUR2NWU21WUWhOdTZKMjNlMUdQ?=
 =?utf-8?B?UDlvckVSTlpoYkRtWFJ6VC9UcEdJK09oRjV6Z0doNFZVR1c3cEduR1lEOE5D?=
 =?utf-8?B?dWQwTDhjNU45WllBdysrUHVxMThHZk0vRzdNK28vQUxkcWJtUW1lNWo2V05U?=
 =?utf-8?B?ajlqVWdvUGp6bUE2aTlSd1RocU1VMmY4ait2M2V0Tm1acnovM21tRG4wbFo0?=
 =?utf-8?B?dDdaQTg1aXM4ZGdKTGNISjEzVGxzenNhak92K09aV0lUaGNFcnN1cW9QSVc3?=
 =?utf-8?B?b0s4MFpqYktzTTF6VzJ4R3F4cHJURnY5ZndRR2kxVmJ5N3lpNGplYVZTY3NS?=
 =?utf-8?B?aWtka3UxU1U5NytOUENZSThxeUErTjkrZmpQaktMRUdCdnZTN0REbjl2TzNS?=
 =?utf-8?B?dng1T2l1OE5XYTJUZ3Q2T3RXYVdIb0wxd3hBV25IZUlOcEFpM0pJOEhpUjBW?=
 =?utf-8?B?VUR4RVBmWHhvZ3ErQmVyMVNrcml3SldycFZOZm5tREV3ekR3Tk5ITE10Qi94?=
 =?utf-8?B?OEpIYUdlVmpyOU9ZTU5iUkpiY0VhMkZ5OTdsaUMxeGQ0SGJ1WTBjSUxzL3lE?=
 =?utf-8?B?Vkt0MmJsR0YyRVVDeTBtamZOWlAzekpRY1FER3E5cmRmRXVsNFNtM2hSNVpE?=
 =?utf-8?B?UHA4WHZRSnpCaXJUZW9VMHJQakJ1Z2tPcWQxb1Y1Y0Vra1Z2NEl2OHlwanFs?=
 =?utf-8?B?OWNuWlEydmhsR3dvUGZWNUErU1N4SlVvSnd5MnhGak81cDBpb1c3TkhLRk1G?=
 =?utf-8?B?b3RVbmpUdHE0N0JNQmFvdUUwbkdhdndIQkxQcE0xS0xVUlM4aUc3TnlNZ050?=
 =?utf-8?B?UjAwVThPZXhVRFN6RnBEdHRZRkRIVzVsaFlsVXFaTVg2SG4zMjFwUDBrbUha?=
 =?utf-8?B?S3MwdEwxdXFwNExNbWNCMStwMnJNQklpcWE4Mk5EaVB0VG5GeXZKMXppWHRw?=
 =?utf-8?B?S2dhL0lFaWZ0U1pHTE9jSlpTNFdDenJEUGRIL1NrZFI0MUtqcmZBOHBIbkpw?=
 =?utf-8?B?MWpta0RNSU9lRFU2Y1ZnakVKbzRqRkRGUHE1TXBxSmEyZ3hpVmROd2NsZjhR?=
 =?utf-8?Q?y5EeF2jiby3V/Xz4RxMe/doeJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 17792094-dcb8-4970-588e-08dd628907b0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 23:44:43.7040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nn3W8enZtqGEl/NOc8Sn+Dyr8NpR4myM0fkddeBzs40QONTFIyjAMiJpzz/oGDUs2ooeZmHQ9sfWE3n3IWCeuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7975
X-OriginatorOrg: intel.com

On 3/13/2025 11:22 AM, Brian Gerst wrote:

>  SYSCALL_DEFINE0(ni_syscall)
>  {
>  	return -ENOSYS;
> diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
> index 8cc9950d7104..7c286e89fd04 100644
> --- a/arch/x86/entry/syscall_32.c
> +++ b/arch/x86/entry/syscall_32.c
> @@ -1,10 +1,23 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/* System call table for i386. */
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * 32-bit system call dispatch
> + *
> + * Copyright (c) 2015 Andrew Lutomirski
> + *
> + * Based on asm and ptrace code by many authors.  The code here originated
> + * in ptrace.c and signal.c.

Wondering if we can skip copying over some of these old comments? As the
file grows, it's hard to discerne what specific code originated where.
For example, the FRED code is all new.


> +#ifdef CONFIG_IA32_EMULATION
> +static __always_inline bool int80_is_external(void)
> +{
> +	const unsigned int offs = (0x80 / 32) * 0x10;
> +	const u32 bit = BIT(0x80 % 32);
> +
> +	/* The local APIC on XENPV guests is fake */
> +	if (cpu_feature_enabled(X86_FEATURE_XENPV))
> +		return false;
> +
> +	/*
> +	 * If vector 0x80 is set in the APIC ISR then this is an external
> +	 * interrupt. Either from broken hardware or injected by a VMM.
> +	 *
> +	 * Note: In guest mode this is only valid for secure guests where
> +	 * the secure module fully controls the vAPIC exposed to the guest.
> +	 */
> +	return apic_read(APIC_ISR + offs) & bit;
> +}
> +
> +/**
> + * do_int80_emulation - 32-bit legacy syscall C entry from asm
> + * @regs: syscall arguments in struct pt_args on the stack.
> + *
> + * This entry point can be used by 32-bit and 64-bit programs to perform
> + * 32-bit system calls.  Instances of INT $0x80 can be found inline in
> + * various programs and libraries.  It is also used by the vDSO's
> + * __kernel_vsyscall fallback for hardware that doesn't support a faster
> + * entry method.  Restarted 32-bit system calls also fall back to INT
> + * $0x80 regardless of what instruction was originally used to do the
> + * system call.
> + *
> + * This is considered a slow path.  It is not used by most libc
> + * implementations on modern hardware except during process startup.
> + *
> + * The arguments for the INT $0x80 based syscall are on stack in the
> + * pt_regs structure:
> + *   eax:				system call number
> + *   ebx, ecx, edx, esi, edi, ebp:	arg1 - arg 6
> + */
> +__visible noinstr void do_int80_emulation(struct pt_regs *regs)
> +{
> +	int nr;
> +
> +	/* Kernel does not use INT $0x80! */
> +	if (unlikely(!user_mode(regs))) {
> +		irqentry_enter(regs);
> +		instrumentation_begin();
> +		panic("Unexpected external interrupt 0x80\n");
> +	}
> +
> +	/*
> +	 * Establish kernel context for instrumentation, including for
> +	 * int80_is_external() below which calls into the APIC driver.
> +	 * Identical for soft and external interrupts.
> +	 */
> +	enter_from_user_mode(regs);
> +
> +	instrumentation_begin();
> +	add_random_kstack_offset();
> +
> +	/* Validate that this is a soft interrupt to the extent possible */
> +	if (unlikely(int80_is_external()))
> +		panic("Unexpected external interrupt 0x80\n");
> +
> +	/*
> +	 * The low level idtentry code pushed -1 into regs::orig_ax
> +	 * and regs::ax contains the syscall number.
> +	 *
> +	 * User tracing code (ptrace or signal handlers) might assume
> +	 * that the regs::orig_ax contains a 32-bit number on invoking
> +	 * a 32-bit syscall.
> +	 *
> +	 * Establish the syscall convention by saving the 32bit truncated
> +	 * syscall number in regs::orig_ax and by invalidating regs::ax.
> +	 */
> +	regs->orig_ax = regs->ax & GENMASK(31, 0);
> +	regs->ax = -ENOSYS;
> +
> +	nr = syscall_32_enter(regs);
> +
> +	local_irq_enable();
> +	nr = syscall_enter_from_user_mode_work(regs, nr);
> +	do_syscall_32_irqs_on(regs, nr);
> +
> +	instrumentation_end();
> +	syscall_exit_to_user_mode(regs);
> +}
> +
> +#ifdef CONFIG_X86_FRED
> +/*
> + * A FRED-specific INT80 handler is warranted for the follwing reasons:
> + *
> + * 1) As INT instructions and hardware interrupts are separate event
> + *    types, FRED does not preclude the use of vector 0x80 for external
> + *    interrupts. As a result, the FRED setup code does not reserve
> + *    vector 0x80 and calling int80_is_external() is not merely
> + *    suboptimal but actively incorrect: it could cause a system call
> + *    to be incorrectly ignored.
> + *
> + * 2) It is called only for handling vector 0x80 of event type
> + *    EVENT_TYPE_SWINT and will never be called to handle any external
> + *    interrupt (event type EVENT_TYPE_EXTINT).
> + *
> + * 3) FRED has separate entry flows depending on if the event came from
> + *    user space or kernel space, and because the kernel does not use
> + *    INT insns, the FRED kernel entry handler fred_entry_from_kernel()
> + *    falls through to fred_bad_type() if the event type is
> + *    EVENT_TYPE_SWINT, i.e., INT insns. So if the kernel is handling
> + *    an INT insn, it can only be from a user level.
> + *
> + * 4) int80_emulation() does a CLEAR_BRANCH_HISTORY. While FRED will
> + *    likely take a different approach if it is ever needed: it
> + *    probably belongs in either fred_intx()/ fred_other() or
> + *    asm_fred_entrypoint_user(), depending on if this ought to be done
> + *    for all entries from userspace or only system
> + *    calls.
> + *
> + * 5) INT $0x80 is the fast path for 32-bit system calls under FRED.
> + */
> +DEFINE_FREDENTRY_RAW(int80_emulation)
> +{
> +	int nr;
> +
> +	enter_from_user_mode(regs);
> +
> +	instrumentation_begin();
> +	add_random_kstack_offset();
> +
> +	/*
> +	 * FRED pushed 0 into regs::orig_ax and regs::ax contains the
> +	 * syscall number.
> +	 *
> +	 * User tracing code (ptrace or signal handlers) might assume
> +	 * that the regs::orig_ax contains a 32-bit number on invoking
> +	 * a 32-bit syscall.
> +	 *
> +	 * Establish the syscall convention by saving the 32bit truncated
> +	 * syscall number in regs::orig_ax and by invalidating regs::ax.
> +	 */
> +	regs->orig_ax = regs->ax & GENMASK(31, 0);
> +	regs->ax = -ENOSYS;
> +
> +	nr = syscall_32_enter(regs);
> +
> +	local_irq_enable();
> +	nr = syscall_enter_from_user_mode_work(regs, nr);
> +	do_syscall_32_irqs_on(regs, nr);
> +
> +	instrumentation_end();
> +	syscall_exit_to_user_mode(regs);
> +}
> +#endif

Nit: Would it be useful to add /* CONFIG_X86_FRED */ here since there
are nested #ifdefs?




> +#else /* CONFIG_IA32_EMULATION */
> +
> +/* Handles int $0x80 on a 32bit kernel */
> +__visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
> +{
> +	int nr = syscall_32_enter(regs);
> +
> +	add_random_kstack_offset();
> +	/*
> +	 * Subtlety here: if ptrace pokes something larger than 2^31-1 into
> +	 * orig_ax, the int return value truncates it. This matches
> +	 * the semantics of syscall_get_nr().
> +	 */
> +	nr = syscall_enter_from_user_mode(regs, nr);
> +	instrumentation_begin();
> +
> +	do_syscall_32_irqs_on(regs, nr);
> +
> +	instrumentation_end();
> +	syscall_exit_to_user_mode(regs);
> +}
> +#endif /* !CONFIG_IA32_EMULATION */
> +

