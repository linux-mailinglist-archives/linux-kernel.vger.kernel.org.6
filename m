Return-Path: <linux-kernel+bounces-403888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCAD9C3C4A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788901F22403
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D685D1990B3;
	Mon, 11 Nov 2024 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ltavtMx2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c9O6cWKl"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94E319AA6B;
	Mon, 11 Nov 2024 10:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321646; cv=fail; b=f9rpJVF0vFwu/pxsMmA9obIld2D7DWzQAarc0eC6fEJ7Pfu6t7S+jl5rSOzUvi9ywLUNKFfWBI5B7f7EjBsqGeed5ryFZr1Dz7ZCDYObEp8tpm8JStbgd/kAACWcNLgG2eAoWGsEpGycaebHHW+NVV8FfRDftY6hiuMcMH8rLCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321646; c=relaxed/simple;
	bh=c/NAi4Wm58pEPCC/JbVj//U3vEdNPOl1U9F0yGQbREg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tEWCwCHIQhPXovjrrzn7E9nD/sBOuxLf1c+jF44ugxXVvHnyK/LFX9VUXGmdVRQccaKAb39N7wMcucv1Ce6vQtixJ83EAzUjy2E7pDT157jFYiVE+HIDczlImGIxk/LYqfTXrMyxk+I9MBj+fMcQABNchDwfwK7XZVcb1jQfD+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ltavtMx2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c9O6cWKl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AB9soaW028857;
	Mon, 11 Nov 2024 10:40:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=sKcQjFMaruPopFLB/w
	qz51bC6SrvxAy6b/biVwcRhCw=; b=ltavtMx2byYewlCah3on4JNiHasogImrY0
	WXXfY4Am3NmPFmysOqkS15U3Gpb31gxmXa3BRo/Xv79OJwx+BPBtPOcHvqQqkI8b
	QRD1EOLhEQhHIo77tyXMo7kk6AI/Vl0ZVE8gQBjWc7FqEHFdiOZE0IO+QIHJvpJ0
	3FjcnW+1OD8/uCrF1N8Xp9YrbsOTiCu/rhxY5aeg2seoqpootfMik/x9utTqSCv2
	mLA6HG1vht0RCNYPWS2l1BGAIXS8HiKFQ4gqYK+ZwRHpdKNSKAxHIPj7rCH1kkiO
	n4/9EkNNSDFxS5JgrktaDFqIqPEKhFh2Zt4ixrUOfjSXkcTPJo4A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0mba5hr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 10:40:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABASaP4021555;
	Mon, 11 Nov 2024 10:40:08 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx66n2w6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 10:40:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THE+4ja463RLlolIaWGE1FpgLQl1hyrDI/mNBfNfCQPShZapxK7XfvhkkeqH6aNNNpEPEuX+nSgUEEcszhe2CCQrX56uPBUetkdKZvNBWhESzzXB0XrM79gnoDVcFWOnGGhVeLEpV6YP8MpCHBe/CxRh02SkUm0YEO+4XhVdKDeG5DA1fsuGKQ4BlEuzFnA+3AxNByZ+RXOQKLSpl9QikhfdP7QxsrdUrDkgxz+4dfDcktHQE1A+XXamqkp+8rxlGNZQDqaBcH/PAeXK+TtenFEkxepAwSkHyytjPsW1o+o4EA6wW36jBgVz1iSvL7gLf43eGZWnCcCU2suP3OaK9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKcQjFMaruPopFLB/wqz51bC6SrvxAy6b/biVwcRhCw=;
 b=HDXiOCVXStMGY437WHeW/LGMzEURo0g05b8q1VNXG9jDVUBvx6HX4DzmmVl2iCDQ+UjoGOOv6fSq5N7AYUoYwfDWYD03puEb8BabkVGRb5+a1AWtS/EBUEQHRGpnZHvy94bZeFP4nS3Gm72vdMIVnP/vE5IKEu3hQTT502Aw4S8ctTHhF5C6MO0NrBkbO95/T6cdhambzJpEypi3EPdjcrWZstW5Iy0VylL/c8EBfoEUXLZx/psvUIjFvNNTIRvBlJmopOx93gy3tgqfQe1z1HYoQNW5MZqLha6o6U/LCOD4b6nX7j6JrWBzAA/YriCcBUhQTiO0pa1chmoTyPy0Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKcQjFMaruPopFLB/wqz51bC6SrvxAy6b/biVwcRhCw=;
 b=c9O6cWKlYb4/HDKYM6qRmq8wemP8bGDV51LY+qv8mq4TsSc8TGoG8mayKepVqHGsqHI2pWIlxAPTGTzDHEOLUAa0m35sTxBK1OBwmo8let7VTVeiidSHuSxx9Q3IkEDtJxRMUhAgY3wUJOJ/ffJVVJlx3PhZE/EdG14ftC8VwGo=
Received: from MN2PR10MB3374.namprd10.prod.outlook.com (2603:10b6:208:12b::29)
 by MN2PR10MB4206.namprd10.prod.outlook.com (2603:10b6:208:1df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 10:40:04 +0000
Received: from MN2PR10MB3374.namprd10.prod.outlook.com
 ([fe80::eab5:3c8c:1b35:4348]) by MN2PR10MB3374.namprd10.prod.outlook.com
 ([fe80::eab5:3c8c:1b35:4348%3]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 10:40:04 +0000
Date: Mon, 11 Nov 2024 10:39:57 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Hillf Danton <hdanton@sina.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH] docs/mm: add VMA locks documentation
Message-ID: <e49519cf-aa58-4241-b362-4c16595560c1@lucifer.local>
References: <20241107190137.58000-1-lorenzo.stoakes@oracle.com>
 <20241111070719.bsgqz4yzxfrruuup@master>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111070719.bsgqz4yzxfrruuup@master>
X-ClientProxiedBy: LO2P265CA0432.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::36) To MN2PR10MB3374.namprd10.prod.outlook.com
 (2603:10b6:208:12b::29)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB3374:EE_|MN2PR10MB4206:EE_
X-MS-Office365-Filtering-Correlation-Id: 46db44ae-f2bc-47e0-a8d8-08dd023d33dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kaYooJNCGtqqDLqVhxxqnaY1tz753vMiKDTcnD34DObJrrX/HzfzM9FB8CF2?=
 =?us-ascii?Q?eI9I+xyrgsmBtor6JkEfjCN19Qv07lsGCxy1ETu23A1B1ja2wckxW4Iv/x1I?=
 =?us-ascii?Q?0I50uUmUwSlLONzwjCLVjplMfVNStp1PYC86vLpf62OlFk94sEUnpfnDuXnR?=
 =?us-ascii?Q?DA5VjAKaSkMj1wnte5nSHpxkhoqUFrmyDdSAhhzjlT/+8eaxVOyDlBimx5Tc?=
 =?us-ascii?Q?GvlyUKvSZ+SEf0XZmITkxbZUFrGUc5HZEZrSXd8ERdBSDxTwRZcI5u4NEHMx?=
 =?us-ascii?Q?cWt4QUMSCg1a1AiCxdnB1bSfgihVB3Jwt7RjGZDXugJRiy9R0YI1F/x1V6j6?=
 =?us-ascii?Q?v2IeD7uoMdeNVEYahdM9qIqGq2/lRztJvFPhI4xWyjZa0C2EUBtK3UogaN3i?=
 =?us-ascii?Q?n4+W8SzQbgbEqIbAG88fdPYw2T5DLKdqdZsUEXFbsUNsbv7grVAxzYSA6HcL?=
 =?us-ascii?Q?U7WTUFZKc8CPxy7s8mbHVHgqUUvHy0xQ9+d3eJHCKtN3a2+n2i6jnC0EI7W/?=
 =?us-ascii?Q?OHiI0c4mY4jsM+qaGCs8dVVRpOCrc8wwiV4DFjzD0xlRvYNfth474vy3keYn?=
 =?us-ascii?Q?papvwQF2xO+O2cLuJtq4XuXSUOyNc9QCdl/Su2vHydui/a3z0xzyJz47sa2a?=
 =?us-ascii?Q?Ht3umypBXpgLP3OUno/E6Yl/OvJcO5NZVyi6gAAOBu5+4rtr7Tfn9wH5rDqb?=
 =?us-ascii?Q?W2atYxJxVpuaJmD5AWcFuSICMPxLFeuH8qYZsubWihCpJ1GYo/tuV8zkLuDf?=
 =?us-ascii?Q?cruo+FVebL3g1ex+aSwU1Vk/GfrGFV22WS+kr8sEkxpoHu89LOLOU+TRV8b4?=
 =?us-ascii?Q?eVzkhBpyeAEXMGdkNL4wYSFZF4Q6yF3S6LepRUEuO1PvhVMBmcvla59cfX/J?=
 =?us-ascii?Q?jH/xba8VcrRY3M/dk8bRsB4roAgLp774a+/VMKyaZ/WoLH4HGKOaRd+sIg/3?=
 =?us-ascii?Q?Nk6rWgujc7WmoaaRLVlkqSv1PNn/MMLH6ZK5MUGciagdREQq7owTaMCJsvAe?=
 =?us-ascii?Q?YnbIb6yVoMQSNxbD3kpRzKxXVgAJJ5Hgjuou8k9VV040+Iz5ba1JGxf1fzx6?=
 =?us-ascii?Q?HB+iYd09EKDM7Z/E6MBDBdLZtoibnZlDprE950pp3DAWuEBy3y8+An5QW+tA?=
 =?us-ascii?Q?Ndj/OWOC287QouYoOmB8XmQlXOld0lhqOhM2/ljA6z24onDMkfa5pq4TqA1N?=
 =?us-ascii?Q?iYwG6PX9nysQ5t02eu4LESYtKcAYWy9LU/FDyWU0f3K4jvc6T/sJD0aXADNZ?=
 =?us-ascii?Q?E/f+cMf1q0q+IgjKta0j3pxDfDEp8ph82YHrMhNNaGvb0NlPG5w1VjYWKR4Y?=
 =?us-ascii?Q?cEQJySf6RaIAAZcJLZmUdXYw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3374.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KyP77WuIEzNm6X9YeTfS9bbB5JS/9BUj25mPgCF1BXwUADu+w7M25RRpWer5?=
 =?us-ascii?Q?tbjFrg+Ob9PIA64OWryD7gPzs2/nRowRLVqX+Bew2tmHwswMelnBQ7z1z3nM?=
 =?us-ascii?Q?n8/f9WHGbcsSwBJJxKCtaC8f5xs21TxE2f8phW86Cuf+cZBb4O9oWdnuifjo?=
 =?us-ascii?Q?YpF1r0vXenOncgMja0qaGgFrFfJvC5cpRMIT7NC62bW7ScsuoCs7WSifUyxo?=
 =?us-ascii?Q?FhHgk5+eMB0rkXVqFSp3jWUoeS02AyVzuw8WzvH7ZLIsJMGAiLOWZpAdMfrK?=
 =?us-ascii?Q?jrQkmAaLtVOSSIGfEfapDic7nD6oK0INr1TSyQLQ7TUpxtfFO++RybhyF8qk?=
 =?us-ascii?Q?4ILwP3Z9Nx+8WB2tpKwlOMwPB9HLwbuwC/Y3ffvsoCPB8YSX6nDRib5NFreL?=
 =?us-ascii?Q?D7HWozAykgmkl0YlQJHVcQo+t3PbeV3hJis2JWPmqJHY1krU4XwTSknpSD9i?=
 =?us-ascii?Q?lboFXDWxWFWwVLvBoeeLOYi0Uc5TM65RP21ZwomnqiFEdBWJREVV/ZTNbrnF?=
 =?us-ascii?Q?/EVYC+ZXwutPLz9GZXRJhR3I63imCxTpIhZKnxTqEVYRObc1N4ytyJCAceqi?=
 =?us-ascii?Q?tBpt8IJJBSmb4+S/0X6jfLO1086DzgyDfb/ij5Wat3T26k0wXOXzfgrnQ7At?=
 =?us-ascii?Q?mvN2M/0pdUGEI3zcg8jvidhus/4s76L3VDNf++Zrw+ANRvgMtcDMCopNlbDF?=
 =?us-ascii?Q?jtNg6P8RmoberRJz/GYBPOegKi7GHlHSXtxOSDfe4LYbj1YPQMOuHbFFU9u4?=
 =?us-ascii?Q?GCQb/VDotF0IDJVshHYhFmddmM8krcJ5H2K9OSHcu8+fIm3VbalO+Cd9swHx?=
 =?us-ascii?Q?uO68BpsKc7PZQT1FnoO9gGAqFfIhKSAPkSnBckVMHDmUUUnKzNSs0S7d80NO?=
 =?us-ascii?Q?h7rwJKuZBX3BeeeV3ay4+BqBPCemEolvBhKK0MM3Dlsh6LXqFmvZTFzf7LAQ?=
 =?us-ascii?Q?/TdE+HUG2DeYAY/FfhYzprGifSTIYIk6R94OXnBa2cjihmm7ZpGt5hB5dXxH?=
 =?us-ascii?Q?9rsE3ipUgC5JAOQc/dumuocx/RJAMYn0npRTatfHRFyFgiJP4PwEfrxiU53+?=
 =?us-ascii?Q?P8+Dsx1kuDTzYYj+B7y8PXbKv8+VTBBI5aLzKe4Q+uvlTGvsjBso149i5xfk?=
 =?us-ascii?Q?6qxK3+3k2t+GZ193G0eDeuhiFGg+bKve3HQIVQ6tvI0pd1cVHiXB3rR6SSun?=
 =?us-ascii?Q?FFaYYagxNe2h9QPWB/KXl73M0Z3cq2tVoFWIzQGGIt5RS5CI7VskFJTf0Fam?=
 =?us-ascii?Q?zd2zJjMDDN3o0NEzioA2FuvLlFvqqZUKHkd86+zAUAEUA+kWhtTKipOHk9iD?=
 =?us-ascii?Q?eSDvxo+MpWsDiUcEGuRQ3AmolN+FWdjMCsM3lDU9b/eXoOHDxoKBu3fFfOgH?=
 =?us-ascii?Q?i85tt8RDZGpQ1sk0QFu5XZ1wneB82fv3P5aAYZBWqo1Gcy/kD8eUt4cpEtrC?=
 =?us-ascii?Q?MTfUCqsv3mdx5GeH/cWIiPkgf4jWMLs3MBsFIaMZRnCqxQg265sT3E73Yvyo?=
 =?us-ascii?Q?IodGoDJgn8BDVjfJ6NvVv/y9GPL94TfnfEaooIv6HN9EYsiWadPTGRIEWEAc?=
 =?us-ascii?Q?byXm6u/lHh3BO/2PVUEMyvNPmcGly9u1PXdW4CCOcytm17it9gfKk2hOPjNP?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w9qGB18tc/IZ5JjM6okdchGzKc2YglyVtPpHeVay+mDrUrWw7V0aj8uJwadPsHHgSanGIgWTJgpwZzusPPPMF0B+pYs5eT+f2HlUYysrGPvpjZTTHR4D7VAOYxnoBwNXwpzUOZ3xboyULcVvfrNpBKN4CRD3z3lk2qwp3DkNlP8yET265kDlwYT4c1fdBQtv4j1ecquEQBqGvCIfYGeDcUmwGSdYlmzujUuHY4T4CIWPACVXLOTcaHAcxmd3aNRe1U2s4wcK7y9xz7WNf7CyAK4S6hZWA/tPKsEGJJnBWCMdIO+E4w+iE0lbjd2WOHKYwAUyDd0Dgfz7/u1tPffucrPu2uCg1NwDGE6hV4oMjgjGSjKs+3ZOqsJ7AR/Yk8N8Jrt0qjuD3UDsbFWq/yVWDCFhNSFkcMDWl6vY0CaNSHGzsQH5KupSjiyn4lZbII+IhZrQkpQAefM9AhxW0q2PBNjwcGf2NRCAeq+DGc9kw80SNFyy0jBKb4xPM11gpcPVk/tioX5W6JGRuH+NwLih9qa20jGIg+uBN1J0iwu5y0j0Jaiff1tdC60g2Lacpjz9fGEJinWTZv5fiMt5q4zoTen3iMWYb2OPQ2T+M9dGqK8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46db44ae-f2bc-47e0-a8d8-08dd023d33dc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3374.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 10:40:04.4703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SnQXrbYEW9AM7HKOvJifHewSQr6w2vprLxX6GMCl96JKjSeU44hYQK9qW3WmsV2JpYcMcc3HKckbDOEq/w5UV9LlABIFU8oOexDBZfTwzE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4206
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-11_08,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411110090
X-Proofpoint-GUID: G5GZH7qkjOLeLYYfhc66F_e-ZfljxgW4
X-Proofpoint-ORIG-GUID: G5GZH7qkjOLeLYYfhc66F_e-ZfljxgW4

Wei - a side note, when reviewing huuuuge patches like this _please_ remove
irrelevant lines, it's really hard for me to respond and easy for me to
miss stuff scrolling through >600 lines. Thanks!

Also - you're reviewing an out of date series, the new version has changed
a lot, see [0].

[0]:https://lore.kernel.org/all/20241108135708.48567-1-lorenzo.stoakes@oracle.com/


On Mon, Nov 11, 2024 at 07:07:19AM +0000, Wei Yang wrote:
> On Thu, Nov 07, 2024 at 07:01:37PM +0000, Lorenzo Stoakes wrote:
> >+If you want to **write** VMA metadata fields, then things vary depending on the
> >+field (we explore each VMA field in detail below). For the majority you must:
> >+
> >+* Obtain an mmap write lock at the MM granularity via :c:func:`!mmap_write_lock` (or a
> >+  suitable variant), unlocking it with a matching :c:func:`!mmap_write_unlock` when
> >+  you're done with the VMA, *and*
> >+* Obtain a VMA write lock via :c:func:`!vma_start_write` for each VMA you wish to
> >+  modify, which will be released automatically when :c:func:`!mmap_write_unlock` is
> >+  called.
> >+* If you want to be able to write to **any** field, you must also hide the VMA
> >+  from the reverse mapping by obtaining an **rmap write lock**.
>
> Here I am a little confused.
>
> I guess it wants to say mmap write lock and VMA write lock should be obtained,
> while rmap write lock is optional for write operation. And this is what
> illustrated in below section "VMA fields".
>
> But here says 'write to "any" field'. This seems not what it shows below.
>
> Or maybe I misunderstand this part.

It opens with 'for the majority' as in, for the _majority_ you need the
mmap write, VMA write lock.

To able to adjust _all_ you need the rmap write lock too.

I have to trade off with 'summarising' how you get a write lock vs. the
specifics, I mean I literally give a table immediately after this
explicitly listing what is required.

If I gave just that, it'd be confusing and people wouldn't maybe realise
that _mostly_ mmap write, VMA write is enough.

If I don't mention the rmap thing then people might be confused as to why.

Given I give the correct requirements in the table I don't tnink this is a
problem.

[snip]

> >+.. table:: Virtual layout fields
> >+
> >+   ===================== ======================================== ===========
> >+   Field                 Description                              Write lock
> >+   ===================== ======================================== ===========
> >+   :c:member:`!vm_start` Inclusive start virtual address of range mmap write,
> >+                         VMA describes.                           VMA write,
> >+                                                                  rmap write.
> >+   :c:member:`!vm_end`   Exclusive end virtual address of range   mmap write,
> >+                         VMA describes.                           VMA write,
> >+                                                                  rmap write.
> >+   :c:member:`!vm_pgoff` Describes the page offset into the file, rmap write.
>
>                                                                     ^
> I am afraid this one is a typo?

This is fixed in v2.

[snip]

