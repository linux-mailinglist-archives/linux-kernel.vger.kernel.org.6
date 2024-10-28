Return-Path: <linux-kernel+bounces-385965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A63DC9B3D8C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1988FB2214B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9766E1E0084;
	Mon, 28 Oct 2024 22:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MROdIl9h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="as6YrkhS"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F591EA84
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 22:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730153719; cv=fail; b=afjnuf0F4pC8Y5ERKkjjJVQKh1vMIdAm2jzTUsf+KyWiKfHIPHrzSH7M3reCN/MbXmXOIUIAY68ndZit4eiHfBGBh6oZlEtXl+ElgdkoCuDkJpX3CePNafH2fzD5kYWXNeocp/XPjonaMzL//pUO8sBeaMGiVYbF7HSJjPb+H4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730153719; c=relaxed/simple;
	bh=VWhScTVrq+cJ8XhL0LsNjHGImLAOYq4wiqUT9rX3wCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ItjgW8rQwTimHWA+orz15R34vZFaGL/ZXqOMOt9+PIZ1honOQXWexnAvxa4DwqAPuSECRAOqibGJMPoTvnW1L+RyH90XdxBlH4tpSuWtsBtCQj7rdQpr8gbLF1OI9ePu9y0QReEUVhRH9+kb0Xwc20dJgo1Qjl1+5v3zegwFpQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MROdIl9h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=as6YrkhS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SKtY19010202;
	Mon, 28 Oct 2024 22:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=e3YNrkzqqcl2In4RER
	h9byjJpv8DnNq6ufM9xiKUQAM=; b=MROdIl9hX1XNM05qJy7SPLdQF0VCOT4Jh9
	i0h6FKqNXUqao010TbXTRv1M4QJlcmOLEQT7qpyEmw9yF2cCMHwBVS4gVdfY+0iR
	YRFSKwOPkTyXtYb+Y6gIWeR64M+3V9hIohKfeiHd6oin+3PQII864FYuVcS2uLoQ
	Unovhoc+t9y11SrTstI1Y6RGxfev8bUmrjRE5YTsRf3WI8U4PuLRSC3GYdp0LIYl
	ks05a34kncbkHRnLQjKFuIAFxua1zWGcbP9ERy7xjBvnv3NqJBgbPTwOzDoaqyBJ
	G63LClACsniPnRGwp4N2SrQXpjn4sKHMbVuyaQVKqy8ImIn0gELA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grgmc3n0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 22:14:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49SL2UZO011745;
	Mon, 28 Oct 2024 22:14:57 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnabgejm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 22:14:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rS/qv6Z2pCgnoMW9pehNgjHuOwnRf4BhrTphNuTY9AlPAeL83UxuQ9jp385NHBihy1adE6k0IxlobfaORwNjYec9pRZEbCxov2XK2/IcGK9mrglS++XDGPfYmbyQwDe/hnffiW8IwgVXqHff4W/oiFlyjlFlRJyl4VwSHeYDCVs/HTyckrpwvMnMBxjEVxUZ8wG0OsS+YxRMAt00VIhAf/jvBsEwekQF4KiomQlmbOAb1Xy/nYZaEjZ2wO3ZJTpHtcNJoPwY9tk/N57/Tdvb/SrU71aq/Rd9izBHQLKC7ypWiEtkMrDmILdwHzUIyxO5CxabEYl/swvEYIhp0dIOJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3YNrkzqqcl2In4RERh9byjJpv8DnNq6ufM9xiKUQAM=;
 b=UI7DCynHsXzVLsLvipOu82v0IyRdQRAeVerlsz9X2VYe08hp5ElI0+RVNKGQG/9m6Aho9ca0cJHLlFLvt2GI6r4+fHZGimk8SM7Xp6q0zNLZgGX04iPPpEe0AtXCr5Sj1Vgboyf9jPMkNYYixQCEifeBpwlbW9x2iaOYsUQv00wFbIFhN5KYK7IIgiOjEvnSzeptpYTfuA/j8p043JsH+W5mfyzB2OiqXfHzJcAabjStO9+KTHTrfvpUmbuswJrIkmZP5EeXpgiHQqo/MZcKNKK4u+WwTqYzc5fjkhILqYeTt0ZINZB0HL1xYoYAtnHlqRDullqngYuxE6ULWobqjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3YNrkzqqcl2In4RERh9byjJpv8DnNq6ufM9xiKUQAM=;
 b=as6YrkhSQYy/C5iPC0b/DmYtCtFZpE3BKZBIglUtGHcsHD0+Xb+WbOn4RDvHliJRrBE1X/01vtyTJC86n257s/EGNRUaY+yEbgJs4Wu2aAfdhIMQQ0ifnhAEOlUPTtV2IGcp/a60DX2QwDxxH5sIUWPVP1X1JEdZdcbdYDX+haQ=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MW5PR10MB5692.namprd10.prod.outlook.com (2603:10b6:303:1a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 22:14:54 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 22:14:54 +0000
Date: Mon, 28 Oct 2024 22:14:50 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Peter Xu <peterx@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: [PATCH hotfix 6.12 v2 4/8] mm: resolve faulty mmap_region()
 error path behaviour
Message-ID: <cf1deb9b-c5c4-4e85-891d-62ecf9a04e0f@lucifer.local>
References: <c24a174d-c8f3-4267-87ae-cf77fa587e82@lucifer.local>
 <CAHk-=whD9MrPwPMBgVG16T_u+my8xYtZg2tUGz932HeodVX7Bg@mail.gmail.com>
 <438f50c5-8b8c-444f-ae85-10e5151f3f24@lucifer.local>
 <57mgmdx7wgfwci3yo3ggkmcnm3ujamgkwcccm77ypvmer5tegn@opiq3ceh2uvy>
 <ykzmur56ms7fm4midi6tbncjvcvf7ue4lp7e4orblrmwnefw3e@oa3enlpdrcrr>
 <bea02efe-a695-49e0-b15c-2270a82cadbf@lucifer.local>
 <CAHk-=whpXVBNvd0NJpw9=FGcuTuThwtfcKeM3Ug=Uk6kpChCPA@mail.gmail.com>
 <0b64edb9-491e-4dcd-8dc1-d3c8a336a49b@suse.cz>
 <CAHk-=wgE8410gu3EabjNEHhOYh1dyYwt23J62S4a9SYcwZUFhw@mail.gmail.com>
 <1608957a-d138-4401-98ef-7fbe5fb7c387@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608957a-d138-4401-98ef-7fbe5fb7c387@suse.cz>
X-ClientProxiedBy: LNXP123CA0023.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::35) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MW5PR10MB5692:EE_
X-MS-Office365-Filtering-Correlation-Id: f0508d04-a18b-4a48-76ba-08dcf79df2e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ggBtNOwKo+ojp/bQYFAsgqfaqublLm77rr7nHxAWcROlqG75WD5GM4g1w3zx?=
 =?us-ascii?Q?ogLeBG40oSuG+T8X14ZJSEwq68msbYGoOKYDhSe2N58yYJNGUhwGa0RQPkMs?=
 =?us-ascii?Q?jqREnFqZHfnECHwm3l7L/8sP5uCuafHK95b0YtUdXTrtSiEI2WI1K5aN3Bqd?=
 =?us-ascii?Q?yFYavF47t3RDmuZN1P9tje3KsUm40uYMiJxtWzljGnmPsbbsEwFDb5LqzsJF?=
 =?us-ascii?Q?hzGrHw/vTryLzNt8jyWp9xWouz5ndz/hv2T7L7hurGunskarhgJcK9wMcMak?=
 =?us-ascii?Q?EL968ZRT6oMjU1Eqb2boLvW4YZD1gWS0RWrE3PQWaEyZ3ZleA4PRHxrPgHMh?=
 =?us-ascii?Q?dtaz1cUCreICeUNQQHdebw2F30p/fnZSQvoZALX3IyVQG+UuQnXeLhDpCmXg?=
 =?us-ascii?Q?lHMiC9jYoENkv78AMx6A3GpPaXCUpQdpkXNbOCQJj9DCG6db5AfJvkIE3vvb?=
 =?us-ascii?Q?4Cq6ynhUp3dfFQxoQkJx12hJuKtUAS7MQBOnuHZTG9hCPU11TG0+7xPvIdJi?=
 =?us-ascii?Q?pft10/0GLrFdc8ep20fXE+pa4sYfLoZLtqeDlCIa+eLfhWVmSus7MTUPvgYh?=
 =?us-ascii?Q?wAoL0JMmOArK/o0s6PH4AedSszhXvTheCYuawtO0e8W/nWJcwynmbh/CrcV/?=
 =?us-ascii?Q?VbMIqAonI1TJ5uMbheVN4wi6zBOPOZ+mh3mCIrlTbphzYkAJDVtTfY45b7E4?=
 =?us-ascii?Q?dWc3BnLjEOVgefuCnC5eiFQavE85glpt6H0+O5s5h+7eSLT/fn8zEXL6r+1o?=
 =?us-ascii?Q?ogvziDUNVtkfmz9idf7tCpZ8KFVxEJSfYXt2WIuQiz4HSe1EyZCJCSgGoyr/?=
 =?us-ascii?Q?iI+wHZElE3XmOpwO/eRP0iFRzxD8s1KmVukt7QcUPR9gtWeq1kqmuGgOdqKU?=
 =?us-ascii?Q?1zjAmpWxUxBe8IsWb532raCSMMouLKjpJZKoAD2N0nJhLVO8Gdv4LVP+PPmG?=
 =?us-ascii?Q?wyeuEQfzj3X205Z9fv3jXpCT2qe3EP4WlrxEuX1QI2DFiqD/x5tGKSqrHCzF?=
 =?us-ascii?Q?+puKOgcpYEMIot6kcenDRimKdWCQjMVg0Nz33eS3KuixmPeZ9nBnQ4m6xqdn?=
 =?us-ascii?Q?BHPJHDweY6bnWndFG/t335y47SR5GZCdtAAXbQQB+ZuBSlbUJxf44sjkEw7F?=
 =?us-ascii?Q?jU3aw3lxhWmZfnvlTwGZhWwGtshaMKU/5HiBRTadMttGSlP/NlrMcUmnw9ea?=
 =?us-ascii?Q?94NGizXHAWtMDAQsa5X1zi01RqwAUPwpi1eV1w3VzlWJ5+xCzHJxc4VBhWvU?=
 =?us-ascii?Q?4v8P1g3MZs8M+wlI4zHXFgcw4Lm7XvN3sNojG17ZZsvIAaCU1FUVvd6bSqmB?=
 =?us-ascii?Q?zB3hefjNSBdR5En+wgq5KMka?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aZzEju1lBr24pGNkMfb+9Y6lswflTyud10rjVAJKx3j43HdilNLICN0mbh8s?=
 =?us-ascii?Q?5wv9Jf8hhM6ce3A80trqvgAKfYivwfEjdua6WRuWYFqf9OVzkbz7OL/HNujU?=
 =?us-ascii?Q?IrKK36ASdcU6ChgB8Yn1c3bu0olpb/eciMqqrROwNVT6A5Ky6RgaVov4t3y4?=
 =?us-ascii?Q?vd98KMrxVsPtw61KRqxS0HazGFibS/xvFd0pe1urAUAk2g3H5y5fVtEZh/So?=
 =?us-ascii?Q?68wXso7PgvpObnBJITeXdEC/Ppe5TR+RY9Ejswx3DWq0H06X9Jjo5bpjmDJ3?=
 =?us-ascii?Q?bJW6FA3m+DT81DOCG1Kh+N4AXZ3taEmFuCOfi5BojESYVZ7WpN3FuL38Ys4G?=
 =?us-ascii?Q?IhzMCphQdC2XRAiZuppupNEgJXR5mNzJA9EQccb6dMlti5uZutFewQLdgtjZ?=
 =?us-ascii?Q?Rv63vU1QK5gnG4BIyNWHXmjQw+uJZ5OKcfMKfWlv+FxSwxOF7Jn2SH8no5ru?=
 =?us-ascii?Q?dn8BGISgvP7nMCabfXXF9KttnytIMCDkpYfeu1X93pO9IsKqOyQ6NKFROFWG?=
 =?us-ascii?Q?vjWj0WOi44HvtIk0WJNPOjlbNDzFLIINVDHJ7hbRcRBLKMThkfF1mbZfcyWx?=
 =?us-ascii?Q?30ZN8YeIPTTxvjQ+pYFePpYd/h+iWNBBDTQ0uEPqzqj3XvJ0FpOe7yfW0blN?=
 =?us-ascii?Q?Z/yqPL2m+yD+YWKwW9Sr5f34/Oq1ZMXPnzrOWo4R0M3zuxIghZahtIRpRsfO?=
 =?us-ascii?Q?dX/u9dd01t4HoEGoGC24N66jd1VsIuArE1mgcypcaIhsDeiSQLEh2c+0NGyE?=
 =?us-ascii?Q?IUBANaGM8Zzv1CsLARlKssFHiARl5tiLTfdtSQ4gj/hn2ugrpNBf87HKzoGY?=
 =?us-ascii?Q?GYfi1kkHmtYMYjufwmGzjvFV8mFra0FBLAtnPplGmE1IoFaM0XVXWsK8qoLj?=
 =?us-ascii?Q?yfgsxK0ck/6xQV5jCTxgJLTBNd5JeS5L779acLPvBGDho8sT9W+f5H3CmmUq?=
 =?us-ascii?Q?C7wcVjfatl2DI8CsOvozuVjYpYd5x7b2K337/KQDL6nc+ns4fFM/hLoVAqzL?=
 =?us-ascii?Q?AKDbGCTACXDt3KJ29mybf7eKPgzF2ByM2UWmMONn6AnQa1FsEczGGa/tMUMU?=
 =?us-ascii?Q?MPMu/TZBz2bAylFazNG3DQT/rcqUS9ohY76lqo6CC1+9hXAu+fpakAtT6hsw?=
 =?us-ascii?Q?VUcXsz00lWBURQyumBaXQuAmL7ZMc98IU8a52JGEW89XhfQ2PWjyF2Tp9hfq?=
 =?us-ascii?Q?B8+uSoD/44N4JBY8CgRrPQhxNUAJ9PAZgykxMuFK7PipPX8SCo5vVHqpBQfU?=
 =?us-ascii?Q?QE7Ke/5lvxsg0gNYPdFdUAM4W/lKu+bW6BbuUpblKeJoGDOd00bl9OeXJGe6?=
 =?us-ascii?Q?sijsdvG8rYrg8YkvSqr3JfXGARqVThyaRY0/Lg0GHPVegAv5uo05I5wXw9IT?=
 =?us-ascii?Q?eZXso1FP79OT+jdkNh6qY2Bmw62ODeHbuloDvzLjtJNnVGu3iV1XGkH3ZHOu?=
 =?us-ascii?Q?+/f3rTsKWntxRgU1OacnfLspnAl6BDxGap3TSbGowlE2Mrsat7nc7IWBBP4k?=
 =?us-ascii?Q?5Iud9e6ks1lwge/SUOhWGf0/gJeo7kD0qdSLhKwF6WXEMnGmy/iZDZjh7jbc?=
 =?us-ascii?Q?Qpn1WSiZLdpil31kw8o9ZMXjVvxeSrNYpHraQAoHtfqbV95KpxmPUDySRnr+?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AV/aQse5rc/MGrfkaQD9nqK6H9xQySbJQP2qYtFrSWsuhkpi9hpzkf0DKHprN1sTCSH2Ht9DL1kMKKZZFln6u9bt20oHW6xcliyyv7UOjwZsy2WDLnKA6SmZzPkRgf3Q5g6St6Vh0Gkvl6ppV2W0G+ihpkqONJ7vKYBXZN3RLfmF4FlWIsXoQl/noctL9mK/v+9w2X63YlxMvPjTdeFGEDWyB3qBTAtJPF7677Mq5nOLzrTkGWRC2fxhkB27mboQRm/2qAp2AQ7YmeMy5RVrr8c9twKNGA5jA01Lr/GcTmJzw7PU8JGgcyx+Le4WdeJ3sRZhZVFQAwXMl1mIDFpldLt1Lewd1WlAsI+YpvHPTe7FuGV6P1sNgH5mgChuCDNJUkbDwiF7apz1wOKDZRGyssuekuoaCc5JS1n9KyrGu78BwDTQlf8DNl86Vyw3obbJr6ollaFd9ctX5UYyxCtQLecOYvIxmbbxiRM15nW/T9dnrgvxcAvfHYKGkXzKRX5I+Gkel1VT9x/L20m7B4ktgq56J9HbYBTNVPokk/hBzUhbOOJSiVP7wS/UblwwtIkMumjQVO24idWR9uzC7sNL03hF4Vc5bt9fgPi4ShpTXrY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0508d04-a18b-4a48-76ba-08dcf79df2e5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 22:14:53.9381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ogrEnvAeLJJN9vwyrgtDKtIVfHzpMYyH57BZqXuWjtt2VERIyh4B6MXgpLvHWzTk8j3R5BDpVWDkrOmQle18isx2wrVz/8gYsseamuIC6Zc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5692
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-28_10,2024-10-28_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410280174
X-Proofpoint-GUID: oFn3wrjogqEQPkp4ydVCF21e9Z7GBNr5
X-Proofpoint-ORIG-GUID: oFn3wrjogqEQPkp4ydVCF21e9Z7GBNr5

On Mon, Oct 28, 2024 at 10:28:47PM +0100, Vlastimil Babka wrote:
> On 10/28/24 22:19, Linus Torvalds wrote:
> > On Mon, 28 Oct 2024 at 11:00, Vlastimil Babka <vbabka@suse.cz> wrote:
> >>
> >> VM_MTE_ALLOWED is also set by arm64's arch_calc_vm_flag_bits():
> >>
> >>         if (system_supports_mte() && (flags & MAP_ANONYMOUS))
> >>                 return VM_MTE_ALLOWED;
> >
> > Yeah, but that should just move into arch_validate_flags() too.
> > There's no reason why that's done in a separate place.
> >
> >                      Linus
>
> Right, and VM_DATA_DEFAULT_FLAGS is only used in do_brk_flags() which is
> also an anonymous VMA, and it doesn't perform arch_validate_flags() anyway.

Unfortunately we can't do this and have everything work entirely
consistently.

This is because, while adding a file parameter to arch_validate_flags()
lets us do this shmem check, we can't be sure MAP_ANON was set and we do
not have access to this information at the point of the
arch_validate_flags() check.

We could check file == NULL, but this then excludes the MAP_ANON |
MAP_HUGETLB case which is (probably accidentally) permitted by
arch_calc_vm_flag_bits() and for the purposes of this fix we probably just
want to keep behaviour identical.

We could alternatively check the file is shmem _or_ hugetlb but this would
amount to a change in behaviour and not sure we want to go there.

Anyway I attach a patch that does what you suggest, I actually compiled
this one (!) but don't have a system set up to test it (Mark?)

If we bring this in it should probably be a separate commit...

----8<----
From 247003cd2a4b5f4fc2dac97f5ef7e473a47f4324 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Mon, 28 Oct 2024 22:05:44 +0000
Subject: [PATCH] mm: perform MTE check within arm64 hook entirely

It doesn't make sense to have shmem explicitly check this one arch-specific
case, it is arch-specific, so the arch should handle it. We know shmem is a
case in which we want to permit MTE, so simply check for this directly.

This also fixes the issue with checking arch_validate_flags() early, which
would otherwise break mmap_region().

In order to implement this we must pass a file pointer, and additionally
update the sparc code to accept this parameter too.

We'd ideally like to have eliminated the arch_calc_vm_flag_bits() case, but
we risk inadvertently changing behaviour as we do not have mmap() flags
available at the point of the arch_validate_flags() check and a MAP_ANON |
MAP_HUGETLB case would be accepted for MTE currently, but a MAP_SHARED |
MAP_HUGETLB would not.

This is likely an oversight but we want to try to keep behaviour identical
to before in this patch.

So continue to check VM_MTE_ALLOWED which arch_calc_vm_flag_bits() sets if
MAP_ANON.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 arch/arm64/include/asm/mman.h | 18 ++++++++++++++----
 arch/sparc/include/asm/mman.h |  5 +++--
 include/linux/mman.h          |  2 +-
 mm/mmap.c                     |  4 ++--
 mm/mprotect.c                 |  2 +-
 mm/shmem.c                    |  3 ---
 6 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index 9e39217b4afb..44b7c8a1dd67 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -6,7 +6,9 @@

 #ifndef BUILD_VDSO
 #include <linux/compiler.h>
+#include <linux/fs.h>
 #include <linux/types.h>
+#include <linux/shmem_fs.h>

 static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
 	unsigned long pkey)
@@ -60,15 +62,23 @@ static inline bool arch_validate_prot(unsigned long prot,
 }
 #define arch_validate_prot(prot, addr) arch_validate_prot(prot, addr)

-static inline bool arch_validate_flags(unsigned long vm_flags)
+static inline bool arch_validate_flags(struct file *file, unsigned long vm_flags)
 {
 	if (!system_supports_mte())
 		return true;

-	/* only allow VM_MTE if VM_MTE_ALLOWED has been set previously */
-	return !(vm_flags & VM_MTE) || (vm_flags & VM_MTE_ALLOWED);
+	if (!(vm_flags & VM_MTE))
+		return true;
+
+	if (vm_flags & VM_MTE_ALLOWED)
+		return true;
+
+	if (shmem_file(file))
+		return true;
+
+	return false;
 }
-#define arch_validate_flags(vm_flags) arch_validate_flags(vm_flags)
+#define arch_validate_flags(file, vm_flags) arch_validate_flags(file, vm_flags)

 #endif /* !BUILD_VDSO */

diff --git a/arch/sparc/include/asm/mman.h b/arch/sparc/include/asm/mman.h
index af9c10c83dc5..d426e1f7c2c1 100644
--- a/arch/sparc/include/asm/mman.h
+++ b/arch/sparc/include/asm/mman.h
@@ -10,6 +10,7 @@ int sparc_mmap_check(unsigned long addr, unsigned long len);

 #ifdef CONFIG_SPARC64
 #include <asm/adi_64.h>
+#include <linux/fs.h>

 static inline void ipi_set_tstate_mcde(void *arg)
 {
@@ -54,11 +55,11 @@ static inline int sparc_validate_prot(unsigned long prot, unsigned long addr)
 	return 1;
 }

-#define arch_validate_flags(vm_flags) arch_validate_flags(vm_flags)
+#define arch_validate_flags(file, vm_flags) arch_validate_flags(file, vm_flags)
 /* arch_validate_flags() - Ensure combination of flags is valid for a
  *	VMA.
  */
-static inline bool arch_validate_flags(unsigned long vm_flags)
+static inline bool arch_validate_flags(struct file *file, unsigned long vm_flags)
 {
 	/* If ADI is being enabled on this VMA, check for ADI
 	 * capability on the platform and ensure VMA is suitable
diff --git a/include/linux/mman.h b/include/linux/mman.h
index 8ddca62d6460..82e6488026b7 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -117,7 +117,7 @@ static inline bool arch_validate_prot(unsigned long prot, unsigned long addr)
  *
  * Returns true if the VM_* flags are valid.
  */
-static inline bool arch_validate_flags(unsigned long flags)
+static inline bool arch_validate_flags(struct file *file, unsigned long flags)
 {
 	return true;
 }
diff --git a/mm/mmap.c b/mm/mmap.c
index 8462de1ee583..e06171d243ef 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1504,7 +1504,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,

 #ifdef CONFIG_SPARC64
 	/* TODO: Fix SPARC ADI! */
-	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
+	WARN_ON_ONCE(!arch_validate_flags(file, vm_flags));
 #endif

 	/* Lock the VMA since it is modified after insertion into VMA tree */
@@ -1587,7 +1587,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		return -EACCES;

 	/* Allow architectures to sanity-check the vm_flags. */
-	if (!arch_validate_flags(vm_flags))
+	if (!arch_validate_flags(file, vm_flags))
 		return -EINVAL;

 	/* Map writable and ensure this isn't a sealed memfd. */
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 6f450af3252e..c6db98b893fc 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -816,7 +816,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 		}

 		/* Allow architectures to sanity-check the new flags */
-		if (!arch_validate_flags(newflags)) {
+		if (!arch_validate_flags(vma->vm_file, newflags)) {
 			error = -EINVAL;
 			break;
 		}
diff --git a/mm/shmem.c b/mm/shmem.c
index 4ba1d00fabda..e87f5d6799a7 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2733,9 +2733,6 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 	if (ret)
 		return ret;

-	/* arm64 - allow memory tagging on RAM-based files */
-	vm_flags_set(vma, VM_MTE_ALLOWED);
-
 	file_accessed(file);
 	/* This is anonymous shared memory if it is unlinked at the time of mmap */
 	if (inode->i_nlink)
--
2.47.0

