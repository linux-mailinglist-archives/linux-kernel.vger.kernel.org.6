Return-Path: <linux-kernel+bounces-536196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0204A47C9E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E32093A5C20
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67161229B23;
	Thu, 27 Feb 2025 11:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GFtBpQ3o";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q53H80mR"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E815C22A1CF
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 11:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740657241; cv=fail; b=GsjaSqDctS8aoE75Q1V2TqCdUi+n0aGG6Xu6c4OtOAyYjBn3MowP4uJ33rRjDrzlWkOvEipwtqG+MDCfwZfp3y9lQwa9iTCv1xRZyvvnoaT/MXNZoCAvdLvrJWsmbrqcSXw34Ye6jZPsx0gphCwHmCrsxobWeGY/uKugt5KmTLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740657241; c=relaxed/simple;
	bh=thL5GvMWFmuDfMzxCVHLSqzIUH/sro4epq4Tq/ERaUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C89euXp++lCCDTRtnfVBdbYqFMPmswjQ9jpmT4C6/FU/e0KBB6TDzddYlvMBE1/Y2ASAvacCjIpVp6ARaEGUaCFG/2zjJxHh4Cr61w6+XnPxyP6TJTDBhy855qS/CXLca/x/aWkd8eqKk31/QzOoj4Jy0Qiejx/iisQFoF//h3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GFtBpQ3o; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q53H80mR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RBQas9003622;
	Thu, 27 Feb 2025 11:53:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=j6C2MF+tVnClrxcAS5
	uG7Waf0bMJsJx8YbZAJGI/JKo=; b=GFtBpQ3o5izoNZ2ybi/8u41EC2pzQCSH18
	GCyksHzvDXMtpyKnSRJiKo8k1W3rm4OFKqBHNUxBt/glE6khtzrkg7JgTh6i5PDt
	mmTIxk8RzbDWIDEJ+kZnod9fxdNOuiZUpafym7Fk6ZsH1y8L+Xtl+CJRaIf2oqEA
	SSO6d0pK90S9uxpfOFv078gNmT3znbXlLfbcgLVgx5i0DbQJBvcDH2XiUYq3yqnE
	LU8SjzXa2JksaTi2kAhnGdj9m6Umu2JUsmnYeprX7ZKOmHaChyuPsVNtqpzVw4u/
	RAeTj2YyuseJikGRkuwHGkg6HHzP9Z1Ay/8CkCx1PSBpzRNOXifQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psf375m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 11:53:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51RBdSXL007528;
	Thu, 27 Feb 2025 11:53:31 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51j34ch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 11:53:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1+wUMJtKOcxuSpeCwWTehNFHcoso49I1jgddeuKkLgaA5qlgT8y4/HIM03kpgeI0VQF58Lt99RaOn5/OK79JQpA7ZbyTWljJiqSSNOaEMRV+ZahG61aXgiU8roMxy2Y7q16FZ4O77AKKKxX6ju0MxhRwHLoh7CWI6j1hzn4O9SkU7+sTVJCXgCCLbFRYrWghHu25/0APCIq2WOsX1LsA87CzMyDVfMCJ/Cee+6kWOiVcItvfYBe+7yfoE5uBXYZ2bjFoYOoV7eRQyrJL6975aOEDGery4gjPB0LHjMLrWlPcBaaxmJJPpB01YS97uksBFCtcn3beRwT8SnMs2mcCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6C2MF+tVnClrxcAS5uG7Waf0bMJsJx8YbZAJGI/JKo=;
 b=GIzv6A++Wl/GB94gCpitjX8QCB8jLWH71LN/CCN7c31D6GkAYZKEzmMwrHfckfJGA0JmvfAl237L0HuBSxxTr1LIHv+dmqt91c/5MUlNOSRwhCNcdbrvYHdXiWwL0zpFrrpLU9dsFbCjSahr6Z3KfV0xR6nUSn+0T4iNQ2tDw+cztFJDBNB4ep+2wIBLzfOv3AuJ9IGNrtCZNHNNmW7oF/bRwQTXh8CW6gKBwbQs+s2jUjK56kPeIeXiCb0cNAGNCHhwfU79/PXX0JSSJfkV3sJuGCmVJk2SO+1sMNC+qQ1GtvwB2qVR3Dbd5evXOwM0J/sW/MyQKDvYHQBk0mQK4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6C2MF+tVnClrxcAS5uG7Waf0bMJsJx8YbZAJGI/JKo=;
 b=q53H80mRloP42cKoooHtFanqcSJ3BLXkBJQj+MSrHbole91iZ6EGMLpgmPuwo7fNw9RZLvfqPpt9pYK4Mldw5jj9jLMwARj0DtncO5uRFOWmX7bkY7ZaRo9z7UwV8t2aLySh3nBAb61WlhWALZdUzjgAZ+3AgO/9sgG8VUhHwag=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH0PR10MB5067.namprd10.prod.outlook.com (2603:10b6:610:da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 11:53:16 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%6]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 11:53:16 +0000
Date: Thu, 27 Feb 2025 20:53:10 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Hyesoo Yu <hyesoo.yu@samsung.com>
Cc: janghyuck.kim@samsung.com, vbabka@suse.cz,
        Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] mm: slub: Enhanced debugging in slub error
Message-ID: <Z8BSJn-hcBEOoJXN@harry>
References: <CGME20250226081354epcas2p44c2f53d569296ac2e5f8a7b01f4552fa@epcas2p4.samsung.com>
 <20250226081206.680495-1-hyesoo.yu@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226081206.680495-1-hyesoo.yu@samsung.com>
X-ClientProxiedBy: SL2P216CA0206.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:19::9) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH0PR10MB5067:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c67ae9-d035-443b-08a7-08dd5725524a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BMZiMewAEOET64PA5QiuIim2iCC2sCuVRrECl/7/vmUQwfUmS+HRRgPsh+U/?=
 =?us-ascii?Q?1fSMvBfqmPFILlfickvJXVvsOTaW3kqaVp+vx6ZL2sX7etGaQD0CF72FdfXd?=
 =?us-ascii?Q?+Jz9tJHIQ9fOdqqna2N59X7S4OegTFH6UmU3JmI6kyE5ko0NKLq/KN0WDiMo?=
 =?us-ascii?Q?jG6NS633hicACEERMaq47Ufd4dzbac0aSh9XRvdzYheFcVw6vzMd96NijPLs?=
 =?us-ascii?Q?n2lJKr/AxEUZpLIOVm1Zvv/fi7AfJJhJY23eO2lEYkmRC6nRitV9IewMi5il?=
 =?us-ascii?Q?66WjT5P/90+9FoYNtYRYsC51YzwCmUUGpJYD1qSExre+aK89LHeGLgpQOg0f?=
 =?us-ascii?Q?IHghlvU1mcOUK9JrCQ8rzEWyUPu4zektarKJ9rXnMLmru4EOPAdPiwzLIOUW?=
 =?us-ascii?Q?5JTLyJF8VjQWn038CGXbizCdx4G673mTicAv7vowGiNOQn+zbACqA11zkKK7?=
 =?us-ascii?Q?VdpGlmNUMso+WVWUZPCc5txTWgQUjyq4sDnzKInNpEDNs4NlolifYLox10+Y?=
 =?us-ascii?Q?Y1ilH+MPWSPrnmicRhNCKSkc5jdSjXo5t5E50tVEfZ0x7dqmrMdxisDO2wtR?=
 =?us-ascii?Q?c5Vxq7YohN9CudT+ymQk3j3+T5JQtqp4EfNVA8JtMNGTnCMfyvvbrTqn3ruS?=
 =?us-ascii?Q?TcH5NTeQLFAF9NzF1mMvTLpvjwrgIroYiJFwrG8ABD6OYFPQqKDROrzdkenP?=
 =?us-ascii?Q?mJREiy0M9PqEdG9yN9A753udILNZnzQY11bpQXgnhoIN/586B1kp+SldYiZk?=
 =?us-ascii?Q?C7i+EKnR5WHn7z68c0+vf/yAmai68TvX5WYMtAnmUuumxkvvldtTQXvfcZtD?=
 =?us-ascii?Q?MYt/GIbn70opq4xpC/R4JHgjiaz/ZfwECW/eKmavdVpqD3+ObF0HiZ5tfgNi?=
 =?us-ascii?Q?SXB5SO9Jg6VqatVFYk8EG5h5f5UGKbnr4F9e46s3nqUkRyydQQFISFuHz0sg?=
 =?us-ascii?Q?wQx9aqYwR5QeSMtDYXwxxCPzbQ7ufySrr6aj8gHviRU4LZIurh+MI0D7g906?=
 =?us-ascii?Q?DYJub/+iNKKEEDMKYLbqVXhlWLDmzIJ2VyJOsMaZ0KQyrRWWNyRKXf4S8jXA?=
 =?us-ascii?Q?rbPfYegSQIKAcXSc1Pdum4Y45C6qkU7b/3f+mM7/TeUZMHtXcLcavyCr+nz5?=
 =?us-ascii?Q?TT4Ar00/SZwoumSkeCSKj04CR8IVstDnVe9mfUoIikqCBQ66z/iGX72XrZyP?=
 =?us-ascii?Q?Ms3JSOfhgOyk0A/VNCSrmJ04xAof+XRSENNEgtWJi4m8uNzDAfSwZ6iy15hS?=
 =?us-ascii?Q?tgTqgb/OYkCJJwWeFKid82STWlo9Rqg7XrNviE4BTciTVyOvE2u3l/f4CH+d?=
 =?us-ascii?Q?Dxt8B80PdiQ0MLs1/2kqdQO6l3seopgBMTHo/4CpP/vHYkTxQS9PVowoEkp3?=
 =?us-ascii?Q?aZ8GquNvKjX68m2M8HpPWyqYonfl60DCC1pRj9muQBnH8a5ikg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UbhcvKKFDDBayQNX/F1dMsKu9lRgMNOjEpWX5uYUJ0YlSSmHmZ4QgFXU2Dcs?=
 =?us-ascii?Q?0GTpOQMuNHUvgdy/i75Y9e2/y+S2Ios9V8XkBkwUKXbk1Rz7s1XmlPUycs+W?=
 =?us-ascii?Q?KtDt94PFYns4WaxXPb1Uhd0HV8i14YCoF9DtpTbmxugCB4NO6ct8NUmF34FE?=
 =?us-ascii?Q?kXo+VkWWv8dQ0jXpPr6x/PT+ZJY4IVJrQvPPuDwrlKWY9nX92oduinRgstUE?=
 =?us-ascii?Q?KotLLQyASukFQk+Y0Z13Bqjr86Hx7rh7Iew0HCxu2Rd0t1oS6t21jiYaCVwe?=
 =?us-ascii?Q?fjyt29YXcVPvii3C+WuGBgWzMaRB7jQcmXo5Ec344HepV/hvDzf6/D/YVWhp?=
 =?us-ascii?Q?ABu//v9pd5rZESVETsSjI7L6bYIi87q9MgUco9qsJu8gf9HU9G1EkzGbs11l?=
 =?us-ascii?Q?a0ihO0AY9kEuIqOOT6Ykb1vr6sO534gXdxWViTW3L8g6LZcvRHme2PhV/n4L?=
 =?us-ascii?Q?P3YG/3lSK1vhgE3yX3JET6k9Yidbbv00D+Ywgda3serx5inmqUbHMCOY2FrY?=
 =?us-ascii?Q?7oS0zEwZ9DtpdH8kQnVKUd9hScDeY4YHbcnEERbXNzlfkZY1NlcrNKmtSIIi?=
 =?us-ascii?Q?VcN2f0s4fNdrsSTBi8eLrhSakWch31qNn0Quewi2zBg2i0WBz7+bQO3tKZSA?=
 =?us-ascii?Q?InSHxqjoMc3Prk+EnQnXFAoEXIz6x7+NOM9w3xjoP4HmW9gDoPioKF+T3BO3?=
 =?us-ascii?Q?onplzAW3s6cu4T10KjCeQvf+jb11fAZtoxy3esTpY8SLCCdqrTrFwuMm2/fB?=
 =?us-ascii?Q?gxNkWbZsPq7xQkvQmTRyOjls8b+rKC39SpFGwGqTk+MrBiUgKKG4Qd2CBnww?=
 =?us-ascii?Q?omXIVQJjsvAj9yx3qTTrsJ+q7TlAIR6BTCzcB35gbvDZZTYR6bqbHolcvgWm?=
 =?us-ascii?Q?JVA0GB7wIN7ygK36DyGVkK7g/pMOl/PKzBUOM2fQ2NB22R/M0LdytTTkcg32?=
 =?us-ascii?Q?BiQ1XaKm+YeRNH1Kcre6MirL4Dtuw577timKksge3rF488zrxU4cPiEtI/dd?=
 =?us-ascii?Q?rR5p/TDR9lUbPmxAAfRC0tEAFFa9RHvwnn2eVcSgrAW7QKIdchekLSoRkk/H?=
 =?us-ascii?Q?FHPHxqnKCV+AJ0vp5+oT3Udxl49EeLH1pWErU2jNxNpPEuGV+JXDNGdY9EYZ?=
 =?us-ascii?Q?TOLHMByypj4d9ZsDr84FDpUDYZoK+IN078xiu8ITgdA1iEO+a5c3JmcFkYpM?=
 =?us-ascii?Q?8SNog4tAZhOTA7eOQIdxmdt6BMHNqZzyJXzjCWGugvKfwplDVhGolCdJJhUR?=
 =?us-ascii?Q?QxE0srhHpruf3x/C30sfrClHjPZPxGj147DODmYl7t8ItUA434xmvG3LpYIr?=
 =?us-ascii?Q?C6jwgHKYTpqoJiKvNxrb8brrdg/C/9gH3SQgCiLNT8Ys3xZiq3pmQU3OQe3a?=
 =?us-ascii?Q?1wNmTjQ+de6A5dR95/YuxgwwM6nZ5tGLsS5xc3bGLYMMOyJAgr9mQBhXc5uY?=
 =?us-ascii?Q?HnrR4HQCa/h0RDPTc2H+rDknG939c43SvW4FT8zpFOlGRV4vIL4geIPLjXes?=
 =?us-ascii?Q?LrkMV4mQPph1h1SEXQB63brMK9Rspod/bOt9HqTnQzsit7j9THc1dMFfyx2o?=
 =?us-ascii?Q?qY2cYnWJXXFnASMCJeb35WS0GrMQAIXLq/9BhP4a?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k7/bA6+HGC8RO2GNZVYnilcW0x855neovXdJzIRV8HesIBJEDPeGGonxV3/CyQ1Y4P5OBu5Sit6ypN1PAelEoLP2RXSXPnpNSbERvkcdDE/GMOoKajBNNmnWvYCTmpPVRoDFHZm1s1AhGyfZgHXkhR70JMDyVlowktJ6q0UgCdpbPvi2bz5mmatg233bUz5md7eUM6wxFTrBCSIzHNtJ4DVT88od/En7t89Sg+K/UB/tHuUBQIuEtM19ZcLH+ybTtGuk8JaZPUXOckajZVWFV5y4DDCiSruFUDHMDgtczPgwLhkMk11RVHvS6NtHZvo4cXpnFgHl8EKuV388d3P8wWpkIuPf+9zpD+WvRa+v4MIdromb1TbDWM4pqLadX8s+Injr/oOhsIWSwfPLrBrtw+WdJ+iH2p9YNVi5J54w7FliGcJYm3qHmISjFFiz9dh/Teovnja/JT6bEpbTedAkKsf5jLPKkuydUgDZ2nMzKXnh6z2YWR9/Dsjhh0J8CwzLkGgsKOzAMqGDf/JKtaHcKw5+A8Jvu1P2gjGlQ37Az9fE0P7ZTLKg4wIk8tgH6vtujuOFl2GDB+r9NFobf5gz4omZYyF2ynOWbWg6jE2qocw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c67ae9-d035-443b-08a7-08dd5725524a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 11:53:16.4052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IXHiA2u/LXx44djVsvODVL0g1AasJnnDX0C0e0Xq4EyzpT/j7E98wiHM6xyDKFhY/TTqkGkpxkqPykiVKeM+Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5067
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_05,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502270090
X-Proofpoint-ORIG-GUID: 5Ww7G-fafHcxjZl7a4kr1nBBXGPrCU0O
X-Proofpoint-GUID: 5Ww7G-fafHcxjZl7a4kr1nBBXGPrCU0O

On Wed, Feb 26, 2025 at 05:11:59PM +0900, Hyesoo Yu wrote:
> Dear Maintainer,
> 
> The purpose is to improve the debugging capabilities of the slub allocator
> when a error occurs. The following improvements have been made:
> 
>  - Added WARN() calls at specific locations (slab_err, object_err) to detect
> errors effectively and to generate a crash dump if panic_on_warn is enabled.
> 
>  - Additionally, the error printing location in check_object has been adjusted to
> display the broken data before the restoration process. This improvement
> allows for a better understanding of how the data was corrupted.
> 
> This series combines two patches that were discussed seperately in the links below.
> https://urldefense.com/v3/__https://lore.kernel.org/linux-mm/20250120082908.4162780-1-hyesoo.yu@samsung.com/__;!!ACWV5N9M2RV99hQ!JpvsczvJJcu4xw6xseDcLQJyiNXgZmwubb5cXEfORBj3VslI2ZTgmipoW7pdQ6qTldrr0mnk2l99xw3nio0$ 
> https://urldefense.com/v3/__https://lore.kernel.org/linux-mm/20250120083023.4162932-1-hyesoo.yu@samsung.com/__;!!ACWV5N9M2RV99hQ!JpvsczvJJcu4xw6xseDcLQJyiNXgZmwubb5cXEfORBj3VslI2ZTgmipoW7pdQ6qTldrr0mnk2l99Cdp4khE$ 

IMHO it will be helpful if the cover letter includes error reporting output 
before and after this patch series.
-- 
Cheers,
Harry

> Thanks you.
> 
> version 2 changes
>  - Replaced direct calling of BUG_ON with the use of WARN() to trigger a panic.
>  - Modified the code to print the broken data only once before the restore.
> 
> version 3 changes
>  - Moved WARN() from slab_fix to slab_err and object to call WARN on all error
>  reporting paths.
>  - Changed the parameter type of check_bytes_and_report.
> 
> version 4 changes
>  - Modified the print format to include specific error names.
>  - Removed the redundant warning by removing WARN() in kmem_cache_destroy
> 
> Hyesoo Yu (2):
>   mm: slub: Print the broken data before restoring slub.
>   mm: slub: call WARN() when the slab detect an error
> 
>  mm/slab_common.c |  3 ---
>  mm/slub.c        | 63 +++++++++++++++++++++++++-----------------------
>  2 files changed, 33 insertions(+), 33 deletions(-)
> 
> -- 
> 2.28.0


