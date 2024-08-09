Return-Path: <linux-kernel+bounces-281127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B5294D35F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB4A81F23B77
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2480A198A24;
	Fri,  9 Aug 2024 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dYSqOwoV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EloxGF/+"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405281DFE1
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723217030; cv=fail; b=JT1392+BSwEV+kOlJdyprf7tC9VHrYBeDEMpDVeQwuGHD/yQDz8ckF6m1bf+GP1tZ2jYku8crEL7yCRJ4tNV+tuhY5pOgxAPrD6W3/znJqgFYW9gtgvTFNbhPHF9oACKUhz4orq84fSjjQp7dHGzXA6oxIs0sIZTfhvqIyYMuLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723217030; c=relaxed/simple;
	bh=ARVsLePiR9ASz8aj75VnGqhvc+DVL1w5KOFiT7H+6Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U1JjVz/11HIicto7PGqDUuFWtVTXtXsp1MiUkz1LNkgMpzRgKDdwhn9IXSLoNuWaOn46tK77S9YNLPY29mvxlA05tWk4obt/809hTZRpgjH0S6bsrypvbBldZ71SLvTUPU/6FHoVhEP7s/hwbjQlemHy9n8asRmirfVMAhpwfHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dYSqOwoV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EloxGF/+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 479FMVDN032135;
	Fri, 9 Aug 2024 15:23:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=SC3gHeAYiCowlgv
	4PsMASnz8DHGMycR70xQC5Coibl4=; b=dYSqOwoVcwhul9X6lYkNX1XVyOn0+Qb
	GEnRBaEjwLReer/OgKQlNRwAWCp2MNAp4rhz8tijp68ViOyU1xLz4ftBqWOQ2WmV
	8+CWx4ocagHMdcaMsNfO+Y3/Obh59xoUa5BldQLPKaEiuei27ebDr9dy5Rg4TcK9
	0MHc8bujMRHnPlcXHxbusVeRMS9MLNDLcPLwEkO4r2yv+YkBSBUIHcQdZ1RWQe5z
	6/uhqcN9GaDsc1q6l8KStkinlKinS2p7qWJR4v3HOx2Xm1fNuh8vsB0FdAcnvdLh
	XHUR3tNU84qDzWrEvJS9lk+mhSN+prOnDlvBk3Sv0g4wQaRJxSRil9A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sb51m8w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Aug 2024 15:23:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 479FMEsb023804;
	Fri, 9 Aug 2024 15:23:36 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0jsubb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Aug 2024 15:23:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hsve9hSr+Z7rqBDx7hhjE4oxp/CdY0sw5NPJXjCvPXVNl5whGuT/fHbBdAyqD9IEKzBMitxsjx0GK8yJiQu6gmjN3nSGHE0NNu0dwEaniQqCGjcci9prZE/HH2y0UGdhZvQassbbMXaLo0HivbXXk8+rZrnM/a5N0S1iLLH7inTuPzzA55iogsjj54L23nr8WwPwEIPWEPprMydrg0aZ1dYE2G/KCobL2vMro0E4gvwljozRvxXM1H11n3w9u8fRd7TreZPVaRQe0cdl8EH1nnrqwVOio4it+uCiNfdFTCGB5tXE2Z24+2PsJvIY8dEqxmVuVdU1ZkQt7QrOsmhNtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SC3gHeAYiCowlgv4PsMASnz8DHGMycR70xQC5Coibl4=;
 b=nz8/omkhBh6aYHvlCiOGX0gIijx72ouXu4L4M5AA4tw7ITuQDSUd5dGxEVtaPM8VwB95POGTwMqUJrVU/Nl9gN8z8cMtCitTUEzzuA4A2N1sSObTV8yO0D+ND5yk7Bo7PH6777TOuDq5YBjgdgJMdwF1JwwDAKKkZQVB4a2siw92lLkCUjWcKRqZV7iD1P+vwHjJYSn+y8oUE2S55nN/xQ1+ye9U5vvLzDn0vVjRjE53+8cxjRlTD1Ti3yc9V2sxWPLEfn2BXt8Tu4FvTmyUbDFigBpiU2c64wFJN8KHdFT1esk4k8M6G9ogoTz6IHvWmjdKzVCLpwHntVTB0++Fug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SC3gHeAYiCowlgv4PsMASnz8DHGMycR70xQC5Coibl4=;
 b=EloxGF/+ooTSySIRi4hiWs+YjXt/GD4tnt2/yVoYWGf+/uNkLFIbSAQo7u7jsMuk6mtpfDWGi1OLqnfZFNFNFbCDOLOs5emRaw6jJx8faRoXcz2lYImwAzTiwQqqoD4ZA5e7IQ5MFqyZjCJKwCptW4Ry2dPxxKTw2KOkvoitJEo=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SJ0PR10MB5568.namprd10.prod.outlook.com (2603:10b6:a03:3d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.9; Fri, 9 Aug
 2024 15:23:32 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7849.008; Fri, 9 Aug 2024
 15:23:32 +0000
Date: Fri, 9 Aug 2024 11:23:30 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 07/10] mm: avoid using vma_merge() for new VMAs
Message-ID: <f57e65yhvflctpfcsrh75qga2oej4rrqwtu7vcsnacfsowrmss@i6cfuibxmmdl>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
 <cf40652a2c3f6b987623f8f11a514618718546f7.1722849860.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf40652a2c3f6b987623f8f11a514618718546f7.1722849860.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0431.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::12) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SJ0PR10MB5568:EE_
X-MS-Office365-Filtering-Correlation-Id: 1253a27c-e093-4405-ef7b-08dcb8873a95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ut4DBdLBvu2L/DpWfdDrpmDLxDjvyn6xFf3/SRISqfsUqsMdzQr0CRv0zlRh?=
 =?us-ascii?Q?WZ28wJyNJ8AoywaKXKFvwqBOxFD/NJrVWd62smpYfOD6eKckDM/sr62a9j1G?=
 =?us-ascii?Q?feAVoFblnwOja/96ycxftpMRqZohNmNPgkCgcle1mlR1dRiGnjWp3pFA2Daf?=
 =?us-ascii?Q?yY5EOTA+pg0o3PMsNvJWSQtY0+9VU06N/JX3hDTUGv46989mjXKKu3skj2QJ?=
 =?us-ascii?Q?5xNZjAa9oxScbfsg6cchl5vkzleHPFLmf9BHwMIQWAPT4lz7DIcYM5dozg0m?=
 =?us-ascii?Q?16xuXFhH64RCX9QTq3N7rwNv1gKt4Z8sq+5usMcuwa96pU6b0wJHzHCiTJ61?=
 =?us-ascii?Q?Y2zMrI6T+PVG6CnybbVHRRxGgocxqW4IXB+Lm0V9z9ycgZbRRsy91xJPmW/d?=
 =?us-ascii?Q?rlMZZYmRQYdud12Sv70MZkmoOAQQ6V5NdfxiR+CK0ZEsuBoxxYMYHGieMv6D?=
 =?us-ascii?Q?S7QLdlEYN9UM1Q8Qb3/u7QRkWsc4xLNXS1fxlrHWajcX1r1sJxmNmqNdp47g?=
 =?us-ascii?Q?gZVknXHIRbxBPK8zgC+33PAl7mfR+JedlF8FutJnolUUpPN1YFBJ9ku/RYjm?=
 =?us-ascii?Q?QFYl6+PwJ7eiug4W0qZR/R/8dhRN8TUHsHpG7qjWBKfK2bBKpZGjp0oUouBP?=
 =?us-ascii?Q?Abp2cVBZiPB3QqzMcINEsXrYLNmCjchDHGiPK+N49j+jJXojbK7/1n4U3JJt?=
 =?us-ascii?Q?qDLVh+fL9KAgU8QQp4INsoBjKDHVF99DEhMYPXcFdP8nVYnsbTmQ+cGU4vdn?=
 =?us-ascii?Q?aFUElPnBG3YeATjDuRkto3MsoFAUkLhJ1hFFyOB6bRAcmcUrfVKkDSlyShW1?=
 =?us-ascii?Q?Q4ZEvgvz4BS+QbQ6H3XxEAOdoE8LkhQO5EnIN9y837mACLNzRFaJ7tmI/nxP?=
 =?us-ascii?Q?GG+J+Dodcip8+8PV8XdUyejjQI7x61lFVJ6Sjmt8HMJdOd+lgCIRvFzYQxn3?=
 =?us-ascii?Q?nl6d0HXsYCwCPr72aQGHQwOi8Mw7wIg90Z/Kx4zlLYgtD7WG2ICxzW+Y8la0?=
 =?us-ascii?Q?dpbql+J8GGZ2WQ9v4wRQJueRAj88mdk8P7gqEht9fltkCCRpehihCkvGMdS3?=
 =?us-ascii?Q?nzttQlSyMg2gOK3SubH6+X0lbJ1CktEUVCstzDk/v4rMl+NoMhzYHGY8RRKP?=
 =?us-ascii?Q?qBLJsTF/CdLt4rjrHgtzk6CRE0ZZ39ZixbD9cdgq6yx0Y5LfMtqli1qGxwrE?=
 =?us-ascii?Q?cc3dSQo2j7aNRiIAPyfQI6Gx0bSaxVCnLOwpEM3ajLKL0o3GFVUeVubk8rsp?=
 =?us-ascii?Q?sZ27CmsAwALqGyteK8m0BUWV4osC89Qz2xgQAoV4cWMLaeN9AVBb0ukxRDke?=
 =?us-ascii?Q?liPxsoCUbVMMcIn1EuKMji8MUNFNZtoXxlqyfUWtQyoxbA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?32AkeAgnLRNK33IAJl3+PtYNJXqdd6WPwe1uXu/m1GtIxP2Qkl7kK9kfoHxo?=
 =?us-ascii?Q?GfPbS3odOzzgtmfm84lq4nIi6FKOIgIoSnMVZLB+/RKBFyFi+fx/aa+IFWiP?=
 =?us-ascii?Q?W7sdjM51SuWuLzWfXSWR/hcB9HS/a+1XykjLy3f/3IT8Ze4lbHhw/vJR7qqx?=
 =?us-ascii?Q?+SkatzqyraIJrkEVOAnm91bvB0+4Or3oKRDm2uEPhj3NlfAO+zRUJ4h26Vwf?=
 =?us-ascii?Q?aGcQP8NGGILQoJozz+U7KN5BQU9vnuHDke3HnDXOC8yGlUDkg6SHkbmydq11?=
 =?us-ascii?Q?6mTfs5gFS3HOwE8ksaki2kXeSxL5Oj/TN6Tu2SGSL9XDeFtx9pPq5UPZDDLT?=
 =?us-ascii?Q?9/5zw3Qk9Da39cfYuZRhgDSjjhSdBezRCyEXRPhY7RR4Wttf7iFWy2U1clj4?=
 =?us-ascii?Q?I8HAp40c4jrHE5RqrVJXYrYTkXMpAtg0aOwm1d4WT9bgUTxWcVKyAiIIBH6G?=
 =?us-ascii?Q?EVaq+8GJJNi0fMum5CK1YeJUuBhUm+zdl2VxsWh1mO2uhqZKDEyete1CRtll?=
 =?us-ascii?Q?DHNJ5v4q76RUsJBjkY445St60q5DcJ24qiDQbEuQ1JA4hobzkVbChwdaA/IR?=
 =?us-ascii?Q?lQdRZURlqlTiVeLYLdpxW7twx9f34zYvfdjJqc8X+DggNtvC9sdy5em6GzBZ?=
 =?us-ascii?Q?dxCG8K08QVeHHZXGDM6mworZFgtp4AAAH1dARzwI4cM9JmK4CNMuKFp0aWTr?=
 =?us-ascii?Q?j+++f2/BXUE1dlZBVRSt6II4SAtkSOuKlyj2eWgWMoinZ9RgQGfMqIOj99Ha?=
 =?us-ascii?Q?weHVDgJaY/jOqIIMrvzpKC4gTYnMAym6UnfIC3wpLOrfQ6DU3NLjGDTU+2Ia?=
 =?us-ascii?Q?3gEahi0AwiDPRKIFmU340xdURuw8OOmn/alIkt+MaMm4Zmap+gE7U+fRXeBL?=
 =?us-ascii?Q?YBgk7WzkVR8zbo076xQqpENe7/RCurz9dp/WyszEtvD53MLJiXUCSoA2k/Fn?=
 =?us-ascii?Q?mYNu6CqnrC7PeEdYf8EikkYD8OS8RtuXUYLKBGsb1gu3fybVgWdS9WbrL5Su?=
 =?us-ascii?Q?P6ERzREEguXL+2ajFzjo6hYYw7wlCHexz5SkwAouZsGte7xlTFlVHr7B2hem?=
 =?us-ascii?Q?+CV6CYBkKw7cvlQ9nUe61oO70OG7jhLdpCAtyeObCrtAjGTLFKVcl2OvNwIJ?=
 =?us-ascii?Q?qIddCKsfz6Fh4L79tws3TJj+8fitQz1/EwU5I2BgnPsv6M+ij3cW9ZoesSVG?=
 =?us-ascii?Q?XQLYtSZ+WT8ApAyt1Sxyhqfa+YHUciOYHdMRvZR610kdmys1QQSYqChG4v+N?=
 =?us-ascii?Q?jyVNWeM32jyDY+2W4vNy4NbAET0KO5+1zH+9H9leypc1EC/vCzMmhzlgXxon?=
 =?us-ascii?Q?p3snkHs/FN3mR2dxAMnSisNhnJQ9xgXvyPgK6UpPTs8Yck8XLl8b1PV4ZNlR?=
 =?us-ascii?Q?zn/YONVPX86D2mqctZjlYQLoiMDnU/NxioxnLW182/Rt/zxl8+1JeQLDW5nW?=
 =?us-ascii?Q?YgnEdjfGWpgnJgsc68nFzf+TfoRrYyM184CfmqXoqIp8lt1W6LRdxKgpYWgm?=
 =?us-ascii?Q?uoKTi4q42JbvqNRSFIGiFxLkhLZL3RdHcuTjdFDwSXoknuCUXIJkrlXwYtdX?=
 =?us-ascii?Q?BDctOlO+cqbjl5ZatoqCcOBw1SbkTYoubGL62n1O1lbk8raUa16iVrOn/OXM?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	an2EediQIrl3H03efJDBYCkCH8CnYuN1akl3wc3NulSrGu3LMZTnVvSo5LvozvJ05IMzEhkPoVFw2JogcnbqA9En+fnS6i31V7Rni3K/NhS1TTLJGeY/oR9EBkJnKILpLksoMDmVVT4NCBe8WyCgIUTSPEF5kzEpyUSnKKbM72NAs19ewH130aPslXyQPX5J3bdf5gBDMdY6UnQKHhylbabrtJJN7dplFj6Y54QIHUouF+P80evZeX/UWkezlkVxpCuwMXGck/Y13QIqbz8Rdy/1+y0D+Nzl18AbcKA9IeM0LoiorPy9h9TyuQS0W4TqPf1OJ+fd6umNU1sM9Sxfhx36Ivrdr2exHvIAD8/xvuaynfp/WGG4l7PXpTiqesEZQ6qcADHflPpPjuMzzYg8dP1P2u/mao+PnBVei9vwdOkmhgePbGXVFY3O/NliILa+Ii5l6p3Z1BjqMnimh8HlRWYGw3p7F79CV/83HMxvK/h8Qfr3aWp3T4DFFvfHYvn6J2VUJNmrRjnsPGxqIpF9TgcJgBsbumq4Pcvt903fDqY9Rs2w1Fl5NN4PscYdIqDprHt+2VnNMjaHSTPw8cPNf8cJ3OwUWRReCLnrzaLw6f8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1253a27c-e093-4405-ef7b-08dcb8873a95
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 15:23:32.4736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lc6XlylD29+baQJ+8/sUWhFj5WsexUH1dOmB3yiMfFTjQSB0lNr3bglg7CIuK8w6uK07Gmiu1uh1/MnnRHbW2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5568
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_12,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408090111
X-Proofpoint-ORIG-GUID: jum1it0FdtzhU7TZpkxKh_RqO-bArke_
X-Proofpoint-GUID: jum1it0FdtzhU7TZpkxKh_RqO-bArke_

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240805 08:14]:
> In mmap_region() and do_brk_flags() we open code scenarios where we prefer
> to use vma_expand() rather than invoke a full vma_merge() operation.
> 
> Abstract this logic and eliminate all of the open-coding, and also use the
> same logic for all cases where we add new VMAs to, rather than ultimately
> use vma_merge(), rather use vma_expand().
> 
> We implement this by replacing vma_merge_new_vma() with this newly
> abstracted logic.
> 
> Doing so removes duplication and simplifies VMA merging in all such cases,
> laying the ground for us to eliminate the merging of new VMAs in
> vma_merge() altogether.
> 
> This makes it far easier to understand what is happening in these cases
> avoiding confusion, bugs and allowing for future optimisation.
> 
> As a result of this change we are also able to make vma_prepare(),
> init_vma_prep(), vma_complete(), can_vma_merge_before() and
> can_vma_merge_after() static and internal to vma.c.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/mmap.c                        |  79 ++---
>  mm/vma.c                         | 482 +++++++++++++++++++------------
>  mm/vma.h                         |  51 +---
>  tools/testing/vma/vma_internal.h |   6 +
>  4 files changed, 324 insertions(+), 294 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index f6593a81f73d..c03f50f46396 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1363,8 +1363,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  {
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma = NULL;
> -	struct vm_area_struct *next, *prev, *merge;
> -	pgoff_t pglen = len >> PAGE_SHIFT;
> +	struct vm_area_struct *merge;
>  	unsigned long charged = 0;
>  	unsigned long end = addr + len;
>  	bool writable_file_mapping = false;
> @@ -1411,44 +1410,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		vm_flags |= VM_ACCOUNT;
>  	}
>  
> -	next = vmg.next = vma_next(&vmi);
> -	prev = vmg.prev = vma_prev(&vmi);
> -	if (vm_flags & VM_SPECIAL) {
> -		if (prev)
> -			vma_iter_next_range(&vmi);
> -		goto cannot_expand;
> -	}
> -
> -	/* Attempt to expand an old mapping */
> -	/* Check next */
> -	if (next && next->vm_start == end && can_vma_merge_before(&vmg)) {
> -		/* We can adjust this as can_vma_merge_after() doesn't touch */
> -		vmg.end = next->vm_end;
> -		vma = vmg.vma = next;
> -		vmg.pgoff = next->vm_pgoff - pglen;
> -
> -		/* We may merge our NULL anon_vma with non-NULL in next. */
> -		vmg.anon_vma = vma->anon_vma;
> -	}
> -
> -	/* Check prev */
> -	if (prev && prev->vm_end == addr && can_vma_merge_after(&vmg)) {
> -		vmg.start = prev->vm_start;
> -		vma = vmg.vma = prev;
> -		vmg.pgoff = prev->vm_pgoff;
> -	} else if (prev) {
> -		vma_iter_next_range(&vmi);
> -	}
> -
> -	/* Actually expand, if possible */
> -	if (vma && !vma_expand(&vmg)) {
> -		khugepaged_enter_vma(vma, vm_flags);
> +	vma = vma_merge_new_vma(&vmg);
> +	if (vma)
>  		goto expanded;
> -	}
> -
> -	if (vma == prev)
> -		vma_iter_set(&vmi, addr);
> -cannot_expand:
>  
>  	/*
>  	 * Determine the object being mapped and call the appropriate
> @@ -1493,10 +1457,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		 * If vm_flags changed after call_mmap(), we should try merge
>  		 * vma again as we may succeed this time.
>  		 */
> -		if (unlikely(vm_flags != vma->vm_flags && prev)) {
> -			merge = vma_merge_new_vma_wrapper(&vmi, prev, vma,
> -							  vma->vm_start, vma->vm_end,
> -							  vma->vm_pgoff);
> +		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
> +			merge = vma_merge_new_vma(&vmg);
> +
>  			if (merge) {
>  				/*
>  				 * ->mmap() can change vma->vm_file and fput
> @@ -1596,7 +1559,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  
>  		vma_iter_set(&vmi, vma->vm_end);
>  		/* Undo any partial mapping done by a device driver. */
> -		unmap_region(mm, &vmi.mas, vma, prev, next, vma->vm_start,
> +		unmap_region(mm, &vmi.mas, vma, vmg.prev, vmg.next, vma->vm_start,
>  			     vma->vm_end, vma->vm_end, true);
>  	}
>  	if (writable_file_mapping)
> @@ -1773,7 +1736,6 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		unsigned long addr, unsigned long len, unsigned long flags)
>  {
>  	struct mm_struct *mm = current->mm;
> -	struct vma_prepare vp;
>  
>  	/*
>  	 * Check against address space limits by the changed size
> @@ -1795,29 +1757,22 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	 */
>  	if (vma && vma->vm_end == addr) {
>  		struct vma_merge_struct vmg = {
> +			.vmi = vmi,
>  			.prev = vma,
> +			.next = NULL,
> +			.start = addr,
> +			.end = addr + len,
>  			.flags = flags,
>  			.pgoff = addr >> PAGE_SHIFT,
> +			.file = vma->vm_file,
> +			.anon_vma = vma->anon_vma,
> +			.policy = vma_policy(vma),
> +			.uffd_ctx = vma->vm_userfaultfd_ctx,
> +			.anon_name = anon_vma_name(vma),
>  		};
>  
> -		if (can_vma_merge_after(&vmg)) {
> -			vma_iter_config(vmi, vma->vm_start, addr + len);
> -			if (vma_iter_prealloc(vmi, vma))
> -				goto unacct_fail;
> -
> -			vma_start_write(vma);
> -
> -			init_vma_prep(&vp, vma);
> -			vma_prepare(&vp);
> -			vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
> -			vma->vm_end = addr + len;
> -			vm_flags_set(vma, VM_SOFTDIRTY);
> -			vma_iter_store(vmi, vma);
> -
> -			vma_complete(&vp, vmi, mm);
> -			khugepaged_enter_vma(vma, flags);
> +		if (vma_merge_new_vma(&vmg))
>  			goto out;

This is very convoluted to follow.  It seems vma_merge_new_vma() will do
what is necessary by finding out that it can merge after, then call
vma_expand() which calls commit merge(), which sets the iterator to
vmg->start, but vmg->start isn't set to vma->vm_start, it is set to addr
here.. it's actually set to prev->vm_start in vma_merge_new_vma().

This is getting really hard to trace what happens.  I'm also concerned
that the overhead of following all these checks will cost performance on
the brk system call?

Maybe we can have a way to set up the vmg and call the right function to
just make the above happen?  We know with the can_vma_merge_after() that
it is going to work, so could we just call vma_start_write() and
commit_merge()?

Also, vma_merge_new_vma() could fail because it's out of memory so it
should goto unacct_fail.. but we now don't know if it's because the
merge wasn't allowed or if we are out of memory..

> -		}
>  	}
>  
>  	if (vma)
> diff --git a/mm/vma.c b/mm/vma.c
> index 55615392e8d2..a404cf718f9e 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -97,8 +97,7 @@ static void init_multi_vma_prep(struct vma_prepare *vp,
>   *
>   * We assume the vma may be removed as part of the merge.
>   */
> -bool
> -can_vma_merge_before(struct vma_merge_struct *vmg)
> +static bool can_vma_merge_before(struct vma_merge_struct *vmg)
>  {
>  	pgoff_t pglen = PHYS_PFN(vmg->end - vmg->start);
>  
> @@ -120,7 +119,7 @@ can_vma_merge_before(struct vma_merge_struct *vmg)
>   *
>   * We assume that vma is not removed as part of the merge.
>   */
> -bool can_vma_merge_after(struct vma_merge_struct *vmg)
> +static bool can_vma_merge_after(struct vma_merge_struct *vmg)
>  {
>  	if (is_mergeable_vma(vmg, false) &&
>  	    is_mergeable_anon_vma(vmg->anon_vma, vmg->prev->anon_vma, vmg->prev)) {
> @@ -130,6 +129,164 @@ bool can_vma_merge_after(struct vma_merge_struct *vmg)
>  	return false;
>  }
>  
> +static void __vma_link_file(struct vm_area_struct *vma,
> +			    struct address_space *mapping)
> +{
> +	if (vma_is_shared_maywrite(vma))
> +		mapping_allow_writable(mapping);
> +
> +	flush_dcache_mmap_lock(mapping);
> +	vma_interval_tree_insert(vma, &mapping->i_mmap);
> +	flush_dcache_mmap_unlock(mapping);
> +}
> +
> +/*
> + * Requires inode->i_mapping->i_mmap_rwsem
> + */
> +static void __remove_shared_vm_struct(struct vm_area_struct *vma,
> +				      struct address_space *mapping)
> +{
> +	if (vma_is_shared_maywrite(vma))
> +		mapping_unmap_writable(mapping);
> +
> +	flush_dcache_mmap_lock(mapping);
> +	vma_interval_tree_remove(vma, &mapping->i_mmap);
> +	flush_dcache_mmap_unlock(mapping);
> +}
> +
> +/*
> + * vma_prepare() - Helper function for handling locking VMAs prior to altering
> + * @vp: The initialized vma_prepare struct
> + */
> +static void vma_prepare(struct vma_prepare *vp)
> +{
> +	if (vp->file) {
> +		uprobe_munmap(vp->vma, vp->vma->vm_start, vp->vma->vm_end);
> +
> +		if (vp->adj_next)
> +			uprobe_munmap(vp->adj_next, vp->adj_next->vm_start,
> +				      vp->adj_next->vm_end);
> +
> +		i_mmap_lock_write(vp->mapping);
> +		if (vp->insert && vp->insert->vm_file) {
> +			/*
> +			 * Put into interval tree now, so instantiated pages
> +			 * are visible to arm/parisc __flush_dcache_page
> +			 * throughout; but we cannot insert into address
> +			 * space until vma start or end is updated.
> +			 */
> +			__vma_link_file(vp->insert,
> +					vp->insert->vm_file->f_mapping);
> +		}
> +	}
> +
> +	if (vp->anon_vma) {
> +		anon_vma_lock_write(vp->anon_vma);
> +		anon_vma_interval_tree_pre_update_vma(vp->vma);
> +		if (vp->adj_next)
> +			anon_vma_interval_tree_pre_update_vma(vp->adj_next);
> +	}
> +
> +	if (vp->file) {
> +		flush_dcache_mmap_lock(vp->mapping);
> +		vma_interval_tree_remove(vp->vma, &vp->mapping->i_mmap);
> +		if (vp->adj_next)
> +			vma_interval_tree_remove(vp->adj_next,
> +						 &vp->mapping->i_mmap);
> +	}
> +
> +}
> +
> +/*
> + * vma_complete- Helper function for handling the unlocking after altering VMAs,
> + * or for inserting a VMA.
> + *
> + * @vp: The vma_prepare struct
> + * @vmi: The vma iterator
> + * @mm: The mm_struct
> + */
> +static void vma_complete(struct vma_prepare *vp,
> +			 struct vma_iterator *vmi, struct mm_struct *mm)
> +{
> +	if (vp->file) {
> +		if (vp->adj_next)
> +			vma_interval_tree_insert(vp->adj_next,
> +						 &vp->mapping->i_mmap);
> +		vma_interval_tree_insert(vp->vma, &vp->mapping->i_mmap);
> +		flush_dcache_mmap_unlock(vp->mapping);
> +	}
> +
> +	if (vp->remove && vp->file) {
> +		__remove_shared_vm_struct(vp->remove, vp->mapping);
> +		if (vp->remove2)
> +			__remove_shared_vm_struct(vp->remove2, vp->mapping);
> +	} else if (vp->insert) {
> +		/*
> +		 * split_vma has split insert from vma, and needs
> +		 * us to insert it before dropping the locks
> +		 * (it may either follow vma or precede it).
> +		 */
> +		vma_iter_store(vmi, vp->insert);
> +		mm->map_count++;
> +	}
> +
> +	if (vp->anon_vma) {
> +		anon_vma_interval_tree_post_update_vma(vp->vma);
> +		if (vp->adj_next)
> +			anon_vma_interval_tree_post_update_vma(vp->adj_next);
> +		anon_vma_unlock_write(vp->anon_vma);
> +	}
> +
> +	if (vp->file) {
> +		i_mmap_unlock_write(vp->mapping);
> +		uprobe_mmap(vp->vma);
> +
> +		if (vp->adj_next)
> +			uprobe_mmap(vp->adj_next);
> +	}
> +
> +	if (vp->remove) {
> +again:
> +		vma_mark_detached(vp->remove, true);
> +		if (vp->file) {
> +			uprobe_munmap(vp->remove, vp->remove->vm_start,
> +				      vp->remove->vm_end);
> +			fput(vp->file);
> +		}
> +		if (vp->remove->anon_vma)
> +			anon_vma_merge(vp->vma, vp->remove);
> +		mm->map_count--;
> +		mpol_put(vma_policy(vp->remove));
> +		if (!vp->remove2)
> +			WARN_ON_ONCE(vp->vma->vm_end < vp->remove->vm_end);
> +		vm_area_free(vp->remove);
> +
> +		/*
> +		 * In mprotect's case 6 (see comments on vma_merge),
> +		 * we are removing both mid and next vmas
> +		 */
> +		if (vp->remove2) {
> +			vp->remove = vp->remove2;
> +			vp->remove2 = NULL;
> +			goto again;
> +		}
> +	}
> +	if (vp->insert && vp->file)
> +		uprobe_mmap(vp->insert);
> +	validate_mm(mm);
> +}
> +
> +/*
> + * init_vma_prep() - Initializer wrapper for vma_prepare struct
> + * @vp: The vma_prepare struct
> + * @vma: The vma that will be altered once locked
> + */
> +static void init_vma_prep(struct vma_prepare *vp,
> +			  struct vm_area_struct *vma)
> +{
> +	init_multi_vma_prep(vp, vma, NULL, NULL, NULL);
> +}
> +
>  /*
>   * Close a vm structure and free it.
>   */
> @@ -292,31 +449,6 @@ static inline void remove_mt(struct mm_struct *mm, struct ma_state *mas)
>  	vm_unacct_memory(nr_accounted);
>  }
>  
> -/*
> - * init_vma_prep() - Initializer wrapper for vma_prepare struct
> - * @vp: The vma_prepare struct
> - * @vma: The vma that will be altered once locked
> - */
> -void init_vma_prep(struct vma_prepare *vp,
> -		   struct vm_area_struct *vma)
> -{
> -	init_multi_vma_prep(vp, vma, NULL, NULL, NULL);
> -}
> -
> -/*
> - * Requires inode->i_mapping->i_mmap_rwsem
> - */
> -static void __remove_shared_vm_struct(struct vm_area_struct *vma,
> -				      struct address_space *mapping)
> -{
> -	if (vma_is_shared_maywrite(vma))
> -		mapping_unmap_writable(mapping);
> -
> -	flush_dcache_mmap_lock(mapping);
> -	vma_interval_tree_remove(vma, &mapping->i_mmap);
> -	flush_dcache_mmap_unlock(mapping);
> -}
> -
>  /*
>   * vma has some anon_vma assigned, and is already inserted on that
>   * anon_vma's interval trees.
> @@ -349,60 +481,6 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
>  		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
>  }
>  
> -static void __vma_link_file(struct vm_area_struct *vma,
> -			    struct address_space *mapping)
> -{
> -	if (vma_is_shared_maywrite(vma))
> -		mapping_allow_writable(mapping);
> -
> -	flush_dcache_mmap_lock(mapping);
> -	vma_interval_tree_insert(vma, &mapping->i_mmap);
> -	flush_dcache_mmap_unlock(mapping);
> -}
> -
> -/*
> - * vma_prepare() - Helper function for handling locking VMAs prior to altering
> - * @vp: The initialized vma_prepare struct
> - */
> -void vma_prepare(struct vma_prepare *vp)
> -{
> -	if (vp->file) {
> -		uprobe_munmap(vp->vma, vp->vma->vm_start, vp->vma->vm_end);
> -
> -		if (vp->adj_next)
> -			uprobe_munmap(vp->adj_next, vp->adj_next->vm_start,
> -				      vp->adj_next->vm_end);
> -
> -		i_mmap_lock_write(vp->mapping);
> -		if (vp->insert && vp->insert->vm_file) {
> -			/*
> -			 * Put into interval tree now, so instantiated pages
> -			 * are visible to arm/parisc __flush_dcache_page
> -			 * throughout; but we cannot insert into address
> -			 * space until vma start or end is updated.
> -			 */
> -			__vma_link_file(vp->insert,
> -					vp->insert->vm_file->f_mapping);
> -		}
> -	}
> -
> -	if (vp->anon_vma) {
> -		anon_vma_lock_write(vp->anon_vma);
> -		anon_vma_interval_tree_pre_update_vma(vp->vma);
> -		if (vp->adj_next)
> -			anon_vma_interval_tree_pre_update_vma(vp->adj_next);
> -	}
> -
> -	if (vp->file) {
> -		flush_dcache_mmap_lock(vp->mapping);
> -		vma_interval_tree_remove(vp->vma, &vp->mapping->i_mmap);
> -		if (vp->adj_next)
> -			vma_interval_tree_remove(vp->adj_next,
> -						 &vp->mapping->i_mmap);
> -	}
> -
> -}
> -
>  /*
>   * dup_anon_vma() - Helper function to duplicate anon_vma
>   * @dst: The destination VMA
> @@ -486,6 +564,120 @@ void validate_mm(struct mm_struct *mm)
>  }
>  #endif /* CONFIG_DEBUG_VM_MAPLE_TREE */
>  
> +/*
> + * vma_merge_new_vma - Attempt to merge a new VMA into address space
> + *
> + * @vmg: Describes the VMA we are adding, in the range @vmg->start to @vmg->end
> + *       (exclusive), which we try to merge with any adjacent VMAs if possible.
> + *
> + * We are about to add a VMA to the address space starting at @vmg->start and
> + * ending at @vmg->end. There are three different possible scenarios:
> + *
> + * 1. There is a VMA with identical properties immediately adjacent to the
> + *    proposed new VMA [@vmg->start, @vmg->end) either before or after it -
> + *    EXPAND that VMA:
> + *
> + * Proposed:       |-----|  or  |-----|
> + * Existing:  |----|                  |----|
> + *
> + * 2. There are VMAs with identical properties immediately adjacent to the
> + *    proposed new VMA [@vmg->start, @vmg->end) both before AND after it -
> + *    EXPAND the former and REMOVE the latter:
> + *
> + * Proposed:       |-----|
> + * Existing:  |----|     |----|
> + *
> + * 3. There are no VMAs immediately adjacent to the proposed new VMA or those
> + *    VMAs do not have identical attributes - NO MERGE POSSIBLE.

We still have diagrams, that's too bad.

> + *
> + * In instances where we can merge, this function returns the expanded VMA which
> + * will have its range adjusted accordingly and the underlying maple tree also
> + * adjusted.
> + *
> + * Returns: In instances where no merge was possible, NULL. Otherwise, a pointer
> + *          to the VMA we expanded.
> + *
> + * This function also adjusts @vmg to provide @vmg->prev and @vmg->next if
> + * neither already specified, and adjusts [@vmg->start, @vmg->end) to span the
> + * expanded range.
> + *
> + * ASSUMPTIONS:
> + * - The caller must hold a WRITE lock on the mm_struct->mmap_lock.
> + * - The caller must have determined that [@vmg->start, @vmg->end) is empty.
> + */
> +struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg)
> +{
> +	bool is_special = vmg->flags & VM_SPECIAL;
> +	struct vm_area_struct *prev = vmg->prev;
> +	struct vm_area_struct *next = vmg->next;
> +	unsigned long start = vmg->start;
> +	unsigned long end = vmg->end;
> +	pgoff_t pgoff = vmg->pgoff;
> +	pgoff_t pglen = PHYS_PFN(end - start);
> +
> +	VM_WARN_ON(vmg->vma);
> +
> +	if (!prev && !next) {
> +		/*
> +		 * Since the caller must have determined that the requested
> +		 * range is empty, vmg->vmi will be left pointing at the VMA
> +		 * immediately prior.
> +		 */
> +		next = vmg->next = vma_next(vmg->vmi);
> +		prev = vmg->prev = vma_prev(vmg->vmi);
> +
> +		/* Avoid maple tree re-walk. */
> +		if (is_special && prev)
> +			vma_iter_next_range(vmg->vmi);
> +	}
> +
> +	/* If special mapping or no adjacent VMAs, nothing to merge. */
> +	if (is_special || (!prev && !next))
> +		return NULL;
> +
> +	/* If we can merge with the following VMA, adjust vmg accordingly. */
> +	if (next && next->vm_start == end && can_vma_merge_before(vmg)) {
> +		/*
> +		 * We can adjust this here as can_vma_merge_after() doesn't
> +		 * touch vmg->end.
> +		 */
> +		vmg->end = next->vm_end;
> +		vmg->vma = next;
> +		vmg->pgoff = next->vm_pgoff - pglen;
> +
> +		vmg->anon_vma = next->anon_vma;
> +	}
> +
> +	/* If we can merge with the previous VMA, adjust vmg accordingly. */
> +	if (prev && prev->vm_end == start && can_vma_merge_after(vmg)) {
> +		vmg->start = prev->vm_start;
> +		vmg->vma = prev;
> +		vmg->pgoff = prev->vm_pgoff;
> +	} else if (prev) {
> +		vma_iter_next_range(vmg->vmi);
> +	}
> +
> +	/*
> +	 * Now try to expand adjacent VMA(s). This takes care of removing the
> +	 * following VMA if we have VMAs on both sides.
> +	 */
> +	if (vmg->vma && !vma_expand(vmg)) {
> +		khugepaged_enter_vma(vmg->vma, vmg->flags);
> +		return vmg->vma;
> +	}
> +
> +	/* If expansion failed, reset state. Allows us to retry merge later. */
> +	vmg->vma = NULL;
> +	vmg->anon_vma = NULL;
> +	vmg->start = start;
> +	vmg->end = end;
> +	vmg->pgoff = pgoff;
> +	if (vmg->vma == prev)
> +		vma_iter_set(vmg->vmi, start);
> +
> +	return NULL;
> +}

Can we split this up a bit?  I was thinking that, for the brk() case, we
need to know if we can merge prev and if that merge fails.  I was
thinking something that you create a vmg with whatever, then call
can_merge_prev, and that'd do the block above and change the vmg as
required.  We could have a can_merge_next that does the same, then we
need to prepare the change (dup anon vma, preallocate for maple tree,
locking, whatever), then commit.

There could still be the function above, but with smaller widgets to do
what we need so we gain flexibility in what we decide to check - prev
only in brk().

I'm not sure if we'd need one for expanding vs existing or if we could
check !vmg->vma to figure that out..

This would also have the effect of self-documenting what is going on.
For brk, it would look like this:

if (vmg_expand_prev()) {
	if (vmg_prepare())
		goto no_mem;
	vmg_commit();
}

I think this would change your exposed interface, at least for brk() -
or a wrapper for this, but small widgets may gain us some
self-documented code?

If you really don't like the exposure of the interface, the vmg could
have a return so we can see if we ran out of memory?

> +
>  /*
>   * vma_expand - Expand an existing VMA
>   *
> @@ -496,7 +688,11 @@ void validate_mm(struct mm_struct *mm)
>   * vmg->next->vm_end.  Checking if the vmg->vma can expand and merge with
>   * vmg->next needs to be handled by the caller.
>   *
> - * Returns: 0 on success
> + * Returns: 0 on success.
> + *
> + * ASSUMPTIONS:
> + * - The caller must hold a WRITE lock on vmg->vma->mm->mmap_lock.
> + * - The caller must have set @vmg->prev and @vmg->next.
>   */
>  int vma_expand(struct vma_merge_struct *vmg)
>  {
> @@ -576,85 +772,6 @@ int vma_shrink(struct vma_merge_struct *vmg)
>  	return 0;
>  }
>  
> -/*
> - * vma_complete- Helper function for handling the unlocking after altering VMAs,
> - * or for inserting a VMA.
> - *
> - * @vp: The vma_prepare struct
> - * @vmi: The vma iterator
> - * @mm: The mm_struct
> - */
> -void vma_complete(struct vma_prepare *vp,
> -		  struct vma_iterator *vmi, struct mm_struct *mm)
> -{
> -	if (vp->file) {
> -		if (vp->adj_next)
> -			vma_interval_tree_insert(vp->adj_next,
> -						 &vp->mapping->i_mmap);
> -		vma_interval_tree_insert(vp->vma, &vp->mapping->i_mmap);
> -		flush_dcache_mmap_unlock(vp->mapping);
> -	}
> -
> -	if (vp->remove && vp->file) {
> -		__remove_shared_vm_struct(vp->remove, vp->mapping);
> -		if (vp->remove2)
> -			__remove_shared_vm_struct(vp->remove2, vp->mapping);
> -	} else if (vp->insert) {
> -		/*
> -		 * split_vma has split insert from vma, and needs
> -		 * us to insert it before dropping the locks
> -		 * (it may either follow vma or precede it).
> -		 */
> -		vma_iter_store(vmi, vp->insert);
> -		mm->map_count++;
> -	}
> -
> -	if (vp->anon_vma) {
> -		anon_vma_interval_tree_post_update_vma(vp->vma);
> -		if (vp->adj_next)
> -			anon_vma_interval_tree_post_update_vma(vp->adj_next);
> -		anon_vma_unlock_write(vp->anon_vma);
> -	}
> -
> -	if (vp->file) {
> -		i_mmap_unlock_write(vp->mapping);
> -		uprobe_mmap(vp->vma);
> -
> -		if (vp->adj_next)
> -			uprobe_mmap(vp->adj_next);
> -	}
> -
> -	if (vp->remove) {
> -again:
> -		vma_mark_detached(vp->remove, true);
> -		if (vp->file) {
> -			uprobe_munmap(vp->remove, vp->remove->vm_start,
> -				      vp->remove->vm_end);
> -			fput(vp->file);
> -		}
> -		if (vp->remove->anon_vma)
> -			anon_vma_merge(vp->vma, vp->remove);
> -		mm->map_count--;
> -		mpol_put(vma_policy(vp->remove));
> -		if (!vp->remove2)
> -			WARN_ON_ONCE(vp->vma->vm_end < vp->remove->vm_end);
> -		vm_area_free(vp->remove);
> -
> -		/*
> -		 * In mprotect's case 6 (see comments on vma_merge),
> -		 * we are removing both mid and next vmas
> -		 */
> -		if (vp->remove2) {
> -			vp->remove = vp->remove2;
> -			vp->remove2 = NULL;
> -			goto again;
> -		}
> -	}
> -	if (vp->insert && vp->file)
> -		uprobe_mmap(vp->insert);
> -	validate_mm(mm);
> -}
> -
>  /*
>   * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
>   * @vmi: The vma iterator
> @@ -1261,20 +1378,6 @@ struct vm_area_struct
>  	return vma_modify(&vmg);
>  }
>  
> -/*
> - * Attempt to merge a newly mapped VMA with those adjacent to it. The caller
> - * must ensure that [start, end) does not overlap any existing VMA.
> - */
> -struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg)
> -{
> -	if (!vmg->prev) {
> -		vmg->prev = vma_prev(vmg->vmi);
> -		vma_iter_set(vmg->vmi, vmg->start);
> -	}
> -
> -	return vma_merge(vmg);
> -}
> -
>  /*
>   * Expand vma by delta bytes, potentially merging with an immediately adjacent
>   * VMA with identical properties.
> @@ -1297,8 +1400,7 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
>  		.anon_name = anon_vma_name(vma),
>  	};
>  
> -	/* vma is specified as prev, so case 1 or 2 will apply. */
> -	return vma_merge(&vmg);
> +	return vma_merge_new_vma(&vmg);
>  }
>  
>  void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb)
> @@ -1399,24 +1501,40 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
>  	struct vm_area_struct *vma = *vmap;
>  	unsigned long vma_start = vma->vm_start;
>  	struct mm_struct *mm = vma->vm_mm;
> -	struct vm_area_struct *new_vma, *prev;
> +	struct vm_area_struct *new_vma;
>  	bool faulted_in_anon_vma = true;
>  	VMA_ITERATOR(vmi, mm, addr);
> +	struct vma_merge_struct vmg = {
> +		.vmi = &vmi,
> +		.start = addr,
> +		.end = addr + len,
> +		.flags = vma->vm_flags,
> +		.pgoff = pgoff,
> +		.file = vma->vm_file,
> +		.anon_vma = vma->anon_vma,
> +		.policy = vma_policy(vma),
> +		.uffd_ctx = vma->vm_userfaultfd_ctx,
> +		.anon_name = anon_vma_name(vma),
> +	};
>  
>  	/*
>  	 * If anonymous vma has not yet been faulted, update new pgoff
>  	 * to match new location, to increase its chance of merging.
>  	 */
>  	if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma)) {
> -		pgoff = addr >> PAGE_SHIFT;
> +		pgoff = vmg.pgoff = addr >> PAGE_SHIFT;
>  		faulted_in_anon_vma = false;
>  	}
>  
> -	new_vma = find_vma_prev(mm, addr, &prev);
> +	new_vma = find_vma_prev(mm, addr, &vmg.prev);
>  	if (new_vma && new_vma->vm_start < addr + len)
>  		return NULL;	/* should never get here */
>  
> -	new_vma = vma_merge_new_vma_wrapper(&vmi, prev, vma, addr, addr + len, pgoff);
> +	vmg.next = vma_next(&vmi);
> +	vma_prev(&vmi);
> +
> +	new_vma = vma_merge_new_vma(&vmg);
> +
>  	if (new_vma) {
>  		/*
>  		 * Source vma may have been merged into new_vma
> diff --git a/mm/vma.h b/mm/vma.h
> index 50459f9e4c7f..bbb173053f34 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -55,17 +55,6 @@ void anon_vma_interval_tree_pre_update_vma(struct vm_area_struct *vma);
>  /* Required for expand_downwards(). */
>  void anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma);
>  
> -/* Required for do_brk_flags(). */
> -void vma_prepare(struct vma_prepare *vp);
> -
> -/* Required for do_brk_flags(). */
> -void init_vma_prep(struct vma_prepare *vp,
> -		   struct vm_area_struct *vma);
> -
> -/* Required for do_brk_flags(). */
> -void vma_complete(struct vma_prepare *vp,
> -		  struct vma_iterator *vmi, struct mm_struct *mm);
> -
>  int vma_expand(struct vma_merge_struct *vmg);
>  int vma_shrink(struct vma_merge_struct *vmg);
>  
> @@ -85,20 +74,6 @@ void unmap_region(struct mm_struct *mm, struct ma_state *mas,
>  		struct vm_area_struct *next, unsigned long start,
>  		unsigned long end, unsigned long tree_end, bool mm_wr_locked);
>  
> -/*
> - * Can we merge the VMA described by vmg into the following VMA vmg->next?
> - *
> - * Required by mmap_region().
> - */
> -bool can_vma_merge_before(struct vma_merge_struct *vmg);
> -
> -/*
> - * Can we merge the VMA described by vmg into the preceding VMA vmg->prev?
> - *
> - * Required by mmap_region() and do_brk_flags().
> - */
> -bool can_vma_merge_after(struct vma_merge_struct *vmg);
> -
>  /* We are about to modify the VMA's flags. */
>  struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
>  					struct vm_area_struct *prev,
> @@ -133,31 +108,7 @@ struct vm_area_struct
>  		       unsigned long new_flags,
>  		       struct vm_userfaultfd_ctx new_ctx);
>  
> -struct vm_area_struct
> -*vma_merge_new_vma(struct vma_merge_struct *vmg);
> -
> -/* Temporary convenience wrapper. */
> -static inline struct vm_area_struct
> -*vma_merge_new_vma_wrapper(struct vma_iterator *vmi, struct vm_area_struct *prev,
> -			   struct vm_area_struct *vma, unsigned long start,
> -			   unsigned long end, pgoff_t pgoff)
> -{
> -	struct vma_merge_struct vmg = {
> -		.vmi = vmi,
> -		.prev = prev,
> -		.start = start,
> -		.end = end,
> -		.flags = vma->vm_flags,
> -		.file = vma->vm_file,
> -		.anon_vma = vma->anon_vma,
> -		.pgoff = pgoff,
> -		.policy = vma_policy(vma),
> -		.uffd_ctx = vma->vm_userfaultfd_ctx,
> -		.anon_name = anon_vma_name(vma),
> -	};
> -
> -	return vma_merge_new_vma(&vmg);
> -}
> +struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg);
>  
>  /*
>   * Temporary wrapper around vma_merge() so we can have a common interface for
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index 40797a819d3d..a39a734282d0 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -709,6 +709,12 @@ static inline void vma_iter_free(struct vma_iterator *vmi)
>  	mas_destroy(&vmi->mas);
>  }
>  
> +static inline
> +struct vm_area_struct *vma_iter_next_range(struct vma_iterator *vmi)
> +{
> +	return mas_next_range(&vmi->mas, ULONG_MAX);
> +}
> +
>  static inline void vm_acct_memory(long pages)
>  {
>  }
> -- 
> 2.45.2
> 

