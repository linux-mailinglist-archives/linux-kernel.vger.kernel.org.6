Return-Path: <linux-kernel+bounces-536307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDE9A47E04
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F1423B6B61
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D747C23496B;
	Thu, 27 Feb 2025 12:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FRLqaw67";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vvTvvsDX"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE902343AB
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659852; cv=fail; b=XpGs3UPnyOUPrSmHNKiZMDPiv+sgBboEYcFiKBNL7AK9TziyZ9nC13PJFaJWLuk8MJg9LpdW22ecwEFMgCJv77w1V4qlB90hZI66SxGAwUdP11+/RWNyW64WAbLErfQ+Jyb4hcd5AtjtxsVjB+BGo6kCquwdKcreTZ1QzLXrKpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659852; c=relaxed/simple;
	bh=1vqyH8FOvF9DFY4yw/b6gYYmwBcWVAu9akG1f9DmBwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HLs27PXz/ojbS5Typp4BMcGdQZNc4GL3iBIgNqJepycwH0AEp/IfehvVnm1QmtZorTW6G5IQpn9FXXcT/W3xk0MtB4k1jozS2FtJA34MJWPIiJvNL6H4GPjDkcDOypJQVxsnInxEZ+ivzPKl9lSefVzs5wtmt4o5fcEkWNzQDWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FRLqaw67; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vvTvvsDX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RBQhrJ001629;
	Thu, 27 Feb 2025 12:37:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Q7aXbK9X8Pl+tUf7h0
	HdTbGcbz138WTv832av0Si6TA=; b=FRLqaw67jX0qDs1L9KWoP5JH9BfF0Lh6G4
	de4koO0kzFDx0uvS+mavoe71gM3vU/dLRfkwotyc4Q4sZ85vYVKAy/rbxMf/Qo5h
	/XVSHLzxSFRntNOQ3xWsDq7UbEmMrmdvuT26hNDOtZ08NN7hPjCBXg3NxrSlF7yZ
	D5fjA7tKRAfE4Ayx9l1bobJToayeD60xMAJJBi2nfoMHZ3T2UHhjrcFMSoDdJiVk
	k/uUIPJpOR10XMY208I731m5re0yBGa85YyOY0PB1SLD2xJl0IleZwZAQC/moV3x
	d0OdLC/cDBn3BUYhekQwBuopd7lPDjvbs3QwZqyuclqrUCmArLxQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psdk8vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 12:37:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51RAdthd012630;
	Thu, 27 Feb 2025 12:37:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51daqkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 12:37:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2Cd/38x3PPt9scRu3JLDMiFy+aKXBlosJ5mWZJrGoigLN/VO5G8Cr75GdmHAQ1Km5yX0vzvbgo1FVvnkVfj/N+X58N/LVm0WN23Gs43XfFRSKmDu3598tXLZiju8lVYRLbK6k1SDZJzxAeZXODi4LIPwgPWtwvB1+DGBLrl5JPn6UFqNvxVos72nSST3sZPYCzSlQiyrNijNoPXwZAdzPUL53dHUejS775jRQvTKGMKxBoQcMhpJKIzyfDdyCFh0LpAU5gOITM9JueYCV66jan6B60gyZDfGxO8Yz33gu0ps9sR/VBADmPLo/aFrIO75Edqq+kfyFi2bF3l+MCCvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7aXbK9X8Pl+tUf7h0HdTbGcbz138WTv832av0Si6TA=;
 b=nuFmzMemxpGs60x0sDHBl7Ar1GIxQag6s5gQlgLj2UNBQ0WZeBqoygKPsmPpE9TDbU5uv2MuBPnMe7Ia180e7RxgIvqknaDzARFib+BbiK1JeMpOUOOFD+7ne5YRiuKPKCNslayFIeKC5oPLBQraTlzP8Ii7QB0CI1xgmSOuLZSJXrF0uF1zH559RsfksOOTiWHoC6xywZ5zH9oelEwCFTFykIQQ/9y05RCoYGZW72UGayQvlXDkpQ2wUxekZgI0uELhb1p6y4oiTCkPbXbcPIsa3uCdd/wS7eunreuvCO4DrRcfofjVnHOO6NqqEP3McTCAZTyVWDqQOuxEgG8Vuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7aXbK9X8Pl+tUf7h0HdTbGcbz138WTv832av0Si6TA=;
 b=vvTvvsDXdLg6Qb0PEqLVV29CLzRYUmlGTe9xQwFIt3cvyx/1b/UNr9oI85LbeB6tC7JrD4d3oAsPVc926rrV+jWW4KFJm83pJNURXIL26XD1IvUmEuqK6gAH8gt6h9VXqRm7s9D3bq4rwcFPnxznPaaKVJmKDDEoQKmScotR/SA=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DM6PR10MB4235.namprd10.prod.outlook.com (2603:10b6:5:210::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 12:36:58 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%6]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 12:36:58 +0000
Date: Thu, 27 Feb 2025 21:36:50 +0900
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
Subject: Re: [PATCH v4 1/2] mm: slub: Print the broken data before restoring
 slub.
Message-ID: <Z8BcYiGfPPmss1mQ@harry>
References: <20250226081206.680495-1-hyesoo.yu@samsung.com>
 <CGME20250226081357epcas2p2f4c462b215b75291a9aeeec23aa1eaca@epcas2p2.samsung.com>
 <20250226081206.680495-2-hyesoo.yu@samsung.com>
 <Z8BRt9a6PqDqBVsx@harry>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8BRt9a6PqDqBVsx@harry>
X-ClientProxiedBy: SEWP216CA0059.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2ba::10) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DM6PR10MB4235:EE_
X-MS-Office365-Filtering-Correlation-Id: c03f0a55-8270-4030-a7ff-08dd572b6cfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8+gsLdNlwrNJf3uLd1bpRnyjeDdIO/I0xZozgAHsKqM47diNWMI21Ml9fS2e?=
 =?us-ascii?Q?BkaNFSErgAR+OP3hEd68W85Il8zjraaNIChG6rJKE7mAdQyJX1x6mdvPnRsM?=
 =?us-ascii?Q?unuzT0IkclIWaygPNnQaVw8VIYFZsA/+DXoWOkk3PDSdMkiV9TuMtMeRYp3O?=
 =?us-ascii?Q?c4JaTD0jSx0LahCFpLiVqezqJVXGxTZlZNwykKuMQQXwUhCgWTF8Yhp4DbW9?=
 =?us-ascii?Q?bOWZk0BpUj5OKSyNPTlngvgfjJOou2t/OVrwoRLh+FPytKl4erA5IH1Ql+dV?=
 =?us-ascii?Q?dBP2qPk+GwCF4yrSYLDC7I/Pz6aieWtpbjhPBMy8mZlj6yHXLwZy7xcdTVqy?=
 =?us-ascii?Q?s0iIAjX3zyT6OElBqL2WXlKKEYEefeyntMPFxTxghC0B/9nE1N16tfU4RX3v?=
 =?us-ascii?Q?Fd4XOVeAxqX8Hpyutx5Ushe/WrsWhXZnxMdzgL2sDJALGNaMJyvpHMMQQMep?=
 =?us-ascii?Q?3YpONMv7gg8nNcjj5og5U6cPPTU2hcaXXwMjPBWIqxrr0sIQvVJSRcNM3CFu?=
 =?us-ascii?Q?ojoRfd1789MfjxZidr2iSmgqKM+fShcDy7GolQ8c3R6YlqkMsshyXE0ciYxD?=
 =?us-ascii?Q?5etXArlXvN4R1NLHq0lm0OQc4gwwAsEH8/cfGWgAlsVYq63hvd4cHq8m4LLl?=
 =?us-ascii?Q?nx1ZON1sYDSbc0OJMhcZFPSDYnxEt3Lg8GCJNV+sQXTgaEn2fTZnoxp4BNQC?=
 =?us-ascii?Q?nHccEn5+o1j3+MsOAefomkL7wXXB5GptopfqHcYeSSRb1weB2jUUm+m1rpvY?=
 =?us-ascii?Q?BbLae9zNgKPz1IE4Mjd+xVmnqlaHene6FTrBNPwfR8iZy5yW1QjWfa45iKAj?=
 =?us-ascii?Q?4u0KCRfp6e1nYHX97oXQEpyfRdbuehlEQ3mtis4E3Kw9cLCVdN7423hyNOss?=
 =?us-ascii?Q?qhIdJg+MQOOuiPnjvucV266v4Jxc9hlVufDZ1fo0VZoM/uCX601c0RetSs9U?=
 =?us-ascii?Q?007iTOrtUptFbN3LrqWYeTrbKixiuvCPl73npHDNz1xPsNIhDokT9y4Igoya?=
 =?us-ascii?Q?DXfotjI4TQI30am2MpTgz4o8bsXb6ONrqZXxb0v4SH3klJ1THSTWHqJ/QFiV?=
 =?us-ascii?Q?HwCLNIBvBCwUqgWxjr3iP3VhFdocc51YFw1RkIF12L5jjoEM2EUXC4QDpQtO?=
 =?us-ascii?Q?S917vOGsmTF5tOWdDxJ8U7w0oPpfUp+y9niMotMLjfrN7MsMYHxHq7fLzcrC?=
 =?us-ascii?Q?gUWr8AH9C7RLJQTQrxVD6mgT0snhuedTj8QcQ8pgHz9MCrHg/9g49qlYDEPY?=
 =?us-ascii?Q?59071193CP6828lPx0TqEqedePN+pcrOe7fOTMTvDk5LqMPkLdq81HKsWxEz?=
 =?us-ascii?Q?PcA3XMl69hBwBDZyQ+Kzy1s+/8+B8MgTvQ61UXaAzoPGtdetwMsARq9gwc16?=
 =?us-ascii?Q?BErsHe8BgcAnEBkmtEzhEYHXgt3l?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4ON0cqax2+7cIu33o9DyXZQPl2K+QgjwBtFo0m+G9FzGvqt/XTBpohxPb+J+?=
 =?us-ascii?Q?kBUn3C53HX+XMn/HpIsD50aDxnTDoZ3q05jHEjQfZerM6IFFgmIBQG+OUaqW?=
 =?us-ascii?Q?CfLLhVV5S6RGzl/67T1mf3TVw3e7KRiS+27OtvvgV+qw+kWkqPw/HxN62K85?=
 =?us-ascii?Q?mohWyI365CQKaere/1jvGQdy9173BZAtsnJscvL6bqEa6pOWk5GPSVyrs3S0?=
 =?us-ascii?Q?4Y9rCU14lsLlkgvVZP6LY61feXSv6wvStkr4EcH2P3RzJAU0eOF1CvHedfhY?=
 =?us-ascii?Q?SW/HsfO6BsmggozPOCaM18+ds3T4hNkVjYWll/hRbPHGW3/i0LnWy0QIOj3l?=
 =?us-ascii?Q?QIyLPPqGN13scj4Ox/Yh40oY4c/WiB72p0ecIR6vn8XrGYVmle+j1tL6ZRp7?=
 =?us-ascii?Q?KxLmEO7VUpvmDUDULrrCJi6bfVAjuxdvy6WQkLup8PGOiiMqIL94W48YB5VJ?=
 =?us-ascii?Q?dS6e1IVVk+HQwm5CHAWHpgUeUoTK3dhEdr6mODn1T1jNjBbKrLSgWZcUoigk?=
 =?us-ascii?Q?Vr1BGmju+lSCrICAh8irEOr1w5b4QlRfkIOpJEVGOoqJZtK49SgAR4qtpyGu?=
 =?us-ascii?Q?Di3VAgzvqmZER/7jb5Mp++BArsjq09UXEs+ypJNHl20/G1ugdF26Z2qsup1w?=
 =?us-ascii?Q?Qb1S5+vLYVY7vn+HCAkn5f7tcUebPZ1NV33bYCVTTGDQeQy1KqzWEeP5TWOy?=
 =?us-ascii?Q?p3ZVG5X94B7BpioeNgIZBOQ8ItNYbTabC/1wp2Uh+WJgwAtDB5oheN8PNQzJ?=
 =?us-ascii?Q?q91ziFP2gTjr8E8hOYZxK3/2lJ6xpJ5DKT4JUuxozebh5k5eiGbhuU9dGVnv?=
 =?us-ascii?Q?o2LmQTRrug0514hWHpmrReAyDDgyf+Kdm2Ib4YOr0GoqMhtAkQix5H1IoNY/?=
 =?us-ascii?Q?Sl55/s7DAwkOVz3G9kB7uxoAfdWinXz/SUkTtNjLYcSBkkjSJ42BOxbvfvRl?=
 =?us-ascii?Q?1CayBcydjaE2FLRfudvOQhisU3p4UVNo5pwBysyX1He0GXCIdhrYLWxv2j/d?=
 =?us-ascii?Q?DIPwN8iWC4f34VrBNm1I2P8H6thdXHpTh1jCbcNdFMHOjxMIa8apAdwncxx6?=
 =?us-ascii?Q?3BtkR6oMYINIoXKtqNI5+LEwW6ovc4dnACrbHCE3EwXF7j1lReMxXfgzolG7?=
 =?us-ascii?Q?sOh/lxilVMNF0YiGphWaQJq1vEabCW9ZVfao8XvOZWY2cH0VUDNMxn9sl5p8?=
 =?us-ascii?Q?5l2tyj0CkOPEByTle+NhSNquHTqTSuK1HcqoNLVdzFymr4uMWidlGPhJ4jGF?=
 =?us-ascii?Q?j4b6ix5C0f42TE5BCypHGxiHSOPxILR2gkGXfi03VhbDPyvP0hiPlzPTc968?=
 =?us-ascii?Q?ljnkMVUENcFqsW0PqgFBthlccXwpB7q0oxbty6DgfY5c9qYjZ5oCPwyzYgtK?=
 =?us-ascii?Q?u1MdjiKnWi+0vQfZDO8QwQ+pPIKiQ9DQZXlmzYouBqRkNWsDjPoYuTRc0/2K?=
 =?us-ascii?Q?L1xsU70YgoWD9HG/04j0dNNRUspb5W/UM5PIxhnfErk8zixBPrjhRn/9BR3t?=
 =?us-ascii?Q?jqwkUbfktkX+xx6K23keTWX5+J5CNxhBHi9uzxWtFiVVJzbAxTo/U95R5Z6u?=
 =?us-ascii?Q?GrYU2UJAXFqfDPd0TlJ0fcvacrR610Lb6MBVVFOj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	57HShAA1RJwD2bUKTD80UKGpriQfpSNsOofyeO6PyxV32+p52CHSfRwhYJGYDNaXNT/sSFb4Oy4Pf0r45r4bxubqAhhDzcfVpNymP/4/gFR+Ep1BZfz1QDB70KiM5NrbfO6bEYzl+rL/tfW3x/kytffPSAlcZNmsZ+Rtx3yVw8S0H+3N4CVY481AwJw1jNIwTKSN+S2nPeUdSYh7s3g7M+ffoqjSZA1UNaXaybOH8cFqSvS7H08ClKouUeH7/rdGp74CxDqBHcdr7RB1+2C6ae5DP+n0pkBDXYeBx/3VsUmvAKxX91u4EF+TdBLQ598TYO6v31pDjJUcQMLMtS7rD1kY9p9tTycGIVbL+3NC9I2fGC969rqGMDgi9n+l9cj/Fwr0PeVy4qIeCoLg8gTQ+rS4dCtTdSV5aahJw/R538VsbCk05cpUdXw6TlH43M0OHBm60Lh4+pFrEUvmE7s1LFvAiRRDqaw7s1uzH5o90hw8BzVCgLLMD4erEU7iIYTVOz4ey/idFmZPuqG9secdVNFyzJV9iOM+0mIo2wlykT4mjvoZKXIW3QcST3MpsAsKpfakf44MiPCdF0Oroxn1dTtHiO69LHUks92gLfEkxC4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c03f0a55-8270-4030-a7ff-08dd572b6cfc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 12:36:58.1643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IvNa87RPFvxfFAEd68cGM6Y1ImF7eWj6xzs8nUyLV5DzBBJxXMOmOgOVfiKrL8aTveNatiOtZCM6D+Kfz73kCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4235
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_05,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502270095
X-Proofpoint-GUID: HiyG4moqHtN59epeVBRzfi0AMqMhIQ91
X-Proofpoint-ORIG-GUID: HiyG4moqHtN59epeVBRzfi0AMqMhIQ91

On Thu, Feb 27, 2025 at 08:51:19PM +0900, Harry Yoo wrote:
> On Wed, Feb 26, 2025 at 05:12:00PM +0900, Hyesoo Yu wrote:
> > @@ -1396,11 +1397,6 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
> >  		ret = 0;
> >  	}
> >  
> > -	if (!ret && !slab_in_kunit_test()) {
> 
> nit: check_object() was the only user of slab_in_kunit_test().
> Can we remove it altogether?

Uh, there is another user in mm/slab_common. But it is also removed
in patch 2. So can be removed in patch 2.

-- 
Cheers,
Harry

