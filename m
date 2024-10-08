Return-Path: <linux-kernel+bounces-354520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E14993E8A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 209DE1C2361C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 06:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8796D13C9CB;
	Tue,  8 Oct 2024 06:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C5TEXRDE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sYl++5R4"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3DC13B582
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 06:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728367210; cv=fail; b=hGv09Fm07EQufSOp2Cvm9yLoYndSm7Z3MHleF8X7e4FBTtz4lehvX8kt3TEy3nCj2WqBWYKFN4ElwmAt2QQ8z4nMuNwG+0/M5CWgmwjxqmaKEogERLxScX2kvO22V/8NKztYk5fVpx0xacQM2/PSdgpaXaqeLbaubZtwnwG3bV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728367210; c=relaxed/simple;
	bh=ODbj1yt3+Es9aIsjYAG91RgpTArEHzTzkuz0NlNsfZY=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=bfo1tmVUXJJ5sKcMy2g/M+Xll13ysuqYtXczIH9GkuEO5SXiiK5he4ScGpJRHzpt/RGCspFLXQPh7pkWt0AG+0oTWOT5MbslYyZXB8wIRCaNYqRW60mLRLKrkEQb60nLudHc0VxYOPdKMZoGChDJjezXd3pmHGFLb2oeMNbkKP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C5TEXRDE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sYl++5R4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4985uc7t010288;
	Tue, 8 Oct 2024 05:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=fD+Nw6c2Y6U8OYGuBb
	N/pdxiWh7PmHlMS6Ob7URs2Bc=; b=C5TEXRDEeWDjfZ1o24vkGpxwz2uYX4oWbs
	uhjRGHx5p19ipjb2eC9ZildFrhZlgyLmg95HwuOLfp5mmhoCAVwC7MgsoUkr8stt
	Q+I3NQsnlV3zAo1MoWPaax2MjvQ2Ib0feAEKUKN6ED8dJuqXT5D0RRU86RUbthlF
	IEJMH/4hG0WiX9qyIDRPdkuaaJ552w0dZLrfaO4/Z0ULBboF+r2nQSYOlb7nITEA
	pGqH7bcDnJDspCg7QLzTqQRfL5UX0IBEFRzEmRgzLX6fqZyJokylFFNFSPY822XF
	sV7iZGGDn3O4KTpPKlhA3lNdJ2FV6nQgQcNGHMydPHAM7q8d8Q5Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42308dmy2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 05:59:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49859uji024883;
	Tue, 8 Oct 2024 05:59:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwd0mqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 05:59:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0G/qUzuGQ5Hxxabb1PN8e51uAmVFh+/dk6coV1G/q5ZyxkB9wlsN42MchSK3HK3AkLIiSxZ0yPlMssemQhHjDpWOvZGj1l8Fm5U/S6Pp/wqW8q+Re8ccHJLWalTSKstUh6XsjmA7Cb2qDBz3swZgU4WOJ1z6K3DnimUOl+dQc10WzDBMypKTjjgIQTCZTZWeN/WMZiwo0l6IbRNyg4hWGSZuh8crQbcGWt8ZiCeOj/Tb0kgU/dL+WZcM5rvRx3ItVvfWiMnxwfNqbB6AprYkify1l4ztEX9AtWuHdR1hqVU8kUFh0Q3f13w4waqIu0ISp0TFfqQ/mp0WR9fkwEW7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fD+Nw6c2Y6U8OYGuBbN/pdxiWh7PmHlMS6Ob7URs2Bc=;
 b=LvaDE7DpEmUKGca9SavdMZ6L2T3UsGGEyA567i5aIFUFmb97GucLeSxd58fTl6KXuNHjYS0PLlQCdXJorVjUcd/L8+wUS9w68C340YMhOPeMnTkhkC1thIByF+kgzVKB7H+PoD3SPSDVCR9Ljys/+ggdubP3bxisbNIYXJaMr0PSbpnEZKPw9HvdSGFLp9yI/Rty9PMKUwzgY/DfD7Ufsj9WAz9GnSZ8DSLYdWAXKxAfqrkaDz6QClEeTo7LvBIRWclsX/+sbc8NZEoXPEKAPNanXrfCBEMvN7j8rCsSxmqCuzO4biz17zIrwep+yJpb8NZ+M4tBjjAUNTdp/6LBTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fD+Nw6c2Y6U8OYGuBbN/pdxiWh7PmHlMS6Ob7URs2Bc=;
 b=sYl++5R48JsWqsMqke+f7LaiXvl4aY9BqWD4JKBJQnKBKxPKKuHV00KVU6Xn00G2g+c8IySe753vQEnhlndqJ7+DkAGAT+/T44q090JmhbybYbgqdwXRcb/6bk3SvryVFHRoHflC4oJ9zfb3aLTsL8rK9gL4Zdm/y18qUc5aFa4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CO1PR10MB4434.namprd10.prod.outlook.com (2603:10b6:303:9a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 05:59:26 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 05:59:26 +0000
References: <20241007074609.447006177@infradead.org>
 <20241007075055.671722644@infradead.org>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: bigeasy@linutronix.de, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, ankur.a.arora@oracle.com, efault@gmx.de
Subject: Re: [PATCH 5/5] sched: Add laziest preempt model
In-reply-to: <20241007075055.671722644@infradead.org>
Date: Mon, 07 Oct 2024 22:59:24 -0700
Message-ID: <8734l7dtj7.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0105.namprd05.prod.outlook.com
 (2603:10b6:a03:334::20) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CO1PR10MB4434:EE_
X-MS-Office365-Filtering-Correlation-Id: 995e3983-71dc-45af-0e3b-08dce75e5d92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6Twm93Nt2dAdeWJtcdJkfMHv60fRYM1/pLlhv1L3/sQTWGbHBA6TpPQGwYwC?=
 =?us-ascii?Q?hka2uRVgtTaBffWvibsnXmMdgqJ5GiD3fm8OtIi9d0wQZyc/WEy5eZXU2TIK?=
 =?us-ascii?Q?8IexKRZ1fkDRltU75ufLxdFPe06NJ7CKaKShdpFUw2MN/sibhG6Shx1sTqZU?=
 =?us-ascii?Q?H5uwpL2SvF0QhtYU9QiaM3ZT70wK8X/8slwLHg5LY+RtduQWd+QZCRm6Wvy1?=
 =?us-ascii?Q?w20DqcFgGkiGTOwV0z0tiQNZv3l3lVr6cVVIkJGvkgdvW8RvX3ZdOog4oFWe?=
 =?us-ascii?Q?UOHi7uPo7gHcWEih5FWHsc509bxmXYhF0NJ7bgbcSiYnILAGlISEqeIC1YRF?=
 =?us-ascii?Q?KdjWu0yPRwm0BV7bInFZl6tJKSTyKDH35ED1okRWZhjnrXnji/WnWaQrQWj6?=
 =?us-ascii?Q?ejj+VjzU0BgKlbUiGvBbDt2VIAOSCOCUGABdlDlnJT9IQsHNq4DP2VXvTNrZ?=
 =?us-ascii?Q?xa6o7s33pb2jA3OxYLkX62BopD9p+L8MrB3H+wlLYmkp7mevONSzY9h79Xoj?=
 =?us-ascii?Q?pdTLS9A2IHm/WwCBK1BnYsYMUdUPLDLfqqqYMijbJG2nmCOv72lK4bBIS4nF?=
 =?us-ascii?Q?ATzFk3GU7cyRaI2YTe7gF+GbLC/9R5L8W8jM2cdwRyhC3XjIN6R/cHVUGDk2?=
 =?us-ascii?Q?0gFSGQP/C0RoMJRcBm/A/Yd0FoRnNiUoDIfg9orVVnJHDIbb5348wfbOE5wa?=
 =?us-ascii?Q?YplaifwkRxNB4ZXwklMWc96ap3HR/db5grtWj/2CXdYE0eNGwQObzBkCEmpo?=
 =?us-ascii?Q?cLxQzOFEIBIncfXk/KsK3IKylXQcAEaNn97SQvT4coRtExKazo4jxNZZlf/j?=
 =?us-ascii?Q?w2HeQXPX4Sys6B6En0QVYcsibHnEtIha8Bl1wQWi9XRRal8DpeUwgp5VmiGz?=
 =?us-ascii?Q?GJbe6Hb++rQgrabkeAUNa1G9VmE2Z1+eVXkMPafgQwrVJvyjVJduNyCbk271?=
 =?us-ascii?Q?KECKVk3FA8k5Zc9Euie9JmhKdjjwqiv0DnkcNrwvQbgqBIl8gOd3+XSY00rM?=
 =?us-ascii?Q?t4VQi0Ka2HvfXAwSSCBgz1DOGLTXjY2404BOWx3iyWNiJRQ95+i4Qtg9GhA5?=
 =?us-ascii?Q?RsRzquAaRXxllID28QDvXtm8Rmk9msNoZFKYUN3phDwiMbdLhCdpGKaHKYht?=
 =?us-ascii?Q?r1IXluiL50+rcqA+4hyzNDy2Nwcbf4XOBijC6Fn85nYPAlqL5lhhL28W9P4C?=
 =?us-ascii?Q?PyZJyIWpHJmqM6FnjDw9IIYR59tPhGgtGiiU2oZZ9beGhlD2dHLAurp/L1jM?=
 =?us-ascii?Q?yDvWpF03JhC+aDmMfcE8i8Pp+K03Fg4WlSug8FdwqQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2R6vfPz/UN/g78OwJo02xBz4NCupKm96Rcbxpv4Fgx9l/SR3+oYBWEstv53Z?=
 =?us-ascii?Q?vlDKpnZrdJAxZ6+QEEAF8N+qyole9biktVxkYmwEejaAUWasOSkpuXrvocTN?=
 =?us-ascii?Q?YHxmViHmlgUuy1TqXXpQwah4etWlqx5x+Iw8CoawT++o5nImoC8XP/CN7pNK?=
 =?us-ascii?Q?wt6TliQuggeHU602qmIWuCThL3ZauNM/l0yLYSXs2PXOKJODvWzrRYGeWLK1?=
 =?us-ascii?Q?5v0QFYXg8Vfpf1/iLhmMdFj2xVaCCpVunetbR7t7uUXFvYAJ9iTFPhj0UwtK?=
 =?us-ascii?Q?jjClMo7MOpRfpuvjJsTuFY1uL1WrTNdpnmNvHOoxQKgp0cTZxE1pMWcbjd7l?=
 =?us-ascii?Q?nAGLS3AE2rAM9Ebj1U7PrHmNyi3sEKcYMQcsrE8hYYrd6ceLJFDAkbA1QRqC?=
 =?us-ascii?Q?NvuDSzMT1pOl5DmjSdhWZYW/ZYSlQItJwKxPoUz4yUMObKqbDZGONMc0X8RR?=
 =?us-ascii?Q?LlxtOskmdAIpV/TP32WFl31I+I7XgPG+6pGq7iaBkpzo9XSuXH7ARQOgT1ey?=
 =?us-ascii?Q?KfKIAwGMtFyzfTWRdvIUvexfdhcihkTIOHblKDEElVu1p69SHKbxU00nkkpC?=
 =?us-ascii?Q?TjqB/nZHpVueVe3OJR5QUBQF6zzbiVS7ExtgODWAVvfG+WAxq6xTbIp3yiWg?=
 =?us-ascii?Q?Ld6xgs3w56wkRyd1ZXY8uyBavW3g9ppNG2KllQ+mrWri9RGkFVdTxWs4hJVu?=
 =?us-ascii?Q?/nOxkCsc8ckGQbT0WdS5NlHTe90kSNAfd070fH2bdrdIKa8z2oly/mwiAQTb?=
 =?us-ascii?Q?C+HlGuWOi92b9nvdAxtKsWWkYj/UOCgXUxpBXw3zNN6Ck0Sg2GU6Y7t2+vRl?=
 =?us-ascii?Q?ofF41gbgMYffjkn5OhhaSJjq9zD6PMBD6dBex3a4xaZBdtFNPjQ8hKEjjzdb?=
 =?us-ascii?Q?01gCbkJeH3ot+7hcbeWXJhQ0Q7DUv8nPaqP6aR0KdgQwzzITvYnBGibbEDLX?=
 =?us-ascii?Q?lqY3TO1ZZsa2y740AY5X+sJpo0eN8wf7ugR6IhZP53CWqKxu43VDZeL1JxqE?=
 =?us-ascii?Q?RJdJJWsIA/9G5B/gITBL8wbB6Jlkv/mCMAfXwI2YjQ8onjxv8KJ3HGo5CvAs?=
 =?us-ascii?Q?83gaRIj7P54klEW5LcuspZIwDkJl90zUxQ8ELN1wpFXFjHdndglOZkICckma?=
 =?us-ascii?Q?/8I8Na1rsE8rNvTD97Ejx93tom6WkIlwpz1AcacyEree3rA605D4C8nPwNMZ?=
 =?us-ascii?Q?YvQs9BZGqXGHp9YiVe8sz9X3FShbvcot8F4Jd/j4RpaKesxovqgHZ3CE+Uof?=
 =?us-ascii?Q?cNfP+xwfTrX3mszCO1B4/MDGahgD9mkt+swM9j648hghO2XsyRanKi3JtVpQ?=
 =?us-ascii?Q?1uYzpGjoAMk13AuvFLG5US5iZToRGh79wb6m+3RELu+q1xaFB409fI3TG4HP?=
 =?us-ascii?Q?12YMyQMogiLQjgAFjlkirOCScDYEFjboTJKsV4XWSUan7s02IQfEPb5PnnEH?=
 =?us-ascii?Q?9Ccgaum+tPR976EKx5QLOFBn5pjVCHTNdREv06F21JrbHx0hQBQ1o28TPS5H?=
 =?us-ascii?Q?Zh5LZN2V8wkWikmxthlsIzNhDwYj171UmOggTao/pcuQqdE/QH64JMkawUR1?=
 =?us-ascii?Q?eTKGgLKoO/dGTM4ZsCD8h8GmUp6b3n9sFX4WTKs1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YY+to+CIkwMvNwigNCy3bjhfhecSwhTFhhe3eJU7pa+OBPTPTLD8RExdMPC/moSUoyaNsYnbzgrpF0MoC/0VTi/J7sq/WnC1RQZxa+CUC6khLjMJpbnRYOMj3Zp2vLWLX1fK61fDkTilAjNkyjrOm4yH0dbovwKxKBxVid8xwEDSnW9n2W6NAUpNXustGLh+NW6Sdq+zuNRK3FVS7ldkFJKt5//juL76KMsrun4f3Tn+kWynddYkKpss9/TgnV19+mSWFT9hd51tmufILo5yMKEeQtrPdsbPVcCSkt5r2U5Ms/VcNDWJTO4KbMyiAceyE1lnVUDi98Xd8XWo0QwPrBO/WF1UZmiWubo/lynuEKYkbTLnWbSrLIweD12831fRmjMfnZx463zUgZuBp8+lArSS1hKqnBu6VbP/5M5qkfQvCaGRVxgWYZk1qP7xCisomR072G2xtenvSVQVGOegO6UYCAWxvoP91dE0xCcp6BrG0kRmO/xsNm92r9qky8bgQF8ZMOxqhrorkZbeEFpnYy0dzGUOfifE6LZPkhMncnGjWJz7sntiVMgclJFYkFsle0guSIKH13kGwjiSLgKukVeXs9jQ+iJg1rQQbuuUJL4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 995e3983-71dc-45af-0e3b-08dce75e5d92
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 05:59:26.3889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EFJAmr4hV9BgZALrb+8u89VcRm3kQ7+w2fJrtIKwMTBSwrRy0jJkkPqvyafI5BGkbdN5nhBq8pwx9Nm8q5x2wD07/I7NFUI/QkoWPzTi0mU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4434
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_04,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410080037
X-Proofpoint-ORIG-GUID: 5dSFjbQ34l9PvPO5IHbbUXuczgNCbO4y
X-Proofpoint-GUID: 5dSFjbQ34l9PvPO5IHbbUXuczgNCbO4y


Peter Zijlstra <peterz@infradead.org> writes:

> Much like LAZY, except lazier still. It will not promote LAZY to full
> preempt on tick and compete with None for suckage.

Yeah, none at least has cond_resched().

Can't think of any workload that would benefit from this though. Maybe
if you have a big cache footprint?

> (do we really wants this?)
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/preempt.h |   10 ++++++++-
>  kernel/Kconfig.preempt  |   12 +++++++++++
>  kernel/sched/core.c     |   49 +++++++++++++++++++++++++++++++++++++++++++++++-
>  kernel/sched/debug.c    |    4 +--
>  4 files changed, 71 insertions(+), 4 deletions(-)
>
> --- a/include/linux/preempt.h
> +++ b/include/linux/preempt.h
> @@ -487,6 +487,7 @@ extern bool preempt_model_none(void);
>  extern bool preempt_model_voluntary(void);
>  extern bool preempt_model_full(void);
>  extern bool preempt_model_lazy(void);
> +extern bool preempt_model_laziest(void);
>
>  #else
>
> @@ -507,6 +508,10 @@ static inline bool preempt_model_lazy(vo
>  {
>  	return IS_ENABLED(CONFIG_PREEMPT_LAZY);
>  }
> +static inline bool preempt_model_laziest(void)
> +{
> +	return IS_ENABLED(CONFIG_PREEMPT_LAZIEST);
> +}
>
>  #endif
>
> @@ -525,7 +530,10 @@ static inline bool preempt_model_rt(void
>   */
>  static inline bool preempt_model_preemptible(void)
>  {
> -	return preempt_model_full() || preempt_model_lazy() || preempt_model_rt();
> +	return preempt_model_full() ||
> +	       preempt_model_lazy() ||
> +	       preempt_model_laziest() ||
> +	       preempt_model_rt();
>  }
>
>  #endif /* __LINUX_PREEMPT_H */
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -84,6 +84,18 @@ config PREEMPT_LAZY
>  	  reduce lock holder preemption and recover some of the performance
>  	  gains seen from using Voluntary preemption.
>
> +config PREEMPT_LAZIEST
> +	bool "Scheduler controlled preemption model"
> +	depends on !ARCH_NO_PREEMPT
> +	depends on ARCH_HAS_PREEMPT_LAZY
> +	select PREEMPT_BUILD if !PREEMPT_DYNAMIC
> +	help
> +	  This option provides a scheduler driven preemption model that
> +	  is fundamentally similar to full preemption, but is least
> +	  eager to preempt SCHED_NORMAL tasks in an attempt to
> +	  reduce lock holder preemption and recover some of the performance
> +	  gains seen from using no preemption.
> +
>  endchoice
>
>  config PREEMPT_RT
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1108,13 +1108,22 @@ void resched_curr(struct rq *rq)
>
>  #ifdef CONFIG_PREEMPT_DYNAMIC
>  static DEFINE_STATIC_KEY_FALSE(sk_dynamic_preempt_lazy);
> +static DEFINE_STATIC_KEY_FALSE(sk_dynamic_preempt_promote);
>  static __always_inline bool dynamic_preempt_lazy(void)
>  {
>  	return static_branch_unlikely(&sk_dynamic_preempt_lazy);
>  }
> +static __always_inline bool dynamic_preempt_promote(void)
> +{
> +	return static_branch_unlikely(&sk_dynamic_preempt_promote);
> +}
>  #else
>  static __always_inline bool dynamic_preempt_lazy(void)
>  {
> +	return IS_ENABLED(PREEMPT_LAZY) | IS_ENABLED(PREEMPT_LAZIEST);
> +}
> +static __always_inline bool dynamic_preempt_promote(void)
> +{
>  	return IS_ENABLED(PREEMPT_LAZY);
>  }
>  #endif
> @@ -5628,7 +5637,7 @@ void sched_tick(void)
>  	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
>  	update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
>
> -	if (dynamic_preempt_lazy() && tif_test_bit(TIF_NEED_RESCHED_LAZY))
> +	if (dynamic_preempt_promote() && tif_test_bit(TIF_NEED_RESCHED_LAZY))
>  		resched_curr(rq);
>
>  	curr->sched_class->task_tick(rq, curr, 0);
> @@ -7368,6 +7377,7 @@ EXPORT_SYMBOL(__cond_resched_rwlock_writ
>   *   preempt_schedule_notrace   <- NOP
>   *   irqentry_exit_cond_resched <- NOP
>   *   dynamic_preempt_lazy       <- false
> + *   dynamic_preempt_promote    <- false
>   *
>   * VOLUNTARY:
>   *   cond_resched               <- __cond_resched
> @@ -7376,6 +7386,7 @@ EXPORT_SYMBOL(__cond_resched_rwlock_writ
>   *   preempt_schedule_notrace   <- NOP
>   *   irqentry_exit_cond_resched <- NOP
>   *   dynamic_preempt_lazy       <- false
> + *   dynamic_preempt_promote    <- false
>   *
>   * FULL:
>   *   cond_resched               <- RET0
> @@ -7384,6 +7395,7 @@ EXPORT_SYMBOL(__cond_resched_rwlock_writ
>   *   preempt_schedule_notrace   <- preempt_schedule_notrace
>   *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
>   *   dynamic_preempt_lazy       <- false
> + *   dynamic_preempt_promote    <- false
>   *
>   * LAZY:
>   *   cond_resched               <- RET0
> @@ -7392,6 +7404,16 @@ EXPORT_SYMBOL(__cond_resched_rwlock_writ
>   *   preempt_schedule_notrace   <- preempt_schedule_notrace
>   *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
>   *   dynamic_preempt_lazy       <- true
> + *   dynamic_preempt_promote    <- true
> + *
> + * LAZIEST:
> + *   cond_resched               <- RET0
> + *   might_resched              <- RET0
> + *   preempt_schedule           <- preempt_schedule
> + *   preempt_schedule_notrace   <- preempt_schedule_notrace
> + *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
> + *   dynamic_preempt_lazy       <- true
> + *   dynamic_preempt_promote    <- false
>   */
>
>  enum {
> @@ -7400,6 +7422,7 @@ enum {
>  	preempt_dynamic_voluntary,
>  	preempt_dynamic_full,
>  	preempt_dynamic_lazy,
> +	preempt_dynamic_laziest,
>  };
>
>  int preempt_dynamic_mode = preempt_dynamic_undefined;
> @@ -7420,6 +7443,9 @@ int sched_dynamic_mode(const char *str)
>  #ifdef CONFIG_ARCH_HAS_PREEMPT_LAZY
>  	if (!strcmp(str, "lazy"))
>  		return preempt_dynamic_lazy;
> +
> +	if (!strcmp(str, "laziest"))
> +		return preempt_dynamic_laziest;
>  #endif
>
>  	return -EINVAL;
> @@ -7454,6 +7480,7 @@ static void __sched_dynamic_update(int m
>  	preempt_dynamic_enable(preempt_schedule_notrace);
>  	preempt_dynamic_enable(irqentry_exit_cond_resched);
>  	preempt_dynamic_key_disable(preempt_lazy);
> +	preempt_dynamic_key_disable(preempt_promote);
>
>  	switch (mode) {
>  	case preempt_dynamic_none:
> @@ -7464,6 +7491,7 @@ static void __sched_dynamic_update(int m
>  		preempt_dynamic_disable(preempt_schedule_notrace);
>  		preempt_dynamic_disable(irqentry_exit_cond_resched);
>  		preempt_dynamic_key_disable(preempt_lazy);
> +		preempt_dynamic_key_disable(preempt_promote);
>  		if (mode != preempt_dynamic_mode)
>  			pr_info("Dynamic Preempt: none\n");
>  		break;
> @@ -7476,6 +7504,7 @@ static void __sched_dynamic_update(int m
>  		preempt_dynamic_disable(preempt_schedule_notrace);
>  		preempt_dynamic_disable(irqentry_exit_cond_resched);
>  		preempt_dynamic_key_disable(preempt_lazy);
> +		preempt_dynamic_key_disable(preempt_promote);
>  		if (mode != preempt_dynamic_mode)
>  			pr_info("Dynamic Preempt: voluntary\n");
>  		break;
> @@ -7488,6 +7517,7 @@ static void __sched_dynamic_update(int m
>  		preempt_dynamic_enable(preempt_schedule_notrace);
>  		preempt_dynamic_enable(irqentry_exit_cond_resched);
>  		preempt_dynamic_key_disable(preempt_lazy);
> +		preempt_dynamic_key_disable(preempt_promote);
>  		if (mode != preempt_dynamic_mode)
>  			pr_info("Dynamic Preempt: full\n");
>  		break;
> @@ -7500,9 +7530,23 @@ static void __sched_dynamic_update(int m
>  		preempt_dynamic_enable(preempt_schedule_notrace);
>  		preempt_dynamic_enable(irqentry_exit_cond_resched);
>  		preempt_dynamic_key_enable(preempt_lazy);
> +		preempt_dynamic_key_enable(preempt_promote);
>  		if (mode != preempt_dynamic_mode)
>  			pr_info("Dynamic Preempt: lazy\n");
>  		break;
> +
> +	case preempt_dynamic_laziest:
> +		if (!klp_override)
> +			preempt_dynamic_disable(cond_resched);
> +		preempt_dynamic_disable(might_resched);
> +		preempt_dynamic_enable(preempt_schedule);
> +		preempt_dynamic_enable(preempt_schedule_notrace);
> +		preempt_dynamic_enable(irqentry_exit_cond_resched);
> +		preempt_dynamic_key_enable(preempt_lazy);
> +		preempt_dynamic_key_disable(preempt_promote);
> +		if (mode != preempt_dynamic_mode)
> +			pr_info("Dynamic Preempt: laziest\n");
> +		break;
>  	}
>
>  	preempt_dynamic_mode = mode;
> @@ -7567,6 +7611,8 @@ static void __init preempt_dynamic_init(
>  			sched_dynamic_update(preempt_dynamic_voluntary);
>  		} else if (IS_ENABLED(CONFIG_PREEMPT_LAZY)) {
>  			sched_dynamic_update(preempt_dynamic_lazy);
> +		} else if (IS_ENABLED(CONFIG_PREEMPT_LAZIEST)) {
> +			sched_dynamic_update(preempt_dynamic_laziest);
>  		} else {
>  			/* Default static call setting, nothing to do */
>  			WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT));
> @@ -7588,6 +7634,7 @@ PREEMPT_MODEL_ACCESSOR(none);
>  PREEMPT_MODEL_ACCESSOR(voluntary);
>  PREEMPT_MODEL_ACCESSOR(full);
>  PREEMPT_MODEL_ACCESSOR(lazy);
> +PREEMPT_MODEL_ACCESSOR(laziest);
>
>  #else /* !CONFIG_PREEMPT_DYNAMIC: */
>
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -245,9 +245,9 @@ static ssize_t sched_dynamic_write(struc
>  static int sched_dynamic_show(struct seq_file *m, void *v)
>  {
>  	static const char * preempt_modes[] = {
> -		"none", "voluntary", "full", "lazy",
> +		"none", "voluntary", "full", "lazy", "laziest",
>  	};
> -	int j = ARRAY_SIZE(preempt_modes) - !IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY);
> +	int j = ARRAY_SIZE(preempt_modes) - 2*!IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY);
>  	int i = IS_ENABLED(CONFIG_PREEMPT_RT) * 2;
>
>  	for (; i < j; i++) {


--
ankur

