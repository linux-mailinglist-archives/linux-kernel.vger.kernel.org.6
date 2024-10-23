Return-Path: <linux-kernel+bounces-378657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F409AD3C5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4CAA1C21060
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8831E51D;
	Wed, 23 Oct 2024 18:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sag1YPtS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RVHV60Y+"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CA413C8F0
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 18:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729707402; cv=fail; b=N5L4Qv+Sa7m6CMsROR0ZzjrM0L/wr07U8dmmD7p73jxUuiZuWYEFXKi8Xk+KisMImvunNl+RRBxtK9G7efnFuVqsZl4lOjSnSD/ZEpcqFxoyqrecZPg9jNsxrQ/RbNzUFn4QFPhvfygVDcwXrBlb9gastypdJnj2ADLCiYU4LMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729707402; c=relaxed/simple;
	bh=1GibIskyDRmAekxRT9R4rYuvFKtoAVmcbMPMN5HpT9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FNABstp1on67DiPeFSB0iQABEQAYXcN736WFHeHvvXx21qpJabZgbmZGqoWqI0ciNI+XIknu5anZ0J5zqkGS1o7iDcumnFv+f8h89NUfIHAtvdiY2tuwDbN7yfS61DlgJJa6bonR5AWBPYljhHix4LI8ERgHQBwh0wTp6FPg6AU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Sag1YPtS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RVHV60Y+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfhuZ031492;
	Wed, 23 Oct 2024 18:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=joFzXwZQicJSkAielf
	cnXZfh5Cp+ezgydjf/ljIq9NE=; b=Sag1YPtS+FgeHJ6FUeE7AnkjLKrsvrZcWu
	VkRDxL5ub+JDfCR6whnnWrsf3R4bzJFheN951HNfhIOvThIvCOYS5OFOL85vZ5/s
	5ATSxwpkgN1yC6OzE9wMG0AzIncYigOC7P88MoETHpeZfStFjWBRaat4fqq3I1LF
	887LlLql2m19pzPvIb98yGUUJnX2Fjqqd8cp4JkTRyoCr1c8v4f4ebyrb4RXgGLJ
	E31k7TdVQv37rbYO85lJi1OLHDuctVdisQ37lWAq/KSu/mtFhiUSlc5hu+o/B9q9
	sgNuHJGf4VCO191UBFuVOTduGDs8qF3pvZw/HnLJoxj59EA8OnCg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkr04mr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 18:16:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NHlApU018489;
	Wed, 23 Oct 2024 18:16:30 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhjwe32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 18:16:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W30jkX8h2CIElFspQJeTpRQkNXo8oR2uuHnt9cSa3pMRVBtiKPhTkzys0MqShaV11AIhGHX85mGCpi3Y5/KB7X3ajy2MnMNoi255P1miTwjgyB6UD4kf0uCVvObNndVG7TCHrkWKYjv6GMpo12vyMAsIkgtTt0vbu5Wr87T04Mo+jgUObI9oDuTKgkgEJjSXRPj3IQJLTcDzPGE6uV4VLzEPAf++2tpgy4+W15S2E3lh6HSdtsnh6OsblscK7e7wu1YWG+mBtDkAPhGTfTfhLkSMnMnEL9P3LQBf2rzQZm2+F2B+ejjtgHoeQHmFmw5XV4KN8lcPjhBcjlDvfZzA1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joFzXwZQicJSkAielfcnXZfh5Cp+ezgydjf/ljIq9NE=;
 b=pvjVTJEtZLzmanCCOQj6XQWIgRpCcq8W6m1fLI90od42mPgM+MUDd7q2JpU+Em0lymE74O8ZmvL6gwCuWLjeO6bgmTKbBPwSgeW2mK08FYkK+kYg/4junfS/xcXwwFxGS5DcHYip8BvCwHlNAy+nlk4Jmam0IuVWtcjCob0BfWSWmGUN3HO2k7Kx+N9qIxyPtnkR7bjz//E1PnpPfp7l/1SY2u0hJjWlPkRIVdcRcMOOJ1S1vPLomrD0mljp3I8wFIeMqrdl/kQBxrr0DHjjYz42ca/zNcteiu68rcQIzDyUPYU7v/wxqX/fsVJEoYiBH3gZ6CwJzfpUxX5wWuKfXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joFzXwZQicJSkAielfcnXZfh5Cp+ezgydjf/ljIq9NE=;
 b=RVHV60Y+SYfneG2Ke7pO4sRgUdU29l3hLtR3mX3yZXZuDrsz48BgunH53LEI7FpoMkIqXpSXRv13dPDWQFrYTgi8AvJjsE4+NGLKbEL4yVLa5YIno2r4kyQQGK6vGbdm7QryNBF57lNa4gXx1qB76xAiNoTBWyUzd492Npc+9VU=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DM6PR10MB4330.namprd10.prod.outlook.com (2603:10b6:5:21f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Wed, 23 Oct
 2024 18:16:28 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 18:16:22 +0000
Date: Wed, 23 Oct 2024 14:16:19 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH hotfix 6.12 8/8] mm: do not attempt second merge for
 file-backed VMAs
Message-ID: <dgv3kvdbzj5r77qralkg4v52d6rq66kc5zly6en67iqqx3s4eu@vugze3mgo26j>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
 <7b6bf6165080505feb5e00b313d2c84c25015e45.1729628198.git.lorenzo.stoakes@oracle.com>
 <f5037dbb-7412-4fda-b397-3e5538343686@suse.cz>
 <a97ac345-e880-4750-9114-43db358065c3@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a97ac345-e880-4750-9114-43db358065c3@lucifer.local>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0204.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::12) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DM6PR10MB4330:EE_
X-MS-Office365-Filtering-Correlation-Id: f5785e4e-3396-41b5-db39-08dcf38ecc42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g72VyOKx1smQl/fAyJlLq8s77rFaJsMI0QhMaLJBrzFC5Ag/4YvPjqB9wMy7?=
 =?us-ascii?Q?PWIlWzfp2hxlxPq6kQhqpNt3iZYDhXAwLxx1Z9akFDARYv5rld0meZOwNHFX?=
 =?us-ascii?Q?3UMKCRyW3PGTUupPqosiEDKwUjWvDKDhIb3nWtISkw3HklGXplMwMYIGbYmz?=
 =?us-ascii?Q?uskmieMPaVYt883gus7CiIS635cafY8J/q7MERvjhImM7PEqi1C0UvpmgGXV?=
 =?us-ascii?Q?A9Ixp6wvEhJfXYGHpceJ8wTWy16G6DEyb/pCJruKSJI7mGERx7W9XVaLh2sP?=
 =?us-ascii?Q?V9xy7gw+JAtTXj8mg0E0RIlB7+USh9Xutp849FWdqZ1j50FrN+8kf4fP63k1?=
 =?us-ascii?Q?oTSGITkn6qGNGSVLLTspmEbIkibgMwdTczBRsoPbPU6JQlto0/+Z0La6xFx2?=
 =?us-ascii?Q?E+V9jhrNOy4PX2nqa7Q5laWnF5x1aTazSJ5Vg2qVq3b6Hf/OrF/huLSvOigw?=
 =?us-ascii?Q?7BfDc/6Iwi1ZR7PRl4PfKENbHMs7ylimt292v7gs2sVBchlBmj4LUnUEC3ON?=
 =?us-ascii?Q?2XJT9lGWJ8Cfs/xvlrFcWHXFD0C9no8MA/0/pU6gLX/LoijR7UvJKnXQ7SV+?=
 =?us-ascii?Q?B4ERE9YAdKqCX4pLC121bWexUUZWKx0RqZcXCuFwOeJ+Kf897crjRPmtOYhE?=
 =?us-ascii?Q?IcUzIJcdscjcSP9f/BLR0nI6TwdBoK7RJ82oLC3VimYfwtPULYgyNU3i8cZO?=
 =?us-ascii?Q?38VXIQxLyEPdiO+9h8CHClxo8Glp54Duc2YIFq0WKTAe37AA2mMNRLfUAd+v?=
 =?us-ascii?Q?R9wBaW+aEH7qh9usnDV3DbG4Cnk0PzoHRyOou+wlBCMNjoxJVxlS1OXBOPEI?=
 =?us-ascii?Q?+iAdoBxY0cxIlHijn2Y78P+Uxz4GkCz2CkHqWIPIO3k4yGQBnH8SPCj44vDc?=
 =?us-ascii?Q?o26XAa4sk4rdhT3pQgLQb14BubVRZCTxk11M44bFYKzLyY15U5stMWxVzSiI?=
 =?us-ascii?Q?hfnGGEBHbJi00CKaFAXvnkuyWKVHqUxbiAbmMLBkp7U/DA5LVRIqPN3mQKv0?=
 =?us-ascii?Q?trT2liqq7mqEEUSCyG3lAPUbAHNUPKAflGXI3cwjCbkVFTYsqIXb3dQHVCB3?=
 =?us-ascii?Q?IfC1VM9FALpaqgrdBrf8RMFXFE9ldUFFyGWAkAJIIAs1Kg7F+9ucc/raYdCq?=
 =?us-ascii?Q?VkvhS/zolCcgnOE1EQrC2RjnWf41fSj8V78Uvg6IwPodlJGCRgWmUw12w+ud?=
 =?us-ascii?Q?609V4VoxdxeNY/VehCDxNmGHt48eNWBEWHMza87o8vZLG1udYrYhKjOA+VxN?=
 =?us-ascii?Q?vE2gJ7HVNy/+tGYHGIRH2dackidPz6+lGAOP6Fop5z4wl7DyXH9xLQZitgbL?=
 =?us-ascii?Q?mI8f007qlvSRw/jkXKNhd4b7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vAx8KsOe5xfnfvpwN8cJO47/94gzkCKQsiZr/GTKMV1YLe5x2+WXNY95n5uq?=
 =?us-ascii?Q?t2oJ9Wv2hzDsR46XjAhOKx7ENVv4M/EB/HxSd9QM+qVidFh9J82r9L9Am5wj?=
 =?us-ascii?Q?cXQvuJwj0LWWZqNZkj7WQ6b3R+FZE0pW+XYlwSVGkwgHi1WfuEWgyj+IEMJy?=
 =?us-ascii?Q?2W4VBZi48WiPx1fJNr5MPtYOEMB+KhCYgA7e1JW8BTE/Edyn7aMCmPf+iQ8r?=
 =?us-ascii?Q?q3kR4RdQPx7jTPgQTcyyP6UF5n/Mmr5I8igrVlbfjrKYwnvzkffqF39IvRIw?=
 =?us-ascii?Q?9+Hnb1qhdr1fClwdNk4lHu/uawbKGmV0sL+nwUYnJ2S2HmTbK9mZrM8hg/Kg?=
 =?us-ascii?Q?QT5Sqg38mnCwRNMe3ggQPeqfHlY/TXH8ml1PKZ1uP95jUWfmkjVUGF465jFn?=
 =?us-ascii?Q?fccsNWR88RUT47vygNc3nEY5t4RMTRa/OIOuI1wW+pZE7l9KtM9ri1P9NN55?=
 =?us-ascii?Q?Fz2qay8gqaUxxeqVFRBKPu+q92fn5Fq1c0035cXpGONO4cbIfd+z7jsx1bQy?=
 =?us-ascii?Q?MbKQgSTGJpIqxZ+L8K9llOqaW1qVEkmVNPXrxUg37XVr2xjucrQsuaBuOOb8?=
 =?us-ascii?Q?Z2tlIBzvkFMRP0c8jld+jBKSQUrNJlNKdraf8yfHSSC5aEhlUlfmC6bSb1BQ?=
 =?us-ascii?Q?SZ06E12y9WuSM3rkmIcgJUHl7yefnCCxyeX+YvH/uD/TMLzw2pwmvclTo7v1?=
 =?us-ascii?Q?utstnWB/YzV2IVrnLA7qUGUZa0CkA3uqQikmXPwxwK91+PjlC7u+a2Gk5g2g?=
 =?us-ascii?Q?nUdjWGZDBiOeq3jjNgPvi9ryCxquIn1vGT6aGXYzZJmtAmvDSL556PTstEj6?=
 =?us-ascii?Q?TCsZ91GEEDy5HepA8DbmsoX1rkWG/phK2Nmcq5Ryqdm4ZlC0HSL0E6cJHEzn?=
 =?us-ascii?Q?Fkv/jKZWqhCRykbSFMAVzPz/T7JUxUPxAVf8xD2B5L5yqHpVktS+DAGonVn2?=
 =?us-ascii?Q?qXVNeu1XeYLulh67SS1++b8gRxoDiUzwVDkHUAVKgu+lpCeoq3Da00/G2uj1?=
 =?us-ascii?Q?llwY1AesZjyV/PzO7I0D/ZVQ5jEyyCn0jepXmBE9BPeLnmeDhkF8DmnbvA35?=
 =?us-ascii?Q?gKJtXjIWsBzZ1mFVJaQiNdOVQoNtg/wRhcIsdSzGGKdzPlueEvbOsDpib1Dz?=
 =?us-ascii?Q?v5Dkc3VRUR9+F0asoQBM58bBMbrDRZmtLem5WaZIqHBN2QqVCwbayiJ5+wIW?=
 =?us-ascii?Q?0TJaWC4+ra56taLeLJUfz+UudfrMK4TsWej4JtP+nxKkUPXt7Ky5k+Wonemr?=
 =?us-ascii?Q?0ttGRjqVgJlVaqjRV4+GCl1YgbJK2XpZgwU0TgBUyYhMVLoETYwuWqdZgjMC?=
 =?us-ascii?Q?MD7/zkdgLbG9zXUuBGPiR5QLo8Jxh+kJkMv4kv78MyaMmWVtECk3zdaigwCE?=
 =?us-ascii?Q?8FkML4vfq/PKe82wSYeV3AM6R1/kkKoDfVUutVwcAIkvskR3KkDhMR6nOIKw?=
 =?us-ascii?Q?b9n6KJ2oxYmoNYSZrvadLw+k/CIWf3MMw7MW1TUxT6OuuvOX5gKx/ClT3n+m?=
 =?us-ascii?Q?c/M7y2QVDhkyfrItTNdLuWUA1SHdhGFKugVNNxxo5whxjqaEkB9FJcAGCVQx?=
 =?us-ascii?Q?qYxbZD3OT7gwrzW1xzd62UGDOJ5V3ZdX84GgfHHk7z9BwCcPCa1efMzwPFDG?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OFMe7OpAayOrOXn/G3yPzYJooO53T+jqvCsW5rNnVYmmsukVQcFowELXs2EG8y/qrUbMrXwQmERinIxycQGVP6VQQ5Hc5L6+/QnmQnAxrv1HKAVvapfoHavaPQG43fi5DFx6kKRNoZeDs17htI5jpzIsrMfSDlV4jSINwT4wsleKWZ8Odua/jOhntjZiQQxX78MN27wwKzNVr7S0NdXZu4SEN9Bn/mfqw4eyG76wvsngbvzUuw1lM2qX9zZI+/bIn1M4wLDevjDaR7nyaZIbgoEJ1j9H+6C/mFFHW2/3C0xNBA+yWYjYsAvXhFL8XIG8a5ODAbv/c8gvy4QI8cLzhG5GTWao55ys6dm/CLsD64xtJ30s0QaS08rXSSs3j0vpS0M8zlSXJ874Ssb/O7arpS8e0wZy+qcTyYwah7QiPQ+kMocmoNsfyylNIta/eJF55cndWUqqAcv9bf/IT7xWW2QNf07g70sbOo+qnKtTth9lWr4DpXrjVxL059SpbNUk/msCfzafHXySJBufNb5U5M1ogSfqc/VGzOIWc6rrgmcdlpOYqMmZYudeJTsL7l6ZwZ98ZfAEyQR75Qbs5bFgiq9/g3/ntC3/086EksEaGco=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5785e4e-3396-41b5-db39-08dcf38ecc42
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 18:16:21.9549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C6ez4UcX0DQHi0gbxAq35Ja4cKvtBfLERNoL3nYxYpzIzOVNHhVkvmdO6Hh2B4avI5Ysbsy+i7BpSoWRd09Rrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4330
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_15,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410230114
X-Proofpoint-GUID: dtspn7wUuBWW6SlcRmYGKHPUk8Z6xJ3-
X-Proofpoint-ORIG-GUID: dtspn7wUuBWW6SlcRmYGKHPUk8Z6xJ3-

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241023 11:16]:
> On Wed, Oct 23, 2024 at 05:01:29PM +0200, Vlastimil Babka wrote:
> > On 10/22/24 22:40, Lorenzo Stoakes wrote:
> > > Previously, we'd always try to merge a file-backed VMA if its flags were
> > > changed by the driver.
> > >
> > > This however is rarely meaningful as typically the flags would be changed
> > > to VM_PFNMAP or other VM_SPECIAL flags which are inherently unmergable.
> > >
> > > In cases where it is meaningful (for instance DAX) it is doubtful that this
> >
> > Hm if that's true, I'm imagining many piecemeal mmap()s of DAX that used to
> > merge but now will create tons of VMA's, which doesn't sound great. Then it
> > has also potentially breaking effects on mremap() which doesn't work accross
> > multiple VMA's.
> 
> I said this repeatedly to you and Liam but you both still seemed to want
> this :))
> 
> Anyway, yes. I mean you're pretty crazy if you are mapping a bunch of
> adjacent DAX ranges that are all otherwise mergeable next to one another,
> then on that basis assuming that you can mremap() the whole thing.

Today, this will only work if there is a previous vma, otherwise we skip
the attempt to merge.  It's probably a safe bet that there is a previous
vma, but it still means relying on this merging is broken today.

> 
> >
> > > optimisation is worth the effort and maintenance risk of having to unwind
> > > state and perform a merge.
> >
> > What if we simply created a new vma but only then checked if the flags
> > changed and we can merge it with neighbours (i.e. like the mprotect()
> > merging case). Less efficient, but less tricky and with the same result
> > hopefully?
> 
> I'd probably rather just drop this idea rather than wade into something
> entirely new, but let me look at whether we can leverage
> vma_modify_flags().
> 
> I have a feeling we can't because we already explicitly reset state in the
> merge new VMA case, and we'd be introducing a new way in which state could
> get mangled.
> 
> But I'll take a look and see, otherwise we can just drop this for now and
> potentially come back to it later, the key bit of the non-backport patches
> are 5-7 anyway.
> 
> >
> > > Since we've observed bugs and resource leaks due to complexity in this
> > > area, it is simply not acceptable to have a 'nice to have' optimisation
> > > like this complicating an already very complicated code path, so let's
> > > simply eliminate it.
> > >
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > ---
> > >  mm/vma.c | 39 ++-------------------------------------
> > >  1 file changed, 2 insertions(+), 37 deletions(-)
> > >
> > > diff --git a/mm/vma.c b/mm/vma.c
> > > index a271e2b406ab..fe1fe5099e78 100644
> > > --- a/mm/vma.c
> > > +++ b/mm/vma.c
> > > @@ -2260,8 +2260,7 @@ static int __mmap_prepare(struct mmap_state *map)
> > >  	return 0;
> > >  }
> > >
> > > -static int __mmap_new_file_vma(struct mmap_state *map, struct vm_area_struct *vma,
> > > -			       struct vm_area_struct **mergep)
> > > +static int __mmap_new_file_vma(struct mmap_state *map, struct vm_area_struct *vma)
> > >  {
> > >  	struct vma_iterator *vmi = map->vmi;
> > >  	struct vma_merge_struct *vmg = map->vmg;
> > > @@ -2291,34 +2290,6 @@ static int __mmap_new_file_vma(struct mmap_state *map, struct vm_area_struct *vm
> > >  			(vma->vm_flags & VM_MAYWRITE));
> > >
> > >  	vma_iter_config(vmi, vmg->start, vmg->end);
> > > -	/*
> > > -	 * If flags changed after mmap_file(), we should try merge
> > > -	 * vma again as we may succeed this time.
> > > -	 */
> > > -	if (unlikely(map->flags != vma->vm_flags && vmg->prev)) {
> > > -		struct vm_area_struct *merge;
> > > -
> > > -		vmg->flags = vma->vm_flags;
> > > -		/* If this fails, state is reset ready for a reattempt. */
> > > -		merge = vma_merge_new_range(vmg);
> > > -
> > > -		if (merge) {
> > > -			/*
> > > -			 * ->mmap() can change vma->vm_file and fput
> > > -			 * the original file. So fput the vma->vm_file
> > > -			 * here or we would add an extra fput for file
> > > -			 * and cause general protection fault
> > > -			 * ultimately.
> > > -			 */
> > > -			fput(vma->vm_file);
> > > -			vm_area_free(vma);
> > > -			vma_iter_free(vmi);
> > > -			*mergep = merge;
> > > -		} else {
> > > -			vma_iter_config(vmi, vmg->start, vmg->end);
> > > -		}
> > > -	}
> > > -
> > >  	map->flags = vma->vm_flags;
> > >  	return 0;
> > >  }
> > > @@ -2341,7 +2312,6 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
> > >  {
> > >  	struct vma_iterator *vmi = map->vmi;
> > >  	struct vma_merge_struct *vmg = map->vmg;
> > > -	struct vm_area_struct *merge = NULL;
> > >  	int error = 0;
> > >  	struct vm_area_struct *vma;
> > >
> > > @@ -2365,7 +2335,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
> > >  	}
> > >
> > >  	if (vmg->file)
> > > -		error = __mmap_new_file_vma(map, vma, &merge);
> > > +		error = __mmap_new_file_vma(map, vma);
> > >  	else if (map->flags & VM_SHARED)
> > >  		error = shmem_zero_setup(vma);
> > >  	else
> > > @@ -2374,9 +2344,6 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
> > >  	if (error)
> > >  		goto free_iter_vma;
> > >
> > > -	if (merge)
> > > -		goto file_expanded;
> > > -
> > >  #ifdef CONFIG_SPARC64
> > >  	/* TODO: Fix SPARC ADI! */
> > >  	WARN_ON_ONCE(!arch_validate_flags(map->flags));
> > > @@ -2393,8 +2360,6 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
> > >  	 * call covers the non-merge case.
> > >  	 */
> > >  	khugepaged_enter_vma(vma, map->flags);
> > > -
> > > -file_expanded:
> > >  	ksm_add_vma(vma);
> > >
> > >  	*vmap = vma;
> > > --
> > > 2.47.0
> >

