Return-Path: <linux-kernel+bounces-210388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9025904310
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D2FD288AA6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784B47441E;
	Tue, 11 Jun 2024 18:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QctTmyc9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jc1l9UvA"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B235BAFC
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 18:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718128952; cv=fail; b=gUzGBvCTeDGgt0+QtzU0iL2u0tavn2TCXtbtqcK218TFIQDgBBIH3buS7fjHd5gKVh7zUC+r03RLT7in2JBPehrrLEEh/i//AWBra0+ifkuFgC3xl7Sa5Sh9GzR9kegy57S0Odjaj9z/nfEwuvLSrvdwC6vFAK3JphGvgj2uq4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718128952; c=relaxed/simple;
	bh=4VUH6eOcgj3v50+VJYmKRW22tvtCdaeUnjLspnKbGOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TlEmqS/itsTXWuwXKUg4BmpYTXdeieI8ZhA8iw7cGtVQtcVi4eWa8W6n/5sbrTJQCJzZ+c/TFd8KUBxkyVHjNzaAMhN4b+jWshVF9BAQJex/Lo/lykyQIkFr2ZXZEb9nsftKqf9R1WEw+cY3FMRHR8/c8waUdaA3LLVbLywq5YQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QctTmyc9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jc1l9UvA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BFpgU8011740;
	Tue, 11 Jun 2024 18:02:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=yZtNmjgp45nBvcrKWhMfvI+CwKTBuCGsX2QgazNsKzI=; b=
	QctTmyc9D8VzkrnJ6Q+WBC1AGrLbtMDmGcpjO0fyPdSmW0+OdKMtjRtj7D1xOeMc
	szq1E9SZHOML0Aiz23R09RJs+u6z9QM8JAUcDOPRTjB/7EeLeKoHe/jKw3N3iALi
	qi7H2qNmDWKuKodGGpPD3Bvn7jqe9UoqnvXlm4qVtK5OWqxgQvVm/XCM1eB6lbzR
	OcTf418xYaSBtRe7NmUY8+zc/eiu6s+08MLQwQ5mikKHKxiteMUtUhnFLnQeDRGc
	u+JMKaeZYddbzBbcdm8t/x41hm6LBSRc5IbcHviS0CnjVoda5arFxYcnamzfEZ3H
	eO6ijbYftJxmaVm1tDtmaA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymhf1deq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 18:02:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45BHw49x036562;
	Tue, 11 Jun 2024 18:02:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yncdwm7x9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 18:02:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKHXFIvwp3WVGSoLYjWqtzhiBZk0JPqKeZUQNmYD8JLx593Uj/oGXTFDsOnHaaBa3R+rcbMADd0lisbBV0lHTlo+bGd5++vR0mOZ8eT7QjjzmlRfYMLpu897u84Yiyacy13++QEF0qJ6Etb5PDn6V/1MnREQOe1JNqdrOFDMh8EJGC6U0T7Um+H98u4PC9lmptV/Hl92OBnb4/qVzEti+4ZhHDzLMXwMsUF6NuBGYTBlTerFR61l2JvbJNnqvCgJTCBaipgzTb1p7KHr4UzwbYACltlobjcvHBtHn19tZdzuIaTXC75qr36YRgb9ehFxiFr+SIiJqSVyzr+KY/Em0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZtNmjgp45nBvcrKWhMfvI+CwKTBuCGsX2QgazNsKzI=;
 b=lnA3HkaF/LXGap0FlNdKVGQJorgMuZUKtABTCQ+1WFhVMkOzCU5k8CehyKloQpHsX2+pamNa8OCo6yWlmTUwThaKWQgBKCOeGTNbjquE3DJpVRBo7t890ND1IfZ8eCNovA8ss3/Fvn9rO8D6F7B7E8SXkOuag9OunpoEb7Fgq7rb/woGFSknhAtSO3HU/om60Ze/hP0ZGHf7Pxd4lbtDpG42NYnVAZxfwEf0RZE+jNf7vAh3nTPMOqXvOkrVUXk3tkEgQtsemJhfDdUyROfAU7WoQUKNc3NO+CFPQOmcgaOdZjHVkemMlYwrmN0S/2WxCcgbXNJfnzfPnqcxIIZdxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZtNmjgp45nBvcrKWhMfvI+CwKTBuCGsX2QgazNsKzI=;
 b=jc1l9UvA5dbMfJ+GSXNWdHPON01O1OLoVpM8i0HvZufnClhnIZPMW3JcDnS2mGA3p4oK2OEBffW2rIno/l1soL+2ht6awEPy6IfJXoT/e9ztrYd7DH2nTwwwuXb+Mu+h0U4P4GoD4sWWgFAObggmLYt1jvcq186hprYR1si7NaQ=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH7PR10MB6154.namprd10.prod.outlook.com (2603:10b6:510:1f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 18:02:16 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.037; Tue, 11 Jun 2024
 18:02:16 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 1/8] mm/mmap: Correctly position vma_iterator in __split_vma()
Date: Tue, 11 Jun 2024 14:01:53 -0400
Message-ID: <20240611180200.711239-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611180200.711239-1-Liam.Howlett@oracle.com>
References: <20240611180200.711239-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0365.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::16) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH7PR10MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a0cf05f-4e94-489c-1895-08dc8a409f3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?kiKnC013rKU4iQ3z/Vm8ELBaaMVJgNfWXi+4tdWa5USO1q+D6iQUmZtTH1to?=
 =?us-ascii?Q?edS0GuEOpYdGiBRV4LvWFKF9uDiznu9RrHMlf78MeMoVAErsGXEZ1wIQSbDV?=
 =?us-ascii?Q?b9NirQrzDBK1ZXSsywBPlV9hVV6jzSkV5r0kmlSOTiob/4zMo9q9uCNQnQ4E?=
 =?us-ascii?Q?aUnZFw2Ephyj6Drjlc2fTbmfolduPTP/ZHlEZKctpGRrdPFT87lUrYrsGK47?=
 =?us-ascii?Q?8l2U66gP2LjbawHXecHIqmL2PFsG/oHjr/Sq7Yvcm86nBcLtIrS5qa1J7CMj?=
 =?us-ascii?Q?jhQNaT6VcWAA8SDGnhaGfdwv3zjYWO1Ro3HrfQLAPMut9kFlCa+OiX/VTmCe?=
 =?us-ascii?Q?P5DRdCuuprBiunUCAN0VA2JPqWLUH9tA4rIXlL/WPkoeaTmzweYMubtfBF4n?=
 =?us-ascii?Q?C/Yckk2vLvImxAJGFEBQSGKinUna10eCvi5lNIHO7rF10ZAsHGoV4eRFZeWm?=
 =?us-ascii?Q?afVtnsDXHEqT0AyUgFzzQyPNcTFAfPo0HY4g6iP6/NnVLaiDptGX0EwzTXDV?=
 =?us-ascii?Q?8MuGSnryMRhLTTimMzcrDY61ad3mW0e+vqLeJcPrA0XNf8FAlBX7e4zW+SJY?=
 =?us-ascii?Q?Qw2wzVEEWKsOqI+jkT/7g+gvHGrJZhzo17q8vlFG2CxkYGPJox29NPl8CYn4?=
 =?us-ascii?Q?VpbRgtgwiavxXn9DpVPA7IyjcVMGBCytV4UfZFqRWTAGeSa3CXxKlaZrBBH6?=
 =?us-ascii?Q?+cNfutpfVwfHzLpbehrv1/rexwGq89OwwV/356L2lQgMagyyssyYyVPsGauw?=
 =?us-ascii?Q?S3LmGUUqJR2uFr+kQiBDmLosbsi79WTTc4vzFX45fN0OrJJtLQLTadnhXf38?=
 =?us-ascii?Q?6yDSlB4gq1MGyN5/9H4VP7DdIDNittAttfCWpdyWMu/Y77E2wa4Lp3elqv2c?=
 =?us-ascii?Q?2dvRSJlgufpzTpMN7BvyjvI8ajLVJYI48XsJ/BqT3u0mMd6eitg9EmRmRctT?=
 =?us-ascii?Q?3Hg97ecWqgKANsb96HaGQmFuLmuePqcUkNiugF0G3MlroHPDgVZzRRm96kol?=
 =?us-ascii?Q?h+SgO8AOgx3cTVn+D1zSNgsSDb0NsKHtjk8MCmu2/OaHQ31i6m3Z5FpNbIgh?=
 =?us-ascii?Q?JgkdmUkOYAmtjOO2tT/OapJP8j9IZpWvXd+uxhDj3Hp96Fr/F2RCsQoKRmCe?=
 =?us-ascii?Q?okWAjKlYC/kVtHsBkAksz/xmHbzmkdLQlbqh0AGT+YPfiSMyOUvO8GCBRVHE?=
 =?us-ascii?Q?0XUG38mdbAWzBXxo71OF+NqmBeagX7LbOOo1zMxuGQlgZfS/12UN+MJ5dvmb?=
 =?us-ascii?Q?vLDfcYeZIosF+chy61URV+ZKrBwGcXcUZxIsnOvPMppxmOKSVaTtbEXmgP01?=
 =?us-ascii?Q?Baz2omujk2XfTyFq81OYvMW/?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dpYhx8LsRli+OZEUTojdC3v47BLOqRweV0dccCC54CySJNTE6idx3rpYBcWA?=
 =?us-ascii?Q?7yc3eLVSEKwifqOoZl/zQa9NEfJVJd5EHgPHF2XOavnJrdWNNOjyY5XPz+ZE?=
 =?us-ascii?Q?HQRt5khQTci+bC6Gnz1v5yhFhdh5Umuhk4d3V0PmWHi3VE4m0GHb7r1Eewms?=
 =?us-ascii?Q?DqHbjc0DJ0W15hr0sqyNPwjHdur1uUUtvQ5hRUuUTAvq6yoCGKBbpuMHBaxI?=
 =?us-ascii?Q?XR0vhK62BH2WTj/04teTMzxgVlG7yafyxgnMjFDhhnZJVVmlRBygkwcXbuEL?=
 =?us-ascii?Q?ubw7XSf47Guby46LB56KSf4CoTHaqyegJxRU+yluarAzaYONwRJA58K08mlV?=
 =?us-ascii?Q?5PmIzolNilHg9AKOb33JzfP8SbKvGwf0mRi8OtsC3XQpF/VYy2RX6XRGfxYS?=
 =?us-ascii?Q?kbOGZeZ7qSGlEdeI8no6+8IN/7qUyCA0iQ3/TKgCDm/pXF5lWrMUc3FZlEEy?=
 =?us-ascii?Q?td0IKeE+tV62g2Ra5mjvRiyilk8/p1KM8XVZ3PO+BGxIrHSTOxY6cRq6tHm1?=
 =?us-ascii?Q?H3l2Q0DM54/TzMgIl2ZIuKfI7W1zOS3fYc10r1m55KcARay85DGI/AMl6E79?=
 =?us-ascii?Q?ize4ZHXajtnMkFvs8vAMuCHCON7PpZ/G0CoN8uI/P7LHdqPB8R7jXptNr3oo?=
 =?us-ascii?Q?gc8uMuYdMUEbncPTZ52ttwLdbp9WWmTm+WiheMI2WifMjP4bCrjvET8Ywroc?=
 =?us-ascii?Q?+9r+pKUHuUCYyXwfPn2SkkCV6lJEFy6EAXm9PpdrdurIzuNKMNg8jHIMrZIK?=
 =?us-ascii?Q?FEA9BHkCpq79sRAA+Bzhs6ikpE9nvbqYElyjTrWf87EqX1UGqSf/lY1nnHpM?=
 =?us-ascii?Q?8tTpwdUp9b3FfNwK5Oq/ObDcRhllwmwTYy2N98L1Gwd+KgmDHS8PtROvfj0t?=
 =?us-ascii?Q?U0zCME/DYictidRzldTjI/vDgKzaRU/hbnJXQbvdvS/VZjQbN3U4DvMV1VQb?=
 =?us-ascii?Q?Xk9zOtjK1F0db1QBd8fQeCBzyjMo++J7bL1tP52KcvKeftbpDJDNFxILwrea?=
 =?us-ascii?Q?xn9B4lJpYNi1FzofCtOznxpRDwqQT9kPNy3INES59m5ocMwMM6lwYtV7gWb9?=
 =?us-ascii?Q?dHNxFmjJWZ4YIiN2wQdTr1HtG3v2muKEgPqCvhZwCizwW6nUAiMms6pjD0Sa?=
 =?us-ascii?Q?3WKZ7VL8wGw8PQLSkA7kJskzUwXlOMGj9jrF3fdCpw10SAtgmbfumdR5CHBf?=
 =?us-ascii?Q?SBV+BUbD61A3LOdemmDJnzDwNvcg0EBez7B8LhpK7+YpLNJH2Yn9dWuqssVD?=
 =?us-ascii?Q?8bN4y2Pdm0ozpuRhOZiX1vrsHaqNyLhB/1WZJpt9fIkqQHVG/2hxbAdr9ui/?=
 =?us-ascii?Q?lsKRjYfH/4x2jfAkQbsEHTSBUKuvh/7v/mMrwHjFDLpkOCVcvK6ba+r7BuIm?=
 =?us-ascii?Q?s2iMtMzYVxhbpeSyfQ4CQmvyq5pRuwnWBVj370tXJscbxG+1F1DJqazdU9G2?=
 =?us-ascii?Q?BWNrEUD4PIutnpEcUXSqeofyAHgOK+QjOcTNQGYkNUTPvYnczlYZD9sZNNx2?=
 =?us-ascii?Q?4khszwDAu/eAKSBvnBdbKfbAVmbIwtsD6n9eqV7kVpbHBisAGbPxz5rxTk1H?=
 =?us-ascii?Q?p0nY7ekb0DcQXwd1UIzR7Kz3qn/hUWwbphxKzCyj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	FLuxJIL3q5BbyvwT19+DI4s0L/p2VE40Nb4rxY76PZZ9h7ClvwF4Nks75J+J2Snc021FtI6m9jTNJF3LtiB40aOMF5Z8C0wrkwSscLicp3051lC1Rpv0BDPk/O1C+L5fBZOK2vfLCNhkiHMTtJiTSZyFyDk52U1m6769eneWPIjjpB4uqmg76NH8Z7+od2eKAN2axJzxdj3dLaKMhfinKxiAx711zImTlCrtuTqO7GdSBl3WVImkF4NKnw3ad/faCIOWyvPYN+jbCwEnEgwiio7o/CxMo4mmIdHbRFF27clwFe+uplay+uuLYNIocpP1tmedWhHtBlEtvwvwIk1wc/soFWzYmkV1Cq3hHAPIg4isPmtEBot8QBwm4lIjkfPdZkFzhzWkHR6duLa8Q7cBVc5n7v0krHx+OdbGg2TkpBpNAltxZWJRQMwRJD9gUP+weni+3imuAqAa1k7XCf0uX/zc0ONnfLHxuILeYplNQTa80DDYG7FJ/ceAiPvQ5YRvEbZrrg5UiJpAogarIkmZS6L2VHxiEvFuvdsmbu6k3lgP0go4ouHGRIyu3PCHxTVoLWzPI5hwssjJFWP9KpQH7Me5SIMplBpJZkAzWDWZa6A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0cf05f-4e94-489c-1895-08dc8a409f3c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 18:02:13.4729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQH+QAVyhJx92e0WPpndUkPCkoJFKb5x2KD0nbegZKbEKlbrAT+65U4yb4riZKpS2kh+MBruhWtckb3hvNqzbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6154
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_09,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406110123
X-Proofpoint-ORIG-GUID: 0BLUpLgXEXAEoUgB2Qwq4M8O7IMkFslZ
X-Proofpoint-GUID: 0BLUpLgXEXAEoUgB2Qwq4M8O7IMkFslZ

The vma iterator may be left pointing to the newly created vma.  This
happens when inserting the new vma at the end of the old vma
(!new_below).

The incorrect position in the vma iterator is not exposed currently
since the vma iterator is repositioned in the munmap path and is not
reused in any of the other paths.

This has limited impact in the current code, but is required for future
changes.

Fixes: b2b3b886738f ("mm: don't use __vma_adjust() in __split_vma()")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/mmap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 83b4682ec85c..4a9929bc18bd 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2373,7 +2373,7 @@ static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
 /*
  * __split_vma() bypasses sysctl_max_map_count checking.  We use this where it
  * has already been checked or doesn't make sense to fail.
- * VMA Iterator will point to the end VMA.
+ * VMA Iterator will point to the original vma.
  */
 static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		       unsigned long addr, int new_below)
@@ -2442,6 +2442,9 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	/* Success. */
 	if (new_below)
 		vma_next(vmi);
+	else
+		vma_prev(vmi);
+
 	return 0;
 
 out_free_mpol:
-- 
2.43.0


