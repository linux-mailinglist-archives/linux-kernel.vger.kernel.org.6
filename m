Return-Path: <linux-kernel+bounces-294704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E4C959179
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 02:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 667EA1F25F36
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D575B1CCB33;
	Tue, 20 Aug 2024 23:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kpc1Fwnc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sTu1qh0+"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851BF1CB30C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 23:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724198304; cv=fail; b=eApAnYC63tn9fcJ3n6Mo2gSaedfs1SzAWZOB4KSohUL9iRxKF6+7lV63Ca18gmZLMXMfdv6scr3jdKUN8motY8v85z+ulI1ZtBp/bvu7WhBQDogDSaiWm1O8AOldHNs6u9jjbl7FNmS4GjZ+nimb3gGvlN31fnqgmUZH/KE9QZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724198304; c=relaxed/simple;
	bh=NO4pR/WNlRQ/wHlrM0871pL4uJ6+aOU7+hQrdbo9ZYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AMVSaw/HjGWu6zU+fcvZrzbqWS88aBZcEhjLJzWTAiwF9f0bGeUT2TRKm/oLUeINz3Q/JqL+9yowP/ozaygX7iOKwaLIYBez6PO0ZPx+SfemDqFXYsSt6PW6XptkE+uDfnO1blmS+S0zoS9VhXDskSVEOzSB0CvyfW38S10xxHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kpc1Fwnc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sTu1qh0+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KMBm9f020641;
	Tue, 20 Aug 2024 23:58:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=/kF+vqo7I9bVt8ivw+hZvg/8Iz+49RUF+0LtjGzT6d8=; b=
	kpc1FwnczDzqhF4J6n6TiMHzJ0Lt8tAg0s7K634Pr7ugX3JO3dB+kcYd7Gg3D6Gr
	UoZXumdh91wJxd0BUtpWjAfsHgXSQfXzacPatPp0b4N9MhsFXk9R03XoKKAOtehN
	jY6L4OVIeyocAZiJwre2EDXzjgUutqswLuNxMEZKWhqpHvVezB7Q6v4iX5uJFqDW
	+T/sxxPSfe8Vg5dor0nAU8swTfYAevUD3Axlpu0vq1OGqJN9gAP53UKI9hpEQb7u
	3rYda5gthuMZm+P5r2azQSmjvwE3srTKGQfW8BpOk2Q1V7dTFibs4/fyx31vGiLl
	gYczfq0DDPVkRgxjFp5z8w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m6ged20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:58:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47KMiKu0036831;
	Tue, 20 Aug 2024 23:58:09 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41546yhqxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:58:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b72HiDp+DfnHL9hwBnlvz3961VkD38hrAkmHBo37WRiSsGaC38RB5M3FO8WnSp5SQ8pjjQMcQ1mtxpRpQv4+YYLhe+Ub6F/yG3UgSgO0XnsXJaLUpo5OaJ7h1F+Vn541FVkORnBv1x06d6VU0pIv/P6NxkyBtPylWe7+T/2abY/2IMJrTroi1zlEjWZg+v9QyNW61m2++8oWtd9VM3QbmjAyJZ7KoQI0zGxGbu+Vk9ogFp2o5n312WeY08ElyhL3PUYQRESnD5vTQXR9iQQmfA60JArdAlqkbHolM7cAyzXaARuIlfvkGDXNaLOVkDm9Xzhf8T4FFfYX4CO2guzJUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kF+vqo7I9bVt8ivw+hZvg/8Iz+49RUF+0LtjGzT6d8=;
 b=Q1jBZwGGcocFcDENxio01LOnf8A3BdZ8/4J5pRItH2bbAdbL/soStKHh2FCEBRe2OXYCIgKs58PXwjg9+HMKeimpTbUrCg1zVWAlwzRM51ivuvxj6lHWz8D7mfSn7Wyybs1idLw27+tTAsCkmWVACcCq/7D4HR3PJGIAt6xE9KahNqi3uRsRCiArVdZarUVYxcG2fGP2heO2J/FOLSW0BILWcvO/svBslFNB3FMDDaaBIrpfiBSkCei71FBI52Jc59uasT/wpXHFxWs3Hz2qwSj9oyEWEIvfSiZYhkCK4HrJBk0wj7fZb2NNsFuTHdtBI/qITo4XchdBo9J7fnB1sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kF+vqo7I9bVt8ivw+hZvg/8Iz+49RUF+0LtjGzT6d8=;
 b=sTu1qh0+aJ/DhNMdCqH23sxz+XAotidlw9LBUqaZCTQ3cpD0WCCBjyhDmgnpFdNNGiK4Aidyg7LqpHHhOU8hxInIFPI0HojxZgfctCrPxNXwv+MfYfXpLR0UPUYjNmlbomHFgzOvzB3Px/5ebX09+77nkMnQumuOqBM97PsP7iU=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB7099.namprd10.prod.outlook.com (2603:10b6:510:26d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Tue, 20 Aug
 2024 23:58:07 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.010; Tue, 20 Aug 2024
 23:58:07 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v6 11/20] mm/mmap: Reposition vma iterator in mmap_region()
Date: Tue, 20 Aug 2024 19:57:20 -0400
Message-ID: <20240820235730.2852400-12-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
References: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0391.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::9) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: cb6ba69e-b179-4660-135d-08dcc173f01d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZDwf26jTixkqPxA287NL3hWqipzMnnaXtFzOydyBFP2k+VYW3jjdrlQOK4RG?=
 =?us-ascii?Q?GWyw9yhRgERqcRo6cp5Qv/thpbSCRh/nlrSjsibCY7kJcmeZztJVX86YhxQX?=
 =?us-ascii?Q?nAbGtSkxiNjqYW/+21bkQCb1fG8cFPQ6UsXd/N7A9Ak3M9VeuKGh61ZOJE65?=
 =?us-ascii?Q?2vFg5HF7thw2LYYoUXmYhPiUoEJJWZeS6PwsDjPkcWAiUH/6zocnJV7vN7Zp?=
 =?us-ascii?Q?/HggXF3oKWD0bcfbbH/6i33FEW+l2HMiiqwuxttiUZI+wkELWFPoS2D4Mcbw?=
 =?us-ascii?Q?GYMIMZ+FLcrz/SrLDL/ces32L7NbqyeEQSEQ3YSVxuDz+iuRNJeWGHaHJJz4?=
 =?us-ascii?Q?rr7revhLzGScpwwalooRogGeHCUBwGC0aKXMSb2V41Y3JuM50biiJghfggCk?=
 =?us-ascii?Q?laG4X6g461MLb8XtxsU3SY+9fPZ+6OqrV+K2ALVkZVls7ZFfCy4g7zwH9Zmj?=
 =?us-ascii?Q?V/Icy6Y8H35dHZ1Qw97w7tPyX1Y/k+9c9QumrNLtOzUQMj+rdpMCtkF9bwbT?=
 =?us-ascii?Q?gWNvcpF8AaiJmwj2z/rsJSKvb5G6OBkhKsACc+uA9UHgS9F3AlprKH74wMlU?=
 =?us-ascii?Q?GW6Z//jm+r99eHZwwj2msmcTV7qf2jXPAkUuPrGaIg/ZMR5T1DXGO6oXnf4Z?=
 =?us-ascii?Q?CjAWVOOgdEUxgC9gEqDa8gaGNN1uFaaNJtF/m9UBVLlUE2+Ajq/8I6MvlyIz?=
 =?us-ascii?Q?XdDLPUVFcZImcwEpoMZM466QRBQCtjatm9ZF6+c2LHAx0r7otEE2jhJHXpif?=
 =?us-ascii?Q?0RadKy3N7t2GfyTWqeQSEpUT09Lzbrp5lJLTgHsSPb1wq4fRFoGnD2p5GoI1?=
 =?us-ascii?Q?77cwnKXPZVUTOc0x9jyyNCd4bwDDVIn7UMDWNbKZ4l6rBBUnFQl6RiAE4Zj7?=
 =?us-ascii?Q?OdEwRazAjkrEQrF+Ix8imMKF+1RmVor+5fMbwtVKgQY7RQT5lthcX436poki?=
 =?us-ascii?Q?rdHnwGWSLYP7buhWwBCsc0PTH4YfQ5PT9D9R4LRKYYgX/hfuhKS3xuUI9pFW?=
 =?us-ascii?Q?yfAWhc8oBBMFUxsDSm9SAgCtaJBKiGPiZZ6p399dLoDf97pARyZo5KwwUWFC?=
 =?us-ascii?Q?kKeVSq++olDobehyGEgrRLqxG1YFlflx4WGl9wWgXpQuffOXx1XYOQP7h73T?=
 =?us-ascii?Q?TPvX+4viHnzlQUTCXEmaWULXtUfR06bU0Q4igx99+8DKF4GE4PSrfNLp7TA1?=
 =?us-ascii?Q?XmwYvYBAPNqHXf+oEYMV+NjEwOIQBJRKbZiz5lMvO65hH1WgxYUk1vOkEmal?=
 =?us-ascii?Q?tgKuiwo6UQO46hOd7uMptwQ1XPhbOKLY8EOLjGDQj4ZE55alFb+tKZYUydJL?=
 =?us-ascii?Q?4zQN/i7DuhguA6sp8+hUMe3wp83ORs6Mna1aS4YjGQHXig=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1y3Ur1rnxkryp/XCIHbrAleVjIBy+0n7ODM1lxXnomMLHCLCse4WD4IyUFhP?=
 =?us-ascii?Q?so0Olefm/CtBzGaigp3+c0t4l/6iYP9d5vhqFhMtySWldTQX/LS70+1k3z+V?=
 =?us-ascii?Q?sFWlCRjjQLm8i0bza/y3M2C4yoP70dUuiLx7MM04AI7SU8oUlY7cXP03iBwH?=
 =?us-ascii?Q?d5eNvORLpxwi76x5RsOMpV8Leunfc7lSx2Bk3mJm2+y495K2wbReTnLAzVMc?=
 =?us-ascii?Q?m8GSutlZaWF6w8xITC2eBjViIE/wWaSggxj4CQ8Wq6lPP/+ZzwdPxUpBTe7N?=
 =?us-ascii?Q?mAZ1ebKPZYaV9zCAkQoLE0bCEZNckiy5VIzB7hYHikXap7MoaIyE9/tGxfcJ?=
 =?us-ascii?Q?5Ugo5HGSFa87t2EWe2lBN6QKdIcjktqyWeAGbSzVa+FRx3NdYb6U7+ckKaU+?=
 =?us-ascii?Q?xRKtpnMB93VGg70fEOzbUeIv1geeZZGKXA1pnxIXQgbDBvzFv+WZhlJnoihx?=
 =?us-ascii?Q?k36OMuN4oY1e1YQGujZkRj1d+OK5sHzmDbQMGtzfjetnZF10TWvXDqzG5fCr?=
 =?us-ascii?Q?UV2nw/pPSz4bJDThS0Uzyn7diYehPPt2Xb/zjKXjSxmGmtkM7dxCpfM7Wh4i?=
 =?us-ascii?Q?m+VVdJCRrMFyAj4opx6uXt2K19K4MFeNL0XBj/NbLt71R5s3PqLPhgMchkW1?=
 =?us-ascii?Q?XnUGJ11+R8vMs5yS7ftO4+u1msOWGpI8KzG9QiuUjPWDPnRLr74GXRNZu0E4?=
 =?us-ascii?Q?/VrNdD3DheHfbFSoFVFPFbn7EvzcJ5ha0/V3xDm0eqnSA9JOPSE28c8h8Lqa?=
 =?us-ascii?Q?Hzjq+TZ4OcCf4MU9BjqHjB0FZlgBwUrR0pfpH/4JEic5LaTCp0U+z1K1b5ma?=
 =?us-ascii?Q?h8vVEESTarFi+226HNwyILUayjLWkonePtD/uTC2kc+lHBBtSCvgiye8uJnn?=
 =?us-ascii?Q?Tz/3/BmkzslT8UHwHvZ0756StXjCCk9jPFnxKoHp1akVBqIVUKwh17H6vSdk?=
 =?us-ascii?Q?RzL4qPJqXV85vx0lHSuLQuFMfSRGSHnCj87DPxSuaNPSLO5LXAen6zOiSpPh?=
 =?us-ascii?Q?46W+e6DVeokHqsMPZQAscUnIWSEeE5Hnlm/vlWb2/PweO8A/P59ao07NdxQT?=
 =?us-ascii?Q?9Cde8FTte0EJXMfA8/qVZEiQ9dVHNRutp1GEe8IkDNlciiLsBE9cvQ+sD68V?=
 =?us-ascii?Q?VxFcwmOGWc8XUPnqIAN5ASPXG8nUiMVj9F/tO6m1AieIk/MvyYuwVTtjxKlL?=
 =?us-ascii?Q?mIvguPPZ6ckg4DfzpJmtW56TXuy6opqW3aRrQZA+LUXNWnrpqirgV1XKzpn4?=
 =?us-ascii?Q?mypvYbaBZ8UrKgtwY5IQH39Gd3Tn5X43hkibvpZVzXcRqEJ1j/F70hC2jOPZ?=
 =?us-ascii?Q?5j9JSASJoN4RSnHJziS1AWeiolY6zyr6IlV9EzAwBaGY3EjAOSuMnEvuAFow?=
 =?us-ascii?Q?y2QQELZ5u+EqvcWsmMAV3N8QYg8vCswYPu8SqTOe0Mpw/dvLVY05k7khj2AE?=
 =?us-ascii?Q?3OoO4E8ClZghQB4awPmMZEUHbrqd49EhmoGMZ5I9NGWjFz13ySNCapvvKMr8?=
 =?us-ascii?Q?of+8i5oDmXYmE6Vj24UH58tXKdv1Ik3L0d7sQLHNiovzctqFp3QPNBHFEBHm?=
 =?us-ascii?Q?Gpb9mZbMDDfri8pv/nl8laSZxgNdIgyRWHQsM6KbIGYsDZLEvbVYpLYwdG3i?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gAzegGg5AF/C3W/oAHHm5NtD1wS7RojqclYuFIBc6ERl4sXEPabtZsOmazpW09orRzlfwSLlutEPqZszmZoYdbl5fmv7KG/+Lxf25x3zqb9T1hXvlV/mu9bXtann+e+upaFG5Ikby2EWnZYL2qfJqeh4dQ/xyeHHGxu4QSawlr05/B0uHCITGyseia7w7QIhY8tzuFlXB4r1Q1pre6Ud7/rrGQSiFhIv6KCZPXlTXuuV+lMesZJ6+SCuGzga6ch1hpiggVtMnSrQvqarA0NcBK+g0/D1Y9/D0FK5a+wR5M2E7ye52qG4i+zUkrQZD6vYWNMQccMQ28Ki5rI7CPE6VZM9QrJrBWIhLcNodmvNCWdyW+RZw0bIWuK2X+IRRZhJfnGzMlSbQwJUF/mmFWq++SC+A80bEhbTg+BS25fmYm6cbvkt35RpDdDkprPJCLRiUwuUz2PzQwgIS53m8wfWqAIO+6IiuLzInf4Am0k96TrEHBofw5uwnpEwnzJMDOZvKn+OWdzhz0iU9Wq+i4v376iRGOGOp/a41uw40CuOF0TvaxfevBQLthUd52HFYN9dbadPWNOSUPtDoIQd9BPnuSpJoV58qTxZbqmq1kuHuEM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6ba69e-b179-4660-135d-08dcc173f01d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 23:58:07.4763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44TB+bCAWQBSmm4aeAodMKm7HEfJ3aY4EUNirjI9gV+Ilv09jCMpwG/Oi/ZqYdPgVcAeCxlG0z1xpH7zK567Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_18,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408200176
X-Proofpoint-ORIG-GUID: MORbhZ9uJsX2wbPTYmwHqrh0LQ6K_kjC
X-Proofpoint-GUID: MORbhZ9uJsX2wbPTYmwHqrh0LQ6K_kjC

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Instead of moving (or leaving) the vma iterator pointing at the previous
vma, leave it pointing at the insert location.  Pointing the vma
iterator at the insert location allows for a cleaner walk of the vma
tree for MAP_FIXED and the no expansion cases.

The vma_prev() call in the case of merging the previous vma is
equivalent to vma_iter_prev_range(), since the vma iterator will be
pointing to the location just before the previous vma.

This change needs to export abort_munmap_vmas() from mm/vma.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 38 ++++++++++++++++++++++----------------
 mm/vma.c  | 16 ----------------
 mm/vma.h  | 16 ++++++++++++++++
 3 files changed, 38 insertions(+), 32 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 2b7445a002dc..9285bdf14c4f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1400,21 +1400,22 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
 		/* Prepare to unmap any existing mapping in the area */
 		if (vms_gather_munmap_vmas(&vms, &mas_detach))
-			return -ENOMEM;
+			goto gather_failed;
 
 		/* Remove any existing mappings from the vma tree */
 		if (vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL))
-			return -ENOMEM;
+			goto clear_tree_failed;
 
 		/* Unmap any existing mapping in the area */
 		vms_complete_munmap_vmas(&vms, &mas_detach);
 		next = vms.next;
 		prev = vms.prev;
-		vma_prev(&vmi);
 		vma = NULL;
 	} else {
 		next = vma_next(&vmi);
 		prev = vma_prev(&vmi);
+		if (prev)
+			vma_iter_next_range(&vmi);
 	}
 
 	/*
@@ -1427,11 +1428,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vm_flags |= VM_ACCOUNT;
 	}
 
-	if (vm_flags & VM_SPECIAL) {
-		if (prev)
-			vma_iter_next_range(&vmi);
+	if (vm_flags & VM_SPECIAL)
 		goto cannot_expand;
-	}
 
 	/* Attempt to expand an old mapping */
 	/* Check next */
@@ -1452,19 +1450,21 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		merge_start = prev->vm_start;
 		vma = prev;
 		vm_pgoff = prev->vm_pgoff;
-	} else if (prev) {
-		vma_iter_next_range(&vmi);
+		vma_prev(&vmi); /* Equivalent to going to the previous range */
 	}
 
-	/* Actually expand, if possible */
-	if (vma &&
-	    !vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
-		khugepaged_enter_vma(vma, vm_flags);
-		goto expanded;
+	if (vma) {
+		/* Actually expand, if possible */
+		if (!vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
+			khugepaged_enter_vma(vma, vm_flags);
+			goto expanded;
+		}
+
+		/* If the expand fails, then reposition the vma iterator */
+		if (unlikely(vma == prev))
+			vma_iter_set(&vmi, addr);
 	}
 
-	if (vma == prev)
-		vma_iter_set(&vmi, addr);
 cannot_expand:
 
 	/*
@@ -1625,6 +1625,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vm_unacct_memory(charged);
 	validate_mm(mm);
 	return error;
+
+clear_tree_failed:
+	abort_munmap_vmas(&mas_detach);
+gather_failed:
+	validate_mm(mm);
+	return -ENOMEM;
 }
 
 static int __vm_munmap(unsigned long start, size_t len, bool unlock)
diff --git a/mm/vma.c b/mm/vma.c
index 2840cbaeff8b..a8d716c39db2 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -646,22 +646,6 @@ void vma_complete(struct vma_prepare *vp,
 		uprobe_mmap(vp->insert);
 }
 
-/*
- * abort_munmap_vmas - Undo any munmap work and free resources
- *
- * Reattach any detached vmas and free up the maple tree used to track the vmas.
- */
-static inline void abort_munmap_vmas(struct ma_state *mas_detach)
-{
-	struct vm_area_struct *vma;
-
-	mas_set(mas_detach, 0);
-	mas_for_each(mas_detach, vma, ULONG_MAX)
-		vma_mark_detached(vma, false);
-
-	__mt_destroy(mas_detach->tree);
-}
-
 /*
  * vms_complete_munmap_vmas() - Finish the munmap() operation
  * @vms: The vma munmap struct
diff --git a/mm/vma.h b/mm/vma.h
index 0e214bbf443e..c85fc7c888a8 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -116,6 +116,22 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach);
 
+/*
+ * abort_munmap_vmas - Undo any munmap work and free resources
+ *
+ * Reattach any detached vmas and free up the maple tree used to track the vmas.
+ */
+static inline void abort_munmap_vmas(struct ma_state *mas_detach)
+{
+	struct vm_area_struct *vma;
+
+	mas_set(mas_detach, 0);
+	mas_for_each(mas_detach, vma, ULONG_MAX)
+		vma_mark_detached(vma, false);
+
+	__mt_destroy(mas_detach->tree);
+}
+
 int
 do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
-- 
2.43.0


