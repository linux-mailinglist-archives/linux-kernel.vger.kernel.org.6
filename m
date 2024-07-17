Return-Path: <linux-kernel+bounces-255620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EACC39342F3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EA481F236E3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D14018C331;
	Wed, 17 Jul 2024 20:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WoP01W6O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gRdLmOrs"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31267188CD8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 20:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246871; cv=fail; b=jxDhmBpUeHWrdheyHt3X1f7kKSfgY64RQ1Zza0VzuRkC1m3ukS2FyAykdeUk+odXH9sdPNSEuRVkB0X84kX432PS2t1TZT1w00Bfsnjtrj2eeYGAy4HosGxMk8OVapzDg9JmBiNTUbF1dRifScDjkZjht8XZe/fOFXOqmDyfpyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246871; c=relaxed/simple;
	bh=SPC04A4gl7qVW535wKd38FTZ+QYFwYocvr8pZPQC/lM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=avHkSgMS1Jlm8uu4MN6dAJplWWubzJINsldnAkHK/AKAR2ESg5s7K2f4uAAFj8KlBL3J4k2NTXjxhk4ZH8Sw97vSRvJjpC8UlceN6TKTrYuwLWe+0v9dBX0fiTQlBMFtJww72oe1HHKc7PI5KsyfHg6jKOx/82023WklTuv+SeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WoP01W6O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gRdLmOrs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HK5ARp002719;
	Wed, 17 Jul 2024 20:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=LArHVtRPmTnLL4Ka/8b8U968Rn79AaiiLYmA/o/M1Rk=; b=
	WoP01W6O2dx5J7hrolTh2BTrFkXgiRJxWftRVO31nsM3ejb7sWpyblYNhq9FINFy
	qVKK9mkd3VOsvh0kgA3NI29r647dUcjOGcsr4f5pG0mgydkOuvSCN3qREgEfjjV4
	sBqL6pDZwKaWiy5ryxnxOKbLIHnuSpzKkY92RLhkcxhFU38wC9dVqh0CcDxQe/94
	VzflUDHYMPUMAn5PDcBHO1cTVx/e11aGTxc1oVcI+z8bJ+1v/yXXcJcYmJLzb4Y0
	x9Q1GnXOJta5Dvh9S7TgnhBP070GXMXkF+sBpIZuVDivfr0fFOxpuL+QA8y8FnD/
	pu39rxOJqzqkNkTrqf2UpA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40emp5r07h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46HJbBG1031594;
	Wed, 17 Jul 2024 20:07:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40dwexugm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=obBGr4I8KZ960gCY2GseLrSq8ExxoDbiAMMGnRFUltnFB6bOfbiAoSxwUO/FC/nev5QO6kXhqc5h4GquHALFVprCI1ZSZTfJBDjQCa9tKthojmmIpvCtG8YiUllyqCwvs5xS54TpVlFAUgYHxTE4PiesnQyMN3uV07NyRAlNCqpLLoP8Xdh/P8q8gHBNvlb2F3m9a8v2zLl+L+LlrBBjumNWdR45/z/454UhP8keYSgayVkGpEzO1ThMyqvQEZwKTuUQit+hr2K/nLGMub/QFNLxN7RJe1CI/CfNKPCcdUQU15i/sCwF0UT20QCg9UhxBth49ydxe1ceQ7T1lllZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LArHVtRPmTnLL4Ka/8b8U968Rn79AaiiLYmA/o/M1Rk=;
 b=BeFR2QXhKkiBecpgHGQVdRusWjdyYdCBNVh6g5Snm+JIRVfF+likh8Opp1Yk6r7uensTSAkoa9qUKs/iwbBVItWF8hoD2U2put/Ihi5er7u1KmpeZyQ3RHEuPSU923GZi0HuO1LuDLmtTkP+lc0UaessujRVUR7rS5tEzWOwF/Zox2o0VBK0IzVGr612OlYpSJkWp22AiCJGPgT7p00YN3itnmCu6U7ua8/3H9rccK9R6hfhpiUi48qt5i6BXePNKw0yUfUOpXQXjW2L+yigyYN4QDvDIn4JgMe0ZVblonpMrorJQ8X6PmNLX/2eia3P0shmg5k+r7OeMS+ECdfH1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LArHVtRPmTnLL4Ka/8b8U968Rn79AaiiLYmA/o/M1Rk=;
 b=gRdLmOrsmYgbKwkN2IRTRnzii38TAxpQu0jytbhkXO+OmES4ROSQchMdT9iIQfHjb9kA4JSckGzrfaVtfk08EsVRkEKmdiTGl5Af2MJZtNXaY2J++XCJlkkwh60LlWky9ByYNZNTT6oNEj+KA50L16KKkJXy5f3kSLJKW8R2XfQ=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA0PR10MB7303.namprd10.prod.outlook.com (2603:10b6:208:40d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 20:07:31 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 20:07:31 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v5 08/21] mm/mmap: Inline munmap operation in mmap_region()
Date: Wed, 17 Jul 2024 16:06:56 -0400
Message-ID: <20240717200709.1552558-9-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
References: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0108.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::7) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA0PR10MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b33095-407f-4e47-bd6b-08dca69c16f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?VtiqM40uxJX7F0NidoNF0nGx7Ppm2TEWN2JAkHwGa3B8PhvOiB10Hwyh1JvJ?=
 =?us-ascii?Q?GXwQCDTDtPuZYwBHT9g5RhaSDh5svtYbo8isASJIDzVtJhkxiT3VFL792SKs?=
 =?us-ascii?Q?4CXtQy0wghJhO/4i4tvWU42hN/UXceKm3Sjyu3iUTEmm9PatoWHV0eVKa37x?=
 =?us-ascii?Q?8yXrE0Y4I1QLH8MW2UVD5M53mdEKklJc5iunaqjBYWkbVwp0j1JeUlxwLlk6?=
 =?us-ascii?Q?mF7SjAI1ZuTi92PYnpZlDMtAanKWNHSMy/OtzhrUmXE58rJep/H8tUZdi10T?=
 =?us-ascii?Q?28JywznEYH5HH+8XkqUFfePmW+OjL83DRD6rtLPMhd3GSV8ylDB6Lt03XiTp?=
 =?us-ascii?Q?tpDd7ADKukmb8x7770WQpHmD0D7aY+lKxrn4QRJa6oeXO088Yj1KVVE3hAmZ?=
 =?us-ascii?Q?Ql41Nj+H4oYPFTM/B3ogrb1wOjLc0Rpw2NM8YuschadxBZ5dEPU0eXAZm46R?=
 =?us-ascii?Q?L+aZhiFMDhjhszWzA++QCoSQxkmjIjhDtngrP4UIBn4Mdz5+n8VpnKdDlMXJ?=
 =?us-ascii?Q?GKEEfQbjYGaT27XO3d9ODD9D6K++4bqWo2gWsTZWFlJ8FOLGr/hX7DB6/Eqj?=
 =?us-ascii?Q?5f2iAn1+uZPpg53REWQ4G2oI2Io6Mio4esqU5GjtF//15D7IOy2Jpx/AMhq6?=
 =?us-ascii?Q?gWxfD5yFn5P5rsMykqhcXoAJdalqgFYvm/wrxaZ13AwpwvtIj5ej/JSDMuwA?=
 =?us-ascii?Q?o3Lc//ych3o+oxdPTwuoy3OGXvwFwav8vjA3msaSWXcKFmvxqfHNtIgNbgaM?=
 =?us-ascii?Q?FCMAshg6GwCgzgkAYyZeXqILW6kTD8lVpPu96Fyi5s7AVl4F4VWQ/i2NPJQp?=
 =?us-ascii?Q?Z+Ax165h7GWmF+b0OJPryjgU0QztbplR/5gntCr0sN4UaFaw4MfB0MrZtxX0?=
 =?us-ascii?Q?VtaCd4P8tgJgvWLj7HMZpmSGeIgGPJ1h1GW1lFSGE2fNMq2N87NeghzsgNjI?=
 =?us-ascii?Q?/pqoZuYnodZXVLRdATCeXuOB6lGoCXPDP82ZrWgfgBxVv+moCTCKG/6uy2Hl?=
 =?us-ascii?Q?VIc+hJ2GnFyUd4BgDfCeIceoUY/x+1wNcpVK6FL7l83TOCn662P5hD8E9FO7?=
 =?us-ascii?Q?e6oaaRMo1jZ+30+QEkGyjeC3WopXGnj790iXK/D6YMhaime4sBC/iHzzY05b?=
 =?us-ascii?Q?TkjR/T/m2vnM3b3ObMQoHNQiTjp3OjkDLOouPJpaHoYeXNQfGJpmw0E5MxNn?=
 =?us-ascii?Q?CckFcNla8lkNus765/xUS6BgvthzBIVVDWUdRExcfSJxflLk5bREkkKg4Ecd?=
 =?us-ascii?Q?bK4JupPiNX1YPPCX2zdQGLLBff9S1wIUaxgYzs6Anj7pqLsXrSWNqemX1xUx?=
 =?us-ascii?Q?houOMDl2b5N6QR42Qn7Q4BpcERobCRIBuQm8qtNmweDbdA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?z7WN8qd3KH7iEiTEK1PxhX6oByaCv6RImUO//W5OkfxVvppVsPEldeIs4r1/?=
 =?us-ascii?Q?DoTFsBv+B+SdIPDhSKO1tn6bLgvwwUfVyjA7kncIK8tDXpujrZEuxyzOZsb7?=
 =?us-ascii?Q?l8ybT1BBvgh7W7DzdnFyjRFTNKB+F98AE0ABSOb4QmUx60LKghzWnmMT1TTj?=
 =?us-ascii?Q?jdjL+j+k0C86sqCZqKeTH6UYPR7PSgkofaTMe6sb/Zr+uOd2czh5n1lAN+y7?=
 =?us-ascii?Q?D5qJvdXB43UiLPWJsm070U73aasWcJovQTr4or0SEQARpwksGOVEMOFptCYQ?=
 =?us-ascii?Q?tQ1f2fz5slKOSLJDOjnGryQdXTlXPqKmF7PT0NWXQhNwQUqtrJHA165Ygq0S?=
 =?us-ascii?Q?p4Zg7TvMh9fX2VuJ7a59t5HKNBxeRUE2QZLzpJRK+rvC2ZSHQnuAjThX38pC?=
 =?us-ascii?Q?peBX0ZorMbuXMUA22Ca/KVMtytYC2avxRCmRwuYoiYd34HUmCzoyoppEyZGq?=
 =?us-ascii?Q?+/BdHGZv8IyVOTQPUeQ52OQaft7vR+HFNmJlTPNkQKASqvclXyAEL4TkJ+x5?=
 =?us-ascii?Q?0BbB3iH8nf353PNWgS1e0g8S7fSkJum99UXK6/PkJjSjQxFgdug203bv91Gr?=
 =?us-ascii?Q?A/CFZWa6ctFDTcN+mpuPrro3dBXKhvV0rPKvPPvpYdGxKneYRlQ07ckFF22s?=
 =?us-ascii?Q?fmG2iUlqmMNSEBP6ICW4MBY9rK62wobRBYYuJJBLmPmIKNsCFNZdw6D3xtxY?=
 =?us-ascii?Q?TcsqWZlypthszBMylG38b6l1PXFMA4b8JakFn1L63oiAf7WNQR6hYBNq9EV0?=
 =?us-ascii?Q?QlE93r1pKqOSCwb1fW/ZkMWW+aDR08ZEWnvzj7ITFNA2AoicMdieGBsvXHhq?=
 =?us-ascii?Q?0A3Ujm49DOw0C1JOyMBpQi+3K03NOECgKPlTs8hP/G4Edm7hczwJZ0pC6wED?=
 =?us-ascii?Q?JdwM7689iTud7ZZ+6ZcFMhzHnAWBKFbnPhgjR4PUznYcL81jB3xf4BfRm6h5?=
 =?us-ascii?Q?BKxENADagTq4N8D7oWlVAHauGDex4ZaDLdnz5bZVOTtfanJcntZQv1Lq9lPk?=
 =?us-ascii?Q?rMMQK8Loj1BiG2/iocDNCnTUKYximfQn+bwDbq91R816jK5JEXHBMUdoJdLQ?=
 =?us-ascii?Q?Mw4hHCei7bpio7neR6SV3UsAU+eqrYu8ONbPjyLWfs14txTBhtVDGq6eOZxl?=
 =?us-ascii?Q?R66m1s2bk7ADeCKcf10zMzvXTa2FOomJz0bMVDEbqKmvFX7rblPmPuddAjSy?=
 =?us-ascii?Q?UZcdTj34KE2hY2XylhS5GZ85krwnv8hRsUxFBrFvbP+nFnHnDHxM1m0ZdiLW?=
 =?us-ascii?Q?nxaq5w+ah8d3xLleHlTQ/D2yPWRH/VqDlbTtK4mkVIkWl1KyW2Ae0hwcv80p?=
 =?us-ascii?Q?nN8nLPvj+jJFwvC2QTnIZUXvqCNXIvx5V02dqoNfW3YPIhafQBaZ5toSV/6J?=
 =?us-ascii?Q?sOierPf+uKGPICD4VYkQ4GkufwE08FAnVNfsfNdsPMX9RGJklR1FVRLHWcll?=
 =?us-ascii?Q?0rGS7gFiEwl0RrtL/QqUsVMwca7ceVllcAp65kSNAoMCH5yMaJctjq0XABJ0?=
 =?us-ascii?Q?6QkCvlKAVewDbLnIQZ80CiS3LI0qDkRFBwqqvnXCqLLA8JeqacxQpEVUC+xx?=
 =?us-ascii?Q?djew7REaUNRvKip1iHN35zbX0VtWwO7itiSVaD4SNdDQbD2jckZy44yE/YO7?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hg04Y/uoTAYKoHdE23ks33lRiMzFCV8JFUb1SCHZub7a2/CGvDFZ2/0GZI3jPC1o+fN6dtru6qvH7/Xxew9gMI9KjyosM5yyV3tjBlItWaRdnm0XgCx28P6L1B9Ff3bPs9arvc/kfUSa9adNRNXpqayybwtc9QUhSFF4GsqQMUetkUoute7l8wTdsTkdQzKc6Hb8D+3ot2bgC205A0inQPzjxahXFMfcdHeNFSctKKKbmueI9TQtw5nDKKRWQmohE+wvfPW7bpmBTtvE4rJIQC2DN+yyTgQnUerNB5MHyUbDhy2vO5zcKo72Lvr4hPueh/eXZqan0i5C38QfTXd9Co19vJUVHDWaguaH7wEGde3akALf0TjoeAPeRQHclgTNPvXSOGY/wRst7cmfQ59h288SC5iPP7GPWsHdu4ixxdHrwQ3CJ7ertvI4pBJZq6bIh7335zWKRO/HA3AjazH9C1GtLMrE38ORXHFYx42xd6Mqki3xDmhQa1LYY3V7AvuzDO0aBedE/QJU2B1uEKbmHLeRRAcr8uHAzZxRgBxIijHlxaNbVWv/4eXkoiT+nU27JnQs346jXQKg3K1LNfYeeZuNTGYr7vgBD4vhDOEjZhc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b33095-407f-4e47-bd6b-08dca69c16f5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:07:31.0914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFaQsn6pQtmetdFzbtlWdRTaTAlTWXHEwr8nyGoNxtoG4FNNpIJ58AAcfsale5Nuric7ooHTbT2rQcDBmTcCrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7303
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_15,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=993
 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407170152
X-Proofpoint-GUID: IseVej541CAnO5fNrz3YmBtFU580LOpk
X-Proofpoint-ORIG-GUID: IseVej541CAnO5fNrz3YmBtFU580LOpk

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

mmap_region is already passed sanitized addr and len, so change the
call to do_vmi_munmap() to do_vmi_align_munmap() and inline the other
checks.

The inlining of the function and checks is an intermediate step in the
series so future patches are easier to follow.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 1c9016fb6b5c..49b3ab406353 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2938,12 +2938,21 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			return -ENOMEM;
 	}
 
-	/* Unmap any existing mapping in the area */
-	error = do_vmi_munmap(&vmi, mm, addr, len, uf, false);
-	if (error == -EPERM)
-		return error;
-	else if (error)
-		return -ENOMEM;
+
+	if (unlikely(!can_modify_mm(mm, addr, end)))
+		return -EPERM;
+
+	 /* arch_unmap() might do unmaps itself.  */
+	arch_unmap(mm, addr, end);
+
+	/* Find the first overlapping VMA */
+	vma = vma_find(&vmi, end);
+	if (vma) {
+		/* Unmap any existing mapping in the area */
+		if (do_vmi_align_munmap(&vmi, vma, mm, addr, end, uf, false))
+			return -ENOMEM;
+		vma = NULL;
+	}
 
 	/*
 	 * Private writable mapping: check memory availability
-- 
2.43.0


