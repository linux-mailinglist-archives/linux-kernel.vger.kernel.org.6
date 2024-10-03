Return-Path: <linux-kernel+bounces-348822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E81C298EC45
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16E1F1C22FFC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E44114659D;
	Thu,  3 Oct 2024 09:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UdyTKh4F";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eoKLZaY0"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8585F145FE4
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727947652; cv=fail; b=gVccqgCsMFvTzYhH5CNopmRMuFqgf4eT+2G3hQT6QgOCJ1DNT75Zaekbyhyai2tic3oh69kjy323KYXnaO131cVeGQ1N4rF/W5V+08Up6xQeYJi3vDKlj/HKnwDhZ9mvjbD7LPpRXK9BYzw7ZxMwj9UWcrA+DZaWROaPY7EB6DI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727947652; c=relaxed/simple;
	bh=EhlESjjId9/88xYjM8kkUS1sxULIKyOMqVghl5lm9Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uGOcRPEey8/dKXEX0WPoZ4QWG4aY8jjRJVMzKaE3CG+GZhAo++iSSjk5weqXmGFElYcXqz2WNelZOt8Ydtya6N6W1oju2UZeJdQgbZeerfUQDkxCicnqcBg2VyiAf1xyW7EdwAY123YuxiZiGzWNOTaXLkDenU4ssqETnTaPjB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UdyTKh4F; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eoKLZaY0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4938tbOn024366;
	Thu, 3 Oct 2024 09:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=/kHzFSZntW3u3Me
	H+hv3fin8yQwfNNdptkmi4ljgU/o=; b=UdyTKh4F+n/kQALvOoSD+dgE2/X1Rk6
	y7tJ9FaoRbLoKM11zSZ1GPpS+SUyKpKWN8HZnQIuGEXH1VtVXKRik4b1wFN83Sn/
	63M57JlmXhzJ2CmLAKCalJCZb+XvMSfDT/HvL0QPDrH3QZqc+0wiv8+B0QZEDBaT
	7xCuodPNmcGFPpmVpEJnCAqxo2v9UojoWHV8y+0SHAOSqdBkTl89wGQ7L0/LhFl6
	54U+Takg0iECrXc2E/HCxOi7wsTu30LEw5dUcuY/Fp6ia05fRMlNfjqWaBnEFKh3
	SL1P3Fgb5Nn3XX0AenaiO86KzAcJcoQhaX57pHzKb2I6pM6oG/NoLzA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41xabtuj2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 09:27:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4938cTxn040473;
	Thu, 3 Oct 2024 09:27:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x889xexk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 09:27:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/wp1tlO6vWnRaL0gUWK/USAA3eTdSXt3weWyg26LITBN440GRy+Ca6kqGTrTD6ayUb7gUQO6AVwT43d9iZd3g8DYrHp5D1s9EYCJsxpg26SeYRomNxpAWMs/N9kv6QHNEImSd9pnu6XPtjtwuGgHaLUaGnavf0Uafkvp2/N1oHOw/crH6yzrSHq9KNCtfake+R34nh7VLlqxNR+xS/07oiYfvQ4QgLXrBnkyd9JqXldTijPYLHBCfluGnHhM+ygYabUtOyxqKJ9nLMsREBcFzmk825J/c69zli95sryqspTUiVwD2ZitSMLlhW75NFdeyzl6J+vp00bVaa3uwKtmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kHzFSZntW3u3MeH+hv3fin8yQwfNNdptkmi4ljgU/o=;
 b=uN1LFUyyuFtl7wbuPMzFJnv0qjV+p6h84GLFx3WR/AbCpRK/KyUNJ8PIN079H3WGiRZuJcYTFHvJr/RpFs3Ud2LNpInyeJb2B8Kky6FSYXrnARwRITCEpiR819SRLNFX4kO0pKGJC0gl57k7c7y71LCUQ1fVxTEgH+yG5igbXKIN75YuKA9XTEQOScHrspk6kH0wZOyISPxegkLgBrOTSGeFDHwdW2DPuNtpDJ15iU7iqoEpJ9omyTb36Adt+5PmfmVZKqEymSlKiom3Og93tVmciLdkj42vn6/FHMpFWCnLj9S8V1WPB+d1Uoal8nqdaO+iZb3z3Pb0XbxmyxlGVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kHzFSZntW3u3MeH+hv3fin8yQwfNNdptkmi4ljgU/o=;
 b=eoKLZaY0eNfYIyHXhcfihITi5K0Nxu3+lTj8CSzLHp9XgSN918F2lgyIkWnfkqJnp5WPuGiLfnQIG3ux4uc1li8klZAff/JYw8RMh5ZJhgjs6hZ58hTs2oEsDY8paDbaz/zF9vA2BcIuBqTVIvD5ix1D7GGpwFwtz6ORWEX9O5w=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH0PR10MB4744.namprd10.prod.outlook.com (2603:10b6:510:3c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 09:27:19 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.017; Thu, 3 Oct 2024
 09:27:19 +0000
Date: Thu, 3 Oct 2024 10:27:15 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <06d9be5c-1e4b-4344-9dcb-2000429d8b72@lucifer.local>
References: <20241003085914.2957-1-spasswolf@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003085914.2957-1-spasswolf@web.de>
X-ClientProxiedBy: LO4P123CA0429.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::20) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH0PR10MB4744:EE_
X-MS-Office365-Filtering-Correlation-Id: a78ac547-bc49-4975-6676-08dce38d9401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7JNZYpQUfWVyzt81/TnLWPyONYKPoiGZqjvk80h5s8lRDieCfnHhHAwa/T88?=
 =?us-ascii?Q?Se6UOXGsVaoG5fSQT4/JVr/o39CEilZ0hOI8BkV00WzIuQrrlJ4UrV7aGll0?=
 =?us-ascii?Q?zcqZXVXs9leNnIbcBWcL9PSe4lnWBbcOCVLS7XuqgwVJH84Mi5i7PNWMOilI?=
 =?us-ascii?Q?En++D8SPwM4vAOxJ8kcAr96pN0TeryIi1bCV7aFeRHLbjYn8T03O9nfst+b6?=
 =?us-ascii?Q?nbVxQ35joA2dqJ8tHB0BXIRsHndNk8t+DbK6Wfq2X7ns/p+GlpyQ+YE/3h21?=
 =?us-ascii?Q?tvBRPhSqa40otqzSmhQ8O8qsP7FUtLg454dW0BsXonfDsjy9AFOeY7O6CpO4?=
 =?us-ascii?Q?V/Asfi+O54UxxQcdpVyfHYxkdnce1KUsroDp+OCSLiexeKbn+ktkPFmiJVx3?=
 =?us-ascii?Q?d+N73YbgYhv1Cfmq/uycuwKBOPk2WK/PgQPeWKTn54gLlilV1wrR9+elz69i?=
 =?us-ascii?Q?Zru0w+sUQhZC1smop5OMrbFQqgME97wRphlj+nxNzZx1j7YrBgfuEF0mbXhp?=
 =?us-ascii?Q?WqsyX36m9CjJgE+RhlEr2lygQ+BO9Xcb8eo7qn1VHNgPvmSJPNrV7BFSdN58?=
 =?us-ascii?Q?Aguh1b3KUZex0a3xFULubrdTSOJE+BPhkU1GxXhCcVrO2+M/3s5Yp/tNjqg0?=
 =?us-ascii?Q?upHOzdyF7kTG6WPquqJFapWl2EC+YLBjlf7gDsnVgKRYIVnuThtyHJljK68Z?=
 =?us-ascii?Q?nlwKc0BsgVZKp9ALmXwkyDwmUCqYgea1VaKWq6ydRGUecL11m8E5qNPnCOeR?=
 =?us-ascii?Q?aPsu5ymksUtkkyp7KNLBtPo/OZnK/kRZYVMyQG3CvDm9Q7b5L0M/zTG7jRq/?=
 =?us-ascii?Q?EHX3Pwu0Xsl3JmfkmwdqBB9doSSUzOZK8t3Rl4ZvyQcOsTgzdJGt5NMi//si?=
 =?us-ascii?Q?v/Otw2fzmJdxEyC2B21R1rcUM3ebxSoOuNvkvSYJzrWmND4yz27MPt4/FcbM?=
 =?us-ascii?Q?ycpbumHDmsPPoCEBBrZwpIGyW+tJm7md5Xa6HX0UJSaKLk/pVce+JRwsbNUT?=
 =?us-ascii?Q?5oCONdNtY9BmNsrtOqO2OzyFDTf0zYsAT2Vb+4WSgfXwpBjj6FCPPpdzHr56?=
 =?us-ascii?Q?i5yEW6R6VYbYEbZamU+VAzFPlrTRfu6Wnfhwf7l8P7zJJHCxkkrYsc2OUbXc?=
 =?us-ascii?Q?0uXvkeSLNlJgcG9uGaRsQvHgcydPlqo3RAwnaweUlmpHDHuIYnttLP01nBzd?=
 =?us-ascii?Q?xPioBZpuvVZgPTw1Wj9LoCYu0IeMf1f0rJVRE2bGXlyDMGHuVU22i8MHl8BG?=
 =?us-ascii?Q?thxPRW3cOxSZRJxOyoPHr7PrH08oziJCsjPAtL69dA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GcvgCRTqFDGoNBgsh8fulHsWyc2t7ma/lMbcGriukdyJ9/+uCRMHFcqyRMFO?=
 =?us-ascii?Q?pYJPAWwJxPl8ubZylYIu24iK7ITNqfOooepmX0X8kGqvza2MyofDM6bfDIho?=
 =?us-ascii?Q?g5yE5jRINAvATkAZvBZ5py0tIRSPNgBshfnEcWeSf2RnXw5mHgl7lA5dlLKK?=
 =?us-ascii?Q?fxpdl9g0E3B6EfIRN8Y1jAn5aIftOTiGtE1s2OrNGHjPBEIf7OJx8dIpEqcK?=
 =?us-ascii?Q?4vCJ9tNszqL3sKs3Gh0BbJKHWHlmDUcUPHBWNZwaF+W+Vz0D1FKY7tzMzTgJ?=
 =?us-ascii?Q?fCYzTp4U0MDFLZ3ZTl55t3UhWyvL4O5ixqgjieogB6TST2lokAczTfm2eOdZ?=
 =?us-ascii?Q?EDEO07WfJ9EdiUDt9qaGJXvNTGUBUnwHm9HQASMGzsI3g16hLqLOnSJqhWMm?=
 =?us-ascii?Q?MIG5Xh5D/6MV/BqfTeQOsuxI0i+DXRvDAUDAu0jThTk5YduRkNK/CpiV6bQJ?=
 =?us-ascii?Q?h5GNWmBqqmu45ejsclBIPlAwsxNgi+9DMnK5AUg4gDnisYDfI/kbbKvbKiUg?=
 =?us-ascii?Q?xunKTeXfJNA8olWA5MEXx2Ve818ktPnxOf5FyGb34+frHHP8GS+t0UKYC5Yk?=
 =?us-ascii?Q?znZCzJpKiJ2dK1AHjiKYuXIJ2eneuyQiIsnbzJO/55TMZyT8cvAAZTAHfOsS?=
 =?us-ascii?Q?aGiJIbqz2NG5+3yQSIOSiof+543ZZr5vx9+zq+TeQ2Woe+MQAx4kjGCMg9/S?=
 =?us-ascii?Q?q/kVYGwfu0i43SQEfOaEUymDaxj+BQh95nbtB35PF4ENEQo1D88ilDFKlWlq?=
 =?us-ascii?Q?VPlWWTSgm0J65dBtk+ovDMAa8m9F729s2VMPN/xFzECFzPFPjjlXDhdqpEG6?=
 =?us-ascii?Q?XbrAfAEvOXsrRDM7lNCSjVCmYPMToU6pU+JznlGjxmUInFT+V3QLF2/WoeJN?=
 =?us-ascii?Q?3PDFaa9btqNLXdzAff76P/PVHMGUBUidcNwcTcdJXUEoZ9ch7ePxxSQh32hC?=
 =?us-ascii?Q?KLV0wj/xo57Ut83mGT7+8sElio+/5sOGl1VCbwpwYUfcj7JVMd5AS08gw7oa?=
 =?us-ascii?Q?ZOOsCbtow2JE+gVx1v/ZseG+YfQ+OfdNJw+D4PSrJcU2GBD8jUwWPH4c6KnV?=
 =?us-ascii?Q?vCUhUTeJ8j3ByF4kHkqodMImHJZjdff0niHVguRuJ440aP18veeCeb6NhCiw?=
 =?us-ascii?Q?zHGSm5yLfNZ20KbT6J0AP/g0VcTqJ4pescVDgd+67cP6oDBpRM3YeN54VXLP?=
 =?us-ascii?Q?WbPE6zm6CVbKVGH4ZZkGJLFVH6DgEelKBfIt5v3O7zkJ56ZPePrUBKGqeYlo?=
 =?us-ascii?Q?Jt+oHRPMXI2t8t9OMXlwcn/FPCYHXsly98wqJxcU/V3LZbvN2mALbkpxwXoV?=
 =?us-ascii?Q?ogkVMgRtYeWUVskatNCP6HrboKxEg4Kqlz9cTy+5PovATKC8kGzgN4aEE+Hz?=
 =?us-ascii?Q?uVqqINCE3KsyCfZ2DBT9k4fZ0L13AkW1e4ly2yKNwQ9KC0E3KRTau4wUphl2?=
 =?us-ascii?Q?WCHwB0e2S+K9rM70piq7lbxIN0m10wxkuKUraP3igshg82oUZyQ/IFlUGv//?=
 =?us-ascii?Q?wlVx1x9lX8kvrF3GLiKZsi5uoDmfsbInrTYOp8yugJdbH1J0dwimTlY5NKTe?=
 =?us-ascii?Q?hP6wyIKhRotGJK5qq0WSE0ztMOQwZItXDQfhqYGrzDCTrcUDxZyq2pXppoTG?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ib604MSqGsisEUYPnCeCu7Ok5Yusrm0xL+3UsTg8lVFVgya0mlJgSrKYH+yrgQujLbdzKowSRhJWWTj7FXdT6EDBSw0I7xb5R1Q8m1EYi/rEITbEd4bL1tF+VDDbkBdlUWSZl/DiRQY275InP5n4rPUhCYxcVkjWHYwT3HbrfDNNt4uDz+Mq4Bawr5mVsqlEetcOvBN08iubRS1LBH1OyEcA30aV6so5bH0gFRt4c6ymlvxn8WRBuHtlZ8JF8/rb7kFZvFscd9auYreraqyEQyMe19uuls7kvdtoNEUoGP9J/fvaYMiu0XchSvvvQF6MPsiGKtANHkcdOSQWxoHe4+dcyo6yPeSRQkFvhnzAM+V0SHG/IJFS4C2EZmJD4tdDIz013h7pyy+KRyUylH4ZQg7Y3ojmXE8go/UKp/1em8MRSbneHjDIq92MjRs6gZxkZwdpOY0rYYHKPaIcM81u9lb55uDFPnzhHTr+DINMUjqzGUp1vTYcGaBzwVaXufp5o9Wx9xlP18umKDuaZPDqN+kKaQoHWdkqubkF98V3uDgkYoREQe4f0J5xUuIFz1TNcTYQlL2+N92IBKptLqqurEgwS+wIjs3fAvQ/HGZ/bFM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a78ac547-bc49-4975-6676-08dce38d9401
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 09:27:19.3831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cM4zOJpZZgcLLryjLnFRZa1tRqSN0JNPcI+7XZPrsK0o3QMMzgLTcnSQJ4YGprUQi0dwRoUGSf5bRP6OiVt+xuXKmF8f9zfsjpfj4eHLfAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4744
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2410030066
X-Proofpoint-ORIG-GUID: W52bHjEE4z4aLIzYcBDXRRMxQQinsYoc
X-Proofpoint-GUID: W52bHjEE4z4aLIzYcBDXRRMxQQinsYoc

On Thu, Oct 03, 2024 at 10:59:12AM +0200, Bert Karwatzki wrote:
> Here's the latest log.
>
> Top three commits:
> db8adf7c0a23 (HEAD -> maple_tree_debug) hack: mm: see if we can get some more information 2
> 7e3bb072761a mm: correct error handling in mmap_region()
> 77df9e4bb222 (tag: next-20241001, origin/master, origin/HEAD, master) Add linux-next specific files for 20241001
>
> Bert Karwatzki

[snip]

Sorry to reply out of order, lore breaking breaks a lot for me.

I suspect the previous 'fix' won't do anything actually, but could you try this
separately?

Thanks!

----8<----
From fa92124d754f52b210d4aafff779b512b78cbeba Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Thu, 3 Oct 2024 10:24:47 +0100
Subject: [PATCH] maybe fix 2

---
 mm/mmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 621109f869d8..e49add0bbf37 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1407,6 +1407,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		if (error)
 			goto gather_failed;

+		vma_iter_config(&vmi, addr, end);
+
 		vmg.next = vms.next;
 		vmg.prev = vms.prev;

--
2.46.2

