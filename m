Return-Path: <linux-kernel+bounces-206627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047CD900C1E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B2E61C21075
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2969143864;
	Fri,  7 Jun 2024 18:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PO+2rqbe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CeYSPjwK"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26D510A24
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 18:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717786465; cv=fail; b=F3jcRzPthxR9DoZ7OJONMv4sJt3Q03/f69v7px19EWX8BzH00pqJq7SIydvtfru66Rnb0LP3b8tFU3xHzaOZCcHg6rA5riOH2GW8s6cNAge45Ec/C9uSH+rxCS2lHw7SnZAxt3QJnjNvRoilfFr3flBq2l0U8mprffDY+dZI4Vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717786465; c=relaxed/simple;
	bh=fuvIPhajJNRabpEHZzbmIovAgzCxH70E2kLeBAtf2+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BSTZkLnuEcwq+Dl1REw1RjwMa+OBfcLFmhTdG+Ib3GOw/GtHdPqXzuqXppV62mkQXKbheBogJiFaOtuDeuyrVq/U3wIkYtMx2UjNBE9kTVFIZDQwD0yvKc4cAZv1tILkVrQmpuO3nP4q0j9v7OWhQ8OcoQd4bVDVo34hTCZ2BmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PO+2rqbe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CeYSPjwK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457Cubmj015442;
	Fri, 7 Jun 2024 18:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=4/F43IRAGhI8ljuTq8SfDFEQovm5z5taHx5vw5SWya4=;
 b=PO+2rqbeAyNn1P3F6/EaytYEhFx0iAtvU5kbbF6H7Y88+4XuNd458/qsa51AsaCoI3/5
 yTzmhvZFTgmyZtWcfeF9k966s2CxjY+KfL+YixfVeqd7wYMubPafuorM/DRXXznVsgNS
 88z64U3FDET6x30EsE0PmL9DAg1/WFwWIluUXNxudlhRRssBK6LD9Ly3B46SV4ka2COg
 qEcPHU3lpyIMHkmappwA+uUs+09J+lZhmV6OBJD9SGqFQ3Rhw8GkFwb5PRyaApN2s4DF
 1Z9GUUbLBu1CU2sV9NMFyGYO9ZoKQpGwj5HiJAVJ9wLpA6VMdtqfotrpMbkyu3mc647I /g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjvwd495m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 18:54:14 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457IojwW025263;
	Fri, 7 Jun 2024 18:54:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrtdbxts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 18:54:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VD/Z3oaw47JuXBNsg4j4V5rnL6M5zRo/lOqN7kAgDfEjfMWnxV0PK5iEnMVjB6NqhH9pUj5C6MGGc9LyWsVsXCVjkrjSMzRmA3SYYuewKxSAyCVkRkmTxQxzQA2dz1+NRMD6z8DejbjFAQACC5Oxxxq6pXq4qhs1D7iJNHHEzeEYA/M+ooH2qicX5CBQphjyMMv/Zja4HcatQRzMJbQLriCBTHlDKYKgc3I4qeG7qgyww1w4nRbp/9DN+rVbyNcVsLbabSD4zln6Bb+rSijSzFI4IM/3Cwq8zh9sOnb03vD+R4Y2xyvOb0jsInUpT7ab3eIBZKuu/TfNCgUU3MzgTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/F43IRAGhI8ljuTq8SfDFEQovm5z5taHx5vw5SWya4=;
 b=ExjLqBOW9ae+S4HzqTqtQathKu3TOGEwMHYf4/dLskvrXSpLoDt0ttNK6OUO/KkI0z0wUoRvn3bqEglLOBGtqHrkkbZBX4Jty89Qroxtco8jg5pcR9/e3vT3W/5Bf8BzG2tF54YbEO6dCEFKNp/yYfak1PWdp5n9UUnIICJ0iuuYeZNVxf1V712ggnM5sCVgFkDnWgn/uz4W8Dr6v9fUxhKyKlHJLBnMR0Ye9fc8pHcrqsZ5J1aRuHo2Fu6D/fgCWChkVpmOQ8fW70N7keUJB9VNRgTgfLZIkSoVYpuu3Sbk6UdH25K/2b0xhXzgPs8TVLeGSuondrlWkM6kuWxhVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/F43IRAGhI8ljuTq8SfDFEQovm5z5taHx5vw5SWya4=;
 b=CeYSPjwKXnYzXKDMAe32zqalt4sUP82S9Eibf+0I7C/eNqBmEuEJI905VhMq490XSHMYTbnm3HgN4YnSHSxM8no2wgF7MwcG2ZFw0ynwxO/ErPNXu0IGCpGCYyw2cyNFJN2ablcSJ/diq3fRMk6KNDTA3yzb8WO8OOBVP2RwCgM=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SJ0PR10MB5629.namprd10.prod.outlook.com (2603:10b6:a03:3e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Fri, 7 Jun
 2024 18:53:10 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.034; Fri, 7 Jun 2024
 18:53:10 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 03/16] maple_tree: move up mas_wr_store_setup() and mas_wr_prealloc_setup()
Date: Fri,  7 Jun 2024 11:52:44 -0700
Message-ID: <20240607185257.963768-4-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
References: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0361.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::6) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SJ0PR10MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 92f28d1f-1c8f-4264-ea6b-08dc87231374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?VRRT/d7YwfCnQma8nJwO2OFokOWGSXpfwIfZitQ8ksZW2W+RA0Au8MmuM3ug?=
 =?us-ascii?Q?hCtK5C9SNM5Qce+TtRbm5NoBLZlI6xK4IdPOGacz8KPXlr3T15STcFefk+7v?=
 =?us-ascii?Q?0d5y8rhwxJ/hE7+kuVxykodhbsl5MGArjSHwrtDVYhg244n8cWYceHl69yin?=
 =?us-ascii?Q?xP0fu3H8Jh2knC28SN9UpIyCPX/YCf4RCvFxFK3Yv3WqnsLg9JIjbJV+njv+?=
 =?us-ascii?Q?hBZRcK/nIZwbIMiqw2YrAjzJiavO5CEdVI5mcJ8qbmn1SE9qQZZ1GKkH9oKG?=
 =?us-ascii?Q?ZskXLpTpIDaWSzxuv4KHCiy/iDgIswMthY5SYvRR1pp16kw5MFG02dBUBW2i?=
 =?us-ascii?Q?9C9p0LOdEfFrLI9W0saooxlCj8lbbik4BgFBgIX5rIo0VxRhwmPZrSuBFGvI?=
 =?us-ascii?Q?wi3EP9h0vR832kndLm8C1FO5zyKb28RqLDj5grY3omyEmgVrJSidK823OlDM?=
 =?us-ascii?Q?Hy90ay1qHTxvdanRhiBQE4i0JZjfl8Rpfl5RsSefOTPe4Ul3Bg07zxhhxJaL?=
 =?us-ascii?Q?lH0cRvKmx+nEciixexv+4mO4DTEhb6FQ4GSjh+y9nAUck4/1b5TN6uvEJzuo?=
 =?us-ascii?Q?IvL1w9cjQuGkBzHQWP4WIm3bSDaYo4YEWKnQ3v+zl/PT+VWIY0cM6BUbnasj?=
 =?us-ascii?Q?foSfy5Ny+onfSLVyOE+PRr5yl3pQR57Vk1ybhjK0bdYHtZ62mo83mOm1ZK1J?=
 =?us-ascii?Q?SRVAhXbaag5bViQBhMgMHNV+MRlAchLiF1ODlfCDFPiv5JFpvvaut2xnrFs+?=
 =?us-ascii?Q?VtGprMgkD7soDLO5cwfuqhhzPjOf1BjWVNZ6QhVRHUJ1LHtB+eR4Q7+tofkw?=
 =?us-ascii?Q?g68GiCE+kJbb7NcEmP78Bi4ySEZQ3h/6JzBccEXDVO4CCYDsAtzeNR+RnEmB?=
 =?us-ascii?Q?CpX06k12CzqbRrK1FT/bufLaCP36UYohc5d1K6OzSgoVFKORK4rma/oGcHLe?=
 =?us-ascii?Q?s80tAagV8CWGuxqbUbA1MLd5AHxihHXr15rtgqQEM1axdVxhYIwz/iktMtgQ?=
 =?us-ascii?Q?i86KAP27bmtdVrXcFx9CjlwW9d7N7L7jdH+MZf3ragdur2A4Z+Es/xDgV7ht?=
 =?us-ascii?Q?SwjLt04/hD42CsfEJWXF1jTkBZaOBioMX0yL1ToHu8Jp209HB58oXDQt6cKL?=
 =?us-ascii?Q?f/LE46FaTf8fYzMYzuKNILbk85ock4z0NI6/vom/ueLSQS6F+14E7yPp0Ewu?=
 =?us-ascii?Q?t/XECTc0GO/QZkOawsjURsVUaYw0Nta7ETDjWeNShxwA5/U9YbDuYohk4uNL?=
 =?us-ascii?Q?jTfxWLE2kEceI+ZYwJJLjfs+j8ia02DB32Gi91CDEuaBmlqRS3cuYQic89RO?=
 =?us-ascii?Q?ETg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?h2VlLFcwolEUvlxi3fFsXZToyLt4ytwY+tI53Xc7Ehq7tOu6DJf8PQJQa4/+?=
 =?us-ascii?Q?3TqCUBIyTXrZ0okEIGuxe7fgr35I4bPOAIaC255gmvTeGFwFZUIEn5/Rk0zq?=
 =?us-ascii?Q?Q6y+KCU1UIaI2nRB6PEVS0AqLjQMhdm7jRU9mF+QKI61uqkDUrxoSdc6K/Vm?=
 =?us-ascii?Q?UshIOiMlXYcL//hcdx3qF8BFFv6CN1DkXcUAMnvQqZOkaBVWwdhuamu87BBx?=
 =?us-ascii?Q?BA6din8BLVfBIoOUOJNoqso87yyDXS+LY/yjXN4YaFSy4REgDeL+fZO1yON1?=
 =?us-ascii?Q?1hmKU3vF9o7qA3lsTKBuCGq1eTBMqPlYwPch2H/W9Hkix8KsAif5xQONnKXf?=
 =?us-ascii?Q?ubMFDDiQoZ+aBn+81tnMz+4+CFZppMoeT4ZUjcXGbECJxKghC6S1Lc9zzM/2?=
 =?us-ascii?Q?NvOBJHVXsoRGfN0Uy96qAMUE24m3mSo33c2e2mgrno9F8ti+TY1057cf9gbo?=
 =?us-ascii?Q?YOj2/RzSv03YpVntCQHEIql9w+/H7PoETLzoDhe4YiqMdUWRLDoVg8sKETIV?=
 =?us-ascii?Q?KZ2JXnFRj6kp/OOd0wpL6CfQBrl8/704qr7FC4DpqVm5oqeA6bHo5MGIFPwv?=
 =?us-ascii?Q?K6/Px22M8J3Qdb9ABMIqs0zXVulYkysX2TARQtnsHzMZ5WIv1fZ8NILCXMYU?=
 =?us-ascii?Q?9UxXld4HUKlVMqfysFjseT8ruyujqcOBsFrh30sWNyKeg8HTg1Ppk+3W1DUE?=
 =?us-ascii?Q?KtUTyKq49iGZL6iM5DKpb8rLLEG1Dg85JyGjLmaT2tkS9br5tcwvD8kuYEWE?=
 =?us-ascii?Q?t9dQ3vPX/TAful1mhU3Myhll29YA+qUrbCDKuaX1EmLLvq/EJsYjURmK9YsL?=
 =?us-ascii?Q?q8Z83O4H8zedkGrdRVYwWhCXb5ifd0lgZHxWcNsKSkuRw1HaNJu+xyJxRWer?=
 =?us-ascii?Q?smMluswbOIMLmWfQKWIZH4c/mizd6LajLNk0iK6kd4lgZ6WDZTWs8Dj75NcP?=
 =?us-ascii?Q?0E4xTJ+i6Sz69Cm9ijgZrSk4F4GKHRJP0cY9ol3JnsuLxYR+CeU2snbrvpjW?=
 =?us-ascii?Q?P8efr+FL8gmnRPv1BRhRdHo4Bbf+dzPXRIfdMeiKqVMS/Qn4WNAc61CcYgM4?=
 =?us-ascii?Q?Vf2fVryq9zWrFeYtFRFLPM2X3eI7G4JHf07BOJjDUSrEpWwUvM2498nWn+PI?=
 =?us-ascii?Q?XM99M6KTAfYr3dwqinoD8N7RbL8z6qdfdGB1c9kbDiF+8d0L3P1XLRUgqz4s?=
 =?us-ascii?Q?4VM7VeKPJeZZfVO2uazhO9MfurdQhrKigfs5AYlgMFF6wt+M0yCYwT4eUnn7?=
 =?us-ascii?Q?k55v57opYDgnXvNfjdPNznjja0ufzcCpz0EeiaHtfXsBC8vTSs23GDRUS6Gw?=
 =?us-ascii?Q?FCgrM1JTYptVEI3fs1am3cMhm2GtjP+Jfm58Jh8FADMrUdhvVqBZl+HIv9VR?=
 =?us-ascii?Q?GH+A3Pt32/rAO7HxAbvghnsRQXvQ8pFuyxY/uNfUbsVQDTuxQazMWUohYx9Z?=
 =?us-ascii?Q?WyMXIlaEZka7yeUA9WeohXQUaS0VM6htsyvC6OzV3raE5uvMdWcS/RZbQLGS?=
 =?us-ascii?Q?ppj0NnwZDoaBWbrNJA/w9gHULiNQcHDqKiloLSNXrr2VEUJpFJJpeq0yXDwb?=
 =?us-ascii?Q?cXyDzzhjaoTPMukFpN/QFv2JU8bqjWy7YOY81PHjxgRrL+1MGHMxDeae97RM?=
 =?us-ascii?Q?+QK24FeDabrn8ofTXplXXHU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Z0xu6/b4/otVCuodc4D8DiZtksPlckk+ddd2Cl5i3M/VeCAOIOKI0xF1S57tXtPoW8bSn67rsMQFg+L1/+vLbg/wSipSDs4vl8Cnh+xb2WuLE+pvNrZgigUkuihLLu2nrncfUyMyaOfvg+yE13VLubegWdp7uXLoysofW9DwxjwPjwExDV7hitjYDX3h0KfV+25w4JokjBdm2mbICTDLtKbGIlUn5GbJpa7TovmLH836qZcgUWMsAcjOwUHqCuPx4UEmhYZXLZ/+QryswB9vcEWJQoyseUHGfUYRvO7UWkPjrwXqWukOlYx0Is/z0b1Tvf+qfzNeL8K8R0jX9QY+PtvYlQc0mHdlApmpLGFJZHP3YyneNGKMFzHv3iS7Hsk2A7r431HzAfA7bP/f/Ez9FOGe0rJUHf5luIvSu+tpSCRM+tMecktSaz9M964YQdo8/9f2KdcB/TrfIG3vUoWt6xWoHDXym09eGeV0+Lul/XhlpStqh4TuIQT+SDzFQXNT/dnUmIOjDZ6OQQEheYMrWQc6kvuNPUBTNnbA3Ph6hfD6ZmB+WDj5AqsQHQ1AB6cqChVE5PWWCRQhOy6msDc+yNGrcqMKmUvHHmXAFikRtY8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f28d1f-1c8f-4264-ea6b-08dc87231374
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 18:53:10.0903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: raBcw4kWm4WZ7gDXxBrOK1qp7FuIQgUZHIZBvu6DgMCeFKTM2yEX4vr0WxW/eJScgI6SYjMlhmpIWhEDWeAjrns4x8JmmHmA0K3gp4i0wAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_11,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070138
X-Proofpoint-ORIG-GUID: Vqs0oFtGowhjzcu6taGi3dfmscJ6TrZF
X-Proofpoint-GUID: Vqs0oFtGowhjzcu6taGi3dfmscJ6TrZF

Subsequent patches require these definitions to be higher, no functional
changes intended.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 96 ++++++++++++++++++++++++------------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index ccbec0f66562..2558d15bb748 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4230,6 +4230,54 @@ static inline void *mas_wr_store_entry(struct ma_wr_state *wr_mas)
 	return wr_mas->content;
 }
 
+static void mas_wr_store_setup(struct ma_wr_state *wr_mas)
+{
+	if (!mas_is_active(wr_mas->mas)) {
+		if (mas_is_start(wr_mas->mas))
+			return;
+
+		if (unlikely(mas_is_paused(wr_mas->mas)))
+			goto reset;
+
+		if (unlikely(mas_is_none(wr_mas->mas)))
+			goto reset;
+
+		if (unlikely(mas_is_overflow(wr_mas->mas)))
+			goto reset;
+
+		if (unlikely(mas_is_underflow(wr_mas->mas)))
+			goto reset;
+	}
+
+	/*
+	 * A less strict version of mas_is_span_wr() where we allow spanning
+	 * writes within this node.  This is to stop partial walks in
+	 * mas_prealloc() from being reset.
+	 */
+	if (wr_mas->mas->last > wr_mas->mas->max)
+		goto reset;
+
+	if (wr_mas->entry)
+		return;
+
+	if (mte_is_leaf(wr_mas->mas->node) &&
+	    wr_mas->mas->last == wr_mas->mas->max)
+		goto reset;
+
+	return;
+
+reset:
+	mas_reset(wr_mas->mas);
+}
+
+static inline void mas_wr_prealloc_setup(struct ma_wr_state *wr_mas)
+{
+	struct ma_state *mas = wr_mas->mas;
+
+	mas_wr_store_setup(wr_mas);
+	wr_mas->content = mas_start(mas);
+}
+
 /**
  * mas_insert() - Internal call to insert a value
  * @mas: The maple state
@@ -5361,54 +5409,6 @@ static inline void mte_destroy_walk(struct maple_enode *enode,
 		mt_destroy_walk(enode, mt, true);
 	}
 }
-
-static void mas_wr_store_setup(struct ma_wr_state *wr_mas)
-{
-	if (!mas_is_active(wr_mas->mas)) {
-		if (mas_is_start(wr_mas->mas))
-			return;
-
-		if (unlikely(mas_is_paused(wr_mas->mas)))
-			goto reset;
-
-		if (unlikely(mas_is_none(wr_mas->mas)))
-			goto reset;
-
-		if (unlikely(mas_is_overflow(wr_mas->mas)))
-			goto reset;
-
-		if (unlikely(mas_is_underflow(wr_mas->mas)))
-			goto reset;
-	}
-
-	/*
-	 * A less strict version of mas_is_span_wr() where we allow spanning
-	 * writes within this node.  This is to stop partial walks in
-	 * mas_prealloc() from being reset.
-	 */
-	if (wr_mas->mas->last > wr_mas->mas->max)
-		goto reset;
-
-	if (wr_mas->entry)
-		return;
-
-	if (mte_is_leaf(wr_mas->mas->node) &&
-	    wr_mas->mas->last == wr_mas->mas->max)
-		goto reset;
-
-	return;
-
-reset:
-	mas_reset(wr_mas->mas);
-}
-
-static inline void mas_wr_prealloc_setup(struct ma_wr_state *wr_mas)
-{
-	struct ma_state *mas = wr_mas->mas;
-
-	mas_wr_store_setup(wr_mas);
-	wr_mas->content = mas_start(mas);
-}
 /* Interface */
 
 /**
-- 
2.45.2


