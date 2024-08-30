Return-Path: <linux-kernel+bounces-308013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2356B96561D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48D061C22208
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF3A1531E3;
	Fri, 30 Aug 2024 04:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eoBxXIZf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B2CnrSi7"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0693F1509A4
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724990506; cv=fail; b=tf3Ae9pAgVBuuNmlQpTZ4IVIuq4AJsVx692lADvIrk5J32juWzjNVGjW+LteDwg1XxN4MEhCJZuafhuWz+GITWxQxAyD6C93XOsn2Nm87ISk975YhKWWWV1JY62mry818DMa1lZq5NumHaX5cvY0EQWou6UWC/BWKZgrQWvnapY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724990506; c=relaxed/simple;
	bh=Lv5IqTv657WMoUM1LrRo1p2rMr9JlujI07haZKG2JE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N+ek9MIRdXcrq+Wh1S3kF2Ug3MZHftys1jicMuzun4Z3TfL2pHJYYOPtIIeN1UtU4vfs+QCixBP/NtUl+JmNqgNprB3YW1XOi3wOml9YPa3exirb7IUfdz6r8DhxmUKOeBqx/fH3ftUqb4abFs9kMsPIOOkVrTgQDKB1325CKSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eoBxXIZf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B2CnrSi7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U2sFnH011046;
	Fri, 30 Aug 2024 04:01:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=qcbtKtfIxq4olm/b689TGnAJiG25veUzjpPHk8GV7Ec=; b=
	eoBxXIZfHcLuq7W3rWNDhOgTbnFGo4zguWfSQvMlKFSs0j+55041evrF4SOG3am0
	l8qvOlPOq/v5e2QTPXCryMlr1PamROtbRfO6AOwciXai5QTgR0zsyQpG4TRWaub4
	wP3hvGQMDWh+FJy1iMwkO/s8YaI2IBba66BDd87z6QaBezN3ITHHoxzr4C4KHiCB
	uaoCzljkFTvfiKks+5apaBozc6rNLlLZkjVQKohKx6hkhjsfVx5oh6aww7SoTlma
	EY/LDx5nYwb+3AX5jtEqJvyDWUJIRSGN7cPEvewK9WU5aBObyyH6a7AbJNR1reAn
	DpOa7ajyagMydKGKnaYdpg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41b5q3r1v0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47U3jJaO036502;
	Fri, 30 Aug 2024 04:01:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4189jp2swm-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIS22csqf24vqBmp0XwHNmP2GScSXJGudmDOWN0n8qlLzOAOo5wfq4aIr4vnerYwPBTkKqHqEH0WoNh/F6yBjIqKoRgGnCa28U37irbwRwWJF96BUX6LvuisENAF+TIvfVR3G43LPiJJpEzGa6X0lGfWz5azaOHUS06vvc9Vil74CsHkkIiJB4xHZTCa/Hblz9DE9vZ6tUr2SbdOKK4O2SsWJJWOyzKP7Rk7wXKcbDnMrkB9xdlGtqOGaxQvwJZ0PebVGVPI+B9RogHoZZer+BqlQoy0XgZAm3ymKFL+fpQ0rSjDrc6jICbrZoqrEXoLGZ1hs/yfdkZdQJU7sTIHMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcbtKtfIxq4olm/b689TGnAJiG25veUzjpPHk8GV7Ec=;
 b=VnejNvfIdChqt2PflrIXlm+3osTIrlqoeWG4GyUwaLqr8VwQ6snGf9S+Zda5hNJ+GSbSEXaJYqPuOesNwluC/XPEOx0rANvo7Kp77Rd2HaoVXEaEWq2Mikw/45QhRVcKDMeJNk5ouNnvpStfAVX6TMWTd06AG9A1nTycAfT9QpYzkjkb54rXI57vvD5KzqcqKPzBuyF2JgPDW5p96G5YKYpriYc+H40CSlPrjt0x3+lCLos3ksvRDU7duv4v+VvkyJUP+/H7dVOZNOHDL3ln8GwBVKwJDxj14md62aDhOfsugPZkKvVbViWt4umi0dkqSm9bhn9kztUKzdsbFN3/Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcbtKtfIxq4olm/b689TGnAJiG25veUzjpPHk8GV7Ec=;
 b=B2CnrSi70A9iRAQGEXQ9TxxBBZWuGkpKKzMoNqE5jD0YMiBpuXl3HbO4ZlqPdMLu1iIC4XdKbcJYwGSNnkGs+loT7wqRNP/gnLq1qa2ZlVpy2jIURj7mTl4siWFxSO1Pux8pDi7ITQ94jbXJTlwr7Np5m0ULugyKbU9EQcN7khc=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CYXPR10MB7949.namprd10.prod.outlook.com (2603:10b6:930:e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 04:01:24 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 04:01:22 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v8 07/21] mm/vma: Extract validate_mm() from vma_complete()
Date: Fri, 30 Aug 2024 00:00:47 -0400
Message-ID: <20240830040101.822209-8-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830040101.822209-1-Liam.Howlett@oracle.com>
References: <20240830040101.822209-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0402.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::14) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CYXPR10MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: e5e05b30-d771-43b5-afa1-08dcc8a8692e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rQqyJZVIXPgM6TH+KynG6OgYB/M9gS+5JZXq9NYRIFmzzlVXsy8JNxR03g2k?=
 =?us-ascii?Q?bfefrfVSrtTQIdNsiZ7+pxyMf4KsaWuZOf4JsHYLBBGZtDyEOf96tfKF54Ah?=
 =?us-ascii?Q?xk1PXEP2fif1TyaeOVpdiDUbXv/wYNSLiR0qLOPCB8B6/uqo+VKh7G5Ya5Uo?=
 =?us-ascii?Q?CLmyDE0eCtdBsDyzQx1d9g0H9JrFeaByhFJKP4dyCtOc55KSYLX7Ca2Pltk/?=
 =?us-ascii?Q?yRzo9yFlr60L9SYDkhh+yiPaO46qYuL1o9HrUzKaQ50xjoCwwYISiRMgAplw?=
 =?us-ascii?Q?++g0jSE7zn76uShbLmQPcN+gSQRzhmKYDBQ8/j1QmXOLE6QAVW9PK2MzUlmf?=
 =?us-ascii?Q?PqiuYrdpvhPmmsC9IqlF5/0q6ejGjlH7dIvzknCL5ijE9uWTpGgPbQSwKbld?=
 =?us-ascii?Q?uZBUSTPKBykDPC/YP6Xy6RqePxm2BjTOjcdoCx8SWGxeJjS8zwwfaXHpoA6k?=
 =?us-ascii?Q?s8u4nRNj9ojbOhHmwqzExlzvC+RHY3JD8pMef53Dog4fMoGDSf9HM9MXMobg?=
 =?us-ascii?Q?pJxU1x1yVJl6rjPulrgpH8534/U9ctHmMTb4dupQWuUxgWewiH/EJ3wJmT6G?=
 =?us-ascii?Q?p6ZxNfkEP8t3IhJUkyuEd1KEj6mFLU2+T/D49oBd6zgJ/g2RWjZZnYEyVcdX?=
 =?us-ascii?Q?xVonSlmSB6tZZfrMZsa7o5yYk3G6vRCr/RE6cgveGdRwQCZ/B5uUgRllCpO5?=
 =?us-ascii?Q?77X+XABZkbXrT8hLanxPYxKXV2KTY2hn4uB9SHsjFAsHjP3nkXqyiRSSlMp8?=
 =?us-ascii?Q?ZFxPjcejCNpluXkKBy+gdABxh1H2f7PLC3U1q55+w6GfOkyR3Ct7cTeyW/LC?=
 =?us-ascii?Q?fZRKJ4gDOM7O1weDW2LilHZUtFCeA00aTLLCHDhy06+zQF17qShYadMVvOno?=
 =?us-ascii?Q?m8h3aO2EmqK+F9SVrjXpc5kUJxUIvBs0uxZ50D/nwVNKD8qXPE4MgPff+8qQ?=
 =?us-ascii?Q?EhbgBqHaAgYzM+o0UeUE3PPa4jy1OiDw6BYZXxFd2z2opdBFowkWiLNdJ90c?=
 =?us-ascii?Q?Vv+GAPUSAz4/3kE4Z3LuGelUuCbW+sAH3Z/n4yV7OsR5RJA9WybvFyvu+TMA?=
 =?us-ascii?Q?5aItU05cEwGP7qt2rmTZwGY9hXBkPH0JYuklyBKI39eAQi4bh0VeHzhSQlv0?=
 =?us-ascii?Q?ctKj1wzCipffCtVDBCMlX5/TVCfq//BKkivDUHhvdACimD3sGcHAxK+PFfZs?=
 =?us-ascii?Q?/2xAHYRZK2Um1829zr1/ZDclm1kvZiQgrFKf4ZeZEgjBjDhzygNhn0LOX61C?=
 =?us-ascii?Q?t4JVqQkRGGMNIDSCRWSgE01ogJkuF8DHGqx7A/Tm9rhoZ7Xyxvc2C1GL2ytQ?=
 =?us-ascii?Q?Yev67k+avgkspax4+wSRUmvso6JcKfE/lqd5XLigk5gvVg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HeDzGEHBtRS5CSGEOnjyA81AKQJTqe07S+iaINz32liLZYQlaUjyLQRlljhw?=
 =?us-ascii?Q?8To9H35+uZEd6cz26Ak4bHnqz0hHQXryDi62kUWwURgfjMZ7UHoUYW3WvIMF?=
 =?us-ascii?Q?iR/R9WS7sIwmBC9F35JgXrjbNsMJxjKjVEruuSi1VDszSoD9CCgx5BxWpcS4?=
 =?us-ascii?Q?ouWRm+EcIX9FVFrtnW/nrMjtFMmeTD6RC46gbIbz2j4SycWYtqjhIaiRhfFn?=
 =?us-ascii?Q?559CpMQHTW1sxSySV9cs1uLeJas1YJefGn2HmBU1Mt5BucLdxGcN+TKcgJS8?=
 =?us-ascii?Q?WgzIhBaEy1Z6RKbVSVw3pKIwBAQdV6UwexHgDLyDKGT/Zi4KLaoHDN/ZwGby?=
 =?us-ascii?Q?dMU4ov1vMkI0RfNbqU/MF6BZgMflrSbXqjsilKS3R8Xz/4rBLMTPSI4vtfb8?=
 =?us-ascii?Q?flUBu4rQZWOL8Pg9FSp4h8qI5YZFIruE0Ugz+FgyM1LhLPwXwETvMfRFoJdu?=
 =?us-ascii?Q?YN6whP6EkDDe392/sgn2hRlNY6/fElAzIXR6CjyoDifCYLCbktZSjaAsFD+x?=
 =?us-ascii?Q?tEwdrBK+WX+oNW8zbdDDp9W5B++smKZfPnLNaApMEbCR3Iv8ahV0D+tKxiDK?=
 =?us-ascii?Q?a+RT72jHO2I8HPAWEzyZq6d5qjGbYC8sB+5xvaASA4y9SYGZxauLZqtv2Cf/?=
 =?us-ascii?Q?+whaUHb3QF5hgc5U/3m4q5ITZsADUyO18vqtO5Fp41wv6m0Q3jL+UgjUU82K?=
 =?us-ascii?Q?DPnGVFa0AVWaPTAG9QbhxvF55fDIBv0mpY2DByrFsnex5swMfCntZHyZ23Er?=
 =?us-ascii?Q?zPzhIyOAENZhNcynp/eVMn3wjo2bdxM11kEWP3zqO4dXPpQbWUR8EBjgll/T?=
 =?us-ascii?Q?+lOxkPQuvtO/R8ULTm3ZjeQrbiXb91OKiWI+as+hl+YrIRCevTCYquz+xWrH?=
 =?us-ascii?Q?h6UvP3n5reV8KBqCZUFDrkO3PtYn65vvUKIaDVxaGsj6XAqP2b/oss5Fw4lp?=
 =?us-ascii?Q?Za7YjJfv8JOMyXJn1X+9ZCeQ2CqsW8Ib6lJCNL3JrpoO73YA2/MiN/Pn5k/o?=
 =?us-ascii?Q?1hoBOjRiwx5z4w+xnz+gyDU4yRPPJS55rGP/Qp5e4V7g+jiMF0J9+IKeKq9R?=
 =?us-ascii?Q?SsnM+v1Et2J5G0C3GjJ2suX2dQGSHH6+fR9R8LmsbZ979+/Db19xFNEydAuC?=
 =?us-ascii?Q?weDeHxkdoLqNhMNtFYA18+if4xlw7miHXyuNRE327F6oB7e+73AhE/1as5w4?=
 =?us-ascii?Q?TWRWEAUBa+fCMLAg0iNdheRLCptfpj2U7uBTgo2i0fA6DlaMqrb7g9LXmj70?=
 =?us-ascii?Q?LBbhEHNxJKfvimW5sROVdwi9KL4G1Wm3Abk7ls8y5qdKBVG2r5upOpvXWNOi?=
 =?us-ascii?Q?JsgZN5LqvqWtDA0f/OTO8axaCJLPIw32flxRK0z11EDfq8S+2vaLbFIepkbs?=
 =?us-ascii?Q?j/NvRXpZus7iaU6R82nlCh7hUA7oc95YZebFodaByk4cbv9vOjdy0LPsxT04?=
 =?us-ascii?Q?AOvwYIQZ7U7NU8bG80oM67qKXSWeLKS8laf+RKAAk545MA9YuGpVfXFk2ajT?=
 =?us-ascii?Q?t1w7DCNXRTdopip+8iCnP/rRdm4GPRKmVctDvBLEWK06//60HMfBiPxfDWtl?=
 =?us-ascii?Q?vxOAI/z4PPYzP5VekURdHgs38JlvdT6/o+JyzWBw89Np/5WxsjC4ozoG9P7X?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Q1ow38rR//SOixmVX3pbBmvhugsRWBarg3Jks0zgyAVIQ8YOvo90Gy8mYHMUAkws/LGnoWb3amN6ZBi3Y9lBhzkoBW5dlk6PkLGAzLY4lEKwKLwqK0MU/8Dg6VWMb4EJ39tgTmzV8mJeymgmaBDUWpMhl0blZU7xjx9A4vKNUKwjGGXgWdZkFeUvlJGK8DfeGSTfA3U7/MCaxh7d+c3fRckgI0LVt3j9oKBVQ1E6THV/oemG17JFnefZZWAxlQTxY27PW4KLZTy/kFv2RV3Utig6Ial8yTstQw2QDlGDNdVpIQ8As8ty6xTxTWSy2euzwWmv6H6nJjKWZiMVvIzpaMoFlhysd0Fmuepw3ruEzjtQzEhZg2F5SSZ9gRP915b4wIK6sLsX0RUUazcDNwtXKgVbyBGlCMborQr/EbsyrEOImffAdZPftNf04wV5lwRom1iiloO+5XsE2PxlycdjGRRxdP81Sh2bZIHmtEeuL95GiCytckEh2doJi2Jp8ZZIyZtElx7c0e6w/1G5/L3rXxfag+X7OVolvQgXjDxJJsrFw50ZsOAJvtPvyRsj6k5HmosVWOyxVnpNuGL9vOraZtrCpp4GpXXCWAKmovvVxaU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e05b30-d771-43b5-afa1-08dcc8a8692e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 04:01:22.5751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 20Yh91gk6me1Rd6JJmRz1mu8iqPQStn8jo69ykN/m5PoxtWYDl55Zj1BMi4SIaJrVPJodpEbmFBGg48SRO255w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7949
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300028
X-Proofpoint-GUID: aVRmbWihzATOceYqtw-yMmMBmxgWFjMU
X-Proofpoint-ORIG-GUID: aVRmbWihzATOceYqtw-yMmMBmxgWFjMU

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

vma_complete() will need to be called during an unsafe time to call
validate_mm().  Extract the call in all places now so that only one
location can be modified in the next change.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 1 +
 mm/vma.c  | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 548bc45a27bf..dce1cc74ecdb 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1796,6 +1796,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		vma_iter_store(vmi, vma);
 
 		vma_complete(&vp, vmi, mm);
+		validate_mm(mm);
 		khugepaged_enter_vma(vma, flags);
 		goto out;
 	}
diff --git a/mm/vma.c b/mm/vma.c
index 6d042cd46cdb..4e08c1654bdd 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -269,6 +269,7 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 	/* vma_complete stores the new vma */
 	vma_complete(&vp, vmi, vma->vm_mm);
+	validate_mm(vma->vm_mm);
 
 	/* Success. */
 	if (new_below)
@@ -548,6 +549,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma_iter_store(vmi, vma);
 
 	vma_complete(&vp, vmi, vma->vm_mm);
+	validate_mm(vma->vm_mm);
 	return 0;
 
 nomem:
@@ -589,6 +591,7 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma_iter_clear(vmi);
 	vma_set_range(vma, start, end, pgoff);
 	vma_complete(&vp, vmi, vma->vm_mm);
+	validate_mm(vma->vm_mm);
 	return 0;
 }
 
@@ -668,7 +671,6 @@ void vma_complete(struct vma_prepare *vp,
 	}
 	if (vp->insert && vp->file)
 		uprobe_mmap(vp->insert);
-	validate_mm(mm);
 }
 
 /*
@@ -1197,6 +1199,7 @@ static struct vm_area_struct
 	}
 
 	vma_complete(&vp, vmi, mm);
+	validate_mm(mm);
 	khugepaged_enter_vma(res, vm_flags);
 	return res;
 
-- 
2.43.0


