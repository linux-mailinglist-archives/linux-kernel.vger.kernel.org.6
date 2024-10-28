Return-Path: <linux-kernel+bounces-385715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3E09B3ACA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BB07B21F34
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948C81DF75C;
	Mon, 28 Oct 2024 19:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mk0ipyHr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C3ddx1FD"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033613A1DB
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 19:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730145067; cv=fail; b=eqLZ84liQvvilqLOpeAhY2GHrOTvA8qSxZbOg91prUA8FNRuA/Hz4hjAIerke8yWWkKW/JVHdI+lDusaRqQXDSJBcj0//8tlrBBOFYShIxnQfPykm2N12NHMM9lwdxyuR2ktx2Pf4rcP5W5aD0d7j8utlGk1CXCH0DM/rrwWnd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730145067; c=relaxed/simple;
	bh=jK7LzeL58xRb7z1gzN8ArkNeGPyuK+yt2aoeNIB6krw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KPefcqZv0DC3RFtlbTnZ/HS3x8Yt23u68zh9mXreAElDSLH089aG4UOkRs3jLkt97tZ8eb4tj0mKLgU30ddqPfWei2js7f4n5qYv8zbBsXnjoFpg9WVdDQZpAnRKlreEE6Zjv5kRU1o2Kpv1l5BTxQvM2ylxt+3lDJSFfXXPgu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mk0ipyHr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C3ddx1FD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SEtbAW029434;
	Mon, 28 Oct 2024 19:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=kcKAVcQ5kOE2mtD8tq
	2pMLkguTJJcL0be08Rt6hR/mA=; b=mk0ipyHrgPElMsOKsb3FYrbc35LcZeefJy
	MBrjOeovmI54LfAwNzQdsicTMZjRiDm+cXppN0sM0Sz8bY1lMq6hF+KOwrhn7qEX
	a2ePsbaO8L3oJK6RVBcm1yp+DH++wiylnM8O76cQjitSn5UUIrg0YK/g1HjglkYN
	O9q93K77ZMtKzcpZPrSvKfctW6mmgzsFpqkjODyCs48iU24zF0ZcrhxboN5o2F1k
	Q5XD5Z2o/+H0OMiFNoevSy8J6yLSU0fkFwdit+NdwIIwcnQmJONBuXxbBNhq4QnS
	aPRnux832bOM7S26NjQ7h7H+HekjLhYNjAyuh0ewCUwNKF7dVHCQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grc1urxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 19:50:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49SIjI6q004762;
	Mon, 28 Oct 2024 19:50:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42jb2t3fe9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 19:50:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJXzHvhN8O1oIRTh9vinqHi3Ra6MQnMKwAOoyXb218Qq8jyTwAyP9UsXH5aFkRVZ+w+TIqG9rYghO2oqhp6kNq3sGmAUTG4WGTAcZPAy3xIc4cY/jFi3iBLt2CJQWa8VEnsHplG5qV4I8k+n3J2SfhulGoaqvNqkVXjjzxrmSaxyQ31hFh/PyakEY+vW+cxOD8DY0/gL6JX5uWMvSvMLSnCG7w2z9Li+E3y88l8RkuKJlOP9SwjdOFbKa3hAfdZKZ6ZZ0jkFRiCw61W53SD4Yxur9knpjM6N3UCWoZCcF3Blhrki4evqZspfsZ3aDCqLn7DSIwKBHYqgTFxoUS1I8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcKAVcQ5kOE2mtD8tq2pMLkguTJJcL0be08Rt6hR/mA=;
 b=SeT4MX/14C9j9pMFShIDZLm38Ov2Jm+Ack3KGors4+fyrFLMRuDvpCkFaSRgj8BrJcn6oMG30mD52nEHRdmQpvuSX4ehIjWEXVqiFXd6wWWGivGjseVUqhRtmyfbvzvhBtpFD2YuVrMI6PDzXMLu29jqZSgntM3oH9vIbuhGlmQNPZguEHhtDlNU6sVOzlTDU1lJbXZB/1d1oMkZB23TFPz4Zn9DsCAZdRUJt+92oy4yhaiEIgwoQXZ/6g9ZpnzbIxr4vdRsGDVvVCwCt8EzEA+0i9JRkvm3Eds+tiobaEkZ4A/eHPu52a8MXi5SA/CQxjgVVn748bGcVowgQ1h91g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcKAVcQ5kOE2mtD8tq2pMLkguTJJcL0be08Rt6hR/mA=;
 b=C3ddx1FD53a9AFQMeDIVOJAxZ6hUmlf7N2rQSEZy8TP3mN/5dfrF5kyIx4WJkucFL7pl2BL4Tqee7/9CaXdG473g1naKpF/YlguClLvLuOttMCywkaonzasdyljQMh+bkuKp7TJQSq/a8HkQa7GpQa7WiypnbCyEzVh53zY1A8Y=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA1PR10MB7167.namprd10.prod.outlook.com (2603:10b6:208:3f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 19:50:39 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 19:50:39 +0000
Date: Mon, 28 Oct 2024 15:50:36 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Peter Xu <peterx@redhat.com>, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: [PATCH hotfix 6.12 v2 4/8] mm: resolve faulty mmap_region()
 error path behaviour
Message-ID: <57mgmdx7wgfwci3yo3ggkmcnm3ujamgkwcccm77ypvmer5tegn@opiq3ceh2uvy>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Mark Brown <broonie@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Peter Xu <peterx@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Aishwarya TCV <Aishwarya.TCV@arm.com>
References: <cover.1729715266.git.lorenzo.stoakes@oracle.com>
 <6e8deda970b982e1e8ffd876e3cef342c292fbb5.1729715266.git.lorenzo.stoakes@oracle.com>
 <61461dcc-e455-450d-9c01-5465003fc31c@sirena.org.uk>
 <c24a174d-c8f3-4267-87ae-cf77fa587e82@lucifer.local>
 <CAHk-=whD9MrPwPMBgVG16T_u+my8xYtZg2tUGz932HeodVX7Bg@mail.gmail.com>
 <438f50c5-8b8c-444f-ae85-10e5151f3f24@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438f50c5-8b8c-444f-ae85-10e5151f3f24@lucifer.local>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0112.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::11) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA1PR10MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: 0511b418-9179-4bdb-e9c0-08dcf789cc38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kiLW91BE8RnZp3MO+qBIjoYGjzaqAkV6cTeZjUo30ViBlhOUh2Dl4nViVTZq?=
 =?us-ascii?Q?6F8G8XvNS3RekvV5ULr2i7WP8zUWo4Y2gs0agNLCM6XhtDbpD3qruKVrjUeF?=
 =?us-ascii?Q?m/FU4tEEqF8/oEEbdwYSlXmzNwKuuz5LJ0R0ixQcnzL1Nxjz56unIjyJuAEr?=
 =?us-ascii?Q?ADJthAtACJQtNApiNBbWly0g8mJHQ8epdPVLFDW+vwwYDNJN/fOT0gfNh4KJ?=
 =?us-ascii?Q?GWvPOBTGW72/DIO9CtmL5flUXNaFrqEdIoecSlAx+1Mu90TaAND3CvdIdpHH?=
 =?us-ascii?Q?RZAby6PsytFZw8ETaRNejGuE145VzVQLGv0jzWowLeh76ay8ztI6apJtPNf3?=
 =?us-ascii?Q?llL7AQyySUW0i1Jzd5X4oHuauG1MVViccztnFZGaGHm0/k8SVMMzPaScnr8w?=
 =?us-ascii?Q?8Zpfdal4OVjpwEJ8UFvCAESsLYfCmyzvTA0+a+b+a+QLiT3nnIGSjzofI0uC?=
 =?us-ascii?Q?EFBOaVGcyorjOqvVsZ0aAmaP6avlX3RM1VeziL8UT7BQSh+zHfgbCL3wYJLo?=
 =?us-ascii?Q?fVtYkrfxJhIYwzdTyXRrUdh0y+p0fMQknMxxlA5+3zQuBjmzJkwuTjiuOist?=
 =?us-ascii?Q?hJgRYi4zGIJKw6qnxSV04MjGvDOcVnFQxt8W75WhdAU3nWJRYvmzlyQ79aYW?=
 =?us-ascii?Q?FyJwR7Z3Qm4CNnbXYqW/HZLu8wqLura/di/Q5MlMMBox2lxBmUVrI6qP5e6B?=
 =?us-ascii?Q?vzb/s9wtYcqrlgVr8rR/TUJ9J0ZQYOdgEF80ebkn0/o90GIC+2PEU2Ili0pO?=
 =?us-ascii?Q?owf3DUTv6gXZKAk96ne4e4yquth7gS4CmLWpftGumuB8xq2IGZM2QbCZJCR7?=
 =?us-ascii?Q?dy8iRzgH0+LiKFVyvSGppLbhZoF9lTu/pOxObi2DkDgzZJ+T/aG4x2rW3q1p?=
 =?us-ascii?Q?xAvTKzIFG5PaG07fo2a3laKrRcPcswxtH545kXi1gStJT2iUN2LgjJKbM4QM?=
 =?us-ascii?Q?1kBJw/MYiOfKHLsk3D2i4RftipyCrQN4H1Hiu0dF5kMobxju6pwVUY5tLCua?=
 =?us-ascii?Q?PTJHi36+haV5rUk95uZuUtPeXkt7NoP1E9nNe3t4zIbsciZi4RTWo5Xkw9fd?=
 =?us-ascii?Q?QuUFNFCFl1SuHuJW2zT/jCupwBmChKVU9N80pyRSOrq8PBMklDnMnfsegtLi?=
 =?us-ascii?Q?4GCRMEcr9ovX9ymjqJOLlZdgxZUVL942ct2U2Tarf9nNJe2pH8Iz4rYq6AKh?=
 =?us-ascii?Q?pZMKQWJf1uVLRIslFolyBDhtZvCQh1kEaEZnDGqA0gJLQ5IMceyMnmNSt+B+?=
 =?us-ascii?Q?x1UEYY3KgkHyJyknIX0d49qJLzNYnkQOuAhyLYh1aJ3xRnrjTRwhW/aT5hUJ?=
 =?us-ascii?Q?hCTLc7s2nR4AqB6ZapeJjYfq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0mz1+UCew69E3ZJkoUzOTCW8yuIHu5Cb0B2vJOXfaALR1J/yIgK12PHwvnJF?=
 =?us-ascii?Q?VnT7RNVPuNQ2l/JLHd3oAPUwTzfJV6cINfpnBBTv3BjyubNrTcXidhU3fWnJ?=
 =?us-ascii?Q?CPR+n1SFCWuc1mDNPJA6Q3eNn+dez0NieYvuBIANEB/dTRouuZPAWcbIYdhU?=
 =?us-ascii?Q?/Db+eLaCZjPIsqgQI3mf0ZHFKRme4mkmutgBNpq6KLvrgYQoNRqqYcl4PNSu?=
 =?us-ascii?Q?JkWhZFyYQVBHzkcTwS+scuhcVb4aIHzfk+TgrgPa7hPL2E9szJRBOHJ00svH?=
 =?us-ascii?Q?yU8zayLt3aJ2f+TcnAgZiP3RHAxBpQQd8ooToLODeeYiPpLPkp/dFEwQmbtQ?=
 =?us-ascii?Q?I1kmAeg8C7CxUYud1WNBwiC+u4BnpTk+IT48norjVJZqewRUtRrua/P9ITxX?=
 =?us-ascii?Q?Kvo5lLLx7+m2b3mWwtQuEPDP2VO9QZkQTOxG3Qy4ERsiLgVDlAVnaZPqCO5n?=
 =?us-ascii?Q?4MefP4s5LqcPhgEfRe0gVKw+9WtIOfxPdPlygydWT+DmfonOZGx11bzuDEUe?=
 =?us-ascii?Q?+Y34IRx0aKQ1+MjfNErBTBsvKw44dQpDxkkKyltyMl7XUObCFmf9bu0IfNSF?=
 =?us-ascii?Q?/HyFECS3pYup2X/RPrBI13PH6Z28KycKAmnKRBXDDnu8i7aZgPhAR2jqZT1Y?=
 =?us-ascii?Q?15E7qsVBxWygYLO3ND0gZ2cicfcsDrv1m0VIp7gDkn5T6lcZ/vu+ZdeBqTeC?=
 =?us-ascii?Q?dg3Vqk015sUCGhcfENlBFJ4v1XCTCoC093G9PaxFEZiQQDj76fXzrClvhmCR?=
 =?us-ascii?Q?KeGLjCKGWjbrTJz6dq8JeJoK0qskx7xFV2VhNzUOkfyHWo5zFvIzNxb0DPZ8?=
 =?us-ascii?Q?C/fvHs5H7WG778pc8C/yx0oyaMD5oXzPifGrv4VWwX9tOYHb0hWp+XWYbUkc?=
 =?us-ascii?Q?8e6e6Rzvytqemo9Us//zdz0paRBe6a8S0AdyDNhBJ9wKpskhk6i6RXZ7u+S7?=
 =?us-ascii?Q?13egp/qpGggq8VSV8im85IkYVeLP+9mPaPsB3PHXniJQqoVYQ1lvUdx9hoEU?=
 =?us-ascii?Q?dkyjIPZ9XWJQ/OJ9u3aibZCgJzgHAJeGpZcXlJgxs+I5iIjvSBws6gE+TxBH?=
 =?us-ascii?Q?aba9guq3uhj8p3lNuRddwpkah8fLjsEn0XA7kPH/NXeEFMkTJMrfE6b7NGtl?=
 =?us-ascii?Q?opddSfetz/wbX7A4oH6KWJKTS6aMHRTgl1vYHVM4119E5x6jGPxXJxwcV9Il?=
 =?us-ascii?Q?C3vVdf8MOWcdSEX43gH0mxYj6hOMFH2bGPlzgZ5XsyIT8Rm6R0DLK1B9oMLX?=
 =?us-ascii?Q?ZDVVCRguWFA6Sg4BkXvcZLX+PA+5jXcP4MCdZw63GCeThKRa+OyzsGjZ5Mmm?=
 =?us-ascii?Q?RpjrdTfqz4YgjAGTUn/Ir7GEMP0ecKJWRX5GGqlZ+vkftWsydyDBJgiR4srH?=
 =?us-ascii?Q?2ib1G+JHEJO0RYZKyE+roY1td0MjIwGtg0NMLESRxDCAgLOGV0yiWGDAgvMW?=
 =?us-ascii?Q?DonERAuCeqvjFt6P7KT+R8wKLYFjyANwXh2Mv5SXzwwkU6EXoqDNus6TdTkH?=
 =?us-ascii?Q?+JggnUtyenCQiJaPipWGHEdnjNkGynf32pt0RMHrCQHfA8Y5mv7KpUzRfVu5?=
 =?us-ascii?Q?0+LcZ8hFqNxMt9Byj8soWnumiwIcEtNjURkg2/un?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NzFpT9/2bHlRzJZ2z2eC0fM1r4A7pzeVndLUz/vZWqjAPdWsR+JVtk32HRS/X5xexZvXziu9ROGyzEX9NyaM9VO8RD8xW027BKB4MBZheHHlRd1iiKbcJty5R95Ir2Hq/2dmeHTu3IVEdoemt73WEHPhO4qf9YxLOhXrkyi4dcg96llDILXZ40aNODV0fTRVGanq7DRLPU0TcRdI7HcE8KXrQ6TbyINM/de+wHbBKTOpwyJ9fgRWNTYaYBmFJ/6JL9zSF+xkR/QZpHNNwezrgCCph4ZiShOu8lCLd6eszc4aLH22lbGvmMsZPUEOZFJ+i5MWwLMw2lYOjpD+B+KC6FZJ8cg42ouawo7NUkZHiVYzxxUkoIFCY1uWiVQPuvVaReEZnhV99R+jZly1OznaQzOFxVKepMR8PqzTWkDqr1IQ4CkqRtSF34IhGCUzdhxf19lTrs+6VpeMM5wo/OI1co9rLj47ozq+27Noa0DFsfnJzus4+ogFVsPqs9/cbdt5ufQ6Phb/d/rNTep5JqtNPb72HXPgPBR8/3tTT1puutgnVHbKmuZoQl1vUVLEpPPDL917dTsSUbDJk39h+w43b8f6jYtIi7UjTxrYzcc6jQg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0511b418-9179-4bdb-e9c0-08dcf789cc38
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 19:50:39.0593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPICjV7+DJGCqpW4pNRm6N4eHTWPYi9p5X6MQxpNTnXhU7yfCIOdiFWIlH48HHL8CBGSxRLMqYg//0xHPaM//A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7167
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-28_09,2024-10-28_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410280154
X-Proofpoint-GUID: QzLrrLne8NPlGov9JP-SfBVPH1GW9F9g
X-Proofpoint-ORIG-GUID: QzLrrLne8NPlGov9JP-SfBVPH1GW9F9g

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241028 15:14]:
> On Mon, Oct 28, 2024 at 09:05:44AM -1000, Linus Torvalds wrote:
> > On Mon, 28 Oct 2024 at 08:57, Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > So likely hook on your mapping changes flags to set VM_MTE | VM_MTE_ALLOWED and
> > > expects this to be checked after (ugh).
> >
> > Gaah. Yes. mm/shmem.c: shmem_mmap() does
> >
> >         /* arm64 - allow memory tagging on RAM-based files */
> >         vm_flags_set(vma, VM_MTE_ALLOWED);
> >
> > and while I found the equivalent hack for the VM_SPARC_ADI case, I
> > hadn't noticed that MTE thing.
> >
> > How very annoying.
> >
> > So the arch_validate_flags() case does need to be done after the ->mmap() call.
> >
> > How about just finalizing everything, and then doing a regular
> > munmap() afterwards and returning an error (all still holding the mmap
> > semaphore, of course).
> >
> > That still avoids the whole "partially completed mmap" case.
> >
> >              Linus
> 
> Yeah I was thinking the same... just bite the bullet, go through the whole damn
> process and revert if arch_validate_flags() chokes. It also removes the ugly
> #ifdef CONFIG_SPARC64 hack...
> 
> This will litearlly only be applicable for these two cases and (hopefully) most
> of the time you'd not fail it.
> 
> I mean by then it'll be added into the rmap and such but nothing will be
> populated yet and we shouldn't be able to fault as vma_start_write() should have
> incremented the vma lock seqnum.
> 
> Any issues from the RCU visibility stuff Liam?

It is probably fine?  We would see a mapping appear then disappear.
We'd have a (benign) race with rmap for truncating the PTEs (but it's
safe).  Page faults would be stopped though.

Unfortunately, we'd have to write to the vma tree so that we could...
write to the vma tree.  We'd have to somehow ensure munmap() is done
with a gfp flag to ensure no failures as well...

Maybe we should just call close on the vma again (and do whatever
call_mmap() needs to undo)?

> 
> Any security problems Jann...?
> 
> It'd suck to have to bring back a partial complete case. Though I do note we
> handle errors from mmap_file() ok so we could still potentially handle that
> there, but would sort of semi-undo some of the point of the series.

