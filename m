Return-Path: <linux-kernel+bounces-522617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B107A3CC74
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C709168426
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735A725A2D6;
	Wed, 19 Feb 2025 22:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F0ofTLMp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BED25A2D4
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 22:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740004559; cv=fail; b=Ta4umRrxiNcGrWJx8P56TPoZeD3g5NYupxdhPrJLQcja/C2bq2GjbgxQ16eTDDKW7flR3899cccL62F6gZVan/NCa7s6kK88/SNTMFpJpnLguTPph0KsjrJN2uHibwgh5asrxK1sPjn8EM0UN/2twgQnoTTm9whgbrT9ZnAUj58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740004559; c=relaxed/simple;
	bh=g7e8APw+644IcQcQEZ5tTSL4bmH2fS7y9A8J+XRIQqQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L3e7I2UNylQBJRwd0mHlBkWHdmnckMS7IftpuhuYf898H8Sw/bQipu5PVc0zKRx8BoPYYyWSrv+dFZAklvo8SDK633swz/CY8PeIoUFtShp9MklMysboHP4fWD5Vt4NdOkYqr/i7AUhz94ViM1orgh3OC3AzwRlwsNUW0tnv+iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F0ofTLMp; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740004558; x=1771540558;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g7e8APw+644IcQcQEZ5tTSL4bmH2fS7y9A8J+XRIQqQ=;
  b=F0ofTLMpYgQwuuLivwaB8zanSC0eBqLsJQgzLh8Kc8rKpHDAXk/0CtQi
   n8yxgVqXm1yR3EdF/4+i0O5kDwaVK/hg8azGQxB02UszshSomHk+09pq2
   Gnkv3s0TqmPoW5OiBzkarQbZM6pDFBPz5V2sX83zF0VkLXTb7wvumfddl
   IAPK/veaj+XtlxXi0omfAM2eM4JPWdshftPLeVSQbcyxSPOQNzphFNL63
   77jxQnVdE+27m5HBk00eqWtOlXiGCayMfOEWEnEXDm0X0RRzkfPaMMr1g
   r2vJBFtqQq+iP5ORn6/0lsZOJGC5adVEHYH7JAgw73O/nbBlWDAhH+PNB
   Q==;
X-CSE-ConnectionGUID: 5rz5OKrPQkeVW4uZBY70tw==
X-CSE-MsgGUID: 2RydDaAOTauF2dR8/CbAww==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="63240329"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="63240329"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 14:35:56 -0800
X-CSE-ConnectionGUID: VYmFDEJbQcCopN0lm6AMUg==
X-CSE-MsgGUID: Brkw/wHLS7OB6HATzezOUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="119789581"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 13:56:36 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 13:56:34 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 13:56:34 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 13:56:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yudT3nEedgAqX+9J4rU+8RrgB1LrM7ijL9xMWtGFUGMZlXHISwoMlTkhobm6rb9bP7RD31h7QqJPSIj+areXzPYiN2fXaYWzUs+YgTdCsFsvkObD5noyoQJwKfgl8aX+3VnQTkwFDTvzpsFK0+PNaizC+K2mCM8tToXH/fB2Pd0ZgkeASAoBL8xfX/bu1lA7Y02J2YWrikmq+2jB/bzcfW3935z6IqnQUyT5GwhXxaRLUaXDmMiHuesAvG5KgM+0VgRiDKZ3DDUGRc9PllKtFWBiyz/N2Cqt3/538fqnpdeE1scpt2v4A0zvFOeGzp4EUbjdy0YN/T2agRoMthmdvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/dL2BAYaLGtnTr7ly1aXTQCegidD1YHVRc+E0rBNTA=;
 b=vStNGUASqO9ZPx+A5H2I5nN7rQUmiB9Y1secc16wxNs59XiyQe9aUmBPJTCua5mg28zQVtQwMKv+Lu6qJYu6O4QoNzmDUD09rSyGDbLVANuvE0h/tQHWYnObTWHNKZaWp8//4a4daTad7Nb74CG0yVFF2+yt2t3cwdJYGrmpIMW4Rgy1RWwNV1pOObFOtlH1lKBIfL7AFEK9e52RX5mnc0z5zeSbBjjMPwoIdiyA5xcGIxYyDREe7cCeTVOYvIUxSFWnvh2M8Rs0B1Su7o2bzVdZMpeMeJ+pAff6NTCO2KmyGSneEtbGMGvXYrxkWILxuijWEKgkb1nNHuY4VIFRww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7)
 by IA1PR11MB6492.namprd11.prod.outlook.com (2603:10b6:208:3a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 19 Feb
 2025 21:56:30 +0000
Received: from SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15]) by SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15%6]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 21:56:30 +0000
Message-ID: <64d0552f-0015-496f-85d8-5a0b68cc69e0@intel.com>
Date: Wed, 19 Feb 2025 13:56:27 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/42] x86/resctrl: Remove data_width and the tabular
 format
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
 <20250207181823.6378-7-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250207181823.6378-7-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0091.namprd03.prod.outlook.com
 (2603:10b6:303:b7::6) To SN7PR11MB7566.namprd11.prod.outlook.com
 (2603:10b6:806:34d::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7566:EE_|IA1PR11MB6492:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc76f1d-93af-4b2d-64df-08dd5130443d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGM0QjhyZTBpajJLeUpyYVY5M3Jub3hEdG9wZlgwNHFQQnA2eFZxalJpU2cy?=
 =?utf-8?B?OFNrZXpPUHltQkF0UzJra1JmdmhuVGw0b2F3cCtsUEMvNFZ1ZGVaRTBCMTh4?=
 =?utf-8?B?SmRuamk4dklHRDNnSVo5NlVqL01uTkZvWFNjWDhiOXZ3Q0Q5THVWK0h4V3FB?=
 =?utf-8?B?Qzc1b0JqYytwSmQyNTlGS0p6T21DalkwdG9CRG5PZW9PdjZOZ1VTbnQwNVE5?=
 =?utf-8?B?b0hBMWlKWTNVaHM1c2tCT1M0aGlRalFZcHpWVmIranJZNkNxUUdQRVpHYmJi?=
 =?utf-8?B?WmVCaHpGeHZGOUZBQmVIUHd2L0pBbTZyc2RNeXZsWTE3ZGxNY0FzZFdnQitD?=
 =?utf-8?B?Tm41cnVWMHpaaEpnMGF1dGJKcGhweHZzQU1XT1JmemtpUlVjc0xYNWxZRURB?=
 =?utf-8?B?QWxHMGd1NUs2UldGSkNQeU82NG1yV3gvYmcwdkozbm1JK2JQUHdvaDFxUU9q?=
 =?utf-8?B?VnRnUGZQalVQQ1VkZmpTcTN0Z2pycDVDK0VzSEhwMmIzK05FNFRnTURONUpU?=
 =?utf-8?B?WHk0NGQyTDF5RlRCeG1GMDlMSGk2Und5OFVCSDVHUUFkeE52OTZzL2RNOUt3?=
 =?utf-8?B?WTRmSksvcVlmYXJoVDFRUzlrY2M5b1ZDUjhjb09pNHE5NGt1SEdDR1hYdHJ5?=
 =?utf-8?B?V0JTTWZpTzFYYjhJSGtEUTM3NFRDRGwvaEZ1Uk8wc3R6Zkg2ZW1NZ29EaEFJ?=
 =?utf-8?B?RjNyeHlnYjFvTHVUTFJ6QmdlR3p1UFF6WlJyNGQ2RCttMk5UQlJpanlwSzFp?=
 =?utf-8?B?WkkyWkxCWjdmL0M3MDRXQnlwaTNnSUFvT0RNMEhwU3R3Sm9kbGJhWmZmVjA5?=
 =?utf-8?B?QXEzWGh0eHpHdTNqK3dmb0Y0eGxEeFR1eWVIYWU0SVVuaHczSFFLNWJLV0cw?=
 =?utf-8?B?ZmQreUZrOHZTMlY3dkpBd3ZSWTMycHhZS0VWeFVacFY4YTNPclRKWTJSRUJR?=
 =?utf-8?B?eGIrYXcvUS82RUJvdnVnaDFSb1kyc2tRb1djRnpQZjNpeUNiY1BEbWI1RCtx?=
 =?utf-8?B?VU9qUFVaRWVHVCtZZkVJNmIzMGlFM1NxajJoMGFuQUQrZ0Mvc0plOUl4Ymx0?=
 =?utf-8?B?bkpabUhqZU9Oa2liRGhrSWlqWEpXejFjNkdadUQ0QVYvak1MZnJ2TmVzVEcw?=
 =?utf-8?B?NVBKSUI1MU0xaFhvenltMXVFNi9LVHpJMFhFN3JBTFVXeGh3MTMyWWtVeWJR?=
 =?utf-8?B?REhCZDc5ZG8zSEZIK3ZENVlWZC9zRGVvcXZKMEE2Qm9vVnI2MnlZS2wvdUpj?=
 =?utf-8?B?OHM2K0VJbTZzMmI3Z1JaKzVzVHdNKzRTMVRHai8vV2lJajBURWN0SFZ2VjBD?=
 =?utf-8?B?bTc1dldFanpRaXpUSTNjUmNKT1V5QzBTU1BSZjZSZGFYTDFFb3RpdXhQbm1U?=
 =?utf-8?B?clpmVTlsYXBZTkxRK296N0ZLK2w5aHhtVU1WRFhlS3lHaGVMWDdnbUdzcXdS?=
 =?utf-8?B?VWh4Tk80a3d0TTVxTFZpZytCTnYwTkVFNXFGSWZGcjQyM2NGcldOd2NNaThS?=
 =?utf-8?B?NjNuVjNYbjg3NVYzdWdJYk1NZ0piWDdsNjZ5SFJDdERyN1hoUlhyVjFWbXlz?=
 =?utf-8?B?VGZZbUVlUUM0SFI3b1FPbDlzWTVEZ3ptYThFSzlSbGZBNUJOVjBvMjdwQXZH?=
 =?utf-8?B?b0svUkZIKzQySFUyY0JHNEU0Q0d6bXkyQnQwK0VDRjF6aWFIQ3N4b0FuTkJE?=
 =?utf-8?B?RDRTMFRWd2ZOSmxHNEJpUWN0Mm1CdWo3L1B0Q0VweXlObTVaeEJ0VlRIcDhs?=
 =?utf-8?B?NjkzOVJjTW1jNnU5cVNvYm5TT2RoUDdtRy8rRW9wbU90NXpONXloT3h5QS9z?=
 =?utf-8?B?ak91aVA0ZlFTeDUrcUxWQldLZ3M3c0dZaWhwM1BlcVNKbGdRMGt1VUQ3aTBU?=
 =?utf-8?Q?wKQbLhQYxZSYI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7566.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWdqRjc3aVVqU0VkRkhaajl6emZjVVRJOEZzcUkzZVNKb2RjSEJQeHdXbG55?=
 =?utf-8?B?R1lDTENNa2FKVVVwcEdPOVp6YXAyQWo3ZXd3bWVndzB3Y0VHQ0pKYkdIb0Q2?=
 =?utf-8?B?RC9jWVVTdnhBSDV0TUN0M2FtVFozVWk4K0NKYmRqZzZnOGZkQlZkdjdoY2RM?=
 =?utf-8?B?YVFOcGJ3aE1kRzgxU2hWN25uZXh3N3N6NlR0MjhnWHVaM1N5cVY4ZWFla0kx?=
 =?utf-8?B?VmxTbG5IWG0yS1JhWkIzV1pORitIMHViV21rM0dpL0kvNzROd2orbGJTNkZj?=
 =?utf-8?B?ZktHNDQ5dDhCQzRNZUM5QnozdmFKNjd1SHVqVXN4UzQwTUVNaXdWS05NUmsy?=
 =?utf-8?B?VzR2Uy91WkxKVC9ETmZSU2RhQk9YYnNoU3NNM2xXWk5nTDZlaXNydXBBdEpT?=
 =?utf-8?B?UlFNdE02Ny9VUUFFSDhaRFZlbDRMeG5ldXovOFd6djZjbU9UY2dXYXlnN3Ja?=
 =?utf-8?B?cWVNUHVFWFNmZmVvL0xlUm1ETmk1bmlvMUcxTG1GVkgvR3U4WjVteHM1aS9o?=
 =?utf-8?B?RFh3elJWMnorbnFManRBbVRLSERKS3l5Nlg3NzRoY2tWV0NUUmQvcWtDSG56?=
 =?utf-8?B?aEdiMjhLeEM1YlRoTWMvUUx5K21DR21Wd1dwU0cxdUpUUnhPbnkzbE9WbVlS?=
 =?utf-8?B?SWpoUW5JRlU0djlZZGhyWEJadlI2b1VBRW5Wazg0elFGcHpJUzNZSjdVK2VD?=
 =?utf-8?B?R25EdHBQOCtqTFUvWDBzQTZzK1FrWTVONk5ibGxpWktzUnpzSFNXK3RudUdF?=
 =?utf-8?B?QjFqaUxIRzQwT3YvTXJaTlJ0cmRiL3l4c0Q3Rkk4NTREYkJpWTNvN0Z2Rjcx?=
 =?utf-8?B?RStOYjhvNTVHWmVxSmc0QzcvYXlobFpuTzViUGx0ZjBjeml4cEZmbHdNQmtY?=
 =?utf-8?B?bDZNOUNYdTF2cFBOemxqY1l4Q3VTT241SEdYdy81aWpONVVyWkVDV0NuNkN5?=
 =?utf-8?B?bWlJeXYzTzZ2N2NINzgrZUZBUXMxWDVIN1Bza2dsM3ZjVXc1YWVOY3YwWmlN?=
 =?utf-8?B?eGU0UnRwdVJuOWJPYnFFZWNKZTFmVnBVSkZqKzF3MCtrbVA1ZXc4aCtQNGNB?=
 =?utf-8?B?YVpjeEVDdVdBOXF3S3prRkxqN3dYNThrb1o2NTEwbXQyTzRDRmh3eGR5TlNv?=
 =?utf-8?B?dnBvaFo0SGsvbE9WNHJET3lBMnJucHpMWE9hcjUwOWFxUjVxSnhRMWdlWmdR?=
 =?utf-8?B?WXZWREN6ZVJITXhLU2hheHZrWU8wRkowODhvVVNuNDRwQXVQdVFoakJ5bElH?=
 =?utf-8?B?aU5XOCt0UWlqYXNCSVN6WkNmM0orOXBSMkthNWNiNUdveU9iczJqdHd4U0p6?=
 =?utf-8?B?SkV0cWJlbWxrWG9HRXBkcEw1dlpFL3BZTlZCdDZ4TkZVWFhvL1QyUFc4dnpM?=
 =?utf-8?B?ZEQyVmVoY09jbnc5STBZVEgxbjBhenZsRUI4cDN2d1A0eVdFQzIwY3c3emRt?=
 =?utf-8?B?K0Z0bk90NUhTbG1YT1pIa2lkRjN3Y0FPZ3RCOW1vaEs5dldqQ0lvVitpaVhI?=
 =?utf-8?B?MjhwdUFsdGFLUVJmY1ByTkhIMFBzb2ZSUUlOOVFVZGhKeDJDc1R4MVJCbDJq?=
 =?utf-8?B?VytQNExVem5XbFcyaHpCdThsMEZycXpxcDI1Y2lpaFArSFBMcHQvYkRxV1JS?=
 =?utf-8?B?c1BhK2sxcm1rM1VFcWNHOERKZmpqS2FTMlN5L0I1M2R5UWtxcTV3dTRQME1K?=
 =?utf-8?B?ejhjNG5LNGU2aEY0QjZzRHdyV0pBeVVSaVQwL3h0UWxCQzF6NGxpTk01NmxE?=
 =?utf-8?B?UnB1THphSCtCRXpkMkZmWTVsWnl1d3pjYjA4bmRpSzJ5Q1pxYkV6Y3VqY0Vi?=
 =?utf-8?B?WnpuR2VXR1N5d1dTS3Q2KzBVMmFHYmlVcG84SWJQQndPaDZieitCTktURzFX?=
 =?utf-8?B?dHRoVmRBUy9QV3lGWFlERnF1NzBEK2dpQUprVUROUkRNdUxsSjFWUWZPL1ht?=
 =?utf-8?B?aCsxZU1aYThwZU4wL3E0NHlxUFlRd0pEdjBjQ2Q1c3lvbmNBOURwaVNhRVdB?=
 =?utf-8?B?cnVpY1BhcXROV0s5SGxQNW1jZzNPbWV0ZkJaeHc3bG1uZ253TWpwMUJSV1pl?=
 =?utf-8?B?WER2cHVXQWJ2NmtGdGtBQjJLNnQ0aE5TMno1ZFFkbDl0ZHMwQUFzNlZYQ1pa?=
 =?utf-8?B?ZXUxeDJqRlR1aXJaeVoyUTdESHNqL2E1d1l1RHlYNjhRTE9iVHh5dXJEWTVy?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc76f1d-93af-4b2d-64df-08dd5130443d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7566.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 21:56:30.2830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vlyp0GiqUuJZxLCQvKG5TPHJ3KYSMrkKFW13LebZr9HwtIRqtEP2/VHccUqXJmHfll8qcFRKfOaAPzGuHWXyrNxy5zh8Dur/nXfbRMN/7f4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6492
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:17 AM, James Morse wrote:
> The resctrl architecture code provides a data_width for the controls of
> each resource. This is used to zero pad all control values in the schemata
> file so they appear in columns. The same is done with the resource names
> to complete the visual effect. e.g.
> | SMBA:0=2048
> |   L3:0=00ff
> 
> AMD platforms discover their maximum bandwidth for the MB resource from
> firmware, but hard-code the data_width to 4. If the maximum bandwidth
> requires more digits - the tabular format is silently broken.
> This is also broken when the mba_MBps mount option is used as the
> field width isn't updated. If new schema are added resctrl will need
> to be able to determine the maximum width. The benefit of this
> pretty-printing is questionable.
> 
> Instead of handling runtime discovery of the data_width for AMD platforms,
> remove the feature. These fields are always zero padded so should be
> harmless to remove if the whole field has been treated as a number.
> In the above example, this would now look like this:
> | SMBA:0=2048
> |   L3:0=ff
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

