Return-Path: <linux-kernel+bounces-242866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CD1928E17
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 22:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 882D21C21E1E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 20:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A9D16D9DA;
	Fri,  5 Jul 2024 20:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B7M70muy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WGNYMBFF"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE32135417
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 20:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720210734; cv=fail; b=TzJo7X2OSBoZJyPO9uhU9hf4/ZuxfpBNdSxKAOmTkUkmzx9adFKE8blgSRgprnorMxhmABDSwSH7LhrJzKAFoSG0wU3H+59vDMTd9SFLfus1G095gDRHD0dA8k06Lm/3I5KMQTiCU0sGNSO5Nb58x0UMahyC7ogcVtP9mYEmVU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720210734; c=relaxed/simple;
	bh=63qjKBOSDv21fcj0oq9fgkHxHILUN0n8J9dP/MHz/DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tFbc1iWfKHMu2o/HOqFYXJJnXCtAZlEVGEMKREqWQ/I8J+GmUTD4gXcN5nOtJr9tal3LR1daC8ddzNy/yxJlsOrB9hr4AyyokuF8DqLF8do5n6ED/bq78C/irqE/SDIOu9ue/QhX4k6AqFrKLtcgzOAzcr1B8JUKA/7o0YSaTkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B7M70muy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WGNYMBFF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465K7phn014184;
	Fri, 5 Jul 2024 20:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=hfGPnuZx68UW5xf
	wg/I/d15QwH5SuM5qsAmY70tmtBg=; b=B7M70muyGhCn0w7qQu94nuUmyN4/Mkz
	cEL3Z7uB0etCQeMr5C7EaSY6cKXIKMWGHlo68Y6KTolklVO7fw6SbziEZhpu+HJ/
	VTxCj23etjCxQ4gRbgotQviUjwqyb8UUoyxlBjZ4maE/i7zlBibIX2OYJqyigaru
	eIHyZPjUVQVbGQmh0OrKBUMQR9cnNjljw3QxIvbiM8/tjJLkZlzFdRbNSa8eNU9f
	VOXXkEcnxKuwX9cPxD/tfxI5jZ4igGF37emnHaEWCPCNu1sM5g4G8giw/+Knlc1Z
	KmLs+ybCIp6AjsInYo27gX0LBrjc82sCNMm1aRctWvbDYde1r3yylMg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 404nxgp1u2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 20:18:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465KA7Sp035665;
	Fri, 5 Jul 2024 20:18:33 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qbeqqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 20:18:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLlYK0ied/eZxGJ6/UHRBzeAI5ScNmQCGtnVLnBQTcAlBJH0+YdQ/jn7blbVj4ZzUlB5eqOEkaDAlFYnRzgoOoDrTLwn9X4i+0bhTFFWfpgB82xmugtLHMdhC8CJd6gbl5hLi58JOIS/aBOtxIRLj53JMN5vVcJVV78XEWEJl4CUrnROcSFatm73Hhl8eWvMi44XR/W8cnP5f1RnH3qq1BbCC3vzVeuQVCqP+hBUAZBqVZGbYwKmzYbPArre4wsGwM0zkiG16yAlj+XZFmaoyix8WFov2uad+T1KFOmkGSVJLmjQwbodWQKu8VYgagHhjrEmSrwk2n1aIQ38PL2iLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfGPnuZx68UW5xfwg/I/d15QwH5SuM5qsAmY70tmtBg=;
 b=EhXKDFvsoeu87HETuqp3gDH+/NHwDwBMgbKNnfZx5MD65AY0alWJwDhy7Mv21/IIgnXI0lNWmYZ+LrkEx+26h+AUpJAFop6WBZmAht9w2Ru3VsdTZQc+gsiwX5f19G1ztXRwyQBe5ev+3cA9WYcVbr2LUpTUJxGA1XtZ4QqTX+FjjeT1USNpR4zymcsW4l48zHtQcOlR7IlEdf8VqoCV/P1S3LHW1o5g4b1uNU9hLupPGg4+CSvVDbfFzSq1XoYHYScN3pXyGomFitEcyw3yXHMB2imcol+lB8ZhNkJjt/W4F/cfJkWUWZn5SSDTW784et9GoB+IpsQJfjZJfwMPcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfGPnuZx68UW5xfwg/I/d15QwH5SuM5qsAmY70tmtBg=;
 b=WGNYMBFF4xL/rO6iaWuom/gZpMs6ovU+sIFy8FftWWpHOVdVx0v/HuJqvLN9gayJ+pDxM+FsY0oNOI4Znh0syCOvXZwaC+usvisS6Xz/C+JDlsNhszxmaWz0Ig3x7FI9yymlgWAG9W7w5gIfY6n4Vw0hkB21HxdtIBwcm3PPeKg=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SA1PR10MB7711.namprd10.prod.outlook.com (2603:10b6:806:3ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 20:18:20 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 20:18:20 +0000
Date: Fri, 5 Jul 2024 21:18:16 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 10/16] mm/mmap: Reposition vma iterator in
 mmap_region()
Message-ID: <76625760-1fc6-4c81-9df9-ee47697995ff@lucifer.local>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-11-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704182718.2653918-11-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO2P123CA0084.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::17) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SA1PR10MB7711:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a27d626-12b9-4465-3a87-08dc9d2f9d3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?gusXk9yoXSDsmaMoAZzU+Xelsu9hzD2Df4Frz0YPjg1M8gxGFBpIyinUzJHX?=
 =?us-ascii?Q?OuSwFb73wuf99Dx+09aka25Rf70fN5Wmc4whuAKQjLaYJsmGAQYUuBq5Xnxx?=
 =?us-ascii?Q?yug1MgLmSKk2YGXGjCRweYYSkbFfKB2MSRndOYFqmUANtQxxZx7RuZ5mQaW4?=
 =?us-ascii?Q?0LJVa9Kj0XWovwnFzqAB3hXjagIN7y3brvanzme2AyzcJ9rdhdpJZYNGxjjS?=
 =?us-ascii?Q?vRptDKWMa3eIuVQiUsdGzkZcP9QnHBTnqfk4E2kmp1K8ze+LtVv2uXrtk22C?=
 =?us-ascii?Q?yywM9GN97r4AKXu7tJgdNn8P6j2d3b1LyoCQlCyRiip6q2lLtIIM9CS11mz6?=
 =?us-ascii?Q?1PJQppzCPG1/uzc/svXva89eokWb3dgBZOGZBB9NnnIoJTlxxUCyoalMikNe?=
 =?us-ascii?Q?UU3qnm5tKg7oKcSO9SKlBe6Z9ONEkGRI2gd7xlEYvpcRIeXBAIaFGwcYCwCK?=
 =?us-ascii?Q?+eMlNNFdrPPkKZjQtWxsGpTX3ON3yyYPftffw/uYE/EqZ0TXYpvVI4jehc/h?=
 =?us-ascii?Q?Sxs8x3Pk9oHlO+OLRExNtOn8ImTEKxsrgax9VQUpi89F0Hc2sL2QCHDy3cI7?=
 =?us-ascii?Q?3mLIRVzzhd1SPghUIH4UyuKtNUO+Ltgm51MIzgFLTuko1TovCMtmm7yNCHJB?=
 =?us-ascii?Q?/6ucoRg35s0m/tCJ7CmloP9o5Q/sS7f+X42Yshc70JNTGTavtxR0iRqnY+Op?=
 =?us-ascii?Q?TA/idfD+5i6eeO3Z9r2SqaeeEDZfVSv9OaQJ6kXSl5Z5jYnFnOvWq7rxieYG?=
 =?us-ascii?Q?EsQ9wr7raFIX599SHuZI4W7dIrnHdwie7W7EQCm6iCf4fsV6UHNceo5Ia6qq?=
 =?us-ascii?Q?DuKpbkbDI65LlMfvqWodCAp/KjTJo4CAW/n0FZXfGhdRbSXdZRf2QYMxLCOd?=
 =?us-ascii?Q?Ta7VE78BYdtFN9RjuE6M3iRfSJZwkP2bOx/dao+zfGHOzn6ycw8MWcXIc8Wp?=
 =?us-ascii?Q?YTWElmPRMbFHVM4JWn3xTxz6wEunyI3H7vrWbc72kiRz8pJEi9Xr6Tisctqi?=
 =?us-ascii?Q?smpV6qE66sKEYeR7VUR5IG8E+02dUbyV8g3iep7wOq8bgCvRsvYv2sNjwjyM?=
 =?us-ascii?Q?eRC+m2I0XYcPsrtDAxENkVd7T1G34f/+Bshga9AInfOZF6FGrG3dIIPzEome?=
 =?us-ascii?Q?HB24umum7Fjrkv/p94bjTUIRw4KEThzcJM6wWhcldVVecFlPgPvLmtcoyX8d?=
 =?us-ascii?Q?LjmBn7nt++RQLFIIpgfWfH+yLl3b4r4vYOc4CIy6OKSo0MFzWlqRfgszGoss?=
 =?us-ascii?Q?f0loTUuVen2K6ukQrQegulj/OdlIz0y1LIVqdFrVGvkd01sHYFmlkP969zZB?=
 =?us-ascii?Q?e9HuQBdsZJI3pK8HkLpEPP/lNliyelFwPxa2iSIMIiU12A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8m4d4zQ4ca22lGKfjGNKqqsvd+TLdUjIeZhKY+kiwte/LjGalDJiJaSDWnPW?=
 =?us-ascii?Q?9QTh8iyYayEWigCvkhXgQGECIORLl0TRIBLhYQJEuS3Nf2qDn4onzH5xzf9G?=
 =?us-ascii?Q?GAd3QhgiG43hTE7yYdLOqSKZtKQIgkOSsyl0pppD7cpKNiUNhVCk6TT59adO?=
 =?us-ascii?Q?DBO4D6sI8jlUkS5p+y2f2zUi19Iv68wj/7gPnqPNNYffwHEsfemrgeuExWdx?=
 =?us-ascii?Q?XGxywZkJwt3I8z8weQlWFcX2Vj9jwdiNXaoBvHOLossLKNdlnS7GmxXQ0m2S?=
 =?us-ascii?Q?dfv8RccimCqy6Lm3z/+UizR2j1OmyQZ2dzYtJM1ZTfdORhN6A1eQKxfdURA8?=
 =?us-ascii?Q?aCPAVfZm1TOmqJq+ahynvqoK9Rr+2PLOAih1HC2jCURyHCleLG8RbRkTcEDP?=
 =?us-ascii?Q?hA+ne9TtYjQifGD94uLw3TQ12drFnHfY4xBxobCrQFwRiVOFC3MmcHvlOla4?=
 =?us-ascii?Q?Plb2lMPRNmsGzLNpRJPWIuN/Op/vviAdcFkEut546Z1UYE7oTylAaBGKvMQj?=
 =?us-ascii?Q?xSWBVsJvzeEZqxBN/no5T+gs1v6LHu9G98Z5+ILuzG+bwaWyEMvXkZM/zLSc?=
 =?us-ascii?Q?z6K/dltADaTr8lA6QZ0hwUt+N4YmLeG0dHcJWrXH7uHuYu1NCV8EhCcmDC/R?=
 =?us-ascii?Q?yAOr6bHGLjcYS/z7P/H1NboLSHH5RNlcNRVjDovNLHnUxIyULjGjReLLI2fF?=
 =?us-ascii?Q?pHcPGckQSMpLwLRRUYGbSpAtU3gexBJeJI7AdG8mlI0SkJ7bwXGGPwFg4kkF?=
 =?us-ascii?Q?ieuq1DxiolVrV0G0RgxesYSMHWr6zcYNnW7u0DdLhjR2dEEiGkM2ooQabGrB?=
 =?us-ascii?Q?1gvR3plwWuTtmnhiaVvIkbpbVUz7zsvoLKPdrw3HvSafCZ3+cNPKhO75lqpB?=
 =?us-ascii?Q?TO2M8aDwTc9nOXIVQOLJDVFQy+jH+vpth5B+rsfff3lJGT0jO571e+BXzc2S?=
 =?us-ascii?Q?Nx/x/0ZI/b4GMSXhSYpauPgLG/WjkSD7P463MO/kb9G8Z451sH+EahWK4zeE?=
 =?us-ascii?Q?3kfrAYJz/m0jeCsaUwzvYKKfD6L9eMPp/XTf3b/xChFWZRy7m03sydEOhE8p?=
 =?us-ascii?Q?pfPsAQcbdxw645D21N8NX0J/4xpB615To0vsBb/6448eer/VAFkXaVViIT/J?=
 =?us-ascii?Q?kMTP2j96V1QDlezGqeI5/QEJ2Vyo4f7gaCHysh8Jg8LThE7o/LVdLlXxvqlx?=
 =?us-ascii?Q?a8r6Xws94SKIFeyWKgUVJtj31R+jATvpFU766vLasMAQnBvqKf5NXdsZUmj7?=
 =?us-ascii?Q?AkuSGRi07VUOavQBtbhzyJ+sK3lrv+wSM8d8Q3RhzAHV4y6YdCwxHkCduSgX?=
 =?us-ascii?Q?OEwqYTeTmf7qDtf5KbD5jOmgMP2M6Vx9GfiX8lDBnA4g5NDpamNIueLTGCKM?=
 =?us-ascii?Q?EKBXa1r619083RgY/EA8kxb4V6QXEfkJERiEKGNLMJh90rcgOr4HlYQJIrxo?=
 =?us-ascii?Q?L7O6klo6oRFDyXkNxn15ysr3u8cPAy/hRepTuvgnM9Nn6b+nEVjm2roJkGF5?=
 =?us-ascii?Q?x5CX/YalH6Y0WQFjFHRbLbaoOmt6HckW5EdZxbx6+H45SMpDsE/KVP0DCkQk?=
 =?us-ascii?Q?jK6YOxlHPYsB4UfMcnzh3LL01Arp32FbLiKAI3RHo6Y9cOhruwUQqWdSc0He?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	o3nDsTLkOu54qgnNlsnyDjfka0PZ0B1QYSWGSnK9yA0CPLcQ8BKIB0DHSBymumUYm+knYRdFli5NXn1K7dQGBKWKLditC4eZVbNrkNfF8GkYV3mNHjcnm3WHZZGxu9CB9HrvxTt5UGVAlbpmDH1kJIKm4LsANu8RDKIs9Wmz0jtxfUKVX0idNI9yJ5WVXPixly/OQ9QOuAPc5wIOUVnVNnDUtWlrAmpdzSxIs0If42b2FDol7UFE3M+eOi8EcIjjoTLky0uwQenHyd4L/8HKiP5v9JeJwBlm1n89RDNnNQgf2wTrHsGY8NgFQOxSjSamq+yXhGqQ0uJce98LStrZvelRNBI8REM/ujjJwl1PoZwb7Wwc04pebyfUE8tvNamEayMs2W9qo9aVLxWJUwXfMSINRNekzDFh7Ki9rnG9hmZy8coGqHx8WHR0aE//NiJ8xkHr2RnCLDjL/y3v8fwqPxRyyPCSU+0R+GAe8DRkeKTY9KIR1fRYbDXDjsfYq3EMY9Ak/0Z14754uMszJB/WCc4+6q1qgc1sp0A0xA/rp4XXicmmNJN+k+jFrf4t2LQ4oHnlHL7Y+25sm8dUWL7jQg2ZNLzYtrQotPwtVUDwpbk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a27d626-12b9-4465-3a87-08dc9d2f9d3c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 20:18:20.7569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ZP4DVfYOQ8YmVAM5BnUQaIG2tMQTMy7bck7C3cDAKmlFshi4rHG/GHE5J8C+Xj2LwWDVsQBCAgS3j+xddRrnSsSU5SLxEGkUxlNLucjGgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7711
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_15,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407050149
X-Proofpoint-GUID: a2RhlHgYRwTI4EwDTstW1SAuU4t9BXaZ
X-Proofpoint-ORIG-GUID: a2RhlHgYRwTI4EwDTstW1SAuU4t9BXaZ

On Thu, Jul 04, 2024 at 02:27:12PM GMT, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> Instead of moving (or leaving) the vma iterator pointing at the previous
> vma, leave it pointing at the insert location.  Pointing the vma
> iterator at the insert location allows for a cleaner walk of the vma
> tree for MAP_FIXED and the no expansion cases.

I mean, it's funny I litearlly just asked why it was being left pointing at
prev and I guess this answers that basically :)

>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  mm/mmap.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index f5b33de4e717..ecf55d32e804 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2963,11 +2963,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		vms_complete_munmap_vmas(&vms, &mas_detach);
>  		next = vms.next;
>  		prev = vms.prev;
> -		vma_prev(&vmi);
>  		vma = NULL;
>  	} else {
>  		next = vma_next(&vmi);
>  		prev = vma_prev(&vmi);
> +		if (prev)
> +			vma_iter_next_range(&vmi);
>  	}
>
>  	/*
> @@ -2980,11 +2981,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		vm_flags |= VM_ACCOUNT;
>  	}
>
> -	if (vm_flags & VM_SPECIAL) {
> -		if (prev)
> -			vma_iter_next_range(&vmi);
> +	if (vm_flags & VM_SPECIAL)
>  		goto cannot_expand;
> -	}
>
>  	/* Attempt to expand an old mapping */
>  	/* Check next */
> @@ -3005,19 +3003,21 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		merge_start = prev->vm_start;
>  		vma = prev;
>  		vm_pgoff = prev->vm_pgoff;
> -	} else if (prev) {
> -		vma_iter_next_range(&vmi);
> +		vma_prev(&vmi);

Why not vma_iter_prev_range()?

>  	}
>
> -	/* Actually expand, if possible */
> -	if (vma &&
> -	    !vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
> -		khugepaged_enter_vma(vma, vm_flags);
> -		goto expanded;
> +	if (vma) {
> +		/* Actually expand, if possible */
> +		if (!vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
> +			khugepaged_enter_vma(vma, vm_flags);
> +			goto expanded;
> +		}
> +
> +		/* If the expand fails, then reposition the vma iterator */
> +		if (unlikely(vma == prev))
> +			vma_iter_set(&vmi, addr);
>  	}
>
> -	if (vma == prev)
> -		vma_iter_set(&vmi, addr);
>  cannot_expand:
>
>  	/*
> --
> 2.43.0
>
Looks good to me,

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

