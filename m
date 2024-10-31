Return-Path: <linux-kernel+bounces-390980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1269B80D1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A3A61C21C5F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD611BD4FB;
	Thu, 31 Oct 2024 17:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TtyCC9TM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IQNymyNY"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC8C1BDA87
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730394297; cv=fail; b=HKzNM1VpA9SgAaQgj6CSmPgF+gnsnnqiSIrP3erUIK9k+747GImg5fz8cRAHcjlRNySNGPeSxik7xceLCWF9lONzYeIU754JPk0a5Ig4+474u8+KCoi0PMeqXFOvvgB0lZMxyU3rOhujRPmwVZdt2N9g2s7ZttPfIokHdn7s150=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730394297; c=relaxed/simple;
	bh=uUEpOl+Zy0NJkt1OTg3cuL8Uz0TAWBmvVSknaEQQzNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ibKmsZ08MN1symoE9jkXFb0EiIuTmJq4WdO+L507Ua+ZChPBC3kRzBrAvFMkmJ3S7xOr/0egx1QuElcfxAlH/9yIScViiZ35gI5igZ8o2LVBhXNswlk5WaxSx9Z4Y6crvIJXc4V7XqZqLgFA19TkZERD7MFLgD3zC6+XIQ2hE6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TtyCC9TM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IQNymyNY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49VGUw3L021871;
	Thu, 31 Oct 2024 17:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=U6NL+ESSHUVbV+i4fd
	XWZ2yqUGJ/1zjUMaQ02SjDrnM=; b=TtyCC9TMx1TdeRsz48MdO+hJxWpp3NA6Um
	SnGHqmjEQNlucyDjF4v03BrqEDDK107lsTh8lmaLo11aHZuJDeqVBZoFjpXVvBEq
	zriGKjj3BpYt8meaifinQ5v1uXFrCMx4lkbVK2wZr13PiKnuPuatu2xJivm21g7f
	CMqDSfZFl/mmJYOOnnmpt3ZRAdBB4SAdRztP0SJ/r465hx2AFP9RLyR82h7746Ca
	JYjBqixUOYVGliR4AvvqBr4+KFxWL51HObgHBZESNYdiFUIFs78/OawPw7mKHuDy
	4MMVSHh1LP8ogYv2UEt804tiwJlG9kkkTt1MxPXJhcVqY0wGe1lQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grc22ph8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Oct 2024 17:04:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49VGNeld034975;
	Thu, 31 Oct 2024 17:04:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hndamdrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Oct 2024 17:04:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dhXZO4QVDq14Y496u7GWh7BlBMTG+RQrfmK/Q7T/IpQdIu6AK5+THN0D4PNwjz7WXHKJ23CkX33AKlSRIO6P0nBpt7RZFkIcyX6RLPje3UfsF+4Qg6P9lgZHwg2fMXgiZlX/WzA0hO9Hx97dI7xJ3CHgm8x9O8S0YbfbHDsZW1jedmMAPCkRkJX4fxf+tyHfROfQhqqLOASswtmIyenGLfkOR9U+J1Lv+dZuM+SEoHE4uzrrLRJSxH7wtj/RFWxsTNePrHuHPHvoG4tSYUDXVSI704FDg6pOn2TGNMeg0PScccySYJLb6mJKjp7kdlWh437ceRqFZeu4PACwTnZLOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6NL+ESSHUVbV+i4fdXWZ2yqUGJ/1zjUMaQ02SjDrnM=;
 b=ccSyerac5A6d2QnZXUxdiW7VxQFWb0iZMVEPzXg685hEguPPz+PZNtaOnByRKTbk95ZmvDDH/A2n/dT7TAL5+Y4+f8Srb9MJRPByORDCEa9yCKzOLv6F1zKZ2nWJhy9MbCtDCJ3RuJBxzQzDjVnRC7qMcQAsku1Z6Z3WMmoe0ZQfcouhk73NYkPohxr2R7AJClkcjIvI852M1QKgl7zjU3WLkfbi9JaKsDAR4np/H91pMN+Y51VkUIk5AL7vPL5B59jskFQatJj3Eo0992G9bmo0UiKtmcJ1oS2KUmdRUiqPjpuau1aSkhTVbYvioU4H/tA67HiFDK3GlEM1nQLQ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6NL+ESSHUVbV+i4fdXWZ2yqUGJ/1zjUMaQ02SjDrnM=;
 b=IQNymyNYzpoi5x6hKU0zZgSjLt8uPwqtU3nnnM6RdYJP9lZsY/VcpNmSzmbc8F0ez5OTaCvS5GVglWyvrk6HgKOqtwRk2+yxGRBrTSwMQ+tAO0h9Lll3/0hUWmKdS3V1Yyg4rdNBDLtUq24sg8SA7qRHrNaQ1uf/X2Zj6HppFII=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CY8PR10MB7121.namprd10.prod.outlook.com (2603:10b6:930:73::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.18; Thu, 31 Oct
 2024 17:04:40 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 17:04:40 +0000
Date: Thu, 31 Oct 2024 13:04:38 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH] vma: Detect infinite loop in vma tree
Message-ID: <r53padg4hfieimmrwryhkhdfnzaxyeas5uau7id5iszc3ug4ps@3mm7yxoqkgzk>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
References: <20241031170138.1935115-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031170138.1935115-1-Liam.Howlett@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0062.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::17) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CY8PR10MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: e1715eef-428c-494b-0da4-08dcf9ce1ba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s3kb3YWEd+Bv3AO5VdxFZUSRyapsnKR1yFRPJisvnQxE3Po5xYgvaXCcthEw?=
 =?us-ascii?Q?+7xou9oj3ulQ8CJ0DhoU3tqGX5fl5xNuMpt8eVn8ZBlpkO1BBAnGzGM/BhfZ?=
 =?us-ascii?Q?E+9Fi/Cx7vFy95OtgsSNJBMYR0jMDr5lLs7zJifqN43GDXB1MwR1tIkZmKzJ?=
 =?us-ascii?Q?d0hcdnGqCFowByWzRJnXg3SDP8zlWUHhV87PxLcWT9DTDURpVqUh5QhXvdgT?=
 =?us-ascii?Q?5O2gD98f77+VPgdOJJpwAgPxliTt+ogMe6uD1l/gb5rcryxzhx4wF+Q7ormm?=
 =?us-ascii?Q?0ohhwfBvNoQ0w9FI98ab5vAe0SjEdn/uSMEcjkBsW402vJfojeH+CWG1/ui2?=
 =?us-ascii?Q?5kxiqIGns5brrgYFtYJ0v7g78CTc9P37wAmHarM/SlNMTJz8Zd7SI9iwA3PR?=
 =?us-ascii?Q?j/7k+6x8byJGTwZOB7XbMFoqsoSSlpMwwIla6rXPClLGlZTCOsuliWZUNb81?=
 =?us-ascii?Q?bs2JL/sb01jqL19yBQ+quzRWmDBQOZZxOcp0t1a/L1y0ias3Q8oub1A2J54/?=
 =?us-ascii?Q?ysvWWxsgI5aTXcmWTRck/I4VaWJe28LiY/CVsxMyjas4Unzgmv6c0h8U60WT?=
 =?us-ascii?Q?V8G32fcv2fWsh3tepEeyFpmeYtq8U1KczRISJd+z/yFvDGc2OS6gT+ZW3rWW?=
 =?us-ascii?Q?r3qiQ6515SyNhoXDh+HX+M7lfa1vG7Roiw7W0zxK8FLq09HptX43zCiFml4v?=
 =?us-ascii?Q?5OGRqvyZDh50Ij4QMoJU7AOycOOgo9lXCt++AR06pPdZfoSZjFwVOEM86sqf?=
 =?us-ascii?Q?19r82mMlkEwguEjkyR9MahsC4sFZpiqSg0/P2JwvGWvEsT+sluaLsWhIzQkx?=
 =?us-ascii?Q?xF5JY6aRjwH1p6sbnlAQbSe/UZ6nCb62bFdeXrW0TJl+i28/018lMkm6f7Em?=
 =?us-ascii?Q?JoBCVYmvijT9J9USCgQz2Pr1gJuJ7B39yN+j7uNpW7k6bdM0eS8mzrad87U8?=
 =?us-ascii?Q?cLnesCK9WOjUGjfTnr82mtNRrFt0eoL5Mepz8XuCz+a2zjUS+lhjXMeoQsH5?=
 =?us-ascii?Q?RMjttnZS9Q7y7mApR0lPb28PkFiC283vCXsuZYT8Kb+AvW4o9g9ZB0ZepspV?=
 =?us-ascii?Q?D1plhaKAJ79vpyedyPX2kIHFq6mdaQ896aufS4abAN7OBXXm5zsEbsGFe/Hy?=
 =?us-ascii?Q?K8AtGE3IttykdMKVxGgX4iAPdOs+eDUqfnz4g+9OLpAKd38it89d72LGGVqm?=
 =?us-ascii?Q?Bz57sTXhgBS3gsiLjIAGetWy0uJlrzBnKoEIvgICwOWHMrROz/4oxQyHapSv?=
 =?us-ascii?Q?SJdLj9cXMRb1sVEMFznfUu3cNQL2g9QnaOtj8zOK6WeYhDVwsOdMzVh3ASav?=
 =?us-ascii?Q?FU/uAc4gHNeray574vjHWyC9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?js9jKYl4Au9d+MZ+w2LJ23rX3cmlk6ldqqXp5H6GPQ6c28MTDiL9qfU1LCtE?=
 =?us-ascii?Q?KkihppoLUDZUJzEj9Byel4r7P3Can0wrPls17d2Qp4WqhLhxLPPB4KdSoC5s?=
 =?us-ascii?Q?k02nlcViTqkN3xe3K+fDoMINWiIGZ0PNa/AM4MhfEHpMannozMbaHMOU30Us?=
 =?us-ascii?Q?xq9+xtcnmQ4D45uM1+dDm4dHlKM5wJEgqBLnyL9Kq/UK834zuvIB3ts+eVf4?=
 =?us-ascii?Q?V9TDDVZVxR/6pfN147xq3VdGUWyK/n/llp5A7+Xks/fqJQ51MC4nFIAeqSqn?=
 =?us-ascii?Q?HOTOYhmL+Ojpkbh91221kDedtAN1EUHhLi1XV417ytEowmKUXjWVYeH/pHk6?=
 =?us-ascii?Q?TwJ33HPyUUn8fMuVG16pJtVrFzazpwQX7AekFJGyZF8UMKWdFcx+t5bHTcwD?=
 =?us-ascii?Q?yPvKavMebe21j+WVFVoQAvveKKyJ7ugt8TEL/p4Jb5ktgAcIQxE0yihSBHQS?=
 =?us-ascii?Q?cd21/SdcouXA6xPMWlurVlQArDx/NRk+5F07erIOsmw7MCFznrn8brxAFxJQ?=
 =?us-ascii?Q?x/5tfCaW1OPIwck9pcrtzNAT+v4GeSW9GArgniJ9B7yhIZ1L/Gu6xXlnPTB4?=
 =?us-ascii?Q?527l8nX18KOvePQ7cz42tH6/ltpYmR+Jz/O8isTTB9MscyxCt01kEUEoenle?=
 =?us-ascii?Q?SMVEFTZ2UruXcVlg1buWQzMpx/YnS6tztD0LlHkHKKi4DqU34gdzUMTMsm01?=
 =?us-ascii?Q?x3XE+1tvzvIexVDMFJ63gknvjGseCvwlxE0ujWpHrNnN2DeHoExVctsQVgeJ?=
 =?us-ascii?Q?2pqOIbL1eGuvlPipBiiF0sL/D8gvFCXowpCS0b2qZaHtWmYV7wqUO/hKlL3t?=
 =?us-ascii?Q?PpA0Edkd7OcgECLRv7S/xt2ne9J4EOFLc1r/zDL47nScDIJ9Yq2luhElWHMA?=
 =?us-ascii?Q?h7xEKTLxU5CNx7EqNJ5JQaykirbuNh4o313YRCvq1OQmp4XEDqdaMdjipjsL?=
 =?us-ascii?Q?XbYgjKN+CxpOvcUrx1rjI2xtCrSiAvLuC3vcj0gAzkllaXYIKmvnUnQNYrj7?=
 =?us-ascii?Q?To5Laawsjf4UGVhitDI2GeqS3dwO85qeTn0KjbbPE4PwqdPFOQKcIqbexAkz?=
 =?us-ascii?Q?SYu6H9EDHZCeM5XifuVjKXGYb6pMJuqOrHUxZdsP4MMLTfKTMoRRDxAqUNGP?=
 =?us-ascii?Q?cNjdZ08EQZHSenO2TSWa1qrYDQOZi1xpUwhivUrG+eKlIUwp0YmYyLcoGgWB?=
 =?us-ascii?Q?ijdneYrYWTwlz0g5SsiQA9XPh12KmYMjLqZfxO1CV1Vivbe4tY4hd3Snp9k1?=
 =?us-ascii?Q?cmXLuSluXDJ5TrX+BWB9y4b+anrzQ/0mmiCpvWDK01iGglgjK+m1KyHeLTGM?=
 =?us-ascii?Q?LhzZMbEzYfgd0QItfKZLoUM1AfDw4SmkWxQsUf1Yj1PKAkJTJJL6Pkpw7vac?=
 =?us-ascii?Q?fyH/ph1fna24PPAjKfOmf/MrA0fruwEzgm7BwrFha7p7IZTIhMKwHAdLhtbZ?=
 =?us-ascii?Q?yT/HCoqxfrOV2igcfQUi0FnpOT+Lk6VPYrVlyfCod/xDGScJK65gDpDx00Rk?=
 =?us-ascii?Q?t9dm0Cx/FMvF+zIm58YxYvhSHz/YrYXBDkJ0pWPm/54CfGwMoPiUJCEW2/F/?=
 =?us-ascii?Q?CxoP1Y8pIy1ru8ugC5vhWfaOmYWSS3YQtJNsULTs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tCFMf7pglVFNwv5GKklZdOR99/V/FwzG8doZafZEQnLwaAzMVp0PbI9DSYd1kuqdXTCqqk7ia2RmZWKR1hbq4IQeiidOLcvjUYdJS0SOR2phR8wSP4pcAhhb0qKcNPRr/NZbLokzIeCCrG2VRocu2GYeXtNLDCrdvH81BPw5Xz4oNqAg0vmKzoth2eu/OK1hXnNka6O0GHAJoa1TU0V8xZKH2sGuCeI5PvMAqw0hPEmv7diPnuUOb+0PEsn47aEXCCwcbbW8lTnhKFEq/b4sE/kTAAW0dvPCK18BlxStHKIb5+wCzammcU3ep+beVxU04xUiJzsAviAGXix2k+BTVjcgBWkV8AWIlRJ92xXXNJismE/dbF6aSJknNioNdoFkSmu6uFg9aHggm65pQtfNy/v98zmMQ2wDazGYxD8pdyemI3CcHa3n6+cDlfyJ1403show3d/rc4uv7esPMfsTKIHk6/WB+f5ObA/K+DKVnmjLqIvvJc3wC0cpDX7T4s6ReTv/tQsHkam6xCO9rZ9N0Kft88+WHQ2g87rVyd3XeM/Fjmz/pryUEMrqlxyE6T2agv38qVw0AyR1LKDB3tCFc3gGP8jB45bFRNBKVXPHylI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1715eef-428c-494b-0da4-08dcf9ce1ba0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 17:04:40.3836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v02x6GuBN4hg4srMVUEegrnJ1g5BxAh3b2qBChoLU0l0L1RdoK/aKtWS4VjZWuuZGDrhZmjs5Vmo9Ie3Nq3Qbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7121
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-31_08,2024-10-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=649
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410310129
X-Proofpoint-GUID: 3kNbNEJTHIKFOh2QnTl8SNIo8-i9myH2
X-Proofpoint-ORIG-GUID: 3kNbNEJTHIKFOh2QnTl8SNIo8-i9myH2

* Liam R. Howlett <Liam.Howlett@oracle.com> [241031 13:01]:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> There have been no reported infinite loops in the tree, but checking the
> detection of an infinite loop during validation is simple enough.  Add
> the detection to the validate_mm() function so that error reports are
> clear and don't just report stalls.
> 
> This does not protect against internal maple tree issues, but it does
> detect too many vmas being returned from the tree.

I should add:

This patch does have the downside of making the count difference less
useful (we will only see one extra as apposed to what may exist).

> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Jann Horn <jannh@google.com>
> ---
>  mm/vma.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vma.c b/mm/vma.c
> index 68138e8c153e..60ed8cc187ad 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -615,7 +615,8 @@ void validate_mm(struct mm_struct *mm)
>  			anon_vma_unlock_read(anon_vma);
>  		}
>  #endif
> -		i++;
> +		if (++i > mm->map_count)
> +			break;
>  	}
>  	if (i != mm->map_count) {
>  		pr_emerg("map_count %d vma iterator %d\n", mm->map_count, i);
> -- 
> 2.43.0
> 

