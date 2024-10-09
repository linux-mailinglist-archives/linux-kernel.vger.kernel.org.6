Return-Path: <linux-kernel+bounces-356076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4702995C1F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 02:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A3A1F23D6F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 00:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4485817;
	Wed,  9 Oct 2024 00:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z6FDi1D3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ra4tV7I9"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203DC36D
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 00:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728432676; cv=fail; b=rXrqA+/xA+pAlC9RvD9RP+AbLm5DRujABOVv0sd5mEVRiMnCdC/ycBqdIzH9cM6hJXKK6hkP2WeJ9AKtZP1nxYktFs0XMb9jSUVOrk56ykivKXYEID67K9n7lcGI+7LneEFpRYR74atyAt3OF+MRErPm3HwggYElFcV7UZz6vXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728432676; c=relaxed/simple;
	bh=5fzuYWtc+bZsh/kgHh3olM85LP3XjXAhFdxviPGiJ/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sbaiSgRmQbp1gPTfJ05/iQ5/f7enTVrYO+QM1V0DZmkRhPKOpku7iXWqM7Z8Bp33s+yxZnqGLDk0nLX2WQhQoQeTNCLNJO73VzTwj36/ixZbADru7JHiO0lHpSwAZfccPr+TjfHyBUMWvLMGBfDuz24Mymmhyq+2S3it0c/nx/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z6FDi1D3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ra4tV7I9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498JtYjF022237;
	Wed, 9 Oct 2024 00:11:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=9IPqn2bEpILhMe+Ln3
	k4xpwh73wR7gO7VcvwdtYNsVU=; b=Z6FDi1D36Azr+DXfLrRWvlemo7UbNLs6ya
	lSVgQtTWzQLInNFRD/348fQQQ55kSz7TnLk2r+y0ef9RJ8k/HRWZreYIrcq3wTjh
	LzQGTFFvXAB9TC1gXve9FoEWWy8peiC95y3eTL+0NZQHfX84Wv60Se5bGwSiUIGx
	C1yP3SGGT7WfhOS89a2sK8ScN/2GLiVnLMKxgBL5OM1EWKd2yTcvdDrvQnZUztNx
	eTQiGVi6WQ4WWPBuLaiZuHUcJvfqcSeqbwbY2jDN8h92mBnkFNrT8PvqIVJmY+kT
	CfAb0Fw892MsKE2xe7CEeLg6Jxy13crB98r+HkO/eLEWK5R6z3jg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423034qa2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 00:11:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 498NFeNQ031056;
	Wed, 9 Oct 2024 00:11:02 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw7whv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 00:11:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ccgwdbl3YEy1jWoXkB/QcjYXxlJG/M+ZpQ2ZZTG6l7FYmj1zWYOGGOv6AyPEKqLItJqQ6fVFxfN0slYArVF9CXvwEB3LlbI/1SS+1ZsSTzZi4ZkOwRJXj50O/0EqBCtDEIQ1+AGMlvCi2Wo9+qsh8L2LP80XqCN1hjK7oJkwAM5YjS3Gc/TVZR0BlJ2384jYSYmOt3mOjTVXyPW3grLMfGpz36eZljGAcHkf2L3bj/MJ3YpAjRvEVOl6jvondS3Vlp60fXoPeg+EAa/ZAm/CZ5wsNYEz8GENjsPy3lhFReGVOX2cvqIeepxHvpOX3ECAUU9MPBK3StxLgCMLUGSJSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IPqn2bEpILhMe+Ln3k4xpwh73wR7gO7VcvwdtYNsVU=;
 b=RTFLwO2FER5fefEz1FaJ+fmcS9c8tSvHL8/rBwkO2cjXf3mnmTgt82e9g1FfZYyyH0z4VYlDRH5H2FarFPudj1hk9yGsaWX44424iFmtkekZV63XHk+pmY9fs/XVPBpu+W7zRwePSX7X0LB2HdCMoiUcgnnzrjVTevlcxgqD48LVdXiQJnG+PlMdqK+/nytSWj+PJdlgUnnC728uZEZOZJudKHgxVj7kYD5L0gmht4yZXz+qgEA2ygIatb3L7yuKOhiLMhgVUw5PKYZj6GmfsqYkfkVt1aZK4LGz05Jm5u/Z9LkUwqGQKAsCumcSbaYpITRuTNsgbA56zbsmulFaPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IPqn2bEpILhMe+Ln3k4xpwh73wR7gO7VcvwdtYNsVU=;
 b=Ra4tV7I9ifTYzWHrPSHIb86fTwTB0qVZ4DczeHpVb34YA5umiH2OChTgV+n17IEuiyKsv60q8a5oMOnQWZ/aK+jW7ta71FI1HPe31LqEKwnhqHDYU6Qk1/1nFdKJ4CTK9HkWM7lPp1P7sKy1N0xmR5cKAyt1kycp3HrHr+e+IjA=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA1PR10MB7448.namprd10.prod.outlook.com (2603:10b6:208:44d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 00:11:00 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 00:11:00 +0000
Date: Tue, 8 Oct 2024 20:10:58 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] maple_tree: fix outdated flag name in comment
Message-ID: <fhsmzzdniegmipfpnqexw4dqcfbs42y77agisobf56ioeydfug@5kpgpsygissu>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jann Horn <jannh@google.com>, maple-tree@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
References: <20241007-maple-tree-doc-fix-v1-1-6bbf89c1153d@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007-maple-tree-doc-fix-v1-1-6bbf89c1153d@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0016.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::29) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA1PR10MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: 050d25f3-f9c3-4f10-8818-08dce7f6dae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yhq8b1M8lobOEtrzVTOMpxF+t1P7s/5SvPxX6giLQ5d8hFXxgIM6liYCsRcj?=
 =?us-ascii?Q?sHor2VJYU4EN05Ia6ZV5c0ztQsRtx5wC5RovCMFx8KNY38Nm8yBrIFOwDhr6?=
 =?us-ascii?Q?b4Oa5vrA8A+Q8jljoVlXZ71vFD2RKDam9QgedWxyk7U5YjbM+JZLzM2LWKfm?=
 =?us-ascii?Q?VOsPXqXPso2B7MWx+3w2DrrUAhWwYZB5+Le/nzvaZWnjj4Xn1J5pOhQssRTc?=
 =?us-ascii?Q?akmflpZjIHP/0Jg2gvsy1Yre/LlwBv5k6JR4QYPEIHfSEcvuFXSzkPgdfz3p?=
 =?us-ascii?Q?PcsIsoS+hwqJQuTB1Fn53Vhb00SScOgsjLvx59tj1t5vMrwL5rXwxot+wVK/?=
 =?us-ascii?Q?xNmRUvxA80TrnfeLntxHlzVFAmSJHpw3ZI32voAF0xED+lSD9z/HrUBfQJEd?=
 =?us-ascii?Q?3/jnKIZF7vVE3U3xKn6sM6Uevt3KPRHm5QadMfR8cypw0iRNWEqjEfnCWA6b?=
 =?us-ascii?Q?PXJaIFEJJsSbwuVxgp6JRwXxXOXSXFCPJGNJU7KNDVYi7sehMjRWi6S/NhWT?=
 =?us-ascii?Q?W3aM6CrshNKIdnn5005HK00Jn05hLfnzNaVCWXeIvN7xJetAdmvEIZ2zP4nl?=
 =?us-ascii?Q?9Wg3YxW5ZtQVmacjgBruX1NvBHzig2yldyDs/bDy/XueaN+J6TFrvHqQbeOo?=
 =?us-ascii?Q?r6VFxfQfTbngnggQeijOvBrWksMCi4wQ5LYTJU9GB7nvzRpguYwqdwMx3aY1?=
 =?us-ascii?Q?qvuItrx0QnIuA8CFITlyl+B0SS2494XxDyrW/StMDzjErplkvoBwu23okOQk?=
 =?us-ascii?Q?UNwATyyprcThxR100ivHKRdRoyRmEtZBKw/RNdcgnvEUT73yKhsC/VZUanD2?=
 =?us-ascii?Q?7gJi0TqweoEtsCl0ggbkxN35TvUBVf6gVdxdPEIy5B2xa8c9mEHjiHIV1ftq?=
 =?us-ascii?Q?T/MZPLdmg17TLu9hS5T55AehGNv7i/Gkn7Gv2EZfcL9gWW8sPrAO7hHh1BLk?=
 =?us-ascii?Q?RsHMOMC/FNwkBlz1Rg78UvdBQNnIws0jr87uGLWDcWj2MamTz32wFc55bK9Y?=
 =?us-ascii?Q?dZx55CNT4XxtQ0ZfGJyxistfhNLFD0VvxhNYB4PCOuYS0XzEJDLv7nDFxl6k?=
 =?us-ascii?Q?QvCk+dHCMRiH+Vz1fF98H0O0zEg/DtrVXNiXB0phTHthv7td2IhB27WdRXIv?=
 =?us-ascii?Q?PrkYff9goHhUH9EMQJqvwC081POCt48xqFbeUnA8XVyYcPlQhqJSHr9OI/pS?=
 =?us-ascii?Q?BjtTHf8SNwld+14eKbXKZE0fl42CmCJo+ChxXnTxVJqcp8Nb1ZKQu+1RR4w?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gW+EFS56YZ1080ueNq/UP5bGcYGrAl6bcOgkK+P4lhWTjmWxdfPv/GdPzmfx?=
 =?us-ascii?Q?QMQ2xgnADFF/jC0H82MCQxsJ/029gWtGD5Be+eVzn9ZLETTitN+Tn3mQiZCr?=
 =?us-ascii?Q?89kT0FkyRhKxPphlkEe/vdPdcMcgsK+dthK5oLRzzn8523llYZWAhIg1+Kdj?=
 =?us-ascii?Q?e38C4ChfKQV/2Xn/oXpbUgVoyzxjlThSqjdfqnvuhzgLbZNOgDlED77OO+EU?=
 =?us-ascii?Q?Bq48F+h+EpIoBrpiuBNkLPzDW3jTRapdrLnPA6u35Kj3DvM9TWnwQeEQi58K?=
 =?us-ascii?Q?+KVzjQkGVLT+BFBXl1i7eh2yUG7+zxSNYpLcxrULSW/SEOG+2TKVghYHVz6f?=
 =?us-ascii?Q?n2kQBwWncnCEMotn2uJysZuI1/7bW8Y8eTG49kywkVuwn01ngsGBDmbB25+W?=
 =?us-ascii?Q?RYgCpD1U5AOovCCOOyv3a6EhyzSonC2FGS0R479HdITH9AmCZ/S1FiVTMdMb?=
 =?us-ascii?Q?3AKFv8FH5hpg98uLCDIPy8AKLfIQ4JG/nw4ntfF97Ki4zQcGkSHQtyw9ua6R?=
 =?us-ascii?Q?4BosRuyztmt/RcsjiDlmnSIOpjKBGIwLw9vuz7GCE0p0F5iOirp+dGfxhodK?=
 =?us-ascii?Q?Eb4sFHGx7h2CbLLCBNnvqEDdSZ33rArd4RTyLtutCoOTA7J3fC5GGX7iD57/?=
 =?us-ascii?Q?Y5RzKU7k5q1FOuglWBBkLYI9erijw3O+ohgGtyePjIhW5ralz5r5dcUgp9Ex?=
 =?us-ascii?Q?NaoY0m+G1fPqzY7/fh8oHKDW5wtRsmqvgS9weBODYvZqgFpfFZIhqc2VrPwn?=
 =?us-ascii?Q?ebBSO4CsIxbkrlyggeHWYZmetfMahWSjettoLnA0yBrSzNfck1hkpNlxC3TH?=
 =?us-ascii?Q?AR9HIUWiHHmOjozhHSoogOjd4yt+O+tNK60GBNyy+6Z9OR26KTzVM+ZLyj4v?=
 =?us-ascii?Q?q1j7UouuYFaMzcLnYNzjjvKCGIZee7jyn/MirZWl+qSR26020AQ39aHal4pX?=
 =?us-ascii?Q?CO7JvQYpv9/7DULSqbs0wxBxyUqSGLKE5q6mgwSzgrpbITrb8GPl8+mUdfEk?=
 =?us-ascii?Q?J9ls9XXb4I1tXWQiZeqlqz8FQYAWEv6B6lqlgkTHrz/1k2m0ETYQSNISDotZ?=
 =?us-ascii?Q?pwWMkVxeD8oLgLNH3lESqycgMdKMbn0qjIv8dCnKd63Yb1kDIuXjwhpgrObQ?=
 =?us-ascii?Q?HOOdY1xiDq5+89EUSuC83P45cuXYga6RETo80YdPa5LEGhymZktR15L5GA5w?=
 =?us-ascii?Q?ZlAWZnbgfbfzbmH7NQWuSObz/quUaIEK5DKzsrQI/Iku/Rd0N5Ffhd3ILLVU?=
 =?us-ascii?Q?aayuN64A4eqlvMMfga1e/XAfLP5ch3nmuLJ05NfyfriD1pyCfXtoWVtJnnnT?=
 =?us-ascii?Q?tfnrq0Nx4ekFCxGFazIDxNH6eAjKhj+hD7SxwWzawcHl4n8ZmlSb+UDfACER?=
 =?us-ascii?Q?OuQnXHkjFcO3SbinWrr7d9gun/wxFnJGGvMMfUuGLgP68M2DLheQiYwnq96E?=
 =?us-ascii?Q?JifqqmmUhJ2u9GxQbss4/Iwnrg6b5BmLZq+T/O/aho94tSktsH4R9UgVzsTf?=
 =?us-ascii?Q?GskiG9RWIQXN4zAUIQSNQ8HNm1j2k4CPnVVJACDGQB2/0EwIpq6NDo2+Ani4?=
 =?us-ascii?Q?ahAJeqafQQkn70Uky8H7yCM+qZ89E8KBxlH+sX2L?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6ifQzvsVjIGCenEcLQxl+sn/RqNpQP45EkrbZMaIdgfC4NCjF+LnidGlbNNBVOhjyxQDhIekGiz0lkD4ITB8bKt4GDVeBxeiQ5XtFXj2bFXPT3SBJ3VxPvYmffsiGSDaJ1Ol+/zNA9ogshXA8uuPSIzq1lJ8oQYOPzKzXiXBZABT2IqwknuJQ1Azrj6+39tDBxJOEhGvBVlNKlBl/zXx3/o3TkfV23LRmldcwqxzVb8FE8gJ0ECuRoXkfAJEsjB9ECfEU3/WXecXvjl+zqeBNixdo/5TWLCQqF+HpZeH3uTZkUDv4sJPdoEwh6SUhBm4W4oMsSNsnca50yOqHZSHJ1FpEY1v14S1OyOoIk6klPhCmTRFlYVxVR9Q7I0pGZLEK6P1BWK1fa09uJpz9brX5JOssp++KaojepVanbV7lsv8gZ4bfrVszS00Gy8zRGPwHUottg2CityCBdSQGGqhCrd19+wWHdzNUDydA4B7mkn2eyY2EDTnkcOitr5bnlUHqzYU4+IsvHTLxwl0S+HtswitTIRXaDX4RvHHV0AFRw7mFvsmlXZCrFgUt5KB7VzUpGSBJE+jcGeW3KLfLwlzcCMJjZ17Rdt5Gd5XjtDpEPw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 050d25f3-f9c3-4f10-8818-08dce7f6dae8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 00:11:00.1832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JEnoFP1pv6LwoenIZRJOTPShgJnR3Xk33DFMA0Oz27x7wBCL+nVf9tUz4YpnhfnGrfKOlrnH7YwuVKcXglU4WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7448
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_23,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410080157
X-Proofpoint-GUID: nh5Pkh1UZEoT1hZ8NsXmVo8-gQqIVFKt
X-Proofpoint-ORIG-GUID: nh5Pkh1UZEoT1hZ8NsXmVo8-gQqIVFKt

* Jann Horn <jannh@google.com> [241007 17:48]:
> MAPLE_USE_RCU was renamed to MT_FLAGS_USE_RCU at some point, fix up the
> comment.
> 
> Signed-off-by: Jann Horn <jannh@google.com>

Thanks

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> ---
>  include/linux/maple_tree.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> index c2c11004085e..61c236850ca8 100644
> --- a/include/linux/maple_tree.h
> +++ b/include/linux/maple_tree.h
> @@ -224,7 +224,7 @@ typedef struct { /* nothing */ } lockdep_map_p;
>   * (set at tree creation time) and dynamic information set under the spinlock.
>   *
>   * Another use of flags are to indicate global states of the tree.  This is the
> - * case with the MAPLE_USE_RCU flag, which indicates the tree is currently in
> + * case with the MT_FLAGS_USE_RCU flag, which indicates the tree is currently in
>   * RCU mode.  This mode was added to allow the tree to reuse nodes instead of
>   * re-allocating and RCU freeing nodes when there is a single user.
>   */
> 
> ---
> base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
> change-id: 20241007-maple-tree-doc-fix-db016fe321ce
> -- 
> Jann Horn <jannh@google.com>
> 
> 
> -- 
> maple-tree mailing list
> maple-tree@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/maple-tree

