Return-Path: <linux-kernel+bounces-435752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A291C9E7BDD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45205188814B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D341F4727;
	Fri,  6 Dec 2024 22:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lp93K/Su";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oHI5iSSF"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A750D22C6C3
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 22:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733524857; cv=fail; b=d1t4AnuRdrGsKoLZi30koeH0+ICwbBcty9POj01bzSpSrlsHcbVSuHxc7RJcz7wA0Fx71LI70pY4cQNEf10L8ipW4tJCxynGBJgdKrzKfGZ7AHS0F74BzgdWzaxTsvis8emFdPVRI+fzJdUxD9IJBEPgpQmxNQGxmNs+s0PkI/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733524857; c=relaxed/simple;
	bh=2iRdOLWEEL79WnY6OMrH9G1VkCn5pT5RiwvbgyCOeYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T9ItHSDjcsDnagoimTJUTWvJ6iJxttVSISmZhsRxZjSe8zKza9txNa/ep7fmVW7Vs3fwjkl2E2lcQG19l4d3TWnWXQR3jNV56qi6fZ5y+kaAbIsJVveFj4DRYLrMlKquKT+C4Cus+eLbaRcuoYU+cl3xPdQg3g7eNQe6pwY0x8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lp93K/Su; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oHI5iSSF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6LXM38014459;
	Fri, 6 Dec 2024 22:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=9dqehDI+dl9y7YRKHf
	5VGQGPFaTl9FX2CX5TfifICFQ=; b=lp93K/SuhkpCVnbAgruJuTk7HTRwEgko8J
	bsmGl+VNptLbF5IyGShq2Y5JHsCagaVynYB4e354tUUO5kjRVKsrSsqF2NA1cLcc
	u2Z8ohMo5rWzxN4PnmiXk95yhym/JZkIJYVCuEntWW2R9fIqYNnDjM/3bnj/6YtS
	JtSehEoDIFQn2DXo5F+8zup+CdmZTC9vt8Qcvc/2/DoFA+wLv0G6HtDYJR1+CtqN
	lYsptSlfY61rO8S2B14fAeBVU779aHqPn3pSpShJn6xrAtHpk/FdNhVg2dScb31N
	5bBvUqr7gX3MuJun4jEy9/QHzKokW44WWdKU8Id4oSeB2RBx7RWQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437tk96bfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 22:40:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6MO6lt020107;
	Fri, 6 Dec 2024 22:40:44 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437wjhfupf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 22:40:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y7HfmJLh5ypAQBnE2KqfxQSYNawiFek9U/kTyY7A/54HGeC07dRwlwcn+9GTvxcEudIcYFzRc+OmRFBUOR32VhnFoTLNGv2Q/erYQC8HersG/IrRAAjdwRqUFCkAg3ncZSWNFa5QvkQG5FNA3MYq2YXA31WUKe5XuQrsYDkh0Q2LL6djIguKmJO+Cv3qZv0gQw48pFdV566qYYH+F3HU7T5jnX/RZeFniFDPXVLNG+H6iAWjIYm42Ls1cb7yPiv7dR3Ijgpx2/U0zt3+I5rFe2Te0Rw7scEmGOsAe9Cp0+ur4N6apvVzZeVu7XGi0s87LBOXxQUwOvd1OPbMZxIjfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dqehDI+dl9y7YRKHf5VGQGPFaTl9FX2CX5TfifICFQ=;
 b=HqZC/auG/bqvJsF22V5v9aSWx00HU8Ns4ArplFuLvaz2H37hjbB4qhnrj+TO0vhhMWARtaow7dmey6mob94tQwbmMu1xq+L0uexCqNeampdHKHWcsWkj68Ove4yKSdTs4qUKedk7DNS6ItdZg3osjY3UIpUOWPMfbS587tC1VIXJ+wHlyqRrsCDJygw8diWIeodAgkWaRfOb8CXhXBY7hH/k83V2OkeiQO2NOkon3Rhs8deZcmyan4AjFV2j231I58xOTj5Oous9Q62plaRgsrQbXoKW+Ch8gKrI0AZunTPAPyJPh9KXqTNeVhFr4HrOEn7GOCW3sYl/KizoUj8I5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dqehDI+dl9y7YRKHf5VGQGPFaTl9FX2CX5TfifICFQ=;
 b=oHI5iSSF81i32VBRv72HQGyoYKXuQl35kWjahIjLeDyG3IyD54N8enouynZ6yqvR79wBuwfONh3MXkJI/StRvB7hu1LKFdr62jzAlVl1bLVtLyFdBCPhKG1z0bpYXnxiOOQSmU1AuQj9ovGKkBxftgSLB4x9Z5fykTkIgXozY4M=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CY8PR10MB6467.namprd10.prod.outlook.com (2603:10b6:930:61::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 22:40:41 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 22:40:41 +0000
Date: Fri, 6 Dec 2024 17:40:39 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: correctly reference merged VMA
Message-ID: <qvsozunpi4yvooov4usji4xu3v2dt52f3mxcwkwtdcywu6xpgb@oald6acxjrui>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
References: <20241206215229.244413-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206215229.244413-1-lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::33) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CY8PR10MB6467:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e514748-9441-4f1f-6275-08dd16470379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?++qb7/NlkLV97XHdh1bSL0ynmN5U1o7hNWMlCT6DbhwZP8pAjVYAiWPPnArH?=
 =?us-ascii?Q?dVUTeQq4W99m+5SFJDIlxICvyXFCh84K5j/6pIfdyv3s78Y6OIsTRSfzSuky?=
 =?us-ascii?Q?003lRAvuEooxMqYr2RVpQu59mP5tVm4TqTMqTSwemf8Ldmr165HH+dPo8A8h?=
 =?us-ascii?Q?Djz0ptsyEXIsns4XU/TQEUL0GmmZsnDODHGULRnkhPLC+CwJtGvNX+yeTLbJ?=
 =?us-ascii?Q?zOc+JOXokcDxW7eN/+IYtTPU5WKQEWgDRtRqeYc6/2wzLcyiMaPfay5XdTOo?=
 =?us-ascii?Q?+/KyVmzbCo2IatUHhoyP9RxLSBUPeucj2YM35pCbk3Y+/h/wtY4SKDt1/gan?=
 =?us-ascii?Q?a1GB2GIy/UwgYAbcu+NzWGpqF0avM0+MYnHpeeX/cmpu3SKgaXOxSoWpJhGN?=
 =?us-ascii?Q?n1N3OiYeCSFsLLmqIZ+x7zj2/9SORPqcP5PV0Nlf9lonhhisaj3z6L0f3Yxg?=
 =?us-ascii?Q?HUutHsq8Bv8Kxd1RDXq4O9XOKZRy9p9jubTUkAhm66Efikp+5OACr1hCgc6P?=
 =?us-ascii?Q?S6Ug9J4//2YN3ymVdb2tG4l/CKbOLx5TOR4tCf47iwzFP1c0waGEfN7eeVYm?=
 =?us-ascii?Q?CxP/60jw/9GmeWOtI09C262JLVEqbOFgdSbloNSWgkSacUzQLf85YvagKy+B?=
 =?us-ascii?Q?swxH/7c6zZhlupKS6d3TX9Z67oM/ccJUCUv2xZL3Q62aS9bKoN4sCz2BMsvA?=
 =?us-ascii?Q?spjOhwL9N2KKfwIURdZB4vn+twQntVjA8RL6RfU+cD0wUnXDU7LJ6bQbHVzg?=
 =?us-ascii?Q?WXW43lVWQzDj7B+auVuMGggReJq+7uC8M467mJFWaqh4neelbLigkNx9taPW?=
 =?us-ascii?Q?PGa2oOZ2M3nC2AKtwG+W7R7fMSWwHXLRZCJ3fuBjKo8N0gVLYdQEvDaRSZYW?=
 =?us-ascii?Q?ckB015C4H5KSEPpKKaRLDQ0E7I1eXDojAq4SsLD3aFgKkpAYWjrOJn2leZlE?=
 =?us-ascii?Q?gFyPbVwAO83tWElwPtx6afaWEze3lonmktlMTI+ChtgL6jx9+YiNXFfNiMiP?=
 =?us-ascii?Q?4Lvxdxd7E36ejEdSCzIdbezLr+oVENwmUAxdsU28bHee3j2U7sSg/TxFzorr?=
 =?us-ascii?Q?b2UZzGnxcDfgcwYva42TClanCgZPzoub8C4lnvQcxBTnvZ7vy/gsPu4/evQ6?=
 =?us-ascii?Q?Wrpsi7zEamhmadvO7Sh3Vu8GWxo3uplB0yaP4yS8VRvZ4Bs47HM2DIIGbriP?=
 =?us-ascii?Q?99g1ivhuli3pOtMBEB5wxvfVEYXqyRhpe66gMQMXqOtQF31WddyG/csT9Fng?=
 =?us-ascii?Q?DKjIk/thaOhfkUplKYGhhudqNYIvxhj9+4nDb/qwX9zh/d3KcV0j4gNSqHHj?=
 =?us-ascii?Q?4iH+v+buY1y73PsBZbqUuI8BkAVOt4V+p6WtpECrelQXCO3fmgdCd06//6oA?=
 =?us-ascii?Q?gj5hVRM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IiagbA/yEcz/mGiooQl4OTcpusMEUJVvzWaP0P0l3pxOssPX/x8x013JVnW2?=
 =?us-ascii?Q?eAmGgSzz3/3np714qmQhS107PBVANkWvTrNA5syQFUXtfwwb3z0m9UMMBA0C?=
 =?us-ascii?Q?7BlWInkQpfX44WSWsmus2l76VbbZFDhd6bdnw793xRmbsLtXSGl+wh6ytHeB?=
 =?us-ascii?Q?u7krnoRjVePSKGAcLgbciQJx03fSgBfg45h3XnOCWDggPvHkw9dREBN/jNVf?=
 =?us-ascii?Q?oiFBTVI4AyO0zjuvCZvWgMIiwpNOuA2Cr3QuyLHmTaZFgXo+Bo6xAzl6Lgtf?=
 =?us-ascii?Q?n8onXRnzJ2Bf/oArB1tXCoayUHLwWB/gHfxRX+vtwJMgw08suJ5NKiNDjCUc?=
 =?us-ascii?Q?sO5CuMoF2kiMNh0fye4Bq90JBqw9aNhMH6wkK8T396lcSTanLMgsHTBGaWgJ?=
 =?us-ascii?Q?26M7MIKlqIu5bV+uFRJPBWkDVzCrKUazK9T+aoRo8ShnjusiHVuTha3PHsRN?=
 =?us-ascii?Q?LpW2mS76coX/zAf1BYb2ovgM1fKZWjuelHnOvLKON9UaEeqfPn53xSU2gE7T?=
 =?us-ascii?Q?wmASaoQPcu5DxNirBkqA1nZwueXDbT0GXqDVkz64C9K5+dv4KrxVqmrYXzPJ?=
 =?us-ascii?Q?Pkr78Ki77nR0Fdw5utaC3ws//FFm16ncnUs0XWIFokn9cIDvoaGgBf72bXg1?=
 =?us-ascii?Q?Ij2aORlC8qyORYj63RTRRV8iprJdYi51dPLugVDRdJ/vG3BlC4DhLCA7+DLk?=
 =?us-ascii?Q?nnjC6cTTGppk+K8o7p83pskUyWf4cto3zo/5+Sz8pHaTmxNfoyx6txHeghMr?=
 =?us-ascii?Q?dorKe+dimAtf979wPbBPuau0uJBciX52JIOSlcYu3EmHX/Tfhmf9r/V3hdWC?=
 =?us-ascii?Q?yvfD9euI74eTWMS2WVbGNE8A73AUCdqnh9YjtXp0N1UHfu5d4XRC1TmAKh+s?=
 =?us-ascii?Q?KOMtgy85vKDUElwSpWAEQQx3F0VRdwHMwQik5MHS6wLGKwHNG55fM0qEEmB5?=
 =?us-ascii?Q?GSrIZgj5PP40SvasTbQf60le75jUKzPjmZ4amS+fdjYePq6qLhaA8Go5HqS4?=
 =?us-ascii?Q?N3a7ukE9kRULbY9ZOxyFKMj95MbHshoZFP6gJv7QczHxI9cGwpT5QriFKU4y?=
 =?us-ascii?Q?7Ou8jvg91/xRZec+QSHFcgwxBUyz7U3LqPTFsKwzKk0KnnjC/euKY450NOg2?=
 =?us-ascii?Q?nRhOuWmG6f7WuYrWhRI9I2eQyh2Cz/Hgo24SOe4YHVRduaQAoQroF0nZayBs?=
 =?us-ascii?Q?Oyogoq8B5lcmwkaUupqSvNAlHGthaABRPfUpwEHF7CsCwcd8BKG2HaCdWZ1v?=
 =?us-ascii?Q?Dnw701r8fmHzXOLfHVkBscJAhcrppNqduL40MDjGTKPRqjHYekJ/YKNZ18qg?=
 =?us-ascii?Q?9ZWOKfOJ+U9i8t6dhBUljHEf3Ki8KT7AjwQnf19OK+rl3GQ5TeW+cNRPF2CG?=
 =?us-ascii?Q?96Ry0S+i39/XVTQD2/Jq0TQVNMlc8s5GIiJdSvqVhxguoCGURhTYY8QPSZ7P?=
 =?us-ascii?Q?hRAPB07QDXHPTrlN84rD+eSxl+0TrllcbMbJiLfNDaAGdlW1XtOyXBGE9Ag7?=
 =?us-ascii?Q?CTKE65v5proo+BZB+raaZmFklEYnoV+a3hX7RCU07gbo3uSAUWBNwIBPFySZ?=
 =?us-ascii?Q?mQkDBdKMFe0KhMN/97f9thCrTKw7aiyYWUe+1BB0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xeQklcDuekiVx3lZnhLIs+zQuIwAvzAv2tUzlsklQ5bnj3IGc+hfdfNhnMJdKojlh9VqROaLO7oDsWBeIsKfT2ItnUWCnJ8+1sUmMy2E1q7/RYSktfCVjVQW6pbHn8PYfIPr7Pzbx5bt9tyyOhVNfYFPV2sjjhl9edD4GG09/F661FwT+d95FeLf22o5LhlXgDaF0tyYn6rFCd9468cdAdXTUbAI1eERFz4t35ODYurTmyDj1JxnEpcog98qY09gqQ9elxeeHBKlCtSwTqdESXCEx7XHCo8Z1Ixxfa+Fug0JJ8Yj9GUSQKtI5cDJ8rVMgosI68DT7MSCJx7tFTYewM0xSPSxB8RtE0vi9h1JFz5KAUhM6THco0RaUM8sVdlJNYIbPoyizGQhKXaq9/SDDhwlG9xBmjxIA5jckT8NtuwnKptOC7VjD5vIamqlRz/TLGY8ziDNvQAaao5sCpVAvPQfGwtQZdm7ko9MVt4TIo7Nrl0It99Acx+iraXLJBSUXwQyfug5kkgoFZdWoGwlPR0bOESuy31wtJQwyg8VbU14q1zX5fpQbW47c/T11IojQJytv5lE2/hvAlf/kyF5faCd5wDmnm62rj+d7cRX3YQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e514748-9441-4f1f-6275-08dd16470379
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 22:40:41.6097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xq8WOQMY2SuKsUuoTzY0JRmOYzi8dfTRCyTMBBhJq9VpKGcYzXKdqqLIAnCwIJBodKI5Dr6qPg/ZideW+uljpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6467
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-06_16,2024-12-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=939
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412060172
X-Proofpoint-ORIG-GUID: j-SnDLhAMpWYIlYtfdjiYiGpVM_aj3xI
X-Proofpoint-GUID: j-SnDLhAMpWYIlYtfdjiYiGpVM_aj3xI

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241206 16:52]:
> On second merge attempt on mmap() we incorrectly discard the possibly
> merged VMA, resulting in a possible use-after-free (and most certainly a
> reference to the wrong VMA) in this instance in the subsequent
> __mmap_complete() invocation.
> 
> Correct this mistake by reassigning vma correctly if a merge succeeds in
> this case.
> 
> Suggested-by: Jann Horn <jannh@google.com>
> Reported-by: syzbot+91cf8da9401355f946c3@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67536a25.050a0220.a30f1.0149.GAE@google.com/
> Fixes: 5ac87a885aec ("mm: defer second attempt at merge on mmap()")
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

My cries to delete this optimisation continue.

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> ---
>  mm/vma.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vma.c b/mm/vma.c
> index 8a454a7bbc80..1ec349141f5e 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -2460,10 +2460,13 @@ unsigned long __mmap_region(struct file *file, unsigned long addr,
> 
>  	/* If flags changed, we might be able to merge, so try again. */
>  	if (map.retry_merge) {
> +		struct vm_area_struct *merged;
>  		VMG_MMAP_STATE(vmg, &map, vma);
> 
>  		vma_iter_config(map.vmi, map.addr, map.end);
> -		vma_merge_existing_range(&vmg);
> +		merged = vma_merge_existing_range(&vmg);
> +		if (merged)
> +			vma = merged;
>  	}
> 
>  	__mmap_complete(&map, vma);
> --
> 2.47.1

