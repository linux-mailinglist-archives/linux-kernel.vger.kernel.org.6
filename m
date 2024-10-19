Return-Path: <linux-kernel+bounces-372592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E22809A4ACB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 03:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C911C21B68
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 01:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA71193092;
	Sat, 19 Oct 2024 01:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ALgJ5nyU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AiMb7E6K"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBEC46450
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 01:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729300118; cv=fail; b=TzrXzSCjqnmg/7nlf+lclPKY1SCRvi7+HvDcoCVelP0Q6hyYejVP1FYffhxFD8Y06Rnha9/2m1odis94Z5DhGFIgQfhq2SH4Xf7Hxx8H87vb7PEJye9+Nr3v1EXyPjeEHMHz3NwTunVbZ3b/lIu0/OveQOYsZuwhVs014ym9BGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729300118; c=relaxed/simple;
	bh=yzCwXi15I3i4/xSOiQALkFWdQx3uCji9VAqFOSwPKgs=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=skIrCQAtl37Us46oGXFfYDX8yqzQqOwfnnqaP66Axq++tuSyX5Euee9+hGcceDdC2SQGRgYV2OJGHUUHkirjxR2Y4hs0q/M/F+SFl/DHpVy2AQf8fgPEPKD56lRqMTf2fZtw4PYGcxBx1L8Yl6Aa9oucWgj7xzZ7MXg0fI7jdk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ALgJ5nyU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AiMb7E6K; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49J0gAfL021683;
	Sat, 19 Oct 2024 01:08:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=xd3JQCs4NrZDrRGUOO
	BLrrRjN1MqYxMxR7FO+76jsWk=; b=ALgJ5nyUFMLLkCQSdiyeOg28fZrrj2yEeh
	ImnwHLBL9h2FcImmCIOhiRSvBWxAa7hVjkozhkHjCftuVvY3WaTQeWwNTusewXy9
	LqyBKinJHO0MikcIa0RZPqxj0vl5kydQ3/C8oGCMDcVi3QtWmDZhu/5CDWtCiA7G
	ZcgPmVPGdt8gR+bQqtE7p0We2opUz22hwgdsPfnsh8EKSscMZUQiMTYbI/SWqE9r
	TzR5t+YmKSfnx9XsHlhWQNJgmBwjOC+QewBWOdW9UOgcBd35GLaGMB7c0FnvEZMB
	VSP3rtvulWBXLjstgdUonw2iesR6jL8CUz5EKKiPrYjBe1UY1xYA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gq7syaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Oct 2024 01:08:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49ILVpD5026223;
	Sat, 19 Oct 2024 01:08:12 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjc7scs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Oct 2024 01:08:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gq4irhZij34vlbJZVXyD2UNUaRMzAw+Za6pzSvV4EK8pu3qCv6N1fX3quqPVd5g2i74QlwQ7FN/OAHjrANFw+UDyLdSUl1tTIEPVFMMJuzzBLKz0bcotZ2sbohSGLOSxeBlXG15n0k8uEns78w+TMHLraORjBwrd/zNUzcR+jfKpcX8kWx+4ofKFugup2AmSXEuQ1HCgSPKjeMdo6zVmhJ8qeHU0B0i4QZ0jW9BgaTPd+pwI6aWof0cgknOy2o8VqkXtOgGmmfBa8LMy7hruivZgakSrhANPTCCygnEX7LXLgqWpH5HrHsUQJFyj8dOXTjjI2sdVj7pBvg+vyYxUdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xd3JQCs4NrZDrRGUOOBLrrRjN1MqYxMxR7FO+76jsWk=;
 b=EZUvqg3FIADCvU+8bNjcSjQtHM8ghJCmzvMlNE4UagUIW0TEW/gC1uFdbNoR9BsGxmMtI9X5dBDXsACXjgEkI/xAKzY881d91o5ZBWwfGQtmL1Kz+wYQozAsvTnFS1vZYMTgG6hmngMCm9sqnMSGg5vb1f5LVk5BJAWSfaY11wsgXmd7qGGAacnM0d5ohvoBoTdGWwaMkMRAggek4TA/KR/ydwuvvp0bD+VQ66ROpmSFUU36FMAD5JS7PNpDv55hixrlAur7aKpZvaQenZnY8hsMBfcLgpfZW3XBxA1E1dRP1akOpEvRxbC6B+d5BawwWNmTq+1JyQqBffqU5t+7nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xd3JQCs4NrZDrRGUOOBLrrRjN1MqYxMxR7FO+76jsWk=;
 b=AiMb7E6KZ2SSWE8Em/h1PN8vUKB+kpQ6x10wLGbup1wjR/KKir2LFB6/0n8ttFZy6YoYKRjzsDpx8mdqjhhtIyPMyMnXLnMP7NVPNUneNp8WCQ1S10r2biEKoCMChpvpVb6A+j0caU9ks2FVYpukdyilvk3NZAjWJtk5J+42muI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB6634.namprd10.prod.outlook.com (2603:10b6:930:56::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Sat, 19 Oct
 2024 01:07:58 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.8069.024; Sat, 19 Oct 2024
 01:07:58 +0000
References: <20241011081847.r2x73XIr@linutronix.de>
 <db3b0a4b-bec6-4b2b-bb22-d02179779cf9@paulmck-laptop>
 <20241011144341.mQKXkGkm@linutronix.de>
 <dcffa722-986a-437b-abb9-af9f4de852df@paulmck-laptop>
 <20241015112224.KdvzKo80@linutronix.de> <87ed4hrp45.fsf@oracle.com>
 <20241017080439.9od9eoBO@linutronix.de> <871q0emji1.fsf@oracle.com>
 <0c04a986-91d0-4f6d-bd4e-ca00d1cd710a@paulmck-laptop>
 <87zfn1jk43.fsf@oracle.com>
 <c886bdf4-23d0-4c12-ae44-454226e92265@paulmck-laptop>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: paulmck@kernel.org
Cc: Ankur Arora <ankur.a.arora@oracle.com>,
        Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, efault@gmx.de
Subject: Re: [PATCH 2/7] rcu: limit PREEMPT_RCU configurations
In-reply-to: <c886bdf4-23d0-4c12-ae44-454226e92265@paulmck-laptop>
Date: Fri, 18 Oct 2024 18:07:52 -0700
Message-ID: <87iktokihj.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0018.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::14) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB6634:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e1563c-f32c-47e1-df23-08dcefda7860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dny4UUlPQ8bL2KW7avavoe31OYki9WqSxvyxrbxWede/Li/UWlBTz9aGGli3?=
 =?us-ascii?Q?Y1Nubnj5htU6l3p1D9DzjLxpiD+stLoPzTzRhe5ojmfyeO9mDjG02TFHetp/?=
 =?us-ascii?Q?Lt8VDXhB2IefeV4BLISLTxrE2pmbB6whrS1PYQvUFFrAtKtsQTOS63pLb3Sj?=
 =?us-ascii?Q?FTHAmIdP+GJ+5ZM5hcYsVtuy/3M28e5h4AYtcdt0RXasbEAGmYt5C9wXe4Xb?=
 =?us-ascii?Q?BDTeqKWULkrDTl45ZCg3++WFU4UU273lpZhXK6kPRWX4GpM7zcrjp+dZggDL?=
 =?us-ascii?Q?umB080HbC2IxyDxy/m7CB5mz7Ju6i8GFWWljXe9D+GQCSNns5khH5STG36nj?=
 =?us-ascii?Q?a0lAROY1PYNj8scbFgYa87CdY6R3iF/ISpaSOIsb/cnhrwJfuE3R63VttOxk?=
 =?us-ascii?Q?Zdka4aMiojmi3LEN1GffljIw3WTEYZa9Svxq/egwS2WgYhochzUZSoQbNarZ?=
 =?us-ascii?Q?8BSm8wueAVgLuVMWh1aKfFddsU2EwGaK1REpxJjdiZGq7B/p6M258iLZwFQV?=
 =?us-ascii?Q?xYGUjRZAExpi5lP3XVrvUbg5OzLnVbKHIivcMyWGyopmyUBssTbC2Vif4Y1p?=
 =?us-ascii?Q?9QkCzqJnKekBYxSIB8xc7AgstGGVo+/T08unbzfl+wOs6RRHpnHPdfvHlx3x?=
 =?us-ascii?Q?pJTls4mFnLA8zo8ea0Rp6deTH11Y6gJPQ5+mUnY1ud2werLuv98iQbwIMbVn?=
 =?us-ascii?Q?rFFOzGSkJIWMXAmi98YZDo4HfogPzrgg/NZqjzH/urBVk/PUYRgNOMWE5GD1?=
 =?us-ascii?Q?3DqjlPSK9vi2hHgMXPMr5UYZZgZd90Jzm3zWyh9nVZ3RW8Fg/H0SrUiIwpJA?=
 =?us-ascii?Q?b37gj3XmlDYhySNwveC1Yztg891zJQLwtCihlZco1SZOP9hC4mHIwxKLcTYn?=
 =?us-ascii?Q?+BWgo+i7xtn4Ny7M7zNCoZnDY4FsB7B+o9ggsvt/iJ+ZC1+veIHHjJ+7aOJr?=
 =?us-ascii?Q?oZfiAVNSA0M6IPbjYL+WBhySEt7NM/K89Ipby6NU6CI7iD5hs8RO8DrsOba1?=
 =?us-ascii?Q?bNQAzN1TlFjPZJYAp3zZ3YCCrCjIfpgYXGETZsuKoRxp87dTBenXelwXGOY8?=
 =?us-ascii?Q?Rilmh3UNhdk1iiZjY65asX5MkUnPj+rhY84fgBdvC+ZjJkFcM7wueJ3Peh56?=
 =?us-ascii?Q?KgMHcbYBy/Ob89B06Q83SOIOvlHSySBu9JeNSB5gMzWlUylveLVjXdfAIUgO?=
 =?us-ascii?Q?NVyMkdu4/Mu57bVQVJrRmsarKsJsJ9vQorBoD90D2fXjryDwr554eGIZTJKd?=
 =?us-ascii?Q?iTzol7chkvZ9AGGEcwhtMdGbpnuBcUTzwUeU1Z1Dkk/if9gtNdHK5k6O6tNF?=
 =?us-ascii?Q?C1sKI5gZ+xrF23o4QiY9HZ1F?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?orsmZRHR+TFqAJ93hckkalNWrs2oQftijOjKxMftQXtLjBLqVV1s6zyDhNdg?=
 =?us-ascii?Q?7U/U+g4af1pY7Wa3Pre8Zb3eVNvroRv1MJL42rOsfZxPD2cMTf99kRF+VmxF?=
 =?us-ascii?Q?XJT/63rl1doBhXb58IMZSZrtMAn5ezJpmKXwo+Oa6t7QBp7x1VtIsdFUw8fp?=
 =?us-ascii?Q?Sjw/Ll5SSyinwTJ50KZJBQFTezSzds7LWVu+djn/0bdmgwIkwDzbuCe7z6ae?=
 =?us-ascii?Q?gMcEvW4uklARAfkVnOhkyeTzrOizVWHPRUkN4tN/M/cKz51vSKQ4bEIVuZA5?=
 =?us-ascii?Q?n+UoS58TF0pG7S11X4gp0BGrkATiwJNtOsL8ybtDgS7E8nN6Oe/4slt3Cbpu?=
 =?us-ascii?Q?1eXDxTLZZyqcq4qMQfe2dgrKKiyP2L7vEmq0YbxyBmJ4J3MFGKuatc7kDz1Z?=
 =?us-ascii?Q?p1E5fqx//3udvC4Q/zzNgapvjni9x4jeNbQzVr1lJj/0ubRHZoeqQfwFYO6k?=
 =?us-ascii?Q?Y6CMgb6Q8S5ejH1+LcAhqJ34TRPO3Cd5ANZ4BwJjC68qD8A9aqUG+p46q/Ld?=
 =?us-ascii?Q?al3ttF3qZdbmPXibU0WrauycxgGv425e1Z0Ge2PcPtJRK5o2echLrdBS5kk7?=
 =?us-ascii?Q?cbTugPc74Fe248bAbGYw/qma9nbT4LF0pzjl5ljD2C1bW4fM9RfS/8jYFxAu?=
 =?us-ascii?Q?u1PsK8r7l59u/3QEE2h0XfYbkkhx7LxFDxFQrXTQYST+/18rOvS6ilWxq3SO?=
 =?us-ascii?Q?1Tu6iSGxi2ShP5rqDt9gJe7v1aRljQLiStbUQp2/tHtEVtm9Xt+f9eI/MLn/?=
 =?us-ascii?Q?LPWzhxO9W7oepLJJhCS1OX2D9VbGQF47GY9MAMfLXTEHh1tjhGr13hMD0g/A?=
 =?us-ascii?Q?Kq6fQnWbQNzj9EsmAU0kJgmTfr3wuQwbQIq7blxtB7zOe/CMF2mnJ8ZLTKMa?=
 =?us-ascii?Q?ufyZirhrptgBhT1jOz7tFO0ZpPZN6kkPtvjF/Va5nGAire2nTxuE6UI4pDyi?=
 =?us-ascii?Q?Z59BFNEttifEN2RwqWRd3VyAMHrurI4xWXtH1axBEJsbajdBPFebA6ggmKCG?=
 =?us-ascii?Q?mwnJaL1HTw0HzW11pIytrQKRyuKed9N/2wz83lr9vXlbUzJROthcGJw5aCDs?=
 =?us-ascii?Q?lXcoZdkbsNi4KYgJzS1H/tc4WhByUCe3wVBVt2z4xhnOkcPf1TLOa0aYlQOr?=
 =?us-ascii?Q?jVs2gRnqhJSH/1QBoCIu5rFr0P84GjmSRoqv8brPbGrF10rPaL8TTM/x2ARy?=
 =?us-ascii?Q?5unacY6YVADgYeQX9j4KOYmKAWO1pu7GxBPyi3UC/4Y/hBRZLnwmI58nA3JC?=
 =?us-ascii?Q?Gh5MKsBYtlJF8rWeM4JjALGL2tgtjHd3qe9bRx+FiD93A0S2esJYtj8L8SCB?=
 =?us-ascii?Q?UxhkCxnxGkG1P+RWdO+5aEW7fzs8zVJPRdWp2hnS+6N6Bo4glfQKvp9ljry+?=
 =?us-ascii?Q?OMCYfmKxXw+9JDE+Gd2N0ziGZB9nN38zPqQI37U8Q2VlNBYOzCV9eJbxgIw/?=
 =?us-ascii?Q?EUHbRzlG+qO5ZEa2JAFaXxHOqxSpwpKMg24ufTQZbEXtwRTGv5Q/wvboQNkB?=
 =?us-ascii?Q?J1DAM/VYSFgtq0Fi0WgpOUCu4XSOB5ZHFTHl7L7ktAwEJEnN348xJMw4RgZF?=
 =?us-ascii?Q?crZ/KuseTWBZJqZjU7GSPlH+u9fqKJARemKykYC5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Vxv6nWfOxQLs/q+leifoyLkAFB1UDgcGUiclHD/6tRfGhajoqwaK2imxk3PSBnp0Sw6hWsBJbVPp7cYCnnF3H6fHLUIFKBey+5gocpLecrX7ffhzq0BLJJlf5+ermIOvN2bT1Zd6GUm4HPqH7hIA4sIdM6i+pFnadPK10cDOScIKPtEdpOji8v+8bD6omyRaUzS7DOEf1QPKt/5pxySbGQglH37wPc+wRJKEdKlPQKBKume4Sm1DuDrsIiKmovLPM2zPM7eNkj2HGRiBydQm9hTd8oK4TlE+ad1Gg0pRFpKksej+5AyON21Ex88BJbnSSxJDF4BMssIxe+yxqBhBnPgNSs3pk9JEbbRyV5Y629zb0l8jduhEOF+RnmaBw+qvPK9s2LEpWMP6wtswcTLoSI63i/nCMTAchpnUpU5Yi5Un9VTY61xR4t+ndo1No5eMyyWD91nIwXETqp8cyy+EEw3EFWn96nRO0mNICOxDpDtVJd9aGEMIVpLauliA0RieYMk8V1LfRzHqYRyyIVb+egaO8Zak3N7fsdAjFqejUT0hmueSBl5ivV2tXCAwVqTTjU8bGWnQ6TAhpb969MT07XKXbBj6d5y+YZCQQzd0qss=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e1563c-f32c-47e1-df23-08dcefda7860
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2024 01:07:58.4290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1OfdlFzndaHu3XuEAtbX+InZClMDiqEKYsCXRNHiGF9mQGoRGtn0rrM6p/bYb5BBp5n04SXaXgl6h7uFtmL+J/FgUtbcFQCGiCb31z11y5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6634
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_20,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=725 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410190006
X-Proofpoint-ORIG-GUID: sdlWPrYoGnLRY3s2zSUyLVpwrieCs6WG
X-Proofpoint-GUID: sdlWPrYoGnLRY3s2zSUyLVpwrieCs6WG


Paul E. McKenney <paulmck@kernel.org> writes:

> On Fri, Oct 18, 2024 at 12:18:04PM -0700, Ankur Arora wrote:
>>
>> Paul E. McKenney <paulmck@kernel.org> writes:
>>
>> > On Thu, Oct 17, 2024 at 03:50:46PM -0700, Ankur Arora wrote:
>> >> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
>> >> > On 2024-10-15 15:13:46 [-0700], Ankur Arora wrote:
>> >> >> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
>> >> >>
>> [ ... ]
>> >> Sure. But, that's just begging the question.
>> >>
>> >> We want _NONE and _VOLUNTARY to go away because keeping cond_resched()
>> >> around incurs a cost.
>> >
>> > When you say "go away", do you mean for your use cases?  Or globally?
>>
>> When I say "want _ to go away" I mean: cond_resched() is deleterious
>> to performance since you are forced to have code which can do the
>> rescheduling check synchronously -- when this could easily be done
>> asynchronously (as the non voluntary models do).
>>
>> And this either means poor performance (ex. in the page zeroing code
>> where it would be more optimal to work on continguous ranges) or
>> gyrations like the ones that xen_pv_evtchn_do_upcall() and the
>> Xen hypervisor have to go through.
>>
>> And, as we've discussed before, the cond_resched() interface, while it
>> works, is not ideal.
>
> I would expect that many instances of cond_resched() could go away given
> lazy preemption, but I would not be surprised if there were some that
> needed to stay around.
>
> Your thought being that if *all* instance of cond_resched() go away,
> then PREEMPT_NONE also goes away?

If *all* instances of cond_resched() go away, is there anything left of
PREEMPT_NONE?

> Given how long PREEMPT_NONE has been
> around, this would need to be done (and communicated) quite carefully.

I don't think there's any question about that.

>> Also, a man can dream!
>
> Fair enough, just be very careful to distinguish dreams from reality.  ;-)

I've generally not found that to be a problem, but thanks for the warning.

--
ankur

