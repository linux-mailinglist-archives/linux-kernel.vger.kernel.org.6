Return-Path: <linux-kernel+bounces-305585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A1A9630D4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5F028697C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B8D1A7AF6;
	Wed, 28 Aug 2024 19:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dSffaoSz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RN/8w5pB"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D093158546
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 19:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724872633; cv=fail; b=rYR0bt05Xj8DtxPtSI9C7+Ei2OXZOZQyl9RAYlRqtHtnNpNhDUJeL1LHVH+q8PlKX9qGGWW0pCmIVgCXrvqY7OQ4xj4GI+ndvF9hUDodEuX97gI0eJr2PUpeRzxtkECPcM9Yt9S7UaQsNAnRpKbSv1I5mFP6X89ziNlnyzIxUrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724872633; c=relaxed/simple;
	bh=QPcKQWiAgNDE+ylYdrRefRvq4REeoC6w+xEcCD6HG6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=igdnWwMa9A7bIIQIrkPJWbhEBRfZAQnM+mRJPCPllngD6y2zwtP0aNlnyHsTjkZhFqMnf8SpNNID/JhnepHE+nnC5jSzrOqpVH64TOk5ECjTnknmJUrR0pnxCfjP7S5VngKG04bMUZsGN2kY+Mtf5CZ1Umyn+0/N61L8W5+iF7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dSffaoSz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RN/8w5pB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SHfZEW007421;
	Wed, 28 Aug 2024 19:17:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=kRH3ayna4qFApdK
	LvnmTt15cw3taoNMh9Yjgyv7VLnI=; b=dSffaoSzm09k+NKFt/q2RfMOSKZZm2o
	Q0A8X7Ld53WxbRe7xap1N6B0VXEDglYItZxJYvyY3yUBfFIzBOj5fhmSdxHFVqd4
	ki858b634pfypTZL2IlJdkJJC6iXBFgJbY7k7p29L35qtLIaDD6/gmdnlk05dShb
	7gG3Aq0zypyn1FcmtPlhAzBwQ2Y8xEwvWJdyNG20Rv/7E6UzKbSL726PsoYbvHCX
	ACsoASznH8QOv95zraklpaT0rINiHhLk4oUL3dUB2KFEt6mc7m8uJn/9q2lonc1Y
	dRdV7LHB3GrbJf829pmLd8c71eoosB4Wu8VGdrYGIokqHdB15CfGDEA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pwyt3qh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 19:17:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47SIeaqn010532;
	Wed, 28 Aug 2024 19:17:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41894prqt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 19:16:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ri5LCP4pK50cwAPs3Yb1o2wuA2t5bXh1C5XxPoQg9IL1+/R2fVC3mW5TpQaKfwNhL4z7spGuLbj+77nH0XAnGpfI1J+Dkhej9KXJ7m1Mg8GrDAOY1vILZn802dg4N6Fb6wZONi/jcXQvVuf1NWyaHsDxCd7/kr+PP7BaYzqcZGd7KRAhA/Zs/qufc4oid5EIXpJN2ngXHUqArNfxd0NBdrh1ZWmz+q/LRzEmKSaZMO1pvI8wH4JyvBLfk6Kq63asUcV12122GjVzzdYgWU4D5cnl7QDzT/M0D42WENFSjLpYi9bD0zlxwevHpsUewEwW6Xw1Nvo8zOK9AeAFO9zKyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRH3ayna4qFApdKLvnmTt15cw3taoNMh9Yjgyv7VLnI=;
 b=WBFdaGFYlEBMyjndNks96FRJa4QhF5dEtUWHd30yTWoPmn24NgdSO8Hvs01gf+ayWY1svyEumWI+r1M185DKbwNQZI0gJbaeNCfDBAwMOU3nFd9OUyaJaZEiS0NvlG1nFPEAMKeLBhDr7RSMkVjEB7pMtzcDvOvjVda9kX7tDO2cJdNhBAxcoTZuLklEuHegC5QSLeOcbpbcDIL0F+GuIWBZAGwemPr+W1fyT2jbcVMlhMyIGxX91xWTHLC9VAkXpVAxb2Np0u2II/aI9kknihzGcxUoZW4KRMQykQYk28KEnpPUqmigWBYX5zLfkid4sguH7v4wYdqHhx/BwX6aeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRH3ayna4qFApdKLvnmTt15cw3taoNMh9Yjgyv7VLnI=;
 b=RN/8w5pBKYLwNn1O+DpPQU6tz/5pxP617AprzZXJeuEry5ChN36RTkkdYVeV6R7cHSJaIuUjozOQhDxvEAU+CLma+/a8xmmdc8/FnejU+JREUMP+qs5S4hnDpMbcVkPOcbObDUWIm7fRMZeZ4itdU2RQIGx8yvBdzTsRNxzvEWM=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SJ0PR10MB5719.namprd10.prod.outlook.com (2603:10b6:a03:3ee::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Wed, 28 Aug
 2024 19:16:53 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.012; Wed, 28 Aug 2024
 19:16:53 +0000
Date: Wed, 28 Aug 2024 15:16:51 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 02/10] tools: add VMA merge tests
Message-ID: <ofiqfclqevjonj7r53fzqi4ivhsrbgz2kksnvqe4azqff5vzaa@thksqz2nossp>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>
References: <cover.1724441678.git.lorenzo.stoakes@oracle.com>
 <0ba339d826857ec8d7a37412464d23af84578d38.1724441678.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ba339d826857ec8d7a37412464d23af84578d38.1724441678.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0226.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::19) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SJ0PR10MB5719:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d5e8f93-7e5a-4050-1db4-08dcc795f9b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?89z30OvCfXz9aOUVuae2RH7pSCP7IB0cjQz6j3IDCF/znc1Xtjjc8UcEUbrq?=
 =?us-ascii?Q?IgmZAM4mKcZon7BVAe92cziPAG+LJRXYK3L8dBxXdgxD9drlcCDc2T5SCWBZ?=
 =?us-ascii?Q?PPF1kUUPROaFLWKENmyJk/xAx8jM/w+XhHh0Yepf9TGzfE3YVPxo1qUTRk1z?=
 =?us-ascii?Q?ZOt9FenRV43J/ik9WGAFb7OOrLYoJjQrqpSXzRzfdG5/kj3WOU8MkzRWNyw9?=
 =?us-ascii?Q?6ABuWJVtbDD8vcxD2AJx9Ly1TLZjI3KzK2ATNDFw7xgbL1zGN3VWgkztHtSD?=
 =?us-ascii?Q?AnZrcvT4c/7zmWEB0XPkI4eF61JSNSN+0g/FYyBk7pm3ghEthFjJADW5SOtu?=
 =?us-ascii?Q?uwrGUs8VdguzpA33EE1X6o1/dLZmKHOdEJpPJTfw8Fvbv21E2wV+IxtRnBUk?=
 =?us-ascii?Q?1DYAZdE7/6y507RQO8+zoi8Z1mh4HkFdoEzmpz+kd8pXz9tW94edeKC7DYnu?=
 =?us-ascii?Q?BkFH2Wh6SkFa0C0BuNWHlk7c5uEDm5azxfahQE0vyPuWDqJnn3INC+8CzTMj?=
 =?us-ascii?Q?Yu3db6qcbiW+sc1qE/Xy3VL2SbFA5TgyTIGmUw47cWldHIuVGDwBhSqAHsZV?=
 =?us-ascii?Q?eWvjOC8A7ujeNkvU+KDWXZLu+lgHTGhYQ26J20qRy757czsgKRP8re5SIjEA?=
 =?us-ascii?Q?1++MGZtFMvnBkiV/RjLvrBIjb3YWxB4YazZ0h1JaEMnD5PbZzD3JtUsqsgmc?=
 =?us-ascii?Q?r7u5G6UgxiS8SY4R8IhZ5XWB9ehRM1ttPNApHxX9KsjVsQcMU0bImQ9leFNK?=
 =?us-ascii?Q?qMDvO+3gL1mZhZIvt5sdJAnlt+Ao7Yc68i6nlwpId9AyHhH2n1emC2J7LYLu?=
 =?us-ascii?Q?ZvapjVE4O+TLGyZdrs6iGvOI9Xjh1BcXu69hlh8vZ4fLJjlT2ruaDmmfUgxb?=
 =?us-ascii?Q?FSFQyydKs+3Emp0pNWhPgEHBPwVO7G0XYsJNxgBiA59ktatJvvcobXk2lA+x?=
 =?us-ascii?Q?p8iKgycX4WX9o+WUf7gzs2D47sDPeHe0l4UrE+DWI4s8CL4IeorXZzwitDcX?=
 =?us-ascii?Q?XEzsCiXSBrjvoLf2eLZ9ZTgoUCQYiodNYf0db2gOv5nRMqDx4PGIb7BWAEe4?=
 =?us-ascii?Q?sTZvh7Kbhp6oGRppsZEZTtQ7kiCY1AFNWOkkAcCJ3Hr/XUIYlIeWqcJJLV8P?=
 =?us-ascii?Q?QMAJaO4JwWeBrZnQn21jJKsksUx9G4IdC9mcFKyYwz0Z8Ahx5+mMtIS++pzv?=
 =?us-ascii?Q?U1kR6PeixVNR4syOlBrePH0q8UMZ3Szi/qeQ17jTnes2ttrNc/mJ9CJvTipN?=
 =?us-ascii?Q?TB4kLE5ZgVFhDoJCXwAzkpsDbAlxgV1lLBdWOuUY8oorg7W/ancLgvj+f9PY?=
 =?us-ascii?Q?zo/KYjZos5hmsc9Muv/jAFw13FMHwA/Xq9T/ikIXz0C36Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xMJMAE+eCjuKEz98j8oozWjwkUrEHe0HVnGCZWVhc9sz78qOCCNGfzvGWgMT?=
 =?us-ascii?Q?8t57/pLStnQKWcRdDCBsa4trlUOxYCu+uj8sVG2EA8/2Q6FoDk2m2z6NWzWX?=
 =?us-ascii?Q?ht7RToXUIVW2TmDdGlXjZVnsZShCOGXXh3FdhlNHrT1JlLC0yqz8W2s2m0Uo?=
 =?us-ascii?Q?f1rypttP6TWF/qYSwuWl1H+moZ1zG4Cwyb3GXDpnKz7QfIQh3Ccsky4jBeUl?=
 =?us-ascii?Q?QzCAPbDi352ijJXvArsQLVFv2ge+YUsfVfrhp141sEGdwVsLE18XdNuj7Nnq?=
 =?us-ascii?Q?OujW5prYQoKeSKpMWE6ouunuMByX71MA6lcyBJPd7pgDyNUFXpAPP9K1Ly1a?=
 =?us-ascii?Q?0jhIC3/NAxrk4WKEQNzTtQj/Mq/ykn872rHyMcgxZ3Bnk6Xd3oc9tWCAfrAu?=
 =?us-ascii?Q?m53i7e1MIIxdwRBGz68uLvmyumuJ4VMehLnAO+RkzUaMfaG5G13z55VhBxBu?=
 =?us-ascii?Q?5BTSCEipAR37TuBqOrvaAVNtdxzsluSIMgNV0BdIILmuYLRxeQ4OizBkkf1u?=
 =?us-ascii?Q?AsqWTM3RoRFqP60yT4TmhHi3BCcFpH6O5HP6qpUQbeSH0EOdJSNvcRTfZaFh?=
 =?us-ascii?Q?DbO+4ZOH5d0h2PHT8CSyialNYSYJPa3A8oWyB2IwsFD5vyqalKZTCiW8RaA4?=
 =?us-ascii?Q?ZzzLyGcygIEmkFONFNRF66Jg5IJ9OWdHNYnfhUL8a5bPVZvugEc+a5kdE367?=
 =?us-ascii?Q?56HyQkxewn5OVCPw5FOd9U6453ZeZVRVf+BODL6QawfdxNWdKdiBNh6wM/A3?=
 =?us-ascii?Q?i7Wwj4xkx4Gsq2XEtfRjpVUnuNdgnSCwozQH2B9PvRRExpsu2TxjZJLvJZYJ?=
 =?us-ascii?Q?a+rFBLYpAnHyYeHppv7q3EyMZvuAY1cwOlx4yffXbLIsPi2o2s+h/YU13oI6?=
 =?us-ascii?Q?1VYOP8lSC9R0XmNyzrOL6A/suqMPJ9jEFX1krtRQJwCcJ6RtMHwEgLB4Rwqt?=
 =?us-ascii?Q?7rLCXfndJV9/caGb/rXHHZE7yEO8hcJ0ebAaJkvWQVoYiwO9xMG3H78UpfyG?=
 =?us-ascii?Q?p94jBU+ZY7Qgc7rQAC3TVn3kqF9i+NVY76BBF5KQlxKLqQTApKrj1/S/oZCj?=
 =?us-ascii?Q?4vSoU/oX3v7bWGiK9pXpgXUg0M58cahuDcBdctZ6pO91Xd7/XBPbj03qbex5?=
 =?us-ascii?Q?H9R4mHJ3MXOL93fHlJ6QkHBRQALn4qoAn7gcgzkGQz3fXxDHtJUqE2/exWot?=
 =?us-ascii?Q?eZMSyVQpkBxoIWJsuwm3zZJ5f7nB0wybe80Uc69BZJ1JWzoyM/334LXuEq/R?=
 =?us-ascii?Q?/9Zu6DFXgEJFB1SQR9X0SudA4rEohbPhTtEV705zyjMKSqMu6R/ipezuA7ey?=
 =?us-ascii?Q?y9FIKWENEMkcrrtNfF2Tg2noONCBi2DK1MhbQhKLRAEsp8++EvGClcYB7TKP?=
 =?us-ascii?Q?GHbsCF+RIgq/WYHIkzy+HHfZT+rpWDGlUBFQzh95P0keKpSxA6ZMXFAI/1qx?=
 =?us-ascii?Q?qsD4dt9ODOvseau6AxfJMBAAitO3EWDyKURbKgQfhXjnI/QhotrzdLZrmyOw?=
 =?us-ascii?Q?zb+Ga1jx/DGwdl1q+PUVYIAgx/o3kqrtrFNoL57EjoKPhGBoN6YpnQaYr6vc?=
 =?us-ascii?Q?Vp3dBbiJsjSOI/EHsz58IlpjV6py4SYwm/d9iDjP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9yRL+ZbxMn1NROKIpHwSwgtjOktEXE3L9pjNzfo1RMdA5/Nu889NW6hvqgnkWfzIRcJP0uY7UtVDiyABdPgRiCABXSO5X/l/+j6TEDAEV5eteovZN3H4E4cwsy2PklDYO7hY1LaPcTeLngt1StgxbQqKihJmBm9JEx8lpJthDD8aJnOL8iLvM5JvP1k2GBzFoMveftLNPC0oTOcs1dSSjQFm7F3Tr6jaC85Esnl6Q4CeCroIbSxOFPYSpAgTopri18Tg8Fz3xDmffjchO6YVb3uptG+lgPRSX7Rz4117JZCNFSz49ZH8hyl+m4LZWVqAb7jEF+K2mV/o+GoJgLxM10dvUYAlxZeSkRdrYyMJ8dnFDcln4FbCoMC122iJpkUYaEsoB3PxccBvK6ij++jxcFww9kAabP70LC/PAdCdIDwNf+b+iVIBK2Rh3r0JQoMBRIHgxeQoInBCLDamchkjvowjk6ymE4FyyKY7z7TjCVkJQWm8clUg3Ih4lhDH00PSmlzDwlm8Kr8b0EytCTSkc4p3wrzRjduYdtR+lhPRp3yQuV78qY3VzFoMitE11sWf7l+DlqbNjM3392whS/3mk4s21Gdd1H0qbNnd0ehWluA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5e8f93-7e5a-4050-1db4-08dcc795f9b9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 19:16:53.5220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4oBszE5qcAfCAwxEqa7lvn9CflX7CXAQy1ZkSbdU8zlFFG9HVwp5JBnwXnuxhAdVGD5DXNwvSuSKQtpA5bd6Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_08,2024-08-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408280140
X-Proofpoint-ORIG-GUID: x3CKvEpy4mPGjqbtv-EpFtuBLYHW8MYW
X-Proofpoint-GUID: x3CKvEpy4mPGjqbtv-EpFtuBLYHW8MYW

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240823 16:07]:
> Add a variety of VMA merge unit tests to assert that the behaviour of VMA
> merge is correct at an abstract level and VMAs are merged or not merged as
> expected.
> 
> These are intentionally added _before_ we start refactoring vma_merge() in
> order that we can continually assert correctness throughout the rest of the
> series.
> 
> In order to reduce churn going forward, we backport the vma_merge_struct
> data type to the test code which we introduce and use in a future commit,
> and add wrappers around the merge new and existing VMA cases.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  tools/testing/vma/vma.c          | 1218 +++++++++++++++++++++++++++++-
>  tools/testing/vma/vma_internal.h |   45 +-
>  2 files changed, 1253 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
> index 48e033c60d87..9b272633ca9e 100644
> --- a/tools/testing/vma/vma.c
> +++ b/tools/testing/vma/vma.c
> @@ -7,13 +7,43 @@
>  #include "maple-shared.h"
>  #include "vma_internal.h"
>  
> +/* Include so header guard set. */
> +#include "../../../mm/vma.h"
> +
> +static bool fail_prealloc;
> +
> +/* Then override vma_iter_prealloc() so we can choose to fail it. */
> +#define vma_iter_prealloc(vmi, vma)					\
> +	(fail_prealloc ? -ENOMEM : mas_preallocate(&(vmi)->mas, (vma), GFP_KERNEL))
> +
>  /*
>   * Directly import the VMA implementation here. Our vma_internal.h wrapper
>   * provides userland-equivalent functionality for everything vma.c uses.
>   */
>  #include "../../../mm/vma.c"
>  
> +/*
> + * Temporarily forward-ported from a future in which vmg's are used for merging.
> + */
> +struct vma_merge_struct {
> +	struct mm_struct *mm;
> +	struct vma_iterator *vmi;
> +	pgoff_t pgoff;
> +	struct vm_area_struct *prev;
> +	struct vm_area_struct *next; /* Modified by vma_merge(). */
> +	struct vm_area_struct *vma; /* Either a new VMA or the one being modified. */
> +	unsigned long start;
> +	unsigned long end;
> +	unsigned long flags;
> +	struct file *file;
> +	struct anon_vma *anon_vma;
> +	struct mempolicy *policy;
> +	struct vm_userfaultfd_ctx uffd_ctx;
> +	struct anon_vma_name *anon_name;
> +};
> +
>  const struct vm_operations_struct vma_dummy_vm_ops;
> +static struct anon_vma dummy_anon_vma;
>  
>  #define ASSERT_TRUE(_expr)						\
>  	do {								\
> @@ -28,6 +58,14 @@ const struct vm_operations_struct vma_dummy_vm_ops;
>  #define ASSERT_EQ(_val1, _val2) ASSERT_TRUE((_val1) == (_val2))
>  #define ASSERT_NE(_val1, _val2) ASSERT_TRUE((_val1) != (_val2))
>  
> +static struct task_struct __current;
> +
> +struct task_struct *get_current(void)
> +{
> +	return &__current;
> +}
> +
> +/* Helper function to simply allocate a VMA. */
>  static struct vm_area_struct *alloc_vma(struct mm_struct *mm,
>  					unsigned long start,
>  					unsigned long end,
> @@ -47,22 +85,201 @@ static struct vm_area_struct *alloc_vma(struct mm_struct *mm,
>  	return ret;
>  }
>  
> +/* Helper function to allocate a VMA and link it to the tree. */
> +static struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
> +						 unsigned long start,
> +						 unsigned long end,
> +						 pgoff_t pgoff,
> +						 vm_flags_t flags)
> +{
> +	struct vm_area_struct *vma = alloc_vma(mm, start, end, pgoff, flags);
> +
> +	if (vma == NULL)
> +		return NULL;
> +
> +	if (vma_link(mm, vma)) {
> +		vm_area_free(vma);
> +		return NULL;
> +	}
> +
> +	/*
> +	 * Reset this counter which we use to track whether writes have
> +	 * begun. Linking to the tree will have caused this to be incremented,
> +	 * which means we will get a false positive otherwise.
> +	 */
> +	vma->vm_lock_seq = -1;
> +
> +	return vma;
> +}
> +
> +/* Helper function which provides a wrapper around a merge new VMA operation. */
> +static struct vm_area_struct *merge_new(struct vma_merge_struct *vmg)
> +{
> +	/* vma_merge() needs a VMA to determine mm, anon_vma, and file. */
> +	struct vm_area_struct dummy = {
> +		.vm_mm = vmg->mm,
> +		.vm_flags = vmg->flags,
> +		.anon_vma = vmg->anon_vma,
> +		.vm_file = vmg->file,
> +	};
> +
> +	/*
> +	 * For convenience, get prev and next VMAs. Which the new VMA operation
> +	 * requires.
> +	 */
> +	vmg->next = vma_next(vmg->vmi);
> +	vmg->prev = vma_prev(vmg->vmi);
> +
> +	vma_iter_set(vmg->vmi, vmg->start);
> +	return vma_merge_new_vma(vmg->vmi, vmg->prev, &dummy, vmg->start,
> +				 vmg->end, vmg->pgoff);
> +}
> +
> +/*
> + * Helper function which provides a wrapper around a merge existing VMA
> + * operation.
> + */
> +static struct vm_area_struct *merge_existing(struct vma_merge_struct *vmg)
> +{
> +	/* vma_merge() needs a VMA to determine mm, anon_vma, and file. */
> +	struct vm_area_struct dummy = {
> +		.vm_mm = vmg->mm,
> +		.vm_flags = vmg->flags,
> +		.anon_vma = vmg->anon_vma,
> +		.vm_file = vmg->file,
> +	};
> +
> +	return vma_merge(vmg->vmi, vmg->prev, &dummy, vmg->start, vmg->end,
> +			 vmg->flags, vmg->pgoff, vmg->policy, vmg->uffd_ctx,
> +			 vmg->anon_name);
> +}
> +
> +/*
> + * Helper function which provides a wrapper around the expansion of an existing
> + * VMA.
> + */
> +static int expand_existing(struct vma_merge_struct *vmg)
> +{
> +	return vma_expand(vmg->vmi, vmg->vma, vmg->start, vmg->end, vmg->pgoff,
> +			  vmg->next);
> +}
> +
> +/*
> + * Helper function to reset merge state the associated VMA iterator to a
> + * specified new range.
> + */
> +static void vmg_set_range(struct vma_merge_struct *vmg, unsigned long start,
> +			  unsigned long end, pgoff_t pgoff, vm_flags_t flags)
> +{
> +	vma_iter_set(vmg->vmi, start);
> +
> +	vmg->prev = NULL;
> +	vmg->next = NULL;
> +	vmg->vma = NULL;
> +
> +	vmg->start = start;
> +	vmg->end = end;
> +	vmg->pgoff = pgoff;
> +	vmg->flags = flags;
> +}
> +
> +/*
> + * Helper function to try to merge a new VMA.
> + *
> + * Update vmg and the iterator for it and try to merge, otherwise allocate a new
> + * VMA, link it to the maple tree and return it.
> + */
> +static struct vm_area_struct *try_merge_new_vma(struct mm_struct *mm,
> +						struct vma_merge_struct *vmg,
> +						unsigned long start, unsigned long end,
> +						pgoff_t pgoff, vm_flags_t flags,
> +						bool *was_merged)
> +{
> +	struct vm_area_struct *merged;
> +
> +	vmg_set_range(vmg, start, end, pgoff, flags);
> +
> +	merged = merge_new(vmg);
> +	if (merged) {
> +		*was_merged = true;
> +		return merged;
> +	}
> +
> +	*was_merged = false;
> +	return alloc_and_link_vma(mm, start, end, pgoff, flags);
> +}
> +
> +/*
> + * Helper function to reset the dummy anon_vma to indicate it has not been
> + * duplicated.
> + */
> +static void reset_dummy_anon_vma(void)
> +{
> +	dummy_anon_vma.was_cloned = false;
> +	dummy_anon_vma.was_unlinked = false;
> +}
> +
> +/*
> + * Helper function to remove all VMAs and destroy the maple tree associated with
> + * a virtual address space. Returns a count of VMAs in the tree.
> + */
> +static int cleanup_mm(struct mm_struct *mm, struct vma_iterator *vmi)
> +{
> +	struct vm_area_struct *vma;
> +	int count = 0;
> +
> +	fail_prealloc = false;
> +	reset_dummy_anon_vma();
> +
> +	vma_iter_set(vmi, 0);
> +	for_each_vma(*vmi, vma) {
> +		vm_area_free(vma);
> +		count++;
> +	}
> +
> +	mtree_destroy(&mm->mm_mt);
> +	mm->map_count = 0;
> +	return count;
> +}
> +
> +/* Helper function to determine if VMA has had vma_start_write() performed. */
> +static bool vma_write_started(struct vm_area_struct *vma)
> +{
> +	int seq = vma->vm_lock_seq;
> +
> +	/* We reset after each check. */
> +	vma->vm_lock_seq = -1;
> +
> +	/* The vma_start_write() stub simply increments this value. */
> +	return seq > -1;
> +}
> +
> +/* Helper function providing a dummy vm_ops->close() method.*/
> +static void dummy_close(struct vm_area_struct *)
> +{
> +}
> +
>  static bool test_simple_merge(void)
>  {
>  	struct vm_area_struct *vma;
>  	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
>  	struct mm_struct mm = {};
>  	struct vm_area_struct *vma_left = alloc_vma(&mm, 0, 0x1000, 0, flags);
> -	struct vm_area_struct *vma_middle = alloc_vma(&mm, 0x1000, 0x2000, 1, flags);
>  	struct vm_area_struct *vma_right = alloc_vma(&mm, 0x2000, 0x3000, 2, flags);
>  	VMA_ITERATOR(vmi, &mm, 0x1000);
> +	struct vma_merge_struct vmg = {
> +		.mm = &mm,
> +		.vmi = &vmi,
> +		.start = 0x1000,
> +		.end = 0x2000,
> +		.flags = flags,
> +		.pgoff = 1,
> +	};
>  
>  	ASSERT_FALSE(vma_link(&mm, vma_left));
> -	ASSERT_FALSE(vma_link(&mm, vma_middle));
>  	ASSERT_FALSE(vma_link(&mm, vma_right));
>  
> -	vma = vma_merge_new_vma(&vmi, vma_left, vma_middle, 0x1000,
> -				0x2000, 1);
> +	vma = merge_new(&vmg);
>  	ASSERT_NE(vma, NULL);
>  
>  	ASSERT_EQ(vma->vm_start, 0);
> @@ -142,10 +359,17 @@ static bool test_simple_expand(void)
>  	struct mm_struct mm = {};
>  	struct vm_area_struct *vma = alloc_vma(&mm, 0, 0x1000, 0, flags);
>  	VMA_ITERATOR(vmi, &mm, 0);
> +	struct vma_merge_struct vmg = {
> +		.vmi = &vmi,
> +		.vma = vma,
> +		.start = 0,
> +		.end = 0x3000,
> +		.pgoff = 0,
> +	};
>  
>  	ASSERT_FALSE(vma_link(&mm, vma));
>  
> -	ASSERT_FALSE(vma_expand(&vmi, vma, 0, 0x3000, 0, NULL));
> +	ASSERT_FALSE(expand_existing(&vmg));
>  
>  	ASSERT_EQ(vma->vm_start, 0);
>  	ASSERT_EQ(vma->vm_end, 0x3000);
> @@ -178,6 +402,980 @@ static bool test_simple_shrink(void)
>  	return true;
>  }
>  
> +static bool test_merge_new(void)
> +{
> +	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
> +	struct mm_struct mm = {};
> +	VMA_ITERATOR(vmi, &mm, 0);
> +	struct vma_merge_struct vmg = {
> +		.mm = &mm,
> +		.vmi = &vmi,
> +	};
> +	struct anon_vma_chain dummy_anon_vma_chain_a = {
> +		.anon_vma = &dummy_anon_vma,
> +	};
> +	struct anon_vma_chain dummy_anon_vma_chain_b = {
> +		.anon_vma = &dummy_anon_vma,
> +	};
> +	struct anon_vma_chain dummy_anon_vma_chain_c = {
> +		.anon_vma = &dummy_anon_vma,
> +	};
> +	struct anon_vma_chain dummy_anon_vma_chain_d = {
> +		.anon_vma = &dummy_anon_vma,
> +	};
> +	int count;
> +	struct vm_area_struct *vma, *vma_a, *vma_b, *vma_c, *vma_d;
> +	bool merged;
> +
> +	/*
> +	 * 0123456789abc
> +	 * AA B       CC
> +	 */
> +	vma_a = alloc_and_link_vma(&mm, 0, 0x2000, 0, flags);
> +	ASSERT_NE(vma_a, NULL);
> +	/* We give each VMA a single avc so we can test anon_vma duplication. */
> +	INIT_LIST_HEAD(&vma_a->anon_vma_chain);
> +	list_add(&dummy_anon_vma_chain_a.same_vma, &vma_a->anon_vma_chain);
> +
> +	vma_b = alloc_and_link_vma(&mm, 0x3000, 0x4000, 3, flags);
> +	ASSERT_NE(vma_b, NULL);
> +	INIT_LIST_HEAD(&vma_b->anon_vma_chain);
> +	list_add(&dummy_anon_vma_chain_b.same_vma, &vma_b->anon_vma_chain);
> +
> +	vma_c = alloc_and_link_vma(&mm, 0xb000, 0xc000, 0xb, flags);
> +	ASSERT_NE(vma_c, NULL);
> +	INIT_LIST_HEAD(&vma_c->anon_vma_chain);
> +	list_add(&dummy_anon_vma_chain_c.same_vma, &vma_c->anon_vma_chain);
> +
> +	/*
> +	 * NO merge.
> +	 *
> +	 * 0123456789abc
> +	 * AA B   **  CC
> +	 */
> +	vma_d = try_merge_new_vma(&mm, &vmg, 0x7000, 0x9000, 7, flags, &merged);
> +	ASSERT_NE(vma_d, NULL);
> +	INIT_LIST_HEAD(&vma_d->anon_vma_chain);
> +	list_add(&dummy_anon_vma_chain_d.same_vma, &vma_d->anon_vma_chain);
> +	ASSERT_FALSE(merged);
> +	ASSERT_EQ(mm.map_count, 4);
> +
> +	/*
> +	 * Merge BOTH sides.
> +	 *
> +	 * 0123456789abc
> +	 * AA*B   DD  CC
> +	 */
> +	vma_b->anon_vma = &dummy_anon_vma;
> +	vma = try_merge_new_vma(&mm, &vmg, 0x2000, 0x3000, 2, flags, &merged);
> +	ASSERT_EQ(vma, vma_a);
> +	/* Merge with A, delete B. */
> +	ASSERT_TRUE(merged);
> +	ASSERT_EQ(vma->vm_start, 0);
> +	ASSERT_EQ(vma->vm_end, 0x4000);
> +	ASSERT_EQ(vma->vm_pgoff, 0);
> +	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
> +	ASSERT_TRUE(vma_write_started(vma));
> +	ASSERT_EQ(mm.map_count, 3);
> +
> +	/*
> +	 * Merge to PREVIOUS VMA.
> +	 *
> +	 * 0123456789abc
> +	 * AAAA*  DD  CC
> +	 */
> +	vma = try_merge_new_vma(&mm, &vmg, 0x4000, 0x5000, 4, flags, &merged);
> +	ASSERT_EQ(vma, vma_a);
> +	/* Extend A. */
> +	ASSERT_TRUE(merged);
> +	ASSERT_EQ(vma->vm_start, 0);
> +	ASSERT_EQ(vma->vm_end, 0x5000);
> +	ASSERT_EQ(vma->vm_pgoff, 0);
> +	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
> +	ASSERT_TRUE(vma_write_started(vma));
> +	ASSERT_EQ(mm.map_count, 3);
> +
> +	/*
> +	 * Merge to NEXT VMA.
> +	 *
> +	 * 0123456789abc
> +	 * AAAAA *DD  CC
> +	 */
> +	vma_d->anon_vma = &dummy_anon_vma;
> +	vma = try_merge_new_vma(&mm, &vmg, 0x6000, 0x7000, 6, flags, &merged);
> +	ASSERT_EQ(vma, vma_d);
> +	/* Prepend. */
> +	ASSERT_TRUE(merged);
> +	ASSERT_EQ(vma->vm_start, 0x6000);
> +	ASSERT_EQ(vma->vm_end, 0x9000);
> +	ASSERT_EQ(vma->vm_pgoff, 6);
> +	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
> +	ASSERT_TRUE(vma_write_started(vma));
> +	ASSERT_EQ(mm.map_count, 3);
> +
> +	/*
> +	 * Merge BOTH sides.
> +	 *
> +	 * 0123456789abc
> +	 * AAAAA*DDD  CC
> +	 */
> +	vma = try_merge_new_vma(&mm, &vmg, 0x5000, 0x6000, 5, flags, &merged);
> +	ASSERT_EQ(vma, vma_a);
> +	/* Merge with A, delete D. */
> +	ASSERT_TRUE(merged);
> +	ASSERT_EQ(vma->vm_start, 0);
> +	ASSERT_EQ(vma->vm_end, 0x9000);
> +	ASSERT_EQ(vma->vm_pgoff, 0);
> +	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
> +	ASSERT_TRUE(vma_write_started(vma));
> +	ASSERT_EQ(mm.map_count, 2);
> +
> +	/*
> +	 * Merge to NEXT VMA.
> +	 *
> +	 * 0123456789abc
> +	 * AAAAAAAAA *CC
> +	 */
> +	vma_c->anon_vma = &dummy_anon_vma;
> +	vma = try_merge_new_vma(&mm, &vmg, 0xa000, 0xb000, 0xa, flags, &merged);
> +	ASSERT_EQ(vma, vma_c);
> +	/* Prepend C. */
> +	ASSERT_TRUE(merged);
> +	ASSERT_EQ(vma->vm_start, 0xa000);
> +	ASSERT_EQ(vma->vm_end, 0xc000);
> +	ASSERT_EQ(vma->vm_pgoff, 0xa);
> +	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
> +	ASSERT_TRUE(vma_write_started(vma));
> +	ASSERT_EQ(mm.map_count, 2);
> +
> +	/*
> +	 * Merge BOTH sides.
> +	 *
> +	 * 0123456789abc
> +	 * AAAAAAAAA*CCC
> +	 */
> +	vma = try_merge_new_vma(&mm, &vmg, 0x9000, 0xa000, 0x9, flags, &merged);
> +	ASSERT_EQ(vma, vma_a);
> +	/* Extend A and delete C. */
> +	ASSERT_TRUE(merged);
> +	ASSERT_EQ(vma->vm_start, 0);
> +	ASSERT_EQ(vma->vm_end, 0xc000);
> +	ASSERT_EQ(vma->vm_pgoff, 0);
> +	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
> +	ASSERT_TRUE(vma_write_started(vma));
> +	ASSERT_EQ(mm.map_count, 1);
> +
> +	/*
> +	 * Final state.
> +	 *
> +	 * 0123456789abc
> +	 * AAAAAAAAAAAAA
> +	 */
> +
> +	count = 0;
> +	vma_iter_set(&vmi, 0);
> +	for_each_vma(vmi, vma) {
> +		ASSERT_NE(vma, NULL);
> +		ASSERT_EQ(vma->vm_start, 0);
> +		ASSERT_EQ(vma->vm_end, 0xc000);
> +		ASSERT_EQ(vma->vm_pgoff, 0);
> +		ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
> +
> +		vm_area_free(vma);
> +		count++;
> +	}
> +
> +	/* Should only have one VMA left (though freed) after all is done.*/
> +	ASSERT_EQ(count, 1);
> +
> +	mtree_destroy(&mm.mm_mt);
> +	return true;
> +}
> +
> +static bool test_vma_merge_special_flags(void)
> +{
> +	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
> +	struct mm_struct mm = {};
> +	VMA_ITERATOR(vmi, &mm, 0);
> +	struct vma_merge_struct vmg = {
> +		.mm = &mm,
> +		.vmi = &vmi,
> +	};
> +	vm_flags_t special_flags[] = { VM_IO, VM_DONTEXPAND, VM_PFNMAP, VM_MIXEDMAP };
> +	vm_flags_t all_special_flags = 0;
> +	int i;
> +	struct vm_area_struct *vma_left, *vma;
> +
> +	/* Make sure there aren't new VM_SPECIAL flags. */
> +	for (i = 0; i < ARRAY_SIZE(special_flags); i++) {
> +		all_special_flags |= special_flags[i];
> +	}
> +	ASSERT_EQ(all_special_flags, VM_SPECIAL);
> +
> +	/*
> +	 * 01234
> +	 * AAA
> +	 */
> +	vma_left = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
> +	ASSERT_NE(vma_left, NULL);
> +
> +	/* 1. Set up new VMA with special flag that would otherwise merge. */
> +
> +	/*
> +	 * 01234
> +	 * AAA*
> +	 *
> +	 * This should merge if not for the VM_SPECIAL flag.
> +	 */
> +	vmg_set_range(&vmg, 0x3000, 0x4000, 3, flags);
> +	for (i = 0; i < ARRAY_SIZE(special_flags); i++) {
> +		vm_flags_t special_flag = special_flags[i];
> +
> +		vma_left->__vm_flags = flags | special_flag;
> +		vmg.flags = flags | special_flag;
> +		vma = merge_new(&vmg);
> +		ASSERT_EQ(vma, NULL);
> +	}
> +
> +	/* 2. Modify VMA with special flag that would otherwise merge. */
> +
> +	/*
> +	 * 01234
> +	 * AAAB
> +	 *
> +	 * Create a VMA to modify.
> +	 */
> +	vma = alloc_and_link_vma(&mm, 0x3000, 0x4000, 3, flags);
> +	ASSERT_NE(vma, NULL);
> +	vmg.vma = vma;
> +
> +	for (i = 0; i < ARRAY_SIZE(special_flags); i++) {
> +		vm_flags_t special_flag = special_flags[i];
> +
> +		vma_left->__vm_flags = flags | special_flag;
> +		vmg.flags = flags | special_flag;
> +		vma = merge_existing(&vmg);
> +		ASSERT_EQ(vma, NULL);
> +	}
> +
> +	cleanup_mm(&mm, &vmi);
> +	return true;
> +}
> +
> +static bool test_vma_merge_with_close(void)
> +{
> +	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
> +	struct mm_struct mm = {};
> +	VMA_ITERATOR(vmi, &mm, 0);
> +	struct vma_merge_struct vmg = {
> +		.mm = &mm,
> +		.vmi = &vmi,
> +	};
> +	const struct vm_operations_struct vm_ops = {
> +		.close = dummy_close,
> +	};
> +	struct vm_area_struct *vma_next =
> +		alloc_and_link_vma(&mm, 0x2000, 0x3000, 2, flags);
> +	struct vm_area_struct *vma;
> +
> +	/*
> +	 * When we merge VMAs we sometimes have to delete others as part of the
> +	 * operation.
> +	 *
> +	 * Considering the two possible adjacent VMAs to which a VMA can be
> +	 * merged:
> +	 *
> +	 * [ prev ][ vma ][ next ]
> +	 *
> +	 * In no case will we need to delete prev. If the operation is
> +	 * mergeable, then prev will be extended with one or both of vma and
> +	 * next deleted.
> +	 *
> +	 * As a result, during initial mergeability checks, only
> +	 * can_vma_merge_before() (which implies the VMA being merged with is
> +	 * 'next' as shown above) bothers to check to see whether the next VMA
> +	 * has a vm_ops->close() callback that will need to be called when
> +	 * removed.
> +	 *
> +	 * If it does, then we cannot merge as the resources that the close()
> +	 * operation potentially clears down are tied only to the existing VMA
> +	 * range and we have no way of extending those to the nearly merged one.
> +	 *
> +	 * We must consider two scenarios:
> +	 *
> +	 * A.
> +	 *
> +	 * vm_ops->close:     -       -    !NULL
> +	 *                 [ prev ][ vma ][ next ]
> +	 *
> +	 * Where prev may or may not be present/mergeable.
> +	 *
> +	 * This is picked up by a specific check in can_vma_merge_before().
> +	 *
> +	 * B.
> +	 *
> +	 * vm_ops->close:     -     !NULL
> +	 *                 [ prev ][ vma ]
> +	 *
> +	 * Where prev and vma are present and mergeable.
> +	 *
> +	 * This is picked up by a specific check in the modified VMA merge.
> +	 *
> +	 * IMPORTANT NOTE: We make the assumption that the following case:
> +	 *
> +	 *    -     !NULL   NULL
> +	 * [ prev ][ vma ][ next ]
> +	 *
> +	 * Cannot occur, because vma->vm_ops being the same implies the same
> +	 * vma->vm_file, and therefore this would mean that next->vm_ops->close
> +	 * would be set too, and thus scenario A would pick this up.
> +	 */
> +
> +	ASSERT_NE(vma_next, NULL);
> +
> +	/*
> +	 * SCENARIO A
> +	 *
> +	 * 0123
> +	 *  *N
> +	 */
> +
> +	/* Make the next VMA have a close() callback. */
> +	vma_next->vm_ops = &vm_ops;
> +
> +	/* Our proposed VMA has characteristics that would otherwise be merged. */
> +	vmg_set_range(&vmg, 0x1000, 0x2000, 1, flags);
> +
> +	/* The next VMA having a close() operator should cause the merge to fail.*/
> +	ASSERT_EQ(merge_new(&vmg), NULL);
> +
> +	/* Now create the VMA so we can merge via modified flags */
> +	vmg_set_range(&vmg, 0x1000, 0x2000, 1, flags);
> +	vma = alloc_and_link_vma(&mm, 0x1000, 0x2000, 1, flags);
> +	vmg.vma = vma;
> +
> +	/*
> +	 * The VMA being modified in a way that would otherwise merge should
> +	 * also fail.
> +	 */
> +	ASSERT_EQ(merge_existing(&vmg), NULL);
> +
> +	/* SCENARIO B
> +	 *
> +	 * 0123
> +	 * P*
> +	 *
> +	 * In order for this scenario to trigger, the VMA currently being
> +	 * modified must also have a .close().
> +	 */
> +
> +	/* Reset VMG state. */
> +	vmg_set_range(&vmg, 0x1000, 0x2000, 1, flags);
> +	/*
> +	 * Make next unmergeable, and don't let the scenario A check pick this
> +	 * up, we want to reproduce scenario B only.
> +	 */
> +	vma_next->vm_ops = NULL;
> +	vma_next->__vm_flags &= ~VM_MAYWRITE;
> +	/* Allocate prev. */
> +	vmg.prev = alloc_and_link_vma(&mm, 0, 0x1000, 0, flags);
> +	/* Assign a vm_ops->close() function to VMA explicitly. */
> +	vma->vm_ops = &vm_ops;
> +	vmg.vma = vma;
> +	/* Make sure merge does not occur. */
> +	ASSERT_EQ(merge_existing(&vmg), NULL);
> +
> +	cleanup_mm(&mm, &vmi);
> +	return true;
> +}
> +
> +static bool test_vma_merge_new_with_close(void)
> +{
> +	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
> +	struct mm_struct mm = {};
> +	VMA_ITERATOR(vmi, &mm, 0);
> +	struct vma_merge_struct vmg = {
> +		.mm = &mm,
> +		.vmi = &vmi,
> +	};
> +	struct vm_area_struct *vma_prev = alloc_and_link_vma(&mm, 0, 0x2000, 0, flags);
> +	struct vm_area_struct *vma_next = alloc_and_link_vma(&mm, 0x5000, 0x7000, 5, flags);
> +	const struct vm_operations_struct vm_ops = {
> +		.close = dummy_close,
> +	};
> +	struct vm_area_struct *vma;
> +
> +	/*
> +	 * We should allow the partial merge of a proposed new VMA if the
> +	 * surrounding VMAs have vm_ops->close() hooks (but are otherwise
> +	 * compatible), e.g.:
> +	 *
> +	 *        New VMA
> +	 *    A  v-------v  B
> +	 * |-----|       |-----|
> +	 *  close         close
> +	 *
> +	 * Since the rule is to not DELETE a VMA with a close operation, this
> +	 * should be permitted, only rather than expanding A and deleting B, we
> +	 * should simply expand A and leave B intact, e.g.:
> +	 *
> +	 *        New VMA
> +	 *       A          B
> +	 * |------------||-----|
> +	 *  close         close
> +	 */
> +
> +	/* Have prev and next have a vm_ops->close() hook. */
> +	vma_prev->vm_ops = &vm_ops;
> +	vma_next->vm_ops = &vm_ops;
> +
> +	vmg_set_range(&vmg, 0x2000, 0x5000, 2, flags);
> +	vma = merge_new(&vmg);
> +	ASSERT_NE(vma, NULL);
> +	ASSERT_EQ(vma->vm_start, 0);
> +	ASSERT_EQ(vma->vm_end, 0x5000);
> +	ASSERT_EQ(vma->vm_pgoff, 0);
> +	ASSERT_EQ(vma->vm_ops, &vm_ops);
> +	ASSERT_TRUE(vma_write_started(vma));
> +	ASSERT_EQ(mm.map_count, 2);
> +
> +	cleanup_mm(&mm, &vmi);
> +	return true;
> +}
> +
> +static bool test_merge_existing(void)
> +{
> +	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
> +	struct mm_struct mm = {};
> +	VMA_ITERATOR(vmi, &mm, 0);
> +	struct vm_area_struct *vma, *vma_prev, *vma_next;
> +	struct vma_merge_struct vmg = {
> +		.mm = &mm,
> +		.vmi = &vmi,
> +	};
> +
> +	/*
> +	 * Merge right case - partial span.
> +	 *
> +	 *    <->
> +	 * 0123456789
> +	 *   VVVVNNN
> +	 *            ->
> +	 * 0123456789
> +	 *   VNNNNNN
> +	 */
> +	vma = alloc_and_link_vma(&mm, 0x2000, 0x6000, 2, flags);
> +	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, flags);
> +	vmg_set_range(&vmg, 0x3000, 0x6000, 3, flags);
> +	vmg.vma = vma;
> +	vmg.prev = vma;
> +	vma->anon_vma = &dummy_anon_vma;
> +	ASSERT_EQ(merge_existing(&vmg), vma_next);
> +	ASSERT_EQ(vma_next->vm_start, 0x3000);
> +	ASSERT_EQ(vma_next->vm_end, 0x9000);
> +	ASSERT_EQ(vma_next->vm_pgoff, 3);
> +	ASSERT_EQ(vma_next->anon_vma, &dummy_anon_vma);
> +	ASSERT_EQ(vma->vm_start, 0x2000);
> +	ASSERT_EQ(vma->vm_end, 0x3000);
> +	ASSERT_EQ(vma->vm_pgoff, 2);
> +	ASSERT_TRUE(vma_write_started(vma));
> +	ASSERT_TRUE(vma_write_started(vma_next));
> +	ASSERT_EQ(mm.map_count, 2);
> +
> +	/* Clear down and reset. */
> +	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
> +
> +	/*
> +	 * Merge right case - full span.
> +	 *
> +	 *   <-->
> +	 * 0123456789
> +	 *   VVVVNNN
> +	 *            ->
> +	 * 0123456789
> +	 *   NNNNNNN
> +	 */
> +	vma = alloc_and_link_vma(&mm, 0x2000, 0x6000, 2, flags);
> +	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, flags);
> +	vmg_set_range(&vmg, 0x2000, 0x6000, 2, flags);
> +	vmg.vma = vma;
> +	vma->anon_vma = &dummy_anon_vma;
> +	ASSERT_EQ(merge_existing(&vmg), vma_next);
> +	ASSERT_EQ(vma_next->vm_start, 0x2000);
> +	ASSERT_EQ(vma_next->vm_end, 0x9000);
> +	ASSERT_EQ(vma_next->vm_pgoff, 2);
> +	ASSERT_EQ(vma_next->anon_vma, &dummy_anon_vma);
> +	ASSERT_TRUE(vma_write_started(vma_next));
> +	ASSERT_EQ(mm.map_count, 1);
> +
> +	/* Clear down and reset. We should have deleted vma. */
> +	ASSERT_EQ(cleanup_mm(&mm, &vmi), 1);
> +
> +	/*
> +	 * Merge left case - partial span.
> +	 *
> +	 *    <->
> +	 * 0123456789
> +	 * PPPVVVV
> +	 *            ->
> +	 * 0123456789
> +	 * PPPPPPV
> +	 */
> +	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
> +	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, flags);
> +	vmg_set_range(&vmg, 0x3000, 0x6000, 3, flags);
> +	vmg.prev = vma_prev;
> +	vmg.vma = vma;
> +	vma->anon_vma = &dummy_anon_vma;
> +
> +	ASSERT_EQ(merge_existing(&vmg), vma_prev);
> +	ASSERT_EQ(vma_prev->vm_start, 0);
> +	ASSERT_EQ(vma_prev->vm_end, 0x6000);
> +	ASSERT_EQ(vma_prev->vm_pgoff, 0);
> +	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
> +	ASSERT_EQ(vma->vm_start, 0x6000);
> +	ASSERT_EQ(vma->vm_end, 0x7000);
> +	ASSERT_EQ(vma->vm_pgoff, 6);
> +	ASSERT_TRUE(vma_write_started(vma_prev));
> +	ASSERT_TRUE(vma_write_started(vma));
> +	ASSERT_EQ(mm.map_count, 2);
> +
> +	/* Clear down and reset. */
> +	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
> +
> +	/*
> +	 * Merge left case - full span.
> +	 *
> +	 *    <-->
> +	 * 0123456789
> +	 * PPPVVVV
> +	 *            ->
> +	 * 0123456789
> +	 * PPPPPPP
> +	 */
> +	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
> +	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, flags);
> +	vmg_set_range(&vmg, 0x3000, 0x7000, 3, flags);
> +	vmg.prev = vma_prev;
> +	vmg.vma = vma;
> +	vma->anon_vma = &dummy_anon_vma;
> +	ASSERT_EQ(merge_existing(&vmg), vma_prev);
> +	ASSERT_EQ(vma_prev->vm_start, 0);
> +	ASSERT_EQ(vma_prev->vm_end, 0x7000);
> +	ASSERT_EQ(vma_prev->vm_pgoff, 0);
> +	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
> +	ASSERT_TRUE(vma_write_started(vma_prev));
> +	ASSERT_EQ(mm.map_count, 1);
> +
> +	/* Clear down and reset. We should have deleted vma. */
> +	ASSERT_EQ(cleanup_mm(&mm, &vmi), 1);
> +
> +	/*
> +	 * Merge both case.
> +	 *
> +	 *    <-->
> +	 * 0123456789
> +	 * PPPVVVVNNN
> +	 *             ->
> +	 * 0123456789
> +	 * PPPPPPPPPP
> +	 */
> +	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
> +	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, flags);
> +	vma_next = alloc_and_link_vma(&mm, 0x7000, 0x9000, 7, flags);
> +	vmg_set_range(&vmg, 0x3000, 0x7000, 3, flags);
> +	vmg.prev = vma_prev;
> +	vmg.vma = vma;
> +	vma->anon_vma = &dummy_anon_vma;
> +	ASSERT_EQ(merge_existing(&vmg), vma_prev);
> +	ASSERT_EQ(vma_prev->vm_start, 0);
> +	ASSERT_EQ(vma_prev->vm_end, 0x9000);
> +	ASSERT_EQ(vma_prev->vm_pgoff, 0);
> +	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
> +	ASSERT_TRUE(vma_write_started(vma_prev));
> +	ASSERT_EQ(mm.map_count, 1);
> +
> +	/* Clear down and reset. We should have deleted prev and next. */
> +	ASSERT_EQ(cleanup_mm(&mm, &vmi), 1);
> +
> +	/*
> +	 * Non-merge ranges. the modified VMA merge operation assumes that the
> +	 * caller always specifies ranges within the input VMA so we need only
> +	 * examine these cases.
> +	 *
> +	 *     -
> +	 *      -
> +	 *       -
> +	 *     <->
> +	 *     <>
> +	 *      <>
> +	 * 0123456789a
> +	 * PPPVVVVVNNN
> +	 */
> +
> +	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
> +	vma = alloc_and_link_vma(&mm, 0x3000, 0x8000, 3, flags);
> +	vma_next = alloc_and_link_vma(&mm, 0x8000, 0xa000, 8, flags);
> +
> +	vmg_set_range(&vmg, 0x4000, 0x5000, 4, flags);
> +	vmg.prev = vma;
> +	vmg.vma = vma;
> +	ASSERT_EQ(merge_existing(&vmg), NULL);
> +
> +	vmg_set_range(&vmg, 0x5000, 0x6000, 5, flags);
> +	vmg.prev = vma;
> +	vmg.vma = vma;
> +	ASSERT_EQ(merge_existing(&vmg), NULL);
> +
> +	vmg_set_range(&vmg, 0x6000, 0x7000, 6, flags);
> +	vmg.prev = vma;
> +	vmg.vma = vma;
> +	ASSERT_EQ(merge_existing(&vmg), NULL);
> +
> +	vmg_set_range(&vmg, 0x4000, 0x7000, 4, flags);
> +	vmg.prev = vma;
> +	vmg.vma = vma;
> +	ASSERT_EQ(merge_existing(&vmg), NULL);
> +
> +	vmg_set_range(&vmg, 0x4000, 0x6000, 4, flags);
> +	vmg.prev = vma;
> +	vmg.vma = vma;
> +	ASSERT_EQ(merge_existing(&vmg), NULL);
> +
> +	vmg_set_range(&vmg, 0x5000, 0x6000, 5, flags);
> +	vmg.prev = vma;
> +	vmg.vma = vma;
> +	ASSERT_EQ(merge_existing(&vmg), NULL);
> +
> +	ASSERT_EQ(cleanup_mm(&mm, &vmi), 3);
> +
> +	return true;
> +}
> +
> +static bool test_anon_vma_non_mergeable(void)
> +{
> +	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
> +	struct mm_struct mm = {};
> +	VMA_ITERATOR(vmi, &mm, 0);
> +	struct vm_area_struct *vma, *vma_prev, *vma_next;
> +	struct vma_merge_struct vmg = {
> +		.mm = &mm,
> +		.vmi = &vmi,
> +	};
> +	struct anon_vma_chain dummy_anon_vma_chain1 = {
> +		.anon_vma = &dummy_anon_vma,
> +	};
> +	struct anon_vma_chain dummy_anon_vma_chain2 = {
> +		.anon_vma = &dummy_anon_vma,
> +	};
> +
> +	/*
> +	 * In the case of modified VMA merge, merging both left and right VMAs
> +	 * but where prev and next have incompatible anon_vma objects, we revert
> +	 * to a merge of prev and VMA:
> +	 *
> +	 *    <-->
> +	 * 0123456789
> +	 * PPPVVVVNNN
> +	 *            ->
> +	 * 0123456789
> +	 * PPPPPPPNNN
> +	 */
> +	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
> +	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, flags);
> +	vma_next = alloc_and_link_vma(&mm, 0x7000, 0x9000, 7, flags);
> +
> +	/*
> +	 * Give both prev and next single anon_vma_chain fields, so they will
> +	 * merge with the NULL vmg->anon_vma.
> +	 *
> +	 * However, when prev is compared to next, the merge should fail.
> +	 */
> +
> +	INIT_LIST_HEAD(&vma_prev->anon_vma_chain);
> +	list_add(&dummy_anon_vma_chain1.same_vma, &vma_prev->anon_vma_chain);
> +	ASSERT_TRUE(list_is_singular(&vma_prev->anon_vma_chain));
> +	vma_prev->anon_vma = &dummy_anon_vma;
> +	ASSERT_TRUE(is_mergeable_anon_vma(NULL, vma_prev->anon_vma, vma_prev));
> +
> +	INIT_LIST_HEAD(&vma_next->anon_vma_chain);
> +	list_add(&dummy_anon_vma_chain2.same_vma, &vma_next->anon_vma_chain);
> +	ASSERT_TRUE(list_is_singular(&vma_next->anon_vma_chain));
> +	vma_next->anon_vma = (struct anon_vma *)2;
> +	ASSERT_TRUE(is_mergeable_anon_vma(NULL, vma_next->anon_vma, vma_next));
> +
> +	ASSERT_FALSE(is_mergeable_anon_vma(vma_prev->anon_vma, vma_next->anon_vma, NULL));
> +
> +	vmg_set_range(&vmg, 0x3000, 0x7000, 3, flags);
> +	vmg.prev = vma_prev;
> +	vmg.vma = vma;
> +
> +	ASSERT_EQ(merge_existing(&vmg), vma_prev);
> +	ASSERT_EQ(vma_prev->vm_start, 0);
> +	ASSERT_EQ(vma_prev->vm_end, 0x7000);
> +	ASSERT_EQ(vma_prev->vm_pgoff, 0);
> +	ASSERT_TRUE(vma_write_started(vma_prev));
> +	ASSERT_FALSE(vma_write_started(vma_next));
> +
> +	/* Clear down and reset. */
> +	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
> +
> +	/*
> +	 * Now consider the new VMA case. This is equivalent, only adding a new
> +	 * VMA in a gap between prev and next.
> +	 *
> +	 *    <-->
> +	 * 0123456789
> +	 * PPP****NNN
> +	 *            ->
> +	 * 0123456789
> +	 * PPPPPPPNNN
> +	 */
> +	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
> +	vma_next = alloc_and_link_vma(&mm, 0x7000, 0x9000, 7, flags);
> +
> +	INIT_LIST_HEAD(&vma_prev->anon_vma_chain);
> +	list_add(&dummy_anon_vma_chain1.same_vma, &vma_prev->anon_vma_chain);
> +	vma_prev->anon_vma = (struct anon_vma *)1;
> +
> +	INIT_LIST_HEAD(&vma_next->anon_vma_chain);
> +	list_add(&dummy_anon_vma_chain2.same_vma, &vma_next->anon_vma_chain);
> +	vma_next->anon_vma = (struct anon_vma *)2;
> +
> +	vmg_set_range(&vmg, 0x3000, 0x7000, 3, flags);
> +	vmg.prev = vma_prev;
> +
> +	ASSERT_EQ(merge_new(&vmg), vma_prev);
> +	ASSERT_EQ(vma_prev->vm_start, 0);
> +	ASSERT_EQ(vma_prev->vm_end, 0x7000);
> +	ASSERT_EQ(vma_prev->vm_pgoff, 0);
> +	ASSERT_TRUE(vma_write_started(vma_prev));
> +	ASSERT_FALSE(vma_write_started(vma_next));
> +
> +	/* Final cleanup. */
> +	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
> +
> +	return true;
> +}
> +
> +static bool test_dup_anon_vma(void)
> +{
> +	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
> +	struct mm_struct mm = {};
> +	VMA_ITERATOR(vmi, &mm, 0);
> +	struct vma_merge_struct vmg = {
> +		.mm = &mm,
> +		.vmi = &vmi,
> +	};
> +	struct anon_vma_chain dummy_anon_vma_chain = {
> +		.anon_vma = &dummy_anon_vma,
> +	};
> +	struct vm_area_struct *vma_prev, *vma_next, *vma;
> +
> +	reset_dummy_anon_vma();
> +
> +	/*
> +	 * Expanding a VMA delete the next one duplicates next's anon_vma and
> +	 * assigns it to the expanded VMA.
> +	 *
> +	 * This covers new VMA merging, as these operations amount to a VMA
> +	 * expand.
> +	 */
> +	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
> +	vma_next = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
> +	vma_next->anon_vma = &dummy_anon_vma;
> +
> +	vmg_set_range(&vmg, 0, 0x5000, 0, flags);
> +	vmg.vma = vma_prev;
> +	vmg.next = vma_next;
> +
> +	ASSERT_EQ(expand_existing(&vmg), 0);
> +
> +	/* Will have been cloned. */
> +	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
> +	ASSERT_TRUE(vma_prev->anon_vma->was_cloned);
> +
> +	/* Cleanup ready for next run. */
> +	cleanup_mm(&mm, &vmi);
> +
> +	/*
> +	 * next has anon_vma, we assign to prev.
> +	 *
> +	 *         |<----->|
> +	 * |-------*********-------|
> +	 *   prev     vma     next
> +	 *  extend   delete  delete
> +	 */
> +
> +	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
> +	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
> +	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x8000, 5, flags);
> +
> +	/* Initialise avc so mergeability check passes. */
> +	INIT_LIST_HEAD(&vma_next->anon_vma_chain);
> +	list_add(&dummy_anon_vma_chain.same_vma, &vma_next->anon_vma_chain);
> +
> +	vma_next->anon_vma = &dummy_anon_vma;
> +	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
> +	vmg.prev = vma_prev;
> +	vmg.vma = vma;
> +
> +	ASSERT_EQ(merge_existing(&vmg), vma_prev);
> +
> +	ASSERT_EQ(vma_prev->vm_start, 0);
> +	ASSERT_EQ(vma_prev->vm_end, 0x8000);
> +
> +	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
> +	ASSERT_TRUE(vma_prev->anon_vma->was_cloned);
> +
> +	cleanup_mm(&mm, &vmi);
> +
> +	/*
> +	 * vma has anon_vma, we assign to prev.
> +	 *
> +	 *         |<----->|
> +	 * |-------*********-------|
> +	 *   prev     vma     next
> +	 *  extend   delete  delete
> +	 */
> +
> +	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
> +	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
> +	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x8000, 5, flags);
> +
> +	vma->anon_vma = &dummy_anon_vma;
> +	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
> +	vmg.prev = vma_prev;
> +	vmg.vma = vma;
> +
> +	ASSERT_EQ(merge_existing(&vmg), vma_prev);
> +
> +	ASSERT_EQ(vma_prev->vm_start, 0);
> +	ASSERT_EQ(vma_prev->vm_end, 0x8000);
> +
> +	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
> +	ASSERT_TRUE(vma_prev->anon_vma->was_cloned);
> +
> +	cleanup_mm(&mm, &vmi);
> +
> +	/*
> +	 * vma has anon_vma, we assign to prev.
> +	 *
> +	 *         |<----->|
> +	 * |-------*************
> +	 *   prev       vma
> +	 *  extend shrink/delete
> +	 */
> +
> +	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
> +	vma = alloc_and_link_vma(&mm, 0x3000, 0x8000, 3, flags);
> +
> +	vma->anon_vma = &dummy_anon_vma;
> +	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
> +	vmg.prev = vma_prev;
> +	vmg.vma = vma;
> +
> +	ASSERT_EQ(merge_existing(&vmg), vma_prev);
> +
> +	ASSERT_EQ(vma_prev->vm_start, 0);
> +	ASSERT_EQ(vma_prev->vm_end, 0x5000);
> +
> +	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
> +	ASSERT_TRUE(vma_prev->anon_vma->was_cloned);
> +
> +	cleanup_mm(&mm, &vmi);
> +
> +	/*
> +	 * vma has anon_vma, we assign to next.
> +	 *
> +	 *     |<----->|
> +	 * *************-------|
> +	 *      vma       next
> +	 * shrink/delete extend
> +	 */
> +
> +	vma = alloc_and_link_vma(&mm, 0, 0x5000, 0, flags);
> +	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x8000, 5, flags);
> +
> +	vma->anon_vma = &dummy_anon_vma;
> +	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
> +	vmg.prev = vma;
> +	vmg.vma = vma;
> +
> +	ASSERT_EQ(merge_existing(&vmg), vma_next);
> +
> +	ASSERT_EQ(vma_next->vm_start, 0x3000);
> +	ASSERT_EQ(vma_next->vm_end, 0x8000);
> +
> +	ASSERT_EQ(vma_next->anon_vma, &dummy_anon_vma);
> +	ASSERT_TRUE(vma_next->anon_vma->was_cloned);
> +
> +	cleanup_mm(&mm, &vmi);
> +	return true;
> +}
> +
> +static bool test_vmi_prealloc_fail(void)
> +{
> +	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
> +	struct mm_struct mm = {};
> +	VMA_ITERATOR(vmi, &mm, 0);
> +	struct vma_merge_struct vmg = {
> +		.mm = &mm,
> +		.vmi = &vmi,
> +	};
> +	struct vm_area_struct *vma_prev, *vma;
> +
> +	/*
> +	 * We are merging vma into prev, with vma possessing an anon_vma, which
> +	 * will be duplicated. We cause the vmi preallocation to fail and assert
> +	 * the duplicated anon_vma is unlinked.
> +	 */
> +
> +	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
> +	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
> +	vma->anon_vma = &dummy_anon_vma;
> +
> +	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
> +	vmg.prev = vma_prev;
> +	vmg.vma = vma;
> +
> +	fail_prealloc = true;
> +
> +	/* This will cause the merge to fail. */
> +	ASSERT_EQ(merge_existing(&vmg), NULL);
> +	/* We will already have assigned the anon_vma. */
> +	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
> +	/* And it was both cloned and unlinked. */
> +	ASSERT_TRUE(dummy_anon_vma.was_cloned);
> +	ASSERT_TRUE(dummy_anon_vma.was_unlinked);
> +
> +	cleanup_mm(&mm, &vmi); /* Resets fail_prealloc too. */
> +
> +	/*
> +	 * We repeat the same operation for expanding a VMA, which is what new
> +	 * VMA merging ultimately uses too. This asserts that unlinking is
> +	 * performed in this case too.
> +	 */
> +
> +	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
> +	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
> +	vma->anon_vma = &dummy_anon_vma;
> +
> +	vmg_set_range(&vmg, 0, 0x5000, 3, flags);
> +	vmg.vma = vma_prev;
> +	vmg.next = vma;
> +
> +	fail_prealloc = true;
> +	ASSERT_EQ(expand_existing(&vmg), -ENOMEM);
> +
> +	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
> +	ASSERT_TRUE(dummy_anon_vma.was_cloned);
> +	ASSERT_TRUE(dummy_anon_vma.was_unlinked);
> +
> +	cleanup_mm(&mm, &vmi);
> +	return true;
> +}
> +
>  int main(void)
>  {
>  	int num_tests = 0, num_fail = 0;
> @@ -193,11 +1391,21 @@ int main(void)
>  		}							\
>  	} while (0)
>  
> +	/* Very simple tests to kick the tyres. */
>  	TEST(simple_merge);
>  	TEST(simple_modify);
>  	TEST(simple_expand);
>  	TEST(simple_shrink);
>  
> +	TEST(merge_new);
> +	TEST(vma_merge_special_flags);
> +	TEST(vma_merge_with_close);
> +	TEST(vma_merge_new_with_close);
> +	TEST(merge_existing);
> +	TEST(anon_vma_non_mergeable);
> +	TEST(dup_anon_vma);
> +	TEST(vmi_prealloc_fail);
> +
>  #undef TEST
>  
>  	printf("%d tests run, %d passed, %d failed.\n",
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index 093560e5b2ac..a3c262c6eb73 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -81,8 +81,6 @@
>  
>  #define AS_MM_ALL_LOCKS 2
>  
> -#define current NULL
> -
>  /* We hardcode this for now. */
>  #define sysctl_max_map_count 0x1000000UL
>  
> @@ -92,6 +90,12 @@ typedef struct pgprot { pgprotval_t pgprot; } pgprot_t;
>  typedef unsigned long vm_flags_t;
>  typedef __bitwise unsigned int vm_fault_t;
>  
> +/*
> + * The shared stubs do not implement this, it amounts to an fprintf(STDERR,...)
> + * either way :)
> + */
> +#define pr_warn_once pr_err
> +
>  typedef struct refcount_struct {
>  	atomic_t refs;
>  } refcount_t;
> @@ -100,9 +104,30 @@ struct kref {
>  	refcount_t refcount;
>  };
>  
> +/*
> + * Define the task command name length as enum, then it can be visible to
> + * BPF programs.
> + */
> +enum {
> +	TASK_COMM_LEN = 16,
> +};
> +
> +struct task_struct {
> +	char comm[TASK_COMM_LEN];
> +	pid_t pid;
> +	struct mm_struct *mm;
> +};
> +
> +struct task_struct *get_current(void);
> +#define current get_current()
> +
>  struct anon_vma {
>  	struct anon_vma *root;
>  	struct rb_root_cached rb_root;
> +
> +	/* Test fields. */
> +	bool was_cloned;
> +	bool was_unlinked;
>  };
>  
>  struct anon_vma_chain {
> @@ -682,13 +707,21 @@ static inline int vma_dup_policy(struct vm_area_struct *, struct vm_area_struct
>  	return 0;
>  }
>  
> -static inline int anon_vma_clone(struct vm_area_struct *, struct vm_area_struct *)
> +static inline int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
>  {
> +	/* For testing purposes. We indicate that an anon_vma has been cloned. */
> +	if (src->anon_vma != NULL) {
> +		dst->anon_vma = src->anon_vma;
> +		dst->anon_vma->was_cloned = true;
> +	}
> +
>  	return 0;
>  }
>  
> -static inline void vma_start_write(struct vm_area_struct *)
> +static inline void vma_start_write(struct vm_area_struct *vma)
>  {
> +	/* Used to indicate to tests that a write operation has begun. */
> +	vma->vm_lock_seq++;
>  }
>  
>  static inline void vma_adjust_trans_huge(struct vm_area_struct *vma,
> @@ -759,8 +792,10 @@ static inline void vma_assert_write_locked(struct vm_area_struct *)
>  {
>  }
>  
> -static inline void unlink_anon_vmas(struct vm_area_struct *)
> +static inline void unlink_anon_vmas(struct vm_area_struct *vma)
>  {
> +	/* For testing purposes, indicate that the anon_vma was unlinked. */
> +	vma->anon_vma->was_unlinked = true;
>  }
>  
>  static inline void anon_vma_unlock_write(struct anon_vma *)
> -- 
> 2.46.0
> 

