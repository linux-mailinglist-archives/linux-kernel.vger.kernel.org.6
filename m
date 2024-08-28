Return-Path: <linux-kernel+bounces-305584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EA99630D3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB1641C22048
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B351A76B9;
	Wed, 28 Aug 2024 19:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g/vI04LH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fhjtPtPA"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C16D433C1
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724872614; cv=fail; b=qfKxy6cH3LSWHd0BBLf4zCi2vhSoxd+61SZ5BBWDvjJrnQp5j574z6xfyd2YPq9TgR8+bE0TNcOySS3POeslvOBPdQWwL8+L+ixX468cqgpRCs1cM8mjJjxFQYUbsY336HLg9ccJnFX4iElgAVSvLegbcaKg+sdqnNMiTujnboY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724872614; c=relaxed/simple;
	bh=gTljBJUC2OOjCg1KZkVNUcutgj1mVqdITHYdTFIXzvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g+7dGTq2CCJMASkCSfmgfbJEr6uVBjn2KwW6GpKgfxku8RyrNbCCbc7VsyPRG8hMKRKw/ZBX5CbezUGfDgVMP7ID7RDpL8ZUu9kvTHns2HDOZQ2p4W2wQvMNFPUVvnSWYkytvI88sD7ftg7LHA10JuEQt3OPTnAuvvBWcxQz3Is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g/vI04LH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fhjtPtPA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SHfYPQ024644;
	Wed, 28 Aug 2024 19:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=S4rBRmLi41q0EMu
	0dxwCLyNSoeqd1FPkglg9prvc+Qw=; b=g/vI04LHpcnp6aTpAkdm1FByBwoG63x
	IVyqA6Pnvd23847FeUYJknltwfWIUlnmmfbeICIzUTlKLKBpAsYNMD04ckBF1IVI
	NfqFHDxE17X96hBqqHOIkPgtU2OJhk0m0Jpc7DvAUdO3oXmHDcRWHRgPi1Y0nDSR
	N9dRkWd5nI5h3Z8+ARpAnOWDoBeE2F00XHGYUWHQHL7T/hqFfvXFXQavPPUbKltC
	7rLnQIBWRB/pHMzf/X6krl8ifCKn7vf3X6/a8cleER3VQNIQBXXt4MpC8WRt+6oK
	dZ7z0TSTDxnvPLyMFGrqOkBCO3fvXSMZsIHv4ugVba9L+7p6YjbnxWw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pus24fd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 19:16:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47SHt98F010512;
	Wed, 28 Aug 2024 19:16:42 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41894prqhn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 19:16:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nI5bER6JfOJjHsGeSEDVePc0eTwsjDQXvCZdx+PbjhltZYiQoaYr2CqD+BhNURQ/zoMf/CRq6HH2Gze6QvvQiTpSlmoFW/Yddj7Aw+bgksq9bFYSNz19AeKU5qWWqmNfKEPc8bouPJVMfyoIHfOdOE+oIXZEsGU+XVaUQzEJWUWv7Cxvyb08pPw45aTyZlEQg7L18FeUCj0qPjzL9iGadICf7Oqc221BHTvLHVrDUpYu+9ZmAzCX86W7lFWGOVFPILVUJ9cjJCvJ1xhXGeXmt72iA9x2r9KOEMbQZSNKXlQCQ7rqdrpRGZb/RJxJcCvHEyH3Jt23FDquXbWq/wdBuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4rBRmLi41q0EMu0dxwCLyNSoeqd1FPkglg9prvc+Qw=;
 b=vQ5/piCgIFNRpKEbSO258H1RLAoZmRp+1RLBoxmnHGgQbh7AaCrIB9PnhjXiHQdifbYfh72z602Ay8juTAQIhDxamxCG8O3wLzFLfXafU+eDtcJBjcapW4jRvuHuvKkv61+450nat3T4yFfEH83DeVjdGfZtVyysVhxOSi7spr+M6v9aqQ8z1YowOvUpW80lzp/CCxKoZLK8yhx3IxSx63Hen7lhNqGZtljAHYO0EeCp0lBd1xLM+w4LChE1T9BB1w+1kJvhlFUT65RwafFvJSqStAfXibWamfp3dnlyOLvspJp38PFLV8RFbUuCUy3VFE1qRYcbp9aRClMVSq/mag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4rBRmLi41q0EMu0dxwCLyNSoeqd1FPkglg9prvc+Qw=;
 b=fhjtPtPA7rSbSsuB75E/9FOQb3h+PDU8xDgtWmWjm4OzU8GgtiANjQUpm/VjTMNWPcN6LVj7l5tgbITbRuCWYwu/3GRCcLnH+1bgx+HeVHeRFuiuQwas/7Z6yjyD7faEXBi0tQk0fYJMHUXklsuNeUv1WEIYUdof5AI+88xkzp8=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SJ0PR10MB5719.namprd10.prod.outlook.com (2603:10b6:a03:3ee::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Wed, 28 Aug
 2024 19:16:40 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.012; Wed, 28 Aug 2024
 19:16:39 +0000
Date: Wed, 28 Aug 2024 15:16:37 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 01/10] tools: improve vma test Makefile
Message-ID: <dnnox3mshjwapiafkryvw4xqgi4cnqfhvbhzey26m7ry2kkzt2@wihdiunzi7pz>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>
References: <cover.1724441678.git.lorenzo.stoakes@oracle.com>
 <31cdc7695e11b6588574431666d806e5d4e3a909.1724441678.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31cdc7695e11b6588574431666d806e5d4e3a909.1724441678.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0274.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::27) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SJ0PR10MB5719:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e7f83ef-29a0-4d77-9721-08dcc795f15a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hlRoFcblFY1qkms+YprIdS2ymF54Ygc27zpBcl7TvNN/FDzpaCtjPPEH2oOC?=
 =?us-ascii?Q?GR08TxbN/ooAUFV0d/21iHmJ4Sls4tXY4io2YvpzXUy4/At1wMz4NDkLV1v3?=
 =?us-ascii?Q?PnMxjBZaA8ZF5L7cdDmul54GoNEylTRoCjuevfVIySVVu9zPRKQLJuoOk5r3?=
 =?us-ascii?Q?NUuTWA3/GldRcHFf4IKIlFo124LOshpzmqgOB+MX2TdmcRk3G1YDJbeeo9TA?=
 =?us-ascii?Q?Hgy/DN7atHxhWso0yLpM6ysj+BJLeiTrEasWodXIRmcFPzx/dmyxaPUk6mpu?=
 =?us-ascii?Q?486cVvwvzjxxPpxwAUUkGtiR+qDdvA9nIdmnHk8rb+47K+wZC5t78pVc/Iib?=
 =?us-ascii?Q?vTMuMnczkpXtcRaaDcRMF/YsvyTuY3TOTvFaDhQesjvROC22P3xdKj6Q/Y5n?=
 =?us-ascii?Q?p+S0MHqxaMb/5ke2CfO7dfEyE97Zdpy3hB8ZT0F8IXup7LzcTnIuZPW8TCh6?=
 =?us-ascii?Q?mjH6sbfgf4HVt4QU/GqEXEEVh4Hkvl99ZC1n7hxT/wPEUYEsh4JcAlwMsCED?=
 =?us-ascii?Q?cC7g74cJYFB/cy95mHOOxeD+ZPCEY9n9F47y5QGXZcicVI3VrfutCzrNLkQW?=
 =?us-ascii?Q?2id/66WGdYAVNJA+TyuEEy4JA+m421w/spfbUDuhPM7JOjDPEV6kExqmNJvM?=
 =?us-ascii?Q?UsMPqW/wgNnTZT1CCwsFT/yNBBM//Yr0rG2Bj7xLfpNQ0XswrU9Wuv9W17W2?=
 =?us-ascii?Q?AaOC1fbkD1FhR69O1Sj70LUzGfUt4uHOIkEtgc6t51fdIWkk+1BZ3nBv6Cm1?=
 =?us-ascii?Q?VmpQvvl1kjjw2TEKFi4CUF92bl+TDmTK+aYSv1XlrAuc/QctNx4YObjlqOUc?=
 =?us-ascii?Q?4l74N3RRN617l680sgjn4tBbUrATHxcvtUE7FSC6mzyZF0RaHcUohYVC3E4N?=
 =?us-ascii?Q?7x+7GLb+voaTgkcPa+Dcs3mXe+YQEfCtx0d4ie+Ct19JSEMb/gkETISg44Ms?=
 =?us-ascii?Q?SrpgU2unKaUXT2eOTFTh30BjjH/s0+PsH82sWH0kLniIuOxaVANJXI+siHc4?=
 =?us-ascii?Q?iTEzRpn6P7LUIoQtxKiq+iWq2PX0mOUIPSpHIrNS8iDkExWmqkghbtn11WjF?=
 =?us-ascii?Q?F04bKRXxE/DNGUbZqSZxBfPUoQ3wU0GGqYriufyGu+SZ7Z4wMoAtU7ztM+cp?=
 =?us-ascii?Q?YRS43cO1JEt/XAlsJl7B0BNRj14HRpqPTXf7tFH1izzHWFfVgDd7DlYO3oO8?=
 =?us-ascii?Q?WyokVMEb0XBtRNUfZ/TN3v3InIUA4Q61ihTeeexy9jrSNKRFhHD86lQf7OKr?=
 =?us-ascii?Q?5ywqkjg5z0ST0DQ7NygG1PTvhHLjrYlEoYvIPbGuu7CuEgpHn2tmECq29hXb?=
 =?us-ascii?Q?DBW3YucryZEsAt/9+DwD9L73uzBKLvnIgJN8PcWrUJVHww=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fp/dWlyCEsj9adhCcfdXphSsEAuuGclFdqraLdVR1Uzff8Tuqg+JSnqTJ+h6?=
 =?us-ascii?Q?CryTrVQnnK82ZgcL5kICj/RiT9lvYQ/Q4axeL0ygI+eDexmkYy4e22pqR0T7?=
 =?us-ascii?Q?Xc7V5nGG6qdDZQBTfXiRf+qi8TMcBv2oYhpY/NJIR1OgehO/GUXR8I1EBoX9?=
 =?us-ascii?Q?OCAhaXtrMi4JmyWzUwFmtjehTFaYx17xgWjMDmzIUDEYmUPGlWq3FzioA+nq?=
 =?us-ascii?Q?Rk0O7hFVj2QriL6d+hFYESm+2MZBb1JiV6ao8Jql1PvkYVGbXZZW0A0I7LcK?=
 =?us-ascii?Q?oDOySDgf0LBxfJWJfb93DOdPpWbBHX7VJ6OgA233vCeAMmz3oFNRJkgA1kHa?=
 =?us-ascii?Q?yBTJbic3/3Wc9EmO2s8fnLM5nA7K4z2SlhASsjGtJhTaWVdepK6XkKJD8fgS?=
 =?us-ascii?Q?kuq1wrQk/b8V5IAuKN4t85grlqCbD7616PyzTEBEtliUMmsiQggs0TooJoo4?=
 =?us-ascii?Q?djdXEgF6XgSvN/Rg5IDhJ6b7p+cOPPD8vCESpxSIOFe/+Z8783M9ISgGqkwD?=
 =?us-ascii?Q?HXsKK/deRxDtW9RoQF18Q4LdLJ0VKth9eWaoDobcreByQUSWXyj/S+ih/Ikv?=
 =?us-ascii?Q?DEIXFHleIeXZ2902eN/BwL12x2bGE6+zl9t9JbjMU8DMh7gjf8KTw6bqCvWQ?=
 =?us-ascii?Q?bNMnoB2EVh9sGr/ZSClX6/tSK4jEuPOUSmYWTti+TIqJcERsLO/JFuNdWkRn?=
 =?us-ascii?Q?nEBTqZ2NvXpEzLD7fDld76hNgEjHixqk6Ab62csBeXDMyzbMoFWoz329DhDx?=
 =?us-ascii?Q?IjfvbKbvtEtpjqLB2gYTtJ9gOWg6LOXrN9a99b5MmGLSQcu52veAsmJR2jql?=
 =?us-ascii?Q?TlvVLeHPxnGwe1KNhS3KZfWiH+3YSDSb2F9grNtW+7zTWT7wUlE/cikCOSb8?=
 =?us-ascii?Q?gYR/rnENiRAWJTQ5SK4yqt8QD3zfI47/WK7/edHjPeUs67tsEnav5zmAc5Pi?=
 =?us-ascii?Q?mtguBEE396+Y5r0hPaxYHFj5Vo+/Fm8gGtlm0ymsAQgkbMHNmR+zKELoFtPk?=
 =?us-ascii?Q?9rYzlTORhgZEIdpk0dayfZcy9ROeihn7XCrKBbJZ+URoxOF0dd8GrUfzB5pg?=
 =?us-ascii?Q?aA2C0myjN1H+XB8AXjkMrHS2nOPYME4bNcZyoM16M9FaSKyMOpKcvFXQQJ5q?=
 =?us-ascii?Q?G2rIkFKwUeaKh1BzOePmDX/SlEgE7yDgW54NGIh3TxQsy16Oi35zpO6zjYWj?=
 =?us-ascii?Q?fVUnEiwaQ2Gu0lWHO5ACjsLInaP1Q45UcHiE8Y/kfzWOyq27jlYttifvt0CQ?=
 =?us-ascii?Q?cY+FgjjeyU10jZbt+qqsH9YnimkHZECyfl2EaGUVvQ7uhCF+NmrpN6mZlGnR?=
 =?us-ascii?Q?gpU6BR2pCBIg65QHAmNCXLHiwPpNVnQn8il7BVRCA/eP+L0SvjNJQPtiumGM?=
 =?us-ascii?Q?lgcPFTab9bxRuEdPWFPkxIRdFtZRiGFIUUkZ3kfNe40FZWCs71WbgxX25wLP?=
 =?us-ascii?Q?PClNwGWj/Qcza8lmnNcDss0C6od1GZ1v4FBqr0Im21/aWxICZW3cu63A2TCM?=
 =?us-ascii?Q?8SeR4rQPBmuqVK8dmjkw8afFEMGIQK3ajG95+u8TZOZLhh9SCn/jr1dLaFWx?=
 =?us-ascii?Q?+qyiLRMtzgnDu3Lg/33RObCVty4LUE9bNzTeZLSJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yLEnQZObRoF8jj2f9l0jIW3MdrskCfXAHvlclXW8PqSyyPBaZyC4X7RvF6Xi7yaxz/K1h6Mxf0wSsVdojay7k/kMIbAVkUNv0OPO5gReJ1Z5XTmUv7Zd1lIc2VWLstZldZpbWvnjB0KZeXkHwHeJBgcCCO+oNzjnxo7ZnYqZ5B3p5a9ynm968LblL/mnLDONOMQW8me1jyQlbuGuMzVJ4G0GX1G2kxClh3ZkvxxgNS8SAOIf9smvHH6AU++WE3i5VykFAxfYzTVQfF1/Mf+/QzxAHdAihA8icqsmb4uwQwdmhZWK4HMVSE8f5Uqa0UySp3HXwkZ0aIupabjjwfj0GkoazEX9egl622ugQa4EkvKtax6dXJCwzh1wSrHIBkhepZd7yrNvAzvXD9o598A7ln6P72cB2+iio618ZuOewN+3Ez3wLT+umFuJmgz9HwnoBas0M+Z0sM9hz+i9VU01/ZEg0yZvvBJmZE91d/zEnNUOFWLtAR88p8/buqKFQ4k2UcK3ltcsfhnbfZwtIdYBUrlJGO18WnLsklLiTp7KbnHQ4Ab786w2W+/+oSM3Tv16QpHbUvyXt2gEeAzVHJqMdxngUwfzAMVMk+3iHzSwhRU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e7f83ef-29a0-4d77-9721-08dcc795f15a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 19:16:39.4428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BxmXLNloUORbi2RmtCkUOhlKDmu2fvddgfCC6sAzmJT+8CSnitDDn14GFObosjmuArXQOI08wc9KD7KWqnjzLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_08,2024-08-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408280140
X-Proofpoint-GUID: 2qz9Xqs51QPhhl4pj410FFjFDkiBWeI7
X-Proofpoint-ORIG-GUID: 2qz9Xqs51QPhhl4pj410FFjFDkiBWeI7

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240823 16:07]:
> Have vma.o depend on its source dependencies explicitly, as previously
> these were simply being ignored as existing object files were up to date.
> 
> This now correctly re-triggers the build if mm/ source is changed as well
> as local source code.
> 
> Also set clean as a phony rule.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  tools/testing/vma/Makefile | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/vma/Makefile b/tools/testing/vma/Makefile
> index bfc905d222cf..860fd2311dcc 100644
> --- a/tools/testing/vma/Makefile
> +++ b/tools/testing/vma/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  
> -.PHONY: default
> +.PHONY: default clean
>  
>  default: vma
>  
> @@ -9,7 +9,9 @@ include ../shared/shared.mk
>  OFILES = $(SHARED_OFILES) vma.o maple-shim.o
>  TARGETS = vma
>  
> -vma:	$(OFILES) vma_internal.h ../../../mm/vma.c ../../../mm/vma.h
> +vma.o: vma.c vma_internal.h ../../../mm/vma.c ../../../mm/vma.h
> +
> +vma:	$(OFILES)
>  	$(CC) $(CFLAGS) -o $@ $(OFILES) $(LDLIBS)
>  
>  clean:
> -- 
> 2.46.0
> 

