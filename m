Return-Path: <linux-kernel+bounces-387202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9681A9B4DD1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F146BB23694
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2210D194A70;
	Tue, 29 Oct 2024 15:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FyTa20Nm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IL4UfbB0"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B020194AC7
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215453; cv=fail; b=Iz9boaE7nbzi1IqVSVc93jjtCGcTn8VTu0FlUyW65Itm15nXdULova97hAE3yx8vviCLx1Ae0MuwgzmU4cclbVMEXn7pcsNTIhz35I2oU8zHLuoYVO3w0kWBhxPKA3Q+wJStZzszdpxjXyYs9Z7C6pyjW62aztvbdf2nosRcAHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215453; c=relaxed/simple;
	bh=DyujkBqR9TdPlfAodLVlo3kpVGn/VnvwIZ1Gtzw0EMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=APj6QhfPgmJU/kzl4XaE8M5iPofm0oFaRiRwEjk3hcLJjzcDleAw0s6RVHwxJh1I3KnLsf6+7XLvdppwROMRr8kEqjJEtt5kYYCKMK/kMNqOIhW+lQrXp6Iio+/115QA7mBxzUZ1cXUX1buaUD/qSikD81Ko2JmlChigh8w6vgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FyTa20Nm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IL4UfbB0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TEtd1I017406;
	Tue, 29 Oct 2024 15:23:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=9g8zmGnVK2yFQD7RBi
	I7hNTPyJ6EXpyUJ1kbOjXu0CU=; b=FyTa20NmTc55cMtSPSYZSr7kpb9u5bw0ZE
	RtcpHTi7SIJm+lmJfDkdkGbxdI14RdCRvl8H+Wz1+116F8qHiwthrh59RtBIg/Tz
	rUsQSmDT2oxW+ChnwBtKRhq+Crg3q4gzkc2XWw37MhUld4WMmR7ykYQrGvtk8zOA
	IK/Jhi7rgqmDPJhK/h7yKK7zGvP1h2Jev/uRu7U7M2QX7zICb+M4sYqzdPenKgzt
	VgqvwLwyg57LPw95pKeaxtr+SXAsjriAC1QJfEDhKfbhi2iy0odb1Cm0EX5A5XjH
	LoT+ZmNC1d9fGolvCyUm85w74mDzSUHln/gbl0qmfjholE9XE8sw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdxnthg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 15:23:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TF9Mtv010991;
	Tue, 29 Oct 2024 15:23:48 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42hn8x16sj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 15:23:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vz0aq64cujPJaFniWxLmA7vJ62j/5mQwSxdzwcPwahNpGIBvk6o2Et2TCw251b1806ZxTpYA5sJ1fPfcDfW8T5OZ0lQO28XCQqyem3CrnPqLy74yf9A7lNBYvBbYQhciKtwvXw7FJsXNuuhT+n2aImq28wAippNDDAE8z+LqkQlrDWSfistDd6EhTtQ3/DqidYQW2pPp5uByVfug9JM4Tn8qocf7sd3+VidK1b38T4DVZRapGmTqO/ZwR2H7PyvpnQ6D9niDJRBl6awKNlxXso3shMy7PcyW3+OKw1JuVlqstmOtEY/yzcqrx+KGXubcWnAhs8zObw0T2txVMMB60Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9g8zmGnVK2yFQD7RBiI7hNTPyJ6EXpyUJ1kbOjXu0CU=;
 b=Q2tK8BQQg+CGyO1pEBjNbVKvPaME2HUXWhamm/L2gQQU1n8VTrLxzBWNhSoSSTaaH74Xd+kuLsPO22jWUk7FkIsP09rKq9QFr7xGGM1poj1rVqO0e8f6GgiXii1J/Irqdx8LaPc+e/fAu8Z9nVYKSvt+InSg6TJON3uY1LpQpoIkn5iUvAma+nf6JE1cjR56NmSWyzQnQIAqMlIogSGoczkI2zytQ2P9bwTPQTqDdl8ceW4OZ0+faDlcOoR8fGs+HYF6PKtZmWxJbJnkxUFEMVOOgt+3Qeu/jHD5INk142mQj6QTDC+Baf9TLAK2svctB/wjyOk+Lhg3DVhwwAim1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9g8zmGnVK2yFQD7RBiI7hNTPyJ6EXpyUJ1kbOjXu0CU=;
 b=IL4UfbB0PqwY/FWLs4+ovuRdtFsLL1FSiHYaUzukYE6FJWRx7MtM33uNpLdQOoMD7/9isbKYVGzzJ25sFnHjnjpUCUq7JjB+dLmWJG+EhW0lngyB5oOV0G0Hr1enGH6OuzQjzCcql4VL7RxzzZbkzz+hmA8v5Afd2EiMSi8/pfA=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA1PR10MB7261.namprd10.prod.outlook.com (2603:10b6:208:3f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 15:23:44 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 15:23:44 +0000
Date: Tue, 29 Oct 2024 15:23:21 +0000
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
        Andreas Larsson <andreas@gaisler.com>
Subject: Re: [PATCH hotfix 6.12 v3 4/5] mm: refactor arch_validate_flags()
 and arm64 MTE handling
Message-ID: <be2cf489-bd8b-41b4-8e29-9d7573a4f8b2@lucifer.local>
References: <cover.1730206735.git.lorenzo.stoakes@oracle.com>
 <ea10a05be83c70cf610d470fe3b4c05513e3859c.1730206735.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea10a05be83c70cf610d470fe3b4c05513e3859c.1730206735.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P265CA0302.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::6) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA1PR10MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: 972017c1-2ae9-4759-bfe4-08dcf82da1d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tIfiC8IGUSN5g1H/dbTxH1u0ETSaLm5R8n9WB3B6qakv4d34+f4CBf+AxZNM?=
 =?us-ascii?Q?Ij8kjDo6MgfKBB9S0jxgEdArrcahqHHt/O625Ix7q6Xa8qX4t9kienY9EjmQ?=
 =?us-ascii?Q?ueE6WdCprkNbQeEpACeMOGxsMdbdpq5vgleLa2oV40Y9Jx+XlesiDhSy1r3Q?=
 =?us-ascii?Q?tAo5l7ERdzRgXdv3LYokhDLAzBaaoBeqJ6do1MSlX9caaINGb1kHBtjYm5gm?=
 =?us-ascii?Q?NjTG9IZdhDhBFkogOEhjIP2jzPIsGym7GwdsbXN8yi3ugJVHXjGa3ero+IYH?=
 =?us-ascii?Q?SDXjjxPh+Z2R0rWM49LNeOKvCr06Q35AY7tKzKkuWE7gRqfAD2ZKEpB8GA8h?=
 =?us-ascii?Q?7gSjr4Vcf8P8RZIFGE3zLnl+r0ODe8X+HhvyqAnYjW8lnUbUThi+EPv0/C0c?=
 =?us-ascii?Q?Cs6dvzLnqnqJTCpAEpadA+pVLFicwpvLFAiDmQV7ZDm0Wklu5W7adBjhS2UL?=
 =?us-ascii?Q?i0z8uiwsoH/u7FZ8vPNkeYiR8DSA6cFo0BYH0pJOU3EM9hFiiPHQ7ESnzLiQ?=
 =?us-ascii?Q?l9lH5Ij58npiWjyrItO9kajemZPMJaXzzApBQg9N2WGFRzi4Qvu0WweZrcVU?=
 =?us-ascii?Q?898Efw4sEw3dxsaC3Vv8+UAsWJpK1gpM/fKNp32hr32NlEoZcQLE8S9Tdo+L?=
 =?us-ascii?Q?uXKbFdw5W/2Q+yfdvPg2qdgbQ7zcfZKJGc4H2KtapVIHIKr3appq7pFzw/2Q?=
 =?us-ascii?Q?jXt1nT6IbcncjDMpY9PuP094FTELO5ylYfkhKXItI9PLXuJASxLZaeGNsTvF?=
 =?us-ascii?Q?FdJKR8/niNkvxYQlnZdYWwictLvupVY0w3EwoI6cMn4g9rNc8BfPsZAedSpR?=
 =?us-ascii?Q?zGkjIIIUmMcBpXauYY3tCL3MCc2xhmMFCCKa7esj2IzkgDO0SvtuPAHtzr5S?=
 =?us-ascii?Q?AidNeBwhz2uijcTb2QruabHmsE2qTb0Zsiq1rd1MJaDCent8odaBjrljrSiL?=
 =?us-ascii?Q?p1e6XB5rg7e7u8tRkvYnWDeuE3vqMLBwZoJze5JnW8VrAjbZNdKEEadmQrB3?=
 =?us-ascii?Q?4Q2tzYhOxoFB2OiQrqpvRgHswsk9VPFskGujmcDlqDozG/HW1GkgCHt+FqoV?=
 =?us-ascii?Q?AHz5TR3wfhuNNkvNW9tX5Bmu50k9VsyJJkaDydSnJqvClrNGD0MZQHLSq4Fv?=
 =?us-ascii?Q?FtzofijYmxAb3Cz3qbaxAa5oxJ8HoZSc8aJTrJx8UhoCyxa+d8R9UPblWi/k?=
 =?us-ascii?Q?520q/GnbXYFJZC3kVQEnSbXp9Y1/74w8zjuW8NbrcDwmw9/Lyy5O0qHMGCe0?=
 =?us-ascii?Q?Z2omN2B9zK4qvtn4tLGNPb9O/SEPsr7B9KVrSD6XR64P0kpXYZJ1seeCpvsb?=
 =?us-ascii?Q?vbOKgL7F+no7H3Bb+h2MyXbX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WBeLJ5bclapn8IEOmkWekafQfswPLCvni7cvnrrOVmZyaHpxhw5A04d95L+n?=
 =?us-ascii?Q?Ju5Qgb3EqI/KwsoAU8u1aUEgUQ63+ozrJ0FIxI8pRpnO4lJT3gPS/c9ZuTxC?=
 =?us-ascii?Q?mq8DDSxsixT9OftKLrfumjl/+TLSJddz+Ma4yb+g2sRxQDOBncWmBdrJuHrS?=
 =?us-ascii?Q?KnTawkeLRuQXOV1Auxne1kPO7dlpF5IYYahl7Cz17vqNLjN2nbnNdFDQTFl4?=
 =?us-ascii?Q?kQ2A6o+vTFx8/BLzcmh5mekl2A3IrUPZnwDYDlqnDF++ZGJnSJnGqYM3iDw3?=
 =?us-ascii?Q?+tU5GY+aNvAp7VZa8MT5tGlXJoPhXiOUxvQoDE5mjCwM/+TX4+2C1byWOPY2?=
 =?us-ascii?Q?ijf1rpfCPsYl5RA8guqevKH8PQek9g/Rd+aVk2pVcwwf092iNmy7h5eFxjLg?=
 =?us-ascii?Q?6mZvcN2nmp2d+S9gNXLV4ow2vE3sqgPEbv17ytqsZRnO+jpGC/srz6Ap4v5b?=
 =?us-ascii?Q?w6aB2pRMzFzMxhMrHaEgpAT5lZiSXAr2SyG2OURa2lxem0yag0nNiTtsRm+C?=
 =?us-ascii?Q?ms4jeA/wWVxP9djLVbVLkOEutK26eia907lyNETDNsGr0C7PJPwBEOJDG4gH?=
 =?us-ascii?Q?2teg/7mBwH1t3t3nyGoE6JJjod4z5QUzn4y7nYz8Bphl30bAXNkiIgWSN2dx?=
 =?us-ascii?Q?/ifVPhZas/KL2Mm18GqrtVoa4FOQYa03C3Ldga59BewFtBrarEaK3aqvymsT?=
 =?us-ascii?Q?OEjmZaYqPphi/Aly5SDhWTnEHHg8fi2EN6xK+oCluImeGlXZvEtjs5c1KZYX?=
 =?us-ascii?Q?q7QflhQGSRkkL+bJoLG34UIzcUAeQRpJl+nVxF9B/gkhPLJT3SfLBv0wAtvC?=
 =?us-ascii?Q?7lXpMoXivD11ZMrnPRSxdkYZmZI9Sl0OcNcdMKVc2h3fceedetN1FyLw+/2T?=
 =?us-ascii?Q?Pfi9ZqM1OaI3BoGkXdLR/1p4X2UI0F3Cb8g2WJA+Aal9mAr5vUrFmP0GbGSm?=
 =?us-ascii?Q?o5enRwBkbkY2Gj5PDCqP24oP2u5gZBHGiVPh/WYUcsjWfKuF7aJgExH+XYFO?=
 =?us-ascii?Q?k4cNYSnmYQ81EKc9zwUY2bU/gffVVuvPlM2Jve/1YYZEyNsT413Xohrp9v2W?=
 =?us-ascii?Q?dVAMkeE46wLFi4fEa/YOlm2J3Q7v3OljB1iLUvjM2/Ua3sHnXYgCvYeis5yv?=
 =?us-ascii?Q?NfM7FXDXedf147KqXkS1Uou0uCWYPjDI0Yh6Ak1XvCEtcy9Xs/cGN6/p6inE?=
 =?us-ascii?Q?b8Rgv8gYxVoRl/n9svBVDnMU8UeiuTzXGZUSxvMAj9pr8Vbf/+lE7J1Ja2X9?=
 =?us-ascii?Q?XxFQd5MYWtY+eZP3tmprexuv+XtRD0HPrb0yezXSwB/opvNxD9PVcUCSWlva?=
 =?us-ascii?Q?FGHKanPQTrMbc9eREn8nb2qOUCG2z3GHEw7nh9jRppnSsyp0owuNHu5GyrZ0?=
 =?us-ascii?Q?jYcGOQXn0gvdyAKUhoQQL0XMbFWSoMV6xnxBU8+5I4Hfou6i432NNaV3p7L0?=
 =?us-ascii?Q?zYQB5v3bXAuDzzBajGnhPnne/HyLOaohgKRY916z0oxc5BdR07LLWUWBXasP?=
 =?us-ascii?Q?WwEE+GlOSWjCQzlLaF01mr+zGJbdTn//8hESfbvAGaRGXQUX/PBEHoMqDj6U?=
 =?us-ascii?Q?mumMpl85x/CLAWCXJ/QjeE3wVb2CTyIxxJ66X+2tEtGt4lkOlaJXlMzhUicZ?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DAgP928HE8OSLTMo4Y4dpvVSmgk81jpSETRJOXWGriz8GYeK252oARy26d1Q9sZHGs5guD9lZtYNfzPF32GVqn8hmHq+Rk+aT2T6XmUNt6LWWcCS7HBOXo86z886DGRv8YaPBS2b5OoxMr0JeRQpRKvcPzfyfyMLFb5Z0f0CKQNKoPWURzEUGVrflzjiWb32hmo3AQ05zJMZVv6BQwfkTWv7bkEV1d1JxelKgGGD5QgT2N2vQbvTBNdsyfEz/mbhL99KHa1r+gkAIc4f8mk70FZWMUwReqn/AK53WVNFFdJAOmuLcr3J8459e2T29NW7HoW+b6c5cFJj7FuYCCDV0wzlv9zyVKv3NrSPvKPo3kPRCfLtPp1jZ9qopEmS9XbaazSY09aRcKjLNNPGErdWZsUcWfbMCttdNx7kJ7OTPSHBXesHzrGuJ/6gg+m7cdWWYxt/BJvq7Qp7Z4Z/45YxOYZueamz/rbw2Xy8zLuQvHuEVGmlgG5c6DpvHOunhgxIadPP9VOtYIRpeQO6TZURxatfIYU5S7/ubXeASKK9P80cdVMCINar8WFEfpLsyRgzqnlalywCFB7t7I7vstF7lEeD1L1GE46Z/WJprs0QH2Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 972017c1-2ae9-4759-bfe4-08dcf82da1d3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 15:23:44.6700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /uzK611tLSkJDBO77VGJQjaf1wL5k6hF/iBJRoiQhO/Bq6h1qmCC6qx919FSaGmu2PXOf6NjGAC7duDInw+2J5GneGRJcz45uMaGTHVsS/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_10,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290118
X-Proofpoint-GUID: Ah6P3euoLtSHJUEZYZU7sqIYm80qqXbH
X-Proofpoint-ORIG-GUID: Ah6P3euoLtSHJUEZYZU7sqIYm80qqXbH

Andrew - could we modify this patch please? I'd like to not include the change
to mm/shmem.c. Sorry to be a pain!

On Tue, Oct 29, 2024 at 01:03:46PM +0000, Lorenzo Stoakes wrote:
> Currently MTE is permitted in two circumstances (desiring to use MTE having
> been specified by the VM_MTE flag) - where MAP_ANONYMOUS is specified, as
> checked by arch_calc_vm_flag_bits() and actualised by setting the
> VM_MTE_ALLOWED flag, or if the file backing the mapping is shmem, in which
> case we set VM_MTE_ALLOWED in shmem_mmap() when the mmap hook is activated
> in mmap_region().
>
> The function that checks that, if VM_MTE is set, VM_MTE_ALLOWED is also set
> is the arm64 implementation of arch_validate_flags().
>
> Unfortunately, we intend to refactor mmap_region() to perform this check
> earlier, meaning that in the case of a shmem backing we will not have
> invoked shmem_mmap() yet, causing the mapping to fail spuriously.
>
> It is inappropriate to set this architecture-specific flag in general mm
> code anyway, so a sensible resolution of this issue is to instead move the
> check to arch_validate_flags() itself.
>
> This requires a modification to the arch_validate_flags() signature to pass
> in a pointer to the struct file associated with the mapping, however this
> is not too egregious as this is only used by two architectures anyway -
> arm64 and sparc.
>
> So this patch performs this adjustment and moves the check to
> arch_validate_flags() which resolves the issue.
>
> We'd ideally like to have eliminated the arch_calc_vm_flag_bits() case, but
> we risk inadvertently changing behaviour as we do not have mmap() flags
> available at the point of the arch_validate_flags() check and a MAP_ANON |
> MAP_HUGETLB case would be accepted for MTE currently, but a MAP_SHARED |
> MAP_HUGETLB would not.
>
> This is likely an oversight but we want to try to keep behaviour identical
> to before in this patch.
>
> So continue to check VM_MTE_ALLOWED which arch_calc_vm_flag_bits() sets if
> MAP_ANON.
>
> Reported-by: Jann Horn <jannh@google.com>
> Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
> Cc: stable <stable@kernel.org>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Tested-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  arch/arm64/include/asm/mman.h | 29 +++++++++++++++++++++++++----
>  arch/sparc/include/asm/mman.h |  5 +++--
>  include/linux/mman.h          |  2 +-
>  mm/mmap.c                     |  2 +-
>  mm/mprotect.c                 |  2 +-
>  mm/shmem.c                    |  3 ---
>  6 files changed, 31 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
> index 9e39217b4afb..94925a0482e3 100644
> --- a/arch/arm64/include/asm/mman.h
> +++ b/arch/arm64/include/asm/mman.h
> @@ -6,7 +6,9 @@
>
>  #ifndef BUILD_VDSO
>  #include <linux/compiler.h>
> +#include <linux/fs.h>
>  #include <linux/types.h>
> +#include <linux/shmem_fs.h>
>
>  static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
>  	unsigned long pkey)
> @@ -60,15 +62,34 @@ static inline bool arch_validate_prot(unsigned long prot,
>  }
>  #define arch_validate_prot(prot, addr) arch_validate_prot(prot, addr)
>
> -static inline bool arch_validate_flags(unsigned long vm_flags)
> +static inline bool arch_validate_flags(struct file *file, unsigned long vm_flags)
>  {
>  	if (!system_supports_mte())
>  		return true;
>
> -	/* only allow VM_MTE if VM_MTE_ALLOWED has been set previously */
> -	return !(vm_flags & VM_MTE) || (vm_flags & VM_MTE_ALLOWED);
> +	if (!(vm_flags & VM_MTE))
> +		return true;
> +
> +	/*
> +	 * We explicitly permit MAP_ANONYMOUS and shmem backed mappings to use
> +	 * MTE. We check for shmem explicitly here.
> +	 *
> +	 * The MAP_ANONYMOUS case is handled by arch_calc_vm_flag_bits() which
> +	 * explicitly sets VM_MTE_ALLOWED which we check for here also.
> +	 *
> +	 * Ideally we'd perform both checks here but existing semantics support
> +	 * hugetlb in MAP_ANONYMOUS mode but not a MAP_SHARED mapping, which is
> +	 * likely unintended but we maintain identical behaviour for
> +	 * consistency.
> +	 */
> +	if (vm_flags & VM_MTE_ALLOWED)
> +		return true;
> +	if (shmem_file(file))
> +		return true;
> +
> +	return false;
>  }
> -#define arch_validate_flags(vm_flags) arch_validate_flags(vm_flags)
> +#define arch_validate_flags(file, vm_flags) arch_validate_flags(file, vm_flags)
>
>  #endif /* !BUILD_VDSO */
>
> diff --git a/arch/sparc/include/asm/mman.h b/arch/sparc/include/asm/mman.h
> index af9c10c83dc5..d426e1f7c2c1 100644
> --- a/arch/sparc/include/asm/mman.h
> +++ b/arch/sparc/include/asm/mman.h
> @@ -10,6 +10,7 @@ int sparc_mmap_check(unsigned long addr, unsigned long len);
>
>  #ifdef CONFIG_SPARC64
>  #include <asm/adi_64.h>
> +#include <linux/fs.h>
>
>  static inline void ipi_set_tstate_mcde(void *arg)
>  {
> @@ -54,11 +55,11 @@ static inline int sparc_validate_prot(unsigned long prot, unsigned long addr)
>  	return 1;
>  }
>
> -#define arch_validate_flags(vm_flags) arch_validate_flags(vm_flags)
> +#define arch_validate_flags(file, vm_flags) arch_validate_flags(file, vm_flags)
>  /* arch_validate_flags() - Ensure combination of flags is valid for a
>   *	VMA.
>   */
> -static inline bool arch_validate_flags(unsigned long vm_flags)
> +static inline bool arch_validate_flags(struct file *file, unsigned long vm_flags)
>  {
>  	/* If ADI is being enabled on this VMA, check for ADI
>  	 * capability on the platform and ensure VMA is suitable
> diff --git a/include/linux/mman.h b/include/linux/mman.h
> index 8ddca62d6460..82e6488026b7 100644
> --- a/include/linux/mman.h
> +++ b/include/linux/mman.h
> @@ -117,7 +117,7 @@ static inline bool arch_validate_prot(unsigned long prot, unsigned long addr)
>   *
>   * Returns true if the VM_* flags are valid.
>   */
> -static inline bool arch_validate_flags(unsigned long flags)
> +static inline bool arch_validate_flags(struct file *file, unsigned long flags)
>  {
>  	return true;
>  }
> diff --git a/mm/mmap.c b/mm/mmap.c
> index ab71d4c3464c..40b5858ae875 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1511,7 +1511,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	}
>
>  	/* Allow architectures to sanity-check the vm_flags */
> -	if (!arch_validate_flags(vma->vm_flags)) {
> +	if (!arch_validate_flags(file, vma->vm_flags)) {
>  		error = -EINVAL;
>  		goto close_and_free_vma;
>  	}
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 6f450af3252e..c6db98b893fc 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -816,7 +816,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
>  		}
>
>  		/* Allow architectures to sanity-check the new flags */
> -		if (!arch_validate_flags(newflags)) {
> +		if (!arch_validate_flags(vma->vm_file, newflags)) {
>  			error = -EINVAL;
>  			break;
>  		}
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 4ba1d00fabda..e87f5d6799a7 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2733,9 +2733,6 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
>  	if (ret)
>  		return ret;
>
> -	/* arm64 - allow memory tagging on RAM-based files */
> -	vm_flags_set(vma, VM_MTE_ALLOWED);
> -

Andrew - We don't want to include this in change to mm/shmem.c in this
series as it turns out we always need to set this flag, hence the need to
not include this part of the patch.

Thanks!

>  	file_accessed(file);
>  	/* This is anonymous shared memory if it is unlinked at the time of mmap */
>  	if (inode->i_nlink)
> --
> 2.47.0

