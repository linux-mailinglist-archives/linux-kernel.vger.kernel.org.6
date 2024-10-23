Return-Path: <linux-kernel+bounces-378334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D009ACE94
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9570A1F2465C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82421C3039;
	Wed, 23 Oct 2024 15:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RDP4Du4/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gD96jfPm"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3DC7404E
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729696937; cv=fail; b=sh9wZ0dxUAR0i3aDz16Z1nE5xxzxmn4bz3LYDtCb8cZT3mnWi+ERRy7npG5PmnZCJeZ/kxaDRB/GmE4JxRbYYEnhvy5fsmYHL9pwDPOQPUFajuIefekrqOA12mTcy65ZKSXf1UX53vg1VJAbq0hErKob0QHDWojfI8SE4fISneA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729696937; c=relaxed/simple;
	bh=+B0aGOlh4fuBaiuJX0p6L4SdL+YisSNtRhjtXQ0fd6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=suJgrktP2gASqqq96WQEgKfztvWBl+P5BAwA40vKlusOhGhzQeW7rrxuJw7ZZVqJpdWz1E/I9KY0fbVqlmxrCodGf6FLEUpkTC4rDhEcrJWhuV1vYMYcDeLy9To848UkweVydl28iMCrD30I64CUrFHP2qyVJhSjfEw+IaatM1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RDP4Du4/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gD96jfPm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NF0bqg024011;
	Wed, 23 Oct 2024 15:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=efZESsBD+UTdRzMZgR
	tgQav1srEQxsfPiOHcBk/St04=; b=RDP4Du4/2LC7dYyn5ZhjLakX7rx0CKEFWy
	ya0y9tPbK2DSorAI+EJR1GbYms93tU+MikWJsz2YcXuDi6gy/CzCg0qe30R+UAOW
	L4AbFR50dc23UjksUXGRaEM1r2DGgwk8bo+a+dBdPkWX1MnhaX7PgiMq3ZwAnW0t
	GkqQdN/fuIuEp3uW6tBREnnVXGOKR5bJ/3706p0A1h7F39Bo6RVX9xX1SIkIF2Jl
	tj8TCI/3liQAY5xxJPzyVgoU5WzmRCw0diZCNPZFr1jBogWziWwb6H8osqK4TVWW
	N2JOrN2OK9TEDYOTuIliMJb+SZUNlPD6MLG0fAJWqGuRcCkS6yKw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55egaaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 15:22:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NEUEEP027391;
	Wed, 23 Oct 2024 15:21:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emh2ymvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 15:21:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7X1q6nQSMLo6lobuV5YUSK1vZTGhoqiYQIlsCNjeoaOF1hDgNJc/EpB1GYaNm3jk1h1Ocfn20Oop2p7sr2b8pL1DcLMpcTebJjlp6JSY/jNAZR/NdtJSE7Bykba7fidqbODuO4T9TGRAJKQQ7M2mPOP4Jo4SbHGK+Ek5k2pIv3Cx/ds6xoOhSnIu+ezy3tL2sh0GNdRtS9ZDoJsXxzCr9643ayUNAbJXdgyDq5Cul+fZnCYwG0zJRAcY9emWGKr6lhtD/mYq81W98fitKG0jzdjrPZkYWkclfI18dedfL8q78iD1512ctqqy56iD+Tekxqu7+gq8IydwBfpaeaxbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efZESsBD+UTdRzMZgRtgQav1srEQxsfPiOHcBk/St04=;
 b=VFq+wMzmyFNborEtIsl3rJztapR4WbDmd2CKihfSHMAZKzuApqfh+Axeh1mrEbani+kfm3rIGFRpXcwtlg+gUxFJhd6eDnj8thQfgvujWO9fB/zy8WgO//+fB+67/mptnSFLfR3wZbOYbCq4/KAOieKbjopV0803fOpq9f7hW2I9ZecntfV13IbNKp5a4OFQeRp/E8JIKMQ554LWL9sBZdMQLSWDQP9vd7AssAwOjuvOPO2J5H4JRuBKTQb022+rA69AYG0SfTPwzR8GkclphfhgQ05srzuBY+MLviZJmAtXeINbaO8jfWMMCeL99K6aJdLe1KCVa906SXGlghCVDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efZESsBD+UTdRzMZgRtgQav1srEQxsfPiOHcBk/St04=;
 b=gD96jfPmnTGvTS6ww+ekRjkHOYO4MeZEZLPOH3IcJsePCxOuWUCOaeod+ErrjJ79nJ//dTcdjdasE8fS3zDQj3HB9tt4gRhPQPuUSftTYR0jrLytZ1x+/zAi0gIUvpI0/RHDmlAr5hF2tCSap0kUiIh9zZeGPJ8HGZXI240y6Lc=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH7PR10MB6505.namprd10.prod.outlook.com (2603:10b6:510:200::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 15:21:56 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 15:21:56 +0000
Date: Wed, 23 Oct 2024 11:21:54 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH hotfix 6.12 7/8] mm: refactor __mmap_region()
Message-ID: <oubvc6lpzfkrryt3ai6xp63aqexymi3nm42aq3tljj6d7sdart@x5qj44cgtxzf>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
 <125b6ebddc7ae8790b8b10b47906c2d39e68f3d9.1729628198.git.lorenzo.stoakes@oracle.com>
 <81712eec-440d-421c-93b4-8b6d9c491693@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81712eec-440d-421c-93b4-8b6d9c491693@suse.cz>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::19) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH7PR10MB6505:EE_
X-MS-Office365-Filtering-Correlation-Id: c3fcfbbb-5df3-4caf-3689-08dcf3766e6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U0ASG71RTmtjfeotGCB+w21oHMnXX3Jr9YnjtofeseRvi6s+y8U8d8+vasc8?=
 =?us-ascii?Q?1MSrtByQtdx9FGHh5vtECAO1kRacBMW7QdI9JTYO8bJrckTyO7G8FXBmcgdw?=
 =?us-ascii?Q?hFCtzOq9Nn5zH9oGWGr2NeDXvc2k4N6BsGLy7AxiAlLRRl8ZOxtrcRNOSVAy?=
 =?us-ascii?Q?xPncMsYfvLrjufcyGpkZxVr3iQWlWmzP8t/+8MbMz5jzHVDOLSzGB660FQ82?=
 =?us-ascii?Q?ZVqEQxWzFlrs8Q0k1KjkfObaR6wrmqfaNc2hzj093w3WzVhMGOGjrqfF3WcM?=
 =?us-ascii?Q?WSaRz1Mppfzh+GYIEjZLDLwje8larHfs8rKMIA3Gg56gE/X8c3BGBQy3h0fP?=
 =?us-ascii?Q?BFfqJgoyYxA71d1ozBa2FpnVtOJC0ju1GmRfELtgPPrLDmRgGXjJvAvzM748?=
 =?us-ascii?Q?55m+iAZ62Kgq6PccRhS/vpQxAKiqriCuhLMbVh9TksR2bvWePVby6Z/A6DHp?=
 =?us-ascii?Q?8qRgkOUkZAv/uMNlOMpi0xzE4WKIy5O0kBPceN6VLFpemI3S79ZSiR1o4qTz?=
 =?us-ascii?Q?CVIkSRjE8tBAxcZtWm+Vd8oV+tJqkhOotM4Z1VzHcd3nAZ+oqiX2mQJJGvXU?=
 =?us-ascii?Q?PTfivj3d+gpR+NGbWORWnwy7r6z/zHHXfjLQKy/aGdINCGFeJiSerIYIMI2F?=
 =?us-ascii?Q?CWlu6QfSxUDYVCTX2m+eewJKN98yCaIX+0bE0I12t9LNjMUY+JGxLp2ikDYa?=
 =?us-ascii?Q?BzBR7DBMeCN8LQbo1mfl0ZSpsbCZHbjc18hz7jBGGv1nnJNxIRjJSuE8zgqN?=
 =?us-ascii?Q?CeUp/FcEkbGR21gHtTjXuE6Qcv2wg25mGVXMUCaLLF4MfGL0sB4Ay19X3KRF?=
 =?us-ascii?Q?Np9PmK3I9WaEGL0uIyYSGx6mj/rfyByvuSskulIrdmZpGwpd+e+guGfYYpUa?=
 =?us-ascii?Q?TlP6FPqZ8l1X5enf6Y+PUkHgGFE0b0y1FOqapdgNPk6AKQG9vHEKxZjmyPWs?=
 =?us-ascii?Q?oZxPWFvonyjS+sWmvTV1bdcoZF4W+8gycW12OLGHzCtRIWNrT3lP376MKt2l?=
 =?us-ascii?Q?4+owa80hn5oz1/FiFKPaAGYlqbXeBQFTR1RK2AhEx/Mjad9gVqtw4Mj/Gk5L?=
 =?us-ascii?Q?DhnuNhQtJskIas/VAoxu5SpMEjk1iOxU0vDRlO4wyad0PVeFCFopXywz6y4E?=
 =?us-ascii?Q?/EqBAxxma9t1MNO7tIkXFLHWWbJDYe9XXwlMpJQBoXs8ECxv3ptSO8rAYgWg?=
 =?us-ascii?Q?vdVflSjSIg/96QrthHcgPKa7O0Uk1u1PQPVmcWRy+oVJZK9UIrYs8x66O2wI?=
 =?us-ascii?Q?AyIj5ZYeSyZhcy68kgeMJ07RB8ReIfbJCKFa2Ogph1Bd7KXJFdy9iJ/sN7se?=
 =?us-ascii?Q?anSmM/yWVTyaSrk2LVhJ1+a4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7avBzbQBvJFEOX/M5Cw4fAXgmAUJlXVXYD8K3R6csZH7hJn2IzJ31VrYCqCu?=
 =?us-ascii?Q?57LA5KLoAZ4lmzSkcZjwM0oUdh5T0Zp6AWMQVViRsbBmzVzrk1hI//MwaNER?=
 =?us-ascii?Q?kWB3bdpDNI825rfCiF3ycc032UwMegT3RMEpJP8i/r+r4lH+vBQNJGI56Ozq?=
 =?us-ascii?Q?VcS4bLXlfRFDwzJp9G1p08sSL4mPKKNha4ukC/SPgSnDYmiJwKj/5yEeeIb/?=
 =?us-ascii?Q?biGkkJMPPmSjlCIoe0C5yW/M0LmjAssNAmOCpir+6wUtfKzZJR5dY4Bjed3H?=
 =?us-ascii?Q?R56AU2HGG7Cvxxt4BgNhP/KeuZp5e+QNSp7OG1dRK+B66uFDfaatDNV7gFc/?=
 =?us-ascii?Q?B4lMCyiRNANUwdzPYiUxpP15hk1j9hPyXH5ToHP0y+UDUKR48QWadvwfRJzY?=
 =?us-ascii?Q?w7Vn2x8DZlGZj0MiXlRpA6l6FuYNOeXH2kI4nVXV9alR56VZcrhrIyAtYzmb?=
 =?us-ascii?Q?Rb/mcvRrERuVhj5OZTNc0v2m9NXDs8FR18uSdUng+HLPF0tWxPF9w7+dlWp0?=
 =?us-ascii?Q?KGJ59XOr3tBvjBpArlj3E2xpG+3f86Ogp/OhBzpgH8kO7a200AJGEOlIWi3i?=
 =?us-ascii?Q?7pqjFBNAt1drlkuCxygcvO3MNPwKLVX9YSrneLSvWGPsIYGmAoY96q3prhLv?=
 =?us-ascii?Q?vL39t9vhep4opW9cITSDipbAqRnBy4/Jx9pW4TrqPhLRCrPkrdCi663/vEAX?=
 =?us-ascii?Q?LkSZlghk6T6goLDTraw6Q4Z3umIruwuVkVJhgPK5jU/tENFNrFOz9seFi1S7?=
 =?us-ascii?Q?UbiV93YD/OR1kEOs17aVPTuUdBTFDVlp5YQQkJ9XAs+hp3JHIhPGUQSkuP79?=
 =?us-ascii?Q?yrgN7ALKG5qWdcDyzbYtu3jj1rrpK9XDJILF73pGjjxBVx98gbHUoGMPRClv?=
 =?us-ascii?Q?DRs7ib8XNs0uB9MtxK8qu8pHb/K62ApbHPmb5BYXbTHfBv2TqV/VlmWoCuwq?=
 =?us-ascii?Q?EEKteWFuQ/wpCOE5EJUmwZezSPFma/j9u/gCm+bmFYJ3kllBBzrNwg7KTjQF?=
 =?us-ascii?Q?X9LvrmRjpdg1aqxqjTFXHXk0qTbiSvugEp8IAPpYgLVfARUCokYrV8Rro8tl?=
 =?us-ascii?Q?riZJiLyJ4ILaUv5B67gwreZiONpENwc4uFL6FLi0zyr7k5C8KxjlQWlsyTXM?=
 =?us-ascii?Q?n5FuFwdZL8YlC7ZP+B6oQenbqTeb8hWkM+U2KXBFflURNInpqeqTa9/S8twq?=
 =?us-ascii?Q?BNi8mchYRSkCfqcWoqSvIZ2lw4IDq7C5c1ig8ZCNJtnobD/ZDlvc/LVC8e2/?=
 =?us-ascii?Q?OtiT09ATVHe+kEm7XHQLRgLj4suBPhz/hdQlEvyQdMqeB2r/prgTJxIp6u3z?=
 =?us-ascii?Q?imUHPALo2o07Ty5joUQMIWVRIsooiU85ULGYlZdARaQY+Ezn8jussRSpj32k?=
 =?us-ascii?Q?01EVXhK+FNyMj2CUHjg5x7aOt+TZqCVN1uDu3daKdjm8X512Pk1yxunze3B/?=
 =?us-ascii?Q?bxkMOss5IiQQebNoQ8zz0PUgWZHq73uHh+1zM/3CHRIojbbZJpgbR7zjXXjM?=
 =?us-ascii?Q?egLgMlKpMURcQ5dgyqTVZVpCO/xQYZ3MFfmhTjmUeXl37A6Guetn480M0TlN?=
 =?us-ascii?Q?EhZYzTOHbRLPCp2eELesHHvvNTgLvjgXawIADM2gQ1bURtpA5XYkvPBmBScI?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eXuPAHRucYgfkY8G65CW7BOEaGbLzOG2JOxRGaolU7eothBkgyiqpgHoi2bvaP0XT2oAyZr+JWP1dPtOtPgaqClv0vmeOMi5WK0Wt1UzttUKD8Nlqt+U3cnfuNAiRFrMv0w88IXTYzFt5JhCrrFBh1Liz7H1qtNC9+yAOVn5sP4Nr4Wx2QcucvwN83eDF4XCFggHtT0THFq1DGZvA4SW5DwRzh+oP7prZnIIuUfOQOzCCdwoRZ0pdK0CEmOcaJ4MHIazuSIdENPrNAmokxzzqeO1SbBIAuoJfsR2tsQxZOD7mta3uswxuk1gs1pwrfmAPDfsxe9AMF2Kpdl1rzOZhFu4buVCKN4qwKK6Dh96MwTGLaOBzHZoS6OkJK2o/Ux+kIypZZfpIgEEY0LtmQ570Am+8uZWKwvEEjm5zS8JhOQu+A71CzXLuUCcRarrdAdml1e6GGvZ6vzWVH4qlgkqdPCcmYkwa7HX/FWGQdPanjJDrlCj8Vlkl8Vg67EMyi/qj8DUqk3m9FMqGFKNNKcOilbzBDcQQq6gFOPjrHMdjUz5VQNEBsSwZ5tJe1a63FG6fZNixn+4KvFDKW0zw3wrSvq8RS1bwULwh0lpU5FeWMw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3fcfbbb-5df3-4caf-3689-08dcf3766e6c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 15:21:56.5977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrWGTj2Im7jn6epi69z22LOM4FPHNiBX6Rmtaf3J892TT/dxQT2W83imlTehqGYpD0jc8son6ARju6oq5l5vKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6505
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_13,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230094
X-Proofpoint-ORIG-GUID: fOoTDaDT2tk3PZA1kFw02Gk-M4lLPWyL
X-Proofpoint-GUID: fOoTDaDT2tk3PZA1kFw02Gk-M4lLPWyL

* Vlastimil Babka <vbabka@suse.cz> [241023 10:39]:
> On 10/22/24 22:40, Lorenzo Stoakes wrote:
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
> > +		mt_on_stack(map->mt_detach);
> > +		mas_init(&map->mas_detach, &map->mt_detach, /* addr = */ 0);
> >  		/* Prepare to unmap any existing mapping in the area */
> > -		error = vms_gather_munmap_vmas(&vms, &mas_detach);
> > +		error = vms_gather_munmap_vmas(vms, &map->mas_detach);
> >  		if (error)
> > -			goto gather_failed;
> > +			return error;
> 
> So this assumes vms_abort_munmap_vmas() will rely on the "vms->nr_pages will
> be equal to zero" mentioned in commit log. But AFAICS
> vms_gather_munmap_vmas() can fail in Nth iteration of its
> for_each_vma_range() after some iterations already increased nr_pages and it
> will do a reattach_vmas() and return the error and we just return the error
> here.
> I think either here or maybe in vms_gather_munmap_vmas() itself a reset of
> vms->nr_pages to zero on error should happen for the vms_abort_munmap_vmas()
> to be a no-op?

Probably in reattach_vmas()?

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
> 
> This frees the vma.
> 
> > +			vma_iter_free(vmi);
> > +			*mergep = merge;
> > +		} else {
> > +			vma_iter_config(vmi, vmg->start, vmg->end);
> > +		}
> > +	}
> > +
> > +	map->flags = vma->vm_flags;
> 
> So this is use-after-free.
> 
> Maybe pass only a single struct vm_area_struct **vmap parameter to this
> function, and in case of merge, change both vma and *vmap to it?.
> 
> Although I can see it's all moot after 8/8. Still let's not introduce a
> temporary UAF step.
> 
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
> > -expanded:
> > +
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
> >  abort_munmap:
> > -	vms_abort_munmap_vmas(&vms, &mas_detach);
> > -gather_failed:
> > +	vms_abort_munmap_vmas(&map.vms, &map.mas_detach);
> >  	return error;
> >  }
> > --
> > 2.47.0
> 

