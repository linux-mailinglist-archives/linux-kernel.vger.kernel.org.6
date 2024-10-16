Return-Path: <linux-kernel+bounces-368703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B1E9A13AF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2577281DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A28D215026;
	Wed, 16 Oct 2024 20:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SkfIZHGh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fSPNfTLw"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3B91C07C7
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 20:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109887; cv=fail; b=Z0RAjyUwPELo3Hg13XvsBQ23bLN3cKwgKALvGqhVqTrK2YynOHbNX2a6xXMDxUVRCX36MjmvX3GcjY/bF6uyRP6QpJWUVWsO5ZmqjZGVsqT0GY3p9pwYqQ1wG8BWADkt9kF73HeqsLh9jCJ8kr0NUenEym0GBjwpfoBSQNh8RXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109887; c=relaxed/simple;
	bh=vs6KPKSbk89nYmyCr17K33YMzOwu8q5kCx+CUzqMgRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o/SXE5wS94Hhf+LtJIRugFcOOGXOHckcYigYwuniYsXNuXGHaTrRFtimlczGA17gIm+1ph7VscPLsuqBQ7OT9SMHBHk0Qew0gl6TEi4XG+rWnJY9fr783dxjxnmUDug6yuyn9jACndHWi1xPGZqmVeY+Oc4WwFlipP5n4NFG6ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SkfIZHGh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fSPNfTLw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GHthie009856;
	Wed, 16 Oct 2024 20:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=PuPaBazg2N1hxGMrBWUR5Bk0SIqeJho3EXvfR58ZJtw=; b=
	SkfIZHGh0FvYqbDNN9m6G06GLM6Z4b0YOKVGmY+faw0jdXgMJouml3obyaipbqJC
	jjtpZ87SvpWSDx1XzbaBPFbyYaqGRJKdensu3sXyMHjVmACKeFf2FROzmWHfr5wj
	gcpoWcWdGLEvzHIh1eIDQCrOg7j/gsXqjd43wEj7y/gTC9FUlwWnEr3fSsD2wPrB
	xmEAatGiKIAZuUqpI6Q12MuijlgmFqorXnI4nx3jF9Cxw4o2NGJXZSJgIujHgNQ6
	rc7EEsz+/m2Xr+nPhT4DJInGcej3ApWX2574SGRJVsmEXUM6KcQmhuqoAXgaY/ED
	9bgGCzoPIsVXwRweFoP8Ew==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5cn4h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 20:17:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49GIgMdY026420;
	Wed, 16 Oct 2024 20:17:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj9b8eg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 20:17:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8VMyEuc9rSs82JPmDTepyQcaJVX5Xi6l7VfcMAznDpI1gWRDxNM5MlVVlJD9qxXclNwvifzprNncccpESVZJawZeawCORiGu68Zl4Q0Er9RDw6yVH/FCrhFOEhlt932RR4A1picKIFKT97ncYt6trb8WXZlNqrvQUPlaR//yv4Rlt/MaAUzakYkVTpcOvDnNXsSogA0sdiuVBkkfYGmuIRX6M5r4nzkfQRVuu7VKndEKPpdtxuTJJbNN0Y74r3iqMSQqUzxNAPUSTHG4P/ao1ovMlgsXrt56rPhMxwwbCWDqiv5uveIYcsUzKo0mGpnYlixE1Hjv87fJ41qeBuYug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuPaBazg2N1hxGMrBWUR5Bk0SIqeJho3EXvfR58ZJtw=;
 b=TWuIPiXfc6JsiGrWhIhCDEOmjYduvLFvOnMBD/E2pVRgAe2ysZ1/Yz+bsmuOvhxVQ1z05HZfPsegwzSGiMgT9IO8GbZsRXPkYHd2q+7EjYbKTIlaOKi6188TuwENiL2djtwlOWzHw+U0/c31M53/ygBnJZZnzd6l9vrWZJPlann1ctG/a2fzKMRgKd4ryLXsM2lEkgyxTABrBYvTgoS5YNaanVNewlfFGOFJH8koPzAiz4K9r9MTkFPQ9y9A5JHYa7UqwFpUCWfDraOT8TYagUUopOC9xnTnbYRmt4QW5K6dN6evdpuUA2/BOd0SnjCqeV/L7Z4CyHxImbPoJvaxZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuPaBazg2N1hxGMrBWUR5Bk0SIqeJho3EXvfR58ZJtw=;
 b=fSPNfTLwBgQ6gG26v8rhfSusoRfTm49FOpH4ao75/2BlqYcCv1tD0fP9/5FqmFuvNbJfltb0VCpefGAIbqHK8ou6PfyxP1Oj7hfaNu9G+dDTxXebHuNhhfZteMOKUW0LI6eINNMn5BXSUwsswHny0gfRvSNkNJElrY6gvMHGpsE=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA0PR10MB7579.namprd10.prod.outlook.com (2603:10b6:208:493::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Wed, 16 Oct
 2024 20:17:39 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 20:17:39 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Jann Horn <jannh@google.com>, David Hildenbrand <david@redhat.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jeff Xu <jeffxu@chromium.org>, Pedro Falcato <pedro.falcato@gmail.com>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH 1/2] mm/mremap: Clean up vma_to_resize()
Date: Wed, 16 Oct 2024 16:17:17 -0400
Message-ID: <20241016201719.2449143-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016201719.2449143-1-Liam.Howlett@oracle.com>
References: <20241016201719.2449143-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0113.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::16) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA0PR10MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: e94b05e5-2f94-4296-53b5-08dcee1f9542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4CHPm5HspxjH6LKHxxFqtAYZUd4T8hqN/t/QthchO3qoeWcm0cY8jmQdrpxk?=
 =?us-ascii?Q?2yS5BbceYogusCgHXkWijFAaKGLGvdgESJsD8I5HAanLsnjpfqT+gjDP8eKt?=
 =?us-ascii?Q?CN7tCR1AKQzvSX7NBRcuWWQAUC7F7Tb7h77tgLBREGW0T6Qn43rIybv7znbN?=
 =?us-ascii?Q?gqEqumLvHlF+wKpYUY9fW43Cs80ERMV/uRoFn7gNQ/tBqEndBoGHsxCYMdZf?=
 =?us-ascii?Q?ODfAtbKeGDcOchcJCb092Letydjet7GIZlfQBSrnusrLAkQ6aTISKzvT7EMy?=
 =?us-ascii?Q?XsfVjltz+zDhpelgbRnwSoNUIYyzD8Vw52NfobUFXN9Oo7w1coS2OOWtlKd8?=
 =?us-ascii?Q?a78CJWBP+COmxCj52VM2AlQtCeujYJY8RZEkt1N5pHhvVpwR80+xS5WL9RLU?=
 =?us-ascii?Q?y9hyyfzq3Fbb+e6oNw62aOW4Q6eaLehMiFRlU7pvdrTukQ7hdEfI3ZcTqMw4?=
 =?us-ascii?Q?KlklftoNYkTcbIOTx0MdenXizGQBez1VSBzkhVq8MVKP6vhb2bb2WMy3CDNg?=
 =?us-ascii?Q?TIJyUl5m/1NDwb/R2PHTFqWnkyvxvj0LfR7M5SAzW3ASq6qCgZ8EWNAlCFqL?=
 =?us-ascii?Q?OHDGgua4ABPAVomOd9l7h9qrNijNRWElfvlbBUosbKqiIMj/tIH6jaDwJtKq?=
 =?us-ascii?Q?ucgDGUtJM18/k/qd0f7lt8+K9MHuzQxxW5jIkc8jv/0wlg2euUg4McSGCgbt?=
 =?us-ascii?Q?ExbSDreyPy2QF66ROVJL7utZbmSdTSPq2aOyFKIitL3kUYIv6EQ2/yC/9uaY?=
 =?us-ascii?Q?gB8GPdm2EvxxpSCb+Cz3O0IJYh5nTgjyjvKNyltyr2YFTYbjlIc9wzHiazz9?=
 =?us-ascii?Q?kXZTsssQ7soKfeYq2dYJo9zFh8WIZwWNHjNQCbnkRAjoj+3to/uwih51QHWj?=
 =?us-ascii?Q?hz1yLEduWqd5ouYMaYawFFXAHuPfce5ISKKY7pIUp7lwexnsmvEP96A4zBM2?=
 =?us-ascii?Q?piiD2RLPT0SalLaDi7GtkM2V9HmO6bjbO67hz4RePhk7uFWnuHdcSjnSaFxG?=
 =?us-ascii?Q?GAGSnEXRyIi+Q8XWjl+0Ue1ClgNKJsmIeCY/6i0w1MYqtqAir5aFqaXABRJK?=
 =?us-ascii?Q?vjCDIpM8SoQUr2Iop4SpHdn3Z4hvLoWASzI/ZBiD7LX80HhTGk1nqeSRklCE?=
 =?us-ascii?Q?VmWjYFbLuLTqiO4KUQBRZDAKBkaJeCU29aDuRoza80HM0cDLk4495ijVe+5A?=
 =?us-ascii?Q?7mcjqbQ7DvuCbvFGe55Slqoos4eutfAzql1IvpotztIMkiGTnm//THvNS0T4?=
 =?us-ascii?Q?rgyoZ5mex2CuM4gvVB195HLPp1FxORuFSclWTSfJHHlL1BVyNlRnP5UwglOy?=
 =?us-ascii?Q?4QUWvIDjlDec/1cHm8v4gNpM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D5PJMXtBWu1X7HB8hsOlJmHv/KLYElcntLJRc2xtO3I8u1WkaqsoHTuVSk02?=
 =?us-ascii?Q?QgKeU08ZX38PbeoHwZ9tIdM3HG2V4zhG/QlGhnfu+WUBkDMARpusIhixeXcQ?=
 =?us-ascii?Q?0o3S/BmeEK+LiB/7u5sa9eKYWGjJSZTkJOMtt7X/aXePqcfeL8uY2y4T8bBD?=
 =?us-ascii?Q?LD6BkGcLWREvOlo+X7LaBGDqqJcVKv9kkMZERi5kLmmhlTe1dlIK9mQiiFPU?=
 =?us-ascii?Q?ViDwgkOA9zvcvcXET4o4vmTWxEsOj313eOcz6ASM+FN6gN+o7w2ubcFgZn8q?=
 =?us-ascii?Q?IDbcvJ6H82nTNyRgatZZcWDZ7WcCCvnyf5qCHFl+nnBxTsLBzH6ERdy0SDlA?=
 =?us-ascii?Q?vUSyifXGzsNejHH4CIul65SrWSDwJp46gqbWX6AxF7pAphpuQARIVtUGTg+6?=
 =?us-ascii?Q?GtuAB2yBA4qYWP4byFdRaJnQHmunJZNYb/2f+Nw9MNhbsZAm0yJ6Rbh/e9v2?=
 =?us-ascii?Q?VMRh4uYZLE1Mb/V8+na18RzFTYn0nsf4235w25PrmVbhVrvgwZmEMoVe8wTu?=
 =?us-ascii?Q?0kbUZWOGi5KZb2km1bC6/pVGDRPZsXL7z3w1dWn13QC0Gk2AbBn0klttZbhL?=
 =?us-ascii?Q?e/xH+qHfFrKqrMh5/UrDBVYNaJHophwqwI3nuUfppKAmxHFD1xAi4p6A1QC5?=
 =?us-ascii?Q?atv2Q3g7N0tPRfMfChyV2ZvZOu7hAMGfeWiLv7OkkyaiwYkM8svdU5MLC0Bg?=
 =?us-ascii?Q?XnWYZJOK/CVc/lnrLpOy6WnNvJczJKQxmw7SdWf7zW0xwyU32aorUYmNqhU0?=
 =?us-ascii?Q?K4ByUCiatmw4GGT9zCyF5zmZCpTa5rKUlYJOSp2PcyCMVRw4tpWy54GxR0jL?=
 =?us-ascii?Q?D8jKyvBSUnGUlxax+0hCoqzn/+AgvuZIovVAB5zh6ae5MLpKdyh8cZeMnAnK?=
 =?us-ascii?Q?46fpDNuns+FrngJAUEQK2mZL5lSQTeHkXUpsS9BZd76tNVFYy/l1JmgEhyY7?=
 =?us-ascii?Q?tF9oLio4lKj8G3tEgNptqNVyqZ4Z2LzVyhXkaqPJD9ZDf+90uljSJ0y3YEqi?=
 =?us-ascii?Q?4ot7/MPeEhaxLkvu2LE9Mv+Jblq5NxZRKEBKk3kaEIutVWvMZXp1mE0Skg42?=
 =?us-ascii?Q?2Wxyk3K4otXQMPlHiWX3Wkt4ZphSgnMQ/hQVpPNc1t8zkAfeWqhaL0N6oAWC?=
 =?us-ascii?Q?b3s99QFWElOh6CiwIoMYMlF/iTcVEltoEy04gf+O21H94Q4UqK1BbT3c05wc?=
 =?us-ascii?Q?HSMPrm82wDZzcMMeWcOZMI+rJ3QUBjhaZ76IqiKa0kGZ7Nz4pn7H2lExkpd2?=
 =?us-ascii?Q?3X832xx8vNxMP4NR5Tgdjat58a/32q7GyMegA9NYGlb3HeWfcoz1zsC+BRXg?=
 =?us-ascii?Q?3/axzIqG2BTunZ/oZSHS7uvysPr/lwcIerBCcmyarjtQBBOZCuvCL5Xzd+ur?=
 =?us-ascii?Q?EXbi2TLhYfreelDs3sHt7/SH1kGiz58FZBVLhyzHSA1RpGWG3Aaw11g6Nf0b?=
 =?us-ascii?Q?z6LhuALIJ3EF73qdJxQoYv7A+Kj6q7rOTm+VeR/M/QAUmGP9m6IkzfmLWFfi?=
 =?us-ascii?Q?6cZVp6aICGlK+RbtPdrsne5EDkzKudqQKRdJfeWB14xN/eLQGlAgDGRx7s9L?=
 =?us-ascii?Q?0lnP3pQeRBOzDMXlF1qw1HnoJ6vMm/EjqMrSBrmKPurOnBLOEipLeBNGaBU7?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YJW63G3iOmmM8QeUxg9+B4iKj/1CJJp33btOyrrhLBdkN8acoI8S2dKHBhVWmWy/If/1qWhnd+dLPwKqUsJTB/dMuZWrUCihWREUyaispgsfeBonRmk5jzIyJ+5lOdgujmwJbP8JiE6Ubu4/NC9Bs2Grl/g4ql7h637YnCLvpqkU1v4ZqthfGlqj9zUfllSGGAf2zV7p+1o1GPUVR/XPzJHiDkiUuTlWJ0gmA6aKdBzD7TApJa8iUfthsrUaafm9zSolFfZqkEfpOThnVtXEKINDwcf9oDxe53ged5IMOYLLBRGCEM7lyBzd24nzdh74eQStx86pkxws45m9ZvrYW/Ub6/RXjILieIBb6T03+0gfR/xGnbyXzV2yhpopOrmXsRnbNCH4Hc3OvGyX20AxeENjD7UadDcPIbyzKCCF1vf7B/Yd4aXYkGjtRK4d7mmnZTHd6WaRGK+/YGSpBlQMb/uUix6FZ0tWw/1ye343ZH3+aB4dMGIzFLEBfTS83nanzXEWjTnnveWXU5/H+Or+vr0oFlmbVDh7lqG36IMLEJGljjowkswaQ1nRcqT/DqXuivSCOt3jtynzFZUQCPJnjuEWzfcF3NPjNOdDCXVnlpo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e94b05e5-2f94-4296-53b5-08dcee1f9542
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 20:17:39.6300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOz7DkEoHi7LBnxfu4T8e+Vqglrx1HyoWVEILtp2SteENFfgweUANKH85OVfcW7NaRaXEyAJQyxCqctMyss4+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7579
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_16,2024-10-16_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410160128
X-Proofpoint-ORIG-GUID: sCl0bjDB6H6qpZOU78KTiYjeOtPelN3o
X-Proofpoint-GUID: sCl0bjDB6H6qpZOU78KTiYjeOtPelN3o

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

vma_to_resize() is used in two locations to find and validate the vma
for the mremap location.  One of the two locations already has the vma,
which is then re-found to validate the same vma.

This code can be simplified by moving the vma_lookup() from
vma_to_resize() to mremap_to() and changing the return type to an int
error.

Since the function now just validates the vma, the function is renamed
to mremap_vma_check() to better reflect what it is doing.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mremap.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 5917feafe8cc..648c29f568af 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -826,17 +826,12 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	return new_addr;
 }
 
-static struct vm_area_struct *vma_to_resize(unsigned long addr,
+static int mremap_vma_check(struct vm_area_struct *vma, unsigned long addr,
 	unsigned long old_len, unsigned long new_len, unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
 	unsigned long pgoff;
 
-	vma = vma_lookup(mm, addr);
-	if (!vma)
-		return ERR_PTR(-EFAULT);
-
 	/*
 	 * !old_len is a special case where an attempt is made to 'duplicate'
 	 * a mapping.  This makes no sense for private mappings as it will
@@ -847,37 +842,37 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
 	 */
 	if (!old_len && !(vma->vm_flags & (VM_SHARED | VM_MAYSHARE))) {
 		pr_warn_once("%s (%d): attempted to duplicate a private mapping with mremap.  This is not supported.\n", current->comm, current->pid);
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	}
 
 	if ((flags & MREMAP_DONTUNMAP) &&
 			(vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	/* We can't remap across vm area boundaries */
 	if (old_len > vma->vm_end - addr)
-		return ERR_PTR(-EFAULT);
+		return -EFAULT;
 
 	if (new_len == old_len)
-		return vma;
+		return 0;
 
 	/* Need to be careful about a growing mapping */
 	pgoff = (addr - vma->vm_start) >> PAGE_SHIFT;
 	pgoff += vma->vm_pgoff;
 	if (pgoff + (new_len >> PAGE_SHIFT) < pgoff)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	if (vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP))
-		return ERR_PTR(-EFAULT);
+		return -EFAULT;
 
 	if (!mlock_future_ok(mm, vma->vm_flags, new_len - old_len))
-		return ERR_PTR(-EAGAIN);
+		return -EAGAIN;
 
 	if (!may_expand_vm(mm, vma->vm_flags,
 				(new_len - old_len) >> PAGE_SHIFT))
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
-	return vma;
+	return 0;
 }
 
 static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
@@ -936,7 +931,13 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 		old_len = new_len;
 	}
 
-	vma = vma_to_resize(addr, old_len, new_len, flags);
+	vma = vma_lookup(mm, addr);
+	if (!vma) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	mremap_vma_check(vma, addr, old_len, new_len, flags);
 	if (IS_ERR(vma)) {
 		ret = PTR_ERR(vma);
 		goto out;
@@ -1114,11 +1115,9 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	/*
 	 * Ok, we need to grow..
 	 */
-	vma = vma_to_resize(addr, old_len, new_len, flags);
-	if (IS_ERR(vma)) {
-		ret = PTR_ERR(vma);
+	ret = mremap_vma_check(vma, addr, old_len, new_len, flags);
+	if (ret)
 		goto out;
-	}
 
 	/* old_len exactly to the end of the area..
 	 */
-- 
2.43.0


