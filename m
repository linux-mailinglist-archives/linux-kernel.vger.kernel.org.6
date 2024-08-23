Return-Path: <linux-kernel+bounces-298945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED6D95CDEC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920B41F25100
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 13:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40327186E50;
	Fri, 23 Aug 2024 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b5gKAu5Q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TU1qRe09"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4500E186E3F
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 13:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724419882; cv=fail; b=MWZMgK+cfYGBc5lnmrWeZ+TZRbEQUPuJC0RZYjxciOw0/9S2ErwrDmnCNRQJ6nE4N+jo/PE9GW/LxWZTEDGkylhpRAaLD4dgkWSQ6NCg/kqHGNrWVC54Tk4UX4c/4HRdafBGLzbM9mMBqJSWl1f8tCSFGUgqxRCYyt2YEx359y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724419882; c=relaxed/simple;
	bh=9NHpFtwRe+JpT6H/x30+/49ykjidHVf3WvB3MdqJL9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YIwAajFY0IyK3w+PeOOE2J5+O6jyPmk7bBOQtYzSnTv/JBW5WJ8y1oiXuto7Q6viQOslmZ4UI2dmpJ6QVR5kViwhKkzbrG+mWsN8XNq4riMJfhTgycZcfXrhLGZ1OphdcStJzyK23oXPqKGVfx5LgEKNwoqvNxyeHcKyhF1+INk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b5gKAu5Q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TU1qRe09; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47NDMVGR007152;
	Fri, 23 Aug 2024 13:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=LudkMJCRBopQOIvRJULZe36mChuuHDpk3yRnh7ZPX1Y=; b=
	b5gKAu5QSq3P9uSEJe17ecE9uE3cau5W11QPLCGCXWMGIB6wskklXrgU2ZQRJF40
	mLNsPuRQpqeoyAfZsHCU6YAI3N0nPsxQ0BTJjbLjX1Zrj5faAFwiH+WNtJ7lstVP
	BOJEdXNTW/Y41RGSO58Xu133UFn6j8fboRRz1MGeh+RFal8KQjPj9A1QNeSF/bh1
	DEPb4undsMEMyAthz7vKGryP33Sb9TO1Aj3fvsRDvTLVQq5lHKhwD3xE9LHGJ7LL
	JjKUhaVWVTQ/gbam1DtcAC2WyRKE75kCED4yNHh+BQHb7UCLINX6ue2VAKpkJgpw
	Sej96qKb4i++q9oUhZ4X8g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m2dmers-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 13:31:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47NDCv27029780;
	Fri, 23 Aug 2024 13:31:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 416u43gj8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 13:31:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frFaBU1CBgtmD5Ecmiq1r6J9s7dxcaKUwRVNLsNYgkGA623Z7pBShUrWFibdoWXtwX+MmoUmfCQQ++0B7PtdZ/06vg9dHamDU57R9/2MuOpdFps2c35uzNhCvL1FuF0DYXOPaxM+EVjE415459JSRYmhnoE4mYEJYPLNWTpIN+ExYgx7kO9Aj9ZCIWn5Vzjkcn9cz/MHfZnlr0um2EYLuihQ+Sl1eL8FiNvBUgrnYvdTh9DSlEj/yKNd6vQExMUk1rdHNvSZyI+imkllQIy8Wu+TU+dgRfw/m4rz+88HPy7Qbb+JlxucXnyOVSU9yxd6DKss3AecwO66wn1LLlYfnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LudkMJCRBopQOIvRJULZe36mChuuHDpk3yRnh7ZPX1Y=;
 b=waDhHwBLkcrqIHf0NNwEmBlFHcp/ei4s0ZYVddeMCYAqgoOiB/+95ijwaHWHzVt0pbDoq0tKTGP/A/4lzrjyoamCWdDSgSc98xrx8ITfteDHGyYJBMOm3jtHBDbqDGOsPUyELjvWYya0rxK+PtuwBhlCLqBOT5vzfTeQwE2XYlssz9C1KAw5AN37tzw6MDOgWcUJdhwAc5PRbGz2sYEhRFVULw5xrLKq0f3Fcj5S8oh888S8V35VWyevKDqGnN3w544KoDNhb2C6iGQzEgL00rQ4BIuTBrexREcwoKtxnRNYElHgXja11bmE1+II3M/K8V1CrbMbXpaQ0ziORdmq1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LudkMJCRBopQOIvRJULZe36mChuuHDpk3yRnh7ZPX1Y=;
 b=TU1qRe09LJsoXtYBpcnsXm7STVjF6/mqpjt7w1gjh0xgLM6zyDP3MkPyD/dOAmzSS/KuO5HsldupLYmdCtnedhK1A13v4kZaBnjBuKEAQMS3ZOksIHVYB5qsr3sCCxGTMlKVruzZs66DoSsCJsIH9h4dH42wOHDDMFLxGGlEKxM=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SJ0PR10MB4560.namprd10.prod.outlook.com (2603:10b6:a03:2d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Fri, 23 Aug
 2024 13:30:59 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 13:30:59 +0000
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
Subject: [PATCH] mm/vma: fix bookkeeping checks
Date: Fri, 23 Aug 2024 09:30:33 -0400
Message-ID: <20240823133034.3527917-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822192543.3359552-7-Liam.Howlett@oracle.com>
References: <20240822192543.3359552-7-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0252.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::24) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SJ0PR10MB4560:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aacbb2e-c4f6-495f-f68b-08dcc377d302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/a/YImIw+s+STMOyq2I/LIr9CQyM0CKk+SQKjdcEXPC1q84nDTFICOAqm8JM?=
 =?us-ascii?Q?TBqIdypEp0Jpq3XgV/2k3QCVbHMvI2WMapE/tC4rWt1XvENM2sYniABIwS49?=
 =?us-ascii?Q?a3WIA6+ZPyr5Esop+Xc5w6oCfiAmgBRy0wJ2mOwPHvpvMgRF9CWfewA9tXyG?=
 =?us-ascii?Q?G4xaWqmSFYoRFgC0QbHDIHZUSybQMcYmYVfZPZTb7A1FW7kReGggtQNObN4H?=
 =?us-ascii?Q?5d1J0I31/DDV9gBqpbXnyrdvz8qpHg9CRHlsoM5oJVTUxTi9RMEredqK4Ffi?=
 =?us-ascii?Q?08Mz9s8c8MTG/OduTq4iQccR8Ua617tiEHCt8BZ65olj2GYVNmISPBsKugIh?=
 =?us-ascii?Q?IZYm+kchJRpEPTxqpL7JbBp3kx9ehHpe6dPyUS9lUrmG7/CS/QFw1o2+ajZQ?=
 =?us-ascii?Q?KQFZQqwWbp641VSRTcvTbRaZpjayHHMlgHhc5yvAEpiQMmrnZ+dpBcz7Iy6h?=
 =?us-ascii?Q?zEBc7JGRJTJHtawOZ6HPMt0oi/z5qKboQ3+Ql0SwnMRhWKCZcW+Hv7a/DHCi?=
 =?us-ascii?Q?vtfAYyxd0xVJEMB+rZMrQKbsaNWuMdKpLqpys1u/obliWvQn3J6NwOGvrUJU?=
 =?us-ascii?Q?MVjLaglhcG9d81wTWqTU2KxGOkL6JBLpcHgXp8XUuzmFgXKhITOETqFTK7Bu?=
 =?us-ascii?Q?Ti8NQzmVyafTOmiaQqxnXuBdhbSGWQ9MNGCX9hqU8uF5UTjs1Sp1hR4RlUnn?=
 =?us-ascii?Q?cvM9k3wa6CRD1DYgVeslQWRYdUX148WyUVrRwpG6jD+L9fsmTOPrtD62opmk?=
 =?us-ascii?Q?fuwj0lcp/0PhN4snIm/9Scmtbp+WCENwQtUv5f1XSZkPjMkuDQrJ3J9HGAPR?=
 =?us-ascii?Q?qRkAqDfVLpJ5N3TTeeaoZRyrU31Le/IXfWrEahptRgb+3eOGx+2LGhxX0j16?=
 =?us-ascii?Q?yGMQi29cxdJQzsP1txjewZT8t0EX3tXd9Kro/GEz6PJTeDshpPsanhIHqmpN?=
 =?us-ascii?Q?ty7zmhbYPQDT9paUwnOm3us2ZoNsXeujGSobkygApAi43Ki91lUyMwfdjiR6?=
 =?us-ascii?Q?Ltd87sF1oUq3EwNdV2wqkf51NcIMIb6xqt3nnmDZbb+QG+QrsarZsWIJvwfK?=
 =?us-ascii?Q?NpKE9YYRg3ZFE3rY34m4QI7Qky6m0mpwEwe6IG2bg7NkTOlfUEkmEWt9udrH?=
 =?us-ascii?Q?vSfs0hzR/6VotKvYSrqybWB3wkD4fQYg9UBq05ILtjsEhiOwsMhaDkfOidz0?=
 =?us-ascii?Q?hRg7az3JP/U4f3iK2cYQ5cCgxvIIDW6U3L3xE3IgRv9h8NETkRYpJQ7ROYar?=
 =?us-ascii?Q?9E/tx58cCO+rBKfnJOMvm0KGRvLfHOzmJNc16XpVWsiP/sDZT1kWhnr6D3M0?=
 =?us-ascii?Q?fpKkANWFvDxHo2HAWqiAl5KnblQ6NVATsvGIZZb9AwRU1Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qP+z5NOa36dRpfXOsXtVhjgIi/qVjV92qAXE8Jzsp09DbyPHjyJjUcG5JQ4G?=
 =?us-ascii?Q?c+VHCY4EEzwvb+nwWXPc9ACiKdEcpYTfFEzyGxYUURAR1zQy5GdS4z3RhhtQ?=
 =?us-ascii?Q?atkisMI3CUPXNfW5k5QmRv+mWiPdQLpcqj49mfwNvSM1bK6WGsBy0g7ijUFS?=
 =?us-ascii?Q?JKG1DgeuHrolzeH7PjwzeFUP0OVVtMLroWPA5RZLe7C4vpghOyq5beg1NW0s?=
 =?us-ascii?Q?fyj29YADhoQI6S+xULMTxguBwyzdPkb/Yp7Wx2I/cieo6uKvIK9WjAww6g0M?=
 =?us-ascii?Q?Dzk3Mi5zupyyiarZlzLbx7xQWJ36OULc/7Z0nKnSqAr7XBr9oXuEFMTo0d/o?=
 =?us-ascii?Q?ErfZnMqAt+G5GOQNaTsewwBBoVdCVVt8vDt2Jim3LQROrIaubrOITDPFIcDM?=
 =?us-ascii?Q?wheR+m67rM4MtwYXOQrI3i36m+RxMyhWSUz7vjduYIB+xsxW2RP4NqOtiHT6?=
 =?us-ascii?Q?nVJepnLEuU6+gu+kOT1GSumk4xwU7kwHPKbkIrP3gUcyErfvkTnSJpXUdcvP?=
 =?us-ascii?Q?/mZfUeE150+8AMMtW8LiMV6IfUtm8b6zrxRSivJ5QBP7ySMddJSExSA9nZWy?=
 =?us-ascii?Q?bgPyqJ/je5TnN1QsIZmbPKUpPxLVw1VOz7X6IMcK74KcH+pGX+o3RSpKJvoV?=
 =?us-ascii?Q?MWahtLDo1fuK/OQlGvG8XOy+myA1KjZRhUQiwekZRfySGHaqeGzxX/oZlp9K?=
 =?us-ascii?Q?BS8n7hNInRsrCy5EAvgKsBcNM9bKe1l8gXlFRu/RkUpTzjx9FdHpOF/ydTuv?=
 =?us-ascii?Q?fNAQ2G4uXaV9dV79Mey5yWj8dlDkbj1uReIzg8N4rRvvlUShFT+NKeOHlDQr?=
 =?us-ascii?Q?g41IQHdnUJEyDIncyxFn5jE2atrStSdtnrMunYCA5/DG9vflnnf+ViAKa8WR?=
 =?us-ascii?Q?8jmmWRp4fLZqgtRB06u1LnrU6WJ902IZKRzLhWSYooN6kfrwIVLpLOl+18HG?=
 =?us-ascii?Q?rADLJaDTEtuqtbx2z8U7+86jteTUMySCGCn14NOTmdXSeLHb9vDIC2jSdR3N?=
 =?us-ascii?Q?aGn9FdD+1d4NKuKERkQXuCELgu+eIga42Cp7RSa0k7HmskXCAeOObiBPpVNd?=
 =?us-ascii?Q?9lY8tWcb4073jHCFEvQ2kyioLdWggY0SZAscOigoTQJjxubBODsZSx/JlC6n?=
 =?us-ascii?Q?hx8lzogC76iyt6K87X7ILMg0QoQCGnC6MF7Cw2sV2uCM5hy7vt6jfxkX7EUC?=
 =?us-ascii?Q?pCvvva0Y5bZxFrxTxSH5NfXOSl8/1ch0rUy/H/Q44rxC+ZExmGvwZHx/KWjV?=
 =?us-ascii?Q?vBMrMXticmafv+d+gqEoEmPoY4LgLQoa1NlizDYAUnPigZDiEfs9bO44QY2g?=
 =?us-ascii?Q?eO4AJNmBvTMqxH5I9QZHehygd2FmD5/bG+LWMJgPOG4cdG7U9eka4uD9Wpjv?=
 =?us-ascii?Q?TKv1M99SHpXkX2cjTbFqO/bxCIyaEAwfY0FJZZdPhGWqvD1OD46+1Nmjpl83?=
 =?us-ascii?Q?39UQhUEoaKTQn/BLSVyn6shMUEyb7n/CtGyfqopMbhaQwoN0I6kHT61+Qerw?=
 =?us-ascii?Q?egpfCHrY3epLGFUTeEpEc4iYtediE7mBMKRDnDBLugtgMryGOgMv4YAuhEFT?=
 =?us-ascii?Q?5TzbdlpoRht7ehEqOZj8/auZwX199WA4p9u8zsVQNkXCmOc8bZFGbs0+RGJb?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bnqhD+qH9eilBil0WmQgt96xT3vpfCc/aEzUdgNud4BUq//GtNf8Of3q+HmKUrynWszv343pi/Cp2yrCc7EYUD/zWh7szMM0x2GCMVuLD739Y5CM1tF889zN9KlWLwesgM1mxihzdJ9i9CstwyvhWT4L/YuhPJALP8GflUGf0OG0poO3CV5CJcSEhiFrXFt+3UMocrdR2Uwh4xsnCG96pnVKX2X0fLHdye/2AB51HeVhM1a6Vd/T4cjkAYvPJzUrViZOr8OyZ3LoNLqMztBlPDJX/9SsDb7JSA34A/5Djz3mF5JIVJBbPe851cgArcKSFh8TG7emhOVQRwdFe8bMJZgf5t3rQQhSasecGBriVNQtwagOn8yiWU7XaAyNSWvkWevl4dU8woxoSg0ffH0vqW+0ZJKva3AIBhaKyKmEYhyv854QACEmVYXNkmk3PueOLzXvo/9IQA6fBkC+8HHUQ7ma3JxIaA1rShUSLNxLmC3Mzf+qKXrRh4kZkqcz81zANgtKhoY5kxqoSdrFL3NNi6EeMv6eFtds1BCz5/otCb+HsdVzqlje+VsrEJ0ZgljwU+8QDCQGfgjSfutL9Rp21yfMYtqdEEWvc0s4Ik5R4mw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aacbb2e-c4f6-495f-f68b-08dcc377d302
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 13:30:59.4688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mwrY16Nq+3hiNs2C711o6gsMbUdlu+4rmiw3IkMrxXF/JPb+08thgAYDZS8/oPU9joPrRrgB74eEeI/WQ9SZhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4560
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_10,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408230098
X-Proofpoint-GUID: PE3W9U3TjtGEuR_F1i06FBTwbU5-dkK4
X-Proofpoint-ORIG-GUID: PE3W9U3TjtGEuR_F1i06FBTwbU5-dkK4

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Switch the order of the checking.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/vma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Please squash this into 06/21.

diff --git a/mm/vma.c b/mm/vma.c
index 58604fe3bd03..b0c481d08612 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -719,13 +719,13 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	update_hiwater_vm(mm);
 	/* Stat accounting */
 	WRITE_ONCE(mm->total_vm, READ_ONCE(mm->total_vm) - vms->nr_pages);
-	mm->exec_vm -= vms->exec_vm;
-	mm->stack_vm -= vms->stack_vm;
-	mm->data_vm -= vms->data_vm;
 	/* Paranoid bookkeeping */
 	VM_WARN_ON(vms->exec_vm > mm->exec_vm);
 	VM_WARN_ON(vms->stack_vm > mm->stack_vm);
 	VM_WARN_ON(vms->data_vm > mm->data_vm);
+	mm->exec_vm -= vms->exec_vm;
+	mm->stack_vm -= vms->stack_vm;
+	mm->data_vm -= vms->data_vm;
 
 	/* Remove and clean up vmas */
 	mas_set(mas_detach, 0);
-- 
2.43.0


