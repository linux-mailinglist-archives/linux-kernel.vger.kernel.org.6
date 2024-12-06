Return-Path: <linux-kernel+bounces-435760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 751749E7BF5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D22116D5C3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2070F1FBE80;
	Fri,  6 Dec 2024 22:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BrSFR7LP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s09qUvLs"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D4622C6D9
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 22:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733525461; cv=fail; b=HzrVn9WVKb1cBSX2rNrz7W1c5CNPuqi91sUyH6BusbThPtCglG7P7kioEL5IqP/kIxtaQid00T+hb/fzwGTn6VDg231/H2FRohoWwAVvJW8BpZH80ntKhRbF69L20kavkPDG+ODXC1QQ0/NjYp2uvCTWkDWONrsIPuVUxq1H5TM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733525461; c=relaxed/simple;
	bh=srdHUrGYLO+8s4KDDPeYLlCwUtvaddtv/p2RTMuTvHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=A6qNurK+oXVMVRItowJMOyIZYZNKogs2qD/DtqkzmPFF1N9KBcQz3LNo59TeA275rvlEzWKGyHwD6I98wuumTKdo5K2zaHgE9+yK/Wp/nvdoyYXUAOgWg1JOYXdhC+6NG6FpQSbzmEq7bnQR+eXVDoZQhObeOCeNZd0DYknjSTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BrSFR7LP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s09qUvLs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6LXRg8021400;
	Fri, 6 Dec 2024 22:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=5XA9GfmnZAsaRJ6f
	r6gUAoi5unMqR7D84zMapIfts9k=; b=BrSFR7LPqlJYhGd5cj9DYG50V3qdZkvy
	puNeAfe4HZD0g91qGWrqSfclLX+dqCJuTYCAX2/RrFupE+HzfdCrGfZ55E3U8sIS
	ALuRsC3TivRk7gyLGHt/uJYlsSXmARpoDiojmxThsnKGwoPDEN72GA/vh8QXL4a+
	mZmVNwMynzzuxHIkGL+3ctLcug//z7iYB2ZCirdxPy+RC0AL4aOqkkCnBQ7/DEU1
	bxAFdDPBajprtkuujiq0yHEokVV6Gjmcue2cAHFOWFGuO1oPFu3Cx5ZXrK7PKy79
	nWr7jDVeRuwGxS0grqcRcpiP2JXN9PMWcb0G8pEsVXq6YglFCGdX7A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437smapk4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 22:50:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6KJfAK020457;
	Fri, 6 Dec 2024 22:50:48 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 437s5curyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 22:50:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFB1FpEnme82txNeUvx4BdEO9nHdPW4ooPLLk5Yc+Xa2Gbg1rB/4DgFqLTyVPkZ+/1eKB7HFLfzp5j7h3YpdF/bibYXEVP85yfI7AaflX6VwcMbc+OqpTf02dHTatCNDYmqJpGQe2APpiLoSFduwELw1VqKPLKdRN4rFlnOVW5doyXYxYFZmMP6Sk0RrkmRDt5JVM3dLj8jD/iQDefMI5jqk0CqN4RAlBZnuDGgfx/Woo6fh/wxjL/gKAc3NyjDq8dHPBM+NcizJKDzS4tEvMTfgdcP+0uJ6f5g0kgv+T6oqyp6NYaitDIHs085tJEN61wrU9rTI8MNS9vDupAG2Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XA9GfmnZAsaRJ6fr6gUAoi5unMqR7D84zMapIfts9k=;
 b=no02aAkKMFCWLUVK9Wx3Path5WiUVXaDtn3ucXUSS0TnzHMvX7v2fY4zQJNdEY7AZ4+ljRk+OYrJ8wTBhfC7gU+R2r9agwnpcr0BhCsmHtjYycp23wxp8tMTgByXxUWSKS1HiWJySARWEjOEL7fI+3OKJlfavPYC1babX0feldMrR2YQA0tItKDvYPvMUELP56VWWf2Dr8h39nEtc5xVncvci6FjwQB+KdLFhYNMWpEGKb7Dlz45S9OrntVnKIbG12rPb8hM35BevAUHGMJsSePh+HGgTzzK8xaeESbMGedBmDprL3lylWq8Xj7hs0n4u+FNqYigX7KMRMtrPJl/qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XA9GfmnZAsaRJ6fr6gUAoi5unMqR7D84zMapIfts9k=;
 b=s09qUvLsYjJMRjWxCIsNHP64uUS3tCXeUgd4bG8u3aBEhCNRcr169BXqO2mAHfSRkay7+n6UJrAABF3Sh11iJ19ZzmpQc43HMQxSujXq3Z1LCnlxBLYNZaVo31Wt/pCjSnmmbaovfUp20vt1xA08dvKczhhDTflUixCmEBg6/Q4=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by LV3PR10MB7939.namprd10.prod.outlook.com (2603:10b6:408:219::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 22:50:46 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 22:50:45 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: enforce __must_check on VMA merge and split
Date: Fri,  6 Dec 2024 22:50:36 +0000
Message-ID: <20241206225036.273103-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0126.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::18) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|LV3PR10MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e68beb-c369-4255-d644-08dd16486bac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RZSxeapBsNKvN5NHkJL8UkkQJXgt87SeG1lIzr4aM4fV25V0cwshJC8U6JyM?=
 =?us-ascii?Q?ZduPXlm/YB0xlxUsz2kSasKrWjvcpD6OKAzbgykYd5ioaGVPsoUih1QZmmfz?=
 =?us-ascii?Q?//5jcdOtDpv60rsYjYSkdXV+UxVtuWmWw/OYP4EgGMqmTImq0ttcVskNkv0U?=
 =?us-ascii?Q?NEcDrYzkbQSNHaQrM9oOxxE1Vq1mQ7zH+PMeT6nKU+IlOSF3M9GgGERn0pOE?=
 =?us-ascii?Q?AC8hGgT8WbLJ4a/8EOoSp07Vqw3B07EeC/X5TMrq49U9yz2xWwjWNw7235oD?=
 =?us-ascii?Q?cCN4I17dvvXd84KdmQiM/eyA1TWizewkJJwk6oHGMVPfsiQMQvhLOUXOV3Mb?=
 =?us-ascii?Q?540cN+A+MGdNBniCsostEk4UjzsSfEAF/mF1N3Jb3V5F90hHuszSGoUMilrP?=
 =?us-ascii?Q?dJEGhTT6PcrlRDA0PrYxtsQ1lKp2/KeX2uKEtYg2oq+6x/f4l/n9JxQbbPaM?=
 =?us-ascii?Q?tqI3ZZGsS/naXIwm/81REDKW4cgfy5Q3U0HC335KvLSr5XXiBKbrBrnnRVrY?=
 =?us-ascii?Q?jXPOzPcazDgxrh2/bn6oMDrL3zF/C1U/B82d9UjSUJFmy7jnRNV9HsNa3Ivv?=
 =?us-ascii?Q?55N86FjQmq8fMuSTLFizpNuCrc1eoqk9sNyu3K3ZUUjlq/cf99BFrDZAmrOQ?=
 =?us-ascii?Q?+lmmMJUOnKTkIvGkOl/RcoyExaW+iVPSHhk7AQGtXpq8hfvBViLdS+ai6UMv?=
 =?us-ascii?Q?ZA1yD6LOHubA+IV6o0FWlsk9LTIThjCk1juMxa5nGRdZt55+p+QkLTz0s8XX?=
 =?us-ascii?Q?bJVAY6SOsi1tKAvtM+7XRk03Jw49K//a2090C+QFNMnLMOUZVv/TnGxwdX4G?=
 =?us-ascii?Q?V3/QG24H73x1MJawW6LZBuXKue6MigXo5mEVACmhQBMdEsY8vmdoomBBM7xM?=
 =?us-ascii?Q?cRZiQ5hvUtqWoHwd80nPqyMbB5x/Orkl4IsNHuMtBPP600C13GHgVWIMfMSu?=
 =?us-ascii?Q?3mjUeHMmq8Zb3lR474FndJfy6TfH/tR6//gGx+v3hkorGHP6UUj41rJHgXEQ?=
 =?us-ascii?Q?6Cjsb09P5sfVH/n0QTUiCJFaUrRbay71uLQ8rHB0FrKXjRg7Qaz0wFDwiJIK?=
 =?us-ascii?Q?fb8NfN8oP60A1KyIpVbIPjhki0KkSwk/sBeBPw96JeqygvJabUS9NbsU+nlO?=
 =?us-ascii?Q?ohMCiF37yRATH9OpHs3RTq73CNasCzEdUYiFRaFsBMMEN0qsJbfdzu11pXlE?=
 =?us-ascii?Q?lNxbmzr02v7qQo23RGw1jM9T5IDTnx/+Jp4hY7+xeARUhwEsHAzOgXcswUUu?=
 =?us-ascii?Q?RpxXTQcCYJUQR8vsP+wWcZ/OEJ28E0ysRoYnzM0imOoOnUornjBZZJ4H5q6z?=
 =?us-ascii?Q?j06Gefv9hYjyonS0ZUshSIe9dpxWk2gUnwTEkMuSR65aag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8V2KdKmUkNio/spBFes5q7LUO3VaSHKhN0iZVvP93iBsla9GKzoSIeD4R5Fn?=
 =?us-ascii?Q?IUEz5plQzsicrtCUvYIlagYzjj3TAKdggw/MV6jyX0h7hmA5waqBv8xZ3d6T?=
 =?us-ascii?Q?ccOi4JbXSpXCmCy/kY8/waGc5kPkVwDAAW5945swdKVhBD6Hm85VcZA50hAH?=
 =?us-ascii?Q?ZjzP3oXq5S80uTOwdbfcAt3kcjihQMEoZkzVlIF0fq7ZqctGeHiTMUbolZ2K?=
 =?us-ascii?Q?el29d9+ZKpHM9lVoVhLO6+p96igvd9PL0advgo08VukCFv3WofZ2ap1LTkSh?=
 =?us-ascii?Q?jWpdfVbo85z0uY0CEUYzbjHdwi4HSweQm4FAdxszb4fgZabUL0/SU/C2QeUK?=
 =?us-ascii?Q?os6GjdJj0av9ubTSNYD/j2Begy5Uyt9iUgdqth04c9Senc9TR2Uk4xUjR1dG?=
 =?us-ascii?Q?2c+3/vtQV1P8VrWz/4GmWuhVUsOuI4wVhRF/j4vCTmsZ8vTzjxdR8kKYnXoO?=
 =?us-ascii?Q?DQd/wEavI7KuIRmhQehMbdWieRRllP7LO7O8LR33EZunHmmYtWyfV7anhviW?=
 =?us-ascii?Q?ZVa439cPwR+rbbc33Vts1yzlNfB4Sn7vFVQgOl1WyIVCOMe+7Oyo92fS86zy?=
 =?us-ascii?Q?pLdwtNb9skyfbMKXCy311UubMdHis0t9ca5e6rjgtNEaNskM9EiPpr2W4TJj?=
 =?us-ascii?Q?c8Z47h4kjrYWg6knQSF/N9TsoQUPeuqmsW4/nozvNAYPpZ78NzlJ0rB4q+gZ?=
 =?us-ascii?Q?XFPnDo3f/dRXnImmBhd78HG8UPUh3KiUDJrLQLlhGuehgj6u5Vf9Pj0aF9o6?=
 =?us-ascii?Q?l+3wiiVhS9d9xGZhSJOam/9A1kCaqscGw9EQyb+6tA2hU6ePj1Ef+piUVrql?=
 =?us-ascii?Q?/suzRfLPoHx7ARniFw59M8nAzMwD7xn6Z+dX5zrof7bS6BhtxbuqxsHalfEj?=
 =?us-ascii?Q?pZIT4H5S5KdmPZYvaYhWMowDGKRSn4+Y4wHeikE2JBafsTFWrJJAzVnPZigB?=
 =?us-ascii?Q?HJtkIuM9lPOnRyCdEUNF8OsgNR2HlyAm/U8aKF/yKt6G9alEra1PMqPa4v6I?=
 =?us-ascii?Q?ehPIJffTN0Cg6JS7Fqw+ZehOPQmAwmZ8uCYf4Fv/IEyl79NPkT0k+viB1oR6?=
 =?us-ascii?Q?NiwwPdzbiVr284BxmbvDBAyymFpE23eI3GhBi49IbWEhwWRx5x2dzCl6qa5E?=
 =?us-ascii?Q?iropCSojN8r6X0yIhxCb3naymkCvYfI3olSreeUNQ5Y6lnJsRRPiiCUtkv8W?=
 =?us-ascii?Q?AQOpkeHPM7DdoFnJik+1vIruFX+l+KrUcXjz/vSMGvB02naiObTKxvqcBWT3?=
 =?us-ascii?Q?IV35TMjUm+Psx04ZXbu2TLQAAoV4BLN25oPCqmo+t1Cd3LBCTeqfDlnpeeNM?=
 =?us-ascii?Q?nUwdcuDz9NqK7CdE/ynl7l81iOKDoIDRy6OyIwaVCDf8g87/viuh4+Gg/Sfe?=
 =?us-ascii?Q?xoJhrnz7W5N+heW6szFN/jKnizyWbF3NvkGVtT7Ien5pdmp1jKX1BeNh82o9?=
 =?us-ascii?Q?evWYDnvCASDgeYvhJ7/vNA4KCrZcXFQ/47VNgM7w44xBaHaALY2VxW/gToIQ?=
 =?us-ascii?Q?1WY1FjXCJ/RoYIwy7BXthd9/9+nhUgIhP3VDKP+hkV7RXHBVyx8y6VUEMBoQ?=
 =?us-ascii?Q?EB5RUUZbYQvqjBOBKMHFgpFxUXkQ9EfstgqyUdBBnwBWrb6IBAuhNn1CrZPA?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DsGPXtDMSeATyqXHBFV6j+AGiBYm2VIuIUxXtKgBGNDYnRAysgNOHOaREMAOFuyiKAl8riYpZNZBlyYHR+68++VO/zsOi+jC7VvDmzuvliCywp+IG7VHMXt4UhlnhGkVxLQOWmZKr40rE3janEcsbdVs6HC8pFupvNW+GUk1yefKHfSaCxxQkxRYByKEj6zZDbJ85/Zf0PkW/+j2+ZCDMgeF5uZ9VOqgqHMhtNUd9LILYyiqoDoNn9hL8IR8UnhGXTushfSgdRf1eGg8m4gvz4vyr3u1Jcqifu3/5t1h8S6nk2GJyQZ86eR8I7e0Y394doE47QUqSYXELtikgfJw3DnubvRn8BUmGEa95dpoAb3nq5Zjnq4CSmpub1r2e8cag4n1GGhMQ1gVo+dOe8xWL/3mTqjMPzZBhyJTFOQKPgbRSB9gfDhHCzWQFhBTKZtEhA3/VurAxeY2h3BOodcypAmE9nADSari0nupd/ipolemEekqCXN2CeI5U51Uikfm41WG3bKRUFg0GwjCJYLBkJeALxJ7qCaiBHBw9KPiuOr3vygIZVixzxe4kaytWJtygeyDs2Y91XJhvD98LqiJpFC7IgJuMcrflJFGeINo7zI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e68beb-c369-4255-d644-08dd16486bac
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 22:50:45.8695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f0P/CyRpsOjVTn+dVubkf1WN+cyF+O/RH3XFyMfAhCo+InPT5oYRyU6QFzdPWD5qvwfK6XHxry7aiGhu8cQl0ik/zxN2tsuAZOOaSWOJIXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7939
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-06_16,2024-12-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412060174
X-Proofpoint-ORIG-GUID: lWJYzMGwkWNklVAWEgujdVnPUkaNeXOn
X-Proofpoint-GUID: lWJYzMGwkWNklVAWEgujdVnPUkaNeXOn

It is of critical importance to check the return results on VMA merge (and
split), failure to do so can result in use-after-free's. This bug has
recurred, so have the compiler enforce this check to prevent any future
repetition.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c |  8 +++++---
 mm/vma.h | 26 +++++++++++++++-----------
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index a06747845cac..543c102b4062 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -447,8 +447,9 @@ void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
  * has already been checked or doesn't make sense to fail.
  * VMA Iterator will point to the original VMA.
  */
-static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		       unsigned long addr, int new_below)
+static __must_check int
+__split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
+	    unsigned long addr, int new_below)
 {
 	struct vma_prepare vp;
 	struct vm_area_struct *new;
@@ -710,7 +711,8 @@ static bool can_merge_remove_vma(struct vm_area_struct *vma)
  * - The caller must hold a WRITE lock on the mm_struct->mmap_lock.
  * - vmi must be positioned within [@vmg->vma->vm_start, @vmg->vma->vm_end).
  */
-static struct vm_area_struct *vma_merge_existing_range(struct vma_merge_struct *vmg)
+static __must_check struct vm_area_struct *vma_merge_existing_range(
+		struct vma_merge_struct *vmg)
 {
 	struct vm_area_struct *vma = vmg->vma;
 	struct vm_area_struct *prev = vmg->prev;
diff --git a/mm/vma.h b/mm/vma.h
index 295d44ea54db..61ed044b6145 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -139,9 +139,10 @@ void validate_mm(struct mm_struct *mm);
 #define validate_mm(mm) do { } while (0)
 #endif
 
-int vma_expand(struct vma_merge_struct *vmg);
-int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
-	       unsigned long start, unsigned long end, pgoff_t pgoff);
+__must_check int vma_expand(struct vma_merge_struct *vmg);
+__must_check int vma_shrink(struct vma_iterator *vmi,
+		struct vm_area_struct *vma,
+		unsigned long start, unsigned long end, pgoff_t pgoff);
 
 static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
 			struct vm_area_struct *vma, gfp_t gfp)
@@ -174,13 +175,14 @@ void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
 		struct vm_area_struct *prev, struct vm_area_struct *next);
 
 /* We are about to modify the VMA's flags. */
-struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
+__must_check struct vm_area_struct
+*vma_modify_flags(struct vma_iterator *vmi,
 		struct vm_area_struct *prev, struct vm_area_struct *vma,
 		unsigned long start, unsigned long end,
 		unsigned long new_flags);
 
 /* We are about to modify the VMA's flags and/or anon_name. */
-struct vm_area_struct
+__must_check struct vm_area_struct
 *vma_modify_flags_name(struct vma_iterator *vmi,
 		       struct vm_area_struct *prev,
 		       struct vm_area_struct *vma,
@@ -190,7 +192,7 @@ struct vm_area_struct
 		       struct anon_vma_name *new_name);
 
 /* We are about to modify the VMA's memory policy. */
-struct vm_area_struct
+__must_check struct vm_area_struct
 *vma_modify_policy(struct vma_iterator *vmi,
 		   struct vm_area_struct *prev,
 		   struct vm_area_struct *vma,
@@ -198,7 +200,7 @@ struct vm_area_struct
 		   struct mempolicy *new_pol);
 
 /* We are about to modify the VMA's flags and/or uffd context. */
-struct vm_area_struct
+__must_check struct vm_area_struct
 *vma_modify_flags_uffd(struct vma_iterator *vmi,
 		       struct vm_area_struct *prev,
 		       struct vm_area_struct *vma,
@@ -206,11 +208,13 @@ struct vm_area_struct
 		       unsigned long new_flags,
 		       struct vm_userfaultfd_ctx new_ctx);
 
-struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg);
+__must_check struct vm_area_struct
+*vma_merge_new_range(struct vma_merge_struct *vmg);
 
-struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
-					struct vm_area_struct *vma,
-					unsigned long delta);
+__must_check struct vm_area_struct
+*vma_merge_extend(struct vma_iterator *vmi,
+		  struct vm_area_struct *vma,
+		  unsigned long delta);
 
 void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb);
 
-- 
2.47.1


