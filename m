Return-Path: <linux-kernel+bounces-572022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC52FA6C588
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FAEC4864C7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391F723312D;
	Fri, 21 Mar 2025 21:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O/7YFU3z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GT84Osnx"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF6F23237A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 21:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742594114; cv=fail; b=cbVws16VHN2V0i9ZaiY9ygsweuKLVzlOQMwRlRhJdeiwtYVTfCVFeVBX+pyRogUdxaw9BTduwg7nF2MYKPGi0lUKM/sjj9CO8UAz/Nibmdb+XpgIOsrvD8qpNyMbtb+onRy33lCAD/tQSYOrQoLXDzHnBOQ1BOFFldnPe+9V61A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742594114; c=relaxed/simple;
	bh=GDw6pzFv8XryG9pr5fJLFIJGhKJdKbjcsXDjGqXfu0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UsLthu8nteVz8sIlHyFW94HcM8j05kPna6QovpP19ntpijN7bBCAkeiXz6XpWoTTRMijmeufQ4SteoxI2veoEo/h08oe+VAeSwOb2Ghed7B070VsKBoJXiXMPoSx/DN3A3oz/jO8olL7fRKnMHmrvgbOsu9VMkeG1gBa9dHy/zQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O/7YFU3z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GT84Osnx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LKftPW019295;
	Fri, 21 Mar 2025 21:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=9zNYJgFUqjiDIj+JrZEMeZN29l5x52LP4nrUTRgqIIo=; b=
	O/7YFU3zwboWdWTiV+5Sm7/7aIJHLEc9PG6ZbSm6ckqpXEJ/oWGTGV1ow8ryqCwv
	f3WWc5lFAdkNsQ3a8xEKamcWwYz5bIl+x94OG3YQPuAJC8nsVpwpcdtPWd3JI/u7
	ANY3m9GtW67SwsoX6FM/HkCLf+cXMCrUsFGsRs7XP5JYMXHj+4TpqJQwQVX2sUpr
	aX+dJVt4JLN62IHPuatctyNyPhZ0kQOXy2VrE6c/g1WyCvYxpJ6gti6csXulrSwK
	JYj5ADpjvTIV9bvVUMD4KMW+RM9Z69lTm+AIrejfs5r9ohj62M6T2RhGKa6WYV1T
	ymciK+XYz4zzSGz/PJQr6g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d23sa1t6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 21:54:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52LLU8PN008920;
	Fri, 21 Mar 2025 21:54:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxm4ns1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 21:54:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iksubTIGfAUyVwSVibrNA/4PKBDI6wECvXlV5rDsR0P+qF35tLutt6pPfc3eZWkcSvp9o6AYFvWabe65Dcj6JMMrTORJcBIjm1msFwfJ+WUP83fS5TWejBZ1RDXqB6lyyUTWrsYVcFHiD3QKilSHrrR2jQ4+lmkd5jwNFf77W5QeRGVcWtLAk+W1ptlD8aAKZhUGePNv+0qaw2IGXzkfpN4sVVXrRVUKt1i4UTx+mCNxQt7qgXeixwcmvkHMjNe4I1RGCrNr2okQVu0Ye+nbWj9wWRT7XgpvA56Adj/hRveQInPYQvIkBtpwdNEDleSjJYiY+P64JgcKlUshr0ec/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zNYJgFUqjiDIj+JrZEMeZN29l5x52LP4nrUTRgqIIo=;
 b=jd3lMw+lXOrhjO39QdBxrYNP5XoADUbE5q/9UHNc8rjctrItH/MYNnu+0TjwwM/MTKuXp6Tkd3w/sJ8tLCbZhAZfG6U2Jj48kllOsjN40uGzLkF9XYBLZnjXdQ3CuCQJ4UIU9GYyAlEnWqje7CNrx1oLQ4zdyImkHsCYGFwSC2dOYz3AotAIaIsyyAtnE00BRc8u9TF79L6vdlfFeWI5Bs+N9ASoWA0vDC37RLb99BcRB6Ehm8n9qADHyKMVmI4asZnqXe/odBoPIPZmgMEQ0GTu5xohShAbGlziFfDgRLO3NvXfhywyV+Zbwwv1kpPPZ8OyA4U5yTFnz4GUiobobA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zNYJgFUqjiDIj+JrZEMeZN29l5x52LP4nrUTRgqIIo=;
 b=GT84OsnxU8OXzCGb7EpeB1YtM/Ir4lNrbXqiH8OuxpJMPE9cx0JEI8pSjunhycoJL+ys/qFgEsQWUm5vxHXyyy3wQq1GIIeJrkNefdhL8Zp1bXO4EzwSu6qgK23Zt+4WT5Z7gm466t9yHwfZO4sr3tHHIINA38Mebs2G3yz5o5M=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY5PR10MB6144.namprd10.prod.outlook.com (2603:10b6:930:34::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 21:54:54 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 21:54:54 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/7] tools/testing/selftests: add mremap() cases that merge normally
Date: Fri, 21 Mar 2025 21:54:34 +0000
Message-ID: <641ba4f558ab671f67267343ae6411a4ea9bec26.1742478846.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742478846.git.lorenzo.stoakes@oracle.com>
References: <cover.1742478846.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY5PR10MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: 374c0461-1a60-4c75-ddf0-08dd68c3038b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2pino0XX9qmYYuYoqEzqddafFvEgYlHJqrtx2HhM7kgUH6S5ulnqqrmkDVnc?=
 =?us-ascii?Q?darxNMOdjWMtkoAIi+d3TM2VEySIgOpru+zM/oco9Qoo8j3+7+OqiPRhupeP?=
 =?us-ascii?Q?y8hpSpN7MvQ7pUrm0Q8mM0gR1RWHTKuLM6vf2O53fq6GFRNzaEM8uJrkw7cM?=
 =?us-ascii?Q?/JQLgXcKlUsC31B0iNmFuB2ebL3Z5NdfaPV8CtWrnB+rd7B4Gtogy0T4T19z?=
 =?us-ascii?Q?nmnPOEAZ46FKsBO3w0YImNtYLPYIb+284VnjqYnQEubMbp89AzIti9EOBT1m?=
 =?us-ascii?Q?jww8jvD+NjNvulZ+0ahAQS3KyjS+P9VFHmD+2LlUs10ScNVZDbkBM7B6E2B8?=
 =?us-ascii?Q?wgTth4ruaCmwLjEalZn20pFZS2DjttIDHJ4aY0O+SbJJHsNVnBnPjSN5gZBR?=
 =?us-ascii?Q?v7kwlYZbWJysxTK3nyv4i6YWm1lxbbVcI67l5Pq5VHx10N+OkO6kE6z0tyb8?=
 =?us-ascii?Q?NUFMA4uAT/Rw+bGWKGIYN8fGoCVPIMEJTLmTpaDyrOUxix0RuJGjLSsggDkG?=
 =?us-ascii?Q?96D9HMeDJOFbNuwKCR8YAo1u7JsrLPaaQnSOd8IGYyV9Gbevdu2cK9iGUp+0?=
 =?us-ascii?Q?uFffijS2wam9D6awrQFXXJXJ/ccTQFLFFgVmBLqtkpPz9+zmJ6u/9I0wFU45?=
 =?us-ascii?Q?g2NS1jsz58xMaha1Fi9iVYVSMI78USfu20Zj12FxgKf9KsW7Pppj51ECe0it?=
 =?us-ascii?Q?YVfmFMxgD2o5PSJQ+5PDgRMijRKVDNOw6p8TB9GPctfaIv8nqZXuv+kPptJA?=
 =?us-ascii?Q?6jg5GLMORMJTVgij4w5AvA3Yd3QemWhFXuZCPWE2Psn/nnqHXxiyq4/oAusw?=
 =?us-ascii?Q?ymbOaEran23iD57POWyUKytwu5kX45GBJMKwvK0H8WcgGg0cJi2NrsUo2TNw?=
 =?us-ascii?Q?gr2UySzhEnT+5R4iuKSrA9iibQz+H1XuMlxhnKZWdhIFx20O1IR50sVQHyf5?=
 =?us-ascii?Q?Fi+Kh4L3BjVO6jUE87K0Opk8SyIEClNRaslXdO+LnSfdZ0m66O+SrZolnTGt?=
 =?us-ascii?Q?O9eR0voUkQTHzUt7DF3b0qQqrxUvFekS1tWRuxQ8tfn/xuvX9oZuA1Qn5FPX?=
 =?us-ascii?Q?jT2SusTtVAYpwv/edVZnK6qAuv1Ie3oJHxfebbM2XHltpaO/3cqhpiB2+avI?=
 =?us-ascii?Q?Hbfe8ihIVqlqe82w/bg7b6yyvhlfr5I3tVPlvvyXGjgOd8LZV2zWsASNqTbg?=
 =?us-ascii?Q?+9mxLa5G6/kvlJoyJMH9eAB/WJNo4Guc50o7iBpI0HXLLKo2cKBTF5Y4QxWd?=
 =?us-ascii?Q?B/myciT9pVbT6GVDz9/M0AhaDXnXbvlTUf3IuAUzYSYl0aKhjf9UsEkP64FX?=
 =?us-ascii?Q?ZHWlCi3sd5P17Qh0Q09d6yQPqjCWxLMnyp5i2Z4yrvHj+GcW49/FWwKu3dNU?=
 =?us-ascii?Q?CPRM0l+MofHg/o1qljytYqSN8g8Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bJDnfP7t718KUaYZLp5+4XaNH4gary9tjpKyXFX/wVNQfDaZtJUEX4OKWvgl?=
 =?us-ascii?Q?bwQPWxssArm8cH+UXFQRSK6bgP8sjOzDRdOkV0uBCLRGQNQ+smZ/oc8l+Ds8?=
 =?us-ascii?Q?UrPELk3WLJ5UyKmm8IUMuOAWHjMJuZELaXyu8aSjjSMxJNDbZ+7g2lU+xccT?=
 =?us-ascii?Q?wUJYS9vQ0zEF6201DoUAMAR83y3BkxxRoZ/7K1pUYCmyIf8UHrxyqLVVbYWQ?=
 =?us-ascii?Q?c7UKkeLZ9riofei001/UntmYa44J+NZjXf1aj/eqosTEeKbBXLT4T1n1bFbm?=
 =?us-ascii?Q?DT3/c+ZV80InDKvp4zoD6rYTrVkmzWKALQMCed20r8w57NaXLnJ9QlBKYFQG?=
 =?us-ascii?Q?XL7908uMDakGynYvprCWjbxHOIaEKA4URVloRS8YJAvJXAWUJ/1Z/qNAwStu?=
 =?us-ascii?Q?2xrBAWE3mJno5+3DaQ6Y9Omhvlk4BppMorzrtyPHrTWSF9VuHVo9BLMbM0j2?=
 =?us-ascii?Q?6EGjxWOaaeP/6pqCd4Ju3dTwE2VaR8kLel40vrC4pvsyTd3vL9tLGKG5AEeu?=
 =?us-ascii?Q?sLj8rZqMEORa1lE8N/RwI/omxYHzpEUcjodp1i0SRr8es3U6H5Lcvj+fiowA?=
 =?us-ascii?Q?23NXUot6cJ7u9ptHZ34Afaj8nFuAIMcBgvvaJ6md74qoZOOgpx6b4Vesm6RN?=
 =?us-ascii?Q?ZPqTLWQAS2bIxzsS/dqTq+sXh1tCsmHHkyguDfltRvUpyfzByoT5sc82UrH/?=
 =?us-ascii?Q?3hGv4vtFzPRlrEnqNuT8SH2LZz1x1mv9s92z0CwpJrotptgaMrRx4yDqCULA?=
 =?us-ascii?Q?cs4WzbWmlpHwoaucjP1hZkMuo2157NcXFWODov79g7MveqNecoo4/v7ihy39?=
 =?us-ascii?Q?1QiqmhdMHJvGlctDZs4+nacEKIyRzQ3TUqxC2tuoTDxjU6EveJr2VVwr86x+?=
 =?us-ascii?Q?ZfOnCEUQ0l4iid9+kgsTKjZdcR4TDKZMt7ukvtq0InZ/Rie3sSCIQYs1NN8f?=
 =?us-ascii?Q?zYXRcic4r0/VW1oUfBljzSnAWZo93iIzUHqgKyV4P3ML1E7pHSc0JVtpP9UH?=
 =?us-ascii?Q?YTgknhVFOxVYQFCFKEviTtxbdvrEABV5HfH+lARmRoDOKStaAZje2z6EJZtM?=
 =?us-ascii?Q?51BUD+dd1pEZyxhghLGhB81VhjNukVKU0xH8db++X6nCoZDfaQi3n4bt4LDZ?=
 =?us-ascii?Q?apS/Kc3Ufi+gLz+AFU8Q6RCEhPyhEoK5V9bCSUiLBc0Cze6306P9Hv6U4hlE?=
 =?us-ascii?Q?HGSI6CGlhz7b82rIauIAl5+DIdThjPG4zmmffPYOGiYFlICkYTSOc1gIHIJv?=
 =?us-ascii?Q?nNDnLFOK8s/yWim/CgtngyX9hraDwMvROTKoA6IhLUNi0MtcI1VOwvbsW0/g?=
 =?us-ascii?Q?OoY0zHjkEg+X4PbzUE1b/+VK8yxth5i19ySaqmmw8hzw1qLbTB+3Cj7P32pZ?=
 =?us-ascii?Q?Ym++r2BL6h59yLa56m8+/FjQAkc2zwPR1duW4HieAmfAmnqgDvFhoG12/hyf?=
 =?us-ascii?Q?X24q1qg56CDRhezf4C6eOn//W4KnrYCWzkV9W/tW64ZsrvvgY+MViByGFzcv?=
 =?us-ascii?Q?6VvlCj3muNDOd7+/WzyMzMVfQWghlVbcoPhrD0UT1DJGCBTEJ2Pp2y8lYh3X?=
 =?us-ascii?Q?+HEHl2F0u9SYCyKPmpXVk1lSzQ0LRwNq2WUjoVFIuRXd2ZElZBbJPMv6JZsY?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tlcn8V1uQHl4+wiwNr2QvwsYj1u+dfcG47ijLfqdTIp9TPWIkPY54RkWw9HqGb8rHQmZTitH9ZacrvlsW9ijqgDb/fsEBncK9Oc5pDD0WvQ1M+/NOIgHF1oDUQRQVdmVpvZChNbCLG4Z0AE0UVCXEN5d4CS//ynn16JGk9IDDoI/d3dMf+oWxVLvjR8YZTvmkK/XrurnmbWLHsbxa8mqGSfAJN64GyMTnM3kUKoa0EZY6FrdORuAFqkd44r2uFqHxas5KH9Z0knzcV/0Yd+v+TJSi9UFnZYYpPF1IikiV1GnPoo59Ooi3PnzIjvwanAaNVq0NX/0/EyjNjBbi62Vc02DsU/bGOiILqe0XiMcBzoF0LWC6zz1aD53HReGUZnNyh8kjLGGEEre749j1gC4ocr+l5Z5v/vjjKQxhyNA8MP8y6ovVOnK64+FJIVw3vOM2/8FzzNppSOSvve4gN7Y7FZmYna97jtJbnkxIE7RDm+0YSHSV9xM5HTZZ6X1LDYASHtH8ULg7QW4abRF1qvXQS5tjJaz/K2ZJhcE1pNH+5EpIRe0rvsDzokSGNSS07pbXAxdOZdZ704qJOXBEGljp7fmQy8UUNtY5tIrjWck5rY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 374c0461-1a60-4c75-ddf0-08dd68c3038b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 21:54:54.5924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XXyVSL/hDN9SER300PqRMnMeyYib0Y+Ue1dJCoEIbW2/+//dLRWyzFyHUk8R+86sMJXAH6KfF3NyHPxSJRya0293dBg+msqRUVa3a7qXHL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6144
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_07,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=968
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503210160
X-Proofpoint-GUID: xeNBrisSgKjB2iIVZJpnrOKRGsr_RaBR
X-Proofpoint-ORIG-GUID: xeNBrisSgKjB2iIVZJpnrOKRGsr_RaBR

Use a direct system call version of mremap() as, when we move to using
MREMAP_[MUST_]RELOCATE_ANON, the glibc wrapper will disallow this.

Also import linux/mman.h (which will amount to the local tools cache of
mman.h) to enusre these header values are available when later added.

Then, add tests asserting all the mremap() merge cases that function
correctly without MREMAP_[MUST_]RELOCATE_ANON.

This constitutes moving around unfaulted VMAs and moving around faulted
VMAs back into position immediately adjacent to VMAs also faulted in with
that moved VMA.

By doing so we provide a baseline set of expectations on mremap()
operations and VMA merge which we can expand upon for
MREMAP_[MUST_]RELOCATE_ANON cases in a subsequent commit.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/mm/merge.c | 608 ++++++++++++++++++++++++++++-
 1 file changed, 606 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/merge.c b/tools/testing/selftests/mm/merge.c
index 9cc61bdbfba8..7c4f3f93c30d 100644
--- a/tools/testing/selftests/mm/merge.c
+++ b/tools/testing/selftests/mm/merge.c
@@ -8,6 +8,16 @@
 #include <sys/mman.h>
 #include <sys/wait.h>
 #include "vm_util.h"
+#include <linux/mman.h>
+#include <sys/syscall.h>
+
+static void *sys_mremap(void *old_address, unsigned long old_size,
+			unsigned long new_size, int flags, void *new_address)
+{
+	return (void *)syscall(__NR_mremap, (unsigned long)old_address,
+			       old_size, new_size, flags,
+			       (unsigned long)new_address);
+}
 
 FIXTURE(merge)
 {
@@ -20,7 +30,7 @@ FIXTURE_SETUP(merge)
 {
 	self->page_size = psize();
 	/* Carve out PROT_NONE region to map over. */
-	self->carveout = mmap(NULL, 12 * self->page_size, PROT_NONE,
+	self->carveout = mmap(NULL, 30 * self->page_size, PROT_NONE,
 			      MAP_ANON | MAP_PRIVATE, -1, 0);
 	ASSERT_NE(self->carveout, MAP_FAILED);
 	/* Setup PROCMAP_QUERY interface. */
@@ -29,7 +39,7 @@ FIXTURE_SETUP(merge)
 
 FIXTURE_TEARDOWN(merge)
 {
-	ASSERT_EQ(munmap(self->carveout, 12 * self->page_size), 0);
+	ASSERT_EQ(munmap(self->carveout, 30 * self->page_size), 0);
 	ASSERT_EQ(close_procmap(&self->procmap), 0);
 }
 
@@ -451,4 +461,598 @@ TEST_F(merge, forked_source_vma)
 	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr2 + 5 * page_size);
 }
 
+TEST_F(merge, mremap_unfaulted_to_faulted)
+{
+	unsigned int page_size = self->page_size;
+	char *carveout = self->carveout;
+	struct procmap_fd *procmap = &self->procmap;
+	char *ptr, *ptr2;
+
+	/*
+	 * Map two distinct areas:
+	 *
+	 * |-----------|  |-----------|
+	 * | unfaulted |  | unfaulted |
+	 * |-----------|  |-----------|
+	 *      ptr            ptr2
+	 */
+	ptr = mmap(&carveout[page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ptr2 = mmap(&carveout[7 * page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/* Offset ptr2 further away. */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, ptr2 + page_size * 1000);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/*
+	 * Fault in ptr:
+	 *                \
+	 * |-----------|  /  |-----------|
+	 * |  faulted  |  \  | unfaulted |
+	 * |-----------|  /  |-----------|
+	 *      ptr       \       ptr2
+	 */
+	ptr[0] = 'x';
+
+	/*
+	 * Now move ptr2 adjacent to ptr:
+	 *
+	 * |-----------|-----------|
+	 * |  faulted  | unfaulted |
+	 * |-----------|-----------|
+	 *      ptr         ptr2
+	 *
+	 * It should merge:
+	 *
+	 * |----------------------|
+	 * |       faulted        |
+	 * |----------------------|
+	 *            ptr
+	 */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, &ptr[5 * page_size]);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 10 * page_size);
+}
+
+TEST_F(merge, mremap_unfaulted_behind_faulted)
+{
+	unsigned int page_size = self->page_size;
+	char *carveout = self->carveout;
+	struct procmap_fd *procmap = &self->procmap;
+	char *ptr, *ptr2;
+
+	/*
+	 * Map two distinct areas:
+	 *
+	 * |-----------|  |-----------|
+	 * | unfaulted |  | unfaulted |
+	 * |-----------|  |-----------|
+	 *      ptr            ptr2
+	 */
+	ptr = mmap(&carveout[6 * page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ptr2 = mmap(&carveout[14 * page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/* Offset ptr2 further away. */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, ptr2 + page_size * 1000);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/*
+	 * Fault in ptr:
+	 *                \
+	 * |-----------|  /  |-----------|
+	 * |  faulted  |  \  | unfaulted |
+	 * |-----------|  /  |-----------|
+	 *      ptr       \       ptr2
+	 */
+	ptr[0] = 'x';
+
+	/*
+	 * Now move ptr2 adjacent, but behind, ptr:
+	 *
+	 * |-----------|-----------|
+	 * | unfaulted |  faulted  |
+	 * |-----------|-----------|
+	 *      ptr2        ptr
+	 *
+	 * It should merge:
+	 *
+	 * |----------------------|
+	 * |       faulted        |
+	 * |----------------------|
+	 *            ptr2
+	 */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, &carveout[page_size]);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr2));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr2);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr2 + 10 * page_size);
+}
+
+TEST_F(merge, mremap_unfaulted_between_faulted)
+{
+	unsigned int page_size = self->page_size;
+	char *carveout = self->carveout;
+	struct procmap_fd *procmap = &self->procmap;
+	char *ptr, *ptr2, *ptr3;
+
+	/*
+	 * Map three distinct areas:
+	 *
+	 * |-----------|  |-----------|  |-----------|
+	 * | unfaulted |  | unfaulted |  | unfaulted |
+	 * |-----------|  |-----------|  |-----------|
+	 *      ptr            ptr2           ptr3
+	 */
+	ptr = mmap(&carveout[page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ptr2 = mmap(&carveout[7 * page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+	ptr3 = mmap(&carveout[14 * page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr3, MAP_FAILED);
+
+	/* Offset ptr3 further away. */
+	ptr3 = sys_mremap(ptr3, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, ptr3 + page_size * 2000);
+	ASSERT_NE(ptr3, MAP_FAILED);
+
+	/* Offset ptr2 further away. */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, ptr2 + page_size * 1000);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/*
+	 * Fault in ptr, ptr3:
+	 *                \                 \
+	 * |-----------|  /  |-----------|  /  |-----------|
+	 * |  faulted  |  \  | unfaulted |  \  |  faulted  |
+	 * |-----------|  /  |-----------|  /  |-----------|
+	 *      ptr       \       ptr2      \       ptr3
+	 */
+	ptr[0] = 'x';
+	ptr3[0] = 'x';
+
+	/*
+	 * Move ptr3 back into place, leaving a place for ptr2:
+	 *                                        \
+	 * |-----------|           |-----------|  /  |-----------|
+	 * |  faulted  |           |  faulted  |  \  | unfaulted |
+	 * |-----------|           |-----------|  /  |-----------|
+	 *      ptr                     ptr3      \       ptr2
+	 */
+	ptr3 = sys_mremap(ptr3, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, &ptr[10 * page_size]);
+	ASSERT_NE(ptr3, MAP_FAILED);
+
+	/*
+	 * Finally, move ptr2 into place:
+	 *
+	 * |-----------|-----------|-----------|
+	 * |  faulted  | unfaulted |  faulted  |
+	 * |-----------|-----------|-----------|
+	 *      ptr        ptr2         ptr3
+	 *
+	 * It should merge, but only ptr, ptr2:
+	 *
+	 * |-----------------------|-----------|
+	 * |        faulted        | unfaulted |
+	 * |-----------------------|-----------|
+	 */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, &ptr[5 * page_size]);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 10 * page_size);
+
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr3));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr3);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr3 + 5 * page_size);
+}
+
+TEST_F(merge, mremap_unfaulted_between_faulted_unfaulted)
+{
+	unsigned int page_size = self->page_size;
+	char *carveout = self->carveout;
+	struct procmap_fd *procmap = &self->procmap;
+	char *ptr, *ptr2, *ptr3;
+
+	/*
+	 * Map three distinct areas:
+	 *
+	 * |-----------|  |-----------|  |-----------|
+	 * | unfaulted |  | unfaulted |  | unfaulted |
+	 * |-----------|  |-----------|  |-----------|
+	 *      ptr            ptr2           ptr3
+	 */
+	ptr = mmap(&carveout[page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ptr2 = mmap(&carveout[7 * page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+	ptr3 = mmap(&carveout[14 * page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr3, MAP_FAILED);
+
+	/* Offset ptr3 further away. */
+	ptr3 = sys_mremap(ptr3, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, ptr3 + page_size * 2000);
+	ASSERT_NE(ptr3, MAP_FAILED);
+
+
+	/* Offset ptr2 further away. */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, ptr2 + page_size * 1000);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/*
+	 * Fault in ptr:
+	 *                \                 \
+	 * |-----------|  /  |-----------|  /  |-----------|
+	 * |  faulted  |  \  | unfaulted |  \  | unfaulted |
+	 * |-----------|  /  |-----------|  /  |-----------|
+	 *      ptr       \       ptr2      \       ptr3
+	 */
+	ptr[0] = 'x';
+
+	/*
+	 * Move ptr3 back into place, leaving a place for ptr2:
+	 *                                        \
+	 * |-----------|           |-----------|  /  |-----------|
+	 * |  faulted  |           | unfaulted |  \  | unfaulted |
+	 * |-----------|           |-----------|  /  |-----------|
+	 *      ptr                     ptr3      \       ptr2
+	 */
+	ptr3 = sys_mremap(ptr3, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, &ptr[10 * page_size]);
+	ASSERT_NE(ptr3, MAP_FAILED);
+
+	/*
+	 * Finally, move ptr2 into place:
+	 *
+	 * |-----------|-----------|-----------|
+	 * |  faulted  | unfaulted | unfaulted |
+	 * |-----------|-----------|-----------|
+	 *      ptr        ptr2         ptr3
+	 *
+	 * It should merge:
+	 *
+	 * |-----------------------------------|
+	 * |              faulted              |
+	 * |-----------------------------------|
+	 */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, &ptr[5 * page_size]);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 15 * page_size);
+}
+
+TEST_F(merge, mremap_unfaulted_between_correctly_placed_faulted)
+{
+	unsigned int page_size = self->page_size;
+	char *carveout = self->carveout;
+	struct procmap_fd *procmap = &self->procmap;
+	char *ptr, *ptr2;
+
+	/*
+	 * Map one larger area:
+	 *
+	 * |-----------------------------------|
+	 * |            unfaulted              |
+	 * |-----------------------------------|
+	 */
+	ptr = mmap(&carveout[page_size], 15 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/*
+	 * Fault in ptr:
+	 *
+	 * |-----------------------------------|
+	 * |              faulted              |
+	 * |-----------------------------------|
+	 */
+	ptr[0] = 'x';
+
+	/*
+	 * Unmap middle:
+	 *
+	 * |-----------|           |-----------|
+	 * |  faulted  |           |  faulted  |
+	 * |-----------|           |-----------|
+	 *
+	 * Now the faulted areas are compatible with each other (anon_vma the
+	 * same, vma->vm_pgoff equal to virtual page offset).
+	 */
+	ASSERT_EQ(munmap(&ptr[5 * page_size], 5 * page_size), 0);
+
+	/*
+	 * Map a new area, ptr2:
+	 *                                        \
+	 * |-----------|           |-----------|  /  |-----------|
+	 * |  faulted  |           |  faulted  |  \  | unfaulted |
+	 * |-----------|           |-----------|  /  |-----------|
+	 *      ptr                               \       ptr2
+	 */
+	ptr2 = mmap(&carveout[20 * page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/*
+	 * Finally, move ptr2 into place:
+	 *
+	 * |-----------|-----------|-----------|
+	 * |  faulted  | unfaulted |  faulted  |
+	 * |-----------|-----------|-----------|
+	 *      ptr        ptr2         ptr3
+	 *
+	 * It should merge:
+	 *
+	 * |-----------------------------------|
+	 * |              faulted              |
+	 * |-----------------------------------|
+	 */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, &ptr[5 * page_size]);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 15 * page_size);
+}
+
+TEST_F(merge, mremap_correct_placed_faulted)
+{
+	unsigned int page_size = self->page_size;
+	char *carveout = self->carveout;
+	struct procmap_fd *procmap = &self->procmap;
+	char *ptr, *ptr2, *ptr3;
+
+	/*
+	 * Map one larger area:
+	 *
+	 * |-----------------------------------|
+	 * |            unfaulted              |
+	 * |-----------------------------------|
+	 */
+	ptr = mmap(&carveout[page_size], 15 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/*
+	 * Fault in ptr:
+	 *
+	 * |-----------------------------------|
+	 * |              faulted              |
+	 * |-----------------------------------|
+	 */
+	ptr[0] = 'x';
+
+	/*
+	 * Offset the final and middle 5 pages further away:
+	 *                \                 \
+	 * |-----------|  /  |-----------|  /  |-----------|
+	 * |  faulted  |  \  |  faulted  |  \  |  faulted  |
+	 * |-----------|  /  |-----------|  /  |-----------|
+	 *      ptr       \       ptr2      \       ptr3
+	 */
+	ptr3 = &ptr[10 * page_size];
+	ptr3 = sys_mremap(ptr3, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, ptr3 + page_size * 2000);
+	ASSERT_NE(ptr3, MAP_FAILED);
+	ptr2 = &ptr[5 * page_size];
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, ptr2 + page_size * 1000);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/*
+	 * Move ptr2 into its correct place:
+	 *                            \
+	 * |-----------|-----------|  /  |-----------|
+	 * |  faulted  |  faulted  |  \  |  faulted  |
+	 * |-----------|-----------|  /  |-----------|
+	 *      ptr         ptr2      \       ptr3
+	 *
+	 * It should merge:
+	 *                            \
+	 * |-----------------------|  /  |-----------|
+	 * |        faulted        |  \  |  faulted  |
+	 * |-----------------------|  /  |-----------|
+	 *            ptr             \       ptr3
+	 */
+
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, &ptr[5 * page_size]);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 10 * page_size);
+
+	/*
+	 * Now move ptr out of place:
+	 *                            \                 \
+	 *             |-----------|  /  |-----------|  /  |-----------|
+	 *             |  faulted  |  \  |  faulted  |  \  |  faulted  |
+	 *             |-----------|  /  |-----------|  /  |-----------|
+	 *                  ptr2      \       ptr       \       ptr3
+	 */
+	ptr = sys_mremap(ptr, 5 * page_size, 5 * page_size,
+			 MREMAP_MAYMOVE | MREMAP_FIXED, ptr + page_size * 1000);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/*
+	 * Now move ptr back into place:
+	 *                            \
+	 * |-----------|-----------|  /  |-----------|
+	 * |  faulted  |  faulted  |  \  |  faulted  |
+	 * |-----------|-----------|  /  |-----------|
+	 *      ptr         ptr2      \       ptr3
+	 *
+	 * It should merge:
+	 *                            \
+	 * |-----------------------|  /  |-----------|
+	 * |        faulted        |  \  |  faulted  |
+	 * |-----------------------|  /  |-----------|
+	 *            ptr             \       ptr3
+	 */
+	ptr = sys_mremap(ptr, 5 * page_size, 5 * page_size,
+			 MREMAP_MAYMOVE | MREMAP_FIXED, &carveout[page_size]);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 10 * page_size);
+
+	/*
+	 * Now move ptr out of place again:
+	 *                            \                 \
+	 *             |-----------|  /  |-----------|  /  |-----------|
+	 *             |  faulted  |  \  |  faulted  |  \  |  faulted  |
+	 *             |-----------|  /  |-----------|  /  |-----------|
+	 *                  ptr2      \       ptr       \       ptr3
+	 */
+	ptr = sys_mremap(ptr, 5 * page_size, 5 * page_size,
+			 MREMAP_MAYMOVE | MREMAP_FIXED, ptr + page_size * 1000);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/*
+	 * Now move ptr3 back into place:
+	 *                                        \
+	 *             |-----------|-----------|  /  |-----------|
+	 *             |  faulted  |  faulted  |  \  |  faulted  |
+	 *             |-----------|-----------|  /  |-----------|
+	 *                  ptr2        ptr3      \       ptr
+	 *
+	 * It should merge:
+	 *                                        \
+	 *             |-----------------------|  /  |-----------|
+	 *             |        faulted        |  \  |  faulted  |
+	 *             |-----------------------|  /  |-----------|
+	 *                        ptr2            \       ptr
+	 */
+	ptr3 = sys_mremap(ptr3, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, &ptr2[5 * page_size]);
+	ASSERT_NE(ptr3, MAP_FAILED);
+
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr2));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr2);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr2 + 10 * page_size);
+
+	/*
+	 * Now move ptr back into place:
+	 *
+	 * |-----------|-----------------------|
+	 * |  faulted  |        faulted        |
+	 * |-----------|-----------------------|
+	 *      ptr               ptr2
+	 *
+	 * It should merge:
+	 *
+	 * |-----------------------------------|
+	 * |              faulted              |
+	 * |-----------------------------------|
+	 *                  ptr
+	 */
+	ptr = sys_mremap(ptr, 5 * page_size, 5 * page_size,
+			 MREMAP_MAYMOVE | MREMAP_FIXED, &carveout[page_size]);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 15 * page_size);
+
+	/*
+	 * Now move ptr2 out of the way:
+	 *                                        \
+	 * |-----------|           |-----------|  /  |-----------|
+	 * |  faulted  |           |  faulted  |  \  |  faulted  |
+	 * |-----------|           |-----------|  /  |-----------|
+	 *      ptr                     ptr3      \       ptr2
+	 */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, ptr2 + page_size * 1000);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/*
+	 * Now move it back:
+	 *
+	 * |-----------|-----------|-----------|
+	 * |  faulted  |  faulted  |  faulted  |
+	 * |-----------|-----------|-----------|
+	 *      ptr         ptr2        ptr3
+	 *
+	 * It should merge:
+	 *
+	 * |-----------------------------------|
+	 * |              faulted              |
+	 * |-----------------------------------|
+	 *                  ptr
+	 */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, &ptr[5 * page_size]);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 15 * page_size);
+
+	/*
+	 * Move ptr3 out of place:
+	 *                                        \
+	 * |-----------------------|              /  |-----------|
+	 * |        faulted        |              \  |  faulted  |
+	 * |-----------------------|              /  |-----------|
+	 *            ptr                         \       ptr3
+	 */
+	ptr3 = sys_mremap(ptr3, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, ptr3 + page_size * 1000);
+	ASSERT_NE(ptr3, MAP_FAILED);
+
+	/*
+	 * Now move it back:
+	 *
+	 * |-----------|-----------|-----------|
+	 * |  faulted  |  faulted  |  faulted  |
+	 * |-----------|-----------|-----------|
+	 *      ptr         ptr2        ptr3
+	 *
+	 * It should merge:
+	 *
+	 * |-----------------------------------|
+	 * |              faulted              |
+	 * |-----------------------------------|
+	 *                  ptr
+	 */
+	ptr3 = sys_mremap(ptr3, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, &ptr[10 * page_size]);
+	ASSERT_NE(ptr3, MAP_FAILED);
+
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 15 * page_size);
+}
+
 TEST_HARNESS_MAIN
-- 
2.48.1


