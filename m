Return-Path: <linux-kernel+bounces-357546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C561997265
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABE42B23066
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49931A255A;
	Wed,  9 Oct 2024 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EdbW2LKm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I/96lvPa"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6211319D098
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728492885; cv=fail; b=gFHJ9uZBaUgzuVctVUCpk3jgqbNtvX7FGbBTEu8wUoXMFmsVJgnjXZnhitx4y77e00bcsQz6s095kiOqVgH6QfPT29l8EtKJk4z4SFZJjj+XoKCP64zpCoyDGWIKBFVk/EUDdv4rzs1jKVYhM3vKMY/yA3Qu5AWbJEqAfGYE9XM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728492885; c=relaxed/simple;
	bh=XUqeMPJzU3Bc4Tp39E3UdBAwc89xMY4QH3GJjjfejKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PKalL7Y3z3TkV33kVuTi/18sut3sZtYt8wiB6HJkad8EbBKwqAA7b8o7y1+8yRVWD8JDtiDLO0fpsI5hQ11qVxeDA1FnDTxFFk83v8kniViscuGsqs4QVRnOma2q3EkEk3sFdKDryX6uB3KnduiAeGycEQI2LAWR3Jp3LD5RC2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EdbW2LKm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I/96lvPa; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499GBe1e008208;
	Wed, 9 Oct 2024 16:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=PrGwhtw4KC/kNfwJa+ZoZwbOxPrK2qSFm0qrV9B+ufk=; b=
	EdbW2LKmVvammODyiMQorbCvmN9fXRVDzpoRgPX3tqshkGq06jIsIcsQEc/3owqu
	W1GR58iRPxBg5JFuule+NGC+8He38BFrTLRzKpAGyQcG6u5u9/+mwvk0HRl56SX8
	d67Il31Ij7TuFmXKWQu0+IWlEYpebnsRDATslX+bFtqYvC52aMlyK45hPVGfNnv9
	AGIbSTN9Sv+pcEpCLrmG8lAMfQhMmm0tJNfKZlc+aHb7yu0zm67/1KtY4JnU2931
	Ha9/1cMcPc+U685sjSZREGAUxT65DnZ8UPFqjnU5wYLVOM+rmoAFLbLEQ0oLHzJA
	Bx6S1j3P6fD/O5G2q8H8zw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42308drt2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 16:54:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 499GqMuH022903;
	Wed, 9 Oct 2024 16:54:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw8vdt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 16:54:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qg0WMWPON66KWOCdGVkM1FMy9mFqvzK1kWo3tDKMedMSZRkjC7mDmB9+gE6efopAABY2qnFZHdGigPGhywrvbRk2J0irNhvT/yMdfsVoerItNhg+awD/0oDaY9dTQOJSeVvMJYJ0jqi6R0jEFmuF1JtB69d7J18ACIk34Ahkjg+BnzWJSGo6vhh99MK+o5x5UQs2nkjkf0kFvQuVaRQhjM7NLTVny12dQooQYuxX886E4KWvSloDUraI+vk+yWsr0uzXX8PrGnOmzhInsBdil3RDrUhSgCNpmOoDVXOQO64vydXoCYDLm7gIBcRg5MQJow2QubfqhVVNkIFqFLetYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrGwhtw4KC/kNfwJa+ZoZwbOxPrK2qSFm0qrV9B+ufk=;
 b=qsJFyYoETeHQeHAV/KmBuczBwatv/xOrzwdPsgK+KdMIFsY3mOGqquqGxFA3VBOg14m68lEz6syt0f0RG/FqZ7DY0xR4gcc5VHjL7prfLvk3ORDYPmBC+myJc+Smx8NsYmBVoVAiPf1DMwPGGBF2Pj/CrElUWWZc4lKQKntK7TgGMakRwt5yJSE3lUKxaWqsq/t8xB+SSkxpxwAR9ETxsPZ4BeXt0jShxO7QZIY/yfv9yNleIWbnfmQ6WA+4UZtVNQLMy7uD1al8nliQ12R041wbFb1pfrsYgwlD/1AmNiegXh5rtdLDajLS1+yZKRVCnK3IvSHM5iVAYrTd0P+Thg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrGwhtw4KC/kNfwJa+ZoZwbOxPrK2qSFm0qrV9B+ufk=;
 b=I/96lvPa7fWGBEcE+Zu5OjMDRw71gHwctio5OX+yvGcvLKn8Ys6Yq8WJYva2S7rRlJNC7d+p/rtgTLB/7aPnXj62HQiwapX/j89ZbSw6PqQmjM482u7BBeDzvGo7dQvbOBEMobnsIf0pf9Kp9sjagHZUPRTnkJInMQrzzmflN78=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB6585.namprd10.prod.outlook.com (2603:10b6:930:5a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 16:54:16 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 16:54:15 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, ankur.a.arora@oracle.com,
        efault@gmx.de
Subject: [PATCH 1/7] sched: warn for high latency with TIF_NEED_RESCHED_LAZY
Date: Wed,  9 Oct 2024 09:54:05 -0700
Message-Id: <20241009165411.3426937-2-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0128.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::13) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB6585:EE_
X-MS-Office365-Filtering-Correlation-Id: f52e8e15-dd13-45ba-da02-08dce8830255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zCZPPYHJysVyjiFwTBoUkNYPxFT7uuQVmbwcLedqCw3InSf63Nt3KQg/Wwgj?=
 =?us-ascii?Q?d8uxONkgKe8ShfMPvmxFH02FZPBrVf0DLD+kPhKl2szF+zBcZUApTfVp1cYr?=
 =?us-ascii?Q?jB/zHyVws5OhjKxhc5YnDZzi6adEOUQJ8XxTfuv98aLiv9Tk+tYtHok9lDqb?=
 =?us-ascii?Q?Lp9j6QdFN353Pmacu5Zqfqb5AXSq2+28dnjr3LxIJJoQP8U6XAH5+AwxsjKD?=
 =?us-ascii?Q?dogv4vgRTrG1mMCNEJVzKohwsmN2AwEnDMvHFm4a0FKMe8WvZ3555T7N/GFt?=
 =?us-ascii?Q?pURUSbDOCOH0QzIQfWC8xSqXOtauuzJS3ZqMx433jktdLt1Wary0Il9qQXdV?=
 =?us-ascii?Q?t5HP1STSbkzabmRArLk4LOQOLDpIJazUoxxthE9OgtSdrMhob5F9XiBuN/Jb?=
 =?us-ascii?Q?xRzzQNwVPeNyHuOKUvLWTRHwf4Nd8VACU/RU7XZjPnef6AKHn9Yf513NwvTo?=
 =?us-ascii?Q?tnx8FR81jgKwhybl10slz83+tbIaVTsh2ISKdJdAPFSVSzaT6Mlk9eUNikjv?=
 =?us-ascii?Q?09Cvsl6CaXXKyX+4L6ubu+5yIpxGS7pHbDpsX7jy93MHCPijUJPKU25Zbrwg?=
 =?us-ascii?Q?+Le9vk4RBdfhS7g7lTIDxog1OVFgyxiMs7qASoEN6xsWwpVvoqCecK69RcOI?=
 =?us-ascii?Q?NYsZ0Z8jR3yEOLiDqWFQu9gHUevtuAaic6zW/JmUpG9imtvPniRFYpviSzhO?=
 =?us-ascii?Q?nrZrO0938sof0S7kd61+Gu4w9N7EF9N8hXIHX9BVm2OS4ZN/Sd4D1D6BgamJ?=
 =?us-ascii?Q?FQjFUmD75t3NNTwf3Uq3S6sdFmZseqq/bH8YeRhP4UsY9qglFYMGG2myvR1g?=
 =?us-ascii?Q?oXH090oED8zBcj4GHWsZfA5GYzqyE5N1iBUftS1dHD51TuSkITzkD293fBP1?=
 =?us-ascii?Q?z2NaHedgToEfQnaDh7Uh0YhQLrRyOfa09jol6WB7Sux7saEX0rg1oF1BJhxf?=
 =?us-ascii?Q?vV1abDkOlWIfVsUG36r6J1l33CM5EErqv3+D/jUGAVNMKB7T6bEOIMC2csUb?=
 =?us-ascii?Q?RzDQPu6OM3LZ7+MYV/I9aGofpDOSLPL6Z05kqiQxwcdTruIaefZhj/Au6Tii?=
 =?us-ascii?Q?NNIodupEtzOF8uJE+6kOifwtJVuTvlmMys9GoQ0MCJgp2iejfJVxGH7wBtWk?=
 =?us-ascii?Q?pRrt+i4FPXpyURkCP5lDFxGOLQ7R7YJjvG0q5w5s88WQZLY8knLwBCd9JCnt?=
 =?us-ascii?Q?0LeNtoKbBDLhzfDkXk2m8AyQpFW92kqLeJVwNYNEVwwviIF3s2B3a0YHd11b?=
 =?us-ascii?Q?nLLuDebZWRC5zJ5mkZ4Aa8RhSAeatXmor+G0qhWkcA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JV3GxdKb7LosUJ5kPqLlHD4sFa61kP6fYFzB20tYZGhkxC4cJGKLExJ7pffn?=
 =?us-ascii?Q?JZuAiudXhCx/2Zhxb2TFDtDEajueTq1JI1KPhR+27B3fsDUG3y4MF9v5my+j?=
 =?us-ascii?Q?eVbuGk3JdBFjmIAiEpt6fB8BuBPB/vQKxkplnCCLHzf9AbkTA1MmkXVnAfZm?=
 =?us-ascii?Q?diRWHJUas+vZKnUDiRYn2Jrm69mY0AvYxx3YD4fIBVSxq/gyNZaDNS33exCp?=
 =?us-ascii?Q?ajTMuqAg0ZynFGfP7LqR62Zkp9o7MzvEw6IkQl/cDGUY/5fca9Vct+wS6tiU?=
 =?us-ascii?Q?9pAM984gMPauFI5KE42fuK6W88P9fda+XzaCOJGckC2Co/WzYUjfbEXpz56j?=
 =?us-ascii?Q?UG2YY9YyvS+6Dv3+r+4jj//1FEvrQER7mQVu6tfdCtk2gyiDognc2E5LnV6n?=
 =?us-ascii?Q?cctmxkp9dHzBy+Na1ymTF0UeF3JriYaTPvAyWKkDqVAMUZtg+nv4IC/F36DF?=
 =?us-ascii?Q?L84un2ns72sD8nLjRI4osKFcJaUsdOS9/szzrIKqg1m/31JuMvIGQJ9VW7VK?=
 =?us-ascii?Q?DTxbpOqmo2OTCnpK+W3LrdTTGwn3cmOjgsbAvPGDN2fFAP/xgi2KrH/hvUoj?=
 =?us-ascii?Q?hkjyTLF/ZO6X6Dw8r5ECv1Nair8XvxMhQEuAvutYnN3GJoe3ucAsLoBrr96p?=
 =?us-ascii?Q?Rm88QZrPEuT/9XxG0QQB164I0/i/uUUJDR/7Yx6T+ObnhqW7D1HxoYbPQmLC?=
 =?us-ascii?Q?06HVkjIvmOy35LOpjCqjUX48cQKm3oKgxncIX6sJORk5PKAdQy3FcUsFeEJY?=
 =?us-ascii?Q?Vtd1/uPEeHtQXcBd7YAFImIdQ0WXDQb5h/f0Ns6vJqY7ZEDF1H4puioe8Q17?=
 =?us-ascii?Q?Y7P2iandRvC9GuIfhhBY/Uc+nr+i932KBgQswM4nf3Wb8e8BmWuFCHMzne3r?=
 =?us-ascii?Q?03KVjYo/0Ti+ap5LPC87FhoCefqryrtgHPTjxuOcDbxSr/TxrpgYHNIVqvc5?=
 =?us-ascii?Q?nO0rDbza6bPLv/VYCXAr1MUlqTdkx+ObkcWqlMCBO9INJuoddDTsAqk6Lvbr?=
 =?us-ascii?Q?opODpVcBqNsanjjfVtmuAeQuyRXLYuppGif+TjZyNWof/P1kXxIjRwkpE2M1?=
 =?us-ascii?Q?TTDQoirPdDahmUdgJ9eAWElljQaxvb0e3KPJjeSS1eB20xiAkdmdEjsP1y4r?=
 =?us-ascii?Q?IIQ11Lu9vuvNDPHtBHeKw9XVlJ7mYB66UowqACdNtysYf7DC9H4TAawTzyef?=
 =?us-ascii?Q?TIQx1C5bEoXqolIonb6MnqfH88wCIm+jN/J3KnSYBGUCCdcWNpRKIaBLXJTR?=
 =?us-ascii?Q?Jv66/EyZzlrGmOmoJ+K+qnt/yuafPR3yDP9a7x160zGPHWVuhN7jHqunngaS?=
 =?us-ascii?Q?6SRV2geg3GpoKbxmaMR+WpccTWq78oZnB25AYz99xi94tpnoaRSlm178RnFi?=
 =?us-ascii?Q?CrGG1nUcmVfiQEFqOoPxHf3Zbr+G1xVCAgOobXUpjyYq8CJXScn20oVrqE+s?=
 =?us-ascii?Q?KrsD79JSrxxHSBhOYYnIBYmf25Rogwhoop5n3FKfw6shjsIEsa2De9SHqkXW?=
 =?us-ascii?Q?pCL0Rgo5ZVZipZA7E4HzsQHNB6CHSLcYZMnYk5Fl+AzcEGZbe1L1522AW7oO?=
 =?us-ascii?Q?iyay9CkXQx1N+fx3gqUyN/E9a9xcp5XOEPPD1TSKh3rIzfdJPmhIzb6+8zmq?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Epw0cqrEWo3rGbLYytO5tSSnrCsZnPHJjHLe8Mirn8Fv6uenvAb8Vf+PmeYnxocU9oD8LNLaAbvW1G48bUVehZ3GuWv/g1YZjzLyNV/miG9ZpZZwDpCx7TxaC8USfRvBg5/upeimE6VdP/85GKkxugiZ+LNFYRGzkUp3ALymq6uqrEs0DRibbIIhWnZCBQIpfncSA2hj2Uz9ehTnd2i/BcmXvCBkIdtAVnw19rH2EO/axA54pa8nrcI9W5zvwsA5HWlv84G9m+ZZFgwkbQkJIOVw8PFJEu4+0My+7CpH0Kr3D0vO8kmZRCAOxEcdfRvFqZx2vUFf/hz++e2P6M0mVv090QI/5DhRFG4cFZFBFIQFdy/EvDNPCI+R2Wjtz/LqV59lLdSNeCag1dn9xgKh/2lK9LFOm1jAmn1UvhIC8UOQauVq7zT45+d0Oha4HX4hlBMeCWzyHQDWLVDZOBajFI1383usHrn+GA9zucJ8Kj2nC0MLtCcj9BI5zFrPvDW3pkIe1RTz7dgNVbMdjDCAVB0Q6ONOUZhMx9fr8iv7jKUMj3Cn6d6L2G3uOM/jeZgOWF7i30JTZZhQel6lm7TyjrksyA8r/Dg/FwwYz0xU0FY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f52e8e15-dd13-45ba-da02-08dce8830255
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:54:15.8303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +jJPmzKrPF75hMBgmdPA77TbTPk6smTMaE7W4oMtA5u9MpiFnL6gkGkD2HojtLRGqJUoLv9bPf5IzsD0qOt/3KeahfDMsKBbD8cBYiw18hA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6585
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_14,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410090101
X-Proofpoint-ORIG-GUID: TJ45H-ZcQq7RkHscMWGQh2d4ahVeFApZ
X-Proofpoint-GUID: TJ45H-ZcQq7RkHscMWGQh2d4ahVeFApZ

resched_latency_warn() now also warns if TIF_NEED_RESCHED_LAZY is set
without rescheduling for more than the latency_warn_ms period.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Ziljstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c  | 2 +-
 kernel/sched/debug.c | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 694bfcf153cb..1229766b704e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5571,7 +5571,7 @@ static u64 cpu_resched_latency(struct rq *rq)
 	if (sysctl_resched_latency_warn_once && warned_once)
 		return 0;
 
-	if (!need_resched() || !latency_warn_ms)
+	if ((!need_resched() && !tif_need_resched_lazy()) || !latency_warn_ms)
 		return 0;
 
 	if (system_state == SYSTEM_BOOTING)
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 9abcc6ead11b..f0d551ba64bb 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1293,9 +1293,12 @@ void proc_sched_set_task(struct task_struct *p)
 void resched_latency_warn(int cpu, u64 latency)
 {
 	static DEFINE_RATELIMIT_STATE(latency_check_ratelimit, 60 * 60 * HZ, 1);
+	char *nr;
+
+	nr = tif_need_resched() ? "need_resched" : "need_resched_lazy";
 
 	WARN(__ratelimit(&latency_check_ratelimit),
-	     "sched: CPU %d need_resched set for > %llu ns (%d ticks) "
+	     "sched: CPU %d %s set for > %llu ns (%d ticks) "
 	     "without schedule\n",
-	     cpu, latency, cpu_rq(cpu)->ticks_without_resched);
+	     cpu, nr, latency, cpu_rq(cpu)->ticks_without_resched);
 }
-- 
2.43.5


