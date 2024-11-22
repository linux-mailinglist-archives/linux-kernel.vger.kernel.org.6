Return-Path: <linux-kernel+bounces-418395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 241FF9D612D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D755C281945
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C15457CBE;
	Fri, 22 Nov 2024 15:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mwabIiU2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tK1f0wDd"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DE21DED7F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288513; cv=fail; b=LO3nYMPtzSO0EEKE284AV4jpacfMyXDMPwUC0hYwqpYEUIktu24FeplGmyujaUKqLuBtPZw8nHVk5XbeWbcdsDkiulKuZMmoPoXKWq7qOQyAoSOC6+i/vmjQhoEvaoXtAw9fl5hqgYd7UrkyiUC7FHtDR8L/Mg7OzmkzegeYejU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288513; c=relaxed/simple;
	bh=5kzPEJAckmmz3MnkfTAkEgaL0kpRkppMCVwIbpNZd0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eJ+i3ja7l2snD4f/UhewD5oikqxSEo8XAgK8gu+3KPMBe2hfSmhk+q/BGJA7wBGEvUC2/kEZRQbVIDCIaTD9tyfvVSRCD9QQLBbH88Topvdpwql7Wgcav6s1KH3a+n6bIiNE/hPZVQBzSyKx5z49wIOo/CCsfoA6zVkKGeY+lDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mwabIiU2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tK1f0wDd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMDFTC5000528;
	Fri, 22 Nov 2024 15:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=b0qKdHIT1Upcwq/vpQ
	CnUbDtNWZ39nRr8j80NIeCsOg=; b=mwabIiU2TdqGGgyzMlP6MCwPIGzKulhu2T
	UGDFu9SvVIsTBxfobvlPcrSZPMIQnfsP3WSHY+QVOyQWKHEnjuiLc3pDAeyCkwyD
	NQne6i9TRjHUaqBlg/xiuy3h2F4gZkun7HHJUBnVMGB1jl/EDV449rvlIscW0ypZ
	SNkOjz8tz/CBrCx48dAo7H2itTX9RdI91JU8Y/UbmaUoFTE3nXJj3ekSKbB4OgYd
	2A99yb4qqNXi1kkY3Znl5XSmEXbxAdKeuWghl9uwMoBkUn5eDWHTSi/ToCInukjx
	42eX2swVtCRwXPgmIBVHSfhOykvK3CCwcqSRUlu8oILcADDsekMw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhyymasm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 15:14:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMDoFe2037105;
	Fri, 22 Nov 2024 15:14:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhuddbxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 15:14:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4a9ntOXuPUJWfBslC+Bf571+/Qnsh9CyWPQFvGQonc2+3W5F4ZTDga6ZxK8RbElFGDDX1VC/sYDqP2vL1nRelNJZpsNfXPTlE0xDmqp/XQXdv4UdxiyEOz1jUKdlGPpNPlFbiQBGZ3b6Ai59Ir3kDaen1RoLWRkDU/lCgYW1DKD14MFMPpXTreN9ePdsi79okpUPNUWcGXfOehLxSTV8QCvIoDnAOtcweig/Vtik3PCKQzZC9YWzEe/8niYgPdlP58d/yoMEsCodzLQIUwZah4KlN8SPKP0eYe6+4Y6/6qaKvZGxWWxr1ixcAo53wWYrJTxDFIWoEeEL2nzO+Mq6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0qKdHIT1Upcwq/vpQCnUbDtNWZ39nRr8j80NIeCsOg=;
 b=Kph5ifCOmKzGiUQOAvA/lWlyaxhxFaGqqzy4V6HStptK9eUJZzoIe2bvPB0Mzb2rHsu5XYmjMRqrblvOxr+fTqq6+/CpEIjbq7pbOMc1DNUfF4MpHCJRMmpCOCyqT/4EdzbYLfR4bMtd6bPoa3B+G3gIHa+WT07+tlQpFx+hawdFHLI+fFqpV+Wes044RGzCWuiYwAdOH2g1I5unoNEsz5pd+UXSIy+tDAhA6vtcol2jPd+M7RYY/pk9lyDWiQnr+IaDx71DzI/Cn9eZHgDNRDBQwpH3q1Z/Q66Xw0mRCMOLdqSURbLMPrFkAYgJjCefFIEJrpdyiVh6NqYeUBkDMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0qKdHIT1Upcwq/vpQCnUbDtNWZ39nRr8j80NIeCsOg=;
 b=tK1f0wDdaZh/sOr3d4v+2RvrT9z5VLuAh1SBG0vaP3PvE8atWg6K24v1BpgZOeZVkv9KfaVfaB2egil1UGOnAh4Mkxjos4UmBBdpfyzX5fhe3/g2QNz8osRlqQSEw4VY0s908zgub4HRZdYwfoLUR9jOp7GpsxLtWiRwDJ3whrw=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CH3PR10MB6691.namprd10.prod.outlook.com (2603:10b6:610:142::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Fri, 22 Nov
 2024 15:14:28 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8158.021; Fri, 22 Nov 2024
 15:14:28 +0000
Date: Fri, 22 Nov 2024 10:14:24 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, peterz@infradead.org, andrii@kernel.org,
        jannh@google.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
        mhocko@kernel.org, shakeel.butt@linux.dev, hannes@cmpxchg.org,
        david@redhat.com, willy@infradead.org, brauner@kernel.org,
        oleg@redhat.com, arnd@arndb.de, richard.weiyang@gmail.com,
        zhangpeng.00@bytedance.com, linmiaohe@huawei.com,
        viro@zeniv.linux.org.uk, hca@linux.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mm: convert mm_lock_seq to a proper seqcount
Message-ID: <qvidvc6rxwacauspyvrkpfjmv4ear7g54zvsmh7prrbzeli4vk@wwjhvzsus77i>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, peterz@infradead.org, 
	andrii@kernel.org, jannh@google.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz, 
	mhocko@kernel.org, shakeel.butt@linux.dev, hannes@cmpxchg.org, david@redhat.com, 
	willy@infradead.org, brauner@kernel.org, oleg@redhat.com, arnd@arndb.de, 
	richard.weiyang@gmail.com, zhangpeng.00@bytedance.com, linmiaohe@huawei.com, 
	viro@zeniv.linux.org.uk, hca@linux.ibm.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
References: <20241121162826.987947-1-surenb@google.com>
 <20241121162826.987947-2-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121162826.987947-2-surenb@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0363.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::12) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CH3PR10MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: 1347deb3-ea16-4f63-2338-08dd0b085b6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m3splGXupjKJbAeOsciUe0jYfFPzT+Bj4i26i14aVBHfBRpTkuyDcWGiv9/G?=
 =?us-ascii?Q?DevJOhClypdZCSCc0dd5olGo5IjSN1JTbSMmO+0JphlEdYzTYtE3C04/0Jd+?=
 =?us-ascii?Q?qGpnxVDUFIaDz0ndO9JBTO5q65bIOZ36yjKC7rOSGjFoE7hwR44NSgjNKyLM?=
 =?us-ascii?Q?wCf8N0XwJO9q6HXoMWOGak1Mch9+H00Y1aIKRW8YzKpvxqDxHI0Io1LBubet?=
 =?us-ascii?Q?0Vr+sdWToDd2nj5zM6iwWPnLNufVhI6R3kcoKlMd9YxLTPzavURUQoShD3Ra?=
 =?us-ascii?Q?Aym5DvyhVbu3JDXHKtIRaHPc/xRJFu1nlkRVqcSqv4BJ3Qv/oUdRi81jLmuQ?=
 =?us-ascii?Q?qE7j6SAJbBUJMGuwopzxI7Yej1K9mNV9dVuyy0E2VQw8j2wXO2Zn0YNcUYck?=
 =?us-ascii?Q?U3w0pPu8ZGqtIRyOMSn30FsWJqauGOVlBtCSYHmBeL+GzH7gZ4NT75gPOI/p?=
 =?us-ascii?Q?ZaZvAj6SksWeiT9dSU/1mAjWUFqydh2w6fgN5Mn1+3iZhRHB58qyPafZz3SE?=
 =?us-ascii?Q?cve92SeKZgg7dcd/TLzKgl6J+B1624j5lIMct24EX4d/G9OKg+DuT+J3t8Up?=
 =?us-ascii?Q?aaf6ywpEiirZlq3SIFoMpG3WHBHKsSqpulRlSwaFCoNmeRYMXFH+9fx4Rcgd?=
 =?us-ascii?Q?CE6A5JW7BjP8fcUpaVq1iIlWjhRIREwajibdhd/zmyJ/Tu4AwLoXunBbaQKj?=
 =?us-ascii?Q?/oDTzx4h580fxByI0eb8Y3pGxHHl99DFTf8H6lsyJfjdFUJy+xZEecNwoMzn?=
 =?us-ascii?Q?wWaQ75u9grHP9lhJpveozr1vzc0e9xXd2LVei7poJf1ffK+vkO3M7lI/JxJ3?=
 =?us-ascii?Q?r3XjIKNLMmid+qlw145rhX7dQmEQGHeA4G+/Lg6u0Bi/GwcdPLzpJOqOKPGn?=
 =?us-ascii?Q?ch2YcIFRNOSklkf+L7WYEBMxbCjfE2zG0A9vmSyHaalYbItK4MzPNrby9Cqb?=
 =?us-ascii?Q?9zJJjPAwcK8Hxt0GevUnMXj8g3QefebKzdFkDKPI4N+0o3XwE3lPGHZjwMqm?=
 =?us-ascii?Q?kKyOZ8DamRT5zjq8lCklyAw1jdRJ2FuIuPnVy9e2GcTf8hGIq1x8r99D6B8+?=
 =?us-ascii?Q?2qhy+7VESZyGGOuGJPdZEZ9FXfMomuCoPXCJcEtDKOICXeMHqFp+jsCDvo2z?=
 =?us-ascii?Q?ICw3+x2bettQHlKnRAgecG537PXI1eENGWHZtZBT4ESYcyzwEAoIWTTjksBh?=
 =?us-ascii?Q?POUAz4YWn6IB6PvIUVpfd6/8ChL1UBrFh5wd/pqS2LI8fVbaLYNor79+PdN2?=
 =?us-ascii?Q?ftJ5AFfCm7MXeXpw5eV+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UQwsGWVS0u7h1gyA+rKnBuk7fErykwiXZI+QDIBswp5QEf47QYwofwaUWVa7?=
 =?us-ascii?Q?Zu5C0LnUKT0YV+rlwSDV3+wvr1gWEM2CHOlvdoFrMCCBMrVgHjkKoql/PgIQ?=
 =?us-ascii?Q?RQMvRslLsb8KA4+avCH5TXmNPB3Gslzi+OXmKX6wnZiQm+LX7uat/hgFnG1X?=
 =?us-ascii?Q?vPRyeMiIvDxgRED07Dh+JXz+MIaAEAIC2OjtTF5S4BcTRFhV8o6enn4zXLMR?=
 =?us-ascii?Q?rlxmd6OIJFszgH/2ANba1SWcdG275eHyhWI4tzz66lqpMqzXaVnR+GUInffk?=
 =?us-ascii?Q?UZj091HLVotcEGrZJmkOq2ZCGqPihHcxe2boNlL5N7g+KP6MijNOkNo8Ogo/?=
 =?us-ascii?Q?DGEEwDFbq+IuD/wk7pU57eq0JzgiCZAixzhm3efHnP0DjckpMURu2cx++3IS?=
 =?us-ascii?Q?Q3ZZ0RTHNop68APIm1FMpXRfBF0re07aerykt5zPKqwimr4W0pnJpHCF4xm9?=
 =?us-ascii?Q?oFUuPGsbs7jPdBMVa+Aph3hIAFCfznzQUN30zthgVtJhTxmnwUKIn6Yc+H37?=
 =?us-ascii?Q?9z9kBxQJZippbSGXYw8rYLKbU0gBjxWbUuNwA/fyAnWF70zkQe6jJnvyz4xg?=
 =?us-ascii?Q?ErGgC+OqM4DSRHkS6MFTaFFezoCA52ARYrZ8AesRwG8sls5BUqq8dzBhy3oj?=
 =?us-ascii?Q?ATt9Tq80fCQ6GJQ6dAm6YHP/PzgiJW4uvODFKHn99dHtjBacKdD+sorXRReN?=
 =?us-ascii?Q?Ld3jx8HYvyj9V8pupSvTu0EoJtgyVME4QgQUaQTXfnj7xlu50yJrvzhffKsg?=
 =?us-ascii?Q?z3yw0LFklSieVGCXu0lRd6yKIFodsyHvaoSInbA/e6c68qBCGLqdfwtn+0+s?=
 =?us-ascii?Q?6OEbadFop7yWEIMR+jUWXMFdqBd/cSYozz2n1AtWfhqGdlrcXT4rmvDleG1S?=
 =?us-ascii?Q?9wGXm5rnfgumBjp4I4WpQigxFDKNECi9TzQmCZBzc5WPibPiD9yQiAN7Ny/J?=
 =?us-ascii?Q?Xnp+kw+2PQtm+8F4I3L3gFQp5z1KmWp8EkTdtH5jvCiVQlE+Hr6T5wlMPzUG?=
 =?us-ascii?Q?L+fq4dqnHJwfdmo0WizxyPHxTGjjGkX0uA9Uyvz9gGf4sneFpZYoXZGa8clv?=
 =?us-ascii?Q?usgoINLsXJUZWjPyj9hGvBWsGlSCDW6yoPGXV8PDH4dMGG2TJCmA+mvRqwxu?=
 =?us-ascii?Q?ao9+tznUm1CFh0MSxiP031IEUwioDVckIqAHjR9dLwaQ+cy24C/U9vDrwVFE?=
 =?us-ascii?Q?ksM1tloKRD01lz0qq0jPQf5ncfSBx1m7unLMpUqeQs/MrdJBLcAJkBnsVqCW?=
 =?us-ascii?Q?vRfD43qoDBNADGiZySfXWbaxjGWYdxtOZKmu4q8CvgHvTSBLVrcMSnc/m9lf?=
 =?us-ascii?Q?11C6rhRYF8ttZ/bN7XRkoFSrDmFsoNNiRU4KCRVQaQlbM54WlT1aMkz9WTiY?=
 =?us-ascii?Q?AhjpxNWO5DkDHVIG0jsXxM4omg4tFG+vCyF5AI1phxNXuE9+8ToqPoXcDF1P?=
 =?us-ascii?Q?KoAWStqlthDfAT6RyfRyPW5XUdJkXQrHPbdM9ZM1Z22/gDIja8i2/EoHlzn2?=
 =?us-ascii?Q?fS79MnbPIRMbvjS/PyNhLUCdRwOFJWXFiYarKP9eYkxFgq+6hOxv7/xVtjU6?=
 =?us-ascii?Q?TC2WUw6a0bzcMffipfVmmuDNzKFGyK9stJ8KiinP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dSmh8S+yUM9hZYwnMigY7Ugyl69OSqC95LUgxZZ5DRA26SxUrnUHPcbpRF5l8cRbkwGg8neNBu5oKUFyY6n0/0Ckq2aLi4r9mKl0g4wQ/yg/EEBlOh1hb+ZJl6gRPge6zXN/CqvqYrsXv9PgeNhdYaRX1Q23VAdoAWd0dQ+q37NlkudniBM4F41fT7513EFM9nF524V6CsNA+pLNYYZB8ovdue5Td20MSGEyU41CTUlPWUPA5E5FVZBWByFIeg0+0QrKh3wbf0HBjNdI16XIsVs2mbhp+Zd1IFZkpnfif8byYaiVGDW6x7lM/dp0eAfcF0rcBJQXMfyH8NHb8ozcP+7y0VUEQWvpgwVnu9I+bDULzWSySCIQbxqlqd6QLdVHo4Q60msH7G/c7qse7TBF8hCNq7D3oWb1QrCAnUa546u5/R0udHA6vGceclNToMB9xTdigEntTu0HPwzJa4bJKN/mHk83ydj0kQn3WRkiJvsK8U1Sh3XdU7+qMRLaos6aZX53LS7VQ/iJbmkfC4HoasqK++CjAVh9XvSvSzqVRN4poezy7OI4WZST049RcqR4iPUhwmnrZPnMJHrGdeefuK1aTxHxyitp5mAIBRo1Nq8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1347deb3-ea16-4f63-2338-08dd0b085b6e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 15:14:28.0104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPzSi2RXXaKrmsDt1efnw6YBcj0l0HMWG3gGQOO5IC67G/ZXtmXJqehJeCc+l8t7dh7O5VGHy0zXWHK1tUqMuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6691
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-22_07,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411220128
X-Proofpoint-ORIG-GUID: FLJrgvdQGkrq-7P2V4A6ScGOtaOr7Q6g
X-Proofpoint-GUID: FLJrgvdQGkrq-7P2V4A6ScGOtaOr7Q6g

* Suren Baghdasaryan <surenb@google.com> [241121 11:28]:
> Convert mm_lock_seq to be seqcount_t and change all mmap_write_lock
> variants to increment it, in-line with the usual seqcount usage pattern.
> This lets us check whether the mmap_lock is write-locked by checking
> mm_lock_seq.sequence counter (odd=locked, even=unlocked). This will be
> used when implementing mmap_lock speculation functions.
> As a result vm_lock_seq is also change to be unsigned to match the type
> of mm_lock_seq.sequence.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> ---
> Changes since v1 [1]
> - Added ASSERT_EXCLUSIVE_WRITER() instead of a comment in
> vma_end_write_all, per Peter Zijlstra
> 
> [1] https://lore.kernel.org/all/20241024205231.1944747-1-surenb@google.com/
> 
>  include/linux/mm.h               | 12 +++----
>  include/linux/mm_types.h         |  7 ++--
>  include/linux/mmap_lock.h        | 55 +++++++++++++++++++++-----------
>  kernel/fork.c                    |  5 +--
>  mm/init-mm.c                     |  2 +-
>  tools/testing/vma/vma.c          |  4 +--
>  tools/testing/vma/vma_internal.h |  4 +--
>  7 files changed, 53 insertions(+), 36 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index feb5c8021bef..e6de22738ee1 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -710,7 +710,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
>  	 * we don't rely on for anything - the mm_lock_seq read against which we
>  	 * need ordering is below.
>  	 */
> -	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(vma->vm_mm->mm_lock_seq))
> +	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(vma->vm_mm->mm_lock_seq.sequence))
>  		return false;
>  
>  	if (unlikely(down_read_trylock(&vma->vm_lock->lock) == 0))
> @@ -727,7 +727,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
>  	 * after it has been unlocked.
>  	 * This pairs with RELEASE semantics in vma_end_write_all().
>  	 */
> -	if (unlikely(vma->vm_lock_seq == smp_load_acquire(&vma->vm_mm->mm_lock_seq))) {
> +	if (unlikely(vma->vm_lock_seq == raw_read_seqcount(&vma->vm_mm->mm_lock_seq))) {
>  		up_read(&vma->vm_lock->lock);
>  		return false;
>  	}
> @@ -742,7 +742,7 @@ static inline void vma_end_read(struct vm_area_struct *vma)
>  }
>  
>  /* WARNING! Can only be used if mmap_lock is expected to be write-locked */
> -static bool __is_vma_write_locked(struct vm_area_struct *vma, int *mm_lock_seq)
> +static bool __is_vma_write_locked(struct vm_area_struct *vma, unsigned int *mm_lock_seq)
>  {
>  	mmap_assert_write_locked(vma->vm_mm);
>  
> @@ -750,7 +750,7 @@ static bool __is_vma_write_locked(struct vm_area_struct *vma, int *mm_lock_seq)
>  	 * current task is holding mmap_write_lock, both vma->vm_lock_seq and
>  	 * mm->mm_lock_seq can't be concurrently modified.
>  	 */
> -	*mm_lock_seq = vma->vm_mm->mm_lock_seq;
> +	*mm_lock_seq = vma->vm_mm->mm_lock_seq.sequence;
>  	return (vma->vm_lock_seq == *mm_lock_seq);
>  }
>  
> @@ -761,7 +761,7 @@ static bool __is_vma_write_locked(struct vm_area_struct *vma, int *mm_lock_seq)
>   */
>  static inline void vma_start_write(struct vm_area_struct *vma)
>  {
> -	int mm_lock_seq;
> +	unsigned int mm_lock_seq;
>  
>  	if (__is_vma_write_locked(vma, &mm_lock_seq))
>  		return;
> @@ -779,7 +779,7 @@ static inline void vma_start_write(struct vm_area_struct *vma)
>  
>  static inline void vma_assert_write_locked(struct vm_area_struct *vma)
>  {
> -	int mm_lock_seq;
> +	unsigned int mm_lock_seq;
>  
>  	VM_BUG_ON_VMA(!__is_vma_write_locked(vma, &mm_lock_seq), vma);
>  }
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 381d22eba088..ac72888a54b8 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -715,7 +715,7 @@ struct vm_area_struct {
>  	 * counter reuse can only lead to occasional unnecessary use of the
>  	 * slowpath.
>  	 */
> -	int vm_lock_seq;
> +	unsigned int vm_lock_seq;
>  	/* Unstable RCU readers are allowed to read this. */
>  	struct vma_lock *vm_lock;
>  #endif
> @@ -909,6 +909,9 @@ struct mm_struct {
>  		 * Roughly speaking, incrementing the sequence number is
>  		 * equivalent to releasing locks on VMAs; reading the sequence
>  		 * number can be part of taking a read lock on a VMA.
> +		 * Incremented every time mmap_lock is write-locked/unlocked.
> +		 * Initialized to 0, therefore odd values indicate mmap_lock
> +		 * is write-locked and even values that it's released.
>  		 *
>  		 * Can be modified under write mmap_lock using RELEASE
>  		 * semantics.
> @@ -917,7 +920,7 @@ struct mm_struct {
>  		 * Can be read with ACQUIRE semantics if not holding write
>  		 * mmap_lock.
>  		 */
> -		int mm_lock_seq;
> +		seqcount_t mm_lock_seq;
>  #endif
>  
>  
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index de9dc20b01ba..083b7fa2588e 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -71,39 +71,38 @@ static inline void mmap_assert_write_locked(const struct mm_struct *mm)
>  }
>  
>  #ifdef CONFIG_PER_VMA_LOCK
> -/*
> - * Drop all currently-held per-VMA locks.
> - * This is called from the mmap_lock implementation directly before releasing
> - * a write-locked mmap_lock (or downgrading it to read-locked).
> - * This should normally NOT be called manually from other places.
> - * If you want to call this manually anyway, keep in mind that this will release
> - * *all* VMA write locks, including ones from further up the stack.
> - */
> -static inline void vma_end_write_all(struct mm_struct *mm)
> +static inline void mm_lock_seqcount_init(struct mm_struct *mm)
>  {
> -	mmap_assert_write_locked(mm);
> -	/*
> -	 * Nobody can concurrently modify mm->mm_lock_seq due to exclusive
> -	 * mmap_lock being held.
> -	 * We need RELEASE semantics here to ensure that preceding stores into
> -	 * the VMA take effect before we unlock it with this store.
> -	 * Pairs with ACQUIRE semantics in vma_start_read().
> -	 */
> -	smp_store_release(&mm->mm_lock_seq, mm->mm_lock_seq + 1);
> +	seqcount_init(&mm->mm_lock_seq);
> +}
> +
> +static inline void mm_lock_seqcount_begin(struct mm_struct *mm)
> +{
> +	do_raw_write_seqcount_begin(&mm->mm_lock_seq);
> +}
> +
> +static inline void mm_lock_seqcount_end(struct mm_struct *mm)
> +{
> +	do_raw_write_seqcount_end(&mm->mm_lock_seq);
>  }
> +
>  #else
> -static inline void vma_end_write_all(struct mm_struct *mm) {}
> +static inline void mm_lock_seqcount_init(struct mm_struct *mm) {}
> +static inline void mm_lock_seqcount_begin(struct mm_struct *mm) {}
> +static inline void mm_lock_seqcount_end(struct mm_struct *mm) {}
>  #endif
>  
>  static inline void mmap_init_lock(struct mm_struct *mm)
>  {
>  	init_rwsem(&mm->mmap_lock);
> +	mm_lock_seqcount_init(mm);
>  }
>  
>  static inline void mmap_write_lock(struct mm_struct *mm)
>  {
>  	__mmap_lock_trace_start_locking(mm, true);
>  	down_write(&mm->mmap_lock);
> +	mm_lock_seqcount_begin(mm);
>  	__mmap_lock_trace_acquire_returned(mm, true, true);
>  }
>  
> @@ -111,6 +110,7 @@ static inline void mmap_write_lock_nested(struct mm_struct *mm, int subclass)
>  {
>  	__mmap_lock_trace_start_locking(mm, true);
>  	down_write_nested(&mm->mmap_lock, subclass);
> +	mm_lock_seqcount_begin(mm);
>  	__mmap_lock_trace_acquire_returned(mm, true, true);
>  }
>  
> @@ -120,10 +120,27 @@ static inline int mmap_write_lock_killable(struct mm_struct *mm)
>  
>  	__mmap_lock_trace_start_locking(mm, true);
>  	ret = down_write_killable(&mm->mmap_lock);
> +	if (!ret)
> +		mm_lock_seqcount_begin(mm);
>  	__mmap_lock_trace_acquire_returned(mm, true, ret == 0);
>  	return ret;
>  }
>  
> +/*
> + * Drop all currently-held per-VMA locks.
> + * This is called from the mmap_lock implementation directly before releasing
> + * a write-locked mmap_lock (or downgrading it to read-locked).
> + * This should normally NOT be called manually from other places.
> + * If you want to call this manually anyway, keep in mind that this will release
> + * *all* VMA write locks, including ones from further up the stack.
> + */
> +static inline void vma_end_write_all(struct mm_struct *mm)
> +{
> +	mmap_assert_write_locked(mm);
> +	ASSERT_EXCLUSIVE_WRITER(mm->mm_lock_seq);
> +	mm_lock_seqcount_end(mm);
> +}
> +
>  static inline void mmap_write_unlock(struct mm_struct *mm)
>  {
>  	__mmap_lock_trace_released(mm, true);
> diff --git a/kernel/fork.c b/kernel/fork.c
> index e58d27c05788..8cd36645b9fc 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -449,7 +449,7 @@ static bool vma_lock_alloc(struct vm_area_struct *vma)
>  		return false;
>  
>  	init_rwsem(&vma->vm_lock->lock);
> -	vma->vm_lock_seq = -1;
> +	vma->vm_lock_seq = UINT_MAX;
>  
>  	return true;
>  }
> @@ -1262,9 +1262,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>  	seqcount_init(&mm->write_protect_seq);
>  	mmap_init_lock(mm);
>  	INIT_LIST_HEAD(&mm->mmlist);
> -#ifdef CONFIG_PER_VMA_LOCK
> -	mm->mm_lock_seq = 0;
> -#endif
>  	mm_pgtables_bytes_init(mm);
>  	mm->map_count = 0;
>  	mm->locked_vm = 0;
> diff --git a/mm/init-mm.c b/mm/init-mm.c
> index 24c809379274..6af3ad675930 100644
> --- a/mm/init-mm.c
> +++ b/mm/init-mm.c
> @@ -40,7 +40,7 @@ struct mm_struct init_mm = {
>  	.arg_lock	=  __SPIN_LOCK_UNLOCKED(init_mm.arg_lock),
>  	.mmlist		= LIST_HEAD_INIT(init_mm.mmlist),
>  #ifdef CONFIG_PER_VMA_LOCK
> -	.mm_lock_seq	= 0,
> +	.mm_lock_seq	= SEQCNT_ZERO(init_mm.mm_lock_seq),
>  #endif
>  	.user_ns	= &init_user_ns,
>  	.cpu_bitmap	= CPU_BITS_NONE,
> diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
> index b33b47342d41..9074aaced9c5 100644
> --- a/tools/testing/vma/vma.c
> +++ b/tools/testing/vma/vma.c
> @@ -87,7 +87,7 @@ static struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
>  	 * begun. Linking to the tree will have caused this to be incremented,
>  	 * which means we will get a false positive otherwise.
>  	 */
> -	vma->vm_lock_seq = -1;
> +	vma->vm_lock_seq = UINT_MAX;
>  
>  	return vma;
>  }
> @@ -212,7 +212,7 @@ static bool vma_write_started(struct vm_area_struct *vma)
>  	int seq = vma->vm_lock_seq;
>  
>  	/* We reset after each check. */
> -	vma->vm_lock_seq = -1;
> +	vma->vm_lock_seq = UINT_MAX;
>  
>  	/* The vma_start_write() stub simply increments this value. */
>  	return seq > -1;
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index c5b9da034511..4007ec580f85 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -231,7 +231,7 @@ struct vm_area_struct {
>  	 * counter reuse can only lead to occasional unnecessary use of the
>  	 * slowpath.
>  	 */
> -	int vm_lock_seq;
> +	unsigned int vm_lock_seq;
>  	struct vma_lock *vm_lock;
>  #endif
>  
> @@ -406,7 +406,7 @@ static inline bool vma_lock_alloc(struct vm_area_struct *vma)
>  		return false;
>  
>  	init_rwsem(&vma->vm_lock->lock);
> -	vma->vm_lock_seq = -1;
> +	vma->vm_lock_seq = UINT_MAX;
>  
>  	return true;
>  }
> -- 
> 2.47.0.338.g60cca15819-goog
> 

