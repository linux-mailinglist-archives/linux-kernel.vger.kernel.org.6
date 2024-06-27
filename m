Return-Path: <linux-kernel+bounces-231762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB73919D93
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 04:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8DC4284EA6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 02:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B9312E71;
	Thu, 27 Jun 2024 02:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="odG7Bub3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sp/VwO4l"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BCA18645
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 02:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719456720; cv=fail; b=uDlA0/ku/fXK6Pzk6KLSE+3MdHgv2A0ZaSRmWIntNJx5+BiCnFhOQyxiXIIPE8kC6iqhCXeeYMQjYAl4/wH/JWjPEehKKb+Ra41M1mxkMWezGWFJVY1/4EQgi7LdjiXpyGUWswcSxbiO9m/shjuCaZv+lT9RBUYemnwxoKqc2fE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719456720; c=relaxed/simple;
	bh=Thn2cZ5iaPcIrrX35cHXiWD5R+1YOxn8/5lWYqUMhoA=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=WUBefTu1DeTBEuECPAxanghY8pvTmmTd0PIYFVbaBC5CiptM5uO60mfqceyq9KKDrjT8qvJZHPK6oOQJVbXhqVxb/n+C4yOZrwWy8Z6LWgygxD5ZYQKcUQOZrsExlG1Yp685+Wx+aYZWeOzBZj2nBTDtnWYyHBa9Fx+auAStgvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=odG7Bub3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sp/VwO4l; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QLMVXR010606;
	Thu, 27 Jun 2024 02:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	references:from:to:cc:subject:in-reply-to:date:message-id
	:content-type:mime-version; s=corp-2023-11-20; bh=crL1JiIluWptWJ
	DwbU+gTo2SYiz1Dc/SIIelUTTEuyQ=; b=odG7Bub3nBPxU4Q7JwSLPQHmLxGAUY
	vRuRspGdvdv/fVEwvtzOnfU3QhOOX4RYPuT0QLERx7OtObQ1BHAX3uCaWESfUU9/
	JlKhcHq7o8HarJ60Gh83h96Q5POzzEsMM3Z5hX5AK0dc17oQjuuXjdzkSybwteit
	zWSbOdMzlVBfM4j581Bs51LphDGAhhmHG0AF4VXsc6jVBfj/+A1mnUKO8UHmLtql
	TsQHsEyj5X2DGAyEyYLJX/YUM/T9uEvAeINJmu94wX0DGcRu8YD7jgbBYEgW4Pxv
	D1Zim2DHW9Eg4YFd6Z1d8wD0VYBTvPZ+5W34ASrcCnc5aWA/tDhw0J2g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywn1d4jwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 02:51:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45R0THLD037036;
	Thu, 27 Jun 2024 02:51:07 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2ab3jg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 02:51:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xm37U7msZt1buqJLjEZh8+zB48JoMoY3WYT1vK3M6/QTBuOkN2IIgyz3cvPZUbnqb0xnB5EreShw8JmxDYqM/AK6OpQxc7sr/G6FCREc6PEif2AD+MVhyb7prN5ffDMRPlbG04UEsRwlzb7QxAE+2OPFSrZLQemYKoYS1A1zhomDMu6OEEbvYghqC+HoJOIg1ej3oJWpqA1HN1Hkb69NyQ7kJL8BzX0mVXjd2200HtUJ8suZHCVQtiM/L0ePg5pw/DMWDt6OUkiDUPYuYFEqd1JuBOZkchQaF3gbQy2VMlBiKAVnX2pbWkmZdSjAfU7y5cSfVx5gl0M1+7X8dmVDiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crL1JiIluWptWJDwbU+gTo2SYiz1Dc/SIIelUTTEuyQ=;
 b=dZBnKUvgYIJy2R7yPsnH2qKzigJytAk4jzdAPDEkZ5vm/z7ZaQAu7idhdC25eInbDIWllIYOJ/KTlDBoHXykjZdpyxlEfkpaoOEivk6RiiszN0z8aBI9XWyDQp9XD5pGo+WpLBfHwWWMbGmdziBgmGuk57QiprSrV72XNH3zsL1rpnMhPhEPX2vhWaB8nhqeWnCRmXx7rHT9ntR8Ef2VX4ThMejq55RR3vZMR/YlP47zk3bF+1a40/233nZ00GEAnbFv/ADANS97ixw+MNRnnazXRfZONU3joqU0IzoBiC6GgUQ4xrvuHz939EZ/qz0Ymq4faeBwZjx565+60nS8ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crL1JiIluWptWJDwbU+gTo2SYiz1Dc/SIIelUTTEuyQ=;
 b=sp/VwO4lpbQ4KpwN5rbAZgV9GCSBHMzqdDeP8qw2W9b9cRFLJuokdkYCKFNCPYgkDkZLI1ThbI3F8BoYsYAYbDzkCiVrlD0MUF3sFqNc/VEnhcCl7U7SKTP9WvkeQKTXR1b22EA6zRwzvVAUDveCZ4iq3CfJ77O7QK0V5heHsVU=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH8PR10MB6315.namprd10.prod.outlook.com (2603:10b6:510:1ce::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Thu, 27 Jun
 2024 02:51:01 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%3]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 02:51:01 +0000
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <2d6ef6d8-6aef-4703-a9c7-90501537cdc5@linux.ibm.com>
 <8734pw51he.fsf@oracle.com>
 <71efae1a-6a27-4e1f-adac-19c1b18e0f0c@linux.ibm.com>
 <bbeca067-ae70-43ff-afab-6d06648c5481@linux.ibm.com>
 <87zfrts1l1.fsf@oracle.com>
 <17555273-a361-48b8-8543-9f63c2b8856b@linux.ibm.com>
 <e7e2126f-40ca-44af-9287-888f4ec34b35@linux.ibm.com>
 <871q4td59k.fsf@oracle.com>
 <14d4584d-a087-4674-9e2b-810e96078b3a@linux.ibm.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        LKML
 <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 00/35] PREEMPT_AUTO: support lazy rescheduling
In-reply-to: <14d4584d-a087-4674-9e2b-810e96078b3a@linux.ibm.com>
Date: Wed, 26 Jun 2024 19:50:59 -0700
Message-ID: <87msn785f0.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::28) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH8PR10MB6315:EE_
X-MS-Office365-Filtering-Correlation-Id: 99e6d3f2-b3e5-45ab-7234-08dc9653fac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?EAtiRcopE46/tn2adPlnzwpitoQPmmUe96cANMWMwhdJBPcPVHIcFeFQ/OhG?=
 =?us-ascii?Q?VFhfbv5Q6fhmPvkCULQOUwFcqmuF2inlhLcjXkyGGS4kNjPusm4YjrdKvRm3?=
 =?us-ascii?Q?AVNykuBFylEb1tw36Hk/auRXT4Evwa8olVjM8eAnGuHTVi2BfMVILPW3dNr5?=
 =?us-ascii?Q?7r01NMn7AlHwsVl0ylie3MX8FuGf58MB3lhWFT/c4eKlTMiH+MZBsUTUsPaK?=
 =?us-ascii?Q?tbuVyTG4NlTg2c33/zkfTXf+yjB9WgJjJici62/QgYHrTE6wfZkV4ooy4h47?=
 =?us-ascii?Q?BnHJBwNBzX60WRJvG1jGB2U/9Yf4N3ZO+uJ40kUmGXpRIQWiwQDs890Fq0MC?=
 =?us-ascii?Q?nL/PmEt3Gnhg8g+eAPxcARLefvKQEbYNRa8AtAQ6owSoHRlgN8rPTlQw1iQj?=
 =?us-ascii?Q?N913Ezot92pvoJtzUbymQFMAD1oEhNN3UC9oIjEDvQgSqvrDszPUqDR9sfyJ?=
 =?us-ascii?Q?E3/jYz+LF/t8nFhEZC/jC/NULh/68DUS5gMODP1jhDIBWcXk5PVgriS0E+aZ?=
 =?us-ascii?Q?qjAr+lOQf6+lKvZysnSoQt/CC/JlorXxpQ1No33FEO/heENNFDjjqkqnKj8V?=
 =?us-ascii?Q?p6lbOGXuO+fd+RJR3sL2FRE4+ADXa7+FcVE3Dk/L1hCn+qwfR20xB/XFG5nY?=
 =?us-ascii?Q?WKIklebkYJ4nsxrMccMtWtiir69l1QrgdcRiI5aAr+55Qk1NU8LtKWnxdJOj?=
 =?us-ascii?Q?Z437CrjHlpKjMRmVKHjj1Euegm/IgQAHSSZZ7kbeMSNbC9pOSywhPcS5gYoY?=
 =?us-ascii?Q?S66Ngue9+oFibuTDX2ubXxEnwDYKZ9VAeuzX4aPiHalBb1cdrLPGYkMgv2Sq?=
 =?us-ascii?Q?/VSaK/fNnqMEdDx+kt3TCC5YrNWzaG7jYnkYRDlFR+mOTk37/iAczFDujevL?=
 =?us-ascii?Q?mDihTzXWCcslQXmAy7ZDkexUHP2m+C9St77d/JkeuDTwGelEAxiEjtCrgh6k?=
 =?us-ascii?Q?WsjBCgDGlqRVwD3OKvm/qCbhMCfEmkhKUI9RsjCWZfsterzMNd4RlieGp2A/?=
 =?us-ascii?Q?3I665BtkkyXWvlzAhJ1SiFE2YDuj4R+rL/ENeqDQG08Vt7oAWEXnvNhrqYfK?=
 =?us-ascii?Q?ibjCTzObeD1ty+bziu9awjIrRmBjzcWKz61M6LnpnqHBHZnFb5TFaYgyhaaz?=
 =?us-ascii?Q?mKFkakAS/0+AP7i1IepkukjAlKe5mdRhbwTCoPKW7aBMq/ceZ29bBtg077sI?=
 =?us-ascii?Q?joikICkRgbX6BeHOlebQJz4AC4IiD/5LOrBiNx1NRDQi0FpHKdaVbj5HxP1C?=
 =?us-ascii?Q?FZ3WdApEhlxbIgOwt9qYOfaJMTj79Bl/oMaZY/v9OBsQMuZjs9A3EWiY1rn6?=
 =?us-ascii?Q?S5v+yEkTIeOp5lwui0lwtbHTDUbF7+xgDD81rUDofGhQ+A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ATwvt75cfKJ9T5+F2J8YzXKQXbcNlfKVbqI9ohHrGIPHfswszQ/wjBp+qcSm?=
 =?us-ascii?Q?T2K/VH+slFiHJrTv1ItxNXTrXRuKOTCSLv5u8qUN1PE2pvmFJGuDog8dSJQn?=
 =?us-ascii?Q?Ycu6nv0LlZwZ8CGtCWa6tJ43i75bVqBBpNKiy8YxqxYD9pjjOnd2ONTspuJ3?=
 =?us-ascii?Q?xSKdqdH0/mof5u/h+SaQUkDw4Cg0HnFu8M4nyKDc3MHyYJ1qMgP4R0/FTtnt?=
 =?us-ascii?Q?4EIw6s6Wx8RfvwiWeZq3k8GeFxrdOiVUtf8t3YD1jZN9QqhlU7eq8jQt7uFj?=
 =?us-ascii?Q?IZ1WWEvI2JQT2ztouQDQJ4SIkQL0eRChpRTTwN1gsaSTDO3L1jsrvkd10azD?=
 =?us-ascii?Q?NIXw1C9fIzqrsCTU9+Vx8YIHEpxdydYXa3oinl7Il9jKslIg4WcDdcpbado0?=
 =?us-ascii?Q?oE2IIUEP8u++eQgmBlW8LdIzumFJc3wX3oe/LkRW0NLNshQQEJ6nzMwKSKF7?=
 =?us-ascii?Q?aAnjYpGiS6kIa4GxOVb49nuFYhD4lKGzbfbIZbf9OexDvXAiXaxCs92xiimE?=
 =?us-ascii?Q?NGwvW4WRU5wBdUNow9lSsVmQSbXo7CXeSOUH+xLs3PvNajsA7dw4IwOSAeD/?=
 =?us-ascii?Q?PvWkMuasQL1JDRo/skMQiDqBTDIvqYfNJac7Tq3o0zhW9sIkCzyR4NcniGtt?=
 =?us-ascii?Q?tjqS5gLN0jGWn3GVkD2KyK6760J+LvbhmxLAvjch8tFqvhjlUCk7+oqDMenY?=
 =?us-ascii?Q?CG2J59x6vWWMsK2bQM+6TAg4YB6fS7d6d8AYkCue6iIUcHjVGO5l/To7ak0F?=
 =?us-ascii?Q?Vamsne1MVRmBRxt3zWWqx33YIx2locQJZVm530TpagEEoKGmzi+FdQOwGma3?=
 =?us-ascii?Q?ryPG/x93zQd/Xx/B3b5j/ivn7ZNwVcTHQHWFOKctA1qttIZz8Msn9kHv2ZRV?=
 =?us-ascii?Q?dyGHU8vP0VpynG86HQXi23585MiKHF6RnucOeKCntiSOczM7OR3hzValbxIR?=
 =?us-ascii?Q?CtbEqoZHSEslufAP8ZJ6rjBC8W8zHuxECZnOVsYzhuRQUuQrZGD+EO5vaJny?=
 =?us-ascii?Q?A22g1dJnP+Swwo8+2LuQa+8+HaLOfqxEAdfyg00IGnjxN18ZPTY8VOdvz69H?=
 =?us-ascii?Q?h//H2XmOt0dAv9/WRkZpW+AOVd9HgVIZTYkgO5xou9ZwfO3cTa9JL7GBtFE3?=
 =?us-ascii?Q?WJ8z4to+zkZpjjnEuvp/ZuKTrgfRouVxTDyC6mM2p9vSATs8WVyEeIZXTHM8?=
 =?us-ascii?Q?OozN5CoaZa5uhg4rkJ4M5E1/xMrehvWwF3uZefcYOGoBEFRB/xoUotAprR6N?=
 =?us-ascii?Q?gvh1PqpCvUtKQIzIxRuOoiVrVBew376AVv0R/owP0VXyUQpuwpqBubRPODmb?=
 =?us-ascii?Q?67cbB0Hp9DSIsEu50E5ItbsA5622qdJFvJ7eG5msEjqwViNGVAtjwln3zPkA?=
 =?us-ascii?Q?jnKqab5hUnbE5ckTi7MEykSGZu+/gnotnPT6kXsuEt+mr8i10VPndflYK5hg?=
 =?us-ascii?Q?Ghi5TF4jahoUgpRw9G7GJC1gmWabFn9W9p5HLKR2Moi4o1LKnniYRfkuwM4X?=
 =?us-ascii?Q?tLHI88jE2D4Ut8aLaANbRRQ68R8+9DtuIuK2aUmDtWguXoFpcTkLIx/c5J+V?=
 =?us-ascii?Q?ltZph82YWSUaROlrb0D3XZJf9rSsCbs85SXUcIWOlgtHNjIwf53JG1zxLNRF?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	HvQOEuic7EsU2ON+EmVHwzIc/d0EYEx0HT8K5pL88OFo3dH/P3MhiumAXSGpnVm4euDHNShHH2dZi71FxX+zt0NiKAvjZjvE8/ztsYbLn7vCuGUPqbRS6dD/S0lAKYzo15WTQvznte8EsqLFdhpja5sXu7lZcOMmprR4mTyAQD2lyKNDQmXxa0iMO4hDC9lyfKgYiZTTKpRKFNWAStmDNr1Igk96pqtHVGtnm2n0E4+mTFOUnpAcGQ0DuuRw2oH1C+CHzKu9/eQfonsCJz4YU7cQRg0lLuGSVFYHwAKccTUF1VKBsIcPXDX7OQu8T0h/G0ohEH8g8UPOoUmLv64PRsGA+OXdVlIi/hQVurngOvilK8tdN0fi/IBloCrFmwrkpJtjbX4ORlnSw1ZcVAX5aXL4WJLt9/T6hDLeh/nIgNjG2Cvfvu3W39awwxviV/WCXS0l1IDvfdX3xR1cJh6M6XqzkNimyi0sG7CVezo8hfPhM3OZaF6SFes0o34uTkn13BOYHhEGAR/rF3+6ELjvPNdhqHxgrAwym88GtmtuvgMjr6WAnBU7+3GZyCXJqic8UNYeIt1QXD7hVxhEjRV8tR2gPMEoe/mCe6lGhrn5lHo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e6d3f2-b3e5-45ab-7234-08dc9653fac8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 02:51:01.6668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 22thA4esgwiGvlqErOv3i4LUvdfbffC6ZrrolY8gnWv8GcqInIc6O1pr/V8vz14JLLTt6Xo2C4u/VNDP0kRcqdxIFxI0XR0RoGFE+LvVRlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6315
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_17,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406270019
X-Proofpoint-GUID: E-8T2aQRneBuEbe5eNnxLsupj7kwDcEH
X-Proofpoint-ORIG-GUID: E-8T2aQRneBuEbe5eNnxLsupj7kwDcEH


Shrikanth Hegde <sshegde@linux.ibm.com> writes:

> On 6/19/24 8:10 AM, Ankur Arora wrote:
>
>
>>>>
>>>> SOFTIRQ per second:
>>>> ===================
>>>> 6.10:
>>>> ===================
>>>> HI	TIMER	NET_TX	NET_RX	BLOCK	IRQ_POLL	TASKLET		SCHED		HRTIMER		RCU
>>>> 0.00	3966.47	0.00	18.25	0.59	0.00		0.34		12811.00	0.00		9693.95
>>>>
>>>> Preempt_auto:
>>>> ===================
>>>> HI	TIMER	NET_TX	NET_RX	BLOCK	IRQ_POLL	TASKLET		SCHED		HRTIMER		RCU
>>>> 0.00	4871.67	0.00	18.94	0.40	0.00		0.25		13518.66	0.00		15732.77
>>>>
>>>> Note: RCU softirq seems to increase significantly. Not sure which one triggers. still trying to figure out why.
>>>> It maybe irq triggering to softirq or softirq causing more IPI.
>>>
>>> Did an experiment keeping the number of CPU constant, while changing the number of sockets they span across.CPU
>>> When all CPU belong to same socket, there is no regression w.r.t to PREEMPT_AUTO. Regression starts when the CPUs start
>>> spanning across sockets.
>>
>> Ah. That's really interesting. So, upto 160 CPUs was okay?
>
> No. In both the cases CPUs are limited to 96. In one case its in single NUMA node and in other case its across two NUMA nodes.
>
>>
>>> Since Preempt auto by default enables preempt count, I think that may cause the regression. I see Powerpc uses generic implementation
>>> which may not scale well.
>>
>> Yeah this would explain why I don't see similar behaviour on a 384 CPU
>> x86 box.
>>
>> Also, IIRC the powerpc numbers on preempt=full were significantly worse
>> than preempt=none. That test might also be worth doing once you have the
>> percpu based method working.
>>
>>> Will try to shift to percpu based method and see. will get back if I can get that done successfully.
>>
>> Sounds good to me.
>>
>
> Did give a try. Made the preempt count per CPU by adding it in paca field. Unfortunately it didn't
> improve the the performance. Its more or less same as preempt_auto.
>
> Issue still remains illusive. Likely crux is that somehow IPI-interrupts and SOFTIRQs are increasing
> with preempt_auto. Doing some more data collection with perf/ftrace. Will share that soon.

True. But, just looking at IPC for now:

>> baseline 6.10-rc1:
>> ++++++++++++++++++
>>  Performance counter stats for 'system wide' (20 runs):
>> 577,719,907,794,874      cycles                           #    6.475 GHz                         ( +-  6.60% )
>> 226,392,778,622,410      instructions                     #    0.74  insn per cycle              ( +-  6.61% )

>> preempt auto
>>  Performance counter stats for 'system wide' (20 runs):
>> 700,281,729,230,103      cycles                           #    6.423 GHz                         ( +-  6.64% )
>> 254,713,123,656,485      instructions                     #    0.69  insn per cycle              ( +-  6.63% )
>> 42,275,061,484,512      branches                         #  387.756 M/sec                       ( +-  6.63% )
>>    231,944,216,106      branch-misses                    #    1.04% of all branches             ( +-  6.64% )

Not sure if comparing IPC is worthwhile given the substantially higher
number of instructions under execution. But, that is meaningfully worse.

This was also true on the 12 core system:

>> baseline 6.10-rc1:
>>  Performance counter stats for 'system wide' (20 runs):
>> 412,401,110,929,055      cycles                           #    7.286 GHz                         ( +-  6.54% )
>> 192,380,094,075,743      instructions                     #    0.88  insn per cycle              ( +-  6.59% )

>> v2_preempt_auto
>> Performance counter stats for 'system wide' (20 runs):
>> 483,419,889,144,017      cycles                           #    7.232 GHz                         ( +-  6.51% )
>> 210,788,030,476,548      instructions                     #    0.82  insn per cycle              ( +-  6.57% )

Just to get rid of the preempt_auto aspect completely, maybe you could
try seeing what perf stat -d shows for:
CONFIG_PREEMPT vs CONFIG_PREEMPT_NONE vs (CONFIG_PREEMPT_DYNAMIC, preempt=none).

> This was the patch which I tried to make it per cpu for powerpc: It boots and runs workload.
> Implemented a simpler one instead of folding need resched into preempt count. By hacky way avoided
> tif_need_resched calls as didnt affect the throughput. Hence kept it simple. Below is the patch
> for reference. It didn't help fix the regression unless I implemented it wrongly.
>
> diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
> index 1d58da946739..374642288061 100644
> --- a/arch/powerpc/include/asm/paca.h
> +++ b/arch/powerpc/include/asm/paca.h
> @@ -268,6 +268,7 @@ struct paca_struct {
>  	u16 slb_save_cache_ptr;
>  #endif
>  #endif /* CONFIG_PPC_BOOK3S_64 */
> +	int preempt_count;

I don't know powerpc at all. But, would this cacheline be hotter
than current_thread_info()::preempt_count?

Thanks
Ankur

>  #ifdef CONFIG_STACKPROTECTOR
>  	unsigned long canary;
>  #endif
> diff --git a/arch/powerpc/include/asm/preempt.h b/arch/powerpc/include/asm/preempt.h
> new file mode 100644
> index 000000000000..406dad1a0cf6
> --- /dev/null
> +++ b/arch/powerpc/include/asm/preempt.h
> @@ -0,0 +1,106 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_PREEMPT_H
> +#define __ASM_PREEMPT_H
> +
> +#include <linux/thread_info.h>
> +
> +#ifdef CONFIG_PPC64
> +#include <asm/paca.h>
> +#endif
> +#include <asm/percpu.h>
> +#include <asm/smp.h>
> +
> +#define PREEMPT_ENABLED (0)
> +
> +/*
> + * We mask the PREEMPT_NEED_RESCHED bit so as not to confuse all current users
> + * that think a non-zero value indicates we cannot preempt.
> + */
> +static __always_inline int preempt_count(void)
> +{
> +	return READ_ONCE(local_paca->preempt_count);
> +}
> +
> +static __always_inline void preempt_count_set(int pc)
> +{
> +	WRITE_ONCE(local_paca->preempt_count, pc);
> +}
> +
> +/*
> + * must be macros to avoid header recursion hell
> + */
> +#define init_task_preempt_count(p) do { } while (0)
> +
> +#define init_idle_preempt_count(p, cpu) do { } while (0)
> +
> +static __always_inline void set_preempt_need_resched(void)
> +{
> +}
> +
> +static __always_inline void clear_preempt_need_resched(void)
> +{
> +}
> +
> +static __always_inline bool test_preempt_need_resched(void)
> +{
> +	return false;
> +}
> +
> +/*
> + * The various preempt_count add/sub methods
> + */
> +
> +static __always_inline void __preempt_count_add(int val)
> +{
> +	preempt_count_set(preempt_count() + val);
> +}
> +
> +static __always_inline void __preempt_count_sub(int val)
> +{
> +	preempt_count_set(preempt_count() - val);
> +}
> +
> +static __always_inline bool __preempt_count_dec_and_test(void)
> +{
> +	/*
> +	 * Because of load-store architectures cannot do per-cpu atomic
> +	 * operations; we cannot use PREEMPT_NEED_RESCHED because it might get
> +	 * lost.
> +	 */
> +	preempt_count_set(preempt_count() - 1);
> +	if (preempt_count() == 0 && tif_need_resched())
> +		return true;
> +	else
> +		return false;
> +}
> +
> +/*
> + * Returns true when we need to resched and can (barring IRQ state).
> + */
> +static __always_inline bool should_resched(int preempt_offset)
> +{
> +	return unlikely(preempt_count() == preempt_offset && tif_need_resched());
> +}
> +
> +//EXPORT_SYMBOL(per_cpu_preempt_count);
> +
> +#ifdef CONFIG_PREEMPTION
> +extern asmlinkage void preempt_schedule(void);
> +extern asmlinkage void preempt_schedule_notrace(void);
> +
> +#if defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
> +
> +void dynamic_preempt_schedule(void);
> +void dynamic_preempt_schedule_notrace(void);
> +#define __preempt_schedule()		dynamic_preempt_schedule()
> +#define __preempt_schedule_notrace()	dynamic_preempt_schedule_notrace()
> +
> +#else /* !CONFIG_PREEMPT_DYNAMIC || !CONFIG_HAVE_PREEMPT_DYNAMIC_KEY*/
> +
> +#define __preempt_schedule() preempt_schedule()
> +#define __preempt_schedule_notrace() preempt_schedule_notrace()
> +
> +#endif /* CONFIG_PREEMPT_DYNAMIC && CONFIG_HAVE_PREEMPT_DYNAMIC_KEY*/
> +#endif /* CONFIG_PREEMPTION */
> +
> +#endif /* __ASM_PREEMPT_H */
> diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
> index 0d170e2be2b6..bf2199384751 100644
> --- a/arch/powerpc/include/asm/thread_info.h
> +++ b/arch/powerpc/include/asm/thread_info.h
> @@ -52,8 +52,8 @@
>   * low level task data.
>   */
>  struct thread_info {
> -	int		preempt_count;		/* 0 => preemptable,
> -						   <0 => BUG */
> +	//int		preempt_count;		// 0 => preemptable,
> +						//   <0 => BUG
>  #ifdef CONFIG_SMP
>  	unsigned int	cpu;
>  #endif
> @@ -77,7 +77,6 @@ struct thread_info {
>   */
>  #define INIT_THREAD_INFO(tsk)			\
>  {						\
> -	.preempt_count = INIT_PREEMPT_COUNT,	\
>  	.flags =	0,			\
>  }
>
> diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
> index 7502066c3c53..f90245b8359f 100644
> --- a/arch/powerpc/kernel/paca.c
> +++ b/arch/powerpc/kernel/paca.c
> @@ -204,6 +204,7 @@ void __init initialise_paca(struct paca_struct *new_paca, int cpu)
>  #ifdef CONFIG_PPC_64S_HASH_MMU
>  	new_paca->slb_shadow_ptr = NULL;
>  #endif
> +	new_paca->preempt_count = PREEMPT_DISABLED;
>
>  #ifdef CONFIG_PPC_BOOK3E_64
>  	/* For now -- if we have threads this will be adjusted later */
> diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
> index 85050be08a23..2adab682aab9 100644
> --- a/arch/powerpc/kexec/core_64.c
> +++ b/arch/powerpc/kexec/core_64.c
> @@ -33,6 +33,8 @@
>  #include <asm/ultravisor.h>
>  #include <asm/crashdump-ppc64.h>
>
> +#include <linux/percpu-defs.h>
> +
>  int machine_kexec_prepare(struct kimage *image)
>  {
>  	int i;
> @@ -324,7 +326,7 @@ void default_machine_kexec(struct kimage *image)
>  	 * XXX: the task struct will likely be invalid once we do the copy!
>  	 */
>  	current_thread_info()->flags = 0;
> -	current_thread_info()->preempt_count = HARDIRQ_OFFSET;
> +	local_paca->preempt_count = HARDIRQ_OFFSET;
>
>  	/* We need a static PACA, too; copy this CPU's PACA over and switch to
>  	 * it. Also poison per_cpu_offset and NULL lppaca to catch anyone using


--
ankur

