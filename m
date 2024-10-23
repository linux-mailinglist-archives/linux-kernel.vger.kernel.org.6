Return-Path: <linux-kernel+bounces-378928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B634D9AD754
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 00:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CA9C1F213DF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CAC1FEFB6;
	Wed, 23 Oct 2024 22:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ij9j69JQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6E41FEFB9
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 22:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729721089; cv=fail; b=N/isjGgjuj6iwOZ9CNjzU0lraDdAfEkNjHLakBVC1flmZBWPPSnaupf/DmYKdLNo5Q63Jd1UbqIHkBqYq9vtT44HR4Omsfit9Xzt6Ny0zEm2df68g4k/ILRIO14ZxkLUAykFH6poyzCFG4G9eftoUdcF1k7Jxlx9JEjyfezT870=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729721089; c=relaxed/simple;
	bh=7bhA0l81Ne2YdZ8/fvkwXdKWhLGczlwzdvJjhIaeaNI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F8xH3FsWJWQA7z8vtxn/myzzg9IKcC09xqDeepcaankaANM+hJ+s1d7tuvs8dXoeus+KQ8mU96glvJKXlYKEvwfQ6gX5xcaMD59FA1C0zMIkbGyRdzoE+DVJ7iNS0+QxmV6BE5m8Vnx6oc8bF2y0QIIoWdn4JUjAG9AOOj+iNDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ij9j69JQ; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729721087; x=1761257087;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7bhA0l81Ne2YdZ8/fvkwXdKWhLGczlwzdvJjhIaeaNI=;
  b=Ij9j69JQfWwna9IKRP6iivn7vmxe26UVaFhH1eWtdhuZuuYcFF2afBjG
   19E4hcaSG7pb+ZB82qKgc/HkaVnJCPvCw4gdMGKgP7mNshC6gTm6TRNa4
   Wq14cD9yfgQW6yeOMpKL1dcMDmH3+VEz3H9FVy7C5HskPChphhDSaXN+s
   w0hwXI+C/9zTzgSoZL+WL/sSRQsQ2+kjs1UDpJoFEJriMhB3uJWW8IaxS
   CclrnpwACO53as9zTA3ME5bv+x73hrE6TqMWQSuGWP7i3AxEBGL4FIwYN
   2Vt2C3C1XAbVQolsFa28nGaWoQti6yTl8Doi6zHKfIOFUbRcDZUJKvrw7
   w==;
X-CSE-ConnectionGUID: mkHpcWQWR8ezF8vFWauRMA==
X-CSE-MsgGUID: 2rAaW8ibTzeFsrhTrOsNYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="40700751"
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="40700751"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 15:04:46 -0700
X-CSE-ConnectionGUID: PmtQBLwMSgOFokUXa3gFfQ==
X-CSE-MsgGUID: xXwiaCw8TMe9bIXVsPSzfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="85512465"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 15:04:46 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 15:04:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 15:04:45 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 15:04:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkgTRPuUSNn7Hy0EMmj9leA9kx0wuPZpaJbpMqUIPgmtW3Ee/svsowj455nYQV2sNxakXdGPhY2uOBz4ioZ97qdWepCBAbc2v0kdrz44Mc88JnLie0B5xbQf7CRNGS47UdXjpBET50pEo+JECEB35hyHK+f1DUDUm8gLPN6vw7XsXXCbrwXEbstBVdsIx06jRQ/bPigqP0bWyIDLmo+lEWReSwJXwxjV1ux7u0qlxc06fWfEIVfGG2ZrRblJa15Z6waendmsyhOllnwuOK4F7i0AImius6dEphcSB6nQDmAMNvAXQEi3IJxHAR70BlaYp+afjeKk4YhctMKnM9XLkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKyiFfEbY5XNdIkAPvBjPwt3ak213b6zZ2Wo6zU9V4g=;
 b=YIEfRZYwzPvsHJ8+tprBtQtY/1x1iobcQqlIdEHvEZfBaJDfLxcTyOwbf5tkpOMVrN2C0gugtzQU2TDV3PmfiyNwZzX1dlfLbX2r48/0ekHgpbqIMkt7e91hFWNhGdL/IrLLzgNwhD70pe26M+eJUt4zXMhqETL5tjXhrvLFHWOcZyNP2kiF+w4pH/Kxd17BVgvEsZiD2kW3vmcoakIgTxRjdGlsIgRNEF10CaW6dlqAM2oll3H6P9c9PhYjixezEji3UL9mdfi1Me2kBLZnA881C+gM8qIxBvAsGzxH/AO5OZPO31JExog3YtMXX6PTg/LY7eR6YBkb8GlI4mMvwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM6PR11MB4611.namprd11.prod.outlook.com (2603:10b6:5:2a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 22:04:43 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 22:04:43 +0000
Message-ID: <b8506d51-1348-485a-ab29-8347f635f360@intel.com>
Date: Wed, 23 Oct 2024 15:04:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/40] x86/resctrl: Add
 resctrl_arch_is_evt_configurable() to abstract BMEC
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>
References: <20241004180347.19985-1-james.morse@arm.com>
 <20241004180347.19985-20-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20241004180347.19985-20-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0028.namprd06.prod.outlook.com
 (2603:10b6:303:2a::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM6PR11MB4611:EE_
X-MS-Office365-Filtering-Correlation-Id: cd2098de-ba41-44ad-4ef8-08dcf3aeb2b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z1d6RTF1eTNYUzVpZU5sdXV2WkpycmNvaDBMYm1MTGZvYW5yNFU4TjZ4dGlT?=
 =?utf-8?B?VVBlN0V1WEhkUFN3aE85QmlYc1V2R0VtMURDbHo1amVQS1gzbVNOVFJXNEFu?=
 =?utf-8?B?bVRCcEF6QWJuZFcwWktUclJjYXJablJLVTROU0N6b0YzVGUvcGlZWE9neHk1?=
 =?utf-8?B?aGYwZ1hmZ2VOK2kvWG5Wd29iNEJvZzB2WmdhQnUyT2FaWm1xQkVhazZ4bDYz?=
 =?utf-8?B?VW0zcjBrWk9sQlBCdEJmbVNKV2FSVjhoN2pROE5oNFpzZS9ITGREcjIzb0VB?=
 =?utf-8?B?akVtd2h5YkFzSTN1ZUIwRmtyL1p5elgxN1J6dVlEbmlhZC9mV0NKQmlXdDA4?=
 =?utf-8?B?VTdmd0diUUtFSnkrV3V6bEx6eU52OVgraG14STF3YjQ0a3dacnpPTXh4bHlB?=
 =?utf-8?B?RmtSb2lKZTd2QWxBb2JzbTVjZUxLRzFSWjVYUWFjaW5zbmRzNUhPdWIvNmhz?=
 =?utf-8?B?S0UxTWwzTllzNTJJQkR2T1BiTFJ0dDBJSXpCRkFWTWpzd1p6bTJYNDU2ZlZW?=
 =?utf-8?B?dExnUzl0RERqdnh3YWtTaFY3SVZVeVQ4RE4vYmdvRGhYMUU2MHp0YTdqWk5D?=
 =?utf-8?B?S3FwSmxGdVJVMjFVdGtHWmRTT0JIc3lLdGFGdEd1dlMyd3p6Qlk2dTk0VUk5?=
 =?utf-8?B?NnBoSXplNmJDWXRpbjg0YkZJaUNtWWFmb1lVdUZxMnVWWVdiUTRzOFZQQlZk?=
 =?utf-8?B?UzRxMlovN2Q2SkNVZCtrQmFqNWV6SWplV2hCSzY0b1I5dTV2bk94YXd1U01w?=
 =?utf-8?B?OE9WSGdzcEpyaUJMeGpFUmZrNWpsMjhBTytJK0tUS29PUyttZDJRT09Wa3N3?=
 =?utf-8?B?WUxzbHBycys1UmZmaWc5Uk5jN0dZZnVtcDBCSUVjMjV3dmhFbm9ZWmtyL0VN?=
 =?utf-8?B?Ti8rY3JJTkVQZU1mRXd5QUxuYW0xM0NWZ0hIUDZua3FlTWhRRloxL2Y0WGd1?=
 =?utf-8?B?M0Q2M01mMkZ3WW1oMlpqa2hOQWV4SWxiYzQ2dzV1UDUvbEpJQVNYZFRvVElj?=
 =?utf-8?B?bkFuWVhXd0E2ODROVUUvNHhzSXlabW55RVB5V3Q0WURzNXBSMW0yK0tqS1NP?=
 =?utf-8?B?U3ozZkI4K3pDUEJPUjdjcG1waVVBeXNkMG1MOHVCdUVLSTJKVlVORStUdS9i?=
 =?utf-8?B?ckF4dThWQS9VZXBreVl6Z0xPZVB0NVgyQnM0ejVnQ2lPYk5oeklWMHFTaHBO?=
 =?utf-8?B?dTdwTEZVMGw4NGtkWCtXUG9CSXg3V00wVWp1UElkdUMveERoMmNQMEg1azVT?=
 =?utf-8?B?bTlOdW9zazltaThsRDVwMGh1NHNWb3dSTGZ3T0J6SzlhdUgyaEJwTStZTnlJ?=
 =?utf-8?B?MjhubExpMmhEeTY5eWpzcVpJNFZpbzdGczFyTWtLb01NVU9GUkI3RllTWG1n?=
 =?utf-8?B?dW1RRW1JSzI0MVdoK0dna3RkQzZwV0g3NEdVSHhYUENUSFFnMzJTZlZWMWZj?=
 =?utf-8?B?U1VHSXk5WDV2dC9vbzRwV0k1TXZmbnRlcnZZOWw2UlI1R002V0IxcitxZVNB?=
 =?utf-8?B?UTU4Y3lYTHp1emgwQlpFbFk1MUtwZWJTeW9MdXVOa0ZVZGJiNEw3aWJwSlBo?=
 =?utf-8?B?U2RndDZpbUFDakNkbnNqbzRLRk4wNUI0K1FrMXNsSzNHNEJPU2dDcUV3SXFL?=
 =?utf-8?B?YWVQV1dMTWIyVXdvUWlBNkI4TlovQmRCd1YzL1BCQndjYldibHZPUGpoUDRE?=
 =?utf-8?B?Z2Q5UWxsWWJYRTRpcS9ZSFVUdi9BMHFLbXhKUUVSaUxnc2wxRDQ1ZWdDSXBv?=
 =?utf-8?Q?fkhdKF4RrNqMdX2u5U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFM3ck0xSHAzck0zdVRINUx5T09Yd0VBZGxJbG9ZWG5FL1NaeVRMa0hIbjJm?=
 =?utf-8?B?aVB0UTA3Q01LK0J6M0tiTEpxR3FweUdkZ2ptMzM1cUc3eXVkd2g2UWs4b0dk?=
 =?utf-8?B?VEZLV1M1eDdYU012a3I3bXBCS3BDNkNRRjNsOTBCbmFlTHRsYldlVlJIYUVu?=
 =?utf-8?B?c1MvWXNQVm9qSDZCKytXMjlsS1plY0lRZmlSQWpBdGprQVBORFV0QjBlc0pR?=
 =?utf-8?B?ZzczZzNURUNBb2c0bFNRUjA2VFJ2Um8xRmNJUUJmQm5ZSVpMVWhOSjJzTGVI?=
 =?utf-8?B?MXVmZ3ZqdUx6aWVvZ0hMRk0vdDFGdXM2QkhpNUNZZWE0dFlQcjJna3Q0NnA1?=
 =?utf-8?B?RzVhSmtRc1lGSW1CaHN4TjNIZnJHTDV1dkJTdUgwMDV3OUdwakpBZktvWDRW?=
 =?utf-8?B?RWkxOS9tTmxHRDNndUlEN0lsd3ZrS2wvTm9yMmZobitrWVpFaTVFZDBYTW9w?=
 =?utf-8?B?cXFwTjQ0Q0dycUZ6TlJHQXpjWGY4dnZvZXZWSFptZFhudEF5WEM0MjJGTElC?=
 =?utf-8?B?WWhXeTRQZzYrVklpbXgwRHAzOXBnTnJlZ1M2S2lZdW05WHdRak9IYjdlQzRy?=
 =?utf-8?B?TzA3U0pvLzVsWUFxTkMxRnZDNnRHdEdGeE9CK2RkbVNqQ0R1VHBiNzY4WHdO?=
 =?utf-8?B?eHVVYWtXQmhaamUyNUxKUDZ1bW11QjlUSWNjZG1adC8zS0t6a2oxcVYya0Uw?=
 =?utf-8?B?bWN4a0phWXV3MExKeEM5Y01oMzB4eURXRmZLK0c2NW80b2M2K2t3MkNUdSt4?=
 =?utf-8?B?cTdEcm5JWCtjVnlZNWJaVTRRWTBmbmFRUEthYkJKanF2VGNScnRPQW01ZlB5?=
 =?utf-8?B?Y3pCSitGNFQ2aU11emtvODBVYnBHNVJRaHlBM0xJU0RMTFNhUHc1ZGpOQVdt?=
 =?utf-8?B?MmpiNHg2NEFXMG4zZTFuSCtiMjJKWjViK3Q3dC9nODNOYU12SWZBeGJNckpW?=
 =?utf-8?B?Z0VaTWR6UGUzaUF2STQySDZXQjlmd29kMDFwYzJTN3ZtUVIxRTY5RWgrWVlv?=
 =?utf-8?B?ejFpVnhORzlwTG9ybGRrOU1Qa082dWxlRVZGcWh2UXFwVTMxeGZETXloRFN4?=
 =?utf-8?B?LzMxOHc1NVNoYWhYTHllMU1MMUs2M0tra1dTZGhRKzNCb1VITVVGZ1R1czBC?=
 =?utf-8?B?S3F3REtOa1dVbmwraTg2U3lVdVFlOThJKzhaUS8ydlBBTEtSNUFEUGt0TWwy?=
 =?utf-8?B?bTNtWGZsSlFnOVpqQktQNGFzTTZ1UFlKV0IzelU3Yi9VMXJVQ1I0UytpRG9Y?=
 =?utf-8?B?cFlwbjNxcHJoeCt5aFRoNkc2QUZEUGJNcFhyZnY2cjJGQ2oyZmVCNjZtNHZy?=
 =?utf-8?B?M3VIa0FSNThwSnV0QWVpVE9BcmQ3MzZhRU5FN1U1c1F2b0xJUXJIZUZKeHdn?=
 =?utf-8?B?K2VMMjhFemdsOXJVWUZENTJkTUJLNUkvNkRvS1ViTjh1em1RNjQ3dVZRcDRq?=
 =?utf-8?B?R3phamRUMHJPYm1UMWd4am94YXF5RVAycForNDJjWlNMZXc1YVJ4L0VFUktF?=
 =?utf-8?B?UDhtbmxoOU5leVFlSUlwZEN4UzdjRmhpc3hpajg5Mk84eENxdHcrN3duYXJB?=
 =?utf-8?B?Mm9yOFFZUDI2M0owdUpiWnk0NHBUZUFITmNZK205M2g1ZTViNmtCVWJwL1c4?=
 =?utf-8?B?QU13ZFMwWUw3azlzMHRCNGxNS3NYTVRDREwyaWJTcGFFdEhHS29qdWdoT24v?=
 =?utf-8?B?V0hvOTlMdjBUb2dvTGZxZlJxV0JYakR4Nm0waVBRNHVyelE0KytrZ2tuTVlC?=
 =?utf-8?B?UUNXcGE4U0ZaVnRTTzhVZUJGWjBlcDdnRUVrYnptUU5hN1hpR2Q4elBRUW1r?=
 =?utf-8?B?YUlCRmtkSm9tSzVKSDRpVGx6UVRFQkJuTi9RaGVGUUVWRnZOVVg3YzVUbDFD?=
 =?utf-8?B?emc2bkJEUVN0WWZpN0k3MysyRUZLK2hiODBwMjcxaVJ5dWdkYjVtVklXUktL?=
 =?utf-8?B?czBYTnY0anFYWU52dVZTM0NJMXdvV05jNE5NL3pVakVQTmJibFRlSzgzYnBO?=
 =?utf-8?B?L2VFZ2NUcCtndnEyanpaWDhzQWljZkZrUDlYRGo0eVNYd3d6RkhoSkwxSk56?=
 =?utf-8?B?SjJsV1YzTmNtdDVzZm5adW1tNU1XMktiNWdzUWlRNDhaY2NjckpXVlBCMVRG?=
 =?utf-8?B?RXNnV2UwZ3I2ZmE2NUFteEJYVU1sVFRxVVhFanp3WGZJUmFMS0pZUU9IU0Vm?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2098de-ba41-44ad-4ef8-08dcf3aeb2b6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 22:04:42.9239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: REyWkJUfPi4bCUBucGPI0OwqWOzihGOHdJWVw2s/OF8K5zFXfJ9/0sSz6bCUXOf+OXTM9Vtv7otwddkaz8KwL9yMxrdNU8kGdkE5cz8c3io=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4611
X-OriginatorOrg: intel.com

Hi James,

On 10/4/24 11:03 AM, James Morse wrote:
> When BMEC is supported the resctrl event can be configured in a number
> of ways. This depends on architecture support. rdt_get_mon_l3_config()
> modifies the struct mon_evt and calls mbm_config_rftype_init() to create
> the files that allow the configuration.
> 
> Splitting this into separate architecture and filesystem parts would
> require the struct mon_evt and mbm_config_rftype_init() to be exposed.
> 
> Instead, add resctrl_arch_is_evt_configurable(), and use this from
> resctrl_mon_resource_init() to initialise struct mon_evt and call
> mbm_config_rftype_init().
> resctrl_arch_is_evt_configurable() calls rdt_cpu_has() so it doesn't
> obviously benefit from being inlined. Putting it in core.c will allow
> rdt_cpu_has() to eventually become static.

Why bother with rdt_cpu_has() when there are all those helpers available
from previous patch?

> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

Reinette

