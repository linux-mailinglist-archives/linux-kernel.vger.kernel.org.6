Return-Path: <linux-kernel+bounces-378807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BBB9AD5A5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6779A1F23DEB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D3C1E130F;
	Wed, 23 Oct 2024 20:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EW2lFWf4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uUan/e/v"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F371FBC8C
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 20:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715966; cv=fail; b=QCkMiur2Ld+WLqpmkUWiuSt1BzJ+8FoUVuoNq7HZ36wfyeLA5TlJ91Bdslo/+8BXdxloDnL/lVqwDwYAV/WE7RdjgdLBP9zI3MojdG1vW6dOAPTMaYF0eZ/7yTLF/95aNg+aGRUGumOZIpgD57cnlg/vwjRHvnd9g/Y7ujLghgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715966; c=relaxed/simple;
	bh=9HHSHDknJDIkcUn4ReqKeG8cLbPBsaDVzMHMLx5oIyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q2LrM/F4QPKQi1mANCi8D06eZ4AoDhv9UfMRmn0LdG/wnUVUoHOO+EhjI+vLi0EU+jAyqSEq4dtv8F1g5n092lLwiW7tm8r5wEwUZBFZFKHVjAuJw5NcAjfoeavT+qlQ28177BC5htKMW5cWk5LR1DUcdJlovbOpFDWkAzGsDow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EW2lFWf4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uUan/e/v; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NKcahE005402;
	Wed, 23 Oct 2024 20:39:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=UJegJK5P09zD1reHH/LUQnoUje3wTD/Wt9CcED7Sn9Q=; b=
	EW2lFWf4vrwwN+wbHNdicCoop7reb+TshGdFiP+NOdmgweQ4WaE2R3J5YxAZkPC2
	YrdAJFgZ5BcCAmgt872/idZvNSLzuTlTiW943vHXAK8xNSJCJuF4BfFwcr4fUut8
	cwf3ugpfLzR/OCjCFpoeHidUTavT50J0WHtlPVEFTC9mAYrQECEeCZfHsDD/7iFQ
	wkuma2gMtaKKKKmNd28B7oWIGQugFWreEUK6ttfteERkqm92kji0svUr3njp4zie
	J3YtjDM1n0QkMBPWHgXbnwYUmMWcovwn6LmKzd6lrXVT6WSbkQsUOMQfOtEeRxOt
	ti/3uxgHEyOBnujGjnxLcw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkr0e4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 20:39:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NJMpf1039579;
	Wed, 23 Oct 2024 20:39:13 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhbj4dt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 20:39:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LVvBTp5U49Slfa4B4lOXOjKxhoXckoPfmcjdJj/9pXZ7xp8P/3v5W5OuM1HpFQslonNGbxT+cRYpTv6CCMXU29Phl6WBEUtPFgmHrYLmpwB/rFJbenXHNSl3G8A1djbdWiJu3iO5bO6it3exjizhDOmJ7dVpjBj47co3ioW1dMoL1WK3B86dxDrU7tVq0yC6dEmHtJrtMI9TloV4LTCLTcgPfFowqZTc8S5+9pDfJIsG9uq7dshvrzcdkrh+RhvgjGrEl2Wpq+OqFcTSJcFnE0c2PEL+HNUIwkE55zr7UjO3RNVs4+Z3RM+3xRe1HI2MDZ72z83eQ1KZPBMvsJfFLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJegJK5P09zD1reHH/LUQnoUje3wTD/Wt9CcED7Sn9Q=;
 b=Aol7WYtd/+FXTyUuuo5f84wA1CtItML9tRjIKCDLpG2dHib3PaK5rzqTajTBg2Yy1+h8GD9Ki1+W4Wh/c9LQON+52eeTaGiqV825O59UMnAXPU6GAKt+w+TaLZX+24/z9QbD1Fo6oD3qSRa5vG+3N0t1ir3qO7iBp7s4OB8Yf/1q5wFbDR/J++L0KRRswNkSWQ7F5/QXciQ9q990dsLJJDaXBJWbRfVRhhYypVbt8aqUiH7Kz7Qfhua0PrQRrIjN9akZ5uVCRR6lRNiFlt1EcdfNFqmZdqInednSbr/My4N9O0q9C4vAQI35OIQByTi/z590imRO6bDZRCx6oZCHIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJegJK5P09zD1reHH/LUQnoUje3wTD/Wt9CcED7Sn9Q=;
 b=uUan/e/vq83MDUXwp+vQnpf6O8SxMr/DyF/vCwrdIIkQ6gGWJhXQuM1LD+zk9LBQd6tuYj7AREL3DfZ6loAgfZFYPPxsYxkReiuwGVCMVgUqVsxPDN3HFlVGJB+2CSy8NTwrc11j/d03Dth1pzTEZiW3n5XlqaCDiycehO5InnY=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB5833.namprd10.prod.outlook.com (2603:10b6:a03:3ed::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 20:39:10 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 20:39:10 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 6/8] mm: isolate mmap internal logic to mm/vma.c
Date: Wed, 23 Oct 2024 21:38:31 +0100
Message-ID: <67d9ba63e203452431c7ee7802d3988bd1258ab6.1729715266.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729715266.git.lorenzo.stoakes@oracle.com>
References: <cover.1729715266.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0178.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::9) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: 8809d1e3-4e40-4a9a-409b-08dcf3a2bfa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0JAkxuIxstkFo81uIE4+QA9VSAX9uPTibYEip5676E1B6vJTXMwstWEHaauK?=
 =?us-ascii?Q?BQvFaEiMTYFhzDc98w8qq4wWzMTKW43DwfFTR03jHXZWSoZOzCg3OqbiTtCd?=
 =?us-ascii?Q?Whbjmd4szs3Hcc7ZxqFu3OTlPMV9+g09oLugt5m4ewWBSCuexiDYknec1JFb?=
 =?us-ascii?Q?GTAV5bbCAUdaYwl38v8xY7YvWP6RCXEn4PEOEpbsgaaaoZggDOOIr9hqLxOz?=
 =?us-ascii?Q?8BaI3QQmfExKAuK8AQE58KCANpei2SVZv5iBbmWlhvImhqzFw6KIjn5efczE?=
 =?us-ascii?Q?jxbM5kBmSaoBKCIc6f0oowDrNT8lDx2+PX42s3F2k00xTS457+szpFNnxMks?=
 =?us-ascii?Q?Sa1HFDil7jCVe3AmcR0MN7V6QXr81RYoNcej+JAgZydk/f9ajfOzCrYYbd2p?=
 =?us-ascii?Q?u2/C8SR6kk4PmNuBtsJVrHboc2Mu1w7VeSZwiPssmGk7cXrgnH0gl1aU9iV/?=
 =?us-ascii?Q?6yzyzjtZRydd/tBYuHHv+LHf4JCMqGGf6bmVnEUies0VuC99ESk1vqAgLajF?=
 =?us-ascii?Q?lpuJ+vtb6mePq+9Xm2kcfR/BGw/EhcF/DjEQmqJl+tzuABfpgL22EnA9PTVZ?=
 =?us-ascii?Q?jJ6lpD60/MGsKyOU45oLB7gaDJ1+VyUCKo8oYsDmmoT5duyHqiOlXlEMt0I1?=
 =?us-ascii?Q?e6OcsaeTq6q8iEg8VZNZnZ/o4Sir+JcjF87rqwsGPBnGvNwOBSGN9PcqlOlh?=
 =?us-ascii?Q?sFh0Ynm5XiGreD8qN66+SLGpWnf7DbQxjCi2hYiuayHaNDFzN4rOQkGcNCsT?=
 =?us-ascii?Q?6ZyMim5KAZiqfa9bioEd982UGqnEjiQTYDcbYorrt4s27ldQf3Z6mHOTBH0A?=
 =?us-ascii?Q?wPLZZKEvePM1sLSBmCsYkbwKmReF6Nf+Z7I5N0SE82Y9qJDVg9lRSAbU7Sez?=
 =?us-ascii?Q?NGYMhneu8AhQz+CFISYoh/efg0sUGKDY5w/TL7O8y2RL9zfUJtUBJfqGkPTJ?=
 =?us-ascii?Q?Gp36MQwyqP10AlSBGgmOB3S/vbf4cWmj6hY0zjVLekQ98iwPOn9iKzmDnD8W?=
 =?us-ascii?Q?4D2KxFXGmOSZFZv5vmGw+G1+xHGQa1BoymKWLLSry/3Lt6mmHAfPGX22uhFn?=
 =?us-ascii?Q?ncZZwKrCqbY6aJl9YhzUpVsDBW/jb78sMZeyjscJahpt5zkSClysQZqbNhga?=
 =?us-ascii?Q?p8mutU5fxT1u4ncYDgy/Ix1hVhgMGzuZPEaMmpuqvr/1d/S3ADJNQwpMtxk+?=
 =?us-ascii?Q?E7Nq8ExXcyURzjJD3zsM0csBkbXFZNiwnwj8YiTbL8KEQMh5Rw/r5PUWHFJI?=
 =?us-ascii?Q?RujxBHh6RDcWVsXYyiNN0MluPRMkw1f9pFwOCKFiaJMBBRko5YJ9vw+BUmOe?=
 =?us-ascii?Q?26dfRszJhvygkV6xpnsEVwLM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ajRKHCrAXrIqzquSqHEty1gvdwmcowUrkvqBD27duIRY5OZAry4Ic93RZ1Yd?=
 =?us-ascii?Q?Bcqh0uLj9rhGaJ/oqoyNBzRTpupU2dU2yOENo5hmpvwiNeSu/Bjp0qQHLIej?=
 =?us-ascii?Q?ZdSGYj7vVqBeoli7n3jFSUwg/TGo+j5Y5UIqDpTjhQ3QMRr55OkbCFgC6UWe?=
 =?us-ascii?Q?pgHsMWBTgUhrnRBHEjF0XmaDcGVoAPYCctz8Vqd8hDJhJX3tV4IRcJXB7rrc?=
 =?us-ascii?Q?//feMcidVr0lKRYIZFVOjC9VCoNP7q77sbit223hZeZFf/R+xvjFhb76qdCX?=
 =?us-ascii?Q?GLl45TuTsL8QQH59MBuoh5Sg51h5mlHzO8TnV51ir0TH4EiZ1tzK6aDawMCw?=
 =?us-ascii?Q?91NwitWSMwdGP1tQ5oVaS8YNABgEY0GgNBxirQ3VXXGLzrAvtK2Pt+G4QuID?=
 =?us-ascii?Q?DWKy+DpCb5/N3ojT2aSZ9b89p7h2uBGzffAb51qxxqfbEZD4lxvJGmaPzQwC?=
 =?us-ascii?Q?pjmh4HmAoPTYLDINSHb5voMBd4AGUt5JUAP4r6etMGub9yE4usSFz6wwMfk5?=
 =?us-ascii?Q?G2i3XnqMYnL5O3tDpr4oEKKMgs5irLiCjiBaGmV1/BXG+JXQ9Ffhbs0yBAfC?=
 =?us-ascii?Q?Z3AUkUd4HGJmvHVzcZEFSztzWjQLYeEDY9Oa3TVLEqpNWYNOPffix2bDnzrB?=
 =?us-ascii?Q?WtzfjeuoVDl2caPEOTsfayEiYTathu9+Uxy5Zl7LFR/vKJfJJtJhuX2XPMXt?=
 =?us-ascii?Q?5VBPsiaV+fzfGa33qcrci7bt8GIgHML08xew7W/y39+V2kIXgMEENtY9XtJz?=
 =?us-ascii?Q?2JntLEJh4DvfNBCE1iiuswF2WUtC8onLhGEm9eywma0kS37b81kCFqTSKuct?=
 =?us-ascii?Q?aIIVU3fg/ty0MF8+K3IguDGnB0VfYq7/UqNHSrrnnPTfcWGgrWvdKpw4APf2?=
 =?us-ascii?Q?2g/jBpkSRDVwYXi+ep0HxxdXI9zRYSjRe+FuBZolMIHUTbLLPWz403a8I9vq?=
 =?us-ascii?Q?+akFWB1dkNadrZ6tx0eoxpV/GYdoeDB3+jVmh1Vk7e5qkt1PFXjzSyHi9Ey/?=
 =?us-ascii?Q?l+zgT5MlaU54ZqiTz1RjsrGNXA/5V5LVgw4xRaSMPSzhm4iD0BbzddbwiV0A?=
 =?us-ascii?Q?gQ1cqp59+3YmcStujOW56b2oyKIsVyGT/nPQoABNlqyrRHwDLLY64ceLSWV2?=
 =?us-ascii?Q?Q7RAdPgnCSNUfp03qrWuObmKb/L2tkVNqfofVSqBLJyhQ2ZUa7tVyu0aGanP?=
 =?us-ascii?Q?bamqgYcFXEmeBFdM8ydDjC8TdmEMFLipOHKMVa7NKt/GiLxj8WW90K58udVA?=
 =?us-ascii?Q?UMMhG2m9ETp/r/zocObik2WP0IH1DQz7dfN+Gsbytcmfa/ofQQrW/EhQ9vel?=
 =?us-ascii?Q?cHBeq6CmNgVzGPf6GZ7dugoft4rJ9BvfzpcX/ihg6RUT0CdIlzrMokIgpLgR?=
 =?us-ascii?Q?TrM4aUPeQl7jhT10ZhDDQmJd4e1npd5rESSO46vv1RiBGr1VMmU99wP6dMx2?=
 =?us-ascii?Q?J1RsYBUkDR2X1OuZ/epzy/H/3igV0ruLBwjP4TNOx5YoJXZadijF0xwqkZKi?=
 =?us-ascii?Q?Lefi0nTwgY/MoapxHanFv4P1VLdLjY0xdPPA5wY5Rw1tGCUA7FSK5d6zeYA+?=
 =?us-ascii?Q?oBbrTlt3/HyVbiGks6QTVP3vn3srCVjaV4YtRZX3mwb85ehyiFEN+pu5M83A?=
 =?us-ascii?Q?ovqV9yUDr6VBT5qPNKUmL2AuBv43Xi1YnRamqJNNqiZ+/zlKJCtvmfKDkkan?=
 =?us-ascii?Q?5WKYQg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JqPHJ9r8rqQ0KV12cUKRpKfcWLpwkkOdRrVHisRdYByUwJr90wAeftzxahtXhn9s0K0dEJHSbHf46W9jee9j9IHcK1nvjV6lKJzd/D04qH06EvM1DKzXhs5CahPVF+uajf6vvbHRgep+DFHXM5ECw1cVwySRNz+6DrnQNBb9wWJzuVziPDAhN46on4PRJ7Fi2RGQLkvqgsZNpBybHktZuOTbn8FcfnKYytXCdVgK9iq0SPtU2kO42Bqg1vgGwWhz4I5n1AMtyD9Wjq2cqmJdKDUumzLLYRHl7gReEQsriHoi7VI4BxRo2GMs4SguVT0cejA8UzRCGfBk1ZJydIqHGD6KV63gSCgz8t0TDDE3E+7bqdssvBOISeyQGQkFAwkxj6kOABmyJpx2edB8mDVRR/Morbob4S+9gfycvGyToMq0ByvB4bi57IuX4wBZoPw2SAgiWHgdTb6yyOL3IIn1NzH0zVQFhKd60EoLxiq7R8O0mBL7osIz3uhXJQNcdB2wHfFp/D6Fkjz8uXdoAkTxP/fbX8kDO1hiY2lz34sZgwmFoy5EznmyVuaNLlppc6BBr9WAVtBrpDOFOHL1vB3p8XuvCc/p/i5uJrcXhTcWb/c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8809d1e3-4e40-4a9a-409b-08dcf3a2bfa3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 20:39:10.7486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Icfi16DXD6lROd2jR6UWGONfDQNg5CXv+9cF2DSbu1wtGGk3NmxwXPRRhB7rwH1BKIlkO4ER6hgoo/NqFiWtkTjzFjdBVQbxk5oxx3KSCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_16,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410230132
X-Proofpoint-GUID: NdrEEQCvf8Dfy0wg6hR1z00SdQhSvRPk
X-Proofpoint-ORIG-GUID: NdrEEQCvf8Dfy0wg6hR1z00SdQhSvRPk

In previous commits we effected improvements to the mmap() logic in
mmap_region() and its newly introduced internal implementation function
__mmap_region().

However as these changes are intended to be backported, we kept the delta
as small as is possible and made as few changes as possible to the newly
introduced mm/vma.* files.

Take the opportunity to move this logic to mm/vma.c which not only isolates
it, but also makes it available for later userland testing which can help
us catch such logic errors far earlier.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c         | 234 ---------------------------------
 mm/vma.c          | 323 +++++++++++++++++++++++++++++++++++++++++++++-
 mm/vma.h          |  97 +-------------
 mm/vma_internal.h |   5 +
 4 files changed, 329 insertions(+), 330 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index e686d57ed9f7..0affd1a0687f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -577,22 +577,6 @@ SYSCALL_DEFINE1(old_mmap, struct mmap_arg_struct __user *, arg)
 }
 #endif /* __ARCH_WANT_SYS_OLD_MMAP */
 
-/*
- * We account for memory if it's a private writeable mapping,
- * not hugepages and VM_NORESERVE wasn't set.
- */
-static inline bool accountable_mapping(struct file *file, vm_flags_t vm_flags)
-{
-	/*
-	 * hugetlb has its own accounting separate from the core VM
-	 * VM_HUGETLB may not be set yet so we cannot check for that flag.
-	 */
-	if (file && is_file_hugepages(file))
-		return false;
-
-	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) == VM_WRITE;
-}
-
 /**
  * unmapped_area() - Find an area between the low_limit and the high_limit with
  * the correct alignment and offset, all from @info. Note: current->mm is used
@@ -1361,224 +1345,6 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	return do_vmi_munmap(&vmi, mm, start, len, uf, false);
 }
 
-static unsigned long __mmap_region(struct file *file, unsigned long addr,
-		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
-		struct list_head *uf)
-{
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma = NULL;
-	pgoff_t pglen = PHYS_PFN(len);
-	unsigned long charged = 0;
-	struct vma_munmap_struct vms;
-	struct ma_state mas_detach;
-	struct maple_tree mt_detach;
-	unsigned long end = addr + len;
-	int error;
-	VMA_ITERATOR(vmi, mm, addr);
-	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);
-
-	vmg.file = file;
-	/* Find the first overlapping VMA */
-	vma = vma_find(&vmi, end);
-	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
-	if (vma) {
-		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
-		mt_on_stack(mt_detach);
-		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
-		/* Prepare to unmap any existing mapping in the area */
-		error = vms_gather_munmap_vmas(&vms, &mas_detach);
-		if (error)
-			goto gather_failed;
-
-		vmg.next = vms.next;
-		vmg.prev = vms.prev;
-		vma = NULL;
-	} else {
-		vmg.next = vma_iter_next_rewind(&vmi, &vmg.prev);
-	}
-
-	/* Check against address space limit. */
-	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages)) {
-		error = -ENOMEM;
-		goto abort_munmap;
-	}
-
-	/*
-	 * Private writable mapping: check memory availability
-	 */
-	if (accountable_mapping(file, vm_flags)) {
-		charged = pglen;
-		charged -= vms.nr_accounted;
-		if (charged) {
-			error = security_vm_enough_memory_mm(mm, charged);
-			if (error)
-				goto abort_munmap;
-		}
-
-		vms.nr_accounted = 0;
-		vm_flags |= VM_ACCOUNT;
-		vmg.flags = vm_flags;
-	}
-
-	/*
-	 * clear PTEs while the vma is still in the tree so that rmap
-	 * cannot race with the freeing later in the truncate scenario.
-	 * This is also needed for mmap_file(), which is why vm_ops
-	 * close function is called.
-	 */
-	vms_clean_up_area(&vms, &mas_detach);
-	vma = vma_merge_new_range(&vmg);
-	if (vma)
-		goto expanded;
-	/*
-	 * Determine the object being mapped and call the appropriate
-	 * specific mapper. the address has already been validated, but
-	 * not unmapped, but the maps are removed from the list.
-	 */
-	vma = vm_area_alloc(mm);
-	if (!vma) {
-		error = -ENOMEM;
-		goto unacct_error;
-	}
-
-	vma_iter_config(&vmi, addr, end);
-	vma_set_range(vma, addr, end, pgoff);
-	vm_flags_init(vma, vm_flags);
-	vma->vm_page_prot = vm_get_page_prot(vm_flags);
-
-	if (vma_iter_prealloc(&vmi, vma)) {
-		error = -ENOMEM;
-		goto free_vma;
-	}
-
-	if (file) {
-		vma->vm_file = get_file(file);
-		error = mmap_file(file, vma);
-		if (error)
-			goto unmap_and_free_file_vma;
-
-		/* Drivers cannot alter the address of the VMA. */
-		WARN_ON_ONCE(addr != vma->vm_start);
-		/*
-		 * Drivers should not permit writability when previously it was
-		 * disallowed.
-		 */
-		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
-				!(vm_flags & VM_MAYWRITE) &&
-				(vma->vm_flags & VM_MAYWRITE));
-
-		vma_iter_config(&vmi, addr, end);
-		/*
-		 * If vm_flags changed after mmap_file(), we should try merge
-		 * vma again as we may succeed this time.
-		 */
-		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
-			struct vm_area_struct *merge;
-
-			vmg.flags = vma->vm_flags;
-			/* If this fails, state is reset ready for a reattempt. */
-			merge = vma_merge_new_range(&vmg);
-
-			if (merge) {
-				/*
-				 * ->mmap() can change vma->vm_file and fput
-				 * the original file. So fput the vma->vm_file
-				 * here or we would add an extra fput for file
-				 * and cause general protection fault
-				 * ultimately.
-				 */
-				fput(vma->vm_file);
-				vm_area_free(vma);
-				vma = merge;
-				/* Update vm_flags to pick up the change. */
-				vm_flags = vma->vm_flags;
-				goto file_expanded;
-			}
-			vma_iter_config(&vmi, addr, end);
-		}
-
-		vm_flags = vma->vm_flags;
-	} else if (vm_flags & VM_SHARED) {
-		error = shmem_zero_setup(vma);
-		if (error)
-			goto free_iter_vma;
-	} else {
-		vma_set_anonymous(vma);
-	}
-
-#ifdef CONFIG_SPARC64
-	/* TODO: Fix SPARC ADI! */
-	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
-#endif
-
-	/* Lock the VMA since it is modified after insertion into VMA tree */
-	vma_start_write(vma);
-	vma_iter_store(&vmi, vma);
-	mm->map_count++;
-	vma_link_file(vma);
-
-	/*
-	 * vma_merge_new_range() calls khugepaged_enter_vma() too, the below
-	 * call covers the non-merge case.
-	 */
-	khugepaged_enter_vma(vma, vma->vm_flags);
-
-file_expanded:
-	file = vma->vm_file;
-	ksm_add_vma(vma);
-expanded:
-	perf_event_mmap(vma);
-
-	/* Unmap any existing mapping in the area */
-	vms_complete_munmap_vmas(&vms, &mas_detach);
-
-	vm_stat_account(mm, vm_flags, pglen);
-	if (vm_flags & VM_LOCKED) {
-		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
-					is_vm_hugetlb_page(vma) ||
-					vma == get_gate_vma(current->mm))
-			vm_flags_clear(vma, VM_LOCKED_MASK);
-		else
-			mm->locked_vm += pglen;
-	}
-
-	if (file)
-		uprobe_mmap(vma);
-
-	/*
-	 * New (or expanded) vma always get soft dirty status.
-	 * Otherwise user-space soft-dirty page tracker won't
-	 * be able to distinguish situation when vma area unmapped,
-	 * then new mapped in-place (which must be aimed as
-	 * a completely new data area).
-	 */
-	vm_flags_set(vma, VM_SOFTDIRTY);
-
-	vma_set_page_prot(vma);
-
-	return addr;
-
-unmap_and_free_file_vma:
-	fput(vma->vm_file);
-	vma->vm_file = NULL;
-
-	vma_iter_set(&vmi, vma->vm_end);
-	/* Undo any partial mapping done by a device driver. */
-	unmap_region(&vmi.mas, vma, vmg.prev, vmg.next);
-free_iter_vma:
-	vma_iter_free(&vmi);
-free_vma:
-	vm_area_free(vma);
-unacct_error:
-	if (charged)
-		vm_unacct_memory(charged);
-
-abort_munmap:
-	vms_abort_munmap_vmas(&vms, &mas_detach);
-gather_failed:
-	return error;
-}
-
 unsigned long mmap_region(struct file *file, unsigned long addr,
 			  unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
 			  struct list_head *uf)
diff --git a/mm/vma.c b/mm/vma.c
index bb7cfa2dc282..0a2965be582d 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1103,7 +1103,7 @@ static inline void vms_clear_ptes(struct vma_munmap_struct *vms,
 	vms->clear_ptes = false;
 }
 
-void vms_clean_up_area(struct vma_munmap_struct *vms,
+static void vms_clean_up_area(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach)
 {
 	struct vm_area_struct *vma;
@@ -1126,7 +1126,7 @@ void vms_clean_up_area(struct vma_munmap_struct *vms,
  * used for the munmap() and may downgrade the lock - if requested.  Everything
  * needed to be done once the vma maple tree is updated.
  */
-void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
+static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach)
 {
 	struct vm_area_struct *vma;
@@ -1167,6 +1167,23 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	__mt_destroy(mas_detach->tree);
 }
 
+/*
+ * reattach_vmas() - Undo any munmap work and free resources
+ * @mas_detach: The maple state with the detached maple tree
+ *
+ * Reattach any detached vmas and free up the maple tree used to track the vmas.
+ */
+static void reattach_vmas(struct ma_state *mas_detach)
+{
+	struct vm_area_struct *vma;
+
+	mas_set(mas_detach, 0);
+	mas_for_each(mas_detach, vma, ULONG_MAX)
+		vma_mark_detached(vma, false);
+
+	__mt_destroy(mas_detach->tree);
+}
+
 /*
  * vms_gather_munmap_vmas() - Put all VMAs within a range into a maple tree
  * for removal at a later date.  Handles splitting first and last if necessary
@@ -1177,7 +1194,7 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
  *
  * Return: 0 on success, error otherwise
  */
-int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
+static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach)
 {
 	struct vm_area_struct *next = NULL;
@@ -1315,6 +1332,39 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 	return error;
 }
 
+/*
+ * init_vma_munmap() - Initializer wrapper for vma_munmap_struct
+ * @vms: The vma munmap struct
+ * @vmi: The vma iterator
+ * @vma: The first vm_area_struct to munmap
+ * @start: The aligned start address to munmap
+ * @end: The aligned end address to munmap
+ * @uf: The userfaultfd list_head
+ * @unlock: Unlock after the operation.  Only unlocked on success
+ */
+static void init_vma_munmap(struct vma_munmap_struct *vms,
+		struct vma_iterator *vmi, struct vm_area_struct *vma,
+		unsigned long start, unsigned long end, struct list_head *uf,
+		bool unlock)
+{
+	vms->vmi = vmi;
+	vms->vma = vma;
+	if (vma) {
+		vms->start = start;
+		vms->end = end;
+	} else {
+		vms->start = vms->end = 0;
+	}
+	vms->unlock = unlock;
+	vms->uf = uf;
+	vms->vma_count = 0;
+	vms->nr_pages = vms->locked_vm = vms->nr_accounted = 0;
+	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
+	vms->unmap_start = FIRST_USER_ADDRESS;
+	vms->unmap_end = USER_PGTABLES_CEILING;
+	vms->clear_ptes = false;
+}
+
 /*
  * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
  * @vmi: The vma iterator
@@ -2069,3 +2119,270 @@ void mm_drop_all_locks(struct mm_struct *mm)
 
 	mutex_unlock(&mm_all_locks_mutex);
 }
+
+/*
+ * We account for memory if it's a private writeable mapping,
+ * not hugepages and VM_NORESERVE wasn't set.
+ */
+static bool accountable_mapping(struct file *file, vm_flags_t vm_flags)
+{
+	/*
+	 * hugetlb has its own accounting separate from the core VM
+	 * VM_HUGETLB may not be set yet so we cannot check for that flag.
+	 */
+	if (file && is_file_hugepages(file))
+		return false;
+
+	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) == VM_WRITE;
+}
+
+/*
+ * vms_abort_munmap_vmas() - Undo as much as possible from an aborted munmap()
+ * operation.
+ * @vms: The vma unmap structure
+ * @mas_detach: The maple state with the detached maple tree
+ *
+ * Reattach any detached vmas, free up the maple tree used to track the vmas.
+ * If that's not possible because the ptes are cleared (and vm_ops->closed() may
+ * have been called), then a NULL is written over the vmas and the vmas are
+ * removed (munmap() completed).
+ */
+static void vms_abort_munmap_vmas(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach)
+{
+	struct ma_state *mas = &vms->vmi->mas;
+
+	if (!vms->nr_pages)
+		return;
+
+	if (vms->clear_ptes)
+		return reattach_vmas(mas_detach);
+
+	/*
+	 * Aborting cannot just call the vm_ops open() because they are often
+	 * not symmetrical and state data has been lost.  Resort to the old
+	 * failure method of leaving a gap where the MAP_FIXED mapping failed.
+	 */
+	mas_set_range(mas, vms->start, vms->end - 1);
+	mas_store_gfp(mas, NULL, GFP_KERNEL|__GFP_NOFAIL);
+	/* Clean up the insertion of the unfortunate gap */
+	vms_complete_munmap_vmas(vms, mas_detach);
+}
+
+unsigned long __mmap_region(struct file *file, unsigned long addr,
+		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
+		struct list_head *uf)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma = NULL;
+	pgoff_t pglen = PHYS_PFN(len);
+	unsigned long charged = 0;
+	struct vma_munmap_struct vms;
+	struct ma_state mas_detach;
+	struct maple_tree mt_detach;
+	unsigned long end = addr + len;
+	int error;
+	VMA_ITERATOR(vmi, mm, addr);
+	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);
+
+	vmg.file = file;
+	/* Find the first overlapping VMA */
+	vma = vma_find(&vmi, end);
+	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
+	if (vma) {
+		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
+		mt_on_stack(mt_detach);
+		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
+		/* Prepare to unmap any existing mapping in the area */
+		error = vms_gather_munmap_vmas(&vms, &mas_detach);
+		if (error)
+			goto gather_failed;
+
+		vmg.next = vms.next;
+		vmg.prev = vms.prev;
+		vma = NULL;
+	} else {
+		vmg.next = vma_iter_next_rewind(&vmi, &vmg.prev);
+	}
+
+	/* Check against address space limit. */
+	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages)) {
+		error = -ENOMEM;
+		goto abort_munmap;
+	}
+
+	/*
+	 * Private writable mapping: check memory availability
+	 */
+	if (accountable_mapping(file, vm_flags)) {
+		charged = pglen;
+		charged -= vms.nr_accounted;
+		if (charged) {
+			error = security_vm_enough_memory_mm(mm, charged);
+			if (error)
+				goto abort_munmap;
+		}
+
+		vms.nr_accounted = 0;
+		vm_flags |= VM_ACCOUNT;
+		vmg.flags = vm_flags;
+	}
+
+	/*
+	 * clear PTEs while the vma is still in the tree so that rmap
+	 * cannot race with the freeing later in the truncate scenario.
+	 * This is also needed for mmap_file(), which is why vm_ops
+	 * close function is called.
+	 */
+	vms_clean_up_area(&vms, &mas_detach);
+	vma = vma_merge_new_range(&vmg);
+	if (vma)
+		goto expanded;
+	/*
+	 * Determine the object being mapped and call the appropriate
+	 * specific mapper. the address has already been validated, but
+	 * not unmapped, but the maps are removed from the list.
+	 */
+	vma = vm_area_alloc(mm);
+	if (!vma) {
+		error = -ENOMEM;
+		goto unacct_error;
+	}
+
+	vma_iter_config(&vmi, addr, end);
+	vma_set_range(vma, addr, end, pgoff);
+	vm_flags_init(vma, vm_flags);
+	vma->vm_page_prot = vm_get_page_prot(vm_flags);
+
+	if (vma_iter_prealloc(&vmi, vma)) {
+		error = -ENOMEM;
+		goto free_vma;
+	}
+
+	if (file) {
+		vma->vm_file = get_file(file);
+		error = mmap_file(file, vma);
+		if (error)
+			goto unmap_and_free_file_vma;
+
+		/* Drivers cannot alter the address of the VMA. */
+		WARN_ON_ONCE(addr != vma->vm_start);
+		/*
+		 * Drivers should not permit writability when previously it was
+		 * disallowed.
+		 */
+		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
+				!(vm_flags & VM_MAYWRITE) &&
+				(vma->vm_flags & VM_MAYWRITE));
+
+		vma_iter_config(&vmi, addr, end);
+		/*
+		 * If vm_flags changed after mmap_file(), we should try merge
+		 * vma again as we may succeed this time.
+		 */
+		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
+			struct vm_area_struct *merge;
+
+			vmg.flags = vma->vm_flags;
+			/* If this fails, state is reset ready for a reattempt. */
+			merge = vma_merge_new_range(&vmg);
+
+			if (merge) {
+				/*
+				 * ->mmap() can change vma->vm_file and fput
+				 * the original file. So fput the vma->vm_file
+				 * here or we would add an extra fput for file
+				 * and cause general protection fault
+				 * ultimately.
+				 */
+				fput(vma->vm_file);
+				vm_area_free(vma);
+				vma = merge;
+				/* Update vm_flags to pick up the change. */
+				vm_flags = vma->vm_flags;
+				goto file_expanded;
+			}
+			vma_iter_config(&vmi, addr, end);
+		}
+
+		vm_flags = vma->vm_flags;
+	} else if (vm_flags & VM_SHARED) {
+		error = shmem_zero_setup(vma);
+		if (error)
+			goto free_iter_vma;
+	} else {
+		vma_set_anonymous(vma);
+	}
+
+#ifdef CONFIG_SPARC64
+	/* TODO: Fix SPARC ADI! */
+	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
+#endif
+
+	/* Lock the VMA since it is modified after insertion into VMA tree */
+	vma_start_write(vma);
+	vma_iter_store(&vmi, vma);
+	mm->map_count++;
+	vma_link_file(vma);
+
+	/*
+	 * vma_merge_new_range() calls khugepaged_enter_vma() too, the below
+	 * call covers the non-merge case.
+	 */
+	khugepaged_enter_vma(vma, vma->vm_flags);
+
+file_expanded:
+	file = vma->vm_file;
+	ksm_add_vma(vma);
+expanded:
+	perf_event_mmap(vma);
+
+	/* Unmap any existing mapping in the area */
+	vms_complete_munmap_vmas(&vms, &mas_detach);
+
+	vm_stat_account(mm, vm_flags, pglen);
+	if (vm_flags & VM_LOCKED) {
+		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
+					is_vm_hugetlb_page(vma) ||
+					vma == get_gate_vma(current->mm))
+			vm_flags_clear(vma, VM_LOCKED_MASK);
+		else
+			mm->locked_vm += pglen;
+	}
+
+	if (file)
+		uprobe_mmap(vma);
+
+	/*
+	 * New (or expanded) vma always get soft dirty status.
+	 * Otherwise user-space soft-dirty page tracker won't
+	 * be able to distinguish situation when vma area unmapped,
+	 * then new mapped in-place (which must be aimed as
+	 * a completely new data area).
+	 */
+	vm_flags_set(vma, VM_SOFTDIRTY);
+
+	vma_set_page_prot(vma);
+
+	return addr;
+
+unmap_and_free_file_vma:
+	fput(vma->vm_file);
+	vma->vm_file = NULL;
+
+	vma_iter_set(&vmi, vma->vm_end);
+	/* Undo any partial mapping done by a device driver. */
+	unmap_region(&vmi.mas, vma, vmg.prev, vmg.next);
+free_iter_vma:
+	vma_iter_free(&vmi);
+free_vma:
+	vm_area_free(vma);
+unacct_error:
+	if (charged)
+		vm_unacct_memory(charged);
+
+abort_munmap:
+	vms_abort_munmap_vmas(&vms, &mas_detach);
+gather_failed:
+	return error;
+}
diff --git a/mm/vma.h b/mm/vma.h
index d58068c0ff2e..388d34748674 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -165,99 +165,6 @@ static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
 	return 0;
 }
 
-#ifdef CONFIG_MMU
-/*
- * init_vma_munmap() - Initializer wrapper for vma_munmap_struct
- * @vms: The vma munmap struct
- * @vmi: The vma iterator
- * @vma: The first vm_area_struct to munmap
- * @start: The aligned start address to munmap
- * @end: The aligned end address to munmap
- * @uf: The userfaultfd list_head
- * @unlock: Unlock after the operation.  Only unlocked on success
- */
-static inline void init_vma_munmap(struct vma_munmap_struct *vms,
-		struct vma_iterator *vmi, struct vm_area_struct *vma,
-		unsigned long start, unsigned long end, struct list_head *uf,
-		bool unlock)
-{
-	vms->vmi = vmi;
-	vms->vma = vma;
-	if (vma) {
-		vms->start = start;
-		vms->end = end;
-	} else {
-		vms->start = vms->end = 0;
-	}
-	vms->unlock = unlock;
-	vms->uf = uf;
-	vms->vma_count = 0;
-	vms->nr_pages = vms->locked_vm = vms->nr_accounted = 0;
-	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
-	vms->unmap_start = FIRST_USER_ADDRESS;
-	vms->unmap_end = USER_PGTABLES_CEILING;
-	vms->clear_ptes = false;
-}
-#endif
-
-int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
-		struct ma_state *mas_detach);
-
-void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
-		struct ma_state *mas_detach);
-
-void vms_clean_up_area(struct vma_munmap_struct *vms,
-		struct ma_state *mas_detach);
-
-/*
- * reattach_vmas() - Undo any munmap work and free resources
- * @mas_detach: The maple state with the detached maple tree
- *
- * Reattach any detached vmas and free up the maple tree used to track the vmas.
- */
-static inline void reattach_vmas(struct ma_state *mas_detach)
-{
-	struct vm_area_struct *vma;
-
-	mas_set(mas_detach, 0);
-	mas_for_each(mas_detach, vma, ULONG_MAX)
-		vma_mark_detached(vma, false);
-
-	__mt_destroy(mas_detach->tree);
-}
-
-/*
- * vms_abort_munmap_vmas() - Undo as much as possible from an aborted munmap()
- * operation.
- * @vms: The vma unmap structure
- * @mas_detach: The maple state with the detached maple tree
- *
- * Reattach any detached vmas, free up the maple tree used to track the vmas.
- * If that's not possible because the ptes are cleared (and vm_ops->closed() may
- * have been called), then a NULL is written over the vmas and the vmas are
- * removed (munmap() completed).
- */
-static inline void vms_abort_munmap_vmas(struct vma_munmap_struct *vms,
-		struct ma_state *mas_detach)
-{
-	struct ma_state *mas = &vms->vmi->mas;
-	if (!vms->nr_pages)
-		return;
-
-	if (vms->clear_ptes)
-		return reattach_vmas(mas_detach);
-
-	/*
-	 * Aborting cannot just call the vm_ops open() because they are often
-	 * not symmetrical and state data has been lost.  Resort to the old
-	 * failure method of leaving a gap where the MAP_FIXED mapping failed.
-	 */
-	mas_set_range(mas, vms->start, vms->end - 1);
-	mas_store_gfp(mas, NULL, GFP_KERNEL|__GFP_NOFAIL);
-	/* Clean up the insertion of the unfortunate gap */
-	vms_complete_munmap_vmas(vms, mas_detach);
-}
-
 int
 do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
@@ -336,6 +243,10 @@ bool vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot);
 int mm_take_all_locks(struct mm_struct *mm);
 void mm_drop_all_locks(struct mm_struct *mm);
 
+unsigned long __mmap_region(struct file *file, unsigned long addr,
+		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
+		struct list_head *uf);
+
 static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_struct *vma)
 {
 	/*
diff --git a/mm/vma_internal.h b/mm/vma_internal.h
index b930ab12a587..fc5f172a36bd 100644
--- a/mm/vma_internal.h
+++ b/mm/vma_internal.h
@@ -17,8 +17,10 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/huge_mm.h>
+#include <linux/hugetlb.h>
 #include <linux/hugetlb_inline.h>
 #include <linux/kernel.h>
+#include <linux/ksm.h>
 #include <linux/khugepaged.h>
 #include <linux/list.h>
 #include <linux/maple_tree.h>
@@ -32,11 +34,14 @@
 #include <linux/mmu_context.h>
 #include <linux/mutex.h>
 #include <linux/pagemap.h>
+#include <linux/perf_event.h>
 #include <linux/pfn.h>
 #include <linux/rcupdate.h>
 #include <linux/rmap.h>
 #include <linux/rwsem.h>
 #include <linux/sched/signal.h>
+#include <linux/security.h>
+#include <linux/shmem_fs.h>
 #include <linux/swap.h>
 #include <linux/uprobes.h>
 #include <linux/userfaultfd_k.h>
-- 
2.47.0


