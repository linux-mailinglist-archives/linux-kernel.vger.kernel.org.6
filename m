Return-Path: <linux-kernel+bounces-555973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E2AA5BEF3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906BF3B13FF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9356E253F11;
	Tue, 11 Mar 2025 11:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h/EG5HRL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="P0IA1bPs"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16095231CB0
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741692504; cv=fail; b=TuDttK42dBMvR6ARMJyYwcZNn7OCQ+1gOONTxtcKXdJPs+6p85e4HwyR5hj8zThA/qK6gDqrb4z8AmMSKOuTUzq1R/aciiGZ/bRpze+XErg2/tWU9LWEVd9Sh8coInDbRZPccf+gpOzRzUEt0g0f9L9sLwYxW/XqsDJ2XqcR8Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741692504; c=relaxed/simple;
	bh=ty8CcCB1eEKDGFut9aRn9mq/YX4sK/f5HH0gPIApCAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eUqy1f8XI6EuoIMpa5rDyED+xHixoe7I/aRzYLJ0E9zX6/jl/pLqVGHKkcmC76o7ivdZCipl06bKZ9Ksio50yi/y+nt/BNVoLQucndiOGtWXouOqByH8kqNSgN5UTfRm3uqxLHIeh++rVHUb8RS3WEeMBB66CzKoyVxNTLhzBC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h/EG5HRL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P0IA1bPs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B1gQxH021777;
	Tue, 11 Mar 2025 11:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=cDVlzV+9qUVp8TydiJ
	3Grt9DiaaHc3khHphyHe6vQGQ=; b=h/EG5HRLKnZGxsJTRL4YoPVhGF8CPzdgzG
	qxMGQeaeFt5eZ3AYCdYncCYXMVMBC2opH9zhbiT6DXj2ugBEErR8YAHgvA8XyyiS
	TpF6L//UY02tSGeFyWJZ52C094Ks5CSwLLTvp+L20BndYLNC8TSskHs/99d/UUd2
	RW+WyqIrqGZDiR/qM7QT4WoXoH/dyFNSBk8Ef0XU7ddvqod7vKcEauL27yyc0PKS
	qFoaDQ3TrjaOpkxQZUp/viDI2gc2apxCVs22ekjKjQY/qHsa32Tp9KX5LM7ANl+f
	ybxBI7Xz42+TrCuiwzVzhfyL7/6MgqCTwCOHil9le/vVvKquV0UQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458eeu4ka0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 11:28:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52BBLgcj029017;
	Tue, 11 Mar 2025 11:28:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458cb8vhqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 11:28:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXPYk4ivS1u4CM0EqZx7D+iU7tROiVpGio6IdNTXf4O1loLmqOrJBfenlXlZs2JR1E72JCkMRK6JEtairTZFG7rAwCD3aP6FFdndhIT0NpdPO20DplEaWCUDOoOTmddSJX4R/YLLuWQmoLXlfGM5alWDhipXPuTgMtbbNofW+CrZP05kBTBik06zGMveMvR7Pk2iyWqg01lz+aM21Z5nMTwMFSEuilbCiOoTpoAZy3pbm6ztjjhoSo+O8Uzxz275uZc0/Cp9MZpDMYPkKJ1+ThkpNf/x5LMfLIpVQa2rOVC/Jwa8490Mvlv2BIEn1wX+SKfC73W1owgf4Civeg26/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDVlzV+9qUVp8TydiJ3Grt9DiaaHc3khHphyHe6vQGQ=;
 b=w3RWv0off/c1fBCiVz355c0sGpObjm0npYTqOz01hIzl8PrnCN+Nj15nWBzJrUpqEkvWtA82jNDt3JQhWWCdbn8TeSmB3i7dZWZD2JjyZiHlVaYBYa7c+I/AzUdZxQ3Y2evZT0TjnIi+FjTbXrv2MIgVBTj751Y9+2nzC0YKXnWSDnGtS/BiaWXp6BFDLvsPce7v1JV7Dk1SqaKC8UJLyeR2j1bqsq7nJQvEd1LzaBqtc/5R+gXgwk/QYt1oszLFE4EWyqE1YEry+oEBV5EbK6MLI9eVVtBxbgcVhBTE4sJMGV6QGIBX5VJkBVEybf6AKnXVNsfL/G6UZSuOLG9gJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDVlzV+9qUVp8TydiJ3Grt9DiaaHc3khHphyHe6vQGQ=;
 b=P0IA1bPs7OgyDZt0IKW4x8fk5U1LGlhLiKrwTliYfVWh3BlwqV5FueqaUzqWJSTjyHjmqTJN0KO8F8x+byrRJgRWHv0ScabkULr3BnVAyxMdgXwZeRhaI/Ep4KQWBuAezssgTl2WzcdmIaIbl6mq28l4rynbtwUrLLOQwgmV8gg=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by IA1PR10MB6097.namprd10.prod.outlook.com (2603:10b6:208:3ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Tue, 11 Mar
 2025 11:27:59 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Tue, 11 Mar 2025
 11:27:59 +0000
Date: Tue, 11 Mar 2025 11:27:57 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <howlett@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/9] mm/madvise: use is_memory_failure() from
 madvise_do_behavior()
Message-ID: <0e8c5b99-6b9c-4e10-b33d-42485a943125@lucifer.local>
References: <20250310172318.653630-1-sj@kernel.org>
 <20250310172318.653630-2-sj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310172318.653630-2-sj@kernel.org>
X-ClientProxiedBy: LO2P123CA0089.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::22) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|IA1PR10MB6097:EE_
X-MS-Office365-Filtering-Correlation-Id: 0953d4ff-5544-4f64-af21-08dd608fc70e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CecyeGP/P0XN/VNShx0Wf5MxylEjguvypXPWkZJ5Wq+64oIV5ptR0BttK8Ta?=
 =?us-ascii?Q?VId9CxjRsIPfScI4PtuqWqgZShGPovtw5jC+re6dcXc9MS7EfeInnrbXdsBP?=
 =?us-ascii?Q?XalgNhT7Z5K0JRu1fnja733xwrtP0ym7pH3KWNVvkLb9EQZTkPHRmNKCllxt?=
 =?us-ascii?Q?gHy3bAFEa4eMF5EWCbvSUF3HyrHTO3HBoqWvHo1/woOsGPKK6tH7X89pI4h5?=
 =?us-ascii?Q?eTOOse2nMA0BT24L/8yPG5tiETzlWgLk8LPtV2ZGZnlBbHVhvfAjgUnG93kG?=
 =?us-ascii?Q?GR3H5Np1HkWOtuxm04+I7jVQcqvJ6v10x/xBJ7Foh12zHmjePT84QsSCAJ2+?=
 =?us-ascii?Q?vyFPUBvoQ8xaLsE4gLAsmCk4RafsVty0vBvNLG3/1tu5b+IxnAbwK+qcHWfn?=
 =?us-ascii?Q?dZunrMvRZyUwSmTg9pUtAspEU3WdnYmWWGRAXPwWPQyUBH7WGXS9cUM9kjLB?=
 =?us-ascii?Q?VXdrGUw82IbhtaYbDNKgfaDP601C/V7ih3sDmV78OtSzGHlg6kcl9Mz4GrPq?=
 =?us-ascii?Q?egfzyS1TRoWOYdkOJwDHV03hEFC74/u6U0gIEllTJ2pijAYESq57Qeq+wc5h?=
 =?us-ascii?Q?jNz4lL0Tb2EiRgEVzo5pLn90P/yWOXZdODgXELnM8UmmTIuyBF+ClP1r1oiA?=
 =?us-ascii?Q?MJpkjD8ewiKPPcPX74qbkbQ8ZRrk/HBJdlDU0v42pbEJtL6E4+6KwIi7vWfo?=
 =?us-ascii?Q?uOB2SItUeQo+PhCwCFKea7C31D1F4gFHg2jrITYJTApNKxYv5oCYZ0qoEmF/?=
 =?us-ascii?Q?wawrlyjuJpGHFN5ipVk8w5Ote49eJkadvtP01CY55lNSRNiAr48NnQ3L0nYT?=
 =?us-ascii?Q?K7CaXyKBopenoHsaK8ZwQd33MK+9Np4T6XXFgkb5HHYojxUxygZbGURHTwLq?=
 =?us-ascii?Q?WTSimdv5KTbhWs9B044MHQWqw9G+k5mQCCHsD7rysOatkVbvl92wiPg86Mmu?=
 =?us-ascii?Q?JnqFJgbgjmm4AOYsH0CkSf/bRgfnzw+/E9B/MYSk/lpfzEBeH2fImfJj5uQD?=
 =?us-ascii?Q?zk8uv/JXSU7DOKXwyHfoiOQKKsLMFgznZNtsNvU7KNxoiDsC28Gqjw5qiIaE?=
 =?us-ascii?Q?uTrea8Pd5MQz75zSN/sKdmcZ2m7Ehb4h5kmItkcwTdODYl2OKnmXWxWgH2YW?=
 =?us-ascii?Q?DU9LoiJaOk/ajeuWZCo9/Wo60t00R+gGDQnuuJ5035/oZ2+gB0NRMdCfH2fy?=
 =?us-ascii?Q?74MySChV5lTS3DK1mKGNYoKQ+D8FKkvpOk3Q+KSwhDF+A404omgeWkLE1zEC?=
 =?us-ascii?Q?hhLvW/L/91HGE+kI8w+XNgrfeYA77oLmCw6Gk17ItfQcGU1wXa2X2dEF4kmU?=
 =?us-ascii?Q?7KElmZ8fTGVfR+Oq2B5ZgVZqRda2MCemWQ24p/MybtqaOwqOnQDd0JbpiksR?=
 =?us-ascii?Q?LzhwX0iACkCufbPQNWBGckwq8MTW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XBEGr0kMIWaZ6BSc1mgPedBLBcrcAma9QiBZL4g7ciwT76xG6ODQ3gHNOHJC?=
 =?us-ascii?Q?QFprwAfg3EDEJ3CCa03aHZ48Rh5gefZ4Twfe3JmA1pDfsM+T3R/SXOkTNlxj?=
 =?us-ascii?Q?CZVZPGLUuhmWSkpw9w6CUPZ7VeEBSACmtw5ndNMLjsJJYk87xuvq899XxL5A?=
 =?us-ascii?Q?vyO8fe6tFEb/b6PLuOF7xmRgbV6Tycuxxdt1QfsVf+FXdbYQqWLRZJG8UCAj?=
 =?us-ascii?Q?OhC1DNjUbfKP1jGvrd6fHhnJr7q6ISsZjobO1BbHeM1Yw2x4EfhlSr9jZ8PC?=
 =?us-ascii?Q?i93yrlBg4TckMSiX4HM51xoiMPhGSVIXh9xME6sOcM8bZFpcHXjo+7gMiWUb?=
 =?us-ascii?Q?/4nt9TrXIv+Iml3Ff2BIMM0HEIJ8VGzpTrueHS3NMuHwfjn9MJKcna+uTiQJ?=
 =?us-ascii?Q?6rai38FkZbiXRzArdeymDSrkrpql4PB1yP/STl0R3+Uksuj9UgAwD4HU+dZr?=
 =?us-ascii?Q?3QV3hodf5DFqtnLSlzhdQEhnRBrFJUsfbN+UKwNiVqxv14XTdZX4XBstk6S4?=
 =?us-ascii?Q?ZtSGtjEoGe0ne/aFpJD4qGaM0G1JVBN31jDzIk2hWmCI3Zz/IHK3b65/w/oU?=
 =?us-ascii?Q?JkX/LHPvESNFlZQ9jxAXQa/0axFR/fjZ33A+Gp9TQfnHnnrdugFGTtiCJLVy?=
 =?us-ascii?Q?nTgAmMokyq0G2lb7wH/sxmlHKYuDmOKzNgnvRvdfgV0qZF+Yf6ITETVBmEZA?=
 =?us-ascii?Q?LW8k6soFR7oIbOA3F7hUhVqWMKcNqycp+eXTagkhpQHtv3VeJyZGIoOe/589?=
 =?us-ascii?Q?IQ2lszida6DminOcow2WkdG9qB0M4yDIfZ9h4i6BNDHuihr8pUgmdqyWtPCP?=
 =?us-ascii?Q?9TTqmwjWSacYga2YyCXYO2KDgGyiR7LK3SfFMpMf5mvyLx7LG8kw5Ssh0Zjq?=
 =?us-ascii?Q?y+MKXjsL6pdOlAuA6gxTorE1qSm+YTHkC+CI6ItYmGkjvXknTik2SkzTdF1c?=
 =?us-ascii?Q?0iAvbhXkgCjSf1fylo3lKlPUHi5ChCLyT/k48dYxDElpXXbNgHA133UvUoyO?=
 =?us-ascii?Q?fCuJvtGrsd41TPHDc7Ob+3OZWQpYeZPegKww89Kufg+x4rulGT10RHjmkNVb?=
 =?us-ascii?Q?8rw8HX8RN6rbZNPsObS1hDLkBla2403CuZaO1G/V4RGZRqot0Vo+PTurIYII?=
 =?us-ascii?Q?eK2u2/Wgcn/fRUVLSq0I1WLdK0aNn+279M1oKJkE2bdk6iQBYljcQyjljgnA?=
 =?us-ascii?Q?iXaESBxvUBjDjyYQMFwGf4LA1IHAvPaiPWHCFdk9+bBrMguypTOenwL1GJLC?=
 =?us-ascii?Q?pEqxOHUFlZj+cKYmuzj1Xx2LrDlpM5Eip0EaeTqtXB5Sw7t6rlDNnEdNOoui?=
 =?us-ascii?Q?YAgHZqMxTTOejt2+cGUHzlbodjyUIYIMEe8oOb3Oh/xip9FIlH3Pu9UCpsI8?=
 =?us-ascii?Q?I5E2wR6apRd6gifhoEJLTrTpzoSlfozQxYAb8nKJ8WFjraz0yQIs95Gxju2B?=
 =?us-ascii?Q?o4OqkRC8LK3GW8qkb1elmuPP4u//MoywvJHwaK3oN1qvUFw/sUFFEfZGAcJl?=
 =?us-ascii?Q?fpFBUeZJGrEDsNO8wZBnmeG7miYQMuiyyZL1tjDXkUoAlplPr/kF/8g/Lq1n?=
 =?us-ascii?Q?etjam0uyPyIBPbkzYWunRHs0+jrXTDhgZVBe3xv9RQCiFYx3JWM44xao3los?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K2jGhFwgf21FcNlR0oJDvn4ShhdMN1PalArgacNwu7+OySMR87grs/5fcJBIhE0vxPA9loLwSxmAohX/BS5Bm2LeirQeGXWO0PR7sRENoFLCaV9gPFw4xrmDDKPt7YlwuUJTQdJEsTAeeWh01sApL2EVKEmBuYKwOJ4E8GLdymO/KiwxdV/nwz2/+2T7wfdwg2ZYoaalc9mxUtl1BPtrhltESv50BTFITA8gEUO1wTwZ6UYzrtmamnwr2tNQCh0eUFelLPJYuiDzXWoiPj4F2MGkeGXe/SZ8lynLmUtzvHd1CpY29wrnsBEzI+MYXQHm39+h1MeQ4Rs+LIrAUozOYTOIa9O0pZsEuG8g3BW5AtuJ3r9FR2wvPjsFdD9eWXHpwkyUlNgaUO+ulFmZiufLwJyclkEdU1CNncG/I+FIXt6iWRvPlzz9f+XVoGg22XvhPoUdXcuZuoylfFsdrow5AV0XR6thQU10md2pe4+W2l7MC0el0B5TbmXmo6td0HDWCqc+mzvZYGXWL0wtMfIh19REJLOvuNuLUFkCcdbURV5Z/Fw+iwjpz+Fcaja33heTCQDOBeayLnC3bat8dB0Gv7/P+i15H6uQWkNfdhokB2I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0953d4ff-5544-4f64-af21-08dd608fc70e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 11:27:59.4118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SscRZCrGrTRy+sj7dXRKFHCrlrKOKVYXp4D9uA+Hh8IaQxtwsFudRXoctWKoKT2ra4UwvBb2QUr6AH1x1B9oCgSu08Y4FAOJHT5U1nniV+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6097
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503110075
X-Proofpoint-ORIG-GUID: nPUCMq97xavZLGPpEewFdqaanTyYneVM
X-Proofpoint-GUID: nPUCMq97xavZLGPpEewFdqaanTyYneVM

On Mon, Mar 10, 2025 at 10:23:10AM -0700, SeongJae Park wrote:
> To reduce redundant open-coded checks of CONFIG_MEMORY_FAILURE and
> MADV_{HWPOISON,SOFT_OFFLINE} in madvise_[un]lock(), is_memory_failure()
> has introduced.  madvise_do_behavior() is still doing the same

NIT: 'is' introduced.

> open-coded check, though.  Use is_memory_failure() instead.
>
> To avoid build failure on !CONFIG_MEMORY_FAILURE case, implement an
> empty madvise_inject_error() under the config.  Also move the definition
> of is_memory_failure() inside #ifdef CONFIG_MEMORY_FAILURE clause for
> madvise_inject_error() definition, to reduce duplicated ifdef clauses.
>
> Signed-off-by: SeongJae Park <sj@kernel.org>

Good improvement, thanks!

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/madvise.c | 49 +++++++++++++++++++++++++++----------------------
>  1 file changed, 27 insertions(+), 22 deletions(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 388dc289b5d1..c3ab1f283b18 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1392,7 +1392,32 @@ static int madvise_inject_error(int behavior,
>
>  	return 0;
>  }
> -#endif
> +
> +static bool is_memory_failure(int behavior)
> +{
> +	switch (behavior) {
> +	case MADV_HWPOISON:
> +	case MADV_SOFT_OFFLINE:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +#else
> +
> +static int madvise_inject_error(int behavior,
> +		unsigned long start, unsigned long end)
> +{
> +	return 0;
> +}
> +
> +static bool is_memory_failure(int behavior)
> +{
> +	return false;
> +}
> +
> +#endif	/* CONFIG_MEMORY_FAILURE */
>
>  static bool
>  madvise_behavior_valid(int behavior)
> @@ -1569,24 +1594,6 @@ int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
>  }
>  #endif /* CONFIG_ANON_VMA_NAME */
>
> -#ifdef CONFIG_MEMORY_FAILURE
> -static bool is_memory_failure(int behavior)
> -{
> -	switch (behavior) {
> -	case MADV_HWPOISON:
> -	case MADV_SOFT_OFFLINE:
> -		return true;
> -	default:
> -		return false;
> -	}
> -}
> -#else
> -static bool is_memory_failure(int behavior)
> -{
> -	return false;
> -}
> -#endif
> -
>  static int madvise_lock(struct mm_struct *mm, int behavior)
>  {
>  	if (is_memory_failure(behavior))
> @@ -1640,10 +1647,8 @@ static int madvise_do_behavior(struct mm_struct *mm,
>  	unsigned long end;
>  	int error;
>
> -#ifdef CONFIG_MEMORY_FAILURE
> -	if (behavior == MADV_HWPOISON || behavior == MADV_SOFT_OFFLINE)
> +	if (is_memory_failure(behavior))
>  		return madvise_inject_error(behavior, start, start + len_in);
> -#endif
>  	start = untagged_addr_remote(mm, start);
>  	end = start + len;
>
> --
> 2.39.5

