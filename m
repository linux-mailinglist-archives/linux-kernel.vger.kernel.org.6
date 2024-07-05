Return-Path: <linux-kernel+bounces-242860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD95928DFD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 21:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51F2DB21491
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 19:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA1A16F0DB;
	Fri,  5 Jul 2024 19:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a/Iu2gfd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v7CXs/qg"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EAA79F3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 19:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720209581; cv=fail; b=p1f4YLVtf1sdWDsCrlbL74tFUmqx7NTs3/dNsq3NFK80Q+h47HLnoftomis2sYIIjvAYGMcdQPbIVj1frTNhNytSrEggLoX/FnG60YdVkdCgHNH0KAVPcSIsjmNWuBckFz4en662cdEcBijnBA8CtgJSAzbjylOp6xEVWhc3KW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720209581; c=relaxed/simple;
	bh=qSqZmhMLhX/jV9EzL4yKHLnpUFYuahf64IlOSgltBUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AUOkF1QbWNP7KRdUJBc1RyLaTYAcKW45hLf/R/zB0kXBL6EP8WNvTHEs8grQbYfeP3Cgh1y0uD5bg7K+j08ZJRSlNtH0ZfVI6Lxhp6LnFhrhVw1UGhasuOa17+oBXcSuOi3DB80QZnu57AkRRdbpDtNBEsPJjSNppRxheY6fihc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a/Iu2gfd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v7CXs/qg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465GMW42024650;
	Fri, 5 Jul 2024 19:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=sDkL75pzntxAHnK
	e4PPjOYY5LR/2oW0ip0yhTsEaDJk=; b=a/Iu2gfdOqjjvn9Q2keKOmHTGFsx3zQ
	3gmOe1x3ipzWveTqlILSNns2hvEZZfBWJhMjQ5dJfU0XvCw8wl7ha4I+RWcgLHw0
	Y2PrxQDAr6yZdaCbVuI5O68EVyysIFKKWddufWkiWzibRTxh/jUnh3w1trXKLcu3
	wzEnko51WaCfMuoPCk8owOkCpi7l55Ve5XaRU/q6528ALxvSEl3TQtMxhnwKj8sP
	paBwsUtJHMYfBA4s0ilJK3XUyusHnSDrxXEmwaIQVHIKqMxVhcvYdvPHUIgJYdjv
	mXXGhC4BrqnkVy/ft8uSJNj1gQITSq2kvw+fvjFhHiWqxNGc7ktMsuw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402a59c81a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 19:59:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465IhJH1021546;
	Fri, 5 Jul 2024 19:59:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qhs0au-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 19:59:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKQlDiJd1UpnLSKQCXKxAYXhTbMKiCjC5Q9ZdFemVjxTG4DqDDWYZlf8wXVWCJAoxumMdAQsS5iat8fPjzWZHAXlljDlay7X0Udu2uwJ0q2KWZwKGcTHPIZuJ94HYVaAEMF5jk3aY0uTnUBSjbJ59z1cdNhZ+QvYj0yOoi2lI//UcEXKjjgjO7bFufDpDr7iLlW7J4EA5YaF0CQGm+HeSCq/esjsF5aNc5llzb7eNRK/l4yz46OjgMocoeRZ894Dto7C4Q8ZjrId+pJCZKcV6ygL6ZnY1jAlnQYc5booTY2Vg0KeyCK5pSbkNptf3jFGc39eBJf/500wb7nsTHCJRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDkL75pzntxAHnKe4PPjOYY5LR/2oW0ip0yhTsEaDJk=;
 b=jxh6uKkqatAV8DUdnQhqIzwrso2BZ3+bNPVVr7EvZkph9M4N66O/ThRQdejHexfauGlEVP2fpbzoos3Ks9uomZc5qK8tF5wE5JPfSuFHf5htHmmaSFPw8TNa14HCFM5/MSuY/qhePH+cqRCEr9QB/FvGVVnihLlJTQjh4wfzC1zrHr5RTiHUE45aviRj8OrdqDleBmW8me8c59Nbx1eIk92d09g2DXpJbr/b9F+rIu9WiUhs8KX4E811Ysp1vnUfuOKyxw27Bm3UL+gGCJjCslaZxbSNqXB1VVvUou7VNxIfIU57LVXkjvu31P+k9snnyMiYDHY6Bf/ENaopky+41w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDkL75pzntxAHnKe4PPjOYY5LR/2oW0ip0yhTsEaDJk=;
 b=v7CXs/qgtbp2D70FKIOOm3zZOCUrz96l0U9nXMy5/9V2K+ByX5if/zLI3ZULLkCPS+JMRpe/RHOkxRSJu38f4tbg/wLhQhEj9J8nvTHc+AqRVQ6teJhozwVHvjVtiKRI6XyMc6lmorQQFyu02bYn/WmGT60KiHt9XnWFXewjpNo=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH3PR10MB7186.namprd10.prod.outlook.com (2603:10b6:610:125::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.36; Fri, 5 Jul
 2024 19:59:21 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 19:59:21 +0000
Date: Fri, 5 Jul 2024 15:59:18 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 06/16] mm/mmap: Change munmap to use
 vma_munmap_struct() for accounting and surrounding vmas
Message-ID: <l6j7mytvepxnpxzq6i4kru4datfxhijf44lzugltbxs5f23f6i@lsfcft2tkg7j>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, 
	Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-7-Liam.Howlett@oracle.com>
 <f12e65e3-adfb-4140-9aaa-e7b11cab972d@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f12e65e3-adfb-4140-9aaa-e7b11cab972d@lucifer.local>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4P288CA0028.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::14) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH3PR10MB7186:EE_
X-MS-Office365-Filtering-Correlation-Id: 14523bfe-69eb-4517-efff-08dc9d2cf5eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?MbuwoWQqHh7M3BZHDK7Z2E/TaQ6UDU85xiMLT08zSVjcJXPhQnyb8EwRosQc?=
 =?us-ascii?Q?+2V1eagn8EFJ6nPe5wnt/R1gyGyp0kDRq8q1n4lQf15oZgCdTSQT53W4J/jP?=
 =?us-ascii?Q?8idPCxaF/GC0GiCKh9bVlBRYHPlSCF8d01EKsuVEWFF0dZloC53udUPa7El9?=
 =?us-ascii?Q?2b8u8AapnEQsW0r15QxlvgLpUwC2DsEPnv8852TKOM26IghNxLmI5BCBA/+z?=
 =?us-ascii?Q?6EYrX4eaH+ECMRYaXIxY46Zirpqf49nxB3N4QHo2hO81IrBDMJqHSwkIOK9x?=
 =?us-ascii?Q?Gmm+ImN34g0WBiX5ZxfNfvns1Qud8WmXIAahPoWY2l02oOJmR5Q2AjdAOTX3?=
 =?us-ascii?Q?E6pXZhZTReT9yr91eT7/INNYXrwKNWog0N7ijdyyAEMZdviZj4Jh2Kh3l2Qf?=
 =?us-ascii?Q?ZkiyJzbn+yQoF9k8xplPpdTAC7Suwn2ziK74kCXBC1izFXUSCUJ1iTQniBwW?=
 =?us-ascii?Q?6KtKXEN4juUqWw5pl6Pt+t/UjG4jY4wIK25mq2xnZGVwApv8RQfDpbtfwfBz?=
 =?us-ascii?Q?UrK4D+Ipn1vN55gofTuQ45pLrKZ4XJtmQYMkuIAuiidbZ7U6H3dYQaipWPpw?=
 =?us-ascii?Q?OQqY8soKDMtpPINeGNFeb4oVQFuA+RfkJRHkarAknGJTsWkQ8Ow5cEUFoiQf?=
 =?us-ascii?Q?vb0c/jCxLkoG/RpJpZuW/GQmKmbwJbFhY6nejpXui/SoXY5Tsk0poPfyoAS6?=
 =?us-ascii?Q?/a/uEBJum1wdkZurf+U6QBF0ro0xljKsV+MN1Db7jfdUHpijWCTdDrzonB+W?=
 =?us-ascii?Q?qoONfgtNTZTYtLJIrql25U0hunCXE5GuQx6BkgKyrlrSP5elpZG33EfFQgvc?=
 =?us-ascii?Q?n7MUEzsgHI72YItDygODNa/yr/RJUJKpk7/8s2crdbfSppgNz6NuaNJVY1il?=
 =?us-ascii?Q?SDIJ+qYnnGHbO/TLY6odgzidgytrmdRsm5w2/OCkTIoMl7gmjf81CX/kq8wW?=
 =?us-ascii?Q?zvTgjqF1whCl73e9sWI2aMZeZKwJKKG0rLRNavrdBJVwFUuWoM40j8Iwczhh?=
 =?us-ascii?Q?Ix8swdGyZeROa9inPGjv4Ovgx7KJ/FoXruyeDNoTt50COhBtqn+FXCnHs9Po?=
 =?us-ascii?Q?bdQnaIit6b/OYATEVkRzwXgJHfiSdPrzjAloDN/5GEjHudUjh+jSZELUzpvB?=
 =?us-ascii?Q?WIjyGdkuTVIUbiIzXBgEE9+MyCBZWE4n8izU8sSInXoVPXN9IXMiW2EsDk4u?=
 =?us-ascii?Q?Mzp0AcViXiDgSEro05Kcr46/LGu9IgCm2EDTlOHYUfZ95cZhaizwCa61PzW7?=
 =?us-ascii?Q?XZWx8zSuF8pNk3YwLfbH/hXIJSIEGACGKY7U4tXG1rs63a5xz76Htr3iZIMS?=
 =?us-ascii?Q?hTCuuhZktrIkBSxYsFnBoTz4GF9mO078EJWwH+pzNOVoNg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qabuTa09LDN5UeSVVLwBjHbexDoUi2xHiPHIcfJwHaYOscm679379vyUPqCs?=
 =?us-ascii?Q?3IQWs1ndTCBYEjRDozsZ2BEvDJeanI2cGsqCosUZNbfC1bBAtwuSsd8RRtu1?=
 =?us-ascii?Q?PwKz4ykB5MW7JSIFPUlS716WoT6uATPB7bGXojmAUUdKGZHSaq6C3caUX6Pv?=
 =?us-ascii?Q?doa31seHdZatoUbeq7hoBJxxzXuBcW2uF+P7isyuxUTd2/AAvlPIni7sc6Li?=
 =?us-ascii?Q?5DUf7WiC9wiKJNuK1RdRdFZAX/dyPQWGJstwhCd3uEPDIjKxxjaS+KJU1zEn?=
 =?us-ascii?Q?72FIHXqbiaxCbJ0HhSxs3T4OonE3zTYPfiG9LBxQnK1TiiPeNWg83uBwbL24?=
 =?us-ascii?Q?NgbZKd9t3ZHRZFGLwgLRdxXJ4566QC4GnxlqlBh61sKpX5pF2iJH/iwXcksd?=
 =?us-ascii?Q?czgHFG7JjYhxPr77HO/WXjhXbz6L+VJ/t/7ucn6G+7HSL6RbfbvbPwnsOSsb?=
 =?us-ascii?Q?P6koW9Wur9snU6S89Vq4aAmkXC3Gsk8Bl/Pfm4ZqbrPIusE6R7PF/6k+ppKp?=
 =?us-ascii?Q?/dafsODEvZa2jiwkUGbeOjAibfhHzOCbtM8zfo4ULT/RxXuykbvgwn0zhjWj?=
 =?us-ascii?Q?KnWM4hwiSKqM9DUdBRczEZQnnyOR9yw56hXKSLCGP8j3OHSIbT0AtwT/5VAS?=
 =?us-ascii?Q?ubStcvkveLp7qtijkfR/HWs9WXNqeVE15QjJsILYOBd/FvdWzH73cHiwQ1Hw?=
 =?us-ascii?Q?D+miZUKBwJu6J5b5cwrR5BVqkSZUgVCc50QPWZ1mC4aRo3huBaUIZ8DAPsJ5?=
 =?us-ascii?Q?pJkMeHom7h6MzLofFDWXBbjIylI1kfGnPZE60nQ2Phxb8yT2VXjD4JVoQgLu?=
 =?us-ascii?Q?BSGoTyfv7t3ySAyTapBTnBQCTK3hI9UqvjbYSk1A4gv8e8skQMjmg4KA9SB1?=
 =?us-ascii?Q?KEX06MvVx1dBvx8vlw6VsaIzwDc/y5UXo1yuZypXh9V3/BiQwUMbiVClq+9L?=
 =?us-ascii?Q?11uQopFQDsQmQLFfx+uYCNscxhGNFpZdIESlVxEc80P90D3b7tAECucwVkpQ?=
 =?us-ascii?Q?aPTp45NYuCTPRlDI0QQQLL6JwAGzBbXOtk76+xK9Bq/unuGNCaF/KueCNozR?=
 =?us-ascii?Q?pBhFHMgGWsMv2KW0oTLqR+kaEeiR8iYfu6s0bG1b2+xrC2TmNCZatm6/YNfG?=
 =?us-ascii?Q?1955AxEgTypo5KD6Ba1wedSSzJ+Qm2Db/fYHQ6x0GsqeQ6wCowe5CnBZ3+Zt?=
 =?us-ascii?Q?Tn1NFszCFS7OxZfA7MNX6/A3yZgfdozx8zTRvE1+7+3UxJMew45Pn+vWz5Lu?=
 =?us-ascii?Q?AQDpraTTMmOaPcNBq28p2VzJDc326LgxNyPdvFKsnnDfFhFDlu2W5KeSn9Ck?=
 =?us-ascii?Q?JsrIXJSWxB9y01Ec3+HFm8zMN+8RxOlZE25pvAFVvLSbtkz/sVhu1P2Tjeg9?=
 =?us-ascii?Q?uDrekYx3osEDJ56DKHop7h2l1fkvn+P2LBLDi5DPGhQDQoHBLt65p2IC76q9?=
 =?us-ascii?Q?/SzMDubF1VgcEC2Ycph//p4OzQCqY8jiiB5XAIskKKqprPX2c+3FAJBjt/rA?=
 =?us-ascii?Q?Wb4ncdDD/NUKAKcpGWDOvAQ+7yM425+FzmyaqN/8ZeQ4S++0lkGGA9jDQqXB?=
 =?us-ascii?Q?cxk2H4NMNbHdYpn2aRTdC+5+YuYZo6XHhaxdHTXN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GVkMWF+m4KDU8MNaTF56VWuVxdLYQnjejmmSMJzOhWl8HFFJvToBzYkfIHmHdM3thG3x+yGtuFO+jGvK7/gcbDv7c83IQUYJBshOu11eVmvyJjgB/wuw4YsnGnbJQx8fNYMWXM8yFT5CrmacSeg8QmxjdpgCnmFpo4OnweYmdGAuvforvABfF15SDVWbxO8si59zxecQqaCnB7OYe0+gFQZutlROiMgQp2Vn9fd9xrk9j5tG+xlBuBr+flx7/OcQGFxyPOp81Rvo5JXBZ9MQKuRdxrumEzFGzMRVRR5E83othj68ouPNgYGd/FCmZt2r6/r5OiAVdoz+4guq+1Buh8QfgWxYwc+oywimK+PINFbLECInovTWjXQN0nGxdhCYnYIXaWbE7Ynp1Wa4bIhSL7T9tgKwcNxBWVippCrkcj6ivLIiE7WGH0D+CJiunchpLKiSa5KnINcXr7Pg0n6/hOWjjOEYdFTvjQN5fWZxCaQB/3f4AqKg5dY27yAdZzgHHus167hZY4MIwCdYnkN2eglpmwjA+/oqVF4JM2d/rVUl4X/5tadKt/ybGIrrOCbJl/TOzzPxRVxymixJZcqeRjFQWvuQTjBbLj1QtGiHhTE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14523bfe-69eb-4517-efff-08dc9d2cf5eb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 19:59:21.0861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wcdpyJ5MR/Vu4OTPPriEP4xm3/FSzsIcgf95XzjOocC0pNOm8JFn90BgLTUg0Bvrnmi+gAXOweuxH4mN2VjfbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7186
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_15,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407050146
X-Proofpoint-GUID: i1oGay83KWMf7KgDMJyobanQgDd_1QYO
X-Proofpoint-ORIG-GUID: i1oGay83KWMf7KgDMJyobanQgDd_1QYO

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240705 15:27]:
> On Thu, Jul 04, 2024 at 02:27:08PM GMT, Liam R. Howlett wrote:
> > Clean up the code by changing the munmap operation to use a structure
> > for the accounting and munmap variables.
> >
> > Since remove_mt() is only called in one location and the contents will
> > be reduce to almost nothing.  The remains of the function can be added
> > to vms_complete_munmap_vmas().
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >  mm/internal.h |  6 ++++
> >  mm/mmap.c     | 81 ++++++++++++++++++++++++++-------------------------
> >  2 files changed, 47 insertions(+), 40 deletions(-)
> >
> > diff --git a/mm/internal.h b/mm/internal.h
> > index f1e6dea2efcf..8cbbbe7d40f3 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -1488,12 +1488,18 @@ struct vma_munmap_struct {
> >  	struct vma_iterator *vmi;
> >  	struct mm_struct *mm;
> >  	struct vm_area_struct *vma;	/* The first vma to munmap */
> > +	struct vm_area_struct *next;	/* vma after the munmap area */
> > +	struct vm_area_struct *prev;    /* vma before the munmap area */
> 
> I mean this is about as pedantic as it gets, and, admittedly an annoying
> comment to make, but the ordering... can't we at least put prev before
> next? ;)

I can do that, no problem.
...

> 
> This is a big improvement overall, very fiddly code.
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks!

