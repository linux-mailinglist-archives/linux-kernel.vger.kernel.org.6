Return-Path: <linux-kernel+bounces-410210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D1F9CD64E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 05:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75F9E1F229CD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 04:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2682916D9DF;
	Fri, 15 Nov 2024 04:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N6Lb764i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hrkCzKh9"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A367161FEB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 04:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731646574; cv=fail; b=KQGZh0mG0QVGVAikeGK9QQ9cgt4wmcKtjj/Cp26IpHzfQvdV55k0u71w9ILpT9K38xCv5R/9CZEaatTlvA4zGfiEGm5pSUbKRqN+pJeLKYbq8Ix4A2M+0mv+hrbN1PflxHLAE8VdVn944ebMptu8EIfvtPN2CJ/JOPJd9oo1JWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731646574; c=relaxed/simple;
	bh=HxobUDPM1nw74QaI/pVnVgzKizjPMbsKRByXcz5Wj7s=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=X2LEueEfjc0X2094zod0i7mf81Cvja7GO1Hm5afLtCds9m+TgBODgrYCL4IiLiViJG7hozTifFeZoUechQbTf5t/IpRy+WfZVWhDXARoGC3diBi5Yg/GJQIUVEiSBMAa6kVGtsfgiS0+JjQwkhsvi7/CooBMYLlAdy6TkpC6v9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N6Lb764i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hrkCzKh9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF4BZMN025275;
	Fri, 15 Nov 2024 04:55:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=HxobUDPM1nw74QaI/p
	VnVgzKizjPMbsKRByXcz5Wj7s=; b=N6Lb764i+/lTHk7dyyJ7ybsaTL+yO3GTFU
	Vrwk9us4wrX/L/KweES8iaiqRCTL+F61Z66BdQdZglkVrACa9lfbslJ70kIwpfx7
	uKcGPSvgVr1zHcqtmWujOwfhopd1Zie+Lf1Ecesa+ehE1SKrGOhm9XYMq0dcb8fT
	xPsVbVOQCPQFMZylhXI77JxJqYob7OuffvXGffY8B124jKgcuy3/MzUO5rg2aj+3
	LJz7FP0V9tWxWBgGd+xBwW4b48Xh2+srz9zT0oGd65LYiQ0mFJ8R/dT6p+xHvPbP
	MqRxax/5NSUpXUn8pjZB+hjHjRyl/yPTZrMxaS6haJpQ3yG9LgTQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k2ap08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 04:55:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF3UgAf000347;
	Fri, 15 Nov 2024 04:55:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42tbpb56sp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 04:55:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1v+0EKiXgAUNuWtXCsIG92JfyA77QsXxGydVoeqnVc6j1NwXjWymSQJ/RWQYOmTJBU0et5i+aYy2kHhC1bNoLp7lVbUYbO7kwyWBw+SeLzt8h7/dDCiHZKVTjMtFQ3x6LVngqID39MBXIl49VRZH2UwbFZ72bSqxQPrC0myAOME/v9FnFvFqAjnGGqFzYKs6p/HpoqZgdyaFSTSpgAsBiH9GEJhE8ekXQ4vncbkk1HpXUp+7ykz/N3kKgh2E90mE4IT4594kfTspFeAclfCkFW9SbQk+pd/uMM12snddUuMfte8F+WjnaXQnEBlfh4j7c3QC1L3ShFL1R8q5CFn/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxobUDPM1nw74QaI/pVnVgzKizjPMbsKRByXcz5Wj7s=;
 b=PrpC3A4cAForQfVA+ip4lMAnCmnOc+1T/pW1WCF1lQWPnEG2RsT1LzTzm0inoY7fA0gkiFTVsKuuK9sUiHhK6ujF8MJ+hIKMDe7An36mE1r40IZV4LrgzhqMxqK0Xubu3QBNFPlVO/jzvJ5qxuURsrDzk8MxyM4p718fd84lZoavfGBw813toegNRUsNJSnogLOLIzc5zYnkTXThhZ/81JoHgAVqitqYRZ2XBstG8/CyvqojlD/euykoaxbyJm+9Dlck4/I9UB12Qjyyi3LQ8ybR6+ksU5/CG58KILYu0Mt+pIMn/jnYMu1jtFWha68cbfBLu2TzXM172dV2q2Dj+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxobUDPM1nw74QaI/pVnVgzKizjPMbsKRByXcz5Wj7s=;
 b=hrkCzKh93wLVh1lJD+v9gfrVlESY1cmPocZsFbnkEY9+9oqzgC2RQ9kYv+TlNppJUSZ7Q+HeCKV91kg9vRPU+fEQMpnJlv+ycvFf9t4tCUgnrlFzMZ7HpImd4fFL7qMqBPhl/TvdqL/zVGdtBaBxF7b/1c4TExSUSm/JP3nBy4Q=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB6507.namprd10.prod.outlook.com (2603:10b6:510:202::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 04:55:49 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%5]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 04:55:49 +0000
References: <20241106201758.428310-1-ankur.a.arora@oracle.com>
 <20241106201758.428310-2-ankur.a.arora@oracle.com>
 <20241114070605.bZFvKJ-r@linutronix.de>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
        paulmck@kernel.org, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, efault@gmx.de,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v2 1/6] rcu: fix header guard for rcu_all_qs()
In-reply-to: <20241114070605.bZFvKJ-r@linutronix.de>
Date: Thu, 14 Nov 2024 20:55:46 -0800
Message-ID: <871pzdp031.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0006.namprd06.prod.outlook.com
 (2603:10b6:303:2a::11) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB6507:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c30bed-1000-4fec-9466-08dd0531c604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3sUwQD8gxl9ltqoTykUHEgJEHh1g++iFWhCTuz2daNNr7CvN45cxIIj7y4Vh?=
 =?us-ascii?Q?oEevx5pplhO9BASRMBVFWgKe0s6iGN1ZkEx8gaZFAR9Zjnh0Y088PM4dQjMw?=
 =?us-ascii?Q?dd6JHaYk+FOVyFyhB5E+CSGZReWyqUBzmsY5qsNayXeYfh9xzD/Vfaz49mxr?=
 =?us-ascii?Q?lekfDZBawzaNazEfWU8UsPy1aJkwRktoWujmtmMzv71JBpNR7S40y0cxc0lL?=
 =?us-ascii?Q?8W9SKwfKvEH4Gv85YeRijtU0VOrlGEzz9CWvFr0+jHjJfUJzEcQO1YDrc2mg?=
 =?us-ascii?Q?iOp6rGr6Z9DzCM8o5yeju8HUou8cPu5WKeovwEXqWQX9h0ipCT1Gw4c79OSw?=
 =?us-ascii?Q?F1tOTnf1Av48EE3LO5VuhneMsLLTgCMNElGXOnk5gk3QN5/Cf8zRRJOfcz0l?=
 =?us-ascii?Q?YLbJABoa6NiwqK0VcDK9adRm1GCZDBecM3w9toLebZx6fW4vFdUfaf9h93p5?=
 =?us-ascii?Q?UG6+MMl3UZPJ7MmRqR2g4C0CtSL4t6LjJLkr90GlmE4Br/yRlsHPhYF1rXva?=
 =?us-ascii?Q?+n/arVEKojT31GCRrUZih9dLKDD4FBCO95Fbyu77xeo9YHTunWuLZaQHQmEm?=
 =?us-ascii?Q?jZwwhfFEd01CQUfWOg/QOMD7jJU3pNe5qhlfKf/+dn3R6mLNbZOB5FcTCdVY?=
 =?us-ascii?Q?NnvfkQV7P/P7VUMPnX5qGLaPHD4Di9TwF4ff21IN+pbBYnQqfRaKG3gKpehY?=
 =?us-ascii?Q?zq6OXSeiQtFRH97Tz1qr5aAZ0R28+9UNnlyTcEZwKPkFIpGD/SBmQDxKrNTv?=
 =?us-ascii?Q?UMDnc+aoNdRR6tvhMhnHKW5VjoKyACmvHpJPgcfC31WmYTFBK1Hs2yyDuy71?=
 =?us-ascii?Q?ENFBgwdWb7WPOkdNQqmSWxtyRjGuT0NnezLrtwCmp3WraVC1/pkp7lkDahqU?=
 =?us-ascii?Q?bhwkatCSbvx8f5eTYRgFVZbbnrPs+EM8M3+eQ4LxIsQ4lH1REEPrGpqGyE21?=
 =?us-ascii?Q?mZ0qsMuf7FhhZ/YyinUllTfKro3c8NO2nbNZCTPJXAdNbikmFOwDKaIpbBpq?=
 =?us-ascii?Q?3sDJ46akWfSXs0TiJ6yPCwIc0m7F8LKNwSH4TwpVF/rXolRVGj4VDkRlucoe?=
 =?us-ascii?Q?Oh73wQ2FOIBSKtS5CzKEY3OLIhyurzlKr+6bukTaZvLosTZBv1RCeQ3WVD+L?=
 =?us-ascii?Q?AcpqNxaCk4YvYeXexj6pJpaXstkKZhkvqZwPuQMCwhSHHFj1zZmGQkcE1vnF?=
 =?us-ascii?Q?KMf/Dofx63HulfuP6XhUCh2dkVAB3lzou/gRQZtI3CQsW09bfNSiDqzKjj0s?=
 =?us-ascii?Q?NzBzZD50gWMCEZVFNdvPHfJIeqlu70Ly+hf3QC8cd7LM5m51FxwVtB03UlWg?=
 =?us-ascii?Q?vVfXR9e+jC5TcQVAJBvRgKrw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7SYHL9kXfX+yjay5q6Sdpz+VAS4MBG9uPo1rZVpdR2YYekSY464e1fb92Djv?=
 =?us-ascii?Q?9QJP2S3DI4G+B3E/abvmCtwDYfX7HxxzZeKAO217iZFJkpsq3kUoR/ExfJYb?=
 =?us-ascii?Q?udLOH/DcDQw43wpoCXhuHkjMhx9GWU1bN6tAdeIKMw2j8wZrldqIfMSyBOzQ?=
 =?us-ascii?Q?jkhi+D1B1MDfjiInkndQrGOSFcJ2cANalfII45e0ps5wkxkjxAk0v/j+3+6o?=
 =?us-ascii?Q?KgeAb5a0P7rSgntxImVXxqKb+nzjz3fCST1J2olAh7vRdQxYhtX6J9kphEDw?=
 =?us-ascii?Q?qOm5EEQ0fIIbsyD7aEk+Ql6o+2LKvqlMbCcDC+VZTJdCrc0XhVjAlDhDrMcu?=
 =?us-ascii?Q?EzkMV1bucFREDhUGH1ClZwMBC+saY0bmkWpXSr/1/wRHiPSSKd+mGDd6vI4k?=
 =?us-ascii?Q?ajqT6Suh2DPS+6ZoC1m0WdexLXYIdSzXXMmUHF4WpLQ8+SqvRyIZhXMUjA0Q?=
 =?us-ascii?Q?uK1XZ6VYZLMrJkznSx5wtEzO4eTNAygMJdnzvJpRYuXL5zjSBVg//qBqH2Eh?=
 =?us-ascii?Q?KZld7hejWUq9ErcXQIQ3k+V4+hnRu4rLYGA7M7m882vJQm9nTKYU6K9n8JaB?=
 =?us-ascii?Q?Ws0PLJ6+5T0vz6SMRHlRRMR5T2CUKFmE5ydxzaqFCnEpj0SQ/jKGCkhHHMOh?=
 =?us-ascii?Q?QEf8hJiZDGaeDdBKkVDQvQjjRH/5LIUMblm6Agb9Eq5CnMzYl8Wrz6KNppAP?=
 =?us-ascii?Q?5vxVqO6qdC0FhRG0jmML54WJ0VzKaclsqer2nkBKctAst2Gie2Ahfaf/7Sa/?=
 =?us-ascii?Q?+in2oVLzj7qo84sk6ZMsLicaMgzEbv/2RCNxnMacn2HSLoe3QnRNz7E+IOIM?=
 =?us-ascii?Q?QniRxtPWCgG+fn0BWb5Rz4g8zeEsishY0vW53QJH37Ex7VEmyozuQmERJ/e3?=
 =?us-ascii?Q?DAW7ENJzgZZmrLNjfDVOfWcSZaNZmsE04b94UokFkUYekR8B12BSKcNbhD/U?=
 =?us-ascii?Q?fgUxMisTlNa8qP13YitAaHgKpFbv4xavke0G5YguU7PHXZM+Hz2vNR2htfwn?=
 =?us-ascii?Q?TRaBgdmkNtkOkSZhINkia0o/Wlvd0k9ulL+t6/T0aNOxNo60bAtgLlYkkFRW?=
 =?us-ascii?Q?eGi5FzWXqYRrQeKAxN/WCDl+Dk5XuaU+pOB1MgS55srfywUZ74jOcUgfDrO4?=
 =?us-ascii?Q?0ePIu6eLI1s9d2qzhoFBspjOWp7E2BpZqMJlsRdDByPjIAfM5+SLUilz6uqU?=
 =?us-ascii?Q?DKZB5xfMfVLmS3HUMNHQAhSXl+iLx9Y93rJBHLgAMXR2ldkP9nepow8YyVCC?=
 =?us-ascii?Q?jxUKjD/s80cV5MUbYCYdXGJ1iid+Dm49XEFip5/gmc31pMx3dvx3FFmFrGhz?=
 =?us-ascii?Q?/a8th6sebfqhyl8opVVdblwEDqR8cJUJF00pLuvcmEFnY8wUoKrvk1aqlplX?=
 =?us-ascii?Q?Z5fMY20+szvxULdj/0TAKQ9vxL76rgePLF0mW3R9GXuNHsjh9vKIJ0Q9z9aX?=
 =?us-ascii?Q?6uISYfRsXvGk4Rq9kM8/lfb+E1gCiX+u2cpebQ0+up66Hp36BAUHu4F9k5H8?=
 =?us-ascii?Q?puMgQqcdHefdX4m/oOj0PVBsz+i8eYfShwHta0PquAg3BIQue1I++uBivCm7?=
 =?us-ascii?Q?tQZWgh63OCF9PznPpO/W5+cn1O82NC+j03vbF78+U2+jCxb8Byc7ghSgXGBz?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nnBYcK63cY5O3P7J0hF5N1eeHZeBzNXlcFChuNp+8m3Hu7SGOA5pzCvtn/LkNT0PlVgp8z9LNT9kxVr4veCvffsg2bW9uVees1Wjp5DmSdO3cDSBJQ+PzGVU5h9oKZH3r3fPac8YmbGYFB2tLWKrXDiV1NLV8US16EnY68l8wskeRLBUFD2+3zzCvuKy0AiO6AmxFmfURKDHP4E9nat6qLxfkWCeZliyTzfER9LZ0pyzRULVw5y+sy/u+X55/IMaDDwOVGZ6t8ugpgsYzDGEwH5iHjOZ23T8dvXlarV1/Bz9XdWvWNF0merOkkY48/rDw3QZBz2b4AW1b2t4ij3fR0ZWvGrttuGNqmlpTpT6cRfJJcnBnb8VBHNA7+kvEuCNXKa7tbqYcStlFAWptFe95yZ9kFpqWCd8QoYT1IE/FbRhXD/XKkbiBFzL7FEVvT2evKXKuI0yIVTTr+ZV/f/pTmVYGhIM9FdcIUMbrC4DWTe4H4lHgDCRQrZMAUf2h9O+wvAQOOZ6pM96bjQLMZ/Tvei+O4EkhnKKkxkYbOUpNCkfR2iYU3/BoJHa+UeuDC3oNIuoV5Q7kDWP5j3v6Gj9+iRz1upbW54fbRPOh2HpVXQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c30bed-1000-4fec-9466-08dd0531c604
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 04:55:49.3643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSJmU+PuG26+NqsDWtBhZUP2WgVNMHFdBKhLiYb6waOvZhnU86zlODZUNOZrFyZxk6dHGLbqaTLh03D+Tmu+I08zmSVTy9ruUHWdf6kWpoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150039
X-Proofpoint-ORIG-GUID: DoPYrirTfEzZ_O7f-yfZLTgavPrLPuFi
X-Proofpoint-GUID: DoPYrirTfEzZ_O7f-yfZLTgavPrLPuFi


Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2024-11-06 12:17:53 [-0800], Ankur Arora wrote:
>> rcu_all_qs() is defined for !CONFIG_PREEMPT_RCU but the declaration
>> is conditioned on CONFIG_PREEMPTION.
>>
>> With CONFIG_PREEMPT_LAZY, CONFIG_PREEMPTION=y does not imply
>> CONFIG_PREEMPT_RCU=y.
>>
>> Decouple the two.
>>
>> Cc: Paul E. McKenney <paulmck@kernel.org>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks!

--
ankur

