Return-Path: <linux-kernel+bounces-378803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9449AD5A0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC01BB22196
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C1D1E2607;
	Wed, 23 Oct 2024 20:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ab7rGpCW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="geJxMFBR"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253581E7C28
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 20:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715954; cv=fail; b=VpDlepvPLaxoSzpjCzO4uSbcN1kqjDI4pL5pk6L2o8D5eOeAt2AQMijvS5Sj0GPdAwN5xwTeVqeQ9K6GgSnxo0yyc0iisfOqHZ7wxoOC4iZ6ZF/6JZA3d9cVRLK4n/loHnw0F6H6FiJHBYE990hTVF5/YW2zuQVLab23exbnXlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715954; c=relaxed/simple;
	bh=0AtljQsUjyNvv7nmAyLP3+47OrwaqkiAmdVw9my8rbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GtnU4MLxZ40QwKKITRosoMh9PwBQdUEMuEqdnOTSZ9UUwD2dZXBG9aWcQMhTlLrams/HeZGh7wttal1UkdBBSKgaewXo10JBoBaIdbTMeAWIZrsnyWDHwQ5v9GoUHgw5Lo+EfZgHD8SqD8TRnKUAb6lAZMXj1omOeJAME6ZBcR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ab7rGpCW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=geJxMFBR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NKcZKS025393;
	Wed, 23 Oct 2024 20:39:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=isYXjEUHVJpnaUR/SKlmRO3SkZ58UHRLRDJ+bIB+HNg=; b=
	Ab7rGpCWlni6wz5UCHnIpmQGIT2Lc5L7WvQBXZhlk22Bk2Gb0ib5YhY557RbXpTU
	muZuPIJr64Bwnq+eN9bFHci6b9ZM3/FWVGj5UbgljPoH69ePxhATc7ZLP6+OxkvY
	j2XlUJ1y8JWy2qfxi4UnwRpfIibGkRsDuEj9wNIqz0dgvwzQf8SlbnbrP3FtHRWc
	aMPtTKnZ0LUBaDecWzn+ENwO+QkLFetXQTsp90eC+p09pKxRF7amLNS1Z1BwQi/O
	jD45y8n6kq5yxH8UYJMkP/RVS4M0f3rBoYR5Kozg/F+cGzRm7+yQnXcLASSfW6g4
	2y2tkXK+PaenWgsvebublA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c57qh5ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 20:39:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NJUVje039523;
	Wed, 23 Oct 2024 20:39:00 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhbj44w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 20:38:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2bBUG09nj28x37rNkTfmaziMfGAxuLy0e+ffwaG6sv7WIfxqhH1HkpsfsqHhksRf3iej3mjAzi35d6aanOr2ojSY+kqU2IivzwyaU7pNE3pV1UyKbNutLF9qMCBGisG1cSuZGKg44HlkGy02VSUr9BAD1zS61+DA9l/Dob8hZgrkgTjClvpgwHiYV1K8vWgGQx0HVVszrve8giSvO7Ae6Dc0oJkpfaoXLaa1YoWAL3GXmxUJLYbiEOJQYkXGIxMdN67n0cb5cKzd+WyezjD8ca01ibZRffRjh9rHAFPPdVkbiiQ1tKavgXzrJHdIOLnLI+zJpoUQ2A4yVmqlVMWgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isYXjEUHVJpnaUR/SKlmRO3SkZ58UHRLRDJ+bIB+HNg=;
 b=l+/IrsnWzOSAvwLGlhBR32DHcceENHoFnfo1jKIXlZ4c+kwDRe+4WoDtDElOz+3EXwTXIMaNSWTT9tRbOR9wn4Q3yAk1kvyUNb3h1ufvJVz85mrdegkV6uwMq0oEhlMoQMlNrTLpo08imDma6sgub3mApOj2frpTIRwCrJ3O1ByapN4URWt0FoaZAMbQQ7wsi37KQd8U+/uJuI2ByRRzHeMeNP7WLDhDGkHTmPzFRyLm9imFlYc19HQDJWPsPz5B1Jg+tghraKQT+LwHDUegmJe0+13lDoh37t8/4BDwghimuO/ElRiqZaJEZvwLhHa683yJDSiB+GU/fOspuEiOaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isYXjEUHVJpnaUR/SKlmRO3SkZ58UHRLRDJ+bIB+HNg=;
 b=geJxMFBRfc2bgwob1tvBUEdI29x02RnKDAJj4nQOntFb5m7StU+yWM7TygScCfl72nwXGv6ftGYKouwij/cWpdl8CdrtNJ43Aj9SNtyygUwC/xPcylMnY123pYJwUEdqF/+vT6HZFvg0mjHE6U3f2TltfZfpC1Qo2EuYgEfJImU=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB5833.namprd10.prod.outlook.com (2603:10b6:a03:3ed::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 20:38:57 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 20:38:57 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH hotfix 6.12 v2 2/8] mm: unconditionally close VMAs on error
Date: Wed, 23 Oct 2024 21:38:27 +0100
Message-ID: <72a81a6fb997508db644313a5fdf4d239f620da6.1729715266.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729715266.git.lorenzo.stoakes@oracle.com>
References: <cover.1729715266.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0028.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::15) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: 35cb7490-a50d-4333-26c7-08dcf3a2b767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YAEl1lPPiYImrNxjt+zyAmv1NiHnF0PHzrzNgteahTq6cb54YpKIdepOsTG1?=
 =?us-ascii?Q?ioI38ltRS3mULSbid+9iHoIAheTMF6G7eLojlWct0NsI3xx3AF+YDoG72xT6?=
 =?us-ascii?Q?WiJU+SPLZ63yRLCJYFSV/J44BmAiVqdxnRr986bEs4sY0xFk04Axj0pFIFtF?=
 =?us-ascii?Q?SmDAMX19kwb4pRdf4fyB4tOF8U/CG7ORem4acEMNySD5yN4M2OvTScRb7NdK?=
 =?us-ascii?Q?4kxnROBvrKlV01A5vnJk14Py3l72WvXlEk2JYHCE3wrNTPM9B3gTahWyNTEi?=
 =?us-ascii?Q?+S1n3SY28fDGoso4ReTf6qccZXq63dn6lP6W4gv/+sY+beMFqxucLmfs0AFn?=
 =?us-ascii?Q?RNow6z2VXfpXtAe4NAbk5g7Y2R4lJqASP8FWbmofezH7E/cFAq2YubMTZP7/?=
 =?us-ascii?Q?iKrB9FGZYUEbK2cfS2QHnvixKZjCN/lDwtFhoI8ZXpa38QQNyT1Z5s54sZS5?=
 =?us-ascii?Q?JPYbjyB8v3UuwvIUbbF+eZxUqe4eIZYlk+8JGgdzaAnkY+ZVspnjBVgEv7SR?=
 =?us-ascii?Q?APrngLczPukcIbmQrx9ynOhPyTYiUf5FGQKrtW2C6KU+Es1EQgZKisaEGCpS?=
 =?us-ascii?Q?Hc5abFtJO/APf/VI5qJJDOqLh2vJxGAjf5Gr5oW0tGqGSu6lBJQNuGn89wN8?=
 =?us-ascii?Q?mogAaKcTGDOiHTR5VmEO03txBnbRhvvsXWHRQKtsMXtWmqb365IRK8tDynqO?=
 =?us-ascii?Q?UzCU2Pj3+7UrPB0rW2wD2vJAoEUFywBU1a8Uo7kWmMpwZeAILCJ2gWJ2600s?=
 =?us-ascii?Q?cQdSGRC51fFQ+O0z5bcnP3GcD8JWsDyS4NWd3rJkspd1PNoFOErFITGA7e7T?=
 =?us-ascii?Q?zPg5AMIdgu8skAq2IfY1VlDy+ZQ+STXZ9YMdtTlBimzW2Ll6WX9oJVmteCCB?=
 =?us-ascii?Q?Na1QzVs+baCqEWB2xw9BxWt1vRIyrM0qKeNzmIKsZRDSl7D4EdAQZDvPIiQO?=
 =?us-ascii?Q?FJhixCkh9iwuwaYg7u18Z9NS3OYi7qMxBuknBap+XqoLShCWvZjBlsX8hNP2?=
 =?us-ascii?Q?c0AAJF372VoJ1FJyxdhPQYUhmN24rHA1pqFPt47wboEITMw3zcO9GEkt4+Ng?=
 =?us-ascii?Q?GFeWxVF79ORCUgGx1oQgmusOukhGC1Jj4sm+SuLePlwNaIJF/WTHlQqLWXGK?=
 =?us-ascii?Q?1IJM4RGfGTfN99U6vw8M2tYIZV032tkq1GpjjXHhU1CkZSzDaKUBPLvu8LCh?=
 =?us-ascii?Q?/6zzKWQTlwZORSDRM95EH6v26a+5sQUZjPfgcLoi8qu40nfoJi0b9DkZDEaY?=
 =?us-ascii?Q?+trIdOof7IAL+szQob2Hfr0iZNkm7fgaq65cNhPtSb6pE1tFfvmyaR1JJhm9?=
 =?us-ascii?Q?YUW9mIiLM+STKi/Zwoulc0Z7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sm/bshCd9g8cr+jL+Ur/LwBauj31IbvNij81H1GV4X1pSM5O9yOtm3KMO20B?=
 =?us-ascii?Q?jJzeCaVnreUbc+l9Hq+zs4IpeLXwk0b6XwGrP3vruyAHwpUj+7bkPKo9WTKy?=
 =?us-ascii?Q?njZPlryi8rF4339t1itEsEN9B3q77iw9kwn84Kf0GJdWOJ2lQjlXdIgGWrtQ?=
 =?us-ascii?Q?kAa2B6T9eYr2j1mjmCggjqdUQQUrn88EtbgGqTfQLyuAyrqeqwxNTEA06N16?=
 =?us-ascii?Q?B4gXtNFdj5eWVAaOT2X3C+71/G0PudsyUgL04ux9x9tU46EAxSWgoYn1WIIT?=
 =?us-ascii?Q?qODY04Vth40fM3ijQ41TGFXU1bAf7J1cljviVe6E5oQHUX4K9BLFtFd2hVAK?=
 =?us-ascii?Q?yNaCMK6fz75rFXCfnBmMxO4G829OttYtiCTer7+R8ljf4+BcWSeA0R0bzEZS?=
 =?us-ascii?Q?qDz7afpp6JcO10yAeJNoxISERPumL4DGQLLFQ4Bdc4Jxa/D0WWdZ2dLw7Z6t?=
 =?us-ascii?Q?pRB4H06AQIEF2Bt/pzh2yhLg/3L+d6iMmZwUCmS3uvWOlqupGb8rlmBMUlP5?=
 =?us-ascii?Q?qV5+NKkGB0SdtPhGVOYPWiR9/ZCgryzWjfgXz1OmmJ7TYeiwxVbdp1gB336f?=
 =?us-ascii?Q?mM9LCNapISLSvE9PTl25GhcuZqJZ8/z4+ocWmUMJm2xUhXI/k7WHdqA9lCqo?=
 =?us-ascii?Q?eRNRVQo41//mBrVucJDSlFv0ZIuapkcd1BCxN19FE5QGz7Zhhrjg9DYWjDdd?=
 =?us-ascii?Q?NmvzzKdyplc1JW+nbEYzpsUwAaQn1jjQA6wy4j5cE6vEp1mujVJ70+NeGY5E?=
 =?us-ascii?Q?m2JZrk9zHaKVSExctVxn+dxncHrsKmFN9d57pl3eIdehF0jajPgm44BkA+IT?=
 =?us-ascii?Q?NSVnV5TfNUmVET/U/Pxs6rKArz2HwkapQo5VqGhYiBhTag/zosPVikI6k2AB?=
 =?us-ascii?Q?FX8ipm6MW2ukzdj8p6aQOt4pc8eTAG1fAPPJI60UXAv5TOSoCr6L+zFT7bUe?=
 =?us-ascii?Q?saLIfXoNipBs8UseAZToVFtvh2QPGgjZCUxh1APeVLKgxB/dCcE1jBwamKjb?=
 =?us-ascii?Q?QummqqacWeIGPMO3s8Pm6ylonVTATncOLYCu+ZbkpF1h4P/vT6rII/RKt89H?=
 =?us-ascii?Q?klQfAAxpSmyS92duU1mqXq5z+P6sxvSlPa80saLUidHPstPNjhFd0LgSAKgB?=
 =?us-ascii?Q?WBvxLkCzGt4ZEJMvwazM0C6T0icqmdmMosArj7/ptnA/2bL4/wrqBw2WMQmW?=
 =?us-ascii?Q?hqXBs2LkMAS7iBL0WoBeFZhkK4LjAu1qgCo26PywpEWQ6bJrf//2Cs4jUEUZ?=
 =?us-ascii?Q?ARdAg4hRwRpwOZ7lfhPriGLqxYQ3EphvR1tSsqFiousPU+reFOf7k2gmPWf9?=
 =?us-ascii?Q?PSJNBzdNslxyDRogMzhEQkkfYPi/CEfBCgnNhibjUpY941n2zkGX3Cj3WCot?=
 =?us-ascii?Q?++jYq81TR9Ex1eeFJAigqjhcjXjsCY7qofZII51XTvtnRAfi9QSHHdNa9nF0?=
 =?us-ascii?Q?TLaBL4CmRo2fL1AUqZPImKBxahKs15rq1jZWfxIhgl2Jk3ilpGAygCAUEsVh?=
 =?us-ascii?Q?w79SfGatVU4jnEcBX9OaaT4UdOnhVtJlp+jRDDEeh0wH0CTqu+b9D7JqKsSD?=
 =?us-ascii?Q?H2Z0kqx1AVIuE+UekNek2Np1PVrZjdPtJN7Ozck9XVmoyL/drSs5sfpQfJi5?=
 =?us-ascii?Q?X4LiemRJEFRu5VO7rXF2U2VqTTDIcwWb8cWbOId7LqAPZRM8jDEWbYxh4nik?=
 =?us-ascii?Q?x7MyNg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sJvXq9AZbcscLgU/dpaqPmk1P9sXog6t4+B+bsosd2zPDz0/fHnMwQcZUDlHcbCxpsa4zhqMNUNbcZP3/rDIcgaYjQjwQjKZV2vheEz6YNuezWJ9+FPGcu9Ij2r3FAyIsCxiIWIyBk7Jb6a3SX5NNeEGzLu4rBBKbaIZqfbdIZrtpP0ndbW/sXzLsvXp9jbjwMUn/tvd1/+X8PtfDVLyW7FGCO1V2F/4mk0rx78841NKFdYlAOmmLoKApINDD43QHPIrldcD9mqbvajb8ZMphCtOuveb4dp2VRca3Ag+z+WVrjFsirCxaeGatPc1ktgX2X/kymObxMTN1fjNOam6JdYgjSuhJU5s0e8cdHipBzP3GSma/yaQXTWTHiankjztmhYRx9zyS+YEFg7UnNtc0ClbYgsVEHd6tFvK/PzTIMKR6cY3iJpiJWuQON+rJElhjs1WjL7frlz33MjTDMANBPKyISdZflg11GYKFIGYN85Vkp7rWB5wOi+pWj4r9RD4btNiEW4u9UONX6TudQWpY9zHUcuH1oeGol1y9xXixusWgf9ZshSMbSU8LHYmRsXF73SK0pXgBJwQCGFFT7PTnfcdep7dj4oqvp7w2bHkyjA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35cb7490-a50d-4333-26c7-08dcf3a2b767
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 20:38:56.9640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k6RfI3Q4fRgYXsv8RSxSb5/u/rKfOdXBd6jEGTI/n8lLoPG1k85wTWEXzwaO5y+TRdvL4iOlrQRXcB4AV+qPWEPaf+UHneqDzrGY7h43fnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_16,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410230132
X-Proofpoint-ORIG-GUID: 9god8jj7Mp6doCKpcF5T5EvsObyK1tZs
X-Proofpoint-GUID: 9god8jj7Mp6doCKpcF5T5EvsObyK1tZs

Incorrect invocation of VMA callbacks when the VMA is no longer in a
consistent state is bug prone and risky to perform.

With regards to the important vm_ops->close() callback We have gone to
great lengths to try to track whether or not we ought to close VMAs.

Rather than doing so and risking making a mistake somewhere, instead
unconditionally close and reset vma->vm_ops to an empty dummy operations
set with a NULL .close operator.

We introduce a new function to do so - vma_close() - and simplify existing
vms logic which tracked whether we needed to close or not.

This simplifies the logic, avoids incorrect double-calling of the .close()
callback and allows us to update error paths to simply call vma_close()
unconditionally - making VMA closure idempotent.

Reported-by: Jann Horn <jannh@google.com>
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Cc: stable <stable@kernel.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Jann Horn <jannh@google.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/internal.h | 18 ++++++++++++++++++
 mm/mmap.c     |  5 ++---
 mm/nommu.c    |  3 +--
 mm/vma.c      | 14 +++++---------
 mm/vma.h      |  4 +---
 5 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index af032e76dfd4..0c4bf09bf788 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -135,6 +135,24 @@ static inline int mmap_file(struct file *file, struct vm_area_struct *vma)
 	return err;
 }

+/*
+ * If the VMA has a close hook then close it, and since closing it might leave
+ * it in an inconsistent state which makes the use of any hooks suspect, clear
+ * them down by installing dummy empty hooks.
+ */
+static inline void vma_close(struct vm_area_struct *vma)
+{
+	if (vma->vm_ops && vma->vm_ops->close) {
+		vma->vm_ops->close(vma);
+
+		/*
+		 * The mapping is in an inconsistent state, and no further hooks
+		 * may be invoked upon it.
+		 */
+		vma->vm_ops = &vma_dummy_vm_ops;
+	}
+}
+
 #ifdef CONFIG_MMU

 /* Flags for folio_pte_batch(). */
diff --git a/mm/mmap.c b/mm/mmap.c
index 10f4ccaf491b..d55c58e99a54 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1576,8 +1576,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	return addr;

 close_and_free_vma:
-	if (file && !vms.closed_vm_ops && vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);

 	if (file || vma->vm_file) {
 unmap_and_free_vma:
@@ -1937,7 +1936,7 @@ void exit_mmap(struct mm_struct *mm)
 	do {
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted += vma_pages(vma);
-		remove_vma(vma, /* unreachable = */ true, /* closed = */ false);
+		remove_vma(vma, /* unreachable = */ true);
 		count++;
 		cond_resched();
 		vma = vma_next(&vmi);
diff --git a/mm/nommu.c b/mm/nommu.c
index f9ccc02458ec..635d028d647b 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -589,8 +589,7 @@ static int delete_vma_from_mm(struct vm_area_struct *vma)
  */
 static void delete_vma(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	if (vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	put_nommu_region(vma->vm_region);
diff --git a/mm/vma.c b/mm/vma.c
index 3c5a80876725..bb7cfa2dc282 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -323,11 +323,10 @@ static bool can_vma_merge_right(struct vma_merge_struct *vmg,
 /*
  * Close a vm structure and free it.
  */
-void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed)
+void remove_vma(struct vm_area_struct *vma, bool unreachable)
 {
 	might_sleep();
-	if (!closed && vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	mpol_put(vma_policy(vma));
@@ -1115,9 +1114,7 @@ void vms_clean_up_area(struct vma_munmap_struct *vms,
 	vms_clear_ptes(vms, mas_detach, true);
 	mas_set(mas_detach, 0);
 	mas_for_each(mas_detach, vma, ULONG_MAX)
-		if (vma->vm_ops && vma->vm_ops->close)
-			vma->vm_ops->close(vma);
-	vms->closed_vm_ops = true;
+		vma_close(vma);
 }

 /*
@@ -1160,7 +1157,7 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	/* Remove and clean up vmas */
 	mas_set(mas_detach, 0);
 	mas_for_each(mas_detach, vma, ULONG_MAX)
-		remove_vma(vma, /* = */ false, vms->closed_vm_ops);
+		remove_vma(vma, /* unreachable = */ false);

 	vm_unacct_memory(vms->nr_accounted);
 	validate_mm(mm);
@@ -1684,8 +1681,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	return new_vma;

 out_vma_link:
-	if (new_vma->vm_ops && new_vma->vm_ops->close)
-		new_vma->vm_ops->close(new_vma);
+	vma_close(new_vma);

 	if (new_vma->vm_file)
 		fput(new_vma->vm_file);
diff --git a/mm/vma.h b/mm/vma.h
index 55457cb68200..75558b5e9c8c 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -42,7 +42,6 @@ struct vma_munmap_struct {
 	int vma_count;                  /* Number of vmas that will be removed */
 	bool unlock;                    /* Unlock after the munmap */
 	bool clear_ptes;                /* If there are outstanding PTE to be cleared */
-	bool closed_vm_ops;		/* call_mmap() was encountered, so vmas may be closed */
 	/* 1 byte hole */
 	unsigned long nr_pages;         /* Number of pages being removed */
 	unsigned long locked_vm;        /* Number of locked pages */
@@ -198,7 +197,6 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 	vms->unmap_start = FIRST_USER_ADDRESS;
 	vms->unmap_end = USER_PGTABLES_CEILING;
 	vms->clear_ptes = false;
-	vms->closed_vm_ops = false;
 }
 #endif

@@ -269,7 +267,7 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 		  unsigned long start, size_t len, struct list_head *uf,
 		  bool unlock);

-void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed);
+void remove_vma(struct vm_area_struct *vma, bool unreachable);

 void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
 		struct vm_area_struct *prev, struct vm_area_struct *next);
--
2.47.0

