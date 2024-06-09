Return-Path: <linux-kernel+bounces-207224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 511ED901416
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 02:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D21FC28217A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 00:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEFC28F7;
	Sun,  9 Jun 2024 00:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H4xh3rp7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nTAvQQZF"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49D3211C
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 00:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717894040; cv=fail; b=XXYcTK0gJPcm/Iq/3tnH7DUoFzbXa4FS0cDvyqT3kYN6SNVSrljgoL17BZPfeVbNg6Vc4B6vbIl+WvcaVGjT4qjQlZROx2FJW0/kFe2XGURujIAqAJ41KqokcLevdsoJIxhGrgNmAudazU48qPt6kGnL7pwhdEv7+fEl9W9NYTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717894040; c=relaxed/simple;
	bh=qAhsSyoAHHgUGI8To5LxpncVro8HC3Gw6lbjoUS874U=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=NnCcwGn4uWqRzuK+zGm76E/bg+8wPS/BHhonyMeVJp+oJwVMuLvOcKVNHWcq6zwD226Icv+kbSUyGl3qeDpbDvPAVPhcyTiFksJQtwNquEX9/nXb64R8ILe2Z3oQ28CyJDhhaAvQB3xCXfofScbk1N2Vzmbc50kPsHe6lyEAKCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H4xh3rp7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nTAvQQZF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 458MkvO9027688;
	Sun, 9 Jun 2024 00:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	references:from:to:cc:subject:in-reply-to:date:message-id
	:content-type:mime-version; s=corp-2023-11-20; bh=QMK9Zy0u20wLEY
	MQwUexI+cT2MtWk686nNWFBqnxugQ=; b=H4xh3rp72L0IM5Y08Jv+4XiRDBfv4L
	2m8IHG2THC3yRQ7ATWc2s5v70zVRu3K9zpdlkEYDG9iHODZV9M2Kw1/2aeajxLjj
	9w5lZonb0hOYKmhnSR4Rg1WnU0IgUZpgb3CICkU6YUiF/yLAfkQVmQlpsxXeLLTu
	NQUeB4tFvymC2QqIfH7+I+IIY5e9YD0UFZezwQCo02lo4fZI05oxuTheXYW8UxgN
	90xHpz2wQXj5uOBIOUxgoM9O0aDHOmB/PWsD5w67L3FSZPW9kXensV5hkeBDt0L+
	ZAd6vQXO/8zfixm/4mF4JhOILE0jt54nXiRoDSTK6pyclWSHCeMTcMYQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh190jsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 09 Jun 2024 00:46:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 458Mv0Vw004878;
	Sun, 9 Jun 2024 00:46:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ymdr5g8ur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 09 Jun 2024 00:46:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfxFDDpj0gOUM2egRxpgdOVharjCrzl+J3uFqLjA5wtRTOASdiFGNolEwdcjEoK7GKY4kJyf0864enU8ZEqqF+GzlaM/GM7kAPGnA9kGk3abc14jtDGDE5DIc3usauRI2NzqZ4yRnpVu9OIgmMTJ1UvmmFhzR7Q/54xNyPYAmcOeDWBqc8lHyhtwAC3Pks88Muqmrk3mb8hxf85pu9c+T8Gs/hjIXNHQro1CLwmSIPIE3iQb6Qp1KTe543qtZiH/u9Si8kp2MX7lLzR9xUAtIuuQ9hgZMbaMLP415p1BdH2M4EeFAzFay3KBVM4DP86zuHBKtT4xYhfDhEs4gBvvhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMK9Zy0u20wLEYMQwUexI+cT2MtWk686nNWFBqnxugQ=;
 b=N4LYZdvuR3nCMBeAuvyjnLHrjTe/rCmTMCLbhwQH41tR+kBMzz6vMB3bp7xl8abNRGyr/4Yw1Bf/p7CrxmZbQcAkIHApSwsbKJC3UZH6ll7h/rOg8PSQ1MZpMkjVfkwozDyYuaQ84jd00aZhCYmleG5zaU5z2G04FQ7Tqpf4EbQbty9mEsx/kzjpWapvCjEmY4EvKzzPqsIB7THn4C38CC8tHTdEhjJmpxFvIzjTP/BXikZ9PlHkhmbDHb1ZuARcOOf5n/Pft7tsFdrKJK+riuh0yd7FJz/ko/JDJY9J0I1bp4FBRQoZA2feTkkox/y5OTqSFhNTgBy57VPDvu6ugQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMK9Zy0u20wLEYMQwUexI+cT2MtWk686nNWFBqnxugQ=;
 b=nTAvQQZFvLzprVHtesvE8FjVULY9SDhdWHiWjNBwVmt5afbxpKxXJCCZGbFC6wtzlS24Ne0dkkAyFU19Hm1hPd+J2A/MW4HJuwGrWb3ANxgoSVI65rjfJnedoJhtxKsLkZseZbYV1nTxfVYTFOP78JVrV2Qn3dESNhbpZVDxkZU=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH3PR10MB7161.namprd10.prod.outlook.com (2603:10b6:610:12b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Sun, 9 Jun
 2024 00:46:28 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%3]) with mapi id 15.20.7633.036; Sun, 9 Jun 2024
 00:46:28 +0000
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-14-ankur.a.arora@oracle.com>
 <20240528162725.GH26599@noisy.programming.kicks-ass.net>
 <87ttif641i.fsf@oracle.com>
 <20240606115101.GC8774@noisy.programming.kicks-ass.net>
 <87ikymw1g2.fsf@oracle.com>
 <20240606173218.GH8774@noisy.programming.kicks-ass.net>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, torvalds@linux-foundation.org, paulmck@kernel.org,
        rostedt@goodmis.org, mark.rutland@arm.com, juri.lelli@redhat.com,
        joel@joelfernandes.org, raghavendra.kt@amd.com, sshegde@linux.ibm.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ingo Molnar
 <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2 13/35] sched: allow runtime config for PREEMPT_AUTO
In-reply-to: <20240606173218.GH8774@noisy.programming.kicks-ass.net>
Date: Sat, 08 Jun 2024 17:46:26 -0700
Message-ID: <87frtnt02l.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:303:8e::16) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH3PR10MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: cc43c600-ff5b-42c4-6f0f-08dc881d9923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?MYuJkgPGl65gC6avIRZ61J6n+sY9+Te8V8bv+MX42sZHIzkwGUaN1T/8eRPB?=
 =?us-ascii?Q?3qgCBZo1A9GFFcFgVFLChiYLMbvEfoyp0WPTx/2xATP+jVMtFh1A/itkUi2J?=
 =?us-ascii?Q?xKfYz8vs5co/Jc4FOpiRQKmNsFnXukNKE79mM2CEvzh/kRJxnVB0JW0+HTRe?=
 =?us-ascii?Q?8F1HXU0ARYOjFC4YvVTc2fXdSmCZoMpyc6r6/CUOPmszHXHFSJlQJavgO9td?=
 =?us-ascii?Q?d1LrVfVptVYpQqR6aiSJY8M8/OgIMkWGg+TYFzYdEi9ENw8xI+d/xbKJxmaW?=
 =?us-ascii?Q?mBqtXRqq63wJ5S2pllvLIZFCM0y1A+pg5x81YStbn0o7pxPIKnIbVmLJ5Qbd?=
 =?us-ascii?Q?/Nmm1GYHBZ0zc4+o6uVTsHUnxEEeb/ViMclUDVOSTX6bzfHY5ZaO4y0ZLXEO?=
 =?us-ascii?Q?oOUNK5+ibuewMUXEBTSJB96Wj9sETklj9D4OUfW5L0JDLZMEfDGH4g+OyGTd?=
 =?us-ascii?Q?y7aBQysBtQJmDks7K3DaWGOn6m5qB4kR5q8Kvh+zmguQaGi3DJhCHkU+UwIU?=
 =?us-ascii?Q?r9hrshaG1RJasW2k5goNPCRvMwDjf0rC651LdhUPhCzClw+Aj0zqEsrZyRxy?=
 =?us-ascii?Q?w6+XoWlgeoODc9P/fx7KM0d9jc96XlROP40yfSujjfyaLpktoodCh6PJKuBF?=
 =?us-ascii?Q?A/DVeJRm5rnvOoIe5RkxE3the/GA4InpfwLrPUZAXrHu636FQZkoc6Fnem+g?=
 =?us-ascii?Q?EzVQ2kw9HUMjk4iNcXA2tpeATwtVikxNgWjAbjFUY9rgztNb3ixbNb3zE3YL?=
 =?us-ascii?Q?HUtLLZSzkqmbT1/KRMtFjNuC6xZ+LCrGd67v/muAmcnK+SK7R16VtQz8xZ1W?=
 =?us-ascii?Q?9YpRZO6+omaQIVsQXYaSdypFm72FdXizxmmfIFZy1q/nS3NwNm7ogOYHg8Xa?=
 =?us-ascii?Q?PKJhW0dHgYSXkAmhtxW5To4/CwrRnvD073DUU1IypOCfRqmv8B983/tm3+zF?=
 =?us-ascii?Q?GibANwbASBo0B8+ImKnXdcCPoJFFjOGtguAdk2S/nqhJBTzQV4VBQKxHoKIV?=
 =?us-ascii?Q?MWmHgQ9s9L1sM9AeBHouSnI/oJGkXYofU49duRH+LLGgcwco5Ld9Yu3Sy46m?=
 =?us-ascii?Q?2eP08IHHbVd8Hv0alj39q/XqPRkjs9FrtxOaOYQSF0rCiO9iW+55DKayrPgC?=
 =?us-ascii?Q?nIPebasBKDkxqDCBcWDTYEkuSTKZ+vMrx2NO62LT29uafcvunjYig+xY4gOV?=
 =?us-ascii?Q?NnVUWL9LqCOWbv9TEtnThLcSvCDb28rHA35KmuhszrpMETyaFTxdkwwyDwWC?=
 =?us-ascii?Q?gglMznJhJSbwXyLWCnhX6Okc+YZKCQqBQw1UHEoX6MoCkoUFKgKMOaGRCYBL?=
 =?us-ascii?Q?y3YXRNXaLJmDhI13sqxxnonW?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hJUPwf1t/usCSwOKo6juGD9Zo1+FDgNB8Lld0NXO0dParbQf0ltbmDmcUwFu?=
 =?us-ascii?Q?hOVG79caKDPjfztHF2C7LrE5capHhT8stnP6eI7lhu0SNW9Lf8RLQ/dcBXmm?=
 =?us-ascii?Q?DKPBL2apG69xyQ9hmItEFqeeP9x4qyYTM8SuJAQF5e9IVzVtFgvoHpoUj2W3?=
 =?us-ascii?Q?OZyMGwqODIBm5hcALW7R0Uoe2jh7iaX6boHWH1sOA8iPr2qb3lV0k2NzDv3r?=
 =?us-ascii?Q?EXIQ3WtmQ88WFdBl7REXlm1xiP8TMhooRG1tBYNG76GaUwLM6EFzuwQgJFcV?=
 =?us-ascii?Q?c6E3h2mwAYRy+j9s2qAQWWzbDp+ABL0r8uDKQwac144dgjjf8GxF4AfLRCem?=
 =?us-ascii?Q?0phN0rFNv6UUHZ5J9IG76tTCOhZ+viBKIFYndv38zMMnDLCKLKY8QHno6XR5?=
 =?us-ascii?Q?k8xTtGPUYZySgsXMWZY2BwIHYVOoEhUMrxdWluNvs37xl66jimUaP6ErRGpA?=
 =?us-ascii?Q?MD9QdkPvwbuZonzztt4enYGOkfvavxUCZpfFu+4g9ozYtOAwRBdz2BoPJXDo?=
 =?us-ascii?Q?kwa/O7y2VGwyHRTJnPXHqctEl+PZYcCnJdURw+KGvN49Pd7xWcI6xW/ouW20?=
 =?us-ascii?Q?xTXuzcgATY6R0CCAG9MIQgDXugVfMgqF3PaE6sUF2AkY9ranaYPjZvoyG0rF?=
 =?us-ascii?Q?ZnhZFVOzWi8O/4Piz9kvuom4t83aXyqAzQnd132PF5l+r1pLFcNocU8RI9Z7?=
 =?us-ascii?Q?fNYnAmrsHQ+DSTgmTrc2uFE/ks1KdSupFwUIyqr95PgZiQgaKQMwN/+rZJdr?=
 =?us-ascii?Q?W7s/MXN2NCb9WQoxrvjDJswZIE66xtaxoFsGMPoMM4cU6GPQew3mH7XnMsF1?=
 =?us-ascii?Q?2N5cTgFp3AJe92aGV/roNPW89JMv0DRECKOfkPxJ+KbBRLrRtRS++Y1kEJJW?=
 =?us-ascii?Q?sZux5aJHW0Jo85a5/ZOEnKUL2FHAU/Fi/1/w2EHl4Xuz0FiXQ981LjsNO2gI?=
 =?us-ascii?Q?JNqt83y+TpRz6eGY9zq2CkwXACSz3SOe1XZOuaR9dFh5wPyOcmJqqrrYBxF2?=
 =?us-ascii?Q?fP89yrO69lUR4bTOSHyLJ56Sr8wdMkvpB2th3cIBxlUHdU++xtvjuaeJpL2c?=
 =?us-ascii?Q?kEdB9WkcwoCSLb+PAsKw1uWXXjPrvgOXf/ImVIDE4SqXBfvKkjV9pnTNCALG?=
 =?us-ascii?Q?/F8ETajXtnqBeInu9gyifWAk5Hp6FVNUQa27dxQit6+F5yZX0A1MBJANt4kl?=
 =?us-ascii?Q?kF3YA9AdDMbNe/S9O1a+3EGqj24dPLyqUt0lQtsx2xwcdqYVc8SIEwNbupFi?=
 =?us-ascii?Q?+MaLcX76DdpzAlgIZP6aMP6AesHMTj1MVsUMDEgEGBtx39+h1vnfedaHe4bT?=
 =?us-ascii?Q?Ko8iWlVnAF6RVC1oPC0XNfC/+TLCfkGa3lVOmOWXIHQLCjGI7HO91Tfj3SNA?=
 =?us-ascii?Q?/wIkeINxg3sF/Ji+LQ8hb7YciLroRB0zCfKNGxfnWs481VxirYBst0aalMK+?=
 =?us-ascii?Q?zFU+CTzfr9zGryvQ9EgVEtKCKvKczgyIOiw4mATfmbloEj6ErJMndNQGdZhw?=
 =?us-ascii?Q?c7o3ekcIBW8gTQyEyXC0jwVgiBrfsE4iuPpSSuHfD3+J2ZXGeienPCV9TeWA?=
 =?us-ascii?Q?cXq5ehM4G50B40PXwgfYTlyNuVXGLu1LAfFWt6DEiy44FUgZZPr7mNTn43Mv?=
 =?us-ascii?Q?Yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dn4ALchQh/BULkU7NkkBptTSyJi9vzZXt+mewgCJNVrshAHlQ8WzanDAuOCwtltJs3B+zO97C90e/EHoBKEJbdOWEaLc0Zcov3zbzK0Rm3e4CTWFZiMc5ZJJ+NbU3e4V44hL64hDG/H2bqVYaRdoN7n4WJWSq/bIAGQRL1hlZ3zqGazkiIEmr4rr4hHQSqyKagogkIJ2Zq5rNVGx8TmAOZX0y3FrRP6aGZ9G+f1BjMasARVJhftF9efDWpWK86WzwsjpX2Vcm4WoXHZ0p8sMr15ny/w+pPbwwaWCQlmgWoxXfSYeitoJlu0FC/65+f1sp0Nl6K+hlgHW8XBmMNLTafffpMkvAVkwY6j9gCKrecTYlTKL1K0yyKKjr6uyY2QXhIeZLpX5QY/WN35rAKqOLp4Dyz+/XInN4nPFUdH63ekWS+etqQ8/rgkQdY6fVVN0BrH+jBvXXCOesebN1rNr6Xez9PVYigdwwFTJ5mHvlafHRFRaJYtpPQdKpRs3SJJzG0pxA7jrsRX+ZQqdI6D5S4qot4LeM/f7mCxD/yZ3ufQzlWFWzkC7RMXxPCuigRn7pyvQPQ5yq9O+JogUo9c8RBvtGTyBjrzYPd+NoevJSg8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc43c600-ff5b-42c4-6f0f-08dc881d9923
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2024 00:46:28.6385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AhXwemRvxonG7Hj34OoER5pSDhda6VzdddkuMGoEW+OP6zZa4rpYeSUrV8litEW1E8Gois5wf4vhBv/sH9nogiI3Ia73wT3qztxCCYWh4TY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7161
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-08_16,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=990
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406090004
X-Proofpoint-GUID: NYqOvPr7aDOE7RvaYB3SmaijzxZP1Nul
X-Proofpoint-ORIG-GUID: NYqOvPr7aDOE7RvaYB3SmaijzxZP1Nul


Peter Zijlstra <peterz@infradead.org> writes:

> On Thu, Jun 06, 2024 at 08:11:41AM -0700, Ankur Arora wrote:
>>
>> Peter Zijlstra <peterz@infradead.org> writes:
>>
>> > On Thu, May 30, 2024 at 02:29:45AM -0700, Ankur Arora wrote:
>> >>
>> >> Peter Zijlstra <peterz@infradead.org> writes:
>> >>
>> >> > On Mon, May 27, 2024 at 05:34:59PM -0700, Ankur Arora wrote:
>> >> >> Reuse sched_dynamic_update() and related logic to enable choosing
>> >> >> the preemption model at boot or runtime for PREEMPT_AUTO.
>> >> >>
>> >> >> The interface is identical to PREEMPT_DYNAMIC.
>> >> >
>> >> > Colour me confused, why?!? What are you doing and why aren't just just
>> >> > adding AUTO to the existing DYNAMIC thing?
>> >>
>> >> You mean have a single __sched_dynamic_update()? AUTO doesn't use any
>> >> of the static_call/static_key stuff so I'm not sure how that would work.
>> >
>> > *sigh*... see the below, seems to work.
>>
>> Sorry, didn't mean for you to have to do all that work to prove the
>> point.
>
> Well, for a large part it was needed for me to figure out what your
> patches were actually doing anyway. Peel away all the layers and this is
> what remains.
>
>> I phrased it badly. I do understand how lazy can be folded in as
>> you do here:
>>
>> > +	case preempt_dynamic_lazy:
>> > +		if (!klp_override)
>> > +			preempt_dynamic_disable(cond_resched);
>> > +		preempt_dynamic_disable(might_resched);
>> > +		preempt_dynamic_enable(preempt_schedule);
>> > +		preempt_dynamic_enable(preempt_schedule_notrace);
>> > +		preempt_dynamic_enable(irqentry_exit_cond_resched);
>> > +		preempt_dynamic_key_enable(preempt_lazy);
>> > +		if (mode != preempt_dynamic_mode)
>> > +			pr_info("Dynamic Preempt: lazy\n");
>> > +		break;
>> >  	}
>>
>> But, if the long term goal (at least as I understand it) is to get rid
>> of cond_resched() -- to allow optimizations that needing to call cond_resched()
>> makes impossible -- does it make sense to pull all of these together?
>
> It certainly doesn't make sense to add yet another configurable thing. We
> have one, so yes add it here.
>
>> Say, eventually preempt_dynamic_lazy and preempt_dynamic_full are the
>> only two models left. Then we will have (modulo figuring out how to
>> switch over klp from cond_resched() to a different unwinding technique):
>>
>> static void __sched_dynamic_update(int mode)
>> {
>>         preempt_dynamic_enable(preempt_schedule);
>>         preempt_dynamic_enable(preempt_schedule_notrace);
>>         preempt_dynamic_enable(irqentry_exit_cond_resched);
>>
>>         switch (mode) {
>>         case preempt_dynamic_full:
>>                 preempt_dynamic_key_disable(preempt_lazy);
>>                 if (mode != preempt_dynamic_mode)
>>                         pr_info("%s: full\n", PREEMPT_MODE);
>>                 break;
>>
>> 	case preempt_dynamic_lazy:
>> 		preempt_dynamic_key_enable(preempt_lazy);
>> 		if (mode != preempt_dynamic_mode)
>> 			pr_info("Dynamic Preempt: lazy\n");
>> 		break;
>>         }
>>
>>         preempt_dynamic_mode = mode;
>> }
>>
>> Which is pretty similar to what the PREEMPT_AUTO code was doing.
>
> Right, but without duplicating all that stuff in the interim.

Yeah, that makes sense. Joel had suggested something on these lines
earlier [1], to which I was resistant.

However, the duplication (and the fact that the voluntary model
was quite thin) should have told me that (AUTO, preempt=voluntary)
should just be folded under PREEMPT_DYNAMIC.

I'll rework the series to do that.

That should also simplify RCU related choices which I think Paul will
like. Given that the lazy model is meant to eventually replace
none/voluntary, so PREEMPT_RCU configuration can just be:

--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -18,7 +18,7 @@ config TREE_RCU

 config PREEMPT_RCU
        bool
-       default y if PREEMPTION
+       default y if PREEMPTION && !PREEMPT_LAZY


Or, maybe we should instead have this:

--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -18,7 +18,7 @@ config TREE_RCU

 config PREEMPT_RCU
        bool
-       default y if PREEMPTION
+       default y if PREEMPT || PREEMPT_RT
        select TREE_RCU

Though this would be a change in behaviour for current PREEMPT_DYNAMIC
users.

[1] https://lore.kernel.org/lkml/fd48ea5c-bc74-4914-a621-d12c9741c014@joelfernandes.org/

Thanks
--
ankur

