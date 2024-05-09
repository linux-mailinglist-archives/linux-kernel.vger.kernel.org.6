Return-Path: <linux-kernel+bounces-174109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EEC8C0A49
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20EB01C219BC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A04146D71;
	Thu,  9 May 2024 03:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MOs5olbC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF28E6A347
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 03:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715226540; cv=fail; b=nuLu310sWZtDrlm8N7XP8GZMSNyGDZ+9KKvAsKRXOu4ccrqGCGuF2qAMFRBy5gfmgRv9NBfrQ3i7H71w2mfEbLSfu6Hko2hIDYDZ0Bp85fMRkkBbPBG/1uCpT04yyngSQnj4eKE6+sFR+BfC+UhqbJpEL8TjKxYfvpxpN+kpsA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715226540; c=relaxed/simple;
	bh=HPH7ZVeyqrUOHvB2mlRsTBiNg9UExgsT02lySI+MW3k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Et5UIU418+SjDqjpUu2mlmhse11eFJJLnks+3oTg0ZEtdU6y525/gtheGf21bYe/Hxxi8KPmWm9jG12ndeeqaOXDwnPx83L8yQKJdW0hdewyKD+e81/ZbqbpdWDEb7gyNVTkyvvOiVMnCv+3MhKYanWdd5+s0cXJMjoGKSEkK9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MOs5olbC; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715226539; x=1746762539;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HPH7ZVeyqrUOHvB2mlRsTBiNg9UExgsT02lySI+MW3k=;
  b=MOs5olbCtl3ASGQd1R7KGaqvymnC9S90IeZyoG/j4MKxwXFBk+IPYrUQ
   53qebziXRiruf2FxDHSXVNNqH+asWm/W2gYUKjVp/4KjHjcP3DVoWXgo1
   G1oh5pIjiP6QUvYuC9pbTgp3WbxzvWrGMkV7Az2F7w0gQNCA6KX4TVLk3
   OwvYw/kqLsLT2QTSQdfGYpbndC5o1c3M5xSH81/35KTex2Qb1gWad0+58
   AYdsO9qrJu4mutZMdX+S327HIXLbi/5tpShLXXSpuc21DJ77zMyEBXnJ7
   A8rKCq5ltzHD9LY+y/M7uOgJtx2aNy2ZW25ipdVoAZ6zYDFKKjLkZz8NC
   g==;
X-CSE-ConnectionGUID: 5QaH++2OQQiyfuPEqeGIrQ==
X-CSE-MsgGUID: 2pXB5j4TSBOaEnrkP45CSw==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="10956862"
X-IronPort-AV: E=Sophos;i="6.08,146,1712646000"; 
   d="scan'208";a="10956862"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 20:48:59 -0700
X-CSE-ConnectionGUID: OEUCph6jQEOXcE1V0Kfl9w==
X-CSE-MsgGUID: a4NfSfXATV6Q1j+SUruapA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,146,1712646000"; 
   d="scan'208";a="29667097"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 May 2024 20:48:59 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 20:48:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 20:48:57 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 20:48:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8dLGQ12POhl2MPzTtCABFuElwGKekA6MTzPAQ/gv+xGXemgw4uR4XsJqsL10OoMezi7hH+0e0FiX/q3iw54VBB6UnyAzyNr3e3ZtiT+7x+e3+vu4/TX20ENVStZ0f2a1b3AxbwkXGBRiaZZmup/n9J690WlkRgfU8oVaOWtiOm+Q/+3fnS+mym3KojZHATwkT9QFp0R2Wmy7PHbhakX2QnT8IUFRN0FyOecgjS7F0ra0+GAUthgyzBnFWQtQx+Aoy1F92t0M15fnnM52a6kvHotipl4hP5p0UFbW9CzvWv0EiQSUpmJN8Ezq9wzMCg8ZEsku5OphR43wCXfE2RVAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIJ/Zpw01f7WxC0eJ2ozbU7f+7TS9xILV+olU6e6bjY=;
 b=mt0jTFhAsOShOkCrd0PXg+PpralVn/jOxMRbVkNNkYHDNCkswO+Wv7cYcch3uAydIk41Vsum2WJ97DuJTQQL2GAmXOGYSC/QW+cn2foSe+gzjWVthALvTA5q2B1yy/9DmgQBLUzWpz64RjohQcgCGFy4Ei05SHbf05CNcXUbPFpcuuQUiKlnAunvJpiEPo8+wLkEOZ4N4cQFTk4lpekYYBUthuSY5AoNZRM0MTppGL4clqK2pAHW55z7TaD7HNbif9FvZlr9rKmyZEu5AsIIe8psPXFNWjkgXsRk4GS8Xhd60Fw803W3RWS3nqEUk0oJMe/VYXMbPNppJFnVk+7mdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DS0PR11MB6446.namprd11.prod.outlook.com (2603:10b6:8:c5::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.45; Thu, 9 May 2024 03:48:50 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7544.041; Thu, 9 May 2024
 03:48:50 +0000
Date: Thu, 9 May 2024 11:48:36 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Mike Galbraith <efault@gmx.de>
CC: Peter Zijlstra <peterz@infradead.org>, <mingo@redhat.com>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <bristot@redhat.com>, <vschneid@redhat.com>,
	<linux-kernel@vger.kernel.org>, <kprateek.nayak@amd.com>,
	<wuyun.abel@bytedance.com>, <tglx@linutronix.de>, <tim.c.chen@intel.com>,
	<yu.c.chen.y@gmail.com>
Subject: Re: [RFC][PATCH 10/10] sched/eevdf: Use sched_attr::sched_runtime to
 set request/slice suggestion
Message-ID: <ZjxHlLQv1WuFq+SC@chenyu5-mobl2>
References: <20240405102754.435410987@infradead.org>
 <20240405110010.934104715@infradead.org>
 <ZjpFruUiBiNi6VSO@chenyu5-mobl2>
 <9c360c0d337b124c71095f06889d1c69279a7c06.camel@gmx.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9c360c0d337b124c71095f06889d1c69279a7c06.camel@gmx.de>
X-ClientProxiedBy: SG2PR06CA0203.apcprd06.prod.outlook.com (2603:1096:4:1::35)
 To DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DS0PR11MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f01a0da-2692-4f9b-5617-08dc6fdaf009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lz9TitVBv7hFY1GZvlv0mk9TSADdcNfpcAZER9mzbj4HMTovAbcBPVa7aDJ5?=
 =?us-ascii?Q?vFPw+tjpxu4FRelNTszL3gTTCDkh1QSdOkVLrjiHj0Q3w4Zg/+ltBzdLFVAq?=
 =?us-ascii?Q?sHzfkgquW7Xq93bRh6CDZB5WRK+eCgi1/x7/xTt+4YFuOQ53WxURIJLa0roN?=
 =?us-ascii?Q?r25WBRt/RPzenSDptVClurXR6LT/2UMLGpgx//VSDKszpR8fBCvmBvr7jJhS?=
 =?us-ascii?Q?wQZAlNSM9UD0P4XAh4f38rgaV53Jrxi3s/KHMdrSFD/1v1JaUKdeDq7aOu1+?=
 =?us-ascii?Q?vEXnWNRpcNLMnqUY6FZDtAnBB6HPimji7aNQWozeZgYlHHI8hgkY7GMNRMoA?=
 =?us-ascii?Q?TC0Wm/gzdLAVGBg87AkVP9rOE5nsqOzjz0X8e00cMAuXO1K9lGXk6lKhiL78?=
 =?us-ascii?Q?3ve/LvrUkAQ6uJ29gS3XrpmfOqmsZgVaoFxGJB0UEYEljxKcANQb677Sl/u7?=
 =?us-ascii?Q?2rMcgOV6HP/q+r+LsAPrrx6TNIJ4LeFEFd1+8TAuvcEQTWx898IjRpuAfD/z?=
 =?us-ascii?Q?HNaenhKWKAnxZDlyjB2hzGYX78+7hT3ErijX3L4srcXRlrfOKi8BLmJvX67e?=
 =?us-ascii?Q?3gnSfT1Xg0TvInFdGJx8ZqXcdu/U/JPqxgHgEse7XtNxJ9w+pGKCCCRj4HNz?=
 =?us-ascii?Q?hZP6KGwQimvZnkJJUWbgV+OlJreMMPpRrIJ48DoobbDE3auEmtv34HyRGr6g?=
 =?us-ascii?Q?8jskief4UsQEdKt0SL1CyDGoIJ0gcxWV4nXWae8nkdJ+I5Ddb0bBJmbYrSRo?=
 =?us-ascii?Q?PLZml28ojWYhzOuZqLCvthZ4QqTT5ytdNtP2eqBlErmvPkl2N94yrJAqB27h?=
 =?us-ascii?Q?6yU3Rt2uLvIqTMk19pCTsXjWeKREdKPONMIPtYLNx2P+ZYOafKF0aPjSc9u3?=
 =?us-ascii?Q?CFaRJA6nU6yHENrXnT0Ekw23zTmlgMT6RUH1g7r1e0ZhXHGcMyiQYPkiZxP/?=
 =?us-ascii?Q?v8PYwVjVgJkGOaG4DcF/3xH85fhw2Eap9YogHYtMlfxnRP2euVlQRYaIUHNB?=
 =?us-ascii?Q?u9GbFc+Zb2DvYFmnmKpoJBJSKpqAPL4BqmVkSdLRI5rS/KYC3Ic8+UyquCE+?=
 =?us-ascii?Q?c1QONAGWZBa8KYKP0jbZMoZsVsnoj42CGtWJgKYUs4GRHkCe1jgtqWk/pZ3A?=
 =?us-ascii?Q?sLJt6bI2Np8qAHOYqQEoUDa70uepy+QURYzGuiutgz43xqzyN4/n5v7sKzla?=
 =?us-ascii?Q?pQtDtLYh9ns8v/AMI5ZeC9w/5zY7QBZScIUZmodTIiaOUwXA02m5kFD8Y+j+?=
 =?us-ascii?Q?JhajoGLyGRPUl8tEGoLgAN5pytGpgCGGxKLcNNaxow=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qc+B3n+noZLUUuY/TFCyFYFCUUgYmhN3fiJ6wV3b6fYJLRYsJ48ma0CYw3Os?=
 =?us-ascii?Q?tJ1vKoCQBeDsWmzsBhNUjPqyL7Ny8y3cExSnxQN6j4q6KYO+RYrajqtLoZoC?=
 =?us-ascii?Q?cxipYF6EOeU77rfUQalMH7u0F8P36JsaKYKI4T2yI3MSTCGludoJncK7PGoe?=
 =?us-ascii?Q?ShuskctSIh04CAEh4mxSraVDuzVjGouuzwI6pMGxSqRkopRtvQMAsack5mSR?=
 =?us-ascii?Q?xGXHoSWGbiGvnOxury+/9mhvIu8NsUvPR8yhb3AlD9xinIZw+7kVrDc6XZzz?=
 =?us-ascii?Q?0kW2u5EcagdP2OC2CPjbmuCkkBMvm+XxyX5ZNR85hxJiFkRMsrSJlzqsALcV?=
 =?us-ascii?Q?z/Ub/IrsD2GLEr62Sq7CcVBWhqUphqms38KrPgDA3VEqL3blvhtnqdYrwCOX?=
 =?us-ascii?Q?nRTZ+LGphozSW9kgHQsiXhqbjsZ29q05smQ7fbsK+hnPUJr5CK2r1BJmaZwB?=
 =?us-ascii?Q?cJJcNia1EAXB2hrhEwQA+cxgEcUK2l+yDJ6pzc6x/oD7ptGpaSbMU6qNT4Tt?=
 =?us-ascii?Q?crJ2WqGBqn8dnRlZ1qgY0gv2IUjoXUc8pxj1o4UK29gARoiqyNeAkFW4x+BO?=
 =?us-ascii?Q?vhpDayXeadoWs0AIBbrwZvZtiY8Kz/o0FTcwyksqs3mUQqZG4SGzPKXAwQii?=
 =?us-ascii?Q?yF5VHs6JbqJqtD0PLY5dBHlbsdFk3eoXjPgG1FCSlGexvIV7zqZLH+GM9bXr?=
 =?us-ascii?Q?ykCQOF5Tj23xyk/RMvlCBJvk+7ITmT/Z4p/vLp3TmaQFzBp7SyGaf3WoTI1d?=
 =?us-ascii?Q?AsxiY3X++QXwO46bDs85yPIxOz2Il2tM12fhGzT5cAHEuHQl8GMZIxmmFB7V?=
 =?us-ascii?Q?9ngFqyHwTimusUL5HOIIEtd/yNfGohjOQIL9XMJ571hfxe/42jCBDrzOfW7t?=
 =?us-ascii?Q?TKwZ+9yae0W5+yILN2ZvpAFPl9B6L8+G5n9WMXX0Mkishr1GV0sZZKLxK6T+?=
 =?us-ascii?Q?qTBfeSz6dm+UXU1GRKwdCLxlbiG261o1OJ/700QwJqCJiex8ulNdwyCzU4j2?=
 =?us-ascii?Q?2Ek+YTiDhKs8YzAjCUGNUM5+lDjFQC8HZpfrSRSU17FEAh3ucP8HSfP3fbe2?=
 =?us-ascii?Q?sWAgKCPxYn4ii8Gc9j1Ycwds3Qw7F8xu46TH2AsQ2gG9gnY7960xpJ4Cf/na?=
 =?us-ascii?Q?i3pYOFzmDkk0dWYazeGtmS5KR5QDEFY211ZygzUBCQikUzNmCvK/NtbBGiqQ?=
 =?us-ascii?Q?hEuaI0cmhAOKJa1rc8r+L9HMNjla1xc3AXCZ7X3zdD+dJOQ+YxPg3BWlPgS2?=
 =?us-ascii?Q?Gv3QNCA1apsBFqsixPTNw2iViftojrKVaXHh7egB/1K9T5uf8YjBGBPUnEzV?=
 =?us-ascii?Q?e0uHtcOt56IlEhAUlKz9f6LGNaO/Mhw7whYDs44ryfgB2gKD/+r8qCcanM/N?=
 =?us-ascii?Q?TfiJxRPhgoP7moQHfenewWXWWXGNtrNE+eS2FltgvTr923VSOdBq8nrcKKDm?=
 =?us-ascii?Q?R2KPdu0CZl7xRI8lCFwDnKdISa1HarCv/JKObuCuGmomIrr2krdgU23TF2Nb?=
 =?us-ascii?Q?1bDOxDuQohFiPjcK2xHAlMx2yMkzjWdNlG8FmtooCEt7dPsHRyHiOk/ob6YN?=
 =?us-ascii?Q?z6IrTgwCE9CVp3w+6CMIl7XeZ3gVGyIpgbUk6pOr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f01a0da-2692-4f9b-5617-08dc6fdaf009
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 03:48:50.1827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDFGRnJt9aocZ5cqYiq6NP61UdKqho/qsDKXtVj+e+561ZfHYeHG7HTqFg9oLLCH5zTCj/2C9PuH8iQ7X5FQog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6446
X-OriginatorOrg: intel.com

On 2024-05-08 at 15:52:32 +0200, Mike Galbraith wrote:
> On Tue, 2024-05-07 at 23:15 +0800, Chen Yu wrote:
> > On 2024-04-05 at 12:28:04 +0200, Peter Zijlstra wrote:
> > > Allow applications to directly set a suggested request/slice length using
> > > sched_attr::sched_runtime.
> > >
> > > The implementation clamps the value to: 0.1[ms] <= slice <= 100[ms]
> > > which is 1/10 the size of HZ=1000 and 10 times the size of HZ=100.
> > >
> > > Applications should strive to use their periodic runtime at a high
> > > confidence interval (95%+) as the target slice. Using a smaller slice
> > > will introduce undue preemptions, while using a larger value will
> > > increase latency.
> > >
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > >
> >
> > Is it possible to leverage this task slice to do better task wakeup placement?
> 
> Slice being unrelated to placement makes its use in a placement related
> knob look wrong.  Even the smallest possible slice is orders of
> magnitude larger than the cycle time of TCP_RR, making slice nearly
> irrelevant to the issue being demonstrating via TCP_RR.

Yes, I agree that there is no direct relationship between the slice and
the task placement. The idea is to use slice as an input hint from the user
to tell the kernel how much latency this user cares(but not expect the task
to last for that long).

> Even for that huge socket box, it won't take long as cycle time increases toward that
> smallest possible slice for the cost of needless wait to bury placement
> decision costs.
>

I see. The wake up latency is composed of:
1. The time to do placement decision.
2. The time wait in the runqueue to be picked.

Even if the 1 has been reduced, the 2 might take more time if the runqueue
is busy. We can mitigate this by checking if there is <= 1 short duration task
on that target CPU. 
 
> > The idea is that, the smaller the slice the wakee has, the less idle CPU it
> > should scan. This can reduce wake latency and inhibit costly task migration,
> > especially on large systems.
> 
> Sure, this is an age old issue that's scaled up to size extra ugly in
> that huge socket box.  Any solution needs to scale as well methinks, a
> simple fixed yardstick won't work, as the costs being mitigated vary
> wildly with platform size/shape.
>

Understand, this slice based placement was chosen for experimental purpose,
and seek for directions. And I agree we should take the platform size(such
as CPU number) into consideration. 

thanks,
Chenyu 

