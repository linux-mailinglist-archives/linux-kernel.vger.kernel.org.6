Return-Path: <linux-kernel+bounces-554387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E50A5971A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8874B188BF59
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E1922A4FC;
	Mon, 10 Mar 2025 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BZF76dbk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X6u2+g0U"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A8511CBA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741615837; cv=fail; b=lQbYo+lFGqRZgMgJVB+GAKTewiOn8PvosIQGQZmLhGKIZVAZmpmPVRmRWjb7mDclBMHjTOZmQgmt5t3rZS3r5YXGI5RjJY0QSVfCP3Kpm+kWCtDbY9en9RHfzGepWrNRh//tbToKT2bKAaKEfg7bMgKs6uU9offpXTvGonvmo6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741615837; c=relaxed/simple;
	bh=931vs9yzzjAxbb2ZGDUSnOaNpL5U11ujC8HDXeNPv8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G2wAy+zeu5yzf16Dsa+Cc++u4KozxNfOECkljqwSc2bHwKzsUxqo5DpVZMcKaqeip7gWN3bPK/UeE3xre4UHROqPazLoBVCYZgyqVtLaAqEy1Ne6IV53G7zwQeOoxqRV/t2rA+KVrTE8agMQpu7PtL6IuymyrMEvIgGBmVDnmrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BZF76dbk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X6u2+g0U; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52ADvsG8024952;
	Mon, 10 Mar 2025 14:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=PoK0szP9LMbkIMoOin
	BiVou/oHfHqeGGBtdWFEOw498=; b=BZF76dbkwejOArSbOn7JLyyAnZ95kNaL+/
	7Aq3yk8/dEM3UhqqRqOofYh/YJp8M/ju7gNu3dhrW/ViaXdTfPmYg7jMixlQH58L
	VPlA2ms98c6hWliHO+JWMUXLSY8BcsIdbNezILzw1UdPMqzd33fZ5pOumAs6PGFS
	kJUkICm/DHxjAj3R7kgBKwwOlrpmxew2dAcuwlG7Bs7xLpubqbaJExS5RdTuTJ/T
	Qb8EMz2HCnofR8vmPnh4dgJi98k6LGC+CNQA0S7PA6jSOm7D+7u9lrAex/PAIxf8
	ETLwt1PbPCNZmOCy+pWP/iuD4ap/qHHsg2PridjsNwUSkW12E/ZQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458ds9jmc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 14:10:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52ACrUUH022013;
	Mon, 10 Mar 2025 14:10:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 458cbe55rr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 14:10:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XnkS6yHz6yasNN0cmXxcBaCEapssnjzlif+H5tMMJcKT5ww50MN1Ktzf8GCutderzUHdstdPHCa05+q2uu+aWVWVlOmfQpB8FGgzdywxUY2L3MkyffcTjoNvs4ADIeFnN7s9k6K2q9UTNNTpmaIxJdpcipU4nRUUPY/z2ZHoeNjEUZD3wFEcjk9bGafCq2Pm2E/ubxmvPnn8iFjycl67I/4Z+3wARWKdxS9gyLI1VPELPQMkrPATjdfmtpbHijVRvlJc/n7Wn0qzzsiAc+kJlQsJRsAUBMhXBw+JeWulSzfKy5129RPFrNSUzIWA5UpQ8lnBKHfTN2mgWPu0BMyhZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoK0szP9LMbkIMoOinBiVou/oHfHqeGGBtdWFEOw498=;
 b=aIi3zPGzD+YOsY88BqDaYTkptUXjSbpm7tffkynd2yO4tNcaXsC4ayXtJ0BUaAMGivnvHKTGNJfqJwaHUppc3JDRAHdoJHKwvUDcCw9UPs+zB6UayLr/iwlX3jwmHcP2IZ+gTFP0oD3vql2fLPrMQ8YnSq0jBbUOEA2Wv1At703uZOuS+HPiOHBi0p3sz/cz2KF926FuxaPrZrlSpbxjqlGCU+JMokGlRlqsosMdQh0H6Z6a0ap6bmskw92lDL4KQL3uYQWjifEW6+rpHb81cvt4bppCciceydJ8tjQh4qiTETeKK2+TsrTMcuFyvDluXbo5713JRiX8cIdWnR7Ryw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoK0szP9LMbkIMoOinBiVou/oHfHqeGGBtdWFEOw498=;
 b=X6u2+g0UKALZArdzHc0BH9EvjCjEWNPIVgzOjOCsgPsWXylztoBnBVL3jv5B0jcJK9GqnHCe3oIZOxQ/uQ3gPlbEeVzQZJQQ0pWlVucaEfpsfuNqlm/5fkJ5wJcVtqgmUp+JSQZWx2O5JWQtJs2wzL1M+gG67BDet3zcNZChgzI=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by CY8PR10MB6491.namprd10.prod.outlook.com (2603:10b6:930:5d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 14:10:19 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Mon, 10 Mar 2025
 14:10:18 +0000
Date: Mon, 10 Mar 2025 14:10:15 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm: use ptep_get() instead of directly dereferencing
 pte_t*
Message-ID: <3157f1d4-7248-4268-90fd-62ef1d3cb868@lucifer.local>
References: <20250310140418.1737409-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310140418.1737409-1-ryan.roberts@arm.com>
X-ClientProxiedBy: LO4P123CA0077.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::10) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|CY8PR10MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d9f631d-af2d-41de-abe6-08dd5fdd49b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eo1ABweF0DZxT1umzD43Vjb/w/sBQ4YRrVHIdi9Kf6aIy08zpfMjRF4NJPEV?=
 =?us-ascii?Q?gIfMCW3vlrYIlNPArSUCwSUChpZm60VP9UORcbjB2fgo3bYD/Dhhhf5URt71?=
 =?us-ascii?Q?8IvkdzXoKl5QUdC/8K7Y/k9ilKNzvPvFOHv/STK6w8huhHWgYDsSOE5l87ch?=
 =?us-ascii?Q?pTu7EUMHqDwBK1JUKAh+LQV2e5iBiiOwI1bjXI343XHevl7zxIw5dPxnQOdU?=
 =?us-ascii?Q?IC9iOfL1JDYrNl8EAg3jYRmBKlOvVG70oEEkhikDbqHh5IYl3rxDI1YNN9Sb?=
 =?us-ascii?Q?dOWQcNYZkrvvcvwf6gZ27CMEufqCqwzQRpqQ678axeV50DfTa0oD0l23czXv?=
 =?us-ascii?Q?wQJhcFBSA/Syj9MDRHeMpZ0Irq7cAAW4XDkSSZqTTCdtH55hAoBxUyBHMNjc?=
 =?us-ascii?Q?gRp7SLrNZ24KfrACtTw7a0au1MIQj7+vjzFZVrMa6BGi2WHDCQWIm/ojpjin?=
 =?us-ascii?Q?LnXBBq+W6sZfk3vp25zgDVdlhbPYGC47g10IxnDqseon+2+csle7AWo2x/2J?=
 =?us-ascii?Q?NRRGS8KD9F4ZqqJ6PbIRzwCPh8M3bQwMPGTDuD+zuXZS3D3fmWNuE9iJue+9?=
 =?us-ascii?Q?CWOTFyvXiurd+BBTXPLSps2MC90p/zQwZLoTKOD9gZpp2/Zd+hfVq/Ayzvh3?=
 =?us-ascii?Q?6zGbhd06MpbS+ZHfTfA4ZAzLLnSMXzhAmNW1+b/YR4WJRqBL+CQtztdxxUxW?=
 =?us-ascii?Q?Xm+mp4gImG/cj2cqFcGUv4m5DJro8oRZ1HftsFrMbs5Bx7nNCfNlz7yscFp5?=
 =?us-ascii?Q?nIcXCRxk3Zk3glfEgeDjwRa5S8/5IS8WX3p6BgPwr/5uv7s785v/yIaaNS5J?=
 =?us-ascii?Q?6CvlzqCBhKsRm7fykA3HeVQ0f0Si8cNVBlqLmdryKLXRAPMVugQCJ911N57l?=
 =?us-ascii?Q?fje+o0vlJzggq7e6vZURoRF8AJMYbm4dh2Z9qvJsCzQ+jDRRWd61Pqu56vj7?=
 =?us-ascii?Q?dwxQi1GY1eQx6S8+KW7zbn7ffArm+gSRntC82KNRrcKke8T1jIfVSQSjEUm/?=
 =?us-ascii?Q?U+D85Ey1JskKhyA228O1OMUR5mrZkoEAUBkD8MbELSx/mc/zOqKzvAjgBXs1?=
 =?us-ascii?Q?MJR+Y7S5nC3DJeoXxo3MXrnejCdjfcVRsaDUgudt1g4mh/046R0EX/UQ9MDx?=
 =?us-ascii?Q?Opn+m6bvhLEQKq6k88/4xTlxDUOBOEDCDr/vdsR7odjBD6GSKZdtTjdzETgH?=
 =?us-ascii?Q?Gk+Egwq3cDHB3A7RpKwV5rrg8dmoolgY6/KOLTndu5/FbjH/IrI2557M3Crp?=
 =?us-ascii?Q?V2x5qM5vhkghdkILp0rUWt0hwBqOUYx7jniEwh2b+J30vLjtM/OmwJHdEvju?=
 =?us-ascii?Q?Eath50Omq8GlRvq3/Wba7Vy+WBEtwDJmVoXjdBV++xbX3wTAJTVfQC4HghSK?=
 =?us-ascii?Q?6Ddq7hJd8ae9QVarGjGYeFLpDzI6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/goiO7H8udyCQ59AYq7FOgtztFj0r7ud6KfG5C+156m4Qu3hEhwph2ie/Nqz?=
 =?us-ascii?Q?/2Z3yJzmkeMDGCQxry1vvO+SBU9sqyebq4USWpZMSvJxIOY9dwFHPDHG5T+U?=
 =?us-ascii?Q?NXEA0FHeoUPlSqdGuVxjMUq3gP2vLAN4wme3Mth6b9aoqDxNMDUtZmFWQ4gw?=
 =?us-ascii?Q?G4KB1zJ04nvqDNhkT7bzSkern2CCSEEXc3RolZ9y5gzj2gAhYnwqiW5zx6bk?=
 =?us-ascii?Q?gBC7cAj4xvjMRyDaWhaGZy0HzOaPoUx2aZ2uhhGnGv4mP1lwZDjbVEe+Zfs8?=
 =?us-ascii?Q?ogy1eHKoyWsxb3ToB6Za/RJ0zPCDJvtMhKBGA/zC6jYFe+xLc/ZCiLg7GEQm?=
 =?us-ascii?Q?xn3jFr05Jx7XGNdbQG+9ueMhUBazokeZYFLZIjBoFKTrDADGVrpT6yr+XnQR?=
 =?us-ascii?Q?6t9MQuTXa1RJOUoFF0w1BwvWTnF7OYNbzriGbYU/20euqMySXmzS7tY5X2Su?=
 =?us-ascii?Q?3RLzUdHoTPRSQYdYwK4fF5fd8UM5wVlvtLc7CqQHU37oaUUIpYdfaf3P0GAw?=
 =?us-ascii?Q?vgX9vQFMlmVz8439/oc61ZhPBnbGqzePp5pmYFzdh1mPZfS4wUeK0xQoeLRQ?=
 =?us-ascii?Q?wwhvGqzh+l9+rnP/0cQyplaMMMaejQYkxwiiFBwsdG6NtQzmA3gV5FjjoIFt?=
 =?us-ascii?Q?6dOQmZ01qiu0c4H+2ALkX6Ccwk46cUaIQBC/G3cHGiYWjI6JbXVEPMcga+mT?=
 =?us-ascii?Q?ESaNrcFilWsfPhWGwuMjzVCSso7KkSjPxIrJHhKIzGF74iRnweOHlkE7UINU?=
 =?us-ascii?Q?cyH7eDWn9DA0O5tVjLZkZiRfYf8WYWL2TiyDHurVNPVpN+7wD8zd0gU1TBZQ?=
 =?us-ascii?Q?Pg+7uZLMUTn2blD0T/6jHg6pLNnVKNjc4BAvn3p1iMLU9OTqnBjy0N2Hgh4c?=
 =?us-ascii?Q?fffEdH1Ghp9V03dvwKxDG+/n6fXlZ8hxAeGTdKhM43NWaOgi7nkJcQtDEm1C?=
 =?us-ascii?Q?MW+OJ3wdRhdk8D0T7Xb5YiUeCSd483tfvPOYyphwW0xJZQmfkcKEenq7BdVf?=
 =?us-ascii?Q?g3knIPumST06Hw5Ev34sh/RbVaqCPz1mNRFeXnqfKvUM1HRNANToWUTw1dXp?=
 =?us-ascii?Q?EeARHrfoGvxZpKSbl/ynckYrkTeEqDnJDSnADS5PVXTP4tRoerD/NRPf5bw2?=
 =?us-ascii?Q?cpnT6cCkJ+yZClqXt3my7GJE/nAATzkVgfwGaJHs2ebjeRxuKrkU/DfjKcmf?=
 =?us-ascii?Q?1mYiaWFH56IrKXUz9+3LTdqySZaOP5eMfMFDXeDj2hdrVjbrpZDGyou890oy?=
 =?us-ascii?Q?N/69EgB/oMRDB8GvYv8r3VRINFacDj8f/qGEJIr9pNlUFoYsIaNl2pva6GBB?=
 =?us-ascii?Q?iyf81a0CXbupSegh8eKM0PGw5he+CtFMCwmvnic2qpom2rw3yWBgMSgUcYih?=
 =?us-ascii?Q?tyR6ZgyniyjaJMQ/t30NILylJsWWmPe9Q3ijfGcEe8NPfCzgmIlLqORgjWei?=
 =?us-ascii?Q?0/TG3/zg8GtLw3tYOuK27gmIuawH2KurFk+HDzQQQ/O96jCE6CpFtKmCbQ3T?=
 =?us-ascii?Q?AW9mMEhf3CS/zlVxnZnuY9d52Fw94d9xY1c2g1IOx+ppDBskoOs4jUPt/WdO?=
 =?us-ascii?Q?eY1tvfr55LeAjr/tA6vN9vY68gS+jrvfFlHyhN9xAD2fdBbawEsWrnLhhE7b?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OVKYB4d8hv412GhM7oR5ckOr3LzGx6XHUiH3IWRrNH3SlIbD5m0lCv/0JJJ2y4TALyWLFoTLLg9f5nnW/J9ap/9z9l8z2jTn99Nr0IxVHSQk4x9e4Kdvyx9y5wRE595id9c4GBrAuhSbpurZG467AWuLGvfHpYjhtKXbmzU/XuL+yvSvkq03cwKa8npWTN5uIqyy2ZJvvJU0m3hYoIIE7iOTgUBmoCD4vgDpRrcfgT7+n2ci96JdvucYxGsixAWJRTLU8+hv+iRph5hgKDbLGT8ngqDRwTLtK5jFfgZq9bahu3ubePMyNPIWrp1wWWTbNH36Ds1iF/9ET4krlczJTGKSN6T41R2Z8J8kGVDpyDhxQ21Jh3T5BlNFr9sXEc14b84m3dm52tpSOJjlUa8eCAo6aSOh2FpmJ+oOL3YE90vx1IlzocLJ/orPvz3R9TPvg57JLbMnBOWh1P9D7YvY4/fztab98pcd7O1wK1tRXiyN+eDvijLTYJA6xB06xJI/ynFalAxH20MjZyqEsQ6jUoInHeUo+MLc6jqJfYlkYfUlrxIx8eqCa3gdcJs4vUIlNeS2uRZ4uVqHwhed29rD+Pi6+YzH1KkfM3plE/9EZrk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9f631d-af2d-41de-abe6-08dd5fdd49b4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 14:10:18.6993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+riG0W5WFe+mv9Q6wXseXgV0XNW4ZaOlyB+9HGJpBSqph3JlO+LPvnnNpGl9FmamtlZUnAyFNaBiXefWsflK/iBi9/X1FDd4oqS4qbzYdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6491
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_05,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=653 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503100111
X-Proofpoint-GUID: X8Qs7SWkgrNYX2iyC9LcqaMtOACv3w9w
X-Proofpoint-ORIG-GUID: X8Qs7SWkgrNYX2iyC9LcqaMtOACv3w9w

On Mon, Mar 10, 2025 at 02:04:17PM +0000, Ryan Roberts wrote:
> It is best practice for all pte accesses to go via the arch helpers, to
> ensure non-torn values and to allow the arch to intervene where needed
> (contpte for arm64 for example). While in this case it was probably safe
> to directly dereference, let's tidy it up for consistency.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/migrate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 22e270f727ed..33a22c2d6b20 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -202,7 +202,7 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
>  		return false;
>  	VM_BUG_ON_PAGE(!PageAnon(page), page);
>  	VM_BUG_ON_PAGE(!PageLocked(page), page);
> -	VM_BUG_ON_PAGE(pte_present(*pvmw->pte), page);
> +	VM_BUG_ON_PAGE(pte_present(ptep_get(pvmw->pte)), page);
>
>  	if (folio_test_mlocked(folio) || (pvmw->vma->vm_flags & VM_LOCKED) ||
>  	    mm_forbids_zeropage(pvmw->vma->vm_mm))
> --
> 2.43.0
>

