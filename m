Return-Path: <linux-kernel+bounces-255628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 671829342FD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E09E21F237E2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AF8190676;
	Wed, 17 Jul 2024 20:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F99lLj2D";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G5Vz3w8W"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EECB19047E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 20:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246885; cv=fail; b=AHU3KQHwMBybsh02JYznSysIIp312kJRL1i6mF+tyPtkZzTtW/8JiunpL5dzSVgNmoZGWFJZtIMoLNyiZQ2hmnplYpN2ZGjKBjP3UuUV3fHG9FGYFR6nS0ypZ2RoHuWYV4237Vltqx9MclQVa6WpKBgg5lboQsHBD6eB7H/mU/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246885; c=relaxed/simple;
	bh=LiSKtfxtf+kffqelJn+S3mG9S151c2l5J27bTgOIV9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yp3iPUVOQY34X18cjORPyF7lYvCL+nZCzQAhI+ZEyw8vh4pZHbnV2555osp3sTrC3oCkc8EdDJxghrGqnq6Bxvh0rAMbFjPcMwK7pdqhBPntT+J8Nd2akIcMmJx3X+sHlVy/IddJUUIN6eU5jk6jvhc7pxxPkYYtlZ8pL8ZgP6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F99lLj2D; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G5Vz3w8W; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HJsRWw002443;
	Wed, 17 Jul 2024 20:07:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=9BtKiGUugGEEWslw8NJfElcvJlWGE3OYXj7kTlHZwJw=; b=
	F99lLj2D0pPc2p9qzDcSqqZsqT8Tg1ZS7Y1NYvrs6lejysEY3jEiW+X39fNDgWR2
	FN0UcxQmVQ62Kp5So0faA1W6mhPJ352cAdJ4cqO2E742CGDsfk93iE8eU6iZL8EC
	UWdZUa1Eepn1kjIZGEw19NEHjkrjt7Te70ZBa9d8yZwHL2HcEl2LjggUuzlL7wnf
	YkXmJ2TACG4jxjyLdTxzbQIrpp6lbmZJlxH/QMFylmd6gHt2JKBX56sosDcLcCQE
	qoy6AlGuBUNDZTnOQTMdC1vsSuqrE6RQh7gGtcyXZ5EI+xR/UaByLHZ5/zXARymO
	EohV7nqMiEMrmCcL+Vejpw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40ekxy84at-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46HJIY6I003738;
	Wed, 17 Jul 2024 20:07:48 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40dweyhkpk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAKIgtkD+w3hmex/YZer243bNB4CarquBBfU6cyalT9ymOZ9vKsT3CfWuEl60fv8ahVNFCmhzMmgxvZJV+9JEAVElLi04XS3abqWnzf0Kvh/oy1KvRnR8mh5DQ/1seF4nUaEmhxXwSlIqGFxZtTCmWXG9MW+j6cdtYzE/8S879NANQfiSxOdBiUiBqyivh41LIpVg5jKJjHQg4Hg4CO31x9AbwgGwN2IwRrUAk2GyZCI4pvvNGz/2S+2H+bnohEAMWFl+foMXlm3iy2+PI1JhLXzKVgqJO05EbJkpklsSAcZllXh8FIEAc6IiiNOnCcqBlAoY06/41u8tZ79hn0Z0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BtKiGUugGEEWslw8NJfElcvJlWGE3OYXj7kTlHZwJw=;
 b=kRYeWNylGwmLKxUbOT2yTDfZlu8ItHUXaXEvbz6mtJIASYt/6RoYqhdHeIcbU3opCbImtjR7CieIbt9MSLsnTAW67pm5L8tKVuISrRBKSrY6BhzI+w9hd3ouC0ltvuyxY93yDWCxatPXwd0pSgdCPlxShJn8/IDD6A3rRcikQHep1NeuQABoJxRQRCxXXDjPAPy9Km5y5icuNwubU9zpBOzM0kZV7dEsLVN96FmmAQMcjDzNlxqyGM4vGLXI2jI9Xz5LBqbrmrf9RcAH7I7ChXcdlhzcFfLh2eS0px7Bym/+T904ctdvXonlDLs3VxThC+RWhDNDyZrSJjlU4wWPjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BtKiGUugGEEWslw8NJfElcvJlWGE3OYXj7kTlHZwJw=;
 b=G5Vz3w8WbkVxrt4i5HAVfajiveBCZ3W+bG1V1S6snjbbhvwf9gLupvAEK7xCl6eYUoAPhJAYuCmlS/3yiU5WoBjdg/JnBkpkJw6EIxw1GmFIfybEwfwaoMsjfxNlAMIKp3IduWyYVcuIYJ1CCgB0I1QqvZadA3O9am+6UoE3l7Y=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DM4PR10MB7507.namprd10.prod.outlook.com (2603:10b6:8:187::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 20:07:43 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 20:07:43 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v5 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Date: Wed, 17 Jul 2024 16:07:02 -0400
Message-ID: <20240717200709.1552558-15-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
References: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::10) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DM4PR10MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a15224a-d056-46fe-394d-08dca69c1e24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?LHfheq0Y2q19j7hVrCrf7J7M0uIUEyeWWwNv2xa9XKRZVfgBKwT9Y08USxZV?=
 =?us-ascii?Q?6o/7Pw8iO3q2bggkeuKrz10geSJsDTTF4OLsOJsrKR0yEshloyiBvLooSflw?=
 =?us-ascii?Q?Y3EqUVEtYFcFVg7rqOVzpHKK5Ld/QKwFmd68H2dcsILl4aDlNYNnx8E8d4iY?=
 =?us-ascii?Q?2Bnu8xPdEnCTd3SOdY62VMOHFbuDjrpxC3EZIKLdYIwUIAwKoZBeUCB/JwkT?=
 =?us-ascii?Q?nAzUAN51SjQZCWnhl50o3b5yGl4C3jY03K4OzAC+DOWeejdr8vyXgzgbO6tg?=
 =?us-ascii?Q?r6lfSSQVxrzB1X6M0gW9wqI5I+O7ru2fH+MVxo/x/EMJ8e3oLx0Lya4XdLmS?=
 =?us-ascii?Q?sJPdlLza02Ov0yrRTYVc2nBvruvywyU9pu1HYgdg2Y0UoI6cqXk38XXynq2B?=
 =?us-ascii?Q?E4e8ceBbiV9jvYAuUwQJrhI1EJBJdFmNgiB1+DjmMwVN6+cRQydCLoDxcWQh?=
 =?us-ascii?Q?lF6pmSc9rmPS8myXLPvu2p4E42dWiFf20+Q5dQw4B/dnwvrBwqkRFL/6Geri?=
 =?us-ascii?Q?pH5gr+MSfaF+EE+lDgJa4lo7Q4I4fdfXkzEcKa6BV+JsRx0DIg8Q8CJNPiUy?=
 =?us-ascii?Q?5ZOJZLaO0L8nr8gzYuwxaBN1SiOP4Qltax02LtQS7JatosenvWXDU9tawJJs?=
 =?us-ascii?Q?r6t/cyJ3HaZH4rad6izLJBedTzwibAQosR6PTp5ORGbdLaqRSfrwoj9x7WAN?=
 =?us-ascii?Q?rc89WQUXIJj2oPXUVBLTyV5yJB88iXEESaxXfKwuBdGPafsEFPtqDHfinUWZ?=
 =?us-ascii?Q?6uMlM1S1ESivmLJpQ6c97PtJkCEIOUu/A3+n4o/nSU6NBqmJJXH6eiQrEgvP?=
 =?us-ascii?Q?Z0kf4qF1MvAwwGB/BBpSQmRWBr34Md0+jeEN+sZZVRrdRFxpZjF1pNNkBLrG?=
 =?us-ascii?Q?SoDbWmyf/NMwflr1l+7LQ/a53vVNpu2YPMl7ww7k71oetFbHVI2pxEkkXMjH?=
 =?us-ascii?Q?T7HDtTyLeTxCDNrLEp4pRfeqPMdugQ1NQ1mH8sZItxPwJeFlo4tIYSDurWr6?=
 =?us-ascii?Q?zQPk7mAvMAq0sRMzeM/R0N3k78LLZT7njZWP6Y7rEcBqTQYgqjGBThTEfvTM?=
 =?us-ascii?Q?kHKNYLEN9id2ytyretSazrWPcZK4eI7zs0T175aTbj7WEPiGZa5TBMuSFKeM?=
 =?us-ascii?Q?SvfGG4R9fE8aUZwMNTqV6ofKnTqDZffK1OmyxqBcb72YeFJmwT6li0uExSPO?=
 =?us-ascii?Q?oY2DiSXiRPkG1rv1pCetCMlPB3R4cIDr965v5JsvWEwXaz4x8r7/8bP8/kq4?=
 =?us-ascii?Q?fYXj7Q1XTPblHyP2IK5pyLPrClGySZQuaDD2/1IsQ1FMdVwixPMFOBuGg97e?=
 =?us-ascii?Q?auhBpR9j7dlzTbIxw/kdJI031x6XVUElRzjdfUmxOMgsLg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9Jnmiif3feMX6wIxaPvv38Eq/S8UwFz5x7aVLwW1AH524lZVDqcLgXe9cFMP?=
 =?us-ascii?Q?MYWUXxAfOB0QlfD26B1QKvjS5X8l61zxjgKQaZdlJ8+NLQqC7mDJJpFhiD93?=
 =?us-ascii?Q?qTM5GTCBwXq5RRqJmLH0bv1ODDXak1uphwM7uVJyGU8wMpdKoXBq+iMQ06IF?=
 =?us-ascii?Q?3vwOveGyQ9TCv0/8O7ZDexsWGV0j4KOWb4YJZL/oYYVC6yVFl2dCNcCbXBBq?=
 =?us-ascii?Q?yIdPWvzLrplaJlW8KPLRr2LZ9WZtwk7kpmzsi3peXW81HbcTPaaKtzJhTgfB?=
 =?us-ascii?Q?1jQtcdUqItdE3ZGr4h4CSG2OACUtesp1zj18nvsPcXTI51I5wLuvn/9BEg7q?=
 =?us-ascii?Q?QYDJjwXC6fC7mKOmC7vB4w5mhl0Q1RNIy2aAiD7OnLwLsc+/lwmS95t/FHyy?=
 =?us-ascii?Q?GIIvRo3ro89h14jRhptMIYCZtIRXOzkYIKr1p/4aedU0rC+PDoZLlfnckNj+?=
 =?us-ascii?Q?rjWKFR6/sLKH1shj1Lu6HA2paBUWUjHxY6ziS2I+We3FPySwLEWeaCY6kMGv?=
 =?us-ascii?Q?bbvPKldYDIsvV4pyW4eQDfrR7GsDG06b3mruREndbMPS23RzlLJ4UhASauS4?=
 =?us-ascii?Q?C256PfCTktrD4DW5gn65MW5/OZWlUu8QJpIa/slpQYjzpyRPQpDSKcqPyHeM?=
 =?us-ascii?Q?mYm8eiaxSOp0ihOzfqZajzqleYMvIzppqM98GS47ViUDlhx4m88x4uogj5v4?=
 =?us-ascii?Q?qGlmY83MG1duGLcDJpmGsPGDD2wVFpvSspH0Hcwmsob+67wDl1U/ead/zcGK?=
 =?us-ascii?Q?LPxsgltqvDQOGfVfCjzUkZphFyOb/9EZCzLMKcCqB3sQ9JauoHKGgeYSsAne?=
 =?us-ascii?Q?fdVOUyMbkFhiNHYqOiIZq9o7OALKOA6HMnLn26cASJk6N9RtsFQ61vjcakQv?=
 =?us-ascii?Q?LoIO5iPxHTJPweOvvnuRq1Lf+scyq2UE8Q3nF3bG+xz/bUumSP9Tx7RX6M93?=
 =?us-ascii?Q?eZSIeIz1McNF/0mTqBcAHbm4Mbc1TOFqa73SYSHss/BWj0rpICiOebZoHQaG?=
 =?us-ascii?Q?UBLb4eg71YMVaV0+mfHqHkIRrTU5VP3qq+wUdykrTQhV2k8cgu5cobvdmOUw?=
 =?us-ascii?Q?0E8DmT5HKt9D0r5O5qlqdr08galGWoXLQ+YTyTjXadLggzqPnvrM105KIvB/?=
 =?us-ascii?Q?NiCvuhru7oMjUJHyO0IVFTUoE7rY/ZiewEZc64U+oJzdyRe/0ut4UxmoCZTS?=
 =?us-ascii?Q?SmFZAuMJSpKvv1OLFTE1ObV/liOFQudqbuVQyFqWy66vwZkKZhZvFd1D9L23?=
 =?us-ascii?Q?qb33jpZVmUXSSiqmtph++jTAOn5gP+2Ef4du29vJ+vM41Gqz7pZhsXa/6byI?=
 =?us-ascii?Q?Ig7LgFRyrkdITzwKh4M4gmlIQoYIhBoYEUhzOlu2N+mbEvI4KyByUM1hGl1w?=
 =?us-ascii?Q?6GpgMz1QZJHWwBONmitNbXyU2Vh+lhG8nLEF2Bg4CwAw7e2xKWUDuSj/t1op?=
 =?us-ascii?Q?wlMTjk5/J2LmUstXHevyAMGR6vx/r+W3ie3ChMb2gT4Ei3kV00jot5EkPzZh?=
 =?us-ascii?Q?pcoo+okrsj6ilfGSL1fyKBWIC8b0pNRO9NwbKz6lY75pu5zmk69GTGudpHhC?=
 =?us-ascii?Q?aHiLLV2Pj7LAc+/ZYrlMkAo198l2vAxm1xSypYzVKVObq6GYoj19jxhQfYAf?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mC1P1SEDK2ZsACtWdFu6WEKwncbMM8f8sViK+dnAqLaQc7+N7n3gm9UkHTWJ08zwvgJY8vrgQK+jKx9sBUDMqV1NuSZGffb+u2ijL9EBIWlDySTiTRUXMlvNXz17HsGlIZfqOEfDbo+4erqbVoOauqUD9YqXBuMdwRuCxxA0EL7A2tJFEznmGy+nnQM8gGgTAyMt3LtuibE69xLeCICIUoTFzxffBl2JdqhPTSxt5a3cb41hA2diLq/3551K80m9MLgPJXNyFX7GWqKYyOo0OcOMEvtmhWWZNrfFxtkAm98KzjNjePFvhA7Qc3POsq6N53SBeK0cO3tCk5sMx28rEEfs0bunS7wkpf7qA+yaguVEkBKQbip49FLBwzPgqauiiZs9FltAoNHsG0LT4PQnStDqpZroBgWr/UE4Wrp0QDkle6e2QGRJt8wwb4nZpM439XX0FYHUYvWWR7wKjarqzaxvVnizjx5P20HjX9nB+btwlunIQgBPc2lntu3E3uQbgJO1wESuoYjqGTnVOlRJkj2mdk0+WJRc9vE+t9MxpoOY+IjoVHTtki1lI0JGirXpXc8/7XWjZtYaDp8O1ctQDbSuYATzVhXzVpcumk+eMo8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a15224a-d056-46fe-394d-08dca69c1e24
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:07:43.1842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8pJMxzRvvaujBu9QWKuJdr84/+XZDyRlvL5k37GkaAxdDjbFtEHHKLC0NFRHiVdKpB7ohePI0KsefAj6Mbkxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_15,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407170152
X-Proofpoint-ORIG-GUID: 8pxu8IA42-a4_-5pWZhOhMGtHFSc9l3C
X-Proofpoint-GUID: 8pxu8IA42-a4_-5pWZhOhMGtHFSc9l3C

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Instead of zeroing the vma tree and then overwriting the area, let the
area be overwritten and then clean up the gathered vmas using
vms_complete_munmap_vmas().

If a driver is mapping over an existing vma, then clear the ptes before
the call_mmap() invocation.  If the vma has a vm_ops->close(), then call
the close() function.  This is done using the vms_clear_ptes() and
vms_close_vmas() helpers.  This has the side effect of needing to call
open() on the vmas if the mmap_region() fails later on.

Temporarily keep track of the number of pages that will be removed and
reduce the charged amount.

This commit drops the validate_mm() call in the vma_expand() function.
It is necessary to drop the validate as it would fail since the mm
map_count would be incorrect during a vma expansion, prior to the
cleanup from vms_complete_munmap_vmas().

Clean up the error handing of the vms_gather_munmap_vmas() by calling
the verification within the function.

Note that before this change, a MAP_FIXED could fail and leave a gap in
the vma tree.  With this change, a MAP_FIXED failure will fail without
creating a gap and leave *a* vma in the area (may have been split) and
attept to restore them to an operational state (re-attached and
vm_ops->open()'ed if they were vm_ops->close()'d).

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/internal.h |   2 +
 mm/mmap.c     | 119 +++++++++++++++++++++++++++++++-------------------
 2 files changed, 76 insertions(+), 45 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index ec8441362c28..5bd60cb9fcbb 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1503,6 +1503,8 @@ struct vma_munmap_struct {
 	unsigned long stack_vm;
 	unsigned long data_vm;
 	bool unlock;			/* Unlock after the munmap */
+	bool clear_ptes;		/* If there are outstanding PTE to be cleared */
+	bool closed;			/* vma->vm_ops->close() called already */
 };
 
 void __meminit __init_single_page(struct page *page, unsigned long pfn,
diff --git a/mm/mmap.c b/mm/mmap.c
index 20da0d039c95..0b7aa2c46cec 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -170,10 +170,11 @@ void unlink_file_vma_batch_final(struct unlink_vma_file_batch *vb)
 /*
  * Close a vm structure and free it.
  */
-static void remove_vma(struct vm_area_struct *vma, bool unreachable)
+static
+void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed)
 {
 	might_sleep();
-	if (vma->vm_ops && vma->vm_ops->close)
+	if (!closed && vma->vm_ops && vma->vm_ops->close)
 		vma->vm_ops->close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
@@ -401,17 +402,21 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
 }
 
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
-		unsigned long addr, unsigned long end)
+		unsigned long addr, unsigned long end,
+		unsigned long *nr_accounted)
 {
 	VMA_ITERATOR(vmi, mm, addr);
 	struct vm_area_struct *vma;
 	unsigned long nr_pages = 0;
 
+	*nr_accounted = 0;
 	for_each_vma_range(vmi, vma, end) {
 		unsigned long vm_start = max(addr, vma->vm_start);
 		unsigned long vm_end = min(end, vma->vm_end);
 
 		nr_pages += PHYS_PFN(vm_end - vm_start);
+		if (vma->vm_flags & VM_ACCOUNT)
+			*nr_accounted += PHYS_PFN(vm_end - vm_start);
 	}
 
 	return nr_pages;
@@ -527,6 +532,8 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
 	vms->unmap_start = FIRST_USER_ADDRESS;
 	vms->unmap_end = USER_PGTABLES_CEILING;
+	vms->clear_ptes = false;	/* No PTEs to clear yet */
+	vms->closed = false;
 }
 
 /*
@@ -735,7 +742,6 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma_iter_store(vmi, vma);
 
 	vma_complete(&vp, vmi, vma->vm_mm);
-	validate_mm(vma->vm_mm);
 	return 0;
 
 nomem:
@@ -2597,23 +2603,31 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
  *
  * Reattach any detached vmas and free up the maple tree used to track the vmas.
  */
-static inline void abort_munmap_vmas(struct ma_state *mas_detach)
+static inline void abort_munmap_vmas(struct ma_state *mas_detach, bool closed)
 {
 	struct vm_area_struct *vma;
 
 	mas_set(mas_detach, 0);
-	mas_for_each(mas_detach, vma, ULONG_MAX)
+	mas_for_each(mas_detach, vma, ULONG_MAX) {
+		if (closed && vma->vm_ops && vma->vm_ops->close &&
+		    vma->vm_ops->open)
+			vma->vm_ops->open(vma);
+
 		vma_mark_detached(vma, false);
+	}
 
 	__mt_destroy(mas_detach->tree);
 }
 
 
-static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
+static inline void vms_clear_ptes(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach, bool mm_wr_locked)
 {
 	struct mmu_gather tlb;
 
+	if (!vms->clear_ptes)
+		return;
+
 	/*
 	 * We can free page tables without write-locking mmap_lock because VMAs
 	 * were isolated before we downgraded mmap_lock.
@@ -2629,6 +2643,23 @@ static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
 	free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start,
 		      vms->unmap_end, mm_wr_locked);
 	tlb_finish_mmu(&tlb);
+	vms->clear_ptes = false;
+}
+
+static inline void
+vms_close_vmas(struct vma_munmap_struct *vms, struct ma_state *mas_detach)
+{
+	struct vm_area_struct *vma;
+
+	if (!vms->vma_count)
+		return;
+
+	mas_set(mas_detach, 0);
+	mas_for_each(mas_detach, vma, ULONG_MAX)
+		if (vma->vm_ops && vma->vm_ops->close)
+			vma->vm_ops->close(vma);
+
+	vms->closed = true;
 }
 
 /*
@@ -2652,7 +2683,7 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	if (vms->unlock)
 		mmap_write_downgrade(mm);
 
-	vms_complete_pte_clear(vms, mas_detach, !vms->unlock);
+	vms_clear_ptes(vms, mas_detach, !vms->unlock);
 	/* Update high watermark before we lower total_vm */
 	update_hiwater_vm(mm);
 	/* Stat accounting */
@@ -2663,7 +2694,7 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	/* Remove and clean up vmas */
 	mas_set(mas_detach, 0);
 	mas_for_each(mas_detach, vma, ULONG_MAX)
-		remove_vma(vma, false);
+		remove_vma(vma, /* unreachable = */ false, vms->closed);
 
 	vm_unacct_memory(vms->nr_accounted);
 	validate_mm(mm);
@@ -2804,14 +2835,18 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 	while (vma_iter_addr(vms->vmi) > vms->start)
 		vma_iter_prev_range(vms->vmi);
 
+	/* There are now PTEs that need to be cleared */
+	vms->clear_ptes = true;
+
 	return 0;
 
 userfaultfd_error:
 munmap_gather_failed:
 end_split_failed:
-	abort_munmap_vmas(mas_detach);
+	abort_munmap_vmas(mas_detach, /* closed = */ false);
 start_split_failed:
 map_count_exceeded:
+	validate_mm(vms->mm);
 	return error;
 }
 
@@ -2855,9 +2890,9 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return 0;
 
 clear_tree_failed:
-	abort_munmap_vmas(&mas_detach);
-gather_failed:
+	abort_munmap_vmas(&mas_detach, /* closed = */ false);
 	validate_mm(mm);
+gather_failed:
 	return error;
 }
 
@@ -2945,24 +2980,19 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	unsigned long merge_start = addr, merge_end = end;
 	bool writable_file_mapping = false;
 	pgoff_t vm_pgoff;
-	int error;
+	int error = -ENOMEM;
 	VMA_ITERATOR(vmi, mm, addr);
+	unsigned long nr_pages, nr_accounted;
 
-	/* Check against address space limit. */
-	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
-		unsigned long nr_pages;
-
-		/*
-		 * MAP_FIXED may remove pages of mappings that intersects with
-		 * requested mapping. Account for the pages it would unmap.
-		 */
-		nr_pages = count_vma_pages_range(mm, addr, end);
-
-		if (!may_expand_vm(mm, vm_flags,
-					(len >> PAGE_SHIFT) - nr_pages))
-			return -ENOMEM;
-	}
+	nr_pages = count_vma_pages_range(mm, addr, end, &nr_accounted);
 
+	/*
+	 * Check against address space limit.
+	 * MAP_FIXED may remove pages of mappings that intersects with requested
+	 * mapping. Account for the pages it would unmap.
+	 */
+	if (!may_expand_vm(mm, vm_flags, (len >> PAGE_SHIFT) - nr_pages))
+		return -ENOMEM;
 
 	if (unlikely(!can_modify_mm(mm, addr, end)))
 		return -EPERM;
@@ -2979,14 +3009,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
 		/* Prepare to unmap any existing mapping in the area */
 		if (vms_gather_munmap_vmas(&vms, &mas_detach))
-			goto gather_failed;
-
-		/* Remove any existing mappings from the vma tree */
-		if (vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL))
-			goto clear_tree_failed;
+			return -ENOMEM;
 
-		/* Unmap any existing mapping in the area */
-		vms_complete_munmap_vmas(&vms, &mas_detach);
 		next = vms.next;
 		prev = vms.prev;
 		vma = NULL;
@@ -3002,8 +3026,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 */
 	if (accountable_mapping(file, vm_flags)) {
 		charged = len >> PAGE_SHIFT;
+		charged -= nr_accounted;
 		if (security_vm_enough_memory_mm(mm, charged))
-			return -ENOMEM;
+			goto abort_munmap;
+		vms.nr_accounted = 0;
 		vm_flags |= VM_ACCOUNT;
 	}
 
@@ -3052,10 +3078,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 * not unmapped, but the maps are removed from the list.
 	 */
 	vma = vm_area_alloc(mm);
-	if (!vma) {
-		error = -ENOMEM;
+	if (!vma)
 		goto unacct_error;
-	}
 
 	vma_iter_config(&vmi, addr, end);
 	vma_set_range(vma, addr, end, pgoff);
@@ -3064,6 +3088,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	if (file) {
 		vma->vm_file = get_file(file);
+		/* call_mmap() may map PTE, so ensure there are no existing PTEs */
+		vms_clear_ptes(&vms, &mas_detach, /* mm_wr_locked = */ true);
+		vms_close_vmas(&vms, &mas_detach);
 		error = call_mmap(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
@@ -3154,6 +3181,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 expanded:
 	perf_event_mmap(vma);
 
+	/* Unmap any existing mapping in the area */
+	if (vms.nr_pages)
+		vms_complete_munmap_vmas(&vms, &mas_detach);
+
 	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
 	if (vm_flags & VM_LOCKED) {
 		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
@@ -3201,14 +3232,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
-	validate_mm(mm);
-	return error;
 
-clear_tree_failed:
-	abort_munmap_vmas(&mas_detach);
-gather_failed:
+abort_munmap:
+	if (vms.nr_pages)
+		abort_munmap_vmas(&mas_detach, vms.closed);
 	validate_mm(mm);
-	return -ENOMEM;
+	return error;
 }
 
 static int __vm_munmap(unsigned long start, size_t len, bool unlock)
@@ -3549,7 +3578,7 @@ void exit_mmap(struct mm_struct *mm)
 	do {
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted += vma_pages(vma);
-		remove_vma(vma, true);
+		remove_vma(vma, /* unreachable = */ true, /* closed = */ false);
 		count++;
 		cond_resched();
 		vma = vma_next(&vmi);
-- 
2.43.0


