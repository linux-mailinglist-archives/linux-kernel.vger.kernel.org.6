Return-Path: <linux-kernel+bounces-571713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 853FDA6C11B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D68CC16E2D5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8CC1D8E07;
	Fri, 21 Mar 2025 17:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sv6C+RWE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k7yB9a2o"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AC422D7A4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577424; cv=fail; b=G083tjhlbgs9RTOu1r8t+7Lvqh+8WvV0VcB5fo15B5uK0vnaQK/yKkpBvpUIiLyN000HPZtRC60ZP+N9KFKy/irs8Z3Iaip5DnBrNjgT4sHhdKSZxIm0WH9mZ3Xt1L0+CyKvruSmyB/nMyp4cxHDNWhmdjOW0zH7VWMN36GLQbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577424; c=relaxed/simple;
	bh=F57WRzlm361HBFUTzWmIWCzgOpBXKs01puvd6iYcEsw=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fOslBeb58pfZ5tLTifbBSyxGGYoeJAuK2V7jlO2eGzMgg2IWrP2KoT+x+ZnkMPkOt9HjzhXEsCHAJT+k0+UG/ZUQTDGg8eC44pIYDV7HHQt4GpsoF/q7AOE/DtdPosnWjtDkolqXPH1+caUBFp8mN65LYdhz/qvtNxXRqzTe3xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Sv6C+RWE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k7yB9a2o; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LEBs16002566;
	Fri, 21 Mar 2025 17:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=TmvR93oclY8qgkDxv4
	oQ5xxy8lMEOUheUcb4sq4A8eY=; b=Sv6C+RWEdAKVs9P/6zAUbKo20Z/3CWftKZ
	I5b2KQT0tZaemyfXBb1GLPcB+5imsanXbUJw1KwXzcvcvSAL4S5u7QWjala3FXOn
	C5V4BWwfsep+Aqg4TeeHYWdTh6Lx9fRH5/SclHPa2a1125HuZo9jqfoFmB5qpFD9
	bXwBfKVLkZchQWXww2kD/oLGyWp2hdG2iER/LgOnVhLot/1I0LQbBJ/IFY8TjtAf
	v0C8uf7C06NTH+ovuz+NPV9QnObQSjw/2imrb6xMrAoQKs6rnIigzIgPFmVkPj7A
	vLpv4mbZyyne3tjGuxG+3io4QKsCBNmogcxNv4i+dPdUpYRNJaSQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1m40jtd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 17:16:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52LGeqjt024957;
	Fri, 21 Mar 2025 17:16:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxbp3pnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 17:16:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QeaAtkJ/vOAEqPxXVLSYsJ9mYEKgtYXdWyy7JebeyEj5ehEAF6SU1BB99ETqj0CQzWCIv2uDoAXQl/dTGJSPRcGtv840Emc7FDwxuXz6NiHC9WoUErUKzuE9Fqgs1kRR3rs3+1Ikb/JjLka9lq+DtRoZE5RyzVzd3TouHhgO4EleLqGx+SbjKe88Vplw5Wt3Faoz1FAY7LJI/reS/odnZf6wDqKBKGPJPJOg0m2CB3RNc8v2Oi0rHgjJ++k5NLkMv2s/K89il4a9cnxg0ffR/i8U9V3cONJo+MftJiOdYBPwCSJG08yx46AhUv18N9geBS+NLkIi/96eBCVwpve9zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmvR93oclY8qgkDxv4oQ5xxy8lMEOUheUcb4sq4A8eY=;
 b=P748G0HcxwUHFUGDVrnUyUVEOQAwoXwCkSs0/jnBfuTRehEMmw1oPISuBx80+yjIcophyiUrjheidSLsgPY7PHhV+fLoT0m0zIm0B62vUVcDjSk9hdvQaWrdnlVFMR+l2FZ3JpIAvVgSXvxnlES1pk2F4susw4Mx3p5LVYSsgM+ZrKrD7kfyLBos+BJCYnkMG3KeDdmQgpVgCykPHN72qPSaP5mDrPdlVTbItg+ed4sDgUY6RV/kD48UDDwaXcbZVv8vBE7QNFWAVP2/audJeV0ubKwCqhev+yBJIVsY3q7hKlj/I+vD9zDVgthROpEy+G5fmlUaldTfmAq2PqdCXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmvR93oclY8qgkDxv4oQ5xxy8lMEOUheUcb4sq4A8eY=;
 b=k7yB9a2oej9HonLQtVOuVHCJFr5BBCzpff/Kg+JWjnkpaIwjWyt3v448wDOtmLL7sg3vKN5eJt+3LQGoLvmN7Vb8x7n5ed5krZElDADY7F9vHF+odsirGCv31bhHizQR2wkFRhd+n+721CtReFx4xttNiLb32Wh+GS0TqZ7p4+Q=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW4PR10MB6393.namprd10.prod.outlook.com (2603:10b6:303:1ec::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 17:16:47 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 17:16:47 +0000
Date: Fri, 21 Mar 2025 17:16:44 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Pedro Falcato <pfalcato@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 6.15] mm/vma: add give_up_on_oom option on modify/merge,
 use in uffd release
Message-ID: <494b3b71-4331-4365-838c-84974bbed32f@lucifer.local>
References: <20250321100937.46634-1-lorenzo.stoakes@oracle.com>
 <233o4lohzhriye27szk6mucduneuvosmnp6pmnjepz3enxjgtt@id6kwhjgysbj>
 <owmqbntgrnwzbjuyzq7r2it7isqjvskq5svvdiosfd6mjpiowx@gm2lu3gol34x>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <owmqbntgrnwzbjuyzq7r2it7isqjvskq5svvdiosfd6mjpiowx@gm2lu3gol34x>
X-ClientProxiedBy: LO4P265CA0179.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW4PR10MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f304ed1-d696-4261-5608-08dd689c2901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H23COaP8u1D1hjCpaiRMwKY7BNy8hnCUKyKFnMwcXw9tQ9mAIeiIYqrDvFqx?=
 =?us-ascii?Q?aDy6sDSDkjeOWCkdbn3Efl0QN6aGLyRHvoruSE4XQBSL0pYwSmbJzd8DGzBN?=
 =?us-ascii?Q?j0BgNoMGvgw149tuVs/ogkPZnk//ZVsoRDBCMfViYXmjhlnMA0Dkwj6+MH6G?=
 =?us-ascii?Q?WKJK2WZZtoW0Z5o3c3pwDfsQ2wihM+h2NPq0t5Cz/ctSVCCqf7xvm6u6Ld1Y?=
 =?us-ascii?Q?qEnTJAvps9a5sXqZtVpnxN2Yr67QbhV3yRWmrqKNZhC/70j8LfHbcD1Phsya?=
 =?us-ascii?Q?8be/TXOfvflwj8GSh1h+IzXR8VcCBokj6idJ+kbrI8TvgskKKESlxTB7ZGq0?=
 =?us-ascii?Q?k7i1NpYaG+k//Q/kkRRCYPNFypE4l3yqiNTbR2T7JlenhGQhCm+9pL+qykIO?=
 =?us-ascii?Q?clBrDrttLOXEGXKauwbz8PtLeM3C/wxVr3/iRJzUzcLk7uCKf1T4sP3YlGnc?=
 =?us-ascii?Q?ZmCAA6Qm5uVZvC1oq6qLHSXefTyDLvy06c3QfPHWP0vyREU/D/o1ryqPX0e9?=
 =?us-ascii?Q?yGjEONJqhm+0fgtSbuKnwNeIOo1UUKHl6ti28e6q+PXmx0RKiel59OLRx5Vk?=
 =?us-ascii?Q?4dNWKy3SOBhzT4JhXjzu7jWDYSzIBp7wcox9mKItUd5RJcLXlvlReT5CWe92?=
 =?us-ascii?Q?yCTA1yNnhAPUliH9e9Rkq57sOBX7GGxQrlDzG0zTgCZMVmZ01um6FHheztLg?=
 =?us-ascii?Q?P4EXmoJt6MC/koyRF1296yjuZQkHBKVi+08an3xuogaB5MfVefUaiFz580as?=
 =?us-ascii?Q?RdzAseLg6fgz9hu2T0o+fmi3CGyikq9pp1z4G1tG6DBsUODQm6gslPi4Z/ZO?=
 =?us-ascii?Q?SOhzD8m6jJnr6dhSBzCVMid8u7w/tGKIRVJ71aEJCzhd4ZrcGhxdYoGu3LXu?=
 =?us-ascii?Q?o4KyySdKzHy9NHpcrNNqUMqujvWA6X3/xCxRofA5PmeCV9LGW4cOqzvVrtyy?=
 =?us-ascii?Q?fmKPoVkL3HEn0gt5V7Le9HJ2c9x7Kq4UiGsju8AUSCHEeS1Xh9VvY0Zh/SM1?=
 =?us-ascii?Q?P9OYn7VMOFGES8bueGoek20CI9YnHW9SA0gV8Wmw4VqYJT57JmA4dRQz10Yq?=
 =?us-ascii?Q?8LC9OYNtvWAVREZEeJmImZ26pGTSRO6ZQ4jFgsjrccsd5iFOnGyJwTip3Wj8?=
 =?us-ascii?Q?+F6p3l3jiH65LNfj3CuypzDrdz6B/fCVMwvjj+uAUr4u8B9CHhS2rq0g66zC?=
 =?us-ascii?Q?nLK2tgy7aVDyEjsUA1mwD/+enjeByeig9smSc4IQ0zWemt3xrp/NFPZIyrr9?=
 =?us-ascii?Q?RSrRwfTzdzqa/P1Uu02RWT5e4uGBqhXHEzKj94o8G5Rj8f4J2HdgwyANBCgN?=
 =?us-ascii?Q?sjV+GThJhTn5QKiOPN5TGCi+P/iCizlTXP5IGHzDIBCV45QnmwfzAQ/Jm9fr?=
 =?us-ascii?Q?vAYe0OrJbamm6OTLhEtfsNtTaFdl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tngcEEV8+XrChTGzZiXPPdBVVZyRTJaLtHcqrfeCt1slsiFwHJ50XKx4ksPY?=
 =?us-ascii?Q?BAwBMVnfIyVHD4R80BknpsuBjmUlusCwySX7PIw1E1oKqGYgLaN745Vuj+od?=
 =?us-ascii?Q?pRq9F6Q1k4lKMEETEs4hC2uSpucVWc55lPc+UPVXrWm0oATBJXq1N8HI3hUL?=
 =?us-ascii?Q?RhKUgo2MDwYdnJS1FGaWIAbelEHmA1PZ7P8p1pT7uJvk2J6ms3sHfL5M1uK1?=
 =?us-ascii?Q?uufpJl9i/BnrrJSZpNkecLLBpQ0JFOybkEai7ljsYT99GkHJfzXHvDAJnZfb?=
 =?us-ascii?Q?nu1+IkESAvqvtjkqxp9p/u55VUCXFpw0oTOlHyGnOE+S/hINs2wQhuBL5F7O?=
 =?us-ascii?Q?OQoGy5cEbbglRzYsqGhLAdCNlSswMIf168pS8WM55P9TUX9CuqrJO4wvQn68?=
 =?us-ascii?Q?nifV8csh/OHbjEldFSRMC3XoLdJbmKGP3PmH69Rmz232sAPhgW0s6SBt60t2?=
 =?us-ascii?Q?bf8hh9oWTDqL2tpzaIQLQdsQhwyGamikWxMDG2REKtdgNROnjYyfzGElwzdQ?=
 =?us-ascii?Q?mhKQwrj6JtmxImxwu14fKZ2HoIZQKQA5XNoBYDvJpAdfXPaRTI/eMA8OH1Dk?=
 =?us-ascii?Q?WbTat4CyGiLIfYzdT/Qa4hYmrR29jqJCFMPt4juuSQrm9d/wNZr138wJxeuR?=
 =?us-ascii?Q?42JynzwiatLJy+6nDttljMn2xseJEd+VMJNuwfUit7E9a4UvjSfv5cr+qf3r?=
 =?us-ascii?Q?DtKCqDeMFInVsV7E8o6bp0WylW9bhUPnLNoUp1ebt3sQIYT/+6CeuE4nrGbc?=
 =?us-ascii?Q?yRvKBnVXYWBfRDS6J2eXLJyn++zSQ56uHOYrFE1TbbbD/u/s1RgetTE5Vhz+?=
 =?us-ascii?Q?c1yd63vzG1QmH+IIvMGF6efMt2BqbbaMavyC3ILE3D85lLNWma7XN7oNhpUD?=
 =?us-ascii?Q?f20DZ5NtndG2Z50wp1Me1XQN91E+lREDaiyA2Ag4aCTH30bvai48pb9yDlgN?=
 =?us-ascii?Q?WI9JanyDd9QGqxVoD2hOfp2/s3qe9tMqmNtDNcvw0NIvuiVwHMDhU4gAZlY6?=
 =?us-ascii?Q?wBMcXrPPMUzIwqqlJREFgf6M9zX8vv3zpr8mRZ95lf8D86qPPqn8nag+pOqd?=
 =?us-ascii?Q?FcFeIHPjPtmtgkP1Nv2Xqn26Hgg1IuNQ/DxvSPIWu/ib2JZ4RWIlfZEZhVv0?=
 =?us-ascii?Q?nttGKnht0tlWTCBD7SannPsYVHMMlMeSoGh1lQ6q/CubeIWVBnNnuFr7Oi0s?=
 =?us-ascii?Q?uF8cndwIIMHf3yrJtS6pqq5pSs86rlGP3yg+YI+HNc8iVSlmcPcs8X0arA6p?=
 =?us-ascii?Q?dSjZlrjUGK+RnVgaBOfGjsXp86nUu4sE6KYgNsmnBbc4/YxOnPIO3ZEdnhBX?=
 =?us-ascii?Q?yjsd+D0Bp8gTL3UvrdusScXLY7gqR8XMxV83cTPqVwsum1QUizGAM5v2Fiyx?=
 =?us-ascii?Q?Fl9czrR3ETezOdhm3+n3DtYM9HD8fRxCFucu7Md35wtobblZ7isZZtRhsykm?=
 =?us-ascii?Q?uoUzK0yISAtlo6kXb7BLZ5ORqCXaxG0B5O0sjM+Cl5ZVNGHYM+ommS7LNI6D?=
 =?us-ascii?Q?NVYLLNChmHjHc/aK8n4lX8pDEgm7gJV2HK4Uu3js65j9CnQN/LdS9+ayCOkc?=
 =?us-ascii?Q?uInwkGy9rh4y8/nDojY5dnN5uB9WM3ZSCttUcDlGVI/JsQAGeBP1bYUO1lVM?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Dd6Fims1q+XZo65XgP41JjYWnCYCzrJJgIKegRQZrcqI5W89sJysaT7ndrJh6YyCq03pZKA3x+im+GOMIXdH/yvEmuvI8vizKXQG+TbcRvGAUctu0mVgE5sft2KpP2RnH99KcDT2vwq2ERtGGPtGWVuN1WWdMaJILR/uYldpqlPhCG00sgsPD/uGlA+844eyvCkEb8ZduiNf8faGK/KzYsk1TtW3Bu0l41Qz2M/rwNpt+mdL8ij3Fnf5S452n17dNkjmJjfUAmxBNzgTA/sVZr72FyzKGQ9AVjxwboavf/Dk+kHKnbJndBSM3qP8bzwuZzSeMyWKD6Zp98pg34a1OTm2rQzwd785YDHcQprWI3JdFsunt7uQ4U+F+RZt62jYprSuLkUw0ab0DqbzKHRRBj0ZVUYexZGfmZ4sFrVg5d3DaTPIS4Ea8AP58IuAHvtJme7aYFTxYScXey1BR2A2g1eA0yivn+Kw+uCWJOXN9grjvGvG7askjNA3QtFuAZ98mkKXbQyTeARAQy99AK95YtcQGopKS2U+R8aqK8fYRUO6ZULDd6jDPfkeuuDItXyBHZFpCJVXayY0Ayhh4AoA8ZH9+8uug6wCoLjhtcFrxSM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f304ed1-d696-4261-5608-08dd689c2901
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 17:16:46.9447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OiPk9CDe9WB81xj+aSvgUFZRCN6FBOm3S5XQML9ckUirwEnuCxGNST8MpLzJGJV6E4f4HRp+hdvlRxIIPTIV6t8LWy3MP6+bvAbyJd9TV3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6393
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503210126
X-Proofpoint-ORIG-GUID: XvyOhlxUk7cG9esGOtI5Wg3nLYpuQdW7
X-Proofpoint-GUID: XvyOhlxUk7cG9esGOtI5Wg3nLYpuQdW7

On Fri, Mar 21, 2025 at 11:27:34AM -0400, Liam R. Howlett wrote:
> +cc Peter due to uffd interests

Gentle nudge for Peter to make himself uffd maintainer :) I am not a fan of
this 'happen to know person X often touches Y' stuff, this is what
MAINTAINERS is for. If you're not there, good chance I won't cc you...

I also strongly feel we need somebody to take overall responsibility for
uffd at this point.

Pints will be bought for this person in Montreal ;)

>
> * Pedro Falcato <pfalcato@suse.de> [250321 07:26]:
> > On Fri, Mar 21, 2025 at 10:09:37AM +0000, Lorenzo Stoakes wrote:
> > > Currently, if a VMA merge fails due to an OOM condition arising on commit
> > > merge or a failure to duplicate anon_vma's, we report this so the caller
> > > can handle it.
> > >
> > > However there are cases where the caller is only ostensibly trying a
> > > merge, and doesn't mind if it fails due to this condition.
> > >
> >
> > Ok, so here's my problem with your idea: I don't think merge should be exposed
> > to vma_modify() callers. Right now (at least AIUI), you want to modify a given
> > VMA, you call vma_modify(), and it gives you a vma you can straight up modify
> > without any problems. Essentially breaks down any VMAs necessary. This feels
> > contractually simple and easy to use, and I don't think leaking details about
> > merging is the correct approach here.
> >
> > > Since we do not want to introduce an implicit assumption that we only
> > > actually modify VMAs after OOM conditions might arise, add a 'give up on
> > > oom' option and make an explicit contract that, should this flag be set, we
> > > absolutely will not modify any VMAs should OOM arise and just bail out.
> > >
> >
> > Thus, to me the most natural solution is still mine. Do you think it places too
> > many constraints on vma_modify()? vma_modify() on a single VMA, without
> > splitting, Just Working(tm) is a sensible expectation (and vma_merge being fully
> > best-effort). Things like mprotect() failing due to OOM are also pretty disastrous,
> > so if we could limit that it'd be great.
> >
> > In any case, your solution looks palatable to me, but I want to make
> > sure we're not making this excessively complicated.
>
> Either solution is fine with me, but...
>

Thanks.

> I hate both of them, and I (mostly) blame uffd.  Some blame is on syzbot
> for exposing me to this unreachable failure. ;-)

So do I.

But as I said to Pedro, we -must- express this contract that we won't
remove VMAs before returning, otherwise later somebody might change logic
which changes this, not realise they just broke these stupid horrible edge
cases (that 99.9999-recurring-9% will never happen in reality) and that's
just not something I want to happen.

>
> I think Lorenzo's patch points out that we should have a better way to
> deal with a return and a vma pointer and we basically have that a lot of
> other places with the structures that we thread through to deal with
> mostly unreachable errors that syzbot injects.  I dislike flags passed
> in to treat things differently.  We are adding an 8th argument to the
> function (of type boolean) to work around this..

The top of this make sa very good point, but in reference to params, flags,
etc... well I have to say something :)

Yeah but it's a convenience wrapper function, literally build explicitly
for uffd. I think it's not quite as terrible a situation as you think.

And it seems to me having a flag/mode to explicitly request something is
fine? Was it more palatable as a bit field prior to Vlastimil's request to
move to bit fields?... Because you must object to a lot of the kernel if
you dislike that kind of thing :)

A lot of the point of having threaded state is that we can modify things
for specific cases.

>
> I think Pedro's patch is working around the same issue of return value
> vs return pointers.  Other places we pass in &prev and just do what we
> need to in the caller and just check the return value - which I also
> hate, especially when you look at the assembly generated to deal with a
> "non-problem" problem.

Let me group a reply to all of these as you're making a very good point
that I think has a deeper solution...

>
> I have no better solution and need to spend more time looking into it,
> but the number of times we have syzbot failing a random allocation and
> finding issues.. well, it's basically a class of bugs we handle very
> poorly throughout our stack.
>
> Realistically, I *hope* that Lorenzo's additional argument will make
> code authors think twice about the failure scenario when calling the
> function.
>
> Pedro's code fixes this caller, but leaves the possibility of someone
> missing this again in the future, I think?  This could be made more
> obvious with some clever naming of functions, perhaps try_<something>?

Renaming like that will not affect changes to the core merge/functions
called by merge.

We need that explicit contract. So...

>
> We are essentially avoiding the compiler from catching the error for us
> by returning that ERR_PTR(), which (keeping with the theme of my email)
> I hate.  It's fine for little functions but we've made a mess of it too
> often.
>
> Reality will probably not align with the realistic view and people will
> just copy/paste from wherever they saw it called... so we should think
> twice about the failure scenarios on code review and I think a flag
> (or a function name change?) might make this more obvious.

OK so what I think we have have is a break in abstraction, where we are
trying to do an 'iteration through VMAs where it's convenient to keep track
of prev' and then people duplicating the code, making subtly false
assumptions (yes pointer being returned with the obnoxious ERR_PTR() stuff
possible and -god knows what happens to the state if not present-) and
etc. etc.

Don't we just need a new kind of vma iterator that handles the prev bits
for us that can just do away with this crap?

How we get it to interact with everything else is left as a fun one for
thinking about in hot baths, aeroplanes or at trampoline parks (it'll be me
who ends up thinking about his won't it?)

Anyway it's all horrid, but I still think (in, of course, an entirely
unbiased fashion) my solution is the way forward, but I agree with and
Pedro that it's vom-inducing yes.

>
> Thanks,
> Liam

