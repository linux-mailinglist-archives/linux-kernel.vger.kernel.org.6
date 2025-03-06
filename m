Return-Path: <linux-kernel+bounces-548676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D871A547E1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 938B4171097
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD19D20B1EB;
	Thu,  6 Mar 2025 10:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oz645Z5T";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LvNxAtpi"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E2320AF64
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257281; cv=fail; b=HdW14Pl+HR/Cj/NKQDBBDfWZUMe3XqowiX5g1ZR6t11QNnRzEmuzwzJnvEIqodAT2hj2IvjfFdR2ugS9IbhrZLbG8h/A+ZIuQzzv5HpsIMouXhHAooEM8YMdphrhh70DOjfbk3t9xT6/FB9OFrfyOOKuTMq4Q52WsKCuuVTwkms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257281; c=relaxed/simple;
	bh=s4DlmD4FiifVC/Se1i5PG7jRs5V6kH1zYZj5NSJgvaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CZv3RFVW2zp7blChZuirS+TKDPpiT3QcmL1DQTodeZ7vOQpV2Ky7BgIU01yZNAsVO02/Q5Kf5iNSFTPQ60OItGVwgGmB+nvJMN0Y2zCVfe2PJ1rltslw4DmxWeTT1hvXyGntbCAjsHRUm8xJ6qQLe4mfkvLKl6UOa+wHT7YAf5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oz645Z5T; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LvNxAtpi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526ACWWE025001;
	Thu, 6 Mar 2025 10:34:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=GGAIFI9CI0x0QrLT3hB7iuFb+RRoFDcK+Z7dwHZUaM4=; b=
	oz645Z5TtXip4oyT83UM8aOPJMX1L2111R7/wLUj4oZzCyW6oUgFmNAdCiVfQRzm
	gAmqLOGZaBWtOZr0ba0zvFXzFHWlLs/kVPfu15gltY56F9HJ9BNK4iGTWSdbHP1r
	8f00/J4NPdUpa7/UVmPQ1cw/eoaXKbKRB6wZJ0FEelbuVxAS+rSFe8ee7w7/i42n
	AcGtL+B9p6QVZ8diIyhAshiqtnqk+lLny2ZGJc+doAByd1TDiLKOI2B2YR3ILVLZ
	4IHFhQrskoxjf2z+CrLXz7UIvLd84c2p9B13TRMQh3TKzaelXnegyqAmowF2Jxtm
	rcJUCArM8diADHk5LT8iMQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453uaw1sab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 10:34:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5268xmFg010942;
	Thu, 6 Mar 2025 10:34:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpdh6we-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 10:34:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+n81w1jjJ0UOMkpsIjneXfZB2DbPZfSuI2HLpcxVNP6th7hc3AcwJ/62DW1lQQX4Yo2thiAhB/XNtnATMOL85jWa40cbusl/vl2ajlG92rtO+ECbZ1zGT9FS9FymOe2HyyzO3xn0zxAMGmCBZOHp8JooypP050j95ZuVlfYQ4pThv2WTv947EArHodQD/KfwqP6Stt115+JPbcVoUDL/rCilKR6eubHy5jOp8ZXwPuMU+dJasJkS9Hd1Yf+g6lePXgebEXk3NjiHIOYQ3kOS0cPhWpoZROFxm8QbzoGlpqBbKbw3LyKJqrS276/5AkfgpiQjemIw3ZFYOhONXvBtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGAIFI9CI0x0QrLT3hB7iuFb+RRoFDcK+Z7dwHZUaM4=;
 b=S8xNYOXENaH7M2PziRzgOw0S/QCAg4k4WWkIC2IzhWdUMoq5fRsn1tMU8p2rMj/7/nokusbLZGgttRjAFCK1OlJdh/NAXEiSJHCQfhMWFhpQXgRETXuokFX0DRusQEwJiuUBklt3nlc+jueAp0/ClhIIrUqdEvq8StDM/bW1rMl71pz6gJNe7UgSgbzipt2XslfQ6Js5AwWHWvTBeexRKKmL1bP3aSdB7y+D56MQlmh+z38+eV5h2IvTHjNYeR7gEYD9qhckaI7I/3oiDZRKQq72JdClV/n7AJfiGMPgSXa7ldHoz8kT2Il41wB+eUoun9ETpdMAOI/LG96Yb+r2mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGAIFI9CI0x0QrLT3hB7iuFb+RRoFDcK+Z7dwHZUaM4=;
 b=LvNxAtpiYnmK1nLetvfpGXp2BIQY3sn9Cip1XgevDAPL/y8qd15KLlFsp3ZzZmR+KO1YbDBwrTeI6ym3+eFCtSHTrs/s8rDntljjQCBotRuy5JkeCI7clCFENGwy9ILOX2F6lfjaECFaStyKJTcjs+lMeXBIVSAXj6Wwutr1cpM=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by PH0PR10MB4647.namprd10.prod.outlook.com (2603:10b6:510:43::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Thu, 6 Mar
 2025 10:34:23 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Thu, 6 Mar 2025
 10:34:23 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH v2 7/7] mm/mremap: thread state through move page table operation
Date: Thu,  6 Mar 2025 10:34:03 +0000
Message-ID: <1d85814f3a73eaa241c554b3e0f751f3e267a467.1741256580.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741256580.git.lorenzo.stoakes@oracle.com>
References: <cover.1741256580.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0250.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::12) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|PH0PR10MB4647:EE_
X-MS-Office365-Filtering-Correlation-Id: e983fdab-03c9-4b8c-6167-08dd5c9a760e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y85LrA9ugxZ3GM+d7Hqv8l3WLzz64+B6NH2oYqA3otjofLqQkrp/B3Yik6AQ?=
 =?us-ascii?Q?dcc8MSCoxpD0WuBoRWWLAIdIxD7js6MSAHVoq/MMZTdzDPVXUfzpw3q8Ltan?=
 =?us-ascii?Q?im7W/byCnIbBNpmPxauKuOyC9athKM3LQZkeoWRK+nrHJLF0xrhLDZZQRo/a?=
 =?us-ascii?Q?e55R4vMnmC/O6Qj2ODo/fwGnPj05U/W1gqKcGzat26KQ80cBfI/thzt+R1I8?=
 =?us-ascii?Q?o0g4YAAuBN2YwfO4DkxthKN1WCLJ3ELqBHcAJ6IhbvBC2loQ8MOsd55jyuFP?=
 =?us-ascii?Q?fPqvhtVfnFnKIdkYKgRwvKwtBqOi1OAcwcwqmdGroPKet3nLgTmgtHgGQ4n8?=
 =?us-ascii?Q?yTrjJhIOlnPiGzpQbzWQucI+k2mwriDyStjD9r8wqMjGuAtLd5OYI9meW0lv?=
 =?us-ascii?Q?ia+C56zI1tw7JMjbr1fFTO3Dfqe5DEytntBFPGoeA1pMTkOkR0deGZ4x9mDW?=
 =?us-ascii?Q?7F+beEQ0ew3xP9911X9U6eEHhS9OYcRtAqoEL5FlNSqE26JwPn0JDNARsEjc?=
 =?us-ascii?Q?mhzvlwdNqxg+DSL0Eb2wxrFbwnp20OCRGYJKR/mQDAqGJN17kiJAVR33Bing?=
 =?us-ascii?Q?h5GEQ9lshNwKWY4WlMzCX9WITmMrlYokm87mR18jP0YnnlOMX3nhAGfGmF7O?=
 =?us-ascii?Q?hlR2iJOxwysbtdo0O8roOXWpBwSg0lSHy3NnHbmyB8rCEicld80VZQhHTINt?=
 =?us-ascii?Q?jWZaX3ke6K2SClXwVkWmMENkeNjCKnFsYEE4ABv1Q3CDquoc1gs7lEC0ZipP?=
 =?us-ascii?Q?BLkTzTJy6hbcMGaMWrJWI3th6GKh1dmR5RrDP+Izb/cjJzIfjE3pJkEleh+M?=
 =?us-ascii?Q?0v6g5z9vXl8OLQf2bMRrlnU9CeqDPB6iaX0oIX0ctJTSMKlowHFb9sikNzXK?=
 =?us-ascii?Q?ikFsMFXLB+wER9XDCiNlTaTGU3bWOGLjPjeBCbS3mI9M4Mn6Vj9BSVeQoiyP?=
 =?us-ascii?Q?cqoZHGSR8NMJ6FYcpp99dIn6KF8+Vree6tzBL1EX9NphOkEE8wjbdSTMxhtC?=
 =?us-ascii?Q?9VbQkdxCk6M6QhEdh1SyCrbJV4Ng2G0VynsWOLLcRoUP1qKUQ1IfgCWQO2+N?=
 =?us-ascii?Q?RY2DD/kT7laoydv2+D+iH00EAwi0KQBANu11rX6JiyyfV7rCUS9bsWUCIUgn?=
 =?us-ascii?Q?VycjVHiiHQ8Jz9wE5u4oT+SCi5I0Agg9g9inHQGHvqitGBPcT8lyKNGrgylO?=
 =?us-ascii?Q?wthiXnVZD6VZTidsL24HUmdxNLzaYnkWdWnFy6z2ZuMepvUUhS+KAi5jMEoN?=
 =?us-ascii?Q?DegJB61RM9lyh3K+ieOAwofG7sPdCBgxkH23+zjZa3yVIwNCrczhyLm7VuyK?=
 =?us-ascii?Q?wlhBH1XwW8tB68L9KRCH5SsgWmC6dhX9hOFQnwiPu38e1Wr268Ohcm8gDqNX?=
 =?us-ascii?Q?v4mhNzZ04diyQTNjxOb5H+q2D6H4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ji5Rqn7rZv3MDVKDk9Q9wZjNTK+yllLJ8lqfvSMaGy00Wxs6zCkOOCgv6O5x?=
 =?us-ascii?Q?qihmmilJvMCepRgBF99OU/hAtyxWAuBWmhxneRqDGgU4tw5q8fYUt9NVm2WY?=
 =?us-ascii?Q?REjaAlFE0F8PHOe1xWsk06Ig6mknk/We1I5jesdehUcMoIYEHUoi2NNhTcM9?=
 =?us-ascii?Q?TFlTxg7NpBFtsjYIgm0SrRqZ2OHXuC8jQjBIJth9xpe3ZvG/6JvLUoMN0y9t?=
 =?us-ascii?Q?4g9vQMFVOVU82EK61JoLBscSlKxXc+zXzmUu4ReZLLWMa+Bb0tWvMMmUlFeh?=
 =?us-ascii?Q?yy7FSm4SGeO+laEx5BGdPkFU+eBkN2x2aAlDIjbnU/o9QBQ+ikH7oICHKy4R?=
 =?us-ascii?Q?b6WVUJnBJK8mmrHVtgyCL4ZfVtj+cs2i8D3nEwerR/QC6DqFoRHB/AiY0zxj?=
 =?us-ascii?Q?1QX5+qS2Inby1APUmZVJZAclYILEfZBVl+ailb+a48UqkqZtKrCH/fMxikbB?=
 =?us-ascii?Q?psybMxSUt4bKuVEFdQ9/kyTTE1gYrIs/5XPhf/7nkNNPwPgYFvx/PPyoqZi1?=
 =?us-ascii?Q?LFnVD66/j6pugeNZC83OfTmjbiNjtrTBK8qQC+bXPKMUXWQwQXZlEqQIrTnX?=
 =?us-ascii?Q?rgw0EKCm3SQdUIYiPa4tUddnU3DMsgweZhnp9p9FvTro6sRouwt0DUODAdb5?=
 =?us-ascii?Q?BbxcdwR86QehTs8jlJsi93YvFUGDgTot9Ti0bHaV0FmxarBqAb2ij6icW5HA?=
 =?us-ascii?Q?p15Da/VPUoWw5sUn8JM7HXME0HPOajN0pHyAyqja5GRMWCFtrA0BCOlIx95D?=
 =?us-ascii?Q?XznDlEGNtERH8bgmK7+YQi8wfdrSKZrAImLMVSBZh4ho7zUfdTg2SUn0jmni?=
 =?us-ascii?Q?x4nJtRJzeaNonJ98np3/VWE18KtGXfz2eiljLhao8HpBGMH+ctZfX/h6I/lu?=
 =?us-ascii?Q?zl9qrtXVo7hRmCobw5vovOIPKImC2qeLZqgywkAf6yev8ztG6P1mS1H8HrSi?=
 =?us-ascii?Q?GucV7PFaeg1wYQewwYoiieQQJuDnHuIjKweQOqQA3X1cAj2w+I5ZiawoYuTH?=
 =?us-ascii?Q?hxQXVIGayMMhe93QPba0W3mnzgfO3/zOtxY4eaxGymVEG5aynrlRYtHGGP6r?=
 =?us-ascii?Q?IyfsPr+LEPAjZ+IlyIwk1sUWziquRQ41scoFVzFMDWjWLahk5zHrSqKuCsEJ?=
 =?us-ascii?Q?r10xrlId7stFAcEbd/T5SGqPVs94M8wUufUjcXGM5hCjHlj07Gqpv+lodp03?=
 =?us-ascii?Q?kaDDqgHyCxi6q6eh5mE+8DVnRPGa/galPXQtLM7Xp4hJuGtr8bvh3SZoJnrF?=
 =?us-ascii?Q?XjVONAKmZffHqpeorq8cupJUJsBd+UFrkr0z0oVnlrwwSMu5fYukvNg/b26l?=
 =?us-ascii?Q?Wet7Y2RTKqrrNdn8hbqy15TxbMA3epfGUG4MA7MY9vhAw/RgT1jDoZaLUKP4?=
 =?us-ascii?Q?r2AzbhuedRreBzruORBR7s6EhJmVqYkcDe03/NH1II/u9ykcYh38u9IcxyPJ?=
 =?us-ascii?Q?NBsFCM8dlpHayMfsYRWePyJZulSHwBRAf7WuK3Np8MWDWlsi1M/nKEc2GTQX?=
 =?us-ascii?Q?27g8SRKMpG5HYmW7V7sIIDoBSrf8V9xp3XXnLNYZAJsmNBJY8JEeJyXcskdw?=
 =?us-ascii?Q?/b0RvMk8hyeFRy78RiDh4POVGPwY3oEM7GbDWwikqJFotyYb5WMqihOD76HD?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9iNz6dKC+HxGygpAcYwC5NznZzuCkDonMVQymQjD0PmgUtGMMAL7nhcxE7LoVPa2l9y+oXi01oC6KJLAN36cK7DghrLBrCoDQ0EaMvmVH0T9Wix7rqX3+VkOaY2fKuUnDDL5QXK7rCUXoGAZT0AO3yVh5DZpRULyW9qnKjUuoQ1zBuudiIcAhVlTPbKN3z/6T6iMZ7H1z77D4BIdUQenZaTwR1U2NuDQv1sVjozRrf3dAmr3Mlas+2GPfGQtsIye234rbaQw8FxIDs3a/vVecHi+TcGTDg/9RqrDThof2dei3Qtt/UnYaCG7JNFZVSKEbdU3w+rQuXRrmsCTG/EA4MVNi34+zuJSpbd6+BwUKnYVfdL6Hl4XtgJgNZww+HJwBE0lXpZ0WmJEUAD3eM9vDZ/eO6rsw+BGFpMCldowBJqzGLtSYR3UYMitSwqzhpMqx/d5eOlBRnqnHPyR/IyIMw5Vp57QD1QzawgZENnQq+xDFhbH/Q7tsiUS1mNqVkFLCbvs1LuYz77Pq0KsOWcKoWkS96kibpNaXhztzsaJ9IdQXPzHNy/aaIiPVwLELhcDft0e5nAKg7W7OXb2nWJi7y90ATBJP0z16pyXHmzBQGQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e983fdab-03c9-4b8c-6167-08dd5c9a760e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 10:34:23.4498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KXdvtoOgivQYhwHbYx592r2T1wy4ASrPX9UUbuhCEEfEHXcH/NJ4FZzPbtvIbctn3CSqLoDHEiYX8rCdCsNxYMQYXSnrihJ/7QLqebJySSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503060079
X-Proofpoint-GUID: xj2vhBG5Vwe91pZ8gdrD59YOSILViFJ9
X-Proofpoint-ORIG-GUID: xj2vhBG5Vwe91pZ8gdrD59YOSILViFJ9

Finish refactoring the page table logic by threading the PMC state
throughout the operation, allowing us to control the operation as we go.

Additionally, update the old_addr, new_addr fields in move_page_tables()
as we progress through the process making use of the fact we have this
state object now to track this.

With these changes made, not only is the code far more readable, but we
can finally transmit state throughout the entire operation, which lays the
groundwork for sensibly making changes in future to how the mremap()
operation is performed.

Additionally take the opportunity to refactor the means of determining the
progress of the operation, abstracting this to pmc_progress() and
simplifying the logic to make it clearer what's going on.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/internal.h |   3 +
 mm/mremap.c   | 201 +++++++++++++++++++++++++++++---------------------
 2 files changed, 120 insertions(+), 84 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index a4608c85a3ba..b3e781855044 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -39,6 +39,9 @@ struct folio_batch;
  *
  * Use the PAGETABLE_MOVE() macro to initialise this struct.
  *
+ * The old_addr and new_addr fields are updated as the page table move is
+ * executed.
+ *
  * NOTE: The page table move is affected by reading from [old_addr, old_end),
  * and old_addr may be updated for better page table alignment, so len_in
  * represents the length of the range being copied as specified by the user.
diff --git a/mm/mremap.c b/mm/mremap.c
index a4b0124528fa..89c8d1bb9b59 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -108,8 +108,7 @@ static pmd_t *get_old_pmd(struct mm_struct *mm, unsigned long addr)
 	return pmd;
 }
 
-static pud_t *alloc_new_pud(struct mm_struct *mm, struct vm_area_struct *vma,
-			    unsigned long addr)
+static pud_t *alloc_new_pud(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -122,13 +121,12 @@ static pud_t *alloc_new_pud(struct mm_struct *mm, struct vm_area_struct *vma,
 	return pud_alloc(mm, p4d, addr);
 }
 
-static pmd_t *alloc_new_pmd(struct mm_struct *mm, struct vm_area_struct *vma,
-			    unsigned long addr)
+static pmd_t *alloc_new_pmd(struct mm_struct *mm, unsigned long addr)
 {
 	pud_t *pud;
 	pmd_t *pmd;
 
-	pud = alloc_new_pud(mm, vma, addr);
+	pud = alloc_new_pud(mm, addr);
 	if (!pud)
 		return NULL;
 
@@ -172,17 +170,19 @@ static pte_t move_soft_dirty_pte(pte_t pte)
 	return pte;
 }
 
-static int move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
-		unsigned long old_addr, unsigned long old_end,
-		struct vm_area_struct *new_vma, pmd_t *new_pmd,
-		unsigned long new_addr, bool need_rmap_locks)
+static int move_ptes(struct pagetable_move_control *pmc,
+		unsigned long extent, pmd_t *old_pmd, pmd_t *new_pmd)
 {
+	struct vm_area_struct *vma = pmc->old;
 	bool need_clear_uffd_wp = vma_has_uffd_without_event_remap(vma);
 	struct mm_struct *mm = vma->vm_mm;
 	pte_t *old_pte, *new_pte, pte;
 	pmd_t dummy_pmdval;
 	spinlock_t *old_ptl, *new_ptl;
 	bool force_flush = false;
+	unsigned long old_addr = pmc->old_addr;
+	unsigned long new_addr = pmc->new_addr;
+	unsigned long old_end = old_addr + extent;
 	unsigned long len = old_end - old_addr;
 	int err = 0;
 
@@ -204,7 +204,7 @@ static int move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 	 *   serialize access to individual ptes, but only rmap traversal
 	 *   order guarantees that we won't miss both the old and new ptes).
 	 */
-	if (need_rmap_locks)
+	if (pmc->need_rmap_locks)
 		take_rmap_locks(vma);
 
 	/*
@@ -278,7 +278,7 @@ static int move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 	pte_unmap(new_pte - 1);
 	pte_unmap_unlock(old_pte - 1, old_ptl);
 out:
-	if (need_rmap_locks)
+	if (pmc->need_rmap_locks)
 		drop_rmap_locks(vma);
 	return err;
 }
@@ -293,10 +293,11 @@ static inline bool arch_supports_page_table_move(void)
 #endif
 
 #ifdef CONFIG_HAVE_MOVE_PMD
-static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
-		  unsigned long new_addr, pmd_t *old_pmd, pmd_t *new_pmd)
+static bool move_normal_pmd(struct pagetable_move_control *pmc,
+			pmd_t *old_pmd, pmd_t *new_pmd)
 {
 	spinlock_t *old_ptl, *new_ptl;
+	struct vm_area_struct *vma = pmc->old;
 	struct mm_struct *mm = vma->vm_mm;
 	bool res = false;
 	pmd_t pmd;
@@ -342,7 +343,7 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 	 * We don't have to worry about the ordering of src and dst
 	 * ptlocks because exclusive mmap_lock prevents deadlock.
 	 */
-	old_ptl = pmd_lock(vma->vm_mm, old_pmd);
+	old_ptl = pmd_lock(mm, old_pmd);
 	new_ptl = pmd_lockptr(mm, new_pmd);
 	if (new_ptl != old_ptl)
 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
@@ -359,7 +360,7 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 	VM_BUG_ON(!pmd_none(*new_pmd));
 
 	pmd_populate(mm, new_pmd, pmd_pgtable(pmd));
-	flush_tlb_range(vma, old_addr, old_addr + PMD_SIZE);
+	flush_tlb_range(vma, pmc->old_addr, pmc->old_addr + PMD_SIZE);
 out_unlock:
 	if (new_ptl != old_ptl)
 		spin_unlock(new_ptl);
@@ -368,19 +369,19 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 	return res;
 }
 #else
-static inline bool move_normal_pmd(struct vm_area_struct *vma,
-		unsigned long old_addr, unsigned long new_addr, pmd_t *old_pmd,
-		pmd_t *new_pmd)
+static inline bool move_normal_pmd(struct pagetable_move_control *pmc,
+		pmd_t *old_pmd, pmd_t *new_pmd)
 {
 	return false;
 }
 #endif
 
 #if CONFIG_PGTABLE_LEVELS > 2 && defined(CONFIG_HAVE_MOVE_PUD)
-static bool move_normal_pud(struct vm_area_struct *vma, unsigned long old_addr,
-		  unsigned long new_addr, pud_t *old_pud, pud_t *new_pud)
+static bool move_normal_pud(struct pagetable_move_control *pmc,
+		pud_t *old_pud, pud_t *new_pud)
 {
 	spinlock_t *old_ptl, *new_ptl;
+	struct vm_area_struct *vma = pmc->old;
 	struct mm_struct *mm = vma->vm_mm;
 	pud_t pud;
 
@@ -406,7 +407,7 @@ static bool move_normal_pud(struct vm_area_struct *vma, unsigned long old_addr,
 	 * We don't have to worry about the ordering of src and dst
 	 * ptlocks because exclusive mmap_lock prevents deadlock.
 	 */
-	old_ptl = pud_lock(vma->vm_mm, old_pud);
+	old_ptl = pud_lock(mm, old_pud);
 	new_ptl = pud_lockptr(mm, new_pud);
 	if (new_ptl != old_ptl)
 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
@@ -418,7 +419,7 @@ static bool move_normal_pud(struct vm_area_struct *vma, unsigned long old_addr,
 	VM_BUG_ON(!pud_none(*new_pud));
 
 	pud_populate(mm, new_pud, pud_pgtable(pud));
-	flush_tlb_range(vma, old_addr, old_addr + PUD_SIZE);
+	flush_tlb_range(vma, pmc->old_addr, pmc->old_addr + PUD_SIZE);
 	if (new_ptl != old_ptl)
 		spin_unlock(new_ptl);
 	spin_unlock(old_ptl);
@@ -426,19 +427,19 @@ static bool move_normal_pud(struct vm_area_struct *vma, unsigned long old_addr,
 	return true;
 }
 #else
-static inline bool move_normal_pud(struct vm_area_struct *vma,
-		unsigned long old_addr, unsigned long new_addr, pud_t *old_pud,
-		pud_t *new_pud)
+static inline bool move_normal_pud(struct pagetable_move_control *pmc,
+		pud_t *old_pud, pud_t *new_pud)
 {
 	return false;
 }
 #endif
 
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
-static bool move_huge_pud(struct vm_area_struct *vma, unsigned long old_addr,
-			  unsigned long new_addr, pud_t *old_pud, pud_t *new_pud)
+static bool move_huge_pud(struct pagetable_move_control *pmc,
+		pud_t *old_pud, pud_t *new_pud)
 {
 	spinlock_t *old_ptl, *new_ptl;
+	struct vm_area_struct *vma = pmc->old;
 	struct mm_struct *mm = vma->vm_mm;
 	pud_t pud;
 
@@ -453,7 +454,7 @@ static bool move_huge_pud(struct vm_area_struct *vma, unsigned long old_addr,
 	 * We don't have to worry about the ordering of src and dst
 	 * ptlocks because exclusive mmap_lock prevents deadlock.
 	 */
-	old_ptl = pud_lock(vma->vm_mm, old_pud);
+	old_ptl = pud_lock(mm, old_pud);
 	new_ptl = pud_lockptr(mm, new_pud);
 	if (new_ptl != old_ptl)
 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
@@ -466,8 +467,8 @@ static bool move_huge_pud(struct vm_area_struct *vma, unsigned long old_addr,
 
 	/* Set the new pud */
 	/* mark soft_ditry when we add pud level soft dirty support */
-	set_pud_at(mm, new_addr, new_pud, pud);
-	flush_pud_tlb_range(vma, old_addr, old_addr + HPAGE_PUD_SIZE);
+	set_pud_at(mm, pmc->new_addr, new_pud, pud);
+	flush_pud_tlb_range(vma, pmc->old_addr, pmc->old_addr + HPAGE_PUD_SIZE);
 	if (new_ptl != old_ptl)
 		spin_unlock(new_ptl);
 	spin_unlock(old_ptl);
@@ -475,8 +476,9 @@ static bool move_huge_pud(struct vm_area_struct *vma, unsigned long old_addr,
 	return true;
 }
 #else
-static bool move_huge_pud(struct vm_area_struct *vma, unsigned long old_addr,
-			  unsigned long new_addr, pud_t *old_pud, pud_t *new_pud)
+static bool move_huge_pud(struct pagetable_move_control *pmc,
+		pud_t *old_pud, pud_t *new_pud)
+
 {
 	WARN_ON_ONCE(1);
 	return false;
@@ -497,10 +499,12 @@ enum pgt_entry {
  * destination pgt_entry.
  */
 static __always_inline unsigned long get_extent(enum pgt_entry entry,
-			unsigned long old_addr, unsigned long old_end,
-			unsigned long new_addr)
+						struct pagetable_move_control *pmc)
 {
 	unsigned long next, extent, mask, size;
+	unsigned long old_addr = pmc->old_addr;
+	unsigned long old_end = pmc->old_end;
+	unsigned long new_addr = pmc->new_addr;
 
 	switch (entry) {
 	case HPAGE_PMD:
@@ -529,38 +533,54 @@ static __always_inline unsigned long get_extent(enum pgt_entry entry,
 	return extent;
 }
 
+/*
+ * Should move_pgt_entry() acquire the rmap locks? This is either expressed in
+ * the PMC, or overridden in the case of normal, larger page tables.
+ */
+static bool should_take_rmap_locks(struct pagetable_move_control *pmc,
+				   enum pgt_entry entry)
+{
+	if (pmc->need_rmap_locks)
+		return true;
+
+	switch (entry) {
+	case NORMAL_PMD:
+	case NORMAL_PUD:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /*
  * Attempts to speedup the move by moving entry at the level corresponding to
  * pgt_entry. Returns true if the move was successful, else false.
  */
-static bool move_pgt_entry(enum pgt_entry entry, struct vm_area_struct *vma,
-			unsigned long old_addr, unsigned long new_addr,
-			void *old_entry, void *new_entry, bool need_rmap_locks)
+static bool move_pgt_entry(struct pagetable_move_control *pmc,
+			   enum pgt_entry entry, void *old_entry, void *new_entry)
 {
 	bool moved = false;
+	bool need_rmap_locks = should_take_rmap_locks(pmc, entry);
 
 	/* See comment in move_ptes() */
 	if (need_rmap_locks)
-		take_rmap_locks(vma);
+		take_rmap_locks(pmc->old);
 
 	switch (entry) {
 	case NORMAL_PMD:
-		moved = move_normal_pmd(vma, old_addr, new_addr, old_entry,
-					new_entry);
+		moved = move_normal_pmd(pmc, old_entry, new_entry);
 		break;
 	case NORMAL_PUD:
-		moved = move_normal_pud(vma, old_addr, new_addr, old_entry,
-					new_entry);
+		moved = move_normal_pud(pmc, old_entry, new_entry);
 		break;
 	case HPAGE_PMD:
 		moved = IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
-			move_huge_pmd(vma, old_addr, new_addr, old_entry,
+			move_huge_pmd(pmc->old, pmc->old_addr, pmc->new_addr, old_entry,
 				      new_entry);
 		break;
 	case HPAGE_PUD:
 		moved = IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
-			move_huge_pud(vma, old_addr, new_addr, old_entry,
-				      new_entry);
+			move_huge_pud(pmc, old_entry, new_entry);
 		break;
 
 	default:
@@ -569,7 +589,7 @@ static bool move_pgt_entry(enum pgt_entry entry, struct vm_area_struct *vma,
 	}
 
 	if (need_rmap_locks)
-		drop_rmap_locks(vma);
+		drop_rmap_locks(pmc->old);
 
 	return moved;
 }
@@ -705,19 +725,48 @@ static void try_realign_addr(struct pagetable_move_control *pmc,
 	pmc->new_addr &= pagetable_mask;
 }
 
+/* Is the page table move operation done? */
+static bool pmc_done(struct pagetable_move_control *pmc)
+{
+	return pmc->old_addr >= pmc->old_end;
+}
+
+/* Advance to the next page table, offset by extent bytes. */
+static void pmc_next(struct pagetable_move_control *pmc, unsigned long extent)
+{
+	pmc->old_addr += extent;
+	pmc->new_addr += extent;
+}
+
+/*
+ * Determine how many bytes in the specified input range have had their page
+ * tables moved so far.
+ */
+static unsigned long pmc_progress(struct pagetable_move_control *pmc)
+{
+	unsigned long orig_old_addr = pmc->old_end - pmc->len_in;
+	unsigned long old_addr = pmc->old_addr;
+
+	/*
+	 * Prevent negative return values when {old,new}_addr was realigned but
+	 * we broke out of the loop in move_page_tables() for the first PMD
+	 * itself.
+	 */
+	return old_addr < orig_old_addr ? 0 : old_addr - orig_old_addr;
+}
+
 unsigned long move_page_tables(struct pagetable_move_control *pmc)
 {
-	unsigned long extent, old_end;
+	unsigned long extent;
 	struct mmu_notifier_range range;
 	pmd_t *old_pmd, *new_pmd;
 	pud_t *old_pud, *new_pud;
-	unsigned long old_addr, new_addr;
-	struct vm_area_struct *vma = pmc->old;
+	struct mm_struct *mm = pmc->old->vm_mm;
 
 	if (!pmc->len_in)
 		return 0;
 
-	if (is_vm_hugetlb_page(vma))
+	if (is_vm_hugetlb_page(pmc->old))
 		return move_hugetlb_page_tables(pmc->old, pmc->new, pmc->old_addr,
 						pmc->new_addr, pmc->len_in);
 
@@ -726,87 +775,71 @@ unsigned long move_page_tables(struct pagetable_move_control *pmc)
 	 * Only realign if the mremap copying hits a PMD boundary.
 	 */
 	try_realign_addr(pmc, PMD_MASK);
-	/* These may have been changed. */
-	old_addr = pmc->old_addr;
-	new_addr = pmc->new_addr;
-	old_end = pmc->old_end;
-
-	flush_cache_range(vma, old_addr, old_end);
-	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma->vm_mm,
-				old_addr, old_end);
+
+	flush_cache_range(pmc->old, pmc->old_addr, pmc->old_end);
+	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, mm,
+				pmc->old_addr, pmc->old_end);
 	mmu_notifier_invalidate_range_start(&range);
 
-	for (; old_addr < old_end; old_addr += extent, new_addr += extent) {
+	for (; !pmc_done(pmc); pmc_next(pmc, extent)) {
 		cond_resched();
 		/*
 		 * If extent is PUD-sized try to speed up the move by moving at the
 		 * PUD level if possible.
 		 */
-		extent = get_extent(NORMAL_PUD, old_addr, old_end, new_addr);
+		extent = get_extent(NORMAL_PUD, pmc);
 
-		old_pud = get_old_pud(vma->vm_mm, old_addr);
+		old_pud = get_old_pud(mm, pmc->old_addr);
 		if (!old_pud)
 			continue;
-		new_pud = alloc_new_pud(vma->vm_mm, vma, new_addr);
+		new_pud = alloc_new_pud(mm, pmc->new_addr);
 		if (!new_pud)
 			break;
 		if (pud_trans_huge(*old_pud) || pud_devmap(*old_pud)) {
 			if (extent == HPAGE_PUD_SIZE) {
-				move_pgt_entry(HPAGE_PUD, vma, old_addr, new_addr,
-					       old_pud, new_pud, pmc->need_rmap_locks);
+				move_pgt_entry(pmc, HPAGE_PUD, old_pud, new_pud);
 				/* We ignore and continue on error? */
 				continue;
 			}
 		} else if (IS_ENABLED(CONFIG_HAVE_MOVE_PUD) && extent == PUD_SIZE) {
-			if (move_pgt_entry(NORMAL_PUD, vma, old_addr, new_addr,
-					   old_pud, new_pud, true))
+			if (move_pgt_entry(pmc, NORMAL_PUD, old_pud, new_pud))
 				continue;
 		}
 
-		extent = get_extent(NORMAL_PMD, old_addr, old_end, new_addr);
-		old_pmd = get_old_pmd(vma->vm_mm, old_addr);
+		extent = get_extent(NORMAL_PMD, pmc);
+		old_pmd = get_old_pmd(mm, pmc->old_addr);
 		if (!old_pmd)
 			continue;
-		new_pmd = alloc_new_pmd(vma->vm_mm, vma, new_addr);
+		new_pmd = alloc_new_pmd(mm, pmc->new_addr);
 		if (!new_pmd)
 			break;
 again:
 		if (is_swap_pmd(*old_pmd) || pmd_trans_huge(*old_pmd) ||
 		    pmd_devmap(*old_pmd)) {
 			if (extent == HPAGE_PMD_SIZE &&
-			    move_pgt_entry(HPAGE_PMD, vma, old_addr, new_addr,
-					   old_pmd, new_pmd, pmc->need_rmap_locks))
+			    move_pgt_entry(pmc, HPAGE_PMD, old_pmd, new_pmd))
 				continue;
-			split_huge_pmd(vma, old_pmd, old_addr);
+			split_huge_pmd(pmc->old, old_pmd, pmc->old_addr);
 		} else if (IS_ENABLED(CONFIG_HAVE_MOVE_PMD) &&
 			   extent == PMD_SIZE) {
 			/*
 			 * If the extent is PMD-sized, try to speed the move by
 			 * moving at the PMD level if possible.
 			 */
-			if (move_pgt_entry(NORMAL_PMD, vma, old_addr, new_addr,
-					   old_pmd, new_pmd, true))
+			if (move_pgt_entry(pmc, NORMAL_PMD, old_pmd, new_pmd))
 				continue;
 		}
 		if (pmd_none(*old_pmd))
 			continue;
 		if (pte_alloc(pmc->new->vm_mm, new_pmd))
 			break;
-		if (move_ptes(vma, old_pmd, old_addr, old_addr + extent,
-			      pmc->new, new_pmd, new_addr, pmc->need_rmap_locks) < 0)
+		if (move_ptes(pmc, extent, old_pmd, new_pmd) < 0)
 			goto again;
 	}
 
 	mmu_notifier_invalidate_range_end(&range);
 
-	/*
-	 * Prevent negative return values when {old,new}_addr was realigned
-	 * but we broke out of the above loop for the first PMD itself.
-	 */
-	if (old_addr < old_end - pmc->len_in)
-		return 0;
-
-	return pmc->len_in + old_addr - old_end;	/* how much done */
+	return pmc_progress(pmc);
 }
 
 /* Set vrm->delta to the difference in VMA size specified by user. */
-- 
2.48.1


