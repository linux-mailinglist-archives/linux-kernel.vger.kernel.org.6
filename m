Return-Path: <linux-kernel+bounces-294694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C3C95916E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 01:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E244B281D32
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 23:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC141C9DC1;
	Tue, 20 Aug 2024 23:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c5Mayhts";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tGkkCQeY"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CA81C824D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 23:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724198290; cv=fail; b=LWYTQ30UPqoSBFkOhxyoZ9AUx+NlCnTrWVTjS17hC6TeRxgsBLNnuuSB6XXJB4AWpSev+hkm1HLXo2h10jigCSPJy9DRq+3EkYrsUtz2Jyace7vPGdzyydFpVM+58QUBUk+8qMePRGBPDjP8DgMJBiPjR+6IE8ckvH2dy3/QFNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724198290; c=relaxed/simple;
	bh=lb0DvUf7lT2aEleY0mrPH5BP8Wz10BmmlxoNIxQQqdM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=b/iY2mz03Qvl8W1Yxkf3HGfnO4rf1PVK63Z6HquEo6ZUHMmbKfweOaj+htolD8FhwRzuv6RAnh+bRE07IfcEx7SSej4qcKynz5JbX7Ns/hCPCLFZxV9aQV0fvooXTm0lLbnQSLntibkh0j6u3mgjLqnj8/EBmRBNEABoZ7eJOxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c5Mayhts; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tGkkCQeY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KMBcpc004992;
	Tue, 20 Aug 2024 23:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=mXWenMb99vNTMj
	AaCToTZHadIQefeJ/dn39gG0a6vXM=; b=c5MayhtsOK3insdbuILD7RTWAK1lkl
	BbcHzXm0wYEAd3zcYwfiA3uYanAGvy3tip1GbG4wJ72g0qBGxk9qzlh65/FfztWZ
	MYmAkQAwVRm7Na9I97Bis+Ax7SKmNMv/zA7h1G1mUzsiytxabT7poQS59mLLGAoA
	HGCweB45cTRNvBPj1X5Gmp/W+udHzTOKZv8P+ileYsnzlSS/e9KMvPPs8yUxdFTt
	VR0CdIIIPydYIf8Wf2u3OCscXZOo0Nfzbnf/14LbKW8xLRQd0ptkTm3bl+5XV1MU
	uNB4NbisTfrMuM8bFtcRBfoxZ/lH/sJQseN3z6wNVQsbPZbhU0rjtsQQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m67e8qc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:57:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47KNY5xQ023499;
	Tue, 20 Aug 2024 23:57:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4154x78fra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:57:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OC7DWZ9VJSZPIB+dB6ygfdRyKqihGiPFdt745EbiZKxFbXJHFMct3fLlSdFwqLYXhQpZR7QwCLgqG88qecoMDFhcYaLGPb1VjN4HBv+5VJw5bedZq158GhzE+qcH2X3JjrTbomVv4cYPgnxeBMCF13/2Iv16FjRxLBV4GeKoRiXFc/1Kn+I4jwlfWkwmujR6Z8R/rO4PisVox/NX9kSBGEnD/uECbvZqsyVY7jBPUTsrDf+42VU0BNN15TfDjdgqb0UyUkdPlMnRnpT29igDJyDQu4Df+SsmhQBj/Yp4naWN/klAF/vKjgoEL+aWOX7Twt5zmbrs+ZQYot0t80jrAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXWenMb99vNTMjAaCToTZHadIQefeJ/dn39gG0a6vXM=;
 b=KHnYWkybbpiGiCtFSWBk9SKwCFbjuv3CmsX9VjdquE9yNiEB5jn9JfF5fiRyFAwDSNw/OqsLg1+JzvTBWQHSxB61bg70Sn6iN3zueJEzAh0OOJVYUp268iku0JAt9CCE+MnpYJ6O1eGCRqnkfBpTcL3VO5L4icmGSzS3f0CO1ioT7+TdW42MQQWE2BWoGi+OcEsmhcDry37qSTNmEkHltPVlH15s2/A0ViI307ww9FQeYxZUf9Nunh91IzaCVN8KI0+DQGlRQwiGE32d2lpRDPnBc+oseQY00Z55XFxIJjbNs1JaUxX6lHRvu0PLeDrRY4JbnSNNUJmKzCi/A8BuHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXWenMb99vNTMjAaCToTZHadIQefeJ/dn39gG0a6vXM=;
 b=tGkkCQeYoQvQAEW15cCEJoa7E7OthkLJYEc8qUbGEILvuuMlhrEH9mGu41QtBFcJgLjZw4gSYQhkkl62xTnHKC5GmjyOGidZsCkSxhzmJhhMeepn3Sh0SU91fRMR6WwJuVOcZwYLJ134fnl9BPWSZ3PxKVOBK86BvQPLJ7uE2SQ=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB4757.namprd10.prod.outlook.com (2603:10b6:510:3f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Tue, 20 Aug
 2024 23:57:48 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.010; Tue, 20 Aug 2024
 23:57:48 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v6 00/20] Avoid MAP_FIXED gap exposure
Date: Tue, 20 Aug 2024 19:57:09 -0400
Message-ID: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0106.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::12) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB4757:EE_
X-MS-Office365-Filtering-Correlation-Id: 251ca3c6-3d89-4b91-5c3b-08dcc173e484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cubJEchTECytVHbfuEOhDMHGZF0K4CjyTODHkB4YC2p7yYohw0yiMYZdUUg6?=
 =?us-ascii?Q?0WosvwKfp66dokfOO+SiH88iQQNAhazAW7wJykb7FlGLOaC8rV0LYgKcfzoP?=
 =?us-ascii?Q?9Y6FUnPjCXTafl96OJhvb40z6XD1ra/3Ha59ilh3Gg0MkF4IfDEb5A7J45kG?=
 =?us-ascii?Q?qkJ6nL9yBvgRmpo/XOhea1Z1LJ+VztVbquRedd0FEaVbfAay00/BAd2P7V03?=
 =?us-ascii?Q?Y2/22n4nYRLuq4PRKmDksrGyvrp4YHPa9o6U5SiCyBu9P/fLVuU2qv2fblt5?=
 =?us-ascii?Q?7UNHq6XwoeUuZSQTVCPRZWaUrybbqlk9DulQcFZee01C228CwbWQPs2HSlbz?=
 =?us-ascii?Q?ANSD9EbjjDfXmq168MhJkyESx/0PO95HWnVX4zQ9glRjeRNYitqsm+SpZzm9?=
 =?us-ascii?Q?rgPR1pVCT75duYJNES1oCMyXur7Rpl1gJbfyU1bzpJBbu/FbHrjbjiaCClmF?=
 =?us-ascii?Q?1ZMeZAV9bLDVOdD0LS4o61PWxwDhBSzeSdvSfUnDm88SXE7+ioWlEXwEZwth?=
 =?us-ascii?Q?wF9bsHcgpyznUE1FKlprMIBVq/NFfPwp+0Pkx/8jX0CMt/b1JG29UFo52QeM?=
 =?us-ascii?Q?DPkt1esU0aP0RG0dKHD0AHIuEhlbtaKZ2FknImhMd/MGqiipD0XWhRV7iG+x?=
 =?us-ascii?Q?LL2LCbNECKPhVmwvAQ6ZMUVcKizj0BNGoCZ1jUnPXyVGYVuiK3IlJvuILsox?=
 =?us-ascii?Q?CdeVwzR92PCZvKI9A/cAYkchjKqi5m0g9Y08RNXgdo+HfAFezLOJveuUPhX3?=
 =?us-ascii?Q?hl8kVAmjlnNkRKnlNAtIo7+g+W+nv7mKMMmKVhs3f1H/V1z26YjwhiQDUegc?=
 =?us-ascii?Q?GCw4tdZ+WDZAjPucEfI79ydUTXvOUHJVV5CVJfFqJy/AEjtDHr6mN9Xcq7g5?=
 =?us-ascii?Q?cASVhxmW4VBvQm6OsOIUZPGZJBNkY2BWdA89i2Al+LE5XEOThqx6AJAPrT1H?=
 =?us-ascii?Q?Vzw1SmGE+4oqqxvX3vwX1yGPXdMlWPW21GG0UEKHNjzg5B0ph2kS6Dtk3cwW?=
 =?us-ascii?Q?vhsKFFRieLtDMd99KX6eIopa5r1vjqqZuBoKHLE/WHBzSIJmCayCjFRQrk6l?=
 =?us-ascii?Q?54gwRC6mJDQovoU7fTPbcdGV2NpynAQ1TAaptvoFzT2QniRykeowbRekGD0O?=
 =?us-ascii?Q?kvtSkqk2ZDKpL5aYPCvZds5JmlCM9YAopu5dTgTh6KtBNBUCunh28pP7ChKz?=
 =?us-ascii?Q?OTNYMWMcAQKQB1i0RD06AstqUzJzZN62wO3c51BKIQsGLQ0qqPpacXDqYBw/?=
 =?us-ascii?Q?z9qyyWD7pB3UXGdbsxPX3E+KanOy3Rwy7Czfvfsne4wpNR4luFWC2izQusoX?=
 =?us-ascii?Q?WQc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2CBkR2hBn31e0aj7JSM0TtNooehTKoGdt1ksNooFSMIhVItJTCZp05bptSAY?=
 =?us-ascii?Q?k2M38hyWO3p1lMUzb7QhelbZW2zjo5FIKQi+kHB+2+rOP07niymRCNGn8xOi?=
 =?us-ascii?Q?B/RoWerXY9UQz7O5w9kJlt6fkc/v5WIYUMwu3o+fAP+IqjjynNxs/Ug6lumZ?=
 =?us-ascii?Q?jMlH4tRSstws2OUDhwY5LiJM3j63W64HLtK4uYM46c0hqjjSWw05ENL9JlwG?=
 =?us-ascii?Q?hrIrXCL532+q11zJHn06PXEdEvycl2/t0w8pGh8jNxcDyZbQbqRddgFxy6j4?=
 =?us-ascii?Q?O7G4zWVnPAWgfiJIYWRD94D61kHrV9AjgxdMaVVOAz8y6W6z6vhxdxAqKpk2?=
 =?us-ascii?Q?fAuLUHPS8L2Cbr11yMBoKcWNwrCmnvVFXeBAdVe7bPx14gqBgPrpd+vJLZ+i?=
 =?us-ascii?Q?3lTdBzzqFWc+Kt0NHPkqJoS9qJOQISbU17w453Ah1cpxDqDTa0xmyiSPop3Z?=
 =?us-ascii?Q?nAwEdlCvCfsuj5/1f+6lZv83X2im5XQwwopY6585FKl/uuRK8oUGzusCHSYI?=
 =?us-ascii?Q?479rU0K/I+k6jptfzjzSQ5w640v77Pydq740wjwUlH0SZuv37SfY1FjR3Lmi?=
 =?us-ascii?Q?Gszp380BspIBj2NLuabcLqRbDbL1XmD9wcDvG6Exia8bFFXwE4L+vXAEsgqv?=
 =?us-ascii?Q?VZbpjXE9qDWtYcW6nKHauBxrfguatmNmmIjc1smr750CWWsSmGHc/AYVjApt?=
 =?us-ascii?Q?/YxwkMhOhQIKMPt/Wd2oUWvyXQh+UI+IG05di1Gz3eEtmDY0V/BFot3yF0Ce?=
 =?us-ascii?Q?xuBT/koi0NQXMWs3csWuD2HBAmzzm9cNBwaVt/GEESu3+MtbMC47tctTBK36?=
 =?us-ascii?Q?y2wOVWLNauCnXEef/zpkNWtNm6EzHUM8oRcqiKcG4myaQF6i7DHhQozhHxZp?=
 =?us-ascii?Q?v2ikhlBgf8AWavKgUQS4Ejt15BtXxaSL8GNJ45+DpRHbGW/5h/e44mjZhtxi?=
 =?us-ascii?Q?tVSngD3gKELjQLLi4CRml7quCnsF8eGgqAthvGk98G3GZ3oKZ5zeatTfnNz2?=
 =?us-ascii?Q?XR9x1tMih2XvXKE67/Ov+YuPK8MQMlnO+ZSCnhTA+toKCyzOQwFyzpiC/MvA?=
 =?us-ascii?Q?34naGBIn1+wp7Gz5OJUFOr/T4elufB/2GLP95wayCOKksD8toRE5GJjH2ofr?=
 =?us-ascii?Q?WZfIP/6xm5RO4yt5dHRxbujkcM+toFw3dXRlMmWEk8S4QvZ0zCT5hi0P7i53?=
 =?us-ascii?Q?IU4xessJS+Ctmr005fECqNGzoX9k2eRRt3Q88Yu4bEy5e4J8DqmqwPHTOIkP?=
 =?us-ascii?Q?pPIqTENdnIMrcgHd82Adk05GTsf4FJWsQEQEH5nKB6IrmDZZx2ucLfZPpQti?=
 =?us-ascii?Q?hdkuonsEVcvd2VsWYKjJLnR8O3i2nIF/7QRpacy13h7Fq6PERdb0fxEl4k2F?=
 =?us-ascii?Q?2T/VfMm4w0xTiTJ4DdVo7NI2G1IrA6jFZHLNjMWeAB5PBXaJH8X5vOOnUm77?=
 =?us-ascii?Q?NIFckxxT9ISZK0ZlrkmrJx9JBgpKShIlG8o2vWYlfg5F5WEoS7so13gQ5Q4m?=
 =?us-ascii?Q?knvaLp2yCwdKwe1hgly7u+SJwV35nMK0XnyGHlVb4Z4x2aKHZQDHimptj0yg?=
 =?us-ascii?Q?bslkI7bgAnvMWp5D5T6HJdNoDY0sdMrzUTEfjHms?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	il2jvYVvlAbXGFAr6f0BeJAa+Goe8Cw7ZKgspGrJ2KaWrtoxaBXPTIYhA29R39CY3lQb7RBfJ7hn1oPrZp1RYqQmxUEJNf07nmLBHgQgIOIGZOIrxqOeqqX1DVVLlnRRFCCGNRp5EtepcalSb+ivMMtx++bbtcfplSn1UH6JkKfNvZ1WpQb4xnZxm45M5SJucVRtLJpny6Im6NlxNN0BcrQOSRxnvPMW6tBl9VaNWH0XOpbDId/NdIfPEGNsvmF4CxlRVQwvRo4QBRieKfSEk1eJ5xyBHuIF2OxXLcLDPWpo2MNOUh+O6DQmOX/87xOzfbRtSMXSN/GeCGMo7LIi0UvRbdc9k/0GsP2Ic+5E6fedLEOuk9JIz4tpFdA46VLFf5ywztXDFxNVEP9gtHNQXGdzBzTimNM/VI58wRUNoeDX5PsZhEDAGZ4GCR+o6dY5DEApu0YLCf9VHXG4htTo3aq/vDrN8Nd+y/D0o8AS1+cITwkcTv/uQKfiz5uP9NlLxd35njkHJeEeXPEJTrpDaENCPf02vux3SO2+CaZ0D0/94WCspQ4wJYE4m7M49yxuFpTFR4wQXEe2I9hkYxF6xL1DqKA/JNsDRKxS7i47sLo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 251ca3c6-3d89-4b91-5c3b-08dcc173e484
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 23:57:48.0318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ge+KkRTnLt+kkczA2Dz6MGiwdnqOS+PrLHxIltFkDOLhIBE17DprqGcbW5DDSXiPDx8fsIIBwLGFqHxAQoVC5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4757
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_18,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408200176
X-Proofpoint-ORIG-GUID: eUIu2VhDS8eYu-_nsZv4xnD1sOEA6FOi
X-Proofpoint-GUID: eUIu2VhDS8eYu-_nsZv4xnD1sOEA6FOi

It is now possible to walk the vma tree using the rcu read locks and is
beneficial to do so to reduce lock contention.  Doing so while a
MAP_FIXED mapping is executing means that a reader may see a gap in the
vma tree that should never logically exist - and does not when using the
mmap lock in read mode.  The temporal gap exists because mmap_region()
calls munmap() prior to installing the new mapping.

This patch set stops rcu readers from seeing the temporal gap by
splitting up the munmap() function into two parts.  The first part
prepares the vma tree for modifications by doing the necessary splits
and tracks the vmas marked for removal in a side tree.  The second part
completes the munmapping of the vmas after the vma tree has been
overwritten (either by a MAP_FIXED replacement vma or by a NULL in the
munmap() case).

Please note that rcu walkers will still be able to see a temporary state
of split vmas that may be in the process of being removed, but the
temporal gap will not be exposed.  vma_start_write() are called on both
parts of the split vma, so this state is detectable.

If existing vmas have a vm_ops->close(), then they will be called prior
to mapping the new vmas (and ptes are cleared out).  Without calling
->close(), hugetlbfs tests fail (hugemmap06 specifically) due to
resources still being marked as 'busy'.  Unfortunately, calling the
corresponding ->open() may not restore the state of the vmas, so it is
safer to keep the existing failure scenario where a gap is inserted and
never replaced.  The failure scenario is in its own patch (0015) for
traceability.

RFC: https://lore.kernel.org/linux-mm/20240531163217.1584450-1-Liam.Howlett@oracle.com/
v1: https://lore.kernel.org/linux-mm/20240611180200.711239-1-Liam.Howlett@oracle.com/
v2: https://lore.kernel.org/all/20240625191145.3382793-1-Liam.Howlett@oracle.com/
v3: https://lore.kernel.org/linux-mm/20240704182718.2653918-1-Liam.Howlett@oracle.com/
v4: https://lore.kernel.org/linux-mm/20240710192250.4114783-1-Liam.Howlett@oracle.com/
v5: https://lore.kernel.org/linux-mm/20240717200709.1552558-1-Liam.Howlett@oracle.com/

Changes since v5:
 - rebase on akpm/mm-unstable + mseal patches by Pedro
 - The rebase means that almost all of these changes had to be modified
   to change mm/vma.c and mm/vma.h.
 - Removed the arch_unmap() changes as the call is no longer in mm-unstable
 - Dropped mseal changes in favour of using Pedro's mseal changes.
   These patches conflict heavily in munmap(), so I can fix this up
   depending on the solution for mseal(), if needed.
 - Added a patch to create the gap if call_mmap() fails and vmas were
   closed (patch 15)
 - vms_complete_munmap_vmas() now checks if the lock should be
   downgraded regardless of if there is a vma or not.  The side effect
   is that the vma_munmap_struct must always set the mm.

Liam R. Howlett (20):
  mm/vma: Correctly position vma_iterator in __split_vma()
  mm/vma: Introduce abort_munmap_vmas()
  mm/vma: Introduce vmi_complete_munmap_vmas()
  mm/vma: Extract the gathering of vmas from do_vmi_align_munmap()
  mm/vma: Introduce vma_munmap_struct for use in munmap operations
  mm/vma: Change munmap to use vma_munmap_struct() for accounting and
    surrounding vmas
  mm/vma: Extract validate_mm() from vma_complete()
  mm/vma: Inline munmap operation in mmap_region()
  mm/vma: Expand mmap_region() munmap call
  mm/vma: Support vma == NULL in init_vma_munmap()
  mm/mmap: Reposition vma iterator in mmap_region()
  mm/vma: Track start and end for munmap in vma_munmap_struct
  mm: Clean up unmap_region() argument list
  mm/mmap: Avoid zeroing vma tree in mmap_region()
  mm: Change failure of MAP_FIXED to restoring the gap on failure
  mm/mmap: Use PHYS_PFN in mmap_region()
  mm/mmap: Use vms accounted pages in mmap_region()
  ipc/shm, mm: Drop do_vma_munmap()
  mm: Move may_expand_vm() check in mmap_region()
  mm/vma: Drop incorrect comment from vms_gather_munmap_vmas()

 include/linux/mm.h |   6 +-
 ipc/shm.c          |   8 +-
 mm/mmap.c          | 138 +++++++++---------
 mm/vma.c           | 355 +++++++++++++++++++++++++++------------------
 mm/vma.h           | 153 ++++++++++++++++---
 5 files changed, 415 insertions(+), 245 deletions(-)

-- 
2.43.0


