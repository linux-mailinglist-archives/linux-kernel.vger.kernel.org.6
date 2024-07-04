Return-Path: <linux-kernel+bounces-241692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A192927DFF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 21:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A9428564C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394CF13CA99;
	Thu,  4 Jul 2024 19:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rp0hBGLg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g00cQQ/0"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E7149651
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 19:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720122702; cv=fail; b=tEoFN2+A7Q9z6aBHkhB7v+s6W85n0rV9PISAsyLgO0atZiNUaLAiNLK60m5ZZox6sgFBw5xFFjNXWyE/SbepGYA6WRJiCtav50a8+/Ptsqza+HAMEcV27hLHLxXm/pR61T1bKuJpf11fHpCgJYFyqLSkKl7R23e8Qh93ugkk6R0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720122702; c=relaxed/simple;
	bh=12pxhC/DkUR6+FxwsbIlaRs+Y07xn/yB+ya8opPIXtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LxQsTi4vmJs7qYbbpBODNVfqHFyxlLLjW0IZd2zcyfpnYImTydDkc6rO2UkjHKxdZCgzXuhM0+2l82pQxCPISRjxWZpXb9Ctba4Nq/5wlDVaj4m9B9wnovHbswpPy3s+V48wSHhg4WBeYpLLG5qxkJebEQU6t+wI3QCHP+ZBjDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rp0hBGLg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g00cQQ/0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464DH5Xl012539;
	Thu, 4 Jul 2024 18:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=1DoxtPb5EdsWVu0FMLjwtMRXKfWWaZ02jMrwbY8xjCg=; b=
	Rp0hBGLg3zk/3uWnFbcJQ9n8SYmYxBgpB1lHwTHgcDZEH8PZe2b4I2Y5P++4aF89
	tFFX++ADd0TgCVcqypfO8SCYCuj3+QCDq8ouOGDmJdk4u9gSL73RlVjzrgQh9wXF
	DCWB1VZpVjFeE+f8srB/DhtAPlppODaEdi7M/e/DdFhtywMwAbciDGr+bZNmdWlv
	3jaBpt677YUuQVGgZMcumwQKoo6jef/IQeHG6MWObiiSv/fKLr7omfOvM8faiL5U
	hhuLOSFRxXbfjOZS478x18RsDsNnpkedu19aGi3AYBmuco+KK2Y7J02vnYPgafil
	7O9+oTqZGIEhci4ViqLRnw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4029232pdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 18:27:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 464G46hx035991;
	Thu, 4 Jul 2024 18:27:42 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qacukd-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 18:27:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doZtJoiWDdvJGEBpz7J4Qqeen59EVhbNZZWcS/g/VMNo7GyxvtbKcZwO4UEiKzSn0Qfstt1dk3qbw5LIFoR4/6lFuDIclybma/7LPUK2CpNwAnHFj5jbZlrhexmHGUDRlobrcJI9UxEREdElNICczXYsVEfwEbCG6qYBIJzpv+RifpXGkleOYzisj7+thAslkR+SVP1/ED6w4Qd6SSBQ5WUqvXwOakHUZ0Uw4lkccouy2qjaWayN9y7vKA/0aPy5zMt/vi6Q6yRTSLjWDAm3BlxLq9j0dImiBD9xLNwsmrHvIDYvGkeq8D4vw20vcxnbOee82xHLT96B/plsrflLzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DoxtPb5EdsWVu0FMLjwtMRXKfWWaZ02jMrwbY8xjCg=;
 b=WeFcIufyi0J73iChWMTX2b6Hhd1XudSu38CiGadzc9VuvSDiQZE0uchKHN+fS5//BFVcqIrzFLIYzV9bAsPutLdz1ZrqVQQj48K4P8NQcfazVWdd7dbXLxUMrNkBeg/EvYCwZjLvNiEybdxQNJ1CaKE6XvUFnpEpq8/ioPQQ3fxxQNeOCHV4eMXqM5+XerTLmU9j7CjXg4I+yxwxBxT90rv0VZbLY4mpnWwV8/JeJ+dCjgRE0gOHb6f++Xn/1a7u1bjNgGyzK1UuD/APXp9Pcntj39R9GFpLB5tlnmvW7q0gprSWW2wX2/zdARSRuMC3C2p5z/3KNphQTkkye0KWVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DoxtPb5EdsWVu0FMLjwtMRXKfWWaZ02jMrwbY8xjCg=;
 b=g00cQQ/0N1xgsOx0/rTm68aI9wiQiwL5dG3A597OLWiFlhFIL8MOpSfkdVZn8mxAuZhK+/y8UzeYwCg3bu8Fx4Go2uycb/UocWVAT69AjpLbmyNdy33rPm7Orv8biNWt11VkkKUh2HvY3oLhWxXrIUhTSsmaeufF2cQGYMafuFU=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BY5PR10MB4242.namprd10.prod.outlook.com (2603:10b6:a03:20d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 18:27:40 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 18:27:40 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v3 08/16] mm/mmap: Inline munmap operation in mmap_region()
Date: Thu,  4 Jul 2024 14:27:10 -0400
Message-ID: <20240704182718.2653918-9-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::16) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BY5PR10MB4242:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f76fd1-b360-4a49-40d5-08dc9c56fc41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?YkL44PWwuzboSw1pzDqTG0xHI2Ntu7lxP2ECLqgRO+44oDLenjAwrD1L29QD?=
 =?us-ascii?Q?rZYKsfM2lATZok/SroLSalraFtAu7VZemddmKuPIp3QiHfgx6LGC6hV5qaB4?=
 =?us-ascii?Q?KjesWjhzm8KKVNrMbDv0hq8jjn2GwMKW9euygxgARpiKX5GKvKR4NuAzL+ai?=
 =?us-ascii?Q?tMtzr3+Paonee3aLqY7465/XvhS3Pz2W3byG7Zut7XFGdsJBKMIFXPso2S6I?=
 =?us-ascii?Q?tB4kYj46pbrWuLQEPaRea91Bhk434x09akiaBrkQW1fWOgrTr5fZVgvBvc7Q?=
 =?us-ascii?Q?KgGbFYP7IOT4YbwWKFBO0bC8iSlYytjLnX8aNzEEL3cnWi1kq5f/60Aiudxb?=
 =?us-ascii?Q?EDPs6dbWBYt7ZRx1LFc5Fz/9ycbX5j7FUrX3UtStW+9jxx7SjaTW950Swk+y?=
 =?us-ascii?Q?c9op6WQzUTYneAfVhq6OwA9xdRshqU949CBhi2kbGzCUHN7cfS0P7u3uupS5?=
 =?us-ascii?Q?wzDqeVkdbfgjS0jifIrHNgVsEXes3aZcwkaoMJoUbzG9tgUXq+8tQBgYucop?=
 =?us-ascii?Q?FGNtjpT2UpnolRxGwDGpzka5t520d2mD0BSVc9DWeMLFIWmBbPtjPLhgLKr8?=
 =?us-ascii?Q?KvptpkHkz6YChAwR487C6X7l/v7yl8TK2M1h043Giu7Y61nBb+GPApOUbILr?=
 =?us-ascii?Q?3q3b9wjQtKSQPJ5sbVZE2GW12fME/+DBCMfNSpS7TXKxt0ZCsu3/Lk970O0W?=
 =?us-ascii?Q?IjVQUK38ZjpaItLoWgUMeAsFKC3SfTdT2o2E8Py4UsnwoAVhXDpv9woX45/g?=
 =?us-ascii?Q?+eYrkYhDK5y0vm4soexfuPrULEQu51l+dp1/l37dFk7inQFMY8K8qsC9Oyd1?=
 =?us-ascii?Q?5GNfOHFbhNuqM0B1svulPTWS9LOsy3YwAGWx+06MPdG4Rwpp8B+T5uNegoEq?=
 =?us-ascii?Q?suCDXIIl7krmDTTii9nz6Jj42FVEjBjzQ2dl9hxXoRsDpxofBtOgJ7G+P+h0?=
 =?us-ascii?Q?ZySyQfs1lN1/zH6G91tWvU14VZgpS1iRlEZBZUPaKB1E8BxL5kKfUzzHssMx?=
 =?us-ascii?Q?tSTEwSQjDp438EoXBQb4SFD2QppmSsvhHPEydjVkGqSkevgjIse/n+fHWKRU?=
 =?us-ascii?Q?G2EwXbSURAwUkuMs7gr1/b+9CeiwGX0OfLE3af+DpgnO+THXJzJfuB3QB/6x?=
 =?us-ascii?Q?M7ND4eCm6Jou/gMUiU/g7RBrxYR0Do6REUutbYIzj9tQGk0zVUvaAdkVUTRF?=
 =?us-ascii?Q?nF2jJVnuChWpeinC4jCXUqd8SIxurJrMA0sYdcsqeA5tFtGUd0+WTIP5o+95?=
 =?us-ascii?Q?7qZX0RtbEFkzllg0huFKr1+GeLxA7orbZDFGSnyKNOqX9TdBM4mucZSoRyVW?=
 =?us-ascii?Q?c/6nJGytwmqPLWHYr2tQmyz8CAFqSoMMbrpw9yzkPlOVOw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+3b8MuH6coAjH6Llma83TMbtVUKZt48LlwqnlFdfKjFqctsdsqQHXtYPa23j?=
 =?us-ascii?Q?OXrZThjdrSr4cCJwgFQ1Xt1uHbqY6GL8Bup7Baad+FN8lQubenM+DOK6eRYA?=
 =?us-ascii?Q?d1sSjEHEWI/RlJQHYYgMuqAMcZNvlpaxd8fTvFNjFJrZKKW6+E3QvrJ+NSML?=
 =?us-ascii?Q?cuumEgnobObAeC+DAU02EvewA62oWB2XgoiQw2+PkxhhOpGnXqobd2844Umo?=
 =?us-ascii?Q?ceaP2lVEGvfRMsquoggXOGoEBDxih35kTWLiS2nlGHZt5OMfAylHZePdOtWG?=
 =?us-ascii?Q?VzxpzlGs4fllZWx8HL3IjdffQyq9yNmF58N5mgWSJIG2cxQ4kIop9pjGee6I?=
 =?us-ascii?Q?wJ6qxhST8ZFiRnGsfp8zGVxGuvsUO3aK7F8EuJfZoRCC6fEm2UEHCLkG//OG?=
 =?us-ascii?Q?dmQN80BES/10hQT7hvqgKYamQi78J4jL7z/ZccRjutDMHMomVjIbLViAxPDN?=
 =?us-ascii?Q?PJP8FOxEeY6RbbXToAnDGhDAgLroeDb1earbWPt5KaKHmZBRYvK3K+tjMuAI?=
 =?us-ascii?Q?k+Mkl0BrBPDeRjumRmIpZ0+WBW9ubRUa44ZqnNXX4U62oqYN7TkiBbJDeVDO?=
 =?us-ascii?Q?UBXq2s2NUF/85NJVWisNRgpnY+tl7ANKhG5OlIgeOWJSLK5BJTUxB8/TsK8R?=
 =?us-ascii?Q?elCfSFYGyzX3tpKkGQUxKJvRl5ziRrc6xzRq8bbcaczI1g2iFrRZtYKAtcYg?=
 =?us-ascii?Q?Lw9sRQIyZBHE85BF/hncGzmEaKGKmwR+GhUKt6igtO7uS9ZMC75GzRTLb4QU?=
 =?us-ascii?Q?QCa5lggf5O678+kFWpgqyqeKSN5bLka/IimBdXcvc5G4FmjOodRv1soy8maV?=
 =?us-ascii?Q?gQPhgxuiswwiSETaiNNJMeWVD1560q8h258m3g9tGDpm+t5s0nxR5/gHRtoY?=
 =?us-ascii?Q?vQNniwzhDFmMWMFNI0qM+9bOm+a7X80NLmRC2FA1fv6+mHkxrPhUXTym++jM?=
 =?us-ascii?Q?xydRhoUHIDTRn5lzOPRChxIFSu79XECnIvimI8dy9Uw08xEBXvTw81EZ5k9V?=
 =?us-ascii?Q?xbeevkQjuStkqz3jLDQr23DNXnhh/lCj9WzqL6koj65rDxpodPQ03ravnGeM?=
 =?us-ascii?Q?XkLyQVdciQAm8ERH8Fmoq1Ib26K+EJtAoUZ71cL74ldjkYPrOX1LIvX5x56o?=
 =?us-ascii?Q?RODg1f6tVNoFxfAxM93auzQWpfhrguA5SXXy4QKbLfp/KLZsgehSvcYUcvNN?=
 =?us-ascii?Q?LoFwWlQ+ccCMVgyETjSlyc5FtpbJyPc0Uapq9xec15nBV8sl38o6X+oNnHQS?=
 =?us-ascii?Q?5Z56VB16rPcQBEIo6yMrLhO7VdIS7EsyX4aei9Ri/yw1huMCwDe1ps7Ym2BE?=
 =?us-ascii?Q?/pu0awLb4gc2EcQvUA4kNGUMTN9cD0QcnJfJsQfDF3j/E3FdvBLzqn3XIaMO?=
 =?us-ascii?Q?VqJL9q3mtVaotLdYhh0EHIzy3i8KbsblKiHo9+p65LBs1ez/guQUjKpmNAyF?=
 =?us-ascii?Q?6/IvlnT2+VD+Kfm8I9QMYImTzMWHm2pJ9n6PwdphA/Q5wf5LXeIb1iiAhst3?=
 =?us-ascii?Q?s0XK+/GvyHSQwPw4rU6fZJqquA4Ak3VlWc7sSoWIHxhbwpoxto61MlfzbOW4?=
 =?us-ascii?Q?AJRjkxMRPMbeyxoqTcwKokr5R6Fa5DAef8XwKwlZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DfTd5JWJkdJ7cKGaa5NRwC70PP/wLaoGSOP57bWmQffqVtDDwe0SHz2VNBhvAUby5w53X6cj/BkSp47tNCAp3/MzkDdq7HmAAYUmtcsncjYJW+VcTuPNJMlPpO3zwoj+Yw9AGDerqr8jwAo6Gx7NajKs8lagmPL/96Z52711iSOU0MhcRv/SPYaF698MfSQSl7p8HpWA8216UFrJhuOBXCgSeJgnBhSJJgl02hqVLxvk80Oep3pIZS9uM7hQa3ewutE/bc974XpiTjaa0kHge9hjQAHJV4bLWts+/5JXQ35+z0rXSIkkmWoOaRoaUgcvYpTc9H0sqHIeOcj8MbgwZdJAPiv1KjqeTiNfd573cSYABfNTYRRAH0rpzQddRTyYqUsB2rTYe6q3a/+Qz9SHW9QHAnu6II+BXIwiPYu0iO4DNLIYYyO+Isv0V8waqhOBlzPG2mUwiEJBSfr1lt0aOmHuwUxBo6JppeWqlEuCJVNUPhzXOC+mGYeTO1SeReGUcIdAZLo8lj6JZldkzZSK1yzqCXbfqVbpDl+W3ymynxNrRgIsGbBG8P0OKJRfdRa9gp9Ngut10YAmwkFWVAy+t8dlXoiP1VJa91HOb1hHmTA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f76fd1-b360-4a49-40d5-08dc9c56fc41
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 18:27:39.3730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEQwvvn3PdRiLOXAqNH1XgIZEcWMLNyA5wKZMeYGY5Z2DcgSTZ+6zYNJD5ZGUn/alCZ2KKJllNs8Zgkjiy5eYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4242
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_14,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407040134
X-Proofpoint-GUID: mt5-1i7PCObdFPUfG8sTTO23qrrkxFsH
X-Proofpoint-ORIG-GUID: mt5-1i7PCObdFPUfG8sTTO23qrrkxFsH

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

mmap_region is already passed sanitized addr and len, so change the
call to do_vmi_munmap() to do_vmi_align_munmap() and inline the other
checks.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 8d9be791997a..e9858ca8bbd4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2937,12 +2937,20 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			return -ENOMEM;
 	}
 
-	/* Unmap any existing mapping in the area */
-	error = do_vmi_munmap(&vmi, mm, addr, len, uf, false);
-	if (error == -EPERM)
-		return error;
-	else if (error)
-		return -ENOMEM;
+
+	if (unlikely(!can_modify_mm(mm, addr, end)))
+		return -EPERM;
+
+	 /* arch_unmap() might do unmaps itself.  */
+	arch_unmap(mm, addr, end);
+
+	/* Find the first overlapping VMA */
+	vma = vma_find(&vmi, end);
+	if (vma) {
+		if (do_vmi_align_munmap(&vmi, vma, mm, addr, end, uf, false))
+			return -ENOMEM;
+		vma = NULL;
+	}
 
 	/*
 	 * Private writable mapping: check memory availability
-- 
2.43.0


