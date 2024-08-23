Return-Path: <linux-kernel+bounces-298648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7799C95C9CD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064841F261B5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B191216BE2A;
	Fri, 23 Aug 2024 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fNMQZkLF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gqyHHMOZ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE69143C4C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724406945; cv=fail; b=puy67qs6Z0GpZEGVD18MT1TyxbF0VPk0KC4nvz0oR6yi4nIhS8AUQZ/dVgqGXtuYcgUra8oBfJ4hdGKAkeoMg91/GzqB2JWwOFsATSNrpGVePQAR20yjs/1/syXNetTkbuy3HWVCIsS4KTvznZDace58VSVo7m0h4IIie945Mm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724406945; c=relaxed/simple;
	bh=PKHi2MMurvJqOTlihsjQl7rG5l9PMM88K5thd7X5rHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oGZ7wrncrVxLquKQC4jaiSt+hJMPSORGFBzs9TrOJWJwLC8Bs8//09l82yFBixh60ByGvpiHL7iqr5cA9+S0XfwKsCI1MkjTnsJPC9V5fHi/kavTw6adI2YprPeBRI8pAN1wCsLFzx8gHOL5o/opd1Pj/eaHoPOlCKDOXi13qr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fNMQZkLF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gqyHHMOZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47N8BWK6020518;
	Fri, 23 Aug 2024 09:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=+uoUCkQsUFscX0c
	4WWExbxhIGMDXeODVH5n7YBWxuc8=; b=fNMQZkLFcaTS4oeUBPuk3awXZEhJLSx
	f7CXCnSjDl3zvFF17IooI3zpEaZHC3195O/rOiiGLgQFAeyYgadxSZb+iR+3U5O7
	Nozzu0cv/5BsIDX68fle55xlxAtTN0Z6mQDFGK/gzxTlQ9plNDRcLWmdjOm0mMHD
	WQMflagxbXq2Cdwn6ZjC0KkjvgvO9jcHkZKXdcb9oAS9kdMsGcGU3Zr62awDSMmx
	Ww3eF45QfsfVETOWkJlfAxRjKO5s+i6B74TWmUzIYliRpAc3b57idAT2g8a4vG4+
	OofbTwsPPvjNs+Prjx5ELrM0Krk80fp6vJzWFa/V31M/X/XEPLctyew==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m3dvaub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 09:55:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47N9sEDA040649;
	Fri, 23 Aug 2024 09:55:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 416r6yr0xf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 09:55:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSvRQ/mxYQHwG0J12NSlJ85zMru5KsyDD/vwrYZ6E7qc5pglrBE+CSYAXJoByqWOHOvJkqkTT91O7yIOitju342my48IsK0vpWTJX2Wu0wFBDQ6E/fBIa5SUl93nrs8hU4arPx0qfLi/ckf3TzKFcq/KnDw2ipLi1CfBR3mqbEX+zsdtaoFhIx2VDUQQIOfEnzWk1lzLW1NOS0I1CfNGrc+O4gwucY1V18AlIqjjMKkivVJWUDEwezj8XFfFUReY9uaTcBgIu4IbKIOCHZuCyIVGxLMisOHlMY2aZE8yf7MS8vfIjeKb7a6WBIS0xRwEIThMlxTBlUCilYj9VJWbtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uoUCkQsUFscX0c4WWExbxhIGMDXeODVH5n7YBWxuc8=;
 b=vewTearAORsQGFpzAxq2gQ9Qe5ine9O/noCgQy39TIOvPEOWbHFrwftgrSo6oF1HoqDzyeP/jt5gvOpk4MrbdOCuAzZMtA1bHzxhvSCfqgtYtnadbIFCTiQztJuCcFtfCggWJs8CCYixXR+SHTvtyQGd/UomtsCP8wdTEFUqLr9yFlz0Wsb1rJLG+sUbOhEXJbgL+i6BjIzlCCBcNRrKPH6vQjTeIxVRUiH+4P8SM/FQGb5p/LbufSfiM/qhY+9Ydr3fqDtclzSMTfC8QFjfU+S3OOI3QUU1TU7Tr+toffvEyw8c5rP2xNQbQ4NnD7+guFPJGcA8RR7nXVqRTDLzvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uoUCkQsUFscX0c4WWExbxhIGMDXeODVH5n7YBWxuc8=;
 b=gqyHHMOZF/ZosUilMtVxyuXPOhQqQ+CCiIsBTis85Guy/wuXCYYmQ8it/rWFYjCE3gBtqgf2KIPEyRns+UVsr0zDpbZrFlrqHqw5hl+gWCeIiO4R9W748Tz1xpAtXJkmiwuRW5GIawwD0aJbJ3EVirvrVqC2vA7GRRDY4wIdA8c=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH0PR10MB7063.namprd10.prod.outlook.com (2603:10b6:510:289::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Fri, 23 Aug
 2024 09:55:23 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 09:55:23 +0000
Date: Fri, 23 Aug 2024 10:55:18 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Jiri Olsa <olsajiri@gmail.com>,
        Kees Cook <kees@kernel.org>, "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v7 06/21] mm/vma: Change munmap to use
 vma_munmap_struct() for accounting and surrounding vmas
Message-ID: <f22f7367-db42-47e2-b702-06a13d41e97e@lucifer.local>
References: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
 <20240822192543.3359552-7-Liam.Howlett@oracle.com>
 <b88f105afcd7d96a5306126c51ec236274780bac.camel@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b88f105afcd7d96a5306126c51ec236274780bac.camel@web.de>
X-ClientProxiedBy: LO4P265CA0094.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::9) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH0PR10MB7063:EE_
X-MS-Office365-Filtering-Correlation-Id: 954d9f73-6d98-4d62-9751-08dcc359b4d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pJRtUDy/EhQbNbanfDDPh7umJaWkoEpe3jrgoX3k4HmWpMMYJUsgaNjKY2IQ?=
 =?us-ascii?Q?ryzz31KS2QrPiOMtyhg8mn7uG1tl31LSc79cRwTPNlBn8HApbMV16xk3cNdj?=
 =?us-ascii?Q?M+Mm+5uDlGWobznenNN3Y/iDORQ1wSTGJrvxBOGWnVQLJaIdU1GNMmDu4Gdg?=
 =?us-ascii?Q?jpRJ5sc1mCMSlUEwZ490QzSioQHyZGh2KLfpPT5EifPEYzJzkGKpEQ+E1ztk?=
 =?us-ascii?Q?A3EG/mDFZIstLgeMrkmeOe+Em/B92aNmDOj4U9XLc7iHBlmf95G351Q8AgtT?=
 =?us-ascii?Q?/b6EWVkl/t88YmpoGCWzhv+OqJGWarvkAF1ROWTVB2ySUKA7AMnakfZBs185?=
 =?us-ascii?Q?IjMgVucIYpBAeTycalUeBMdiP1U0YRI4QxoXQhS/8Ei5tS7mb7ONSrBpOJJ7?=
 =?us-ascii?Q?kGyizXQG4wdtaqvT+C0BZVCNfVGoNLXTi/cKgGFYS2pNk+M7qPFzVm915j2q?=
 =?us-ascii?Q?iuySFLJpWaOPrdjkprTboO85GFVJf0CQBJTbH6mWKHozzGPRcqTtosvP4P6w?=
 =?us-ascii?Q?8txaXRXwLOiaAwvVWttfPmdOr1/hIU872dAirzf/NgVVhDaP/9prxYOPOQi2?=
 =?us-ascii?Q?QCLlODyytoh/SDkPB26On16y7XVGQDIuZkZ8R5+B/3JdtZbgHqnkAJHcnjKu?=
 =?us-ascii?Q?uLzHIABM8M//j2cYMl41Y8l0q4G2XOFZZtiqpLtod8JGhnlBxqZeR6rCjO7N?=
 =?us-ascii?Q?arIY8zp+HWAFD1aa40cD7MNin+4bnWoGw6jYOfhJdyDttWnvYkGSS2YkcZzN?=
 =?us-ascii?Q?W9aUqPIX6SIFJVJ0QojE3lcEwiBqrHWeQACQmkAoxsL5YXaNWr5tROHYXejm?=
 =?us-ascii?Q?ISnL+rr+bBMUN4qJVGO3lZCL3h/UsXsA/CccdiSRn+7oV/sP2p4vNVfT1Dlt?=
 =?us-ascii?Q?sdiC7TdxnlDFDCcOoWq1iCUnzIJasHY0difSC0c+wLHDTYm7NDWZaec0gzTb?=
 =?us-ascii?Q?YHEVqfj8CSPLpePbkXkOTIqrTKNzrLuGfQHMvYx+BAxFNEvCWWepUgdVRYHk?=
 =?us-ascii?Q?9UNu6b6kchrPB0ma9k2Oi757HchtLsgVrSek47Ky3bmcGGmDqW/8ZzdfEoxH?=
 =?us-ascii?Q?LGLba8K4zTJkdA2e5eVJ7/1udFUyyk1kKFijm3P06r+NAbamFbR7XpjXtczb?=
 =?us-ascii?Q?Zkyzb+9/sEm6y2mZjLYz8zeBACAl1bJkLK++1lMe+lZ2SjKIo5qoQ+YAQQuf?=
 =?us-ascii?Q?HwabZrgc66uY5c4gYPYPzcsEl2a0CvbMRjHokB5V0hxs2a2xtF2c946ukgp0?=
 =?us-ascii?Q?pzpxGytMqGhUI7xsCnqfOU9bJyNqNNFjVzpWk/RHUxRmyU8r0dFlEpxFlZ0P?=
 =?us-ascii?Q?NBcE8iJo4dCL+no5b5qP+kD49zspOWQe1dLhlvEGUh3MSw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tN7xMapCRsX+tvJ60BK0L2f3XJEpf7MFRVy0uBE0MTqQEb7rYTdob34aJ0YO?=
 =?us-ascii?Q?WFNAzgrngWJC5tkyr3/HBtypHzJJu5e2Oea0Imj0DZMpuDxQh8bQMLL9PBhv?=
 =?us-ascii?Q?eCi6+Kmt5Q4+0rUwbf3B20b8lu07uTHQb4WzYEdnDRD+F5EWr2m9vD9GZcla?=
 =?us-ascii?Q?GwOKvocDGtbbzA3m79cvgfvVIJ9rjX5pBi6IOlA53uYHB7+os3TJ0j8BsxAE?=
 =?us-ascii?Q?kunSmzmF1jVZ5zCBpkQrDQAihkbC9JmKiuHOxnreKvdSe5CiNWAHFD7ac6Vz?=
 =?us-ascii?Q?txckpVorCLE8iRZA5vJvYMMc82Dfc7TEVkWkdjpKiDrjQhFXXH+GdMSXkWr5?=
 =?us-ascii?Q?gYEDfo6GOCfUWbB3xBohvRv2X3RUm3sYsdeqtm0c8JI3syVlXUxKzrnnPE4f?=
 =?us-ascii?Q?uvdxjLhZPtMdAR9+OJ1DfHje6KLGHufD8i6O2KgiaUU+sYM8x7k1DQHRvopL?=
 =?us-ascii?Q?e93xuMKrxk20BK0TvOxFQ4Kquv8AeI8fNUbSdFe5P72W1w9YO/4LjWS+VLQM?=
 =?us-ascii?Q?b8uT8tahYFMr21fEafcYkdi/jzBH+vguJp/ZucQzFIyzgnleGxJu5CAh341y?=
 =?us-ascii?Q?RRJ7s4c55pLZU1tbie82tndmAmaOYNfkO7TEWdB+BQrzO2JdkAnTbT9md3JT?=
 =?us-ascii?Q?RzfLSvvgsafdcKek1qhJDCz3k+KVC4I7bnFdixPqGHDTsZw14Jx7uSroVH9w?=
 =?us-ascii?Q?j1KRx2UbKqEQMG7ytRVvJ5UiJh51ikIVamcoGLoxHzpRonglA1E8XDTScLBE?=
 =?us-ascii?Q?CAkoWHnVFBJjzjdihrT73PjBQhw7bC3OQvbI+dup4TX9iqu3UovvfvNSMUxn?=
 =?us-ascii?Q?GC8y7YlLwAvGWhXUQUeV6Lab5jcxwjCKTiQza8qZhu99r6gLvevXPpzJGAbQ?=
 =?us-ascii?Q?sDGfcYV+zhzleLvh3WyvGqYpq1Q+PNX6f48dz/dmkpXmhfbIqYQc81Gn+lpv?=
 =?us-ascii?Q?fs3g0rstUhmfZEyDCrT1yIpCEAqtaAKyXa6+WiFTA7iT0qir8o/NUxXe25t7?=
 =?us-ascii?Q?B6jkCNfmckWopEUbjwSsjcQtUlBz8KulpP5324eT98PglxI/13MR7rK0dT75?=
 =?us-ascii?Q?1nUx2eaiEqD7tKEwYeFrYP3ovIrBSaU3VNqz1ASpuJSXPact9wHX3GTOcw9g?=
 =?us-ascii?Q?ERINsQzbrgI2euVyirNrvJ6fq0RkntGZNjFrRCYVQmUNz89jOPOaf9PbKLpI?=
 =?us-ascii?Q?oseVeg8WuW6hk+QfJyaa5mWU7x6xub43PYmpsqGsZ2W+LpGvTL1NHRA29oSB?=
 =?us-ascii?Q?iEzhfToGadou2qu27vmdw4G9bf7GJ+TxQXModdj5KniNi6i+PRwpZzEFlTq3?=
 =?us-ascii?Q?3ZZiR8J2rov4yp5JO0vbT1n0SarcQ96uNX8d3USjoZP3Y1u+GfIQWSiyFVij?=
 =?us-ascii?Q?ndVZ66oEZwod0B8EiZnTHTHzlzfXUmKW0Px99ZDLkj37Lt6rLYq2OhCe6geX?=
 =?us-ascii?Q?axGyVnXyPOY3V7Oo/eYZW/xmyt9mpqRsdo0f8omMbinoezYTK8X8ps6D5Hc1?=
 =?us-ascii?Q?EygPfFpNmlXpcd5ThwxLH+JtINyVioceBgB6MXVYgIHGDoei5bHbIy0yY1vL?=
 =?us-ascii?Q?SQogbMipVbeZcgdnZxa5ZZyIkpv+yngJkHR+5l4wzx21uxO4DZngH0HL/FZF?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	giyHOxpdpZwb6TyBHSM4Kcb6p5i9BGDh0RQdhXt+wJ+mTYqdPmX/l/jZO6uncIOUaFyoqjDaeSnAACGC3+WIb+AChb4Vc54XXA/bwhgRQQlpbyYwrFzHzdVgm+XFySsKTU9wtyT4e51YzUaihteF+pWzcYIfc54VuTndnSExzCsbf2SWlPlJogh4l471FB43FNT1R6n4RCjmtn3+jXAZVi8v+d8M/2nyK63+f7yElQCsOXlh88khazTSh1fOYu8OtdGiSvMaZ5i+2jrL02eTNXs7I5AwDkQgQDPMEkHritNJ3Ux3xVUh90Z6x9x8gGssEWECw+NHgUSI2yIgd2/XZ4C6c5Ak+L6fbew+hwN71n4USRGm6V/OM9eJQxEdLK1sfQQZW44NmaPIvhzjlmihlOyZKLEeXPRcSkek9u6LtZP6MgxG+5V2+Q0WPZcy18kHF/qeQyvHsAWkN6cKmm8UsOHqIhYGUve1K0kHHxQhkoAUDspF8Yq6C+iNWgPbjlWkLugI+EFjdbvzUNEjA1K9J9frHNSr/nDNrpX9+V/RRS8F/+AvPLActSNC5OYqh6p/HdV+iEE3MNEM6jMm7FqI2U8XO535gzrayade+jmLAck=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 954d9f73-6d98-4d62-9751-08dcc359b4d5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 09:55:23.5454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SlnrbVrt3bnTCeUS/VInaCKGQqjK9vzq/V0UQaQyTvOkFe4wOFlTlBjaYCeFec4A8EZuRq1QFJrQRtfYOp7FhOZqExD/6l5cXZNaRt/HBKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7063
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_06,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408230072
X-Proofpoint-ORIG-GUID: aggplZtTWZIIdrc01dUvyEvEZg-QirTN
X-Proofpoint-GUID: aggplZtTWZIIdrc01dUvyEvEZg-QirTN

On Fri, Aug 23, 2024 at 10:43:11AM GMT, Bert Karwatzki wrote:

[snip]

> > @@ -731,21 +708,31 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
> >  	if (vms->unlock)
> >  		mmap_write_downgrade(mm);
> >
> > -	prev = vma_iter_prev_range(vms->vmi);
> > -	next = vma_next(vms->vmi);
> > -	if (next)
> > -		vma_iter_prev_range(vms->vmi);
> > -
> >  	/*
> >  	 * We can free page tables without write-locking mmap_lock because VMAs
> >  	 * were isolated before we downgraded mmap_lock.
> >  	 */
> >  	mas_set(mas_detach, 1);
> > -	unmap_region(mm, mas_detach, vms->vma, prev, next, vms->start, vms->end,
> > -		     vms->vma_count, !vms->unlock);
> > -	/* Statistics and freeing VMAs */
> > +	unmap_region(mm, mas_detach, vms->vma, vms->prev, vms->next,
> > +		     vms->start, vms->end, vms->vma_count, !vms->unlock);
> > +	/* Update high watermark before we lower total_vm */
> > +	update_hiwater_vm(mm);
> > +	/* Stat accounting */
> > +	WRITE_ONCE(mm->total_vm, READ_ONCE(mm->total_vm) - vms->nr_pages);
> > +	mm->exec_vm -= vms->exec_vm;
> > +	mm->stack_vm -= vms->stack_vm;
> > +	mm->data_vm -= vms->data_vm;
> > +	/* Paranoid bookkeeping */
> > +	VM_WARN_ON(vms->exec_vm > mm->exec_vm);
> > +	VM_WARN_ON(vms->stack_vm > mm->stack_vm);
> > +	VM_WARN_ON(vms->data_vm > mm->data_vm);
> > +
>
> I'm running the v7 Patchset on linux-next-20240822 and I get lots of these
> errors (right on boot) (both when using the complete patchset and when using
> only the patches up to this):

Hm curious, I'm running this in qemu with CONFIG_DEBUG_VM set and don't see
this at lesat on next-20240823.

Liam's series is based on the mseal series by Pedro, not sure if that wasn't in
22 somehow?

Can you try with 23, from tip and:

    b4 shazam 20240822192543.3359552-1-Liam.Howlett@oracle.com

To grab this series just to be sure?

Because that'd definitely be very weird + concerning and something we hadn't
seen before (I don't think?) for the mm->data_vm to be incorrect...

>
> [  T620] WARNING: CPU: 6 PID: 620 at mm/vma.c:725
> vms_complete_munmap_vmas+0x1d8/0x200
> [  T620] Modules linked in: amd_atl ecc mc sparse_keymap wmi_bmof edac_mce_amd
> snd snd_pci_acp3x k10temp soundcore ccp battery ac button hid_sensor_gyro_3d
> hid_sensor_als hid_sensor_magn_3d hid_sensor_prox hid_sensor_accel_3d
> hid_sensor_trigger industrialio_triggered_buffer kfifo_buf industrialio amd_pmc
> hid_sensor_iio_common joydev evdev serio_raw mt7921e mt7921_common mt792x_lib
> mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr nvme_fabrics fuse
> efi_pstore configfs efivarfs autofs4 ext4 crc32c_generic mbcache jbd2 usbhid
> amdgpu i2c_algo_bit drm_ttm_helper ttm drm_exec drm_suballoc_helper amdxcp
> xhci_pci drm_buddy hid_sensor_hub xhci_hcd nvme mfd_core gpu_sched
> hid_multitouch hid_generic crc32c_intel psmouse usbcore i2c_piix4
> drm_display_helper amd_sfh i2c_hid_acpi i2c_smbus usb_common crc16 nvme_core
> r8169 i2c_hid hid i2c_designware_platform i2c_designware_core
> [  T620] CPU: 6 UID: 0 PID: 620 Comm: fsck.vfat Not tainted 6.11.0-rc4-next-
> 20240822-liamh-v7-00021-gc6686c81601f #322
> [  T620] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/MS-
> 158L, BIOS E158LAMS.107 11/10/2021
> [  T620] RIP: 0010:vms_complete_munmap_vmas+0x1d8/0x200
> [  T620] Code: 8b 85 a8 00 00 00 a8 01 74 35 8b 85 e0 00 00 00 48 8d bd a8 00 00
> 00 83 c0 01 89 85 e0 00 00 00 e8 7d 39 e8 ff e9 63 fe ff ff <0f> 0b e9 eb fe ff
> ff 0f 0b e9 d0 fe ff ff 0f 0b e9 d3 fe ff ff 0f
> [  T620] RSP: 0018:ffffa415c09d7d10 EFLAGS: 00010283
> [  T620] RAX: 00000000000000cd RBX: ffffa415c09d7d90 RCX: 000000000000018e
> [  T620] RDX: 0000000000000021 RSI: 00000000000019d9 RDI: ffff9073ee7a6400
> [  T620] RBP: ffff906541341f80 R08: 0000000000000000 R09: 000000000000080a
> [  T620] R10: 000000000001d4de R11: 0000000000000140 R12: ffffa415c09d7d48
> [  T620] R13: 00007fbd5ea5f000 R14: 00007fbd5eb5efff R15: ffffa415c09d7d90
> [  T620] FS:  00007fbd5ec38740(0000) GS:ffff9073ee780000(0000)
> knlGS:0000000000000000
> [  T620] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  T620] CR2: 00007fc336339c90 CR3: 000000010a39e000 CR4: 0000000000750ef0
> [  T620] PKRU: 55555554
> [  T620] Call Trace:
> [  T620]  <TASK>
> [  T620]  ? __warn.cold+0x90/0x9e
> [  T620]  ? vms_complete_munmap_vmas+0x1d8/0x200
> [  T620]  ? report_bug+0xfa/0x140
> [  T620]  ? handle_bug+0x53/0x90
> [  T620]  ? exc_invalid_op+0x17/0x70
> [  T620]  ? asm_exc_invalid_op+0x1a/0x20
> [  T620]  ? vms_complete_munmap_vmas+0x1d8/0x200
> [  T620]  do_vmi_align_munmap+0x1e0/0x260
> [  T620]  do_vmi_munmap+0xbe/0x160
> [  T620]  __vm_munmap+0x96/0x110
> [  T620]  __x64_sys_munmap+0x16/0x20
> [  T620]  do_syscall_64+0x5f/0x170
> [  T620]  entry_SYSCALL_64_after_hwframe+0x55/0x5d
> [  T620] RIP: 0033:0x7fbd5ed3ec57
> [  T620] Code: 73 01 c3 48 8b 0d c1 71 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e
> 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 0b 00 00 00 0f 05 <48> 3d 01 f0 ff ff
> 73 01 c3 48 8b 0d 91 71 0d 00 f7 d8 64 89 01 48
> [  T620] RSP: 002b:00007fff0b04d298 EFLAGS: 00000202 ORIG_RAX: 000000000000000b
> [  T620] RAX: ffffffffffffffda RBX: ffffffffffffff88 RCX: 00007fbd5ed3ec57
> [  T620] RDX: 0000000000000000 RSI: 0000000000100000 RDI: 00007fbd5ea5f000
> [  T620] RBP: 0000000000000002 R08: 0000000000100000 R09: 0000000000000007
> [  T620] R10: 0000000000000007 R11: 0000000000000202 R12: 00007fff0b04d588
> [  T620] R13: 000055b76c789fc6 R14: 00007fff0b04d360 R15: 00007fff0b04d3c0
> [  T620]  </TASK>
> [  T620] ---[ end trace 0000000000000000 ]---
>
>
> Bert Karwatzki

