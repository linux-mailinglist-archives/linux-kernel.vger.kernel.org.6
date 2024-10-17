Return-Path: <linux-kernel+bounces-370329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C969D9A2B2F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3951F23230
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1461DFE30;
	Thu, 17 Oct 2024 17:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="in+Rc/r/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eHVRf6OC"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3661DFDB9
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 17:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729186895; cv=fail; b=t+L2nl5CDhrwKENEn21Xp9bUlBrhOHAHolM0pzM8q6p5utYY//sAlDQ42z1x1h0XVfBOAClBgLvcWK9MqoUV0ArNtVWyxaYW8PE7Egs0IbNXbfqof+6Hkay0lQwDgQp8cLTBM2nNwN2K7f//HaU0eimEcQVRkj1/wOtHWAkylBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729186895; c=relaxed/simple;
	bh=fzdAOqXak661Zcz1zmAc5E1IRDh1kyI7rSZC5B26AAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XHdczfxVPe9TT/aPBPN6VE6hsI9gifpGA0CeTjzE0XHizSh6BXYz9HcaLi4s0w2DuqtiIdWGV4nah9iH/F7IMk0U9CUMStTFlD6B9VTeGqLAPS24zqn//BZgiCeDwJBb1lXUReuVFRjY/aAL27H2wmwUkrRPP8CSf9TPJBGhm/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=in+Rc/r/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eHVRf6OC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBucG024452;
	Thu, 17 Oct 2024 17:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=v9GEZ1A5d85xxUFXi4
	vgXTWZfqIhPeJSUBU0u86Djvc=; b=in+Rc/r//+xnAVlTygc54+awGLC3WxL2/s
	y4M4f7AjrCMi7S5tgGZ7UkgdTosW1aPckMI9LxX/mPrPR2mvPVzOiDKCCFVgtPeZ
	CsJRKXDDRGt30kzKADGYUByzbvfcGHEJ9+WcyQSa63lkoAXJ7HUJjrySsu/kJSDf
	rkDB77GzNTRSi+iPOfj70Cs2uSzDPlK3FZSPa7d0MgqFE9yrZcZP7zjBLZT3XF7I
	waXYkjhwU3kU8vJrlZWmgi++xNQC4UeenbQQW+llgeMDlbT6uSUyhzMK6znFCrVI
	QLXPe/cU1WMnwJvGmg4TSKHjbr+jltFnJ352a4E76lSQHsgd7dbw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhcpmqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 17:41:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HGGaGh036084;
	Thu, 17 Oct 2024 17:41:19 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjh25bs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 17:41:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pCrnQsGgCIyaxuEpda7L1oDnkJ1vct4baYNIZBN27I61W+ACz3rL+WOUkSiAmOzgpZOvuE/uO9thAN2deuiAQw7vsMGR8IT0uKzRpg+K15S+G9xwOJifcNGM0Q9AbkyzbTmQVQTwyoycPc+3i8xJxu/I5UzLi0nmC3r139qJS4ZmpPATWF42hOd3039NpIXMrVFwY9efU0w3+g73si7gjYQNyLrKNExAg5D2UWooJinpAOEJAOwfNEV3E4+iFvTS5msTamemu3t0D9j/ZzmjP6oT7cdkfAaDJxhTBKkfmDQk+fNyuQl/3cCuWXA1hgm80Zvq4KEyEaLbfX1DsqIzMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9GEZ1A5d85xxUFXi4vgXTWZfqIhPeJSUBU0u86Djvc=;
 b=obSDZ5ec3ZR8cZCDtYcFA+wV6xhZUjVZGTIGOpZLMEnfupFOpxs386ZcUWkRXn719gcY25mDeZJia30HgnkAsnymv87ENMg5EaAFyKwlJMvwSfc0F9yOi+gl53wvguMyu21kW4NoIiBDXBRZPCInldmYPV5CsaTKcDB/M8VqMigAOLYSSLUvuvte3Z8SaXAxPaaFtBh1kER18vOIG3KogS4l2u9Ot8Fk6VdZceCU8LLF23SXAVN4Qh0f3NuaiS2PI7R0RK6flvsxp5VG7x/jAaL4eAtBAjjarNc7Adtn7GGjjXYpNI/9hVqJm+9HLGX+CewvyERRCQuZD3TkfPYI/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9GEZ1A5d85xxUFXi4vgXTWZfqIhPeJSUBU0u86Djvc=;
 b=eHVRf6OChmF+xrVK/YsPx9RRrYOZK5vo8VPK+qpa2FMmnYe8OkHcqSd645yt35Sg/2PiHmL+CQ3BUs6JZMoYy6C0on+NqTy3vKQsHyHYqHpEzhmZstB5u149bd7IfhfoGJWUDOD/lexGs43xkYRTwT/GfGkjy1VJofMt7lMh49w=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH0PR10MB7462.namprd10.prod.outlook.com (2603:10b6:610:188::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 17:41:17 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 17:41:17 +0000
Date: Thu, 17 Oct 2024 13:41:15 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oliver Sang <oliver.sang@intel.com>
Subject: Re: [PATCH hotfix 6.12 1/2] mm/vma: add expand-only VMA merge mode
 and optimise do_brk_flags()
Message-ID: <srdmj5c2yb2qshyp2nkujk3tbcilkoaryzevchkv4rzeps63kh@rw3kkagts3o4>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>
References: <cover.1729174352.git.lorenzo.stoakes@oracle.com>
 <4e65d4395e5841c5acf8470dbcb714016364fd39.1729174352.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e65d4395e5841c5acf8470dbcb714016364fd39.1729174352.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0007.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::8) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH0PR10MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: b894cff4-1eb2-4d72-4e76-08dceed2e792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V7sQRKhudvsMIQoROBHj/wTCWgAUpBHPMraLeqlQyJqYWcS21FdHmAkpyC/d?=
 =?us-ascii?Q?UrpWUI4KQXBaPMZqH9r7SyCU+IkMqi4ehkM7UPye2UOD6OcfRVw2/nBtK2Fa?=
 =?us-ascii?Q?yafI1LlYJQ3gGbhQumrtVYey67BveGXu2y4V9IK0Ch5+Wkbf4wznbotQMNJG?=
 =?us-ascii?Q?dGzUGm6HcN8f9iAMcVp0qRS+mnvuveTFfDfHnQ2qbr12rpr38AANGRU3e4I5?=
 =?us-ascii?Q?XcO7UXYvg1TCYr1qFot/tHuE3pwKmi5ybQ/wwohvUZuEko6PXJlgfOdII6DM?=
 =?us-ascii?Q?SbbB85osH2SHGwqLDJyJnd7zJMzIcbItjC+jd8T80JAaicTyFw92lpbEDVE7?=
 =?us-ascii?Q?3eku8/ASb5HbPN5RppewBlOkyHrKXNWXyArrNk8nJ1aj7qyrNB+BToeMkTVc?=
 =?us-ascii?Q?UpxyohEbCS1oBG1Vefd/VjrFp2djKWG/44M16Yl4VjysTEhj2hYNAsbF8fzE?=
 =?us-ascii?Q?foHB/ffc9maQGfdTvX2wdXwNaqeOSlMheWMHJ9N4T/lz2XDrxtCkiiBlvbR7?=
 =?us-ascii?Q?Tq4i5BCRARBxifthBBwuKc3CDafXx5c0PGV4t5KlhB4iXABfkyTDSbBvkn8B?=
 =?us-ascii?Q?rCRUod2bH1t3AtbV2lnjv7BYu6jXq88NgtB1q/FBFP8rhBU54lLJUjHs/g5x?=
 =?us-ascii?Q?mUxbbW1wdC2xzs9RVtqR009bc2bxKRqqhc0vh5BRBSuP2zpb2cMPbtriGmDD?=
 =?us-ascii?Q?1uMJOaDtEPY7ZkmTH/1oJwgXagFYcVRDF6ms67SRSHbUUUyGhLcdtfzWtnFm?=
 =?us-ascii?Q?tn3wEYeSDB1GVYgyvnIGVdWcygSpaq8eipU7sWTNinLFuhGmLS0itdEmw9xH?=
 =?us-ascii?Q?UPUkqboGfBI4dme66+6aFCAphtUzJVQPOpVhJ8nr19hp50MF7A/nfiO+DWIo?=
 =?us-ascii?Q?b6WUe/pjZFdUxNsMrOdUQC019iwRXetRX+RbSPBjmZTanp8SXuw2f/louaYu?=
 =?us-ascii?Q?Ob3OL+imJsoymGc1kM6JcgTEW7N5wx6MZVvdvfT2YTLl3RDjXzO4srPDKyBr?=
 =?us-ascii?Q?duV71x87yt6s2g0iB0301ud22t7+D04VLjIw5hbC8BnKVeJAkFj5U+UWm0li?=
 =?us-ascii?Q?GSLsOKjSH1JWMc8n8Wtg9K5M9cKL+4kMWLv9hnSMtAalX3dY8JXEcyUxr6p4?=
 =?us-ascii?Q?yE1Aw85DUAkkMAjpcRyYoq4bWqmsAzuwiRZfCz8nxy6aALdfcncJZGuEZ8aM?=
 =?us-ascii?Q?ydgugISAfxMAcne6ZYfk705BX60ceS7ZiHd9Lis45FgPghk7B3lOU3KM7tYr?=
 =?us-ascii?Q?Iv3OsLZIf7WTtcOZQhArumrnN7Poj3MZZggTCVmqK+2YfMt7HkFzSEbDdNnN?=
 =?us-ascii?Q?QTXL6w73jEXfYOIgzhP5mP6O?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N3x0U32oISKAetjGzZpLFy2Xn9GWCdfNue9BDkR4E/yBNrg2DJiEqVk+58MW?=
 =?us-ascii?Q?sTIE776vcODIXxzmFHDXV+antp6CqmhqSjzqwkEnJ2f8wczElsC39x0CmrBZ?=
 =?us-ascii?Q?6bCWyc3PHIxASEZ6+n/lbuUT9rMAjswHggbK/6ZHTQ2ouo5k2p03PcZqd9x9?=
 =?us-ascii?Q?a3TdX5F4msVtRui90meUhL1taD0Iu2vH7RDfsCG6j7s/1RtfPaIz5tWzxIIA?=
 =?us-ascii?Q?wVRuQbO6NCvIcuQRrZcFtk0B2x4Sw7ptp9srtV1gsACKP917/73PFjV7l+vx?=
 =?us-ascii?Q?yqtWAEwB45G6tAJHHfVwfmNH8wxkkR7WMW1nqbj27CANmxk4MONO52+mmSjG?=
 =?us-ascii?Q?5Gex8/TELjliuQa2OSJ4ToDSlvIi2s44DGUU57IMfa+SEcDjdWLw/xW9qW+a?=
 =?us-ascii?Q?5zBMq+BL1DsuHzA2WDTJNh+BKHeeqQrSoL7RMfLql5W0XSOSsFyzYzcqiD/X?=
 =?us-ascii?Q?3+apPU0OOvsnm3tW9ezRHq/GYa1Btutvkcf5/D+J4L9N92ygFI32ZVsZLYKh?=
 =?us-ascii?Q?zMEomRzbZMf5VqHlry0EBa+WYYeLOXbKn4ubpyALUW6X/rvlLPqPkPwqKR5J?=
 =?us-ascii?Q?76koxVEDlf9HlYySyTvAztK978i+WRggCBkuPtrS4PxCpVcAy6UmZDTI2FVm?=
 =?us-ascii?Q?w4TeHVwzO2MskFX0P71UktpWoF9XyWY8XUr/mwcyFNv2kBJd2lAfSNN176Xp?=
 =?us-ascii?Q?T1BD7HBXyCdxXf98wJjstSQXXSBtO4XCeHFN87oxGUgaziyR0hKCHPJ8wZWD?=
 =?us-ascii?Q?R/WrycQpkS7ugEhiVQkVyMkBxSf5cdII487vmZoNBLgs10WyqhUyNZ79dNmC?=
 =?us-ascii?Q?eR7EkkXko688ly8F9SGc6uKGTwz3tfe4tr7WgPDzPX7wPFnEiT4c+yrSW9Ou?=
 =?us-ascii?Q?CLTBDUVAbC9CST+6l7ylVygX5FTdSVi2QmC4lCWXuY9uBLei6OXqm+GZptCQ?=
 =?us-ascii?Q?yW+ZGwRNinixWFc8cXIyiTsG/0AvFrZKfMAE3ascF4XpVDZCoNWrP8lNf4Ly?=
 =?us-ascii?Q?geRh1a0dtxWIa+rIL3o+pY/Dej/i1NV0KLSNnU6xEjg4VxcAfVJdaIUGPHVN?=
 =?us-ascii?Q?TP6HvnRHsbpzt5Bl772hdVqEU25gMiUXyUIgwlhv/2AxFy1T+q8gJ3atef7g?=
 =?us-ascii?Q?AGsLH65L3hARCBKwzSEgv95zY4pzJrFJjeJeCx0qJt44W/Ye2tE0cYVLJ8ka?=
 =?us-ascii?Q?PbWLA1GUvv6qFWTXuX6TTW6VSr6gR1irq5GAD7zZ5CtcDqnG8HYovBdLoVDa?=
 =?us-ascii?Q?C98KtZz9USfkHojfPkTzNNxBa9AJWUAzgTAxZuaB4oDG+HwEu+DAvwHoMF4u?=
 =?us-ascii?Q?Wao1iFJ0j3ohrW5lifeEYwSWbpbCUn6mWFdgWu1ThBh4Z7rKufBxrhgLcrDZ?=
 =?us-ascii?Q?fZDbYwZMwRiz0I0dZiSKppBpFyRGOQkqbbmHaTz+gRBB6OpZyl+Ns4gRAn2J?=
 =?us-ascii?Q?ujHiqLNP5gqXq49Mmv75T6CESn9+uRBRd8A4CiKR3GK+PuvgKT1Bj8ZQQRjF?=
 =?us-ascii?Q?I0xTRNrv4ELDnhFe75KU2LvJ6rylPrwjETvrdbcCS2W4XJ3UgwzOo9ryeozT?=
 =?us-ascii?Q?mFnllqA/sbjSOGU3fzoPIyF6zgR567uis0XLUoqo7rI0mAZuAYqn5aZawo7y?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SIQaQ5qBCRvtvOPBiRrGfkkuhdpSIOyu6q9StSvuhwjzCPogmzgEqvbJz7L9YXsX0l7vFFjDTS3Zc1YOeY1xHnTHHmovrxxhok0Do6VeKielVwxrEYKRjtKTMviLjco8bIXRcfHiT1RqTAu3qiFvzQ3y6RH0og7U2gsvjavKoAgVDkTcWZ8YqE8+LPZ7BZqGEJL49nJ22/uXI7q40Jv1Pcb78HIDFQZw/sj00/uagnQ6p90yq489s2hpcPBH9AjyzpYkVj7TAnsBH5phRxesEWPP1bOR40hIUvZBdqPa1qqcaHsM9lR2iSpl7hDowYEk3g5fy2nmmBmykfjEI2tSkzJsG5YqDXShZ+WPotJRZqp1c+hQOCo/z+Ixj5znJnVm5d7hm6kWsCRC7mZY1BQpmM4ZC8oGBBbun0iZc+Uvkc2Ijs8WXohJCK9JoJm4th4bivI1FRMhAOooLYU6+4d7Z5K+sQTyAt1I8ZvhKxxSl4jsWQDzPOeUj8t9NBtUS6u1TlRvp+WShlGoLRJL9eBsLQL76h4uxk1Mrz6j5zuzQaRi/KFTo6ekI1AFS2sGiPu/6wjXY7HkuGv4DutuO6JbpN8zQZdZiI/itPEyixcQ0Ok=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b894cff4-1eb2-4d72-4e76-08dceed2e792
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:41:17.6824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VoRnUfS9FEXtdxMmh0lrywdu41gech2yq+Ue90+2j5Xbk/f01pkeVZFsWnOciEAPnFhAl1HtnDInh2pSYUgT5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_20,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170120
X-Proofpoint-GUID: Az1uqVDLt6UBPGssFjpqL_xQdK8YbpNB
X-Proofpoint-ORIG-GUID: Az1uqVDLt6UBPGssFjpqL_xQdK8YbpNB

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241017 10:31]:
> We know in advance that do_brk_flags() wants only to perform a VMA
> expansion (if the prior VMA is compatible), and that we assume no mergeable
> VMA follows it.
> 
> These are the semantics of this function prior to the recent rewrite of the
> VMA merging logic, however we are now doing more work than necessary -
> positioning the VMA iterator at the prior VMA and performing tasks that are
> not required.
> 
> Add a new field to the vmg struct to permit merge flags and add a new merge
> flag VMG_FLAG_JUST_EXPAND which implies this behaviour, and have
> do_brk_flags() use this.

Funny, I was thinking we could do this for relocate_vma_down() as well,
bu that's expanding in the wrong direction so we'd have to add
VMG_FLAG_JUST_EXPAND_DOWN, or the like.  I'm not sure it's worth doing
since the expand down happens a lot less often.

> 
> This fixes a reported performance regression in a brk() benchmarking suite.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/linux-mm/202409301043.629bea78-oliver.sang@intel.com
> Fixes: cacded5e42b9 ("mm: avoid using vma_merge() for new VMAs")
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> ---
>  mm/mmap.c |  3 ++-
>  mm/vma.c  | 23 +++++++++++++++--------
>  mm/vma.h  | 14 ++++++++++++++
>  3 files changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index dd4b35a25aeb..4a13d9f138f6 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1744,7 +1744,8 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		VMG_STATE(vmg, mm, vmi, addr, addr + len, flags, PHYS_PFN(addr));
> 
>  		vmg.prev = vma;
> -		vma_iter_next_range(vmi);
> +		/* vmi is positioned at prev, which this mode expects. */
> +		vmg.merge_flags = VMG_FLAG_JUST_EXPAND;
> 
>  		if (vma_merge_new_range(&vmg))
>  			goto out;
> diff --git a/mm/vma.c b/mm/vma.c
> index 4737afcb064c..b21ffec33f8e 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -917,6 +917,7 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
>  	pgoff_t pgoff = vmg->pgoff;
>  	pgoff_t pglen = PHYS_PFN(end - start);
>  	bool can_merge_left, can_merge_right;
> +	bool just_expand = vmg->merge_flags & VMG_FLAG_JUST_EXPAND;
> 
>  	mmap_assert_write_locked(vmg->mm);

Could we detect the wrong location by ensuring that the vma iterator is
positioned at prev?

	VM_WARN_ON(just_expand && prev && prev->vm_end != vma_iter_end(vmg->vmi);

or, since vma_iter_addr is used above already..

	VM_WARN_ON(just_expand && prev && prev->start != vma_iter_addr(vmg->vmi);


Does it make sense to just expand without a prev?  Should that be
checked separately?

Anyways, I think it's safer to keep these checks out of the regression
fix, but maybe better to add them later?


>  	VM_WARN_ON(vmg->vma);
> @@ -930,7 +931,7 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
>  		return NULL;
> 
>  	can_merge_left = can_vma_merge_left(vmg);
> -	can_merge_right = can_vma_merge_right(vmg, can_merge_left);
> +	can_merge_right = !just_expand && can_vma_merge_right(vmg, can_merge_left);
> 
>  	/* If we can merge with the next VMA, adjust vmg accordingly. */
>  	if (can_merge_right) {
> @@ -953,7 +954,11 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
>  		if (can_merge_right && !can_merge_remove_vma(next))
>  			vmg->end = end;
> 
> -		vma_prev(vmg->vmi); /* Equivalent to going to the previous range */
> +		/* In expand-only case we are already positioned at prev. */
> +		if (!just_expand) {
> +			/* Equivalent to going to the previous range. */
> +			vma_prev(vmg->vmi);
> +		}
>  	}
> 
>  	/*
> @@ -967,12 +972,14 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
>  	}
> 
>  	/* If expansion failed, reset state. Allows us to retry merge later. */
> -	vmg->vma = NULL;
> -	vmg->start = start;
> -	vmg->end = end;
> -	vmg->pgoff = pgoff;
> -	if (vmg->vma == prev)
> -		vma_iter_set(vmg->vmi, start);
> +	if (!just_expand) {
> +		vmg->vma = NULL;
> +		vmg->start = start;
> +		vmg->end = end;
> +		vmg->pgoff = pgoff;
> +		if (vmg->vma == prev)
> +			vma_iter_set(vmg->vmi, start);
> +	}
> 
>  	return NULL;
>  }
> diff --git a/mm/vma.h b/mm/vma.h
> index 819f994cf727..8c6ecc0dfbf6 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -59,6 +59,17 @@ enum vma_merge_state {
>  	VMA_MERGE_SUCCESS,
>  };
> 
> +enum vma_merge_flags {
> +	VMG_FLAG_DEFAULT = 0,
> +	/*
> +	 * If we can expand, simply do so. We know there is nothing to merge to
> +	 * the right. Does not reset state upon failure to merge. The VMA
> +	 * iterator is assumed to be positioned at the previous VMA, rather than
> +	 * at the gap.
> +	 */
> +	VMG_FLAG_JUST_EXPAND = 1 << 0,
> +};
> +
>  /* Represents a VMA merge operation. */
>  struct vma_merge_struct {
>  	struct mm_struct *mm;
> @@ -75,6 +86,7 @@ struct vma_merge_struct {
>  	struct mempolicy *policy;
>  	struct vm_userfaultfd_ctx uffd_ctx;
>  	struct anon_vma_name *anon_name;
> +	enum vma_merge_flags merge_flags;
>  	enum vma_merge_state state;
>  };
> 
> @@ -99,6 +111,7 @@ static inline pgoff_t vma_pgoff_offset(struct vm_area_struct *vma,
>  		.flags = flags_,					\
>  		.pgoff = pgoff_,					\
>  		.state = VMA_MERGE_START,				\
> +		.merge_flags = VMG_FLAG_DEFAULT,			\
>  	}
> 
>  #define VMG_VMA_STATE(name, vmi_, prev_, vma_, start_, end_)	\
> @@ -118,6 +131,7 @@ static inline pgoff_t vma_pgoff_offset(struct vm_area_struct *vma,
>  		.uffd_ctx = vma_->vm_userfaultfd_ctx,		\
>  		.anon_name = anon_vma_name(vma_),		\
>  		.state = VMA_MERGE_START,			\
> +		.merge_flags = VMG_FLAG_DEFAULT,		\
>  	}
> 
>  #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
> --
> 2.46.2

