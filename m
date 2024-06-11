Return-Path: <linux-kernel+bounces-210389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D656A904311
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 528121F25E02
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0911B74E3D;
	Tue, 11 Jun 2024 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gaYTCc2Y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HXdp6LXz"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209D55915A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 18:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718128952; cv=fail; b=u1X4B70Zz0Fdpt/PhOw1hcJ+a4k7w0iLViesDkVTf1HNRGXWup7mFnnWO7o/1gHI8ehRKge/gJNWvTjWGQe6HKsQVuFV93/020NRoInjTrZ11OlO4mbbH1CSO2OousMNpm91Yj0FMmMaWL3CvFfNSs1DqdHXfwSoZcLxyORTJNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718128952; c=relaxed/simple;
	bh=HDVaGS1d9a/2YRbocg5jMg0cHbMpfbegjwO8Uvg8ENM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JUKFjorRBbw5Cb5vga9CaB0t752y83qpfzJPR5jopfrPRySG3MhHYOfM+yut0hD/XXnbMVWfAKL6lU8RiTaElODOg/bXQOUgV3ODcQtMFeD4hyAskfxaO2amzVaepwV7iX1a7TcL5homc2RveOqMUw9SIUBnffh/nTWO9zY95gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gaYTCc2Y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HXdp6LXz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BFhbwG012582;
	Tue, 11 Jun 2024 18:02:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=MFeZrFP/xFyu1t0ex0f/0sa0iG1XCbNnZL1kUI3f+xg=; b=
	gaYTCc2YJ8zz2hEutGdQfIQc1SnCUchJsnAPLEg5NceNoeyc2whM4N+rYbMHX6oY
	eNDB/8gorbnTHhzI1XL+R4BcEOpRNddeL+fK3ThyUnqHBRylLr0557fpS/cMoKK3
	W7aJSud7Pze0XjcPHAzoMneeQ67gwtJfRTbcwBh1i3jvvQ47FoTIwbJMhZwprcwO
	faLHHOT9w4zv1Ku0YlEORygvWT/53ekoz0DuhWiQFIKOP/ZrX1cHWy2WaJq061gr
	09heUe8nxirtRBkjQGb74BbH0YTwLpYyMgQwVC5l6BfUEG/dNI7dc+QpWgj5cf1A
	MdXAdDk3N/M+vyCEvigFfg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymhaj5fgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 18:02:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45BHw4A1036562;
	Tue, 11 Jun 2024 18:02:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yncdwm7x9-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 18:02:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxwR8A85G7L39lI2SciQ0aPiXEOfh6zSJcZESo1lI4q/FtdZKDULUiNGc+SGU6oVBVMNaM/JX7f45LJu/ZVJ3uEUGdhIbTZIi1vM9ZzrUkLM/c2W75s6aoB3B4tszyK+GRL6wcqcct3MOrs++KDlV/9Ewe7XQo6PR+petataIJ+5p6C8fD4Oz2fdjDomf71tKNw4YHUfimk+k3ZBdfs5XrLgJ5fStFqFDL34C+IK5hCqa176mDcgtImcP1d//tB0tOPFKu5kQ9RwQbgVJoE1KKer8R9Lbv+r62tWye1Hib3BwMHOXvqySmIczUoKwGeEJiHiUuwmiMt83mwEzK+z+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFeZrFP/xFyu1t0ex0f/0sa0iG1XCbNnZL1kUI3f+xg=;
 b=CEYMwwUOVvBIGvL0/wzaGuEakuRd0MgJ7TeK+96g5s4K4Go43qIPnT+t/AUH2SUsXNNjRH6TkuC3s38sDxKO+2XU3bV0dqmkkzO0/BB7Rz/4ENyhQm5Lu//WZZzGDs94lu0wUpJB63mpQpZkHh2TfxYb7tWr9gPC6bht3NN4zjOfJwzn65FpgOGh2OMgy8IuXDUHFCoBsH7OpqlDf6n9txmnG58yGMAXsEsMEICcFD7Fh//wLU7U5vhgF95xUM9Pp+Ze1WYtHk0BaK2Um/r5r8rZ6HVJ8WQ7zJvVYakV7yQX25xjIVp2veysQwKTShkfw583uJ4sf2Ge7LlhphZRRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFeZrFP/xFyu1t0ex0f/0sa0iG1XCbNnZL1kUI3f+xg=;
 b=HXdp6LXzV9bomxtd+vWVcUaceS8HM+wPtjwJEyPtuOODhwTp8gK1S/Oy7XVxIAsmhofY4tIdurx0veb286HCx6eJJwZs486gJZIBtDSYl/ICp0KubljAuQT/1XtzsJo1IPeBcmHmVvvcXYy1MiNP20OWcDIozPgkkwtVoiNCZfo=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH7PR10MB6154.namprd10.prod.outlook.com (2603:10b6:510:1f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 18:02:17 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.037; Tue, 11 Jun 2024
 18:02:17 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 3/8] mm/mmap: Introduce vmi_complete_munmap_vmas()
Date: Tue, 11 Jun 2024 14:01:55 -0400
Message-ID: <20240611180200.711239-4-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611180200.711239-1-Liam.Howlett@oracle.com>
References: <20240611180200.711239-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0272.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::24) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH7PR10MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: a2313aa7-bf69-4950-5093-08dc8a40a1ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?EuaLWRj/643FJY2QbPQ6May/cB1DyJenQ7nSHcsQUFQNWAEDkhQ6oPlW1Myo?=
 =?us-ascii?Q?90lwza6irUUn6yLQvUhfX7kZEFeiRftzSFlqat11tqWM2n7+cYd4ZVw9CnS7?=
 =?us-ascii?Q?NzmvW4aBCwxv+LTHzrMBVLbz5uuFtutXqDuHjmG0dp3MLbmPjXemcdTGrFUt?=
 =?us-ascii?Q?eZ3UMEeJQ2QXRqEZwqwjnMnQ1E2Y7K3qPG4u5Czq4KNK+j5/fM4EvwwAUYac?=
 =?us-ascii?Q?k88Y67oQo8GNdomavQYieQNRWeNXrYmp+MLc0uVJDYGR3zYi4nDkXts2ICZt?=
 =?us-ascii?Q?VmIwlJQ+dSd/csMcdJoV7SEGA7SefUjoIUaAnSQx1pDb39hR0R9vuPZyrdE/?=
 =?us-ascii?Q?S0pht2c2FM7LQFU/yUY6qjelJgFgsWPKOKtoLeghf/2l4uajZmGwKDFs09Hx?=
 =?us-ascii?Q?x2NEYlkNUVCzieymSQNIayhc9jB+3uLaR0KFcwrTy03yc4NgRghVryXqXU2N?=
 =?us-ascii?Q?TY6oPsb8NMrGjT42Fu62MZOfPWGjcpMmK0tcg4o+UeCJ2XjjRE9gRsJ+FzLn?=
 =?us-ascii?Q?J1z+XfgSL/cXKeNIwJVEB2reEACQDQwhOiESspVbIDzUaJm2OV5RiyuNkwNz?=
 =?us-ascii?Q?uf/b80ZwvUwjIQVmetSPFO9W8Xm1Grh3T9LnUq4zK0e6DHcrFCL0G8ptNC2V?=
 =?us-ascii?Q?+5NAUN2OU8G/neYNLSb2KJHGyFUsQ0M91gZuUyuQjRoBiE7zEFEVCDhDPe+Y?=
 =?us-ascii?Q?luvG4Q9IiUy4yLLjG3ltYwe++JqvVBmdBxsXqaazZZ+bKAGE5rEwQuDyBuRQ?=
 =?us-ascii?Q?VcZduywtzfqknpvWxK1WuS1efEdpjo10PpPZeKZgTYtvGvpOS25zCtBtG84B?=
 =?us-ascii?Q?3KEYG9/w9rX3IGWQbYAVDCqgSjpaw2cX+EaD1bA57JrTNucbjC2HjSF80sv4?=
 =?us-ascii?Q?5rixZURULacU7Iqqyk/co/3KAN4/610wXq6chKzWX9cPgUlzmiJ/F3XTC6AL?=
 =?us-ascii?Q?7vzQm4S4gH/vI4UlTCTrOfffC3fPZWdyAHXORUshkkFDVc0cboCngZHij4+3?=
 =?us-ascii?Q?kbW4nf7aR6fHN7yYYBOMr11qoeI7NEhRJDlr4dojQ8d+uHlijn2zGLZPuxUj?=
 =?us-ascii?Q?ux2fHjCXiMPdTbr/9RU6D81DcOv5I+sQQ0R32dXznyWM0PZvoQ/yj7iiPG+Q?=
 =?us-ascii?Q?uH2d1K9G+lYDffy7PvedRvwkojCJg5r069pfiV74T20M8hg+3e2OeOneiex8?=
 =?us-ascii?Q?+5QluSyRBrZzbu4RafyuNsXejohE8m0CHbinLWmnO2gYP6Rl3Dai+Sll/iMn?=
 =?us-ascii?Q?Rn+HdNBr8or0OVKBCRBSKbVpKUS9KS2hYcpTbZOe0hFWAibtV8D4XaP3i4TV?=
 =?us-ascii?Q?B6zesqZbUZ0OfuvfFXHTe0S2?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nzUwNAFfUFjrcQxOC61TsUyS8q20dyMoygOxIgYjnnmbRqZq4Tfe8+6URvp9?=
 =?us-ascii?Q?CoenrhH7H2w/teDXaQ+CVcdavNNdQNQBrBKND31Mjdawiqd6czcleE6T6Hz/?=
 =?us-ascii?Q?dw7L0GfZNgYysYiFxQi3MN9s34LyEok8g7ReKP5A33LhfdT170AsfPEPXWXm?=
 =?us-ascii?Q?f1I++7r9Kbt0v4sLUiX9aPSXQOWnJkl50FhBBnMLchHT/09rF3A/kDTmRdGO?=
 =?us-ascii?Q?bwXdUqAx25Qy7VUe7dlPYNgXW7hUlUqLSvdBoEpEKz9bbX39720TX0teypLA?=
 =?us-ascii?Q?F1y/A9DyFMFwrXDZsdodJuA5NNu+dHonR74SMmsoippwR3ArX1moWVUA6tcb?=
 =?us-ascii?Q?VO75HgUEz752lKevpbsHpYzI518Y1ksOCgNurNYZr1sNkZ6oGKMp2rznOm7Q?=
 =?us-ascii?Q?dwVc+7bUhjGDYA2WDDpfjPOy1s0lm7yG7UzgbWnbJOnmXpQzTtq9k/xr2MVE?=
 =?us-ascii?Q?w8yZlom5S9j8g559cojnyyILqPB7Jg1QDlbP5jOAlUMi96CfzR/dMKNbXJBm?=
 =?us-ascii?Q?ghJrXk9GMztaL+IYLZTeqt3DzINghiJNnNx/4nK3IJutNMdwrSHV6ozXPL0K?=
 =?us-ascii?Q?b154tHrIjewS3BsI0ChhVTTuQ6cu0Jb3w2dEHncS+cJ9clQlgqd85HtK5oUs?=
 =?us-ascii?Q?jYgAjRP0wuZSuqhcoeZrCny3Nb/iOKRjH2DRf6Hk6tX4lJGY2m8CBdjqBAZn?=
 =?us-ascii?Q?8ea/51tjKDGlvbZCUxPiGxBwTNVFcU3T5ee5DL2KRkL2l1lPGM6Zkdl6gZl9?=
 =?us-ascii?Q?DQ3/eH3L1puJvJNAatGABkNMq85ZWgpGJ2+9dHP9IYWk6AoRf2q7m5sP6dMA?=
 =?us-ascii?Q?mOtR3FlLnP6rRBL696fUcvJ46rLUMcrXy0RuycKC6jqs95KXOnWxL4TqX7PK?=
 =?us-ascii?Q?OlLhMiGPKZoz5N1b3rGe7t4n9+SbDFGbaPfWXvfMQeZN661FdWbw6AkqN2tw?=
 =?us-ascii?Q?1JwIqb5a3lKSUUYqYoEnkOjNeV8XpYF4WZsrfNUNOhGVX0w+um5cbHtry2/b?=
 =?us-ascii?Q?gLW2EYXaYB8DTRnhsgdupi6ivgcvs0iXbfuDPdhTf++gAi+QCianhYhLD8Fd?=
 =?us-ascii?Q?Q7fppl7quJIVq0f830yQgQn1tW/X7cCUknf5+6/4mOnAYq6EQnjFQ7/J1Wh3?=
 =?us-ascii?Q?r86vmNdIs+/zTmw2MBVyWfTut9fGT71Qa8lOy53tCWTcoBmVmY8wSYYk3pws?=
 =?us-ascii?Q?zks1H2IGbuwOx50dLx/aKCjYLYtL8r1mcMwvVOm0cQMUdJk0MofElFXVt7cx?=
 =?us-ascii?Q?o5xotc5cTOtPGEg1gU1piJuy3PjOVReoO0lwvamsO9JFJH6hICpION+XPQfr?=
 =?us-ascii?Q?JX0oZ0nIVG84YIf2ggO9Viszo4TGIq41m4+bqYxeB9weHLYJC+0YLJhGPVCs?=
 =?us-ascii?Q?IQCOh2PdVOAvbepTsd8gFaHukCNXPE/2osUfNzoENln6RKdGvOKPA1CNtqKu?=
 =?us-ascii?Q?q9uMPWVqXYZuVIdRrarPCOriYaecgzsiBg1aCUpLg+TnkJp+gS6V+8Qu7de9?=
 =?us-ascii?Q?GYzyEG78V7GXUANu4llGSqVgWs02S76imJ8jWKEIM2aL643KUwwzERNwDDHM?=
 =?us-ascii?Q?BzA0by68lagDk6jZVef0kjs1WEsJAVMvGV8lamC4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UOV7kouxgIy0GFX/4Atz5gzQrlxH1DeUG4eKhAOQktjYEybGFsDFF1HkWe/GE/VuiCJ6ATGJ8rltbJv6i+7hidxmUNJsjgn0p1KP8BEIW7uKYY0QpXzzo9tHRRgsAwQdOZUTCPoqe01Rxy24Q6+W+vXg2N56E+MkI2T0EOO32Oer4Badfz8x6NuOhBWO4U+CGngN8HktlWlsA8Flsi7XUK51j8z0l/V9RTSySiPonLXN9QtidS9jIn8tSpoF6nq9GYjpiKHUoZUU6OKRNC79oQmn09f4+j/NWiJzxAl0nX5v8/+vBNsiHxhCAGDR3rKf07oOWekHo2NzlPPVz9wnUna34VyCcrS33mYTcDpnLwv/s/PFQ15UizWoE7UhKgtYY04Y4qPpEfGgfCU4oYA8VteB39aHhm8I3UkgBBf+G2TF28CvsCrZlBIDzkW0vNBwJqdBHccdt4WP3APF4hVS9bA7FGwSRycrr2QLAXV57PK57/+K79/k6W6mFStcVBHeqAZiYwG8pRuNNbhAQbe3lEADx2QEZzCJmVHFewoH2HNz44b/kGcdtG0yoo2LGC74B2s2uW0Zi0B0u03QbdSJqtpKCSUqfk0Qz3S08qnKkPw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2313aa7-bf69-4950-5093-08dc8a40a1ba
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 18:02:17.6861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cv7trV8GOVVAjzCe+hqwlHJf1xr5aaJDHo1DXOZsNEUXXy5xWJieEL5J4mWgeqOvzqT1JHJGDMKsq1utvYoA8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6154
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_09,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406110123
X-Proofpoint-GUID: m1-PEulBQsaQj4vb5Eaw6YtEwU4Llkma
X-Proofpoint-ORIG-GUID: m1-PEulBQsaQj4vb5Eaw6YtEwU4Llkma

Extract all necessary operations that need to be completed after the vma
maple tree is updated from a munmap() operation.  Extracting this makes
the later patch in the series easier to understand.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 79 +++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 53 insertions(+), 26 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index bcfcbe006b1e..01bef2f7af2e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2564,6 +2564,56 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
 	__mt_destroy(mas_detach->tree);
 }
 
+/*
+ * vmi_complete_munmap_vmas() - Finish the munmap() operation
+ * @vmi: The vma iterator
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
+		struct mm_struct *mm, unsigned long start,
+		unsigned long end, bool unlock, struct ma_state *mas_detach,
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
@@ -2583,7 +2633,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
 		    unsigned long end, struct list_head *uf, bool unlock)
 {
-	struct vm_area_struct *prev, *next = NULL;
+	struct vm_area_struct *next = NULL;
 	struct maple_tree mt_detach;
 	int count = 0;
 	int error = -ENOMEM;
@@ -2687,31 +2737,8 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
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
-
-	__mt_destroy(&mt_detach);
+	vmi_complete_munmap_vmas(vmi, vma, mm, start, end, unlock, &mas_detach,
+				 locked_vm);
 	return 0;
 
 clear_tree_failed:
-- 
2.43.0


