Return-Path: <linux-kernel+bounces-336050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8D897EE80
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418701F226AD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2530D199EB4;
	Mon, 23 Sep 2024 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M7to+JoW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AT3IlEt+"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9E713D893
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727106543; cv=fail; b=tiiqhyOVmpgAcoI/r5w4o9UYnwI3a79f0dvXibj9G9JtPXYjI8gJCczviD1pfUQMXWqxapnPb7kY1Lr424KTdis8/omT41obVlR9shpUkyMvbWRwxGDockLzmrvbztQjET+hXFtsBK98P96ibOsFcNt7o4uTWtw27KdqhDNm8XU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727106543; c=relaxed/simple;
	bh=itJ5bPRDko9a4YVVYULBxQhz2FDI3DqNsJp+romRZxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PqliNH9Sph6Px7OHlL7cDJJEufDIsAa+PMuX28ZJHuypJVDMHUC8FEXikgRmJ1a+foemXQtqHTzsWUj9LGH3jT6q0z340c9toMnqggLCvwFMxAvteNVz01LXyMIE2uTVbr5ZLwlVrgg6Osl9NYIeabXUDenoPzxT2BxAB9CzGag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M7to+JoW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AT3IlEt+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NFfX0Z020700;
	Mon, 23 Sep 2024 15:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=h+++dqmfVp1Pzz0
	7NnspTFUKRVpKXNd2HKje/vHjTEM=; b=M7to+JoWrhMS3okICFot60Aq3lh9KL5
	z9wa6S1yqsJ7tq4tuXcuT6GBtnE58hJfqVmmW6N0gp10RKt3VKE7pjHVoScMs2AF
	lycky3bZaUCtnrrVmMVI89pcYgfItejJlQQzSjWTh3Z6Um+CufEpx/qnmvSAVRdN
	2R6aaVBJCkfe3adUhDjZibqOdrM0cFatHCQJBJIWTQe286N8Msz7K9+vRfm1pFus
	beWF40yAqEhkPWYK8b4cMCj1vE7QhRfS3TkpwqXXXY6M//ba69b6AIMp6uWhuyeU
	ivpHIxyl3VA+AqkjZ4/+jDHc90JSDCk0z21Cc+fjaZz5jPAeTYF7oCA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41snrt2k9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 15:48:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48NFaubC004832;
	Mon, 23 Sep 2024 15:48:46 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smk800cb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 15:48:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XvlohU8JDp028fVplqXf5iL1z/JlFXG3Tu8aYEzuvpceIDNsbJqeSYnW9cRbiOGjNEX3yTt00tvf05cjw4I97gcbnP7MYwPjIUW6qaetvClPvO+Naga64Rt4+Rr48d8MXEsMKw34WGXxl1wCBbvD0qADfOXQ0k5zcVppPsmhAoI+tXJ6fMwX0fpbIOB/itjOM6Ax6ZP7INXRqGsoOXWUpaKJOvsTK+Q/6hUoAwSOXt0kubDs6Uzw+kjLMMLNdS/Trkmh0gt8OZXABAEI/tiJBI5R95z+C3AdOiqTK2VVOT1mZBAv29TdetcuzIEP8H6XS4wB5Og9r06KsoqCL529sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+++dqmfVp1Pzz07NnspTFUKRVpKXNd2HKje/vHjTEM=;
 b=RWqtVUxrigIG5kr+xtQPcalL2wGvebtNcVIl5K3xFel6gNnBbFII+V68HpBGRbnvfNyeCYdovT2KnRsktFsFTi2r/51B5vpfTgUX1DXf87DUmeLtFca+2Vk2KFBezl1xS51TnmA2tp1HLrU1m40LLCNyZgwf2f6E9ZdCPheqWk4Mn1caL+yWrcCoIYawaeWimKKymZx3u8b2b5ZUNwytGXDCGEVgyB2uGHSMK3HrSv1D41swHjgF2TcBkXuhmdArbjKj9qCa4g8vHX2NFfqEOE/+dwrhkndYUJjKI3kvEetrIUbGbItFTqBZ5I1PBl4GjUXdh6GpzM43ydAx2OjEDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+++dqmfVp1Pzz07NnspTFUKRVpKXNd2HKje/vHjTEM=;
 b=AT3IlEt+cxOF6V7u7p7/DE6jWNBvh0PRCUhkSYU2NOIwEkZMADF+CUexUnK2XoxiKWbdxxQcKYwM+1tdDlZVGK/qkMuFkCSi1m53Z/W3/O4HdiKoSm1p83M+X6syF18E3Q9oBqlYiD6Mu3f5qEYstguWbZt//EkiJ7zuvT3gpnU=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SA1PR10MB6591.namprd10.prod.outlook.com (2603:10b6:806:2bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Mon, 23 Sep
 2024 15:48:44 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8005.010; Mon, 23 Sep 2024
 15:48:44 +0000
Date: Mon, 23 Sep 2024 16:48:39 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Ba Jing <bajing@cmss.chinamobile.com>
Cc: Sid Kumar <sidhartha.kumar@oracle.com>, akpm@linux-foundation.org,
        Liam.Howlett@oracle.com, zhangpeng.00@bytedance.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shared: linux: remove unused variables
Message-ID: <2bae0949-36ea-4d17-b64f-19fd08e5a2f2@lucifer.local>
References: <20240903032952.10120-1-bajing@cmss.chinamobile.com>
 <f9060eec-5e90-4f27-89bd-c82476ea6213@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9060eec-5e90-4f27-89bd-c82476ea6213@oracle.com>
X-ClientProxiedBy: LO4P123CA0417.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::8) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SA1PR10MB6591:EE_
X-MS-Office365-Filtering-Correlation-Id: 27271775-0e5e-454d-cd02-08dcdbe73493
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BkxR+SonlHVTnW7HtqUs6QibxcSn/ZWC+wJoOwRKOM6AHpuzcLZYqHS5qq8Z?=
 =?us-ascii?Q?x4+eOeAT3vA1LRcDERS1nYinJRTNiHyqr679LSUIpMVF9wzqO6UtZUQ/IVQ9?=
 =?us-ascii?Q?BB8EswRqIJIGcQgDd3iNcPccc1+/Huzsgdi0yLZvzVmpaBZA9N3MqwbJOpJ9?=
 =?us-ascii?Q?ksgPVZro+MzdoRmrpC74jC5C/t3MTWRPchyCSiFm9WCXeHxethwBuMkQw+EX?=
 =?us-ascii?Q?SftxhgVbUJBVJZ6HwhR/VMXNcigHeJf05l1tQK5UlJ2BLrdSlpKHASyS57Ff?=
 =?us-ascii?Q?UbNRl4OUWjT5InUL8DxPKxxXMhq1SBqbI0fI2Ux4riMkIwzjbPYb7bxcV8k3?=
 =?us-ascii?Q?0fsUC+tiA8YsJ2agwkD+ae9YYEb/+R2TiAkTy5xlvelvjfo17H/NIOlfxsXO?=
 =?us-ascii?Q?mzG2u3rhLle7Zt5D3CGgQ90y4zZy85kOir0Ie1goLWtuoRsssDgIoxYPIPU+?=
 =?us-ascii?Q?VSmvVcRedCvxusf7uH4SpHyItcfeWhXvBIbmFnINnkGgwoEswCHO1UfbJIa7?=
 =?us-ascii?Q?BOj/NhJN9z9LzYcHXl5CrW+vHVE1H40Y2N0eldiHgsDXnbsSp6hr57pvlcgC?=
 =?us-ascii?Q?+mRDcKt5roL3u2ykbkUBQDwHeX+gXrLg7/fasP+PbI0vLXn2vcawom9by+Zt?=
 =?us-ascii?Q?mFDod7kVNH4YjgvVeMj3gBYmP1Wf4nCZgeN9nFhmCm3zziifdP1DJ+s40cdz?=
 =?us-ascii?Q?JRr1jMAB01w1qfCRQcWKNHt+Ym3CsIXmTnrBJuZN/GMtMFweOgXDb5zFbxto?=
 =?us-ascii?Q?8rTZVP2Gb4ohTOhytm2039N+P/Lv5RymlY0ThgJvn2UrWLNzuxCoqHtQ4fQw?=
 =?us-ascii?Q?NHgtNSBt/y2+67R8gEaxANU5yNZJtt5LX8taoSU0GMOTxZ+3NtRoNc/DIGeY?=
 =?us-ascii?Q?YsGzC8jRQYcRvO+wtqprBMDF0LVbF2YD3Kc8RpwfVbvi4+Z0iSeMt3H/Djak?=
 =?us-ascii?Q?qWYNU/Bi2o3zIfXhy6hZcZwTB2xCStlRZ569biJRVgGEtSlna3LjsbmqdWRQ?=
 =?us-ascii?Q?3QzIvYugcF3KmQC3qb7HYPMR8i3ymPCewYKNEUtk7V2Fd/wbgBKUQndXr0/b?=
 =?us-ascii?Q?5rAQy7hqOjqrAa4V44/8GY9fTskUrzjvb3pkqCGN7l8OwOhrSNt1jqCfsi3K?=
 =?us-ascii?Q?6IhOFw0TCiwo8FDoQYXuOAtqG6t4CspeQM08I9dJshzpCXje79J2i8gYyhFd?=
 =?us-ascii?Q?TZvY9dsxDVMWtV4YGsU/HTazHcdzTxK8uIgvxw7GhMfhZC/mjuEQktG2r6ma?=
 =?us-ascii?Q?Xv6B04+FYEh/NRDGMI0uI3PLFYrYDiDvGaLhszrG5Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Isry1P/5TB9u00YP/JEAT98GfrU2zOIGrZ9RGlPg6jJe21mGH1+cw09TuI9w?=
 =?us-ascii?Q?HbhiH9l3BJ0urB0+CEn1cAVfdzeLBkHmzn901/XadLYHhTOsY61T0TIhNlad?=
 =?us-ascii?Q?9PV6dm2CirSPqjZofKMcFZi0usIaNqKitzRtkSokGeIb8RHo7e3k9wiWyGna?=
 =?us-ascii?Q?uL31Ztk+QAiWCPZ1N+EqzjvQB3ik778/P+UFeSaKZF/rXdGTBladNX/Nd7EC?=
 =?us-ascii?Q?yQtwU868Y7N44jnEytnvJZcWM/Ilofw3tYCIIZ3xpd7/MoKmpwA/yuQ7k68n?=
 =?us-ascii?Q?QuAr62a7+UfuzN3nQLUZjwCM75+0FJIA1AbD8kYBtBkZrxKJSEQutvPiciGK?=
 =?us-ascii?Q?DEc5EpOfFxFNK6cZEfCr/uaQ8It01CrbbwCyhTIRTE17JczAB7nJOJoW9R49?=
 =?us-ascii?Q?gHQDpQjTRDoxsdrLXJ9ZFH3Qd6dLyfLwUb3L6tbyXVd7Hkhdw8mrWcCH6HgJ?=
 =?us-ascii?Q?IUbUfT6ccqWaKrhKK/CGwCLIohOKp3rL/PRfNiwX20ky4sLREZuorCdhyVtZ?=
 =?us-ascii?Q?j5B3+CC+olJN4n+zxL61GWNdDKD3miOPYM/G9Naf8OrYiCOvczrV1iRNxZjN?=
 =?us-ascii?Q?LJzbbwFu0IvyfES+VFTbp7p0mJKqPGxa4o1Od1Ioc+62L6/2dY+IxygTLppm?=
 =?us-ascii?Q?1j8/tMTpOcg7AniIKCulOE8zVHuAY2WEVkp+wnEcwJBXMaCJ8eQ4HqugVT1r?=
 =?us-ascii?Q?OvNA2xyMAM/4OzPKqvL0dVGN8GJnkQ261KxDKRRYC2eFxf4I3gEJ6wTD7r87?=
 =?us-ascii?Q?5ASkJk07ic1d66wFNupiv9lRqroomyBVkopsbWZccCVP3CL2Rc87JjFyhOCk?=
 =?us-ascii?Q?bNy4Rk/UZEWR0hal9a/u1FAykjy9eATdmPvfY0G7J1MgT7I5Pdl4XvzAuB6N?=
 =?us-ascii?Q?aKT9wJF1H/9gUEjJ+/FAipcT1aGEV90lNL6o3Zz4fhDq0tWkl+leAYjlN3Rq?=
 =?us-ascii?Q?rYb1VTheBqMf6ThsIJCWnBzqqB5d+1E9BuVIo/RLxvMyECLz2ISV6cptYugn?=
 =?us-ascii?Q?e8/AtTfymfDtOKryjfHVk4I8OkfPTGVohzB6jFpwc/4Eg11GHb4bDQmbsMBv?=
 =?us-ascii?Q?CQJ9ymJ+FMZYzf11CLjW0ta5dZXhaWXYBMQoB3Bg5S3SVshTKB7+0WI9xwdS?=
 =?us-ascii?Q?q4jSqlNBqCSTp4ZlDNpqA638RTMuhxeU35PZkMxCzb10I36poWQjmdHkjL9F?=
 =?us-ascii?Q?e1qr0aN9q20z3rbWz3g29RHQa6h0oUbcBfZfZuAmowIv08Mxv8KEU2AHm055?=
 =?us-ascii?Q?Fktr/9pUCjKAonAi/SgbBtrEfKWqtj+f50a9Y/Wsh8WXMslVrdJgQcL1XPx2?=
 =?us-ascii?Q?+m9J1jAsSerOUZVjlpVdFUNIqIpfhsXzCY0ERZQvqTUzRsMtbPcMImvoNZja?=
 =?us-ascii?Q?Xcy7TOExtX4ZRkGQgrHMQd93USVpze7Y8+3ayw8KYP78G/F/G6/+AtzDQaL/?=
 =?us-ascii?Q?VTg7ULdtVTMooUn2Ammiz0CSPw3v+amWra8L4o02KK11VuV3JSDsfccxCMNC?=
 =?us-ascii?Q?jaN1WFrcf6cVHeKUmTLxi16F5B/v1AvkrMTd0zf3xbWqUC3VZDoiyJmhONVz?=
 =?us-ascii?Q?d93oEps345S9FqVMiST+AbCJxaX/V0Tg/Lm7jnfU/1ZP4HdvOnIQN9wcicd5?=
 =?us-ascii?Q?NAFanTQJpcEjxeKsZslvq5HHXthKqmd3Sy/aASG1wNgQ/QyO3KyB5UJXKYSR?=
 =?us-ascii?Q?WsqmFw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HN1L52cB8lzoZLw2I8WaNX25pZoBzbTJziBzYDyFs0P2gjU0eDYrt/1fUg4AcMsBR/8htmAfsw51Ant+7hA1mD4+ece6dTcqNd1IWdGVy9IME4zth++FHzy3/Y1fewogNvlJXE+6WdlKPOcz4PHmgYxqyroRjKNWoZwXv/VJwKh9JK/bRJxeEMl1Yltkbphh6E+OT5yEy8aWNUABEcOVy83jJS/KqlwKmaBbJ4+1+x/vCZ5vUGK9FJtIp/GYfcn//E7t1TNVaq00O1kPrr25nw9/lnhxEgb3rUS4I4ChwAgckIe0BYul6K21LcdySM/PezHa2qoyj3LGRu6Kl9SfAH/vS1QatyHJEbVNT2lzDHI20MnV29aTD+QAwyhEXkflsg0rF3/bMq7uHC3fPjLyK4DaQecy6GlIj41keDeeVZ5Moq6e6jUImLeRmqPV61YWqXrgz1REI9klULwhKMIKSd/QRse2V/Am6RYK7al4oXEt0EXio9yNWIScOXIsh00SodXza4PczheQb2RKiSIkg0kUEjt9PerIJRngyIHkO6E13/+EsEjGPGEBpagyXd+9viHMCKMgxn+r/ks0k8Zj6UAUUiCNjc46ntAvs65lbm8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27271775-0e5e-454d-cd02-08dcdbe73493
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 15:48:44.6655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HO/SeNzsyE8bN8Dtv4litENwCtcI4Qih/fK75ELPmDWWsfsRDduRohn6ijoo5qEowleLrrs6awVE84ThXaKLCAHt0CXA2CoZipjyHmrLTnQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6591
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_12,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409230118
X-Proofpoint-GUID: B96KMbWRrQ3sJCQikPDOtKjYAyPDVGBG
X-Proofpoint-ORIG-GUID: B96KMbWRrQ3sJCQikPDOtKjYAyPDVGBG

On Mon, Sep 23, 2024 at 10:37:43AM GMT, Sid Kumar wrote:
>
> On 9/2/24 11:29 PM, Ba Jing wrote:
> > These variables are never referenced in the code, just remove them.
>
> Hello,
>
> I think these variables are needed and they are referenced in main.c within
> the radix-tree directory. With these lines removed and running make within
> tools/testing/radix-tree I get the following errors:
>
> /usr/bin/ld: /home/ubuntu/linux-sidhakum-public/tools/testing/radix-tree/main.c:74:(.text+0x57a):
> undefined reference to `test_verbose'
> /usr/bin/ld: main.o: in function `check_copied_tags':
> /home/ubuntu/linux-sidhakum-public/tools/testing/radix-tree/main.c:135:(.text+0xc3f):
> undefined reference to `test_verbose'
>
>
> /home/ubuntu/linux-sidhakum-public/tools/testing/radix-tree/main.c:243:(.text+0x1d68):
> undefined reference to `preempt_count'
> /usr/bin/ld: /home/ubuntu/linux-sidhakum-public/tools/testing/radix-tree/main.c:243:(.text+0x1d8d):
> undefined reference to `preempt_count'
>
> adding back these variables allows make to run successfully again.
>
> Thanks,
>
> Sidhartha Kumar

Agreed, this patch is just incorrect, obviously the above that is required
to demonstrate that, but a quick grep also shows these variables in use.

It's important when performing a patch removing things like this to check
carefully that you are not mistaken, a quick grep is a basic step (but not
always sufficient as the C preprocessor might generate variable names
etc. so you should be _absolutely_ sure).

Also, generally speaking, there might be reasons for maintaing variables
even if they _are_ unused. We've had a number of people sending patches
trying to remove _actually_ unused variables which were incorrect.

So, I'd suggest in future if submitting a similar kind of patch, to send it
as an RFC, so you first get input on this.

Though again in this case, this is simply incorrect.
>
>
> >
> > Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
> > ---
> >   tools/testing/shared/linux.c | 2 --
> >   1 file changed, 2 deletions(-)
> >
> > diff --git a/tools/testing/shared/linux.c b/tools/testing/shared/linux.c
> > index 17263696b5d8..eb1b1878cf64 100644
> > --- a/tools/testing/shared/linux.c
> > +++ b/tools/testing/shared/linux.c
> > @@ -13,8 +13,6 @@
> >   #include <urcu/uatomic.h>
> >   int nr_allocated;
> > -int preempt_count;
> > -int test_verbose;
> >   struct kmem_cache {
> >   	pthread_mutex_t lock;

