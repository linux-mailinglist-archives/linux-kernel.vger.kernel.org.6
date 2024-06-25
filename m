Return-Path: <linux-kernel+bounces-229575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BFD917100
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67BD61C21E24
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1E317E8E1;
	Tue, 25 Jun 2024 19:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DqO1J6Ih";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bRfITZgs"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8371617DE3F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 19:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719342750; cv=fail; b=Fmq6XEPPO8GBEt75nI/tujOivT5VsMgf3z0MiZGfbsgZmmwCogIOCV/6Jfl0ODf1t/B/v0fpk9PSyC7o6/M/nwzCVyOP3USQAZRe9G1qfSqCHMQmXGudClc2HEmtVOrDDOXKthfY2k+avHDHZy5CkdxMeY0hwbWrKZ5SOBbgOJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719342750; c=relaxed/simple;
	bh=zgWIXyxRK0U7CMIKtGRdvF7rAXC0ub2aio/B27Rw0t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WpBvaL0/mAVC8K+kMJmCTbO89R1dR4kkjjdjtN6wr0kaYueECvmxZg9s9Ynirb/j24eLO7xTLruEYLze3IGkLkGuBwqL8uDojeF+UC894mI2sq3y2A8VUJa2jRMUZXOVcgtsh1rbxGwlr/9SxHPPgv/SG0tw6+dF/sTlzjMnkFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DqO1J6Ih; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bRfITZgs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PIfU0l003528;
	Tue, 25 Jun 2024 19:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=f12gUZaqT5CBj0qbmSntgTFf0542jsJzkP1hUweMEys=; b=
	DqO1J6IhMcP/dtTaWo6D91ODUm4doxqGMDGJV0ufxb89ftvspfkTWCNR7b0TWrZI
	fG4qlNre25FDYRfA76/4eNY2/w62r3aWJxUpj4uVMGliISheJq0IPBxbVWYx23wr
	WQNKyXJFzJHO4i1ReJuyG95NTfo6s6nWtPTFANt9Vz1fSdSmpRbofUb8EhLlino8
	gwkT7WVN+na2migUeFOg5I0rcS+bPPU5k78+FIbd7w4XYUwX9RDhsAS4xGQBTU+d
	vrpAoAVKGQVosEiA6IQhlQ0uyj24NnEguKMGZpRpKpiySIv7+weIgNLtBl2ZUied
	72T5H1mC/F4eS3Lz6YigAA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywp7shjvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 19:12:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45PHoVnn017823;
	Tue, 25 Jun 2024 19:12:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn27ytxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 19:12:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C42bZ4hMJy/AX/SBS2652Lvbnm/rJFaWTEnZGh5uY6bKFoVV5gsTIm3z1IkCvdsuMS54Jf2rh6rvOAY2BjHJjrRyYlT4lSbudOaT+zDymX/kZIOC9tNVetJ28dteb/NwBFl6Ka6uZp09d61ORfmELtD0i0k3eBanpXq5V9WuNF7aFfAfG/2RKntGcJqV0huBHesvLDitN6asC2rlfotP51o6PWy/CevF+vJ5leVf4yDdMnHX2XcAeL3gU7Q2vJF6uEUyNPqI9z/J+HfF0fl+qDsMCRZ/nd2IZ0tsjkHfgPf7JGDWLpjbA5LdoCsKaJw7+p20yjuAQT89GJcJNAVkMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f12gUZaqT5CBj0qbmSntgTFf0542jsJzkP1hUweMEys=;
 b=itU09f4py/NyPLlE3MlcZdaqVpUZ0/12cqNoujMr4rNpjiDjZ/QyEdKgi3FTGE4eduF6eFupWXtjAJ/vrqlbcnw43PD6lWjv8lEKcccoBxn9OUAYr0ug70fii9ekOy1WRAspw5dCDgi6FF8TDCiICfcGBGaV4uMDl+6byrLJgUvaFLCF9CMfZXgsOAdXrqGq43GnXCtVJxWNXXHMUIqcKVv9ZvwVLKBbCddEdam5xtL+gcFJG+/9LEm5dZ+njB281HRuebCrBXbn7xqnI9cLpr9LJrLuUQxaLwaJbNBQRNJ6VLRnX9SQdkq1CMTq3CsW3owmQQYb4Ze0sCWUIzKtcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f12gUZaqT5CBj0qbmSntgTFf0542jsJzkP1hUweMEys=;
 b=bRfITZgsv4jAbU+yIcHq5c2Ugr34q/YPeloenaK83xjhgMOIK4Bq8fJZqFN+CMcTGvSv3yxOxu7z36ZWIirHJY5jYtcmNnsqjsT7UPjz8akuFf0bqFh+Liw7+XF/aquQKxtOQ9pWmoalPRSJdXhARBo6LazWmQZQBWamB+y4DCE=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CO1PR10MB4707.namprd10.prod.outlook.com (2603:10b6:303:92::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 19:12:10 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 19:12:10 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v2 09/15] mm/mmap: Expand mmap_region() munmap call
Date: Tue, 25 Jun 2024 15:11:39 -0400
Message-ID: <20240625191145.3382793-10-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
References: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0320.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::13) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CO1PR10MB4707:EE_
X-MS-Office365-Filtering-Correlation-Id: 82561080-8a7d-44d9-8486-08dc954ab691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|7416012|1800799022;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?A/875Jh80dxjQbYKAgvhvUBbPBoZo0v5zddbMQG0iA2UpqArM+SfSi6IFBsC?=
 =?us-ascii?Q?ZWhGUP29UO+RsFDW73TlgAQ/Cod36mVuy3GAqXb36oIFtmzu5Ay1EgcFtLSR?=
 =?us-ascii?Q?zBtSk3dRaGUe72oPfKXqjokG1pTuBA95uSCXlmZNQ8lhzsdhFfpvcGiyarLY?=
 =?us-ascii?Q?noZhAT3y7ntOtgIZ1Sv6Arz9h5Z902uIGM2F/PzN6cSC9GqNH/YQGmfs5XS/?=
 =?us-ascii?Q?AKLxsrdAWVV6QWbmJCEr/8ikPTgJmpdfcAe15szA8T53YTt0TpJe0XeFzLW1?=
 =?us-ascii?Q?O/yaX2NpiyitA3kgiPIRk6Sucx4Yep5H58zuYouXvlE8KWsiUdRRbYcdQ0E3?=
 =?us-ascii?Q?F0wJXh6r/WBu7v9bGxn2r3sMFHHMXVPprrqYLwpn2+89e/feGgYjZS0n9pZ5?=
 =?us-ascii?Q?v+HcbDtRsy/Oi+lDGQ6aFByLkHb3aHMWQ2vfNlP0E6AmOv00PeTNYHNq8Ucd?=
 =?us-ascii?Q?/93q3CGdApWx1o1bWmUEXSevJdft0CDQI5me3PegZY0Y/9L0YxOP+px7eB78?=
 =?us-ascii?Q?nbMr+PGvc2b1rlYklNoRBsZFHezqUPuU6zyww+Vh3ZUZbRFUw5fr8aQCBm69?=
 =?us-ascii?Q?lfWiy23kSQqp5euFSFzzkYbAEd+rFaun5i8b70Ri7Rxi+VLfT8VuLOrpfct8?=
 =?us-ascii?Q?O+dy8ETsU65t9qNcO3hyVwxCcCllzuoOm1n7dGyd6WQfpb0tjeeex5I7BBQ+?=
 =?us-ascii?Q?KpPpIaPDOFbuvhGRP8NobR1CX8kjMFxKx8HMymeGcfwqlr9TbLZQ8/+2G7ux?=
 =?us-ascii?Q?bHxbF7aTQAlNgJEVSxjUVUfKNTkFBahOVwVWYpkkO2JXOR0QB3drYHOmFjdm?=
 =?us-ascii?Q?4ch9pGs5jLQD46SkcWudjOnC23QP4GahMwYrCFl39E9XGxmw53Nzjw7N8NWx?=
 =?us-ascii?Q?1z6G1BYPe/FPGO4gpoY+WzgXpTZelzZRrxMaYWx2qsqD2JPJDLajEfhLDVYO?=
 =?us-ascii?Q?VVB3z8gUVTMwW6Znk/z0rixNOx9gGI+GlQ+tmz0/XmhvZHH2UzLlMS4m6nNw?=
 =?us-ascii?Q?cZDecbjgfDTto/2G+ybSOLYBIt+Nvra0MemahXTj9Ov8kFQy0KTr142plCT5?=
 =?us-ascii?Q?fF1ZVHuGzpSAvVAIgkZLuLGIQDPOdg6fdKlo4KAfTB/WtMJkkTTtPczAzUQh?=
 =?us-ascii?Q?NYM5hNUJqdsSd1nx2ehiwdeaB1wDRFWnPyaKdb+ZDpqZBwia/aV5MVsWv21n?=
 =?us-ascii?Q?wSWYULBjQQm+tUbC/OUO8vZw6LSUGX/m90hBih5yR2DZ1aMTIHo+CyZcgbS9?=
 =?us-ascii?Q?e/h44j83PPuThXM1MiI7yV/N+DgDulWhtjYkarcqzg1huSqKOjyI1UuHVENH?=
 =?us-ascii?Q?zm9QBJj5MOoHJc6kbYkbdQQ+?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(7416012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ejsJDs8VZW3cr91CklcKkBKXvr44Klb2Bmeeme6uFIl4rYwWNN7iZBwxyMC2?=
 =?us-ascii?Q?xFYaqmYB5apDScVNb8F26S4WClLgWcwW1a2l9hAev7J7BRTJlvlARSrzt8qa?=
 =?us-ascii?Q?EGjDP6yZFdKtUpcAJLB4Twlx7dIhtzIS13t+7lhG+IH+P14wf5fr6cbXbM14?=
 =?us-ascii?Q?Sy161aVD0H7FvZLtLbCpGaz2QhVJ5ZXBU7RIA6CZbVXwvOSF9tkusFgbyLyI?=
 =?us-ascii?Q?QaCLKXPx0A6D5jiq8/b27SHqfXEN2ZUtk2jCw0iGOmZ5eMIeQysKsac/2mlH?=
 =?us-ascii?Q?s7LTDzU3nY8IsWro7vyjIh4rN2pg3Gkdxs5AxM7MuC2azgIuR+CsZY6XZTfC?=
 =?us-ascii?Q?TDL88oYw4v1RimbWVtJqSfEK7WTjuel764ZY4Itq8JZUagIC306Fw6tuf64K?=
 =?us-ascii?Q?yHPA3zkI8zMqErjk/z/Gfgt01KXVH00oabb2CIwQUi+YOya7Aol0nhf0ngAK?=
 =?us-ascii?Q?7eOrR8CQ8W5rCp898ZEbBKd3/jm5BeWsSnKFgtQsEUGvGKQIF6Rig9xTMgt3?=
 =?us-ascii?Q?bSQ6bQjpEi5dOPO9Xd87Bi0hdHi0+iAwyfsQ8EpAUion6w0xL8C+6JKQgAkG?=
 =?us-ascii?Q?IAQ/xHv9acmrsaoGM3QpRa/JOrCWffM1muqlhqpldkOg3syEWmt4lfCJEV9E?=
 =?us-ascii?Q?U7T0guTyBCl48d/yQDTYgdLrZl/8QHAGXOsKlgE8AKL5qf5HqAyuZQPr3wEr?=
 =?us-ascii?Q?ejBqf4obVtaG/ra+8MjNXkzsb8jnxNi5fSsqwhXmi0bHci31oO5vnfoOnirM?=
 =?us-ascii?Q?RLSjrGCxWVwi4QN1XOZWO4c5v0CT49qrKmOMFdzMzuXuTiCI0n5L1BfnDVD0?=
 =?us-ascii?Q?ddghnhZ4MMCc1XGqey+Si+O9eHigh8G7e7XPn5JlwdZvwYPUpIWGRrBB03jG?=
 =?us-ascii?Q?np4AC8VjhtDvpe+GGbBo0O9PYMZVPtQjXFjKe3FRpSDj2j/9Z92W17tVdr2a?=
 =?us-ascii?Q?ntMWUxhdejQ2qxcgLlwzBLkxKBM9TrLX6hMFl8ufIkr2a1JNfF0KYwkfVPiP?=
 =?us-ascii?Q?lZS+wBQ6c3bC0IWg1GTB8P8N44KAFACnVlOA8+rfVTCmC7QEMv2h7rgbRly2?=
 =?us-ascii?Q?4TEGa0LoDfWP40pa21ql4qRlEh3wKrEswy6k36npzEY3aMD0DfMu+hapniSR?=
 =?us-ascii?Q?QqIlKET6tS93rYei13/W6YwQM9y1iQimutFYHKSqn73uVnTMtcW6dCAESRKg?=
 =?us-ascii?Q?OjdAbXdZ0U6mdqDXxEtQsbcTI1qAyAzs5+ehDd17aqI3BG+Y7OfnjTO2q2Da?=
 =?us-ascii?Q?QZKIUcyQVzMAuOk3rIthqEDdkBy9quvn0h93wh907sKdaSAVdC9XKs170n9s?=
 =?us-ascii?Q?lI3wuZhTB5fqBJeb36PzwDShQm1TnT/HtPMSVL+9pLdiaUms3vMt37T4Ri+5?=
 =?us-ascii?Q?wdDZfEz9b4glDUQK9q9PAMAbuNfoBtlewwy5eubAniSjiAENNhQkMBkU0JR5?=
 =?us-ascii?Q?UAFW0mfOqjPlxgXnvuWJIb97X3SzUObfdYWRQT7n6PfZY2LdbULNusDVqpWq?=
 =?us-ascii?Q?Ok1zzCM8uDKxdV/XE76vb0Mfi+o/x2qmbeVGs5/JqPzC3C7+uc6Me4SbYGUk?=
 =?us-ascii?Q?N0F++TlqVslCVU2SI1kjlxMpEE5v+NLuX9pbfex3Jr7d/a874oZc+u4aqNhx?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	oZhGgN1ZAtTLvmBiVOx36e9GwXZwc7CpMZJSZdxkFfGMZgpkJrYt89m2CJ4Zkd9xvLbYYA6OyOgVVxBPFtp3QGR6mGP8i/wwM1pseRI09aorFXHeGSqWqIzKuxf6Pm0xk4LVVv7nfsu8VVGLobTSNm5aRSOTnCA9+7wjA4qCZJ29n4Ba2uCmZONEZBHuNGwZzWaiie5ussJf//7HuIEzFK/Y0pDp7xyDRv+8wfOIKBprjssZrZ9+KmG67JQIJLjpJ2gUPVbx6slQyxhxuMSXYx4zGMsUoRLTmq1Hl21CiZm2eyzLMUU+1TYZ0a+NIMVcgtck7huvuCqGE4Nx9038MwdRMZdVER6O6jW2XN4wAt3hHNTL4vCJTtpSjAUUMIUzbeOHAO7tXAmIjs8Db3pjc0qFhmr7J6t/Hmp0RO/LSkNp1HEEgyir+EE1v4PuuKlBiu0pLe8SpTDjKlMIvItRouZiE6/0VgFN3BQtYYZ7MmtOSYsZLTTHXa/UMPvpdVNB4c1zB3z0wHGSsU5p6e4pKFWjs98RVWKY9Jfu2Yw6XxwHk5wOcPAJaA1KNCfEfqkVri0LsYfJtT/JMCEdq6WE6Ihoo0J61shvyHR8vkoziJA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82561080-8a7d-44d9-8486-08dc954ab691
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 19:12:10.3827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +9Uo2JVJ2NXcS6Ou3eXPLCvKwMWDS5jgQkXI3ciVmk/8sBA+6JZpnMNVhdoTzrrtAw6NYZMadk6pQ7j7+ojuKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4707
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_14,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406250141
X-Proofpoint-GUID: drSW4CsO7QR6fk1_fLdATppIVTpTC23L
X-Proofpoint-ORIG-GUID: drSW4CsO7QR6fk1_fLdATppIVTpTC23L

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Open code the do_vmi_align_munmap() call so that it can be broken up
later in the series.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index e9858ca8bbd4..f5b33de4e717 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2915,6 +2915,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	struct vm_area_struct *next, *prev, *merge;
 	pgoff_t pglen = len >> PAGE_SHIFT;
 	unsigned long charged = 0;
+	struct vma_munmap_struct vms;
+	struct ma_state mas_detach;
+	struct maple_tree mt_detach;
 	unsigned long end = addr + len;
 	unsigned long merge_start = addr, merge_end = end;
 	bool writable_file_mapping = false;
@@ -2947,9 +2950,24 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	/* Find the first overlapping VMA */
 	vma = vma_find(&vmi, end);
 	if (vma) {
-		if (do_vmi_align_munmap(&vmi, vma, mm, addr, end, uf, false))
+		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
+		mt_on_stack(mt_detach);
+		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
+		init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
+		if (vms_gather_munmap_vmas(&vms, &mas_detach))
+			return -ENOMEM;
+
+		if (vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL))
 			return -ENOMEM;
+
+		vms_complete_munmap_vmas(&vms, &mas_detach);
+		next = vms.next;
+		prev = vms.prev;
+		vma_prev(&vmi);
 		vma = NULL;
+	} else {
+		next = vma_next(&vmi);
+		prev = vma_prev(&vmi);
 	}
 
 	/*
@@ -2962,8 +2980,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vm_flags |= VM_ACCOUNT;
 	}
 
-	next = vma_next(&vmi);
-	prev = vma_prev(&vmi);
 	if (vm_flags & VM_SPECIAL) {
 		if (prev)
 			vma_iter_next_range(&vmi);
-- 
2.43.0


