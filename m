Return-Path: <linux-kernel+bounces-444256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1BC9F0364
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 05:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0C2E284BAF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 04:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A01017E00B;
	Fri, 13 Dec 2024 04:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mL9v2Xgj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cZaFh5fk"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9F516EB4C
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 04:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734062855; cv=fail; b=pSTphKOcAeHQ6BQ7zFKSKAOo6PzV4CHaMHyrnWUsWaPwsJLGkCuWl68W251S07j1dfIE49lCwyaeuyhXBpqQibJm54B2mYtKQN4xBDqgHRpzBqLUxjyjeL3AAdpzD2+bBFHB2HTxf21zGsZf9YhpNYPvib2e1J495mOxlr+hBOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734062855; c=relaxed/simple;
	bh=abXdG7zWScan0KRp04kt/z6/ormvwX5n7/vP/vZ/4o8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k1Mek6FVuhs3UEaemjElWqAfBNLFKGwhOX1w9M5lZgl00WEnIeJ3Eg1gK2Nla459mafPKnQe+zoUmkvB2ehvWLmPoHCFzR4uoqOLsXzRlnAMm1aQ6H+aceybJ6bPU4oN/fHBGIvAgDrCZ74EgiUr2rKaMnsNUfBNaP+J0KOAF2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mL9v2Xgj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cZaFh5fk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD1fpis025939;
	Fri, 13 Dec 2024 04:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=UWxjN/4UYknSnD4o/sPxXJIdCyNZXhcwNo/19fZvAUg=; b=
	mL9v2XgjwXgXco0jcBfEFroSbXeXeydXNZ101IoPlHHfgiaP3iClb/IqqGJsICH1
	1v5fgzfrW45EcbNMtM4VlLHoIDUlO6blqdTCP4x8OQM5JzvgnIOe+HpWz9dewXeA
	a7R1zpr/E+6IMK+kpVWkyZpeBKrmuVw6Pg2jy6AKVN0bMIwjPTPaez3SpZXT5O2r
	IBqF3rJKKsAzmbyNe7fXuT3q3l7r5DoiOkhSM8RK7vv4xqP8G7JIXcwdxSM/HJdR
	pnt3PcNvnijbbo7AImT3/ePUi+huZDZLs01BE7Ak8x6J4cV4dyjk07SVf9N1QxqR
	d8PIAx9UVpGUC9mx9dqoUg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ce89ces3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 04:07:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD0lK9Q034970;
	Fri, 13 Dec 2024 04:07:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cctkhje7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 04:07:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anwAK5KeOISX++qpeR023/1NIDMkmSO50JHNhQKu+x9sdhpM9dDAMz4n7BPEbvjeEKqdF4s7I7DgZUShZnnhb3j58c4lNriWgsyqPtNqcz3w4yvwM0xgrQjG/a3zalt4pNOtTyBAT95IHvLMgA19AaD/EQpDeLKu46WU8ItSl95Nn2JnABcbSuMqcnY2HBaTZVuLvoxNG51kZtDH/bEuMjUZY27ZamwAtrD57BFj4PnDgkEHHBYNceH6A1G69fw7pQiuyZlPjNMCLYZdv3HWpRVqCzWvtYKER43plWUA/a2m1kJ8hPcrKneq8B6RSxNain25OFPuPJXOA6h65o3n7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWxjN/4UYknSnD4o/sPxXJIdCyNZXhcwNo/19fZvAUg=;
 b=Hb9yYTfaB4CM0CJeWDUVcHknjNhMRooqjhVjSQwzBo0xurMHTnqxj5wAUlYqOw7OHvMsiuJyheLg3jjqbgGnJyQ2K0+AgQ53QtxLiTxfRnK6voVhSSZCV8YLP/4XFM5/xzixjCzGuBBNOqngSlsoqxhMbh8x9upU3lsGCCxHS7whiVDMSgakfBjU61t5RJ9dQiTTzK6f8yIbTv/eVFuiOIWCaVL7gbjDFhAXGwZPhUQ/+2aslVlWscQshAqJCnxJxGGLzDuHVZsS43krfEHZgoS4PIxEOuzYVybkSQp21SIexiq6vDCU9D8ycGGhAYgc5JF0uL/3D8/SrDTSsqm4aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWxjN/4UYknSnD4o/sPxXJIdCyNZXhcwNo/19fZvAUg=;
 b=cZaFh5fkjhDvbxJy10PxluvfOD8GUcIiYpRND5zh2WTBRl+hjCVeYkU/IRjk4voTa3WK9DN9jD7i+nIm04rNExbI+Hu5HFen3opAJhCksYU75pA3QLZLHXo6m8IIsN+zgMs09JbPnrzH0XmlZ0eS40laHC30hCRh5eQ1v2YuktQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH0PR10MB5848.namprd10.prod.outlook.com (2603:10b6:510:149::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 04:07:08 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%3]) with mapi id 15.20.8230.016; Fri, 13 Dec 2024
 04:07:08 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, ankur.a.arora@oracle.com,
        efault@gmx.de, sshegde@linux.ibm.com, boris.ostrovsky@oracle.com
Subject: [PATCH v3 2/7] rcu: rename PREEMPT_AUTO to PREEMPT_LAZY
Date: Thu, 12 Dec 2024 20:06:53 -0800
Message-Id: <20241213040658.2282640-3-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241213040658.2282640-1-ankur.a.arora@oracle.com>
References: <20241213040658.2282640-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF00013DF8.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:b) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH0PR10MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f2fc434-c9d9-42f4-a427-08dd1b2b9cbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?42NR10VCyoYk49xcqgajC1xxUvvWqc6SGMddg8IxIEByvf1V9/vSD0L4QRqA?=
 =?us-ascii?Q?8RJa07GCnxjj+QQVQJamMcGxWoMoPz7f3f6HECvdchoFIdNCf+YGpzbH6LTm?=
 =?us-ascii?Q?2lj/RdH7mdw28PEtjklZPAj3HLHyJBc5S3IJqF0NmsZgTj/4evDFP7eKph/X?=
 =?us-ascii?Q?TgKa/PV7jJ7+mSICA9dBFJk9sfdEAmNqfZrj0ZD5UyLMsSLIN8vnRqLiK69K?=
 =?us-ascii?Q?BX/3fT5vRAt7z9ijlenKqIlLB2skSxaNcb6kSRFgOw7TdikfynEeZRqa8D5i?=
 =?us-ascii?Q?a6noqZIoldvrwzr0viYYcv6ZfBF88W6VXK5wCC9x2pItMCaiX+lMXgJqAIR5?=
 =?us-ascii?Q?ret2U7gP523dMymBXKiLxPIvzBrC5IQltjbn+V3a1TaPsFdpB6MNJeJnG1oR?=
 =?us-ascii?Q?YXzjhnOZpsTVp0JqSLEoEqiGyBZncxmoJ1r4TV11oFZBs+ImkgpzQhPtv6uu?=
 =?us-ascii?Q?KioGLmxXrnn9mrLEqYiTiYMOhRlI5dAiymp2EOsgQOLrQZjh4U6aF97QUks3?=
 =?us-ascii?Q?X1nliIzyi5CHa75wq2Z9CuyLlFyLL34zCXFGaQIFe0DxLck9MlEO7mDz6WQt?=
 =?us-ascii?Q?MgtjpBXMBLYS50dRxtuZKspcZESuDm04gUItr9VYwO8lVsM2RiFM/hcuVHFU?=
 =?us-ascii?Q?JtYBnblwjbkTWBZvnxJjvcwx1VoGYNT4t9X5gCWKHyNdbr2UTKB4gqcM+izn?=
 =?us-ascii?Q?JM4p7BEME2iNgPSxU/uBQUMmLpyEeiyffZeKbM8D/KzdsrqO9FeJLo382bcD?=
 =?us-ascii?Q?14IOYgkq7hFfqeQ73oE2kW+kRx8AdnBGfeeA9ky+rViZWUtkvOK+9vUaoHZu?=
 =?us-ascii?Q?JtMk/sBpHbAxotQrB/5Y3aGSo++Gtv7DdTTsItwVfhKcSc2ja710dBf850hw?=
 =?us-ascii?Q?BK4PT1K/eAS0AbpGsj4cxcaKfwnuXp/1jf6k1BrxLSb6YrAU65NKsXQHYcGn?=
 =?us-ascii?Q?KakxMMiZjczTIe9DfvwErD4uBQaEeTcQrpKU/Ki0YKbOTdRQ4pqVfAMvBX1S?=
 =?us-ascii?Q?nUdv8awIE2e1KhT7jOmBvfH96jYV6EoQ+IAOAY0kS9UyG+eo4LYQLC7Rp/tB?=
 =?us-ascii?Q?rPIzTgVoX+57C76TErNbWcjakrOlergJjMgvm5HpU+hKSTSkrJb65zVyzwOO?=
 =?us-ascii?Q?icWmptmJpdD2k+8BZ3MwVjnG+TFHs5epeU3mnTiocTDKosy3+KzxZ/c74G3r?=
 =?us-ascii?Q?ZxrhGu0T7IwLhMI3DMR50P1ngYMvwGNwcjCfAILVU3wJdJ932uhdNMbctozu?=
 =?us-ascii?Q?Hvkl2eNcf4MAjkFC80f7QCMsFDkYjwT+immRPYiNNJP5zJolAGdZCwUP9BLu?=
 =?us-ascii?Q?otIXoMnGe9KLPkl0PtcL5yfNpyB4iBhk0FW3gOOJH9hZT8BKvzPlkl4NA7rT?=
 =?us-ascii?Q?nUmjaSX+1XepStX6EyTU4aCTNtlC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B/YI6SzLqhiWbYdS65kCTy9MIHiUSzgHduZnmJBYJ309xkxhDNnpzOafUXTb?=
 =?us-ascii?Q?EM+hCOFtxNdSlm1l+i0D1u1aETnc98WdYxL3OSfzvY3kAChUI2hTQ8ww5bqv?=
 =?us-ascii?Q?5RN+SugKAiIZTjD6baK8pIn3Qmfi57mW9KkFZ5Tw0uTSd3lapavQIuz/EecM?=
 =?us-ascii?Q?cqZwNYosY2saX73NS+qpp2PEwehs2jeu4KR9zM8L5vMkjNyxKQPnqPFscfip?=
 =?us-ascii?Q?JXSjQsbG03y1FFiAFexjSghtP4tp8Ukr1WMHktr30Jzhk0Ypu12sjA4qXUTH?=
 =?us-ascii?Q?q9eywzrVkRCNtcgPghV1B1fdq6vlT/0E0ekdeSW8vfEJp6dqC0aCAwDQwtOJ?=
 =?us-ascii?Q?pVQOqXulsPmd1g1HzyNQo1JzNBboSA/7Q58rxAXQxnb/G3TudoDU+oLHm6vC?=
 =?us-ascii?Q?vOldKmn6Efi/dqNC6gPSYNVnrd91tHWSgKbm132hy/LB4sQKUBwD3AHP3EmB?=
 =?us-ascii?Q?wWfxc4RWQiEXZZLyy0UzqrZV3GQM1pv+Hl90/+iCDlNyDdaXz+cR0H8vDjeD?=
 =?us-ascii?Q?+ZF8lVkaTCIw+zFjTQDUntDvfYft+8Gz4jYPkR0+exCbYCxgKqgXfYAEh4VL?=
 =?us-ascii?Q?GKljjZYkXP5V589CsmrbL5UBkvO4CuvIEyxFtdGYYBlLMLSW7+bX3g42MvDV?=
 =?us-ascii?Q?eKo03SX6gDNbH7axsTPPwa+ij2nELqasYj+8jfamwuSVcS4FXzekj2q2rST8?=
 =?us-ascii?Q?YC2NvBTZVSxiUH29g8gRzW42EHfYHcqbPfXMbglxThd2+Cv1Ik4xgXzB+n5i?=
 =?us-ascii?Q?6Y7LTvZEq0lQakdt4r8vY3lTuTMyFxdn+L9imGbod5L6C1+tOMwTHl8yO57F?=
 =?us-ascii?Q?dUG5vzYIJSucP5sja/Q3/l5mDRsI7OlULKFZSYAwkGM0QkM4BS7Spy8J39wN?=
 =?us-ascii?Q?+NxNzUahmMPUhqlfoAwZdYUytpMr4FoZMlThYlyotzkDiQcciVMCytsQ2yPa?=
 =?us-ascii?Q?twadreyAQ8C+X1CHXMOKXaIK0lORcshgi+PS7y3HwOwYjuSuaQbl2UVsAY+o?=
 =?us-ascii?Q?NwCbVdDckj++Unr032un7TUVg0dtH1X7cGdf/69SwoOSMjqRuvAplN5f3US7?=
 =?us-ascii?Q?GfYk38gC8raFTXfft26wV/DU7A84oP19AlJbmVRqj+ZSg2yrKX9VIa5m1Sr3?=
 =?us-ascii?Q?c8lFoDW/TjdPMWcExr8OsvVWNdLR/fMMpau+b/8GTZ0YmPSRV0yRnEJCJutY?=
 =?us-ascii?Q?7BD2OmtyQI7V7N5YeXhKaQZbD7wwk2EzXfa/N8KxhbUBpX9/9CcqbjxRX/L4?=
 =?us-ascii?Q?VctSxu6fo6Q65y+WKl4qK99H32wFx33Jp83udZ4bxM1byH5VcIxQ++Ou3wKn?=
 =?us-ascii?Q?zVvWEDQiBYsk4HEiWvzYktYlAJTp4mecu4Md3CFlJFW1018tO5oTAafN20Ci?=
 =?us-ascii?Q?xCq1bOOvXkm4r5lPr5nVakEzUNacV9qSUNQCxYRkh+cisLTMEYrER9XLhGIH?=
 =?us-ascii?Q?msSy005cLuQL6GtcBuRLsqyaEMo6SuYZ6LSWNMFyydJUv7pkRPzGLt3stQAy?=
 =?us-ascii?Q?EEa/KmPUH+XmY72rMJt7LPFkCnWIVxjlv9t0ViMv+u45RofOXWkDrOvzBc1s?=
 =?us-ascii?Q?zEMBBOOy6MkKbYkCt2ZBZydsWaABCBc2yUTtl8incLIU73k70g7muDDRIob+?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	S/dqxWnKz2DJC5dOzJZGzozHNxyNaZj1xBuJWkZoGDYqlQb5aQhYWktxBhy1RJubb8EqICDkXDouR3GeG1cpn5dTBazaloCv4oRnLebPZ35DuUnDW8Z93IpT0/tq1dte+Eqw1VptWSStEeIiSK+J2f/rhLC5zgYxP/jBcR3ZFmdifDP4NgYJ76PoVeV8I1aAaB/Xgvb8++kqfKm24ahHfAmAkskdMiG/RXwNgJEnoOqkQkbciumyB950/D7TCBLUvtq7QADai8CkZ2pAeRKaD7BTvA36v9l0uYiNE3o4IDwuZVRM7TYYhXt9fW/9SXvEuGADHZqYQZoUj3qec4F2J/jkeMt/unKULQ9XJYimImd5ihmOa/NHtprf8QNpgFVLU4H/E69dPltNgPGmfhcdnw6lUVyePTmnN1IhauNvFqtck6Wf0sv3hicHKVK8s34tcRNGBmZkgIKGIH3oU/4ETKBiQDvtTkjN15wdcWpx7/NhOexy8egx5SFsPh+5/YpX2biYk4YE40p9CUR3vtgaHsHfiVUuuBzZx+/zUcT20rk2YiKlRzMtLF8jZsvO9rFM8/EjxiQZqeSi8AG3hbvJ3nLlK8HjZCTSGbjsK9ErGeM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2fc434-c9d9-42f4-a427-08dd1b2b9cbe
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 04:07:08.5772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lnuf9zvPJ1zpbXALfhrXODDiB+xZtwZN6Xwz1HOv0HM8mMWDVp8+0s0j5PTJorPgZ3TzPiKsX5ZBqJL+SNA2pMjjdKHpOxW4VZsmWXxHKRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5848
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_01,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412130029
X-Proofpoint-GUID: gqNn52JNwN5CeY1WIUpgBvgOLpMwjwO2
X-Proofpoint-ORIG-GUID: gqNn52JNwN5CeY1WIUpgBvgOLpMwjwO2

Replace mentions of PREEMPT_AUTO with PREEMPT_LAZY.

Also, since PREMPT_LAZY implies PREEMPTION, we can reduce the
TASKS_RCU selection criteria from:

  NEED_TASKS_RCU && (PREEMPTION || PREEMPT_AUTO)
to:
  NEED_TASKS_RCU && PREEMPTION

CC: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/srcutiny.h |  2 +-
 kernel/rcu/Kconfig       |  2 +-
 kernel/rcu/srcutiny.c    | 14 +++++++-------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 1321da803274..31b59b4be2a7 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -64,7 +64,7 @@ static inline int __srcu_read_lock(struct srcu_struct *ssp)
 {
 	int idx;
 
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	idx = ((READ_ONCE(ssp->srcu_idx) + 1) & 0x2) >> 1;
 	WRITE_ONCE(ssp->srcu_lock_nesting[idx], READ_ONCE(ssp->srcu_lock_nesting[idx]) + 1);
 	preempt_enable();
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index b9b6bc55185d..e2206f3a070c 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -91,7 +91,7 @@ config NEED_TASKS_RCU
 
 config TASKS_RCU
 	bool
-	default NEED_TASKS_RCU && (PREEMPTION || PREEMPT_AUTO)
+	default NEED_TASKS_RCU && PREEMPTION
 	select IRQ_WORK
 
 config FORCE_TASKS_RUDE_RCU
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 4dcbf8aa80ff..f688bdad293e 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -98,7 +98,7 @@ void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
 {
 	int newval;
 
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	newval = READ_ONCE(ssp->srcu_lock_nesting[idx]) - 1;
 	WRITE_ONCE(ssp->srcu_lock_nesting[idx], newval);
 	preempt_enable();
@@ -120,7 +120,7 @@ void srcu_drive_gp(struct work_struct *wp)
 	struct srcu_struct *ssp;
 
 	ssp = container_of(wp, struct srcu_struct, srcu_work);
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	if (ssp->srcu_gp_running || ULONG_CMP_GE(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max))) {
 		preempt_enable();
 		return; /* Already running or nothing to do. */
@@ -138,7 +138,7 @@ void srcu_drive_gp(struct work_struct *wp)
 	WRITE_ONCE(ssp->srcu_gp_waiting, true);  /* srcu_read_unlock() wakes! */
 	preempt_enable();
 	swait_event_exclusive(ssp->srcu_wq, !READ_ONCE(ssp->srcu_lock_nesting[idx]));
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	WRITE_ONCE(ssp->srcu_gp_waiting, false); /* srcu_read_unlock() cheap. */
 	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
 	preempt_enable();
@@ -159,7 +159,7 @@ void srcu_drive_gp(struct work_struct *wp)
 	 * at interrupt level, but the ->srcu_gp_running checks will
 	 * straighten that out.
 	 */
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	WRITE_ONCE(ssp->srcu_gp_running, false);
 	idx = ULONG_CMP_LT(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max));
 	preempt_enable();
@@ -172,7 +172,7 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
 {
 	unsigned long cookie;
 
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	cookie = get_state_synchronize_srcu(ssp);
 	if (ULONG_CMP_GE(READ_ONCE(ssp->srcu_idx_max), cookie)) {
 		preempt_enable();
@@ -199,7 +199,7 @@ void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 
 	rhp->func = func;
 	rhp->next = NULL;
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	local_irq_save(flags);
 	*ssp->srcu_cb_tail = rhp;
 	ssp->srcu_cb_tail = &rhp->next;
@@ -261,7 +261,7 @@ unsigned long start_poll_synchronize_srcu(struct srcu_struct *ssp)
 {
 	unsigned long ret;
 
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	ret = get_state_synchronize_srcu(ssp);
 	srcu_gp_start_if_needed(ssp);
 	preempt_enable();
-- 
2.43.5


