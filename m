Return-Path: <linux-kernel+bounces-392765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD699B97DF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F7AC1F21AC4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887191A3AA9;
	Fri,  1 Nov 2024 18:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pv6Cn0Z9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nhoEyKIl"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB9514E2CF
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730486808; cv=fail; b=gnIaEK75SRTbg/2DFW3CQtU8E0tU+fIsuBgcv9vYLyTgYjBCzjD0OOiO/F3Ri42SaiFQRkckfyu5RJHvBGWhKi13RCu2NgN4OYvRP9ZtDdxIqXfE+wq0ZEe/8fms6IkuHNaSSUJX+3C6gsB6xNv0KGC7tUr/26iT7mRxZrwfcmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730486808; c=relaxed/simple;
	bh=ZUMhJJZfhWI50zFRne1rb7W2rQazl6Eq1drQrV3H5R4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HeZ9/uZcNdz6V+NvuyEoeh5x63tnbmTbVlJb8TNXCRk2nRw4Wcl5vvPiIMTPInoUsH41L/HnnI1JOhELT3GlEKYzK49a/0y1mAOqgr89dezTpgCAsDK994K0GoV5gEf/8xXBx7wrceHK7YDo0iC/VVZDmd42RYiNVVp5fetzfW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Pv6Cn0Z9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nhoEyKIl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1GBcmQ012955;
	Fri, 1 Nov 2024 18:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=LYC0Tq8toHpRlpy5
	lvz/KenXjM3EWvGZXLEwbOOwNM8=; b=Pv6Cn0Z9VMKFTEcfx7Wg1gLhdE4mDkdR
	q3tZfwl/bcWcpzPI9etlibopLUrSoIwMiWgeYYs+HSgVIUe2woY5qjvZVaVlkUDm
	vDCs8D7zr9qEvk1CX+d+0imcprfY8CHD8iIsIfbC4Xl4DFexFEXKQ0YDmwGjBDZK
	T7YXN5PR4jFqSSNpMocRYrjqnI+K5daS7+/j0oldQ00psoi1KGNtGoKqxeQfoDxZ
	uZnAOG/ztkvVZKvZu+ZarqE2x57T0/aWyM1qlvFfF2vfXsuclAgs3HsWlIhp7Icv
	jEhv6EFbGjlxFQ+xoL12Q43PDyanq1/SEK6iJ94Egy2ZkjprTXyg5Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdqms0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Nov 2024 18:46:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1IHlsJ008411;
	Fri, 1 Nov 2024 18:46:36 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnedtnqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Nov 2024 18:46:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHSkI/kgYZ0u6X9g2TLaliMcge/hRSvKqrU0PG/UxIBA/9Zuy0hCOf/pUmum7qINozUSHoudukE9GEghOtI2V9qPeNSfwThZa8pCAJePA4UOQ2zVToTKDSs72UqtsUTxfsj4g1DszKEGpFkQBQmPC3j6SeMT2Q+elRst7fzTQAj+5hNn52uezCti0em4J64JJ6VLi4qlBSWWutF/OGT82jIiHGgpvQp/oyGpYs83wQUISwaPuTUUePnaAWOulUw3hCTyptoWnQRaSxT3cK2H+PFjlDmrZWTaArwKwPL7iu36DTm69XE2GZY+IIq5M8K8zOaqNs7FYF/jX2HmIZadPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYC0Tq8toHpRlpy5lvz/KenXjM3EWvGZXLEwbOOwNM8=;
 b=xsQLT67RNouHcn/geovcn8L7lKzwwF1zMcrsEucfyF5icW+5GzrScSw7hibU1Qje6eMLJBlQTwTKP6lNF6lY9RuoRuAUiF7/vJusOPPXK1OVZ/kGrWbp4gvN2Tfo/8yC3UJwdj1YgAHbpYq48RQCRyy/dcH3O3n93R/9xKHBxXchTtFqKNWZ/N2yBGcMn+2qGRdzY4QlCaXwa4dWCwlN+RrLBrfLCAt9aNGvWkBQ2TqJzuGRPiZeUtCAtE4/vSShgYeuhifubIPSQMgg47q+ihWSX3ZfvT0ZidKMwL/CGu8S0c9CxnK+dLAFi5I/29VdyGOEYA4VTNYbsrhj6XBjzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYC0Tq8toHpRlpy5lvz/KenXjM3EWvGZXLEwbOOwNM8=;
 b=nhoEyKIlc38Zv8a5KEoxzFMSGqDBK6K+EGW+n1p9lLW4Nx7keNYrCEIDAzFMYiDeZcIFqT0cTzU7cWJ+4tokKECZguo1tlbKNHtXzxCn+xVnkG8wppyegb5rxAq8qSyY8RFCqEvV0CcEFnXOfNoYvbgpAxiadacDpVgfgfU6cf8=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH3PR10MB7414.namprd10.prod.outlook.com (2603:10b6:610:155::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 18:46:34 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8114.020; Fri, 1 Nov 2024
 18:46:34 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: remove unnecessary page_table_lock on stack expansion
Date: Fri,  1 Nov 2024 18:46:27 +0000
Message-ID: <20241101184627.131391-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0045.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::21) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH3PR10MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: a58b8392-a0d7-48f1-f782-08dcfaa58244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F4ILdSdlUhFGsYeXsCT5WQck9AMSuJyfN/Hx3dH8cm15IvJhWV1O4OzEiQhF?=
 =?us-ascii?Q?Z7geN9npzDM8Lo/ai1CIH4TWPClU2aNv8GxtbhpdNOflbYy9PZGF0zXV6xw/?=
 =?us-ascii?Q?B9GM9UefV0ErQm6V0ieVA4bOlRmjb1eE69FcfMTvODaKjSHngkaOzUZPhS1A?=
 =?us-ascii?Q?7j7PyyyPtylkLCTMiBT3PFMshezSi1HIxzJTEJI3m7526YSsQCmW3f/MzgtC?=
 =?us-ascii?Q?3hRL52rfEGZDnJiJd4/FGH0EqSUpiSe4gEfcSX93vFV2CycLho1R7qrrXqpv?=
 =?us-ascii?Q?rWTP+6l2Qu33f0EN5iqDjuV1Sm9NCSVI1muY2kMIv/rHl7fgVx5yT1QWOfGb?=
 =?us-ascii?Q?mq642QHibxh951swGTipRPooe/B39sfxw6gTyrjVdJ3tOrp7Di+G+nFjlwn0?=
 =?us-ascii?Q?MMA876L79zytuoVcFGDfLEIie668WvhMgQTbenTed174SkjC88rWLjax/0PV?=
 =?us-ascii?Q?ICiiGACzf+VNgBcOYFTt5GkDXVAvISrTluvaUnHiKTMRiBhXP/OpI/crnD/x?=
 =?us-ascii?Q?K2dKnt80Vs1797DsBzzLxqdyy62ioJPOYYiUfiVZJY0Ff0rmkOYfbUqFZCzj?=
 =?us-ascii?Q?eLMnBVVvizSlc+ijpb2hThOpFeRhCgqk6OBow9w6a++5xmfxFNom6yO0Ofj/?=
 =?us-ascii?Q?xdtdDHOoXhklOjAiL36785Lm3vkkEfwestew2gIj0xRofP7WhzIqf9i8lekS?=
 =?us-ascii?Q?jAGSbpdnY/oCo0rsdxDDsc21kcN2mK7rxRrOny9yA4D7uhZUdckvnnjPOkQ2?=
 =?us-ascii?Q?DJooPPgYFzXQr3B2NiST85xVRDJn1pnVcCwhH/mcvX3VJKqXH/6/8i7id5kO?=
 =?us-ascii?Q?fYQ4szkPx+DlR1gUZCLsQl9qm5tgNtyERc3ed2CyPb6/IBdDQpsDXpwiYbhB?=
 =?us-ascii?Q?SvW7iWID/53sFRH/ojBv9tF0DOwnfRmgJgvz+T+vJdMpjRa68ROlQDDWtUaL?=
 =?us-ascii?Q?0+hc9Jh61h4RVF451TZqsjAVVMinHrlqHzpE3qNJhIZoKdBOwaOCNW1p6pzg?=
 =?us-ascii?Q?4jqIURJ/1qFMlb7v0+kqHJVaxPEC5+CPHhEBk/nWRvAhLp68N0FoWkE600cX?=
 =?us-ascii?Q?rFi1/xZMtXqDa0De3I8NlbQQpOX6PG/uJNcdeSxV2B1b9a/xKpphyNFbEhMU?=
 =?us-ascii?Q?E+p9W9gBs/ApfgkNL7VkM54gIfsAzSwXWVEX4FYJlsg0R3UyXhOrxkmLH5BA?=
 =?us-ascii?Q?Bib9v0RawRZkP/bmHFTV5wvS5UjGJ1G33vhiFoGKOMfCA4M4W4wrn0I5nhCp?=
 =?us-ascii?Q?ct/+UFxDeCe9BbfExZuG6ZFNKujt9jrThBjlNyMYHt7eGW4n0APfXdHl4M/o?=
 =?us-ascii?Q?Nyq4NUR9NN1+mmLbDxdn56ma?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ml6Qye6w/YHo2fvn0QvyMw8ZcDa8BzqpNe8MkoNOaFb4KIJw0YU3FSC2LjE2?=
 =?us-ascii?Q?RyzXHxLoGlHYFwMA0KjDvJ5gBvxNZlGuOWiGMIMRye+usYVxhXJWsGByHJc3?=
 =?us-ascii?Q?nEdq2xioJNPEd2B6rNrvdmaA7vvA/EtU+sU5Kk/52/il0EvHaMFczyZcMqXm?=
 =?us-ascii?Q?SGIF4I30Ff4XEcfnMSZkVbFpHgSEIXW3CsIsQnP7a3ayWo8skuFtAlk/vzQr?=
 =?us-ascii?Q?xZP6xs4THaRjgSnNJHUKdx6/qEGRVyJqK6xYqdzgoEqknHf83xxaspnSDKra?=
 =?us-ascii?Q?phS3jBBkIZQgaamaPmpHH0BN4NYfsLMIDRhBnlLXlPOLwDGkz5xSVBCWCNd0?=
 =?us-ascii?Q?PRkfNgpiZ+gmVLO69WZM/VDVqAijQ8xzd1sdb1+oXSBJ8bULtz6LNAAQhmFr?=
 =?us-ascii?Q?Bf0ORHONeIQr7m/y9yEkoHvGMqIUkajfAyupueAz9zeHRthVgnQieSWYj0eD?=
 =?us-ascii?Q?4I+pZKBabrmRTEWK2GepTWw1xaRWnOfmtNxzYhIovIwi9HOwVrHyWJckLan0?=
 =?us-ascii?Q?eOwugX6lNW2uKs3ppDEPK3OJIWb7f1Wq3pNj/msaBe39tvKOKFPT47Vjj0dW?=
 =?us-ascii?Q?CSCV5NKoK+yVbdyGB22bw/3WsQGSjyo/hZFBYZJdAdEQVOm/LKvEzQIHwOeL?=
 =?us-ascii?Q?N/ByrWxGP81lrxPpG7t/U/RgPlC/q8TOLVtRe2CHvX/RqjGp5y4a0wJS4eEc?=
 =?us-ascii?Q?OTq1a63hDiJHxpPAebqSFCNHImLO12OFTvGxIxmUeZKWsSIqtVo6KcYZWKwp?=
 =?us-ascii?Q?U8CcTZtWZ1s17LrhKxbiBfhr/ckL5QAOAeqky3+JJhMLiFzZt4XFg+5esNtj?=
 =?us-ascii?Q?4MfnUe9Cpcmbjl6/K0NMjWKAIwzhuXhwsw0laiB2xilXeRjftwAfXTefbn2a?=
 =?us-ascii?Q?ZykTkg0+o1YY8RT5xWIsIxvuzjX7bQ7jhcuOJ3hyOcBhhlqDFXJzWOYnc/7V?=
 =?us-ascii?Q?xkZGY0ZeeGzzV5UgIMb8OcGWhoqeMiIg39IGmg1/G4SokDZwvb5LvjgAZFyB?=
 =?us-ascii?Q?IknuvVDjfibwObn0pxx0mEqwiV6i7hBoaCLpFvJIB55FzW8ShoeSdAO6lFWQ?=
 =?us-ascii?Q?1VFrYsMZotvt/g9YI5P73yUCy7jta8Q4xkVtEhwdsj4bAKnLTH/Yn/fdFc/z?=
 =?us-ascii?Q?eWD33ouFDJwj/H3DQ48qjRwWQU4aH56Dsbz8LZeTGHDI1aB2PHsl5Ck/0CJg?=
 =?us-ascii?Q?+/zQveDcCMYXyfTcihNRx0ikjkn/RwUJwLEy6TzNEh1CAu25snp6zoHcYi5w?=
 =?us-ascii?Q?z/4LQ6p1/INRFtTloGR4qkqC6kz0KJ7F5938TrwSdQI9f5UM6/pjE9yC+MRp?=
 =?us-ascii?Q?Tq2v9uRdAVO0YxZUsWsr+mMQkUhkhFtdcYBltQqwwwe+vKfIiYRwffwSqyEG?=
 =?us-ascii?Q?1RKQeoRhNKz+LkD0EJ8phT41uDq1EFlDTO95cssAiG1u/m5fRTciW2B9n6cD?=
 =?us-ascii?Q?znryef0UmA09zmdVp/kd1Y2Aw2nJDMSJv7CFrqLQ+IfDqmHAV2SGcVoe1Pss?=
 =?us-ascii?Q?gejnmKP+XY+mddQxPFvY0SNHUuwGQOX2EWArjt5rbCfQq1DjCEstyaze33kU?=
 =?us-ascii?Q?KWiSB/BWO5Z6dZM3ZhWZJZ4fvSKlTXE8bJdVppmb82rlwlbZrHs3kBPL02R7?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	04sr6joZI+nf6xWiQlwwSM3GaymqT97ofipbr0BlhbVqEbJr+BkOAiyMo8HaCd8CkXb3UQ8oIsVx0fLhnGPyrokb+8XG+hP+9fvgxzvBT+TmbbJvdrw58uPTpO8C+6cETlN2877cJ4OS27YfRUqLm8O7WQiE6V3//v5bk9IENxM2W8i66ZFCqx+nYgc7uBtZlRNTuSDReFb3+K6d50nwTSEYzSwAcMSieKq9svCB0oL+xt2sXjQhwzY54TFoiYJLwEZxGTyrKUD2W8VoZTY9nIigwVKCX/eQm/Y6xUqXOZa9MchXavsUkrwLoJSRHxBb4sHFA5humRPGoHk0GIeJ7Fiva5liu+wL+xob6cjBNpXKFO7MbFHaYgGN1IqWarzyrSE98U987UtcyIr02RcXbeAHK2U+ovK1qatawy8lUnTbRSFDjPTUmdteGQRvXCW64nHvgurOaMc0LIyBkX9vPEb77OkqWcciRs8WNiqoCrV+ZTGXhdPc0o6JevZ/MSbhYjj4ucy8avyn29NRnHXhl4Z8+06D4SwiIkLsbSI4J5Ih57nqoPCK3yywpPhAzOGi/+vLgdvtGV9akPqYi/rkGUYjuTCUiIHrHT8xOFdllQg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a58b8392-a0d7-48f1-f782-08dcfaa58244
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 18:46:34.4010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uPTqqTi63vvEsf2LJa/MjjoAj/RsQbOVTXqdwBKt75saX/+bTn5HkavEFo0QeyaGNVlSjcV8g1nW2dXUc0M8K0/1eCOtpnFUinsTS/7dcLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7414
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-01_13,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411010134
X-Proofpoint-GUID: U0XpXlfHevvKXwsSp4qdLnaTt3qoL5hB
X-Proofpoint-ORIG-GUID: U0XpXlfHevvKXwsSp4qdLnaTt3qoL5hB

Ever since commit 8d7071af8907 ("mm: always expand the stack with the mmap
write lock held") we have been expanding the stack with the mmap write lock
held.

This is true in all code paths:

get_arg_page()
  -> expand_downwards()
setup_arg_pages()
  -> expand_stack_locked()
    -> expand_downwards() / expand_upwards()
lock_mm_and_find_vma()
  -> expand_stack_locked()
    -> expand_downwards() / expand_upwards()
create_elf_tables()
  -> find_extend_vma_locked()
    -> expand_stack_locked()
expand_stack()
  -> vma_expand_down()
    -> expand_downwards()
expand_stack()
  -> vma_expand_up()
    -> expand_upwards()

Each of which acquire the mmap write lock before doing so. Despite this, we
maintain code that acquires a page table lock in the expand_upwards() and
expand_downwards() code, stating that we hold a shared mmap lock and thus
this is necessary.

It is not, we do not have to worry about concurrent VMA expansions so we
can simply drop this, and update comments accordingly.

We do not even need be concerned with racing page faults, as
vma_start_write() is invoked in both cases.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 38 ++++++--------------------------------
 1 file changed, 6 insertions(+), 32 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index f904b3bba962..386429f7db5a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1039,6 +1039,8 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 	if (!(vma->vm_flags & VM_GROWSUP))
 		return -EFAULT;
 
+	mmap_assert_write_locked(mm);
+
 	/* Guard against exceeding limits of the address space. */
 	address &= PAGE_MASK;
 	if (address >= (TASK_SIZE & PAGE_MASK))
@@ -1074,11 +1076,7 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 
 	/* Lock the VMA before expanding to prevent concurrent page faults */
 	vma_start_write(vma);
-	/*
-	 * vma->vm_start/vm_end cannot change under us because the caller
-	 * is required to hold the mmap_lock in read mode.  We need the
-	 * anon_vma lock to serialize against concurrent expand_stacks.
-	 */
+	/* We update the anon VMA tree. */
 	anon_vma_lock_write(vma->anon_vma);
 
 	/* Somebody else might have raced and expanded it already */
@@ -1092,16 +1090,6 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 		if (vma->vm_pgoff + (size >> PAGE_SHIFT) >= vma->vm_pgoff) {
 			error = acct_stack_growth(vma, size, grow);
 			if (!error) {
-				/*
-				 * We only hold a shared mmap_lock lock here, so
-				 * we need to protect against concurrent vma
-				 * expansions.  anon_vma_lock_write() doesn't
-				 * help here, as we don't guarantee that all
-				 * growable vmas in a mm share the same root
-				 * anon vma.  So, we reuse mm->page_table_lock
-				 * to guard against concurrent vma expansions.
-				 */
-				spin_lock(&mm->page_table_lock);
 				if (vma->vm_flags & VM_LOCKED)
 					mm->locked_vm += grow;
 				vm_stat_account(mm, vma->vm_flags, grow);
@@ -1110,7 +1098,6 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 				/* Overwrite old entry in mtree. */
 				vma_iter_store(&vmi, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
-				spin_unlock(&mm->page_table_lock);
 
 				perf_event_mmap(vma);
 			}
@@ -1137,6 +1124,8 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 	if (!(vma->vm_flags & VM_GROWSDOWN))
 		return -EFAULT;
 
+	mmap_assert_write_locked(mm);
+
 	address &= PAGE_MASK;
 	if (address < mmap_min_addr || address < FIRST_USER_ADDRESS)
 		return -EPERM;
@@ -1166,11 +1155,7 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 
 	/* Lock the VMA before expanding to prevent concurrent page faults */
 	vma_start_write(vma);
-	/*
-	 * vma->vm_start/vm_end cannot change under us because the caller
-	 * is required to hold the mmap_lock in read mode.  We need the
-	 * anon_vma lock to serialize against concurrent expand_stacks.
-	 */
+	/* We update the anon VMA tree. */
 	anon_vma_lock_write(vma->anon_vma);
 
 	/* Somebody else might have raced and expanded it already */
@@ -1184,16 +1169,6 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 		if (grow <= vma->vm_pgoff) {
 			error = acct_stack_growth(vma, size, grow);
 			if (!error) {
-				/*
-				 * We only hold a shared mmap_lock lock here, so
-				 * we need to protect against concurrent vma
-				 * expansions.  anon_vma_lock_write() doesn't
-				 * help here, as we don't guarantee that all
-				 * growable vmas in a mm share the same root
-				 * anon vma.  So, we reuse mm->page_table_lock
-				 * to guard against concurrent vma expansions.
-				 */
-				spin_lock(&mm->page_table_lock);
 				if (vma->vm_flags & VM_LOCKED)
 					mm->locked_vm += grow;
 				vm_stat_account(mm, vma->vm_flags, grow);
@@ -1203,7 +1178,6 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 				/* Overwrite old entry in mtree. */
 				vma_iter_store(&vmi, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
-				spin_unlock(&mm->page_table_lock);
 
 				perf_event_mmap(vma);
 			}
-- 
2.47.0


