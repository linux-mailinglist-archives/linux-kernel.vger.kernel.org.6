Return-Path: <linux-kernel+bounces-374959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D91579A727E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68A991F25639
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4E41FB3D0;
	Mon, 21 Oct 2024 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZRKm3MpM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R2ph/RpF"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FD01FA251;
	Mon, 21 Oct 2024 18:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729535811; cv=fail; b=RsQ5HgMTHIB+3EPXrY7S2bPcZEA3o1QlTKvr6lAttfygYgLqJgKc6gvvQiqioT6cJn42xq8AmQMhNTMwyKARlsrJC3oGGQVYB54zBcsO+HKjUnXp/FVnq3T0HqGJDpLxY9sy7oE2CnmJbjDPVF25GFILe+ROPJY/tYmKqsOEY5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729535811; c=relaxed/simple;
	bh=7S8151f+r1QddJ7bxM2w5zJUPPqlVUwrYVCQvObPlyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TfMsbyP+INriO66KtGV4ZkJtjhW9c80hZQSEDRJUQmDoGvocjyQJevhGK/qdNcut0aPi/pBCP77JRbblT71RiWsTBUZip6o5OVJwOdPNuo8DY921bW3Ly+UaO3QYAsraVrIcR49l+GGBhknWNiAY+Ecq/RJshpZHmWcCZq3z9l4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZRKm3MpM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=R2ph/RpF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LINV79008935;
	Mon, 21 Oct 2024 18:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Z5RtEn+lf3sUliG36t
	YMGUtt4OUCjekDjc/F7HexYno=; b=ZRKm3MpMn5z+ay9MEdLX1mWmEm8OQgAmFs
	WejqTZN/uTDJ1xBSkD+Vqc0I6eNo2370ZqqSQ9EC3pAo6GTQLaDatpIGVY+8HG6a
	omZYziZwoP9SVDk/q9YPGZ+RoKpYqtC/x8zcRoEU9um/3EDKl5f+q+186gwqWKBr
	Schmc2L3MAfkUbyvBj0rT7qdVCFaKFQL6E0BRVG0fKAQpuFMXXSU2+gyZkFInVhL
	zhU8AsGPG2jvrs0gOqqABtrFnKG41bXaUELC7JdPCDq9jJiQdPQDQmPOtmdaGaZ3
	DOuW8SgjJKtErU53ZwkxGghDNfsi0ZfLMAlYDIRk6anjezCUYh2A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkqu584-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 18:36:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49LIRSpR035359;
	Mon, 21 Oct 2024 18:36:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c377f6wa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 18:36:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7dS0ucCszP4R32JIXSazY1kj9JNQOtb/YelVUPlAvTOwkmLEc1VWu6i7EsUgV3h2uGfJdU70PzDP6PGgum+iFxI2HxLyTjt9LpnJbg+HaAvwtkEefjL/FDVMYRV0Rj3BcwzT+JVHITGUyjtTtjrMkxx7/TUokQIcNkyNAOEeLuDPjOlRlzXPW2VV/gJ5CnHIKQZU+MdiaWe41Re/cvAnPhZa+1zGOXUx+XqGR1m/9a3ENMqGSTKinFNpauPby+lPp8n9mQaH1+zsrtvWE7KjU9ExdaqCVGKCRebaqcK4MuiieVbVPVhHIzQD9TJc+/ZphSsaTrX/HvAQZlfdg/RZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5RtEn+lf3sUliG36tYMGUtt4OUCjekDjc/F7HexYno=;
 b=AKYtQUdFeE7mbM7SUG1Vh7VdYoVVvHa3pI/ybdGztOE2koCVM2tYn1wNFHKMMPtYhOTJa1mXCPVa7pV2PhRyoD7FrWdGZOSERfnjKzYtFMvhFjKbzeUdGkyalhpw0Q1X1eO5ijKJK6w/Z/z21V0u1ETo8FU2YMoDdOxD48nZTKtV1vdPky1Z0SjM3xLV6dcmGP3lu6IvgKYpCJZjyhkuUJLRyUCBs/EKr0eED9j4ESWboxZsx+INZ9aR0Noqb/kykGV40KWZzvObuy9ZQal7ps5bFBpnzRZlY7kdhDiGnJ/AHbNL93LH3qG+zj7qZzLgv++T7iBHQQeTX1wirafJqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5RtEn+lf3sUliG36tYMGUtt4OUCjekDjc/F7HexYno=;
 b=R2ph/RpFXvbWKZWHv7IoOSZeZBhiY1BHN54x8VkM+kLFelGQUnY+afikAGUmuMxNwED58sboUJYNb6u9p5/ZqeVuwQTG/mIkmFAXDIYntlhIqIFgKm94w+2bqYT1eUEKUp5oxTTTZ4Q7JBgHFp7Yak97td45ffCECzCKIcu1IbM=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by MN2PR10MB4192.namprd10.prod.outlook.com (2603:10b6:208:1d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 18:36:41 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 18:36:41 +0000
Date: Mon, 21 Oct 2024 14:36:39 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Sasha Levin <sashal@kernel.org>
Cc: torvalds@linux-foundation.org, ksummit@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <xhjzj6kfgg2dxq6swurwaeyzqtd2sl4dat5pzg6jolirw5og6z@bmwdcuwsf2bv>
References: <ZxZ8MStt4e8JXeJb@sashalap>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxZ8MStt4e8JXeJb@sashalap>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0074.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::27) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|MN2PR10MB4192:EE_
X-MS-Office365-Filtering-Correlation-Id: 62e46f97-fde8-40e1-2015-08dcf1ff4e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9HOqhBrmUhHd6DvZ40R4TPKioZViGklJu17HjG0C/N+ks1dNnuSwg0I8xzrc?=
 =?us-ascii?Q?cEyEO0G/DYm7u9u09GGDWr89HfCNOoCwyQgmxu9EWgPejqg7W5BF6060x0p7?=
 =?us-ascii?Q?RPmcH66FSgnMfOGLYz57FTNILQz74J802eIcld9OpDU8fHpaBDdAliIEUcAF?=
 =?us-ascii?Q?I0aHTaHGw0xVD0IiifbV86JAcPl5aRKaFvguY1LYbnXJgYo6IoiI8kpkYoth?=
 =?us-ascii?Q?mB5/YkHZZQuQBaThEZUOIghUvMyU/xjP5xY9QIA4evA1/atODgjfu9YQ6j76?=
 =?us-ascii?Q?rHPxwSCvnOxhQAQny+IK3ju1DJ9qW2RFZ1rmHxIb/1fiMKcvzhmdiU5XAP38?=
 =?us-ascii?Q?0JNLlITEuIhWlLQiY0ugXkBwTYj2UPNwzeEzK4dlvFN1FACW3ZrZ6Dm3z+0t?=
 =?us-ascii?Q?WAo5Bm6jRaPyg/cS3daonplpINcn53KdFnjteqcp/fvwRfYawAH5rybk+xJG?=
 =?us-ascii?Q?j6hMuf2ckSuQFVAkjx95rueKfaKCncqFnu0W157kDFLBC55gRdBXPg6cD3ew?=
 =?us-ascii?Q?ijHvNyow6K4yxdYSFQjPf+fkraSUSijVkzj5aXwwcnPUV1DOwKe0sjPUgVWP?=
 =?us-ascii?Q?nlnAjVLcA58Jbfh2I+5C1vOfaFMC/LBfVnf0J97193G9dTonZom70I54+cp/?=
 =?us-ascii?Q?N1Qy1SWUxZIWn8/GiaQnXqgFUz1KNuttDGMQZH9h+QJemNjT8PLsqFAcfJSk?=
 =?us-ascii?Q?EXP1rYuk5g6LMybV91FHYk/OvOROqX6HdgujjF3x72JCHcCTYjPB9Qi9LD8L?=
 =?us-ascii?Q?r6ghlBm5BNyEediugIiSvSXWr/fVpdd/ILCmWKqq4dadDoFGGPZhkKBYnwzC?=
 =?us-ascii?Q?TgrButdYnQFXFpwdko/RNIa1ov4yeZ5s61Fi4ygnvdH6PXxJ90iZ8ACGErV3?=
 =?us-ascii?Q?KQinK5CVx13fNShlAgGDyulL8VatPf4ybqWF+1s7qGNCIUPlTJmvPJRGSufK?=
 =?us-ascii?Q?rSivOzHHR8NvtdBp76XxidnOigRbqwzQx572flmnf9+1Qfh8I7uNaERtK/7a?=
 =?us-ascii?Q?k98jJjmuyIKoObrbuyJ/xR028PBkoEQNADpKSKI4jmzt2qWyYyEOv/POiTqk?=
 =?us-ascii?Q?ILZrihvR8lFslLDbd+3ipueQOMVOo07A3BzR65MhfwCQ3+vbM6DOGpKbaXB3?=
 =?us-ascii?Q?i3Jw0RRZyXKxgkw4AI4xKlDXfAyCiLKkzaEYHguA280PX3M6sYd3mH6xG9O3?=
 =?us-ascii?Q?+hu+xSRPUK1m8+fp1mQWoKX7cJVU6hlAZwi083IYz+c4w4U3/zSqqyJgIymE?=
 =?us-ascii?Q?Esv2pZ+JD2VY0Tvdr6A4kzBYU/sZlX0H1+T5/bbsbZkPl5rUIEfbN72jjqN2?=
 =?us-ascii?Q?fZC9EeDYyfDVDmL/LJoGoPKn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ildthKxxrY5D7aLDdtzH9JqyGFVSxzqhCPyGu22tspJCc+VLyharoOLQ0n3O?=
 =?us-ascii?Q?VmFc98FEIenAQkM+jnhuTpBcJtWnjRtk7DDJO+89INuXeZa4dTTuXWJgQd2z?=
 =?us-ascii?Q?NJq5xMEmDKdCCdVlAVjzB4/wtEKkm0GVhkZnt93b6wfNrY0sPi+sMP2JBRxn?=
 =?us-ascii?Q?XE7H6hnKlkZctTr1fO7E0HFDTcmAg6Gi/twvdqJkxGIi9teHmRSMrJW4s61S?=
 =?us-ascii?Q?cUC3ta4Li2Inr5PBIP8PahYBoZ0QO9w8tLiyXcbaW288GR65AwwCV45gAcpZ?=
 =?us-ascii?Q?UD9w8NUqC8QHwbPP7ird9a69QYmoc3XIyrFwl3GZD38CdVhF59OY4Jg2A8hK?=
 =?us-ascii?Q?k8f6mnkuXcspGajgynbpkwmeDel59sPpMY4G2zMy4MeoZ/TwgUfmpXVFkbPw?=
 =?us-ascii?Q?QFEJwy/74YoeGgsSEk2riO6MvwGY+pN4iTDW6CbFHnaW68iyT6NHbbAKTSaQ?=
 =?us-ascii?Q?aWv2bt+B1VzeDsW6UPJstuzPwN180F8I0SHd1zzgFDFG612EeDQ5Vig9byRP?=
 =?us-ascii?Q?GmGO+QSz83KqR/2V6UTRfE/y7Y7gLzgVgeZcbCwchTNCSZY8K4ombSV38/xY?=
 =?us-ascii?Q?yLCUHGqLvlQ5hkPx1IBFOxokMpzkjlhFosWoTdDLTxMSngCt0fsl0q+eb1X8?=
 =?us-ascii?Q?0cmnqf+JDbpNQIYjLA1bb3ofAVRWUUsqn9Y9R2Shc8eQkdjfHv7MHLseOmmO?=
 =?us-ascii?Q?INvMtT7dsXh4rqVFCPatgxANf6TAaKWEvXGGRv13B8TEM+IbkvUBO3r4J6Ls?=
 =?us-ascii?Q?pv4f6/mCDGn23l1fm9eyXWmW5VmNtET2Z8s1aq5rkLNa9Vs3zR+17/nfOL2k?=
 =?us-ascii?Q?rypf9x44DjsxK/2jaPflYCSt0aMhUlBnZFJFtUHKrVqnhGaxYE6l/HmyNcVO?=
 =?us-ascii?Q?6VRCZ1wxJF0KKBN1EB7SneVcIRRbl5ud2FDL78OZREd0luo8G/02AmF11Z+2?=
 =?us-ascii?Q?zupiEV8axv6Xrf0UH1CY2PiFWca9COcidIM+5HQplN/mMmEFmIRAbKX8fHTm?=
 =?us-ascii?Q?mX1unN4AiZHutgGQZm1MtGdhdvPJHMuXxdZCwY77IJhYSD81viveb1Dux5qj?=
 =?us-ascii?Q?+J6MkVfU11QmF0xTxk7kDXCYvvTS1+r9rK7org9zVH1/am9Budc4u+C7J0HZ?=
 =?us-ascii?Q?nvHbgzX+3kU06QwGA1BS+jku0xjw7qFUO6VVgwQUVeBXODF2EQZHrWLNIA3r?=
 =?us-ascii?Q?SRaxokKxNAah8+O6EMdHbuJwsJYIgnXKlMRf3BH1696TM+w3xcAh5aW1ETMq?=
 =?us-ascii?Q?CA6ngZWjwZeTs/w+TpjSVP4oOR7BLeLuEP4xDlwG+wWCbukKuH0zEnsXoWab?=
 =?us-ascii?Q?VKZKzyJU6xYRR7cRIqfF1ylvattR6Zo0xgLin79yQquoy0TrM7LT6AGJFM+6?=
 =?us-ascii?Q?UijwbQC7S9NgL+9X7NB2AyvOqWd39raRIuSrQeaaRgIhzpHAjobFZVyE9C1A?=
 =?us-ascii?Q?4Lbs1qw1YVXfR7OR8YdkjG6FojPyjgTDYjHeBhr+WXDYCc+CRc9k0IR+Kr1Q?=
 =?us-ascii?Q?PEA+bcbYsJ4iT+Ux0YqF0jUIdxhXbxU6oIh2ttTI7suoLecG0HJJ0nouy1PB?=
 =?us-ascii?Q?Oh6Xwrs5uP7Gv5cEaVqFJ2iDt++Wk+n2DVfsfpN+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z5jvD8Cb5oAEURfGl4Ol47xBUEDUZLMLNFuH8J/jvtYDHTuugn/2J/YAkez6Ku4D6DmI3ewiHdFnXv5xG5aH0wSbNlDSG33CaNGQYpMb+czJ4CpqVixYStGN1RY31a1ve75pB62+HOa8f08lqI1NDwZffkEyl6/ltaNOfe9jZ3pL10/vmA3Zqvgj5Psiplm65Xxi5tCJ4lDyerc9Uj/S2aneTrE0G8sYeWTVJvDcEv/vXEJotIPKXLAQIYxJIPwQJTzsPF8IDmPWrxcPbEBhrStR68BLXpygYjUbPxGj0rM2rHRFciPNfCHiATnTbrd+KQToECe7iQSGOr1ZcWpn4mg+9Dg3DtNqhcL4r2HFNgj3M68vfhM5djFsqQsUMNXKZ3XK0oeQ8/X2Ti0gjpK1uX2V0PCrwNjMGuqv9US1Zjg/z69GAJZpyHd5BFdwDm/sKbVafCEtTSFMBGAbRGFw+HxEecpDhsGtg4sddrbcAt3fV7sszq3/ENAnU60rfq40MWLtIFNorukkWX47/Bgr6ilfAFKZdx6WiTqpOpRyvnXMJEcwFfBoASgcLbNgYV8cKp1gPxOE9LU15Fl7kDzd2VJnm3UQoGvNC0DVwcjq6Ys=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e46f97-fde8-40e1-2015-08dcf1ff4e25
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 18:36:41.1982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CdXzuGZ1BmBoPd2SapXhObB6OQ4okj7Q3WN4NHRwaGvBIznDRrb4RqJTO3IC8xGZKGrDU6eNI2v5W3tQV6ITSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4192
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_17,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410210134
X-Proofpoint-GUID: ZyHZFxEovl1XRfQjCapIV0TyBfFkYPL0
X-Proofpoint-ORIG-GUID: ZyHZFxEovl1XRfQjCapIV0TyBfFkYPL0

* Sasha Levin <sashal@kernel.org> [241021 12:32]:
> Hi folks,
> 
> The linux-next tree we all know and love is widely used by the kernel
> community for integration work. It offers several advantages:
> 
> 	1. Early detection of conflicts between matinainer trees
> 
> 	2. Catching most new build errors/warnings

Would it be difficult to catch branches that change things outside their
scope without correct SOB/RB/Acks?  Asking for a friend...

> 
> However, it faces significant testing challenges:
> 
> 	1. Contains a mix of "ready-to-go" code and experimental additions
> 
> 	2. A single "bad" piece of code can affect testing of everything else
> 
> 	3. Low barrier of entry, encouraging inclusion over exclusion
> 
> 	4. While linux-next offers early conflict resolution and
> 	identifies build issues, it is very difficult to actually test
> 	due to the abundance of runtime issues it tends to have
> 
> These factors combine to make linux-next a valuable tool for integration
> but problematic for comprehensive testing.
> 
> During the Maintainer's Summit, Linus Torvalds expressed concerns about
> the quality of testing that code receives before he pulls it. The
> subsequent discussion side-tracked to the testability of linux-next, but
> we didn't directly address Linus's original concern about pre-pull
> testing quality.
> 
> In an attempt to address the concerns, we're trying out a new "linus-next"

The names are really close, could it be something that's more than one
character different?

linus-pulled, linux-pending, linux-pr or something?  They are also the
same length, which adds to the parsing challenge on both typing and
reading.  I'm thinking I'll get emails about the wrong branch or send
them with the wrong branch specified - especially pre-coffee.

> tree is being created and maintained with the following characteristics:
> 
> 	1. Composed of pull requests sent directly to Linus
> 
> 	2. Contains branches destined for imminent inclusion by Linus
> 
> 	3. Higher code quality expectation (these are pull requests that
> 	maintainers expect Linus to pull)
> 
> 	4. Continuous tree (not daily tags like in linux-next),
> 	facilitating easier bisection
> 
> The linus-next tree aims to provide a more stable and testable
> integration point compared to linux-next, addressing the runtime issues
> that make testing linux-next challenging and focusing on code that's
> about to be pulled by Linus.

What about the people who send them late?  I know people get told not to
do that, but some people still do.  Those late pull requests would
potentially invalidate a lot of the testing in this scenario.

For example, if there was a late mm change, then anything using mm could
be affected.  That's a large subset.

Is there any cut-off time for testing?

Thanks,
Liam

