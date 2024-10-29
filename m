Return-Path: <linux-kernel+bounces-387252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13399B4E8D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCDBB1C216AD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73C81917F9;
	Tue, 29 Oct 2024 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ut0KuJzn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kF3dNzmx"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E182802
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217166; cv=fail; b=Ml7VCmd4DzdObA1OTfkWR5/ocELUg+k508zCBLONL+i16vB/FEd2lh1WoZlV/d0jQQCKUYgzJE0dphx7FBXNuxJUxicoX48gUWJAOgaI3Jib3L5gFF4c+5nAdjZebOpFWL/IvzPlw6qwFhcQmUt4DKotWitkowpnFqCXZtRnpbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217166; c=relaxed/simple;
	bh=h82LnOydpWFcB/Mo64vhim8aQt+pf5HhOEHXKNltgSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dUEQ22KShFKj+Ej2p0DEYSPfSJIdxPOZqhrU6OT+LpArf4CoKCqspx6oA6ftQXvbgTZKTu+SPgM2hoNvG/n5RUY+2AGzl6Ke8iaZg8suyG5Mb/U+wn+k7NmwX5rOICPgfz9rRHdqG4nQ+lG+6CHxwGoarrRWOoG5T1CvXoAdsC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ut0KuJzn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kF3dNzmx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TEtdg2015673;
	Tue, 29 Oct 2024 15:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=h82LnOydpWFcB/Mo64
	vhim8aQt+pf5HhOEHXKNltgSg=; b=Ut0KuJznLFmZYg8jx7tU1xUxna4sQ1WwxI
	e520nen1/7lIw1FUZigh+sERUEgqxeTNfecDsTkpxcbtwn/o9SOIdjBViVTcTYJz
	EEcetHQ5BG9sm3owgBh+mhVg8ohz+RlITeyfhVcV53PMpH841s1SCbmv5pXpdpKJ
	g6aEGeuXRM3NYIcg2+o7PpD4zhwu0UdGzgDxvJcVM1rYFniWhiLDS6IuMqczkRrW
	Jfc9t8ofPyhqp3kbgalYTstNNToqU4Nxku7p2mPOdsYh2LqQd6TTygSNY4IioUDf
	cPSX2j5SYGzPuUcPeTxKg1sxeXbFeG85AuxlDI97QpzKT9M8T7tg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grc8wvt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 15:52:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TEuMgZ011760;
	Tue, 29 Oct 2024 15:52:21 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnacqk37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 15:52:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIsSDqiZq/gPPXGLLM76wayNtUeghs3fe9HaeAe8WIwxq/XeNvXL7f+QHC9WwfbfJ0xSzQHgfi5V0jOqe+8rOmAjMJk1MPQDJ+Bplcr+x34XDBpxMmVQi4C/fhwFFpf/ri6pq5xaIyrFi9/01vioc7vhRlFtK70XSH2UGxy0YgHTIuJAvRlhZKnGiLtrgLFk2eQe5hMosXD2fphYCMyWf3mI2fzeFJFN9az/ZxDTzyxajPQxSvNhNoDMyjqSXXZ/TervOud46+0nDOtAKbBKStH9NqyYtPWUd9dK+6yWDIAttrAouN59gOQAYwi4quSqCiBoDPK4vYdnAmbVGHaPtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h82LnOydpWFcB/Mo64vhim8aQt+pf5HhOEHXKNltgSg=;
 b=O2lGwzIOYE+sDRZZZ7DpBB7iP7v29gaZCvXEJhqsrccKV/LYwaOyzfVjyaUxV2FxL1XdQi4detIDd4C2VlrzPJ8/FC+Jgj2jZC4OrrK/3WEhQLW0r4Nh4y2ek3MzrtTYJh0mLKlbMY79mmssgyAQETNGQAYzS8Itt5NXRKmv2zwHYBQgd3CbUDnnBRTCUywMjEs1KB73V+Abu8Mo4RMeF+sHAiVD2M1i7jkIgrQsO9Efw0eNeV+nNnLuDBehd3VExPS9EkC7IDEilk2TDe/PLc33sRfTfYN6DMM5rlgNH9QXZ9yLlhBp3jTgd9Paj0aqO2CGPcGF/CCYLMbXcOa/5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h82LnOydpWFcB/Mo64vhim8aQt+pf5HhOEHXKNltgSg=;
 b=kF3dNzmxkeO1q0YLByCLV5D/8U7FM5amhqw/JHo2hjyLACcOLCSXnXC4W/SRTyaqQyWbPAZJG6TdErwPiAMJm5xE7//0e4HMgxEQqlCAuPS0080C+IdwfUzQ4TGTTz7I/MD0+CooSm7C+msgnBd3f60k9yucRDN1U6+bcCBc2z0=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS7PR10MB7130.namprd10.prod.outlook.com (2603:10b6:8:e2::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.24; Tue, 29 Oct 2024 15:52:19 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 15:52:18 +0000
Date: Tue, 29 Oct 2024 15:52:14 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yang Shi <shy828301@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
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
Message-ID: <32e59a00-a174-4fcc-befd-56915cfb01d1@lucifer.local>
References: <cover.1730206735.git.lorenzo.stoakes@oracle.com>
 <ea10a05be83c70cf610d470fe3b4c05513e3859c.1730206735.git.lorenzo.stoakes@oracle.com>
 <CAHbLzkqmDyOb9kwLKyKkThjT41UNCwb6p8XL6rEHVmvEbJEXZw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkqmDyOb9kwLKyKkThjT41UNCwb6p8XL6rEHVmvEbJEXZw@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0223.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::9) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS7PR10MB7130:EE_
X-MS-Office365-Filtering-Correlation-Id: ed3b8ae6-dbd8-49ae-4a29-08dcf831aaf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YX9ckkW7QMP+MD1nVLu7+J0jB3XkjlyiFq6Wyywqmqsc8uwYduMDm8UbO4s/?=
 =?us-ascii?Q?928/mB0ukixU0bGJ3br0pqY/PzCe+jobUMBy4yX0nfRJPL4Uj1fkFGfpyleh?=
 =?us-ascii?Q?Ep/1MRWGZ+UC3w49Fv7rR17fa3sgCW2nCOU2JR//1iK5b9hzAFp+bAkTAN3V?=
 =?us-ascii?Q?VUpNBDKumGPnroKiUFGpEWhzYF+ZipzuikBaFpI9zAyqfDacMFmOnuYL7EaM?=
 =?us-ascii?Q?T3QXALO28zSm4jiAvJPMSMhMoTkNU5d7wIKa4rRhgA1ypurCEICq5SQGBalk?=
 =?us-ascii?Q?Pu/a8WFHKPuTsGBhX46fVT9y6JIp09gJQW3+TrBTf5/PhxOpxrabbvdclYws?=
 =?us-ascii?Q?8fEXXYm5P6TTlUURdBFHP+HzxRS/87EAy1ivTUdXCuhqSDAVoBccKRYxyELp?=
 =?us-ascii?Q?h3UtTvht2sLHTkhjKb7MP3P4pBYuRvhUXnb/8V/9DIloORIy1aGaWjeckbjU?=
 =?us-ascii?Q?LFrD5d0QS56NfO+sa5ydS93+aKm7lXuhqPotyyMjziCNuPZCzrXKG+aX66iU?=
 =?us-ascii?Q?Y8pEFrUiHfPhE+r9HPCPwZZqBFsR8Uc7hgxF6oOP9T2zzUiGYfU8KM3Ul5F+?=
 =?us-ascii?Q?Y9x/Ht4jH4rZ7bZNVLWCWd+44X3yecBjAe94cQxegtngyf/CnubMUbfmllnq?=
 =?us-ascii?Q?0ZG8eDzsWWBuAyJPOgSqhY56IEijw1Zq7uSN/QC72z6fBF8S5o6WnfAiWZVr?=
 =?us-ascii?Q?vhTpiRh6aFaYYeixHnpVY6UPJIZo4+XKC1S8X5IrEN5vsZcf3KPfhjJ+S11z?=
 =?us-ascii?Q?U18XpKRvaB/6O8XKl7Y4DLDM7Kkf+d0/4jbeM49aU16KA53mytF8pKlbw2Iq?=
 =?us-ascii?Q?uQOumltwltb+Qp699dVOHJ7oZ3mFzq6TV4J6T3QyWutjEMmUGP9DyHjTuT3K?=
 =?us-ascii?Q?6dyaSLuXcIiQqQ+xicpYxxw0edi5++RJAjLLRwY9xX7EHoZqtNAr2ie79izQ?=
 =?us-ascii?Q?+QSMvN5XLnB7TndWbZYXU3t3Q7b695tJM5ZY8E+T3ftybHBv3VD4tqk9l+QB?=
 =?us-ascii?Q?+xpaPtXWiXYaBhWLK51IUdaiXvj00MZ55jfRl5yc5QC5W6SOhDKxKRT5kIwn?=
 =?us-ascii?Q?aprl94lT6QdlrB/6EvZda6qupIkTvwYbrVHpSJYy56MuJMM9fkKNE33I7j+t?=
 =?us-ascii?Q?SX2PjLhEgi9ru9lrcgwaQ8KQhOfeC4uus8j5+tAkWAAAFfs9GdCGpDE/mKNk?=
 =?us-ascii?Q?8ZHHfS01f6nJBytSIDXZQBTxV2839m4FT9jFFkdZWxMNZYzCKOd2wJApggNL?=
 =?us-ascii?Q?/+AZkIVg7ZAef0yjowEP2UhTdL+/w91BhtjNSn4l8/tHQGnvmlvk3Z6tlC61?=
 =?us-ascii?Q?uUxYAqY1eHMccs8mmGsDb4I0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NsA+RIsXO3k3tAyveflocyxNCRu7Oe4u0kGm+gX/EakhZqX8HvXmoVxHMuv8?=
 =?us-ascii?Q?0A/b7Ro0X4yjFvUS+cohY6MZMcgwhrHDfRJtDL3mW1YMGcSdB9kSXscubwxg?=
 =?us-ascii?Q?SdLjbzk/hO/9Pdu1e+mhL5ueTuMH5v9LS2012JUBu0gkmlaOxEUKUOQ3OqcC?=
 =?us-ascii?Q?uDwa/iRzJOBuaH/MFYe5ZQLfkvsHJYb3jXMeyv1eHPFCdlnYHHn+P598N/x0?=
 =?us-ascii?Q?ojhpJ3tRHtBNxO5pshMn7HsBcAQ90SifFjvuhjp1eVkbH/6zZ1oRaxsfgCSf?=
 =?us-ascii?Q?10mEdU+Hz6Ltolz6I/2c/67CbPFeDA79K2p73KX7NyG/ZfU1Qq+cNBvWwT/r?=
 =?us-ascii?Q?o3HDm1xZbAh/vCShrtpmHyA2OO+kNI7APg7x9DmGqX83Wbj3SXc7Cla9zro8?=
 =?us-ascii?Q?98RnGnxGnWfJWKbO4sC/3AbWZ3+iJrgaRmL3PFzIIqj3euD8ynwBsLdv0Mc4?=
 =?us-ascii?Q?Lh4qHVaiLPrnDIddefhsjlBVuJ0AscBMOFBZZ1CSRK8bWOqOxNFcmERtYjkR?=
 =?us-ascii?Q?dGelD6hTR1vD2okJIyhqED2k3lPz7LUmzoiSskZUcwfi4O2FtDltteL2Zuyw?=
 =?us-ascii?Q?7r07Qo6ID7LpKmuoU+gDL6M+nMxR7yf9lOoABRsvFxNMglv8xiuM0n0ryqWT?=
 =?us-ascii?Q?joR00H0EUX0v9zYgUjQ24qGtxkSwGfKQz63ccYsFHdEbFXVGJQHida5BU3/q?=
 =?us-ascii?Q?8xaTx45SMpFGO7sO1bc2l/lcIbUmswPGZ0/4nMaThnjHEDHNkPg6VO9tRTT6?=
 =?us-ascii?Q?KT/S1Nhu7EivH4tqgr1mfAlLmky7hH26kUNIznstIE16ve4hrWuZUyCceku7?=
 =?us-ascii?Q?b7WpyzH+/iJNn07VnQXFCoiSIGjf6HPEfRAPUuqHKZov8zQ83YHP8DhhwgP2?=
 =?us-ascii?Q?mlxjF8CXFXP62v/KHoxxLS7kytb4SzZn0JmYp6tCk+AVJ0tIiNQyJB9S0lOA?=
 =?us-ascii?Q?yH83FJoz8tq4kOm6JBMG5D7onviYuuKfHpuK+GRUukg3mGh/p6L374Mjpxy1?=
 =?us-ascii?Q?TLXJT7KS0B1OoUJVx31p0UdgvDXfYdjuBPoI6s/S9MZS7RhEL01krjTuP1Pj?=
 =?us-ascii?Q?mtEUhrlno6SaiH0sAlNNP2vnJLZwNIllK7nnVOZdYEhOVjTD10QHIJ57z3j0?=
 =?us-ascii?Q?LR1fLrTJ0KXDaFonwmn5Q17kB5bOVVhNIT5imWfraPjYO39idPjOfMrand0Y?=
 =?us-ascii?Q?XYx9rt2ZKldJPceBBg8FiipZBVrZlkplZmZVPLADG5W6D2siRkbcsW2hZJZI?=
 =?us-ascii?Q?qMiWPfMIxHmWBcVG1n0OofEUPerMo1YdFweLny0n1TS7lf6ioopFxE4PsDuY?=
 =?us-ascii?Q?x5VT7dk1o/hAjOmo9pIG3dNFZKtcCCXj6TqfXr3yHEZQPR7lE6Kgi4fh9bDQ?=
 =?us-ascii?Q?kyIhhelDCOM/vOYAM9dMMrWKwvuKaWbEdvXL19k5kaWMxXUeHHsq07c8JYIJ?=
 =?us-ascii?Q?D0YOI807qmuLVuLprYjhzVILinKM4aRxRL5XvB7kZkMOT81yWvq+qmUDiMK1?=
 =?us-ascii?Q?9sfXLsK1wqOkKUa4U6EJLdIG12Z9wbZztIoTuSAOb2EdbTmDomeBzQpgIwdO?=
 =?us-ascii?Q?oU5SfeZ30Ign9W4Wx9kCgjZT2oI7vdeomRVqoZpgxi2tiXKBqPmqTqKWDZ0B?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BBo7F/Ij3jWTFuGyeSTEdXIHUoIaNqXow6Oar3jARacWfmjWSi400Ds5l1CUyZBrDqiSHSyTatvAXVNF1icv6elWHyRv0s58zlhW0GiXOR9cedl30VuQGkC0r4kkoNAboutP6A9CZXmw5Uwvj8BhPcnvSPL9bmeWoiWwBN83sMVPcQRZ4ryvEk9d0yJjfn6Y3wO6zgXoLl3t7bS93n0FBJZ/uF8fZj/zKhYLZJQTr5buBxU7bUxdT5twVEgekAxFm/9FGJXNCP3pcSonIar00XOZnm403EExaAL9eJQlAV9GBxtzrwNE/xPhQE9NC5nLyVwM4SbgRo2K3ZlCjn5BCKHQR2fB7ZZaAqh/5Fd5KiRlo4kbcQ3cLY1gMyHjuaW74LRTCGFe0m1d4QdqiZhLjugoRbSHbwwOHN2ys8pmtHvhDAKyZuoEuIzHZqsKnNuA1lH+TFKmmgrKY3+4EGQYXHVH0IkKJoqwc+NTwLWrlQRYRtmrby2Sg7MPsTslNL8d3Y0TJZBhrY6G6DHCyroPr3sXWEYgm5XBi9sHvF01z8T22+FcloitovIeuf9OAFTL+5qpAlhEt5jS8eBtflGrWqVkQWp5ZWNzs0MeJtCPevA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3b8ae6-dbd8-49ae-4a29-08dcf831aaf4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 15:52:18.5899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WDcxtClm+WziCCFpdjZoETvHp7McjBOWLZ5gf+/g9jkFYR96lYj4dSbIBUyjA7Z/T41fzjL9jD1u1+v+akGM0jEEkR3UdukO0IDzREp69nM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7130
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_11,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=895 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290121
X-Proofpoint-GUID: Fd0vrdHZqwsromOdBIPI9cIuTfD_C_85
X-Proofpoint-ORIG-GUID: Fd0vrdHZqwsromOdBIPI9cIuTfD_C_85

On Tue, Oct 29, 2024 at 08:43:04AM -0700, Yang Shi wrote:

>
> Sorry for chiming in late. This looks problematic IIUC. The patch 5/5
> moved arch_validate_flags() before call_mmap() as the commit log said.
> But shmem_file() does this check:
> mapping->a_ops == &shmem_aops
>
> But mapping->a_ops is not initialized until shmem_mmap(), which is
> called by call_mmap().
>
> So shmem_file() should always return false here. Did I miss something?

Well firstly this is tested and works so you did miss something :)

Bu shmem_mmap() is not setting mapping->a_ops, it's setting vma->vm_ops.

__shmem_get_inode() and shmem_symlink() set mapping->a_ops.

