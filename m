Return-Path: <linux-kernel+bounces-376940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9242F9AB7D3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C512836D1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C161CDFC1;
	Tue, 22 Oct 2024 20:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lUsgi4Ly";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lbH5GsFw"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D821CDA3A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 20:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729629706; cv=fail; b=QYhSIzo3cPW4/KYk1bZlkJ2oWN0MGUQ9OkSo1/9QiLGBJG+MeYpBSBYEMtiEMVMpFsiEzPxM3Vq5XoRthcmCssOWhfvlWS8L4Z0jH2yOqzS/7Qqlky5ftnKL6xLjTF47b873DseywN5chSWGGPbsvEOgfT35I+hBCK8/ckikg1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729629706; c=relaxed/simple;
	bh=UFR570+7lWgU2R9rqljhTWrjnz/apipw7WXakhB0wXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AfUF6gKB+OE3F7eCLxdrO84P37a/PpLyLpTsvrbOzXiXYGYudEX7RfBxBO7H86KURyKECeM9ZDv/vQD8Fn+u8vHVW4gbvTrdiaPm7e1T1SMKkCiwb4ij/2Bgjod1oxHiN1j7Xh1g32bVLJIPi55b1I2Os5s3Y45TalW97zS2Spg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lUsgi4Ly; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lbH5GsFw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MK3Xjd022857;
	Tue, 22 Oct 2024 20:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=yCK8Nyvg2JGUKvD2t+3bdnTb0tis8I4rLlCnKTQX+/8=; b=
	lUsgi4LyKBE3aZPyUNIeryeuBekwLW1VbIC1L0M3CQ0O722OlDLyXJkvD/3KeMdm
	ayc6BGn4aVxPrYDLJ3nybaXJgqOOqHza9sWdBHYe0BK5cWDWm+IK3w9XT8+VmPi4
	hSckP+Aaihg29akkzVe/v8w/Fe8w828H8IWXvuOcGDsTKclQ4FYfhpg9dFycpPnT
	TaYMHJP6sQd0zFrospyG7gC+CHVPxvwJhvjNN2yuPIPcLzt00T2tLWuKHPRzGT+Q
	aPwl6Z+W/I0AfLXw1SznTdd3d3e/MVcyCiyFExqEoGUbf7WiprFuVTrELobrjp7U
	4Q9AHAVGOPGj8UncFJ0sTA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5456qu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 20:41:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49MJL6AN011963;
	Tue, 22 Oct 2024 20:41:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c3780peu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 20:41:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZGm0fVkamId52zWloPhuDTAx1oWI1wjGbs6Wg8+bjqEMCkHmy9Ym9IZb6STPx8oHnStyqxi+Whb9cDbdZgBhslxf805zOkqA8L2zxlpAyZh/DAQ7VqFoj1qTlhAtibo4pSHLCNbHZMY4TvWgnKgiY4BZGOOZFqPn/v26bT16ORhew+FvXkgrgOewiGRmaQdh0WYQqRdSeVwwfMODmWkADHjk2xRnwv0A4ZymgknKHA97TQBgDtIzBjhnmp/RjwqJUTnDZgBuSHBw55MLxg/sCdzTKghtv4u5zE4AC9YGurtRdz020ES8E/aJ2sOSqQ0YU+WiyuId2u76KpxDL/U7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCK8Nyvg2JGUKvD2t+3bdnTb0tis8I4rLlCnKTQX+/8=;
 b=artAZW/Hy/lzM8HJoFi1Bzq3qZCpdrOSFFxljl/+hvh+NBukPJvEVJEj6qrR/7bF9NWm4fEEBn0DyMm0k2yBqjZ0/W5/r9wKMwYeNqPEZU+Nm5+QW+ZojVzsJ7lj/u/iPlcVmZOiDbQM27zpgensjEwskpMkpnf2XV3LV2BURWbXxh/OBAz9j7uH7R/icHskHdGGYf9JnkXGfXRczn6o/62hr2JhC6GsO2WlK8iRvl5xoz7/4NYoThpNwkJnEw6sgKHbG8voONLtD+E8izj8MG7bi8KeCLNhrScU51HQV84dkWnylLmCksXl4F1s4xAtYK1BZsQs4X09Jh36knxiNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCK8Nyvg2JGUKvD2t+3bdnTb0tis8I4rLlCnKTQX+/8=;
 b=lbH5GsFwHF9IYVdFa+1UdwIDdO025LzdQq+ljSamxoe7b87dttcFkABn8FX7oVI2z5s1Gm/oYh7nYNk2RJner3Ca+XzsNFuXVYA5QhyMStBJxpXkaPqa82yDSJwGnaHixmuLQnxf/suoE0bpd6LeGrCJmBAYUqK5YfNXC654KRs=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH0PR10MB7437.namprd10.prod.outlook.com (2603:10b6:610:193::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 20:41:19 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Tue, 22 Oct 2024
 20:41:19 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH hotfix 6.12 4/8] mm: resolve faulty mmap_region() error path behaviour
Date: Tue, 22 Oct 2024 21:40:55 +0100
Message-ID: <3bc3ef7520eed73472f7ffdce044f2e94f809b32.1729628198.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0633.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::20) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH0PR10MB7437:EE_
X-MS-Office365-Filtering-Correlation-Id: 6427b3a2-45ed-45c5-8092-08dcf2d9e218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eKQHymW4Tni8S9JfPECtWQ6HVnVEEwobYTGghi8q/EaHho15cVfQvxzRS8Dg?=
 =?us-ascii?Q?qXpuPqYuJAqS83A35NCQ6VJhmwda0Micy3/BuRlyMt1l3gYDV2Y0KGo2UjtM?=
 =?us-ascii?Q?S/pbA57cTh196L/JYzYtXXYrgJ91yeAt4pQq5rTWIlWOF6sdy3H8Bk2tRubN?=
 =?us-ascii?Q?5jAx5O9TmNXIuWle6gvfhAoA/z2XlCq1BWIiR8ybVW5dD/rFClyuCNGjJo3l?=
 =?us-ascii?Q?RFP2aQtA6oD9BPRVjxRl2Qtjsw3FGRuZlY0rk92rYT1Heg+aUwCH7UiMmRzZ?=
 =?us-ascii?Q?iPaRxXA1j8G8peThIAl3YGSYKLgcPjOG09m61T+tv48Hpt5UeHuUjp4gAdko?=
 =?us-ascii?Q?qNkQCjoRxVCg4oF769gvhono3Bp1rwc+60awg8V+ruAiIqEvBs9Hza9fA9gr?=
 =?us-ascii?Q?6J2h+r3ukP5TC0nY1lJD66+8LKpL5ax0191yeJPKDtTo3oWvEq1nVV+s7fmW?=
 =?us-ascii?Q?Dun1DqAD/9UTA0gBswt6d+swny2tX2hawrHNqQzXqHQ0PTbsI5HAHIf4PPzY?=
 =?us-ascii?Q?0rf2+owo74+ya6plGSjqf6ShA0j6MtVMUYC379izs+ZpJT9CdAGQ9KPqIn7M?=
 =?us-ascii?Q?uu4e3X9uKce+fN5qjEmAq0rfZSqvE4EVPIkXsLRFihM5F5EL1ZcGAnfb3m2H?=
 =?us-ascii?Q?+ghLNbJdjuxPYVKLsb8bN5MS5uzB0nEW4nuT/to2tAu9+Gb+r6ZKxFTWd4v/?=
 =?us-ascii?Q?eshG08MHHefN3UlMyne204bcD0wObeBYW3ZZSL7XzHUuxuoTlVxbRkdNvEZv?=
 =?us-ascii?Q?6qKxUnq5I3ZzUEwu3icYiNWeu70x8Pfb+i0OOy5JJoPNl089NPi63WAjvIjW?=
 =?us-ascii?Q?7UmF4SxbORTHkJLKM+yrcuhfQyoYVeCLjUHBkzNnZ1v25f3mlMQzZKqGfYAw?=
 =?us-ascii?Q?2K6PetiohY0YmDD8R2ROKZgeTbAlhfd+yJKuC/ar3A16Pl1CDdlzZQ08R3nc?=
 =?us-ascii?Q?VhDcJtIhRQZ0K3UVlw7rBffmYrkaH4O0Jiyg64i2eeVzVBVHi3T7lloP7ewL?=
 =?us-ascii?Q?C24NcHZZkHJqaDO2UZoFKK4OXsgs5s0ghnaKs9AD9p/y/D/+qCzZ+Jl7V5CI?=
 =?us-ascii?Q?lGI2AI4lHkb6YZ94kRDQomwUZZKCteWBBnt7UIAXJWwyMhqa1dLHQi+77Ngr?=
 =?us-ascii?Q?myKk2rU4lmo39qJjWaBtIwQX/wOBU5zl9nyPAnTFy1miicIbOPfEBf1qBjSH?=
 =?us-ascii?Q?Hz2SB1a136iO7Ntn4H5zTd7MgacVidD4EXtCEuSIfMN5+o4HIVRo85DJ+GDG?=
 =?us-ascii?Q?3Ma1O17YUPHnRXBnTAc+nGp8Mvbp7yxjvJJzyUdgOAZ5DOJbC4fQIx124IFA?=
 =?us-ascii?Q?wZ1qAO6POhamQ2hE5oYBWzO7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KwoFQ5PGL98qQ7xrRYK1DLKI5Rt7treR0GznHboc7d+ItlODxeScuv6QXRqh?=
 =?us-ascii?Q?fdMm9T+cACiBgyZfzAcg0FecWM2enbEHw7hdVe5FOrTHhJvuzhWDN1sYLAQi?=
 =?us-ascii?Q?hXF2Rha6xLtsMccQzvJ3SSwrT9BrLFX4kwj/P/xlaRO5gZQTjMIVHkfhYlvY?=
 =?us-ascii?Q?NsxI9hd5FmbY3y5Qot2K8PGevowOwhDYeCpmUziy0KIHr/ctVAjkWf4EJa49?=
 =?us-ascii?Q?XeQIZ25EbeCHRIhvJCijBl858FcXC1wq7jHEtYAFOUiL8lWsaYh5UqOdJaQ6?=
 =?us-ascii?Q?Ui28mqyXLVOnNmOPpXlLBE8qcqRcDn/jIw58WWlwl+yOZy2hJgxF393sepvG?=
 =?us-ascii?Q?qV6D1T34EvfhoL76GiYT34FpTss9YKOTor20IewxymQ7j/x31zZhO/AxZmxf?=
 =?us-ascii?Q?L6DZCbpEMPFvLKSErM1fNcbshxfyqIUYbt5zAKUdp2/7Z3MEwuF6REu0z8re?=
 =?us-ascii?Q?EDW7DmErAfS8x0XZ9+AO9T1cdiTK3v+hRdAhxmJzSsB/wtxG6vX14l421br9?=
 =?us-ascii?Q?mO59kWu+ANB+3vnD75kOBG9xj2VUG0lQx8URcc/b7XomxsD6EqY6Pqt1TJLM?=
 =?us-ascii?Q?Nkho0VdQxjtejOPf3I2i9VZe+70r0Xz7vgd2Rpo9dR07GqWUYoMW9PBixurd?=
 =?us-ascii?Q?obzLNI+HkXO+Av84KW5VmGJZV/qR+HiVjsmK4bQepaIrca18Sk95u7L/0T8c?=
 =?us-ascii?Q?8nAcI9vUsHbfyPy7c9XBIahIme854qj77hUntHZCP4VwD8PZpd0fFIT+eee9?=
 =?us-ascii?Q?+PXIFuT4BB6N/nmU9Nle71pdTPZoTmKv+vTEaD54x3tCQFwfGRYr7pNNq0wv?=
 =?us-ascii?Q?1T+7R6yE3UCQkJIJ6jLdk2HoF5SAlSsXup7r/l03RdQ0LNE2L6lCsQrLYYFq?=
 =?us-ascii?Q?RZysyXJBUzEwZZjGVvzHkZSal/srqD6g/yKTMyZ5akv5gFwYOeftkUu3YffT?=
 =?us-ascii?Q?Rnj16E2iCDrl3xVae7nGVid5YYhF6YWpfnQlIfzv1ObOIeua/bW35TF7yr99?=
 =?us-ascii?Q?wQzRTwLuFrhqXNlk1Cn7T2Fd8kx3Cb9xfqjDurgF8GNocwriAnhWKL38X94q?=
 =?us-ascii?Q?m1wkJ3rJyWvJyKPXFiSp/nzcfBHaKq5K7Ggyd+TUUtZ8pYYqVTxhbhXOQyrT?=
 =?us-ascii?Q?MFjxy+KoFupBABvh0kRzI2itorj2B++rKLVLzDeFJumn+/TXPa0gq+CeI3Iv?=
 =?us-ascii?Q?eTKldM3v5GSEu637al3Dqp7rj6fYvn4BI5OK5nK5EKChzSLPUDF82VZdVIZQ?=
 =?us-ascii?Q?XXBZOGaJUocY9XKSN+vYDuo1u7xhrBgat148VAqdYlj0vtfIs8LSHRJmbx8A?=
 =?us-ascii?Q?VvqUn5khtqgegqDh3/p/r5SCwKjkzjwWdx8x1EJ4sjZd1zYeEMon9aDtTKCE?=
 =?us-ascii?Q?1nn0SMSzBgUUgDho0v+E5qqQxBzMZF5nRxuHwG4Q4g16D8VJYimtIxWNMVYp?=
 =?us-ascii?Q?h9J2CxT+WW6jxV4087Ye04xh95MDD7Ks8zXe1ofOPQLthP6+obnUmGRwjE73?=
 =?us-ascii?Q?u6o9NSmPfXVh+toENl5AyLQsBawrS8Lq/e0kAgLaoISzNMooSH3sPlBbhxqo?=
 =?us-ascii?Q?Dv0GbGnbeiMrtOIyz6xiA/S/Yrph1JvsGe8OK+/VG9W/uXhGeBuvwSEf2O2v?=
 =?us-ascii?Q?UfT+TuicBLR2aQq6VVAYSapeQpjR6IPHx0xMwI4MIrgET08VrS1BLRDvznbz?=
 =?us-ascii?Q?7Ge4ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BIWeL5MHZ6d6nahzchFqVJcoL4I/PIzHv5DxOVOHuz2cbpu3R4rOFk09s00qbH8FeDz+M2EGJaPKHE2plNyifpMU5eXCL2KN3iu5skqgz4IKBBlS0Gdfj4RJbEnbhH6kox1+jZOL/bda/bZSY81QTMMlTA8K4/+U92aU4UIzFYqVD1T7X/03O8FFRP5MhnkzBN3k8P313XjYW2Xx6zalbCc4LR8Yyaowel5kiMHL7owkMIotpeJF2izGrtboFUubvCPlmqBH0WgL5sTZZisadr9I5Vq0qQmW+wF8WeLHHGlOATiJ/danHlueCaD7xyK3nGQC8fkB2p8T38DKaSZiO8jN9e+yNyOy06efFMd3AHcv39NL9gEGLitHz8IXYBnyEW1BCzh59l+pEXTIPXqm36B1XTNjeLHc7NQAaH7MCocaIyiJWzcGtT2zmLrgRetnBhF4EgUks3QT0Fhf7WT7DuktX3Ojer5g0rowfX5iZztpbms4xSTsAW65aHfT+CQGmRHc8Q/zXmX3Q2WU6UWc2n3XgV1T5A2oufQSKo0CH3GFF0D+5LE7oa0VrE3qnj+G21LsmmphODJvn/xJqkuoKQg0l+zh+sgjrLA5Fdl1v9Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6427b3a2-45ed-45c5-8092-08dcf2d9e218
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 20:41:19.5753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DDXZ79c0ZXi1o+vanivQyNg+JbbksZcexj9T5gLMvbZ7pbgZiRxM4q+Sb9xy5IKofEX0KZsTGrOq/ztkq+EhAa71rUZSr2hJCNnf1AKXuIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7437
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-22_21,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410220134
X-Proofpoint-ORIG-GUID: 5g-7dUENjQSk1UQvQiT0UM6KKFOhrXLx
X-Proofpoint-GUID: 5g-7dUENjQSk1UQvQiT0UM6KKFOhrXLx

The mmap_region() function is somewhat terrifying, with spaghetti-like
control flow and numerous means by which issues can arise and incomplete
state, memory leaks and other unpleasantness can occur.

A large amount of the complexity arises from trying to handle errors late
in the process of mapping a VMA, which forms the basis of recently observed
issues with resource leaks and observable inconsistent state.

Taking advantage of previous patches in this series we move a number of
checks earlier in the code, simplifying things by moving the core of the
logic into a static internal function __mmap_region().

Doing this allows us to perform a number of checks up front before we do
any real work, and allows us to unwind the writable unmap check
unconditionally as required and to perform a CONFIG_DEBUG_VM_MAPLE_TREE
validation unconditionally also.

We move a number of things here:

1. We preallocate memory for the iterator before we call the file-backed
   memory hook, allowing us to exit early and avoid having to perform
   complicated and error-prone close/free logic. We carefully free
   iterator state on both success and error paths.

2. The enclosing mmap_region() function handles the mapping_map_writable()
   logic early. Previously the logic had the mapping_map_writable() at the
   point of mapping a newly allocated file-backed VMA, and a matching
   mapping_unmap_writable() on success and error paths.

   We now do this unconditionally if this is a file-backed, shared writable
   mapping. If a driver changes the flags to eliminate VM_MAYWRITE, however
   doing so does not invalidate the seal check we just performed, and we in
   any case always decrement the counter in the wrapper.

   We perform a debug assert to ensure a driver does not attempt to do the
   opposite.

3. We also move arch_validate_flags() up into the mmap_region()
   function. This is only relevant on arm64 and sparc64, and the check is
   only meaningful for SPARC with ADI enabled. We explicitly add a warning
   for this arch if a driver invalidates this check, though the code ought
   eventually to be fixed to eliminate the need for this.

With all of these measures in place, we no longer need to explicitly close
the VMA on error paths, as we place all checks which might fail prior to a
call to any driver mmap hook.

This eliminates an entire class of errors, makes the code easier to reason
about and more robust.

Reported-by: Jann Horn <jannh@google.com>
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Cc: stable <stable@kernel.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 120 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 66 insertions(+), 54 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 66edf0ebba94..7d02b47a1895 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1361,20 +1361,18 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	return do_vmi_munmap(&vmi, mm, start, len, uf, false);
 }

-unsigned long mmap_region(struct file *file, unsigned long addr,
+static unsigned long __mmap_region(struct file *file, unsigned long addr,
 		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
 		struct list_head *uf)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
 	pgoff_t pglen = PHYS_PFN(len);
-	struct vm_area_struct *merge;
 	unsigned long charged = 0;
 	struct vma_munmap_struct vms;
 	struct ma_state mas_detach;
 	struct maple_tree mt_detach;
 	unsigned long end = addr + len;
-	bool writable_file_mapping = false;
 	int error;
 	VMA_ITERATOR(vmi, mm, addr);
 	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);
@@ -1448,28 +1446,26 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	vm_flags_init(vma, vm_flags);
 	vma->vm_page_prot = vm_get_page_prot(vm_flags);

+	if (vma_iter_prealloc(&vmi, vma)) {
+		error = -ENOMEM;
+		goto free_vma;
+	}
+
 	if (file) {
 		vma->vm_file = get_file(file);
 		error = mmap_file(file, vma);
 		if (error)
-			goto unmap_and_free_vma;
-
-		if (vma_is_shared_maywrite(vma)) {
-			error = mapping_map_writable(file->f_mapping);
-			if (error)
-				goto close_and_free_vma;
-
-			writable_file_mapping = true;
-		}
+			goto unmap_and_free_file_vma;

+		/* Drivers cannot alter the address of the VMA. */
+		WARN_ON_ONCE(addr != vma->vm_start);
 		/*
-		 * Expansion is handled above, merging is handled below.
-		 * Drivers should not alter the address of the VMA.
+		 * Drivers should not permit writability when previously it was
+		 * disallowed.
 		 */
-		if (WARN_ON((addr != vma->vm_start))) {
-			error = -EINVAL;
-			goto close_and_free_vma;
-		}
+		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
+				!(vm_flags & VM_MAYWRITE) &&
+				(vma->vm_flags & VM_MAYWRITE));

 		vma_iter_config(&vmi, addr, end);
 		/*
@@ -1477,6 +1473,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		 * vma again as we may succeed this time.
 		 */
 		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
+			struct vm_area_struct *merge;
+
 			vmg.flags = vma->vm_flags;
 			/* If this fails, state is reset ready for a reattempt. */
 			merge = vma_merge_new_range(&vmg);
@@ -1491,10 +1489,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 				 */
 				fput(vma->vm_file);
 				vm_area_free(vma);
+				vma_iter_free(&vmi);
 				vma = merge;
 				/* Update vm_flags to pick up the change. */
 				vm_flags = vma->vm_flags;
-				goto unmap_writable;
+				goto file_expanded;
 			}
 			vma_iter_config(&vmi, addr, end);
 		}
@@ -1503,26 +1502,15 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	} else if (vm_flags & VM_SHARED) {
 		error = shmem_zero_setup(vma);
 		if (error)
-			goto free_vma;
+			goto free_iter_vma;
 	} else {
 		vma_set_anonymous(vma);
 	}

-	if (map_deny_write_exec(vma->vm_flags, vma->vm_flags)) {
-		error = -EACCES;
-		goto close_and_free_vma;
-	}
-
-	/* Allow architectures to sanity-check the vm_flags */
-	if (!arch_validate_flags(vma->vm_flags)) {
-		error = -EINVAL;
-		goto close_and_free_vma;
-	}
-
-	if (vma_iter_prealloc(&vmi, vma)) {
-		error = -ENOMEM;
-		goto close_and_free_vma;
-	}
+#ifdef CONFIG_SPARC64
+	/* TODO: Fix SPARC ADI! */
+	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
+#endif

 	/* Lock the VMA since it is modified after insertion into VMA tree */
 	vma_start_write(vma);
@@ -1536,10 +1524,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 */
 	khugepaged_enter_vma(vma, vma->vm_flags);

-	/* Once vma denies write, undo our temporary denial count */
-unmap_writable:
-	if (writable_file_mapping)
-		mapping_unmap_writable(file->f_mapping);
+file_expanded:
 	file = vma->vm_file;
 	ksm_add_vma(vma);
 expanded:
@@ -1572,23 +1557,17 @@ unsigned long mmap_region(struct file *file, unsigned long addr,

 	vma_set_page_prot(vma);

-	validate_mm(mm);
 	return addr;

-close_and_free_vma:
-	vma_close(vma);
-
-	if (file || vma->vm_file) {
-unmap_and_free_vma:
-		fput(vma->vm_file);
-		vma->vm_file = NULL;
+unmap_and_free_file_vma:
+	fput(vma->vm_file);
+	vma->vm_file = NULL;

-		vma_iter_set(&vmi, vma->vm_end);
-		/* Undo any partial mapping done by a device driver. */
-		unmap_region(&vmi.mas, vma, vmg.prev, vmg.next);
-	}
-	if (writable_file_mapping)
-		mapping_unmap_writable(file->f_mapping);
+	vma_iter_set(&vmi, vma->vm_end);
+	/* Undo any partial mapping done by a device driver. */
+	unmap_region(&vmi.mas, vma, vmg.prev, vmg.next);
+free_iter_vma:
+	vma_iter_free(&vmi);
 free_vma:
 	vm_area_free(vma);
 unacct_error:
@@ -1598,10 +1577,43 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 abort_munmap:
 	vms_abort_munmap_vmas(&vms, &mas_detach);
 gather_failed:
-	validate_mm(mm);
 	return error;
 }

+unsigned long mmap_region(struct file *file, unsigned long addr,
+			  unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
+			  struct list_head *uf)
+{
+	unsigned long ret;
+	bool writable_file_mapping = false;
+
+	/* Allow architectures to sanity-check the vm_flags. */
+	if (!arch_validate_flags(vm_flags))
+		return -EINVAL;
+
+	/* Check to see if MDWE is applicable. */
+	if (map_deny_write_exec(vm_flags, vm_flags))
+		return -EACCES;
+
+	/* Map writable and ensure this isn't a sealed memfd. */
+	if (file && is_shared_maywrite(vm_flags)) {
+		int error = mapping_map_writable(file->f_mapping);
+
+		if (error)
+			return error;
+		writable_file_mapping = true;
+	}
+
+	ret = __mmap_region(file, addr, len, vm_flags, pgoff, uf);
+
+	/* Clear our write mapping regardless of error. */
+	if (writable_file_mapping)
+		mapping_unmap_writable(file->f_mapping);
+
+	validate_mm(current->mm);
+	return ret;
+}
+
 static int __vm_munmap(unsigned long start, size_t len, bool unlock)
 {
 	int ret;
--
2.47.0

