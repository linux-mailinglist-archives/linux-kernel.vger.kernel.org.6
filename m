Return-Path: <linux-kernel+bounces-564857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05336A65BE2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9C1F7A5A17
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9F51B0F23;
	Mon, 17 Mar 2025 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kZEuo45a"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2089D1ACEDE
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742234750; cv=fail; b=RBIMSut06rzY0mkS0/jZfhxm97vlTH/a1b4V1/pKZ7HBQOSuKDPNLWyDiTfR/CFP8GXX/w4xSB6g2jFNUrkWEqfTCnzTHhGqyPdOHiCNbZ/7fg7N9vh1jkGPPD4YEwpqmWj21dzKL+x9e2+OIiHb0UdfH4Duol1Zl78i+AZwdUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742234750; c=relaxed/simple;
	bh=9xV7sxcb6XZLZOwOJQ6QMNrpELSNM8o9wZvIbpAh0eA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O8eP1EvlGknRBOpD3FsP03h4WW1DmdCVI3RvZMg8AESxIA4REE6udDYXERw3DFVJLUwakC1Y1OqKaZlyoRmVu6Z9aUxRNOE1SqzbX/1tHPC5hBxZzjvLOi4USdKgesHxD9Id953B1hrIAvNWWi7P/Bp94qEIU3nhz/SXhVEmhMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kZEuo45a; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742234748; x=1773770748;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9xV7sxcb6XZLZOwOJQ6QMNrpELSNM8o9wZvIbpAh0eA=;
  b=kZEuo45aJTYfoNq3kkxVe/LLBMPtURG4N+GnWZ7hfMOVN29GRUT53WhR
   CqxJjd9a9zXtadVN1bTp8mRJUGNXlY+cmzw/AD+fAlXXxYm4tKwaeCm6y
   232V+dm8k9UU4Apel6K8orCZ4wc1KHLoMjBbG4ZZ7mVDxjFAwCO1S5oPb
   deCnd8N9qJwUKF7xUTmAZrSqGCCq42iN/kmlu8FREaJkELr3z0CyP9wYH
   wmtMKBFmnT9i1ljm7seAGCOPCpfOughTqumYCbktur8/SQYWWaVSXN0zO
   J0DV0CcR7mHmKHGPEblrx8dX2a3+xKke5DtnZWJT0/xl4Tm8vjtOOOht4
   w==;
X-CSE-ConnectionGUID: BaOeV+neTRmXzF/UbI5qVw==
X-CSE-MsgGUID: poPiuFO0TnS/2wPJwhBphw==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="68702066"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="68702066"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 11:05:43 -0700
X-CSE-ConnectionGUID: DvbG86BDTtK5RMV2Q7QKhA==
X-CSE-MsgGUID: XhBMatfAQnqO7xFe6imyUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="122962561"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 11:05:40 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 17 Mar 2025 11:05:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 17 Mar 2025 11:05:39 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Mar 2025 11:05:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZjCnfHtbAlFucsaOqR2QryWQYlagQ+bX555HOs8/HBfPL111WcADRWcZ3l3mKx6TA6YL1xznOH+0BA5/WA9JHMtRsG/3dtXN77uX5DmUQ2csOFBvPyfyKmDhX2MNRCqSislSK8L9JfSLgZ56VPPqcmjq3QAsa4NE/TzKDa7olRc9V503a67tL9IXaAXE0OpkVeCHgRTbrt3V3iBj3FY0q8T7Vu2A8VIxIKHU/IWbBC+Xdue0N/yLTNm8kq90DF1EIlVmcy+yFH3jZsUUIvgQjKnFKtivChkmoCtc7H9utT/cUIixIf3jUPjX6no+i1/3pfgbO6z0G7pYemhy1zuMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgOXbsk5BKcuWuNKSkDQ4WKyFcFHNUfZtaqTp6O0UHc=;
 b=LGrFHxCjok3PR3j3EJ97XSQS1219BSqGjjqx12ZG5CmTcwq5iX/C/upCiE5hgbcyWVq3AEXRw/iJnG8Nfe7Us395JKIolLu2OiA371n+4kkCO9y/EPhwkqy5q+TLOlOattMzTGjmLkSBluunDsQp6YlEMeyNHeEBUWbgDIHzXBkbYh5ubaZwPFCOfCgJMcnHme5vydd2Ht825urcq+iFRxf0elT/zcFb0LJ2ns9+Kcz/yY01dW2mSAi1SD98qgiAOvXwerWtifjG3HDFDCs4wpc+JSNGLch5jbs5qaaW8yunRoac9kOh7Tz8N3ZYodvjZ4zyExwAOnEDyOxMccvfUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6005.namprd11.prod.outlook.com (2603:10b6:510:1e0::19)
 by CO1PR11MB5121.namprd11.prod.outlook.com (2603:10b6:303:98::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 18:05:08 +0000
Received: from PH7PR11MB6005.namprd11.prod.outlook.com
 ([fe80::39d2:ae29:6e3f:1b6a]) by PH7PR11MB6005.namprd11.prod.outlook.com
 ([fe80::39d2:ae29:6e3f:1b6a%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 18:05:07 +0000
Message-ID: <3915af7f-fe05-4a1b-a8b2-e9690827b916@intel.com>
Date: Tue, 18 Mar 2025 02:04:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 7/8] sched/fair: Retrieve cached group stats from
 sg_lb_stats_prop
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, David Vernet
	<void@manifault.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, "Swapnil
 Sapkal" <swapnil.sapkal@amd.com>, Shrikanth Hegde <sshegde@linux.ibm.com>,
	<yu.c.chen@intel.com>, <yu.chen.surf@foxmail.com>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	<linux-kernel@vger.kernel.org>
References: <20250313093746.6760-1-kprateek.nayak@amd.com>
 <20250313093746.6760-8-kprateek.nayak@amd.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20250313093746.6760-8-kprateek.nayak@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU1PR03CA0022.apcprd03.prod.outlook.com
 (2603:1096:802:18::34) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6005:EE_|CO1PR11MB5121:EE_
X-MS-Office365-Filtering-Correlation-Id: d78684b9-65ee-4a0e-23dc-08dd657e3ff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UnJBN2dqcFhWRFg2MEw0cUZVeUJ4Ti9OdWl3N3o3Slh5bTlhUUxjM2FvRzNk?=
 =?utf-8?B?QUV4K0xhSC9ESllDSjlQdHUza0pFL3V0VktmZklwOEI3Y0g3RFRHZTdPcnBB?=
 =?utf-8?B?L1VjSnpMQzFid3RTcHpidmJIaUlvam9ZYlpjbDNha2gzaWV4NDBnOXhMKzhv?=
 =?utf-8?B?R1dxUGdnczFaclVmTHZsMU1vZ25jcjE4K2JpSVNGQlFUUXJUR2dIeWRDb3l1?=
 =?utf-8?B?alVLc1MrRXpvQmR5a1VBZVpxeWxkYnZ6ZmhFdFRKdDNIaElxN1JCYzVSYmFI?=
 =?utf-8?B?dlFMMDFYc2pucDJPQ0NpR1JMNVdCZW8vMU1wMmV4Wm5VUnpoRVdnRXMyelZK?=
 =?utf-8?B?N1lmNGU1SldOZTFuSWR6OEhvOStzdGh0Qk4zS3h5aVovazJLTHhTRHNseG9Z?=
 =?utf-8?B?NHNlUi9zZkJhMTA5cDRYREFqWWFuQldiOEpZY2Y2bVhGbFNUYkdURVhJR3lm?=
 =?utf-8?B?b3c5eFZVZU0wdjFXanVwKzBIUTNKU2pKajBhWjhhOEZGN3ZQWG9CVXdubkNm?=
 =?utf-8?B?QVVxS2llbDFzdUFobnFISzZIb002SUY0QnRTQ3NKYWhmUkh5U2xqQmJ3YXp5?=
 =?utf-8?B?Mm93cHdVVG5nRlpyWVV0c1dRc21mVm9lVkltYllBSmxjeS80UjVjV29CeTR6?=
 =?utf-8?B?cXc5WUE0ZnBGWFplbFhJZFM3UkpKVSttYURqYTdnYUhZVnUwUGs2UjNxY0dz?=
 =?utf-8?B?bFJqNnBIZEJHQ2tkV0Vxb1crMUR5dGNGcVNsM0o5UFNRTWdQTnZFc1FTK2xC?=
 =?utf-8?B?eWZKT3dtTG44dVBIN2ZGLy9lMnkvSFRzc0pkZUxtZ1JGVDFRUHlGZ2k1Nzh5?=
 =?utf-8?B?cGxQOS9sNWRMcktkaWtTN3VORldLSGRVZGtHZGcwMGRBbjB5RVhJMEh6Rmgw?=
 =?utf-8?B?aERacXVad0NDL3p5dGNXbm82QkQ1Y3lEYUp1Y3h0TmdHZ1JLL3cvVjYvRmQ2?=
 =?utf-8?B?R0pnakN6Wmw0OGUzOSt2VCtDZnU5ODZTWFlkRzZlMGhjQ0RRU0lSWFN0OGlt?=
 =?utf-8?B?MXVrMk8rTzRDSDQ0RVJjY0Z1Y0dTTkFDS0dFVUZnaG5BTlVaTnJVMmN1NTQx?=
 =?utf-8?B?cHc1dTdtY3kxd1ZOUEptNjd1b0lSV2JJOUVDSFp0TldDVmRSK2VHWHAvZys5?=
 =?utf-8?B?WmtJV3dTcnQyZk55a2JPY0pzNUNrNDJvV1JrNDlraHc1VlQ4a0tYemxaNWkv?=
 =?utf-8?B?bWpheVFXTkVoZUtUbDl0TTZFY2VOSnpzQmlKWi81d2ZUWW95bzF0T0ZjK1du?=
 =?utf-8?B?QUxZRm5pK1VqWmt3ME9WYlF3dnFtZkFsNXBtZWlDK2lld0hsVWEwVTR4d0sz?=
 =?utf-8?B?dnM3VEJabGdER1hueis0bTRxem1IM241R0FxNVoyNW9Hc21GYWYrNmQrT0lJ?=
 =?utf-8?B?ZUIxUEQ5THZhakJTNC9NM2VOblNpbU5UM0tnc2J6bkJaU1hBYnFPenhFRzdz?=
 =?utf-8?B?U2VVbUc4VWRkcUpFbDRDOUhwZzlWQ3p5Ty9JL0NSZnp4M2pJZzgzTER6NzFB?=
 =?utf-8?B?S2FJNDUrLzhRSCs4MTVzVnhJengxSGdhclI1R0FxNnJHZmV2MVgvdjNHMDJB?=
 =?utf-8?B?T0pvcmNwaVVKR3RGMUZ2YU1RMHdlc21uUXdkLzJoZ082bnpoenV6ejhJZ2xw?=
 =?utf-8?B?bm8yVmp5UGhYQjArSXJJVzBubXJ1T1k3Tk14WTJHWjhwanp0cTc2YmxPNjZM?=
 =?utf-8?B?MjlHWHVDTlhuZ2hHb0NuZU1EYnBHN0s5TmpsUEFyZjJBWXZlVFFDek03aVVx?=
 =?utf-8?B?WXhhOS9iQzRxN3JobUxrZi9SK0JZVlhJamUxZ0dUZjNPd3I3cWoxZ01oRlQv?=
 =?utf-8?B?cWtWeHY1amRTb29GQXFmWlZxK0FCQVY4a3hNQ0gwZi8xUHJZYWNoRnlGV3RB?=
 =?utf-8?Q?sl/6z6O8Lzq7d?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6005.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3ZzTWFaTGszL3dIckI0NnhxSVdOM2J5emMrYXRLK053V3I3TEtCMkFKOFJn?=
 =?utf-8?B?SVJGMDdIYjlZQUdkWEwwZnVON09oSXJ5VFNoZ1lUaWtFR1E5VksyZzI0TUJT?=
 =?utf-8?B?VFZFUTdRbzloRzdHZ0pxMXZLM3FRVktDeDJISWdNdUhRUEFheWt0M1dHVktx?=
 =?utf-8?B?QjhmK3p6ZGlMRUkxWkErQkRWNmFoajRVTnRBUGxxaWNMYU9ZRlBZYk1iUFoy?=
 =?utf-8?B?Y1gzQW9IQkVpN0cySHZuR0hBQU15RTBXdWNUZjFRU1p1ZmQrR2VEbVZLdnhh?=
 =?utf-8?B?dDdhMDVxWUU3VlptbVFpU0Fhd2RjNVpjZFdENFNjZmxhZEJaTjBoQXNjSExw?=
 =?utf-8?B?SWdSSGRRRUVIQnZtME13OWljQkJwNEVaZzd1U1N3WExyOGt1c3U1ZjRPNU42?=
 =?utf-8?B?VW1EZk14bXBqVURpTWVEbTNRQ3plbnArMWRlemNSWXd1VGJRTzZtQW5MN3B6?=
 =?utf-8?B?MnpXWmR5ZnNJSG5raFhLcnRiYVlaUVZUYkNFRE9TRkFwbXVVNFlyS0s1OUx0?=
 =?utf-8?B?aVZqL2RjMzlhWTB0Um1OWEVDYVNCTnNML1BKek16cit0bnN4QUovS045ZzlF?=
 =?utf-8?B?VGZSbCtrQUNiakVXc0pTamg5b0FNOHJ0NkZyVnlxTHNqMlcyVTFoTXZKVW9D?=
 =?utf-8?B?cEFsRWhjUWppMGtacWpURzBOaS9yd1V3eTNyNmxGUVBBK21zT2lSV1AvTmJE?=
 =?utf-8?B?by9KZXJZL1lWK3kyMjBhVUY5eklUQU4vNk1zSHNwd1JEUGhNRmRUYnBlSFVt?=
 =?utf-8?B?V3VtbHhvdWdsa3N6ZFVhT3VzT201WjJ3TnNoMTBNQjE2QnZDOVl0MWZWSFV2?=
 =?utf-8?B?VWRRamEvNFUxWXNJbk85dy9sZkRwSFVaNUh1Q3lsNVlob0xJdFlrdzZ2VWxy?=
 =?utf-8?B?WWNmWVZ2L1NlY1MrQ3lyZU9UU3ZWMnZIcEJRcElGaTNxNVlOQS9mNnZSOWpw?=
 =?utf-8?B?dE1SQmxzRDlBTG9iVGRjN1NFSXNZbk5IZUUwck1ielJQNlo5a0Y5ZjhHTy9n?=
 =?utf-8?B?MThlM0FwZmdIaDJwTGNhdGp2SnVqbjRLbXl0L2l0a1p2NkxEdTdnb0NGNE9n?=
 =?utf-8?B?a2Q3QW85U2VIWitQUlNyVmg5NmNDMnNZTENpdUdTUldJN0xhSTBPdWMyczNL?=
 =?utf-8?B?U3dNWVBCWnZPSmlucHA2dy9iQ2VaQnBZQ0U1eEpDN0Mwc2xvNjNIZUtpbDc5?=
 =?utf-8?B?d1Zib3Jsai9teXNEN2U2dGJtM3o2OWNwQ1ZVU0l1SUJxbmpqY1ZzWGZPZ2Jh?=
 =?utf-8?B?bWx2REhyaUZMRlI4b0taS25rZ3hmRHBVTTZMa1J6Si9uaVJNVy84SksvZUla?=
 =?utf-8?B?OE50dHZsZk5nTEJPMiszNUxMOFVxd0E5dzVFc2hoYnpDYUNmR3pEYzRVSXd3?=
 =?utf-8?B?dXdWNUdMVWgvSlErMTVlMlZTbG1LL3RFZXArbGEwemoySko1YnpOVWpTRmRp?=
 =?utf-8?B?S3Qwc3FkSm51YXZSNk9UeTU4VEtSemFDbTlNa2xvVVpZcmNCSnV3L1p3TzBw?=
 =?utf-8?B?eVByTlo4VER6eWFmQWxNNzVLc1l4NncvUE5oQ1duaTFxNFZRWEFZS1Rsdksz?=
 =?utf-8?B?S3hGNXRCdFY5ZHpaWFAxNld2emVMVXBsb1lLSEJkQlBhNk5NaGtRZFUvTnVN?=
 =?utf-8?B?NDQzRm5MYkhOQ2prTVFYSlRFbk5RbW1yeitkYkpFUkMyeGcySCtoOU5ybjVs?=
 =?utf-8?B?cDR2QzduOWhZL1FBUThnTWVOTzhaeXA3MWp3UjRmMUd3VlVTR3hFeklYUjgv?=
 =?utf-8?B?d1R5UmVYaVVTRGV0Mmt5VEtibHZrVTBvRzJQdHhMTXk1RlJ6UmtZVUxONzRM?=
 =?utf-8?B?R0xydi84MWttQkMyaFYwTXN2cDN1aDZKQm1tQXpzc0wwRUVBcHErZHIyMkI3?=
 =?utf-8?B?a3JoakRWNHRiejRvQWpBcEFMbmxFaVhLTlorQ0RRSWNmdmdoVFJ6VTVxVTVT?=
 =?utf-8?B?NFYwVFJSeVRYazROc2YrMU9aV0hMRjd2bEpwSFB6bngza3dXM0pWN2VIbjFQ?=
 =?utf-8?B?ek9rdjhQWmFud3V1Mjd6Wkw1WHhBM0lrc3J0VEJuUUJsQldkOURTVDlEc2Ir?=
 =?utf-8?B?NUhNc1ZBeFkwUVdvZi9WdFpXcVZCSTQ5UnEwYUJMSUJyTFNKOXVJbGxpdjRt?=
 =?utf-8?Q?qJTSGJE65aaNBPKbzO/QpcsA8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d78684b9-65ee-4a0e-23dc-08dd657e3ff2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 18:05:07.8558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rgPOJzKfmUnFZrOCiZ3vh3R42ql9BefLqhc9OhkbQyoWIixI4L93tXGkgHzIdPk2+55U3qStd08hjRkWjHzy2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5121
X-OriginatorOrg: intel.com

On 3/13/2025 5:37 PM, K Prateek Nayak wrote:
> Allow update_sg_lb_stats() to retrieve the group stats cached in
> sg_lb_stats_prop saved by another CPU performing load balancing around
> the same time (same jiffy)
> 

If I understand correctly, we allow update_sg_lb_stats() to retrieve
cached sg stats if another CPU in the same sched group has just done
load balance within a jiffy ago, say 10ms for CONFIG_100_HZ.

There are two roles,  writer who updates the cached stats,
the reader who reads the cache stats. For both cache writer and
the cache reader, do we trigger them only when it is in busy periodic
load balance? If yes, consider the periodic load balance is usually
triggered on 1 CPU in each SD(should_we_balance()),  and the
interval increases with the number of CPUs in that sd, just wonder
if 10 ms is a little short to find a cached stats on large LLC?
thanks,
Chenyu


> Current implementation without invalidation of cached stats have few
> limitations namely that the stats reuse is limited to busy load
> balancing since stats can only be updated once a jiffy. Newidle Balance
> can happen frequently and concurrently on many CPUs which can result in
> readers seeing inconsitent values for the propagated stats.
> 
> For this iteration, the focus is to reduce the time taken for busy load
> balancing allowing the busy CPU to resume renning the task as quickly as
> possible.
> 
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>   kernel/sched/fair.c | 83 +++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 81 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 60517a732c10..3b402f294f0b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10275,6 +10275,75 @@ sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
>   	return check_cpu_capacity(rq, sd);
>   }
>   
> +static inline int can_retrieve_stats(struct sched_domain *sd, enum cpu_idle_type idle)
> +{
> +	/*
> +	 * Only under perioric load balancing can we ensure that no concurrent
> +	 * CPUs modifies the stats being propagated upwards since
> +	 * should_we_balance() can allow multiple concurrent newidle balance
> +	 * to progress and an idle -> busy transition for idle balance will
> +	 * require the stats to be recomputed since idleness metrics will
> +	 * change with migration.
> +	 */
> +	if (idle)
> +		return 0;
> +
> +	/*
> +	 * If individual groups are separate NUMA domains, migrations can cause
> +	 * preferred task statistics to change and will require recomputing of
> +	 * stats.
> +	 */
> +	if (sd->child && (sd->child->flags & SD_NUMA))
> +		return 0;
> +
> +	/*
> +	 * misfit_task_load requires recalculation on SD_ASYM_CPUCAPACITY
> +	 * domains. Skip caching stats for them.
> +	 */
> +	if (sd->flags & SD_ASYM_CPUCAPACITY)
> +		return 0;
> +
> +	/*
> +	 * TODO: For CPU_IDLE case, invalidate stats for an idle -> busy
> +	 * transition but for the time being, save some cycles during busy
> +	 * load balancing.
> +	 */
> +	return 1;
> +}
> +
> +static inline int retrieve_cached_stats(struct sched_group *group, struct sg_lb_stats *sg_stats)
> +{
> +	struct sched_domain_shared *sg_share = group->shared;
> +	unsigned long current_jiffy = jiffies;
> +	struct sg_lb_stats_prop *lb_prop;
> +
> +	if (!sg_share)
> +		return 0;
> +
> +	lb_prop = (struct sg_lb_stats_prop *)sg_share->private;
> +	if (!lb_prop)
> +		return 0;
> +
> +	/* Stale stats */
> +	if (READ_ONCE(lb_prop->last_update) != current_jiffy)
> +		return 0;
> +
> +	/*
> +	 * Pairs against the update to sgs_prop->last_update to
> +	 * prevent readers from seeing an inconsistent value of
> +	 * the propagated stats from a concurrent update.
> +	 */
> +	smp_rmb();
> +	*sg_stats = lb_prop->sg_stats;
> +
> +	/*
> +	 * If stats were read in the same interval, it cannot
> +	 * read an inconsistent state since stats are only
> +	 * updated once per jiffy.
> +	 */
> +	return time_before_eq(jiffies, current_jiffy);
> +}
> +
>   /**
>    * update_sg_lb_stats - Update sched_group's statistics for load balancing.
>    * @env: The load balancing environment.
> @@ -10292,10 +10361,19 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>   	int i, nr_running, local_group, sd_flags = env->sd->flags;
>   	bool balancing_at_rd = !env->sd->parent;
>   
> -	memset(sgs, 0, sizeof(*sgs));
> -
>   	local_group = group == sds->local;
>   
> +	/*
> +	 * If stats can be retrieved, we are doing a busy load balancing.
> +	 * Skip right ahead to group_classify() since group_asym_packing and
> +	 * group_smt_balance is not possible under busy load balancing.
> +	 */
> +	if (can_retrieve_stats(env->sd, env->idle) &&
> +	    retrieve_cached_stats(group, sgs))
> +		goto group_classify;
> +
> +	memset(sgs, 0, sizeof(*sgs));
> +
>   	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
>   		struct rq *rq = cpu_rq(i);
>   		unsigned long load = cpu_load(rq);
> @@ -10360,6 +10438,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>   	if (!local_group && smt_balance(env, sgs, group))
>   		sgs->group_smt_balance = 1;
>   
> +group_classify:
>   	sgs->group_type = group_classify(env->sd->imbalance_pct, group, sgs);
>   
>   	/* Computing avg_load makes sense only when group is overloaded */

