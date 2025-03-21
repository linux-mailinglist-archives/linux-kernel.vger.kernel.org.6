Return-Path: <linux-kernel+bounces-572071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE674A6C634
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 00:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCD777A6299
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5D51F1516;
	Fri, 21 Mar 2025 23:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j00jCQBW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41341BD9C1;
	Fri, 21 Mar 2025 23:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742598029; cv=fail; b=VrUlzX7UygP6skQ6iTokT3PPmRMLe2SeQSf6zKavB1oTB+G9F5p2TYRsWnbm5ChD7/z6eSePdGqXxwow5TAtmCNVxfEPkv6THQf/JtkgnaGXAVlAL7N8FndKMJU3aStIgN7kudrkLd1ATHoNp3Q57JEmTkGWGCF5hT+i8kprzIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742598029; c=relaxed/simple;
	bh=+Pv+bUWRu+FFjzU0p5f1lqa6Sn7FQc/R0dcUXEGYH4A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EYiqIXKzO45MIna7+I6sCXGqMoCZJs4ef1Fa50UP4v/7407tnmN0CwcE9jJn8oj0walyAAJe1A8n7QgN2pOrXxRofkfulwxXstLqHiLOHk+RV5xM61Xk9h4pTUhwfiUDQlrS+By56PfG3ixQ1L8O3Hkpt54h3WISHhhEW8g5KSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j00jCQBW; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742598027; x=1774134027;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+Pv+bUWRu+FFjzU0p5f1lqa6Sn7FQc/R0dcUXEGYH4A=;
  b=j00jCQBWcO4M7mEh0zPLtu/SpDYkLYRw/9R2Gis8NAVbGTKk1Kr0D8Hf
   XgnVRz7Uz1LFw93Ronvf505B+NyvaSAq6lIHWPeQ2OrWm3tfM7icOOnsD
   evLrgI3teYZrnnrhoMBohy1i8fuTueoZSsZnWytkjz6IER/5jAh1oVoHx
   yHrOraBbj0UGRdUZCum6l8nHofvwy6/6ElYofKLgQSSiVn3RDS8OI1uwp
   dofxClKaLG7Pql0MQHcVCVZe+lQa0qxnHM9dMSnkRTzob9i/+Z8b2Vfuu
   twF2osmVNc+EMqZFeL14rPV4a2mIWGQ7H4FabTHMErbHmuXedcW2XIRR/
   Q==;
X-CSE-ConnectionGUID: hMh/hYFyQv2TcUumXhCQow==
X-CSE-MsgGUID: kXdVLN/mREi0hj6YBZT01Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="44066435"
X-IronPort-AV: E=Sophos;i="6.14,266,1736841600"; 
   d="scan'208";a="44066435"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 16:00:27 -0700
X-CSE-ConnectionGUID: RWLn9QokTWKkbIoCl7Tn7A==
X-CSE-MsgGUID: eKdtsFUrSHeRSeSQvjdamQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,266,1736841600"; 
   d="scan'208";a="128636502"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 16:00:26 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 21 Mar 2025 16:00:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Mar 2025 16:00:25 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Mar 2025 16:00:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LR9mCw4XB+5kwIIuuOpzgIDY12gg5edLMrwIUp0x8EQRW9vTIYDZCaqm3g0JcLCXnEW3wTcNggDVAM+xskc7aiI7WYLK83X40bDq5TejueVsLft6g+84FrH92ToFTD4TGGB72ST6I5aeRp1I4tCiNzMdOeLza7yDKzFQIpzu0QSSaOp8Xv/Z9MeiE9w2pSghXAN5Pw/p4QGeTGeka+qc5cAD+JkDWd2GR21Ls8aT9tJyjpde7d70am14X/fHXDCNzP5PZ6i0YwIurJEjnmj/kG9udVuSADcgSvLPFKypJ0x80ZunYV/aoyhKubh4LUk69Pvl4+jfNWpqp03oXuX30w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8NZX+7VcYFga6En41fGA133nB3HphAZ+g54Ut62Fec=;
 b=ncdsBGl+OGFs62Lq0r3QiiE/jCIktOiwkK8duzCgujGl/vFn7UF3H5ZP1swKqbFwlnkSbEnDIfkUQJKwA9J5iq1wAkEPHqgH1qBnhfcZEmNJjK718964dGk2V2sqaEeUX3ksoax6gcKTMQ8OKJkqmAP50KUjVybjNy4YzXp3BQKau7gSYuPP8hJe65K8xqxt7Pgn+Gne/gR9DQ6tuqISPZKvsgHSVSa2DQoLfHOwCLAPUE15ckZle0NkIQsnpvgGKg/o9kb/l85dOykn15BYauPWINSLrmUV5B8I7S+wTzkIdD8qIFxTUAdMcqBCNLJ/pBcAJd2w7ZhaBRz05uTl4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB7647.namprd11.prod.outlook.com (2603:10b6:a03:4c3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 23:00:10 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 23:00:09 +0000
Message-ID: <906f3a02-3acc-47c0-9bdb-8a9135160c4a@intel.com>
Date: Fri, 21 Mar 2025 16:00:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] x86/resctrl: Introduce interface to modify
 io_alloc Capacity Bit Masks
To: Babu Moger <babu.moger@amd.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<paulmck@kernel.org>, <thuth@redhat.com>, <rostedt@goodmis.org>,
	<xiongwei.song@windriver.com>, <pawan.kumar.gupta@linux.intel.com>,
	<jpoimboe@kernel.org>, <daniel.sneddon@linux.intel.com>,
	<thomas.lendacky@amd.com>, <perry.yuan@amd.com>, <sandipan.das@amd.com>,
	<kai.huang@intel.com>, <seanjc@google.com>, <xin3.li@intel.com>,
	<ebiggers@google.com>, <andrew.cooper3@citrix.com>,
	<mario.limonciello@amd.com>, <tan.shaopeng@fujitsu.com>,
	<james.morse@arm.com>, <tony.luck@intel.com>, <peternewman@google.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <corbet@lwn.net>
References: <cover.1738272037.git.babu.moger@amd.com>
 <74b65f562c4d61d24cb2be53fb05ee1ca436d59e.1738272037.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <74b65f562c4d61d24cb2be53fb05ee1ca436d59e.1738272037.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:303:b6::13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: ef2def15-e506-4b0b-ddcd-08dd68cc2144
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TFArNmlWRG1lWlVYTG9Qd2FoTjR6VUVtdXl5NGtLQXlHRjduUitLWVpPNi9u?=
 =?utf-8?B?OEhVbjBNdUFseVBKVURQL25lelFveWlBZUZUUTg4UUk3WkZpU05DTkNTQnFl?=
 =?utf-8?B?T3duUnlTQVJOU3czUlNZSVBDeXNGQVdyUzM3aldqY2djTmtqMXVYcXFQcWU1?=
 =?utf-8?B?R3RucGNJQlNqUUdPcnJEN1pacWZFK2t6K0poQU9yWHZGckpQS2Zoc25nVVFX?=
 =?utf-8?B?ZmRxSFAyTTJBeDZmbEFYVFR3cHRwcmNhTUlLQndGbE1QSEM0KzI1dHRZemdX?=
 =?utf-8?B?TjVHTGJLSEJGYlB6UkJ3djM0N0JoQWQzelh2NUhaMzNaa3RNWGNZWnpOdzlu?=
 =?utf-8?B?NWZiN1VpM0VzY1MvTUN6VUJkZUdXOGhNb2VhUlhMejJZQVVETTVubnUvRzFC?=
 =?utf-8?B?ckdiZVE4S0YwQTNFR2xDMzVNMVJRenF1dEF5dHZtS3doY2M1ckxpNWxWQTE1?=
 =?utf-8?B?OHAvZDNqZHZUOWlKSTRPWE8vWFRRbS8xSVhmc1R6WEhBQUtxcGh5UUUvU2pO?=
 =?utf-8?B?NTROT3R4d3c1cHBQekxsSlAvMzBVSUR2NU9uTWV6d1VCT0c4NGVEalhua0xH?=
 =?utf-8?B?RnZ6Z1VEY1BtMUc4NEdCZkI1WnZObjJPajRNMXRoYVV6SE9iczZYZUNrbEww?=
 =?utf-8?B?SlFCTmlnRGFWc3JGRFFRM3NycWw2dWhkUUlTL09CMVFsQnRRWFl0cUxLZ0t3?=
 =?utf-8?B?b1BKK3dyNExFOVVxS21uYUgvK0ZsN05rWmpkS3VmNWhZOGlob3g4VEZrK0N1?=
 =?utf-8?B?K1Y1R2VJNDdBTEpmR3pGL082WCtVSU5rNW5UQUloS2YybDdxaThlNVhBUnVs?=
 =?utf-8?B?Zjk2NTVNV3N5YTVjdm5sckExUDQwS0hLTnZ2TFVYbkt3TkV4MThuNnBnQzgz?=
 =?utf-8?B?cFJGWVIvYzY3eTliVDEwZEIzVUsvMTVLMjIya3JEVWVUVnU1R0cxM05od2NN?=
 =?utf-8?B?RmZwWm5MS2FyRU1GUEZ2T1AzNUQvajJYZk1EOXRCZk9KdDdHZ2VtQk9wVEFy?=
 =?utf-8?B?T3JrSXljNFVWNVN5R0RrVXVwOURTTTliTXphbWxUcjduT2ZEY1YxaUM4dWt0?=
 =?utf-8?B?b2JCWXQ0cFl6NFVJUVRwZHc5Ky94RFJuU3RGbytYWXlrNHh3RTBLblZBTm4v?=
 =?utf-8?B?SGRnZ29EZXV3cFhoSlpFT2Vjb3ErYVdwRzZ2eU5YcXJqSlFLZE02V01EbTFQ?=
 =?utf-8?B?cnR0c1V0eFdXUGNnaGZPSnJCVngvZlZFYklPRStJY2ZCaFpGNHErYm9oc1p6?=
 =?utf-8?B?bHJYQVg5emZUcXRIbExEdjhLOXozVzI1U0s2NzZBTEJUaDdSbXBmQ2pqaEU4?=
 =?utf-8?B?QmRLMkhtMXdOVmJ6bGN2UFgwVk04T1NWeDc4RjNJcmRIY1paNGRVQ2IrZ2FN?=
 =?utf-8?B?K1IvS0VVZHRWalZMQ2xSbkhCeE9GbWxuMTFGQS9iL3lQc1QyeXNMVWZmMVpD?=
 =?utf-8?B?VUlTK2NyaEdtbU9uSFE1RThrQ2IwdXoxTkE0WGgrUndRTnFrYVcyaTMzdEox?=
 =?utf-8?B?Vm1NUHhXSFVRdDdQNWlPK0xVRElNR01ORUlad3hIWjRTODVvSTR0aHdFamRR?=
 =?utf-8?B?dmExMXhsVEkweTNpRXFObDYwblhidGYyY1VvNGpXZ09wd0lmZE5Da1NYaDlo?=
 =?utf-8?B?QU56K1RnNk5MNkRDc3NVaVhWeUJMZENFTlBPZXJvZ2c1UDRXSmllc1pUTVRV?=
 =?utf-8?B?TXhqSURDLzZzZlpUamZHMXJyajlDQ3p3WnVUYmxkcVZWOWJTTlNDbUhFeE1K?=
 =?utf-8?B?UmFPMU5hZDc3QSsydFdwVHRaVDJqeWJoOXNMUjc0YnJCVVJKZko5OUVZYll6?=
 =?utf-8?B?KzRDMFNCQ0luSDZaT0RaRXo4cWw0TW1vSWtMQzJETG5GZ1VCaGk4TkdlUzdj?=
 =?utf-8?Q?xhz0kDBuRv/oL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R05Vb0dKclh6NXBVQzJLTGdNTzlqRlFnNWJtL1JUcm9DMjVZVXUzSlVBYlNu?=
 =?utf-8?B?cVZvbTRDOUFwQ3RZTCtyakx2b1hwbjZKQXFZZEY2WUJSWHkvSmdVbUovSndh?=
 =?utf-8?B?ak9ETGxJMGJIaFFGR0ZUbDh2aktJV2IzK1ZIV3JKS05jcys0TGZOS3MvR0lH?=
 =?utf-8?B?K3pYTjZIVi9MZXA2V0EwZi9EekxPTzVqd2NJRkRqbEVXT0hHV0RrWUNrOTAr?=
 =?utf-8?B?WDgrM3h2QVkwallQZ1JNNm0yaTFIWjA1YjJzT1ozKzRyK3pSTzkzKzZvM0Rr?=
 =?utf-8?B?UFZuS29uQktwd0NvTnAvZDUvaDJIWTJYWFRTR0xjWm5LZXBmYnV3YlhoWCtG?=
 =?utf-8?B?TEtucXBKOEtJSGJESHdxRS9xRmthZU1nWWtMN01XTGNUbUNmOTZxazdDNllO?=
 =?utf-8?B?RzRHV0VQaFNjOXhvdVVETHFvWEdFdXFIUGhralF3NkVjYWl5ejJlcXA0UHp4?=
 =?utf-8?B?NWN2N3hsOG1VVlRsaWJsWEtYYkhtYm5MNWU2S3VtUklGOUNZYmhEaFhZdFUr?=
 =?utf-8?B?N0k5ZFlOSjhoZmZ4R0JmaHVnL2pQcmN3eWsxUTdrUjVMd0szNTNvN0JkcE1Y?=
 =?utf-8?B?RlI4MXJOYkVQaytRWjhsUi9RWDFycEl6eC9XZkw5YzNSdFNWN1Z4WTZkd09T?=
 =?utf-8?B?dTZGK21qK2FyOUxsZGhGRkhZS3YrbzhTRlMzUWw3WG5md3Y2NGpqMDhaK2JG?=
 =?utf-8?B?dmJrYVh5RXBQM3pJaDlTMHNibFp5enJncWZrc2VnbnZkMFU3cTVnWTVvOXZl?=
 =?utf-8?B?RW1aTDhZUFF5eVgzbUluQXIrb0NDQ2R0Z1d5eDBuOFNMQlIrdTFXWFQ4TGxw?=
 =?utf-8?B?OWh5eWZMTUlmbnkvRk8vSUJNM2o0NlRvZGUyUVdUb0dkVUt0dXozRWUrTWFP?=
 =?utf-8?B?WTc2WlA1ZVVHK3UzTWdjMlBpVHhtOUdCaUEzK3hvMnM2amRMbG8rcUwxdGFP?=
 =?utf-8?B?SEtFelUwTVBoU0wvM2tpTlpUbDVLUS9DQXNGVFU4WlZ5NzJmSDB0YnVXcDQ5?=
 =?utf-8?B?aWNoa2l5eW16VmE5dnJmc0JxaW81WndLamRGYXFSclVxZzFxbktOOU1YdkFt?=
 =?utf-8?B?RFJ4eC9HaHRDRUVGVzBtRC9DNVJxNmljbXdkZGxkUzBGS01ORzloRXg2NHU5?=
 =?utf-8?B?bmVvRzR2NHpsQ295VFdKNnFYNnJMd1R1TDFkd2RLU1pDeVhZcURMWmphd2Nl?=
 =?utf-8?B?RkQyWHZJZXAwZER2ckNESWJYN1FQdVp3VkhLQjRsWU5lZ3BnWXl2d2RyRGVG?=
 =?utf-8?B?RU1CL3B3T2tYTS90VzZMaVZ5WXphaTVXb1Q1ekJoam80MnRYV1JPNE45aERj?=
 =?utf-8?B?cFgvcWVKb3k4b3ZDV2dRVEJVUGtjT0RPMjJORXN5cWdtbmxSZlJkV3RlRW5E?=
 =?utf-8?B?dTllYmMvS2JXMmhGU29GSm9uNEllQWloWHdNNlVUYXYzdmF3V1ExOTIyNzBQ?=
 =?utf-8?B?Unp6ZEhHYThDY2piM2VEZlBORjVkWitaeDJaSUU0QklpTWJQUVYybHpJcnZk?=
 =?utf-8?B?dFR1d1lDWGE1NVJibkZkcFJvZFd1VlV0Yk1TSE1hUUpaQ0hGaG8rMEYrVnJN?=
 =?utf-8?B?czY2YTJSU2Q0L2FSbG05dUF5dG5paUNZYVhuNTBNaGt1QTNUbTBQdGVhSUlj?=
 =?utf-8?B?cEptVTB0UjBEb2lPMEhTTGJsYmZ2NjFIa0tJYmRRSVhKL0hsZGtCcDZNUTZL?=
 =?utf-8?B?WTExQXUvcW5ETE1tak5RR2NhaFg3ZFM1VWF3K1hGVGNDSnF6OEV5cWIxT1No?=
 =?utf-8?B?K0NSN1lTNGlZMTFBZnF1UjRpRmJaTXAzZHdMSmxwRzFmUzBrcE1KY1lPZmlm?=
 =?utf-8?B?U0hTbXBrTmpTdHJWOGlEUDhHczV6bjNoN3B3UjJMQVcvVFZwRDBiS2ZTbG5o?=
 =?utf-8?B?Vmc3SWJJeWRsSzlKcG10d01Odm9zSVJWL2xucytBdGxRWjFEc0h1YnYxQ0dj?=
 =?utf-8?B?NnVHbm9LcGx5RUwzRVJCWTZvQXo4N0tsQWZsc21xMkpmdE5sb1JoaUhMN3I0?=
 =?utf-8?B?eXBac0c1VkV1NHZ6aVY0MVU0bjZ4dndBM0pPaDloK3IwV1QzNEMxZHdYVjgw?=
 =?utf-8?B?U0FORzEvUyttRzNBMkIxRHhWRGcxYXN4S0VqcVBVc01BdDUxaGVheGc4Ums0?=
 =?utf-8?B?T3kyTUtvOXM2NGo5V2t1VEwxcExWMUZQRTlqTmlobjRrcFZWRUI3VXN5M2FI?=
 =?utf-8?B?Tmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2def15-e506-4b0b-ddcd-08dd68cc2144
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 23:00:09.8661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QaWCXZy4sIlOS1c+JhorlU14LzGks/orNkuCPilSUSrIt1j6Mcqg3FLW6M7lRodZXJXd8fLAVHRN0PKl9Y43Kmr83mpbu+19oKAjNMXHt1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7647
X-OriginatorOrg: intel.com

Hi Babu,

On 1/30/25 1:20 PM, Babu Moger wrote:
> "io_alloc" feature is a mechanism that enables direct insertion of data
> from I/O devices into the L3 cache. By directly caching data from I/O
> devices rather than first storing the I/O data in DRAM, it reduces the
> demands on DRAM bandwidth and reduces latency to the processor consuming
> the I/O data.
> 
> io_alloc feature uses the highest CLOSID to route the traffic from I/O
> devices. Provide the interface to modify io_alloc CBMs (Capacity Bit Mask)
> when feature is enabled.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v3: Minor changes due to changes in resctrl_arch_get_io_alloc_enabled()
>     and resctrl_io_alloc_closid_get().
>     Taken care of handling the CBM update when CDP is enabled.
>     Updated the commit log to make it generic.
> 
> v2: Added more generic text in documentation.
> ---
>  Documentation/arch/x86/resctrl.rst        |  12 ++
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |   2 +-
>  arch/x86/kernel/cpu/resctrl/internal.h    |   1 +
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 134 +++++++++++++++++++++-
>  4 files changed, 147 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index 1b67e31d626c..29c8851bcc7f 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -169,6 +169,18 @@ related to allocation:
>  		When CDP is enabled, io_alloc routes I/O traffic using the highest
>  		CLOSID allocated for the instruction cache.
>  
> +"io_alloc_cbm":
> +		Capacity Bit Masks (CBMs) available to supported IO devices which
> +		can directly insert cache lines in L3 which can help to reduce the
> +		latency. CBM can be configured by writing to the interface in the
> +		following format::
> +
> +			L3:<cache_id0>=<cbm>;<cache_id1>=<cbm>;...

This format is dependent on the resource name (not always L3).

> +
> +		When CDP is enabled, L3 control is divided into two separate resources:
> +		L3CODE and L3DATA. However, the CBM can only be updated on the L3CODE
> +		resource.
> +
>  Memory bandwidth(MB) subdirectory contains the following files
>  with respect to allocation:
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index d272dea43924..4dfee0436c1c 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -102,7 +102,7 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
>   * requires at least two bits set.
>   * AMD allows non-contiguous bitmasks.
>   */
> -static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
> +bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
>  {
>  	unsigned long first_bit, zero_bit, val;
>  	unsigned int cbm_len = r->cache.cbm_len;
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 07cf8409174d..702f6926bbdf 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -669,4 +669,5 @@ void rdt_staged_configs_clear(void);
>  bool closid_allocated(unsigned int closid);
>  int resctrl_find_cleanest_closid(void);
>  void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid);
> +bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r);
>  #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 81b9d8c5dabf..9997cbfc1c19 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1999,6 +1999,137 @@ static int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of,
>  	return ret;
>  }
>  
> +/*
> + * Read the CBM and check the validity. Make sure CBM is not shared
> + * with any other exclusive resctrl groups.
> + */
> +static int resctrl_io_alloc_parse_cbm(char *buf, struct resctrl_schema *s,
> +				      struct rdt_ctrl_domain *d)
> +{
> +	struct resctrl_staged_config *cfg;
> +	struct rdt_resource *r = s->res;
> +	u32 io_alloc_closid;
> +	u32 cbm_val;
> +
> +	cfg = &d->staged_config[s->conf_type];
> +	if (cfg->have_new_ctrl) {
> +		rdt_last_cmd_printf("Duplicate domain %d\n", d->hdr.id);
> +		return -EINVAL;
> +	}
> +
> +	if (!cbm_validate(buf, &cbm_val, r))
> +		return -EINVAL;
> +
> +	/*
> +	 * The CBM may not overlap with other exclusive group.
> +	 */
> +	io_alloc_closid = resctrl_io_alloc_closid_get(r, s);
> +	if (rdtgroup_cbm_overlaps(s, d, cbm_val, io_alloc_closid, true)) {
> +		rdt_last_cmd_puts("Overlaps with exclusive group\n");
> +		return -EINVAL;
> +	}
> +
> +	cfg->new_ctrl = cbm_val;
> +	cfg->have_new_ctrl = true;
> +
> +	return 0;
> +}

Could you please reduce amount of duplication with parse_cbm()?

(for rest of patch, please check that related comments from previous patches
are addressed here also)

Reinette

