Return-Path: <linux-kernel+bounces-241594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F3D927CFB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 20:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAA6D1F24076
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67338130AFF;
	Thu,  4 Jul 2024 18:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JKYGc9n8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bAdihBT/"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C009649659
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 18:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720117667; cv=fail; b=DRN6W0c7/RgN3EmZBRHkH80hSsYCGzt0UkX5JrB2jq0EPHysrdOmoLklREVR58VOJn8fLr44Ypbkenz3XSCCnFwBP1ONDzUU9p64caBCWU/bifRrlRqiRf5CgbHBqp9L9PuA+R3hQnPUMvwkzz5nKnbp+dElplYUHGDZUw2o0QY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720117667; c=relaxed/simple;
	bh=6s/9/zQs0giQkdAt6eAbPNiuj7v9DkM4VBjapEtRLxM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pOzoLNYOiAolYI6SPGqtBbPDrSnZGtgUzxqXSUE8vL0JmX0x/CbW+3NHZTjiyt1pq0hHTtNpYnGAjJFb1Ss2u/AIzfmhMa/gwnKrrZHxiKziAWZalytN5vE0nvpmMT48VZJ5xUy0Aj9TXCDOAUn08TDWjUSARh1drAnn4KCzs2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JKYGc9n8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bAdihBT/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464E4hxE032178;
	Thu, 4 Jul 2024 18:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=AJIXKbZRdDZOg8
	Eri9uri3lMAZV/NRmUwsFu6zrxkxg=; b=JKYGc9n87zL19Z1d9+lRxO+o2xqIIR
	JKm4emDz8U5XAuvLlBn083EXkqeTSCXvKuMQFysMGJdZJfDtvp+jQe5SaQPHd4OX
	DWNX5zM1JXF895DAXh4UEmv4pxhtTE2duvaIOryfdhLRCwYV+sklmfEQkxWdrZke
	HRTQh3sXzPL1iLmbhux6G5dvWFc0KL3bAbYe7VhVY/x+y1YFz9nIpE7q2YNUT1or
	Bp79wQFex+yn17MBbzSTuzFyA/+9VYX9zd2Fz/mRokXUkHHCcB+YhUBC160VqrcR
	JlGF4a4AxFtYtFPxZe6YDpnBKEcI7hA/q1N437bAMH7Kca65XYdofrHw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402a59aexm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 18:27:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 464FVlJD023459;
	Thu, 4 Jul 2024 18:27:25 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 404n11kmh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 18:27:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YO/yvqUVugRVDb4nsfuLbJ+/pkNobpZ0/sQlwY6dNrhiZJ7BpFDhbT0a6pBj4PRl8tF/eF8Zy6XNFP+3DliYYIZtkCzK86KPwSHMVJ/7Oa1exlBiA7RAkf2yAAOCLEH4AyA7slUtbDeb9+UEl8JcyaO21nvLCzmIlAybnF3YAV/MgT/l28Oeh8IoDvYBgjTth4bGC2p0iu/lqozPsjX0/jWGP67jf+irr280kIZOWci2chPB5B2gH9nxSH052F9bbDVO3YXqm2sKJZKbMeaG2ReWv4OA7m4cbQhHMoDbcvXE/KRCoUDZQr/Thw5M/poQaAZciOzxHcotiuQlsvo9pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJIXKbZRdDZOg8Eri9uri3lMAZV/NRmUwsFu6zrxkxg=;
 b=S2vlIZxXf2Rr5zvH8MxDfIT0DR6zuo1BuxH7dcdB2DyUaEA1SkqQDOERM6ngGFF+Yb1jfsQcCrfqo7lDs33OTwdfvdb4gsJ9DEls14Zhd/H069p2qvgiCkeo+HCUFF96JZ3XBQfyiWohI9p7S1Ek56KVv8spur17Qnftb7x6gfXmbs4PRpOUNl0g6s91Jm8BLHlVm4HWNPsMQC5gCerAgrImScntL9/RVXVEMXU/fnOQ/nj3s3cI3vlxpippOtAkWy/ZG55ZMhSQVr3EGFRWpHLzR6tITOa2VdLHNefaeq4bgpU8d6XBMpcrfCIVBDcI3Du645euw+dcTBWGSzdAEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJIXKbZRdDZOg8Eri9uri3lMAZV/NRmUwsFu6zrxkxg=;
 b=bAdihBT/aDN6A3DyaM5UL9ZJhV+QXJztXKO3nZQd3LtBtYdAwxRHqLxud0Ned7vNYhLhG4k02ZotSFqk2H1D01HVLReNwP066Ld73x/0VPCjpnzf26/Y3Tf5rBs2x164trQHcztXbOXYBcG1wCgnHxcTDVyCB3nm7/plIVpvr8k=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BY5PR10MB4242.namprd10.prod.outlook.com (2603:10b6:a03:20d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 18:27:23 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 18:27:22 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 00/16] Avoid MAP_FIXED gap exposure
Date: Thu,  4 Jul 2024 14:27:02 -0400
Message-ID: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0483.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::22) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BY5PR10MB4242:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a5ac89e-6ebe-488d-85a0-08dc9c56f255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?2EdOnNs3n8psm0Vfrcd4Z5xlzNPhR9eCSPj1+KOFvxWOYb6IskBgUnnE27U1?=
 =?us-ascii?Q?AKdG1IjW+F3G8PmCdcsJKuMujF7dd8z4kDSINIBSpT6JvnDby+UtH9gvH1z3?=
 =?us-ascii?Q?WJWepkxZ3xkcufaB8eaoE/YDiAppAafbFjBEqTq9oXJytCvGgqnNFOI16pTD?=
 =?us-ascii?Q?w0UT65wfkPAopitueN22dWG4w0x4ot4aPMwwsd9PRwIi3rv1dFIu5R9sX/0o?=
 =?us-ascii?Q?MH/566rWwaEtCWR0oSV4HzAFC+awdePxyZoUjm9tsEcqIwHgSfziEw8UE1Hn?=
 =?us-ascii?Q?PF8WdfBh60lJQH6JPyKJE1enCQBNfaC7chQVAt2NssL/6HUoe8/hgDy5MvYF?=
 =?us-ascii?Q?2pNJJxi7hdIds62vWUplNrw200YsJhe/c4U6rZgWHPWjLJ6mgOgoNpS9zs7L?=
 =?us-ascii?Q?FQXGHfwbtNQ8mQWXOs7UMno78dOfajFKwr6dwsITj5Zq46p4bTq9FrGtjCvc?=
 =?us-ascii?Q?x5IPYxv7TqYlJfLC95IZ38fZayomCe+55PuB5f70IJYhsJSZ8L/NugqFfT2A?=
 =?us-ascii?Q?EtlODq6xeGtvmaKMPiqhMHpnW1VvaMNWmliT3ur2BrhYnrp0EGNUvStUIWhY?=
 =?us-ascii?Q?/ZXlccfmIHc8EQs1ifd/Zz+EmKikKHSfqZesH09U4mdcXIWOTJQ3/tNr4DCR?=
 =?us-ascii?Q?rR0doBfqWolwHgaxrIX+UcgsGtXcRn2SZI+yoFsDECVqP6rf513QrP72D+fg?=
 =?us-ascii?Q?1h89SrhE4s3KX9tuSm6phTqmkJRPqP26JujIQjJ8HU5/5ZWymI19EdDioYpm?=
 =?us-ascii?Q?cVoRSFDGII49ZpctsRf/vKgGhiQkhkj20uGKMHQJPcErj/IbZ17btJ1z7Xfz?=
 =?us-ascii?Q?bq1STyIS0YAKXkgc+jEP1GDoyntfEk0yQIEtmllECJ6yyJF0UHSw1wweDe1i?=
 =?us-ascii?Q?RsLSHSEQ2Ok6K0kl6zPaSVQAKcqBc7PnG7IDJkRh/F0APNMU/y0thmpGOb2T?=
 =?us-ascii?Q?58+6O3wVR3b4Ek38PCqI4EmiIjlLU1HFCtIxwt5sP9iFN+LVHBbIKbktjNJB?=
 =?us-ascii?Q?1bLF6HbspnMWy0hlYaxAgiSuRunf72SyluiGdcrlfJ5HzqEP8t36E8e8ua1f?=
 =?us-ascii?Q?fKFs6GkAp5P71L88DsTCMAFSjtzyRRRL5jlFnrvuga5oLsk4U6NRDCEWLhpg?=
 =?us-ascii?Q?Q8OL+3dPcXNd1HVbH+/xZq6cEVtg5qg0sgkJXa0HynYsx7TzDIH/YXLQgum8?=
 =?us-ascii?Q?1XtyAgywTYd9gdJORjvxoTIAHInJEsBfMtzgnbFW3RCE1HsWTlGf3H46sl1P?=
 =?us-ascii?Q?jTO5RN5UaPkRccheS9QUqs7Tk5R3isT+VhZ5Al2iEhZqD8oa2s9EHvjpSqsn?=
 =?us-ascii?Q?187zb4JSQunExdMGgpGv8Lgr?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XAe2AH0djzIlN1UxDgmlu21dlVmMjvTirY5dTpCEJq9dpuwqtoHEhd/hrypU?=
 =?us-ascii?Q?Miy7zP+eLv+KFYtbBMD4fF8le+XflwHNRQ3H4uZIt2AF5y9rmmYgxDv7BUIE?=
 =?us-ascii?Q?pEHj9DjM5+EgVls4gYwiPxgt9oq/S20ObcfN41b2Wa2Bb+e84bwqoILxnBXC?=
 =?us-ascii?Q?cYXAlSquLhuQST/EGVXVd0rvzXcRyBciU/87l1QvkGFJ72UigmPNmlgHMZW2?=
 =?us-ascii?Q?zXGKfZygtmVOlE9MJTuzR+nD30g9v5MzbUe29gWxEhwZmNHaz7xNcGgleIpb?=
 =?us-ascii?Q?hAg3TywNesNVecKzqmHZ/yeuixRWDYxyORhlpJu+iCOB9Pb4IX2MbHfDFG+X?=
 =?us-ascii?Q?FwolzkWD3NIMU5fBVM/jCEYNQKX5wAZN+swT2Bf4S0j25GJanEHqKiZ1YW1Y?=
 =?us-ascii?Q?yKFZPU1J9ZRR6n08YbOSdoxUWNZgAMsBsgbL31nm8lbhwrPXWrQMwSIAkVu1?=
 =?us-ascii?Q?6u/1jMajc2mMGcu81lDkNzCDcOQOIwPU7DZZIcta9vs6/i1i10qJw9ZmAjyQ?=
 =?us-ascii?Q?4gEr+XgFh4E7T3vYyb9XOj2I1gg/EyjLq0nIT2a1rEov7OV02A591RgaX8g0?=
 =?us-ascii?Q?Pb3SJz+WRvtyb7rbrYFpjnph4XhfBpQ5WxdKSdsgI2Cl2ZYPXCFC6IoR9j/O?=
 =?us-ascii?Q?aejYRdL4c47YIJyVnlWeN+yxFNngqSYTK57x0UrDyiGFYij/kj87dvP8I8HS?=
 =?us-ascii?Q?b1ValHM4NKIx/40vGWvgbGeF/LEazXUIV6Ek+kEcX64KP6/RgmYK+F3goKoX?=
 =?us-ascii?Q?swWImHlqE102Im+Tt3o1dXIyHZG9wSX9ZyosX3t7PXTd1DR5QDvCrocTnkud?=
 =?us-ascii?Q?n79HFcWCZKx6OMHfMmRGTayEZzQnp1nm0tz3rlzYVTYxshssLOMkqGPg/i6u?=
 =?us-ascii?Q?rWuDaRZkqM1OohROqICQAJetGHnsR4uu64QSfua9XGy24XtQssKWv4s+zgS0?=
 =?us-ascii?Q?wMEBMoHX+c1GwMRpcUuNzhTZz+2r26UDROzocS4WxIy6qpvZwSB21DBQ1BK2?=
 =?us-ascii?Q?F6ln9MPaU8i6Tdzj2vwKE/lVYA+s/HXFggTFAF5jTsXuwvdAbo3532pV6YzP?=
 =?us-ascii?Q?SII49CRxoNMYqFqa0Js+1e8miIN7Yk2h8KkiS27eUl8ko34L2s1KTDmjsx6m?=
 =?us-ascii?Q?WpNUPE0h+MWjvIjHmvjEXOsG+ucVP1uNLAUZj2p6qoatpqdjpkfs5jTaO4f+?=
 =?us-ascii?Q?WJgkVlrEAE0V/bS3olCPMursFd0WxrkWps/4rVibA0OHY/mYIoAMYIuTxX48?=
 =?us-ascii?Q?izOz/1AH+//7gvw46nUJAyof5LBtPlM0ezDNkat9fkCC8NYpImg6xjAVKjux?=
 =?us-ascii?Q?J3HRv/tlhbCCh2neF9hbk/4X/oT+UuzCrOs/Wf5EMC8SKMKeRymrrRRN0zAO?=
 =?us-ascii?Q?QeU4uqGtPOf9lG/tjeviU8pXMWNlJbF+Jn268wbsRFgA8cVYTKRlailr0XPU?=
 =?us-ascii?Q?RnuygdZwCJKL5V18Wggv/foxXq10IBQ0FAqVQUPF5AOBCexpL+2AhXgNGHxZ?=
 =?us-ascii?Q?mUMFG6OqjF1W+6OfRpSbDjyl3Ydwz8Yxxt4HDgaiFaHE9PHDUk/AH5u++TR0?=
 =?us-ascii?Q?9IusM/eOszVpdRBWfNUvQAjPhP9FQr6f5CUJAUYa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	sgHmp5osVsCMvE941yIoI+n+kk6b3kZluplOhPchw01x5eiUxq21pFJIxu5aI8NyQJOdvhRuJ5NS8jqxK6age5I5Vuo2rQRfYzdVshwpHHiZRByPp+iGdER+kArwHpBvt1VCfjf/ejMzijnJGqxY5k1e0vP9ZldmNXTRAbzCpC8JaubhnJ8uFSwyJi41HG2UFQCKzQGP72GFmN73UsWdEg/MhjpWZKcRVfBKvs/NyR1F32H6KPsYcTDo6e9VcfYzFIXZLYNejCuaWLlN4rPvFW5DdlL1KvJ5R9FleYk5yReBeU+Sl4klXEq4a2O9eB/kRQQ6tDfKPY7RWS+bvv4u10YGqNOwlcyiGdiZo1sANwPjBx/VWUqe3cchdHXzI8BHTu1okMYRwmpGJgi6BcL/AKqaML7Tm1DlOmp0K1PGZkE93H0sGN2p019L5gFER4nCmaJS7wxrnWyA0FXJ9+vcybAOQxVGziJj1uGHLygJ7ksleG138Ha6HTYE+VavLr2OsNabqDpirr4W2ht0pwX0/4rvYvpnF1YLElIOrtqnvHhbjZFtO7PRI01Ca+W/G7EnHYNxx6HTfP+rZzj3xek00dz20WarllIiBsxox6QHpc4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5ac89e-6ebe-488d-85a0-08dc9c56f255
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 18:27:22.8255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XajWJcvXjKTNkf5XaZogWkIIgun4R4qUXXaADGCfV9aMc71RW1yrtssVATd7gtvxhKTblhGSeNdwhprD+CiOHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4242
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_14,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407040134
X-Proofpoint-GUID: 9FN3C5as-_gcHMacvRzvzEB5M0vegQVk
X-Proofpoint-ORIG-GUID: 9FN3C5as-_gcHMacvRzvzEB5M0vegQVk

It is now possible to walk the vma tree using the rcu read locks and is
beneficial to do so to reduce lock contention.  Doing so while a
MAP_FIXED mapping is executing means that a reader may see a gap in the
vma tree that should never logically exist - and does not when using the
mmap lock in read mode.  The temporal gap exists because mmap_region()
calls munmap() prior to installing the new mapping.

This patch set stops rcu readers from seeing the temporal gap by
splitting up the munmap() function into two parts.  The first part
prepares the vma tree for modifications by doing the necessary splits
and tracks the vmas marked for removal in a side tree.  The second part
completes the munmapping of the vmas after the vma tree has been
overwritten (either by a MAP_FIXED replacement vma or by a NULL in the
munmap() case).

Please note that rcu walkers will still be able to see a temporary state
of split vmas that may be in the process of being removed, but the
temporal gap will not be exposed.  vma_start_write() are called on both
parts of the split vma, so this state is detectable.

RFC: https://lore.kernel.org/linux-mm/20240531163217.1584450-1-Liam.Howlett@oracle.com/
v1: https://lore.kernel.org/linux-mm/20240611180200.711239-1-Liam.Howlett@oracle.com/
v2: https://lore.kernel.org/all/20240625191145.3382793-1-Liam.Howlett@oracle.com/

Changes since v2:
 - Introduced vms_complete_pte_clear() helper needed in case of modules
   mmaping over MAP_FIXED area.
 - Reduced arguments to unmap_region()
 - Fixed potential free_pgtables() range issue on first/last VMA.
   Tested with stress-ng --vm-sigv

Liam R. Howlett (16):
  mm/mmap: Correctly position vma_iterator in __split_vma()
  mm/mmap: Introduce abort_munmap_vmas()
  mm/mmap: Introduce vmi_complete_munmap_vmas()
  mm/mmap: Extract the gathering of vmas from do_vmi_align_munmap()
  mm/mmap: Introduce vma_munmap_struct for use in munmap operations
  mm/mmap: Change munmap to use vma_munmap_struct() for accounting and
    surrounding vmas
  mm/mmap: Extract validate_mm() from vma_complete()
  mm/mmap: Inline munmap operation in mmap_region()
  mm/mmap: Expand mmap_region() munmap call
  mm/mmap: Reposition vma iterator in mmap_region()
  mm/mmap: Track start and end of munmap in vma_munmap_struct
  mm/mmap: Clean up unmap_region() argument list
  mm/mmap: Avoid zeroing vma tree in mmap_region()
  mm/mmap: Use PHYS_PFN in mmap_region()
  mm/mmap: Use vms accounted pages in mmap_region()
  mm/mmap: Move may_expand_vm() check in mmap_region()

 mm/internal.h |  25 +++
 mm/mmap.c     | 479 +++++++++++++++++++++++++++++++-------------------
 2 files changed, 321 insertions(+), 183 deletions(-)

-- 
2.43.0


