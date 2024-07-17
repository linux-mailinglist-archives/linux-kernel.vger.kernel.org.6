Return-Path: <linux-kernel+bounces-255631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB13934302
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E0741C21451
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F1B192B8B;
	Wed, 17 Jul 2024 20:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HpAHzNR9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CFJBvBNq"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4321922EA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 20:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246895; cv=fail; b=DqIuGdwVI3Bj/lwCf3tVULKiOVu8p7qgIGybFsfvLXJl9VAOhuH65cDYbOx9dV30g3V8+o8+DPdqOgCC1d3bd2B3bey9LLd5MunEPbmQh9wqsLUR45DldQ5H2ZbC86T7edyWKfb+ba4DoUb2u0RmYopnt2qQZQkni1vfXaUyRvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246895; c=relaxed/simple;
	bh=92IBaHVc9AS7zQaJWPZ9Cwer3tcFTV7it7oCsTYo5N0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cpcr3MhPuAJflwP9WYYy6foUzyibegTvRoyme/xK9Mw57Epw2urCXH9tEECFPsdAnOMfQFgCdMXETqjG2Q1176td56Zw01ws0hbsXdm9ncMarZBXkKPPlRgkJ8Z3FIFo4JCHmHy5O478qnmNko9KCotxRFmy7IvFHn+13bdMZsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HpAHzNR9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CFJBvBNq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HK5ARs002719;
	Wed, 17 Jul 2024 20:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=1JOtMp6ytkbFmdJPiX5X/B9862zAZNwTtK3hdHWBpPk=; b=
	HpAHzNR9yFPcLvRudQklQI4H493/DxD7zuA3SlC5gAfc6md8ccwqp3KpPJxIfpWe
	XLFd936DhId1/4MF0g5XXxISSW0vykiQTRyNB1eccE32sIpKhtXgQJv7VvvhtSig
	ImZuvbegtX+rkj5elZ1XtWOC49pw2oxPhSMKW1Iad7qGAZzEj9ghKOoMCYDnWmFS
	GDNRIKlfNGvwGfxdMLfbaNhVZbTZ+QTdpyHhsYzqoAA1OBQFax+sOmfugfpFW3BY
	iscURLt0dtu4Iudqw9yWhPGlzejk29EWaP6f6t+2ukPUQwDgxyzTfi4aW/jbmhjC
	UI/V9VC1t1Rn8xminiFkUg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40emp5r08n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46HJEjNZ020154;
	Wed, 17 Jul 2024 20:07:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40dweyh8qh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ye4YG2AJim55+RJiaKZBVInQ+8vHneJvfNVl7BEJapPfa6AfPHgbpeJe2ATrO4Aq3pO5BJACr8MfiqIYog6re0Ra9k9WDtDRiHlylzmD8U4ENYkpTam12/WukivoKUgt/T71iOaJdedqO51uMKh4+XiWcwckHPoT4feuYNBV7WG+LgO6jw6k2riG21M94rC4fnBIJvdE/g8OQaaA3I/IUl6c+1rqDC5H2gBkw33lCB0R/VkonIWjhU4txjKe5TGOk995zZo0WgsFQUGqcFB6aPtCebrfgF6MEz0d0hhYmmzXOcgmfBXPp9d8/eBxwCQCYWOfvV0A4m3COZVw4W6ROg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JOtMp6ytkbFmdJPiX5X/B9862zAZNwTtK3hdHWBpPk=;
 b=SEGHyDLGHjW+mQQvSvNK6E9VC2o76yfgxOP5pMInXiaIwPSqrTfvSiqrWDlrKpZ+t43cjozwypn7889x8kkLFH8lqMqhAbuqfMgfiPO2zVJ8uB1jquSfYP8x+T3LbZNJ8ksWs3fpAvodAdFUXHk4/KOXomr8Rb5u+AUVR7MZjQ8FcQnSRwlokivwKCWzb+OjfEcxPpr1ly0hxnWY0BzCexnR32ysXzSnrYRHJk5N3gXTdHWe7zH2E5dPZm2VUuTh9EIropmsNOwI6WdRHdNl/L1Fx6d0pBovONwCFhwWHQ02eBby457WUu1/S2JMWRYCJrmMfdMBAMyi9Oe4TXGJvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JOtMp6ytkbFmdJPiX5X/B9862zAZNwTtK3hdHWBpPk=;
 b=CFJBvBNqLV51Z9DMzlTWzNRZbnFDGRNOdZLnBjdteEsLhe1c639A81pdBzY2fd3Mkfdv31yXWjYrtmdHk5hHz/4inb9jf3VSUlmz3f48n5XJn1pkn599FjVljCCePjPY0T3B2zvwsv8yQQqbd6GyoXes02TSDM0t5CBgjhuSv9Y=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH7PR10MB7694.namprd10.prod.outlook.com (2603:10b6:510:2e5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15; Wed, 17 Jul
 2024 20:07:54 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 20:07:54 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v5 19/21] ipc/shm, mm: Drop do_vma_munmap()
Date: Wed, 17 Jul 2024 16:07:07 -0400
Message-ID: <20240717200709.1552558-20-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
References: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0275.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::26) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH7PR10MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: a499ed3e-3afc-401a-61e8-08dca69c2513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?sKEDJ/sRZHHtTrmXPumU5lSAlHN2+zSKMoibKTow+6ZlDjW92f+2kQ0Kt9/p?=
 =?us-ascii?Q?U/D9PtHufMQQ4bw2DrBSBtD2vyvxZneHZYlyT8g1+VxdrNAb2Z8+YrGYoCGs?=
 =?us-ascii?Q?ZBmtKEPEaG0CAVfXuH80h+3uwE58AOn3/KFk91k1EEL03vLKgjiQRekvpf7m?=
 =?us-ascii?Q?u9AwZKIysQ1WxdHeSpY3UZ/aBlnqr5EGn+c4lSqt9ZDZbtT3dHfGyCXsWjjN?=
 =?us-ascii?Q?89PrnPfX/SM74H9/OyQZucSoPVZHaaR+goy+Bny5mYimHSDLqcqPlrlabwvK?=
 =?us-ascii?Q?cgpyL0RMY2vFxqTJGseriM3pzmrHYu8dVXkzTpYzQ7P6rXSQb8Fbf8HRMlII?=
 =?us-ascii?Q?YBXKr8lRBFEuG7FBmNwORtk0G1Bg4z+fo2NWURvYDfBDk18nPNg120BpvvTf?=
 =?us-ascii?Q?kknh8DabhQkeyhfDbWtATO3Uaonlu2t1OZlNQEIIhjTyV4ynoP4iOCztaYyL?=
 =?us-ascii?Q?ihtlHsgnyVE+0kYWkgjeFnbOFa39X4ikuz/PyA7s+kjX7nBgJE5J2paR9w37?=
 =?us-ascii?Q?jevcK0FYiQJBhFAyclFKutkM//jG6GlOCn+Skqd90kbo/bRrxLiK/hp9wwcA?=
 =?us-ascii?Q?Db1LN1eiz3i6KMYi4gOVMl98puEtph35Xls5ytSQW95CUmA3LFw9mvUW6zEv?=
 =?us-ascii?Q?CcyJPPRDiXHGgDy4/Snupf/iOTLn8AWzz2VpbiOrwX43+lJVTlSyQmzYlvok?=
 =?us-ascii?Q?h9Qi3nCDosrueb9QEWVMmvEI1nW3L/2xTMluwhh+qG30Ca3sqjrduK8y5Dck?=
 =?us-ascii?Q?XXc7skvKZ4uk7hadGEiv8vYXMCsv8GGh/VEuzLCgi7kjfufzBB7xqmZUU1UN?=
 =?us-ascii?Q?41+d/vpTZ81LDd205Uiof1FayRpQT0CkYz/1FiZpYByl4PmcfNs8KWmYjVW8?=
 =?us-ascii?Q?Fix2ucA8lty/M/dN1/md12ry8v3C1kMU92k4smRh3sVMo6H6eHX9moAFd5Mv?=
 =?us-ascii?Q?FcoQuHDse8yfO+PsXECEUpNJwocDV3/lGxtIaf/XWnCYklhmGmtdxtBCqTkH?=
 =?us-ascii?Q?+dlKSWiIdOAcIyplp9HsyvdcNZNRzvVbFH5BE4vwVG/lg0gQ5YDCvR1sHU5B?=
 =?us-ascii?Q?L6dszmjU/uO4pxFjxPHfOv/4GDSUJAjPpUdvSIKnWtOkl660Mlj01/Lv5tbW?=
 =?us-ascii?Q?PN7uZnxLtMQo8XZBj/dL3QK7IeEpBz4qye5TqzEjuH0iTHVLHn5RSv8YhBoE?=
 =?us-ascii?Q?zgGooGta+bbYAIRZ/y3CvWWLAHO8iqdu2lAAzG4+rhTy6iAdsOWfhLV6vNUq?=
 =?us-ascii?Q?yz3sY8f2PJ+fC57s8t0YlDVGWIjkKH19AYxBReCQIvVYBImBCu0ZfhKWLWsR?=
 =?us-ascii?Q?0ZdivSxwYJDxCSNQQufNb/0BPxEvxJM6TXOsAvaUuDDHPg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?k0ixBapY2mCl3f6/1vhOlv7rHCYjhFDINbdQINzf7VeTCjhzGCpevEe2d2qs?=
 =?us-ascii?Q?JESDS2C3QiUS+cM1iRgtw6TwVhaiKu2eu/wLTqt1JUXbK+E1Tau/K8MeEOsG?=
 =?us-ascii?Q?fFzanWhi/PNR13vGROaeesNtrCagx69K+IGoJKspA+dtQQBEDMdlXJL9pS4D?=
 =?us-ascii?Q?Pwlz/9pJZgLgkz8CgrzdtCsKFWUdehtX7d/qT+zQVUCx/LBnNDNrzua+vSQN?=
 =?us-ascii?Q?ITF9ORnKBeZvYJNz5t2I0XeKGp5vxpj4yAS0IaCxbr0Sk6ZypINmudDzsu+o?=
 =?us-ascii?Q?trTlszdygUleHdr/AqZVal1EH4dTItcResrI4lCPpZFhJe+YWWqzr9GtAB8D?=
 =?us-ascii?Q?95PqVbkCnhHBpsovNIRFR1VziO3VxOOpRSNOBsEqShOCJ7rthEolWrKlE4ZL?=
 =?us-ascii?Q?cpx9LXxedMSTwGUSeqlZOTt97qGPvoG1vD4iXkYfRVJK6b3dbI5dLXBCjFjT?=
 =?us-ascii?Q?L542AZTG2QUvaPj9qkfYyRr4LRglg6/U7SElQLCXyJYKm8N+t0Kvq7Nwvp2t?=
 =?us-ascii?Q?vD2R1rSjG30cyaxFfu/WxblE+ZS3tk591kTkv6OmDv4L5RPYMH/rUU+YXsO2?=
 =?us-ascii?Q?95pFBMbfBZHhS2I9/UhFQXNOCZTLvc+wzwBOxLJwMI3f7O8caPzFxn7bwg3N?=
 =?us-ascii?Q?Sl0ePcq+uncIHzvUsQ3N1+YdAY+Rdzb00Y/EEFx0+jbv+SgQ7LbIK32a+bIX?=
 =?us-ascii?Q?Knd90bQZYMNRAqiJqB5HdMJWegLIgraeXWbDCDltUNV0a0mzA16O5uhFyvmV?=
 =?us-ascii?Q?8fcziSqKn7Vxzi2KZlsRCyBOiVDcoVU06Vmi7kRKWHYTdWGK3AOpO0eknu7m?=
 =?us-ascii?Q?VynXjg6/0l/ExoWemSaNTMlrpDMjmCcwMZd/9UYKdIeR19kMmWDhg2E0vfZ1?=
 =?us-ascii?Q?V6obMxsnXwxq1Yc3j3+JZTZHJ8xFSeEFGFaRVcilUYm0oAzr1MEp5rjvYIcr?=
 =?us-ascii?Q?durRLZcXWaQrz5KYL/UGdc/GmKXzqhbTxiR1Cgo0WZADb6xZ4NnFTajR8LwS?=
 =?us-ascii?Q?6yEjvd6nZhRXsCqmfez6MePOWXci3q2b7Sh/uliRz5lnzocM8M0zqmw77QXg?=
 =?us-ascii?Q?5Tle2NqZ5NE8A8MCDVOteUt9XJPMf1s+6UnrylCJdxhuxlkbcIiRDklAXx/7?=
 =?us-ascii?Q?oquNZzVJMpg5p/7HJGarFJUqiXb66LMSLxznBXkbpSwWzqAL7nXohXQtkh73?=
 =?us-ascii?Q?bbtp2n9eW8CgR8KCJ8D3tJKjGhFIqUdZBYi3dm4d7kfTkb8+OyKOz4DNH/7S?=
 =?us-ascii?Q?DpGbz+09n+G6cjs6AgzgJBwmthGJKPMdyshmqOjp23SsZ1APIEcels5yoUNd?=
 =?us-ascii?Q?tLqN0/mZ54TLj6jiLaci8ZtzUTGXNbcsrHvNmq4qkc5TtaNgomnVTqoVDCXx?=
 =?us-ascii?Q?gwJ0sEBTThvICVRKoWv/1woTH4yPgot45Hp2agxnidvwoaypQMBWkn7M5sOP?=
 =?us-ascii?Q?jud/YRivrC+LEVD3JwnGzL0Mv4wCh9+H9x3y6S9MjF+IXe95idp23jW3WSx/?=
 =?us-ascii?Q?O/Di9yUgdT8ge8/FKpZgkc27CD+EgEp9Ib6suM3MA7vX5cz/EWhjEMU1iuQZ?=
 =?us-ascii?Q?42CwXfJK+jvVT6tq239Npisb29keWVz7Sg83Jml2OflqGF53ruj1hCH296Ae?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7yXKUITeRxxi23orb1uLZHjPE6ZpBIJ++YflZENKnGa6m4BZiIeTo6elpaoZBQL/ZEQLv6tI0wXBJ45k4ini8C23MgBgA13gAHa6BhIPmnIUT3WBZpJ06ttsa2GutrBk7NHP8DWdla4ip6H7MCK0yXtvAtleCaY2MEzRs78A4yydTi9hAv2dqX/+IFFmz7TRLPULAmejIag5XsV0kVg2EcN87W97l7yi2S9nzaC14WBrc80HtjC6C26kOUiYU4SM6MmjwzWv2O+MsVbqGswj43x7ApcnzDdvpTz3Cjl0LrDF5lGs78EpAkzcbu8pFUZlYQK796LppiHLdCwUyTXJnyB5CFv2/jlb02rJfAfLARMi4RiPcsX6I0JIBIIW0daukXhmrJshBaoRDeqKzQvi6mC8eeNObWtEtiQkIZZO0+7L+5uw7t3mMfkJj1qj+cSRQy3AeECMmmHcyZ+TQEOJHO1IWKHjAKIzjOBuEBBvXrLe8HrqONLauoJFF1fM6WYSAGQquhAeEEmhpe4yAFvrnVUgAJ58ThFI2ohLNNubejM4yLKCSUhBdoy8KAAh/Nur9ekzdiQHBOcyoOPHfHTS7a7z+Z8rXEfrvRLC9VAgU1k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a499ed3e-3afc-401a-61e8-08dca69c2513
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:07:54.8300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cPGPnt0FJv+IyJm9sivBVCZWSOvbc1gFkGLZpc1kuB7tNSh+o9SCJpVTZfykuJh0A1S+qCrpxTkpljkJebFX1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7694
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_15,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407170152
X-Proofpoint-GUID: z14d3hxX0ix4cqEGz7T2ONAneHPtAb3D
X-Proofpoint-ORIG-GUID: z14d3hxX0ix4cqEGz7T2ONAneHPtAb3D

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The do_vma_munmap() wrapper existed for callers that didn't have a vma
iterator and needed to check the vma mseal status prior to calling the
underlying munmap().  All callers now use a vma iterator and since the
mseal check of can_modify_mm() has been moved to do_vmi_align_munmap()
and the vmas are aligned, this function can just be called instead.

do_vmi_align_munmap() can no longer be static as ipc/shm is using it and
it is exported via the mm.h header.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h |  6 +++---
 ipc/shm.c          |  8 ++++----
 mm/mmap.c          | 33 +++++----------------------------
 3 files changed, 12 insertions(+), 35 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5f1075d19600..49a24c023153 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3406,14 +3406,14 @@ extern unsigned long do_mmap(struct file *file, unsigned long addr,
 extern int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 			 unsigned long start, size_t len, struct list_head *uf,
 			 bool unlock);
+extern int do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		    struct mm_struct *mm, unsigned long start,
+		    unsigned long end, struct list_head *uf, bool unlock);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t,
 		     struct list_head *uf);
 extern int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior);
 
 #ifdef CONFIG_MMU
-extern int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
-			 unsigned long start, unsigned long end,
-			 struct list_head *uf, bool unlock);
 extern int __mm_populate(unsigned long addr, unsigned long len,
 			 int ignore_errors);
 static inline void mm_populate(unsigned long addr, unsigned long len)
diff --git a/ipc/shm.c b/ipc/shm.c
index 3e3071252dac..99564c870084 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1778,8 +1778,8 @@ long ksys_shmdt(char __user *shmaddr)
 			 */
 			file = vma->vm_file;
 			size = i_size_read(file_inode(vma->vm_file));
-			do_vma_munmap(&vmi, vma, vma->vm_start, vma->vm_end,
-				      NULL, false);
+			do_vmi_align_munmap(&vmi, vma, mm, vma->vm_start,
+					    vma->vm_end, NULL, false);
 			/*
 			 * We discovered the size of the shm segment, so
 			 * break out of here and fall through to the next
@@ -1803,8 +1803,8 @@ long ksys_shmdt(char __user *shmaddr)
 		if ((vma->vm_ops == &shm_vm_ops) &&
 		    ((vma->vm_start - addr)/PAGE_SIZE == vma->vm_pgoff) &&
 		    (vma->vm_file == file)) {
-			do_vma_munmap(&vmi, vma, vma->vm_start, vma->vm_end,
-				      NULL, false);
+			do_vmi_align_munmap(&vmi, vma, mm, vma->vm_start,
+					    vma->vm_end, NULL, false);
 		}
 
 		vma = vma_next(&vmi);
diff --git a/mm/mmap.c b/mm/mmap.c
index a32f545d3987..ca752317adef 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -269,11 +269,12 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 			goto out; /* mapping intersects with an existing non-brk vma. */
 		/*
 		 * mm->brk must be protected by write mmap_lock.
-		 * do_vma_munmap() will drop the lock on success,  so update it
-		 * before calling do_vma_munmap().
+		 * do_vmi_align_munmap() will drop the lock on success,  so
+		 * update it before calling do_vma_munmap().
 		 */
 		mm->brk = brk;
-		if (do_vma_munmap(&vmi, brkvma, newbrk, oldbrk, &uf, true))
+		if (do_vmi_align_munmap(&vmi, brkvma, mm, newbrk, oldbrk, &uf,
+					/* unlock = */ true))
 			goto out;
 
 		goto success_unlocked;
@@ -2865,7 +2866,7 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
  * Return: 0 on success and drops the lock if so directed, error and leaves the
  * lock held otherwise.
  */
-static int
+int
 do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
 		    unsigned long end, struct list_head *uf, bool unlock)
@@ -3348,30 +3349,6 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 	return ret;
 }
 
-/*
- * do_vma_munmap() - Unmap a full or partial vma.
- * @vmi: The vma iterator pointing at the vma
- * @vma: The first vma to be munmapped
- * @start: the start of the address to unmap
- * @end: The end of the address to unmap
- * @uf: The userfaultfd list_head
- * @unlock: Drop the lock on success
- *
- * unmaps a VMA mapping when the vma iterator is already in position.
- * Does not handle alignment.
- *
- * Return: 0 on success drops the lock of so directed, error on failure and will
- * still hold the lock.
- */
-int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		unsigned long start, unsigned long end, struct list_head *uf,
-		bool unlock)
-{
-	struct mm_struct *mm = vma->vm_mm;
-
-	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
-}
-
 /*
  * do_brk_flags() - Increase the brk vma if the flags match.
  * @vmi: The vma iterator
-- 
2.43.0


