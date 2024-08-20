Return-Path: <linux-kernel+bounces-294701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 871A5959174
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 01:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 097481F25FA6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 23:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545E11CB31A;
	Tue, 20 Aug 2024 23:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oAHegXJw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UtdD9rDr"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A851C9DCE
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 23:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724198302; cv=fail; b=AeHrndvOPXlW44MOackBlS/4a9ejkvWcc19AnsJixZcd4FmsdjTqrUjMUdTQ73Xmj4WdYtXcn5aYwRjF3NH+rPyemPmKol9uO3xvHM2Vq9blUYcJA0VXjYjlDElSGDVgGMLI8jObxnf5nb8QFe7EE+Kyx9h1NLoZbpemLG6kn0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724198302; c=relaxed/simple;
	bh=DgWFhbve7GQEtt2QOvedaFOnGQgo9qcJHP0GOjHSNic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IyjUev4ZbqLWhH7csLC+0TLtFlunTj6nEuUb2y3cyP65fGCMGeE9Pm0voe3zn10Hrb/R+FyTG8rl1CeTnwE/764Ru2VxTaaJTwiXaJ61PYZkvRZXMrYCBD3DgOcNTzSiK7GJyV/aSvYrYEYC5xWxnRlfMNttAYvpMfxfqvovAwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oAHegXJw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UtdD9rDr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KMBXE4005239;
	Tue, 20 Aug 2024 23:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=PDNDdIK+17zRq4WUoWjBIpOtq1SQCKc3/dZCfu/MLyo=; b=
	oAHegXJwpixOVzpL1KfcNL3FPCFLegTqsd2AHfzv17sfC/tlBKI6r64uf5YYMIuD
	epFqqBCRl9riX0OZWwkcWT7THClpDM6sbY1Ha/vRo+8N0BMeC9VquN2jhInOVlxN
	o2sq71VyaCkgQsDtxeD2oMi5cF+dPJTf93EuwOVzzy5sfkVohJ3isB3zKAFvscAn
	dbemQzjvXzBMZIQaKOj4J+u7wwp+z/KC789k8RASrVhWx75tDR+SI0rTJJqKQZ4C
	qLEZ9+M0WSp4nLmwhSBkZahBkOkKV1bQxef4uM9zcwDfCJLv0F13ZY70xnS3iVqH
	exN/RbjDQqEwa1C+CX3AZg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 414yrj0mm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:58:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47KMJJkH040123;
	Tue, 20 Aug 2024 23:58:06 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4153u2tbef-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:58:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aAcQaTJKyGRekAC186wA2b6DXWrmx9RdwkMhoSAfIIIC0jRIyC2k0uRRABxdhMd8c7ZR6dnZT/lV0CATFbQKN1wJCGw9TI30Yopqh8HNrxTd0eLfLTkZ5BST6PmSMvW7zVYN9vwws5s+Sx6UdrrDwI/UYpxMzlOPsRHG7kmsPuhZ1BBkvIe4WaZA2RUa1vog91RcWnGhCObFRiXNaBj62MwcDar29ObshjpeH+6SY0bzRI0XYNcJaTlrumX1t0YPJxN/K7kVTwsyFt329bbT9kBJulV2EWeRqZtxPQ/nNGehC/ZTL+LpmvFB5XTlPh/4Vg+gjiTbpBKtSQUFFvQWLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDNDdIK+17zRq4WUoWjBIpOtq1SQCKc3/dZCfu/MLyo=;
 b=xXhLpbJEJE78RFANFoNvWM9o/l9lPkMGhbmKWcN/udfVsvYWTsGl1qKjcWQb9cvBcjMUmQBfBC66pNZdhsVksW+6k/efPTR5DgOXYO9sMxdqKbkli43IRICETudiny74QgDEY7dsI/5MY0tb8kHb5Ksvy1gwRczZx+HP9XfY+BIy6qOVSxCcEswBxOvHouvqJRidjo6aEiL/1qzM+0+GNP4XPikXXFqKJGRJU4YrcZ1Fa3LS51CSNJmFUiil2zePlO9kaWTLNUCcVXTJZQugjyJ6Ihaks9CYMsnTT4r6IMD2SH3M0ow1Lx/gzgghjaglwoI3dgWZgdcBy4P+JapZzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDNDdIK+17zRq4WUoWjBIpOtq1SQCKc3/dZCfu/MLyo=;
 b=UtdD9rDrlEpXnv93zcUNz71neSFeWfOzf7Bzjhjyz6o4HWeet2n9WhpwXKHMhyiJ0Egp7Q9GrvnsjUzNYiXp1kXY7K9Iug9vkbGa8upN82IY+qpefDf0CP6KjJmCDJuOUL4RkLH4erZe/HY6x5ppq1Jxk8lNEk/+ecKM7tX+heg=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB7099.namprd10.prod.outlook.com (2603:10b6:510:26d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Tue, 20 Aug
 2024 23:58:00 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.010; Tue, 20 Aug 2024
 23:58:00 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v6 07/20] mm/vma: Extract validate_mm() from vma_complete()
Date: Tue, 20 Aug 2024 19:57:16 -0400
Message-ID: <20240820235730.2852400-8-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
References: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::27) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: 14471e0c-be93-4fca-85ff-08dcc173ec1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1M/5NT1fSs2l5WxbOYqVaJ7DoCP4Hm5q2H3AMcAkLJOohup91HUGazI9Qpib?=
 =?us-ascii?Q?U5ddw/OOMGTM0f4xD0xFHtmxLmV0TdiETt8Y776WwZlUkgGmh9umlZ/6Hy9p?=
 =?us-ascii?Q?VdMnI64lqE9jrqZDs54uRAjVHbULLtoUZXB8xNKQAP6/xyc9RsHHxgP4tp2g?=
 =?us-ascii?Q?lCXdKQvUNKH1M/nF/ulmKJRCx52GNAN0sd9ksuHfwqiu38hIaoRvGs72afJg?=
 =?us-ascii?Q?Umqcxvpl3le1rnU2FCG7KOOwEM8oVB0eweCFRd6xCITJWUzlpGTmYyABQW89?=
 =?us-ascii?Q?ex3jRewjq/C7LcQXmvVPUF0Yk5hVOThjlubN2MIx0hWUx8JFohmV3ytO4E47?=
 =?us-ascii?Q?7XhNL4+YhW8N1p/CYlkFUnv4+aWEI9lzfI8zz+XBeB6uZiNL+CUE2ANyPbYx?=
 =?us-ascii?Q?7bIT6ZiGw0MvFK6tB8HDifmqGq7JMZ5TS+MGU2NmNdY/PfBkiSiCWKBZCBWA?=
 =?us-ascii?Q?qrjpxbJ3V8a0nQoHUSz52nHlxa6VcMdfSb3i/LAL8xj2nCm2GMUoAgAz8Y2S?=
 =?us-ascii?Q?6gdnjmzMDh+VzjxdlvS15ZvUmEnVNsaDHQ1njglIYflxMjXPXhLpmQdEER8H?=
 =?us-ascii?Q?meI96IrS0zC04OeHCePZEl7uQjZe71BK+Wik4ZRmlh9TJ24RZJP1Mzp9yvUh?=
 =?us-ascii?Q?1sgEi/RUEN/9c0ceeW7X7HCHBNmlp7heuZXMGg/aYT2iQRML8qKZDfLE05PN?=
 =?us-ascii?Q?upLaxfX72r4pzQXx6UnVDLj23LgNFBw/NDcQJX03nSTWKNbEpdrQB376BzC0?=
 =?us-ascii?Q?9cHVgpmPDb+XZJAB5r9v+QIKNjylOoiraJ+NqSBqm1KfDQPgRBwhTVdF2Ohw?=
 =?us-ascii?Q?A0/8e5LCXTqWdP6h+OtrBYxLxljCnAPWh/JAFEb3PCNgMi3pxt3kbKHOLOpj?=
 =?us-ascii?Q?H+kZkUuqP4xM/3noCo0qEmUvx/+jaVLwQ/3WLDlQw1KhwQNmNEGXIvRAmKxV?=
 =?us-ascii?Q?nhIY1WnNNK3D/jf2ZC+0PDZBQ8YhgbM3oWswVj5H+LdF1Zm6MsiMMQYB+zef?=
 =?us-ascii?Q?IUgaORHKJPQaeZ94nbvjEpP5Bf74W6vXCqRD437azZCYqZ0LoKCZgxR0lXcY?=
 =?us-ascii?Q?LDrE1IVQYIHNalc0B+/L5zYnm9b2Bbk0fW10hzFUqyfz0B7YobBX6NbZ1fzK?=
 =?us-ascii?Q?GCDbpc4JJG4/D4j9C2/qZ6aUfE0ABmgGAOW2Cr7lJP21vnWJOW1HT55c3ZzF?=
 =?us-ascii?Q?1z6JWFiLdz6nAwazsL/cNI+x5TDYeSZFPUmjE1HBA9T0SP+yzt7wHzQRYGWP?=
 =?us-ascii?Q?ZHj21qj84UR/peBH9L3QnEO97L/PullAkUj3BRs/VG693xZeyBKjmKWLlbtR?=
 =?us-ascii?Q?B6HlvKJ5XqTJnh+hyhpov23P8SN1p9NnZm/CoQAVKJqd0A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?016ydFlcY+oh70lQV8q/32rVsHSSkN+6Nljzm0P/RqBTt3Ud7QCQoQyk4pnb?=
 =?us-ascii?Q?P+CxpXQVIUZpQpL7+Ix88PJtv4Xmyk5UWGhcZKcbwHjghloArb6ICjxYEb3A?=
 =?us-ascii?Q?NboJbrZ01FiLnYtq2/78//0IKSi+cpaF548/fCoIaMyiSigmLg48HX0i3ozy?=
 =?us-ascii?Q?Do6npHpitxAOO2i2FmwQMY3snKxX3L/jzOkAFNLMaEvgpMIlElKlJIlqhcNq?=
 =?us-ascii?Q?T6ZnbvdFMZZrAmPe+t5YGEJhWNa1MSES4mKLSvvPznvegSjF5QjITYS2vl+u?=
 =?us-ascii?Q?qHhYLahLFpBgtL+8op0Kzyi4GW86TbvnFi0aKtnI+2MbCL56L1H/a3gRXGX4?=
 =?us-ascii?Q?hlIcG2I1xwEx9C4roHGJawmDmp4cfu7ILPkMF+20GZxFNDiHWifxc8AaeUcu?=
 =?us-ascii?Q?IkrDS9GVnDuINDmchWvcdKHdlzU0og/KeezWJziZP2vt9SHacJqDH+c6eueF?=
 =?us-ascii?Q?vuq2IPuT8PCE1VWh/CLXvTsXcrosK0prXzs7YNZb6qGj/0KwbqwXU2Js9K2l?=
 =?us-ascii?Q?/Dh5cA45utr6yngIrbhYdVDyIJneg5Uoyf5Cl6WTcsd5+CIUpm/c7BglANDC?=
 =?us-ascii?Q?vmJZFFyFWSA/JAc4v/+WFXHwbois18N5KOECLt3iCHVPCbpyh/ztePU4pgXn?=
 =?us-ascii?Q?2vCfNMa6K8w2dvjFoTeR2xXsFMHyBERwITFRY3PYfqTKrEsAD4DR4ZZ77ZTB?=
 =?us-ascii?Q?ZBU34KTU+PHhoPl+IkZr6ZilrdopE9agGEam0LXO8+mIq7r/NcpzieYaRvKa?=
 =?us-ascii?Q?h9jxkpqv3HQcqshEigRpXs84LNgznCwo/ukp6E5Jvh8vyEDHhND5AW9IRini?=
 =?us-ascii?Q?03uEJvVtIYTZqaBmdBpM5b6Jkuhoyr4Nc+cGnTGZr6gDY8jFwb/uSFo7Ibtw?=
 =?us-ascii?Q?kQPEV5H7igSuWtIZU000hTTQoaQiff6ka0oJThwN5zFtWarMXPESoMHlFKx/?=
 =?us-ascii?Q?6uZ38RRF+2aODOmyABhkvQ6HjS5Jbc6bxeRb4fl/xh2HCD/Dj42zcdUcI85T?=
 =?us-ascii?Q?YjxkK/e8zpCYjed0tkPBiDdbRVoD4pkkgHhbp2XTabGkmZWN7N4rBdJqgH09?=
 =?us-ascii?Q?0J++iNpwjqmFctY6rCZr7o+j5IBwdX9ZKf7R2UADXkakAEh6h0dDucBKmu/S?=
 =?us-ascii?Q?N7pRik8DbeomDkEAczVl5YyF9iXQl0qrQHav2xZDXPERmHLcYXNG8k7FRvC+?=
 =?us-ascii?Q?8WSDDO83SZFWrNW6Aa2rfXN8D6Q+BEXuos33BrpjmaShdlR9Ecexb2EQdTti?=
 =?us-ascii?Q?Sq2OkfUQalAk6lX3pYg0faN8xa0FVnpBZZ8w3goBPJQCn7lSXDJdn2DdHB5N?=
 =?us-ascii?Q?bzG07FgdquBtx0iUS1rqJfRhjptlgChr2BVXUDN6LoaIjqtQzD777HMIYbfD?=
 =?us-ascii?Q?2JwzlzwP1uSFRgJrZN3/AdDZmJqmmcxpQHXCH0ekkcMQl2LzgySlLeovjRO4?=
 =?us-ascii?Q?lG6lmX01rEhdNmq31tFXBCzST3azgsa5lIN/JonQA2YH4Chb4t+7apD4KmaN?=
 =?us-ascii?Q?jerjCgxKF4T1uM+x+kBXiYG60Gvhbxe17T5f8yj+IOI+210bNDgCFUTCDq/X?=
 =?us-ascii?Q?SKv5N9AZfBG3pOQwIqrbwZI+RVZyNmgwzSErUH0Tqp1aYUsxkDA3fFjt2XAY?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PzjRa6om05bV8PXdTaciahrAJxCsRCI6ZuPAmlK+tjuh9zc0EZhkoKIF8/T1PUeRXwO7vwHRE5cg+wvOzXrHYtXRER1iJCzlFfped4XPc5NWZqc8Q59dIzCbMEl/SPh6RaXByJHMJGcXkYJ4lx6SlPX9YMJwH3epdIRbrpHGYfQFl7g2AClaUlyKLs7n/TO1nJpy94B1mCE5DF2MQ/APR4PeweL5wb3WF01G+X0z3gCBJMtnfezRiIOZRQEB4rMs+sC4I4shKZqnKIGLcqZ0+R59q7//E0jsynLdhP+6b99WbBjp2ehIFiyCMtXH8YmL1u3fPpqJ1rUqqX/Fgc+pZaqOeQaJrCUH0L7/Cg4IdvzGDRmPeTva2jxAQId2OzH68kJVfJFMM4JwVE3N5SxhAvfOiFScoRhoce49KokmTbNqXU2bqlAQPr8yS50B6J0up3MIFMPf4Gf6rNpL9PS32XlcMA9PAJ1Tis8HaaGAFhUNxemZ9LeK6J2yqVnV95BU5YE8IRI6henluPg1ZFUF+IYV++a+fqS1wJCY+PHlPJgHDZ+Xg44FgiYbNgA/6SX0P/E4UMpO0KlFKyCoUJ1mvZJXrLFJJ/xKIweUYs3rUJY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14471e0c-be93-4fca-85ff-08dcc173ec1a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 23:58:00.7372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WYDfolKE0YHZmCl/CioxMJH05L+34pWdkh9dW1UDhdnrT2VUxeeWa/Me/8+JF3+qYdlRGfMyQKS+SAiN071RfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_18,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408200176
X-Proofpoint-ORIG-GUID: CEVl1PdElzELRSizlCLErMBnW45nL31O
X-Proofpoint-GUID: CEVl1PdElzELRSizlCLErMBnW45nL31O

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

vma_complete() will need to be called during an unsafe time to call
validate_mm().  Extract the call in all places now so that only one
location can be modified in the next change.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 1 +
 mm/vma.c  | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 30ae4cb5cec9..112f2111c457 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1796,6 +1796,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		vma_iter_store(vmi, vma);
 
 		vma_complete(&vp, vmi, mm);
+		validate_mm(mm);
 		khugepaged_enter_vma(vma, flags);
 		goto out;
 	}
diff --git a/mm/vma.c b/mm/vma.c
index 7b8b8b983399..5abda4c49c83 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -269,6 +269,7 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 	/* vma_complete stores the new vma */
 	vma_complete(&vp, vmi, vma->vm_mm);
+	validate_mm(vma->vm_mm);
 
 	/* Success. */
 	if (new_below)
@@ -548,6 +549,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma_iter_store(vmi, vma);
 
 	vma_complete(&vp, vmi, vma->vm_mm);
+	validate_mm(vma->vm_mm);
 	return 0;
 
 nomem:
@@ -589,6 +591,7 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma_iter_clear(vmi);
 	vma_set_range(vma, start, end, pgoff);
 	vma_complete(&vp, vmi, vma->vm_mm);
+	validate_mm(vma->vm_mm);
 	return 0;
 }
 
@@ -668,7 +671,6 @@ void vma_complete(struct vma_prepare *vp,
 	}
 	if (vp->insert && vp->file)
 		uprobe_mmap(vp->insert);
-	validate_mm(mm);
 }
 
 /*
@@ -1200,6 +1202,7 @@ static struct vm_area_struct
 	}
 
 	vma_complete(&vp, vmi, mm);
+	validate_mm(mm);
 	khugepaged_enter_vma(res, vm_flags);
 	return res;
 
-- 
2.43.0


