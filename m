Return-Path: <linux-kernel+bounces-248161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DBA92D90C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4CC91F221A4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E501990DE;
	Wed, 10 Jul 2024 19:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kBQyoiC2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Iv+qP3H7"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E08D19883C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720639430; cv=fail; b=Rqs1+Df+ZSsbzcvyMV10b2Cvs51Xi0fAlrZTyTVzx+B6NoYisqLCWPKkiWH42qn0OmIt/iUdYoe3knevtOjnQE8wG3VycZWoVbzoENFSQWHPBy1PeL/x7zi8hUs1VmNQtnPC2tSzrLs6K3eseB+m1bh93la1oOO29UhWZdJfPxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720639430; c=relaxed/simple;
	bh=ahjT4jAX2L9Bvhdj5nbsQZCB8KEUEamjhkuT5LY7s2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=be+VoylW+FmvWCCVOFIPmQJokB1Sa1XmCJm2ICMaf10DrP/GmVL6BZrsOybwDRT1sLy50ptjPWfahYifFKmsoIC+3w1p2cB7djN/jkPSbrImMs+DT0mCwB9xaPEFnEY4N2hTbQdA+ymj680W/OuRalhCj9PH1SsSLamIZSgqtEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kBQyoiC2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Iv+qP3H7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AGCIcS012159;
	Wed, 10 Jul 2024 19:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=dpHEzn80OIyOxWiBfc/i9nreyp81gPbsuptSnKpNCXI=; b=
	kBQyoiC2HHmufG9EvzwdtNKYT39w4mYERKF2hoBvmdlXQyD6GPctErjm27JMtn1o
	dUwk4/i+XQsLqpmB5ISFOsaDPiJAio0yB0uc/d3hY8iW23ue62bcyuxEoBt6k4Io
	7hx2MMxjN9h/UnkMGFySvsx7PAzEu6ero4otDVTdyKsxp62gNtFR3o/bTsyQHlsv
	OjjB6/+cme9RFYX2UKxYHHb5B9KFb4eirTQdzGp72tViEkBDpc2ffgrTU9Qz2xQ1
	ft9FazpMC2YBye/JNcuM3M8UJqrToPe+NKs/Mt+ZXSsKm2yAEoyoNTddI4HBjHz6
	B5uIJMKGz4EtetHZMC32Ag==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 407emsyct3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46AIihMD033699;
	Wed, 10 Jul 2024 19:23:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv1948k-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H23CV8GIgN5iQz2kjaBOskNgTD2zuJHNrFtWGZjBZIEhoCzmOtkl5kalTU1zMfQCxfTaQQjjqDQeXlsDBWlnPl562Xybk2aVCqf7xF6k096dL0jyYyw7QnjQSS2DSeGfqGyqM0PLW3XikE/xYMMr53RpQgBonBJXbqa74WnUPRs7wrsFiOU/xz7xxurHeyyTCtWiYnMzNBJiZzUoPU6dfEkHU0JkYXtirfreSa4GqJfsPHd1fWA/BgC9VwVFIkHwkymLu5+19tak2uote6epb57V1zx8+2Wu4ovhN/fU5bEqhWBp//kc4AMk4j6ADUTyhAmBskTRwOer3RMSuXXg7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpHEzn80OIyOxWiBfc/i9nreyp81gPbsuptSnKpNCXI=;
 b=F/UNTqP+Un2bTcdOOrnTHarkLqVzO0HJMivgTL/8KVr4BdUESiDYg6C99oabNtQXnIdbtq8xS9XBgGibpZdkRdGMf2bR8qHl3fS8S3hGry2DMAhp90uskkphCr1JlQG6eDrmmwVBIF7npFizME7fnwvb/LlSq4xAxnMnOKDZv36qY183UAKN5HWsTV63HpoJSUVle5MhhKGhYPwgomYlsI8csnxAXy2WsUbveT5XImQkOFQL6ci5H18sbnTUIM1CiP/GoXvFg1gYzuQGjCdBtsHEf6uUJKqBzWXjCa/QT0NKh82+i5ME4xqVFcDuWa4KVJcH/MvBaNJwwMi4yrcdxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpHEzn80OIyOxWiBfc/i9nreyp81gPbsuptSnKpNCXI=;
 b=Iv+qP3H7hT+MvNXvsFUKMdclgY1yextneou6O780oDFgmDuU4g+gwVwVy0oojExNmveNCjxFztEzwKqemNWsMFj0UUIWh5EVVCMrM13wPDVSZ2vAGb50KIhq2BkUlXj0zYOWS/XmPQ0HTEB8Vk0v5ung3RE+j9cJT1Kc+sL71LA=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS0PR10MB7295.namprd10.prod.outlook.com (2603:10b6:8:f7::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.36; Wed, 10 Jul 2024 19:23:05 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 19:23:05 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v4 03/21] mm/mmap: Introduce vmi_complete_munmap_vmas()
Date: Wed, 10 Jul 2024 15:22:32 -0400
Message-ID: <20240710192250.4114783-4-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
References: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0027.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::6) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS0PR10MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 42204ac8-7579-431e-31c9-08dca115b8fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Ic+uJSiYcbJ75Wn43zGt3VTYumQbgm4E7xCfSXnbBWAzu7iAMFN8czzlqmO1?=
 =?us-ascii?Q?MTMPFzy+5EciW5aeqzkl0fckdXIXiK1xjuHZb1nyuV/a5keNvk51kDbS2gfV?=
 =?us-ascii?Q?RBlCkjuTYMbn/GMsnnadB/G7xdgqV0Vq3IjU/XGjtDkwkcqZjyQXJLJUU7tO?=
 =?us-ascii?Q?zqgu3Rh89dMS2EgKaaEGtNbdvt4VMG2NrB9WLvS66M2mB6kyHlT2Pd5v9K0A?=
 =?us-ascii?Q?+Tc6/vsg52pgGrtkZFY56FaFETmvNdevu0S4FqtVeIAyEH1nLx65luVEAiMx?=
 =?us-ascii?Q?vaB6oCDAtRr6x5hKJnZ5EInIbZO5JH/wQty+24L8hmcvntxpB/MXDh1Cbu6E?=
 =?us-ascii?Q?FKSmg1Bf/vbvYsjhso+yCbb08ko2pKrlESltje7Db8P2F1cO7bxR2rEsQOSe?=
 =?us-ascii?Q?qGjRXfUJK50uNlKsz4UWvY3lBYYOLAzhKqIdgy7Pw+mPOK8nwC7i4d3awCzM?=
 =?us-ascii?Q?WN2WFmotEXM60qtqhI0k677WRGekwDrTo3K6a1uAuzy8dBboGbjH2Dgx5IBu?=
 =?us-ascii?Q?qZU8OpddFiJMhS2LLy/F8+E9efupYoslRao6jvFKti4PD5J2SOHgoisav1Qw?=
 =?us-ascii?Q?WyO8n2FV6CT+lZ1wU9Mq55S3meZgjhmg6sZLL8Z0FnGE+5003JjpHkXcjVDL?=
 =?us-ascii?Q?Sx4UIhydoEBn3Ev8gpAVu4OiJWUDHWSLB0TZdYH+GcBAFV7S2bIZxwARRi54?=
 =?us-ascii?Q?gtxq2OSQX0NJFu0seOodYRtGEiMt1ecZeYVdM5z7knPDn1t5HO73By/wSeUu?=
 =?us-ascii?Q?PXna3DsmmSsHKXzPeZVWlWKJx/amgDObOmLhbv5/xpX76QZsqEQZPp6MBh6t?=
 =?us-ascii?Q?FrCwgyEFlaydYPT18BGjLB2xoZ5xGLKgMbQVKewZgNQASMxjam37uPUNISLg?=
 =?us-ascii?Q?6mYwrh4Ahzsr5BY3rHbvNLaPC2MYP24K8rbkL/aFQwpMxx0f+eA5V4l0xM50?=
 =?us-ascii?Q?XI1VZsv4qI3GzbjSmCIUYEtIeZbt6Q/L37yjXglacIUk4mmLq4UwdIRePzBp?=
 =?us-ascii?Q?Gdp4RaBcndwI5agn6Q6irySF9WEMy75V0MSgJUIc1FQpxbQ0JhnZBNsgy9U/?=
 =?us-ascii?Q?2dibsSi6kh1B1vgm2SErRs7HkjTKrteHXG/9xR8PCVE1D4VfkxTORQIhfl7X?=
 =?us-ascii?Q?DbPJ3Ku1XA3YqBhlF8xWm77FjbmRKM3azAsEXOSI8HrJ1BRmIWzYao2UIk6g?=
 =?us-ascii?Q?VN0n+551DtQHR5lCXwkIsu/0JPynGNKtPGiDQMTEoOqSKZKoj1Bde6/eqdkY?=
 =?us-ascii?Q?nU2rZwjVHIWDyDTurWsS5gGvyx7YNAsqiYn0UXo0u8tn2kQELXGlWO9FBtcV?=
 =?us-ascii?Q?di5YZrehV30Nnyet7Zk+OTI/Tx1WXRxiTjKcUkNMP6Hf3g=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?U1ZkkvrNydlumj/1ngeAaNBhsXHVkayZ+Z5vgcZx8Fq+tHV2VJL9xL2YruZH?=
 =?us-ascii?Q?mXaxaMNw9J6U3CPAqe/juDSgLwMy67EXncWhLaC4AHPXV4lzRDI6TzEmC2NS?=
 =?us-ascii?Q?Svj0m0cA9WuVIUbPNvPoFBeoC09dABx8Au6g5Bh/jGm7MaDxtwMzfEpoiSsR?=
 =?us-ascii?Q?62CgI0OpyKnJ9H3PDUHQ9ljyz2ZVwtxlQodrcvVO8DizwBKGP1c70b7VdtSG?=
 =?us-ascii?Q?F+92m2PIU6sO+O1r5SshnZHRNVSIElI3+WFuXwd/hTvaMFVJ/TimV+n0HHsW?=
 =?us-ascii?Q?zUZYh6+4GUbeLqWvgITjLQ3m9y4YqQgeBxRkFmY6HQmCMOyX2tzOzgdBkYpn?=
 =?us-ascii?Q?hCnD4HoxpIJGC6X9Ah6yyBf3Se/Gmm7l5Jvxt76zTproBYbZWn8Y+Ep1g7Hs?=
 =?us-ascii?Q?MwEKU2BIMoy1RtJajvanYCgCQYSYBxiD/2GN0e1aYtGKhQJBqGKfWo/lUUHH?=
 =?us-ascii?Q?qGhSfedyplDzD4n25YMLD23Lb2WsiErxA4Svnn8xqkvPjuwoZBACs9XIUUQ2?=
 =?us-ascii?Q?ykhmymeUC98xrv1Yhy3CeK5KWZe0eoKUV2r0fVby48IT5eqBkLGjzwKZgV0H?=
 =?us-ascii?Q?AtO0KFBbljYM9wzhLwJ+ShZoKD9HhOOLaXznMmeZEM+mFPklmbHn5sDssHQf?=
 =?us-ascii?Q?VA+RBokROJXWw8TqRcT3fAOpqHMTnLObY7GX2mC2vNNaP1wyW5ZDb+76NTzw?=
 =?us-ascii?Q?2KE4itm6UDb9T1OZcp0CLpbq32ByDgyxAd6KS4dsddvCfiW8iWxhMaa1SUGx?=
 =?us-ascii?Q?lWby7tvA8g8Ckn+sb5IAn/cBHG5D/+gHkWEuRqt0wGYzkD0kObwZ0RkuzrIH?=
 =?us-ascii?Q?QsN3IGK6B+v4mYNLzFgEbdtBrLw7WIvx6vlC8i7X9+B+W5uui5ixstqZkm2J?=
 =?us-ascii?Q?8p4daprfniZpzgGHNGRliquUzMHko0Va/ggVsnN6pPudnkMm9Sl47gKaXHXW?=
 =?us-ascii?Q?DRryzEssdtD8ziwxzb14JSBhUQedvVaLYuU+wVd/WJjNEN0lnSbBM+Nefb0g?=
 =?us-ascii?Q?9r31nmrSAW2Ux+8iUoe2teWTWC7N8fdqqTfB3IJ6QlQDpkj7s7/BMxcpXE3H?=
 =?us-ascii?Q?GTAqf6d5csr6PpcuvhI0A6NsL8Dk+cpeGJIvl2zGCOjdvxUfaJZnJRExp5Vz?=
 =?us-ascii?Q?IqDvMdV8TBCcCEGfjJlfh5E00TKj1Dtblsr+hO928oI1NJk8A/e2rP8Ji2LS?=
 =?us-ascii?Q?6KQioGZ1BZ6NB7M53Ns0L6Noizemp+WALq8qZcZGrKcl80Kxly4709cJOyt9?=
 =?us-ascii?Q?jAgdJYWjP7TL+hdXBSJm9cS6ASKViVcOzrkhXAiI8BMv2GAI5eLy3egPM9tZ?=
 =?us-ascii?Q?XuFzI0LOh02Gun3a7sLR88TrPR0muyE/rPOEB9L9Lo45fdfWi+BPxVoahdoJ?=
 =?us-ascii?Q?mqjJanVSXHAbOMxtbI3WFEBDTNbkMEqOdDhGT/Bx6BLXrjW9GrvVZYRacnnN?=
 =?us-ascii?Q?1S5L+qo3kh56UX1RSQjvt6sABD+wMkrRFnB5XzDd8MJ0qKRTWQP6rZ3P7YRj?=
 =?us-ascii?Q?xqdEEVTc1MtrcGclAtJGJ5BarwjCtzb0OHP+3HNK8+MTORCbNM+XL78tpjnY?=
 =?us-ascii?Q?8zjTq1kXc3sz30n9yg5Av6Nd75lpJOuGNiJLvAxndigAj8dKZpDjn6CMuaYH?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3S9A/pPhUD0F3dbLO7zcXKb5eigQe8oSc9KQGTkMHukkZrzasdwCe/7Ys6zLeCIgeiqiRGLJ4n4MnAEBi6m/sxqemQMkZ3DuZlsGvmx7zFRFL3jSt2TngoRH4zejt9s/SQcmMVlc1D2eAdLV4BGE/OQpyO0frTI8mIG5qvKJB+lvXGWI8I3EUetQTuy9K5l29FDuJs+R3A/aNU7D8eXqNvxjsKMz/GSXE8H0xMQiuHFBOM9yoc6PJ6VJNGJgQ45RqwIxV6JKaPe8bEPIv7aVZktMbFh3USONQkl6C/lg49U+zLdwiYElVx/kxyW516GsqSLy7imtKS7Gozl8rdyiSezRSkqfDT7wmhWZEqVASuWqQs8QAbpkLBl5EtvPnAGH0NMVdTA2WyYdaHwTpSMka2SC7GwOn3I61If5YmVR79KPBW9UdhXjf4nDlUo7Zjpe4x3BcwDaVRL6Ls37fpakIuJwlAHH0oqsQV2L3aBihLOKcBjQ+fq0tkvCXkmG2qV5GefG7zKCJ6mI6Jb7XLcM+9KTyu082iSjKkTdEUdsId8/tmZJbGvBmnItq80vQw9LnXk9F0+4/mj67evFVOlob1OPQcJdJe6+khsZ4bhAc9Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42204ac8-7579-431e-31c9-08dca115b8fe
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:23:05.0620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6rcLADfL3YwzSCvaSTFhEecTfi6oixWLGJ35CVyJ8q5Oom4j8VjefY7T3peaOtIVG1CoBx63tV1v1L+WG2M7TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7295
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_14,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407100137
X-Proofpoint-GUID: LczQ5RSvOBwM3NNqT1uWXz6mxqlhV2IG
X-Proofpoint-ORIG-GUID: LczQ5RSvOBwM3NNqT1uWXz6mxqlhV2IG

Extract all necessary operations that need to be completed after the vma
maple tree is updated from a munmap() operation.  Extracting this makes
the later patch in the series easier to understand.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c | 81 +++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 55 insertions(+), 26 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index babfa50f1411..bd3378935c70 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2602,6 +2602,58 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
 	__mt_destroy(mas_detach->tree);
 }
 
+/*
+ * vmi_complete_munmap_vmas() - Finish the munmap() operation
+ * @vmi: The vma iterator
+ * @vma: The first vma to be munmapped
+ * @mm: The mm struct
+ * @start: The start address
+ * @end: The end address
+ * @unlock: Unlock the mm or not
+ * @mas_detach: them maple state of the detached vma maple tree
+ * @locked_vm: The locked_vm count in the detached vmas
+ *
+ * This function updates the mm_struct, unmaps the region, frees the resources
+ * used for the munmap() and may downgrade the lock - if requested.  Everything
+ * needed to be done once the vma maple tree is updated.
+ */
+static void
+vmi_complete_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		struct mm_struct *mm, unsigned long start,
+		unsigned long end, bool unlock, struct ma_state *mas_detach,
+		unsigned long locked_vm)
+{
+	struct vm_area_struct *prev, *next;
+	int count;
+
+	count = mas_detach->index + 1;
+	mm->map_count -= count;
+	mm->locked_vm -= locked_vm;
+	if (unlock)
+		mmap_write_downgrade(mm);
+
+	prev = vma_iter_prev_range(vmi);
+	next = vma_next(vmi);
+	if (next)
+		vma_iter_prev_range(vmi);
+
+	/*
+	 * We can free page tables without write-locking mmap_lock because VMAs
+	 * were isolated before we downgraded mmap_lock.
+	 */
+	mas_set(mas_detach, 1);
+	unmap_region(mm, mas_detach, vma, prev, next, start, end, count,
+		     !unlock);
+	/* Statistics and freeing VMAs */
+	mas_set(mas_detach, 0);
+	remove_mt(mm, mas_detach);
+	validate_mm(mm);
+	if (unlock)
+		mmap_read_unlock(mm);
+
+	__mt_destroy(mas_detach->tree);
+}
+
 /*
  * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
  * @vmi: The vma iterator
@@ -2621,7 +2673,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
 		    unsigned long end, struct list_head *uf, bool unlock)
 {
-	struct vm_area_struct *prev, *next = NULL;
+	struct vm_area_struct *next = NULL;
 	struct maple_tree mt_detach;
 	int count = 0;
 	int error = -ENOMEM;
@@ -2725,31 +2777,8 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		goto clear_tree_failed;
 
 	/* Point of no return */
-	mm->locked_vm -= locked_vm;
-	mm->map_count -= count;
-	if (unlock)
-		mmap_write_downgrade(mm);
-
-	prev = vma_iter_prev_range(vmi);
-	next = vma_next(vmi);
-	if (next)
-		vma_iter_prev_range(vmi);
-
-	/*
-	 * We can free page tables without write-locking mmap_lock because VMAs
-	 * were isolated before we downgraded mmap_lock.
-	 */
-	mas_set(&mas_detach, 1);
-	unmap_region(mm, &mas_detach, vma, prev, next, start, end, count,
-		     !unlock);
-	/* Statistics and freeing VMAs */
-	mas_set(&mas_detach, 0);
-	remove_mt(mm, &mas_detach);
-	validate_mm(mm);
-	if (unlock)
-		mmap_read_unlock(mm);
-
-	__mt_destroy(&mt_detach);
+	vmi_complete_munmap_vmas(vmi, vma, mm, start, end, unlock, &mas_detach,
+				 locked_vm);
 	return 0;
 
 clear_tree_failed:
-- 
2.43.0


