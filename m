Return-Path: <linux-kernel+bounces-206622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4450900C19
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B414288163
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB89915E5AB;
	Fri,  7 Jun 2024 18:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lCCfvV8E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uuDZQpHK"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC7814A4C3
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717786434; cv=fail; b=IOld60fdASwlsllQMsUcCu7nTX0G7HV9IUh2kGTlxy0D17E0VDQF2ELtbiVtoFnqtaDX0eASebloPZYuk0zb4EEXs2sCZFSdWmSVWsW6cstHIKrSHaFjkIe6UYQLsJQatLKrPPhO2cIDO9iFRZrYKaj718Ydg+6PWtSEnDIsK4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717786434; c=relaxed/simple;
	bh=jEvta4pFfQcXTPGbGH/LyIsgvTLScDY6hMP9nCRwmdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TjavLWAkA6OVEzcipxHYmOMNIiQnX77Yp6cWlre2xYUz1ZgA4JD0Rf0vcflHFg+fAqUXXok9ZWRSqsKhG0CojljVa9x0Sx0Ev1oXbwqXKY/u2ahjNCqX+FOA1xNn+pvIa87wDwu7UCjmnqijULkoZ5P83YP/rVrETb7cuk3XCak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lCCfvV8E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uuDZQpHK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457CufGe021449;
	Fri, 7 Jun 2024 18:53:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=UJaoN99ei7MhPXDYFpeA/QQw4oOI9Gga2dfK1ADbeKQ=;
 b=lCCfvV8EQWct+MVgNxH7823G05w2FDp5MZ1ojOjML6qOb3H+aVj8l+ujCPl41Mo2lTIw
 GRAYBpMm8etzxcKbrKZmwlzTQ3iddE4/wWHVQxffXBucwdutCdMMRSX+F1yoHLq82vIZ
 uadaimxqS4/sIkrPgg6R9BQVY1GdCY2LiG4mYIOtf+xY896WctqQglncnYSFz/Tzr/Ak
 +yi3hM11YSQLpsTwGXDI7314QWXJEPI+bWGnvf+XD5cdffKh1Yy+3n0a/G0rLFNZeeV8
 PJwSTpq+K93yvWh3kXtfJgxYHSx78p68DaNGaU51Nqpa/+QV3jyzh52EKU8rYUKuLIQH EA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbrhea3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 18:53:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457ICR4E023938;
	Fri, 7 Jun 2024 18:53:40 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrr2k7tv-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 18:53:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5yTe6dy00VYUQJHk7tXi9O+kozuwAiBVjk6GIXKAUr0uGJ6p21j8bbuuN4qbeqnUpTF1r8iodQld6KSJyD25PGCKkagOiFh1CqkSmYrOdItzK81dcNiPxTFKLin7HIxxQzTiMiDxx0Ifckv5v6TLxIHsAbaqKgKNLtNtk1HvmZUX4IMjcO8XhFV2XTM2lnHFTL1pBKvR0sfaMNw5wzWJ9N0I8YpO6EuCdffUVhc341mqAGWwNB2rF2XuGKG41Q+zR3c55RrLouiGjvhBQKAWMgnGr8K52oXn9/Ggawqk9Z5j/5+y+wwLFdQzq1ibyFB7DQl2VC6UkQVN7pMJ0rwZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJaoN99ei7MhPXDYFpeA/QQw4oOI9Gga2dfK1ADbeKQ=;
 b=et8UaU6XZSNWM4FksdS8QeTwXawIrHxUGf+0XwgNE1XISpKQYSGhzJUMUWPI3Wy1+V064/8LAEw0m3aPmoiqGhsOnXvbZY2wo6ZeJIRYVjcgIlDrj3oyDj+Lf5Ur4qpnV8zu0ATyyDtmJuxFCKRwmDhp5tHrSuzFRXfUyZrJ6TKeoeuOVnwRutYj0r+gTRQBObI6QU9GMg07KqGkm47IHM2kLwKoJTsbndHQN3bhYAg+358IK/VFGvM/QBCfNj307nQsigqIzu0HVR9DSLKof/fyvOkKBvQO1z+pGoGpYuPaISWG8tSezAr+dbPiElW7lnjPAlGAzYtElpxHDUK2MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJaoN99ei7MhPXDYFpeA/QQw4oOI9Gga2dfK1ADbeKQ=;
 b=uuDZQpHKByuw4qoZWLgKz0kJaQlqWNrilM3tdq9/dG1LwUz8nYinank7Rbza5nz9lgikTsUYKoPBkchaP4ccYhE0+ZAM37T0mKidrjvRDnXAfGWoUKn0SmgeZwYS3hxEvpvXsy6+c1Y5fTHC43mnSJNq9PdFRqRgKSXrG1fGxBk=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SJ0PR10MB5629.namprd10.prod.outlook.com (2603:10b6:a03:3e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Fri, 7 Jun
 2024 18:53:20 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.034; Fri, 7 Jun 2024
 18:53:19 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 07/16] maple_tree: use mas_store_gfp() in mtree_store_range()
Date: Fri,  7 Jun 2024 11:52:48 -0700
Message-ID: <20240607185257.963768-8-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
References: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0014.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::27) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SJ0PR10MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cb72308-3c33-405e-e936-08dc8723194c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?XX3EkMZ9PYiTn3KCtDMynu5l+HZGjrIK8MYBjEsCdSko4bG4wAfPNDi/PXqJ?=
 =?us-ascii?Q?CAC6bfK+ay7Z7PRjLKGKpHJSi4WOcCxfXaltlChmEjPYX3mKmd1xFDVn10pH?=
 =?us-ascii?Q?m7jzCvus5c5CjZCshPHetKugEkbiqUiSxRvTBXQhb9P1i32l9tdmwnTQ9yea?=
 =?us-ascii?Q?9pHFPmKiIz3czkt5T0ZgQGhmp71BntogyNLHkNwDuU+Nl0gYaLZaE5nTwB33?=
 =?us-ascii?Q?A81s9zrjkRBInJfJDlvKPShF+QCoz+gsYZNNDs1S+yuAtbXxqGr7ksv83Vy9?=
 =?us-ascii?Q?4je2UmCqNjMLFU/FAJs/XChz7SmgDHQ3d6AfUT7JxqPIcVPlcUB1UbM4GJDa?=
 =?us-ascii?Q?tbtATIVQHdQaxGY64ied7IjHjak+K/hzB8VnvZrMK5N8jfgFxdwhfvD1FmHO?=
 =?us-ascii?Q?qAPCHZW93X24qKsF98HFVG+MCWoFM2KXoiHBUiu6A/8/nn/rV/gk3KZWlTLZ?=
 =?us-ascii?Q?HtlTCorEnj11fWZVMvHM+L5XYIOasPttZkDNX10anmkpQwd0k/lsxKRH5mho?=
 =?us-ascii?Q?oPzZ7y0fRuVBtatJ+X5H0R8/ZuZADSwZ+9mEDaEMxwICQgaH8d+XNg1sV4/L?=
 =?us-ascii?Q?8L+Hf9rjWnP2pI+kMPRsG84KvAMWERCLx4LokBEggLAMIU/tFLQZNOubXIlj?=
 =?us-ascii?Q?wNkvSJeYHnNWD5aOwjSCX0ABWvKvPXF+zymxOLo9oqOkMCiJc8U5qWtF8VUh?=
 =?us-ascii?Q?EOE+OqmOQeTZNhEFkPWT79dutjHpnomZ4W4gG3OfU+iEYi69y0nO3y9rsLrq?=
 =?us-ascii?Q?Ah/KEJyJI4tMVHzIxDEf2Zhax7WIxugHCph/io9bV0OiE2hR0XIcJsOgData?=
 =?us-ascii?Q?WSMZTthHGwzwH6ORe9vl7CZjicfPGHoWrclyKFztB+lUlymW/E3x3rK/xSZn?=
 =?us-ascii?Q?jv8dnbBhx2jYZ6Ezn8B+OLmHoCEE1646by8Rl+SVjlCNYaorn2beTIiJj1DF?=
 =?us-ascii?Q?J8hczJiE+TbbL87c8zoBzwuF7ff8xXRV58En2SvQDMDT9366/tKjecDnhaeP?=
 =?us-ascii?Q?6npy3IWOgmFJfUxhL3AnU1iV2RMeA5L+dzTjR22dw21dN6OfE/2EPkJgQ1hD?=
 =?us-ascii?Q?Bkb8evT7pPgvRlSy9ts8vs4Jhavui2QvwCH8V2CQocx2GDGdBPWT2Q96h2da?=
 =?us-ascii?Q?l3U4NlyaqEkxwSmoRsw358PtDuTdwBU7pyHsWJ8F5blsmDsEi47MnGcgsTgB?=
 =?us-ascii?Q?GoNFbtGjYsB4FrRQ4+iAlFk6iou+7LpgMfZEhm8jRK91RO97mFkjzew4b2HF?=
 =?us-ascii?Q?8W6IgIV7XbfMTAh6yQirnTX869OoAX7cedGIKquwkGsFCxBjm8S5kJyBqKdj?=
 =?us-ascii?Q?lV2HsBD65HRReHwCi7ofA72K?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vjhYU2yAcXz47qIIuFAG/FHohrjT+E0e1ayZFVd7Pcy98/HME73djnD+Bel5?=
 =?us-ascii?Q?P0Kw8JllhZbh2LvQ61VzRuJQIH2x4U+QC9QB2IXNyp0yisPhWNVQ97qsmWza?=
 =?us-ascii?Q?5wU/VwW4ORZTVC/AaBDcssjL1PBLfBt+GnMFdLrC9yOFV+2497KodtV/tMBH?=
 =?us-ascii?Q?uCoyRWBOEm81w2mkA9TweL6G69db3gkIibP3U2ZZuRTOZFFuehobXAM87CRE?=
 =?us-ascii?Q?/IiaOYBvPRNW3YFF1d1s1Hc3Mo9MQSKn/qwIj0qBRZB72R/98HPf/aaMhZoL?=
 =?us-ascii?Q?zgv+nh2ZPx9eJTYzmlQUmjchndVoWfyyshFNjAl3EaZ1AublPBIYJ4c+xcYR?=
 =?us-ascii?Q?HQk55BWqPBrpFlOKjV3xwxsUJ9F65ZuX8AtKvpRHfJwfevXKSdS9Q9JpgAwR?=
 =?us-ascii?Q?ZcPkyzZ730hZjDRmZ+Rg0tFPcFzkkbQsnWW7eKf1zd/UN2qzTAKizF54/WV8?=
 =?us-ascii?Q?e41Ka3sKbqizqcCnsKv45EyTNpgodKqasmuNA08+P6j/Z3JiVhAiMWAV7vkB?=
 =?us-ascii?Q?z0ukQRXi7T4XBy9jQZVX5xd84vaNXHvaJMPkZaB7noHD3XsXsGljWikcknYA?=
 =?us-ascii?Q?EYAsI1wA3qbj+99esjrDuhXOWYeqXPpHJjH+yVKm1o593D+WdHOIet0AQofO?=
 =?us-ascii?Q?yYWaTfp+umW1UmB8Opel5A7vV3ru50jtIybnTea++tElTW0JXdBAhcsvPZZR?=
 =?us-ascii?Q?AK1v9AYEfyL6rTaqMFdvg95fEA4+8wzOvOQYEaXnN+2mKSpCBBw2BHt9rDfP?=
 =?us-ascii?Q?f7mOek3E44qIs42sy8MZvYbC3krBL/BFJuOvScDBlT3RnbFMocwPk2nqRJr2?=
 =?us-ascii?Q?MWSSR6izk1vzCNsifq2rSsQfeQFA6lL7k/6aL51OMug2T70Cy8IPsfxZG2Ep?=
 =?us-ascii?Q?SrQEWNzR/f+B6/g3qD1s3ql0aE9ryJ0d84KItW1LlVrd4QXdtNkiv4SAvuM3?=
 =?us-ascii?Q?5s2iDBthtJJxOI3oe/ich4AP3SrWFLs86eUjDmgoFlJ5SVSTykJYqVpzx/jF?=
 =?us-ascii?Q?9Qso5qY9iIwfuv1n+El5Ny43ts713rrTZ3SdiJODEy9S983kt1J2tKzegylx?=
 =?us-ascii?Q?D2AL65hrisC1b/zJo95Sb4i8QTVccSh1oH/Kp8BMM3ZGwE5TtkyTftjQQZic?=
 =?us-ascii?Q?o/FSGhbNu7HyWE6DSG0qdvDQfZgrBQAfSAFBLYQ1o2ubRD6Kfa/fTJ8hS0hj?=
 =?us-ascii?Q?Tjnel8qvIw47/LmKWZ42Fqht2HlpvFCg82BS22zpg0Tex8+p0r17pQVdzo8/?=
 =?us-ascii?Q?lzCPhm9a3q49jGpWJebbyJbLSeOaocyhF+feLLWe8YtXZTXOhhaxkTWfo3Ip?=
 =?us-ascii?Q?76LX2ek/Pw2kbxvtkHdID57sp+2Z7aKiNT87mJpvf1Lv6iWmTsqjt/zRC/gP?=
 =?us-ascii?Q?OUNS2/RAKQ96S2VybwdMSmF8+cD76XUFGmUh6KXdfTlltzLGmr0CwZJk5Z1U?=
 =?us-ascii?Q?IX+WEceNs5j7wGupb5MA6hVg036JyfYrpG1uQvU+0z8DiXizHYwZE6I0xryk?=
 =?us-ascii?Q?A0g3A89kGafxwvqv2MfL7YUlmHhHywU0frbWhJp1xZZPFIVcfItkPitaOoHQ?=
 =?us-ascii?Q?GeHO9bQ2f8eRQCw5IcCekuvTOA2aY1B72y1UZX5Su3WNgDCfLxK3+HqgaVUr?=
 =?us-ascii?Q?TfypB/5ma7Ncdl7VPJx5b+g=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5FooOIwhayQw3KtO3tZwwZwN8nLFWq8tf4R4MZ9z7vPoKOsP03VGxsplCI1BMZqRRMNq8lgd+yrXetnbBB/pvBIP+suEo5m4Tz7c46khFrM19lJr5heDGF61JWb8Rrz+iXqbuwrtyEAU+3+4xPcfW3J9RIrK/cdQ9q9YTcTdSmAToBduEnbPhHr9QmvXJ0q2zuyUqrklt7dcfSlGocsOL5dl7xV7wmCLhsxViGvQBvjF1WRNggypOLRSkbo/f4gq4lCRmBiJG0bcCVcbx6XH0Migu/pUUu9aXiGdhoIYlZ81ywMjIxldhTy0UJ6jqAF/mn5ZP5FnN0aZWT3270VurV+QB9hRMrfPAU1mPaAuRWkKikRtP3lpY4NlaRfmwTJcEZ6YX5Ykpijni4EYfLG1ogff3/yAGI9+GBkzwO/JFhOkC/3Hn2B0aFzEiRpRCmdA0mu/WZRjhasGhEU/cJ4JOBk6aUj31Ozk02i7TpkLeEDEGuJ1uRZNjM6BMSLN47HlT2k0UaBPGwHXiGpgh3MIg5HUH9WTQZVnnaolnkXFRDVXbsV/na1MUscNcx/gqpn77shmw/6FeRaRcR/Ci/iELjb8NWyObjbnSKG8E5PHFT0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb72308-3c33-405e-e936-08dc8723194c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 18:53:19.8887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4tPqoPxWH465rV2OI/3hBgJZTjX2hmjJUxV4tJb8ypyAO9ufFR/vh8Aa+0rJaRZXq3revQnMmbroMXPCZA9zQegAqw63PfU3Lb+rNOdKt/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_11,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070138
X-Proofpoint-GUID: 38jTbIEemBuoqz-hQ_1EJkGhInPKsRSL
X-Proofpoint-ORIG-GUID: 38jTbIEemBuoqz-hQ_1EJkGhInPKsRSL

Refactor mtree_store_range() to use mas_store_gfp() which will abstract
the store, memory allocation, and error handling.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index bf309b7515e7..a955316b6745 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6459,7 +6459,6 @@ int mtree_store_range(struct maple_tree *mt, unsigned long index,
 		unsigned long last, void *entry, gfp_t gfp)
 {
 	MA_STATE(mas, mt, index, last);
-	MA_WR_STATE(wr_mas, &mas, entry);
 	int ret = 0;
 
 	trace_ma_write(__func__, &mas, 0, entry);
@@ -6470,17 +6469,10 @@ int mtree_store_range(struct maple_tree *mt, unsigned long index,
 		return -EINVAL;
 
 	mtree_lock(mt);
-retry:
-	mas_wr_store_entry(&wr_mas);
-	if (mas_nomem(&mas, gfp))
-		goto retry;
-
+	ret = mas_store_gfp(&mas, entry, gfp);
+	MT_BUG_ON(mas.tree, mas.store_type == wr_invalid);
 	mtree_unlock(mt);
 
-	if (mas_is_err(&mas))
-		ret = xa_err(mas.node);
-
-	mas_destroy(&mas);
 	return ret;
 }
 EXPORT_SYMBOL(mtree_store_range);
-- 
2.45.2


