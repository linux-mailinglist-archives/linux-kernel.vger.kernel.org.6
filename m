Return-Path: <linux-kernel+bounces-191559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2FC8D10F7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7FDE28309F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FD94436E;
	Tue, 28 May 2024 00:36:32 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B22EFBEF
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856591; cv=fail; b=OxIGDs5QY/5nUSiEo1rmep5SQmFd0+LTHNv8K0zBJzhDtsWn1Ixm4XDy5g7YmHWDNKd6pz1rLSRjQx6UQOCG2YmgTLufy0+fLB3ESb939jUHYUh9ABCOUlKuY99rizFBzeq8f1T5+F7s5mDNrCeaIU21OrmVuhHSxDNm/g6mNJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856591; c=relaxed/simple;
	bh=n5kHsq2LdeTXPidmFPEb0CBJulVBFf/7qrNINHvcFcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IdXrpdq13u/a+R/ucL8ImNc8RYwNOTsP36D/OPPLtDwMvEjcAFaXQBFUDhzTNJsrnbEzgcdVr6MC86HzRtC46Md6nAollmWb1KQCXpVTOh6gA/ONKWbedzZj7kMrEJAemZrIgmMOETHn36pmlaPC8LgcqkmAgrPjASh+HJsd5o0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RH4gB5001264;
	Tue, 28 May 2024 00:36:12 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DGx6lN4oSikeRoIFj6jpi8xRrGdkpmoo8JEO3xwmhxYA=3D;_b?=
 =?UTF-8?Q?=3DfscyhiWzwpp9JAQNe8gQbaDjVEjxeRI+wQ8fqlcmGNjscxadNNmouvPRVm5j?=
 =?UTF-8?Q?nutd8kBO_QjJVKru6m96xLwvKGDpq05v7eoTkLGoeHmoBseseytxsTFVCsSMCx7?=
 =?UTF-8?Q?LnJ4Lub0wPBKhf_n9fSTZV/qvr0iQxnBrTqKymGILu8nHtKSCevo7c4WAGFVhLX?=
 =?UTF-8?Q?D/DE1Po0FGfpDVnVt1Ct_6xcaOcCnFAVOI/USMpITn+WCROlcGnV6urxn8b/TGO?=
 =?UTF-8?Q?A03wY83RVgaKXRo3K3wyxm3vzj_p9Su3ZG2Ft8ScAliInegntVginXRPWSfS2lW?=
 =?UTF-8?Q?pUrxgyD8iNzt1PuODVb9C54NPncVlw5D_gQ=3D=3D_?=
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g9k8wf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:12 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RNMbXY016167;
	Tue, 28 May 2024 00:36:11 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc55vtfwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTFCcw8YHgG7w/PI6Yl5TWh38GKuCVpZ9XjJY3dhU+M5uKQCu0+pCVaMtf5Opa91pVFVucZ9AddF8doBkPmL8KmjxF/UzgVhQLt4Im82oo2AQPIQOAC7E/pzilBZA8uEOTnpuXP836DPAB5z6Rm0hKeBuO/0U8mWgE7evwk8VA46bBmP7LTMNvFaVJcdKMNdrv8P2LykbIiD6wUJCSqgJPnW0pt8VO4OxBlXRVdhrYc1IbXZ4CCTdC+2KBX/2egXfu0wFmsvdLC11yll8UXiOt14wB13/t4Gy7sEJSeTKmAjspiRR/BmATKUUIPdYeiJ4x5/9JfahYJffLvFwbPJMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gx6lN4oSikeRoIFj6jpi8xRrGdkpmoo8JEO3xwmhxYA=;
 b=U8fi9rTTK3EHlpA3LPfhYYNjzx4m8LPMXdo3iTh2/wZiULlpUYmGm92czXJG/h6HYukQg7przQ1CFba2oCZazsIGAoTbUqqQ0DdT99LaTqTMdqaB5Ib/uYlm1JSV3xJPuxEG73V+zdGGp52h4Ma8vrT3vj0BlaZCOy9igkv/nhn1xQaUiyLNER9TOlP7/JWCl/yNbuxHavoZEOhBBVtb/ltBrpo5LM1MXJG8gyWp8sgrkgfPlCZxITHnHXVJ7kAbakH0hhBZGDwfbFekoSVNFKHJpAiF2DMNnmwL7XUOGshsaQdc0PDpNs+zx1jWHqC0RkCQd7CZYEx1mjSN28LuLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gx6lN4oSikeRoIFj6jpi8xRrGdkpmoo8JEO3xwmhxYA=;
 b=aWnfpMzvSRF4syGr7cF/botVC1ih/+sIDHoc8XEZNe4SDKtZEHO1Zzp18rq/wn7kH6wiikjN2Tp/pB5i9k0mfKi1IIa/zJJi5AD5qnLiA9XVslnwN7njzqYN59hiADXV+coaSYa1AwDMrTSDUxLz56M7dtb+hC7l5Xx112ZlkbA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS7PR10MB7177.namprd10.prod.outlook.com (2603:10b6:8:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 00:36:07 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:36:07 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 13/35] sched: allow runtime config for PREEMPT_AUTO
Date: Mon, 27 May 2024 17:34:59 -0700
Message-Id: <20240528003521.979836-14-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0313.namprd04.prod.outlook.com
 (2603:10b6:303:82::18) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS7PR10MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d00aae1-c204-4b6d-65a7-08dc7eae29d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ukQudOUy7cQZi07XT5miBZ/9zwv+lgtRqWSBYZSeskajZ/NT+rRi3MegPZ1x?=
 =?us-ascii?Q?yxa37A5ozWAskwIYgts9MrQmUi2gBGx88QW+ASPudKK1pb8/X/dzZcXwwaeT?=
 =?us-ascii?Q?F0wmV59OQk4gzcY6nnGe2hnMyu3t8O4bbq5s5uK/K0B7g1aPJsbAuCZ1dNoK?=
 =?us-ascii?Q?sIDVI+rBYS0qvfUzjzNeTsvpRsAXqhRF4Srvp0Ve2omSstvgVASxJOb0MgPk?=
 =?us-ascii?Q?H/RqwzPdVP7Sp+N6MWGO4wXX+uj7JCE3cnGqUSXLbjs0XQzrtlqUBh4hHyte?=
 =?us-ascii?Q?GLkhQ91JYjJHPR0L6qzSa1XvZHr1nYTB+d2cQvKXAcuSnKTxgGRbonxDI1CU?=
 =?us-ascii?Q?sjSu8AGm/OUhdofo6CrNpQfd7skC5+rpuaLIwEyq9mQ2AFFPVn7ljFZsE2Wu?=
 =?us-ascii?Q?IMOuglOoLzvwljMTj3WInq/SfO7b15VKudLftOghhup5IA4IeM033SB36Zw0?=
 =?us-ascii?Q?1F4U81aMzvzyBwiyvHm1rNxE0E6hb5784TdVI8FPwoyOwaE2bPTuy8fJnIws?=
 =?us-ascii?Q?HR+ecK6ybvSRE30qQeg3/IhxEzwNVetVBFb+20/TAm3bvkY7MJ+P5qReQz26?=
 =?us-ascii?Q?ye15wGh59O2sy6PzWdv1mJ+cjuxjt/RjvkiGoOeXLZFdTOvvEyPxF5HJQtmY?=
 =?us-ascii?Q?F+z+ome2JE/UhN/KeE7mRTgq5iofuGSxxfZn6LOoKiqJp0nAy18PINanaZ0G?=
 =?us-ascii?Q?7qHKdYsN5y1Q7zmrS69DF9prvh+YfX8cBNKHQbLtFo5IWV6FPU18/nei/YHr?=
 =?us-ascii?Q?omoBksZz8TiUdhsbpBS2FMBNxGhrZZ+5dqbljxVJCf3OpEIORtJZvKC+0qRq?=
 =?us-ascii?Q?BrQU1fVQpEIoO/Ux1Z/H/VEi4zBhY8PvAErRUFbdThHY407YKNPh7tV7Ifsp?=
 =?us-ascii?Q?j/GH4ZbHJo/J+XBHO3B/ENziIyFGcNaoOV4CLcLAayP5bkoALP8zEWdq7gxO?=
 =?us-ascii?Q?59w2gMuMWSj5+/iUkMLbi/t6ug2PBnA7+TTdwYfwvrPDfKOqGULW2UK8BoxC?=
 =?us-ascii?Q?O/h2nAhsb+m1A23VMyjixCn0xXtGsN6Lib9lME4bGwTjvvk1mRE4V/xnIBZc?=
 =?us-ascii?Q?5AiCNxveXx+cmJik98QhIq4lUZpV1CFu7LiGkXZzWb+Oxd/b2AC38nZpRcDB?=
 =?us-ascii?Q?osCAfmJPo0oYIWoXerlF7i/SzIYHBA9WeEVLvu3xOGgLn7H2BXG/0VkEl58U?=
 =?us-ascii?Q?ltIUcC5tjgdnyP+6EBT6GDdkCV0M0al8wjaI+UpiooQ3i56rbVUuTzkH6EuP?=
 =?us-ascii?Q?gAY4WhtYSL4afTKFapWxOHCeKpXNoOG5kxKYLgQr/A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?kzZRHq1rKStpqokafVzdzUWsvIsk5MWzHEWbATs/u/Koo13Tzq/vmJKcj7o7?=
 =?us-ascii?Q?VrtnC476UpTghitQD6/hieGZbdnLXdbJ7SM0ioO41cxgewRQ54ULw31HL3dQ?=
 =?us-ascii?Q?OKNoDps53w+cPOFIte9Qt9jA0HkSPiFz8Y8CkQkcbHKF7FzXV3fz2j4PPKks?=
 =?us-ascii?Q?rZUMC/k7XK4E5rzqzrQ9j48xlqGd7EJRwshNScJl+sVrKskUefE0Ny6GwJ4+?=
 =?us-ascii?Q?sCv++5hjOpuv+DmHRgocfJSlTYYVy3t78gNrHI+YnMCWQRkUGur0nTUfRDCn?=
 =?us-ascii?Q?BXSQyuajHeofGFghn5HJu4Ze33seTzTn8AIXU8CrlC2bD5zGrlqIisHTIlQt?=
 =?us-ascii?Q?HPRfx8pDGibtZYSORJPB8AL79v+CzqI5cYqypjyzg9q5OHOT7ghwVU7E5KqZ?=
 =?us-ascii?Q?cBuTaOIz0UY+SxmnkQqvUsfL7Is0Q3c+usIGnoh3SpHoiC3i24e5dQw8FY53?=
 =?us-ascii?Q?zhCWeAikscrxmo8/btAVGXWM6k2PzQ1dKaOf760fbKxXoyUEk4sgh9Ih9bdY?=
 =?us-ascii?Q?psKavL02/96Xii4jjkqHeLVE3tT1wBu1eGhxtYe7CgcUqJhIhqhxg78+hRBy?=
 =?us-ascii?Q?TA14jP4YR3FlZZ54xH3nUejY03rBMmdn3ibejGOSKL2rHaIpOByw6XTwsAta?=
 =?us-ascii?Q?O1Ug8tFdfu1sUGE0nVtuj99MS3N0RRzWWDCWyR5FKtPcqcGPSq0A30uT1Djt?=
 =?us-ascii?Q?mjF8VpJe+nevNqKZOJaR9ugqKGoXIgHYoQm13ateo3WekbmdT8mILVdw/aqH?=
 =?us-ascii?Q?BvyHYxmO4kUxI3uiUHK7PdfkQ61x8Oln5wdr6DO5COhcb+agcU8Q2Bjvt8du?=
 =?us-ascii?Q?FfCk5sa3Ai/B8a2cUTmjq7N1IfwcrxarE7MP8yqbmb2uFFnCRh5/5TtFxFPW?=
 =?us-ascii?Q?LLCxHAmy1VRHyddIoMsKyr9/8VZ0xVrc2iP0sd5cB68boWEAOvoJrHrG4N5a?=
 =?us-ascii?Q?akwtNeseXBjEU4jRYDVuu6l5u55Smw9jZnzUJSgGHGLkNqCBKJCuFKA54luj?=
 =?us-ascii?Q?99J75r4toHdrp7Z/oM6bGpNP/IApV4dW5m03/9pDnS58JyIs6g0+N2pPkZ24?=
 =?us-ascii?Q?VdKWcFdPDXqyJRUH4o2fK7JV6VFk8UV2fLOff7SpGMoDecEf45kJHw1iouYE?=
 =?us-ascii?Q?p1FkInqV50Qoo5LcVg5tMu6nslx/GgELsWES0EeODrny17P2wlh1tX34/Hkd?=
 =?us-ascii?Q?jzqtfyBDAKe9e7Y0jAuOhK+eUQkKATvEwL6ftQ+fdM9DwgSi5tRs9zjdRbIB?=
 =?us-ascii?Q?qhlIdWd2mcAZo6ssKKN3B47gOZqb5/fdMnrmYpZyJG5lXS3iOze8rv1eKu2s?=
 =?us-ascii?Q?pW6g6+n3wHVKhVK45fuc0rgsLiIQVSTtACmewyKqiHB8AguxW70pknUPwDuW?=
 =?us-ascii?Q?UZtaKCiBRUvh56g207/zwHaSZEtoBE4KTeNmDMjg6Zmsl3pw/lecv5a5zC3n?=
 =?us-ascii?Q?px0c1pD+vSv0Lm5k96GB4CtxqimAUq5Ti9uGEmFWWmNApnaKFw0RLRhrs2hf?=
 =?us-ascii?Q?dQwE7gcA6/nt0e4Cg6bWbr9MlzkFn/slDVn/FzOoKt7M5aKVCvAxwu0KcZpl?=
 =?us-ascii?Q?MKmb46vTza9pTtlgJWK3VEvGqwv8epdUXoQ7T1Aqh+FOsizqlvSxx1FmFRS9?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	K56weSQb7N+wiIEofK98AG7B19OiHnqtyhUrgkfXlWWQKxwnbtYP5xEJLLGte4D6Jluv7HJwvj3DyJ63+4PYF8kueF66El4v15U2ywyjFy0E/ZFsZUpqqx03VGFdHGMvNY5qKBeRsOVzcoyttAaT3BuBCn5OiRQuuMcBkEixJ1VZ3TzcjTYVaEesP5zzzctrcE0DQgxQNLJ+NhhiTB6HGoB3dMIWOUEaPEfqPWCIlt7ppP2evku2I+8MKI9q60bEGCIM30eq0NVOZNw7uQoGj3CkQGPDW9FAvAAWIjLjuWUv9a1AqkdMES/iRa2TawAND9ynOGX+8fkF7IUzmenwKlBvJn3UWYiQJ9duYwKsYccwxfleQkSTyITZZzIWatvescfJ8F3+gTkMFb9eyZDKCQG6r/xQQ1I2Y7Ylc1cfZ5hikUHfzlZd39fMA0ca53D1KgViypqfoAHPqbeoPqsTNJ627LdRFWlp/ZRzo/LAGmF5Lst4nfjIKMetm6W/BUjeCviZDBTI01D3Qmp+QsPA+MxpASypV78WSLXHDW3pff4voNwFjIrDPmGNDVK28hBWl3QWUeBNG4s2H0I98BzYILAb38vjvug9q2CnOgmPjVs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d00aae1-c204-4b6d-65a7-08dc7eae29d6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:36:07.2397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4X80sMRT2/zshg1KNS53hmDs1nu6M3W8+fLTPkJKwYxN2uDjt8nfbLCOU6hHtxm5Bj7RNoOg5a11zBMqPnI3IgDSsUZ4oVXHeBdav76+C+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280003
X-Proofpoint-GUID: rZoeRqIuWdDNU5XlM7OSNSEjdQ3SA93A
X-Proofpoint-ORIG-GUID: rZoeRqIuWdDNU5XlM7OSNSEjdQ3SA93A

Reuse sched_dynamic_update() and related logic to enable choosing
the preemption model at boot or runtime for PREEMPT_AUTO.

The interface is identical to PREEMPT_DYNAMIC.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Changelog:
  change title
---
 include/linux/preempt.h |  2 +-
 kernel/sched/core.c     | 31 +++++++++++++++++++++++++++----
 kernel/sched/debug.c    |  6 +++---
 kernel/sched/sched.h    |  2 +-
 4 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index d453f5e34390..d4f568606eda 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -481,7 +481,7 @@ DEFINE_LOCK_GUARD_0(preempt, preempt_disable(), preempt_enable())
 DEFINE_LOCK_GUARD_0(preempt_notrace, preempt_disable_notrace(), preempt_enable_notrace())
 DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
 
-#ifdef CONFIG_PREEMPT_DYNAMIC
+#if defined(CONFIG_PREEMPT_DYNAMIC) || defined(CONFIG_PREEMPT_AUTO)
 
 extern bool preempt_model_none(void);
 extern bool preempt_model_voluntary(void);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 349f6257fdcd..d7804e29182d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8713,9 +8713,13 @@ int __cond_resched_rwlock_write(rwlock_t *lock)
 }
 EXPORT_SYMBOL(__cond_resched_rwlock_write);
 
-#if defined(CONFIG_PREEMPT_DYNAMIC)
+#if defined(CONFIG_PREEMPT_DYNAMIC) || defined(CONFIG_PREEMPT_AUTO)
 
+#ifdef CONFIG_PREEMPT_DYNAMIC
 #define PREEMPT_MODE "Dynamic Preempt"
+#else
+#define PREEMPT_MODE "Preempt Auto"
+#endif
 
 enum {
 	preempt_dynamic_undefined = -1,
@@ -8790,11 +8794,11 @@ PREEMPT_MODEL_ACCESSOR(none);
 PREEMPT_MODEL_ACCESSOR(voluntary);
 PREEMPT_MODEL_ACCESSOR(full);
 
-#else /* !CONFIG_PREEMPT_DYNAMIC */
+#else /* !CONFIG_PREEMPT_DYNAMIC && !CONFIG_PREEMPT_AUTO */
 
 static inline void preempt_dynamic_init(void) { }
 
-#endif /* !CONFIG_PREEMPT_DYNAMIC */
+#endif /* !CONFIG_PREEMPT_DYNAMIC && !CONFIG_PREEMPT_AUTO */
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 
@@ -8925,7 +8929,26 @@ void sched_dynamic_klp_disable(void)
 
 #endif /* CONFIG_HAVE_PREEMPT_DYNAMIC_CALL */
 
-#endif /* #ifdef CONFIG_PREEMPT_DYNAMIC */
+#elif defined(CONFIG_PREEMPT_AUTO)
+
+static void __sched_dynamic_update(int mode)
+{
+	switch (mode) {
+	case preempt_dynamic_none:
+		preempt_dynamic_mode = preempt_dynamic_undefined;
+		break;
+
+	case preempt_dynamic_voluntary:
+		preempt_dynamic_mode = preempt_dynamic_undefined;
+		break;
+
+	case preempt_dynamic_full:
+		preempt_dynamic_mode = preempt_dynamic_undefined;
+		break;
+	}
+}
+
+#endif /* CONFIG_PREEMPT_AUTO */
 
 /**
  * yield - yield the current processor to other threads.
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 8d5d98a5834d..e53f1b73bf4a 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -216,7 +216,7 @@ static const struct file_operations sched_scaling_fops = {
 
 #endif /* SMP */
 
-#ifdef CONFIG_PREEMPT_DYNAMIC
+#if defined(CONFIG_PREEMPT_DYNAMIC) || defined(CONFIG_PREEMPT_AUTO)
 
 static ssize_t sched_dynamic_write(struct file *filp, const char __user *ubuf,
 				   size_t cnt, loff_t *ppos)
@@ -276,7 +276,7 @@ static const struct file_operations sched_dynamic_fops = {
 	.release	= single_release,
 };
 
-#endif /* CONFIG_PREEMPT_DYNAMIC */
+#endif /* CONFIG_PREEMPT_DYNAMIC || CONFIG_PREEMPT_AUTO */
 
 __read_mostly bool sched_debug_verbose;
 
@@ -343,7 +343,7 @@ static __init int sched_init_debug(void)
 
 	debugfs_create_file("features", 0644, debugfs_sched, NULL, &sched_feat_fops);
 	debugfs_create_file_unsafe("verbose", 0644, debugfs_sched, &sched_debug_verbose, &sched_verbose_fops);
-#ifdef CONFIG_PREEMPT_DYNAMIC
+#if defined(CONFIG_PREEMPT_DYNAMIC) || defined(CONFIG_PREEMPT_AUTO)
 	debugfs_create_file("preempt", 0644, debugfs_sched, NULL, &sched_dynamic_fops);
 #endif
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ae50f212775e..c9239c0b0095 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3231,7 +3231,7 @@ extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *w
 
 extern int try_to_wake_up(struct task_struct *tsk, unsigned int state, int wake_flags);
 
-#ifdef CONFIG_PREEMPT_DYNAMIC
+#if defined(CONFIG_PREEMPT_DYNAMIC) || defined(CONFIG_PREEMPT_AUTO)
 extern int preempt_dynamic_mode;
 extern int sched_dynamic_mode(const char *str);
 extern void sched_dynamic_update(int mode);
-- 
2.31.1


