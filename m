Return-Path: <linux-kernel+bounces-263594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F73193D812
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D87A285A86
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E14617C9F5;
	Fri, 26 Jul 2024 18:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FEK6n8qO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fBT8N1NS"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691C717C211
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722017632; cv=fail; b=BM7klENg2qAKWCIjj4P/Yvpqg/SNOmt5LAQxreDd9K1tvqrgAIYC7ipiw3NROtexjJxFlXYgqxZCBT1S724H4N7BFt3L6AX3BQJklUvXyLSfJaliIsavb/gbAlzzxPxHH/7o70+N1mqtmk8SXjhBaHj/W+yb1Daet3orqyGjmiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722017632; c=relaxed/simple;
	bh=XIGI8GO5h/wLA1SqlLbWvmDqU/jY0M49MvNBbwtzhfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aP0eGfSGDNrOyjhOXfAWfednsvcFxpVZCzS5XvGKIeGE47KxEzgq9TKoas6RbJsL56+uhjfy2SLNANsS7gMgXpC9rh29qmXCRdsM4QANOIr+OUyomBvsDwzf5Xh0lL1ByhlnZTD7+azgJjta8WHpXVzX1GIHsHsTdnA9Tsfj6VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FEK6n8qO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fBT8N1NS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46QHxLFN012543;
	Fri, 26 Jul 2024 18:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=/eK03fMrKgJbE53
	MTZHLTqkifXBCdvTfmFUCUxTYN84=; b=FEK6n8qOQJTDhoE1Oa5b4d/nDr/lheg
	cCZWrE3KkIoZihjQ62tEXfWGmR9UvinqVKPkjS13sfifVVF9tCwPaq2ZlAGfqEJp
	yA60+1lfF85Baj3NkiQrFE+pipoThXSs/WcKl5F2BRKSG0Mv7kfr0nz01qZHwX6a
	ywzX2Dd8XtOqq2HshKCoWFGvPjM/tsTYyzgRqM5jCD3YmOZw47oFQhLjCU7AZ9j9
	PFYRqlX20hwg8W0Urs3ELq6pukLoZ0b2OKuRGofbfGkjSYSELNNIyL49uuiUXWqx
	aOkH/rG7qIhz4q7fSnNgERUg/XLVTr2u8YKL49e+S8OT3kE5x6I5SWw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hft0p3c7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 18:13:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46QH0jFN039027;
	Fri, 26 Jul 2024 18:13:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h29vrr4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 18:13:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUfsFOKyV2aK2xu/RUBkutiAnTtz5xEp+21STtJJuvTfLve+Iid/7EYJdV3N84HjZABRST3aaQf51cJRM5v+mTA8aKDoMScedBWye9G5cFO0EE5Z8StFOvgpc7G20nj7NQv9cmT3cx11ZrCXrsPmwb5L3/gV3WJLiFC5PuRTT/DE01kaM5UMNkuOZijn2+rpKjGSLhcZw+FIH4Y8ILzPzN64W+DJG5BPzqPkbCfIdKbdYKj2IAqcdniS7j2maFhlFj/T6P8Uuy9R85syI2QzCIyS3df0lDWVFSRVQN1GoE5oEeHCF1+Lu8UgXGcchIPbYgwgsXP4ly9booBeDpT9Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/eK03fMrKgJbE53MTZHLTqkifXBCdvTfmFUCUxTYN84=;
 b=B9WddduU1tBcknmrenk5sFlYFN850wsPlbBy6asNIt8a+V8rzGzqfO5bkgk708cAsaQvIMdB91F08yQ6HjWWcrNmNOGcAq5p9YVSUi+b6qTCfdi+lMEtgrPTKV5Eppw4A4cQw9A2HIp+b01UHdtiOTuzOrAJhfHNrwlHrNdCuIzM8fmLqYx+Y7euoGZEXp9sF9tC3GYfIdQgvcCfCqdRkmw0XXatiOQi8BmZIWf9hnppX0nN6TUSk0I1atpV1dzX7hpomd059RH5leHxGSCxQdnufPZWwe8h+G1cahQN4R2yh7s/Ah8JiQP0Tx3KAeefA0gI6tNagr+zdxUwWEvg+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eK03fMrKgJbE53MTZHLTqkifXBCdvTfmFUCUxTYN84=;
 b=fBT8N1NS2MWmAhr+PL5NJxnRHdEfB18y3QkXq/X51sY39Yk0cbjcd3t4DqATmh26QY35/fRrOMamm1TsM+UjesJ7gX04vzga8siFQ568oidBaY6KbNIB7xkTvkvA5affP5kXN1JG9Vm0NrNiw28WddsXegBEGKnTQVYDHNplrRs=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SJ1PR10MB5908.namprd10.prod.outlook.com (2603:10b6:a03:489::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 18:12:59 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7784.017; Fri, 26 Jul 2024
 18:12:59 +0000
Date: Fri, 26 Jul 2024 19:12:56 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: David Laight <David.Laight@aculab.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>, "Jason@zx2c4.com" <Jason@zx2c4.com>,
        "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>,
        Mateusz Guzik <mjguzik@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 0/7] minmax: reduce compilation time
Message-ID: <b8722427-cf1e-459f-8bad-04f89fb5ffc6@lucifer.local>
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
 <902a9bf3-9404-44e8-9063-03da3168146a@lucifer.local>
 <CAHk-=wjCV+RmhWjh2Dsdki6FfqZDkM9JMQ=Qw9zGmGQD=ir6cw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjCV+RmhWjh2Dsdki6FfqZDkM9JMQ=Qw9zGmGQD=ir6cw@mail.gmail.com>
X-ClientProxiedBy: LO4P302CA0013.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::20) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SJ1PR10MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: ec394c7b-70e3-4f3a-13de-08dcad9e950e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ob/cetip5wwtbd4OMSRDixWCiqIffeSqWhw0AJYFCkEvsNY5n41mxGqahFtf?=
 =?us-ascii?Q?7oGYnb114CtHq/UPr5wdvlLd/+hrSevBMRBUb0wUjKFI1gGOlgV9S1GooICM?=
 =?us-ascii?Q?ZEbwzuGAEXOEXyMrjRhjdGUESeBlOaBpglG4IaZbSGw7T24eF7b95gkCsHaA?=
 =?us-ascii?Q?bpa1E10aNQfe+PN3daqhvIDv2P+cJYR7u5jH/Uw3S+DiHjLbGcJnhOzoLAz5?=
 =?us-ascii?Q?ZARbwMRyr0MUbJZASGs6abGZi4GC9r4H52CCYsme454bGP1rTGCf4WXR1bec?=
 =?us-ascii?Q?ijPeLI7LzrgYfRutkp4ng1wW/TIk3zdAu0M3JVxoHSQpWa3JEEcbDN9O/fcY?=
 =?us-ascii?Q?96dFCQPL2mf/LRRSYnbqCSGPZkHVepJitqQneui5kLoFDk6H/3DnXcuTu11E?=
 =?us-ascii?Q?xg2bD/x+D0qfFbkOoqQ/S+sQxb/kRqnMrOy28eV04Xvq/ibeX8yNvxGC0r+O?=
 =?us-ascii?Q?LrybfgR3oRcbs3wGsZ9EA8kPNrQHcc/ioOKZ6VMfHEOOSaPOVH3xY6vRt+86?=
 =?us-ascii?Q?xkvQA3SRbuWIV94B3OVLDg3DitcButXOvytQBtQuqDQPAMrSZj6YfVNJZq1C?=
 =?us-ascii?Q?Osqi81TjnaKFO0HL7inS2vIfOWBWKmuzYajl6eMtDrOuRgeQjSYjytJh2bUe?=
 =?us-ascii?Q?G4q3WDtvo6UEi6tjc0mnLfI9IE3yVFu+IxXZzJDLrRiY09/CKRHv3dXCBsdl?=
 =?us-ascii?Q?7+BKXWLlT/P1GtlyK/YeNxFkwerZvgE+6QJmTRWaAY5FXR6ZfdSPCxmAG5z9?=
 =?us-ascii?Q?mH2E64dDJcqVb39sgjT9ggemwVv7ru4OwgFfWs2TDNSEB6sWE8OCh8ZFJDwR?=
 =?us-ascii?Q?p27DgyLpdEeGajgHlppE92ZEwFrY3TDe/9jn+qMoQncKlNTXgBTJ+7ixiwc7?=
 =?us-ascii?Q?cOTvNM6NgxvPEjDXvnh+IXdqFkDC9zYerjdy5lyLBjPeYLzvP/RElrsj4fJq?=
 =?us-ascii?Q?Qu+BHdtF1Kg/y9ZGO2iE0gWjOW9WyFB53V6yA/9DPcC6UZSOhrp+eHDQmcU3?=
 =?us-ascii?Q?OjzDNrS5qdDatePBeioYzUy0rWk4sfIdonrTAsr8DKR8NqTDkxhW//Qx0GTy?=
 =?us-ascii?Q?oWyAMUMs2QzkxjTbHLAdFM8uHdQE7JpNbBmZ9GX8pC+HNf9zyTDgrPUz83UA?=
 =?us-ascii?Q?4n5y9t15DuFPZcihyK4lYHWGst3gFUYhfjJR/Z2BGD6+crV3iQW8SmY4WVWv?=
 =?us-ascii?Q?hWwgl28BZsfZuFcVaUzd4MaQvgyHs2bjDzPCL8Ownlk7KxKcMiMIbXGy4+Vu?=
 =?us-ascii?Q?2HaaTR0MYVkPT0LQOMkPy+aDu4kwiWwwJrxLlsbmQLB1WeoChksFmlzaER0M?=
 =?us-ascii?Q?KY0L+sOT5kAzRzIGNdZj0+VEundnMRfXYg7P3eZ9Ws7Zuw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Qt+WMqnvomcN3/MtzWdFyHHpTS5phoFtb94QIHMCFDpkxfsyEBLVjUcgdFz?=
 =?us-ascii?Q?QmYOEupAe65o/65GzMG/YdX/uELyT84ilPiURK2DPg+up/zqUr3KLqOknnRr?=
 =?us-ascii?Q?hpuYoRZgz3hz6wLhvT+w7CIS4cpwQqwC5ELhHY6K59fqkSnopWA5iQz9xZQF?=
 =?us-ascii?Q?CfI+rIAEjtwcTPv1z9biRNm3HFNTs7qzMsN9Du1AQKj2SWG+QhYsUZpY0LYw?=
 =?us-ascii?Q?ixljCkxONo/x1z0ANmVL+6YX+I+OIroPfXvXfaJsNdk5aK34RR/ARGINr4SV?=
 =?us-ascii?Q?5Tf5ey/1t9fCQKK8E5Phh85QjEciaghwYc83n0ep+9l28ygmLzDxO9NuhFuf?=
 =?us-ascii?Q?ISFIpT01DvSM9guMQ5pcAk4zItII+P9Mjp0V2+TWvDcej+fnCp+KfQOBU9Y+?=
 =?us-ascii?Q?ehuqW2TJDDI/4S0dBn8ctgn7cAOudpS/Z6RJD1/EnTZYbUoPIlGFfbUWAQWO?=
 =?us-ascii?Q?DVThdFtIxh/h+0S8q/xzl0ugyoagt18LNvlVeGxX8cdIi0V6ik5C5kb6gYci?=
 =?us-ascii?Q?jFcRz146kcTmadmPjcEb50i6tHWaOLhCp53/ICNjZoiigx7ChvYPHqtJDmU/?=
 =?us-ascii?Q?QGOcWxuXQEeiuSB2Oa0qPasEniMRItQ4UZ9NPOz95WJWH3CZYlHM0/4Q0aM0?=
 =?us-ascii?Q?oJLbMojiP+0aAYTglapQ6xJfk9Q5PrVU/7vLpUd35WCunlpAbjKOqOsEUvl0?=
 =?us-ascii?Q?2sSmUMcGo/IW61bl3fRVc9Ms9KwFgaf7ZWHrTckRg57sxZi/97o4bOC9qlEo?=
 =?us-ascii?Q?yIWwPv3R3191QVAbcUWdzfhVNIY6fCSqobuIjGrHJpXa0Q/5d9+oc73vUstN?=
 =?us-ascii?Q?Nhe2F+1MGt0YMHzrk6WDNRT3XDgAwyBh/sU8zfLe1ywkwyQvlMxajcoJV+ma?=
 =?us-ascii?Q?+FNqCFuAbeNmRRTzdODOV3Xi9Dk1f6wfQaPLrTx7lgl33Lb7cKVlhz+ah8RL?=
 =?us-ascii?Q?LZP0Fr64ayV6aak+7k03hKSWB6u7LUzDlpVmkcmK0UUfBWHLPfvF62QmVb9u?=
 =?us-ascii?Q?ubRhATl/ypjN7iUYsUYyI9MtkcrqPxYxHa59uTFhgovJQJS4aUXHP0FXI+Gn?=
 =?us-ascii?Q?p3i6q2YV4SzpAPBMyS3RKcBSQuu6FTwM6P8EOAAw6WNFHnG08/igBXft1WHz?=
 =?us-ascii?Q?ZnWzTDdTxkpvXWfYO1T7sxlo4JhzFNDo8vKrQKDGFEhE90PnxLA4NMi4Q5MV?=
 =?us-ascii?Q?1np0T1Y2dqmdnWhKwNcs8klOsPekZH7h1+xFw7RG3ZScZ7SNW/XPYPpOX79A?=
 =?us-ascii?Q?UDLJsNJa6wlovkNd+P3epJ0P+aqNGirCRjs2KeJIdA3mpexRlcGprHGdNeKE?=
 =?us-ascii?Q?d6TnS7OR0AseSlfu3ed6DJfsAgEfMfhAV0hnRSYUY0gH1UJ1nH4UiUd574mj?=
 =?us-ascii?Q?V4nL+zZGkTIDE/0J4vK6rxpCf7+gFI/NYysvOP7BIsvbcZfTu4I5AtIuAWe0?=
 =?us-ascii?Q?fncRHeGeOmGsgeEEWeVq/ENGeG6DjPpPmvqoA9+JgqjBHfnvT1o22CY0emTM?=
 =?us-ascii?Q?fFJDjPolWG4P8kDZ2MlI1nh9fCgL8SFg5oDBlPJIADkjrrZHOVZOBh8P9ror?=
 =?us-ascii?Q?YXWV2KNZcmFbxj6LHKWaXKuz/hVEQX+YvQaHFvomQxZzIFkYAcusFgLunWQy?=
 =?us-ascii?Q?gHD4R6UMrEhgsy5LpJWCe2SowJ3ZSQ6hPm+5vrDcGRKNTNyBaR4j77B7HKBQ?=
 =?us-ascii?Q?QwicwQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UEoqSMVfcTC7UkBxCYCMBA4ViMoHD779IzjopjXFTJebCxJntZz+DYzNhg+fJMhQmjv91U3Cq3uvX2ZZ8PkOSRGiyB+hQh9OnfZ7hScG37Y3nDX0Z7gFxxgB70S+u2xF1y2IMbEoCUmLsJcJ+GkMg3EIvo+QvO5p+R/7Y7H+2nyYp4Fy12sscRwAEpyzRqlQJE4Z7YzzT5JhEpU5M57oIMbJ3zczDjJWeQ0pGIG7jaBx9ZQ27TiVDHCxcACczxQl0emhA4j96kQVQ48HoabnqAJzeDvmMZcnLi9G+nXl79ynQZ910xUSayvBVuOSu3wTFR+f76B2P7zKfGkl0oo2OpxF/VN8Bg0HshsmP9K2pEIN0JUtBqY/ysCzdwEawuRQcbWfMy9GKNZiQz15wD2YESvlv/Or22HmDbf4HTq15PFoLdwLrtxua++/tyzaTtU5ZTZUDqgCnNqEf4/jV6XjLbA4YJJxdah+aPEfP7nkVLxkUFBe6hqLM2G0Nblj558MTEdx9WiPnjgXXeNBoqC2dxhgJ3oYhR2XbbcVrDwkapGjNME20t3NGKvOh7g4d9cfBhEhG/slPLtrqzrmIBmVVNLBbzZBftYfytwr3SrTdeU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec394c7b-70e3-4f3a-13de-08dcad9e950e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 18:12:59.8217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHC84bc8R0ZAGduynLEJL7COX0R1HVrf1YWyVWuzULYd+0D7JrU5K9bsvPr7hEc2Yuq9pkPuntJbX47mPs8dAC8TEeowVrONjzTh2vgygTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_12,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=996 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407260123
X-Proofpoint-GUID: QHazw8oc4G3Bv4ZZMYxbfsM5X9nWMQVp
X-Proofpoint-ORIG-GUID: QHazw8oc4G3Bv4ZZMYxbfsM5X9nWMQVp

On Wed, Jul 24, 2024 at 12:52:13PM GMT, Linus Torvalds wrote:
> On Wed, 24 Jul 2024 at 12:35, Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > My rough numbers below, on a 32-core intel i9-14900KF box using defconfig +
> > a small number of debug flags I use for compiler development:
>
> Side note: I think better than "time it" would be to simply generate
> all the pre-processor files, and look at the size.
>
> Because to a very close approximation, all the overhead from these
> things comes from the deep macro expansions.
>
> And unlike timings, the pre-processor size is going to be (a) entirely
> repeatable, and (b) will also perhaps point out other worst-case
> scenarios. IOW, maybe there is something else that looks like that
> "min3()" horror, that can be more surgically fixed.
>
>                  Linus

Agreed, have generated these numbers:

## CONFIG_XEN not set

### Not Reverted

8,413,999,318 bytes

### With Laight's patch series applied

8,237,750,156 bytes (~2.1% improvement)

### Reverted

8,157,201,494 bytes (~3.1% improvement)

## CONFIG_XEN set

### Not Reverted

9,006,361,868 bytes

51,407,944	./arch/x86/xen/setup.o.pre

### With Laight's patch series applied

8,781,003,140 bytes (~2.5% improvement)

4,819,999	./arch/x86/xen/setup.o.pre (!)

### Reverted

8,699,892,262 bytes (~3.4% improvement)

5,447,539	./arch/x86/xen/setup.o.pre

