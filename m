Return-Path: <linux-kernel+bounces-297887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8969895BED8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A2F285A78
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458EB1D1F4A;
	Thu, 22 Aug 2024 19:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AD2fBBFm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x6Xtzvtw"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5904E1D174B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354817; cv=fail; b=g2Seu5z4ck286vlewK4uGJGWEzXQHmWoY3AYuE7ASWXgygE3he5gIRi4B1HYM/k+fbtuZpw341auVE30OE7xJmajOsRocVkAef+XYx5fUlc4zgFg+IaB+EbmwPCsDr6sHuT57RtBGfasJLQWNiuFf5YzuTmHpTQDmhcyMlY4n4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354817; c=relaxed/simple;
	bh=JeNyjEYotExh6kBf2xD9KGTbEOPrpNiT3lZeVF9sCSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fqMbLzFo2+z6h51znwul1u+os99OEBqkYdNXQELQuZyZ7MEIeQhG6qNesvjcVQna9hgkpCegDVJ5QAyRzRQRROt+ICSop+FCwO3KOBBPzLkwTuaF9vr9jFlKBsRYhfZbofRDNvpBK/fpJTDfF568UV0J1hiN83w3bTN5v5SGDGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AD2fBBFm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x6Xtzvtw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MIMVFh019167;
	Thu, 22 Aug 2024 19:26:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=VJwZMoZ9FdNzvr9ihYDV0ermmuz2Um1cqCOecEEoDKY=; b=
	AD2fBBFmmkqng7sfAsrMu663P2oGm7R2uBHkJd6vMwMa9JjYdMfptmVaNXy6Lg7k
	g0+1Tq0KiPhiOPw8Wna9jvVkikDd1mNQWPYp0uV+vyP0nZOjVCaNGxPvw/Ra70Nb
	c+UdWuCYIkB5R8uv/THzhB2zEJEIqU8wNAlkQebtJpv76QV2zgupCUrnuGMLC4gi
	RpydR6se7q9JE6RvL6XXeD9R3N/01JjzrTYODvbofUbrvLG+7KZkGW50gNQeuCKM
	GNy59oXNfaw9kK+y166UxSa8XbnKpBcpvi+a5x0iJXRmCrrGj0DjmV5SkUGRL/9k
	m0QlthpbYL1odEXW4JQlHQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m45jwaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47MJ3jJM020764;
	Thu, 22 Aug 2024 19:26:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 416b5jryjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxiuAV6Z9jHqu2F0joVZdM8b82a76/QlHAyDUxrMf1QRBS2uKp+0MIggrxGCchrGr8VZaGOWDzJNri+kQ2K3fCb6+CUXb9Q3b5v6lXXkGym3XI3wW/vf/5SMPc8Zy69p5uDkCf599FDKK6HMu+X7LVRD27PRUSt5kayIjRD2ZByTyz6qLK3BIz0Mut5sW2wwg09eejuDvJyHh7puTDjEvjDxgtkLBqelTLesHQTwdooKQGBk+mY+5zX2fi870ekkxexGDbuSa9k+sF9+lmZAfvNomv6u6/tZOImSYl/w+ETZbGP+YYZpc9xM4gTVBBk6oZfBDrBsvmPNXEkMasTeNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJwZMoZ9FdNzvr9ihYDV0ermmuz2Um1cqCOecEEoDKY=;
 b=bxaOEv+LeiqUES9/x0CKSkXjR8wpgM1B2CI3Lq1tXYTUzLH6Y7qgS5yqb44xvFSHs5xG9Eeg3NwDcXYLvwqa4X3mhpKjQFWHNbalfVJiYNB+HoiNnoc8ozVjpxySYy9BD6rsmSmnXnFYyDMiflGFIwpmxlRvYnveTIQ0fZx57AkZ542YvibxmImkjbiDjzfZshTew2lHiqFEJnoq7ow5P5bOuCLWhBkiq0UCmqY3xj2u5W/XbJ5V2MijoqkHMoYd1Y6SY/TMG6+aiEWqrkJ1yQ2t1IxnxV6HewttArLSc+yFO8lIKNAinR2n+qrVaRfKktoEnLeUMDeobTWdQJEmvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJwZMoZ9FdNzvr9ihYDV0ermmuz2Um1cqCOecEEoDKY=;
 b=x6XtzvtwPi0lPkibN+XpZz33QUnegDZ3zI+lJjZX4vRbVPXfXcX/BmuVXZ548iAwd5LjMPyO2aB4artQiaFrD+g76Gg9H357Uuxx/UYPlpb2pn4oTdDIPf6OGyBPxSedomXg34QvezQgsMfOA9CXye+Y0koK6iUVNjMV6QqPlvc=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DM6PR10MB4202.namprd10.prod.outlook.com (2603:10b6:5:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Thu, 22 Aug
 2024 19:26:40 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 19:26:40 +0000
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
Subject: [PATCH v7 16/21] mm/mmap: Use PHYS_PFN in mmap_region()
Date: Thu, 22 Aug 2024 15:25:38 -0400
Message-ID: <20240822192543.3359552-17-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
References: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0323.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::29) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DM6PR10MB4202:EE_
X-MS-Office365-Filtering-Correlation-Id: 54d1ff7e-779c-42b8-539b-08dcc2e058e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xLgfGiI8HXoCqPqlnO+DBDfgc0DSiPuioK00H/rCDbE1PGT8+V2kuI88VKNF?=
 =?us-ascii?Q?NlnfulabeyjlqZHvKnmRGmHl2Om0IKHRZlXX57K1vFbe9nktk1yWG9H6T0zF?=
 =?us-ascii?Q?qD0HQ46Fx5P7C6aUwf6/Ev39dTUtbSZlvCmnEfu4nxCcBVZsp1JsEvZ7ArJM?=
 =?us-ascii?Q?pClKc7v/w5rmk1Kle2VgXy82lH4jNZi7p0Sxi3dL2XY5uouonzmA5idulX6g?=
 =?us-ascii?Q?+uhv/4iT7fXit35CFXh8TI/0Pp8pBYEHFRh8CXTTx9VDHkdyQ4VSDE5uLt+u?=
 =?us-ascii?Q?4wuHMOerf+PqFxaTsyXRrSY/wyGW7DfnpD6j7UzdpVmvfDWj0GSaYkRnce8O?=
 =?us-ascii?Q?zuStAI4d4wGpGhIJJNBgHw/9CHXFxobpBYugQ+U/3kfKUjAj8Sw7xFXm+shS?=
 =?us-ascii?Q?Mao4pnIDb29IIdjGstQF0Z1b0imMdKtMBcJuAWkWjM6Yy9iQxHU/0DR2cend?=
 =?us-ascii?Q?XnsGTPPOY2+8zuhV3CawOSiFxc0BiNDI8dS5v1lxwDyyoU5FkVNKN75R44+R?=
 =?us-ascii?Q?YCVzgY+Cbg/Cfg0wkLlz357Ffz+J/KP4xLwGWPBowppttktKkknjD3fboQqw?=
 =?us-ascii?Q?lv9athrX7+ClsicXwBjI6MX85iYtxvVSI4cgglzbGSGtvZHYEYEILw2D0s/E?=
 =?us-ascii?Q?YOg+1GmyMgffnhXk+Zsb3BTqbASdtxBiGvoVyHBfjRK1796Tt96j2S/oIPkA?=
 =?us-ascii?Q?nXDKvGD+2y/spXSFlXUsYRJDm0hbQkKjH08MWuJ8xnsZVZ90x88ryZNRnftd?=
 =?us-ascii?Q?ADaE35eoktAuCKcjRbPpkS6SGuc6/S9Bdi+cFmNLgFVJQc8cyARKdBNVzyvR?=
 =?us-ascii?Q?Lq4DK2RXs5nnuZssr50Fcw/C8OPG0aPS+iswuHXRXgot8Ru9W4RUOYc9my1L?=
 =?us-ascii?Q?PY1Q9dOKZdxPGcI3YMtV5qAm1B/7bCGW+xBbohrcfEJqmSxqn120gxGkVUEM?=
 =?us-ascii?Q?q0qdW3/N23hC+5qJbOZqF/UiF8OVDdz5fb3GDkAPwG5b0mVJnoizE/zLdj1x?=
 =?us-ascii?Q?ldPxbXzL8HnyYysWBQeUc2z1KKJ5xTFvQVSma9kGnaJql0vahAiGN0DwwSOv?=
 =?us-ascii?Q?PhibJe0WtV50nUuiFFpxgUXp9TQ6EL2Wjs4yN8AxPqU42AdUyK/ZROD06+ST?=
 =?us-ascii?Q?eWoeEX9WEQFj89hkbqouT6oQBlH+NhlLbY7FFp+R2A1ORxr9ix+2R/wE7LZ9?=
 =?us-ascii?Q?VVXBPG5ofXkvJXT5+cgVrJ6K5Itio4Z2jVKcaikvvi1mcRv5bZt1XqaCA98V?=
 =?us-ascii?Q?ot3Mmxk6xr3ZkU5RC0vGFsch6IzyakRigHdBcuxJk/NOIRZpW3AkkNjIzo4Y?=
 =?us-ascii?Q?/oxwBOWh3FTEPms3q8b2vzQcoC+dTwMQ3eFNzduxiaV+jg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lnZKO4Qf4upTMGtahz/bMOqBqgbQvYPiYjct2O2KCsWWXzCqPcH9qqgAidqw?=
 =?us-ascii?Q?P4HgPyZh9qEUDpwwdkrgx0D196PbyuAm3tiMe9fxszzbYFnXJq4re785+W8w?=
 =?us-ascii?Q?+YfmXuloqqLkBp8WpqsM7RrInE15qLWBe2u/pbpWwsiCCTkzS3L7HprcTxsJ?=
 =?us-ascii?Q?XQ/7pVxPadSxmrYB1+EBVg5kwqM2s9TEZ/LjynXIwnzZcC96Ei0lnq5COL9G?=
 =?us-ascii?Q?Zgfi/SeHXOXqjffLcsAMxwCzdCUodaBy+7cFGJV5f3JCkjqfrATQtwSFId5m?=
 =?us-ascii?Q?Lz6ib2NxtqWd/nmkwfBMWfIZV5eVEurIWUadvOIDTkUKxPA8L58GsodecXoz?=
 =?us-ascii?Q?12thULXhJY/8q06jir0pisP4KKUg5vUlsck/T/EFOwgT+2AUX/IN/APC+UTI?=
 =?us-ascii?Q?xmIp19KaG4nxCuMeoQkbotg4TvRhkDd3EM4MP4fHLfjSErE+bTl38B2JZ58p?=
 =?us-ascii?Q?VxKDkFyw43DcOdU4CsY1h6sXfDIinwy/t2+ZC9hIrYL+4IJDx8XDIXJdLkwi?=
 =?us-ascii?Q?D2EEKwCSKOcxvmu4feFQEwCRpke+8vAzTbF9iUY0Afa9uhMsjbggSBn8rnEQ?=
 =?us-ascii?Q?6wsAP1c/Fgp0f582hYjd32oOgG0kqvKCGVaiGQdJhmCm7laLaGhqzu7KtXmQ?=
 =?us-ascii?Q?qKoAz7m8G7e5U/VxWkOiWLN54FjLX2qeKDQJwNwM2yrsFAu9nx5tPF7n8LYm?=
 =?us-ascii?Q?Yr2kAg0zi9EnjgF27T9CIdCxFAReBt9uMLIBdKzS0GUYY5wq+hnGW/W2qK1Y?=
 =?us-ascii?Q?lpzS32fM2n6f1ceCeoTryRu8GbjzRlWMlbFamNl8LMS2ONXjaW/1QSMt4yY2?=
 =?us-ascii?Q?rOZovH/GH0fW0qaI0LM6easkx8zxRH3YFduC+9YdzGMRyfRi34YqHNcUGDH/?=
 =?us-ascii?Q?TiFORQiwX2P5l+5a6cB5vHK3FTPMxZO8YsX24EextdooP0Yeefgv/T7cfsJm?=
 =?us-ascii?Q?jPa6j3kOR7Doe/1VE/7Yh8M+OLVmt2aRpQIazHLjje/kc4A0Ni8S+K1WsY4q?=
 =?us-ascii?Q?ZO4IiGtBEtNrRVDUsDTwowaNv/YgsYHMGodZhXy9FqBQ6TdnqEhDu8tpIohI?=
 =?us-ascii?Q?TDJIlbGAGSHir5FUvo6+n3I9R5syGL01NJX5K76Mb2DIu2vqYUmV12KVYUgq?=
 =?us-ascii?Q?tF6LiD4X9ppLO8e2ZFPqaxEmCCGHJ84qIXUv1BbNTS5TNhsKie/TiMtcHSLZ?=
 =?us-ascii?Q?7SV4GTMCTisqd7j60SKxpnjH2v4eqT2M4q0XpkdDEHTCGTv6r9j8suLmWLVD?=
 =?us-ascii?Q?TRQ337JQO7H8ov6oojVbFy4LUr8HZTBl756FdktAqhMRaXdWl+52VI0srFnm?=
 =?us-ascii?Q?bOQDFxNxBZlp4XTzIUalw4jFhkuYZ/r/S2YfQ5a6jcB0MM5cfMdMwoQR+JB4?=
 =?us-ascii?Q?HptOnJ/S3/jdhXnn14xODxvYIn9a/G0oZOdgwgEkTyajSzkrhHUn7/pTZe6y?=
 =?us-ascii?Q?+4PjEkXpgyGksQ3sSA4DtzwK2nfoNVsKwKnjib3hjivrrT7H+QFAitTgBHaw?=
 =?us-ascii?Q?Dp+Pt/z0nFJ9fWyUjmloL9VYwKBryXfU/KW7ExXeW2fGWmsN8/0GEYhjdh8T?=
 =?us-ascii?Q?fYH99MuTJYwp1xYO3sil+ZONsFEb5orthP6ujgibBufCnbMtbO4DWiLA8+yH?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O9LD6sxGvy6dmy+3DqyAcRVvm/B55JgORo6I+yXKtjuZse0lU5oajBKc2k4Mat8UnGoZFXwQWgkyWaDDXfrzIczBXO/mQHXIFRZCiSDbzT9QQB3n4A+rxMjB4P6RUyDsD+RwPTwdfg2RZ6QDsItyMNezAr+JJ12zo90tallIEDSdkneF1aiY5HJsQCNW7gvCHFuSWZfw2yIAKxjUnMVwVkS7lJdn9uNwsENNpSqOJWuKnOKj5jnpfriYf6hQ7qLOBeA/T7yWe3qN7Tqf1EY6wEAsXaG7Dk6wDjWvCsdlOCdYUzHoH2dkqWUAGWlr4qYFyPCSegrXO+di6zeR5on9ZL2gWF1rMQu08eSkqfKv0tWPAmvn80uTrswDf+JqBMmcjs4X7lGAbg38uKtTIZ+tW3Wl1AN1mUdivsldr8KsxNzI4cOXM5GQ353ToJ+D5UtpbIbrCKGy57l0rC6n+lXZzrbV/SVnrK00kfoXoVKLpo1dMin6MNFVWX0yB6IjxrdWJBWHbBI+ByKT0dxHoYfpRB0GG8BCMTvG6Lj7Oky7womEGek0EM7Rt93jN046aW6ZTI0+/DaO9ATt99AS0C0GwcQP+FC3FWblTjjBYMKnlKA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d1ff7e-779c-42b8-539b-08dcc2e058e4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 19:26:40.0976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eeiVupgdAwVXg/dl9xlOb5+By48MtMsPwyeBicaJlhfQAGIevCCHZ0JHrNF9xwW8Pa4z4u1pUV8GSJEQ5DO7HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4202
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_12,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408220146
X-Proofpoint-ORIG-GUID: yYUrKUJc4UnKRUsEgQc7arG_aTTZmklZ
X-Proofpoint-GUID: yYUrKUJc4UnKRUsEgQc7arG_aTTZmklZ

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Instead of shifting the length by PAGE_SIZE, use PHYS_PFN.  Also use the
existing local variable everywhere instead of some of the time.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 217da37ef71d..f8515126e435 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1364,7 +1364,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
 	struct vm_area_struct *next, *prev, *merge;
-	pgoff_t pglen = len >> PAGE_SHIFT;
+	pgoff_t pglen = PHYS_PFN(len);
 	unsigned long charged = 0;
 	struct vma_munmap_struct vms;
 	struct ma_state mas_detach;
@@ -1384,7 +1384,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 * MAP_FIXED may remove pages of mappings that intersects with requested
 	 * mapping. Account for the pages it would unmap.
 	 */
-	if (!may_expand_vm(mm, vm_flags, (len >> PAGE_SHIFT) - nr_pages))
+	if (!may_expand_vm(mm, vm_flags, pglen - nr_pages))
 		return -ENOMEM;
 
 	/* Find the first overlapping VMA */
@@ -1412,7 +1412,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 * Private writable mapping: check memory availability
 	 */
 	if (accountable_mapping(file, vm_flags)) {
-		charged = len >> PAGE_SHIFT;
+		charged = pglen;
 		charged -= nr_accounted;
 		if (security_vm_enough_memory_mm(mm, charged))
 			goto abort_munmap;
@@ -1573,14 +1573,14 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	/* Unmap any existing mapping in the area */
 	vms_complete_munmap_vmas(&vms, &mas_detach);
 
-	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
+	vm_stat_account(mm, vm_flags, pglen);
 	if (vm_flags & VM_LOCKED) {
 		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
 					is_vm_hugetlb_page(vma) ||
 					vma == get_gate_vma(current->mm))
 			vm_flags_clear(vma, VM_LOCKED_MASK);
 		else
-			mm->locked_vm += (len >> PAGE_SHIFT);
+			mm->locked_vm += pglen;
 	}
 
 	if (file)
-- 
2.43.0


