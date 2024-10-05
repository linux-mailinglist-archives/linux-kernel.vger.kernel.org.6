Return-Path: <linux-kernel+bounces-351887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE87D99173D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 16:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7178E283425
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 14:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2EA14EC62;
	Sat,  5 Oct 2024 14:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YdnAE+l1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bQVQu24I"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C68315AF6
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 14:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728137643; cv=fail; b=VsqPuR9qtr4MKbO/0xjNsyJNTzka1JCNfXcBMsBvrp5j3kXZC7TCXhUoQiAVHgC3/iIsr6EXuEu+MWsJEHa76AewtAaj1QEWIDxJeG6PBQNM2jnNoXGBs+22ljPrI9WjJr9JNIOSlVH0eA1iq58eF+WJEAU/AEeuFK5K1B+SSjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728137643; c=relaxed/simple;
	bh=cV1P4gg1Zuv6wjPy8OJrcdhp/BFqQAV12x5Jmoo5vbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AUGSTEdn/VWao+K76MjTJSnruoUDzjVlM2fNdsqC8l0Ifl3+8hbVRDnen/LWSuOAmbqp7Fa/V+7lYsgeh5vM9sA8Utv7jk+jY0dksK1XllKw5nPBnF3tJkff04QpBIms9wpApJrX6g3DzBSID++4ZveRkRWKNqUr5JrnZ2uv4MY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YdnAE+l1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bQVQu24I; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 495Ad5U9023942;
	Sat, 5 Oct 2024 14:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=cV1P4gg1Zuv6wjPy8O
	Jrcdhp/BFqQAV12x5Jmoo5vbc=; b=YdnAE+l1bTN/Fcr0Bm0rX/D4sBgBxuRdns
	i5POgZ8ZvThkn+W1j4vWNkAMstacbYXiUNYcesPNR+gR5/uRgfZ+0PRJQDtQ4bKS
	fYw/E8fOJMvwdVWcdenJf1Iuao3CkWGgO/3UPy2h7QGQhmLy+mbIQbgiuxWD6iC5
	bwMPqkXOg2caowsi1lVjwKeJz6ice1tsD70nFaLHEyNG/HwxYm6izPiOWkuUlgc/
	npyNObPoyVgW/Gw68xkh3/jsRgwVQtKYD8LUDNTobkuVIPy+0zPLXH8U+6LXbn4R
	XNELUuJMtkp/R09viD9VmKEfJ2aIfZ6pDq6PJwE+XCTsvhi70d7g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42303y8a56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 05 Oct 2024 14:13:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 495B5K8x001243;
	Sat, 5 Oct 2024 14:13:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw4awev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 05 Oct 2024 14:13:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5kysVyJvi9ro/XnjxmX7+5Iumm00/47jYEUNdQELK4kxrKRthG2mgm9v9D0fnO0AI8KQ6nO/v8p3NRo/Zu0bK+me/Y1H++7eY4HfoMBBB5UblQqsmq1jzQrLoaR7bkedcus4UKVCwn3HVaWCB5GwUAPswjMNItiK68ZihORF/bSSal0VM6+IkDscxrmURk+Jm7t0EWczq3XxmiJ5cGcxzvi1ze2lQO+GOi8N/jizInWykvhtkpbRoLkZVZ4MDJcabO18CVdyO9pR0OyDr6jsl+s3K0nKYiEGmp5DE+1yqCYVgZB4hyh0SECR5S+et21UAUU1qglZcmEzco2yoFfrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cV1P4gg1Zuv6wjPy8OJrcdhp/BFqQAV12x5Jmoo5vbc=;
 b=bUcOyKHZe4vIzjJJ0mt9NMaizHMkxakFGFLelbdt2HJb8y8d79S/MD1PtTDotL1RN6Bt5URxveOtK3tXSlpBRPbRppNW6JguZ2gJG6sEkmk0nFT4EI3nAdWhSI9L3HwBQewSsUZ2clbxNMULXhMjzb5O30DAAccEvMYCqdDjPvFOtE80BqFnNl5wccQFLXUg9d9/ftZEMWauCA11AWvHXlDSmnkics9gtmVLwVDtKKfUWkf/lpyxJVpMcm7B23R3r3nHFGqv7pvoF32ZQFnyE5r78MpNmKNq4pB2q+22tyCvP/e10Q73Iiwd/SKLJ2Az+rw+6oaH5H2YaPs46HpAxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cV1P4gg1Zuv6wjPy8OJrcdhp/BFqQAV12x5Jmoo5vbc=;
 b=bQVQu24IUm4wOAVwoJIS1g5XI+I+Ym55C3TbgrQ546Y5U2PDxtLZOP/trgoGTQ1LSC7qVyAcFZCZ7zrkXVJBdtrFvArnN3tDQb8m8/7lsIStFuJlJW9UHpmRtVvCeJy5ZO+a86Os0ryjalNPo2UkHol+HNROsAE4kJZ0O4GaEaw=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by MN2PR10MB4173.namprd10.prod.outlook.com (2603:10b6:208:1d1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sat, 5 Oct
 2024 14:13:40 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.019; Sat, 5 Oct 2024
 14:13:40 +0000
Date: Sat, 5 Oct 2024 15:13:36 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: Re: [PATCH hotfix 6.12] maple_tree: correct tree corruption on
 spanning store
Message-ID: <e7d2ad02-c346-4da2-83f5-9857a79fad60@lucifer.local>
References: <20241005064114.42770-1-lorenzo.stoakes@oracle.com>
 <b7eaef5a-016e-46ae-b7e3-2bd16909110e@lucifer.local>
 <2eefc57370d54b70e082edfe69bb98d17fa1b27f.camel@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2eefc57370d54b70e082edfe69bb98d17fa1b27f.camel@web.de>
X-ClientProxiedBy: LO4P302CA0005.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::13) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|MN2PR10MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: 52b933e3-0ad1-482a-2510-08dce547e9af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9ODTgXXt5U4xizgnwFKjAJIgg1fUjfo9VkW/aqqRaxz9Oa8P7GRBf1Y5FNGC?=
 =?us-ascii?Q?sLUGGAm3Zbjld/rg8fcnREMUrwtOIAeK2j2ovQQZqzdmcD8rMdn4LeoZEScH?=
 =?us-ascii?Q?IF73bC80SEMdpvJ69fqBOFIFp4DtWEHOipGNxBJggx1v7HPz2h5PSd65hzAr?=
 =?us-ascii?Q?Zf5MeWZ9g4BZiV33bX5VV3QWkEna33k5vEjf2lhta0Ivz6NjrDwRSXzrZmkR?=
 =?us-ascii?Q?lZZI//C0l6iTgiLglnymKlBa8vNbLwC7bEXQg+5iu20Q0LElaEQ0U8xsuLoL?=
 =?us-ascii?Q?FzF0IfsbwQJx/8ISkMgBqnld8szJe4XLJYzpDwtPS+ue2/7fPv6SFuZodDXK?=
 =?us-ascii?Q?pYbqTYhDCcudhMytWkmLGa1Sij7+2MRMrbxzwoDbFA/VJHlDIygFQYzRn+H4?=
 =?us-ascii?Q?lOkoEpY2uJR5gfcHje6ntzqLjIWlqzLyNKiW8QuAOew6tF4Rm1YaSYuvPwHE?=
 =?us-ascii?Q?bgkQXqHVNK45aDJpff+CDMGJ0bORbcN9c5+CKu6QTV9xcVueBcADD1nY36x5?=
 =?us-ascii?Q?KqitH5gB81nHxoOSminK63ykGnYM024sHvMY26CHa6dds1dsa6cPGf2hZVkj?=
 =?us-ascii?Q?uzNkOrrpl1PXT6gs3BNTkaV8iYyH8hsu5gI+00U2+YZ2pRYUJt8beiQoTPiT?=
 =?us-ascii?Q?HJVs2dUpm3vqZQAAOijlrGvemmoocn5K2nwwZxh1jHLTzrP1WWAaygtkZGZv?=
 =?us-ascii?Q?lU5ZjH+6YoKMch+aamjelAOYNfWEdJ7Uy2UqhlJXsu5SsLPLE0rEJf3wCaKp?=
 =?us-ascii?Q?m3JECop3gYPHLN7icCR8wJ+b0kmoDKNWoTUaCYyV/BklpL5FQzrgivLCLG6U?=
 =?us-ascii?Q?rrGxnDkO9EgWt2XMBGU34xBcD4iQTQNrd/0lF7N7IQ7dwoQrBi3IMnEJj0lZ?=
 =?us-ascii?Q?PqirrWFW7xi0RNeFPPA1XeLa/nubD367aUm3mLkO9yy7wpbNQB3+HWNLmYz5?=
 =?us-ascii?Q?9uaRpqyqU+WOmc1X0LoDGkj36+4MHe/phnm20Wmc4E9ZWhutnMiPE6OxG0hc?=
 =?us-ascii?Q?ya5cvUueYa7r9dCukFxvewYT9ejHq9J3aWfuWyzjNFfcvEmeW2KDcn/A/mAd?=
 =?us-ascii?Q?0h1WydeGGES6la5y+9cIbPumfAGr5LHpV+66bo9Qeq6eQafJ0q0E8B7Lp9Dy?=
 =?us-ascii?Q?nylumCIkv4qcjh6frRUZi+BQiE0PmLTBCYPKnbIssHolSMMtnQ6usYFTv1IP?=
 =?us-ascii?Q?5xd49gYrRX3su9f/o0QAKUM0jv9lDpA8JG7x049uEjunm+2oQ7QRSlhQfo3Q?=
 =?us-ascii?Q?LX0Afx065CaUyaTMuYxkgzWww6YnlyA/wE8BuP/OEw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cL6eRJSRpOxtq3OL3akXdfnvEblK1kVLBh0OTl+W0SetxgSsLxhTuZDto81N?=
 =?us-ascii?Q?FYXmDjeiP+H/J+/32Rmqi2JnsEkT85XuloObeAYsTf0PB1A7vs3kqgJK0uh9?=
 =?us-ascii?Q?C8VPMz3N8RW9QRCapPB1aWW7nilyEhYelPH1qPb/uHBkMNl67KJ2O99mhYfC?=
 =?us-ascii?Q?0fHvMVIuq10Z9xBi/O4EKHFt6u8pq9wiwVWV6fbFk9xgudDvPBrYMCNil34H?=
 =?us-ascii?Q?46/e364QAeWTCKsiFyc327vy+SPyVE7JOXpNsCg+ks9N/yXkZMFXY5KDuCkd?=
 =?us-ascii?Q?n7WkDVe6pmopYecs4vnshPSvBuZc1y3xRoekr0BsA/Vuh2ibc3z2DBBafDOp?=
 =?us-ascii?Q?bPI7t/jHQsje2QzJJD6/oVdB+WZOkiI5C9UphWbnGBrnGwKui9Y86JxFD8Kb?=
 =?us-ascii?Q?O4fPZE4FXsIfBgLWrVbeOfzx1NgDSa+uD9Q7V+92Yb/nxiGQSpMOqenl8s3v?=
 =?us-ascii?Q?w2eJQShvVgCgs5ihRXVT7jvBFbWrgbNAUX2i1B1YkiJW5MYFHu7jera6x8rL?=
 =?us-ascii?Q?rTqgTc83S1vnwIp+aMnFMp3toFQak7aKjbi1mg70ajlrb7yw6IyoD+H8KvjG?=
 =?us-ascii?Q?20XrtjYXI5RwqRUvM4KOtIaxpmPR6AU3QsAj5PjkqUW0K5ttXhqXNnEjVTOT?=
 =?us-ascii?Q?fBzSVOrkG9WnqTI6Yq/pVMBCSK4YHjg/jQpX3MatCHnOGN/Sz+9YhfO6sh+W?=
 =?us-ascii?Q?lhcO+tLpmqKEOZVUnxwMlKdIC050q6vMpF3qMniew/qw5lhHjxeWFHHjXaSy?=
 =?us-ascii?Q?xcnFHUy6/5pOwBZ4km4B5L7A7vIHZ1Bk2t+PKD7B0DXdtLUQzOpuEHkfMT5P?=
 =?us-ascii?Q?nRkohWHnuPHgpylr9DSONMKcPBkIi+sXJVFI1we1cSlq+erCCpNNz8wWOKp7?=
 =?us-ascii?Q?pcul3aEvRhiE9ErDtdxXzV6uiSPooVOdqEAyXNBuQX09ghgZ7ZX90lKhabF/?=
 =?us-ascii?Q?SEv8YprcfcZaAvY4iog4d58jU9OoZGC9NaIRBv8UcCUj291nCV83/VmFKlY/?=
 =?us-ascii?Q?MH3uF8SbEFE81ATYTbqZL/SooDIBg8fL+NFU5MxuL+WcNb45akwpR3vhxP/R?=
 =?us-ascii?Q?NFMR71aU/HvU3Z9J+uWNiPx2yOayuuV7DG7LeasRSbCHp9T2qWHrM3Qrz8yy?=
 =?us-ascii?Q?3E2oBnduEMnn6bJXeRXI3jfDsQ0FtKHafrgnvLrWXbRTg1l3gC/UkEER7+zu?=
 =?us-ascii?Q?TNrG4nW/bpfoyxol1bUt5QlHr+8csU8CeDdUDy99bG5uulS3QeIqD91kxn1E?=
 =?us-ascii?Q?o4zDzpC/JZ1l7aPTbjjfX0zHyfQevsq2HrpmDpErEDOXJ7bfDyDiLSE/AoUP?=
 =?us-ascii?Q?xNbtcAsX79bx8twsjI3Z1bMsHCQ6HNmC20O0iilNzAAewDoHUqdXYlRi+0EH?=
 =?us-ascii?Q?p6w2aMa6Utb5QGERmmOwR31RETOJ9yGtwKpcQLZKC4d2oBDDscZcuBy1Sq3J?=
 =?us-ascii?Q?4TY3hZVUI4uTgLMDQGx8L1/LzkRWNnfZvo6t/UMAghVdguwCAmvjbYQh0LJr?=
 =?us-ascii?Q?spRs5NOvB0iJpkwH6eNFNNpxHhJBh6T4aUzp6piTokkK2WfZ4nVEfzmQPey2?=
 =?us-ascii?Q?ygYX+sa1Gfc1UcwQaLdYnQWbi75dTId0th7/vnXWFe1b3etxRybV6B3+1a9/?=
 =?us-ascii?Q?CxeyZGyzM9zO6qoxOfpq6kYRQtDv7eBRX5as/EPZ6V5O6odZIei7bV3C9IHB?=
 =?us-ascii?Q?ocLnsA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tWteb5164e/G6D/w8wBVXrSROfoRwKUoVAbAkgit9A2LuylFlIJIyLGtlWPqVFQ/HqshTsI2ofIFOCfrG1KMqSBYkUxDRWwuE/5gq4Ao4YfZyO/pGOFfMgYf2w6npa1GgktmReFGFFv1ZO/JrqBBk4tfpwlfU5FJpNiwy27ijNFQTcknzb2hyVCnnRjXc6DaxFiQWMQk/k/U+FpydlGTFhca37h5p6/nkwc4ed+dYZ8bl5woXVl2bGonOKiw3GovTndxf1o7pTHvwC0itroAq3rtj8Iuekk6wiIwcEC3GYFC9OutMkZEBlxJaVH/AMUnd3eyMmDSGxhiAnyJfQYmBSdE6j+yciKadiULeXlMvewuySDBjnHpZfPzitej7YZt+9y7t4JVx/hduAwYWrCDlnzN5qM9mpTDovuy3pK9LWeDTJI3YGqxRNmS8gU4dToot+0i2RWNMPEAGXOxlJ4pFe59W3UzIML9BdNywlarOJPQu2WCP6okJztXbbG64YVIlEnJ1SyPrtoP9TSXOlPvwWI6/alnvvueDnD0c1av1ZNmu5OGVNJA0GXpUi99mJYZn9VzzdMzsybHJPQxutAsKX3j8N3N4i44k10cUiugY6s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b933e3-0ad1-482a-2510-08dce547e9af
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2024 14:13:40.6803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Trfq3UgOcE1T3EdwpuE1CqBDuZysdB2di9aqalCfmcLxRNnWuRE0GwVyzr2h43bFWJu+vavJNX56pews7a8fTqD9m+gN3AzAenjNL14KYSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4173
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_12,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410050105
X-Proofpoint-ORIG-GUID: DwP36ZMjjHzuRohAfq7QgO9CEjbAyo_j
X-Proofpoint-GUID: DwP36ZMjjHzuRohAfq7QgO9CEjbAyo_j

On Sat, Oct 05, 2024 at 03:24:39PM +0200, Bert Karwatzki wrote:
> Am Samstag, dem 05.10.2024 um 12:17 +0100 schrieb Lorenzo Stoakes:
> > On Sat, Oct 05, 2024 at 07:41:14AM +0100, Lorenzo Stoakes wrote:
> > > Writing a data range into a maple tree may involve overwriting a number of
> > > existing entries that span across more than one node. Doing so invokes a
> > > 'spanning' store.
> > >
> >
> > [snip]
> >
> > Andrew - just to note that I have intentionally left stable off this, in
> > order that wre can allow this to stabilise in the 6.12 release candidates.
> >
> > Up until 6.12 this bug seemed much harder to hit, and as far as I'm aware
> > we've never had a bug report for it prior to this.
>
> I still suspect that this could have been the same error:
> https://lkml.org/lkml/2024/8/28/1558
> When compiling the kernel without CONFIG_DEBUG_VM maple tree bug results in an
> unkillable task, and when trying to kill it first produced the rwsem warning
> (and soon after took down the whole system).
> But I couldn't reproduce it with the given reproducer, either.
>
> Bert Karwatzki
>

Thanks for reminding me of that one!

Yeah unfortunately that thread was very unproductive in that the reporter
gave no feedback or further information. They spammed the list with a bunch
of such reports many looking suspect...

So it is possible, and I suspect that this bug may have caused some other
'weird' crashes that were non-repro in the past.

The difference here may be that we (or rather specifically - you! :)
finally found a way to reliable repro this to the point where we could
diagnose it.

As far as I can tell this could happen even with vma_iter_clear_gfp(), so
old unmap/MAP_FIXED behaviour could have hit it.

BUT a difference now is that we essentially combine the MAP_FIXED with a
merge and overwrite everything in between, so this addition of up to 2
extra entries probably pushed it over the edge to make this event
statistically likely enough for you to have hit it.

Note in your case it took unmapping 6 (!) entries and merging another 2 for
a total of an overwrite spanning 8 entries.

Anyway, assuming we so no issues stabilising this in the rc's I will ping
stable to get this backported and fix this everywhere.

