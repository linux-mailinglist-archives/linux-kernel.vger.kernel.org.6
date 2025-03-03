Return-Path: <linux-kernel+bounces-542435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA9EA4C966
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7EE07A3A56
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7032D25D908;
	Mon,  3 Mar 2025 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TFpm5VI3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qMDMSI4L"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01FD25D8EA
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021951; cv=fail; b=I78KEPo92PIbFpv+tMBFKTMakgg2znrEVLhM6JXllrlMqd05K5icBQd22marq60VNSFVkcdsFMJEIWXxHGChTQPHFezuUKXtdvv7m5XozrkSNowXNlOOgk3+V+epUUTxQuiiLwQ4tN26Eplc7cwMmEEXUl7CLCpCBBrqnE49IZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021951; c=relaxed/simple;
	bh=raIsHqbdnnL1yBWmOg8KhEPCWJC8/kX4kKO9tSBkSEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=flaUWxPOrpj9BHtElhR6mvQ5uxQw1CL/RHEbxSwEPUcAr78A8AZ0Bf/eGiukG8n1orDO5fxuC6vAmwO6JyQupZZtwVplrgjICDkOTJFjwBfMOdOTcmNslbULB7zzbUi8U51Gh7gmXuVrEY/o/rEMxU2j+8qCGsB/nQwZHlWVoCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TFpm5VI3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qMDMSI4L; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523G5S0W030063;
	Mon, 3 Mar 2025 17:12:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=GgSl5ilbY0Q1C7HX+1
	mTDOsFm45sm14y5EBM2dH527A=; b=TFpm5VI37ElzYLS+7jw+4pVssvVWnsVi/j
	yK+OunUNlNWHavIL4JYfYIJpZ3x56PItTegc3K4/GiDblW0CgGKcw807oIvHiwzN
	e1QPwEjG3FFweP4VHTKTI8BEiJiKapssSH+MoUA9bpKPYWvyAWTgY/Bvsec7OV0o
	Vj7ZaqZmxq9owsFnlUbrOM9KPVATLf8qGBptnB8BLfxY3snXQ8bBleBpZ3qUtnwV
	DwAStpbnVk6Mw9mvZuLURq0Fp27+MxbMxLKzpfy0kZDNlX5w+w6gm+AVJkJuubtc
	qoCiwvUFIEPeLnvrBcDDBJJ1G3AUvd7HWuvJYQ9HdV2udbJAW3Ew==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u86k61k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 17:12:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523GZifx003199;
	Mon, 3 Mar 2025 17:12:12 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rp7sje1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 17:12:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjjCU4rn1pWcinvZarSU2gIl721jh3d8XRrUNW2XSZEwuWiHFXlsWbJzsx4nn95nZHthwu5t2yS2YfRTHg5st7cH+mfcQqjDM4+3oTdIMY574s595W2ccAqon9jxo7SvQSBcRYCA+V7V4eSML+5Ly8druUk6HoaWMDMJDOxTAFQz+YQikmncvAz+r2Xcl65ZDQK3yZQqXeRVk5h+aV+uekGMJ0HsNiaz72oKC+2qTI7cTJ/rf5b7tlNzEqIANd+L0RiRRqdoeRjHXolAzoTS+aHWwx+xxLn19FvSYRs6/NlpdhzI/+j31BFWQKIH98g2MmYbVtBkUzwcLQnIw5qTAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgSl5ilbY0Q1C7HX+1mTDOsFm45sm14y5EBM2dH527A=;
 b=J+2eO80De1PcmGopQwfmt4Mx2/Nd556tyI59jFr1NwUHWTeixFCKIVl8k3HKRgtXQL+6er4Ix3V4zJQqFw/V8DWH41utP7MQNcpqRfGdJa2Diq9LUTUZVENA6XWqIxSOS9rBTlVHdGNA5/+h9Z+Tn0Fbcg+719dhOUYZII09eEl4VnCdRRUhai0SrvC011eWtIRN7d7O99UjVqzeaVJzUcHzZz27hEnb3YSbo9moHphOXF/8dsl43KEo8gmzMaOunrqz9vjqQ67gJ16/nX604eAOPSMGUWJEdBIOZU1AM6e7hs3Jz2FK71Eb1bmjC5gWTX8tdOzOPJmsL9ODkLGsRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgSl5ilbY0Q1C7HX+1mTDOsFm45sm14y5EBM2dH527A=;
 b=qMDMSI4LqTzwNqrbovpPOPhs+FIWKashE7GKHGyVOx95d0duJS0HmmTVM0e5Q9Vmnrtl1ByToYZsj/q50UZqjETZxP4L+8oCQb1GFqYehU79BI0MtU5uUrfiPC20TeYJ4/fV/Jj6wjg7C0/GdOX13Qg79G2StcVZZG0HcEZJI0c=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SJ0PR10MB5598.namprd10.prod.outlook.com (2603:10b6:a03:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.26; Mon, 3 Mar
 2025 17:12:10 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 17:12:10 +0000
Date: Mon, 3 Mar 2025 12:12:07 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] mm/mremap: refactor mremap() system call
 implementation
Message-ID: <g4lus5wcyzcfmvcf4w7yzsaej2dfprwttcqdjh5thvb7qgqiso@hl34vyxbuhe5>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
References: <cover.1740911247.git.lorenzo.stoakes@oracle.com>
 <e6b80d8f58dd2c6a30643d70405dec3e9a385f7f.1740911247.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6b80d8f58dd2c6a30643d70405dec3e9a385f7f.1740911247.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0267.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::22) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SJ0PR10MB5598:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc8bc5b-86f7-4349-b2ec-08dd5a768875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NWOP6+VxRDLziNp24ny6HER1VJMLm3DS7REZ6tgIDungkuu1h097ONdp6i6t?=
 =?us-ascii?Q?GZDDXKbPQwmtlSr9kVDzNxymZ7gVTZg+WDH0sLM9OW3aeRXbwoEO1fBp32Oe?=
 =?us-ascii?Q?pfdAtckA9Ay9Bedyn5sKVyEv6NJdZKA8zr6elim+tNX8Bc1Ou6TWJo6qDEYL?=
 =?us-ascii?Q?IMh4RkmRJ371+5xOAfflejGbyFORSj4nbrHcxgwGVnGyqXiezzE61P3tUf9Y?=
 =?us-ascii?Q?HYDOBb5hCURwbetnukeu0G3C25PE7pfLhyYe1XrST864pz7CL+24BMgaWPZs?=
 =?us-ascii?Q?UGDF337ekcrQuadBqWLhY3P0bb+xOp6N+KzyTVxMcJudiL3i3nlIkASPAefZ?=
 =?us-ascii?Q?KbQj2hwWzWA/2npqYlwEBznQ9KwOibPjd1qvaCS3hfc7WMVI96ZlVCM0dgn+?=
 =?us-ascii?Q?DDQE9Gy1GJbSOzGiyRoCJyE+7Upuq7SnRR2E4N6K0k3J5e7DgA9HVFcg2Axv?=
 =?us-ascii?Q?tb+YNg9TS7ouEOiQ0arA5md6KADQCmkeOoi264Y3XpW5W6tSzgM8QoMCDxJz?=
 =?us-ascii?Q?ggAsEDtesSO/dnuD4jh2krW7ctxyaoWfBXg1TOsD4EYfQCIYjXk18qN6jQlq?=
 =?us-ascii?Q?GuneWgXpzmJQU3mn7igANgVD05MbdGPVLxdpMBkkH9lrpzlnW0n+1oolxap2?=
 =?us-ascii?Q?LpHKy2AtsJWPHKArfd7lBDxtTe7VJcWO1VNzi8KbBCDtDFYUnH7ejRpeK6uC?=
 =?us-ascii?Q?kqsHHTGtBeaejTs4VPVk8TEAVCuJhtF/5tDuZtTiRsDvcmQPo/TrJU9XA6vM?=
 =?us-ascii?Q?6HcvViraPjwy0y2WdF7VcXmndmt9eT7DzlPq3qW1wZlQW31qLBYs3+MUKXVQ?=
 =?us-ascii?Q?gkU3mUUP2PJqMafX8ruGjxjcRrVWtREZof9s9Qo5YtNFSbEsz2LKjIdKdnyM?=
 =?us-ascii?Q?SYyj6vZ99Lpb8nSg6nCzIE2WPN/c2oXv9cIDQ/lOY0ixwnYvlw6aXXGDkCet?=
 =?us-ascii?Q?TM7ius388xAvN54HrR2bH+S9zkl4/38RDQb4aCy+QYqdJc/VlqmjaljnvRaf?=
 =?us-ascii?Q?STzkfS0/fb9Z2KdL65r5jBI/IouCb10ZpXp/l2DSpdSS/+6vO77MM4Bj8fii?=
 =?us-ascii?Q?Jt7hBt+dgBu8ogz+z+/rXy1vg1RBxyRV4HgxShATDYBPvt9crP4mY7d7IYRB?=
 =?us-ascii?Q?zx0xva5qIycOewP47fgYoJF0swgMAeWQRddUFpkidw8+Q5oqMj2+KAY4+a5m?=
 =?us-ascii?Q?kkFkN5FiW0TEgubd85E9BBZ8T9r4+up2NaDWdZC6pTz3GbwfDcjq3E2V6nby?=
 =?us-ascii?Q?Z2t3OB9ndU/K59TMGY/LzwSrO/TbwZCCIsSyq47YMgzF+LvrgxBqdfbb/gmc?=
 =?us-ascii?Q?kocYGHyUaiMpgCHq1u8S4Yg3hb36Ul8Yxy/8B0iEuL6jyl6f6zakh5rCeMy3?=
 =?us-ascii?Q?XxivfKHstOJXW4/FWy/fdz0ogmlN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ziB0Mzjwdyufr9j3Jye+YhIXiq/RuhpITCrx9G+dupngCnLnJIVH+FywdS0B?=
 =?us-ascii?Q?BhgwFukeu+GbZM7foki3N0IfXCoRZ6DgqXVx5ngMoCx/3kadSQq/BkrJOqdN?=
 =?us-ascii?Q?7uAmjrnkq1zwHa0vppbh9Lt5nG5ES/rPGwdc09aYoc5mw7zlhchtPS0qcys4?=
 =?us-ascii?Q?RxzhVbrkrqRffCAU90BuSYo8gFN2K5WTdQoFqJnxXgv1FYVHaPFse6RNyoD+?=
 =?us-ascii?Q?wXYbVjVapJHp1VaRra8jBigNNRlqk4FaXHsLOnfMbN2PxCEqwrd/OdJr4S8U?=
 =?us-ascii?Q?kJUH00+8J3CaEzcViNWcbA/K8kbTqnC219GkzRxg/26fIZAzOuwm2PafTzGl?=
 =?us-ascii?Q?IzyIYW8KoVbwyhLdNPClLxGCcwnWmnWaWzjp/bwMHV7dkIj8ENM/UvVA1ce3?=
 =?us-ascii?Q?bBiUEVHdtc2vWoMRY+DST2ISeFkVHteirTH+S8tlv+SvDbR70+FocFnHsD0w?=
 =?us-ascii?Q?uN6n+ARpJNJYq/3rMvDFhi/kpDo+X0imh8o5c1pWmvZIb6zjrEcxCdsfiVOZ?=
 =?us-ascii?Q?/Vn/Fw4M7Ve/bZdJqAF8rPu76H/aYEx7FCgld5IZ/Ba8OncwOvgYnYTk4bSG?=
 =?us-ascii?Q?KmtvWo6jkCl+hGJd39rwzqhO96uU2ddgncXhoAulOMBJhT2TDKIHuv+plmDK?=
 =?us-ascii?Q?0fZBvgQ5BEpVtBqHx9ZUoZXBBSyEKxuk6nQVL9liTeO7v3eTEQjBVJ02qIvl?=
 =?us-ascii?Q?4ctW6UgdZ3I1rH97B70tzx5nWIfh2GYjlni2FfNcYzYfI5ePEZjOOSN6zihT?=
 =?us-ascii?Q?pwL0Y/UevLpzbwueeTAwmijGHOen/pjwIo5pcTpWtGuUQNWUlj33HeJjRNCG?=
 =?us-ascii?Q?X6UnUBhJCi3yhJb4JLv8Bx1NEwKKUCfLBDYBHQdpEH1xQ6rsOuphIMhdxlYJ?=
 =?us-ascii?Q?xWhr+zBxOnj6lQkdTKYCRjO9R9GylGfrPs7h88/6uO8zi2kyLt+Bf0u4PxNG?=
 =?us-ascii?Q?9nnNuIMPf8BNhcAko2GS6tMoDqJhuKO1P1u/UYOFQsMQvH1V2YJHl4xZxRGe?=
 =?us-ascii?Q?Wu3MWk5MmtO6Mz2/ufCZDtcdt2dkaSnGKlPU0mn0eO5zLP645p31dTb/fFRO?=
 =?us-ascii?Q?Dm84aFV7Cnq4wIF6t/sUaOXS3BqcjcH0bSSJG1h6ofIeyUxHGdqAITtUwX2K?=
 =?us-ascii?Q?5UpWQG9AUcTyGprjBp3775K3nMM2aEn+rKMizddPz81uL3Va7E5IeHASEFwK?=
 =?us-ascii?Q?m7IzPbVw9sIMBuwZsFBww2me0Srhwg+eVZUKpK/ud2uB27Z+2PX1RZJGXCGQ?=
 =?us-ascii?Q?+xoMd4GHiPjjumWIyTgvuh+5drM3MzxDV7eNfAvStRHUadAIIaitnqmWqdWB?=
 =?us-ascii?Q?gp4qphMkLHXTLmJx9BLCsuj3jV7jyPhNFtkTQcCeI1ciIURAY2bqbj2ZeBP5?=
 =?us-ascii?Q?QXBanEdKjrceUEhiTYpSuT7wPa0HRr9mSzagF+q5V5WxjuIRh+Zn+1Cylax6?=
 =?us-ascii?Q?Zd2FEd9A1a2uChMnqFY3mMjqJAId2ZocjOjV19rmj8/3LSU8BIUKZt8e2GhY?=
 =?us-ascii?Q?B1f0UxgeCzumU45ZPjSiLyk3k/DhLihCYudEOT1KwLCb4lY96eAfEPUwpB1L?=
 =?us-ascii?Q?6mXzgoHjBInPvXxomUsPRffUGfKArsZHTz8JhuKW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WrTMRDxX2xdTSJX/2hx7VhSsgb4gmwc6/WfU4r6Pp8iSe3CG/L2nGuUF3qaNLaR6LwutFBm0PV8CgFWT1o778VDjX3TQYHwhCYUap13uQbc/LVg/5JJYgITkGAucOVrpjWw1rg3aNWh423b2xu5dADv9ipQ385S8Nu5RB2BDaXrA8NsF0kOB8QStzxPNEQ9EZ3EaqDnwGKURAaVGq1bkn9gwJ+GdU8LvYCx4xGUBFIQHdmJ4sb4CyFhZ0ZFLK+2fouxvBXg8Kspq2njyl4xOSsIVLcqld+hItv7p5wSSiMAA6RAryrKt4LwrxTsGRmoycaDpxBtrd0rwKAsyANlTyaMwmPOqb11+H8DSdirhkCXAHleg3/ePPz2hlmx7Kfs3gz9ZqX6Q7/n4/6dCdTYYdK2qgU646GqHUg10es9XoZi0WsLNr+0Aux7kZufvA49GU+Av53dw/p75KE0smYaEQ8WCXEortKImpUeDUc6ccw9XfBZNpJrXiwuUwJQYw2DXZgb4Ky5118duHvkU/tobq4gSMIMEN1yBmETyWIMxpheXvZvNM33ae10G/0egGLczpePOXULG17dwULIcpb7GK59l3i8FLMyi1DkGDk8hDMU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc8bc5b-86f7-4349-b2ec-08dd5a768875
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 17:12:09.9837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aTZDIk1Xhidu4jDZ+FvLBz9mgRsFEiMSuscjb1z/wOZQsiZSG3/Y4bYRAyCxigZ3b3norJupi8khIGYVPmFoOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_08,2025-03-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030131
X-Proofpoint-ORIG-GUID: llBQBy1EiKuxMyvO0IFKsdrDan5DM6VT
X-Proofpoint-GUID: llBQBy1EiKuxMyvO0IFKsdrDan5DM6VT

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250303 06:08]:
> Place checks into a separate function so the mremap() system call is less
> egregiously long, remove unnecessary mremap_to() offset_in_page() check and
> just check that earlier so we keep all such basic checks together.
> 
> Separate out the VMA in-place expansion, hugetlb and expand/move logic into
> separate, readable functions.
> 
> De-duplicate code where possible, add comments and ensure that all error
> handling explicitly specifies the error at the point of it occurring rather
> than setting a prefixed error value and implicitly setting (which is bug
> prone).
> 
> This lays the groundwork for subsequent patches further simplifying and
> extending the mremap() implementation.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/mremap.c | 405 ++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 251 insertions(+), 154 deletions(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index c3e4c86d0b8d..c4abda8dfc57 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -942,33 +942,14 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
>  	unsigned long ret;
>  	unsigned long map_flags = 0;
>  
> -	if (offset_in_page(new_addr))
> -		return -EINVAL;
> -
> +	/* Is the new length or address silly? */
>  	if (new_len > TASK_SIZE || new_addr > TASK_SIZE - new_len)
>  		return -EINVAL;
>  
> -	/* Ensure the old/new locations do not overlap */
> +	/* Ensure the old/new locations do not overlap. */
>  	if (addr + old_len > new_addr && new_addr + new_len > addr)
>  		return -EINVAL;
>  
> -	/*
> -	 * move_vma() need us to stay 4 maps below the threshold, otherwise
> -	 * it will bail out at the very beginning.
> -	 * That is a problem if we have already unmaped the regions here
> -	 * (new_addr, and old_addr), because userspace will not know the
> -	 * state of the vma's after it gets -ENOMEM.
> -	 * So, to avoid such scenario we can pre-compute if the whole
> -	 * operation has high chances to success map-wise.
> -	 * Worst-scenario case is when both vma's (new_addr and old_addr) get
> -	 * split in 3 before unmapping it.
> -	 * That means 2 more maps (1 for each) to the ones we already hold.
> -	 * Check whether current map count plus 2 still leads us to 4 maps below
> -	 * the threshold, otherwise return -ENOMEM here to be more safe.
> -	 */
> -	if ((mm->map_count + 2) >= sysctl_max_map_count - 3)
> -		return -ENOMEM;
> -
>  	if (flags & MREMAP_FIXED) {
>  		/*
>  		 * In mremap_to().
> @@ -1035,6 +1016,218 @@ static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
>  	return 1;
>  }
>  
> +/* Do the mremap() flags require that the new_addr parameter be specified? */
> +static bool implies_new_addr(unsigned long flags)
> +{
> +	return flags & (MREMAP_FIXED | MREMAP_DONTUNMAP);
> +}
> +
> +/*
> + * Are the parameters passed to mremap() valid? If so return 0, otherwise return
> + * error.
> + */
> +static unsigned long check_mremap_params(unsigned long addr,
> +					 unsigned long flags,
> +					 unsigned long old_len,
> +					 unsigned long new_len,
> +					 unsigned long new_addr)

If you use two tabs for the arguments this will be more compact and more
readable.

> +{
> +	/* Ensure no unexpected flag values. */
> +	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP))
> +		return -EINVAL;
> +
> +	/* Start address must be page-aligned. */
> +	if (offset_in_page(addr))
> +		return -EINVAL;
> +
> +	/*
> +	 * We allow a zero old-len as a special case
> +	 * for DOS-emu "duplicate shm area" thing. But
> +	 * a zero new-len is nonsensical.
> +	 */
> +	if (!PAGE_ALIGN(new_len))
> +		return -EINVAL;
> +
> +	/* Remainder of checks are for cases with specific new_addr. */
> +	if (!implies_new_addr(flags))
> +		return 0;
> +
> +	/* The new address must be page-aligned. */
> +	if (offset_in_page(new_addr))
> +		return -EINVAL;
> +
> +	/* A fixed address implies a move. */
> +	if (!(flags & MREMAP_MAYMOVE))
> +		return -EINVAL;
> +
> +	/* MREMAP_DONTUNMAP does not allow resizing in the process. */
> +	if (flags & MREMAP_DONTUNMAP && old_len != new_len)
> +		return -EINVAL;
> +
> +	/*
> +	 * move_vma() need us to stay 4 maps below the threshold, otherwise
> +	 * it will bail out at the very beginning.
> +	 * That is a problem if we have already unmaped the regions here
> +	 * (new_addr, and old_addr), because userspace will not know the
> +	 * state of the vma's after it gets -ENOMEM.
> +	 * So, to avoid such scenario we can pre-compute if the whole
> +	 * operation has high chances to success map-wise.
> +	 * Worst-scenario case is when both vma's (new_addr and old_addr) get
> +	 * split in 3 before unmapping it.
> +	 * That means 2 more maps (1 for each) to the ones we already hold.
> +	 * Check whether current map count plus 2 still leads us to 4 maps below
> +	 * the threshold, otherwise return -ENOMEM here to be more safe.
> +	 */
> +	if ((current->mm->map_count + 2) >= sysctl_max_map_count - 3)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +/*
> + * We know we can expand the VMA in-place by delta pages, so do so.
> + *
> + * If we discover the VMA is locked, update mm_struct statistics accordingly and
> + * indicate so to the caller.
> + */
> +static unsigned long expand_vma_inplace(struct vm_area_struct *vma,
> +					unsigned long delta, bool *locked)
> +{
> +	struct mm_struct *mm = current->mm;
> +	long pages = delta >> PAGE_SHIFT;
> +	VMA_ITERATOR(vmi, mm, vma->vm_end);
> +	long charged = 0;
> +
> +	if (vma->vm_flags & VM_ACCOUNT) {
> +		if (security_vm_enough_memory_mm(mm, pages))
> +			return -ENOMEM;
> +
> +		charged = pages;
> +	}
> +
> +	/*
> +	 * Function vma_merge_extend() is called on the
> +	 * extension we are adding to the already existing vma,
> +	 * vma_merge_extend() will merge this extension with the
> +	 * already existing vma (expand operation itself) and
> +	 * possibly also with the next vma if it becomes
> +	 * adjacent to the expanded vma and otherwise
> +	 * compatible.
> +	 */
> +	vma = vma_merge_extend(&vmi, vma, delta);
> +	if (!vma) {
> +		vm_unacct_memory(charged);
> +		return -ENOMEM;
> +	}
> +
> +	vm_stat_account(mm, vma->vm_flags, pages);
> +	if (vma->vm_flags & VM_LOCKED) {
> +		mm->locked_vm += pages;
> +		*locked = true;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool align_hugetlb(struct vm_area_struct *vma,
> +			  unsigned long addr,
> +			  unsigned long new_addr,
> +			  unsigned long *old_len_ptr,
> +			  unsigned long *new_len_ptr,
> +			  unsigned long *delta_ptr)
> +{
> +	unsigned long old_len = *old_len_ptr;
> +	unsigned long new_len = *new_len_ptr;
> +	struct hstate *h __maybe_unused = hstate_vma(vma);
> +
> +	old_len = ALIGN(old_len, huge_page_size(h));
> +	new_len = ALIGN(new_len, huge_page_size(h));
> +
> +	/* addrs must be huge page aligned */
> +	if (addr & ~huge_page_mask(h))
> +		return false;
> +	if (new_addr & ~huge_page_mask(h))
> +		return false;
> +
> +	/*
> +	 * Don't allow remap expansion, because the underlying hugetlb
> +	 * reservation is not yet capable to handle split reservation.
> +	 */
> +	if (new_len > old_len)
> +		return false;
> +
> +	*old_len_ptr = old_len;
> +	*new_len_ptr = new_len;
> +	*delta_ptr = abs_diff(old_len, new_len);
> +	return true;
> +}
> +
> +/*
> + * We are mremap()'ing without specifying a fixed address to move to, but are
> + * requesting that the VMA's size be increased.
> + *
> + * Try to do so in-place, if this fails, then move the VMA to a new location to
> + * action the change.
> + */
> +static unsigned long expand_vma(struct vm_area_struct *vma,
> +				unsigned long addr, unsigned long old_len,
> +				unsigned long new_len, unsigned long flags,
> +				bool *locked_ptr, unsigned long *new_addr_ptr,
> +				struct vm_userfaultfd_ctx *uf_ptr,
> +				struct list_head *uf_unmap_ptr)
> +{
> +	unsigned long err;
> +	unsigned long map_flags;
> +	unsigned long new_addr; /* We ignore any user-supplied one. */
> +	pgoff_t pgoff;
> +
> +	err = resize_is_valid(vma, addr, old_len, new_len, flags);
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * [addr, old_len) spans precisely to the end of the VMA, so try to
> +	 * expand it in-place.
> +	 */
> +	if (old_len == vma->vm_end - addr &&
> +	    vma_expandable(vma, new_len - old_len)) {
> +		err = expand_vma_inplace(vma, new_len - old_len, locked_ptr);

You use delta twice here (new_len - old_len).  I assume this is
different in the next patches.

> +		if (IS_ERR_VALUE(err))
> +			return err;

Doesn't expand_vma_inplace() return 0 on success, error otherwise?

> +
> +		/*
> +		 * We want to populate the newly expanded portion of the VMA to
> +		 * satisfy the expectation that mlock()'ing a VMA maintains all
> +		 * of its pages in memory.
> +		 */
> +		if (*locked_ptr)
> +			*new_addr_ptr = addr;
> +
> +		/* OK we're done! */
> +		return addr;
> +	}
> +
> +	/*
> +	 * We weren't able to just expand or shrink the area,
> +	 * we need to create a new one and move it.
> +	 */
> +

So it's more of an expand_or_move_vma()?

> +	/* We're not allowed to move the VMA, so error out. */
> +	if (!(flags & MREMAP_MAYMOVE))
> +		return -ENOMEM;

and by flags we mean... the flags from the syscall.  This gets confusing
with map_flags.  At least there's only two and not six flags.

> +
> +	/* Find a new location to move the VMA to. */
> +	map_flags = (vma->vm_flags & VM_MAYSHARE) ? MAP_SHARED : 0;
> +	pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
> +	new_addr = get_unmapped_area(vma->vm_file, 0, new_len, pgoff, map_flags);
> +	if (IS_ERR_VALUE(new_addr))
> +		return new_addr;
> +	*new_addr_ptr = new_addr;
> +
> +	return move_vma(vma, addr, old_len, new_len, new_addr,
> +			locked_ptr, flags, uf_ptr, uf_unmap_ptr);
> +}
> +
>  /*
>   * Expand (or shrink) an existing mapping, potentially moving it at the
>   * same time (controlled by the MREMAP_MAYMOVE flag and available VM space)
> @@ -1048,7 +1241,8 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  {
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma;
> -	unsigned long ret = -EINVAL;
> +	unsigned long ret;
> +	unsigned long delta;
>  	bool locked = false;
>  	struct vm_userfaultfd_ctx uf = NULL_VM_UFFD_CTX;
>  	LIST_HEAD(uf_unmap_early);
> @@ -1067,70 +1261,38 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  	 */
>  	addr = untagged_addr(addr);
>  
> -	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP))
> -		return ret;
> -
> -	if (flags & MREMAP_FIXED && !(flags & MREMAP_MAYMOVE))
> -		return ret;
> -
> -	/*
> -	 * MREMAP_DONTUNMAP is always a move and it does not allow resizing
> -	 * in the process.
> -	 */
> -	if (flags & MREMAP_DONTUNMAP &&
> -			(!(flags & MREMAP_MAYMOVE) || old_len != new_len))
> -		return ret;
> -
> -
> -	if (offset_in_page(addr))
> +	ret = check_mremap_params(addr, flags, old_len, new_len, new_addr);
> +	if (ret)
>  		return ret;
>  
>  	old_len = PAGE_ALIGN(old_len);
>  	new_len = PAGE_ALIGN(new_len);
> +	delta = abs_diff(old_len, new_len);
>  
> -	/*
> -	 * We allow a zero old-len as a special case
> -	 * for DOS-emu "duplicate shm area" thing. But
> -	 * a zero new-len is nonsensical.
> -	 */
> -	if (!new_len)
> -		return ret;
> -
> -	if (mmap_write_lock_killable(current->mm))
> +	if (mmap_write_lock_killable(mm))
>  		return -EINTR;
> +
>  	vma = vma_lookup(mm, addr);
>  	if (!vma) {
>  		ret = -EFAULT;
>  		goto out;
>  	}
>  
> -	/* Don't allow remapping vmas when they have already been sealed */
> +	/* If mseal()'d, mremap() is prohibited. */
>  	if (!can_modify_vma(vma)) {
>  		ret = -EPERM;
>  		goto out;
>  	}

This could be delayed to the munmap() call, which will also check to
ensure this would fail.

It doesn't really cost anything though so I don't think it's worth it
here.  Maybe something we can keep in mind for the future...

>  
> -	if (is_vm_hugetlb_page(vma)) {
> -		struct hstate *h __maybe_unused = hstate_vma(vma);
> -
> -		old_len = ALIGN(old_len, huge_page_size(h));
> -		new_len = ALIGN(new_len, huge_page_size(h));
> -
> -		/* addrs must be huge page aligned */
> -		if (addr & ~huge_page_mask(h))
> -			goto out;
> -		if (new_addr & ~huge_page_mask(h))
> -			goto out;
> -
> -		/*
> -		 * Don't allow remap expansion, because the underlying hugetlb
> -		 * reservation is not yet capable to handle split reservation.
> -		 */
> -		if (new_len > old_len)
> -			goto out;
> +	/* Align to hugetlb page size, if required. */
> +	if (is_vm_hugetlb_page(vma) &&
> +	    !align_hugetlb(vma, addr, new_addr, &old_len, &new_len, &delta)) {
> +		ret = -EINVAL;
> +		goto out;
>  	}
>  
> -	if (flags & (MREMAP_FIXED | MREMAP_DONTUNMAP)) {
> +	/* Are we RELOCATING the VMA to a SPECIFIC address? */
> +	if (implies_new_addr(flags)) {
>  		ret = mremap_to(addr, old_len, new_addr, new_len,
>  				&locked, flags, &uf, &uf_unmap_early,
>  				&uf_unmap);
> @@ -1138,109 +1300,44 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  	}
>  
>  	/*
> -	 * Always allow a shrinking remap: that just unmaps
> -	 * the unnecessary pages..
> -	 * do_vmi_munmap does all the needed commit accounting, and
> -	 * unlocks the mmap_lock if so directed.
> +	 * From here on in we are only RESIZING the VMA, attempting to do so
> +	 * in-place, moving the VMA if we cannot.
>  	 */
> -	if (old_len >= new_len) {
> -		VMA_ITERATOR(vmi, mm, addr + new_len);
>  
> -		if (old_len == new_len) {
> -			ret = addr;
> -			goto out;
> -		}
> +	/* NO-OP CASE - resizing to the same size. */
> +	if (new_len == old_len) {
> +		ret = addr;
> +		goto out;
> +	}
> +
> +	/* SHRINK CASE. Can always be done in-place. */
> +	if (new_len < old_len) {
> +		VMA_ITERATOR(vmi, mm, addr + new_len);
>  
> -		ret = do_vmi_munmap(&vmi, mm, addr + new_len, old_len - new_len,
> +		/*
> +		 * Simply unmap the shrunken portion of the VMA. This does all
> +		 * the needed commit accounting, unlocking the mmap lock.
> +		 */
> +		ret = do_vmi_munmap(&vmi, mm, addr + new_len, delta,
>  				    &uf_unmap, true);
>  		if (ret)
>  			goto out;
>  
> +		/* We succeeded, mmap lock released for us. */
>  		ret = addr;
>  		goto out_unlocked;
>  	}
>  
> -	/*
> -	 * Ok, we need to grow..
> -	 */
> -	ret = resize_is_valid(vma, addr, old_len, new_len, flags);
> -	if (ret)
> -		goto out;
> -
> -	/* old_len exactly to the end of the area..
> -	 */
> -	if (old_len == vma->vm_end - addr) {
> -		unsigned long delta = new_len - old_len;
> -
> -		/* can we just expand the current mapping? */
> -		if (vma_expandable(vma, delta)) {
> -			long pages = delta >> PAGE_SHIFT;
> -			VMA_ITERATOR(vmi, mm, vma->vm_end);
> -			long charged = 0;
> -
> -			if (vma->vm_flags & VM_ACCOUNT) {
> -				if (security_vm_enough_memory_mm(mm, pages)) {
> -					ret = -ENOMEM;
> -					goto out;
> -				}
> -				charged = pages;
> -			}
> -
> -			/*
> -			 * Function vma_merge_extend() is called on the
> -			 * extension we are adding to the already existing vma,
> -			 * vma_merge_extend() will merge this extension with the
> -			 * already existing vma (expand operation itself) and
> -			 * possibly also with the next vma if it becomes
> -			 * adjacent to the expanded vma and otherwise
> -			 * compatible.
> -			 */
> -			vma = vma_merge_extend(&vmi, vma, delta);
> -			if (!vma) {
> -				vm_unacct_memory(charged);
> -				ret = -ENOMEM;
> -				goto out;
> -			}
> +	/* EXPAND case. We try to do in-place, if we can't, then we move it. */
> +	ret = expand_vma(vma, addr, old_len, new_len, flags, &locked, &new_addr,
> +			 &uf, &uf_unmap);
>  
> -			vm_stat_account(mm, vma->vm_flags, pages);
> -			if (vma->vm_flags & VM_LOCKED) {
> -				mm->locked_vm += pages;
> -				locked = true;
> -				new_addr = addr;
> -			}
> -			ret = addr;
> -			goto out;
> -		}
> -	}
> -
> -	/*
> -	 * We weren't able to just expand or shrink the area,
> -	 * we need to create a new one and move it..
> -	 */
> -	ret = -ENOMEM;
> -	if (flags & MREMAP_MAYMOVE) {
> -		unsigned long map_flags = 0;
> -		if (vma->vm_flags & VM_MAYSHARE)
> -			map_flags |= MAP_SHARED;
> -
> -		new_addr = get_unmapped_area(vma->vm_file, 0, new_len,
> -					vma->vm_pgoff +
> -					((addr - vma->vm_start) >> PAGE_SHIFT),
> -					map_flags);
> -		if (IS_ERR_VALUE(new_addr)) {
> -			ret = new_addr;
> -			goto out;
> -		}
> -
> -		ret = move_vma(vma, addr, old_len, new_len, new_addr,
> -			       &locked, flags, &uf, &uf_unmap);
> -	}
>  out:
>  	if (offset_in_page(ret))
>  		locked = false;
> -	mmap_write_unlock(current->mm);
> +	mmap_write_unlock(mm);
>  	if (locked && new_len > old_len)
> -		mm_populate(new_addr + old_len, new_len - old_len);
> +		mm_populate(new_addr + old_len, delta);
>  out_unlocked:
>  	userfaultfd_unmap_complete(mm, &uf_unmap_early);
>  	mremap_userfaultfd_complete(&uf, addr, ret, old_len);
> -- 
> 2.48.1
> 

