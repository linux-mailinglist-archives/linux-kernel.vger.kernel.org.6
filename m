Return-Path: <linux-kernel+bounces-437709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 288809E975D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F3911882004
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BE3233156;
	Mon,  9 Dec 2024 13:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BvS7zinz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DYohkpF8"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A47233135
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751695; cv=fail; b=MSu7FmkxvJkBQiLZZHQTCNbDJ/GUdTklGwj0zBTiaJi3u33OeT9w9yUjy1/LnJepRLIgHRQP17Zjf2urByQGVYK4IOqiboKSGyNkEJTzF+Bovgfaxc2s6+H6G+JowpZM/5v9tIBT1NKDmm6A0+x0XmA/6ZAmpKTOjuMMzOehFuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751695; c=relaxed/simple;
	bh=5pJuT7HeQIHnld/R8RDNIDzPpiYpPHM9wo2VnbLgUDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ootdtd8SqEmmIPjn6bWZ8TQ9fsuhe7bkVgXdFb0X/PwU+gzGNeFmufcE1JZZ+PR7qvDyZ6oHL0rBXap/rX61P6e3cUyjUC9XQISp5VzjryTm8jm/QYFcnRBoC5aqKXSkTuQrwr++ZIdrrqqfAPNyFXZRj0wtlkAljDI6/SDT6a4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BvS7zinz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DYohkpF8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B99hKsD004541;
	Mon, 9 Dec 2024 13:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=fejpPg+/PrOF9U0rZL
	eE+lWXBMowT9HiHcSq4cFS03M=; b=BvS7zinz5Cm8Xr8jb03yO8gUureNRU4x7e
	rKlJjqoBxUE2Nd4KnwGBeOMKtDfIg0ZnQctvakJn+4eFAQ7JI1wS9hHf849mdbgK
	AtrFgdGhxXOBs2n4UPAJVPlXphBP8AdVHwqfWQqpXNP2E8EgnWhu+ttN73BpQPrd
	VMtIAp+twY0GCCJuA+w9O5YhSH/E7CyrrKgdmJUKqoCTQgiOjCgcjqeSahv1lR4g
	U4gmCw+YExCJtlq6+BL0uXEuXs7K+pqyhrOdvwCnNeCs0jg8dBhia4R6w0E0oddv
	EFKjlJQj855WmSB/RwlSSwvddc/S49GOLrPYnvcbp4U+3g6DGyMw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43dx5s0d3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 13:41:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9BvamZ008814;
	Mon, 9 Dec 2024 13:41:22 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct71ueu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 13:41:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQzJ57C1eadPCv2YhZpL6yfApjII1tuftkYlIMFc1Gat0ZXS9lcwguNdmIEJ7T4UBbDAehNrLokbTxTSRSEc22ftjcfvsyHO6lRbjoXXu3TPzm/TUqKNDAFyPtsjz8HCe3EPqx9Rd86CNSC9UkJNAjPrDHfK5xbe2P29NqEHQt5cuVTtXfB7JEWJHVu7kbkh2gTMbtESHWInwv6aTaArkG5u6CQjKB5wVQiH5C5kuEifVmYgfhG/Lljct6yLJ3dT/Vqql1/pXdN5GWb8lMaM1mIagSe9t8cGFylMBcz/Kn7fbPGa8gwGYg/5D4fBCYk6mC27DYvfppqzace5yV2xYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fejpPg+/PrOF9U0rZLeE+lWXBMowT9HiHcSq4cFS03M=;
 b=jhLzu/Xq2goe0Q7jw44pdV4tfXLE3CyjnOof9+dcHKgAEakokqx6EKwta33OiepswvJQMd8xoOE7OMPA4NqITzOaL23hZoMmhZJnxpbzS6+7cpD6Y5DacXWjDpXA8KFo87X4cm3PPfoalcRtCLOrzSQkCLsbr3gz14LXBmCEGN7KTfgPZ53Tb4cKaf5hEvTtqvBFW4+CW/Lv9JJIYW6tV+11D2HSNobcUpx0sLmIJaZsTd2zjSYIGRYd3WqwG6E2QamxFV5DsG3V6Y8uh8gBVmswzvCkmtzjsIiOrEwn60Ydpchg1cQRwj/8c0IhJDB8zim2oaAtkuQyR06Y0vMekA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fejpPg+/PrOF9U0rZLeE+lWXBMowT9HiHcSq4cFS03M=;
 b=DYohkpF8JABrGnb9GqyJJsHIyGco4sCdli+FxMWuSZjhpyWKYGrPJqDkhss2dyZjpZcN+E7wdyL/UgNR5Pk5lZKd6lY+F/4Qk9e2X3l+KMlCaJ0uTzZLrRlM+78AhZS30cRGEJS3RIpiPflJQV1gTClJFgu1gBUsVgJgoPQ8dDY=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by BY5PR10MB4339.namprd10.prod.outlook.com (2603:10b6:a03:20a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 13:41:19 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 13:41:19 +0000
Date: Mon, 9 Dec 2024 13:41:15 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: syzbot <syzbot+2d788f4f7cb660dac4b7@syzkaller.appspotmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] general protection fault in
 find_mergeable_anon_vma
Message-ID: <aa2c1930-becc-4bc5-adfb-96e88290acc7@lucifer.local>
References: <6756d273.050a0220.2477f.003d.GAE@google.com>
 <1b8b5d54-d667-4ca9-b831-bee4b4e74c40@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b8b5d54-d667-4ca9-b831-bee4b4e74c40@lucifer.local>
X-ClientProxiedBy: LO2P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::22) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|BY5PR10MB4339:EE_
X-MS-Office365-Filtering-Correlation-Id: 600a1ac9-7beb-4f40-dbe9-08dd1857296a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I6sGtH2Yt4CIcCiqo7ZwHx6D7lYASWdgwcIcwcXcRA8eQ/WC5mSC7z9JAzH/?=
 =?us-ascii?Q?abAgb8ZFxYy1QGIzzouD1a8FSSjRVI+GHZ8eWB+xMyMeDAggPQlRVYNHifuv?=
 =?us-ascii?Q?Fx9EO1ERntSMliw4g3C1Hsbuej83c5WofBilO0WsOGUzbvxN9G5VxxBIOgcI?=
 =?us-ascii?Q?Zm+d0ib70r9Ym+TFIIhMtsQB+oDmzvLcpF4FVaWYc9frdOAuWLd2zBu3G/xp?=
 =?us-ascii?Q?aySr5IWH1qsNPcvsY99+kxkZzThLnvzX94tYtVeclW2JzV2GIZrQp5YvamQk?=
 =?us-ascii?Q?03mgZd20bXJrkNm6ipLrBVgo6pGbNu/4Zwg05k6CS53QR23SpAInDI+A95hF?=
 =?us-ascii?Q?4b1bZ3w2acj+9HmkziDisiV3HJk6ZqjvrSSrYNZ230kKoMND54HqkI1iJzMn?=
 =?us-ascii?Q?Chzk0IvPhrp65jmKE5mTWNIKmxGSrvemKuitRAigFxElNsHA/+IpWd3+VhmD?=
 =?us-ascii?Q?iZZoXlkHHSNBPvXrkazn2otzOuDrBUCJqczq643oHhdl3bzmXNmLPp0ESIC+?=
 =?us-ascii?Q?d6EofHhDSLUU/aGnnZZHGxPTURvCXKod0TlIAqIMp2J4drvzKqaDEzZnJojt?=
 =?us-ascii?Q?MDcgjdcpy8KLXQn5RPAiOhD4qdcAunMCW+uMOxY0GyMttY3UsdF/NXZE1ccE?=
 =?us-ascii?Q?Upe2l7CmxiYOqJf3pu1yIjLhUTAlJyWwv7cOrOJ2NFPwk0v8/EJPvhHt1fol?=
 =?us-ascii?Q?QnBFdnlc5geEi0k2+LwX53uGldfA097dvAfGbuWkDDIXEE9OX9Uff3ECEEax?=
 =?us-ascii?Q?hG6OS7eVfwGLvjP+maJDAQpjTDCcya5rtAfEY1f2IpVB2utjPAnTxoA7S80k?=
 =?us-ascii?Q?IlCQO54PAD/RSmDnGii6isZSGbwYpfHkJB8uSVCFwqKrjkvoKSrWo4dzU2ji?=
 =?us-ascii?Q?YpyfSKWhjUdc8tQcAwP9LZVMQDT++VWUXPhq/0bkA/YixlQpiS+NhiXNvCz6?=
 =?us-ascii?Q?WxlAaoGLTzW2tpLbEUprkGrIZq61t3vBPrShqY3PINj1JOWPgvcj3SgEEi6I?=
 =?us-ascii?Q?RbwV/V4U/3h+nJZ2MnnLrsBDS4po9MvRoo547YjEeT+jXBfKRrobIVDaQ59X?=
 =?us-ascii?Q?xseUi//XNQEZtAUEECVLgOaIYyF0mJ8nYn1XTN4nOzEA9d/HxlfI0xVieZyE?=
 =?us-ascii?Q?NUQ47pmk9jhGUR1r06CQrSYwtQX6daXgr68LX8NfKubTzAuWUqnExvKkgs4x?=
 =?us-ascii?Q?nW0xdPSuJVbRAgZbhVCXeHKL8E2NnmmYxblu2CqTjPnm2WFBAGPb4f6mjGkg?=
 =?us-ascii?Q?205NYUFB8YGvTNI0zBvDEMTKXcaNOWjpN8w1+aWSlN059gPTxTvY8Ii8/8GG?=
 =?us-ascii?Q?Wf4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bzOuBvMXw4fBDpHWQuRJ18yH4EhYm5vjUL43lGkhHo0VEGbj26zwWHPTvNX9?=
 =?us-ascii?Q?/AXFcNIeoctOZmafi+nlCgE3dCub5h0NBjXR4yjcHpgCtsY3fRuRu9Q+81d5?=
 =?us-ascii?Q?VCCVLn47BXGysAqofxRb88FZKKex9fsIhYsdHILMdwmI5YnRbjRPJjNYzbxk?=
 =?us-ascii?Q?RDlV2C2EYcVfVwMc7PbCrmcMxRk1jnWC/sDajImvwo0gAdwT93q+30NasOyW?=
 =?us-ascii?Q?xWcMnGir7K+0RECnKuzSdl9X7oudFoyXDznRqP7dRGwX2hxtc4sxT3mRxGgC?=
 =?us-ascii?Q?gWfibTB/4j6SsuPNpyj3RBsEJ+/iMN4ZVVGsSLL076I3EERh4W7+h45JXN7o?=
 =?us-ascii?Q?c+1Novj7vvuIoLcJnqChO9oUOAvywtbqEfC9nqwpN6DhCvS8DyKFlXk1prPJ?=
 =?us-ascii?Q?2kYdHyvg69NauMjkEN63SY5dCzPcybld36dC2xhlvaR6j0+jiWLpO241+znU?=
 =?us-ascii?Q?GqgOOqd/avhb7oizzur5sV7SZOwm8lGzMxwr8h40G8333m+LRRj/8l80ZU07?=
 =?us-ascii?Q?aCNtZ23VWEASmBJuWUGATWrsCJoR96Lmg/beinUiRKGNUMLzBvnr4ac3CaOK?=
 =?us-ascii?Q?BWii/CnHUeqEMAd1U6FPb8Lt1A8zt+fcXPqZAZ2wNizgIShTn75+dki0cvnr?=
 =?us-ascii?Q?OLwe2VZ/xBpybpZhlwmGTxduOuyFVY7nA1uo/XP+iO3p3QLwasYySfbC0PJD?=
 =?us-ascii?Q?6cSpWsB5fLWvbzwxHFNzZ+4K+8XJZJdryoWYHpklCYsDn2/mCIb88TbJHNEr?=
 =?us-ascii?Q?/LZaA4MkQln1hAenrCjLHcti91v6LUPebNdDpBuFGRHjUyycWbCXQyNwmB31?=
 =?us-ascii?Q?B6A6znhxAmTx+BMakK/g9CUNIjuKlGT6grZMsFQ5jZlru2kVMt0MJE4nnf5U?=
 =?us-ascii?Q?4b04sB1AEgcLJO9lHMlfNbNiviUfjoM0WtT4i/jbx/YMVJVPgOP0svYlgDJc?=
 =?us-ascii?Q?Usypzv531Z4fgA02lP2oTvBbup8/Ldx57Q8rlKipoYlyiweFyARgaWHN8nBo?=
 =?us-ascii?Q?F+UmbY9Apxsz8iIBR+4A9XzXJTUUzAyCdD5O52rOP9LwiuxsJTSNJv933xw4?=
 =?us-ascii?Q?yTXu20WlTRN08RpkgQO052FSyZJ7NF6kWfMyXzDD23VAc2nh4PNlEOkFkIQO?=
 =?us-ascii?Q?wk6YXiwFZBmQW9Gb6PQVsCSuDQfZoAf7X+bcGREmc/PzgjJdFt/nKeVAuB5h?=
 =?us-ascii?Q?k0rBbjNcrqYhzBtr18FQZlPJKlboGNe2Y/8kzvtTKXOxUwc5z8PvRDySf4gY?=
 =?us-ascii?Q?oYV5mDbsrRAcrAENGcrs5wQDCQsZDykZmjMqq/XdBcBWMm/drC4srSqlQwLo?=
 =?us-ascii?Q?HQdIGNI6Zi6JqRCJsmHEylATrCb1QQLDLKJevlpaqAJ0iBGmhkb3T0xPeLtI?=
 =?us-ascii?Q?mtqFCw2Okyx6AtpFfGveTDW+GzfkEUXra23j+m+TytbfvbNZA9AP6lnCiuZH?=
 =?us-ascii?Q?/1WoJ4gzSQf9N3Utv9OeDieTz29S8x/v3DPYZ1mMi4m/HcRFuytLd84CAZBc?=
 =?us-ascii?Q?at5KP3VrgBgTpO45tNzOJLz+f4YT7LiUnc47qhY54ihj5M7tQyla6/XqCKuN?=
 =?us-ascii?Q?CISsKjqyaZfmw90PNJQ54/Ouixc+26/79bdsedSS6kT++GWZ3uEo6ziiDaSC?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qAbY3D3KAwXWA/g5Ll5D5Er025vTDY9Wz9G8mKaOSHlTdlmRe0L2BFqAR4qJv9JKwiCmHk4Yp9iqAkB1W5WuHghLR7kacbAJBzRltdFXPmKepHbf5FTUwuGklCU7dXZCtDvIdwGfRpaipIuXy+P1rJ6DvxFSgz6TmESU7WSXCQA/ytkq4gbDlsIa2Y/64at8jMEyDvat+w4mnPxPO7DuC6bvmkBJdkhPa+27OgA0iKVE4VldjUKylEm/yTwxT/BUB/MefyUwg4/dITQzT6s/JuQ+giWRHN2YmzLnFvYKT+uig2+XtZHvfk8wkgvv5mJQtpKDE5rs2rrKlx8OBkIpR51as5j5qB4oSqoBg7wnibXx1T8bHfVbKC1WTtEasoIkUi5gyrqXjR1+AlNSfPNpaOB5cLJoyn6uqDP9Bxt/QTho/NeGyYrULN0QkUrMyaQleDPDap34guDGV5dmFD8XmE+JrJGIW0JKpC7XOpfqi1fy/01k4Gs6a782L/KOMsWQfT02H2A0HklvZ4XfTpumAg5ks/9hR8HQqTsSL6Jn50CBDOPJMO6O6MCvQR9VXvBAghdSyC4K3SQ8uTRdBxKJ6YE2IzZ3OAluJhdx/+UcncE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 600a1ac9-7beb-4f40-dbe9-08dd1857296a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 13:41:19.3796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bv2UG1+NIsqRP5cmcfs/49c0dR1Hfi3dZ00ua9e8AgF9sNL0EdPWgclzkzGpz+golYLiGTRp8/Obl+ysvWF3WhRNV0skVz/YJUwCYKr94pM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4339
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_10,2024-12-09_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412090107
X-Proofpoint-ORIG-GUID: rzh3DDM-VRzyTMJQjtLEdg0IYMwBT47A
X-Proofpoint-GUID: rzh3DDM-VRzyTMJQjtLEdg0IYMwBT47A

OK I think I know what's going on.

As mentioned below fault injection results in:

 	mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_end - 1);
 	mas_store(&vmi.mas, XA_ZERO_ENTRY);

Being set in the mm.

Then, in find_mergeable_anon_vma():

struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *vma)
{
	...

	/* Try next first. */
	next = vma_iter_load(&vmi);
	if (next) {
		anon_vma = reusable_anon_vma(next, vma, next);
		...
	}

	...
}

So we use vma_iter_load() -> mas_walk() -> can return an XA_ZERO_ENTRY.

So here next might be equal to XA_ZERO_ENTRY.

Then in reusable_anon_vma(), where b == next == XA_ZERO_ENTRY:

static struct anon_vma *reusable_anon_vma(struct vm_area_struct *old,
					  struct vm_area_struct *a,
					  struct vm_area_struct *b)
{
	if (anon_vma_compatible(a, b)) {
		...
	}
	...
}

And in anon_vma_compatible():

static int anon_vma_compatible(struct vm_area_struct *a, struct vm_area_struct *b)
{
	return a->vm_end == b->vm_start && ...
}

So b->vm_start which is offset 0 into the vm_area_struct attempts access at
0x406 and *boom*.

So we need to be a lot more careful about our use of XA_ZERO_ENTRY.

As per Jann's reply to thread, R13 is set by KASAN to the value, which is
0x406 or XA_ZERO_ENTRY so I think this explanation is pretty much confirmed.

Liam - thoughts?

On Mon, Dec 09, 2024 at 12:53:45PM +0000, Lorenzo Stoakes wrote:
> On Mon, Dec 09, 2024 at 03:20:19AM -0800, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    feffde684ac2 Merge tag 'for-6.13-rc1-tag' of git://git.ker..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17f85fc0580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
> > dashboard link: https://syzkaller.appspot.com/bug?extid=2d788f4f7cb660dac4b7
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
>
> Points to this being racey.
>
> >
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-feffde68.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/6135c7297e8e/vmlinux-feffde68.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/6c154fdcc9cb/bzImage-feffde68.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+2d788f4f7cb660dac4b7@syzkaller.appspotmail.com
> >
> > Oops: general protection fault, probably for non-canonical address 0xdffffc0000000080: 0000 [#1] PREEMPT SMP KASAN NOPTI
> > KASAN: null-ptr-deref in range [0x0000000000000400-0x0000000000000407]
>
> This doesn't make a huge amount of sense to me, the VMA is not 0x400 (1,024)
> bytes in size... and the actual faulting offset seems to be 0xdffffc0000000080
> which is 0x80 off from some KASAN-specified value?
>
> This would be vma->vm_file. But that also doesn't really make any sense.
>
> But I wonder...
>
> I see in the report at [0] that there's a failure injection in vm_area_dup() on
> fork:
>
> [   73.842623][ T5318]  ? kmem_cache_alloc_noprof+0x48/0x380
> [   73.844725][ T5318]  ? __pfx___might_resched+0x10/0x10
> [   73.846687][ T5318]  should_fail_ex+0x3b0/0x4e0
> [   73.848496][ T5318]  should_failslab+0xac/0x100
> [   73.850232][ T5318]  ? vm_area_dup+0x27/0x290
> [   73.852017][ T5318]  kmem_cache_alloc_noprof+0x70/0x380
> [   73.854011][ T5318]  vm_area_dup+0x27/0x290
> [   73.855771][ T5318]  copy_mm+0xc1d/0x1f90
>
> I also see in the fork logic we have the following code on error path:
>
> 	mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_end - 1);
> 	mas_store(&vmi.mas, XA_ZERO_ENTRY);
>
> And XA_ZERO_ENTRY is 0x406.
>
> Now if _somehow_ the VMA was being looked up without XA_ZERO_ENTRY being
> properly accounted for, this might explain it, and why all the !vma logic would
> be bypassed.
>
> [0]:https://syzkaller.appspot.com/x/log.txt?x=17f85fc0580000
>
> I mean the weird thing for me here is that mtree_load() has:
>
> 	if (xa_is_zero(entry))
> 		return NULL;
>
> So you'd think it'd pick this up, but maybe if we're not actually holding
> the right lock we get a partial write/race of some kind
> and... yeah. Anything's possible then I suppose...
>
> > CPU: 0 UID: 0 PID: 5319 Comm: syz.0.0 Not tainted 6.13.0-rc1-syzkaller-00025-gfeffde684ac2 #0
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> > RIP: 0010:anon_vma_compatible mm/vma.c:1804 [inline]
>
> This is in:
>
> static int anon_vma_compatible(struct vm_area_struct *a, struct vm_area_struct *b)
> {
> 	return a->vm_end == b->vm_start && <-- this line
>
> This suggests that either a->vm_end (offset 0x8 into the VMA) or b->vm_start
> (offset 0 into the VMA) are being null pointer deref'd assuming the compiler is
> specifically referring to this _typographical_ line rather than the expression
> as a whole.
>
> > RIP: 0010:reusable_anon_vma mm/vma.c:1837 [inline]
> > RIP: 0010:find_mergeable_anon_vma+0x1e4/0x8f0 mm/vma.c:1863
> > Code: 00 00 00 00 fc ff df 41 80 3c 06 00 74 08 4c 89 ff e8 10 39 10 00 4d 8b 37 4d 89 ec 49 c1 ec 03 48 b8 00 00 00 00 00 fc ff df <41> 80 3c 04 00 74 08 4c 89 ef e8 ed 38 10 00 49 8b 5d 00 4c 89 f7
> > RSP: 0018:ffffc9000d3df500 EFLAGS: 00010203
> > RAX: dffffc0000000000 RBX: ffffc9000d3df540 RCX: ffff88801cf80000
> > RDX: 0000000000000000 RSI: ffffffff900062a0 RDI: 0000000000000000
> > RBP: ffffc9000d3df610 R08: 0000000000000005 R09: ffffffff8bc6b642
> > R10: 0000000000000003 R11: ffff88801cf80000 R12: 0000000000000080
> > R13: 0000000000000406 R14: 0000000021000000 R15: ffff8880120d4ca0
> > FS:  00007f137f7e86c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000020000140 CR3: 0000000040256000 CR4: 0000000000352ef0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  __anon_vma_prepare+0xd9/0x4a0 mm/rmap.c:199
> >  anon_vma_prepare include/linux/rmap.h:164 [inline]
> >  uprobe_write_opcode+0x1a95/0x2d80 kernel/events/uprobes.c:516
>
> Here we find the VMA via:
>
> 	old_page = get_user_page_vma_remote(mm, vaddr, gup_flags, &vma);
>
> Actually one unfortunate thing here is... ugh god.
>
> I think there might be a bug in get_user_page_vma_remote()...
>
> I will check in more detail but I don't see anything that will prevent the
> mmap lock from being dropped before we perform the
> vma_lookup()... FOLL_UNLOCKABLE will be set due to the &local_lock
> shenanigans in get_user_pages_remote(), and if we get a page after a
> dropped lock and try to vma_lookup() we could be racing... :/
>
> Let me look into that more...
>
> >  install_breakpoint+0x4fc/0x660 kernel/events/uprobes.c:1135
> >  register_for_each_vma+0xa08/0xc50 kernel/events/uprobes.c:1275
> >  uprobe_register+0x811/0x970 kernel/events/uprobes.c:1384
> >  bpf_uprobe_multi_link_attach+0xaca/0xdd0 kernel/trace/bpf_trace.c:3442
> >  link_create+0x6d7/0x870 kernel/bpf/syscall.c:5399
> >  __sys_bpf+0x4bc/0x810 kernel/bpf/syscall.c:5860
> >  __do_sys_bpf kernel/bpf/syscall.c:5897 [inline]
> >  __se_sys_bpf kernel/bpf/syscall.c:5895 [inline]
> >  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5895
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f137e97ff19
> > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f137f7e8058 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> > RAX: ffffffffffffffda RBX: 00007f137eb46080 RCX: 00007f137e97ff19
> > RDX: 000000000000003c RSI: 00000000200012c0 RDI: 000000000000001c
> > RBP: 00007f137e9f3986 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 0000000000000000 R14: 00007f137eb46080 R15: 00007fff36be56b8
> >  </TASK>
> > Modules linked in:
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:anon_vma_compatible mm/vma.c:1804 [inline]
> > RIP: 0010:reusable_anon_vma mm/vma.c:1837 [inline]
> > RIP: 0010:find_mergeable_anon_vma+0x1e4/0x8f0 mm/vma.c:1863
> > Code: 00 00 00 00 fc ff df 41 80 3c 06 00 74 08 4c 89 ff e8 10 39 10 00 4d 8b 37 4d 89 ec 49 c1 ec 03 48 b8 00 00 00 00 00 fc ff df <41> 80 3c 04 00 74 08 4c 89 ef e8 ed 38 10 00 49 8b 5d 00 4c 89 f7
> > RSP: 0018:ffffc9000d3df500 EFLAGS: 00010203
> > RAX: dffffc0000000000 RBX: ffffc9000d3df540 RCX: ffff88801cf80000
> > RDX: 0000000000000000 RSI: ffffffff900062a0 RDI: 0000000000000000
> > RBP: ffffc9000d3df610 R08: 0000000000000005 R09: ffffffff8bc6b642
> > R10: 0000000000000003 R11: ffff88801cf80000 R12: 0000000000000080
> > R13: 0000000000000406 R14: 0000000021000000 R15: ffff8880120d4ca0
> > FS:  00007f137f7e86c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000020002240 CR3: 0000000040256000 CR4: 0000000000352ef0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > ----------------
> > Code disassembly (best guess), 6 bytes skipped:
> >    0:	df 41 80             	filds  -0x80(%rcx)
> >    3:	3c 06                	cmp    $0x6,%al
> >    5:	00 74 08 4c          	add    %dh,0x4c(%rax,%rcx,1)
> >    9:	89 ff                	mov    %edi,%edi
> >    b:	e8 10 39 10 00       	call   0x103920
> >   10:	4d 8b 37             	mov    (%r15),%r14
> >   13:	4d 89 ec             	mov    %r13,%r12
> >   16:	49 c1 ec 03          	shr    $0x3,%r12
> >   1a:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
> >   21:	fc ff df
> > * 24:	41 80 3c 04 00       	cmpb   $0x0,(%r12,%rax,1) <-- trapping instruction
> >   29:	74 08                	je     0x33
> >   2b:	4c 89 ef             	mov    %r13,%rdi
> >   2e:	e8 ed 38 10 00       	call   0x103920
> >   33:	49 8b 5d 00          	mov    0x0(%r13),%rbx
> >   37:	4c 89 f7             	mov    %r14,%rdi
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup

