Return-Path: <linux-kernel+bounces-248170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1580892D914
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C602B24F4C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54D8199254;
	Wed, 10 Jul 2024 19:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SE2BmYm1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CNDuBIIW"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD33E198E88
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720639433; cv=fail; b=p14yIFe6/uXMTidWXenuXJpGg3HXARS7UgTLRxEmdSu7lrL6YHw/8ePwJPLtO1m6GK6GUE19sPag3Mc4oRuhskmWnk7NktTSFPLsAEKCnWjrdS51wojB5UE1DMH+W2jUVQ/Eij/R+zEQwMraYoCp4Q1DhZrxVtflegBtZ47vccc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720639433; c=relaxed/simple;
	bh=yIedfDJWoG9+9uRg4cr30K4nvx9TualNAp4FMwHgKhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iqU7l39Ba8tXT+nDxAv7e1tX+Bk4/Exwn43f/x9HQEsBpnv7Ow7P0cXbnPsz3520UPkT9pYODCtdNvkuZGYT965NUlj5VAujoHDRm0JnJ/aPMcwyIlAAEkHt2XjILItuvnbQwyZGHfhTEH1Iutt9nhB/jUGyHKG74t98ZUG+sU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SE2BmYm1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CNDuBIIW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AFWaku012654;
	Wed, 10 Jul 2024 19:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=nNu/B6N42Yk8627RuBq6GJzGSQoxxNJoP3M3uv7oJ/g=; b=
	SE2BmYm1Z0SivcBTto6WpWaQDtjqOUD6M7+wtupEvX05cwF2fW2Q/ds5yJPuxQ/S
	9kvlOxt+ZcR4v5Wfr4n90Oiz4JOhjs8EfuVlP0p9Q+e5O+O4UAP9fFgKDmiDNOfb
	Oysy+YFszMjUN5QPbKc/Qjx4asFWE7DffKQUsT1JFadzCcsI+B8G6gwesQ7lo5x/
	8yELvDReWKTDsu7lRcub2YagrId1ObKeM74fmyZ12wlp9fMG9J8eDQlLskov28lv
	yDySyu6606qPWM7LUszcfv9IhmAyqv5KoU3Scy7cT18GX/CPQurKcMoZpiq9TqTT
	DOuGEDx/lqukdn43RaoiRQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkcg0bk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46AIdNi7033802;
	Wed, 10 Jul 2024 19:23:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv194ff-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVY14RMkzwNE6/z+fhtJRRAFL5nWjrf5RBggq/Fo4vUlvgUWkDaxfGOtnCCTiMVoPQZNZrwdtnPezoc/96CGW4v+7I5MPSvDiOcQAvW4bTr1ALDURwP7Ih4/dUtMhxlO+AHc3srEFxmlExUmEYT3Pg1YQmPfwj9bksdpQ855FXFy5Pg/qaoW9Xol47WLtmV6EqS0lr+2R6UO0su3MWwcksGsg4ISzbMpJ96lSQyJgrIUYnDm/TMNWvCyjLApDHwZCTLS9rUMDRACmL0c9u8BYA+8TS0/Rf+WpbZVy7H5FJXjltgtwZ8j8Yw0gOq4lCA7lUbqa+izWTE2Q3rbAVQuQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNu/B6N42Yk8627RuBq6GJzGSQoxxNJoP3M3uv7oJ/g=;
 b=PjRaA84sAdyXt1vy72xut0BteNur3em1abhDClf62InBt9JXmCosBZ2gXOpE3oa74xoCtmlRiBde0yNqnr5RG3/lMmS5KW1sU/ifsgH+5S0ht9iqKasLgegknywXNIRND/fH8tYyM0dmsjtL9BgJt+Pau0iqXxHZOh7krCTEJuNzsPxglQLIQxSxAhvspH6n8yKX3QNIhxnsk8bH4sMqrd+p6stUlRENpqv/OPk83umP4fiP8bDXGbFqjKomJqutuN2+0OnCtC/coQnBz8S0SLKNNIOi/oR64BNSZvaeLfXXtONci/mErOXgQeQlJyeCz6axftqAGxYO761/3lSKeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNu/B6N42Yk8627RuBq6GJzGSQoxxNJoP3M3uv7oJ/g=;
 b=CNDuBIIWn0zRDjhFF4obJwdF/HOLT31eNmj6ut/yDNidY/cnnRDCXm0EPNpjJcaD7WRjphoaFDtbRP1YB8OGId5pc0q19DYSoyE1/9r+KMXE5mxQ2f1harmTTMLJ9qp03/xHGXkDccqrN5FEeitV37uU/Fl3CxsJUsD0ifxfA2c=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 19:23:18 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 19:23:16 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v4 09/21] mm/mmap: Expand mmap_region() munmap call
Date: Wed, 10 Jul 2024 15:22:38 -0400
Message-ID: <20240710192250.4114783-10-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
References: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::23) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH3PR10MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 27c2e7c3-52b3-49fb-9d7e-08dca115bfd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?gRga06PGR9lUVVFlpYyfJyfWXmmCQfQo/BsrHXuN4ZUHBQi2+CEONq0so7pj?=
 =?us-ascii?Q?FU1bnQck79iCy10cp8v5OL+Uxgy3rw9LHbfAZqFyUs91WFDCE6OQ4aoFVIVU?=
 =?us-ascii?Q?d01pOXpbjkkDi4uJGcsiwUW3/nOW32wC0CzbidZeGzogb5JQsBMB98JRfhEU?=
 =?us-ascii?Q?28EuzMPl0XchpD43Hruooj3Hw3nX8HhBxtmLOuhT8tQNEs5RcJe9ofRo29kX?=
 =?us-ascii?Q?y8ofuHSBJmKDu6msYSol0B2BVAv4qfrABEaEzLlOb8BRisx8fY+XH+9Pn74J?=
 =?us-ascii?Q?dFfMyRBym9ZzQS8OIAtY999sF/7KiHWG3wMOuzhi/hvzqotQel5vZKRIFsvs?=
 =?us-ascii?Q?QmRrZ7Sa/ZgpRXeicJF2Z2H2chw5OH/9458ubENXpvI1F6iMeUrJN8ln73vT?=
 =?us-ascii?Q?TCwmQ2jBqld8BzIs2TpjEFBwCSJkgyxxYCAmlsh6KmfAgm/llCexUTEUAmko?=
 =?us-ascii?Q?sqnCFsmFc9u2nUbHSTljbqOB39iwSJMwsl1KOvCAwBSNoKGLN5zpY8RikSNO?=
 =?us-ascii?Q?XMr3h92EEvPeyL6IJcl0SxVZ6yUwpk9JGk859sFEPpWdSNUlRbkMW8+nGA55?=
 =?us-ascii?Q?dFLThFwwgOciudctRxQi5Y3HCyeOHm+XavN25iaeN1Wrj5pHTjBjGLZztI5o?=
 =?us-ascii?Q?+VF9HzQqmircLM3igYk210heGTIIzotJNNIV9UzV6kBUc1F07Py0/BXjHlFM?=
 =?us-ascii?Q?JPRMRZg8GxtXFlmwrhyt/zs8E5KtbEYxcqCV0LE2zCFpreZ1eJkrq4I4mubX?=
 =?us-ascii?Q?9viM/LgIu4mvP+d6pjHzNAyjC8gB7CnAiuzLtvkWdoSzBXBKjrhkhfy2OrUq?=
 =?us-ascii?Q?1ycicItjD2kZsafSZ5uQ7CES4/TkI0q/F5gia7XvtSm56OsoNhkdMWssjXol?=
 =?us-ascii?Q?ExrVMKS/bS30lk0VPXoIFjlP1MKxjGzLlK6zXay8tPX0/Lqv41B8iZf5xSfE?=
 =?us-ascii?Q?Tay+xwc0E3kmoPPaIDhPhCOGV3SMQZuzeQUQuDZRIWdCfqtdh/0U35iG8S6m?=
 =?us-ascii?Q?aNjFaOd+QetfpakEReYU9ymZTZOrCC/sjiJdms8J9DMvXvZxUohbxYUj5caA?=
 =?us-ascii?Q?yZDwahKQh+i6lfKgFAYLSxkoXwFIelxJt4JLOwCvIONXvLfTMf5tCQ3CPqAK?=
 =?us-ascii?Q?nhXI4t1LBY6bdeDwE/LGIUZ+JmqkulASFKz5D7t+INQhrGAJiU9QA0aooNsq?=
 =?us-ascii?Q?ypt/rmvEpLsdyR6NnnkqkF90nlDZTSVuoZS4wTPE7avkOkLbRCiVZfYmdhvb?=
 =?us-ascii?Q?5WOfo/h7TmGpUwVsWxWSAC60zeVneis3FzNHCfXJwQCQbjv8HEGj+FfPiwkp?=
 =?us-ascii?Q?yd95k22bemq/cVGmq8MAGRJIwYOKp9O/gBXWqj2Lu2Lu5Q=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?l0SEPHUio2p0mPtm5r8IzxtWzmizbzMWTF7/ykaim4hR/YC8k03wKPWqHBXb?=
 =?us-ascii?Q?pS1NGGgu9GhX2KT3PO7ksVRsQqvwa3W/wYePAZvHdf0cfsZSslnIt3nl7ZDo?=
 =?us-ascii?Q?Aczqq3qEHvrRzqt9Ha3Sdy9leM8jRsU5mrCcU44SYmb5WHfW06znPVUU6vvF?=
 =?us-ascii?Q?n0OgxIHNPnEhjVpehfoH+bV4/yZ6IFTNKbUD5yAKwQcjU2TYnLaNK1zPw5xz?=
 =?us-ascii?Q?WhYWAaEsyhy6P+LEPdYOvDaKMXlC3gR9aIDNwY2B1MSgjIie2N8pdzpxnXpe?=
 =?us-ascii?Q?U7wgQqkmIwmHN5F2wNnjCbbqo4G892TnhlpAKVaRSVautxSmzRXzNAgWvumv?=
 =?us-ascii?Q?39/Z6slZo0nCP1PtUIL/t90z0qD0S8aZd8XJ1L5QDxnDA4MDh6jWgJl0g/Vn?=
 =?us-ascii?Q?cYQpcnNcw4IHme+3HwFlE/Zg/d3cWYbm/m3K1XTNb1OEWrHI64T+TIBRG6PN?=
 =?us-ascii?Q?bEOn+0MLFV8hHqwhnp+3rO9luBmuqFwP6B3NSzmuhelwE58S5F9gAzj9oRQy?=
 =?us-ascii?Q?N3JC7/1hDxmv/U5IZo7NbULZKPL+JGVLxgF8kwRaxG4V/hYXMADSjdyRP5Bg?=
 =?us-ascii?Q?LyRHRrg9lGGK72BA5HeZlzfE6bPZd+L5psvvPpYRd39Mm0OYaKavfFhyJiGE?=
 =?us-ascii?Q?l2fPGVfSflP8s5N1bOlHYFKVIE8cLpPJIZIxeVMxutS+ZIW1Tzi3M89g8miM?=
 =?us-ascii?Q?KWzNM2gczxNbhynA4UR8Ohmg0LVNoMexn6FotqiT6eDrWNTVWQEi/cCBF9cI?=
 =?us-ascii?Q?8wmXFNybI1LT2Hcodhdu+QpYOFBxfHT46c79CSeqU2PUOb90YVxP2F/f8UPG?=
 =?us-ascii?Q?yJRL4bXoOaFk1GxE/A2EnzXPLwPO3fFgaDJaHvvDuc3uu4GapWDRAps2Z4qq?=
 =?us-ascii?Q?rxHmYo/1SNpqvf24SYinn+pz7nPCmhIwExIIQK3YvxmlnJJDu8NOvbZnk8TH?=
 =?us-ascii?Q?u+dg5PQdnH4KbW6fUVpdC0gV+VLEUqrBlgR02YLkKxETFM3a+FpeEO2Y0JdJ?=
 =?us-ascii?Q?2KhboMOaghlUToPVm7rsWzGvyZNB6TTNddu3eYlBUpqGla+ep2B/hTf5PqMG?=
 =?us-ascii?Q?kA7QHNW47QvSpzNx9qiyaLeRQtPCyH0O2vwSwpdDVHcIlWuByOCAOHcCAjAg?=
 =?us-ascii?Q?5QrjL+SuVIDTmtt/kEq5DgHUdCIfGNnuDutnro+bqCuDnnJcnX7wPemdgeTv?=
 =?us-ascii?Q?uIwhixW9DXXz/m4iLoTl/nyJngbCkO+dC6VR8RTIWxig2PFoxZes/HV2Oqbg?=
 =?us-ascii?Q?iQhf+Haitra+V1S3gujXUjPlSj8Ayt4KhnP4A0rjhR9u9XEKhabLx9DX5dKs?=
 =?us-ascii?Q?hL2M1ZEVjYQMZLE+QNVGggxDuA7u6LjhGoa8WwcpCU4B09IV2muS3fiTcSAd?=
 =?us-ascii?Q?C43sSJG24xMcUTfvBrOJ+k85Sr4Zg+6TWknlz/OkTr9kWf6A4Do6RuQfS1KL?=
 =?us-ascii?Q?T/tOXC0BWNDvTAxxQtpBm9x1O7QpDrYfvN20kY2Tpfp1UE74uXaE+iWZnb+v?=
 =?us-ascii?Q?2K5nroS3+9jHtmOdxX69q7LJLS89e5/SZrqAuiDbdOxXk8nPeHEtA3IHJrr8?=
 =?us-ascii?Q?mIRNHzg5rKkJ9zuPjFTRnnWzN6ENx8mbrpSi7LuYBs8cy0jKYS+LRiLPRx2P?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Ns0XvRO1iGEBVOMWAUfFaUc4dNur2a5ATSe32QDmrAeM5iqZftAasazaFgkk+nVaA7gzUdkEnamtyQ1lC2/EgkAET8pNkJDogVfW1j9Xbi0rPFyJJyvqU9o2J9BMp+z8xzCQFTjXZhdk1Irq0fJoRZduIAekQfNciEqLDTp44DI6THok/yba3AeLeWhvehbqhlQy3MV6nDH/s+I5xzLYsGKmHrw5COKiQE75FmGlz0rQUaQiOGBnVk8h97EsR4NeS6W/5mB8005/8X4aDvhbznCxX14Fh1rW0E/PsQT6rFp59BjqIYJIm1YaUf6zuGgxHHz/9vYGiMhfslC3OSXtm9/VcFFiXUIOaDkSx5wn40AFiiP7yhonjYgqZVqoTtZGYGMSI+KelnFpJuIvk1Afx58X5ow0qmAU7b+HjhxdWL2UetSV5QphevDf6Ecs80w1ta75rcNPPhhl7EKrZw7JlvA+mO5dZPapdsf9wCJ3wBkY1VwoY+g0aIJhKlCvcz4OEsRnkp/eoL364FnrNU8YgBe5ccdhNdg2Fjh4eZXQ8dGtxdVl7o7TUGE9cA24jCWHbHc6eEWewGRjbtb444HVtBeF9SWSKeisbrWd18+y5qY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c2e7c3-52b3-49fb-9d7e-08dca115bfd7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:23:16.6051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WR+b9ezQe/AF3wgCAv2gPxgW4kb8QUgAvW8I233fyEi86ShTf/tthzBTFgdgboD/VHyQ9LtCmPMth3Cqmo9oaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_14,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407100137
X-Proofpoint-ORIG-GUID: mMk98T6BYbX9vl-0_GVSLWRA9kHs7TXH
X-Proofpoint-GUID: mMk98T6BYbX9vl-0_GVSLWRA9kHs7TXH

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Open code the do_vmi_align_munmap() call so that it can be broken up
later in the series.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 49b3ab406353..a1544a68558e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2916,6 +2916,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	struct vm_area_struct *next, *prev, *merge;
 	pgoff_t pglen = len >> PAGE_SHIFT;
 	unsigned long charged = 0;
+	struct vma_munmap_struct vms;
+	struct ma_state mas_detach;
+	struct maple_tree mt_detach;
 	unsigned long end = addr + len;
 	unsigned long merge_start = addr, merge_end = end;
 	bool writable_file_mapping = false;
@@ -2948,10 +2951,27 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	/* Find the first overlapping VMA */
 	vma = vma_find(&vmi, end);
 	if (vma) {
-		/* Unmap any existing mapping in the area */
-		if (do_vmi_align_munmap(&vmi, vma, mm, addr, end, uf, false))
+		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
+		mt_on_stack(mt_detach);
+		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
+		init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
+		/* Prepare to unmap any existing mapping in the area */
+		if (vms_gather_munmap_vmas(&vms, &mas_detach))
+			return -ENOMEM;
+
+		/* Remove any existing mappings from the vma tree */
+		if (vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL))
 			return -ENOMEM;
+
+		/* Unmap any existing mapping in the area */
+		vms_complete_munmap_vmas(&vms, &mas_detach);
+		next = vms.next;
+		prev = vms.prev;
+		vma_prev(&vmi);
 		vma = NULL;
+	} else {
+		next = vma_next(&vmi);
+		prev = vma_prev(&vmi);
 	}
 
 	/*
@@ -2964,8 +2984,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vm_flags |= VM_ACCOUNT;
 	}
 
-	next = vma_next(&vmi);
-	prev = vma_prev(&vmi);
 	if (vm_flags & VM_SPECIAL) {
 		if (prev)
 			vma_iter_next_range(&vmi);
-- 
2.43.0


