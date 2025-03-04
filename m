Return-Path: <linux-kernel+bounces-543239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6236DA4D317
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 943C718950BD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 05:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2E81F4284;
	Tue,  4 Mar 2025 05:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HnMYIREV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Lgn3feMX"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2B91F4CAD
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 05:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741066843; cv=fail; b=D1MN75ejrwqtffI5IoTAQRS44y9J1+7+RKzi7j6UuKSBnETqt5ZZWzAD+h1XdwrREaiXV8jSgC+sNluiOL65xCrs0dJ2o7oK3BOy/PTkJ9TY3s+5sqBWY+jcIWyxwgk2t+kFLW5YhP6FwWkm/dPfCuVHcNde3owu9n7EGOUOo1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741066843; c=relaxed/simple;
	bh=+j6kgviMPAzKVzasdVLEpd75xFQiR62bkNb1P5idkhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g45tBpu4SCDd6DzbtN83tgZj5Mf2mlucuYyxSeVWiIkUd/PedsuNXymB289SUdUKcuKC3Kdnm6/XzTZBXMWFuufdlvLqJgm2Nk1FA1uekVef8An92TieEMQB7yJ11lqxkTi/xq20FwwSDxOw2ixmxjEDiJKeKQpoIolRnAoEKwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HnMYIREV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Lgn3feMX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5241NNZe017408;
	Tue, 4 Mar 2025 05:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=OFSpE+TtsgeRPoXQyU
	eZ9Gb8C0KsX3uyQcq1+4/uP9M=; b=HnMYIREVaQZe0bFb8B1Vxg2OTuDGaLbGgH
	Y2uZ0YB1LVsmTWsXmf9nP/e1aEvtRiAVmpDUDTN4hDeHC9K+WweJYFnbb+oC85SN
	FWDesHeRYgNvtiJ7Xp9NVx2VHNtwZiEF6pqwk4OFC+2Fp1vSEHZ5KabP0+anzFi2
	o6XgUgc9LANR8srrYPPqv2jk9kefWcns4HoXmz+ppjOqFoSrfnMqE+6OBxar7Uu7
	3zds/BQ89xJS5Pqu7ByuJGJJF/05IxJ5aFeyMndV3jyXuC+CsAWUunrc4kp4WERs
	+Nyi2pfljBCc3Pr5k5HQjTB1fo4p0t+lf0kbyvcvconjl2tnlbjA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u9qca5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 05:40:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5245a9Jr015772;
	Tue, 4 Mar 2025 05:40:27 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rp9pmq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 05:40:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0jvIS/2McZvXjd8vfdAVcVt0hW+0BIVI6n8DvBXqTrXU+ET1IWXA611kXwBl/FWO9lLECUzddCNhGczJHCc98lb0H+0PA6lSYPtVa0QKJxanUeoq8T80KfrhLAyt+CNAX1gxxVFfbn35gkovQM0MR2bNhh5xkYDd10asj/VMCIFKMrkim5yM143dWqCKS/qQdiMZbnDerBa1TyFP3JU3gI2FzW/tOzoxBhoTQ+K762744TZIUuTgeMNgjfIZKw7FYyp4XcRHzB0HGzpkoQNYPD8ylSV+3kSsopV8aJwNc7bcaD3z70ea2LU7iIIzR4jYmHuC4VBzEpTG57Dsq5UFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFSpE+TtsgeRPoXQyUeZ9Gb8C0KsX3uyQcq1+4/uP9M=;
 b=ja3P+skqm0Ax5HiwVX2lU8foHKdX6hj5t/TofRz/dtTQIPG2rYhIu1J1i6a9iQ5vJZAaAgTr6M65w/WjrEi335G7IWxYTnmVZ5Mkq5rwSSF3PmoAyp+uiYq9zPySl4rknA7scHky2TD1qztHvDfH9SVZZgGn2fPgXqx2nAMw6dmCWs3j5DBwyOrs6cQYciPuveMmON/V6li70BRXvoOmE9SPU9oLgUIKW1PvMcdNvI7I+uKwc4og414I31v6lA6Sf/EYUo6QFYMCwKj7mW75gU7muMkTh+PTqKtBC8J1K8CzwtmS6bNH0/9Wx7WdquvwHKbWpBYPk8brh6hwGj10tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFSpE+TtsgeRPoXQyUeZ9Gb8C0KsX3uyQcq1+4/uP9M=;
 b=Lgn3feMXxB4jO7iI6NxXhAmijnWtTqHr2UggoHkTstcUoAEQahmK0dluUJo+jlE99jBmYgj1mm1hwiXe4Kd/figYKWy1DYYAQJlnRXeQitmocow1Bcz8TSq2fUxHidWb6RgjgxNWd/k+bTLH/LD39gVTvyHrKdYYcvhyxsxzMks=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DS0PR10MB8223.namprd10.prod.outlook.com (2603:10b6:8:1ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 05:40:24 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 05:40:24 +0000
Date: Tue, 4 Mar 2025 05:40:19 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] mm/mremap: thread state through move page table
 operation
Message-ID: <9e7e4fbc-3ec6-4613-9120-fa49d52a50d8@lucifer.local>
References: <4cc18ebfc0cb32e9e42d86503cef3265108343e4.1740911247.git.lorenzo.stoakes@oracle.com>
 <202503040759.5zpJdC2i-lkp@intel.com>
 <20250303160555.46915fd9f69ca13e1fe2c5f9@linux-foundation.org>
 <20250303161256.1c3d497ee525023d239d1c38@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303161256.1c3d497ee525023d239d1c38@linux-foundation.org>
X-ClientProxiedBy: LO2P265CA0116.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::32) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|DS0PR10MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: 80d8da34-ab55-49c2-3411-08dd5adf0faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yhZrtorpdzvRNhw7zxswiX5KSkerVT0xGlCt5BF+G8hfVGEsf4EYhXtXdOje?=
 =?us-ascii?Q?fVCajnIOBDr0zl80fTHbUpRfnAqpTxDGb5RJVb2DhTqAb8QzbjCXhfdTLo6r?=
 =?us-ascii?Q?bQG21KvdqjAEAWMdzlXBxwcKZ8FHpIG3KdvnZMGTd2YZqjmbGF6BkF59XSz9?=
 =?us-ascii?Q?LOK3ur29/+gNG5iFguMILakVQ5uDsYHncE0KKgmCpO9+YhixdGE9NgD83icI?=
 =?us-ascii?Q?cHsUPqanGrufv96ZrXwcTRoTEOLXQpXirMPpMX5HKOfJp4I6sqrR4Ew52O4X?=
 =?us-ascii?Q?SKkePtqKyjYDlvVSeGR+NATqvEi2e4pcJ82bA7MOzuYHzAzfLzzPjG87rAky?=
 =?us-ascii?Q?vSWcJ/Dql2e10gDAe3t+vCijbvk+pp+L7V2pw9tN2QnnuMRlBcEHE7LUfK19?=
 =?us-ascii?Q?NmHNq5XttV0AcF0/2cRXEkF81p3ywrv6mn6V34QDSYx4rUz7GxSmV0kSZbC0?=
 =?us-ascii?Q?tFfy7P7Z2aNKgG54Ch7MwATIZKy97PqRJko7OQ4YdqujDmig1VXEHsLIatfL?=
 =?us-ascii?Q?F6kxs3B7dh1+ul5M2GODC/bnxiYOPhxDqFu8D+U+w8TjvNLkki7vinCuU2Hs?=
 =?us-ascii?Q?s46OpnoW+2endLnJOj/8PaPZGV1zKftDVYYAjzY6r5dV/bLtcPiZgDdzwLGG?=
 =?us-ascii?Q?1udlyo0tSxHepnjlepfRRrWJF/pFXIVNGRrgl9wrzXI0Uu2c1Ec4qrTQChXm?=
 =?us-ascii?Q?dPWY6fscAz4f7FowjKrvlbmXPXg5xzkK5+dat3frVjrVAKOPjmSC/FErMQhs?=
 =?us-ascii?Q?GkcScwGktWnsWPSorA7CqW1Vrtl1nUbpRgEV5FmRH1bepXfC7OpZldk5QUnY?=
 =?us-ascii?Q?AgBu0OHDJJOVjiX+eNHhw3hQJJxzpGWyj35lR4upfGPtoCn0wnPgvlWIcSaR?=
 =?us-ascii?Q?PejaQFXOvcN93zRK9TtwUPKknoM59HZDC8du8DR5nab4XZCGBOObokPWQhio?=
 =?us-ascii?Q?erx81fH+K8mWhwEcaUoX3ayT6/u78wvCkK6VGbt4Fwv9EpxV8sp8vCfNWs3M?=
 =?us-ascii?Q?Hc+fj9ACzC5A9jWtP2gPAV0if65DktLm9EVabnbL5urR2lntceAiZFvxfKNE?=
 =?us-ascii?Q?ywogo3Ar+8vNwXTBEi92gidPeNbVtNnsDoz57DSE3H3KeDaDypYWgywJ3Crx?=
 =?us-ascii?Q?ag16uiyeZjnVvi3VXyFtrOAqRe72KrsRQ/8Iw0jPXhzo24ok2Lfq9fPKlK9z?=
 =?us-ascii?Q?K487Gs4vhSWB+pdpnQbvsdpGGNH3Ym88eUth/Q6WFc2NDlOHhKCd1hZmF4DO?=
 =?us-ascii?Q?Jb+fVHtuhO/26J9cld2kcQhrv025/7gdZKtTG+zIX5qS0jcF8+tmluQ6ed+w?=
 =?us-ascii?Q?TxvzRd8YsubTD8i36uG8RT7tOGgiKcnV2QjNS/FSgP4wx7dOP2xnKLLvv8F7?=
 =?us-ascii?Q?o2yJeX7aTw+THB2dXuh4R9qoK6er?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k2Au4gsyeFL2i9sKXWDwIOeUEtwvtGX8O59JcvsneYgnH+uGSadvdCjsHzEo?=
 =?us-ascii?Q?+uML00/1IM3218odAMKoHzkr9YVGpqAsDZJ7rnOYWr6p6DUZ7aKbW4IfDAB/?=
 =?us-ascii?Q?DSvuPqhZyjovdMKvFHBuN8DwYDXnzumllxhMUytuJYrWJiA84UXM8oii60lu?=
 =?us-ascii?Q?QqVZVUOS9ZwVTQnILR/VlW4EW+YNNFexWs9IkIVhSeFtSJPxngsDsBqNlVxV?=
 =?us-ascii?Q?hKVO7bGO67NEzRlb855WPtgg1EqN80vZtJzZp3CmC5W8qrowyer0njqHpwTi?=
 =?us-ascii?Q?9mEsXkOjlsAQKAsV9EwF+8rhlGIOuvjj0vg8HTX1hCbwFHXS7n57YmqZInYl?=
 =?us-ascii?Q?s8gBkq+L6G7pGcPhe/hfUkrIG1BQ2OOiEsDippMAv1A1Uf9LVLc8K5aIfxbC?=
 =?us-ascii?Q?TXrBp6Wi6e57ld7AGiR/WPo7raw6MmuSLGC2b4sq02kA9WsDnGIssUsPu6AL?=
 =?us-ascii?Q?qMRWPMAmecqN+qAfY48TtJdqLYzLDzUlXPis5i/FFymP7TClfPv0q3Rkpj8J?=
 =?us-ascii?Q?cHWCDmUYN9nBo4SdrTCpLBVVHAg5X8VrqEaOazrvzsFasrXfhadQaLNUwMeN?=
 =?us-ascii?Q?yNNMDA8XvWxoZ8EiWSe0/pK14opMIMQDlEFWfRzXocAhC/r++DX+osVy16Si?=
 =?us-ascii?Q?JLHvZqnpcGmJ+6ZevmLgSTWHgnznSgfMsN35OlMUEtxJL3Yjtx9rmK679gXo?=
 =?us-ascii?Q?XARzhdjQbIiGhIZ24x69KPLVlknxTu1YkL5xTbjLgHJGJzaZoiqBGsmk3Zd/?=
 =?us-ascii?Q?QjyofMjjElBXCf1tnt40aNapJxNSlUN+jDWcH3EA9IFy292tDCP3gSD+sgyA?=
 =?us-ascii?Q?vqc7GXYsjvYEUM1Pap7B3Qv46B7buzNTwzkN81eqxAD/zo6gz5X+ZcaQyoS7?=
 =?us-ascii?Q?nt1KGksOnOQcKy+QKvf4W5hEPT6zze+XQzg1XHpTqrYe7r0GMjfVyLhDGqQE?=
 =?us-ascii?Q?bpBM0bc6qDbW0cCbwLHBcaBrYUCxL9lZTezDHEw1owU/gI4UVKE3lyREoCQz?=
 =?us-ascii?Q?1r22akq71TlHE42ArbGY6l5I/FCR6dFbpaclDLyVuzaeQVZyPDdxKwQU9eFV?=
 =?us-ascii?Q?GX2MGA6aInf9gqdNqHELKJkg/OQedcoxJcwZSiWXte37T5vqDu02o/UMxWSf?=
 =?us-ascii?Q?H4S9oj608nUZFhLzQ9DSujQCOPD/L/RbershS5erpi7kEkoJJRbwgbJ2o2XX?=
 =?us-ascii?Q?o11DT5vZNBEl8XfgNvq2TSWgxik9ZjEIkAJ8TA4UXyCRHpyO0kBcC/+BThK6?=
 =?us-ascii?Q?hVhiNDCeRtiOX1ZyX8PGU7WIxuzzyiHyixcD6VDt24KjBQegHLLXQRkGV6Bw?=
 =?us-ascii?Q?Mbf71JA5pophDnWYYToItqUHgPB76PvPF4xoXLmjzgYPz7h5ExOrezC9u0S2?=
 =?us-ascii?Q?ZcbVxcnU3EF6Ey7f8cPIdNtZLTsuPU9cemLqr+EWhnekM6gQhANOLTJL34aU?=
 =?us-ascii?Q?O7c86lhJoB86KW4dvSfvqCzmpPUNkcqQRqW/aURS2WGsdP5U3M+KYScikXIS?=
 =?us-ascii?Q?Rp5B7uLkXIgmJsBYApZtNoAm51gxpgSCfV5ZoJSnxJIUan9/7hWkSIyCowm7?=
 =?us-ascii?Q?ejdQhhzC31nV/miRMlUh76eo7E61vDKYQNngVHwaEAyTohVYsno06/XvV1N+?=
 =?us-ascii?Q?3A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BEAsxKrGgenJeiaaAaZ7FdXZwApDdWqGFzZ/aHBcIRCB2XkeZQnv5VuK3iL0D1cVO/BcrTFQmcAVCH6vrqUj9edipKMJjTSDgkXdbDvdFnWAUFgLPpguHGY0ipGGkI8zmyJKeH1kAoJSsIu1k4kr+i0Sex4NoaaYq3mdvXceuOZ6MI/pubOzYhKeZuqf8qu+uEw0HkWAYNIUosX4KYi6555immV+K8098CFM7k9knrNjsazbl+YvQa1eLB0cq1A4bFyp3OKJNfVUWE4DZNme2DF62KHZbTjtqjfh8zW8dJg+RdZKj8qYQcPpGHi62E6pBucggUSeAmWy0kuGK01mrhF/wItuUDJTESh49GHUAORgIVC5nCw76D6JP5tMQWIul1riGsUgqCFqLChJ8Aoc38RFUZx3lknukQ15C2w1JVujTsh1FjjWa06SZpAOMwghFiAQJ59vpFMrD0fP6ahtF96h6U/Hqto6Z0a16ifl9BMf7cRUsea09BVEqzm6FvMY2aD4sYYIic0MBQti6+y69nQ/OnsR1xaCrXTUL4bjJYXqgDAYsuBhaQolOJ/9p4tuG1neSwvJKpY2CxGfWywh4T1XpnLusliF3Gk5jKfa7UA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d8da34-ab55-49c2-3411-08dd5adf0faf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 05:40:24.5413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P6HyKRWk1LAxFp6aC29BiunbozEreABFx9DK+EZYg+BecuODcIDhZyFekMp9v0BXaGygEKQhRCwQjEtsINFxyBpAngoW9yc7R34N+wnkX5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8223
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_03,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503040046
X-Proofpoint-ORIG-GUID: MtSZc2e957z2UYr3uNyhrdl0-4PJRSYi
X-Proofpoint-GUID: MtSZc2e957z2UYr3uNyhrdl0-4PJRSYi

On Mon, Mar 03, 2025 at 04:12:56PM -0800, Andrew Morton wrote:
> On Mon, 3 Mar 2025 16:05:55 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:
>
> > --- a/mm/mremap.c~mm-mremap-thread-state-through-move-page-table-operation-fix
> > +++ a/mm/mremap.c
> > @@ -475,8 +475,9 @@ static bool move_huge_pud(struct pagetab
> >  	return true;
> >  }
> >  #else
> > -static bool move_huge_pud(struct vm_area_struct *vma, unsigned long old_addr,
> > -			  unsigned long new_addr, pud_t *old_pud, pud_t *new_pud)
> > +static bool move_huge_pud(struct pagetable_move_control *pmc,
> > +			  unsigned long old_addr, unsigned long new_addr,
> > +			  pud_t *old_pud, pud_t *new_pud)
> >  {
> >  	WARN_ON_ONCE(1);
> >  	return false;
>
> err,
>
> --- a/mm/mremap.c~mm-mremap-thread-state-through-move-page-table-operation-fix
> +++ a/mm/mremap.c
> @@ -475,8 +475,8 @@ static bool move_huge_pud(struct pagetab
>  	return true;
>  }
>  #else
> -static bool move_huge_pud(struct vm_area_struct *vma, unsigned long old_addr,
> -			  unsigned long new_addr, pud_t *old_pud, pud_t *new_pud)
> +static bool move_huge_pud(struct pagetable_move_control *pmc,
> +			  pud_t *old_pud, pud_t *new_pud)
>  {
>  	WARN_ON_ONCE(1);
>  	return false;
> _
>

Thanks! Apologies for that, thought I'd caught all these... :)

