Return-Path: <linux-kernel+bounces-347103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2D098CDD2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0DD6283FEA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 07:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C3B194089;
	Wed,  2 Oct 2024 07:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EXDQSQnm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C3jxjJuX"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BA2D517
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 07:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727854632; cv=fail; b=LJerp4uhkAYbNpWcBgSTBe7TyI1/HZQFWQVZnEgcW88aGK6OQ2EfCoE4iwuAJx71Zv7B7uKuGVKaEgW4dolxEHp56CsaPXi2UvNmbpReiJMzxkcAMopfcQUejNXbeBs7zXGfw4NkLFVI4HdO6sIyP3fHt1QURDT/hJBCtM3NXYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727854632; c=relaxed/simple;
	bh=lJYsKxw/X+lregMQBMjLE2bFqIktE8HsPYlT9UAfplk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RYH7vAYSaj4Idz4J0VXJb5DpCnHBIgqoZXt9qMDdbF19UP84OmDKuCuUdbu17aT9LkMEcv28SIZefO5yupLw+09vAhhdhkTSGf5ETCogfix3HklTp4eMNcsJ2VFZeVKEHNjeh6Nm5gYaLddkXAqVzO98ILprTNBbxj76Wrkoi4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EXDQSQnm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C3jxjJuX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4926Ma48030859;
	Wed, 2 Oct 2024 07:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=lJYsKxw/X+lregM
	QBMjLE2bFqIktE8HsPYlT9UAfplk=; b=EXDQSQnmVIcICtz68gmCZkQRJuVB+bi
	oDP0du4dPuvgkUQpzCVHB5YGo6z1VFozj9Cq4ej+NPrRfc0rS/9AaEwncr98b89K
	ofRzY2PAxAa/cTmlHUdRijDj72EP1XCkx7yBkHnnnxPpcSZyQsNqZ3txZw4/yovq
	anVX8PbuOK5tNuSqEIDnipCDPkNxj460LfcFIVtcI15IIfWvoPjnJEJTwFqpXXH0
	fTh6+pcTH4JwuOL7rEZ3PoBNswFLSDvifpp2anrx8KvyvthsBPvxyb9Av1bKY+Z3
	L2B8XyA7k/chNIs4+waGL6btFh+dO8XfoM/poLDcmdeDBmPlE0943dg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8d1g9w0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 07:37:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4926nLZX012527;
	Wed, 2 Oct 2024 07:37:00 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x888aysr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 07:37:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GfaeWBXxIZ165WwAx4ckETIZiddgXK6bfSJTv6KC0ShPp3QJsluDh4CpRDc2+qpsUC6PEqCS26vQ/dvccBGN6RSqWVFn8JN348ieOXN0sjv9nB4tm55yAoMbkz2WG/Ln5LZoSXzzh+tDQQNga3kFzo1HS+uXCxnLsp/6UXVz1Wowr3z18YZwsC/96YJqxd5hJQ00M5kfQsCmmVRS0/bWSn1xuhkI2rAVg2oA7i9TTMt2hCHePu/N2G9pHlthV1zxlMmQMr1NI4074BM71X9HDStw2ohR4F6F0416CPx7kQuWO4CuFXn1Dr//AqG4MtImsNV9FiIlO4E6IuAcnbrNzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJYsKxw/X+lregMQBMjLE2bFqIktE8HsPYlT9UAfplk=;
 b=wFLNrgo4yeAlsDPrt7qlLdoWbmeKvZtvyGOs4+TuY26kUBDmjh90r9wHr6U3jQ0OEcQvSW+AYzOa1XsFuw6oA/FoPNMvdXzmODD2N+dJHbMpdLPfzN323NUp8Wn/N01/pkR6r1YrSmEBtxhGYKeAb6VDpttpW7n52H3h3jW+vukaHZFeTj9bLn4YnTP2JUzJhHpBgYRt0abALNWjxRs0Je/MwxU9zQvLRVB+L5si103epFGsOO7I0yMRXW9px9B3GzNPHBGm61iw/dXzRAetqpIL+ymfp9t5/cgWEna/tHcsagSEYssBYzcDj9r0tYN82ewwZS48vjvaxzzTovM/pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJYsKxw/X+lregMQBMjLE2bFqIktE8HsPYlT9UAfplk=;
 b=C3jxjJuXDiAATee1hh2k5h7/QeFvjaVe6nxOt33jQSlKhtkkhzI12WqcV8LkZkA4Ib8Sx3Mij+UBYZ9k0iGZ+w/yt/v3rZapqCYpTNgJkduWu4P1zTNjg4a/+WXFTWlpxStU9u/X1fCvABnfNZrykS9LE056q7tJwoTbffaxGSY=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH0PR10MB5083.namprd10.prod.outlook.com (2603:10b6:610:dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 07:36:57 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 07:36:57 +0000
Date: Wed, 2 Oct 2024 08:36:54 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Bert Karwatzki <spasswolf@web.de>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH hotfix 6.12] mm/mmap: correct error handling in
 mmap_region()
Message-ID: <3de82936-2546-4bac-b8d7-76fa38811d68@lucifer.local>
References: <20241001133726.160275-1-lorenzo.stoakes@oracle.com>
 <84837835-b483-4d15-9e0f-1719c350423e@suse.cz>
 <bae80e71-a139-4209-a2f8-3dd08d1b2c5b@lucifer.local>
 <20241001144433.ce56e7afddabc40febe94bee@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001144433.ce56e7afddabc40febe94bee@linux-foundation.org>
X-ClientProxiedBy: LO4P123CA0478.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::15) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH0PR10MB5083:EE_
X-MS-Office365-Filtering-Correlation-Id: 42c573a4-c996-4f58-48f2-08dce2b4febd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cATQ+QwrfBkj6LzN5LajnE1ybdgcCq/TixL7I2AKEz72P6heaTO+lnVwxdfU?=
 =?us-ascii?Q?ozMnIhtyAIF2PJkjMBUFuRya9YdgVbYh4RyNP3q7dcGNxiM+scuEHjJxc1I/?=
 =?us-ascii?Q?tAfpXWVbRO4LHosaisIwPuhimgYnUnfHecpq4B8LFi4pF4fxNymHT0ctFSUh?=
 =?us-ascii?Q?y2uo8cXF1ekq2yWOq9tRi7e2ect3Nj8WPEvnQrCgsAVIsuAN6DlAWAXi3QD8?=
 =?us-ascii?Q?TDdD0d3epSqkFh0Y5yURBS9s92F9A4RTpi3QPo6yd0mSF8F5AF1FK/a8ybLK?=
 =?us-ascii?Q?mWsgNin4tvlLsdLxHecGpsUjOXmzjsbZd5+Ig9uxLKfEGA6htNYeZgTkkAon?=
 =?us-ascii?Q?KlL1WCtGXjcG1+OBK1LEYjqkT+oC2Q8mRSMFUidbFF7oHVHWkXfnH7GTma4t?=
 =?us-ascii?Q?rKDnvrG3ROgPXxS2lOtzV0druAezoOmn/FkVvZ6PJm2qIoyxl6Qf5OyWRyGX?=
 =?us-ascii?Q?6tLzYFojnQEfkkepU2Pnb458xyoRT3/LBxDMPqSTn2iwZgHFeMfdSsdCu8oL?=
 =?us-ascii?Q?9Utbe9Xk6SlHrFodqP7Df6GsrJzxtGJeS8tbJSnxBtBeetmLOsczQeUdPeOZ?=
 =?us-ascii?Q?qnH0ELCKe5JzYIhLe35Wkueo1AVlUnpq6rtG6F7CilVlPVn09574HtFeUioA?=
 =?us-ascii?Q?eUOtgmeB9d/6d4OMiQZhpupcs39a8fccmmSyBcdaiiZvlDDcB+9+4KVz++hE?=
 =?us-ascii?Q?n3Fn7JSSoa8GZfYHflOn8OBog1Br5vOMYgDo7ZLKzWjgyYu0n86NMEOFetY/?=
 =?us-ascii?Q?Ktv1/PC54GrAbiusadUCDPD81zLFym3pWBjB0icusrm5FIlJElJ7kfIFCtp3?=
 =?us-ascii?Q?fbJDua8yvnPruAtdwawTgq0eE8+MIkRBjGHmgQXGwWQhTImdGUC4OwmcGxHh?=
 =?us-ascii?Q?7URHykSggUoozZWJq5ZA+oniU69hPIe/Fpfc2RAF9OIIZgM5+ZPG/EYu+nnS?=
 =?us-ascii?Q?PQR23jCCxT193nbxx7U17HJIJuLA9YddWJVKDJQn493mrzpH/A+ZhPMtZj1G?=
 =?us-ascii?Q?x7P9XvRuHVfSKs1FNoMW0LLvCVRRu7/xaohZdT4SU8ut9RzyPBquk5Wvcgiw?=
 =?us-ascii?Q?ublevjOqOTlrZcvwwm/oCmlVMxvpXSwfGnawFfitems+L5plOH4lcjE5q/Uy?=
 =?us-ascii?Q?UzBhc7lpfLkpfd0sk3kPXGQlGmlzPbg07bGmd12hl07Zrx4FJ03l+arj3iZr?=
 =?us-ascii?Q?zw/vJsy0MWmzWTEzCXPayjfsipwt/hkZqURcr7lS4+4YmzXAOSjqEL+jt9Kb?=
 =?us-ascii?Q?rgoUAfKVbx6HXhEI5Pv8sJ6T4wriULvMlol6WLavNw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n5iXjQi2lmzNmczi9cP8DUmjzznXlbdco59Z8/9dUR2omaLFczQpNnT7GiPR?=
 =?us-ascii?Q?EdYNkZQyFlVE3usuZ22K0oYxoY8Bk0Cpqo9AwHgQ4zR9PiMZMubBixAL755v?=
 =?us-ascii?Q?Q0qlP+QgAyTJT9kbKhu11IjV0L3QZ8bV5M4tgWRwOZrPMzf0fSVBi+XFO39p?=
 =?us-ascii?Q?prN+G4aWnM5wUWf5usVtqFnmD1Kiv8vC5Nzrd6uDsKTu2V6EZPJ/0NWzQd3N?=
 =?us-ascii?Q?zPgk0GG7hkXQBSCmgLRNv2kDYRzM92w6yjweFtKKm6joogL5MY+m+fs0VPHZ?=
 =?us-ascii?Q?GD3rzvrpV+H0PcvTuudBnzmIs8FKoT6B27owEBefFdlDPaF+y4L7PEeTHrbm?=
 =?us-ascii?Q?QFLAXSPxg50Ek37kh1FRGr05cHtpdwSjBuQHN/ZtYpOalOYXolYnkdxmbp0Q?=
 =?us-ascii?Q?fdJQEdXTABdGZ5fBdN1aKrSJCkNm79NgOB9RGOFJR/4FrLsez7ZCszeWMX4W?=
 =?us-ascii?Q?Pucs4WW1v0PUxrpwlYyBEzRv4KT5xU3T9J+GrrYia3nQ9VrORjGbDG0T4mth?=
 =?us-ascii?Q?K9jIghx7KI0TRnIL++C6Y/JzTalinu1eeU93qWm9Dd/z06jJgs0XgVHmHVha?=
 =?us-ascii?Q?pzrb6GnmQf1Cz8F7dfgA86tu8yFa5EGbUVjr/b1PqtNEngoe/EaSi9uxHrcA?=
 =?us-ascii?Q?uFW0zd+wl9vlnz/ydP+gQocSob5TvQ5e91XEwa9TgeR8a4jdwSFTKMeVOrSy?=
 =?us-ascii?Q?qqFCzk7rgYoQKCgb7vc7+g7N8RMxIbNvvoNMWfX7HYSWmeWfHeklkmS2hTI4?=
 =?us-ascii?Q?0IqeoSwqRnhFqjdB2Ym4qcCm+q4lC9AM8awpxwvzaceBUuQZrQeDRrMiRomt?=
 =?us-ascii?Q?Her838uRwgDKbk4cdPqle3U+eY9homL8wSmfRwpxa0d+3OWBrGlEz3oxScBg?=
 =?us-ascii?Q?ZqGSj55yr8JgNQRgdRDEZiOvw7FgthgKE8F+5mYgSAs0bn0qh3H5YPrE8SbD?=
 =?us-ascii?Q?jwq4e4IYSoV2+IFV9w9eoKKhHiXiR1kODWRgzfW2l3hZ/BhR3IqMVS5qq9DP?=
 =?us-ascii?Q?m22ge+HdzBwDQ2zgNbl6Qotsc9guxrvMTopsv3ELRpPhveYFA0FQvnaFqnVP?=
 =?us-ascii?Q?I7DeoS5nPt9mzPKchTghqo84iXyegP0cd7XUDQLU+rDH8zhNJAzTtEZYIV7+?=
 =?us-ascii?Q?EZyyB2BaJQln/lQ5Fc7PcltDl5pAsgV4qDISLua398yzT+ye9TA2m9/bJ5Fw?=
 =?us-ascii?Q?FejJKxMaWi6FTNUx+LQlLWAC33ZIrGJPm6U2fjhblmXwsryC0EswmF6qyWXf?=
 =?us-ascii?Q?gulw0yF4i7hRdXAdcROFA+FmtYnyKEKLYUAtBGHyvsK54HC4g7cKuBIuhyjT?=
 =?us-ascii?Q?qvawjNuUWgqg4l2iP4UFWb2h3T1LHGaCAU8jQ7qDGdoiPkm757yyZor6OGiZ?=
 =?us-ascii?Q?YWGjVvlzq6SGrZBqjiA/hdw+ngu8AG4q9jOlFuHsQ30w+a5cF9XZh70mPR0v?=
 =?us-ascii?Q?qz/n0jOkT7RwLzZrsRQsTb6WIEf5o4CmKsz7Lx4EHoSnjViH6Ou/tbDZJ3vX?=
 =?us-ascii?Q?IWcrNTFitqLPA+dSMFOkxPKSNpOtg3r+u+WiQ07SJsk0+hAQmvqXHvkdQ1l+?=
 =?us-ascii?Q?qPTcEPudyIH8hG/WORO5j5KkZEVPFfjyZ6lbocMwRdVlhFyPHcDFTxc7LVCM?=
 =?us-ascii?Q?8/am1/Jhx++xKFg/x/vb66MP34ZqDTvvjIcm9LAe1S62N/9dPFwDGRFHbcbk?=
 =?us-ascii?Q?vstznw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nB+q2jw1DAYN3Ea+vF3KHOZ2/+oCe1wba9OleuGK21rfnbIVecDFqq6R9vLDm5LRIHJ0A5wolOLBUeRFgj8ccKJmzNd8j4uzrHv5jkxeu4gmnvl7jnH9fharhPcY3h7ITAtNlYkD8lyXXReaxk8rftFjECDfOoDwydloHIoycya6iljKGK/LE3lv8MPGtCwBWwQgfGLQZ7R3DSPhLUvcjBZyFjKfZNpSu3l4ABVlVpJONG4Zn0rLJQUSoNXlb8yyMQp3Rwor5jvL4CJiFVovlWpoB6Wisv4/Pd5awD6RGULoP1zjS1uEYU/xbQCCAYKLRrPSuXIOu7a+NCtly2uq7VHB4tXieyquyUmhHZkYmnXr2vfH1iozdXICw4sUMRk5zH/YYPUyIHXzOychPrxhlMEbVJVqay1ytLqdbmlL4uE3SyzDQ/lc8tFRaGiQls7ldm/uvl9Wlj43eLV4FqqR4YfC4xKCal7ye0TkBlMmEa+mQi5xcP3MDXnHytwBfUtFmSITjn3BJmyu009R7OYd2pt9a7lHN2p2oYUVFfRD+tCj+W0RI50gplfYbhL+6UFKozgmdINYj+YuRPcjSQg9H2bLSbp6SbNdBcWknn4nsGc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c573a4-c996-4f58-48f2-08dce2b4febd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 07:36:57.6723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MBTKWFbzpHnHpDoSzgFpsF61asQleKuNdtVLxU/lq862l65XRz0FtoXTazpfHmyFGr5Eb1xFO8AAUN+5wB8Dggyy5956Kkk45bKqQG6KWXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5083
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_07,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2410020054
X-Proofpoint-ORIG-GUID: BkdzKusqaGFvd3pW1I0RoYLouVnoD17d
X-Proofpoint-GUID: BkdzKusqaGFvd3pW1I0RoYLouVnoD17d

On Tue, Oct 01, 2024 at 02:44:33PM GMT, Andrew Morton wrote:
> On Tue, 1 Oct 2024 17:51:07 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > > I'd be surprised if that fixed the reported issue, but yeah this is a bug to
> > > fix anyway.
> >
> > Yeah it seems that you brought about a tear in the space-time continuum and
> > the very moment you said that Bert reported that yes sadly this doesn't fix
> > it :>)
>
> Please resend with a new changelog?

Note that this does fix an absolutely critical issue, just not the one that
triggered this.

I'll resend dropping the reported-by and link tags and adding Vlasta's
reviewed-by but everything else is valid.

