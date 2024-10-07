Return-Path: <linux-kernel+bounces-354153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 091BE99386B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 22:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9323285382
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4BB1DE89D;
	Mon,  7 Oct 2024 20:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZQkr7DN0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uFl6aj5q"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1C51DE894
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 20:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728333582; cv=fail; b=tK8aMVqK5FqZ7LPDnefVtu+DMC5iJuqTIplPVaxD35NVIkYx9V9NlkP8X3TUFIHB/VIvlvWjfhKsSn0SsCql0DbipR+nGWJJbxosdxv5JN0P2p5l9OsbNwsvxLvbspF578ZElBCw8HMHhMBgci9LJECSX5Cb0CwlmEEnEJaWkn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728333582; c=relaxed/simple;
	bh=TBg/oLVDmM2D3zAO6CSOLwInyLCmaGuo7HPQz76GxM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZR2FDnoFTV0s2dnuovtnGYWzg/Jg5iAzKkeVBpTJDfGXiFF0gYa9dFZU8ZO5bGwnc7D2UJFToBqrCYhEwagZa0aAtPx9VcjvsBPPmZgfYJzhYtXOfA/iivdPJcROfPi9FWfju9U8ld6Xk8lndJgCYRHTL+iS6NsNJwOLwaMxpe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZQkr7DN0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uFl6aj5q; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497K0alY031793;
	Mon, 7 Oct 2024 20:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=hlDkIENRnzNq+C0FeL
	7HeORxHKS63QCKYFW3B3lagUU=; b=ZQkr7DN0ixzWeM0Ryyx8AEgeUYiulTdze8
	blI8CRuSn5BY3+0ZNXZ2Sl6PHvdFZrzGdhXyuHa9rRGTvDI3k5mvQ0tz6gnghnWF
	wrGKYTqr51xAuTrJfbA+s1GmFnrIplCIg09wgctJ3ygEQCplgWCFR+/llXIiuc/P
	uXgg0AfOgiwcpegB28ns3KkIs9SOMqfsCjhFYadtslTCBtehlX1lYkSAKwFQd4F2
	X7hMoet17xVqZombjsFk9cXiyIkEv1+ezYIu8InEiGruN2bNS5znDPA1ZcjXbMOY
	21Sfcl+H2o9+6c30XH8V4DUkcLM3AHL3mCR/q+oa5k0OaIhL0GgA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42306ecayd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 20:39:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 497J0v1W012067;
	Mon, 7 Oct 2024 20:39:26 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw6a5fr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 20:39:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zlr9tUVl0JKrpbsEYcyVU4vf1z4ugRaN4CH/h8T4/VRajc95xl1LLMkF8H4NYeNBPnlEq0EPjBjjT6gj3rCr36YQGFuQryTMceC3gte/3BmTjC+tmJB8OEcJ7TrFbseV6pEavMKRfUbqUFXhbtF26xlA5JWHAgd5Bl0peTSUwm2cc4AfdMwFTbBfYLgl6o28YZOwGjOwzmN1NtIcD6ZT67Iv5HmUqgEd61n0QJchvcIFwJD4UGfK1IMAEaRrIGk6oxs80WQfe+mOKZrNoNFy9FKthqCJldVbOoYMWUSNaDtt0O14NKyN1B8qGm7R9Zs8Ab2jsJ1DvMB1GPVsxzFS5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlDkIENRnzNq+C0FeL7HeORxHKS63QCKYFW3B3lagUU=;
 b=VX9lWMFVtthn24DEE2zePgSHVsoHcYXpAlAzH87JSDK2Bmx1s8TpIv2qXGZjR4ag9NbZ37UpX1idV2YfjvWco7UJY+qR4gACM4AOsSwnUfPggL1+iZs7Mysejhb0SnF59UIjufRGaRCGcdlx8ciZueOmq1Cdx3vrotgZw7EjWYDNVPmiKimr0ttIET2y/fMrCiuYDThQ32ggB4+ZO62S7iRWUhLXqYZydkAo6UDnhqo8CujDrESbejgW0veHq5NtmRReUwhgoXOk9FnUu7VOczE8W6V+CkTSeUIDyZh+h9WVUxZUfSkPEa/JHxDAuxjZVNDF6ZSfcL921b9Atw7KXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlDkIENRnzNq+C0FeL7HeORxHKS63QCKYFW3B3lagUU=;
 b=uFl6aj5q2qmQ2CSXyMh/1FZwjxLRVhizbxZjAiJ/j7WQvdkoCx8FdAX+9yIE1GIVKdo5dQlc3CYYxbDB1eR1W38xtHNUi9S8Tbc27ZBWlMcfUTtOlX/g7pXy3e86CdLB+Shee5dyzJ5cZ+L0Kn4V2UtrCk7fvqHM5L74nt2yrrM=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by LV8PR10MB7847.namprd10.prod.outlook.com (2603:10b6:408:1ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 20:39:23 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 20:39:23 +0000
Date: Mon, 7 Oct 2024 16:39:20 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Bert Karwatzki <spasswolf@web.de>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH hotfix 6.12 v3 2/2] maple_tree: add regression test for
 spanning store bug
Message-ID: <y6vps6mz24sccrbszehz4i3abcdv73yj6jxflbjoz3gcatbbaf@24btpbtw65dr>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>, 
	Bert Karwatzki <spasswolf@web.de>, Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, 
	maple-tree@lists.infradead.org
References: <cover.1728314402.git.lorenzo.stoakes@oracle.com>
 <30cdc101a700d16e03ba2f9aa5d83f2efa894168.1728314403.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30cdc101a700d16e03ba2f9aa5d83f2efa894168.1728314403.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::24) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|LV8PR10MB7847:EE_
X-MS-Office365-Filtering-Correlation-Id: 2491018b-3087-4186-7f6a-08dce7102091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Y52GolnJGBOpVJFIMatuSCp8OoX5PFXDT7/vWuIXsw0FbZ5guMfkLIRlZk6?=
 =?us-ascii?Q?MXV0WNaH1xOZdOzrwFAX8a9ioJFgjpLVmPOr4/7bM8Q2W2N7LUzuw12kHpJB?=
 =?us-ascii?Q?Nx8ru7xKWFQHYVuMMcO1Tii6BtN24NicZqtWVqlkrTyTcH0wlqLr7AfkcUsH?=
 =?us-ascii?Q?phMtNfMQcUiL8PVydxpdZVCppa25A262cvJKlVleo7uFtNdkGgaFlO7CNa18?=
 =?us-ascii?Q?ynYuUJlrSuDZIZ7Hrw9wyL33qEAgmip0JIOwJklvRCLu/lsWTTUwOZdCNZgS?=
 =?us-ascii?Q?9t14dx9EMeB0Yo2AbFmf9duDiFH4eorGfYAqq7r50inFfumflR7WxUxwBEbO?=
 =?us-ascii?Q?c3npToLEbKXbjeuDkm5S1LyUHvqzWDd6JyqVNWWomJXVODJpTNenaGFHQGk1?=
 =?us-ascii?Q?JYDGutfxTNsr7zxtOXA6MQLyQ5J9a6Lf2AiCAxDj0M06XdmzOJ9Cdj7+nw4V?=
 =?us-ascii?Q?JdokFkeYr9bTo2lHKHRqz0Z3nFtjUWD0467FwBCqBsNWTmNFKoJtAN4bBTD9?=
 =?us-ascii?Q?+M2sW1YYwbVOswtUzDEWTTrjTk+P+aD0Q/CLXu4fjl9MvWNI0PlfcN3JaHFm?=
 =?us-ascii?Q?gIEc7MCPPVHoF6ShsHxMJ1BD6Gp2ROBuXR2okCs4i+B0n4PgRmrUfd+JFo9A?=
 =?us-ascii?Q?jrORPBzHmhHog1MTpRz6tt4zNK33ghzs/IweM1gGVstC+z99iei9SO/qmu7o?=
 =?us-ascii?Q?4h1Ky0sSiQteUqdIgWhGKTW+KFTt+7zyKj6nNgBwCQAD6QeawWHivThcab3L?=
 =?us-ascii?Q?/IpKSvzvmZGDjGUnthqt278vDMO3r2A8OoXN3oYeDOjGD8fz0bVIGBMg9Eg1?=
 =?us-ascii?Q?tZVGLK/RRABoWBtUpHoTl6vunZZXD+YE3WRNCxdgRApLDdF5mUBcB7fqLmus?=
 =?us-ascii?Q?eoGxZPghqazQ4jtnE8zvnUBpR6veswC5wrppoCTCiCTwwLIOXBXNI3RIs/a1?=
 =?us-ascii?Q?za2U0gnMS/43hyK9LxMhmeww8LrRmiynSYnY45PVr2Qx7qafvgy6+bWuJ496?=
 =?us-ascii?Q?wCr+XNBGhEg7PKvQ4eB+fpzBzAt/K3Ln/k2nYg9vMq6a00HGAj5MHmCiwrCg?=
 =?us-ascii?Q?GyJfxH9Xd4zexo77qLzutFaK3xBcAH6TxwC2Bb60MphKsxEEaqmh2bFuyLCC?=
 =?us-ascii?Q?o6SzBQ7Q0ADrho1KMUtFlNT8z6q/Xv9oCM1QyECPEUlG+fcza2eIESaIoBBR?=
 =?us-ascii?Q?XcmP+AMxARDuXA6DC5K/X2b8GTM9veiPIT54rHzWLgO7tlL2/znSjsLJZ4XZ?=
 =?us-ascii?Q?Vb7UAQ/ExhAQYP1ZM0uF2SDPIHBCCIgUM0kUVkeUgg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J+vc9DoCv3yuMo7idh0dAkv3WtloYYwKvr4S2CmKozwcgWyq8DeCJLFsRLxS?=
 =?us-ascii?Q?DvuyDlwCSh4lWs73FuP2LeNK//8EM7GiYpSrEI0IHzdG+rTyVxUyKzZ0yFbH?=
 =?us-ascii?Q?5/acvhjH6rstLtjPE2rZfaVYiCFEsGAUpoMjM4nvr3R0UKJA4EPCyffYVa6B?=
 =?us-ascii?Q?ONWGmjDqbXxhVDgsf88zNLOcVp+QmvAYifFs5dJnTn/PvLg0atKvD738oE38?=
 =?us-ascii?Q?FShu0YfX4U4+6XhKh5EVXkQmCMZDTKx5uc4OQ8TdZJR8s81Rh6ZP5JC0FlTo?=
 =?us-ascii?Q?L6CIIhqILgYsjnPew42/1F5K0gzpigqOtcMjZ7nnyca9SW3Rr4DVNjxbgees?=
 =?us-ascii?Q?Xv42NlCzOdVhuQCwlA3T4S1miiUyUBpP8BYGpSbY5poWrd/P9VH7ldEsaWmH?=
 =?us-ascii?Q?rAI21NQRe6RTW7GPuKU+ZD+n3uxJrFT+T9MQon4OLKVxUvjA9iGwd4Z/UQJh?=
 =?us-ascii?Q?hS8lWww4ZBqe+SP52KZXKr3Ucmh9dZwjk3Uk9Uk5BN2OFl3stJhgXTYatw+g?=
 =?us-ascii?Q?5/6tCbNVdelGI324enx33gVsmW4kVkzdRBp8pfXgDx+U7uZfLtJ/OTqAZYZM?=
 =?us-ascii?Q?PMOGOgl+f6hYZn6ISx2IYv6rmavrZL+Pg23n2anpf3ynlYEdplSRZY3L1EKV?=
 =?us-ascii?Q?1pw6Uxa8A+PYxrg2y3MJTzUGbRIVSbYrG97SL9DGVIw8CtxhwUEjNLubmW3J?=
 =?us-ascii?Q?WN5/ACPoHd5QXlQ/CziUlHVxRecSGKcO9h97e6FpRaM1gM2SGM9Iwvn6UpXK?=
 =?us-ascii?Q?f0QwV2BWiVs0ffv56JKS8o4oIJaIgWr8C6l9HA/X4U585IQXqnD+GjVXpKLd?=
 =?us-ascii?Q?jpKOGJnx+KwTarGf0PKgFquueuC0GsA9aI+EzPZVt4NF1LojaURtggcGI6FY?=
 =?us-ascii?Q?ReHBHvtmbkNXAeHH3Z+WOwQ15+zq4am8CwTaya0LQwzqteY9UoFfiYkKk4I5?=
 =?us-ascii?Q?TNkirPOo+VpkVeO9GotKTSvQjioT7sQ7uIiVXZ+UzXrKPcUhBTsQAkNf2AaZ?=
 =?us-ascii?Q?R4lGcCBFql1VE7bWk3PoVcHvvFSfFLFJ/GzDB+TSHsTJvQ7htZw8v/tVSx3s?=
 =?us-ascii?Q?jabGsTjYxl24tw2fO6nbgKrt+IPTG2aNCykZiwCxDGKDUtLlmySuTi+PDfl4?=
 =?us-ascii?Q?7F3YO1I1BfvstENxJzp7xnf092qXEObjtiiq+1rvRDjdt6TznESmK/bgYM2f?=
 =?us-ascii?Q?+AlhGzbLjqU028YzEZUJP9KFJrgfcUh6AK12zcfQ/+CT5KhAOcnnut6XATzs?=
 =?us-ascii?Q?NYgtOR7/XQ8fw2imIbKktRtMpkM4DY90eOk/FWw6bUsCLMxrrAWRbmnUeMHq?=
 =?us-ascii?Q?x7hGLduI1PtEpaGZl/nB49bJdrIJeMqO50VWfHz78nPAi5B8H5LUwdfLvTah?=
 =?us-ascii?Q?q5NkkL8/B07TMkGSH8qdymIIYvgcj18aH6ln2TfdvY/hpRoxtmVzQSGW9pFZ?=
 =?us-ascii?Q?KWZhwkrOFdqKLKh4cEg1gOIbPz7HJoqLSRW80k0TpVbePquWJuknC73xI5T9?=
 =?us-ascii?Q?j3hyGEGbn+LH3rnhKj7L+A6oUZVAAKl6efyt2FRoRFp4Dip2/hVnO54ERZqA?=
 =?us-ascii?Q?rxkKGcpdx9MvlZdGThqKQ4Cy02w/hxwsyyRbSqJT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YY0pj4QAlDiXMzvvbVltcCeDrvZdEu083ikeGm7PH3T2DwhM3bFAfUMlMx/SRkGEndUa8STIgf9LIhsHnsDwfdMzOSXxx5hg5HjY5TAfF4iPzD83kvaAlhfJm71GuDQ/l2w7CjVoBVEIuLEx6imjb8P5qWZvTss82NvzJeTxElD1H3OVFikv5SXwLzQMdGolMsZVv8h6fxRDUjpHGNNLHNRvUTmO8Ll8AeBye9eBqPVlytA24YPlbSpAVtreE/vnAoFpqPzCXm6D5a2cJjfykBFtlH6Iowofv2LTg59ERsnwHvGvtSdi+pbDNYe8YAyim8KE+UW9YVhV20J4n4J+c1927hDZvC7iZywf1T7EY8MTou1MV9z0k8UW2rGqDl31+NpBZwBz7xXgYYrt4YyThB/Piq6fbgwn2sl8qvVkdXauoRimmptNDxR/lNUFzGN6f+A3Eh3huyRItcCvO+Yo7IRP2Savkxgi8xkVmHEAdIcutz3t5KliWG3AgwRRiZZ5XnZv7n6xJ8qHFAbm5CLRzdXGBECxv42wqen24iXpnLE7+5toqztz+rrdX+mg0QO17YVg7netJ05Dm2zMY6tByOHALtRtt6JE5u0vtgIfnFc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2491018b-3087-4186-7f6a-08dce7102091
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 20:39:23.3300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3x+KM+CW8RSP+Cw98UXJbH0qegfexZG8WcndnpKfyzMPQpTLTlDcOktfHCJE9inAboF1jOjhk9sx56s8vaRpjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7847
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_14,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410070142
X-Proofpoint-GUID: 4uZEgZ--edfJmaNb0EBjwGuNx7aZAMBZ
X-Proofpoint-ORIG-GUID: 4uZEgZ--edfJmaNb0EBjwGuNx7aZAMBZ

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241007 11:28]:
> Add a regression test to assert that, when performing a spanning store
> which consumes the entirety of the rightmost right leaf node does not
> result in maple tree corruption when doing so.
> 
> This achieves this by building a test tree of 3 levels and establishing a
> store which ultimately results in a spanned store of this nature.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> ---
>  tools/testing/radix-tree/maple.c | 84 ++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
> index 1873ddbe16cc..5fde09999be4 100644
> --- a/tools/testing/radix-tree/maple.c
> +++ b/tools/testing/radix-tree/maple.c
> @@ -36406,9 +36406,93 @@ void farmer_tests(void)
>  	check_nomem(&tree);
>  }
> 
> +static unsigned long get_last_index(struct ma_state *mas)
> +{
> +	struct maple_node *node = mas_mn(mas);
> +	enum maple_type mt = mte_node_type(mas->node);
> +	unsigned long *pivots = ma_pivots(node, mt);
> +	unsigned long last_index = mas_data_end(mas);
> +
> +	BUG_ON(last_index == 0);
> +
> +	return pivots[last_index - 1] + 1;
> +}
> +
> +/*
> + * Assert that we handle spanning stores that consume the entirety of the right
> + * leaf node correctly.
> + */
> +static void test_spanning_store_regression(void)
> +{
> +	unsigned long from = 0, to = 0;
> +	DEFINE_MTREE(tree);
> +	MA_STATE(mas, &tree, 0, 0);
> +
> +	/*
> +	 * Build a 3-level tree. We require a parent node below the root node
> +	 * and 2 leaf nodes under it, so we can span the entirety of the right
> +	 * hand node.
> +	 */
> +	build_full_tree(&tree, 0, 3);
> +
> +	/* Descend into position at depth 2. */
> +	mas_reset(&mas);
> +	mas_start(&mas);
> +	mas_descend(&mas);
> +	mas_descend(&mas);
> +
> +	/*
> +	 * We need to establish a tree like the below.
> +	 *
> +	 * Then we can try a store in [from, to] which results in a spanned
> +	 * store across nodes B and C, with the maple state at the time of the
> +	 * write being such that only the subtree at A and below is considered.
> +	 *
> +	 * Height
> +	 *  0                              Root Node
> +	 *                                  /      \
> +	 *                    pivot = to   /        \ pivot = ULONG_MAX
> +	 *                                /          \
> +	 *   1                       A [-----]       ...
> +	 *                              /   \
> +	 *                pivot = from /     \ pivot = to
> +	 *                            /       \
> +	 *   2 (LEAVES)          B [-----]  [-----] C
> +	 *                                       ^--- Last pivot to.
> +	 */
> +	while (true) {
> +		unsigned long tmp = get_last_index(&mas);
> +
> +		if (mas_next_sibling(&mas)) {
> +			from = tmp;
> +			to = mas.max;
> +		} else {
> +			break;
> +		}
> +	}
> +
> +	BUG_ON(from == 0 && to == 0);
> +
> +	/* Perform the store. */
> +	mas_set_range(&mas, from, to);
> +	mas_store_gfp(&mas, xa_mk_value(0xdead), GFP_KERNEL);
> +
> +	/* If the regression occurs, the validation will fail. */
> +	mt_validate(&tree);
> +
> +	/* Cleanup. */
> +	__mt_destroy(&tree);
> +}
> +
> +static void regression_tests(void)
> +{
> +	test_spanning_store_regression();
> +}
> +
>  void maple_tree_tests(void)
>  {
>  #if !defined(BENCH)
> +	regression_tests();
>  	farmer_tests();
>  #endif
>  	maple_tree_seed();
> --
> 2.46.2

