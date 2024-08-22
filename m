Return-Path: <linux-kernel+bounces-297883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0A395BED5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 196381C23008
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CE81D048E;
	Thu, 22 Aug 2024 19:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K6l03OSv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oWUDkyDG"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C73C1D04BB
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354805; cv=fail; b=NeyNfN1NEZsuRoBsKjQlb9TsKI8jH2ZurGhXCsVQHrCBhzDEE/HLUVIbzkBsvRZYOiBPhGfagP03CMuvuHHdeadcSgphuSPLcLFr0EFuDin4CWGbVaNjVTHON/bz6/9ti0Frm6mxENHrdPqTXTJ7alBJnaQ/yiBCCq5lgGaYiJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354805; c=relaxed/simple;
	bh=n7bMIWyNOfnO7AnknnmotZ5t3XZizZpBj00pow9yzA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hs8ylwJ2jvCwnQ0g1j90vgXXVqdtvihJ+dMwAQrb26h28p2QdUH0qcOPuKNWnunF/DWkfWjPKXN3qbXVjrYEpWKlNaCIa5gR1LrgWF3NBm+O+H+8Dok3MUaZ7WpyBn2cOTG4YkmSmhW3NeKU8k2I/E1Pkk5OyEq6h64a4ql4HLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K6l03OSv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oWUDkyDG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MIMWp1019191;
	Thu, 22 Aug 2024 19:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=jbqzxUpWaWhe7HX9TTqUu2TcUsDnEJBssn9V4YZ/Zgw=; b=
	K6l03OSvOpzRptIlJrTntQ44YyewF3XNDFmUO0KLsF6uxQBQKFCq7D841twyZGj8
	eMlOyy1Ts8M5Y4cOtOtfbv46pcnQQLUTo/b5BKmEGPuqPZ/pTUdUx0PZEJ0WdLn7
	hG++dY/RE6GpyPfMMVJFBqP41v4Nk5VkKXNNxLHWOpIcUCKH153r8Sksep7/Rm9C
	x8vh4BN0TtEz63aGTN2VFzPKl/0n/COUYJz9CgFUQkOLReVeNSM0SDg6VEYx5SDX
	7egTvuHSIsmIC/abup2JhAsMNFtWIb4cL7k0RKSM2DVvxl+BaqAFbbdhKQ4MII2C
	ntnsENVfO+F4V7Xzj/XnBw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m45jw9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47MJJDAA005150;
	Thu, 22 Aug 2024 19:26:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 416bcu0830-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UzezXIb3l5IvbG0edol9qE+NzezrHfQA9S07W7Jx8obVj/dAYKBbYIpNe1yvOBW3ujx7i4n0pbPX+k/VBUvtJeifPy4F40R7jho0a1vWHCptZeqZLwFRsTNvxSOrSSrKG8uRkGAuLdu2hu6bWyd3Ue+sIOv21zqcYCYxPyWHAZXBDl5NmFmQHOqRJZ6FN6U3JQ0fpLSnGrYXLH7lFObXek0cUj7Ytvw7iEFfZbELwHZ/uJpoHhOlIjfu0YYjwqqvnZiyFUtHiF8o2gltq0B+ttAKW32UkAziP1TLCLjfksRxI/o6glZcrvWRLxbLokzQK96xS3MKI/HqkDnIeG1PmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbqzxUpWaWhe7HX9TTqUu2TcUsDnEJBssn9V4YZ/Zgw=;
 b=P+ST1HZMOhfeYHg6huLximeHUZ/QHhkUL5ogGv8Y2nW1rwh3Uc5QJd+cmjRXAf7cFhrX4aaaAHekNeWLMAnHbUFEhfJtUxBheS8xomqNw/zT9e5z8qVx1klQt4Ujh2J6UA3jlMC0/ode98gvF//PxlabVsU0ex7YPO6ZcNPbdZ5PkR7cj36RIDrozHFfTq+Z9a+FoUuNJUvkpHjsLK/9D0MhuSAS/zgKrBox6eZrt/6h1mJZmRTYnCS452DBTU2A0DoQUF3EVxLpjftEiW46vhqL/yFjud62ewSGordxI2LbnEHsRV3ITRWOCNPf2TmOcSFOx7YD4N8+7Yq76SfVqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbqzxUpWaWhe7HX9TTqUu2TcUsDnEJBssn9V4YZ/Zgw=;
 b=oWUDkyDGcDEu9JsI3oUKVBqWyQSXjCDjX0u93+CJ3x4XLQ+st3wO4DFGt53G37NNpkTQZGMYKqTt5VBZHQhrRB88E5RumW2PB5z6TIr8cg0FE0paSBzHsXQcGwkDeMHODoLswd/ki9uqdjPNDHLo26BehUi07c1y0g+Y+W77sKU=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH3PR10MB7356.namprd10.prod.outlook.com (2603:10b6:610:130::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Thu, 22 Aug
 2024 19:26:27 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 19:26:27 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v7 09/21] mm/vma: Expand mmap_region() munmap call
Date: Thu, 22 Aug 2024 15:25:31 -0400
Message-ID: <20240822192543.3359552-10-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
References: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0408.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::13) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH3PR10MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ec38b72-d7b5-41bc-99b9-08dcc2e05133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LEsX88v9PAIfVgHjRJO3egkqiTLScIJ6wtrGDCdzBOEYEVS/7NhmoNpJhtO2?=
 =?us-ascii?Q?djBtxpe4bJuyRcy4dRSJsUm+rAeRCTmQWVSmjAYwVk3Glpp+fQ8wV65gtuts?=
 =?us-ascii?Q?XA16Yy2jOLSHzFZKMMkBpwvKj25dzJWxWvIKHlJL+JoJg6ax/34j+qQZE6WW?=
 =?us-ascii?Q?5090aECqYcu//7MnZ9DEqt9xWvs9+K4779+ARoV44scyN1R+isrfQl5Df3Ng?=
 =?us-ascii?Q?KTxFS+KAGXxrC58ItSpphbYjo5hWuthinqvF6NSA9OQl9G7xy7Re3W2IO5d2?=
 =?us-ascii?Q?+WO0m4IXzB21iC7HF6G1ys+Ql8EBozK7yTJQH+V2RXaBf4qPw+iJ7ZoYVH/2?=
 =?us-ascii?Q?07UmoHQv0xOVPkasWO5pSAcM4HYQrKOlKkt/8s5aIQeq7lZxmTKa0QcIl32z?=
 =?us-ascii?Q?u0KkwlDvmz7qeama9nfJwCvXIJoHjHxZ+Qw9cEJRfxIEmqL/+AN07H1P2s9A?=
 =?us-ascii?Q?No8sPdwCJyTcRtKtG4PppDcWjQ0KC1Of+ZY7w48Pgz3kqFOOlqA08EFSMalL?=
 =?us-ascii?Q?T9bi0dJ86FUywXDFlcsCe6EZeCqAx6+Gc38CHiNHOaHbXsIPMlfwwDJIWtaO?=
 =?us-ascii?Q?vvCbosLcjRnW8SeebcJX+XDEM4Nfq8XBZl4C2Dk+TmLu4a0W3dmNy0RXVFhK?=
 =?us-ascii?Q?CCAliO6QIGGggxqUc+uK72jRAfe/IyYTJULdQ7YQIKc8Yi+yvITpm4yPNPit?=
 =?us-ascii?Q?CqSkXPJU0N/QAW1eV6HkBnUlEA3JOZ+higHO3g8X8tngZfR6BsTReaumL9Tp?=
 =?us-ascii?Q?5WXlNthNpOJ1uZQGLnSt1nb22ZbPSpd2cVLT3O2TICOwCq0S42tV6V5cS2dp?=
 =?us-ascii?Q?GJxOM83waCjU5T9uyAzkpX8ubfGVeFArFRxGKNemQxtQYhzbl+7NOjKVQoH+?=
 =?us-ascii?Q?5RGQZVcWD7t6O+q8qS1BdzwvMqb7dWeFcSalnBA0dmVSbFagx1D8sf/Gva3u?=
 =?us-ascii?Q?7S4kpHOYUONTZSGoqdbCEoigKe6o/pYAahrc28ff2l5RVr7pfNPcARZ1pwOB?=
 =?us-ascii?Q?Dyj6mNEjt1jPDXfbjNhINuRELg7JUDwuujnEK10LVjPlTvbPeR3k5fbTtkLR?=
 =?us-ascii?Q?e3Z6tN2J4YeYpF3WTgu3EY4x6T3qYbxi4wZnyE/p4ulA8oJy7+1pLs3YgYBQ?=
 =?us-ascii?Q?pYq0ctDeUGCdqVEuM8GVReVs+/qv52QSLfImOlj8Oqbv4SVwXbMcQ8aiVZbc?=
 =?us-ascii?Q?Beqoi3X2Y4iAB0V+mMp15+MRDKK2wbyVIWL9+PAe8SYZFF8PN+FsY4l0pa8j?=
 =?us-ascii?Q?QSpRdBGhvMShR+Q6tG4RsLJzpoJcU+OrKTE2Bbe2FG2gOHAeZhtsyf5CRqCC?=
 =?us-ascii?Q?jPKpbids0NtcyWBc0Sha5yXH8W0TPJthH3/6ym5Ln088cw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s2JXRcJLYvNAEiZzwI2bjfv2+sp3cou3XENZ9DVWGT+wjYAR+mm2jIQYWkMx?=
 =?us-ascii?Q?NrcKcx6TAZWVeJfRDnLFDu9r3bB/PoDg3yA5+UTE5y8VfXnupzN7olRmf0rX?=
 =?us-ascii?Q?7Sc/m/BYfoy++dSLMR9Leidr/rMYWRXzgxj/6Xjsd3mPZM8GCIdFUNKb1Oxp?=
 =?us-ascii?Q?nC+IAiJn9dKjqPUP9Ux3ikec/LcaOxmuUhKPK3cT6/u95JW7HGj2AfbKzEVW?=
 =?us-ascii?Q?jBJKzC1AzkNh0zb+UNt7ub0pj4Tn+phuo/F32BGDMAmmV9a3mlY9tFF+6419?=
 =?us-ascii?Q?NYi/09w+f62YXTj0fLHIRHf1AuQIOkKQlDUQx5bcjPUwME/xyUA8CE/ATjMo?=
 =?us-ascii?Q?daMlzxFuMSoBsiyVM5KGKOSk8FZv/XrXRap8a+G+YGYKl2JGsIFMvjCY2cIi?=
 =?us-ascii?Q?X8+RwpewW6yhSBHS6WAAbVbBbFJVMlS+ISr0M6lWhy1AX97y05glb0O5x3GH?=
 =?us-ascii?Q?RtUdoyl12FB2M+d+K5MlV8X+qD/2Q5/lvAqD66afpEjPrIaRSTDkBouU3Ahz?=
 =?us-ascii?Q?LJ9yFmD91pUtzmbC/uZ9nmzy7sQhNuByMF4jIY0XevPwZOouvB0i8ZjoLjzo?=
 =?us-ascii?Q?FX8Q0E5X+GcZzS6GGaEVQ+e3Wm+fu0bEjhVHAgCZcyJ89yuwrn10h7oly7x4?=
 =?us-ascii?Q?pF5z7RXrmeK85zfLNRgFgRJ2aDOtC5cXZ311YOxp8mN4DgjVNNzcbW0WEJWh?=
 =?us-ascii?Q?t87Uri91M2ZhAhKSrWFpYyOpcxpns/YYd5mttELe3qtniFCDgLUDqMHVx5FK?=
 =?us-ascii?Q?mV0AJ7+vxzAdSRuDyfy4RnTjLBLr/fPhDIkHRSf02js3O1qUaqokZucnAzfl?=
 =?us-ascii?Q?HSIi+g2ohX93GjSsB7nJDLaRJC7FhAO69bzpi/lbslmLyIVq3DaORJBZtU2p?=
 =?us-ascii?Q?zFkmvxj3q+7a2WcylgNcOHhPRzd5JHga/JRokW3Gwm3RiXXjJUHf7WS5rkye?=
 =?us-ascii?Q?GeWDgC+2vF5jAQnQzJAXm1FuQhILdijJy+IQpbvuIglx4caqwlR9I5VSVsmd?=
 =?us-ascii?Q?1PuucwVafqZaHBWq2AP416RTt2M7nkWAZofmzpLPMg0QG2WlxI5WWw5vAqmr?=
 =?us-ascii?Q?0DAkOQzdG+HqJOiZg7FnKuTkBvxrtH6c2zO1Wt4NGlC0tMtfmOf9XrZgwkNM?=
 =?us-ascii?Q?cRI3G3EpaxsGz6yZhywfL9UmtF4IKqC2VUv3xpmPUT5K2TzW/8ST6sB/7unT?=
 =?us-ascii?Q?66uDqpmX+6ovtA6NhychN4pqitfrFXQOxV3NhG8wygaThF8vbOlOLaTtIUK+?=
 =?us-ascii?Q?Ac31j3zadNPSav/LrRREOaiiv+rDwSkl5C1iCfvQj06oiHIDJ+ziywD1OAmF?=
 =?us-ascii?Q?5Rpdeynh2mtVLIa7f64tUK3C+2ozqoTeN0AxjJYiz0ewqZs1k1WwFZU1sh47?=
 =?us-ascii?Q?CUw3FrDmMVx+qwKYp9+T70TVPPXqIIFjQKGF4zW0sheI7MYJEHkRItCkAd3m?=
 =?us-ascii?Q?z1CRq0EMM/yhtidIs3BiFLtma8XdUc7p/mMN2L/MPlsIO4kibnzRYT0astam?=
 =?us-ascii?Q?JNHMUdhEigffcIffMAGvNNjN+A/eqPoAcHFj598KWL5VUOoYQ0xfPsnwL3dA?=
 =?us-ascii?Q?UTmuP4Gi27GDJFRFuMC6P863HVUuYmQgf9bD7t5ick/GxE+dfgHX/qfdoTFW?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ip5xySYsH8W3ZSq4IRupNB5r/NUw7pz8ICUrv7zwWVs/k/y20cQtckxoWNtlqD7H9sDsREp5bs27XhUrgqEL7cIrp4BLr+/3vlpEvrkaZs+nnJgBSETgM8KRKsCBsJVXOj2I/5D1/c8BKZotUMLyRHKV9mUtsmn0pPGiG+rUjzSWzug7C5/4L30tQDW0hreG/DtgX19+QAeVUF+jyqIz/iR01W/kcqb/gMTTG1YbUF77gzA3oNdeUKmGJPBhRL0BuowU/T4CqDNQBlYikXSn/mUSTrHi0SwYgFPdUu9tsPAjGcbcpJiJ1DBc0vXBe75p24cN8YEsH40DshjhNZW96MmMKwTvuavVA4jJfb0Z+fjLO93GakSDRO48RHnu5UW0DZKtUqA5BBiAbfNPcx0jExcWfWlYiqbsH94XaLIoBKStR7JWnFv0ab6OPMBhNaL31f0II52fctvcHfPXSqmUGAEq+sVdpECYwmvgd1chVpw46M1D90/tv9M/DtHzfLVRTDQRYUfUF2Ho5gTEfQOMkvq3fUtBttep3UJcjU5sDAuiAy7zFJ/6n6habkeClIJf5I1XzRDRr1qeDIJfu0E/1kyhG+X4TIvT+yVASXHPDxQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec38b72-d7b5-41bc-99b9-08dcc2e05133
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 19:26:27.2878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wxjpVKx/aAihFkLjjsOrc0OHttvSit3O9Juf4rthlm//io0M1N3O/4Xzfy5skWHyZaMeR2TfcAfnfaGy8JPVlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_12,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408220146
X-Proofpoint-ORIG-GUID: -oVfmSUzkAXdTqBC8nxOaJP-ptN09o9d
X-Proofpoint-GUID: -oVfmSUzkAXdTqBC8nxOaJP-ptN09o9d

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Open code the do_vmi_align_munmap() call so that it can be broken up
later in the series.

This requires exposing a few more vma operations.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 26 ++++++++++++++++++++++----
 mm/vma.c  | 31 ++-----------------------------
 mm/vma.h  | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 33 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 0f5be29d48b6..e7e6bf09b558 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1366,6 +1366,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	struct vm_area_struct *next, *prev, *merge;
 	pgoff_t pglen = len >> PAGE_SHIFT;
 	unsigned long charged = 0;
+	struct vma_munmap_struct vms;
+	struct ma_state mas_detach;
+	struct maple_tree mt_detach;
 	unsigned long end = addr + len;
 	unsigned long merge_start = addr, merge_end = end;
 	bool writable_file_mapping = false;
@@ -1391,10 +1394,27 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	/* Find the first overlapping VMA */
 	vma = vma_find(&vmi, end);
 	if (vma) {
-		/* Unmap any existing mapping in the area */
-		if (do_vmi_align_munmap(&vmi, vma, mm, addr, end, uf, false))
+		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
+		mt_on_stack(mt_detach);
+		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
+		init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
+		/* Prepare to unmap any existing mapping in the area */
+		if (vms_gather_munmap_vmas(&vms, &mas_detach))
+			return -ENOMEM;
+
+		/* Remove any existing mappings from the vma tree */
+		if (vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL))
 			return -ENOMEM;
+
+		/* Unmap any existing mapping in the area */
+		vms_complete_munmap_vmas(&vms, &mas_detach);
+		next = vms.next;
+		prev = vms.prev;
+		vma_prev(&vmi);
 		vma = NULL;
+	} else {
+		next = vma_next(&vmi);
+		prev = vma_prev(&vmi);
 	}
 
 	/*
@@ -1407,8 +1427,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vm_flags |= VM_ACCOUNT;
 	}
 
-	next = vma_next(&vmi);
-	prev = vma_prev(&vmi);
 	if (vm_flags & VM_SPECIAL) {
 		if (prev)
 			vma_iter_next_range(&vmi);
diff --git a/mm/vma.c b/mm/vma.c
index f061aa402f92..6b30f9748187 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -80,33 +80,6 @@ static void init_multi_vma_prep(struct vma_prepare *vp,
 
 }
 
-/*
- * init_vma_munmap() - Initializer wrapper for vma_munmap_struct
- * @vms: The vma munmap struct
- * @vmi: The vma iterator
- * @vma: The first vm_area_struct to munmap
- * @start: The aligned start address to munmap
- * @end: The aligned end address to munmap
- * @uf: The userfaultfd list_head
- * @unlock: Unlock after the operation.  Only unlocked on success
- */
-static inline void init_vma_munmap(struct vma_munmap_struct *vms,
-		struct vma_iterator *vmi, struct vm_area_struct *vma,
-		unsigned long start, unsigned long end, struct list_head *uf,
-		bool unlock)
-{
-	vms->vmi = vmi;
-	vms->vma = vma;
-	vms->mm = vma->vm_mm;
-	vms->start = start;
-	vms->end = end;
-	vms->unlock = unlock;
-	vms->uf = uf;
-	vms->vma_count = 0;
-	vms->nr_pages = vms->locked_vm = vms->nr_accounted = 0;
-	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
-}
-
 /*
  * Return true if we can merge this (vm_flags,anon_vma,file,vm_pgoff)
  * in front of (at a lower virtual address and file offset than) the vma.
@@ -698,7 +671,7 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
  * used for the munmap() and may downgrade the lock - if requested.  Everything
  * needed to be done once the vma maple tree is updated.
  */
-static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
+void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach)
 {
 	struct vm_area_struct *vma;
@@ -752,7 +725,7 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
  *
  * Return: 0 on success
  */
-static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
+int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach)
 {
 	struct vm_area_struct *next = NULL;
diff --git a/mm/vma.h b/mm/vma.h
index cbf55e0e0c4f..e78b24d1cf83 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -78,6 +78,39 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	       unsigned long start, unsigned long end, pgoff_t pgoff);
 
+/*
+ * init_vma_munmap() - Initializer wrapper for vma_munmap_struct
+ * @vms: The vma munmap struct
+ * @vmi: The vma iterator
+ * @vma: The first vm_area_struct to munmap
+ * @start: The aligned start address to munmap
+ * @end: The aligned end address to munmap
+ * @uf: The userfaultfd list_head
+ * @unlock: Unlock after the operation.  Only unlocked on success
+ */
+static inline void init_vma_munmap(struct vma_munmap_struct *vms,
+		struct vma_iterator *vmi, struct vm_area_struct *vma,
+		unsigned long start, unsigned long end, struct list_head *uf,
+		bool unlock)
+{
+	vms->vmi = vmi;
+	vms->vma = vma;
+	vms->mm = vma->vm_mm;
+	vms->start = start;
+	vms->end = end;
+	vms->unlock = unlock;
+	vms->uf = uf;
+	vms->vma_count = 0;
+	vms->nr_pages = vms->locked_vm = vms->nr_accounted = 0;
+	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
+}
+
+int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach);
+
+void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach);
+
 int
 do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
-- 
2.43.0


