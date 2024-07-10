Return-Path: <linux-kernel+bounces-248173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 012DA92D917
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC59F289484
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D04919A86E;
	Wed, 10 Jul 2024 19:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jyF9I1Mj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dghHDPoV"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19E4199EA4
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720639441; cv=fail; b=jjVFi9c+ZTY8mVYgWZkCz73isiKQMa5LMqpTmLdqlUVyIadKbYDuydbsqZROaZn77R+jN/HVVCCI/uxe/6bWqRqQaSTJuwTdxLPY4gJmbtyV+0Rg0NTiSZ10kCXMvkG3r26ZEJISQzKUc7fylHL6b6naPT9IQMX1XRkBHaXXcck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720639441; c=relaxed/simple;
	bh=xlEjTrVKdPMgsbAfLZPthYkoUw80MjfxLWQq8ag1hy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PGuz1b5/XiGXa2C9w1uCGw36tjrMVntb8J9RSr0BloVs24xYX8gQLNYMMXaw4EKCWpS9n7cYGxt1qtCrezAp0pXNKbF4cwM+eNhywJyTwVWf8bQz1170TocRhaN71zRypmYI5w1hwUvapk8jWaVroyBGtMCfPO/XSaGGVrhX35k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jyF9I1Mj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dghHDPoV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AG1ac3012151;
	Wed, 10 Jul 2024 19:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=5uyJ/yQEOK6UxBQ0/FsfhFoC0HXOJMLs6pKNlOOdFCw=; b=
	jyF9I1Mj79jg8frDcIoWb8VdkxOJslQ5bysjbruEs7D1UvZ0sAVWY4tpWVbAIksO
	FwMypNUaHClWMAE/fzGXQjQIUbMtlO3GagzHiLZB80zDvVdR77oTQ5c6q6iC6b9D
	0Z4YDUqZU00+D3GtzetSLqKd7/y3SB0AWc25KIU6ICeUX+JTnBfZdWMH/Nd0B1Hr
	aehH3JImZpdHgs7z+Z/zVbeSU726LHv/BNdQQY70qct5bWXKzg4j8BkVQDdQTnpy
	tFBy1/XbaMw4RhUNvPC4bRnMlKlByu2k5VlfKcng1AkMWulvhnVFZHQ+lkiBRD7T
	+5OOyE6iM4Niu93r+Umgeg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 407emsyctr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46AIlfXu010839;
	Wed, 10 Jul 2024 19:23:43 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vv4s3w9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYm4BCVWA8Ab8vzB1YiuvzrZWzTDWZxXh4O+/cRGeqX4P6qw8W9QQRslCYM7kSueRwxzsfY2BS0aSwojUr5WAY0i47XHgIwp0SyFViyNuzCNvbXC1I+kruXwiXgkSYWEiwiPdg5HfO1zFR6F1pGOxH7Tsp2puR4elJpsYSoA92aWf5JrQ9t7YCoiNFrjBLxMceMJKzoPcj7BdG1tTYpcCcQ6NLW/VEfBcqHJEjeN3ovdXS79cpn4gq/ox3sL3PcR4sL9h1xUD74obm6///+NQrn3DDVMfRxfi0xCTcFURppBEUs7mGSgTZNs3pk/8nnE4h5EjOmvizqRz4MoL5TXfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uyJ/yQEOK6UxBQ0/FsfhFoC0HXOJMLs6pKNlOOdFCw=;
 b=ogoEAf5+klibMiPy/KMpQN3WtiJ5Gw8MlGzmBmbmNN1gzCLvG/gmgNVbrpZfEkVNlesu74/XGpWsJDh4iM/hEMgg1+FkWOIy76V6wcjDtaVVzFbzB+5uMqAUiIYU5vtfNhcmC3sil7oRCvTSOgp+g7M0E2kmE/fNAwG1GEYLIf9i2sRDw+jAvRCnRTQ9kJKs6rBTo6iWWn5Ypg2YRHMz8ldFMKq0qPobwlDaVERv2YCBKi1C2+lZwD0J+B9anRkR/0u7uGpHbvFXLr1UKbqyzkiz/ISOfrnXabj+L2THHd6IQ+2Ux01w9b/us/L3p6r+I6I7k2xQtgUo2YhREwmI+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uyJ/yQEOK6UxBQ0/FsfhFoC0HXOJMLs6pKNlOOdFCw=;
 b=dghHDPoVdHm9jIP6xj0alL/vvpPgLli2kkCACU1rKANK1rtRpliZcunIR9vNcAbFvO+J+Opw8EqGfGNsp7xQ0FP+TEolsPGivjuKRV1jb2Nn37Hc9TLBWOLW9s/mR0yysMFqGBZnjbGehkkLwZXE/PbkoLPioPGbu1xClNcxO/w=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH7PR10MB6106.namprd10.prod.outlook.com (2603:10b6:510:1fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 19:23:36 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 19:23:36 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v4 18/21] mm/mmap: Move can_modify_mm() check down the stack
Date: Wed, 10 Jul 2024 15:22:47 -0400
Message-ID: <20240710192250.4114783-19-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
References: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0114.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::31) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH7PR10MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ef1313c-d9cf-476e-ed46-08dca115cb65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?2JUdvlaHNf5IZ+Lq4byPvlnRGLVM2zLWy9j2qD5viYvcQve+o4yif2C8rLgV?=
 =?us-ascii?Q?ZVbIXzYWB0o8Srg1Fy3ZDG63t5i8xxqvgTFiZI6zbjOliMdnHI6x2JbkEvuY?=
 =?us-ascii?Q?l3j4fVaa9siXZ6EDE3lmhmV3UfsUmTWv6RfkU+DgG9RFpoBHkN8Lbyhvc/WG?=
 =?us-ascii?Q?gkE6SYRIUtEwzZdXTRC3xCvJkuCEDUk+RqOrHjP14N2871ySiaQ6er2Nzxw5?=
 =?us-ascii?Q?MgaDWqamdnvh9NzJrumZwgEWvIJ6dV+4WAg1BRr5/Gq0OvuryQjSuDwXzGmT?=
 =?us-ascii?Q?vlDUbOVQAV5Tu9s5GdAAOVsdlocaQm+hyGuXyyU3MRXcA2TOsV93pLyyx/0C?=
 =?us-ascii?Q?NX9uupZAL0eVke5hxA8ogMy8rbl8mPypoy1MYnra0e6ZIWgno2fG/TAyyNKN?=
 =?us-ascii?Q?YRpgv43k34lrp3CdW2jyG1zri/MLo2Y7YSn5bba9T1tjOX2OAXU3YTXg9X3Y?=
 =?us-ascii?Q?5967OL+ozBH+SqNb9uD0FRtLBX+zhUTzAcIX2oUwCR4MwNfmnRc1hoQs3F5/?=
 =?us-ascii?Q?8C74z6gwS1bQIuuxJ9stNQsWSFrWrwKGBIJyrjZtQ0sjl1NOFB1VlZ4cV3ft?=
 =?us-ascii?Q?AhWvubQSFvZbv06o4tqZ+9ZYtG6L3yyHfuS/V6YUWSR0++nxHQhQZEXB6dOE?=
 =?us-ascii?Q?9mKasb/1JK/LIDKV1AaB1FFrrM8z0YglztQth6efzZ8Acwp6ogLVTjQ/jLF1?=
 =?us-ascii?Q?+WKX0OTxUwuVj741409/pz092I90XEVI0s0iTDUQLznCwr4dlpJCEwHTANHd?=
 =?us-ascii?Q?3xuDr1AELtLRW/B3yPqgOO8Pze+A2GV4F6f5nLjNH7tMNnDzbMueCbdXVr1e?=
 =?us-ascii?Q?3SOuxqY7gOt3BxqUDV9lkmz/zgReclkq6WKFWLliBqX975Etrq2262y2u2ii?=
 =?us-ascii?Q?tm9/20C8Su97Xdu1vurn+bRJPT9c4KnPgFpl3ASvVoF/CjlqdEFWOC0RGbkA?=
 =?us-ascii?Q?KIzYjYjz8N6/JyOE3geDDXQ4lmLmz8oLBEyJNet6epz7LTJ0UOE0+m5rxXP4?=
 =?us-ascii?Q?zyS6etCIlxE7zHqQS6r7w0CcKjWE0YJkzVpqqCCMgIfrJpdDa8ojejLklggB?=
 =?us-ascii?Q?/BqknyBsi14S3u45Y5f04hv3hMX9ov1rYdSJM3VXucpaJYPCgHBLclaQ/UM7?=
 =?us-ascii?Q?oQzMzDOetdNVU9e//Sgr1k0k9fh8PytpHvkQ6P03oQLNxFOuSZFluRumpnPO?=
 =?us-ascii?Q?hi5h3oPo6eBf63EQs+EmzAyXBwraZPmWSW1gyVy4IRFIVDTc2VZuNnOvdD78?=
 =?us-ascii?Q?chGzF1hyUlnMzfxNUQKHdnwERNNBGWNjDehqMZ486FpC+xfgTXhP/ylwjN7a?=
 =?us-ascii?Q?lXTIk9uJyV5JIJfmBNVZHok5k4+tLS/IDWhuzxb39WcPpQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7wnc51zULSZvHxYANP2lfzy6BRrZFrlbZo0FvAnRme9f4BN0S+EIfAPDdnZl?=
 =?us-ascii?Q?mas1xIhTKI+bX9xQ06Tzh6w0/DTegyUsLyvRx2FeGh5soCpyycdMeMk5I3t8?=
 =?us-ascii?Q?OZnm1lL9p5yA264Dl76z9xAG2ZtkbbLMk2HsGFT42STilViaGwePmjfB7PJw?=
 =?us-ascii?Q?8n0kqMrpmhTxx1IH0MhE8C79zYkHHDx5J7PT66dvQOpVYCkNKIPZi4eezOgm?=
 =?us-ascii?Q?lglVFCFMWDdvzyXDLeH6TJewA/KGMlWAlnubDJhLP4ZepVvEXXWKZXPdBMTu?=
 =?us-ascii?Q?9gfvIoGOKzu7WlMw94T0XTsE76aJD086w5cp4U1/97nR7YU3Ez/5i7SyECSB?=
 =?us-ascii?Q?FEg2WBwFJ2JUNqVrtb4zOTAjp2wmsh4poTCYpo1P+GLyCDTXmWy0eC1RVUPG?=
 =?us-ascii?Q?Hg7ErLwACc2GMybCcd8AEFxVSVE6FFp30hzN5pMhPF3FLjSsn8Y5IoliAB2K?=
 =?us-ascii?Q?DOacpZuQ1fWiPReaJg7SKl0U5MD4O2QAW3wmg7QQmxLfh8jgA/yTtXBGe+ex?=
 =?us-ascii?Q?5aTPGydtKVVBKdQpg3fX30c5W3DRu1OOmCcInnSDe2Lc4HnvlMH4WzTJyusu?=
 =?us-ascii?Q?io4BPBLql+aSjHzkpgLfbsFbaupm8sXAVVvWUEVhtkEA3fKXzYljC/9RGqG4?=
 =?us-ascii?Q?5T1YXsTyjQHaWq61Uhede9/xcNRSYOabeoqbaJIdlNVvwUO+D5iv5H7kkXdA?=
 =?us-ascii?Q?Y5UodEzYeWDCUSZ4u6Kc/Bk+ePfrmvUpz2+2g+kOKTpIg60hSrnMhBcvYSUa?=
 =?us-ascii?Q?culdrRw1yFIc2xMxSZtvM6a2LartRo6m6H0iildO/Ft0pvJZSQPZhQf/2sc1?=
 =?us-ascii?Q?AjJED/VV9fokaGe9SDeDJrm+DYh/OxxBOSwDgW5O5QCPudyWCKmNYpTBYd9b?=
 =?us-ascii?Q?W1YA2msSdOvkWAE/eddTthfr3r6dbPxXGfjOlnKt9azWmmdIzZ2yRWfO68xt?=
 =?us-ascii?Q?6arjBzosKcmNM/VdL7vi/X36lHuiOsS5oqr6hDBJN3z/9+8bt2FSsBC0yZxz?=
 =?us-ascii?Q?nU0W9NR+ldeul515b1hCxCS3ROxmMwwuxwjsch7Jr6/w7A7JL0TadgfoOhlF?=
 =?us-ascii?Q?cXeQ8VXGCwFl1lUoVZRM8QMYOQuNTrkyz2IFJukiv5++Euk0QEwJ8vh3MAV3?=
 =?us-ascii?Q?evOya9LpBCCig6hg3VvYtICj66hEKIK7HAq6vf7MIyjqYYS2ihfYOGfQvwgE?=
 =?us-ascii?Q?MJut0JqUntNkjT69ET46Z8bC/rYIuepVxI8JagXxwo+rpgHOw/YAoaBlD/e/?=
 =?us-ascii?Q?Eog3xHFnnt+Cg0o0Xqw43Stb3YN/05f+IkxdsRkEKTl7hSQ9Rba5r9Hz+8zB?=
 =?us-ascii?Q?Dd+CrDMy4HFuLRJ2OShL7S66zU1sZTLWicbiqrYAH9LN14YzLaOrzVf0RXU3?=
 =?us-ascii?Q?Guigsh/nna1Sx9298pvXZBsnfO3rP8xIqEDwDTRlanw5Z0yN9es9lMK04Qho?=
 =?us-ascii?Q?GyPZ53XIH3/WrmSYtI5cuQUPXoC1D7/GOIdnOpcvxt2Ylk03BqgUbm43+8S4?=
 =?us-ascii?Q?0EmWzWWfmZET0EeHLd9g62EH01UJr/z+LRB8pReyeTAdOdU1fQPLPLpo8iXt?=
 =?us-ascii?Q?1M2nmz7XcKpwIz9PY3HmTqXT1s2PmC5sDxJOUV5GwwYEIjrTFzK4fPw2lBed?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RRH3ryhYmoFEF4Jn9EDnPMheRbChzy2uTW/xIzdzP2YpmEzThgU9EEIcwce6NvV+ANXJSiXUbFhYEjY7Kc3CRbYeeMgOMQOUckyw0daVUpcK+9m2Q0GbgM8sFcw0mG/Pouj5u5+PCxSxDu46S4dG4e/cexySftnfsZml9UsFuz4t4mV+BDOWcZJ2+C5+8oXtrYicS4Fti/vaYjKww7f1MO9ffreM/jfpxtjOzk4lTogDkSlq+U5w+T1mn/n1vbVIHDWOkmb6Wq6U8R4D4GPUX8DMIRZTNr+mpGExbq46f7Uais/bvVOSDVjqmnu9Pyq4YO9Fo78um7E3nxNDY+nw069un/iAa7Qy11BuccleEjUCxbL9H/qDR0r5Z/FJJhf2ZFsoB0xiiDEM5bY5/cyXf/GBnVgrSf+9d/bNgt10OEzaqVXabO2ucuztXE/c/Gz/m2AEdMmvIHr8wTz/dYL+6XoapvpEp7dCBVnoSXq/XSR++BIKgjk7lDCztHF+EZmVuzos+VT82f0LI7MpseBN84MVqNNv/n5KCPJbrFBHN32kcDOre1o1Q3q1M6TLx4I0ecQyQLYHROxpGjgFPYk7zc3iIEuFqF+cXCxTJD4LyV0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef1313c-d9cf-476e-ed46-08dca115cb65
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:23:35.9514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVEObsdGaMrw1TIoCziNi/dfH/DdxpB6RwnUN8FtlBLtqv+YsGUfors/zWLLXJusyqmCzxiTe3YiZ+qtwXiJxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6106
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_14,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407100137
X-Proofpoint-GUID: d2Azyu8hUA4IQ7CrbOnTAHCmTHXtFNRf
X-Proofpoint-ORIG-GUID: d2Azyu8hUA4IQ7CrbOnTAHCmTHXtFNRf

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Without an arch_unmap() call anymore, the check for mseal'ed vmas can be
moved lower as well.  This has the benefit of only actually checking if
things are msealed when there is anything to check.  That is, we know
there is at least one vma that is in the way and needs to be checked.

Only call the can_modify_mm() in do_vmi_align_munmap() and the MAP_FIXED
case of mmap_region().

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Jeff Xu <jeffxu@chromium.org>
---
 mm/mmap.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index df565f51971d..c343366b3ad2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2849,6 +2849,10 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	struct vma_munmap_struct vms;
 	int error;
 
+	/* Prevent unmapping a sealed VMA. */
+	if (unlikely(!can_modify_mm(mm, start, end)))
+		return -EPERM;
+
 	init_vma_munmap(&vms, vmi, vma, start, end, uf, unlock);
 	error = vms_gather_munmap_vmas(&vms, &mas_detach);
 	if (error)
@@ -2899,13 +2903,6 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 	if (end == start)
 		return -EINVAL;
 
-	/*
-	 * Prevent unmapping a sealed VMA.
-	 * can_modify_mm assumes we have acquired the lock on MM.
-	 */
-	if (unlikely(!can_modify_mm(mm, start, end)))
-		return -EPERM;
-
 	/* Find the first overlapping VMA */
 	vma = vma_find(vmi, end);
 	if (!vma) {
@@ -2963,13 +2960,15 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	if (!may_expand_vm(mm, vm_flags, pglen - nr_pages))
 		return -ENOMEM;
 
-	if (unlikely(!can_modify_mm(mm, addr, end)))
-		return -EPERM;
 
 	/* Find the first overlapping VMA */
 	vma = vma_find(&vmi, end);
 	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
 	if (vma) {
+		/* Prevent unmapping a sealed VMA. */
+		if (unlikely(!can_modify_mm(mm, addr, end)))
+			return -EPERM;
+
 		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
 		mt_on_stack(mt_detach);
 		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
@@ -3341,13 +3340,6 @@ int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 {
 	struct mm_struct *mm = vma->vm_mm;
 
-	/*
-	 * Prevent unmapping a sealed VMA.
-	 * can_modify_mm assumes we have acquired the lock on MM.
-	 */
-	if (unlikely(!can_modify_mm(mm, start, end)))
-		return -EPERM;
-
 	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
 }
 
-- 
2.43.0


