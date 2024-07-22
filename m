Return-Path: <linux-kernel+bounces-259357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789529394B4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 22:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB312822E4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 20:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE73219E1;
	Mon, 22 Jul 2024 20:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BIM92WEa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UVxII1+y"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D8F1429A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 20:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721679826; cv=fail; b=PnGcNk/ywkYn5h0WxEVoT6/2jlNrw2CPHAhCJR7dAb/I7gI4jD9IcXEU2NcDEosUo864yoo4+d9Zng6jMFy296iVqMdYkcag3YBj0GeiERIKKV6ViJU4kjbCzGjtY7W4avgf3HWmAUV4cAv6sNcWC9DR0bIBn5ctF+/YugAwSnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721679826; c=relaxed/simple;
	bh=BXONMHGa6JUw7/kDcc1iJ0w+p1++21II29ahAoKbFdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gAeClcBReyYtpKnAo8yAk1lQfpYPYg/THaRc8MNfhauKlHlVIHYr6PCKsjjn9spLb2l3BK4MgBmNkrWyPRkQv9UVtPnUAFD2h8F6pB5GMy8wlYaFovf4lhLIiIYTU0uM6gXX1KNdPU1Z4zqWQVy9lpaHlMyxdYaEqHdHRburYJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BIM92WEa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UVxII1+y; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MKMV0m004327;
	Mon, 22 Jul 2024 20:22:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=KuuAYKMp++amimo
	Z3o4UtO9w7nLaviPQCJZwiqK4mEw=; b=BIM92WEaoZxPZ7Mxt2KRQP5RwYWQPSp
	OGKXBGsjr/i9DpxAsgOT71dAJRP/xDZcHX+rurq89ofsbKmxyWSZlIYMbvVxgt+/
	TO+Cu1T2AeFIf/dUHw9WjWs9B6aSWGpRaLuNloaZIKgHIODWccBn/4tcPRZ0mxbv
	c5wCNsGgjLFF/bOwRY1V9LhUPNTndXBBPyPy2PLtK4T9xZHBA6l9dKXi7tYyCeWC
	nXk7CM1v0RjmF6b1zCzXBJCiHnAebJRiKZm7Om1yW1fIONrhLBXBV4EJwhn1oT4H
	MO7gVfpQaUgdqFoy+EjU+kcHAdkxUccXK/OTVuB6Y2f2aK8+FslEORg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgcrbdnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 20:22:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46MImqiG011001;
	Mon, 22 Jul 2024 20:22:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h29q8hr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 20:22:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gfHX/zS3yatOaJZ5K1PLqudmYd0b+KBh00Ffm6nH75htsulf1uWAH5rFyr1Wj2eMvaSdnZH3X6sV7wZSmMVw4YkTHFTr58rigSL3kQNfKCuqPWSSDKVfQjqXBcC3VdJuh7HfyJTYQM/CSHVBiFWUYYmuXB9kRYkDwYu7QCoTskIxvawLhT5sOIhf6p79udEy5PqnsWz2sqtV+DG9e+kYCnbvhjkEFmjm40gNjcLxok69qCT00/SJXcH53hvOrO5NUfH2z40dswNsdXCYKlQawFrAszKwsYamoEtFsiN0P/Mo2mgQQuikdX2UN9A8bJR0aIBUWPMbuqN8KbBwoIFLHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuuAYKMp++amimoZ3o4UtO9w7nLaviPQCJZwiqK4mEw=;
 b=k2jwuFvubOIPLb6LcY+tym/Eq0dMNlUjU9YBhiuAbv02sAL9Y3sxL7bvvpILUDjwBldNzgs6n3v+w0pjcwoUa484J3dPUbelbgbskbc1yW3kaIytqL+s5VX+j3jzgc/g8q612UvvG51Paom3qBmS2zb9GM8wLLVt3JZT/fbMFbWeNjVPCd2iQnn3+tjpEiQsS6AJGjb2+NyUeNjeTSFX7d/SahoHf1pRX2IPLrYQcL/Rrx5xmCRSyNWDVisViq4TPDL+NQT9vX2X0AAeDvTc1TYr+bpSlKA1vF3YmpEsxnagt8Qjvywu0d3wtxy07vNAaeEX3piAv2tudPsVvwMj1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuuAYKMp++amimoZ3o4UtO9w7nLaviPQCJZwiqK4mEw=;
 b=UVxII1+yvnLt+YHfHbwB7MUyM+sFAfj19lpCj45IpqxiWA75GcdzNi3Vh//9YzcV6Syob6lRTBm4Eu1DrFPRc7uXrIqGdjL0b9gHQrmTEvUgp/IM9kiyPgRT2ibjSCaHg4QaXTnhWxeGh+VYDJCAdZzG0pLiEnwGkp05ztsDjjA=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS7PR10MB5072.namprd10.prod.outlook.com (2603:10b6:5:3b1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Mon, 22 Jul
 2024 20:22:48 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 20:22:48 +0000
Date: Mon, 22 Jul 2024 16:22:45 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>, x86@kernel.org,
        Yan Zhao <yan.y.zhao@intel.com>, Kevin Tian <kevin.tian@intel.com>,
        Pei Li <peili.dev@gmail.com>, David Hildenbrand <david@redhat.com>,
        David Wang <00107082@163.com>, Bert Karwatzki <spasswolf@web.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] mm/x86/pat: Only untrack the pfn range if unmap region
Message-ID: <ox3rg6uyazlaeshxeub5hxv4z4bjai222mkitoduktmar5l3pd@qfxv4jdnj5xo>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Alex Williamson <alex.williamson@redhat.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"Kirill A . Shutemov" <kirill@shutemov.name>, x86@kernel.org, Yan Zhao <yan.y.zhao@intel.com>, 
	Kevin Tian <kevin.tian@intel.com>, Pei Li <peili.dev@gmail.com>, 
	David Hildenbrand <david@redhat.com>, David Wang <00107082@163.com>, Bert Karwatzki <spasswolf@web.de>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20240712144244.3090089-1-peterx@redhat.com>
 <t7q4s4rktcjkrtmr7l2zffpthxis5bmafhae7aaxxekyyp75ev@x4dshxdx3jpo>
 <Zp53fnlsJGOmWSRQ@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zp53fnlsJGOmWSRQ@x1n>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1PR01CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::7) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS7PR10MB5072:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe2e41a-b810-4475-7887-08dcaa8c0dc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gnGk5McyZ0dbPN1MadqkJ9SrF6OBM32pcOaJZ62wHMHVMSuhdZoK3aX4cqP7?=
 =?us-ascii?Q?ZgMAkMNiHA1d+4RZvTPDNB92CYCwr3xWakhaV8PnF573uHopDUTf90ps7QXN?=
 =?us-ascii?Q?imC6OW25NJ6ZWVWLjTZ89HH07EmQvFs7mabvCQq72fzgi0GF0MNURsT4CmZx?=
 =?us-ascii?Q?6BI90bEAha3S2bLactXrmx6K42ouQQHFfx+BoNYmBzIJrjpg3qO4wleoIRm9?=
 =?us-ascii?Q?vxQA/1uA0v4Eb/yBBuXS/X7T519sJXNLN7ed0rbWuOXdgcpGFfn+qQN9CA7C?=
 =?us-ascii?Q?SUH07Hx4RkWfSFXlCoksDBqn8LwznSOmR48+XFDtfvrBiuVCwposbEziUM5j?=
 =?us-ascii?Q?RwJNfzLrtVLyhbHtgswX8XMJLu3fcWYEo394LBTMKjduptEkbplKnoYPH+50?=
 =?us-ascii?Q?3655mW/n6r8zznihEfTgkqdACl6/46DsCbIXaf4WqWyyLld93ozgjCErftNT?=
 =?us-ascii?Q?FBxXj6kYxEOMJyvu8kAs8OSo3aU5k6ahgqAW4Q5Tu3MEHE2AwCBlbAPEUUwk?=
 =?us-ascii?Q?CWV78RSgeoNbNuxxvSi2yhnBOmm1nZRBX1J2otA+0ZR+su9laKkWGVrgW8Wz?=
 =?us-ascii?Q?/9YmlwSBpPb5kF2V4BYXP1UxWANPffbYkdlopi7fh+gYqwch2jB5QbQPskDI?=
 =?us-ascii?Q?pS7RySP/OvuvrAFZTBOsrUcgD1SRFiqB003WqvHxAXECwhJZJdFom3P4iqMx?=
 =?us-ascii?Q?iDtmaE9qFUQfKDmLOuIMvbwaGnH51o2FRib9E5UdvCTJ8lmc8GDVeAg+8nTA?=
 =?us-ascii?Q?a4w1AH8F25UrKuPWQE63HhL53D/kZKZxNiam0J0tb4JTQVf2HntLeUoW/rZ+?=
 =?us-ascii?Q?6wcC5bBCqCcPomJ9vwzfO0GbBAtew4d0k3etVMllARtHiS2AD9Ku6Ae5Wmp7?=
 =?us-ascii?Q?Ba1OuqwaKL/qEcTD9yRo8LAlxEMO0yGV0n330E2fTF+JPMRHPNo+6d3l//AN?=
 =?us-ascii?Q?AB2pPkRLBmOv4zbshfLErYMUN2f+adNVGBsk+hBXYCNpEjJ1o4div3b7pN50?=
 =?us-ascii?Q?nW+s4/ifEksFoLZ4WtGRyMcrpJfBmPRFtzrt5FRr1ZdLUbaQKWKpnWtTLH91?=
 =?us-ascii?Q?YnRqgoNVH8/V+f/2RDKrKZ+4h22xttI6taze6UlBwwtbxouxYcdfgZO4u16c?=
 =?us-ascii?Q?sQDOSH41ZuUC0XZCWAG/9Ye+fogoAQMir7E5pGLYiByHfho4WR9fXdYnbmD/?=
 =?us-ascii?Q?x1/Qt6hbiFgJuLVH261wNKSeg3nObNPxtFw/2Z24pX7CcpoEySy1edc2mQ32?=
 =?us-ascii?Q?xQMO9tj9fAiHEOU3OV4Gff+5DkiTDN3XjZA9jG1iaMYsu3iE7CTOo1f3Xy/g?=
 =?us-ascii?Q?Zxo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v0bshRur5pi28fI/bpxfvckaV/3OV+GLZFh/RkHkh/GVvHsX7fSpq0ltRUUU?=
 =?us-ascii?Q?rVk/LW606kI8BYio9j5i0yjXwAOutd+m2hkthXBb/ykJhJLSJfltdIKBNniC?=
 =?us-ascii?Q?bO+pBErc0osoo7eaflPyRlWEDqe3hVPYLI/2Kmj8uG7b0lg7kaJxiS5ifOGJ?=
 =?us-ascii?Q?t6hbFVH0n0qmK63+/7kyQxadM+ijaTpTi8KVUH/2zXffd/+LEk/SUaNUNAbZ?=
 =?us-ascii?Q?gACgvgK3JwK8Z1bRDCs1OiDnLPAjOyqL2brO0X2oXuM3fy4wnaCUv5UGHfHi?=
 =?us-ascii?Q?2OqdmnlOOwMcHQRMf/PZsLRnaIRtfmq2jKtfMqCjN7nCJgSmRDGl93RKgdIK?=
 =?us-ascii?Q?DqwZPWyYFCCsaR2QiGQFcoP3DlWuFVL9ZAS1zFPq5Rbhw5PC7QXqr62E0Smd?=
 =?us-ascii?Q?vlsskRGaxZiVlasKgOICVkpwD2kBuWVu4SPCKfERlB6Hy4ICuTz32CHQeFNN?=
 =?us-ascii?Q?IZ+I3q/AaWyrdvP/7IY8GtST0GfSimI54ef4ChiQGWN1SJXZMf7owUqG+2Af?=
 =?us-ascii?Q?tA8h1oxV18ocYOarVdpUU3odqL6bYymAq2P3GdSpKI5wKabaPZfbnvdtxJZE?=
 =?us-ascii?Q?c5fyM+dyWUyYLjaJvHlW2Lc1SBhOH8KfW9fRr9etSo0rCBNXvMj4jm+T8hBq?=
 =?us-ascii?Q?WQv7/Hk+Lo1n8Vxcw644Lrigm/wFio/vKflwoAy/PwW7dAFhX/JBiona4Dx8?=
 =?us-ascii?Q?3Jt29QM9yj2iWlHhvI/Ej0H8rvXRYaHnu2MH0iraY16GVO2cP/zuZ/mlqYEq?=
 =?us-ascii?Q?K26mA3KAclXf19pU0oMKDz0kFwIWdMHtvkymUrNI/Zd7R7CZwjf5ZZx6sd/C?=
 =?us-ascii?Q?G1fyVxEBr0ZzetGd6Kb6Ft3iRFJQHkrErTqB2UKvmGPLOoDgGXnG0rEACRHh?=
 =?us-ascii?Q?1Tywep40/ya6MHwdKKskgUxhPP2pHtx9uwF2oLv9O4vsFuC7ariZqffopTfj?=
 =?us-ascii?Q?Y49V2nsl/1VPoMtEZsqSnhE38SDpuzK6khMkT+rmL82py4h6N9hN/Too8R+4?=
 =?us-ascii?Q?almv14qSTpSDcxp3Vx9BSI4Zg6FODfoHYF0dhTST7kAMxojipvWfW/bCf7bj?=
 =?us-ascii?Q?H7zKrYv+fo+J5YoFkL7hqZPZVyE0DFGTvc/TyvswFhKQtojPL2u24MCn6JJ1?=
 =?us-ascii?Q?4hr7gSojfetbQhkHPpeB/nlt1FY3ov76cY24FLaQczbn1C5bPK7CXKfuheQq?=
 =?us-ascii?Q?WpUDSPH6jjGU1Aifm7TvQwDqdPyGxZ1rfOpXgXarLuMAN3bRxWCI3R561sfl?=
 =?us-ascii?Q?Q6Z6JFUgK8xv21XT8zADSI8o6HkqIlgtWbSJ/HKpBBv84ebZOBC+zgBEiP+9?=
 =?us-ascii?Q?jA3DlYcM2XpoSUQsvs1nEwBuilCzIzFTR6msOaDFFL0OBg0BHzsPrx4NzJ2X?=
 =?us-ascii?Q?e4RGrwjQNTQ3Ko3N+tK1tnNu99YoD1TvaJJu8pY/rIBTp3p6hV59HD3up9LV?=
 =?us-ascii?Q?KXIF5MiL8LT99uJor9DeP1DhLWTAJJuLEJY6kBl2U27D0eIZGa8I05TCM5Em?=
 =?us-ascii?Q?5gxhDCZa9xMdajKSZuMeTEzL/WU7Frq0DMjxTZa5DgcQb+b5vs4m3XTpNSIW?=
 =?us-ascii?Q?9QpUJOSJdZnxx2+OHA7g33iozx94f7PD8M2oHCVv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cPR8A7vjkT36wbifdvshFJOs12Xs+ZPpzeWCH9MsD7gtjzL1kf5+btyqmvEk46OANhA+bs/xTSnavLv/y1tFJ2RIezN8GNDRPNf6XCEvHDQv3d8kD3gc2wQuBfshv1tj3STwnl8H7ATEjBWQ5nmS9GxKZxF/f6+LtJCrqKc4Q1138Kp5C5RWuMrr40GqCuIlOos4QmtKfCsB/XvNwd0ZCl1ckdDO4yWa3UNbTjCKNeqAUZOXb2FPpA2hS8+YVJoWTHfMKhGt0QthHsKrtb6HW3n+kWcIJWIv6SVX8qu54QdbZ6XxfVb03ZngVv1k08vhrS5DFbiuVRPwb6znopbcwYiPMRzipPqMQK95XEfpn0Km3HOf87lHi+5XlGCrEa7byVNf+K1xVXGI7ZgmoTamqyh7ZLhyiVxT2XHluxRGRH/Q421tXJlUunbe0Ww/+loAxRzr9QLl0I8qm/wK2mpjh1oDSvcIJXOOv8V3jV8hSNu81UIhI/NlE3UQcv8dvc2eQlcd0PbYpRlxJjT1tBSImvO8ZMZ5PluzEl6O6QP7r/tN2SjAOmLsNrjyEbc4XovGm7n5UHD/HhzSmQczcY4hdcZm5ZcWOCpOepE020hHaQ8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe2e41a-b810-4475-7887-08dcaa8c0dc7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 20:22:48.4999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gGB6nT+xVeAPRM4p9URgRbtoR3cR+5u2a6c6GOYvNvrW0m2HauWBAhjcS8yUwyGebLN+uKstxHfal5cWoja5cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5072
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_14,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407220150
X-Proofpoint-GUID: eLb1FeMSb5r3a2NxKnRTgp53ih0KMCXO
X-Proofpoint-ORIG-GUID: eLb1FeMSb5r3a2NxKnRTgp53ih0KMCXO

* Peter Xu <peterx@redhat.com> [240722 11:15]:
> On Fri, Jul 19, 2024 at 10:18:12PM -0400, Liam R. Howlett wrote:
> > * Peter Xu <peterx@redhat.com> [240712 10:43]:
> > > This patch is one patch of an old series [1] that got reposted standalone
> > > here, with the hope to fix some reported untrack_pfn() issues reported
> > > recently [2,3], where there used to be other fix [4] but unfortunately
> > > which looks like to cause other issues.  The hope is this patch can fix it
> > > the right way.
> > > 
> > > X86 uses pfn tracking to do pfnmaps.  AFAICT, the tracking should normally
> > > start at mmap() of device drivers, then untracked when munmap().  However
> > > in the current code the untrack is done in unmap_single_vma().  This might
> > > be problematic.
> > > 
> > > For example, unmap_single_vma() can be used nowadays even for zapping a
> > > single page rather than the whole vmas.  It's very confusing to do whole
> > > vma untracking in this function even if a caller would like to zap one
> > > page.  It could simply be wrong.
> > > 
> > > Such issue won't be exposed by things like MADV_DONTNEED won't ever work
> > > for pfnmaps and it'll fail the madvise() already before reaching here.
> > > However looks like it can be triggered like what was reported where invoked
> > > from an unmap request from a file vma.
> > > 
> > > There's also work [5] on VFIO (merged now) to allow tearing down MMIO
> > > pgtables before an munmap(), in which case we may not want to untrack the
> > > pfns if we're only tearing down the pgtables.  IOW, we may want to keep the
> > > pfn tracking information as those pfn mappings can be restored later with
> > > the same vma object.  Currently it's not an immediate problem for VFIO, as
> > > VFIO uses UC- by default, but it looks like there's plan to extend that in
> > > the near future.
> > > 
> > > IIUC, this was overlooked when zap_page_range_single() was introduced,
> > > while in the past it was only used in the munmap() path which wants to
> > > always unmap the region completely.  E.g., commit f5cc4eef9987 ("VM: make
> > > zap_page_range() callers that act on a single VMA use separate helper") is
> > > the initial commit that introduced unmap_single_vma(), in which the chunk
> > > of untrack_pfn() was moved over from unmap_vmas().
> > > 
> > > Recover that behavior to untrack pfnmap only when unmap regions.
> > > 
> > > [1] https://lore.kernel.org/r/20240523223745.395337-1-peterx@redhat.com
> > > [2] https://groups.google.com/g/syzkaller-bugs/c/FeQZvSbqWbQ/m/tHFmoZthAAAJ
> > > [3] https://lore.kernel.org/r/20240712131931.20207-1-00107082@163.com
> > > [4] https://lore.kernel.org/all/20240710-bug12-v1-1-0e5440f9b8d3@gmail.com/
> > > [5] https://lore.kernel.org/r/20240523195629.218043-1-alex.williamson@redhat.com
> > > 
> > > Cc: Alex Williamson <alex.williamson@redhat.com>
> > > Cc: Jason Gunthorpe <jgg@nvidia.com>
> > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > > Cc: Andy Lutomirski <luto@kernel.org>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Borislav Petkov <bp@alien8.de>
> > > Cc: Kirill A. Shutemov <kirill@shutemov.name>
> > > Cc: x86@kernel.org
> > > Cc: Yan Zhao <yan.y.zhao@intel.com>
> > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > Cc: Pei Li <peili.dev@gmail.com>
> > > Cc: David Hildenbrand <david@redhat.com>
> > > Cc: David Wang <00107082@163.com>
> > > Cc: Bert Karwatzki <spasswolf@web.de>
> > > Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > > 
> > > NOTE: I massaged the commit message comparing to the rfc post [1], the
> > > patch itself is untouched.  Also removed rfc tag, and added more people
> > > into the loop. Please kindly help test this patch if you have a reproducer,
> > > as I can't reproduce it myself even with the syzbot reproducer on top of
> > > mm-unstable.  Instead of further check on the reproducer, I decided to send
> > > this out first as we have a bunch of reproducers on the list now..
> > > ---
> > >  mm/memory.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 4bcd79619574..f57cc304b318 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -1827,9 +1827,6 @@ static void unmap_single_vma(struct mmu_gather *tlb,
> > >  	if (vma->vm_file)
> > >  		uprobe_munmap(vma, start, end);
> > >  
> > > -	if (unlikely(vma->vm_flags & VM_PFNMAP))
> > > -		untrack_pfn(vma, 0, 0, mm_wr_locked);
> > > -
> > >  	if (start != end) {
> > >  		if (unlikely(is_vm_hugetlb_page(vma))) {
> > >  			/*
> > > @@ -1894,6 +1891,8 @@ void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
> > >  		unsigned long start = start_addr;
> > >  		unsigned long end = end_addr;
> > >  		hugetlb_zap_begin(vma, &start, &end);
> > > +		if (unlikely(vma->vm_flags & VM_PFNMAP))
> > > +			untrack_pfn(vma, 0, 0, mm_wr_locked);
> > >  		unmap_single_vma(tlb, vma, start, end, &details,
> > >  				 mm_wr_locked);
> > >  		hugetlb_zap_end(vma, &details);
> > > -- 
> > > 2.45.0
> > 
> > 
> > ...Trying to follow this discussion across several threads and bug
> > reports.   I was looped in when syzbot found that the [4] fix was a
> > deadlock.
> > 
> > How are we reaching unmap_vmas() without the mmap lock held in any mode?
> > We must be holding the read or write lock - otherwise the vma pointer is
> > unsafe...?
> 
> The report was not calling unmap_vmas() but unmap_single_vma(), and this
> patch proposed to move the untrack operation there.  We should always hold
> write lock for unmap_vmas(), afaiu.

unmap_single_vma() also takes a vma pointer.  It is in both [2] and [3].

> 
> > 
> > In any case, since this will just keep calling unmap_single_vma() it has
> > to be an incomplete fix?
> 
> I think there's indeed some issue to settle besides this patch, however I
> didn't quickly get why this patch is incomplete from this specific "untrack
> pfn within unmap_single_vma()" problem.  I thought it was complete from
> that regard, or could you elaborate otherwise?
> 

The problem report from [2] and [3] is that we are getting to a call
path that includes unmap_single_vma() without the mmap lock.  This patch
fails to address that issue, it only takes the caller with the assert
out of the call path.

Removing the function with the lock check doesn't fix the locking issue.
If there is no locking issue here, please state the case in the commit
log as you feel it is safe to use a vma pointer without the mmap_lock
held.

Thanks,
Liam

