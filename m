Return-Path: <linux-kernel+bounces-556070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 907ABA5C08C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2BA177644
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221CF221F24;
	Tue, 11 Mar 2025 12:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K6YwqRKR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MriwHf97"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600D825A35A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694773; cv=fail; b=KCTuiD/WmoLN1lLNt3D6FRLXKrOI9wC/mUt7kGkAYlGa/bEsvy69c1UAvTCeycqEYh8rbzAkjojV+JVWhj1LWFc3C3RBmH6KvqTno5B232AauPRx5VoXJ+eK+PRhANkMcIMu1icM9kH2l/qJQNWBE4yn0Xjsql9THFZZTXA7vxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694773; c=relaxed/simple;
	bh=iN08r/okh/cS6qcvrPJRiMNY9rbIYA+v+L3qNt3MBQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hHi+AFPxlXMgDaSSe2AACh1cJOMrEuJe4Ql4iyhZHhPgcXy245dvA4uzSsdZpxG2IkFhNqOFfKudyE3KAbZfOjKRStWOBhzD827zXLtgcKd6Ef0ilSZMtg15bRnOBinvt5Ex6V98sxjbXMJsTchoywmT3unsT2vaUDFSFJdo68U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K6YwqRKR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MriwHf97; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B1frpR025383;
	Tue, 11 Mar 2025 12:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=8fjJck9h/5tlXk2lPL
	mQlJ8X5fhg4EUrpG/aKLLBRI0=; b=K6YwqRKRUOZ7OBKfjGbrvO15Cwfk4B7Xz6
	YkLiKAfsDHpsOvyHPnuiOT6zE5T01kJ/sqvpa9fcxz2fvQ7i823fFGTWJT4L8Pbc
	EBs1x62lCuyvzXPIuK6RG4zXe1VHuxNyETU92y/WBvLvhzOJnALuh8KUInh3UpN4
	bQGwwFDtw9j9qEGSIGtL/s/lmBNJVPIYCrjebgcWN9cRmvJEET/P5ML52xxpjZ/Y
	dpu9/olHJE4tplLzgY/VhN6xIFGehPzQIpt9A7lBO6VvyKoSZLR2norAEaVEPIb0
	QaDFTGT7359ONz5a9eOhJIc4ZSIaHZW9UDlUU58AMjI36JqTEB6g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458cg0vqfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 12:05:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52BC2CIM021385;
	Tue, 11 Mar 2025 12:05:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 458cbffbax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 12:05:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIJkgkV7vVIou4t5XMa4BJcBlf3GMJz3nEi2cDN3zaQ/naFskvuHg2CnqDVraJtUnLL4CtlSMTcsxXuj5YubmzCZnwRivVBoKi9vIOyGubThTGnXnNxWdBz0C7Bsh0lPKpBeJrYcqB+dUUKmf/zQJJmUDPHS/EI5OG+uqY/2CIDemqC8GVjHNRhpuMK9plX333h5kmdaqiIjydT1jEHB+eI6zZKfCNw9fi6VmaEv/kDcTcLpBBVtfzqQAHNUOXiGkzChLUoghO5HiGkNumM5cHsJaU6PODjOUuVTWIEEsykSPSQhm6pxUc2gxyOWzzVs8sWNgq1ZJrSlF2ErL4vGDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fjJck9h/5tlXk2lPLmQlJ8X5fhg4EUrpG/aKLLBRI0=;
 b=qs4lIfIGwNlQP/Ou4xtv+R0dcTE+HyuLgW0yqAwpKLncC/8nzZCSCmC6OnjMH/LKrRS4oRdBgKyuUDvqw0+C484cImcgEX3Ode3hWDrOdw3Lgy/8PFF6mf7Pz2Ptv7MSgVz8xm5ig3A2sI0ehu5VeeAABwFd+IBw3jnM3X7tYwzexeupPPtbNKCi0kriGa45YmklWHmq0ywpUPZvQsvDEoJIj0Ak/+lg8crZlzZi/W86+l7AX7Us7vhxAtDtFdLLxPLOPYbsw3+YxhW8a9Hn/kXke5Srs3+Q9dWOPOX4VXVJ0PmtXOtCxgg3k0qNY79ojuBLXNScDcaP1xuJ8idl3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fjJck9h/5tlXk2lPLmQlJ8X5fhg4EUrpG/aKLLBRI0=;
 b=MriwHf97JIvzwl83ljg1qfMJmHq/huTxCP/jHdhXhTdpKkA4s0RBWh/WQsDzbRGlc8uw3kDgD5fb0Bz1GjCbnw5zFOSYUqT/CLHLuUa+eaDcuY8DqwgrllB3faJFdoN1ZS4TQCatWTeB253lCKK+3KiIS/OLuC4s5NJwKXHlYEk=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by MW4PR10MB6299.namprd10.prod.outlook.com (2603:10b6:303:1e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 12:05:46 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Tue, 11 Mar 2025
 12:05:41 +0000
Date: Tue, 11 Mar 2025 12:05:39 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <howlett@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 4/9] mm/madvise: remove len parameter of
 madvise_do_behavior()
Message-ID: <5dce5c3b-b20b-49b0-9e28-7909ff81500d@lucifer.local>
References: <20250310172318.653630-1-sj@kernel.org>
 <20250310172318.653630-5-sj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310172318.653630-5-sj@kernel.org>
X-ClientProxiedBy: LO2P265CA0205.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::25) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|MW4PR10MB6299:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e54534-825d-4f07-1f76-08dd60950b10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rQzNpo9Rhawq9wmplHMoFIHlKNzSkHn228mH4RXMFzdXOAvVebHF335RxHPQ?=
 =?us-ascii?Q?e81HSRNKB/a361vj6kqqvpdW3eaXahdKiI3pv5E0A+isHiuxpIWzuiYvNcOR?=
 =?us-ascii?Q?ZGuYNJBJZ3g85FsIO6ceUD/8Mq42mRSQgObhmhBKUDaFN9363ipVJxA0iD+A?=
 =?us-ascii?Q?9zwOQvIriyQeOsv5zgLADMxSIAuSpdCIairZ6Td90ryk/Wq7Ix3lpDLnqwb2?=
 =?us-ascii?Q?B5YkKT1m2AojrjRSlGfxkGe6jcdLmMjwI0MCV7n9DmpiEYi2juQpRixZIjWO?=
 =?us-ascii?Q?rJKgQlj0ALEjUSpUVg2g8liA+WMevR2h9jx0bhkLOWdyQ0u/82PGfUjdxShG?=
 =?us-ascii?Q?DUMpjPYx0Qnc1pJeiLz/QGsmVOZ5Fx4U7zHQ5f+pi5APW+xU9I/9PSGrNvFU?=
 =?us-ascii?Q?bvxVAb7zumZrh/x8myYRm1vORoFICLXPwNzq9/jrDTtK8/Y3k8WfEg2D1oFH?=
 =?us-ascii?Q?NaVw8pFOaIJyiI3MZ4VqTeCmEv+iluWW7K0CTvm1SUFohqZz4sDlqrN6Z+88?=
 =?us-ascii?Q?cHpvFoC0GWttTuCGEPTgDBXSBqDLbQSzjV+ezza9yQOjLU3lfRnaZ+MX7i1M?=
 =?us-ascii?Q?6VmZGq0VY+BkKfCWFHbHOjTI6eEnMbYDxN+bhm8XTLqkNNP8xcvkv9wAqCDE?=
 =?us-ascii?Q?m3A0J32meDg8MAcCRu/tkbOdl9reW90/I1D0ZuMpDzaEXQM5bzdjy/qC3QA/?=
 =?us-ascii?Q?moG78m9KUcIj+p+iFKOOyaYfGhj0LAMu9wC5O6q5pcpHdglmDyygjCvlJBcO?=
 =?us-ascii?Q?wk6a5TE/vDZe2Fa+QRUrN8vRK+3EUT2Iedq+M7A0IruLJk6QD8jnaYgwAJJ3?=
 =?us-ascii?Q?Rhs/rWwa61r2notzcJVHPjKpSqlI/atUr7t0Ou2AVqA0Xhobb8t5Op+z0XCG?=
 =?us-ascii?Q?FsQouqppMfzc8A4PYXotWfnU8DEXEMpnTInZHjGgccBJCfNBisnlZiJ5NUGH?=
 =?us-ascii?Q?ELb4aGzHkaSUc+K9YEMRh4NseQolWfTXtocsJnTebp8752VpG0MWUDuiDgt6?=
 =?us-ascii?Q?uVrIrsPw/Xi2PxfaLuGeQfJjVtLZXyO1kj6OTOHQ9i381KJ92/Pc907vFSLK?=
 =?us-ascii?Q?MyEWxNyxuSQP7pL1PPZ2euhx8FdqsZjUrAuOR+rha+q55i37/3D16bg14L7w?=
 =?us-ascii?Q?SFokIcLEdmiP8OB68cPuA81ox34Czp9PTq0vEUrVy72cWprKsAVoazflgKnm?=
 =?us-ascii?Q?s9rlzSfzSyo3zpGDDwoTIvWvF8vGmUqnjueR7sugSsuLDZgmcz+zuiVu0cOH?=
 =?us-ascii?Q?aIJ7krBaKahi910gewIpbGCTW6nW9NVU4ea+V7vOd74ZPUhGQZXLFkeq/p7S?=
 =?us-ascii?Q?+gKzRw4LFJsZtNSjLo6/x2wInhaZTNHOV+EDrwWatPHFCx8RKdwXBH7H+agg?=
 =?us-ascii?Q?eb+LwjjQAoQB37LHB96tUZIbQmzg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/NLIr3BtTiGlk4qf9Ht9AHkcGFA6U5WHabZMbbj90/Oz333t5UackX4kYBPX?=
 =?us-ascii?Q?4F7lrGoloasApvWbIotxVnwlDpiGakOb5C/F2GyYSDvKSuTlGMKbblJX+TP0?=
 =?us-ascii?Q?LXsw5blXs9Vhj/hfYIJ0wsfDDAfj+dCHzwIfpA4Nv6kD2erLG2TUQBpX678P?=
 =?us-ascii?Q?xj37A7oJJGlTu3lm/SU/aWnPUkvi58KMZ0sMM7SjiqWDU8KzGBQxZTknm53x?=
 =?us-ascii?Q?XIDJkI0fgsk18uIJSeDaIiRQ2WtNzl42a9xTaX6YDyOHTRJY1VRVn/tqD1/R?=
 =?us-ascii?Q?ZyKDqodduu62tT+gfNYdiwU5TSOYK/V7JgG3b1ZL2qON1p4aytXO6AV+aV59?=
 =?us-ascii?Q?b7Vn2rSXFrcVaK/FSyDoQUrN/L9AroxAhBT/QMf64VGGo+zLmXIi+oENv8zv?=
 =?us-ascii?Q?RrCbzb5hS+yTk/PQ+sJf9lozZWJq42fzuKR3+8Hf3AzrRB8i1bFQErql5B8Y?=
 =?us-ascii?Q?GvuxwbZfhjprTSNhK40bOTQw7TtXw9QZ/IZ5lCovrFYBWCYi3LS6gRl667oX?=
 =?us-ascii?Q?XQmUwEEO2B0dvGw0iohjf/Yqh92rYuwArOu43lIW4z+fRSFJtb5UsnXV18MD?=
 =?us-ascii?Q?obucqvPybdgM0G4UH4oFOiOSeRHAjy7prjl896bJObYrdEn4rxxsZFajJrpr?=
 =?us-ascii?Q?Sdp8LC1ABTCawdKV3N2ACe1iEe4rewYXvK34QwpCf6oWm5Y2ZRo1MhfuHuwd?=
 =?us-ascii?Q?qd1wMaR7FAGwhC4brt2lH9lmo2dwWkukGR4+JMvPQBYyfhHQ1+StrPdh2gs2?=
 =?us-ascii?Q?BP3sQ591EwlzAD8+JrkuldmPcKZnWDRQNG60re2R7Shg9GdoKHq+1psMVjAA?=
 =?us-ascii?Q?rfsS7sIVcftKG4Uz1HR5YoaxUNUw2fM0tTEK8feo7/iYgbUxR6S3jpTeZGEl?=
 =?us-ascii?Q?DP5W29H3J8b3QZ2yJX7J0hbXbGfP/hw7+fKJRGx30tvnN5OTSAB89S+5oaA9?=
 =?us-ascii?Q?RQO8ZE9hs0r3wOSSKF82wFd6yrYPwvxnSDCV37Q3Igulo6JwlMYWIhxW8dea?=
 =?us-ascii?Q?rXjlAxN23396Vr1/rZzC+CL3qi1A2NVdOhEJxJQaOZp0atNDiED+tbBhibSY?=
 =?us-ascii?Q?YqO/of22+zm61fXgzlj9DEHV1apU8RdUWcp+hKVXAj5yYd8yHwh1qIZ31M8O?=
 =?us-ascii?Q?8pENh5s5Bnpl/KbAsY5p4sw7736kW6ONhdirXsAvT6Z09gwqsxjlkHTNPYRt?=
 =?us-ascii?Q?8RKUkwJTc7wk3zBZ6rCzYCu73JfsfW8/K13H9nKu1USr385nKydVDLzBIPuT?=
 =?us-ascii?Q?Sho2kM5K2VThIUU7yDS+UPaJUeMqAFK9hJUIrsU7H5kskvBqy4Wg4xBnMlde?=
 =?us-ascii?Q?pSZ6puNA33lkqxL1W0SZwWGoeie6CAbo6cfd/O0kVdKpFhod9YAyULVQMwyW?=
 =?us-ascii?Q?ZvtK33caYltwTC4NYiq2khCFwg+kyhZkxfz8oNLCMKaLZtRWAKeKNEg/Zz6t?=
 =?us-ascii?Q?Dnd3uwcW17vmjF632vgNS5PRw6jC6gBoEEx4GKSVSdasSBY63SbqUxNpUfth?=
 =?us-ascii?Q?5rYgwo/WZ5xARY4VzK59k5kO2phbbqXCXwAstRlhdh4BG6QqZBzGp54OYGtw?=
 =?us-ascii?Q?fROBbHymIPCllD3pquEO9mn+WFewcSSTtBlC0YXHXdar25euWFzkgLqTUz3N?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HHpc6mSb7pxbwsrIuDGdx7asfBou1LPCWzNmYmV0AOTkzpkaivYWnHMrvI461wwZFIqkjBdLKRGDQRFqreJ0NxIPP58+lllHBLk3aTvQk1anpPd7agj1llyVpzo43oclwwSzFrN1owBPgU/aRBfl3bKeNe5hplZfQM3kzD4DBwAHs08v9gPB8DAzA+W5LSgqllNewj60Rut62Ab70CiB4b+ReJKo+p7nG/YXnVbozDHtqzaoEtQgR1lN+zXFr3YAyS1HVByKW9+ZWW3fcouK+0BVj5STIxbarV+roYcoA4fOBFjXCIj+OTIDzDMmB2IfhTPQne1EYltTKYQRD5j8wajZIAnJaLSuZXBt5SUN81oiKA1utiQ+UnhHOSyp8b1ufk/RexdVFozcOgB/GcHxW5s4DO+/TJwIukGSquOOMSHPG2q09TA6MmtgZONQuc04SSKiYdm3E+tT3RSNGKHSC//TZKzH9xBkbuqM5UaIJ+H1zm2VL2sza0YspUcSFKrVTSMNtMnxXrIHUD9y7H7fYpsCnWZ17P/35BZfybdVZx4dGmKghfUIqWnyjpo0AfUt9/M2Ah7KFoAdMA9Gjktu+EaXPnrQlH3Ex3kM9j7m3JU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e54534-825d-4f07-1f76-08dd60950b10
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 12:05:40.9918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDB5DDtQKq7xfOFu6a2s27WqP13l6BuRlPVS8SPibp9cIbDXQF/Lalcte3NiBmVDV5CbmmGm8i6TlKsI06KB+Hh82AxqhHwoFE1oWQoMsnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6299
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503110078
X-Proofpoint-GUID: yi_62a0YWh3woW3dQcPK_pea5o7tVbEX
X-Proofpoint-ORIG-GUID: yi_62a0YWh3woW3dQcPK_pea5o7tVbEX

On Mon, Mar 10, 2025 at 10:23:13AM -0700, SeongJae Park wrote:
> Because madise_should_skip() logic is factored out, making
> madvise_do_behavior() calculates 'len' on its own rather then receiving
> it as a parameter makes code simpler.  Remove the parameter.
>
> Signed-off-by: SeongJae Park <sj@kernel.org>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/madvise.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 764ec1f2475b..469c25690a0e 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1673,7 +1673,7 @@ static bool is_madvise_populate(int behavior)
>  }
>
>  static int madvise_do_behavior(struct mm_struct *mm,
> -		unsigned long start, size_t len_in, size_t len, int behavior)
> +		unsigned long start, size_t len_in, int behavior)
>  {
>  	struct blk_plug plug;
>  	unsigned long end;
> @@ -1682,7 +1682,7 @@ static int madvise_do_behavior(struct mm_struct *mm,
>  	if (is_memory_failure(behavior))
>  		return madvise_inject_error(behavior, start, start + len_in);
>  	start = untagged_addr_remote(mm, start);
> -	end = start + len;
> +	end = start + PAGE_ALIGN(len_in);
>
>  	blk_start_plug(&plug);
>  	if (is_madvise_populate(behavior))
> @@ -1775,8 +1775,7 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
>  	error = madvise_lock(mm, behavior);
>  	if (error)
>  		return error;
> -	error = madvise_do_behavior(mm, start, len_in, PAGE_ALIGN(len_in),
> -			behavior);
> +	error = madvise_do_behavior(mm, start, len_in, behavior);
>  	madvise_unlock(mm, behavior);
>
>  	return error;
> @@ -1808,8 +1807,7 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
>  		if (madvise_should_skip(start, len_in, behavior, &error))
>  			ret = error;
>  		else
> -			ret = madvise_do_behavior(mm, start, len_in,
> -					PAGE_ALIGN(len_in), behavior);
> +			ret = madvise_do_behavior(mm, start, len_in, behavior);
>  		/*
>  		 * An madvise operation is attempting to restart the syscall,
>  		 * but we cannot proceed as it would not be correct to repeat
> --
> 2.39.5

