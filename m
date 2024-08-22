Return-Path: <linux-kernel+bounces-297880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0FE95BED2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6801C2316B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7FB1D0DC4;
	Thu, 22 Aug 2024 19:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hLXbAvK3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C9mABP53"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2F81D0488
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354789; cv=fail; b=JE951rZe7CDmyx/vG1bu11cd7haJRbmTcTXYTXtYqHLOl84OdbLiKryvDry7lxZi/AGcEacY+3lcjI2ELTu5V9gUF3bdoHz/ngo7vxpm3g5xyHy0MDX+q80MvTR0FnkuKmvhpXykFwhKSSumoqL4ysAFqzDcisXnTmPONbWWTiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354789; c=relaxed/simple;
	bh=BqQz40OqzPtGsqK+chLoMHo9IBeOINIsNRURO7HunHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iP8ABkr0ppiErXVhSDYV7MGtWbpfg0UsjGOk24zoWTw3kV2tzU1GSUb5MtQsncH4hwyBFbMU3tMbNniFhAxiXeBEArCp3YA4/Atm7jMQpoX1hI4TbhdSPHA417g4zogSusCTMqvqIq6i1RvcGIrQgIz9cwk0IPqN4jMVU7aDrdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hLXbAvK3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C9mABP53; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MIMWwB019187;
	Thu, 22 Aug 2024 19:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=+SgEZNii7vamI+Wr52WRA094htKGd868kPJiAHCbwa0=; b=
	hLXbAvK3NkbS75NtQvpc6TD/FnM9BFdqq4+1JAWZJQH0jkhiwXVIDaOecLPLYnzJ
	ynVbllmPKc0+MMlbuPZVkmzmBqmr6t8PYwz3YaRyIx1qjQG2cJX2l+zosYMJdoJB
	ifP999VS1TWyexO/+YICQlSyj3+C/Al1ZgN/ObGr0d+Iy0BKXehCd7FhjzB+1j33
	b+KELZmo95B2CX8cRPGtPI5FcsD+70/brfQ/Lz3xzhwcbd4vHEaXP3r18sanRIrO
	Jq8uhLeJyf2MyWn+YpRwpG2uRFW6fBzly+5M+BWkLyQb0ditX3jJAoyfIl2eYxYC
	idm+UgMs91zd3X/FQw27LA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m45jw8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47MJJBvc028114;
	Thu, 22 Aug 2024 19:26:07 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 416bct87dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IA0zdRyndS7PQUlwnGqe/mtzqnw1aPzzkENiuCCFWjVY843nkD6FPi9b5cKpeY/3eZQhn/CohAsElQcjlOk43Zy1eX6ec2j5+kia2gl5MWaU36qg31/7P1Tuk8dBd4a7j4F6CnamcOFjAur+r/uUdIKLEyL778IQFXmncXBZ87UXjpScX/y0ypXJpZ1OzVe+Smw9BYI4g5MO68xuhxMxyjr2BgMqYSuYwWMFd9bq/878MOMCipvDJ0qRC0eYt5O03xXA3ANmikOKTnNmtUtaDFq1yKLSdkcHg2pXBuWc2ySMAbiR3UNyVwRIo4nf02ZIeWVH2XeJT2YiEqYMHaaQJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SgEZNii7vamI+Wr52WRA094htKGd868kPJiAHCbwa0=;
 b=Pl8KLi7BGF0xlZBoRsYKBk8OGckbP1CY9NZc4cudMjK8TK5aCLV0Sj+tMp5HUVCLp1G2QI5UuPJmBLlA1b5lRiv35sUgpD7MIRra8G0EZtNzYDOHZlyoqFO7ppo8vh6fv2HI1YyJEIxLibm64sNn/jhwSKRW07Pm6hRim0xnD6jVzA65HzgfySsxNRN8xg6t3xXG1rZuq3tmmbOw8Q0peOg4w+76U8Xc6krO8jogSU/nkIo3rQe998I73wYWKbfJYQJge4UTTqlvNtnsVbTpn7B6e8E4dEMijd8is5vxEVml62HQq+YMlx4Bb4DR9eN2UGrAB3KFRHkB16n/4nZFhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SgEZNii7vamI+Wr52WRA094htKGd868kPJiAHCbwa0=;
 b=C9mABP53k2wuLEAf1X+r9YKLOIG38XD0zfOvZD1c/v/uq3I0CAQVX5/RDfqBUUamc+P3Pg0KFsHq7k5WT9Wz/XMDAN3gmjm8x3m6bRsHJ7ZLJQfWxEIyb/Wqu0aV7Xy1jBPQREYGqFUgJW57/2vw461c5509SpfjfzuGPqd/UYE=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH3PR10MB7356.namprd10.prod.outlook.com (2603:10b6:610:130::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Thu, 22 Aug
 2024 19:26:05 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 19:26:05 +0000
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
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v7 01/21] mm/vma: Correctly position vma_iterator in __split_vma()
Date: Thu, 22 Aug 2024 15:25:23 -0400
Message-ID: <20240822192543.3359552-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
References: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0155.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::8) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH3PR10MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bea9c5f-499c-4dce-0f17-08dcc2e041c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nrojkfse8nWjCvRRdZXsssK3/8SXgusdz5b5kjjsOzJXsvAPMPibyWbfsmpe?=
 =?us-ascii?Q?Gr6m89Jg7T8T9PT0V8LJyouNon7RMlYVz4fQAj33Z02PSxBEevbdJ4HFz2K8?=
 =?us-ascii?Q?nTFgnE3lES1pL2IFlSN/JcBg3yuUEwVqoC3yHhZJwPOy+g5WSKlhzbDiDyMv?=
 =?us-ascii?Q?anqxKyYd6XycZORJqmOra/IdeW2BTn7BMme22s/wu5naClXROKlAeVQjbRsk?=
 =?us-ascii?Q?m1p0wOyp3Vw1d+8kzxnoOTfMHDEbYBhi46lvUznnpjvRuD+CLNiGwIOvJ8wZ?=
 =?us-ascii?Q?JIPUCfJTxgYuggRos49kFIe2U6UOBx7wAGnB3RxYeM91xPheG6X17Am4Ieq/?=
 =?us-ascii?Q?h2PpnVke9mMBYpw4T+RRjlzxon66/1o/IHhZPfqWAgBWMhvfVkjMcNS4Obtd?=
 =?us-ascii?Q?6cOHUCpCjNSGJ/L4u2ZQcX+kSYTOtDEcWzr82tAJPs1xGXgXErmjNWMieKQA?=
 =?us-ascii?Q?mREOnVuMeSmeW1gQiysBjhyxlMHfLDbdfNiu9RgZZuIdJTn/Lax3RzsMtQGg?=
 =?us-ascii?Q?fYb0NVYWJht43OELvMSmoYkvH2DsZmGvoVbMdww8cOi9ho33S212+gJbbiGG?=
 =?us-ascii?Q?vXA5a1H2JwbPPNKrmCvWxFmdrrv2lttzBuEPS6McgeIivRJc/2Z8He7BlEaU?=
 =?us-ascii?Q?DS1XP/DfwbgbURi8YcNFIBB8YyP9ifM53CER6e/bn2oWaq4MsqlLG+UC75EV?=
 =?us-ascii?Q?56Q1PuBbX1XhIAGZX9ONCLizPQT+kMQ7q4qp9/qewME/jMQS7AxtClyRNn89?=
 =?us-ascii?Q?CknRMNrCtwBdzCWM20cvA5uQI5iKk23b5KOtnMndJ6tqH8U0OLCTrFvnPhLk?=
 =?us-ascii?Q?GdOrw5DRXuAQgZkkMFrxNXR3Av3r0ZLosNEWrq/723w15BW1O9UJuaJr5RI6?=
 =?us-ascii?Q?NGve1tcvoDJvjVxmbhs3L83Ew4JSypfb7TMvMBWs5yEcVI11dc0FocXonAbC?=
 =?us-ascii?Q?M/TA5J2EocnYM2vdQIFK0JQUYppgGD/SduN71lSit55/hEOscnGgUaJXJBun?=
 =?us-ascii?Q?bzKVg7+ZaCOh7tYgf7Etp8Gr1W1E6TMUmJ5Ob0wxSMMRFIr4E5jz09pEOAOq?=
 =?us-ascii?Q?XUf7UkCszE6M4wRq1axFiwNIcsKZQwNCLAfRBUYpw2Q62Y7g670wyauLG2bD?=
 =?us-ascii?Q?ryJGS9NF8VlFuQshYykdauNddt6JLRlJUzrT/de8Nozk18cvAOVSMTp7icpU?=
 =?us-ascii?Q?zxR7DOEGo1BFflhyuXTYaVXdUqGDiNGqalxGrk3O/5Vv++vnNKpRuJZg9lI4?=
 =?us-ascii?Q?9bdGJcTjKLAAtYOx6crmJGFmnEj15hs4fsnp9qUVUhCHIwX4yQdVoodoiVcw?=
 =?us-ascii?Q?Yob6leDur5hLhhNkBTwYUlOj9hVPrkYzpgz5tRFCJVxS1g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z9ebnDYdFG2a88J8qCAsaGDqcYkuHw4eeUWqdiF0gFO5NZZj4zv368krdcCE?=
 =?us-ascii?Q?nO4e0XDUiFwe5FAQbw1zsr3iiAEMtfKIYFgdrT7b9YhwmKkqagX7mZRh3LrP?=
 =?us-ascii?Q?k3pHLAbPkXrNdzF+P2RUa90kfqZ/7PgSDMlmDq+OHIrZfqPmX7aamoUTXXsh?=
 =?us-ascii?Q?eQqwIctd7B21OCf1m7oBA/nl2aGoFqE7mdiJEa8FFiUotczUzt24GvstEvL7?=
 =?us-ascii?Q?791Zb3oU3bLUKlGT8RCp/5PuQny65yeULAPgqCnO/AFWNCnecD5+5O7D7bxr?=
 =?us-ascii?Q?RdLb03tsOqpZIY1VBFA0u41vlC4zS2VBXIEzIQXe5DJg851EztEOpHFEY8r7?=
 =?us-ascii?Q?Eu8TcER7O7wOAGR/d7c7mcQ00djf73imT/AORi2RFcZOP0TsmKVrqKVYAzHR?=
 =?us-ascii?Q?7a7JHE9i09/cazOtuNQaE66g836x0ttQppdCtrlO1Z0Pq0onSJj74xQQxbLm?=
 =?us-ascii?Q?30vMXprzJKqAMOSqppCIw2nOiLDhq/KihCHsNXKQnhTNSIWDyHb3SRjMDQEm?=
 =?us-ascii?Q?Qm7zzubxxUx2ZeSVTSMOBQyPVI21MqGMIE8iEfkyz3x5apM631dgpQodPhJJ?=
 =?us-ascii?Q?0gAkgTYgHVKU4A7/4WM+28h0eA4ARNN/oIUAUyYj4mYZ6drzTixvR0aO6V3X?=
 =?us-ascii?Q?FkY97RX1zAKqgTGa5xg7INaF2d5GBmBkqD5LGOFiWeiK5AsFdilWcgljzJNJ?=
 =?us-ascii?Q?YZeJGm+05hTyDt5Ih2n+6kSOG+gFLUb8fxWFxi0uPWfabpqvJy59bOqGn0O1?=
 =?us-ascii?Q?swBf/KfgEn7o6xTZVMTIdyP7gO1oG+KQU62pPtGyfJTq7mkwY7hHn/NbJCVs?=
 =?us-ascii?Q?arqgJxkjkJr+ZDclO+ZlUItR9Lsp6FcE1WlwBIYsbZ2zxgAfu13UmidquMQc?=
 =?us-ascii?Q?sYuLmpepOLX0aA3RzJ6OpWpjU0ZKO8YKHCXqWPkrr3N8u3+/DE0FkNjkDJ3I?=
 =?us-ascii?Q?A2L1o+a1Wj9TXdCO/A6XoNt0uKjk8CJQExKM7RGullMsaQe2xsPuesAe2h0+?=
 =?us-ascii?Q?oWoI3//za3SW8GUb+oRzDLqGjaBwaOqZiyjAyOwfAoaSPag0Qe/18G5LxzXH?=
 =?us-ascii?Q?yfABzCcZFxVWqf008a0iRlk3QBqxMhVK5nKLr/TS0cUlgdOSmWoA0DGZzeIG?=
 =?us-ascii?Q?s1lNgeBLXYwFpr7ptvXfjirGRHx/BTcuHyWjmy1Eq4a08wTAEU/RXQVr/PFr?=
 =?us-ascii?Q?W5rdGbL0dLzaCJYLKfKQWvV4p7UM+axLLHTi1vqC/LnpsBmWB1NyLJSSazdW?=
 =?us-ascii?Q?pZz4KfcepG5JvpUO0oteBie9x9HVofGzBvHc1SFWeTz+uqeETik4lw42AHD8?=
 =?us-ascii?Q?VNbjPHMBjQT3rZVPK745MVYxD+kAK1E9hK2d/7Eedw+WjXPwx+7U5/6UIL7g?=
 =?us-ascii?Q?WCxge4hTP2KG/qhh+o0YZZ1RnRkVyYXuPRZnegMEzQekzhvc1+nOmEFnh9Mm?=
 =?us-ascii?Q?DmKgyaQOCVQNC7djEDhIpDRZ7Sjar3PJyH5dHTrvUoGtQd3UwPDeudrCaQ1M?=
 =?us-ascii?Q?hApwKZevMW9L6OuhocarTAvr+o5WR32EBPVSz1ZX6hB2CbKcqFcjB+YkHIMC?=
 =?us-ascii?Q?yCNUSqbnt2VcwablIhi9hEKcqvUBFMO0zRfL02LCfe1FlNX9MqEgWQjqOQnJ?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+qh3KrdtlvkJW/kb4UCEdgADbMkDE/+PSQMLDCYCNmweVj3cFcpHZ5bfosMBh18bqjKwxHw6UarDI6CylinpQNThAwbf7TffdXs950+++NtWFhW04C6VQ+7kvyb4beNrQlZm8PqHCLBJ7LQkepnV1Ym9WgF5vBtoqljwM7WNqTDWbjSoarBoZE9GWiGbu0MyavUDPM2Xuy52DlXJUJ9CxNKuQjrx7zZSmGb3OQcw4VzEikPkAJnBDleoQqPXMJdLT490yQ8Tc18Me6/p0lB68qoxBvpq9eONJalNrkWK+yEyEcKOP2p+zI7cywKW6lpIYbb55anr3c8rApUkVCk8sSzqAQFEjExUKKbOSs7ZrT7GofYGA/Tlr5nh4Umal9EdB/+wHz03tItlMnNubg4iXICWQsX5qQNaPFZm1AQp7wHD8kULwvDjm2BuGTe7MnADgzquTZzLOVFT4SGo7QZ7hLQ1sbqSN2Ksgthyz0mq8pPi+n4QzEplFhcV8nJmCs2apwdqyZVBXCF+g4U3AI+ihcuO3JpDWPKh9uDr6kTE5gQrQaxV6G4PTnVKij4Tqeb640omU4iFyyOj3b1q/pViWi52ctPCErPxWKX0MYbKu/8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bea9c5f-499c-4dce-0f17-08dcc2e041c1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 19:26:02.5333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19c+xLbuu8cD8IvYxsyXaN5sp2Ej6TAUG/Imqk/Z6/qSM6zudNhgIvTddtJfX8cItOBQ4/KY4TjAMULEBAM4SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_12,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408220146
X-Proofpoint-ORIG-GUID: PM4w9XTmSZB4njjbw5GPv7D9Scax0FBb
X-Proofpoint-GUID: PM4w9XTmSZB4njjbw5GPv7D9Scax0FBb

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The vma iterator may be left pointing to the newly created vma.  This
happens when inserting the new vma at the end of the old vma
(!new_below).

The incorrect position in the vma iterator is not exposed currently
since the vma iterator is repositioned in the munmap path and is not
reused in any of the other paths.

This has limited impact in the current code, but is required for future
changes.

Fixes: b2b3b886738f ("mm: don't use __vma_adjust() in __split_vma()")
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/vma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/vma.c b/mm/vma.c
index 5850f7c0949b..066de79b7b73 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -177,7 +177,7 @@ void unmap_region(struct mm_struct *mm, struct ma_state *mas,
 /*
  * __split_vma() bypasses sysctl_max_map_count checking.  We use this where it
  * has already been checked or doesn't make sense to fail.
- * VMA Iterator will point to the end VMA.
+ * VMA Iterator will point to the original VMA.
  */
 static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		       unsigned long addr, int new_below)
@@ -246,6 +246,9 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	/* Success. */
 	if (new_below)
 		vma_next(vmi);
+	else
+		vma_prev(vmi);
+
 	return 0;
 
 out_free_mpol:
-- 
2.43.0


