Return-Path: <linux-kernel+bounces-367078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F2799FE5E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B861F22480
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 01:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132D213B787;
	Wed, 16 Oct 2024 01:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U0HbT8rl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pfStp4k2"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D4E13635C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 01:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729042534; cv=fail; b=asxxIpeziIO7QnakrVK9HjqTYjMzRmwP57uhFQH2GEc6fIX/XU7BuF9Dy9ScI28VuZG7MIfLcbWvH5uE5r8Oprns8RyWYcKBYJhEZj0GlFM51buFTA+TKUcrvxgXBngOv1XY74e1E1BjWa3vSN4vb/EhASURIyt85+CEyO9PHJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729042534; c=relaxed/simple;
	bh=5sNL+i5u3LkIWY0mOdpCrOiwMZE/mkg6eEswJcvKkWE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nSkGprX9E0Rqrs37V4AuiTp8IlicYwb/TOnkEoulzUJqxqsHY86YsSW5kM9wNQu5yBYc1RCGIPbwyp8ccDP7hzpZKHy0bqQ0tRnaK4t+vSbYz6VLJ694Fy9uVWH4KyOqomDnDh8E3QLQuUuzsjHsET4slT/AybrFiCyb3ulRm7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U0HbT8rl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pfStp4k2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FHthdD023502;
	Wed, 16 Oct 2024 01:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=bHhtJN8X7Wnj22gT
	TbiaucGspjhvxLvcHr3d0/tTh34=; b=U0HbT8rlet+wP5qbT7iDEJteNyU3ZTU2
	3vZx188j6vu8cIgrLycbkhBEAMuNtryFHkvWdhsdo7wr5+hd9qm+S4mkwBJDQNi1
	B+2FkG1AtG3HweRk/CioaxQfzVaf18g5jueoYXYAZGpb5lsIPIgQtmVcmBMA1iTP
	QNNLr+BUsEDhKYGiCIPc7aYBwnt4Nk4phlc+6LztjzveZJmugJVIIZgy1uxjPVZt
	aD+VTae2SjDNLCRCX6jjcMS8kdEtqvxz1EbOrijbHMdCxDKWqT9XCAB+144AKRz0
	qKhB2AbdgiNGPSKgd9arJaSLFYzsFP2YYUmYRFAqwTnbl3du/6Q8hQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h09j4ad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 01:35:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49G1312b035999;
	Wed, 16 Oct 2024 01:35:16 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjejtd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 01:35:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5ZK0KBV9KFScvcSC0GE+WXezBV6Aee/Zwm7zpk8o+DCiBNjEqAnlXmJjX7KPsbPc159sN3TSXHZtLPNgkITXMxUCAJ0nqgXt/GwO2zTChHYCss9dbo8ed84UDXLHo7uuJtqMKShNW39qqSQ9d4LATtjRopRcIMmxX0qdbXp184PV3N5UAYC6Hr91Wg8xfS/LYJbLOJ4PjpmfGDcyQ+DU/giyAg4yKPqzumzABCpaKKqzCytJqsOUcr0MLXASPHjIiPLF5hhPjkQ5Ssno0Gm1ZpiXJMRZhnqJZCtnBw3t4onSf1JGfZ70fHwq1zXNvfU7luKdpRPpq7mOO92X8EoqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHhtJN8X7Wnj22gTTbiaucGspjhvxLvcHr3d0/tTh34=;
 b=qDLedDDCX68NGNugdbFl2DRVJbCSjobbwqOmiEUunww5Y3RSk07Uc87JxEhqvmclNzv3x6/BTX+wC4MIDYXvUQfuUk+POCU4nW/LIpvg7oeDQAiM94UfhVuXzpgJMy4QY9+eXX1FubwJsYp1jswVQCU8M10awzGrYDWp9SySI/vT+dfI0K4Nt8wjvHEd2zJLhdghdcrMXOG8Eq2W/ZMPiLaVM0fr+dqBJFJN7XRshPgAOK70va2+paHC9Vd3BtTkJkYMPTFuS5r9V15VXniatNq8vNW6LmvQ4dNX2sTuYBaK2wwLfO1Z+b7/GCdoC7X4H0s1Om6iIsDqtPVgFyrxiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHhtJN8X7Wnj22gTTbiaucGspjhvxLvcHr3d0/tTh34=;
 b=pfStp4k2YEAge4RSMb7gVb7wCd5yWAVHa8hEghYKw1bDyQav00EprzPits5jNFhFN12/IWjcmP7soJuOZoiWQFZ+LTuW4qLjF9md1rmSTQc+vqjOPMtkqX+45V2n5j54E2PpmjkZfdUIZYhD7oz0suf6gPL27yF2QvWW/r8P8FU=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH7PR10MB6553.namprd10.prod.outlook.com (2603:10b6:510:204::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 01:35:14 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 01:35:12 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v2] mm/mmap: Fix race in mmap_region() with ftrucate()
Date: Tue, 15 Oct 2024 21:34:55 -0400
Message-ID: <20241016013455.2241533-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0420.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::17) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH7PR10MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: 64922209-b2b3-4bda-25d5-08dced82c76e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MXycE/wiP1BxnrLIOiYdJFrhY2upVMEvcleTPTNxo3tjA8jrcX84e9Q5vEi/?=
 =?us-ascii?Q?w9M/oueuHGQ7G+ef7gps+d2vUZtpx1ir7zhOG5rWCySpQqHOkpRhGsm2TLos?=
 =?us-ascii?Q?5qL0i/BvMgD3/EkLhdotj/Jw877z//gNoJX+m65GvtpVzqUk6k0irzMe23rc?=
 =?us-ascii?Q?f46tjpa3vi+Lr+RNLo0ikerxVmqUQ3JrrIUA44FI71Um2v9xKrQLIkpeJMr2?=
 =?us-ascii?Q?VAEIu2BfOvO117fITl3csF+B15hJSjn9aruQzheH8bUvKc+lsfB2WlQjWIPF?=
 =?us-ascii?Q?H+yiyISJL4kmz/1wtWcdqcQwn5mv75agw7fMHAUcIaz3Mc0hjMk82SXCVu8K?=
 =?us-ascii?Q?VUomy14dhGtmRgcCvCg2AsTaWCeUtfWU1ZpxWUqMmRV0YMPd91vNHCd8snkJ?=
 =?us-ascii?Q?H8ACoGkoEuWygZyUbPLSt0XMo32GG997GGUWhpAV5rNUrZFvRPWEUqN+PpYY?=
 =?us-ascii?Q?toQLeN/CbVpMbZyUcExh81njyIPe5WkaAA3kJtsh4hKnNBSphxy6fTacoACY?=
 =?us-ascii?Q?hAKlhgrehYTESdp+3PSs6IFAfboJNse4uxiDFz38Ho5KlDPwjemVMOsT8pX1?=
 =?us-ascii?Q?f/E9tpqbT3qtWvJzecZ6pXe6D1asRvSD1/IsRV1zFjhMkqzJVuEkS1mV86Du?=
 =?us-ascii?Q?qg5Jxxr+AWNy3kOj10C2z2/booixiliRqY+CKTYZQpLCOPI+u2cwEUuRbnjU?=
 =?us-ascii?Q?euqJaVeykBQOnPKzt3xxJP/S/gvHjgQX390vtowTd+AtZ3xvglSc7MddMmQi?=
 =?us-ascii?Q?ef19UuoH8heHSzR0G3bJ5o3Lx4dvwMdzctu15hT4w+GZPFn56AVAfoP4qVhr?=
 =?us-ascii?Q?j4RQRnYqnG58W8UyykFA8M97oO59z5irxTID78baDFyp09Oyl/MG9K3jXrxD?=
 =?us-ascii?Q?mwfbF9gsh10c4UZs7l8RLEgYGkCedQshdD7dZTrp6JPsogVFE314XyRizBnv?=
 =?us-ascii?Q?Sf7+rk27LLJnEAWrCvwEpbfwJy/KxuDZVWOf9j4/V431odgtnz2KvEYVrf8v?=
 =?us-ascii?Q?rUnVv6978umW0G99swA05zVDSxWg1mAxXHf8gvjTCurxEOLnRkNEZLCSYrO/?=
 =?us-ascii?Q?kaPJ8Krap4DSh/g5oPtMNZphFlVZqNd+RAR5HnTi9BiN2au9YvJ+9/0Dp/at?=
 =?us-ascii?Q?iiDxc6hqHgtCWWO7HBuaudlEpwckzVvRl+Vs5IsEE3zGxtd7QthhVZaOJJfJ?=
 =?us-ascii?Q?lM3QnlWdM5e08W5+plAnuMZm5qKPYBr5OgFPmokS/EScuWP1DuyiFFQbuu3k?=
 =?us-ascii?Q?B55k9Kj3i1mgr9NVM0f4LqvDUU8y/Kb4kN7FEa9BwkLHntf4RFNdNI0LL6BT?=
 =?us-ascii?Q?EMg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Pg6RorscuZzIAqxJ3dPQQYL1z90/2FKkA0Cgl0Vb/uloTbI8cHZ2Aqg2RoK?=
 =?us-ascii?Q?2IKhlgJzxqjr0+d572XMcKbm1qB/YvHGi9E+7HwX7QLQUKFFGVzDtwM6t67a?=
 =?us-ascii?Q?vFDRJWZkzahN2zqDe05+nduJyejNBv1e/GYeyoEpKWPRR3c/2pV8+TJ1LVSE?=
 =?us-ascii?Q?Z9HgWdLJP8JhoaKoZIppnnEk+6WFxXFqwmt6dU4HqmLI7RfARL7UY0XblJBz?=
 =?us-ascii?Q?QLZfZdfy5OF2RC/FUz6oe7ZPQId37mxrTbQMkAS42/PvyI1K+DHOAl97YzoC?=
 =?us-ascii?Q?5FiIoRmSRM9nMhN2mpj3qMqBsSwKotnupjoypkMGCRMt68fVSIXrW1xk2m7s?=
 =?us-ascii?Q?1Ib6r6IN9digvoVqsPPrDHoqfKBg07tidEWJdx8/snT4l/WZntO3ujd3/0d3?=
 =?us-ascii?Q?CrrHI62OOBEYkl48Rv7UW76fdu4TYsyXoJSKfUH5zZoF2WclqUZGgTC7JZzt?=
 =?us-ascii?Q?KEWt1RfFcnKFXdwLKPtxPtdBry3gUEXUXjydXAqJ+FeVjyRHORglIbFTCyiH?=
 =?us-ascii?Q?YNS/9ognWjTkuPXOrJlbibSTtl6YbJ2xBA+twQHVMwQ849IwuxOpiLVjz9Cp?=
 =?us-ascii?Q?KKQlETeDnMAvC6IzRgFk+vXpqPuOcREX3VizGBmSF/w+AD7427YI0pO6q48g?=
 =?us-ascii?Q?qTqdFuUdKVwjrBWMfWG5/leL/ELzzGSxBNyRg5I59ubHoKvhiz2MgR+BG7J4?=
 =?us-ascii?Q?zt/n4bXDYNfCkZYjh/zyF8egt6CXu4kNIplkh4tER8Seq4XXy1ElIGqDNvxO?=
 =?us-ascii?Q?7JcPHplho2BHhggIB9O2Fv3ccmzaDmqAflPZZA8jjP2uUMPIPe9CrQwGl8pM?=
 =?us-ascii?Q?nFbuQq6IoCiMgFc/vPQIJzLiwnHLwl7ZuF5g+tVdKMvsNdDwoDbPp1Wo824O?=
 =?us-ascii?Q?GXKhFFoSDXyGK/DtxYCxYa1ka5UUxBSVwQn7HjRbtSQeUWsv3E95VQR3v6qA?=
 =?us-ascii?Q?iopd2AgJr36i6ZFxj513I2VJJDATorPB5gwgREoRaSoFoLw8QsOdcHJ3M2Po?=
 =?us-ascii?Q?G0ejrLhJhYlQItnKtE6Ash1MRpSogLdMzvHpA+kHlnBF/92ldfE586KbUN8g?=
 =?us-ascii?Q?wO/p7r7o+itsSkSZww6nsazsymd3FyhXrImIdsZtOA3WXImirG+/VXNquorR?=
 =?us-ascii?Q?c7iGc1R51h/Nulk++JR0prCDtrpsvrW+tt1zON7l3yoH4CxRgtinXV1R6m6U?=
 =?us-ascii?Q?4FLlujv9qRlHIOQqnVlGwvDAFTVARbDvgC2IKKn/kBq8YFPrjuzvkPNCKubl?=
 =?us-ascii?Q?D3VF9RKr96vYajpkHzRmBu6owKVDNZvranx+DHM999viTNyJH6WQTMHUFnEf?=
 =?us-ascii?Q?V3u4Y6R07zAkmXBVAMR1+VsfEdYr1i0/L174mtXC8yxAFLvRiKAsimkMPCId?=
 =?us-ascii?Q?KKmCQHZy3nePByetZDNBwgv2bq7rE2ApPXEf5UL43BYS7B4xNIOeiwEQmXNR?=
 =?us-ascii?Q?51qCXUs8tWWYdfuBohf0R0VskUH1ADuG2ZvC7aWeUNYjbWdEw2wotsdx8uPD?=
 =?us-ascii?Q?S38W0SWpTd1zftQwScBUMpCAAO/Xnx+ahHIlEkSxe3X+X2rbfnv1eduJegsa?=
 =?us-ascii?Q?Dj3cpWQVqczVrnpJwNCPe080pVNS89uXBQk1eSj3fDhwME7kSdhQuhYv4PeE?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	B2DbLTThe9MKMOtEo5lgYgRPfcQ6s6eo5FU/3NuhASESAu5bi4Hn5GXH6aVJusxQ5I1pivmO5EZGR26s+hJzJOobEP4GaPsS0KkeS5lSgaawJQO9vlw/hdsXMzm30zQQqQZ5WyBVAoqOkwfwg/2oJ81sEPT38YIcL3TTn778g1m8AMhMkQKyi9R6VvpWH5qSWbV0Swd2foILiqoi+/IDBkp5I0np9PxhSsk0MImwdcCWeILvajR1K+pGuFM2ak4gpTlTcmtXHrFVMxKEF64KOaHNZ5VUb3ryKsAD3CPMZcsnafQ+MEx0a6r0m0gPy7SNlpQdhA/Z2cv5Mm4C82hOtYgoSzChUnB/QE2qAySc3EWxjTwA67Osc583rCy2ZIVY1u4FYMi3Hq3XBE62YEwBKInjTCxKXzR5Q33iXxaSp2lvM1X2HhRWSAxPpFGqffrsvXSL1CY8rDf0Vce3qaV04IOARmcPG3RuvSgBZ8bnBtB6Dfo+xaXbYlDCzKaAtJHyiAk+V0d8MLuBPdu+5m1zk+Qh6Cq07MI0V/fI7H8eU5dyqiu7PumKY/k/DDoouxopJcmTcZF1VjnSSW1113vWBzSrLW3qfSV8hZmNP5EW7RY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64922209-b2b3-4bda-25d5-08dced82c76e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 01:35:12.8511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PRWvovpQhrOmsnJ+TGEkoaC6OMJuqHdgRQye7opOsn542WdtdoUqeZZuvM1tkx4XhNO95tO/yTXwXwoiZ9KJUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6553
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_21,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410160009
X-Proofpoint-GUID: Hgv35KpppWyq8azF23fNXzjw18PWIim6
X-Proofpoint-ORIG-GUID: Hgv35KpppWyq8azF23fNXzjw18PWIim6

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Avoiding the zeroing of the vma tree in mmap_region() introduced a race
with truncate in the page table walk.  To avoid any races, create a hole
in the rmap during the operation by clearing the pagetable entries
earlier under the mmap write lock and (critically) before the new vma is
installed into the vma tree.  The result is that the old vma(s) are left
in the vma tree, but free_pgtables() removes them from the rmap and
clears the ptes while holding the necessary locks.

This change extends the fix required for hugetblfs and the call_mmap()
function by moving the cleanup higher in the function and running it
unconditionally.

Cc: Jann Horn <jannh@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>
Fixes: f8d112a4e657 ("mm/mmap: avoid zeroing vma tree in mmap_region()")
Reported-by: Jann Horn <jannh@google.com>
Closes: https://lore.kernel.org/all/CAG48ez0ZpGzxi=-5O_uGQ0xKXOmbjeQ0LjZsRJ1Qtf2X5eOr1w@mail.gmail.com/
Link: https://lore.kernel.org/all/CAG48ez0ZpGzxi=-5O_uGQ0xKXOmbjeQ0LjZsRJ1Qtf2X5eOr1w@mail.gmail.com/
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Jann Horn <jannh@google.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

v1: https://lore.kernel.org/all/20241015161135.2133951-1-Liam.Howlett@oracle.com/

Changes since v1:
  Updated commit message - Thanks Lorenzo

diff --git a/mm/mmap.c b/mm/mmap.c
index dd4b35a25aeb..a20998fb633c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1413,6 +1413,13 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vmg.flags = vm_flags;
 	}
 
+	/*
+	 * clear PTEs while the vma is still in the tree so that rmap
+	 * cannot race with the freeing later in the truncate scenario.
+	 * This is also needed for call_mmap(), which is why vm_ops
+	 * close function is called.
+	 */
+	vms_clean_up_area(&vms, &mas_detach);
 	vma = vma_merge_new_range(&vmg);
 	if (vma)
 		goto expanded;
@@ -1432,11 +1439,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	if (file) {
 		vma->vm_file = get_file(file);
-		/*
-		 * call_mmap() may map PTE, so ensure there are no existing PTEs
-		 * and call the vm_ops close function if one exists.
-		 */
-		vms_clean_up_area(&vms, &mas_detach);
 		error = call_mmap(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
-- 
2.43.0


