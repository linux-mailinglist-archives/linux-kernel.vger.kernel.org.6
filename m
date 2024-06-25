Return-Path: <linux-kernel+bounces-228151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37CC915B83
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 03:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2EA51C21839
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 01:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DC114F90;
	Tue, 25 Jun 2024 01:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J1FnHQkg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RnxjTXbB"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9CA12B93
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 01:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719278037; cv=fail; b=T14Z7eH2sfq5wmvoRXbn1cxjfMydFifIL54/BYKrjJ++CO4Q6Dd68/DkgkiaEEdM3Aq0d4QJ9tkZIu6SKi7sQYUReHL185uWvVW3hPRdOscRITqPwdDPkg49uuHFCfFe6fdLGGOWpm0sxEx3Sk0KSzFq0mrISvbPKe8E9yRD4Uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719278037; c=relaxed/simple;
	bh=XaHzs+H0ChqEKGcTk0v49g7WZc+wql8LbBuCSMwxw24=;
	h=References:From:To:Cc:Subject:In-reply-to:Message-ID:Date:
	 Content-Type:MIME-Version; b=RckCU9r4QlK5IwudhYHKSu7iRxbGTHRHCIM4Dt/3xKlJLh7jLBUp8nLgFEIhutMylqAPBWX4EPZVKt2I8tvdMTLXzpo3yYvuB6rJFVuwMS1k5EbUg2v4H23VT06dPXSNcHAakNl/XSAstyR4Kwj/V9nw7ob07vkl9CmkcAT/X9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J1FnHQkg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RnxjTXbB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OLaKhe026189;
	Tue, 25 Jun 2024 01:13:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	references:from:to:cc:subject:in-reply-to:message-id:date
	:content-type:mime-version; s=corp-2023-11-20; bh=EVscN6PXoKes6I
	8DIB2S99AGdqM5d9beD17M6/wLPxk=; b=J1FnHQkg+UHIGafo92sjmads1yoPNR
	GUeKU4MLBNuPTv8kgoXXbQmToCTb+sFBRHAasyfqEExvfSPFeD5tEm4HvPzdD4KC
	3V4em0Zcc583cZJf818zSxnVGesHhFvOsnq/iEty4/xK5yAbe/ZaB0Ktw9YkuF6D
	Mt+sSv0JejR5jf2uSEb7MvvFWU2tM7KrmXQT0rlz/bRFeBhJPuqOBPFHMbuKzx/9
	N3eT5XtDvi8R7YLyeOCsrBkTxlggLGjwDDNvKjon4JGp1Vf6aYwgwJYTWKDg4+nr
	c6S4bas34H/EEn9EJIXt2fsQCKPFVi8twPKBEtJHb/Rua5rGSc5I6cQQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywpg97dnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 01:13:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45P16FEO010825;
	Tue, 25 Jun 2024 01:13:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2dbmsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 01:13:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nc2qXpPANY5mbv6a1BS3QHkjFAic4peOcP7VtmjsyD5Vkrb6QZ9eT/tTsltxpaVvmmKtKjHKwenjSraiJklMiR7zbK7M2h9cUfPLzjSnj7j/COhCoBT7I24bLOP7c1r+xcQpseG08bwEITza98w4tZa4d8v4laNyO31JyoHqs6WXV4/lA/3UAtQHHpW4gwnMOphTpOa0qEhAst+uBGMKBnkyPpssdJZUYvdkXK9rWyLs/He/LjsN022h4ZvXsIJTt3BFqweP5wh+gBYFkOYoG6s3RjEfUCp8opE2jwaX11zhad7RCiKKWK0ifjJd9Qrxz4Z6vwHQMBsnHJM8Mw/3PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVscN6PXoKes6I8DIB2S99AGdqM5d9beD17M6/wLPxk=;
 b=JUwkIxTmVLK7xdC04ca4q8SsFPun3OmZrcDay+JXIovQt901K/xZklL1N7JT+wzpB4x30uMUXLqkic6NJ/3zcGECFuxOYydiq+ekeNYN+piD0/2tOM4X7CwhIHLC1VzOmTtrNG5cuPgQWKPRlhATXMk/e9iWRE84w2afCIG1aVHhMkCZa143ng1ZCpvajrkuHcQwWEQFSDEj7kHt7iZmbIvZQ8DPD5pXgR+Si+CNKgLdBDTX6mHLOMEqlR1uwgP0E3TP/dSO/BRJP05+zBSHve94qjBkPUNlGFdu5TvWG1AQbavZCZcRihvG6FrZdGBuMfS8V21FC174+6sZYnT2Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVscN6PXoKes6I8DIB2S99AGdqM5d9beD17M6/wLPxk=;
 b=RnxjTXbBIcXcyPyP9TaVxJSQIrGkJ7ZzwMytnL2rjwt/zCbkqojQkdE80F8Qjx1wYByAzfGcmqeNMwCk9Il+Mik1UdlMU9UoOHi7KyVMO1pUD91Ah2bAcf/0woFce4HGrUULarrbDiubLZKxLEa3RryGmR+6iRS5YSo1uw6gGbI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB7801.namprd10.prod.outlook.com (2603:10b6:510:308::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Tue, 25 Jun
 2024 01:12:52 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%3]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 01:12:52 +0000
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-30-ankur.a.arora@oracle.com>
 <8e6f02a0-2bd0-4e75-9055-2cb7c508ce4e@linux.alibaba.com>
 <87h6dmazs5.fsf@oracle.com>
 <dd6c29cf-3ca0-4aa3-8cfe-e85a35e300e4@linux.alibaba.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Tianchen Ding <dtcccc@linux.alibaba.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ingo Molnar
 <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 29/35] sched: handle preempt=voluntary under
 PREEMPT_AUTO
In-reply-to: <dd6c29cf-3ca0-4aa3-8cfe-e85a35e300e4@linux.alibaba.com>
Message-ID: <87ikxxakq5.fsf@oracle.com>
Date: Mon, 24 Jun 2024 18:12:50 -0700
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0285.namprd04.prod.outlook.com
 (2603:10b6:303:89::20) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB7801:EE_
X-MS-Office365-Filtering-Correlation-Id: cfaadd04-040c-4f4a-a1ff-08dc94b3efb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|7416011|366013|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?bwGd71lGwQ7qamOH3uvTbLHwhj7we9V2psxiCUt+Kf9V1jIbNPpmioC+sWpS?=
 =?us-ascii?Q?kEsD/cNqmOUaz6IfzySsfiLlWeTYVjN9NCD7zmH2HTFdFmjP5udv1MzU0Gpm?=
 =?us-ascii?Q?oP+potfANsv85gCjy7LZzqZGCqRe9ctnlvhyj8m0joitUAvW0uTTc4XvWWiC?=
 =?us-ascii?Q?HdAFb63Ief4QGNWdqpWVzbubY842wahKP+qczmF6cRIQMAjKt/UxOHNvsLpo?=
 =?us-ascii?Q?5SxgdA6OsrE8mZLq9JjMtRTLDJLP9u8T6Vy0sy7RnB9Fd6QTDkIwSG0VWCG/?=
 =?us-ascii?Q?HB0vrA9Yfoczypq/NxOp+tFg5yqVM/m+wuVg6Q+d1Gv78gS2I4oXuwKA55iQ?=
 =?us-ascii?Q?M6oCywdqTBAFDgHdeLbEzfH+P4wGzznLpOa0xlkapt/+JhNUsEoAA07JYCIT?=
 =?us-ascii?Q?x5iR0LeXpJDEsnoIwNO7jc66gw6fg3UrVpNpObSjQbHsP2r7ShxOORGlSC3E?=
 =?us-ascii?Q?xT2djuaLoBLw71XYJmHv2H3jkkFVwphZQImPenCmAuN1l8g6NTNY7r7uOc7m?=
 =?us-ascii?Q?zW73i0jFj7sAGL2HRIEtQXLgZKbqDsmJBJaM1I1A+eRbKVp4QtjEFz4x56GR?=
 =?us-ascii?Q?kHlr4qvrW1Ddcn9yzBZIjcdXolwM29atQiaJxPeYj7ucA3M0kA14PxkngnGm?=
 =?us-ascii?Q?7hI0r2+aCMWfMpwtrTgVo2DaATUmvAfZTS9gs4rqceph53X/076y99ejEMb5?=
 =?us-ascii?Q?/S2SXrjWzQUbmXkreCG/Vspkhr3V0hT2e46pIfgA9zb7dHRfL6tUKJCoDQS+?=
 =?us-ascii?Q?NxUZkhCiz1I5dEM/CacwxF+R4nxjbm+m2SB+tAxGUtQx2Cqi/PbeZfTTR71j?=
 =?us-ascii?Q?q70orI8++euavulkykWS7m+Xa5kMK9JIplQeFwrdccUYNRHkKSRBWyTP26cO?=
 =?us-ascii?Q?sh9011bBzJz3kYiH7aFW0aI/ACdj47jBqn4/yvwC+CK47/ndRugrItqctHsA?=
 =?us-ascii?Q?XZk7+4e49AFIERxxbKF8PnDOQ1aw1d18TqIWv7YipkRgoXVQHqe9Xwim+gof?=
 =?us-ascii?Q?4LGxhuhi8jylKq9WyhUYRFp73z/2+cVZ7ogDVv8xIB4kt653FyDWEVtMzfYT?=
 =?us-ascii?Q?K2grdQwH+JS93bD/C83ldIyWV8KrEpTZ+OsRmDbzk+R0Qgo5YK87ZpKSfYDr?=
 =?us-ascii?Q?Qg8j3UNxSBBc0iMGBoYha7EfINW43kyHIp+O8RfJkS7QI1j1jmFJbE3WHHqo?=
 =?us-ascii?Q?/rxrhww2TYFCugBifEn42usIfSjodMXCmRiH3ixdge5wPuFFvkBCqGbYjjgf?=
 =?us-ascii?Q?xgELZJ6qInFlEp/leZ+2?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Y03GRWJ0LGdmR7kBoq85gfdiTvm3WXhPex4uC6AIYDN69P8Gi4vvIAzE8jCk?=
 =?us-ascii?Q?ElcG9/hAVsGwL4PulSmwRybiDFPzNct/MLB5sq2WDI/rJl/56auGYlBGJqlr?=
 =?us-ascii?Q?WdvyyWBRsLqYlNPxz7LF2Ga25awSuXGnCyG9yYyercMaCCURN28/hnDC0DsJ?=
 =?us-ascii?Q?ghpMrgMHp9EO43lTxRhxypHXBS9PH6j/kmx8VQ0Rud7w7brRH4IuREgKqfRj?=
 =?us-ascii?Q?OVEULNkgCJFDDW+zCKjMo65+iYKihhrEmooz4aHcVO4jzTI7zIFcbQHRmSZ4?=
 =?us-ascii?Q?R4Kw8Bp6gjkuuEDOVEADUny7T3BGZFlHTTJdPXqhejzPP+ZgE1oi6/2Oi6eG?=
 =?us-ascii?Q?aOu4OrEF36VVwCLwNSetCHR50Vm0ZJ97EOkjZ9aQoWI/1hYWDqFIUWqTMWtO?=
 =?us-ascii?Q?OinK9GXAxawerG7iI/xXs1+oUJtYQFMxWei2ce8HN6NFAwmhrUAN4R0MPOXS?=
 =?us-ascii?Q?AbIw18t8dVGbBY5PuO+47E6X9DYeTdx8VvZ2Ew4ASAUBzOo5JaMf7Z3Y77ys?=
 =?us-ascii?Q?CbdEEcwLR0QwJv7bR53wGPCCALmORFZj0GxQp60G4GZgpV0UeQSjFD7i59No?=
 =?us-ascii?Q?agSPj66BEdb/k8gmovuEFsVgDNkxiBj0OSSxlhMDZv4L3s7DFDjEYss2yvxE?=
 =?us-ascii?Q?QXHBpsgLbspfSZvHM0a8dP02rJ1zfQz/Asnsxc40WmUOfaWaoKdp8O7ZpxKK?=
 =?us-ascii?Q?D/hsFRfx+DQEXU0U0IbypleHQcZliCdo1dRG4EPfukx2OzUoXytY9lbhI+7f?=
 =?us-ascii?Q?Dv/Zkpqm6OTHAk1MnqTBIQU9d3jOcVAgphbRApQ1GwWwoRBL/8QI5ERheJT5?=
 =?us-ascii?Q?G8Ws0V5dT+SSQ7P+SpAopD7a8MfzeaZ/gWsmBjmucw3dlPMdg24UBW/9WjoF?=
 =?us-ascii?Q?hx5jhUwxvk/Qyfj7u/wl/dOgXUCDU1nStIDtfYvx+Dg+mkthprmd1oJzutzn?=
 =?us-ascii?Q?4Chd4GCzlhOCqkPvGsIGz4C/oX9jzgTRZzGYF3Nr/Ti7KLqMNSdovUjdXNcj?=
 =?us-ascii?Q?Kal6D9Wkbl6/CBwTfKpcdEhLrYYVXXlNQzabjH515EbA6iXy+VOfDqhqByWx?=
 =?us-ascii?Q?9823oD6JXN0h8j/BHd3mSyDV0A7zanJ6RsQuFaF9ymBITTPZM4UoOTKRzORa?=
 =?us-ascii?Q?v/YAJYOcHX5fm/pO0qBs7559o3/uowUfjAMfJYYlYCyeqAYU7JlZNqEgnZjO?=
 =?us-ascii?Q?a2oPGqsenctg9tViBY2oNepSB2fzuCg923O6js6hoJyYGIH9FJ2vI5/i5pg3?=
 =?us-ascii?Q?/5zGctscO8yopLAhsI4pi/ELKAjqNLA3JeXdUnRhWMMpYYzUtufOXk110bsO?=
 =?us-ascii?Q?U7NsHD3v3QYNQBS08+m4v1rgYeFaG612BmhyrJ7Gi8atdyeN6o26XFBsZ66J?=
 =?us-ascii?Q?UUH4DbcVxjDiWYy3sx3Pc2AOw+etZD6wFsdOtLKn5pWDONPObnwDOS8FkjFD?=
 =?us-ascii?Q?yCmG6GvjbXiohav3iBN8h5ESyNBpdKMjLr+dneucXYIM4rRJptM0/k3Lw+5M?=
 =?us-ascii?Q?zcG7YmC7rD+SiFZiU4fcv0MrM94fl6MDGSHktIv0lpL5Dqdjy4jgiLUBWZN1?=
 =?us-ascii?Q?CDTqRLFb17WLyXfVYFmRpHYdTsqIl/D0gJmJya07pJzuWKAxvQAgLrc/JC9e?=
 =?us-ascii?Q?bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TmzPIr2vURR2MsS5j1EzSW911PCWiS/FIySpiAPxrMZ724Vxb66/6e9g8pPPVIIQMg5jZhn1j+mCgLFzrM4Y419XR2hjE0EybQMRkeXMRcbwOZkBa+zbqLKeN1RipNmNM2Hy8oaC5QC7M7rEEg4nYql8JbodZwOcuqUWtg16Z7zxrEJj3QtUXalSqFkJdWXYTE3j/HDC4xGXEXQ1Iszso2F52Sv//gGsVsMBIRtw4VrkMCUDchZda6FWtsX4ALuAmnbSyK1uZnaTrVGeURrXPKveKECMPabwnIg+8E1HGf2C9H1j5FmcM02qHMEJjIR6sPZiFCS4H7GRqbmp4Kpudx6MCcosdEJ5ZsVMt9fbDYNTTGkAkp/hGdwJNiXNcLxK0P5YYLWYCyS2VSMWnyXMUrKVO+fCOBOvqC3+R4O6nPLAkfpQqRcr0ybFDl+rX+bnad+jOtSToCY9ErK1yzujIC+wvI63x/4b2sV/ClhRjUX4K71WrZ87sVut12Lf1D9Giyzdqym05S1vzsRrB5wCe/VugG1HlkZR5JZjlh1TIscNqGsV6+E+CzPNS+3n/pTmdGy4Nc95oazUAM1fu8B7q4WsmOBd5TdbKKgoDIyH55s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfaadd04-040c-4f4a-a1ff-08dc94b3efb8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 01:12:52.3859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bxXf6ewBYYGM1aF869snWv7KCobL+PGGj0J6iI3UqzV4r5BcgRhooEs4Zd1auqLETp90UXsab0a/ju+1zgenJgyd+xxzOZt3lS50iiFA0Jg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7801
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_22,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406250008
X-Proofpoint-ORIG-GUID: ah-H-Vh7FJptzYIr6WLKiw3Z42kIQ5SE
X-Proofpoint-GUID: ah-H-Vh7FJptzYIr6WLKiw3Z42kIQ5SE


Tianchen Ding <dtcccc@linux.alibaba.com> writes:

> On 2024/6/22 02:58, Ankur Arora wrote:
>> Tianchen Ding <dtcccc@linux.alibaba.com> writes:
>>
>>> On 2024/5/28 08:35, Ankur Arora wrote:
>>>> The default preemption policy for voluntary preemption under
>>>> PREEMPT_AUTO is to schedule eagerly for tasks of higher scheduling
>>>> class, and lazily for well-behaved, non-idle tasks.
>>>> This is the same policy as preempt=none, with an eager handling of
>>>> higher priority scheduling classes.
>>>> Comparing a cyclictest workload with a background kernel load of
>>>> 'stress-ng --mmap', shows that both the average and the maximum
>>>> latencies improve:
>>>>    # stress-ng --mmap 0 &
>>>>    # cyclictest --mlockall --smp --priority=80 --interval=200 --distance=0 -q -D 300
>>>>                                        Min     (  %stdev )    Act     (  %stdev
>>>> )   Avg     (  %stdev )   Max      (  %stdev )
>>>>     PREEMPT_AUTO, preempt=voluntary    1.73  ( +-  25.43% )   62.16 ( +-
>>>> 303.39% )  14.92 ( +-  17.96% )  2778.22 ( +-  15.04% )
>>>>     PREEMPT_DYNAMIC, preempt=voluntary 1.83  ( +-  20.76% )  253.45 ( +- 233.21% )  18.70 ( +-  15.88% )  2992.45 ( +-  15.95% )
>>>> The table above shows the aggregated latencies across all CPUs.
>>>> Cc: Ingo Molnar <mingo@redhat.com>
>>>> Cc: Peter Ziljstra <peterz@infradead.org>
>>>> Cc: Juri Lelli <juri.lelli@redhat.com>
>>>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>>>> Originally-by: Thomas Gleixner <tglx@linutronix.de>
>>>> Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
>>>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>>>> ---
>>>>    kernel/sched/core.c  | 12 ++++++++----
>>>>    kernel/sched/sched.h |  6 ++++++
>>>>    2 files changed, 14 insertions(+), 4 deletions(-)
>>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>>> index c25cccc09b65..2bc3ae21a9d0 100644
>>>> --- a/kernel/sched/core.c
>>>> +++ b/kernel/sched/core.c
>>>> @@ -1052,6 +1052,9 @@ static resched_t resched_opt_translate(struct task_struct *curr,
>>>>    	if (preempt_model_preemptible())
>>>>    		return RESCHED_NOW;
>>>>    +	if (preempt_model_voluntary() && opt == RESCHED_PRIORITY)
>>>> +		return RESCHED_NOW;
>>>> +
>>>>    	if (is_idle_task(curr))
>>>>    		return RESCHED_NOW;
>>>>    @@ -2289,7 +2292,7 @@ void wakeup_preempt(struct rq *rq, struct task_struct
>>>> *p, int flags)
>>>>    	if (p->sched_class == rq->curr->sched_class)
>>>>    		rq->curr->sched_class->wakeup_preempt(rq, p, flags);
>>>>    	else if (sched_class_above(p->sched_class, rq->curr->sched_class))
>>>> -		resched_curr(rq);
>>>> +		resched_curr_priority(rq);
>>>>
>>> Besides the conditions about higher class, can we do resched_curr_priority() in the same class?
>>> For example, in fair class, we can do it when SCHED_NORMAL vs SCHED_IDLE.
>> So, I agree about the specific case of SCHED_NORMAL vs SCHED_IDLE.
>> (And, that case is already handled by resched_opt_translate() explicitly
>> promoting idle tasks to TIF_NEED_RESCHED.)
>> But, on the general question of doing resched_curr_priority() in the
>> same class: I did consider it. But, it seemed to me that we want to
>> keep run to completion semantics for lazy scheduling, and so not
>> enforcing priority in a scheduling class was a good line.
>>
>
> OK, on general question, this is just a suggestion :-)
>
> Actually, my key point is about SCHED_IDLE. It's not a real idle task, but a
> normal task with lowest priority. So is_idle_task() in resched_opt_translate()
> does not fit it. Should add task_has_idle_policy().
>
> However, even using task_has_idle_policy() may be still not enough. Because
> SCHED_IDLE policy:
>   1. It is the lowest priority, but still belongs to fair_sched_class, which is
>   the same as SCHED_NORMAL.
>   2. Not only tasks, *se of cgroup* can be SCHED_IDLE, too. (introduced by
>   commit 304000390f88d)

Thanks. That is useful to know. Let me see how best to incorporate this.

Side question: are there any benchmarks that would exercise various types
of sched policy, idle and otherwise?

--
ankur

