Return-Path: <linux-kernel+bounces-229570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C2C9170FA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22B89286CE9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7776C17D361;
	Tue, 25 Jun 2024 19:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oxJisfns";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lnXd51M/"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AFC17C9E3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 19:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719342740; cv=fail; b=lGAepWM2R7ALzsKlEgT2dAP640/btdPvxe6Y8k/j5dDLKkbYyYjMIa7GRTyxItV0U/ckhFZp5Sy6gnGOGJUQB38yTY5mpXJP/eu4OZKw399gd0mNDAoD9LzlDticJ4mxaqhPrJR2f/ciiws9PDqfhQ4WdsgOnjCdP6NwMZxxI5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719342740; c=relaxed/simple;
	bh=yLsCZojYpceWxBcHPMJfRXfVPYQ+yXjS5NbS8G6N0SY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lyW+gjiSz+HWPXHJ6pzAtUq/XnSnEU9qHpjF+PsEfN9RkllbhnY4efAVA6IlDsGAkFYa3J3egjSAdYIS59HhS1Nuk1buQSw6gRaI2IrduKZm3BTL7clyqe+btx6fWrkN0quarVjzaIzE5nbdNr/EAv2L3H/OMhrxBplpniMZ9DU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oxJisfns; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lnXd51M/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PIfYWZ009059;
	Tue, 25 Jun 2024 19:12:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=CR5r5SlcrI9HaSM6OStIkTOvAIfiXnGdaLZK//vb76c=; b=
	oxJisfnshsrnegtJUyWxs0XdwrjdjgGlg3+NpANGu2lo4VRqCknZ1EhWGZUZFTxS
	qDcMd3GRud5uejPKvgYB3Utmn7/oqlszzudC+9QWg7Xb+mLgMJSvWTwwUiVpHgjt
	Kh8+1FtMMgfW3Pbg2y4KwVkw4Sa0kGQS/vf/XV2/ISF9JkB5zHu+pCV/i/WiQrvp
	8i9uqz1NI4tQMmf7Fv65vhE7QggH1sC394TmDn7+n13axdIX1hI/ciTNttbDuaPN
	oYSrGdJjTEJJq3HiMQKJtelJNScTGGuN+Dy3DFh12ZsVTg7q9Fe1POIGFN/Y2M6g
	7VEHjS32CRVPXvjNE3FxIg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywnhb1jqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 19:12:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45PIIVKD023395;
	Tue, 25 Jun 2024 19:12:04 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2ehg26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 19:12:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDsOvpLLHsTKZMOjc9q2IjPRbG0VeK7/soCSFSnpWcL4gx41Bu7T7U9BXWr+hxaPiSdNOdZ2sCjRvEwqaGxxJoH/IkRoPMKsVf8jAQ2MVEfWIClSno23uffvr5LQfoVF62Uc15HaL64FXDEYKfZLCq15VyFFQy6gkVPCgmeuxcbynPUXtzAlP3XXNdasGPbAgTpjeFWAodK9j1Sjmipa4OgCPKyekp1OC2texHYblpf7kyidUGDEyD1vtM3L3rwrU6FW5GdswIXXNdcJoY4QpxZjTxwoQm8/Zbw9FILJFoVM8RBk+/wEtwO3BjBbxrCIatGa4fOUHJDYOPXteGoUXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CR5r5SlcrI9HaSM6OStIkTOvAIfiXnGdaLZK//vb76c=;
 b=lWDT3LLq1phJLLLOle9+ozr7YSJgY+xjuEFn5sVYa0dCaP0TPVYQzPnol/HZcWZjb4i6Bco32zb8N3YdCaPipgkw6HhEa9R62/kvUi9hT6ge680RKZDO2CUGsmPLTIg2OOgHQwcfTNes+sJaREizDToYcOyGPMrHfaEc8idBQxTQXKnCPHme8NXRFKSbu6ypq0sBg23O0suVTNhnW1DCUVFBZ096jSa1ssk69cRLOzKEgHDQ9odpxWvGPAUIijNnUVtjgkBzDBCYWtVpLx9kkt2VUykG9eYdkTI8K902PgkJaQBIGxMoYwUph+82eBHvtDDN6hUd1Kv+xNN9hzOo/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CR5r5SlcrI9HaSM6OStIkTOvAIfiXnGdaLZK//vb76c=;
 b=lnXd51M/eh/MXJoXCVHntLspWlYdO+VLCMkVQCv+1Uvx5t6m3mhbZdsfFRJNjHEfgHZfSJkPCHCb2ebhI+DL8U2Hp2eRMKeE7z6B+4s87O2hUW4j7CR4mRRbYvPCxG6FAciisDRHcX1IXcG8c96UrDp8Erit47OxfcvWnkj3/lY=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CO1PR10MB4707.namprd10.prod.outlook.com (2603:10b6:303:92::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 19:12:01 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 19:12:01 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 04/15] mm/mmap: Extract the gathering of vmas from do_vmi_align_munmap()
Date: Tue, 25 Jun 2024 15:11:34 -0400
Message-ID: <20240625191145.3382793-5-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
References: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0212.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::10) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CO1PR10MB4707:EE_
X-MS-Office365-Filtering-Correlation-Id: 329da883-a507-4f62-9da4-08dc954ab126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|7416012|1800799022;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?R7Ic4VwgaDcjJgACyc+WI1l1n9oHC4aVmKcWrh5kD2CGSw4A836U11M4zoL+?=
 =?us-ascii?Q?lHv5Qexo6OkPySS8ztcJNnI8at7EH5wobZMNUl5oILT9U8AuRh+cUbCvPe4N?=
 =?us-ascii?Q?6n+4wx7IVobwtIJUs7xhIUSf2HdSBuqv+9k17BnOvGKEX33QYWcO2uOMeaDe?=
 =?us-ascii?Q?vdk0E94fm05PdjeqvfpT1IvcU4/j7Z8QmtLhHxrDnV4F+yUwcPlV56F7pW+R?=
 =?us-ascii?Q?uwNKvacz1cjBGZy0wB0cwQpD+3Zpu2PyMQZUOrLfalFxgxl3/i/qgeyzWmCe?=
 =?us-ascii?Q?KRTPZp1wxPnyYn0EEtNiDcLkYzSa/fvJMae0zEy2+53X0gS4AluAegMafVu7?=
 =?us-ascii?Q?y38CLPVxLklZp4J847SWRQDXn/LHW/nYT+a51EwALMcbq42tXr6XkX6b6G4z?=
 =?us-ascii?Q?JIM31GrAoM5gtJki8Ik3cGUi9H8JN9wdd7tpe5HnUEW01ekiy66NGTcjcUTM?=
 =?us-ascii?Q?WjD1YeuvTImZEVA5l81L0+2txVYBHKCc5gpwGhwyT9jKGoOEEjVnZstKSdl9?=
 =?us-ascii?Q?4Slj96+Na5WnxWG5S9vepzgMY05o9HWkIpj64ZRvRk2YCx00MCmFduZxjOEr?=
 =?us-ascii?Q?47e2RaQK/MrQCXT7TsQVsjrqO9cs+d78bQTmF+Sxs1UEVYhHpDHVlCbOnUR7?=
 =?us-ascii?Q?QcmM+on6djKl2gp1mUsyahNoSKyn/f3wKXSaj1ifODuTd9bgPWTRBNJRi/J2?=
 =?us-ascii?Q?7uKjfI5ghakugzMMBuYJ8peWhPfMmeE2/AVmYTJXhvjFhqwKoBdVaEz3WKuq?=
 =?us-ascii?Q?w83+S1m6SUzm6fxk/0lowvGVBlCmJN5MMi5PTfQ70DS7aF+k5xmL+1NxkiA8?=
 =?us-ascii?Q?IOtOd6THl3vo6KSeGtQ0QJw4DGtOupttlHVrRT6yLNzM7HiNXX9P28gTBnZ9?=
 =?us-ascii?Q?qN2PBurFaNu6U4mJG+JkJcnX/Nj8rGYjkshUM6HImD9sLqoe00TSpUu+LpLE?=
 =?us-ascii?Q?KfZrc4BZGS1by8Hv+GxQHwUG/UGqIJdIIqJj5J+0NatK/hb9UjaLZ+mSvOZy?=
 =?us-ascii?Q?0V+LrdqwGnVWWZuv5uXdnFJv0V4AR/A1cUpMR/Kjr7Ka3R2aV3izodwLJ9IM?=
 =?us-ascii?Q?YUm6lwVsvkjCAfSsXtczHND5wG9GSV6AzT+/lECFdUUxt1I0Bl487FK/x4Qk?=
 =?us-ascii?Q?FnEbFWRebOUfeD5GCvKrlPuvefBvfRAgUbGK47AKV13MOSfi/+ubqRpbInG0?=
 =?us-ascii?Q?X49CY3XzpBtunlHeb5/4n/PkVnBpA1WN6vaAq1EkSqU99lssx4gaCG48gZNG?=
 =?us-ascii?Q?zvUqxUfICw5MNOdyA5L/dMhd5DjQNCtEE3I07WfNS32oWoMluxUYlEcgzMIl?=
 =?us-ascii?Q?yKy/O2DyiG+arQ0BPkQclenw?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(7416012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Xnzkf56g8fUz3XvQU2ICBzyAay/0Yf0HahOvAtMRKUpbkOgxnSbsrmmxAQfj?=
 =?us-ascii?Q?IMf4ntFp0+0SQBkzStzBTR5PxX1O2TXm6CLlJLKhyomFvLxgLfjaxABuc0DU?=
 =?us-ascii?Q?MgkAFaTn2kZP4PMVOJkQPqfbil0TUD555LUJ9CA6WbdK19quFnCA9ss+5QCq?=
 =?us-ascii?Q?4wZ9lwl0SDmVhQwhezDxeLZrSK9DhnskUUTp2fRn8LIu73TJQsvTuK7Odtp/?=
 =?us-ascii?Q?4UOwlxE8SmkpQtCJOpqIwfG5QP6dQnRP1EZnxktkwolQSGwRUjNATw6Hxf2G?=
 =?us-ascii?Q?irtmFkwEgHxA1pAhHcZfX4dflFiwNt6VX222Sh7EmBxUqMf6YLLYu6dZmt5m?=
 =?us-ascii?Q?FcxsD7KFk6rfqPhPHjrSyF1KTu6mtUeaQfLeL0Ev3zUKEkkiA1bfW8LY1WYc?=
 =?us-ascii?Q?06YGdDu1SOAWA7+ifthsk5bpzQbpwTVIcjLWPQey5oqMVvKEUX3fD1+Fw1HL?=
 =?us-ascii?Q?/W+BBiogMRji3jkvht86UutNKmmojpp2UsZffxM5kXewemAuu42HSErkR0wm?=
 =?us-ascii?Q?L4UJYSPkmkQLlfbhG9Nr3dthhxxbKwfP1EW9j4/U4NxudYbKHCmHuW9vEioP?=
 =?us-ascii?Q?Zsnb+iFdbQWc2TzITaaIalqt9pHB051ZCKoYbrgjzOI0wgQo/pbofHaYQKzA?=
 =?us-ascii?Q?L2njzeY/RugucMma9WhZrMdnsnRkxe8vdneQHW5rJSvGD4rb8jU9L5c+oD2F?=
 =?us-ascii?Q?5Td45O4pGH4fGZSflFqjbVOA70IBjmz5FG80r+xZWFCNIv2uudFiPo8AbRF9?=
 =?us-ascii?Q?1bLKxczwHQOrxj5vDa6OtqtKCSB9JV0lIb+uPPekbgMgkZoZa6ufOse4rYys?=
 =?us-ascii?Q?1jfEWOh37v4jAUQfvAN0eJIIPCESiZ/R+FFjsSJl+FZlcl/jqciWD9ymsfHZ?=
 =?us-ascii?Q?gbckuC0w9iNxvbHTDb1Fqkzdu+mVBQ58Djn6xYzAk0eaZ4364ey2UrcONvVc?=
 =?us-ascii?Q?sCoGXxikLZep/9vA5rBkqjOHEDu0nK989MaPM9ruDYtNvayxWHaOGGm/cL5d?=
 =?us-ascii?Q?So/0yIWDNzfIGQqL6rLjTT6ZxwQBn9dt13D3wPQ6R5wQv3GHYfaMZt/0O0GP?=
 =?us-ascii?Q?5epz5ahrS+jAHVwZh7/hY1xDDiomy/077ZNnhCH4UDWi8dOeJR7bAqJQt3nV?=
 =?us-ascii?Q?U4HNakYr8gVJDUbgTxih+OEP2hXXaA0H6zYEvKV0UiG31XSz/+sVWWmGyNEU?=
 =?us-ascii?Q?pet2nOsvtrr0H0FYgT+8p3p59no0P7CSrY2iqU2aKSU7AL90QcetwCPmaZOT?=
 =?us-ascii?Q?0UMN2XMsu3iDa22SGcD9p3Ml17ACdncJJidpqLdFdj/ywaaCfEwc50bYDqc9?=
 =?us-ascii?Q?dOj6gOQzMhYEVig3YbwUllMYUS1Ss9b9rLjvdTwivsanch2B+LhipQNGRqo6?=
 =?us-ascii?Q?1bu662AohVR5IUV0LT2BY4FkrU9awq+ed1GUMuD8QfpJEM3+T6zSfOmBfUCt?=
 =?us-ascii?Q?w8SF5TUuci92OkpQw5r21uqkSLq27Q7G9vSutavZxTv6g3OOZmoS96ZnFrYy?=
 =?us-ascii?Q?8OzCfUlfVYQ5miV52m+5hK1llFSRRwWiTtJYDfV+rCwPwd5XslcuXg+t/g2P?=
 =?us-ascii?Q?TSZXXtzYqy0OWyai10m+dCOcBqcvCGiW+8YA0bZUk/Jw0wAQuAj5MnE0vk0u?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	D5Qh9wSrY7meNL9YVbgcJlBlSy2JVAhzEWCvCWi1smerMjYQGZJyDEKDPyCtEO0qiWQMiBsBX5JDbB+2vkN/pDA6N8QMgFd8snNAoxXWdhIJXheyorqUTKuaKiMP+VXZaeG0WLhmhpzOp8cStiPIwmla4k11UhpOJCP//asnLTrhl3poP8kDN8t2hiH/DE5wiqdWiXHkl2k6SxU3oWf0zmYLzLDqhgVccRixPHExOFZQvpzmZ7h2uxnh6Y2l+hQkioDuwb+MlZ48JoduGf04fg0GfcYqD8U462hTmTDAdyuMen5Nn6dT+jXCiswI8EKNBhArcL/FnAXcDYyUisQL8Czyttnvg6sRMvLZu4XdugNa29adgeYrO+hqDz5zuUN9OB7MzmOq/DNdQWwpONJorXc6Y0EtcTdzY3O7Fw7/UuIOnTso8nPxQorvZH69+bMRwJTmmVGUmjQUEymtWMib+abG0B0CvRIHZHtXxTwxZxXaZGK40YPz+RZIdNANy0jVHJ5nT5TzutBQ7XZG7+WQ4xQKtZWW4FX4jy7T/9ec1rtdhAvUDts+hYy915J1wv10Uqfyzi1Pqqkq9TW7+W/vGwJleRymFZSs8IEZ+3d99rM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 329da883-a507-4f62-9da4-08dc954ab126
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 19:12:01.2995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lCs99qoXMWRBnTqXzMdFqzDe8RSDgEBKAmyKRSHAM7kUdwzWWEqML3kEgqCiTrHhZYtFktvjWQ0YXpo+M6IdtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4707
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_14,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406250141
X-Proofpoint-GUID: p4198vMT2zga54XI8MWqHsd1_Ikof5No
X-Proofpoint-ORIG-GUID: p4198vMT2zga54XI8MWqHsd1_Ikof5No

Create vmi_gather_munmap_vmas() to handle the gathering of vmas into a
detached maple tree for removal later.  Part of the gathering is the
splitting of vmas that span the boundary.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 82 +++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 58 insertions(+), 24 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 411798f46932..8dc8ffbf9d8d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2656,32 +2656,29 @@ vmi_complete_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 }
 
 /*
- * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
+ * vmi_gather_munmap_vmas() - Put all VMAs within a range into a maple tree
+ * for removal at a later date.  Handles splitting first and last if necessary
+ * and marking the vmas as isolated.
+ *
  * @vmi: The vma iterator
  * @vma: The starting vm_area_struct
  * @mm: The mm_struct
  * @start: The aligned start address to munmap.
  * @end: The aligned end address to munmap.
  * @uf: The userfaultfd list_head
- * @unlock: Set to true to drop the mmap_lock.  unlocking only happens on
- * success.
+ * @mas_detach: The maple state tracking the detached tree
  *
- * Return: 0 on success and drops the lock if so directed, error and leaves the
- * lock held otherwise.
+ * Return: 0 on success
  */
 static int
-do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
+vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
-		    unsigned long end, struct list_head *uf, bool unlock)
+		    unsigned long end, struct list_head *uf,
+		    struct ma_state *mas_detach, unsigned long *locked_vm)
 {
 	struct vm_area_struct *next = NULL;
-	struct maple_tree mt_detach;
 	int count = 0;
 	int error = -ENOMEM;
-	unsigned long locked_vm = 0;
-	MA_STATE(mas_detach, &mt_detach, 0, 0);
-	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
-	mt_on_stack(mt_detach);
 
 	/*
 	 * If we need to split any vma, do it now to save pain later.
@@ -2720,15 +2717,14 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 				goto end_split_failed;
 		}
 		vma_start_write(next);
-		mas_set(&mas_detach, count);
-		error = mas_store_gfp(&mas_detach, next, GFP_KERNEL);
+		mas_set(mas_detach, count++);
+		if (next->vm_flags & VM_LOCKED)
+			*locked_vm += vma_pages(next);
+
+		error = mas_store_gfp(mas_detach, next, GFP_KERNEL);
 		if (error)
 			goto munmap_gather_failed;
 		vma_mark_detached(next, true);
-		if (next->vm_flags & VM_LOCKED)
-			locked_vm += vma_pages(next);
-
-		count++;
 		if (unlikely(uf)) {
 			/*
 			 * If userfaultfd_unmap_prep returns an error the vmas
@@ -2753,7 +2749,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
 	{
-		MA_STATE(test, &mt_detach, 0, 0);
+		MA_STATE(test, mas_detach->tree, 0, 0);
 		struct vm_area_struct *vma_mas, *vma_test;
 		int test_count = 0;
 
@@ -2773,6 +2769,48 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	while (vma_iter_addr(vmi) > start)
 		vma_iter_prev_range(vmi);
 
+	return 0;
+
+userfaultfd_error:
+munmap_gather_failed:
+end_split_failed:
+	abort_munmap_vmas(mas_detach);
+start_split_failed:
+map_count_exceeded:
+	return error;
+}
+
+/*
+ * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
+ * @vmi: The vma iterator
+ * @vma: The starting vm_area_struct
+ * @mm: The mm_struct
+ * @start: The aligned start address to munmap.
+ * @end: The aligned end address to munmap.
+ * @uf: The userfaultfd list_head
+ * @unlock: Set to true to drop the mmap_lock.  unlocking only happens on
+ * success.
+ *
+ * Return: 0 on success and drops the lock if so directed, error and leaves the
+ * lock held otherwise.
+ */
+static int
+do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		    struct mm_struct *mm, unsigned long start,
+		    unsigned long end, struct list_head *uf, bool unlock)
+{
+	struct maple_tree mt_detach;
+	MA_STATE(mas_detach, &mt_detach, 0, 0);
+	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
+	mt_on_stack(mt_detach);
+	int error;
+	unsigned long locked_vm = 0;
+
+	error = vmi_gather_munmap_vmas(vmi, vma, mm, start, end, uf,
+				       &mas_detach, &locked_vm);
+	if (error)
+		goto gather_failed;
+
 	error = vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL);
 	if (error)
 		goto clear_tree_failed;
@@ -2783,12 +2821,8 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return 0;
 
 clear_tree_failed:
-userfaultfd_error:
-munmap_gather_failed:
-end_split_failed:
 	abort_munmap_vmas(&mas_detach);
-start_split_failed:
-map_count_exceeded:
+gather_failed:
 	validate_mm(mm);
 	return error;
 }
-- 
2.43.0


