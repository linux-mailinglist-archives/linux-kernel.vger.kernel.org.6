Return-Path: <linux-kernel+bounces-349378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6618398F508
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 19:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE7C1C20DB9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA4D1A76C0;
	Thu,  3 Oct 2024 17:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UcdIIYe3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QYs1a3O7"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8041A7065
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 17:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727976278; cv=fail; b=cJ31sn9XBcHk09y3aBZ++qNUEVTjejY1AQ2ScKgvVroV5EUOkya+lDP45TOvrpwc89tTN+RV5vTw55G7UsPC9APsUSb1kmT32rdsf0IPJAwZo56O3kc0wdxCQvADbV00vFLLcSW5yBbkhcbRK0CRlLbnTR9/AZNiDrbBMPJpkCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727976278; c=relaxed/simple;
	bh=pRMbSk9jZ5RR+92LISdkfrAPv4jXHlu5AQAKIVISxFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oF58lAQxJz681TTRF/tYvIpahmTgGQrdczaX8KMhrqe3xPrTqLKEIfPkjAVtsFxhKy/O4J0EtaLsGFIeZkAgR22Uk2+Xn+tK839ZSI8ViVXMtrf+2/1HLSSceE0FGm2mARv62I8mFcCNWKWQKHmfZsBVHK6GZPNqChMxkpvIopU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UcdIIYe3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QYs1a3O7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 493FMbvQ009166;
	Thu, 3 Oct 2024 17:24:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=pRMbSk9jZ5RR+92
	LISdkfrAPv4jXHlu5AQAKIVISxFs=; b=UcdIIYe3YCK+LTd3DZ9ASwvSsNCZrlY
	NpXkAUV3BCMgL1ycuv8njoJbAlYpTBYq6mOqPx0Q4HigAZgo1/uVgM4esBYFtx5a
	iGZJQObWaQi8lTvJrECeejgMCjEcmgjbDpj3LHrMd6WMgXeZpK8sGhqARkN+MrnT
	FnlD0T/QUHE2/MOZE8a3afg+lrfQbodtfKBMbXlAlnDZPce62otrmJ2GtVjwKjMY
	luayMZLdWRaiwpEfTPZwUobXf+9wL5nf05+hoSVcxqODaJE/t2b8whIHCZCW83e6
	0z49Y37w0TTDVFOpDwE1EPZAOW50MiCz2tGIPCjrpVQEHbbMQMC4ZWg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9dt4stp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 17:24:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 493FpF7i026276;
	Thu, 3 Oct 2024 17:24:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x88ajwnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 17:24:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IjZpmeSHORdsXT0cznF8ojtqR68iOfg14lA0jOFVf69qfRHGDoDAPWQNrXW4qnbATV570xHLB+UfPq73zqpnz/do+NOBvR5LnMPmyedTaXbzhQ/RkE0CjUWJ5fU+JhZXRKc7SWwrffpMY+DLp0LYGrwA7/Je8VbXdHEC743LU5yB59cS+lypinv0gby5YozD70aaOcfAAtj0Y3o1GMrigsHvIwzdlCaz/jP/qfBuN8bGevkcdZLgqZS3shRAaX/tjjM0T7kmyH3c1h9EiBn0AkI2YqOqsjUVWOgP5+Hvl+rHHHTQi0iqekAywhDVlst3YnJ51vJNswUFXQKJNgCaUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRMbSk9jZ5RR+92LISdkfrAPv4jXHlu5AQAKIVISxFs=;
 b=lQxNoG/HugYxLUcAgllXxB4Kvb8djwi4MwnAzYh7+Wp+QHGtbWTuuZmVxAnyLbRa/WPgCAOyqYQyKe5le3HtvRGOClFYWrG6urP50/1i4nsgthz44BKA6N8dDdx0zR8tZlPZFvaq+Pt/EQweetoNsqFd3pYMcACWBf5BCXRXhiAHwVrE1pWLWwbw3CapOxneqy0XsepvMmo4NG3ZHZc0AivCvSSp96qa/gacJKKK77kvAuzW2VSmt5wHnlCFuPuhgi0L1w1sdCXhz4UQwuCB7mByNrqzRpl//cgO+vHI00PGGnT0TdsjJbCzyGYDzh+HtqUx9b6leH8VQFOl5gXQiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRMbSk9jZ5RR+92LISdkfrAPv4jXHlu5AQAKIVISxFs=;
 b=QYs1a3O7LTIWwBzPIhMPVQwctiRRU81gH5AwjrJzvvFvksmTJQf2sgQIRy4cvwxf7gN9HF7sP6qwuojDyb9c5WSk6XFva6qUOL9Ptjpv4IwxT6D+OJ62EDzf+17/YFUotRBKiY6FocZ3rqaz7+04mWGCHccvw98nDBF4E036C3k=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CY8PR10MB6873.namprd10.prod.outlook.com (2603:10b6:930:84::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 17:24:27 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.017; Thu, 3 Oct 2024
 17:24:27 +0000
Date: Thu, 3 Oct 2024 18:24:19 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <d2cb3a93-d5c6-4311-9a01-66fdc72608b7@lucifer.local>
References: <20241003170738.2870-1-spasswolf@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003170738.2870-1-spasswolf@web.de>
X-ClientProxiedBy: LO4P123CA0108.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::23) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CY8PR10MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a691c48-4ef9-4178-7c9b-08dce3d03b8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yC+YdhbYKCLa8ncMuTCA8Q+XyDgm3PnaHplu1/bCNVOO/0QGhzdQYi+qESHL?=
 =?us-ascii?Q?Za5mrYPYOTun+ngbNmc7QhGxW+ArDFrIcPDaFGoqsSn4YCu0QuWVysuV5fYm?=
 =?us-ascii?Q?BGrylQQZpYqOmoPy0D8RQmUN7kEEsIrt/ExpdOKhewL5nzupLG5cfNmXSmdC?=
 =?us-ascii?Q?mWCGhIxoCBbHsBWdDxehv8BGFZQr0OPbZRJ2oU2z7SFOL/KHm+jlqr2683Qy?=
 =?us-ascii?Q?jFgArCFMDi+sb8IhLTcwSwpRPdzOfHpryDen3TqVMbr8T0rPoybXvXw9SVtW?=
 =?us-ascii?Q?vBvptK9N1+MhZczF+LE0qyxZz5flkmYfpoL8mdwJtyoFG22pwugK41/NGTq6?=
 =?us-ascii?Q?GgjI4GCwVSun/u7J4It9d1bjWTJkc32eeklfzpqaj9dME1XyNOQoanx9t1oK?=
 =?us-ascii?Q?/ufoWelA5MaxvAswaCRSNjOCv5Ze7ND2EiNrWvLxkcC6hAhkY1645dRhckLd?=
 =?us-ascii?Q?P/XvR4lT6xEdk0lSuk6Ku1ZcsJYd/jivv7Sf9D3bAhfDkSBd2cIFpqfAZW+6?=
 =?us-ascii?Q?MYonhTpXeVY9Ao5yqSNegj5L0/pW39cWTyajtR8VM4T3cjQ8Q9vEJqMzh57j?=
 =?us-ascii?Q?zIsIJyKMIAkda/WzEsbI9BxEYkWRYoTdF4WOaKpxbEuPC8vSyKRgWbtonxvj?=
 =?us-ascii?Q?e1u9J3phJVYKNGWYzVDOUACJqkoU69XGIyTU3yk5YbENcyaPnJGCW38CKeBy?=
 =?us-ascii?Q?fQyZnWvatHrGV9pDL/rc674AELowzXXvOfYxM+XbnY3Z9cufXbR4oyy4TR9c?=
 =?us-ascii?Q?IRPBUhYtkqqnC6VUj0F4w1lV/AVh1Vv+ntAAwymEgyV4svULU3JRroVMK0KP?=
 =?us-ascii?Q?flDrRrUWP9djbnDQ/Ti6XAfgA1oxZQR0SCOP2M5ZSVhj4y9bwk6lvM5rsrM7?=
 =?us-ascii?Q?ukOZ6Xc9W+z5D3sWETyK1n/P7Kyzglb3BgpC+MEEarrLqdoAR2TqulCkiLlf?=
 =?us-ascii?Q?fG6hCpNoDSnq0YSsvCYr3Rn1fjmyyab8k4d0RysYJvirSvx/Hf+9znPToo6p?=
 =?us-ascii?Q?+dJOx/CdT+HN2X6PTP9HIIk//pUKHvA6Yi5l6T+ome7gWps1ZeRJR3YDCf/i?=
 =?us-ascii?Q?qt+9c+Z/YPpQyUziHtPgpGoR1r0ipGGPHirZON+Biss2exI0YOdBp4w7KDUX?=
 =?us-ascii?Q?WX3kIsmXr2lv1PZE7mMR70KX2GhLRYqLt9FuLO4dke5nT32HZcqN+rP6FarP?=
 =?us-ascii?Q?7oEIs60wVlwWMSvKgyNPRj89Ugk/YqmqVp2oXxvEjflEDITLK3/O0FfRyunU?=
 =?us-ascii?Q?Sgbe3EtBW0qKoBMwE9wHPNd/7IYMe/P+nCpRspAPpQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?seYANK9B7FtBF2RAs/xEqZl44NFy8J3o1re/wHPKEQgcr2IDxa+DAMaiNBu0?=
 =?us-ascii?Q?ypk/DgXkGYDZJMsHElQLOmnAjhOd5vXOtUSYfI1k02QONxxKmkOCkF3OTCXY?=
 =?us-ascii?Q?53zj1xf3G+eRZ+YQDGtVVf0ZotIEQ2C6zt+90IeiM8YmVDH7u98gPY8WUh+s?=
 =?us-ascii?Q?YwRVLBRFXltezq+O1gUD7bCHm72aEvq5ztelbOAiiJoklTaQGwtmnBD3KiXp?=
 =?us-ascii?Q?oTt+2Etok01IziX3pYzgNIngHeyA+Wb8er5ndxcJn34xyI/CU6FZ6iJ5/Sb/?=
 =?us-ascii?Q?FNX6s6MbofPkuZQq/m+bE/5pIfKL/lkR03fYZZvFktIIjqT1gHA2gdx+gLvL?=
 =?us-ascii?Q?8jWQnMux6t3kQgjRo8uxnrzrZyLrhPZpzehY6oqW0YiBjqAfcQavZH+Ro3aP?=
 =?us-ascii?Q?ZU/dqvZxzyhZljNYTnp7i9IANv2EoLl3as47f2x0Av6i7CF7AeSj/ixT9l3x?=
 =?us-ascii?Q?cj1HlJ6vv1pwPBmsdXx0GatOlW0lTY2GldMIG0A2Q7RmSluLmW12K4koOb91?=
 =?us-ascii?Q?lJA45MJ1fZkDRw9Z8VS3e4aQZFKVATehOXA3IQ/VSTPNLFzNAwPWOlrCje+n?=
 =?us-ascii?Q?Fs0FdX3V3ufJIwHdnBtkooTaeuPv13tZhG8O4hWZR+HxSrHAApTFsO6+HEvz?=
 =?us-ascii?Q?uqeQzUcQYALWZ/BC8TceBkAYG4b3yELZeBevqufgGf8ZxIuN2kz3MEC2RvzP?=
 =?us-ascii?Q?MFIYeRgeXhIGFTFnfVKhAQBe2jCrvLOU5zxP/z2ok1Q56lG22abeOx74SKTS?=
 =?us-ascii?Q?DpjEnC/q3unt70gsOLydI6DPgytZCQuGhQOyFP5DzB35aq12v9yjBexzaUQF?=
 =?us-ascii?Q?uZLAUvlZ4PrDbVo08p4P056p8i/SYmWmza599uGCEdzVZR9tyeKKlV6Q1orq?=
 =?us-ascii?Q?H/tFq/CFSAQN8YB6ZQG97BPUi/8ssK/KLNKh/j6WyBvUYRhd61KxOOh86WHf?=
 =?us-ascii?Q?q5ipfD5SmSDsGToilH1IjSQuGY47ml3dPIt/tdiQcMG/7w1I0xqwINMR+5zJ?=
 =?us-ascii?Q?+8VVs/JSJQzgCLJedM/c1SNV99zWUIi3ydTd/Myk5jyfn3a5xVb7TXrG43vM?=
 =?us-ascii?Q?3krUJG3luQYTl6cYkCOR1fwY6P3t1Y2YcFVLyE5aI9FckTOGTC7oLcG5bcYb?=
 =?us-ascii?Q?JtM5KNAKHu2AQaF76eBbyVnscdw/lY/wS3TCvv6BNx26H+wHmuociXu9uPBP?=
 =?us-ascii?Q?bDC77vdB5QRFnPgKvcJURRnYjDtfdTWU78WZ/KGYAz82OD8755Mr+Ms/Kjr/?=
 =?us-ascii?Q?tifSLnMpyWU/mnsuaGhKaIsLyGND3jGM3N8u4g6orHnFAPxyWmVpkwOZEdVJ?=
 =?us-ascii?Q?9efyddUeiP+132RrWLaiGhvKEX/CqoizMUWm0vQ8fyhi/EVAWWbpRa9Lxmy9?=
 =?us-ascii?Q?gKDQh2TlH713f32XqPQ0+Mw+qltcznvmzD5S84XuXMX/MWvTCALKCeI2pZqm?=
 =?us-ascii?Q?Nxm5NmOLoQyNQGN30fV9CyPAmg7laDdYDWldnNZMe67LfMZPUJo/OJcsJPCe?=
 =?us-ascii?Q?NHONzqpiUuGZmst/qYtkR2uF86mobAS+nw7KrNxKlR8SVbjgNJ11aueU4H5h?=
 =?us-ascii?Q?JqNTDnTHV4PniKcu38FCqlTDym8MsuXdZUalfuc6kZGFcWO6heN4zbT33iom?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2PJQz/sTQW6+QxEP+mHG2Hrb3q4MlvVq82JUd4cdcrXIJIuvWnyz4WMs2TUhvghPl8nbH0plcXWMfuE0GMDc7Wf/IRVcN+T1ar79oTvx1vllZd/1fWN12snxV440r31qxkthX3fF87ohmiOsEA0zQL59PR3cAhG014oE9Hm+IA8zXZYpG9ZlLD7WSPiypHgCXkCmroqneIZ6nVWR2z9QbbON3vXTvV8CeMb5ANqZig3md9AZYFWjxEOeiv7eYho6T54k0uMxau1a4eEde4vdz1UOBJKn6ume3BXfCD2dMgxkTnjl9R5fgAe/qk+e+nk0aCFpWqOL1QYwUpkj3UN2fLbDHwkRm+G9oMHwxNtNWPNwGumv3d8UkCGu3wJ0JfDiNwhTc/RTT38hnLPxxnH0oWuisW2DtOz0O3UL6dSKNIqdMbjVoYBbn1aZMt6/XLjxOgRF6DgqlklN+fN7/O2nGeeC+hf10Uil9KRqNR4jyqY0eUgIkW1KZcdEBfMTEPGvMuMuqniQkAEoAEKn2Y88mj1kckeOrGr28MjktdBNmU6tNb+xy7Yu44VCSNY9e/1FsmXcdQKRIhZKbacM80wUnzeqN7lhoJr7mnMbjToHTQ0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a691c48-4ef9-4178-7c9b-08dce3d03b8f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 17:24:27.2920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y6pbjmMeceKvakg9wTSLvDra7f/jtqs2JSPLllXYR4VD6r0D3weJcxF2JS8z3L0nj+JDDFKIeBDAokysmZCQE7At4iK73H1A/E+VXEZWuoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6873
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_15,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410030125
X-Proofpoint-GUID: fTlKZa8F--w0MNzRcKyrXEx44x3LDO_1
X-Proofpoint-ORIG-GUID: fTlKZa8F--w0MNzRcKyrXEx44x3LDO_1

On Thu, Oct 03, 2024 at 07:07:37PM +0200, Bert Karwatzki wrote:
> Here's the log procduced by this kernel:
> 102b001a01be (HEAD -> maple_tree_debug_3) hack: set of info stuff v4
> 7e3bb072761a mm: correct error handling in mmap_region()
> 77df9e4bb222 (tag: next-20241001, origin/master, origin/HEAD, master) Add linux-next specific files for 20241001
>
> This patch actually changes the reproducability of the bug, it took three attempts to
> trigger it this time, so is there some kind of race here?

My working theory right now is you're happening to get a problematic maple
tree layout due to your unique setup and sequence of events (nobody else
can repro this not even with amd hardware), so the 'racey' element is
probably this more than aything else.

Everything happening to modify the maple tree is under lock so it seems
unlikely to me there's a race. The fact you can repro so reliably also
speaks to this.

Perhaps pausing to output this amount to the dmesg from the tree can tip it
into not triggering quite the right configuration but hard to tell.

I _suspect_ the maple tree has had some very subtle bug in a very specific
circumstance (overwriting a large number of entries that span multiple
nodes) that simply would not happen as we would overwrite most likely at
most 2 entries prior to the recent series (in your situation it appears to
be overwriting 6!).

Of course this is all theory at the moment and I may be wrong, but after
working flat out on this for the past couple days and obviously with your
kind assistance trying multiple possible causes from VMA code, I am fairly
sure it's something internal to the maple tree.

We know for sure it's the vma_iter_store() from the merge of a specific
range, thankfully wine is doing us a favour and explicitly mapping the same
exact ranges each time.

>
> Bert Karwatzki

[snip of huge log]

Thanks so much for this! Hopefully we should be able to figure out if there
is a maple tree bug here and repro it by constructing it :)

Again your help is much appreciated.

I will go off and see what I can do with this data, and _hopefully_ the
next request from me will be for you to try a fix again :)

Cheers, Lorenzo

