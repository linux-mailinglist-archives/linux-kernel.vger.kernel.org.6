Return-Path: <linux-kernel+bounces-378605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 792D19AD30A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF686B23900
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E08F1CFEBC;
	Wed, 23 Oct 2024 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TVPFddID";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OdhmjXkD"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B834B78C9C
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729705192; cv=fail; b=r/oSq+2SGvdDIlhrNUJZZw1QRlzJdREjgk9rm+9nLGT22t2EIMdChyEnhbkS3OsexropJCbpt1qpc8dFCZ4uY981Ns0r+pOKksBUMQriV2y1AZtfNiW1XlAuEhjxtv/CKi0tw07SHlDPqXRgGpv8YKDlSPVkZqXBV1ofem5t2a8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729705192; c=relaxed/simple;
	bh=Z5+fPJ2jA72CKsjuCm2Rf1h7yjjMl1NV49maMpcVQPY=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CHnOkp/x7GRGWIW2QOnxmF+6uppM83WAjpSwHlvLTX/MoGZC60VdAfcA+93TSQB1NE3SC3kbJ1poeniZYurkNudqx9KvPewSSngqHOo4v3jldeOKE1+O4IyKNZq9601iHOjSBrexMBMzYs1WZpLHP5PGCbjIIuQHF9mATP8uJ8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TVPFddID; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OdhmjXkD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFffRt001663;
	Wed, 23 Oct 2024 17:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=GWlpErfLpuD4m9ET7H
	E4wg2p69aohBm6s7NuVgdCoeE=; b=TVPFddIDGejKF8zm3svQemR2J6EWA9/DcS
	xKDsA8YQVygopjrcF7+5+t2VaM7JgXCq1uPMGEqIzH8kAW/b8KdsqbmYkRvpnlOu
	SKYwgJoyWOxk1FFDLOCGOv9if/RuWXRhygzfPLrpAMQvfh6domY1NqOcrf1UqVz5
	bvbPdJy1lxW1kY9lWVOaBk/IaBO4UEv8dkKrhsrywPHHLwgihly/cNi/pKU4S8Ys
	CLBGpdsc5HZGgmUhkPWTd5SiqkZbix5AD31Eb1HUdyTrBR10BvWp601KGKmGzhRU
	8CsFhgJV9t8lRuT8s3wBmC4D5a576OA9hQ9hU9aCyfXjw+bjI1Mg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c57qgsaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 17:39:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NHWmvf025445;
	Wed, 23 Oct 2024 17:39:36 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh9u4mb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 17:39:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vYWrRpr57MEYm19wRV4xpRRBAZTtc4ycAqmefqBnAGlF8GW8F+JQIlAN692oC7aA6iTNgWKM335q9aXxdUqpO6eemPTwbV/Zy6unsfOi776L8kA2aYHr585ulKe96EBgvRkBU+7PxV0UOjleFslc+V3o9a1E0Dp0EqGgzpA9udDDs32GCjEpwLcQivg/23VhombRnOVL4pEZv+Y6o2scaJNSwgvmfCry/yG+A9Qb76FtYLQnu0knQx4nu8mfJyD97dDeSRG5urF3GDwH8eQIQtRSvfEpXWSSJAT+WhG2IVWYC+AUku/ghKoRHfM5ZMwz9O+OOHCKq3GAyWcRETiFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWlpErfLpuD4m9ET7HE4wg2p69aohBm6s7NuVgdCoeE=;
 b=UuqnV0pC0tezEuY1oKCj5M3glS+whp2rN8Xh5jappM4YZ1NIcyRfFB7cqmO7DWmT0mfI6cMkB9Fg3lvkZbSXWX7A/vuNxbcj0nq3e8ZryAdAeyn4vodlpLqd5/K+gORMQKhYeMV4zJKVvZeZLsipMN501z+EaltOtod9GrsUWBtjM15MwIXJts40kyD3Bh8b38cAuG5iR45OdCblbfhrXLAgv335V3MY7xOpqjqE6rm/d2oW6krO65NXDLkrdPCzX9SjOs0a2gHVTPOdo7e5MJEbeg6I4KDKPkHPDkoPHNclOhwI5/3/hzDYnJnAFPqIz6r0GV44GTDeDKyYAQbr/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWlpErfLpuD4m9ET7HE4wg2p69aohBm6s7NuVgdCoeE=;
 b=OdhmjXkDVOsi6ogoZDhJqJr7D3Bo+xdBkr1rz0xRuh30N0HuDLbseK287TRS/PhB7Ai6cM/N47Zu/7DQxaqg3ee/b8MYCjq7p3xpevLmlmPT3OYDJc3vLruRV18wlzx3oyq9PmoDz9+MBKm9elY90bgRGKV5P6CPGzldqe4euVg=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM4PR10MB6695.namprd10.prod.outlook.com (2603:10b6:8:111::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 17:39:27 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 17:39:27 +0000
Date: Wed, 23 Oct 2024 18:39:24 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH hotfix 6.12 7/8] mm: refactor __mmap_region()
Message-ID: <23f8b278-293e-43be-b61a-63239be5dc59@lucifer.local>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
 <125b6ebddc7ae8790b8b10b47906c2d39e68f3d9.1729628198.git.lorenzo.stoakes@oracle.com>
 <81712eec-440d-421c-93b4-8b6d9c491693@suse.cz>
 <oubvc6lpzfkrryt3ai6xp63aqexymi3nm42aq3tljj6d7sdart@x5qj44cgtxzf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oubvc6lpzfkrryt3ai6xp63aqexymi3nm42aq3tljj6d7sdart@x5qj44cgtxzf>
X-ClientProxiedBy: LO2P265CA0404.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::32) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM4PR10MB6695:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d8be8c5-8338-407f-f8c1-08dcf389a462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5jzmyq/BLtjB+hV9IGkRVO7V0I4L8CcroUr8a/SxtKy/c02LtCWSagJLWw6R?=
 =?us-ascii?Q?CUF3JqW9rP/z1RQuldqxGvgpVRC9DWku0eYE7YTa5U01s2tfviXtdtpTbJ7g?=
 =?us-ascii?Q?jsvneKpTXKqjkjFZrbM20Tp4BJYb8uRN/C7M3sJ5Yb1xa17UR239xGMc92F5?=
 =?us-ascii?Q?0PpSRd3xPuwph7gTgmEvVy8MmQdilJiEzNdOkCbh2wQkYtAf+y7UaNoLly9H?=
 =?us-ascii?Q?cN/piY1azECrc4bXF0DN69TKh273oLx5AoatEmM0Ry+RfJavVoEYf+2Edmek?=
 =?us-ascii?Q?5a0YYiMWoINTizKaot5Tsvl653Pdc0Jd8W+rjYx+Lvd3dRAVqAQMhGyUMstS?=
 =?us-ascii?Q?rCtsb51DMeAUHJjssRG7t4eC17s3jaICBr3eQhJRsyzkDeY82kjLRfqhPfDj?=
 =?us-ascii?Q?ElCs777jD1tZqZFZo0up1n69YMXBMcIvucg6t5az7oIjkzvHfQz5gBvSeDsD?=
 =?us-ascii?Q?T81vHtluhV/DGceJka3SPgL4Db8VjC5Wvg7b4xOgV347VlrRCV4WhhZ3thyL?=
 =?us-ascii?Q?8Njp2hz4Wk4GMGWgbC2xCmf1TVF+xK8RpRGrUyDoF9aJrq9+dSrutMZtx+V0?=
 =?us-ascii?Q?IIGLjX+qLKI7SEKa7VWhKB+mjh8x/eQpeHkNpoZQLfkfX1AoBYsPvlfuKTMh?=
 =?us-ascii?Q?4CY/qiJ4etpBt940WJwNGtNx9DAmk14xGyNEScoirrIYLzsu8YeSDIjzwHlD?=
 =?us-ascii?Q?m9a4pcCSAeS9phks7VZVOj0VFXRkLgAKBINXAYbTMxPFBojqHvrp7ZvnWGkW?=
 =?us-ascii?Q?1cVfcrobnBzTSjNehWRZzrYKEc1Fb4Wfs/DhBJZWUdQBrr1EKOlddxn97v+S?=
 =?us-ascii?Q?badeKb38qR1/Vma/JbXBG71QvaS7pT9G+krXM03qZBOPU8pYIVR9twAqbNl4?=
 =?us-ascii?Q?pBrVyjZxpBBwEtUEbudd0cqsSDuZnfGDDGjGgTbhxgQTopz2g9rMJ63NqnD2?=
 =?us-ascii?Q?XeZpvwjSzVyBktIvRuW26s0uRIrsUYUwrjgethKQS/QlWTjo1iclohQKwNg8?=
 =?us-ascii?Q?6xC15sC4813BWBbafxvHIKxSCPCTXK1d98EDsMKWybtVLHiA+VklPCgxV8Ry?=
 =?us-ascii?Q?mnTLty+CAyfHIWGYLoaLs0FkkJEob13/nleuUDQj0mavhcXNbMlg3HKMBRSY?=
 =?us-ascii?Q?uPj8yubldH+w9+WO6lfR6h0g6kLTaKugYUTFo9UgDP2TwazaffqRQhWAm+Im?=
 =?us-ascii?Q?z2/OWeljg5ynn74JnfPa7gqnQRx0nMSERBy+SMCOT56TE60DumJc7ntVb39h?=
 =?us-ascii?Q?gtYZidD7FBXg3sQqWYGD25158OgpkDyWEMhkjaBrTMUNBmgvQB/V3f//L75M?=
 =?us-ascii?Q?4q8EMD04nNdiatCOn0FydeCa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZXnCpla6ynA7HK4SVf8ZP+YMWY67gYO1kzeBK8J9wh5W+6N/tXyGaUT+BwNc?=
 =?us-ascii?Q?63jy4PZmDQJigMkXzhBiNkQK1EKw7Ja0eUl2ulPKRwLk/Vm/k+3zTwhD0c7s?=
 =?us-ascii?Q?MzI/4O8lFblEiYaeEW6AjVs3vDyS0wjUnPwE6Zm/PeEWw5Y9oI+qmpPcj73W?=
 =?us-ascii?Q?zPaZovQ7Md4E6YhbUsGyt58GrFuXPXRsEpDIq/W/dn55t0YC8Pf3vUX3lyGa?=
 =?us-ascii?Q?i6LWeChhGDeX+GgNvag6zawgqd5VlymfB22ZZJybOj5gOX6JZbqhZBOv/4Ul?=
 =?us-ascii?Q?JV2NZQVOUbmQuDJcl8EUtuMAjTY1dNcIsbiW89O5nnnnUIBtx6QlVixPs187?=
 =?us-ascii?Q?na4aJQJR4i5auZ66S/OSSSd5dcd2vkENSjld6wiYyNP6yo6LUWvktg/ynm2y?=
 =?us-ascii?Q?RZUz09qE8BfVil/gV7lsJIiuixg3dQZZ0y5ADx835D/o3ESVLj0sTc2YHx9J?=
 =?us-ascii?Q?mzI6n6wsU9uc/4+slm4DNEBvSnCLyl+Fy9SO+TaKhfMLlY+ICF0+mqVBbZdo?=
 =?us-ascii?Q?1oYw/2dr4SHV4M2Wk5jPK15SFjt3Gq2qrsE5P+MIjTh4EF6lrETQmfMhMbmf?=
 =?us-ascii?Q?qTQBM+vQP17LC2gdu+1cqHBGo2aCn5dmOz2U8iOysAIVQVm2jzXhbGtsbWLQ?=
 =?us-ascii?Q?U2KbWFAiOyAvQxMP7t+KyW88xSheQLB99DhqwG4hzIOAWHfmcy1n3hBWW7oM?=
 =?us-ascii?Q?05EScjswl6zeJ28YErarW0z9CHJ3hHRVFx9WqWlE1NycGMMmk06hbH2PVqpc?=
 =?us-ascii?Q?+7QNKuVQ+TEHmpMy6/WWRrFIWGPZPi0ScM1cJsUNFj2j8dPPr/zJUg9120GZ?=
 =?us-ascii?Q?LV9J/GP5+p3YSpwGzNVV4TQ2+WXsRJdLV5d/xdlfhuMxrf6cNdvCDdzm4KsP?=
 =?us-ascii?Q?FIWdEIHspnYMyXPvoeu/Tz5GDxXKdvB3GOKAEKudRtSY93hC9hQO9x455MzE?=
 =?us-ascii?Q?BCCfjBby/4nGqvKYyXhMrXD7hphCqQCxE490DxEJ1DZkzBTQFShcNcJwoswM?=
 =?us-ascii?Q?XHbAH7Cy2XZch3qYa3tsR9M1ZzQjimywkz387ib44Q5avb7Z7KlwSF2ykAaw?=
 =?us-ascii?Q?ASQZ95PobBxFaL8RjqlFRDrf+Z5WWBoxvccfDg1LkjMgRVjHRFXdAnrRtWx/?=
 =?us-ascii?Q?6E+BeX2OmDqCV3Tof/JK2XbY18wZhdV5rRCAe9CVnKb8AVMgOK4dzlLk5MsI?=
 =?us-ascii?Q?nhD63s4uH2DB3P7gCFjJ905Eh85QzWIUsCEUIKMF9QqRFYwn56NgpLMjkYDj?=
 =?us-ascii?Q?LGIoqfWDR6/g+txz7Dy7f/kEV4T2UMDjkNcYHFYOynB66IeKIAqntqdu1zyt?=
 =?us-ascii?Q?BknoI0SHFWQVP3WrKTTvy9z8PdoPUyfLEVoq64sIksfaIdtBMtY15iB39zpG?=
 =?us-ascii?Q?zvpuDaWH2GCUDeC3n+k/u4E7symzPqYM3YoGtXko+cBrvq7V2IpA61P99Tfl?=
 =?us-ascii?Q?gVoIiDRZjI+ge/WDt80iAbNbZpmuQU+FcDJoAwc2PQpoGNaQsNVfNjISiR2U?=
 =?us-ascii?Q?eItsT9RGO3Q7mruOLyvlvE41/fFoXgMfU8MMMrjPunR1FXxZxMl7HdgHsP4F?=
 =?us-ascii?Q?GCn3+aG+8002Z6080BPCNdk6YhlMgdKdt/jV5RqBYlBoknOgrftvTysizvOZ?=
 =?us-ascii?Q?1ZdnF3ruuxfQ44Fzfkxcmi3it6f2l36aX6sIwdJJkjNFVftPAYdE6sJ0jmTl?=
 =?us-ascii?Q?p9btaw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OhNpWt5fUT4XqJphWTtdIcZZT2AoknKaBhNXaQpIcXoeOQdOsUT8boewmCTYn8hyCiMG9ObaNvBLW1UpjKzHF1j6rqw4BELfL1kQz+eQ6VkQO9WEuC7O7W9MEu7ZR/WW+6imGCIPwxS8e4a5FIdBgCtYgnDcYExDr+fcrQBtBWW1ijvqrP0gZpshNxLh7mrJSZ5cs/iH1UYyIYUcjXx73OfEsuLtOeImTPdkQ3LSUKUIcaybFCvp8xcmpi7pifPjd+iKOgM3lAFfk2VydQlOLpdTHEgakbPlp3odGRvfGvlY3iTDqQGOhfUje3vpUrN0Yvg/puVNIM/X3dAv3jcrqn82Ru/QswBRta9XvCU79siJ2HIGot/AtdD7pSdKs7PcVFyUQX/IBR7Kv0eaFMzqyiIyYVr4sGWDkvOKi86d+8gSOQSnhurotaRtlPxuN+ZKbfFp8FrSwJue30rsEoZX6/Xfi+lAYTf+/bh/SR+AWaDDH2Up/NABJJWvP+G3zf6/8DoPyt5eh2nv7IlK2neDDPCS0k0bJ8dkeG3x7wZGx95qBxVwvSfKXrmAM1dEKU4mNNhUKIGLQ/Gke2ZaGIWytMZU3RGT6HsMrBesrNZC3lw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8be8c5-8338-407f-f8c1-08dcf389a462
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:39:27.7216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gNGCTFXOB0vVZglkK1QDmdzxq0VKNvYyevIiES55LFAO7Ish2FgVHnfeTdyiTKh2SRAzjQ5FLuDacQ71IAHuIKX2wSlSidUpqkwhv75OIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6695
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_15,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410230112
X-Proofpoint-ORIG-GUID: 8t_M0mvOWapZ0fk1Wg5IMuXzLQBQzMaG
X-Proofpoint-GUID: 8t_M0mvOWapZ0fk1Wg5IMuXzLQBQzMaG

On Wed, Oct 23, 2024 at 11:21:54AM -0400, Liam R. Howlett wrote:
> * Vlastimil Babka <vbabka@suse.cz> [241023 10:39]:
> > On 10/22/24 22:40, Lorenzo Stoakes wrote:
> > > We have seen bugs and resource leaks arise from the complexity of the
> > > __mmap_region() function. This, and the generally deeply fragile error
> > > handling logic and complexity which makes understanding the function
> > > difficult make it highly desirable to refactor it into something readable.
> > >
> > > Achieve this by separating the function into smaller logical parts which
> > > are easier to understand and follow, and which importantly very
> > > significantly simplify the error handling.
> > >
> > > Note that we now call vms_abort_munmap_vmas() in more error paths than we
> > > used to, however in cases where no abort need occur, vms->nr_pages will be
> > > equal to zero and we simply exit this function without doing more than we
> > > would have done previously.
> > >
> > > Importantly, the invocation of the driver mmap hook via mmap_file() now has
> > > very simple and obvious handling (this was previously the most problematic
> > > part of the mmap() operation).
> > >
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > ---
> > >  mm/vma.c | 380 +++++++++++++++++++++++++++++++++++--------------------
> > >  1 file changed, 240 insertions(+), 140 deletions(-)
> > >
> > > diff --git a/mm/vma.c b/mm/vma.c
> > > index 7617f9d50d62..a271e2b406ab 100644
> > > --- a/mm/vma.c
> > > +++ b/mm/vma.c
> > > @@ -7,6 +7,31 @@
> > >  #include "vma_internal.h"
> > >  #include "vma.h"
> > >
> > > +struct mmap_state {
> > > +	struct mm_struct *mm;
> > > +	struct vma_iterator *vmi;
> > > +	struct vma_merge_struct *vmg;
> > > +	struct list_head *uf;
> > > +
> > > +	struct vma_munmap_struct vms;
> > > +	struct ma_state mas_detach;
> > > +	struct maple_tree mt_detach;
> > > +
> > > +	unsigned long flags;
> > > +	unsigned long pglen;
> > > +	unsigned long charged;
> > > +};
> > > +
> > > +#define MMAP_STATE(name, mm_, vmi_, vmg_, uf_, flags_, len_)	\
> > > +	struct mmap_state name = {				\
> > > +		.mm = mm_,					\
> > > +		.vmi = vmi_,					\
> > > +		.vmg = vmg_,					\
> > > +		.uf = uf_,					\
> > > +		.flags = flags_,				\
> > > +		.pglen = PHYS_PFN(len_),			\
> > > +	}
> > > +
> > >  static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_next)
> > >  {
> > >  	struct vm_area_struct *vma = merge_next ? vmg->next : vmg->prev;
> > > @@ -2169,189 +2194,247 @@ static void vms_abort_munmap_vmas(struct vma_munmap_struct *vms,
> > >  	vms_complete_munmap_vmas(vms, mas_detach);
> > >  }
> > >
> > > -unsigned long __mmap_region(struct file *file, unsigned long addr,
> > > -		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
> > > -		struct list_head *uf)
> > > +/*
> > > + * __mmap_prepare() - Prepare to gather any overlapping VMAs that need to be
> > > + *                    unmapped once the map operation is completed, check limits,
> > > + *                    account mapping and clean up any pre-existing VMAs.
> > > + *
> > > + * @map: Mapping state.
> > > + *
> > > + * Returns: 0 on success, error code otherwise.
> > > + */
> > > +static int __mmap_prepare(struct mmap_state *map)
> > >  {
> > > -	struct mm_struct *mm = current->mm;
> > > -	struct vm_area_struct *vma = NULL;
> > > -	pgoff_t pglen = PHYS_PFN(len);
> > > -	unsigned long charged = 0;
> > > -	struct vma_munmap_struct vms;
> > > -	struct ma_state mas_detach;
> > > -	struct maple_tree mt_detach;
> > > -	unsigned long end = addr + len;
> > >  	int error;
> > > -	VMA_ITERATOR(vmi, mm, addr);
> > > -	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);
> > > -
> > > -	vmg.file = file;
> > > -	/* Find the first overlapping VMA */
> > > -	vma = vma_find(&vmi, end);
> > > -	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
> > > -	if (vma) {
> > > -		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
> > > -		mt_on_stack(mt_detach);
> > > -		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
> > > +	struct vma_iterator *vmi = map->vmi;
> > > +	struct vma_merge_struct *vmg = map->vmg;
> > > +	struct vma_munmap_struct *vms = &map->vms;
> > > +
> > > +	/* Find the first overlapping VMA and initialise unmap state. */
> > > +	vms->vma = vma_find(vmi, vmg->end);
> > > +	init_vma_munmap(vms, vmi, vms->vma, vmg->start, vmg->end, map->uf,
> > > +			/* unlock = */ false);
> > > +
> > > +	/* OK, we have overlapping VMAs - prepare to unmap them. */
> > > +	if (vms->vma) {
> > > +		mt_init_flags(&map->mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
> > > +		mt_on_stack(map->mt_detach);
> > > +		mas_init(&map->mas_detach, &map->mt_detach, /* addr = */ 0);
> > >  		/* Prepare to unmap any existing mapping in the area */
> > > -		error = vms_gather_munmap_vmas(&vms, &mas_detach);
> > > +		error = vms_gather_munmap_vmas(vms, &map->mas_detach);
> > >  		if (error)
> > > -			goto gather_failed;
> > > +			return error;
> >
> > So this assumes vms_abort_munmap_vmas() will rely on the "vms->nr_pages will
> > be equal to zero" mentioned in commit log. But AFAICS
> > vms_gather_munmap_vmas() can fail in Nth iteration of its
> > for_each_vma_range() after some iterations already increased nr_pages and it
> > will do a reattach_vmas() and return the error and we just return the error
> > here.
> > I think either here or maybe in vms_gather_munmap_vmas() itself a reset of
> > vms->nr_pages to zero on error should happen for the vms_abort_munmap_vmas()
> > to be a no-op?
>
> Probably in reattach_vmas()?

Hm, but that only accepts a mas and seems redundant elsewhere... am going for
simply resetting nr_pages for now and maybe we can revisit if needs be?

>
> >
> > >
> > > -		vmg.next = vms.next;
> > > -		vmg.prev = vms.prev;
> > > -		vma = NULL;
> > > +		vmg->next = vms->next;
> > > +		vmg->prev = vms->prev;
> > >  	} else {
> > > -		vmg.next = vma_iter_next_rewind(&vmi, &vmg.prev);
> > > +		vmg->next = vma_iter_next_rewind(vmi, &vmg->prev);
> > >  	}
> > >
> > >  	/* Check against address space limit. */
> > > -	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages)) {
> > > -		error = -ENOMEM;
> > > -		goto abort_munmap;
> > > -	}
> > > +	if (!may_expand_vm(map->mm, map->flags, map->pglen - vms->nr_pages))
> > > +		return -ENOMEM;
> > >
> > > -	/*
> > > -	 * Private writable mapping: check memory availability
> > > -	 */
> > > -	if (accountable_mapping(file, vm_flags)) {
> > > -		charged = pglen;
> > > -		charged -= vms.nr_accounted;
> > > -		if (charged) {
> > > -			error = security_vm_enough_memory_mm(mm, charged);
> > > +	/* Private writable mapping: check memory availability. */
> > > +	if (accountable_mapping(vmg->file, map->flags)) {
> > > +		map->charged = map->pglen;
> > > +		map->charged -= vms->nr_accounted;
> > > +		if (map->charged) {
> > > +			error = security_vm_enough_memory_mm(map->mm, map->charged);
> > >  			if (error)
> > > -				goto abort_munmap;
> > > +				return error;
> > >  		}
> > >
> > > -		vms.nr_accounted = 0;
> > > -		vm_flags |= VM_ACCOUNT;
> > > -		vmg.flags = vm_flags;
> > > +		vms->nr_accounted = 0;
> > > +		map->flags |= VM_ACCOUNT;
> > >  	}
> > >
> > >  	/*
> > > -	 * clear PTEs while the vma is still in the tree so that rmap
> > > +	 * Clear PTEs while the vma is still in the tree so that rmap
> > >  	 * cannot race with the freeing later in the truncate scenario.
> > >  	 * This is also needed for mmap_file(), which is why vm_ops
> > >  	 * close function is called.
> > >  	 */
> > > -	vms_clean_up_area(&vms, &mas_detach);
> > > -	vma = vma_merge_new_range(&vmg);
> > > -	if (vma)
> > > -		goto expanded;
> > > +	vms_clean_up_area(vms, &map->mas_detach);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int __mmap_new_file_vma(struct mmap_state *map, struct vm_area_struct *vma,
> > > +			       struct vm_area_struct **mergep)
> > > +{
> > > +	struct vma_iterator *vmi = map->vmi;
> > > +	struct vma_merge_struct *vmg = map->vmg;
> > > +	int error;
> > > +
> > > +	vma->vm_file = get_file(vmg->file);
> > > +	error = mmap_file(vma->vm_file, vma);
> > > +	if (error) {
> > > +		fput(vma->vm_file);
> > > +		vma->vm_file = NULL;
> > > +
> > > +		vma_iter_set(vmi, vma->vm_end);
> > > +		/* Undo any partial mapping done by a device driver. */
> > > +		unmap_region(&vmi->mas, vma, vmg->prev, vmg->next);
> > > +
> > > +		return error;
> > > +	}
> > > +
> > > +	/* Drivers cannot alter the address of the VMA. */
> > > +	WARN_ON_ONCE(vmg->start != vma->vm_start);
> > > +	/*
> > > +	 * Drivers should not permit writability when previously it was
> > > +	 * disallowed.
> > > +	 */
> > > +	VM_WARN_ON_ONCE(map->flags != vma->vm_flags &&
> > > +			!(map->flags & VM_MAYWRITE) &&
> > > +			(vma->vm_flags & VM_MAYWRITE));
> > > +
> > > +	vma_iter_config(vmi, vmg->start, vmg->end);
> > > +	/*
> > > +	 * If flags changed after mmap_file(), we should try merge
> > > +	 * vma again as we may succeed this time.
> > > +	 */
> > > +	if (unlikely(map->flags != vma->vm_flags && vmg->prev)) {
> > > +		struct vm_area_struct *merge;
> > > +
> > > +		vmg->flags = vma->vm_flags;
> > > +		/* If this fails, state is reset ready for a reattempt. */
> > > +		merge = vma_merge_new_range(vmg);
> > > +
> > > +		if (merge) {
> > > +			/*
> > > +			 * ->mmap() can change vma->vm_file and fput
> > > +			 * the original file. So fput the vma->vm_file
> > > +			 * here or we would add an extra fput for file
> > > +			 * and cause general protection fault
> > > +			 * ultimately.
> > > +			 */
> > > +			fput(vma->vm_file);
> > > +			vm_area_free(vma);
> >
> > This frees the vma.
> >
> > > +			vma_iter_free(vmi);
> > > +			*mergep = merge;
> > > +		} else {
> > > +			vma_iter_config(vmi, vmg->start, vmg->end);
> > > +		}
> > > +	}
> > > +
> > > +	map->flags = vma->vm_flags;
> >
> > So this is use-after-free.
> >
> > Maybe pass only a single struct vm_area_struct **vmap parameter to this
> > function, and in case of merge, change both vma and *vmap to it?.
> >
> > Although I can see it's all moot after 8/8. Still let's not introduce a
> > temporary UAF step.
> >
> > > +	return 0;
> > > +}
> > > +
> > > +/*
> > > + * __mmap_new_vma() - Allocate a new VMA for the region, as merging was not
> > > + *                    possible.
> > > + *
> > > + *                    An exception to this is if the mapping is file-backed, and
> > > + *                    the underlying driver changes the VMA flags, permitting a
> > > + *                    subsequent merge of the VMA, in which case the returned
> > > + *                    VMA is one that was merged on a second attempt.
> > > + *
> > > + * @map:  Mapping state.
> > > + * @vmap: Output pointer for the new VMA.
> > > + *
> > > + * Returns: Zero on success, or an error.
> > > + */
> > > +static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
> > > +{
> > > +	struct vma_iterator *vmi = map->vmi;
> > > +	struct vma_merge_struct *vmg = map->vmg;
> > > +	struct vm_area_struct *merge = NULL;
> > > +	int error = 0;
> > > +	struct vm_area_struct *vma;
> > > +
> > >  	/*
> > >  	 * Determine the object being mapped and call the appropriate
> > >  	 * specific mapper. the address has already been validated, but
> > >  	 * not unmapped, but the maps are removed from the list.
> > >  	 */
> > > -	vma = vm_area_alloc(mm);
> > > -	if (!vma) {
> > > -		error = -ENOMEM;
> > > -		goto unacct_error;
> > > -	}
> > > +	vma = vm_area_alloc(map->mm);
> > > +	if (!vma)
> > > +		return -ENOMEM;
> > >
> > > -	vma_iter_config(&vmi, addr, end);
> > > -	vma_set_range(vma, addr, end, pgoff);
> > > -	vm_flags_init(vma, vm_flags);
> > > -	vma->vm_page_prot = vm_get_page_prot(vm_flags);
> > > +	vma_iter_config(vmi, vmg->start, vmg->end);
> > > +	vma_set_range(vma, vmg->start, vmg->end, vmg->pgoff);
> > > +	vm_flags_init(vma, map->flags);
> > > +	vma->vm_page_prot = vm_get_page_prot(map->flags);
> > >
> > > -	if (vma_iter_prealloc(&vmi, vma)) {
> > > +	if (vma_iter_prealloc(vmi, vma)) {
> > >  		error = -ENOMEM;
> > >  		goto free_vma;
> > >  	}
> > >
> > > -	if (file) {
> > > -		vma->vm_file = get_file(file);
> > > -		error = mmap_file(file, vma);
> > > -		if (error)
> > > -			goto unmap_and_free_file_vma;
> > > -
> > > -		/* Drivers cannot alter the address of the VMA. */
> > > -		WARN_ON_ONCE(addr != vma->vm_start);
> > > -		/*
> > > -		 * Drivers should not permit writability when previously it was
> > > -		 * disallowed.
> > > -		 */
> > > -		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
> > > -				!(vm_flags & VM_MAYWRITE) &&
> > > -				(vma->vm_flags & VM_MAYWRITE));
> > > -
> > > -		vma_iter_config(&vmi, addr, end);
> > > -		/*
> > > -		 * If vm_flags changed after mmap_file(), we should try merge
> > > -		 * vma again as we may succeed this time.
> > > -		 */
> > > -		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
> > > -			struct vm_area_struct *merge;
> > > -
> > > -			vmg.flags = vma->vm_flags;
> > > -			/* If this fails, state is reset ready for a reattempt. */
> > > -			merge = vma_merge_new_range(&vmg);
> > > -
> > > -			if (merge) {
> > > -				/*
> > > -				 * ->mmap() can change vma->vm_file and fput
> > > -				 * the original file. So fput the vma->vm_file
> > > -				 * here or we would add an extra fput for file
> > > -				 * and cause general protection fault
> > > -				 * ultimately.
> > > -				 */
> > > -				fput(vma->vm_file);
> > > -				vm_area_free(vma);
> > > -				vma_iter_free(&vmi);
> > > -				vma = merge;
> > > -				/* Update vm_flags to pick up the change. */
> > > -				vm_flags = vma->vm_flags;
> > > -				goto file_expanded;
> > > -			}
> > > -			vma_iter_config(&vmi, addr, end);
> > > -		}
> > > -
> > > -		vm_flags = vma->vm_flags;
> > > -	} else if (vm_flags & VM_SHARED) {
> > > +	if (vmg->file)
> > > +		error = __mmap_new_file_vma(map, vma, &merge);
> > > +	else if (map->flags & VM_SHARED)
> > >  		error = shmem_zero_setup(vma);
> > > -		if (error)
> > > -			goto free_iter_vma;
> > > -	} else {
> > > +	else
> > >  		vma_set_anonymous(vma);
> > > -	}
> > > +
> > > +	if (error)
> > > +		goto free_iter_vma;
> > > +
> > > +	if (merge)
> > > +		goto file_expanded;
> > >
> > >  #ifdef CONFIG_SPARC64
> > >  	/* TODO: Fix SPARC ADI! */
> > > -	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
> > > +	WARN_ON_ONCE(!arch_validate_flags(map->flags));
> > >  #endif
> > >
> > >  	/* Lock the VMA since it is modified after insertion into VMA tree */
> > >  	vma_start_write(vma);
> > > -	vma_iter_store(&vmi, vma);
> > > -	mm->map_count++;
> > > +	vma_iter_store(vmi, vma);
> > > +	map->mm->map_count++;
> > >  	vma_link_file(vma);
> > >
> > >  	/*
> > >  	 * vma_merge_new_range() calls khugepaged_enter_vma() too, the below
> > >  	 * call covers the non-merge case.
> > >  	 */
> > > -	khugepaged_enter_vma(vma, vma->vm_flags);
> > > +	khugepaged_enter_vma(vma, map->flags);
> > >
> > >  file_expanded:
> > > -	file = vma->vm_file;
> > >  	ksm_add_vma(vma);
> > > -expanded:
> > > +
> > > +	*vmap = vma;
> > > +	return 0;
> > > +
> > > +free_iter_vma:
> > > +	vma_iter_free(vmi);
> > > +free_vma:
> > > +	vm_area_free(vma);
> > > +	return error;
> > > +}
> > > +
> > > +/*
> > > + * __mmap_complete() - Unmap any VMAs we overlap, account memory mapping
> > > + *                     statistics, handle locking and finalise the VMA.
> > > + *
> > > + * @map: Mapping state.
> > > + * @vma: Merged or newly allocated VMA for the mmap()'d region.
> > > + */
> > > +static void __mmap_complete(struct mmap_state *map, struct vm_area_struct *vma)
> > > +{
> > > +	struct mm_struct *mm = map->mm;
> > > +	unsigned long vm_flags = vma->vm_flags;
> > > +
> > >  	perf_event_mmap(vma);
> > >
> > > -	/* Unmap any existing mapping in the area */
> > > -	vms_complete_munmap_vmas(&vms, &mas_detach);
> > > +	/* Unmap any existing mapping in the area. */
> > > +	vms_complete_munmap_vmas(&map->vms, &map->mas_detach);
> > >
> > > -	vm_stat_account(mm, vm_flags, pglen);
> > > +	vm_stat_account(mm, vma->vm_flags, map->pglen);
> > >  	if (vm_flags & VM_LOCKED) {
> > >  		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
> > >  					is_vm_hugetlb_page(vma) ||
> > > -					vma == get_gate_vma(current->mm))
> > > +					vma == get_gate_vma(mm))
> > >  			vm_flags_clear(vma, VM_LOCKED_MASK);
> > >  		else
> > > -			mm->locked_vm += pglen;
> > > +			mm->locked_vm += map->pglen;
> > >  	}
> > >
> > > -	if (file)
> > > +	if (vma->vm_file)
> > >  		uprobe_mmap(vma);
> > >
> > >  	/*
> > > @@ -2364,26 +2447,43 @@ unsigned long __mmap_region(struct file *file, unsigned long addr,
> > >  	vm_flags_set(vma, VM_SOFTDIRTY);
> > >
> > >  	vma_set_page_prot(vma);
> > > +}
> > >
> > > -	return addr;
> > > +unsigned long __mmap_region(struct file *file, unsigned long addr,
> > > +		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
> > > +		struct list_head *uf)
> > > +{
> > > +	struct mm_struct *mm = current->mm;
> > > +	struct vm_area_struct *vma;
> > > +	int error;
> > > +	VMA_ITERATOR(vmi, mm, addr);
> > > +	VMG_STATE(vmg, mm, &vmi, addr, addr + len, vm_flags, pgoff);
> > > +	MMAP_STATE(map, mm, &vmi, &vmg, uf, vm_flags, len);
> > >
> > > -unmap_and_free_file_vma:
> > > -	fput(vma->vm_file);
> > > -	vma->vm_file = NULL;
> > > +	vmg.file = file;
> > >
> > > -	vma_iter_set(&vmi, vma->vm_end);
> > > -	/* Undo any partial mapping done by a device driver. */
> > > -	unmap_region(&vmi.mas, vma, vmg.prev, vmg.next);
> > > -free_iter_vma:
> > > -	vma_iter_free(&vmi);
> > > -free_vma:
> > > -	vm_area_free(vma);
> > > -unacct_error:
> > > -	if (charged)
> > > -		vm_unacct_memory(charged);
> > > +	error = __mmap_prepare(&map);
> > > +	if (error)
> > > +		goto abort_munmap;
> > > +
> > > +	/* Attempt to merge with adjacent VMAs... */
> > > +	vmg.flags = map.flags;
> > > +	vma = vma_merge_new_range(&vmg);
> > > +	if (!vma) {
> > > +		/* ...but if we can't, allocate a new VMA. */
> > > +		error = __mmap_new_vma(&map, &vma);
> > > +		if (error)
> > > +			goto unacct_error;
> > > +	}
> > > +
> > > +	__mmap_complete(&map, vma);
> > >
> > > +	return addr;
> > > +
> > > +unacct_error:
> > > +	if (map.charged)
> > > +		vm_unacct_memory(map.charged);
> > >  abort_munmap:
> > > -	vms_abort_munmap_vmas(&vms, &mas_detach);
> > > -gather_failed:
> > > +	vms_abort_munmap_vmas(&map.vms, &map.mas_detach);
> > >  	return error;
> > >  }
> > > --
> > > 2.47.0
> >

