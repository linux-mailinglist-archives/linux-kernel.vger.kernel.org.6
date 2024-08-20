Return-Path: <linux-kernel+bounces-294698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A34959172
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 01:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E57D6282A5F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 23:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1181C9EBE;
	Tue, 20 Aug 2024 23:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mjDXQUAA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KXtX24xf"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09661C9EA9
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 23:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724198297; cv=fail; b=qJP6Le/jj8EoEWxtV13uWVBp7GEa++qOzQ1VSIVjV2WS1eRCJqI5oHScWjKXXyN8aGZ/C03/nwEQ3fhLcy/nSSWYxXb8VIUKW3qccu2UY1ZdD+DTB5GC5JXb6xnEr1sVCGAUnt27FQmHbkrTrtXBgHixscjIWyo5naEfcP04phY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724198297; c=relaxed/simple;
	bh=1qZ9zGRDRIBCufOoQiJCJ2wnhQuXyou8FNZA7Zns2IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g26LZvADh2C/94q/+lCY6seIGoQOF8F9D5KuyaeeUinIIfgt2W5sWYpb6QR0Hsfo4DgLpHnuUJZ/A1KTlVDqjVM5ZFvWv4QWJXWo3W5G3uonkLJOCCf2G4z5FFeXUI0plOzdxUAfogbCkpxHW1XjeETCDeYz4d5dz71feBzS+8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mjDXQUAA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KXtX24xf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KMBaE5028808;
	Tue, 20 Aug 2024 23:58:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=umj9YQLZTIAO4p/q1uoqol053BLAnZXvnRL4qkPn+G4=; b=
	mjDXQUAAtKxlXA6Hzcuybf5sAVSpYe478Gdo6nM5Ei6lZOsFEqs+SkxypGAhTM8i
	V1PdLSFcspy4HsISdchLUkzDRX9RkGEKTTe+a+CrhYn8vdEBPhd/uV/ZEod+z/6q
	wautMDQ4GT08C5YEe9nlccA/FoNJnFO0PfA/KmKZeTrvcvghWHjzz4vyWGM+nJIR
	YT7jnHdG/XjrQOI8mle79By8JP16tEzMtqhYdYjluYUuXR+rUqeID1HEENEB9VU3
	lwLEdUD3ElQiMOta9bFYVYCXdFmlFShmph5kOcslrVlI0uKr/YQAhu2cpsdFBhc1
	bLoTZtEsotdIP7HcphaDsA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m45ebsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:58:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47KMJJCr040079;
	Tue, 20 Aug 2024 23:58:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4153u2tbed-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:58:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSSjQ84ghEPr7NhQ1BgtgGHvm/yrCn6VhQT2TvjAaY6gsfnLEnJgy3PFWcm3Cm4S5W/E1HxZdSQj2KEUByMuJjSiio7XopuSqgrbnzodOWxPkNi9fzRA5RXB85ibQ1j+KT+QiV/gEB9KGvFMurMqxQa9Ea6r/tIGqI9NiLynewcq/8FPvQ/QgvIp2pp9f+J40Dg3LcrBgzA2RnA5rzynlX1zvOq4sk/orJgnQ4lfdE7RdzrVrftrCLUll0q2as+UWvMVVFiVZo1IBEGqvePTSo/YQm6fhwF5mBRbeNJhN3vjd8KXSCgRHdiXeYVVfGEpuO5xWxt2vCO6NGYdcpGSiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umj9YQLZTIAO4p/q1uoqol053BLAnZXvnRL4qkPn+G4=;
 b=rUTm1MRUvGpJ16wS9Rj9GAaetNT1nXLOJmgeexvxvxusyaiCnNxLCGcZUMlKgIiREP+0ybeHLxeooKlflf1LZNMtLqoyVCTFmP0NgTF+ppaMsrRojdKZKuvOGiOdkhWyM0G2Wu4nX8ccC3THMC3IZ4DgwF8s7aXY+N3P4056np1qMg2ENdnAx9wZ11PWA1gniltFxQUnOv+ll538CCgmVfaQVxmVsXQhpAjHgjTwOHKrJ/xv99Kau4FXODozQ1SNF+tHHd865trSdooXAS7v5jk2yae8BdhQQmNjck8Y7GLhj35ZsVRu7yYKnog9AVGDYFnXrNqOpghmhyUr8LAk8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umj9YQLZTIAO4p/q1uoqol053BLAnZXvnRL4qkPn+G4=;
 b=KXtX24xfgPKQP0J48zpLvRdVvZMetzokGd4CDcEfs4mff1QIRShvG10VVJquz44UkXxsNE/Z7OFBP5MEO4aFrHN63GDIqmz6SMNsPXnZULYSzXe9E1Wd03/YuhCicIRK1rsoMaaonBE27iJVqOytsR7aBx5tBWEM4bVTHRZt40o=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB4757.namprd10.prod.outlook.com (2603:10b6:510:3f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Tue, 20 Aug
 2024 23:57:59 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.010; Tue, 20 Aug 2024
 23:57:59 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v6 06/20] mm/vma: Change munmap to use vma_munmap_struct() for accounting and surrounding vmas
Date: Tue, 20 Aug 2024 19:57:15 -0400
Message-ID: <20240820235730.2852400-7-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
References: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0419.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::6) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB4757:EE_
X-MS-Office365-Filtering-Correlation-Id: 269f7abe-bee4-447a-c2e8-08dcc173eb06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bTMeUvEiUtvzTkiDVg+af42A5W9kN53AH3nn6uCghi8k4V9N0uWDuaFiplil?=
 =?us-ascii?Q?MWegGNJKgEwm9jHreO2zEfdKGxBXTazT7+k2Gh+AiO8QK/oNul8Yd8q3rG8v?=
 =?us-ascii?Q?sAW7eXQwNbj+ykGsBWcd0KioQmJPgZugfCXiDX1RtrLge9/y5/S3WRxR/HYs?=
 =?us-ascii?Q?bs7LhWPCoyg3RSfp+WG46+JcovsVoen4ETiAIrK8PdQ1ix9aARN+4lM9epoL?=
 =?us-ascii?Q?tI6pTuBLHrtMUf3M0qnvZTHgsimhI9fV3nutTLD29Fmm8il123kE/HVWMu8z?=
 =?us-ascii?Q?F4fGowgNn2Vz+HTU4LNetmwdAbMVJAK8kQXyEHD0VkaxwQuYXgomjTqQ36X4?=
 =?us-ascii?Q?4tQVZPlooCBylP99pMlJ1Zad23XdLJ/mvkCzEwNCbBbp8vHqyBIoNdozfWcL?=
 =?us-ascii?Q?4YnlGk+PqNzoZZjgF257t7Yonk7GcEn5SYzczbm66ljnLNCEyEutvC8OYrlh?=
 =?us-ascii?Q?mXkobc1LQDhMqaEVkRklN2lbBVaIGdkvw89bTI5efImzYWwUtJYbWBOBY70U?=
 =?us-ascii?Q?XpoeosNfF3DMICZxSFOUOUHAnD30ZqEYy171EBdLpXIYrPPh92vfZ6GuTKsJ?=
 =?us-ascii?Q?2rPRC4h+1xg5rHGhixo29f+1m+N6YUsnzhFjcAi25DZFQyr5JTSeVVHqqJFK?=
 =?us-ascii?Q?HIRCLgop6hVKh0YUi+RTTSA6TnISpXb2pCAVcEkvbq/M2kcK5/Pw3xqnoxKw?=
 =?us-ascii?Q?tOc6VGOItdwS8UIpipRAepw8hF3kUk6l0AYbwaVVSgKpf8Ucmxljx+Q5W1Mp?=
 =?us-ascii?Q?7oPuB5T4aV/NBzKk+4sidsQJcjCgjGKGXbTXL73lzQt1x8itl+nJ3JG/I90f?=
 =?us-ascii?Q?3a44Cdxo9K3JH81APgGzt3X0PE2DXMtp2AOCJ1RRSLlMc9yYpXfQT3Rnfd81?=
 =?us-ascii?Q?PKRV6b791tzZDiUHKVztGE4ISbPXnkvZQShI6zkanS/FwtM+OFc80qyFyTgJ?=
 =?us-ascii?Q?HnU03S0OycyIuDU9WUyn0keuzOy8xWdcdAT5ofsR8T7/2iVYB73Wf66A5pf7?=
 =?us-ascii?Q?N1RmC8+p/5TUfkN+w2kqAPk/86A/00x5fR4pYgX+6fn0n3DC+PKxx4Uozphp?=
 =?us-ascii?Q?8g4owFPo4GCnwfWD6f7+psCbNN3kGnXhl3WARpLJmT3OT3i3Wm6KjVmkTwON?=
 =?us-ascii?Q?GP8xhiH1lKPL2Hbr7TNd5XsgHq3pqHKkx3kFYYkGKXPvL9xDlbH5eeBsU9oL?=
 =?us-ascii?Q?/2XeMdVkG18sJXNZtyPIdvjWz6Iy6ZHquHGA2sH5EuU2Cr/BydWD9ihC9YHW?=
 =?us-ascii?Q?WUgIzWlyFKLeph94MwVspukhV6q+oA1xfvjf3D1zlJSc7X1oqel/z7KFnKsE?=
 =?us-ascii?Q?xgZ0IUIRMVgTSAj0KErff2/tDVXObQ89abrg1rUnnQLA9A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BPuK9mcqh4JpsB4QD89JfFJ9Ax73ETTVpyYDwyrGK06DHW+OLsGU9jY1EL9h?=
 =?us-ascii?Q?lV1yIFPw6sRRdTj0BEXq/AHRr1HWpMSZyIey1/DLFKiYaYqlB/1tft17FZ19?=
 =?us-ascii?Q?MQpVyrCcMwgC624wVFXar+TX/Yq+WjtOfmfKr6r6ttATM9jiCC5WL20dB235?=
 =?us-ascii?Q?Jo6V44j/AE71/CE834+mtsaptg1Sq+gAYQ2CgOoQ9iT0wAfFDly08iGTmoQA?=
 =?us-ascii?Q?msLClFpelhsRdLtE+GflTd3osbwvdtU/rOksr+9yP6OMIcFLOHXFNhwLlXz3?=
 =?us-ascii?Q?dB0uBZbRBe8K9oZw5/ySExUoU32s1tPDZY6CO7nfQ3nU/Dj7iImDjVanCADK?=
 =?us-ascii?Q?cYwjBgDqW/R8MMd3NIDWlEGZN+JCXRQDRTBhA1QZmoU8y1zOXXsT/YN4yqiC?=
 =?us-ascii?Q?71zbz4k233P/U9HLGySOA/dCO9FNj9GPWZSb7c3dJMm1m/G9m3c7tL4/fdOo?=
 =?us-ascii?Q?qrjBRno1elmkdJ5q8Ivd49gGRWBRdcVXsCT0YBHFeO+GJ1p4c33tvjyy8f59?=
 =?us-ascii?Q?IdzLBLoS8F00Kpkhx+AunFhaMrQtwJVh/10VrUy/MnaiWyjxucBB61RQ1Xtq?=
 =?us-ascii?Q?waq3Bw3xgTi9emR9jqizxMgoghsN+5HxmLsgpRwEaQnQ71hDbc1/i8fNKTQE?=
 =?us-ascii?Q?LEpOCvRL9zZ9+E75v/W0j8GslDVMcx19zeMAW0UfhIYkYSP9caNbvWPE5FUh?=
 =?us-ascii?Q?HU32UWSw/GEb1rGD80Ck7pomuI0qgRuolikoLwH09W1Pw2RmJzn6vCSbO+jn?=
 =?us-ascii?Q?kZ9HMcErsZRnduQuAfvlbbpBOn0UEvQs2OGFZlRmnKgSMI/XoQA2fbLdNN4n?=
 =?us-ascii?Q?GGj+JbLbjMzwBMAcWyPfYz9xUkIm7pBzXAKrlcQxJaSSSfH0APurtdvZWYXR?=
 =?us-ascii?Q?ZXrcIQwGUS2q6RgiocLsuicgKaNVshV3Xo3O12yg5CGKPn6326GYcbbt6OVQ?=
 =?us-ascii?Q?Jo9Yv5MbkcwbO1McQSxtaaLIicLVtE1ESQNJ7wj747mjs/22f1mSnS2v72xb?=
 =?us-ascii?Q?rBNGStT+bbP11WAb0kG6EOD/rWryP9sBgvodiaz/DPI4ZWJSquSE4E0/uBMv?=
 =?us-ascii?Q?ZF8xnwp5QqDP4qbMT7wA9Vf87Kj6JELsTkxcWXT7+LK9lM9P9koGTDUClU5w?=
 =?us-ascii?Q?gCeCQYwdFfToUS/AAGZC3+rApOXwNS6a7VpidReqj7Rcs+9IXt6I2Ah/0Ki4?=
 =?us-ascii?Q?JnENrki3g7Oun6PfHvNd7HEvIj10BkAASnrzQeSwcd1cB1jvQGujbhUf4FEU?=
 =?us-ascii?Q?pJBY6ZMZnVoFGl2zFLoUrLW/YYwRQPjgvNnjCz6MEBGqsl+mcFP51HPHXJCH?=
 =?us-ascii?Q?4OojtlV2pPJG4knx1srbKfFHP5qFYC+Us6C41xbSGi6r7CNFbRKFdrQ8V1TD?=
 =?us-ascii?Q?j8z756Zs24Ak0HKxxQvpm4ScJ449zf8nNIBJxvcREdT4bQunLs7ddTTgZtW+?=
 =?us-ascii?Q?LbovHU73pqsgm7UxW4104nsM0jo2WJvfflnxwWcNl7N6xbb819fTqp0bd/O/?=
 =?us-ascii?Q?3Of1gVCa9tfgurfBcAqWpSHandxAShjzmd/Cdy7g4UEH/tIhWahXsQb9Fwqc?=
 =?us-ascii?Q?0WQjU+KMSv8zrpW+U7tKC+WcPmYe1pf6pwQEJik+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UpR6DMPSbM4frFWOjhpwHt308x74kkJrW5KzTxlD9Tx2mC/4+bB7WSS9CwXAwb3jnFJ1IC2gwNM5+DLASERZJdYBSJSOgO7Q8WNA5auRWR3xUXRNSgHRb/zbCBdrkYeuoihDwEwSRjUPYipUuxfrPsnjRvgc8vVe3OppaHohz/chD0mluuK7fL6XgG+BtxbP/ob+UvqHIUJgKIoRRmTGgjLxa539JaH7seWu9s6RrEcXJXAaswma1ZppMD+ljZKjDAnvW1qlvIIb9k5c6gIbUVIqOTaTA1MZxHFaVRoXchhDA6pfDtfuDoxxd2UYdF0LnHSCPKisDs/r77dTAX3rnAnuYC8nII2mqd5n2MDE2SVdBC7R7o42YU0+wjnw1ikDWRlBoZYzN+9rcC5bKy1g0oiMImKxmjdS1hPNqMHZ0poGYKl8jr2Sv1/IyVPQzzcNTex6jEWbrZ/yDqI1AdOJujkT16AhzzlBsooLBxSte+H20Dq2q05FEd+W3am+Y3X+2zUhSDPZ39gjtPwnD5id4lWClKvkB0WG5kOfokv9v4K81uTwtc1R+gzDBEXaXOqZHQEsnC++mOskeJgCCHH3IX2M737lDRLFkK2xZRqHX/Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 269f7abe-bee4-447a-c2e8-08dcc173eb06
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 23:57:58.9488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NaI1HHgF5BbWIXM42sE5dI3FoCB3ZedyS4TjJ0cI/mgipAYE1OIXYuCKFi1jyY6WrpVnV3Lg6GewcGvKuxz8Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4757
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_18,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408200176
X-Proofpoint-ORIG-GUID: e7p5JRB65i7T9U1pTr0Pcr8QkAaP8Gnr
X-Proofpoint-GUID: e7p5JRB65i7T9U1pTr0Pcr8QkAaP8Gnr

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Clean up the code by changing the munmap operation to use a structure
for the accounting and munmap variables.

Since remove_mt() is only called in one location and the contents will
be reduced to almost nothing.  The remains of the function can be added
to vms_complete_munmap_vmas().

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/vma.c | 79 ++++++++++++++++++++++++++++----------------------------
 mm/vma.h |  6 +++++
 2 files changed, 46 insertions(+), 39 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index e1aee43a3dc4..7b8b8b983399 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -103,7 +103,8 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 	vms->unlock = unlock;
 	vms->uf = uf;
 	vms->vma_count = 0;
-	vms->nr_pages = vms->locked_vm = 0;
+	vms->nr_pages = vms->locked_vm = vms->nr_accounted = 0;
+	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
 }
 
 /*
@@ -299,30 +300,6 @@ static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return __split_vma(vmi, vma, addr, new_below);
 }
 
-/*
- * Ok - we have the memory areas we should free on a maple tree so release them,
- * and do the vma updates.
- *
- * Called with the mm semaphore held.
- */
-static inline void remove_mt(struct mm_struct *mm, struct ma_state *mas)
-{
-	unsigned long nr_accounted = 0;
-	struct vm_area_struct *vma;
-
-	/* Update high watermark before we lower total_vm */
-	update_hiwater_vm(mm);
-	mas_for_each(mas, vma, ULONG_MAX) {
-		long nrpages = vma_pages(vma);
-
-		if (vma->vm_flags & VM_ACCOUNT)
-			nr_accounted += nrpages;
-		vm_stat_account(mm, vma->vm_flags, -nrpages);
-		remove_vma(vma, false);
-	}
-	vm_unacct_memory(nr_accounted);
-}
-
 /*
  * init_vma_prep() - Initializer wrapper for vma_prepare struct
  * @vp: The vma_prepare struct
@@ -722,7 +699,7 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
 static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach)
 {
-	struct vm_area_struct *prev, *next;
+	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 
 	mm = vms->mm;
@@ -731,21 +708,26 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	if (vms->unlock)
 		mmap_write_downgrade(mm);
 
-	prev = vma_iter_prev_range(vms->vmi);
-	next = vma_next(vms->vmi);
-	if (next)
-		vma_iter_prev_range(vms->vmi);
-
 	/*
 	 * We can free page tables without write-locking mmap_lock because VMAs
 	 * were isolated before we downgraded mmap_lock.
 	 */
 	mas_set(mas_detach, 1);
-	unmap_region(mm, mas_detach, vms->vma, prev, next, vms->start, vms->end,
-		     vms->vma_count, !vms->unlock);
-	/* Statistics and freeing VMAs */
+	unmap_region(mm, mas_detach, vms->vma, vms->prev, vms->next,
+		     vms->start, vms->end, vms->vma_count, !vms->unlock);
+	/* Update high watermark before we lower total_vm */
+	update_hiwater_vm(mm);
+	/* Stat accounting */
+	WRITE_ONCE(mm->total_vm, READ_ONCE(mm->total_vm) - vms->nr_pages);
+	mm->exec_vm -= vms->exec_vm;
+	mm->stack_vm -= vms->stack_vm;
+	mm->data_vm -= vms->data_vm;
+	/* Remove and clean up vmas */
 	mas_set(mas_detach, 0);
-	remove_mt(mm, mas_detach);
+	mas_for_each(mas_detach, vma, ULONG_MAX)
+		remove_vma(vma, false);
+
+	vm_unacct_memory(vms->nr_accounted);
 	validate_mm(mm);
 	if (vms->unlock)
 		mmap_read_unlock(mm);
@@ -799,18 +781,19 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		if (error)
 			goto start_split_failed;
 	}
+	vms->prev = vma_prev(vms->vmi);
 
 	/*
 	 * Detach a range of VMAs from the mm. Using next as a temp variable as
 	 * it is always overwritten.
 	 */
-	next = vms->vma;
-	do {
+	for_each_vma_range(*(vms->vmi), next, vms->end) {
+		long nrpages;
+
 		if (!can_modify_vma(next)) {
 			error = -EPERM;
 			goto modify_vma_failed;
 		}
-
 		/* Does it split the end? */
 		if (next->vm_end > vms->end) {
 			error = __split_vma(vms->vmi, next, vms->end, 0);
@@ -824,6 +807,22 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 			goto munmap_gather_failed;
 
 		vma_mark_detached(next, true);
+		nrpages = vma_pages(next);
+
+		vms->nr_pages += nrpages;
+		if (next->vm_flags & VM_LOCKED)
+			vms->locked_vm += nrpages;
+
+		if (next->vm_flags & VM_ACCOUNT)
+			vms->nr_accounted += nrpages;
+
+		if (is_exec_mapping(next->vm_flags))
+			vms->exec_vm += nrpages;
+		else if (is_stack_mapping(next->vm_flags))
+			vms->stack_vm += nrpages;
+		else if (is_data_mapping(next->vm_flags))
+			vms->data_vm += nrpages;
+
 		if (next->vm_flags & VM_LOCKED)
 			vms->locked_vm += vma_pages(next);
 
@@ -847,7 +846,9 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		BUG_ON(next->vm_start < vms->start);
 		BUG_ON(next->vm_start > vms->end);
 #endif
-	} for_each_vma_range(*(vms->vmi), next, vms->end);
+	}
+
+	vms->next = vma_next(vms->vmi);
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
diff --git a/mm/vma.h b/mm/vma.h
index cb67acf59012..cbf55e0e0c4f 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -33,12 +33,18 @@ struct vma_munmap_struct {
 	struct vma_iterator *vmi;
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;     /* The first vma to munmap */
+	struct vm_area_struct *prev;    /* vma before the munmap area */
+	struct vm_area_struct *next;    /* vma after the munmap area */
 	struct list_head *uf;           /* Userfaultfd list_head */
 	unsigned long start;            /* Aligned start addr (inclusive) */
 	unsigned long end;              /* Aligned end addr (exclusive) */
 	int vma_count;                  /* Number of vmas that will be removed */
 	unsigned long nr_pages;         /* Number of pages being removed */
 	unsigned long locked_vm;        /* Number of locked pages */
+	unsigned long nr_accounted;     /* Number of VM_ACCOUNT pages */
+	unsigned long exec_vm;
+	unsigned long stack_vm;
+	unsigned long data_vm;
 	bool unlock;                    /* Unlock after the munmap */
 };
 
-- 
2.43.0


