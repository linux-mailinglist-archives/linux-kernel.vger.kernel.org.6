Return-Path: <linux-kernel+bounces-218299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFC890BC3B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7716C1C22DFF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567A3191465;
	Mon, 17 Jun 2024 20:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NWnms/lS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nECbFY+D"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CCC16A94F;
	Mon, 17 Jun 2024 20:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718656490; cv=fail; b=mKrAnIDLAPlcKPUhgw0fFNP+5zE1Ih0pG0936xx7KjVH/ohMPHtIOAiSUQ20vF9p6k4Sxx0qemlds7DuoESR3qfuNpbdz/aKnr27HR3JLlTxe1mi1yHJA8wEG2qKIyiVanCn3wQz+V0cBcBqqBMx1RbIQPXNg+5bsPskd7bdlms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718656490; c=relaxed/simple;
	bh=q68/BpNM2i0aJzMK4H6ieACd0iV/24PgF53BGDy9C74=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=K5nNqs7j+UyQ37u6a4bioJZ+WFHpAQA2Kf6a7fWFa/bO2j/eSizoabixQDvb/PQFiClgvppQOz8zWoI2MP8m+xrBU7uFOYRxUWHQ4sy2liIs8PwNGLcwlw9dUTRIZkIMDotzE2wu/wbUAE/NeGD4KCpK5bU3eVRqPeKAGil4x58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NWnms/lS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nECbFY+D; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HItS10011207;
	Mon, 17 Jun 2024 20:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:in-reply-to:references:date:message-id
	:content-type:mime-version; s=corp-2023-11-20; bh=6S64lzoaQOe73Q
	536Iwz3yHjbMJlH1Fy/0OuhPP9aoU=; b=NWnms/lSdOrmS2XQhCBzOblFTzUKN/
	eaTk0mPwWqJqS/ZXpAzLNncx1aMFrc1xoBYO0o8WdgE/S3cnnhNJYBlJKe/PPkFM
	Tls3xhMxd0f6anJtljXoFD7koSdb/n6CzmUGK+eOsjf6CCmwz6EW7hrgoZCLByqS
	yXKvpKpDvY7PHHZ6loWOl334fwTuP7dupVTtA0Ebt6GJ/oKjst6YRyoJhphnxa5F
	kgSLG0TiZUs4LEBh0juZay23MPqJQuwGN78V0q+DmgwjVYci7x1VOzQw9DCm2GnL
	qGTSAkc1oU6nM1fJ73Yyi1/mNtZQ8qiG8PFUIojH/seLx2m2XmuIgl/w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys1vebmpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 20:34:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45HKM2U8030635;
	Mon, 17 Jun 2024 20:34:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d6ybgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 20:34:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNWxZfeGsopQP/dgeK38wa+A7jqGlQm4WOGyU87Tg5d9huLiDQjHUYpiGMd6r8NZBT73EB4566l698kFWMM9IP4E2fPQrp15lAtnvYd2Lh4UwrayO6rsGHfZRXnxgHDLC0tm/PLIf5dqRR1dLqZ6nBkabF8SwHtKvhPWY+5Fg8ZZsm4JTX8k7DaBZf8zeF9enO6uggCESyCfvmnwTWMUlz3cUxL59uklrHi7qjV5o308PDkiBo2eIYFPIlY6U7IhtUnpEPDzD2ko80SCWl5tiXem5vcAh06hPMtI+9I5+LFkGM3yE0CpTLhbluz5vS05RCogwvHIKPxMUZme1b0sfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6S64lzoaQOe73Q536Iwz3yHjbMJlH1Fy/0OuhPP9aoU=;
 b=PNcm133HYJlUh61RQOYdvhm17XzKtx38UgyI87S3hOBquxEpm2XnUU+4XuXjMRBk79VXVq92XzVEGmsmlYzvg4qP7ChWcspfDl3tCNfnMKPoY0HuTpTB651e5WHwEVYNkxxCZSh1nCc5jV5556vWe8Ierearfb3Ws/sQENp3lPmCiP/Qmd1x3xWHF83Wo7017EnTjudjOyUWZH7Jfx3UB1wjotnfhAB0kknLYC+tmxAdZWLnntoLsSRMk5+8tKdyhviLKdXeo3OMb+BxoGMtFbDAqmMyRo3bs5rJ4rZNeYWoqvrnw+S7ju5ljb4gzzyDq2zhSC+hj4ZSw7vldfG2Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6S64lzoaQOe73Q536Iwz3yHjbMJlH1Fy/0OuhPP9aoU=;
 b=nECbFY+DIIUAgROyaS+PsBS7ikwPLKZn6muFd/hTWcD2nolRkH28HhWi3y82HUM/zQGyMTgas7ApjwRVQ5MF2mODc/WJfDdw1MsA5qafoMBxnIXH3KSV60g3gjKzO+BcCB+JK8/aecwcS4Fs1YH//C/f8aqywo0hzclS5Lfbwvg=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by CO1PR10MB4737.namprd10.prod.outlook.com (2603:10b6:303:91::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 20:34:23 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 20:34:22 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
        "Vishal Moola
 (Oracle)" <vishal.moola@gmail.com>,
        Omar Sandoval <osandov@osandov.com>,
        David Hildenbrand <david@redhat.com>,
        "Matthew Wilcox (Oracle)"
 <willy@infradead.org>,
        Hao Ge <gehao@kylinos.cn>, linux-debuggers@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm: convert page type macros to enum
In-Reply-To: <87ikygo1yb.fsf@oracle.com>
References: <20240607202954.1198180-1-stephen.s.brennan@oracle.com>
 <20240607212738.bf55318aebd7172fadaa11c5@linux-foundation.org>
 <87ikygo1yb.fsf@oracle.com>
Date: Mon, 17 Jun 2024 13:34:21 -0700
Message-ID: <87bk3z1f76.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0033.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::46) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|CO1PR10MB4737:EE_
X-MS-Office365-Filtering-Correlation-Id: d6756c8e-82ec-493f-c6dc-08dc8f0cdf30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|7416011|1800799021|376011;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?bYLbBLHx54hY/nYQulnEGyobblSsnyJvphNfQ2q8ubgDD/eAmu5bUY5RCS0l?=
 =?us-ascii?Q?x2t7EdBy3fvmApgwTvZjbIPH1JAKWhKbY3oPPrUn0tlhUbXrzrpQEvwdqEKW?=
 =?us-ascii?Q?JPAcv88I1RchOzWrCs7d+Z1r7H9yrpwvKilstMcYTDTBrh8Eu2R1Bm23bGHc?=
 =?us-ascii?Q?+M+Vc6O2fE3zyAMI2hTlEjeY1WX4Pm0rN3NhalKUy0Jc5ZIsY61ZShdk0kyU?=
 =?us-ascii?Q?u0fpqECmPIMXglpD22qTxFQHHPs20EomiLpzNQyn3yo8mgXTibDXlniWmR5P?=
 =?us-ascii?Q?1y7wa7B1dt+yCILiZEhB2quOAVF7+lA4aJi3lQE9nxDZVyBAFu4IPN9wg/rs?=
 =?us-ascii?Q?GR3PzgcpjKOYHXYz09Vgj8RpXy5Rk5nHSArtLvV2EXJvTxtlTJpB6f6e0Sr/?=
 =?us-ascii?Q?xs033uvfyF+qs1xRff/id1S14pV9o1JPlfhJ+9cH6XLBh+gzdqqAHMfBpYvd?=
 =?us-ascii?Q?oX5f8bShITLoOGoenblTmhiQEG+pWmjncKP1wxQ0IOQShBNNaQsY7RyG9zBN?=
 =?us-ascii?Q?gfmqpLAYEDtYkwlxaVXT3MI90oUDhbTrbau5g9NzwF984q2nunm2+dBJX6J8?=
 =?us-ascii?Q?EuageUtaYOTfxEUy956DnVSFNPnIAKlKUGEWwArtJaMO5K1U442Vh9vpd/j9?=
 =?us-ascii?Q?aUTFBMXZEVcLJ9PzB6Kwj7uNHERCWOL1l+rF9PnzS+hg3KKH9nCbpfYuQ3Gf?=
 =?us-ascii?Q?WyLfFvwjBqQn6+5oP4jEeHgb27aBha79FgQGvELApP7ElKRO/2NEjPUA5a2v?=
 =?us-ascii?Q?+VXCSK7T91xGzf0Jow/nnGKyxybAQkAvMUl7+WXTcFQbkGwpIibtEY/avUdU?=
 =?us-ascii?Q?VvIXF3iFSGwJfItsjywIDv8y+SB6BZ6P6MMOjqhmoq8VFkaOBrRtWN3ZWVF2?=
 =?us-ascii?Q?A9xoBeaeJWxmqnzYKvZiQAkslAxaUUbueYoTsC/N4+VULHZMDJvqphe0RwdN?=
 =?us-ascii?Q?ZVLG85A8P0M85JjCfb22QX4ga7D+Vv4DxQmqUV2C/dnlAEDiZqgMcbUUK0+v?=
 =?us-ascii?Q?tyMZDAYnEuSe0DEH5ANlgKGxYTWSWtPGJ5Tp25oOLjPBH97HxomiIIflmB0w?=
 =?us-ascii?Q?bibPiU7K165fDgQfe1opcjaaczwevl2zUONaiG+Ih/KDGa4+bHJBQgKuKudB?=
 =?us-ascii?Q?78f1oUO7LcKiU1XZ0dG7ITL0QVOElUXBAdzMDtWbOGl//PYBQRQ2dnCZRlCf?=
 =?us-ascii?Q?t3ofOmCDlhEI/hKgZShH/HhuzfkPD7nGAkU4sGv9LPfgPdamq6ONrYSR7OGl?=
 =?us-ascii?Q?JF6CubioWA3u/9H0dBqmWuMVfuZ95e4yzHQPtgLNNyYe7jMW3SzFE72XiL/g?=
 =?us-ascii?Q?lOHpL3/tqRg9s8NAobpTVce8?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(1800799021)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qr8ghHjeqXiWJaveNnN5pRimQ8jModTkjCCCHbtyQzf/lSSsOqyg/UqTC/qh?=
 =?us-ascii?Q?ov8g4StwxOOCXxJo73u8gTWEVxDdVJUop3ZAUmh3ofTwdHzn0I4YMLBues9y?=
 =?us-ascii?Q?+meRCZMSFoGrZO4YIdS+O990JIRq6O8o6vgt4b/+Lr7kiZVeruDYQdgB8853?=
 =?us-ascii?Q?9UuzuV/TDJY6YWpKfkFv0JuHmTjIK5hsLeW/uMb61nTx3R34Czl9/BJJKUBV?=
 =?us-ascii?Q?HZ+FjZ6PmEI0ZE7gNMT8HT+qiYn+BaUlBFGzucrVFK5dsxxXDtn/mWXG5Pcw?=
 =?us-ascii?Q?CC3GQO0roiU/88b/PSlXlvorFnacsPn7mlEw12ehyR8xUREtGIWcnYI06w6k?=
 =?us-ascii?Q?0IEEapBWH9yj3or1rOfECoGAFN8kxGeBQMNKvEoQxJ7azlU2G5zvct236p6+?=
 =?us-ascii?Q?f4x6klxsgSG7jNGT6AHOYhGycpuLhFrX8a/lcfC61qNT2ebRGS2+FMDqBFvY?=
 =?us-ascii?Q?FNbxhw1egFIZAGbSM/82RZDC/JW30OaaiZDmRi3Y9A8pQxBqbBDMuNL/MA5G?=
 =?us-ascii?Q?fTGixw6BAbIIXYVZRiHMKszednTkYr0nn8769FYrO9oIde3z2LCVsLlywgnj?=
 =?us-ascii?Q?8b8CUtA1+xmVs4512oMObOibP9/S8tpqPci1wri8/EMbW5F4P+i4AjQeDqvV?=
 =?us-ascii?Q?DkmfIuYLu/PF9r0/xzwBKBK0QLLVZle86Udw9JcWExDjO4zA/2602D+zOQ7+?=
 =?us-ascii?Q?xLM5KoBgCtDyG+Z14LQ2fi/NHJUZyjnm/zRmNCI7XFvBpy2lJX24yiXwmxa0?=
 =?us-ascii?Q?VuCNeezIHDxCzwbIzRViutJa2XLBUYMOULmm5wfBGt2JySq0n9lQ2j8IXXIE?=
 =?us-ascii?Q?1ckVsyo/pvs86EBCNlIfvkPI3qQddE2MJ5txP0fZwAi4nPMGySWcmcdJG4HB?=
 =?us-ascii?Q?6IaN736J4bNBtJ9FnHn33ZLJncyJjEF8v2eI4kDUFYgKGyynBDB+wfcZW7/X?=
 =?us-ascii?Q?N2vNASBEE3lMtROKAjJqhFARH4VVh9gf5wlo1B++xTvOn+qt9h5pG9GawDMw?=
 =?us-ascii?Q?ectPDW4rE5HE9wlp94d4WtaQVrnoBd/IRqPo3pj+5Q+ReIuLx5rjpREYrwPn?=
 =?us-ascii?Q?PHYWrxCJaeSXJ25jGn1XCSDVep3RjWbqbd3Rrq8PoaUs/1XYerkf+pp1ffEc?=
 =?us-ascii?Q?z6J50pIiIsLk1M+mIJlA0PWgCSESkvIrASMpyoOthHgBoL2lxhoo/vFeiwF4?=
 =?us-ascii?Q?FXob4T0cKLNR7sYR4wBS8b2zEgdGGV2Z+LvyZ8xN8KBm/r6Xe7TQx/+HDSSV?=
 =?us-ascii?Q?VtSEnApNshhahWDaJ1zVX+6WZ1GmvBNQA9nIveAkvX+sZJePMki+RUR45WRj?=
 =?us-ascii?Q?5zGKrgCEy0T91IT65Yg9f3o+mZtZtPQubAzS7jhnlAjoE1+MtEHijxfcWbEf?=
 =?us-ascii?Q?cAN/JTSO+ZYnSGNUl0Hi4K2D9ISX8O8/Lheakik335X+td8GBhewSbz0snTH?=
 =?us-ascii?Q?MPOcVnn451YyAiNuTdqx7kTGefCmQliSp7XkwgEgXHfTMBE+RFtB8n5nx3rX?=
 =?us-ascii?Q?CTmGb86MmTYaIxRDCkRX1OhseJGJJmoe0Odn+RDKgiUezcKhhVCRYpxs9Dgp?=
 =?us-ascii?Q?UkmU+yxTwQ+bV/iuKz7lBiyYGqntVsW5ducb/5dGXdkg4psLBQWRuBn4FUjq?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PmagP4ESqhZb+rLMVbsPZItNbdgIxmhleti4wKPGE/WtJ/YtGFVwFgV/RCBotcrv1gmvX32WyGQ+F51psbLpaKExZ5DL3gsN8ZCbs68fgb4GGUjTvOJl6iTlROy64VI0JwP2gWM7nTKul9leUKe90bCn1o1FRFllSgeQMO71wINSB8vZaRb8Rx5UuI0PhTQ9UMxVnNjeZyQ3+FTwDshp4CxRwdatVG+UZAikXnh5LqFwQXBxVUW5jPl8KWYbuGLwtv2in+R8NJYsLTfhh99LuJt+5Q7F/oza6boqmaifZGsvxu9MyrwAQ0qaWzscn8ZQMp3H9PjTWvQBvrq7qxyjPR7dr1sjok+GhOWzCV6JJJccwOCN3pD5Sf0zJs9c1xAHUdPFT4fT+OP66c+CFOHZLn0nOU2Kylnk2sy87GJVLsRqSfta/n27j9djuuVQQHGC/YauMqftGsawJ2yE3XZEKsoDjEXUxvJc4Cvyc2+1Nq3kIYAWMLb4rLCOEICk36Ph+xoF17DFUfcBcO95pCmqjwxkt3ymuODT7l2COuCFLUu1ZIKC658uWCv+PEiLd002Y0FkbORO1YMBt8ItSB46UbNRmhgFS3KoOe37u3I7j8Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6756c8e-82ec-493f-c6dc-08dc8f0cdf30
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 20:34:22.9237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YNi/lvx/U+g6He1ZdCm0sUl4UVhTS56GvXzmt1x6wNmx+lBy15imuPca0OrBlP9XbLghnzHszk5aqbNiGRTZi9jEHuSQ6P0qkJRw3uEYV4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4737
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406170159
X-Proofpoint-ORIG-GUID: 7SlFUdmGkTGkBeyApmtwO0tmY-QLP3Yo
X-Proofpoint-GUID: 7SlFUdmGkTGkBeyApmtwO0tmY-QLP3Yo

Stephen Brennan <stephen.s.brennan@oracle.com> writes:
> Andrew Morton <akpm@linux-foundation.org> writes:
>
>> On Fri,  7 Jun 2024 13:29:53 -0700 Stephen Brennan <stephen.s.brennan@oracle.com> wrote:
>>
>>> Changing PG_slab from a page flag to a page type in commit 46df8e73a4a3
>>> ("mm: free up PG_slab") in has the unintended consequence of removing
>>> the PG_slab constant from kernel debuginfo. The commit does add the
>>> value to the vmcoreinfo note, which allows debuggers to find the value
>>> without hardcoding it. However it's most flexible to continue
>>> representing the constant with an enum. To that end, convert the page
>>> type fields into an enum. Debuggers will now be able to detect that
>>> PG_slab's type has changed from enum pageflags to enum pagetype.
>>> 
>>> Fixes: 46df8e73a4a3 ("mm: free up PG_slab")
>>
>> Should we backport this into 6.9.x?
>
> Hi Andrew,
>
> Looks like commit 46df8e73a4a3 ("mm: free up PG_slab") is introduced in
> the v6.10-rc's, and not backported to 6.9. So PG_slab is still part of

Hi Andrew,

I saw that you've merged this into mm-unstable, thank you!

Since 46df8e73a4a3 ("mm: free up PG_slab") is part of the current 6.10
RC, it would be great if this patch could be part of the 6.10 release so
we don't release a kernel missing the PG_slab info.

Can you confirm if mm-unstable will get merged in this release cycle? Or
else, would it be possible to include it in a branch that will?

Thanks,
Stephen

> enum pageflags in 6.9. From the perspective of the issue which motivated
> this patch, there's no reason to backport.
>
> Backporting could make the other enum pagetype constants available in
> 6.9, but I'm not sure there are any users who would care for that. I'd
> say there's no need.
>
> Thanks,
> Stephen

