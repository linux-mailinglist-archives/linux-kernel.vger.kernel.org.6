Return-Path: <linux-kernel+bounces-378199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0179ACCA7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C3EE1C20CA9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7D31E22F6;
	Wed, 23 Oct 2024 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fTlMoYEr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G+ohylZn"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753B21D4340
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 14:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693863; cv=fail; b=PB4/AVEe59lppYXbtTTJ6uwwitIMkBQSXUCrBhCgMdT/3NI7deZuSMz157ELmYrmfBZ9JVoQQ5uNR/buMNPkVRTtx7vjMuIjF6JAVFFaKoIHVoabSZbrjy5zTLayUlqEcvIpcJ2YiWZHCTNNAG0hSI5GIqsdz6v79u5I1pQmKXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693863; c=relaxed/simple;
	bh=CbXBV6L4N/TzAvvC2FGZaV0mVRvnxhoVoi2uJU52b6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dkx1+fbxHijIY0XhYQ82am4ygwAnD1AAeqI8KRPUAkAdSCF9/0tbnyX9ORB78UoxwyGa7YGGCwpWLCM8zn/LLQapwsMeTZpEw1K5frYJr24MVwDowtoqaZFKPeh6Fdq0y93ae58ndYwzIBhvidf/DddnnbEbbkcyC5nh+W/K9ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fTlMoYEr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G+ohylZn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NBQWYH017377;
	Wed, 23 Oct 2024 14:30:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=jgqaFi6yheydC1D0b8
	x4cEm0PQgrYabCLuhRnspZ5K4=; b=fTlMoYErHRJ1crdyDR5JDAE/TK/DM/v9cf
	eI3SQB2GNPUfLSUxFCvchrHSjHCysM31Yu168Ip/txYSIbK5TbHIf5hswSjc3vLa
	DSzvezSRWrDV4f2U60i6f8al+ADY8s1oIPrHLwPuUnxONT/pnYUvc3iHj/sn7WjU
	npvpCiFnuPDlMbg3Z0TWbxJqyzR30zq94s4EW79qe7VSUFhBjY5rgfXbwAmpP8DV
	JQLZkMLV+0iJ9y8LPgH4ekI2uO9n33/9QiOZDh4K8BbdbrgVzGCeEpWF/L3DYGux
	E/nriwoioCckev4jm/1zJQL3BD598uR9MUat+M4ExHGX8xYf/T7w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5458d7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 14:30:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NEUI6d030872;
	Wed, 23 Oct 2024 14:30:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh1ktwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 14:30:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C1c3hEnrRs+B+Q2uaF//BHV+xfC9Yonn5UIOmFR6Nvnv4B+GFQl/OSZu/69Y/RVz28BQcB+BxrWoy5UEeD5t6bW0CvP/vpZnSFtMhdXE69/8qFazkTVXJS08CrwpiK+keyHPddy6LEwooHu5DhaRBk3M/3ESPLzlz2d7Ld34TUYc6jzj5uofUKbzaVYnp2suz1ahJtccI98e2A8r4V5FH91HI6iGHc/y9HsXnndCZqtgUYvPrDD1S6r5TyULqIYf7IJgnta0XuoBOQoapcyXkaSnZaa6N9CLYk/BeCW67h+SLUHcz1b1gCvKDPgzHjIsWCmNCCSdDOeeKoHqO/CbXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgqaFi6yheydC1D0b8x4cEm0PQgrYabCLuhRnspZ5K4=;
 b=ceY47v+Dfb5SYPIEp6+bznLSWV7gky0U2IIJcYCoFpk5Sv8Woq1gx+LAL9TzvrmoQfdgryaMkHbzDjNnH8Azv6oDhNp4rw1QYyxq98AWDhFnfXPPux9DKeeTMPAhnMZ8Yt6CKj9a3cawVp1r+CMFrG6JEKtOLflZQiWIkN6QEY2OOB7lY/ftxIGmFU/+Eg9rr8UgK2+JAucGV+xBfaulBsdq3lZZBi27cljh0WHtQ1/xlYqgdRP7L0pF72IU+ja+32lVjTOI4LXd51UfjZrx6A0Ew6fYbIpJb/S3SD3c6GKnqi4NQ+d/JH/z9ohqV8IWzK3sxvEPyiXVyjif/jeexg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgqaFi6yheydC1D0b8x4cEm0PQgrYabCLuhRnspZ5K4=;
 b=G+ohylZnJa+NnXEG0aui51AKYQXYMVMxUueWm4+kyOFOzmQRGwXvqyPAIOYyJDBoqEhmHXBbOqU6s5An2f082RAdmarR5FCOtqrnkUzk0zc6/ntzHcpMW5uuXXeWvwiZZVH7GWZ+tKxiZSVtYxc2uJQZGa2hRfyG0tDjZvOvo+Q=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CY8PR10MB6636.namprd10.prod.outlook.com (2603:10b6:930:54::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Wed, 23 Oct
 2024 14:30:47 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 14:30:47 +0000
Date: Wed, 23 Oct 2024 10:30:46 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH hotfix 6.12 3/8] mm: refactor map_deny_write_exec()
Message-ID: <3de53e7fmsql2t7byzoqonyt7e22bztucjcypykvqiystbalw3@2vwnvh7jcfed>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
 <e67b7f6c682bddbea2fe8b2d87b8441e4d2ea6e6.1729628198.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e67b7f6c682bddbea2fe8b2d87b8441e4d2ea6e6.1729628198.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0264.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::25) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CY8PR10MB6636:EE_
X-MS-Office365-Filtering-Correlation-Id: 373e83f2-cc74-437b-043a-08dcf36f4950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t5F6IoMeDxKcs3T2gF6wu1Iqt2yd+KURyX7k+le0/fmv8jv1uMYrg9R2Bm6Q?=
 =?us-ascii?Q?Mfi6TyckJeqYhKg2+d4qaieW2HLkMYDNFSSAZEIGmi0oEF8hfKLZEAcJ2yuL?=
 =?us-ascii?Q?D1jH0NSmbeO0Gw2yggSeeWIlmRwpi9KQ6RGGccDXctvXwiS7ct2v5m1qOrSj?=
 =?us-ascii?Q?nCWTtxDaGthrnXgSjMN4Xxj45Lg/MTUonSvYNNPxuPZIyT/puiBpa5joRRku?=
 =?us-ascii?Q?6xDu7ibqEzCXEIwmjrzDSIdnBfzOMO7EdQbQGX817JMZEWGzNtd156+uHf2j?=
 =?us-ascii?Q?tyAhDjsK3njSxZTo0toaULhL8JDrU8Ar1J9SE7nChx5odYJqdJZgFAs6TXhi?=
 =?us-ascii?Q?iZXeYqTQ12YV30WCc68b65zVI1kvT3UrfpxuGC0shq8agBlJ0E+u1TyMxcC5?=
 =?us-ascii?Q?LJEt1N1dIeAIoHWySFg/wX0T2jcVlcD3a6fVsqcj6j//nH+BtMhjuW+WnKxz?=
 =?us-ascii?Q?Bk54kOed65b/wPI/9zfeKeTtaW+HwHPjQcqc7VE1VFBVzeA80niBYr4zBfHv?=
 =?us-ascii?Q?KkICbtMVXJf4pyYpY/xpdNRLd8e3VeHBrPXh235XV1tnSQoxRz09QK2+3i3I?=
 =?us-ascii?Q?Z6uYjRFLtkZrj1u1Z7RbSk5CA7PPzrM427Yj4mNGc4S4gut1irNA2jEP+kQz?=
 =?us-ascii?Q?RZV9HF7SmQydOpJhbY/ZqtPjbBf2qFKPFqmTPYs771qCf+Xkyvk1krtHdMN/?=
 =?us-ascii?Q?tGz+fiEqhLcDHDBSeIbAca/SL6EHNHArFtqoCWNwe6ZBEtq8OPHJle0MWF2s?=
 =?us-ascii?Q?+/8YcxRONLtJnLnPrtN7S9M0qr58wvJfprGIMLEB0vzmDg4yiykAaW3OZjpj?=
 =?us-ascii?Q?BJOtaCfKhgL1p3l+fR48NANRTpwlR2ohhHpG8h3u18e+JaVJdRoPZ7NzJiwn?=
 =?us-ascii?Q?h/Fwt4T9jQcLnbPC0HGkbH6QZnQcN3Jf4wndGEfQZl2fPyB5ZlLIVGnyWDb7?=
 =?us-ascii?Q?P9jdPv/M0XI99QXAtiveDzVHbE0jLahYH9rPcKBjxcIRgdlfvOcuCPGVKtG4?=
 =?us-ascii?Q?17hVwAzDTs+SboS+61fs6To/Q/qJAJj0b5P2HHfBNQQgKprqECDKwXrftCOf?=
 =?us-ascii?Q?vPxc5PG7Fm3Wp64H0KctfNlqIrjG4fMJKOYbCDawN6DJ0tgNOhgwEkmHORO6?=
 =?us-ascii?Q?lc2Kzna7ZbmJC654KXz5Zlxjj5o5nLIdBSgew8MCNdgmHqsesbY9zpkVq5Xs?=
 =?us-ascii?Q?xneemjYc4EcSkBUc9kOaYT9+GIZ1U0AIAQeXqtt9D/yVg6dHQm++OTO82ao6?=
 =?us-ascii?Q?d9o+j6cwqLKtSwqqiJ/rxVJlXkL//WLPS7HtRjxHctkUGGZTaOG49d1s3f8N?=
 =?us-ascii?Q?0lx+qt7vK7K2QufoE59rNdrx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5DqJAxe4XwEp7zguHjQrMCtmRM1HdMGCEG74wa4W96GCuYUor9USaU7uyNQF?=
 =?us-ascii?Q?ZE1tkJP9ogbdmVIFna4HiJKpvBPKlHZ9qPfsJI6iUaXEMJFy+kxYC8ytVHfV?=
 =?us-ascii?Q?FP1bIosBr5yZIOB6bUWcbO0uYekwXqKSPnISpIxGXjjpeVjrmbPiKkXHyuBc?=
 =?us-ascii?Q?EEs9miiyD2N7HUAtZQ33A3okz5LlNSXB7PGSk9zrj1Jf5dcUL/+Y7cN9T81t?=
 =?us-ascii?Q?yaoFyuTGG8UUEguszHKNLwlBomQ1yrNmwT4v8DTJR2z1D55Y3/U+AbFptA24?=
 =?us-ascii?Q?zeYZiV6cLeUNtaLI/wlcv87UTaoUyULg8M1n0WNQAyUtD/vUF2Ib92dr9FVH?=
 =?us-ascii?Q?/G9nRgYGlMHYTnIcQZKYv3zokeQpbRxZRtFpI/vWSNkXIkH7tCeFNXzcabt9?=
 =?us-ascii?Q?5eGkFOOS6GMTuVrFO2gqEvSQoxk/RHCwOb/L54/iYt3U5LLy94oKZ4hD8P6r?=
 =?us-ascii?Q?SBnb2nCWUSdyFih6RhacJhOS40HCn2UyBJ9nzgEHzlhj7sq1vMb0sfF3C1uY?=
 =?us-ascii?Q?OiQYqnx9P+uI/uzNKO1Rz4ItLM6jOuKG3CvHZ29KDW79TO7Fa8UJQ27B1k7o?=
 =?us-ascii?Q?+BUPU4W9Fde2qK/8WFAVkNcwtl04HYBDclPL8s+f7YmDG7nZpZsYCFlS5XUt?=
 =?us-ascii?Q?WQcSAa7GcAdi/rJrjD+ao9yCcZaqiEFFBZp75WksCcZcECA7OZJUfqzgYev+?=
 =?us-ascii?Q?Dx5lYQGJoSDNfJ9KSjk+RZ8g3/a2AYcT5nVgjXYXEcP+lW6Wy9V9QTvm0RzL?=
 =?us-ascii?Q?CkELvmR7l9iKT7SsNlaRT9F/wEDEJ7ySaciRT7PY3SDWuJD1TcrQGG1YAoHM?=
 =?us-ascii?Q?oiO0ksvLl1OlTNkkPLHJZCXKfR8X4f6s0g6sNH215xOg3NdSMHyf/9y+LVqN?=
 =?us-ascii?Q?nAQqH3vP3aTa0+wS6PjCCNf8ektXx+5TrfBRTFu6JTJxlxxRgdSfqx7rqHSk?=
 =?us-ascii?Q?cBnRwTrIsEET7ajfKT1kXuVTl5V3XYKcwL9l4Sb5yHyDjjrvxBc9sFscsEkv?=
 =?us-ascii?Q?l33lTpc6zD4gYN/jZcWuiOdV5dy/lY8KYEegg+oUWksQsj+chZxnNjsc2RKf?=
 =?us-ascii?Q?sUDwfNKsL/1CzGqsbmdlBuTlwDID2TOk/z10H8ZOCcLCJ1/g33uy5EAtRRe6?=
 =?us-ascii?Q?eJVmnnsEBmqsUKdWa1OFNyttGFYctMHwloN8NMrvCjnFPJ8DVPTzFo5WKAxn?=
 =?us-ascii?Q?MiB8XiyQHmXuB8/eSoR1+qYE7uGS8rRRGV0fgtZop9lDIZ5gvr2ZKvMJ7RAt?=
 =?us-ascii?Q?vpkxPy+6NjV27G8ZVj4XwPHiQlG5+RsPHVcWa5AVV9OsyfmjmQemcNJ3p6Q4?=
 =?us-ascii?Q?w2lhlfhEvZXXtoets3v5nr4L2RoKDjcytOPyjLRWk3TOZXmBbH6F993UqiGA?=
 =?us-ascii?Q?EI+fdSfiufGrvN99o4qxFW1vGOvV2sc3fbPSC0fZHi2InBjOj4CkN3WjCXKV?=
 =?us-ascii?Q?CtuLzSrMj8G4iv/lMFnH+O7jetOvXwC+hwywu+SixCV0C8qMiIcVyl2l7Nq6?=
 =?us-ascii?Q?e6QAg1kPbkGq9uYYb/8xmablQMExp9Bez67zOMcg0vZxG4aURMksicSV6y2S?=
 =?us-ascii?Q?oaMuqspNDlUFzsdNk40yaZgArxszVkn99kT8x6HEeUBc635uJpmxWVZo39zx?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xbPOZ56U15KC4Ln+b8yz7mGMmA7NwRG4AJL1quPpbP4XZ+0BzMsSgrJJt1myZhiTrUzrgSpWQJ4yvEiXlVV8PmzSMcgB6BnFjsUzQMSI4eIVLs3m2S2tPshuKizmtzjLYYarRiyS4hx6n7qgzCatRtA1z8sMOgFq6BpgdyEhiKhb6niCq/L6NyfkaeoJc63XAZNAQJLAtDGzHlqAvvDI481o03dFwAReSpVzx3DEeC07V+r+gJrM2vQMjS2mKnzCKipLkMVRZ5mB/J6Ke5NnsSm3m6kof93nwAzeDcyjmrem5rSix2XRK40Hyo0VR7QQVqOI3KBCI9Yzq3phSpTbrY/meEAMnqxid6mush6wWDd1mJfEmOhpKEpgrthuXZ9TYND8+s2vEpfriaTUkrQSsZhIRPI955G3dycdSDcXBRuUW58YrBnm6nexHKemCQoSHWMdJajmEsjP66Nod7/L0G+R/84/es3A47IXQK33KGlmT/Wggj836IonYvRIccW8tdzL5L+RUHROHVadECEbwQCEDEYstpJ+o3F8Tx1ctXz9HZxG3T2RE5ROj+YgUE6OXhhnIXNzueGrXRKxD0htEpCDi08rusqpBqQVlJN3Do4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 373e83f2-cc74-437b-043a-08dcf36f4950
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 14:30:47.8253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjIbDCpoHWFJbsHtj3qtW0xof5rjuiMgh6SsW0bJ2C7oSqvUQOZbKeE8ECr0D30LMZ/xgbMfQreB8GGNWN/ynw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6636
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_12,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230088
X-Proofpoint-ORIG-GUID: 8zUsBLNRAG8T5qX9v-PDio3Hyy5SHmZC
X-Proofpoint-GUID: 8zUsBLNRAG8T5qX9v-PDio3Hyy5SHmZC

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241022 16:41]:
> Refactor the map_deny_write_exec() to not unnecessarily require a VMA
> parameter but rather to accept VMA flags parameters, which allows us to use
> this function early in mmap_region() in a subsequent commit.
> 
> While we're here, we refactor the function to be more readable and add some
> additional documentation.
> 
> Reported-by: Jann Horn <jannh@google.com>
> Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  include/linux/mman.h | 21 ++++++++++++++++++---
>  mm/mmap.c            |  2 +-
>  mm/mprotect.c        |  2 +-
>  3 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/mman.h b/include/linux/mman.h
> index bcb201ab7a41..d71f83b821ef 100644
> --- a/include/linux/mman.h
> +++ b/include/linux/mman.h
> @@ -188,16 +188,31 @@ static inline bool arch_memory_deny_write_exec_supported(void)
>   *
>   *	d)	mmap(PROT_READ | PROT_EXEC)
>   *		mmap(PROT_READ | PROT_EXEC | PROT_BTI)

nit: the arguments are not in the comments (which is a pre-existing
issue).

> + *
> + * This is only applicable if the user has set the Memory-Deny-Write-Execute
> + * (MDWE) protection mask for the current process.
> + *
> + * @old specifies the VMA flags the VMA originally possessed, and @new the ones
> + * we propose to set.
> + *
> + * Return: false if proposed change is OK, true if not ok and should be denied.
>   */
> -static inline bool map_deny_write_exec(struct vm_area_struct *vma,  unsigned long vm_flags)
> +static inline bool map_deny_write_exec(unsigned long old, unsigned long new)

Nit: somehow "new" is special in my editor.  Also, I'm too lazy to fix
my editor so I'll live with it.

>  {
> +	/* If MDWE is disabled, we have nothing to deny. */
>  	if (!test_bit(MMF_HAS_MDWE, &current->mm->flags))
>  		return false;
> 
> -	if ((vm_flags & VM_EXEC) && (vm_flags & VM_WRITE))
> +	/* If the new VMA is not executable, we have nothing to deny. */
> +	if (!(new & VM_EXEC))
> +		return false;
> +
> +	/* Under MDWE we absolutely do not accept writably executable... */
> +	if (new & VM_WRITE)
>  		return true;
> 
> -	if (!(vma->vm_flags & VM_EXEC) && (vm_flags & VM_EXEC))
> +	/* ...nor newly executable VMAs. */
> +	if (!(old & VM_EXEC))
>  		return true;
> 
>  	return false;
> diff --git a/mm/mmap.c b/mm/mmap.c
> index d55c58e99a54..66edf0ebba94 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1508,7 +1508,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		vma_set_anonymous(vma);
>  	}
> 
> -	if (map_deny_write_exec(vma, vma->vm_flags)) {
> +	if (map_deny_write_exec(vma->vm_flags, vma->vm_flags)) {
>  		error = -EACCES;
>  		goto close_and_free_vma;
>  	}
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 0c5d6d06107d..6f450af3252e 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -810,7 +810,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
>  			break;
>  		}
> 
> -		if (map_deny_write_exec(vma, newflags)) {
> +		if (map_deny_write_exec(vma->vm_flags, newflags)) {
>  			error = -EACCES;
>  			break;
>  		}
> --
> 2.47.0

