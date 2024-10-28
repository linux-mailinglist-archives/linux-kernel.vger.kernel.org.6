Return-Path: <linux-kernel+bounces-385749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBA69B3B34
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 801341F2297F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5C31DF98C;
	Mon, 28 Oct 2024 20:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ile/H5R9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t0fZGjfs"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC93418EFC9
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 20:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730146698; cv=fail; b=CJtX+vLDhEOfXopoxzB4wdV1NK2nejHCKuWhXqwWgdA/D75JqWuVH6Tf8KXKUximIS6ClG/Z3z9OZfolQLqeF4AOOjRJODJ3zD3V00cxaCQu9iAzEad9G52QmdqlBofDkVrpjI67AiRGVO3cHRl/ih/nE8WN6Lyo+u+RQkzKYdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730146698; c=relaxed/simple;
	bh=r4jE5R/OWj5zZ94odKpc4y567US8Hb7BNXr61wdKmz4=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n/xz5uOEhZL3LQt2TYU/qBgF0ZHGveNyQEXPY2akdZmNXceo5P/V4XJf5oySajiFXS7LYw2SHIvOi6M4ReoMsvsbNtwc27js8nocWQVskL2Uk5DS4y169jFRqN4RHKDa0y08rV4nMSY8WuMTUSmp2Qo692Putf6JELgGgJRiDbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ile/H5R9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t0fZGjfs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SEtdrS020885;
	Mon, 28 Oct 2024 20:17:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=yoUm8YtmZTzUNEIgdi
	mZFa5LFGCg32E/BfAQHFdS3mA=; b=Ile/H5R903z1ej8Jq/NvEONXsE63YBodY7
	mYVWhLasqrQvjaKCa3H5Rb1jtc6Od9DCKwSwxsJsF0ylHTJl1rn/wwB5tvDeRalU
	mO8I7XCsZ6cQllTcSbD+/Wim4ppzt7ZYLm5uzcyueBy/V4zxewV2qeRRObUMgpUZ
	9fbtD/DxkhF0S3VlRnm1lAoQj4U/Sbl9Ibo3GY/AJu5dj+ErMCk/VqF0VGHZn24o
	oisvw2/gILy+vNOILhodQzB9ZM/TBVf4L1zFDcblk2YcnmW4EfYX11O3VpZJGbMo
	q3lN8cwGD0FKcIM9nmtryDAySmPYf+ZPX6OAYCA79/c1AJKiwBBw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grys3vw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 20:17:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49SKCiBR040035;
	Mon, 28 Oct 2024 20:17:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42hnan0ghw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 20:17:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wRl437mtZT1pi+L8tbzMTWrbLXL5QpyKYRV6MPaAV1XIMtiZ1jilHC0zKdHNRtgywuIpeAbhw/63UNXBbKy4TmBrFaAWAb+Arya1GcU/GtDwgfn23911uxHyz3qC6h5/sDRWJ+nxorCG0h+VawDS+ofKh0ca+eeRdZ1Fa3ChQ87TbgVfG/6zPCLaxW/uq5xZAoSStYqUAWNbk3bXALV/aARYdxYkJjmzaN0kf2i0i9f3Ir2aw3kymgPuq99TqimMdM/954cfT55pgohHmx0oz5Dlbq1G7jgC918KQx7KSPXP7FQ16YRZQ5dLBy8HsdqCk5iUocdX2WWZCOfet10AfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoUm8YtmZTzUNEIgdimZFa5LFGCg32E/BfAQHFdS3mA=;
 b=qTT2PZop1Xpr3zscFK4FrcdVGduXqZBCNb88Fq+Uc8Wpp11OY6g73tHbfySm6JLf7uvZUeHwjprii206bb9NFN1TefCo4B/5u+l7RskawuWyFE7IllcOardB/63iFfAH1qqoSqDzJq509a/5MMCOw72H00/pZEhEC+dGUsSaohdsybK83XoGYlKP9Y6Ihu8ytX67wsrxcmdjD/CkhJOLmI9S20yG8MGWJAjmmu7+IAcXTN0if1HC3A21aX5fLP9OhgcPnl+CESi73j8eYVxOqUhTUybsffAt0+S4wc+3+j54UTG4zZI72YM4QGWnJvLP5krJI3rNIKp9L0Le82p4Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoUm8YtmZTzUNEIgdimZFa5LFGCg32E/BfAQHFdS3mA=;
 b=t0fZGjfsR6UDpoS5SDccG38Pr9m/wdqnj9SWQb7qIa+XaXVCaXjZcREQnYoBUYcYMirDQU7wrofUKgvtwn+ayDBvs+Ld8k9VX71/tzNme4cG1w3hWzOiO1nJCCbC1yx4M3gfLa4WOoTsiQK1bn1qtZbYvkVvZrH5V8FavTqP+2I=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH3PR10MB7164.namprd10.prod.outlook.com (2603:10b6:610:123::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 20:17:48 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 20:17:44 +0000
Date: Mon, 28 Oct 2024 20:17:39 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Peter Xu <peterx@redhat.com>, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: [PATCH hotfix 6.12 v2 4/8] mm: resolve faulty mmap_region()
 error path behaviour
Message-ID: <bea02efe-a695-49e0-b15c-2270a82cadbf@lucifer.local>
References: <cover.1729715266.git.lorenzo.stoakes@oracle.com>
 <6e8deda970b982e1e8ffd876e3cef342c292fbb5.1729715266.git.lorenzo.stoakes@oracle.com>
 <61461dcc-e455-450d-9c01-5465003fc31c@sirena.org.uk>
 <c24a174d-c8f3-4267-87ae-cf77fa587e82@lucifer.local>
 <CAHk-=whD9MrPwPMBgVG16T_u+my8xYtZg2tUGz932HeodVX7Bg@mail.gmail.com>
 <438f50c5-8b8c-444f-ae85-10e5151f3f24@lucifer.local>
 <57mgmdx7wgfwci3yo3ggkmcnm3ujamgkwcccm77ypvmer5tegn@opiq3ceh2uvy>
 <ykzmur56ms7fm4midi6tbncjvcvf7ue4lp7e4orblrmwnefw3e@oa3enlpdrcrr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ykzmur56ms7fm4midi6tbncjvcvf7ue4lp7e4orblrmwnefw3e@oa3enlpdrcrr>
X-ClientProxiedBy: LO4P123CA0213.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::20) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH3PR10MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: 99cbed74-7556-4feb-56c6-08dcf78d950f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qsCJqJGDSiMrQCp99FWHocAvY7akDjciv2A7HxqR2eesO+myGS/fhVKJRHdW?=
 =?us-ascii?Q?ruJzNgXomXKnKjS+HBMgfnM7rw1IcIcANfArvbghAhMDm78pVtB8BKhAplRw?=
 =?us-ascii?Q?DEPh2oIAhyrWcRJMir1UnGXT6+X1cZpZcrUJG3uNxz6+NOsd1aGAZmLXYbfJ?=
 =?us-ascii?Q?gMvR0OCDcsQgD6jYaWE9dWwmWQqSNhRvcK32ya4v/t0b62GCHZt3DERQIswv?=
 =?us-ascii?Q?3AIDcNpmGjL1KwAQwGDTMTp+2XjxBrVXkAYT20STJrZe9A314HKsbK6P5ala?=
 =?us-ascii?Q?hXybhMXzVsQ/aBdO+4xYzlX016XtPE3r6l0xnbkeVSY1LlOCOVg35qnyDfCE?=
 =?us-ascii?Q?vpedom+rBlyeF1Bnjq8C7gqzrq5WbIhKJhA5wby6avdccvu/hHWyVhzh/AJf?=
 =?us-ascii?Q?c/8df59huxZhDpiaBCIyNR60KK8kAvbP9m9ZihUa0tkprZLk98Os61VMIJ2U?=
 =?us-ascii?Q?SY/aHJjPomLMSh0mY7GNQkhkeB1CnA4LRaZO5q14NMS1ESoeCbhTh0DKcggn?=
 =?us-ascii?Q?MkHaAwNOBNWZRlHooYH4JnXxkaWHJk5e688Ll7xINCnVYAxkEbYul+QGKhVQ?=
 =?us-ascii?Q?OMvQPgpcx1lH7MMwgcK7YOnU76eQMYpg0XEk+qOk2YN10wfiRGiU6EQ5oksn?=
 =?us-ascii?Q?KJ6I7RfcbP4WbVi8G5wDM6ldsbemPpd0MdNEcKpyMOOe1zG1rlET2e15f3cF?=
 =?us-ascii?Q?k3+Vhsku1n3P4Nn1LQGWb6E41wgDcbQCGXQAHsdbP9J8FMVU458B71DICN8W?=
 =?us-ascii?Q?U0aoJi8yw7lauC+3trESJR0Zz8zz7vZ+9jwbcJIKRk3XSAFXrJvuUtcrjrGA?=
 =?us-ascii?Q?j2li6ippprlj0QxEweVFVGEbY66v/PWnmpuDo+JhYdBT1RhgQsibcpZTjHND?=
 =?us-ascii?Q?EZ1abQIZKq0iiN/lcGGnomvqExMbG+NnFjSCU759sYXHdoeLnJdsoCb8PR6Y?=
 =?us-ascii?Q?kE9W4aetqxZoxCiay8L2yMyJslAfr13aKp7L4oQovX56aR0M5yDbspp5NJU3?=
 =?us-ascii?Q?Xm5doZq9laDOCsKsZzdDvUtBgj2M3LPHxtw4AK3YwBP7IobF8gLqxFAHwqCt?=
 =?us-ascii?Q?58xQx3p57geXXNZdgm42inSsWogtDbR2ZD9Gn2SGMBJ3mpBFcukfog8zRyeY?=
 =?us-ascii?Q?BLYD19VYAvaapseY3XdAl84FbCoo/jaen2O1oxw/DDWc3HOD/65S67q796MV?=
 =?us-ascii?Q?jX4Yo3ofpYRlvT2cSgmiajqn/6/0GRQ072xqwTKUGymzdKRuu546fc3tsfq3?=
 =?us-ascii?Q?mk6PiFCT6kEeAPWDUQG1QGM8FZesgoxGDsYkT99tsaP3QvDbr2AhRGXoW2vH?=
 =?us-ascii?Q?3MIDyhhMteooN1xKZhyF4W4UVtVTyCSvLr3UOdGT4u/30cdDbD3CNIVFcxQA?=
 =?us-ascii?Q?Ay7BmME=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZZJ3mzgnvzC3m9bg2C4+xyaEyJHz95XEiP3rKH5UdD/jwN8Ix9oeES358Ewe?=
 =?us-ascii?Q?h367msndReqiRZLOo21ztLv0mpjq1/iAI4CaTpxI/yihpksjEyCqZvxu5B4G?=
 =?us-ascii?Q?Hicj+QFp6hWogMyLAPqtk2aoPAzxkJlJmQFPiUjmbj87bMWqVlyi8QY2iHiR?=
 =?us-ascii?Q?AnAJXmB/2xWeDZyIp93sSaXK4kjlKoYPCOr91qFYajtCeXTW25PhShJbMb7i?=
 =?us-ascii?Q?PC60WyMBrgAV2s/uYHM8lKYXW9qglO3gWzbhZOsjqDUkYw4YnllVKaa32MVc?=
 =?us-ascii?Q?dMgRCNZszxnRVaEHD7upyzmdMsuq0YG47Kqf8VEao0vmD1g/sJpxiWK/dQ3h?=
 =?us-ascii?Q?jrDPvUT1TvvibcR0v/lYBHh7ZS+6IRMoKoso6UooJE2rvP/KQKPV43y69W3E?=
 =?us-ascii?Q?0pEaD+INvxIH1Dyvl//DlHaox9bPLAHm/0ARWD0FdkwriaVrQRGk4lrUaSt8?=
 =?us-ascii?Q?POBJnlfqBZo8kXnB0CwalmaypAt89fquJ47EaQ8nO43MY8CWnV++jC3ZHy08?=
 =?us-ascii?Q?KOdzqpEDtvyypMsxpBywPFeLB9f68E8Ce/3mrhMw35+MNVBnCydZnz513skw?=
 =?us-ascii?Q?eui533PeyEDgp/PzHbJz50nsB82MvQAUmHISrg+TIwjuyBwznJKRNEm/Ogfi?=
 =?us-ascii?Q?p766IjsJGYlAlgzZocWYyLPiXs1UOPqQgZRDwiIqeKK0oQ2lqVkfp9cEma6w?=
 =?us-ascii?Q?pYXOtWapxwL5+c6V7PmQ06sm4I/2E4IZoi7ZXeSsLsHXhfDN8Bi7237RAYHv?=
 =?us-ascii?Q?pIMcmSthA0YF/SVdt9WBwjGBMamZ8xbGLpxqHWpZszJB2Ev/kCzZnMCMk/yf?=
 =?us-ascii?Q?6IZms5uCktOj8bsHInDEh4M2C2zVGgwHiuVARWRDi7f5hSrdMmiMyip0v5pJ?=
 =?us-ascii?Q?G3hBOcHK6oNavawkLdB1j+ZrhnCoOxUF8sslCAIs1t5RczrOlQAzK/uKgsnv?=
 =?us-ascii?Q?ED7u70qPZ/xsa9ZeCUzR5MjuzrJDELcpubZFoH94SBKEBWVAMVdmxBunjiE4?=
 =?us-ascii?Q?vqvtPuWs7GVz29XGM/FbEt5/r29rnPPvTgsj0OSwpc5gAIYi3n2y6DrfGYrh?=
 =?us-ascii?Q?dG00UQntTEmBsSaSxhc5GeZd6vEJVsxzRrMbTVJFSWbUNyFKoWPorJBYlsaQ?=
 =?us-ascii?Q?oEQUQDTv4UjwXJSFztS9uBXyMP9FYYpbHTcMM4XzaIIGt3pNWe9lGv42ZR0J?=
 =?us-ascii?Q?tLOahjrHonNv6BWEeElDQFP3+1opCL1S/Rn71c8WtSU4O9XFk4Dw3oe4iNz7?=
 =?us-ascii?Q?kOfJMAYHdvP0xk+rOlQApM1lP0rVMUa4ckeSWSl6j/j673FlXSuV2ltA/VUG?=
 =?us-ascii?Q?z8DGKojIV41arb8rdAvS03ipcm4Bp2msYnyFRddENwfgMEbrERVrx6Jx3cd9?=
 =?us-ascii?Q?i6v6MZiI61tSahjZ3bgOIl0wusP38B9GZ73VpUtEW7w4h/7GgnemQL+0jZFn?=
 =?us-ascii?Q?YAU/XpFIg/uG1APh+fvpwjbmFjUy5B5OVicwaLEV6Py/NEVtRza7ZRpmFZe8?=
 =?us-ascii?Q?u8wKBQvLIB6wsivF91HUtNbrD8ct33oIv/Fzl2EA5PqAfWfgDeWUbOnG8SWB?=
 =?us-ascii?Q?lGhREUJuTV/zwNhCrm0FKV6BWoB/ptAkmCx5Tt22zDn7Na0IBR5yb2otaAwu?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HRp4X38x9s09kV+U6JCRObFo9KdAX5QfehWzvHYmBhlbQzVTZ0p1t1divssvz6okWUr2B+hcEWj0qXqvyP+d1yJ1cRGaMlIDSB8nLulnNnsiqBl9T2svOjmAQmUnXdPT+/IXMFuuG2WddbQQMUlKnALmGB7XvPsIienXCa+zCb7UVdrlJ5YxRbYiCgmA8R7mVDfHceAFfpL3lFhTMNP8Kwozkoe1adhgrED6aIX0U6HPNZ9bL9C2N/nAoJcqoMrzi+5zXGTAUHcan8kHVVZuz1VVSjYxWE/7VoqBqaKQFdoDYAuspuxzn3+DqQIjoTi34xOQmsmcwLLPvyDeCirSu3oxnxfSM3WUgo8BQoG+64WbOzjMS+0ZPWO/e5KncyDIYWj3kBeQgqj824hVvlRakHukB75cSLonbvFiMtC9LxCT3vU0YIyqUyN1+i3MkAUtvRRid+Nqb/W3NonhtpMlxYIhOjP2YII1WQQ1oi0w5ViGsRPKpdC7ZHdfXBDpp/IWXOE24chaFnbZxDg+30onQF9FLjSgdY2l2oayuKjxPlsyaloI/C1eeNbrHaWbKfuv0rJnNwoKussjIqBCpQkCiwcgABs0KdmEHKtl9iBD3YM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99cbed74-7556-4feb-56c6-08dcf78d950f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 20:17:44.5562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVuOdKYqz0hiHQ1mGYmF21M6uJ9d8z45kYXS5Rh7wxG+ls3FgxZ+w37cJnpC7arBZ1z76duylve0La3iLTiTnfA9RQz3slbzfF2+9oNI3qg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-28_09,2024-10-28_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410280157
X-Proofpoint-ORIG-GUID: ZEVfy20TIX5XOapIl_xkn9l266RCDxXP
X-Proofpoint-GUID: ZEVfy20TIX5XOapIl_xkn9l266RCDxXP

On Mon, Oct 28, 2024 at 04:00:29PM -0400, Liam R. Howlett wrote:
> * Liam R. Howlett <Liam.Howlett@oracle.com> [241028 15:50]:
> > * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241028 15:14]:
> > > On Mon, Oct 28, 2024 at 09:05:44AM -1000, Linus Torvalds wrote:
> > > > On Mon, 28 Oct 2024 at 08:57, Lorenzo Stoakes
> > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > >
> > > > > So likely hook on your mapping changes flags to set VM_MTE | VM_MTE_ALLOWED and
> > > > > expects this to be checked after (ugh).
> > > >
> > > > Gaah. Yes. mm/shmem.c: shmem_mmap() does
> > > >
> > > >         /* arm64 - allow memory tagging on RAM-based files */
> > > >         vm_flags_set(vma, VM_MTE_ALLOWED);
> > > >
> > > > and while I found the equivalent hack for the VM_SPARC_ADI case, I
> > > > hadn't noticed that MTE thing.
> > > >
> > > > How very annoying.
> > > >
> > > > So the arch_validate_flags() case does need to be done after the ->mmap() call.
> > > >
> > > > How about just finalizing everything, and then doing a regular
> > > > munmap() afterwards and returning an error (all still holding the mmap
> > > > semaphore, of course).
> > > >
> > > > That still avoids the whole "partially completed mmap" case.
> > > >
> > > >              Linus
> > >
> > > Yeah I was thinking the same... just bite the bullet, go through the whole damn
> > > process and revert if arch_validate_flags() chokes. It also removes the ugly
> > > #ifdef CONFIG_SPARC64 hack...
> > >
> > > This will litearlly only be applicable for these two cases and (hopefully) most
> > > of the time you'd not fail it.
> > >
> > > I mean by then it'll be added into the rmap and such but nothing will be
> > > populated yet and we shouldn't be able to fault as vma_start_write() should have
> > > incremented the vma lock seqnum.
> > >
> > > Any issues from the RCU visibility stuff Liam?
> >
> > It is probably fine?  We would see a mapping appear then disappear.
> > We'd have a (benign) race with rmap for truncating the PTEs (but it's
> > safe).  Page faults would be stopped though.
> >
> > Unfortunately, we'd have to write to the vma tree so that we could...
> > write to the vma tree.  We'd have to somehow ensure munmap() is done
> > with a gfp flag to ensure no failures as well...
> >
> > Maybe we should just call close on the vma again (and do whatever
> > call_mmap() needs to undo)?
>
> I take it back, that won't work.
>
> >
> > >
> > > Any security problems Jann...?
> > >
> > > It'd suck to have to bring back a partial complete case. Though I do note we
> > > handle errors from mmap_file() ok so we could still potentially handle that
> > > there, but would sort of semi-undo some of the point of the series.

I'm genuinely not opposed to a horrible, awful:

#ifdef CONFIG_ARM64
	if (file && file->f_ops == shmem_file_operations)
		vm_flags |= VM_MTE_ALLOWED;
#endif

Early in the operation prior to the arch_validate_flags() check.

Just to get this over the finish line (original idea credit to Vlastimil, insane
ugliness credit to me).

Could be in a __arch_workarounds() type function heavily commented...

I mean this is pretty gross but...

