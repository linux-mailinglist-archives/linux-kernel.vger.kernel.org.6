Return-Path: <linux-kernel+bounces-229577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2935917102
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8011C20370
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C4D17E90F;
	Tue, 25 Jun 2024 19:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T2o7R/1B";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mGYBobBc"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCFD17E46E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 19:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719342752; cv=fail; b=KZ48Rj+X5e3uy3KOycIOE4nO6R1PubHe9iP0+e1NrsY8PN/WERWuL5PXNsSSotXUQDBizA8J4XiSvM6OeAQbdto/qVyoL6lwU/WwagFbZmf64zYo5NkAMDWibNXuSdpBOWIjIatQS2pMPc2U6HmKHapu0bo0H9EGqUXbl4SkkXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719342752; c=relaxed/simple;
	bh=hz3eEVdBk3DNaGbj4AF+GLdhtMwoG1b4l00Ev7QDryY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EHbSAcMfVM2jaBcWyJihViOtkq92ZiLfsElTGPeE5NJIL+3+ZaNuwlo1oZKPMdYU91umFRHR/rkzmNQoLk/xIMY3l6nCEO5duOgzADgspsCjPikQ3DjIQDY/uZYwJlQ3DCj7UQMwR03aLYlncgKvVKyC9lKu9FtqofhFop4bVnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T2o7R/1B; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mGYBobBc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PIfY7q009067;
	Tue, 25 Jun 2024 19:12:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=2C47QT2h4bMPUfGiEQ1EmT7/uBhtsa8B2FgGIJ4qDYI=; b=
	T2o7R/1BxtVtVS1qwJShcVe7ZB/vUf8fxDcy1xApRJqshafHuJSMZUYwxlyV2Wjm
	L+7gK9dYb9FRXN1t6EXB4tnlBmtyEXM3H3pH0ssPoMf3bGK1PuQvwHJJFmJUh2wa
	vlBSpqZ4445ASVzxIjpvTETyNP+RLbivcjkLKGhDNWI1oJdh3U8risZXDgfVvjxc
	di6iuMlldLtyDmOSEz+wl+hxjOiM5TnIq2eBSQkdDq36zq/Pu5aaybHSIOnARjZm
	HmW3mH83/uaTD7YsvQqfAIbgCyoKEjZpBSs3OJ6XVjNSZzqARNndM8kTofiBofmV
	p9ZvSrAfhoLIpt9tVcjfzg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywnhb1jqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 19:12:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45PIvN1s011492;
	Tue, 25 Jun 2024 19:12:16 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2egtsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 19:12:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQm2af/Oxk8M4+P8zw2Cxv83bHOq++aKpEQap02LA795N2qz5+s/UalqCDudYfLXIks5ma9hSB0tQRn2uxiJS5h5mOW0/lD/LT5fos+R7jkQ/l5Yxn8VZaRspMGmV3F0bgJH6PK81RcScDvmlGQgxacmqUaX7k/AuF3saEqtT+OQ33X1s+LfZFBPt4IkMQBe2qjDssgtV41fl/etnC8/pRzC3Af30Sv6sB1DrcMA8vfwFymCf8ikRapq6dxzqo3QeLfKrJX0ROSzACCDpmDPZh1cw/aK7py5waFUeN4mIsGBWrz+f0HWAgseHIWzHQIx503OZLE2ThuON/+VsUQ92g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2C47QT2h4bMPUfGiEQ1EmT7/uBhtsa8B2FgGIJ4qDYI=;
 b=G1trylSndNv2kCKmp361dnXM9pAlQ3ZwBPqLI1vmlNvSilVdTGykqadhTbIca2/pp//miBTCBW7Lpa7ZqqicOjPGfoiTMnNWohqVG4pWnMKX9XifBezbqRWwtHu7+6TNiZPT1kX0/JrMuWIE9Y14C8rZKJd7qh4ytljKikbKK/i3eySriVIJ0k1vLYKIQi2uE7j/Dt16/g/Vn7gVCzDGm7mH2q6BY8DEoVppawT+l30dbfGKwDYqKu/Q8QXo68g4HbuWJsPW39UefVZz0rnQjl887S2GaVpEpZIj1sx83+iaxyqJUAnOudh2qrj7YetK8bsFAeAkvaFMeWn88h1rNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2C47QT2h4bMPUfGiEQ1EmT7/uBhtsa8B2FgGIJ4qDYI=;
 b=mGYBobBcMRUIk2viXHomlfi2J0hHrAozHEfT6dJOUFBF1T0Nia+YzXI7zjzoq4OU8erAw/Siw66mM/4wKVAVSc7PunOwET9zjwXLcMFzmXeB9cXil9e4/+CvL2YMVyRCj7M0D2Hg1kpQaV6nqIUfy2vEMbLVRmYzL4/iwNJHKzY=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS0PR10MB7066.namprd10.prod.outlook.com (2603:10b6:8:140::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Tue, 25 Jun
 2024 19:12:14 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 19:12:14 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v2 11/15] mm/mmap: Track start and end of munmap in vma_munmap_struct
Date: Tue, 25 Jun 2024 15:11:41 -0400
Message-ID: <20240625191145.3382793-12-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
References: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0200.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::29) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS0PR10MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: 759bba6a-442a-4ea6-fc50-08dc954ab901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|7416012|1800799022;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?9EcHe8MMTkNSZakHbsxcu+Z5T9D8Niv68ojbfe9B9wibT7cisT/B3akxbWel?=
 =?us-ascii?Q?TCGxYt3ZkTL3byKxpPcA0rW8VWAyiE7+YBfICpnMCToOMYt1dKgKEF6cOWWl?=
 =?us-ascii?Q?Q80pYvKAUHBS/W25mSw6GI7a7RglG3RQTXBYHxuWL2I923Wkyr3LZ1mmE/D9?=
 =?us-ascii?Q?P2Dg1P1DPDoxjawlVJFoRhMAHpATEoFhrTeNlidU+w67m0IHY6kahp63ncp4?=
 =?us-ascii?Q?BcpkBuo0b5MY19ZC3vTxT7uZQbM3ZIAa2NYKxjlkuUHgc8rEiHhIVanHYqHV?=
 =?us-ascii?Q?VCpeVr2FVt0xmIDy4zB8PB3lua6RFZFM+iwQYuKT86T/qijXOWRl5QLUdHPu?=
 =?us-ascii?Q?9XhckhgbudQWj/x1Xpu1Wt/M2wggfOkOdm8nTkQUG2aBg3MwnTl3+acniI/J?=
 =?us-ascii?Q?IPS2/LQ9gtRQPcbHbH1M7TYndsrvpzUjjNHmmK3hbpqCc/LfETaVXITA4CdO?=
 =?us-ascii?Q?PC6f0jbooCVpDqsQPCYyt/w/eRiO4sXt3oCpAPrSU1jLZxWGKk30XSYrzfcv?=
 =?us-ascii?Q?EP3GI6bfj+qRO1WIqfRiQKNI2QyA3c6ngiCtoSY5kczrsxYNXRhLBrD1D6RC?=
 =?us-ascii?Q?a09uQ+HLDqsfH7HpTJDTw/8wJTgEdOOwlDUtwkqowTDiiQwy9dyKDlNzul22?=
 =?us-ascii?Q?cAXH06bCm1MDyWqbbZ2yKQ0NkJlspqBpyC2dOp5T/NI5CY3Ci1M0nC9Emguh?=
 =?us-ascii?Q?mQvOJLJYSau+UCi+6jnQphv2Gs7NML1VfZUbRcUJrgswC0RqzDlhMW6AH3ws?=
 =?us-ascii?Q?55Bh4u9omCQvjFd8Q7Z3FI3+/wPbM+vkvsou2iAS/o+qnBy4vF1VtEBFa8VR?=
 =?us-ascii?Q?W7/BdHfOBzOdGa60l2aRFZQDWP0jpiist0SJq8jwC8MGcv/Q21c35Q3xrIZc?=
 =?us-ascii?Q?WbBSHjSmqZPtGLslpSbma0zgjIPATXvOGcW5uMs5lrWocUMLYo9joSGAFyvS?=
 =?us-ascii?Q?X9J4twNY/2/3C6XW3wqrXFMdbvwKQcNSaVNWduGugowYI1E1yRWIAUivmPTP?=
 =?us-ascii?Q?U9ebrmLzes8Fa3euqkofvdDwEXVVC60Z6gf7Ak9uGVPci3Uwto1J4nDWsZVt?=
 =?us-ascii?Q?fE0PmbxKyYG90cVqoOpajSlLwbEyniytvzQxSMMhuWuyT8iEFTg+R7c+0+Dy?=
 =?us-ascii?Q?BK67r56A1E6be2PpXyvmYhZ4PBa/usu5ZsrNgHwle58YfDhE2oyJJZzucgLu?=
 =?us-ascii?Q?dYCSLcE8QORzH2TzTDnwfKibiuQ5h5i36t6770mxNIMUlJKzTn11L3j1BWv9?=
 =?us-ascii?Q?mstlnb5A5rbdUGfmIzoJi1lBFFSpeBzM/QsgMceHgXzMBX1n6siSnJu4fMVV?=
 =?us-ascii?Q?BiYRtEhP29wfra4xCk7i7Oyo5dny748MtYWNTjLDPq1SzA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(7416012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?yeYjv6UhBoHNMHCFp9L5I2dKDkYGW5F8q8NpO4XD6Hr/k9XXFBGjHDV/ouB2?=
 =?us-ascii?Q?PqV3WCGzp5JuuuvMr2xcrJnO8mqTZCvLRHpEynQQLvQw30PphEGGXw3lmPcp?=
 =?us-ascii?Q?3CJj44Km76/+vTfiBQFZXWQgWp1A1XUzQI7Mt6WW4k9DrS0eJ9UwSLKGyksd?=
 =?us-ascii?Q?8NYVhuDWFUtyaoJ2yUn+3tSnAWBC2Bv/lVxB1xEJWWRXhVaFWj2heCR+V0ED?=
 =?us-ascii?Q?i78z1XHZJoEK7MAn2Dq71xj6z78QMO8btCfiFSSyCDGZ1qEBe69BCw1jrXeU?=
 =?us-ascii?Q?FmR0XdJR5TWEtvzjKP4yv8e4E7BB4C9p2xUnJPBShEF/Bn9KPx5ZeLIcKIFs?=
 =?us-ascii?Q?+kbw/ddi3M+9Caap5sSWCRrtY5sciffdnmmqY0F4/oiUsKh6h1sXTeHwqjQw?=
 =?us-ascii?Q?vB0twwGZgUMXFPItxOxyvC/JrrIK1Jk/V/yGD33wx81HPrjHIZifl8hwlae4?=
 =?us-ascii?Q?LNu9NTc21iriXgRcwuUlYmh4mhB81LpDJxAfxsNVb+qfRe2X4Lw9dQLL+NJW?=
 =?us-ascii?Q?WAzL0bHu3hzFoPDYciMmUpx493GkA3Xfy+zi7XjCVWXo7qvw27UZnjbJNp5F?=
 =?us-ascii?Q?9QHHK48LP6onOZNML4h63i7hOJxWyEOeCYRc+ZWDsXYdhTkKnd3gQtgZqzuH?=
 =?us-ascii?Q?IHQS4OG/aLeuDrAxJAFOWCqEMybS8bsr3mZveqYPIayowVwBdP3jYimo5nbQ?=
 =?us-ascii?Q?cV0VDr0FJlhGkDO/CrYFkb3nP8aVNrzU4q061N1DpEYj4tsawS+ADrwK4Plz?=
 =?us-ascii?Q?WnjrDni0qt7CeA/G/rTJq66KsXps34qu+9cyfSn4JdEty4Ac+P59I4mhpIBK?=
 =?us-ascii?Q?02rmmb3cErhnYZ0+ezQSnD1sjvMSXw5DTjBKjlfVGfJlVbl8tlwKUlMVBLM2?=
 =?us-ascii?Q?fLm9gOr3yME0UquR2jbJ2U0ktjc3OxrIX4zl8JbwxqD3AU5ocMKMxjvYkegJ?=
 =?us-ascii?Q?BT0OjUvZJ/5AenEu2qeFhurQtgJv1LjSwrwa97KKs0Fl2tGx72maHJmfMhSg?=
 =?us-ascii?Q?02cnV7VYdnh/99+q8LPaOpalQOyWDFWSyadvquDMlPEKjQl+WsugSDX8MMyq?=
 =?us-ascii?Q?qtneGoWV2F9xE7dPoxcVzEfvGVuz4yis2CXHaoozVtxuqQiDtJbNFdgX6kAa?=
 =?us-ascii?Q?37LsKIhO3dUDRSeDDlVRLIR1j1lmLrjcoWd57nJfTpaHg1JMD1Xj95HP3tqc?=
 =?us-ascii?Q?xM/fA/nm8RU5mGuwYP+EwoU0DiPkaBmuTKAhHcKcRaoZLi1Dwo3Q5RV280aN?=
 =?us-ascii?Q?kLLOEWJEt9kWnGGcWWbJYi7y8W4ZEttSj03NpHMZae5kYsJC3YWx83nqSnnz?=
 =?us-ascii?Q?7o8KNyY6jbBDvOgya9RmUVIaQGwfykpBCW+NxWdDFTthn3gOvYCNwcw1PWCh?=
 =?us-ascii?Q?+u5dwB1595dpXiIkxu4xfVsFp61IearespTSbiE20NbyxebCRHo81uz8FBoK?=
 =?us-ascii?Q?RD543QZjBt3eCY3Jm04MBCZyPgiZXzfMoJxGHKzoc/JONWjF45qd3kCDYHcr?=
 =?us-ascii?Q?agCrCYTQg9XIGg5IcD4YqWABGqVWnVot7UN8+J0fmcWl4XYHPbEwhfreJNrZ?=
 =?us-ascii?Q?CxgkMxoQQODtNCyYz+K/bcOaohqVtJYRBf3pZUEBhAtRU6SbuFgq+gQORu7H?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	iR87Gtnr6J8DbyiTfTn5CChZSq692p1Joss7uevJmoQUcYXuYu+OgtYzDQLgHftIG1ncz7maD1cVL3HXKaDjZKleCEceHoxgXg9jB3KKmmOO5vtRFhvIc7nuxXLLpi38HGD/ZaVsDFScE0LM/EsrEtf861/cXA9CTltjWBS9IRqd7UnJjuiaLnGWtICJS91fGDe1d9fr/zN23pvBEAquycRtrfNPIQi4PuE3gZsWbIoFyuLqwk8jwPHxn6LaV2u0fYjfEno7rfmF/O1pn9x1AoD6ZKYZxbzHmcxLFZ8/EVIj2/janG46/sUxwphX9hePKgSowwR3A9WtAke1ZWYLiUACoujPUlJPvNOyIBPu/n22piI/q8VnrNCyYJ+FCtpHIjjqVmwNodzTCrRlCpXZxUadjD3i2QWvsxmJOUQKfGdQlaHI7GfJ1RWMRgSr5/TQaHD3qSScb3mpRjxrZWT4LhhaYAV+knqAlbGl4YyFjZG+JadciZgI/J+M/q/oyu4fKS9NbLx6t+CZtaj3LT4xwL73wK8bgpUP63GWMt9y5CGCofsa8l/Infg+IeMi5BeqRYtbI5VF5KXW2fzb7O+LbXzB0sI36XaapE0hxXbELaI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 759bba6a-442a-4ea6-fc50-08dc954ab901
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 19:12:14.4733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LlYM+ZHEVeUfW8yNKNJEn49BFB39K7q4xMpRwawlk79XVEhDeF5HNkaGIMMDKtB/Ygr9dQNpztsLDqejpWFvoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7066
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_14,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406250141
X-Proofpoint-GUID: vHLokLqYuztwhig7wlvafLp5p9ScFa0i
X-Proofpoint-ORIG-GUID: vHLokLqYuztwhig7wlvafLp5p9ScFa0i

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Set the start and end address for munmap when the prev and next are
gathered.  This is needed to avoid incorrect addresses being used during
the vms_complete_munmap_vmas() function if the prev/next vma are
expanded.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/internal.h |  2 ++
 mm/mmap.c     | 13 +++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 90cab15c3b81..b0300cb22353 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1492,6 +1492,8 @@ struct vma_munmap_struct {
 	struct list_head *uf;		/* Userfaultfd list_head */
 	unsigned long start;		/* Aligned start addr */
 	unsigned long end;		/* Aligned end addr */
+	unsigned long unmap_start;
+	unsigned long unmap_end;
 	int vma_count;			/* Number of vmas that will be removed */
 	unsigned long nr_pages;		/* Number of pages being removed */
 	unsigned long locked_vm;	/* Number of locked pages */
diff --git a/mm/mmap.c b/mm/mmap.c
index ecf55d32e804..5efcba084e12 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -525,6 +525,8 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 	vms->vma_count = 0;
 	vms->nr_pages = vms->locked_vm = vms->nr_accounted = 0;
 	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
+	vms->unmap_start = FIRST_USER_ADDRESS;
+	vms->unmap_end = USER_PGTABLES_CEILING;
 }
 
 /*
@@ -2409,9 +2411,7 @@ static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
 	update_hiwater_rss(mm);
 	unmap_vmas(&tlb, mas, vma, start, end, tree_end, mm_wr_locked);
 	mas_set(mas, mt_start);
-	free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
-				 next ? next->vm_start : USER_PGTABLES_CEILING,
-				 mm_wr_locked);
+	free_pgtables(&tlb, mas, vma, start, end, mm_wr_locked);
 	tlb_finish_mmu(&tlb);
 }
 
@@ -2637,7 +2637,8 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	 */
 	mas_set(mas_detach, 1);
 	unmap_region(mm, mas_detach, vms->vma, vms->prev, vms->next,
-		     vms->start, vms->end, vms->vma_count, !vms->unlock);
+		     vms->unmap_start, vms->unmap_end, vms->vma_count,
+		     !vms->unlock);
 	/* Update high watermark before we lower total_vm */
 	update_hiwater_vm(mm);
 	/* Stat accounting */
@@ -2699,6 +2700,8 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 			goto start_split_failed;
 	}
 	vms->prev = vma_prev(vms->vmi);
+	if (vms->prev)
+		vms->unmap_start = vms->prev->vm_end;
 
 	/*
 	 * Detach a range of VMAs from the mm. Using next as a temp variable as
@@ -2757,6 +2760,8 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 	}
 
 	vms->next = vma_next(vms->vmi);
+	if (vms->next)
+		vms->unmap_end = vms->next->vm_start;
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
-- 
2.43.0


