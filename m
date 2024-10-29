Return-Path: <linux-kernel+bounces-387467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044779B519F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CFA11C229CA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E7E1E0DDF;
	Tue, 29 Oct 2024 18:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fENiiWLq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BQdOGxr9"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12419204F66
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 18:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730225575; cv=fail; b=G8+JNCT9ymToYBv9LIy1wEP46aiwp5eJnhzJhULjZj7j6oDAvBtFsJzPg5krYVN3lLlE4e4yZ7jNStzikUYMwzEUXzgnpahitNMLVDHqkuEXUHg2FSKPCVvrsfCdp00XoMc9bZOjncW3oOxFKsZrF4RR/wDZkM8nVhoIllWkqvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730225575; c=relaxed/simple;
	bh=3Lpqevb7LtPALl3uqQZPBhfCPkfJ9UiEpvwIdWgkOaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qj8dUVk6Q1wj3IZrAH/G1m/exnbXzXdxQ3yDLa8AXoQ+39fFniom1vwQFuyc6gNWPaBk8nz0mjrvqkBmutSF+EYCdcy+IVFDd5gf2ROHTY36OvmUhTPAusp5WUVi56uZMbmshqBYR7gEcPCt80aIW0DR8lG1QLqgo2T2cIxen5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fENiiWLq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BQdOGxr9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TGfVk0030916;
	Tue, 29 Oct 2024 18:12:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=lnRs8fMf9CA0ufwxjVoxof7qX+F6sbCgSJ51HkqymKo=; b=
	fENiiWLqfdlZcdOFO9XKHGnvsnRwZE9SpudvzJjt9owZRs6yhrc4KpbEpdVmFAAn
	i/62POOc5E1+zl6vCNE4X9cpEHP2wz6HPqPM4jOiGbhRsWxi4M7Yb4owB+N0e98W
	N7hvOK91kTwrObrKYlnQRj1QxBD6ktQPn59Kkva46MlwDToPHlmCoqTLNX21GaOW
	YumasfNjmkjLX4EHxoAdnIxpuZHwWvSzwL2Ml/6c4VpTwIadXzly/SK/3Fj22O2x
	rBa8nUeKQcF6LLjMSh/GDBqwPWNf0Vgkd9pRkc95sSFH6Rxdwo1j5zmJ+tF1PyB+
	f0t/Kn7PhaZqMqgFW0xMvQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdp67rj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 18:12:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TI5Ogr011848;
	Tue, 29 Oct 2024 18:12:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnacx88r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 18:12:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0OyqhiCbFKWKquqpkzWgjBD4laLlaUcWCW39ZG7BOdYnxTXzpitiFMF3GSD7UrSJX+HsrFCj2TIsZVME0yE3CRnYHzs7NgI5dwivoztolIl9sf/xnUnTbtdxsC6lzs+CRggkfjLsiQUo93vfZFEFs2s+bXPqkVtz/UX3RywE86IiYBtOeEu1IORxuQ5BZNyVR06zop01H/cKjQiVbCXZ2T+Yhi9ocnpSvVnjl45g/BlO9V81nhR0pLWza1htLbnQ/wqgGtnMc/myoiP0UrGtOr9d8BYFVxnayfhUTBS9D5mozCuN2m1wU+EGVNWHJ5GANA+249LXjfERoKeoZKmIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnRs8fMf9CA0ufwxjVoxof7qX+F6sbCgSJ51HkqymKo=;
 b=OTmjbia0O7WJDyilud20gR8nuABgI1PdtcE8/UzyhL11o5omAtMn3sp4+lfiSSeFBn/F3UUy51h71Xl417nShbpLhGJQEcQ/oJZetTxxGFQGvJTqIrjold+cpD63OmCK4aY4oo6BBv74izNuGLSsAfSFF405hOqP61ZrOJrE9qFkQAOQHfLKPrHIiWQGrpt7TQYxBw0HdWy/I1DJok6iV/Ch7Kh12mVz6lfjtLmgxtqY9vlGWuP/gltfZibXKFrXfAkY3T6df3nytKs206mgKeVfpnu6oUbl6a/UUyjWBClZLN/VYoSmyduszN3KBxe+zYHip5O/sD196ezokks+vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnRs8fMf9CA0ufwxjVoxof7qX+F6sbCgSJ51HkqymKo=;
 b=BQdOGxr9NbmFcANwuFt9+/v7hsa6xZppNyw8FSB3p0REn8ea9asNd54Nhj1oJdeL1mmfuSEhhhKUfptFx4GFYhn/h4fV6aYGW+N178hZ/7q0o8KHFPRB5apwdnNQ0MyhjHLO3VlHyq5fvaw2/iLiYkDR0PweyPj1O6rkYmKJjjw=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH7PR10MB6966.namprd10.prod.outlook.com (2603:10b6:510:277::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 29 Oct
 2024 18:12:18 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 18:12:18 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH hotfix 6.12 v4 4/5] mm: refactor arch_calc_vm_flag_bits() and arm64 MTE handling
Date: Tue, 29 Oct 2024 18:11:47 +0000
Message-ID: <ec251b20ba1964fb64cf1607d2ad80c47f3873df.1730224667.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730224667.git.lorenzo.stoakes@oracle.com>
References: <cover.1730224667.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0273.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::10) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH7PR10MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ff592e2-4815-4648-7436-08dcf8453959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j1ykXFkbGhYmgLsyys03A+qbpQgYmn6VFBUDrpdALPOwOV9sXhp3s3JYriv4?=
 =?us-ascii?Q?lT9NC9jEoUWvArmeCkakbO4l/dKTbLl4cX9wfzjl7Ei6AwzPM2HG1rrT4rNp?=
 =?us-ascii?Q?btxEopUFZxSPBeltBwDmw56Ixv41TBhIJl+fIWLM8hX1/IpBtlKO8I2pQfw9?=
 =?us-ascii?Q?K4hpYP6HpU4ltN2fxZfCHP/YuCKHGlRra6Ve5gL72YRJn3pvXrJ/tGqLk2nX?=
 =?us-ascii?Q?+1uOxqEyAPebpi0PdJQhXnWJ7hFfO+iPphtoYiavXPb15o3m+C8D8cWzE+sQ?=
 =?us-ascii?Q?5mWGPy0M+/6RUNTpU5+Gr9Jc4tVzWqonaa10uDYfFsuvDNSidXFsS7/qtjqf?=
 =?us-ascii?Q?41rFYPSE1RwWDJh/7H8ww6lNk/69Jo4GbDFgol+ZJsWG5kobEqtLQRxKnKh4?=
 =?us-ascii?Q?aUDLDCcMwY4AdSoawYA+MWNR6J4dobWjIXs9W4s1skh5ONIMDVtH75UTYSqO?=
 =?us-ascii?Q?1fLjI4HcmMhgctPChBZ4KvdWKcsEkokG2ENP0Oo7/pQ/0Jk0OYruAAf0Un5r?=
 =?us-ascii?Q?NjegXYvNE6VGeRY77W44paNIjyD86dRFQ/H65yeH1k8hQTCxq9r6aXXTQ8Fw?=
 =?us-ascii?Q?W5iymcM73Q1FTb5F2btL4bsXmkvXn4aqfPLtSSGRqd0ABanUG1jHpsF6iSWe?=
 =?us-ascii?Q?T6wbUhncRHAgVJvuut/X3N46uxTO86EmFxcrygndJuoR330m1LX+Iquq9YSY?=
 =?us-ascii?Q?iXeXSIx7EPsvKf+nnHIY0BhM5dPrymA5fancPTLuljTdAzqpj+31V9Brk8F1?=
 =?us-ascii?Q?/O3ZzwyUBT/GLpTDkw8sPKvMz6guXS7daKm9pzsPNhW3skeO6P9tDFGlhxk1?=
 =?us-ascii?Q?ZKORNx3IIE0ioRRONzqfGWZNIMjcl5i/GtYBqbsByS0CEl4Fj0B/nu1VAXOV?=
 =?us-ascii?Q?LmH8oi40NeXRY1uh7GafMnRmMdWHkT5ylnRvtfAXEUjsWsvtfWX4mGNQWPQ0?=
 =?us-ascii?Q?/5BGBeiFLtWfzl0ckOOiOvKeL6bjPTPuwC0Nafep2bAaGvuS5KQ3Jk9P2PWR?=
 =?us-ascii?Q?cj27g0x+at/x/j4jtS2Sfz9Mxc2G7qXjFxyDUhVxF7gsSp1oAEjqQq5n+56S?=
 =?us-ascii?Q?HdacEGoXJoxnGQ/t/IMC6Lf7n8q+2eaZz0twGorcLtpuLb99vZp7MDOosG/a?=
 =?us-ascii?Q?BLVpNjkJa06yX0tPsDqdof++ux4knKKYw8UXIlw2ZzAR6kurKqiKgUOmNWWc?=
 =?us-ascii?Q?6CZZL07SupblXTf9tb51n66XTTv7R6gyYdIL59AjgsnSv/yhxzmR9Xj/HXaR?=
 =?us-ascii?Q?UHcC6CLnnNqNqNP5iBYE50/rb5SAkxwSVHusrPx5Yq6dAt7vzYufsiqydQeY?=
 =?us-ascii?Q?75qKAuaDxAMTBq+ZSBr/jCM5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UUCB8QqDcve+1US/fnx1WJuA4nrep85tXZm7cnBe+lEfnDokbQbBXDM2wlL5?=
 =?us-ascii?Q?/m9aRzeEX7nrvxy6Mv3HqGSwl9fhtuXEm6s9LIqG17ssDRchZT6F4THHeCcb?=
 =?us-ascii?Q?oQ6oXEl78uIfsTkQypjNAgVRmDfqa+BGGlzgj/N0cBVix0len8pF7a3nuCtm?=
 =?us-ascii?Q?WygpmbPfQlnSPSmKxLRBjcCzsbZCN0XmbRyTCkYgzy4rre6j5gspmkXL05n1?=
 =?us-ascii?Q?jJD6THyWx/qAyC+FrsU/5UVgreCFmUGJM9rvgDDZkfRmE1IbM9hNMzPlD2Hc?=
 =?us-ascii?Q?qwyEvS4HyE/GYiw7/nGsoZHxhk/tgGWVhq1E161nk3uln930mCa5TSf0eQug?=
 =?us-ascii?Q?F6fgO83zNyAqo8GewgWg8VB06Y/OWyXg9L/M4j34z80LBJBB4865vKnvCqmE?=
 =?us-ascii?Q?S8pZT7aapF7tglTCEYvsLxPdbfs3BZij6OOjN/vlBhPEI9II5iEAHyzvOTC4?=
 =?us-ascii?Q?ShH3MTuYlQzJoC5zchDXo8KUjcAoVtX4JS+EWkOAmwbYydKSk0j35JUjXswT?=
 =?us-ascii?Q?eJv7A+9KSgi3ZgwGoEQ+l8+evahvFzm0CZ0zX2RRu6/n/9Pp3yhNJOu45qRp?=
 =?us-ascii?Q?LqnOeYsn2f5A860rxUwDrzCOz3UP7WcHLykjzgLu0G6Lv/h7/RLxB+PPAJs7?=
 =?us-ascii?Q?z2XTbAoSCi4b3RS7SAV7Wzc1ScKOPyNrNMuVNXbHmQZbHVxH8uUf2FYYf5dc?=
 =?us-ascii?Q?w9+gBx9BX//IaMsdtPu+m/ilLPjh1WMn9NAFzk5TTzrywMh18nk2hhKeMGDr?=
 =?us-ascii?Q?kUEkRZKjHEb2wtLI+OKUF4mFPuNr/+2ipQoBNZWVuWHmHQTT7xG42tN3DpQy?=
 =?us-ascii?Q?yuO2lsFAr8cZP9+oSyImNeCRKTA0/WK6nQDk4BFYLQNf75ErmLaCJHKYuAaG?=
 =?us-ascii?Q?7N0psScXxcllkEU0V0jgmhVKSRJC4zrCa8SXZdm0hV9hRgGG2cznCM/Hm4tC?=
 =?us-ascii?Q?0aEGfOcyHyL85qyUAu3pSiyBqn3vXqyYf7FqcWzvyv68jvp8g2aIS2Dw0z7p?=
 =?us-ascii?Q?swXd5JnonfdbFuJTnSAP1B267VnSsdilqdCs08rkivAqmmU3HADkQu0EzUDj?=
 =?us-ascii?Q?8mA2p7L4AUqwBlnkoWnV8LnQDJDwjMKBFP+rAdqsxJFMiYvZ+wpgF9ltqadT?=
 =?us-ascii?Q?7Jka7LFMeelxfPxlil6PRY+VucP+XPDA0io7FvHVl2irn2gvmWgqxwMw/fkZ?=
 =?us-ascii?Q?q+FzLPmwE6pA+Qc211dhOb8ou/dV3qLk5FWzGgd5YPZidrgAfblxlSCzNs2+?=
 =?us-ascii?Q?9HIBcShZTac5lgN/O+NHNpdHB8gQp5V8hAzUAOY/3qgf8pOPnBwxUct25oxv?=
 =?us-ascii?Q?Wa6ZHp5awy1DoC+yqx3MoCwDEqiy+VHVOYl4ty3QJOZb6smhIU5Zd9it06ak?=
 =?us-ascii?Q?tORd2N1deCg3K76ZMLHdYmKrgNjuoy0Ty82yAUd3jWcw+V7h6hsIVyZLvSXQ?=
 =?us-ascii?Q?NKHLOZrScmu7NHIroF71OlHl+S9GHlUNHdh4J0Sd/3Qqpob55cSiq60ngrUc?=
 =?us-ascii?Q?zl1GmPSPrnPCFf2SwufXxBXPoscok+LKh/7xAIVhHy6QUh1hr2G28WUi0+Dt?=
 =?us-ascii?Q?ZCQhns/PSX2x6TqONhnrj0ymCOHF620zF/vMAl3eyxbt6vhrHrsecT4FiwjW?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RPwsYbLN9RnGPqPF8LwxiqgSI8GOOOZ91eB6vzeoO8cqQ9ku8X2NUmtfTLIbui4AkoE9mhzDheCg2hbeOFWba11/YB/2P858MhFyd+55Obw6OcJJsBXz5KGMNEGTpmoSQKHFMkDvpaaAp3sR/sULxZvesf32pRtjbHlxJI6uW5tvy01pkRt6vV+nVl9iheVGKip8vU4B4gfz5PQ2vRvZhrpJq9nYi/Zr1EkVTE9ewyCQp1HvEeFW+i2CQfth9sQc2cKboa6qqYY7RZ4la+/MIiljyWBSOI6wW+ZpNoT06HIMQ8xohpL7aTwur5yN39ou5WA1ju4C+zJdACZrjdwqvoMn+rkKIBAMh+Spt1j+8/q2HNnJQJl9h5gDrSvMzWstcfEiEQPz7tjkWzH/ts4BVkmalaVEF6fkLTXDlXDQjKaxIBgGjUOqjMpWddJW1oEoXriDeaHIi6/74DwaR41nOd0sJS7Tr+GgIuw2Iyrs2++1SJUBLKrOVLklFErjXYuRcPeGF3y9dH5zdHDBaM/nSC8/Nvhp06Ftf/XuOJFHWtd1M+EXw1/ibJ58j46cyxJFEKRXS9NXWPQ9o6uXrD5vlsw4zfDo6OKBklBaSgKgxfo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff592e2-4815-4648-7436-08dcf8453959
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 18:12:18.1191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1MCe4rgkAkGNUXlDVOUTm6g9CqXMgwZD7wmOItUU2up6cWOGsGI2YA73tr4Q5gFLdwkhUHd2VAQejov4UXNeFjUPpLyd13tpPiUvpPlKbrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6966
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_13,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290136
X-Proofpoint-ORIG-GUID: Mq8pEVXT8P7w0vZGyztvhoAyIMls4F-D
X-Proofpoint-GUID: Mq8pEVXT8P7w0vZGyztvhoAyIMls4F-D

Currently MTE is permitted in two circumstances (desiring to use MTE having
been specified by the VM_MTE flag) - where MAP_ANONYMOUS is specified, as
checked by arch_calc_vm_flag_bits() and actualised by setting the
VM_MTE_ALLOWED flag, or if the file backing the mapping is shmem, in which
case we set VM_MTE_ALLOWED in shmem_mmap() when the mmap hook is activated
in mmap_region().

The function that checks that, if VM_MTE is set, VM_MTE_ALLOWED is also set
is the arm64 implementation of arch_validate_flags().

Unfortunately, we intend to refactor mmap_region() to perform this check
earlier, meaning that in the case of a shmem backing we will not have
invoked shmem_mmap() yet, causing the mapping to fail spuriously.

It is inappropriate to set this architecture-specific flag in general mm
code anyway, so a sensible resolution of this issue is to instead move the
check somewhere else.

We resolve this by setting VM_MTE_ALLOWED much earlier in do_mmap(), via
the arch_calc_vm_flag_bits() call.

This is an appropriate place to do this as we already check for the
MAP_ANONYMOUS case here, and the shmem file case is simply a variant of the
same idea - we permit RAM-backed memory.

This requires a modification to the arch_calc_vm_flag_bits() signature to
pass in a pointer to the struct file associated with the mapping, however
this is not too egregious as this is only used by two architectures anyway
- arm64 and parisc.

So this patch performs this adjustment and removes the unnecessary
assignment of VM_MTE_ALLOWED in shmem_mmap().

Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Jann Horn <jannh@google.com>
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Cc: stable <stable@kernel.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 arch/arm64/include/asm/mman.h  | 10 +++++++---
 arch/parisc/include/asm/mman.h |  5 +++--
 include/linux/mman.h           |  7 ++++---
 mm/mmap.c                      |  2 +-
 mm/nommu.c                     |  2 +-
 mm/shmem.c                     |  3 ---
 6 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index 9e39217b4afb..798d965760d4 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -6,6 +6,8 @@

 #ifndef BUILD_VDSO
 #include <linux/compiler.h>
+#include <linux/fs.h>
+#include <linux/shmem_fs.h>
 #include <linux/types.h>

 static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
@@ -31,19 +33,21 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
 }
 #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)

-static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
+static inline unsigned long arch_calc_vm_flag_bits(struct file *file,
+						   unsigned long flags)
 {
 	/*
 	 * Only allow MTE on anonymous mappings as these are guaranteed to be
 	 * backed by tags-capable memory. The vm_flags may be overridden by a
 	 * filesystem supporting MTE (RAM-based).
 	 */
-	if (system_supports_mte() && (flags & MAP_ANONYMOUS))
+	if (system_supports_mte() &&
+	    ((flags & MAP_ANONYMOUS) || shmem_file(file)))
 		return VM_MTE_ALLOWED;

 	return 0;
 }
-#define arch_calc_vm_flag_bits(flags) arch_calc_vm_flag_bits(flags)
+#define arch_calc_vm_flag_bits(file, flags) arch_calc_vm_flag_bits(file, flags)

 static inline bool arch_validate_prot(unsigned long prot,
 	unsigned long addr __always_unused)
diff --git a/arch/parisc/include/asm/mman.h b/arch/parisc/include/asm/mman.h
index 89b6beeda0b8..663f587dc789 100644
--- a/arch/parisc/include/asm/mman.h
+++ b/arch/parisc/include/asm/mman.h
@@ -2,6 +2,7 @@
 #ifndef __ASM_MMAN_H__
 #define __ASM_MMAN_H__

+#include <linux/fs.h>
 #include <uapi/asm/mman.h>

 /* PARISC cannot allow mdwe as it needs writable stacks */
@@ -11,7 +12,7 @@ static inline bool arch_memory_deny_write_exec_supported(void)
 }
 #define arch_memory_deny_write_exec_supported arch_memory_deny_write_exec_supported

-static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
+static inline unsigned long arch_calc_vm_flag_bits(struct file *file, unsigned long flags)
 {
 	/*
 	 * The stack on parisc grows upwards, so if userspace requests memory
@@ -23,6 +24,6 @@ static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)

 	return 0;
 }
-#define arch_calc_vm_flag_bits(flags) arch_calc_vm_flag_bits(flags)
+#define arch_calc_vm_flag_bits(file, flags) arch_calc_vm_flag_bits(file, flags)

 #endif /* __ASM_MMAN_H__ */
diff --git a/include/linux/mman.h b/include/linux/mman.h
index 8ddca62d6460..bd70af0321e8 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_MMAN_H
 #define _LINUX_MMAN_H

+#include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/percpu_counter.h>

@@ -94,7 +95,7 @@ static inline void vm_unacct_memory(long pages)
 #endif

 #ifndef arch_calc_vm_flag_bits
-#define arch_calc_vm_flag_bits(flags) 0
+#define arch_calc_vm_flag_bits(file, flags) 0
 #endif

 #ifndef arch_validate_prot
@@ -151,13 +152,13 @@ calc_vm_prot_bits(unsigned long prot, unsigned long pkey)
  * Combine the mmap "flags" argument into "vm_flags" used internally.
  */
 static inline unsigned long
-calc_vm_flag_bits(unsigned long flags)
+calc_vm_flag_bits(struct file *file, unsigned long flags)
 {
 	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
 	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
 	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
 	       _calc_vm_trans(flags, MAP_STACK,	     VM_NOHUGEPAGE) |
-	       arch_calc_vm_flag_bits(flags);
+		arch_calc_vm_flag_bits(file, flags);
 }

 unsigned long vm_commit_limit(void);
diff --git a/mm/mmap.c b/mm/mmap.c
index ab71d4c3464c..aee5fa08ae5d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -344,7 +344,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	 * to. we assume access permissions have been handled by the open
 	 * of the memory object, so we don't do any here.
 	 */
-	vm_flags |= calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(flags) |
+	vm_flags |= calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(file, flags) |
 			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;

 	/* Obtain the address to map to. we verify (or select) it and ensure
diff --git a/mm/nommu.c b/mm/nommu.c
index 635d028d647b..e9b5f527ab5b 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -842,7 +842,7 @@ static unsigned long determine_vm_flags(struct file *file,
 {
 	unsigned long vm_flags;

-	vm_flags = calc_vm_prot_bits(prot, 0) | calc_vm_flag_bits(flags);
+	vm_flags = calc_vm_prot_bits(prot, 0) | calc_vm_flag_bits(file, flags);

 	if (!file) {
 		/*
diff --git a/mm/shmem.c b/mm/shmem.c
index 4ba1d00fabda..e87f5d6799a7 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2733,9 +2733,6 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 	if (ret)
 		return ret;

-	/* arm64 - allow memory tagging on RAM-based files */
-	vm_flags_set(vma, VM_MTE_ALLOWED);
-
 	file_accessed(file);
 	/* This is anonymous shared memory if it is unlinked at the time of mmap */
 	if (inode->i_nlink)
--
2.47.0

