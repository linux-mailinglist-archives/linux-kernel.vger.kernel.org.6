Return-Path: <linux-kernel+bounces-402912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD8E9C2E5D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 17:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BBDDB21808
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 16:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDC619CD1D;
	Sat,  9 Nov 2024 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gG7jbTJK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tx+bg4IT"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D5719882B;
	Sat,  9 Nov 2024 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731168168; cv=fail; b=KIZwRQF8NGVH1i4BDp23CDAJ6/VUgNtPw5aeU7GHTeVc3yE6jEECbd4LDFZDE85VhffUiB2SPlTKpP4o/NkWEjH/ZuQnX1qT3U3ocXPTwZ5/3IoiLp34F9cq9E4CuIqIHx2Dm2Snw69DQDrEYe9zI3P9lpwp0AEBe3R6s2xIgp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731168168; c=relaxed/simple;
	bh=o1EtuqpSdJBleGlAotP9389k+j6jB0Ym5yxkIHklIEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LVs5lF3zFsrHunMv8HmmaFZjLEUScuhLPMjQEvuB3RnkGNYyI9ocYJ3ThxJENKLm9t57hWaSI/98ekuSdt0Uy4I4eldvN9v17tCwZBR5wMnqL7ZjAD5r4RmPAct9mxuqbwlnQ+vKnsIoWk28FfNn10mKh5SOIReWYGKhj1wWowg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gG7jbTJK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tx+bg4IT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A9CZuQN032551;
	Sat, 9 Nov 2024 16:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=5+cttJLajAntnpMUl5
	Xod3OPSkip4aFOUctLLLimTkw=; b=gG7jbTJKY/SRS55CYlmslneUJZtdFVpYXI
	kUMFKiBd8sOJu5uKKcnEjdoWJGRKmPgjSiu9wIqDrwjbHQrt72kfavq4yuM5l82p
	gow0taJh2tFLaFD0c5fyGUCidcie3fQUgmmuxJHWtCAJ+YbmGKZ5+ZJh2QmaCcJx
	JndDgKHkgnfjHYQ2Tki4I4BYcVarw5ioMDG+cGSVzHeb+0VTQmMz+0mUUMqYr8EP
	5dw7XF+NCylDPDiUsl9blygKnY/bvs3Bmue+BEqpSNTQZ6OySHFKcbrhMrRIpzbq
	QzpXPgD5uDTcLntB1q6nqUswOVYYE8mFSAR/W8xLS+ldQtgk7Nig==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k58bxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 09 Nov 2024 16:01:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A9F9EfQ034301;
	Sat, 9 Nov 2024 16:01:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx65mppd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 09 Nov 2024 16:01:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7Wp4wq3Li7iZVryM+bY6oQocvt2jRZlsQJs30qBGsbRVeRnWTB6QB0TqhHC/FY3WF5ZtYPR9GDouzXl2wCnb5rp7xvCJnnI77o+xqi26s3xeMdp26l9tAavpSUgwyJcWD8nOcglUFgZHZbeeCXL6bwg7K5fNYNKIa5aHFsSNp+j5qscgn4kvokMycjIVziM4E0xjOvvQNiRywKuzPflE/0J0aqhVU5zNT33Qspig1V+2SWTrMFHngE2WC8rtcV6ZuHCY33HOQyfKK2MZHYOvXt9BeOJReC1LOhQ1f8BytbvGPkedv4rc26kRjYCRXiryt2qdFTtnEBEVsOJBD1piQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+cttJLajAntnpMUl5Xod3OPSkip4aFOUctLLLimTkw=;
 b=BGUki6SBsPL5+ufjcEKQ6nGCcN8D+rBQZG4D5ec82TM5/FSRWrG5TznF5X5RS6dwS2ZSgm74SSgShAybdMTL8mQjOqiv0Dj9YGs89eZPokFVdBeBItGwzz4zCjx7zuuev+16NyOfc5rHrJpqGCTCEps9igFapj1DSDeS/rj0pnjGdOZvFKDYWNreCVkRLQyp227IFLmHhg5tsn++f8DjGFLlY9KloSFgbx3Oi9bXGZZKtP+Gaky803wo746Cx3Xyue0mat5UlaSM9kLfelVe0laX5QS0dMjJW0K+swmG5h6n9MYbOgf1WQBIs6LbEO9iOEiI1fsbU/fw7FvQG+0Fkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+cttJLajAntnpMUl5Xod3OPSkip4aFOUctLLLimTkw=;
 b=tx+bg4ITqfPylEkNnNO/084CKX3a2h/cNNB4scVgdGZwL2ucD4pnfdJf879D3R0vp4vYoXxE1IUyTmEvMmgzMuIj+nAhVr8BadruCwW+yA5aNu6ioZQoXz3g68+71zQpvcnLZcrXLGsAS9nZ5WWUPOi3d/y8quOnGybwAooDMFU=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH7PR10MB7803.namprd10.prod.outlook.com (2603:10b6:510:30d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.25; Sat, 9 Nov
 2024 16:01:53 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.019; Sat, 9 Nov 2024
 16:01:53 +0000
Date: Sat, 9 Nov 2024 16:01:46 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Hillf Danton <hdanton@sina.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
        SeongJae Park <sj@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2] docs/mm: add VMA locks documentation
Message-ID: <d3de735a-25ae-4eb2-866c-a9624fe6f795@lucifer.local>
References: <20241108135708.48567-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108135708.48567-1-lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P123CA0276.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::11) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH7PR10MB7803:EE_
X-MS-Office365-Filtering-Correlation-Id: dfbe3729-7356-475a-e7f5-08dd00d7d43a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4tYcx/uRnu1jQ5v96pQIfyqYGA/0EuwNFKE4qLZytLLIbMs0a2y3FINq21IN?=
 =?us-ascii?Q?jta34MMVYr3nUiNWu6HwScYyizRP18dQYpLzotcaiS/b1XZ0Lpr/tIkmJoh7?=
 =?us-ascii?Q?5K5fUafKLyJgooRshdiXVy8/xdCaLhMSfuDjNvbLhirE9Wum0+x7tl2QP0Bs?=
 =?us-ascii?Q?mdEHyRjNcWwVtJp0gkuqxT0TSufSYc4EnFGSW8eyKHiCCXHuM1X9AhwueYt3?=
 =?us-ascii?Q?XYDe1c+24Kvq5BJaQIdDcAJBSJ/cKyeNT/KXwWV2sUrzikP09nn+lvGgyIm4?=
 =?us-ascii?Q?wq0oyWxKL0uVZESKpoE+OICy/pK2XQAYJn86Mh67kigU7Vsv+pAYc9N7yIja?=
 =?us-ascii?Q?Ay55rifzdkwYBwMDcLCOm26dIcgxxHmXYz8ltbznUHX5fQ+SVCVihwwwsKtQ?=
 =?us-ascii?Q?tXUv7MAaXeZ9nFCWcFQXTKmkNOp9JXz+IhAt0i0DxM8dfWvf/HCjTbW0neQj?=
 =?us-ascii?Q?RGfk+MbCdtGO+YFLd83RSvsRsYoyt4xFT5DlpMKS11Hp+f6mVnqrCLhr8tT1?=
 =?us-ascii?Q?WpV27HtdJPHuLqFZJo/uDtWjgJT5yoo2WeltXmlslZsnxuiAtW6kziJKoqDT?=
 =?us-ascii?Q?aa1R5NlXJNQOg20G1D5fUXwknzya+r1LdtPjpoWWPSV5RpsV0NgUgIrF+o1E?=
 =?us-ascii?Q?8LH7h3mTtaNu3bno8y+XwjSF678uUP0p9YDy8fVxJHO1nxLnv01yHPb5o9Cx?=
 =?us-ascii?Q?/5GBwk7rfuciKZqxFw77XZSBIgFRxdTHzD+OT0tHz9S/SgJqPHki6hRz+omL?=
 =?us-ascii?Q?zpDWa3Dt0DyTk6b4LhzXiE6DtyRljCfYh1Wqz0h7P8YskVqB6QfSPBqg4pHK?=
 =?us-ascii?Q?RJCMLg1qDFc//3f1WmtHJzKXoPckvriix+30g9y/Fe9U6HmkDbemtxUjUCh3?=
 =?us-ascii?Q?/5twN3td5o09cqKy3UO3rgHfl3jQN4Keti4ndKwEnpMVdYOs6uXsD8503Qji?=
 =?us-ascii?Q?nH1noCB/P6niVeg0xBoOr5SEGM0x+X2G8co5g99uf5/HACtyuQqNGYMi4njn?=
 =?us-ascii?Q?F/XSTCS3SnvYBSjd2orxuYKr6ku+q1eerjtqw0AvLe06Av3Rq7AcP9GYDpvf?=
 =?us-ascii?Q?bsxSO6H/jZ/hAt2Ss5W3jNWD5j0P2CICUKkNpqflhWCuXqgdutzddSHaS8hz?=
 =?us-ascii?Q?mZhD47oE0Lwq/CiYGs6Pqpw57PhUggB5tnDqjOXypLm3mcjea2NoLfoPrAPI?=
 =?us-ascii?Q?5EsoXCny36bKsh0dOn8hIXAg5RfvypMrYu7CznnqC6Xr6aqxFvxZ+jOYKjp7?=
 =?us-ascii?Q?bsenxZ+K0Ye8PkvCHZpz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZCentWqdttip2RXo+41DbSlNzpq5qpoTpyypVV7urJT2RbuhTxqvsYw9hWGT?=
 =?us-ascii?Q?jbRN9Y/oNMwHQPzQg0Z4D4x9FoL+ECsMx7LbGgoeO0Rll0h+i7oI8G+kUm1B?=
 =?us-ascii?Q?nd5kNrnDrGk+kLC25yX2Rqi3yyshWekg0R/wtHorNkklbNe2fze7NqBCfUt0?=
 =?us-ascii?Q?ZJngt/8RJpeFmNRtnmB+jxGjVwmzZM132e3hjchGWmxbh+a6Sf9hTQ8R+WT+?=
 =?us-ascii?Q?7014ZdIt8Jsrv7KR1sKWnZxfcWLK0+nDsZM3RCad+epzV2LCgyeoRUwg6cQn?=
 =?us-ascii?Q?Rf2csFrNwVn2jIvvn/wFEp7DBowpO3+fFNBP7UIFQv0Zz3fEDEZdU1izkSUl?=
 =?us-ascii?Q?GnCesvoaBycpa34cy26wZU09JXRQ+PMlsvGNirOY5nvdfIJcqP1KupuyJPPw?=
 =?us-ascii?Q?K2Ths71N3WFI6piy4f3MakG/DPjQX9eKu1GBsSgi9VgsepVWC83AOtZNigT4?=
 =?us-ascii?Q?9cLVlPZNPHhGUO8uyIlGnkVt7wN2MkoM2IYXMkTlSI/gif/c9qppsk3owlGT?=
 =?us-ascii?Q?vioIP2j7+kw4YTbTd25AhrpAihBX/nqI7iueaZaK8X9YirjNQojI5Dl/WT/u?=
 =?us-ascii?Q?kmJaSy8HBCw2H/9tqhOUdsQaLGCKZn2UKZUqJt5f95lUUC+xYKi2xRddiXZ2?=
 =?us-ascii?Q?fKujrgFc07tH5CXtsXcQ0j+hpIc6QlkOjiZXQ9NDn4nPX5jAcjhTNnwJyjZ/?=
 =?us-ascii?Q?1yGh/7zNvzg5mjw4aWmKm1Mv4ONNo3KrIwFjxvq/lTO1dQk3kqp/ts4uOIbn?=
 =?us-ascii?Q?A7ldzMvMwY3LeTKTKfgKHxq+3lPST0l0iJrt5EfGQGMNWrArlRoySwnUzMRY?=
 =?us-ascii?Q?F2vEZucDQzdB0Et+fvatXC+yYDPECDutjr7dddEh3s8/nAZbhdINcCMheBin?=
 =?us-ascii?Q?L1Gh02EOwvpNtn6Ve3IkZQvT2OjDS342Eg8I6W/j8hjpFlnJWk/UC/ebgdN0?=
 =?us-ascii?Q?33k/W3i4TndOsoPFz8XULC1vfR8dxKjlbkTyXmE57OpUWP+o4SbCfKh67zty?=
 =?us-ascii?Q?e8KOSJMgorE8ulJGZ+G0AhmOFOc/fEO517byPqDwEHN0r3jBeLUt7Re6Kmy7?=
 =?us-ascii?Q?3Ox4dw7y99f73fuvvxawy8H5R2c2C41QbJzCPBA18neLwosuMeSOVGrP8m9C?=
 =?us-ascii?Q?y4aCA8enKc7jk4g5KO0Ng+JHY3EMHoooiiJXJRbzDLNSeXZNgGmLrmJZSjzp?=
 =?us-ascii?Q?pvZI9KphWOncSu2o4B1MUW8d2b5AHioIXCGlvps3/OLOdW2ZcsksG6Wyw10v?=
 =?us-ascii?Q?gL+S3qUzW2eCd323n+BZ0t1aThpn7FYTakBzB+a6wXnvpgfG3wikqYltEse8?=
 =?us-ascii?Q?2fuShTyEiTKZxa1B0jWvPEhVSTws1/AgK89f++tJjrO7MUX5pQ3tf9z4rTbb?=
 =?us-ascii?Q?NOh4BD0UakB7CFGRBOmo1pTv0PJMizMY8Q5wwfQ9OeVj/oFRvxe1CatqqGn3?=
 =?us-ascii?Q?89p+IomutUqCrA1ZgiscbkB9FKBpQa+vg0xW74Vb10/5pgVJLMxKA27pJeLm?=
 =?us-ascii?Q?zO7DQttha71uJ2j47m+WzRWlyywNTNdakbDU20ttg4At/ou46MTZihp8yIH2?=
 =?us-ascii?Q?dSInC0T9+8kCWYe/r0HP7Xx4zckREdb3mn17uZjGLIQvwJnW2R3jPRfVF6m1?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zfH9qME4/bGj2/J1KeyKm8wQpDks1vX9FhTSQ0NjhMrwhvxAJjYLqbOUmLw9hq4+J1WnyyFlGQFuduM/I9c5X8XEsZizfniGIJ4TYcV1WJ7j768ArK3JAW0IE+y/6S5Osz9vGFi4FJrzewUIA9WdFCx+BLlReHw8TkoxmQZJ7bOcQwB/98BWgV4NOVesMeXAw5BZlp3gsBCB7QMXD/ypEuhDzhS9dCyh/w7raWws7Df4dLpOWjraD1O+KWn0xdXWk/uATMYQovhpYXwlkGlaq2z6hGuQtjwhKMm28tssp+b7m8t4YPGNnyH5dKZ+dhSTYD8lfCFyWeKWTr9lY7LNiR2sBluUTBe6lBCyy4ywCHdAxO1zioWy4bvaXgRGsqtxOP9eXkWSApHFJbd8PdGe1rYilv8+3bhHut3Ha00IJ5wL31xCeYG1Tl4fewFAZQ+AFn1qgESSuyVa0+Lpv+LhkB+r5TKOFNDfPGjQIeak+cxYouWqnhbz2Kz/VylnKxEm2PI32PwiaK4/8KzWGHB1jvDvkTfARfuQ9XRf68STkcXMsJWPx/NnNjPUM+KueBwpC7GuAszo7ZOKrB+GgHN5KuPgz43UoBDtt3Ccq5WEgz4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfbe3729-7356-475a-e7f5-08dd00d7d43a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2024 16:01:53.8587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KKWU2PnCmr1CacBME1oHbD23F4NNjFhhzfC8pS/zTtH8wiAoosuvQCrIUJmu/5qVckmmvJAZ0aKf8vHT2VWpVinSNX4p5s5qtWWV6HweBF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7803
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-09_15,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411090137
X-Proofpoint-ORIG-GUID: KXIHlHLHPGNC1PpmRtYoDYb4i9tPHUei
X-Proofpoint-GUID: KXIHlHLHPGNC1PpmRtYoDYb4i9tPHUei

On Fri, Nov 08, 2024 at 01:57:06PM +0000, Lorenzo Stoakes wrote:
> Locking around VMAs is complicated and confusing. While we have a number of
> disparate comments scattered around the place, we seem to be reaching a
> level of complexity that justifies a serious effort at clearly documenting
> how locks are expected to be used when it comes to interacting with
> mm_struct and vm_area_struct objects.
>
> This is especially pertinent as regards the efforts to find sensible
> abstractions for these fundamental objects in kernel rust code whose
> compiler strictly requires some means of expressing these rules (and
> through this expression, self-document these requirements as well as
> enforce them).
>
> The document limits scope to mmap and VMA locks and those that are
> immediately adjacent and relevant to them - so additionally covers page
> table locking as this is so very closely tied to VMA operations (and relies
> upon us handling these correctly).
>
> The document tries to cover some of the nastier and more confusing edge
> cases and concerns especially around lock ordering and page table teardown.
>
> The document is split between generally useful information for users of mm
> interfaces, and separately a section intended for mm kernel developers
> providing a discussion around internal implementation details.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Hi Andrew,

As Murphy's law so often dictates, I noticed a few small mistakes moments
after sending the patch... :)

I enclose a fix-patch to correct these, basically a typo and some small
prose fixes.

I have also updated https://ljs.io/v2/mm/process_addrs to reflect this.

Thanks, Lorenzo

----8<----
From 11d47b63e5b3a631741c663257f0f9051585f3b3 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Sat, 9 Nov 2024 15:52:55 +0000
Subject: [PATCH] docs/mm: minor corrections

Rename a section to avoid confusion with the address_space type, fix a typo, and
reword a mangled sentence.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 Documentation/mm/process_addrs.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/mm/process_addrs.rst b/Documentation/mm/process_addrs.rst
index 5aef4fd0e0e9..ed74685ffbf2 100644
--- a/Documentation/mm/process_addrs.rst
+++ b/Documentation/mm/process_addrs.rst
@@ -68,8 +68,8 @@ described below).

 Stabilising a VMA also keeps the address space described by it around.

-Using address space locks
--------------------------
+Lock usage
+----------

 If you want to **read** VMA metadata fields or just keep the VMA stable, you
 must do one of the following:
@@ -291,7 +291,7 @@ typically refer to the leaf level as the PTE level regardless.
 	  compiler might, in practice, eliminate any code relating to missing
 	  ones.

-There are free key operations typically performed on page tables:
+There are four key operations typically performed on page tables:

 1. **Traversing** page tables - Simply reading page tables in order to traverse
    them. This only requires that the VMA is kept stable, so a lock which
@@ -513,11 +513,11 @@ When performing a page table traversal and keeping the VMA stable, whether a
 read must be performed once and only once or not depends on the architecture
 (for instance x86-64 does not require any special precautions).

-It is on the write side, or if a read informs whether a write takes place (on an
-installation of a page table entry say, for instance in
-:c:func:`!__pud_install`), where special care must always be taken. In these
-cases we can never assume that page table locks give us entirely exclusive
-access, and must retrieve page table entries once and only once.
+If a write is being performed, or if a read informs whether a write takes place
+(on an installation of a page table entry say, for instance in
+:c:func:`!__pud_install`), special care must always be taken. In these cases we
+can never assume that page table locks give us entirely exclusive access, and
+must retrieve page table entries once and only once.

 If we are reading page table entries, then we need only ensure that the compiler
 does not rearrange our loads. This is achieved via :c:func:`!pXXp_get`
--
2.47.0

