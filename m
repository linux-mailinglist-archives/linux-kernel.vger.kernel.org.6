Return-Path: <linux-kernel+bounces-378321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E7B9ACE6F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC19A1F22DAA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC3B1C3F26;
	Wed, 23 Oct 2024 15:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lT4KIfqq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b4dk9S7e"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593B31C3023
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729696612; cv=fail; b=ngSWvK2NicDd8j2Qp+qUW78N+nPnM8/0zSrV66lqOeOliBhXZNIo90vxSN4Pn6Mk/UE9ySGaiH2cD2CEWI6OchJLsuqImzZOElChLtHSk22HunnYzTZ98FV5yoVrl2G7tyr4bhmdHvF3vtn6BXM5jGJ9vy2eFW/SqciLLm5d3SM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729696612; c=relaxed/simple;
	bh=iWVVs/IJKa8ylYdfFmglc+U4Hbiwj5OR5S/zw0OEtKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bOLqVZV/YPkmGTmWl3woGZ4YnWCFA9Bp6DSCWppPMcu1ZSpdrpNHomJquw1yeQFWDVCT2sqbWwQF5dg+oDz62FaUMd/nIkxJUE7JUVNLVcFCwlivZu9JpTr3qulcYvBFJHEqZ/QVaOVUe2z/3qNMMhPMtP6YolGRBkEJ3AwtFJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lT4KIfqq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b4dk9S7e; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NF0Z2x030053;
	Wed, 23 Oct 2024 15:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=czDyXj6hytUL+8Mjvk
	XVnjKPuYTYgsuEymxGuZbDK1g=; b=lT4KIfqqqcnv89GxKg0dY5dae0x1KmlB8J
	x9K7W4pWXejgCX0xxOy9NMnBqDsR38eW6MhEJk5596T2LQWnp/HhVwJP2H6TSQbv
	qQQfI8EGaRp/08gEk6JAGWSwalNJj09Oawv7d6Z54ThTOrGSMs7Y37bA4D0XoD7t
	YUV18GO/H7Y/OA6DQQhtiNXiZq0sIvgKKRgXWj8NtTyrBXX0Cp64yaGFzVuhW9Pg
	JUkc0VqxldTqdtNCPowzXXYIdkOajk3WCq8KwcKdywaAY9hGDaujpZpJW8jObov3
	UxUkv+7Ci+mDRi9nE66J/yMWi8TcgsnPh4u1z12vLh0P8YfEeNEg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5458h64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 15:16:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NEJI7t018359;
	Wed, 23 Oct 2024 15:16:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhjpcbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 15:16:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ciAzmVD3haL0m+lU4OEOXCGb4Vj1cAlROLkp899pHbl8Bi5iXggWEZPAEdFrseTOhykmMlv4XSSb6HTGi6cGL5axTdXef86id7NQdWEWF15o2jC7/oQJLOh3Z7VsUdYmn7olpobWbnQ3qMiJrxX4lDkfdMKIpcu/y+g/Jo2mmgvBTutEqoLq/5V1jcg1+d/O25/ZO73jlbWXz6VkfgugVqmcyjvWND4NZdS/GCNG4myB/IL3YO5T7T/AH5rOljmRZYypQLIH7inbZIbtNhL5ukgJfQo8dQFMrvHclOXBI8XHyztqRmcZt7ZA4XnVS9k466VBcZuYoX3kJk/2x8dgoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czDyXj6hytUL+8MjvkXVnjKPuYTYgsuEymxGuZbDK1g=;
 b=VZ5FezG4CQYBXc+C4d50rKNoIYzDM4LMJAVopfbm2Y3aClVdU+ihJYZpm6DrdNAUxFK4RFgnjBUDikMkXqYjTrGltGPrkNMn9EZN51vtk+DaM3MMGqw8brj5A9L24QY1hwBOCg6bJOnKAZnmW6T7Hjyi8RrhLCjAhRUwDzsm3ZUIWd6wWdZJuXTP5u2hIYSeTZu8PHnaZBI24ykk8EYV46IT9IIlffyPxtOaC6wSHmcu3LyVYAjW3D9ctSE45BnXROe5EmfRhEdzay6N/58HjdJpxlcpCyzrGovrveeYsYRx17TprHVQ+ljx3ZOMxiLVCJhyYPEPh1kpU5fqfVrTug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czDyXj6hytUL+8MjvkXVnjKPuYTYgsuEymxGuZbDK1g=;
 b=b4dk9S7eOqg4R5nmHJhZmY0JV7M02nspOWfL72E8E8B0BoT5TCloq669P0kV2NJLSGTCRG86LTGKDdkgxYRh/9NIX/NYtQA60gJNpMseLrgfW4hSWlmOIl5CbKu5VS5ZEv6uer2vE7ijaZsI74E4kXZ92z/q5+H+mhOrRx8g8t0=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MW4PR10MB6348.namprd10.prod.outlook.com (2603:10b6:303:1ea::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 15:16:37 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 15:16:37 +0000
Date: Wed, 23 Oct 2024 16:16:32 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH hotfix 6.12 8/8] mm: do not attempt second merge for
 file-backed VMAs
Message-ID: <a97ac345-e880-4750-9114-43db358065c3@lucifer.local>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
 <7b6bf6165080505feb5e00b313d2c84c25015e45.1729628198.git.lorenzo.stoakes@oracle.com>
 <f5037dbb-7412-4fda-b397-3e5538343686@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5037dbb-7412-4fda-b397-3e5538343686@suse.cz>
X-ClientProxiedBy: LO4P265CA0090.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::11) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MW4PR10MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d8ddae-25b0-4c1f-18e8-08dcf375afcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9M6cngMvb/5HarOPxfFasJ9R9Z7uYHzFK2k3G7czZFMKw2yh4D1ackjX7gE4?=
 =?us-ascii?Q?4KA9iWYkgjdNufhrTMdaStd9yATlyAZRG8wA6rtDol1879gCtLuTrmwYLdlT?=
 =?us-ascii?Q?6BUGuGpM8PbhA0kzw8Fnuk7fEg6+LPx06j+PjrqpNsjW3EOp3MQdDsC4TTP3?=
 =?us-ascii?Q?r+E896c8qA61rfHNJ5BCkeFB3lucJ1qwWGV4KAtOXt/ZnJrb83B0OdITd1Og?=
 =?us-ascii?Q?+Fx20xsjPhTg0Ju46Uv9phmjPY5XL65azBuWz3xNzgGiJum8+6YoLp7HpFRw?=
 =?us-ascii?Q?ha3FvJr4UOBdReFpt6LeclK/YZ2DCew25Iy7qUFl2uqt9TvBBBAbIED+JTNS?=
 =?us-ascii?Q?bZ6mxCA+z4M69K4XqpSmpF1+nHw5GrIzeDnOftrmWucU66TLOV2BgSUV29L6?=
 =?us-ascii?Q?irIQJ6lTs4mB1M63i6bR7Kwuq9Q1DQK65kxlOXWuIPZAktPcu0u9l7kBzeY+?=
 =?us-ascii?Q?Xsw/FIqFCX3tSPbSzTDKIAXUV9tfrG+DEEpNeyFiEbUqDFe/GWfdOuY0ZQpR?=
 =?us-ascii?Q?IzVxSQ/ItJgqpHyovE4m1VKoN/mOx7EjWoHZqgooZKnIar1l0UlEEg5OT655?=
 =?us-ascii?Q?b0y7cPSJewx+fG+N07DXNiyrJIb7GVhsV/RPKFr7ySWXNuB9ksxCQEYne924?=
 =?us-ascii?Q?E3IkKQ/sWXgKVhTxTDd4FamlDoZraMkMyWZFZycGf4t++/nhHuqMwPGrrmCr?=
 =?us-ascii?Q?Hr+Wj2FGyI2ykNmHSe47Hv7qS/iz62vbANgvuCo3Km27y9Saeccg6LHPkk5P?=
 =?us-ascii?Q?F9dUKOu8Uhxmey93w6FSpyDLXPrYb0f6nFXAm88WQuz6mTczN+SSmcP885z0?=
 =?us-ascii?Q?RFglNjidKXrSlYxJOAb0d4JEFxtal/H5TNncF2V9z3kkHwduoYfkpnEVGJjk?=
 =?us-ascii?Q?dyHMsUOgx5IzQPEJpanLFCdAWmicWAkTGhWkMJsKGylzkWDU6yp+rVZcXqN6?=
 =?us-ascii?Q?Y4vCQx+FXIb9VNDxVFvehz8ISUQ0K0wBJkFHplrR+9EligcHAhVmYVvB/EUj?=
 =?us-ascii?Q?gU004Iqpk61FhlNSi2JGOI1dg3rfGf+G+ij+Zq0/qLMu4/bsX3ibT13W7Ltj?=
 =?us-ascii?Q?z2tdCr0tyxsZGPUX4txVsA7TX1hgWTkVoYlMXNeHDL+X1Hpr0MwoyN5B9/az?=
 =?us-ascii?Q?PFsi35aAPcv5m6lkHsLesV2onD9KzGOTyutEKrrPjbE6pNc8q9bdlHYS+AnS?=
 =?us-ascii?Q?lzU4BA5IYoG9jMHnjs6szvwFXEayv+Qud1Uf1O27DwmZHyNcMD7x0i3B0nwh?=
 =?us-ascii?Q?0JbgvDxS8XHN1pIrbbITG2BJ7agfZfuAt/JOAJrjU4oGQYeqjTZZHu40nNNC?=
 =?us-ascii?Q?9bRBNp/TZpRXTfCAkQzUw/Yn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1InaDYigO4Twd81953jyIGs/45Hmz3d4d2s7w0r/ilaSig1F1WOTqbsrFUYS?=
 =?us-ascii?Q?NEmQGO8au19jGbcBJTx9z3UsZPzL1a03FtuLkV1/pBtoTdsst28kZmmsKqn4?=
 =?us-ascii?Q?rvENmUbazCLlPjTAa/viDtGB0E5/oz6S0aaqvteXt0EepVxZIFMx05YRD/81?=
 =?us-ascii?Q?UxKRA1ZNfQKpjYCGY70vFp75V6XG2LmzEdZBQLaUkYQcS+sPYdHwhN5QMEv6?=
 =?us-ascii?Q?+k7irUXMJJphudyTJQSnQEKzfPXvy+nlM9zIskXDmaAYkeiNmCyODPjWbHVX?=
 =?us-ascii?Q?ucCl6G+mPaoWitA3ULr0dBCHo3bF8NXJrzb+B4afyvA6hXT5DbnGCiYd8UjM?=
 =?us-ascii?Q?BZB83zzktbU1BO66WAjHKOOsAoabBg1Jghj7ZaxUd2gEfUSKJUzCosYsq34O?=
 =?us-ascii?Q?rv+QfkgXTmWrDAQz+5xadBpf6a6EoiOowL3Xxi9WS+FF5A7J6N5d52PQCife?=
 =?us-ascii?Q?tChS4Hq5JIX5eQwuOb680Hmjzi5NBqQKXV3V6V/2qBHylzZMyUtUN10MFwod?=
 =?us-ascii?Q?Rm3tLYCBnLLwmcxErxF4zS5lIm1FaeSgKSfRUZGzZp4bQpnbs5fvAPrTUipB?=
 =?us-ascii?Q?Cm0VV5JDE+Hm14YeRpzsi2J+9z5nWv3ATFGdGfwg6M2+5Yyc9Au1hdoUHXi2?=
 =?us-ascii?Q?E9C65KG6GzaqfJzCbEi+4oESeDNV92DmrH1p61BZ6vBfaBWfYAo/N4cv2HGg?=
 =?us-ascii?Q?lZGXURUHA3M9KPWEJe/uT8ZrSK28xbnrVcvpfjkN4+sH7aG7kfypM08RKMIP?=
 =?us-ascii?Q?jK3y2UUIWRo5QhA7jgSiFW+I8xkBJ2XW7ZO1UYnyw/x065Uxw5xNNbQPuMkz?=
 =?us-ascii?Q?SLIZzHk+f0cIGtiylq1UQUxh7aoPODDP12XVPV9DOTR0WxnFk3k1VB0cvrxb?=
 =?us-ascii?Q?lKz8906llPGwYEVjCekOWp1IfrPgbLauCIRdOI2Q3t/txbObqjgJ3urQpBMO?=
 =?us-ascii?Q?C0wDNYrj4/YygDHYnPjiEpCuG/HgQC7T/fOW6DRJfmLA9LuVrsIuP5SXTUGo?=
 =?us-ascii?Q?PgysB9cUrTCM5s9G+3cOKdoB19p4yea8hnWKoeJsBwyhovqnMyiazZ0TF+7o?=
 =?us-ascii?Q?Ac2iU9xffXYLECyT/aZGr3WHoA4CjzGSuSknGg/9AHk5ocIX5olWm93FRpLx?=
 =?us-ascii?Q?wUOH0EScFj6p+2HIO7ywJFpbRGOWI+X3EgbKiPf41kg0rNWfnTRjQ5/H3Oz2?=
 =?us-ascii?Q?1Zp0lIzhuOenrAbWi5+bVbqn8yp1PAYgPn8xMd9PRL/Etc50ldreY4PAhVGC?=
 =?us-ascii?Q?S4yvYOvjaNaVWAHeQY1+oYrtA0bzKtHVoQeDpJm/KUCvq7fPowExgktv4JH/?=
 =?us-ascii?Q?KP6Rezn8sgg6WHtWZZLmy3r6knyjzhqU4EDdRBx/pKFNU3IutIyaxq/furVo?=
 =?us-ascii?Q?riNF6G7ObddMDNPnGTLZgZeEq3AG/IqNukcfpp356lorP6IUB3oW3Kuc31vJ?=
 =?us-ascii?Q?cnx5sZBYQ8OeB2cqDZIfnXSYp8p25HtH/vkh2m3ZeHbrktpBDIX8NcsxvYRm?=
 =?us-ascii?Q?PLpoqs22Vbk2Xly9RsxDbKs2HEfpNBEpJQ55oGzQH472dOgGFsZuk3SVv+XU?=
 =?us-ascii?Q?EItT+8ODBjZMGFb1+KDFPLaKPTojhxxiJRJ7WFOcOk+CaOjZnt6hwh1rJ9GA?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	N+bmz+YK3pTlN73M5yeDyw24RGaS/R4ZK4QgWHVu7rPIUHEoFyoLnNTTOpv782drMVue2d8eoKPA/HKMsma6vf6xj+JB6E3/ddKtA0lcT1qlY6N37C7HvgR6YUXq+cN1bru6RRUlUoj9bQ9rGSRmNSLaMTxN0fj4JAjG2QMCK1FrpEXzzCNLjWVmgVIIJ7J6UdFyylkYBFMJEgkJI4xnOrCfhLhlc17oqEPc2Uv9B+ntMmabRM8fHSocweFwqLQJ5ktWnH4lQXH+ftv2gSvYjgNRfF+B04hNaGmDAd03tSYno8IkDK5Ly6+3oV5u4Ix+faSi10ohkK0HYOteZaHdr/GjyCVwhhh5Tv+8Gn1XpsX7NwPQ6R7FUKR6JtegO2iTiZuKN//oZIE2gwzPxs5yywg6LPHf3u3tkiemODOSE12USvr3ujX1krobm27pqmcrYPpB0m2AzpWcPKldNMagkjhXpiKzwYfaWbjr+BT66sK3fLh0cRqUkLNcHZPETm2Qd3a6XLC8iiVm1nCbb5Wv0OF9dVTBCJ5+dibnS91OAnZHNo5CEUPyycLGzeez8gAiLJSPZl8KKFBB9osvIDNXXXdhM/vVvfptvcGkP/Wsy0U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d8ddae-25b0-4c1f-18e8-08dcf375afcc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 15:16:37.0621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6chuCUe8THH6SFm+4zR/QTx8zB1Nqx4ArvVlKbRhpTb4PMNJEXC1cg7C4J3F4aX7OfpBCj2YId5QT6mQoAmCqWTrBl9ZZef7azAktMYa5b8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6348
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_13,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410230093
X-Proofpoint-ORIG-GUID: 2yImbJieK5mcmEy9p0JLGFV8uzQfU2G9
X-Proofpoint-GUID: 2yImbJieK5mcmEy9p0JLGFV8uzQfU2G9

On Wed, Oct 23, 2024 at 05:01:29PM +0200, Vlastimil Babka wrote:
> On 10/22/24 22:40, Lorenzo Stoakes wrote:
> > Previously, we'd always try to merge a file-backed VMA if its flags were
> > changed by the driver.
> >
> > This however is rarely meaningful as typically the flags would be changed
> > to VM_PFNMAP or other VM_SPECIAL flags which are inherently unmergable.
> >
> > In cases where it is meaningful (for instance DAX) it is doubtful that this
>
> Hm if that's true, I'm imagining many piecemeal mmap()s of DAX that used to
> merge but now will create tons of VMA's, which doesn't sound great. Then it
> has also potentially breaking effects on mremap() which doesn't work accross
> multiple VMA's.

I said this repeatedly to you and Liam but you both still seemed to want
this :))

Anyway, yes. I mean you're pretty crazy if you are mapping a bunch of
adjacent DAX ranges that are all otherwise mergeable next to one another,
then on that basis assuming that you can mremap() the whole thing.

>
> > optimisation is worth the effort and maintenance risk of having to unwind
> > state and perform a merge.
>
> What if we simply created a new vma but only then checked if the flags
> changed and we can merge it with neighbours (i.e. like the mprotect()
> merging case). Less efficient, but less tricky and with the same result
> hopefully?

I'd probably rather just drop this idea rather than wade into something
entirely new, but let me look at whether we can leverage
vma_modify_flags().

I have a feeling we can't because we already explicitly reset state in the
merge new VMA case, and we'd be introducing a new way in which state could
get mangled.

But I'll take a look and see, otherwise we can just drop this for now and
potentially come back to it later, the key bit of the non-backport patches
are 5-7 anyway.

>
> > Since we've observed bugs and resource leaks due to complexity in this
> > area, it is simply not acceptable to have a 'nice to have' optimisation
> > like this complicating an already very complicated code path, so let's
> > simply eliminate it.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  mm/vma.c | 39 ++-------------------------------------
> >  1 file changed, 2 insertions(+), 37 deletions(-)
> >
> > diff --git a/mm/vma.c b/mm/vma.c
> > index a271e2b406ab..fe1fe5099e78 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -2260,8 +2260,7 @@ static int __mmap_prepare(struct mmap_state *map)
> >  	return 0;
> >  }
> >
> > -static int __mmap_new_file_vma(struct mmap_state *map, struct vm_area_struct *vma,
> > -			       struct vm_area_struct **mergep)
> > +static int __mmap_new_file_vma(struct mmap_state *map, struct vm_area_struct *vma)
> >  {
> >  	struct vma_iterator *vmi = map->vmi;
> >  	struct vma_merge_struct *vmg = map->vmg;
> > @@ -2291,34 +2290,6 @@ static int __mmap_new_file_vma(struct mmap_state *map, struct vm_area_struct *vm
> >  			(vma->vm_flags & VM_MAYWRITE));
> >
> >  	vma_iter_config(vmi, vmg->start, vmg->end);
> > -	/*
> > -	 * If flags changed after mmap_file(), we should try merge
> > -	 * vma again as we may succeed this time.
> > -	 */
> > -	if (unlikely(map->flags != vma->vm_flags && vmg->prev)) {
> > -		struct vm_area_struct *merge;
> > -
> > -		vmg->flags = vma->vm_flags;
> > -		/* If this fails, state is reset ready for a reattempt. */
> > -		merge = vma_merge_new_range(vmg);
> > -
> > -		if (merge) {
> > -			/*
> > -			 * ->mmap() can change vma->vm_file and fput
> > -			 * the original file. So fput the vma->vm_file
> > -			 * here or we would add an extra fput for file
> > -			 * and cause general protection fault
> > -			 * ultimately.
> > -			 */
> > -			fput(vma->vm_file);
> > -			vm_area_free(vma);
> > -			vma_iter_free(vmi);
> > -			*mergep = merge;
> > -		} else {
> > -			vma_iter_config(vmi, vmg->start, vmg->end);
> > -		}
> > -	}
> > -
> >  	map->flags = vma->vm_flags;
> >  	return 0;
> >  }
> > @@ -2341,7 +2312,6 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
> >  {
> >  	struct vma_iterator *vmi = map->vmi;
> >  	struct vma_merge_struct *vmg = map->vmg;
> > -	struct vm_area_struct *merge = NULL;
> >  	int error = 0;
> >  	struct vm_area_struct *vma;
> >
> > @@ -2365,7 +2335,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
> >  	}
> >
> >  	if (vmg->file)
> > -		error = __mmap_new_file_vma(map, vma, &merge);
> > +		error = __mmap_new_file_vma(map, vma);
> >  	else if (map->flags & VM_SHARED)
> >  		error = shmem_zero_setup(vma);
> >  	else
> > @@ -2374,9 +2344,6 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
> >  	if (error)
> >  		goto free_iter_vma;
> >
> > -	if (merge)
> > -		goto file_expanded;
> > -
> >  #ifdef CONFIG_SPARC64
> >  	/* TODO: Fix SPARC ADI! */
> >  	WARN_ON_ONCE(!arch_validate_flags(map->flags));
> > @@ -2393,8 +2360,6 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
> >  	 * call covers the non-merge case.
> >  	 */
> >  	khugepaged_enter_vma(vma, map->flags);
> > -
> > -file_expanded:
> >  	ksm_add_vma(vma);
> >
> >  	*vmap = vma;
> > --
> > 2.47.0
>

