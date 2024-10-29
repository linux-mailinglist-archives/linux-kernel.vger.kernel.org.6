Return-Path: <linux-kernel+bounces-386991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A309B4A8C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 425CA28408D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EB1205AAA;
	Tue, 29 Oct 2024 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UmWqK2um";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sg85BcAX"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A1AC2ED
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730207060; cv=fail; b=nxJGfZZE860G6s3TsemHZfzXZlj8oBNtzGLEISGWI2BQCHh/I6hgqwvL73Fp2rv6xsFwXUFY7HBFOAl0ySQT/iKZEvmL7MQEcHcYo4VaMRHzsx00dHclZJJ49LPvDY0RBmnsQFWhq5gtv4tt4FXtVI0wcDsUHU/fxn9e+u/bazI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730207060; c=relaxed/simple;
	bh=jxx6fD6nf/Y3KFSrMb25LGU/qkWlr4ViyDhGPlbV3RY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rSJiWnWWC/f+HTOFN0b2628+RUuxN32Q1YMjxliWnVtk5KrKcJNaYDO8SYxZPnAe5nZTMZjuvumEQ46lZvgSjy7m/yYP2Ygpzs3OAuHXZZLijRUjhiy7WR92gXgix+GZbmu1Sf2/J8PF3ACPU8xqSpCt6toERnfNssHqXc25MJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UmWqK2um; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sg85BcAX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TCboFv032723;
	Tue, 29 Oct 2024 13:03:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=0Ipb4+8ULYbRwn+d
	/CmttK3pZ3bYglvQTn6LdykCoiw=; b=UmWqK2umkL52xKSglJs4/KpS2Tnn89kv
	8BfU/xSP6USx3bvBHlrUTWSbkD4QBW6Q1ZugvWGEVGEHWteTMRSyYISbaYH5knvl
	/TQePmdKGyfDDT6fiXyDcgejmhgca+Q2se7BT7X9p5mfJkPaRQpjgG8CPi/OXOHl
	Bwd+otwtuL2MmDWIIFstfc/+5XpnIKB6TDEFCeYiP3H2DJpB/DxGeFMfzgsEOQiq
	luYMlwH3y1uWg65MybxPn8FgIU5zrwUR4Ya8B728pYGmd99Y/MHxeXMiusim8W/5
	uhW1ZHz3jKp4m+XhBnYPaeyfIOXEm2Vj52WmInz87EHLOvOwnhf46g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdp5bv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 13:03:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TBH1LI011747;
	Tue, 29 Oct 2024 13:03:54 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnacfn32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 13:03:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYa+bG15sA+xRhFwjyvT9Dl/VR772FPwFp5ifGOEeNlOyUXeu47hDuYanCN1cV6yUiU9hwNdYtyCXfV6uD/9AL/wi353A+FJDCVDIc4IpVkXgmriJIJyr8ORcSElycW65OvQ4cbRPE4nbElt7/9zmnxebu1XRGrvtXyy63zCbW3a+MQLfXq4ofa2EL8wRWhzSDsfOBY9RXNDyVRGg/QSEF22A1uPU+PjR3eWHzamVfwKeuFRpoPWtzsVjHJVUgsLA/VNuTFz8Z1h9wUxEGrvg/ETAIaiplgrttyzcTuNmdU9HtcnRKyAqpGjHfDI+K07+1+eeRBBDE5BNEltPbW0gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ipb4+8ULYbRwn+d/CmttK3pZ3bYglvQTn6LdykCoiw=;
 b=wjED4FdjlC/rjPjld1LUnVw6PlnlEyprNnlTBg8wRHAJW05wdRr1hMkcWo1PyIXUNHIb6cD7q+sdvgvbYm5k96/hXHQl5DpGITFajbxJZSzb2azvBFrC4kRj2t+BwkP5okqm/bG72U14YiyXEk2ok2LLc7ln2yWhvWjhCxA6nSuSBvfz27bzVaRkn7G73spbO7kJW9sEqGvYksQ6eHiM265O2toAdxmnXjAd+MxPO8GC/JnjS3JMfqSsrx8btZGtL7GYpxIjFwLPV1iWoStue/Jg4vrcZD4voMusfFLpqdmMOru64bmNJLsOhD60R13ocVFd03O1vHZbMKhg/I1CMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ipb4+8ULYbRwn+d/CmttK3pZ3bYglvQTn6LdykCoiw=;
 b=sg85BcAX1n0yn/Q+vri5B/m9HpLcA71E0JQZumwoNMrSNFDN5TLfKtGBDctLd/9q0gI3csn2qtVxQwOQh5K4knqdw5RjKFDIGU+MbT3lGExPyEr1UBxARK7CRff5OAuJF9edVqD23ak97l6IWpgyNeOCPpdg50tuEJR/SnZuq/M=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MW4PR10MB6462.namprd10.prod.outlook.com (2603:10b6:303:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Tue, 29 Oct
 2024 13:03:51 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 13:03:51 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>
Subject: [PATCH hotfix 6.12 v3 0/5] fix error handling in mmap_region() and refactor (hotfixes)
Date: Tue, 29 Oct 2024 13:03:42 +0000
Message-ID: <cover.1730206735.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0678.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::18) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MW4PR10MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: fe93dc0d-20a0-4d65-4213-08dcf81a227e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PRMc0Js+A/tBer2u2CEbimE+h1YUs7ld6+X9gJUefWz+fJvmRVEUmS0iHo8X?=
 =?us-ascii?Q?mdW0GfDtSpsv/PUGydWGQUPMWovImhcHjMj6Vi/lbXaJL6Nkkk73YfRT02jJ?=
 =?us-ascii?Q?vlj3I93NZa7J7iW7pNo0rhXCqzQjQ/yQbOpSBQlENGdwP/hRgkDnuUei08y3?=
 =?us-ascii?Q?UQ+Zt2nikS2UmB6Gpa4F3Jvf1bvf6LnIYjqSzbpSP4jS9rYSCnJ+HudMpXzf?=
 =?us-ascii?Q?v5Ve7Ni+4bkP8M6N596fgDE6O2pAe4oFXOr0nFVYxHNQD8dctQ3epBPh4oJR?=
 =?us-ascii?Q?98yyZwHWD62zoKeqhyjzjOCwuL2+ml0oQD9jGPAH5QDWWtd14xmg/agjrUJd?=
 =?us-ascii?Q?xC1MeiwTxAfSV/+wYzfgr0snfWXIIuW0se7cTdhpRYdC48GyGHU5h6sjIGBa?=
 =?us-ascii?Q?36yYpbuNr/Ln/x95bsB038QpPum1yr0wINs8wLTCbK6eBc47tF9Y5LdIslWT?=
 =?us-ascii?Q?2SLW8tr2cy9EQU0Whpek7qkb/QO13FbrInhNvCQfXoJjxtdB5FFTgy3secvM?=
 =?us-ascii?Q?gWOYX29n1v2YJAp5uUQKshXpUY7wcyUAOS/8JKgU5/RSTEB1m3SfQrRGFRSy?=
 =?us-ascii?Q?6qm2DZEeG58G8VzFpuTU75Sp5IHkiGfa+l//FRC7MIBIK+JYi3h6NPq+sVvo?=
 =?us-ascii?Q?k1Xix5C7jJVmAdX80MAJMd9EfUKf9gRXtTb0hLMoA4UQ+ll3F1z4iA1av52G?=
 =?us-ascii?Q?v6azRyW+/xFwIW8Xl0CG3oc0R2wMyIEk3pAbQcEcgzJbApp9UP+F974uzDPj?=
 =?us-ascii?Q?O6LHDb2wR4a2slrGv59eQRyMI4nWNVsp0jcgZOYcmtf3fR7LdSJWOq3TUJIy?=
 =?us-ascii?Q?8nOEYNY6A+Ptb/L4/wR4SwSuZSq0wMc9Hogvx6nTI6y2lqGZaBySvhRqdXtU?=
 =?us-ascii?Q?8JsDski6PTqWz64vwgycQsRF88dAwzoHvLSW4SjRodpj0lhCvwDPJBdtXChL?=
 =?us-ascii?Q?CaTT5VsCR3GpIa7t8SNUgY0aQ63TfP4vXLE+bhHAJ0hKnLjQr54QQtiaZTxC?=
 =?us-ascii?Q?mzc1bjRegf/TDB3XAEQWHydN6Er+tMbS6V73WLIhjCxBGnxrNxnBKrSyAaAN?=
 =?us-ascii?Q?JUd7hpBtIAz9H57sT33yRYytY7/tRBLJmdFEeIYk1LT0t3EdWbmBjRa4xF94?=
 =?us-ascii?Q?8FtNrJDdktTh5/h/huD76SoCCTsSlBLEocFSQR3KJyi87p2FKVnkuK+II0Fg?=
 =?us-ascii?Q?QOg4f1PmCpvNdvmVs5v68F4GU0fLYyKI6H0+8cHIhys4V3EQiVKpFH0W2ijN?=
 =?us-ascii?Q?ZZys2MXw3Uzaj8X+j+96TgRX1Dgp3FvKQONEoZS2c+EGyIv+yXxVTruQcrEW?=
 =?us-ascii?Q?GwRxuTgjT+OF1bB8L36c9rJs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?02/+dwhqXwbv9vVNVB0tjfJgzrnzB53jYR1ZNUkCOL/12wlky936BDoJhLaI?=
 =?us-ascii?Q?OVn0+ycIQAGejTwMEIyMPRIWWG2BY1+anBJPHlM+CW5/lXWRlRo6C48XZnjS?=
 =?us-ascii?Q?vs/s41ALWrDP/XZCaRpCm61ESDcpgcrymiX4jTv+HwGpQdYA8GJy2qAvrVpY?=
 =?us-ascii?Q?L6EkOAFbTNETgc3YHrRmAD+RcXcPUVdz4IFYC3nPC5ZCdKR8q5FWal7O7hQV?=
 =?us-ascii?Q?C7Sz69+xFr9PPuOUz9cFmrkR/O1KvmjASLwFMq8flaSOrLUCc/kgbP0bsl3i?=
 =?us-ascii?Q?1wFoyBloARtZtsXP2TwiQvoXjDEUMWlpKCabwheBJeNLgFc2gII0oeuEagV/?=
 =?us-ascii?Q?CtiCO+kn/jSu2DrVRvfUgVBsK43Ymp+BjH8KY/akHhZ13xPpC8JDJ2Z5Tz4f?=
 =?us-ascii?Q?24CHXfhR7SRmcGqi3OckxtjSrCvV4L+w3HazTKWM3TDcUNTucV11s6kbk6QN?=
 =?us-ascii?Q?OvEGYXDGy6OdjEMELok2UJ+vKv7Zzx1sn97E0tpc+ESeHAm0yDv1kwEghFeS?=
 =?us-ascii?Q?PaqL0etnj/+OebD0pWQF/5NPLaLU7OhHfl8us1wQl1B0ce8hZJ9k9zyybQsC?=
 =?us-ascii?Q?Pp63STZ8TtVYWML2AUz1DRJ972r9p/SgZivkb76VZigGsPFCho9mFEvh4cDC?=
 =?us-ascii?Q?R1SRhiz5QW+APEUoQHmJsLBVWFhN7R4afEJ/HObrz7cJc4iTi/V7LhLti6AX?=
 =?us-ascii?Q?2uXz4A4rMca59zhZWkAzN0+RPgnNc4aynXlTeYhZaBJnz/hxIW/Q0J1TbW5R?=
 =?us-ascii?Q?GJyEqYeexvESQ1owE5PPuAAB7+3R5ylQqGK/sVIVV1dZJ1/wdc/5hzzl8EpJ?=
 =?us-ascii?Q?FJkEeKybfEEV4m4FqQnvveOuDLYVz/xLQFkJPJdFeB5kJ4t1wa31tebQQwe5?=
 =?us-ascii?Q?5bPtLFBhSdc1BD8PV/6ldtUCLxBQu/hm7rIQNMwh7Hymzm1RU78Rhwcic4sC?=
 =?us-ascii?Q?nsz8bVH/gkD0DHDPOHFr81Y5pQsoI+H7NPnKhWTdAwiq8+Zjx/jKGdOFofd/?=
 =?us-ascii?Q?f0AzwAwTBZC+Z2OM4WnrVzyX4sBBWeixN7fSeYCjOKajRkCJbedycnt0d+MT?=
 =?us-ascii?Q?Ou3uSMqIYO7MyNJUPz1J21t9EJubCLMF0yiEj7akAUuvaGKKsUg7ymBp88Uu?=
 =?us-ascii?Q?FwV3AR0g5jKYRbfXOUsWeg+ky+iM9sNeVen+sQL7MoqH+cO4gYLxHetYA1FI?=
 =?us-ascii?Q?g5eXAZVRXpUqrZ0rP2MiOexHhQc22zupVx1HilZsINl9Myo1IsEt+n3+vG/y?=
 =?us-ascii?Q?d5H8mkcOeGpZyW65fc0gk9dqIOtJNvmFXgaPCSLKKNA3i2201vVryYF8OBra?=
 =?us-ascii?Q?jSF994LUJ9VAoX0IGRTSEv3gzT+Cg41K5WyZGZXsGefF8bVL5tLDJXprGdaG?=
 =?us-ascii?Q?/rAoymhexmAOwqsBJntybYf5/jjn4JSAQ/KiT/pb9lrnWz35gmYDPVKFmpDv?=
 =?us-ascii?Q?+FhZEHaou+RZ798Cffxgf+W//Yo0mk3ZM4JCI9YTPzaR9xvvZuhH14aSvde9?=
 =?us-ascii?Q?bVdWIkr5L7GIfGSz20u98IYbKGTFKPdStJhXPtSdTp4vTyAqe0kvQggVfzb4?=
 =?us-ascii?Q?LNfSj+by7FdIaZhXm2ipIRJSJYr46RJMFme3O1DaqBTVTXOn51YIvvUb3hJC?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qZw0F1DSb+fXCHB1HpD7h7IHWsS6Trz1SOC94BWo6GwyBeZPXflbasVyiqj1/kN84Knr9CCy03xaxL+bf9hCgwI5hS6qecCKPGXsXmj/oDRq9Xhh470CsdYTmT6wrVfF5ax1Zjr3rBzbjQYTeBNste3yUf08u8arEWzaMyFx1kVPpzCeqg5idgh1hEfcUtdj/zDcHBXo/hQcA5C91XjzbiDriWwfUAXkiHXTR7SAzncxlg3LvaHl8tda8pE3ip1CqO4jn2/WcK5XOfXt9SvfddIdM2LTsEPD+nsFxXmQMs/Nv1ui+s/6Lnvzww+c8jc+fJGyg8zwDrbMn3mW0+BlXCsBVeMYWIKllnOOHx9c43AVdkYvd2i9f8Qjkf27zT7y8YyUZCrMzIij3DN0pBY+HUaDnZ2+sS7xJv0iyTOmV3DT/K+slGtt9ltBKy26+n2jBZguidRHsnrOWb5WPnPcwNdNZS1RMG1ctNZx89xT9RnmCxRPsiGYHvIGoNMlh+Tl1GAY2Eem0objBLnRN5Ih6qkoYRyQp4TO2kO7kJi66VY9IQUMEKyFEHqglXfaRj/Okce3dffnKDt2DA2lvn0/7oyJIokVM8+SheZhe7vjbrg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe93dc0d-20a0-4d65-4213-08dcf81a227e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 13:03:51.4414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mgv8yeX6SuHfomhFaPrZI+eGdZQ4+tngrNnPNcP8mSULY/FcGMhQVXFJz17MsjxUQqxnadNYBz9ZNbDWfsMN+mm53llA4g+t9f45UT63Qb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_08,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290099
X-Proofpoint-ORIG-GUID: V4mZwTvoalCET8egFWyM8oYK-VpCd5gp
X-Proofpoint-GUID: V4mZwTvoalCET8egFWyM8oYK-VpCd5gp

NOTE: This should be applied on mm-hotfixes-unstable in Andrew's mm tree as
      it relies on other pending hotfixes.

The mmap_region() function is somewhat terrifying, with spaghetti-like
control flow and numerous means by which issues can arise and incomplete
state, memory leaks and other unpleasantness can occur.

A large amount of the complexity arises from trying to handle errors late
in the process of mapping a VMA, which forms the basis of recently observed
issues with resource leaks and observable inconsistent state.

This series goes to great lengths to simplify how mmap_region() works and
to avoid unwinding errors late on in the process of setting up the VMA for
the new mapping, and equally avoids such operations occurring while the VMA
is in an inconsistent state.

The patches in this series comprise the minimal changes required to resolve
existing issues in mmap_region() error handling, in order that they can be
hotfixed and backported. There is additionally a follow up series which
goes further, separated out from the v1 series and sent and updated
separately.

v3:
* Added correct handling for arm64 MTE which was otherwise broken, as
  reported by Mark Brown.

v2:
* Marked first 4 patches as hotfixes, the rest as not.
* Improved comment in vma_close() as per Vlastimil.
* Updated hole byte count as per Jann.
* Updated comment in map_deny_write_exec() as per Jann.
* Dropped unnecessary vma_iter_free() as per Vlastimil, Liam.
* Corrected vms_abort_munmap_vmas() mistaken assumption about nr_pages as
  per Vlastimil.
* Changed order of initial checks in mmap_region() to avoid user-visible
  side effects as per Vlastimil, Liam.
* Corrected silly incorrect use of vma field.
* Various style corrects as per Liam.
* Fix horrid mistake with merge VMA, reworked the logic to avoid that
  nonsense altogether.
* Add fields to map state rather than using vmg fields to avoid
  confusion/risk of vmg state changing breaking things.
* Replaced last commit removing merge retry with one that retries the
  merge, only sanely.
https://lore.kernel.org/all/cover.1729715266.git.lorenzo.stoakes@oracle.com/

v1:
https://lore.kernel.org/all/cover.1729628198.git.lorenzo.stoakes@oracle.com/


Lorenzo Stoakes (5):
  mm: avoid unsafe VMA hook invocation when error arises on mmap hook
  mm: unconditionally close VMAs on error
  mm: refactor map_deny_write_exec()
  mm: refactor arch_validate_flags() and arm64 MTE handling
  mm: resolve faulty mmap_region() error path behaviour

 arch/arm64/include/asm/mman.h |  29 ++++++--
 arch/sparc/include/asm/mman.h |   5 +-
 include/linux/mman.h          |  23 ++++--
 mm/internal.h                 |  45 ++++++++++++
 mm/mmap.c                     | 128 ++++++++++++++++++----------------
 mm/mprotect.c                 |   4 +-
 mm/nommu.c                    |   7 +-
 mm/shmem.c                    |   3 -
 mm/vma.c                      |  14 ++--
 mm/vma.h                      |   6 +-
 10 files changed, 173 insertions(+), 91 deletions(-)

--
2.47.0

