Return-Path: <linux-kernel+bounces-201190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7AC8FBAC0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F3CD1F22199
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E8414C5BF;
	Tue,  4 Jun 2024 17:42:35 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDD714B96B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 17:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522954; cv=fail; b=BO/JMJvMpiV/ZiKVftZX2Kg1EfxbfhwosfpL44XkVa9r8nITRs7tFqTBVyAGJk5Y/Ns8PH9D2glHxo91Yl+zAWS5QMapVBh1wr5u3gE6KfFp4HkjHzQH91IXyGGkxHCVENy8MbGITR7CcTIxdB157C/v8sVNdAOaDhacwyu1Zpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522954; c=relaxed/simple;
	bh=HB7Sh1PeiJALq2jKcRlvwqE7ckLZhm3dW5Vb5poabfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hkK+j4LaClYA7sv4xJSXWZLg/d27TtAmvxV+dGpA6lnHL/nqzI6NugKB6E+GSwGMXEPsMHbiFW/7XB3D3EykbCO7fVNGi6IUBu4xrViVfpuOP5/kERTUcdCGlqYGHGCbPKe/XzfSEfytTNiU8dwijkjcr9+nzI2fdtc59kvgeUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454BnHAU028058;
	Tue, 4 Jun 2024 17:42:09 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DhpxPtaHCdDpGoM+1JKTkz/eDuE9n6lt2SUfsNJBwVt4=3D;_b?=
 =?UTF-8?Q?=3Dh4l5LtgfYZj5B5hLfTjcutms/80uCorByqv76kE93qFfsjTK4NLGfvcExmtf?=
 =?UTF-8?Q?yS8LiAo/_qJrL+WY28iNVjIhROEg0hqXXjUot13w9xkphB1SZtdYQKpI5RA8PXb?=
 =?UTF-8?Q?FLOqZ/LRWSB0FZ_2XDsZuvIY2vzVArB69lra+A8VN9UPJIIK2U4/b6NjqrM+t1C?=
 =?UTF-8?Q?olB5/wugUxZuoueVK+Bn_LtIzLem8dkPbt1Sv54S8b9h+JVzVnLtW0wL23rZQqo?=
 =?UTF-8?Q?TXpuAiHBE1DJhw7EYeMaMJMmIg_2a16T/GmpRWXwTIZ+JiNq8E/9pC59jlfhTFQ?=
 =?UTF-8?Q?iVj1WWVY52Tc15V0yJVZfsGq4QvERyhr_MQ=3D=3D_?=
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv58dj9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:42:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454HNoQi025242;
	Tue, 4 Jun 2024 17:42:07 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrt8xx21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:42:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LknQQZaBI1mNucTss9YmFc0h4gqVrCZkL3TU/5TLSDe+0mD4t3R9k6sji9gNyYiMMo9lidG2m7Ny803saGZAZH7CKZP+IwosxmoFpVZ2y9sveGzkDxjb+7mM6zawcxpAu5AaMG6SP6V7IstOKTJ/OO1kqZxlv923NayxeMVyA21RQv/cOVjBehyFxQAEOEEhOVtPsZwqLsdbkv7HUwGzNcVUpK6fDWPz8rW1U5+T2IUQACsBulkaZTJQrg5YlulGEVmuvhV9VVjpGe5bTRPEkbmizSQmcVwy11MA7kITlagq1lM8byEJ7qUg7TDHB6c4S20DxQKqJCHffT6O5i+Rdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpxPtaHCdDpGoM+1JKTkz/eDuE9n6lt2SUfsNJBwVt4=;
 b=kIDR02RlnWuvRgpZKE1IRoYsKt58YP+LRmNRuDnSnJP5Po/DMu1Y1wYdhgbiQsL6zw57YLTdEiyDWqrQAxwF1LIO2hQ/sTT1e94leXQdLqiPe1/Y/A5VMuGHZjQYFZArXaRisMrr0lItWOzaVZX86nzOAgQjRrBKZ9dk+c6FKBv3+TLlbSGaq+VBSaEZeEScnDbGh3WXJ27ddPXoJ53d0FQyN4xuPV2e3KPL+/Pr4+nDy+B/hu/yLaMsKfojV9AC36+GO5epcPoJatf3y6nAdynp5zxsswTun/6Us9kK99paK7v5soVp7OFnArpqyGePNIFpkS0sIE2YZxxKx+CLRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpxPtaHCdDpGoM+1JKTkz/eDuE9n6lt2SUfsNJBwVt4=;
 b=ax6mLaWgDp84sIGjyVuypjWaD8Xo3ca3IQDcLly6DF8uSTTS0QGnb6ibaaXYLsAjWKS9FHM6OgtzHfaacDFs1yb494pLEC4OA3i45RR0idOty6ZFgLnMOBMIj+vTiUIgJZ9nYepqD05csHRqKx9eDdFb0uYMGhqhjIa3Dqln+c0=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SA1PR10MB7593.namprd10.prod.outlook.com (2603:10b6:806:385::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Tue, 4 Jun
 2024 17:42:03 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 17:42:03 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        zhangpeng.00@bytedance.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 05/18] maple_tree: set store type in mas_store_prealloc()
Date: Tue,  4 Jun 2024 10:41:32 -0700
Message-ID: <20240604174145.563900-6-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
References: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::39) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SA1PR10MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: 342384cc-040a-43fb-e110-08dc84bda522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?8Gea9MI95ITbr+/FvqHwP310XO2SmTZRJSj5hASsrZlhEgcksVmpP13nP8lU?=
 =?us-ascii?Q?G0HRy/O9vIhEKu9Gg8ry+3kC4dYyzWeM2/j6/MQCqxSuxgkHWfoITPaDUagB?=
 =?us-ascii?Q?t39phlGqSpsOvsK+ZASMGSDyaelfR5tl21OxDW8OT0Iupoa1n8biryCEQ3Y9?=
 =?us-ascii?Q?n68HOSWWtYNdSFrsU1N2cp3MC+c007ox1d2KyOtZI8K9BLHjxnZ9YX++/LPk?=
 =?us-ascii?Q?PHb6LJ7xLQb0JTseREI/CgFuohOFC5f43kgycQqSrXhxR6kC+fLH2K4GMeH/?=
 =?us-ascii?Q?y5C7/Rz6OTL6Tnevny+FRieyTVoj49H8xJjYK7UeAfm85mfflAw26JH/aDgp?=
 =?us-ascii?Q?ATTrAxjBI2YzuwvcXGQY2xpxD3DvdNDdBjmmRPe6no3IWzuDufcMZsdlxuhS?=
 =?us-ascii?Q?9vqFduMco7sFlqre6IFcE/OLrptePHYybsQNcWCZIbjI/aXq+BAIf6sqwH8z?=
 =?us-ascii?Q?8Ax1Ufm0zUgU7m5LPYZQ/NMDGmGSQksFPtqODLMyw38I0xJ2RtpOofS3VtnK?=
 =?us-ascii?Q?h27KVuhL2bP/eL5j9n44Tdgy52S8mDoWYWkxzXd3sMydDKYnFDQGgZx+Blxi?=
 =?us-ascii?Q?gkWY82sUqT3jXNbqrvoyxVlGJSKRrQ9X9vwbrl6ig/OiCpSscacjc68Am07f?=
 =?us-ascii?Q?v8fesmXt3W33/oQQ3albkdo2NO8DzCuW3cLpV5mKITkB3NMZfG7eykZczM5c?=
 =?us-ascii?Q?RQK1JB8yPBNpUiXxBbk0OBdVfG0Ft4OXgVPRA39Ib86s6DHdV1jl/n0ICqeA?=
 =?us-ascii?Q?MOd4/P9RG24iSGHd8QY8gT9TPH4QHsC5s51+9PkvSVxSf4Ui5NrLD1zRdHDO?=
 =?us-ascii?Q?r+BqytNtJOI58yOzPFvWHBvqPIhGa15tM7JEIMGTtp7DaCMrL+vC3jgdFf5+?=
 =?us-ascii?Q?pDaw8xn/Jvxu44jenxL1UIFHhEYg0692uZLzPnhOr19slDRiskI2K9YqX5rR?=
 =?us-ascii?Q?oDdyIyWAvSpm/PsepNdcUo1AnryNv6sQrWxIHQJy8+K43S25iqbsmy/lFjoD?=
 =?us-ascii?Q?DxZAvj46Ihal4xs2dl6oA5Po+jpdiDajINZqNwni7sVCd43+ZgCWLcZYF7Be?=
 =?us-ascii?Q?rD6YTuAy5CiR6/dtMMOUxYlLmauyK6SssZS+Yzmj9F2xtTYUhZ5KAMLy6s/a?=
 =?us-ascii?Q?XLvZu4qb/v/oBf7k3nZKU62GxEJQzIbSUrsU6FLc47IHA8bvlZZWaDeSb747?=
 =?us-ascii?Q?LZvkDyfEWIeHzYgFPbrF3xIUjnf26QFYafp23hn5Gc8O2YiA+fJEd/g8POwJ?=
 =?us-ascii?Q?1P7FU4MPDn985mo0sVduYfibNHydPGMcVF9o4xJR5Q=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4fXeiz7DXBr9HArSAusYXbeTFeiZPLkWam0K6Jqjw9GdD+b6NQgUapvuIOkO?=
 =?us-ascii?Q?/0vJwn4Uoo4x1dejQLPNDAzIXYduD6YnblBfRAz1czZjM6VNLIYM/rQVFXBL?=
 =?us-ascii?Q?/r/k7QpohzlbF1Db/8qIXTiGhDgQ7Z+ktMT5ld44kZvgR1MUTCFK9vcwH/9y?=
 =?us-ascii?Q?2K3ftQoxcbRUueG+f78ryCOoieIVV4DijFhBwuGgRu2TvEnS9CrKPK3ElR3l?=
 =?us-ascii?Q?lgumCvieqHeS2Q99NnroBU2QQWvTgnpKKP8iv6wDA2Zimyq051phs6MeMup4?=
 =?us-ascii?Q?7mbwQbQMNGBp6GElwioIgixg1orkh7w5N3b+bY5SCShIdZeQn3BdKukjQDMN?=
 =?us-ascii?Q?JQ5hEQteQCenJHsc1S6rj8SubhCf/yAXcM9TooxncHisSgLu3oxxHqv6GX7n?=
 =?us-ascii?Q?uT70A9HpFdWKFxmwclK5QqU3whpyhPDQhe4l9z6TO1t/aprBXLtMvwxL99ij?=
 =?us-ascii?Q?1TD75ZxI9RZmeddiYTgPjDHA8jZtJBqoPhyUKn9jgej1YyGkzLPZoXf7DSE6?=
 =?us-ascii?Q?6ZGeiNvPEXT59w4WmwVPRVFUTQ4lMB+QvdMS8MxUyty2WL6R0239fOnxyqBo?=
 =?us-ascii?Q?KuoIbVF58FYwafJH6wvp3skAbxfrwWZzvu9bFY77bHVHP2UVkGTudvGg02tS?=
 =?us-ascii?Q?UEWIaCSO16bIX0lV6ipm8zrqvKbx3Mt0BvYGQT+RPeMMeF9wpVcE3guzKDfd?=
 =?us-ascii?Q?TPByhaCV/K+6CEMuxQI2xfgSqL9mubqsESvRW3gpza+1mBP4AdCB8R5t4vdK?=
 =?us-ascii?Q?ITj0XQHwupf2i3ysmq3fUVxLNWc4xetIiZ7u5i86OGxX6H4iWXN2r7ol1Pa7?=
 =?us-ascii?Q?/GW7CFUQ6GLf1kilp1ryxRlg8LAgTdW9r0aYErYYU94IiMSdackf4FuLpl4r?=
 =?us-ascii?Q?/iLGLTTCLU3IFx7U7G2b9bA79W2cBxN9ONNTk8YA/Srf08sLCJJ8wY+506Jy?=
 =?us-ascii?Q?LZYA0CxsY5jx2wjJxaDjPDpiVWKP++SAgyjOnw1Bm1SVA9Cuh3lzI8hh5Uiv?=
 =?us-ascii?Q?RwJ0rOu8vaoFP+j5CwLMUKV4t1VPD6nmuBYduU11t29jmgU2anDwoX8SfaAp?=
 =?us-ascii?Q?PoMnjA05uuwJEzJPQALiuSFeq3j4/iR0PKJomJDXnghLitG0ba8gZn9Qu5Lk?=
 =?us-ascii?Q?0smlrZA9BTH4RwpSGMNrDOCCRtggwJdZB9NhOEoCY0b6fAPA9auCs49ZQmX1?=
 =?us-ascii?Q?P5nZ7mSHrCYD4o0RhcmEozyU4Shl2kZa80fkro0JYpq6kcOlaJcoICgvJ8ML?=
 =?us-ascii?Q?Veiq+42nDVqwrKgzuhyKn6HGwdyEiPiflfNg23CSiEgNFKv/8jypTX4od8tx?=
 =?us-ascii?Q?pN0BrIK2qi7kR0K8CszMRvnkpDRKvsA8A+PRnnKkGvJPsIFi46NoiRiO2oZ0?=
 =?us-ascii?Q?yXTBem3NIRsXWSp2YbdxKbf5Cg3Bo63RUKFfq0uoc4FbLf0edbBFQ6aHs/xD?=
 =?us-ascii?Q?51uziPVwCoWRBoswaxKpW5O2DIq+5oFlPYvWlGyf4UaNIzejjtTEyaKwLG7G?=
 =?us-ascii?Q?1KZvtT17hZKwHdMP/gn562swLYTyuxNRkuUs7DQGYou+grmWfUaqhMggK4l8?=
 =?us-ascii?Q?eWI1mK9Vq0CcoyacU8AzUeMn9kirH1I+0r9Mjp+1JKlflIDT8qd6GERWzj7/?=
 =?us-ascii?Q?iejkBrVWeXftP+/6PjDcmxI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	x+rydlpwwFuEtsfOmCJOe7lv0aRto7mmUPhDYtz8JCE1HQ2Tj28y3UXnNDCorzqgqv59gRDjL32N6S8MRZyaK5bdktGxnO5babkwrX1LtyDq6XDende0VVSGAcLB/x4tgVrXTjm1kJb76mYQDvX6RLl5BgaB1Fh80qt16yQ3KS4ttjRkIXFoRzMdStn0ohb0OkcrCVSWvgkUVoO1dAQTujRuMjxCrqBZQ3ynnlxupQWYzCFThQzVak563fLdxbXhD09IbUVtrdZm5qRG0V2iwaZBVpsV6JMH5oKxxhsUVr01/P7QitMmS9maPxEQQ/luG3Y0ZjSiV75oX6j7txQGI7g9zCJ67wb4z7GI/xdDmfmXeiLKSV0FcXj5nJIWRLrickn9VlGVudAyGJhYET0rZzngYFeig+9dBNsJos3YjSXiZ7w2Dda2SHitG0AhGReW71sEUwZsmljRfaWkJro8P2PfrajX/G/CSiWWcbboyzky0mDhjy8KFknvUQqqGSbMhlrppImgUvr0D6UX6xhlp/WQ5jIgb4mRfaGy3DcVaWBgOYwTAG8E5cs3oLBg8FSjrfoTn+KSZ3NDxokYrFEDOySdXxFXuImVrbGiZ2DDIu8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 342384cc-040a-43fb-e110-08dc84bda522
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 17:42:03.5154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dz27FlE4T0QzQUNTukT0jWSiwi5nA0lmssbbnwSeoWkXg0e0IR9mQLouLT9g2hMcDlEug4Fq0E5bHoxg7N4PMoOMQ2BcHpWwfOYHkBxZzzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7593
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040142
X-Proofpoint-ORIG-GUID: 7jk2jXqsA4sJBvNYoJnZlLdJraKQEqHl
X-Proofpoint-GUID: 7jk2jXqsA4sJBvNYoJnZlLdJraKQEqHl

Set the store type in mas_store_prealloc(). This is needed as
mas_wr_store_entry() will be modified to read the store type to make a
decision about how to complete the store.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index b37fa8690558..3780d4bb0415 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5631,7 +5631,8 @@ void mas_store_prealloc(struct ma_state *mas, void *entry)
 {
 	MA_WR_STATE(wr_mas, mas, entry);
 
-	mas_wr_store_setup(&wr_mas);
+	mas_wr_prealloc_setup(&wr_mas);
+	mas_wr_store_type(&wr_mas);
 	trace_ma_write(__func__, mas, 0, entry);
 	mas_wr_store_entry(&wr_mas);
 	MAS_WR_BUG_ON(&wr_mas, mas_is_err(mas));
-- 
2.45.1


