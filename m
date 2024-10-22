Return-Path: <linux-kernel+bounces-376941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035219AB7D4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5089DB2285A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2251CCB58;
	Tue, 22 Oct 2024 20:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RRkHlGTE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K1gq3NQS"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5B11CDFA3
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 20:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729629707; cv=fail; b=kWoEbKfGNsHiBdTC8IQz16u3WpJMzUP70HxwG1O3En/njXcYOALU+WK8EWyo17qk7w3uLWIE2gORnN+/uDU1qMAh62oiaWmcMDOYwxHjvxa1hiROGNx6e8po5E7a/aFX9wcvAPZMlykMzfvOSOUDecp9wfqpGlIcSPnqND7WlIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729629707; c=relaxed/simple;
	bh=eBgZN4xb41jyHIkVxVr8miWPKM5sT7f7EMsk8Iw3+/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D8cRtDtCW5ETQvejDhdj7igJamd0tJefOC+00rHn4I47vlKu3WCjZF/SvtXZtvqmfETQp2VklfxHKO/a8WML0jfmxqhaUliJPq5FpMMQhEDHhxqixYKoDNtTciKjVq8vCPCooKQmOPO02YvJRCt5Foj5pBcsAwC7AQNpHzlSE20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RRkHlGTE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K1gq3NQS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MK3a9U013287;
	Tue, 22 Oct 2024 20:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/O91e0wD9LofGQVbbD9R68Czyy5IEr6OFCxJlloVhbE=; b=
	RRkHlGTEceW9skLKTCkH2+KhyGz6ZTg8oXFYJUsyjsUyu5wSeGkZd9wJnP9D1gEK
	T5c8Nc1/Dl6N6pNdEHPuQWLwJ2ruLQrWrRiwu3Ckjpkg1AgoAgV0myqOe/AyJOap
	XOmoE3AlhnI3kSjmSEDFNxO7s9Jajt1gBC2por4QgDbkMmdH2gEFtL4UivN4C/ZM
	sPXE26FS7CpwU0bL+spQUkbrz68JigCLh1omuECLrIyd9hReXQyXg94sGGO1mFJ9
	ZzriUxGqRaMutWCP8g542X4xi3lHr2VAWGugqtqolNPtgNMRYM8EDS7ZIU9OGAZ9
	u/8HAMM+cqwwbwepyl+QCA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42cqv3dsvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 20:41:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49MKXDcN019706;
	Tue, 22 Oct 2024 20:41:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c37ef3v5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 20:41:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/DpYTFyLyVZWco+dKmJRNaMlTFPjjd9WJ43j2mVvHP0zO+Gqf5H3b/T2ujrqcCQcFsNdJw2tyUynSrb7TcCb1eyLgYjgL1FflC4X5BlJuktBOvDJ2oDQaDcb2R+IdMTxcoUAWVy7AQhto1gm7W6o9pwIHI+A4NxdUPG7HwjR+QvinuccyyTNhefiD0UUnt0+ftNtckxTCT4pDUfDC8fJP5nuA994KOPSicAfZFQ1j3LsDkfvvYx/iVmlFKtwdgOYp8HgV1GKZJNuiAIg9QjJnQ+sosCxwSqMiRkR/7E9QUhITEXUBrS0TEcZmlH7U//JOGrPGVqilcQtSGjwBflmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/O91e0wD9LofGQVbbD9R68Czyy5IEr6OFCxJlloVhbE=;
 b=uTPvxf+m3yYwoBV6gOb1K/PFFlQO6uQca/NHHF9gprsrS2Zo7JMqfrn/9OPSeoqqoYg5xpwaw3ol5qEiqEMN4xrDxbHZoYQOQ00jhC8tnbkxc9nbE6xYMxCdJZkD4VzsqhRatycsvP6ovTeHPPch8ZZqFJQriQwrPDuU+yFqII9dKve/1+xAR3gmYLxwgT19h1USZVBdz2qv+wc2v42FhCTbCHTYBG4fYiHwrn1kU6D/qXytfR9zxUQYe8J8QrnSHROpJxJdJb96cGvJzky/Tv3Da7hhqB4YQVJTOIdfm1du/sOZoRU2Coa5uoEGfyZZEcn+/HtYXO7jmV8rSIJPDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/O91e0wD9LofGQVbbD9R68Czyy5IEr6OFCxJlloVhbE=;
 b=K1gq3NQS37Q0/SLRmmZlxIHc8dLbnsVMu96/8g5E7y/FEBtqGh3rU4c349Xk702+uD0RpZ/Fc3DuDS4fpP0XHoI4jxnrt8iXnRtxLDpcXckpsQxe70sxXOlYCSbSQsR4i9w3wHFlTSkdH5mIktFH7CzEiLPazW0yGkAnnRinIC8=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH0PR10MB7437.namprd10.prod.outlook.com (2603:10b6:610:193::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 20:41:33 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Tue, 22 Oct 2024
 20:41:33 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH hotfix 6.12 8/8] mm: do not attempt second merge for file-backed VMAs
Date: Tue, 22 Oct 2024 21:40:59 +0100
Message-ID: <7b6bf6165080505feb5e00b313d2c84c25015e45.1729628198.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0215.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::35) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH0PR10MB7437:EE_
X-MS-Office365-Filtering-Correlation-Id: 086c1ccf-e4b1-4bcd-c404-08dcf2d9ea93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?30ShBGC92MNAhvuyHDLZxFLexKIGbtrpUkBdjOeyRiSJORiu7KiSdYbkW2Mj?=
 =?us-ascii?Q?26b5EWDgdkdaCSWyxJSDBXgB6fI9v8MVmWzaZk2C4Ag8C/hQva+rn9/atLHe?=
 =?us-ascii?Q?yA+gKwArDtzMy5cNLt++5+ZMNKaqq2hk37z4j88PRwecMtj956KBDF3dNxZt?=
 =?us-ascii?Q?BBYPXbijvmbT9Xk/uwrtZl484BT1pl0eajRc7AJNxn4wWDKUPWUwMkWUw4wZ?=
 =?us-ascii?Q?IulpdCWHcjBoU4CI89rn7CJIhPfJnlP8FidIle9k+Z+D0q2lDR73NHkLF9qm?=
 =?us-ascii?Q?e1qXqVCA/t35CpYRWi+myt83Df2U7kuEf0JqKg3fhYyYvotkN7zfPudb6U+I?=
 =?us-ascii?Q?Aq6peMmQZpRp5YukZqvSYNoaMJjjBN2cIUDaoI5f6KqJZ0eVo2WuyxMd0Hry?=
 =?us-ascii?Q?5uuKJ6r8RnXwbHauv6reNDLwCgdFCc9Fkct+YHQlid6a4PrNDqJUVviTBxHH?=
 =?us-ascii?Q?vztYv7XRWVc3YUjDjtVJNL+9ogiIZcDXY+sGzRtQKzHTEvNmk9VZSp3ikKlz?=
 =?us-ascii?Q?ynGY4SsDhWWMVuS2DN6Sy3f+WC2uOeCf3IkGqoyThYeOcBAVW3N/cOf1dr+A?=
 =?us-ascii?Q?1+1EMr6BY1WqHOjwQ4GfrV34BvumEEUm2xYoXDIbBPidXBL9XhUkInKo3Ax9?=
 =?us-ascii?Q?sree69QWlzIoV+n/oA/tHufWoeD8U/Ztl/HbMZC72PM6c2x4fJaZ98sqbq+W?=
 =?us-ascii?Q?LnPdy28IDkIsN4qDnMBmiL84ddbPJVkGJgg7+Nz1Bfv7A1mg0zeQuFQr/vz5?=
 =?us-ascii?Q?GZr9Qdwr/4ORheAOV2XtTjNVUPFEUQBMW9FumyDTK7A23W7y8oIRM65eVIoC?=
 =?us-ascii?Q?JRGuJ0fW4/UsAREdfPBgi/IBGb44zT/ZalT1dbExJCjhRx9ogiU1estY50X9?=
 =?us-ascii?Q?dUDBmBvmNXq8HbJBty7yprwFXVS1AamtXJwHElrmCoHd0yRgDF66AB/18Tis?=
 =?us-ascii?Q?M3kJ6FvbX0ruv8diGagl2jC26v6C4RmxcyGemT9OZ4cjrDbHJ0zqkq6PWKUq?=
 =?us-ascii?Q?90Hxyy5hSLxhCF00Ly5i2dR/IDXcHiSNikYUws/i2KMZXsAWmpiCILp6j0g2?=
 =?us-ascii?Q?mM5DWxBRT1Un1OWlDB7ABARRQdeCx8Gao+gXbszCFDtHdG9+n7sjkEnvs8zl?=
 =?us-ascii?Q?bSUYwzL4Xdr7HJGhvF55zmMUY/hEwZ2aDI+6iXyrtO4wZLyJgqM+zqoK5Znz?=
 =?us-ascii?Q?pLvIXZ3THRBOlUHFD/aesYlFg1W4XuTsKKz7S12nrmHK05sqqbpS8hwZO1Rk?=
 =?us-ascii?Q?WNVqRAK7+iEZTefxxzjvwnNBFeFBIdp46MGYsr5iqSTkNHFyDpoUcZDjW5T/?=
 =?us-ascii?Q?1Vg9Jh7wqKhaKtABgGDpE+rF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AL1jjUIabVKfMDMQTeKS+NOLB8EOHKyOsY/NTdLvvMbwsROD47kpxFDxBNdT?=
 =?us-ascii?Q?vlUYDx2SeCXYalVPQM2iB90PDX5x2rScJNPsLih2tvU+N3fjwx2Bjv5Ar2v0?=
 =?us-ascii?Q?GZ882ENPoHObBSu/b6de/DZDQMDUN8PkiPpfUtmA/iRTsdWdts85Lq50MzwN?=
 =?us-ascii?Q?pgK+qLeyytLMfmlqLdT6e6d7uskl4fvknXST6BtlorK7yyzcnLCMUpl/VM+1?=
 =?us-ascii?Q?eX22mA5+JALeDuW7nrLay1aaRb0zWyALfVObWkBH0P3iKk2Zzp3HNoHPO4b0?=
 =?us-ascii?Q?QghNATT2Vio65LXte165ksHm2Ed9v0soQvQ1YHgfoggcZjg1d0G7Ndtvik4k?=
 =?us-ascii?Q?uipCaQVxP+X0ZPqRVMbMcqFhqnIU67SmBFahJZ+feZqplly4L7C04XPKf5LN?=
 =?us-ascii?Q?VNc4pxfpH0Du7hK9xRn8lGrVTWr07vTLBm9As1HVC8vteqptIS+SQmvVPAdT?=
 =?us-ascii?Q?DBPcyB/I5YGTULHe+zZuprawo7YdDG1sbCUzktOxL64yFdEt072EF8hMRG0Y?=
 =?us-ascii?Q?c5AiSON2RBOJqXGi4tJJ844iHgJ3GLp/XiPyfn1ABFbZZyulN+IrMY1q267G?=
 =?us-ascii?Q?2wY7e8dN5K/faXmfT/6g5Rb4Nz7msip+FV3sauOhfnWX9H4HsMzGhTDcItin?=
 =?us-ascii?Q?x5Uz6ZS9yTNLYimgZglHRNnEmpfOGEKppy2+x/14HZZxiQ5w+0S8RBgrW4IF?=
 =?us-ascii?Q?qaOUqkXf+fAgcHBcQn0jPkYfWRDaqJYahOeHMqwduckmXnOLPqmn6AgeNBxF?=
 =?us-ascii?Q?LYi0YIKANfKf257NkU0fEkaQO0y075w+w4sd+oVOyeRlRm/pm8Y6aWZ6/bkw?=
 =?us-ascii?Q?k0wchCZxb3HOhqvnkL30synRy5bZJhEmCQbwOD+3W5pZHQ2Z7H5hyKQ9o7k0?=
 =?us-ascii?Q?OiyB0BPIohkxT1s3xpe1tEHaLnYb2iEgOeO8JmCTDhXgFvI393gUeXHbNGPj?=
 =?us-ascii?Q?tBswyjnS8pBNYocVJIHRqma80NlecMTltqOFMlwkijYpmkE/bTO1Ek8ZQi5j?=
 =?us-ascii?Q?rHJAO1mDfIqAiXmJwklxaALXmQHxS1q2htuUTJ1yQFvohWqom2aNk36DNbOr?=
 =?us-ascii?Q?7jkXEUuKih8azya1X9DNXTVU5tl3w2ns/Adr5odPFysKKnO9pJYgmq7Mh+bN?=
 =?us-ascii?Q?jwk9jb9irEJ+k8v9SSGDry5OXaoIWQ3hTN7JjQNhxx7sJKLOGVHrZWduAZPE?=
 =?us-ascii?Q?19bTMSTMGZ5aJlMlJyM8FOEAAJpjAuFJ+E+yIoqscdtHBcnSMpxYY7TT8DHQ?=
 =?us-ascii?Q?7UAPRzPhZgJs7MCufLlk/3n4VWZobBvZY87hW+t743VPx6vFpZ2UjQ8A/saF?=
 =?us-ascii?Q?cr3+gMZVWwz9aRW9yQyiniHoIm058lE03qXe+grYKGdRdQxIbgnHLwOexDWv?=
 =?us-ascii?Q?SI0EjW0Hk70M7vgHAYdijeORqcCK8vjjOXgGBkNEHnI2Kuq+NU2Uol4sZs1t?=
 =?us-ascii?Q?PCohI95SwH4Kv9Im/Gu35EoAkCilpBbeoUm2z7PDghE5tPG+lO2/zacBeT+s?=
 =?us-ascii?Q?P1Q8jBTk6xgNfyd6O4NaNZPcJDV8YaoQZaKRUjMA80PP8k/VdMeglTrcGFX6?=
 =?us-ascii?Q?JWueiZnXwsA8XX59LseYrtRu+Q7lYs30LZHqVpM0ja4tRB19G3+pOOUJmg4e?=
 =?us-ascii?Q?pOL8NmGCtuCU9CfIshNwexs9fAKxxAsr2XDYvopyLmYbKWkUsbWLik5jVjCd?=
 =?us-ascii?Q?gIvubw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PI4UNchyM4NbA/8ErWkLLyxGB6P9UW9HFzArjkL5yLCx5wmrqD/xhUuUpXd1FPajN480V0OL7XLTFCdtcgOe5lpXbFWQjoo246zoKuhhG2r51NrKnU4zl3QNR6oceTOhtai0NA0gZxnSQlp1qZRFlkfNcRTXlT5qGF8lZ15SvKrMdEym6JCCh8ya+y4hOgCVLMiZ6A7ys5SW4HJ4q9tNQWu5DlvaCN6+BIU7lGn+xgskFKW9bvagIaBoZfkLZmz7PsPuT/QJlmhn3/rfoGp50O1EWcpjgrlP7uvPbozxkkintupwMmT5kTD4clLVrYb2FUxxudomjRZ4H6xSuw5Y3/2xhHa1oKzHvKIBIHQh6Zn5LhhjB0UsVDF376zVdd0vunVBTEpasdzWpPHqzDgXDNbB5v0WlDuyZp1sAAobU3gHtFomRY5ULdM466CNZ5stXz7/qmUP2b03gW1Vdw0KI0uQfpvpM2rfRvm4ouol+0SQd4v7apylEuGVsb/zwNxsgzg/m6ApIhDJ4ah2dBDINGMuNBZrDjkSyRHpswcAjNY6CCi3ufHKAZkSUTEyc3s9e5Ub6KHxhx+c/+mOrjyW1+AGL8Hm4D8o+u0F5YMSAvs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 086c1ccf-e4b1-4bcd-c404-08dcf2d9ea93
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 20:41:33.8002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7CaO4yRoaSo8UfW9TQwfs6gbS3SkNp/fR6bkfN/k7mVFpgkYQHnCEqZmO8A7XL7i9mN0cFhu+xtVC1gpp5LfjlhVKrJo0vsBVSFt8EId/bM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7437
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-22_21,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410220134
X-Proofpoint-ORIG-GUID: 0SYT3gDCiej8Hdw2SYk-M3WBSiCJQ4cQ
X-Proofpoint-GUID: 0SYT3gDCiej8Hdw2SYk-M3WBSiCJQ4cQ

Previously, we'd always try to merge a file-backed VMA if its flags were
changed by the driver.

This however is rarely meaningful as typically the flags would be changed
to VM_PFNMAP or other VM_SPECIAL flags which are inherently unmergable.

In cases where it is meaningful (for instance DAX) it is doubtful that this
optimisation is worth the effort and maintenance risk of having to unwind
state and perform a merge.

Since we've observed bugs and resource leaks due to complexity in this
area, it is simply not acceptable to have a 'nice to have' optimisation
like this complicating an already very complicated code path, so let's
simply eliminate it.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 39 ++-------------------------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index a271e2b406ab..fe1fe5099e78 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2260,8 +2260,7 @@ static int __mmap_prepare(struct mmap_state *map)
 	return 0;
 }

-static int __mmap_new_file_vma(struct mmap_state *map, struct vm_area_struct *vma,
-			       struct vm_area_struct **mergep)
+static int __mmap_new_file_vma(struct mmap_state *map, struct vm_area_struct *vma)
 {
 	struct vma_iterator *vmi = map->vmi;
 	struct vma_merge_struct *vmg = map->vmg;
@@ -2291,34 +2290,6 @@ static int __mmap_new_file_vma(struct mmap_state *map, struct vm_area_struct *vm
 			(vma->vm_flags & VM_MAYWRITE));

 	vma_iter_config(vmi, vmg->start, vmg->end);
-	/*
-	 * If flags changed after mmap_file(), we should try merge
-	 * vma again as we may succeed this time.
-	 */
-	if (unlikely(map->flags != vma->vm_flags && vmg->prev)) {
-		struct vm_area_struct *merge;
-
-		vmg->flags = vma->vm_flags;
-		/* If this fails, state is reset ready for a reattempt. */
-		merge = vma_merge_new_range(vmg);
-
-		if (merge) {
-			/*
-			 * ->mmap() can change vma->vm_file and fput
-			 * the original file. So fput the vma->vm_file
-			 * here or we would add an extra fput for file
-			 * and cause general protection fault
-			 * ultimately.
-			 */
-			fput(vma->vm_file);
-			vm_area_free(vma);
-			vma_iter_free(vmi);
-			*mergep = merge;
-		} else {
-			vma_iter_config(vmi, vmg->start, vmg->end);
-		}
-	}
-
 	map->flags = vma->vm_flags;
 	return 0;
 }
@@ -2341,7 +2312,6 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
 {
 	struct vma_iterator *vmi = map->vmi;
 	struct vma_merge_struct *vmg = map->vmg;
-	struct vm_area_struct *merge = NULL;
 	int error = 0;
 	struct vm_area_struct *vma;

@@ -2365,7 +2335,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
 	}

 	if (vmg->file)
-		error = __mmap_new_file_vma(map, vma, &merge);
+		error = __mmap_new_file_vma(map, vma);
 	else if (map->flags & VM_SHARED)
 		error = shmem_zero_setup(vma);
 	else
@@ -2374,9 +2344,6 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
 	if (error)
 		goto free_iter_vma;

-	if (merge)
-		goto file_expanded;
-
 #ifdef CONFIG_SPARC64
 	/* TODO: Fix SPARC ADI! */
 	WARN_ON_ONCE(!arch_validate_flags(map->flags));
@@ -2393,8 +2360,6 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
 	 * call covers the non-merge case.
 	 */
 	khugepaged_enter_vma(vma, map->flags);
-
-file_expanded:
 	ksm_add_vma(vma);

 	*vmap = vma;
--
2.47.0

