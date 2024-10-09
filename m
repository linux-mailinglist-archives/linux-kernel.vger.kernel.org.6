Return-Path: <linux-kernel+bounces-357756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AD199756B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998831C22741
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4011E1330;
	Wed,  9 Oct 2024 19:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GjHJQMPJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aRRyPRUw"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818F91E1037
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 19:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728500823; cv=fail; b=dSIYdWqZm/6nfJShSyZbcJmUYCyJX/FBUKL8Igmc2qYT562jfY9fbiEAyxgxGahr605LkJp3Gb+fhNMf3GniBw6+tOppae/Eq0sjxICoiPtrbntihlmWTaRuzvdFlHE9nX0XyiC3xoxs7oqxVBifcZ+xxHQUnX4dCUvINw77iGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728500823; c=relaxed/simple;
	bh=Efqkr8WPRqYu/tMWfS3qEfuy1inL5fnWC9c5IMOmgzY=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=f4tY7u1bDSkzEvKMwfQebs5fBCyuGYx2R7dLzGi1JDHv+1HGNSGnSPhBmlbZ/8mTiaRCtAOryYs+ah8CG3daCN1ycn65R9/95c3LtGUswRZC1KRd49GRTGpmLr2tWHw8ZyIk58eKpw8Ys3UUGFeDTrIO0BUdqFzDWuauRcxJYNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GjHJQMPJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aRRyPRUw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499IIQT2023392;
	Wed, 9 Oct 2024 19:05:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=TiWNKCDPbAar2Z6KTc
	KdUqS+CDqssjXVyvP6yp584kI=; b=GjHJQMPJSUrm7kxGN4vxFJM4DbZQGb+ImQ
	Mu4ZdFX4x+YUnNss8PrmnB16u6yyGsOTW+rse1r5C/cc1wl2LznA1x17P7QRf02F
	OjgFbAPLMd2TnN5b1DZpdlgEYtMn11g7ItEmZegC7hxqga2BwfyMSytCXeNhELwb
	CL3me48W483A+u+QP0vcYDqUvHnLDK8YKZpk9NSnsi3JQAToe8+ZYYy8T2x5JjU4
	oWmLRNUpF1r0RDgJfQdrIooyKIXa+5rQc9zmBUpBqj6jLXXgLRApTT/Ej9KnK1ve
	wAfEHIOq0+fI+TgO1gbXvp3yNaYKa6dd4l+cBKzPfv+Iz65SUPFw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 422yyv96nx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 19:05:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 499HQREY015234;
	Wed, 9 Oct 2024 19:05:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw926tu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 19:05:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8j7npMkTE91w4iC3qWp5Lr9Q0IAPaonM03EI5L5cVjCteoB3FNarmLQ3parWWtMa8OpoflbhyHRXg/6ywH+e2yOQBof9Wv9iSwuj8AzcgsHJ+9F+UrfBm79zISkxP6X8qXGsYf2iqOp614dsEaOZ86Ef7VhvVhfrOxlW3Cyigcj43jwk2x4vhUS4Oph+GrPnonj1fZ6YNxZxfvTdYyRpE/C1uwCSfAf9UUNwS5khrUUNqTM1zs+/0xTbkZCGp0+qMqHLb8CHMmG3D45HQ4qXCm1k7Y0w3ZaU4o/ANFIMF4YGefjMa9n1RcIMYi+w2wK9bOQpuYJ+rSGAbdacrXz2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TiWNKCDPbAar2Z6KTcKdUqS+CDqssjXVyvP6yp584kI=;
 b=jVDrjm7p9U4bEgslJnpIzqDT09HlfGoT//lUea3qT2aKIUBDCY/FixUhSmRcXdM0WWGwZX2/a5aZMtypiKUrrjjj7N/dsjcAiKTyRuuuCKpaJpvuWotuzNzsrHPUxM7irxkYkX1E1ojQadsPsIjWbZJ05O/pWhzZ8OK6rGjEZFRGe2TEfOhgZlK7dyaKPJFG2BzlCuGLF6IS5G1gx37cNZMDq9RIvYR8zHIJGt/TdSNnKkN4MScs09WxhEp80e9TWgv6nadRowsX1H+z8ZZj52Vow5brSHk91gZkHM5TkaZO6yd04/P7nFVD3J71ZPIZq/xZBW/KsFVubCIh40KEow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TiWNKCDPbAar2Z6KTcKdUqS+CDqssjXVyvP6yp584kI=;
 b=aRRyPRUwmPMpWXAx+7kFoxuFHTU4A2nxNAeEQzFxNqQrfhAnCgy0bCVVyh6h78XM4WSQFJHgpnWHDX9pOCGejY7FtEDce7FzjWONRspYSo/sUFn01SRU4wrQLgcgwE9+U0jOHwCzEk7zucGqdAqpVKVX40MH0wd8Uk+YQpnbzQc=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB6514.namprd10.prod.outlook.com (2603:10b6:930:5e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 19:05:51 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 19:05:51 +0000
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-5-ankur.a.arora@oracle.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
        paulmck@kernel.org, mingo@kernel.org, bigeasy@linutronix.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, frederic@kernel.org,
        efault@gmx.de
Subject: Re: [PATCH 4/7] rcu: handle quiescent states for PREEMPT_RCU=n,
 PREEMPT_COUNT=y
In-reply-to: <20241009165411.3426937-5-ankur.a.arora@oracle.com>
Date: Wed, 09 Oct 2024 12:05:47 -0700
Message-ID: <87o73t9jw4.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0014.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::19) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB6514:EE_
X-MS-Office365-Filtering-Correlation-Id: 13bcf6b9-0ebe-4829-3b9c-08dce895644a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GfSaVbXO8ndk1udw8WITzpuEiatxNCzWzloip7Yma/O3S9F+8KLQq8nGA4nx?=
 =?us-ascii?Q?DYkskRGNUZ1cQghbGp1NUSw8j26WSL7qKZUQETIW2K99E+ZPZZj6woog6ZsS?=
 =?us-ascii?Q?g/sXYJXcehxZYsn74pfLnhQYTX6ESHaVw4pJaCS+At3ael5/quY0mt6YfJaN?=
 =?us-ascii?Q?+OvAMb6P3SYjdDZaKEXVs+gbNvyNh4Y/RnwhJTZMBndCly7t9zrFJY/4zdxg?=
 =?us-ascii?Q?wrq7sow4pXgkgY55wibf9sVPno7nj+8f00LY90cngsZf4a4g3P3PidstHspV?=
 =?us-ascii?Q?zEEw6qDdb4zgkfd1R9Lggkq3fidSPDUzBP89QMSOKHytqcvH0lpfkJn8u/iR?=
 =?us-ascii?Q?JZq174XZRoeW2cCGpmDzbOUy2lVVa0SsnMJF2Y+od1twrDSTkzd/wmmUvlUL?=
 =?us-ascii?Q?8saOQxdpdSDf+AXNIWkw20M08uJ1FfEtBT+6TLHcfY099owo9khM/hVAlLQa?=
 =?us-ascii?Q?9AZqfz3yY+EAGrpHvXv48ORB+iEgIeccZV2ey3wLSexY6pmZGOzGxaa7ofAy?=
 =?us-ascii?Q?LsmNKFIgHUx+6Kd4UBkpMZkjaM9GleURNg1BIwfkByKG82QUrhKKy3AgvE0U?=
 =?us-ascii?Q?limECsXglJKd2urMeMrmVMEy2SNmzeOklYyGc2j+O9/aCtBWophBi+HVbXLF?=
 =?us-ascii?Q?7OnVl/Sa1ML8tRnTOpqT5FQudI+oYoz/BkkxFv2B+dt2FiFkC2owOwxZy9xE?=
 =?us-ascii?Q?yfDwMHmN4Mdu/c3ABWy+rUyvIikvwoq/7bHFHZnzPT3wuX2mYwNkQbMYd+Vy?=
 =?us-ascii?Q?Bp7UQnxb86NgJPvuB3hoDyln+6OwQ4+LKhA9FhvTLt7eOIHp9cegU7Z5w/qU?=
 =?us-ascii?Q?2xb/Dx+QWV9E0Ams+X88Ni/ZgMg0qiXOtWXEYIEaPZo+qHO/w4A0j8Nmbpa3?=
 =?us-ascii?Q?E3coB1RJMpfgflAltBREoLyRfw7HwQdLCd22Rnw8wU4gLvhOX3s2vlLkMaaQ?=
 =?us-ascii?Q?nSb3D7nskFx3vtPz6ZFInkq5HVAFxGLIu+bfy9UOWassb7L75LCvpx05GfaR?=
 =?us-ascii?Q?t3ei3/yx40iKjn+sHGAMaV+E7oEM6Y+1FPnuEuYLsHl9WXFTmd+9Ea/O8p8C?=
 =?us-ascii?Q?IMtgl+5eiNjslM0v0T+R9t2xMZriBi8hC1E5zHisLeZuuQ+K/lNMY5Oyr4ZI?=
 =?us-ascii?Q?630Ry4h2Ls3GmFi+me/xXyXh8kYBW5cPC4GHHbmZJ9Oz+d9Cixak8DBzHByX?=
 =?us-ascii?Q?8t4o4Mf+PK0Sb0sAaFhe9v+Oc/PWjAnSfDP9gbA1J90Oos2J4KOuG40iwvPq?=
 =?us-ascii?Q?5k4/2wcbRGRMmq8WytH4wwoIElKJAqPmnmpMfD105w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P8ka6OseTl+UsO5Bkc9CL7PcPA09ucVP7UwciL35YmS7yMfcKY0uXRH6Eq5a?=
 =?us-ascii?Q?8Fl+e9HXR2ikVgjMVELKUO1xT69ZS3ITaAhdjfRE2bPg9wvQMNWbe6wf4ILs?=
 =?us-ascii?Q?sZDq4m4+CE5B8Nyt9ygYyOR95nSKWVsJ+QTcFoi7xR/x8xM76nsW9+fN9dMd?=
 =?us-ascii?Q?9jPv8M40e+ym9CkTwuuB9rBZOctSk136TbUvQ6AaDFdgPivgfZjwTB4/fHD8?=
 =?us-ascii?Q?xhLBLoPsbrjyAX9wG0EVTGYX1VsSC+Oehw1epn/MWCYmt0fnN7AlPX1Sk6vx?=
 =?us-ascii?Q?fNz8yG1ycy2eEUYXYM54Q8lODzz2PgImQuS45WcADK4931TIzI3fkwXlTb5I?=
 =?us-ascii?Q?xoidDeV1Dy18aDehUx1RoE9YO0cXpp1bucodXjhlxRUvHg4MztJ/WIOVxXYw?=
 =?us-ascii?Q?u3vEmtQbA1FI7pwcvZ6JvJhQOJYgzmuFsVseDzrobo9YM+2OMZN5waRCzKgy?=
 =?us-ascii?Q?HrbCm9uLVOBLnPL65p4JWMFY9TKySYByuPKwPS9DxlEaOyK6UzRQmP4zUvTX?=
 =?us-ascii?Q?nqaye04t/gQPVvUZmLDWrPjvnucx47fe2ncMxVFl7GaMgyHmHfPA+XWGKPbb?=
 =?us-ascii?Q?HUg+86nPRNoN9lL5nL2LxmNrDyVvGj0gKkvHEcZVbUMTyo+x1KmMS3ROIxJv?=
 =?us-ascii?Q?+eNMFYkVPbzK31QWqKRy5nEvZq1glfGZ7ldMHzT9o0Il8x79FFU3nOSy7UWE?=
 =?us-ascii?Q?EhzZXG0ctCJv0qr8M6s2Vwca6izLH7u1M0b/jF9jE3RxuY5pErPlpbcfFs9d?=
 =?us-ascii?Q?stpWbBvaTsIaqq7pUeqN7hM969JtUNyyJgDL9sIhOsmg+1vd282Lcc7LHoZh?=
 =?us-ascii?Q?vUJt+EB6AbVT5NVz4MBza2x0gSUAXxgXPaG/iDa+gSdZRhKAFJNriP2w2iBM?=
 =?us-ascii?Q?hweS+7zM8cnz7nh96ZaF6lJ94o2b/RnWu2rmix9tJgRNk1tDREh+1RaAIr4c?=
 =?us-ascii?Q?2IW18Lo/qo03i4kbM5ZCoTrxKNYZyYB86FTdWmiIpBJ2KAzsveWHv1A7KLNm?=
 =?us-ascii?Q?Dee9D9edIDTakqwajFkzWXsWxuP8aD4dL/p/3wnJL4dCZSWuM0wZTUEprqMQ?=
 =?us-ascii?Q?+SYs3W3VZl7CHcWrIpAahGEc3qwlHZ2Fu/ZqR7jJwdSNx90ULdkBk3ywXCSd?=
 =?us-ascii?Q?n8+nVmKY0bFZLxe+54Uis5esHTLuZgJx4HBiEOgY0ytu1E9MfiXkg0uH9TGY?=
 =?us-ascii?Q?HoqhBSyHLPJ/wQDf5QsXkeD12TLdNWjx5kK7UU3Ci2xXC1o0nXtL5juf/481?=
 =?us-ascii?Q?nlii229Uk1DdJP+4+G9Ur+xtw/7FFdPSBRaS+CqLy0msRzGNIHyXqbU7ceoc?=
 =?us-ascii?Q?0oIm7Sh3iG9WYxGlx/1y3X5OPriQ//X9FhMGyboOFEKzSNcgJxE7c47XqqDW?=
 =?us-ascii?Q?eTi+Oi1zc77cZvWKzMcsPHXe5hf5jjIY4m0PEzopxyPkZl/FXCPYZrHFJcwl?=
 =?us-ascii?Q?2XmKxQl+/ZoLOKnEI5GBg9MRONSCy7viOuIGKNbBXdWhAjDMIOf0bGUb5rKH?=
 =?us-ascii?Q?zhvKE0vKqLChHLmLjwgivWZpbCTrJ0S6HHcrLOor4P6p7EviAXKbVUNzbBbE?=
 =?us-ascii?Q?UyTMj6JZbcvso7gQRed1yFQAbPjSZwkZV5Jj4m5BzkQNhTaALmNsSxsoQIha?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	L5Uu5CyoD/4epAvNiOV2LN5I3aurLSR+boFBBsnWBaFRiscMMYnS3jdjhCKS/clMe9aFkPQFR2JaKs8VX1gBgeVjtpLA2pPfp0iVS8tD3TDACLH/qCFDLlVnvAE6CxG7QLLTsxmiqTHaIyw4xwhFaDMKkxFT8PPcZRjsOWO6x6qTi23Kw9tTC+e8w6TJ9OWZi4zAOnM6ykGSgCO30inDL53uZZou5MKSv6ySvM1puN/GK6writGtHh1yZ2DRgKdy1pIlStj8Chh91w2M8Y5xnipQOKtuCJxsMaGSO3K/AG+8R5VOvXkHDL0ClJfKRnBxK8x1LmcD7P/OtTib/Plg+h9iX8k6lUthaqX/7fVZIiwq61U4GySDKYPvMLTMj8FzEyaAQIyl3MXMbHcivl0IDcHXGRCbgU/qrMyihy+uJGw38f/ttCUc4F6ubFOVQUVzT3O7jeu7qOxOorMh6c4GdYH/uRPGZTztAYR3ldwv0extpOZY44cJWe8uhzokW7/xZQdi1rY20SroXDsQ8ICFVNZ+ey6hXEz9KAoKS3uvzLwqFTb3g9OOYw3MsY802y3Y3yzblGNJ+Lp7He7+E73YioR9829aFTvXLTqS+iVlHtc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13bcf6b9-0ebe-4829-3b9c-08dce895644a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 19:05:51.0793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PjPfZDbudgZvowpsZrIowmHPfveGJ74tgc2so/KCv8CCtS9csx/2SlcqRdDZ4JuHuTuG7IkBJDJfOvKBQhtkpPw33xc43NVUCnw5FTqYKIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6514
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_17,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=649 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410090120
X-Proofpoint-GUID: o3sbUCmOwkjMouN9lKdFk-e1ef_hjTLd
X-Proofpoint-ORIG-GUID: o3sbUCmOwkjMouN9lKdFk-e1ef_hjTLd



Ankur Arora <ankur.a.arora@oracle.com> writes:

> With PREEMPT_RCU=n, cond_resched() provides urgently needed quiescent
> states for read-side critical sections via rcu_all_qs().
> One reason why this was needed, was lacking preempt-count, the tick
> handler has no way of knowing whether it is executing in a read-side
> critical section or not.
>
> With PREEMPT_LAZY=y, there can be configurations with PREEMPT_COUNT=y,
> PREEMPT_RCU=n, where cond_resched() is a stub that does not provide
> quiescent states via rcu_all_qs().
>
> So, use the availability of preempt_count() to report quiescent states
> in rcu_flavor_sched_clock_irq().

A note about the inverse of this case, where we might have long running
loops which only temporarily enable preemption and thus would be
unlikely to align themselves with the tick: in prior discussions [1]
Paul had pointed the need for providing for forcing a context switch
in such a scenario.

I had a patch which did that, but I think it is unnecessary since this
clause in rcu_sched_clock_irq() should already handle it.

   void rcu_sched_clock_irq(int user) {
        ...
        /* The load-acquire pairs with the store-release setting to true. */
        if (smp_load_acquire(this_cpu_ptr(&rcu_data.rcu_urgent_qs))) {
                /* Idle and userspace execution already are quiescent states. */
                if (!rcu_is_cpu_rrupt_from_idle() && !user) {
                        set_tsk_need_resched(current);
                        set_preempt_need_resched();
                }
                __this_cpu_write(rcu_data.rcu_urgent_qs, false);
        }

Paul?

--
ankur

