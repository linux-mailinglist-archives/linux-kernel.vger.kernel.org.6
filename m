Return-Path: <linux-kernel+bounces-378623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 769D49AD356
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3305028386C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F801CFEB1;
	Wed, 23 Oct 2024 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AVzIKo9R";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UYjYPMI7"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5A215EFA0
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 17:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729705954; cv=fail; b=UhKLhNRqqeWTXmrzswRZ+etv1jWjxmOWhYiNesMdneYlebmuwdBswWyFaDIfQ5LOG/JQaY03X8+akNZik4y7G8FG30wEtNxG63ICiKEPN0ahunuShuZbaNsRXndUxFHh/UwqAeoxKrVU7WNp0EV7bmjYNnZtunL5S9CZyMfFawc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729705954; c=relaxed/simple;
	bh=SFZRLlXVWjnjK7liRaiBIrXRzAMZolVokeAunIJLvv8=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZwVukvPsraRuak5UWeZeT0znpGNKXcI2y/EFXpyEWXtQE589yTi+hPYMJ0oED+UaMldab3wD29ozsz0ASKcuvUZANF2qC6dItM1v8jo2LbSOMVC0spBQd7g8e52IPimgIQQFPpcBmvBmqt46p3Dm5F9JnUtT1T7CUZb6dWu7t10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AVzIKo9R; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UYjYPMI7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfbHc031352;
	Wed, 23 Oct 2024 17:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=U3/aom9aegueUrFCd0
	OXUB1vEweSb00GX4z0HpXDg9o=; b=AVzIKo9RpJoC5iE+589LSjxOyTXiduVmD9
	SognblJJKBjQMtM0hIys7d9yo98Ycx1jX82WVTPn3Z+HNX4zxKChauPiG+9Tn+Rj
	cTW+/5St8lUG7RjFSsmyN111W0zgjuy3kbiokpHXC+m3Kyf/lnW911Bgza9Lduq+
	spSFxoXSfTrSW9QyZbo3wB4qQIEjSfzPYvSlxBqVGxn2TlWSJqWpSYySDLbEk4yZ
	g+MXkYfTbeCDHENjicOhUTEo6XUIPX4MyzGqafFw8x8s1tEXz1/ZQUzj+cGe8k7+
	YDe4/BnDtUtx7pDpWOLUyar8OB7CPw7UK0mJUtgAIFXVs/O06cFQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkr02yt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 17:52:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NGEpex031028;
	Wed, 23 Oct 2024 17:52:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh1uhrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 17:52:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MeSed4RcLAClt4dDXwN3ipHjEV57Vuekx59Tze1wAKZnoWLuJDrr6hBH4pgXEMxWKlr7U6bh4/c/zEh/OlyNmijkaBwZs+izhjhBTrotVbRbJ9tDXPbNk3blo3ODmdniMSTUui1bnp5XSxuub2O4F9Umy2c14ZSyjiunY3kMXmcMUdm2nYDEkPUFAqoC/jVVGi8QFZnSoj1ig/q2UOX2F2C3RKvOC7LauU64A+ELY9QJVM5xvl9wyIsz+7G0cvQ2xzy054XZYz0dbAmkVFR3vcdznslDjCl4cWnugRpaOVDWlG7hBGKFxCZffIXTK0j691COkCYZFjCVhrdJHLBJWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3/aom9aegueUrFCd0OXUB1vEweSb00GX4z0HpXDg9o=;
 b=YadsHy9U/KhqF/xf+LaRlxgPtUCLyWsM80vmwkuK7bZwtmf3Tmm5/354C4ZX3njpn0GMgjL6loDroJSc0IqsTgGdLu2caddHcJ1+6BB2zzU8y4jwmkWGBICI85ISUYQy5MehyOXPByquhv9vlV6B4kZCcJIZ6nwjDap4SWq4wOTz3DfbjRERgdgRLwQkqs6kbmGnvOfeS4RURAOxA3zSmr3CzBuxk17r+ZpAqhATmyoFdFNQzrsgs3v9FZWNkScdwK5qMA4lA3AOecZRM9fwJ7hRasBC/Apeq0bbLYH8kvm399Fj9/QlFP/DpkIj0FUVE66SxgHn9rzleh1APy4HLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3/aom9aegueUrFCd0OXUB1vEweSb00GX4z0HpXDg9o=;
 b=UYjYPMI74Ibn/PREMkT3BRcv1LbCN4v77jF3iPn7r3AbXXa8aAMAPwu/b62UcggGGyZ5WiIuoGPOaY1qHE3gF+TiLPUDl0euqSrJZc+5yw4Fy6OYozf/5YH+56DyNFOEvFQfjm8xe47KOItgfdG2ThCWmBTlEf/ndxCD0VfiClU=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH7PR10MB7731.namprd10.prod.outlook.com (2603:10b6:510:30c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 23 Oct
 2024 17:52:10 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 17:52:10 +0000
Date: Wed, 23 Oct 2024 18:52:06 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH hotfix 6.12 7/8] mm: refactor __mmap_region()
Message-ID: <9d9b143b-8b1a-43c8-9290-31255defe828@lucifer.local>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
 <125b6ebddc7ae8790b8b10b47906c2d39e68f3d9.1729628198.git.lorenzo.stoakes@oracle.com>
 <zbv5u5rqlny4l77n2be4eyh32nkojjbnyy6j5ve4uv2x7pynqp@v33tjz73yeyf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zbv5u5rqlny4l77n2be4eyh32nkojjbnyy6j5ve4uv2x7pynqp@v33tjz73yeyf>
X-ClientProxiedBy: LO4P123CA0590.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::6) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH7PR10MB7731:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b9afa65-5f79-4666-85e3-08dcf38b6b19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M0pVGGwbfJqvHnYecUhe7XyPIH6btQh+6qWJnWacYoh9XFQocq2QQhgF/6Y8?=
 =?us-ascii?Q?h107WOMk4QDCEqBC9UM6w8HmuanD3ha3EPGgQ7INJb0BPv4hJL9JuiI0du3I?=
 =?us-ascii?Q?rXV18wig6fa/k4MWdDa/qexFwYVmYBW2sqvq0SjSW6HIdm47IyFQfhfX1JfS?=
 =?us-ascii?Q?LicWFIB4PSIDRm2H2QrNWKfPU7Ed3b9rXTH8OPPlbeW96/WtnqS9s4Ltdbgp?=
 =?us-ascii?Q?z+zUIdnvQhKJB6PHZsn0UiSH/NEyTMOXhyAEVrk1/p75TTjungrSk72rn9zN?=
 =?us-ascii?Q?TEuazH+80PhZjStQup+knuaH9tkR/s4gqGxzKdxdfJRqQBsEGqK827BXL/6m?=
 =?us-ascii?Q?CmjFuJvINTXvNPERP9BMTsYJBZI4vjINNYo3ZjplF00Gj6Eda3ArbKMekwIT?=
 =?us-ascii?Q?PpLkRkQfCdw6qJYCFfZNpvKyNqlOWvQkrnljZWlIVDT8aojot++a2Ie5tlAR?=
 =?us-ascii?Q?qrSb0JBBiLvVAcXRl3J+oQFuiZ0XKG8olBzfjkoiw4aH7Xuy1inykCj+zEP6?=
 =?us-ascii?Q?MQws7NaGzVarckM+gVav+ViFhYUbapuAqTHrGKW3h+SlJ/bDGdVAeP4jTToQ?=
 =?us-ascii?Q?DZ48L9ABF1tmVSzn3g774sDz+NY1O2SiZRwrjTqDCTNyzPFMEfcjy9rQ8YAc?=
 =?us-ascii?Q?dGoZ+WAzmI2aObenTWmaAzCwGQ7zuEG4QoLZU3QspbaPV+ueYb3xcgGift0C?=
 =?us-ascii?Q?QMfIGDjsUGorwPhUX+A6uLEWp6kP8SBeAgwZa5+AHH50YuB+La2RD3J39fuK?=
 =?us-ascii?Q?NiUWqS8WXi/MBTvrJCAV3k1wVM3jD7xcc7eVDsXd1QtDsfY/aaFZDSpvlMRc?=
 =?us-ascii?Q?7Z+ZmU2j2ZAACADwbBX+6mTLh6pr3H4elYIp4XV44Y48SZJViMT6WH3UFORE?=
 =?us-ascii?Q?QGCpdnrlZuswn0jL6OydH1xONdrzzzayXOKDmjKtmSdsCPmRylc2C8dak17x?=
 =?us-ascii?Q?YmXRAV4kAtCcsTDTQ33EW/dftjEGHEztErUdmEDwJO9qVWjQn8l6Qefm5myK?=
 =?us-ascii?Q?UV2Z6Y6sp+3BzafwpsjeBiRfD3KDSUXWRiG6wRXxAR40Wn6EWqyQCTWYKIKW?=
 =?us-ascii?Q?fH0nLbgIKTuN0ou1nR6jEPgyKJKlKLBN3mlrJdXAZmPQY+fIQ4q7MxylwZT2?=
 =?us-ascii?Q?w2hdpUzpuL5rI59ORbKtM1pOtxxZe8iFoBUQvGU8MD8KUEk80Ci6A8IZsDO7?=
 =?us-ascii?Q?B/8Q/jNFT2b8OMBToLNWcIygquVcGvg/2oIndYGP2gjinnL0aolaoRQWLAqO?=
 =?us-ascii?Q?NfM3C9Nhfe4gb8Esyw6ISdlVf4u9Nj5EFT0i4T4r2kHzF2Ev7EVDdlJ3NP1L?=
 =?us-ascii?Q?h02VwtSvCA4nRCU7+CV6b9Io?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QFkHBTaAjSw2eKGnk5VA/bc1XYWeJio023dDn9T61Yt3NnAGqjtV3g0H/FNQ?=
 =?us-ascii?Q?l/JhbjSqfL7eejOgM01shrlyCOe+H+p2sPkUrAdgHhlszcmb+hnIwA/o6GZj?=
 =?us-ascii?Q?Os0bC4Jcz+5l16ewjsWoPDkoKsaZW9qaIRdrBr/8r0oOpudSP2nf6eAhx/YR?=
 =?us-ascii?Q?ksoXWlIzHdQsua/0d/q4jYgnvtIEnL4moU/A4Y3Ar76bJGXbekFq46ZD2Eq/?=
 =?us-ascii?Q?K/9xwi5i/BodBrgLlZuV4MXwy4vRm06o/Vd7KrW2UrVbl2oCrx6JVMxMxoqh?=
 =?us-ascii?Q?hJFld/2iGYXEpcYuhOomGzdxiolmxSKnfmJwHitRe/FPbUULNZrCanmxrefR?=
 =?us-ascii?Q?s6CI5l1s6PEcz5O8Jd9d0XA1UyvtdAGGAQq5JuzoR+ZOiBcePNrLE1rIcCnk?=
 =?us-ascii?Q?LRSAsDB/YZWNc0zfaOjmZdVuN+r1WrhzOp7hkGtMfJw/ikYJ2DXghnMxmMxv?=
 =?us-ascii?Q?D56nG/1oboIuzIMH9q4RCuA4R/m2GDLRfwGe6aJiqUpv0gONjYNUctmJM4ER?=
 =?us-ascii?Q?DYtXL9+Sx0JdmHo+dTNZbGFPV6NQ8ldrx+WSJzJIPL6L4cvZHczrti3tr1Vr?=
 =?us-ascii?Q?383brzzD+znCUwdYwATLklehcC7RvfGIkIP5N1mxiHEVpgtJWwALd69T08Tr?=
 =?us-ascii?Q?FTcb+E2c+jMYK9Qn9rhdOUsW0SEGI5lbB1SEQzaJK0kATffb+gf36XGmrwAQ?=
 =?us-ascii?Q?dplsjKRGwE7ZtC+m7sxlWyg84rr7jJeq+7hwCMFokidxvyE+R0nOq6PEkRYT?=
 =?us-ascii?Q?ouq2whSOGp1oPgNEAytQoFWvbRJ5Wi1oujtIbtmtJ/yOP2pGwsQu4ecM3Pne?=
 =?us-ascii?Q?N7V6nGUwyxaZhtIPGW39yYTQYPZ2PIJWTqkmXnfnFCD+hihhvXz6BUCH0sC1?=
 =?us-ascii?Q?NnvjC8ujxCVzQOJR8Jz1WYprxuhe1bYd6ZXH5GB3dedD2yOjnzI8IzQUMTYF?=
 =?us-ascii?Q?aoU32ngTkYSdhMbk4d7b59Gx2SXAuu50me/jkSg4sduw0vfXH2zisCQS75eU?=
 =?us-ascii?Q?laouW9JRDkfPZp3RBWTT0cEm8xOB/fiQ69cvHKMJGoz27pUNc0VBpvtzoOL6?=
 =?us-ascii?Q?SlsWsBXI+tSIvbqG3FQbR61JK01gOZe2vrPhV9htVkJX8Gxxvd8cbh3iHR8X?=
 =?us-ascii?Q?PKeYfzjyU08+fKuozy95Wyg7n7pKiw+ejaql9CKf4a0/uS9kzExM+3+VqpD4?=
 =?us-ascii?Q?6W8FjJCyjUncTJJMaNFEXMTMDRRPPzUemXtjequCn10G2Qst4LjucwWv3itJ?=
 =?us-ascii?Q?KjM1iwXuGGcbx53GkN0AvKlHtaeAyDArrET8Rq5sFuhxX4xHk7dl2xmthgaW?=
 =?us-ascii?Q?Rufkn11swlIesv3C69GEHrBANVwjQ1qiCK2R/1xFt3Ie3/NggrYesdSNVViS?=
 =?us-ascii?Q?aNU8uhuIp6tvmPk+ygVIKUK1dYxFmwYikZqlplr9RqtXJpfbafX6232XKXl7?=
 =?us-ascii?Q?n2YkHdQKhIWxaGsD9DFdimOm9sugnVH2Y/ZeQ/dGpAKW4xEfRQzwhEc8B8an?=
 =?us-ascii?Q?6q86KztlajrS24XS4KnLb/mRCArPyFW5wqffpvxQqUiVjRa+Usu/zcz9eU9P?=
 =?us-ascii?Q?yDuq07X35kW+yCdPNwzdX3Fqp1R6/XvT4JqFrmtUCSMPRPNW6NnvhB4E6nIS?=
 =?us-ascii?Q?PipE10SfpATYWaOgRaroIXGd6r3LE2LDdR2S+X2XzCTJZV6mJTMa4BwekE8N?=
 =?us-ascii?Q?4Fl7Dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a/j6fmr7cimX1N3yrK5EeTC4sJixF3K1/bbzD/uuCfHNXOA+j77NK89slXuJKMlT5jSLUglz0AfbDvls8/gYVpBsqluptE5h2f0pXH3XUcU2gK5qEko1/jr2qyg/+st0TVFeCGFFO+SG92Rzm3JX+r0rDereQ4+chstVzpD4FthR5hpmFZL2SnbRSHhG9uw14cXna9N9xCTMH6KuNkW1dnZN5FSc61w4igRppXVomrs9RTOl+DiQ2f7jmCSsSgfxi6b1Msn5ehyVlon59ziZOARQUiMB5RxLHfFlmHE8M/8xVbz8wyRM4C1G61NrKVD74jAJHJ/6dHLYRj7BKkcK3dEdHdlSz1MiuRaYbg8/frBkjYvDT+4aWkNsO8GA8+g5Itq+fJujBUAD4vVFphFut6JpTs1MBVXlvwHVe164d4f6MOffoAYEWNCXbeKDyLdNyyedwcZ4eU5BWwDocQFQEe6wyFsVrRppdZSWSLuVWLrJHU0wyCiq1KNpVmyVJPjY/9/Q/k6SefYGoL13a/5HgA4fPgcwrcYG8EkB9JNOvFIUktjxpS46yluXNjguzuFHCdjOyuchhZ0baB38SXldY4771XR+rIs0Ny70E6OW49w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9afa65-5f79-4666-85e3-08dcf38b6b19
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:52:10.5255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OF2cTsh0Hs2BSpb6fZIlRwxOAaiWNQW/jMTdQ81RBeXyXjCPOW18Op1MjT9VjOSJL8O6I9vqPphroNWBg61xeYYbOh2jYyczTpnst1y/1eU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7731
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_15,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230113
X-Proofpoint-GUID: XwTFRKpjwyekrnkmBnq_77xk013IX7w5
X-Proofpoint-ORIG-GUID: XwTFRKpjwyekrnkmBnq_77xk013IX7w5

On Wed, Oct 23, 2024 at 01:19:35PM -0400, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241022 16:41]:
> > We have seen bugs and resource leaks arise from the complexity of the
> > __mmap_region() function. This, and the generally deeply fragile error
> > handling logic and complexity which makes understanding the function
> > difficult make it highly desirable to refactor it into something readable.
> >
> > Achieve this by separating the function into smaller logical parts which
> > are easier to understand and follow, and which importantly very
> > significantly simplify the error handling.
> >
> > Note that we now call vms_abort_munmap_vmas() in more error paths than we
> > used to, however in cases where no abort need occur, vms->nr_pages will be
> > equal to zero and we simply exit this function without doing more than we
> > would have done previously.
> >
> > Importantly, the invocation of the driver mmap hook via mmap_file() now has
> > very simple and obvious handling (this was previously the most problematic
> > part of the mmap() operation).
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  mm/vma.c | 380 +++++++++++++++++++++++++++++++++++--------------------
> >  1 file changed, 240 insertions(+), 140 deletions(-)
> >
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 7617f9d50d62..a271e2b406ab 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -7,6 +7,31 @@
> >  #include "vma_internal.h"
> >  #include "vma.h"
> >
> > +struct mmap_state {
> > +	struct mm_struct *mm;
> > +	struct vma_iterator *vmi;
> > +	struct vma_merge_struct *vmg;
> > +	struct list_head *uf;
> > +
> > +	struct vma_munmap_struct vms;
> > +	struct ma_state mas_detach;
> > +	struct maple_tree mt_detach;
> > +
> > +	unsigned long flags;
> > +	unsigned long pglen;
> > +	unsigned long charged;
> > +};
> > +
> > +#define MMAP_STATE(name, mm_, vmi_, vmg_, uf_, flags_, len_)	\
> > +	struct mmap_state name = {				\
> > +		.mm = mm_,					\
> > +		.vmi = vmi_,					\
> > +		.vmg = vmg_,					\
> > +		.uf = uf_,					\
> > +		.flags = flags_,				\
> > +		.pglen = PHYS_PFN(len_),			\
> > +	}
> > +
> >  static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_next)
> >  {
> >  	struct vm_area_struct *vma = merge_next ? vmg->next : vmg->prev;
> > @@ -2169,189 +2194,247 @@ static void vms_abort_munmap_vmas(struct vma_munmap_struct *vms,
> >  	vms_complete_munmap_vmas(vms, mas_detach);
> >  }
> >
> > -unsigned long __mmap_region(struct file *file, unsigned long addr,
> > -		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
> > -		struct list_head *uf)
> > +/*
> > + * __mmap_prepare() - Prepare to gather any overlapping VMAs that need to be
> > + *                    unmapped once the map operation is completed, check limits,
> > + *                    account mapping and clean up any pre-existing VMAs.
> > + *
>
> nit: formatting seems wrong here?

But I like it this way :( will change though.

>
> > + * @map: Mapping state.
> > + *
> > + * Returns: 0 on success, error code otherwise.
> > + */
> > +static int __mmap_prepare(struct mmap_state *map)
> >  {
> > -	struct mm_struct *mm = current->mm;
> > -	struct vm_area_struct *vma = NULL;
> > -	pgoff_t pglen = PHYS_PFN(len);
> > -	unsigned long charged = 0;
> > -	struct vma_munmap_struct vms;
> > -	struct ma_state mas_detach;
> > -	struct maple_tree mt_detach;
> > -	unsigned long end = addr + len;
> >  	int error;
> > -	VMA_ITERATOR(vmi, mm, addr);
> > -	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);
> > -
> > -	vmg.file = file;
> > -	/* Find the first overlapping VMA */
> > -	vma = vma_find(&vmi, end);
> > -	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
> > -	if (vma) {
> > -		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
> > -		mt_on_stack(mt_detach);
> > -		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
> > +	struct vma_iterator *vmi = map->vmi;
> > +	struct vma_merge_struct *vmg = map->vmg;
> > +	struct vma_munmap_struct *vms = &map->vms;
> > +
> > +	/* Find the first overlapping VMA and initialise unmap state. */
> > +	vms->vma = vma_find(vmi, vmg->end);
> > +	init_vma_munmap(vms, vmi, vms->vma, vmg->start, vmg->end, map->uf,
> > +			/* unlock = */ false);
> > +
> > +	/* OK, we have overlapping VMAs - prepare to unmap them. */
> > +	if (vms->vma) {
> > +		mt_init_flags(&map->mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
>
> Nit: line is too long.

Yeah think this is possibly pre-existing but will fix either way.

>
> > +		mt_on_stack(map->mt_detach);
> > +		mas_init(&map->mas_detach, &map->mt_detach, /* addr = */ 0);
> >  		/* Prepare to unmap any existing mapping in the area */
> > -		error = vms_gather_munmap_vmas(&vms, &mas_detach);
> > +		error = vms_gather_munmap_vmas(vms, &map->mas_detach);
> >  		if (error)
> > -			goto gather_failed;
> > +			return error;
>
> As Vlastimil pointed out, there is an issue just returning the error.

Yeah have addressed it, thanks!

>
> >
> > -		vmg.next = vms.next;
> > -		vmg.prev = vms.prev;
> > -		vma = NULL;
> > +		vmg->next = vms->next;
> > +		vmg->prev = vms->prev;
> >  	} else {
> > -		vmg.next = vma_iter_next_rewind(&vmi, &vmg.prev);
> > +		vmg->next = vma_iter_next_rewind(vmi, &vmg->prev);
> >  	}
> >
> >  	/* Check against address space limit. */
> > -	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages)) {
> > -		error = -ENOMEM;
> > -		goto abort_munmap;
> > -	}
> > +	if (!may_expand_vm(map->mm, map->flags, map->pglen - vms->nr_pages))
> > +		return -ENOMEM;
> >
> > -	/*
> > -	 * Private writable mapping: check memory availability
> > -	 */
> > -	if (accountable_mapping(file, vm_flags)) {
> > -		charged = pglen;
> > -		charged -= vms.nr_accounted;
> > -		if (charged) {
> > -			error = security_vm_enough_memory_mm(mm, charged);
> > +	/* Private writable mapping: check memory availability. */
> > +	if (accountable_mapping(vmg->file, map->flags)) {
> > +		map->charged = map->pglen;
> > +		map->charged -= vms->nr_accounted;
> > +		if (map->charged) {
> > +			error = security_vm_enough_memory_mm(map->mm, map->charged);
> >  			if (error)
> > -				goto abort_munmap;
> > +				return error;
> >  		}
> >
> > -		vms.nr_accounted = 0;
> > -		vm_flags |= VM_ACCOUNT;
> > -		vmg.flags = vm_flags;
> > +		vms->nr_accounted = 0;
> > +		map->flags |= VM_ACCOUNT;
> >  	}
> >
> >  	/*
> > -	 * clear PTEs while the vma is still in the tree so that rmap
> > +	 * Clear PTEs while the vma is still in the tree so that rmap
> >  	 * cannot race with the freeing later in the truncate scenario.
> >  	 * This is also needed for mmap_file(), which is why vm_ops
> >  	 * close function is called.
> >  	 */
> > -	vms_clean_up_area(&vms, &mas_detach);
> > -	vma = vma_merge_new_range(&vmg);
> > -	if (vma)
> > -		goto expanded;
> > +	vms_clean_up_area(vms, &map->mas_detach);
> > +
> > +	return 0;
> > +}
> > +
> > +static int __mmap_new_file_vma(struct mmap_state *map, struct vm_area_struct *vma,
> > +			       struct vm_area_struct **mergep)
> > +{
> > +	struct vma_iterator *vmi = map->vmi;
> > +	struct vma_merge_struct *vmg = map->vmg;
> > +	int error;
> > +
> > +	vma->vm_file = get_file(vmg->file);
> > +	error = mmap_file(vma->vm_file, vma);
> > +	if (error) {
> > +		fput(vma->vm_file);
> > +		vma->vm_file = NULL;
> > +
> > +		vma_iter_set(vmi, vma->vm_end);
> > +		/* Undo any partial mapping done by a device driver. */
> > +		unmap_region(&vmi->mas, vma, vmg->prev, vmg->next);
> > +
> > +		return error;
> > +	}
> > +
> > +	/* Drivers cannot alter the address of the VMA. */
> > +	WARN_ON_ONCE(vmg->start != vma->vm_start);
> > +	/*
> > +	 * Drivers should not permit writability when previously it was
> > +	 * disallowed.
> > +	 */
> > +	VM_WARN_ON_ONCE(map->flags != vma->vm_flags &&
> > +			!(map->flags & VM_MAYWRITE) &&
> > +			(vma->vm_flags & VM_MAYWRITE));
> > +
> > +	vma_iter_config(vmi, vmg->start, vmg->end);
> > +	/*
> > +	 * If flags changed after mmap_file(), we should try merge
> > +	 * vma again as we may succeed this time.
> > +	 */
> > +	if (unlikely(map->flags != vma->vm_flags && vmg->prev)) {
> > +		struct vm_area_struct *merge;
> > +
> > +		vmg->flags = vma->vm_flags;
> > +		/* If this fails, state is reset ready for a reattempt. */
> > +		merge = vma_merge_new_range(vmg);
> > +
> > +		if (merge) {
> > +			/*
> > +			 * ->mmap() can change vma->vm_file and fput
> > +			 * the original file. So fput the vma->vm_file
> > +			 * here or we would add an extra fput for file
> > +			 * and cause general protection fault
> > +			 * ultimately.
> > +			 */
> > +			fput(vma->vm_file);
> > +			vm_area_free(vma);
> > +			vma_iter_free(vmi);
> > +			*mergep = merge;
> > +		} else {
> > +			vma_iter_config(vmi, vmg->start, vmg->end);
> > +		}
> > +	}
> > +
> > +	map->flags = vma->vm_flags;
> > +	return 0;
> > +}
> > +
> > +/*
> > + * __mmap_new_vma() - Allocate a new VMA for the region, as merging was not
> > + *                    possible.
> > + *
> > + *                    An exception to this is if the mapping is file-backed, and
> > + *                    the underlying driver changes the VMA flags, permitting a
> > + *                    subsequent merge of the VMA, in which case the returned
> > + *                    VMA is one that was merged on a second attempt.
>
> It seems all the descriptions have indented lines.

I like it that way :( will change :'(

>
> > + *
> > + * @map:  Mapping state.
> > + * @vmap: Output pointer for the new VMA.
> > + *
> > + * Returns: Zero on success, or an error.
> > + */
> > +static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
> > +{
> > +	struct vma_iterator *vmi = map->vmi;
> > +	struct vma_merge_struct *vmg = map->vmg;
> > +	struct vm_area_struct *merge = NULL;
> > +	int error = 0;
> > +	struct vm_area_struct *vma;
> > +
> >  	/*
> >  	 * Determine the object being mapped and call the appropriate
> >  	 * specific mapper. the address has already been validated, but
> >  	 * not unmapped, but the maps are removed from the list.
> >  	 */
> > -	vma = vm_area_alloc(mm);
> > -	if (!vma) {
> > -		error = -ENOMEM;
> > -		goto unacct_error;
> > -	}
> > +	vma = vm_area_alloc(map->mm);
> > +	if (!vma)
> > +		return -ENOMEM;
> >
> > -	vma_iter_config(&vmi, addr, end);
> > -	vma_set_range(vma, addr, end, pgoff);
> > -	vm_flags_init(vma, vm_flags);
> > -	vma->vm_page_prot = vm_get_page_prot(vm_flags);
> > +	vma_iter_config(vmi, vmg->start, vmg->end);
>
> This function is only called from __mmap_region() after an
> __mmap_prepare() and vma_merge_new_range().  The state should be fine,
> so maybe this could be WARN_ONs?  Although, it's probably safer to just
> leave it.

Yeah perhaps one for the laterbase?

>
> > +	vma_set_range(vma, vmg->start, vmg->end, vmg->pgoff);
> > +	vm_flags_init(vma, map->flags);
> > +	vma->vm_page_prot = vm_get_page_prot(map->flags);
> >
> > -	if (vma_iter_prealloc(&vmi, vma)) {
> > +	if (vma_iter_prealloc(vmi, vma)) {
> >  		error = -ENOMEM;
> >  		goto free_vma;
> >  	}
> >
> > -	if (file) {
> > -		vma->vm_file = get_file(file);
> > -		error = mmap_file(file, vma);
> > -		if (error)
> > -			goto unmap_and_free_file_vma;
> > -
> > -		/* Drivers cannot alter the address of the VMA. */
> > -		WARN_ON_ONCE(addr != vma->vm_start);
> > -		/*
> > -		 * Drivers should not permit writability when previously it was
> > -		 * disallowed.
> > -		 */
> > -		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
> > -				!(vm_flags & VM_MAYWRITE) &&
> > -				(vma->vm_flags & VM_MAYWRITE));
> > -
> > -		vma_iter_config(&vmi, addr, end);
> > -		/*
> > -		 * If vm_flags changed after mmap_file(), we should try merge
> > -		 * vma again as we may succeed this time.
> > -		 */
> > -		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
> > -			struct vm_area_struct *merge;
> > -
> > -			vmg.flags = vma->vm_flags;
> > -			/* If this fails, state is reset ready for a reattempt. */
> > -			merge = vma_merge_new_range(&vmg);
> > -
> > -			if (merge) {
> > -				/*
> > -				 * ->mmap() can change vma->vm_file and fput
> > -				 * the original file. So fput the vma->vm_file
> > -				 * here or we would add an extra fput for file
> > -				 * and cause general protection fault
> > -				 * ultimately.
> > -				 */
> > -				fput(vma->vm_file);
> > -				vm_area_free(vma);
> > -				vma_iter_free(&vmi);
> > -				vma = merge;
> > -				/* Update vm_flags to pick up the change. */
> > -				vm_flags = vma->vm_flags;
> > -				goto file_expanded;
> > -			}
> > -			vma_iter_config(&vmi, addr, end);
> > -		}
> > -
> > -		vm_flags = vma->vm_flags;
> > -	} else if (vm_flags & VM_SHARED) {
> > +	if (vmg->file)
> > +		error = __mmap_new_file_vma(map, vma, &merge);
> > +	else if (map->flags & VM_SHARED)
> >  		error = shmem_zero_setup(vma);
> > -		if (error)
> > -			goto free_iter_vma;
> > -	} else {
> > +	else
> >  		vma_set_anonymous(vma);
> > -	}
> > +
> > +	if (error)
> > +		goto free_iter_vma;
> > +
> > +	if (merge)
> > +		goto file_expanded;
> >
> >  #ifdef CONFIG_SPARC64
> >  	/* TODO: Fix SPARC ADI! */
> > -	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
> > +	WARN_ON_ONCE(!arch_validate_flags(map->flags));
> >  #endif
> >
> >  	/* Lock the VMA since it is modified after insertion into VMA tree */
> >  	vma_start_write(vma);
> > -	vma_iter_store(&vmi, vma);
> > -	mm->map_count++;
> > +	vma_iter_store(vmi, vma);
> > +	map->mm->map_count++;
> >  	vma_link_file(vma);
> >
> >  	/*
> >  	 * vma_merge_new_range() calls khugepaged_enter_vma() too, the below
> >  	 * call covers the non-merge case.
> >  	 */
> > -	khugepaged_enter_vma(vma, vma->vm_flags);
> > +	khugepaged_enter_vma(vma, map->flags);
> >
> >  file_expanded:
> > -	file = vma->vm_file;
> >  	ksm_add_vma(vma);
>
> __mmap_new_file_vma() may free the vma.  I assume this is what you
> mentioned elsewhere about UAF.

Yeah no this is a new one, let me totally rework this thing and make it
operate on a single VMA and return a merged boolean and reduce the window
between 'pointer freed and pointer reassgined to literally ZERO LINES.

Sorry, I was probably feverish when I did this bit...

>
> > -expanded:
> > +
>
> Extra whitespace.

You hate that whitespace :(

>
> > +	*vmap = vma;
> > +	return 0;
> > +
> > +free_iter_vma:
> > +	vma_iter_free(vmi);
> > +free_vma:
> > +	vm_area_free(vma);
> > +	return error;
> > +}
> > +
> > +/*
> > + * __mmap_complete() - Unmap any VMAs we overlap, account memory mapping
> > + *                     statistics, handle locking and finalise the VMA.
> > + *
> > + * @map: Mapping state.
> > + * @vma: Merged or newly allocated VMA for the mmap()'d region.
> > + */
> > +static void __mmap_complete(struct mmap_state *map, struct vm_area_struct *vma)
> > +{
> > +	struct mm_struct *mm = map->mm;
> > +	unsigned long vm_flags = vma->vm_flags;
> > +
> >  	perf_event_mmap(vma);
> >
> > -	/* Unmap any existing mapping in the area */
> > -	vms_complete_munmap_vmas(&vms, &mas_detach);
> > +	/* Unmap any existing mapping in the area. */
> > +	vms_complete_munmap_vmas(&map->vms, &map->mas_detach);
> >
> > -	vm_stat_account(mm, vm_flags, pglen);
> > +	vm_stat_account(mm, vma->vm_flags, map->pglen);
> >  	if (vm_flags & VM_LOCKED) {
> >  		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
> >  					is_vm_hugetlb_page(vma) ||
> > -					vma == get_gate_vma(current->mm))
> > +					vma == get_gate_vma(mm))
> >  			vm_flags_clear(vma, VM_LOCKED_MASK);
> >  		else
> > -			mm->locked_vm += pglen;
> > +			mm->locked_vm += map->pglen;
> >  	}
> >
> > -	if (file)
> > +	if (vma->vm_file)
> >  		uprobe_mmap(vma);
> >
> >  	/*
> > @@ -2364,26 +2447,43 @@ unsigned long __mmap_region(struct file *file, unsigned long addr,
> >  	vm_flags_set(vma, VM_SOFTDIRTY);
> >
> >  	vma_set_page_prot(vma);
> > +}
> >
> > -	return addr;
> > +unsigned long __mmap_region(struct file *file, unsigned long addr,
> > +		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
> > +		struct list_head *uf)
> > +{
> > +	struct mm_struct *mm = current->mm;
> > +	struct vm_area_struct *vma;
> > +	int error;
> > +	VMA_ITERATOR(vmi, mm, addr);
> > +	VMG_STATE(vmg, mm, &vmi, addr, addr + len, vm_flags, pgoff);
> > +	MMAP_STATE(map, mm, &vmi, &vmg, uf, vm_flags, len);
> >
> > -unmap_and_free_file_vma:
> > -	fput(vma->vm_file);
> > -	vma->vm_file = NULL;
> > +	vmg.file = file;
> >
> > -	vma_iter_set(&vmi, vma->vm_end);
> > -	/* Undo any partial mapping done by a device driver. */
> > -	unmap_region(&vmi.mas, vma, vmg.prev, vmg.next);
> > -free_iter_vma:
> > -	vma_iter_free(&vmi);
> > -free_vma:
> > -	vm_area_free(vma);
> > -unacct_error:
> > -	if (charged)
> > -		vm_unacct_memory(charged);
> > +	error = __mmap_prepare(&map);
> > +	if (error)
> > +		goto abort_munmap;
> > +
> > +	/* Attempt to merge with adjacent VMAs... */
> > +	vmg.flags = map.flags;
> > +	vma = vma_merge_new_range(&vmg);
> > +	if (!vma) {
> > +		/* ...but if we can't, allocate a new VMA. */
> > +		error = __mmap_new_vma(&map, &vma);
> > +		if (error)
> > +			goto unacct_error;
> > +	}
> > +
> > +	__mmap_complete(&map, vma);
> >
> > +	return addr;
> > +
> > +unacct_error:
> > +	if (map.charged)
> > +		vm_unacct_memory(map.charged);
>
> So this is effectively undoing __mmap_prepare()'s accounting. I don't
> have a better label for it, but it's not obvious by the label that the
> accounting was done in __mmap_prepare().

There's a comment in the description of the function. I'll add a comment
here too to be clear about it.

>
> >  abort_munmap:
> > -	vms_abort_munmap_vmas(&vms, &mas_detach);
> > -gather_failed:
> > +	vms_abort_munmap_vmas(&map.vms, &map.mas_detach);
> >  	return error;
> >  }
> > --
> > 2.47.0

