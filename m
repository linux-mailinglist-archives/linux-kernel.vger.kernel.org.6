Return-Path: <linux-kernel+bounces-378284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 529CC9ACD94
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C865281964
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7511E2836;
	Wed, 23 Oct 2024 14:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ErQlEb4C";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u186WXRe"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C74C1C9DD3
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729694539; cv=fail; b=GB1yINYUqR6yOA9mI8bTwxruVQtI6HeR5uf1VwWYl6HLpObAr/q3ltIjVFhQLolYJ4A+32hY+Vsd9bjRP4rIdln9oE7AKgqUj/e9ztfdz4Ks4SGf/zEFz55SAQYa6xSxnv8Ye5+jMj8zveGAOI+mZQ2+GExPMoIlSlP2UmtcioE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729694539; c=relaxed/simple;
	bh=Xves6otuj4fT9EGWLoIgzPb2N0THI0sk899YXycAfXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C1s9YMma42r4CXSBbf7G87+YW4IbLNCI8veZZMN+JsYsuAAd06kc4CWYshJ25oE2rqfgkqvLtWhKi312s4gAb83fjWGwou5Q8Jfip5cu8cM4cghSKty5fitjGRiVg7j9NWfJxnxeh8wt5OcbTYpQH3futK/0Vargq/3j6sDvPRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ErQlEb4C; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u186WXRe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NEfgEc021391;
	Wed, 23 Oct 2024 14:42:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=C4+HHrzxOQtNH7W1Xt
	UdE6gmNINvRnvEI09BUjlNnQs=; b=ErQlEb4CphFsuUqNbbFgh/JYd66sdoq54e
	Jr2hk+vW48AC1R5mxWQcVZlffNCIkeStOpGAXo+t1MX1cTP7wEr3mUV9Zlloc3yS
	Q4Qrnen+yrJMNGujgPgoV367uwkA47ILW2e2FPqw5+ff8X4v6i8O/LycwhY/pDdR
	pgAJ3Gv6Nnqjnaqw6DRWrrBPdobIIDHEKlrv8OZL7k+NBIKQuy/D38rKsyA4OaIi
	JYhfp+5Uzmsvyqefvvv5Vd0INy4T5ZJefc1Q0KsnSRMn6X1Phol+pxyEYoCl596c
	V6/w4kwRsOyS8bXDp8YuBA9u5vd/rt4UWKjsihYooE8ROsPJUxjg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55eg6yt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 14:42:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NE2285027408;
	Wed, 23 Oct 2024 14:42:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emh2wy05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 14:42:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQOY2IpRbHTkNs4ZRMX20eXru6tw69ALqqUzhMFxnsIIkuPDvLNgY0CZ9DPPpIDJUNXecJmfblvqD0Izg50mc1VotDUwngREIzop10HAIfnNQtTfRWc+YUDz8FkNizgu7J8LAm07NMM+6RaAiA0wIARtx6Jy4KttgloNdotl6X3WOeFtpmAcoaBNgqNrigKQE4Usr/CyiLsKqMWnzQfhVG83gfzXQfMpkWbFZwF71pe/lJSHpLIkVAXKF6XPOOLDY6XGLgJAHymyb2OamqEQcUqR2QjkQLE6j2+LugPIR5NP5Tx+dRhVcTlMZes6qT73iPBDDIY4HFR6NufYEfPcvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4+HHrzxOQtNH7W1XtUdE6gmNINvRnvEI09BUjlNnQs=;
 b=HnqtrIhWX5WI02rqs6dvviKLQvZagiLOl48Vzpt0invN/cINmh2cXWwN1pNH1rCB+1IBtarbmd2UmfYSU/xY8Kmj9aLma14wpNZrBoRlkfMdcXdgdKj/QAKSm30IAuKqv4uXkgNRKe6zLzRs2WGU5TIUqe4HDBVQuv2rxIXaaBpSjURf14rsytckQFE4C1MOgMO8WDPua+XV17uhvAA0CL9iZ6MaYnSI7trL5C81NDWgyYqpvj0WtEUwjBxwK5oJFOjNnvVSp2nXsSB3veLHYiaOy0N/vBmFeeYKn3C2esBsTQPbh8Kh8uoUf/HfwBOTs8XKzsDIZqBH+FZu5GKdnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4+HHrzxOQtNH7W1XtUdE6gmNINvRnvEI09BUjlNnQs=;
 b=u186WXReBBmUpObIDNPMtXkd5P9ataC+3Nair0/wZH/wAl/w4MyXCgSDA6ZBhOezxgPVnVLpKeQlBXHv3GiWCoYk02SVMgH9LLJK5gggpJDfULiFxTT+41adQFaJAoO0gurzIlqIRAG9FSJBzXUPl6/4zDzBCQDg735OsRC4A04=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by MW5PR10MB5806.namprd10.prod.outlook.com (2603:10b6:303:193::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 14:42:00 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 14:41:59 +0000
Date: Wed, 23 Oct 2024 10:41:57 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH hotfix 6.12 2/8] mm: unconditionally close VMAs on error
Message-ID: <7gssykgsibgeaz3qivq3qrwciff6k7qkafsugwnmlc5vxjgbwe@7uwypnam6lp4>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
 <9a84bad9fdebbdb0adca2b5b43ed63afceb5bacc.1729628198.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a84bad9fdebbdb0adca2b5b43ed63afceb5bacc.1729628198.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0164.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::6) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|MW5PR10MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f52fd92-71cf-42ef-9d6d-08dcf370d99d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iNqPCN8FCTe4itiv0Qb5q2FNskQFyN20WgEbFtfVtASLwM9ShQ7lL0VtWEAk?=
 =?us-ascii?Q?IwOKzqcBy6+n4sn5y5RMD5chwadS3XfpJOl7uAOMtwBGBQXYsbrPf1T90Axa?=
 =?us-ascii?Q?rTNmtsboe26glaQ9OpPluJZwvMi2GRn06+l/OKtGEUClfanPh2/JkDXhSSG1?=
 =?us-ascii?Q?KXpBQazEWxUaND6jq+s75zoUV9VY4VT6Pdl3Q7nDyyTjiP5ytq8jgnfUwDn6?=
 =?us-ascii?Q?Df2Oka8QaFDMfxnbEKt8oN6Jhe8svku0NasoLdWng0ukkRoZyjb6Eyf83604?=
 =?us-ascii?Q?WQFPbJto2aQ4LqX7PzxiKelPgctPDenqLr+cAd1pdmOzXLGab7Ek+3NNDR8m?=
 =?us-ascii?Q?PVuMEVbC3C7z5ghxJ7m7tFGkuiShbf1Uk9gurcKOtQ66U0O99ldo9PHbpzQI?=
 =?us-ascii?Q?bpEiJ/H5rIdLJrQOtOlnKuhe8BjjZ17scHPaTdpu0mfRhVj4AP2hJH+p1ssG?=
 =?us-ascii?Q?//4qXMSz/7VIju2wjo58x6W4NgUH90836gXSA2Ii+4FuxYJAk7upDubsKm9/?=
 =?us-ascii?Q?yT0203t9sb2nOdUf3mXL//uAFvDU4UdQrb+d1ckYpDv3gkzQZBGntA0stZvN?=
 =?us-ascii?Q?t7NwXASD98itzLKW2SBa4KmjpjijXdL9sBy4mZDjCMTTJqlE5K7/olXghZql?=
 =?us-ascii?Q?zAjNz+VpYw7ngRrftSy78JLdkU4xO070SJuOG7GMSnbFz86/f5679CtpY3uA?=
 =?us-ascii?Q?5O84i5gytGzR/tBY/ToxgZ0j2SVDBrBy+UwPaQzFjsQ5iGbbcjTnLzk4ZNq8?=
 =?us-ascii?Q?L66BuBJcnSX/PW8ZNwwiPtPov9FIG+Fe9juDu/zDdc6rQZ7SECANxzDnloWU?=
 =?us-ascii?Q?BsHhK4ajYKgkAt2F2lf7lhw25JdKA8uty7HTbf6+tqZjKA6gpuw5zRa8FTsz?=
 =?us-ascii?Q?iIjmT1bMao4d5zUFaNwknXy+Kp/h38Qsk1diGDI6PtNCyyUV+gZy2z+jlhGh?=
 =?us-ascii?Q?JS7zsnEjjNXMbgKOA8JAAo4xk8o6cZgn1hbMTqE1fNWifZdF3BkqX2vtWwCa?=
 =?us-ascii?Q?kfksSOvLDYsYxQ+RS0tuayY/hOCqQ5q/09oAxAHRjx9qDjCF3DOZJZxac0z3?=
 =?us-ascii?Q?+uBnaxw3hKvKVhnHWUpKyusNQx9BT+CKpAQ628412htOq4Jtk7p7fp5Td996?=
 =?us-ascii?Q?WJYlxkXoQw6Csk1c+7p+dRE9LIphP7YTlyZNVmzGhUMOIgkKOW6Ys2xiZ/d+?=
 =?us-ascii?Q?AYAjSM9D2hME4mrrxfHEdM+BH0PLho9pkiZL0aLlkQakXuyAsgW5p+qukiOe?=
 =?us-ascii?Q?5TKPr7x0LIc82fuG0pgrgECRufIXBzqMrqZMMkDQI2xjjvh8mu+ljobsmmUB?=
 =?us-ascii?Q?INtqX0tPOSslslRPD5ERDdV2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e+zB6qHHxCBOy3NBB8Rn5yp8FRHnNfvb3QOfshTO1NQA5X16vQQBgi6FD0SZ?=
 =?us-ascii?Q?MUZ1RGmCtv3Cua9LCvkUIgV8+jA8eiOZyMiR/k3hZ7wjfiS+HhUg7/ghHJi7?=
 =?us-ascii?Q?R+S7WZlyXGFJAZ+78FCZkzpHxZxg7mynUFXpXnSfwyi2HYYF4+xb/6JXx6Ce?=
 =?us-ascii?Q?HxXmJbPMiix7l4FPSqPiDnQbFqf4iDr5af5PeBpV/Eu+H0T86JIDoG5Q64Ev?=
 =?us-ascii?Q?6bLRNDmvfPE5+wJRQil45BbqtjE2bKQ/cJ2HXdg4JYCHVodTXrEthA6UWGFQ?=
 =?us-ascii?Q?lYzIa32Jt1Y7KUx2CW7hZjb2EPEpJVgFCEHrFhwbyoXGfwiVkTv9YTRndcbc?=
 =?us-ascii?Q?sQ8exTdCAJOJXtExFQu3ln4OWpg22C8ZOSx6LiqZW5XCSbk5gnayPlNcXf6V?=
 =?us-ascii?Q?J5Zd4qyrXbDL/3+omufNUNvU/AzsUivll6u+zrKRVm0eV12pSYXZDCj/o5+9?=
 =?us-ascii?Q?jnYqk2G0ZCym+hSJ4koZlNJvJBv8dQaggZnbMV6xPr0p/ongwMQTgrhUxkyu?=
 =?us-ascii?Q?XHAVRmsx/HUWnPL1+T+CDKk2Mj8OkRVVTT3h9vguvtX95+p+ISy1ZETeS8P4?=
 =?us-ascii?Q?Cd2a8RbHOtjsLg+JaIr4kFw297jCu5npa/rkilxWG4AstUTwtqub1PsWbmXK?=
 =?us-ascii?Q?0XxB4tE0e8q7HiLTHb4IM9WMjpInH02gXlvXnwvg1JwRk6kiMPCW69OcH7Pu?=
 =?us-ascii?Q?v4E2HelvZDZ+ZjRYI4migaBTMO174SA0P3NiuXuDMnDsyTAOEAtx8D4eVXGc?=
 =?us-ascii?Q?ZCiA4hIEC/isqpxfQGDGtpPwbp7xCI6pez8tr97OgwZ4xdfYDgzlD+kP5Ue4?=
 =?us-ascii?Q?fJs2leZN5pLew66EGzD6dQFfl5In87PLG/tgKGfibqhxlviVFRoND9HPyhf/?=
 =?us-ascii?Q?UVejmBuZfUU/hmTgOtFhd58EZr8vba1RbJp7HZNdz+udj3O6fwV/qlNT7jjU?=
 =?us-ascii?Q?nvtnSVq5+JX3V5qqj0zGkRvvCuad5ZVvcAuDteVvQal/N+2TRigw/5KHqvXa?=
 =?us-ascii?Q?u4P94vDnOm8zgR++8V1KRAb4Os/j9Tvep7J2J5sgfqY9chblL8VycedKWNZj?=
 =?us-ascii?Q?qkQda3xdZOGotOiO6NoZCjyD/U3HLx0E1ikC7UknQ/qo0BD1dACSzrmMEzLx?=
 =?us-ascii?Q?5rQMbUUDzotRF2RIFtuLoEp6tIqMsR0knQmoq6+bNMviaU65V2xL209H932G?=
 =?us-ascii?Q?/zpF2k8cL8bRFU0++e7fBGqTK1r53A7DUokqL9gsQr2eoAcL7rGTbfBXBRm6?=
 =?us-ascii?Q?M5BGHq/GtNjYY7Il0jxeXF6zo8v3EoVz4fe8jLgQ36sOYlVB5gcGF0GaVbSa?=
 =?us-ascii?Q?2Ts+1fxWXBb4Mdf1r8LGaMtIX9Xg48CFqPQIq4KlQ8uGOMlP2cIdf5Q4xgK6?=
 =?us-ascii?Q?9F2KaMQwRW8Ok/lbyIfOqYz0t32RB2prukyaBZG9ugfoHV4JORkkUUA5ekED?=
 =?us-ascii?Q?cYaVhGTT6QekyF5p4IHTC8QOs+AQAWlouAmMHhH0vXaUvDJnnodv7WauDH55?=
 =?us-ascii?Q?vRYjKAQHzrmm8PyKsI7JIpCLGU9KVY6TvJFV2bDO1sumt1UpiRwJ/CI3msDI?=
 =?us-ascii?Q?eTcM/Fg/CRH0RC6KGmw+/ee65nNOMZdB5lnu7x0goFi8zj4luhwGY3v+9BHU?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FTCFn0/XGQC//In6U15EF0qUWYOaTuTdZ2lmadGqTA0UmofTk9TglMiMk5gkjiCx/gWYsOVCo6j1YuLUFc77HpKztggGqiz229YHi0baewjRoLSpFCfaHJrECrKg5cWZrv1qruFWzicz5VXdFM9VcMU3GvfEMSur+bm05M1b+zzp5n4/AgfUusu3r0J0KEtaGtP/3Vd9QBJwk7hn5nPtd+pB9IsIriSQsiaWR1JiC7hwKWGQyB/THHelU0dLkeAiCxNOjgDtzilsjusIrDtqMhiyolIDMOu2hmvlBTeaFrrrTFQvRLf97AmnMstjUz0LEfNQLxi9+X1uv2dB6Uo/ec4g4Fg2mtw7VXw9b67c811lzW3DqkZHghqol2dAnDCwfzf8lUsi151MB8l7hBby2jFbP2jPVKPbWKiaJJZQ/UDH+EkyetJ/aGTt04ARZZghlTbTpRzvsu1Gl9C4oqtGYhAvp008x/1prw+wEmM2BM2No+7ZcCOKiP844AgJGv66LkfTsZzaygoOuKi7uSgT34uIuQf6w45+sXHRuBMcU0FPM1YVVjF47eeQ/7eLIZThl1F71uz0FTgQXJZMtfTW7Say1tO0Fp+bcylgHZGcNUM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f52fd92-71cf-42ef-9d6d-08dcf370d99d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 14:41:59.4245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fJmrZ9mqOKYkEhY/SoWueY0BE1Q8DEg9wdtsxqNILFu6eMzVYV9c138jtHIQFfZ+DbNygI46BNjayJfenAO8lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5806
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_12,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230088
X-Proofpoint-ORIG-GUID: pw5MFctMItjEPQ3-HlafZU96Qe08KNMK
X-Proofpoint-GUID: pw5MFctMItjEPQ3-HlafZU96Qe08KNMK

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241022 16:41]:
> Incorrect invocation of VMA callbacks when the VMA is no longer in a
> consistent state is bug prone and risky to perform.
> 
> With regards to the important vm_ops->close() callback We have gone to
> great lengths to try to track whether or not we ought to close VMAs.
> 
> Rather than doing so and risking making a mistake somewhere, instead
> unconditionally close and reset vma->vm_ops to an empty dummy operations
> set with a NULL .close operator.
> 
> We introduce a new function to do so - vma_close() - and simplify existing
> vms logic which tracked whether we needed to close or not.
> 
> This simplifies the logic, avoids incorrect double-calling of the .close()
> callback and allows us to update error paths to simply call vma_close()
> unconditionally - making VMA closure idempotent.
> 
> Reported-by: Jann Horn <jannh@google.com>
> Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  mm/internal.h | 17 +++++++++++++++++
>  mm/mmap.c     |  5 ++---
>  mm/nommu.c    |  3 +--
>  mm/vma.c      | 14 +++++---------
>  mm/vma.h      |  4 +---
>  5 files changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index af032e76dfd4..3a45cc592fd0 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -135,6 +135,23 @@ static inline int mmap_file(struct file *file, struct vm_area_struct *vma)
>  	return err;
>  }
> 
> +/*
> + * Unconditionally close the VMA if it has a close hook and prevent hooks from
> + * being invoked after close. VMA hooks are mutated.
> + */
> +static inline void vma_close(struct vm_area_struct *vma)
> +{
> +	if (vma->vm_ops && vma->vm_ops->close) {
> +		vma->vm_ops->close(vma);
> +
> +		/*
> +		 * The mapping is in an inconsistent state, and no further hooks
> +		 * may be invoked upon it.
> +		 */
> +		vma->vm_ops = &vma_dummy_vm_ops;
> +	}
> +}
> +
>  #ifdef CONFIG_MMU
> 
>  /* Flags for folio_pte_batch(). */
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 10f4ccaf491b..d55c58e99a54 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1576,8 +1576,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	return addr;
> 
>  close_and_free_vma:
> -	if (file && !vms.closed_vm_ops && vma->vm_ops && vma->vm_ops->close)
> -		vma->vm_ops->close(vma);
> +	vma_close(vma);
> 
>  	if (file || vma->vm_file) {
>  unmap_and_free_vma:
> @@ -1937,7 +1936,7 @@ void exit_mmap(struct mm_struct *mm)
>  	do {
>  		if (vma->vm_flags & VM_ACCOUNT)
>  			nr_accounted += vma_pages(vma);
> -		remove_vma(vma, /* unreachable = */ true, /* closed = */ false);
> +		remove_vma(vma, /* unreachable = */ true);
>  		count++;
>  		cond_resched();
>  		vma = vma_next(&vmi);
> diff --git a/mm/nommu.c b/mm/nommu.c
> index f9ccc02458ec..635d028d647b 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -589,8 +589,7 @@ static int delete_vma_from_mm(struct vm_area_struct *vma)
>   */
>  static void delete_vma(struct mm_struct *mm, struct vm_area_struct *vma)
>  {
> -	if (vma->vm_ops && vma->vm_ops->close)
> -		vma->vm_ops->close(vma);
> +	vma_close(vma);
>  	if (vma->vm_file)
>  		fput(vma->vm_file);
>  	put_nommu_region(vma->vm_region);
> diff --git a/mm/vma.c b/mm/vma.c
> index 3c5a80876725..bb7cfa2dc282 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -323,11 +323,10 @@ static bool can_vma_merge_right(struct vma_merge_struct *vmg,
>  /*
>   * Close a vm structure and free it.
>   */
> -void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed)
> +void remove_vma(struct vm_area_struct *vma, bool unreachable)
>  {
>  	might_sleep();
> -	if (!closed && vma->vm_ops && vma->vm_ops->close)
> -		vma->vm_ops->close(vma);
> +	vma_close(vma);
>  	if (vma->vm_file)
>  		fput(vma->vm_file);
>  	mpol_put(vma_policy(vma));
> @@ -1115,9 +1114,7 @@ void vms_clean_up_area(struct vma_munmap_struct *vms,
>  	vms_clear_ptes(vms, mas_detach, true);
>  	mas_set(mas_detach, 0);
>  	mas_for_each(mas_detach, vma, ULONG_MAX)
> -		if (vma->vm_ops && vma->vm_ops->close)
> -			vma->vm_ops->close(vma);
> -	vms->closed_vm_ops = true;
> +		vma_close(vma);
>  }
> 
>  /*
> @@ -1160,7 +1157,7 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
>  	/* Remove and clean up vmas */
>  	mas_set(mas_detach, 0);
>  	mas_for_each(mas_detach, vma, ULONG_MAX)
> -		remove_vma(vma, /* = */ false, vms->closed_vm_ops);
> +		remove_vma(vma, /* unreachable = */ false);
> 
>  	vm_unacct_memory(vms->nr_accounted);
>  	validate_mm(mm);
> @@ -1684,8 +1681,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
>  	return new_vma;
> 
>  out_vma_link:
> -	if (new_vma->vm_ops && new_vma->vm_ops->close)
> -		new_vma->vm_ops->close(new_vma);
> +	vma_close(new_vma);
> 
>  	if (new_vma->vm_file)
>  		fput(new_vma->vm_file);
> diff --git a/mm/vma.h b/mm/vma.h
> index 55457cb68200..75558b5e9c8c 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -42,7 +42,6 @@ struct vma_munmap_struct {
>  	int vma_count;                  /* Number of vmas that will be removed */
>  	bool unlock;                    /* Unlock after the munmap */
>  	bool clear_ptes;                /* If there are outstanding PTE to be cleared */
> -	bool closed_vm_ops;		/* call_mmap() was encountered, so vmas may be closed */
>  	/* 1 byte hole */
>  	unsigned long nr_pages;         /* Number of pages being removed */
>  	unsigned long locked_vm;        /* Number of locked pages */
> @@ -198,7 +197,6 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
>  	vms->unmap_start = FIRST_USER_ADDRESS;
>  	vms->unmap_end = USER_PGTABLES_CEILING;
>  	vms->clear_ptes = false;
> -	vms->closed_vm_ops = false;
>  }
>  #endif
> 
> @@ -269,7 +267,7 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
>  		  unsigned long start, size_t len, struct list_head *uf,
>  		  bool unlock);
> 
> -void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed);
> +void remove_vma(struct vm_area_struct *vma, bool unreachable);
> 
>  void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
>  		struct vm_area_struct *prev, struct vm_area_struct *next);
> --
> 2.47.0

