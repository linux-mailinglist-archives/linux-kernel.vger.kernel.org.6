Return-Path: <linux-kernel+bounces-572023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4929BA6C589
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3878B4865FB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB73233149;
	Fri, 21 Mar 2025 21:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EiP4urQ4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Rm/Q/J96"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65094233D91
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 21:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742594115; cv=fail; b=P7fgqAN81YhbkmgYBefvKkVOe3BqE7pNjQU0TitZOJjPa7WGa6TAfE3zxX6Qxp1h5JPQvfTEsnFknD8CH2WzKu53evK90MLZf92uLKId9tSVHE568mRrmWuvc1QFfgU3cvE8uu3+7MVhf28UE/irAUa5YgaYQS3MMDg6iNtohrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742594115; c=relaxed/simple;
	bh=sDGqOgNERH9zwularw4OMKRjmyp+m9EbMfoZjwqIKPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vm1jmiQmELu4dc7Jzh5bZkzjGbEV45QmxOw7kBkwhVoZx+RLi/TXfiCh8rd7RMC6OfDQ4uIn/T8DN8fYGm6qcY8pnnVDvuYhpAAAxGDQ2EqkQ8DPM+72M1VaD3OSQJD/f3vYEWNAifAwAJCBhgK+FX67HRX0B95vAmSfNhuyYbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EiP4urQ4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Rm/Q/J96; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LKft0G021302;
	Fri, 21 Mar 2025 21:55:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=R3VQ2JKT075yM5Mu8/gj6ahdUavobj6twKvRFNDdQMQ=; b=
	EiP4urQ4ji/nvHR9OSshYivsMEsXLej90114NV9q0EjGY5HkeXgUdmBHGAp2oh2+
	85hqTjirH9OI4WjCeIbnn/UpQ+ufm6AXkac5srSb6rSAS0/qeWagmr2+Mf+tifOv
	fdJeQYuMyhXWlulAIriBJp2nsWcGc1f97faxjb9WlJRBXVsj7CSsHaYkIgNiyhie
	AtxIiO8E9mBNFwdB0aZZECI3r9DFypg/KWUZSEGHBQkx0Dwm2WcWn5KGZgDCKD+/
	LZGOBy8k70jeVWv8CR1uHM8PVUNcLA0suZrDYjJba6Bqmh9zGcF1bj3mDsz6ecrI
	CaFkJRiDzAVqAzKyq/HCgQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1n8sgb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 21:55:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52LKZM4R022350;
	Fri, 21 Mar 2025 21:54:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxem9n0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 21:54:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHHgGA3t73IirT1GXWXC9x4ALCxR8p2lyzQrhqZJJP6VND2hmXDvQG0WtwbPyM1WBY7RntXWvvQ7z+bhAgD1s47kSNrt/MZjBCNsYq4SE4VL0IUxUQyoGc179bveWL7CZiU/eNX+lquisbmShMQdBBSx0ff8QN9WLIhGIUZrNSWNFZl5XRBpNIihapk6yisfH0ExttlNYFsjQAAv1yuDBMj2B8Nb8umnxYJMK+OCX6DiELwlbB4HJ4s6tHPFD+NZ9wCNs8eTS+82/28fxHFNcrItreH6KO7WmPwdZ1AeXvWc+AoGYy0W16hyLM2wEohbNdVQTIwwni/KZnTuKK24fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3VQ2JKT075yM5Mu8/gj6ahdUavobj6twKvRFNDdQMQ=;
 b=AFSd+pJVod0P50B8uCS600AdkA14/gjdsXzBkhlJJBLFfoyG7bz3wjGhG03HnNp7PzAi+ofiNYVsa+uCzNGrWdCuotR0qoGWV122AeIyH/3kPVEKUWioyToA5OJca6QWbyp52jDcQf3uW4CNhlnlCvbtLf+7oyYs83XPY23nUe4YgLQonU1xyM+D9OazcmGQV9y6+cQL5nuidvbnaNhg/qGf6sbl4W7ANvVBfjw9/MjKaHtSadqM4Yiei6jfKlX0Zpi+0atG1wN0MzEiJ0KJ6Lmt6QQlCmJdcZUYvTjuF81hiZl1q8iwGnA4V1N82yMX8bM/8MRszCR0rRB5EfBmxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3VQ2JKT075yM5Mu8/gj6ahdUavobj6twKvRFNDdQMQ=;
 b=Rm/Q/J96gxfCfeC13e4E+akdDEgnS9PY+Afdt9ei8wXK37+K1YzWlM3Md+CvjPtrIuS97ZXHzQchFXB8RXLX+S3mnkyS0xXUtVVgBi7X3mUHyVhlczaNXTdT5qziTZildJo5+ysh4gXbDN+yM5vjpPsSj/XxPz8wGaV1QP11i5M=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY5PR10MB6144.namprd10.prod.outlook.com (2603:10b6:930:34::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 21:54:57 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 21:54:57 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 6/7] tools/testing/selftests: add MREMAP_RELOCATE_ANON merge test cases
Date: Fri, 21 Mar 2025 21:54:35 +0000
Message-ID: <8b82838696e93d97161af4f62f9f01dc9981ec7f.1742478846.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742478846.git.lorenzo.stoakes@oracle.com>
References: <cover.1742478846.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0296.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY5PR10MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: d82af179-a55f-4735-273f-08dd68c304ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cR7QUkOC5O12EGrlgvkCXn6lXhydVkAif5YKX9MKD2gu+E+gI3aRAifrgx1b?=
 =?us-ascii?Q?wmaNqVlr2u/b2vxDrQSovrZcllncdXM/SQYv8ioWmbbiXpGxha/OwXUj6+MB?=
 =?us-ascii?Q?e7LrO5kgaUmzJU3aQgRVPUgTrMZdzU7GxZNwc24W70icM3cCttkcfiFYySwO?=
 =?us-ascii?Q?tTyDiHWd3z+0PhOpeoE5DsGhS+lw1VprTzqBN7nbbO0sbaM0nK50tOubZcU6?=
 =?us-ascii?Q?DuTtmK/I3ZQLjGEHyMR9VSIsiz0GLqItmSutNC2iLpDul0l3aumsMBdlSl6w?=
 =?us-ascii?Q?E1N02nTfLCjFUongtnpieJdkFMHGdM2gmh9nyiYcN5ogVAKzzclQ7vPu5aTo?=
 =?us-ascii?Q?4Xey0Cxs8q2TtrguHkSGJUBDiOW73GcnwjpjlmE8GgHjKX6FIlERs+QwFQo3?=
 =?us-ascii?Q?9Ei9xKlhGPBCx7OrBNfpHjkU8Iv/fzYHE1Lzb0KPlndpzAOYJzii6+0Pthnt?=
 =?us-ascii?Q?zEn5kF7cHUsGc8vyhVfMZDnzp67WqHzAbuZplRriVXL6ORAOLWaDpoVx9rzU?=
 =?us-ascii?Q?0+SLYLvdCCSjPvivez2b+Kvpz0H9g55rD6OP+3OT6rEqEuZOAlqvWUDC/NaR?=
 =?us-ascii?Q?O7C9H6fFhL8SJ9fNfblklUzUnx/s64Wt0bVkHYKmWvzVd0GnjKZAvWuwRdsj?=
 =?us-ascii?Q?CqKeGJBkeYmUK2Ca9jsvGvCt9OYO8Qe+4RGFYm2aH/XGtZSoCnMgxptdpMwK?=
 =?us-ascii?Q?crC7rY079oFAr2lgxbjWUkNhHJAYamFFRk2mQSohGjOYGPEU7YMz9b25Jk/O?=
 =?us-ascii?Q?Y3BPnj+cCge1idckl+o70AzLbdbJwmZJsdnl+R998gZvXfUZ2N72nZvQV0Q4?=
 =?us-ascii?Q?PyRHrUeUqhCgbgLU6vpZEIb/PsPk0mfe5/e7PnMYe9JRp4kjAOvPaxCLDOci?=
 =?us-ascii?Q?b/QNHHFh5x3RikQE6mVIJ/NUbug0SwRIQRCFsT6KRsrkjnU6mdhXBjEp5pSi?=
 =?us-ascii?Q?ATMOqAYDGbGBbimaruUQZV0WNDCjpqLVd9JBoGWlQyfbjzzbYanr/Bi4Z2PZ?=
 =?us-ascii?Q?2ERxL9PVzMPkuaoTQZqOGm0U7mLOz2ZGDMsnuFIajvwUUmEjTp+Hphj40P86?=
 =?us-ascii?Q?EdyY8kCIQr6BZwN/CbWAVDRaVo0zNYxEobKuGson+LS/kin0k27s4S1B+4J5?=
 =?us-ascii?Q?V75m9jkMAy0XyyUFzKnkIDF961j76um36dZSzV7mrPy1vctbFLNOXXDTDAC6?=
 =?us-ascii?Q?oF570GYBlDgve8VB6hYItScaCXlcyyp43ZyOpm6Hv02XW661n9P/Ho/EW1m4?=
 =?us-ascii?Q?z//kyCva301Hs+CZnCCo/vR2TYos0C5hoDWf4NFuQzxX6nrTCmVuQBWNjHTt?=
 =?us-ascii?Q?EpksjV91DMT3fPaUnGJkAdZBtN4YHp9CRjumt9R5Mtp7F9TCel3v7/bUGEeL?=
 =?us-ascii?Q?EkOjQS0nkbN7Eyv8FJNSw8kvRAQ5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ox2Ak00aE9SCo5vqyV5nHHMsQm5XIQCQF4AN8BN0u7zddr8QI0QJ0th78MJG?=
 =?us-ascii?Q?AhpF5fjJwkPhZcHG57tAwJuz8LLqRgbjy3xpMiF4AMx1cqhRQc9HHpQIab55?=
 =?us-ascii?Q?fqYRDj4TVyE/25eV9SuFoHmLZ+sQ3aANyKxKYcz3yHojWhWsiUuhiyQGGYTE?=
 =?us-ascii?Q?CXx475Jm5v41SlmsrvCaBcmdt2DxYkT+B3PIvW45DBJeupd6lg6woTEjVcP3?=
 =?us-ascii?Q?0IZwxGOb8PCYMxVPkR2N7lpD6cznPzq19T/ud9k6Q/BFUcVQw8MAJY2GJ8QI?=
 =?us-ascii?Q?oXOL9+uXBBCHQQ/6b7P8Dqkoa4dUOTlAYWcTJ1E70oCDLeCsVHmKu/kX/SRz?=
 =?us-ascii?Q?tGU3CgUSniirkbJDOe9gSvIQgyIaYgHaep1YmvK2TyPe34s9dWSmB2sI7T0j?=
 =?us-ascii?Q?u8TN8+60Yo80RyQZCoM58Q0VEhURS/w+y8xBYY2ThxYEgFd3WkS9tYTGxPZj?=
 =?us-ascii?Q?15Lxf6TW3NH03DLWLcuozFj/75z0C3g29/TxF85njDC9+Fm+IWO3uV4i+9Kr?=
 =?us-ascii?Q?NzPC1U1Q0WuLU4IwLNd/aVNoWM9/cHS4n+4in3ZGHXQZYwUg4vSuLR4TkV1e?=
 =?us-ascii?Q?47UpRGt9jt2yEvDk/IllHHRynxYt+pEhfBIQLCKo7GDCAaIL4rb9bKJEnFLP?=
 =?us-ascii?Q?JFK3yJdYSRnv4oYVN8pfZf6TUgUZWXw2JJKoj1pUvHx0WU05KoWX/u+inSfj?=
 =?us-ascii?Q?WvctJ6L0O6yRDvY4hQ+n8FzazOw+Ut2iiotDCSz5ZSuF9bvDM4CxmWxqfrSW?=
 =?us-ascii?Q?UypHOULsaYP0opb32nIxNM04qZoGIS1dL4Bdw/T/gKXMdF4d3SQtVakVHNFz?=
 =?us-ascii?Q?HDJNvoj984SeEBpkyejDiuYpk+L/TTA0lL43BNUBqDNIVS1nEBLj4K5TgEzQ?=
 =?us-ascii?Q?jmvKhbHWEyhnN5DuDYpmyA2ykWNHsZnoxA+CNMlFTCCYewkwp+chZOhWsrUq?=
 =?us-ascii?Q?sfp2DIV45u6fn9i7iQrAv5wjzjFhqKP82kHz3nN9IIpFYPr+oyBwADCjyv1k?=
 =?us-ascii?Q?Prlhw8Thc4e4dfcRlw34ehciyMYSCtKHrYsYzQ6/7tw1HE6NIHuYBiz6Rfyu?=
 =?us-ascii?Q?avFZC3mRpYn2LjkUgexGUxlpdO9VVOhUw+HUq17qpH+DolhXxmZEQm0iAk1y?=
 =?us-ascii?Q?SmSsG67txpHOlTrqMVuO8cFtC92TEmN8+tIi5TlcmAzPA8NF5p4dBM9vmn6l?=
 =?us-ascii?Q?FKqv0OMppEh3Oz8LmtunF+rv/QaXyFcJz7d/rtQmwPilWLQYF8jURULJIsTX?=
 =?us-ascii?Q?HLvYpGKKLd0ikSfKMM45RRPOeBGU9YnViOsJs2yG2xvep1/u9IK5Nq3nrvuu?=
 =?us-ascii?Q?7S9nkf3mAX4zpwCFX77OP3QxwtlsvUyTex9/meVk0ZNS6Z8UYcEFaIZ8hynK?=
 =?us-ascii?Q?U9hkCnLKslzrv2Bmt3wnDoQPHAIOEc2OXWcbWTlaYyOZjVfrh3NB+/VH2GtB?=
 =?us-ascii?Q?PaG7ifhfKQNVDiyQJTRRH4IyXdYbp2Fivw5+6YOZK6J4nD5v5gCnmaorcbtL?=
 =?us-ascii?Q?k5Ija2f5cPGVZDMldqZrVGcNle9Ag7ENXa+t7C0LKFUl7hU+riAX/V98NGIC?=
 =?us-ascii?Q?qyPTd7kWHzmR3lQktPrphzk+fF6PbA/a4O+YFKuNcdkA8X36EV4HKF300U3f?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AWhWbLDdoZ4+c4BEgK+qTzSfwTS1RUOUHcv/T2FZQsPhSq6ANuc21RuRVZNPad5pFbJW2lXfO3HnFyoLSE3PfIkLNYcEfjVWDEmmNNtuazsJqR9x4KaG8dATqfMmA65bt/spHMQRfKaJwizNcBudQZ59+n1hN+XdNu/WCqsObkmybXjLGHedmxbMQE1Ejt4hww8jG/aegB+ccZF++HllGWiiXed5+AURjKUKHR35dDYDCGYKudxN2O/vFjqxUybj4+YoGvg+xSDkFjzMEmv2BsAMgNkcewnBFavbn6Re3C635jlnX98giG7xfEPFoeSlY1OvhsE/Am+vXbjTxKgaWaAJcexdNRJ6U1XRpwhR8+cFAUTZwgagefwCZ+Arae+deT8VlcZUyUqINEaDIJ/QqtBSEmRpiq0FuVZRl9642Log+p0JgDUQ1iSzNiAtCvKAA6Jw37ISSkhcWObewqOAKpYkuPw5PsT82gxUyAFNL1iuTkLJuh2y4UWPyyKT4uKWbi/CFv4rSCVMDU8b6fJLwa9+H+eC6xbS+azzOPYPL8eKX1UxZ9fCFcs6JRk12wI/YljLaB+uZFgXBbsblbrqjT11h+XdDnCvTKtKnTtKRsM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d82af179-a55f-4735-273f-08dd68c304ed
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 21:54:56.9252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: di4QFTdiJApTXj8Ct0I0E1v5LpGRVxPA2GOR35F4F7rsiRmi2xsjWWVeW0CroCIZxP8ivDTnH7Xw3pdKkYp5YeVtqAo46KL3P3DdaBKAbYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6144
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_07,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503210160
X-Proofpoint-ORIG-GUID: kUoJPsbaZm0xmfxgQN2jzPH2HhbEZvQi
X-Proofpoint-GUID: kUoJPsbaZm0xmfxgQN2jzPH2HhbEZvQi

Add test cases to the mm self test asserting that the merge cases which the
newly introduced MREMAP[_MUST]_RELOCATE_ANON results in merges occurring as
expected, which otherwise without it would not succeed.

This extends the newly introduced VMA merge self tests for these cases and
exhaustively attempts each merge case, asserting expected behaviour.

We use the MREMAP_MUST_RELOCATE_ANON variant to ensure that, should the
anon relocate fail, we observe an error, as quietly demoting the move to
non-relocate anon would cause unusual test failures.

We carefully document each case to make clear what we are testing.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/mm/merge.c | 730 +++++++++++++++++++++++++++++
 1 file changed, 730 insertions(+)

diff --git a/tools/testing/selftests/mm/merge.c b/tools/testing/selftests/mm/merge.c
index 7c4f3f93c30d..bd1b82665348 100644
--- a/tools/testing/selftests/mm/merge.c
+++ b/tools/testing/selftests/mm/merge.c
@@ -1055,4 +1055,734 @@ TEST_F(merge, mremap_correct_placed_faulted)
 	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 15 * page_size);
 }
 
+TEST_F(merge, mremap_relocate_anon_faulted_after_unfaulted)
+{
+	unsigned int page_size = self->page_size;
+	char *carveout = self->carveout;
+	struct procmap_fd *procmap = &self->procmap;
+	char *ptr, *ptr2;
+
+	/*
+	 * Map two distinct areas:
+	 *
+	 * |-----------|  |-----------|
+	 * | unfaulted |  | unfaulted |
+	 * |-----------|  |-----------|
+	 *      ptr            ptr2
+	 */
+	ptr = mmap(&carveout[page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ptr2 = mmap(&carveout[7 * page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/*
+	 * Offset ptr2 further away. Note we don't have to use
+	 * MREMAP_RELOCATE_ANON yet.
+	 */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, ptr2 + page_size * 1000);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/*
+	 * Fault ptr2 in:
+	 *                \
+	 * |-----------|  /  |-----------|
+	 * | unfaulted |  \  |  faulted  |
+	 * |-----------|  /  |-----------|
+	 *      ptr       \       ptr2
+	 */
+	ptr2[0] = 'x';
+
+	/*
+	 * Move ptr2 after ptr, using MREMAP_MUST_RELOCATE_ANON:
+	 *
+	 * |-----------|-----------|
+	 * | unfaulted |  faulted  |
+	 * |-----------|-----------|
+	 *      ptr         ptr2
+	 *
+	 * It should merge:
+	 *
+	 * |-----------------------|
+	 * |        faulted        |
+	 * |-----------------------|
+	 */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED | MREMAP_MUST_RELOCATE_ANON,
+			  &ptr[5 * page_size]);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 10 * page_size);
+}
+
+TEST_F(merge, mremap_relocate_anon_faulted_before_unfaulted)
+{
+	unsigned int page_size = self->page_size;
+	char *carveout = self->carveout;
+	struct procmap_fd *procmap = &self->procmap;
+	char *ptr, *ptr2;
+
+	/*
+	 * Map two distinct areas:
+	 *
+	 * |-----------|  |-----------|
+	 * | unfaulted |  | unfaulted |
+	 * |-----------|  |-----------|
+	 *      ptr            ptr2
+	 */
+	ptr = mmap(&carveout[6 * page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ptr2 = mmap(&carveout[12 * page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/*
+	 * Offset ptr2 further away. Note we don't have to use
+	 * MREMAP_RELOCATE_ANON yet.
+	 */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, ptr2 + page_size * 1000);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/*
+	 * Fault ptr2 in:
+	 *                \
+	 * |-----------|  /  |-----------|
+	 * | unfaulted |  \  |  faulted  |
+	 * |-----------|  /  |-----------|
+	 *      ptr       \       ptr2
+	 */
+	ptr2[0] = 'x';
+
+	/*
+	 * Move ptr2 before ptr, using MREMAP_MUST_RELOCATE_ANON:
+	 *
+	 * |-----------|-----------|
+	 * |  faulted  | unfaulted |
+	 * |-----------|-----------|
+	 *      ptr2        ptr
+	 *
+	 * It should merge:
+	 *
+	 * |-----------------------|
+	 * |        faulted        |
+	 * |-----------------------|
+	 */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED | MREMAP_MUST_RELOCATE_ANON,
+			  &carveout[page_size]);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr2));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr2);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr2 + 10 * page_size);
+}
+
+TEST_F(merge, mremap_relocate_anon_faulted_between_unfaulted)
+{
+	unsigned int page_size = self->page_size;
+	char *carveout = self->carveout;
+	struct procmap_fd *procmap = &self->procmap;
+	char *ptr, *ptr2, *ptr3;
+
+	/*
+	 * Map three distinct areas:
+	 *
+	 * |-----------|  |-----------|  |-----------|
+	 * | unfaulted |  | unfaulted |  | unfaulted |
+	 * |-----------|  |-----------|  |-----------|
+	 *      ptr            ptr2           ptr3
+	 */
+	ptr = mmap(&carveout[page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ptr2 = mmap(&carveout[7 * page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+	ptr3 = mmap(&carveout[14 * page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr3, MAP_FAILED);
+
+	/*
+	 * Offset ptr2 further away, and move ptr3 into position:
+	 *                                        \
+	 * |-----------|           |-----------|  /  |-----------|
+	 * | unfaulted |           | unfaulted |  \  | unfaulted |
+	 * |-----------|           |-----------|  /  |-----------|
+	 *      ptr                    ptr3       \      ptr2
+	 */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, ptr2 + page_size * 1000);
+	ASSERT_NE(ptr2, MAP_FAILED);
+	ptr3 = sys_mremap(ptr3, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, ptr3 + page_size * 2000);
+	ASSERT_NE(ptr3, MAP_FAILED);
+	ptr3 = sys_mremap(ptr3, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, &ptr[10 * page_size]);
+	ASSERT_NE(ptr3, MAP_FAILED);
+
+	/*
+	 * Fault in ptr2:
+	 *                                        \
+	 * |-----------|           |-----------|  /  |-----------|
+	 * | unfaulted |           | unfaulted |  \  |  faulted  |
+	 * |-----------|           |-----------|  /  |-----------|
+	 *      ptr                    ptr3       \      ptr2
+	 */
+	ptr2[0] = 'x';
+
+	/*
+	 * Move ptr2 between ptr, ptr3, using MREMAP_MUST_RELOCATE_ANON:
+	 *
+	 * |-----------|-----------|-----------|
+	 * | unfaulted |  faulted  | unfaulted |
+	 * |-----------|-----------|-----------|
+	 *
+	 * It should merge:
+	 *
+	 * |-----------------------------------|
+	 * |              faulted              |
+	 * |-----------------------------------|
+	 */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED | MREMAP_MUST_RELOCATE_ANON,
+			  &ptr[5 * page_size]);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 15 * page_size);
+}
+
+TEST_F(merge, mremap_relocate_anon_faulted_after_faulted)
+{
+	unsigned int page_size = self->page_size;
+	char *carveout = self->carveout;
+	struct procmap_fd *procmap = &self->procmap;
+	char *ptr, *ptr2;
+
+	/*
+	 * Map two distinct areas:
+	 *
+	 * |-----------|  |-----------|
+	 * | unfaulted |  | unfaulted |
+	 * |-----------|  |-----------|
+	 *      ptr            ptr2
+	 */
+	ptr = mmap(&carveout[page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ptr2 = mmap(&carveout[7 * page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/*
+	 * Offset ptr2 further away. Note we don't have to use
+	 * MREMAP_RELOCATE_ANON yet.
+	 */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, ptr2 + page_size * 1000);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/*
+	 * Fault ptr and ptr2 in:
+	 *                \
+	 * |-----------|  /  |-----------|
+	 * |  faulted  |  \  |  faulted  |
+	 * |-----------|  /  |-----------|
+	 *      ptr       \       ptr2
+	 */
+	ptr[0] = 'x';
+	ptr2[0] = 'x';
+
+	/*
+	 * Move ptr2 after ptr, using MREMAP_MUST_RELOCATE_ANON:
+	 *
+	 * |-----------|-----------|
+	 * |  faulted  |  faulted  |
+	 * |-----------|-----------|
+	 *      ptr         ptr2
+	 *
+	 * It should merge:
+	 *
+	 * |-----------------------|
+	 * |        faulted        |
+	 * |-----------------------|
+	 */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED | MREMAP_MUST_RELOCATE_ANON,
+			  &ptr[5 * page_size]);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 10 * page_size);
+}
+
+TEST_F(merge, mremap_relocate_anon_faulted_before_faulted)
+{
+	unsigned int page_size = self->page_size;
+	char *carveout = self->carveout;
+	struct procmap_fd *procmap = &self->procmap;
+	char *ptr, *ptr2;
+
+	/*
+	 * Map two distinct areas:
+	 *
+	 * |-----------|  |-----------|
+	 * | unfaulted |  | unfaulted |
+	 * |-----------|  |-----------|
+	 *      ptr            ptr2
+	 */
+	ptr = mmap(&carveout[6 * page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ptr2 = mmap(&carveout[12 * page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/*
+	 * Offset ptr2 further away. Note we don't have to use
+	 * MREMAP_RELOCATE_ANON yet.
+	 */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, ptr2 + page_size * 1000);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/*
+	 * Fault ptr, ptr2 in:
+	 *                \
+	 * |-----------|  /  |-----------|
+	 * |  faulted  |  \  |  faulted  |
+	 * |-----------|  /  |-----------|
+	 *      ptr       \       ptr2
+	 */
+	ptr[0] = 'x';
+	ptr2[0] = 'x';
+
+	/*
+	 * Move ptr2 before ptr, using MREMAP_MUST_RELOCATE_ANON:
+	 *
+	 * |-----------|-----------|
+	 * |  faulted  |  faulted  |
+	 * |-----------|-----------|
+	 *      ptr2        ptr
+	 *
+	 * It should merge:
+	 *
+	 * |-----------------------|
+	 * |        faulted        |
+	 * |-----------------------|
+	 */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED | MREMAP_MUST_RELOCATE_ANON,
+			  &carveout[page_size]);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr2));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr2);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr2 + 10 * page_size);
+}
+
+TEST_F(merge, mremap_relocate_anon_faulted_between_faulted_unfaulted)
+{
+	unsigned int page_size = self->page_size;
+	char *carveout = self->carveout;
+	struct procmap_fd *procmap = &self->procmap;
+	char *ptr, *ptr2, *ptr3;
+
+	/*
+	 * Map three distinct areas:
+	 *
+	 * |-----------|  |-----------|  |-----------|
+	 * | unfaulted |  | unfaulted |  | unfaulted |
+	 * |-----------|  |-----------|  |-----------|
+	 *      ptr            ptr2           ptr3
+	 */
+	ptr = mmap(&carveout[page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ptr2 = mmap(&carveout[7 * page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+	ptr3 = mmap(&carveout[14 * page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr3, MAP_FAILED);
+
+	/*
+	 * Offset ptr2 further away, and move ptr3 into position:
+	 *                                        \
+	 * |-----------|           |-----------|  /  |-----------|
+	 * | unfaulted |           | unfaulted |  \  | unfaulted |
+	 * |-----------|           |-----------|  /  |-----------|
+	 *      ptr                    ptr3       \      ptr2
+	 */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, ptr2 + page_size * 1000);
+	ASSERT_NE(ptr2, MAP_FAILED);
+	ptr3 = sys_mremap(ptr3, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, ptr3 + page_size * 2000);
+	ASSERT_NE(ptr3, MAP_FAILED);
+	ptr3 = sys_mremap(ptr3, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, &ptr[10 * page_size]);
+	ASSERT_NE(ptr3, MAP_FAILED);
+
+	/*
+	 * Fault in ptr, ptr2:
+	 *                                        \
+	 * |-----------|           |-----------|  /  |-----------|
+	 * |  faulted  |           | unfaulted |  \  |  faulted  |
+	 * |-----------|           |-----------|  /  |-----------|
+	 *      ptr                    ptr3       \      ptr2
+	 */
+	ptr[0] = 'x';
+	ptr2[0] = 'x';
+
+	/*
+	 * Move ptr2 between ptr, ptr3, using MREMAP_MUST_RELOCATE_ANON:
+	 *
+	 * |-----------|-----------|-----------|
+	 * |  faulted  |  faulted  | unfaulted |
+	 * |-----------|-----------|-----------|
+	 *
+	 * It should merge:
+	 *
+	 * |-----------------------------------|
+	 * |              faulted              |
+	 * |-----------------------------------|
+	 */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED | MREMAP_MUST_RELOCATE_ANON,
+			  &ptr[5 * page_size]);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 15 * page_size);
+}
+
+TEST_F(merge, mremap_relocate_anon_faulted_between_unfaulted_faulted)
+{
+	unsigned int page_size = self->page_size;
+	char *carveout = self->carveout;
+	struct procmap_fd *procmap = &self->procmap;
+	char *ptr, *ptr2, *ptr3;
+
+	/*
+	 * Map three distinct areas:
+	 *
+	 * |-----------|  |-----------|  |-----------|
+	 * | unfaulted |  | unfaulted |  | unfaulted |
+	 * |-----------|  |-----------|  |-----------|
+	 *      ptr            ptr2           ptr3
+	 */
+	ptr = mmap(&carveout[page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ptr2 = mmap(&carveout[7 * page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+	ptr3 = mmap(&carveout[14 * page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr3, MAP_FAILED);
+
+	/*
+	 * Offset ptr2 further away, and move ptr3 into position:
+	 *                                        \
+	 * |-----------|           |-----------|  /  |-----------|
+	 * | unfaulted |           | unfaulted |  \  | unfaulted |
+	 * |-----------|           |-----------|  /  |-----------|
+	 *      ptr                    ptr3       \      ptr2
+	 */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, ptr2 + page_size * 1000);
+	ASSERT_NE(ptr2, MAP_FAILED);
+	ptr3 = sys_mremap(ptr3, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, ptr3 + page_size * 2000);
+	ASSERT_NE(ptr3, MAP_FAILED);
+	ptr3 = sys_mremap(ptr3, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, &ptr[10 * page_size]);
+	ASSERT_NE(ptr3, MAP_FAILED);
+
+	/*
+	 * Fault in ptr2, ptr3:
+	 *                                        \
+	 * |-----------|           |-----------|  /  |-----------|
+	 * | unfaulted |           |  faulted  |  \  |  faulted  |
+	 * |-----------|           |-----------|  /  |-----------|
+	 *      ptr                    ptr3       \      ptr2
+	 */
+	ptr2[0] = 'x';
+	ptr3[0] = 'x';
+
+	/*
+	 * Move ptr2 between ptr, ptr3, using MREMAP_MUST_RELOCATE_ANON:
+	 *
+	 * |-----------|-----------|-----------|
+	 * | unfaulted |  faulted  |  faulted  |
+	 * |-----------|-----------|-----------|
+	 *
+	 * It should merge:
+	 *
+	 * |-----------------------------------|
+	 * |              faulted              |
+	 * |-----------------------------------|
+	 */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED | MREMAP_MUST_RELOCATE_ANON,
+			  &ptr[5 * page_size]);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 15 * page_size);
+}
+
+TEST_F(merge, mremap_relocate_anon_faulted_between_faulted)
+{
+	unsigned int page_size = self->page_size;
+	char *carveout = self->carveout;
+	struct procmap_fd *procmap = &self->procmap;
+	char *ptr, *ptr2, *ptr3;
+
+	/*
+	 * Map three distinct areas:
+	 *
+	 * |-----------|  |-----------|  |-----------|
+	 * | unfaulted |  | unfaulted |  | unfaulted |
+	 * |-----------|  |-----------|  |-----------|
+	 *      ptr            ptr2           ptr3
+	 */
+	ptr = mmap(&carveout[page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ptr2 = mmap(&carveout[7 * page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+	ptr3 = mmap(&carveout[14 * page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr3, MAP_FAILED);
+
+	/*
+	 * Offset ptr2 further away, and move ptr3 into position:
+	 *                                        \
+	 * |-----------|           |-----------|  /  |-----------|
+	 * | unfaulted |           | unfaulted |  \  | unfaulted |
+	 * |-----------|           |-----------|  /  |-----------|
+	 *      ptr                    ptr3       \      ptr2
+	 */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, ptr2 + page_size * 1000);
+	ASSERT_NE(ptr2, MAP_FAILED);
+	ptr3 = sys_mremap(ptr3, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, ptr3 + page_size * 2000);
+	ASSERT_NE(ptr3, MAP_FAILED);
+	ptr3 = sys_mremap(ptr3, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, &ptr[10 * page_size]);
+	ASSERT_NE(ptr3, MAP_FAILED);
+
+	/*
+	 * Fault in ptr, ptr2, ptr3:
+	 *                                        \
+	 * |-----------|           |-----------|  /  |-----------|
+	 * |  faulted  |           |  faulted  |  \  |  faulted  |
+	 * |-----------|           |-----------|  /  |-----------|
+	 *      ptr                    ptr3       \      ptr2
+	 */
+	ptr[0] = 'x';
+	ptr2[0] = 'x';
+	ptr3[0] = 'x';
+
+	/*
+	 * Move ptr2 between ptr, ptr3, using MREMAP_MUST_RELOCATE_ANON:
+	 *
+	 * |-----------|-----------|-----------|
+	 * |  faulted  |  faulted  |  faulted  |
+	 * |-----------|-----------|-----------|
+	 *
+	 * It should merge, but only the latter two VMAs:
+	 *
+	 * |-----------|-----------------------|
+	 * |  faulted  |        faulted        |
+	 * |-----------|-----------------------|
+	 */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED | MREMAP_MUST_RELOCATE_ANON,
+			  &ptr[5 * page_size]);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr2));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr2);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr2 + 10 * page_size);
+}
+
+TEST_F(merge, mremap_relocate_anon_faulted_between_correctly_placed_faulted)
+{
+	unsigned int page_size = self->page_size;
+	char *carveout = self->carveout;
+	struct procmap_fd *procmap = &self->procmap;
+	char *ptr, *ptr2;
+
+	/*
+	 * Map one larger area:
+	 *
+	 * |-----------------------------------|
+	 * |            unfaulted              |
+	 * |-----------------------------------|
+	 */
+	ptr = mmap(&carveout[page_size], 15 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/*
+	 * Fault in ptr:
+	 *
+	 * |-----------------------------------|
+	 * |              faulted              |
+	 * |-----------------------------------|
+	 */
+	ptr[0] = 'x';
+
+	/*
+	 * Unmap middle:
+	 *
+	 * |-----------|           |-----------|
+	 * |  faulted  |           |  faulted  |
+	 * |-----------|           |-----------|
+	 *
+	 * Now the faulted areas are compatible with each other (anon_vma the
+	 * same, vma->vm_pgoff equal to virtual page offset).
+	 */
+	ASSERT_EQ(munmap(&ptr[5 * page_size], 5 * page_size), 0);
+
+	/*
+	 * Map a new area, ptr2:
+	 *                                        \
+	 * |-----------|           |-----------|  /  |-----------|
+	 * |  faulted  |           |  faulted  |  \  | unfaulted |
+	 * |-----------|           |-----------|  /  |-----------|
+	 *      ptr                               \       ptr2
+	 */
+	ptr2 = mmap(&carveout[20 * page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/*
+	 * Fault it in:
+	 *                                        \
+	 * |-----------|           |-----------|  /  |-----------|
+	 * |  faulted  |           |  faulted  |  \  |  faulted  |
+	 * |-----------|           |-----------|  /  |-----------|
+	 *      ptr                               \       ptr2
+	 */
+	ptr2[0] = 'x';
+
+	/*
+	 * Finally, move ptr2 into place, using MREMAP_MUST_RELOCATE_ANON:
+	 *
+	 * |-----------|-----------|-----------|
+	 * |  faulted  |  faulted  |  faulted  |
+	 * |-----------|-----------|-----------|
+	 *      ptr        ptr2         ptr3
+	 *
+	 * It should merge:
+	 *
+	 * |-----------------------------------|
+	 * |              faulted              |
+	 * |-----------------------------------|
+	 */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED | MREMAP_MUST_RELOCATE_ANON,
+			  &ptr[5 * page_size]);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 15 * page_size);
+}
+
+TEST_F(merge, mremap_relocate_anon_mprotect_faulted_faulted)
+{
+	unsigned int page_size = self->page_size;
+	char *carveout = self->carveout;
+	struct procmap_fd *procmap = &self->procmap;
+	char *ptr, *ptr2;
+
+
+	/*
+	 * Map two distinct areas:
+	 *
+	 * |-----------|  |-----------|
+	 * | unfaulted |  | unfaulted |
+	 * |-----------|  |-----------|
+	 *      ptr            ptr2
+	 */
+	ptr = mmap(&carveout[page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ptr2 = mmap(&carveout[12 * page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/*
+	 * Fault in ptr, ptr2, mprotect() ptr2 read-only:
+	 *
+	 *      RW              RO
+	 * |-----------|  |-----------|
+	 * |  faulted  |  |  faulted  |
+	 * |-----------|  |-----------|
+	 *      ptr            ptr2
+	 */
+	ptr[0] = 'x';
+	ptr2[0] = 'x';
+	ASSERT_EQ(mprotect(ptr2, 5 * page_size, PROT_READ), 0);
+
+	/*
+	 * Move ptr2 next to ptr:
+	 *
+	 *      RW          RO
+	 * |-----------|-----------|
+	 * |  faulted  |  faulted  |
+	 * |-----------|-----------|
+	 *      ptr        ptr2
+	 */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED | MREMAP_MUST_RELOCATE_ANON,
+			  &ptr[5 * page_size]);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/* No merge should happen. */
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 5 * page_size);
+
+	/*
+	 * Now mremap ptr2 RW:
+	 *
+	 *      RW          RW
+	 * |-----------|-----------|
+	 * |  faulted  |  faulted  |
+	 * |-----------|-----------|
+	 *      ptr        ptr2
+	 *
+	 * This should result in a merge:
+	 *
+	 *            RW
+	 * |-----------------------|
+	 * |        faulted        |
+	 * |-----------------------|
+	 *            ptr
+	 */
+	ASSERT_EQ(mprotect(ptr2, 5 * page_size, PROT_READ | PROT_WRITE), 0);
+
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 10 * page_size);
+}
+
 TEST_HARNESS_MAIN
-- 
2.48.1


