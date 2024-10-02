Return-Path: <linux-kernel+bounces-347169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 889A498CEF5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A1A1C20365
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04895195F04;
	Wed,  2 Oct 2024 08:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f58QPLDx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cngV7f2S"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA4646BA
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 08:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727858388; cv=fail; b=l3Ud83E988M4rySc2paK7YlvRIbnWqHcJz4fRRk3zYV+enm9zqM+QaQFIcBkPVfuJbMcb+L5hw3jQZceMoskLdfGK7dW4fQJHQShH/o6eHYD6AqCQoxOoLnq1p/UxxQ3YF8wlRvqrISr5pa6N/ysEgEXNLYQeuJEvyQC2dgrA+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727858388; c=relaxed/simple;
	bh=Xf0PmxKpJMV793s9Wzt7J8S7varb8pH6c4kDLQDLLqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A/rMCTZQKc4M0eXJX52t9AjnIrLqzBY3XmMfKZslMbkYIUpC8S0+F5iQ75j8u30bCdh9PAcGUgaLJPP91hqpVgg08YmVNUu6x9whPRtZq9kTLZQuD2akZ6IcokNkwjn5CuhC5MRfVao3WOJQGu8iULVvkh0Pwrt9pdL5DCrl1dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f58QPLDx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cngV7f2S; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4927fWjh024458;
	Wed, 2 Oct 2024 08:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=p7xCIPId6mMPnMG
	gOdZGhsHMVUE4O0C65krc5+fVW74=; b=f58QPLDxM/sgR24efccCh2jmwh/FaJ5
	P2BjVPy5i5tAEA9yQIT25cFXRA9pxAOCUlx1zYEYd/7vjMP3KH9DXdYTHtggregw
	avgjC3Mm8OlU1pp88YW8HufvkzDNC/eJvm2sV3qDqzL5NDMUqqc13gIUxKojOSdv
	Qx9KGzASK5BDIL+Mkv7BWWrGNv5vLm1DLkXHsS2rrbRJY5YgyOZpC//vUFrmFhAt
	oir7dfEqsX5bnEz181aXT9iXXDTW3sW4lVI9+rmr7XsiVRLfGBW5HtaoTlmqnKc8
	WvwZVVPnpJNsM+aeGAOudx4ksCmZAER+cByCTOmerDssFg6oLaYoaSw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8k38m00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 08:39:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4926C1D4026240;
	Wed, 2 Oct 2024 08:39:33 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x888n93j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 08:39:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8O7xapldtx93RVekj8VIuqzTtuj+xp6yJuMf9oNdmmJLQ/d8mHERv1RMfEfuX0r1dFKadkqWpa3wtMHUbtr3fMglvXwJlMqNZCEYoJrG+PmPMKMIj79CFpMbDC4JrxRgdmYbpUMur7bNQ1K//Ul5zCmVdIco34g6+yIXfHi5roSfnk+SpQ73w+I1x5pKhhu3cLXufdy6jLQnRU2/lf0AlF1nt0eKttsX1dyEp0MbYksDypTanIStecHJQJob6iVmJ9VDHtuDyyyp7EiASsy/fLS0RTWJZlX/TuDQHXHnQHKDNt+R5xU0F8/5dDcU3YkH7boIMTu71PQA9FdFD44/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7xCIPId6mMPnMGgOdZGhsHMVUE4O0C65krc5+fVW74=;
 b=BxG0YS/Kc8bWgX0Zon1u+aGwxfTh8pn/l+QSwZspND4yynHD94Zkr+QnWwH/iG/+Q2ugl3V+bTMAEV6ejWUmEEJIne6hvcrOg/ChMQdhDUruYfmIpQUEIbUo3tHWV1gK1+stHgucd0fOI1Znh5R1Y4WtE+fTChTZ/J899QFETinGz4VKH1tGB85MA3oo/xiq65HRpmpQUrU9te1lGh0U8vVswqvJcvWBKi6XHbk9hjSOU5Z+MNIZIbmF15SL5IDKaC3ZMiEF7CY6pt/ZPjGO+ezr/vv9rvXbQZQl2KUBqy/5F/hnEk9hFRhH0ofXZXr3yho7CU0k9RQgyCd16dIuPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7xCIPId6mMPnMGgOdZGhsHMVUE4O0C65krc5+fVW74=;
 b=cngV7f2S8Cy2ag1z6RCUDdHhczkiYlfLNxVRjhmAhKhqNmQbPf0AvXPzrzPbBqHxsztnvEXyjboSCU8Cjr39IHQF0BZI2cNszzeCRRFM3JjCNsd9lgtUeBgMwPreZpDUqy572dko/NUsPj6m1JBBam0qunhkJ5euywH7Jjw9bQc=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS7PR10MB5901.namprd10.prod.outlook.com (2603:10b6:8:87::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.15; Wed, 2 Oct 2024 08:39:31 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 08:39:31 +0000
Date: Wed, 2 Oct 2024 09:39:27 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <85796e78-277c-424d-98cf-63457713c761@lucifer.local>
References: <20241001023402.3374-1-spasswolf@web.de>
 <44271477-0789-4fac-a649-75420d0c403a@lucifer.local>
 <76adbfac2a0cd1f500c5cc481b6e0068d11d37ca.camel@web.de>
 <aa6c26da-f1f4-4bc2-9b5c-0f682f8bc7f4@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa6c26da-f1f4-4bc2-9b5c-0f682f8bc7f4@lucifer.local>
X-ClientProxiedBy: LO2P265CA0332.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::32) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS7PR10MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: 2584407d-f5a2-4b1b-b9fe-08dce2bdbc3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ppRtWp0myRQjwmuDPCaNjGn7P6huxyHBvLmCXrn5NnkdFspDR0s3VKdbU2rN?=
 =?us-ascii?Q?jONNZA4xcNMrDRdu/w5hNyJ0vDgleVh8ZV/gERJVkAwC89JjSTdEZPMMs6fw?=
 =?us-ascii?Q?yvtAMZlFi5y/XvQtNslbQJsOig/dbL2x3tfTPYI9MUxwkreFE4B6J1q4qfwR?=
 =?us-ascii?Q?7kVqc74Fole6HVkcy3Mx5EYu/R/NuNCh0ExFR0+jbjMfzy6lGCwcVWfRZUx1?=
 =?us-ascii?Q?futY5JldQirL/OxiOMujQxvAfOUue/MRwDjMuOvF72fhZkGS9fwtEXuFcnMb?=
 =?us-ascii?Q?0LLQgyRpKs2rVvznHOzjEMFwzfs09I/d3Nm9Hll/xzwiPBGJTPApLpQZYSBN?=
 =?us-ascii?Q?4q22kLDi8CIdd1puSZaIU57wYzxbS0cGXcAIOUCveN9zxrXu6VUC8KdV0G0D?=
 =?us-ascii?Q?Efc6FHBBC69qBgtBie+Nfck4LliI92Z07ALuCivq9eqDphes2s6YSvGHY1Fq?=
 =?us-ascii?Q?Ka+lGud18yFq7qc7GOz7kOu2+3MZGl/D7u8q1+nT7GDBWF660uliAlOXcTkn?=
 =?us-ascii?Q?iFPvwrQryM0ey1Qnj50lwz0K4ItBuRU6wLe4CnBFuNGYWfVvkXa5J6DGMooc?=
 =?us-ascii?Q?L+EApVgYW3Ou4owtsrXw/Tvmf/LoYdoRHLuR6e/quxPHEPmyp7yfaDi20vov?=
 =?us-ascii?Q?rYDJAif3Vt/uNNVQNOHZ7kcAeC/8ar3Grp733Y7yGQhItzD7+JcOtPe63V7k?=
 =?us-ascii?Q?OCSHTyjH3b81URRnv7ZFgpJCmNxdlat3H/YoGGLoQPcbZYGnfv6ZyHpD7Wbe?=
 =?us-ascii?Q?gocHKqPyiy5gBhgeQr99v2ecATm3iaxdv3fTyF7vjECJEwob2aTDRx+iUSXf?=
 =?us-ascii?Q?rXHZ+jCmtyXmWKA1ncL0uNAz/McJAo2MRpxxUr0JjjU1DneloniIEZiweA8Y?=
 =?us-ascii?Q?9SykIlJioYQIPoel5wQB7GoweFFUM/ZZ2iemj3f+FqRNjQF3xyLezPw2E6BL?=
 =?us-ascii?Q?46QJdpcupy/eJMNR2y/8u+h5lgZSrSvjZafgt+wyg/ZcK4ygbPcr/R+HCqwN?=
 =?us-ascii?Q?Qybu2N+Pqc7taxd7SVlioXHT+xxwxi82vmnqdPqhZJ2hpyEu74nl/l/4V0ds?=
 =?us-ascii?Q?VHQelNSGcD+UfFnqouRquSun6Sq71xFvLsLkWjUGLZ3iDHonddB//QASqnNT?=
 =?us-ascii?Q?ePyMPolWomQrI5RLI/7hhU0Baw4FIT7xSAWvs325d6H3OlYFP9RPw50DttNL?=
 =?us-ascii?Q?DCHIXktN/cgXOLy+UkMUwDs0d/arBddKc/cr/RXXDu+IOZktnCT8J8bzxmRz?=
 =?us-ascii?Q?eeQES3V5pYTpKwWzcpXxKAue4ujTDEV5UuUzVrfLjw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tOmn8aSyWRXwRNwzPTE4sjObIPbfpKPVfFbZhoSgIyDc7vHAm+nyLK8k62iw?=
 =?us-ascii?Q?nf6SKxrUvg0AcO7KvKln7C2Vz3AE5n828xbQwWpkFsFvz1Fc63ZLsHMVVRBF?=
 =?us-ascii?Q?M1u3Z/UPBsJYm3vUTATc0fNAjUHaV4BMJTxQdJeChhQdHjXah2WLie/i4b6E?=
 =?us-ascii?Q?595MUeqs8N9p6Ur0w3F9y2BAOKlTb2guMgJ1JFNfEJH8mIRXKLt3pjCf5PTQ?=
 =?us-ascii?Q?3WawwVrn3cEKC728h6kKJpHe4tRRsbrSmJuYYoMVk3ou15vnJFKxyKRT81Z+?=
 =?us-ascii?Q?vXQCTRxGC+FAjN8ctj6vpcMsvqfgptxjvtgGmkIrhxu1zNAh/iMIzyZBH3A7?=
 =?us-ascii?Q?D2uitYMJcFZ5Q5jBT8PVoakTP/GLfXRtvMtyqVmP/V/v2lhXfryuGdQ8syD0?=
 =?us-ascii?Q?yWuKM8IMs2nwXY7CKMlE40zdcl89Rdl2SFthBvWKNXBHaA3BMqTIQS7/PPaX?=
 =?us-ascii?Q?P0PSPGE2mv2V3H8JHJDfYQ+YfafRYRylPc2M6/mcpN3NMZUTifpxEILeNz/F?=
 =?us-ascii?Q?QXsCfIb8DPMLeWgcIdh9t/oFpI1DVcYYZylAx5IoZ+qJDrjL0OqpPiYoD6sV?=
 =?us-ascii?Q?h1jpICm5bcbkKjkB5wVm12T2ansrTQCMOYCFWG2A73f8PZSv68pE+paVMPp9?=
 =?us-ascii?Q?Sa8aGBHmiFbHtXSnRkRScI+GGKXh0yNKfAAcWtPtWwhNs3u9IFLhVMnphGaS?=
 =?us-ascii?Q?NGGsLOiYBu25LD9DfdOhijgHRgQJGR59ooJoJj4+A+vTr8EI1uBX+6KoVx+1?=
 =?us-ascii?Q?tNwiW1Nabus8kGvejKZ0hQIoUcA1APOxIaMmmK98e1zsyJYXeX5AgfBEtTUE?=
 =?us-ascii?Q?oBWr10L1KO24KmdnJ7pKq1+M7pfaI9Kb4L24qdWX1/1draf+9toBSIu0fiAj?=
 =?us-ascii?Q?1hsLSlX3b0v7cllWvm3Z8HTVRgaitz9uKt5C7t1MPpEGdO9g5T5CVbygq7rm?=
 =?us-ascii?Q?8I4vK2Uv5OmZPabN+UyBxR26OqJstiCCqbdGWoatTZkmY/SrlFlsDi/3aO58?=
 =?us-ascii?Q?WXD2bl6LlQ940g137XUBXUZcPdtfzMxhX4XV8kPGQo8CGJFUZ1BD9YYdN/a9?=
 =?us-ascii?Q?WnNT6vAzUUoe3OA5fOhMt4+BorInLxeoJn2E9Hd85gJTMkNlKnhmDr66LEiM?=
 =?us-ascii?Q?mlnpQZOt9cIpJk7xEAqjLDpiU2ucXUahZSdlgIT7LKobw72PXSxKbZg3Srh/?=
 =?us-ascii?Q?vf8V0qp3C7LoKpCDPOi5ZCy+kUwOIpqkNJvmpmM7rD5Il17YvQzZYgc7Ol8i?=
 =?us-ascii?Q?jZCvyLCG1d/c+l7IXb8VlQaPvPk6DOXJJAi+BWUFKXzxOTms0qhXdDbIFI6s?=
 =?us-ascii?Q?QQNu9DVKwe23zDgUgfW/czqjZsYgk30rT5mweCln2Q/BJze01oojA+WCINDg?=
 =?us-ascii?Q?Jo61Hn2PHjr51F1VN9PbziBdr7nHyOnR5WQIWSEMaucSSdI4VHO/tvaYRRc4?=
 =?us-ascii?Q?MxnJ+CVAGeLzAWoSNzW3270NNm2BVFptXLcRTsRNtyfrcFgKYe3RcBl1AyV6?=
 =?us-ascii?Q?mHdYYJU6eOz3zTLBYIi7t099aptY0Xp30M3RI4Gd6sv9X+KhPzSkW46KqnLo?=
 =?us-ascii?Q?RX5GwHPDOTTFdv+l3NjF3gBVLTSfk5+sdsoh4hDNR/yhoCTF+ClrC4ErglkO?=
 =?us-ascii?Q?rojGmE9n+2ROkmiKBH/KwpMvbi2HeXEdgvEhatgmyPSkVKmV1zecP9TKW2Uq?=
 =?us-ascii?Q?huDSQg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bcAm00UaUUs15Jhjr4fIdz2le+d/RAGUqNhG2ObaJvWsVzmowAyZWcJB/jZ8/U9eCmraK3sHkfLsguoHUsWP8RmZItUsIvfjYpkkAE5gTcaY2WwFlpYPvMV356Npk1kdA5eyvhVEmxh45TtPNFGHpmuK/C0AMUDXxgZdV5aHs0HDvHnoxgn/oQzfsHGRReghgxwC8u0S6cNxtyXR92QR14vmpOVVONtGkOC7Cvxmz7Iv8gKK1ckd932At3FgjzqBDIzP5HqgkdI/UM9YEuFna//3fmjMfx7KvVKXxS8vWpGxK2fPYqyvQvfebXyIw3fmQs0ALO0uTWtwJp48CYX0Y6Jn7blhUwfEqdTu33F2TFBn19kfPavXSkYHgUbVbnLFTPE5qvQoGc+HyXF3VhjYGiqDdvI+rC0dooJ7/hLU/pHaTZ9euf7YTO5CXOnnQTf7f+w2pKSOIp1m7UtH7D0umxw/IsAuIAi69Cyr7skRqE1sptkXZHRY1fVnlLgpGRxa0XazR3UJTrob34lpT+PfFWL1sNvlm+slV5NGNWmWuB6m3oPYCQcd0rZNoLHgUi5EWk6xtNKpmNFhMtT8uiUg2WfB/jXKYQEl/ux15O90uEE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2584407d-f5a2-4b1b-b9fe-08dce2bdbc3f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 08:39:31.5589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYT38oi+oH83LvGuuWF0Cids4Pz/Sn2XXcIHl/ScnnUhGnlVWpe9GBMgPpgErYNRiWYEzyGd5M8wlDHE0wFrVOi3+YvtT+TLHjZE2jo3Qkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5901
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_08,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410020063
X-Proofpoint-GUID: WJ46N73sgYRXax7nqus3K4kx3Z9_lkxg
X-Proofpoint-ORIG-GUID: WJ46N73sgYRXax7nqus3K4kx3Z9_lkxg

On Tue, Oct 01, 2024 at 07:01:41PM GMT, Lorenzo Stoakes wrote:
> On Tue, Oct 01, 2024 at 06:43:35PM GMT, Bert Karwatzki wrote:
> [snip]
> > I applied this patch to linux-next-20240110 (it applied cleany) and got the same
> > error again (Andrew Morton asked on bugzilla me to put the logs into mails):

Hi Bert,

Could you possibly apply the below hacky patch (again using the 1st oct next
tree as a base), and share the dmesg output?

Hopefully this should give us some more information and test some theories.

Thanks, again appreciate all your help with this!

Cheers, Lorenzo

----8<----
From 36c5c148580c5aaf93f0f689c2c3de36ff62f1ba Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Wed, 2 Oct 2024 09:19:28 +0100
Subject: [PATCH] hack: mm: see if we can get some more information

Add some dreadful printk() hacks so we can try to get some more information
on what's going on.
---
 mm/internal.h | 15 +++++++++++++++
 mm/mmap.c     | 20 ++++++++++++++++++++
 mm/vma.c      | 11 +++++++++++
 3 files changed, 46 insertions(+)

diff --git a/mm/internal.h b/mm/internal.h
index 93083bbeeefa..cd9414b4651d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1443,4 +1443,19 @@ static inline void accept_page(struct page *page)
 }
 #endif /* CONFIG_UNACCEPTED_MEMORY */

+static inline bool check_interesting(unsigned long start, unsigned long end)
+{
+	const unsigned long interesting_start = 0x1740000;
+	/* Include off-by-one on purpose. */
+	const unsigned long interesting_end = 0x68000000 + 1;
+
+	/*  interesting_start            interesting_end
+	 *          |--------------------------|
+	 *           ============================> end
+	 *        <=============================   start
+	 */
+	return end > interesting_start && /* after or overlaps... */
+		start < interesting_end;  /* ...overlaps. */
+}
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/mmap.c b/mm/mmap.c
index dd4b35a25aeb..0ed27e558ebb 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1341,6 +1341,18 @@ struct vm_area_struct *expand_stack(struct mm_struct *mm, unsigned long addr)
 	return vma;
 }

+static void ljs_dump(struct mm_struct *mm,
+		     unsigned long addr, unsigned long len,
+		     vm_flags_t vm_flags, bool is_unmap)
+{
+	if (!check_interesting(addr, addr + len))
+		return;
+
+	pr_err("LJS: %s mm=%p [0x%lx, 0x%lx) [vm_flags=%lu]\n",
+	       is_unmap ? "munmap" : "mmap", mm, addr, addr + len,
+		vm_flags);
+}
+
 /* do_munmap() - Wrapper function for non-maple tree aware do_munmap() calls.
  * @mm: The mm_struct
  * @start: The start address to munmap
@@ -1354,6 +1366,8 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 {
 	VMA_ITERATOR(vmi, mm, start);

+	ljs_dump(mm, start, len, 0, true);
+
 	return do_vmi_munmap(&vmi, mm, start, len, uf, false);
 }

@@ -1375,11 +1389,17 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	VMA_ITERATOR(vmi, mm, addr);
 	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);

+	ljs_dump(mm, addr, len, vm_flags, false);
+
 	vmg.file = file;
 	/* Find the first overlapping VMA */
 	vma = vma_find(&vmi, end);
 	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
 	if (vma) {
+		if (check_interesting(addr, addr + len))
+			pr_err("LJS: mm=%p First VMA we unmap is [%lx, %lx)\n",
+			       vma->vm_mm, vma->vm_start, vma->vm_end);
+
 		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
 		mt_on_stack(mt_detach);
 		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
diff --git a/mm/vma.c b/mm/vma.c
index 4737afcb064c..989ea3ce366d 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1202,6 +1202,11 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 			goto start_split_failed;
 		}

+		if (check_interesting(vms->vma->vm_start, vms->vma->vm_end))
+			pr_err("LJS: mm=%p vms=[%lx, %lx) split START of [%lx, %lx)\n",
+			       vms->vma->vm_mm, vms->start, vms->end,
+			       vms->vma->vm_start, vms->vma->vm_end);
+
 		error = __split_vma(vms->vmi, vms->vma, vms->start, 1);
 		if (error)
 			goto start_split_failed;
@@ -1223,6 +1228,12 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		}
 		/* Does it split the end? */
 		if (next->vm_end > vms->end) {
+
+			if (check_interesting(next->vm_start, next->vm_end))
+				pr_err("LJS: mm=%p vms=[%lx, %lx) split END of [%lx, %lx)\n",
+				       next->vm_mm, vms->start, vms->end,
+				       next->vm_start, next->vm_end);
+
 			error = __split_vma(vms->vmi, next, vms->end, 0);
 			if (error)
 				goto end_split_failed;
--
2.46.2

