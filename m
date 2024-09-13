Return-Path: <linux-kernel+bounces-328345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B9C978248
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEE09281AA5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB3C1DC72A;
	Fri, 13 Sep 2024 14:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FY8vGHNx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UQ+oCMSA"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDC21DB521
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 14:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726236429; cv=fail; b=aNcTTgJ/MibqceyhLcZvt8qjoIFh/UpitgoKI9vgjhxHDmsj8/KqTql7pWUcwcdxHGfKN4j0n4rxWUwmEYIYUVHgtcWImCw8yhZm1llvgYZkzxZ0c88jc+piYeziH6SwurVdEI3n5Rk7zByhrtL1BdVwMuq5kEclPGypZ5O0V8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726236429; c=relaxed/simple;
	bh=g+zSorfG3U1N5/YNtyID//dV+xPaBff2phsQUyDoOFU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TJCKYVOuX7lheRWTils4f9d3xq3vG0fpM82yod+XVSiU2sCvY2gF83dB+Jme2/rmTk9h/xsmOlwceDwvccFt8hdOgokH2rU/UyhyUX4WoOvMqFjNf0w/d2NT6yPQDVtQqZmqnJyYUeihBuSUiwf5i5/4IZF9tPMC19B9LJcqDks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FY8vGHNx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UQ+oCMSA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48D9YKeT012300;
	Fri, 13 Sep 2024 14:06:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=SXBnQ98f/f7P9Z
	dQa4POAoPEVxiDNUZRkS+JU2o9jyw=; b=FY8vGHNx5Y8bc0xfc/MXzcxJQaP4su
	2tGr3wrlgUIaNvt2pfx4D7liRqTv4ppYmlpZvqMaiGBL7i9g+9wyMnevWOYbzYFY
	RPPRfay/RGQXGwx/uRBBRqFik8kA6Ol+5Rn8gfAzH+RjhiQ1hQilRgt37tg4CpPO
	vpU5satBVt6DjqRhy59ouyuvVhu1t5rqrrPqR7bo3l5Y3iL6O5n+3jcmo36ui6tj
	DkjhgKOkWVYbF9M5js99C+zpnaHLnpQvqPExvIK+gZI7KtFW7+jcNZeqY2Vzenm+
	ylYNhCrvudpv/bvCVYVuCKcZPGmemh7Or9k8mgp3S/6AKxS+sKth9PjA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gfctnq9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 14:06:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48DCuGNU031606;
	Fri, 13 Sep 2024 14:06:48 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9d5y1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 14:06:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfFpQ7qNTd0VzAUgqfQ3xCgbBuZMmQrR8X1cGSTlC/4EjqnDIaBwMhWQrumQmeG+tGUxTkzFS2KD0KQeIYs+Hn16+gsn0mVHG2FxB2lPRWDhT3xvnwd//N+wZyg0Ku/hUgs96dWdXAo/K7angtNJYfdICIyWlzQKTAi8aE/z+wmbBAPLBBkmAP1EpIObtJrXiRKm0D1xwKPW6S6o4YHspuFFTn6vb7wZVRQR7iiiKs/J+2GQ7ZOp4Sw1lN7O0jlYvWz4WZBRFChkWla/NviPVrs5mQ7Ix2sW2T18XZ3cC/Q2gcoCNJZjTUp0k+SPonSZZns9quVnJcc8ZCUoHi4NZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXBnQ98f/f7P9ZdQa4POAoPEVxiDNUZRkS+JU2o9jyw=;
 b=cr11nmH0AVMQUdzG58N15xfCe/B8iaYpOPgFViCzRYfby3RkU1ezLWBqX9m31l2xxjbeUWIyAk9erzn2b7wUBh+EXaYhlWuOyIuRfHGdVutqfAgBg/livvCiYwLnguhwhGMFYdYl+11JI58LvO/mgtSSqTHyCta/p1anVbG6WZks01phBxgxDFhlPQdjmJbdI3ZdtOTCeHA9w3J9Lj3A9SiO+tzU71PNu8IMRyHvqOzc4NLCN2ixCBs0BC9o0pfDNDEVtzAjxfFnlQScBh4N9JCuiYBeCuBYYINqGTlj6t6zhT2aAuoPbBA9Y9ZsCr60M7jz3EaNrzYtB7EQBrtciQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXBnQ98f/f7P9ZdQa4POAoPEVxiDNUZRkS+JU2o9jyw=;
 b=UQ+oCMSAsq3gBuJBUsTJRbxqMn5suvFRqrbYzWBsGU5hb2I/hwMqIWJMno5x0uGQSUensC5pxoxydSb619+3K0t/TV/QmEh67gDhizIOFIyof8VYQefhMn2AIoSR4DiU51OkwUei4ksT2RsCQ8aqzCFR0GnmZmNcsX4uNLRPxDc=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SA6PR10MB8208.namprd10.prod.outlook.com (2603:10b6:806:435::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Fri, 13 Sep
 2024 14:06:45 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7962.018; Fri, 13 Sep 2024
 14:06:45 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <liam.howlett@oracle.com>,
        Shakeel Butt <shakeelb@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH] mm/madvise: process_madvise() drop capability check if same mm
Date: Fri, 13 Sep 2024 15:06:28 +0100
Message-ID: <20240913140628.77047-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0126.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::17) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SA6PR10MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: 862e0321-f14c-4db6-4a11-08dcd3fd4d1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G9mdYFHnTReNJ34NjcZmIY5YSwYqo5X6Ui3vKGoZ9RUOwbur1j1+yrMyi8UI?=
 =?us-ascii?Q?67wLxYWaYIOgXaQOTh/Gy7m+eLQJ01vviTb+3asNp07Fa/69Lr0sersJYXGq?=
 =?us-ascii?Q?jJU8vwcdKd3It0UqGCGXnS4a4Mvzksw6/TvIO63bpcLx2FeDKM/C4HSCCtiI?=
 =?us-ascii?Q?6ZpYVKEYYu0kCf7x6ZF81azRv380HjKO+DpJw5to721l6Bw6QdsugRK55UZ1?=
 =?us-ascii?Q?7sdLxZ4odqYphATah2PNP8xOUl8+vh0mcplhGgUkKctOrz5G9pHYjPncyFC5?=
 =?us-ascii?Q?LRiJEFjQC5ETbjtlJX+rLSgMCuJC0etPFxu7tcLq6pM+G9e+fseEEVMjI8OS?=
 =?us-ascii?Q?2XefHMhFf/Z4/qrLgWkAv4llgnD8KIUiewPj0uanVfohw4bv4OghHOpDCr0b?=
 =?us-ascii?Q?2zpojPGWh6jxOlercnrJRVvdYFkwNPgU7pwk4ne5J/g+dfZzdQwkGxmFPohl?=
 =?us-ascii?Q?80s1jVjAmpSp4H6xJyAd2cY2CuDcbNNfKraWo86/CYnTZyI2NLsam3owKtCa?=
 =?us-ascii?Q?cm2Uos1hn/02riWYAlHasopNw6dtfRNuTObemfgV3NFt9UDg1ZNGcbUtK9Ns?=
 =?us-ascii?Q?WZOaytF1r37Dp9/2lOpzkoTF3vDmfIVxNPEp2K8BxJrbjcAEFrlssX31tVZo?=
 =?us-ascii?Q?9Gi3k+eJBfukMJ6TWnMDVy9ER1sX0B0LL2g6UhCckKGEKFOLOCFCtcyODnwg?=
 =?us-ascii?Q?+aHqawP4wk279tLXqzt3jZGng0c2wZYANy9SuiN1v3tQoVr5PCp8cy3EKJJU?=
 =?us-ascii?Q?aRlFvky2rPis6n9Uy6XWj11ukYPKObChFQ8QyZbl/owwBDoKkKWBkpohxT8K?=
 =?us-ascii?Q?czAd6Gfx5uTJolXDczdoR2QsjTx0WiqaccRW2X9tO3WNMU3rIaaT7PHSf9kb?=
 =?us-ascii?Q?zxDbC5q0LQG0GLsvrMT+f1JEm4RCSY13YCMlc0Y/SK7QIVDppJFaYDeZwgtD?=
 =?us-ascii?Q?ndyrbzKyyU3LC3FfrT05iip6YygoNvBsk3xPkWOJhdAv8UthhzOpPlwPdbPb?=
 =?us-ascii?Q?IYuxfbgxdcicFLn4JvcjwNK+9WK84T1W9xCwY+In260mkuzNJMjXuL63VJKF?=
 =?us-ascii?Q?rnCGWC7oRX8A6Mo0y3fLEgtlAk01W8fPB2DrektclFUQ0Avk8arK6x4Vh5ta?=
 =?us-ascii?Q?zWXOAikBlAgZB416ZOQNWfc5JMRmh/s0Yigcqoup8S5+3fPiHY8RhpTVdLYN?=
 =?us-ascii?Q?QiGsevB1b13+uJQG2oUzpeiNGzkQYfZyEKJm8VwOtraYLcdDkkQfbG6CxIZ4?=
 =?us-ascii?Q?b947zEja+o23CBBJin4N97cW65gjzMVvJ4nYHjv2UR/BqhWo3uotxmX86bRx?=
 =?us-ascii?Q?bWpNVBj3Mvf9TSgdrZCMIPCvb7/98BkRPQwRi53RumyMqw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GTNODCaKjEc3yL1xUmBA7arGivakCBD7/Ql/qRlA1O+rnErxHb9kBt3tN4wD?=
 =?us-ascii?Q?xTbGyWs+COwMg8VxOsIfYlhljGIS43XQdiJIUQaPMhhrx9w6oBsa2QDMWEQh?=
 =?us-ascii?Q?iw6RlOsJ/qVMRCgWgT7EewFDubrjtNdUHmCiulcXHKVU92GFzefLV9plHMt+?=
 =?us-ascii?Q?BVQ3lhBIZPvoJ0kiUlJTzNKMzIIDrqPZ7J8B5XdaT1UDT1pHh2X7V52cVaES?=
 =?us-ascii?Q?XWYsspXSojl8LASkDBVn+A6xYMZ0bw70eB/yZwX4btPgAHcdOGw8vStS2/Y6?=
 =?us-ascii?Q?9RDKwAgfBWFkJoCwhJW2i7hXzoIk5UQfSdyY6dPHOKK7qlga6Q3nPxXmMgws?=
 =?us-ascii?Q?TWf1s3MNvMlqt68GaqHxtmEOyIOOjlMFTwUAVBisk4rKLh2rpB7UP6eJwnzJ?=
 =?us-ascii?Q?VFVsVpkPlyXODFgOkqZZDgChN1g4IZpOwvorlkQSWGhugYCe72+i9HCnf5+F?=
 =?us-ascii?Q?kSJlk3MrMUvLgg3PKcmGhzq5JY79W10lIoeUwLd0q3UjlWYceHBJhLCxb7bp?=
 =?us-ascii?Q?EFcnQ6U7M2gcWk1WQuByMnMGlIcJCsNpHAdQhLqviHt4lpPxzKkf8HpozdOI?=
 =?us-ascii?Q?JyanslzkiF/8BxLEJ1LHfHGB+IrNa68oY8rV3P1PPqnMZNQU5C33HtOMJ2dX?=
 =?us-ascii?Q?0zuozDV09TF8H85+7nU15IZ9nuwYc3/OnC1bCzKLntA2/e/amMmM+e8gJS/e?=
 =?us-ascii?Q?HRaXpYHfgEcNcfJQLcdGIPhinetwzoIkNLbAIXuZq4MiWa1CM84Jw+MGEVGk?=
 =?us-ascii?Q?sy+uAYhNy+WcbvM6GW5WNbbP46K9g9D4120YH0ct+4wkLsk/IXxRGQWQVJpR?=
 =?us-ascii?Q?Y2mub0NRIgG3g5Ej7jrCP1LircjV6jm3o1ZOo+xNtKcxnPmAa2gH6uPpFqmq?=
 =?us-ascii?Q?PlSVhH87JZrikO3BGafbR+9a02Un5TxWPRwPJDZ50IWHPTij3exO+I/ejbs4?=
 =?us-ascii?Q?84Ui8iRpj/osXVJ664Vmg5c+Iw7RBtsoHTSgYH13s471gCa6064prk3krll1?=
 =?us-ascii?Q?BKjU9kKcKL5U8CsPw8dJN4bc/uZjWJl38HHzM6wXxyoDwfGNFPMY4TGGoAMC?=
 =?us-ascii?Q?NvJRClSI4bYXcpZ4t/H4Uxm42TxTyQNicFx2WH2z/8EmC5dSpM36GF4XpFOx?=
 =?us-ascii?Q?8PV4y7y6H5kvZMRWjYuascBzxOr/EjECg3ApB1i12cG6MLPyfYfXP/wJZU38?=
 =?us-ascii?Q?pxgcnA17SYffkx9btPPJJx3kerYnKGx+aLl1NcyLZVqI7qTXUxsGjMxvluF5?=
 =?us-ascii?Q?sPP+EJp0bGMQQZedMa1rtg/Rf5xXsHBzhJd7ROelTKF42PdrKpV3AsonEBsk?=
 =?us-ascii?Q?Y22n8aDUO4hqm8qD7UvLsuJmtftnuJimjn2qh6g/W1aMVYvksQiRc65/D12t?=
 =?us-ascii?Q?RmFfJfk6RttGKfotzCEjlsq5zVX0V1j35+97h2kYTVxy2aBWlMiWuoT760Ye?=
 =?us-ascii?Q?FvF6tTUxdlnF1WTlNuPlnED7n9u8i40Iy1FY+OkyUhjXDtePhi7y2Ym1MzVQ?=
 =?us-ascii?Q?w7hH9OwPAEgHEdJ59HSAKVVUTEqF4zQYckn8YFVwdzzR1BvR8jO8L6Wp85VN?=
 =?us-ascii?Q?S/StrPjt5Bhxr6DQYZr/CIJbXCSUUL/Tv0BATROGbpT50ZczuhIZBgdkokWT?=
 =?us-ascii?Q?IkGhhOPBlDQyVn0ZK8gv9V6BGYC3gx2ca1cbuPlLgejf/YAvi59cmuUhB7B6?=
 =?us-ascii?Q?gysrgQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ub1dl3obWcEfNzpScaDzDwaspxgZ8IFV4gl5Yv75TSnzqoUKxpY1gdyh6gfGHnd2qhWMQBLPV9WU0XBNv4zYjdd4ia2CaoRgPBTVzgfsyE71NULbFkWcVsass0I/0zIVrXgLaLeReyTpn4Z8LJ9K4DRSDYgPRTPrhGhoZkh10sn/7iimMofHlUyv35eaMWC7a6Hi9EzFZwhu5sYLNGk6CogXXBRsEzAhzbT/fHU5ybaJ1zVkVFxmetgPm4hyTnXH8HTRDbQwDfGNZyyMKJ9rOknVdS/+3pG+xpIQxlz0WtKD7zl0sQyT0h9GL5mV9zdIkL0+n0nQFgW4LpmQ8lshmKRBrjYe96jVo/HsTm/sjw+D2up97DA4UMYdPmPT/Rtgt3SWr69Bco4wD3fgF49aiUgNXyki7Gwn4QPnz1QaoMIyQ5d1nxy5s+hgOkmNTfFvJpYIyrFidcYr//rhHD90rAqMmu70U6Hc8TjAxn92KtA5bMxN0BsBuqeurGnKFdWZmLegOXXRLvsMnozRLLIZ7S0bg6nxc2Hbs21ZeLC9WeNs74n5qo6Wrlu0zQAcx/+XoRszSeXMct7f913N85jUucTdsGF9bPYynX4AhkYXxkM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 862e0321-f14c-4db6-4a11-08dcd3fd4d1a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 14:06:45.7441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/cNBAjnFOL97ebhbVSOb7PkHm0BCz1L3vqBPIFtLHXCZerK2BIl3G2GA2prSF0fTPqQP3cij7nMMq9iIJu2rQEE1fwU0q3gn7UzuPq3iXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8208
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409130098
X-Proofpoint-GUID: KDQA3dLV31MLXXYP01x9HwFc3C3-jqOw
X-Proofpoint-ORIG-GUID: KDQA3dLV31MLXXYP01x9HwFc3C3-jqOw

In commit 96cfe2c0fd23 ("mm/madvise: replace ptrace attach requirement for
process_madvise") process_madvise() was updated to require the caller to
possess the CAP_SYS_NICE capability to perform the operation, in addition
to a check against PTRACE_MODE_READ performed by mm_access().

The mm_access() function explicitly checks to see if the address space of
the process being referenced is the current one, in which case no check is
performed.

We, however, do not do this when checking the CAP_SYS_NICE capability. This
means that we insist on the caller possessing this capability in order to
perform madvise() operations on its own address space, which seems
nonsensical.

Simply add a check to allow for an invocation of this function with pidfd
set to the current process without elevation.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/madvise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 4e64770be16c..ff139e57cca2 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1520,7 +1520,7 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 	 * Require CAP_SYS_NICE for influencing process performance. Note that
 	 * only non-destructive hints are currently supported.
 	 */
-	if (!capable(CAP_SYS_NICE)) {
+	if (mm != current->mm && !capable(CAP_SYS_NICE)) {
 		ret = -EPERM;
 		goto release_mm;
 	}
-- 
2.46.0


