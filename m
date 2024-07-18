Return-Path: <linux-kernel+bounces-256838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C231937110
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 01:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9DC61F212D3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 23:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D4A146A63;
	Thu, 18 Jul 2024 23:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fx34Mh2s"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4D6146599
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 23:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721344831; cv=fail; b=rUsG2SDUweLhHwFaBVJmuvKJ1OlX4mvmqh29OiBl5VdT0DfBJBzHNmTsE7Ofqxlkz6xPNenZs+LjazGi0RLGqSsOsY/yncVbdJH+mAHkrXxFed41OAk1CmpS66spogAe1M46kUXYjDd/kj+cE/qthNFZt385fHg+amVJhIWPqOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721344831; c=relaxed/simple;
	bh=Pg9tgTk9LKnsXGpi5Rxh2oqZtQIuqRiTFCHH9qPEfZA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e5CrqKBsK1YNkSTSdANOF5xpHjxKuT3gxVut+hKOWimnf1Q0MWB6GpmhhqANVMG5QTscLrRGe3oLDLRfLwXIZp+oxf8ry5+PwDGDBSRzomikDQn8BGhduYMGesfxnUFWajc5pXaXQFnU5DKXhlUIhibRhCYuXkdw9kbphAQR/ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fx34Mh2s; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721344829; x=1752880829;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=Pg9tgTk9LKnsXGpi5Rxh2oqZtQIuqRiTFCHH9qPEfZA=;
  b=Fx34Mh2skGJhcpzPyBS6eqD9C1EcpjstN4IqoQc+5eGk4PG4laY/PcGr
   Tc5DnYG2mUltD+ORgrFaFPxKvIQFwUKywiO2EFDFjwGGDseIzF0BClKv7
   NVywfQAA4J0vlWiWJ5o5u820soqVKy8H8A1Thuu+OEjGQxu957JhlQ5ry
   USm/aBdYbcJRINGkR9TxT30WLrmqICGX1gSverN6Qlnj6G18GSvOSewBj
   zUvwBZUbw+h/VL2HtFw6Q9t5lGMKKAohqk96rcZ+Wc9rJPholnuQBAqD+
   Za9iF5vf+lcejFNeLjvc0eZ8z9cqR4zAkpkFRkaBpjniBTKHgA0hHUWr8
   A==;
X-CSE-ConnectionGUID: PNuJSlcRTmWF7WCSG4gDAg==
X-CSE-MsgGUID: XH7M0XYGTumG71BenYFqXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="21844357"
X-IronPort-AV: E=Sophos;i="6.09,219,1716274800"; 
   d="scan'208";a="21844357"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 16:20:28 -0700
X-CSE-ConnectionGUID: vETJEEfaSaGyuHyu6fuuxQ==
X-CSE-MsgGUID: 3DR3KLmJRJOhPKc9kvkLMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,219,1716274800"; 
   d="scan'208";a="55464710"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jul 2024 16:20:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 18 Jul 2024 16:20:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 18 Jul 2024 16:20:25 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 16:20:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBidnvJd1n6M6R0T4XXsZr3CV13CHlOv6xe5IIOwzn4jiNWc8RobqA5tZWxLcgBqtv4Rh8G7t1n8/2GtFtV8D7OQuozNGh4S6S1NhN/Gfds1SM4sxIV69bDDviyrc9e3xtKOowuagcL7SB+9lqzHGJRtOJFomIKLcO6b7Zs1tHWvzn7dKj3ZP5aUhh2g6L1+ApzmXyW6CaphifMvQxg1+vvpCNAHkEzvN3eb3gBMh0StunbOZv/mO3TipHV1eWpe0pggSPZgVa4jyJU78YkG/mqTJ6Z+0J8s+/CH1MVfmGFIyIxFB71WRz+HXWyvJefWfjQFi9uZLuVhJuqyoqwgfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VzanQ4quX2wiPndLKj88/pVDPukwMHnx7YRm4xkxJc=;
 b=vAjfWrOtTC3U0WcJySVhgaXkNr/lDN5UR1X4B+iZhJpMVZ3/yas+EiP7fpq56jyMwkqOOel5w1buPwhcSnvxdhWRxUa0e5TKcvzK09dpe9ak6jRy3/FJBz6sZ4kjJZRPpT+ebuHFVdAVUkxIiv4OcccyQSmszlnXj1cghz9u/7r7KYmcRvwsRkKZYYUrvn8FP16P4jszQyicko+Yw6+Gr86yD0EGJgZJd6WdqihtFeSHDIy6e3U+CpLhdNEXLWSVMu62rMyblpJDGKLrOpGkxY5QMi8QHM8ES1HcCrOPUxLIW0GHkkOROkGd81NFgqo7IvRLBWhGnOIhlxZRiYUxzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 SN7PR11MB6751.namprd11.prod.outlook.com (2603:10b6:806:265::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 23:20:17 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%2]) with mapi id 15.20.7784.013; Thu, 18 Jul 2024
 23:20:17 +0000
Date: Fri, 19 Jul 2024 07:18:48 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, Andrew Morton
	<akpm@linux-foundation.org>, Alex Williamson <alex.williamson@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Al Viro <viro@zeniv.linux.org.uk>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "Kirill A .
 Shutemov" <kirill@shutemov.name>, "x86@kernel.org" <x86@kernel.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Pei Li <peili.dev@gmail.com>, "David
 Hildenbrand" <david@redhat.com>, David Wang <00107082@163.com>, Bert
 Karwatzki <spasswolf@web.de>, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] mm/x86/pat: Only untrack the pfn range if unmap region
Message-ID: <Zpmi2JWirNDiJz+7@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20240712144244.3090089-1-peterx@redhat.com>
 <ZpTLCscCFGtsrEjC@yzhao56-desk>
 <ZpUyZ9bH1-f5y5XG@x1n>
 <ZpY5uU2NyOoMVu5A@yzhao56-desk>
 <ZpbDnoQxGubegtu-@x1n>
 <Zpcgmk6wexTKVv2E@yzhao56-desk>
 <ZpfR_L9wtuXhtSGk@x1n>
 <Zph051h5BsSFMpR6@yzhao56-desk.sh.intel.com>
 <ZpkglfpbHH7lQSft@x1n>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZpkglfpbHH7lQSft@x1n>
X-ClientProxiedBy: SG2PR02CA0125.apcprd02.prod.outlook.com
 (2603:1096:4:188::13) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|SN7PR11MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: bec6ccb7-9a9f-4743-0128-08dca7802f89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t3z/150eBSGzkWRT7JvBP6qHxlyg8ltT9sw2iUOa0rqRAPPqZ3ygXFP9baKm?=
 =?us-ascii?Q?1ZL0ho7XHtdwuuDYo+afGmrmqOZsb+L7ajqgkdkBB4xSl7THtgC2k+j4lwmX?=
 =?us-ascii?Q?vpdhjagUAon1qHsqijErXSE2BHL3RO9BJR4J5Zxwgr4q0t1fAHm20BcJDU+d?=
 =?us-ascii?Q?nt0xpQXT6PKwDq5CnWO+Xyb5wMfOvhObZzMYCYg+U3cDNIF7RCxxvUpmXKV7?=
 =?us-ascii?Q?gNTpk+JmNx0Puf+HwG2RHL8zpoo/HNrOfpLURpQ48V50rFIqyIR3Co2U4xZw?=
 =?us-ascii?Q?hT8vCIGa8RxYzyS5Yty3UCrPDz49/I6RQHPHm8k2lu7QF5XrE9EZruGTL0eX?=
 =?us-ascii?Q?0KMRLiUDgyv42kO53Xv7WYr/SpeGtIJtltgWo/mhYrnGqqwdM7FdYYJ/EdIr?=
 =?us-ascii?Q?2DZY9Z4QqJL3lPoNN88sW7Lr4ioNK+C+loV3XE9YQ6YcTaD0lhHOHRkb0U05?=
 =?us-ascii?Q?Cmd5O1dOarGhdee7AhLGS3tRvnCLZVFL1997n1VkmfY3r5Ng/hrXppnQRZQP?=
 =?us-ascii?Q?bQ/Syaqb5c0PQMCN0ZYEsO9lTj9p3eJqt91aeurpb6tA2IAJlGaku10xg2WL?=
 =?us-ascii?Q?61NNAaYn8fHPbSxa0u2slWZZfPCAm0VVtLHGTRj/uh+5Zdb9ezY8z51tEmlb?=
 =?us-ascii?Q?/hoJC/xeze1vPZkvvoS/X9PPWqPy+EWhGnl7VdG4K4Uq7vEJ/siBeW7KbixB?=
 =?us-ascii?Q?Q0UREa3RqnwtT6niKdlYZUgLmDq2ir1V4HA667Tpe516Go0lwbtzr18HGaCk?=
 =?us-ascii?Q?ujd95/GbaPmuY3hXozgRJ/2knjaYH2TUI4karcTqXiBE7BQStAv00XDm0l9y?=
 =?us-ascii?Q?3mtoPM+CZ1jDtbZ6/yDtQ/s9HPMxKBCHSFBzzKpBO1+v9Z7W3wCtzkrMsgm6?=
 =?us-ascii?Q?7/f83heEHCA2KKEZ1kRfL3i4ILNak27bia2OztEhmjwyL1ugXA0NvOuufQUl?=
 =?us-ascii?Q?r4JFOQhOaj99W67LgCYTtK26Xgbqoz+975URo9yUXnoF6jVeLWaGACRXI9bf?=
 =?us-ascii?Q?A8Fr8pWb4ktZI+UQz6hbh6BTZPUVgGBeXVOu7YoDDcTJXjiAWbNpKGOkO0xW?=
 =?us-ascii?Q?BrZeZPqhJPmsTvpB5t2nwBHMTW/9rrntS6jdqUKY+1SEpTHybEGsNQy9A+ml?=
 =?us-ascii?Q?yh5DcdGqpNafngYXXd/zJawxhTrfu0t/qz3LdvxAluw6ui5zFGX1iVJXCj5D?=
 =?us-ascii?Q?3S0Qp2UJfHfTJvEjKGYI/lTvee5FgYL1s9LUgM4xZrO/vmhkrFRGgxZYEh98?=
 =?us-ascii?Q?nYkBLWdIlIn6/Eysgqi0/MzlnHqq3GiHW03aB02f6qHrwi03BDitTKyQ/T1g?=
 =?us-ascii?Q?/lBJ02CX2OARaZPUtL3i9LA6AdtxjEhgpH/KXGBc9g8zzA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tlnzgDJmusIw4CHp76Pk5Ombyys0Q2wv3L3bEHrZ9+CpTJq12GnHvq/sSX3T?=
 =?us-ascii?Q?2kr5KD+5xUJPwnJwRaZg59E3ayYJmcQQfYH+Ku0PfIBE4dnACjWHOZ6z0Ytc?=
 =?us-ascii?Q?e0msmBJvpu8/f+KxAh5nH0HfwXMF6w/olsotkqCxKTw1ymq+eM+jTpkX4Dyn?=
 =?us-ascii?Q?qq2xIxEPyQK4T3jQ2KdCZzSFSeMIkVNHI/11w8N4C5GMPUo9ivYffb3/+xDR?=
 =?us-ascii?Q?shGvCioWUrorcfBpq13MH6yP2y9N+/YP5hSUwgRrFdF8tPcQxXpICbmsPHo8?=
 =?us-ascii?Q?BvSb4jJ0LHK2wQnV1vySczLpAMbgS0eU2eDrgUOq6NZY3lblriL0JAS2Dzfg?=
 =?us-ascii?Q?PeW+0nKHAix3AUXZMJnRtBOYgGozTiKqh5mcpSOryRlM4aLSC/gkBTulP9F2?=
 =?us-ascii?Q?bdatScd0+pjd+bViS3YTunA/xu5/cHK58uSpCHi4X9SSBHeGfT9HElnJ83KL?=
 =?us-ascii?Q?pQ21xjCSiaqQh0DO7b36AaRSVWfKJPEICJBYzYHqdfb18sHaIGUZflmIFhNL?=
 =?us-ascii?Q?bRmd1is3IPyITtHRzEKEOjYksmkDobQ+qLRU2W8cTdHOM8UP7t43bJcjYuhB?=
 =?us-ascii?Q?QNUiyQlQjM54g0VnTv4ksBmlw8vlElVuF1Nx0EznSJlzEYfUNx2ATbiDoX8u?=
 =?us-ascii?Q?SxVu4nAjj/zj6IGUes5DHIClbWwFXAEo+8fr5/dPw3ufY2tXAoGSnMimrh2x?=
 =?us-ascii?Q?7cVq39TZDhDQJpNd7k51CVRJzMp16+86nWJaxQAz/SyCUEf6MDJPUpiSru+l?=
 =?us-ascii?Q?LptxFPaQoYUMkB5mFCehUYyr9bTpv0xThxnGW9GZIOFqZRSBt2JMEI/7cv1p?=
 =?us-ascii?Q?gRtiIUqxPp4lyWBGDYfYFpMV0q7fj0K3T9tYuaUjzWCMjSVFkdQFr1I/IMTo?=
 =?us-ascii?Q?oo5d0IWEax2h0878AA0fOGzfmafcACle0EnVNiyejSffbpgO2uvRw46lgLtm?=
 =?us-ascii?Q?zwSD7TCM3GKzyRpHNproVBrXH7+WL65PjcoCAkwkVTfAnIgl5ImAMptUEpVC?=
 =?us-ascii?Q?P5YhfBA8grw3G0NdH41GSh3KBBViLnnfrDXHYd3idLhYpl+IYqqNpksa3Ph0?=
 =?us-ascii?Q?VXcks0MjFGWHRzunwkMWRPeW1kQvkG7BrfZUiNbq3VjI/Qwk6/yHU/ax299z?=
 =?us-ascii?Q?fB0tAm7ka/keWDylIiP7WMDfbuZKHrDmqVYed0kzHjF5eneXFJ8qoNYd0VyX?=
 =?us-ascii?Q?JREl52mIDyVFLcrBzlikgLzJyU/u7vwdQyS6WJVsnTY4Gotb+nsrz4Msl7IW?=
 =?us-ascii?Q?us2UP4Vm8fhdtsFKk0vEiFBpacvvZL/rsocTlaheBYp6pnBqW24ByhrNUYyF?=
 =?us-ascii?Q?jfNLh/mD8Wj6uvhHihu3UO5+cUoIhYRQBUkOV+b+aHd2STg4QdfoNbVtAdNA?=
 =?us-ascii?Q?r/eBZ+wvCoj3gTkppNWcvvPWVRFc/mJRz4DfM1SliG3RBP8SsRaQvizBdlHm?=
 =?us-ascii?Q?yTEumLI4XjQkqPdVEUotyqlbSczxcef9RpbcwHYmze9hWc5yWmvmNMxwrdgl?=
 =?us-ascii?Q?mqyA6oFcVKIYrJVrd4P1ozJb1YC8xOnVrOfCCzfHL6FcJni/s2hp+hTLa3kv?=
 =?us-ascii?Q?17nBBBUz5AcC3PZt1x4EQdPJ1gwB7C4/H1Qe2KRf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bec6ccb7-9a9f-4743-0128-08dca7802f89
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 23:20:17.6298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8MlvuWUUoB2KpPvIQH+9Rgaop9/hCLIX1betiJ75wHvqXyOoqkcOrqR1Cow0k6FehnnT00MPGlJEvONUsULcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6751
X-OriginatorOrg: intel.com

On Thu, Jul 18, 2024 at 10:03:01AM -0400, Peter Xu wrote:
> On Thu, Jul 18, 2024 at 09:50:31AM +0800, Yan Zhao wrote:
> > Ok. Then if we have two sets of pfns, then we can
> > 1. Call remap_pfn_range() in mmap() for pfn set 1.
> 
> I don't think this will work..  At least from the current implementation,
> remap_pfn_range() will only reserve the memtype if the range covers the
> whole vma.
Hmm, by referring to pfn set 1 and pfn set 2, I mean that they're both
covering the entire vma, but at different times.

To make it more accurately:

Consider this hypothetical scenario (not the same as what's implemented in
vfio-pci, but seems plausible):

Suppose we have a vma covering only one page, then
(1) Initially, the vma is mapped to pfn1, with remap_pfn_range().
(2) Subsequently, unmap_single_vma() is invoked to unmap the entire VMA.
(3) The driver then maps the entire vma to pfn2 in fault handler

Given this context, my questions are:
1. How can we reserve the memory type for pfn2? Should we call
   track_pfn_remap() in mmap() in advance?
2. How do we untrack the memory type for pfn1 and pfn2, considering they
   belong to the same VMA but mutual exclusively and not concurrently?

Thanks
Yan
> 
> > 2. Export track_pfn_remap() and call track_pfn_remap() in mmap() for pfn
> >    set 2.
> > 3. Unmap and call vmf_insert_pfn() in the fault handler to map pfn set 2.
> 
> IMO this should be the similar case of MMIO being disabled on the bar,
> where we can use track_pfn_remap() to register the whole vma in mmap()
> first. Then in this case if you prefer proactive injection of partial of
> the pfn mappings, one can do that via vmf_insert_pfn*() in mmap() after the
> memtype registered.
> 
> > 
> > However, I'm not sure if we can properly untrack both pfn sets 1 and 2.
> 
> Untrack should so far only happen per-vma, AFAIU, so "set 1+2" need to be
> done together as they belong to the same vma.
> 
> > 
> > By exporting untrack_pfn() too? Or, you'll leave VFIO to use ioremap/iounmap()
> > (or the variants) to reserve memtype by itself?
> 
> Thanks,
> 
> -- 
> Peter Xu
> 

