Return-Path: <linux-kernel+bounces-447976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF549F3972
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A190D7A51B6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFD7207A25;
	Mon, 16 Dec 2024 19:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YSj7CASi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vS5csxOx"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01007207657
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 19:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734375713; cv=fail; b=oEXV0GZWMqYFKjNOaEqpU5KOJnpGsQzyVy8J2+rVIkkfToKFXt3RM/pTnmPsMexcJxKbpMiMIOm2tTic0DEJPR3MspW2owfEEnIiN/Pwrmrugf/i+/tFpexSM6NE4azTeb+4LdbdhEKbn7LYP4Kwjq/rQPeAYM9DMbOWy8TDq2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734375713; c=relaxed/simple;
	bh=NQM0D4H2qlgW8hJIPIDwcWPTHZvX0KkTw2MUG0e7l6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WPUsbcnJWG+79S2XjRxr4yhxkTdXVh6uy11zLYbUr2bodAeJoDbZgSUR4seZ4E5SVx+RTiiYyk2W7K9gXbeCxBf1qOBQPvnLbM8ZXgAFKwY1ZI+Ek9SDZboLV6Zp7KL8UqIZS+uTmRpfLSFAuGUuFzEyWGiGIKEBtScm4y+lBB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YSj7CASi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vS5csxOx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGItpm9011703;
	Mon, 16 Dec 2024 19:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=xuctSjfhPXjd0DVljUFQ32ExsSe+bdxch5aI0NlBsWo=; b=
	YSj7CASiDw7hNXqLt9c/twkG/fW0CIM6ivuTi4s0xYjXciADLr22ktfzo6i9dBzn
	6CCpgPnFs/k9m9TGwohJsYAbFto1UDT9qucoeZ1AlojkowLKgeVwWc5v4G5sozoY
	SWBi8c+OpmjlJPzAuypKTJptiT+BGfZZweGOWq/P6VkTVTHiJbjen0jsx0Hhrk7J
	+dtCfNTy7ibC52z5sW3aDwAuX3Xx3/6zzehqgHpXNMCQGUtaXg4jfmoIbj/lrARR
	habrrttLabS7/e3gCU98QJkO3HKcBEdW8wN9bErA2PpjymAGRlAzbGJ4M0a4wRgd
	qD2E1NljHJygCJuJWet2RQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h22cm2p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 19:01:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGHROee035805;
	Mon, 16 Dec 2024 19:01:33 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f7fd8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 19:01:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtvZbblkDkQpOeToSuuCyeDfzz1M43AiPRtCqoeFM4SXoV6x7hYgtAy81150FSM+AWYU+Wh5REhM7AAlk7O02XmcXdlV+IZk3D4ZDbf3HVVE25AiJlFT5295hTuWYXj9Wp4rlmMYd4NJ5fXcm/+R2DYLNylsPatJ58CT3BKtcfiwz+Rqpqx8x6DuTRXLmarvV6cCPUWc0PuajTA4Fuj8GtQySlgtUUdpqiugEBqprty5IVPuTnLoVCrDp7CT85gpi05+YHuYWxxJYntFvng7E31JEPnUxSgRRO48PPE5IjcHO7Gn2b1GSTO+NDCX82h4GDwy8PEnwbt83r3ncajQbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuctSjfhPXjd0DVljUFQ32ExsSe+bdxch5aI0NlBsWo=;
 b=yEZ3gDql46wJMexW2/TFuDOAx32CGYJxveJLSH/W6VJrG7xLXCjN236RKUDEt3oN05K79QfYS/zRmcfgvl6m1Pwzs0MmySqLHwbDYNxH72yKtWt9rmY7w+Ix6uO24Cyqx7kllJB9BoCNZnDXbMfzVYnsi2uAPaS6scef7HQXvvfFN3LRaUgCqBSa66RZCCSoR5lMzAJzfLxqbX1YQnDf5t7Dkjvw7ndmhbdKbvbpoyYG0Wm/DgP2LMSIwsM3u0vAWQgNwOjn/BqwbbCez7V30wR+46btoGRi52GLl/oM3QfMNAZ001IPxrSvEh9KWZdbnb6N76D44BPBXjd6LflvwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuctSjfhPXjd0DVljUFQ32ExsSe+bdxch5aI0NlBsWo=;
 b=vS5csxOxsov1KfRj5j2dqPxLEW7zwRvsEdgKdtrUnZy00u8PlgicrTgcV6aAEKPQbbfTPCpGOMZuALA9SQa774etZY4hi/3BO4D0KmtFUZKE1i5OMHMqj9Xiq0tZIDlwXfkPnicSSWHxH07ytNfOuUYuIfuN+j7O63R8x72QHXQ=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by MN6PR10MB7441.namprd10.prod.outlook.com (2603:10b6:208:474::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 19:01:30 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 19:01:30 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Erkun <yangerkun@huaweicloud.com>,
        chuck.lever@oracle.com, brauner@kernel.org,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH 2/2] test_maple_tree: Test exhausted upper limit of mtree_alloc_cyclic()
Date: Mon, 16 Dec 2024 14:01:13 -0500
Message-ID: <20241216190113.1226145-3-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216190113.1226145-1-Liam.Howlett@oracle.com>
References: <20241216190113.1226145-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0388.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::29) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|MN6PR10MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ac6efdf-7783-4966-8d89-08dd1e040d38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FwOvubTsVpMkSIK5N5So89HhDpaK8NoVhGf51rfb/ZD9A6KGDnaFtH8Jm15E?=
 =?us-ascii?Q?2AKamP9ojUGt3luJDV1zI/rwpGc2A/pyn1EbmDkywR+kd6S3rHrDJ7sGgw9f?=
 =?us-ascii?Q?77Q2tqlVRuk2uv5ewBPcEZs4LXBFF1upPr1Co+A5mNVvzJth68VBHs6fLmVS?=
 =?us-ascii?Q?zmF/gcJ87ex+j5lSqgcbzDqugp0+VB4W0iCQB7uAjfrLpJW8JUeHSq6MNFFU?=
 =?us-ascii?Q?ioBOrKgMpzw4Z1wki19Aczmf5szsfuIL/4IrKrU6a3wZtltYOMfYYaL+UDLW?=
 =?us-ascii?Q?yh1OlZ+RhvjPa+0fF4ZrT8DOZM2iotR7IC3Z1/YDl94iYfzanTZWQeAYaEQl?=
 =?us-ascii?Q?qlJ1Teqop0OmGgS02pljtIiPAHU5BQX373wxUO3j0JX1MC6v3q2stDQWb4k6?=
 =?us-ascii?Q?s+TuFl9XPm7Zr/MNj6E29nYiCwfhnsbm0XnlGY5eaLE/s6ofDSSPJQLZFSQU?=
 =?us-ascii?Q?9pS2R3LYxUYnD3tYl0zRYIFjdaBCLw+jPbQdVpl8c+IAazbAkc1Xx/KtmRtM?=
 =?us-ascii?Q?42CW4dhFqMlKZMBzu0BFLCvY0q7qTlwWiy59TZ++6c2fgjpTzr2qRb3RBbHF?=
 =?us-ascii?Q?dRDPRU+yaUSyUTdUOXxVcH0u1++pux+TEKsRtTgYQpRCOF0ptkEx5ml7Iyox?=
 =?us-ascii?Q?9V5JAx7Ah9NDlc4FD62HFQ3VxNOH3sAlHXzD5K9OI/+9e2iJWOnW+8CA739j?=
 =?us-ascii?Q?L55Pz3ReCLi8KfwRD73ECdfUeLQUB616EGujW0IJsoKa24vm/TCF3XWg/NDa?=
 =?us-ascii?Q?VwXvEPoA+ZV4QOFsbx3j6FQrwP6GiO4s3bzaBcf3JvbhFreXGcN8xV6+1STo?=
 =?us-ascii?Q?tHGsktTlDv3LitJI3iGfmnxwc0qaPcQtMo1rDkN8iY5AhZNBgU8Ippl3h5P4?=
 =?us-ascii?Q?63/Lkvdoo6dqQulHUkg7vHH+0GfCnPAeP7pCKI+0FDmVOmg1DtlaFL/nGOeZ?=
 =?us-ascii?Q?FuA3rzZToxkGUY0YissaFpyzscljMiMxMzmcMEb3XXCf2LkVB95fR0SPrdKx?=
 =?us-ascii?Q?9fXlLVlxi8XhzJv4ZRCn+oFdGZTYhXiHwU3OWZ4Qnc/IWP6uUV/fiA7pbTI/?=
 =?us-ascii?Q?MdX170vT7pNLfwZbXRF9GRQxGheTsfTUI2E6gFif1ELerjF4yyAMLC1T8UVK?=
 =?us-ascii?Q?2ZRHKQY2tzW40dWicS0phJYe2dC2QJ1QfSspMVPIrPxEOPOhsq2jkK9mW23L?=
 =?us-ascii?Q?KgJkMABr778BEaHBvYON3gdPVYCayVAurqxf2x6e4ZQMPBVW1rYL0mzewoOo?=
 =?us-ascii?Q?Q00uXJxtGHlOZbG94v0HPhpjW95lTf6YmlMsMSPqoHI6OORFXNZcQl3smSpZ?=
 =?us-ascii?Q?jpnHdl0tyVoA4QLV9EjP0St4/T0M0wICFnLbN7Atc88pDOrA8zh0eDU2qK2m?=
 =?us-ascii?Q?CiD43QUX6ABz71QbUXgwsCBjc8nJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1PEXxgchEBkZ2f0GbKHd7y73ZWdfVoxQxRRtGyR3ZFAFIRMjzFMMywur5eRu?=
 =?us-ascii?Q?zKVfmRBLGtUdq9+ExoBBVNePRmtPlbSXu403yQdJTBD/HmKNjKchyOiRuSSL?=
 =?us-ascii?Q?8YJL7OKzRAbBIj+Pke0M8HqkW9Fo4uLznNS9MQdZ9gSRWz0Rbn5GJWTBJ4EH?=
 =?us-ascii?Q?1jJHgKUZLevVl9kB29i+QUY/bXb/xp8cDIBaDSDubs9ShOC5mc587mHiG1a7?=
 =?us-ascii?Q?e6z30vmz4Bv3Ji8KJe65hSMnPb+c7VUsHOewm7F5Q/4b3Q/jpp+ggVbr/8B2?=
 =?us-ascii?Q?V3PGNcNzmPG6LSO5hRrM6HuMug7NIPAS1x3VTN+9ixIDdzGpjkFtP4+ENHKz?=
 =?us-ascii?Q?FijSA9Sp5bouQ1PcTTlsO2T/eOPBUWxDi6dtvBM8zdQimsiAH3AORL1eHtJK?=
 =?us-ascii?Q?gUTkltkzXOnf0MifHLY8fx2Nk7h4IoYHN91PY7RNSA5rxub54jgrdSi8M3Bu?=
 =?us-ascii?Q?HxPl7UfuY2NfsOa7ueU+eEZWPD3DzBFiL48lUGR1Fu3OzXHhdXzwkG3t7PeP?=
 =?us-ascii?Q?K853oTCEagcWQjdYn2W7BHGZreGZjnZ19RI9gRI+QJ5ny5M2omnd9wNQ0g2t?=
 =?us-ascii?Q?MWNfLYJWfoWlR7FgzZ7IoIuy028vxRAtqmr62AwL0XioUhW11feX6t9xt8Ut?=
 =?us-ascii?Q?OlZs0Aqyau451S/afvM+r01GynadabpMM9Lpmv5oi498xbt4/QXv7VmH7Vfu?=
 =?us-ascii?Q?4fabxxKhvxPzi7v48OorYiMqbiAVALOaGs1rgjtD2PWKHvZkN7t9U5mx7l7g?=
 =?us-ascii?Q?e8QdsgMjECzfqkjhq4LPZYv/aXLzVLWsUX4U0J7E+S0FlxATKsv6tzAls/zl?=
 =?us-ascii?Q?TBRlSkYkp9wltoeSxYSUVt5g0m9EIlOGhgTuSaBMWuU48tflPdWYKZmFkGIM?=
 =?us-ascii?Q?ov2NqwLakE6R+yzh+vwTEdKkjuXc0AxkdFi0ZFrMnIxpvnxDBtpcrFT8CL6g?=
 =?us-ascii?Q?jano3EMuTF+bncB12BwBJXwRgSlt1fvb3K3uXTrFUNZWv/09OE0XUqkPHbb+?=
 =?us-ascii?Q?Zmp8MElCWbsq3hu/OAybRqmbmJ65kYpCoXccyzA293P5oH/k/apZ/HBj4h1o?=
 =?us-ascii?Q?Wp9bqzcW906/+F/e13vuXBo7dRaUqHqqAKcx8i1xCNYcm+88GD8BCmeMQEkf?=
 =?us-ascii?Q?DjA7C8027Fp6UNIaXTxletJythE+iXhXPDEG6kNXUgBGEZBtutoj5dSuWM/W?=
 =?us-ascii?Q?6VuAb/DsvpGlRIPAq0r058Wf7SK2atuT+Z+8FsbyYuPAnTH8+EUneKr9fCLK?=
 =?us-ascii?Q?LKjqUvMvl+wfB8Ufoj7TNA7Sd+RvLJjI0pZBNXv6hRNp4StChbAiozGJ3+Fs?=
 =?us-ascii?Q?fMvP7IuVyGsclFFvysAYIOY1P76p7XaPivpV0+5WH7EnejXGJiMphWBzwWn6?=
 =?us-ascii?Q?vC0URkTa5JPDgAU4VifHNvkg1dfWN2megi3k3R4qfTqN1CqQqIhtjjDAHynC?=
 =?us-ascii?Q?se4gZGy/DfMwGW8eDoxHuYiy0nYuh3lG7rPFmoWxKjTbBB4md4r7wofo7Dgl?=
 =?us-ascii?Q?DHjgLV+VwTU2TRQZ5hNxxIiZTvJSW5cE+woa6p2AV+9xjxHUVfLUVbpe59dX?=
 =?us-ascii?Q?8uCbU6PvvOe8rYys7f1At7E3rc45rK7sdQz6BISa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZlGiKn04+0ry7ujA7C4KC0XZ6yI3o9o+D+vXvt+39LOqdPsIA4mkcnf4UwNg0bVS0OyUanPhsPEjmrR3Vd9Nag/620gsCriEAtl0foOoyYf9Lv8EV6SXCFgsNxuIlIIKobc3RRx5opPLSRDz0IXq8rGZLxhplOzwraPzM/3rIqn8gX3u9g4S5H4CBYfaOC8bTnq5pc4E+7BBpmAhTNsEsCSeJXDZ5GOjLug9Y32jjM+T2uFIx1p3Uf9i03dU/QiVTkCvx2ySFiQIITjl/1H46SBZX1qo1P3EwzCESHscdFz9rk/K563oMgGQH6KH0m/cTlGlrH1xTgQfJ7iGL+uZPMXVBeE75MErkAIDCTedjxYzsyy3/4wnQIbrvok+BMbQpvsLEhJDnGMulqqe94sugSr7HNW3jzil3lTyfG4rAid/XZ/lswt4NRNeK8ICjiWcyWFjT8ULqeXVy5/2h+3cYGZhjnAGbcdvy1AMQT+i91L2NdhVgdc6heKCsxjPofNKolYqh+Kh90DMNAdw2C30LaP9Y7NyLUZJJh5JjKxTSImqdCU6gCrplNdzGUzjXIwLJ2Xad6Pj/O5ba3TMR9+g0uZ9g82ZVxFE3Q9iMnBz8sU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac6efdf-7783-4966-8d89-08dd1e040d38
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 19:01:30.7999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hiUgnAxHBbYBQmDuiGxBG5EUxFyNJjG753wGDCQQ9jgdytGVdB71n+TJoxxBCguAG/ffz4nbySKjqQ04Dq3FBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7441
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_08,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412160158
X-Proofpoint-GUID: p7euNwSz0Q86VJB_gEJWJPy8S4ZJcWwU
X-Proofpoint-ORIG-GUID: p7euNwSz0Q86VJB_gEJWJPy8S4ZJcWwU

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

When the upper bound of the search is exhausted, the maple state may be
returned in an error state of -EBUSY.  This means maple state needs to
be reset before the second search in mas_alloc_cylic() to ensure the
search happens.  This test ensures the issue is not recreated.

Cc: Yang Erkun <yangerkun@huaweicloud.com>
Cc: chuck.lever@oracle.com
Cc: brauner@kernel.org
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 lib/test_maple_tree.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 72bda304b5952..13e2a10d7554d 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -3738,6 +3738,34 @@ static noinline void __init alloc_cyclic_testing(struct maple_tree *mt)
 	}
 
 	mtree_destroy(mt);
+
+	/*
+	 * Issue with reverse search was discovered
+	 * https://lore.kernel.org/all/20241216060600.287B4C4CED0@smtp.kernel.org/
+	 * Exhausting the allocation area and forcing the search to wrap needs a
+	 * mas_reset() in mas_alloc_cyclic().
+	 */
+	next = 0;
+	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
+	for (int i = 0; i < 1023; i++) {
+		mtree_alloc_cyclic(mt, &location, mt, 2, 1024, &next, GFP_KERNEL);
+		MT_BUG_ON(mt, i != location - 2);
+		MT_BUG_ON(mt, i != next - 3);
+		MT_BUG_ON(mt, mtree_load(mt, location) != mt);
+	}
+	mtree_erase(mt, 123);
+	MT_BUG_ON(mt, mtree_load(mt, 123) != NULL);
+	mtree_alloc_cyclic(mt, &location, mt, 2, 1024, &next, GFP_KERNEL);
+	MT_BUG_ON(mt, 123 != location);
+	MT_BUG_ON(mt, 124 != next);
+	MT_BUG_ON(mt, mtree_load(mt, location) != mt);
+	mtree_erase(mt, 100);
+	mtree_alloc_cyclic(mt, &location, mt, 2, 1024, &next, GFP_KERNEL);
+	MT_BUG_ON(mt, 100 != location);
+	MT_BUG_ON(mt, 101 != next);
+	MT_BUG_ON(mt, mtree_load(mt, location) != mt);
+	mtree_destroy(mt);
+
 	/* Overflow test */
 	next = ULONG_MAX - 1;
 	ret = mtree_alloc_cyclic(mt, &location, mt, 2, ULONG_MAX, &next, GFP_KERNEL);
-- 
2.43.0


