Return-Path: <linux-kernel+bounces-199109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7118C8D823F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1EB5283DC0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B658062B;
	Mon,  3 Jun 2024 12:30:10 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8208060D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 12:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717417809; cv=fail; b=iuHadWLTvQ+P7pZfoORWnfGA94CAGBZIQRcCYx3JYTRD+8hi0EXpPwxxU8QqWd4sNf3EfYxjVW3xMl+o0DePuKHQSdipsCp4MRvALoyUILTRbPkROXYcBha5h464RhN8+CIIRPqvqLih+mU75SMojYC7QOFNJb5QLKVjCmgY3h8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717417809; c=relaxed/simple;
	bh=9gaYIVl80/4sCRFr57kpTRfvvAohp5RTbsemaUqYpGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hcsBGquMtRtFlCi9OdJJvOSXLavwH6hXt536Wn7ds0GeQ3eOVo3GmxWoP0hocUkcUIZDxyFQIFf2zkk3wQgR3/rhFLFva5gcyyGIowdZq3N9Hn+REiiwthoPCzGYEIcYlMDqaLJjHR7TvXtk1dQYfoYIQtdLudGSVlgxuPDFI9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 453CIe74025334;
	Mon, 3 Jun 2024 12:29:47 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-type:date:from:in-reply-to:message-id:mime-versio?=
 =?UTF-8?Q?n:references:subject:to;_s=3Dcorp-2023-11-20;_bh=3DKmALd2GHlz5e?=
 =?UTF-8?Q?JrOnggI16y665HOTreXUtIEa2Vc2TOQ=3D;_b=3DQ12Dk+RDXgf9OPF6C9SqZFe?=
 =?UTF-8?Q?43aRiARbcgUh7YqTLC6vs8sDAovHObZC3a8FAjmCBG43O_3Sx+uz+rSOJgXyR5S?=
 =?UTF-8?Q?kF/0L3lTDvadekqjXmyhmpIiDL1fJg0K4InwBg8ZWmZvsLhXn+I_03zl/DrzgUW?=
 =?UTF-8?Q?qjA0MD8Kf6k4seCu2ezPqaq+s1qgjwW1MoHn47OuxHa/eHhHS1btJitXB_ouy0j?=
 =?UTF-8?Q?fpnTpOAPyEg9Y0N3PmcHQ6YdIYTaI9s2Fd5leUbVSqD0/Py5JSsYOg141udhb9n?=
 =?UTF-8?Q?_IEdf2S5KGRzz+VKjr0C3LzYMGHn7CU3vOnoBOj9g+QnWCEZ0x41wDWqD2IPC0W?=
 =?UTF-8?Q?oEL/P3_CA=3D=3D_?=
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfuyu2ptj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Jun 2024 12:29:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 453AYQef005399;
	Mon, 3 Jun 2024 12:29:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrs8khnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Jun 2024 12:29:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyXwRTfQ6ZQqM5z7xF6UMwG8nTzaU8RTiU9uEdx+99fDhreSvBDwGBalyIsJZ9NvOOHap8gfo7qOy/BqkHcdgr8eceTcBhsxKVegUr1yaksMPA+f75ZKLldULIIrjHCRrn2FXTkAQqK8dpYtSj5d3LnXuH323PQv+ETUNWKYPmKey9Qdr2w3/LOK/RQGfeaDm28Twnu3F8hsxLqpX7Gw+MssOmTo5S5g5T19NIkf+M+3LE+fgWaSp5Vpei2rfu7stF3P17Bs/K9V1DtJuNGj0UEA3c/LfrlbVK7rLytVuskeMa/k35axHw7WpspBDnkx2fLLb2zIjfElm+of5OLGJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmALd2GHlz5eJrOnggI16y665HOTreXUtIEa2Vc2TOQ=;
 b=lQ/Nj7T92UJ0giNhtewSxOB4Dr4hbT4yifPLf7xyzJOB7lGD0n6CyUmXCdY/hHAPO3OCPE/UCL6uwLK9YUnsYiMc/u1srKKOz72qcrzCA/F9bP2I6sz6DJvpm00iMowX3/cUkRLgp9E7DP1wPR+x6Qx0M2NUbIHlpvVwgGqlJoAU/NjJdnUYAwhDO1QRJlfnDvbqnl/pATqEKP9PXh58HSE6KxT6XbnorHb5/UOh6IZP2MOJGth4iDOGwmHGUG7boBrImamAuabJzm/lweY2zfwcj9KBF9a4nKAaNcPtdoAORbhgNccvgwC/N1OeaEu7NV0IUN+Qk33AGFV5OlqqHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmALd2GHlz5eJrOnggI16y665HOTreXUtIEa2Vc2TOQ=;
 b=OhEDBT/UHATbq/Sz2UpUS7NEtHog9D/l0u7cVt3QZjaXj5yV8zYBV4qpgtBBiRuVJb4XceTWD6RqEIBX96CSu8zRtDsYGu1YZj9dRFMyRTXLOOOwhNlwNft2ea7ru9hpe9c8X2sW274/ecXl60V95ZKiJJrGIrekC5gF+ePGBak=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BN0PR10MB4888.namprd10.prod.outlook.com (2603:10b6:408:115::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Mon, 3 Jun
 2024 12:29:44 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 12:29:44 +0000
Date: Mon, 3 Jun 2024 08:29:41 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] maple_tree: add mas_node_count() before going to
 slow_path in mas_wr_modify()
Message-ID: <57xfda6fbz6m4sig4kdyi5jinibcqycobwrpaih45cykfqyr5a@fstc2xjyw2x5>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	JaeJoon Jung <rgbi3307@gmail.com>, maple-tree@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
References: <20240601025536.25682-1-rgbi3307@naver.com>
 <ntycfywrhmt2beba7pgyxmahwhncufgnpjxjobl33f2tyrhzpb@cckdgisyqlra>
 <CAHOvCC6vZQkotPCvOafGxXWb5GygMSUiYUaYZu3RwFA9cCY2nw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHOvCC6vZQkotPCvOafGxXWb5GygMSUiYUaYZu3RwFA9cCY2nw@mail.gmail.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4P288CA0011.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::22) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BN0PR10MB4888:EE_
X-MS-Office365-Filtering-Correlation-Id: fbf8807a-6298-4c98-f8fe-08dc83c8d94f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?zdIqVMZkO09DM/9i3oB5NTEb9J79dagYcB4wOPMnhlRJ2IdRPIZhdcsyjjWt?=
 =?us-ascii?Q?oBZFHCkJuCPedC1JA98qzXtw/5DYyJIToF6JHv4ji7Daa2okW/Uc7vQe44nr?=
 =?us-ascii?Q?SvaJmB3XimiUKwqOHPULWuUC8Jv7GrNdKWA/H2vCH5PM2boIcVPvPDVTfPGd?=
 =?us-ascii?Q?3gV53DJkIrTpARQOMxjE/MIYo73aILWtf0iG3azOX0WtpEim/4V376IUGb+b?=
 =?us-ascii?Q?Mb5/KlebZ+zFBMXYpxNtyi7YmuY8kBGGcu+YOSIroZol3sfpaaPLoqZF22z8?=
 =?us-ascii?Q?KRbXYSm+MVNH5TwlJrTej68wh2V5sSZuxmjDZekLo+tDjOWGAjHIf/A9W/pM?=
 =?us-ascii?Q?UHTGe0Z6/JCGDQIsoc5C8VoZsAPZDBX8WwLc8ZnCFmtfDRvD0UReQQ823uLt?=
 =?us-ascii?Q?HIE0qaeyK+LQLSltca1D5YP28x5hy5mOq6ZhtzZ/sHP3zFQfEhmdr7z15GuJ?=
 =?us-ascii?Q?3vPBSzmMHW7N/S8MuUhlLuN96dsNWaY98g3RpqUQXTDqF+sq+wxtS8vX4+K8?=
 =?us-ascii?Q?auZENO7yMNHtSG7CRJmSPSPPNg9tGIHsdkxdBB72ooh9JasVUhstIGCWmsRm?=
 =?us-ascii?Q?4bzkaWMdFaEqWfZ9XYWBaDD5m0uIlz5azLX/UVk1b9P/9OVbOLe6PJKiXXEi?=
 =?us-ascii?Q?vHX6kWqlSC4aqzW4+fBnRX1k1FW/6cpSQUJz/7cVfwqTB7Xh5IKP+VTOIqVO?=
 =?us-ascii?Q?ycrKh0LS3KD95vZ3zXguR4GIRrfk0/yX2eFsKNQIbetDsmffBW3cu9WqzQkk?=
 =?us-ascii?Q?K86hfrmvDBm1+tmTXYD5OdDwiTmMPzDpYjEhiya+pwTkGzVDvzYwXaDHOXj6?=
 =?us-ascii?Q?ObISAhcEXa8G7QYmodno2S3i6d6dE6frDTssON7doneE2AM/BdcKc6oDec2A?=
 =?us-ascii?Q?fwOZ41YioVcdnqil6I4Vxgd4SEWlk3dGIA1aMynVrZ3KqSptLGKCXiZ+CkJo?=
 =?us-ascii?Q?4OtAQWBPg9vJfJdRi1cwdru26OhFwGh07WcrWnyk9RFXqpZmTVna+cL7Edf7?=
 =?us-ascii?Q?i9so08IqHntSe7CrOo/SNHbNx73OLiNuGsg1go3g2nhgp6lGiochgB6ypHKO?=
 =?us-ascii?Q?ivIBUawhVBwBE3Qkcf5nsI5m4bGcOWOgJNhcXtgzcCMkR9OGxTFQzj8NXJHv?=
 =?us-ascii?Q?lXt44UQfGA4r+Qp6//1C1y1hyHA9aC6IYDrRydMFMBnUKmdKTv9Gpvsp50yh?=
 =?us-ascii?Q?0VjPzbSXnuYl+fmia757P43SxmIL8aUtCnQ30P/3jnX5qnZFqz0uG+yiZIfw?=
 =?us-ascii?Q?o2q1TkMVY7kaBNl08bA+DuE4bKBEpOW51mcRqHKNEw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?OF5a/cqz3iP1WlIRmXOxupTLrb0zo6tu58O+XI+Wy248LlzL6A7grGDGcCD9?=
 =?us-ascii?Q?VkqDlQrDzT2wXRPxNI8YIVw9n+3Cf5CR5dPewpbTIGdAuAhWPpK8J1coUTiz?=
 =?us-ascii?Q?Y/3269zi9Nr6w6/xejY+qVmjywCT264BnplRWG2KwXgIU16302UlNLz9ozSP?=
 =?us-ascii?Q?MKpsqpmvoA1KMM7GBWFwI8jxs5S1ekxEpaRBti52b0aSI02t3bvLC2gnJA25?=
 =?us-ascii?Q?s2Ij2ScMTAw6yFUmW9VfGOi3yOaSBmirBh74cIhqnbnZ01C3ayERkaATWrMV?=
 =?us-ascii?Q?NrZvispgWR42v65EfqtetnMON1PxEC523LfAUlQ6FhRZgnzPBCSnKm9fPMru?=
 =?us-ascii?Q?9+mASUkPI14eBFs8GulFq7NZZ6N+ov2H9Utfa2hEczp4iyQYQ5FyhcMd80Vj?=
 =?us-ascii?Q?jVSftGKmckDqsbl17Qe3+NR8HfwGun8hf4FGec7h5yHOLOJ6HedNAqmg9rRY?=
 =?us-ascii?Q?n85AUsvg1iXFYYuhgaTYg4eNwDYghBsv462jyhEqid7ccpocciw5TmUSu0lI?=
 =?us-ascii?Q?KcbYjdSyX3zyFGyX7tQlsrPO/Fp0TJLN/l+Cn87sY6tefpp8mjZzySoGb88i?=
 =?us-ascii?Q?/OiFeyk8gSS+mxxAZ7yS0+CCq191o6EV+Ayp/wngpf1uFnPwLfiW6zaTqwNb?=
 =?us-ascii?Q?Y+yDutkHS0J8jgOTixhXpRBTYygAh5rDrd1RKz20nqlsXHbn6UH7cD49QQ+b?=
 =?us-ascii?Q?yT4UvwSZWYSVyFXfrV0MMDVcg+nkCQyNIQvPLN5VGEqvGX11XXJcrEXKONVi?=
 =?us-ascii?Q?KfZ9NC72/PAsO4RRuPBMbYrtNDhvZ37A/c+8BAUx071KvDPm772AXWDpGBIw?=
 =?us-ascii?Q?EDMBlkJ0JgUurn7/yYpkOzGcp5nIC+EfX9cyqJE3h0tL3/bXHICvMzBJmnfo?=
 =?us-ascii?Q?fPdreuy0cGrtnCylNXn1CGCDX9P/Z2FCGfiOI77IAwXzkcVTzr+t3Jl9dqLm?=
 =?us-ascii?Q?tP98Uh3ir7vtI/xRvlnG5PUdCG4KlL1Kbe+g9RErFspiCr9sZpfpUh3Mp5Fb?=
 =?us-ascii?Q?/dTIEIlr7dbMbLRnqXkaU25s6IUMh4HUwiVSATsoiBbaldVK4DOHKPXmqEGP?=
 =?us-ascii?Q?kSuNWJ4dkXS02pTC/p2u7751fC9gaGKOzOmepo+2e0bmL1BZWFDiEWM7EQTB?=
 =?us-ascii?Q?UI+Fr1lIdj+0BNCxwc0p6d9CIxdx78E4lTM2xcxBoWzwCYkk2+UCwYAmN3vy?=
 =?us-ascii?Q?zPZGz8hKlws7tGyq3paIa5Sobeo8utr+BdmPLCKcnOWuPcTznNwAwUikCgra?=
 =?us-ascii?Q?IxYiirdQSWajgpOsLcJYemtsvrq6eNrWtFWsfaRMF/p//Wj6QI2KRxXacAMd?=
 =?us-ascii?Q?rUio8O4RBvK4ZYoncWJmVWZQhX0feMOl/ypnZHyx1/8o82dWxLAg5whD4tyP?=
 =?us-ascii?Q?SsNdkSkM0gHROCQuygv+RyaLYV741gPjwUK64MArKKFV5qLo9XMBUI6xtx9u?=
 =?us-ascii?Q?BxOdYH7TdIrUw/CW/L9gGxwfftnOS7rnD8q8pL987GqtRBKMbyLa5wtXA+NO?=
 =?us-ascii?Q?2a+R7rTpRNAGo389VO/SbhIJO130mTWbfuvCfXYTrDHxvy4bz4sML4u9BpbI?=
 =?us-ascii?Q?AfMMrAgHBlTHZDU119/pXtV/CbWI7T9p9CiNu/7F?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yQ2h3moJmQzl9P7s4X7Phly2BRziLeHrXAIWxxi7TCLbdO72lhtaoWeEquq1I6fkuVoed1CXiQLeURez8ntuKaqiojkTITM28VKhhQg+Xvu0ISpUzCf+eQvmvdGGob2T4rkwHDhjQf81EK9PRPm+gO/0FpJuTS7ZacQKIr2+3W18PEhLSM+x1Ir2z+42dc5M/y+zKRl7cmYJZJ1yOtNi2rOB+0TUFGRuLzkIlU9bsvCr2ospZj+PHtbkqyc492TuH1leZouMUY79sfF4iRxyQIrOVhbePW01faVAZgaUtXtnCRLtraJSQvcLytPx4dhzzh3vyhjPrW9G3aZ5h1LAEh3Ogg4MPATXXibzcKwxa2YumyCAKt1mq4nopvsbcxB41fqrc0voiZIpl0waBUHJ/70TKWb7r56sN7V4+Dx4F+rJ8x/wOUbfJGiyvQHVRx5KDn29+IlGzHiM54p/9Ojr7jo+crpmR1njyD0t0Ua7sC5M8A9W+fB2Tg5lta0ksi0zf8Of/zc0dVIH9xdNZz6+1dUJqhwdkPH6S7nxl7B07aQn8EdrBhHBNB2jv52EFa5tVE2tURNnB2zguVagXshBVCexVRWJ5Ew1SnZ1kj9cgH4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf8807a-6298-4c98-f8fe-08dc83c8d94f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 12:29:44.4129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CPDd73IHEWiqlPInKT1ph/HtP2lUmIzMi5XNW5kAdrBQQ7no60XLV39FXxZPEkZ/9mhwRriIcjQnpB/deCD0kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4888
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_08,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406030104
X-Proofpoint-GUID: fehucAf1fnSU3RDbVKnNi4Apni1FWOoX
X-Proofpoint-ORIG-GUID: fehucAf1fnSU3RDbVKnNi4Apni1FWOoX

* JaeJoon Jung <rgbi3307@gmail.com> [240602 05:06]:
> Hello, Liam.
> Thank you very much for the detailed answer and explanation.
> 
> I tested this patch in userspace.
> In user space, this phenomenon always occurs when kmem_cache_alloc()
> is executed to allocate a new node.

This is expected in the userspace test program.  We test the error path
most frequently, with only a bypass for those who wish to test an
initial success - such as preallocations.  I was concerned about the
testing since your first patch had a syntax error with a correction
quickly after.  It is good news that you were able to find and use the
maple tree testing framework, though.

> I will try to test it in more detail in kernel space.

If you test in kernel space, you will have to hit a low memory scenario
to see a difference.  stress-ng would probably help.

> I will also refer to the notes from the email list you shared
> and send results once a more clear analysis has been made.

I don't think you need to continue with this work as you will find that
the low memory situation is going to be rare and in a very slow path
already.

Thanks,
Liam

