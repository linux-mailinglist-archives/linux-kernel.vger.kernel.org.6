Return-Path: <linux-kernel+bounces-410214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1629CD658
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 06:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D23BF282C9E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 05:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3B91684AC;
	Fri, 15 Nov 2024 05:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hJD/TDhJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SxxEOexR"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF8374BE1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 05:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731646828; cv=fail; b=NEht2FmG7/M9WLdpdndQFXn5SwFiVVaPHC69JnIAYLU6W3/AGt+i0UVD50Vp8l2k1FzXPA4r56xP+12CUW6pyQuUnYtYKMhbQdtdirPiHRvRl9NPzNO03XsIxOITQhlUKe9OKGPeIPLmDre2WUF3OezJBBBfB5k+Hy+Cqj/N1SI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731646828; c=relaxed/simple;
	bh=rQFJQd5cEP0SpDMqOrCPPgvGYznJXC4oI3DZa6uZ/hs=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=Yyx7utZbTU380qTVLkBD8qj8WFfbXY46C5q8v+5aKvjowDfhNkN2ukD8Cr44+svZLhLRxYH0fEB/Nh1UsZPDiTpaTB7N2Tf6EUXu00skhyFbJql1ZwkRdtaG7Sz2asNtaLHPBvvEbZJ6Ah4JZu3UGE1aMvxoDFn8Vz0y5jnAcCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hJD/TDhJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SxxEOexR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF4BaVw008055;
	Fri, 15 Nov 2024 04:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=KNel9lz+q9wA/pdfC7
	ts8TK9jHEk9PqtforBD+nF7Cg=; b=hJD/TDhJx62dFA/at7zeNNNCFjtmx85oER
	ZtE58+bJyIS4I15aj0+lRtZD8gs3mUogp3+RyqCC4FLz2qK5RyaDDzTcbDwJ6Hzn
	T1j6LBLeVvtnF+9GX4u8NNs36GJBcUiYVaWqFWtQheAzVBLAEvru7v4gEe1yGwbM
	FxhvUdRXz3KNgEP0MbCXNXldHEfxVvoH4JoClSPMnbFMl3wKBtPAT/AiwZp8VSJW
	U0CmeM29qc0TpE7V1J/Eq0PW04Ki4XcieIlt33z1md8Clh7/kuS7RvLDzpgDnBkz
	ysaiJgUxpBWWUnA6NL8yBCkXgiA8H8caOEb0RriojsKPk4BjocVA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0kc2sjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 04:59:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF4YT2w022682;
	Fri, 15 Nov 2024 04:59:55 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42vuw280ng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 04:59:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VW/HbomcH1dwTG+8C8kwB0K/1gLXeH9najDQnjHCp2ICFbYeKFi9YPJh/eeEkwSOT4GuIEcXILgQ/WpZpPQCNImFQXaYG73fANgKpEsepEnW8xqn+PmmqEOHE1drxzbskEzf0+ceUNqFLxuNADn/KSnKl3tf8oIcCwG2HIzzuD9dMmy+MQYQGNkqF1J/QUqJLZIjHGeMigvCuP3pauTC+L4gMtTmLqsV1/bgRYmxpT2noXXetHB6oUhVCGF0ESDUb/HsEL/9wDoFKdePckMAh4+0STdG/LQY87KTIBfEX0qHYZa2CKP2DlVHsBYdvkHGB+25K6dn2HuNmHUHQmy9wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNel9lz+q9wA/pdfC7ts8TK9jHEk9PqtforBD+nF7Cg=;
 b=QRvu/XzFv2YHo0LTjRKWKblLW3K15h+tZ9nbD58SvUo5rYSaIakzbGZFUeUNY3rGbtdBv0Z4TS5kJ+dfxOzPqGRQuHtW79wKW2LWD99r8qYrG/iApjcGW+QQhwgE4ZBVneHH1csHn60H1tA4+k7JVEwUQgnFN8Ve6fuqyzbLgEQuNNWZkddIkbT8NOFCCt6C58OfXrUrxSysWVzGFaUqw7FU9QkV+XIPipvu8RtQh8QlyprxbHCc4RXozWR+zDovPh6IFvDWqPaKnvOIGvFmC+SW7R1++KjP3PmUAbXevR+iz1WLTIVGpok9KbJYtGlDwWLoO+zmpKn594hh+0DOIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNel9lz+q9wA/pdfC7ts8TK9jHEk9PqtforBD+nF7Cg=;
 b=SxxEOexR/re7f4m+DK/N5zTCeBagvExPglXdSCBRqkq29zHS/odZJgEieVQw6GF9YMACB4Iet9stpEigGOwMBjfed7zP/p/1tUZyCPp9DRApf3oIeRzSKAvSlpcdJD9J3re7dhdMpIXBxD4yND4lWieDqWhkasoA6EEazFHPRPI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BLAPR10MB4946.namprd10.prod.outlook.com (2603:10b6:208:323::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 04:59:52 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%5]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 04:59:51 +0000
References: <20241106201758.428310-1-ankur.a.arora@oracle.com>
 <20241106201758.428310-6-ankur.a.arora@oracle.com>
 <20241114092225.lVdeX1wG@linutronix.de>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, frederic@kernel.org,
        efault@gmx.de, sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        Daniel Bristot de
 Oliveira <bristot@kernel.org>
Subject: Re: [PATCH v2 5/6] osnoise: handle quiescent states for
 PREEMPT_RCU=n, PREEMPTION=y
In-reply-to: <20241114092225.lVdeX1wG@linutronix.de>
Date: Thu, 14 Nov 2024 20:59:48 -0800
Message-ID: <87sertnlbv.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0312.namprd03.prod.outlook.com
 (2603:10b6:303:dd::17) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BLAPR10MB4946:EE_
X-MS-Office365-Filtering-Correlation-Id: f8b5a93a-be5e-4b4b-911d-08dd0532568c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?61n3sPwxP/ptwtyaJ+0Pn6/2JQMFSGesdOJ7uvxc5BwdV2i9OIDe4CfskP90?=
 =?us-ascii?Q?ZINdVykyGaa9IBNJX0rNIKiXGGxL4b05RTUXx4ge1ZkvxOGnbopUVEdVIek0?=
 =?us-ascii?Q?3YjGgKp4ABIbsAjvZnatIpWQ4Ag7w+ILEJWUf1xUx9p6lQNVqySngNWkJic/?=
 =?us-ascii?Q?hXeZv6sMFUyPqEQvTAVF/B8HEu64ZfSTGGAlZ3oz1igl5962T5BydHnK8qy7?=
 =?us-ascii?Q?3syx25ya//9+xnNrhgz33Mh/gbYUdJc2ahGocpOlf4l9IYuvL+VJJkBpJdKY?=
 =?us-ascii?Q?ZON5Qo02T9k4TB/JcGpm1NATQulw5TbULZt+yEmgtJCGjiUHoLY8CFaYSbZp?=
 =?us-ascii?Q?dfbU0F33kP3yIjUq22OeUaGxtzMDq/bXZ1i5uBanqqTesbl2Wc3mZImU7R35?=
 =?us-ascii?Q?eRX5I8CQj1E8OBYuiomcy8xckD+mr3LwXMiNPEFpTJQOLn/cRxwInHftjCkg?=
 =?us-ascii?Q?WgewUpiXap0sIv8AtubGweaqNeqa9Tvje1GxkSGNmpWcGJd3a+BHg1pA7rTJ?=
 =?us-ascii?Q?b2ewL94J8YssCOI4aRpl+mOWGUDUL84HeXZQmh4dEUGdMVlg9gDMXQ4I1MqH?=
 =?us-ascii?Q?Kk8q/TKRNh8u+kYKBylyjO8VCtUWAp0T+EcDgTkU7FdJzzyCRv9ynAM55Js2?=
 =?us-ascii?Q?NbtKri7SZZQdQ3gJzlU5/koQ+JCwF7KwvgoLG8U6M9IuO0VJbtKmaOXNCa8P?=
 =?us-ascii?Q?WHHNA3jgv4fErITj4yXs8zzH/7aaPkHP3a9pfEYUcwrh+F30XAuKFTA1+cHW?=
 =?us-ascii?Q?dC31kQyxYu3i9fWmNHqoFKKmwmvxPQvfksEJ/QF2EAqNN9p3i1+Omo2MK56x?=
 =?us-ascii?Q?Sp54hp8PAcfF0qde4T0XVc8SfOMgiZF6BQISYgtZFUAB0Qz2uRa1vxuTm+uq?=
 =?us-ascii?Q?iS1ZZmzFb/4rNtdHbekZcTNJ/O4iwItQV/IsESKkoIymD/zUk/ObqjBOzGzb?=
 =?us-ascii?Q?ouQGeyRqabDLY3nk1vAbpDBidkEvcKb/uO+w3zEl9wiCPCSKW7T52bxX43yL?=
 =?us-ascii?Q?t3gf1YHFnAK+Lo5UxQLAL7gP1NEgA+69MCJ6xCbe8g85NUPQ+2/sdG9gO2NG?=
 =?us-ascii?Q?L6Ji7Bj7YJe4NKFcoi4MuQvfpxu4plRSFeXW/X/v7Dl/55UElnQq+uiFq/7Q?=
 =?us-ascii?Q?wxinjvC5OHWGe3VXsqhtO1iYzNBMPK8Rmfio2kLBWkU2nnAO7MfD8wdI0Vez?=
 =?us-ascii?Q?V8kLlYIy8Qpvje+iV8z7MsSLfVVGPX6HA9w3sOci96pu0yxaEZO/56qGBajy?=
 =?us-ascii?Q?MTFdHl8Y7TWDOfBSV2XpDA3QaAZp2sbiO4efbiiTMu+DzzlOa2HOptTgywfZ?=
 =?us-ascii?Q?d8c/eeeaxFaWm58/ID3nD9L8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?69FRcgHUfnTQQx3uGGTxonYG6DX5O9jNZ15pRW6iOY6ydzX9rSoa3c1S8zoV?=
 =?us-ascii?Q?qsZ/AOQxlSR/ewPxQW6Qq9srPSG6yTHDMmy/dnIM4Kn9Q/67LKtjbyqroHNY?=
 =?us-ascii?Q?OBmOsQI94fOBq6z2V5iyT6/7Vedzx0A6ToEAuGzEzjVTu0Cm76CqlSuT0w/5?=
 =?us-ascii?Q?fMAcLweWu6RFZESQVij+u/o1H4BjRjSTu8S31zUwwGhpva6RBipQZV8WgMbp?=
 =?us-ascii?Q?gygcfPovCmgLINoJTxwdk4v+Ogo4EbgycbFmm3+uLdeLVYEonbAlq/rlP5M+?=
 =?us-ascii?Q?QBGMQVjgWRIUXvMNftm/7YZxyAnWeAYvTVtdnQGBlycUeLKYivtHeRc26IYt?=
 =?us-ascii?Q?3HJyYLTSEEfRwKs1S5XbeMnrUeTswSixqggacFeElTCmG7aKjlKahlGGX85B?=
 =?us-ascii?Q?lm4BjA0Cm7MorA+rw7RZ3gJamQUAinYkQyPk4+bEDQ81A2X3J8qMk4IA1VJ2?=
 =?us-ascii?Q?jbR3rd9xDW7z99SQxMCS84BcYsiDbqmntUAozmjIuP7zLHQqbi9puFpgRW42?=
 =?us-ascii?Q?utQ2sZwivdJrXK9ZbLgDlAIw1HSdMLuRZr73ua9PIz3mkPSqXtzEvjAtPHUh?=
 =?us-ascii?Q?2wy9Jod+VOkjeU/JJPv+qDMIXDgJI0pTp5vAw1EhdevMlJVh8u90l+9J2Ab6?=
 =?us-ascii?Q?EhPM/EjaTg5Wr3+6t0O9jZKn4IJHnua0l605ftxSaYw/4axHvROLgswCXnzr?=
 =?us-ascii?Q?mXMVp32Vxda7k1BvPBOMfv/ACN/H61UDyFghpkbyRN/GvboAzTugYk+3j+y8?=
 =?us-ascii?Q?zWQGc63tMZuHZlnjQi4I154Ci74kFNUjzmHbB4fuIuWdvR/AhbzAh2eTa5gT?=
 =?us-ascii?Q?I+rbTHWxZ/rrMHkTrpAgLGro6Xg4Q0gYeUqxmf4ReWB+dVKz4w4wrnQUolUQ?=
 =?us-ascii?Q?JNctYRLVbiYPQE1OaP9ml7VKGNDu74tvcwOYKZyzgFrcGWkxqhfbAQZFwF7I?=
 =?us-ascii?Q?2nvNvz0R64ZWwgoY1XDsB040DB0yrILV38gj/R7Na0try8e10LdjJ8tcNP5h?=
 =?us-ascii?Q?kX+SK10VM9SBxVjE9D01HW3w3SUb7UB7TWoyMaIErcVjss0fUO7GkAX2CxHh?=
 =?us-ascii?Q?xvItbkf88+ocvNarZqHWMMoQoZNVPC01u9dF7uiT0x0KgrisemEQYFh3FT5/?=
 =?us-ascii?Q?aSMVkOXfJ8AaCRGlsBEvR3/WDQz9y0H8KAvZ5WLpFQ0x1UMPTNTOdKAlmzUX?=
 =?us-ascii?Q?UCMgpg42WQYprpQllPmnp95my3O94KX9hlmZf0ivweA4yFU/+A4kPnyzu6f9?=
 =?us-ascii?Q?jQC2O0EeTrjEXrFfFnUzo3fMU4Ecc2LOiMw4J/Uj1TRPyWaFuQa5AM6O9U8F?=
 =?us-ascii?Q?HhflF8oCpiUn5UVUTppWs0VPjbgu8bGcc6gfzwGg6QxstsX24xU5S258/peA?=
 =?us-ascii?Q?Cr//8IYg+gQQGDHb4DEaQZ7EER1HeBvfVSLxKNn9glXiek10YH3RNLiNq/DC?=
 =?us-ascii?Q?PMUo+/8spHlEf1BIVpSzjixV0KVciiRFRbjMKcctCVHpxO3OuFQQVrv/nHb0?=
 =?us-ascii?Q?6t4oeArdVA14YHLCwIbqJTN6uFbPmJ3sDnKuUsAPgTV09x4ndQ+Xd1AylsNz?=
 =?us-ascii?Q?yXXPM49G9ZFU15iS+EoeTIp7i5TE7NQBf3TKNuZo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vkKCVN0CWKRv40l7sZk6eV0/UMEQ+vMZrTYrjEAu7bPnc46xDVGGGpHtHyNY1vuioG1eleKCUwHgJi1VUGEAOcCLJDasDcsHBNB+aCaFnTK24fYZa9laMocfbbS5d7wrr+KHrUAQYMVdavQSfgRipYNniqsflBTAo3pObXPBR8GamKZggTyvEcJZ9eaozqJrTy0r/QoTTT9ANUSqgUos4OgyY7rwJS9SOEhDuuNcfNl2axqrZMCfU73TDmHtetrD5qQV6ncgMmj1goOoBVhiRX7tQab2D3mtEuArhWaK7rNw+9TimYBvmuV0bGL1e4T9bgp2a3eE84umqF4wnTegVjKx4UqyOAp+sgCJGc8Pm/EnpUzcsItjh9TsJBFJjSuO1OMLaTovkMcJPE5YLGUk2BbiCMHZbaNCTyBkzjqBUXoqWbwjF9tNuQay8UDXntQitmbInPBz0FD8PdM8zLcDVxBx+B2wkQLOHgmFLJXMKxI4qzkVXYMeTZG2DdhBDRNj5gpkxc71uwuuiWqwulggQQ4x/pbYTDC+AeC7yfUKXvAfmDfWFICWLJc3eDnYQ2TYdizSR4G5WX/oSJNrsxYOuy5Qx57S7NHrSKZ5U3isi2Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b5a93a-be5e-4b4b-911d-08dd0532568c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 04:59:51.8059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Kaoq+DWVaEu/7hS9v3s/T0oM3hmyxPkYsVrg7Zr1nuXhaJrUSsEnkJuqN10ziqaz2KFVOZrvXCRhitwO9ytoKJ03LBwHIoZAchLlYG3SK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4946
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150040
X-Proofpoint-GUID: zbjPqhU0A8wdQV_2xTNFUC_xnCNShJfV
X-Proofpoint-ORIG-GUID: zbjPqhU0A8wdQV_2xTNFUC_xnCNShJfV


Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2024-11-06 12:17:57 [-0800], Ankur Arora wrote:
>> To reduce RCU noise for nohz_full configurations, osnoise depends
>> on cond_resched() providing quiescent states for PREEMPT_RCU=n
>> configurations. And, for PREEMPT_RCU=y configurations does this
>> by directly calling rcu_momentary_eqs().
>>
>> With PREEMPT_LAZY=y, however, we can have configurations with
>> (PREEMPTION=y, PREEMPT_RCU=n), which means neither of the above
>> can help.
>
> The problem is as you say CONFIG_PREEMPT_RCU=n + CONFIG_PREEMPTION=y.
> You can't select any of those two directly but get here via
>  PREEMPT_LAZY=y + PREEMPT_DYNAMIC=n.
>
> Please spell it out to make it obvious. It is not a large group of
> configurations, it is exactly this combo.

Makes sense.

Will do. Thanks.

Ankur

>  With PREEMPT_LAZY=y + PREEMPT_DYNAMIC=n however we get PREEMPT_RCU=n
>  which means no direct rcu_momentary_eqs() invocations and
>  cond_resched() is an empty stub.
>
>> Handle that by fallback to the explicit quiescent states via
>> rcu_momentary_eqs().
>
>> Cc: Paul E. McKenney <paulmck@kernel.org>
>> Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
>> Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>
> Sebastian


--
ankur

