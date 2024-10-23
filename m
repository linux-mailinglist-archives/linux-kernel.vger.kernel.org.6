Return-Path: <linux-kernel+bounces-378891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2059AD6C9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B5C61C20A4B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4941D279D;
	Wed, 23 Oct 2024 21:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G74OI6UD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5971817108A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 21:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729719164; cv=fail; b=H04tDdIDfe9EoNCw3HRry1KLalpHOVNbXnRXkzM3rI6FyOV34H4iToOzYi4Qiutr1SguN+NPYV5PHZJGKWAnnYk5CJ0XDaeEev3Rdje6KKJXxOBM53qRUemDd/93NWt7+D2aysX80UEt01BjoCYWihyW3DtnZj2isyzDRjKWwTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729719164; c=relaxed/simple;
	bh=gIdULSG6TbXBWqOTP2aX4tl2ZG7ybZbBqKVeOWQFQm4=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kmKt+rDropTKL9Enrfzn8hlvc4GjHXSMO+2agA+uYnpY7nqVreg33L2RSUMka+pQonvKMYz1XMRgL4hGFItlxaroyQWXW0q0oEGXratS7bBkIu293gqQxGLEz49AhQ0Ncw51FCfjpBYQQ5CjVflEuqILnXA+oG/oXhiq/e4y864=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G74OI6UD; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729719163; x=1761255163;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gIdULSG6TbXBWqOTP2aX4tl2ZG7ybZbBqKVeOWQFQm4=;
  b=G74OI6UDkUH3PQgAa3r4PfsmSVkmvwUAPY50sdq//TdNn9OH9z5ioFlV
   JsjThN2AbDVZMU1eCqb/0JU5hnOdVEB8xN+GF7o5EwUhYhBT4W+YDMfEJ
   LodaQXu/s1xgJebkroqd94gTe/WYNDrwgSgeXN5wJISox2OZLN4QCHdZg
   tnucvM/Bbe0nxVIxrGm5C69m7/50yI7z00gXHEfaYpqglsLJ8hTLXokuA
   jaEX9kNVSWyoY3RJBVjEg44bvVt5jLiRCZUH3lx7U8nqxHoIudzSR9Y6W
   FTeVZezb1i6NOb66Xw6kndlXc4VY4oot08a2Kih7lJ9xry0FPpn4ROGi+
   g==;
X-CSE-ConnectionGUID: oLtROmRLTiiZ3H9gYNWLcQ==
X-CSE-MsgGUID: Top50v8kScyvxNj861WRYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39876852"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39876852"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 14:32:42 -0700
X-CSE-ConnectionGUID: AGc2hXG7QFKLwCEbZ8Z6rQ==
X-CSE-MsgGUID: lTi4l5SFRZGwcL211gCJuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="80703848"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 14:32:40 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 14:32:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 14:32:40 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 14:32:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7rQ0jYahZK2qF8LaGnU73S3CyrtjwYZf+Ss+B1BjvF+ctsGV8g3M1ZRJrmNPEXKWVVGl0kWChWG84+u9+RF4ccLcIouxwXwiZk+H8NF8sHGoENj+nuZP3pdFSQaBsdbZ9PO8Fn+TxYEN7KdrH1rbvWemqc57NaRbTRiiPxuzIRvdoxkQOGtJIVbPeT28Da0qOs1y20E2BEWydrTAHU/9BmZZn/49pMifctayYvN2nKiqnj/MqKZWZCf/441/DrAeVNMXE4tBYjzz9yqh4rt6KOs6IGXH7/xjuECM7ok1nl0GDORQ01qNyjpxruJgQ0w8knGOneekRjkcWMDTdcgHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8TRawAKvFqSj3aZnW8rhsTOUkh9rW4liR615QCOwiM=;
 b=udh5yAb9sDE/EUtobX4lx/+pvUqAEaMB4uGbs4Gqf2REoPy5clprpU5Jw1V5LF+G16U8IZAbQoBfnbh2e6aIvLemNYm9p2jjKlJNQpluhA5aPymwlaEvP1hFNDJatcO/4TuHog6m86stRG1mozDBHowVJLYYzx6tZqqYw8WB5YO6J024MuA0GxmLgP00yQJsfCYO+m4ID2D7SqRWAqj+wDMYnOVosgz1uIsxeHrmJz9Q/a0bVd4+0J7kgGcePNJMH+y1/NTDcJywG3NvN0gTmYbPhQHKnmFBuk9gU1myqLfQtPancyrSjeFrTS4hDU8Oe+YHFR2Aaym3F7LaFVKAYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB6828.namprd11.prod.outlook.com (2603:10b6:806:2a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Wed, 23 Oct
 2024 21:32:34 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 21:32:34 +0000
Message-ID: <a0ed3b9b-c035-440b-8244-7e6a5c4009c9@intel.com>
Date: Wed, 23 Oct 2024 14:32:31 -0700
User-Agent: Mozilla Thunderbird
From: Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v5 14/40] x86/resctrl: Add a resctrl helper to reset all
 the resources
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
 <20241004180347.19985-15-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20241004180347.19985-15-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0245.namprd04.prod.outlook.com
 (2603:10b6:303:88::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: 9486e763-90b4-4d2b-ab16-08dcf3aa3523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFZBQ3lYTjZLSjhFTEMxWGxZU0M0WEkva0tLSVM3MmJDTzRkMmMvNWJFS2hz?=
 =?utf-8?B?MHd4b1ZINXVvalZvME1JNUNvNGV0aXEyNk1LMlVMZER5WW5ncUdsOEN5MWpZ?=
 =?utf-8?B?UnRlRll0ekt1enpLN1REaWxJNVZKS05rbEJMRkRuR0tTc0xXa2NrejBkdHd6?=
 =?utf-8?B?aUhrOGZqeVNIemhlcFF1a2laU1l1empENlJXYTJ1WjZybmtrUXJnRTlUV0d4?=
 =?utf-8?B?d3RuQUVKWHBGcXZKUjRySjBybVM4Nm9XS0ZabG5rYmJPWkE3VTB1N1JGTEU2?=
 =?utf-8?B?d25Cc2NFRUFaOGJRMGxJSUFTSm1IaCt1WDROT1lxRWxpck1VNGpKM1gyT3VX?=
 =?utf-8?B?L2ZVT0RXdEhqUzBKbnZ0cjhub0szRnR4STBySnlYUi8yMk5iczRXLytqOUZi?=
 =?utf-8?B?Q3JlK3Vib1A4QWJFdkJpVEZjaklPR1Ryek0rYzByU3ZxT3NUZ2lndDliaTlS?=
 =?utf-8?B?NmYxYzJ0MjNyU1pUelJBVUxhaGN1OHRuOFdOYmNNbFVtVHE0dUFLL0p2d1kr?=
 =?utf-8?B?MmZJZmRrTGcxTUdGWWJvOWhxdGZxc0E4dnJ4L1B0dndPUGlqUTQwWU93MkYz?=
 =?utf-8?B?TzhmcE9weVJNSnhDQXIyd0dJc3h1MGtCN25JRkxMTXRqY3hVM0phSU9CL096?=
 =?utf-8?B?SHYvRXZYY0ZqVDN6Q0RlUGRTc0dqejFORlJmWlhuTS9uMTRXRFhQWmp1MzRw?=
 =?utf-8?B?TjlmRnVzWUpWbTlwVDVFMDlvR0tPaWlIY3VvYWF6Z3dHMXNvNWZRMTZpWE9v?=
 =?utf-8?B?ZUJEY1RmY0E1VzhIdFZYZ2tnT2RNdG41TWtvSGVZMTErck5Fd0UzVDFKQXlt?=
 =?utf-8?B?ajNwOC9sVGdGelcxdlF6d0o2cWd3TEd3YnBkTC9wNjVFc0JHODR4NmVDWnlt?=
 =?utf-8?B?d0xmNVlQUVBKSlM5cWtRRzhaVGMyWC9ObXlKMUJjeEtlV2hTVitGZVpjYWds?=
 =?utf-8?B?eTJuVzNyWGdFaGhYcTNnM3l3WXE1T1p2U3crK0tOTXNmUXFkSEw1TFh6cTFL?=
 =?utf-8?B?cW5iaktqaUkzc1JLYVlIZFptY1JQcWZiUlBTV2I1SDJ3RnZlaE5GeE5Sczhk?=
 =?utf-8?B?azRsalBTMkk5aUw2dTloa0xUQ2dMd280R2tTNGpkZ0JxM3VEVGZsRE9iWHFG?=
 =?utf-8?B?WTk4cExmaXljTE5naDdLZ1RGc0RwNGl4eFg4UGdadXF0T01LN2dJdUFvR29t?=
 =?utf-8?B?MUR4aDZQQmxWQisvMzMxMDV1OGxJRVZQa0kyb1R0Z3hjamZ6Q1dlL1U1aEtW?=
 =?utf-8?B?WHZKK3hYZDliRmMyWnBYYTBZYU1aWVVRQ1RWeWk1cldNWTIyREtScm5TTFJ3?=
 =?utf-8?B?aUUxa2dqTHh4cHUvNXdiS3pETDFWUksyREhMZTZ2YmwzOUwydm04QjlBTnEw?=
 =?utf-8?B?bFB0cytnaHUySVIxT0piWWRiU2drcjVDdjNsSmU5LzlMaENaL0phQW1qd3NP?=
 =?utf-8?B?b1VvNzRvemw0cGVubkhHbVd2bk8ySTlFZW9XRy83cmo4T2VSYk5CdEkvcDZN?=
 =?utf-8?B?bFBNT2ZwSE1hNVM1MlBVWGJzRjZSWHNkNHZ5a1djSCswaThFVjUyZkkzUWxl?=
 =?utf-8?B?QVRQRzNXRCtTMWpuK1k3dzF4WGp6SDdab3VaRi9DK2I5QU9wcEVEKzhWdk43?=
 =?utf-8?B?djRnOUc1cFBWaWhBTmwyRlFFZWpmRktIdyt6bCtpaHFkSytvNWZRaDlGa0xj?=
 =?utf-8?B?NU1FWlJiWjMwWEZqRWpSK2xyc2FWbUFTQlM4dkdBUU5jU0Q4K1RDaFUrVmNI?=
 =?utf-8?Q?16xDID0hWJg/18JWUjOibxTBoADJ3JDcddgqoBs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXgzRkxTcUJ4cHhNa05NN041OEFsWmkyem8wZFVDckUxSWZNMDhYY0hIREho?=
 =?utf-8?B?MEpZY2Jra0JhTllTczVTWmhUc0tkOE85QWlYRGlQdi9XbUtrbEp1UXZlNmRT?=
 =?utf-8?B?NmVTQ0tBNkFjRTB2VEl3V3FqL1BSZTZpNGUrZU9mK3ROVzVhRm12aytVdTVR?=
 =?utf-8?B?YlRyTUQ0SzRDKzV0dloyMWl5VGkyZWxNblNKVC9tVTVsNk5wakE0eDhqb0tP?=
 =?utf-8?B?aEJpdmRpQmdEUTY0QnpiMTc1a0tIUjVhcFltVUQyNXM5bzFWd1U0UE5VazIr?=
 =?utf-8?B?c2xJSHdZYzV0bWVXamx5d2dHK2RtY3loZEVnRGdINWI0SDN4ZjNPaDBYdlZS?=
 =?utf-8?B?UWI5SFJldGxsSENEUmhRek56MkUzdjVDMjlWUDR3dytFU3pVbGFwWmxPTzBm?=
 =?utf-8?B?M3VybEEzQldGMU9TODFWMTJ2ODdDVWx5WTVsWkFyekd4eC90TmVIM2ZmUytR?=
 =?utf-8?B?Qm5Tc3dhc0ZBM1g3SWxic2VWUEowQnNjMklJS28raVh0T2NkYVNIZG11aURQ?=
 =?utf-8?B?Z1lnajN1ekIzMStXQUkvTUNrZjVOcGU3YTFrdkZxWnFPVGdxQVdIR1k1dyti?=
 =?utf-8?B?MkI5d1Y1K1ArWG4yMlZ6V082SjYrUkluME9rTi82RTJPcUhweisvRHlzb2hn?=
 =?utf-8?B?Nk9MU1FZQUgrbTNZem0xRGtwWkdZKzBsdUhmZ2VsTnllTGZlUndKcFFBNlc4?=
 =?utf-8?B?OERBMkFiUURiVjZDdFprRXVlM2xhVUhqNVFweVhtS01QMXRCb3dkM3RnamI0?=
 =?utf-8?B?Mit5S0MrU3BHeHJ1eU9iQWpudEExK2tPd1ZMc2g1YitUa2VWeVIwWDJhQXlX?=
 =?utf-8?B?QlN1S1I2R2piU0wxZ3lUSWwzeUNSYUhjMXVVY1dVMEhBUGRZU3IxekFsYVdr?=
 =?utf-8?B?MERBNEo1REtwOWFGT1BSd2p0L09jQmJlMVFYK1N3N1pKa0JacTFRdjZIZytE?=
 =?utf-8?B?TG1xSWNlWWtGOUlBSy9mb01yZHhjVjEvNUsvbHQ2bG5iMDUydnhFcmZnbHo1?=
 =?utf-8?B?OXN2Tnl6STZvT0VsYS9rMXh5VEY4Y1hzNTExZTc5K1piUDNxcm84SkdxOE9F?=
 =?utf-8?B?YW5iT3h6czEwUGZuUGZoK09vK0NzZUM3SGdSMUxlRjdGYkM4a0JHNkpLcy9k?=
 =?utf-8?B?MWtRRXozUXVmWjQ0R2VBUUkvOVZ1bUhmeWl6a1BTQ1R4MDZkNm1xaGJVbmJk?=
 =?utf-8?B?dHpWdFhhZkhSbFhvL1hQcmpqQVowZmRBRE1UaldHWThwV285RjNsOTI0UzYr?=
 =?utf-8?B?Nm0rVzNQNHU1S3VxemZoUVF6a0JYSDJhM3R2TkdTS3pWMEV5K2xkTHBlTEsr?=
 =?utf-8?B?cWhzTk92UFl2dVUvSW1ZSC9zaG5EUTVSMG0yRjNOUGI0SDhxRTNQeHFLQW1h?=
 =?utf-8?B?WW1tU0UvK1g1T3dRNlBaS2F1WUZyeUVDTkRVVWU3NlNla1c0eU4vb2hoVlFK?=
 =?utf-8?B?MUpNYkFZNWpqOHBZUHlDdkpZY1dncUZrZDlCbnB5TUhBL1p6ckFGTUxzVDJk?=
 =?utf-8?B?WGhNREVjNXFNcUVuRWJvbk01cVFUNXExcEhDVFdERkpzUU9LWWFxZkVXSndV?=
 =?utf-8?B?YkVVMmRCR05WSG5Ua1RSYndEOXB3NE10ajNyZE1PNzBMdFREOGMxS2Q4dUVG?=
 =?utf-8?B?bGJXeTNHMTYzQzdiQms2YVhwWmtLZXNUekJCa3R6ZHNDSHU2c3dqY3ZvMmtX?=
 =?utf-8?B?TE9FeUtlaDVKeWF6bDlRY1VZZitIUmhMclZKcG9hcFBzTFlRTkR2S3B4ZGU0?=
 =?utf-8?B?NXF5bHBERU1PcG4zWW9NSGpIZjZ1Q3NLUkVzU2tZMWpnMWRrRDhUeis4QWxj?=
 =?utf-8?B?TWtoeTNuVFZNdGhobWJmWm1SaHBQZW80cEJhaGpqUW9XVWlFdXloSEN3c0ZT?=
 =?utf-8?B?WGxZS2lRNUpnSFVZaHB1ZVVlSTRVVjY5anpRZmJFUE1YWG94cGpEZG4vVS9a?=
 =?utf-8?B?NnFZWU9tUWhIV3dUNVJHKzdDOFlXY01sWmpnZVdWd1p5T2hjRVlCUDV3b3V4?=
 =?utf-8?B?R2JzTWhlOFR5NTVEK3QrQWV2VE1qOGpUdDdhVHFXZkhyU0gwTDlSd052OUZq?=
 =?utf-8?B?SWs5Z0ovanFESjJnbzl3Sml1blJsNHNvNjZuK21WcnQvMEo4Sm5LM3BkSlg2?=
 =?utf-8?B?VXlJSHBiTjJvYlZYdE40MlZHcFJxd2FUb01ydjdKeThiL0ozYU84ZWFCWGVD?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9486e763-90b4-4d2b-ab16-08dcf3aa3523
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 21:32:34.2647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v280XpacFjXHnMAhK2PC7kY/zRRQ+0NwE/k6IUYzhjtmcxqfEKVKO9X/PvJ0S9SkEe7Yip0DVS71icM1hbI9vgsM9lPvLTzsllobuMw6zKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6828
X-OriginatorOrg: intel.com

Hi James,

On 10/4/24 11:03 AM, James Morse wrote:
> On umount(), resctrl resets each resource back to its default
> configuration. It only ever does this for all resources in one go.
> 
> reset_all_ctrls() is architecture specific as it works with struct
> rdt_hw_resource.
> 
> Add an architecture helper to reset all resources.
> 
> Co-developed-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
> Changes since v1:
>  * Rename the for_each_capable_rdt_resource() introduced in the new
>    function resctrl_arch_reset_resources(), back to
>    for_each_alloc_capable_rdt_resource() as it was in the original code.
> 
>    The change looked unintentional; and presumably a resource that does
>    not support resource allocation doesn't have any properties to
>    reset...
> ---
>  arch/x86/include/asm/resctrl.h         |  2 ++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 +++++++++++-----
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
> index 52f2326e2b1e..5622943f6354 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -16,6 +16,8 @@
>   */
>  #define X86_RESCTRL_EMPTY_CLOSID         ((u32)~0)
>  
> +void resctrl_arch_reset_resources(void);
> +
>  /**
>   * struct resctrl_pqr_state - State cache for the PQR MSR
>   * @cur_rmid:		The cached Resource Monitoring ID
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 61c8add103fe..a15198f90b29 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2883,6 +2883,14 @@ static int reset_all_ctrls(struct rdt_resource *r)
>  	return 0;
>  }
>  
> +void resctrl_arch_reset_resources(void)
> +{
> +	struct rdt_resource *r;
> +
> +	for_each_alloc_capable_rdt_resource(r)
> +		reset_all_ctrls(r);
> +}

Wouldn't this require all archs to have a duplicate helper as above with
only the resctrl_all_ctrls() actually being arch specific? 
What if it is instead:
	resctrl_reset_alloc_resources() or reset_alloc_resources() or ...
	{
		struct rdt_resource *r;
	
		for_each_alloc_capable_rdt_resource(r)
			resctrl_arch_reset_all_ctrls(r);
	}

With above archs only need to implement the actual reset code.


> +
>  /*
>   * Move tasks from one to the other group. If @from is NULL, then all tasks
>   * in the systems are moved unconditionally (used for teardown).
> @@ -2992,16 +3000,14 @@ static void rmdir_all_sub(void)
>  
>  static void rdt_kill_sb(struct super_block *sb)
>  {
> -	struct rdt_resource *r;
> -
>  	cpus_read_lock();
>  	mutex_lock(&rdtgroup_mutex);
>  
>  	rdt_disable_ctx();
>  
> -	/*Put everything back to default values. */
> -	for_each_alloc_capable_rdt_resource(r)
> -		reset_all_ctrls(r);
> +	/* Put everything back to default values. */
> +	resctrl_arch_reset_resources();
> +
>  	rmdir_all_sub();
>  	rdt_pseudo_lock_release();
>  	rdtgroup_default.mode = RDT_MODE_SHAREABLE;

Reinette

