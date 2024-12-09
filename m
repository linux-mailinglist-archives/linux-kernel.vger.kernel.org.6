Return-Path: <linux-kernel+bounces-438199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B5B9E9E28
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260B4280169
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A135E175D2D;
	Mon,  9 Dec 2024 18:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k/E4e+IU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="emPLJy7J"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EB87080B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 18:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733769407; cv=fail; b=h+x5rSAMQD8W3p0Rqn1majrm2XY1f4LithBiWdYC4k74PHNkVqiVdIagXTNmaPE3OrrzGvY8KI8Rt8AkgMtWgkY1Djrq3amOCQYs8OL+fHweEaTq4Ib9o4irskf5MVyp8m1Zou2F2MvujTXVERkHC+Y2nkIkPFiU+1XIROKID/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733769407; c=relaxed/simple;
	bh=mL5XF0OzKo9/Slzlzku6DqqTzfpD0ww/sUsV4VzajkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZBxKvQEOTx3w/alVsKBJiv1jki+Lj8nZT6XsNECRTRmoFk/0W6npo5ZiU7/qbh9nag9xFSTf2he6F9HuzGNmBykqtk9QZPz7Wt30IMH1N7BLyLPnIAGbeyH2LiaJ4hlzx4xeo4+6eGJJZ2sLBM/zHjBdF/wmBby7V+7TxtwoChg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k/E4e+IU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=emPLJy7J; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9IBmTU004558;
	Mon, 9 Dec 2024 18:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=LkAorfkyWaH7Pdju/m
	iy2Pn02zcZwCaS08nXLvUJQwU=; b=k/E4e+IUmHIXH6Vijcvvr5RJgMvb037o86
	dX/7IPkvHVK/s7NxzkqPfrvVECsxP1C6uZmYM2BmrAJwLm7DZCu+EkoH98jzrsTq
	kekLCX13U5dHLHmM3E3Ycp2KlRK8IzP4umacucsVzSjjDl1UGSITHTY8WkrZj1mP
	MdoIyqExRBmqA8PwIUhU2w/SQJ/OhY+YsmNo7nZZYXQrl51pep72KoKFZyTmK8Pu
	C4OfU2Qh6tRSz4tXH4iAFc1+27+UfwIEyOYXSjaQrPJcuj7ACZBdiY++NjnHISMB
	VWHUtHGtWqnUX4k6Bp2KDlxTpxlMaxFS6npE7MAhf+GtSPDA/4mw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cd9akymq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 18:36:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9Ha1UA038270;
	Mon, 9 Dec 2024 18:36:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cctdtxfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 18:36:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQuIfjg8bt3/Ue4owRkIw1/3kluvJ3V2HHB+Ub8fZpe1ebcC0wC3B6wzrp/dxQB21Q3eJ123Rfrqjq1qJZVCCIYyakU0U9k8dg3xt8Vuj6mNRRZjBbuC237HCSB5O87ukAMClo8UENnJaiSLDtWPGF4e2e/fx+S++V0T310cz8AMPwEHZbWfO6if5WN8LAoAvM+XM0hBVNqnxxxf4ugshuogZJsdzBlKUwq8+SYbD9XYw8HywDval7sr/bjKJJJTT5xpfKonogbTYtK5BaJZUn97lWzs9zbw7B5aQO5PPV4qxkUs6mhTqShIoc/Am1qwvvFg7fbQW1mwVd/yVnem9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkAorfkyWaH7Pdju/miy2Pn02zcZwCaS08nXLvUJQwU=;
 b=PkXpWJroerVRObW8SKkJ0J6a1wwx/CQzB6xPd5x9e7ruYJ15x/Vvxa11gF+7nQajqt6JKgnn1gGH61qwbGlxhEXl+5ydBxBCJq5uTDOZbpxaqbLZmwX2+C1zLWaAEtlSJSsjvush4LFGT4iYfntaYRr1DtA2R8AFUlmqCQ+fA91T1RgGLDelYiLezvqVcydSSLP+a8IRfmXCoGQWXTBovQLP4W8FbYhv4YlAtbC5VpRh1noAkEs51fUW1ck/jBTiXjFYEjoemSTuiljoCb+qC1fOz7wewbHNg6kAreclok/5m14eT+YvC4QicdsQfuXYe6QUdkJyamFVytiOJ4GNOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkAorfkyWaH7Pdju/miy2Pn02zcZwCaS08nXLvUJQwU=;
 b=emPLJy7JoHcu7bKcjgusxlGQyRLGzdBn9TGVF7PzafCiF0s9ighLKt3MTo2mj/YLQD/81FpruQD9E2g6E0QK8PS3CLHAHGMUYF9vODk2sNdymL6ANv7PaVeNHSTbgrh52GOzEs7bVD6YYkDn+k0kwwJip6e+kau0HcKTDbAgWhg=
Received: from MW5PR10MB5764.namprd10.prod.outlook.com (2603:10b6:303:190::15)
 by IA1PR10MB6122.namprd10.prod.outlook.com (2603:10b6:208:3aa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 18:36:31 +0000
Received: from MW5PR10MB5764.namprd10.prod.outlook.com
 ([fe80::8d9b:9200:a7f5:19a9]) by MW5PR10MB5764.namprd10.prod.outlook.com
 ([fe80::8d9b:9200:a7f5:19a9%7]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 18:36:30 +0000
Date: Mon, 9 Dec 2024 13:36:27 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: enforce __must_check on VMA merge and split
Message-ID: <fatemcbruasjxnt6ihlx6m5z3rglj4hac5zhz6ugu7ien7f7qd@wq34u2tyk4jo>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
References: <20241206225036.273103-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206225036.273103-1-lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0254.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::9) To MW5PR10MB5764.namprd10.prod.outlook.com
 (2603:10b6:303:190::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5764:EE_|IA1PR10MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: df139ba3-50ca-480f-ce18-08dd188065da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jnFqMfyFYoORoD4Nlp7xn/PenDxPbJWvMK8lqYuH/r5f7qskxWpyPOn7TmFk?=
 =?us-ascii?Q?b0kzrNCHORKs+qHbhU3dckKaD011AJG9KIWDSyhXX7f1Ztsb3A87NREIe3ij?=
 =?us-ascii?Q?OviDXXvDSuf1QfixALtwqy50+H4p8l41Ehn/NZQjiEYuCXNoDQ+ZO+uGPgk1?=
 =?us-ascii?Q?+scy9kRmmSjvUf+Y+2tP4qzBiqZb2O7JUhieC4MGdGmFJ+hL8Tov8ZowKl+0?=
 =?us-ascii?Q?tsfIAGgExSlwXdvGWOkN8IRBtLz8pkR8HKqYvjzPjUtigOptvgFXp49VVRWR?=
 =?us-ascii?Q?muHjxRjbJu4ripnuUHeKokfhfDB4ORFGK6yOmNIySINUeg+MbxDJHWSBsHBA?=
 =?us-ascii?Q?IorEnPCfrX3dwIProcQsrYSBzFARuR/l2HOaFqRv2SLTd7NNrplqh0ZRagzd?=
 =?us-ascii?Q?JpdV63vx+ChxnVRw/aRxOv+NOZOX/QAbRZE7CnPjY6ijZyera21HkIQZnOSY?=
 =?us-ascii?Q?X7IKNt2En/Fml99xD1yYbY+HwaSS4VptHznJTh/17U2Xt5bLPeSP//2xSo+Q?=
 =?us-ascii?Q?Nt8JH1LQf5KUmu7yOpjYK2WQ7CrCvWTwWMoCxQUg8Shf8ioTJvkVzL+TyK1C?=
 =?us-ascii?Q?tTbEaqFehcARVjmCJNZpVtAm6Q97G4NBbjUkEi76VVX2bK7Tk7XToBsFeUCG?=
 =?us-ascii?Q?T5162duvxH6UQGVDHB/vvmmmPaydwR+DItFesiCHo8uZTfvcuuWP0KHxegOW?=
 =?us-ascii?Q?22NF1qrnlUxwaKGUXIvH/e9V4OnkCQ08tT/EAe4Pgc2mF/rbPcSMJnDSoGmi?=
 =?us-ascii?Q?NWheuWEcNYHLQziZ9AZ8B1en1lhNXn6TuGi4lVRF1bCsMBqy14AgLXeB5WT5?=
 =?us-ascii?Q?OzBiwhRPXJMrgEp3vdvldvcHpMTqxk06Bq8Hfacb3sGQ7Pii4sG+90Ckvfj0?=
 =?us-ascii?Q?gh8NVIXbBbI39Ig3soLGvZfHYs0qyPqi4rQ3U5Jx6HcK9j8HZAwAR0nrRXOr?=
 =?us-ascii?Q?1RZU+o4t66mP1PJEu5Z1j+ThIYX7RkcdWq4wour4MzfFqgmfrYKPIo0a2mhP?=
 =?us-ascii?Q?UAqms9DbUdxhlGh7EypxcSMcAYndkV4Mjg+qZ4ufhyNOyNhKznaSm1m9oszR?=
 =?us-ascii?Q?h6u7f31rOksT51TBHiEhoKAtvbdYi+DizIEjGs6rn0wq3dKr2UWetg6tRdak?=
 =?us-ascii?Q?96bekssnythwpT6sGsrwjiAtOmfHmGm20DvA3Bxher8yES/rq3U3f9BXoOs6?=
 =?us-ascii?Q?Dgz0+dM3B96Wc5wxVBpExLF09R47UezuXpQBPD/LFOEk6jO9c+jwLbsSDMIJ?=
 =?us-ascii?Q?nCrJ9bXXMTc1K4ktFa3WR46SwwleaWpI+8ehyTq3TLNjhfGvxHeApkG9HEV/?=
 =?us-ascii?Q?zub5n2lbJEZUj3RPW7Ym9SmLhRKMctBx6HwJ4iGS98M10A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5764.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Av7YzUyOKNlAj/F9+w+Dpqocv/qO51XcAXZpIsE79FgmbFpZxt2uizilokTh?=
 =?us-ascii?Q?x/fZqVLG76xOa6YlI0713ddnJyYGwgwrrIpfgJY2knpUrbk83VVsEsW6nclQ?=
 =?us-ascii?Q?m1EIgUjj0n6gY/EXcuQvyO0cdylMduTgL6MXQaJ0hBgwAH85DZaSvHu37+ap?=
 =?us-ascii?Q?pb/drrmB858Ho1GIeFZjppA4C3yY2An15cd/M4S43xt0BcF3oR4CAvFw+JS9?=
 =?us-ascii?Q?/azrj0JW1OFp98JAhBrXk/Ju75ahgdnlfms8Wh5XWKdmgUR2jClNXGK6R9p5?=
 =?us-ascii?Q?Y4+xNvbTpFWa/TzVX3wPnuVsE9X8HKnUiC4caAKUwMcWmpJYXwThAsBnev2v?=
 =?us-ascii?Q?wV6neg6ySAyCHx2NlecEIn7T4mMI2tUpd0hiRPegg8AhhgQ4c79LGheM1qUp?=
 =?us-ascii?Q?bAAGWhzQnEwxncHUTz7y/CyZOPAyx4WKxW8ARr1DmwXrhi6eeVfAoxmHUrtE?=
 =?us-ascii?Q?Ag7i28GYHa/w/e8DT7XklMRefXVFqYKifq5Q1D6wH6kOMFqF4Ob9Pt0xctta?=
 =?us-ascii?Q?GmjL12bW5Lo4okYLOo46XtvDOUQFfcaPN4GmgY0ZUGQZsmEwZ1tqmuNIjXSn?=
 =?us-ascii?Q?k8ytXwmmnVYGVyZ4j34p/Sc3CI4K9/Pzsaa0II4a4XZIAZRZKMHXAaUlf1J7?=
 =?us-ascii?Q?X+bDetWPOc9QnAQTgsg6VTNb5q1EhCtsS0WF75tQZgUdQW2AvuNAE4k9Hk0U?=
 =?us-ascii?Q?WOWyX7ZEn0lGeaFn+6O1ehqKD1tcY5xKRzMyd8YQvF/4sny8b1ETGWXf2jSl?=
 =?us-ascii?Q?mSe+x3yECh0p1xdNeaBFtqGtjBmSxUB6PxkZpvfoqtVyCD6S6nLqHRJEZHTm?=
 =?us-ascii?Q?Kd9o8WEARN2TguTLD1u51CZsXk8O7HKsZrS21JiEkT94tFkNv4XekBrBNKjM?=
 =?us-ascii?Q?MUC/810yqx/x7xYFPHRa9j6Dtg8+BNmj57LktueXs8PlxmpNXYt/EaM6YTO9?=
 =?us-ascii?Q?SOYxiyTbTlhiJXQgRqZeRXEsPHvJCVLNKVTWf8sCJPjB28mehZjQajS+ZoXM?=
 =?us-ascii?Q?Wx6On2mA21vd7Abqm1r5vtdtSsswyT3dQLy/JKZIx1k0m0O9TainZCvnh+mK?=
 =?us-ascii?Q?B39sqTZMBTYS15/bJEKzI0nH+aIRZ1Fw4kPJCVAMJP6KrDq+k4O2JXim5B7j?=
 =?us-ascii?Q?8WvV6pK2Y+L8aPJCy3LAXvyLoR6ahKtUGeAl2+jgORLDqsj1pR0MTMp0Sn9Q?=
 =?us-ascii?Q?nXj3ioxXHwwJ5JzXvjgkV2093hwN+NCcxEftOcDg/85wkXJrQkhURQw6b+rH?=
 =?us-ascii?Q?cK5n4aYI4kyNEMIps8qsqQf9omptlxM7RUnWle7eH4gUAJ8tz+xpiiPp5jGD?=
 =?us-ascii?Q?kxu00KQJ5sgjdgqazgLNwZrQHSMjzashTbEHMCnXT2B2qYfifHKTWoJ87y9R?=
 =?us-ascii?Q?teno5u2BMpMQUUqNNS+3lNx+Q8rIRjBdgXiIAoyqkDNufVnO2OHSXNncQD9/?=
 =?us-ascii?Q?FW3t2hcKEGFpf6psRrLagz3GjFl7hRV+eX1F6pnjjJjXkbGfo96XC1lzS4AV?=
 =?us-ascii?Q?/o5WxYtBb4csFOvQqCCXZS33aqV/hM1RTQkZSgu/eolmF9iT9eu/Qz8Ljtx7?=
 =?us-ascii?Q?y5HyiSqCMIzgwpa1NumY43E4zjXSzjWZxrrardYb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7FzbySZtO8iqbBIN33jbCGni4JqajbPQUzSLVaOHRnkqCZFg2Sr9g2dyjXBAsHUXCUP8k97KhaKShH9igqtGAiKM+add+PQ5JAv/P1eUJNVj4SENV9maW+MymD5dsWEhDD59cFOIO3N0zbukuGDm7YEHNgihHbl4fdWLhrZ+eou48RXwAI4aRsZWIeXEZXjnBpHVpi8VR0RNot3nyfXX6j0heWTGTJ+OgAWjWxVxTOC9po5iITXMj4pCSmhF5rvkaEKgAJ77GEKgT5qsuhur1Ltjmn8JSmSBHQnkQ0nSyvpHWGxvoMNCFy7qCiZf5M7VURo7/9LOFXMU8+HX1vrQWIsMkvk63EHUYZQYbsfNb/w3Ho9WAQJWt4YjWAtsxcAD53lEZybxMd053A3o+1n4mIOeEbqcwI+Mo4mpnlI9uv3sLbL/SG0BDNwv+l3SXZ/Fvl49cy1q63Qvqw+TCk+OJLUVmbvAUosQc6Hlm46pQUVhO1kI9u/23r7boI9g3W94XaUihtVr4LGaHeS0jNYRlYsrXFdCyO1Ed3mgztIhOwLL/u3est8hI/AC9HDRYnv8R3Mn5zaDuzJlVvz5XAyRjYiUsqmn+c+KI+QSWhy+k8A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df139ba3-50ca-480f-ce18-08dd188065da
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5764.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:36:30.2135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: watGaOvenuYXTTPlo50lzg6CFRUdr3dAvlWJAXZJ06XwzuK/ENp1Vnp1oxd7YsuJrnS/2zZvGea4dpB0rrOyKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6122
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_14,2024-12-09_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412090144
X-Proofpoint-GUID: Y_NIRJuV-AbRD6FzJ19RSJf9ooHMShaK
X-Proofpoint-ORIG-GUID: Y_NIRJuV-AbRD6FzJ19RSJf9ooHMShaK

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241206 17:50]:
> It is of critical importance to check the return results on VMA merge (and
> split), failure to do so can result in use-after-free's. This bug has
> recurred, so have the compiler enforce this check to prevent any future
> repetition.

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/vma.c |  8 +++++---
>  mm/vma.h | 26 +++++++++++++++-----------
>  2 files changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/vma.c b/mm/vma.c
> index a06747845cac..543c102b4062 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -447,8 +447,9 @@ void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
>   * has already been checked or doesn't make sense to fail.
>   * VMA Iterator will point to the original VMA.
>   */
> -static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
> -		       unsigned long addr, int new_below)
> +static __must_check int
> +__split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
> +	    unsigned long addr, int new_below)
>  {
>  	struct vma_prepare vp;
>  	struct vm_area_struct *new;
> @@ -710,7 +711,8 @@ static bool can_merge_remove_vma(struct vm_area_struct *vma)
>   * - The caller must hold a WRITE lock on the mm_struct->mmap_lock.
>   * - vmi must be positioned within [@vmg->vma->vm_start, @vmg->vma->vm_end).
>   */
> -static struct vm_area_struct *vma_merge_existing_range(struct vma_merge_struct *vmg)
> +static __must_check struct vm_area_struct *vma_merge_existing_range(
> +		struct vma_merge_struct *vmg)
>  {
>  	struct vm_area_struct *vma = vmg->vma;
>  	struct vm_area_struct *prev = vmg->prev;
> diff --git a/mm/vma.h b/mm/vma.h
> index 295d44ea54db..61ed044b6145 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -139,9 +139,10 @@ void validate_mm(struct mm_struct *mm);
>  #define validate_mm(mm) do { } while (0)
>  #endif
>  
> -int vma_expand(struct vma_merge_struct *vmg);
> -int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
> -	       unsigned long start, unsigned long end, pgoff_t pgoff);
> +__must_check int vma_expand(struct vma_merge_struct *vmg);
> +__must_check int vma_shrink(struct vma_iterator *vmi,
> +		struct vm_area_struct *vma,
> +		unsigned long start, unsigned long end, pgoff_t pgoff);
>  
>  static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
>  			struct vm_area_struct *vma, gfp_t gfp)
> @@ -174,13 +175,14 @@ void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
>  		struct vm_area_struct *prev, struct vm_area_struct *next);
>  
>  /* We are about to modify the VMA's flags. */
> -struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
> +__must_check struct vm_area_struct
> +*vma_modify_flags(struct vma_iterator *vmi,
>  		struct vm_area_struct *prev, struct vm_area_struct *vma,
>  		unsigned long start, unsigned long end,
>  		unsigned long new_flags);
>  
>  /* We are about to modify the VMA's flags and/or anon_name. */
> -struct vm_area_struct
> +__must_check struct vm_area_struct
>  *vma_modify_flags_name(struct vma_iterator *vmi,
>  		       struct vm_area_struct *prev,
>  		       struct vm_area_struct *vma,
> @@ -190,7 +192,7 @@ struct vm_area_struct
>  		       struct anon_vma_name *new_name);
>  
>  /* We are about to modify the VMA's memory policy. */
> -struct vm_area_struct
> +__must_check struct vm_area_struct
>  *vma_modify_policy(struct vma_iterator *vmi,
>  		   struct vm_area_struct *prev,
>  		   struct vm_area_struct *vma,
> @@ -198,7 +200,7 @@ struct vm_area_struct
>  		   struct mempolicy *new_pol);
>  
>  /* We are about to modify the VMA's flags and/or uffd context. */
> -struct vm_area_struct
> +__must_check struct vm_area_struct
>  *vma_modify_flags_uffd(struct vma_iterator *vmi,
>  		       struct vm_area_struct *prev,
>  		       struct vm_area_struct *vma,
> @@ -206,11 +208,13 @@ struct vm_area_struct
>  		       unsigned long new_flags,
>  		       struct vm_userfaultfd_ctx new_ctx);
>  
> -struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg);
> +__must_check struct vm_area_struct
> +*vma_merge_new_range(struct vma_merge_struct *vmg);
>  
> -struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
> -					struct vm_area_struct *vma,
> -					unsigned long delta);
> +__must_check struct vm_area_struct
> +*vma_merge_extend(struct vma_iterator *vmi,
> +		  struct vm_area_struct *vma,
> +		  unsigned long delta);
>  
>  void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb);
>  
> -- 
> 2.47.1
> 

