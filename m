Return-Path: <linux-kernel+bounces-345658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980DE98B8D9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA6761C22073
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536211A01B5;
	Tue,  1 Oct 2024 10:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HnH4bVBM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RcTjPUwp"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683EA15099B
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 10:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727776960; cv=fail; b=L4CzdAtsTNARMKRd3Mh0GmOhmPFNwZg+X1VRDFXTFXExBEldMCBX5Dd4EAYEg04uWyy5cwBLDHXGO0e2/AW6pvCDf+MiSS6mIvSQz4ChraLNh+34TMaxi0HV6a49yqFSUq586ZL2vB7epH01g+3OFn0NAEOb9Kf8JHPEPgtuTHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727776960; c=relaxed/simple;
	bh=RRoG2GiC2Ni+O5QIKZP6eVIOpgaJkrf6HG8zs2Y2oWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MUUCIvmZW7Jj55GyqFT8xaPbMLbCJzSDk7JITJeM/O21yQtr44z/EDqFXaoQJqxtOEv9IyRDiF8uVN+RoDNj9HWSmRJFNtcdqmiBtMn7At5nu8QvCjGYH/cQ1PV0wczLbVQff4wBiBzyMO3MhPo655pzqD4bkAV3AJBJVku1exE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HnH4bVBM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RcTjPUwp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4911td3w030477;
	Tue, 1 Oct 2024 10:02:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=RRoG2GiC2Ni+O5Q
	IKZP6eVIOpgaJkrf6HG8zs2Y2oWs=; b=HnH4bVBMvtKih3jxVoGHVlBnHH03ksn
	zmJ2JL6AcYTrafEcC7GFMtEeHmhohXCWASr0/Gqt3yYKOmhqjnqElLXi+FInrSOO
	v/DTjXtxWgonu50/cpCo5XOVlpuY8T2hkmAc50uguIPM8MkkSYyA7V9Hm1VIJbKJ
	lkNGs0grWJp5EuCkgNTXUggbUhoNsgwAdoDRmTirTbFJ/GNw1VIRcQJPyWXdQVeY
	QNt0ECSJjEbWGH/lNkxPSjd6eAIHNJiZWCKWaqVXGxb8ZkV1t/rQdXkKg3bZyzRV
	j5JJ28b7K1kc1OLJ0mr6wZzQL7U1oA13EQhOS7qLxqinKKH35OaE+1g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x87d5udf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 10:02:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4918X5n6038735;
	Tue, 1 Oct 2024 10:02:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x887b1ef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 10:02:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gtt9qDdti088KQb3RbQMRNEYTeuDql1Jxh+qBGKPMp/9YH6JQQzE6uk8TNaJv4NMxOMKmzL6ZbWEor4gzKppF2YnyW/52UM5/KeEZTVY9sugyh1Qm8xmYvX3vAqFjNjIiPIB6tKDN2AtZcaNz44aV+B2QUmOKFVjsyAz/rZcxru88eN3KNTyOLwBC9OXNLkcyXrnW5DNtf8xGMnN/mBQAnU7+D6N5fo+dGDOx7b+XFmYTQTnH4sTylEEse79pipD9hSmIoiwlskuCt6FsdxyG0i6s2yuwIUiHdDWw+4JMOe0XHOlEiUQMB+GzM3RJReq2rSl02sHAFR7OpOgjCpNtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRoG2GiC2Ni+O5QIKZP6eVIOpgaJkrf6HG8zs2Y2oWs=;
 b=aBZ7hUk2udR8P8jEFEWcUnKI6NaidW5i7CmTSY3FulX4c0Dn4VngEk82des5+JA5pCcgjqWlvQCx+E6VrvF3OIyzfSM1YxWzRzCfpF6oBAvnQqSnSOVtD6qoy8ofOXhsXiH/9EgSIQ5iRhHd/rqOi1HECi95LNOgq9eVto41l5BEsPtSn/5cjKOeBoZw2cuPu+R6uFTIGfr5H0Tp8WHofGdgqE7cltadkAJnlgXAw9by223T24BF1/3BaQ0dpJdt3l9S+OW39iqul0Y/3QhFefFUlEFkYFjaF8SFnd4oJnuSlnLuhjUlcHs1OTInLgWP5J9pxJFnUF5zqDp8trQduw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRoG2GiC2Ni+O5QIKZP6eVIOpgaJkrf6HG8zs2Y2oWs=;
 b=RcTjPUwpknhP5xfOrPlrMH1A1jJ8kw+VQ0/4zOjCGqxvzA4Ql3f7oJ0tHjB+y/MyVGKXnxLG0wor7ae4uPM4POsCyAh6ljmQROIeF3GojW6HZROFhiug5AeKeWuzlIDAsKoJzTUjOxupGqnvyYkczUvUHgt3WdeLRQoxW0BoxnY=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DM4PR10MB6232.namprd10.prod.outlook.com (2603:10b6:8:8f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 10:02:30 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 10:02:29 +0000
Date: Tue, 1 Oct 2024 11:02:26 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <81235f36-7266-4ce0-8175-7c4d0e6ae3de@lucifer.local>
References: <20241001023402.3374-1-spasswolf@web.de>
 <5ec8665e-2f51-4b06-b68a-c878a969fb06@lucifer.local>
 <cdbf216338d40b0aa768f93b0fe5aff1994ebd9c.camel@web.de>
 <2f1a5621-1c3b-4c2e-97c4-86e36bc47788@lucifer.local>
 <9a97af91ba1925629d5c7fa1f1aec34f92123a15.camel@web.de>
 <fdaa29c2-e1de-4f77-a23e-8fa7523919b2@lucifer.local>
 <32226c4d16d2a17d8dbdbbd007d583a2a6a2663c.camel@web.de>
 <cb24ddf8-2299-4b65-af04-e8a1ecc180e2@lucifer.local>
 <386f485c-5dec-4c7c-81f8-a23aa98a72e7@lucifer.local>
 <0e9eb75f6342a7aaa1fd0eee3dcbbb15fb1f6539.camel@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e9eb75f6342a7aaa1fd0eee3dcbbb15fb1f6539.camel@web.de>
X-ClientProxiedBy: LO4P265CA0233.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::19) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DM4PR10MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: f72546d1-f841-4c04-a527-08dce2002931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X+NnGijElHn5LDVPNbR83ofoU+w8gRLlsrBcTtPWkz3R6f1IfODovq3IxoQf?=
 =?us-ascii?Q?WISanD0j43e3B0HP1Bhn/kbKHWjg322l44bvnzULBVLuzinSd5fmnmo5crFP?=
 =?us-ascii?Q?xFV5rRYJvWhRyO7KBFR4UIFrvEB65Falj9/6u2fzt48+IMcOROayNwHTwvf6?=
 =?us-ascii?Q?33ls1oBvCjV/uOdOe+/DKKcvw0uzoFjZGDrmIPsCHQokZ0cJoozQYbLagwdM?=
 =?us-ascii?Q?16HisJxlKfefeTDkCVzXmgzlbqZmq6w4yG3NwDcS4FlwHLH1tvzpoyX9I13f?=
 =?us-ascii?Q?TR5ywHDfIl3he0ujfVUcSrHmB7qmjVeMFmUvYCFckQ8/lXEpkZLezTfYqOpH?=
 =?us-ascii?Q?aR12Irklxx/Ok7TMKqzJPWZXeKn9cliwxkyDWLFB13EvHvsirddYzZl3Rwzj?=
 =?us-ascii?Q?u2IJoO2marvydnnFg6YQx+JROcBc8SzvqfG0PUOUI+DxtfzFrB+68SeHtZfK?=
 =?us-ascii?Q?tHT8KaOpp6naJnE2iLA+mqG2nW7C9+mJzyAFy3K9atOnBuVJQpdsbI90+Ivd?=
 =?us-ascii?Q?xOfvVqh4e1p4JQlEGFM6f5KYjJlikYmkIX74iydhE7bLZEMFaJGMw/6WLXOD?=
 =?us-ascii?Q?dTYMbLqgThzigjTZFP/3bEmsNfuv+DwmPc/P4cKhve/unYOAyJuNZ/2/QyJD?=
 =?us-ascii?Q?Y+vL4WHpTEp71jdgrMvO8ogcEPQAzAvXj+wd/Eukh01HqkEBlA5rXS6EoCAK?=
 =?us-ascii?Q?YW42A+aqdY6fhLWRfPocyccj/IGFFmSD7xGSMtMsGZWExmAUjk43dAGWxnEr?=
 =?us-ascii?Q?+eVADio/ZEnYBd6xc/OZMTKw2kAvzv0IZ7im4wa63oQX7Z4UcZwB8bDYSv8u?=
 =?us-ascii?Q?AR05ziT1FLbDrxM0MJjrc/dUQrPuETADiH9LJROzRxeBSVUCRe8XDDQe8YYM?=
 =?us-ascii?Q?MmOHQPfUbaYevIDH5nTKueI1fogXvXKhBIUrXXsmuEQ7YM8lPsj5U32VXt25?=
 =?us-ascii?Q?dulwhzLAvNq5B7RzqkTjwbqfVbXqahAMNbFgyFtRLziTWT/r78cxEPFRIV4v?=
 =?us-ascii?Q?nvgDhUvE6xPliUXx/FFu49EordxeFALPZOHidMaMXsS/6CxnyQTi6Jo/Qgv6?=
 =?us-ascii?Q?35Ad3k4pgWRczKKP8aJUr53vJ5HrasIf1mmXTMnnLuZF9otqt7G45JolTeZG?=
 =?us-ascii?Q?RenTCRDsKF1zGGPIAkdBsGTaqKIfKXEu+JoTSitzPvXRPhny+h3t9ZVhOc6Y?=
 =?us-ascii?Q?svfckjJlrQwbwYRXYXADbkCrbwAR7u8pbEbpKBd0ezkpzy6oIBXKjjUrvZC6?=
 =?us-ascii?Q?ksiMKI8yGnuocWTmibTOBaSZ+qMd3qa84nvvpoaTbw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YSgbgsETtPa7eO16K/j/eWh1Ks7mcaa58FHmM6PeTPIInWdsqgQ6jUkaXOp7?=
 =?us-ascii?Q?Pe0JdtRPiq2IwCqDU+8gKgGvhAac3fDhcCZrT4jQ5yKoerKYe0U41sV3X3eB?=
 =?us-ascii?Q?AK90rUy5vBZHzSOQ1hbHdOKTMOytAoCR+czuLjfARhUMT20N4y+XxRDm3sGd?=
 =?us-ascii?Q?Jo23qb4oPyC+kK39L1u6l7HpOXVkdKchoeLWSSt3iEzbYLHIF/y7H65atxWD?=
 =?us-ascii?Q?YneGxvJeKf9kYU/hvn8TScAXz0HVDGBGJ/kP0808lkV8jaDNFcfp/6ntzS+B?=
 =?us-ascii?Q?SMrE9R2e4u0f9prgtuTs3jihG71/7qGthhqiDp8xo0+dc5LpFKYQJJy2VxUV?=
 =?us-ascii?Q?DTbNdLX6IHjr0YwK48+MLOz0jXWuABPlgVpm64Ri460EUZQ6WOwjLap6Qs8S?=
 =?us-ascii?Q?9j+/LN1ZyZeNXwl0HriLCYCqxXPdoVKrRKXFjSjYt/pitCo96hA5ZGwf/OBE?=
 =?us-ascii?Q?wJQHIjqFcNZSp8G6LhDp4yDba47jyKM24VZltjMGLgY6K85PdvBN6nRz+gap?=
 =?us-ascii?Q?PsfE/PE6GJW5KhY0KN9mNvR3b6orugCFIvP/+2KHy6tumNzXgDK4a+rqJt3U?=
 =?us-ascii?Q?BPgEWPM4UQ1MYfakGFwUt7Ye6rZNvBV7jgQw/JvMEOWMuLuFtEXrW3VfYDTj?=
 =?us-ascii?Q?1/0mJhmSUNWUJsgnoyc4FpqpzUWy6K2D1ivXIBYOM7I9PDRhE+DkNzlriLJb?=
 =?us-ascii?Q?A22ufrflrtzWa9fxhBvl3BzqjM76hbsCecg8LUaZxjippAw+Lgp3tgQWwXAY?=
 =?us-ascii?Q?HTvDKuV2KPBmRhoinAFBWxEAT5K+nvlYPpknLJx/q0mIerVX38/3LWFNyLdj?=
 =?us-ascii?Q?eCTUIviW2p7wt2MfCXt11iEYvx7sDwHWxqws8RXt0/w4F01FbtvCgyhUCJBc?=
 =?us-ascii?Q?RKRQ6D67KPwbBl8biCqfUr0/JU3/S2Bvdz5DDrU7Ez8Hy/pnXhqSLYkeev2O?=
 =?us-ascii?Q?keq/hQXZ8px2lq7uGjdnezMA0BWtgohHsr790i2NnKDqezzsthxrSwpJDosE?=
 =?us-ascii?Q?NOoSM1Bnb7rhswCrn66B78Zl8lqk3yx6hEANbZ1mRukiATPs2pnw8UD4l7lS?=
 =?us-ascii?Q?U4O8ylagzG67Uub2cGm+GluRLa15B6qO6JMv8Ov7rgyPTFt3BOhZBmG8YFUY?=
 =?us-ascii?Q?iWM4lFNwl6+u3FDzY9SWv1c5v6VhYlmI7MGyqnJqDsqcp39i6oq/pER6ACp2?=
 =?us-ascii?Q?Ges8h46JOWunPR/BL3oKn2WMYMIACPPWCj9DqnWW5T/l8rQlRHY9LeIy9OG6?=
 =?us-ascii?Q?NbPRkAQlNmZYhgTmiM9SDo51BpQryoAV3N1HFS35leAKDW0p7SQek0/l261+?=
 =?us-ascii?Q?aJoNungwHZb+dTeahIVU+2w5bYdQWsiphkys6qwIe/YH4zm3RQCKxFaBCLwm?=
 =?us-ascii?Q?jV74w7Z2MTXsBGZnVYyy9HOhsOYVJSGrSnlFh144+ygSXOnUjU6/dead9AAJ?=
 =?us-ascii?Q?BBZNMflwa1IlIJA4br/SmVAO/P3mLeYGMQqyY4A9JGSuW7wP6cztiQQDKTm4?=
 =?us-ascii?Q?9EVhXxTgULovjZEZyiM3cd3AoVzakM14sd8Ofd0sF3DVyoEvHxUsR2Z43s72?=
 =?us-ascii?Q?RczJYhLVkkJwFvqJsTDfxck6ZgntSKs6I1IU1zxZRuSUYS5jjDTCYIP+RDZ5?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SE2SmlMHcSi453+ZM+9C0MpzFRcKgrCx6Mz1hIRqNUhYIJPH1khTnbD/HSSsU3KaOKZVRKh+pwMhPybM97Ie3P+kTRX9sAopk0rxrzAL0ocasPMGenXueh2U82GgGH1tJZ+/CYDRIRDBX9KxaiQyrA23SBpOhqWOstktn6ZE2+BUh8FyyayPJalbhegN4hVGTBmm2uCMe4q3bpUQfk6NN5nF+MC6Rgnq5AwWtWAf1LGrgWECGhb6GY6AqcWSJ1Tcu1DpyxGLMsjoCmTt+ege6R1GICjHg7JtpNaSb78NSkqFors5pe0EtYMtkUO+CUpYQBb9KFKFhWRC1Z91XMV9u136GFSgeGW54Izria2HJj1XUCPPHAcOLz2onn2KoiyyKEwMOHTNSQNydFfelOejwniN114SiS5tIn/UnY0mPBRw53JEEMzBO4eousEXuM0TGcrl/4dJQYlWsVNJQngFqo8CfdxGHino0tfzTCXjxl7ZO0G+yxb3IX/Byvz3s/NCYUEXdDyRuras/4XLLDWBZeo6LuV0/+LzpAIVhORxA9t54r8KkLYqcOEgo78zuK8SQRoMD5iDF9Ax4pgbZ55hva+/iHGlRGs7HDUp4GEqyxo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f72546d1-f841-4c04-a527-08dce2002931
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 10:02:29.9509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucsDgSLpLQa4LJ4gB7MIKoxqbXdVSC5AhhHw6ChD0bcDkKFQPOK7zVxRTXpHj21EKCr1IdlKdbWjwt/qBSDC0LKzV8b6ru042ODiFgRknak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6232
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_07,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410010065
X-Proofpoint-GUID: QbLgXB-Rs5V5wE3TLSjvvSvx1M0rzXZi
X-Proofpoint-ORIG-GUID: QbLgXB-Rs5V5wE3TLSjvvSvx1M0rzXZi

On Tue, Oct 01, 2024 at 11:57:02AM GMT, Bert Karwatzki wrote:
> Am Dienstag, dem 01.10.2024 um 10:49 +0100 schrieb Lorenzo Stoakes:
> > On Tue, Oct 01, 2024 at 10:20:02AM GMT, Lorenzo Stoakes wrote:
> > > On Tue, Oct 01, 2024 at 11:10:55AM GMT, Bert Karwatzki wrote:
> > > > It seems that the maple tree broke down, here's the result of the run with
> > > > CONFIG_DEBUG_MAPLETREE=y in all it's g(l)ory. (Here I didn't need to try to
> > > > kill
> > > > the processes to get an error and soon after the error occured everything
> > > > stopped working so I had to reboot via powerbutton.)
> > > >
> > > > Bert Karwatzki
> > >
> > > Yike thanks very much!
> > >
> > > If it's at all possible for you to confirm this happens on Linus's tree
> > > just to be super super sure (again I totally expect this) then that'd be
> > > amazing.
> > >
> > > I ask because we have another thread which bisected a problem to this
> > > commit which we didn't think was the cause and seemed actually to be the
> > > result of something else fiddling around with things it shouldn't so just
> > > want to entirely rule that out (a fix was applied to Linus's tree for
> > > that).
> > >
> > > [snip for snaity]
> >
> > OK so looking at the output it looks very much like your report is
> > unfortunate truncated...
> >
> > There is a 'BUG at mas_validate_limits:7523 (1)' report but immediately
> > prior to this there should be a line containing data formatted to "node%p:
> > data_end %u != the last slot offset %u".
>
> Actually one can just grab the report from /var/log/kern.log after a reboot, I
> just forgot to copy that line, here it is for the old report:

Well depends on distro etc. I suspect systemd systems probably store too but I
like to go with the 'easy' or at least straightforward option :P thanks though!
:)

>
> [ T4598] node00000000f48524f2: data_end 9 != the last slot offset 8
>
> and here's the error report from next-20241001:
>

Can you confirm that's definitely the first line in any bug report in dmesg from
boot? As after the first the tree is likely to get more corrupt and later
reports are just not going to be that useful.

Could you upload the full dmesg somewhere and give a link? Or send it
direct to me at lorenzo.stoakes@oracle.com? As pasting whole thing on list
might cause lore to sick up a bit. Possibly...

Thanks!

[snip]

