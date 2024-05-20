Return-Path: <linux-kernel+bounces-184227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3018CA490
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0500281FA9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62F24F613;
	Mon, 20 May 2024 22:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KtGm0cW5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="paySDcOE"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D216374D9
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 22:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716245090; cv=fail; b=rDvgH4Y+iojJAHG+cMTruvkB0zXh9zayjikLMUzdpRl54gdZvqAv5G/fApR7115AidTPSxA281HO0GYasoWq6jPfoxFYHJlF5v8G9thFMzOUWGFwce7C1XqxB+5ZR+Xzpz4fjEKZLEgSKREfdtQwtL8X/hL+/UK3+5966SZbETE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716245090; c=relaxed/simple;
	bh=km62u8kg4kmnkThx0o7L22SQ/oe3Jbaz8i9cZJpEiZA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=R7NvmkLUUGFs2i0zNpU77cEDVDSNSyOaDG+6uzHLAFHckllBoffzCK9RlNpy9PtdL2nu0+cucQDwnE7/8xkc5Jmeh8ZKHKnLOekaJ+QKcUU4iVCcc20eyR3ztgux2QD3nTr70eMWOPgSi9PdpqbfQhpCSZROETmq01oxuCZbr7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KtGm0cW5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=paySDcOE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44KM4epJ025719;
	Mon, 20 May 2024 22:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=nhOcDwWGCyzM5YXZAIxQDOuZu3TRFN+XqlsWTEcNHnw=;
 b=KtGm0cW593wHOde/bDvFNk4mjYY/mB7dVxQ+TvQWHM9Degt2jFsrKe3kAfjcH2l2Qj2/
 ozGi5z9H4A6rLH1hD/gXG5t04nSpTuf05CMreMBPEk6CWSQgfvLvjxQT9c7wIB7azjDe
 dm3oZiR02e6IK/0FQTB423/9U8rQHrVjkbW0frLAFwph9sqMa0Vdm8yps2YZvxrvOfq/
 z2qMH1qfjGBrJfDgb1ABQYD1Psr8DVk6Qup0cVaAAmWRAhwjRSVNLwEZwkZeeLA1hxC8
 wcc8L8Ir1gnZpM+gD89XU6ddZdJwCjedfqrqu1Q+R3D638a/AvJPBPwGYuWxy5NJC/0Q cg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6jx2br92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 May 2024 22:44:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44KMC4fs037830;
	Mon, 20 May 2024 22:44:15 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6jscwnn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 May 2024 22:44:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhQhA1NgsSItJ9qdZzHrkd9hJCq++EXWf7x0qor8MkkHbcZ3RYRPZKfRKbJYrAZjk/yXlZdRhKKltc+moBovsmd+Uy5Ab1gTljHl3/py8jzu71COReTCeKfuJmwxBdP6wtgoFZbrC60LnF/XIin1hewyjF5YjBO+nqynwUN4HgcjGmfgF576+e+rJmU9wHmblgEv742GqlYBq1pa/1P/btw7erD7FY023p0Sj/IahLaOG9rHVnrR1pRQM6nPzA/Z9kJVRqQNW94/IpBvjhoMAADnMDxd3jWtKsTx/KhUI26zOyTx0t9bP2vKjr+rW37iafGgqXpY7+fkvFLsRWyC9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhOcDwWGCyzM5YXZAIxQDOuZu3TRFN+XqlsWTEcNHnw=;
 b=g/gtcrwmkG3SOKsJAqc6cIecFnYEYkqlA4Id/I04f3ioN6CX8rIzd12ZaRRdkBF0Vcw24pcraSHEbImk321i0hShT0lClH6FyAVvgmxghsQz42AZv56KYeVnZgxvPGYE0VOIbq4Ic8AsPAabevJfZtIXRyagKmudLc8EdmEUQIZWlEiPfsFGHD4CntPS2dNghexDL3z8vLLDAB2q+mvp8Pv3ddLe8ZP7GvTYfZCiVifswhkt4SNxrRq8eJ4tTsbeiXQCpVqKu6fMf/GDGwZ5YZ2oau6bzP/hZ1CoM/L2a3wFSnhE0CynDs2o9CPIRM9OzDju3aPZnWhPOhT+jD09qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhOcDwWGCyzM5YXZAIxQDOuZu3TRFN+XqlsWTEcNHnw=;
 b=paySDcOE+2YZZDQa9FwKV+N4TRidCDMbEO8buZdTXvFVb14N0oWOWwxhfnNXA5xBgy/6jORiaSNW+KfvZfVkBeyXCK6KGP93RAGNUqMIRgJW1U0rmlK+FOvNBiOA/jsowOqsf/NU1lEsX8QQ3gqmsC5+6GjC1M1xYQ9aGV28YUw=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DS0PR10MB7089.namprd10.prod.outlook.com (2603:10b6:8:142::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 22:44:13 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%6]) with mapi id 15.20.7587.035; Mon, 20 May 2024
 22:44:12 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, vishal.moola@oracle.com, muchun.song@linux.dev,
        peterx@redhat.com, osalvador@suse.de,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH] mm/hugetlb: remove {Set,Clear}Hpage macros
Date: Mon, 20 May 2024 15:44:07 -0700
Message-ID: <20240520224407.110062-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0013.namprd12.prod.outlook.com
 (2603:10b6:208:a8::26) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DS0PR10MB7089:EE_
X-MS-Office365-Filtering-Correlation-Id: 443ca090-20f7-4ea9-022d-08dc791e5ebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?90iFrzyX9kFkLRDBmJ0CaYPBHQXRw5Kq2oihfv1wfiqhdaTNg4Q1hjCJP1bI?=
 =?us-ascii?Q?f2IqGrbwCUygB0iVkS0QvJOMAuWZVE3/yjC7kIfRSPq50EXXu3b0JMHarIDz?=
 =?us-ascii?Q?hJV3fTY+LMFSeaDB53Iu1OFuAloQHpy5D3wIe4YqgS5YYQY7tp4elhinfHge?=
 =?us-ascii?Q?o+LDn1tQK5ALkCxjkmJMP37Zg0Gk2MUKiqOjR6HsgmcrqPqKPmvQ4RaL6obh?=
 =?us-ascii?Q?cxa989oFyWhgwbZWNtxq1d6tBw86rIdsO2ruEF33TtWAzsuQHOOvEZwmOD7j?=
 =?us-ascii?Q?ahmY+YK2hU+2/1Y2UKkTudZG9Mp2OcyUI4DVFyOe0gzGja34RtWchn5tcrvM?=
 =?us-ascii?Q?BM4fkKOWXmzWzC4o5ZUQA51vZ+uXFVGUjJ2usqnEMmPxM2Obmr5JQff+E85T?=
 =?us-ascii?Q?FdbBvSyPa4uQclBbIr2Kh2vSHFZqyn0v65yonxal8mdrPG377/bMhD3dETuM?=
 =?us-ascii?Q?tL+amCqunY60VhtXeSBj/1nlOzw1SuM73hQ2NddKblKKBms8z9P1ak6nYvAG?=
 =?us-ascii?Q?161kox4kggtRJjFPPYZh0FF0lKdt+zwfbZUo3dBpBMk/7685i8f3Nu5VNqPd?=
 =?us-ascii?Q?6vk58qv+JOMzL2qYWt+wpna7DNqfKFilITmj74GV+SjVwN+mBo0dRIqvLl61?=
 =?us-ascii?Q?vqiTKyQ8OHDptVZlmmtsKtP0bhBJnoNx9kiRN6Jt5D/TxAPmfUaHEFtyjDv9?=
 =?us-ascii?Q?5pIXMvMnNweUfABGJuHuoeFiT/CxNXotl8PgyIEgeB3XVJ0wHVVgl8V9KrG6?=
 =?us-ascii?Q?xdL/9FdcEnZHYxhOwQXg40Er1k7yftfYAR261FFAzesZQ5k2ZTYAolTm9hKy?=
 =?us-ascii?Q?Ck8CYZ0hVJE1dF7GFq2vM0vbEW/X8VGpob1j02yXM3ngZoGqtG9UmnmvxrJY?=
 =?us-ascii?Q?dNGZj1ysDUCbs1QCUBQHE0RFrqA/A+8/VvKHiSBt20ZI5WmwWFFLQRIA8xKD?=
 =?us-ascii?Q?6lDggtEiUuxXmp6d6RZkb0okwUT82BNlrxv7w8iXbLHWi+4t1jWxnQhdUVO/?=
 =?us-ascii?Q?BRY9FQPoThl+JCxW1DNehMaCbC9lUOY0ti/c93196QgjQ4OQtZnumW5fsdfk?=
 =?us-ascii?Q?oAQNUZqnj1qI9LWbm/4dEKMCGGBvtW4iTRfE4p4rJhrtGJeFUR2cpRiPqcIR?=
 =?us-ascii?Q?Vr75/M7EXrHZhMjdekSZd9qVYslnOT+0kKgbEM/4326nq07LRjJOIumX3l3n?=
 =?us-ascii?Q?/tCgDGOevN0LfhyCGfRHMmIbfBMrzb+az1Xv6y+2UjWB14uNqmDTYd+Em67/?=
 =?us-ascii?Q?n1reuYZD2JvXUTe3soEpoMQVEp8eRLBLj2eg6ZjOTw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0f+8UrGjtk/9mc86ILxXTlzsu88b2duydoQU9aHhHK9n8YQxs4JQ3NyjHC0D?=
 =?us-ascii?Q?OQKhCYXg4ZateTcnDwOnmkgacFfu9Pj+CEKskihOEG/j30bb/TkFHIEIBG4p?=
 =?us-ascii?Q?hlW78srV0gi58shLI6twZQu0OGXnobBb+ITSX6CpxK2nONncJ6+JrrX8t2Ix?=
 =?us-ascii?Q?L+m4E/h8ZvYOVMRCg7cElWotW1TpB8Pq6YjNnf4IP1bW/pARB+o9rBikyDU8?=
 =?us-ascii?Q?KWVZRtti+NjLb5k8ezDvT9mZn1lfeqlZITMbkfruDY9BS3Qdlw1Lz3/ZMUb/?=
 =?us-ascii?Q?72eQyfEFOTcXs33IMhhNnWMKl3AUkd5NMxcyZaXvC3PDGRSF0ac65Pz9fhOT?=
 =?us-ascii?Q?admsVkaVGATggFBWdw9yWKaIK08N+3AoX7Tl/VEVf9ixR8Tvq+3uDlBN4Oj+?=
 =?us-ascii?Q?tYfMdhdo0nxRdbtbi0Iir+SodNmeNTYPxH95t9VJwQ3N4Owu0e9JCBFwu8N2?=
 =?us-ascii?Q?SziypUrPjAr53/d9vyNGVCy6DMZXnLV+IyImWfeps+tUHP4wio4/a7rGf/V+?=
 =?us-ascii?Q?lGyEfsJVesD5Q4uXcxufHQogY+vhxCt6OSSsL17ngHlmrne2h8XdYAohAE2i?=
 =?us-ascii?Q?+7NkYkhUa0XQscMa0yJamTwMlGJcfvXQ9V9Og4U+JJ3PssvFvGpeQxBN/lGY?=
 =?us-ascii?Q?CrWJDeAjtPJNUiX2ZbtDF3YlviPkB3x6TuKoG0X3ESqPaQXeK1U9CLa/4elK?=
 =?us-ascii?Q?8+deOS8AHVOulYrJYSeSmHG4XjRiriHsgYs0uPOVLCBboPRefIS3vXEypByh?=
 =?us-ascii?Q?aK27diiY+V9z5ZSXI0J8tGn1HmlU14uo7Xt02w7+OVQIkgS27Meu1TfsexAd?=
 =?us-ascii?Q?jbJrhVotJL8bHYcA/lVlqwkJf2ZVbE0xtuxVx8hr9gEMz1FACCHS4g4y2/Ro?=
 =?us-ascii?Q?v/eEC4ZVJVCVsZ28pkkE0ziuDXo90DQIQUMdRsdrX4gQqW/p5XV8dj7kig78?=
 =?us-ascii?Q?OyHNPUOx8BNDWYovAIMjez2bZuz5cm26f8EgyyRrkGu5ruWb2px9LyVxDC0D?=
 =?us-ascii?Q?wFrFeM7HKJV5+Ahf5Fz0ROQVP8xKnUXd5+pi7dXt8HHHG7qqOTBDiw40GUkT?=
 =?us-ascii?Q?56wv+9J2eCXqa1rREFswITvqu3ajvx3W9KeBmko7aGkUJnN2c+XE9ohHt24T?=
 =?us-ascii?Q?bFp5bmTXpVaC8TLPSXtLS/mPsmxApzSZ2pGFwQOIg+cdYk94zvUGpwm+/ImN?=
 =?us-ascii?Q?J9QERai6qI08JGnMlztULlF08LT2j3BrMmGX58ElBzSN1+9DQCVsD/VBJmpd?=
 =?us-ascii?Q?zDoiTyUdhPXEZ1JEAr1SPhB5OjkxW3jQf9jeZIBjPsv7DCiG3W4ZKSek/wbQ?=
 =?us-ascii?Q?nmwI/rgz4i/wzs9SicrJY9XsnTfd4tukvwiUONp/ISk5XC/DOrpFV/IIQeyz?=
 =?us-ascii?Q?9vd2YCklgBOLFFhl02pvGnMKPkntf3IfRcz+SbF5ADcPPVHtfbvmaYS+k+sn?=
 =?us-ascii?Q?ctVRcMfq/pNOrh6p17IatSiQzNVjEVkR7Vb/dyPt2ylXbWVzg6gnLXxr3Xbh?=
 =?us-ascii?Q?Di4FM15Y/myhV1LVrnYV/9mxlAJ969pHWBZund6+VL7ag6+3e47G/cGqTGmR?=
 =?us-ascii?Q?b/QIMI+voIJ6UY7GtOlpbKoDsbFVA3QojbzFNDwn2yvuQ3WG/ZFSaQPCCAH3?=
 =?us-ascii?Q?tJmmn7qVX2Yt7NRtTHAe7Hk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	O2W8Uxt2dCwEc/dX1Ci/rcHt5wBSRGjlWnatUmttB2B9V+ruHoxtacu/JCyQySrCwvWy+uXl1OOHc55TOX56vQSGTa0dGRnOdMG/2P+hcnLTJqlKlhIAIGRi8BgNb4XHDa2HjJwkAWRR/Vu6ClFHg3p4d01cp7c1Y+qD4lcKKdR78iHYvHapOtjw1W4yp5iUp4gjfS+WtscnyTZtQqgLLBMbJefNNFGBTL5oFYxiFhICUjN0Is//l7e+z/ncME2ix6OTRGoeF4J+VFW1hHQ2GXFZyA6Ksd87BcmwJZWug3rpawK3ID/wxDxsW1E7atRj6gFRsJVPbp9dy6BEpmv+xOFr+QHY/w0cWry3sl/GiGhR9YRSe8ii/1m59UF47bLgAbGGVeNAZe6RJLOzpHLo+h+BuE9uV1N2BhXhMxAZdukUPGvyqBitSy4hD7kPnBYMwmEGth+a9pIGY9HBSKe50z11b9Goa09Wk3jOaPcnJv+/1la+O5BMkjdzKbFRYkcRCutaTor6SxZhsQ0b82wVNqW7/vtc+AEU9x4sK79xHWPPU40RlqAlf+jexQS0rh7L9TaNYWW/z2/OwvVFOFujF+EOz0M3nlwvzMaJLuLaPtI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443ca090-20f7-4ea9-022d-08dc791e5ebd
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 22:44:12.6634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KqhO4vbx1KbdAC2yvuL9GxC2ZGpFP/R8D0D1l/EVmRqhy9YdTFYWd6hPuIcBCy0J16LjvKlBI2MYVvfMLF8I6sPy5VrU9qUS8so3eGyKVp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_12,2024-05-17_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405200181
X-Proofpoint-GUID: O-bmUw124O5qQBZiTumHHtKoGDqPqHmf
X-Proofpoint-ORIG-GUID: O-bmUw124O5qQBZiTumHHtKoGDqPqHmf

All users have been converted to use the folio version of these macros,
we can safely remove the page based interface.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/hugetlb.h | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 77b30a8c6076b..c99ed9d2192d8 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -657,18 +657,14 @@ static __always_inline						\
 void folio_set_hugetlb_##flname(struct folio *folio)		\
 	{	void *private = &folio->private;		\
 		set_bit(HPG_##flname, private);			\
-	}							\
-static inline void SetHPage##uname(struct page *page)		\
-	{ set_bit(HPG_##flname, &(page->private)); }
+	}
 
 #define CLEARHPAGEFLAG(uname, flname)				\
 static __always_inline						\
 void folio_clear_hugetlb_##flname(struct folio *folio)		\
 	{	void *private = &folio->private;		\
 		clear_bit(HPG_##flname, private);		\
-	}							\
-static inline void ClearHPage##uname(struct page *page)		\
-	{ clear_bit(HPG_##flname, &(page->private)); }
+	}
 #else
 #define TESTHPAGEFLAG(uname, flname)				\
 static inline bool						\
@@ -680,15 +676,11 @@ static inline int HPage##uname(struct page *page)		\
 #define SETHPAGEFLAG(uname, flname)				\
 static inline void						\
 folio_set_hugetlb_##flname(struct folio *folio) 		\
-	{ }							\
-static inline void SetHPage##uname(struct page *page)		\
 	{ }
 
 #define CLEARHPAGEFLAG(uname, flname)				\
 static inline void						\
 folio_clear_hugetlb_##flname(struct folio *folio)		\
-	{ }							\
-static inline void ClearHPage##uname(struct page *page)		\
 	{ }
 #endif
 
-- 
2.45.1


