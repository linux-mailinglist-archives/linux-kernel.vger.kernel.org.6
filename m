Return-Path: <linux-kernel+bounces-367907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9949A0831
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9550B25837
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FDB20607A;
	Wed, 16 Oct 2024 11:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gZ5xuUqy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PNIxcDy9"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4335E15C147
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 11:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729077404; cv=fail; b=uWp0l6x8loaFPt/kPHFdsp5yE+0Cb9Z1KRhcvHJGaqB1Ip397W1eyX2A03fYHHngqk6ZMu2LM4tvl59FvYL7/J9hemQ8+KU4DFs8tph20dQvZ2N0wlETt93dppgFhj8SIkd9V1+Pefp1qOEUPUh5FqJ0qPYswo3tHiRUHKVAJrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729077404; c=relaxed/simple;
	bh=FhNPm1WWwb3iGuVfzgGjiH5mro8bQHkYDUCc04J2Nnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=olT/fddlyd8FLg7gYW5qloBzsVoRAPkaXD9oXFtE75mJN3V24Befv8JNlteEdqfuzVCrrWyGcg7/WVjbZKKQCllzg3jA2WVVXg+N9CSOXOSXbY5/Bhss3E7XKnSGm2iPqdlKPiWO0aTsVMq3CSr+EfDc9LtOOwmkpghL0ID5wrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gZ5xuUqy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PNIxcDy9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G9tcPA010050;
	Wed, 16 Oct 2024 11:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=e4Nn1yy4zKB/9LQAlk
	+byvZ1JarlywApRcNSfwuRElU=; b=gZ5xuUqyD4Io1ZW8tcz22fIJSjNaKTLDEF
	GlSAb8iBRiL7V+cDXp86cq/TOqRZt+mlTN/wUPipoS2GUFfZiUIFzMQAv+vfiTdp
	wLnt7lt3EpR+T5WGecrdincyPLblhyz+Z5xSDCEMhsHRQPX7RlUW6643vGA0eLEI
	BUs8nV75ZvDFbsOdiSLjaRuLGMYSS35pamBwPtnvfbpwsopmyM6llvLUhNVveajR
	UrhQcbzS6HpfmWPpcoxcFUkikzDxN84mEXzn8XQ/2uV/iaAkX41Q/WwzUwFolGXR
	9gIrSt6BMv8de8DlYQYvoN/t8uzlVT1Z7B1ORi7gWJmCtCcOwAeA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hntbh30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 11:16:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49GAMGBr019864;
	Wed, 16 Oct 2024 11:16:36 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj8px6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 11:16:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/bJwUzHjQXAcKe+u1Uy7hhyye6wnOFtJgnWJOgKDXOWuQl2J53ieZrYrwp4XYx4FkyVo9RKQoxuPrQrqL9C+1cnlUVfozQFIz/1ic/uPsDLQjZiXf8C8BRodfkVqDS4fSa44SMK1slNoGlN+aTBEv8hlmQUUFOv7vch15waazP3ksVEdJ9zGcsT8SevW/kpJOVOyc0f+tVtqSNJ1v+inuXPMOo3xjWSRvM/U1BnqUmJlBgeHLes/JIAvaT8yAF6ENo/QY/Ymbnl+kDVmYF8Z2Orn5w6QLg8PMbmTst76OPZJl5atsWPt21wFAIFuwK6kDh8Px0fYFFhtmtAPrKdcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4Nn1yy4zKB/9LQAlk+byvZ1JarlywApRcNSfwuRElU=;
 b=mlPvLLv+0lSm4eiNb64Jre5fINzCJmwAkUXssrbYASztC1HmBn6FBLd3vd27mQIhajaaMYzfNemD++VWarL+9g414DQ4QZauUGj6bLwYZ8qBDPwOeSALh5rvr7QVj43RJQd7X9RFgp1C/J89eqvtADnOTEGGE7ELnqTX9IzwjyFY6UbPiet0WQOb7BUZFL7YV4XosJN4MkdMfJTwA++mCorAezoXGdEA+KklLuTrjiheuQAnIzVdPmak4dy9SF69SssvtMoYrC9j+3Qo1EuWedtIky/T5EQBRi+smKJ9Hl1608c3Vl1EA+sXob08A2+KunXqlY+v3QbQxB1n0EG8ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4Nn1yy4zKB/9LQAlk+byvZ1JarlywApRcNSfwuRElU=;
 b=PNIxcDy9wheeOEApN2VQpFP1d0Bvse9+uBqMK1w3/bG4119SAIB3BV63dxlow2WFhSOCttoSNY7M0OVltZ8nyETh/CoBlPzwMKBWYKTPlIN2cBemAjITl7W3M0JwdaKwOKTg1XiPThDWKIGhNo5BBfsHE+mK+ifpB6TZ6eEHqS4=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH0PR10MB4774.namprd10.prod.outlook.com (2603:10b6:510:3b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 11:16:14 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 11:16:14 +0000
Date: Wed, 16 Oct 2024 12:16:10 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <04f2a791-6b44-4743-b074-bda537cbc8e4@lucifer.local>
References: <20241013223601.3823-1-spasswolf@web.de>
 <02217d08-bc08-4ffe-8e63-07878561f9b7@lucifer.local>
 <3b4dccf8dfbfb5a9d7c07a745c48a96164fbf19a.camel@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b4dccf8dfbfb5a9d7c07a745c48a96164fbf19a.camel@web.de>
X-ClientProxiedBy: LO4P265CA0267.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::7) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH0PR10MB4774:EE_
X-MS-Office365-Filtering-Correlation-Id: 2124e454-567a-4744-e457-08dcedd3f28a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L3JJ3of0RHMl7Ou3eZPnXDx5OpKDMTDlSZLnz9zylpzibYZyMLbsgOr5E3O2?=
 =?us-ascii?Q?teNtuX/EwHG3fTLIAM6DBrg6rkQY66OlIMdWSBia6W1wheF99w6HXdoc8IMq?=
 =?us-ascii?Q?h1q8+FDovVYiRMwQ3GaXH3nY0WFcx2eWWlhV9sUqBwLcE98LeOtL8hm56m7m?=
 =?us-ascii?Q?7JpBlmDvAKMvmdbEKybz2V22R+LPE1NU5vuKdg4qnrPtArJSKIuPG495z3Lj?=
 =?us-ascii?Q?4Gv8ZnKEGx2e6IRow13T4B61GgHWuVCcvfFoTmW1dJAGQe5vzDcep8qfyGPD?=
 =?us-ascii?Q?kBcz/AhhcSfFv8XSkbYmQ+NmLabAH2AW6tFYH8kWRbTAsm+kNIAEPR06W9zI?=
 =?us-ascii?Q?5HTH5uXWh16tPPaasyJYLJj8IRLmwixd+74Lh96GB6E5URz+ZSaD9jh1zLV8?=
 =?us-ascii?Q?lIZK8Hb2cIfPIU9xzvUnlmSknh2h24bKIKlYDnx29UnZgE3jjViqhlx1+t3V?=
 =?us-ascii?Q?jOk0Dn8/dPABDCthjMD1rRPvOW36ugsr5QXQ74S7sPiTSwb4mnZRE9xo9wd7?=
 =?us-ascii?Q?dw+eir/bpqjPt74kI6IUBe+V7q6WXClRw/WnNx4DHPvJi6l1X0mv1FUMZjFP?=
 =?us-ascii?Q?oEUC6UWMMjPQ8qESRfLShyMiwCynMy4eEKGCfu/OYIoivr60I49gxsoevWrM?=
 =?us-ascii?Q?Ay/jdho5y7MEFqRJak0fKxlrr0xYprZGCYdDUHzMQShrH/7jREunDSn0pxu8?=
 =?us-ascii?Q?9Etr4BAqYpRkRWl5+XKH/Z5Z1/9PXOLauaejs/bHJ9QTYDsAoBdvqBFGZNbx?=
 =?us-ascii?Q?mQBPhXbQK1r53smqlAvwWFN+oUuBoC4adE/TghcH2rdqp+KpCo309G64bGzH?=
 =?us-ascii?Q?avUdQzSEQXEj5mTpC9fJGJl9GJlfr9ky2LLw293/XxQUXPASyCFivvXpl08P?=
 =?us-ascii?Q?u/ILvihWTRu/8T0ET1SPVTANNTSNAjLewN5WrSaVac03obe6qAwj3BC/C8ug?=
 =?us-ascii?Q?j4uUgjTwKUg65R4y9QHhXMBI6cpGcIji3okR/owxzKvWAYPjEhZ1z0jEg2LX?=
 =?us-ascii?Q?TD9KJrv/0curlA0HEUEMSbkcZt+qgCCY+LNtA96Q2ug0ua5ldbifjB5V6hu2?=
 =?us-ascii?Q?QDuWhQab0FpCP0MlR6u4yWlEd4qPhVEafem5V45oI6Cfs5tQjNzjpL74hPeI?=
 =?us-ascii?Q?yyyBnU/T1txcLzUz6A6+IoNV3W+QkTnB6r97qpNaC8duGN7G9MdekPw0J7QA?=
 =?us-ascii?Q?9l2hOoWc+0pA0gjqjDBvl9BYufPgG6Q2O7FX8z/xo3MYGoaOfcjTKn2VMj8U?=
 =?us-ascii?Q?ygBP/3Yv8j7Dof0sRw43G76J8GdpNYlFiT8YazOXyQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CRDHEO6BFhqR3HdPt899Mt4qSnRWvLzKPa3yOqcL+1o/LTHEyQ8kym9OsoTe?=
 =?us-ascii?Q?RFqDoTi59GIOjTXBgCwhv5uAFB/Gw4VAushU+Yf964XqDNrpMnXgUiOB4Ezk?=
 =?us-ascii?Q?I21JIOZZtwmfd9OW7IIKVH9U4pvbpL2kBChm9+UrDrDDiyWz5GacGyFom4R9?=
 =?us-ascii?Q?OMpB5kD1hg8lt/UPyOn9wCaTw9cGuIke65Vnxs2PSwyxHF5bH/sfr2KaBGzk?=
 =?us-ascii?Q?Renf0O7Ci2oXxHUi1mNgjZaPeh8xqDsMgmlSs87YUQE3UqkNsKfsdNqQS8tj?=
 =?us-ascii?Q?zGZHRy1Zm6WVAJkaAHbygKPihalcusc6Ipe5QoCz3UxM0EsCZpk5KSv5ZSTl?=
 =?us-ascii?Q?LOYSuX3gkGHIskbtdmWSbKu6IzmMlt9/wlUO5TqR7XmF8cmNmDputlMwMllj?=
 =?us-ascii?Q?mtMvS1JWc5IzbbSYhmnVN1uuLC4CVQK8+uI3iTFQ7eG7qq5hHWL/AEz65On4?=
 =?us-ascii?Q?KLgzFbrcOrSa/4D8o1tIXOi6u/1HG+nacAV3XvvS2uOtF9Wt0TRrHRxXyDv1?=
 =?us-ascii?Q?wFY6VdVBgaF9AQ0FCWxOmoIKGc5ICXIwsLfJtTpLGikNOvECigzd+vCa3EuR?=
 =?us-ascii?Q?u6C5yQEIX8rx2YXR+yB9SqIsFYuFrhx88akmQEjrQ+VbMLibBQcv9/5BpPVb?=
 =?us-ascii?Q?t35sMyjlpq+G2+10nEldPImRAGnclaSJABGT4bobSFHYutbXUOmQpZ55y6qI?=
 =?us-ascii?Q?sVq2JLGr7dtEocUIsCv3EBqPkBDVQviObxeJk51MpfnNlpE70Fcmi2gh/PQG?=
 =?us-ascii?Q?N6eGuPMuLyTM+5oHnHl6FmapAROnLuFt029/7eIuzd+ymF1T7mpFO48onKl1?=
 =?us-ascii?Q?dKDsfEZXj65UaX3E22mzDaGTpa+GyRMl4+s1Va0/6kpIQwKVCDZPqzzRbh2b?=
 =?us-ascii?Q?7mWjGPScyedeXpB5MgegB6oc0RDjJA7yLoiEpBfI+jf2huqx5uozE/+MLMbf?=
 =?us-ascii?Q?YFHise4dQHaUxDTvRKepC9cgXqJAU9hBIFOy8Nx26BDsjpXCBiH8Fh0gdqBv?=
 =?us-ascii?Q?JqqkNRA+MpmKZ1e8xdLMbthvrUPZavb5jze9i5oIzt2IdRaho7BUcQNpkIJJ?=
 =?us-ascii?Q?VJnzkJR/iVnX8fEzxLAq37Eyop1bIvvYsx7/fXJorbU6348aa0KkvlgSyAl1?=
 =?us-ascii?Q?MksHBxsyWL0jpo6rsMe2a0FWhboJJ76J5Ts8l7k6AWJx/mAavFKmkMTFugu9?=
 =?us-ascii?Q?tZnTtALJ5yNXqPunulUghD35dqY3V9+wuUBbe/kgdQHmqAvTYu95/XG5x/zd?=
 =?us-ascii?Q?uxMmgvQlJgp1amW685PmBhYRGnKHIAx1JLEODr0MUcnZ9MXRXdZzPNtaGxIy?=
 =?us-ascii?Q?j3XdvCfozvJkNNl90Fch1/syy2znbPc82VJDV17HcMy/N0j0mDqHmvwZdC4F?=
 =?us-ascii?Q?MGyjpVzO3/xgcV9dvPRPHxn3wc4fGEY3te7kfQb7/eLRTVnurG/4R4bfwHxN?=
 =?us-ascii?Q?uljiV1BwHJ0PQiBng2a7Uwze1RiXkKCx5p64wVjMUgPCNTpym/J25V6IGeGP?=
 =?us-ascii?Q?OdgOYTFLhVq9e/veDEQLF/R8Brt/bWBQD0nynW/gzUaSD1huiwD1vzuzskX1?=
 =?us-ascii?Q?eMzODy1nzLtc/MQTPRJo4/IXFwaGiESPLYPgroX2tmtFcnV6L16t2h12Wwcq?=
 =?us-ascii?Q?7xvc2RBnika2sGCdkBt14UEQvBwLNoVXoUFub8ayF1RD9Fell0GjkbhaCTYO?=
 =?us-ascii?Q?Ar7URQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1IS9Lbe4gpV/J2E7o//BSxiTYI4KfpoTAFxkKIlPhmUtuuG4OZWCqlTj1kiPabW1+fQtqXAxMcNdlPZWxIuGX2Y0ZUVEjf47bJeiVjRNC/dx0KCHnMYQLrpLiCwN/iBgcgwFd1OwbVm7FZfaH3XuHfFSHoUQdTns3oQO7I8q+5TPeekmdewq1FSKOEJnYgl6EFgfysUo6qId4z95zzeLbaEvEP8C47sqyCRd+bNjou6QA433FG/odKlt1mWVHxBlCEJwJoETQcH486qFY1NSUP6Qj+fUXtRwvSAaAfZ58PygLz+HPHJOrB5yMpYv+yq/BGd4Rg3YmqnudlNmeUfmtMUoudzR3PzUfVHdT6cS7x7UX9KdM5/0mbtFAMS/naaVx2yQ+cNh41IlFBRjsL0HMj+Dxy8iUpCi83Y2czzlcugvUznal8w5XmHjiVxXGlGdzbeIqIxG6HYYbOWXVKLEdz1KLyz4BElSFvSMry/Qi8aftgGdKlkXFAsYsUknEvf2dOWsXcn6vGJfh13rztN+weq+lWPWJACgF5oc1jlmL6k8Qstqq9gHhq0DIIsXMRvF8oiZ7nlHZChBFwz9tQsAw2GYdVMn26wdUBFWIvzTiOc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2124e454-567a-4744-e457-08dcedd3f28a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 11:16:14.3866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MGKTHPMBjwB1Kctv/xhkZDG1dY8Yibh9GvCfFMtyU0vX8OHjKt5XRIyW2HDDZTHqj8VXAF+yViTZlSDb9zKrc+5v8t8oiyitQMFKsUjB8WU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4774
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_09,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410160070
X-Proofpoint-ORIG-GUID: 39jU5BN6HzTyzOrrAjaHpUuXZGU8EuZt
X-Proofpoint-GUID: 39jU5BN6HzTyzOrrAjaHpUuXZGU8EuZt

On Wed, Oct 16, 2024 at 12:28:51PM +0200, Bert Karwatzki wrote:
> Am Montag, dem 14.10.2024 um 10:46 +0100 schrieb Lorenzo Stoakes:
> > On Mon, Oct 14, 2024 at 12:35:59AM +0200, Bert Karwatzki wrote:
> > > I created a program which can trigger the bug on newer kernel (after the
> > > "Avoid zeroing vma tree in mmap_region()" patch and before the fix).
> > > My original goal was to trigger the bug on older kernels,
> > > but that does not work, yet.
> > >
> > > Bert Karwatzki
> >
> > Thanks, that's great!
> >
> > For older kernels the problem should still be present, the fundamental
> > thing that changed from the point of view of this bug is that merge won't
> > contribute to the number of VMAs being overwritten at once.
> >
> > To trigger prior to commit f8d112a4e657 ("mm/mmap: avoid zeroing vma tree
> > in mmap_region()") you would need to create a situation where the _clear_
> > triggers the bug, i.e. you must consistute all the VMAs that are being
> > overwritten by the store from existing VMAs you are overwriting with a
> > MAP_FIXED.
> >
> > So some tweaks should get you there...
> > >
>
> I don't think triggering the bug on a clear works, because a write of a %NULL
> that will cause a node to end with a %NULL becomes a spanning write into the
> next node:
>
> /*
>  * mas_is_span_wr() - Check if the write needs to be treated as a write that
>  * spans the node.
>  * @mas: The maple state
>  * @piv: The pivot value being written
>  * @type: The maple node type
>  * @entry: The data to write
>  *
>  * Spanning writes are writes that start in one node and end in another OR if
>  * the write of a %NULL will cause the node to end with a %NULL.
>  *
>  * Return: True if this is a spanning write, false otherwise.
>  */
> static bool mas_is_span_wr(struct ma_wr_state *wr_mas)
> {
>
>
> I think the could would trigger in this situation
>
>               Node_0
> 	     /
>             /
> 	 Node_1
>          /    \
>         /      \
>      Node_2    Node_3
>
> but only if Node_3 contained only two ranges, one empty range and one normal
> range, and if the mmap into empty range of Node_3 would merge with the last
> range of Node_2 and the last range of Node_3. But I think the rebalancing of the
> tree will make it very hard if not impossible to create such a node.
>
>
> Bert Karwatzki

Hm well that would explain why we couldn't hit it so easy in the past then,
and is a good thing... :)

Still the bug is still a bug even if hard to hit from mm code and should
get backported (obviously you're suggesting otherwise, just to emphasise :)

