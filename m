Return-Path: <linux-kernel+bounces-303219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDF096092B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85A871C22E85
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C894E1A00E7;
	Tue, 27 Aug 2024 11:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ne+fkSvW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Eh+ZZ4zy"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE0A19D88C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 11:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724759041; cv=fail; b=p1zAkaFeDJjOZ6L9pifaWVSlZxvfTQqdszACHEcUG57NvdnErz36jgsXBKUO4AaNIeyRpXDv5k7lmoyMFYjdJGkckbVNlironbQXWUBReqsx2/wNieeYWqyD/+ztVV4CKatD7Uz06nF6SjDgoy5C7KKvMeTdlfiJfA7DBDl9VOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724759041; c=relaxed/simple;
	bh=g55hebi9Md8xs4wjucA7MyZineOfRTJu0SBOFybThwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f59NzDFK5ZN8dehBynXdBfsN0GZGTJnfeHUYJQHZ2SmkWHHvzx3byCGxqjLT2RUs0D6FKwqTTxgoaQv3ZL0ddTjTl8CLtnR6jm42pL2W4OUzVfq+Ex3DSdqrJzhVv1LV2uE1cf95DcPCDkUcB1qiJDyxE/Ea5JY4Suw2AOFiC4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ne+fkSvW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Eh+ZZ4zy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47R5tUqk021027;
	Tue, 27 Aug 2024 11:43:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=YMHkkJq8cEqWflC
	3XCtYsHWOn2ywIQv1RTv3AnT8Meo=; b=ne+fkSvWk5F8+W1YZhGSf+47Y1BrieI
	3joueyyv63JDHC9ZZEgtyzEaoGB2gP3VEw1ZTdNKmS6qCdTK8xj4/XGNU/s1Yxao
	OqasULDy+n6ka83OSApqWbJsuWzS33Y9KqD2zJW6pkuWBoMO4azYotcTspr5JKcd
	uMUxAIeKIVakKmiApasQlnEOPLzgw16gqbabosp0HLP4LTIiIc8KwW34nowVb8oo
	NJGdyo424G5nYQDvMj99hJ8w4NQh/xsd9U/U7a1fuAB74mCCP4f4dDjVgnem4dYe
	KvzFCF7O5scmuK4n8Tu/AQhjEvOoUyhgQxVUpoAGeSCKOyyOO+I8D3g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177n45a0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 11:43:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47RA94EX010532;
	Tue, 27 Aug 2024 11:43:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41894mtq0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 11:43:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWl3mpuqTS3SEA6NuvH9O6AgiiIhHit+7gP7CiB/R54eHXq9sCo9DCG4IRWGxVEZlVB9xHAC7pQRMOxQK+/OJT4a0ptQp4zBGX25OkDVFW6UE4NNJA1OIEN2KD3XFNWD1ZCzXoWT0uK/OqJ7jDtqLTfjnrDXyiAdeiJ2UOEZ+gxYkn0hurWtmQmsMrghP4qLeIG6DOWu12gOBm4vMnYFZbFWsjNLzxMibNN4NvjIsX3NucL0sR0QAFFimVpGnO/N8AoctFghz1JccSM8g5yFYk9MxeHMaO2tjQKE88vkTTz59e52wUn2cpbHceh/4n9ELmMqWU741UYSQucwXbdzug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMHkkJq8cEqWflC3XCtYsHWOn2ywIQv1RTv3AnT8Meo=;
 b=R2agTrE/KT428apy3S/QgnDH0gPdcLJe+sxsIdkr9NX4nar7z+nGpjeA1mcV3wJa6xPhomkJP8pI2nd0uovRu/8iYklWhCbG2/tFhEiuDNFhh9B+F8z9xgCUqc11TYLQuSMCpP9uga5qJoHvTYtOkkeSkFpluc8P3rTpJW1Jhnia0u/r9LnPyBCXiAJ8xm7AtmUIbhDV1zinjng7fR0z9HezyD2Z9Q14Muhyjwl6QjieKCWcqede2t4CqpCZPXvXDiV6kIyeZHL5lLzwQRFBSFZKAavMSFB1rwywZw/i169OhkihQEC7qNCTiAwTmWM725bS/CMG949NmLk5G7pSOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMHkkJq8cEqWflC3XCtYsHWOn2ywIQv1RTv3AnT8Meo=;
 b=Eh+ZZ4zybt+VhDlJUn0J4aIhxkBZ7rb9MwpiXPK/O+QMjK31s40edDScRe1Vl1O1TiTAyS+QfSoZUeOWW7OIwgXJxIWjWpcMpRWZCWikngX7HgzrZCG8zSrec+4sr8EMLGjnbZOyG/EMJP1Z8wDoSbdi3CDp6DVpHJIWxYGgTS8=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DM4PR10MB6015.namprd10.prod.outlook.com (2603:10b6:8:ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Tue, 27 Aug
 2024 11:43:27 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.017; Tue, 27 Aug 2024
 11:43:27 +0000
Date: Tue, 27 Aug 2024 12:43:24 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [linux-next:master] [mm]  a0f2295a60:
 WARNING:at_mm/vma.c:#vma_merge_new_range
Message-ID: <c7dc671c-0768-43b5-87b1-ca1654037202@lucifer.local>
References: <202408271452.c842a71d-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202408271452.c842a71d-lkp@intel.com>
X-ClientProxiedBy: LO2P265CA0038.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::26) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DM4PR10MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f91e0fb-6721-40d5-313a-08dcc68d76e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XOWtx3v6XvqVagiCoxFttOuOjPR/kEfNlHJ5MuqcSsjt3dGBrDw+q4GI60vN?=
 =?us-ascii?Q?vnw9ex+CqJS2GRLMtBMs8/9TnjCISD0+CUFfT4NJws4DvfkqGnqahTJ8GWes?=
 =?us-ascii?Q?1X+GeBuktNEd+RgIJRmIcKiNJplzzey/ZR8lRW+qHEwGBJr1moQQNENW29vX?=
 =?us-ascii?Q?4syXvDfKmL3OrgeJJv9Csj7y1Z8ETqwlejYSEJvtu9br/7YybJpWn6GToBya?=
 =?us-ascii?Q?j5QaQmKZDN3KZfn6fx50Qd+zYah44CwuMEeNUD0Bil3Cri9YftdmyDMCLYMz?=
 =?us-ascii?Q?rsR9vxQamvBPzXIWPlZMwfKbciSxwJ0OVNqS785SN7Jr2wOGvpYKX+1rjOD0?=
 =?us-ascii?Q?6oSLoAv0ftY7N7/VLU60VaQYPY0B7m9k+17HmBAsvLiqpcB2HOfXx3KkItQo?=
 =?us-ascii?Q?f6ZivT5wT4jmhN4AqMn8GIqd3X5ds4VPX/BtdTGhP+BXDW+K4jmrvWpl2HYL?=
 =?us-ascii?Q?eh6bSj16n7+gMvAcvKH4rts98nVGbCSP7MzY6VF8NmWi5jZEiPPcrseHwiUV?=
 =?us-ascii?Q?g4MzZZ2HOwJxASQn737jUtsuO/CX98uPs3w5+HonCZfGC2l+LbBy2oWRy8fU?=
 =?us-ascii?Q?ZcN71D40wFJHt1VlEtY1irtz5RKpbUHLOCpANlwrlH7r3sF1wJraLcYEXvQI?=
 =?us-ascii?Q?+QZ/PlP2VLMonI7miC48AbOE1H+ofRwpc1ooIby88un3qO3F+6OeKiP9nO7b?=
 =?us-ascii?Q?fYxjufJ9lu/Q4ug+dlPY+AQTUmIrhlCJ/lBCwQjIdRA20exobaNduhQVCQrB?=
 =?us-ascii?Q?UOwhnIfZ7akjDB8ycKeCFW8kGB6BbaWWQvrxYKwkcEp86gpClLY0rLnRjDOk?=
 =?us-ascii?Q?mEhA+4XmRcDl0JJrReYsCqFnsvf3xpgp09bendL5CqQLBxLIFUz5DdjEJk7r?=
 =?us-ascii?Q?sKXTdyzj7Ryf3rlqrn2s2TFMGbaw67IvkxUNRWvyQVDCGenTdDv4W2jWuse6?=
 =?us-ascii?Q?z5VWt8Vb+/3Knp/Hq5CkCa/45JpAJInsF6m9sSqlYXyjyMXdJtTBlGYtVR4/?=
 =?us-ascii?Q?0HGGsWUJAiM0LBGemlxWWul90IS0lPFmgxJxJSgEZtfLNuHa3CbBMmZA/prO?=
 =?us-ascii?Q?N/ZhGF934RpoZc6X8xcwICKjib45qtUihLj/9Ly49Bo6DRvQ/x03sMBzgp3N?=
 =?us-ascii?Q?icMCpySL+ZrNfWoREJxqNB2jP1XrIRGu5J2Iz4l8BizH1UwdxaDp3VzafNnD?=
 =?us-ascii?Q?w2/CEphn123w6KaY3KNniwexceR9DpykpH+2HBxtlQCuNJJzS1UgH2PtwqZO?=
 =?us-ascii?Q?MYat6R4iHN/IY7uubkF91A/x8yIAxe12PoFvOFkV4MVe7azNrrpnYEg7B2cp?=
 =?us-ascii?Q?0qVH/RGpygc1LQxKIqwTap07?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bOAqiqOhTdgLMXtDhY1Ud8/IpUo1RbM5XGSNFVKbozh/qygLn9K6g45cwziC?=
 =?us-ascii?Q?g+W9VxoMAHWHEovwg4T4JFEGzUJ9Cuu6CaPtep2SAesdSOOB7uaYMbHRmZ2o?=
 =?us-ascii?Q?1EbjFLXjH5iGwIZLQIjbJt0d0Y1zUQ9VLmWOeqCDJTFI2o6VjZwhUP74SNUB?=
 =?us-ascii?Q?WmtfFNefCeTj2mAc3ypUFr8RjhTD/dK/KcnrxoAFbzSsIzHpQevcaNrSp5CW?=
 =?us-ascii?Q?BMTh0iixWLD8RKRmjU9yY3XtOgdRgHhOOcZuGflZrfBM4h/1LumpxMHc02q1?=
 =?us-ascii?Q?AcpYLHSp+ZcR5Go9mxji6okjrKgJF3LXJJHeUH1DnlyONmzGWT2GiHdeO4Hq?=
 =?us-ascii?Q?apPK5J5/NIzyyO1S5OJZCBVeh2Nv23j5XTuLENn+LXYmDkrkXGhIzkEoAq9d?=
 =?us-ascii?Q?sf2tUgHYOhXCN8WTsU2/0xTN4oLeLt7panetrPvLdLBqmAdQwZX6RpHXzEZU?=
 =?us-ascii?Q?mMjpq0CBlnttIhweURcodLLs2VLYW8eZtFLRPmHI15DiX6K/VAhWQN8yoLne?=
 =?us-ascii?Q?7al/yLBMvZP9kCF6MAGo/8CU//B+FJm+5AaLu1zoJ56OqWrh+g8yk4SMKAag?=
 =?us-ascii?Q?IvVm9TavVGuiafhgcNivZKZqPUDTIx/K9GQzeai66xIlBJbLJXqkvUdeBF+U?=
 =?us-ascii?Q?HP1uFZJsEk1+pYBfpeZ/SCKQlnK6Lv8SyRNf97nyy2k8K25lnyUk522EtTg8?=
 =?us-ascii?Q?cmNFdJ1hpclGhektB/1RK+uiWYWOnQuJWcbCPSpiwakN9jlPBM5r2eGouvg4?=
 =?us-ascii?Q?YTeIUjflioijYUem81niskpeVL+AMVTCIeLzT6J27KUFk2hMQbfITXeeVKC9?=
 =?us-ascii?Q?4AJ1/UIzs4rLfgkthS6lqHQ8/UrpcfnM3JLxW+qW/t9IDfnbDIWpqCQHoTr2?=
 =?us-ascii?Q?MynUd2PnyKbmcz8hdvsGcMuFcIvS/B/l67A8zq5w3k+ECKThpLry/RQVJTsF?=
 =?us-ascii?Q?IeGZLL20Iu2LrUk7G1z04sx0nMsaiUv4JyzuQ7BmnqLQSzMefAx4BSls4zSK?=
 =?us-ascii?Q?73iU4qGgpcOGJEv/G9lpsWZClmrQkP0RHBKVjvgNdK6SbhjdedZp9j+M5qF0?=
 =?us-ascii?Q?gu0M6NV+O45cIlNQXAnM+8gbAXzdhCVbq5UQFFKs9dyT4fGbcrGmWXXxxMzv?=
 =?us-ascii?Q?kBrLmd+z0SUk/+UdGOVF0NCok8Ob/7Bo8yat42YZHoo2X3xs1i7jPMnFJMFT?=
 =?us-ascii?Q?lurbRq8TXMH+A7iz5Feq1rfLis728Sf4FJeZlT8GTeANoXqnVlQAfX/YVpHO?=
 =?us-ascii?Q?EFpOiA9mqo7nYW/MMxTSz72m0HxmlE2SUGAhwlm4My3H+aAFNqlZKPkql90H?=
 =?us-ascii?Q?saeV680lZv02G7ssa5NBikT+2xerdPbthlIrcq2jge5i0y7240t5EvRuleN/?=
 =?us-ascii?Q?Yp0l5Wa0ByMWP7B6+YNudjfPwAPMB+54pvpIVfdfiRMfZMkzJY+lJLa8vmSb?=
 =?us-ascii?Q?t8i0fGdvp8fKe14lb+Y2jt8mkBjKslYxJbww7FvqE6Tv0OnJuIZmhzoLgVAR?=
 =?us-ascii?Q?4uDwtkUPPwFILgnRjHFtNZ0XGfpWGBZvVYrOE9v/r2+/9ulLONX2szPCpBaQ?=
 =?us-ascii?Q?VjhoHP74XYQyu5AzjlqPli0Uikf7/VUKFnbCpchtuEpCt8bzmFt1mBY41Dnu?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	D5Y3Nc8aCBZJWhWvXEdllV68xOgbRhwa1Focq81TUBd9DPdPRw9LSZihyR31yphvHIMLDJGBPEzkxWAHAQrAgKGfB1V8T4BeO/MQXKUxGEp1HeEpu1ZHj61xgR7dVj9MtlW7r9f0YTxZ0KThsxQpReUU8knCejfP5nW7mYklqhSBtU+ZWzTB+hrYBDv59KhMvdC2li0BdmT8qK6zGMTwqbRibBP4WVS17Fbk7gXg7pe6afq9DqKNPkK/bRRrIyv4yLv0zZOwIOMUgMMsu1aH8E+BsRIBkLcPo460X3ldQ/EK7Tv6Zr0cheIMlhXxhZJIlKN6DZJACwTFWfshYRBd6dZzAGGXNu3TmE3n4nl4CSEfJ0Xcp1FE9sHFGSDGJgTUa0CP+an+gsqeYPq6+JNsjDONPEMalsqr5RtJDDNysAW57w/4cExeleS2Yh0vQi8eOQ5ID+gDVkZSxrxTh+Y/Y0atG1CCRO6/JWXyIKMc5rXspAOC3KX/6bsZ2vJFihc8ghYDlmGky4xopnd6e65JlVEqbI0MBkES3S/SHtIv/Lwp1FaLgEum7zYTmwE+PCMV92NN94X4tDd+VphgpwvKJwrs4+H1VRjT2rEl8QNwioE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f91e0fb-6721-40d5-313a-08dcc68d76e8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 11:43:26.9557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DeCXu4BI0Q+tijaSZyMGcPTkJuZBzPf8vj0ngy4D19WXPXRbeFSWi+F2dnuQmeULOhC73ED0y+Xg0eaO9eyaqvAK25pHiJIde3HzAwGlHbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6015
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_06,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408270086
X-Proofpoint-GUID: lV_aBi-YcFTHg3zHbzOdjI2CL0I9I8NA
X-Proofpoint-ORIG-GUID: lV_aBi-YcFTHg3zHbzOdjI2CL0I9I8NA

On Tue, Aug 27, 2024 at 02:55:45PM GMT, kernel test robot wrote:
>
>
> Hello,
>
> kernel test robot noticed "WARNING:at_mm/vma.c:#vma_merge_new_range" on:
>
> commit: a0f2295a607c0e8a64893593432562444a58a70b ("mm: avoid using vma_merge() for new VMAs")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> in testcase: trinity

[snip]

> [   28.048325][  T765] ------------[ cut here ]------------
> [ 28.048597][ T765] WARNING: CPU: 0 PID: 765 at mm/vma.c:524 vma_merge_new_range (mm/vma.c:524 (discriminator 1))

Hi, thanks for the report.

For the record this is the following CONFIG_DEBUG_VM check:

	/* vmi must point at or before the gap. */
	VM_WARN_ON(vma_iter_addr(vmg->vmi) > end);

Which I was able to determine fired due to copy_vma() unnecessarily
advancing the iterator if no previous VMA exists.

I have provided a fix-patch at [0] which should land in -next soon and
resolve this issue.

[0]:https://lore.kernel.org/linux-mm/c0ef6b6a-1c9b-4da2-a180-c8e1c73b1c28@lucifer.local/

[snip]

