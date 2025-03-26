Return-Path: <linux-kernel+bounces-576710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B94A7136A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7528E189788B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3D61A4F3C;
	Wed, 26 Mar 2025 09:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bjg+mGno"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D1A158DA3
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742980551; cv=fail; b=QV6/lC6bXem2/aZRzCRSpTwAFGCv/5EjWmLd3V8aPVTXxiFkuBTZ3ePmarZLdY6bPcSorOa8gRZH737QYerqKKFvTPB1PDVxdf/04QNaYxIYap0Ql1DuZ8/CI4Jqmh8kkyYMvJXUTG1fxCknE3+JYGU4EHx0aFCezF0bObF/kqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742980551; c=relaxed/simple;
	bh=DEmlNaaciG5Wvlp6W7zBzbT3MfP2QxH0+quUKACqlk4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vr/ctKyxnHd9ZS7BrX6jq3/ufg3YxJsjvuHBBmsErLmqthVff+yL6kCJbacTjvyZrfTvqr53/FjXMNT/jwKqHQ6PqbesvJ6ld5FsU0nhwTbLrtOLwzw02K5gn17CD7/F4eAekXNJrRf4u2R0Cr5ehf/VNhrRdhKkeEaqWQZiPzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bjg+mGno; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742980548; x=1774516548;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DEmlNaaciG5Wvlp6W7zBzbT3MfP2QxH0+quUKACqlk4=;
  b=Bjg+mGnoHZiEMIZUf0Fq53yLvNSrFWQGBSUc2CpMaQZImRA96CBbJpWw
   nQSRPZJFrS+PwiV67lRCYTcQS8by5wPsaDuAzOnxwUadbbS/Ltq4LarBO
   Awh2BquI8cm3TQfYKbOaK0IkYThGUZfMPjiawa8173XaLSFKz7xfdbhYR
   L6vbO0xP1qEc/zWMWRaooUO2ltB4eouElp1PcDhY852AKA6FyHW96Qy91
   8JmbJz5SWgkCHXXpzH7h2gFrCtc0fgvSrDZMl/Ib5DdlTwmMkIzpbAY8x
   b3XKJyYvyw2NGpwytq/ifYHSfT9u9zLvLWd+3wGrCEGO42Rv7MBAmpUQ6
   Q==;
X-CSE-ConnectionGUID: st8VfAiQRSqQCZlKDuaVkA==
X-CSE-MsgGUID: QsOrFa5HQJSLMALjPGc+TA==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="43985954"
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="43985954"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 02:15:48 -0700
X-CSE-ConnectionGUID: xjR3Y6RUSo+UB/BGh9ZeHw==
X-CSE-MsgGUID: c6JmCS0qQHS+/4uWiODabg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="147883766"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2025 02:15:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Mar 2025 02:15:46 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Mar 2025 02:15:46 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Mar 2025 02:15:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5Ggen8yoLNq4nxb5qfueKK/FFrfMNajoRKrRZuDp8/QJiMSCsprmQltJKEnyUeyyAHX4Am1tA7y1LEqQWuCA2ZIqTLY74PGEjV7TiUY1rAF4oflGg5Q690QDhpokFRIfmXYFRFWcUa6OGdLD9WHR9Gx9fUtFS3C3jdJoRKlkL2r5Bh3G3x2MycXKUcWd+1SiHk1kB7aq0WMApMHEgGbHaL1zRnHBNCEhbu7caxENMdRXuwfZf0+QPPJ/H0V2QgZ5X3+eGBNCsTExXSJEjabzntmqnb0dPtKnAVxfKmUAHEtsIVBJryX6cCHVZFacCproLYatmYV6hJodIC5q3O83A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88U0GYpV4hxSSvf2/zk80An/kg61cHoWf6vLtle5fJE=;
 b=ThZJ9eufU2242IfZbQjYWAZFOrku4p8a4bMb/fSLwdM54JxGz9byWUo3p5UXKKhX+v8gJ+5F83ffVZphQF9Uk3T0dXh5DFbNz/CPxoFiJ/CYLzUrWXRAudDQY/+FYMYsRDep4QeC/NGcCh+EqtIIsPwqNxy34A3AuXTqM9GdkIDZZDYdP9FfTiJzNXv6JqcALs7EddvO5fCnpjm/+PAtu/sHvJ9u+MpzsA3EliHBI+agkCi1Qf3+teKFhlAJ4ORhBG6qz3YdWHjUbJFhXMpAjjVbBcS9zMM0/jdmHtgAuer7RQg9U+ZVAqTZm/SfgGHwD/1mTFqQKs9eGYYiWeznZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SJ0PR11MB6623.namprd11.prod.outlook.com (2603:10b6:a03:479::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 09:15:36 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%7]) with mapi id 15.20.8534.042; Wed, 26 Mar 2025
 09:15:36 +0000
Message-ID: <78508c06-e552-4022-8a4e-f777c15c7a90@intel.com>
Date: Wed, 26 Mar 2025 17:15:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] sched: Cache aware load-balancing
To: K Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra
	<peterz@infradead.org>
CC: <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
	<tim.c.chen@linux.intel.com>, <tglx@linutronix.de>, <len.brown@intel.com>,
	<gautham.shenoy@amd.com>, <mingo@kernel.org>, <yu.chen.surf@foxmail.com>
References: <20250325120952.GJ36322@noisy.programming.kicks-ass.net>
 <4cd8ba54-8b9e-4563-8fbc-1d6cd6699e81@intel.com>
 <20250325184429.GA31413@noisy.programming.kicks-ass.net>
 <17d0e2be-6130-496f-9a80-49a67a749d01@amd.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <17d0e2be-6130-496f-9a80-49a67a749d01@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:820:1::26) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SJ0PR11MB6623:EE_
X-MS-Office365-Filtering-Correlation-Id: 93e7c8d3-23ab-4fb3-03a9-08dd6c46c4d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUl2OENmNkdtaGp5T3QrVVZwTnNDaFdldlNJaHdmdGc0bjlOZzBMdVN5YVR4?=
 =?utf-8?B?V2hXK1RkN3dlbGxRUXpEeE5sMHhFZEZJMmdic1NrREl2NVliL1hlbzZiQ0Jn?=
 =?utf-8?B?VVVrWHMvaUtvK3dnbzBFWXVVNjU5WG5kWkVkTVZqNm84K09QZFluVXhINVo1?=
 =?utf-8?B?djRJQ2JzTW84a0s3d2tIaEpCd3l1UzBDVTZ2S0Zob0FrQkdOUTIzNzRITExv?=
 =?utf-8?B?NmtKZWJReVR6QWkyQy9zSi9wb0dyU0hyMmRLUWRKK2hSMXFQdlhtNWsxTmZL?=
 =?utf-8?B?bWJzaTZoM1FkNGptWGE3Nm5RV2VXNlBNRVpYSnk3S3E2TzFNczFTcStHKzg3?=
 =?utf-8?B?dTA2SHpBZC9LRUZTc3BlRE1jdDlwWXZJR2l1Tk4rSW1xc0FZMnNnTHBuNUlX?=
 =?utf-8?B?RVFTc3gyTk1HQmRSSmN5QWhqNHYySm54T3o5SnB2cXlyMGVjS0x5WC84TE4v?=
 =?utf-8?B?NUdabFkvak9OUGpZMkdrdG1ZTkppY3kyci9rNEZkOTB3NnJWc1NNSTlkUDFH?=
 =?utf-8?B?Q21tY2J0cUtIcHR0MTRDVWpjVVZRekxwUGJyd1Zkd0hQb0JFSDVqTFc4Yng1?=
 =?utf-8?B?UmVjcGJIeEVRTXpXTXNNbDNNbDlsTDhQekVhWFZKTlU1TWtGcFhyVWZ6V1dM?=
 =?utf-8?B?NVBRQzl4Y3hDeFliMzdTb09MdHB3ZGRvdUl1UGpUWXVJckFuTEJSb0hXd0FE?=
 =?utf-8?B?U09BU2hJVDI3bk5RY09LUzlKb09LUnlOT1ErY08vZmYvRlhLbzRjZFpaM0xw?=
 =?utf-8?B?a2F4QzQxL0VDUFRDMmRnKy9HVFJEMHZhaWR5M0xuOGVSUytGb1RQUE5sbDJU?=
 =?utf-8?B?T0szd0RCQXlLV2Jtblg2WVhOVklmNEtEMkhpTFM2disyRVd0cDZ6RUdRQng1?=
 =?utf-8?B?OUJDanJJdFY2eHpHYVZsMitqbG1ZdHMwSkRWY1ZLYWdFSjBqVU03bS9tMW5h?=
 =?utf-8?B?MFNKUEl3UWFyVkZhMnc1ekQvZlVuaURTa2VMRytESEpMZitIZnJkZXRvNGdB?=
 =?utf-8?B?Y1VramRJRks2QmwzY2w1ZUxzaDlIMFVMeG5kMDg1R3UwUDdmeU5zV1RrTURz?=
 =?utf-8?B?bGxTSERWTDdUU3docVo5MGtLcWZJT0ZRODBsbXVIa1JEUjZ4VllGQktqY041?=
 =?utf-8?B?YzM0d0FuSlZneEdOclJUOE1acldUeE0vNlpYQ2hncEhKcnB2MzUyVTIzSTJG?=
 =?utf-8?B?YmFZc3AwQlBuMGhKQlBKR3k4ZHB1dFg3V3NwMlUzbkRzWlBHUURUN2FYek9N?=
 =?utf-8?B?WjVucldUWGJCUGtSdElacUV3Mlg5NHAvREtMZkJuZlB6dEZvSThEaU9MNHBH?=
 =?utf-8?B?ejNlN1hTUU9nK3hrODhpd2ttMXdCMjVXeFBVd1JLYUxKRkpJTGUrSkhOOXRh?=
 =?utf-8?B?QmJ4aWk1cVEzMkVKVytnNjh2ZExTY1l6R045RDJ3Nk1JZEhnemV1WkZnTWpO?=
 =?utf-8?B?Qk1hZEI0MjFxUjdlUjE3QkR3N3AxclMzenB6ckV2L0g0VGkvV1N0cjVTNDc4?=
 =?utf-8?B?ZWUveVRhL253RloxNFNBVXlEOTZGaWd4UnA2Q1IwMTJwZ21EdzFnaGVYUStk?=
 =?utf-8?B?SVloLzBmVjdqS0x6ZFlSWSt1dk1uZnVEbzNmaVlEaXk5N3pQcGgwODlweXdU?=
 =?utf-8?B?UXMvdVNyZ2F0aWJCZS80KzNYL0FGM3FYcmI2Wk5kUDA0cER3Wnhqek9IYllh?=
 =?utf-8?B?UWQ3TktMU05yVjZmS3NMd1dxcVpCUExyck9oUUpXM2RTY2tDYjg3Ry8zbWU4?=
 =?utf-8?B?WWloMy85cHBKU2VBb2N3bGQrNklXeFNLYzdRRUUwanNuM1V3RmtyckpuV3hC?=
 =?utf-8?B?Y2lmaFBVWUlJU1d4TnBWbm5pWWN2dmhqNTZHRFRVVmdNWCtESVZhTVlhcEo1?=
 =?utf-8?Q?O1e2FUQjRQqFZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGFnenRwS29ZandxTi8zTHNIL2dvWWVkMlZLajVIV0ZteGlxV0twTHVDQm5H?=
 =?utf-8?B?anU5QVdmeStsM2U2RHlFS1dVK25QbVBtM3lpc0NKbjltYWI3T0VVNGJlalRG?=
 =?utf-8?B?NkNvQ09SQWhLaGtYRzdKcVlTSGoxbHQrUjduYlN5V1hmRDFyTkxxT2RKU2da?=
 =?utf-8?B?NXBtdzV5UWRjSXJRa2xIZm1mR2VMNFlwa2JoZUFKTWhWM05LMW42UGc4MEtH?=
 =?utf-8?B?cUZhQTZWeVJTL1YyWkFWN25CQlI5QWJ3RFBpUHpsRVMrSmY5MUVGL0ErYysw?=
 =?utf-8?B?UEQzOFE3cGlEZVJ1Qi9JTTlZakRUNTQ5NmJuVTk1TW5EbDJPV05yQktpRnFI?=
 =?utf-8?B?Sm9wMERaam1UN2p2dzg5UjV2MjhqbUtEOXlzVlFnK2pTTWIyNWlSeGZ1WmZY?=
 =?utf-8?B?b3ZsdlF2NUZhSTlRWlhaazFwMUtEUnJCWXVoU3FFQzFkb3Fpak1rZ1llaEZH?=
 =?utf-8?B?TXhYVmtyZUR5T2ZyeHZTUUdvTWJnakdoQ3FGazErYjVmcVhScHh0WEluenY4?=
 =?utf-8?B?b3crSlYzdEw2Nzc4TWNSQ2RhSWNrNTlHZU44VXJGdmNqRG9FVTVxQkM4M1ll?=
 =?utf-8?B?dThtTHRCTy83YnBPU0s1ZjNPTHMwcVBUNnpReXFoS0k5Q2ZaM2hiR3Y0S2xs?=
 =?utf-8?B?TFNrMUZxUlVIUFBEUGdGRUpuTmlHbVZSNnpkUEhueGZxY29iM1duaE1tMDhX?=
 =?utf-8?B?cytwbUdsT3FiNTZwWm1tdVo0SjJiL0tsSER6b0xlKysxUWRtcmdiR2k5Y0l0?=
 =?utf-8?B?ZkxXUFRDVFRHdktzejQzR2Q3TWl0dldjZFgvSnhNeWNnRDJkZU1mc1hZQ01Z?=
 =?utf-8?B?T2U0ekJtRVp2K0VPRXBjK1NoUkZaaU9lWVNSc1FBZGZTSGtndVV6cUZWMzhG?=
 =?utf-8?B?dUNaVUJyNm1BaW5GMVRjKzNodk5oejM0aVdiclhvYmkzYUNKQllRVG9adG1B?=
 =?utf-8?B?NHJvd2pBNCtUejZDNnY1ZWk5ZW85OGF2QlVBSWtKaWphYStDOFd1b1pHb2lz?=
 =?utf-8?B?QXN6eTNjVnNlNklOa3hjcFdmUklwL2FDbDA0VHpiS3ZTMnVCWkNNY3VaUTVT?=
 =?utf-8?B?WmQ5b1BWWG5OTUdUeWhDbGthRFlkREZuV2JMVjgyVTNPN1FtNE9NbVlWU3hX?=
 =?utf-8?B?Tnk1NEFWZ2JuZWdkOEdKZzV5VDRZOXJ3QXY2MGFXRnVzaUpJYVMzbzJiOU0z?=
 =?utf-8?B?OG5QenV2cnhvNDRtZVBxUzUrOEZ0RXlHb21RTkxiem91QlU5enByejRjTXY5?=
 =?utf-8?B?NDBralVjUk9zWWpqSTV1LzBRdWpVRkhFeXo4SDlDeVduVVZBSkh3ZjdqM2or?=
 =?utf-8?B?MFk2eHBEVk9YTktmd0xKblRTNWUvQ1hsRGpmQVhROWszQmY0bTg0WWgzM0gz?=
 =?utf-8?B?R0dEempxL29GeXVyNXVPVm9ZcDBFOUx3WGowZ3krN1dhQkNzVnpiVndFUjJQ?=
 =?utf-8?B?eks0ZXgwR3ZWbG5Id1dwenZRclFzTDIvdFhyR1JBMUhCZ2RIRVhBVkZpRTg1?=
 =?utf-8?B?K2JBcGpKTGZ0YlBTdWJHZ3R4UU1uclJMUlF4Yk1BbTMyeHNrQTdUL0RZUmFy?=
 =?utf-8?B?QmpsSTBtSjB3bktEV3FNWDNJZkpFV2ZpYWpJbGVPdGdnVC9zYm1jQWQ4KzAy?=
 =?utf-8?B?QncxcUJiWm10OGhhREs5VFh3ZTVsd3YvSWpiMmNxYnlrdjRjNWtiVVpISDJH?=
 =?utf-8?B?ck93eVltY01CcDVMdWlscm5jbzIxMVduUmNiNy9SWUd3aEwvQ2NZNzZGZEl3?=
 =?utf-8?B?d0w1ZFI2cURiNGFrT2V0bDlrVDgrSHl5aGZNcFVqTHJ4ZUVYMEFtQ1YvOXA0?=
 =?utf-8?B?cDZ0MWxlN25TVnRWRmhEbm9VeWdYQ0MyakhzNVNjVHFRb1E0ZWxhaGFBamlz?=
 =?utf-8?B?elhNTm50bkk2MVErWG5zUGRoVGlQV1kwQzl3c1BkakludnB3S0sxdjdBRDdr?=
 =?utf-8?B?eVZxYWNFUkZuZWVveEpQMStNZDMyTlNhd2JhMnBkQmphZytNVnFHVDAxUEFD?=
 =?utf-8?B?ZjNCS1gxZis1cHZIRGNNQk5RaTZzU1dnQlh1RkdMZ2Z5bTdNYnRMbHBvSFMx?=
 =?utf-8?B?emFmWG5QRHJhQ0JUMG9kUng5OTNQQU1rRUVRdUIyL0tmbGEwOGlkdUNMTXNN?=
 =?utf-8?Q?NNrAkgsVwfb2Od2UhrzCpAteP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e7c8d3-23ab-4fb3-03a9-08dd6c46c4d9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 09:15:36.5890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hqMHOas7uwThozh8mK+MZEkaMuLhUCydeJ0bFCR9ypZWP5Hf3KNajEM4cJ8WIoKXNHlysnM0GbDMqsAKEZ/SSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6623
X-OriginatorOrg: intel.com


Hi Prateek,

On 3/26/2025 2:18 PM, K Prateek Nayak wrote:
> Hello Peter, Chenyu,
> 
> On 3/26/2025 12:14 AM, Peter Zijlstra wrote:
>> On Tue, Mar 25, 2025 at 11:19:52PM +0800, Chen, Yu C wrote:
>>>
>>> Hi Peter,
>>>
>>> Thanks for sending this out,
>>>
>>> On 3/25/2025 8:09 PM, Peter Zijlstra wrote:
>>>> Hi all,
>>>>
>>>> One of the many things on the eternal todo list has been finishing the
>>>> below hackery.
>>>>
>>>> It is an attempt at modelling cache affinity -- and while the patch
>>>> really only targets LLC, it could very well be extended to also 
>>>> apply to
>>>> clusters (L2). Specifically any case of multiple cache domains inside a
>>>> node.
>>>>
>>>> Anyway, I wrote this about a year ago, and I mentioned this at the
>>>> recent OSPM conf where Gautham and Prateek expressed interest in 
>>>> playing
>>>> with this code.
>>>>
>>>> So here goes, very rough and largely unproven code ahead :-)
>>>>
>>>> It applies to current tip/master, but I know it will fail the __percpu
>>>> validation that sits in -next, although that shouldn't be terribly hard
>>>> to fix up.
>>>>
>>>> As is, it only computes a CPU inside the LLC that has the highest 
>>>> recent
>>>> runtime, this CPU is then used in the wake-up path to steer towards 
>>>> this
>>>> LLC and in task_hot() to limit migrations away from it.
>>>>
>>>> More elaborate things could be done, notably there is an XXX in there
>>>> somewhere about finding the best LLC inside a NODE (interaction with
>>>> NUMA_BALANCING).
>>>>
>>>
>>> Besides the control provided by CONFIG_SCHED_CACHE, could we also 
>>> introduce
>>> sched_feat(SCHED_CACHE) to manage this feature, facilitating dynamic
>>> adjustments? Similarly we can also introduce other sched_feats for load
>>> balancing and NUMA balancing for fine-grain control.
>>
>> We can do all sorts, but the very first thing is determining if this is
>> worth it at all. Because if we can't make this work at all, all those
>> things are a waste of time.
>>
>> This patch is not meant to be merged, it is meant for testing and
>> development. We need to first make it actually improve workloads. If it
>> then turns out it regresses workloads (likely, things always do), then
>> we can look at how to best do that.
>>
> 
> Thank you for sharing the patch and the initial review from Chenyu
> pointing to issues that need fixing. I'll try to take a good look at it
> this week and see if I can improve some trivial benchmarks that regress
> currently with RFC as is.
> 
> In its current form I think this suffers from the same problem as
> SIS_NODE where wakeups redirect to same set of CPUs and a good deal of
> additional work is being done without any benefit.
> 
> I'll leave the results from my initial testing on the 3rd Generation
> EPYC platform below and will evaluate what is making the benchmarks
> unhappy. I'll return with more data when some of these benchmarks
> are not as unhappy as they are now.
> 
> Thank you both for the RFC and the initial feedback. Following are
> the initial results for the RFC as is:
> 
>    ==================================================================
>    Test          : hackbench
>    Units         : Normalized time in seconds
>    Interpretation: Lower is better
>    Statistic     : AMean
>    ==================================================================
>    Case:           tip[pct imp](CV)      sched_cache[pct imp](CV)
>     1-groups     1.00 [ -0.00](10.12)     1.01 [ -0.89]( 2.84)
>     2-groups     1.00 [ -0.00]( 6.92)     1.83 [-83.15]( 1.61)
>     4-groups     1.00 [ -0.00]( 3.14)     3.00 [-200.21]( 3.13)
>     8-groups     1.00 [ -0.00]( 1.35)     3.44 [-243.75]( 2.20)
>    16-groups     1.00 [ -0.00]( 1.32)     2.59 [-158.98]( 4.29)
> 
> 
>    ==================================================================
>    Test          : tbench
>    Units         : Normalized throughput
>    Interpretation: Higher is better
>    Statistic     : AMean
>    ==================================================================
>    Clients:    tip[pct imp](CV)     sched_cache[pct imp](CV)
>        1     1.00 [  0.00]( 0.43)     0.96 [ -3.54]( 0.56)
>        2     1.00 [  0.00]( 0.58)     0.99 [ -1.32]( 1.40)
>        4     1.00 [  0.00]( 0.54)     0.98 [ -2.34]( 0.78)
>        8     1.00 [  0.00]( 0.49)     0.96 [ -3.91]( 0.54)
>       16     1.00 [  0.00]( 1.06)     0.97 [ -3.22]( 1.82)
>       32     1.00 [  0.00]( 1.27)     0.95 [ -4.74]( 2.05)
>       64     1.00 [  0.00]( 1.54)     0.93 [ -6.65]( 0.63)
>      128     1.00 [  0.00]( 0.38)     0.93 [ -6.91]( 1.18)
>      256     1.00 [  0.00]( 1.85)     0.99 [ -0.50]( 1.34)
>      512     1.00 [  0.00]( 0.31)     0.98 [ -2.47]( 0.14)
>     1024     1.00 [  0.00]( 0.19)     0.97 [ -3.06]( 0.39)
> 
> 
>    ==================================================================
>    Test          : stream-10
>    Units         : Normalized Bandwidth, MB/s
>    Interpretation: Higher is better
>    Statistic     : HMean
>    ==================================================================
>    Test:       tip[pct imp](CV)     sched_cache[pct imp](CV)
>     Copy     1.00 [  0.00](11.31)     0.34 [-65.89](72.77)
>    Scale     1.00 [  0.00]( 6.62)     0.32 [-68.09](72.49)
>      Add     1.00 [  0.00]( 7.06)     0.34 [-65.56](70.56)
>    Triad     1.00 [  0.00]( 8.91)     0.34 [-66.47](72.70)
> 
> 
>    ==================================================================
>    Test          : stream-100
>    Units         : Normalized Bandwidth, MB/s
>    Interpretation: Higher is better
>    Statistic     : HMean
>    ==================================================================
>    Test:       tip[pct imp](CV)     sched_cache[pct imp](CV)
>     Copy     1.00 [  0.00]( 2.01)     0.83 [-16.96](24.55)
>    Scale     1.00 [  0.00]( 1.49)     0.79 [-21.40](24.10)
>      Add     1.00 [  0.00]( 2.67)     0.79 [-21.33](25.39)
>    Triad     1.00 [  0.00]( 2.19)     0.81 [-19.19](25.55)
> 
> 
>    ==================================================================
>    Test          : netperf
>    Units         : Normalized Througput
>    Interpretation: Higher is better
>    Statistic     : AMean
>    ==================================================================
>    Clients:         tip[pct imp](CV)     sched_cache[pct imp](CV)
>     1-clients     1.00 [  0.00]( 1.43)     0.98 [ -2.22]( 0.26)
>     2-clients     1.00 [  0.00]( 1.02)     0.97 [ -2.55]( 0.89)
>     4-clients     1.00 [  0.00]( 0.83)     0.98 [ -2.27]( 0.46)
>     8-clients     1.00 [  0.00]( 0.73)     0.98 [ -2.45]( 0.80)
>    16-clients     1.00 [  0.00]( 0.97)     0.97 [ -2.90]( 0.88)
>    32-clients     1.00 [  0.00]( 0.88)     0.95 [ -5.29]( 1.69)
>    64-clients     1.00 [  0.00]( 1.49)     0.91 [ -8.70]( 1.95)
>    128-clients    1.00 [  0.00]( 1.05)     0.92 [ -8.39]( 4.25)
>    256-clients    1.00 [  0.00]( 3.85)     0.92 [ -8.33]( 2.45)
>    512-clients    1.00 [  0.00](59.63)     0.92 [ -7.83](51.19)
> 
> 
>    ==================================================================
>    Test          : schbench
>    Units         : Normalized 99th percentile latency in us
>    Interpretation: Lower is better
>    Statistic     : Median
>    ==================================================================
>    #workers: tip[pct imp](CV)       sched_cache[pct imp](CV)
>      1     1.00 [ -0.00]( 6.67)      0.38 [ 62.22]    ( 5.88)
>      2     1.00 [ -0.00](10.18)      0.43 [ 56.52]    ( 2.94)
>      4     1.00 [ -0.00]( 4.49)      0.60 [ 40.43]    ( 5.52)
>      8     1.00 [ -0.00]( 6.68)    113.96 [-11296.23] (12.91)
>     16     1.00 [ -0.00]( 1.87)    359.34 [-35834.43] (20.02)
>     32     1.00 [ -0.00]( 4.01)    217.67 [-21667.03] ( 5.48)
>     64     1.00 [ -0.00]( 3.21)     97.43 [-9643.02]  ( 4.61)
>    128     1.00 [ -0.00](44.13)     41.36 [-4036.10]  ( 6.92)
>    256     1.00 [ -0.00](14.46)      2.69 [-169.31]   ( 1.86)
>    512     1.00 [ -0.00]( 1.95)      1.89 [-89.22]    ( 2.24)
> 
> 
>    ==================================================================
>    Test          : new-schbench-requests-per-second
>    Units         : Normalized Requests per second
>    Interpretation: Higher is better
>    Statistic     : Median
>    ==================================================================
>    #workers: tip[pct imp](CV)      sched_cache[pct imp](CV)
>      1     1.00 [  0.00]( 0.46)     0.96 [ -4.14]( 0.00)
>      2     1.00 [  0.00]( 0.15)     0.95 [ -5.27]( 2.29)
>      4     1.00 [  0.00]( 0.15)     0.88 [-12.01]( 0.46)
>      8     1.00 [  0.00]( 0.15)     0.55 [-45.47]( 1.23)
>     16     1.00 [  0.00]( 0.00)     0.54 [-45.62]( 0.50)
>     32     1.00 [  0.00]( 3.40)     0.63 [-37.48]( 6.37)
>     64     1.00 [  0.00]( 7.09)     0.67 [-32.73]( 0.59)
>    128     1.00 [  0.00]( 0.00)     0.99 [ -0.76]( 0.34)
>    256     1.00 [  0.00]( 1.12)     1.06 [  6.32]( 1.55)
>    512     1.00 [  0.00]( 0.22)     1.06 [  6.08]( 0.92)
> 
> 
>    ==================================================================
>    Test          : new-schbench-wakeup-latency
>    Units         : Normalized 99th percentile latency in us
>    Interpretation: Lower is better
>    Statistic     : Median
>    ==================================================================
>    #workers: tip[pct imp](CV)       sched_cache[pct imp](CV)
>      1     1.00 [ -0.00](19.72)     0.85  [ 15.38]    ( 8.13)
>      2     1.00 [ -0.00](15.96)     1.09  [ -9.09]    (18.20)
>      4     1.00 [ -0.00]( 3.87)     1.00  [ -0.00]    ( 0.00)
>      8     1.00 [ -0.00]( 8.15)    118.17 [-11716.67] ( 0.58)
>     16     1.00 [ -0.00]( 3.87)    146.62 [-14561.54] ( 4.64)
>     32     1.00 [ -0.00](12.99)    141.60 [-14060.00] ( 5.64)
>     64     1.00 [ -0.00]( 6.20)    78.62  [-7762.50]  ( 1.79)
>    128     1.00 [ -0.00]( 0.96)    11.36  [-1036.08]  ( 3.41)
>    256     1.00 [ -0.00]( 2.76)     1.11  [-11.22]    ( 3.28)
>    512     1.00 [ -0.00]( 0.20)     1.21  [-20.81]    ( 0.91)
> 
> 
>    ==================================================================
>    Test          : new-schbench-request-latency
>    Units         : Normalized 99th percentile latency in us
>    Interpretation: Lower is better
>    Statistic     : Median
>    ==================================================================
>    #workers: tip[pct imp](CV)      sched_cache[pct imp](CV)
>      1     1.00 [ -0.00]( 1.07)     1.11 [-10.66]  ( 2.76)
>      2     1.00 [ -0.00]( 0.14)     1.20 [-20.40]  ( 1.73)
>      4     1.00 [ -0.00]( 1.39)     2.04 [-104.20] ( 0.96)
>      8     1.00 [ -0.00]( 0.36)     3.94 [-294.20] ( 2.85)
>     16     1.00 [ -0.00]( 1.18)     4.56 [-356.16] ( 1.19)
>     32     1.00 [ -0.00]( 8.42)     3.02 [-201.67] ( 8.93)
>     64     1.00 [ -0.00]( 4.85)     1.51 [-51.38]  ( 0.80)
>    128     1.00 [ -0.00]( 0.28)     1.83 [-82.77]  ( 1.21)
>    256     1.00 [ -0.00](10.52)     1.43 [-43.11]  (10.67)
>    512     1.00 [ -0.00]( 0.69)     1.25 [-24.96]  ( 6.24)
> 
> 
>    ==================================================================
>    Test          : Various longer running benchmarks
>    Units         : %diff in throughput reported
>    Interpretation: Higher is better
>    Statistic     : Median
>    ==================================================================
>    Benchmarks:                 %diff
>    ycsb-cassandra             -10.70%
>    ycsb-mongodb               -13.66%
> 
>    deathstarbench-1x           13.87%
>    deathstarbench-2x            1.70%
>    deathstarbench-3x           -8.44%
>    deathstarbench-6x           -3.12%
> 
>    hammerdb+mysql 16VU        -33.50%
>    hammerdb+mysql 64VU        -33.22%
> 
> ---
> 
> I'm planning on taking hackbench and schbench as two extreme cases for
> throughput and tail latency and later look at Stream from a "high
> bandwidth, don't consolidate" standpoint. I hope once those cases
> aren't as much in the reds, the larger benchmarks will be happier too.
> 

Thanks for running the test. I think hackbenc/schbench would be the good 
benchmarks to start with. I remember that you and Gautham mentioned that 
schbench prefers to be aggregated in a single LLC in LPC2021 or 2022. I 
ran a schbench test using mmtests on a Xeon server which has 4 NUMA 
nodes. Each node has 80 cores (with SMT disabled). The numa=off option 
was appended to the boot commandline, so there are 4 "LLCs" within each 
node.


                                     BASELIN             SCHED_CACH
                                    BASELINE            SCHED_CACHE
Lat 50.0th-qrtle-1          8.00 (   0.00%)        5.00 (  37.50%)
Lat 90.0th-qrtle-1          9.00 (   0.00%)        5.00 (  44.44%)
Lat 99.0th-qrtle-1         13.00 (   0.00%)       10.00 (  23.08%)
Lat 99.9th-qrtle-1         21.00 (   0.00%)       19.00 (   9.52%)*
Lat 20.0th-qrtle-1        404.00 (   0.00%)      411.00 (  -1.73%)
Lat 50.0th-qrtle-2          8.00 (   0.00%)        5.00 (  37.50%)
Lat 90.0th-qrtle-2         11.00 (   0.00%)        8.00 (  27.27%)
Lat 99.0th-qrtle-2         16.00 (   0.00%)       11.00 (  31.25%)
Lat 99.9th-qrtle-2         27.00 (   0.00%)       17.00 (  37.04%)*
Lat 20.0th-qrtle-2        823.00 (   0.00%)      821.00 (   0.24%)
Lat 50.0th-qrtle-4         10.00 (   0.00%)        5.00 (  50.00%)
Lat 90.0th-qrtle-4         12.00 (   0.00%)        6.00 (  50.00%)
Lat 99.0th-qrtle-4         18.00 (   0.00%)        9.00 (  50.00%)
Lat 99.9th-qrtle-4         29.00 (   0.00%)       16.00 (  44.83%)*
Lat 20.0th-qrtle-4       1650.00 (   0.00%)     1598.00 (   3.15%)
Lat 50.0th-qrtle-8          9.00 (   0.00%)        4.00 (  55.56%)
Lat 90.0th-qrtle-8         11.00 (   0.00%)        6.00 (  45.45%)
Lat 99.0th-qrtle-8         16.00 (   0.00%)        9.00 (  43.75%)
Lat 99.9th-qrtle-8         28.00 (   0.00%)      188.00 (-571.43%)*
Lat 20.0th-qrtle-8       3316.00 (   0.00%)     3100.00 (   6.51%)
Lat 50.0th-qrtle-16        10.00 (   0.00%)        5.00 (  50.00%)
Lat 90.0th-qrtle-16        13.00 (   0.00%)        7.00 (  46.15%)
Lat 99.0th-qrtle-16        19.00 (   0.00%)       12.00 (  36.84%)
Lat 99.9th-qrtle-16        28.00 (   0.00%)     2034.00 (-7164.29%)*
Lat 20.0th-qrtle-16      6632.00 (   0.00%)     5800.00 (  12.55%)
Lat 50.0th-qrtle-32         7.00 (   0.00%)       12.00 ( -71.43%)
Lat 90.0th-qrtle-32        10.00 (   0.00%)       62.00 (-520.00%)
Lat 99.0th-qrtle-32        14.00 (   0.00%)      841.00 (-5907.14%)
Lat 99.9th-qrtle-32        23.00 (   0.00%)     1862.00 (-7995.65%)*
Lat 20.0th-qrtle-32     13264.00 (   0.00%)    10608.00 (  20.02%)
Lat 50.0th-qrtle-64         7.00 (   0.00%)       64.00 (-814.29%)
Lat 90.0th-qrtle-64        12.00 (   0.00%)      709.00 (-5808.33%)
Lat 99.0th-qrtle-64        18.00 (   0.00%)     2260.00 (-12455.56%)
Lat 99.9th-qrtle-64        26.00 (   0.00%)     3572.00 (-13638.46%)*
Lat 20.0th-qrtle-64     26528.00 (   0.00%)    14064.00 (  46.98%)
Lat 50.0th-qrtle-128        7.00 (   0.00%)      115.00 (-1542.86%)
Lat 90.0th-qrtle-128       11.00 (   0.00%)     1626.00 (-14681.82%)
Lat 99.0th-qrtle-128       17.00 (   0.00%)     4472.00 (-26205.88%)
Lat 99.9th-qrtle-128       27.00 (   0.00%)     8088.00 (-29855.56%)*
Lat 20.0th-qrtle-128    53184.00 (   0.00%)    17312.00 (  67.45%)
Lat 50.0th-qrtle-256      172.00 (   0.00%)      255.00 ( -48.26%)
Lat 90.0th-qrtle-256     2092.00 (   0.00%)     1482.00 (  29.16%)
Lat 99.0th-qrtle-256     2684.00 (   0.00%)     3148.00 ( -17.29%)
Lat 99.9th-qrtle-256     4504.00 (   0.00%)     6008.00 ( -33.39%)*
Lat 20.0th-qrtle-256    53056.00 (   0.00%)    48064.00 (   9.41%)
Lat 50.0th-qrtle-319      375.00 (   0.00%)      478.00 ( -27.47%)
Lat 90.0th-qrtle-319     2420.00 (   0.00%)     2244.00 (   7.27%)
Lat 99.0th-qrtle-319     4552.00 (   0.00%)     4456.00 (   2.11%)
Lat 99.9th-qrtle-319     6072.00 (   0.00%)     7656.00 ( -26.09%)*
Lat 20.0th-qrtle-319    47936.00 (   0.00%)    47808.00 (   0.27%)

We can see that, when the system is under-load, the 99.9th wakeup
latency improves. But when the system gets busier, say, from thread
number 8 to 319, the wakeup latency suffers.

The following change could mitigate the issue, which is intended to 
avoid task migration/stacking:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cddd67100a91..a492463aed71 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8801,6 +8801,7 @@ static long __migrate_degrades_locality(struct 
task_struct *p, int src_cpu, int
  static int select_cache_cpu(struct task_struct *p, int prev_cpu)
  {
         struct mm_struct *mm = p->mm;
+       struct sched_domain *sd;
         int cpu;

         if (!sched_feat(SCHED_CACHE))
@@ -8813,6 +8814,8 @@ static int select_cache_cpu(struct task_struct *p, 
int prev_cpu)
         if (cpu < 0)
                 return prev_cpu;

+       if (cpus_share_cache(prev_cpu, cpu))
+               return prev_cpu;

         if (static_branch_likely(&sched_numa_balancing) &&
             __migrate_degrades_locality(p, prev_cpu, cpu, false) > 0) {
@@ -8822,6 +8825,10 @@ static int select_cache_cpu(struct task_struct 
*p, int prev_cpu)
                 return prev_cpu;
         }

+       sd = rcu_dereference(per_cpu(sd_llc, cpu));
+       if (likely(sd))
+               return cpumask_any(sched_domain_span(sd));
+
         return cpu;
  }

                                  BASELINE_s          SCHED_CACHE_s
                                 BASELINE_sc         SCHED_CACHE_sc
Lat 50.0th-qrtle-1          5.00 (   0.00%)        5.00 (   0.00%)
Lat 90.0th-qrtle-1          8.00 (   0.00%)        5.00 (  37.50%)
Lat 99.0th-qrtle-1         10.00 (   0.00%)       10.00 (   0.00%)
Lat 99.9th-qrtle-1         20.00 (   0.00%)       20.00 (   0.00%)*
Lat 20.0th-qrtle-1        409.00 (   0.00%)      406.00 (   0.73%)
Lat 50.0th-qrtle-2          8.00 (   0.00%)        4.00 (  50.00%)
Lat 90.0th-qrtle-2         11.00 (   0.00%)        5.00 (  54.55%)
Lat 99.0th-qrtle-2         16.00 (   0.00%)       11.00 (  31.25%)
Lat 99.9th-qrtle-2         29.00 (   0.00%)       16.00 (  44.83%)*
Lat 20.0th-qrtle-2        819.00 (   0.00%)      825.00 (  -0.73%)
Lat 50.0th-qrtle-4         10.00 (   0.00%)        4.00 (  60.00%)
Lat 90.0th-qrtle-4         12.00 (   0.00%)        4.00 (  66.67%)
Lat 99.0th-qrtle-4         18.00 (   0.00%)        6.00 (  66.67%)
Lat 99.9th-qrtle-4         30.00 (   0.00%)       15.00 (  50.00%)*
Lat 20.0th-qrtle-4       1658.00 (   0.00%)     1670.00 (  -0.72%)
Lat 50.0th-qrtle-8          9.00 (   0.00%)        3.00 (  66.67%)
Lat 90.0th-qrtle-8         11.00 (   0.00%)        4.00 (  63.64%)
Lat 99.0th-qrtle-8         16.00 (   0.00%)        6.00 (  62.50%)
Lat 99.9th-qrtle-8         29.00 (   0.00%)       13.00 (  55.17%)*
Lat 20.0th-qrtle-8       3308.00 (   0.00%)     3340.00 (  -0.97%)
Lat 50.0th-qrtle-16         9.00 (   0.00%)        4.00 (  55.56%)
Lat 90.0th-qrtle-16        12.00 (   0.00%)        4.00 (  66.67%)
Lat 99.0th-qrtle-16        18.00 (   0.00%)        6.00 (  66.67%)
Lat 99.9th-qrtle-16        31.00 (   0.00%)       12.00 (  61.29%)*
Lat 20.0th-qrtle-16      6616.00 (   0.00%)     6680.00 (  -0.97%)
Lat 50.0th-qrtle-32         8.00 (   0.00%)        4.00 (  50.00%)
Lat 90.0th-qrtle-32        11.00 (   0.00%)        5.00 (  54.55%)
Lat 99.0th-qrtle-32        17.00 (   0.00%)        8.00 (  52.94%)
Lat 99.9th-qrtle-32        27.00 (   0.00%)       11.00 (  59.26%)*
Lat 20.0th-qrtle-32     13296.00 (   0.00%)    13328.00 (  -0.24%)
Lat 50.0th-qrtle-64         9.00 (   0.00%)       46.00 (-411.11%)
Lat 90.0th-qrtle-64        14.00 (   0.00%)     1198.00 (-8457.14%)
Lat 99.0th-qrtle-64        20.00 (   0.00%)     2252.00 (-11160.00%)
Lat 99.9th-qrtle-64        31.00 (   0.00%)     2844.00 (-9074.19%)*
Lat 20.0th-qrtle-64     26528.00 (   0.00%)    15504.00 (  41.56%)
Lat 50.0th-qrtle-128        7.00 (   0.00%)       26.00 (-271.43%)
Lat 90.0th-qrtle-128       11.00 (   0.00%)     2244.00 (-20300.00%)
Lat 99.0th-qrtle-128       17.00 (   0.00%)     4488.00 (-26300.00%)
Lat 99.9th-qrtle-128       27.00 (   0.00%)     5752.00 (-21203.70%)*
Lat 20.0th-qrtle-128    53184.00 (   0.00%)    24544.00 (  53.85%)
Lat 50.0th-qrtle-256      172.00 (   0.00%)      135.00 (  21.51%)
Lat 90.0th-qrtle-256     2084.00 (   0.00%)     2022.00 (   2.98%)
Lat 99.0th-qrtle-256     2780.00 (   0.00%)     3908.00 ( -40.58%)
Lat 99.9th-qrtle-256     4536.00 (   0.00%)     5832.00 ( -28.57%)*
Lat 20.0th-qrtle-256    53568.00 (   0.00%)    51904.00 (   3.11%)
Lat 50.0th-qrtle-319      369.00 (   0.00%)      358.00 (   2.98%)
Lat 90.0th-qrtle-319     2428.00 (   0.00%)     2436.00 (  -0.33%)
Lat 99.0th-qrtle-319     4552.00 (   0.00%)     4664.00 (  -2.46%)
Lat 99.9th-qrtle-319     6104.00 (   0.00%)     6632.00 (  -8.65%)*
Lat 20.0th-qrtle-319    48192.00 (   0.00%)    48832.00 (  -1.33%)


We can see wakeup latency improvement in a wider range when running 
different number of threads. But there is still regression starting from 
thread number 64 - maybe the benefit of LLC locality is offset by the 
task stacking on 1 LLC. One possible direction I'm thinking of is that, 
we can get a snapshot of LLC status in load balance, check if the LLC is 
overloaded, if yes, do not enable this LLC aggregation during task 
wakeup - but do it in the load balancer, which is less frequent.

thanks,
Chenyu


