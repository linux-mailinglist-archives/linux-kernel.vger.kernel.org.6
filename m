Return-Path: <linux-kernel+bounces-297913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F7C95BF0C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 811871C22EC6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EDF1D0498;
	Thu, 22 Aug 2024 19:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MMfOMmx+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="phYZMC9V"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AB928EA
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724355727; cv=fail; b=ta5jtsz289lvFwV76vdFZ1fX99i1S6FcuwQKNvjPDBgAukwumlfraFZeAgft66uVef0kWRspXxWhQ0B0nXKxNroNyiGwFw4LXVQetJMaekz2ls/rylSArJRKGDHJRR+vXoOHLLuULFLWtIj/JoiqIQ55+RT2yuvV6KSG+SpbUic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724355727; c=relaxed/simple;
	bh=Ja7Bz5c7QYIwgfejSMlXO3aKekG2TItgC4dTCREQJjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fl8Ply3Xh3Dqtdct2olQS/bwfcF6nxcc7288o/xYxpH2eaJRf6PELHP2E7Mhq0+uL9HSd17Lg4ibQaprRnnGobfa3wDS7PtsxWzm+S4W1ufsaypdDq5duNR+Bddibkwd3B3ZXoiUmMbI4ZYLZGiLJhrSPlThVhAMxsGVQ5aMtfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MMfOMmx+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=phYZMC9V; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MIMWMR021101;
	Thu, 22 Aug 2024 19:41:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=eT+79ztIa0jSTO9
	avpLP4HEd+EjhbHWIbA+yccckFjg=; b=MMfOMmx+OQ7gE/8Zz3RsuzqqF0v4Tf6
	p+EKD0pO9mjO+sE7FBhU0ugj9MVTKcNciwCcWRPnOYjAJQHBUeCOb4G4UcZSjmbm
	ol9fu5EXlQH0BdkRI6aidOVnCcVVxTcfvZ1C4AGN8pcPvVemr0CNbebP7n3fHa6a
	K/pVZ5tikyw94cmWFTJj+BInGoDoHmRSWFqUvBANuO99iPLIYskmwqCxKjcIpSAE
	k1oHJzgQElR0bA+6sbhN9t2tu2UyJeO5Z64o3BGGEeFySIynHVpW5uxE1PKaER39
	Yx2Ko8vY9FE0CyI0HN9NK9SUx9xFzM3iApWv1T9mCZpKS8Rgv1LADBA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412mdt2x2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:41:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47MJJFl0028248;
	Thu, 22 Aug 2024 19:41:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 416bct8qpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:41:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KczFJ+AhXzmOAZ7UO86lTNBwQXsyTRWoiFmW450EnznwDWIJ2wF+OIXaJFWCB8EbQ+ewUU4/YFagtlJjgunYcdOABdFrlCR+91iCN/BhKlv2QNA1qjzzH5Yb615sfg+wvZSfcLg5bvmIy+gdrephEkh25e0sWrXVSQLcWth6d4gRrnpqJn/Ga7gk7h9aTI2zsWtB42XUx4WCxFwsnASYjrFhYZ6empjqZawJItsSy6d5uLUJMAAzRiJ7rJz2btMkXvS22h8YsB5ZqxG1oZYURosbG1EWEoMm/tNGsP2GwhyzG1OcYBk+Stj5qFVijmyTKCeW+gkCmiAqSywaDpFLnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eT+79ztIa0jSTO9avpLP4HEd+EjhbHWIbA+yccckFjg=;
 b=Vx/+5+ZyGEHnIFxWp6iJAP8KB6X5fBaITR6oBySdny3PL1lohUkFF2hBq5CWWnMgY/7kT3/PcYZpjb/s7+dUI72gCFEhhbvk88RZA7aUAkfGacAlZfTgTFFSRzMH0RpHINepjXkjRiyiZl54Z9cDAVADH4oLD0rSDOW5oe75Ggknz3J0yJiHvWy3pmlMa4m3CcKo5vQ/F/7kXOnabC0k26K8RLElVl4o53JAeYMhCPtydXztpn0257J/1HtJ5pScLjFa49u8CnmzlsKJgBg/2D/rETbTPMulpbyddiZlo8upQeQwl5xy5OkNvo7G5dpWEdPGoV56TKp07qM6ewAMIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eT+79ztIa0jSTO9avpLP4HEd+EjhbHWIbA+yccckFjg=;
 b=phYZMC9VLLNa1j2UfdPA16kmFul2tXbdZTCNGlGGjCel1bpcHdkTUqm/TQ1+FyDyLHnTSTQjVaU0XcSBEMOek1pnWZs+jF17GAO1ImW+LKF1n8G8F/oLCAWV1LPZ4xSPylLEVbHruExK0hiEcFRpfzUMsNb/vAPbglq8z66G/4s=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH0PR10MB4857.namprd10.prod.outlook.com (2603:10b6:610:c2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 19:41:41 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 19:41:40 +0000
Date: Thu, 22 Aug 2024 20:41:36 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v7 21/21] mm/vma.h: Optimise vma_munmap_struct
Message-ID: <1ef65eb7-dfc4-45c4-99db-b29609287b56@lucifer.local>
References: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
 <20240822192543.3359552-22-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822192543.3359552-22-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO6P265CA0018.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::6) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH0PR10MB4857:EE_
X-MS-Office365-Filtering-Correlation-Id: 11947cad-4cef-40e2-4fc8-08dcc2e271b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iGlLegYgTCF0l6ih9QugJtaiR10zQJYMbMrFZ6znxgkbmQ3v11b1KaSdmid1?=
 =?us-ascii?Q?6nUiMeVu5TcBTl4m4NrxRqgEtUBtubUklYxOdV6TRDQJ14yPyr4eFizNt1Zk?=
 =?us-ascii?Q?3Z924cbclg5xVksjZnVf/uO/SnDeQz2+b6Tz8I2SgVcM1NKcRAT06xJGv+Az?=
 =?us-ascii?Q?uvomGo5zeWp9uOBgC8mzGpP0s3VfiSB2+BolsCL8bA9f9WyGpS/aq7fo2yxV?=
 =?us-ascii?Q?WYi+NRg/dBZ4JwhWx5Z7HNOmY+Rn28izp5uaywiScfvF/ewVfJ+8MBfMMBz4?=
 =?us-ascii?Q?UcB2cMqXqQvnXVtkua9orVMKbO+8FmNBFuLLLZOnHALnV/enVC6zHNzRhbzD?=
 =?us-ascii?Q?R0tnWXcMZC/O9baUu9KDN4cFCfn8q3isgnd3oOTQl52h3AQF4OS+jkMgTevC?=
 =?us-ascii?Q?1mwWh118Yv5C0ZHTFFvOurcjrfylux3SwV41yIX0TZ1hZGck/IVgZD57DpjM?=
 =?us-ascii?Q?Zbe5O30iaMzlfknLJzyOZ/Jbz7un0NOAjKPp7GqUjvLiiMbFrngeNNoGyH66?=
 =?us-ascii?Q?Y9DrRukimryqqIGu2oM4QrEwzylX0+btx4d36MNZnPLGVTnvxByI+Wg0NMWD?=
 =?us-ascii?Q?YAztqftxVlENpaFoy9fZ1THoCbPGk2wOAlGEIc/19tGGk8ZUq6csKFto8vrx?=
 =?us-ascii?Q?aqHiyBtOjOQGOkwHn6vZDQvQjXoUVF9LXa/05ndNX3D2k4evMpYPrg+ggJOp?=
 =?us-ascii?Q?v+bkfklT7kheq7MGgmEHd89XKR8FCXkh19MqhwZKy2S6iDB8zeSjfbFkWB5Y?=
 =?us-ascii?Q?DWR9il6HH4eyVTeVkXtmRpuwV1qoSQvmpZKXvLB36GIiOUHSXd9/P3GITlV4?=
 =?us-ascii?Q?Ft1asMAqPSqSBWSBn6++IbZbByCYiGIvR8foKOTxOU5VPDVkYTolfVCv84Pw?=
 =?us-ascii?Q?4/6ONVYF8d2Wugbz+teBDmDO46yEqgrPzd8rH1CZB6+lZURpu2HAREJdasJ6?=
 =?us-ascii?Q?+8O0BRtPhcYD4DVucGrLYTZLw5op4qQ3/71TWFJg/VdjaLx5TN3Fniuz2bQp?=
 =?us-ascii?Q?iPq7jGBJ55p2APzbtVSuU2Bje7Xg6vyKEQtB6LFNuxdIbIqYkY1lu1ToZLod?=
 =?us-ascii?Q?Cd8NsReL6ck5yiRc9NmFcmyimyCRkB4a7pzWqmgpZITxnABI4IDPDSr5XkAn?=
 =?us-ascii?Q?FEyWV4sj0LyccdB7ppGDvQnEYrualc7O9w8KREtvPOGo52PrQ+Hs1qjD5jDP?=
 =?us-ascii?Q?ORGlEUpW3EDVYAQ+tQJ3AdNGY1hI9EC2TtDDfmaPmliK24V7MIMThHFLKEjd?=
 =?us-ascii?Q?lDXYkQNALKHcUbsgIFnLVsSe/9Zb2A7KmIydQYNWJ8+ctLXV9bSThRdSPtd6?=
 =?us-ascii?Q?KDsVYmm+8Eb8KuANTmz+aKHieVp0giceT+MGflY1pkyWDQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oACE7PoEbHd21CwFcrAGKB1yyfxg6ph5PlyTOIcWFE8ORuguq7oI3olT0Au6?=
 =?us-ascii?Q?ZS3rrXkrXf+yH5Q2/KfQuYMvNN4Mh2pxFSQAfkCjpRjEXdZFaGg/4xgMoASF?=
 =?us-ascii?Q?ay1/V8AdpINc076tgDei5u1q289TlnlO30thBNBGhVNOOgMVt/ojuPU3bpDL?=
 =?us-ascii?Q?D/xsW7ELxzGncfX6PHrBf26SRqqyeg2xGzES8hC7/wSulkRBvkpL4fundMxX?=
 =?us-ascii?Q?GHDju93jOHxhrcIbsW4dCgooTG5S03osd47PkHM9v4SFRIG8wFG6pkM+4QsZ?=
 =?us-ascii?Q?ucM1zr1HZFApaDHu2TwAPtms+VTg2kicNzAqHn7bYIn1BxckpNkyoqSt2Xrk?=
 =?us-ascii?Q?ajB6DqSFjeLaHi4s4UCns1/AlW1T5WLOAHhLpFpWtd5/H2m0D9tij1oq8csu?=
 =?us-ascii?Q?1vTAwyN3ncSVog6InQlKeuc8+J+BwOQAxDTOEd6bAag/mzzuICM1KUvh98MD?=
 =?us-ascii?Q?KbU4Zyp8r6YdH5N/zh8M/RKeLQDOf1r9ZBhfFOeKSrDoEoxIL+QThkuFCAaI?=
 =?us-ascii?Q?5FBgff1wfufCWZY1n0WxTHl+ZuqvW/004kjYPCubUcCtskot7Xgn4p8StpJc?=
 =?us-ascii?Q?xmHOCzSeNaIphGGRGA6LsXosT87K51QmJo6wCwnLQYyWxAMm6TTqspy/YmtN?=
 =?us-ascii?Q?nzpnOR9QNhyTXqiZ0IMPd4e9FEQ89KrqFO0Y8ZwensxIJp5CMoKMvHR2i6jU?=
 =?us-ascii?Q?o8i8lMI6u6iJtgtMxN8/vxUaYGciLikNN/dpkJIr5+PlA828tQEmqFwWhA8V?=
 =?us-ascii?Q?amXCDWN4sayizo1ZZgN59JgCuSFPtD6UZdsyfP+2Y5FhJbl7fvAJpAQkmtp9?=
 =?us-ascii?Q?gy/oB0g1DG/s/RRc59oXrdpzE0KOnKVNhLJ1ERPSYBMYC9GYvyw2GEHZVVz2?=
 =?us-ascii?Q?GUrCIxXfRZTg/t+DCwLzcTk6wXc46EdWqkXmq7CUaUkML3TCDxPJuPdi9l0t?=
 =?us-ascii?Q?tQE0G/cQybOj2tH/7c0eQ1yxZGyoPCPYfHKJg+GN6+X7LooQuWPFrYlRDpfW?=
 =?us-ascii?Q?mIpzKYwgC+EVikUWBwQutQKICC74DfbVAMf3MkXS0emTSOiJINnKOixJDjeT?=
 =?us-ascii?Q?hfSuqLIwrSTBo8apHTNYhMho6n/hP4+IUh+aSN09VMuCbmsGKxrmefAm773n?=
 =?us-ascii?Q?ZsOHu3H+DYpaegBUWAtGLguks9fEe+CwpTdmEVJLJ77JYNQLnGT/+zpGnFso?=
 =?us-ascii?Q?VLb4VjDmB4KVlerhIxeMNckZcf9NCGInKWhWAkhnEAi0qGUM7aBUeBrGfbut?=
 =?us-ascii?Q?z2GBsiI91gvmuyCMG+i8Jzw0BK/Nto/2yQpH+nbJIN/xTXKDb7AAjnYRfvHy?=
 =?us-ascii?Q?iNpjM5T4Y4OGpyhC9abj1oABi7LNJN7SRNK2zR92N2DPjoQX2wPyBsDrzzbk?=
 =?us-ascii?Q?XFsVau9+7P/WyeLQ6NBXsBSnbhXi4xpjqNCHWNnVbiVb8fgIz0UxTNw2rxtT?=
 =?us-ascii?Q?50zu449qbUG+AKDXyrNUsoZWPzy1nnRv+UrJDIqPhzVOz+5j+aO2jQwJGjKd?=
 =?us-ascii?Q?PU21q7Us2FR1QgJq+3Gajn3ey2BmNrxR54BNr2JNznzG7qRNw9RkBJe0ZCPg?=
 =?us-ascii?Q?HKnKnWJd5suGGJxjVOMl08FGO3ww6P99bWkARHBEDwAwDuNAxtWY5fOfqVW5?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Cncg4F/D3nOJSaaQe4jqghYQYspZO71s3Khf+2TickL+K+OKB4+7UFrvlnJKs6vvDV5w0F/yJP/vc9xRRoAeF+ZYUPNqVQxtAHeMjX0dFP7O68jtXo4ok+i164ZgJiGupODmtvMsNvOCoKPN7yyWRFxib20+Hi4qZ+/0jRdn3bD4is/6zFlFPcMgUzcgwtQ604vU/RNji/o9F/udM6f/DgQKV0Kr9RWLtLwcaY5xEivJjHAGfTiuujf3YsWfO9L31/Unoh0ZDpOLHGLzarb5yu0AKEuGqkqeCVX/gWp73KZ8fuolygaKOMfoBJX67I5WiaTawAEZ5C48gNAq+8TLvWmw+pydzzuNqBHp1AZq+mq/mxZPtrixnWZUINxcJlyL/8PnMXhKTQKeNXuKUpVTFr9mO/m6hPtLR08axXNBPlTu6c83PtxXy7hGnxBxLN8LUbKskDMUhGUpXxPBSEKRnL6W2TL4PJgWuIJ4PQDp6KGvGNFnx/ofq3CzOWejvJWf/8T4Y+DPNjYDHfJOaFRSle/8aV915jTBssnDnfERV1CowJWIRXKETLeu+jgBLrIULunD4ZOw2eGjr+0Uuk2sq+vhU+gRC3lNbatX6byX56U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11947cad-4cef-40e2-4fc8-08dcc2e271b5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 19:41:40.8342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lfcft3hU42C0263/mY49evzXfRpHvg1hnrWK8P9wQE37OOCAGg8JLXZwOMzFvm8GV8VFwVBW05vt6qqPYCEVe/s/QmhQU7xwZPrNTMqtUC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4857
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_13,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408220147
X-Proofpoint-ORIG-GUID: kQeW35-8Pkh-AkL0druxBNhptx0CVn1d
X-Proofpoint-GUID: kQeW35-8Pkh-AkL0druxBNhptx0CVn1d

On Thu, Aug 22, 2024 at 03:25:43PM GMT, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> The vma_munmap_struct has a hole of 4 bytes and pushes the struct to
> three cachelines.  Relocating the three booleans upwards allows for the
> struct to only use two cachelines (as reported by pahole on amd64).
>
> Before:
> struct vma_munmap_struct {
>         struct vma_iterator *      vmi;                  /*     0     8 */
>         struct vm_area_struct *    vma;                  /*     8     8 */
>         struct vm_area_struct *    prev;                 /*    16     8 */
>         struct vm_area_struct *    next;                 /*    24     8 */
>         struct list_head *         uf;                   /*    32     8 */
>         long unsigned int          start;                /*    40     8 */
>         long unsigned int          end;                  /*    48     8 */
>         long unsigned int          unmap_start;          /*    56     8 */
>         /* --- cacheline 1 boundary (64 bytes) --- */
>         long unsigned int          unmap_end;            /*    64     8 */
>         int                        vma_count;            /*    72     4 */
>
>         /* XXX 4 bytes hole, try to pack */
>
>         long unsigned int          nr_pages;             /*    80     8 */
>         long unsigned int          locked_vm;            /*    88     8 */
>         long unsigned int          nr_accounted;         /*    96     8 */
>         long unsigned int          exec_vm;              /*   104     8 */
>         long unsigned int          stack_vm;             /*   112     8 */
>         long unsigned int          data_vm;              /*   120     8 */
>         /* --- cacheline 2 boundary (128 bytes) --- */
>         bool                       unlock;               /*   128     1 */
>         bool                       clear_ptes;           /*   129     1 */
>         bool                       closed_vm_ops;        /*   130     1 */
>
>         /* size: 136, cachelines: 3, members: 19 */
>         /* sum members: 127, holes: 1, sum holes: 4 */
>         /* padding: 5 */
>         /* last cacheline: 8 bytes */
> };
>
> After:
> struct vma_munmap_struct {
>         struct vma_iterator *      vmi;                  /*     0     8 */
>         struct vm_area_struct *    vma;                  /*     8     8 */
>         struct vm_area_struct *    prev;                 /*    16     8 */
>         struct vm_area_struct *    next;                 /*    24     8 */
>         struct list_head *         uf;                   /*    32     8 */
>         long unsigned int          start;                /*    40     8 */
>         long unsigned int          end;                  /*    48     8 */
>         long unsigned int          unmap_start;          /*    56     8 */
>         /* --- cacheline 1 boundary (64 bytes) --- */
>         long unsigned int          unmap_end;            /*    64     8 */
>         int                        vma_count;            /*    72     4 */
>         bool                       unlock;               /*    76     1 */
>         bool                       clear_ptes;           /*    77     1 */
>         bool                       closed_vm_ops;        /*    78     1 */
>
>         /* XXX 1 byte hole, try to pack */
>
>         long unsigned int          nr_pages;             /*    80     8 */
>         long unsigned int          locked_vm;            /*    88     8 */
>         long unsigned int          nr_accounted;         /*    96     8 */
>         long unsigned int          exec_vm;              /*   104     8 */
>         long unsigned int          stack_vm;             /*   112     8 */
>         long unsigned int          data_vm;              /*   120     8 */
>
>         /* size: 128, cachelines: 2, members: 19 */
>         /* sum members: 127, holes: 1, sum holes: 1 */
> };
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/vma.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/mm/vma.h b/mm/vma.h
> index 7047fedce459..c774642697a0 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -40,15 +40,16 @@ struct vma_munmap_struct {
>  	unsigned long unmap_start;      /* Unmap PTE start */
>  	unsigned long unmap_end;        /* Unmap PTE end */
>  	int vma_count;                  /* Number of vmas that will be removed */
> +	bool unlock;                    /* Unlock after the munmap */
> +	bool clear_ptes;                /* If there are outstanding PTE to be cleared */
> +	bool closed_vm_ops;		/* call_mmap() was encountered, so vmas may be closed */
> +	/* 1 byte hole */
>  	unsigned long nr_pages;         /* Number of pages being removed */
>  	unsigned long locked_vm;        /* Number of locked pages */
>  	unsigned long nr_accounted;     /* Number of VM_ACCOUNT pages */
>  	unsigned long exec_vm;
>  	unsigned long stack_vm;
>  	unsigned long data_vm;
> -	bool unlock;                    /* Unlock after the munmap */
> -	bool clear_ptes;                /* If there are outstanding PTE to be cleared */
> -	bool closed_vm_ops;		/* call_mmap() was encountered, so vmas may be closed */
>  };
>
>  #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
> --
> 2.43.0
>

