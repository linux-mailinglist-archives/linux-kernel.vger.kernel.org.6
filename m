Return-Path: <linux-kernel+bounces-209015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37092902BDA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 00:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 505CA1C20DE1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EB31509A7;
	Mon, 10 Jun 2024 22:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V9J1ysqT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BvjBW4X6"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95395466B;
	Mon, 10 Jun 2024 22:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718059321; cv=fail; b=TM4GoPyyzxcTQo3alPgZOoOKkjGkFh/Ey0RBjVohYnfII05Hxe9HkN1sImTjQcx5cAvsu0uY2UH9CRm71AoRNxk/MG5uEQVstSqc2OaB0Wo18tI3wNrm230MMch4sAa9S3dRYXAg4DQbDimRlBpzn/rTQu1g1pc2wjdXJWLTuQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718059321; c=relaxed/simple;
	bh=sFm/hidqQXBuXNv6dnZvoe11wCLRl46sdDB+SJHuAtM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=cwUTIcEjUx2HUF1F/GZzvteEX5uF+0EjC/Onb6AmJEB1VNcrJAvjOibP1blyOzjfEZcIFGTd6mj3efXEcqnri2u9aKEiAWiWPbHi+t3Qenonh8lowDMfAIs4GPUCIyenE/9XQz26X/FEonPLCphG5Sk7NZ4XSgz7gG1BWjZX+vA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V9J1ysqT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BvjBW4X6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45AEMOEt001920;
	Mon, 10 Jun 2024 22:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:in-reply-to:references:date:message-id
	:content-type:mime-version; s=corp-2023-11-20; bh=rhjoLtrSLyEvMc
	7blyZYzoA6yKQns71ftHPEnqry4TI=; b=V9J1ysqTxTlIIBG/yhNsEqGtYxKvr9
	3EVzogMmz/7yUYXMI0zmMLHiKDvLjJBuT2IGFdUtyzf/mPwmIjL16UYjY3kZvh3M
	bVv99azm50s4+jav6t9BVCOYcvQr+75uCw/WuQlGwQymZ/e0Y8o+SPPh4yHy+1zQ
	NxsiCYN9EyNjd3KKNQDjgknluIYoIe3X3UdEj8Mm9Ji548SnD+Wv0qnl+Nrc5mz+
	EOX1F0W6jtkSja5x7N/J/y318Y6Hi1hvvmHFIs8mp2OOoQslkWxBwaoXg0ZMAmvQ
	IA7mVl3jQIOLi91LnH/5O8fhRSDhZ7c/x5lPReVcN7mAsIx8d1+0iJ6g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh193p86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Jun 2024 22:41:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45ALaVwX027051;
	Mon, 10 Jun 2024 22:41:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yncdsepsr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Jun 2024 22:41:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlGyFt8TABQ6mi/6ULqvKVfpyZE3dGm60Rm/Jr92jyWgEWm2PSVYqe1r3TeLLVlB20VtW4v7Oix1O9silsjS3RMYkPKxy2XHNN4tcI6igru1PX2thJOBOBZGy8FFeTbDHBVFksRTtnhdaNBpJX3sah7EjXvO232H18Gd7wvs+FajGwZWcRu8mxkdf92MmFwl5jX4DECfIv/YB0NtT7nHueZ18zvIJUONeaM62QJx/OJCDl89cu10lDz0cxPZD141GaaPhehdrNRlFUqp4Fn2aMCGf/7UTInhUYcBGVIf1k6+5wpBglBdBYZ8oVzZfT76HBnezvDW3PHFmF4YuY8NkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhjoLtrSLyEvMc7blyZYzoA6yKQns71ftHPEnqry4TI=;
 b=PklXsJ0qiuEnbALJdgzf5S5t4Usoj+r1Ybrplnkd3VEX/+x49n1MgUl/r1s6MycVpsbu8V2EdnEHNwT5K3oF353czXhbr/KFZpoXSYsucXj/LK1GePEGEeogI4qGzJdPYtEJflisQU9Uu3Wv38w8fw0xFL2RufuI9Bxc2a3p+MQmYO8WUH9LFAGeX1Iq8bEz8eYAnc/r5RugZ+MXmvnbHsYbQqT9w6wtCVTbLN+IQqbEGBz7YtNNikUhJCDqtNXQzmFLJ+C1T5lsjfj2l3o5l5jHQh5hTzQKay0gcFdOqBuxh/bia1vw+9DcySpVNU2XvOnNMcw/eGauLVrQ0XD6qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhjoLtrSLyEvMc7blyZYzoA6yKQns71ftHPEnqry4TI=;
 b=BvjBW4X68zyUGq/hljhDfBOLSO42CGuvUCU6NpASCo7siemYQjPXmr3vSziJ1Gn8T4E7ev5A9397trgy55hr8Vjuijoul+sCl9ECLi5nVmAqJCrrs6qGDVUOdvbEAOzFy5zjAducz1EKaH5oNDtxWlvX/T5pYPkjpDj1VncoVwQ=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by PH7PR10MB6275.namprd10.prod.outlook.com (2603:10b6:510:211::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 22:41:34 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 22:41:34 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
        "Vishal Moola
 (Oracle)" <vishal.moola@gmail.com>,
        Omar Sandoval <osandov@osandov.com>,
        David Hildenbrand <david@redhat.com>,
        "Matthew Wilcox (Oracle)"
 <willy@infradead.org>,
        Hao Ge <gehao@kylinos.cn>, linux-debuggers@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm: convert page type macros to enum
In-Reply-To: <20240607212738.bf55318aebd7172fadaa11c5@linux-foundation.org>
References: <20240607202954.1198180-1-stephen.s.brennan@oracle.com>
 <20240607212738.bf55318aebd7172fadaa11c5@linux-foundation.org>
Date: Mon, 10 Jun 2024 15:41:32 -0700
Message-ID: <87ikygo1yb.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:208:c0::46) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|PH7PR10MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: fc600c35-824f-4c66-0166-08dc899e7b3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?BF/XQVPzzYTvaM+dHQE/BJ/fTq0FeyT3lNIx4RCygdyXnPivd3/L/WQHgyAd?=
 =?us-ascii?Q?kHhZZonz9dEGwnwjbGzOdGn7glaiIE52Pk+022pYolBse43071Njage3Mj5e?=
 =?us-ascii?Q?4VI2GX41wJuEOc0lE/anGrj/lJW9imIo66JH0iqEO2wshq9cBOurWFXMDOGT?=
 =?us-ascii?Q?IRtJS2smnIc87JbKiuMV6O+d/oMZqLYcSDQvG3cewuOw6t8JOZg829it0z6E?=
 =?us-ascii?Q?P9pUn/1mC7yQxybLimGjkEUSErafQZfg9Phb1QEEPUw751Lll4jyvqbiervh?=
 =?us-ascii?Q?LbHVs7T1tLPvIecC1FqcIXxXLSSNuhknF0HSU9gAw5lq6zbhIWJ0np8gv2Zi?=
 =?us-ascii?Q?xbcPlaGYisefaxf8U6XCt/LCFSvhHhs923/1WqMJea4vmpZF+aUZqNo66tYs?=
 =?us-ascii?Q?p3pBr1SymTIwVnwdiapw6l6g7+/OfbMd77gkN5zhcvPrnAIOjFpXS6zZB0vb?=
 =?us-ascii?Q?AKerOslgSSyeW6gpeFF5Dud/dUs/pDzpsccLx00mvQSjeSTwgnZhE4R5Mckq?=
 =?us-ascii?Q?XOMYrvtCnu2FcwSAeVtdx6SUxCKY5X/KyiFqoPLB1o8fSrnstnYI7W6cYxFa?=
 =?us-ascii?Q?2GYM/sKjvzdd1gar6eZc3SZ6P/4Y4jZVCi/oKfjwpP1w26/sag+9IZmQ5gbA?=
 =?us-ascii?Q?rRirf04AOeH09ZOIF2dWqJqA43Lbel+fDchTFRYNB/evl/sp+mzX65q4XqAG?=
 =?us-ascii?Q?WnT9UVL9hy0a+zwz7pRkwaDFy+CgwvaqwXlShMMIfPWqX0uKpglI5m07tMgD?=
 =?us-ascii?Q?eYRDKfNqJDFyxtyyPZ86aeS0IFq2pXe4xm7CNEzvbQUpMX9PVpRCk2z9Gkax?=
 =?us-ascii?Q?4wNDlwrLG+8u6Ct8CWMCjxKYbwAXvVv2UbWRpSgBNCTM1HJlCGVx5s2lAgX4?=
 =?us-ascii?Q?sxxv5iMXBUaSGGHfdzsj5q7jmGlAIm7wmO22aySGbxeA89yvnPi0+2i9FRyl?=
 =?us-ascii?Q?00ptGq6QIbMgXG3wmWcdGrwcAHSAfdqpYhKWNaXB7l5Ur1aEX6mGAhWVM/MG?=
 =?us-ascii?Q?yBbELuySV9RMlXbbsnAhwOY+8pAm4ABsfNQ7dpY8Qh18Jd9xQ+0gq623wz7o?=
 =?us-ascii?Q?2DSb3GzEfNXTXE3twfpAAoecpMxPwQeEixyVi93RM8WqIS97KjYcPopPbPFx?=
 =?us-ascii?Q?GxRWY8uZASI3OBUMifo1RRv0tPuQBTGoKDQXF4oqCfIbL585AR+TYqVl/P6I?=
 =?us-ascii?Q?kbU5cB417uM7uFrBwRO+HnXVrO/CbDRsphjafheTFJObT0xWSt8GotwfeKwr?=
 =?us-ascii?Q?Hprkn1DOrbG+Ot/nB3l/YWoHLNRyHUl+QHaGQOuo45PLPHvMC9pcjaPQnH3x?=
 =?us-ascii?Q?DcdWRHTw3BrXSpXqrZYuSqxW?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JgkY5l4Y1cZ4f6l4xGlqZAAYmQmN8SrHq6LlkFtipIW2axYV4zuRgburPoFM?=
 =?us-ascii?Q?lR+RgByH9RvRZylCXuS8PNek+SOw/U47z72CCpz5mIsRiqBq1YG+pNI3DmXp?=
 =?us-ascii?Q?AdcLeg1MLq59s7Xj2j3qWIADobQnKhUGvS4Wv9uSDrdiJ8W3Dh5lD23PMo8Z?=
 =?us-ascii?Q?xY0frCTYJpGb42CmavLDRG0C9JKmHbbTJCLVd/pInFlNdq2Sch1WxIy+bEs9?=
 =?us-ascii?Q?JGbiV2Q4UodCI7vAK5LfDsbUUy92YH0cGObGW+ZdhbDwPs2NLO1q9Bkp15Mg?=
 =?us-ascii?Q?axPHBdznufbYqF1mfWDyYA4vYVEKnF1UsDGQTPWMDXj+RtAA1l1eqSc+Fy9i?=
 =?us-ascii?Q?kA56DUtwu7MIubQLkLyeewJMcMMVXnsaqgwMWzDKYWNvh+mSfXStC/ztJx9m?=
 =?us-ascii?Q?bmrC5hLJ1cj7n4NS9vRl9YHxQESSAAwax581zLb6gAgGEP0gYwZ2uMgDz2BB?=
 =?us-ascii?Q?WwJspV5Fya2uvNGm+45ll6+UD+jnnFMaegekh5Z46SSlnSV3AC3szgZH+4Vg?=
 =?us-ascii?Q?v7n6zDSM/usCuWNSPQPOPwRgPzBCbgBbmBu/gFy8JxgMZVg+N/XRDxpM9pom?=
 =?us-ascii?Q?A1P9Hy9YtYznnl60piUiGubAWw77CVGCO6gKYBU1C6G+4o7spWh2ajkGviko?=
 =?us-ascii?Q?X5Wgeqg0sGw6vjx4LIyoLwN0O7iyiZY536jM0Oe+i8aNj4v20wbDH2pYiy5w?=
 =?us-ascii?Q?+Fk8Uu3arr/EoL4NCgGOqMp8t7MBijGok5HKhkkJrTTnZmmRB1x2x+pSgMpq?=
 =?us-ascii?Q?DVf5vXltM9IzYf+ZF4QW+fI39qPGvyiq2kRPn4Y3xxz1Mp/MOBgj5JJXnqhF?=
 =?us-ascii?Q?6QUAqhOJxUkObeJNog8uM7mABanRnTNU2ggCwnnP/9sNNb86wUVDMwVNSi7u?=
 =?us-ascii?Q?VMGaW4qrG/LbJxaEV3cmANfJa7RwiFYe5U+MlL89x5ZJZoje3wNBBu8lJCbN?=
 =?us-ascii?Q?h0YzoutEdbt/hrMkMgLA2h63C3y9Vu0DIucWsvxwfKXttOQobqqKhEbnBPqt?=
 =?us-ascii?Q?ZmlJhqSezdiZHgkkxmCWoL5nezXmGDKZAIn2OvK1sN6SCLJipsbqFLVGZD7I?=
 =?us-ascii?Q?2Rt3CIhMuufHzPenlIztGpEQz+/DO1/NaBWNs2RbQfMqGBw/ojd7qspIpjoX?=
 =?us-ascii?Q?D8eN6AvMNa/6mxkXTHnxJIT5T/p0Gs+RwX7zSteb2zpD5bn8AD9ZhEpJZFi2?=
 =?us-ascii?Q?5PAHdpNKs4fbC0sg0Pcj5x26hBlkO7TuMZVkLlM0uIRgxgKFsCr7cY4wzTnP?=
 =?us-ascii?Q?lOZkvU2HhyEc6LM/agxEpZJHNzsea/deyerKKJw6YpwirempnIAFZiHnuBd+?=
 =?us-ascii?Q?LXu8nw+lSkW+NLM/9nAswUzSFTzha1QQUtGDN8+P8uB0mfXapqkgPcwhclky?=
 =?us-ascii?Q?FLqQ7Iyu4Waxzn/STZKewkryIamG5EYB04itoeqh1O/Y83UbimYo7A7rQ5Dw?=
 =?us-ascii?Q?3pdG3HtFl85yjtNAPGTqJiP4IQ+8r9A/1sKFPn5qKmDp4A+tE4jwkOTHNpYu?=
 =?us-ascii?Q?v8PdMUpnWKJeMMm0PRtF+T6Ab7YtFB3eBHcBtaXylWVGml02HGM4jNnvuKkZ?=
 =?us-ascii?Q?3IcQWAomTMYkKPJ+iebPKc1Kry4AuzjIIOnXNlH3SrnloEimDwmG8PRG2fu/?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	KzDvMUUUZ5amdNKYi1/QWviHKgVoyAAbXx/kgWd/3X9Qkf3IzSJ00ISnxIwr1Upl4xisw9HZuBNh/IyymBZioaQ/rLeAVN+jl4FibAi/HPQh/9t/NM+hNUpnqAN7F1wmMvRaDcja+N0ho+H33FbA+ZorNsNCVZk0H4ull6ezJStUWxhPx2yQLAIE41o7YhTzLnHWVUuMWnTO0A92Ae6bfGMyBUZK80hPOl3TbuMWyN0SkNWIbnd3pHG9YCmDisepJL5KO+TcAXmdwyqbMZ0Kxn3B1PRZBe5O6LOR/c8J5suUkR+pjFKhWq4EUhVTYYenXCvwcHVem5q7uwVsAgE5oFYGl+FpbkGb3+JpKa6pt+iroPTc0+WAn5fCM30S7l1c9EPPZxFqkmhgopTOWexMI1Pen+qOexLifNbFrM0o4cqnDqYjF3ybzqum90Bna6X7NQBQn9Hu/FpJBVISHgW0Py+WYuPvdyjUWR+7xdLUAVxcs6fP1itqjANd3dIiR8XAcwhNUWidZ7JU69o7ui+TsrrCtr21LrGmm20H71RrrRuhhkhEdG9uApmzF3q/X3SD6xZMYHXwBxqM3Qn+WcuKgbEgejBQgEqQWv9SzZma2GI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc600c35-824f-4c66-0166-08dc899e7b3f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 22:41:34.6895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQJ81QGSJcXgP+QjgiqmyAGhxnsb4nRm8rTAz04EdPnnuqovilIdy16DZJ5V3cyaVadmge3/DRnOU4PPB4ZOqjpittNn2+sfQRQo5lOLy6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6275
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_06,2024-06-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406100167
X-Proofpoint-GUID: 9H37eLw5_pT2BayIYAJQkzEosy-rXPBG
X-Proofpoint-ORIG-GUID: 9H37eLw5_pT2BayIYAJQkzEosy-rXPBG

Andrew Morton <akpm@linux-foundation.org> writes:

> On Fri,  7 Jun 2024 13:29:53 -0700 Stephen Brennan <stephen.s.brennan@oracle.com> wrote:
>
>> Changing PG_slab from a page flag to a page type in commit 46df8e73a4a3
>> ("mm: free up PG_slab") in has the unintended consequence of removing
>> the PG_slab constant from kernel debuginfo. The commit does add the
>> value to the vmcoreinfo note, which allows debuggers to find the value
>> without hardcoding it. However it's most flexible to continue
>> representing the constant with an enum. To that end, convert the page
>> type fields into an enum. Debuggers will now be able to detect that
>> PG_slab's type has changed from enum pageflags to enum pagetype.
>> 
>> Fixes: 46df8e73a4a3 ("mm: free up PG_slab")
>
> Should we backport this into 6.9.x?

Hi Andrew,

Looks like commit 46df8e73a4a3 ("mm: free up PG_slab") is introduced in
the v6.10-rc's, and not backported to 6.9. So PG_slab is still part of
enum pageflags in 6.9. From the perspective of the issue which motivated
this patch, there's no reason to backport.

Backporting could make the other enum pagetype constants available in
6.9, but I'm not sure there are any users who would care for that. I'd
say there's no need.

Thanks,
Stephen

