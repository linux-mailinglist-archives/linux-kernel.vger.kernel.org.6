Return-Path: <linux-kernel+bounces-244494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 346B992A502
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566751C2153B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F8A13F450;
	Mon,  8 Jul 2024 14:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tcp6zcDW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B3mK1rSR"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B51E15A5
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720449964; cv=fail; b=UNeuL7LVV7Vm2zeDwqjrww1p37RYic7x08TLx2wXs3iTqSHWSXYcPiqKuNDPwtsl7EM8dR3GnlW7MnXdK/qxOnXZLxY66cHlMwMyfZsq7zCjfk6w9o5/u3aXpsRSF0gl/wZkyOowVX6BdFoeVYMBrnveczNLmWgJAHDIBoP3jY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720449964; c=relaxed/simple;
	bh=WoBfTkZsENj2+vv1mheSl9yUzQAIdbYJKIv4jVj8CRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b/zuublLgmt5Y+1cc/NzOtY3t2jlBCyZAyoP80OWUOA8hQOocK+OBuzc7CinNnEXcVAVYAN07ckXwhMzONhsH2KyTAS2d7ug/k5ueT8j6PfX1j7OU+whxxV4mm4Qvs38B3R0SYqz0haF4hqA27dIgoDMs2z1MCRT0oPfzY2FifQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Tcp6zcDW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B3mK1rSR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687fWMF018070;
	Mon, 8 Jul 2024 14:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=V82tll/MSRCjxNK
	xlQcGAJ7lvMG1EpkoEnGi97Exoks=; b=Tcp6zcDWgskMUDB2oHDp63QgAHcfrMH
	+6ezXUb+Q951/mrGJ+0H/x7sczlKNdIxHHF+5aqSvsGLKL+XcoY70YDPXaZ1WlI5
	VNrspqdtvE/EGb3dcWazQShiEbXXGWI/MsYuWHcvSaEcpZxLJRwU7TElss2dqCia
	Wi2Fm3FflepTG03VF6wehtbMx/LNbBzJMCMOBkj+x/2mlSJ9dhD8QiF8Wb+ETPyb
	OeGbWGVJTIlGWB/GT4Xd3XuqhXG9yZHe/VrlbPtWO9r5qd+L+Q2KA7f2wwqoCAgx
	f3TDd10lzlITW+nhdzVCX1NY6MbSrCbBXEagKNRMvyBvD+dU5H2w/lQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 407emst6yh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 14:45:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 468EVvtR007511;
	Mon, 8 Jul 2024 14:45:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407tu1rm7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 14:45:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JD6KeH/Ec152O8YNplLIpHM4IWu6PK9RhK4OciSgXOKl5Z4XNBkIOIyg5jYB/g/DeBkHumKYkCEMi7vubMNZ01GxjAi2hbDNT5cXesgiOyPPIijfjp7Wz1LhLHnXPOYjPUQlFAMyY2+JYnz2pjyaLMdGtXcZj7QW7LMWKXdWPhhIO03mwZEhP+01j2abtpU28Ffb3KjhLYWq1JWMB3UW6CXIsRSDGtRP8lbBJuKiiAg9J9/gDPzYOgLy7IRxephsNfovgISSbdbH7ifbQpTwY6352xvpBnvl5PnfRlk6EIAvuO2iX0zQkEn0gSQfpM6C8h4DL5P0lLQMKfAAUYlecQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V82tll/MSRCjxNKxlQcGAJ7lvMG1EpkoEnGi97Exoks=;
 b=J3JvPFb2A9I0Oksz0n/PsvfiY7NNcdR2Mg0OWJRC9QNuNcz3EYg01fw7gYW1LYwq1/yme4dHq+vup5Ur+R7zv0Bz07G7zbjqLm2YCG6QlshVo1H44iTBNH1uZ2Y62+6U2bZ8TDdGqwv/6uhuvuxd1F+6+c+Vua+OAPwzsgJijIWHc/nAHui0RB44Bs5bSLjihj1sDSfEd37Fe8ggRUvkG1v91/e6fVNnUN++u+myAtt6dnG6qNhNsOOTu3e5agmcSe1F01F4JDEyxB15m1Nsu9Dq6s8/FD0SpQZMkLzFGbKmc6nXJ5PWx2IMKIU6Is68QAM1HVaj0HbYnZbRyIc7FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V82tll/MSRCjxNKxlQcGAJ7lvMG1EpkoEnGi97Exoks=;
 b=B3mK1rSREZMrgLlg4P59PdFQOE7GxO9qzfdVIWuprcQMoqKeItvV+YqbHO22UNywkstoxoyHXnnqpZ7DWuVagyUJHOCnk0J9WPWWenjAvf/eun1h+jX3BjneVSoy49IHv92JmX++ub0bUaPP9tQIw4G1Xz20E5HMMQND/rjbxGc=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SA2PR10MB4729.namprd10.prod.outlook.com (2603:10b6:806:11c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 8 Jul
 2024 14:45:41 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 14:45:41 +0000
Date: Mon, 8 Jul 2024 10:45:38 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 11/16] mm/mmap: Track start and end of munmap in
 vma_munmap_struct
Message-ID: <jghcpyibgtemzndnpeqncc6qboym3uk26nxsjsht2sllcgaheh@37zpmuehbhdq>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, 
	Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-12-Liam.Howlett@oracle.com>
 <37ea5831-2163-4086-8b2c-baff3be2e5ad@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37ea5831-2163-4086-8b2c-baff3be2e5ad@lucifer.local>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT1P288CA0028.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::41)
 To DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SA2PR10MB4729:EE_
X-MS-Office365-Filtering-Correlation-Id: a1fa933b-faf6-421f-c35c-08dc9f5ca3cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?O3Y6JTjT1gq/lY6cAgNv9pQzJcHiK9catVjb8/uHGGvARO8HewOcMrf3Z0pv?=
 =?us-ascii?Q?pJwbEPg5NPKGl7HN35hC9XAg600hZFYC/irXPOPWu6ls9kOoSxjtsPVkfxEo?=
 =?us-ascii?Q?HkQDphTwMx2D3A54vwmIxzbRvXpYyOlmtGs6X7L8DdvIVd4U2G19edd8I8eh?=
 =?us-ascii?Q?p+5HguRfS8mZczxNcvufty9d3i89jKkFJYt4k3lu+tcfm21x9C+cLW2e6HgH?=
 =?us-ascii?Q?JS6Q5cCNXNv+drmpDDozuUX0RwXbRbBqBU6zb8wYBG8TEox9CZbVCH67AI4i?=
 =?us-ascii?Q?jzwxV66HRAEMhS7KSpdFMy35qHlCqGpXFBdeE5KGGCZ0EOgrJdaSG+0TMwd0?=
 =?us-ascii?Q?raW67hEM1ZMsTQWYlx4v3F09kMUiQGm7ARidYReLhMj+GA4kJNBcHepRC//P?=
 =?us-ascii?Q?SIEUNPktDdZG/oPCzXr5KVOXqKUTAw5F/TCFzUjqy5zKxrL0JA9Of0hidlpw?=
 =?us-ascii?Q?ccUpDCCtZCdQ85cpU2iLQXl+rMNodv+FSEAlc/2i+GIvoKj0WIxErxpXRPe0?=
 =?us-ascii?Q?Drru7Dbsd45uN1HrdceE1WbaEdQ8VqVexgUdl1o01bPhFY2Iyw6/fLPuUhpq?=
 =?us-ascii?Q?lP9E4AMMTXLhrBfbfQKMARRn4S+GX+1cFp9M4DZ4wQscAonp6BkQzExog8zj?=
 =?us-ascii?Q?ooDuIlGMaklfgC/yHbvHEC9ZLZdMHjPW+B7vJmCtTZAWzvaRnrkRj+LjLtOu?=
 =?us-ascii?Q?KhQjB0UDhcgpQ+9sa4Azs6yfITaCrt5E5EZOmEGupIynxvO9OBgRALVuCJw3?=
 =?us-ascii?Q?eL1BK3c6GuRDv6afvPC0lTd6vrS+KM7/Moiitj8A5eSxA2ofV166wmgVjVh7?=
 =?us-ascii?Q?3h0gLS7VAcXcUMGWSMFgYXP99noJKFFk115cMJOq8mVGWvLBFbR8JmjKyw4d?=
 =?us-ascii?Q?Ty/NPisTVvSBKiNj+bl7t3jyoSdvqrcKRXsIv2UBUYuACYiQI3ihTzbHWsM3?=
 =?us-ascii?Q?BP+HUXGRu0rerfwe3fiS5PheXoUPYkySpqzfqm3xoo5NMlWhmyX+wj5FjHDe?=
 =?us-ascii?Q?yzZwqkjk5svubpVfCp0ntd06kXUE/hjalaitKVIdx3IiSPsX6Tnni+u/KAjT?=
 =?us-ascii?Q?TgpMk7j0l7p6P1XI4zhfEWGupv0hvpHxWFoPLG5nL+nri+iho7dDq5+3LdZk?=
 =?us-ascii?Q?UnBxm1DNmFgzcpgZkNsc11P3tjeuDTly5wk1wZeK0g10k++Dj0qN3YZEh2YW?=
 =?us-ascii?Q?ytETHgup3pdinqmPhLcl+4T2TfOY1KSnX7DVRc68o+kkbzJe/HeTfKPwVDzG?=
 =?us-ascii?Q?aD106FQzyLc7CzMhUWN4LutkOCQW38veZj4vbKVxOThRxeZehQGbpbWlG8bK?=
 =?us-ascii?Q?/DA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UOEvuZFS9ElYlvkDKSfE5BeZKBxJFeRkoEC1SyeOXeLj2IlYR9yMN4x562rm?=
 =?us-ascii?Q?hXiV94SuugMaOck03187y1lOCZ3EatMr389jDbL7nVKgqX4jbnbtzfvAp736?=
 =?us-ascii?Q?32/Q/piEcShLRUgumql4FvKCP+zXFPcsGchZkV7apGwywAiH7qPlv7rw41Re?=
 =?us-ascii?Q?pkFhN2c1svYwkZ8W2bh96A1hXol4dzYBaFyzDewaSmWPok3XzgAj0zlqlT/C?=
 =?us-ascii?Q?aYG7cPG9Hkwh9quXpALojgwUEfVa6BWzAQLF9dmIPaBSQdStWU7TOM8bUDtf?=
 =?us-ascii?Q?dbF1kyTfS15qBaOKv1GznqgJCGfiqbWffvtzO9EKuwcsGDx8j7zJrl5jYg7/?=
 =?us-ascii?Q?LpE35g9pV4oUbUTWfpeuTsiTdjOWaO/7MhbZsiV7DtvRP1BeQO9ysnMiQtKL?=
 =?us-ascii?Q?n7/JQ07cFu8tJyCQvj4zyIFrzmHVBrQwmOcDWDdA+ePqkUhQVDwwkSx08Lg+?=
 =?us-ascii?Q?CL6WO7eHQR98L3AN6oNIjXVsaGo6BsVQuqypOiR0F6PzrNxAc1kbjKsg5I6c?=
 =?us-ascii?Q?1OGN575wzN5ohhypF3jrpZuha+dIX4Gm0HgItZgwoTNZiPa98JE+TP6eGCac?=
 =?us-ascii?Q?jBAprVpbhmxBqTX5RiQu1fZmZENYezKXoiXFVVQz/HV+meksy/Jfd6Ii7Agk?=
 =?us-ascii?Q?483oVtOCJhBzrLKaodR7ctF7yVTFekJQX4s/hiFXZ8SQaxd+ux3T76XnWfV1?=
 =?us-ascii?Q?9/E3sx5oSSV6jSE41VfTr7F1MBXLLu8hxnbEd7LS6WqF6DTwcOrROBr0um2J?=
 =?us-ascii?Q?wTTtJfRU/cP7odGKDmtPfyBbg599ZYe2+eCqofChXxznwfLS2xcUG+x6hrwT?=
 =?us-ascii?Q?MzSBm0RbbKUzurzxC8xydVMjnCTR5vWF1earmNtsArkzd+QXfAXxrxecKDrc?=
 =?us-ascii?Q?7XM4lTvFS4msLQgVMxQ7rqfe97qBhzek+qjozSukIUdQHUpgYbtnUPV9fB8U?=
 =?us-ascii?Q?xSQCESHoDBKQmG6PGSAUxFPXz5BCFza3+WH2vxVi4OqloHICWegCCD2u9yWJ?=
 =?us-ascii?Q?jfzd5EA6ehW1d0td77Xi2MeDGc1lD+Esq2t3DIO1n0xK7L/kH0hE1yEExZVD?=
 =?us-ascii?Q?mliFUiT27c9MoZiTQmwGUrHqsh2PKaMNaBFoqErXThW6zJ0L0jfWl84BCu+1?=
 =?us-ascii?Q?ScqJuxlY4WpSlcvtz6PrzhfkAkKZ/MEVuKmhjLzEoVShpkiKr5xSu5xzerPk?=
 =?us-ascii?Q?w6RuK7TdIyfGwFmOFbjFo2B8betduC1R2ClPJZIjCotQeaBvbVIK7lj65bN1?=
 =?us-ascii?Q?RrsVsCvosWohy8FiHupQAVdh0ptbQ/ELNq8KCvHgxjajv6vcgrLAGu8hS5Ew?=
 =?us-ascii?Q?qHOPQwKvzrp4UCBRfNIAUEtR9A/7234ThZ1oFxNOM408SMknRYhYPGlkecfe?=
 =?us-ascii?Q?Aru8ey3FJyAmTcrhTXVeGwozU4mKHnQPnfDvsR1iGuPIP+R+dzoaYXMa9jZ5?=
 =?us-ascii?Q?rA4IlZW8omTaWfgLrrf2pSP53nG1Hh7XOcqefQFlZlWoC18ckfefnJ906c+h?=
 =?us-ascii?Q?lwA9GvMToBSauS0Rw4LnNA5E9tBA8CHGTHgeMxP4U7B91et15Bm4xf4lHjbR?=
 =?us-ascii?Q?fyzJ4i+T+fCbiRWqoZBrNsopqWRIKkNGgTm5drIu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ptP7B9bGnFV3ud6MMo64CgAoKOi2BUu3L8q0VNMAf/9X1nCpc7bl5YcrZfoOyRXMbzTz3kIgfIjsocuBVKCK2kwdTuMB9J3jdcCo+je4+R3FdRpaytzd3mOVISWcYn7unMb0ATRT4JLlow7jECEEIw4LkvtXhmbELIsPvtRwBdB0BtFXrs7+c13klh9utus8BaN+qilwChRJel0TVQOg+rrD6+si8wEdrqZSdmWSwP5LoXj9STNfLzXunrRRGx0K0J3UzeTZX2sCdU6wIn7RCbG0phRuk8vvjUDeQnYefGpTvwJJd8hBctMJ66pLVW00JBzWfzhGq/pNplixge0mNprzYkfgsxY1Pe2Q5wdwGqoYhZPzGO7z5FNL+VgKCG+StqAFtgibF2kSVbdi22gpWraxljgUJ/cmvHCFBifuujsx+MhyAuSj/pu1coA1TzdUQI2QCGRWq2W/4NwhDsPrIx4knIAm7p8KFoIYS48c4o/Fk5zlIHA382ntolv6uX/biPkwu5vJGVbZTL1uNR9tCXYUyzJ9RBnBKOnEz3fhipt2RgLxO09oVvWdE+Ic/MGlNqq1iB4jepumwZgQV7lVtXa7wmdQaCAQKNBh9PSiWnI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1fa933b-faf6-421f-c35c-08dc9f5ca3cb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 14:45:41.4922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p64aklYPI7WdFAD+D53kaUoB3hdt4MfxqZMyfvDWozgQRykrtmvwOrVrRzdg3mZDWpT8rOYOFshmgwi1mVPWmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4729
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_09,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407080110
X-Proofpoint-GUID: mUsSf4zvIYIXDH7Dc2mhby5MpsuJYZLz
X-Proofpoint-ORIG-GUID: mUsSf4zvIYIXDH7Dc2mhby5MpsuJYZLz

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240705 16:27]:
> On Thu, Jul 04, 2024 at 02:27:13PM GMT, Liam R. Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >
> > Set the start and end address for munmap when the prev and next are
> > gathered.  This is needed to avoid incorrect addresses being used during
> > the vms_complete_munmap_vmas() function if the prev/next vma are
> > expanded.
> 
> When we spoke about this separately you mentioned that specific arches may
> be more likely to encounter this issue, perhaps worth mentioning something
> about that in the commit msg? Unless I misunderstood you.

What we spoke about was mappings outside vmas, that is between two vmas
may have mappings on certain archs - I'm not entirely sure on this or if
it's still something we have to worry about.  That is, we use the
prev->vm_end and next->vm_start as the unmapping range instead of the
actual vma start and end.

There is also the upper and lower limits if prev or next does not exist.
See git id 6ee8630e02be6, and e2cdef8c847b4 - probably from an older git
history than kernel.org: https://github.com/mpe/linux-fullhistory.git

What I am trying to avoid here is using the prev->vm_end address for
munmap when we are changing the prev->vm_end to expand over the area we
are mapping.  And the same for expanding next backwards.

> 
> >
> > Add a new helper vms_complete6ee8630e02be6_pte_clear(), which is needed later and
> > will avoid growing the argument list to unmap_region() beyond the 9 it
> > already has.
> 
> My word.
> 
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  mm/internal.h |  2 ++
> >  mm/mmap.c     | 34 +++++++++++++++++++++++++++-------
> >  2 files changed, 29 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 8cbbbe7d40f3..4c9f06669cc4 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -1493,6 +1493,8 @@ struct vma_munmap_struct {
> >  	struct list_head *uf;		/* Userfaultfd list_head */
> >  	unsigned long start;		/* Aligned start addr */
> >  	unsigned long end;		/* Aligned end addr */
> > +	unsigned long unmap_start;
> > +	unsigned long unmap_end;
> >  	int vma_count;			/* Number of vmas that will be removed */
> >  	unsigned long nr_pages;		/* Number of pages being removed */
> >  	unsigned long locked_vm;	/* Number of locked pages */
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index ecf55d32e804..45443a53be76 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -525,6 +525,8 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
> >  	vms->vma_count = 0;
> >  	vms->nr_pages = vms->locked_vm = vms->nr_accounted = 0;
> >  	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
> > +	vms->unmap_start = FIRST_USER_ADDRESS;
> > +	vms->unmap_end = USER_PGTABLES_CEILING;
> >  }
> >
> >  /*
> > @@ -2610,6 +2612,26 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
> >  	__mt_destroy(mas_detach->tree);
> >  }
> >
> > +
> > +static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
> > +		struct ma_state *mas_detach, bool mm_wr_locked)
> > +{
> > +	struct mmu_gather tlb;
> > +
> > +	/*
> > +	 * We can free page tables without write-locking mmap_lock because VMAs
> > +	 * were isolated before we downgraded mmap_lock.
> > +	 */
> > +	mas_set(mas_detach, 1);
> > +	lru_add_drain();
> > +	tlb_gather_mmu(&tlb, vms->mm);
> > +	update_hiwater_rss(vms->mm);
> > +	unmap_vmas(&tlb, mas_detach, vms->vma, vms->start, vms->end, vms->vma_count, mm_wr_locked);
> > +	mas_set(mas_detach, 1);
> 
> I know it's necessary as unmap_vmas() will adjust mas_detach, but it kind
> of aesthetically sucks to set it to 1, do some stuff, then set it to 1
> again. But this is not a big deal :>)
> 
> > +	free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start, vms->unmap_end, mm_wr_locked);
> 
> Yeah this bit definitely needs a comment I think, this is very confusing
> indeed. Under what circumstances will these differ from [vms->start,
> vms->end), etc.?
> 
> I'm guessing it's to do with !vms->prev and !vms->next needing to be set to
> [FIRST_USER_ADDRESS, USER_PGTABLES_CEILING)?

Yes, exactly.  Since we are setting the range to unmap, we can just set
it to the correct value during the gather stage of the VMAs.

> 
> > +	tlb_finish_mmu(&tlb);
> > +}
> > +
> >  /*
> >   * vms_complete_munmap_vmas() - Finish the munmap() operation
> >   * @vms: The vma munmap struct
> > @@ -2631,13 +2653,7 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
> >  	if (vms->unlock)
> >  		mmap_write_downgrade(mm);
> >
> > -	/*
> > -	 * We can free page tables without write-locking mmap_lock because VMAs
> > -	 * were isolated before we downgraded mmap_lock.
> > -	 */
> > -	mas_set(mas_detach, 1);
> > -	unmap_region(mm, mas_detach, vms->vma, vms->prev, vms->next,
> > -		     vms->start, vms->end, vms->vma_count, !vms->unlock);
> > +	vms_complete_pte_clear(vms, mas_detach, !vms->unlock);
> >  	/* Update high watermark before we lower total_vm */
> >  	update_hiwater_vm(mm);
> >  	/* Stat accounting */
> > @@ -2699,6 +2715,8 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
> >  			goto start_split_failed;
> >  	}
> >  	vms->prev = vma_prev(vms->vmi);
> > +	if (vms->prev)
> > +		vms->unmap_start = vms->prev->vm_end;
> >
> >  	/*
> >  	 * Detach a range of VMAs from the mm. Using next as a temp variable as
> > @@ -2757,6 +2775,8 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
> >  	}
> >
> >  	vms->next = vma_next(vms->vmi);
> > +	if (vms->next)
> > +		vms->unmap_end = vms->next->vm_start;
> >
> >  #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
> >  	/* Make sure no VMAs are about to be lost. */
> > --
> > 2.43.0
> >
> 
> Other than wanting some extra comments, this looks fine and I know how
> hard-won the unmap range bit of this change was so:
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

