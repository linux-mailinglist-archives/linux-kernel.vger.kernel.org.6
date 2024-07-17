Return-Path: <linux-kernel+bounces-255621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5490C9342F5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77C2B1C21569
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8A51849DB;
	Wed, 17 Jul 2024 20:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RFNTDkub";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0J7QU0v/"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACB31849CA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 20:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246872; cv=fail; b=iZh46kjPJPBk2Jj+k3hIr8rvYAD6GC0xR2xgTA8viikWDbqGXEaYyBmbVBa02S24ziNASVP6opgtrBYH/0zTQNrkAw5iKHbhnE5m5AOjPKOZmpyAKRt8n6aoDDQC+Br7VEdRzJ0Qj+sqKrLjo5vo9MJgdN6NAUpn9+zICUcbNY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246872; c=relaxed/simple;
	bh=Si18alZgatmYZ+sA/uPhGx7TAS4KhcTU/ETDkETbPag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ShXj5LHKGcEdZZut+jmXtWoEwouTBYtsMmnc1foEuicKwIm8yImMGN9izcnUfrR1XkETyQIjQv5z26F1A37OjtFXB28YeFmSjsTwgUD5b/Bd7bE/JSY3HXmAA8wIZxeY8ktg6i4WrSC8s4UBB2V66bGaHTKMGGx8y+LvS/wNjLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RFNTDkub; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0J7QU0v/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HK03GU028095;
	Wed, 17 Jul 2024 20:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=X3v/lo9AxRmsHNZlKpTsm76kEoN8cW2y2gHVgYbRbTg=; b=
	RFNTDkubyajNzrJwx6ZDN/vhGbvEDpeqiNNi5Mnf8b7JNjeHq/cJsTq/rKcWCctw
	nYSlz6c8fwzJg/pq6UZ/8gzdkqbrwWN2PE+OizSrk26/ZBInbJSh/yjzubP+OR7k
	nZGy/5HO/FpYvk5E8VFQZlg6yFgXPi7O39X2RET+q03xuTKGxY7Dr9cIc1ixFCra
	lbEDuIhZ+Go2el8crt6pPT1G9AJ9oBbt3pHRz6YYe069lZzUnbCnRl+3PSHnBOqO
	SPtaHgtZpVkQfrUCgp7UVOdWcPukSXUOaUJrI8hzEOy7jWUmT3D10QSgEgUAMnNN
	yLGtYrkbBKyBuLxihvJVnw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40emkyg19v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46HJbBG2031594;
	Wed, 17 Jul 2024 20:07:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40dwexugm1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQvRXb8zmbUCmIFsbBkZQxh56Wpz0vk+MYZRGfCuMMBH2s74Nd9ArCzCU0sVvff+H4iusG/zy9YFQVLOotAmhu53CnqxANZ92x5dIKzGPEk+t48JhO2i4TcsIdEt+js4zY6R4yVKsiLGXqhgg7TTlji7ugb22IeVbvpLUuXw92h/XRUUtzju0WkvNIJSBJ/lBfb6ndLlA9UVZ4AmhLh1gcFto2qWvXWLBzIc1CACOtuSnX4BIyzhODTr49XflsHSL7IJv0Kmf7FJuLq6IoltYrA5l4N2wCnQajt2bYFF/kRH3Hn+7vWEv5K3dDVcdYgQiU3t6H+GZZml3yDiD6/TYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3v/lo9AxRmsHNZlKpTsm76kEoN8cW2y2gHVgYbRbTg=;
 b=U7lcyOBhem7ok97IUqR60TLgCUE41U8s/2WYUDdRFkq+KGnrsJH7XupLlGf/b2p/RaIb2K1KZGXmCTt8LveHNJZBch4SKpj3oqjo9rUeHtZtgGoO2cDdy4Kk59Jyum5goq3D5ryDtZadkImBdXXySW0W/t3zitxNZ1AfB4F3Wl06wxzQvmexuGg6LY6QdacQ5GndYtxTUeThct7a5zjo9xng8ICiMm5i3xqMLeVPJhidULRcyjDLz6CzQmHi95rbIfLIKaPLivebrCKIyDRIKCOp5lRHa32jR/JydNfQ+//vXRmNY1mrnxCnnhonubVZkRYmFiHK5bt90QqURSzliQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3v/lo9AxRmsHNZlKpTsm76kEoN8cW2y2gHVgYbRbTg=;
 b=0J7QU0v/k2GR2ZevAnfIOJl8WdKqeRIo8UBdWowgkkioJX8GKFVJnFnkX4Kf14laPxlahfF3gL6DbDYBm6glmw4Wt/giZw4IxSaU14AHi6orPWmoSTCng/sDHqjxwJP2+e700tUQFWyAGuZWTFVMFXcaGpfFUyjP8uGE7tL+YR4=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA0PR10MB7303.namprd10.prod.outlook.com (2603:10b6:208:40d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 20:07:33 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 20:07:33 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v5 09/21] mm/mmap: Expand mmap_region() munmap call
Date: Wed, 17 Jul 2024 16:06:57 -0400
Message-ID: <20240717200709.1552558-10-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
References: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0143.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::18) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA0PR10MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a147d9-c97c-4eca-7d80-08dca69c1832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?41206tqtRPNEeQ9WhAN39w7Pq4AoKu76S1UzR+/ebq19EOvcNBqnzLhBbgh6?=
 =?us-ascii?Q?ccRyCfiASN1N8Jf5oe5qO73kP1pRHyKIufnSb9bxC82R5c7/rwl7f1sFjcAT?=
 =?us-ascii?Q?eu8cdQoFmJMiGNyE7k3BvglPxB8lx2bcWkN4y7YUWOYGbCi93RQeaWSgWTtU?=
 =?us-ascii?Q?4h0/vLGkC3d/SzM9BbHLqRZxyRTrCtckfnSwdeMVf9kFXd4pwIZ6HKqCtTBK?=
 =?us-ascii?Q?6UQ4Qj0q5p/AYoS6vV5HRjPS1Ko70oKjQ9IwLr783DlqVR2OM0xHrAp091MC?=
 =?us-ascii?Q?jUrUFmVX1u01S3D4TB8EkCWZdtAg8ndUcPlZwetzSzyECcvCSbbgBiZwSKvd?=
 =?us-ascii?Q?RtG0+pDi5X5I9bpqd/zW4t4qWBJ38qzB6+RLz7k75ZXLHREn/nZZUACIu6TR?=
 =?us-ascii?Q?2+3c5e6hjO/eEiZnbv6/9d5mYdSeHmEcEAIW75tLUqtQ2zdnYmP4cP61ypco?=
 =?us-ascii?Q?pefEIHBB8MsH9giHqhJRSdtWB3txFbEIFhga5rB5E3fqs9bw+CaN7bwXS9Xy?=
 =?us-ascii?Q?fEvDadac/pVkC98AQIhcOJdrKM9Vx5l01fFFWT2NFOSD8VtIAdSvOw813D8s?=
 =?us-ascii?Q?YWBTZDyQeyhUI86IZ9MYCv5VzaXvtqL/NkfR0MxS0cRsNCk3pgDdXmscCc0q?=
 =?us-ascii?Q?3/QoLUL8kF+VojrtNDVfDBs2zjm/SodXoOW7AAS7MUfeMnYWbsnZ5xPVdp11?=
 =?us-ascii?Q?G4+9p8IvuqOOYbyaAUikSbx1l1bwAQ87RaNtUvgdZEwj1cVUFhSpGNFh1Zzi?=
 =?us-ascii?Q?Ltmh7ewrTKG674N/mRZjGIDlZyjzY9RH/PbfWFo7X31UW/PHDjJ4xGNu9IsA?=
 =?us-ascii?Q?1Kbf5q6E/IaoD7TlF2qyJdrKW/zZbApMi0yIYmvF7OgVgbUwxgZcetiowoXD?=
 =?us-ascii?Q?MT0/nO3b/Jkz0fuwkwjgvJe3mHhsvLUaY5O/R+g7kqRAy4Jm6eFP91vP69E+?=
 =?us-ascii?Q?7eyWXsIcwbMnOelT3EzWJI83gVkJfuGLZZBwhjoMOkuV0ysAYCuLsv3g9SAF?=
 =?us-ascii?Q?0+VDiSXzCLZ1s0UJB+m7yGhhf9s1+B4xuj2oc0wdtVIsImM+x65jhpa9q02A?=
 =?us-ascii?Q?W6PXEtFwxOCaXiJr7mXS95gV+MHqXCWE/Aos7rOH11carGteE+s+UtLyeAhe?=
 =?us-ascii?Q?lbBSPlgK0iLU5MVJAxdlAC8+PdKJcpkxdGwwFJa88Ye8CssRUCKezGTFrBN7?=
 =?us-ascii?Q?sVzHFfZ53tiifaeN3fz6HTLql+WGGv1jQKOZXhumDNdxRpgfF8jSRK6Rr5Pk?=
 =?us-ascii?Q?bRtRt7oUW5YiYLGMd0aAsO2L8FnbKAZWQzEJ39AYx3aPXTpcAS96bS4MpZa5?=
 =?us-ascii?Q?7Ou2zWqAvXnMdlN6wqpPiu1JRPzUQZdrEg0PdyXbRgGUig=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WnmxuffSVt9xLy+ocvHFaNjXDLyLnpxzY52MfnZimpsVahBBI12NW9rdbRyx?=
 =?us-ascii?Q?njnz1T+tkmoKhlGY8kDXzvY0/FENqZM2iOLUIagGz9dQevMUwCFnTfJhsFtQ?=
 =?us-ascii?Q?r8ynFPLR/77P5CpYC9mXlLS8KAH4qPpQ9j6Y03gCIyw8GGSdn7ixDJ5acF6M?=
 =?us-ascii?Q?DOuBcjLdtlwMI9MHV6m5oCcL/FGIkHz7agUatF5QSLrpXrRasAPuFsrNdCPp?=
 =?us-ascii?Q?Lq5T6nDNAksg5Y9nx+9EBPEnTHyx/pjl4XsAxGiewNI66soUjpqVq5MedOPH?=
 =?us-ascii?Q?lGOuA7ET8xOuEYSlIlN5Knrym93a21J5B/gXxSOQo/aoOUqMjeMUS76v9NTM?=
 =?us-ascii?Q?iFXcr0YTx7EFgavyX387v0si79euUG5XQ4h5f0txPAqjYsIJ+uAJZvvk2adI?=
 =?us-ascii?Q?/TmLyeeVdUrnP6cZqMN12QBWvpvYJboVxAiQPUrhCRQoAsUP98s3DZpBz3ER?=
 =?us-ascii?Q?ow7npqkA51881yWpquIpUOrd8ijd+oV88m6LptTE0ZuI8V3+j6bEPHH8Pd6r?=
 =?us-ascii?Q?HnUNgIGaNryHhJeySQ6DR7N3q1/lcp53QnQlNhoKk5DnyyAh5NgdYaQ29lCJ?=
 =?us-ascii?Q?1LnOFRdRrwPGPmwG3tANS0h6LGK6jcsTbEoEpQV70C/sBFeakWEJBYe46i5p?=
 =?us-ascii?Q?CcX16fWqC8AucFeC6p/jlv1ZxguDfjobhDjSsJ16Ac1907l+9C5Qcf1S6fxY?=
 =?us-ascii?Q?MAYmYdDqKVUamuX+P2Sc0pC3jWMVItdDX8z6J1MBImSzf1xAoKTYrosEtqmf?=
 =?us-ascii?Q?/+W7/LkDyHK3Ic4s/PhxpWE6fi3w/u0avnmb2PMSMB41Aid25+5TwA+kgtsl?=
 =?us-ascii?Q?biSTCnLoNtTco5eV9OtgpsK73IVablf+CpzitUfTXUXoBhaaevUgWtwzhEFI?=
 =?us-ascii?Q?D/83ueIs4yJZP3X7V1Q+DLPySPPBMC6CiCVzunPj3hydNyT+3at9+Io8VIEP?=
 =?us-ascii?Q?+4XLk1Dy2QX0ocpiUMbmGJhsRiNbLlOGpQgHBrwFVmMKgrWfLytZnfqFlB0G?=
 =?us-ascii?Q?uU2xLnbLRhM/oVHEb1oNkK1mXsbY7ZIS/mUpMsSh374wQskwwruZmN4NExrr?=
 =?us-ascii?Q?0EJQhiputvIJcKve7hY+4t292kSd+POLdYHo3vANrGRtnmIHTYg3qBpBWGNA?=
 =?us-ascii?Q?JRgse2YiPF+TULk9iDAWNMjn7Vum0ga5F7bvYkDsxLOrNfvHerHK446wLRHl?=
 =?us-ascii?Q?wKu0KQRfDbfebJhBHBoiQRkcUBtHh2UumDt/pPUp+GET7SgvjarksxvVPExe?=
 =?us-ascii?Q?kA84DGBoA0O9UZsy+IzIJcTjTx8FPUD9nAgt7sgkNIqepQlJJ7uGoHGfnln2?=
 =?us-ascii?Q?zI9uKMRrlFyTS4AScZ33b7Qdjtm+oOsgyqZGCL2zykW+gKXZv5vP7p0YHr+7?=
 =?us-ascii?Q?ExTgYRzgpB8k5/e47ybe+Z9j35eCbL1drVXUHIvF6TtMLGcucrM6ZWrZt9Ut?=
 =?us-ascii?Q?EaBeSGDQJW/PHZEiAk2ucOMRD9oGdWRbai53ljazjo9riRK9VSZbo9UL6/6k?=
 =?us-ascii?Q?YR8yXQ0OeoOEeLCihkOn8/w5Jm/f8beSLg1eRmKdQXbYWzkSaAns5fKJxxpO?=
 =?us-ascii?Q?990IJZ0H2qdu8jQ1aSg2+TyqpXb/H8wj1dd2sp7Wc66NqUIqK94mLkYdhm9s?=
 =?us-ascii?Q?SQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cjJ7uDkTt2KInEx9KwwFrvgRni8Vq39WuR/S83bYmXlMhBT85AGiyTdrUS0G7KHo4ajnsold/1X2LfBu76wrm6WqdPKirKo+JiksFuwjIRn4CmadvpU7KDV2Tu1G0tepM8tdB2etpJRpRI0an8dggChpdtpaGh9PMc+485hhKVEScgfhR12JViJysgYTC40MepJmXEd+dlHGR1d1r/HZoRWKchK1dc5dVCrPK59AKL2qN8B/VhM2bKR1n05A+DxzpF2YVXm8IP4MXHzXnmcJ8bQKlQC6VCoEwQXrL76ute/tC685iTktknlbMq8yk47ZkEYpbcPbp8AHXqgaWgo2HWMQPBNHC11mLWCIkKmOnWEnyNSqJj9RI1wQJBg3kfVg0eWFmkjpGCxpxEQ4bLjPejI0PZknI9LVRmSikUO7KjRl6hvNACnsJgwnrWR2e1YEqR5Ed5OAo9nAmk0FM9TrLAv3QHzDbqFu9bm2hSXXl9v+JKGRT5DqrWEyjgOTAVdBHWd3lpBPlMbaJuomHbCsl5JQG1mNtPOvAAe7/vy4kqoY6cBpP2KOwrUe/50IeXrKpaEpcVn+nlzqCNVha5pr2a3Y2kr6oZ+yoB4zFQNnPd0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a147d9-c97c-4eca-7d80-08dca69c1832
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:07:33.1850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8hOQI+OhNe6qrhjsDcmGKz/njdzYbLpzB7Ar8GgvlH5FCXg5VLHwqQBw8K90sRKmdlyWE9DrrfY3Me1ENGPV4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7303
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_15,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407170152
X-Proofpoint-GUID: xWU0oLElLrmHOswr_d-TEfm3l9tGAdl0
X-Proofpoint-ORIG-GUID: xWU0oLElLrmHOswr_d-TEfm3l9tGAdl0

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Open code the do_vmi_align_munmap() call so that it can be broken up
later in the series.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 49b3ab406353..a1544a68558e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2916,6 +2916,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	struct vm_area_struct *next, *prev, *merge;
 	pgoff_t pglen = len >> PAGE_SHIFT;
 	unsigned long charged = 0;
+	struct vma_munmap_struct vms;
+	struct ma_state mas_detach;
+	struct maple_tree mt_detach;
 	unsigned long end = addr + len;
 	unsigned long merge_start = addr, merge_end = end;
 	bool writable_file_mapping = false;
@@ -2948,10 +2951,27 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	/* Find the first overlapping VMA */
 	vma = vma_find(&vmi, end);
 	if (vma) {
-		/* Unmap any existing mapping in the area */
-		if (do_vmi_align_munmap(&vmi, vma, mm, addr, end, uf, false))
+		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
+		mt_on_stack(mt_detach);
+		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
+		init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
+		/* Prepare to unmap any existing mapping in the area */
+		if (vms_gather_munmap_vmas(&vms, &mas_detach))
+			return -ENOMEM;
+
+		/* Remove any existing mappings from the vma tree */
+		if (vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL))
 			return -ENOMEM;
+
+		/* Unmap any existing mapping in the area */
+		vms_complete_munmap_vmas(&vms, &mas_detach);
+		next = vms.next;
+		prev = vms.prev;
+		vma_prev(&vmi);
 		vma = NULL;
+	} else {
+		next = vma_next(&vmi);
+		prev = vma_prev(&vmi);
 	}
 
 	/*
@@ -2964,8 +2984,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vm_flags |= VM_ACCOUNT;
 	}
 
-	next = vma_next(&vmi);
-	prev = vma_prev(&vmi);
 	if (vm_flags & VM_SPECIAL) {
 		if (prev)
 			vma_iter_next_range(&vmi);
-- 
2.43.0


