Return-Path: <linux-kernel+bounces-522710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C3FA3CDB0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 865623B4F8D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6089E21B9CA;
	Wed, 19 Feb 2025 23:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fv7LJ/t+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6591DE4EF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 23:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740008007; cv=fail; b=RgIabiQbes1v5GjPkc7tuFIDk61PSvrA87tYehJCmBgLPASRi7j5dMdLNCGTmM6L+FFAT1E6Xsc++MwXx7EKj9sWTjDx028O2hyNnpvTGggwnq44keTNHRArbS3S9gu/Pa7Lp8Yc6Ro23/I5TcW5wxT7JymbQ6bw6yplH0qGHfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740008007; c=relaxed/simple;
	bh=1ymAG/3iPBsFDB7w7fVSDNVT8S8CQRf1tN8DeFQcUS8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XDx/NYYzzLETOFqdc5iCp+irQ1oMpEDB6jUEw2FLdbGat85wnQxCHfq6yFXp3qdzIwhFVMiJC+ojFrTQhendKsfVjE7wi/JiR5CIxu3dYksI/o/uDwECPl6t1EIQdHp3eLOfrTdH7tqZyCdC8zfsSRzARCnuj61t4cq15X6FZxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fv7LJ/t+; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740008003; x=1771544003;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1ymAG/3iPBsFDB7w7fVSDNVT8S8CQRf1tN8DeFQcUS8=;
  b=Fv7LJ/t+G7hslDvRNtG68rwYFMDChiHerAMPzyUIuYCDxtaiMfARWJX/
   P6Ed2wal3exTyA2I9BUXIf6KleKj4PirbLFWF2YuF7PJGODKT58+E8syl
   PyfWK9xPhNDYNwES8gcj5ZRAWG0MUP5UQUzQkVGlzLPohkjpofG7uKvv5
   vH+4sA4Y4xG4afg8uny27YsR0iRo0giaw5GYbX1poyxzbMDdX4bvt3Yhl
   niugIQxWUGmjRtrNRoWK7jq8Bz4ZlHd+ea+uWOOlEZB8/2MK83fISVmVP
   QCWHI0tc9J1wGYd3xQQLp4ZNGcnMbbyMOrWqDnQLJlQ4gmmgZv5OZ0+aA
   w==;
X-CSE-ConnectionGUID: xXOdZKExR6+gsIrQminqTQ==
X-CSE-MsgGUID: C9tmZdyrQBK4mul5yGgXoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="43598511"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="43598511"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 15:33:19 -0800
X-CSE-ConnectionGUID: CNXc6gW9T+eTasCKbRycOw==
X-CSE-MsgGUID: uWgl8GsxRVyVsh+iEaotMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="114702213"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 15:33:18 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 19 Feb 2025 15:33:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 19 Feb 2025 15:33:18 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 15:33:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HP1D3861nyvTmUko7Ylmy7dcdnzVUvyiBvJaXP7/ghQtxbqBVukicrn8bG5IVA8BIzPkwWYHCsooVrvtpJoq40lb9ojxTzdN3hH3eALQsKl9e57gt5brQbHP7TGHPceT+OkhiIEOs1ktWLaS+z5fO5jHGgDXVuhTv0KSZz7TsSqZM80rIVEoUXlR0gQXx++eAJNAxD3SQ6eHotxlXoc8Mz0Mu5fIGyA+f3TSveFTZw4+Rg3G7z42nd+xiI3GJlyjLDpDsuMt3jKGZvtvAZKYs9aZ72lto1taaZ74TOaiZA9qzmWkB37or1UnLkb4edPA84wjYbh2qQKcid1UzubxMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mt79hAYMIOKHmgJjhq2D2PIKkxFBIX1E/np0eTwP9Os=;
 b=jRyt9+obVtjTKBA0omJRmByoKH2XVz9D9Y8LlJ+sBXwPxo6aR7u/aaXMdGw+iRqLJeXX1VPw7a3+X4p2bAEwMi2/dSnQ9j+OmR1I5i1mUqW1lJIJY5etUdMd5hfixZtgTDFUdAI/CWia44wN07O7HxbKQzVKnH87dfm0fUc71fQ7SplSukDwZ6r10w/alyUZSWq+uCXE6haAw1PYjoveWBv8ZsiAoWPRs2zOvkdcyAq7HpeyKEPCuhyaz2OYVhieMVsu32zr9HmdNDzJu5xMRm5sh1QtlAYnhOC4Hxv/Sh9ZLJHQQghh7sdmdLOH6aXW2o34km+8P6N3CzN165I8dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB4975.namprd11.prod.outlook.com (2603:10b6:a03:2d0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 23:32:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 23:32:27 +0000
Message-ID: <a3e8fd63-b58d-4286-9a00-31cb9bcaf266@intel.com>
Date: Wed, 19 Feb 2025 15:32:24 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/42] x86/resctrl: Add an arch helper to reset one
 resource
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
 Donthineni <sdonthineni@nvidia.com>, Tony Luck <tony.luck@intel.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-15-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20250207181823.6378-15-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0327.namprd04.prod.outlook.com
 (2603:10b6:303:82::32) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB4975:EE_
X-MS-Office365-Filtering-Correlation-Id: a227c5be-3e68-4e0c-a4f3-08dd513dab78
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGNaOWxaMUJ0Q0hPWEpQSXFvdFZRbWJIdW9Eb2hLMDU0d1JkakdiRVVrcHN4?=
 =?utf-8?B?Y1g2RXA2WkR3QXUyMWhmbDI2ZzVNQy9uZnAzbzJ5RmFpcjBlSWNuOGlOQnZh?=
 =?utf-8?B?TTcwVXJDQ05QckFsNW1RMlQ5dUxTZ0tTMlEzd2JlclhDZHhYYjR0bThzb2dn?=
 =?utf-8?B?bHUzVFhEYkNGMTUzRzBVOVN2UERJK0NGcTEzMFRzdkZtY0lBREMrOTl0cVY0?=
 =?utf-8?B?VWFFd3ZheVB1YXdpcVVuN2JVbWRNMGV6UVdPajNDckpYUk1QNFZOT1A0SHpy?=
 =?utf-8?B?cVJiOWRmTkN0S3A5OVVPeE8xSVo3ZjJpTkI0SGdBWkEzWDBobkhKanRlQytO?=
 =?utf-8?B?UGZWTDBHaUMvbkpraGZKS2FzeWRkK1I2ZkR6UXdtZGMwME9IRHcxRE5BdWF3?=
 =?utf-8?B?YnNqU2wwU1dSL29rcEY4UnBQTllnanN5azQzVXRwR0lhWFhmc3VSbUlONVEw?=
 =?utf-8?B?azAwMW1LVjRLVlhONGMyblFqbUdlRWlNZ3c0bkI5cE4yNW9iNUZLNk11NERx?=
 =?utf-8?B?T1JHYmF2MDVTalNsTXpOVm5rZ3IxVzRocGwxNUQrR1F2YzVoV2NVZ050Mm5r?=
 =?utf-8?B?bFd6ODdvNXZEVHpIellrQldyOFltSWlMYURsbHd5c05JWm9lbnJPWWM4SWI0?=
 =?utf-8?B?M3pXVEM0QXNzVWFLbkErckRTc3BXZDFhajZ5ODQ2NFVCNnVWbnNENUtwa2xI?=
 =?utf-8?B?cm15RkViUVlVYzRwTUNINXpITUxrdjE2Zi9IdlN1ZDk3VmlCUk5MbzI5RUZl?=
 =?utf-8?B?c3NabCt1MkV3ODBQbitjU0w5VTVSZXdJbUl5a0JEN0F6eWZvOGZ4WEtnMHNz?=
 =?utf-8?B?eDJRbmZsNDNTTU9CRHl3bGVCbno2ZWdSTmFudFBiaWd0VFl4YmVxbkZSZFpp?=
 =?utf-8?B?Ny9Lb0lSeUdLV1pqT3FQMWFkektsN1oySTJZWDZJTmMrbVd5blREWlVRSW5h?=
 =?utf-8?B?S09KRVI3Z0FGTzZWYWs2SE0wRGg4TEpXenNiVUt3Vk9jcEFKclJBR054bzEy?=
 =?utf-8?B?SDNFRmtjSnFySVhZM0M3NWFzY0hYS0RBd05KaEJ2WFVZS0VoZnVBbEQvU0Zi?=
 =?utf-8?B?YXRPUmhURmdjVGR0U0dPTGF6Wm5ybnU1VURjZHF5emxXQWVMd3huVUxwMzRx?=
 =?utf-8?B?SHNsTHhjdXZzZVZtVzUyZVdhNktNenV3M2NBaFRRR1VMRHloVmNPdE5tL2Vl?=
 =?utf-8?B?aS9VUEZVSFgrektDdUpOTDFERFc4R0haVHhyV1owQ1BWT2kzUHpCa2ZYL0ha?=
 =?utf-8?B?K0svVmZKOXFRMVhZK3E1d28zRFQ5RE8wS0hoUG5Hb3o0NXBXNjVrQmt6dFho?=
 =?utf-8?B?Y3Q0OWlLci91YXVJUkNDbkpSU294b241SURJWjF0ZEM0eFYydHozRUJGMk1l?=
 =?utf-8?B?L1pud2wrZFN0THJ4K0pXZlB4bU84QkFGUnJpV0VwM05WNllBci80cXhDQU1r?=
 =?utf-8?B?aExGRVRmMlkrcmxnZWdRUTl2UDl5WmlPNGZ6V1lGYmh2YUFUalhIYzBLZ3Bi?=
 =?utf-8?B?ZExISkNrV3hYMDk2dGNNQTVTTUpiSXVuc0ZmVW5peGZXU3FRdmlMNlorZ21r?=
 =?utf-8?B?Q3lCR1NyNUpQZnVlcTlrdmtXWDN1RC9FUXJuOHVjcXV0Qk1OVmhYZzNvNWJF?=
 =?utf-8?B?QWN6anE0dUZsT0ZhYzJIQ1lkRXIrVndRMHRrY2ZsTU90dVpWSmZ1bllVZFhG?=
 =?utf-8?B?QmtlOG5kWDAxWkpsSGR2WlkrWm5oSjMvWUNHVDFveUhVWXF6d0o4aFNOSjB0?=
 =?utf-8?B?SGkyNHFPdlVGQXF6cnBhMzM0T2tEaitHa3B4Vk9KQ05WanNINzRkTnRjdUU2?=
 =?utf-8?B?TTRmVi9ERnZRaW5ROXYvOEJ5V0lQR2NMcE1STXdJMGpLRDgyWmFuTDdueThL?=
 =?utf-8?Q?fJ8vn22b9uXqg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1pBa3d1SFAyUDZFTGFIT3plZWx4eW4rRHZqdlRROCtPZi8wRUdGSWhPMlVH?=
 =?utf-8?B?bWhrVk5PdUUxeFl5a0ZoMEFESmkrQjlQd0QrbEdiZHJ5YVYvTFU4MzFQcyto?=
 =?utf-8?B?S0RCSWtPa0tPNzlPNHBkT0xuaERIaFFDaExlZENtZ3VlZHRFMXZ1OThIa2xa?=
 =?utf-8?B?V1lnajN4YjBDWWVnV1Q3blRhcytycUFyemMxUUVha3BDZ01IdVhUc01JRnJs?=
 =?utf-8?B?Z3JyZVpzZ3NoOWVXWXhOdEtPRTJ6aWNvLzZWZVhiK01HWkRUaitRYk5aRmpL?=
 =?utf-8?B?WnYvaUtyall4QmZLeWl5bEFUa08vWGtnallCZkJ1ajhMMmJBRThqc3pnZEw4?=
 =?utf-8?B?TnhLL0lURmY1ZUFiOWxlQllzUjR6ZzhmTklJYmRUc0lFY1BoQ3l0dlJKWHZB?=
 =?utf-8?B?YXZnMkc2MzcyOEtzMlJjcU9uU3IrMzdyRHNYam1lUlpTZGU3angwL0ZaRmRj?=
 =?utf-8?B?Y00wcHpPbzhHQ0xDcG9JRzdESTluMEdINEtxQzRjRUVuUEtPdEdYaDRGbWhG?=
 =?utf-8?B?anZ0Mk5MZ2p0K1FnWU81MFRvU3FzYmkxTTd4S3JRVllMN1JteTV0dWlzZ21J?=
 =?utf-8?B?ZTdYTTc0bXJ5V0k1RnZycFhnRzR1d1JwUUVGNnU3MFk0ZWhVaDlESTI3SnJZ?=
 =?utf-8?B?NnpUZG5kVDdGWVVya28wSnc4T1lONWdNdG5PSFIwRWczbjFGempIYStXdUY0?=
 =?utf-8?B?aFZTNjZ2djE1bkxuMVpGNUFzVE1UMFJ6SGdoMzh1aWRYUXNoZ2ZkRlZUUDN3?=
 =?utf-8?B?dnRtdHJGdkN4RUc4VWZFbXBWWW1EM09NQThFdi9xSDZWWHg4U0tJanRValcz?=
 =?utf-8?B?MnNaaVJVSTJOdGZvNG9FRGJ1NnQ1Q0pvemEwM0FhcmJNSzZ1RWI3MmJxTjlB?=
 =?utf-8?B?WCtLcXYwenFRc1J2eTQzSk5lY1lHYzJMdXBUbDYxNWpzSlZwVmIxa0VrQTVS?=
 =?utf-8?B?R3RtWEZodmUwUWdoeEVSbEZNL1NITlBuMkJyNlBadlRzVUNHREF5c1l2a3hv?=
 =?utf-8?B?anFwZWEzME9KRXBtaVFoMGRqZmtpYk9ML2VxSm85RG5vcTZlVm9GUU1GdWNF?=
 =?utf-8?B?Y2tGZ1ExOEhzMnVBWURSbDJQV29TVTF1ckJZb1pkSmJIWmZIaytGL1U2TCtX?=
 =?utf-8?B?eW9EaUljOG9vQzNsUloybEdXczB4N3pNSFFxeEJSYVlucWw5cVJPa1RaV1Iz?=
 =?utf-8?B?a2RhSitWa0RKRnpqVXlPZk9nSFczbDlOM2xnTkJ2VFQ1UmRRbDFUd0tJUVBv?=
 =?utf-8?B?TENuOXQ5cStHa2ttSkRPSzNSaDNDSlZZcWFVNldRbVUzMUM2c1J6N3VzNXFx?=
 =?utf-8?B?Ni80NXpYcHRrN0dPYTJxWlJkY3AyZGlLWEVPSjJ1Z1pFazN3LzFiUFluL0V6?=
 =?utf-8?B?WkRTNnNQeG1oMUFoRUprejdEOXpnN0ZQY0ljYW1YZCtFSXdleDN4eHB0Vitq?=
 =?utf-8?B?NDRrdUlxSHdkQkkyTiszM0dRWkRXdmFGSWpsZkhkdjRyRmNyZ0llSVNZZStQ?=
 =?utf-8?B?c2VHSGxFOHQraWs3dXRIS3lPeXQ0Q1FOTjBVVFdWU0xSRkI1SmVBRUJadndn?=
 =?utf-8?B?SDJOb2Y2UnkrcElXV1kwVlVzMXZCTGNlNGZtdWw5OWZxZU52YnQ4SnF5RHY1?=
 =?utf-8?B?Q0pvYlZtWXF0OFZOS3RNQWtqK1hhZkdoTi9JbXgrNkVnOGpzUHZvNEkwWUZq?=
 =?utf-8?B?RTM1WTA2a20yNndXbHc0M1NCTTNhWWNidjIxZVlxOFFnUnB5QVN4OHJNeU5t?=
 =?utf-8?B?THc0TmNzY0NDUjdaZGNpbFZzTkF4OGlYb1N3ZXRKVXZveUkraEFCcUNGS0I3?=
 =?utf-8?B?VGpSSWZ4VWI0T2lycytydHViaGpRUXdSTGlMVnplbVlMeWpMM3NYV2U1alJo?=
 =?utf-8?B?aUZySFNxbTdldW5UNGxmUEh1amdWc0tQaHVwb3VhVjhqbytwa0ExQ1lLd1pp?=
 =?utf-8?B?ejMxeUhCejhRTjAwOVQ2NE91dWxDMldTNVoyeXE4aFd6VEcydHYwKy9mbHZH?=
 =?utf-8?B?RS96TVlrMDhZeFlyTzR5QTV1N21oODZjdXQ1a0tJUkNDVElqYUMxOFNvY0pW?=
 =?utf-8?B?UlB1UnduMGZzMEtaSFFxMmRJRVRhaUZINEcxOE5jcXNERDkvei9PbU9OQUFz?=
 =?utf-8?B?bzN6SnMzNHBFclVSLy9pMHV6ZEJyTDM1MmROaEgzT0FoODYzQXlxYzBQUDRr?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a227c5be-3e68-4e0c-a4f3-08dd513dab78
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 23:32:26.9882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uufmRi8z0MHxaYtv/bKh8lAzRYp9h8WBzla1T6u7PN+D4FFamOLLMn/CZwzk3yJDXvMiQIot1i0DFjDWsxnhmRNxsEK55KGMZQ/2Vd4tA0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4975
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:17 AM, James Morse wrote:
> On umount(), resctrl resets each resource back to its default
> configuration. It only ever does this for all resources in one go.
> 
> reset_all_ctrls() is architecture specific as it works with struct
> rdt_hw_resource.
> 
> Make reset_all_ctrls() an arch helper that resets one resource.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


