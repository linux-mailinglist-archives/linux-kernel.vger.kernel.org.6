Return-Path: <linux-kernel+bounces-381665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D889B0257
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58B3128361E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D9E20495C;
	Fri, 25 Oct 2024 12:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NU6k//XM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d+nTQH8n"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C98B203703
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 12:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729859241; cv=fail; b=BogAuqW1iNC/T5OphJ5vHexzq7aXqRH0nTQVEy+V6IRxFGvjV7nBg/Y57fWcqKPH0AOiShSxoV4ioUnZOTb5kUDcAzy3wtbUx7Th90T9u4D5j2hAVugbAEGuoprYiLttkOfl4B1XaJ4g++AE462BDw1spYocVwFdoezUl+QmT2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729859241; c=relaxed/simple;
	bh=LBSjk6vfUIq9PpwrB3e6JjAcOL+38PGFK0yxTmawgTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c+OiuJ+Tfp/7zLPHR1F/R2SLcNoRGth77OZAL/sKdT/PxlxD9wIUVo4Wa1t300Ngqgjg11CnpOWTRPljwzdPQzL+rtw0Y7c7U04cL/BOjxI3IkAcbY9gFfkvCqR553cuAzxjT2nk2L4C29f3HmxszEsk8iGAo7g4E23uTsurEHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NU6k//XM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d+nTQH8n; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P8BZgo026805;
	Fri, 25 Oct 2024 12:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=rzah8PtqmSFAEkrgx3+NN4GKeumy7rZse5pxRqGcMM4=; b=
	NU6k//XMb+TkwpLqE9l4ORvz7oc7dhH3bAjyRGPv3vkABROj6uuEc5FOm+bCVL+Q
	BjAL0ZtqqSmMAvC/RaX+jrbasy4W43/4saqpAInPOtDIg+5c3lM+S565yHkUG/Dq
	aNi0Iu6ahUQvYC8m9QuaUxFJzYXJ5Jflid494/zQIpfFuPAdnnmHS+wUsepmNHu4
	jqEYRyy/S1R2vL4G3rs1wsAJcadseIDKYsWc5pr3gcB9k8kGvILPvKr7EnhydHKf
	SqMmAuviir44DaeAvqmjMEEj6x02mdfHQGM2oHdsrh6JmrtmJci/mOYQ2riAVPPm
	DiqeTNOeRJrX6+wrtpqCPA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55v4u6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 12:27:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PC7U62015833;
	Fri, 25 Oct 2024 12:27:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emhc7tsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 12:27:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vuN4Kvecfo0MJjCubI5yCv+oQUhA0uNs8rSng/QWq2n9dxlvU9Y6vOhTlN9ysAUmh1a0ep35JIZU1PxlQeneb8wBLzsvk3TH0LrXdsmTXU6UsB/O9/eSXKJs9kpkxunP7ZOnYgUjiPGgLDrLiBK23QCN6GbwQ8K8ZW94xO9Zwqjmb3xMOpxAqRa6ILpS5fSL4GfSoJqPDURZWvLV7V81+J5dcabitzuoUe8SLPye0KzIb/fuBTHtFS4pxkRMfsQ4LmF+cFWv3XTMvZM78Q7uTw1apCC1rKd2M/gqGTqdMZXqTIYHQOvE+n4acEQ49cKTdsLMtTdTcJda5grbIk6uBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzah8PtqmSFAEkrgx3+NN4GKeumy7rZse5pxRqGcMM4=;
 b=D6oKmgNf/UXzpL/dXz+9f7KWHoxZYgb2JutVdRM6s/N20GNqwRZlNbSL9ns4TYsWRRxG+WIjXXhIOCsst4/dBl97adfdXL8eVidv+tV36kQPuC2Gh5nDdHA8JXFIikklgHDpYTu8K7BzmL2JOljvMbn0gLQTH0HQnbdk+gwNKdmydwjikV5uv+/flMDY0M7FfPIo4UTWljvAK+Y36tDexMzz2sg1oEi+T/jSAyZ/gMXUDTdN5nppmjLdwlqNF84mzEmWX2JZpEs+665TA2lKMRVBlz31aFpzPt0Z2/6f7LKE+VVfpK7MrDTIxpEITlMF/6FU9eULXUhsjaI96TCi4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzah8PtqmSFAEkrgx3+NN4GKeumy7rZse5pxRqGcMM4=;
 b=d+nTQH8n3jY/vlBTBqStNRSTTmeuMf1NZfjX/CTB+Jf/SJNr4ZxQW1d7xV+xNsabH0t7wGa1lA0o8J1NQ2j0EMAXv7b6w3YH1Yhjle96Xhx80Js4gDOLE1SXHDFBf+2V+fZZFlrMjdMgVnqyorh4iuQuag7N6fjOBS7A+moWOqg=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CO1PR10MB4484.namprd10.prod.outlook.com (2603:10b6:303:90::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 12:27:04 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 12:27:04 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH v3 5/5] mm: defer second attempt at merge on mmap()
Date: Fri, 25 Oct 2024 13:26:27 +0100
Message-ID: <d4f84502605d7651ac114587f507395c0fc76004.1729858176.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729858176.git.lorenzo.stoakes@oracle.com>
References: <cover.1729858176.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0175.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::14) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CO1PR10MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dfb44ee-6443-4906-9909-08dcf4f05532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qYJuqreerQF9eUS63UnHKlkXtcJOCi7u7FFhi0Fretog8trb9ejn+9RZi3rc?=
 =?us-ascii?Q?s3ebrojTEX698SSIuxzXJ4bMC7XzvyLr02xg77mEVYjmGohgyrNAijFovBEx?=
 =?us-ascii?Q?YdiXVTWg3cDi11OVVj96q40Ib/uagCgwaUjmL5V/ajFJDBC8oT26XL/rf/+K?=
 =?us-ascii?Q?dLpA3ekKjyONPSk2IZsEw445LoS3iMyEdnm+Og/mX/h2p4E5DAnQpLLKMl+R?=
 =?us-ascii?Q?GtFrPsug5nY5Tqr4tkKKFDKt7ifUtn/jkIx+Z4dFY7Ndn+KHfK1cE+wrakhz?=
 =?us-ascii?Q?ERIXAOfq1e70Kx/PIbbZFeFZoxJhNw9M2s3k7WAHY52bpsvI9rkoR7d3MXkK?=
 =?us-ascii?Q?uFZoIGax+weg6c/eEDT+f7s/bxxI1Y1FArAmNXMw7RhC0d4zNr2tu/Ore7qZ?=
 =?us-ascii?Q?BB7Vw1kd6hUjbULMwqdil8POo+R6fgNITU+aOcNM35LutC6uk5gzkZ5T1Ne7?=
 =?us-ascii?Q?SiZc2/oL9zVL0469Hj6LnhCBR3Zys2lVH3sj0ysdWFcGUgLQ3MW4Et9ZTkIS?=
 =?us-ascii?Q?6v5Fa0prkwqTeq2CovyA7a7mDrY5IZpcgj3nWDzNroE67bPxm9d0Gk9OD+Jf?=
 =?us-ascii?Q?twg5OwIV40OK4y26TgGTTJogo2UWwS6vwypwyiNomZOy6iAHKnTvKEnEiwK0?=
 =?us-ascii?Q?tvMzei63HmwbtSg4w3TMgkBQRwU5GMa+rHOo1OqQogCPrx2TtScbWKsfczZR?=
 =?us-ascii?Q?Cl0+3ijgc98Hc6os0XKEAcLNG4phXB4MrrQJLhtXsFDKMH4vorFG1/+LCvZb?=
 =?us-ascii?Q?xjGhGXucILYb3Y+DAbYXOzV2sYur69B6c4BqA5pcByyq8dpgDXHhhfkPWJSJ?=
 =?us-ascii?Q?1I1YE4PM3Bg/GQQrgapfV6KK2DAI9FXftN3sbhWTpou1w7NVptndhwj1KotW?=
 =?us-ascii?Q?83bblAMBFsohOY1Y5kpKHjtgb06MRBgPmLs2QQhUkjqnar2oJaXdgQscbHA5?=
 =?us-ascii?Q?Ub7hLAMgeqT+kGQAluGT0eV+ckFKZJt0A3TDaKtV9JpXapspcXzKFcxTSLvK?=
 =?us-ascii?Q?PEHnM5zFJkIw2/R9VpR6evCli/lhRrmOWPgkF8rt+Ltmd+IPRGD0ocE51UNf?=
 =?us-ascii?Q?IeQ0hR1rUGg5+OFJj8uq92Wc6VxWD0A/QzwgxU0X61PO/c4pbGMqhA2TDjWM?=
 =?us-ascii?Q?e2IUf+qZYAsdKKsDoBTR76air6Mt5MlbdYzpSS6j71tfGfit1JlrC6vvuE8R?=
 =?us-ascii?Q?fVwgQJVg6fEcoMV89VvqLdjRxdQbV9lYZdt/O43uqq6HUf4I78W7XoDPAMyA?=
 =?us-ascii?Q?tHmhnETFMwaOqhX03Ok5seOhQJL2QxwybAoE/JMH9lJ4Hv8iJjHSf6F//Sq2?=
 =?us-ascii?Q?Je0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+3uyN8lVUn8n+fz75PQhfHl7jSyB3C5kZoHB+3RdtHTZ/J7yLROjn8AJ9Qik?=
 =?us-ascii?Q?f4J4KVVHeABFXE8bYEuPPC0XpI8jW9IrQXaeeYV2/I8MFRnzpYUCWa3n3et+?=
 =?us-ascii?Q?C3Lzk6OIHzMhLjBwz/KS9ZhBqC/wqzUjQsKEQ4BlsATMz3aDE0FvGg4UQn2a?=
 =?us-ascii?Q?ZVLPoxKKI1PnWXGw66DGvYycwBcTIkzot76AvrHZ4cxq9AVZMVD82/tadtfD?=
 =?us-ascii?Q?qFxcGH9VeSzOq8G3/GeUz7kyEAJkvNRICq00vjnG82XMpkM3ArGVvw8OgeD0?=
 =?us-ascii?Q?d2RU9peIBNPA0RESnXoKWXkbVZhl5YBfYOGIP8OaBa7rX9u/5x0dwmL/C27C?=
 =?us-ascii?Q?pW/6JGxe5P3PWP5oiNRmXUn0snNCArAc58PmTyK4IeKZQH7zyXKP2IpmgONZ?=
 =?us-ascii?Q?z8m+DRpVRB7zpw5PsVSRydR0O1pFTY2GOENHLdtV4SyGlOCmU7HI5ypgossw?=
 =?us-ascii?Q?xAA+sjBE1RdN1/v2kUmGqV+Gci4X7GKRFoC5JHe/6FvKBr60aBOQ3Q4B79+8?=
 =?us-ascii?Q?Sq7xIzoalKgUFrHFkR6qf1QmP/uLXRIty+oFN6eap1u70otqmV9dMxsolXCf?=
 =?us-ascii?Q?jSgHaSluY73EFkxqs6jZ3QMKg7XPVuFl11zVtCqkRxrCKddLcsw9viQ3XqeM?=
 =?us-ascii?Q?oiG6q7ukym8Kr3pXxP+pl3YP5+Wc/2nYSgW+IwuprsdU/E/SniQwneK/Rl6k?=
 =?us-ascii?Q?xkGEvoSdBUYZbC4hm/KjaKUJ02dQgmM+pmKv3emjF2LPIIOwBuMPS3YZ9WyM?=
 =?us-ascii?Q?t1NUVZiBDjgbRjAkhDrouMgFWsxKLTsdMp9PoUyAICuUp3E9Hzko4yTmRLzp?=
 =?us-ascii?Q?6Z6U9yXixG5xs6ujP0KypKpbRiJc7yK1oDgQybj+2k/9pAY6bhYDHShTpIo0?=
 =?us-ascii?Q?qD2Rq8tY9PKy7KWyN0D+tMHFnrNkRewEQRJO5DAOyrhlAEDOYBFuc1rRcSi7?=
 =?us-ascii?Q?pTUxc639M8X1/tPS/d6YKOvQTNjSgHuBgRV/g8Tl30rzEHvhWVZn3kvITpA2?=
 =?us-ascii?Q?cFH5XAwMBH3dZMaHaNbSwW+393qPNrz3KKRYtKFKN+7gUdI8prlM3n6tqpRA?=
 =?us-ascii?Q?5GzVDYopR1fI4JtFeXynOj4Z5XTris0FkRfDpf4xX6hZkEdT6h+B5PU8cDgk?=
 =?us-ascii?Q?xoTtZpeQmV5iwVB3oRq6LE9LiHGL+4ZCv7TYh+jyOCHHtzV6b5B/QI9ufn0W?=
 =?us-ascii?Q?Rb//TdhXtr3wdCmTBNI5WpQ9ylf58RNc4hXmNCT9PLfJm4b/OZSesi37vIu0?=
 =?us-ascii?Q?v2QZpy2X0squutTqoW2du/odpLyloU33vo2SWMWioh3cXtdHjIv/zXInr5ta?=
 =?us-ascii?Q?pB8W7UCSaOAcVJD+WEkcyC0X8Ei8oLpEMHT7VCepXFDyvG+FwrOPiPpFJKzs?=
 =?us-ascii?Q?7YWjLvTaFKprgWcngCJMqeCQE03h7o5EdSSyUXRjiMNiAF7WvuBFTA/fiS05?=
 =?us-ascii?Q?Buo5T4PgSR3NJZqIpEs+JjmBZ6JPEzHVtsQHpAS/fZm7kd77hLp6GCjCZ3Q9?=
 =?us-ascii?Q?pAPffGgTqpOLoudDFJ7W3DLmA9CZzOX/rCbPaFDnXqaEAN5p1h0q6MtxuyaR?=
 =?us-ascii?Q?aaKQGy1Emepk6QIYLzPqVFtGW0Mf3/gOgDOpkuZ2VU77ahxEAfcQuL1JGT58?=
 =?us-ascii?Q?Sz9EwkuRbNIQQWHCsa4yfB/t4WL1gPO1T89tf7aFFks7n5O9NqttqpRXwcDE?=
 =?us-ascii?Q?ZfQCfQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lJiofi6nJtiajkXLDa0h3aGGlb+B5ShIJtcwI4UZes4KDXME9RLlwv5IXgVuXWH1FPFMx1KNs/bIO7E5zpsYajEbImvnJegmDGlImaIxvQArkv91EY6i3n5cTm1BSwOH3uFiewVMBT6XLm1YeU20cPnYFzkIUR1lPYp/Q4eNomAJMPQJQBvD10v3AuWsS1xGhkB8VIBZg2TDw7qnirOLqyC3qkiwfFh0r3rMAVTiJK2Hd2pE4/EbMFCCn6Cwou9KFlch5F7Dvq4cZb4hHzVO5Y0yB/XA7Q7bIbeg15riugzsCAskFB3muLYi/o7Y3jUi1eEb2PRD/7HBE4QjBE4WX4hGinuqnF1zzbwE74rBMRFIeFe5qhmJmWS34lh2gbbyE9jGXrzLFdp1ojo3QHQSm4rR31VmcItl9SGujJ975KiiY2HXj6h3Fa1CiievieAvyguKnojhNF5LPzZj4EG6MCc450Jk6LhAJ2WGQiLnE78vV4U7QSNqGkIarsPP91S7G3k5Eji9b4TsVWVCo420RwTIl9iLU+SEzcqUbS3vjJEIDAUtpaYD9T7KzMpttIytad7TIokqo11yqu2CygB6Z+vStonB2mgqgJQ3a+2DFoY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfb44ee-6443-4906-9909-08dcf4f05532
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 12:27:04.0639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qnhg7qMjYjckbdbujNUcTYaZxDF9TdxeEieuYAb6NZNm74nj0sdSFbeUk0EUoSxrEu5+uEkGPUiCk0SkCoWUO8nMk+djPbYfJ3VDThCVrXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4484
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_12,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250095
X-Proofpoint-GUID: 4846HGWgGTtz7mQcL5vJE8pt_jl0mp-L
X-Proofpoint-ORIG-GUID: 4846HGWgGTtz7mQcL5vJE8pt_jl0mp-L

Rather than trying to merge again when ostensibly allocating a new VMA,
instead defer until the VMA is added and attempt to merge the existing
range.

This way we have no complicated unwinding logic midway through the process
of mapping the VMA.

In addition this removes limitations on the VMA not being able to be the
first in the virtual memory address space which was previously implicitly
required.

In theory, for this very same reason, we should unconditionally attempt
merge here, however this is likely to have a performance impact so it is
better to avoid this given the unlikely outcome of a merge.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 55 ++++++++++++++-----------------------------------------
 1 file changed, 14 insertions(+), 41 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 7c690be67910..7194f9449c60 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -19,6 +19,7 @@ struct mmap_state {
 	struct file *file;

 	unsigned long charged;
+	bool retry_merge;

 	struct vm_area_struct *prev;
 	struct vm_area_struct *next;
@@ -2278,8 +2279,9 @@ static int __mmap_prepare(struct mmap_state *map, struct list_head *uf)
 	return 0;
 }

+
 static int __mmap_new_file_vma(struct mmap_state *map,
-			       struct vm_area_struct **vmap, bool *mergedp)
+			       struct vm_area_struct **vmap)
 {
 	struct vma_iterator *vmi = map->vmi;
 	struct vm_area_struct *vma = *vmap;
@@ -2308,37 +2310,10 @@ static int __mmap_new_file_vma(struct mmap_state *map,
 			!(map->flags & VM_MAYWRITE) &&
 			(vma->vm_flags & VM_MAYWRITE));

-	/* mmap_file() might have changed VMA flags. */
+	/* If the flags change (and are mergeable), let's retry later. */
+	map->retry_merge = vma->vm_flags != map->flags && !(vma->vm_flags & VM_SPECIAL);
 	map->flags = vma->vm_flags;

-	vma_iter_config(vmi, map->addr, map->end);
-	/*
-	 * If flags changed after mmap_file(), we should try merge
-	 * vma again as we may succeed this time.
-	 */
-	if (unlikely(map->flags != vma->vm_flags && map->prev)) {
-		struct vm_area_struct *merge;
-		VMG_MMAP_STATE(vmg, map, /* vma = */ NULL);
-
-		merge = vma_merge_new_range(&vmg);
-		if (merge) {
-			/*
-			 * ->mmap() can change vma->vm_file and fput
-			 * the original file. So fput the vma->vm_file
-			 * here or we would add an extra fput for file
-			 * and cause general protection fault
-			 * ultimately.
-			 */
-			fput(vma->vm_file);
-			vm_area_free(vma);
-			vma = merge;
-			*mergedp = true;
-		} else {
-			vma_iter_config(vmi, map->addr, map->end);
-		}
-	}
-
-	*vmap = vma;
 	return 0;
 }

@@ -2346,10 +2321,6 @@ static int __mmap_new_file_vma(struct mmap_state *map,
  * __mmap_new_vma() - Allocate a new VMA for the region, as merging was not
  * possible.
  *
- * An exception to this is if the mapping is file-backed, and the underlying
- * driver changes the VMA flags, permitting a subsequent merge of the VMA, in
- * which case the returned VMA is one that was merged on a second attempt.
- *
  * @map:  Mapping state.
  * @vmap: Output pointer for the new VMA.
  *
@@ -2359,7 +2330,6 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
 {
 	struct vma_iterator *vmi = map->vmi;
 	int error = 0;
-	bool merged = false;
 	struct vm_area_struct *vma;

 	/*
@@ -2382,7 +2352,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
 	}

 	if (map->file)
-		error = __mmap_new_file_vma(map, &vma, &merged);
+		error = __mmap_new_file_vma(map, &vma);
 	else if (map->flags & VM_SHARED)
 		error = shmem_zero_setup(vma);
 	else
@@ -2391,9 +2361,6 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
 	if (error)
 		goto free_iter_vma;

-	if (merged)
-		goto file_expanded;
-
 #ifdef CONFIG_SPARC64
 	/* TODO: Fix SPARC ADI! */
 	WARN_ON_ONCE(!arch_validate_flags(map->flags));
@@ -2410,8 +2377,6 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
 	 * call covers the non-merge case.
 	 */
 	khugepaged_enter_vma(vma, map->flags);
-
-file_expanded:
 	ksm_add_vma(vma);
 	*vmap = vma;
 	return 0;
@@ -2493,6 +2458,14 @@ unsigned long __mmap_region(struct file *file, unsigned long addr,
 			goto unacct_error;
 	}

+	/* If flags changed, we might be able to merge, so try again. */
+	if (map.retry_merge) {
+		VMG_MMAP_STATE(vmg, &map, vma);
+
+		vma_iter_config(map.vmi, map.addr, map.end);
+		vma_merge_existing_range(&vmg);
+	}
+
 	__mmap_complete(&map, vma);

 	return addr;
--
2.47.0

