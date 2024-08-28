Return-Path: <linux-kernel+bounces-305626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF13963168
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4127C1C222D3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D501ABEC2;
	Wed, 28 Aug 2024 20:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ISun4aAI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dl18WFGs"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F105B139578
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 20:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724875456; cv=fail; b=G/iZNm7aLV7rFmayW7MeK96PNGYCPu6+1Jq1ilWY1FPRbdj5M3hOQj56pzTdeL3tdCtexWrazD8WkQptxwgd72P2BFAmvVEmPjm7FyR+QKnKHqSKiQhosTfr/BaSWikKYuud8GWzPPFP0+EtCDQ6g5jV2A0J9//giyKgNSOv/dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724875456; c=relaxed/simple;
	bh=d1V1UYynUN/vMaboRNcPTxNgqfN8+9/en9IGb3a97JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eC90YhThuk2Q1ZjkFHv2dCX2sR0c+jPNlanV774urlc5bL0ly64fn52ZJBHqJ+3JW4nj9G2paSAE2wAWvRwMsYu7UnOWJg3C7OZizywabyGj1sIM/mZ6wN9ax9uWlWZgFJM9qFKEM81+pZsk0+feFxslhxVDy2wxaNSH5mnZlvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ISun4aAI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dl18WFGs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SJXXVC019656;
	Wed, 28 Aug 2024 20:04:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=SW4hf+pJTmLPcqe
	o1ivF5sgyBVIl6g+RSv286Y/Dt9o=; b=ISun4aAIEjZIchiLDPqTTAF6OG+2EjO
	vKVN04atBbnA6DD13WxuybrzAE2RTTp+ObypCXbDan68gfhX1gGispbXqHNMldMD
	GsuKZtBAnw8msPhoIPtJxJrpOAfgZ79FahR3hmd4tNP0khpDyZ4vEvz/GzQ3BkO4
	+p3d9z+sgLBARCJrEZAP6KS6BXc0soZe18UNsdQpqWp0nSwGLm1miiatia4wie+/
	T2lWqlbHqCh6ZZA2rOuyWJ2DuS2cUhPVtWFoFfpZm/h3St/fJ5ID6vJ1oGNtF9bh
	QNUkbWDJSbuVP7f9oytFscL03rxuRWUZJXQcQMstEwvQNBME56eSf4w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pukt7kc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 20:04:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47SJMOM9020091;
	Wed, 28 Aug 2024 20:04:02 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418j8ph9bp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 20:04:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kR3FYE6aObZAbr8ZGrfJjvBjIGGzg8wJB1Iw5Iv1hakms+3n7hzoO48WCqMLvpPw9dYfnJeaLpX/Uv4eeMAFWKeNGQG8kbQUjmfeDskZqf/Unff3rbg4xpvbMWL2sCOfC10Gro+CVtl8SNUK7ecxL2Lxon/k62UmtvdxiRZDv5f7xWPGH+BbKVnoLM6zCj60iOl45kTrWmNM6X0HDfv8wPaRCAVRgHFB5SJkU23/DdcwHbJiVqSoypBFf+TA1e/g/2ByR0NGJS/xu5d+4KwRj2rKE9sfAYIWOt02A+DQIt82htWTJermWRh2m4IIftT7L+BQNurIkdA5vDMj7W+1bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SW4hf+pJTmLPcqeo1ivF5sgyBVIl6g+RSv286Y/Dt9o=;
 b=uRnXayx6pDlCyGyM+rM4RTNMsTCfTBu5rhx5UPDv97AxH2oj6p/NDJKbtaG41wBUo3Oqq0+fXEbCxTTagQrhVBwznf/0yb01uFmQOhB8v0yZtgLoJhiTcSsYlGxBjmjP8O8hJ/kiLGLTt0b8IhXHN0kLVUFbeBFWP6jif1nLaP9PQnIL1rps2Iq++oz4O9/4Omjojkzayy2ZtOu2G5OeJ+HVhU9ECJPOfQ8157PiS53nrSUFWtgdWat+ZY/WbiK2R/Xq8xVsXzLUATWUe2Ildjjn2M+r9iHKmxzahfIjy2mJ/omy6dcQkF2frYlHNotEF5i/wrtXr9ZJrj4tD4pz3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SW4hf+pJTmLPcqeo1ivF5sgyBVIl6g+RSv286Y/Dt9o=;
 b=dl18WFGsGp4FMAaNUUmN+1eNXEOjP9r6sxjin/0Rnz4lUiIv/2DpgncaQGT4mC5y+2URwiWcrpuh5T8js38vPsdPzs2FG9Ur2pYF1DMgY8TA7nBRV3Qy4amxX2pzVnBusWHB7g8Pwu+3ZZLanjCd5vxlZZhjHsFktjX6oxERg8I=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SA1PR10MB6590.namprd10.prod.outlook.com (2603:10b6:806:2bc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.17; Wed, 28 Aug
 2024 20:03:57 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.012; Wed, 28 Aug 2024
 20:03:57 +0000
Date: Wed, 28 Aug 2024 16:03:55 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 05/10] mm: abstract vma_expand() to use
 vma_merge_struct
Message-ID: <zckithqj7lpa6cbvyfg2vtxwbpruwd5bqrgowy25ci6jaa3u2t@2nni4fjohkov>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>
References: <cover.1724441678.git.lorenzo.stoakes@oracle.com>
 <0cc0e4d1af6722b3b0d121647089659bd8060087.1724441678.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cc0e4d1af6722b3b0d121647089659bd8060087.1724441678.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0385.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::24) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SA1PR10MB6590:EE_
X-MS-Office365-Filtering-Correlation-Id: b79d8232-a17b-4650-4e22-08dcc79c8cf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QaCv/GEBsZjVyq6CNJmsHSeTOwNfx6mQ/e53mHOqyN4uU4D7nUS5rGbmAKvw?=
 =?us-ascii?Q?amz/BQihx7ePx9BryEwGjtGA8/Kk7Yyie1Fzv4FaPGVZuN/ODEn98U/7hleU?=
 =?us-ascii?Q?CVv6/VKCwcD2W17xnLXp2MCfnRz4uC/Wa0KF8bppIgTR6j/l8ui0DIBe6oUg?=
 =?us-ascii?Q?I57p2MxtrGsg/aPdlDtgroijf+srioaID1tDIkU2cKWnA0VgLy2KxzuuHWu1?=
 =?us-ascii?Q?WOUPu05Y1sr2ryq1h+rXjOuhfNf2+D2eU9Y2U+olVoy3Lbmf0jcv410WsX7p?=
 =?us-ascii?Q?MtGyU1d0vlwzUNk4/k0qgYZbjSoQetrJjXW0EWnTgG0cLt+AeHPSxJlrPrlf?=
 =?us-ascii?Q?YXCheUAUnmVltex7qO9qvYPdIS5e83YD2wA51h94LIooASYHgc9Ruc6Ts5Tr?=
 =?us-ascii?Q?+kMtbhRfYL9xej/wOuyJFz28u4g5dJPRW09dR9HyQ29zZkNlfaHD94PTFvKG?=
 =?us-ascii?Q?1KwPrlVNiH6V5w2gG1kIzAAD7HiVb2hhQjFXDdFadqArOyViQtt/mDbXLy0V?=
 =?us-ascii?Q?CBiaLjRGzKu36QHTDygxd6rd5vMESORp09GHoMOG1PLSx729CDjjsCJKZCy8?=
 =?us-ascii?Q?J2LJwd8RtcFIJKbgWZmRRqG+1tmt7vt+Q5LTARnPQOAGbqqNVsz17BOAsF5v?=
 =?us-ascii?Q?a2dKT+/Z8x9uPVSUUPWkIHjJKA2NvxXQ3t3Vwr2l/Q70x8K9o63/zdFJERwj?=
 =?us-ascii?Q?V1K1xea+5BOlRZ4Hm5wYtUGOkhqJKIKMOuo/5ts1nDxQxJqGh1q9NVNjGCp4?=
 =?us-ascii?Q?iJbPXqyR+q7aVVM5uEviY9vi5BER7WFYZKo1UOvF70fLjoEl8WkFq623y3kL?=
 =?us-ascii?Q?Oi5DKu09Krqg62nBkG6a3twxpziy9eAuBsNjh+srpZGf8KCHr6wUAtcPzcUX?=
 =?us-ascii?Q?zePXylnuKP5uFZ3/mmluqnbKATcQsfvtyn0jc85/m3QK1O6kcuRtEl6zGiPl?=
 =?us-ascii?Q?VU4sUgjviBp5cErD6zg4NJseZW8H36Q4hEO6hYMVdtZrgvPK8sxoZsyu8NBG?=
 =?us-ascii?Q?2JNt31sfjYv2Cna/4Jarkl3npJXyZ8ASAYmOMlqh1QQ9uU496aAp3nnJNi2H?=
 =?us-ascii?Q?l5+xu45tlAZri3fCbioTCMR8j+EJ+VbY1nFzOWOmtIQ45V+ZaqlfUdXaDjoA?=
 =?us-ascii?Q?lrfWYSyazzDx+W/SX5y+QO57OhvlAYiUDGcesRlZhIRov+qYy6klwn1XBBeu?=
 =?us-ascii?Q?gCv2Zsv4836s8zoZhqM62ECRZwB/xZcy/nTDCvOLLR3Y20ITJU7gbp8wTE15?=
 =?us-ascii?Q?n1dnbxiI3C9mRVqJsmDap31MnDrRFNYRkSL+RLjL906TaaMJ2srDU/RZknj1?=
 =?us-ascii?Q?U2RenpKnHuzfbEVC5lKozJBq6Q/wTzPxvBJ38dY4CC3Ung=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NeflwtjVdFrdlhKAe9xGSdPPm6Et+XuONWIXS69Ym6KJRmKNjYU3KXY0SZcA?=
 =?us-ascii?Q?WZJfzcBGTP57eLsNxEuPr4xaS0r6V2dJjtzZxRtoCnoEbRO7GB164GKCybAa?=
 =?us-ascii?Q?hbXd0bAOy7pHDcx1dL6GoNKawU8VbEgA2UUbzavuq/vCvfa2zfL+g37rGk8c?=
 =?us-ascii?Q?J+vV3B3P4yimA3MSKWDH8TmD7j/D3zRnKpMO/ps+QKjvY6g6YQkvjJKE0JDE?=
 =?us-ascii?Q?2JU2uuVcOy/YBC1aHfbCE9rZRD4ZTIOocJlNwuyweuOOaziMhbH0Ct7EyHD2?=
 =?us-ascii?Q?1m8XcrzFdnJXBBm6pzdenRTokCUoCBwpJseuYY4baIF2EZU5S3qrUlHE+iS4?=
 =?us-ascii?Q?QKrQoQGsdki8ff1aovt5hxSrdOspKxTPk9rk/WSgvkukuvVRYfmRib50GZJp?=
 =?us-ascii?Q?R8n54Np4TowrjdvHuIxdYhQauL6nCP7ijooEtsqj5llttUEnsjl/Yg+RbJEz?=
 =?us-ascii?Q?xMa0ohRgSQgD3bqaNHFtpFLGWgdlloFfDxvJ3JL5ieuJOqjCG3owNp6Ria5u?=
 =?us-ascii?Q?u+xQbW9oTSIblIlmWCRxfhSl301WOtWd4yzn/YTVDOHRu9l4X+Trg+2eVexD?=
 =?us-ascii?Q?/btsgNAcLtq90Q0u3YloDZNT+7AbnfhmSr+KaNGmnw+884GbkrgyzFXlJ3Am?=
 =?us-ascii?Q?QYlKWl8CG+ewQYimheKrlVuWzNWJ00y2yuLFlpW+b37hy7zVqvCSM81t3CyM?=
 =?us-ascii?Q?tV7B5x1kwSvsjeQ4Zk8Hvm+m2GLDWma/40JqVPtygsCTo9uCv5OnscBBpowi?=
 =?us-ascii?Q?DnIgJ3E4Y0sD3j27T7nCc/BeCUqOiWv29IcRk/WXEp64sZQwxd6+g4c85xOb?=
 =?us-ascii?Q?umGHz9rfDNBM8Q+j512LfUqfHxUEaOry3btfzu9+Dp9v7B07oZxC2/gCp7S/?=
 =?us-ascii?Q?Ww13glOnJdABFe7SJKZ5hPXiRk/8fWgYpsMPboEPDjrAr7f15+l6OTxk9Osq?=
 =?us-ascii?Q?Lfq44tqUzekBIyeHGqJR9LrR+v2/eYntuQ/y7zX/6lrFvEN76itSLXZVLjzI?=
 =?us-ascii?Q?78cwwIFWrmDoHa1uhmpv9x1ogWzPyA2ovc2ECruPj61yWPOFsB4I7aK+J1Oc?=
 =?us-ascii?Q?0FSYVeqxKQ4Y5N15qy3p0sOWUaYIMuu6avXznae5JlDohusu1he4XTmPDrXw?=
 =?us-ascii?Q?HIkVhPO5z1qi6q1LeDbSalQ8X7AlijAnRsdQGcBNnR4F75I+U6pDag91/e2Q?=
 =?us-ascii?Q?/swJm3TgjByQ9l0ABrwpDFoyZiMO3xIsezdsVfACYs0GbfqrLzG6JzarQKGp?=
 =?us-ascii?Q?1iOWHg0HfbrSGI3qXacc3cmrP2S32JxHjviygdtUyktcSSpeAsLhjUn+YQ6Z?=
 =?us-ascii?Q?ckZX33OTpbtYMS3kuwcooT9O286IatdePMGTSLVxhacvMuEvrdwFQKFkr4vF?=
 =?us-ascii?Q?wa25Hwzd7G2ovq+zH2gOjowFsY5Wjj3e3o8HKZIqCOzi63TtzoofFdM12m6d?=
 =?us-ascii?Q?Vep2hQ+igvKInvj02gvzy0hfBydcKwVT7y6l42dheEuE2oa6buwIGI0v0k3s?=
 =?us-ascii?Q?SidrjqRR6aos3qyN1GsRRA/q8ePBy0hxjHxYlzTvvILeAfYqifLK7Lz6hOJ5?=
 =?us-ascii?Q?7h4AkL9Drwz/iSHfIGl56La0rmIhJm+uNA7Dtiab?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jMg6cjQtLC45m8BK57EWvWehFcwPtCxGEP9e517QpRLH9bsvps2ENrr/fPL6vccTrtE/ivMI20MRIPk3fVVo1S0ntgi3FPRSSrxE+5sFmG/IX09SvE4Ajjiuiyh9I5i8g3MZyoX7SF2LjzYaKzLUt/ieoKVyXs2C/kOM++brY43PrRExi95TuuASGew3gR3qW9rNIRkXLSjY62dXH6qdW6PL82nwpNM2rkHIGe0wDsgHYIT3xpG/uoMnTsMLKNh+FH4HbYTS9OvyGXwhQMG6MTzGt49GPV8Lz2DExCZdPcg9YlBWl00ub1pnZIAg5s9nkDFxgrGRAcynGzvTfYdAEkSIifJ6Ihc0d87jWhjp8YOS6bmw13cgeVvl4CODlYAAH/UYSHETTtzUUvWrGLVblkKO9QdMNE702bl3p5T5f9oxcKutEbQ6byup5PiBhp3jfVW0NokPm0yOOlrSIpaotMyKzBufV04V2rRfqsTHaYt7HeJ1u1KiEj0uIEeh5b9AT4H2HllFoftNJdlvHZkRkuFTz6qVtEcgk8V7f+amdHuf8eZZgQCzR569PixLyj9XWhs+aX+/kJSvvWIuiAeXBF0J2jHP/qr5otkIY7k0sIM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b79d8232-a17b-4650-4e22-08dcc79c8cf9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 20:03:57.5562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WyNq4nEg/NEXnZw+j7p7DjZ32Wnavc4Flg/DPK+A8smrDY265+skB1ugdIwh6RsBYwnfXqcDrbnCN2Mtci9ubQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6590
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_08,2024-08-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408280145
X-Proofpoint-ORIG-GUID: Vipsrj8qmFJwsXv-4GqLdtJNnAgWgfBp
X-Proofpoint-GUID: Vipsrj8qmFJwsXv-4GqLdtJNnAgWgfBp

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240823 16:07]:
> The purpose of the vmg is to thread merge state through functions and avoid
> egregious parameter lists. We expand this to vma_expand(), which is used
> for a number of merge cases.
> 
> Accordingly, adjust its callers, mmap_region() and relocate_vma_down(), to
> use a vmg.
> 
> An added purpose of this change is the ability in a future commit to
> perform all new VMA range merging using vma_expand().
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Just one extra whitespace below.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  mm/mmap.c               | 16 +++++++++-------
>  mm/vma.c                | 39 +++++++++++++++++----------------------
>  mm/vma.h                |  5 +----
>  tools/testing/vma/vma.c |  3 +--
>  4 files changed, 28 insertions(+), 35 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index c72f50feb98a..0d242c9b1f4c 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1371,7 +1371,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	struct ma_state mas_detach;
>  	struct maple_tree mt_detach;
>  	unsigned long end = addr + len;
> -	unsigned long merge_start = addr, merge_end = end;
>  	bool writable_file_mapping = false;
>  	int error = -ENOMEM;
>  	VMA_ITERATOR(vmi, mm, addr);
> @@ -1424,8 +1423,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	/* Attempt to expand an old mapping */
>  	/* Check next */
>  	if (next && next->vm_start == end && can_vma_merge_before(&vmg)) {
> -		merge_end = next->vm_end;
> -		vma = next;
> +		vmg.end = next->vm_end;
> +		vma = vmg.vma = next;
>  		vmg.pgoff = next->vm_pgoff - pglen;
>  		/*
>  		 * We set this here so if we will merge with the previous VMA in
> @@ -1438,15 +1437,15 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  
>  	/* Check prev */
>  	if (prev && prev->vm_end == addr && can_vma_merge_after(&vmg)) {
> -		merge_start = prev->vm_start;
> -		vma = prev;
> +		vmg.start = prev->vm_start;
> +		vma = vmg.vma = prev;
>  		vmg.pgoff = prev->vm_pgoff;
>  		vma_prev(&vmi); /* Equivalent to going to the previous range */
>  	}
>  
>  	if (vma) {
>  		/* Actually expand, if possible */
> -		if (!vma_expand(&vmi, vma, merge_start, merge_end, vmg.pgoff, next)) {
> +		if (!vma_expand(&vmg)) {
>  			khugepaged_enter_vma(vma, vm_flags);
>  			goto expanded;
>  		}
> @@ -2319,6 +2318,7 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
>  	unsigned long new_start = old_start - shift;
>  	unsigned long new_end = old_end - shift;
>  	VMA_ITERATOR(vmi, mm, new_start);
> +	VMG_STATE(vmg, mm, &vmi, new_start, old_end, 0, vma->vm_pgoff);
>  	struct vm_area_struct *next;
>  	struct mmu_gather tlb;
>  
> @@ -2335,7 +2335,8 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
>  	/*
>  	 * cover the whole range: [new_start, old_end)
>  	 */
> -	if (vma_expand(&vmi, vma, new_start, old_end, vma->vm_pgoff, NULL))
> +	vmg.vma = vma;
> +	if (vma_expand(&vmg))
>  		return -ENOMEM;
>  
>  	/*
> @@ -2368,6 +2369,7 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
>  	tlb_finish_mmu(&tlb);
>  
>  	vma_prev(&vmi);
> +

Unnecessary whitespace change.

>  	/* Shrink the vma to just the new range */
>  	return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
>  }
> diff --git a/mm/vma.c b/mm/vma.c
> index b1ec412fac7f..4867ae722a9a 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -467,30 +467,25 @@ void validate_mm(struct mm_struct *mm)
>  /*
>   * vma_expand - Expand an existing VMA
>   *
> - * @vmi: The vma iterator
> - * @vma: The vma to expand
> - * @start: The start of the vma
> - * @end: The exclusive end of the vma
> - * @pgoff: The page offset of vma
> - * @next: The current of next vma.
> + * @vmg: Describes a VMA expansion operation.
>   *
> - * Expand @vma to @start and @end.  Can expand off the start and end.  Will
> - * expand over @next if it's different from @vma and @end == @next->vm_end.
> - * Checking if the @vma can expand and merge with @next needs to be handled by
> - * the caller.
> + * Expand @vma to vmg->start and vmg->end.  Can expand off the start and end.
> + * Will expand over vmg->next if it's different from vmg->vma and vmg->end ==
> + * vmg->next->vm_end.  Checking if the vmg->vma can expand and merge with
> + * vmg->next needs to be handled by the caller.
>   *
>   * Returns: 0 on success
>   */
> -int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
> -	       unsigned long start, unsigned long end, pgoff_t pgoff,
> -	       struct vm_area_struct *next)
> +int vma_expand(struct vma_merge_struct *vmg)
>  {
>  	struct vm_area_struct *anon_dup = NULL;
>  	bool remove_next = false;
> +	struct vm_area_struct *vma = vmg->vma;
> +	struct vm_area_struct *next = vmg->next;
>  	struct vma_prepare vp;
>  
>  	vma_start_write(vma);
> -	if (next && (vma != next) && (end == next->vm_end)) {
> +	if (next && (vma != next) && (vmg->end == next->vm_end)) {
>  		int ret;
>  
>  		remove_next = true;
> @@ -503,21 +498,21 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	init_multi_vma_prep(&vp, vma, NULL, remove_next ? next : NULL, NULL);
>  	/* Not merging but overwriting any part of next is not handled. */
>  	VM_WARN_ON(next && !vp.remove &&
> -		  next != vma && end > next->vm_start);
> +		  next != vma && vmg->end > next->vm_start);
>  	/* Only handles expanding */
> -	VM_WARN_ON(vma->vm_start < start || vma->vm_end > end);
> +	VM_WARN_ON(vma->vm_start < vmg->start || vma->vm_end > vmg->end);
>  
>  	/* Note: vma iterator must be pointing to 'start' */
> -	vma_iter_config(vmi, start, end);
> -	if (vma_iter_prealloc(vmi, vma))
> +	vma_iter_config(vmg->vmi, vmg->start, vmg->end);
> +	if (vma_iter_prealloc(vmg->vmi, vma))
>  		goto nomem;
>  
>  	vma_prepare(&vp);
> -	vma_adjust_trans_huge(vma, start, end, 0);
> -	vma_set_range(vma, start, end, pgoff);
> -	vma_iter_store(vmi, vma);
> +	vma_adjust_trans_huge(vma, vmg->start, vmg->end, 0);
> +	vma_set_range(vma, vmg->start, vmg->end, vmg->pgoff);
> +	vma_iter_store(vmg->vmi, vma);
>  
> -	vma_complete(&vp, vmi, vma->vm_mm);
> +	vma_complete(&vp, vmg->vmi, vma->vm_mm);
>  	return 0;
>  
>  nomem:
> diff --git a/mm/vma.h b/mm/vma.h
> index 9060a1a1edfa..8f01fbc20fe7 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -128,10 +128,7 @@ void init_vma_prep(struct vma_prepare *vp,
>  void vma_complete(struct vma_prepare *vp,
>  		  struct vma_iterator *vmi, struct mm_struct *mm);
>  
> -int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
> -	       unsigned long start, unsigned long end, pgoff_t pgoff,
> -	       struct vm_area_struct *next);
> -
> +int vma_expand(struct vma_merge_struct *vmg);
>  int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	       unsigned long start, unsigned long end, pgoff_t pgoff);
>  
> diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
> index b12f72979478..cce1ba78c57f 100644
> --- a/tools/testing/vma/vma.c
> +++ b/tools/testing/vma/vma.c
> @@ -121,8 +121,7 @@ static struct vm_area_struct *merge_existing(struct vma_merge_struct *vmg)
>   */
>  static int expand_existing(struct vma_merge_struct *vmg)
>  {
> -	return vma_expand(vmg->vmi, vmg->vma, vmg->start, vmg->end, vmg->pgoff,
> -			  vmg->next);
> +	return vma_expand(vmg);
>  }
>  
>  /*
> -- 
> 2.46.0
> 

