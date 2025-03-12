Return-Path: <linux-kernel+bounces-557247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2064FA5D5B5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 06:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5805B1797A1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 05:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7A11E1A08;
	Wed, 12 Mar 2025 05:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P8tgcLBS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gS9rHmwL"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E431208A7
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 05:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741758450; cv=fail; b=jcgIt5Uq0xCSre6ZLd2n2vEf0OPw3dqOKLjtYG9XHmhIOMsEF+tbsu8tXLTmP8yQNi8qxGCAzp55vmHFdzfmIMa71B3a6/qhN/bEkFtx+2ncNe6+lvgfpkPsSO4qXAutsESOMcthRo0ikENLjDYQuv8cfCvWEZ0yQ+b1J0/c/68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741758450; c=relaxed/simple;
	bh=Nt71i+EiNJcyO3H/Ij2P+AbVDyP0Turvy1TZu6m4lWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jkYkzcAQgq2SiPg6WDQ5PMFK4QciaC+8LH2NFWMGfYcoANcYgJoLPuKaYyU54ufxUa0wjlMx0KFGCbJcH2dUD8RDEeHKarCf7gAEt9QR/Vc12yKr841L+CnYs92kTVicZoAUdW+VAuJvRrz0IAY1yz/Lc+Kt8pntDpy/rFhagOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P8tgcLBS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gS9rHmwL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52C1fxaU025269;
	Wed, 12 Mar 2025 05:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=DZg3vO6FUVsMsZDyju
	bU+4IWraCpa17vfQU2cX2ZCN0=; b=P8tgcLBSoTT6oCBZfRz2WhJQ0feza794xD
	o6uin9j3qpYgqyOVyG2IRUBhWngDGShliFXQB2zjBJqr0bcwSfU8EcCeA9KhPhzj
	tw6sMtp8xs19lmBPWjh0Q+Mi0IiYam2A5qbi1/9lUoAMe7R8PyV+NfqhaAU2HGe5
	u4Zj9sU+xqK9RrDyyRqJEUm1YcHKpc8kfYzrfuU3Z1EruUoklMeNHJEarB1MMC7/
	HSSgp1V618/h7uc9sY1VHrQrU4gz+aRRy4WH2T326P0AVoo7BH5yRZsYP612Zpsl
	ZEiZE+G6K0UbksT09Ig4ec9JRq6nFamrdWEDRaAENIyrPXOnq4mQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4drv5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 05:47:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52C4OpnI008673;
	Wed, 12 Mar 2025 05:47:09 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45atn2t8bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 05:47:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ryaxZ0TsP37aRb9xPwFaBPaiy1N/ghQdGllynkUFBAFfDZP8Kv0fZWR2lPh/PKQ1HcwkPAb/mML7l4TvRmJ+jJLwQfJsK0Hr55osHFmNTN2LcLhuOeNyyu7WyfWHTjwl0Z42mHuCdFO8A86MtdSbZl0/0hGgUNyK5+M/nY7RbvhRyg90OYAUOO88H26sj8VScRKkCXQCcE0558XBQnwiYM6yRrY1/+YVYTE3HH1f1SXbyKpG10YJPHh+j4oNLzz3C0zdz/X4+LO0oXgHGzd9DSnD2vzCNEa4oNsi+n146+f9kaT/Rzv1tWCo3H0XmYzyMnOk2DjwJIV/HaaW1S6pAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZg3vO6FUVsMsZDyjubU+4IWraCpa17vfQU2cX2ZCN0=;
 b=Fjf0uoTV7iDhsWSwxOi9xaonqI177uueKMqomt3u8uaZjJv2+3r5jYcV7UeypcOZvcdbvcyA8Vy5jFb8snuh+doe4SG6hTozkEa8F6G/giWIzRZ2PufCWvN0hpj1Ha1gjdBhuiNbF4pZj70IbIueKwEH2sizBZhvYWDGeLT2O68rRJUgTk5InWORMYqvubLbX+7UaNBylNxR9MpEeKehis5GAyJihwTXwOtACagWdzy1g3m8BTC1HrHLPb3e4+kdAQI1XwzmTUz9O0p4AHhrBPHiyZRxWpiLx6cZXufv1pXP/53XH4t+V7cocQ7eNMFcM2LGVNqF6ujB5QeX8th2LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZg3vO6FUVsMsZDyjubU+4IWraCpa17vfQU2cX2ZCN0=;
 b=gS9rHmwLY9hvEsLrVGcXSAIhi2JsEi4btTw3qdi18xguZbLBp8zwj5S4jMWfowOprXEr/zMI2YgvJiD4qKRd2eZZ5ZJorqGHgFL9cRe8Gz9eIxze4VqDXDZXAVnol3FmVNKIlDkh92lfwHjs8qkLzlqGNZr6rIJox89Gmv/7kHc=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by SN4PR10MB5591.namprd10.prod.outlook.com (2603:10b6:806:206::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 05:47:07 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Wed, 12 Mar 2025
 05:47:07 +0000
Date: Wed, 12 Mar 2025 05:47:02 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <howlett@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 5/9] mm/madvise: define and use madvise_behavior struct
 for madvise_do_behavior()
Message-ID: <2a2eb9de-c8d5-4be0-afec-2efd334dbab9@lucifer.local>
References: <cb48d187-6fa5-41f5-9fc9-3f424f105785@lucifer.local>
 <20250311205617.85289-1-sj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311205617.85289-1-sj@kernel.org>
X-ClientProxiedBy: LO4P123CA0240.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::11) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|SN4PR10MB5591:EE_
X-MS-Office365-Filtering-Correlation-Id: a03830cb-8697-4307-76eb-08dd612952ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JncKrISxjWy7r3FykYOocFTzHCgqE/LCEHGawTmnzvssswxMJqcXkLIwBoWH?=
 =?us-ascii?Q?JNVpMpxSz+9n3h6HNuhiVmWiHW6SBjG4EvNmpXjNtNGNVRom6pTNqquMyRAU?=
 =?us-ascii?Q?tZWI0ozR2ESp42D9WUztU5x5v5Y/j38acHklK4BWwZ+J5kRc+MjY0Sp+YOda?=
 =?us-ascii?Q?O6Untk5w0/gjAibTqO/hz4ubL8gJbcKaRKNFXrMtYUFgKPdRvnFM7ZHkxQT7?=
 =?us-ascii?Q?B7Kx+4IcS+Y2bDt0ZfmzjmQUqzofGH5suJfYiGCkDOQUHQcBPMzUyRrC1D2X?=
 =?us-ascii?Q?Y04ukv44eQ575jUsjAI1BRwbCZnQFXO4rDqOe5dbXshP4sQbFdXbmIg8ixvJ?=
 =?us-ascii?Q?nzxhQbcB4juJqlFmj5vRuh0PoTM8tFL3BroQeND9mo/Vjj3o3REPmtr3eqm+?=
 =?us-ascii?Q?JNtPHSQfqTGvAMhNrCbowz7Lof7Awo8TsexYY33A0f+pqQBaKtcWSdDqrAfo?=
 =?us-ascii?Q?/wLvEHpnRll5fivRpXDFyS2mpIzYrZ4Nab48kADtRJ/lqRmNMyXs2J6ZC/np?=
 =?us-ascii?Q?N/4Q6kbrCToqoz4qYCyFG5iM2kKGEqxtf6y5pf8VxNH9TciQl6oWx5YsySjK?=
 =?us-ascii?Q?b4nltkYUwhH8AkKODlyCD+mVurdhO1Xi4ASLzfyoNMJ1rwriwITxfjpUNYyZ?=
 =?us-ascii?Q?sGm0YMz44bzX6UaOnl+qKv2DdHoo/4lThsnNVkJNzZKkejLbm0bxVmRMLV0i?=
 =?us-ascii?Q?C+hgUJetNTVNpvPi/N/vPuSk6x2WwYuKUsxc7B9txTmkzL6Gp8PTFmYousNX?=
 =?us-ascii?Q?pHerxtbWtSagNVIu+RAjuqLk8VQhQnpzjgH2yoqTK1J7PAxeYhHS4E1zOxvO?=
 =?us-ascii?Q?qDOQ3CK6vRaRcGpPiZqXh4Z+mFUw37xQaGltH+eTnWR3e9FGIml2dMTIuqZD?=
 =?us-ascii?Q?DhHqysZiTcE92Zoa9bZhzUuFCbV36Exg8xYmHuiISb65iyVI9XOU1M75PmH4?=
 =?us-ascii?Q?Y7WTvi+azR/eRcjypUY05NK/qLyVEB1xZdnTq/885KbphIjRWHNHakE1PrYZ?=
 =?us-ascii?Q?4EpLC3oSDYJkvehkIRXLi7gHyXpJSrtbeoo9lA7oflUxTYpaeRZZN57fVRgE?=
 =?us-ascii?Q?JNoEKZE1ms6SpYUS1gkrIAEYlnUoTesaebpdMqUZvxWpp+HElv49pGks35tD?=
 =?us-ascii?Q?2qpqoTTGtnI9YUfBjdLtijBoUfjJJi0CtOR3MLf/g0XbV/tlKp068IBdGG21?=
 =?us-ascii?Q?Y/Jk70XQ+8tLqNTt8aCSqP/v1u5GUOXDBqtzFEAvlXZ1VbwSWavI5R6BILF4?=
 =?us-ascii?Q?JRwRHQuZ65oGxr2WKetH2U17fi+zb9h6eqwB4bAIRf35k50+fm/OZXLH5Kih?=
 =?us-ascii?Q?gPBWdyEntFuosCIQIaTeBYU9NydoKeri/KxekQWbAE54VKVMH/g6GFKmLFL/?=
 =?us-ascii?Q?Oqn+7f7Uphk3fUJC9hLGIRq57tB7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/wwQmOkL12ZO4nlYwYzBIY01dudJV6bIS8h9IkjeuR6nwyUGYHyLd8lKlolQ?=
 =?us-ascii?Q?7PvG1hWPOd1BLqQmgyA4B0m6LQF1UEAdrka8j0HbjPWGM44Whkc80b1c8538?=
 =?us-ascii?Q?7lFOSN3zdX94olnQlWzGS1slXRQwVa+9V/I5W/t7NZDgksRV3WC/eidhrU9r?=
 =?us-ascii?Q?+vYqoB0bwLBPzYXUfaofB9SH1gic83yie57r4+LQjdssd0J81IAg51eVgVtv?=
 =?us-ascii?Q?tJKEnwVEUtmgzuZkITQKfgT8EmAS6eDiSboHGH+DW0RG+ocxN2XMPPqO5ONo?=
 =?us-ascii?Q?cp3H44bdPS5ivFLsytnzheXGGsKN9U63kIStnD8uR0cGmT+h0dcmXuF6Ml0v?=
 =?us-ascii?Q?qqTbVPul2owyBm8lKFqk5E2ds5A/FDi5ECW6cFQKcOGMLozu8VlGoERIPle4?=
 =?us-ascii?Q?SRVMyx5GvtCwBHtkKVjhCHJK6Uwx3EHciv3kJ4k25ZkBt/JMPCMKAw4n+DDl?=
 =?us-ascii?Q?oZLHd9fmAM51faxoHCDJdek32PFyZXsyGRBhj8XbVOO0Bkz1SgTjITmrcXHV?=
 =?us-ascii?Q?8B6B4bHC0wQaUm/qLWk9nAFLjCrgyTIefqXPZT83siS7QzbqjbWGhezq8xKW?=
 =?us-ascii?Q?stZ0r20iyl0msbntWGLpHK9dYzAFJlGULIkPy80vdPGv6w8RTNyDL0ve6UBQ?=
 =?us-ascii?Q?mkU1ov4FMFT4wTuUdFRMh6bHJ+RXFeyF9/ri//WKRjbRxswIn9ze62PrGKy9?=
 =?us-ascii?Q?vQjXKo+9zF5/2OC9/UwtP553Y9UBT7BztoiRkHaV0Z4596o9mwifpHn+K3W0?=
 =?us-ascii?Q?6thPx86tyefqVLQxgtsyT5Qy9xbHzrXB6aAD0Yem7+YTI3cqH/IuO/rmYvzv?=
 =?us-ascii?Q?/SSuCIp/5rPQK/rxpjy+130e9vhTxHQacwQPXx73TqzmD/OR690yFO4HXNKi?=
 =?us-ascii?Q?DZGNIJNGW65p2dO3ABW1BzSjzc3PZMX9ADHNV5hAqTpPuHtpjRYJsVxozGGK?=
 =?us-ascii?Q?9hNSPDzvOxmQyI1n/vD4GMv4ZnVXpPN8/xvU5OhKS4A1GfpvaNrW5TsztWyL?=
 =?us-ascii?Q?Vc+gody6onLpX+J7h6maIuszWbYg7OR7kTbolzoEz3iY1PwYHdW26ZuqVDAs?=
 =?us-ascii?Q?dinDVWGW2sdDES/AzvdeTTqAWsy2UlpDC++oSJmdqo7ViQj5mjrlDnK5HlmE?=
 =?us-ascii?Q?cy7GPNOLei9cqgP50nebFo47/f7hUcTHabbt6XE6pVG1rzJZHZlSAI3ff8Aa?=
 =?us-ascii?Q?1TFIFAENyUuWyaL7nlyzU6CIt2V27c6kBNrt95PXD1seqCnHUYQfsr7HYmXH?=
 =?us-ascii?Q?TQtb+43qBZDHob7y/wTgto5EtwNz2bMJZ1In24pcX+4+WX+OIZX7BXDSYx7t?=
 =?us-ascii?Q?5MxzHAFSnrOrsMa20MAG05z5Kif8xHUSqaJj0Z0KhzP51AQ5YVcZ+PILEPia?=
 =?us-ascii?Q?CtVDFvAvsmIhojryyyQ/SqXVZtm2rWQ0QIHepsN9UpvZg5pTrBSzXqyfmK9g?=
 =?us-ascii?Q?2NjqmHp+LEwQoUM1dFz1y2TAq/iehD6ffF123NaMln0GLEYrConVYbn/rb+E?=
 =?us-ascii?Q?1Tu7RxfhBxsVS/7Mxwyn7jWlCH6DYtVctibpjfk+6X7auyhoaZ47rRDZ8Hhh?=
 =?us-ascii?Q?fj4JG8c+CM7ANy3glIpMhnCXFTvfzjPLEOwOggCm0F7qEC5CRVslXpUqx1vX?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2AMPpqsxNBIOf+RBP+P1EMERq3VvJEEKsvbospjI32AGT1b9OtkA43umfsZvR4ylPt0dRjh7COwHklBeGcOIL5FL0Zc+K177E6S+SmMH7KrBnRdwP9x2DFWwI6dpR7Sl2UjCNIqJmW68JlcPO/FNEmoBwhfukMSn5DDCIKWxQ056tgwPETETNU+y5ktSVZWf1nOFKm8WfpAgAewbKX/Zo2dyIUi+K1txeGRxw/Xf4LVJel+kon/IG+u7VtDbf0/5cfODalcD0JRWdwucWuEekvE1k0OFw8wqWVtJ8Tk/zULALYYl4rP/uaaEUW+Z2FlHxa0HVOQaxjV0Y6olGLIffHSOuN/X/AqXefOTspNQdt8bS6Gi3oi1+1edfcHs7Pga/pZPQKQXO58Xh4uiM5XCFaYVVLoX2mtoBFzINL2rl7RyNf6mX8IZSbo6sRJgm2IGDEjUSAp/5LyvjQGdJPqXuSsPfvNxORh+KX/KfJr4Fyy4GASeAg6GlhM320/kCLvePENJcJXkQCTyta2FcfKXl6EGsUV/pbiV14dD+cnj5zs1URILKPurcNCxvBUszFlihHiJYyjLjpkkMITTpsL0rAXKRvBb+bQ7Dgg9DGn92Qg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a03830cb-8697-4307-76eb-08dd612952ea
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 05:47:07.2117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eP/aSz7PCe+FBHoxzb+a/flWTH4TE5xr4HzUoLEddqLoShjMF9APxV/mLVM1pLXle9O5b+g4qm07CNnqckjysKeyq0Q2JwWmWOKHoz3Mg/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5591
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_02,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503120038
X-Proofpoint-GUID: R9eRkxAAq5G81P_CiTXmVEvRl20SlvTt
X-Proofpoint-ORIG-GUID: R9eRkxAAq5G81P_CiTXmVEvRl20SlvTt

On Tue, Mar 11, 2025 at 01:56:17PM -0700, SeongJae Park wrote:
> On Tue, 11 Mar 2025 12:17:40 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > On Mon, Mar 10, 2025 at 10:23:14AM -0700, SeongJae Park wrote:
> > > To implement batched tlb flushes for MADV_DONTNEED[_LOCKED] and
> > > MADV_FREE, an mmu_gather object in addition to the behavior integer need
> > > to be passed to the internal logics.  Using a struct can make it easy
> > > without increasing the number of parameters of all code paths towards
> > > the internal logic.  Define a struct for the purpose and use it on the
> > > code path that starts from madvise_do_behavior() and ends on
> > > madvise_dontneed_free().
> >
> > Oh a helper struct! I like these!
> >
> > Nitty but...
> >
> > I wonder if we should just add the the mmu_gather field immediately even if
> > it isn't used yet?
>
> I will do so in the next spin.
>
> >
> > Also I feel like this patch and 6 should be swapped around, as you are
> > laying the groundwork here for patch 7 but then doing something unrelated
> > in 6, unless I'm missing something.
>
> I actually introduced patch 6 before this one initially.  But I started
> thinking this patch could help not only tlb flushes batching but potential
> future madvise behavior extensions, and ended up chaging the order in current
> way.  I have no strong opinion and your suggestion also sounds nice to me.  I
> will swap those in the next version unless someone makes voice.
>
> >
> > Also maybe add a bit in commit msg about changing the madvise_walk_vmas()
> > visitor type signature
>
> I will do so, in the next version.
>
> > (I wonder if that'd be better as a typedef tbh?)
>
> Something like below?
>
>     typedef void *madvise_walk_arg;
>
> I think that could make the code easier to read.  But I feel the void pointer
> is also not very bad for the current simple static functions use case, so I'd
> like keep this as is if you don't mind.
>
> Please let me know if I'm missing your point.

No to be clear I meant the:

int (*visit)(struct vm_area_struct *vma,
				   struct vm_area_struct **prev, unsigned long start,
				   unsigned long end, unsigned long arg)

Function pointer.

But this is not a big deal and let's leave it as-is for now, we can address
this later potentially! :)

>
> >
> > However, this change looks fine aside from nits (and you know, helper
> > struct and I'm sold obviously ;) so:
> >
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Thank you! :)
>
> >
> > >
> > > Signed-off-by: SeongJae Park <sj@kernel.org>
> > > ---
> > >  mm/madvise.c | 36 ++++++++++++++++++++++++------------
> > >  1 file changed, 24 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/mm/madvise.c b/mm/madvise.c
> > > index 469c25690a0e..ba2a78795207 100644
> > > --- a/mm/madvise.c
> > > +++ b/mm/madvise.c
> > > @@ -890,11 +890,16 @@ static bool madvise_dontneed_free_valid_vma(struct vm_area_struct *vma,
> > >  	return true;
> > >  }
> > >
> > > +struct madvise_behavior {
> > > +	int behavior;
> > > +};
> > > +
> > >  static long madvise_dontneed_free(struct vm_area_struct *vma,
> > >  				  struct vm_area_struct **prev,
> > >  				  unsigned long start, unsigned long end,
> > > -				  int behavior)
> > > +				  struct madvise_behavior *madv_behavior)
> >
> > Nitty, but not sure about the need for 'madv_' here. I think keeping this as
> > 'behavior' is fine, as the type is very clear.
>
> Agreed.  I wanted to reduce the name conflict causing diff lines, but I think
> your suggestion is the right thing to do for long term.
>
>
> Thanks,
> SJ
>
> [...]

Thanks for being so flexible on the feedback! Appreciated :>)

