Return-Path: <linux-kernel+bounces-527436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2B5A40B25
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 20:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CB3317E860
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 19:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E1620E717;
	Sat, 22 Feb 2025 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HKhumtlX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yxfOLYKK"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AEE1CBEAA
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 19:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740251546; cv=fail; b=YXZXVOi/LQQY+Cxam3BvgLLDLJ3nG+oG/+FSPTedJij4Z4ECTziGFDtD8J06Rbkd57/DzdQTNw/ZRcbrjR9mY2FAy6dnlDMdg1ZHWeU0SBh3gda4ULjpzZ/jOPMlcy1O4Txq13UB33e8wkJFDWUcIK5uNgZT18w7NxlKPL30A6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740251546; c=relaxed/simple;
	bh=pRKeRZxRngSPRemy9oERgL+sWlz0s98yIyc4QmsMKpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jOO8be2CYevcFBy8axM5R473+O414Fjdhj1KBn2+dAUPP3aOmPnqEGA6K5YfRZaHbixI2GRzJcLY7uQyRCsjxtpDcxBke+Cbt8dRiQVBDnixjjrdCLFyItJRpKF87Ke3g1+H8QkhwNOYstQSNSkOSuNhOZrsoo6l69UNnbLU9Ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HKhumtlX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yxfOLYKK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51MIeHnn015222;
	Sat, 22 Feb 2025 19:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=pRKeRZxRngSPRemy9o
	ERgL+sWlz0s98yIyc4QmsMKpA=; b=HKhumtlXMpQ2tq1rm0YfSX/67ObF7c5nz9
	Lg8GFxb4O2ZelLZD6OX+NxV5TlfT9BDeFfwFVGHgxU0GWyMpA3gZBXHfFLzbsDsw
	hinS+1fHlcRoJnIKdpc+Ew7d5C8BzZbOvDVQSs3V3awcMJ2Ddi3IMXbtNQCV4EqW
	vq86nB8NiFYpxED9/G/R3xhcDCUmz0R/iN93rkdiapGxvktq6RKudF/e4TN9JYrC
	N9axonaq3EeoMMvlE3ugJNGWhEfYGNiYRIE/9Jaf4VUfH+062aDfLbZZhGDcQ7TJ
	OXs+qEHqQLUyL85jbhrRJnXhYhNL1BlH+ZNAirA0hNKb8YOnTS/Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y66s8fh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Feb 2025 19:12:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51MF8X2k024543;
	Sat, 22 Feb 2025 19:12:10 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51688pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Feb 2025 19:12:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njNVFghgHPB6s6oIlsJ+hEo5lhqfIk/izkXzwPktgTFX71Tnf/4b3owhusO1VyabGQYD53dQETBf1oABW3UePgKau67vjltFlMuQ5ICPiZHaZhYNbLnxvPSqXDv1IZWJW9q9AOyMBl/Lih3qDy6XmSGCXjgFuNq+NCujcZtkSC+a1oS2OBfngy5Qe4pgWlLZBmuaTwOQgDkWk99QFK6J4Zon/9yZwxhipIPow3NnQ4batkbxFHn9EA3DXa+9714EwkTtOVsQneAvqxYlR5eAb043PUSb7Io8EbIW+DeiJ+ckbaWaRS5XQRFxurxlLX71MhGmizoHUGC/bFcge0nH8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRKeRZxRngSPRemy9oERgL+sWlz0s98yIyc4QmsMKpA=;
 b=f0tS1n7E7wpzS6NeEGLQ+t8RlrfFFZDws2pdQzIWbjxJh3G0zD8++8PgRYpAzzAuoFdmldn2EvPHNy3AL+/N+3a+aKnknM9AC4Bo30rFKLPSxcAo+cIm1T92YPwrjd/HRKtqIQwV4zSxrMZWl38i2HCZfOj0AcILlLDcUSmfYh7SOyFUW1at/iLOy/wU2XqfQJEQrDlYPCo0/vAX/oBFmTdd77RNxXXVxdAnVncOt4bmhFNjxltZJ29SufW/pkKMbDnCpE2eWnTWha/lvnKMFgcgb38ItWPWkDgG18zkZcpiByS76SxJzAcmAN2sxqpMUcZk7gylf0jLX4hBgLxYvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRKeRZxRngSPRemy9oERgL+sWlz0s98yIyc4QmsMKpA=;
 b=yxfOLYKKgAse+fA4K2GlZvxiHrvjeD7+bR4VVjj8ReW87I2t18s8RefAj+TFuExFwwmH8EUtpcs0iPr3dowq6FHUoQXrzk6wR5KH8IryOPxTwZ+1DSaCnSIaPF7ze1SqRgPQt6EY71ZdiU9QVgF7vhrr+GTU5aHM2v+I7UZWDyw=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SA1PR10MB6542.namprd10.prod.outlook.com (2603:10b6:806:2bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Sat, 22 Feb
 2025 19:12:08 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%5]) with mapi id 15.20.8466.015; Sat, 22 Feb 2025
 19:12:08 +0000
Date: Sat, 22 Feb 2025 19:12:04 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Guru Anbalagane <gurua@google.com>, Wei Xu <weixugc@google.com>,
        Yuanchu Xie <yuanchu@google.com>
Subject: Re: [LSF/MM/BPF TOPIC] Physical LRU scanning feasibility
Message-ID: <947c153e-72ff-421f-8042-c636c196b831@lucifer.local>
References: <83bebb7f-f157-4179-b7ec-b25b2ee4270d@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83bebb7f-f157-4179-b7ec-b25b2ee4270d@lucifer.local>
X-ClientProxiedBy: LO4P123CA0098.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::13) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SA1PR10MB6542:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a364269-a197-418e-de21-08dd5374cd18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?122VsPmxD2aTQ+5tYek9bJhvP5lumQFsCxufct4PFQts3vYVMwgjZAVhJBon?=
 =?us-ascii?Q?HQcj1y3kQ1CblQSQUr17i3LJ2yJMUxEdfM9AMQtg4LGRjJQEiu4NjBhhh2z6?=
 =?us-ascii?Q?9yBFc9ewE+GKXSgDvQuflsjjklxy2FZf21qAmLonSmGC2BYr2rsQ4ztnFuOK?=
 =?us-ascii?Q?QCP8d8nvcRCONwCpq6wg77pkyprEi6nhLgotWtwah8MvPuPorSUKlpuNariR?=
 =?us-ascii?Q?2STOCXz7ZExUVdaFYEtS6jQUgDdNpAMDdfak9E308ZJ04QWqWrGVDOpWgKfO?=
 =?us-ascii?Q?sIsDS8nVbTynsj9gMhctPiuafjR0W99d8cQqUACRAFFJ6ZDisQunFEWK+06G?=
 =?us-ascii?Q?Gwni20ZFuEGhw4K0b7Tii5bjnY9RgF/wE1sIfuOAOCp+TccN/rgZFD9i+Sj9?=
 =?us-ascii?Q?CJsvn9nJaJKhWl3SJRFe1Iyd6ulIPtNgHavv2GNSzZrdNWUpz6aeNbr8LmH1?=
 =?us-ascii?Q?9Gl0dFkt1HNvEKBhpApqtEn5qYTKW8/P3KPwWWHtmL3f7/LELIUZ+DKnHjL+?=
 =?us-ascii?Q?vSG8zyqXXxvNdmaCDuh4KDhrlO9wvUwcPLYxkVsCNQ/2Js8xKk71dbRgSHrT?=
 =?us-ascii?Q?8SPVKHYQLHOyVwp07ZgFYyJrKB6a4DvCAzJ6NVvTevvH7VkKMwkFp3PQNOvL?=
 =?us-ascii?Q?ylK82iyRmzHAgHIGS/myyfN5f7hfrgVtLv4bEB/59T/mqAIXlOQsCQvDtfw+?=
 =?us-ascii?Q?Bn6CgsDOk5lz9hB+J0rG8vBjxUIJN17FERTB7FVKp94OGaKNWgD0PEfIpGEj?=
 =?us-ascii?Q?4tsUyEKfLIzvZF6potMi7eVqnyfr49YlHLb8BunUy9a8BBypWT5zf34SLoNQ?=
 =?us-ascii?Q?5YIipSKIYSAj5xlf9ZmcUWMF9AXp7RpXoV7PDVvjS1/rOBr/+X7dkJmiEqRN?=
 =?us-ascii?Q?v0z3v4wvp+7laQALDiUy7ZXzk1mw0/tFdqUal8At9EX2tz1Y4HwtboBj33Tx?=
 =?us-ascii?Q?2ZML2YPD6DqKoKW35O4D/R1VA+KSZu7C/gg3YgfZZT4BWJ04erF/0duKr3Xh?=
 =?us-ascii?Q?CT55wVyj7BXNsQ8cUwfjTpXLbNO4F1f418w54NETbP5zGxeJdZzGHX6noILh?=
 =?us-ascii?Q?syYuyfjyKvyS0syVdoGTZPUGksVGdPr9ls54TtWhRy2aCaYehO+r4RdvrNfR?=
 =?us-ascii?Q?85X7HZ0RlzLFtmpnJENhqDnkxWL0fq6xujY9Wy2CNPQ2F5XceHBE0ASdb0IB?=
 =?us-ascii?Q?fqQBS6sc6zoiSikWIUv6Fq9MzZb52OTQloju5ZDKhmXCzeDeYYvwFqgIbGn2?=
 =?us-ascii?Q?4Tz6Iu24tC0F4W/bkZxz1sViwxidCuwQeIw1671AdhQtMm4BTBh9+L5jQiBe?=
 =?us-ascii?Q?SM2KEG085uXkEobbPiQOLK3w2iqnECB26LEz7hz5uRvcYreK+gCz46G5BTC3?=
 =?us-ascii?Q?n7DFI96gZ06EWTIhT4p6V/TS0PFC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bZeuD1aoQMX5xc9pYqaPMj2CT7X0Sqq7u/h0pl5uR6BLizWUjd7yrYqojrkS?=
 =?us-ascii?Q?MX6SC/YAsL9jNgmErsz+su+g30y0p9mTj6P5YsXusASgyrAecIgPMTvpSycq?=
 =?us-ascii?Q?+lherNDBsSigbJmTr93OeJsm4eiXhGxnYEiOYrxt7MKwDaqjgwmNMlWx0VmB?=
 =?us-ascii?Q?scXaq+6xp/jIW7J4WkWe0YvfRrPI27DMfMlc6ozEDMYaAdSD3hjrbR2xB96M?=
 =?us-ascii?Q?uvWV34KLnjTndznMY3hLGX5zsjXHnCsu8/eNw3vaQFvzz6LBGUcx/ASU+0pZ?=
 =?us-ascii?Q?ELFNgwQOWjGt3GoqecToAnybI1RBMGl88MmBCy8nUZ+PuT4ytqyJRjnNvjeD?=
 =?us-ascii?Q?RYSJ5QrSjYsDduz5kw2wXuakOAhTtTQBugeVsOsVKtGJg72KjADQ47xRmskp?=
 =?us-ascii?Q?UxrTZ6QDmk6t+29S5GsnJK0wNPqR4yciBmzdG7cPwnIxqEgS2J/in7ofArYD?=
 =?us-ascii?Q?tE4zoo6gNwpReFsTc9PdXXYiubRd0IIG+R+J+FjHnTzPkTom+q4FNWeeD8xh?=
 =?us-ascii?Q?0t9jcfeKis/nXRiqfhHQXi9GcVZyHfSxTjcUIDZuU0WPzDTh2wHkz3yYxwxk?=
 =?us-ascii?Q?ZjfjNpdE4CmXyCNjVUXwWwt7er82jn8mC3Q7Qn58Iv5OGMDZtEb+w7zx92y+?=
 =?us-ascii?Q?d8OSBsMpArJaUuwjz1H3ggpqPulTB8ke2nceFcVdG6JeO9kUuBn5t+F6SPFD?=
 =?us-ascii?Q?KWRq/oqsbRvHycPNPj5NLQnM9ktZ7cXGeI4Tfk+CtSkPA7Xs0Dtm1jwBKTKv?=
 =?us-ascii?Q?rN2/PlhpOuvZA5c1y4appRlJepj8ocirTAh6p4GOhXy8Uk0fFbdHlO+8Qgt2?=
 =?us-ascii?Q?DWK/IRz1+DBL51zljhPaN1dgTHP5OjDM6xxuDLC1SDD4DRghvbcMN4km8Ltd?=
 =?us-ascii?Q?MM0M1PaqavtT+7LAcj14GGkU9Qxp1DAcTRGTMMZddDUnp34ROzrqmA+CSSzS?=
 =?us-ascii?Q?cKItQOkF5QaxIEy8VH9wLSiZwijzcSVRyIt67Yl8AFV2S2qlK8PHy5jM9N9y?=
 =?us-ascii?Q?eYq3Pss+ZMUJGNv97+zEU2pB2gcJ5MnMLbrW//CqVjNSsfki2FK0tp3rH0tz?=
 =?us-ascii?Q?xEil9FnY6O8Sm4l4yJ8+NigV2VEj1tmWer1FiT3rLXGBegPY6+PtHz9zwH5X?=
 =?us-ascii?Q?bZbdqzfvJlEAI7PSRwRcSy9ITF9P6kCteloOtdtGirNs/LpFo+97cbykOsJN?=
 =?us-ascii?Q?ichDUoN4mskiJgGl88uP52jXrP5rGcKzC1lpIKsqjepHqh5BjExeUJb/bJaY?=
 =?us-ascii?Q?pDbkHhIiixhFHcWA2OzkLSimK/Us77wSz4kvPLfbRCdKP5gLZ0cyfHWuz7Wa?=
 =?us-ascii?Q?oVHEmVuHGqJuS8V3Mk4dhEHpUVMarvbg2g49a0qsQWpQ5h22ZaPWnxEQ56sV?=
 =?us-ascii?Q?WwCUBeGkx0EguBUkrud2eeE7b8qxP6kCLjr2e5sskank8x7OSv1xjyQErGUg?=
 =?us-ascii?Q?GLHrnvdIJFekA7EDbyO3EpN9OTV0/mTgCMh/mZ6Y4U1sKVW/tSMtd3CiyQy7?=
 =?us-ascii?Q?b962kst2fSxl1brjLwPPJNdDySSuISo3iqRHjxVWatsTvvmrjI4dYqC5D44O?=
 =?us-ascii?Q?BfQylQFVGwdlOw56iusnd+lAz9mzNUeasnh31H4cVC2fcRz7susLVbmcwbv1?=
 =?us-ascii?Q?2g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xzKu0WB+VruAsuifp6gCTaW4OV+ketrPn7iRrtr+xQtx9HMMUkyg4VYI0c/za+HBiQKac+Jv2UM6+wux+mW9oQfd+Cq2VuBZJetgJkuarJtCGjlsx/vFBmZBFIKuC8bWOpEvIR0WY6UXT5Ap4o/K+G7MevkVcCKbBYsXmR2nc0IHtWVGaPComq1J0HbzLdzCaYN56/vhbdSfQA71XkYrgMHPhr01bTBGqaDZilLBsOORPx5TkaY3iBuVEO/l1bh7dUsUX7pKBtf14L906Ol7qTAhyrJ/P6iEBAMMpilSiOuR+2WDT4g+0UEJFK0/FgsmVOKa7PkdElc6rkqE45Fc9GJKBwSJcOdOB0ACG9IWhV/KczDFEyN9a46kjnFB/UwI/U/vhqtCUsIcZ6DU9UJzjNEibfkUa3K3AFhdZKRuyVFW4O8fmfohzTbqDah9KJL31ZwF5lMinCFVgD37slgF0sAS6wHsU4Tbow17DXcgXY+ZlyRSSPFElJnICaDG4OQ4xbtqraefpEY/cqX177vZfzrf0n6Bc5kwUcI9dp7P8+uP9oUKDu3Nfgxfs1H+nqnvl13aStIL/Uzw18jNAFaCtJin4VzUorPubrNlFlvWGVA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a364269-a197-418e-de21-08dd5374cd18
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 19:12:08.0080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFlhIEKAjGIXB139pE9ZW80klIz5NUWPLaJnLD6fVZR5QEfpRhgSF1BO7bTv9KJgJFF5hCwqaTf+zlWKrkHog0Rv+u+Y51IHsyV+QcVjnBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6542
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-22_08,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502220152
X-Proofpoint-GUID: pxksOLBikVMhWH6_ipx9oTyWtjLFWoAG
X-Proofpoint-ORIG-GUID: pxksOLBikVMhWH6_ipx9oTyWtjLFWoAG

Hi all,

Apologies I feel I've bitten off more than I can chew especially given
current workload. I'd like to focus on my anon_vma topic, so I'm going to
have to drop this one on physical LRU scanning.

If anybody else would like to lead feel free, but I think this one is
rather too dependent on my providing my analysis (which unfortunately I
don't have time for any longer) so I don't think this is really feasible :(

I may try to pick this up in 2026, and perhaps by then it won't be a
post-mortem of a failed attempt but rather a discussion of a succesful one
:) let's see.

Best, Lorenzo

On Wed, Jan 08, 2025 at 09:46:31PM +0000, Lorenzo Stoakes wrote:
> Hi all,
>
> Not too long ago I took some time to investigate the possibility of
> scanning physical memory directly by traversing the memory map directly
> rather than the LRU linked list.
>
> This was inspired by a post from Matthew [0] wherein he demonstrated just
> how significant the difference is between traversing arrays of contiguous
> data on a modern system vs. the almost worst-case scenario of traversing a
> linked-list.
>
> I tested how this might look by implementing code which simply traverses
> and filters the memory map for LRU pages, simplifying as much as possible.
>
> However no matter which machine (ranging from 16 GB - 192 GB) or whether
> virtualised or real hardware, I found unfortunately disappointing results -
> the act of having to scan such a large range of memory resulted in
> performance significantly less than a typical LRU scan at low memory
> utilisation and performance at best matching LRU scanning at high memory
> utilisation (simulating higher memory pressure).
>
> There are a number of factors at play here, and perhaps the shrinkage of
> struct page (allowing for denser placement in cache lines), or an improved
> algorithm might lead to more promising results.
>
> Having discussed this with Matthew, he suggested I put forward a proposal
> to discuss this area in order that we can learn from this should it appear
> this approach is unworkable or perhaps determine whether there might be
> something to this that we might still salvage.
>
> I intend to do some more research and generate some more specific numbers
> (feel free to give feedback here) before LSF so we can have something more
> specific to talk about.
>
> I always envisioned this approach being somehow integrated with MGLRU and I
> wonder if some hybrid means of integrating this approach with the MGLRU one
> might make sense, which could also be another area of discussion.
>
> Thanks!
>
> [0]:https://lore.kernel.org/linux-mm/ZTc7SHQ4RbPkD3eZ@casper.infradead.org/

