Return-Path: <linux-kernel+bounces-554853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1741DA5A1E0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B45B3AE934
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4782343C1;
	Mon, 10 Mar 2025 18:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ebg3pVdl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ow47u/tW"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D6A233D89
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 18:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630462; cv=fail; b=b81N3QzL8/w5UV3TZn+BaI8dNN92BrrzQJBKa6FvoZpZsMw5I5yKyDXHkWaLufmTJG04QrbEOfH/xPQuemSUZzKi8U92kj4CJio5dgejntkzCPaHTLA9RMhsa5cxMXmBjxOMt/cD5+lJAY4dvVJLeR1qwflLf6kCZj9KNuBvxwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630462; c=relaxed/simple;
	bh=taP0Nl4ED7iM+3l+N5JpjcZeE2r3CPodapSdsBP5ehE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PsgrGLggfd4BXRGiU8VNyHWvIn6E9Op8WQhSBUeZ0qaydVx7/2DKRsigtkwVaflPRPTH6T9TKC+z1MPv8cinSkG0eQOMA8vo2ocRmFNWrIQVceq+8VGuE+2k9FF7hD6O24O5RsH/k9UUY/ILugrwMmQ3DZAMqGVdu8fHmD7iU7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ebg3pVdl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ow47u/tW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AGfnte015854;
	Mon, 10 Mar 2025 18:14:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=pUeuWGZ0esupoq1p0+
	/ltsbohw5HhduPnaIvCvI4ckw=; b=Ebg3pVdlsiGmZhKTqCytu6StVBIG4Zfazs
	IkefAitWQGDBl3/+bwaYe6xBxJfruRTORe6Pva2JvDKsSix0bmu70znb0HF4aKyp
	oR9SO2+mRNjFa89M568obHPGL05th6YOHdd4DK4bHqAmsyGosJ/hJ9rEccg92GiY
	G192NbWxxo5JumIZxE/+cJ1kLbTtE7VwUEicsGN2/RQodCFuRYWUpUwcZ1c9Uoev
	Sk9EgOvAeZEaMH/olRsjG5NyeCbSpLaqHDMeUfYhofJ7xSLgS8GbctqbuVZpR7AS
	wqiYQwlPSbhd+mXvxFzPB3oiHseSv0OEl4WPo9v7bF8rs3RaQcCw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458cacb7px-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 18:14:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52AI1S43021713;
	Mon, 10 Mar 2025 18:14:09 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 458wmnesxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 18:14:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xywzVDTC/Nq6okAMOvdeOlsnahwaeKuKg9vUUoxmWh7k+Entbz0tUp3QXiOq6/L911L3lXuRPVV7ix1VhGFGSJVcST7BDLWyMGsmTysW8CiMDQRrx1I/HhgzV9LqUu9Qofr4Q+LKa/s/60jxKgH9MMt1RAVit8+xfkTdP8Dg65dRvZM4H5IptZPRElq4ZWNdSNbLiCvoVR0H8bYzDe3xwCAw04B8iBRxhvht3fOYtKh25VYRBUbrbkyecy7coNt2QXIA3CKL7GaEQ6VvHVm4UDCXGyA5wEkovZq5yIoOqExY9mw/ptRMllSM6todnFBwUnrLI5Cp9uhsFfaUzHYBJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUeuWGZ0esupoq1p0+/ltsbohw5HhduPnaIvCvI4ckw=;
 b=yw+oo3lA4r/jZDMuBWA1egZ3wEtXw/mhUL9AmImCwKbm7lF7VrhgPEyKshOGQ/nk/acW83sAKBHgf1+BWOOVC4Ma2ezviVkEULRJ3bV96M9o8bkFXxs9WNIqjKqiSigk2phk5+3ye3Q46+/yuGsg4sbJtpunHay8t6MdqMzXYFSxgqgiUwEp2pbMOcyeWRbdN2psqNElMa2eu4Y5NNorw60HcDXTkw0EdSLW0FbgkLetWIJXF/H7UPyqP4XcLMm5lvZfQglEBhNOR0NrBfPkAqTxA78QcXdshWX+uR2+b7MZiouhivPnFJCxnX62GidttMRV7fPesnYyO8JnaDCQrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUeuWGZ0esupoq1p0+/ltsbohw5HhduPnaIvCvI4ckw=;
 b=Ow47u/tWIwaZWU8SjgB5sNFbQncUY8EyqhXYI1n/T4y1PpnViLTFYiw70JeSzM8OJA0x+8KZh8h9oyY8WVX8G3cglGf9aZF9cdFnEa1kMajrsebYOO/f1Ix+wK9eKwYKyPQmJVXf56qORyK7H2wlu+kasHkeJGlhSFfkB+Sj8tU=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by SA1PR10MB5687.namprd10.prod.outlook.com (2603:10b6:806:23f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 18:14:01 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Mon, 10 Mar 2025
 18:14:01 +0000
Date: Mon, 10 Mar 2025 18:13:59 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jann Horn <jannh@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Harry Yoo <harry.yoo@oracle.com>,
        Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: Re: [PATCH v2 7/7] mm/mremap: thread state through move page table
 operation
Message-ID: <0602cc1a-0013-47ec-9111-1b4fdf8f44ae@lucifer.local>
References: <cover.1741256580.git.lorenzo.stoakes@oracle.com>
 <1d85814f3a73eaa241c554b3e0f751f3e267a467.1741256580.git.lorenzo.stoakes@oracle.com>
 <38628bf6-1676-409a-9712-15095eec8dc1@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38628bf6-1676-409a-9712-15095eec8dc1@suse.cz>
X-ClientProxiedBy: LNXP265CA0074.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::14) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|SA1PR10MB5687:EE_
X-MS-Office365-Filtering-Correlation-Id: 646f9c7a-0f44-42c9-9e4b-08dd5fff5570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U4xGe/gp5IOUpAHyPU8cqwQytsL0lF4qoLIVOplQ0x7uxR+ZPAudtK1zwbuX?=
 =?us-ascii?Q?GbwNUPlCAmmp1M6lqOceX6D/g7EGBAFIl9J0GzONk+grtm6ljPgFwO7YqN94?=
 =?us-ascii?Q?iliMNcCiauUfg0P3V22slgeJD4O4sGpycanLIIErNj7FnqDdMM6U3DHW7kZ/?=
 =?us-ascii?Q?LAeJBQ+mbSodbUBqoifzGtRMC0UDsijxqrFyohHzL+m9rOfUgmdgnIBTW8zx?=
 =?us-ascii?Q?GRK94/91TzgxXknUkIgk4KEbSwP/bS5SYR6/D7PAdMrskkrPzrmloANlXeMq?=
 =?us-ascii?Q?XrHxSrr6UvsaBhTxb0yDMmM8KDiBD+LPdp5SAmi5kXqXwYp/eeE57pLC4R/F?=
 =?us-ascii?Q?phlYL64TqqP7OwnC8SUroKyA+v4Sx/EyUIoonJbenEU7LpjOrawySft5Duk6?=
 =?us-ascii?Q?2dxXh/GMNpA6bBnR/8UoD+r9PMPeG8FWiDsQ0Jws9eP+S3Q2DW1PHaZNiXVe?=
 =?us-ascii?Q?YOgtr2Bf3ZjU/iB5wxElz7OrZSzeqf9PRn3ddv+6Y9N+L1NVvM3Blq2iSBt1?=
 =?us-ascii?Q?H8NajypxZG9RUlG0iaYVqIHSMTbN2Sxqz90lnxEMqtUm0Tg+Qk2bc+RtKqaN?=
 =?us-ascii?Q?0KIT1tSpeL5kE1BivYtgXCzob7dXuS2vb4JuNEep5HNLSVHsZrsxL4nrrarv?=
 =?us-ascii?Q?QWRMS0z0FBv32m697sG2mAuOm7D9cEb1WRQV3//NEF7BhrBGqdw9uZrAoZdC?=
 =?us-ascii?Q?znMR37S6zuDbk6zsXYHWchyU9ZjOCuEaWKnawVWyQP7okbAw0bognZby1sWx?=
 =?us-ascii?Q?uOwPHwzjZHQjN/s7xPUSNQ6o1maJcTE1dN1Ir8q9tBx/iWX1cuXHU6r6lU+E?=
 =?us-ascii?Q?QECWWZaIo3hD6Azb4tdma3PfiQuri/GsZvmpRvpdwSedx7xq1P4VwhJuTaSX?=
 =?us-ascii?Q?B7QqAQAgijCbfJLrgUBOAbrJRVw+YC8CgFA3QxT2Fvij1uQ9jG+gvCu1ytR6?=
 =?us-ascii?Q?FhWxNC8albI6jRYwwRHLe1ahoWaltB4IX/AgOU4rnk3AiRkOjOG9VXfoXroq?=
 =?us-ascii?Q?u9gaMFwgjBqWEykOuroqgaeQET7cyPrzkwH6GUmodjSV38JdLg77s2Ca4T4W?=
 =?us-ascii?Q?qUeLcD3SZqOLciCErszDawtsYSHCb4s00lHdjKWlj4GCZW+8ssH6rLMNu1/x?=
 =?us-ascii?Q?92tzlGMiHSs4h9H3e1lKxfsr9bO68lN0Z/e1ZzxjAses/avWGP3cRKEkI61Y?=
 =?us-ascii?Q?hTsHNE5+HRQGzzIPBg8oi0tNoMD4os9xDDxYvGfK84G6PDRk0b7XfBIdpS6T?=
 =?us-ascii?Q?jwZg1piJhhQsMISS5FurCdlwcCpffDy/tgBRCGJZ3y1TVlrhvKJo1abgF9Py?=
 =?us-ascii?Q?1yy4+JoKmx39PErxiXstn/917F2qtfdY+2DlotWhnoKq87fvZ+7vwCLvtrQq?=
 =?us-ascii?Q?Clkp/29+PkzCFb1oNpEklxo/CDMP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rQXUuI8YjWolmjxRPdIxLZN9dkOIGewV9vm6pbHBp0ijdCx8nqnI5XvVwpJO?=
 =?us-ascii?Q?1QD2Uq/PNcKTVFX6YoT9BHZVmHrxBI5gxCCgD+sdnEROC03Jd3ezjHzzaUR3?=
 =?us-ascii?Q?7RMLSckwCKqFBzjs/g9/dk/adb/IDXf+blHw6hXVwpZwVKHKWztrPK/e5VQX?=
 =?us-ascii?Q?+jjTSvzgSe3qcyukS7oxA6SVscVbDRFXOnLhfHj3Kqwp4XSrxigZl2bdNh7E?=
 =?us-ascii?Q?tD8UkgqiUxXs7cHsmVXYaX40cHdhWtSVdyasA4YmMx7WeKaDJIChpC1US7Dw?=
 =?us-ascii?Q?Eoh/TrMNfBLq2pLVW9TQhGZMnwVxzObJsaXT9Awal28zFhBUMwj80xCusdBA?=
 =?us-ascii?Q?GQcvOiW8dBYFp5BzxCgwNJE99PuGAAsFl6J3+8T4JGUiLeMGEij3HwLwllTE?=
 =?us-ascii?Q?z6UlwdK94hYVt4Tj7wVWbA6zjOG2lp1d1GiY9BMv5nVUM/JST9le7647olKc?=
 =?us-ascii?Q?13ACyfq2VAduQIrdcuQaTB/XXGPgY2A+DUkduHppt1Gc1k1huiaDcGQXgUK0?=
 =?us-ascii?Q?mo2Zn5Is0KzjLGigbOM07oZuCv0Z1FQK22PtksgjJU7ioQhM39gjvBdJJw8F?=
 =?us-ascii?Q?febQJo6bbZunQ5q7ibH6pAbnzVs7bCZGvAQvUrnLOtr9Nb7hfU1oXKbTnjB0?=
 =?us-ascii?Q?H98LCAmVj/5JeIUrD64M4kv5B5DPh45iFPGCuFsAFEay/+imef/puy+ZfSVi?=
 =?us-ascii?Q?Jio5masT45L6mbRgGESNPVPaxteHlQCwHHH/TRkI18lhmX/8fBIXkinxyU+W?=
 =?us-ascii?Q?WAQkMrNaKSrqfNiJP43iZSgRhG4QLEOsCfm+yr6SyagiBeggZnZmDOjuWWnf?=
 =?us-ascii?Q?1FnuC1sSQxbeZCOBT4NyNi6k1hiDMH09wN4SGP9zsNPmhHbrCxLlFFF2RQfQ?=
 =?us-ascii?Q?RtdJCASNUFQdoRJ1mUC5dBXfoHfP0Ot8db+fXzZQogIrFVu3nMMU3SqUTije?=
 =?us-ascii?Q?YmdC47UPe8E8PrU4yY/+6lzmJzWF7OA7AfJ2qIQUaHjt8CaWlYVm/yWnEaol?=
 =?us-ascii?Q?d6jVHfwdlJQu03tB+eGhGgwUv0/Q+KzXXhpT1xQIE8cMj7WlP1Ca+q9KGh8P?=
 =?us-ascii?Q?nD5asM97BzdCaKZGyp6zttZhR3sfcbZVuPaRWliuMeuMpTnSqIR0JAxQBr+i?=
 =?us-ascii?Q?MYZO3hSFePxIAh6kjzA0D5e5l3DnizBLeUDQkvHzMg8/26ROjpcr8fIjTzcw?=
 =?us-ascii?Q?/av3ea+Sc5NX0hXefyUNnOwzgqmOm7/Bqy7cdkIUzYk/DmgBQtLvAKW6Ooct?=
 =?us-ascii?Q?cm4FhRtNJX1sgdHDw/gDNZRiqTEaeq/qvTjbuzWqzi+QaT64BwHcaYDaj6a1?=
 =?us-ascii?Q?plmYeto93YTKqN0iFtGHxNzteVNUNdquMBf4quCgju0PVi81AXrmoTJUUVK+?=
 =?us-ascii?Q?sDDpNk2XqQBApLRqTj+mzywXwOCXiLfbuXYxMt9wKegTyXTqXQLGzCwzzxTX?=
 =?us-ascii?Q?P4szUVfEFFw/5i1SwAgwneg1LHChO7Kg1V+VGYSVKEdeNqYvLqz4lmhcfOQB?=
 =?us-ascii?Q?7CgpipNifOTpkO11Tu7A7Zgg9+NZTJjP6ELmskw8P98JdiKIkUr3yqr5zTuP?=
 =?us-ascii?Q?lc/3cDm3e26C99R/Em4zicbtOvbctQbwvzCq5mJwDe8KeBYxIkGeIyZr1xjb?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3G6v3EbYsL3vtTGUXnvLIWb0N3XcIa06hu1oERY8I/YeCjsSoGpv+27oJiVdOU+8DzOEiw/VxJt367zW25Hr+q/G9WLaHRADkV2XHHPnmzFe1TxhnKqeSEqrwVqGrBtlpHCw1M2fo6CLlgLDLnkh8zpcJb+RwAFqOusQgT05bRv6jf364usY3Rzdz6cdtk9GOp9WxL6aFSPL8H2eAweb0Lx5eHfpPHgKhUP53swes6BXgvbiMiKJOtNyRjbCfo92BXEXtuzO2ZJDy2gtC85ZHXib1tzjJTwy5dCXiijFyrCyQ8BGRjFUBsa7QPvoaxixqnWTXDse17CznSkypKE7JmeFOiIagypDgu7uvydZpeqLEHHF/cvfBVXiDw0/RGwSA92M0kQwHNza7IDnGKlnVlI4T98brPR0H8w/ksiD0r888sSAjjzo0rEkBXa3LaKIX6SN2tlIy+Vu73E2iSWhKzCtqE+M4+a/xDUL9l6aFPYUgACb2iB3inVLA6V0g1yqPGCST3As6s78sFKk4XnJK2Q3f8pPA376tSCo5wH2zVN3a3hIkoRDPj0pYqBEXNQGIEGjE5E3bLQ68nbOMANhscL2k7tlulsJsfMAczbEJb0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 646f9c7a-0f44-42c9-9e4b-08dd5fff5570
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 18:14:01.3093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s++Kz4MDG2yNCYWUYGI3uhhndahi4e8f32Ohj61mw5zhqXNMcuSSgPNL/mPJ2ASg5Fez3ViQWPndWIY/6WJ0h3qmPNEhAW4al6idMBpOSJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_06,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503100142
X-Proofpoint-ORIG-GUID: tXlxseul8CTNbVeTbeAOoujBh_uqWLei
X-Proofpoint-GUID: tXlxseul8CTNbVeTbeAOoujBh_uqWLei

On Mon, Mar 10, 2025 at 06:52:25PM +0100, Vlastimil Babka wrote:
> On 3/6/25 11:34, Lorenzo Stoakes wrote:
> > Finish refactoring the page table logic by threading the PMC state
> > throughout the operation, allowing us to control the operation as we go.
> >
> > Additionally, update the old_addr, new_addr fields in move_page_tables()
> > as we progress through the process making use of the fact we have this
> > state object now to track this.
> >
> > With these changes made, not only is the code far more readable, but we
> > can finally transmit state throughout the entire operation, which lays the
> > groundwork for sensibly making changes in future to how the mremap()
> > operation is performed.
> >
> > Additionally take the opportunity to refactor the means of determining the
> > progress of the operation, abstracting this to pmc_progress() and
> > simplifying the logic to make it clearer what's going on.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

>
> Small nit:
>
> >
> > +/*
> > + * Should move_pgt_entry() acquire the rmap locks? This is either expressed in
> > + * the PMC, or overridden in the case of normal, larger page tables.
> > + */
> > +static bool should_take_rmap_locks(struct pagetable_move_control *pmc,
> > +				   enum pgt_entry entry)
> > +{
> > +	if (pmc->need_rmap_locks)
> > +		return true;
> > +
> > +	switch (entry) {
> > +	case NORMAL_PMD:
> > +	case NORMAL_PUD:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +
>
> IMHO the "overriden" logic would be more obvious if we removed the initial
> "if" and just had default: return pmc->need_rmap_locks

Ack, agreed, will fix!

