Return-Path: <linux-kernel+bounces-329841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BF297969A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 14:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360221C20F18
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 12:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5C91C461A;
	Sun, 15 Sep 2024 12:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LLi9wmQl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hjCgutrF"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A581BC3C
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726403939; cv=fail; b=RKOUD8DxMh6jFjzbXpCyYKna7jtAktTZIC/dDtMoTp0QqtDBZ80VvOVB2tv/EXS/VLeg07JAMVWztu7p2MTw5n3e+i1RWbccHYiOWxa/Cogkdn9SHtfHAxDBUDoieN5Vm4JEKokTfeV6g/RdIP+FPl3U8XQQX7Vy5qMJUYGfHjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726403939; c=relaxed/simple;
	bh=NV3DnxSTXJsaRyQHzoOkscqngBrEHEIJJtteulHNNM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V7NrDdZkf3J2ZUkVn+GmHixHmRyMd0woe/kl4Gvqb4lxomGtZHPVK2yGaZnjnkifqnojSOf9Mc8U5qUxZjOulleMz58QwbINH1rew6Ryiw/dfLM5Sm+hiQIiwOPzsTRmvEnP+uunDU7Be+963Ot9HqQHUhFTWDT0r7adrlEoUos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LLi9wmQl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hjCgutrF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48FBj1OQ021248;
	Sun, 15 Sep 2024 12:38:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=21IdTJ2Mo3gZcZF
	f3z+A6ZM+4bP6V8JE18iLG7+2tbw=; b=LLi9wmQlE+o4C1gpE8e9nHUs1zwq2pZ
	+hjAp0jw6o4nMSWj5e+2ZkuiydUiyMRR57L8qBDg/XOTPDNXMG+7ucNZ6atJKq75
	/6ulTbmw/ILVrW/eVtZ5w2I/GYQeCni7GLScmxR/ABBzRRV15R1W8s1Eg7gior93
	Ht9DHQH6//WAwq7ppPEcrXN9y6R23Q2EWqobM9N2wxxS1WpFTyxO1Os/7qqRuUbX
	rDUmG0wBf9TRd2Nd1PbB1AU6YHfWppk0eBlkn0YbpfJcg+QzWyNkDTIVG1aITRCX
	xCbpyclgr6ZeIW+4R2EoLK+dlx0q+gKRq5Dnk/L3wB2MCKDtW46CnuA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3scskgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Sep 2024 12:38:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48FCCwlP018566;
	Sun, 15 Sep 2024 12:38:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nycuga4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Sep 2024 12:38:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g3ET9+clws6zpOP2PNUYF7RH7qAm41tMb1ctdOTjtH9fuTjzGgh3I6K9evYIDSZF0+eppUROeHaptCH6icnzAamldn/4DLtlvDIUDcivCeakDwi8YMqq28voHWStZItNUMjVHJmcHHSD+TT7qIv5VV3og1onJszVN7NelufIT+Kia2zlRX2XHWaZYExfuZnb0z/EC5Wd09i8vDfkq0ClFvBGheQsy01LUdkCe0Bdn2p87c8O/QuLLOJZBWF2xZY0xADg7+yT4mmf4RsvGp8JrhHTTR+vKRBxTzKD2aOpct/4j/VHRDPUkHgPX0XdQaomxzWcVDQttBppOh8TGQh9Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21IdTJ2Mo3gZcZFf3z+A6ZM+4bP6V8JE18iLG7+2tbw=;
 b=RK8e4nMYQcx0sDpvWzPfhLgFDWGx6QyF5q74MkFeUkpT1LwdULmBuTyJz2vVXi5QfaQzveat6bVWPDbyfUebKnjj6YHlD0cEc2m2Lb4IjLtnuRFFN92z/X+wdkPzf9JnWb9tfrx92RlR5z27GKKCcvcU0WXTPExiEcfhgggjZTiYuZZpEJ4Qe8Q8TPiPe0HTczggmzvDXCsf/9u/tLTUkfNllD6hNUdgnrxWKhq/YEl9rx8H7I8MSkYSUWBq49fO/1Nyyc6lRfPHHyGFwjX4GBntJ2Yx4kJO727brZcKKcpFNLWqCAChpfCGwde7alOikKybm1svfDB+AQ2JBS5V/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21IdTJ2Mo3gZcZFf3z+A6ZM+4bP6V8JE18iLG7+2tbw=;
 b=hjCgutrFKe3cqpTRD4RAxUFyMWosvst0KfNIvxZJV+IjLxRvKjdfRNF9UPoq8yzlH2+SXtVhcJa/BYKybUKnk9aLZ+2ItCKZTAmiRsWbSDCc37v1d/3VEiEy91fldAsr6QPWSOtBpq1AfKmiIuuZtNMmAP/sJtG1nkohHgwQqhk=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by LV8PR10MB7872.namprd10.prod.outlook.com (2603:10b6:408:1e7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.11; Sun, 15 Sep
 2024 12:38:43 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7982.011; Sun, 15 Sep 2024
 12:38:43 +0000
Date: Sun, 15 Sep 2024 13:38:40 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [bug report] mm: avoid leaving partial pfn mappings around in
 error case
Message-ID: <998b7c12-19a5-4213-8df6-154f50cd5dee@lucifer.local>
References: <8e3ffaf2-358f-479c-8de6-46e1b0bb0c5f@stanley.mountain>
 <68590155-fd3c-4ce4-9a1f-d314efada198@lucifer.local>
 <5a2f4219-e863-413a-96b9-ad2002f5b35d@stanley.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a2f4219-e863-413a-96b9-ad2002f5b35d@stanley.mountain>
X-ClientProxiedBy: LO2P265CA0482.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::7) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|LV8PR10MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f313295-fe89-4e12-56f1-08dcd583559f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tHy02JxnKSYICYaq7JY6FUsklfXMcDicrKUFaQu0NVc/A/CYkJ/CViCl60em?=
 =?us-ascii?Q?OmSxKP+Suxy3zFNAQ/HBQ11PaS5R0eAq0vjEOR8gvJ9Ts31HJ0lDLHI1ZRj3?=
 =?us-ascii?Q?X7qvM3vJ99uFcKxlLxhwCY2jVqHxIql5SSaLGnMboZELg79VwSQaO63dRmb6?=
 =?us-ascii?Q?CCCJW23ztOZLg45p/unbRMNZD1j8kyCfbQ7Jigoxp7b1YCRQS+uSip1LAZBZ?=
 =?us-ascii?Q?gE+wxIUxl9h0HlcaCCF76xRflopEodvXBLBxt9kcebj4g8BTwayKCb1xxhPP?=
 =?us-ascii?Q?VlR4J6XMaAbZ5unxF9DCSJkV8EYjIeAXjS/7wzjuCkqr2C/+o9UxnINIWFzM?=
 =?us-ascii?Q?PqYdNfNg8wWB7Zn7p6TIeD5NLrrMB4seCp61O7nAvp0qeqXHExD7nBYfbp3T?=
 =?us-ascii?Q?VClgiYua6zTS6SBQWiRB+wyfHXeBRYHo4wrOOIno+Dt2zh+uV1ucByKVbN5F?=
 =?us-ascii?Q?UFOmYugyjm3mzONhk9uPJDIu9Bmn3YSTf4E+nvbkXempF27Y9oFFXZRzXBN8?=
 =?us-ascii?Q?9C8r/bqsF3JZ34mF79yS+fm5M9ZnvSs23wWprVXKjWMrFK409OUCP6p7wA7S?=
 =?us-ascii?Q?lI3IuroiGsPB0jVUDLNyc9OMtMBGzfsbgaam6Ef1ErTnfADsBXnskawzEEZ0?=
 =?us-ascii?Q?PF2TR3J3VRnJ1uNj1MquNWMPXpgn0Qg3dUjFMGrvzGqjBALTHaeegqjLKEY/?=
 =?us-ascii?Q?pzSLdzNNNctqI9aBe918j2BsnqQfebM7gnfZARd37cRvmut1MZUfqSJOLVU5?=
 =?us-ascii?Q?kFGKtZXRbciy7ly1oxcaONT5PdjcvMh5GsNNa1qHoSuPqR1AA5va9RovmwnP?=
 =?us-ascii?Q?HNxl/wZdvpCuEAJ1vcmVkzpni1ifydp2jYDMAiZjgudKajkZ2RHhG6SJoTtk?=
 =?us-ascii?Q?BKA/weRz6SHHZrT478HrtPLBqQrKSJElnLTUfyX7ciTVlREJZnx+gkwY3XS+?=
 =?us-ascii?Q?H/sp4Me3SSUDOOxdIzMOi5etCZ8zi0mS9ClSB5UvgcJHktwWyZ+T9dGPm5Ma?=
 =?us-ascii?Q?Vmz0qOq4/bP4F2q8ErOSM6hW7GMJtbC2O5MWmuVUZHe4DXBhaGH11jXoQBvU?=
 =?us-ascii?Q?/7YlN7B5CrA6CebyIb5Up8OUS2UDLiNnFRqpPlaKavgFzDdHIZfnf1Jxm2AU?=
 =?us-ascii?Q?QMwVUOKDvDYp2vUkzkbTDBEo77tD4kXbOV4Jh4W+3gDfoAXbiIsTltELhOKX?=
 =?us-ascii?Q?avQZonn7A+e++GQOIzuu0twghOh0yLmf7vQKRZbVezAJYobCNg+4RWRwkxYt?=
 =?us-ascii?Q?0GjXT/OodiTC5qwBwiL33wLFZGeBuYmAjIDGrypB7iuFai0Bw0DHEfQAxhOG?=
 =?us-ascii?Q?7KjceWjsjNoS1oi2CYW4gUM34vjciiwXinO5eUxJFNJXFg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z5cpMFVVEnwOlxa+E6tCap9tk/uEQtwxJIMfYd7D260dRssWlSOT93s6e42Q?=
 =?us-ascii?Q?1og6IZCtiNZ1bAh/B4dGRFdJnkUHV9yMSGYu44jOsPBQi/SmSOBAfAqxKWu5?=
 =?us-ascii?Q?UZ4v6u6or8msYQ0cK+A7ycqT1Wy7N34/z3PluoI1LGUXGUJEbeCZvv1nwzeN?=
 =?us-ascii?Q?My6hbHT9+DRqgo2YJ02nVIIFuNNz1QinjKzJj1jg2xpEtgSYW838sJEKmCI9?=
 =?us-ascii?Q?ckzJZMRKTxWjqElR2ohzZdNspQ7nwfnTZCP8eSPUuOhpDDKbMgtuxjfTlTP9?=
 =?us-ascii?Q?uOhlbInQ8JyblEeZ8Rge3HG0ojoVIb2nclWIGIJtlDZh847pgPttUlmURSEy?=
 =?us-ascii?Q?R6FXCf4Fbiuw3ccCtBYFfk4FT/YWkU20ovFfus536TFZvKnsJV1JSjv5eNhW?=
 =?us-ascii?Q?6OeHjwQeslQqm0xebuErCM9grBnwWhu47wgqxgkmdnymgzIOxnfEnNPus3xQ?=
 =?us-ascii?Q?+dRMUCHNRGT+JonFyGaSu1y8YNFhNyEda7Dy8a205StYZSwTv8eAIFYHAQJs?=
 =?us-ascii?Q?ZwEXM3GtFZh/18X7jnv4eK4tfGCMw4vBOfofWaN/EtmyqxDBhYvmzwX0xv1g?=
 =?us-ascii?Q?fC86r2lQ7KFVNxDBmZ3UAHMcLnmoQeZ2xWGvpWRj2ToSedmsb0MQhZ3eriTR?=
 =?us-ascii?Q?UsqPMOek2KgwOYduhPRNWnYI2nmvb2HCcFrv4L3BJ2lE5t4nRug+X0UOCvGT?=
 =?us-ascii?Q?0jDKFKjaP1It/1Nw91GWM24aeVI8PoKnBaJVGGbD7CGZn1TfPlxCC7wyjN7v?=
 =?us-ascii?Q?3uE+nZeQRBFuW0Bc6dGOhLQG9fndQkolGcvSLsc3GjTIn6aRcTUQbsEUvqoG?=
 =?us-ascii?Q?xM2QTsT28BVP9FAKv8/BG/wnlWQnsHyrblQnCb5poZlPEqiRRL5uMe8RQLVP?=
 =?us-ascii?Q?CRLXcrlwiTJeHo/k9U3GCxFrmGcqKrjobLRSwNX2JDPEbnBjfE6RGnbSYQMv?=
 =?us-ascii?Q?e7AjuhHfvr6m8f5bsm3UoyG1KND9Yms/s8z3A9du/ZM5AI1OKRAf6et+0aCP?=
 =?us-ascii?Q?egguxlBRsxxBJvxwHM9agCf2LPuJMxmcmfeMFDl4pSEM9W3SZip/6yV0E7Ch?=
 =?us-ascii?Q?Dg1d0RRY1jZ8TD/gtJT6PDopB1NKOci2K1O2xk/soJh9gLIu+dQqRGja0ybR?=
 =?us-ascii?Q?YAmylaXoZ7E6qP2fGT97k7tDOYkP2BeXaJ/Pw2AoRSUkrVTDv54zib7GhsJM?=
 =?us-ascii?Q?V3NopiFz1qWN728mnGRfi9FB2It79i6ASwkw3rTcN9Rm2cZWCNt1DvVuq4EU?=
 =?us-ascii?Q?L7ggTzJrHjELOx1U9USAKH5ah60gN2sCrZUCErUl63fsMwDM5VBOIBOQ3yxn?=
 =?us-ascii?Q?8LThR0gK6ZjbH96EadCyGN/2cFtZFI0bTAkZjn8jjqnRrUjqTU4xjjpj89vD?=
 =?us-ascii?Q?GEdJ3hI5K+uRbss7Aw+OWK0Eu0OGRdSjFKiq24yo0SSrWIcNXim5owEiHD7r?=
 =?us-ascii?Q?h8D1SPes8KAdW5N5WrymPHosDRScUJubQb4655ksjWR+R/96u27i3oGR/bIo?=
 =?us-ascii?Q?gS4RW5shCjDb00YvHLbIR8hjtAYL7GtCs+l0fAoHsHvJlrJsTsNmvvdW+al6?=
 =?us-ascii?Q?dB+nJpByaHGEmKFAf5WnufHVx6FZxRWGFftb6SkWGAuXhpmaVwfJ7b78IFWu?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7wX4dtSaiS5cCJUVTs0GpG6Vf7zeSONy2mzsHWTA9cucEG5QKyWGfJJZWdBCrdSetpZjEuokWxd1iGN+qPYdA8Dpk5V88Z3RyRpf/dlR5ZSD0eovTA2yND6rHtS6fCHPlOG17/wv9N4seD5CKvWoOxs/XITOvmyiXyMzOtRn+KGLsJOH1W4d/BpVlKSSQGtyAPkZXzVeSR/afQoXjZG2ufIm34SUQ9h6BCEF5xdUgxNW1aRrEFgK5LPM3abbNxo2OEFJ+5zHiK/d6V8hoksPq5grUfd8dxtVvtuvSDk208JSJ7Yc66kFYgP+ctULZD4VZzmksMRF5Qeh7M8OxdqmYVHie7xkHJ18hIKHaCSGOZ103rdhjxvn5KnCcORNdcE7D3GflucGNNyotVkxWDtgegY6P5jImMEyW+PLPHz0h63/3LiPfoNpgrItwKRuv2mXDB+rMpwl7fLfpVOqFiB4EVv9OpQYbuREQidQSyLRusMOMhHBIY6WyUvIB2nhdFCsSgU2T9IXVJpJKLdOeSlbPMPo9OPpwQSL55M8nM2gx9pZpTZOURsWV4qK2ApG1JN0Rp7xHSHc659+oDZ+c2LiynrTJcJnsNH+iR9srD0gkUk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f313295-fe89-4e12-56f1-08dcd583559f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2024 12:38:43.4929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lze52C6Gz96Tk0FggWBY/McoEbRIJZe39Jk70LfsrATeB+zraZD9Efv2XlzZe7GaGfVauThp86Jh7t877lfEH2rHpmWe+wIrb7+4dporb50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7872
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-15_04,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=756 adultscore=0
 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409150096
X-Proofpoint-ORIG-GUID: -LFL33Zt-rIEyYVXVrQDo1AycnWuppn4
X-Proofpoint-GUID: -LFL33Zt-rIEyYVXVrQDo1AycnWuppn4

+ get_maintainers.pl people for drivers/misc/sgi-gru/grumain.c

On Sun, Sep 15, 2024 at 03:09:35PM GMT, Dan Carpenter wrote:
> On Sun, Sep 15, 2024 at 01:01:43PM +0100, Lorenzo Stoakes wrote:
> > On Sun, Sep 15, 2024 at 01:08:27PM GMT, Dan Carpenter wrote:
> > > Hi Linus,
> > >
> > > Commit 79a61cc3fc04 ("mm: avoid leaving partial pfn mappings around in
> > > error case") from Sep 11, 2024 (linux-next), leads to the following
> > > Smatch static checker warning:
> > >
> > > 	mm/memory.c:2709 remap_pfn_range_notrack()
> > > 	warn: sleeping in atomic context
> > >
> > > mm/memory.c
> > >     2696 int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
> > >     2697                 unsigned long pfn, unsigned long size, pgprot_t prot)
> > >     2698 {
> > >     2699         int error = remap_pfn_range_internal(vma, addr, pfn, size, prot);
> > >     2700
> > >     2701         if (!error)
> > >     2702                 return 0;
> > >     2703
> > >     2704         /*
> > >     2705          * A partial pfn range mapping is dangerous: it does not
> > >     2706          * maintain page reference counts, and callers may free
> > >     2707          * pages due to the error. So zap it early.
> > >     2708          */
> > > --> 2709         zap_page_range_single(vma, addr, size, NULL);
> > >
> > > The lru_add_drain() function at the start of zap_page_range_single() takes a
> > > mutext.
> >
> > Hm does it? I see a local lock, and some folio batch locking which are
> > local locks too?
>
> Ah...  No it doesn't.  It's the mmu_notifier_invalidate_range_start() which is
> a might_sleep() function.  Sorry for the confusion.

OK so in conclusion it seems to be that Linus's commit introducing
zap_page_range_single() accidentally had smatch hit a might_sleep() via
mmu_notifier_invalidate_range_start(), but it should, in theory, have fired
due to page table allocations invoking the page allocator that might sleep,
but didn't, because smatch misses the below might_alloc() path...

-> prepare_alloc_pages()
   -> might_alloc()
      -> might_sleep_if(gfpflags_allow_blocking(gfp_mask))

...as a result of get_zeroed_page() tripping it up *breathes*. :)

(please correct me if I am wrong here).

The preempt_disable() is introduced in commit fe5bb6b00c3a9 ("sgi-gru: misc
GRU cleanup") from... 2009, but it fixed it from the far far more broken
'disable preemption before taking a mutex' situation that existed before.

So fix seems to me to not invoke remap_pfn_range() with preemption disabled
and a mutex held? gru_fault() maintainers added for input...

>
> regards,
> dan carpenter
>
>

