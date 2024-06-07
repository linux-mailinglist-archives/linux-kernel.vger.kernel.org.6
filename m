Return-Path: <linux-kernel+bounces-206623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19965900C1A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 929A31F23195
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA5715EFB5;
	Fri,  7 Jun 2024 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wn/pWOf0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jM47eTXs"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3C814B07B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717786434; cv=fail; b=u8yhBYwMfnxWalP57cwHujSpPQ/FOhebzb4pGslhTLlVh5PD6t8jMOLKnvBWL7TFzRQ4gBGwrbfTIMr7yNkx35wkx9eIag1IYKvJiO+4W8E2h9DNaiKKPvtgZI1u1RE/vunVIvADrV0n+aQ7jWKTIDp80NWe4he9jMGKhL3rYoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717786434; c=relaxed/simple;
	bh=FHBPLAk1yjQfLp/gCiHi8gjI2VEhvH6ZZCHdcF/acfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sLMHLOb5OsRn4xcYQ1Cceb9i6wXh9h2kARtjoGKVPTZevkgrNBtECcDxt6rwN3PT1lcw2+mmnu6woMhj0qaFtd77xLdYXmDuVWXux3Jd/Us4luOOonLmfoN8JsIze5dgbpZ4GRXFaz7vp83h5GeYy/HFRN5cFJ0CC299hhOvPfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wn/pWOf0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jM47eTXs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457Cui9W016028;
	Fri, 7 Jun 2024 18:53:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=txVUe87r89sa/r6dkQBB9JXM5MiU6n0BwAusUfBDG20=;
 b=Wn/pWOf0w9AcHLetpZHNfsGbe79H8pS3kPQe5/9FvEUSjmfrcHnRVNEArKS+scEly/PW
 QJ9YwFmKK5KH3wQoEaEoQWy/VLVnd8/wHqcLGxF8uRZqTNNwEgtmtrDQcUYg9KDGh1Js
 H1Kh6my9H5z3euCfScr4YHdv/4Q7jAEJZ4ZutrMsYzDzgFycHiXtQwrewHmHyuNkCBJO
 VKmg/aHSYqSbbIjjaBVuDEOD5IHiCqtjxHntHBD/OViyGZK2X27GTwdzCcqlulhIloOx
 g50pfZOs8Pz4Y62PDAm+RNZ380WXFGRAepyiZqjS++WMNDraQMX6nOd8XX75IV7E8MPX ig== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbqn69hc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 18:53:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457ICR4F023938;
	Fri, 7 Jun 2024 18:53:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrr2k7tv-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 18:53:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVoVgsZEsqtZWegYCqRDDoSpE0E64vnOp9f+5Rl1NAjMeIJx3LkuexlS6aQQdQXUulksOXdH1NahEgiy85m0VoeUaqxhhMxoBJhNGWP18Fx6vRPxNTj0FJbB2nDwvqZE6z2rMPTMjSFiT/OQzI/GbMOo/xIejmHWRXa9PStkmCIk9EnfTKa8KLT7QgFzc0DgS9zu5BP7FJbdK/N92/lvSGHJLS7fG0TIpIeNRi8XEIGwKEKQB/2bxhtm51s8OJsS47ZyZuH6UGWvl4ZHKyZbD2VzTzLcrVhUKyPDbVXAtNFbnI8wxYBzDx7CK4u9YJ9+X6E+aW+WVv1SAXH9TMD3Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txVUe87r89sa/r6dkQBB9JXM5MiU6n0BwAusUfBDG20=;
 b=H0hzFyjMpWefWOBoHqNvDNJ1Hmv2/wgknJe0SiFsm5xHfmwqBUH2AO9244BmLll7cLiV9U1vss6QKp9eApWTrp9uNDB4VF8AFjA2Sx+dvOPl9TnK/GvRu3cN0AGjPGKbwxLWyooG5McNfedjdhk4J5DgQIzMH7doVvGgLFghQEzkiNBx88/bllqmFStOInJU7ivCqeMpVwKT7ixIORYEK8U6PUK0Lm4LWB+QkBnFrzZLLSp3H/2A+drm03qlaz904juC/hoJckI7MXe88YYBx2naOmA3GDuui9hl6n2mdKt+EP5jXDA7cLCNDPGYmKJg4SnF6WDq6RYcRN1Bd9vjKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txVUe87r89sa/r6dkQBB9JXM5MiU6n0BwAusUfBDG20=;
 b=jM47eTXslYt1uw8v8AuLjjWHbNtBaqZjXuV6sN9fHOB8HIvHckmtV2aHdTeu02u6wEL0Cv0tTq6DxEXLrLIBWHtIPVRpdu/EsdbTA9ZmzTkOQ7T4hCGcpk9X0zsMQXwkv9nOtbJ7BmaOhZq+bYCyrgN9B2CvtIBUZte6dShAF/Q=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SJ0PR10MB5629.namprd10.prod.outlook.com (2603:10b6:a03:3e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Fri, 7 Jun
 2024 18:53:22 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.034; Fri, 7 Jun 2024
 18:53:22 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 08/16] maple_tree: print store type in mas_dump()
Date: Fri,  7 Jun 2024 11:52:49 -0700
Message-ID: <20240607185257.963768-9-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
References: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0028.namprd15.prod.outlook.com
 (2603:10b6:207:17::41) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SJ0PR10MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 8205936e-3d8c-4830-264d-08dc87231ae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?RlLfwVqGFaFyBI2DdDSqSQQZ4lWLVY+x0flQbRDFrCVHlU7NW8aNCW4NLGOz?=
 =?us-ascii?Q?R0OAiFaWOe1POiiMO5kpcXmLEUwwaUPmBzIOvucKlZCM/bFp6OuWqVocEhC+?=
 =?us-ascii?Q?kGAoKqPCucl5N2DlDrYHE9VgA6huSkSPHFKIoUvjW/1bEYwuny7Jcgsf2GYb?=
 =?us-ascii?Q?PBv8fy7Zjm26nLEEQW1d57zmTsT8AYcZJ9wZr2OV2yz+maURBOjE7kyH3AJL?=
 =?us-ascii?Q?CyUQI923F9zryWXS0p7/M1WLaJA4vaQ/UkwVp5TiWv1Im5ggeyJORBtMZ1AQ?=
 =?us-ascii?Q?CGH8my4yBGHzNsV8MdzdPLGnR6erMKXEVj9amSnDoGm5ftwW7FWVAMxJ0rbZ?=
 =?us-ascii?Q?szUTWi2mVDkKyKDdfeVnXFZ9J5AFxu8qvGHkjhLZEireEdomqreehcp63PQR?=
 =?us-ascii?Q?mWeOl2nr/i59vMSsEzDI3MC1ngUJPDxn/DjLqZ8gQNV8Y35eB73KxZ+dqwJy?=
 =?us-ascii?Q?HS/i4IdZ1fqv/LPN/xwyAuPaPCghUFH3GTXVNqK1JYtNgYUTyqSnyAIk6+j9?=
 =?us-ascii?Q?pKiV2LNjIt3fuehPeFo0V4tVc1u8mTbsvQ9s4jYwloigqWX4DMIa07mjTTMe?=
 =?us-ascii?Q?mreN2CGyjYAl8Dq87SaDKWh0Gyp8/TaPaLjWQ0mMr7qdzA+ToLBVyZ6sAWuU?=
 =?us-ascii?Q?AWaluTMZ6/yboWnw0c0LF5cNSOghaylkwdLqb4MBRo4XDRa+062rjLZCjaAj?=
 =?us-ascii?Q?fGX359Anl1nguwXbcF2twYfVabhyJ/e6fJaYADlXniYU8lhUIG7wAzraOX7x?=
 =?us-ascii?Q?rxlj5rFX6jRfelSYzxgDZzbanXgvmhuqaa1WLIPsx1dyRKx7dL3VnkkJr9ge?=
 =?us-ascii?Q?LZNSXYd1SoFqW/2vEa2995jQn2wmVIz/psQco8NWauA3zCIXbBhXIuZPOttV?=
 =?us-ascii?Q?QTwrryKKBEVvonx9b86Is7sYFDSRrYF6PstHdOjjX/8zrEZjSX5itLcOOZi/?=
 =?us-ascii?Q?D7h8IWNvBxyPcL0yWsgwp87gH3qi8FH+g87ybD+rZ0Dls5kgQOy+ZSX6j0TT?=
 =?us-ascii?Q?f+rM1M2LYvuqytxZ/BAxt9lad0ERweEynMM3jyq0seMt5UKEwwL40sDfWxu6?=
 =?us-ascii?Q?v+YKOHec5GiSS6/ZCErTmsOtEWF/z6qvPfil8vHrIyCF1hPBSCq7eGZ4w+Gg?=
 =?us-ascii?Q?trG7HC9XXK78w1RzpyzkBtdHlcWq0OoIYPtEe4a+usMatlL+GK5E9cpxbbT7?=
 =?us-ascii?Q?WdRz0DyZdMOsIW8bcygvlR/rHw8to4cNjdJdTefH91IbXlakHKZfeYDrSEDK?=
 =?us-ascii?Q?tKlIGmb3u5IoYcA50yVQbgXNETkQItOCTL5AGYpYkhKGDMh8mRqDdJH2xL3g?=
 =?us-ascii?Q?2Lw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PsLagm3uE3R3CfrAkba5WxifHESo/ANJu6upD6LHsjh786htgGpSUz2ogKzN?=
 =?us-ascii?Q?savQ4p3o/TJ46yu3cIaq9Zu3MVQnw5ItXRF7B/xB2YMeCXKmklZkHaSBgzPj?=
 =?us-ascii?Q?Q8R2tyjZ2Bq/iZtAx+Lb1xEBdqzz/NIOrwR/ZLxnKFq36OTd74x4xplpPmtN?=
 =?us-ascii?Q?4NAd8OJBgKnr223hbtXEWcPPe1bXWbMS5XfbuNO58Go2zng8i4/Ogfrb+hOn?=
 =?us-ascii?Q?QhWUVtWzQyGDmC8bFh6eo2Awa63KVCsaLd2WI9vQ4qRwW7QyGySCwXyNVclE?=
 =?us-ascii?Q?ohe9VmldpsISajZyBIaXr/iLDGQbafrYfOuptC+dU0ur7GsSXGsNDIc9nH4m?=
 =?us-ascii?Q?rpNUmJ7Id/BdvF9UOj5grVdzCsYdi4aj0c9sxH7j6aApMgB59v/+VgVMVXHg?=
 =?us-ascii?Q?HaN+TseAth139EeEOm+qKfFJtcW4jG86pvrNOd58zeINRDEwBCxdb/mAM2j6?=
 =?us-ascii?Q?+gq41irRrgXaOlVft0kndwc7rqXLviXLkKxZXKi2syEvbnsMf3hF4OExVS9D?=
 =?us-ascii?Q?PFLWUOiYttqg3SvySBUBylBIJtvn925vD4YH4Jb3tymbjZkVLthipn+ZymrW?=
 =?us-ascii?Q?/Z4BqoTi87PoWMO4cfExhz4io7ZLAxMS5pCYL09c5rRHZzXr170RuWA1bY99?=
 =?us-ascii?Q?QB6TPRDjunRJ5zOR78DTwtKt701MEkw7QmvSt0yRYXlCnIc4NfIioW3SrjA6?=
 =?us-ascii?Q?6K/1uvNGgwcSXc/XfLly7z3YnqfbM/H4ODa4BeSSqLyG7rHvGqB8I3YFcR8T?=
 =?us-ascii?Q?MaPgpaXFAhUn69ZTJLGfGIWK8HPBD+PqchL1HkxsLeToAhfcThJRRgMP634m?=
 =?us-ascii?Q?umFeWwR50cMGppC+VknvDrDMnA5tXVy6Cvmn2xmRuxcvndx3r7wDoty4DYNu?=
 =?us-ascii?Q?FlmIFGNJgPT4io+Vz0RFlG4/A0X0klCrfcrfW9x5xvtds5/iYNW8bwLcTDJk?=
 =?us-ascii?Q?uOh5zWs/hXH/4tR8hL/Mm1roojaG0KxQ7oPuUXA+QCVi1PZeUYhli1UCAooT?=
 =?us-ascii?Q?4Jnk/HTneVD56Ra91FX/c6jJrUEET/OwPhfjyg4ng+2IultYA1Xav5ZoIhXJ?=
 =?us-ascii?Q?P7ryXd6bxKvmKdRV3+GhsvOl/R1PX8OPBuGTqpjbmlHEIU7fLIW3/hxm3oFo?=
 =?us-ascii?Q?lz8C6L9qiajqrHBlAfJ29aRgClm2HryX62nNs5wRWW2lMkTToiXsrotAHU/S?=
 =?us-ascii?Q?pqktUjl65GVy4IXfitBWf5PyYKIsoUieWXTKz70CinbJOc02i68prOp/EqyA?=
 =?us-ascii?Q?X4mXWlIs/qKiZIapY9fxFDmfBIV9FP8mqICWHxELT6Dh8hHqaMKW+PMNJvKT?=
 =?us-ascii?Q?ReHFFlFPsDfpwRbBAONa1FEWfnFVAJCCOlKc/HlziSsMwcCLSoTedGnCm+/B?=
 =?us-ascii?Q?WeQwQGonadLKCZJ8uW89w6X2PmZdUpNz5k7SMJs1omfWGpvaBnrvJbFRxbQS?=
 =?us-ascii?Q?X0A16HTA/ow1fAdrroXgk+EjiT04xwHnp1qkcOQPeu38ogi3WjYt8merl4A1?=
 =?us-ascii?Q?SpZo0LAN4eYA2DPEXse5p1TdqUCFpAAOwTD444dZYHGq8iMq84+YXVZB2Yz5?=
 =?us-ascii?Q?Rspy2e76kl7LrJgSfei8jpXNG+BtDlk2A3eDO2kL0d3KvjonGuOoqwwdUfjG?=
 =?us-ascii?Q?YG1VGrrsk4owPTwhM7yHw88=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	SiWiWLru+K+HbHdhMwbib0oY+BAMYkV2oFsO7d+ZyWM81CSRZuGza6v3RDfaUMUQtPRw9J6VS/CAdOAqe8yf9UCiEjsY15JBtsCunWWYTrACql/tft8cVZc8dzkOELHCly4zf0oWjhHOKt/TjXlCsKHVZG67tszKsidsCvLI89neYTvD/5EWfliFnVlMg3SGvtyqzMrUp/dlAypfgwJkTLRr+fgXYmgtyq9Jl6z8zPkVIfW66izw/YvB2435erevYJSEMe/8rXHCqkNHYWln3JSgviAdSphWV6EHhpdCUieGaqTeWYiFixFRjW7DuqzuVKbCZtxEozq6eQ7Yvm4vS+y0cYJuBBTXx/AtYwWz34xYXAeM3ddGrvTqijNWaZU897Q7CuCP6audKQFZ9T8Yib+/fpmOnYI889Z2WGg1nQkJYOQXD9F4F6Id0MRAH3PIA62Btve1QpRzud/GjP07duUiv6beveLrwZTrHS/Fw32w4eflI78QwaGAeS1sKK3T99xKLuPy1xQiHuaV+h1waScUlet898qVwiCPZGOAsk/mYYS9jyR1nj0ohNF4/feyVqGryUKBcd+egoDBIbh7Je4uBi6+dK9JhBLCSt+QXQU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8205936e-3d8c-4830-264d-08dc87231ae2
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 18:53:22.5718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6QXiWF0iZtDb7cGI5GYCOIpiUZmXhSkGhwPwSgLlBCzUOzcL0WGu7eBHEVWwt9XrzXW86HJsgcRgLkZHRtUuvdfEa2+9L6q4ycpRVzT90hI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_11,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070138
X-Proofpoint-ORIG-GUID: iMfofkIRx9jhm6tGWk7hDfqzHcNiBV6L
X-Proofpoint-GUID: iMfofkIRx9jhm6tGWk7hDfqzHcNiBV6L

Knowing the store type of the maple state could be helpful for debugging.
Have mas_dump() print mas->store_type.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index a955316b6745..91b18eef81e1 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -7731,6 +7731,45 @@ void mas_dump(const struct ma_state *mas)
 		break;
 	}
 
+	pr_err("Store Type: ");
+	switch (mas->store_type) {
+	case wr_invalid:
+		pr_err("invalid store type\n");
+		break;
+	case wr_new_root:
+		pr_err("new_root\n");
+		break;
+	case wr_store_root:
+		pr_err("store_root\n");
+		break;
+	case wr_exact_fit:
+		pr_err("exact_fit\n");
+		break;
+	case wr_split_store:
+		pr_err("split_store\n");
+		break;
+	case wr_slot_store:
+		pr_err("slot_store\n");
+		break;
+	case wr_append:
+		pr_err("append\n");
+		break;
+	case wr_node_store:
+		pr_err("node_store\n");
+		break;
+	case wr_spanning_store:
+		pr_err("spanning_store\n");
+		break;
+	case wr_rebalance:
+		pr_err("rebalance\n");
+		break;
+	case wr_bnode:
+		pr_err("write_bnode\n");
+		break;
+
+	}
+
+
 	pr_err("[%u/%u] index=%lx last=%lx\n", mas->offset, mas->end,
 	       mas->index, mas->last);
 	pr_err("     min=%lx max=%lx alloc=%p, depth=%u, flags=%x\n",
-- 
2.45.2


