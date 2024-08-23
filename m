Return-Path: <linux-kernel+bounces-298794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9C895CB90
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 13:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0337B252DC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE8018756A;
	Fri, 23 Aug 2024 11:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f0L7jmzG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AaQ4bmkB"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAECA14C58A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 11:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724413221; cv=fail; b=Yp7ihRDdpq/LTi74pkCUVEAEEZ+nwoRRqjPY/wBCADIc2EHyrerFr3iDA7V607nDvDFHw13OvYupwmQbJyxXh94GiMmsYW54t0AhkNygeVD7F/ynzCLErA+gz3AaV4d0Annc0nIly4Ff3BpyZlMF5zFQ0MtboV5lBzqfxIaxdw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724413221; c=relaxed/simple;
	bh=d6WI6UiAvooNBvHZs9txL1BBuNPpYoXMaXFv/o/8Q6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oAQnxon5beMAMLrmLTMN3E2Z7+1D1WtwiFqPxFaZa8wYg6t7FgeDpObVqG2ffJx0XyyjvqaZoVhjN7dD/V8Fub6E96XWuSO7EBqEI47J2gPbgoIKXg9+1ibPaZ/MR3DcLbkFgF3yojDzNHtpcQh3zDRl5C82iu9/2jt4H+tbLsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f0L7jmzG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AaQ4bmkB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47NBZ92n018370;
	Fri, 23 Aug 2024 11:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=z0RRhtPUX/fv+ej
	4rK4jua8PNvcZ99naCRWfZzqSDyc=; b=f0L7jmzGqgID9//YkU4xMR0rR5YJeRU
	Fp44PHrQn0dVQsiAuIwpIJ0mUDKt0KZMetFvO3LOtfSkan971t0DE9cdqnMPzxaS
	+X9dAMiYzHECHEDlAIFNjHdC0PitQbufk0DkedlhvHYkrDujY/JdJ21Wpciej/RO
	BLolsDjCZRGNlVdYqEQ8p3NVdGn3MIj9Qt2VVHK4pmRgB00BFZ6Y3sUjtcRvmfe5
	qecSa6JoXCFSDhW1O/2+Rfr34Wo8M3Vpoa8LFhENd9whOeTNb+764W5OkO5zfejx
	vWT5RmuIAwMhJyLT4k/4fNDfwAUoNecRMgE1JDxgZpTDcxYNo+kNMmw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m3dvg79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 11:40:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47NAi5Y4022279;
	Fri, 23 Aug 2024 11:40:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 416rxb9rar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 11:40:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BzZWJp20FX1fShrcCZYoYff1D3cBs8M0gIJ+2OkW9b8o7/yiRoKoVbnrBnB2dmE3vSvDc0mO4A2a4LN0irc35mV5y6cNPMaLKSaMXFjAMKQN17vGUKXvP8MT5iwpwcNNJWh2dooRhfwzgp1wBEM9+AYipLIJBs/XxIZChTB+dRG5BOtAu/rr1cCFtgjb+mcR2Rf2DKQf1Do1joKhDu0Aud82p5LP7HIC580DdaQ3aZ9rQMvNEV33J/MOM163bX3ppaBvZ7tREMwinBOVjll7viI69yHYJ6EhjAJXtWNaYpzrz7evhrk0SmQscVb07KQjiu+RClFU6arBmTHbxW9sKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0RRhtPUX/fv+ej4rK4jua8PNvcZ99naCRWfZzqSDyc=;
 b=BrWKij0XHV3jMZF2YkbPAjZCO3X2dcW4jReuuY4AisQ3uIbp13VNYlPGIwRe6CHhO3HgMBG40oJMfQ0CqG6ifkKjhFOj4gnowzE3oibl3Rolk6FDRadXnBJ9meqx6sthr/knAXVl8Nl24tIxvUO82yKxcTXc6yyJcmx/1jx8XCvr5dlxtLfWYIH2oCzTpL0PgZ4/e2twZy4Qym5N1wSJYNr3f45xr03zkUwK8toktvvfP+wnqqWtf8w7VbZ3cLzn90POkoQ1+G6JlM64nwgkbbWdU5MGBWBttARFruH7IgYbwdWFnXkfS+pOW60YMIstlGocyqWUpKn+Fv6mEHaZnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0RRhtPUX/fv+ej4rK4jua8PNvcZ99naCRWfZzqSDyc=;
 b=AaQ4bmkB2QEsUdUFEZg8Job3Hz7ZT5tVTNIqZGMEf5E+pKXS05/15FuKZKS041YajwiT0Y0F8vgBvKvndHKn2mScDY3zJ31o//lVbdMlovqkCmuxbFd4GNDAiuGNKNRffKPkzPrLWOpXNQF2MAIlUTfb0FWABro7t4X1KNuWzdc=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CYYPR10MB7567.namprd10.prod.outlook.com (2603:10b6:930:be::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Fri, 23 Aug
 2024 11:40:00 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 11:40:00 +0000
Date: Fri, 23 Aug 2024 12:39:55 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Jiri Olsa <olsajiri@gmail.com>,
        Kees Cook <kees@kernel.org>, "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v7 06/21] mm/vma: Change munmap to use
 vma_munmap_struct() for accounting and surrounding vmas
Message-ID: <fb6d107e-0e77-4c3a-be61-fdfb6e0c6cf0@lucifer.local>
References: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
 <20240822192543.3359552-7-Liam.Howlett@oracle.com>
 <b88f105afcd7d96a5306126c51ec236274780bac.camel@web.de>
 <f22f7367-db42-47e2-b702-06a13d41e97e@lucifer.local>
 <ab9edc828156be187042cbfdba41a52f23d19f79.camel@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab9edc828156be187042cbfdba41a52f23d19f79.camel@web.de>
X-ClientProxiedBy: LO4P123CA0648.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::19) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CYYPR10MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: 14f433cc-bbc3-4da1-d677-08dcc36851f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5s4V+FQHLB59+LhxHBrwTcGenGlyAltTxJRW7gxkPMwW+e9XGK+OEvy/secf?=
 =?us-ascii?Q?ZKFrJp4bHqVv/mTf8D1pkEz5o2LlmowTQrRcZOqU8b7lLhcmNs3lIdJSA80z?=
 =?us-ascii?Q?O3ew2nMcN6cAwRrNoBhnPjnJKJwDMC4O/Egxo7OZz4DOtIgbaSrd3ks1lU6g?=
 =?us-ascii?Q?UdL8BOghrp0XOy9NcmBw2QFoREtmDDuT3KvGbZC7s//ujdZdQOBC7Cka2GhQ?=
 =?us-ascii?Q?1PHZXHakbUm+5IFGJeZ47JprVmtdty3VWDaeRNGctulUr8RPWGgxImmMMLI9?=
 =?us-ascii?Q?RZHJtah6qplJibiYu9E/Rbfr7fO3MM/loDuNcpSkKD7xufzgTzPMo4LQQmtk?=
 =?us-ascii?Q?08n65BudL1uHNAKxQoUcx44PvcI6dZRVhClbraUKOi7feTYNNJ0uznfUXkI2?=
 =?us-ascii?Q?Yw58ieU6mrtpmFx/s/egyL7TNzXWbeDcReKuQ+NM9gWK6qDF3eL84gZHcVLu?=
 =?us-ascii?Q?QE/GiYGGTmQifr88W+6ZM1Lfe8CILQgbn/TB8lBU1i8ELkkpL6gvHqpNqsBD?=
 =?us-ascii?Q?jlyyRi5oyMvGusL/FdB4V+hgHeIuoMnReJsDLIHF7815tfXFy/jnZt8ghGS2?=
 =?us-ascii?Q?ZMiBOX4bEINtqwu+PmLkUIrXEembO6PpqjsHc/mEcls8kz38A6cvLVTJ9GK1?=
 =?us-ascii?Q?GlAGweDv5SUv1YrsOLfA9iEtzZMOUbk6kTUJbCvPNvrtFowGL2/wdxHN/XEq?=
 =?us-ascii?Q?J5MD/1PGvl27ZFWCVqx95JBnosgOV0JkyTTtGWPR1jIkAAJw3/C1qo6Ma09j?=
 =?us-ascii?Q?12R5MolTtr8qRaaZV3l/i0iTXFZn7ro5yqdtWAPc/+Ddp+MBS418qGCsb8Qx?=
 =?us-ascii?Q?w9zLfnJIeRgHgpyhJiIUAm2jJbQgrGWjRRAq2kCqywqPiRHN7ip5tmD6lfAU?=
 =?us-ascii?Q?RDOBgpar/A/kaPDemhRb+h6gCj2qwCkQdjMPfDMn7YKoKaU6uCJRhebr4jBN?=
 =?us-ascii?Q?s6nzJLF6iRBZsFvjLtRC4rtkSA7zAjymqZfDlFk6iULRN+oP1vl+tKdouxNM?=
 =?us-ascii?Q?gHo9pOmFa8RsUKIvzs/EhKJkhHMTCNKR4mTisclKrKFRQlo9jKeG8OVw4OmW?=
 =?us-ascii?Q?dPzZOOLq+NIU8dKYhOJh1aehsZ7N2FsN/26P7j9bWoOzOL4vC3JG1m0v/est?=
 =?us-ascii?Q?4zm7jcw932RbmoZmI2omrJsYmUHgpyB8GDPt5vdFWQIeq0P6EqDUzzSR0oer?=
 =?us-ascii?Q?e/DWsLdKR7uqGfhsL80fL/Vwe9mBwatDCtMgvxvrhXq8aIE8Qj207mphnkwu?=
 =?us-ascii?Q?3G+4dCZQ+LLF+oynHiwLnLS5iNtSVYGD9CuAcf01kGk0OJNYGqxwgBovRD85?=
 =?us-ascii?Q?kvtj2jUBiNay+4xIKTBiltrej5DOqXhQkBz/Z3EyF0OoSA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nAS04+Wox8YtJZsVlB8KsvW8k5HqtIlMkmQqfAH7n1dQUxit/TpF/0UjQHoC?=
 =?us-ascii?Q?szaEdbIFk2tMFClvpswiKviSPK871WPHwq5DZnhIsH8BTOHrZfg/iZ4/Kzr0?=
 =?us-ascii?Q?7qA5qGB8R9ur64M/y7WY6jFX/xnL2OGQoCyZKE+WdRHqHZqVatAmb98W2Sx5?=
 =?us-ascii?Q?MMfxDYI/kQFh6zKsRfS+l9qcdzZGGRMM4/oKokbg850Gcd46AcoBVsspGrx+?=
 =?us-ascii?Q?cV3i/fSerzbPBibM1ARumuCVH7wE7CKxpGoS+gEfRrLa+UY48z/elhkJ+/oo?=
 =?us-ascii?Q?Gj5qX0VcWbmx1+r+Uq3j82tskayTMX25TJVoLzvTPZzY71S9Ab2KJGtTgdy+?=
 =?us-ascii?Q?ffpU937s8x98/kdECgthCiXT9yqsoV1oiKyffcNVY3nMviXXX3VjfP7hHSqw?=
 =?us-ascii?Q?1PoLoZWwMBs5WRDnxIzwd20vfZBI53f7pclvcdgFfSy4Jr0YICdWaOIO+zRo?=
 =?us-ascii?Q?FhFq4wkMypjRlcHfrUhDfnvdUIiOk7WVKrygbefehiFB8DC2OE7r23pk7S5E?=
 =?us-ascii?Q?g/eMUUkb709+Axe4q7IcQcVKinxzCzAzcTTYNhs9hCEb+fSgZSbsPAGvuHIS?=
 =?us-ascii?Q?OAXavzUu1Nyi20Ycssot94A80RsutPbQe0OG3yu6Z7OCqlzI9Wfs4j5vl3M2?=
 =?us-ascii?Q?5HHSAHl415Pij2rCXwhNIL49IIlO+u6LYuFuqDxLvbUZNW6aFeqPS8/CcLty?=
 =?us-ascii?Q?KQSnjSWzHPMfRhSq8SSGf4YKUfKZ1PpTEkMSAb0ASzUoyR+APa2HIOroRcDK?=
 =?us-ascii?Q?u3fgUwDNfSEU/DsJyuMbrwC02zcm8Y6pyNj2ZtId8hpDW9/wiC0KMbLo1HP4?=
 =?us-ascii?Q?BpRB9raOG69KjRhCzUIoZz5Bln/w65uWX8d0Xib+2AW2V0OE2izyOJYHsZjb?=
 =?us-ascii?Q?ClTkPD2YU5D6xpYSxnhOHr7yeHJ34Jpsh6mLVWJviTrdg9/yKcs8n6rnjsC4?=
 =?us-ascii?Q?54sxUyms4QkwoTCo+eggyumy3wqLAcIy6R0E38jbx+E+c7AHmXJtWR0Hp79N?=
 =?us-ascii?Q?GfDFDveeWOBGZpGA3OO1N/nKClKhE1d9J8qq2UUzAySwNsHpGD+ZLNRwJlmX?=
 =?us-ascii?Q?prrsgae3y2N+0odLFDC2O9FlEI88A3npHEw3/ulP7OTi2PrpGhqQvblbeaRA?=
 =?us-ascii?Q?vC7tVdOAPWLNV1yQx/LwAwOE6AMTNq3xjVN0bm9nPB3BGYFgOF7niOH83KaR?=
 =?us-ascii?Q?tnVK3wT0mfMjdv8T/YMQxkSSe9JSWZM5RMIc5wirJV40tduQEw7MejLiNVSx?=
 =?us-ascii?Q?lHup5DrCC1u1KR/ePcV5L4GJs+7VQL3x9GwAkrB0WaE0qgMW4zFWHaGEn3El?=
 =?us-ascii?Q?rtGinu8CSKyR0si97VzqgaDDV4m1/fSaMdcfIslQv8an6QT29bKRgd4SNh35?=
 =?us-ascii?Q?FJfRucJhAb+h6hkamIE4Xgo33jcpOS78dxVmp4TGqaK429EYg+DW4TwZZbOn?=
 =?us-ascii?Q?qvFjp51JLIWPbftGli8jsCvoKbBEEQW0w7iSzp+/KANaBsiELVI7u5aJKM5m?=
 =?us-ascii?Q?5Gxki+Rlw2pxnVn3zfQS3YDttkUcx2KfMvyL0sFrF77z91gmAS+B6qT6sXZ1?=
 =?us-ascii?Q?uMzKZQRpaGLPJsFqu0LzJU9msWbjwWtqxMr5jvDPdrglRY6EkGLuH6kzoAOX?=
 =?us-ascii?Q?wDTxqwFLA5X49uAjoLAyEs8pHysr2qDAm5w+IDk7WmqMvWBavhNkqVnw1rLZ?=
 =?us-ascii?Q?aAAPgg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9x3WvjCWH85WCrgnKVApedB6Q0nbumjLBceYuoSq2MjJRY1aAKuPYR23eM8VCpE+qzOLT168Dzv188fQa4MbXo9CG8C1fYLT6Vvc6v2wqtAOx2/f4WdVcRlz5a7NPP/hzNXjgaJN8MPBAa4H8b/UALvkAjlmwZ2gcrwCEsMJXBxIjzS8gy1kZd8F+heZRFCOOff9YFkjqa/vLmwVpJoGBPFnW2rtgZ+FRSDPsc3a+461I7QmtpsgD+xk3fHzp3V7LP6t/m4YtGq+ms69XrhbtaWUsxq/MaNQhfGgkNARBeAvH0XSXnGaITrGE84xYN7WJT8e/562prKQDjmp5O16nLDGXNMXe+uEg4vtaSwU+uGc7UVD91KQUBPcaxltFFVzLJMFZZpHCf3thRqR7YXgObQyL3wRQXj5dXDEBcfTPc8SA6/boGdnS9+W9OznBhqi6HWCCAflMbYgmqtmS4qf+NpzsEwqFPe5Jk9DNn4nEKXg9dtxuV6MOIJVMlfhCvFrh3gI4fHC+m4h3xC+FyJD1EjHlrBgUg2C6ca2H07/uBiDvkyp/GnNkn9Nq7eIInBl8uVdRrBZoYf3Jju+bWGGwS2pVEQKrpfS5sf7HlrPSIA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f433cc-bbc3-4da1-d677-08dcc36851f4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 11:39:59.9707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ampBvPA46Mosh/RhhSG9AuP/MJeqLrIWFURQDV98on5wYehq5nuhS6XZfVNyCFY+jqU9ZO9VUxULdPRVD6dyYAvaS2q/anG0Rxuc3h1GWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7567
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_08,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408230085
X-Proofpoint-ORIG-GUID: jx0AoFF7LK8i6GvJdIfjGb2gPL1i1OQy
X-Proofpoint-GUID: jx0AoFF7LK8i6GvJdIfjGb2gPL1i1OQy

On Fri, Aug 23, 2024 at 12:42:18PM GMT, Bert Karwatzki wrote:
> Am Freitag, dem 23.08.2024 um 10:55 +0100 schrieb Lorenzo Stoakes:

[snip]

> > On Fri, Aug 23, 2024 at 10:43:11AM GMT, Bert Karwatzki wrote:
> >
> > [snip]
> > > I'm running the v7 Patchset on linux-next-20240822 and I get lots of these
> > > errors (right on boot) (both when using the complete patchset and when using
> > > only the patches up to this):
> >
> > Hm curious, I'm running this in qemu with CONFIG_DEBUG_VM set and don't see
> > this at lesat on next-20240823.
> >
> > Liam's series is based on the mseal series by Pedro, not sure if that wasn't in
> > 22 somehow?
> >
> > Can you try with 23, from tip and:
> >
> >     b4 shazam 20240822192543.3359552-1-Liam.Howlett@oracle.com
> >
> > To grab this series just to be sure?
> >
> > Because that'd definitely be very weird + concerning and something we hadn't
> > seen before (I don't think?) for the mm->data_vm to be incorrect...
> >
> > >

[snip]

>
> I grabbed the patches by saving the v7 patch emails as an mbox file and using
> git am to apply them (which worked without error) and git pull --rebase to
> update the series to next-20240823 (which works without conflicts).

Thanks, you are right, see other thread for an explanation. Good spot!

[snip - for brevity cutting dmesg logs, but much appreciated!]

These messages aside everything seems to work (I sending this email using the
> affected kernel) so I'm wondering if the checks aren't a little too paranoid.

Just to make the point - if these checks were the correct way around, this
would indicate that key mm counters are underflowing, which would be very
serious indeed - so just paranoid enough :) The paranoia is because this
should never happen.

>
> By the way: These 6 patches by Pedro Falcato are present in linux-next-20240822,
> too:
>
> mm: remove can_modify_mm()	Pedro Falcato
> mseal: replace can_modify_mm_madv with a vma variant	Pedro Falcato
> mm/mremap: replace can_modify_mm with can_modify_vma	Pedro Falcato
> mm/mprotect: replace can_modify_mm with can_modify_vma	Pedro Falcato
> mm/munmap: replace can_modify_mm with can_modify_vma	Pedro Falcato
> mm: move can_modify_vma to mm/vma.h			Pedro Falcato
>
> Bert Karwatzki
>

Thanks for confirming!

