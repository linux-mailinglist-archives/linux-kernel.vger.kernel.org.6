Return-Path: <linux-kernel+bounces-548675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7EEA547E0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 441353AD744
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF299204F60;
	Thu,  6 Mar 2025 10:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KVGah5E6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gujjvwQi"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBCC204698
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257279; cv=fail; b=T6VTtDrV0MyXuJxzXDQP46iadlEgYujWmW8twjDa4XWezdchGkG9fw7kmJJyRjlfrhbgVUtefIJqJAZVbtOdrjbaZ1OaFY1rvhRyZrbkrRMGmsvGJDW4T3UrdBixpu5GITl7fbXD4e1j8T8ch64+WN3GZz/U5pwGYq7AZGibn3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257279; c=relaxed/simple;
	bh=WpXrN8kgsJQakXMim527OszG4FGOmRrpaosQtsIt3XA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qHquGpzrN3Ecv9r9lisLCRpqrcocq8KI6++urNlAs2NzUIKuzNOGOkByI4H0ebgwLfm939s/t3OejeW0Fdyvs0LnpsiPB19k6D4fxPYVyMDE+bYTiknKya0xgZUXklIVs8kvlHRhkf/weeziBUlGC7gG2LNThAgrLE1BnZySh/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KVGah5E6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gujjvwQi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526ABfhN024547;
	Thu, 6 Mar 2025 10:34:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=5OOk1sOhqeNPU01ZgtOnGB0jLypwuBEMjd32gqcDYoo=; b=
	KVGah5E65sHnvkWoNY2hAwWLbfQixlQbjXmQRryBGWy2eyKEdRuQl3dkwB0jGVN2
	SvsJcTAUwuHvmBb9Pp8bnKKmttRwGjTzAThQ9vBts0NktcqpvxdYMLebzKWtkXmW
	txJpspEMge2voMFi2N1o8BHFQDrQDpUTqnuG1PnhWMgkZQAPchXr2e3VbtebZvbL
	nfIeBU9wtD0AKIn8P5wZ2UF12VrcxOBYBZZNFMECKO84ntAg1r0nliMSSEJTucJD
	4mysf82rI3nlJCp4KdmMoC/sff8gykqU1ajSyMlTVJBR9b2XSj6XlLLjfb0Y6aB+
	FaiIgGzznYNohHVlDUpQKQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8hhttd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 10:34:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52693cEn038319;
	Thu, 6 Mar 2025 10:34:16 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpj67vg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 10:34:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GakV068XVdrNs7qWV48BLUrK9/9FHo3It7MhATPDZboOrJ1nptj+7BqQul0NU44re9cFacyF84/LV04QFuZ6pjo6pqd9smNb+NR9WnG9PO/5A9bgLhUpz4qBtIdF6REmrGg/CqsTzqsSpw3vPCPBllVChPUwWwPx8uu947igzo0f36SY2tNblxHgZ7Qll8g14BeY9JRzt8qbHRrDkDMeg3w6lgzTueRx3vhonMEruYSAAn79YdGFUrUzS0c5qGN6s1gfLuSeOT5GRHdc+D1I7rnEC+ghjXMN4/cKXvXWRBIyuN23IPbBTBbmYX9Z3m4wA30m3mNM6QGLYT2eK1US3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OOk1sOhqeNPU01ZgtOnGB0jLypwuBEMjd32gqcDYoo=;
 b=BZu4OPitaTN/1C16d8wJGi22UnfPXPBFRO8VrE867ZerC5upBrvfoKpn/nHKPQYmZGNL8UHnpxjvHPL5HsodD0aN9/uyzVwOiLGdwQ588EnrBAFu9pD5R08gNRH3oRQ7OCGdT7zHe4PRDd/FMP+m/e9Fsa4i2fJC1VBg2W6VaWtx2xu3peiluuzowauRLyASOhwrEYTIRjAYqB372Gvuqc5lJV4pbjeSyq6iPWAbUXsDMmPKj0knahOcZ1RvGqnRL1kHBU8B2Q8IUnp5ciZoznakmlwoJcWypwFdslgdYXGZ76SknPspirm5mdcHeSlazEwhz8XiU9hk+UL6H0+z7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OOk1sOhqeNPU01ZgtOnGB0jLypwuBEMjd32gqcDYoo=;
 b=gujjvwQibPbvRTP9KH6h1QY9XnEWvTWtdtw+a7RB20mruyGG2WmPCvXlDs5wYm4fd0AzkQlQxx9JZ9enn/9+yjqZ8gnFhztH5rX3Lgs/hzuBmiieLGzV2OPEDdLFj7qMQgBCrEGHXWvacqzYV8kZtTRG1ZlITBvMZIyZNPGVTU4=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by PH0PR10MB4647.namprd10.prod.outlook.com (2603:10b6:510:43::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Thu, 6 Mar
 2025 10:34:14 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Thu, 6 Mar 2025
 10:34:14 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH v2 3/7] mm/mremap: introduce and use vma_remap_struct threaded state
Date: Thu,  6 Mar 2025 10:33:59 +0000
Message-ID: <1aeadc40d377fff8796b7c114cb0351c92a68f20.1741256580.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741256580.git.lorenzo.stoakes@oracle.com>
References: <cover.1741256580.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0372.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::24) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|PH0PR10MB4647:EE_
X-MS-Office365-Filtering-Correlation-Id: ff49a02d-8832-489c-b199-08dd5c9a7080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LiMKxbqt6XoP1bqhmBe27bdhUg5W7KLo1hC6FuN89uSOX+M6HRswZi9fX0Ue?=
 =?us-ascii?Q?HQAbYv/29Mm2E28DF3TXyQU5K2uj+2QfMftBGzY3YZ4wNhl1o0n1v04JaonG?=
 =?us-ascii?Q?KLefmf546HIsmfcCSrYJsU2YFurrFK48dtJog2jtedEGGzF3YbLMBl95vLdg?=
 =?us-ascii?Q?dPnbtGkSag73pPrIgREBt1MpkDK9es2fIiFv9ufWY8y+eARbho+oV5ZweV2l?=
 =?us-ascii?Q?MeMnW94jU0THfCf0ZztlpGKBMQuV/GOEYLWPHL2/puqerFDtZj6qrNSdY04V?=
 =?us-ascii?Q?pzW2H1T1NntOhym5Vhn9paPzIj6gID6Md2yfTm6RL9CG76zNhWyWe8oCchF6?=
 =?us-ascii?Q?3flatJzf0rZeiJTfHUpQZIU/oxhYP73DmVTerp0h4oxybFsp0t8DtR1+sLws?=
 =?us-ascii?Q?w/b2D4Dv+ZreJ6WPRD0nwRfLLULQhsLyB4U1RVgKi/etb88+o76cjYb97KP+?=
 =?us-ascii?Q?5qkU20UxWfHdR47KogkJGBTO4oBOI9/NUXKWNNCT2DcPjdIBtxAdBxviCdvJ?=
 =?us-ascii?Q?5ztq4kxy5mmWDtViAowR0tIsc1GpiT5udrdAS6UgoOYjPF4EUSwdZcsE4ovU?=
 =?us-ascii?Q?yOr+hsYMZFracYAuoDkhpa44FDm7/AvEkX9IdzNb+plvBkREMKkEx5lHUCN2?=
 =?us-ascii?Q?aJAvF74LCX6+ZEArXCBxI0WpyzITVpryQDj/iX8W1/CzcadEr0bVv1ZBFb1k?=
 =?us-ascii?Q?x1rQhotfyz1bS6qTPomnfLJ8FjTw0qZp1rB77T/ypeQ3ejynI+l6MOX13C2B?=
 =?us-ascii?Q?f1RLjidPpVKYzO4KwWXoE86abQ/N+lURVbFGTHkZZXsrI5vVna4FElRDpbGq?=
 =?us-ascii?Q?ZAAwqkrZjYDqBe1uBGN8RRijdiukWo83LjdbZrEIoPxDhHbROq6Q0DXqWPNO?=
 =?us-ascii?Q?rhgeXunxoxVIq3ULntvL3iemK+9xWvibfdg2UNzqOWuTCHXczwL1PrKB8V0l?=
 =?us-ascii?Q?HJc4xoSmhbBLJOQaADIAHDM70TO1V73GyWq8KtAskQj27QVCP20rZGCnm9NL?=
 =?us-ascii?Q?p5Zt2u/D/FUmVOJsaGEdpcH9/KnMxdoUGHZz+i3RdFV0yFb8re8Lw1ubcP3d?=
 =?us-ascii?Q?c1eE88ypDnwcYwD4OaykyKQ++2gdRiWDcxDcGEXpKvObhCRwxRAPkSfoI5nu?=
 =?us-ascii?Q?L+guvkmddf458vQ5GDBlGso8L8JbouQEK/EiekdLPJjV8UiaW1cHtRGHeQna?=
 =?us-ascii?Q?BBw7/iMjI68n3pagEPhnnWS0Y6C6uHdzKFQCSZ+CsDW7JRQsCK6z4oMWvSUs?=
 =?us-ascii?Q?PCKAley4Hp40ZK3uTCL07tfU3rnzL4gWCyEhzueUBRTa41yLAmqtq8lCHlll?=
 =?us-ascii?Q?znHD/WQo/6wTTXF0NwsT6M/W9cjk/9aUYYF1sZS+P9lQliIy8WN0KHepdiCL?=
 =?us-ascii?Q?7+9DIdNeszEs/QX9wo7Q7zx28ipj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sE4bkTSiGU4m72685KkObvOJwOSQ6CYurAUooJ/Ak7bgQsd2aA6J7NqStBK5?=
 =?us-ascii?Q?3/St/Lf7ArKoOkOAybvqHgZ4Yi8sLEeHa2kDACK+ZBnJElzFezL6WpqUxEZ0?=
 =?us-ascii?Q?UDqGIPn8IWQ7ZMp7mVZ8JWOsxiWy6Fmpjor1Wcc8dZdmKnUFyTNaAOxb3xEc?=
 =?us-ascii?Q?iM2RihJ6jr0PZYe5QvMfsNwQEfDprD9tarN2i29dCtpb9ZP3Fl/VE+UlSfe/?=
 =?us-ascii?Q?+QClbUUzuOWD9+Rgab5BMAKCvAAa6i0A6y7UH+kR07UDAB/3LqT7wsm1lZpO?=
 =?us-ascii?Q?u6EBSy8kePjErCIBsg9rG75NaUdIUjmfBwB98PSWDvMsb2tsEFzTFFOx0NNz?=
 =?us-ascii?Q?LT37MxmYUaGlAoy1+DOseiFN0V6c2ZWCT50arwIqPua86zYuIBeyywKPNVaR?=
 =?us-ascii?Q?cYegiS+B2hVzC5Umtmp+QEiELCEVEkGxVSFO4HWwCW5NXl2e7p0Fw7AqMReC?=
 =?us-ascii?Q?fpRI8kBoDRsAUoHXsmTy0fZW6NBLVW3dOzDBi/0J2oM2Np1VzGS8zQKiJRIn?=
 =?us-ascii?Q?Gik9wbGioaMhiHA9HXbTeDcygZYvaeBNQH4hLEgSeJ2NFevlcv3TVMp4ikwv?=
 =?us-ascii?Q?c74DmynFTz/c/X6NEV8VSAmADUgiHB4B4bn8+/B6yFUgb3jMCdfH/SNZsDMW?=
 =?us-ascii?Q?xOi6QBXbRe9QwR6QScSljB3GMt3XASuywjZupQ0DUS2CmWwcJWjYe24WvCMa?=
 =?us-ascii?Q?YwTJ51ImC9ReznXeTMeGU2eF3TzdsTSlhUnCJwYA4DfwYCC6fM0vFJ/Y4oRU?=
 =?us-ascii?Q?h0kJtVCHat2VZ8DMKIt1c9WUYCTK97jPqo/sjbFvPHR+yTRgs9hamjNHAEgT?=
 =?us-ascii?Q?jlhLYxLjN38y66flTOH7pIVr8qDAIPoiCk/RKvVXzCf2n4+QtMr1QCduvba1?=
 =?us-ascii?Q?usC3ZzPgOOAuRCZLqwa9ELjBWtvxp5p2b6gia8GjrL/X8w9rGSE8zCocV1bj?=
 =?us-ascii?Q?5uNhvv6V4HC9urXdRed27S/rZvRUBINnQpSx/qLIdW3vWpbAmoBz/nMf40En?=
 =?us-ascii?Q?uiKlnIeCP+S38juhuXHm0xa/dtVmGTlY6lgr6lp0hx2H8JDYMsa1onipOWfy?=
 =?us-ascii?Q?ZUyfnHY4BEdK0Ey98tPaHgSCVWafXv+i1EJr6mw6D+oSzDQfIuOHe01muvbg?=
 =?us-ascii?Q?CuxrTMmTBrHuXlJcSig0A9rHO8iVPRLo3OhJTyr+v0GqOBPqaK1lte4wqG7z?=
 =?us-ascii?Q?Yd4B4oiltVV1QNRjV6qbSKSP3CfAN3I6X3wGvvfPenIwJpBqDH/AjlVCzp9M?=
 =?us-ascii?Q?Z7JUv9he/PtVcSNGF4fNpz3m7bjprhkkAlyz16ylBquxSneZC2kPXqtiKb+L?=
 =?us-ascii?Q?Ka4PrcqLdd/b9D5A7pJhdhBxUMi5pdciBnMQfKRDkyfqfitGsYpLAWDGUI8L?=
 =?us-ascii?Q?4fJboshUdKXwHog0dYGITTBChX0wbkeNv97SHKe2L8b7TstUCyDKzwSaZv30?=
 =?us-ascii?Q?9Ycf/y8PKb5peFUeP1eBJCPDTujb++WGqwjlWmY28wYRjNjuegl5SE0c5uJX?=
 =?us-ascii?Q?DQVdbf72SU/BGRRND4tU3A1KnQRfzcABLbOfVD09iU/kyOj7Xw6BtaYXpO41?=
 =?us-ascii?Q?1HNFsaoTzgIoUI03bUKITkabUGGrpkvKYI76uY4TzJt5JXuCKi/Yh8jyDBZ2?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fQLmqqjaeoSrGqc7IkKTSfk7/nl9bCdoctFG+/fKQVQmNRLTLiSOiDtDRC0+dMpqHp8ediVHr23r2c6OpmTslQWD0GjS60w3C2Nj6uCht3OD+DzOWKdn5M3DD7uXy3gpvL0Daj0neaIrUlWCeECtmnQKYtyvYfg0E2O/2iU2FPyTqJ9vaiETlU5LkJRDTNyHpPXaAc5MHgcMn2F2wW79w3BIf7TxR3QlVSrUumJOvrbTBY5IzJrvdjzUBq2C63n9QhJyxzaD04nBur9+wFOQbIIIxd4UezAEJdupC9cR1TFzUBg+EEbe0KfU4h+68op2iRzr7fplV+ZHJgjIOMTsKB0syIWFtlkqiAQg8iORIdtalMbJKAMGCDVCTLWrDb0wpj2cZ1ilq8DWklarvPxC9jYDTj9O/JEatPZFQE03aoX73AN+27dHX0SsLs9zgDH5T73bTCYCQiw2JYyk6q4d78qtXZ1jKT0eNN40maI+Bjzt2bbovDiYxamyJ20IchdZohtpLk1SdFcnNgl5RK+azDdxFjmi2W9uBk+g1kisDjiFbsKol82SCGPbBe42pRj9MIcVjIY42VMyv5H2uvBjm+v/ifw5nEeNP5T5yqUjQnI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff49a02d-8832-489c-b199-08dd5c9a7080
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 10:34:14.0658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzgTENKg+QaocPm3lYAVLgk3+y9DPKyz92nbzObZoYBnXDReiD8h9gWs3FgAVP+JzuIOFZWho82BFXmS3peUojPGkni9LOfbJV/xljND/Zg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503060079
X-Proofpoint-GUID: 0FxVLUWEtqOnwcCOpnFfymdcqYIOtzAQ
X-Proofpoint-ORIG-GUID: 0FxVLUWEtqOnwcCOpnFfymdcqYIOtzAQ

A number of mremap() calls both pass around and modify a large number of
parameters, making the code less readable and often repeatedly having to
determine things such as VMA, size delta, and more.

Avoid this by using the common pattern of passing a state object through
the operation, updating it as we go.  We introduce the vma_remap_struct or
'VRM' for this purpose.

This also gives us the ability to accumulate further state through the
operation that would otherwise require awkward and error-prone pointer
passing.

We can also now trivially define helper functions that operate on a VRM
object.

This pattern has proven itself to be very powerful when implemented for
VMA merge, VMA unmapping and memory mapping operations, so it is
battle-tested and functional.

We both introduce the data structure and use it, introducing helper
functions as needed to make things readable, we move some state such as
mmap lock and mlock() status to the VRM, we introduce a means of
classifying the type of mremap() operation and de-duplicate the
get_unmapped_area() lookup.

We also neatly thread userfaultfd state throughout the operation.

Note that there is further refactoring to be done, chiefly adjust
move_vma() to accept a VRM parameter.  We defer this as there is
pre-requisite work required to be able to do so which we will do in a
subsequent patch.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mremap.c | 565 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 358 insertions(+), 207 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index c4abda8dfc57..0ab0c88072a0 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -32,6 +32,44 @@
 
 #include "internal.h"
 
+/* Classify the kind of remap operation being performed. */
+enum mremap_type {
+	MREMAP_INVALID,		/* Initial state. */
+	MREMAP_NO_RESIZE,	/* old_len == new_len, if not moved, do nothing. */
+	MREMAP_SHRINK,		/* old_len > new_len. */
+	MREMAP_EXPAND,		/* old_len < new_len. */
+};
+
+/*
+ * Describes a VMA mremap() operation and is threaded throughout it.
+ *
+ * Any of the fields may be mutated by the operation, however these values will
+ * always accurately reflect the remap (for instance, we may adjust lengths and
+ * delta to account for hugetlb alignment).
+ */
+struct vma_remap_struct {
+	/* User-provided state. */
+	unsigned long addr;	/* User-specified address from which we remap. */
+	unsigned long old_len;	/* Length of range being remapped. */
+	unsigned long new_len;	/* Desired new length of mapping. */
+	unsigned long flags;	/* user-specified MREMAP_* flags. */
+	unsigned long new_addr;	/* Optionally, desired new address. */
+
+	/* uffd state. */
+	struct vm_userfaultfd_ctx *uf;
+	struct list_head *uf_unmap_early;
+	struct list_head *uf_unmap;
+
+	/* VMA state, determined in do_mremap(). */
+	struct vm_area_struct *vma;
+
+	/* Internal state, determined in do_mremap(). */
+	unsigned long delta;		/* Absolute delta of old_len,new_len. */
+	bool mlocked;			/* Was the VMA mlock()'d? */
+	enum mremap_type remap_type;	/* expand, shrink, etc. */
+	bool mmap_locked;		/* Is mm currently write-locked? */
+};
+
 static pud_t *get_old_pud(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
@@ -693,10 +731,95 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 	return len + old_addr - old_end;	/* how much done */
 }
 
+/* Set vrm->delta to the difference in VMA size specified by user. */
+static void vrm_set_delta(struct vma_remap_struct *vrm)
+{
+	vrm->delta = abs_diff(vrm->old_len, vrm->new_len);
+}
+
+/* Determine what kind of remap this is - shrink, expand or no resize at all. */
+static enum mremap_type vrm_remap_type(struct vma_remap_struct *vrm)
+{
+	if (vrm->delta == 0)
+		return MREMAP_NO_RESIZE;
+
+	if (vrm->old_len > vrm->new_len)
+		return MREMAP_SHRINK;
+
+	return MREMAP_EXPAND;
+}
+
+/*
+ * When moving a VMA to vrm->new_adr, does this result in the new and old VMAs
+ * overlapping?
+ */
+static bool vrm_overlaps(struct vma_remap_struct *vrm)
+{
+	unsigned long start_old = vrm->addr;
+	unsigned long start_new = vrm->new_addr;
+	unsigned long end_old = vrm->addr + vrm->old_len;
+	unsigned long end_new = vrm->new_addr + vrm->new_len;
+
+	/*
+	 * start_old    end_old
+	 *     |-----------|
+	 *     |           |
+	 *     |-----------|
+	 *             |-------------|
+	 *             |             |
+	 *             |-------------|
+	 *         start_new      end_new
+	 */
+	if (end_old > start_new && end_new > start_old)
+		return true;
+
+	return false;
+}
+
+/* Do the mremap() flags require that the new_addr parameter be specified? */
+static bool vrm_implies_new_addr(struct vma_remap_struct *vrm)
+{
+	return vrm->flags & (MREMAP_FIXED | MREMAP_DONTUNMAP);
+}
+
+/*
+ * Find an unmapped area for the requested vrm->new_addr.
+ *
+ * If MREMAP_FIXED then this is equivalent to a MAP_FIXED mmap() call. If only
+ * MREMAP_DONTUNMAP is set, then this is equivalent to providing a hint to
+ * mmap(), otherwise this is equivalent to mmap() specifying a NULL address.
+ *
+ * Returns 0 on success (with vrm->new_addr updated), or an error code upon
+ * failure.
+ */
+static unsigned long vrm_set_new_addr(struct vma_remap_struct *vrm)
+{
+	struct vm_area_struct *vma = vrm->vma;
+	unsigned long map_flags = 0;
+	/* Page Offset _into_ the VMA. */
+	pgoff_t internal_pgoff = (vrm->addr - vma->vm_start) >> PAGE_SHIFT;
+	pgoff_t pgoff = vma->vm_pgoff + internal_pgoff;
+	unsigned long new_addr = vrm_implies_new_addr(vrm) ? vrm->new_addr : 0;
+	unsigned long res;
+
+	if (vrm->flags & MREMAP_FIXED)
+		map_flags |= MAP_FIXED;
+	if (vma->vm_flags & VM_MAYSHARE)
+		map_flags |= MAP_SHARED;
+
+	res = get_unmapped_area(vma->vm_file, new_addr, vrm->new_len, pgoff,
+				map_flags);
+	if (IS_ERR_VALUE(res))
+		return res;
+
+	vrm->new_addr = res;
+	return 0;
+}
+
 static unsigned long move_vma(struct vm_area_struct *vma,
 		unsigned long old_addr, unsigned long old_len,
 		unsigned long new_len, unsigned long new_addr,
-		bool *locked, unsigned long flags,
+		bool *mlocked, unsigned long flags,
 		struct vm_userfaultfd_ctx *uf, struct list_head *uf_unmap)
 {
 	long to_account = new_len - old_len;
@@ -837,7 +960,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 
 	if (vm_flags & VM_LOCKED) {
 		mm->locked_vm += new_len >> PAGE_SHIFT;
-		*locked = true;
+		*mlocked = true;
 	}
 
 	mm->hiwater_vm = hiwater_vm;
@@ -860,18 +983,15 @@ static unsigned long move_vma(struct vm_area_struct *vma,
  * resize_is_valid() - Ensure the vma can be resized to the new length at the give
  * address.
  *
- * @vma: The vma to resize
- * @addr: The old address
- * @old_len: The current size
- * @new_len: The desired size
- * @flags: The vma flags
- *
  * Return 0 on success, error otherwise.
  */
-static int resize_is_valid(struct vm_area_struct *vma, unsigned long addr,
-	unsigned long old_len, unsigned long new_len, unsigned long flags)
+static int resize_is_valid(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma = vrm->vma;
+	unsigned long addr = vrm->addr;
+	unsigned long old_len = vrm->old_len;
+	unsigned long new_len = vrm->new_len;
 	unsigned long pgoff;
 
 	/*
@@ -883,11 +1003,12 @@ static int resize_is_valid(struct vm_area_struct *vma, unsigned long addr,
 	 * behavior.  As a result, fail such attempts.
 	 */
 	if (!old_len && !(vma->vm_flags & (VM_SHARED | VM_MAYSHARE))) {
-		pr_warn_once("%s (%d): attempted to duplicate a private mapping with mremap.  This is not supported.\n", current->comm, current->pid);
+		pr_warn_once("%s (%d): attempted to duplicate a private mapping with mremap.  This is not supported.\n",
+			     current->comm, current->pid);
 		return -EINVAL;
 	}
 
-	if ((flags & MREMAP_DONTUNMAP) &&
+	if ((vrm->flags & MREMAP_DONTUNMAP) &&
 			(vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
 		return -EINVAL;
 
@@ -907,99 +1028,117 @@ static int resize_is_valid(struct vm_area_struct *vma, unsigned long addr,
 	if (vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP))
 		return -EFAULT;
 
-	if (!mlock_future_ok(mm, vma->vm_flags, new_len - old_len))
+	if (!mlock_future_ok(mm, vma->vm_flags, vrm->delta))
 		return -EAGAIN;
 
-	if (!may_expand_vm(mm, vma->vm_flags,
-				(new_len - old_len) >> PAGE_SHIFT))
+	if (!may_expand_vm(mm, vma->vm_flags, vrm->delta >> PAGE_SHIFT))
 		return -ENOMEM;
 
 	return 0;
 }
 
 /*
- * mremap_to() - remap a vma to a new location
- * @addr: The old address
- * @old_len: The old size
- * @new_addr: The target address
- * @new_len: The new size
- * @locked: If the returned vma is locked (VM_LOCKED)
- * @flags: the mremap flags
- * @uf: The mremap userfaultfd context
- * @uf_unmap_early: The userfaultfd unmap early context
- * @uf_unmap: The userfaultfd unmap context
+ * The user has requested that the VMA be shrunk (i.e., old_len > new_len), so
+ * execute this, optionally dropping the mmap lock when we do so.
  *
+ * In both cases this invalidates the VMA, however if we don't drop the lock,
+ * then load the correct VMA into vrm->vma afterwards.
+ */
+static unsigned long shrink_vma(struct vma_remap_struct *vrm,
+				bool drop_lock)
+{
+	struct mm_struct *mm = current->mm;
+	unsigned long unmap_start = vrm->addr + vrm->new_len;
+	unsigned long unmap_bytes = vrm->delta;
+	unsigned long res;
+	VMA_ITERATOR(vmi, mm, unmap_start);
+
+	VM_BUG_ON(vrm->remap_type != MREMAP_SHRINK);
+
+	res = do_vmi_munmap(&vmi, mm, unmap_start, unmap_bytes,
+			    vrm->uf_unmap, drop_lock);
+	vrm->vma = NULL; /* Invalidated. */
+	if (res)
+		return res;
+
+	/*
+	 * If we've not dropped the lock, then we should reload the VMA to
+	 * replace the invalidated VMA with the one that may have now been
+	 * split.
+	 */
+	if (drop_lock)
+		vrm->mmap_locked = false;
+	else
+		vrm->vma = vma_lookup(mm, vrm->addr);
+
+	return 0;
+}
+
+/*
+ * mremap_to() - remap a vma to a new location.
  * Returns: The new address of the vma or an error.
  */
-static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
-		unsigned long new_addr, unsigned long new_len, bool *locked,
-		unsigned long flags, struct vm_userfaultfd_ctx *uf,
-		struct list_head *uf_unmap_early,
-		struct list_head *uf_unmap)
+static unsigned long mremap_to(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-	unsigned long ret;
-	unsigned long map_flags = 0;
+	unsigned long err;
 
 	/* Is the new length or address silly? */
-	if (new_len > TASK_SIZE || new_addr > TASK_SIZE - new_len)
+	if (vrm->new_len > TASK_SIZE ||
+	    vrm->new_addr > TASK_SIZE - vrm->new_len)
 		return -EINVAL;
 
-	/* Ensure the old/new locations do not overlap. */
-	if (addr + old_len > new_addr && new_addr + new_len > addr)
+	if (vrm_overlaps(vrm))
 		return -EINVAL;
 
-	if (flags & MREMAP_FIXED) {
+	if (vrm->flags & MREMAP_FIXED) {
 		/*
 		 * In mremap_to().
 		 * VMA is moved to dst address, and munmap dst first.
 		 * do_munmap will check if dst is sealed.
 		 */
-		ret = do_munmap(mm, new_addr, new_len, uf_unmap_early);
-		if (ret)
-			return ret;
-	}
+		err = do_munmap(mm, vrm->new_addr, vrm->new_len,
+				vrm->uf_unmap_early);
+		vrm->vma = NULL; /* Invalidated. */
+		if (err)
+			return err;
 
-	if (old_len > new_len) {
-		ret = do_munmap(mm, addr+new_len, old_len - new_len, uf_unmap);
-		if (ret)
-			return ret;
-		old_len = new_len;
+		/*
+		 * If we remap a portion of a VMA elsewhere in the same VMA,
+		 * this can invalidate the old VMA. Reset.
+		 */
+		vrm->vma = vma_lookup(mm, vrm->addr);
 	}
 
-	vma = vma_lookup(mm, addr);
-	if (!vma)
-		return -EFAULT;
-
-	ret = resize_is_valid(vma, addr, old_len, new_len, flags);
-	if (ret)
-		return ret;
+	if (vrm->remap_type == MREMAP_SHRINK) {
+		err = shrink_vma(vrm, /* drop_lock= */false);
+		if (err)
+			return err;
 
-	/* MREMAP_DONTUNMAP expands by old_len since old_len == new_len */
-	if (flags & MREMAP_DONTUNMAP &&
-		!may_expand_vm(mm, vma->vm_flags, old_len >> PAGE_SHIFT)) {
-		return -ENOMEM;
+		/* Set up for the move now shrink has been executed. */
+		vrm->old_len = vrm->new_len;
 	}
 
-	if (flags & MREMAP_FIXED)
-		map_flags |= MAP_FIXED;
+	err = resize_is_valid(vrm);
+	if (err)
+		return err;
 
-	if (vma->vm_flags & VM_MAYSHARE)
-		map_flags |= MAP_SHARED;
+	/* MREMAP_DONTUNMAP expands by old_len since old_len == new_len */
+	if (vrm->flags & MREMAP_DONTUNMAP) {
+		vm_flags_t vm_flags = vrm->vma->vm_flags;
+		unsigned long pages = vrm->old_len >> PAGE_SHIFT;
 
-	ret = get_unmapped_area(vma->vm_file, new_addr, new_len, vma->vm_pgoff +
-				((addr - vma->vm_start) >> PAGE_SHIFT),
-				map_flags);
-	if (IS_ERR_VALUE(ret))
-		return ret;
+		if (!may_expand_vm(mm, vm_flags, pages))
+			return -ENOMEM;
+	}
 
-	/* We got a new mapping */
-	if (!(flags & MREMAP_FIXED))
-		new_addr = ret;
+	err = vrm_set_new_addr(vrm);
+	if (err)
+		return err;
 
-	return move_vma(vma, addr, old_len, new_len, new_addr, locked, flags,
-			uf, uf_unmap);
+	return move_vma(vrm->vma, vrm->addr, vrm->old_len, vrm->new_len,
+			vrm->new_addr, &vrm->mlocked, vrm->flags,
+			vrm->uf, vrm->uf_unmap);
 }
 
 static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
@@ -1016,22 +1155,33 @@ static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
 	return 1;
 }
 
-/* Do the mremap() flags require that the new_addr parameter be specified? */
-static bool implies_new_addr(unsigned long flags)
+/* Determine whether we are actually able to execute an in-place expansion. */
+static bool vrm_can_expand_in_place(struct vma_remap_struct *vrm)
 {
-	return flags & (MREMAP_FIXED | MREMAP_DONTUNMAP);
+	/* Number of bytes from vrm->addr to end of VMA. */
+	unsigned long suffix_bytes = vrm->vma->vm_end - vrm->addr;
+
+	/* If end of range aligns to end of VMA, we can just expand in-place. */
+	if (suffix_bytes != vrm->old_len)
+		return false;
+
+	/* Check whether this is feasible. */
+	if (!vma_expandable(vrm->vma, vrm->delta))
+		return false;
+
+	return true;
 }
 
 /*
  * Are the parameters passed to mremap() valid? If so return 0, otherwise return
  * error.
  */
-static unsigned long check_mremap_params(unsigned long addr,
-					 unsigned long flags,
-					 unsigned long old_len,
-					 unsigned long new_len,
-					 unsigned long new_addr)
+static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
+
 {
+	unsigned long addr = vrm->addr;
+	unsigned long flags = vrm->flags;
+
 	/* Ensure no unexpected flag values. */
 	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP))
 		return -EINVAL;
@@ -1045,15 +1195,15 @@ static unsigned long check_mremap_params(unsigned long addr,
 	 * for DOS-emu "duplicate shm area" thing. But
 	 * a zero new-len is nonsensical.
 	 */
-	if (!PAGE_ALIGN(new_len))
+	if (!PAGE_ALIGN(vrm->new_len))
 		return -EINVAL;
 
 	/* Remainder of checks are for cases with specific new_addr. */
-	if (!implies_new_addr(flags))
+	if (!vrm_implies_new_addr(vrm))
 		return 0;
 
 	/* The new address must be page-aligned. */
-	if (offset_in_page(new_addr))
+	if (offset_in_page(vrm->new_addr))
 		return -EINVAL;
 
 	/* A fixed address implies a move. */
@@ -1061,7 +1211,7 @@ static unsigned long check_mremap_params(unsigned long addr,
 		return -EINVAL;
 
 	/* MREMAP_DONTUNMAP does not allow resizing in the process. */
-	if (flags & MREMAP_DONTUNMAP && old_len != new_len)
+	if (flags & MREMAP_DONTUNMAP && vrm->old_len != vrm->new_len)
 		return -EINVAL;
 
 	/*
@@ -1090,11 +1240,11 @@ static unsigned long check_mremap_params(unsigned long addr,
  * If we discover the VMA is locked, update mm_struct statistics accordingly and
  * indicate so to the caller.
  */
-static unsigned long expand_vma_inplace(struct vm_area_struct *vma,
-					unsigned long delta, bool *locked)
+static unsigned long expand_vma_in_place(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
-	long pages = delta >> PAGE_SHIFT;
+	long pages = vrm->delta >> PAGE_SHIFT;
+	struct vm_area_struct *vma = vrm->vma;
 	VMA_ITERATOR(vmi, mm, vma->vm_end);
 	long charged = 0;
 
@@ -1114,7 +1264,7 @@ static unsigned long expand_vma_inplace(struct vm_area_struct *vma,
 	 * adjacent to the expanded vma and otherwise
 	 * compatible.
 	 */
-	vma = vma_merge_extend(&vmi, vma, delta);
+	vma = vrm->vma = vma_merge_extend(&vmi, vma, vrm->delta);
 	if (!vma) {
 		vm_unacct_memory(charged);
 		return -ENOMEM;
@@ -1123,42 +1273,34 @@ static unsigned long expand_vma_inplace(struct vm_area_struct *vma,
 	vm_stat_account(mm, vma->vm_flags, pages);
 	if (vma->vm_flags & VM_LOCKED) {
 		mm->locked_vm += pages;
-		*locked = true;
+		vrm->mlocked = true;
 	}
 
 	return 0;
 }
 
-static bool align_hugetlb(struct vm_area_struct *vma,
-			  unsigned long addr,
-			  unsigned long new_addr,
-			  unsigned long *old_len_ptr,
-			  unsigned long *new_len_ptr,
-			  unsigned long *delta_ptr)
+static bool align_hugetlb(struct vma_remap_struct *vrm)
 {
-	unsigned long old_len = *old_len_ptr;
-	unsigned long new_len = *new_len_ptr;
-	struct hstate *h __maybe_unused = hstate_vma(vma);
+	struct hstate *h __maybe_unused = hstate_vma(vrm->vma);
 
-	old_len = ALIGN(old_len, huge_page_size(h));
-	new_len = ALIGN(new_len, huge_page_size(h));
+	vrm->old_len = ALIGN(vrm->old_len, huge_page_size(h));
+	vrm->new_len = ALIGN(vrm->new_len, huge_page_size(h));
 
 	/* addrs must be huge page aligned */
-	if (addr & ~huge_page_mask(h))
+	if (vrm->addr & ~huge_page_mask(h))
 		return false;
-	if (new_addr & ~huge_page_mask(h))
+	if (vrm->new_addr & ~huge_page_mask(h))
 		return false;
 
 	/*
 	 * Don't allow remap expansion, because the underlying hugetlb
 	 * reservation is not yet capable to handle split reservation.
 	 */
-	if (new_len > old_len)
+	if (vrm->new_len > vrm->old_len)
 		return false;
 
-	*old_len_ptr = old_len;
-	*new_len_ptr = new_len;
-	*delta_ptr = abs_diff(old_len, new_len);
+	vrm_set_delta(vrm);
+
 	return true;
 }
 
@@ -1169,19 +1311,16 @@ static bool align_hugetlb(struct vm_area_struct *vma,
  * Try to do so in-place, if this fails, then move the VMA to a new location to
  * action the change.
  */
-static unsigned long expand_vma(struct vm_area_struct *vma,
-				unsigned long addr, unsigned long old_len,
-				unsigned long new_len, unsigned long flags,
-				bool *locked_ptr, unsigned long *new_addr_ptr,
-				struct vm_userfaultfd_ctx *uf_ptr,
-				struct list_head *uf_unmap_ptr)
+static unsigned long expand_vma(struct vma_remap_struct *vrm)
 {
 	unsigned long err;
-	unsigned long map_flags;
-	unsigned long new_addr; /* We ignore any user-supplied one. */
-	pgoff_t pgoff;
+	struct vm_area_struct *vma = vrm->vma;
+	unsigned long addr = vrm->addr;
+	unsigned long old_len = vrm->old_len;
+	unsigned long new_len = vrm->new_len;
+	unsigned long flags = vrm->flags;
 
-	err = resize_is_valid(vma, addr, old_len, new_len, flags);
+	err = resize_is_valid(vrm);
 	if (err)
 		return err;
 
@@ -1189,10 +1328,9 @@ static unsigned long expand_vma(struct vm_area_struct *vma,
 	 * [addr, old_len) spans precisely to the end of the VMA, so try to
 	 * expand it in-place.
 	 */
-	if (old_len == vma->vm_end - addr &&
-	    vma_expandable(vma, new_len - old_len)) {
-		err = expand_vma_inplace(vma, new_len - old_len, locked_ptr);
-		if (IS_ERR_VALUE(err))
+	if (vrm_can_expand_in_place(vrm)) {
+		err = expand_vma_in_place(vrm);
+		if (err)
 			return err;
 
 		/*
@@ -1200,8 +1338,8 @@ static unsigned long expand_vma(struct vm_area_struct *vma,
 		 * satisfy the expectation that mlock()'ing a VMA maintains all
 		 * of its pages in memory.
 		 */
-		if (*locked_ptr)
-			*new_addr_ptr = addr;
+		if (vrm->mlocked)
+			vrm->new_addr = addr;
 
 		/* OK we're done! */
 		return addr;
@@ -1217,62 +1355,67 @@ static unsigned long expand_vma(struct vm_area_struct *vma,
 		return -ENOMEM;
 
 	/* Find a new location to move the VMA to. */
-	map_flags = (vma->vm_flags & VM_MAYSHARE) ? MAP_SHARED : 0;
-	pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
-	new_addr = get_unmapped_area(vma->vm_file, 0, new_len, pgoff, map_flags);
-	if (IS_ERR_VALUE(new_addr))
-		return new_addr;
-	*new_addr_ptr = new_addr;
+	err = vrm_set_new_addr(vrm);
+	if (err)
+		return err;
 
-	return move_vma(vma, addr, old_len, new_len, new_addr,
-			locked_ptr, flags, uf_ptr, uf_unmap_ptr);
+	return move_vma(vma, addr, old_len, new_len, vrm->new_addr,
+			&vrm->mlocked, flags, vrm->uf, vrm->uf_unmap);
 }
 
 /*
- * Expand (or shrink) an existing mapping, potentially moving it at the
- * same time (controlled by the MREMAP_MAYMOVE flag and available VM space)
- *
- * MREMAP_FIXED option added 5-Dec-1999 by Benjamin LaHaise
- * This option implies MREMAP_MAYMOVE.
+ * Attempt to resize the VMA in-place, if we cannot, then move the VMA to the
+ * first available address to perform the operation.
  */
-SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
-		unsigned long, new_len, unsigned long, flags,
-		unsigned long, new_addr)
+static unsigned long mremap_at(struct vma_remap_struct *vrm)
+{
+	unsigned long res;
+
+	switch (vrm->remap_type) {
+	case MREMAP_INVALID:
+		break;
+	case MREMAP_NO_RESIZE:
+		/* NO-OP CASE - resizing to the same size. */
+		return vrm->addr;
+	case MREMAP_SHRINK:
+		/*
+		 * SHRINK CASE. Can always be done in-place.
+		 *
+		 * Simply unmap the shrunken portion of the VMA. This does all
+		 * the needed commit accounting, and we indicate that the mmap
+		 * lock should be dropped.
+		 */
+		res = shrink_vma(vrm, /* drop_lock= */true);
+		if (res)
+			return res;
+
+		return vrm->addr;
+	case MREMAP_EXPAND:
+		return expand_vma(vrm);
+	}
+
+	BUG();
+}
+
+static unsigned long do_mremap(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	unsigned long ret;
-	unsigned long delta;
-	bool locked = false;
-	struct vm_userfaultfd_ctx uf = NULL_VM_UFFD_CTX;
-	LIST_HEAD(uf_unmap_early);
-	LIST_HEAD(uf_unmap);
 
-	/*
-	 * There is a deliberate asymmetry here: we strip the pointer tag
-	 * from the old address but leave the new address alone. This is
-	 * for consistency with mmap(), where we prevent the creation of
-	 * aliasing mappings in userspace by leaving the tag bits of the
-	 * mapping address intact. A non-zero tag will cause the subsequent
-	 * range checks to reject the address as invalid.
-	 *
-	 * See Documentation/arch/arm64/tagged-address-abi.rst for more
-	 * information.
-	 */
-	addr = untagged_addr(addr);
-
-	ret = check_mremap_params(addr, flags, old_len, new_len, new_addr);
+	ret = check_mremap_params(vrm);
 	if (ret)
 		return ret;
 
-	old_len = PAGE_ALIGN(old_len);
-	new_len = PAGE_ALIGN(new_len);
-	delta = abs_diff(old_len, new_len);
+	vrm->old_len = PAGE_ALIGN(vrm->old_len);
+	vrm->new_len = PAGE_ALIGN(vrm->new_len);
+	vrm_set_delta(vrm);
 
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
+	vrm->mmap_locked = true;
 
-	vma = vma_lookup(mm, addr);
+	vma = vrm->vma = vma_lookup(mm, vrm->addr);
 	if (!vma) {
 		ret = -EFAULT;
 		goto out;
@@ -1285,62 +1428,70 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	}
 
 	/* Align to hugetlb page size, if required. */
-	if (is_vm_hugetlb_page(vma) &&
-	    !align_hugetlb(vma, addr, new_addr, &old_len, &new_len, &delta)) {
+	if (is_vm_hugetlb_page(vma) && !align_hugetlb(vrm)) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	/* Are we RELOCATING the VMA to a SPECIFIC address? */
-	if (implies_new_addr(flags)) {
-		ret = mremap_to(addr, old_len, new_addr, new_len,
-				&locked, flags, &uf, &uf_unmap_early,
-				&uf_unmap);
-		goto out;
-	}
-
-	/*
-	 * From here on in we are only RESIZING the VMA, attempting to do so
-	 * in-place, moving the VMA if we cannot.
-	 */
+	vrm->remap_type = vrm_remap_type(vrm);
 
-	/* NO-OP CASE - resizing to the same size. */
-	if (new_len == old_len) {
-		ret = addr;
-		goto out;
-	}
+	/* Actually execute mremap. */
+	ret = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
 
-	/* SHRINK CASE. Can always be done in-place. */
-	if (new_len < old_len) {
-		VMA_ITERATOR(vmi, mm, addr + new_len);
+out:
+	if (vrm->mmap_locked) {
+		mmap_write_unlock(mm);
+		vrm->mmap_locked = false;
 
-		/*
-		 * Simply unmap the shrunken portion of the VMA. This does all
-		 * the needed commit accounting, unlocking the mmap lock.
-		 */
-		ret = do_vmi_munmap(&vmi, mm, addr + new_len, delta,
-				    &uf_unmap, true);
-		if (ret)
-			goto out;
-
-		/* We succeeded, mmap lock released for us. */
-		ret = addr;
-		goto out_unlocked;
+		if (!offset_in_page(ret) && vrm->mlocked && vrm->new_len > vrm->old_len)
+			mm_populate(vrm->new_addr + vrm->old_len, vrm->delta);
 	}
 
-	/* EXPAND case. We try to do in-place, if we can't, then we move it. */
-	ret = expand_vma(vma, addr, old_len, new_len, flags, &locked, &new_addr,
-			 &uf, &uf_unmap);
+	userfaultfd_unmap_complete(mm, vrm->uf_unmap_early);
+	mremap_userfaultfd_complete(vrm->uf, vrm->addr, ret, vrm->old_len);
+	userfaultfd_unmap_complete(mm, vrm->uf_unmap);
 
-out:
-	if (offset_in_page(ret))
-		locked = false;
-	mmap_write_unlock(mm);
-	if (locked && new_len > old_len)
-		mm_populate(new_addr + old_len, delta);
-out_unlocked:
-	userfaultfd_unmap_complete(mm, &uf_unmap_early);
-	mremap_userfaultfd_complete(&uf, addr, ret, old_len);
-	userfaultfd_unmap_complete(mm, &uf_unmap);
 	return ret;
 }
+
+/*
+ * Expand (or shrink) an existing mapping, potentially moving it at the
+ * same time (controlled by the MREMAP_MAYMOVE flag and available VM space)
+ *
+ * MREMAP_FIXED option added 5-Dec-1999 by Benjamin LaHaise
+ * This option implies MREMAP_MAYMOVE.
+ */
+SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
+		unsigned long, new_len, unsigned long, flags,
+		unsigned long, new_addr)
+{
+	struct vm_userfaultfd_ctx uf = NULL_VM_UFFD_CTX;
+	LIST_HEAD(uf_unmap_early);
+	LIST_HEAD(uf_unmap);
+	/*
+	 * There is a deliberate asymmetry here: we strip the pointer tag
+	 * from the old address but leave the new address alone. This is
+	 * for consistency with mmap(), where we prevent the creation of
+	 * aliasing mappings in userspace by leaving the tag bits of the
+	 * mapping address intact. A non-zero tag will cause the subsequent
+	 * range checks to reject the address as invalid.
+	 *
+	 * See Documentation/arch/arm64/tagged-address-abi.rst for more
+	 * information.
+	 */
+	struct vma_remap_struct vrm = {
+		.addr = untagged_addr(addr),
+		.old_len = old_len,
+		.new_len = new_len,
+		.flags = flags,
+		.new_addr = new_addr,
+
+		.uf = &uf,
+		.uf_unmap_early = &uf_unmap_early,
+		.uf_unmap = &uf_unmap,
+
+		.remap_type = MREMAP_INVALID, /* We set later. */
+	};
+
+	return do_mremap(&vrm);
+}
-- 
2.48.1


