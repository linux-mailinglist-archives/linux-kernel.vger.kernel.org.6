Return-Path: <linux-kernel+bounces-376937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAF99AB7D0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A376A1F23C1C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468FC1CCB3A;
	Tue, 22 Oct 2024 20:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L/wKDuUd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qPL8U3pU"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5111CDA13
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 20:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729629697; cv=fail; b=sZMFBOcS0xpn3NJ2LtMJT1kz7EfDlrWg8GM6nIxnGiu1qxz83rHtD7DJPJJiCxZq23MS0joHmErOkwpsto7qdgiruJxq9yOJ47GtKXo9oAib5SEWbS8b3VCQJaVrCrEzdmOm65OFG6WA9uXUYqHz16RmW0ucfW9X5O+Hy6KYSgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729629697; c=relaxed/simple;
	bh=E0qC7Ua3UXzEi3XMLrX+5853B+raXqW83k4z2/N9IIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uuVILRVgOxvCtQ+10N+vNUbWEzuf0FthXxcEjarkdLUQFNrabCm5/QVWC6JlLHycP4S7BtyNrvl3PPXZ/5EWUU+QoFfRbXwbL7qGl9haewUFHgsZboHyW6bK0TFStjEjhHM6rABZJHTl8pz3qQP+uGIfH9aTedG4Tt+OVGDt9gA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L/wKDuUd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qPL8U3pU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MK3XDW025813;
	Tue, 22 Oct 2024 20:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=IYEq217ZQe6BhqkHPhji53xMVlBJZl7d8VhT2IXVRxw=; b=
	L/wKDuUdbU68Zrv5TqWOnYDmQh62U8K3xVF8sGWtCmTpPCSu7cCUQFmQrVjc2HEq
	26B613sSVob/uOs02fQafV07K1B19let53bHKyZhLEVsWBluf8g9qXjlFt9yGVVC
	591uL8omVJ5XtTAP/4K/GfgQ+/PXAWQFJsP1Q5i/MTnZ9wpR9B6wycrSK00iKQNn
	06JTee7X6i2Sz7C2i2GaUkfsfxsCFjQmX6krrs3Od24oCkZgNYVfIbPMlbryQKgg
	ucjwstHm/MBsb71Rq4pf3Azv0a65/Lh25Ecs0DoqQcsA8cA+ZVep9F/wAtKikJis
	OGFW9/bjXgBveW1aisBqdQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c57qene1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 20:41:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49MKDugL022727;
	Tue, 22 Oct 2024 20:41:26 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c8ew34e4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 20:41:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBo2qVHpxX5nKQ/y+q+1qlYDO0Zt31YpZhWD2n0yd9WN7PnPgwSTqgnzfSNlt+RSzWt2iZaDJCXfCFM0nZr2hmI+vpXCxcjEwRdKLaH/fxZLLTMmjLLqOuS3iqJE9VS8BtWQNUFqTSQ3VAIiCdti3q8GxSiZREsFIgBGUy4OO6unxJ1rigG7e6MCQ4+HFiIrgRj6xLihzv1m4k0Wm6/zX1bpyxGDShphqwDwY2ghvoxbOHjRHqKMsrYLzGv98n3PsZAKtDNAlD2y6O080gB+/o6kNNXfKlbgCHXxxcwRoskCFvGEG+8dXBZQ4N5+snXoanOof1vH9kctsCm/IZicIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYEq217ZQe6BhqkHPhji53xMVlBJZl7d8VhT2IXVRxw=;
 b=a7pIYJ+bnksrgAu2daDJGGLZOPPHvtLfhhsC8WWLVXEyzUfawFgosmbdETfu1+PHsNDy7jWsgLu3KyhRbXt/X8O+KStw2qU/tTMbUVK9y+YQ88GHXxTZufC8fSLQUtAuzYgl8Oc2MGRgYzCphV2B6LcbkDApjQponRquUGgH9jPaL+3hWsF+MQPV+bcQ6IoN2Z3yBKf0DLn5ksM7nO+jVx3us5FnDszF6RAY2LhWBCgngucnce25oYKFhjaObFVWIBhz00ocnuYbrzdQnBhT7M4IRZkH0r4m2wCdBJSfCmG7sUrs12lgILLOSV1b2mdf3yWqXP2KjpmXzGydtG6r3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYEq217ZQe6BhqkHPhji53xMVlBJZl7d8VhT2IXVRxw=;
 b=qPL8U3pUVRD02G3BLz4TZur3jkgb35Naix5D/QApbFulmzdc07oXT7QCDoHv5dZtywAnM5bECCTuYgKYZfLc48fVckS0RicwXJni7qpQWnWGBvyKPA/EG7v0vuxTOvu6Zylv6NCbmtWKaCXbU8dx36zwJcIFsc9ebUZc38n8C9E=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH0PR10MB7437.namprd10.prod.outlook.com (2603:10b6:610:193::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 20:41:23 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Tue, 22 Oct 2024
 20:41:23 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH hotfix 6.12 5/8] tools: testing: add additional vma_internal.h stubs
Date: Tue, 22 Oct 2024 21:40:56 +0100
Message-ID: <1e039f29776bbb7df5878f3ac85ef6732f450fc6.1729628198.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0657.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::6) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH0PR10MB7437:EE_
X-MS-Office365-Filtering-Correlation-Id: 41598306-88f6-4e39-5526-08dcf2d9e40c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J+OWaVWsNAc+hj8FuUai3GoEVRlfPqP3l7FfbwZ3UvNVKNJO05d+1uEwRAPh?=
 =?us-ascii?Q?2dh3BjxldjPvRgqiD1Nccage1a2sADzGxIhbPrzHTx31KQNgZ143BpkDXPHG?=
 =?us-ascii?Q?8kWVrd/QKeLT1CsOxSZFI+U3Kfo+PavY803wFDxOG1sOWvg7oaIO/yD4D42f?=
 =?us-ascii?Q?6GBoSISckjwFQvS1iUV3/+7EtvjDkZOC/mik0UPkgHX2yiWM81h5en+/83aI?=
 =?us-ascii?Q?/lzYEmxgyMNDTG9VHPXe4zYGiKu03P9hZ2bQteQkF5v78lUIHSYoNa+xWlz6?=
 =?us-ascii?Q?r6G2QJ5/Ffz9EYYefrVhwiGiRscZ13WeG7sHnZ0dYGZQt180oLtJg7Pd+3Vf?=
 =?us-ascii?Q?IgQqyirn1yu4eChMACSu8PZ3YwM9gvQUlyq6B4q9XSxbx5ERs9AbmMr3YPFt?=
 =?us-ascii?Q?82JG87u4bkCiOvmVbR7a0fBbMCHNA+YhmHWPCdiw5zNGxVotlsOoekGB7Uf3?=
 =?us-ascii?Q?0KpaJsy6/mf+E+LW0FpRiCTpPCX0XiMJLhvtHozvpQBwqV+9TGR6xWXjbKIb?=
 =?us-ascii?Q?AgHTHgy9PZ8otUtxOm7LkDJ+8DXY1oSLgsMSPBRvNu54AnVnc4FaihIPpBKe?=
 =?us-ascii?Q?C6BlQbD5eFehqhyQZl0Q43Y+o/S8bxDJjH2SIBGBVTSkz8DPrkr8j1Ct/fBX?=
 =?us-ascii?Q?U5bnnLA5eimmuTD4pDZCt4oeTkK6M872U8lL2NLFrz/C7JPEdnupPtRoKX/i?=
 =?us-ascii?Q?hRQn7GeXvDj9ThOFquzYPNanr1EBeG83PsQykrI5rFM7/Ph1lhlrBaFyr6Tz?=
 =?us-ascii?Q?Jq8WnsTiF6t8WqOwY6C+CM63oyyeLpJx1HvFqWBsiy/QXF/pzXbgzK88o3bD?=
 =?us-ascii?Q?jcNUseNswvXPDaCseswPT9ChEaE8IuGgQ0Q1HjWT1l8PgNhds83zVZWQkJge?=
 =?us-ascii?Q?q8NY50iHkdWCC7e2munsOqpMgF2ZmDq7651sdrKdcR8kyjAkSa/I8KAaPux8?=
 =?us-ascii?Q?uxpZOZS3+BQ/+JgQi3M04YIFmiu/CON97s04gviRBVgl11YWpDvFv1yj1Ekx?=
 =?us-ascii?Q?z9piDX8zj6K/SZO9OpNLdRpcpP8l8VzuqPAd8aFqrUt4AtuyrNKrJwuS0QV5?=
 =?us-ascii?Q?+jyFX0UT8z6l2i/jWTumQ3aYxZS06EgLO2x9O3AIjEGBV5eK/oOQKgD5ajz5?=
 =?us-ascii?Q?HFPKyPBJadEJq17e3X5A3TU2E64b4rJJ2PwAkBS/VoYxq5/vPvnuKc/Ha2G0?=
 =?us-ascii?Q?yMbcMjYn3pC4w7z5SWEewH5RZpv7BpHOv17ZlnF/zvj8wI13/5Ev15ulxsil?=
 =?us-ascii?Q?HXYl7rYwDc9epRaFiO6o53lnu8/2acZlFdBEFb3DHywPSIp9EUvGjHJ9vCt1?=
 =?us-ascii?Q?6z7U210e/c3CPQOrn36vrR6r?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2gE+e8nSObt/suGu0nf0Y5h2ODwQBeTfgfHRd5vMSwtR50Ids1//k9llcB9Y?=
 =?us-ascii?Q?bwrMAgne0AfRKrRsX5EgJapKT2k3QqSG1U8Xoel5du39TFKiVIYNEUaJm6mp?=
 =?us-ascii?Q?gxf9mclDD+oZaHVL1elyfEl6IHwc/0svF+JzVLiU9Bl51Hw2Vs2IGwGIzy/I?=
 =?us-ascii?Q?9V5atnDuQRxpCqK+35ZJD+UHR0PCKZ02/7P0mvEpQrbOx1vuPLfWJaOtY4aT?=
 =?us-ascii?Q?MwyokYU5Te8FvNWmIw1bKdphkh3VRndVGitr8vHA1u+ghyabpJ/fVN3YUhaR?=
 =?us-ascii?Q?F3h1K6uBPWN48es1+pWLm+wVeHC9MipkpIuJFGkLx6cNAt5Y4VVKDkfgQnCd?=
 =?us-ascii?Q?3qU7wGHoIGCBJTEX/9F33QgykAKnCM/QpugG61A/bCMleuzHXzhg02Os1q9/?=
 =?us-ascii?Q?pJ3+u9TveE2WZm08RERql2BKwDYt4wZnF0bSPwhGxWze5b7HpCMVOkqZjplV?=
 =?us-ascii?Q?JH+GP/rL7XSem95v+R/PGEY+Cu5apDv8fuNO06tQImO2A82JTAD3yD+9MTVe?=
 =?us-ascii?Q?fELGJbnaEJaKiiXJLCeqhvJLCe8hOu99zM9bvgu/aaa7QMXYeYRGGt/+2UIl?=
 =?us-ascii?Q?z5bl9T955DCoLUMlXf1mb2J0e1TEoMYjnJ8gDHzFs/AZ+5v8CU4nA7Bpqf7m?=
 =?us-ascii?Q?oJ4EvQpFHMVmhwoyEtcj1i03QkQvIA5KjAQaK6XQUbNwmKnwYax4gOtyECY3?=
 =?us-ascii?Q?odDYs9cRWmyhkmH4qwV7rk7D+7ySP+7RpHB5GpaICcRmm5PCt2452Mc5RN59?=
 =?us-ascii?Q?tuPe9hdSE8ccdqJ1OVriZ+6PqnnB6H8zisCycg9linFlgC9Bd75u+Idn7mi3?=
 =?us-ascii?Q?pl8HtFl6hssaElk65ACpgOJ6VwvTxrvFpdlfdSMZNZsUJrMGOrKV0L5TTVoa?=
 =?us-ascii?Q?kXMpGhA3ie9RKXD9+8bktR744jH4UBVaHTiNvVyPxVhivRZ7yCrFEK+aZFB7?=
 =?us-ascii?Q?0a/gRWuTkrhcMOmP5yzLkhNZBu846S3/aKSWht3tsfJxFS7fJtXao6Znsu4L?=
 =?us-ascii?Q?8Tst/xIfmZY3pO8k2G4377rV/rmGnGrJh5Nyp02XFz9KAWa1s0pyFrkm4WJN?=
 =?us-ascii?Q?qWCzxabBqS/eERkOFkDwLgiSlXelyCpJ4bqBwZiaPUu18MB75z+rL3+jf+cF?=
 =?us-ascii?Q?iJxlOiMKJg0hdQfvesbZ4s3jL36Nz6m9K5pBgj+D7JNYeNVf4AOZK+hFuFq/?=
 =?us-ascii?Q?LVsSYpItVftg9XvWEKW0Vt1v3Z19BKo5ax54vdts/eLQgQHi1q3mKqm83ocx?=
 =?us-ascii?Q?Cnn4lwJl4S5OtndZqDh8UAYzMPqmF435UJhtR9Lk5RFt6WGH4ZsQC3nx8KHk?=
 =?us-ascii?Q?iYXaOS2h/1jkNcPaojVJ0g9pxrLZwEBSfMQbBMHt6PS+mRkbvqKzzRpkNRhk?=
 =?us-ascii?Q?AUsRTI9dCVDDR8HbpVl80tUMC+3ap9tO54StUD4pJCo+BihbjOWk7tYw428F?=
 =?us-ascii?Q?VCP/LlojyxwSs1NG9iXqcvn+msppr0TkZO0EWpfWtbyS3x89V5Ho95qGUSBv?=
 =?us-ascii?Q?WRUEFtFWNO+pUHJwTGiCyraMApiD3a0q4foVm62TgDTHIb2aD72unrWuD6kj?=
 =?us-ascii?Q?sjqOjmg4aQEeeotQjl6XDrpb2yPQWFcOUPsCeCz0HdeSP/vbLrzx2FHlRQ7t?=
 =?us-ascii?Q?YScSNH9QBjdqwEiayzT5vLaKKO1hraIwkW9EhU6IPkOKStLR4BM3DupTed9y?=
 =?us-ascii?Q?Rhn97g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DJLIKZUiyiX8zxlZCPxUmJv4ewZQw0qgqP0H+vjAzUwlLjT0uDW2yhZIzKVKqmOaBmsAci2J8/aFyfqT8XYgasehWoBNI29js9KiYHJcWOIYRbZRVNSP010Bi60ObqenRR0G/R5JB2XHhqoema5eISutm9eTm4mq93sd8OJB/m5sPcwGciu0MYpGumsLkkwR21vLQaiW/MS0BAFAJp3m8acylx0zQvFt8HyMGHfqu+rUDPAQ4Teia2V2Hy9BYrqOPpu+WNOn1+4ClHN20pafFz7IgYH9iO3Vwp1hOoIyTleV682uDG4M1dTIglTpnGuD+DWEG2Huojo3dhg3iEILtkj30TFt+UCmcc57LiZwNZ/Iox1nbQJ9qJzjznj1E6yOgsdknTpxqMm2IBq4m1TLSnsi8yoxQ0DXW1F01G7P9p7738lPKvot2zi7LgxCjSLHx5cs9g126vREIJA2zjDnfpgzL4S+UaFS006q3JDoVMPVJ6ZrrorztSsbHmOr2oxUIRlJ5b3xZskkMaKsJn4NKYgP45M7SrBYAtt/bUrwcLqmHGzKqxKWtYcb2nROyLBvimRlhUwXkxkgmYbOuBZpbo/IuTXZ+M4/0Zyys3SA87o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41598306-88f6-4e39-5526-08dcf2d9e40c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 20:41:22.9831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8SD7InpWsUJAjLH18KUButYk6O1qgTWTPfBUGJtAc2m3eoP+4pSJuDZlQl8Nb7EZLzjlrCOlc2ZTXlGe9+Yg6CyXPs+bsRgO1UJ0Iy16JI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7437
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-22_21,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410220134
X-Proofpoint-ORIG-GUID: f9GLMFmV_wR4uE2WylsAauF2AlkWZZRf
X-Proofpoint-GUID: f9GLMFmV_wR4uE2WylsAauF2AlkWZZRf

Add some additional vma_internal.h stubs in preparation for __mmap_region()
being moved to mm/vma.c. Without these the move would result in the tests
no longer compiling.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/vma/vma_internal.h | 106 ++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 1 deletion(-)

diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index c5b9da034511..bec50a8c846c 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -44,7 +44,9 @@
 #define VM_LOCKED	0x00002000
 #define VM_IO           0x00004000
 #define VM_DONTEXPAND	0x00040000
+#define VM_LOCKONFAULT	0x00080000
 #define VM_ACCOUNT	0x00100000
+#define VM_NORESERVE	0x00200000
 #define VM_MIXEDMAP	0x10000000
 #define VM_STACK	VM_GROWSDOWN
 #define VM_SHADOW_STACK	VM_NONE
@@ -53,6 +55,14 @@
 #define VM_ACCESS_FLAGS (VM_READ | VM_WRITE | VM_EXEC)
 #define VM_SPECIAL (VM_IO | VM_DONTEXPAND | VM_PFNMAP | VM_MIXEDMAP)

+/* This mask represents all the VMA flag bits used by mlock */
+#define VM_LOCKED_MASK	(VM_LOCKED | VM_LOCKONFAULT)
+
+#ifdef CONFIG_64BIT
+/* VM is sealed, in vm_flags */
+#define VM_SEALED	_BITUL(63)
+#endif
+
 #define FIRST_USER_ADDRESS	0UL
 #define USER_PGTABLES_CEILING	0UL

@@ -698,8 +708,9 @@ static inline void tlb_finish_mmu(struct mmu_gather *)
 {
 }

-static inline void get_file(struct file *)
+static inline struct file *get_file(struct file *f)
 {
+	return f;
 }

 static inline int vma_dup_policy(struct vm_area_struct *, struct vm_area_struct *)
@@ -920,4 +931,97 @@ static inline bool signal_pending(void *)
 	return false;
 }

+static inline bool is_file_hugepages(struct file *)
+{
+	return false;
+}
+
+int security_vm_enough_memory_mm(struct mm_struct *, long)
+{
+	return true;
+}
+
+bool may_expand_vm(struct mm_struct *, vm_flags_t, unsigned long)
+{
+	return true;
+}
+
+static inline void vm_flags_init(struct vm_area_struct *vma,
+				 vm_flags_t flags)
+{
+	vma->__vm_flags = flags;
+}
+
+static inline void vm_flags_set(struct vm_area_struct *vma,
+				vm_flags_t flags)
+{
+	vma_start_write(vma);
+	vma->__vm_flags |= flags;
+}
+
+static inline void vm_flags_clear(struct vm_area_struct *vma,
+				  vm_flags_t flags)
+{
+	vma_start_write(vma);
+	vma->__vm_flags &= ~flags;
+}
+
+static inline int call_mmap(struct file *, struct vm_area_struct *)
+{
+	return 0;
+}
+
+static inline int shmem_zero_setup(struct vm_area_struct *)
+{
+	return 0;
+}
+
+static inline void vma_set_anonymous(struct vm_area_struct *vma)
+{
+	vma->vm_ops = NULL;
+}
+
+static inline void ksm_add_vma(struct vm_area_struct *)
+{
+}
+
+static inline void perf_event_mmap(struct vm_area_struct *)
+{
+}
+
+static bool vma_is_dax(struct vm_area_struct *)
+{
+	return false;
+}
+
+struct vm_area_struct *get_gate_vma(struct mm_struct *)
+{
+	return NULL;
+}
+
+bool vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot);
+
+/* Update vma->vm_page_prot to reflect vma->vm_flags. */
+static inline void vma_set_page_prot(struct vm_area_struct *vma)
+{
+	unsigned long vm_flags = vma->vm_flags;
+	pgprot_t vm_page_prot;
+
+	/* testing: we inline vm_pgprot_modify() to avoid clash with vma.h. */
+	vm_page_prot = pgprot_modify(vma->vm_page_prot, vm_get_page_prot(vm_flags));
+
+	if (vma_wants_writenotify(vma, vm_page_prot)) {
+		vm_flags &= ~VM_SHARED;
+		/* testing: we inline vm_pgprot_modify() to avoid clash with vma.h. */
+		vm_page_prot = pgprot_modify(vm_page_prot, vm_get_page_prot(vm_flags));
+	}
+	/* remove_protection_ptes reads vma->vm_page_prot without mmap_lock */
+	WRITE_ONCE(vma->vm_page_prot, vm_page_prot);
+}
+
+static inline bool arch_validate_flags(unsigned long)
+{
+	return true;
+}
+
 #endif	/* __MM_VMA_INTERNAL_H */
--
2.47.0

