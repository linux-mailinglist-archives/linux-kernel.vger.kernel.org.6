Return-Path: <linux-kernel+bounces-349078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB79998F07F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C61284344
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6501F19B3F9;
	Thu,  3 Oct 2024 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hzXxeecW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RbT0obYk"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A9F4C70
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 13:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727962494; cv=fail; b=m/+Vep7SIq86GWTxu/YP3ojzp89JL9DDmR+xDUP1u5dBV9lOCmjUZbOyAJ/ygj9GfKAjaZshDQ2XDCVUZRp0K/FDUV9ooDx0fBmlcEEl198r2erEXgseYcRy2udKtmKHl++4xmDSjVqh1dqVP6taoxwRu9ymgalqaHxAQ5Vi3Lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727962494; c=relaxed/simple;
	bh=ennXKjYc5kzNzDM9wtJMBw0o54HuOcC9NMfPUdQ1M3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gi3gg9Zdc5xSyga+gUPgd2h4nugUKKFt3YKruOf7gjLWH/NGgf687gz2gn5efqwd+urUcJVL4HtpJlzzthHTLUtPLVSqvRargyharZrJ4Lv5RpY9xEZXmbwZTvk6siwZPTQMAhmMc6XCp7oSp9OA8aTUbJBdb78XLk70QF7IF14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hzXxeecW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RbT0obYk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 493Cthkt019370;
	Thu, 3 Oct 2024 13:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=w/+67n0Ld32uLHs
	YzcTRigQTHJOmJyzEBkNJSLK97Ok=; b=hzXxeecWiFEpfju9oWUNiw2J0Oj7ZZe
	Y3DGEnQ0AHv4vJKM5BCYxtMVkg0961pSQ92/iMDBO8rvJbtZI7NJUwEYT1kLHH6H
	nJ9FIkO7f9qayInQDWjAptnBhVQJmhLrFYCq+9tLCgTj0koifHdBNzpK9LyGLHJs
	SB2vapSnYHpp0OXpAMjiebINXRlBKJYo5wEMpEWWOQlYr+Tseirh2rp33dyPwcWc
	0lt0ZZbLQMawVONWpvq+CzCIg/MIbElcCQO4lOuDyC5tWOQpxz871DJ8z16/+Vkk
	pHg7yyhPujRsKVXiykFmy5dIRjEUJzU40keWbKIXrM77jVwiIDjb3JQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8qbc4e2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 13:34:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 493DFSld017338;
	Thu, 3 Oct 2024 13:34:44 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x88a683y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 13:34:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RyPsYBIg7EBZqyPAn+Oi2ECfO2B7aSfJkARMc45qWB3dUWzF9Lol1q3ybn9/0/3gp2VgaWItTbdUWpy++5EtjxPXg/f2aLNkzpXLu1fNUPWwRMsIyTIv6kJvJl/DanX68zWfC7lB/DiOFU3qk43Vg8euqOsy2Rq3Uh1wdm3+bxy/FUbcyxXZHmwQnXETKWd4LDfOEmE9UTuPsgm14DqqN8QFc7sRWPKZHmAE9wkjndRXcsBTt1g1wFV0Zc1gR7FIt1ZsC+dQcpzggC2Tb4+74PF45BAkiF8Qr0Nta4iYVUhQolRZqKYnxRA9/q3HjhI4258f95qwpVMS3QVKb+Ig7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/+67n0Ld32uLHsYzcTRigQTHJOmJyzEBkNJSLK97Ok=;
 b=L91T5oMKwvfjm1rSWylJgPj0o+AX+YbI4tvJNCnv34baGtSwVDfqnplnvaqPvqcPA+stYRcbR+BkcpiAcoe4SzM10L0vJPbeNG+/VMc382nBYv6doUNhGsf4wL6/WXgl8y/IAUAYutBq6eGK4/oJVTlhoRGdaXXjhM7kUI5Ou87cSTRpZFS40DiLIhTa2V5Fbvp9EWuWAhF5QdpE4dyxwFM2I3JYtpXCi0+g4oj17FFreeuBsEn+IEuPOv2xpnyfSY02vaOeb/C106dtUiEMjXdUwtOYLvOhU33u4AAM1qR73LhvZAn3LK4y+dR34aWW6+AcOMHmfh/P5blKeRGnIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/+67n0Ld32uLHsYzcTRigQTHJOmJyzEBkNJSLK97Ok=;
 b=RbT0obYkPEDXxTInQIE14yHsW/9n//lHKD4gMihvPs4E0VgGc2w6uypV5sZ6wEFi43+6WhMU/nbxFl02yRobhN25WgXAaGTneddXAwE9741HQ8YnrbcNCqAQOqJmB+vFNJvGVMjdl58xct24Rax8o8zjU9pGFIAVSiURUsgX2vs=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA1PR10MB6736.namprd10.prod.outlook.com (2603:10b6:208:42c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 13:34:41 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.017; Thu, 3 Oct 2024
 13:34:41 +0000
Date: Thu, 3 Oct 2024 14:34:36 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <bf8a73c9-a7e8-4480-8274-d58e587fbfff@lucifer.local>
References: <20241003130909.2895-1-spasswolf@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003130909.2895-1-spasswolf@web.de>
X-ClientProxiedBy: LO4P123CA0268.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::21) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA1PR10MB6736:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cf66558-46c5-489c-7a6c-08dce3b02247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5cpiQfxHft3oPbv0vMLO9cYn8ov40F6LflSqgpgRm2nT1F1Ourk/w5Thvhvo?=
 =?us-ascii?Q?BBLVLFftKGuge3qP6Z0pki33upW5lsy8Z70wUvBtLEnH0EQfrV8nClAHBalN?=
 =?us-ascii?Q?18qzzM39hdME/izBJByGWHLLRTfmmAfaEzM4s0Eafv0bHVoSlcr2wZ2Hiny3?=
 =?us-ascii?Q?eR+dTGrs+X/EhcMJTuBcWEmfRdIkQFcCKgr4mmkxbTAp93yjNSJMGndHTUit?=
 =?us-ascii?Q?twzpbjLFOZD6v2BOdG2+qTxS4wJ0mz2aryvVJSS9aKsrtFTLl3/pdFV08KzV?=
 =?us-ascii?Q?0xdKgokdGIQ0goFruDtR4Cko99Qg1hxEjn4WSc1eBZ1WNYpLT4e1GN2EC+bD?=
 =?us-ascii?Q?Ls12c/7swYNwQXX5aI6D1AxDD58dbTBxJVhP1AJztLYSJ2KJPAxL4bOOw5WY?=
 =?us-ascii?Q?PCUGnXzkP00hZa7ur4P3+GOMP17g1NC5krCvefwI64fWzeO7+llF/vz0m5g6?=
 =?us-ascii?Q?jYOTpGYAohMinsrkiRcmhVk3CrFLIiYDjcDuAfNvyDg6CXV6rMGYX6U7g2fd?=
 =?us-ascii?Q?EL13GBuzE9wlsWfAjmMFawksZ4uNjG8bK8Zx7bYMFk+BWzmIbWT/LMl3YvuH?=
 =?us-ascii?Q?OjofibY7F+QN84EzySlUA63jjhsBjtypbg0m0HVRuMDceyRz1XOz6IQffS2A?=
 =?us-ascii?Q?zADpv/N1IWCZfuJGyJtKAoCNuiNfZFAmSVWpECPfgG7VRS/oIaAjXlMDdw15?=
 =?us-ascii?Q?NB7hg/6Txahu+nuIHRhv9FfW+BRby5X+kbmyJA6jMxCBvNG9NE4YnGOLFEqi?=
 =?us-ascii?Q?mcG+W3CY596pMYlduo83soa/ktfyQSr6jv8ftT8zIzy6LLJHcAnWIJG9b1Yf?=
 =?us-ascii?Q?nd+13a6GSljJs3kKzZ5iYZqicJwQ4PZ0JpH7j0lTmZa2wxXWBsyPPOQvqcCW?=
 =?us-ascii?Q?ppW9Srpm8pP6kNQXv0RcESckinO9nEhQo0ZQGB4h8UPwlT1fwKqB4UkZZbIO?=
 =?us-ascii?Q?r/g57R/PQtFyjBqQuTcZm94SbNzpiu+/HPQN+qXbBBYlzdE79NW3jVFo+wC8?=
 =?us-ascii?Q?8DnCjjC1qOqZdgnWddo39juq8+xZbg64heHCXiGphx5KGnLjF4NDzbuGDB9s?=
 =?us-ascii?Q?bX1TFZEbBlo9z31kxq9p3SM/UZc38g+5MVadT00FVri9lO+SFOa7up02ckas?=
 =?us-ascii?Q?p9ERUtGWcWp9aOOQ5LlbyyH4lhWKgL/4ZpvtZYeQInCj0fQubZdbNfhD9YCy?=
 =?us-ascii?Q?6na7Y1qGQsGwkK3pZ/N/e8TyIwoHrjqE1RJ3yu03mP20xxBS99Lt5Yo5KBr2?=
 =?us-ascii?Q?9dfo8060Yewp97E3rJfwTGEeMuqWas27HQH17tSb/Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8Cgig6VtJvy8CfKN3x781q/QrjNGOuqfadExnX8RySsGxbYpBbUyIRQ/6p2x?=
 =?us-ascii?Q?N6Povz8Wq0ZyqnnNGoD20mV1pd5djhkp7XN39TqfV/vM547bf1vEzKvRWUou?=
 =?us-ascii?Q?Oia6aIPjNP/3Hsw1EBVXp0XMNq2FoBEKWX6SbSXg7mH1+3h1J9XS4ddBXlgj?=
 =?us-ascii?Q?R4e9hg1z62bFOu15CtPXuYbSHbouD+u9QaqqYnLF2ban8NMhXIu9pJDElP//?=
 =?us-ascii?Q?N52zXE9YzbgHk1CzmDqLu1yWe75gdbukGNX16Leln0fx7YEfdoWPE0f3XySB?=
 =?us-ascii?Q?dgOJgEncdpRE6X22jruwiw7yVJLDKoqIPGgCCAn7fSFTwDwSQvTBNEuYutMj?=
 =?us-ascii?Q?AO0EU1n9fAjaavMtvy2I2Tn7QAe5gmX3dom8fTyPEj6J2hVK1i9Qg+jN1uhf?=
 =?us-ascii?Q?amNJKqwKVeFyMD9tkqgiZ9OHxjNQHykgVIf672wJZjxhm7Yyb0U0UFuXeG3o?=
 =?us-ascii?Q?wivE4Mw4J6NqLO5zSnCF0pKqkYSy8pjOr7OhLy+UpLwgmgHD8wo0awxhtq6n?=
 =?us-ascii?Q?V9qb5DkYAlwTRsa596fUeyv5urtlx+nO/OV98ILFNNgAwttQND5Ag40YiMyV?=
 =?us-ascii?Q?d1YjSmjfgvTHpYwA5jp9y18KRuGHGGX9923grKcTmxe0ZmSpGt5xrw+gf3Zf?=
 =?us-ascii?Q?IgMVIxUwF1Gzie0MdVHYptIosYaiso5SRZscFm6GmKLshX3geF3qVq7bl8hX?=
 =?us-ascii?Q?hDTgtY7DvoG32MA7su2alAMaWGJNvFDhVcxxlOZ8UJQc1YWetAI+BP+ZmGj6?=
 =?us-ascii?Q?vistkXpvLGnDO0zk7e6wUFHgJFol8eUDfMcYJnspsyQby0bgat5+hyYPbJh+?=
 =?us-ascii?Q?Ng4wNjDjsUqy6j8UyHzKuKEmIjCnVqVCMi2mOTbMrN0Pvo+0c3TwAsnJTUbb?=
 =?us-ascii?Q?hEnogBAntS8QxeEnR6T4EuoTWQSjJmN7KLugBls7ebgtpts4zsWpdohZRUEv?=
 =?us-ascii?Q?FzH9UBKWc9PDwBTtcDDySfsmHGI7rOO8SkY3GUA+ISUw339Nu4xLcJ/3jzn3?=
 =?us-ascii?Q?mFhYqTrp9m0bdmRIBoAsBu24dUBfO+bMvx61fyGyFaHIgrj3znrIGcyd/la2?=
 =?us-ascii?Q?HFV78yB1T3ED9dHsghl7QmbjtIyYtOtsQkNdoWbccXSJfs1TIPG1/58Nr1l+?=
 =?us-ascii?Q?PlZdKg8I/Stf9ZTrgN7S8Q8cjN7+DV08Em0A0HEsm5YSe4O0n95UK78+9zub?=
 =?us-ascii?Q?hWuM52e+TZh0rYMVpN8A8CHGGNdGigf+xeXnGR3bbHD3Q9fvdO626/oAJwIm?=
 =?us-ascii?Q?4h+ibdcuA+hly+/7DQ2AuXclqJlCP8AxhEP2Cxmv3ajiCfePe25MFFyeTpZA?=
 =?us-ascii?Q?9KccHCfi5bRf4/NVpW9K19MxsFv1F4Mqc23dAO0Re9Pffjbe68+p87uOFjyS?=
 =?us-ascii?Q?geey0PLiMcY63vkfRbOjZTX2Pmwsv4UJH4zoNslNktxILatqUhKccNKrDArh?=
 =?us-ascii?Q?wubR0ejkVNgy61m4YGk/GwlctirygWiyGbfIZpcafCNSBapYQjfc7trp22PL?=
 =?us-ascii?Q?N5AFztlTbLUwL0AEfCPk5MM3CyZnrTqhYWx9hiNqH6TInBWhshJ8SepO4gav?=
 =?us-ascii?Q?Q8SabMovUynbPaxVbZABOBlUIZPEA1bXao0JpikHCck7mNVt3dqlTwu1Mkyu?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/m8jv/69v/etB4WqC5zPXxzHK/tQdBKr8T1U++7+pehYHVWlgE5iSZJ2bAMkuIjKUlHSY8S711Bs+9BO7XbNshFsgELHN3uXYuKfV62nT8dzYcPVOycsW+ND8nDZ4BBBc1KijMP2Ag2QJHw+H9TrHmjKKmiwdmtE45wLx/t61e8rvKxFg8OKvRAuL1K+zdZTLq+DsYOEhpz5zW5BnaGf3Y6Fp6WXH29miA0f5/ss+TisGAC9tImDJ1eWvcZXDQhEIAjyY6tEV5TCKFCXbBbZp6r4F2RsF1kUNjwzccd1QRpzssO7LujFav6gpF2ApnpVYlCbrKALmXigABrrZ6+qS4n6G1wCuERR1S+s5vNeafpDjmtNJ3zz0QqQzI9CRxENVch8Jr1NOkcxVPuuSjLKlpTAzdyH7y5flcPIiq1h9/j0HjMSt877hxyHZ9shUdvX8srtS9A2eZcezHTfmAKhiSPYIpJiokdfFekwPn24w8cpL8n08DkWT9E4nbUUdav2zt2CF1wZAwYoBBAQ8+MVmcbwByzI8fyYUhTKI+5HFrH1JDJUHw6G9C3vJhZVhYazEwdUp03qpzCiYBRlcBJyx97WLmIcqPELR3VHvLKsvFg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf66558-46c5-489c-7a6c-08dce3b02247
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 13:34:41.1165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7HMyBWveG0H73vHzgjpk6PJhwaLVol/IrCSh+6KRE42ICSgoJG0OPf/rJXzWr8So3CydWRDZtj/cOhikExj1dfkO8SjZUbJnYuk5e9fSis=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6736
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410030099
X-Proofpoint-GUID: LQw-QeEYkVJm-HlEZMyzjN5d1pUFSZFY
X-Proofpoint-ORIG-GUID: LQw-QeEYkVJm-HlEZMyzjN5d1pUFSZFY

On Thu, Oct 03, 2024 at 03:09:08PM +0200, Bert Karwatzki wrote:
> Here's the log procduced by this kernel:
>
> 2938bbdf68a7 (HEAD -> maple_tree_debug_2) hack: set of fix, info stuff v3
> 7e3bb072761a mm: correct error handling in mmap_region()
> 77df9e4bb222 (tag: next-20241001, origin/master, origin/HEAD, master) Add linux-next specific files for 20241001
>
> "maybe fix 3" did not work, either.

Thanks again for your continued help.

It's a stubborn problem...

At this point I am strongly suspecting an internal maple tree bug given we
are probably doing a rebalance or a split to overwrite 6 (!) VMAs we unmap
as part of this operation which is something I don't think we could have
hit before in practice.

Let's try and snapshot the maple tree state prior to the 'nuclear' event
then, and see if it's possible to reconstruct it in userland or such and
thus see if we can repro it that way.

Please apply the attached patch to the clean 1st oct next tree and let us
know the dmesg output, again hugely hugely appreciated!

Thanks, Lorenzo

----8<----
From 6bacc48b5c8b91dcde307f0c853ad1ab8948b884 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Thu, 3 Oct 2024 14:19:17 +0100
Subject: [PATCH] hack: set of info stuff v4

Try to dump the maple tree immediately prior to it exploding so we can see
how things are before/after + try to reconstruct.
---
 mm/internal.h | 15 ++++++++
 mm/mmap.c     | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 mm/vma.c      | 51 ++++++++++++++++++++++++++--
 3 files changed, 156 insertions(+), 4 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 93083bbeeefa..cd9414b4651d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1443,4 +1443,19 @@ static inline void accept_page(struct page *page)
 }
 #endif /* CONFIG_UNACCEPTED_MEMORY */

+static inline bool check_interesting(unsigned long start, unsigned long end)
+{
+	const unsigned long interesting_start = 0x1740000;
+	/* Include off-by-one on purpose.*/
+	const unsigned long interesting_end = 0x68000000 + 1;
+
+	/*  interesting_start            interesting_end
+	 *          |--------------------------|
+	 *           ============================> end
+	 *        <=============================   start
+	 */
+	return end > interesting_start && /* after or overlaps... */
+		start < interesting_end;  /* ...overlaps. */
+}
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/mmap.c b/mm/mmap.c
index dd4b35a25aeb..617fee229b3a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1341,6 +1341,18 @@ struct vm_area_struct *expand_stack(struct mm_struct *mm, unsigned long addr)
 	return vma;
 }

+static void ljs_dump(struct mm_struct *mm,
+		     unsigned long addr, unsigned long len,
+		     vm_flags_t vm_flags, bool is_unmap)
+{
+	if (!check_interesting(addr, addr + len))
+		return;
+
+	pr_err("LJS: %s mm=%p [0x%lx, 0x%lx) [vm_flags=%lu]\n",
+	       is_unmap ? "munmap" : "mmap", mm, addr, addr + len,
+		vm_flags);
+}
+
 /* do_munmap() - Wrapper function for non-maple tree aware do_munmap() calls.
  * @mm: The mm_struct
  * @start: The start address to munmap
@@ -1354,6 +1366,8 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 {
 	VMA_ITERATOR(vmi, mm, start);

+	ljs_dump(mm, start, len, 0, true);
+
 	return do_vmi_munmap(&vmi, mm, start, len, uf, false);
 }

@@ -1375,11 +1389,16 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	VMA_ITERATOR(vmi, mm, addr);
 	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);

+	ljs_dump(mm, addr, len, vm_flags, false);
+
 	vmg.file = file;
 	/* Find the first overlapping VMA */
 	vma = vma_find(&vmi, end);
 	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
 	if (vma) {
+		if (check_interesting(addr, addr + len))
+			pr_err("LJS: mm=%p About to do unmaps for vms=[%lx, %lx), addr=%lx, end=%lx\n", mm, addr, addr + len, vma_iter_addr(&vmi), vma_iter_end(&vmi));
+
 		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
 		mt_on_stack(mt_detach);
 		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
@@ -1388,8 +1407,16 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		if (error)
 			goto gather_failed;

+		vma_iter_config(&vmi, addr, end);
+
 		vmg.next = vms.next;
 		vmg.prev = vms.prev;
+
+		if (check_interesting(addr, addr + len))
+			pr_err("LJS: prev=[%lx, %lx), next=[%lx, %lx)\n",
+			       vmg.prev ? vmg.prev->vm_start : 0, vmg.prev ? vmg.prev->vm_end : 0,
+			       vmg.next ? vmg.next->vm_start : 0, vmg.next ? vmg.next->vm_end : 0);
+
 		vma = NULL;
 	} else {
 		vmg.next = vma_iter_next_rewind(&vmi, &vmg.prev);
@@ -1413,9 +1440,40 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vmg.flags = vm_flags;
 	}

+	if (check_interesting(addr, addr + len)) {
+		char *special = vm_flags & VM_SPECIAL ? "special" : "";
+		char *has_file = file ? "file-backed" : "";
+
+		pr_err("LJS: Interesting [%lx, %lx) flags=%lu, special=[%s] file=[%s] addr=%lx end=%lx\n",
+		       addr, addr+len, vm_flags, special, has_file,
+		       vma_iter_addr(&vmi), vma_iter_end(&vmi));
+	}
+
+	if (addr == 0x1b90000 && addr + len == 0x1bae000 && vm_flags == 2097264) {
+		pr_err("LJS: PRE NUCLEAR ============================>");
+
+		mt_dump(vmi.mas.tree, mt_dump_hex);
+
+		pr_err("LJS:/PRE NUCLEAR <============================");
+	}
+
 	vma = vma_merge_new_range(&vmg);
-	if (vma)
+	if (vma) {
+		if (check_interesting(addr, addr + len)) {
+			pr_err("LJS: Merged to [%lx, %lx), addr=%lx, end=%lx\n",
+			       vma->vm_start, vma->vm_end, vma_iter_addr(&vmi),
+			       vma_iter_end(&vmi));
+
+			mt_validate(&mm->mm_mt);
+
+			pr_err("LJS: Post-validate.\n");
+		}
+
 		goto expanded;
+	} else if (check_interesting(addr, addr + len)) {
+		pr_err("LJS: Failed to merge [%lx, %lx), reset...\n",
+		       addr, addr + len);
+	}
 	/*
 	 * Determine the object being mapped and call the appropriate
 	 * specific mapper. the address has already been validated, but
@@ -1441,6 +1499,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		if (error)
 			goto unmap_and_free_vma;

+		if (check_interesting(addr, addr + len)) {
+			pr_err("LJS: call_mmap() on [%lx, %lx) old_flags=%lu new_flags=%lu new range=[%lx, %lx) [CHANGED=%s]\n",
+			       addr, end, vm_flags, vma->vm_flags, vma->vm_start, vma->vm_end,
+			       vm_flags != vma->vm_flags ? "YES" : "NO");
+		}
+
 		if (vma_is_shared_maywrite(vma)) {
 			error = mapping_map_writable(file->f_mapping);
 			if (error)
@@ -1467,6 +1531,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			/* If this fails, state is reset ready for a reattempt. */
 			merge = vma_merge_new_range(&vmg);

+			if (check_interesting(addr, addr + len))
+				pr_err("LJS: flags changed for [%lx, %lx) from %lu to %lu %s\n",
+				       vma->vm_start, vma->vm_end, vm_flags, vma->vm_flags,
+				       merge ? "merged" : "");
+
 			if (merge) {
 				/*
 				 * ->mmap() can change vma->vm_file and fput
@@ -1511,9 +1580,22 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	/* Lock the VMA since it is modified after insertion into VMA tree */
 	vma_start_write(vma);
 	vma_iter_store(&vmi, vma);
+
+	if (check_interesting(addr, addr + len))
+		pr_err("LJS: mm=%p: iter store addr=%lx, end=%lx, vma=[%lx, %lx)\n",
+		       mm, vma_iter_addr(&vmi), vma_iter_end(&vmi), vma->vm_start, vma->vm_end);
+
 	mm->map_count++;
 	vma_link_file(vma);

+	if (check_interesting(addr, addr + len)) {
+		pr_err("LJS: mm=%p: About to validate [%lx, %lx) addr=%lx, end=%lx\n",
+		       mm, vma->vm_start,vma->vm_end, vma_iter_addr(&vmi), vma_iter_end(&vmi));
+
+		mt_validate(&mm->mm_mt);
+		pr_err("LJS: Post-validate.\n");
+	}
+
 	/*
 	 * vma_merge_new_range() calls khugepaged_enter_vma() too, the below
 	 * call covers the non-merge case.
@@ -1530,6 +1612,14 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	perf_event_mmap(vma);

 	/* Unmap any existing mapping in the area */
+
+	if (check_interesting(addr, addr + len)) {
+		pr_err("LJS: mm=%p: About to validate [%lx, %lx) addr=%lx, end=%lx\n",
+		       mm, vma->vm_start,vma->vm_end, vma_iter_addr(&vmi), vma_iter_end(&vmi));
+		mt_validate(&mm->mm_mt);
+		pr_err("LJS: Post-validate.\n");
+	}
+
 	vms_complete_munmap_vmas(&vms, &mas_detach);

 	vm_stat_account(mm, vm_flags, pglen);
@@ -1594,6 +1684,8 @@ static int __vm_munmap(unsigned long start, size_t len, bool unlock)
 	LIST_HEAD(uf);
 	VMA_ITERATOR(vmi, mm, start);

+	ljs_dump(mm, start, start + len, 0, true);
+
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;

diff --git a/mm/vma.c b/mm/vma.c
index 4737afcb064c..729575903fb1 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -605,8 +605,15 @@ static int commit_merge(struct vma_merge_struct *vmg,
 	vma_adjust_trans_huge(vmg->vma, vmg->start, vmg->end, adj_start);
 	vma_set_range(vmg->vma, vmg->start, vmg->end, vmg->pgoff);

-	if (expanded)
+	if (expanded) {
+		if (check_interesting(vmg->start, vmg->end)) {
+			pr_err("LJS: mm=%p expanding to [%lx, %lx) addr=%lx end=%lx\n",
+			       vmg->mm, vmg->start, vmg->end,
+			       vma_iter_addr(vmg->vmi), vma_iter_end(vmg->vmi));
+		}
+
 		vma_iter_store(vmg->vmi, vmg->vma);
+	}

 	if (adj_start) {
 		adjust->vm_start += adj_start;
@@ -956,6 +963,12 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 		vma_prev(vmg->vmi); /* Equivalent to going to the previous range */
 	}

+	if (check_interesting(start, end)) {
+		pr_err("LJS: mm=%p About to merge [%lx, %lx) to range [%lx, %lx), addr=%lx end=%lx\n",
+		       vmg->mm, start, end, vmg->start, vmg->end,
+		       vma_iter_addr(vmg->vmi), vma_iter_end(vmg->vmi));
+	}
+
 	/*
 	 * Now try to expand adjacent VMA(s). This takes care of removing the
 	 * following VMA if we have VMAs on both sides.
@@ -1108,8 +1121,13 @@ void vms_clean_up_area(struct vma_munmap_struct *vms,
 	vms_clear_ptes(vms, mas_detach, true);
 	mas_set(mas_detach, 0);
 	mas_for_each(mas_detach, vma, ULONG_MAX)
-		if (vma->vm_ops && vma->vm_ops->close)
+		if (vma->vm_ops && vma->vm_ops->close) {
+			if (check_interesting(vma->vm_start, vma->vm_end))
+				pr_err("LJS: mm=%p Closing [%lx, %lx)\n",
+				       vma->vm_mm, vma->vm_start, vma->vm_end);
+
 			vma->vm_ops->close(vma);
+		}
 	vms->closed_vm_ops = true;
 }

@@ -1179,6 +1197,10 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 	struct vm_area_struct *next = NULL;
 	int error;

+	if (check_interesting(vms->vma->vm_start, vms->vma->vm_end))
+		pr_err("LJS2 vms->start=%lx, vms->vma->vm_start=%lx\n",
+		       vms->start, vms->vma->vm_start);
+
 	/*
 	 * If we need to split any vma, do it now to save pain later.
 	 * Does it split the first one?
@@ -1202,6 +1224,11 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 			goto start_split_failed;
 		}

+		if (check_interesting(vms->vma->vm_start, vms->vma->vm_end))
+			pr_err("LJS: mm=%p vms=[%lx, %lx) split START of [%lx, %lx)\n",
+			       vms->vma->vm_mm, vms->start, vms->end,
+			       vms->vma->vm_start, vms->vma->vm_end);
+
 		error = __split_vma(vms->vmi, vms->vma, vms->start, 1);
 		if (error)
 			goto start_split_failed;
@@ -1217,12 +1244,24 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 	for_each_vma_range(*(vms->vmi), next, vms->end) {
 		long nrpages;

+		if (check_interesting(vms->vma->vm_start, vms->vma->vm_end))
+			pr_err("LJS: mm=%p vms=[%lx, %lx) UNMAP [%lx, %lx) file=[%s]\n",
+			       vms->vma->vm_mm, vms->start, vms->end,
+			       next->vm_start, next->vm_end,
+			       vms->vma->vm_file ? "file-backed" : "");
+
 		if (!can_modify_vma(next)) {
 			error = -EPERM;
 			goto modify_vma_failed;
 		}
 		/* Does it split the end? */
 		if (next->vm_end > vms->end) {
+
+			if (check_interesting(next->vm_start, next->vm_end))
+				pr_err("LJS: mm=%p vms=[%lx, %lx) split END of [%lx, %lx)\n",
+				       next->vm_mm, vms->start, vms->end,
+				       next->vm_start, next->vm_end);
+
 			error = __split_vma(vms->vmi, next, vms->end, 0);
 			if (error)
 				goto end_split_failed;
@@ -1295,9 +1334,15 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 	}
 #endif

-	while (vma_iter_addr(vms->vmi) > vms->start)
+	while (vma_iter_addr(vms->vmi) > vms->start) {
 		vma_iter_prev_range(vms->vmi);

+		if (check_interesting(vms->vma->vm_start, vms->vma->vm_end))
+			pr_err("LJS3: addr=%lx, end=%lx, vms->start=%lx\n",
+			       vma_iter_addr(vms->vmi),
+			       vma_iter_end(vms->vmi), vms->start);
+	}
+
 	vms->clear_ptes = true;
 	return 0;

--
2.46.2

