Return-Path: <linux-kernel+bounces-294696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4094959170
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 01:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D83D31C21716
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 23:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D951C9DE6;
	Tue, 20 Aug 2024 23:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iV48l5rF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GrdPLvtr"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698861C9DC2
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 23:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724198293; cv=fail; b=Ab60qznOPKj4xPFB2Ps1z66S2ysXfumqUBBw0YJRVepln7Iljm9dqHt2MR9ATRpznEPtqxfBh0gsoZxjzMvUkmNcO3f2Tavu/6fpBN490IOFHmMrMWv1sskRq4DTDdrlUxPW+TkTvb1E1Daig9bie/rPBStSN77WYvnDOwzWPOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724198293; c=relaxed/simple;
	bh=4BoDbH+8BYl2x5PGXsKrkv0NY/DVKc5EY8nphVnMq0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oX8CmUI8x75jltjvlkgBuI5iV5LpZDJLggAb7eKz0M63Jd2J+lYMY9NkOqhJk7ILLKORSDjbXGd9Qhqxog9xuaAVK855J/Qdklgv19HJGQTugG3hz8HEsmr8qtHC0E9HX2xJMEsAJtXdjM762G+2JfRPSVzEy71eha6Vt3teSF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iV48l5rF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GrdPLvtr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KMBZAm028778;
	Tue, 20 Aug 2024 23:57:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=INR2A1cBDUV4GAxtVOjXNUJPR3TPHjuX5sIyohpW8AI=; b=
	iV48l5rF4ocf/bbzCROLPZ7nyNuMPhodD62nvz3mNwW/pYFo3WmHEE+5Szy26hJK
	PH//eyeAz+cvW9iBl23R9X4ih3st9XSzIDyQm86VSsY5N1C9U35vF2srZOq2heIe
	66KlaspkivKwLPw9DvPthGNvhB+t8NElRAsA+VBJD+ttVlP1Nbadmkr0cnEJmr+F
	1+v11L/TzpTcrcxUHUT578WpYUpkodPAxVyZDYMHR8BWUhETdvHt6BU3MZFaOLyp
	oVSxhLP2BIZfght5Sw1qWdULzh40YaWKb9JIk9EnOv7x47eGRhgcrwrTrrK+CyC1
	GesgvPHNW7XBk6k3fON/gw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m45ebss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:57:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47KNY6L9023532;
	Tue, 20 Aug 2024 23:57:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4154x78fsn-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:57:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ump5vfYfdkDXcf4qIMy/ALfyhD0pVgIXwMc2AvHS6wqwCC5Ai/7YKOwC3K8HFZLiMFBGaFyPE62zsPpaYjq8awsneVnV8mHTTc7kgrcW7RPMu2ttRTWT/zTnGTpiVarTocgU0Y0T0HhQKg5/AsmVVrzQK5vhK9Mj7CWoZiZB8ujewE4uvtt/oED4+asmpzLF3T4WRp/WCRJnG6cmedu6Wwbv2RMteap8Oq/y0q9i+/crRV9SWWCrLqtHF9Noe802CNlLFQubIB7L4l8RPchOLsjDXlNRIHuqQeNREJi6B7a3kinlFvHI6/oCee3FwPH7gSgQRjxaJuM22f7LN6DpFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INR2A1cBDUV4GAxtVOjXNUJPR3TPHjuX5sIyohpW8AI=;
 b=oQNFFNk/HLFr5a75IqEaY8jHxebgG6EDNAoeo63IlErCY/2pjUfzgDqfWl9pCK1rtwZbtUzm3Yq5bOYzH7a9FzMivScRUOy05Kr/ilY6vSWl95JSkRnU9nL48xzUNQdJ/WLgpFa1OGLKQtG5wWAt0GwHpAJjZd2mw24lVn+KVL7/ftM/reOMB688S4SKoQM5vMwA2/pQkGi+8bGiODwm9ATa2xwaDzExYHrOg6uJ6tGO+mS6EtVs2RJ4i9jvuc+Yw36oEurCZKV/JQgxUmWFSOG0h+pFp2AfEpLLuMiVQt035qmUolzzn2GBA2KG7wo6UH7jCWFbJSCzAEbegrvopw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INR2A1cBDUV4GAxtVOjXNUJPR3TPHjuX5sIyohpW8AI=;
 b=GrdPLvtrG+ipjAWOxzcActXC4g/mSfsOL9ye3jHGCN57aX7+7uGOdfSK/u8A/QNDzAG39fDtmUaDQJJKvk8Zhsj0RY/a6ylPnQ6DG3Fsgagvdhqcvt8alIIf6i9psr7jZp54z4TcbRBXPWbO51uSsZoGPB6nBtXEk4OKclVwwuc=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB7099.namprd10.prod.outlook.com (2603:10b6:510:26d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Tue, 20 Aug
 2024 23:57:53 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.010; Tue, 20 Aug 2024
 23:57:53 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v6 03/20] mm/vma: Introduce vmi_complete_munmap_vmas()
Date: Tue, 20 Aug 2024 19:57:12 -0400
Message-ID: <20240820235730.2852400-4-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
References: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::26) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: 7145c791-b2d3-4962-d81c-08dcc173e7b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jbU8J7LBKR3gauWRkSXEzvbVpOluRb5OmDqVqYtyCKiZJC3KbPXz9NKZYQ+j?=
 =?us-ascii?Q?8USolP+TpUJN4Nlfq+FhfmlrJ5bvyvAWDRsIPEkrQWr1Bb7hmz9dJBtRfSUs?=
 =?us-ascii?Q?7XJ1ie0gdpPcSTDHWxokJXPATiC84H2SaIkJbIHUMWgTCkIp2x5SPuNdVOUp?=
 =?us-ascii?Q?E7IpbTRlzYKTexx8VsseoNLmo4Z+1tZJ4gkQQpULA0tqQmk2bUUOafKUOndr?=
 =?us-ascii?Q?QXn91RkT0pM9kb7BTZFPKJMfddureN/4r+QriJD6EifzdwbnDZBC6skQa4YE?=
 =?us-ascii?Q?kCnu/vNyLwhroanROnXabdO9rJVY2W3WJTDfcQmoQ0JPUwZyyt0Mldogpa/X?=
 =?us-ascii?Q?Pjz/+y9QfxW9Ur8wvr8TnZ4+9EDpYzOu6isBN4a7JqKEB9KtRdjNe2Hj1/Bk?=
 =?us-ascii?Q?bDpTXPMDVt/mu/K0679b39FAWQR9xfPF0YIwDaiy4fAXhlbgjltVYTusjqIN?=
 =?us-ascii?Q?tb7T1bOaAmOaUzG3dJvA0yqc768kTB/M9Hq6QVum06hQAlz0SQTykfYBbNE1?=
 =?us-ascii?Q?XSJIqZrjiFzFRT3hpcw6RmZj1eMSv1N+cbj7hQYEAxn1BYlU3x4Hq7guREiF?=
 =?us-ascii?Q?a7UIbCj6V6WqP1iSSmKHER1ga15P39pLR2lg5sZrGj66VcJKfFqbYz1ZMzf4?=
 =?us-ascii?Q?+JAtJvV69hk9tw4exOoZyj6EV270q3Yr8QLTPmV4O1U9JAat8ajrlm9sxg5Z?=
 =?us-ascii?Q?CJLArKOL9Xh6AlC0c+tweN9IenWRT5TDRQYaTyv4y/XsyS4Gl3JBUZClQLuW?=
 =?us-ascii?Q?+ppBstertDsCxOEW1P0CQiTSa0BNtd4hDoCZUwT57Jmq2xEmJGTFFSFaOqa4?=
 =?us-ascii?Q?ZM8K/HJVrhwuNG4eb6Td3w4ECfxfzJDtfc3ahcnzm76hBnBSRx9u7cCtqS6H?=
 =?us-ascii?Q?aFBkQaAeOAYrkC1irGzLQLR2llzj0Y7cwJ9VJvaxk6bT3Yi0ec9G5TLy7IFp?=
 =?us-ascii?Q?CywMKgb//9RJpjfT3ycf9hRLeCuro3Q7rpVLy0u33gjqu8uk+C/pgUf20SV2?=
 =?us-ascii?Q?iloP/pgoSsnumC/yA4xG7pLmdGaGMePdcoXGzGwnuW3ctmFlbnkxlW2Xogyx?=
 =?us-ascii?Q?H/6M4EFW6+Udmans260c+zpXb3hU0Of4ovR5o8N1OMVHru91i/d9dzt7krE4?=
 =?us-ascii?Q?oJcHRRtsu5J0FGrZZcm7F+VdC6ahZLNwOm3gCwWO8NdzmUrQNSjTeqTapwAD?=
 =?us-ascii?Q?Fp5ymZbbF4N6XyPwLdxl0kNCwxGRrTAGk5jORkp8oQqpEa4bQ4dDeimh8nNU?=
 =?us-ascii?Q?+rzk89INkvIHX4bBi7n5hA+Coi6lIBjrUaswikl+rNal2PnVbnGKEn5C8z5a?=
 =?us-ascii?Q?H+6+g6URLZtRv5W86xmTHA66gY6Tf84ExsGfylAAXyCA7g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EPI0OwAMW3Ogml7X6pPxJF/0X4QpGC3FN+drUZwhGF596Rgxjkvst/E7FPRG?=
 =?us-ascii?Q?wxM9Oav/uMclm1FtKgd+XEWsU7lM7IFdLJ5DQF5q454NqIEDMQQypFstQo0V?=
 =?us-ascii?Q?fMXLPl684Yv7/pQeS+0iXT0yv3dBH4T8HPta0m09TFaVc8Qx7q5b7v0hVqu8?=
 =?us-ascii?Q?NYqwFR18ghLDJC1ZsEZ/GFjqXvM3/nSq6PosfYQ2nZPQmIIlWWMD0GdRBiTN?=
 =?us-ascii?Q?FklH5Vbnlpi8gFQrwU84s+B9VAX4HjJbS2H7PBIlCWuNqnmCMoJWbNLv89px?=
 =?us-ascii?Q?ZLCmRjNtxTOCL3dd8a+m6J6FlqtR6uzRrTjNSF2L/kjaA+dZ5gHQRyUrzjdd?=
 =?us-ascii?Q?cR4C8DYpvAgRi+JMtfh8n0ZEbrDX8xniqb6WxJk+Apxv7ri7pAMCFbePUinH?=
 =?us-ascii?Q?7vppZSkwrI6BsaHpWAY37Q7H1WIqBucmd9tPxPQPsh60o9n+Yw8pCzVDrRNf?=
 =?us-ascii?Q?3jBJ3PgpfSqAtcqHUt7ZQav1TGZaQeC/3fTn2M41UyqmV88ybCjfgGyBwSRE?=
 =?us-ascii?Q?hJrwkTHAtduq1L0gD0KrWMtSndzx9MVztebOBOG1D5FHPqruVkCJzq+S1bea?=
 =?us-ascii?Q?CbUTNR6avl5jaQGOZiIaTZQoBTqIKeFoEFSHz0f+IiqsQgp7r25jJsBst/QP?=
 =?us-ascii?Q?GGg7CaGIjgX6ug0F1lCrZrYa9UsGAa79o5OLJ8XWtecvxSqTHkzudnKCqjle?=
 =?us-ascii?Q?n0HoTCg3P73AuMqaRAqM7Ifomc8KAFRxO8PUeCN5IMcWxbGKAFaVTSiUMPoc?=
 =?us-ascii?Q?bofAJ9oxHk9xPGi+AnzU7vE5Db5LtK6Cc+rsluQ3O0dXj6ZRrRTBkYrjCi97?=
 =?us-ascii?Q?2EfrdMQ7XDEGuvLuq6Pk3fiwMcrB84qJ/Fg9IDn+Fw21GpOnjuYA/D8LEFrW?=
 =?us-ascii?Q?jkM4JWT4kdqE6IL4c9pQ322JqBRqiAWsJg4L8lywFSHIw49LT5irYGWW465C?=
 =?us-ascii?Q?uALLWzsQfD8TPlhUEvv1iqv7Ma/y94ZcfEE8TSAuXo/7+WkfOHJ6CWvuy6pO?=
 =?us-ascii?Q?MV/0yGfdTCVeq9z50kpldVgq0OKXTBr/a9NsKvZ7Od1iv30omarzJtiRbPHs?=
 =?us-ascii?Q?XtQwYIbftdQQociGVfuvQQr74UiBM/bi50aqHADZM09NsDa2EZD8rvuDo5u3?=
 =?us-ascii?Q?rjxINDmim6woUiR5tfJkydFnvnPnYNo9WgMm1tQERsfkue7D5PLtlwNQL340?=
 =?us-ascii?Q?FcHr2kkzYyinS387sQ4Kitzvmak1yAMPri0SZwQASOvuU7K1tsvCbSlTooYo?=
 =?us-ascii?Q?1qj0b8Xi/KecR5mmqzpZJ0MGODYtq2MNmNMMtXMYQzRc1Oz16n9jsko7UTXO?=
 =?us-ascii?Q?/9doIslnvszHLopFHycZ9MZt2rSXElGAbYgUEcZcopEnOsh/QNuT7pkc6hMa?=
 =?us-ascii?Q?j5S8Gf1eYys5HXT4d4KZwD+m3O9GdBVc6zdDu4npNTKoiC8tH19qcm79989S?=
 =?us-ascii?Q?TwXyCBvGG6NLrYUOwBjOnJrgLNoUf7TivwjFxps7+vOD/wGY9wuxIRRGn1mb?=
 =?us-ascii?Q?YEH+j5MitPFKq39Tla5DGTHSYJPD9Msnb1yul+FlFXa4SV2qpfMQIy2hjN9g?=
 =?us-ascii?Q?k82QgSf38FzzH4ejZoRLpsCb+XV7/rsILVEf6BLs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mzs3+hbdvRKZIctF3TsKLwGghy4KiycNr6FODrGhIu9IOIrfKz1decLajuLbfZ5DrTNDIzbwFhooS0fL9quYlq4PLlcjPeUZHkG6JRLuvMYydN3bo1KIM89O8For4IHw26a0aPbpMlnjw2Z6nDsfS0DAGOwO6+1pc1CSNDWDbPcVT53tCFtdPY+X3ClR9ImQLdQ4YD7gPXA9UbOLllb35mphvCHCtsUNLhngbudS0vvugoHCsgbMkTwcx49jiSS0bnbbiirQavLzFEiVG+J/YnrN45C7uFe0eggRInOyvcZMB1Y7vsfCao/xEyUijujj95J5oOqB6rgKHQYI1F/eR9kswGkvSjBg5KXTVof4YdXtAkFsgHaeV+GrJ/AQAE8KZI0P0CqGoUP5Oxu0LQygqI4D5oF+V0nTBiYjBtRC0dXiucLB2YVdrC5RV5Ui9ficpae3Gvv3l92wKaKY+bNJHWqleDGa4dpd7vzF7DgioT7Ag//o6oiDenQjAhPL+uJwgITWHWZDemEvDRxnuGlJdcO8yrxKnTXpMmpiR3Y3xEjyi16877yX5cSXdvvykL49u9Bb0itmwYQLSg+/p7eCMrbspf1ipm+6OUUGh7pN3i0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7145c791-b2d3-4962-d81c-08dcc173e7b4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 23:57:53.4433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5yfTxP7nc2sD0lpKARLqB+Z1ul0HcTEgQGs/QII3vRBWgCULbzcdLshg5vMbpFanU5pWcls0VWD5Lprmq+LMcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_18,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408200176
X-Proofpoint-ORIG-GUID: TKAvJgV6Tw5tr_8J_E7flWznTOJ0muVd
X-Proofpoint-GUID: TKAvJgV6Tw5tr_8J_E7flWznTOJ0muVd

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Extract all necessary operations that need to be completed after the vma
maple tree is updated from a munmap() operation.  Extracting this makes
the later patch in the series easier to understand.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/vma.c | 80 ++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 55 insertions(+), 25 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 58ecd447670d..3a2098464b8f 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -684,6 +684,58 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
 	__mt_destroy(mas_detach->tree);
 }
 
+/*
+ * vmi_complete_munmap_vmas() - Finish the munmap() operation
+ * @vmi: The vma iterator
+ * @vma: The first vma to be munmapped
+ * @mm: The mm struct
+ * @start: The start address
+ * @end: The end address
+ * @unlock: Unlock the mm or not
+ * @mas_detach: them maple state of the detached vma maple tree
+ * @locked_vm: The locked_vm count in the detached vmas
+ *
+ * This function updates the mm_struct, unmaps the region, frees the resources
+ * used for the munmap() and may downgrade the lock - if requested.  Everything
+ * needed to be done once the vma maple tree is updated.
+ */
+static void
+vmi_complete_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		struct mm_struct *mm, unsigned long start, unsigned long end,
+		bool unlock, struct ma_state *mas_detach,
+		unsigned long locked_vm)
+{
+	struct vm_area_struct *prev, *next;
+	int count;
+
+	count = mas_detach->index + 1;
+	mm->map_count -= count;
+	mm->locked_vm -= locked_vm;
+	if (unlock)
+		mmap_write_downgrade(mm);
+
+	prev = vma_iter_prev_range(vmi);
+	next = vma_next(vmi);
+	if (next)
+		vma_iter_prev_range(vmi);
+
+	/*
+	 * We can free page tables without write-locking mmap_lock because VMAs
+	 * were isolated before we downgraded mmap_lock.
+	 */
+	mas_set(mas_detach, 1);
+	unmap_region(mm, mas_detach, vma, prev, next, start, end, count,
+		     !unlock);
+	/* Statistics and freeing VMAs */
+	mas_set(mas_detach, 0);
+	remove_mt(mm, mas_detach);
+	validate_mm(mm);
+	if (unlock)
+		mmap_read_unlock(mm);
+
+	__mt_destroy(mas_detach->tree);
+}
+
 /*
  * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
  * @vmi: The vma iterator
@@ -703,7 +755,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
 		    unsigned long end, struct list_head *uf, bool unlock)
 {
-	struct vm_area_struct *prev, *next = NULL;
+	struct vm_area_struct *next = NULL;
 	struct maple_tree mt_detach;
 	int count = 0;
 	int error = -ENOMEM;
@@ -818,31 +870,9 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		goto clear_tree_failed;
 
 	/* Point of no return */
-	mm->locked_vm -= locked_vm;
-	mm->map_count -= count;
-	if (unlock)
-		mmap_write_downgrade(mm);
-
-	prev = vma_iter_prev_range(vmi);
-	next = vma_next(vmi);
-	if (next)
-		vma_iter_prev_range(vmi);
-
-	/*
-	 * We can free page tables without write-locking mmap_lock because VMAs
-	 * were isolated before we downgraded mmap_lock.
-	 */
-	mas_set(&mas_detach, 1);
-	unmap_region(mm, &mas_detach, vma, prev, next, start, end, count,
-		     !unlock);
-	/* Statistics and freeing VMAs */
-	mas_set(&mas_detach, 0);
-	remove_mt(mm, &mas_detach);
-	validate_mm(mm);
-	if (unlock)
-		mmap_read_unlock(mm);
+	vmi_complete_munmap_vmas(vmi, vma, mm, start, end, unlock, &mas_detach,
+				 locked_vm);
 
-	__mt_destroy(&mt_detach);
 	return 0;
 
 modify_vma_failed:
-- 
2.43.0


