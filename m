Return-Path: <linux-kernel+bounces-396401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A76C19BCCA3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3808C1F24073
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306A81D517B;
	Tue,  5 Nov 2024 12:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hdIKaZBE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o+CFK+ZX"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4BE1D514F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730809464; cv=fail; b=kfwD9NgEJakgRp7ufOv/BYaxl+xBXPe3RYeTxxazGicanvRPvKRmQZVitzeBreY94xgmWBF9uqu17JyHTAcpO25iL49ALe26b4JHxwMrsX6NPAbWgsMs8tbgS3XodPmmzipxHUGr/ExRmUPsytbYLB+sXAitcTp9htXVbUhS4t4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730809464; c=relaxed/simple;
	bh=JbOWPw7bQsr34jN8niJUoHe6ePyIf8t1qTDP63A4hXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=thmQTYwWlu96Uce6bla5IcuqeMPsr3wuSsBpnop+uYDylJw9FK8owgQEysLTiWc6UOgJEVmJveQmKN3LgVoaZXrNQxbbsi/p3+kP/FNZiwLk3FOSde+cR6gw+qDIXQQfMR2bHqlp85lm+ukKM0VFyjIhp4zo9n1HoEvytpNTnws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hdIKaZBE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o+CFK+ZX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A59iC08004735;
	Tue, 5 Nov 2024 12:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Gd4lo63sHNmmt8sUGI
	Nt7yoSQHpcgYOcJPYAS/e8zZU=; b=hdIKaZBEi/b19TYyM0MCCsO55h9kUJU8Bs
	B3p+7+mHfUVOWTWD3pmaScEof+jiQ79zbWfr6ilgWKcof+DEP9ObNpRz4/5yW+1U
	3cBHt3N80KEdEqergQ2KiXSnBfIRlG/Sq0xympc6L/XGzW8wMstR7uXvdHSqjumV
	qU2hmfJxeBmrlNllCoeHpRc0G4vEEq/dWcqgwSEIepZsONLq226g7UTDK/WfqeCR
	SAaBfkAiiZy9KmO0iuGLfMoR4EiVrfOyOv5oknMZFhMB2d0qxwbJY4hTi2Q8dLnH
	AVI4h6COqR2ag74DUCwPaVCvlWYq6gPMqdlI1M2Vv+Cpa75acj8g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42qh0389h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Nov 2024 12:24:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5BnuxL005055;
	Tue, 5 Nov 2024 12:23:59 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42p87afg9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Nov 2024 12:23:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bWTNc6ZG1bSjO1SI6FUcJJ/WuTsYmOZzUzH3HOoZ67WLwnAkekGPIq2JKaWvsAVongtS37TC25SehTifl8aCWBsxgJPxBI07OsXYYPLgm1alza5w/qxpFpMESv2O3Kaqjh7jUE9Nwhu5oR3Cph++k/dtolrytbvJjZYW4Y8Uvrmr5q0CmTM/W0Sp/T+rxnYeQ2xxDyynj4eyiGEkc+cN6Zzot5k6TgLLYYgApb0i3LxguPhoavkTa2fjHBJ1nLCzKhCdTShiw/DbRkixpsBpDrWDUSMYbFbO0+wGH7mzg7jUdlJUYm+30rL/gm6twmReR1JYkINtS2Gpj9d/Zatp2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gd4lo63sHNmmt8sUGINt7yoSQHpcgYOcJPYAS/e8zZU=;
 b=BdHsT9AmyBtPQl++yKc1eVWhRBYqAKMmvcn7SWZ6A0elvoDc+UUeDLrcfc8fKS8HkEIlWUkJYEOOuUIR06YpkRIa9moSqlYo1nxFNlx78HkzM1vo+jh8G1O3VgYDzFSnyLhKw8HMdEcvMtOAN8BNg7x9VILyMqsjgubxkuqAuGLfXFOkTjQd7KZ0Or3dkK8j+Z58jupyEQ+boRQoUoUgG4iAe7Vv4+1fYHBiP16UljJcm2+IP7HeJuXMTqSUGtLyRCBk0V57a0HD/401QDqTrNfILnGeWP//pIUj5Qsv6v0eUhNlhcAm4cA2jiB8o++IyjAHzuVG5iUyJBUtRJ4dfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gd4lo63sHNmmt8sUGINt7yoSQHpcgYOcJPYAS/e8zZU=;
 b=o+CFK+ZX5u+61Zj4yIj9QnxnyeDneMkdcC7/5nVpQVondja+0EsNKh/x+oCdyHwObuV6CCP/nF6zxtYBBqfU/yUlSJlePIGgdbFZ0fZLOHBXCd5iDUaaN31+H8vjdwI+ezRJFBQUzd8CJ3Tbh1qA0VI50UCAJSmpAGM7N6CHiso=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MN2PR10MB4160.namprd10.prod.outlook.com (2603:10b6:208:1df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 12:23:56 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.018; Tue, 5 Nov 2024
 12:23:56 +0000
Date: Tue, 5 Nov 2024 12:23:50 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] docs/mm: add VMA locks documentation
Message-ID: <6e43cc76-bc70-4392-a822-0ef0db19ea1b@lucifer.local>
References: <20241101185033.131880-1-lorenzo.stoakes@oracle.com>
 <ZyXqJNIqIx97Y0To@kernel.org>
 <164796a6-c9aa-423b-ba2e-5c6093e3d559@lucifer.local>
 <Zyjl-YxldU7EQAdv@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zyjl-YxldU7EQAdv@kernel.org>
X-ClientProxiedBy: LO4P265CA0273.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::10) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MN2PR10MB4160:EE_
X-MS-Office365-Filtering-Correlation-Id: 5607a4e2-98ee-4f51-14c8-08dcfd94b68f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w1CZHjGWGGNHfTm87EO5mupikwXu+Rakg5I8OHzhjnZJAY6capU2L+dQ4Mh+?=
 =?us-ascii?Q?1MmgYgCy6qpkNUdAnP4uBiCVey1bOsnfqdUPJWdpMFwIDBCeOCKVB4z+WNQ3?=
 =?us-ascii?Q?eytqTbojHYMjNUQFyk8wV1YXdOvP+ATwi6MrzW3MtSUdw1Y5saBpKwmARQiu?=
 =?us-ascii?Q?Z0HAt1UlB5lMSRY6an+mKXQckOpdeWL9IfvjmeQemUeK6qkmVRLUzteBc4Lx?=
 =?us-ascii?Q?E9MztpqzlUigF2kzfi8BvL6YkyRTTVya0wS/cav2O90IiU0lYe9/DNaGcWCc?=
 =?us-ascii?Q?662ogM6w9YqbwOVb0HsYkDcUOi3CiUVQEcGmn77YQ1Yc8zQVCi4fH4d3Y172?=
 =?us-ascii?Q?sotHXMCGks1CcmbFc5rbO3Tmtew8+CrzeYUHsTC/MbUgetr7HrZiaWSA+wsP?=
 =?us-ascii?Q?9ccaSii85iw83dKkx3n+5fipz4FXUD91FlGRC7Xke0nEf2OzT3kmWp7mRPB7?=
 =?us-ascii?Q?dAn0xfelAqYNo+MBWF3RJ7XDcQX0VCLY/cG44bu82iVcM07Z9CDw9NVlwwff?=
 =?us-ascii?Q?fORq9EjtPYs4gWQAZYG9/9jn9ZBTCYT9P9O8zOgBWvWIuYaNT0nHKJuD85r8?=
 =?us-ascii?Q?j6EZ+B7Jo5at7bBLn4QW5GiRnNwF6KIIqnAX3GOrV9pPYhNkV1iIzEG0fJdi?=
 =?us-ascii?Q?RLefHsMlRQwGKrW8z02d6kdgH6Nf4QWV/C2rY+m2G5xc2x9uXsUQXcIGnc98?=
 =?us-ascii?Q?jFTxVBWtYiDlHR8wh8vNVUW7dDTuB+3/TofuuMInU/Ln1/66EKycIG8xKKat?=
 =?us-ascii?Q?69WQroFHcf1K2zLXQI+/m804i2WvMoAOjIMUWZOeOB09F9TTZu2P919rwvAy?=
 =?us-ascii?Q?0yQGeaWimJqYKF5o0bkRSQlBdbDNnJVUHDKVkzpDgUPv1ukznUbZI44lqAzY?=
 =?us-ascii?Q?dW6zB+SH8YeKLR9I/uSpCyuyHo+c5lRrYQXpzCPOgaLcbiN93/28c+mYHGdr?=
 =?us-ascii?Q?h2xxkoGqDC+bnHM2/OyYNdFfm4AcRIRU38f12KivMpvRcRrzvTJ1NPNuucnr?=
 =?us-ascii?Q?4JMgruM0IwYUzy403Li/slaCuPJ6Q8x5gdf7/Q9+s1nbs+58LlhUXjWbSe95?=
 =?us-ascii?Q?pdu4icWarXh1lBCQf6jqUwIwqwowUN9tIFQ3SugqZ55wm09T1Na9HWJDhI4m?=
 =?us-ascii?Q?juM9IWMEzeeGMfxUtkVraIRjuKuyrgdjRwyNeuRtFxMleo/T1TtbkNmk2UyI?=
 =?us-ascii?Q?EvZJ7jd1yuzWTtNocC6MCGw0i8YNvFgGsZoD73aXTlakXDlbSZMiJJH7hX95?=
 =?us-ascii?Q?WKagV3IVH7iucMOpC17OtMTnER1D0NFi6AKlp76GfFnKKhZA/s3b5DfgR+yn?=
 =?us-ascii?Q?GO2haNykpxSNa2bV0PJAv2be?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?owYtDc2z92jnHg03LsJj3S7o0K/cO8rpaezfRuTeY7hn3/qYw/w0GxzqD2j3?=
 =?us-ascii?Q?x3a2XkzT3F5MDmwu1oCwp+UgWAv8YW5ZtMdgvte0zouYIjZNq9b2T8VqODQ7?=
 =?us-ascii?Q?loyedyZCrEuCDjVqcUNxVNZ5Bcynw8EK/7J38iGZFK+u030DLWGUuDd/WuLs?=
 =?us-ascii?Q?Iir66U0VKswrxSGsuEE1qpEH3XgCBlQ/1J3drCmtneDCKrvqJ1edHEPzm2Og?=
 =?us-ascii?Q?u1aPcUn7IuSfJSBJC1L03xra7wgHVMYoFbq4rhlautq03OOU+cc8QYqtQBR7?=
 =?us-ascii?Q?LgTQGjl3NIuRoIRFFm7bFCXu+5C54yFNjlgdih3ygJSk/uuuwuC+RajdmddS?=
 =?us-ascii?Q?LzR55aZa4/jYm60GTWsDAVin0cOBt8n5mNDhT2gH+vywYb/kt49MiyttsWaW?=
 =?us-ascii?Q?HREx+ajqOkOld3cg0koHqToS7WXIHmAYAPQO+VmgMhO1S8DUpy+kWOi8gOkE?=
 =?us-ascii?Q?I9B9fcw6qbr7qp5mTAR+2lo3YufHxa49br/+VUOf+PW4gd/8pCrQs7qSgiPY?=
 =?us-ascii?Q?X7VV7AofL7jMouWnuKjfwZYVfWBnV0jiZkA88xYKpZg1qPjvc87IxWPn/aZ/?=
 =?us-ascii?Q?PdNgL5ZnIo4ekoBxd1tD2C58eHk4Hzpg19QlzilK3cUDiQC/LCB5LMct0qCV?=
 =?us-ascii?Q?dFM90z+6p14YqnUXjO4YMqD/XTsu2XE1hsgzkNG5GH17CSnpdBhgpS6Musz2?=
 =?us-ascii?Q?C3YiE+NYOjB4HSh5JAW/6a6kMOtNNs9JAunixJcR7hPv6P2y1vy+et6Wszvm?=
 =?us-ascii?Q?2Ezjn6VqH/zxEGHLQsLf77ljEwvSsUKiWPG1Mi0FQRW413cvFkk+DUL172I9?=
 =?us-ascii?Q?M9z2zK/cpAE9M+SKOzV+AEOwgw72yoWCOri8r5gjRczkzs3Qd7mu0ClHwYuM?=
 =?us-ascii?Q?bDC4UNBHrmUaqox3RzWmFUJ+IGu1rQenxDe62oOTVHOjWdvBeKlQKtUKl2+h?=
 =?us-ascii?Q?QCILmD1xn5rcj3S8TZMOCUcbUM406yFukqTYQJ1upl+LYNMHf7MyI3jXrl4s?=
 =?us-ascii?Q?dB0EngDO1Vi9X/Kpkbpjq+U4FE4GhO3u2NFUoJcEY1REWNUAScCVUvYxUqb0?=
 =?us-ascii?Q?xB7xEChQsWVIMv1WcUIAxisFwHs4IVuEn/7ilWlz3XR83ez1T+87FgpRkrOu?=
 =?us-ascii?Q?89TD5hJdUe4VOCN82iqMJxxVACO9NJ3fd2iSTxag2gKAjF5tKUpB2b1/ABWU?=
 =?us-ascii?Q?7rNtvZ/TDEfHCx7lAu6RfZvGshq35mYEuTpb90THSYweqslyzd7PX14M6dOu?=
 =?us-ascii?Q?DrEZ2BNHPIFupEP4QzJ+jrSVB5b+vqjHo7QPJuLYMGOmjWZVhnkudRMsLjKr?=
 =?us-ascii?Q?TkBdybsnlW0jnty9Ny0hmNjn+cK4GPeHhZS+jYHa4ePzIAVDce8/+9A61hcd?=
 =?us-ascii?Q?gbMwaUHhGzm7KpXcVTJU21WFanqV5NX8g8AXl9u6ytBYM8oEQjlFMynO5whi?=
 =?us-ascii?Q?PSy/jaYyxvxkSvYmLu71rZhx5WNk5wGzDb/XKh14AIl/ZLPfl6YtA5WSfeXw?=
 =?us-ascii?Q?g3bYWlYublMkp2yS6UMbmkMYgXxkg9N0RkO4rTQWeUO2Tid2dyYLeXHIV8Kb?=
 =?us-ascii?Q?AAMvOsllE4p1Q8XHyZ1b4y+eimM3jbo5m/4LrDwQohiCPj5FPn/1co9tabJu?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hUok9eSr7om8IXc0urAboc3su0cB5Eb7205X7+BtrsQ2O8UN/vZdLs7fAeA4OrDTy7Ux4tw3ebXOwoDGxcnCRhbqOgolAMBYcHZ01OikaoTCQF+3nZRn8ZdkOfb8O652xo4rysFSnJe3nCNv6aCxSbDnk7IQAbKQB3gdrme7wKQLicnqKf1+quRFK/vrbpCa1RqV3AvqS33kMsTMg/44X5uxW7lyTpAuUEUPYncuia4RMW/4AWZZdUxPh6LR0d4dFQPwPD1n2iErqrTOChYf/sYIGpWojl9Q2R5RMXXnS3xyQfTzmLK5RO+0Zz9iRU9Oz53Y1agQ6zDJAN7zf4XhEt3K5LGYo5gu4USSSGyr0yePqRIp/1TVpaMif3Uoce7Ez2IALWr+33ZVksSrPvJWHc44Vpo/F0H5418f4SWxupNjZ78h/WTo+hdwfND+rg87ucDw4EQwtU+VoyJYYpQVPThtW2w84NlxqvRa6BrM1UG9DbCwEqARBcV9NNmnlT5WswpFErxUIUd2OtscyrLhhBY+7jb9sgN3NF4rN7MULQ70fNvQg21bMKRLi5OH3FpmX4Jjggna2h6xfZqoBMpCvFcoGSZIgZ0wbwLnhKTfb70=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5607a4e2-98ee-4f51-14c8-08dcfd94b68f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 12:23:56.7838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUivXf8tgw6Wp4xMoZ6j4Fm+jg7UNVVtLngfvADYa20uWLyX5Hau7x/7gtIeHwuRiJeiedkhctVtQkqlKmTDP/tjiVmoprFsjOtE96n/T0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4160
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-05_05,2024-11-05_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=842 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411050095
X-Proofpoint-GUID: iVMzfFp87XSDZjmCgH0Fxpc0_GJE6gG1
X-Proofpoint-ORIG-GUID: iVMzfFp87XSDZjmCgH0Fxpc0_GJE6gG1

On Mon, Nov 04, 2024 at 05:19:21PM +0200, Mike Rapoport wrote:
> On Mon, Nov 04, 2024 at 02:17:36PM +0000, Lorenzo Stoakes wrote:
> > On Sat, Nov 02, 2024 at 11:00:20AM +0200, Mike Rapoport wrote:
> > > > +
> > > > +The table specifies which write locks must be held to write to the field.
> > > > +
> > > > +.. list-table::
> > > > +   :widths: 20 10 22 5 20
> > > > +   :header-rows: 1
> > >
> > > And use .. table here as well, e.g
> >
> > Hm this one is a little less clearly worth it because not only will that take me
> > ages but it'll be quite difficult to read in a sensible editor. I can if you
> > insist though?
>
> With spaces it will look just fine in a text editor and IMHO better than
> list-table, but I don't insist.
>
> > > .. table::
> > >
> > >     ======== ======== ========================== ================== ==========
> > >     Field    Config   Description                Unstable RCU read? Write lock
> > >     ======== ======== ========================== ================== ==========
> > >     vm_start          Inclusive start virtual                       mmap write,
> > >                       address of range VMA                          VMA write
> > >                       describes
> > >
> > >     vm_end            Exclusive end virtual                         mmap write,
> > >                       address of range VMA                          VMA write
> > >                       describes
> > >
> > >     vm_rcu   vma_lock RCU list head, in union    N/A                N/A
> > >                       with vma_start, vma_end.
> > >                       RCU implementation detail
> > >     ======== ======== ========================== ================== ==========
>
> --
> Sincerely yours,
> Mike.

Since it's you Mike I'll do it ;) unless it turns out obviously
awful. Should probably be fine! :)

