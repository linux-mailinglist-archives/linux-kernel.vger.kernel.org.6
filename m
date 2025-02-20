Return-Path: <linux-kernel+bounces-522792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A5FA3CE8E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2CCA3B375D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB9B16D9C2;
	Thu, 20 Feb 2025 01:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jO8iHBV/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802BA1B0F1E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740014470; cv=fail; b=bO8UZL4c3ZaJQiUeCwt4iy6CTwfWyZv74Vzp8tOxMDS3xgzhhiIC6bHpNnHh/m/uKFX7rWftFU5op1ISJ1gNiU322bBcriXPaXLMoztPVWlU5k1BIggaz/3nV2B6UfPjpqLvhFdFq5GThKoQsqAGdnhZOwht4DnBn57sTnhyMt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740014470; c=relaxed/simple;
	bh=pFixP8RyNpoKR7JdLMhNy6FTKbB8tBN5xxnG7p2yC+w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LS6VxWu/XJ9mmcbhl5ripSPc5k8yAYQLGfY7h3vE49IP72dHWf7EAcxxmMscAco2DPCwTFpbWL3P9/ZNIt/RAOEnexzGV4Ea/OOKh6L3LbT+W0B68syokYN859hewBy027IaoNj2uTuSM6dSJ+FRZX88M7VVeDskd36Ykab4UGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jO8iHBV/; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740014469; x=1771550469;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pFixP8RyNpoKR7JdLMhNy6FTKbB8tBN5xxnG7p2yC+w=;
  b=jO8iHBV/dpk+sbP1BH8DJEPz6AqujBEwGY5QLnf9rGE5jb2BOQbRi2Ab
   HScZhGw8oSyB2e+Ml+GNE4E2z8pcPpAayX4+9sHXKelkC4oavATz7oyOs
   FR39nFpVdi5Yk31QJHwjGTLNYKq9PRpnI6dXJjEpsKBYoBbvgBSq20GD8
   L8ovpwjAeb7vMVbAKQ6zh6kQJl/fkIPWxR0hVHeoAqYfHIeMvCjDt7jNO
   1JYDKaWbyD5hp2spdhalH99mIdKlPzw6uZ0U3dnw5Rk3tKdE1l9VCCXwx
   05qEkspYMumuddLoS3wmDTa6WlUAqW+jjzTSWt1c2Hev4+iCXHCWV4aLL
   g==;
X-CSE-ConnectionGUID: E+gQkp20SFmmRnBGsWm2Xg==
X-CSE-MsgGUID: /QgODDthTTyvHEaoYFwJ2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="41036017"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="41036017"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 17:21:08 -0800
X-CSE-ConnectionGUID: LPy7IGBdSXG2WPcI9TYOpw==
X-CSE-MsgGUID: 9fZCxop3S46ezdc1xNVf3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="119824315"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 17:21:05 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 17:21:03 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 17:21:03 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 17:21:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vs5zxvXNbty/jvoQhvbLsID/NOzfzWid6+INL2o55B4Uuhq+VAaxaPjCnrZ9mmaxM9E010N4av3ZLgXcgL8E37zNl6e+vgcPlYdVTcPL8KKXdqYbUdTpYkYkv4qNfjgYLXnp5Q9buwS4oz8VlCzeMYwvvsz32rY9B8Ap8z7xIegFgqxIlsmqLbL2xKXe5VnS619332c/vIMRUfUpWuFf4rtztz84HcGQRmtEPYmv7aUs7GHr7LotdYUZ14OFa6TjkRubC1LpnyuWkfE0SsmN7EYTrH7gmqatvc5BiyiyO6foGl1wAWRQdB1ogwLlvTdpk+0h6bRv9n+qybtCybsS8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVOhwoRgXOCAEtM9ZOcLfFeAhux2BwXMBh218xxhxBA=;
 b=mOpOgHhtFrnv+U7ExNBK5TmCtu63dWvgF5yyp8c4aUX/+VGCRFdXT5sgBycWO/h0KkHakYX4vGMMgzUrSbnud14j0vRzikWQfo0xY6PmjE7nwVOprXr/LfDkzH9RxEDdOySOCTX7di67lBIqt/FcMAPKrqGKikbEwP0pdEXlo/COqRLsxRQXvnF3o6RRI4aKTZaBH0jNF0ukqhl8yLBymTr2yZtvAxlLMDlUiqssDi1Su0p2weNg2ru6sf9LlXzVx5RWsyf1/d5GuDRfwBNSRrotdlP0hyaaVxXkHKFdJwaUelhefkGR7wyyIYGQthZmXNyD2/xCc9P3EGVLeTwq9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB6715.namprd11.prod.outlook.com (2603:10b6:303:20e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 20 Feb
 2025 01:20:59 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 01:20:57 +0000
Message-ID: <e11b33a7-ffdd-4280-ba3b-986c577199ab@intel.com>
Date: Wed, 19 Feb 2025 17:20:53 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 28/42] x86/resctrl: Handle throttle_mode for SMBA
 resources
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
 <20250207181823.6378-29-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250207181823.6378-29-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0207.namprd04.prod.outlook.com
 (2603:10b6:303:86::32) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: a928152e-46da-4fbf-a370-08dd514cd40b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWx1WTJPYU5PaHo5NWlhL3NGcEF1MEFqWXJLRnBPMURCc0V6aGZoMloyQTVo?=
 =?utf-8?B?NHNJUWp4d1NKSGhscFZkNy9FRU5KZ1ZPWlRhUnBwdFM0RmlGVXZYdThBdkIr?=
 =?utf-8?B?UVNLem1uTHZkNW03ejZZd2E4Zi85RGJFMnk5cktCYnptUlFOaFFHZ1pUdUpX?=
 =?utf-8?B?TDQ2UUF5N2tkUDBUbTJaa1hYV2IvR0lLRkZFVGFvSWExeUpFR0dFV3MzYzVw?=
 =?utf-8?B?Mm82TkdqTXZSMnZVeG5qZ29EcENjQTFTQVVVSEIyaDg4NE8xME5ld0szMGZa?=
 =?utf-8?B?SDdEVGZ1bFArODNXcTBvRUJydDFsaG1BS0MxRjZxUjMxMVNiWU1qL1krT0dU?=
 =?utf-8?B?WVk5enVUNURsZDIyTWNPdXh1a1JLVkZ6aEpTWGdVd1NPYTRIM3BrZ0FUd0JT?=
 =?utf-8?B?dU8zYU9TeEhXTXBuZzgvT05ZM0w4b0FCZ3ZKQzhzMHdxY05zRVl2M0ZTWTZP?=
 =?utf-8?B?R0dLcVJ4S1Q5VkpyciszbVNMZ0xHQUxNRENZZHoyU0svNXJRMFJaUElnd1E0?=
 =?utf-8?B?cjNBc1doOXcwWnVuZDB3Tis4ejYzTm96d0NxRXdDTEVUNGJRWUFuaTVYWjdQ?=
 =?utf-8?B?ZGczR3lKWnJ1V2I5eEFXNk5hME9kN08xcXVzZ09aM2psNGxFVVZEdzRvcGVS?=
 =?utf-8?B?SVdseTdVeTFWSkE5bXErZzNTWDFnL2ZZa240ZVRKQ0pZbEJVUlliZ2pZTDZR?=
 =?utf-8?B?K0JyOXdqdDljTEs3NlZOaW1HN3FwQWN6czZxNGJjUjVkMW4wREY2VEpKU25O?=
 =?utf-8?B?cHYvNE9USmNWdTljTjdFbW5MRXRrSmhTSlZNalZldWk0ZlpiN01vK0trd3pQ?=
 =?utf-8?B?NWRmYVFNaFQ5MU5QWUxkNGlPa3lWMlN1alV1Qm5xTW1DS0wzTmV2NEVuVElr?=
 =?utf-8?B?enBQTXlMZzhsOHVZT3d5NHdPYnN2bnBrankyNFYreHNubGRLS3RMNi9HMmh5?=
 =?utf-8?B?U2owemlvemszUk9mRzFRd202UjVMUnYwTm4yckFyT0dwd1d3QWhNcjFKelFt?=
 =?utf-8?B?MThVRGtJWm9pTUs5OFFxRENCSzFTelAvRkVIeGdVMFZVdzB4V1d1WU92TWov?=
 =?utf-8?B?cW1NTGlIZlUrTlBmdXZLWW10aVBSR3liUnNMYkdyQTZXZHFUTVpydlhoUG9O?=
 =?utf-8?B?ZzZLcWFBazdiMGpHWTJSdTYreTlVajNBaEJjV0V6b2x0ckFjeE9BbjIraHhW?=
 =?utf-8?B?SUxHaE9zWDVxRUQvVVh4eFozWFF6TXRDOXgyKzRQa0dDQlMyTE9CeDBqSHpU?=
 =?utf-8?B?a09nMFlhWWZRQjFIbHpvdCs3TkhhaFpKTXRta0tVL2tpSXhrSXVIZUE0M1d1?=
 =?utf-8?B?VHZSWEtmY245a1BKK3lmUm14K0JscDFoQmlGcndRbWtNMjQzVGk1MjhkVjBP?=
 =?utf-8?B?azVtSmRoV1RVelZaVExZR0dhNkFVNDFJQTgwZ3JOelROMkZ2Mi9yLzJ6amlS?=
 =?utf-8?B?Y3FNbXRXTDJ0MmVPcll0dytiT1Qwa2tjZFZJRFJXQW9kWnZTYURQRU5NSlpX?=
 =?utf-8?B?dFlVMWlnMkdqcVNUaWRzL3NabWFGNG1yK2todHlaUnF2dmxrMnZzVitoRjZ6?=
 =?utf-8?B?ZWlrMXRNT1R5MWNiWDUrS3hxMVFSVHlEaW5vcWxpOCtBaWRlSkEyRVJDSWpj?=
 =?utf-8?B?eld4aDRpK3ptbEpFMkN6SjdvRlBJSkl2Nk1xc0ltTXo4K1ltNXJvL0JTRmxw?=
 =?utf-8?B?dTUrTXU0bUhmVEE5Zm5zU1RZWlh3S0tSMUNnWjFySVFCNE1acmJnaVdMdmZP?=
 =?utf-8?B?eHJXcGRWdnlieHFsZXVBOEZKQU9nckdoUFVLU2pnbVFuU1o4MG90UUc1cnNB?=
 =?utf-8?B?ajdhcmEzVkI0V2t5S2V1TWEyVGVDTTlUMDBvb2VBRjVaNVJXbTFtU0ZXenN5?=
 =?utf-8?Q?7m9eSQqoK4Zeq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3FMZ2xwSEh5aC9EbDZZRGRlVDB3VXoyNVVFbkFjdE9oT1ByYmJ5QjRmRlJL?=
 =?utf-8?B?Zldod1Bkejh5bzV4ZEhjTmc0ZzN1QnFkcytZbk8rVmZBRUlDUThrZG42M3ZV?=
 =?utf-8?B?QStHQVNkczU2T1ZMZ2JkZGd5UkhyeHQrUEVIVjZVNWczWGRQN3liY1V1WWJs?=
 =?utf-8?B?aURza0ZPa0xPRFZLOE52SkJsckpvbmw4SjVxWC9MK3pnRVpTc2J3YXl6MHlU?=
 =?utf-8?B?L3d2SzhWMXc3ZFFKZ0JNekRQcEZlZ1RwWGovTXJHVWw3UFBrWkVYdVFtTjF1?=
 =?utf-8?B?akYxalVhR01EWUFPNnA3NlkwZUJTN01BSFNBSEdZQkVlUUFadHZJd29YT3Ar?=
 =?utf-8?B?KzRyZ2R5QzNmNlNmQnhsdmxqZElMMlJvazBuSVFTMlZ0N0R3OVArV1FWeEpY?=
 =?utf-8?B?dkRiNjIxUmZtUXVxR2xhaFFIQ2d1YkZyOVlKb3lmcG9aR1dYVDkvWnljR3Jq?=
 =?utf-8?B?ZVpQUGp6UVJmK2M1MnRTbzBINE03bGlmdHczM2JDRmxEbC9kY3lZRk1BVWJj?=
 =?utf-8?B?VC9PeDR4WjhuWmdLNUlZa3Z3VkFuOHZIUXdHemJxcGJmN2k4SHFkVTAzZnc4?=
 =?utf-8?B?NVFiVU1vZkFwOVBLLzVrNGhweGlDMS9oa0VEUGJ0Ky8rYmE4ZTdMVmszM252?=
 =?utf-8?B?eGpRc2lKeitkcHBaSFErYmNRWHlQeDR0UlhydmY3KzRCRTAzU295amp5MU9h?=
 =?utf-8?B?dkhVcVdsU2FSTjhySzJmWFVHOVN2c01pbUVUdXc1ZFRjbWtXY1RKNkdCN0xy?=
 =?utf-8?B?MVF0VWhTeW93QVBYU25Hcnd2VFhFUE9saEVYU2RHZUpMM2MxS2tLcVo1cm1s?=
 =?utf-8?B?U3FYWmQyazBZSkV3ay9SOUFKNy9zQ1Bma0hGdkVQblpRUVJseFhPcW16Q1pp?=
 =?utf-8?B?Q1ZMUjlSek1nNFRjanQ4dnVOa2hPQ0REU1k2ODNHak5UN2xSeWxzU0NUb1lD?=
 =?utf-8?B?RDZ4YmVibldLSGpqVVBHS2QyMmVTd0xMTnJ5YlkwakRqbDlVSzRwVDFIZUZ5?=
 =?utf-8?B?ZjV1NVgyQ3BtaGRnaWF6OGhxL0ZXQWFUeFFQWDBOU2ZCd1ZWcmtzMUsvazJT?=
 =?utf-8?B?emZmU2lUSkxKR2xZWWl3MEgyMWRrakJvV3BLQlkzN3hQWlIrc0NIMmtJMEJx?=
 =?utf-8?B?ZGhsZnZqZGxWRkVpOU95NFllSFV5TXpsOVZqdEZ6VEdCUm9JakF5RkJMNGt4?=
 =?utf-8?B?dmxkeTdlNU4xcmFseWlJRmxmb0thcmRvQkg4Vy95SytGUGxweE4rem9QOFA3?=
 =?utf-8?B?VElyY3FxbFZSNkxPVC9GZFhCRTlmN1BnR1pCQno4U0NpMnJGVy9tNHkyelpC?=
 =?utf-8?B?VmF1WHlRMzNTSUQyVFpmTWNJK3RwdW5LbDVvc3VWckdkalBtK0JkSVlaY1J2?=
 =?utf-8?B?L0NTSk1xOGFCcThXWEN3UUFVRXVGM3NSZjFrN2pScVlZVjhvR1ZkY29IQ2hi?=
 =?utf-8?B?OVM2TDlZZXJTaGkwT0dGTE1hU3gyb3dsdnBuL0J2bmhrSDhXcC8rOWRPc1dN?=
 =?utf-8?B?U3FCN21mWEVGWlhOYzY4MTY0M0ZTRmF1TDdPZXpOdnRYb3BTNHNnKzV4Y1NB?=
 =?utf-8?B?OWlVNDNlbTVKSzhGZUpjTTc0d05xRFFtL2RnK1BxcWhLNldwUWNVVlBNRHRD?=
 =?utf-8?B?eXJBcmN2TlRSY0pXOEU2aVRqMVo2eVBKWHRPbSt0NkRMRVc1ZEhVZDNtY2NN?=
 =?utf-8?B?WXJRYjlWWjljRXVHRkJkTnVQcHAvWmtBM3daS28zK3gzU09IUzdWNEEzRFZu?=
 =?utf-8?B?OHlmQlJkalY0RmdPelZHUlJzK2U3czlNemFXaEtYRXBxZHVxSGMxUkdYZll4?=
 =?utf-8?B?OThqdithUWgycGFqQitIdDNuREZGT1hKSVgrdUpxNmJvMHpWa0FESDB3MjB1?=
 =?utf-8?B?VkM3SlpUQXMvaHBQWWZVNXJiT3F0c2l6UnJjS3BMZ3I1Q0xkY1hFZmpTNlg5?=
 =?utf-8?B?VGpqbVFUUUJmSzh5TmNoelpPV1NJUG5lV3lORi9wY3hKd3ZOUkVXYk5td2ZL?=
 =?utf-8?B?SDFsSFg0a0t3ak5USWQyMkpnR3BHalczYlVacm5hSlFpZmtMbk9oTXJINUJn?=
 =?utf-8?B?cWRHazZTZXZEUk45NjFIZGs5RzNGOXliTCtnd2V5cUZIMTZrUnIwUmtpMkZh?=
 =?utf-8?B?Z0JqYlo5ZnRxc1VuRzBtcFJObTFITm9GcnVra3RMcDN4NTR0L002UVVLNGdU?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a928152e-46da-4fbf-a370-08dd514cd40b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 01:20:57.4817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/on8+jFdIFLW+tTKu6yO85wyUdO5LTf9XWuVE9BH0ugnl/2RK8HB8307RPGHHYiIqsYnYjo/c93PAmgSQgI7t4ROWaEKMrgTYyBekmOnzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6715
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:18 AM, James Morse wrote:
> Now that the visibility of throttle_mode is being managed by resctrl, it
> should consider resources other than MBA that may have a throttle_mode.
> SMBA is one such resource.
> 
> Extend resctrl_file_fflags_init() to check SMBA for a throttle_mode.
> 

"Extend resctrl_file_fflags_init()" -> "Extend thread_throttle_mode_init()"?

> Adding support for multiple resources means it is possible for a platform
> with both MBA and SMBA, but an undefined throttle_mode on one of them
> to make the file visible.
> 
> Add the 'undefined' case to rdt_thread_throttle_mode_show().
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---

| Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

