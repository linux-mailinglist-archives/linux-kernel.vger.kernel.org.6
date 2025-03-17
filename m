Return-Path: <linux-kernel+bounces-564860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F31A65BEC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4470189FB04
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147881AF0C7;
	Mon, 17 Mar 2025 18:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LnCbsLJx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B101A47
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 18:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742234893; cv=fail; b=FWgna40T7Q7ITjB+pMVRGUxCzoc8QG2N8m12SSliopyZFkx586HiF78SvuB6MIS1+VjsjDuOwdF7JvO3J31DBB0x6WeNM91yfNd+AOND0WVzYA+InUSYAX7HMi7zredUZbDpbHsMWzXRHPXkqsmeyDvyV3xV1amp3jqiojq2JGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742234893; c=relaxed/simple;
	bh=g3jDTzww5D0IwXYQNE6iVg0IkcOQLtSpFhKcMgdtU3s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R3NQOLwsa8I3Wz/5MGOnJ0C0JxQdALilnPpRjjmmtwVoa6osfOU88wMXU/wN5H4bzBufawQNL3LpSHROc6FEaELTrGMMTtXFugiEtN5qIZJoroS9tCCfPpr4Z5+GHuqy+ZYyGPNz3z0+zzy+BugS/PZrE3HDQTjnGobcpVXeGGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LnCbsLJx; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742234891; x=1773770891;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g3jDTzww5D0IwXYQNE6iVg0IkcOQLtSpFhKcMgdtU3s=;
  b=LnCbsLJxEjfNrhnVXNrRQetvdyOk36SGmP8fOAEbSFbOS1bBTCBPpGt+
   8+3R41tr1tYgB+9AXyEEKKdCswmWMiewyKkpphxcvFbCtvBic/sXyQQi9
   LiPD1dvcQmS4u0FIt0Z3DzuZv39MQ84kdstlmU1f++hekGdVQFtSAOAs3
   YskLgZ3hXhBGMhvYOvMHDB5s3cq95/zjLiDFL5xpBhLWuJJjl4voyn9lV
   JXN4yQMd5hBbZ6TII9bTkb3fb4UAuwTwGVFoWJVot9Vs7q00NCjQLxqst
   ET7WKyhJfPgGq1eqK8n8FSNgqs6g3vuocj227gZR84TdK4cGWOS7mkMzt
   A==;
X-CSE-ConnectionGUID: AJNmPVnwRUuqUYuOXX0LgA==
X-CSE-MsgGUID: H3kwzUDgRJOnbZLTFteCHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43081081"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="43081081"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 11:08:10 -0700
X-CSE-ConnectionGUID: 3upFjJNBRMqSutJwxbedtQ==
X-CSE-MsgGUID: QyDUXTwsRp22F33zqThDlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="145190114"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Mar 2025 11:08:09 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Mar 2025 11:08:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Mar 2025 11:08:08 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Mar 2025 11:08:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xiCblgPerKZmxuBHfaEJ28pktPAA4l1UbpSHZMqgC4wYMPIXlX0MjBtG2/0hyNp9UCo1TrUyGdFIDDXfY5HA41Fe8vOhiICjQRaKUQMgM6KHotE0ECH+Hd2OXX8HjYj8mN2j2vtyxP8OAf0N7HFXzyxeQJ81r/3D4hQiUDBlK4uti0mzhnK4ZtnWXNNepz0QcT7oPl3QFBeV7+nQibcpNIyctl9V7E/8xsLNJp8CEQ5F+p1eufuLiwRE6g1CROSvxJOB8IbXBbgWDogq/iBvpavrP2MobFjRDy8w9GExFFcL3kJe46B6yNaA/+ynjl/Yuj5+xaW/kqQ4GNsOGys68w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0k6mc6SZgAK5JH/wA/zO8Q4S9WcUgXhO/KA/YPC4enY=;
 b=NQi3qi2Xn2ThvFCHbmnvSQBDzynf/gLwI+iarE7mmJgi/Hj5l0WNTcZ4tCzOiJYyxx811mJwUl0vkp9kaAk5GSnqxpb0kXRhFJtZ387dVoGTb4u1Mqu4MiYYy9xsPOcS5lstfSIFIVRh4XEyX7VEVjwkoVcq7/eivW/PVNKRq2o+qDTgGo1kAoW7pZALJlQaOSTaWzNw73gH04dS4YByLgqQV5KN+9AUOBDDRYefYVPq/aUkHDYZ7Lp6uhvMG4eczUZY+jC7mDEb64tyMYE27PdA4sj++0p9waQ3U2XZarbUai94H32QWuvT+Mlf0vMD8dnS+Gl/agkQhWHYf1W82A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6005.namprd11.prod.outlook.com (2603:10b6:510:1e0::19)
 by PH7PR11MB8597.namprd11.prod.outlook.com (2603:10b6:510:304::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 18:07:53 +0000
Received: from PH7PR11MB6005.namprd11.prod.outlook.com
 ([fe80::39d2:ae29:6e3f:1b6a]) by PH7PR11MB6005.namprd11.prod.outlook.com
 ([fe80::39d2:ae29:6e3f:1b6a%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 18:07:53 +0000
Message-ID: <8d4edcf9-bcf6-4832-8840-dd8aed1639a1@intel.com>
Date: Tue, 18 Mar 2025 02:07:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/8] sched/fair: Increase probability of lb stats
 being reused
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, David Vernet
	<void@manifault.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, "Swapnil
 Sapkal" <swapnil.sapkal@amd.com>, Shrikanth Hegde <sshegde@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	<linux-kernel@vger.kernel.org>, <yu.c.chen@intel.com>,
	<yu.chen.surf@foxmail.com>
References: <20250313093746.6760-1-kprateek.nayak@amd.com>
 <20250313093746.6760-7-kprateek.nayak@amd.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20250313093746.6760-7-kprateek.nayak@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:4:186::8) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6005:EE_|PH7PR11MB8597:EE_
X-MS-Office365-Filtering-Correlation-Id: cbe1c73a-58b1-415b-c621-08dd657ea273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?emw1WVMrUkc1aG8xUFh6ZlJ5OTdwQTFiUFllM2t5YjAxMC8rd1pkYWdhTENW?=
 =?utf-8?B?aFdIU3V3V0ZmdFREejBkYVRoV09pOVNzc3F1ZFZ0blEzczVWWTd2Z1BiTmw5?=
 =?utf-8?B?TlF3MnBhNmhWMkxuWUtaOElpZmlteUFEZmJOQytCTlROT1hFRGdWZVhhUjlm?=
 =?utf-8?B?TXlWYXhvbExIRTVTakV6NUw5Tk5jbTBGQTBKcmsrYWxvQ09ZYXNpME9rMXJY?=
 =?utf-8?B?SmN6KzVzaTRya1VFcGhrczdxSEVQeFd0akF0VEF4Z0NNT1BOTjZMS2VpMERn?=
 =?utf-8?B?azQ3bm1ZRGFtOW9FeHRMRW05a3BwTHlnVTVqRTBsd0xpNlY1THFvWWFGKzVz?=
 =?utf-8?B?NWpTN0k3UlNpRU5la1VqSmdLcSs1Qk5hT1RaZTkyOTBWcGI1UWVxdzlQcTF5?=
 =?utf-8?B?bmsyKzd6SDFhWWZNczc0eUIxRm42UEpZb1kzMU9jb2h6SDdsSThNL3dwU0Zz?=
 =?utf-8?B?QmR2d0M5dHlQU2RJQlhDMEVSN1VkdXRtRVllcERLTFMxWXNLckx0ZTdWbTI3?=
 =?utf-8?B?bEFTSDJoT0h4RnZQN1BGNG9JeWhISnlEazlCd0c2b1NqVTRvdXBpTHg2TUk0?=
 =?utf-8?B?L3FBVWQzR2VRd2RReTdCTUhRMUJzS0lsOFlYdVlTaWxWVzhLSmFJMUszSWEz?=
 =?utf-8?B?aFZIM3FXd05EcHNtZGhReGlqOTZ4eXBXTUZDM2hjOHhlN25RRjh6dFpORExM?=
 =?utf-8?B?NDMyb2ZiUGNKL1kzRmxkYTlxUzJBcWw2Smg4VXlQS2h3K21xYmQ4TFBNVWN3?=
 =?utf-8?B?MEdYd3h5UTJET3duN2JJVGVNdENBNzVDZXVEQkc4blhGR2t4cDl1Nk1VUFRz?=
 =?utf-8?B?YXRodUZjMC83KzhyZi92RWV3eEQ4cXM4ZjZqYm4ybncwTE05ZkFETStwakhG?=
 =?utf-8?B?YVh1K0c3OGRjRzF1dmRXRkU2TnM5bzIvc3ZlelBEUEF1Q1pEWUx2UHAzM2Fh?=
 =?utf-8?B?ZXJub3RJaUxsWDNPNFBNOFdlWlllVWFNZVRFSllxRDQwRmVIN2FUQWxibTdO?=
 =?utf-8?B?MWxHS05Dc0duazhSQ2xRb0tKbGo1TDZUbzA1TGFVa09tNVh6SGlNNzlsRkli?=
 =?utf-8?B?R1p3dVIvWVlMR2Y0SUxIOGJ4cGV6YTJvNUh1bzZKQzMrT3BGZUg2dGZZY1FN?=
 =?utf-8?B?dmNkWTJPNldpc2dUVldaSjdFd21ib0lkNmNqV2ZwM25HVmxCZjVtR29aOWJW?=
 =?utf-8?B?cnZYREtaOEYxQUlIQk1meUxrQ2pUejlpRzhZOENoMmwzYTAzZlM1TG9Tcy9B?=
 =?utf-8?B?YmlBTjZHLzYrN2NrVXNMcm9NQkswRk1PUUsvQkVoRVZhWElzMk55a2F5bit0?=
 =?utf-8?B?cFlUMkJrdTJsMFJjQTUrWXZzWTBZdVRtUlBSQVFEVkdoWUZ1c0EvZzdxd2N4?=
 =?utf-8?B?Z1I4Q1NGU3lOcE1hNGYyUWZTVzdXWk5TMUtxNmFFMXJlcWdsUXY3a3FZRnBx?=
 =?utf-8?B?dXlUSEM2Q1doRXFSLzNBMW5rekd5Uk5ac2t1NkVDM2ZqWm1ZSTdYc0lETktJ?=
 =?utf-8?B?R09UdGRzczdWbXVKYitFV2RsbkxweWk3cisvSUZVMVNQRUNXeWF5NFE3cEJR?=
 =?utf-8?B?a0oybkdvSHRQY1N2Z2YvV3NTK3p4UEt3bTNlRU1DL01xTnVuUU9Nbk5IYi90?=
 =?utf-8?B?WmVNbXU3WEY5N2crVHhzNVlsbUk1Z09Bcm16ZkhaWGtkbHB0LzZib1JoUDJa?=
 =?utf-8?B?RmJvUzNCTk5hMWplLzVBaEJyb0IrRE4zRDhEdG44NFRSMWNvbXZzK2t3QWkz?=
 =?utf-8?B?Q3VCbTFnRUUwcVcvbitvRmYrNDM0TUhuVW9pVWxYeG8vMk0yT1hEWXhWRXFm?=
 =?utf-8?B?dWxHVzBuZ0wvc1ozQ1NpTzV1R0pKMTNHNHJJMFBLWTNRenllN2tBT3VnelQz?=
 =?utf-8?Q?NkldebNJUdnY0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6005.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE5OeWxuM01keEs3dGp2cC83TUdvZWVGZ1pmb3NpT0kvMExjQ0w3S1lMblp1?=
 =?utf-8?B?VEJLRDUzZ0tndGNqaEZwZDcvODU2V1lLb1p4cFZYOEtPOHZnQ3lCWXUvTThz?=
 =?utf-8?B?NEZjYUZBcHBIbWFJbHJKb0loU2FKUkQwVWpONHZCRTJBdlYrbGkwWW5xV3Nm?=
 =?utf-8?B?RDNKRnVaNHR4bkNMNStSekVwcXNIYmhqazlpcEdsazJqNSs2RU0rdmVlZ2Rx?=
 =?utf-8?B?dVBJTU1wWTZac3dXcmxES050bDZxby96ZnJuZkJQRDVkNndSNTZheHdNOTBh?=
 =?utf-8?B?OVJMZ0sxOEQ4V3VOUjRzL0RkczVQRWxLVi9yT01SNnl3NmxlTXdCVFowUzJ5?=
 =?utf-8?B?bTFHbXR3anZRQWYwdG9QSkVJaHhscDZiMWt2U01IYkdQU3pmbGdUYXpGck44?=
 =?utf-8?B?TnY1VTBwbVFYUFVrc3VKWE0wcXd1WEl6VzBTaVVFZDBxNEg0UFJGTWtKMHNT?=
 =?utf-8?B?SmZhZzVrOXZER3RYNzJBRGdWb1dOSmRMQ3lQN2F1NlpFSnltQ3c4RVlndzhm?=
 =?utf-8?B?S1FZMWN1eE5lWWw0RFo0RXVrZU83aDF3OHRtUnVNRXhwTzBXYmpzdzRLVFlw?=
 =?utf-8?B?NmxNSTc4a01ESU1lTnJGN25uSlcxdTIyMTY5T2ZScGliWENtdTdWTkVucnhi?=
 =?utf-8?B?QkU1SG5ZZFZkVXNzNThRSEd2UlNmTm1tZ0pWekxtRkhzZXlCQkNqL1VTZjFR?=
 =?utf-8?B?aHlIUHRNR056V3YxcmxZcEJ2T2lnK0tLMXZkSGVvbmJkaFlXU0x1QW5KRk1y?=
 =?utf-8?B?ajBZV1FXSkdoVGt1S2dVMVJib2ZhT1AzQ0U5RWNBOE45WmVOK0pZMDJ2cmRa?=
 =?utf-8?B?V1BTSHc4WFc3V1FKcGhwU1J6eTh2VUVGbGJWc1lPdlhnNGMxY0JQbTBHclhu?=
 =?utf-8?B?U0JLYi80b2R3NmFSNlA4WXBNZEpFZjVNRU1NMGNDVlIzazlRN20vZ25CMTYr?=
 =?utf-8?B?My9JMDJzNExjbUoyY3JBVDNueGdIVDFKa09vQVJFRUFHQ0tmSk5WbUdzQjlr?=
 =?utf-8?B?amRqZXFqSEdsZHdXbmJ2SUdpaTVCRjg5T0JNSGpsZUtCYUcxblJHQUU0REhJ?=
 =?utf-8?B?YU9vb2ErVzRRemJJWkJwbWhtOThRUzc0OEhFclEzTzJkOXJRT1Y4Z1Nmbjlt?=
 =?utf-8?B?VG16R1ByeW9ZeDl1cjNlUWVHMmdaM04wUHBQZS85MHdBeFAvYnFFaklCYXIw?=
 =?utf-8?B?Y2FzZTk2Z0ljczY1T1Fic1pPWm1VMjVnUkY3MVJsblFDaWM4YmZ4Lzh4WjBo?=
 =?utf-8?B?em11K3ZhZEhBT28ydGVNK2xaZ0EzRlE3YnJxKzIwWWxCaDVsakQ3WlRnMGpP?=
 =?utf-8?B?NlY2UzhSYW04a21JaEYvZGFhL2hCSVRlZjdSQi9DK0N5TGJwVXh4dlhPMzY3?=
 =?utf-8?B?YTNZWEVCS3QvZHlkZU1XS1VXK1IvM3lUL29DYmFINWtlR2swMzl1d1MwRDVK?=
 =?utf-8?B?a0EzREJTZk0vOVA0TWhXRmlaTDBNdnBNZ2pnaDhaTCtnZHVtOVN5MnltSHFW?=
 =?utf-8?B?dVRralFYdEpCVzNIaFU2ZlZZYVJhZjdydHpPK1E2azh2NlRYazB5MVFmU1Mx?=
 =?utf-8?B?OVNYU2xIMmwyNVBxVWxmTVRWVkhZUWtTTGFqWVlseDNISkN0LzFyTnRsMC9G?=
 =?utf-8?B?NGd4dHFxTXlSOURaNGh0dEo5Z2UvTitQTFlHaDlKNVl0SFhrMTJHeFg0akRI?=
 =?utf-8?B?NjNKNW1hNmwzUnZHb2ZkNitqWGI5ZW96MWlER25hYnlsVndpSk15Z2h1bm41?=
 =?utf-8?B?TFJPbHJCSDJsVGxvaVY2YkRXby9SZlh3YWF5TzA4UzdYKzZWOExPeGhxaUl6?=
 =?utf-8?B?R2owRG95WGwya3g0YTFaZWMyRkJuK0Q0RCtZUkdJUFRRdVdnS0RrVFN3aGpC?=
 =?utf-8?B?TmZpazZIbGpoZXVjTGl6VGkzMitjQWtUNDFKMk5senRUNU85SW1yZXVHYUJ0?=
 =?utf-8?B?VmRUd0RpSE9jaDBYVXN6TFY1bGl1TmsyTUJQbGptNWhzNk4wN3lMa21PTk1i?=
 =?utf-8?B?UVlreGNzcVE2Rm02OHpNWWxlVWppdy93QjVadGFSNHdvbkI5bTM3aCtJMkc3?=
 =?utf-8?B?WUJrMXV1UjRORnlrK1NMeHdsSDhEZWJUWEt4Znh0NTRjMU9sNWJXMGJtcGtG?=
 =?utf-8?Q?3XLbrEBQ5LsfQViBVHR/CFvrZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe1c73a-58b1-415b-c621-08dd657ea273
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 18:07:53.2464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YwTiV4sUG99AN9PE9iNrdwEPVQC/M96KW1NCWllHJYfnOlWbGansfFXde6Pmx+x8JFM0c9AUCDY4QHuSvoK46g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8597
X-OriginatorOrg: intel.com

On 3/13/2025 5:37 PM, K Prateek Nayak wrote:
> The load balancer will start caching the sg_lb_stats during load
> balancing and propagate it up the sched domain hierarchy in the
> subsequent commits.
> 
> Increase the probability of load balancing intervals across domains to
> be aligned to improve the reuse efficiency of the propagated stats.
> Go one step further and proactively explore balancing at a higher domain
> if the next update time for a higher domain in before the next update
> time for its children.
> 
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>   kernel/sched/fair.c | 18 +++++++-----------
>   1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 3b1ed14e4b5e..60517a732c10 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11956,15 +11956,6 @@ get_sd_balance_interval(struct sched_domain *sd, int cpu_busy)
>   
>   	/* scale ms to jiffies */
>   	interval = msecs_to_jiffies(interval);
> -
> -	/*
> -	 * Reduce likelihood of busy balancing at higher domains racing with
> -	 * balancing at lower domains by preventing their balancing periods
> -	 * from being multiples of each other.
> -	 */
> -	if (cpu_busy)
> -		interval -= 1;
> -
>   	interval = clamp(interval, 1UL, max_load_balance_interval);
>   
>   	return interval;
> @@ -12126,7 +12117,7 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
>   	int continue_balancing = 1;
>   	int cpu = rq->cpu;
>   	int busy = idle != CPU_IDLE && !sched_idle_cpu(cpu);
> -	unsigned long interval;
> +	unsigned long interval, prev_sd_next_balance = 0;
>   	struct sched_domain *sd;
>   	/* Earliest time when we have to do rebalance again */
>   	unsigned long next_balance = jiffies + 60*HZ;
> @@ -12136,6 +12127,8 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
>   
>   	rcu_read_lock();
>   	for_each_domain(cpu, sd) {
> +		unsigned long next_interval;
> +
>   		/*
>   		 * Decay the newidle max times here because this is a regular
>   		 * visit to all the domains.
> @@ -12162,7 +12155,9 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
>   				goto out;
>   		}
>   
> -		if (time_after_eq(jiffies, sd->last_balance + interval)) {
> +		next_interval = sd->last_balance + interval;
> +		if (time_after_eq(jiffies, next_interval) ||
> +		    (prev_sd_next_balance && time_after(prev_sd_next_balance, next_interval))) {

(prev_sd_next_balance && time_after(jiffies, prev_sd_next_balance))?

thanks,
Chenyu

>   			if (sched_balance_rq(cpu, rq, sd, idle, &continue_balancing)) {
>   				/*
>   				 * The LBF_DST_PINNED logic could have changed
> @@ -12174,6 +12169,7 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
>   			}
>   			sd->last_balance = jiffies;
>   			interval = get_sd_balance_interval(sd, busy);
> +			prev_sd_next_balance = sd->last_balance + interval;
>   		}
>   		if (need_serialize)
>   			atomic_set_release(&sched_balance_running, 0);

