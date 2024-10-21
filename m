Return-Path: <linux-kernel+bounces-375009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 972AC9A731E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529DC283824
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CE01F9A8F;
	Mon, 21 Oct 2024 19:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W+Jlvs3v";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PlPGDTbm"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497F31EF0B1
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 19:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729538512; cv=fail; b=kEGJ9tYMVU8BjSOg+CBTcKMNldssaSRKx7pIbYzdYH9ygX8i5XW0HQO+o8EBG7vWKa7Eo6uPrQT+biaBrn0hTVGYWYb20pJpdsR7Ssytfzry5ckTW5RCD2CFvp9n0bQG0ImpYSyuHa3S+tcpfpT6/yABpviCkfW8Bq6R1rA7wCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729538512; c=relaxed/simple;
	bh=wjcXZ7ks/7PV0S98/6XGdfWs+iqxKwyyLsKVVfUIkzY=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=MA6fefDLF3HTm+q0JlwUOFLU0Fn8a54/2bREsKCZ5+bYkV5NqpW1Jm3cckBoP/smZueAwHjMCNjdAZSNvx564pMwaPhpwrxpbsjM7crTp/SfWz/00tpaxVs7FK0c4/orzckt31VWNfpGCX+SLwKKRaS6chL6R9uzOKis8kawdOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W+Jlvs3v; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PlPGDTbm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LJBcYE001344;
	Mon, 21 Oct 2024 19:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=r7VS5++IzV3WowXsWR
	NhVvLir5MbyTxAnDkvtsgMJ2A=; b=W+Jlvs3vVMZvQPgJLC/HIztT/MmvMjU3UE
	cclYRmsQRckBc2pCcjZ7ia/shRXn/R+dh2k3Zh6roiEzSudhLuQD0SaGQGmkTXP5
	k2DY1G+4/EMdv9+Em3O9hVCLPgqcc/GO5P6eaiuxzl6IsjxHF+3k6VcymsR54H8j
	rdzu0EJ1dMFxePn3Zp80Hh87vUOOeEFLI0F5gXYbjcrNbFsvbJUXPTc2F72aCnSa
	cWszNku0qp3zWF8YDLoxlHTm7Z3NcS7Qk+XLNRgp1Ya23vHZchBpV7TkquwZ8a/5
	UtsT2EcsrQEXUIvmryMeaZAzM9xp1PeCcvH9YxXrg/+e/B8KOhAQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5453ybm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 19:21:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49LIOKed035240;
	Mon, 21 Oct 2024 19:21:18 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c377gqtm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 19:21:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvqFB5byAtI4DkLMrLOWNuMj2On1P1sRQqGWC76827eL+mEkODpAT8iHXRSTZNWfh3ozONrTr9KL26HIrXkLJf34GT4n1WNBKEfG70mLWc3F4UBEwFoK0A49anJDqkd2eUhLhArmB+/+fe/XfImrelZsCsCT3Uw4pypRaHI2HX5oDJfnaHMji8461zHsSRKeDJYINpRhs+BHI7mIlPBvy07odicpueJ3Zc+STKe2KBEL5RWyCVMV//0V/bvDj7y678DZDRfYOxFGIIf/Ud5ZlThSF0FCf4QXicJhaD+phE7Hy+C3+c5A75KLIESRRzmieMFUueDDMH7TvdVabLAKvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7VS5++IzV3WowXsWRNhVvLir5MbyTxAnDkvtsgMJ2A=;
 b=QMLbzfk3mia7enH0w9WGaCnEb/eLB2C9xCQb4z+nGjyQdIJXUxJjZH/94pEC7td38mg0Tsg9l0fflrnwgga/+942zwDok+fq+x/H61RY6pRivjC5YT+vwhy9cQfiXZh6FB6YVqWEsYFNnjXhS/uRZY65KNI30FvIAglaeq5+eHNsb/ACZ9bxyclx8CguXGv/uCS9YoPaseg22X/FU4/+c5fOamw/y+5/Evs7crTR5fFgpTVagNW8A8uZe3RsbBCpiCMTozb4BtHXI33Yw2Pp7+9nMn6GZJx9QYF7sBwDJ+moDUKQK8tew3klxPDJlgJkRqR+TiGsNETrFe19tBGFKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7VS5++IzV3WowXsWRNhVvLir5MbyTxAnDkvtsgMJ2A=;
 b=PlPGDTbm6x1TDz599mGDwBWDA3kM1m65b8Btv7ExM7gMNrlz9FdWI8rZrnRuA7V2NIEBxBmwLZz5emCH3+6C86Ur1oi0NaBHNLzARw6JtFzug1a3LbAXXoeUQWy1eGwVwxJcCq8kW2b5uqftMOlK2TqmtVZXIk2ljUQpDCtHaWo=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BN0PR10MB4917.namprd10.prod.outlook.com (2603:10b6:408:116::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 19:21:15 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 19:21:15 +0000
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-2-ankur.a.arora@oracle.com>
 <c8dd612a-1851-471f-b5c5-f4201593e7b0@linux.ibm.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, efault@gmx.de
Subject: Re: [PATCH 1/7] sched: warn for high latency with
 TIF_NEED_RESCHED_LAZY
In-reply-to: <c8dd612a-1851-471f-b5c5-f4201593e7b0@linux.ibm.com>
Date: Mon, 21 Oct 2024 12:21:13 -0700
Message-ID: <87iktli7o6.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0176.namprd04.prod.outlook.com
 (2603:10b6:303:85::31) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BN0PR10MB4917:EE_
X-MS-Office365-Filtering-Correlation-Id: ce7c2fed-6ebf-471a-f5c7-08dcf2058818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oC4oHZR51jibrsnLdihJF0dPOJp/waXN/x/TT7SYLTh/IWQXs4DZvxGfHSnO?=
 =?us-ascii?Q?NHjM4RJkzo6At0SlSW6MKff0qdVOSejWBedY9oCebrNEznGUALSxTY22UaYS?=
 =?us-ascii?Q?dziGKyMPcGv7sO8cMPQfbTmF8ylYHe3Tr6/1SmL5Cie9W7GZQq8Skaigwpnc?=
 =?us-ascii?Q?7UEwOgUasIVhw986cC6QVAObH9Hw2TZH7VrBoM+h9ZoR4Z37lhJXXjukPqtJ?=
 =?us-ascii?Q?q+xbJTVxkgjIYtQ2nDr+e1Yv615aRQna5eJP6ko7vRACUto10rrEWWDKzMKL?=
 =?us-ascii?Q?5J48tOeW91Algz8TFg6BPv9+WSwz5b7pMT5hGGzioHvAIGGk4kG+UybqJk9p?=
 =?us-ascii?Q?lOWMWUHffU6JCG1qH8+gjYnil2qTWQOz2n/f31aZR7gDm8/uvQV3k6N5WOLQ?=
 =?us-ascii?Q?5yga6+slNjX9HEciAcQZZ0aq0IreyXv4303rPBguJMUc6Mt4SEIVA3KLnV9C?=
 =?us-ascii?Q?pBFsXeA94s+h7QiSpJwvsrgKwamaQzF7+++DPAqdEpGNdrn5ustZzrFNNd5l?=
 =?us-ascii?Q?9sy1YkqeQcUfi3eziEHuurstT9RXiEmSCJ2Kzl4YwiW1lE4j/bTqfPobIe48?=
 =?us-ascii?Q?3jN0HCrO8O2d9A89pzL3gDf560czf+bfpvXhCvIT7QA1GORRBAeNo8kNqO4A?=
 =?us-ascii?Q?nq1n9opvGg2n74VnvZDPYFxxV0jU94pBjO3mWOyfQ98ciT/HspUoc5NsgiIN?=
 =?us-ascii?Q?juEu3yCFP7oxbo76Ly1M8C/DepJ4+FlDl16rGFWS0h3yB0r/Z9rCgEee6y/R?=
 =?us-ascii?Q?effttxoK1cGefLt6AgB3jG+S0+5rqqcX/OrKm8wVeevRsgAfISQaGqWQ5wAi?=
 =?us-ascii?Q?QfLv05gN0g1tuBusUlEV+9KRRCMTV+lHCNm5VDomESM9TJg6ZG3iXnoLpBuc?=
 =?us-ascii?Q?tPYew6V+NixEeneDq/459IWjII4z4asmDmqPxFbQqCKQljt2sIBJVbs61n9o?=
 =?us-ascii?Q?Q7peCZPVEh7fKvHBofUUVA+2zXokAYP1FrbFWGw+o8i0Q2lTTCRWOHB0kxEs?=
 =?us-ascii?Q?kc1NV+hbuW0lgSRPUNghqmRGcsQEjPtIaRxSGrQE/k1C1jUKSee0S2va3S/6?=
 =?us-ascii?Q?p+XCm53uLyU38rY6Wdg+lQBHA6qGdHWtnflf2pTSQkhEb7GulifvkuGAG/gn?=
 =?us-ascii?Q?kB0O7NHCC3tWFHmwVVk25zfk00o9PQMCyQoklWjgtsFGgs7AzOf8YVbmg9MH?=
 =?us-ascii?Q?8M2hshQiz49EI7KJsQGX7jLI/2shkPHtw2gwqd1abwIs+SYyPeRY7czsfqbs?=
 =?us-ascii?Q?qTKYetoDckmMR6V+dDhy7G58cp+hTyiCPcV87u5c4cJvqpChvaRMm2T3sBB3?=
 =?us-ascii?Q?ssc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?djQiUgf850d9XgrlPBZ1YQ0ExbGAR9qflx23/hpFNRBzLOz8WN77VT+/kjAZ?=
 =?us-ascii?Q?ABcZnhelDiUk0pLkSks5aQAqqiLNXvWT+vBDJcn0tUb+3PxTd3gIOETjez2G?=
 =?us-ascii?Q?N+CgFAjcHjLY6TR4dpdbDKb/DGL+k9XJpX0H+OQd5Q+CKJdC1gtVYqFNxw70?=
 =?us-ascii?Q?2Yhf9NIEOBVg+unJf0cCbjifsJbKT9q2lxFocrZdsWtf735Vh6Ug0xlbKo0J?=
 =?us-ascii?Q?e4e67K4lBGx1cjPpZDXYIRIPITPGQVsZemZWa6KeSLj1JTVT/QdSJ2ZZQ4lP?=
 =?us-ascii?Q?0GZwqXkAtR2kv+ARLzYdghkALzY5DqI4AuSB/4EsbvoMPa6Mdimln259xtjt?=
 =?us-ascii?Q?CWwQL7OzvyUWaqa9vHUZTLhwuwdisnqIs26L0FDx8GymE2rXEM2HA6oWiyHv?=
 =?us-ascii?Q?kzjAjjzvfHlX7MLmTwR78vqMmQAGteNpKlV/ht0/NRBR6V2MypdSsI2nMkcE?=
 =?us-ascii?Q?Kn4xhtC5wXPSp/cQOILs/9mUkW+HChRupBuwUr4rEme+ixRx3nQnazWUnWQF?=
 =?us-ascii?Q?wyBjyXO5tBcEvNsH+JYCjoK0tHInMVJtJArewk2VMK3X2Jv0s8bFcjHObHH+?=
 =?us-ascii?Q?vTurIzJc/JINJLHoPg+j8tNuQa9ZCrSy3bL0u7DGnW4lg9UNY+t+KVN/2TYc?=
 =?us-ascii?Q?AHVht2uVavN02qKT8HxJA6A4UTLYCw/7Ez6ycPtgggyM/ZhBqOF5LN3uNj1C?=
 =?us-ascii?Q?HrFtl9aVKJCr6AhMBKWd+h5c6dQF/tzFkhoFGuVx9esMsTe6AYjeXqDH+7Zw?=
 =?us-ascii?Q?FCXzGfn8uLthZCTWmazuYdK2ACRi+DOh6fv6a7eYtGJ9PRnziCV1AJ7YkIcT?=
 =?us-ascii?Q?cNFs7CwI5Y4wv7nm6654iQIc8/qnsLlXFCaSLraLXAS3OJFcv9AC1cCjbpEo?=
 =?us-ascii?Q?CC8SsLcOZT342Ep/vdl0upEomQIoAFhaxNh5uGlvhZ4YVp4ceJsf2v1VLWXF?=
 =?us-ascii?Q?w/cLAa8Rh4xtbK1Wo5rafI3W7oTt2DyqobQDjx7Cmar3J/5u2zw1Tsy8CAal?=
 =?us-ascii?Q?tg+lrj5JbVX8gZ8Rr860NM6hdclCvRusPxfbp3edUGtKGUdv2LtmpdmNnV1i?=
 =?us-ascii?Q?uKisqyIcQ95PkhalBLz1CHzPl6tPH3hjCHu9kBfvZOaOIuKpzp6cp+zo3kos?=
 =?us-ascii?Q?ZJRyqnb7cdh7P5I92weNOTv+EqsXJCJvVSTi5P9OCiX0hVknBhutGXE8TFnO?=
 =?us-ascii?Q?f/a27HwAsUecTaTwU8UlaSxGQbwWsRzDk4Oq5oKwt9WKW0TH5ayt2PmT043L?=
 =?us-ascii?Q?PXhxOVhJMTJvqBb2f0M9njc+us4uRBYVQ7ZOk/MDBcNZ0em+AMTlynD/OsSW?=
 =?us-ascii?Q?4ewIQ+AoMcV3Px0dKkmf14yH2xBLBEdHMq9YCgeN+3iI6EwLr0RFuyFAgnvu?=
 =?us-ascii?Q?FR6uY60IO7mgDjf2vR0Fk6t68AVR+J2C1hCZhmZuBFFyebzMW2W6Vh55UUE6?=
 =?us-ascii?Q?k3K9eYlcyjAMEMnFLLu6Hz2QGe39eg9D/GIdkmRb/VYjPajnijcn16wxSDhx?=
 =?us-ascii?Q?B+S4X1kudDxk3qRiS5X1oCAX7OxWxDDoutviDEQxyW3GhSKWn6Qk8H3fQ/f9?=
 =?us-ascii?Q?0yBjYGTYhucH6LzWI4LbazYSclVBM9WZT60PH6nZKTK4zmOY0EWoitFqvXjG?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a4YPN1nHXO3tsek9JysP8Ij7xomMBKAvRzVrjVhSexg42MiwRckowCNG3CO60aDSsfjrv+LdtYzsFJy578N37Sp46QSn8hBVQ1Q10YRfybsprje8RPnClMMUzt0yrty0CYLRN9W9Sq0Le5wmGBibXKqQMBrdSZWb5IEz3cT/fn+U60t7DFZTNCLEAdnSbAyO5DclxMyVKRvXTgbx97md+jhch8xMTiZ/IFjIWffHn17xeT0QmBDR8/uFUQlcEeFzB8+DTOZVgjOoToSflavBH6p51tIUM664l38cYVKd+nXClB3WaRP4taNBxIG5EnqCNXGyLUmULfnAhxmDq7WxVAVqbwmyXkcQozAFpZZ0gSc9vE1iitqtTns3Rm9xrpaFqLRYVMqHw4HyQO/HgDb+qxbCR/e9TxQq7RtD+54sRv4Az5M9YCTaX/C5V4898Q6BlBf6wIdO2fzB5IrfDx+EmBV69vnskrZzm8oIIhofcPAj3OlcFDdWBe8Jxm1TKWexgLF3aVdCXfPrtLq+9DhJuMRYaAztBPP3vcmFzXPgIMRzOJj9qfaAowGyMrOuxjWaDsHoUYMZ5UygNBidnlSQYycLdsYVlGZE7Q3ZM7yVLg4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7c2fed-6ebf-471a-f5c7-08dcf2058818
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 19:21:15.3326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EWiBT8HQnELPBQzueeLOqxToYyUBbWMpiYxzrWS/N2gn77mT1LrLuUIHAt4qHjED/ETpumSnYx1AdwoOcc+pagUrKx3X8p/rCxAkjPyPA+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4917
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_18,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410210139
X-Proofpoint-ORIG-GUID: Y2zvGfjp1-XLAEYyJAGjaURT_oRQf61Y
X-Proofpoint-GUID: Y2zvGfjp1-XLAEYyJAGjaURT_oRQf61Y


Shrikanth Hegde <sshegde@linux.ibm.com> writes:

> On 10/9/24 22:24, Ankur Arora wrote:
>> resched_latency_warn() now also warns if TIF_NEED_RESCHED_LAZY is set
>> without rescheduling for more than the latency_warn_ms period.
>>
>
> I am bit confused here. Why do we need to warn if LAZY is set for a long time?
>
> If lazy set, the subsequent tick, it would be set to upgraded to NEED_RESCHED.
>
> Since the value of latency_warn_ms=100ms, that means even on system with HZ=100,
> that means 10 ticks before that warning would be printed no?

That's a fair point. However, the assumption there is that there are no
bugs in upgrade on tick or that there's no situation in which the tick
is off for a prolonged period.

Ankur

> IIUC, the changelog c006fac556e40 ("sched: Warn on long periods of pending
> need_resched") has the concern of need_resched set but if it is non-preemptible
> kernel it would spend a lot of time in kernel mode. In that case print a
> warning.
>
> If someone enables Lazy, that means it is preemptible and probably this whole
> notion of resched_latency_warn doesn't apply to lazy. Please correct me if i am
> not understanding this correctly.
>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Peter Ziljstra <peterz@infradead.org>
>> Cc: Juri Lelli <juri.lelli@redhat.com>
>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>   kernel/sched/core.c  | 2 +-
>>   kernel/sched/debug.c | 7 +++++--
>>   2 files changed, 6 insertions(+), 3 deletions(-)
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 694bfcf153cb..1229766b704e 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -5571,7 +5571,7 @@ static u64 cpu_resched_latency(struct rq *rq)
>>   	if (sysctl_resched_latency_warn_once && warned_once)
>>   		return 0;
>>   -	if (!need_resched() || !latency_warn_ms)
>> +	if ((!need_resched() && !tif_need_resched_lazy()) || !latency_warn_ms)
>>   		return 0;
>>     	if (system_state == SYSTEM_BOOTING)
>> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
>> index 9abcc6ead11b..f0d551ba64bb 100644
>> --- a/kernel/sched/debug.c
>> +++ b/kernel/sched/debug.c
>> @@ -1293,9 +1293,12 @@ void proc_sched_set_task(struct task_struct *p)
>>   void resched_latency_warn(int cpu, u64 latency)
>>   {
>>   	static DEFINE_RATELIMIT_STATE(latency_check_ratelimit, 60 * 60 * HZ, 1);
>> +	char *nr;
>> +
>> +	nr = tif_need_resched() ? "need_resched" : "need_resched_lazy";
>>     	WARN(__ratelimit(&latency_check_ratelimit),
>> -	     "sched: CPU %d need_resched set for > %llu ns (%d ticks) "
>> +	     "sched: CPU %d %s set for > %llu ns (%d ticks) "
>>   	     "without schedule\n",
>> -	     cpu, latency, cpu_rq(cpu)->ticks_without_resched);
>> +	     cpu, nr, latency, cpu_rq(cpu)->ticks_without_resched);
>>   }


--
ankur

