Return-Path: <linux-kernel+bounces-376933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2FD9AB7CB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BC2128386B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880691CC897;
	Tue, 22 Oct 2024 20:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fm0cjR99";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aGJLOcpg"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64941CC148
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 20:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729629680; cv=fail; b=anV9/+33JPPZlcqgmoxzl3K+/DVlQPQx2y6O5mwQp1ttFt2RQ2HEGsXzf5AAlKWoTV9HCeR2Tb4DZDF78m3O+rCurBSyBeDtdvlPSFxVjQuTjJ+GglTlGGa5JDVpiz36IbNmsLOIDGKrLvECor7RnNmbWKu9yIjM+HcRcKm6VEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729629680; c=relaxed/simple;
	bh=bU945MpOgwlJ5cbznLicK1kzPPsy5f/H4svguhNDxOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cmRs41OX3qKx5utIQovRjWekwHx71e3CTBz9c4iHeQUjvqC+mq43b3+0+ZjyFKAyiXFet4+Dibd5rvbBOcY3KVa3YJ+FNCyIR6XoB2Si4U8B+W9d05IfDyeSiexcgp7uscVJ4tY4GfhC9N5jxwvpGKSWZxzAkiDriNi2dUIirVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Fm0cjR99; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aGJLOcpg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MK3Wt4025707;
	Tue, 22 Oct 2024 20:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=iYFdRZtxK3YWDV2kNLEF9wGq/1fKTAuij1RdPiYsVFg=; b=
	Fm0cjR99ocgVdxgL7Ky62AiHNGhtHszKgm6g/+O4/Y6AoVAJo/yMbTPjhB1BM9XJ
	mU9yvg+jh1LWd7iNd93Ti22rFi6hPrpLBbqi7/2+lpp3IBrPffCi3omRQsmCTNnQ
	Cl8ucla6GyvPaPgxlWGnMfkM/SYAad7P4qLUyL6k1xrn7JqlyWd0dTrV7wRdtK4n
	HoiQzawBeFOVVKwbPqNNMqp7vMWr/QC7o8ScfNVzCZYF/C3Ap0BgjfV8O3l29S0F
	+LJXOIQuJJi98T0ZP6EluassC3LvAKsmBpUsrPPsB5zKevW5eBrzvU9geVm8DoK2
	9tR1pUd3ayatb8iQBRt8jw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c57qendh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 20:41:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49MJnVOJ012557;
	Tue, 22 Oct 2024 20:41:08 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c3780p3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 20:41:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLFkM2c6jabIaGB9NvkgFBRD0d3iFEhkieHc8LttAf5OjAFbet7p9sMFufP6F+l/S7irILPkXLdk5rsOTCC77d6J7Dorj7eulPSEVpVz9ZpydWYFkp5gnP8j5BLIfjRtzIfjtOlJjrkXEfWJiY9ZkONiDf5pvub8ohLglfbA4lsoOohL819naTWizoz2i2ZRY4nVOF6zac6+pyJjHxqRJM39S6qGtFnjDXe82XTZcxP0Ihb8KDvOjb46F6UPKc5iPYoBWnOBYz8FsjKOKZ4pJy1q/LmoFakwDbKPhgqAwmqhlDa0xcalWOG8mt1ZNHVSQAKvi4OWpIs250nPxc4U1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYFdRZtxK3YWDV2kNLEF9wGq/1fKTAuij1RdPiYsVFg=;
 b=Qnqa7rXaSeTFfEBGMjTSYj3HiJ1bpoUS0gFqGgHEkFv7tDvGi2R5S/5KO6xZNkTEr1FY2MFpitSqTZwkBIDAqJKNOb/PnTQtG/6/HBlwbrlkGqzt0hMKbOaWLHl3VNXUa9KiMwmNoPnYgOpHugKoYynV+f60CKvaNPkNtYXSUuDabcdn78TdImkoxMjaa8/QQBuPLcPYTH+bCVCuGl8hRztHKv2staS9Z9DK8RBXUlB4M5SM4Yf9/cl9EMJ8UrfcBvUzcqGLH0BGMRCEH7SOjI9fe8TLdzj5/+6+KoXBDsqkKn2Krtz5abW2XuKNm2Bo68bXGBNN81bEuXWhQGctyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYFdRZtxK3YWDV2kNLEF9wGq/1fKTAuij1RdPiYsVFg=;
 b=aGJLOcpgTq4B2jVrDIdDtyIBsT9nEtQ7sz/lOEQNFtFM7OTxXIVKsFfumqj8sLRCpQkmqIs1os8qMeASdaQE7jzg0eecc8OvKZePA4y/ov2a80V8Nppd28aD4clVVTMHJ5MXN8j92TNcuhiSVt/jx0jSwk414QRSChB8IkRkVMs=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH7PR10MB5879.namprd10.prod.outlook.com (2603:10b6:510:130::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 20:41:06 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Tue, 22 Oct 2024
 20:41:06 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH hotfix 6.12 1/8] mm: avoid unsafe VMA hook invocation when error arises on mmap hook
Date: Tue, 22 Oct 2024 21:40:52 +0100
Message-ID: <ddc1e43edbb1e8717c2be7fde96b682d8a898836.1729628198.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0381.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::8) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH7PR10MB5879:EE_
X-MS-Office365-Filtering-Correlation-Id: bfb2990c-65ac-4234-bbf2-08dcf2d9da37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yqSyCZZK7ce9SaRWsdXgMFtZiY+ntTCawqaZ8k1AhI/LPkwAhoTsENN5ax4G?=
 =?us-ascii?Q?wbTGHbd0+gIRg2DViL9ORfkOZKIKqMbwXplQbWy4Epqb/T8XTRPK7swLH7RR?=
 =?us-ascii?Q?3Pez6DcmIkMBFgjWUT1clzGcRYhdOt9CxAyfDJq+OR6bQYQWPgGJMZ1WyCVN?=
 =?us-ascii?Q?3Pc+jipiQFPO5Alt+ViorTf58Pdym4F5BXmnM8VecjDAXaly2zHN3e71Bq5c?=
 =?us-ascii?Q?C7/PQFF1JHJSa19oBYGodbKurt3ED2XKrzvXjZU5jxPOPjoeGZeCpOsKLEHk?=
 =?us-ascii?Q?XSYl0cJ287E/7LL7nPWc3T8uXiKJMcFFa08kXTj5Yxq2/hO7/67jWQs+zpXS?=
 =?us-ascii?Q?TFvqnK3hxoxoL1MpjuWRZGeTyxk2kr+MSYQOHNe3kZSUA+gVbbUfZnxzs0Gx?=
 =?us-ascii?Q?bhHgMYz6ZpmgYlrJs1JP9cnIxbbZr6LGn8Wu9FVu06Xn1CE5tiAA3wAa5BEd?=
 =?us-ascii?Q?/pZoYpWyq9sphsrH1K4MGHNrkquEGvTxqmTeA8EzUHZ95eRvV+VbdFurNweH?=
 =?us-ascii?Q?z+Ng0yR3D5anCYgTgTuMZzN7w+iZ9CugXthUnWUp/8ER4b2b9xc8Sr/4r+QP?=
 =?us-ascii?Q?ga4EarhDSg4vCwKVQiftjO7csKAr79ZJkf434BZ2BAE1AlInxnx4rfQ4l19s?=
 =?us-ascii?Q?Yu7EMD1YQHMgHgO+jJpUwhVarqz8CYJju+it6lNQgrTadZyNozrqulEXEytU?=
 =?us-ascii?Q?LW7XoWlRwx+S8jRy+XWtn/AyOOaQ4KN/5ZlCMbCxhnTOS+xxdYhy6Ypzt+Va?=
 =?us-ascii?Q?p3w2LZSK/vtgb87HH28jRkIeLCCQtFCnclC6wPK27EYYWsVIPKsW6Lnxj0yk?=
 =?us-ascii?Q?1nFw4myfGHReEIOJ2Ka+shtcrNQCivSTbTUQNbJBHpcSkOyHaE1STQglWhr9?=
 =?us-ascii?Q?jHv4vUO8CVn7NBwE8oKcW2AHLsISxvFwhvv1pndBxVe6n77xOS5Y2gc2HtLl?=
 =?us-ascii?Q?dqnMDTvMeru/aXnXd19IQyuLCKkS9A6COBSMALITnczYLjFAQwLXmTpu+NTs?=
 =?us-ascii?Q?17TOwInc0veo8uOPXlIn8bNoymAWJm5yLYgUcgx9Hu83bm0LK+H559v2SI9n?=
 =?us-ascii?Q?KKycHlhegqMKVt2n38pwGBaUlMJ/+IvSz/ZURk+qy3wGZ5o4mzGi5BDtFL/W?=
 =?us-ascii?Q?xWfdW4kyFKeglEa2Xg6TbBJuVcxQN1xjTEf5EUTX0Es2EgHdtil8sH4+ImeI?=
 =?us-ascii?Q?gNe9CJSFJhJNCH58npUylO9eOQB2Jn9hRUlJ6EBnkTt6yXjLGDX0xw4wvBwa?=
 =?us-ascii?Q?nBylrS5ZgoYruXYyOouP03aUJ9K4By4AlkhqlyoghZffbVQacZ+mEWs/QcHT?=
 =?us-ascii?Q?VokLrv/vJw+FOesiH3coiNcm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4EFOZLY82UQQUT5TcDfVvJErsCLAo+YkaRDaVebfMgcwE72YVFyCjzTeec/p?=
 =?us-ascii?Q?Z7odI4qCGNaQQ+33wtohHdi+ILMY/aZxYrdVdk+X3XOgXp8TMJbxIFWrRoCu?=
 =?us-ascii?Q?vOReAvieE5WXI7ZE0IXwmPGdpaSpAJuz9mSvc5OLb1KOfqIyANAr25LJKnf4?=
 =?us-ascii?Q?gUQhWhbY0X0semELLmYq6aIjfv9ryxJcF9ZbGH75lzukGitEe/0yc1UgT7Yw?=
 =?us-ascii?Q?QXG3fCesO7N5+j88iJPJzcglA/usVRO6oi8PI2/Sl6Uhp6M8vUWlvqXzWs8B?=
 =?us-ascii?Q?KwFM6Qq7zA8WWnLuWxP40VlVNh9bxYLJmK7AruqKJb1bOnrHMtY202GIPh4A?=
 =?us-ascii?Q?TgKqX48yIaRzb/Yo5e/bqBs5xmhlZGpIK2ksXbD1cxrqC0HR/2J2ERtbO659?=
 =?us-ascii?Q?ECU36QUbD1aATXEuba/aihzpcqzg5kyZ5mRfW73lTdVJrXNXLaMDVuD7GWW7?=
 =?us-ascii?Q?yHc+qMIqBmBPjChOOEBcjoQTr0BMmK9H1d5JaxWZ+b6GLRJbSNX4O/zZyrmf?=
 =?us-ascii?Q?5w1bY7+3erxhtpNc+efgo7YBCVkoYQgi8ZLQ27W8hp3J+Omj83CHi5KRrLHw?=
 =?us-ascii?Q?5Qzb3oi8pK2Yblx7ol05uMG7UX5r6WMMbzHu5nloT7LwScHJzfDJkRASPB9x?=
 =?us-ascii?Q?Pz4jiBkcmQ0QTGSonx3hmLd2iLEQzYzYPGMYMfvb9dgJo0F2Q+GkyCQBSkmJ?=
 =?us-ascii?Q?BJROGhLpOnY7Mv58PvJQn1Aws9Kf7WiWdfufWdXDbM/farl0Rywk2tb90p/s?=
 =?us-ascii?Q?87N3BcfFIJdcvYIC6Qx67kUhqrjBgowdlW7txDevX0XLVwEaPLn9PRnzOeqJ?=
 =?us-ascii?Q?oTwVda2lIeTo59A9awqgfJLKaeell+dtngNT9taFFOlZapcs8l7wnFuIe3dA?=
 =?us-ascii?Q?tdaGgoYzHA49CYk8aD7mdS1GI5CjakICoNIauhcPi5IykRreWA/5kn+qlMD6?=
 =?us-ascii?Q?8kbmIBjZkiSTNzRudHvinfPMs4jgbSl5Owd/YkX0I72eN9KJwV6d/HNyeWW9?=
 =?us-ascii?Q?hkEhQePyUmni70YscxB1ugVBZXcflEOUodOT1Tw8PlunRWtUhfrDs5dSptL8?=
 =?us-ascii?Q?9TKffWxQcSYjoSDqF6N/2GSKsXDx1hHOGNI9y89GGDtHMTkG65jHr+avv2Ra?=
 =?us-ascii?Q?xgaCyLkBrizHd2SzkEwF7+oYt2AW9bhgKOgodha21CH496Iwx2ydf5fCRc+R?=
 =?us-ascii?Q?Y5+VZMNkr8XHgWHZRRDP/dPD84ogI0ubR1EszyCSUsMi201W24WYvCbhFZlc?=
 =?us-ascii?Q?MDda0xqON4vYMxYIEKVFsi6vvcbj3T1B+4s0/ALQh7ZkMUwxQdfpwErvXoQi?=
 =?us-ascii?Q?ny0+BtBzfUU6RUiWjMHaKMBFqfD5ickIagrJTqPU1oHdnnx6bTWO1MZCC6pK?=
 =?us-ascii?Q?XFyutH2g4z6Ej99I38GAXhEcJyes5F5DnjBORAkWYg+8ND3sBq856n96yFLP?=
 =?us-ascii?Q?Z+nqmWO13V0+rwbuiCJXCnAX9Qz4OjlcxFh+/X2ecjTimDFhpySX5HKT43b9?=
 =?us-ascii?Q?TsUDvCSVjxoj4MnRgg6AHU880jgV3l/O7uJpUMvijvtnXbe7IzGgfG5hJmgO?=
 =?us-ascii?Q?vt20pkBRQhFFVBtFUoLcK1+VumzNUoreGQXBDZhi+tARY8Uovf+x7O0hs/HK?=
 =?us-ascii?Q?ey3kaVixzirLNo0lbZuqm40JQ30vaTsKo392FccZiUiq5pUXDcWrFgFEJTMf?=
 =?us-ascii?Q?WDa4ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OAN6fGUaUQWwmSC29JWzZxVjVStP+d3v2gctyn954aPTjI0zjBMFawxMzuoJRamCGeDaaV8gHNG+efligHCrNztbJh2LJ7vdhmkMs8ES0vRxBwn5j5sSsbJNjBiiKMr+AnPIdgTkmweQzrJE2n/VU3KTV4oaSt9J3fI1LKiWc7/vhuAMSxHNbuo86jMomOsnypv/hAq9yh3dqPg9R/COem0GMKW6Xgk4jBV2x8QZCYpPoDHPufriY34zilVI2RNgVZu55xNFBB2mSKF57oZizhz9qnYpGjdE9k4MnkcjrZh2BRpacFGJmjfagzvCXNiJXMt3rYMIEi0Ur3C6mSRpITnI1NEBi1BdphqwPtHrwGGbeJwpCvu66CKA9kOEXkArDJ7blvnBrTm2VOoUTfvrHLnIB/hyicnIpgSxdJBRkGzX3Upuqs9zpWNdKPWMcS+Zy16oePFkInJuncFu/i3biUo1vpb5YzFgd0RWQ2neIPivUo8mhY2uhblJqJLy7EuLVdbvLD1aztTHa+NTT14m3F5vKonZIhf3OIFekfhi/fhBrVuZ40ojCjG2xkVuDlURRAarrcqYQed5+UC5wJlZCogoxl0D1o7GR6QkVRONRa8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb2990c-65ac-4234-bbf2-08dcf2d9da37
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 20:41:06.4929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UWrQkSa+ChaTgSVy0YwWTbU38CS8vXW6qQLoVfiv5chXrtSs1HDHG6oPpu1kBcXKo9bhNS2m0z9t2zKGOB448i4IVrlae3ta6IhmDpKOzW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5879
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-22_21,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410220134
X-Proofpoint-ORIG-GUID: 3TfZiNXp4y8ylZEWf_jytYJC_KGEgrWo
X-Proofpoint-GUID: 3TfZiNXp4y8ylZEWf_jytYJC_KGEgrWo

After an attempted mmap() fails, we are no longer in a situation where we
can safely interact with VMA hooks. This is currently not enforced, meaning
that we need complicated handling to ensure we do not incorrectly call
these hooks.

We can avoid the whole issue by treating the VMA as suspect the moment that
the file->f_ops->mmap() function reports an error by replacing whatever VMA
operations were installed with a dummy empty set of VMA operations.

We do so through a new helper function internal to mm - mmap_file() - which
is both more logically named than the existing call_mmap() function and
correctly isolates handling of the vm_op reassignment to mm.

All the existing invocations of call_mmap() outside of mm are ultimately
nested within the call_mmap() from mm, which we now replace.

It is therefore safe to leave call_mmap() in place as a convenience
function (and to avoid churn). The invokers are:

     ovl_file_operations -> mmap -> ovl_mmap() -> backing_file_mmap()
    coda_file_operations -> mmap -> coda_file_mmap()
     shm_file_operations -> shm_mmap()
shm_file_operations_huge -> shm_mmap()
            dma_buf_fops -> dma_buf_mmap_internal -> i915_dmabuf_ops
	                    -> i915_gem_dmabuf_mmap()

None of these callers interact with vm_ops or mappings in a problematic way
on error, quickly exiting out.

Reported-by: Jann Horn <jannh@google.com>
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Cc: stable <stable@kernel.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/internal.h | 27 +++++++++++++++++++++++++++
 mm/mmap.c     |  6 +++---
 mm/nommu.c    |  4 ++--
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 508f7802dd2b..af032e76dfd4 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -108,6 +108,33 @@ static inline void *folio_raw_mapping(const struct folio *folio)
 	return (void *)(mapping & ~PAGE_MAPPING_FLAGS);
 }

+/*
+ * This is a file-backed mapping, and is about to be memory mapped - invoke its
+ * mmap hook and safely handle error conditions. On error, VMA hooks will be
+ * mutated.
+ *
+ * @file: File which backs the mapping.
+ * @vma:  VMA which we are mapping.
+ *
+ * Returns: 0 if success, error otherwise.
+ */
+static inline int mmap_file(struct file *file, struct vm_area_struct *vma)
+{
+	int err = call_mmap(file, vma);
+
+	if (likely(!err))
+		return 0;
+
+	/*
+	 * OK, we tried to call the file hook for mmap(), but an error
+	 * arose. The mapping is in an inconsistent state and we most not invoke
+	 * any further hooks on it.
+	 */
+	vma->vm_ops = &vma_dummy_vm_ops;
+
+	return err;
+}
+
 #ifdef CONFIG_MMU

 /* Flags for folio_pte_batch(). */
diff --git a/mm/mmap.c b/mm/mmap.c
index 1ba0878bbc30..10f4ccaf491b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1425,7 +1425,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	/*
 	 * clear PTEs while the vma is still in the tree so that rmap
 	 * cannot race with the freeing later in the truncate scenario.
-	 * This is also needed for call_mmap(), which is why vm_ops
+	 * This is also needed for mmap_file(), which is why vm_ops
 	 * close function is called.
 	 */
 	vms_clean_up_area(&vms, &mas_detach);
@@ -1450,7 +1450,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,

 	if (file) {
 		vma->vm_file = get_file(file);
-		error = call_mmap(file, vma);
+		error = mmap_file(file, vma);
 		if (error)
 			goto unmap_and_free_vma;

@@ -1473,7 +1473,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,

 		vma_iter_config(&vmi, addr, end);
 		/*
-		 * If vm_flags changed after call_mmap(), we should try merge
+		 * If vm_flags changed after mmap_file(), we should try merge
 		 * vma again as we may succeed this time.
 		 */
 		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
diff --git a/mm/nommu.c b/mm/nommu.c
index 385b0c15add8..f9ccc02458ec 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -885,7 +885,7 @@ static int do_mmap_shared_file(struct vm_area_struct *vma)
 {
 	int ret;

-	ret = call_mmap(vma->vm_file, vma);
+	ret = mmap_file(vma->vm_file, vma);
 	if (ret == 0) {
 		vma->vm_region->vm_top = vma->vm_region->vm_end;
 		return 0;
@@ -918,7 +918,7 @@ static int do_mmap_private(struct vm_area_struct *vma,
 	 * happy.
 	 */
 	if (capabilities & NOMMU_MAP_DIRECT) {
-		ret = call_mmap(vma->vm_file, vma);
+		ret = mmap_file(vma->vm_file, vma);
 		/* shouldn't return success if we're not sharing */
 		if (WARN_ON_ONCE(!is_nommu_shared_mapping(vma->vm_flags)))
 			ret = -ENOSYS;
--
2.47.0

