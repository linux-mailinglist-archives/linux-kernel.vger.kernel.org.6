Return-Path: <linux-kernel+bounces-260269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A7E93A539
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B87C2835BF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A743E158845;
	Tue, 23 Jul 2024 17:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QPKrdkAQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sU6zP6cK"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1768156C5F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 17:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721757579; cv=fail; b=YSEcuIubzuCOQtvGjNhEjZkrshUjDUyIAqo6UwMoOBAIwMsScEu+tYDD/MOP5wfwwdDcF5jrK23DlLcgvXiuNNvC4FSTMwzMJd+gw6P0V+L9ba+oT4Z48r88/4HbFBeZoxLcx0DZ7vgYG/3NqcETtLBjh+P7b+x5MJv1JRRHf5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721757579; c=relaxed/simple;
	bh=2i+VBIpWeuENbYX4qMHJpNI2Uy6TdT9lsrkUC6e/ucU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I1sJr/jO+WAHhAk515Mz2xbTMj6MGZG4Z2cxIA2SEYz+D9GZndp2UvD1rWidBT3cG0tvK8cx7P16n7ZnvfILclR5Jp/2tGeaQQpLK9MPXjc6FLyKOB9nE1GyI1q+iOSSiz2HsWxfy5wxQ82dOVVZ+TxJz/j4rdckeyJvQ9esn5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QPKrdkAQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sU6zP6cK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NGQTLb022868;
	Tue, 23 Jul 2024 17:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=oCqfMqzsNlInPMh
	5iHHKvuPEq8lIdx7kk3lcR2sOeyo=; b=QPKrdkAQMuZ9xUSOFYmReUIAI48cYaG
	OKpKY8dqQkwU5hS2vWkgGNl7yFzfGBCy2lVmmF4WqGz3+LX9yQuhOLbhF1a/x69N
	VYPvGw01l4wWFcbqyHrEpuVeI10kyuxYRLg+fHp76WM1pVrOp2hJ/uyjlHVBnM9K
	0pRFxjN31JqppIPgytUdOFRg5sc8crUJXC85Tgaf2KfR2XE4BbIlPE1/JqxyEnNQ
	3bAH1948ydMXPe2p+Fv85uJzfbsYaAkhkXMCgaNy9iazbpnORNU2VXgd5/ca4Awk
	U+vIsJRmGquPOxrDkSSLlPCBL9c1NZLa1XrR/4XR84oxaDTmFghYfxA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hghcq2h3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 17:58:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46NHq1Mj024602;
	Tue, 23 Jul 2024 17:58:49 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h2a1sq3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 17:58:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cIJp2mQUnc1xBXckViDSL34CqEHVBNtpJWEKtqmHmApWJDSCVM7hRnczNoQpQJy1SDKvm9QV8YfSoROwJBDm6IszcvJuzDo1f89RQ7+ctvIqzqgacYAWCA3S4vzdU2joJks64QbnUM8kUHuJwLMWjz+ao6cpkwkV54tqcWc6naaOcc2zhf3yoH8hkmX10EmJrzFgV7FZKOPyAMryY8G2AjF41D2Hr8ppSyIeqoe2axcb7q56ym97pELQ3WA4uBySZlNsXZp3C5hY0DBxVqr5c9EIduwG280V0wXWKzRAa3YGBKgJwXcIyrE7V0RKVfHOwh6YCFX3NUGsm/H/OQxsGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCqfMqzsNlInPMh5iHHKvuPEq8lIdx7kk3lcR2sOeyo=;
 b=gm3m1Q+k8rbYUX/riqnBaQ3tL64YqdBqG0EfQlTAL5s2mJTEf12LuBAvBVOJ5ewnhdgcFKpTnvTpXxm2dcudFH4AxlEVKsayK5AxylFOBi8BpZ9O6ikZ9SVmcSe4B9LUisNBEQEu6vL9wFDX7GWwnUvmqfU0/HdUumNE8AKNmduTL+MbP+ndeig27y1rCIdPPG4NzNy+GRYjPtxVPaRtmQkPrrK3Kkq8vMtIwGcGmh4f+yDPaxWiGEUSzGUYAqHe359fNU2JJzSbcr11DTpHz/DkTedCu/zym9qadwGHCI7IvVCsuMHchQT6ngWiJ7uY6afYjh25TCLABYi5HZuYeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCqfMqzsNlInPMh5iHHKvuPEq8lIdx7kk3lcR2sOeyo=;
 b=sU6zP6cKN18yirmONLQpNWruJ77iISqi66tSXcVrtd6Pw0SrWPHr5tWTKbycqzUzliYUAMhDytkoOIliVX9Vw4/WH4mqVlBT2SArRj1JnjlCSPER5eCCrD1DJ3lmktQL9qSx0hflhK0Bp5B8ybu8H4WSQUGe9HJ+JL2FiADAdy4=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BY5PR10MB4178.namprd10.prod.outlook.com (2603:10b6:a03:210::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Tue, 23 Jul
 2024 17:58:47 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 17:58:47 +0000
Date: Tue, 23 Jul 2024 13:58:43 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>, x86@kernel.org,
        Yan Zhao <yan.y.zhao@intel.com>, Kevin Tian <kevin.tian@intel.com>,
        Pei Li <peili.dev@gmail.com>, David Wang <00107082@163.com>,
        Bert Karwatzki <spasswolf@web.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] mm/x86/pat: Only untrack the pfn range if unmap region
Message-ID: <xbgdq47laus4mmm5sobkevjdrs2km5virq3gqperutdifuf47l@b7o5qmn7ckfd>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Alex Williamson <alex.williamson@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"Kirill A . Shutemov" <kirill@shutemov.name>, x86@kernel.org, Yan Zhao <yan.y.zhao@intel.com>, 
	Kevin Tian <kevin.tian@intel.com>, Pei Li <peili.dev@gmail.com>, David Wang <00107082@163.com>, 
	Bert Karwatzki <spasswolf@web.de>, Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20240712144244.3090089-1-peterx@redhat.com>
 <t7q4s4rktcjkrtmr7l2zffpthxis5bmafhae7aaxxekyyp75ev@x4dshxdx3jpo>
 <Zp53fnlsJGOmWSRQ@x1n>
 <ox3rg6uyazlaeshxeub5hxv4z4bjai222mkitoduktmar5l3pd@qfxv4jdnj5xo>
 <Zp7MaJ0eosfaZP_3@x1n>
 <50a581c9-0e59-4282-859b-922d02b3870e@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50a581c9-0e59-4282-859b-922d02b3870e@redhat.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0412.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::11) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BY5PR10MB4178:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e107e4a-29a7-4671-b13a-08dcab41196a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?50IHmp1idakCrn1mk35oz+QpaNBdBNEPEKmOjzXtO+dPd1YEP+SKJx/wdOOU?=
 =?us-ascii?Q?0g/v9dKXUMKKktT7c+ikqLQI7tQF+bd4TIFSoxqipIVWkAvVvGcJFl6rgD57?=
 =?us-ascii?Q?F2PA27/OMA197+eggRNI7CxZwCyE/fwqAPU0lcL8iRdfCwH6eNdiFSoFKQCi?=
 =?us-ascii?Q?YZm1NumD+2nRqUqWfzwInSC2vjjO96BX3JGMe3skj4wMnjvf5895OyJ6l9gQ?=
 =?us-ascii?Q?GtrYxHtt6LYF70keHMzyf15K44nacaUeq8edVNGF6L7NrvXykHSf560dmJgu?=
 =?us-ascii?Q?UsG3Y4BSft7MPeOKfwHwVbGGFELTT7rTKG67XeqK3q2p9MoYFcPnmGGD83u6?=
 =?us-ascii?Q?EV8PWak/ytuPZ0K6TNnFn1MlGrC5BBdgv0g8tys41+1orvBLmqITT8VxHsEh?=
 =?us-ascii?Q?nh3zhJomLdisBCiegXiKq9UBY7QmK19ja7jNpQBbwx9l+tON4ulsub2xQa2u?=
 =?us-ascii?Q?qiv8uwgjbcV3WsUA7/Z4Uo5UczDQha4NE8wxYQ4pNzNGjcGyYwl3Q1QMLEri?=
 =?us-ascii?Q?PegE3TuTB45rQi7/q9PzVZvZ+NVLYHSWSBAFE4Uucgqa69bI0DmhuEy1P4X4?=
 =?us-ascii?Q?zKd95m4wLLpISAJKFozL06hGflnce1toPKZlRiDNEG5qslPL7wV51eyqZ9DI?=
 =?us-ascii?Q?fwOB2ej3jDPdUHg01dfvbtmYJXbUQ/6/SBY6ypkhzNgefPPbfsHG9OMsbb2O?=
 =?us-ascii?Q?R84dWt623ZftQqlN7g5+rRkfDZT7QmpBqyOIfCLCgtL2Hjdvm2A6DwNZw1Cw?=
 =?us-ascii?Q?wbIaCoujzo1iJmZ2VCzPuUAAFwHemlhczsPa1J7ue1iUklAsTfbkrOAJjg3k?=
 =?us-ascii?Q?6Map/PG/zeynRPAtrXd3nu0VaIg7Yxhu9BrPNc+5sx7C4krwvP/0Yj3DTkfS?=
 =?us-ascii?Q?fZVF857mni4Zs6o9ZJjXmKWQjCNQe3e8aarvD33/N+cOsG7BSJeSaB/BmFwq?=
 =?us-ascii?Q?iCRdkY60ziimjonTQAQnRMQakblN6DhC8rhbJXHqXUoWcy8N3E1sMwHg/Aja?=
 =?us-ascii?Q?jgjoAusmmOcwlv5lVe8T6Vq5NmJbsG0c5FoPdP1Xz6uoMwmPcot0OALXuubR?=
 =?us-ascii?Q?clPTVmXg8dx2VNUhBU2MXd0v24VK8FwAdVEj3pgqTygYYURU3YeBdmT7Ajlb?=
 =?us-ascii?Q?ot+/ioYVkV/y+LXv+5cW0dHuoEu2RX2x4opS2PnqjnbxH6EqVnqdLj4U9Jaw?=
 =?us-ascii?Q?59MWFv47SDrbvD/uxmrlHfEJ37pXsL3GC76P5ZMmwTnbk+pSmzbxp52pVGF2?=
 =?us-ascii?Q?Jc/5zdW2yrMOwDYmczFubtPvqWARVK8howGqREb3B4o+uElfrJkY2V4ILiKP?=
 =?us-ascii?Q?dzR3F/wvnHU75Sh+i9sTZTbH7cI18HgN0CVVNT3mJ1r6CQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ENwuG1qDzPbe44JvIn+8fYyP9kvg3arttUJUNjZ0RMKU3Akvi5xpq98WhMSx?=
 =?us-ascii?Q?3zXeTDONXy41BeFstjZ/882DqKvYNmIzDdf0tigxm9GErNuzwF8IK7Gc1Slx?=
 =?us-ascii?Q?CjnwATYdbDpm1MrGDBk/BByA+TsCN/bKpp3usxZrgkQioYuHbewGT27Rq1ld?=
 =?us-ascii?Q?4XlN/jvzd1B+6nMpvq3cCCtL005i4LLvr9ESO/oGce8w9gKWNyPthDl8IWCc?=
 =?us-ascii?Q?GwzYyk1rmZ9OGG8oaaArKL/1sq/S85uzpd1g+zMtcpkouYwZPpUya0Vms7s4?=
 =?us-ascii?Q?XyG+ID5qlHuR2ifW4gzb33FU2UD5xgxuEcdisFQfWeOLW7Zak/yJdslE91hR?=
 =?us-ascii?Q?s21e5TRfwZ20ivSvhgKwbzkL1XK3L79ZyYv7KhSGTBzIsXnV+GlOue8kd9bW?=
 =?us-ascii?Q?7rb0UXa1HIUwNOwhYm78jyW3iaDTSpCUwKh9zLCAUi7bETJfk5DfqjhTOfdv?=
 =?us-ascii?Q?Al9fxqjqtuCvCBBI8FNGOSXL9c7LKCmwjBn38Hzt0/ZOEGAmOc9Ez9awrhcD?=
 =?us-ascii?Q?Wh0V/RT2E5bXvzVIZxGALutpp0/AEAQnbi5lxyQJaS1FQgqQAU/vagro8vAT?=
 =?us-ascii?Q?Q0v6KVEpuFUjSXBsYy0qJIX1AhAixg7KNfv/f05/cVHUpHZ09B7dSICA43tU?=
 =?us-ascii?Q?gsPaC+NVycDchwLvszgz1QRGu77AzqU1h9drxUY0ZJ0kbENHLFoAGcwlYEl4?=
 =?us-ascii?Q?P46hr6rXzWLKUOXABxZWIG/q92Berouvjmhx90Qa67bN7cybu0mIIwyu1TWZ?=
 =?us-ascii?Q?sdmudJYDtT7GfNMsGhAm6jaEq7zpnTbu4g02/Bi8OIiRSdXfFbLQofwnDjId?=
 =?us-ascii?Q?X/Ck0GI1C4rCsC0Gvbn6Grrs+scPJnZxsNMCLSJvFHu6HUjTaS5rt1BqGt+g?=
 =?us-ascii?Q?GaMUZ31OAUlVrWLnBKHwLk9VCoj3ycWiQmMHgC2epHnaSNqH0a/d7phTnOPt?=
 =?us-ascii?Q?4xUdFEER33nLztC/l76B+SX2pr60XYsiPDZU9LUOfMFvMJhS2mhJCjy/mBkp?=
 =?us-ascii?Q?J9YzBhJ5He/M+S+AlKoNMAXj9Ms//dVByNrJbNQAVCuEVSvilfoC3rpbVvw+?=
 =?us-ascii?Q?BBUNoNTqX2JNvvNj1srfQDLXPsl0WicEN4CB44d0oIb/4T04cuGPwV25+cWR?=
 =?us-ascii?Q?4mbLR6hddSpcdavEtLf3qwfvEpBRLlmSTEY9ZN+LjW/t9+lQlJ7fn9ig0Owy?=
 =?us-ascii?Q?j0VOaNI+5ND+h1dDsoFn/8jhfIMJLm/N6TJB8g4yME4g1PAO0CoSfG5Zon0H?=
 =?us-ascii?Q?mZFunrL5vteok1l7dnmjz6npNBHutJE3k9t9CY7r7pAXk2ivPH9CRjm8D8Dw?=
 =?us-ascii?Q?54LIeVlCmFlr5ueCxNTUqr5srKo12PFpZ9KtxSA5ENG1XIBnUlB3s8jEEADv?=
 =?us-ascii?Q?4tTFaKjHt2vIt5WHz1PghSzJ+/IMriQV8Bsx28Kt5GQxpJSHbFMNAYaYrz82?=
 =?us-ascii?Q?PU5tnqnW3Sw81X9bQbxdvYEOB5wNC80rAferEne5QlDqHZh7T1x1Rx5uattb?=
 =?us-ascii?Q?2xVMKtmS1rFtwUW6VetNeF/XmIsDjIUId6RESbakbH+jQqf53TJIROs1d4om?=
 =?us-ascii?Q?WKEOlcmJzFW00Wcrod3uMnlXnW8sNebXNKybCK86?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wg33Upmajs4YiQdl7ox3dfhaksidFwZtwh8I4+ueIXhTwNQrtcvNa8eHZ5tuZRP+GzvzCvg8UCV8nh6e6dDc9Tx0ifTGa+/EoXVKwJvTVNGCrTA5M5znJ07PkJgIgP/Rsv+cpRXbxan0BWxw/HNlJ0aiKhLR2+FGU0CZ+Js1J8OoiGeqoWlwNngU3BNbtJyJHrEdL8MNrwphZWVNTTyRqn+SRnhslnSoRLKPNlA1kV1ruh860O1i5G6YnvrW1ZxJ/YeTbVYYCto7y/x4bo6jHpF4p9mW5B2bquMuxRRsEHkepb94AG6ziKAkbZio1bBlXzyBYoZ3wUfnJYs15JyrymJuUgCMwkBKXzK2VPUFPfyi3t5LRM1E62r7OTlzk+Fqulfm8G2O8RRgkn6RmbHVHrfHB4thOLGltl2kvfNRkcR3ApxkDlB5EQR36rKOSiAQbyzxsUBTUSN96Y81mLFMmVYdH0EMIT0kD7rBmO3u4TpI5zgW1so8tqwvAN6hMJa9BtFbEReR87JWpUG6lprogvRZXf9amIuT+RSkvAySgruY07Y+OSDHeREyv4+ihkGjzmxewuDy0b04izFVaTurzdUqS80jDNZ/Ivv2oaqtNfE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e107e4a-29a7-4671-b13a-08dcab41196a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 17:58:46.9605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NslnylB0RHGqkBhP0o2foBR2SSHP3yfXtw2Zh3gHWWXXIuHnv0yKNmEbnGmujyyeRjHfc1FGiFHLRPAAzk9bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_07,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=993 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407230125
X-Proofpoint-GUID: 4lzBWl8I1hfTXoPD0K-Wl1E-APDq2VfO
X-Proofpoint-ORIG-GUID: 4lzBWl8I1hfTXoPD0K-Wl1E-APDq2VfO

* David Hildenbrand <david@redhat.com> [240723 06:12]:
> On 22.07.24 23:17, Peter Xu wrote:
> > On Mon, Jul 22, 2024 at 04:22:45PM -0400, Liam R. Howlett wrote:
> > > The problem report from [2] and [3] is that we are getting to a call
> > > path that includes unmap_single_vma() without the mmap lock.  This patch
> > > fails to address that issue, it only takes the caller with the assert
> > > out of the call path.
> > > 
> > > Removing the function with the lock check doesn't fix the locking issue.
> > > If there is no locking issue here, please state the case in the commit
> > > log as you feel it is safe to use a vma pointer without the mmap_lock
> > > held.
> > 
> > Could you please state why there's a locking issue, and why this patch (of
> > a x86 PAT specific issue...) would need any documentation on that?
> > 
> > I thought it was pretty common that file truncation (or anything similar)
> > does a file rmap walk over vmas that mapping this file, and vmas need to be
> > alive during the rmap walk, no?
> 
> Right, I was also assuming that the rmap locking (from where we obtained
> that VMA -- rmap interval tree) makes sure that using the VMA is safe.
> 

Ah, that's what I was missing.

Might be worth adding to the change log.

Thanks,
Liam

