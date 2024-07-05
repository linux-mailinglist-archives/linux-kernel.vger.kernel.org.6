Return-Path: <linux-kernel+bounces-242803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E950C928D5B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 20:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10CE1C214CF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 18:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7658516C861;
	Fri,  5 Jul 2024 18:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AZs9UXND";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d0MCerFV"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4596113CFA8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 18:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720203151; cv=fail; b=FmEsc5L/x/d+k3VIyXRKDxw+lB9IvLNReEHdgcq5NiAjDzuelkxYbTSTTFzdwQK+2um+/WKbKslt+P/pNbP2iyb2rS53PRVHLUe4FnOL1ezfLqJdIDCZMarNfmaeml5V7AVfkd132N5H4QokSPrtibF0sptf7+plBqPrt7WtDxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720203151; c=relaxed/simple;
	bh=/sbIu9G4Ze1hSm6LfWzvljeSBHDPYRFXLRiQTLoUSMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MiQ/7p+vbLRhQAKupEG1MhvFyUMgsgmmMdJ6ghpgD6wFrqDAWZODDYvotMl4oDxMHMT8zXj/xM79A3lkGZzktxstnCiyrJOfrD2vapU3AorxAzjY/QG9Dd5o98eQVuOGWPGq+lY2u5jS0mq7VFj+ddSbDi7Ztgbk7V/K9Xb6H1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AZs9UXND; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d0MCerFV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465GMUJS024956;
	Fri, 5 Jul 2024 18:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=8MY6mJ+7vRLVIKK
	Owo3pUrT284QEpjgFNNZza9uzgk8=; b=AZs9UXNDZt5gYcG2QpRiAgsMVtTwpYS
	RZ4o0lEyWAr5em5pVgrYrTSE11mdiZUct0h4mp/U+O9LMascggEfvVgsVa6N/TiY
	+C6fSq+bvqV+I3Y8eGYYvGbvFJPjeaeDYGX443fP8ORfVlxeymDY+kHPSqWyaURt
	ozyOkK77WhvLzh5qH++SkreZWQfgXegC9Vj32f4lLLs71z5Qn7EulEd/I1AYDmK1
	vU9KA4VOQ6IjAqfUk7c0Ayv9BHuezP47QXP1bkC8LDS8E9ikXee9w6Sj8jktJcVA
	Gpz9ugBaV/QT/u1YYUycndhxQRqeZgRyIXXIbrKmXc7dnl4x4s5Qxmw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4029vsv8ex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 18:12:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465FgtcQ021566;
	Fri, 5 Jul 2024 18:12:12 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qhpqwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 18:12:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTT22TmS+8W4OBn4wAPltez73wN3g6xwipG2BklWH1JYjBorZNMaM3gPa60dckGCdr9n/puTJ/DJHJa0iWi3UOzbBJkKfVi1ncrl2hHNdxCUeZ5+ziNKUQmoH/M6aSX/WC9cNkTq8WWmN0I7Xzgs3BjLUxpNQEpDJBFzKCxjqIUg1QLk1Kfp33xL2+253Zv4+mJOW3h/f5HtZ6VcXJ8W2f4iiS+q8aC8wkfNtjU2NHR/XKop/t/cdblGOpV2aCyZEWwtxK/Yc9Iyks3FsFKadQw5ybAsDg/Wf4n+9y9NrZQgMa2Xw54Nt2MxDerUCDW0xXD/gxG3FwyRmBO+tskhXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MY6mJ+7vRLVIKKOwo3pUrT284QEpjgFNNZza9uzgk8=;
 b=Zt+oqYLxQjuCVubXARTKs0uwPDFyAFl3P/KCVLHlGT7LKaohuonhgE81D4B6My5FiC66nmCqmJS+5SdDYZn7Ca9MynZr6iLY65i9+NMGIphQwXzYIw6dx3p9MWHJHuB7M9VciZNNHzD0lbpqyCbhmR1n/NF+Fip+hZ87F95xZKJmwwle2eHTzXB1XFTeOqpko1SScX2NTircmQqwvspX8EFx55nlvWSL3j8mEgovcc97BP/yDg0exluljReqfHnf4wnBMOMVNpHhgBu7MDqDuQoQwjWvx14sT2O6ZAF9x5UBi3vBjcM/IQcJLt5ZRlgB4Rmrik8g37AeFQDwRrSPyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MY6mJ+7vRLVIKKOwo3pUrT284QEpjgFNNZza9uzgk8=;
 b=d0MCerFV6A6G0jpo2ZIpyaLaXXmEqPd1f0GrO3kOVk244Jv8MLgNb9k1kSdJvzhPopD0AK8XGJOVWGZGY3Pux53kNEz2fwevDMN6FDgiH3ZKxNx3yQHXhEAhac0hj5qdvRd8yhkpVqgCo+KYJh2P+iZTcWSoHHbaoPMFcoKUITQ=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DM4PR10MB6255.namprd10.prod.outlook.com (2603:10b6:8:8e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Fri, 5 Jul
 2024 18:12:09 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 18:12:09 +0000
Date: Fri, 5 Jul 2024 14:12:07 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        sidhartha.kumar@oracle.com, "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 02/16] mm/mmap: Introduce abort_munmap_vmas()
Message-ID: <fftle4xpq4vqskgf4tdlczs3wnlzdoj4obhmmsj4wlc6sylo7i@xzeyqg5kvxsk>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, 
	Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-3-Liam.Howlett@oracle.com>
 <f9b7c816-b0a4-4e9c-a5c6-0cc5990e56d2@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9b7c816-b0a4-4e9c-a5c6-0cc5990e56d2@lucifer.local>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::12) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DM4PR10MB6255:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bcf45d0-af39-4582-e0fb-08dc9d1dfc86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?S4yW2fn/nVWklYX4izCdiz0cx/L+EOyq248YrdYFHiEcFwa98ytuiyQLm4kb?=
 =?us-ascii?Q?auY9taQFokOB/63E136eUNBSW1ukc0+sE04SlKf69OI3qDFgCT9uClx9u+u8?=
 =?us-ascii?Q?C88tqPyFxN6JVx8vzuDDXFCcRiC3qOTZtI/SO3/3aU8fvpFiMGtXTtkKWx4B?=
 =?us-ascii?Q?HkwfINmPnDW9vkB6mH1eK/NNqrYUhgOJtfRSUvWqeWBJno32Vyxqmpj4nyQx?=
 =?us-ascii?Q?wwPDFMU3A3EldDvuwsYVNYkKYL3u9BZgfaYuyecxmOOpgeY2zzOjbNbjHwOz?=
 =?us-ascii?Q?W9ia6U7xbMK+Al+EYaFjZ/7vPnbT6QWwr0hRYZChzDxsW6Bp1FTE5jEwaXL8?=
 =?us-ascii?Q?HLuqMrFbFfTKxW8dmCNQs6q/z0A8dNTeMFwDf8fkXHO6KrrDCXFKV8xHGTeu?=
 =?us-ascii?Q?cG+dB5uD9nY0uLasEPEKNrMf0l5cpD314/OHVgC7pkMZGt57UzDtc9+oj3uv?=
 =?us-ascii?Q?mCqdesmurHJKmsyUZnGwY2UfRxb0Ho2zLGKEiuLGTKpZsnK3y7E9JFSnnrHn?=
 =?us-ascii?Q?hr1HaJXF+eZYPlKnQcEQjrZ1EbMMVmvF8DZLO4HXEIdUk1IBx9uRyRJAih+A?=
 =?us-ascii?Q?xwUo/ms87PCJRX5mvNPDRzU4ZZRJljvSXF1uPcJxBS4vG/tMcED6qeWpboKY?=
 =?us-ascii?Q?7l9DcxsuQPcyO9JsIaW2fmj6eC913Hx2MaDZPI9ExSp3rJCFFcT8Vf9qgi/C?=
 =?us-ascii?Q?r15VyV4HqD9c3JfRZTe4lKsMEQtPusUOi8XrP2jZFZzFORbQ0czgNkz5blVy?=
 =?us-ascii?Q?XlrDnN1PT962vCwKDLFpHDOEKg/i2s+6sXqTA5Jz3JhM1IUDBzk/YqBY4xIo?=
 =?us-ascii?Q?7GNjbLJ94CCs3MitlcnOilqtFcRYiRs6nSNEa11378F53DRVtF5Ynb8LFg4Q?=
 =?us-ascii?Q?bszMaeci8BknHHninNsKRPg7htQcjwtHURvo+S4r5wM7Yy+TBrh0U9r0DSpF?=
 =?us-ascii?Q?D2+fy3V1V9NhuenGyGsA5aVSOqppGaDDaGuZU05Yt2CueofWDI0Tz77cxX8b?=
 =?us-ascii?Q?88Enaf63FtM4hpo7lS2h3eB85V2g9rgwvRkOtvvvSy4M6BP28WpEqrw1fn4t?=
 =?us-ascii?Q?vkp+HiOUeHbsXET1KSx97e3eUvRV11c87i0Nhf5xfehLWwbh8jI39qlZi8kO?=
 =?us-ascii?Q?9R+F3IAqXRBJpU/GPKpCQkQ/7iE5iYj+OMxqoKdT+QsT5zvaGI/uwPtCfZFv?=
 =?us-ascii?Q?aaiOPUexL2FZCs4Q1KwILVH9h5yDmXUqrx5vfQwKzf5PaSQZP9O7f0Q/Rbh8?=
 =?us-ascii?Q?laW12IEyiRViOXYBHkqK3JJTRhrmm1qGIpA29L+oO0GfhEsc+dQFTzfQSeKg?=
 =?us-ascii?Q?d+JvSgFMNmwsntxXWaYooucl3PHToSKSeHoGo9BkQXfiQg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VxIC7iP6XHYt/XBBeLVjDuUtQCQ/+iE4ggqYTxnyexReR/DAAsEFFQSHlGT+?=
 =?us-ascii?Q?zgBmaKBKcoS1k2Z524aezW9LQZSiFu2jdM2iuRSJnqqTvsTLfB0Hjj48j30N?=
 =?us-ascii?Q?712Lf7yU1IxUfScZnYqxXSXH3q3No4JapGkfVMMY7JZ/lyRwNRCfXiP9PNML?=
 =?us-ascii?Q?m4WozTGrKvPx4DtNmFnB6ibQ2HC5CzgOZ/Sx3HgpfPBPqlGg611W4PpdsRZg?=
 =?us-ascii?Q?uh9WO2ds3lRgKxw/wpZ+2WHvuWiAkPxx/H2A74JmzPaVKq2Oop6ReU6m0Xo+?=
 =?us-ascii?Q?NJdDTvV4jrMXbVtqtQlH5OlYKJew35H050kpfGj0esA/lYCed62WYtHcKnux?=
 =?us-ascii?Q?lhVo/VqoNy6cEFKW8ICBoAjC9CBS5tXlMzK/k5olgX5A4ZDt+HkQV7iTep9e?=
 =?us-ascii?Q?zXvFjzPVmtgKi7qVCmY8tx1ecHN4dFdh4TEyrhtlRqAdUReYL9t5ikAw5oVY?=
 =?us-ascii?Q?ifGymglhRDTQbFhPsUsTRZyybMv0R+87CmePQZZ4GuvY+dv266qkm06Erz5a?=
 =?us-ascii?Q?WpptRnDZekr8rl+PodomG4RypRHA68dbfQhGGMFnrtFiCjAX/VpiUA7KZUDW?=
 =?us-ascii?Q?KvutV15PPC0maYmdJGJvs2VzbFxHKfdSixrgq80qNNgNJfr+bRInxnb0+TtZ?=
 =?us-ascii?Q?XwGcYNBvRkqiQ6vrSl6qN8i1i7LU1Q9f5pnhQ7A6MQdsK9Trt7Cs2aPe7od7?=
 =?us-ascii?Q?5iZKZuOCaiZEYKUrjV/l6CB7LhxT3aUQURfCFCABYTRudw2myXUfI7AdpxQL?=
 =?us-ascii?Q?xuFhOfkcjk924ogiKEWeOgZ9eXYQMzP2CQYQhaKxw0ZK9ovW25kNrbvDyjt2?=
 =?us-ascii?Q?dFynOJo7vBeheJWJSiOKSOr7KAy36aqI/0GWNeAZfRwqHilRuy9tLLw62bCr?=
 =?us-ascii?Q?6nOY9TXoydHvM7v/Fl+fUDZ+K9uHP9M4SnuiUggjYvVGo9cikKzW4Fx7kven?=
 =?us-ascii?Q?a/gxIR+be5VaRJMtrJfz3s1VGserwRgAXJ1Q2knQRP5yKe4+Zb7hQ5WtzujQ?=
 =?us-ascii?Q?oaKmjmhteRBWRYMJOubWY4eivHf5HZhY8hemDRMsA+Xltf7OOemjXobHg+ca?=
 =?us-ascii?Q?i6zAhGO2D5vDXSU5YYyXEtIBkaYC7dxi4qMJBa0aOyYn2/81XyRt2dW1FYbm?=
 =?us-ascii?Q?Qp593zLrVIYXww8nzNqBEyI3FobtUJcQkX4AnrkHfed3tH6aVlqMAYyFsiSO?=
 =?us-ascii?Q?l/xR7iC1YoyY2+R0JKnjiTwrOPsB0SdRj2qw6QXtrR1nh9nkyGaNnUSorW0Q?=
 =?us-ascii?Q?DwrVzl+TZ1TNvIt4iAglQLeNc3VSsbt9rQpnylJ/6j+fkKVBgJfQtNy2hoFj?=
 =?us-ascii?Q?9BC1mURVgQWaU2H4XtDu/igGSPxSY2t/kiRzRYsgJGXKqRZHhNMmoITJKvst?=
 =?us-ascii?Q?eBPGhMv3YQkSLd3+SXzbzplpDNVK5G8C5KHu9PlE1BbM4ARTpZ2aPlmZFV2h?=
 =?us-ascii?Q?OkcGhtnXKAAkR/k2bpoQaRdwRhMwdhtbNVnIKt3Rqjcq3AIeMhFmu9U5jUHY?=
 =?us-ascii?Q?HM3SwG+18wrkOTbqIA0Ym6/EcqSiKe8ofqIbUjZSMPvMFsNXpXQGZ0bmEeP0?=
 =?us-ascii?Q?doAGO0O9VPeU/zIAot/wuEPIxc6rrMSuxH3iLI+L?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pk06C44V/0q8oEzhF/aN4600+zvKCBDGVgdpqpCh2rRp8Ar51GRa2+DtGeosSxretYuGaoxcH0ad67pSOZnq+JUW9zbGxhD+yfP5hDNVuewpVLDjOqrL86DTtVekJLTsP5+pqPS6TP/H9vT3Uuc5kla25ctkok8JeBr/wg55qWWLsnq/5zl8j0pqvwt6kSwILz/ZHCroU/aDEVkPBErj1HO6W+8ja2QFcC9d1oGJm566WFr6H4xhXqdzlveToLf1SV25QsrsMwzgPeFfq83HC6xiB5h/atAyFwA8QbUaB4dhQviiPgr9M8gO73szcoYt60//zYyyMVEsbCfFVxVP1+Vhwg30Sz+Gyht6hxQNZ974k32YVGfJLzNZWm0K/RJ8S97nPegCMWdj+g0ZHc9iMNWb58x56wvmu3hpqCDkmZV3f2Bw0+nYdydGicfvRliaoWAJoRAGa2ju5UqbrPf7w8t5DPTLxn/NIArm5Q16uLsy0QavTvbAc98yKSOjqSgL0Vuu0Dp9+b0ondoZaMImJCoAQlGPw0j5zEjfaOs5miSMnfHyULxhlrYbJJ0+TmKR7Gv8MK5uvxXnHZJvCX7+FMNRVlnnvNVHPU8lnyS9emA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bcf45d0-af39-4582-e0fb-08dc9d1dfc86
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 18:12:09.7837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8uDQH7MnjLaZ4qaf2Rv5xaHr6uhnHG43DmbsazAMxYAI2j9z40ehvJ8QupQ89PRdA5tfjwVvp1U/oIrYp/YZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6255
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_13,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407050132
X-Proofpoint-GUID: 6aK1BeXSpE4hPv_2nx69gcxi1p37Hq-k
X-Proofpoint-ORIG-GUID: 6aK1BeXSpE4hPv_2nx69gcxi1p37Hq-k

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240705 13:02]:
> On Thu, Jul 04, 2024 at 02:27:04PM GMT, Liam R. Howlett wrote:
> > Extract clean up of failed munmap() operations from
> > do_vmi_align_munmap().  This simplifies later patches in the series.
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >  mm/mmap.c | 25 ++++++++++++++++++++-----
> >  1 file changed, 20 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 28a46d9ddde0..d572e1ff8255 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2586,6 +2586,25 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
> >  			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> >  }
> >
> > +/*
> > + * abort_munmap_vmas - Undo any munmap work and free resources
> > + *
> > + * Reattach detached vmas, free up maple tree used to track the vmas.
> > + */
> > +static inline void abort_munmap_vmas(struct ma_state *mas_detach)
> > +{
> > +	struct vm_area_struct *vma;
> > +	int limit;
> > +
> > +	limit = mas_detach->index;
> 
> This feels like a change to existing behaviour actually, I mean a sensible
> one - as you are not just walking the tree start-to-end but rather only
> walking up to the point that it has been populated (assuming I'm not
> missing anything, looks to me like mas_for_each is _inclusive_ on max).

This is not the main tree, but the detached tree.  It only contains the
vmas that are going to be freed (or, rather aborted from being freed).

I see what you mean that the end in the abort code below would be one
beyond the tree walk.  The new abort code uses the index (from the
previous write) as the limit.

All that really matters is that we go to a number high enough to cover
all vmas that were detached.  I used 'end' in the below code because I
knew it would cover all of the vmas added (we actually start at index
0).

The value of 'mas_detach->index' is used in the new code because I knew
that's as far as I had to go, and I could limit the arguments passed
to the function.

I think that I'll actually change limit to ULONG_MAX in another revision
because I like that better than expecting the index to have not been
touched by others.

> 
> Maybe  worth mentioning in commit msg?

Yes, good idea.  Thanks for catching this.

> 
> > +	mas_set(mas_detach, 0);
> > +	/* Re-attach any detached VMAs */
> > +	mas_for_each(mas_detach, vma, limit)
> > +		vma_mark_detached(vma, false);
> > +
> > +	__mt_destroy(mas_detach->tree);
> > +}
> > +
> >  /*
> >   * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
> >   * @vmi: The vma iterator
> > @@ -2740,11 +2759,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  userfaultfd_error:
> >  munmap_gather_failed:
> >  end_split_failed:
> > -	mas_set(&mas_detach, 0);
> > -	mas_for_each(&mas_detach, next, end)
> > -		vma_mark_detached(next, false);
> > -
> > -	__mt_destroy(&mt_detach);
> > +	abort_munmap_vmas(&mas_detach);
> >  start_split_failed:
> >  map_count_exceeded:
> >  	validate_mm(mm);
> > --
> > 2.43.0
> >
> 
> This looks fine though, feel free to add:
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks.


