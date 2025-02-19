Return-Path: <linux-kernel+bounces-522699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C1CA3CD8C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209BD3B343A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3097025E471;
	Wed, 19 Feb 2025 23:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T4KlnsXi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651471D7E30
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 23:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740007796; cv=fail; b=HpwVbSqAhWSWmhrQnItTlHvU3b90165cW1j+fNM5ZJWk193k7knbDgmbPkcdzT7iDMsa+p128JrnnYISzDUx7eq24h/PiPWWL9KZH7BMIi/Ge/HgIbzobWPepP2ufR98ascaQ3nccIkCXbs9PMzgRwidVuC2cgYBRYPYSOz5itA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740007796; c=relaxed/simple;
	bh=n8HQXyxt4nIMCbNcopjfcGrdyoD+JxDYqSARSGKW4Dw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iD/qJG+tNQXtViZK9RD13+ITe+A27hEKeq7OdZV+a4AnLQQWqFRZvzQNOtAtYWKzTh0JmCHraM9jjkR1lS/v6nVt1Wd5BsVubjTfoQzZoJKoMgljClnZmI/OV2WRnkjKJrmd7LhkNrHKpjdvWwNq5X4DFGocJ15jsUoeIY21mig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T4KlnsXi; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740007794; x=1771543794;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n8HQXyxt4nIMCbNcopjfcGrdyoD+JxDYqSARSGKW4Dw=;
  b=T4KlnsXiLNT16wFQYUzptvgwyEzCo5YWsMO3g+7DfQDHH6JjfPU0SZ4v
   vCXL54sF4tSkPq9q6Lbp2HwSHEkdiKu5uWiALy7Z6D3sEetEX0ltk83Lb
   tt5TZV8d1WQ3/PBFt0AH7Ccw61894em0t98x1nABQz6ah48UpwA4d3b1k
   95pasPMwbbF5CjamqDPh5tE0pb6gTvaqlhVi7iBE10/L//NU81SvtcRFp
   hSLHCrdBJppdEwckPxZwH5q5SPAwng89FFNf8J4yhKWa+9NbHnzpIrJta
   EWGbx1ggm2sS3ArFl2wGCzO2xFVg4mZ9Qy5f5DqkEbKaNmODVV16ly+ta
   g==;
X-CSE-ConnectionGUID: ++tTBYMMSvyYD3DDxp/u0g==
X-CSE-MsgGUID: WNTJhu5cQxCfBJ2LGPdYUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="51388498"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="51388498"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 15:29:53 -0800
X-CSE-ConnectionGUID: wj8BEzgeR4erlBfLoV713Q==
X-CSE-MsgGUID: gQc67Fr4Ty68wWTxKNTvCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="114848167"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 15:29:52 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 15:29:51 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 15:29:51 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 15:29:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZGvQo7FB8oqiBn2AA/flZphUYM8ecPKYqBui4p5HCRWy55lhtLbe+VF3y9ogWNVlYVELrvrnFh61pF5SiB4XuXlmioAXcud2WcHo2+gJj6i71w20YNOmAm5x1wxeSjXVKQzc/o1HNi/ijkH19FTEUx6zKnw9wxVFe30f/XoKIxBOU3xiitjJva7NovJFHtZX+XGzJiIrDQOUvJjKQ133yRs/hboeX2JR98Jy8h6Au6Ra7xHfIk2GQ1u6F4cKIL4RKJx6f8O9qzRdoq8q1aRUcaPe8H6wAyXSkh3Li71RXKqEdiodbhY73eB2El/7s8jXkgklaRV2cFJ7kWNBCFsDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aws0QSJAEICc19MbF0pH7OxY9RJ5OipxRHzz3yyUBrc=;
 b=asSi548nah1EjEDxlB+vS3r+WjBRO79XbEsQiZ7FYCVA79h2L7IxBDuKw/xfk+Xw9cWTOVNnkuP6ykiH4GW2WSag3vb1IiBbe1QS8u+MDjuh/KdkFbS2sKoPAyCaz9MgiVa78g7F49avWr7RWzq1tQFLd5NNbThx7vARsMe5GmGj5oWt4t6QKueDLwlSH4X2QeMEQ6hfaqlQe8K/0ziDEkHcB8R4aHZO3vVwChWAQQ1r5efmqHnXOiQ7QQzmoywLK/TsCYzTBGR4XW4szUwsPQ3IDx41pZJuHIg87FaxnDQfOx/LAyiAhMVQpEzV6P79gyirZpFQsae9yo6NIMCP4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB4975.namprd11.prod.outlook.com (2603:10b6:a03:2d0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 23:29:47 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 23:29:47 +0000
Message-ID: <8ff43700-25f4-4606-ba99-3ed71721d9fe@intel.com>
Date: Wed, 19 Feb 2025 15:29:45 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/42] x86/resctrl: Move resctrl types to a separate
 header
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, Shanker
 Donthineni <sdonthineni@nvidia.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, "Tony Luck" <tony.luck@intel.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-14-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20250207181823.6378-14-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0273.namprd04.prod.outlook.com
 (2603:10b6:303:89::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB4975:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fbdc51d-6642-4de7-f6e9-08dd513d4c8e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WlJoN1RoUzU2Yk5qNU1tQzEwMDlEQTYwYmlQMnphSkYzM3kvZngvN1gwNXRx?=
 =?utf-8?B?V0RvckZ0U3g4UkVIeHhJYWhKSU54ZVcwaGFSR3FsL25MMStVYm5wVVJUSWkr?=
 =?utf-8?B?R2ZTMTdMSlhVV1R6ZVNVeGx0VTRwUlBRZk9Wc1EzZjBkUWJWSmtHZ1I4Y0ov?=
 =?utf-8?B?bENXMjFlM05ueS9lamcvNW44c3BhRU5QRXc3Tm1XT1pBenFhSGljU3dJb2Ji?=
 =?utf-8?B?OXBNQ0N5M3B0MjZycGF4bGZxUzJpZS8vUDd6VXpUOWlWRGdGRzVlTkZlc2tN?=
 =?utf-8?B?aFRzVVJjbjRJM1E5Z0NzZVRnVXlNRjd0K2w4Mkt3Q1BkdjBOTGlxM0h0am93?=
 =?utf-8?B?aGNsMVdNZGFGUGZ2U3ppZGhibklUOE54NzZNektoSktoLzVjbnkySXg1ZEhU?=
 =?utf-8?B?K05uNEh5aFpmN1dQaEtRdVpnMXhlRkd4MTBzYXkyYzMvOUFKbDNkalh2QmV2?=
 =?utf-8?B?VlZEcnBDd3Bxd290SXAxNGdkTkE3akdlc2pTbTU1VjZ2VjhlWmxtUWZ2KzNQ?=
 =?utf-8?B?M1ZOZmlBbklnemRydUlHWnZvQ2dGdGE3N1l1MDVKZ1QrNmxLSnQxdlQ0VkpU?=
 =?utf-8?B?ZVl5Z24rOE8rN3VuYlIybFJiRVVrb1ZGZTdQby9GeS9Ham02c0ZlZW5iSzB1?=
 =?utf-8?B?Mzh5NzNHZjBLaFBSOGhFWW1HTTk0SUNGemEycWw0TnhoaDdtTktOM3A5T2t0?=
 =?utf-8?B?SE9LVTdLMUVIMUpBZ29PQ0RjK1R3NVJEcWIyU3VDQittVko4N3FXUVhEalRj?=
 =?utf-8?B?M2ZGckpVNllJOHRvUE5kV09Wc0loSy9OaXI4MkdZS0ZlUEFpQktYbUtuRTcy?=
 =?utf-8?B?RzZNNE8xaGtLMDJhYWhRYTA1Z21xcjFXaWZBS2prNnhRV1lOazVnRnVJVVlM?=
 =?utf-8?B?RERUNExKU004SkhVZ0ZJZWVWbWlhYWtEUjZMT2NMZ1JGdUhhYkhHYzRTeUJz?=
 =?utf-8?B?NzRGOEU4UUdHSzRlZEY1RUNwcHRteXJ1OFpXYUZDamF3Y1pzYTErYVhYWm9Y?=
 =?utf-8?B?Mng0eUxSWnY2V0RQYmZGWTNLZmJRQlZPSHA0QmF0bUE1Y3JHRHM5K3ZIZG9q?=
 =?utf-8?B?WmlTczdTRCtzRGxMM0xOWHFVSWRPUTRqRmwzM3gzdTFuR3M2Y2NGTGN2cjJT?=
 =?utf-8?B?UnoxL2k2NHcrRDZDM3k3eTBVMEVQOUZzSGV1L3hqSDluSkhRRWMzczBlZ0Rt?=
 =?utf-8?B?d3l3TkVjWnZibEVpRnFRUVYyeTY0SmRPaklOSERRd2xzM1pzQlU3dGVxcGE2?=
 =?utf-8?B?WnhDQm5sVCtBdkZITWpRS1JkMi9KZ1lPRHN3NlVvRmlUbUNQM0QrK21HUVM5?=
 =?utf-8?B?eCtPbzZxTHJ0MXB6TDc1cHl3TjZMTHRmc3FwSW1Kd3dDbE9xcTh4blJ6WUpR?=
 =?utf-8?B?ZllpeGMybWdCSUpBM3gzN1U5R0ViMjVuUFJPVlNwdkh5WXVPMmpiQUhickI1?=
 =?utf-8?B?emFNdEpKSEl6Y3JBR0dDeHZxaHFvVW1sS08wajhNSWdnUExnNnpEc3ZMYjJn?=
 =?utf-8?B?QitsK3NaMUVTRGI0dkxCWGJBR21pYkJoTjUvUG5wdk1yTHFZYW5jVGZndTZQ?=
 =?utf-8?B?eUs3NGc2QkRjdjNsY1A0UzRlUEdHQUdEdkNEdHcreDQ2QWROK1EyUFU4WHRl?=
 =?utf-8?B?eHhRWno4TlNZS3JOaTEvL1Z4d1ViMEptRDRJWUEwUzAvMDFnMm45NFFzR2d0?=
 =?utf-8?B?QzBlcFVPcno4T1owU2wyNWdYWmVQV3pEK25yNFBpZXZWa1BmenRCNjVpVFJQ?=
 =?utf-8?B?cVJ4cXYwT3lQWW9hZk56VFhJczUvRFpYRklmK3FjN0NGYlhvMmFvUkwveS9y?=
 =?utf-8?B?ekxzVTRMMFVOc3N0cTJ0TThwdUVqbWNINEhiUDJTQVFPZUZmNXVGZHNjT3pt?=
 =?utf-8?Q?Jxibi5Jg1OpWN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVNZamdRZTFTZ01HcnJEY3ZwbnR2N2VWbUZxTHQxR0lWazdwODdUTFJHZzN1?=
 =?utf-8?B?MmlaV1RzM2hhUnZIQjdReFVYWHFsN3NheXNIck9zVWpqNnhTNlAwd01FV09w?=
 =?utf-8?B?MjEwNXhYNC9heFhIamVkMENNZkVzNUo5N0ZwQ0xRQ2podEl4Ync0Wmx1NG5u?=
 =?utf-8?B?VjJNSHpXbUpFcjgrV2Rwd2lPUThXQTVnMU9Wb3lzS0dwMm9ncmkzRURtY0V6?=
 =?utf-8?B?dFNrY0F3VVkxUFJXVlBFd0JkamJKbWlRV2Z6L2I5T1JkelU2bW8wZkFCSDVN?=
 =?utf-8?B?RTFLMjZ0Y2tHaFBjRUhLQnVRbTl3bnN1Z3pEY2srN00xRWhOOEtmQVlsMmVB?=
 =?utf-8?B?UmRjT1htaGs1RmlTWS93UzZnNlpMU0RIemdVaUpzTnZSK0pncmxvZ212Zitt?=
 =?utf-8?B?aDhXV3JmeVhIc3BPRjUycWltZDdCdDA0a0ZCMnZIZ3Erc2RYVkdwM2FSOWdt?=
 =?utf-8?B?LytCcmkrYTNOa0FxOUZDSVZHaVdXWFlCRUpGcU43YW0zK2xFc3I5L0hDckVZ?=
 =?utf-8?B?U28rVitpRUhPUGt2cmtZQXkxbTJKR0YwSDkrYWFkSlp0c096Q1ljWFZEcmVj?=
 =?utf-8?B?MEtkNkhMalA3V3l6QzAwNXY2Q0Q5RWxOZC8yZjZJY3JmVS9pRDI0SE9kU2dJ?=
 =?utf-8?B?MDF0RUJIRXJvdC9DMW5tTE9RbG9lWXhRTGNJSStxU05IaW1ZTGtvZ2JzRXJk?=
 =?utf-8?B?SitQUkZUVHZuSC94UDZJcUYrSWNjNWNqTGNpVWoxcm9TajExMnFRUFo3UjBu?=
 =?utf-8?B?WEtrelJlT2FyRzdTNDRzVXJqanhIVlZLWU9yK2JERmEra1NQTkUyazl2RllH?=
 =?utf-8?B?WWQxUUh6elpUWG02RmYyL2RuZ2QyYXFZQzJIamFqRldsT0NuN1FzZndBcXFi?=
 =?utf-8?B?aVdWTGk0SVUrVXhGWnhwdkl5bTlPOTJyNXY3Vmszc2xiNjJMYVFRSEdGUWIv?=
 =?utf-8?B?N1pibkVpeFgvNWxVcnp1M3ZWdmRYaHNBb1FXK2pjcWRMYktTbTdwVXJNNUg2?=
 =?utf-8?B?K200RE1aY0hTNXJpaVVoVHNMQi9CSXBYSEgvdzVTMkduNDk1NGJ5eHQvcmov?=
 =?utf-8?B?ckdrUkZHeFJJT3l0b3hsUmVDRmtDcldmVjdaenVCTWpaUVBOaGhsTldFQVlV?=
 =?utf-8?B?VFp0eHpsTS9aK2pLT0NpRFAzSnVFTW5HL2Ztb2J1VS91eGpyWU1vWTRTRkMx?=
 =?utf-8?B?azhXUHR3SzZSd0F3SlY2SEc3OG16bXQrNFlBM2QvTUdTcnY0Rlc0Tjgranhw?=
 =?utf-8?B?dTZ2WlZRYUo5WWdaNjdTLzlrZlg3Rmh3VDd2RVR0ZXJDem00YTdyYmNvS2Iy?=
 =?utf-8?B?YkI5elNzYWpqKy96RlI2YnlLYy9jQ0dINStTWGMyaUQ3OURpZ3NyMVU1WE4x?=
 =?utf-8?B?VGVmcWN4VEp1UzFGd3Uxc2FEYmRpWFJYWHliNG52ZjlLU0RaUFczZ2JBT1dS?=
 =?utf-8?B?V3NCOEN2d0VDR0NhY0NpakdrbzJ5aWI5bjFLQWxSdHZzOHAzWExtNEg4cFZq?=
 =?utf-8?B?N0d5azZQSkdlU3BPY05jR3d6ZTZqMldyeE9oR2g3M1ZYVkt0d2FwRi9yeGJu?=
 =?utf-8?B?dVhWNnlqQ1VGU3ZmQjdmL29jY2NyYUdrQnNIZ3dodFR4enJDRk9jRHJNek56?=
 =?utf-8?B?aVl6WTR6d2RITGRYVlF1Mk5yMVo1OVN3anhpZndqMGtaay9zTUZpdVBtNnJx?=
 =?utf-8?B?UENIQ2krb0xGSkZ0UCtjUGYxS29vQmNsRnU2U1M5T2drMWhZSTd3cjVwVERa?=
 =?utf-8?B?dFoyUHFWTTVQVUZ4dmJQVTVoYU1DQUZKOWNPUnJ6ZDRzRjlGYkgzajlYZ09X?=
 =?utf-8?B?N0w0S0w5TVJrY1YyZXZWWkRySXZ5RVJvZTdlemxXV1RPWmtzR3FGM0N5TThT?=
 =?utf-8?B?V3NqN1Y2S3Z2blFab0NaNEFGZGZCaDR6bUJpNlM4cVhjMjZ1ZXhnS0RMUmdI?=
 =?utf-8?B?U0l6RVJONkZ4b045eHB1ckY1T2VqcDdlWEN1VGdvdDl0alVTV2c2b1c4VC9p?=
 =?utf-8?B?UGNTL1VhdGZQUmtkajV5QTNxL25FNWpGU1FWR2MvYWNCQTJqb0dJWWFhV3FO?=
 =?utf-8?B?KzA1VnY0c1N2YUpTNlBXcUpSWndxbElvcmRxUElHanBNaXNjdTNxWlpBanY5?=
 =?utf-8?B?RlBwNUZ6M1phN2puOEJpTmhtMkhOaFFKOGkxSDZIa2l1RXUrVGsvdE1zRkhM?=
 =?utf-8?B?QVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fbdc51d-6642-4de7-f6e9-08dd513d4c8e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 23:29:47.7433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qRpu8XT7fmf08A3r2PCHvoGVDI7Tu6GpMN1CeJrTX5rv7EPmbqB3SXQ4+pPCC3Vckki/70Am0O5NAgr5selKWA8Y2uL2zjM1P+Glq+qWQtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4975
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:17 AM, James Morse wrote:
> When resctrl is fully factored into core and per-arch code, each arch
> will need to use some resctrl common definitions in order to define its
> own specializations and helpers.  Following conventional practice, it
> would be desirable to put the dependent arch definitions in an
> <asm/resctrl.h> header that is included by the common <linux/resctrl.h>
> header.  However, this can make it awkward to avoid a circular
> dependency between <linux/resctrl.h> and the arch header.
> 
> To avoid such dependencies, move the affected common types and
> constants into a new header that does not need to depend on
> <linux/resctrl.h> or on the arch headers.
> 
> The same logic applies to the monitor-configuration defines, move these
> too.
> 
> Some kind of enumeration for events is needed between the filesystem
> and architecture code. Take the x86 definition as its convenient for
> x86.
> 
> The definition of enum resctrl_event_id is needed to allow the
> architecture code to define resctrl_arch_mon_ctx_alloc() and
> resctrl_arch_mon_ctx_free().
> 
> The definition of enum resctrl_res_level is needed to allow the
> architecture code to define resctrl_arch_set_cdp_enabled() and
> resctrl_arch_get_cdp_enabled().
> 
> The bits for mbm_local_bytes_config et al are ABI, and must be the same
> on all architectures. These are documented in
> Documentation/arch/x86/resctrl.rst
> 
> The maintainers entry for these headers was missed when resctrl.h was
> created. Add a wildcard entry to match both resctrl.h and
> resctrl_types.h.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---

...


> diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
> new file mode 100644
> index 000000000000..51c51a1aabfb
> --- /dev/null
> +++ b/include/linux/resctrl_types.h
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2024 Arm Ltd.

Please note year.

> + * Based on arch/x86/kernel/cpu/resctrl/internal.h
> + */
> +
> +#ifndef __LINUX_RESCTRL_TYPES_H
> +#define __LINUX_RESCTRL_TYPES_H
> +
> +/* Reads to Local DRAM Memory */
> +#define READS_TO_LOCAL_MEM		BIT(0)
> +
> +/* Reads to Remote DRAM Memory */
> +#define READS_TO_REMOTE_MEM		BIT(1)
> +
> +/* Non-Temporal Writes to Local Memory */
> +#define NON_TEMP_WRITE_TO_LOCAL_MEM	BIT(2)
> +
> +/* Non-Temporal Writes to Remote Memory */
> +#define NON_TEMP_WRITE_TO_REMOTE_MEM	BIT(3)
> +
> +/* Reads to Local Memory the system identifies as "Slow Memory" */
> +#define READS_TO_LOCAL_S_MEM		BIT(4)
> +
> +/* Reads to Remote Memory the system identifies as "Slow Memory" */
> +#define READS_TO_REMOTE_S_MEM		BIT(5)
> +
> +/* Dirty Victims to All Types of Memory */
> +#define DIRTY_VICTIMS_TO_ALL_MEM	BIT(6)
> +
> +/* Max event bits supported */
> +#define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
> +
> +enum resctrl_res_level {
> +	RDT_RESOURCE_L3,
> +	RDT_RESOURCE_L2,
> +	RDT_RESOURCE_MBA,
> +	RDT_RESOURCE_SMBA,
> +
> +	/* Must be the last */
> +	RDT_NUM_RESOURCES,
> +};
> +
> +/*
> + * Event IDs, the values match those used to program IA32_QM_EVTSEL before
> + * reading IA32_QM_CTR on RDT systems.
> + */
> +enum resctrl_event_id {
> +	QOS_L3_OCCUP_EVENT_ID		= 0x01,
> +	QOS_L3_MBM_TOTAL_EVENT_ID	= 0x02,
> +	QOS_L3_MBM_LOCAL_EVENT_ID	= 0x03,
> +};
> +
> +#endif /* __LINUX_RESCTRL_TYPES_H */

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

