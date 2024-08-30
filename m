Return-Path: <linux-kernel+bounces-309302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6829668B4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126351C219EA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306471BCA08;
	Fri, 30 Aug 2024 18:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J3gH5Zy1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RzqlTbDs"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CBB3DBB6
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 18:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725041454; cv=fail; b=HX+Ae38UkgtQKXZNGh6noP4fuRA45BjTcE7ouXBGXdBLjAXZjt1yQNEoF+Q8xvOmQu4nHV2OBw2ad9tm+0ZmZhCM7ksE5eCSA3y4ZfGtqBCpCXdgkoM+9t9gfVB/34uzn1WHtWoBRJRsbZmxLJxHc2Nab96ZxNzw/cRCyZDEr7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725041454; c=relaxed/simple;
	bh=iFIlWNCK93XfZ+G5gf3aZcLBvXc8S1IyBfsLJMUagN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UnFXXSztfv3LDE4pg/43rAMfskFqXL5rvqHF+vIdX3lKRNlAirmM0RGykhPVRp2uKF4PNoYaUA+evve7EsFTS4GVqZjcLDjdxnXBQMDCyZwzIe9hgYPOHvLTo0+Ly9vXPo8YXGtLfG2Gm3KWtbeFvTS9Ww8SrUgm1wHxn/INY2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J3gH5Zy1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RzqlTbDs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UI0Uls009282;
	Fri, 30 Aug 2024 18:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=YsJLW67TeMKdhBuCzJUurH+LeO0c1LX5e8yYyWk9Qko=; b=
	J3gH5Zy1Q31UQRFEF4BH5M0ZF5mTEi76gZSw4RVHa94HZHBtDjYOrcSPJCtJiRdL
	mjq6P7r/m4e+pZkmEvdvcUosPrsxw+CzyiWOhUZUHM4OmL8zNfRFlbTNXOEvxHr5
	c3UTHmnWZRwiXwTLI/Le9h2lsa5T35m+psBZwQHsKMq6cBPiB3tr5/1LZKBgME//
	+sh6KObCkPO407KmCabDPkq7ISJMlGkUfpn9uNloe1Yti4eWoXP5JGrfXGH62JW5
	fWMc5qIEgOaC9fRQIVh+fGS85K2hVZOBUs3Jk5ir5AhPQanRcD6E34fCn4HqhA4v
	GajYZoeuXVpJl+FEUhqDdg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41bfgj8gwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 18:10:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UI76Go035469;
	Fri, 30 Aug 2024 18:10:39 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4189sxqd6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 18:10:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFIfafXZxyAb/YxDY39zU2zsx0L3hVVmZfrUqw718K4vo96N3oH8WM6UwXLJ6R1wYsnicawxo4gpKaB8InkEP+rNU8O7/fLt2VMwhbLiR1SWRD9KbvrLV4kEqlWFaao3hE7lLZFj4Jex4Wp4oxaGQ2L5xIaZTab07omijE7uv3x20/NT7iGVr1V5xnEGvLkMHINGo9XjDz1wJBQOv/N1Hk2qfKZrpttu2tVXky6pugx2NluQKlgVBeMgdW5FPN6wWWhDy9McFWJdxRiGxS4db15BUs17mreckgeNBlwqrsKVF+efuJJuPflAs7TTQ8Kyi5Dqyz6gCoplkq0a9tjNEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsJLW67TeMKdhBuCzJUurH+LeO0c1LX5e8yYyWk9Qko=;
 b=feAJenkw9WOtcgUdBMi9lTlaSipxHS5r//Voa+YB/KSEuo50R/n+PVejYC75f3VEgOa7Rn0ZlsSKfuHYpDBVDCzl/RmDwS+1sDcE76uee24X5cPw60C0XUt+s+USbLbiXVqnBhTGazeehtQl/3X6b+TksAg4jCVLPk7+0G5acMkCGRKkbKLYmQN6rLyWUw54Dxd4wt6VlUxtB44MRLUnkSuHnwG7UlhkVrDBDlBhPpfAaIIgKDITiEKaaJpG4etXCihv5QbW3knlYOlQXH4j3EdVw8mWvYoRdBDzFbwlODs85kKTM+cTwWu1nOdloetCwqxnDNVUrgFKvEdskPQjJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsJLW67TeMKdhBuCzJUurH+LeO0c1LX5e8yYyWk9Qko=;
 b=RzqlTbDsdUP1saqV0OOVz0oIXC6lX1Hj7fJQ1sCW8s8SLmAKsqZbUi/s3RywWBhvmQkNagJKcKp76IUt/J+ZlMpvZKkRgnLgZC+rlqBnp3c3lcShZRzE/vOkeyG60HlXDyG4hPkIbLYKdB/6e710NuvOYa4IyfwTEhZeS0DcNr8=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS0PR10MB7151.namprd10.prod.outlook.com (2603:10b6:8:dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 18:10:36 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 18:10:36 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 03/10] mm: introduce vma_merge_struct and abstract vma_merge(),vma_modify()
Date: Fri, 30 Aug 2024 19:10:15 +0100
Message-ID: <a955aad09d81329f6fbeb636b2dd10cde7b73dab.1725040657.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725040657.git.lorenzo.stoakes@oracle.com>
References: <cover.1725040657.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::6) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS0PR10MB7151:EE_
X-MS-Office365-Filtering-Correlation-Id: d3b2237a-6a19-475f-9a1f-08dcc91f0bea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WLh0uC0HukfVAfFsPQS+Km0axPlCeH24ojUg3JCuzdt9BtY2kTBnvngj/ig4?=
 =?us-ascii?Q?DFD7SDYHFuWbQUT9cWw0fPll+q4OUNXQAO0aMn5+t9cwidDp0rugvFoG9ng4?=
 =?us-ascii?Q?Res33tTngbVG6/i+QxDlRbXTdUXrFakd1qZcyC4L+nprTgNTdfQSza+7aT0O?=
 =?us-ascii?Q?yrIGVY24xpq2V3HMh4CsgL5H8ZbXRnOKNvYRqJ6LiI/tv0mgPdTtM4aK+yoe?=
 =?us-ascii?Q?XidfRqm9Nxwiy9oifshqPUmzAJFXwWftA0+PC4O9VlseE92JpUPD7xb+p4xX?=
 =?us-ascii?Q?yXPuCqvkD+Bk71I4Su2g5u0BeHDVICMMY+m+Td4i+MzoDw4RJotQ5gmRa2RT?=
 =?us-ascii?Q?0c08a9n3FaJCdrEpnmNWS7TeSRnDWGGYizh+moyfAti40fdXGrJWeL6/JisM?=
 =?us-ascii?Q?mxOciBFrjhfFC3vmJI5Qb7ET85zlnj43nq8VTqNuPjk7yGiEMxuGmDll0xoA?=
 =?us-ascii?Q?lsCBtQg7gmVFFDpANB66yisDC5pXg+rNW6I7BSFjee4WPXQK2NI7CnTc5/Z4?=
 =?us-ascii?Q?dSopfTa1VWtlJ/E5O5SHVGQTnGTFAOqA0TN6lUbUpqvj00ZNceIS7gx8WeJr?=
 =?us-ascii?Q?pqS7md04K/spWqW6Fab0KJDAUC8QUKQQIS1yAduV2+9zonmkLsjp4547oT6F?=
 =?us-ascii?Q?dzKNhBMeT6TQJO/GcfNPSt6wuDTovKCAW7TJFbsvnZnbSdTfPHNdJrzKPq0a?=
 =?us-ascii?Q?1nyR7TWr6M9P+dJIRiT5czuGO1vrZGMNYqeXl0lg8p2Y1Gfb8NYGBpjfXIGj?=
 =?us-ascii?Q?LTSyAIBjRUagiurkUcaMqTC0ObAwRx51Mv72bS1x2LkqorT2mRLPvgxPIaDr?=
 =?us-ascii?Q?lxA2bh/Dy8D2KF+OjdniXKTP9rVYOo9TwLGJgJ+T0reHM6pEkNYZ1pjwAiLB?=
 =?us-ascii?Q?MSDxxuLbxL/JedUyWm0FhU2qVOwdsjWEPsPXijz8b5FDTX/ZXLYJfM5Vjj/y?=
 =?us-ascii?Q?5P906YVZM+bpTI/68ZjgbaxGBZwHNAifmLYL9KkmgTlGkb7rmxcI05o0055z?=
 =?us-ascii?Q?pbk96AC6xPe4a8evC4f1YAvbydyuiU0IeNDu6nxuKIQAOa7xoiGp3SgzemBF?=
 =?us-ascii?Q?F/638cmTxSZhE5ZwT6TWpnKHpslFupalsJwRSw3evSgPUyhjNHr7cxL5uoOX?=
 =?us-ascii?Q?J/hSULLDAoTTFq47916Xf3mZgLKjc0yzKktKSr9tz/HgnhWcc9MWbHAQ/a1X?=
 =?us-ascii?Q?a9YFMcewpNyJTSxD156bYIfx6ibUC7n4G2kl39PDP+oxZ/UaFjUqnjHi7A4S?=
 =?us-ascii?Q?10tBy112WoWAUpOxNoGDSzP/Bh1SSC4HbFA1MerCnGdJ+PP8zotsuKb1i6BV?=
 =?us-ascii?Q?da5N4+SUI3N7xExUaYmFfMU3uKcXEzHAiZISj9VYl+l7TA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ogSLszcFqu7nXkEOAxOqcEzQLIaY1BUOuU7SVBUiENylYUOaDM1Oxnojjujs?=
 =?us-ascii?Q?6l0kMEQ4tJG9H1dAfhOLDrDE2bTy86fwnfMGLAu2tu9uXT/bSoQ/buKXZGXJ?=
 =?us-ascii?Q?fL/OKkR7TUB/jeeHDqGtQMP2QvmraY2sD8uJpBkBytFKhVL3AnmgEvwYMk6+?=
 =?us-ascii?Q?6Gib7WnFkvIRUmV4monlI7P7jgSx092RRV8o55IK5459ix4QbzCrrTc+D6xz?=
 =?us-ascii?Q?nw5hz0EKcpE3DOC9ovsJv+5THrS8avLVS8u6JUoHWyPTqsejFRseOWW8WVHL?=
 =?us-ascii?Q?jzNpQjcA8BNyNmjTgUbYdORD5uj8f2zSLXZeXUhGQMFzKLX93gbjqXXcGvgZ?=
 =?us-ascii?Q?5MIbXZuOKjfCQxw3LRulhFQhNxz2ZnkjWg6WmIYKJ0zmZReYUjPOO4WY9Aa+?=
 =?us-ascii?Q?rIsSvZ9sJA3Urc55Mpf537aY9vOMgSz4/lmXEFSwDwJgwbYXb/DS0Va0Iu0A?=
 =?us-ascii?Q?BzZnRh7xBLzU61ufa+QW5YaPahR2J/pMBJnbDN6Wa+mEzSGARLN0Vp/vkWC7?=
 =?us-ascii?Q?pLfNv/2Axpvv1H/7WNN3YLn/jgm7V4TXGuCNog/LApP5de8vM+b08basptLr?=
 =?us-ascii?Q?gk/H0Ist360VSSl/6q4vHlW1Dgps17UHcX9gl/m7z8GngPmNzEorMxGmngZy?=
 =?us-ascii?Q?LmFG1DQXxj4sVNYyABMXi462bNH7VJgeE04UGwYh1nBCNpRULkdLmB/nm585?=
 =?us-ascii?Q?waxaYnPpnSsAgDwuaeTdXF4ONtTHL0OWAqpPai5dsB+fmcp7p80mn4gdMDpY?=
 =?us-ascii?Q?FDBiHAQhV+iKNIw7FtU/0+JUCd1ZBprM89XjU5UIbPZmEoK/Lhp3wmDYz5of?=
 =?us-ascii?Q?mOB9LQv/d15YAoQLbt0pX1a4zBTp0OLOIXHkRhoUChL6Iqqbo7TSFmqLJDrP?=
 =?us-ascii?Q?19AmI+EUXQ/YL99B4klxBk/oRPDjw6C5dARvyn3kbIfNGSjprKe+29rIzy40?=
 =?us-ascii?Q?kOpf5uQ5d9+onVfzpUd1qW+0mYnzhdOtYodcultlJY8EN4lCMduLQFvjnNVK?=
 =?us-ascii?Q?MEO+ULfGTkm/Z6DHIqrdRNzT9xRiXyBKE+g5Ced7khNm7sQJLV5OJcTo9MD9?=
 =?us-ascii?Q?44g0qg9dSkyqIzLzbNAeuvF9kUztlQewe1U6e1fDnPHw9pwxPmY85gw4koQm?=
 =?us-ascii?Q?WnERJtp5Y6HD/TV36exZ9WzhsT1zrQv3EDbdHx5tX543DpceXEBGjRVcWjld?=
 =?us-ascii?Q?0IoFr9oz9dVUewKMxTv6Y51YV277WHoUUsZcFi3WR2Y+ng72WZZ80lLa/ce9?=
 =?us-ascii?Q?EecYcbDTWSrLPsyuB07d8FYdQX3KYhAVlk40rXKlu184xoZHRlmg389S8YqZ?=
 =?us-ascii?Q?UKLoGKkRqOOVMdFoXp92gGieRj42u1jU4sVbkOSkC+epqCZAloXQ+f1drUMW?=
 =?us-ascii?Q?Hrwh1iPEDesLvfcbjfaODPYLkzFbxxNnaAElNy/svto7Sv5cl60TUlYA/ixk?=
 =?us-ascii?Q?+4Ctyj9nBwVUW/bm9mlQYiS0Zje5ipRxF/AzLM9t7rNW6PIdtvcmaSCXKMay?=
 =?us-ascii?Q?eA0j/eoXiyCWGvUNxZCd4w6p+n52UQH/PPRcGmVq1s9f2F7YDlHu+WPp1P4i?=
 =?us-ascii?Q?EdBD0FlJInX6vD+e3X/gm3b6S3K3lz6ObwaFcmV+nHXeV3nImv/xpGbOygfG?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bawcVu5+ChWuvgH/815LunyrpfMdzpCmltbb3vREjbQfG+dDi5o4amdHQBsCwvgIHBb7dGyQTPIN8+8CHO3bzVyRE2rXUuvWhisD1s9AXJU6pzQ+iu08WEJ2+VH8MRuYfVZO3pXui/wA9M5Gs0tlaEgumfzMXNVZyd/ej4cfD2UMRgcTS9hneaUqvr5xXIRSR3Q4akFaAXAOXYu1af34hlOkdAoad4qDl/2RVcj+Pl65hccB/O/FLmFHI15PeBsG2AmEqZ8BzLhwRxrCzPdVH2Dv6f7aBuTUlJmvS/NrbpPeF1oV1xnpsBRdDPCUqETvP1NgSjRK2bG4DKbGScWGBHlDkFbv7fDu/cJap8MEKJEY7KiYEloKVBmjCVtgrz+7nTuPvb04xNNsmrAZ9gh6C9xwrM0Rb/VAj1O1e/8y+loazuXgNlHuNt8XWoEUB8ag26i6CuAm5O05LZHU6driOXkY3QAKDa3a/5FKV1ySUacVb16FwJGw6PiYm1TsF9Zq5WLA4MbiyQYiYGZlGX5CiHxsTzLnFqTm59upFWieDUedg18Sij9etT9qfOkWyyB68lnVUsoYl3JCVah/WZlxtMYShoptMwYCFpRDlzT+ZYc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b2237a-6a19-475f-9a1f-08dcc91f0bea
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 18:10:36.3116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JHMxZYf40mF7BzVS89XSqeLRV3L1+qX/513kkS/XPtV4ajH6dd4Yq1YFY9ybYwrt1xwV+oxdoU5jrdc/leYupKRho/bm3F7EIjrxxbWyHWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7151
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300138
X-Proofpoint-ORIG-GUID: e5k0Mtf0kjHD0mJhiSsm3OHs5wkPRxtM
X-Proofpoint-GUID: e5k0Mtf0kjHD0mJhiSsm3OHs5wkPRxtM

Rather than passing around huge numbers of parameters to numerous helper
functions, abstract them into a single struct that we thread through the
operation, the vma_merge_struct ('vmg').

Adjust vma_merge() and vma_modify() to accept this parameter, as well as
predicate functions can_vma_merge_before(), can_vma_merge_after(), and the
vma_modify_...() helper functions.

Also introduce VMG_STATE() and VMG_VMA_STATE() helper macros to allow for
easy vmg declaration.

We additionally remove the requirement that vma_merge() is passed a VMA
object representing the candidate new VMA. Previously it used this to
obtain the mm_struct, file and anon_vma properties of the proposed range (a
rather confusing state of affairs), which are now provided by the vmg
directly.

We also remove the pgoff calculation previously performed vma_modify(), and
instead calculate this in VMG_VMA_STATE() via the vma_pgoff_offset()
helper.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c               |  76 ++++++++-------
 mm/vma.c                | 207 ++++++++++++++++++++++++----------------
 mm/vma.h                | 127 ++++++++++++++----------
 tools/testing/vma/vma.c |  43 +--------
 4 files changed, 246 insertions(+), 207 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index fc726c4e98be..ca9c6939638b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1373,10 +1373,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	unsigned long end = addr + len;
 	unsigned long merge_start = addr, merge_end = end;
 	bool writable_file_mapping = false;
-	pgoff_t vm_pgoff;
 	int error = -ENOMEM;
 	VMA_ITERATOR(vmi, mm, addr);
+	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);
 
+	vmg.file = file;
 	/* Find the first overlapping VMA */
 	vma = vma_find(&vmi, end);
 	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
@@ -1389,12 +1390,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		if (error)
 			goto gather_failed;
 
-		next = vms.next;
-		prev = vms.prev;
+		next = vmg.next = vms.next;
+		prev = vmg.prev = vms.prev;
 		vma = NULL;
 	} else {
-		next = vma_next(&vmi);
-		prev = vma_prev(&vmi);
+		next = vmg.next = vma_next(&vmi);
+		prev = vmg.prev = vma_prev(&vmi);
 		if (prev)
 			vma_iter_next_range(&vmi);
 	}
@@ -1414,6 +1415,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 		vms.nr_accounted = 0;
 		vm_flags |= VM_ACCOUNT;
+		vmg.flags = vm_flags;
 	}
 
 	if (vm_flags & VM_SPECIAL)
@@ -1422,28 +1424,31 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	/* Attempt to expand an old mapping */
 	/* Check next */
 	if (next && next->vm_start == end && !vma_policy(next) &&
-	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
-				 NULL_VM_UFFD_CTX, NULL)) {
+	    can_vma_merge_before(&vmg)) {
 		merge_end = next->vm_end;
 		vma = next;
-		vm_pgoff = next->vm_pgoff - pglen;
+		vmg.pgoff = next->vm_pgoff - pglen;
+		/*
+		 * We set this here so if we will merge with the previous VMA in
+		 * the code below, can_vma_merge_after() ensures anon_vma
+		 * compatibility between prev and next.
+		 */
+		vmg.anon_vma = vma->anon_vma;
+		vmg.uffd_ctx = vma->vm_userfaultfd_ctx;
 	}
 
 	/* Check prev */
 	if (prev && prev->vm_end == addr && !vma_policy(prev) &&
-	    (vma ? can_vma_merge_after(prev, vm_flags, vma->anon_vma, file,
-				       pgoff, vma->vm_userfaultfd_ctx, NULL) :
-		   can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
-				       NULL_VM_UFFD_CTX, NULL))) {
+	    can_vma_merge_after(&vmg)) {
 		merge_start = prev->vm_start;
 		vma = prev;
-		vm_pgoff = prev->vm_pgoff;
+		vmg.pgoff = prev->vm_pgoff;
 		vma_prev(&vmi); /* Equivalent to going to the previous range */
 	}
 
 	if (vma) {
 		/* Actually expand, if possible */
-		if (!vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
+		if (!vma_expand(&vmi, vma, merge_start, merge_end, vmg.pgoff, next)) {
 			khugepaged_enter_vma(vma, vm_flags);
 			goto expanded;
 		}
@@ -1774,26 +1779,29 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 * Expand the existing vma if possible; Note that singular lists do not
 	 * occur after forking, so the expand will only happen on new VMAs.
 	 */
-	if (vma && vma->vm_end == addr && !vma_policy(vma) &&
-	    can_vma_merge_after(vma, flags, NULL, NULL,
-				addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL)) {
-		vma_iter_config(vmi, vma->vm_start, addr + len);
-		if (vma_iter_prealloc(vmi, vma))
-			goto unacct_fail;
-
-		vma_start_write(vma);
-
-		init_vma_prep(&vp, vma);
-		vma_prepare(&vp);
-		vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
-		vma->vm_end = addr + len;
-		vm_flags_set(vma, VM_SOFTDIRTY);
-		vma_iter_store(vmi, vma);
-
-		vma_complete(&vp, vmi, mm);
-		validate_mm(mm);
-		khugepaged_enter_vma(vma, flags);
-		goto out;
+	if (vma && vma->vm_end == addr && !vma_policy(vma)) {
+		VMG_STATE(vmg, mm, vmi, addr, addr + len, flags, PHYS_PFN(addr));
+
+		vmg.prev = vma;
+		if (can_vma_merge_after(&vmg)) {
+			vma_iter_config(vmi, vma->vm_start, addr + len);
+			if (vma_iter_prealloc(vmi, vma))
+				goto unacct_fail;
+
+			vma_start_write(vma);
+
+			init_vma_prep(&vp, vma);
+			vma_prepare(&vp);
+			vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
+			vma->vm_end = addr + len;
+			vm_flags_set(vma, VM_SOFTDIRTY);
+			vma_iter_store(vmi, vma);
+
+			vma_complete(&vp, vmi, mm);
+			validate_mm(mm);
+			khugepaged_enter_vma(vma, flags);
+			goto out;
+		}
 	}
 
 	if (vma)
diff --git a/mm/vma.c b/mm/vma.c
index 1736bb237b2c..6be645240f07 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -7,16 +7,18 @@
 #include "vma_internal.h"
 #include "vma.h"
 
-/*
- * If the vma has a ->close operation then the driver probably needs to release
- * per-vma resources, so we don't attempt to merge those if the caller indicates
- * the current vma may be removed as part of the merge.
- */
-static inline bool is_mergeable_vma(struct vm_area_struct *vma,
-		struct file *file, unsigned long vm_flags,
-		struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-		struct anon_vma_name *anon_name, bool may_remove_vma)
+static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_next)
 {
+	struct vm_area_struct *vma = merge_next ? vmg->next : vmg->prev;
+	/*
+	 * If the vma has a ->close operation then the driver probably needs to
+	 * release per-vma resources, so we don't attempt to merge those if the
+	 * caller indicates the current vma may be removed as part of the merge,
+	 * which is the case if we are attempting to merge the next VMA into
+	 * this one.
+	 */
+	bool may_remove_vma = merge_next;
+
 	/*
 	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
 	 * match the flags but dirty bit -- the caller should mark
@@ -25,15 +27,15 @@ static inline bool is_mergeable_vma(struct vm_area_struct *vma,
 	 * the kernel to generate new VMAs when old one could be
 	 * extended instead.
 	 */
-	if ((vma->vm_flags ^ vm_flags) & ~VM_SOFTDIRTY)
+	if ((vma->vm_flags ^ vmg->flags) & ~VM_SOFTDIRTY)
 		return false;
-	if (vma->vm_file != file)
+	if (vma->vm_file != vmg->file)
 		return false;
 	if (may_remove_vma && vma->vm_ops && vma->vm_ops->close)
 		return false;
-	if (!is_mergeable_vm_userfaultfd_ctx(vma, vm_userfaultfd_ctx))
+	if (!is_mergeable_vm_userfaultfd_ctx(vma, vmg->uffd_ctx))
 		return false;
-	if (!anon_vma_name_eq(anon_vma_name(vma), anon_name))
+	if (!anon_vma_name_eq(anon_vma_name(vma), vmg->anon_name))
 		return false;
 	return true;
 }
@@ -94,16 +96,16 @@ static void init_multi_vma_prep(struct vma_prepare *vp,
  * We assume the vma may be removed as part of the merge.
  */
 bool
-can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
-		struct anon_vma *anon_vma, struct file *file,
-		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-		struct anon_vma_name *anon_name)
+can_vma_merge_before(struct vma_merge_struct *vmg)
 {
-	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name, true) &&
-	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
-		if (vma->vm_pgoff == vm_pgoff)
+	pgoff_t pglen = PHYS_PFN(vmg->end - vmg->start);
+
+	if (is_mergeable_vma(vmg, /* merge_next = */ true) &&
+	    is_mergeable_anon_vma(vmg->anon_vma, vmg->next->anon_vma, vmg->next)) {
+		if (vmg->next->vm_pgoff == vmg->pgoff + pglen)
 			return true;
 	}
+
 	return false;
 }
 
@@ -116,18 +118,11 @@ can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
  *
  * We assume that vma is not removed as part of the merge.
  */
-bool
-can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
-		struct anon_vma *anon_vma, struct file *file,
-		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-		struct anon_vma_name *anon_name)
+bool can_vma_merge_after(struct vma_merge_struct *vmg)
 {
-	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name, false) &&
-	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
-		pgoff_t vm_pglen;
-
-		vm_pglen = vma_pages(vma);
-		if (vma->vm_pgoff + vm_pglen == vm_pgoff)
+	if (is_mergeable_vma(vmg, /* merge_next = */ false) &&
+	    is_mergeable_anon_vma(vmg->anon_vma, vmg->prev->anon_vma, vmg->prev)) {
+		if (vmg->prev->vm_pgoff + vma_pages(vmg->prev) == vmg->pgoff)
 			return true;
 	}
 	return false;
@@ -1017,16 +1012,10 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
  * **** is not represented - it will be merged and the vma containing the
  *      area is returned, or the function will return NULL
  */
-static struct vm_area_struct
-*vma_merge(struct vma_iterator *vmi, struct vm_area_struct *prev,
-	   struct vm_area_struct *src, unsigned long addr, unsigned long end,
-	   unsigned long vm_flags, pgoff_t pgoff, struct mempolicy *policy,
-	   struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-	   struct anon_vma_name *anon_name)
+static struct vm_area_struct *vma_merge(struct vma_merge_struct *vmg)
 {
-	struct mm_struct *mm = src->vm_mm;
-	struct anon_vma *anon_vma = src->anon_vma;
-	struct file *file = src->vm_file;
+	struct mm_struct *mm = vmg->mm;
+	struct vm_area_struct *prev = vmg->prev;
 	struct vm_area_struct *curr, *next, *res;
 	struct vm_area_struct *vma, *adjust, *remove, *remove2;
 	struct vm_area_struct *anon_dup = NULL;
@@ -1036,16 +1025,18 @@ static struct vm_area_struct
 	bool merge_prev = false;
 	bool merge_next = false;
 	bool vma_expanded = false;
+	unsigned long addr = vmg->start;
+	unsigned long end = vmg->end;
 	unsigned long vma_start = addr;
 	unsigned long vma_end = end;
-	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
+	pgoff_t pglen = PHYS_PFN(end - addr);
 	long adj_start = 0;
 
 	/*
 	 * We later require that vma->vm_flags == vm_flags,
 	 * so this tests vma->vm_flags & VM_SPECIAL, too.
 	 */
-	if (vm_flags & VM_SPECIAL)
+	if (vmg->flags & VM_SPECIAL)
 		return NULL;
 
 	/* Does the input range span an existing VMA? (cases 5 - 8) */
@@ -1053,27 +1044,26 @@ static struct vm_area_struct
 
 	if (!curr ||			/* cases 1 - 4 */
 	    end == curr->vm_end)	/* cases 6 - 8, adjacent VMA */
-		next = vma_lookup(mm, end);
+		next = vmg->next = vma_lookup(mm, end);
 	else
-		next = NULL;		/* case 5 */
+		next = vmg->next = NULL;	/* case 5 */
 
 	if (prev) {
 		vma_start = prev->vm_start;
 		vma_pgoff = prev->vm_pgoff;
 
 		/* Can we merge the predecessor? */
-		if (addr == prev->vm_end && mpol_equal(vma_policy(prev), policy)
-		    && can_vma_merge_after(prev, vm_flags, anon_vma, file,
-					   pgoff, vm_userfaultfd_ctx, anon_name)) {
+		if (addr == prev->vm_end && mpol_equal(vma_policy(prev), vmg->policy)
+		    && can_vma_merge_after(vmg)) {
+
 			merge_prev = true;
-			vma_prev(vmi);
+			vma_prev(vmg->vmi);
 		}
 	}
 
 	/* Can we merge the successor? */
-	if (next && mpol_equal(policy, vma_policy(next)) &&
-	    can_vma_merge_before(next, vm_flags, anon_vma, file, pgoff+pglen,
-				 vm_userfaultfd_ctx, anon_name)) {
+	if (next && mpol_equal(vmg->policy, vma_policy(next)) &&
+	    can_vma_merge_before(vmg)) {
 		merge_next = true;
 	}
 
@@ -1164,13 +1154,13 @@ static struct vm_area_struct
 		vma_expanded = true;
 
 	if (vma_expanded) {
-		vma_iter_config(vmi, vma_start, vma_end);
+		vma_iter_config(vmg->vmi, vma_start, vma_end);
 	} else {
-		vma_iter_config(vmi, adjust->vm_start + adj_start,
+		vma_iter_config(vmg->vmi, adjust->vm_start + adj_start,
 				adjust->vm_end);
 	}
 
-	if (vma_iter_prealloc(vmi, vma))
+	if (vma_iter_prealloc(vmg->vmi, vma))
 		goto prealloc_fail;
 
 	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
@@ -1182,20 +1172,20 @@ static struct vm_area_struct
 	vma_set_range(vma, vma_start, vma_end, vma_pgoff);
 
 	if (vma_expanded)
-		vma_iter_store(vmi, vma);
+		vma_iter_store(vmg->vmi, vma);
 
 	if (adj_start) {
 		adjust->vm_start += adj_start;
 		adjust->vm_pgoff += adj_start >> PAGE_SHIFT;
 		if (adj_start < 0) {
 			WARN_ON(vma_expanded);
-			vma_iter_store(vmi, next);
+			vma_iter_store(vmg->vmi, next);
 		}
 	}
 
-	vma_complete(&vp, vmi, mm);
+	vma_complete(&vp, vmg->vmi, mm);
 	validate_mm(mm);
-	khugepaged_enter_vma(res, vm_flags);
+	khugepaged_enter_vma(res, vmg->flags);
 	return res;
 
 prealloc_fail:
@@ -1203,8 +1193,8 @@ static struct vm_area_struct
 		unlink_anon_vmas(anon_dup);
 
 anon_vma_fail:
-	vma_iter_set(vmi, addr);
-	vma_iter_load(vmi);
+	vma_iter_set(vmg->vmi, addr);
+	vma_iter_load(vmg->vmi);
 	return NULL;
 }
 
@@ -1221,32 +1211,27 @@ static struct vm_area_struct
  * The function returns either the merged VMA, the original VMA if a split was
  * required instead, or an error if the split failed.
  */
-struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
-				  struct vm_area_struct *prev,
-				  struct vm_area_struct *vma,
-				  unsigned long start, unsigned long end,
-				  unsigned long vm_flags,
-				  struct mempolicy *policy,
-				  struct vm_userfaultfd_ctx uffd_ctx,
-				  struct anon_vma_name *anon_name)
+static struct vm_area_struct *vma_modify(struct vma_merge_struct *vmg)
 {
-	pgoff_t pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
+	struct vm_area_struct *vma = vmg->vma;
 	struct vm_area_struct *merged;
 
-	merged = vma_merge(vmi, prev, vma, start, end, vm_flags,
-			   pgoff, policy, uffd_ctx, anon_name);
+	/* First, try to merge. */
+	merged = vma_merge(vmg);
 	if (merged)
 		return merged;
 
-	if (vma->vm_start < start) {
-		int err = split_vma(vmi, vma, start, 1);
+	/* Split any preceding portion of the VMA. */
+	if (vma->vm_start < vmg->start) {
+		int err = split_vma(vmg->vmi, vma, vmg->start, 1);
 
 		if (err)
 			return ERR_PTR(err);
 	}
 
-	if (vma->vm_end > end) {
-		int err = split_vma(vmi, vma, end, 0);
+	/* Split any trailing portion of the VMA. */
+	if (vma->vm_end > vmg->end) {
+		int err = split_vma(vmg->vmi, vma, vmg->end, 0);
 
 		if (err)
 			return ERR_PTR(err);
@@ -1255,6 +1240,65 @@ struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
 	return vma;
 }
 
+struct vm_area_struct *vma_modify_flags(
+	struct vma_iterator *vmi, struct vm_area_struct *prev,
+	struct vm_area_struct *vma, unsigned long start, unsigned long end,
+	unsigned long new_flags)
+{
+	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
+
+	vmg.flags = new_flags;
+
+	return vma_modify(&vmg);
+}
+
+struct vm_area_struct
+*vma_modify_flags_name(struct vma_iterator *vmi,
+		       struct vm_area_struct *prev,
+		       struct vm_area_struct *vma,
+		       unsigned long start,
+		       unsigned long end,
+		       unsigned long new_flags,
+		       struct anon_vma_name *new_name)
+{
+	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
+
+	vmg.flags = new_flags;
+	vmg.anon_name = new_name;
+
+	return vma_modify(&vmg);
+}
+
+struct vm_area_struct
+*vma_modify_policy(struct vma_iterator *vmi,
+		   struct vm_area_struct *prev,
+		   struct vm_area_struct *vma,
+		   unsigned long start, unsigned long end,
+		   struct mempolicy *new_pol)
+{
+	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
+
+	vmg.policy = new_pol;
+
+	return vma_modify(&vmg);
+}
+
+struct vm_area_struct
+*vma_modify_flags_uffd(struct vma_iterator *vmi,
+		       struct vm_area_struct *prev,
+		       struct vm_area_struct *vma,
+		       unsigned long start, unsigned long end,
+		       unsigned long new_flags,
+		       struct vm_userfaultfd_ctx new_ctx)
+{
+	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
+
+	vmg.flags = new_flags;
+	vmg.uffd_ctx = new_ctx;
+
+	return vma_modify(&vmg);
+}
+
 /*
  * Attempt to merge a newly mapped VMA with those adjacent to it. The caller
  * must ensure that [start, end) does not overlap any existing VMA.
@@ -1264,8 +1308,11 @@ struct vm_area_struct
 		   struct vm_area_struct *vma, unsigned long start,
 		   unsigned long end, pgoff_t pgoff)
 {
-	return vma_merge(vmi, prev, vma, start, end, vma->vm_flags, pgoff,
-			 vma_policy(vma), vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
+
+	vmg.pgoff = pgoff;
+
+	return vma_merge(&vmg);
 }
 
 /*
@@ -1276,12 +1323,10 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
 					struct vm_area_struct *vma,
 					unsigned long delta)
 {
-	pgoff_t pgoff = vma->vm_pgoff + vma_pages(vma);
+	VMG_VMA_STATE(vmg, vmi, vma, vma, vma->vm_end, vma->vm_end + delta);
 
 	/* vma is specified as prev, so case 1 or 2 will apply. */
-	return vma_merge(vmi, vma, vma, vma->vm_end, vma->vm_end + delta,
-			 vma->vm_flags, pgoff, vma_policy(vma),
-			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+	return vma_merge(&vmg);
 }
 
 void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb)
diff --git a/mm/vma.h b/mm/vma.h
index 85616faa4490..b1301d2c1c84 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -52,6 +52,59 @@ struct vma_munmap_struct {
 	unsigned long data_vm;
 };
 
+/* Represents a VMA merge operation. */
+struct vma_merge_struct {
+	struct mm_struct *mm;
+	struct vma_iterator *vmi;
+	pgoff_t pgoff;
+	struct vm_area_struct *prev;
+	struct vm_area_struct *next; /* Modified by vma_merge(). */
+	struct vm_area_struct *vma; /* Either a new VMA or the one being modified. */
+	unsigned long start;
+	unsigned long end;
+	unsigned long flags;
+	struct file *file;
+	struct anon_vma *anon_vma;
+	struct mempolicy *policy;
+	struct vm_userfaultfd_ctx uffd_ctx;
+	struct anon_vma_name *anon_name;
+};
+
+/* Assumes addr >= vma->vm_start. */
+static inline pgoff_t vma_pgoff_offset(struct vm_area_struct *vma,
+				       unsigned long addr)
+{
+	return vma->vm_pgoff + PHYS_PFN(addr - vma->vm_start);
+}
+
+#define VMG_STATE(name, mm_, vmi_, start_, end_, flags_, pgoff_)	\
+	struct vma_merge_struct name = {				\
+		.mm = mm_,						\
+		.vmi = vmi_,						\
+		.start = start_,					\
+		.end = end_,						\
+		.flags = flags_,					\
+		.pgoff = pgoff_,					\
+	}
+
+#define VMG_VMA_STATE(name, vmi_, prev_, vma_, start_, end_)	\
+	struct vma_merge_struct name = {			\
+		.mm = vma_->vm_mm,				\
+		.vmi = vmi_,					\
+		.prev = prev_,					\
+		.next = NULL,					\
+		.vma = vma_,					\
+		.start = start_,				\
+		.end = end_,					\
+		.flags = vma_->vm_flags,			\
+		.pgoff = vma_pgoff_offset(vma_, start_),	\
+		.file = vma_->vm_file,				\
+		.anon_vma = vma_->anon_vma,			\
+		.policy = vma_policy(vma_),			\
+		.uffd_ctx = vma_->vm_userfaultfd_ctx,		\
+		.anon_name = anon_vma_name(vma_),		\
+	}
+
 #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
 void validate_mm(struct mm_struct *mm);
 #else
@@ -212,80 +265,52 @@ void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed);
 void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
 		struct vm_area_struct *prev, struct vm_area_struct *next);
 
-/* Required by mmap_region(). */
-bool
-can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
-		struct anon_vma *anon_vma, struct file *file,
-		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-		struct anon_vma_name *anon_name);
-
-/* Required by mmap_region() and do_brk_flags(). */
-bool
-can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
-		struct anon_vma *anon_vma, struct file *file,
-		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-		struct anon_vma_name *anon_name);
-
-struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
-				  struct vm_area_struct *prev,
-				  struct vm_area_struct *vma,
-				  unsigned long start, unsigned long end,
-				  unsigned long vm_flags,
-				  struct mempolicy *policy,
-				  struct vm_userfaultfd_ctx uffd_ctx,
-				  struct anon_vma_name *anon_name);
+/*
+ * Can we merge the VMA described by vmg into the following VMA vmg->next?
+ *
+ * Required by mmap_region().
+ */
+bool can_vma_merge_before(struct vma_merge_struct *vmg);
+
+/*
+ * Can we merge the VMA described by vmg into the preceding VMA vmg->prev?
+ *
+ * Required by mmap_region() and do_brk_flags().
+ */
+bool can_vma_merge_after(struct vma_merge_struct *vmg);
 
 /* We are about to modify the VMA's flags. */
-static inline struct vm_area_struct
-*vma_modify_flags(struct vma_iterator *vmi,
-		  struct vm_area_struct *prev,
-		  struct vm_area_struct *vma,
-		  unsigned long start, unsigned long end,
-		  unsigned long new_flags)
-{
-	return vma_modify(vmi, prev, vma, start, end, new_flags,
-			  vma_policy(vma), vma->vm_userfaultfd_ctx,
-			  anon_vma_name(vma));
-}
+struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
+		struct vm_area_struct *prev, struct vm_area_struct *vma,
+		unsigned long start, unsigned long end,
+		unsigned long new_flags);
 
 /* We are about to modify the VMA's flags and/or anon_name. */
-static inline struct vm_area_struct
+struct vm_area_struct
 *vma_modify_flags_name(struct vma_iterator *vmi,
 		       struct vm_area_struct *prev,
 		       struct vm_area_struct *vma,
 		       unsigned long start,
 		       unsigned long end,
 		       unsigned long new_flags,
-		       struct anon_vma_name *new_name)
-{
-	return vma_modify(vmi, prev, vma, start, end, new_flags,
-			  vma_policy(vma), vma->vm_userfaultfd_ctx, new_name);
-}
+		       struct anon_vma_name *new_name);
 
 /* We are about to modify the VMA's memory policy. */
-static inline struct vm_area_struct
+struct vm_area_struct
 *vma_modify_policy(struct vma_iterator *vmi,
 		   struct vm_area_struct *prev,
 		   struct vm_area_struct *vma,
 		   unsigned long start, unsigned long end,
-		   struct mempolicy *new_pol)
-{
-	return vma_modify(vmi, prev, vma, start, end, vma->vm_flags,
-			  new_pol, vma->vm_userfaultfd_ctx, anon_vma_name(vma));
-}
+		   struct mempolicy *new_pol);
 
 /* We are about to modify the VMA's flags and/or uffd context. */
-static inline struct vm_area_struct
+struct vm_area_struct
 *vma_modify_flags_uffd(struct vma_iterator *vmi,
 		       struct vm_area_struct *prev,
 		       struct vm_area_struct *vma,
 		       unsigned long start, unsigned long end,
 		       unsigned long new_flags,
-		       struct vm_userfaultfd_ctx new_ctx)
-{
-	return vma_modify(vmi, prev, vma, start, end, new_flags,
-			  vma_policy(vma), new_ctx, anon_vma_name(vma));
-}
+		       struct vm_userfaultfd_ctx new_ctx);
 
 struct vm_area_struct
 *vma_merge_new_vma(struct vma_iterator *vmi, struct vm_area_struct *prev,
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index 71bd30d5da81..7a3f59186464 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -22,26 +22,6 @@ static bool fail_prealloc;
  */
 #include "../../../mm/vma.c"
 
-/*
- * Temporarily forward-ported from a future in which vmg's are used for merging.
- */
-struct vma_merge_struct {
-	struct mm_struct *mm;
-	struct vma_iterator *vmi;
-	pgoff_t pgoff;
-	struct vm_area_struct *prev;
-	struct vm_area_struct *next; /* Modified by vma_merge(). */
-	struct vm_area_struct *vma; /* Either a new VMA or the one being modified. */
-	unsigned long start;
-	unsigned long end;
-	unsigned long flags;
-	struct file *file;
-	struct anon_vma *anon_vma;
-	struct mempolicy *policy;
-	struct vm_userfaultfd_ctx uffd_ctx;
-	struct anon_vma_name *anon_name;
-};
-
 const struct vm_operations_struct vma_dummy_vm_ops;
 static struct anon_vma dummy_anon_vma;
 
@@ -115,14 +95,6 @@ static struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
 /* Helper function which provides a wrapper around a merge new VMA operation. */
 static struct vm_area_struct *merge_new(struct vma_merge_struct *vmg)
 {
-	/* vma_merge() needs a VMA to determine mm, anon_vma, and file. */
-	struct vm_area_struct dummy = {
-		.vm_mm = vmg->mm,
-		.vm_flags = vmg->flags,
-		.anon_vma = vmg->anon_vma,
-		.vm_file = vmg->file,
-	};
-
 	/*
 	 * For convenience, get prev and next VMAs. Which the new VMA operation
 	 * requires.
@@ -131,8 +103,7 @@ static struct vm_area_struct *merge_new(struct vma_merge_struct *vmg)
 	vmg->prev = vma_prev(vmg->vmi);
 
 	vma_iter_set(vmg->vmi, vmg->start);
-	return vma_merge_new_vma(vmg->vmi, vmg->prev, &dummy, vmg->start,
-				 vmg->end, vmg->pgoff);
+	return vma_merge(vmg);
 }
 
 /*
@@ -141,17 +112,7 @@ static struct vm_area_struct *merge_new(struct vma_merge_struct *vmg)
  */
 static struct vm_area_struct *merge_existing(struct vma_merge_struct *vmg)
 {
-	/* vma_merge() needs a VMA to determine mm, anon_vma, and file. */
-	struct vm_area_struct dummy = {
-		.vm_mm = vmg->mm,
-		.vm_flags = vmg->flags,
-		.anon_vma = vmg->anon_vma,
-		.vm_file = vmg->file,
-	};
-
-	return vma_merge(vmg->vmi, vmg->prev, &dummy, vmg->start, vmg->end,
-			 vmg->flags, vmg->pgoff, vmg->policy, vmg->uffd_ctx,
-			 vmg->anon_name);
+	return vma_merge(vmg);
 }
 
 /*
-- 
2.46.0


