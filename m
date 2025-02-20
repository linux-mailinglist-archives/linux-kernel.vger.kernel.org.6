Return-Path: <linux-kernel+bounces-523009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBA4A3D0F3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7228717CEEE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E931E32CD;
	Thu, 20 Feb 2025 05:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QRzXq900"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541C3198E81
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740030053; cv=fail; b=XGn8thra5VSsbOt4n1OPiymjfSDDyspU0ZWPYWU+c7TXf0Aa/p5oZI4lw426vthbtPXl+/IRrn+SgxKxctEIqgQJFGdc8GryOiil8ffHm26EzWQaK6Ge2j6JUy9lkb2Rr38INs5ZdEy9FHGQATiH8ll9GdVlxnR7bcJLsU2l6YA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740030053; c=relaxed/simple;
	bh=EgUDVloe5/KlSKV90g1xe4s2vsoA42FQNUoVxSp93Vc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WBYjgPaPIP0oz9aV3ghDbln4pSs/ZwnWgTmjBaXea2UJOhMpfyw211KhA0mWJKVjIm8sLxUdZj6n1KxjDQAzNwreq0LNFxadC5QtGqY3gfgYTAMGUG/ubGky5TeJsrwqNkHRhoWvg/Yzmryw2PT7hgHj8ywzdmmtXrC46165jpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QRzXq900; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740030051; x=1771566051;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EgUDVloe5/KlSKV90g1xe4s2vsoA42FQNUoVxSp93Vc=;
  b=QRzXq9005ClaPaGtf2CUh0MzXrqmBt71c+f9unweSQPPrX3eEGtyc+wc
   IhTPLBe4mM8QGmAyOB5PlU5+sSzA/r6myOOjQUfkjPTigIljLBFaUuYz/
   oVBMABshPQNf8jGBTxFBQyuToIvc4OeA0hkHcN2p7Oh2lAPH6Lg2YzSXp
   3Z2iF5VpoW+UlOsbFYfdpEbe/edGLK6D2JzHa22W/pKgWAOGbnF0TTm8e
   lK9muJ2KTny6fw4g3rU6H10Vr8Yo+fjjR7LFujIb1R8Q2T5BvHzMyb+32
   TQSkKuKCKxZH0cJitXMEA5EOjItTHDD7OUE8xwUdHPoanpNFndG/UZ4ep
   Q==;
X-CSE-ConnectionGUID: RnVWuwzxRr+ik1gxGJcSvg==
X-CSE-MsgGUID: 2lRedATAQYG5bTfWZTpxuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="51412657"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="51412657"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 21:40:50 -0800
X-CSE-ConnectionGUID: Vez+BrIlRJWG88BIV5ny0Q==
X-CSE-MsgGUID: nXbXUP+ISs+UQ1z4zlikxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="115476574"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 21:40:49 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 19 Feb 2025 21:40:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 19 Feb 2025 21:40:48 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 21:40:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tye4BGx50C4N0HaXVtbZIo4bJhsHoSsgT9CnkzjY2NE6vhViac1uNIIceh4Dh0CBWv5giJDrQYeKTVRdbarM0/CSypVOS3NRGSQssRte5yE/2AloVPCxGaK+oZSbjHDa9r8XKdH3kPtielgdPbvD2b0ACBokg1Q7fn1BsutkIetDy2vMXiGSVk2YlqUbRUx+lv658NHgW2W/Cqv1Z7YfIKcSybQzKlnTZU7md1ivXO+AV/K/2FJZPuc5BLr2DiCgLUo/hd/UjcD17Sc/p95Y39kl60zCJevxWixCLMqVeRjm/bdjVz5otQ9kwjj2GpNUL3ro7K1wEU7Fr5HCtv3XEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMOqvzVZeySE7lHts/NTc9K1dN3KmGjakM0Wp+WPiak=;
 b=WAZPs2Dde+bMLiwic44Am6FDTmpoATEC0U5tbFwXhClQUbrAjgIKVPSZa5lkGwpTLgAQERA533Pje+HC4Ob8uojslRokfjbM4F0L7rIyAwW0sSxH6iJubFsPpEFGQzpDKUCwWF8+tpCJLcUoCB2KGcanBJbTLBsRzj5qRZupEOk6iBqf3LGvpH+ARrYhR1iG1vbR3FVveuzZYsMOyZPgamGli+Z3DXcgsf5Jg5KatpIUZOHEnihwQUzyYphQw0xDC7OreOv2FXq6kK2u6BG5oqzGjtD6VcVL4zwfPmNcSgWql+St6Srio0SfaF9MLMLUG22lB3glIUZ7pdCZQX5BQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB6791.namprd11.prod.outlook.com (2603:10b6:a03:484::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Thu, 20 Feb
 2025 05:40:31 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 05:40:31 +0000
Message-ID: <bf7e9acd-01f0-4011-80e3-c11c0298fd73@intel.com>
Date: Wed, 19 Feb 2025 21:40:28 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 37/42] x86/restrl: Expand the width of dom_id by
 replacing mon_data_bits
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
 Donthineni <sdonthineni@nvidia.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-38-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20250207181823.6378-38-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0244.namprd03.prod.outlook.com
 (2603:10b6:303:b4::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: 53c94a12-700c-41e9-a638-08dd517116b7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NHN1VG51Z1VuZGNPRERHYUVmck82RmJ4NC92dUIyK2VNcm9VNHpPOEhGMDk3?=
 =?utf-8?B?dldaWExsWWpQSjBJa2FlQUR2cDh6OXJnOEtWTXdoOTh1WEVxZ1pzMHZNZ2Q3?=
 =?utf-8?B?TGxtVkRVWFgrWFFlOUM0dG5iNmUvNWsyc21lVTE3UFNwWDlyNURlT290S0lO?=
 =?utf-8?B?QW02SVNTNW1mbTRsaEwyWTZpNjlpSnRwWVBKQTNvUTNMbXhLenZwQUJDQyth?=
 =?utf-8?B?ejUwMTdqNHdrMXJTeUs4bEtqdGdLTHhTY1FURnNaMXZOTVpCaHRUQ01pUTRG?=
 =?utf-8?B?REZtakVpMXRYVmR6UHRKWFZhK2FlSG1pNlEwY3gwdDJwMEZrei9NbWNVVFNz?=
 =?utf-8?B?NlgrWmluZGgyWFVkNnQ5bEJFaklNVStmUWkxOXJNaW9NY3FqUWpIUngvQUJ4?=
 =?utf-8?B?cXRzY3VPNDAvVGFjZVRHRVdYK2tlajlKS2xYZE5MSXNhKzl6OVlzSjdQeklC?=
 =?utf-8?B?UGhTdjh0cFQwcmxQaFNmNGlUQW1xck1kTXdCTko1V2V4L09LTm1uK3Q4RmJQ?=
 =?utf-8?B?SGxBaGdVKzJJdVorMkx4aVpJMVRiM3cxdTJna1JrZTdUdmdlazYraG93aC90?=
 =?utf-8?B?UXRidXRNVllCR2xiekVsMXByNG1QQlNYZ2ZwMHlBbUlIZVlyeE9NcVlQWjF5?=
 =?utf-8?B?OHNWWmJjVkpXeXlmVmY0dkdiT0Y1ODBCQ2ZtKzdWYnpVbnRnMXdnalFEekEx?=
 =?utf-8?B?ZVZVcy8xZTY3MGRDem5rUzdWTzRwSjlTV0hyU0I3MHdtVEQ2SW1wNUxwYmpK?=
 =?utf-8?B?ei8rRjdVb1ZFRm9ER015Um52MExSRkdsamliMkZITndXN3RjTU9HemRtODNK?=
 =?utf-8?B?NzV4VDdSaFBwaklBcXZ0bGZ4bFZaaWFnazFGUm9rdE1ZWW1wTmZxTnVSTHA2?=
 =?utf-8?B?bWZpT0lvRGdERzJ6KzQ0MXBwdVVwOWE2NWVJeUpRUkJuNUtZZVlxWkc5dlNF?=
 =?utf-8?B?QWJTQnZIaXRhS2Rmd0ZMODJjZE93MVJvaE5yOTN0VmNxMnh4YUJVZGVxKzF5?=
 =?utf-8?B?WEdTbisvbk1OWWExRng1bGlmZDhibjdJQVc0Qy9MZkNFSStiNFVqcHdhdGpR?=
 =?utf-8?B?a2VjMktIN2xwa1lGemZ1ZmtHSXlSaWJVbTF5V1F2MVZOcVk2dnpOMDA0cnVT?=
 =?utf-8?B?WUtKeXVYWmlRVXplSnJ1UWc4bjZVNXBrb2I0bzF6L1BKZGtqeXlYRzFoSUpa?=
 =?utf-8?B?ZTJZVVhvcTI0NENCT2tEaVJjVTdxRVo2QllES1hGMkx0UDI2cThEZ3dnc2VG?=
 =?utf-8?B?NVNKaXI1OFVjd3J3TDRCaEs5SmtmRnZ2RUJBUmxxR3FJYk9YQ3A1N09SaGxF?=
 =?utf-8?B?dWRRVVhKd1V2Q0xORUhxT0d4eExLUWxlUitEUUVzdnVYdlJsWGpxb2JBNGcw?=
 =?utf-8?B?TEdVWWVsNWRKSFNxVFNFVUdDTVlSMFJkNVpBd3JiR0FFNVFta2R0ZVBNc3FV?=
 =?utf-8?B?N2pISkZUbFpGL2xDaXkwbzVkRVc3aVNDaThTaEt5b0VxVTdkTDJ1MStHbDQx?=
 =?utf-8?B?bFZNYzBLQmxaaE5yR3B0Y1d3dUlhUHRPK2h0Um1KT2dLNUFNTG9INGtOOGhi?=
 =?utf-8?B?Ty9yN1ZuTDhTL1ZvR3k3MjV5Uk96Tm9vS3BrT2lJdlR3N1F1dFdHRTVlbkJu?=
 =?utf-8?B?WllYL3pTUzBZOGliVmVPWFI2NUsyOWFGY1dnTDB2V3E5VEJyMnJxZFRuUkdI?=
 =?utf-8?B?c3hjZmNmeWY3L1FDd0xmTVI0MXp1c3A3UzkzdmtmakE4WDBYaUp2dTIwcnV3?=
 =?utf-8?B?SytxR2ZyZnpodWZnRTQ4bnBmVmdpejBsWlBON2ZuZEpiVzA5Zzh4QS92RHg3?=
 =?utf-8?B?NHB4Sy92WGdMMjBkRTZVQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tm5KZzZ6bE1DbFZiKzV1a3dpeTY2L0hpUnZlY0hJU0w2NjZubTJRMnVIeHkv?=
 =?utf-8?B?b1FvZW1BTUNzL1R5b2dqbjZqWHovVXQ0R1A5cHRzRlprMnl1Z1ZWL0hDL3Nn?=
 =?utf-8?B?cFZrUHJJQ2tPRnI2SEtJZXp2MmE3YTZ5OVRHeGdGdkFFMmhoNks1bmNNSjhD?=
 =?utf-8?B?S2Q2ZkxUOW1tUGc1UWthclIyYUhPdStiNE1uVHJPeSswNzR2T3R0UzJHOTNM?=
 =?utf-8?B?cFQwOXRIZmJKUDIvcWM0c05JUVF2WisrUk0wMEZQYis5MmFxblFpRGQ3ek5z?=
 =?utf-8?B?bEdCMW92cnNvYXlGdjA3VWk0VjJpY3hzck5tMWNwUng1NVl6SG4xUzNXc3gr?=
 =?utf-8?B?K2oxTWV1dEFHQllEekk5ODV1eUdvUUdxdU9NWTNXZGQvV2pHelJCcXRuUWlD?=
 =?utf-8?B?aXJ4TmxCekdxRFg4UmxlNWw5cFMrWFdoM2VtY1dNYW9yYjYzeTdRQmx1S1NB?=
 =?utf-8?B?U0g0dDh0ZU5WVldzL2V2cndNN2s0ZzFod0Mza0pUSGZwZU5CSEh2UWJLaFJl?=
 =?utf-8?B?MktHREhXRHhsK0w4eHRiTzN5bzdGU29FZlo1RjZLMEdkMTd0WUN1azJ0UU9k?=
 =?utf-8?B?QlVZVE50djZzMkgrNGREZUZnZC9kK2N2ejlZUEFHeERYcHZ3Um50dW5YdXNw?=
 =?utf-8?B?ZGg1U0hNd2ZUbG00WENqWlR1aHJZa1VlOTBxZkloY051bW1zZ2VQNnBXblpt?=
 =?utf-8?B?Yy93ek9tWmlMV2JObWc1YzQ0ajVSb1N6ZHhKVVZwcmJoRGhoTHhRbUZCZTdD?=
 =?utf-8?B?MitjbFdUOWlJOE5VMFZrbXJ2WU5ISDM2OG9vZjNJcVZ5TkloTnJ6cmV0b0ph?=
 =?utf-8?B?RzFTVUNOeXgyc3UrZnAvay96a1ZXdUw4SlpLMFg0N01iQXlVQi9IaDF6cUp3?=
 =?utf-8?B?K3Azek4yVGZLMDV2aEdkeW1LclJYampJb2duWW8wR1JJRjQrN1M5KzhjNzAw?=
 =?utf-8?B?aU85cmFhQWQycjVFbFBKSzRQYXJqZzVDU1NpcHJLSExLVlpkcFVqemxFUGRz?=
 =?utf-8?B?R0RoLzhBbGpLdFdXUlZEaXQxM1c3ZmlrOTlBT1ZYVU9iT09VTG9GKzYrUFE1?=
 =?utf-8?B?b3Z2MXJiSm92UXpERnUwc2ZOOWZHU1lNWlJsVStPaUZrYUowUG12Mi95K0tH?=
 =?utf-8?B?RWRHL0ZtMlE4cWs5TXRXOGhNVGhBaWxDQnBGSU80ZDh4SzNzRi9PNDhWVTZn?=
 =?utf-8?B?Q2x2SjhzQm5FZG9CYjFIdmg3RGtNaWFPcXhlZ1dwSUUwUkxmS1c2TjNDODJC?=
 =?utf-8?B?M2E2Wnh2dnEySGQ5d2U0YTBjaGN4NU5GSGpmMUdxRmt5ZCsrV0JDWlN1R0RX?=
 =?utf-8?B?WHJONVYwd2UrQ1ovWXFCdU43a3MzNXRPVEl6QjZUN3o1YWhXTmJSUjVGMjQw?=
 =?utf-8?B?VXQ4NjVFL01HNTZKbnNPb1dTRmNVaThwVXlBYXlxampuc2pjTEwvWXk1K1Qw?=
 =?utf-8?B?d0ZXNDE0MDdveEt5U1F1b3BxcFpSWGtVYzBabFhjL0RwTzRzcjROb0xuVVhY?=
 =?utf-8?B?TlJvN0J2elFsd0hnU1NNSVY3MUhvaFl3Z1pKd3lwaGtJNUNva3orcnpwMkh4?=
 =?utf-8?B?eU5Gemw1eFY0Um9mSS9rSmlkSTlwRzFpcld0NklzdFlTajNtNFBkYy80Unhq?=
 =?utf-8?B?M0Exd3BRMTNGcG9qcHJqNXd2cGszT3FVTE50LzBGM2ZqRU13dGhVN0VMWVpL?=
 =?utf-8?B?RndTTGp2N09hVWxUNXp5bWYySStSbVhLbVJkOFBQUDM3Tno4K1pYL2pHVWFZ?=
 =?utf-8?B?V3hFZm93ZlE4TGIvM3dMZ1l2a0pSTEJ5d0lQM05OcWJUWk1zRjdUWDlXeEps?=
 =?utf-8?B?VS9XYnlIUDBVajVWNEF5YW1sTVNzWTdTeERHY25FTDVxSXBoemt3NTdrakxD?=
 =?utf-8?B?ZFgrckxvTnZzazJNVS9XK0t2UzVBMlY2SkdrS2xnVmFleDl5N1kyZ0l2VHNQ?=
 =?utf-8?B?K0NpMk1XRkllYldjb0xhVnJ3Y0tScGRYSkdRN3Jrc2JvdENrUE9RL0xKQjh6?=
 =?utf-8?B?eWVCU1VCWXlXODdGTE5LT29JZVJQR3J0RGJqeXR5TjMwcVhiV3NiSUU1eWVm?=
 =?utf-8?B?L3ZvMHdwQ24rU3hvZTNWbHZrMUVWR1NHYVBReXlPU0pWbWNlb0pxQVVFV3kz?=
 =?utf-8?B?S2dsSVVxWUNlY2xYMUo0ZTAyYkpUYktBWHBKbmRKOUlmUkFqYXVmUWJpa05G?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c94a12-700c-41e9-a638-08dd517116b7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 05:40:31.2430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKPf7+YE9TmwMeH/loYfCQAZT37+DZT1nZCehuN1oCNrIPv1E3NJZD+Br9Sa/TFdMtPlk8/O20PwIIy5UZvRpyhB5m371lW/3FlA+cIC3rA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6791
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:18 AM, James Morse wrote:
> MPAM platforms retrieve the cache-id property from the ACPI PPTT table.
> The cache-id field is 32 bits wide. Under resctrl, the cache-id becomes
> the domain-id, and is packed into the mon_data_bits union bitfield.
> The width of cache-id in this field is 14 bits.
> 
> Expanding the union would break 32bit x86 platforms as this union is
> stored as the kernfs kn->priv pointer. This saved allocating memory
> for the priv data storage.
> 
> The firmware on MPAM platforms have used the PPTT cache-id field to
> expose the interconnect's id for the cache, which is sparse and uses
> more than 14 bits. Use of this id is to enable PCIe direct cache
> injection hints. Using this feature with VFIO means the value provided
> by the ACPI table should be exposed to user-space.
> 
> To support cache-id values greater than 14 bits, convert the
> mon_data_bits union to a structure. This is allocated when the kernfs
> file is created, and free'd when the monitor directory is rmdir'd.
> Readers and writers must hold the rdtgroup_mutex, and readers should
> check for a NULL pointer to protect against an open file preventing
> the kernfs file from being free'd immediately after the rmdir call.

The last sentence is difficult to parse and took me many reads. I see
two major parts to this statement and if I understand correctly the current
implementation combined with this patch does not support either.
(a) "checking for a NULL pointer from readers"
    The reader is rdtgroup_mondata_show() and it starts by calling:
		rdtgrp = rdtgroup_kn_lock_live(of->kn);
    As I understand, on return of rdtgroup_kn_lock_live() the kernfs node
    "of->kn" may no longer exist. This seems to be an issue with current code
    also.
    Considering this, it seems to me that checking if of->kn->priv is NULL
    may be futile if of->kn may no longer exist.
    I think this also needs a reference to the data needed by the file or
    the data needs to be stashed away before the call to
    kernfs_break_active_protection().
(b) "...being free'd immediately after the rmdir call"
    I believe this refers to expectation that one task may have the file open
    while another removes the resource group directory ("rmdir") with the
    assumption that the associated struct mon_data is removed during handling
    of rmdir. In this implementation the monitoring data file's struct mon_data
    is only removed when a monitoring domain goes offline. That is, when the
    resource group remains intact while the monitoring data files associated with
    one domain is removed (for example when all CPUs associated with that domain
    goes offline). The "rmdir" to remove a resource group does not call this code
    (mon_rmdir_one_subdir()), nor does the cleanup of the default resource group's
    "kn_mondata".  

I am trying to get a handle on the different lifetimes and if I understand
correctly this implementation does not attempt to keep the struct mon_data
accessible as long as the file is open. I do not think I've discovered all the
implications of this yet.

> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Previously the MPAM tree repainted the cache-id to compact them,
> argue-ing there was no other user. With VFIO use of this PCIe feature,
> this is no longer an option:
> http://inbox.dpdk.org/dev/PH7PR12MB8596BF09963460CEAE17582E82522@PH7PR12MB8596.namprd12.prod.outlook.com/
> ---
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 19 +++++++-----
>  arch/x86/kernel/cpu/resctrl/internal.h    | 37 +++++++++++------------
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 28 ++++++++++++-----
>  3 files changed, 50 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 032a585293af..0b475e274483 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -645,7 +645,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>  	u32 resid, evtid, domid;
>  	struct rdtgroup *rdtgrp;
>  	struct rdt_resource *r;
> -	union mon_data_bits md;
> +	struct mon_data *md;
>  	int ret = 0;
>  
>  	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> @@ -654,17 +654,22 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>  		goto out;
>  	}
>  
> -	md.priv = of->kn->priv;
> -	resid = md.u.rid;
> -	domid = md.u.domid;
> -	evtid = md.u.evtid;
> +	md = of->kn->priv;
> +	if (!md) {
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +	resid = md->rid;
> +	domid = md->domid;
> +	evtid = md->evtid;
>  	r = resctrl_arch_get_resource(resid);
>  
> -	if (md.u.sum) {
> +	if (md->sum) {
>  		/*
>  		 * This file requires summing across all domains that share
>  		 * the L3 cache id that was provided in the "domid" field of the
> -		 * mon_data_bits union. Search all domains in the resource for
> +		 * struct mon_data. Search all domains in the resource for
>  		 * one that matches this cache id.
>  		 */
>  		list_for_each_entry(d, &r->mon_domains, hdr.list) {
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 32ed9aeffb90..16c1a391d012 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -103,27 +103,24 @@ struct mon_evt {
>  };
>  
>  /**
> - * union mon_data_bits - Monitoring details for each event file.
> - * @priv:              Used to store monitoring event data in @u
> - *                     as kernfs private data.
> - * @u.rid:             Resource id associated with the event file.
> - * @u.evtid:           Event id associated with the event file.
> - * @u.sum:             Set when event must be summed across multiple
> - *                     domains.
> - * @u.domid:           When @u.sum is zero this is the domain to which
> - *                     the event file belongs. When @sum is one this
> - *                     is the id of the L3 cache that all domains to be
> - *                     summed share.
> - * @u:                 Name of the bit fields struct.
> + * struct mon_data - Monitoring details for each event file.
> + * @rid:             Resource id associated with the event file.
> + * @evtid:           Event id associated with the event file.
> + * @sum:             Set when event must be summed across multiple
> + *                   domains.
> + * @domid:           When @sum is zero this is the domain to which
> + *                   the event file belongs. When @sum is one this
> + *                   is the id of the L3 cache that all domains to be
> + *                   summed share.
> + *
> + * Stored in the kernfs kn->priv field, readers and writers must hold
> + * rdtgroup_mutex.
>   */
> -union mon_data_bits {
> -	void *priv;
> -	struct {
> -		unsigned int rid		: 10;
> -		enum resctrl_event_id evtid	: 7;
> -		unsigned int sum		: 1;
> -		unsigned int domid		: 14;
> -	} u;
> +struct mon_data {
> +	unsigned int rid;
> +	enum resctrl_event_id evtid;
> +	unsigned int sum;
> +	unsigned int domid;
>  };
>  
>  /**
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 6832ae603db3..abebe01447ba 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -3113,11 +3113,19 @@ static struct file_system_type rdt_fs_type = {
>  };
>  
>  static int mon_addfile(struct kernfs_node *parent_kn, const char *name,
> -		       void *priv)
> +		       struct mon_data *_priv)
>  {
>  	struct kernfs_node *kn;
> +	struct mon_data *priv;
>  	int ret = 0;
>  
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +	memcpy(priv, _priv, sizeof(*priv));
> +
>  	kn = __kernfs_create_file(parent_kn, name, 0444,
>  				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, 0,
>  				  &kf_mondata_ops, priv, NULL, NULL);
> @@ -3137,9 +3145,15 @@ static void mon_rmdir_one_subdir(struct kernfs_node *pkn, char *name, char *subn
>  {
>  	struct kernfs_node *kn;
>  
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
>  	kn = kernfs_find_and_get(pkn, name);
>  	if (!kn)
>  		return;
> +
> +	kfree(kn->priv);
> +	kn->priv = NULL;
> +
>  	kernfs_put(kn);
>  
>  	if (kn->dir.subdirs <= 1)
> @@ -3180,19 +3194,19 @@ static int mon_add_all_files(struct kernfs_node *kn, struct rdt_mon_domain *d,
>  			     bool do_sum)
>  {
>  	struct rmid_read rr = {0};
> -	union mon_data_bits priv;
> +	struct mon_data priv;
>  	struct mon_evt *mevt;
>  	int ret;
>  
>  	if (WARN_ON(list_empty(&r->evt_list)))
>  		return -EPERM;
>  
> -	priv.u.rid = r->rid;
> -	priv.u.domid = do_sum ? d->ci->id : d->hdr.id;
> -	priv.u.sum = do_sum;
> +	priv.rid = r->rid;
> +	priv.domid = do_sum ? d->ci->id : d->hdr.id;
> +	priv.sum = do_sum;
>  	list_for_each_entry(mevt, &r->evt_list, list) {
> -		priv.u.evtid = mevt->evtid;
> -		ret = mon_addfile(kn, mevt->name, priv.priv);
> +		priv.evtid = mevt->evtid;
> +		ret = mon_addfile(kn, mevt->name, &priv);
>  		if (ret)
>  			return ret;
>  

Reinette

