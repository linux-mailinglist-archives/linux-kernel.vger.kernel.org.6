Return-Path: <linux-kernel+bounces-444258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BBE9F0366
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 05:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 956D1284BDE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 04:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B657F18893C;
	Fri, 13 Dec 2024 04:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B0oJk7Ke";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IPPnS/mg"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9656185B78
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 04:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734062861; cv=fail; b=s451fgrQsDyoZrV6EnuxMpuUPOk5D7O13ZAR1vUgBuisFOLDy2nchhuJT8NVPsIWkJftwBg98/QTB/klstTvpmyUMEgKzFX+IpBVxx/kchphPVq8dAMjtYu2g916eOnQqb5MOEJWXh5JWUhHy15jmwAVuTlouW0eq+6a0PLPz4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734062861; c=relaxed/simple;
	bh=9GoM3IPzQt495bUaJznHiiFzxBF6iJW7QUqP/4/TKns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eGpHRERjXx6tQngMpI3c7Ca5w1M7bTZPA6flrSUsj/GD+3XhGCLEeYPkIToZhtMKso306fFudS2PqV2vsNIfQh4aZfQ2ouUdp8N8IqV2xOsNrSEpYoro8K2RGdqBfLGFSiUBIMhZFPaCiNaS82DdgZhTqRcTVjzowECo91WKxxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B0oJk7Ke; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IPPnS/mg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD1fmCJ025580;
	Fri, 13 Dec 2024 04:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=d5sKXlDhj79R2/V0x0RiPPhkZzoDdiYwBFqfA08QL/k=; b=
	B0oJk7KeURyF1IzJWVwm29Bt7cO1tS5y/0P+A2N9zBFpxGizq3KOHZRYbnTFoJGW
	AEWTlZ7eGpOXUMB68JMpAtnbAPiDI/pD6Ls6SZZi/FayzrJWtvrY0kRCgCJjAa/4
	CH5htMKKEj8vG/MfKeRf9uhCgDBcfEGCBNJAgVVOOuTHGQgjNK7W388yg004meHU
	lolVJOdkwuVctWEh8dcOb3HABV4AAutc9crZswSxtLBTve6SqevfIopkv3a2H0rV
	8+nuMLIFpVCa/dWrxIVvHSUmiQ8MDeBCRTNFvjMdpErKsiskvDmBPDYpE94G0rg+
	JH+vk3AkgrRF1RlI38p4Gw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cd9avpe2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 04:07:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD1YMrd008602;
	Fri, 13 Dec 2024 04:07:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cctc10k3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 04:07:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dz/QTanZenO3XlyHY3XQ3CzE1015vjlq2qnJvV4gCAjqFltctaQOqbIvxp/w5neMpGUw+gCCCxtJNHBPbpnypxMZ+60jFkGr2i1dBceFY0PIPC0nUTqBk/iO1UNKDEj29K92Tsc6WJPK4NuTo8+r+0dCUYlCnBXCaEABEaRz4qpPF/mk6fAezLBQ9Z/TlSVbaCXMGUoSzYolWY888yKmdrsDpgmKTu3Wh4LX+ZS9yzAtiv+8vbs8gLiOwHR0LHgoyvy3rsvKCQloxvWsqMNlmJ7PtgQ4q9CFR9QPmwcumwMfN7Y0ej6CVRU9IJcD5e7meVQ9Jhq3kqghnBs/UhlPzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5sKXlDhj79R2/V0x0RiPPhkZzoDdiYwBFqfA08QL/k=;
 b=JKHhDd2tMbPcBwuPJWCZFgsh/sOri0WBCutDtzi0p9rCqfPCkCBPA7l04IcJSTOeYbs1FAXStpwG5/B3s364XS7MfsNTWm0FsJ1NUmsyZR7dsv3KZpn/8wjKWCGOE6ZIPXGVxHmel2XWqNb+dyvuDd96wu9kKFBw7UBP84+dTHRsY9dpCDsCiBo7y92JPSykR1Ey+mP8xguCz5x+2FPqchfGRQhIjLnC9JtuIG4bVY+pgRRSQMXX3FTM47ciqxOwsE+WnG5AcbXAoAsAcfyMe7yVx0EurXGs1V/5XFAJ9yR97AxJSF7Bkku+nzfGfWgj8JRSYh5h1r4JyCI7WtiXNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5sKXlDhj79R2/V0x0RiPPhkZzoDdiYwBFqfA08QL/k=;
 b=IPPnS/mgvN+lNqwVf8DRjLHacKxTEvpjIWDVz++V6h0ulmKJOfW8lyeADpGlGSVPHQbBAI2v1UYY2Nq/MOT1l8T5XjxSHSFzxtMtST8QlmxynwzYF9RRCiL96ejscgchuHwWeTCE7JfziC09jXTsgwfjj0O+k4gqU84tOxkHx68=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH0PR10MB5848.namprd10.prod.outlook.com (2603:10b6:510:149::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 04:07:16 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%3]) with mapi id 15.20.8230.016; Fri, 13 Dec 2024
 04:07:16 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, ankur.a.arora@oracle.com,
        efault@gmx.de, sshegde@linux.ibm.com, boris.ostrovsky@oracle.com
Subject: [PATCH v3 4/7] rcu: handle unstable rdp in rcu_read_unlock_strict()
Date: Thu, 12 Dec 2024 20:06:55 -0800
Message-Id: <20241213040658.2282640-5-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241213040658.2282640-1-ankur.a.arora@oracle.com>
References: <20241213040658.2282640-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0272.namprd03.prod.outlook.com
 (2603:10b6:303:b5::7) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH0PR10MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: 1190b4d8-be83-47de-7382-08dd1b2ba15d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kFO5UXtThIreGQcYWNvnyIVHg57/8CvqYynDQvyTXGz4HRqar/1gOIfiyYmo?=
 =?us-ascii?Q?HkE9K582YP0NqEpQNrFPbB2T3kkCb/A0h8dqu/eRE4NEOERSrp++aLzXU61I?=
 =?us-ascii?Q?xfiYuHGlY6TgT0EQugYiubyvEhdwx0U7vlGO7K5RHukPxQRLW1U0vawOD+yi?=
 =?us-ascii?Q?i4RXBvkpTgDcco9VvCZPnTRoJvO8nyO774uG4DpMa5agIJT1VmEawUQdGo0b?=
 =?us-ascii?Q?S9F5Y2ZhXDMGsyG0GyLcpM4s/2UoXB+MKTSjSeffB5plxn+jukRAMQKpjKBl?=
 =?us-ascii?Q?MmEHTOe23AwAf29ipl85AVI9ECv+6CVjy1p2DAVpUQ8IEiW19HKp8UvOGCPb?=
 =?us-ascii?Q?PoQfD+sJylXDuUhJn5x0JKnI1AaFRGkejNgyw5HMx75VSje11Hh7KGQ3qQ/B?=
 =?us-ascii?Q?zwKvJYgxAzSfiepVheAmfToAYSK46NUVuuHFLMLXv+Sxpcap1Rn8aqzAwu/j?=
 =?us-ascii?Q?9y3cDgr4LJrbimizpB7GzYp5b1srHAsiC7mQfubdVbajzWximRiNC8yEcdOe?=
 =?us-ascii?Q?XErdnCDB/gLVDtmre7X23QvgRmIF2+EsTTI6y22kXqf8r8ZEnVEIDQRpWKuO?=
 =?us-ascii?Q?UM1n3yeZ5F2wO20i6OcwNHUFuTWm5X9iXvdZTv8GRW5D2+K52oSjZ19CZzXq?=
 =?us-ascii?Q?EkkMJNmes0yXl04Ve6G1LUkSRXNavUoKPSQsnqmMocbIZORIdBrZDP/jynzj?=
 =?us-ascii?Q?UGXM2SL+2Dvb4LJza8bvzrVqVkin8iL8nW9nzPUFz1kWWB+npEhw34+Z27Qs?=
 =?us-ascii?Q?AD1U4skU2n1LwYeJYn4lvE+Yc0LoFmCGdVQqeT3EOItplKcQ7TKaSjOohIVr?=
 =?us-ascii?Q?Vm4L5776yJtNeJcYYY8+ji0Eq8scNGsteuDbfpxVypDDB69aLUqOdpHqm7kY?=
 =?us-ascii?Q?3EokN5nuST7buIvT1sA5+8DDuRe5FGPTfL2CPzBTaiVaAeQOsWHKm8LEEuZj?=
 =?us-ascii?Q?lrGJ4/YIR89qsg9QDenK/kwoR3apxeOY0Ch/kPhsuhPj1MpkWmY+TZWmG0Iu?=
 =?us-ascii?Q?/SCvLz4TkbUmgzANh25poCdGdA+ZY8OB/Tnpxjb7c4OOO2FQVd+9UFkHaEz/?=
 =?us-ascii?Q?cAXJBx4Fv/ibMjfz8/2gxnduM8mj7ImcE/Hf/NRA4UrBGtfpN6J/vw7K6JWs?=
 =?us-ascii?Q?wOzGoBpREUYLDFPxq+AukdikOfXykVO9qjGp+amhy50e1shyM+iuAvR8oec0?=
 =?us-ascii?Q?01j4BlGaPFG2vc4sU4Rc8naVxupd0J1T7yFQPKFTGVYSu8at4+KufsPneA0d?=
 =?us-ascii?Q?KqTWKFwIfeg3Fx/iTV+/Ev3o8wXRA/BkB8ZMe2jzDAzIGR4u0PXHWLK4xNwW?=
 =?us-ascii?Q?XkMoB7Ha+0WmUb3+e1WvaIDyCQGdy+8GuvQG0xOEYYinfINT0nv4f9NlIJeO?=
 =?us-ascii?Q?qU7tQBaCgzd1moi5Cc/b61bzt0q0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yF+gDfxMWfqEhcebxvjJuIeoOo5At5hBtG4MErWT/p8qBSLT2Rk9x87nFSxz?=
 =?us-ascii?Q?hO4HBTc3gLv1k4RaBSp7HblZzU0GVOX2gyGBmG8lT688l6cvonuKinj0n+O6?=
 =?us-ascii?Q?O4posJtV9ByykU7O8uq4zqJlpe+iPLQcBIGLSQHKe+AE4lf/r6FrvL1YemE/?=
 =?us-ascii?Q?3WP4ouXn8V4MXd+0cnGywhsvpyQTX5lwK5eyWBw/vIzIYAizIItpXGn4BLjf?=
 =?us-ascii?Q?LtaiN4/pii5tufMxbPs6HnR+QBKhJUrFgE/fwqwd2Xp5V21k0Dk475ChCaNo?=
 =?us-ascii?Q?HK+Sfm3L5VdJSjyeXJyv37vR74NzRrsNpGmr1WMqhRFx0kp1VhN2B7MJ8ySx?=
 =?us-ascii?Q?7vathMZXMD/tB68EVAWZ1NCbiupxIkCxmd0HIxa9j+amKSKS6RVPU8+pKodr?=
 =?us-ascii?Q?vvmiWERXkZ25KMagt0ti2bNmZ6pBaWSi3QCFVV2VuM2Nxorgmtff5XvuXMGz?=
 =?us-ascii?Q?Cae8xofN34GgOhmjb7b8zNRXMRuykmuv1qgzsPn6Bei997lbZCBM64KJchQc?=
 =?us-ascii?Q?E1UA4sjsq1Girsw3IQZd/SdyIkq4wcgegGbXhcKLyp+pu+ZlU2QYNbEg4jfc?=
 =?us-ascii?Q?EZL2xhLKy4IOQOfWkomDDxZxVud1QektMm4aucMWqEV2KLoVw/EP0n/vRJxt?=
 =?us-ascii?Q?b/gV2HAwK/Xh34Yl57W3jcFtKOlswGEZfvOPeiDhfjAD/8yrJqkkyZV2vMf5?=
 =?us-ascii?Q?xOpT+5JKWv8qjOpLirPfOxhxcgxArnYRqqm/DEzo9SOH6saK3ikTbjwMku3E?=
 =?us-ascii?Q?eHkPiOj2Hik9EDUQOwmg1qVOCj8FDeiywKnja3h66CC4hXZmXx27PCUrU1rG?=
 =?us-ascii?Q?pi54QuEttaVzmpKcpJmqSA0XzugEGelcunyF/OqJ1691iWUy1pAAx9EY31Lv?=
 =?us-ascii?Q?tMecKPntamcKoJydBFXGsnkWdldJon2EsVAUbhGaq0AG5L5IUehhVGZWEVwO?=
 =?us-ascii?Q?KRdvrxaZBsIAyK1521N65Xl5MmTtD+0w2VRolxkPJCol9E1s2Ak0MQRyjJyj?=
 =?us-ascii?Q?h4O4x2IUZsz2SfbD6SIPKR+ZpsDYs3ZHAcmTJKw8Wb5YGAv4CiBvf+MGyOnd?=
 =?us-ascii?Q?UAZGKrumRDmavsbxdQr5yWV+rXS8eoVOH8vdEYUIxLhsv8SCbfOFGJCvnh20?=
 =?us-ascii?Q?7PICm6/dt6awVGKCy/JPfwpBXvv9Iw1do0aJ5Ps3c9kyS9sfMPeGYyRt2t9q?=
 =?us-ascii?Q?A+y+KASTx/DtdtXQzN3lLcut5gzzazAvha8TyTU0Fm+ahiVqB7E07bb31FX6?=
 =?us-ascii?Q?ZDPBs+YHLWzNYDvR8frf/1CkY7FipWtTmxthm8AUJm1OzktPaYGtGcJPNwb7?=
 =?us-ascii?Q?JpkKZfKsRnOhTIqXLAR5WzwQJLIeLiKvcMvXvoqcKFBAv5p3++jKPhBaXHlt?=
 =?us-ascii?Q?9h0L964BeHNwOph5t4Mu3CjvS35pYQ8InNJtAR/r1t3VzTd1yBX8MMCLGv8o?=
 =?us-ascii?Q?gIQi58/WOr35sUAiDjbNiXChIjvxAnckbY2llIVCm7+a3JdCQbF3uqItykEc?=
 =?us-ascii?Q?JThRn9ayuYTShcUd4yt3w4DilDVB2YlQFS1+kSVMcmDoqjDDxZfqRPwQOe+M?=
 =?us-ascii?Q?XoqLIsXUH3M6ULUXtMhDySv8r6RK8UtsuVruD3P4zsN8OJ8uEkt5+G9JnISo?=
 =?us-ascii?Q?aA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	icse8rocynfysSe0QuT9FczDrHUQH+a2IPFdXRuzWs/QMXcmlKQYEtpYoPw5xMtwE5cjhFJm4mhnifLujNj+yDDHPtXuSeTkeVPHNdFYcp3vVskTiCW6wmkWNEYVJPpi2dQlVlWvEsoau8VinUXNTMtBlwVwMoSXg9P5Q0ILZgbPlOQsceAWPwNlUjbKoEaCmj9nd73Pw1smw11V72Ylk4yD94GKXbQOrTOmaDHXhlgGq1oLHBBaK8UX1OMTWgQPQtS8X4Z9ya6x/S+ZACx4HTdSAViVnb1XlhYEymIpmTWkjw1cmFsJmTJDjM9C1vbJGDab7FtM6asddFjB7yRqPGiIo14wzwr+agPaba40oblkYbuqpNZ6WLDd/duA4irB8o19AmYfDVs19vJDHEN99uHJ1DhCcgfAIccLTqjU7DTqyO1CDMSABlHzEFvIFCytNQN2cNyrWJEpCwW5S+epPqbq9FgeOIgIRsblhKj7iYvASi3HzMmf3gQzmSgzzLibcjC7qnN9ygyCtFX0R/yAFxbs9aIvq2YJ1nXPlYLy0z9WzNb+PocjEaTYArCStPT25NK/07GOMC+GoxBtKf7cEuAULLPApVvZJZ/I3OhQiX4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1190b4d8-be83-47de-7382-08dd1b2ba15d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 04:07:16.3250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: omcJIpLMevBPE30Gjo+BZ/hqjvn1s/SQw1Ts0biAGoe/8VpRiHmJqwG1/VFFk2WwwkbpEjn9sG8+SPWIzp9K846S8yXQMY5cNnuA+cMF++Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5848
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_01,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412130029
X-Proofpoint-GUID: KUtqy1IrlVm2jKbm5pNOBMAimtpys1BZ
X-Proofpoint-ORIG-GUID: KUtqy1IrlVm2jKbm5pNOBMAimtpys1BZ

rcu_read_unlock_strict() can be called with preemption enabled
which can make for an unstable rdp and a racy norm value.

Fix this by dropping the preempt-count in __rcu_read_unlock()
after the call to rcu_read_unlock_strict(), adjusting the
preempt-count check appropriately.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/rcupdate.h |  2 +-
 kernel/rcu/tree_plugin.h | 11 ++++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 48e5c03df1dd..257e9ae34414 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -95,9 +95,9 @@ static inline void __rcu_read_lock(void)
 
 static inline void __rcu_read_unlock(void)
 {
-	preempt_enable();
 	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
 		rcu_read_unlock_strict();
+	preempt_enable();
 }
 
 static inline int rcu_preempt_depth(void)
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 3927ea5f7955..95a7c6c71a91 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -832,8 +832,17 @@ void rcu_read_unlock_strict(void)
 {
 	struct rcu_data *rdp;
 
-	if (irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
+	if (irqs_disabled() || in_atomic_preempt_off() || !rcu_state.gp_kthread)
 		return;
+
+	/*
+	 * rcu_report_qs_rdp() can only be invoked with a stable rdp and
+	 * from the local CPU.
+	 *
+	 * The in_atomic_preempt_off() check ensures that we come here holding
+	 * the last preempt_count (which will get dropped once we return to
+	 * __rcu_read_unlock().
+	 */
 	rdp = this_cpu_ptr(&rcu_data);
 	rdp->cpu_no_qs.b.norm = false;
 	rcu_report_qs_rdp(rdp);
-- 
2.43.5


