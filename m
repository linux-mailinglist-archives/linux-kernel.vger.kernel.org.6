Return-Path: <linux-kernel+bounces-294703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCB2959177
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 01:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B2B1C20ADD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 23:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1531CB33E;
	Tue, 20 Aug 2024 23:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SQYC+3Xd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PStfrdxn"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209ED1CB305
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 23:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724198303; cv=fail; b=lWYN3vBX0zx0CSiv7Yf6OX6U8hg/QfldUfPDEQMmAVfdhFWuV6JOI8LW9vSWSTzx5uYP+4sR8ayna2bu8Ytwyxg2aXfM5ulsngOvXSsfW/v0V0FeieD1J5qz/KXrBipJFtKVURLERs8faHwq26K6vxUp9TYgzONY1pg0W3sYTv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724198303; c=relaxed/simple;
	bh=27mDYeX/eSDaAX4xhTZE0VmdqYGn/ttgiTi4mpE9FYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WkIWQeyemE9fqZNWet1/E1BsCU8jM3HFEIDI47Pv4veEYuqHQHaPL5BXSHE0G4CrhkZ/CVakxnIg/GEH24RhfMlay6nYOxeOxL6G6dk62kbpqu53Q/Cu6FkYcO+vuPONGA+YMT+yisai3YuCBVyRIelIdmQCBWvJoGiP/VlVkRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SQYC+3Xd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PStfrdxn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KMBZcQ028784;
	Tue, 20 Aug 2024 23:58:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=tuulxpOjQUJ/MDbodMRktF6LFgldzTminw+CzgLFNt4=; b=
	SQYC+3XdhFCzjR3DhKO9DQI4Bm7+KKTPWGqRQc4Stp4I9QvLFjChUhiDe0C40Rh4
	FaDTNyf1mPXLZBX+Bi6RnzE9/eWapbWuHXBNZz8MD+4XxKgU3dEUNf6nxixaRV8e
	jKs+QzFnre/rdPKBJNyfgqeki+qYbDIWNY6+tTajidyrwihBkXIVYFShP1p8arqN
	LZ+YauprXADgKxCH8lPXmzZxkumP5IJEG7mpjKJbUR+Bql7cN/yKprjAWwu6x8dH
	FZzgOHG1oJyQMyDqjDlLoujwR5UPCxispF2c6Z3DGXwDbNcEZV2Cfxypel4/wnna
	IQrdk3eGNHxkPngLK7ydSQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m45ebsx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:58:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47KMJJkL040123;
	Tue, 20 Aug 2024 23:58:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4153u2tbef-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:58:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KoDTUSWq1mtsVU2Rt1pn2ZwqSYVNMxAm2CFE2ly15+p5c5GY4jShg0Ff1/4VThj/Ah6gyWphVN3WXpCXtFN8IBOdk8GK1Fq1dMOq+905wj8J9PwjUYIqzwurMj9LIrZUg//CWIZl9Ope26Ynis0B0SWDFi2461/ci8XcY+RfrXpqHn9elafY1BxMqjLo0pN7ycBPac3Y8FaZwD1SYGNUMOA754iStysEybyHdLOCHOP2A3OvdYBnaTIx3O0sbXBu80Rt6LEGo7KvvRWmUCc9fzKkLcFN1+BpaChdZF5PzSrCRG+7Z0+6crqs88y118pRf6/MuCoDlZJGWMi2m4MFvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuulxpOjQUJ/MDbodMRktF6LFgldzTminw+CzgLFNt4=;
 b=re1c3PgmzWGobx/kECMU8+5N6AJQwIhYfYmes/sjmbfjXx1I+/MRc42aXwHSYjypflcJFmDUAjED5C2fbyxVSHE9iWOKmHtjtIUZBUbUukpl06ocTCQtxKOT5e8mrkcu7egOTlY726WzTP8rGjPBftLekSUIhQqLwTCxVzxDnWs3rkZ9Kti6TDB0s0RduIowCbrWzOCFToCz9lRD4I5GESc6xhQ5rbZvSqOOMOVCRACTzHAoU1pO2ibxbp4XpXaFMddKyftSbl+KV9ShF3yUayclwb13KbxKv6/WOWHXA10MBQwVJt6aLIeI2CHcl1uLPlCKSwUIgLRV6s6AvfwI8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuulxpOjQUJ/MDbodMRktF6LFgldzTminw+CzgLFNt4=;
 b=PStfrdxnx9//J46IOJECopDeockL6boKG7RvP+Nrza6SqcRsEzXqNfNyuSckQurrAQO9CSWbGOcC+Z9NAFpg5Ay6D9RaFHzMk0K6aqrUqarcTvY4irz6RiqROWBl/JWjzPuLGKnga5NiXQsiuYkreKH/sothkvqaCuJC6f8iwrA=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB7099.namprd10.prod.outlook.com (2603:10b6:510:26d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Tue, 20 Aug
 2024 23:58:05 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.010; Tue, 20 Aug 2024
 23:58:05 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v6 10/20] mm/vma: Support vma == NULL in init_vma_munmap()
Date: Tue, 20 Aug 2024 19:57:19 -0400
Message-ID: <20240820235730.2852400-11-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
References: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0095.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::29) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: 545667f3-03f7-474e-dc4c-08dcc173eefc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iKuVYAVbdvPOGJe3DkMMAFK8b5x6JtguAJiqI8ykjJ5mshN1o8iXRBgUvFBO?=
 =?us-ascii?Q?ebODql4O1tqVQPjbf/xYHCVrk8FTkRNJ2Evt2qIup7QUsNyOoRzPN8U9OuAB?=
 =?us-ascii?Q?E/8xf3Qt+WCSUtd2U5Jwj8ssk8wTVzXQ9t+5fCto2rRMsMS2BKEk4MmFYcJG?=
 =?us-ascii?Q?H9l6Gc7HCmf+Rt74xgh0h8cI6M6hDRPtrO79T1xT3J4GqP05NKphLlvgqSAZ?=
 =?us-ascii?Q?1YTPn1wJgRLR2qKuSeKDEI7CoXQ6+Mvhb4h1YU4RGv9JxIqQWF1TZnfE9yIh?=
 =?us-ascii?Q?3+uENQ7a+dsP/8AKqtXOJJbzmdxuV3TpF3xCNoYNPdqhs/CjQCUQzGxY11EA?=
 =?us-ascii?Q?8w+QP4nm9XJC/H1nKA9+SuzQkek+0IrtCmXduUVZ8Bu2oMydfJojbrEQIlMP?=
 =?us-ascii?Q?nRw8LIeYRyRTpOgpgkUvAYVQDKmvRHQSrav/Lak87BdvEGXltliBrDkLUUE3?=
 =?us-ascii?Q?Zke/sCbOGPot3PMpVyxlTuPaHF8zz1E7+PpHrhVCHvtLhzBLm+EakKXcfkqj?=
 =?us-ascii?Q?Meka7FEZ5w/evyamXGxSezWxaVgZ8peiQOD+tEk1crew0bkdYvfT7urk81o2?=
 =?us-ascii?Q?pzE75mHplyGS0titf1NDkI0cP+S+WXceLZWHCfziv0T61FkMCbaOnEyzIEzJ?=
 =?us-ascii?Q?hjzMTF9ZI8TngELc5h9dy6d1pWXLuzEFvpalYYTZuxB8NanFnAgguz+AVD9o?=
 =?us-ascii?Q?NBUjEGXyrcWM5N7SnPgE/HFRNn2FfQqj1CLIdbDbt2hkDjY3SK2YgtXsVF2W?=
 =?us-ascii?Q?geVFAMfNhtwrprkIUImH/x0qFeXHztspe+Hj2Iy+lzhwEOb0x4JD9RzoWlgB?=
 =?us-ascii?Q?f69tcOIKFjMIW9us8fuSaPI/Gwc6afhgxXNKubTLWbjXo0CGuj0Oj3O0Be+N?=
 =?us-ascii?Q?3rZcWRM/JRUNBSM9XhTmmMEJshsSZ1XbNAU8IzlPilJPIYed3hO1DbwEoKEa?=
 =?us-ascii?Q?9q2FaOQdATZj1D18QHersiVlY5fl5ZeGscdTn6PwAdJTQ/zbVCc7e/Rm0rcN?=
 =?us-ascii?Q?ISqlkdQMl352MaeOg8R9C02Bq2XI1v9TYA5V9nQ1XdVefE7cA8eC29AhELGx?=
 =?us-ascii?Q?nR/4ohSp32PGbBJmyobOnt4E09EEHzUS+PtXK+zM7NPtX0UQmghIkX3ViArq?=
 =?us-ascii?Q?FGgrPx+25YtKM4nzdt3WRt6Irgx2Xk8LE0aeoY0egY/Eg/6mCXZt29tLTWJy?=
 =?us-ascii?Q?cB+qf2WCyeRCA5P90k7LvGu4+R2y94ItJ+Ga1Ue39i+eYWavsTLCre2lh2Jl?=
 =?us-ascii?Q?LxwPNXk7dI0r4egHtmTi9DP3Z5zJDrdAXBzoDnn0WMh6ZHZ4HDb4ofOdjWTz?=
 =?us-ascii?Q?65VdgtqLPu0sRdvTU44jT1wZg9NFNUD2xvTTlrhYUhA2Ig=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7+s9NrA9p5HFNNkmVZvbC7dR7k7uV27cOQDAT8kRwEne6TAg7imNzUBax9z/?=
 =?us-ascii?Q?c2TnN4VeUld6H/TkFb/DhLYd9k7Tfmo/PndzX1Romo1R7wkkz2+XNzeM9ATh?=
 =?us-ascii?Q?l1Xx+wAOVI4IuusnCpESC1/dVitxqqVJR3TdriGkhO00QXxQrGmFBWDjLuNm?=
 =?us-ascii?Q?2WgK5FU66vxGlW6YGRsqasGwIchzz9AZpQLMXY+KNlvF/hl0QuRzRQ676SrT?=
 =?us-ascii?Q?8DsOwKxnadMFVP35Cd2PoGCNJLJa74Wn3SzHILXpMbWGwb5dV030Ua4bzJbX?=
 =?us-ascii?Q?DjPuWzPH39qvsv5CzOFbp51ZMeyjaCFcgujMgAr9PFofDfGlgy+R/f0kWAbx?=
 =?us-ascii?Q?FJ0RUT28fRD4GueqG/mv01BeuVTDFb/sb4qnX7QBQMpufhpTV1vBRkEfKfrA?=
 =?us-ascii?Q?4tSqf4/v6+nHUOHD5I69SBETRL79XQElFkHMig/Urc0GF5nlzhYg916/v/LN?=
 =?us-ascii?Q?i6k9/FZSOgWqYOWwMbeNIIXkv2ip/j6pvZvAmqJQZCe/NFf+zaQ2+Ja5+c6H?=
 =?us-ascii?Q?KGkc/N+ZBJHoGTpCsW9qTN1iKRiyEHwLlp0GHleiWs7gYtRNtNvx9v0FXKWt?=
 =?us-ascii?Q?/IuZXSsG87vCEGGp9Is3zzTjdntKFrWWuscWy5mLkbMXvVFxc7iIs33F2/cc?=
 =?us-ascii?Q?MSc5gzRC/qa52m5B3Ro6Lt8ikS7aQhxDYGBIIlPcmDDOrd72k0DyeLIzIXQN?=
 =?us-ascii?Q?iM4EaVFDrO0RWIE+h+OrKmUyC0dHpaYoVeI50rhQalHcz3lLBjK8RD7J8S4e?=
 =?us-ascii?Q?NDNoXFTg6/D/KRq+Lz05sdBCOWqd7LN//71e+fMy9P3f/uzYVMUVXzZfwLL/?=
 =?us-ascii?Q?hB225lQ6hDTPRAM5YIYnD3iGI/TQuoODZ0eXW6/YHm1vPLL6gUtfOI4eE/Bq?=
 =?us-ascii?Q?YX0t/5Hg7iDqXYuTcKX1keE3Ox/EoZapMnfQEZ6LAfeQBx+8YBs6fah8z0QA?=
 =?us-ascii?Q?91D+WoBRNSh5r81FM5fUyYZ/3qltbgGcbvQG8/vGzwZG1i+10Iur4vdhElaj?=
 =?us-ascii?Q?8gE06kON5JX5Tql+217RblMMk5yPregBJO94hkkq00aHino0xcxwiphO+XYp?=
 =?us-ascii?Q?1bdWGqgZy/W0Pk+ksXqTs/OMYhapK0784+PPDiyA1oIM3xha12s5OO5jdlhm?=
 =?us-ascii?Q?8EyNVDsyKN3/Q2PiEYFbWu58o+RiBusSbHmVgsuHPk5N5WfK3+JxP/EWgxgG?=
 =?us-ascii?Q?VADAbUK8R59DVen4uqVCtN7tec33QBMtZQW1LGWKav++7Lxjnq4mUsLVvrkd?=
 =?us-ascii?Q?98wLkp/JY2hkWG9AcTmvDk3yWi3jg1UxjpV8TpaTetKEnEXfyAUFUb5ZVM3q?=
 =?us-ascii?Q?5IOZB72nz5uNAkeW984lNj7rcz1wD3eRyZiO2IRNlhEJ1g88HpKTeHUO2e6K?=
 =?us-ascii?Q?bDORE/JB5IHMwu/UJip44tFcWInZ1AdqCJYxXBYxQS+6VSijAVZA/GXVYo++?=
 =?us-ascii?Q?1qyVWCFwiS2hP569Ys0fKHQESSIIxaQ0Y6F+PnMHsg9OqRC9jqegMeocac+P?=
 =?us-ascii?Q?6G7vongIhIc1BwkbBl/GdPgGfHxD58/pka7JcsmFpZFxgIumVWsyRRYVpM9i?=
 =?us-ascii?Q?CPfslG0HG431MRoZ5lv0BZNrpTRLk0SrgnIDH9c2KCG+0BGidrFrdYOe3Ttt?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	L1zu29lpRwl4qZtx/IygCNUsTxJkI4PxxqpW+qmFtfcuGb7usRRELQVxN0WVaDx7eBCLPv/DbSNQTU6KO6Q88YnKqlQKWgnUHOrgbGHBqRcncoiUvZ+cU2J6o92oiOVuVZl2coODZbln4WB2SiVR9BDfWGBPtdmvgrWhA0yymScDIB6S4YhN3KfNTwKLvZxWjUnhDMP6GpbMpYpV19bZzfAmLhDLuI2sTtYebZobI/7fZBxMLIhO88PA73kk8XJx1oDJCkKfv6UC/5kwiXumtGEM/itcrl760K+5WNVKxovWA3rvW+QkBlWHHx3c5a/k6A71xpYfs3pEORqQlgJN54TCfu7y3MtGqfYS8xDlY/qnCJS1hJgegP0f6W7Ik4ln2TgdpdG/v8LgOFUPAQ8TaUsnAvkJ5SYKrTMVHRa0YNrQdLYV7pEQ8GoCXaC4I4aNPEgjgxTLZVax4e013OreXEUB81ZBBxNcnbbjqF49Q38ZqtXJ4ucYcQt70jLmaQf/mVInfpMmpHIz7WrOqF60STcXmqxpMhErE6qUp/3EfA5Ah3FtRidAEJUj5xjcAgG3EFqDlNVzOLDpSWZ9KfpvMtsYjOq2e45roFtN5+pSsdg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 545667f3-03f7-474e-dc4c-08dcc173eefc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 23:58:05.7708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FNeyK9Yh+3H/YsxclcvpDVdGtdaVvKvb3RmpswcOEmRe5WP+OdaZxOpwGfPZdWSCUYJT7cmHSVpt+R5YJod1ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_18,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408200176
X-Proofpoint-ORIG-GUID: aKsVfAVlTN-wXA17ZlCCbXFiZi6aSPOO
X-Proofpoint-GUID: aKsVfAVlTN-wXA17ZlCCbXFiZi6aSPOO

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Adding support for a NULL vma means the init_vma_munmap() can be
initialized for a less error-prone process when calling
vms_complete_munmap_vmas() later on.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c |  2 +-
 mm/vma.h  | 11 ++++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index e7e6bf09b558..2b7445a002dc 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1393,11 +1393,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	/* Find the first overlapping VMA */
 	vma = vma_find(&vmi, end);
+	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
 	if (vma) {
 		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
 		mt_on_stack(mt_detach);
 		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
-		init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
 		/* Prepare to unmap any existing mapping in the area */
 		if (vms_gather_munmap_vmas(&vms, &mas_detach))
 			return -ENOMEM;
diff --git a/mm/vma.h b/mm/vma.h
index e78b24d1cf83..0e214bbf443e 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -95,9 +95,14 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 {
 	vms->vmi = vmi;
 	vms->vma = vma;
-	vms->mm = vma->vm_mm;
-	vms->start = start;
-	vms->end = end;
+	if (vma) {
+		vms->mm = vma->vm_mm;
+		vms->start = start;
+		vms->end = end;
+	} else {
+		vms->mm = NULL;
+		vms->start = vms->end = 0;
+	}
 	vms->unlock = unlock;
 	vms->uf = uf;
 	vms->vma_count = 0;
-- 
2.43.0


