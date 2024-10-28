Return-Path: <linux-kernel+bounces-385731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3349B3AF5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A171282A97
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3981DF26E;
	Mon, 28 Oct 2024 20:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DXnqAOda";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="quF4QnTu"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E823A1DB
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 20:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730145661; cv=fail; b=qNuINgwNbpuPnY2eED/TZVDKTiIzSwN1rQfo5bBmPUZaUco+RKhIZFR18P5/bsxteHJwFXF+Y5dd4lBooqSBrjQj36xRI50kRhBgfM1y3z9Ep0d0RjcyKTMhXVuG9VPHtrl7ztS5JYCmucglYMZUPNWNACA3tp52m2p9SDh3uss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730145661; c=relaxed/simple;
	bh=8hUPXeMUo8sPOn/s6XHPVLcfrqwuEzt8JxSDLyT133E=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f3Du2qKTL5HcDuHwgXGdAmDhPncBN7z9ZRFsCb8NXXTB9YmyRJGBaJKVGjrNVERi6KmAQnQVcfkMJ9fChC3k7jbPnvfpIqMZyRcniqEtpbraraY1Dldg4jVjV0M+1C9exu8JgTS3dGovQsLNYcLv/eEpZ3b12w439qmCDCOsB7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DXnqAOda; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=quF4QnTu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SEteY1020913;
	Mon, 28 Oct 2024 20:00:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=tW3z49q3pjdZme/Fhj
	5P7iu2FEcFFHDI7UikbqdQmqc=; b=DXnqAOda8lhWdwv34j+KyNWd/ue8n5gD3N
	LaGxUP7hXxWrQx1EJf6cZtvofuP6dJM7r1zN6I+EMyV6G+DcBF1xMIA3ZkDqGMRh
	wqhiI0wd+ZSR3GXD8UmaNxYYSc2DmFO3Sef96LTGmRmhR2wIt3Zhjtw+czbQvbX+
	GdiuDiQxI8YPyBxmpcmbd/aGPblHZKGiCuK5gRMlMCYIhx5lK3Rfn+iWWiXsISa9
	GHfl8cktD0qya0kcqCkQKHNGkHgVj+cB0DCO3waey6ICrAW2/xHbQfnaKDdCm7YK
	h35KaPvALXxCDjuZfhTwrc3xzEg5pDBRfbr1nFguSqokPlQIodGQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grys3uh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 20:00:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49SJ7Chn011834;
	Mon, 28 Oct 2024 20:00:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnabajv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 20:00:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wHSk47gzq96zAfVcWCQEI2zhj3Bl/z66ooeye60vXVAAFLK+DhgGHm8GSQWJKzgxNfjRuZEDtqDK+p57vwZGT0MCgHuRxESt2ScAz7TqEoWhqchTkUx867vqjG7z5Xr0JhUrl0hzCzBreR721dBYUl3cK52mK9+UvETP4t9FjhIdARfDm7yIZous46/quJhKsTbsLwjmyQSVWnp+k7hkaxnbiqPMbX3WvbJoH4yqe/Uxkj6FoKkFLE5qMKjsHfNtbQGPQyJQvHyS3JXTd1tHm1eEQJt0MJKf/rPxiQmNOgjjNDwLGvDZdD9Ex0YXPnelE3IWa+1PuF8w8U9RmugSbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tW3z49q3pjdZme/Fhj5P7iu2FEcFFHDI7UikbqdQmqc=;
 b=qAAsQXDM9zyCk32ax9JWHPzFUUZcPmwHxE8DQpdGc2NABI4152ezfQxU83bcziwDG8fICjEagoEvTuiLiyjC58RIZ980rC1IUcS2O6e5Bq8O3ZvFCMahvFUhEjFy+EwE5twxE1Xl3qNtSvk2HYg8NnACI3h9Ox1pJB6o4isBRLjZX8gA9sOAHaKVSShJ40Os9sftniLilO6w5jJuu+NhXaE7uXS+Gh5ZRlJG6P2qD3PjfA7l9574JWMQQMD5Gfd6Pieqxv4jFmdDQlLd3qx8kvq5Ai9re8+CpZPoScbkizpIA83KCgSNaAcrEaMzUVX39BxqcxvSFotuCojbu0ya9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tW3z49q3pjdZme/Fhj5P7iu2FEcFFHDI7UikbqdQmqc=;
 b=quF4QnTuhVADEJ9OdqnMBFyibu/P45N2S4eChZNsT8EuyOVgK9L4hQGSa0/7aGyTm4xf7AJhbDUwiIbhv5GxgsogNsTukyaOWRlRBGspLnROFsAQopsf+7ZzQa1hgCIGPTXLX9erCzQKS1/HX46/hJZRCmjck+t3gGKM3GhMQzE=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH3PR10MB6738.namprd10.prod.outlook.com (2603:10b6:610:149::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Mon, 28 Oct
 2024 20:00:31 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 20:00:31 +0000
Date: Mon, 28 Oct 2024 16:00:29 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Peter Xu <peterx@redhat.com>, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: [PATCH hotfix 6.12 v2 4/8] mm: resolve faulty mmap_region()
 error path behaviour
Message-ID: <ykzmur56ms7fm4midi6tbncjvcvf7ue4lp7e4orblrmwnefw3e@oa3enlpdrcrr>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Mark Brown <broonie@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Peter Xu <peterx@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Aishwarya TCV <Aishwarya.TCV@arm.com>
References: <cover.1729715266.git.lorenzo.stoakes@oracle.com>
 <6e8deda970b982e1e8ffd876e3cef342c292fbb5.1729715266.git.lorenzo.stoakes@oracle.com>
 <61461dcc-e455-450d-9c01-5465003fc31c@sirena.org.uk>
 <c24a174d-c8f3-4267-87ae-cf77fa587e82@lucifer.local>
 <CAHk-=whD9MrPwPMBgVG16T_u+my8xYtZg2tUGz932HeodVX7Bg@mail.gmail.com>
 <438f50c5-8b8c-444f-ae85-10e5151f3f24@lucifer.local>
 <57mgmdx7wgfwci3yo3ggkmcnm3ujamgkwcccm77ypvmer5tegn@opiq3ceh2uvy>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57mgmdx7wgfwci3yo3ggkmcnm3ujamgkwcccm77ypvmer5tegn@opiq3ceh2uvy>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0277.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::10) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH3PR10MB6738:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f98cd2a-f02d-40d9-c51a-08dcf78b2d46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wDYm0YKiIKQLuDMdeW/EDySJy1RyYLc/KjRnmZnLgXSfV3RgKzxmG/cKcil+?=
 =?us-ascii?Q?kKWGEHWlwasRLH1RRWKzpMIYFZD/Mne8A70WDBkrwBhfDnr1QTSzIb4CbOWS?=
 =?us-ascii?Q?rh95qNJFP99XLUrEB80Rq9VuWC0TcqeMdHrpcJ1wX1gwp5IYebqE5iUXkYDu?=
 =?us-ascii?Q?U8Li7wpVHVmasw6RRLZ7GqA1V16NcU4jHDphCSA2S6hEJjQNyIzMYFWh6Cfb?=
 =?us-ascii?Q?Ir7PLusKnwM+7sGAsKChRQkxUWJrkDGPRP507K/wrNcj0+Epo/Sl71B86CPl?=
 =?us-ascii?Q?ziE4E/dXTW8sKXcbBIOOO2Aj7Hr/qDfG40hQBMjW+Tm8yEfrH4PKVTxbW+Ee?=
 =?us-ascii?Q?MciewztRoFDRINmtP0eHFxwa+GTkrFd4K1ZsaPqibY34MKoxEXjQP/P77En4?=
 =?us-ascii?Q?hC0Q0L3DJjCxVvkHCmFhKZgI/ah4l1Ds2al+MMhNmVScJreW4ZpfGHYeCj3f?=
 =?us-ascii?Q?grkOxflwHl+dwOHCpZDr3jb8gZspa9wuAG4KMiXadMGcShmlZvX6SpURkXYh?=
 =?us-ascii?Q?2sP+rFmRzFSyi6FzNC+hkkT9a6IpsuWM48Qn9BblW0kO5z0OEwbXedgXuzm0?=
 =?us-ascii?Q?iJOZMStFnsas84D87lHWGCfOc22ImIlEpPOnE1nXbcCue6VjWyRas6tw/u0D?=
 =?us-ascii?Q?Uuv7/EGlE3lmcFl07gtblkJwiQZwlNKDpnn5rTFrNLqIReth0qjQwhZHQ4M5?=
 =?us-ascii?Q?JjldW0Iy2pHh6qZ5RABJswNvB+r7bmX5A5EYi1h8PRgsoy39lMMcf7EtVHf4?=
 =?us-ascii?Q?V+w4ZsqqEE86BPTma7LQAvE6rBd/JM/Xp7f10/3LHcy4pntHQK7VchRqSCYB?=
 =?us-ascii?Q?XtOn7ZWTBwVnM+O3qExUr28QTgq80jPc56M1xfeOR8Q37bT2Bjl8uSDoqy4Q?=
 =?us-ascii?Q?i4fuwaab5ZZXQPVX06tG2Rm3BVvMbcjqJoimSjmR1aRLvvHKkTfWyA5Pbd8i?=
 =?us-ascii?Q?ikGs/OY3m803zFsmJ9jKAjx8O0ibiKfSrLPuSEKS6EFUxLolFmJEmXeRwQMR?=
 =?us-ascii?Q?XVKuPS1QmWqvcPTUqDGXdiiq6Ao8EkA4x+9RlBZstKV+dBvXOAi29sTfqVQy?=
 =?us-ascii?Q?T/dTJSTN41qcEMtlsaAvq8ybfBlcUlkI15DEr3pAHf+30nefBJzRuxd8ksUO?=
 =?us-ascii?Q?2QCMXAm1xAIBnjQL35xlfJwec3Dor6h99DkAD0sFz9BHuArTBF5Jt+1DkJzg?=
 =?us-ascii?Q?i/3arjloQACwPc1VxiyKOSrr5hcyT8J+EyL3VFLdGKy0Y47aVXk9wlOMTNAe?=
 =?us-ascii?Q?nEpCVHAA9LOrn/xAwc5JY4e/BPTGSqNB5Eee3K8/0JkUByLLarAgzH0X5Y4Y?=
 =?us-ascii?Q?QBvDtmvq7yFUBoayea+3Cavp4IwjsvZnRTueBiZHnvDJk9/tQtt2DZOJusBP?=
 =?us-ascii?Q?/lVpFvQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OUZy4C1xwCLOLklEJV4wB75CxEGlrKPeVux53bx9fLdPadsAM5HaLB7mElBd?=
 =?us-ascii?Q?gVzWft9Fvnl8LbOwsxTBLG+Uv6B2KFMf4x/ryNonNvwRzLAAaHe61DNM639X?=
 =?us-ascii?Q?ln6ZT/kpxcDoal6ew3eWF95hQbDO7lB2iT36H2cA30KM7an9CY4USYmGdo61?=
 =?us-ascii?Q?ol+ySnKPo96vWHEYw697GRbYkY7qmTEEuddMXqmW0WU37ezoec/h0qJk3CIm?=
 =?us-ascii?Q?sSIdfnwc0k3shZwcaF7NAb7dK6MV//arEgHYtgZSOAPWAdbFQudzGi+MdLfV?=
 =?us-ascii?Q?kzykhMJ9FNFvD4KYRslp3I4Gz+xT0nb39z5FDZeP6KeYcsgVekQBpELVuBRh?=
 =?us-ascii?Q?GrLT9tRuBZgCZHtFCP4ktNcp6J65oHJ8FCGFVu9iOy9q7LmOtoV65yqkQlPA?=
 =?us-ascii?Q?yVxVv/sqDRjkpeaJhnILooHR1p0BItx76ulZiCz6LzlJJvWAGmp735BflpLa?=
 =?us-ascii?Q?OsF0X7uEpkCRj0AcRSAzxMxVnR8wpA8VQRtHE+mC6Ob3Ouw+77qGBcF5ZGxw?=
 =?us-ascii?Q?njelvwLv7yO+pEkeBV5lCtGloSiWVwY0ElNPEJo+N8gxtaPMJZyfRT5pAG59?=
 =?us-ascii?Q?xip6z99aipsJwZwgsXWQpoHoNzdM99xnrZiNmUVMcalRPHzA3dmihbgADjQ5?=
 =?us-ascii?Q?qAiy43clfDnm5FkE9Xy9o0N6BnkX/Xgr+ajM9foPnC7pNkSWOnx44oFwzoic?=
 =?us-ascii?Q?ME8j3zolFfhDtNt+mHQorwqX6AasMtW+/WSXKPvD2zYDOYrIiVh96Ddv9WAl?=
 =?us-ascii?Q?D6z66Dv1CenJJvgJDQjaRPGLrNgrUqe7MEGwbQNEmATm9ZPCRgQ6gY2CkwWY?=
 =?us-ascii?Q?As5aoGkuNUeno94Sd6BTsTRxagTH8XGSrQr+fO9bSQdpoO75YbSXUK9iTIop?=
 =?us-ascii?Q?hmoAnNAlf69tRiVetrtQsuePymK64VqNeza7KZpT15mMs7Axcdzd7s/hjVLj?=
 =?us-ascii?Q?FuNFKtDpsT9JAgEI5Bv3yqy0TCFozwnpDS3xu5wTGq+pc5u2oX+W2BRW6RCO?=
 =?us-ascii?Q?MC3JGJ5uEQ8u97vtyleWIcIy5+s7NtK2v+Xw85L8kqM62K9Ini19P7Vh2eSg?=
 =?us-ascii?Q?faP7R6hLQemAIuQeJC1X+42mRzkgO3Dfp8m7C2zWa3WjetF9Pa3hcvkbDC6y?=
 =?us-ascii?Q?8MyvEiNMQVU3K39fCGbMhUh3Tx17CVCj1TSYbiQI7eIF7R8s+6Jd96+p81UW?=
 =?us-ascii?Q?etZKhIASsAhzBrK8inEMERVUyWXRMA1Z7G3alaCZ9kQRoeuGCkLJrhixck7H?=
 =?us-ascii?Q?KzX9E+Y+YsqcDKTyLFTIx8i5ltRX7V/4WVIHhuadRDv4ddEN4f6zyUWebMU+?=
 =?us-ascii?Q?uxX60TfnrqKR5jmxqMWoeGZ252WAkVpqYMhS/IdWvMZQqj5ClX8mbNUShozW?=
 =?us-ascii?Q?StA2qdknHOdIoIdpY+NYfkEUmu3hlv2t8Ei1YEwJZZIpqqlYFpkP6NYBzVdn?=
 =?us-ascii?Q?/FQE+2pgulIMY7dctaJX/dSmhPCIHaqA8tvxrt2uRVXojdlZCPCsIAIWDFO8?=
 =?us-ascii?Q?ilnO/9J9s8Xp4aM+QoRSxrVC7FUNkBJ5TSPw0LqF3mSKldSVD0G7qVp1XwSf?=
 =?us-ascii?Q?WT3SfJFoxZ0BX/NIP9Gw6Vm2KXiknvcpk8hdBEct3hF+pBT8t/R9/YQs06WJ?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OKaNDiQDmzw9e/tdtJom/xK102o7mxzKAphqdedJWE0NTno8vfqIJ6m85aeUcKIMAS5rspI22f8Ydm3dgtIBAz6nSPayeo6+9bCHaPAVYj9YvUyEfgo67I493CY8Xej+vzQ60NKJH3Day9027MDAaau1Z+Jw+Bi7159e9JFJZVS0Uk4cuMrHoesWvKqQsArJkHY/60VzsOsvzCy6mAUHv/6arj/4k2vK3qd89Bypqk34Ij6/VwFRpgITldqHchkT9qr14j5ikMKTXRgbzIaPvlBSQnx4BM6TlX/7lASBFUhsJ5Csx2KLVYm8crmHoVuH1pg0oqSHhtApj3Mdvmnce9Dmz1m25oTvI/vICUCWTA2COJnFgAEHI1InObLA0e4tfJsoKQ9b8WRxh3hRhn9dHCbQm2Qvw1/mushtgcNgYmeQIiXRhudUc+RPshuDeZHzVZ58ZAkzgO5dMpS36Q5Uu8ybfc9JQg7WhDb9cDX2qaD6/ZbBvgzZ9Glo13PlO2bA78tjYp62l0SRdfEO0AaRcVOovye7T+12uxdkOXqZE0Ob3LQssjsfDcSk/nPfRPua5hJhVzDJCK5aG9zkbFFFOWgmGjgrJJNwb1gnWHRfnfg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f98cd2a-f02d-40d9-c51a-08dcf78b2d46
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 20:00:31.3554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9F16jiNuxIGDD94n3p6rN4o84sVlr0BX/al01svuPk1o7f/bJ+EMqgR0btoARrajNMXWBbYnX56blv/br+M//A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6738
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-28_09,2024-10-28_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410280155
X-Proofpoint-ORIG-GUID: eAu1oHQ4R3gHvadNA84pYtoRQkXvhrsn
X-Proofpoint-GUID: eAu1oHQ4R3gHvadNA84pYtoRQkXvhrsn

* Liam R. Howlett <Liam.Howlett@oracle.com> [241028 15:50]:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241028 15:14]:
> > On Mon, Oct 28, 2024 at 09:05:44AM -1000, Linus Torvalds wrote:
> > > On Mon, 28 Oct 2024 at 08:57, Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > >
> > > > So likely hook on your mapping changes flags to set VM_MTE | VM_MTE_ALLOWED and
> > > > expects this to be checked after (ugh).
> > >
> > > Gaah. Yes. mm/shmem.c: shmem_mmap() does
> > >
> > >         /* arm64 - allow memory tagging on RAM-based files */
> > >         vm_flags_set(vma, VM_MTE_ALLOWED);
> > >
> > > and while I found the equivalent hack for the VM_SPARC_ADI case, I
> > > hadn't noticed that MTE thing.
> > >
> > > How very annoying.
> > >
> > > So the arch_validate_flags() case does need to be done after the ->mmap() call.
> > >
> > > How about just finalizing everything, and then doing a regular
> > > munmap() afterwards and returning an error (all still holding the mmap
> > > semaphore, of course).
> > >
> > > That still avoids the whole "partially completed mmap" case.
> > >
> > >              Linus
> > 
> > Yeah I was thinking the same... just bite the bullet, go through the whole damn
> > process and revert if arch_validate_flags() chokes. It also removes the ugly
> > #ifdef CONFIG_SPARC64 hack...
> > 
> > This will litearlly only be applicable for these two cases and (hopefully) most
> > of the time you'd not fail it.
> > 
> > I mean by then it'll be added into the rmap and such but nothing will be
> > populated yet and we shouldn't be able to fault as vma_start_write() should have
> > incremented the vma lock seqnum.
> > 
> > Any issues from the RCU visibility stuff Liam?
> 
> It is probably fine?  We would see a mapping appear then disappear.
> We'd have a (benign) race with rmap for truncating the PTEs (but it's
> safe).  Page faults would be stopped though.
> 
> Unfortunately, we'd have to write to the vma tree so that we could...
> write to the vma tree.  We'd have to somehow ensure munmap() is done
> with a gfp flag to ensure no failures as well...
> 
> Maybe we should just call close on the vma again (and do whatever
> call_mmap() needs to undo)?

I take it back, that won't work.

> 
> > 
> > Any security problems Jann...?
> > 
> > It'd suck to have to bring back a partial complete case. Though I do note we
> > handle errors from mmap_file() ok so we could still potentially handle that
> > there, but would sort of semi-undo some of the point of the series.

