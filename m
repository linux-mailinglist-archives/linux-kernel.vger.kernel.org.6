Return-Path: <linux-kernel+bounces-308012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1CC96561B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46EA828862B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1341531D0;
	Fri, 30 Aug 2024 04:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FPgBEyoK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eesjldRs"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EFA14F9DC
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724990505; cv=fail; b=m0RwfkGecI9RVMIKDwe6rzhnbhuyZprMZG2iTB4g8P1prYZuR/0qZu5ZtOfbh0O0L4MW8sjTA6BrYiT1vcUerfJ7AL1txMZgjEbgQMR/laBQGPZYWm5ZVyue7ZQOip5pgz5m0RmoyEJEenz7eJXGGIglgELKBwcxA5gMMEs5PkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724990505; c=relaxed/simple;
	bh=kfLiFfuu76KuUS/5UmfiKhSzgFWii4GPrQQduHUxi6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b+QH12AgJC6CGAKzZBq4vFOoxEaxDC9Lu4U3F+XjtMtdyep/2e/fza/TKDBqgV+VXCZ6bX0+I86L+flgYqt0D5CIR9tqaZXrcyhJ79yg7FcxuQb7ISVVI433Hf8vj9p0uiSHHLxhWu1h0yHFKruWq8zEfHTYPfuEJS//qm1482M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FPgBEyoK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eesjldRs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U2srf9011858;
	Fri, 30 Aug 2024 04:01:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=G5x2B6KdF/l+leREmzG9b04kNGdPYnwroP/y6Yjz/QA=; b=
	FPgBEyoK266hI6RaIii69d24LM1Z5pC+vEw4uaRmDAd4TA+++A+mJBCr8wk5LQ3r
	MKOmnmGP93j/ZLrOI7xaymoYviUOT+5rNljovgD81K4wOOIsykCLK/fSO0cjFgX0
	fqSa/LzlZ102I9QjarDHYuV+wuswADkfReyXEg4nIAXgF7/jKl3yXPrZQhl7dK69
	dDPOGgCu8K+723dzjvHRantGMEVYEvG/70DuodYDJ8IKrU4393qOXMM+XLT2uwvz
	7qAdQJETznetUOj6a7FY/ZdO88FuGFKc2RCoTvnjjWitAuZnI5DUSa3LjBG8z5zu
	ByxhLp1OQ3MCPnqSCQ1kMA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41b5q3r1v1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47U3jJaP036502;
	Fri, 30 Aug 2024 04:01:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4189jp2swm-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amDI/iHlCL4PmHybMRaSCOQw5tKfczKhM7k3IVp33CxI1f4X071oT+UpouewJnubUnnRDoRtGCPETXsgdrHjzgkVem0xlcDXNmZvBmmHRG+VH0SPjDx/mrN4fA3DswEscaQ0FynS8xw8UlkKBL04OFkkxwxIOvsqDcAu5r6emE+pjOT7SxR2LZgoNoiSW64/7vIGCOgBW8B4wjLkSfj2sblVq2Rl8XzysSPojUHWOsgQXXq/ZXXftUVWJlQfXGVQrvGSmLbLplfc5/8is6EsiVcqLpwxPv8zhu5xfgfOM88YugDmzdbtIH7Q1dZXbfN4CwmctQskrhx418w0yyvI/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5x2B6KdF/l+leREmzG9b04kNGdPYnwroP/y6Yjz/QA=;
 b=R+xUvc4qEfHUGf6zmTqi6It1bbZtzJiixRHVOOmWRKY2J50JtKmVnvoyzEsc1HnFeV9qcxEao+msLnV+FxuhiZfjNALJfctSWkFbb8uOol+5ThWkb6MT0+htG6B9gSWju+c0n7C6VXlvESXcKV4n57hy0hiGf11fRYsTwKCC673xLIs1XDKyCRiG8XDJib4HexlnffVDQPEyTHjRMC9BPjgeFZ6FS/BxJwenBHHJH+Fgu3FqQCKsvAm7FwpFxGkCfrWpHEV/XB4bvEKqA4EhtJvtvW5V5COeYmPhstPajoaX5UD3M+Z906i8eBYXHYF+jsT4AzF2X6YR8h+ncrtOew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5x2B6KdF/l+leREmzG9b04kNGdPYnwroP/y6Yjz/QA=;
 b=eesjldRsMR9BDidWbZYoTk6CM+HJRFWjMB8CIJ/TrB3lfakvFsQP0GX++UqMu00hAqzwjoM5xzHNbUq2eZIFPuRB/+U9q7A50lgiv3n7695OLEdgSQ3vUQ+xzLEfG5Fd9wvH9h3ON7fW8O1E4o2wgcLLq2nPEsZi19fE+icRnBg=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CYXPR10MB7949.namprd10.prod.outlook.com (2603:10b6:930:e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 04:01:24 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 04:01:24 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v8 08/21] mm/vma: Inline munmap operation in mmap_region()
Date: Fri, 30 Aug 2024 00:00:48 -0400
Message-ID: <20240830040101.822209-9-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830040101.822209-1-Liam.Howlett@oracle.com>
References: <20240830040101.822209-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1P288CA0031.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::44)
 To DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CYXPR10MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: 99322462-6b0a-49e9-0da4-08dcc8a86a59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zdi5fsZWBtshPrFg4lh1DRSdILh94vOoXBnrOrD+1P7Nt3GjxODvP6SmaKrD?=
 =?us-ascii?Q?cl1BD/reETz9cLgG9R89QM4py7rt4z8LS+JEP5xIz5zepwvnO1Dg6DqP+YHY?=
 =?us-ascii?Q?7gzjkD2pLfCQWdZjHLj4ajS/yLJSb6wj2N83YEqCIRO6xhaD2U0020Ztvuwq?=
 =?us-ascii?Q?o/vpHwxM4I8/tyUpSTi8AEWB6p3+cr8ylAo/SaFb+ZE+8KLXT6dCh+rCiFD5?=
 =?us-ascii?Q?K1Tt6IiIZ4CXZHpyEmZIAWSmrB4enLrDq2yOD2euLxiAy5FIxUeMW0q25Z/Q?=
 =?us-ascii?Q?248Ko9cQtVTYzhtbPIAafYghIFiYkV+Fdw7Sw15Euw9EJZp6UIRn8YTiaEDM?=
 =?us-ascii?Q?ae6Xl+l76dtCnsYHPTmlvujv4Cw4QfuP7dp2gasplEW/zVRpkSHPUaXx+UDu?=
 =?us-ascii?Q?quG3VHxAAJqdxYjAbTgk85sQg3Hvmo+Po0BaJ8ZXPnj7II2a8g05TT3tiRVQ?=
 =?us-ascii?Q?TnP1oUoe7G0eXv+0rv2PZktaXsT/GHpyUbmncFZZisyMSO7Ut60Mpt6IyR3u?=
 =?us-ascii?Q?+ecNvymY+nkCl0ke7LhctzaiNZxAwdKpNoKNFhKnemgsWML6ryxYdY/1H2Yi?=
 =?us-ascii?Q?0pUIX89MkRAzGzF+U5Xhak6XT8u5bD//PYbq8sPM5m4xJzZKZB8XqcSoZgif?=
 =?us-ascii?Q?1ozjPid3PFTvJCnHj2rvSlCjYdjlXOycPwH0xGjHZK68DHFVA60ZKGbfcGOm?=
 =?us-ascii?Q?jLrvCaMxcS0pLzjy2z/6fof7gVxR79CYE0b4W1JHsPCb0zeXZEURelOb99aq?=
 =?us-ascii?Q?rHgVBwaWeGynSHus/Oy71zYaGdl0ocQ4gKKnhqq/AuXRPjvSARRaoYgVuZS0?=
 =?us-ascii?Q?fWA5cit3eBFu9YEf9wBtiOZhTPvnMAH3EP98IqdFqxfvBHNLM4uQTVJBour2?=
 =?us-ascii?Q?fJ8TBwC8Gn7ElPUNLl/14emRh4Jo81URT03Is8C7Y9RynoJWW2+G7hTHpr9a?=
 =?us-ascii?Q?LyOTUKYv6n45RShjgX8EuS+eJkA8hDh+NsgEERcmgKxZnQczEtkomN8AUmto?=
 =?us-ascii?Q?Q4UMhxM8XPUtiofHq3/kD0kxF0GQiAaPk/b2MdSACfKtTETod9dHqJA2ecPb?=
 =?us-ascii?Q?GVcDKMA36GKgVUw3DJRgjW/VZEo8P9Jtr9UR1vmhr4ClfggyjSdvUKjeA+kW?=
 =?us-ascii?Q?jORcB+4T0Fsr6p2g/jmypFd6hPl1KmzI0KPCSlQn0dAMkFIHU3H81NLaRb6m?=
 =?us-ascii?Q?cM9Til401b65Imfft9nPD0pj4THXigq64Kt+wI01Kg2FXGsV+ksbFQsYBaJ7?=
 =?us-ascii?Q?OSbUlA7j+ePkfsWAHmmnxjpaGlVDBAcO2Ue9wJRPPwDcXLrRk78GJdruBThG?=
 =?us-ascii?Q?M+NkEaYSzPv2u/7I5rNLjQeAznaEHkrbtTvkTWO0/gc0ig=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sn1m9z/CzIccL7qUR8FyR3R2fXBxZvdvPTgsjEwRdmU48T7E/jJbFGSGK+E8?=
 =?us-ascii?Q?9dcEZ40ROgyuEq0Z/mV0FlWxMeBm8pMjEIKCfKDthjZBOjja63evOnAkjr88?=
 =?us-ascii?Q?YjYVyRFjh1nLSxObOCJL9zmkSBOeeR+NYfgyDMYHaoqD6FHt/w2txrV9jndD?=
 =?us-ascii?Q?TmjvTQr6V/GJW/xeF1n0WT6hvmcUsgrF2AjrCNuGswE8pxw93gwEnKYUqaph?=
 =?us-ascii?Q?Eo66HiyluDKiEM90pXSigFSZFu8VoXYMVQFb3CnfmJiFK9lAWYnc0x037X7D?=
 =?us-ascii?Q?TBGRSZtnMdVm6qFcKNuDrXA3fNIjRnbCfhxslsGFnwihJSJx74kZZYDaek30?=
 =?us-ascii?Q?3d9EXuou2hk72TsRawEzofsiIPXoOvcicqDHU/5qNccpTawhmphP1w6debxl?=
 =?us-ascii?Q?N6kUnVlcP9tjRXlzI02TL3+602Z4jPIX7adr1bF8oh7Cs/l5/2KkGWvXVwNg?=
 =?us-ascii?Q?pDGKaCdnPmWD8OJ8hjecWW5DePHqm/pIqes9w5wPOCQr/9uRs8DQ/BpwHi2n?=
 =?us-ascii?Q?WGxtkIah5GF8fplK+WRi57Lb9TDoL6zrW+BIdCWhe9YqiUpXaKeZI9U+CA/F?=
 =?us-ascii?Q?IV+MPUc2/XCh4x7OhuQsPotoDtLW8oEWog7isBgERaFERz0e6qF0t+so50bs?=
 =?us-ascii?Q?YpXsaihNcJ8tdlABwtmxWw6fSE5XZpvda5EIdj5xHTMZJoTw/O+KS9Z5Uh8X?=
 =?us-ascii?Q?CCYoGQURGff07q3s2GcRCsbu3NPlkCwliykhd9Ztd5kVjrZaXNtf9Wag5ict?=
 =?us-ascii?Q?9hwYePhpDIGaXaH7tRcZPJxlIRTQ77ceoyCLi2ahP1TPCSRxOQm1uUx3Aluz?=
 =?us-ascii?Q?nU6SJwOJ4oMMAkQdC21AR0zRFyCilOQpdrbZQ98voWYeUkfB7/j4GuNfzy1e?=
 =?us-ascii?Q?c9kBzrfLocFee3zrUosuUOxHER03xkXWUU5G3lkVB+Z1xbFZzmQhZ5jDDHGg?=
 =?us-ascii?Q?Rx+NgCX5SAAWlg6hh+Alz8TT+IY5EjYD5byBxp1SGrl5xDtDRGCxdgP9s3TD?=
 =?us-ascii?Q?q7cPAelLWXQQflTiSGCPzU+Jjb4Yq/SieD/O3TPiNuFvv3ZkLlQ5YbyHELAL?=
 =?us-ascii?Q?59pQw/qPzJAW032a6ACJNHGlFkW8vZudgnIIuiQ+RAzZujuHusdk8FwYCMhd?=
 =?us-ascii?Q?mP8NRDSR6kzgCSlMUioKkshbaU9l2Tez2SHE2pMta2MfS9REGgelXfUjPAkf?=
 =?us-ascii?Q?+/L/0Vxw8mwbLRY870OqSWJEx2mrUcvKaqO8IXOwVnZf+DBzDCU2TEmxEkLx?=
 =?us-ascii?Q?Jx6ttzs1lthYRH1pDLHjkloYP5wq/XOnt/sO3++5sV5oLYRutNLwBnNQ1c+U?=
 =?us-ascii?Q?+VFeFmBiSKnzEj/PMKcEtcp4vz8jro+h2o1ht6gadr2P+GBuKf/QfjZH69AA?=
 =?us-ascii?Q?4BVpsfdErEscnImYcLG3vrGBP9cYpexnJg1L4S6yELmrpVrtS1BBToddLGFM?=
 =?us-ascii?Q?uhcflEwamM7hoggHgIUP9ZMapxLs6sgo1VhxaetDAN+/Q01c/GvoVR3D9ULU?=
 =?us-ascii?Q?D8/Mv71BPlt67WhNgR0zvW4vf9JdI7TeO8tlIbgI1VAwWBhpKEBVFPWGQlau?=
 =?us-ascii?Q?k1KkLm2bd1ciwRzCaJfNB4Rc3Q6tj9thBdS/meQgtF9V0OqTYYHcQu2Vft3f?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jNXPpxlAlbsPhqnmL0iLBPk+QOyBzGM/a5O7BqUxvneU6AgFJ4YsvdMpM1RtZTYIcU95A+KFgWxoY1G7980Y/sgtPXcV9425dwb/Wcpx2WKVCFEKI5gWPNq7WzInb6yImn6/sZUCdz55cxE5MCGoZUsthaUYXuuLYQvInhiSBgptjHAnLqD7cCNzT0dsitaNLFJfmlBDv8h9zIZgbAJFkxynt8BPLf+ofdn6DxptHmtAetpbJWOQt0Wh7wYbknoe8t0olZjQNz/bouir4r/f+H5erww08ikQamSyBit3DROGFtpSbaSNn9WhvO/rz36z9SY7BZZkSHFsc4P4UIl5RBQ0DSZOzD4oStQhJ+IwFHN57fInog4DW8OgY/+MhE6Jv3HdL2sM3zrl/GpOaC4P9MTaucE+Ym66xlQwoKdnivfKhlz/FSlCLript2i7ZSlcwBURWgUu3aPjJHLpFHZsJ58Q9hnlQJ+lso0Nq18y2hoAjy8avRk7PLqJbcyoEIaFFxTHAIDoJ7s50Kt4H5dxvHMpDN+H+tb4pXawAlE9tztEs2Xr4rY/NWXG6seMmVh51LtgrhSoGHf7AW3oG6GRJp4zuj4FKMOCb0gWixuBsc8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99322462-6b0a-49e9-0da4-08dcc8a86a59
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 04:01:24.5268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7P+praqS4KVKW8aL4HF3Mll3nI13SaMXtm483nlhD4BoI6XSd9R1B/JFtJAYlT82O2w9azispgaXs2DuZ3Wxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7949
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300028
X-Proofpoint-GUID: qWbMrd-yMzxYTgqHDsZnajb4gbBE2Axp
X-Proofpoint-ORIG-GUID: qWbMrd-yMzxYTgqHDsZnajb4gbBE2Axp

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

mmap_region is already passed sanitized addr and len, so change the
call to do_vmi_munmap() to do_vmi_align_munmap() and inline the other
checks.

The inlining of the function and checks is an intermediate step in the
series so future patches are easier to follow.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index dce1cc74ecdb..ec72f05b05f2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1388,12 +1388,15 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			return -ENOMEM;
 	}
 
-	/* Unmap any existing mapping in the area */
-	error = do_vmi_munmap(&vmi, mm, addr, len, uf, false);
-	if (error == -EPERM)
-		return error;
-	else if (error)
-		return -ENOMEM;
+	/* Find the first overlapping VMA */
+	vma = vma_find(&vmi, end);
+	if (vma) {
+		/* Unmap any existing mapping in the area */
+		error = do_vmi_align_munmap(&vmi, vma, mm, addr, end, uf, false);
+		if (error)
+			return error;
+		vma = NULL;
+	}
 
 	/*
 	 * Private writable mapping: check memory availability
-- 
2.43.0


