Return-Path: <linux-kernel+bounces-315767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E9996C6AD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADC98B212B9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE40B1DEFCD;
	Wed,  4 Sep 2024 18:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hyh8cG+q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Hh/kwcgU"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E26841C6D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725475694; cv=fail; b=MhlUhu5CzvQIZC/KOgwcT94po/GAKFBMrZe1VBOPCxR81Ew+fqoLkJW/ZhFiUdHWeQghYPor8Tfz4Y3LYkrRzfRXZhvHmGk2G504niZpqsW8XZpdQWgyGT1DdCd/VF4lu27zHnBi0ZVTkxhsf/HOtl/7deDJ1b2EYIC0aO7Pgek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725475694; c=relaxed/simple;
	bh=9RUTW9bZaOsV2wrYYsuIosvwvvBAShjdt3VAkMCbxaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Oqf5AasZo75JV2Vtl1uuKiksCF2Hjds+xLF15fchIWm9+EMnLwk2I1CFr0nUEm+gxsmAC7ByNM+NSo+GgW8ByI95RO5QYY8dycGBcUwA6om3NflK0nEocLO6p5Md+AwL4B/6YmftRsuOfg+7BzJSloR5foMjqS5K+1TZTuefEO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Hyh8cG+q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Hh/kwcgU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484I0URJ013800;
	Wed, 4 Sep 2024 18:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=To+33+ftd0rI0Iz
	9NqPjGh2rH0BTthh3sEvG6NPtIaU=; b=Hyh8cG+qbzfDxypgdJlYYnVtIrYtap/
	67miRtJxCm95IMozyKx/b1imY0fZrIT+/kLEZh1jA8FL6g3UCq/8sxhNVd0lNqYX
	sKsgHgE6uSrCFRmo9Ur769m9uoZfOgBfNwUU8tBhiEqPlZFoIZExlTOd1VEirwGU
	UmKtvhSj/fHrLgrt6aYiQ5Z4imrF6y5pnMvC3CPOkrHS8g6a+aegFIx3xXj0w8CD
	kkTVZW+C1JtqISevN95adnBtw6PjnfObM6Bj/rk/8Ubgobq6nw85EbqfISDZA9h/
	wCBpLI9LA7P0QFF4IzVdicqHWbGYtXR53xabNZ9JTEj4SHETyiF9Z1A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dvsac9aa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 18:48:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 484IcM1F018435;
	Wed, 4 Sep 2024 18:48:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmgh4eh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 18:48:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WC+6KVgSFA4jTZZcmIzs3gVyVrIZP82V1rJ7pDQOUr/v9vgOBw8BsbVkBRMDPk0qSPQ4PzccCyg0VmBCw/iZRCbt8vdvpXYdWR6WZOPgFLdx8XvLl5gVufaz4zoHQNKgWaAnNjspk0VudtelI0PzsJ5SASVWptfrSxCpayLq+p6Jlu9k00Y4OpR3umSZfVqZ6HME6z8i0NCTHCJsGUQNxTjwBB0b87Ild4JnHralT0m8dq6YqGmxUSBYd9pu7a0oH4lpfoI0T6SAKXyC9gpl7NhtmAIkq2z07ptG6jjJ6xJ7+m1lrfOXg4o37rHQ53mKxB+fpmVnOYwnITA1KmNF4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=To+33+ftd0rI0Iz9NqPjGh2rH0BTthh3sEvG6NPtIaU=;
 b=H9SwkLSfTr9D4+j/KQDp2VoL4WUSkJHppAjG/mMqMfsr/RtnQS8Qr++iKG7R5bm+11sKQXH90cPvY6WAHO2OKfYhwOw3ZtxP+oHKk16J5D5mpdha/TIkjxd/2rKqAKcQwFfdzRKjv2pySSTPNcHY7+HFa6Mi6ogbKJZKC89MoYM2i1Sl5SOF3zf07tlYoFcoxKfBQt9qOadXcr0KxwLfPOK7APaJEi1UnhzXGVX5WSyn0UbYalirJVHV3ow8PuFrQgaAqsSjmGE3E4LR2zwrO2CQ84a7k/QUlVLNLgztPro2dtteIoExRQ1WR2jWlfZdrhd0VrZZzK+bswLSzl25Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=To+33+ftd0rI0Iz9NqPjGh2rH0BTthh3sEvG6NPtIaU=;
 b=Hh/kwcgUpevPJMBsLu+ibQPqVt9JtlF5GtpF0b5wsDT4rKVr2ed9gttXjao2yL250RF8uPFJ73rZYa+aelFeKFLbUAqC0LHcqdXNyKzHjXyraMypeBY6U/KrkKV30x0wYxbXsnm2AJHMPgvkKOyMVtSWeHyuoHAPvrUHa3NElkE=
Received: from CY8PR10MB7265.namprd10.prod.outlook.com (2603:10b6:930:79::6)
 by SJ2PR10MB7082.namprd10.prod.outlook.com (2603:10b6:a03:4ca::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 18:48:06 +0000
Received: from CY8PR10MB7265.namprd10.prod.outlook.com
 ([fe80::d299:36f1:493b:33fc]) by CY8PR10MB7265.namprd10.prod.outlook.com
 ([fe80::d299:36f1:493b:33fc%4]) with mapi id 15.20.7939.010; Wed, 4 Sep 2024
 18:48:06 +0000
Date: Wed, 4 Sep 2024 14:48:03 -0400
From: Daniel Jordan <daniel.m.jordan@oracle.com>
To: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ktest.pl: Avoid false positives with grub2 skip regex
Message-ID: <silatrzj6dnyyjnzuaojyawdzztffq6hzolra365ufti4xc3t6@mvbzrjqofttr>
References: <20240904175530.84175-1-daniel.m.jordan@oracle.com>
 <f7eae65c-fcd8-45b4-86c7-443e57e96a96@eaglescrag.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7eae65c-fcd8-45b4-86c7-443e57e96a96@eaglescrag.net>
X-ClientProxiedBy: MN2PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:208:fc::18) To CY8PR10MB7265.namprd10.prod.outlook.com
 (2603:10b6:930:79::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7265:EE_|SJ2PR10MB7082:EE_
X-MS-Office365-Filtering-Correlation-Id: 771c5b22-4305-4b1f-3b7b-08dccd121d04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l1hQvcfnMekSefQPHUitBiYateZLZ4AfPSuJG9V+GDh1ye6IOgtNnY41XT6Q?=
 =?us-ascii?Q?Li5whrUiL5B6+89PNRor+xMd3OnPvMmZa7p8NrA/2Kn5B4PnenLT3o51NfXI?=
 =?us-ascii?Q?PY/76y4YeQ7QIk0kPuzeTxEvN6uwgq6QeD/kpg71PhmDhbHyxcxaokoZ8E9E?=
 =?us-ascii?Q?b+zeoMrDhgl14KjBPVp8t7M7KVKQQU86ABTtseW4TzwFxbC+ZydkVmfRteLH?=
 =?us-ascii?Q?NcGeejtHK0J4BIN7LZ8FxwFuGcuwCNgVWRrRwX7ItrY6EemP4VVKB2avdJGl?=
 =?us-ascii?Q?MUPsdgjY3gnm/wE3iLDIkqYGI+k5aP5U2XSa7yp7vnNjgvnE2B6+wxZciw+V?=
 =?us-ascii?Q?3JfG8ZDmplfvOmB24lrXhtnHyGya7Is5hHyDkKJRnIwDXVA0oGlbcWujGQut?=
 =?us-ascii?Q?qen5vh5Ho7E6wSe9LNSzQm9blMoOwGmwwW+AwcHsnEZIscz8xHORkeNUcn0l?=
 =?us-ascii?Q?/D4ndSf4lDh+jF+iry9mOoU9ljgBzSOFoE3owvA+RT3CQ0Fzoe8WksySG+so?=
 =?us-ascii?Q?5fEY5ln1cE2UGAjUKb39KXB102IWRWqw19llFw4ohBHtrWfdU/c+Rho9gCyf?=
 =?us-ascii?Q?9vkuhnrZgru2Prdj9AOnYNA5tInA0OoxJITG26JoMuRz7C9Nf8mMDkhoTsCy?=
 =?us-ascii?Q?WyCpNLbOwI2fh+rHlVbqZ1nis3FUBsjHF4aP2XB4eBetGWl2jJCeif0zKHvv?=
 =?us-ascii?Q?NNhYgvC9W87+A4OJXEZTZATrzWc1ko6eA1zxSxEVyqZDyqkswzybJrUV/Uwh?=
 =?us-ascii?Q?CvbGMfNulGv2Uadaq0MbKgOZpewChnBWJH4RaATNlHS6sffFuDxCIywsS/aW?=
 =?us-ascii?Q?gGGwMbWXnVfu7f8Etq4/jez71QLoIY7b9bAB71e628ABdCIWf1Gj7J4aGZOB?=
 =?us-ascii?Q?HoClNLxIHPfaYfyuWpWgSXc35zl1FAVH7D4hShiKsOR1SriZUNMqXJek6R+S?=
 =?us-ascii?Q?qRYpYLUxEklinnupTDcR10BNhl/wyt9onx+vLINqO5Ja9SCPhQ0IL+0CtHHr?=
 =?us-ascii?Q?inzvZGpPBrYDh4WadIIR/R3c1uoKQVDOVTOJy2VjiM7Qv/viNVViCbBea5lB?=
 =?us-ascii?Q?jx0LwWgHdez4olNaCrES0zdRNl45rLAC1I8m7TWyDIE+gVPcFFwyevjOudCt?=
 =?us-ascii?Q?c1znFHEiONHqo0iFxlriN2EwOBvQNqPf9GBrwjl+R1mHbqUx7jwTwpoK5euO?=
 =?us-ascii?Q?JSTBXRYOpnPMZXMqwUPKY36BTYBO8E2DlPHVhzUjXgnDBsn6xrP2KSiyicWD?=
 =?us-ascii?Q?6KGvcYxQGRDwOsDuglNK8dPKhKEjJEY3p7wykATEOve/XGEfmB/2VSkvHJ9s?=
 =?us-ascii?Q?QQBCJgWneYq4cu1FIf16Ybzb9lOF563x5+QMSLdxqripIwcaXmAMhLvMIYUX?=
 =?us-ascii?Q?fvXOofHTBZdEHl3U9bGreXNO72lqjivFSjYjlVTQQzmvdx8tUg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7265.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RqgLh0Z8L+YBuW1JZ3+B4HXRNFnF8Y87viDJT4LFq6WjL56Dj5viYLSMkoik?=
 =?us-ascii?Q?RqsMDn+9+pcKqKXtWFatdGbQ6orGhzrF8OocexhiSZVBFEr3VTg2DBk8xyqS?=
 =?us-ascii?Q?Db/vIbLHS12wQJ6cSYRy/HvRTLcIvRPLdjyGsaMoAmRcpqBCLXCq5yifo7zY?=
 =?us-ascii?Q?0Rnk30VwLsTiAWfVC/idp5zlYIkiV1BoTocfKR1Ragxu3Kj2heErFTVJsSq/?=
 =?us-ascii?Q?YXkmZAlA+HB0gSyva1FCCgMJHG9F06A4O3x+4LWQyttWDcZgF4ryG5GQuBV1?=
 =?us-ascii?Q?YJBU9Jb7JZXoCwLsqjzrHA6/kB0sWJD01/zjZg7y2eTxBnYxncxJdFU/b253?=
 =?us-ascii?Q?GAit9zZ5MknD+cDcvD5W4Ob6LAA7+lTnCjG8mFuJnQjmSmYaFcjk7U3jNqAO?=
 =?us-ascii?Q?3c3VKMR9hg4XrAktloUT0+3Jb1XXuogXwtlG4+2+s+QYyjvYouhhfffkXWYN?=
 =?us-ascii?Q?Zuj3R2jBGWgXBlvZ0Bj1tRHJwQEBtzSB14PtSZfuJnoT4hdyVO0AIZ4tNiay?=
 =?us-ascii?Q?bf/dSzFMX6B7QHjwZ2kzuKrrudc4JpsYtZoTcdB+BNaleYBvebga0bbqc4Uu?=
 =?us-ascii?Q?r+0ari1YCB0hYJg8ztyldzyBh3ZYrKXj2JB8VXB3tumoRyu/NVxHMq8/ct6I?=
 =?us-ascii?Q?u3ZAlJrixRcsDpjlbjJNGkj6oesI0njNEHitvuCGVUM5zrmwmmy1DPDD0lB9?=
 =?us-ascii?Q?QDiNI7s+tIvP1EBv7O/uqrTScAFDwmWNHPL6RWdY9MtcTzyra/EbraWLl+sV?=
 =?us-ascii?Q?w0FH3UhevaI5Ps3TaGjw3r7tjEsBacPUCpsq+FR2QZOxk4p0tSil2RQSgQk8?=
 =?us-ascii?Q?ULWZ/XMkUlJyUO6s1U0eNSnF4b/v+/SQwNtPMYXq5mZWZ9BzLcQYMST8tFGM?=
 =?us-ascii?Q?b63lbhqyLVJpe5o628+ZKAWExTbSSDYaiGCiK85vv4JbfwEKjcmNerNdvzqe?=
 =?us-ascii?Q?uDBPVa8ygW1mLVmwiExKfVZBa18or7FnA7H9LcFa5o3n0kWP4SOg+9xH6G0g?=
 =?us-ascii?Q?a4mBzN8Jj0UVulOpv/qd4WhHE4CIl+hLi9cbSXKdyLRVta73bUDueV01N7y/?=
 =?us-ascii?Q?I91LLUC9c33soc4pVnbOfuvBwZoAZdP16zN3FMbFv6GgxXZ+FmUePomRwGBv?=
 =?us-ascii?Q?8bJidFF+XZ+Qw1vrQwIJ3FnYa6bnJ2h6mhq5++PXvobOcfwMxsbEtER/X8li?=
 =?us-ascii?Q?3qO4X4xCNscAuIv6VdQlxiq6zUjgwSCAaGcoR+iq63CNFfY+8835t3k4niRV?=
 =?us-ascii?Q?ZEPj0VbQvxVTlFZD335JCvAxkEwOjhGgjIDZgv4nNaoz/HZ3MkTQNe9HZSNJ?=
 =?us-ascii?Q?8iUZAfh/J9b8gRI7YeqL1cPo951ylOSRc0uS4DCutSZ9yWq23e8q4FGdnLRh?=
 =?us-ascii?Q?WL9/MH85FjKoTLVXmqz6YejEPjXNgMXqW09WQLQb068XhSI2khPauDGe7Zwe?=
 =?us-ascii?Q?Uy73QGOtlv3qWW/RbP25j+AYjI9Yezijz7o1C0WJBKZJmpyFZIjQ+3w8j+fw?=
 =?us-ascii?Q?k3Ews4wCpUGpAk9hwbYhXhr/M0yLqNzuiFTBkgCwnOZkVDS0I+QRUDTmxrCp?=
 =?us-ascii?Q?vyju+7tjUfZblCd+DeFXrXci3D9kQW83RoiCLYzXT7wvfW9s0tf9vwoxhf+k?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	co/k0O7tspVy9SvAXuVtbcSoPp++2b4lFsvoEt2bjBd8HeMSyiUAw+jSkmEsxMqqKbKqlq+QJwg+fBOvxDukQ/F27Iw2RtG6vF048hW2I44A6Qkn/QEwxyR7lIgmT2Kehxxly1KrWMyCms5eaV7BdXJXEbL03RqtFq0zefxgkC11AJaR7Nh+ZNFkAePvjLHe8aqs1PSZpdrZOKTbkLD/KSa30WogKBKFL6GPEMPDotBdoBGipCQEtS9SL6eFtnwsSAwpz5vfcbsovFlHnUsSX8UxGZjBN072z3D8DSMN23NysZX5H5yOt7n1elspYsC/7Hn0+Hx2yxJS165Q14WwW3TpjIQL54oRpHKvfrqz4lxrc+jvvf1FoTYKkeZi2bqJsEACAjfj9qe64MV+x/jnz9qtqGDuFTvk7Vvbg1b8AWX2e9pNS8goTNkct2jF+eqUYDe2NYDpHUwII0ua7lj6buBrajUxYuSXEJa+2Tz8+8FDhT7rBjZXwj40FBHQkHVQ1hiECvQfhkDR3AW5xJTv0/+NUjA9n5Z3byAEWMYJp5R7iwM2jBusi6YZTdM6XSH7zUpYWcShA4HyX06ijRZnXF5k0TvsnWOJEsPstw8eJH4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 771c5b22-4305-4b1f-3b7b-08dccd121d04
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7265.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 18:48:06.0939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q6+HPiSk312CKNMS4cmvNGF6QfLZyDtSFUhpi2URAGsJaIAZMftvPhBRGE3duaPfGEXyKMnk8ri6E7brCP3H/gsL88stcLxwbEBIGCM/4Uo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7082
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_16,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=651 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2409040141
X-Proofpoint-ORIG-GUID: 46RL7Y7pRQyzOB7jf9DxBBGGBwUhg6ha
X-Proofpoint-GUID: 46RL7Y7pRQyzOB7jf9DxBBGGBwUhg6ha

On Wed, Sep 04, 2024 at 11:44:12AM GMT, John 'Warthog9' Hawley wrote:
> Easy enough fix.  Out of curiosity which distro(s) did you find have that?
> Haven't run into that myself.

I see it on Arch and Oracle.

> Acked-by: John 'Warthog9' Hawley (Tenstorrent) <warthog9@eaglescrag.net>

Thanks!

