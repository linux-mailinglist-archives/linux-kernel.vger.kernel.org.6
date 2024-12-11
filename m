Return-Path: <linux-kernel+bounces-441180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D40D9ECAB1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52CCB1883119
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6AB211A09;
	Wed, 11 Dec 2024 10:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RRoujXST";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tEiSaknI"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5C7208973
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914418; cv=fail; b=DTEm8kdlZctLTfYpdDNgNyqmJXS4qc5v3B9E8v9pfT+wh43S0lo/dPksrVP0OjG6aDs9rfDZuaXgvfzY+RdUQ83UxQCPrrOUYZ0pfI45GilWIIVk5xV068DFtiStVeJmljUw47ISRXE0C1bR3JPXG/x6IUR8rl8+FSOrP8JXCAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914418; c=relaxed/simple;
	bh=CXkl8iFTtRZlpw0zJgzvCNqSmc54wdT5GnNTMNhYe5E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OpZAFnInOIVEq0+5qai5o5tOCw9I+vaesd2m0JIafAcNHY2aTDvF9BqZufRrz3gyWKHMIFPeQf/TC8vCkfacVQi6LmSinWmfTrYdIrGBfmRpePUjvhIoGTlu1ZEA/Alu1qmsh0iqaVTleTa83djXK++BQYf7T9BOE7jfHINNo+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RRoujXST; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tEiSaknI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB8ROiV022584;
	Wed, 11 Dec 2024 10:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=GbJImlsHsQGAQIft
	Hxb7/rE4tfWx3qAQf7T+C0T+4VI=; b=RRoujXSTwuRLA2Wz7puhkygxNdQHjDbs
	t0f+kKLvPOHsgzVTH5MR7o2ak7CRVH8bvDaJd+3vIBVu8vo9PMDZIjj8LWmK2WxD
	8/q4VwvZb6KBHgXeFxzZ6ozEj9L2dXHLmbfu7KS5ieSQ2ZEEYfRRwFg9vlboOJyQ
	+A93StY0R0fIVklhDqDBEvG+a+ZMJID6tDYmdKoTtDS3q+AGCiEeMCtZf1QdCwPi
	DhkOqHEY7GPZoLFkhoSDyhXBQVyj6Qr4w8834ez6cIqOwLqKYAW2hFFd3TqqmTWO
	gPEj9ZqZ+CU+0CPqd4+qFKV7c/Jp1SKn4GNADGtqA6O5Zlxi3dM+0A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cewt8bq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 10:53:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBAisRq035700;
	Wed, 11 Dec 2024 10:53:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct9usha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 10:53:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIpDQki1bvA8XsnlJuU/C+/uwTcw4gJcpUMfmlDKQO41CgTQJcLMEM2KJPkvDKc4I0KcOayYg9YSd19SjuFKcyMpY0BY2VFHg7FthEhDSogP23F6h+RgbDnWk0ruxvRu9Qm5M+r3JXp6AweHniCulbKR0gnqomLQK0B/09tc2/xONuu/I4neXOTK9UGUe9gljB5KhgweNcQRY9q968/7DYgo6l9/OpClylDwyQFvGFQUZ48EFkjwAePF802PzWdX0BjCY5Hsa2Eb2OiWnwgnSlWi2yRnQ0+T9hzJgs/7DkXOkmt3AQHJwMiCZRsoKQM7N25rHmD6XhQdml0hOzoeuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbJImlsHsQGAQIftHxb7/rE4tfWx3qAQf7T+C0T+4VI=;
 b=IF9xqH3GhmRY2+Rj43MFSi1WiLaelERNLsAqToYuQ1Xm3IauCMQ+StXe5xAeVM8Davj9LovXZ+RpBCPqCgeiAjgenQAFz6AOww34ItvGkTEAUp/3DkwWdFGscWM0Q9h2F3LDSf4CRHcVG4k5CEjWZk5E7WL18O4cGHuwubj9tapS9Nm//r9fstT5eonAnrhVB+IL4FX1wyp0NHRmBNJEpWj0upcqkLE4FIn/T2g+HeuXtOLFK89uLiPW//HP8DpekoDleRBJtmo/c98hGd5jFcHVR+QdLR0ltozIVMAuOVFxMz7mf5VLs9ploDQOi1CBAe7UdhZfh1iUoJM3RDThfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbJImlsHsQGAQIftHxb7/rE4tfWx3qAQf7T+C0T+4VI=;
 b=tEiSaknIPwlRwLzxS0tzjIbcB9qcdCmfe7H45RAdKeQ6N8pcKiUFD5/6WLctQL45QQEKKHwHedEFkkW/U6DE90so6hgv2uAR1AhlJpo/74pSUQbhaH1W5dX+MtoUR3746e7ZZfyX9D8S0Rcu+c/oZCl0xdMS+jhOS0pCf277kAE=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MN2PR10MB4191.namprd10.prod.outlook.com (2603:10b6:208:1d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 10:53:21 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 10:53:21 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH] MAINTAINERS: update MEMORY MAPPING section
Date: Wed, 11 Dec 2024 10:53:15 +0000
Message-ID: <20241211105315.21756-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0101.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::16) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MN2PR10MB4191:EE_
X-MS-Office365-Filtering-Correlation-Id: 2367bd07-1a52-4e7a-6764-08dd19d20717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9+h9TEfgB6lB/RPPGkh+oVY4JX/L81HoXO62yKgf4ZdTtWkEEdnUUAIWvM+i?=
 =?us-ascii?Q?icGIUhz6zh9k69HhP8w3BMNAujd4segReQsQjTD5V7Z6tbzpLnPiW1KY8IEk?=
 =?us-ascii?Q?ykgPVnOkyI8l0+UlG3E1EdiDqz1js73cJ9DaCdxl/rbTdUc7CKmxzJtsUg6G?=
 =?us-ascii?Q?nARBWsV58f0AHp/3AhG810IgbNLLbBwb9An76j0zKrve9DiuDJkhaVQikc4M?=
 =?us-ascii?Q?nJIo1U4d45oj0ZaBDaHIUtpRHz5ySldM5u6DOdA+tIDROvkTzAg4oOZKA+J9?=
 =?us-ascii?Q?zEqsv+zmzIZlm/cIY1rPysAjpDeqGRtifRJVvXfhnjMpZ70D5bRogXDr24x6?=
 =?us-ascii?Q?hpJPExEvksKQTBcmFZmdQHN0h71rV+3z2Vc64WAcospStqHW4rOe6WTj+RcS?=
 =?us-ascii?Q?DICy2mfbE0QP8fs87YNZHp/6oS57hdBZZbtUs1eYF4XYl/MDO+ptxhNulWp6?=
 =?us-ascii?Q?fxRWyxmpeQ5P9qB4FImFXOTDkehTRnhjb5fJ7itWAiJ3CvhmOgDbwbRl94b2?=
 =?us-ascii?Q?7GvCR/64wAa2apTF30zrXZYe5pZgq7TBLplx5+RIyNJBtdDEP7pQNrULxwgc?=
 =?us-ascii?Q?vRvBLsbyXOFlYJZ12uc2A+CchFzJOrKBGaAyLIxolylr0AgndBOcpf4vCTQC?=
 =?us-ascii?Q?zROKepwSlgRRS0wbkHh2MUTkt40vrhf2v1E/Ka5l77sAgIkazLTplHjcqVZS?=
 =?us-ascii?Q?EQ0rw50U9HxSDQHL4yI+6ZynILJlx+HNrBF6OsRMUs2h+6p/1tqigQh8duMC?=
 =?us-ascii?Q?UzlFIdxMZp6lM44S9Na8UDbDM4sbLKczEcufdcBZ96gKYT60Y8A8GRJV6FQ0?=
 =?us-ascii?Q?5YHLJsysmm7xG1bNdIOwN6epz0mxhP8yGs9zx067BiBC6G2nqrVJ5G3ckB+4?=
 =?us-ascii?Q?YgvC7SMCaQ3hAzZac7r2/yKqEtirnavtONBbxMZP6ZKo+IoQ5DeX/UTWnnaB?=
 =?us-ascii?Q?qDPMqstpGeGe/6KZGn/sKxAtXSHZcZ+NDCEwNC6yRZyzhf+oNqh3G13Eq6J1?=
 =?us-ascii?Q?BHD+GMaCfa+dcheO27vWIjPljm6E4zzlUYJq+xN7jDb9ojQ17tXnmYBdc3Zj?=
 =?us-ascii?Q?2yriQQeezUx7zkyvMLeVn7DVVa+fgVZps7mIkAmYDNDn01s8AVwSRV9njRn1?=
 =?us-ascii?Q?dQFLxc1XzI3+P10eEYxy+Gdhml+2VwTkYB3vvkWtmEhBT5KjlcKvzDBmPjqq?=
 =?us-ascii?Q?RDJQwPEyCBHTCx+bcRxRUF6jYDRuitpLWmbZ4iL13Siokbj1Qxoq6UMscvvk?=
 =?us-ascii?Q?6Df35m9+dlTJJselDoaUz35/8GpAnxeVEP4TD1hKYD05q0jKeYogsMxTpugG?=
 =?us-ascii?Q?ldQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V2Tfk94RpVY++uv7FqmGL+YhY/C8H6eB3zTmaAJL3d/0jbgx+IwEe9LRpNk8?=
 =?us-ascii?Q?qCMoh9fVl6AQEcuhC0lfUTxup4ZHifatUw5FM3njecK3t4BOAubOPv+Oy7sw?=
 =?us-ascii?Q?V+BHxrTlWe2q5O9vFzVpqlQByI5VIeQK5x9AWlbNb3jQRPYZF3JAcdgDSa+B?=
 =?us-ascii?Q?gowPsbrIDFjcALbQX6p1/Yg+UFg9qehgCdv56QgGdgLnlQ52x9C4yqm6CVyl?=
 =?us-ascii?Q?PpbmKbXIG/iPjS/STx5ylHZOaxlCPp689FS6GpPqaxPY255LaPs/X5XxjGtH?=
 =?us-ascii?Q?IBIuGNJk8JFByy+bQWAKFenToSigNLFvwPaQtt32TJyqpvYvcW/OcIA4aJHL?=
 =?us-ascii?Q?L8MGPAA2slM9oLRjEAGp6aiV1xgAE5yoTdkMsY4UUEHcHLAmMah710jGbbGj?=
 =?us-ascii?Q?26V73hyyreLnxhdieAuNYatfY4JjhrvGtnHjSX+9XE27cGVvW3IRVIovBYxq?=
 =?us-ascii?Q?j8otwdtHHZmmuAshef5Q0GwdYKAMngx3Vy0/UuEqFEviTzIbrczDKoxABXgv?=
 =?us-ascii?Q?6P0iowDBtCXYTKbSVZQxQj16G5KLclDgdhwMVIw8zkspjZOL+Ic8wkFGdDDn?=
 =?us-ascii?Q?gWSqIIzhWrlDq29NkafFc0s6nnw+uFX40IAfsEqNZ7LE+3rETn2uyugoRGuX?=
 =?us-ascii?Q?nj3IenfrsKFIsBxkMsV5kvjsCNAsn1yRNwE8FnVwrInc21kqrPLx/fHTRRCv?=
 =?us-ascii?Q?ufbNMhniwWCwtlHLSuhHjbPiqop9/8yL0HUMOX3UZactYoFD8ZrtgpKUPXlr?=
 =?us-ascii?Q?9C37BGCnlx7rYu3cFOorW+k9aVUbA58VFCLF478AZcq7YriUw/R/hYZkxIvI?=
 =?us-ascii?Q?ZjNNi5q823YzCz4gTKgznbvINRHFENspNH2okdy6KNt5bhQFkH/6sVXxEdNf?=
 =?us-ascii?Q?bfxIXJCp/HZe5etGuAa7Ai2yx93kaNlAMCaahw37kvZ/H8cEMnV4MV7slR4l?=
 =?us-ascii?Q?065Rim+qz0rIRcVRjgm912X0r1PBjx00h12WnHIIYI6Pkt+t6IycqnezfXn0?=
 =?us-ascii?Q?pcgKm3l1rYtol6i0UuV5GM80pOF72ZZCUix8M5et/zXZJfM1wicCNAPR7VL7?=
 =?us-ascii?Q?PUOcbRHPtYRMJaKwG05rLEHcn5Uo6uLKbjbNfBiSuFAYy2gtKIreR5Elvo2k?=
 =?us-ascii?Q?KMduq8mDXJgPGtv82HYOjOEmmL0LlHet2UBl7NiT5rb0VesYh7WZ/duIjg3e?=
 =?us-ascii?Q?q1uB1n+cLF+7tD6IbBzahj06UzCZsKufQbZUbVRt7wciH1VMjwpWEOt8ssgS?=
 =?us-ascii?Q?T0AEYHfCBkRnPQvU+KPwcpYYVFSs0w87Q4tudzcVTIVl/oQMeJ3Wi9dAX+UP?=
 =?us-ascii?Q?cSR4kcWvjc4+71nL1LaeiqGgdzqEnwkisXOeLqcuNz1Cid/7UQUqRnmDNmdj?=
 =?us-ascii?Q?pbIpuU8BggDFEILtn+J28AKC83xuJHhD+W6pROTNgU904D1/uZ4Zw6vmzcl1?=
 =?us-ascii?Q?HoKyJm6MxzPO83pP0K/S7belKcuIEvmkWzNZgGROTiYnYd1+gi62L/oHzoGd?=
 =?us-ascii?Q?tT+UEKr8XCHD+XCb+TnGCmJi+HBSAiDtWTM3aJ3d7tp61Unq267kw4GzY2sO?=
 =?us-ascii?Q?rcZoSguD4LLSouY/VBB0jPl+GhCVszd2K96yNsEQAdXV/nyzfYRj7DopKPtP?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EbFnz62sSLX6aIzh64jjaNWNvmDJ9fgs9ezayzD9WEvKJs56MNTE/fQ3NOldO6NWSzFvZWQVoanv/bX2MZ94QineouIg8L6xkltUDah6iHfHTublnmsewS4asjGuKUg/X0uT4ZVuWPz4wv/ZXOKwo58OyRWLvZE5t1nlSPOxlFhxk5iH5xsZfj9ZwR8XcNR28+JsoiLrzj7sSXd6Yv8btMJMqT0wLMbZr+6gvGsCIU13p8uGEDdHRhcg88O04GGK18dmRVt6Nle+C7qNJl7OjMgKQupFVXaojbmORkW/AbSNRFCKDLTe2vB1OIYh6lvPaLWMlqiZ1HLFZTiNrs1CPmjVt0r+LxbYbVS1QxvNzRDOdupr0Sy1tEFT7wTJMOvG5ZAY6DuqzqQjBrgTBRJPVgmSw9DzrbeMrVocF59i2YlRF6c1c0tJpVMN68RrOLlkWqt5pKf2L1rentusb/V5yTc823Cp8aqvAmh1dkPi0sLUqh85krIPCPeb1Wmrc+nrImdho0f0mVJAs5dbeQZrY3FVCpXc7/s0iu0FNOzY6pU73YZvOmRQLxNF41AfUD/H5JGvmMmmL9dMweqzv49jiKXofWANEuRIsKhfPfKbyuA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2367bd07-1a52-4e7a-6764-08dd19d20717
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 10:53:21.0362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YsL8C7Sis3lmyZfOrXYww0VU5iR2ssqRXHsNYuZW/h7kvOM7yNwxlcMVFPXW2UzLCJ1v7WKDSWEYFF65OZUih3pIBWUl3W4xj2PM6LpTp6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4191
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-11_10,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412110082
X-Proofpoint-ORIG-GUID: cvFskWivMXW-4xYL9Pa2wUZWzOAx_d8d
X-Proofpoint-GUID: cvFskWivMXW-4xYL9Pa2wUZWzOAx_d8d

Update the MEMORY MAPPING section to contain VMA logic as it makes no
sense to have these two sections separate.

Additionally, add files which permit changes to the attributes and/or
ranges spanned by memory mappings, in essence anything which might alter
the output of /proc/$pid/[s]maps.

This is necessarily fuzzy, as there is not quite as good separation of
concerns as we would ideally like in the kernel. However each of these
files interacts with the VMA and memory mapping logic in such a way as to
be inseparatable from it, and it is important that they are maintained in
conjunction with it.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 MAINTAINERS | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 68d825a4c69c..fb91389addd7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15071,7 +15071,15 @@ L:	linux-mm@kvack.org
 S:	Maintained
 W:	http://www.linux-mm.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
+F:	mm/mlock.c
 F:	mm/mmap.c
+F:	mm/mprotect.c
+F:	mm/mremap.c
+F:	mm/mseal.c
+F:	mm/vma.c
+F:	mm/vma.h
+F:	mm/vma_internal.h
+F:	tools/testing/vma/
 
 MEMORY TECHNOLOGY DEVICES (MTD)
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
@@ -25019,21 +25027,6 @@ F:	include/uapi/linux/vsockmon.h
 F:	net/vmw_vsock/
 F:	tools/testing/vsock/
 
-VMA
-M:	Andrew Morton <akpm@linux-foundation.org>
-M:	Liam R. Howlett <Liam.Howlett@oracle.com>
-M:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
-R:	Vlastimil Babka <vbabka@suse.cz>
-R:	Jann Horn <jannh@google.com>
-L:	linux-mm@kvack.org
-S:	Maintained
-W:	https://www.linux-mm.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
-F:	mm/vma.c
-F:	mm/vma.h
-F:	mm/vma_internal.h
-F:	tools/testing/vma/
-
 VMALLOC
 M:	Andrew Morton <akpm@linux-foundation.org>
 R:	Uladzislau Rezki <urezki@gmail.com>
-- 
2.47.1


