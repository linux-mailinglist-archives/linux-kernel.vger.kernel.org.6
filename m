Return-Path: <linux-kernel+bounces-409667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1659C8FDF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E215D283B49
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B621DFE8;
	Thu, 14 Nov 2024 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="D04fzrc6";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="XDoVHFzY"
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6E78F62
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731602021; cv=fail; b=IBRF8g/SXRu3JClMlWAQM3cNxdcikMGy6TsZSKyi79FZql0VNd07JhSU16IZ5hWykZNeCoMIU5QxVf0gTYKnmkMaVrukhsICyXhMtj1ImoCKcatfQ6iXIcYvaWUI3Cs6EhJqF5MsUatedSKl1wAaOhLQCkgCwB5RLADO6I1d1Lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731602021; c=relaxed/simple;
	bh=aBEjFrVYOx54xJNPuV7JtXVCJumuJoMp8bXzPCTk4Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=I+8Y/kz9OwrauUjMd9lW0IyURRacvp9pTedMu3gNEcFUnUjur/vHyK07vxTHspY+mGiNEOtEM+ebKnsFV1pbu0HG5l9h7cG9sYBVY7Af4xUpqFvibIUpe16rDbyUnAM/KeAjJn6kSAqtev9iXu9icUe0GuDDeLug2OQOMXoudxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=D04fzrc6; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=XDoVHFzY; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AECLPQu002825;
	Thu, 14 Nov 2024 08:33:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=G2yFhdBVljQYG
	ICsi/DCzZndr/soCZ2sgBizE7kvVfU=; b=D04fzrc6+uXACe2DQV2tjObAcq0YV
	Xm7sm+gwCDMV9gmyUn3aqdODWYUjBpzKoFvwJRMEWJTs2hrCkDUS+yjjpAJfE7hs
	wV7dVPaPIx6GJzeBntnQgWtW8N64iDUltUmY+htX/05pz9on9ZNnTc0fR9yRDozQ
	Rh+f2O5C/GH3JjLvtRepMxzUzBy4oClFpRf3XhTuwMY+9G1RTzdOi+JFKzMxRM+T
	uIw6TUB9sf7D7xu7GChmSpUn4BoBngF3zlHrfz+s5drv1yafH7xTHR8QardD30Vp
	zXMRDx7iZm0DDFW27Bt6sv5WK8rJM4KS9cBUPLi+/ewcYlEDOU+OjILgg==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011025.outbound.protection.outlook.com [40.93.12.25])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 42wdx6gx2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 08:33:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UL/5X+ri3mfJUkeIeO3JPDLsORBRP6lIUI8W80Mj7HzR5LHXU4nDBlE3MotlILrekRlVtYwntXDit/WThackrE+RSkJ39EjnrCUN9tP2vOQbXa24UBgu9ufD7oVEFHOHENv23geKBz8z+2HpiqTinJN09QUhtlVXt9UTz5AouhUAcEpzIL8hp8xxuUH7YBg2KVL8blhLFf7nsmX6iEsOgm0Cilhdao1aKp+s6zpSBa/dq5Qj40Qizzlk2Gn2EeJxLSve6JH4pHL1XmfTpusXRVgr7aB36OFp8slj7C+DLiQQsOdhwM6EqScIoEqFNa/cBPY5fCK7jrkmyVaWp8w/xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2yFhdBVljQYGICsi/DCzZndr/soCZ2sgBizE7kvVfU=;
 b=bog4lIhfQx3me3zrHyV0aORzrwxu00oe8vi8vopq3SBrK7RKEezrBieWGCbN1ufIY9H73qhGHY8KcNoMFmg02+mvliWp2jO6gTNBDWB1Rz6dFixXQFcf5yNlQm+Gr9qUuAt+ndeZGNYErLgwqTC5AuYtCZI6zGENtoo4x1bxMZNRepN1IMfEKyk/YXQJXwk374cqL2Bl9PNz5KI0e9yAZfbp7Q0kkn4yC274E+7RM+Ku8aDQJP6LkTenXKIkW6Bt1raXPamrdjAIVI0Y78dNE+rCoCcRAvOS+ctsIvvZSH4AQQeYtaPVr46uP6wMfw3RksF5ycUKuQjtd0iEkpwHNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2yFhdBVljQYGICsi/DCzZndr/soCZ2sgBizE7kvVfU=;
 b=XDoVHFzY7YEY+j5fpRQ9Gy+vKsCzknfJXXv3zBqdkUAXUzifkauLpu2dEWUxhPUIDSox3rhYEHhOYJzUunqUz0wsYInWkhA9B5lwK9LFetWwIDMZ7NorUyihd3pMNLjs8JAIsXwwi+FIF/5BlY7aJuekLuOsajGzj8TEV+55Y5pjjb2rf6rc6WlflhANolnukumcuP70GMyvnzwMV/nBRlL98qRYukMUzl0B2sDMUabRF7o6p9T/KSzf8QCmQBv3zLxXl+3Slt0hHhw7pLwHJwfVnvmOCBIttWpQKfcXlBAXgi1TbpkwOcYbreUvQIkULg3ZtfCugSocWLLOdSnspw==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by DM8PR02MB7893.namprd02.prod.outlook.com
 (2603:10b6:8:30::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 16:33:21 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%4]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 16:33:21 +0000
From: Jon Kohler <jon@nutanix.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>
Subject: [PATCH] sched: hoist ASSERT_EXCLUSIVE_WRITER(p->on_rq) above WRITE_ONCE
Date: Thu, 14 Nov 2024 09:53:52 -0700
Message-ID: <20241114165352.1824956-1-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0088.namprd03.prod.outlook.com
 (2603:10b6:a03:331::33) To LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR02MB10287:EE_|DM8PR02MB7893:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a53c0f7-93f4-4799-a5ec-08dd04ca0d51
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WzfRFqg+wst91696xZ9VFakKEG2VcHJOVTmrW3d4M8/MdpRcGN3N+IVgZr+p?=
 =?us-ascii?Q?YRF5CvPI9wB1yXvY1AoiM6mxn/R95zVoeahvebo2eymFWpmFyHt0n4CLdyT0?=
 =?us-ascii?Q?AaQqogUbpmgOQ7MWmbruZ2nHRdASZN9jBUGHBXW7UiTe+Y9NokSWW7orR4rw?=
 =?us-ascii?Q?zk8HNPMTXoW7+OZ18WdktXKV1H9OWd4o1+9/sfV1k5Tsv/yzHP4QyTTOy5E1?=
 =?us-ascii?Q?F4gweISQezCXhqBHcYKrw1WozjMLz0YzIuS60mws3LD5sB9pF4/4MIiQjQWi?=
 =?us-ascii?Q?4JxdGfs8FwOnZneyHQMDC63SAITjx8tZAXoSkEP+aHvykcqD8tbe58Ez8qRp?=
 =?us-ascii?Q?5e0tcllyIPBLCfKDGbD6wyL8OE0xPMSDOBhyAWZBZb/ofpzRLJcdD5/osRUj?=
 =?us-ascii?Q?spuJoTIKY6YXwhztBjnYiJ4bUqpF4rtxV9wePi4J6S3G3B5IHmR9RvUYdJvs?=
 =?us-ascii?Q?gfIsQ6R9fTmVuueHsfXZPYLm0AxVOcZmAr3+8hVkRq+n0Dx1TJaqzSycsD/N?=
 =?us-ascii?Q?x4kw/osQYo9UHqQlvzxJfvrq2UC1f589IwppdYcPw0tD2LA9cS/oopvo3GpH?=
 =?us-ascii?Q?A9GoFJA2kohXcdqPl0mVsSkaMTUdf+aadNPsclpyCR9+D4Z8g9rWD6AD9AhW?=
 =?us-ascii?Q?+shOZ4Ae3zjKPoPyiAtESCXsdlQCw7lZvny+Vi1F+9tNn+uA/fgNMwP8wUVf?=
 =?us-ascii?Q?U/TJsEYVw8vY6mThA7UrDAxiOn9m4hHrbDGhHKxBF8pVgGoXUAUCrJ9xfglW?=
 =?us-ascii?Q?seU2qO6X6DMDaorfnw6IMBAXJOzY0nsifmFCTVts9FX6FVJ/zpcjPC3O4jUJ?=
 =?us-ascii?Q?F0PyzspRvMgDgmcNlwgp+7JKWNrAE3uGpFfdoCthtE9DmmzBFY+woJ4Q+URs?=
 =?us-ascii?Q?sgyjBJKcoeVluBhdA7pv/Ki4YcZhAMSnIOuybPlJQl69+ea4gt38KqPFvgrG?=
 =?us-ascii?Q?BBngbg0XKI2/HTjoFzOGoJ517FPCynU6j7X+A74JYAMDSEWWdragW/mf0tfd?=
 =?us-ascii?Q?1OADJ5e6HrSMfNO7FssbZRgf/imHtr7lUP7ciEGnaLpfYnplxZwrT1EroteT?=
 =?us-ascii?Q?NF/hM1WdM0XYMN/6dOMqiCzEgNZAjM5NUjWbKGl27PuKxZVUZYqn+ocjIa1x?=
 =?us-ascii?Q?TXw19IiCpJPB/SgIpWersX07MY1TUqZJSk7juB4KKClIvSpj67QPY2aMnLnN?=
 =?us-ascii?Q?4tZcHsSiSfv6NKdrjR/xjl2wH1TYQRIiSFaXqEMRNHohLthWPMPtGgCAvYG8?=
 =?us-ascii?Q?Zz6xNg+DNzTe1NC8zTRCY1lTYaiggsebp0DZFpRukhKUR7YsSoOUPknYBzcu?=
 =?us-ascii?Q?kWfQXwS1gt3E/hReqi+fpMcK7EkV2V0g+XJ9iPPHDnsR6KP55TcCcnGk4jhp?=
 =?us-ascii?Q?OOKdkiHrjGE+3jvAeBY/rnbPdO9P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F9KkGGGfoUNCHUthLp3fUhWFgE2LLVdlaRzfvFlVo1LPJcAuHB9LkspuARor?=
 =?us-ascii?Q?S0oE+aHFMe1fw7gB8S/BnaQHJSewzZHH5n6Qr8/8kGTyGhTg40+PfFDTCghP?=
 =?us-ascii?Q?OGpjbZYjVJHDaVWd/kXJkHYsZao7H3efWJvvNGvx5bLA4y6KpDBDSPVrFCXm?=
 =?us-ascii?Q?Vbj1/JfmZA/sxsWB4Z2IsRfoXC3ZLONsSVoTwHyONHudhSvzLuziTcx0brVI?=
 =?us-ascii?Q?bVCVbrw63lv/npMuG+kBBIurcC/UvQieBCAb+mnaR5+Gc87k0cIf5LKQ911y?=
 =?us-ascii?Q?6BudNVM9uy4nVTm584UGkb5DM3h1IOhxlNtTY6R/E6IIh7BfhGiNSC4vaKgi?=
 =?us-ascii?Q?yewUL+aJ23cnENS472WNJ7dTBE5OWaVC48pkR1DQHaIz5Qu3suIrL9B14wl+?=
 =?us-ascii?Q?jLs3RxR2On89iyENdRYuF0HQ+LwJGwuyWWYVu5CcH2LL/HTLw8d2A3aapBg3?=
 =?us-ascii?Q?O5lVCiBci+NMR60OuwASvqubDBZDFqODUKx99Lca4MX+RcK20KqyOp+zze+w?=
 =?us-ascii?Q?61OQ78fUwpW0QEkrD1WDJzFFMlpUwjhgpsoNousqsw/Cc2Ilm2JXKNzla/VB?=
 =?us-ascii?Q?Vc6JYlDx9zpsklGGjmIEPnAIXqzmx2mnVjUf4oYhMqwUr5iukSWuk1UKX5Tb?=
 =?us-ascii?Q?NcpXjuE4MdnroNpjuIWKsF05+99sRB7q8caXEfLxMuqyvWP2lgiaDUBo+TB9?=
 =?us-ascii?Q?y1QBfutTsVy5bnd/YmHOtbzpRrBycQQPEq+8qQDrjXJb5fySFBYDteW+ICvr?=
 =?us-ascii?Q?MFSSj2YVp8pJbJtEb4a4Er0G+zsK1dUiP69mNVULMkIMWQlAmx7rpGHtLryq?=
 =?us-ascii?Q?t5oR1SCo4GktScwUdGWRC2BC0ooAqcv6u5d18T/cXFs6gLIwTJ9RFk0yyvdE?=
 =?us-ascii?Q?eZkMzC6V6Oj5pLXlqYoxWYcabLoCxq3pggHnZaahlAuPxKnrgum4k3t9UcD9?=
 =?us-ascii?Q?1RvOm+SS6+TnMDYZoK+nlFQ1CK3hkRR3WQJUUodqStKkFYzKrgZzIlc18MxQ?=
 =?us-ascii?Q?MBmazhYdLQggcRLxe3ntCO9iXYp0zu58r1S38iBzHDVvMleVNEruwR7toBUj?=
 =?us-ascii?Q?NXi/5gj6ko0gdicpKAJeyjkU9wcoHv6NfQYu5DkLLPvS82jS4hUki+9nE9c/?=
 =?us-ascii?Q?J8YLIT4GhZKaNkFbo6g1rUYL5RWYofi08dMRT/PMjZPlkBOSjuVisKtLS6bF?=
 =?us-ascii?Q?YWr5c76G1XjfUe0y9yzUgK+rkNB7dK/ZIfrSjPp69Gfcs1E1IcAit/cFYYVi?=
 =?us-ascii?Q?o2d2POyHRzXe0QNP5EjAV/X6G+OxjmdK13ui4RLnF8Nv50N1aPWal5SYZxoW?=
 =?us-ascii?Q?e/WeNWe/yy4yQjSbO51+unN5qQsJi2RlrBxysB7gjj8gnSyARUI3jJjtZMae?=
 =?us-ascii?Q?l7c9YYHqxzdf+etPBnF01G9yqeaD3LYK5HfvE+3zZWoMArq8r3vyJMMmKPNU?=
 =?us-ascii?Q?SRMJGcL/mg9JRkPdcWzyqrsGi48nfv3V4TWflrUpRQ6WSIuoKOxGto/rPzIb?=
 =?us-ascii?Q?ksbc/NA9dB+lNuRVUYjKcdi0xTkh+TWN5OsM9FtLL1NLYP6dflPP0vRcnGXh?=
 =?us-ascii?Q?OO5GLh2s/j7BMe94MoqzSVRVqHZg4P5hQsRdSjErzkhXE0jM+K00btrEbwtr?=
 =?us-ascii?Q?1w=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a53c0f7-93f4-4799-a5ec-08dd04ca0d51
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 16:33:21.2523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7PELeMwYBiSAYAiRQa4QZUX/De/9Er3G1+yv8gMUaTy4val0oubsnYHsMie4vb0rsiZkjKPLik9zCHrZrktzFyJQXqjIk7DVfENx9hAl/5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB7893
X-Authority-Analysis: v=2.4 cv=XIpiShhE c=1 sm=1 tr=0 ts=67362653 cx=c_pps a=+Uvz/0742UIoYwQyQT1M/g==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=SeSF_3wNJrZcFQq4b1oA:9 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-GUID: 2WkQwm0Br4P8V7vD50eMwHevLcLmZ5g6
X-Proofpoint-ORIG-GUID: 2WkQwm0Br4P8V7vD50eMwHevLcLmZ5g6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Reason: safe

In {activate|deactivate}_task(), hoist ASSERT_EXCLUSIVE_WRITER() to be
above WRITE_ONCE(p->on_rq), which matches the ordering listed in the
KCSAN documentation, kcsan-checks.h code comments, and the usage
pattern we already have in __block_task().

Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 kernel/sched/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a1c353a62c56..80a04c36b495 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2066,16 +2066,16 @@ void activate_task(struct rq *rq, struct task_struct *p, int flags)
 
 	enqueue_task(rq, p, flags);
 
-	WRITE_ONCE(p->on_rq, TASK_ON_RQ_QUEUED);
 	ASSERT_EXCLUSIVE_WRITER(p->on_rq);
+	WRITE_ONCE(p->on_rq, TASK_ON_RQ_QUEUED);
 }
 
 void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
 {
 	SCHED_WARN_ON(flags & DEQUEUE_SLEEP);
 
-	WRITE_ONCE(p->on_rq, TASK_ON_RQ_MIGRATING);
 	ASSERT_EXCLUSIVE_WRITER(p->on_rq);
+	WRITE_ONCE(p->on_rq, TASK_ON_RQ_MIGRATING);
 
 	/*
 	 * Code explicitly relies on TASK_ON_RQ_MIGRATING begin set *before*
-- 
2.43.0


