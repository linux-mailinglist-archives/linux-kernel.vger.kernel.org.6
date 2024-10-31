Return-Path: <linux-kernel+bounces-391016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5535A9B8136
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95D71F235D1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDA41C4614;
	Thu, 31 Oct 2024 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kJdTDgLz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RfBBNh1M"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C869C1BE852
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 17:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730395828; cv=fail; b=H86rvajtSM1e3E6cwzDWTYLY5eTooESImSE4Melz9IRjx7Tfnk1NtBui1xS4wAMTOFBBDVwya8/teV4CXCz5CLsc1pFyEVXO4HtiTZyGydpzWCXQdhvzN3EySQ6CvyZiq0yxzp75vtN1/+DoU+NPOzcYaP0a8HC3An1Ivs+FFLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730395828; c=relaxed/simple;
	bh=9HivZV5f4EF/oYTKA/wEmX41yO0NRwMV+PN2IpYx3eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=crvb2q93U1h9mHYpJi78adYBOnpO3cAc9pirxliZGmbPE5/cCFQpbCDA7Df9MAC9Cat0twGubFZANEQL9Z2pzaWfsY3l3Gbe/ypFARxsPSp7foG6wcRtMwFqR/jT912I23wXnk5WfdflVx46k85dh7D1eA02H5YCrhJ2JlU6BW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kJdTDgLz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RfBBNh1M; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49VH3uMC022223;
	Thu, 31 Oct 2024 17:30:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Ra614evAfvJpW0nbV6
	AM2tpmDA2MNmKg//yR3oocGN0=; b=kJdTDgLz/ptCNp1Sa/aDNCTgv+RCwk3G1s
	AqB2dif1YZrxitlCNRzZm7ffFAHY/8zYj+xJuJ9R7ZtZ4kNeEcih+knro3PMakK+
	lUubYdcbguVO+8JTR+S1Oin4OWuNJyj98Mglq12bkwamCaor2eym4gOvuvPDPwul
	ts8ifoSm8fCGMvBfWPg55oneEEmN7g3TghCKyJ2sVcI2gl2WMIxKD/pSYl7iKctN
	8eNySzQ3TpSVV4hweD5X/VsGVtSvjXNXvy5YS8RHRxvKGiKdLFsvQlGMn05mKhcz
	ROirEUG7coV+QkWkUAl7T/PNwR1aznCkAqxgG973R3t9YpNv1kmQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdqjqug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Oct 2024 17:30:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49VGOlvf010086;
	Thu, 31 Oct 2024 17:30:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42hn90tmur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Oct 2024 17:30:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcGkpmpOPOQrze+1HBSaCidkGIM1+QBXPiNQQC5zn0BALx3ttfNP8OJoGzKhx4ncEm5sPONruvWTVCX3azepJHaeQGbETEf/LwXPjc93eDpQ8UO/yec+9ICheIVpvfTx+5R3Xyj7J+vTt7PdstZwVOL7QFzvkzVh8jvmH28fY6ugXnmKcC4UetqOsRFmq1UYHci3xCY1PMWLTfoTE/SEBA/zrzrZOgVgLkEcezF0Gh91QvwnJ3V9oiO8N3+p6fiAeVaL6T4nED6NugcsQGVQmDP3h+8Gzsre58ychQkONP/V4Nee5i/nueHdHoEfO808mcoNYndVz4vqulgyE6Rriw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ra614evAfvJpW0nbV6AM2tpmDA2MNmKg//yR3oocGN0=;
 b=ENOcN7/zj+StGDsTT11rm6zDfiM7iIJ0jvpqx8+ul56fgdRvqA9vOM4wr3qJVYX4OzZNLDCAGG/nmfUPuV2/ZC4+iC41FUfUpe7xYcON4LzA78uTVyx+8B5TM0pltX3htyLLQvfPcULgEqWfXxMrne7W7Ii4qXhOChwJz2CYzS9sliOArFlMMvhl2HIpvNF40kcxWGs5jXVDrOIexo24iGikUZyM+krv554KD3Nok8+XOEA+1LVniXU8UOd5r28YYQXKkbcpCYO2vYGiZ2fq1NJ7lqf4g4puxn5D8vmV5YVEBm8pvS566AWAdvgCV5YMnf5ZD9u5kEFNOGGVb9ghdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ra614evAfvJpW0nbV6AM2tpmDA2MNmKg//yR3oocGN0=;
 b=RfBBNh1Mx/skG3QYPjMd1ldYp/ZGCTCdkfSXpzRMfFq6DdYBzTGV/yM2YkFQcwYLfFyU8p74Sl93tY490r7FQ+BW3N6EZ/19BQNnyKDeTKFANks5BfigclvjSyNEXd9IdWhSxMkpmIEsxIi5WlHJ45QvasKhI30WtBwXurJo9nI=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CY8PR10MB6612.namprd10.prod.outlook.com (2603:10b6:930:54::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 17:30:09 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 17:30:09 +0000
Date: Thu, 31 Oct 2024 13:30:07 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH] vma: Detect infinite loop in vma tree
Message-ID: <3g7wnnw4glxouzv7biiwcxpdwk6s37eosdfl6wb3bjhwltbzx6@qkusx2ktwt7i>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Jann Horn <jannh@google.com>
References: <20241031170138.1935115-1-Liam.Howlett@oracle.com>
 <d0174131-1fc5-46d2-af87-a42a72a31487@suse.cz>
 <2hwlqzr4zfqhv2lz5zn5jypzbdbnx6rsnwrupcnxmhkxit26x6@33b3fsjywjmq>
 <87d38ab4-215f-4981-aad1-1c1ca3708f2b@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d38ab4-215f-4981-aad1-1c1ca3708f2b@lucifer.local>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0125.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::27) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CY8PR10MB6612:EE_
X-MS-Office365-Filtering-Correlation-Id: ac79b432-cf31-441a-74ab-08dcf9d1aae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XBYt47xCbwsEIm1o2tQ7zHvF+VRKnYJGIN+RulXQH8YFvLsRFpHiyZvA8Q+Q?=
 =?us-ascii?Q?Xom84eP8tf3GW0BumMgYCgW87Xul6pYJepa/bjb12Ww2SP3lK2bKVW+BuCwC?=
 =?us-ascii?Q?6nD9Yvv9rfhHcQtzFHPd43rv+6jPGD2zdh9wfgMRSf8n5vpr/E3SeabCCUeu?=
 =?us-ascii?Q?JmiwbmSJV5G1bbZbPyr6oJvJSOBrL4Ep0wl8lJ/r5e9up2riba0akOsCdVhz?=
 =?us-ascii?Q?PC51yV5gtz5XVOBeW7MuFR7eW0c7MQhxc4xBkuiNGfljS6SF4i0eNnSw7a7m?=
 =?us-ascii?Q?jXySVM8pFlZhxj9637Ax/m8IAmYzuwx59H0Lf6JgzncGzosv3E7Pcj+wAl58?=
 =?us-ascii?Q?KTxCF7Jdogu10o1com47GDAIEuvmlGomVrmk0xJI8z/+2K4McQR/BibrKeLl?=
 =?us-ascii?Q?Jib84mySNcRTduMspCpwnD+MWR3ZF03aL673Tlv6LBjIcTDOctl6WU0KFGgw?=
 =?us-ascii?Q?1tQfM6eM1jVppZueR363716bvJ4LRCC4nayX71p3vrpK3PPJMtxI7sRfxKJF?=
 =?us-ascii?Q?FSycJD5b4D1m/cdl7K8ylSl7fhoGGpTH8NUGtSWmMW9dsSdAvr1o6cxZEFzg?=
 =?us-ascii?Q?HeQlJUeG2hG7qm1utlYhLw916mbYisNrf2ET3P1LtXS8n4t5ulE0B1BEMW+9?=
 =?us-ascii?Q?LaeTCIEsRD/3QZ1NFdp3BfLr4olIouZCVau3EYhS4FiPqLY8j8LGgqpMNtXh?=
 =?us-ascii?Q?DgO8xfeSEYrQYCMJ6wdB6igJVlw+X3GujEFiD5hS/6zsG7iT5xNNc5Z32sR0?=
 =?us-ascii?Q?rgAQx3V/E7Qig+a7yhWT0ELfIT3YBRgKurx1jZYOXZve5kKQXqdlru7aq24Z?=
 =?us-ascii?Q?or/U1NYyOS/roFCc336CXgAzWh2KsG7l1pwIZCjdGpXaHYsvIaQbblMzKm7Q?=
 =?us-ascii?Q?SGzkJlCmlQ4e7wNIeR93P941TdV82C754m0Qr3zi7Wh55PlqTSMgWx3n0aGO?=
 =?us-ascii?Q?Uv/FDJZyJQ4VYtMU+Yqqb8mWbd9+nPwyBtQtV0HfX/+iP7yuIEfi5dA7TR7U?=
 =?us-ascii?Q?vJrYPtdZK13TTPPp7r+9H6h2GRDG3JupmJlG5BaCYDC0GILI+OGLSXWfR6T0?=
 =?us-ascii?Q?gImYwu8r9EhIXkkB+kLRhgUd2LRdGPt29JuqJ8/CeHhj/Z2L5xt5BqlIl5PH?=
 =?us-ascii?Q?m9IOZI/FKcoval6JEgUgkuYSzlcqRj8wG0ABMAFbeUmDeXB9oa7NdcAwAuOE?=
 =?us-ascii?Q?jRJmHXW3rCjXI/Sv9Lm68lDUvJ3L4ejk48uIFJGq55/hEMAOhPu+1aRLmP+/?=
 =?us-ascii?Q?xHrr8qXg1XD+MNf2r08Db20UUWf3J2+Tav0eqaWFOArdc0Jt3UkGxX9bPgOB?=
 =?us-ascii?Q?mEKaEIi4Z0ihoQYv6/NbwuT+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KJCOogfztp/NevykN3rzSk/ngomDN/IRhYMVStHsLtlVTfUMEmG01LVZwufd?=
 =?us-ascii?Q?H7Foli/2hpWyerSWLuS0XkSApSYIN0JjbssXNQ/12PC7Mt+dRAwEAhZBum8C?=
 =?us-ascii?Q?R61ihTdIrUeI4570azJ/0d2DACXxEFCrxQz5PfrsukEQ1b83tIcTuhSQ7YSn?=
 =?us-ascii?Q?bfK9JcACQrkAzH1pMQvo7LBcOsKlBrLugcryCgsO6/FsMqfhK+KGNZDlxjRB?=
 =?us-ascii?Q?Prv90pDSTk+HFKGBpSPfFVSfMIRD2X+GF8IgDz20vlPIHa4zsE/y8PFEBz7b?=
 =?us-ascii?Q?ZCMb/Om62exwsbrpwCMTiDy0hQI/a3HIYIGH8WNhf+NGyiw52iInBEgYfPLw?=
 =?us-ascii?Q?PVLgJ9L0PWqzA89e78sjt8Qh6vGQ4jAW+4gb1iZNzzQfgUHe4hNhVACiWNm2?=
 =?us-ascii?Q?AmZPhMmRmDT6NC0BiXPglAkHC0v/nWK552eW8EW41/FWEKZDstYZNoAA6+rM?=
 =?us-ascii?Q?Osx/Ef78sZnRH+vPN71+9dKujQKe1p9rKp0hrMdl28WFaVJP3ZRwrokc6BX0?=
 =?us-ascii?Q?AlYdX0X9xp6/0mSaDGa15DcDLG1GkcHYMB7/l+zZ98W8n39X5YFbOSTwnXiS?=
 =?us-ascii?Q?JoQTIeeYYuxmslunFYBQEdhfYzjliO2/ceyA136mdrtuv6e52VFPMhjqXvrq?=
 =?us-ascii?Q?y5dxMp355X58My6kpI6xRcV3DZWyepppIcPaphY0SolPRnHDh+qQ+6EYPe4Q?=
 =?us-ascii?Q?Zc/1vpR8yIu1bMHDS9rfyE9ABgVphbDG8FVeBjGWyLtJMUu0VXeIY1oGlhCi?=
 =?us-ascii?Q?DMfZweSG5ld+xvlNppTZ33dwgm1yXiZcbeCFPizljWXWNijV3zFtb2k//emL?=
 =?us-ascii?Q?4TVFoKNcfxFTtd78/qp1e/PT7oAPPYzD0/jz/MY6AtgLU+hglAPtdL7JTMHy?=
 =?us-ascii?Q?wIzlZdiOoMLzcrd4o97RGu8+bnJGShhUjrCKtzdIYlj4DX5mz96PDjrdkKZ5?=
 =?us-ascii?Q?sn+MuoG3gh4FR7FO4KJuvlAmfr9s1mLcFeDN9Tl6j2py2qWccq7En1hGiOee?=
 =?us-ascii?Q?BYKMMZ2zZyK4uPWz2uXgz5L3DPiZclf/vQjTbAdIrLxR4KQzEEo26ifBEo8y?=
 =?us-ascii?Q?yFbQCn96D2RrWVfJnSJtvCIArSEZnc+rQF/64TuzWNs8Tg+VHfJGwq624Xpf?=
 =?us-ascii?Q?Y1V/CmObc9vuEJDtiuLqZ6su9YC7JDEm0MZDEB1g4/CC2vH+ayBPKrqHoINy?=
 =?us-ascii?Q?KvuuJscCKzn8qMYmm32I4t2RgJosKryCA/cIFshOM4oZrpZKuySbjDh8+5vs?=
 =?us-ascii?Q?YJT5dwt+rlimgaqbpGCseMk5+lYF0SdJSeHn9z/r/CLH4biuFJzzE2m8MsUv?=
 =?us-ascii?Q?gxg7asVg1erm4O4BIXmeHNZeYPvKTmFJQLoShzFqHOSdrtHVvKCbZXNcG25J?=
 =?us-ascii?Q?yn5wCz66sa50eSYuSuveqpTWqbFRoLH64Q714+JsvpoewoG4wNmVqCfDaih9?=
 =?us-ascii?Q?0cM5s1C77xQMBdR65y5DBU05igfFD3JQHbSHYM4wHzKAVKEvv4r0g9Ou4eJa?=
 =?us-ascii?Q?EIUzg7tOYe4ZTwHg3x00A0sV3Vu+pzJxxnsw+lSbRRJ1iHl+CX8VHXeFQi7U?=
 =?us-ascii?Q?MG48LV6gRvryUscRyBQBWC4Il+1KRXSmkQN5E5Ek?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qHhbzu8W+XhY1DVPCZ4evLO4ky4e9eJGAlbN0CNNJ2WId3TGhddBPpM2qgBOSz+aLKb9SfXIJ9nNoZEaETqSLh3UgMNMAdeEgwJnsEbI1GJnWwrogyP/6lK1xdzcyri2Am7ayiXKTrEhmXqCCe3SST0WO/NGxOB0o/HbTKY3FKOh2ErGdOoX/B/QEsXQh+8ncFj9LT+exNC70i0ZL/czKRwGDZO1N7augtrYwItf0NrIdOSuLQVo2dSOwqDYv9hu5zPVk3u1L8b0RvYiwvDkLW+KataLLhOQdaTcWOHTPBfWUTG8inqsvRPPVbIiIDfSma9BIz7ovXtOgw4HgeV9KYBAa9JFK6Z8WARjnWO7/4Tla/68WdAIwO5jFb+H29C2Wtav44WLAI5tMUB+jAZM08PeEwO7hXcZ7eZW1zEfud5QaR1pu7R+gc/8uJfgyShbqgF4JsWsSId1gyI4D83cj4TKJFKOSWPdI8pFB0HCOn1BHXnWfdg/peo1UFrLTOlbAiUDY9AqVKPSJynBhrT1y+8QNjexorNPoAZE99GT8ChZQ5pCLhShj/rXDMPkIez3Z+OUkf1OhZZdlBN6MG+XIaHzd04qwC2OiecOC/DXofY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac79b432-cf31-441a-74ab-08dcf9d1aae8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 17:30:09.2536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jEAXqVvxzhEcO8fY3RwqqvaQBXHyFRtd8mSENaVgSl/V1WwkpcooTxzLJN2R/4NIaTfkji9CJr+Z3Mdw9029Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6612
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-31_08,2024-10-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410310132
X-Proofpoint-GUID: 6VF09up-3h3MPpZVqxYLazoECVXnQYmT
X-Proofpoint-ORIG-GUID: 6VF09up-3h3MPpZVqxYLazoECVXnQYmT

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241031 13:22]:
> On Thu, Oct 31, 2024 at 01:13:28PM -0400, Liam R. Howlett wrote:
> > * Vlastimil Babka <vbabka@suse.cz> [241031 13:07]:
> > > On 10/31/24 18:01, Liam R. Howlett wrote:
> > > > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> > > >
> > > > There have been no reported infinite loops in the tree, but checking the
> > > > detection of an infinite loop during validation is simple enough.  Add
> > > > the detection to the validate_mm() function so that error reports are
> > > > clear and don't just report stalls.
> > > >
> > > > This does not protect against internal maple tree issues, but it does
> > > > detect too many vmas being returned from the tree.
> > > >
> > > > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > > > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > Cc: Vlastimil Babka <vbabka@suse.cz>
> > > > Cc: Jann Horn <jannh@google.com>
> > > > ---
> > > >  mm/vma.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/mm/vma.c b/mm/vma.c
> > > > index 68138e8c153e..60ed8cc187ad 100644
> > > > --- a/mm/vma.c
> > > > +++ b/mm/vma.c
> > > > @@ -615,7 +615,8 @@ void validate_mm(struct mm_struct *mm)
> > > >  			anon_vma_unlock_read(anon_vma);
> > > >  		}
> > > >  #endif
> > > > -		i++;
> > > > +		if (++i > mm->map_count)
> > > > +			break;
> > >
> > > Would it make sense to allow some slack so that the error below can
> > > distinguish better between off-by-one/few error from a complete corruption?
> > >
> > > And in that case assign some special value to "i" (-1?) to make it clear
> > > this was triggered?
> >
> > Yes, probably.  10 would be plenty.  In recent memory I cannot think of
> > an example that we exceeded 7 munmap()'s in a single operation -
> > although it is easily possible to do.
> >
> > I like the idea of -1 too, at least someone would come to inspect where
> > it came from at that point.
> 
> Hm this feels a little arbitrary though... I mean can we race with
> map_count at this point or is everything locked down such that no munmaps()
> can happen?
> 
> Otherwise it feels a bit whack-a-mole.
> 
> I agree with Vlastimil though it'd be nice to sort of differentiate, but if
> we _absolutely can only iterate mm->map_count times_ here, it might be
> worth letting a few more go, then in the next bit of code...

this is done under the write lock, otherwise it would vary already.

> 
> >
> > >
> > > >  	}
> > > >  	if (i != mm->map_count) {
> > > >  		pr_emerg("map_count %d vma iterator %d\n", mm->map_count, i);
> > >
> 
> ...here which does indeed imply that i literally cannot be anything but
> mm->map_count, I mean I guess we already get to see here how far off we
> are.
> 
> So yeah something like letting it go 10 more times (maybe like #define
> UNUSUALLY_BAD_CORRUPTION_COUNT 10 or something I don't know naming is hard)
> just so we can pick that out would be nice.
> 
> But I do like the general idea here though!

This may not ever produce anything - if we are in the maple tree code
and never reaching a leaf to return anything then we will still loop
forever.  But it is something that is easy enough to detect and stop -
which may make a syzbot report a bit easier to swallow.




