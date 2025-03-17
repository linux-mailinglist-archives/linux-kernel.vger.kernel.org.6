Return-Path: <linux-kernel+bounces-565069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B24A6604B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9B7E16F8DA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 21:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58B4202C2B;
	Mon, 17 Mar 2025 21:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IBD1y0SC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AfT90CYp"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19CC1FFC44
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 21:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742246162; cv=fail; b=cvYTMYH5RD7qxhJ8mA8LhDlnlrfGiFJ56npnYcPXEv4+M7N3RYeUgiQTZV5jX8hLDb9l5enfsXnaiGY+EjokzZuau3BJ0/xhGqdFL2yyxxPRMDrEzZBTZ3a7zNNDbx5YpZ1HpSC2jMgDqVqvq0/3O/qzLKpNBgGSqAvOMGAg7H4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742246162; c=relaxed/simple;
	bh=Z1fZdBZQYM2iwfDGyvwRBpkx3pFXObha49a/APLPoyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q9VUw9Z6Y1pAc2/ubJ5Cro3zdKp9WEcV6D0fQAUJgZmJSyADD7lXC5HKeJL6mhmord5F7IcBDrOxfrxTZd+60Ac6JVIZ1FZjIS/V4mFs/wLTGJKNn4e/B2bDzJKbXI41qCNOFt5hkxCfypp2YSjS5VekfK3fJLzu9VJDl0j5MrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IBD1y0SC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AfT90CYp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HKxULb020921;
	Mon, 17 Mar 2025 21:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=5ALnRtJHBCOGTybACSflieRd9BTsCCokIy1Rg6CQogE=; b=
	IBD1y0SCLo2BrBWLBMgrK7RlX4/ZFPBwclGgqbNQQnb8EUEj1cPSFiQGicsbOfks
	aNZGM8qF23vi6F5J5rg/0e/KWb1tTmr3EuxaJKC+BPn7lXxB1yiBfAEvJwp1ffKc
	7t6OkEKKqVkH6AjCQ0dwG1uNecwDWecfV9INoSCzm3N1MTGPCiwO6JDrZ3c4Wvhv
	2KvOSHiHbLy1z6fE8gLjXppeRLCtXGUckl40i2mukrly+syAZnOGFBA8BjR3Ex7K
	qEkArfeZmDBDCuOqc6nSr2KOg1nS4gQIb5IsFsobl5vq9q1HJazYPOYndh9oNNoH
	/nRUBjGIQ2DNqaBpyRteNQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1k9uxpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 21:15:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52HJWHcf023892;
	Mon, 17 Mar 2025 21:15:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxeefmgt-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 21:15:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1aTLXFP0YoehRmJ8Cj3yZK01UNjEbFPS1c6plspUV+Y75zRuNLhc/pQEggO2WLRdOBhApcIDzy0SE9ly9cDEWJhQyLg8yWwxHY/SwsY9hAo8TY/hWK5NsbWiunkJG4gRxidvr4KdJPz7ltYzhrLD2cF/zCnV2oZVerrheQpRduHk+PTaRQxqoiHUIr7JnmubfIiLD+myF/Tu172WO/hdPVoU1moJTQm6X63Sp3votMIfbmkOFOTM4QC7I0tD+TfPCG+wHbFoVVaxbyKnIiUn4Lzuw5cukKQDVxyWerBQOQUBJLxjwLfS5IEO0KKqRryXuyrc9IMgXaGRrKy8XI5JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ALnRtJHBCOGTybACSflieRd9BTsCCokIy1Rg6CQogE=;
 b=gusF3pUCkEJpCYXhJ8wPl7zXmMTYY+6F93vvvaYma9lEHLSYBIMJDcLovm8XnAd77OvuDfWqxQnwOyEHGiJ7Z2fTc+9SkEZotYuOGVo1nd4xNdy9XMluzDa9msWuuWcXH3u8uu2CmJItnurdYL1VunG815WmukY/p5A49Q9UmuZvtEUqB9CejIMn9FcNmiQw8sBrCfuvqyeLkbnXYgu+Ekccn7+QQWddze+fq1Npcot/tyjZStd2jxWvtCe57HyDhSVoHYj6q00W6sqMPlMh6d+aeO/mjS9GqUZzR908EynZc6CdGDJWCgOVjc8Pk5AFU3QRPYItNbBy1mSqPpip7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ALnRtJHBCOGTybACSflieRd9BTsCCokIy1Rg6CQogE=;
 b=AfT90CYpXiXTwCId4xN8Fhz+g5KiDeawqS/rcJF8sdpHj70SXv3+NmIEiLlJZj/QjcuZF0YezqeqmO9zaBrcTWTzUHBICHsbhOj1SemznAI9zEAbn3qvP6Cqbhn3tqKJHUK/6/fT/JRCfutgBjU8vMcviPc4ZlUTc6Yg3q/XAXc=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by PH7PR10MB7105.namprd10.prod.outlook.com (2603:10b6:510:27f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 21:15:24 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 21:15:24 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] tools/testing: add PROCMAP_QUERY helper functions in mm self tests
Date: Mon, 17 Mar 2025 21:15:04 +0000
Message-ID: <fafaa05d2f0fc7ff3c2b852427dc9b64e1709891.1742245056.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742245056.git.lorenzo.stoakes@oracle.com>
References: <cover.1742245056.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::22) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|PH7PR10MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b40cc0b-cae4-47fd-07f6-08dd6598d522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IGAF+qG+o+XJri5a73zY6p4qF3nXu/0tIa1hQ7XdXXIwikDXn5ZuVenzAulp?=
 =?us-ascii?Q?RiWPD2uiRMNS6gAV7sKA6QJ3hU7qW5DCSZkxQEiiRqNkIN8S+4za+aRqvsKk?=
 =?us-ascii?Q?W6Jgwh3lLqbRd5TdAiZ64qfXkEScFyAhMttAl9GE7hi+mF9TpDGvfs6tPbJC?=
 =?us-ascii?Q?AifKz9n+NxKnJeSH9wIom5KrV7g/RBGNijqk7icEX2UeoRyu/zV2wJS59UNp?=
 =?us-ascii?Q?aRV34Oa1+xCKLGs44/99/8WABxeWdH+w5Bo8oxLIEsz81j+azdQXSrcIjVTz?=
 =?us-ascii?Q?FBQSFPCHyBsT92PXEVrUqzAA2KcXvqbnUssYIPHRgRzEfSUYjMe3mvh2/B7q?=
 =?us-ascii?Q?GlQcnq3P4tSCA66jYqB1fil681IHtEb9M1JR+9E/ukNIr2j71Wq965sznXRE?=
 =?us-ascii?Q?5lEnI9yYeEL+l4+M/u29k8JtUttWQFlq6Jbhu1YaVSTPsTw8S9T18kCaXfjG?=
 =?us-ascii?Q?pckaTKwVmkZ4w3tAr5HkXHWT8MuYg4wsezGL4h5ptCHCLElJ5COmITJF8IxK?=
 =?us-ascii?Q?XGalYjjMGMB6c97p26VnTRDE6qkAg+ZVkv90nQ+0j6yzj7FohPZXP/KCaTxl?=
 =?us-ascii?Q?pXwTvu1aoI1tGsaPKWWa9SICjYtCaFXgThw7IvwiKLhUXGctXaSqnmVi2gaQ?=
 =?us-ascii?Q?Ur0GEkBQ4H+BEkRBi1ebmaFr3cs4j1RQLb2qfbwvoDj5ZRde0WXUp4rrvMw7?=
 =?us-ascii?Q?1BIdxq8OqKYHUdllqJDHFQFtKA2ioOm3K6NBqYJngXjKQFR3e7DfEOwqMxLT?=
 =?us-ascii?Q?C1vlP/3OUMwliTUcDOBHkEEaRBSH5Ki2Q7cbVM4TRnAsycls/OgurzcQJl+E?=
 =?us-ascii?Q?m6dHTG85zVCpSMzKBEYKMkbK072wIhD/NYwHvmOpZLbjNJFTUdTqm5s/UesZ?=
 =?us-ascii?Q?JDHL3f88FZPvTfqTBTYWEiYrP1haim1IkTi8tq8XI202avT0PmXTkfbX3otX?=
 =?us-ascii?Q?Ckthpik23dRqvGCdPM4Ax4vBsaSQzhdWUQHVOhhUmoRohQDkg4ZrVCF0V7/v?=
 =?us-ascii?Q?KUi/B7ZKkkgwu9Z26eoGFTvwQW6isUsp627OuwaSUQTxWy8DplGral4/Tp+E?=
 =?us-ascii?Q?JWEhHPGabzFUoDpF667+VYff8akRlp+7UGhu6HUyamQ+56eW5Iz4NoREsyX3?=
 =?us-ascii?Q?1T/ldHrRRnpwDQc4/Pt9QRJHU89UsdMwo6RUoXJ4ErZadsnvkXMl97IxkeWM?=
 =?us-ascii?Q?31DdPwW8nCZMsW7V8xykD4UR2q3gq5lrPFT++sxTwRcNpMtggC2MZF1eXad5?=
 =?us-ascii?Q?GrvNxQdx1KaqCbaesxA84cgIe+j8wla1CD1vJsfb0yC2cshf+IbzyLuDqKzt?=
 =?us-ascii?Q?NDJOyNoNbrA1bhO1WYVqnlSCQK8ni4rpC0TFLc988goeYgVolpH6nm+7CgcW?=
 =?us-ascii?Q?NgYuU4iBzn4uQVFpXIH45mnxvnd4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NKDHBC2+aiGOWkxG70jV0N7zaXm1YmZDb8Llbar4e+HnpXY6xmpSUcvvhPJP?=
 =?us-ascii?Q?CQ68Fcud25eYyb8udZrv+TJua5sKvsXApJzgQW1SvJmJG13gYEFOgHe0/7Jx?=
 =?us-ascii?Q?wRIy4D4zz5p9hdyYYVQiazXohAgj1Js2MDq/8qlHA59PniLCGbAMcXfLt4mT?=
 =?us-ascii?Q?qR4QDXeNA6sJoUowLmVWywhO5uOCGy6wbAyJk40sdAGxN4pwzzObQ5ZKtkLE?=
 =?us-ascii?Q?NLLdsxZvD/MXSovCg11STTRLEkm3eOjd5WpUTRpl35LUlebufIC13abN3lom?=
 =?us-ascii?Q?pv92DvxsLpdUNjB2QSTz74rQrAuSONabDYHhNhLiyPrDyUTndm8I7owpec4D?=
 =?us-ascii?Q?ms0MSbuyxB0781x3mLfs+E0Q9J+H1UBdx9bGyguq1uf9J/YuCdxhPwj4uJkL?=
 =?us-ascii?Q?UU3/kpneBc7oo+8azuFK7DQ9FYc7Pt2Udub280QtGthoI0PyFbZWCQ0e/yxD?=
 =?us-ascii?Q?5Az/BokA42uwxDQlDaDhN5lK7DuMpNm40BhoCbPCL4Npw5pAwO9vIVVU++U8?=
 =?us-ascii?Q?8DABGhmfXjGfSSFEf6e6BKP+E4KzeJe4wLYM7Ex7Ux60pXUY09YWQBYjrklz?=
 =?us-ascii?Q?nO5EPUHSqglaOigWkEm7VwKBETRc7kLbwwX2fSSOzoKMa3ibD79w5qBVmwbM?=
 =?us-ascii?Q?sprtS+iHOWtjc5rN1LhZNDLsnOl/Bq3i7cU/dn7UfAqnLJBeiqHcuvNacqhr?=
 =?us-ascii?Q?O4kXf1WRCDBpkSdI74KiY70EngkcsacRBnkgTtd3byB0yUp4h1qDwTrtVslA?=
 =?us-ascii?Q?RZqc+pm76fSZgqFyEZQG6wwxb+GsrR4r9fei62Nh3ait0D15bSJczmTYNjxg?=
 =?us-ascii?Q?N5Vpe6R3YAFTtsR2LQwFZLLBqH0GPZKV+0q8t9pG/YuMWleZ+90xBoZ8lNJ2?=
 =?us-ascii?Q?YACVGwQ9YMQXDThZlH3GAzCzUFXqkIdrIEywl5Z63tblSZhog10fgFWzQkwF?=
 =?us-ascii?Q?syLbXnNicQFUfjP/DaipmDkYMhtzTGSn0A57pffvQq8S72OeYJn3rQuKmvfK?=
 =?us-ascii?Q?42/jftleXZA7Q776NQiJcHaB0fOfIkz6Rwiy0NuNs4znea7AzbCsDXu7/WWe?=
 =?us-ascii?Q?ywdavtJSwv5G0gdCdFtfYSfU3LgENoYndhDjCdY/nZbW0gnuMsCgDrjEb+7B?=
 =?us-ascii?Q?ie/lL6xjZFvmkqjYEXmmStiijKhZbelJNt4MCU38x2lJs62w6rxWWqi52v5p?=
 =?us-ascii?Q?RdWwDZQIDecKtS3oRuRIBIleUZVdXAoS+xl7QbEP/Sndygvc8zmTucBA21/K?=
 =?us-ascii?Q?tj2W9e51oJSTQ4kgFd8FT4Mx4FBTJmk03HYwILELSMGPaJ5xHbXoSfoA0Hqi?=
 =?us-ascii?Q?TcsM4rLNfxBYMR/02ft6lQ9yXJhmg9vIve43gbKqoQOBroElTR17WW3gjXQW?=
 =?us-ascii?Q?9knMGy4xpntWI1p1Ib1JZ1N4MvrDMnoVmjQAXJNdoE5Cw2IRfd4xYS4iTPcr?=
 =?us-ascii?Q?gXgKoefPNvSWFU2dzHQ05Egu/qysJ1ZmaFkQj81fv1SKYKVlcFKex8ga944Y?=
 =?us-ascii?Q?reP1IhUdSvbt4iKU+20L3vtyXSYERwFAzBJSh9lRWSDhgjzeM3W9chc2aEy0?=
 =?us-ascii?Q?gjbzmEpiv2hKN42sfmmqAktS9GRoc18HI9WGI7H4dXLCZcRmFphpEYSSzGQe?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	D8nulWBJKpyQWesQNPT9BkhSXU57CsuujyQGh7bMs2FI6W3XDk+MaILvx4T3+/ZN9OedZtP8+nuklVZO3bcQyIbgKe+rLZSOVNURFrfqS6w6hON0IZgwE+nsAkfW7nQVpJwt0nlNR7chZeri7p6FxMopW6G8WHTaOV3fx+K3lgrmYSS8ezYGTasAPOBeRJmaGm+stHCdw1/ugWopHvNnUA9rwqp9wcj4PpfVFx5go0gxarY1H7j/K0wIIXTRFd4Sklnq/12mjH3jXSoTD3+zlUvNXKPT7j92YE4Iz7Z0xNzM4jPSXNCbN6rKYDzSiFhyxG9L0An7z+6eQlowvT2M3PnyjrTvHjV6V88Yp+4wr3RzbtxgBLZYOg57p5Q6SrcGBYbeLt+FPuCg+FZb6wb689LELCru3N1kbQrk36WMa8zftLY8cB0z6HffF7rPvsgRHxl6omTpSJFbNbN3WWfXVhWwwb02vZqA23/bzMZXhH+Bl8gjWlWNjsp0eLrbPUgZ3Zn68uaIPkBJxCpd3zvsABu15NOZb56Yk3WQ8FrdZqAYSDOpEnn6s6o2j+a9KV6OxzenS0ao80aOJick4vmAZDgpTTy+rVv4mDSyttTVVBI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b40cc0b-cae4-47fd-07f6-08dd6598d522
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 21:15:24.2778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6tCf4pOg2VAZKpHeKWMkgHGXTWb4nNIDBn4xSYHdgwRlV3YXt7SZpNmdsPow3AxLJedNo+jx15tHjSa4Mx5M5j4uW0158GtgOiL4m6jP/lk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7105
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_09,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503170153
X-Proofpoint-GUID: WKbj2fwl6-b4KPIR04sY7JRWS1wgIB1l
X-Proofpoint-ORIG-GUID: WKbj2fwl6-b4KPIR04sY7JRWS1wgIB1l

The PROCMAP_QUERY ioctl() is very useful - it allows for binary access to
/proc/$pid/[s]maps data and thus convenient lookup of data contained there.

This patch exposes this for convenient use by mm self tests so the state of
VMAs can easily be queried.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/mm/vm_util.c | 62 ++++++++++++++++++++++++++++
 tools/testing/selftests/mm/vm_util.h | 21 ++++++++++
 2 files changed, 83 insertions(+)

diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index a36734fb62f3..891ce17453cd 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <string.h>
+#include <errno.h>
 #include <fcntl.h>
 #include <dirent.h>
 #include <inttypes.h>
@@ -424,3 +425,64 @@ bool check_vmflag_io(void *addr)
 		flags += flaglen;
 	}
 }
+
+/*
+ * Open an fd at /proc/$pid/maps and configure procmap_out ready for
+ * PROCMAP_QUERY query. Returns 0 on success, or an error code otherwise.
+ */
+int open_procmap(pid_t pid, struct procmap_fd *procmap_out)
+{
+	char path[256];
+	int ret = 0;
+
+	memset(procmap_out, '\0', sizeof(*procmap_out));
+	sprintf(path, "/proc/%d/maps", pid);
+	procmap_out->query.size = sizeof(procmap_out->query);
+	procmap_out->fd = open(path, O_RDONLY);
+	if (procmap_out < 0)
+		ret = errno;
+
+	return ret;
+}
+
+/* Perform PROCMAP_QUERY. Returns 0 on success, or an error code otherwise. */
+int query_procmap(struct procmap_fd *procmap)
+{
+	int ret = 0;
+
+	if (ioctl(procmap->fd, PROCMAP_QUERY, &procmap->query) == -1)
+		ret = errno;
+
+	return ret;
+}
+
+/*
+ * Try to find the VMA at specified address, returns true if found, false if not
+ * found, and the test is failed if any other error occurs.
+ *
+ * On success, procmap->query is populated with the results.
+ */
+bool find_vma_procmap(struct procmap_fd *procmap, void *address)
+{
+	int err;
+
+	procmap->query.query_flags = 0;
+	procmap->query.query_addr = (unsigned long)address;
+	err = query_procmap(procmap);
+	if (!err)
+		return true;
+
+	if (err != -ENOENT)
+		ksft_exit_fail_msg("%s: Error %d on ioctl(PROCMAP_QUERY)\n",
+				   __func__, err);
+	return false;
+}
+
+/*
+ * Close fd used by PROCMAP_QUERY mechanism. Returns 0 on success, or an error
+ * code otherwise.
+ */
+int close_procmap(struct procmap_fd *procmap)
+{
+	return close(procmap->fd);
+}
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 0e629586556b..aaea0ef78322 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -5,6 +5,7 @@
 #include <err.h>
 #include <strings.h> /* ffsl() */
 #include <unistd.h> /* _SC_PAGESIZE */
+#include <linux/fs.h>
 
 #define BIT_ULL(nr)                   (1ULL << (nr))
 #define PM_SOFT_DIRTY                 BIT_ULL(55)
@@ -18,6 +19,15 @@
 extern unsigned int __page_size;
 extern unsigned int __page_shift;
 
+/*
+ * Represents an open fd and PROCMAP_QUERY state for binary (via ioctl)
+ * /proc/$pid/[s]maps lookup.
+ */
+struct procmap_fd {
+	int fd;
+	struct procmap_query query;
+};
+
 static inline unsigned int psize(void)
 {
 	if (!__page_size)
@@ -55,6 +65,17 @@ int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
 			      bool miss, bool wp, bool minor, uint64_t *ioctls);
 unsigned long get_free_hugepages(void);
 bool check_vmflag_io(void *addr);
+int open_procmap(pid_t pid, struct procmap_fd *procmap_out);
+int query_procmap(struct procmap_fd *procmap);
+bool find_vma_procmap(struct procmap_fd *procmap, void *address);
+int close_procmap(struct procmap_fd *procmap);
+
+static inline int open_self_procmap(struct procmap_fd *procmap_out)
+{
+	pid_t pid = getpid();
+
+	return open_procmap(pid, procmap_out);
+}
 
 /*
  * On ppc64 this will only work with radix 2M hugepage size
-- 
2.48.1


