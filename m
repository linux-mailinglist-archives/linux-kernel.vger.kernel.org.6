Return-Path: <linux-kernel+bounces-255616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2799342EF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D0E282DDB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFBD18757F;
	Wed, 17 Jul 2024 20:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K+C4GbOi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Jo7y10DN"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89351862AA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 20:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246866; cv=fail; b=HVuKwUD5xFLo+FSh+/9kkAZcCSMdkm/ayu+aiuRCiJdk7928roFPXlUcrxEogsRVnX6zs8L1+TwWORjsKqrnzJIMi37xoVXzVd9/qLFzHH85G5N+2C02MaYP3bacvkIkQHl2KC5faGSJMMyVPVySGmCGD1CAZPj2aj5QlAJaOD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246866; c=relaxed/simple;
	bh=z9lPIBEB8h0tkNv8hatUxAW8h6cpl1NOiwc80r4ThwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cK02M/sAB4BZeAKMQpuw31EZBBfdL5O5zRnhM0sj3mRo2pnI4lzWT7F/7+RFo/lIeNkyRgdoceOm7WaNYIBRl/vyYVr+AmIxmVG9xu0FOJhIHs3yopsh+tBzLgwz5XKrD+KtU2knLgd+e0aaeMRh3u3C8XTNSDtWGqmu46uarH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K+C4GbOi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Jo7y10DN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HJsS4o002470;
	Wed, 17 Jul 2024 20:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=W8ePtixmHK858Jxwt740eyTinrn/Sv9QWh8NJ5u4sOE=; b=
	K+C4GbOiFPwZABIXe6mNL4Jj2ProPb7If/OMOLVqRm4iK37LL7AWbqmB/BkEtdsx
	nnr++EJG7g+X5jajgiAU59pKcXQ4Xl1gd/H0ZwAPw7ih0sO0amK66AU38YF4b20O
	mRITla0mPjiffuAyGvNaTBnJ1SgeT5a1KgYRFpYh2rwFkxeNMHW0RALDAlvjxMGK
	eKNZKKpNOlvFv+HSrF1VRhfdxlgmQ76NwAXtt7b85BbhKdmH79Rnl9/4VWHqsNEF
	A+oL8+NrwBCHJqM6TRLrDzO1gZlWjvDUAA9m7PKgLAuNGs7UCyM11JyWUPUTvTZd
	OPeGodJ87CjsgnGwSuhaKw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40ekxy84ad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46HIrJXm006940;
	Wed, 17 Jul 2024 20:07:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40dwey1fcb-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OxTaIv5bbHkEP+QPEjkwA89YUI3b462E4bkQB3AXq/EG/wL38L4QxO/aYXi+Cm6bm6iwPAIDyOJT4QS1eDuWEa/Nt+7ugOUftNK1IrxiWAgTtCXAD74bfPHNKIl48gXk1tdZ6ZS3KymAJzRpfAc0wFIV5zq4mjMh5UIsNJXUSRrJp2Cx9o0Ctssej+D3FkEckFqrD8+p3OxLctZwcM9kHF3AESnF1VZUGAXILXrp8oMnS6tXCvvmAacxNwCZahrAL++Y12LDWld/93yb7VUEJdZ8nOn8qgKcp47rFFBbKYcnj9cHlL2KrT9+UmbVEDbTMRhR/kHw1j0fymmGVuMJxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8ePtixmHK858Jxwt740eyTinrn/Sv9QWh8NJ5u4sOE=;
 b=fUqcePQA699PLBbstItIrApibdNVUJw8xQywwPCJ9HmJkMHaCvK6yfPkwJoFUIQFmk5xLVfRbddm9/KuIneCAfwYHIoINThzqFy8tRTD6+S4dwFjNlpzG2X0ZyZ4hBzAlnlwm+2Pjub2ab6tbqATjtdvREPYGGpal+RGdbIml03CMbKSFFIrcHJ+bigFdqyltywfwgEhNvDrv+uhtnpbh2XvJemb8GPAu3B/yXe5ikxqDzF3g/o5ha1HQzRnRS5XMBqNHlCSoJQz4rD+PP5WaI7Y7KnjBgrZxE2Mch85urLa8CzFV33v46peoZD7aCh/Dlb5VejBz5E1ebqSmwCSTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8ePtixmHK858Jxwt740eyTinrn/Sv9QWh8NJ5u4sOE=;
 b=Jo7y10DNg/DAcytYUYDwEf2KJe3Oj68yPxN7I3X2sResQYdR/AI+QeLgNnKc6ImhmAoQrwpMg7WjrNYlAVJce2J4VtIn9cggUYrygLUAKK8aflszRmkDqzGfPtMacsLCYuglcqsF32pntpc5BMRGgyp0i0FiSMMuVxAQ0TvTkCk=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA0PR10MB7303.namprd10.prod.outlook.com (2603:10b6:208:40d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 20:07:24 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 20:07:24 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v5 04/21] mm/mmap: Extract the gathering of vmas from do_vmi_align_munmap()
Date: Wed, 17 Jul 2024 16:06:52 -0400
Message-ID: <20240717200709.1552558-5-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
References: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0071.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::12) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA0PR10MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: ae453853-f68b-43fc-9335-08dca69c11bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?nPIxEncZ3rO7iGQcBmwGgwhcCQWPslMTUDfRb9zuOJY58FEsJbWlq8DO5Xvn?=
 =?us-ascii?Q?BvVqSI3chw8LjfF8+jSWn9enUJdAQIchlpmku0Nqo6+t7dUUBSQrg0oHsWWU?=
 =?us-ascii?Q?GEENx/LqqxxmxyA42i2KLEQrF/Cg8b05YCjs62cc4Cwz9MsFy87eBWfhezWu?=
 =?us-ascii?Q?V59RFp/PvEWV7oG1O2LRpHzmCxkkgNZQf98dd2w99xdqMSZwpCz6D5mfXxW4?=
 =?us-ascii?Q?mUAfK34E7w8Rs0Hz6XlDrf8CB4hRbRKetCp4wnTyItDB4IlvGoJSEuG9+B3o?=
 =?us-ascii?Q?9EOmv1Dk4GDYJiWPcoxFUQUlSvyMr6R7gbk8tQFQuzKpnvbq6yEhPcV36vae?=
 =?us-ascii?Q?wOj1bCXPddKh3R6XrIX/Y/pVoRB7Xo7c445waePayZTvo+JY8ykZ+HzEpSF9?=
 =?us-ascii?Q?7T3C452rpjwoSjnVCnG3iLOfC6/DDfyCpopTQLbDyBg2JmFOyq0nSlnzrKkS?=
 =?us-ascii?Q?GC4qmzFzJ3EfW4gB0wnPXksGxCn0M5z+XE0nmatiigtTlZu+hSKrRSc2OuCK?=
 =?us-ascii?Q?PpiAkbLRF114p6dZq8pFaDezFqWBdFswtYPoBPhmJhE3iuKL59zqRxc8qkNM?=
 =?us-ascii?Q?NpAV4kjYf1CH0xY5T8QdXRGz7E8WGbviPzmIVb2bEiuy0TR55FLabu436qct?=
 =?us-ascii?Q?2VcRETOpxQfoAi4afEmAAJ6rG6pV6301i0ALS8p4phxyo+Bn42S9nNTgvyP2?=
 =?us-ascii?Q?c4TBzhCYKJ2rEgA3uMnhXHAjT4pazcZeFNWlXsIBum0CeJEES8aUkvCoFtnt?=
 =?us-ascii?Q?+A6N10S9PjqMWtRIXUrSJVOTHF5nG3evZyDnbYq7TRBEWG4w4diD6jDfz6oi?=
 =?us-ascii?Q?DnfCR8D3WXppNmtLAvl1xNUVejxkmsUZduGWV63qGkkn0CxVM39MQ5z+95lD?=
 =?us-ascii?Q?DfxPzT72xJe1K4fVsoxDRvN+3bvGWOIloUjsdhEf6pkhNwkJS2XzS8xivv4+?=
 =?us-ascii?Q?3Jf++aJmpyXWVfnHNHePbAms8Su2QruHT5MamTwrZ7lOWBw+TDCvA8Hu74F0?=
 =?us-ascii?Q?cFhKsiR3+G741Tk8DyI7lGT40uFYsoZlgicdEAodsBLx1dYpTEAy+D6fH9nU?=
 =?us-ascii?Q?jOwmLC4BLpxnTKdSYR5XfoEXjQUJK2ldFhjMo7kHrDNScz7zP9mE1DD74448?=
 =?us-ascii?Q?JsxYCeDXy3NsFHhPyq3HJt1Owz6CyOBfjkU7AmiNpBtDw1jfvimOMtO+2hpy?=
 =?us-ascii?Q?XPFE1/Tmk4B1jIgIRh/feOSimmTHJpzgz6Hgd2X15UwE7GeOvEo3hxW6rCjt?=
 =?us-ascii?Q?ZOy8wp+YAi2iBMGKC/14/MYU5/fUo6WDHs/+vmWz9zPWW7dB6pSoHzsW+E8P?=
 =?us-ascii?Q?9uZURj5I4X8uBoMi0nY/xcqhAkjGMWJhItym4LmDpxB2aw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?a0tHpNWWlTOjyAIsiF+b5cwOWaMNq6tJ1HAych1wkNhTR7ZcpfjJj2876ui6?=
 =?us-ascii?Q?3QCCfcJBEXhEIhJ0D016t5hEfeibGKYVMEHeO0MzdiLbazbtzBqOaTBnWDuB?=
 =?us-ascii?Q?VBZYFpGlcjkgSdz7oicC/u7mYMqBommIpgPClGgZKtWVQ/9taGAvPwrzXY/4?=
 =?us-ascii?Q?bAt+DejJGfqN6dnBsZ01q2ytPtgtd7fLlilJceyFfLypIvDsfx8YpZi5OT0S?=
 =?us-ascii?Q?3F27RH8tvYxwMPxHNlZz78jC9XhzYykznuu29rlVlqbD7BI7Co8NRhF+Xhnn?=
 =?us-ascii?Q?qwROAtTr4D6AvfeH1D37t+26Wb48JA2ktSbru5FUtN9mJQagtIdeeq7McjfY?=
 =?us-ascii?Q?GfyIin38+TMwGLx8dxuKNS7TR4kBoWnQ2vwiGoCk1Wc6fNm4mYeZH5rXR+WG?=
 =?us-ascii?Q?Io9Y+oBNkyeISzgCHPQUrYI/E7kfRFpcdWr6O7uC3N9+lV4ur7MthltV0Omp?=
 =?us-ascii?Q?Gn1GndSejjhIgZbbuUEB1qv1FAyhcIQ1q/NltqjuMBRd7knbRGgVX4mDp19u?=
 =?us-ascii?Q?T5a+iEdtUpSeF2l1GEDA/AEli/tpejPcseR2uatSQ0eRWytuxde5BPAoOUJy?=
 =?us-ascii?Q?BtlpySw6hxWhrLBcUJozcA8I3y+/SSNWqDCNmuUwR/T072GPJGUNxmHOS7kh?=
 =?us-ascii?Q?U1hq+GCcvGxFmBSDMOSKtIieupr2Fpk2ljuAiRmWHKEnd9GYFP/jVPEpdSMr?=
 =?us-ascii?Q?RgY2Fic77iMxbawxpzs1dVdDIAe0V2AyRGtnogytFCu0lbIpoJUELdKa0fm5?=
 =?us-ascii?Q?+9rjA2qYIjZfAgGMdtG6EW88FCq27GB9TYAZF4Y1YIKzJUP7IHqMIFL9SXOv?=
 =?us-ascii?Q?6sZB8LnzL0z9a8s63RwxsbKQR0TRWL5mGFRu93JQ+TYhqQF+2pzIcBOcChyy?=
 =?us-ascii?Q?adAqHZuqutgUFNpomABTDlHng2L1ULu0iu7Ng6tI7oi+O6ILm6YSGHKfGE/7?=
 =?us-ascii?Q?ZKqMOke5bmZOY9mQd+dg1a+flhQxwKrRO2hy7cUtam08WYr2g9QnubAL5s2o?=
 =?us-ascii?Q?iOQpeuYMoDo/J2cXDXkKZoqVUUc8GFW2xMSCUzElfWVvAfiOKgbYEKGmFgTz?=
 =?us-ascii?Q?0vlrxp4uDCXdLcMOdNqnOMCGJuqkF0OBdsB5JZsweGxNd7QzY+ianv3Y6SBW?=
 =?us-ascii?Q?xNx0Abny0cafmJKCIY+DlFn+wGpJvVdhJksolrU2Y2t4JVNBv7vItc8lA2gM?=
 =?us-ascii?Q?lYLMpNc8KqIXN+9vTekQZYZK9RMLnjGDK++HjfRNsYoCMp/Rl0tlfmvQIYFi?=
 =?us-ascii?Q?4zHTZRp5pzc7ZYBAjctNSTMFLoibbiPkdnj3Q/Mis4Y2EBBP+VVnYswuN0yR?=
 =?us-ascii?Q?2CmaZliG2iT9Zefs5j2oDkPCM2i2FDX5xrwh0As6DPiIggXZl4El3Tbe7KV2?=
 =?us-ascii?Q?hjsYWsZXORyM7FsxmN8UwRK0W4c0B1r1dEF47YojEKxl1fATMbGv5hlXDqSV?=
 =?us-ascii?Q?3aM8ODp64Jy5JNuhtwbuYdbaJJJnJZpC5uWRYUnBPr5rgKermdyu5CP8cyus?=
 =?us-ascii?Q?dN1A0J8gZOpUtuWqCPQC9hKCJWnD16hDX39mlJA4zY+4UMdD9jZNB9G/r5EX?=
 =?us-ascii?Q?iE6i+lE9AZlMBcYSVG/D5i6VSa6d2X1NazByy+px?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	NS4Nzs6qgGRGmZse7D9tTRmDyzSW7LZXx4yZiey/MB4BRWm4aHqOwOSJRB+8UigIZTdrlxNzkjxRFgcecjzeaao7f7qHrYXnEjgtvQk6p6/sFsSDheZXG56sk9wKWIZqvVfQBWFIMq3CAQ01CGLJs8jo8fC7GoNZOnbPS3bbK9C+nIL5OYckA0cshb1Yd/gl9FkPnA0DS4y2CGWocq2CzU7WZUfVNwIblK5BBFK3PpTXxbMpeyEv2pd1vPTr4D0RRoBp/qDI34F+0YXb7Kr3OsK7mQA4zSdlDjqFDQeF9UNtcVRhTvkZrrVxO9fk/og5eHwbi/V2cocNUyRkQSIgUbkJEaYElG3g+gBg+p9gPJChjcKntPoGJoBXKdtcriFWt6Xv9PJVsqALrQ59dK783ylTZmz+NmcjYyLejqebXODG6x/wjZxMSOO4Y2HrDAObx41ktKbigc33TmPaYS3s8ijFRJDPk9+BS8AJsrblU1/io810VFG5C0OBKDs35eYE8YX/qpFNbL0j+83N+TqKn3QSM+HoZsdcrtgiTXQ9eXhSxbHNxRq5njG/raD+7RsX1L1K6Sp48gtIOqmjdqaudVV9ke24rRFR2HCM8mXRtm8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae453853-f68b-43fc-9335-08dca69c11bf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:07:22.3466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WHZKY2WALSEfZx0O+LxA5AU6WMqqr/ts1p7oHrsLQNzcA/M0rB8i2QCoKRA1v8UJUwMZBhJPuVHBbAwf8C2tHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7303
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_15,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407170152
X-Proofpoint-ORIG-GUID: pRLOhoYPNISsJEM7B4jIiACYZXIpw5QH
X-Proofpoint-GUID: pRLOhoYPNISsJEM7B4jIiACYZXIpw5QH

Create vmi_gather_munmap_vmas() to handle the gathering of vmas into a
detached maple tree for removal later.  Part of the gathering is the
splitting of vmas that span the boundary.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 80 ++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 58 insertions(+), 22 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index bd3378935c70..0d03fcf2ac0b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2655,32 +2655,30 @@ vmi_complete_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 }
 
 /*
- * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
+ * vmi_gather_munmap_vmas() - Put all VMAs within a range into a maple tree
+ * for removal at a later date.  Handles splitting first and last if necessary
+ * and marking the vmas as isolated.
+ *
  * @vmi: The vma iterator
  * @vma: The starting vm_area_struct
  * @mm: The mm_struct
  * @start: The aligned start address to munmap.
  * @end: The aligned end address to munmap.
  * @uf: The userfaultfd list_head
- * @unlock: Set to true to drop the mmap_lock.  unlocking only happens on
- * success.
+ * @mas_detach: The maple state tracking the detached tree
+ * @locked_vm: a pointer to store the VM_LOCKED pages count.
  *
- * Return: 0 on success and drops the lock if so directed, error and leaves the
- * lock held otherwise.
+ * Return: 0 on success
  */
 static int
-do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
+vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
-		    unsigned long end, struct list_head *uf, bool unlock)
+		    unsigned long end, struct list_head *uf,
+		    struct ma_state *mas_detach, unsigned long *locked_vm)
 {
 	struct vm_area_struct *next = NULL;
-	struct maple_tree mt_detach;
 	int count = 0;
 	int error = -ENOMEM;
-	unsigned long locked_vm = 0;
-	MA_STATE(mas_detach, &mt_detach, 0, 0);
-	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
-	mt_on_stack(mt_detach);
 
 	/*
 	 * If we need to split any vma, do it now to save pain later.
@@ -2719,15 +2717,15 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 				goto end_split_failed;
 		}
 		vma_start_write(next);
-		mas_set(&mas_detach, count);
-		error = mas_store_gfp(&mas_detach, next, GFP_KERNEL);
+		mas_set(mas_detach, count++);
+		error = mas_store_gfp(mas_detach, next, GFP_KERNEL);
 		if (error)
 			goto munmap_gather_failed;
+
 		vma_mark_detached(next, true);
 		if (next->vm_flags & VM_LOCKED)
-			locked_vm += vma_pages(next);
+			*locked_vm += vma_pages(next);
 
-		count++;
 		if (unlikely(uf)) {
 			/*
 			 * If userfaultfd_unmap_prep returns an error the vmas
@@ -2752,7 +2750,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
 	{
-		MA_STATE(test, &mt_detach, 0, 0);
+		MA_STATE(test, mas_detach->tree, 0, 0);
 		struct vm_area_struct *vma_mas, *vma_test;
 		int test_count = 0;
 
@@ -2772,6 +2770,48 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	while (vma_iter_addr(vmi) > start)
 		vma_iter_prev_range(vmi);
 
+	return 0;
+
+userfaultfd_error:
+munmap_gather_failed:
+end_split_failed:
+	abort_munmap_vmas(mas_detach);
+start_split_failed:
+map_count_exceeded:
+	return error;
+}
+
+/*
+ * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
+ * @vmi: The vma iterator
+ * @vma: The starting vm_area_struct
+ * @mm: The mm_struct
+ * @start: The aligned start address to munmap.
+ * @end: The aligned end address to munmap.
+ * @uf: The userfaultfd list_head
+ * @unlock: Set to true to drop the mmap_lock.  unlocking only happens on
+ * success.
+ *
+ * Return: 0 on success and drops the lock if so directed, error and leaves the
+ * lock held otherwise.
+ */
+static int
+do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		    struct mm_struct *mm, unsigned long start,
+		    unsigned long end, struct list_head *uf, bool unlock)
+{
+	struct maple_tree mt_detach;
+	MA_STATE(mas_detach, &mt_detach, 0, 0);
+	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
+	mt_on_stack(mt_detach);
+	int error;
+	unsigned long locked_vm = 0;
+
+	error = vmi_gather_munmap_vmas(vmi, vma, mm, start, end, uf,
+				       &mas_detach, &locked_vm);
+	if (error)
+		goto gather_failed;
+
 	error = vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL);
 	if (error)
 		goto clear_tree_failed;
@@ -2782,12 +2822,8 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return 0;
 
 clear_tree_failed:
-userfaultfd_error:
-munmap_gather_failed:
-end_split_failed:
 	abort_munmap_vmas(&mas_detach);
-start_split_failed:
-map_count_exceeded:
+gather_failed:
 	validate_mm(mm);
 	return error;
 }
-- 
2.43.0


