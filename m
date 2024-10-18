Return-Path: <linux-kernel+bounces-372159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8A29A4529
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DC331F23D9C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7EA205AD1;
	Fri, 18 Oct 2024 17:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JhTZIB9n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C27vMjNK"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB98B204F65
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729273310; cv=fail; b=UWrwU0QS8IVssQtZ3OIgcMAVE+2Z619marvFkG+7p/4KYjIMkXdKQIEcvC65NKc1x3v2BDypSsMCZIT7bjfWNaIEzapER2lQMAyEMHl7sOzgh86dFcf5DNsy7c85riwbzub3VqznkxVyTwb39FNCeX8O/iklmcr2AcW1eTMikzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729273310; c=relaxed/simple;
	bh=iC4nJyxxU0x08IL69FBkxKK5l8eJr9My/dso6zcitVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JrpxNYmKun2jE03ZC2iVe+9LAJ1QoonSac4kN1wupd43VYtMZIdBfI8s2hsUQiVaGr6+VJzi60duLIY0c9IGko1QaMGsPiJ2uUKiAx8Znwy87brO//G1V52+reE9rWo7rBp3ye+aYaNuZiGkbEl5Tpf6fDlzBULh2l6Y3gx2Q7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JhTZIB9n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C27vMjNK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IEBhJA022582;
	Fri, 18 Oct 2024 17:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=4WsOX6LvlT+1onW8mlsKAymogeel1ZnaC3LAXJT3nVM=; b=
	JhTZIB9nXujtO8uTUP6gwzmitwOM3H5j8Pasrp8Aa0WpRP2QL4HsVfmO2aGcGoja
	GhHj4bIZ4F3WrSpPnvojNsV20SmN3iPHr2hupR88Wn/iXK6lA14yqC6Mq01SMjgA
	fEWE1nrDDF0OTRK7weL0i4Uzmo0pgfEa+6qV5BOHeO9SwM3F2ekuZyYYwsuDq1Oh
	FsdXLN6sIZxRhze3ZK+LizeBvO0ajze2PsFtSqjwXbzPI/OFdfnLWxcezmrMlqGz
	I/VrKFQeHPtCbaY4DpPsiU2eZhKBRBwUfqd5yilQoImgtqbXKa4+MybXsUsDh3W4
	Pqm+hjrwyI9xNbW0w97WCA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fw2shja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 17:41:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IHZ8V8026241;
	Fri, 18 Oct 2024 17:41:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjbvtet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 17:41:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tT2XMH18xChl84vpTDzsxHP8Z82ziJFsZLiBTcJuB8DiqpH58igYTujVHsZguuOK8KtZvJbO8SfGLu7b40v/LybrOU9omxQMo4ETtAnMizSy/wRMuj6AHTJFG3YfyGD0067fW1FFMkvR0S0YaNBSvWKi891woPrD6r4tDieXJiMNz7Q23Nmm99NQnWUcBJEoGuFola9GX67DF5FjYp40UOGtlRcsXr+gky/kx/O6gFbcA56r+lggLODMxn72QzlwDNijRyAvqjqXsnLgEu9iggIMlHNdmrPNpLznznlbQ7755jUlqor8qjegzel3sFuoFxC7E3GUpopzcgXe/yPxIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WsOX6LvlT+1onW8mlsKAymogeel1ZnaC3LAXJT3nVM=;
 b=v45nvn1VKoLB8lFreltDgqGeoQou+q7H+G8YV2wfDgbnqCjWOOFjXkwODa/ih3RTfa33Sxh3+nd1CovaCjGXBB0VjyjGfrdymLSZcpkMC0EcpGPzo/bN7PBgxa1eNIS44+NPrxK+Mh9kNlTljuZFIE3U93kn1/KqVUCmjWvJT77eqKXVHYe+PcqYTjpblT8k7Cj0VbG9nAN6opZTVkDDpxUpJIJUvtv2mAoKoEcmi+qQmZNS0OubxXT0I4jZA+f/5zedqxQt3xKTB4hFe4+6v/Vs8TqF9S92cVNREddhY2dNCRqbJrZkuXUgmjTu6WczjyR3+Ws/FJA/xsMqqz7hFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WsOX6LvlT+1onW8mlsKAymogeel1ZnaC3LAXJT3nVM=;
 b=C27vMjNKajzKHbB7OJaGJn1RlUKOtbLfAklmL/UxiUA35kw02TxN9cogheYPsmKujOwjqZJFyBXvvVEHY2JaWAMDSaQ5EvD4BLvlIcPRG8Z1EpvQsq5a6M88S952Imgr4vvTn6OGa7XCnP6rmQDXJpRgOhYib0N0jeOzr1X7l1c=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB7078.namprd10.prod.outlook.com (2603:10b6:510:288::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 17:41:21 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 17:41:21 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Jann Horn <jannh@google.com>, David Hildenbrand <david@redhat.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jeff Xu <jeffxu@chromium.org>, Pedro Falcato <pedro.falcato@gmail.com>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v2 2/2] mm/mremap: Remove goto from mremap_to()
Date: Fri, 18 Oct 2024 13:41:14 -0400
Message-ID: <20241018174114.2871880-3-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241018174114.2871880-1-Liam.Howlett@oracle.com>
References: <20241018174114.2871880-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0238.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::28) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: e01f5eeb-2de8-419f-03c2-08dcef9c143a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I1SYfTTxEEGCAcPZK6m3+zI/3meOXYs2wwxmomVwDFmtAgSdsTphZNrXvHGo?=
 =?us-ascii?Q?DPr6TR2Rd/moN1Pi+ptO8tpog/ETOB7D/F5tfKMh6kLOjVOwahsfYnlzZR4J?=
 =?us-ascii?Q?lpfCCXapSA8XgZEjAkHlMt+ElPRA+Ou5NTtsUSTdCFf7Qt8C8kbGxZ8RjwMf?=
 =?us-ascii?Q?jLsq8NmHLXDlsuFX9cZV+JGrI4WLLXQ3fOk2jK1XK6CAGMGl9POAssSLnkpN?=
 =?us-ascii?Q?4i5GqQ/bnGBMCajoc5CXSu5MyynBuQ1g/KTUiulsed/S05rnDXUyQU0TgfXL?=
 =?us-ascii?Q?qr1u4WMqv1BmG0yUMlgd5lsW9OZLC/3IbLSkWaPi78/ZyNzuINc8SCATEsHA?=
 =?us-ascii?Q?UN53iL8MLTkXezhiqwtyeuMU14hh2UEDHcAJGCCNF+4RYWim87Ned5MIbeAE?=
 =?us-ascii?Q?/3DLLk8dmHBDZ7FqkH6q19omwYVhDmMNZHYifp2WNstwTdvKk0Hr/8lTD2y2?=
 =?us-ascii?Q?54zzMfjfAcEnWKi3mcSxhcacvHtEvqT377da5Pf2hyvYC3MC2Vd6PwG3SBLm?=
 =?us-ascii?Q?wcnM8HaOSwa2+y9p2NbkSfmujst1Tc+xkV8Gdr3EIccr7zXkZhXZqA3u4PYA?=
 =?us-ascii?Q?vfNglIiPAiPZga22Jf5IrJ1JPFiMakVJ9f7PK1Bxh87pDbIPmvh2FAsnoCcb?=
 =?us-ascii?Q?avguuPlHrVYuQ1qRbBiIXh7Si0kVQ6QkZmrH8I9klTihVqV4eKtqc7evimZs?=
 =?us-ascii?Q?dJEl+deXfhHYCrFy121cDo2/Vzj5CSKblXSnEYzupwtoZKFYO0zDnZPFMoOq?=
 =?us-ascii?Q?vntoqbmjZKJViKAUGeL+3RJzY4TWIVUlPpoVeOu2ZtSS2j/WwPtdM5OWG2e+?=
 =?us-ascii?Q?AQZL6RGw5ptnFBDjT0gEXYiyG9h8LuUnRaQb4bLOMDnwhNhyTzddsKm+eAy4?=
 =?us-ascii?Q?IRUBW4IQu7QwZ7z9JKI+bshoejofEPEZCgcABkboKH1xmvd5ymqzfnwMIijT?=
 =?us-ascii?Q?KRGBleJ8TbL7dL2xAsJrWFRfQnLQgZwuqdh3R/pqxaAwWk5+e6ra9dhaEzkS?=
 =?us-ascii?Q?zqk6RjKbINSfse3g09ULoz7TT0/eVu0LvqgBqNNcIAmi81UM9d2il9jYsaK6?=
 =?us-ascii?Q?dYdQEshkz4lv9inUlzNZmjCgBwtGJOosXh46UnBmuPhFLm4RsxF7FuvCywfq?=
 =?us-ascii?Q?ba6Z5Z9DEVke2wiDLVSMNwCrfj3V27QL24wylOAL8eLJ2FcMzzK+/9mavSLQ?=
 =?us-ascii?Q?BEyAQbIlA+ahMdxoRq6+7cZlEP+G40UHBqFGHsY0ZwI36ItA/0lLftWHemIA?=
 =?us-ascii?Q?mI808Mb9MYa1FrxBjV0LniD4X/rkTsEspwvvhUUXzFObv7lbIu6VdbuLfCB6?=
 =?us-ascii?Q?mveDttsiQlywzmuzw/AZNDmG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zPMHPNaO7pZu1WINkbxeNcqzgmbqJ0r0GWrEC1P18a+clxhtRBogaGty6Pr2?=
 =?us-ascii?Q?xPMdt3sLxZUVlvwRe7F99HdrUfAIvl/8s9LpD8VXP6KU0zZ6c9HwDvUSV4h4?=
 =?us-ascii?Q?LXITEjUb0BE/1ta58gUdvNyGf8rBlwVMTj3wiFnEpQpk7D2cEJn0jgeUnJa+?=
 =?us-ascii?Q?7YVNaOWzk6XNmNYND3ucj9hQ/iKIpBbUDJbAXXExi4MRoMwaydlLYB2mRTeR?=
 =?us-ascii?Q?ivdMvuPum5cRKS6BEGcVUnkjVP6gHkmEIoErX+X0GCX35bGDaW6pyypVry4B?=
 =?us-ascii?Q?RyTOyhCqbaX6+HjfgvkJvg5QbpL7MG9+SzwUIiiFqKJ3A3bk99RHmG075MfK?=
 =?us-ascii?Q?QJ6+KgJERZtKxVlMs4nrDW27UzSQjdQSSQAAlm/vS75TC5dcfLN1MKWH0Mik?=
 =?us-ascii?Q?Wl3CvCxxlTDcJ36DOsdC777Luni9fWceucS4iC5nD0Z/myJRtFZ1hEEUOr0w?=
 =?us-ascii?Q?VCGKAnTC1WdgctU0dQcge2VIvzJybxev/5Itp6uxewk+5hMXZF/7WYQ4RW40?=
 =?us-ascii?Q?dNVPp3ajxbq/iMBM1OuEVdaYTQ2WpgA4SQ+XJh8Kjso0hHARhKOfXuMwT0jz?=
 =?us-ascii?Q?0dULcjBONgXDBRSmHHWTiW6xwGlvXnCdjeSx6KyFmoGJSYio9oaE1zKd0Dt+?=
 =?us-ascii?Q?ZmMkm3WOuGl8/AkhBmossY1daGnX+E94zaQ5IVSCKqH6PghgEQW78Celektx?=
 =?us-ascii?Q?GAiZSMgzlAeoScVsmpXXMH5bsKy04zOCwO0BQvie7d3qEUEvXzo79DBZQ3UI?=
 =?us-ascii?Q?fK8IwPJ7F5+aC/YR5DmFo0LgDtXQfIBVhbevJOgnGyYWUT7d3+z2rCpoimuM?=
 =?us-ascii?Q?YVOBQaSx7x7BxQMqXFbeya41VzmBneUPZ+3js2TBx0LftE5IK4wth1T//6Yr?=
 =?us-ascii?Q?1iW3odo5gqZyJFPzqe9tfyySHNTq89PWfBzygOI2UAUd3SvgtIZsIFwHts0I?=
 =?us-ascii?Q?7odliIFCkvMSZ/VOBlC9uYfPuvOYFkURyo79aUqs4poJW9MML/RYCSUza0hU?=
 =?us-ascii?Q?FESkvvRQumnlx42mp9gvLiURnuNxBZxLmqu7PCXKhU6fva2HspxzY0gAp6qR?=
 =?us-ascii?Q?C+vrMBFa011guFoJHYgAlT2tP7IElTwuW5jSqbkUubMyKsDUThJHVdmvttWu?=
 =?us-ascii?Q?dN7zn8o1rwrTS8TEHDmRwQpCq8rNTqswXOlc9mfbSS0Jsz0vO2TLJxwaM8x2?=
 =?us-ascii?Q?18DPTQpZ+8LOal/f8rNOnR2uQAUA3GTg3+rXjkOTCzh0LzNd1SSzJiF6lkPm?=
 =?us-ascii?Q?2LXn1lU02Kcyzf5hXcWCggQhh+MgDa6SlPhFCNe5r6mpQPkB1R8nQ8e6dlk5?=
 =?us-ascii?Q?sjbtytQ/z6r0CnIy58simTQnfNARbvYNBhpF1ekvdF+2nz9ozxCGTwrPQ/d4?=
 =?us-ascii?Q?ajYmPq2wo+2ie3tzXt2wPcgDk1DWlpY4wl6QjmVApHUfj1l3h0Sy1M3erKre?=
 =?us-ascii?Q?P/c6iFqKek3/JRwdShtJbuJyZklGfCl74WXZSsKIgAUimX/S9yhJPD/+uqZa?=
 =?us-ascii?Q?6cOp6/Lad69r6M7/gJyRv93WObxsIH9T7RuVo4ZZufMzSWUNcyyY2lmbYnzM?=
 =?us-ascii?Q?4K3Q835OunRKoaNM0FzW/nikWwVumHdB1AmeYN7e?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bz2+IcB9/Ai+HDgdPuKuzutUXy5EoQ4W6VH7dsd3/IGX/J+/GsiSbME9o6Rn/slVPF6rVS/SdfJLgsungQCcJ/UI5MnW+OJFmL2/cusydsT8bqYCUTydN72tdjCRStyJA2OftC5zuSJYF6oR73yJcD4MYCb8qvSON5a84N2NxosTzeU1UT6Bu5ciNzyDLOAYj/Uqd/gkrZ0FmWf4ofJnUrbqdbmb1lriFY/PlGtp+/3O3mfgRUouVPIeAfKINZRtx0DHtKakNMQCY5sx1P5B939YWzi/pmDPIIGt7sgSbuThPC7tjvtPEj8hw97nA5J9DvPE1QNQDlty4z9z5iTpDB4Y4P7xzxLPz2mFbRXPP60U4N9IsnjLTcN/E3b7KxwxvWZNuHyQPcIURhVIwUojYuuYj6ofiM1qj6EpbuE4cJxG2eBAfYAaO/qhvjcUDHs/CivPn0Hh/gh0T4cgDua7jjCEu8GHiRW27mPFYYu1HneAOPC83QazjnHkkvgtkGsIDZYbPtO3lkXYQz59ki/4ZXSRwM2GZZmGyH8s7LVgdlX5UJwta65KmiLysZ2i014EzBi59/F51w+df9x7ALSUphGqmuGFGrzH/VK27UwqS0Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e01f5eeb-2de8-419f-03c2-08dcef9c143a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 17:41:21.4027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYfKx77bf2HOeAhxDlt2Ba9cmF1Ccl4EfbKi15gyZscHbGZv69ufSaMHF5io9yG7HdumjhfFbxQ+BE3F5xreew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7078
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_13,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410180113
X-Proofpoint-GUID: vyAgnZ8z3eYk5SNbvX749wLgTGZFPtuY
X-Proofpoint-ORIG-GUID: vyAgnZ8z3eYk5SNbvX749wLgTGZFPtuY

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

mremap_to() has a goto label at the end that doesn't unwind anything.
Removing the label makes the code cleaner.

This commit also adds documentation on the function.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mremap.c | 46 +++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index e781ec4573ca..4c79ab92eb8f 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -887,6 +887,20 @@ static int resize_is_valid(struct vm_area_struct *vma, unsigned long addr,
 	return 0;
 }
 
+/*
+ * mremap_to() - remap a vma to a new location
+ * @addr: The old address
+ * @old_len: The old size
+ * @new_addr: The target address
+ * @new_len: The new size
+ * @locked: If the returned vma is locked (VM_LOCKED)
+ * @flags: the mremap flags
+ * @uf: The mremap userfaultfd context
+ * @uf_unmap_early: The userfaultfd unmap early context
+ * @uf_unmap: The userfaultfd unmap context
+ *
+ * Returns: The new address of the vma or an error.
+ */
 static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 		unsigned long new_addr, unsigned long new_len, bool *locked,
 		unsigned long flags, struct vm_userfaultfd_ctx *uf,
@@ -895,18 +909,18 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
-	unsigned long ret = -EINVAL;
+	unsigned long ret;
 	unsigned long map_flags = 0;
 
 	if (offset_in_page(new_addr))
-		goto out;
+		return -EINVAL;
 
 	if (new_len > TASK_SIZE || new_addr > TASK_SIZE - new_len)
-		goto out;
+		return -EINVAL;
 
 	/* Ensure the old/new locations do not overlap */
 	if (addr + old_len > new_addr && new_addr + new_len > addr)
-		goto out;
+		return -EINVAL;
 
 	/*
 	 * move_vma() need us to stay 4 maps below the threshold, otherwise
@@ -933,31 +947,28 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 		 */
 		ret = do_munmap(mm, new_addr, new_len, uf_unmap_early);
 		if (ret)
-			goto out;
+			return ret;
 	}
 
 	if (old_len > new_len) {
 		ret = do_munmap(mm, addr+new_len, old_len - new_len, uf_unmap);
 		if (ret)
-			goto out;
+			return ret;
 		old_len = new_len;
 	}
 
 	vma = vma_lookup(mm, addr);
-	if (!vma) {
-		ret = -EFAULT;
-		goto out;
-	}
+	if (!vma)
+		return -EFAULT;
 
 	ret = resize_is_valid(vma, addr, old_len, new_len, flags);
 	if (ret)
-		goto out;
+		return ret;
 
 	/* MREMAP_DONTUNMAP expands by old_len since old_len == new_len */
 	if (flags & MREMAP_DONTUNMAP &&
 		!may_expand_vm(mm, vma->vm_flags, old_len >> PAGE_SHIFT)) {
-		ret = -ENOMEM;
-		goto out;
+		return -ENOMEM;
 	}
 
 	if (flags & MREMAP_FIXED)
@@ -970,17 +981,14 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 				((addr - vma->vm_start) >> PAGE_SHIFT),
 				map_flags);
 	if (IS_ERR_VALUE(ret))
-		goto out;
+		return ret;
 
 	/* We got a new mapping */
 	if (!(flags & MREMAP_FIXED))
 		new_addr = ret;
 
-	ret = move_vma(vma, addr, old_len, new_len, new_addr, locked, flags, uf,
-		       uf_unmap);
-
-out:
-	return ret;
+	return move_vma(vma, addr, old_len, new_len, new_addr, locked, flags,
+			uf, uf_unmap);
 }
 
 static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
-- 
2.43.0


