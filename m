Return-Path: <linux-kernel+bounces-447975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B209F3973
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1C7A16C4AE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27AC207A34;
	Mon, 16 Dec 2024 19:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KJ6BcCFK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TWaqy2xg"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828F3148314
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 19:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734375708; cv=fail; b=ZZk0U8ufbGQjqgHUONJnRyKWUPCzen332CKf3Th7QeSj9H04v1Tvc6Lp/nixyxa88Bo6S0wCg7ga+o/+myeVR8OcNnNmvZdoRLCZlfNCEEp9oSm/aV6Pf8kW/kVb9d832lyIQKX+Z7Klc0kTZ7DIGo7juUmJJqgSKlRrDTL8rRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734375708; c=relaxed/simple;
	bh=mN4lxjyQlTdzODY1UYOJyHIaCGLcbJVX8HrlVjlEHP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J7Uyt1vRnlw7EKsKJIx0Uo5PBhZ1vkVBxJTsd2WdDq4vkc2HBnSX+bIk+P+VJECKt4m2swKU+wYIYpzrkbliEswqZbFLGrpTu0l7RyD5KKDHNZ7xK7+mrkOyBwEhub9y3UIjUFYQtB1MY6BNO681F62Xf6+BTF9HIkM4vBfcGSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KJ6BcCFK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TWaqy2xg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGItuTf006696;
	Mon, 16 Dec 2024 19:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Ia/NP1kGJgCvcglMLxHajq/c3d/8nTeQNYTL0rvJcug=; b=
	KJ6BcCFKFssowP0kfAEqeqaMsCM8lNVVXi5oVOh1pyZwIWzIlNyWMfUWciHaYoTC
	f87uuBZuj5SToDlU0T2LLs0kuiUDwW02+0kPkU5M8KaJZJllaAwu4xd396vMA2UI
	o+IZHWah2Kzw9VSp444Y8ZOYpqTmbdNaowWJqnEz9KOZf/gjFOvVyAGJkRrHjwL7
	+kyD4RoSm2scWYwnpj6TWBWuZHQNvlVC5yBnxyPEi9FK7WMfnYJ3EauCOD3CVGvK
	nwf79piei3nDhPH5oH0RghJKqjRqnpwxe9SKgevn8ITtpoOsuImdzeL2NzzUC7y1
	vUJ8K69PZLjXeWnILAu+7Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h1w9c21y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 19:01:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGIsqFh035295;
	Mon, 16 Dec 2024 19:01:30 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2049.outbound.protection.outlook.com [104.47.57.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f7fd57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 19:01:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNj2yzErUzfIiC9FoUdz7yT9n20M70FuKLWHfr8hbDYZUdXAbFgr14skizrsK814dlShB8N+ezPCtaUaO+OGjogMAvMf8Pyu5QYSbZ0lJmEiIb7noA1o8nPG1v4DP4UfAERTKkHtmWBBzLIUH6Or/Q8eN3yYQlzMLu+v9L+P0ZuwMbmhdeLvgHiXyUTIOf0NeWWkBFbQIxFf4HyvfFM1yZ8CitLHPRB0kUaJcEpW46018btnUhBYmEY2uYmMiOUUazVKsJ+10s/OCMYNMWkc0nDx56MjAEIr7BqQ+5jXaS020sJH8i3Kg97Ir8cWPLcL2piUIIHGjsw1VPTVHjE1Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ia/NP1kGJgCvcglMLxHajq/c3d/8nTeQNYTL0rvJcug=;
 b=fA7LXNlhKeaHfHUq+0aLHZK+BEZoGcVb3LiTrYSyH6S1QrwZLFY2cXCX5H5GQJeGMMqGRYFQoETSUqmYlhr9Oy96ztgploMV8YHRC8wz5sY4Tak8K2fBkMxWJj4HwqAltXJ4c4+adEth/dxIG1/kfJeIwvMfqsGuJ43qGxVZjUhpuerMZV/8G1TUKMms2OaiU5QKs3KgbXD1TYjRdMijLHx93e+dLYq5Lh/VqXDM4Pt1AzJzZkuh4pbqsufKsehaxTsG7iOFTUfyygw6UXlLSTVZtA7SmVvITM6HXqG9KUJnU+29JsZU1PjpWbjeyNcGNLFkYujxPL/WHXXBuOvSMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ia/NP1kGJgCvcglMLxHajq/c3d/8nTeQNYTL0rvJcug=;
 b=TWaqy2xgjkg5UZeAX727zqY+1PFTyZ8P3ZVfoMcWofBWCu3Af0dsAW/gwGiwZNEf6fEQx0HcICLU/c+c8IFY4rG0JItAgyu5PhoiweCmGeGNUmHgzDsmTF4tGQbFKNnyPAbZ9XuLBA8P4IxuP8ikbJ2LC4BcPX8n1sBMt94sme8=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by IA0PR10MB7602.namprd10.prod.outlook.com (2603:10b6:208:488::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 19:01:28 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 19:01:28 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Erkun <yangerkun@huaweicloud.com>,
        chuck.lever@oracle.com, brauner@kernel.org,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH 1/2] maple_tree: Fix mas_alloc_cyclic() second search
Date: Mon, 16 Dec 2024 14:01:12 -0500
Message-ID: <20241216190113.1226145-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216190113.1226145-1-Liam.Howlett@oracle.com>
References: <20241216190113.1226145-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0408.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::13) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|IA0PR10MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: 62739901-6c0c-436e-1784-08dd1e040bc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mb1H/UzpAXCQeKxSgbm3GY7Kqq7BINlf/kl1AaQK10uW8uLjX0gLFdjvolv2?=
 =?us-ascii?Q?kggvqRJFfyCc1fa2epkPfraNdD9/Vx4FO4Kpi8bqwzhnnGZom3ZBAEJxYbK+?=
 =?us-ascii?Q?lGNH5LB4CHxplFSbvZjiKHy7RRKMbDWMHfK041z1ydcWRHeQjUIIedqG2hQG?=
 =?us-ascii?Q?Xck/QBBj+V5UMgPgMbtIVUSI6UuazLuGYb8mpNZSmVffq7yFSwdd9I360kjg?=
 =?us-ascii?Q?mTQpOmNtCJvsor5t80DnUag9335sub4FNqbwITsX1Y9j+RQk56Uf2BoxblsM?=
 =?us-ascii?Q?77rkd2xLbOzgJH468ZCzE63pN1UYXUz/VQHiigFHdyhUFdoc69KNpoyEyZk3?=
 =?us-ascii?Q?g8SI1+oCAENQXJhg0OJ1UHYky4DUkdvA+JXsFYxjPLwpvKlUjkOqN3NJ/XaG?=
 =?us-ascii?Q?HLtNyuugtLoDOLUGT6jqVLVrVCuyW2Xe/vZGDUy/tpldfAZ9mJiVuW9vF3ev?=
 =?us-ascii?Q?5weaoLLJTw7HD5kJg3JzaSQ+AoRD2ItoFdAN41tjv2A6uTM8f7slE3KKpkIk?=
 =?us-ascii?Q?S3s2FvoVH8Q9DTBkSjvhTZfPUPC2xwnyn7/GdGvSR0y34MkY0dl9jk+2ZJSw?=
 =?us-ascii?Q?85KqYeJZDre88EPBE9jFQCbOG4YEkHPXtooFGt4WZPGJumOAR0bAY6x4EZ4K?=
 =?us-ascii?Q?JG3nBvnd6RtPzW0dWOVBKzBmKysp8EsukA48doy868+Szr4/cQyuNvo/18Qk?=
 =?us-ascii?Q?FYlONfz/AKDDjqqCpRmyEZ9OhcPnM1zxLYF3/5x2Jvt8RKxnIdW5N3gDt0AW?=
 =?us-ascii?Q?9HS3e9aQ/9WH/GNq4bgliFzQ5pRELI2I6mJTQfDbKJWTpxYLBLmXjX6679aa?=
 =?us-ascii?Q?u2T4Lw+km9pa5dhuBUFqb/y18RwYj6AfYFNHRFJmcv1i8ZPFlN3U4At4eFb2?=
 =?us-ascii?Q?3r1ojAd0emZ7ntDQyG1vFPXeoZIP+/siVu42/OF5Aw2wj7yIpqpR8Q1GLggw?=
 =?us-ascii?Q?ppfUWC1MgileSyznWITdutAJ7P2SBYPYiiFZtJZhFvpieD0M5zeo1I5u/NKg?=
 =?us-ascii?Q?ajDFYNKTsuMAvt+xJmuJFYk4GcWoYyr88u1lygHVNZ2EPWJiCYMe2mVtnwBs?=
 =?us-ascii?Q?g3BVzTezOvys3lHrn70XI7q1YbbF745ZhXo5W/2RFd0u6pcLGwLajn9LW3w3?=
 =?us-ascii?Q?mjpiqJKK8j5mn4VZGmvd9fbTb1l61atRIGJDbWMqxx5nuste5lnJiICLTlzb?=
 =?us-ascii?Q?UgsFIZUsS0E41inyGA3fk/PSLTkXAfPlXtjtf0awAOXxxdUW/FsA8eTiCWe1?=
 =?us-ascii?Q?2sKt1K3028ltKSQUyL6TOpvS5W+DQopikpuHquMWv8fDvSUgufYHLTK9CLbI?=
 =?us-ascii?Q?iuzJlkQG4Vuab4xG5aaBy7fv3XpsE8PHsJyoQwgedqFxuLyP0PX0oqfEUiaF?=
 =?us-ascii?Q?MCao2Ox+DNKZT+/iNHc4gZFqotWO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YfYV1v1eGUmsGF8KAOVr4+dE/zRjQANVl0ytX7tfh1U8RB9+6j+56n6MzJOV?=
 =?us-ascii?Q?TNMYb4mY8moyTUnvHc/2VkIjfgHXibverPxKlWvEOKHIpnOrOQDSW6vBYkQY?=
 =?us-ascii?Q?K7DqNFxD/SbdDg0sry9CdNCK1lK1+M51hogTb69ls8J6k5A6hDDeaJFuBMRY?=
 =?us-ascii?Q?vIhu41WJeP/bRQkplaYVlNKiRxn2nRelZoQjYQTRZq35CDcxMDvAZ8Pbavrd?=
 =?us-ascii?Q?NZVuuv68klgtM+mmEc4o33uAGNpOYxGxqiNUPoXgb86uv61DLnb+LzSmKQUp?=
 =?us-ascii?Q?SzcGwrrKMwI6nJbxkK4sRsIO9MdgiU6GBShR56koLgTo7yPRe9heHoxRb6aX?=
 =?us-ascii?Q?ja+PravD9Pdv1drGigzYJ23bNHbp6TjJM159DFQ9r1k6UKA+zd+y+Y0hzY0n?=
 =?us-ascii?Q?U1ByAvYWWntBQllodRbxktt1bTr4XEOlhm56AFPjQuMfgvNAQe5vIggK680I?=
 =?us-ascii?Q?TSZq+7rPQC+DnmJYbWxyU3pw+yb/+1ZKpYhDwtOPBa9Eiho6rpBYyBbYUc13?=
 =?us-ascii?Q?JVixXnrt8dAdZO5giLfhJr5Kr3VrL8MMffrTkWzOoBtg8WqBxQRyimN4Bcqb?=
 =?us-ascii?Q?L8JKSkDq2zEOyE7CgmcVzfbiTkS9HNgwVaXmr9iOqTTS69Yf7U1mxaSmApJb?=
 =?us-ascii?Q?uuhbh433J0h7cblRrw2raP7Kwxp1iAf44Kb30ZggocvGQEBbn9Rplukce6Wr?=
 =?us-ascii?Q?9HLSZ5y29muD1CZlAMXSAwEmK1NZGVFrcJlyqmr81gbKAAkq/GJ0Bxo3MNyQ?=
 =?us-ascii?Q?NTdPjfJtsAMY9gKS3IooikW0zrJwbPUrnz126nQsy8x8aaIZwey3uNQlG9Jn?=
 =?us-ascii?Q?S08Bx1pFfZ60xXs5UgVwg1UD3Ia5s4oen44QXrC2Rq6ta2FP8I0dQiPmkWOP?=
 =?us-ascii?Q?7Usv20Lg7aK/U1YSHSdNaegFlXXqnxd3IL5pDovflLMMPPEfFE7CYjfh16iF?=
 =?us-ascii?Q?nBFxlVSMKz/DeWIbqpztbfpfaG9DYFYTuN6veTsagKVny/xdYZIeHDscUSxg?=
 =?us-ascii?Q?0ru7KBTm9N/IDHEmQzPu2XrboYOjSs1dh+/XbPbYd+2NLnNWak8daghgQHCn?=
 =?us-ascii?Q?gViUhqH7mCPavT2PxUvIA5ZygeFKtCc4feOdOJJ7Gxcb10IfMdgCqu7CpOsP?=
 =?us-ascii?Q?vEjRIVWbdzz5eeEd+hjm8mPZMj9vAm+e1hHXlEcz/1WrLL3iG/AzXGiET15Y?=
 =?us-ascii?Q?o93r/8+M7KllbAPiNYEhR4m061Qn6yydGsgZkFcyiqpQd/PtYrE15x8OmVNs?=
 =?us-ascii?Q?mwg+8l6QB/K05Ip7qUrqkIs4Aah0qbJOywwmOo8eoE1vGYGzyh/nj1k+5XlQ?=
 =?us-ascii?Q?s9btVhaHdixZ0f+KezKK6GSt8xSLAbzrBQWf0/VCQiC4JZTnQev6ITZEmAaB?=
 =?us-ascii?Q?pZDR7cTnnXMdjKSdDjXvFuCRZkzKoh5sGUu2Ou5cRD2loa8zaIvODqBrrrHV?=
 =?us-ascii?Q?wLn9WzI8qqjyZiVZYh6tosVCxi0GmMAPbdMvbgTe8hy29SprrmhxbuSCcfH5?=
 =?us-ascii?Q?nNyx+xIOG8RNcER8pfd8bpJm55vEH9HTXAdZ3K/P4OKN9pzTDeSkoxlxomJw?=
 =?us-ascii?Q?iP/f23Ztv4qVsiGQPROX1puNbp/0vzhjpac+BI1N?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i88+3TNshXyT8R/rj1QRJI6urwgdmHWVQ7QYDZ/mVyX++29s/BiRupi4cS9BHC608dK3daMTjTNkEswUZgwp6y1vURgZ+ZD88TPBRO4oCnRJAQBV/HI2q4aqxcCetrdNzVhNAksEv2hQe3V5RUxQy05fAiyTxLZXFaYHI7gdQZ4y9Eyv0qTzucGeFuX6fFoxO/fNdQrer6hQ6cGt2HgMw4elfkfEetApdhYUUkG8WlM+rDStB1iuvXv5/Gfc5Uufj96ATn6/KOXGSPvOwZ8A/3C0sSLyVXmJhPf649wSB3nn4vFWSQ+O3MLD/NLLBFdp5PeZxqnbeMit4JLx4aIduUyI/wMydAOEB6ms1TDj7mnPSIDhgCWLXbzu2XgSjfXoFPsEemempLE4hLgrL4Rpp7Rx+8LccYqW2+2neChXkknYl1Rb8TsXeyqz3hmd5dW/EdEU2aoItgGqx1++BVRM5+UcjlX+jKvMVqM5gLIf57C4pdtdjIv/Q5bNsRI1D2DeZzF3YX1cSVpudH8Vrs7VhkynKqQyuxziqyZ7UzvyjrxPvgG3xetlPgWU0VtASMOnPZsio+qQuT5RM3cTIv4mCrDO6e7Xd7zd3o50/ABceXM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62739901-6c0c-436e-1784-08dd1e040bc5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 19:01:28.4172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZRZGfn9JtF9fDKjeE1HQi6mV/BSqHIN1H6TuHLmK8b1lu3MDCWmDoTw+TDM54ny7N0w+clP8Up1lFfxrRY76w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7602
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_08,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412160158
X-Proofpoint-GUID: n7_Yjfg_Vc-6_fqrKSAnGkMLyNe280YA
X-Proofpoint-ORIG-GUID: n7_Yjfg_Vc-6_fqrKSAnGkMLyNe280YA

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The first search may leave the maple state in an error state.  Reset the
maple state before the second search so that the search has a chance of
executing correctly after an exhausted first search.

Link: https://lore.kernel.org/all/20241216060600.287B4C4CED0@smtp.kernel.org/
Fixes: 9b6713cc7522 ("maple_tree: Add mtree_alloc_cyclic()")
Cc: Yang Erkun <yangerkun@huaweicloud.com>
Cc: chuck.lever@oracle.com
Cc: brauner@kernel.org
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 lib/maple_tree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 940d30653407b..f7153ade1be5f 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4335,7 +4335,6 @@ int mas_alloc_cyclic(struct ma_state *mas, unsigned long *startp,
 {
 	unsigned long min = range_lo;
 	int ret = 0;
-	struct ma_state m = *mas;
 
 	range_lo = max(min, *next);
 	ret = mas_empty_area(mas, range_lo, range_hi, 1);
@@ -4344,7 +4343,7 @@ int mas_alloc_cyclic(struct ma_state *mas, unsigned long *startp,
 		ret = 1;
 	}
 	if (ret < 0 && range_lo > min) {
-		*mas = m;
+		mas_reset(mas);
 		ret = mas_empty_area(mas, min, range_hi, 1);
 		if (ret == 0)
 			ret = 1;
-- 
2.43.0


