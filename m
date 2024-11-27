Return-Path: <linux-kernel+bounces-423998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057209DAF28
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 22:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA592282754
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 21:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C60E2036F6;
	Wed, 27 Nov 2024 21:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OuVsnQWY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gpa50fcu"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7797202F7B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 21:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732744770; cv=fail; b=jiSS/mIf5lOzsUZBWsMCJrbt2ncYzuUKYMlnGU8HaHfDDNbx5IVNnHwZE4zGAlV/eORndrLreQMvhDWFWufsoAVGpSRBeeoq4o25c5FwGvwa4NBUSs86JehqtiqbNj1U7kYg5TqMMuIH7Pg5LLVepldlcK5CCqip1ZjhkUBDTO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732744770; c=relaxed/simple;
	bh=LyP3D+rjMd+bJ7Y28ukLXuXc0BQixfLSXvVOzGsG57g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mO1NkKLdFP+yO8OBiO8VpJrblSlowqJX7QUYYgyWX3q4SmgrGkFXYVl5xHZOXtJTezKcpnRsSXDUrGdfKoiOuVntbbWOKR0uQgFDEGZHa1pGp6sh0cd00jCClOMQP1JwJIAhRnw0ql3b8BO49eNHclKzhs7jnq1tAjZmUllcH7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OuVsnQWY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gpa50fcu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ARICL43014609;
	Wed, 27 Nov 2024 21:59:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=nAdlmFfP0HwNOWkjQP
	TfH11sKuYSmwmvgPTD4C7mkY4=; b=OuVsnQWYCR0sD6Em2R5VZJdwiTLFH3P3eb
	IdmtJXG+zdjM9z8TA+quE5B9rtfDGKaou/QSpnSqr+L/rvSpWPpFzlUm29MOB7Mc
	cEMlP2J/9FAUgQ82eo295fnohP5tEqeYAiVlWn4ad6+tL3q+5SMOyEh9QvvXejXO
	HscrEuFeEYlIln0TzmNA/ZkcPISwvBhs4hEL1s0vQdWRkGiCSViPOKWCkGnY4gdw
	J0PG7pMlSRjuAKHJ83CrQvakGhLmKW06SUCzyMXnxMvAZYyWrMKRMKCZII7iPafr
	E86pOs01Tzy+n1lW/VEm5fl747vvqeC1s0hypFfziWz+/H/QkYqQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4366xy8jkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Nov 2024 21:59:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ARK3M8J014249;
	Wed, 27 Nov 2024 21:59:13 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4366yxu597-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Nov 2024 21:59:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dVf+ZTypL9FE8eN2t7zro6lL4mY9t6UNfAC3uL2zKnua4wwMMwzsSbWkGhRJTBrbypGHaRzkEdOIyySXdmposGM98jX3VxSB9WLnjkFs33bghR6rhwKkK4oAhgc94wX02O+r8T1G8HJBkhBkZeR2Xemvq960s4oeKQBzq49BcmNqF8vu+XlYm8pPqkDTU3fBys3g1jJAlKiZl1nLPtYv5Po4IqjJ0KwD6AQizfsx2vccbaSGkXwb+FXM4RN5LfPdWcp6WvqehP/baxZ3lOUMdpOs3o5K0GISEU3Ygg5Sk76PGFSFssaBKHN+M/hCTtCP3CK+sRMIDcOY97zr3JCJdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAdlmFfP0HwNOWkjQPTfH11sKuYSmwmvgPTD4C7mkY4=;
 b=YoEQiLIMPSr0SSv9cqS8N/SxBPTVifZMiJsXO7xTXYARFJnl7Y+y97/ITBkUK8JHURu4dPbDu8owB7knSRVg4a1p6hCJbpxhnm6DVOwUEwcPui05/iuxVA8tslyh3kyi6qXQRcaWcs2voVi4NGsnlFuIgW4H6BWn1EHKIwxpdH5DLU4Bs8VfYEJR5FT6ve4Rn2XQHPczARplrIid/H0SPpPe50XuTpSxX6dbPbil9TeKZ3Zs8hheOSWidxC72bVbu8wNrFae/cBC1JRpe3JRF07JQcYQbAROR0u1bVo31M7T2XPyHBBC15Wv8Ez8CLffl3evxbQaKz7xJ2iS+RB/SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAdlmFfP0HwNOWkjQPTfH11sKuYSmwmvgPTD4C7mkY4=;
 b=gpa50fcu3/s/70/OCi5YNmRb1ZxtL2nZlehgGJj9c0tW/izqf1B8IUhdveAG3Y2rjcws5Yd4lnrYZODelK7B/DQmvdVqYyUa0n30BoTQF3y9X5lndAtdSUskyMJPhIdTar7O/hEqds3bOfgVGVVffvyQIE6JZWmpOkjpbc4XfSI=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM4PR10MB5942.namprd10.prod.outlook.com (2603:10b6:8:a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Wed, 27 Nov
 2024 21:59:11 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 21:59:11 +0000
Date: Wed, 27 Nov 2024 21:59:06 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Julian Orth <ju.orth@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: Regression: mmap rejects shared, read-only mappings of
 write-sealed memfds
Message-ID: <b36af945-9233-490e-8d15-c088d59bc17e@lucifer.local>
References: <CAHijbEUMhvJTN9Xw1GmbM266FXXv=U7s4L_Jem5x3AaPZxrYpQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHijbEUMhvJTN9Xw1GmbM266FXXv=U7s4L_Jem5x3AaPZxrYpQ@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0343.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::6) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM4PR10MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d8af251-ec5e-4970-ec41-08dd0f2eb95d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TtRuF0WzeqGqxVDJlta6q9l1TzDDV1qk3N+yy3PaKCTySff2zn9ErVmBITss?=
 =?us-ascii?Q?FqPYmVXsgkEeLlX12cf7X5uRZ5KgNypVVT6mLGxLotXyICqTAEHBL7/5ycP+?=
 =?us-ascii?Q?2qExjNJhic1HwCjmzzYusCnh8DfFoU9tf5KNCL0FYPQTSMOP74xOZhWeiAv7?=
 =?us-ascii?Q?iKxQGM4ldQ241ZjhAYN6XAHDIfx37AZJwptDztRei6LCtQB7sReAwbC/7q37?=
 =?us-ascii?Q?0jWa+M6ay94LeF3vyf1TzMwwPrcVd1jEhkPLcNGMSMaPqcdmMk8YsWdOIhBp?=
 =?us-ascii?Q?SI35BDk0KX8TRL2L994xn40nQSFptyyv3X9HZDvQxRIxUquz7S2sgcnWP4GP?=
 =?us-ascii?Q?OPDUoc7HOPoxurNpFKuxRcjRB24ms/xUMZ2oJODiWrrO/bezRb3WVuD87liS?=
 =?us-ascii?Q?23kBHg16FuwqpsK+40+jegdB8tlB6TmJb+b631+yUlvFEHeyrkO4j1RSR231?=
 =?us-ascii?Q?cKI6OH2oVvnyoXEtO5rmRqnALeUcJugJV9dRDuTnr3DJH9DiqrZuwI38XVcf?=
 =?us-ascii?Q?lN7V+TxC1F4gcdVPppCT3AwWlqGdYxkoZx9YDnyUWmbKXXsvPz76dyhTE0Fc?=
 =?us-ascii?Q?fdbzvYUS2wvMBzOdDd1Gd9youZOTlW1d/U18ThSzsk3uRJIjqOqh1/LVSvER?=
 =?us-ascii?Q?arwASBlQ1HNXuodNOcGRC4VFJFzVkXoO3WyI7SQTAWIh46YkTn5fhKyTuqrU?=
 =?us-ascii?Q?CEvuoWS9LGRVpHsn/XnEv/j0PlcLaEpdxe0Ge8Fsc30TnOHt9IfjDOopOXMZ?=
 =?us-ascii?Q?5+4hWIrCjpMrfkcVWwCqHj0HcUKxOKQSI/PcPbcg+YM1n2uxLWzUGg8OYz5X?=
 =?us-ascii?Q?hvMkaC+iZ79vb9LeQKPeD02tNdykYcng6SxJaEnInWn7D/sR69t89iGXxtdU?=
 =?us-ascii?Q?oiANs1jwCr9nj9ZhpViqD64EVskSCUF5cPfFVp1aTW8nD6VCKizISwEHKXue?=
 =?us-ascii?Q?wQw6UGscLXdpipi+AjQt77/pO9gAc1gTClgwWxZePdB/G9lfw/k+2C/QmF/5?=
 =?us-ascii?Q?A0ON60Scy9Fol+LOLW11ZIyqsgfvcMzmILqGRziBhJZt/Sjc/pqNFmNQ60Ce?=
 =?us-ascii?Q?fKG07iA4RERrWRQiFgdPql+7WWyTdVq7h9zlxPRVnxWn8j2P096kHxhiX1W3?=
 =?us-ascii?Q?VGpuWbaItsGZvyNrzubQ+b2AKPtcOJLr2AmImAqsiYNx5IYgvRWSj8P3HHIK?=
 =?us-ascii?Q?lIjoBwbtf56Hka6sPVdfzlD/opOwJ8HpLSrz7Ps9rEJQ4nouhmAwVvioye63?=
 =?us-ascii?Q?BE54MFJkSuM2HfbO3plvik2ZV1jcXD9yP0LhbOZdjbMJcfh/lAlwCRI7JdRz?=
 =?us-ascii?Q?fyYc7MzMuG6d0fGK8kPExNziXLFPJ1oOffXgfpRghCTiTA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NAJtJcBI0DfoVzEGszgcgk/4Xik0Jj+QgWN9CwLp00fIrVFspoNfe8yar8yW?=
 =?us-ascii?Q?M8x6SefT+vLdGARwvGkkxL4F+YPrlXpRILz5k0uG6QHS6jEZqctnZix9zD0G?=
 =?us-ascii?Q?BNn8LwPjKWykIhjPBLRFb+o6L/nJhV4ZOHxhlZS6xliCJPotTl6RZked6pvg?=
 =?us-ascii?Q?ufCpm5IBZvGGf9dm4xa88W+TMkKQYeRxKJQrGBkg9WQCi2Yrp7eWksWYkqrk?=
 =?us-ascii?Q?CL9cwBh9tqrTwIRaLJYBc6ABy1OcZy2c+D2wdlZvkB62I7q8RNO+4sV/TLcW?=
 =?us-ascii?Q?Z4WiamLZCijjHMCVtZTrS6AxWeSTfepLvDnsjhWvsZ5fDtGKJvsQRcuy4vSD?=
 =?us-ascii?Q?O+fyjJBe9qHERC7gWXYtsY1V2prk9sXbB+whSyYik+GCJMQX37yTpUa0X/cz?=
 =?us-ascii?Q?Q/gvcpGHOtDT4Dnd355Fq7a//E7nxnj61noZ3qvMzHyswmho9KQkP+kjo05E?=
 =?us-ascii?Q?nbgHcmaN1Zc6WaPMXQ1g4H18g/Uo/+FYp2PeA2n+B03/1VKQhB1V8cT5SsoN?=
 =?us-ascii?Q?W8TQmi/VyGp015GkY56xjR2vN/QMHIj8IqP1OowlaDEpugm+14beQl7AT2I3?=
 =?us-ascii?Q?mTZLL94Payy6UBt2gmtkHreZylE3tMX91P4oTzfmO4JvHFrnu0SRmLEHkaJv?=
 =?us-ascii?Q?kf9flBUkIG+zToGHt2ycbhbEXiJqTWneMNQPi9C/XIIhXNY6g8Dzv1rxUKU6?=
 =?us-ascii?Q?0mJjgi+3u4fzkpbsusYYnqpJq2o5xOA7W18qOR/bRgmM82p4Ii5wHRxkP7YJ?=
 =?us-ascii?Q?NScNsg5Z8UGx61XBUVKpe0jHtstmRXme6jikVDtI4ven1t96TKBZ+zevmcSo?=
 =?us-ascii?Q?sIKk0XLjs1AyEK68tIb+9OQQh7BOrXR+bI5fAPGBcXca8LXwyykYyMAyd8mV?=
 =?us-ascii?Q?jApS0mGqlIYk/9P4GCuBMn6/C/ctdHDRz/OeAV/htfC53IbtnknBbCSVDElv?=
 =?us-ascii?Q?QP6UQD8Bf91q0YQw7rCMx6Ri0xBr82YDfLsH8jf5QYjdzjs2bEjIJT9uIJWL?=
 =?us-ascii?Q?OO0X+pXio2lfSw7LaMRzG0m0zjdDL2rP/5wJbjMRzcvGE6lMvaPY8Um8QUqt?=
 =?us-ascii?Q?3FyGLoSbFzysIqozQQWyBPXKn4adTaSKRXspHgsegCTWCN5rXMTvLRsDeE3p?=
 =?us-ascii?Q?NBTOJS2neBm7OaU2UPN5utX1Nh1WLD2v+9FBomOrduWuVIvpPCwjk7UbtT+Q?=
 =?us-ascii?Q?MSgaEF1YXoRnUurtZWxwGScOuGlpDjvdoBlIPOO0TK3GvdZYuVJSdn6iKpAy?=
 =?us-ascii?Q?qYP6nnJ/lmpc15u1NZLO5QPPAjwmA5oaKgCES4uA5lyTWwYNDuLlnRM2VCS+?=
 =?us-ascii?Q?lTdg2SXWCMdZTsDVE1CC0RGvVR8bsjkiiEypXb7wXVEyEff6C8KsMN80SU+H?=
 =?us-ascii?Q?Yd6j4wuQLgpPvk3zjZwJNhv711I6lMOftFudNAbvkdONJNTmSuAkNy17pa7F?=
 =?us-ascii?Q?7vaeYGhrLssbKgLojeU5xI/sdmKANAG8dqw+xxS5fRmJDwvdmV3JVEOaVQj9?=
 =?us-ascii?Q?Gzt/1fdWtMAtEMqDjGeo9NtJNfgDhbL0cGcfHdrtbwRgbjUC+0Wy/unjZFdM?=
 =?us-ascii?Q?7akCLST1MXXd4WQcLIG29jVB9qSgvgx86uV8zKwnRIsDEtD2AO9+kazc67jg?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	y/4AkLqM/FbQ9UwJq3oR7pHitUZyeytbDe+ta/3eBuwP2vmvfpfxUHr2ojUVdCV7PEjwfvfvaJ/EVodfn6sh9hvV+LRPKptggpI2Efz5ryFj+t33DJb//2xqWuLsgpRkxYCwkcuhKPPmIsVtDQ9Qq21ELuiZrp6Eyi3MaoxdUgU/i7zwSvmx4CwR4Va0C0qpWC4TslQsx+S6hoyQB0++pRs0BHJgvOOWFAD1ACURxRDYGKyxQBmsjgZiTfno2kcEvGoRBztcOkwT6MbbVgLPPQdNjMzeLJ80EGEp4lnrA4PETAIONvYPKSO8pcDogUH7aH8apobN/iVmcle1wzWZLdJyZBYP/gXwv/ITs+k/V4ktMB4n9ZiqibzhZmNTUgjjiqkLR6qiFwzaLVeRFCI6ob2bTeGCLeUu/Iam6ul/4210hUwLRKFVmGS//0K6dUIWOFKQrnXcLvv429KuGlIosv5mSHH4cBeMNLWm+H82QGk5UC0lydlM9TMAMH4Jnpwns2Ec/3EV4Rj4X03UNdwFODFb1pc2rX7ivQ/uNledJErfm9iDk4qUFt03iQgowPx3eF+pdrEdx92wj2hcil752YUWprcZptn0x//b43pDyFM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d8af251-ec5e-4970-ec41-08dd0f2eb95d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 21:59:11.0516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KWstz4uugiWZPVL3rUA1jrtmR4aCqt+KNqjfC/7XyMKSEtrdrSbSuIRV60pscjEsOb7gfgko5jmtA/zulQ/iuKDxt0btMEt4nupejL/K6u4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5942
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-27_10,2024-11-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=570
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2411270171
X-Proofpoint-GUID: 2j_WRfK-lwazfpxNSJCZqeE9ITdXPrvY
X-Proofpoint-ORIG-GUID: 2j_WRfK-lwazfpxNSJCZqeE9ITdXPrvY

+ VMA people, Linus

On Wed, Nov 27, 2024 at 09:49:29PM +0100, Julian Orth wrote:
> Since around
>
>     5de19506 mm: resolve faulty mmap_region() error path behaviour
>
> mmap rejects shared, read-only mapping of memfds that have a write-seal applied.
>
> Before the commit, the code in mmap_region was
>
>     if (file) {
>         vma->vm_file = get_file(file);
>         error = mmap_file(file, vma);
>         if (error)
>             goto unmap_and_free_vma;
>
>         if (vma_is_shared_maywrite(vma)) {
>             error = mapping_map_writable(file->f_mapping);
>
> where mmap_file would clear the VM_MAYWRITE flag for write-sealed memfds.
>
> After the commit, the code in mmap_region is simply
>
>     if (file && is_shared_maywrite(vm_flags)) {
>         int error = mapping_map_writable(file->f_mapping);
>
> with mmap_file not being called until much later.
>
> This regression seems to have been first released in 6.12 and is still
> present on master.

Thanks, this is ironic as I was the one who made this behaviour possible in
commit e8e17ee90eaf ("mm: drop the assumption that VM_SHARED always implies
writable") :)

This means this functionality was only available from 6.6, and is pretty
corner-case niche stuff (code written for any prior kernel could not rely
on this being possible), so the number of people impacted by this will be
minimal.

I will look into this and see if it is feasible to resolve it.

However it is of critical importance for security and stability purposes
that we do not abort the mmap operation midway through, and therefore we
cannot have a case where we abort _after_ the mmap_file() call (which calls
the f_op->mmap() hook), so the behaviour as originally implemented simply
cannot be restored.

A workaround might be an icky special case for memfd's or even a
refactoring of this code in general...

Thanks, Lorenzo

