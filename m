Return-Path: <linux-kernel+bounces-374058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F9A9A6145
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8CED1C249BB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2A71E47D3;
	Mon, 21 Oct 2024 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tz+yAyY6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TqR8pbg5"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445B61E47A1
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729505050; cv=fail; b=Zs60a4b+twvcY2DTymT0NocX7susG9LpOEoc/g6aW/AS38VgYW8QzIpxDOP6REb3zBlHGryRToxYPR+zdlLjvc4goRtJ7sNGBS1fFAJQqejcZMoybcTrDN9klLS0yL1ZNnRbBIkmtbxZVhhtUQTnG2V5h6+7uKIqb8hPU8/5nhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729505050; c=relaxed/simple;
	bh=dhPb+tlKpoeB2LIszLxjRf+eYF8vPgtUUz9tHEPntTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=chrvggtJV8MyKNZ4VLkIf8H/9+fpURzw///XOONizslxcXro85PzuN3pWKmWjJ57fuOsPclskdcbzQbn9ivAB8cVeBUwWQS1n+y0rqDFV1KXqq9W+G/sh1ucZ64DrnHaOM7sL28OjbRa0UiJoEUQxLIHB0qaA/w6iy+78bVXVVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Tz+yAyY6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TqR8pbg5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L96v0t003037;
	Mon, 21 Oct 2024 10:03:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=LlSdzOb/sPE5hK7pLR
	swK6fR2TvsUtYePq5fldG3REM=; b=Tz+yAyY6//YdCbvtCuonCkbXLXyqPCphJY
	nRILuSn9KzufYCbjGjpSGdmF2Y1ej28COnbrUuP01cBy/8mtOHw0oUJ5mn2SIEZJ
	W6ZohB9gfIHVostpNruQOQazhM/7okAQOZsFxdOQ/BsLd1nLmiR//3YbGlkvJECj
	GmbWEp0JfWom6s5xdPohPOa7pj2zks6jUss3Zzp8bEyaA8qRsgP2HcKrmN1N409j
	Jj6s7Gkw/DJV0J81/YxZ8O0GUGYm9SKn5JtHq0GqDXDfQBSSoQo2I3OgRf5WdUTz
	avothzn8nwpeD2ugnG+UnzDxfDHSl4pA2zYMQCiLeo9flElNXOMQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5452qr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 10:03:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49L94bC0011942;
	Mon, 21 Oct 2024 10:03:38 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c375vhm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 10:03:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGC5ItzuEwAINOeZrEHKO/O1mec0yhLz7JJZyWvfhsIXt5Gk88a1tMklGntu2PZQjDSo1zMbQ7nXxH0mwDWmHIgKjPs/JGM2zfC1huL4D4oZTYHAr2cRc3nYRNfyryGB03MS++q0RVo7ZhEq5sNqWjiOLpDpQA/WVwKKd2k+TCwyIqfdfdA7ZIVI8wHjNZiV6eC0kzRvEJ5vPGSRF49VhPjY+DrwZN2PXmBDwNZDoWlnmh8CGixS5ib/RpHCK3b7db+I2U8ROQIv/lva5WB5R+vw24II7aI5y9DOdTuYcbhbp1Tr7E7KWqmaa9OKk6VtrLcmOmiGRicE4dG0bX1kPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LlSdzOb/sPE5hK7pLRswK6fR2TvsUtYePq5fldG3REM=;
 b=UruM/BUdEUfIIxfTsL7TPKwNNfqAay7U4p39HphJeEvLZQrA+bAmPWzHIbCOfOfXSurgsx7vDkxvBjDxrg297LjnFo2+8vMsxZ417fYe7RhUtCV/ZgXZhiIGN+XFV61S1vS+8fpDNldJoLaFze0aXHsM9g+fpKgHxnJB+xBKgeDD+t44oxmGFL3WvQ/F95jSx3l//wE8v0riWeG3BZEIsWBBw1SoaFO2CEOYSEj4ZyLRFVwpFk/KSrs9wQsmavVQrVSSZKndL6MyNpxnotwZ2aklpHV1RrphqOQIkoZPOVwIbfs6lfzsORGPRtzw7ncx2RDnrlORo2Pc6tOTV0S5aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlSdzOb/sPE5hK7pLRswK6fR2TvsUtYePq5fldG3REM=;
 b=TqR8pbg5t6noGlov3r8WTMW5hLA/GeFXpghuKE7+4smc674GiPnsxlyd++X0at9ZJdnGHLNullfBUv//aeeV+mjqIj1AtxWTEmqRlv9AaxfGXYx1COjZB1H0yinasfOS7ZbgZqOItCBKV3V5gGGq12RH01JbMrz5ZpAYyJq1QzU=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH0PR10MB5625.namprd10.prod.outlook.com (2603:10b6:510:f8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Mon, 21 Oct
 2024 10:03:35 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 10:03:34 +0000
Date: Mon, 21 Oct 2024 11:03:30 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jeff Xu <jeffxu@chromium.org>, Pedro Falcato <pedro.falcato@gmail.com>
Subject: Re: [PATCH v2 1/2] mm/mremap: Clean up vma_to_resize()
Message-ID: <8ea11588-02ac-419f-b531-90e8cc3b330f@lucifer.local>
References: <20241018174114.2871880-1-Liam.Howlett@oracle.com>
 <20241018174114.2871880-2-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018174114.2871880-2-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO4P265CA0179.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::7) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH0PR10MB5625:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f9ad55-f816-43a8-5647-08dcf1b79fb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HVpVfpcrTkWpHrJU1cl7gQuKZ1cLUobur+qXS6jmLzLh05cei32eHkf2l1MY?=
 =?us-ascii?Q?RuXNY9k+h/9cGA/V01StzBd6cmxaLSX0lZVPZVUVGhsCM/rbcfFzvb0G82mA?=
 =?us-ascii?Q?IDBGiJj7NJTdvolq1o+12BaedshPrnnw2W++E4GnuKke+4NJ65+C+mwdLEld?=
 =?us-ascii?Q?y86JqcUX+8H3ACs2hn5hephETisYdW7qH3es4SwC7qPPpvOrdqjzMSaWxYvm?=
 =?us-ascii?Q?YoFWC1xwycVAQtZoufzRy9lm7DWqwtLeuM0r9IeCEgengWkFArGYhjicum9B?=
 =?us-ascii?Q?nQm2W3mv96zsJp3D5KcI0yktzNmN1EGqDCub0CTq8iYdD1gHpI9TLHoGg2Wg?=
 =?us-ascii?Q?pOpycFyGxRnfXbaGIxsIZjY+9gZ02g1tnyCqLgp5usJVReQd85rLSeHzPCg+?=
 =?us-ascii?Q?HpAMLW/XxJTn+XvKs6Bk5+niATWVrFlUzphTuynKmJs2QpsMuBeDvZdkRVoQ?=
 =?us-ascii?Q?cacFM3dOXQpsHQczEXJDRsyeR19Uy+g6h6B8OFpaO8864Ouv3TlpMuyjZIDN?=
 =?us-ascii?Q?GcKUBXwcO6NwoZVyYTWuKVCo/y/aLEfQZgh4VHZ3+4hAWwSZEzDZYYDDPeJS?=
 =?us-ascii?Q?tJznFm9oQhblz7mYuWw99d4sggOt4p/ohO9ZtH0taR4w/tZlkaVXte6l36s3?=
 =?us-ascii?Q?Ffo0oN/cTMWrPS6u9ln0lTbLmOgTSV/t7JvSGmn25s/Dt9nkTMhZfHJ4UPHE?=
 =?us-ascii?Q?UJD26KPY1gxt2l4BibCXoE3bVpnc2pnkfeuDs4/WTLAdpVcSLppc92n++x55?=
 =?us-ascii?Q?Gkienyv5k2nXku0jsqoua3i3Wv4kwiP9614s+JEY5XF63ZESrrFKXglu547I?=
 =?us-ascii?Q?imhE8vjcs1AwAu4FzptBdFvwO3WrYB/lKkldgJlToCPOMo0ydutbzcPGCkYF?=
 =?us-ascii?Q?JPntGxHLy7/qKEe8Cc/AJy3msgnwi9dY3F36O0d4RNk1pOETZRBQ6jsZdK9y?=
 =?us-ascii?Q?LFurAfLcdKCvjfESqNd6JETbSCRLJKiD6j58BKYa2jrSE5nIcFMpfS51YY2f?=
 =?us-ascii?Q?Bl6q7vT3fnvoDBS2N25Fu2Brx5Xzd7ukqMNm0W4xGaYWfClJ5v8/biP6WUjW?=
 =?us-ascii?Q?QV1nuj+jTXSeww9cHvl3dalZMCodr7seWzDGtofO4ifal2d3FB8zHclbCHaU?=
 =?us-ascii?Q?gxNLowBe3dC/qfNmTpPvFONOOVRC0fpYq4vobiaTSD2zNvIlGlEUmM3CmaOL?=
 =?us-ascii?Q?iEnNlEYusG4iKLghkVvJTomUnClVakuOpNi3rCUVYO78u916uVVjzN1a90Yn?=
 =?us-ascii?Q?5bN1C/TaNWKooW0BdMxOzlzguKBIzdzf8sFwbfwmwC+aOtc8h0hiwQJPGS28?=
 =?us-ascii?Q?uvxklZrJ8wiVUpFfxNTYOUur?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dQV9EfQvN6kX2TGmVgIp9b1xUVp+MoVEuV74Bj0siMEYv1HaRZ+sOUC7CLJi?=
 =?us-ascii?Q?GQrGzNZOlcGZoPHjz+daaDw+3esvIqR0CIznRUv5MDu7xvtFKPIjRIQmePVl?=
 =?us-ascii?Q?ZxjuV/uofWz5L5OAZHb2HKesODnPHoKASjc5I+tu9+J8DcwR5Q1i1Cw2afda?=
 =?us-ascii?Q?r9WD3Ktt2JrnP6VYJpDnV9Zt1U/c9gBmxSlMGiNAWzP4WoLOmh1U9BJosteJ?=
 =?us-ascii?Q?6EnrCXzt4GtVeACqIfuTScASoFK/Rsw+/bw/BO/Tj/7qKJ3xtzs1qYLENKJd?=
 =?us-ascii?Q?iRgJL44xGKzmIPJGog08BGRcV2nIFyDdSBeJErdM3IrRP74tI3EgzRBYkuQ8?=
 =?us-ascii?Q?xVXi7pPAAJot5/pL172NAKTh/mLh3lbCPwhvvN6EbaebHKfFRIq0BEXtITN0?=
 =?us-ascii?Q?AGhkIPfdksDEJWMZrtHG2dvlfJ/C1J7kpJi7jDH4seA5AJEaryDnHmEHt9sB?=
 =?us-ascii?Q?0bHHMtElsIkAZEP0YAVyYR6yTZq0XlEihpQYNVgWepaOzjlu+QgJAJope0IB?=
 =?us-ascii?Q?yp052cqfOdQ7wwqjtdm/SNXWaJW5T/fFzdCt4vW7tPw5xlTRj5iDkdFkSlxU?=
 =?us-ascii?Q?dSHvUUK+51NDaFDAeKJhvtOm518BTFUEGKbPOjq33fcIQ75buMwXqYmsL8ou?=
 =?us-ascii?Q?PTtGu2RUAhlSaq6/FJSEAf1RJpj/YHpmx3Nbi/dn1v5PuHjCXmclmETRluNr?=
 =?us-ascii?Q?nH3xECpEYImYgVV/A6GcgDcVe4DIuETfwCDjVFXdv2zArN/ZMTcTOsIWhpdm?=
 =?us-ascii?Q?RUGZ6lApMLtn5MJ7PWp9GNMSYQ86cL75cUa7uhAd77UmR9UlZuX8tAUdATsc?=
 =?us-ascii?Q?WlvTahU4NajYO674s6J3PKrk7VXsER9xelo+VXWJxGwGCdnVA/tZpGKICv4Q?=
 =?us-ascii?Q?FVqj5gUXG0co+ZguwVJPzSa0gSuisN/tdfbWUdaXpE9SIIlhahJz8z8ueJIX?=
 =?us-ascii?Q?zv8GLxF+a95wkRF/1+f7uQTZqUkqCMt694I2fZoV8XPrty21AA4LIXopRAA6?=
 =?us-ascii?Q?uL8z80eVhAMKh3+gYE21eWqk7rVFdm61vgW2IkbWLb3Qq00QSAiTFCjmT/ks?=
 =?us-ascii?Q?/Ynp4F4uUkKKm9PpMY6X1u82KqMp8USgffn++WB1wK6MDBZn1CT7i2jbeAbf?=
 =?us-ascii?Q?jY9ddRlpBdJGD3vpKRS3UtiL/IDRMVP/lTCQCippTSoYM7hap7Qdm4qQERgN?=
 =?us-ascii?Q?iGb+8mtIRk5Bcq8ouufzCFQHrS3tvP9VVldor05/YJ7VC9647Gd6ER47DiCj?=
 =?us-ascii?Q?xr45I8+e+XmYW/FzyzIY/XhwidZ5EITHgzsg1uZf/xeE3dLuqg9T6lcih+PE?=
 =?us-ascii?Q?DhlF9pWNxcRXE3Pa/Cqt4VrHdWNScmHjmYg3bvtVufPIQpWByr9OLKdqoEfH?=
 =?us-ascii?Q?7RorTRmsAd8B6DGZ7e36Ux9oHHZ+bvqi+6t5AraeoNz6jrtNUMI7348uq8De?=
 =?us-ascii?Q?+oI6bLPJVj5spuvoBxKvdSmhylvZvriWHcM9osGU5l6OawKdFdBcs4lQPhnM?=
 =?us-ascii?Q?zPq+0f7oa3zgIcakoc42+X7RrKqqKkkNsLMzmsuWvgF1o+htVy8Hd3j7vDwK?=
 =?us-ascii?Q?/sUXKBjIkH45prJBQTpuhIuTfivkR5bMdYdwAgnQnF97TR+Lr3xT7ZBBQZUp?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZmrugFom38g/XjY52An9y/038hXKEYHk60teLAjju6nPZUmQWGNcvNUdU31w1zslYVm4CHVv/5kSKMZeQ5hp/UaGw/0bffeCmyPWxNN84FOFH0DBWYsOYjqS5bNbLccIq9IE7rmmfcP7LYS9ubhoGkblZ+k0Uef31z1OQMlijPdHE7YmFjIgPha9qy32Rx3bsOiHqVUzWap7INZZwMeCBuhTtA6/UO32AhvK8FULW4BQ7gLFMJ9zynTp6DaBlhg776vHyRWhOvl9AUQixCf04/nybnxGRsOxYGNBofvJ++Aijw5yI84KB0Y3u4bXK/1OkQmfY/W3xMVBxcbjX8JD0/h6QpDEPQvCQeh1dXzKO5J/q1r1g4pWW9M3UkFQB6XtjrCcPLU2rTjf5ZURhQaCJ7Rf3qC4/AD/VnXIOXMUMMJZHDCxE+5ptd16PqP3CJLc5VCeBQA10FEfNpv+7JUufwwcMQtW/vtxwL9vNcRdHop8kHtfoXMZQjbtfKaIfd+pdarJYIHQ57+nSIPqnqMURmsnxK7olur3aIWLH5qTD8q3YgaFsoQoqksYdROyyMVDk0LPg/EVa3jlw4EC/BQIJZHUgiGNBTe+AC/D2bng6xk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f9ad55-f816-43a8-5647-08dcf1b79fb1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 10:03:34.2781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yX2SXXUBSZ1MDhFvCSZnbEnZrYOT3oACc/8m43y+RY83GgB4DDiEOfX0HyTFpuAFJNPmzYiqrOEkAtIxUw+M5b2QB9GWTXhFh3Y8H/M8Fcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5625
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_06,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410210072
X-Proofpoint-ORIG-GUID: ufsPusfjaRhGdjJccvtq1TGFWvP6VVcT
X-Proofpoint-GUID: ufsPusfjaRhGdjJccvtq1TGFWvP6VVcT

On Fri, Oct 18, 2024 at 01:41:13PM -0400, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> vma_to_resize() is used in two locations to find and validate the vma
> for the mremap location.  One of the two locations already has the vma,
> which is then re-found to validate the same vma.
>
> This code can be simplified by moving the vma_lookup() from
> vma_to_resize() to mremap_to() and changing the return type to an int
> error.
>
> Since the function now just validates the vma, the function is renamed
> to resize_is_valid() to better reflect what it is doing.
>
> This commit also adds documentation about the function.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

git-icdiff helped here a lot :)

This LGTM,

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Generally a really nice clean up in any case, thanks for doing this!

> ---
>  mm/mremap.c | 53 +++++++++++++++++++++++++++++++----------------------
>  1 file changed, 31 insertions(+), 22 deletions(-)
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 5917feafe8cc..e781ec4573ca 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -826,17 +826,24 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  	return new_addr;
>  }
>
> -static struct vm_area_struct *vma_to_resize(unsigned long addr,
> +/*
> + * resize_is_valid() - Ensure the vma can be resized to the new length at the give
> + * address.
> + *
> + * @vma: The vma to resize
> + * @addr: The old address
> + * @old_len: The current size
> + * @new_len: The desired size
> + * @flags: The vma flags
> + *
> + * Return 0 on success, error otherwise.
> + */
> +static int resize_is_valid(struct vm_area_struct *vma, unsigned long addr,
>  	unsigned long old_len, unsigned long new_len, unsigned long flags)
>  {
>  	struct mm_struct *mm = current->mm;
> -	struct vm_area_struct *vma;
>  	unsigned long pgoff;
>
> -	vma = vma_lookup(mm, addr);
> -	if (!vma)
> -		return ERR_PTR(-EFAULT);
> -
>  	/*
>  	 * !old_len is a special case where an attempt is made to 'duplicate'
>  	 * a mapping.  This makes no sense for private mappings as it will
> @@ -847,37 +854,37 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
>  	 */
>  	if (!old_len && !(vma->vm_flags & (VM_SHARED | VM_MAYSHARE))) {
>  		pr_warn_once("%s (%d): attempted to duplicate a private mapping with mremap.  This is not supported.\n", current->comm, current->pid);
> -		return ERR_PTR(-EINVAL);
> +		return -EINVAL;
>  	}
>
>  	if ((flags & MREMAP_DONTUNMAP) &&
>  			(vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
> -		return ERR_PTR(-EINVAL);
> +		return -EINVAL;
>
>  	/* We can't remap across vm area boundaries */
>  	if (old_len > vma->vm_end - addr)
> -		return ERR_PTR(-EFAULT);
> +		return -EFAULT;
>
>  	if (new_len == old_len)
> -		return vma;
> +		return 0;
>
>  	/* Need to be careful about a growing mapping */
>  	pgoff = (addr - vma->vm_start) >> PAGE_SHIFT;
>  	pgoff += vma->vm_pgoff;
>  	if (pgoff + (new_len >> PAGE_SHIFT) < pgoff)
> -		return ERR_PTR(-EINVAL);
> +		return -EINVAL;
>
>  	if (vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP))
> -		return ERR_PTR(-EFAULT);
> +		return -EFAULT;
>
>  	if (!mlock_future_ok(mm, vma->vm_flags, new_len - old_len))
> -		return ERR_PTR(-EAGAIN);
> +		return -EAGAIN;
>
>  	if (!may_expand_vm(mm, vma->vm_flags,
>  				(new_len - old_len) >> PAGE_SHIFT))
> -		return ERR_PTR(-ENOMEM);
> +		return -ENOMEM;
>
> -	return vma;
> +	return 0;
>  }
>
>  static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
> @@ -936,12 +943,16 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
>  		old_len = new_len;
>  	}
>
> -	vma = vma_to_resize(addr, old_len, new_len, flags);
> -	if (IS_ERR(vma)) {
> -		ret = PTR_ERR(vma);
> +	vma = vma_lookup(mm, addr);
> +	if (!vma) {
> +		ret = -EFAULT;
>  		goto out;
>  	}
>
> +	ret = resize_is_valid(vma, addr, old_len, new_len, flags);
> +	if (ret)
> +		goto out;
> +
>  	/* MREMAP_DONTUNMAP expands by old_len since old_len == new_len */
>  	if (flags & MREMAP_DONTUNMAP &&
>  		!may_expand_vm(mm, vma->vm_flags, old_len >> PAGE_SHIFT)) {
> @@ -1114,11 +1125,9 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  	/*
>  	 * Ok, we need to grow..
>  	 */
> -	vma = vma_to_resize(addr, old_len, new_len, flags);
> -	if (IS_ERR(vma)) {
> -		ret = PTR_ERR(vma);
> +	ret = resize_is_valid(vma, addr, old_len, new_len, flags);
> +	if (ret)
>  		goto out;
> -	}
>
>  	/* old_len exactly to the end of the area..
>  	 */
> --
> 2.43.0
>

