Return-Path: <linux-kernel+bounces-548671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E00CBA547DB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC9D418916A0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785072054E7;
	Thu,  6 Mar 2025 10:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QWuAl1RS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ehRFrAWi"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13882036E3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257271; cv=fail; b=GnKaol6qMvfK9EKZ+nCc+6zEWfmqByyoJ++WbaVs8pexN/Dv5+WXEN6dPiJPa3EmJX7dNh7lqaj3I67+KJLAroHdch056t6jUqSVdaDcTRtitDcBIw9ddtxo42TeKRmVFveFHA41wUjIGAou/FddGhOHC770jdOEVWKtMAb8xwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257271; c=relaxed/simple;
	bh=ux0bcZdT62Mv02nEG3MfIpmpmk7imcJ15OghwGWzrd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZUC7Uz1d5ZJrhuNJgF/eRSFW3ksFynXBlP0J8epjr1eN7OqRbf8PhxNQwXbuEZTJ3djwuCmdDvmhtSGKgL4ezi1FGx7fhfruvRXM7lcbEtHGCMzSVIBnaO8D6y8eFe7Dh1STQ5IxsVKr178JPxiPhBR/JVoepLmwQEPqAMUmdHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QWuAl1RS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ehRFrAWi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526ABfhF024533;
	Thu, 6 Mar 2025 10:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=KFsDTc2m7sSYu76rEqtlN3pEVJgvjf1GbcQX824iAmc=; b=
	QWuAl1RSF6BXGvGSKKipBs1Q82oEFxbyyNaaRDUDfTt+gtBDva5K8XvLUPTg//5v
	0EXym8UildZjYOsJJFsFdYCh0at4YHGW8Pi9lRcs2KIoJjEcYEup1TASYZkmZGKm
	WRcnq7eIRYZ3iSgBw3EI2OFz+UiJfiJHMTLwQ9Z+bCtxQEMMA+01oaPz74Bplvlf
	gLSU6xe8IESbkHhBDWJ9wS+l0K2m3HctMw/mTIIqDZAYNnKIiZ/f86i/fVvB+jpS
	eMfm3v9ebO9h9kTIybX76hoNuPUkD55TIq/cKZ8jwbi99FjmQCBsMrx5UMlxNASQ
	qoHaDzgUdINmXfN8EkP2OQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8hhttb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 10:34:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 526AAEKi038403;
	Thu, 6 Mar 2025 10:34:14 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpj67u6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 10:34:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ce7QyQj4x1DsVfbWle+9dIHDlaDZMIq9fTMLcs8ethVs5WkfDeGC/PEROyqL3pey3lLaM5Nr0YakciJ099IiJE7ndheRR79Z4YOdxTfUjCGivJk2cChp7mm5LT/XKpmHnvW2TwUBE3GgP9OhGyCvecNBSzwSNmjhL1hf9iP//M/+puGkw1pniJjrq6nFDamOn0dOEX/dhPUlrE5gPGrSk6V5LSUJrRd/wCIoPnOsBI8mr6pzIHMAlwVCYWqH9Iqliq6nSLALW4WzD9zu5Sc7vUH8Dz9nL+pQUapsO/Q49+TeJDdPy1j/4tmtsQu+4a5YpXbs8PKWQsu03aLlBP3xjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFsDTc2m7sSYu76rEqtlN3pEVJgvjf1GbcQX824iAmc=;
 b=lRjQsTnwnM9AGrvZIIJNWEJxUIPqP7jfxMi2Q7UnL1KXs2HHm0ZYnH33mOtQdT7vBax/7BkETqD7d/EugVRDq9voQ7R3B3MDpZ2sFrj94ZnnFNmVyrDJDBWKGW96t1uRS20sXl7pIV2Gw+pgWJ+CXC3lMHaICg7rYjGVHemtLEpw2VkXDtcYtXvuGclGRBN6vJkDjh9jzpt0k75tZHYEEGvw4ouQKzfTopsDPnYsav3ZCkygiGUgpp8vAq8Yg5tPqC96F/duDbhU19yIEqZyiNA4fZLz2I6hs2PfkOb7it1Aun5I9LL7nmp/TTMenNdJD+w65uJrLnL48HE9Q9AqJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFsDTc2m7sSYu76rEqtlN3pEVJgvjf1GbcQX824iAmc=;
 b=ehRFrAWivrAssvSNdmh4IUNP3jaLGNXKHTMbYUFsVBsdy0HLsI1O6IvzzHWCxYScTQ+bugS72WFWiuyD8As/InXrloxDt7u1BfumTEYefA8gxrKY066oBGSzoJqDN7uFNk+r6sOAsIPEStHzOePm+k2fKsE9frfz+eT8YGgOm7k=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by PH0PR10MB4647.namprd10.prod.outlook.com (2603:10b6:510:43::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Thu, 6 Mar
 2025 10:34:12 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Thu, 6 Mar 2025
 10:34:12 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH v2 2/7] mm/mremap: refactor mremap() system call implementation
Date: Thu,  6 Mar 2025 10:33:58 +0000
Message-ID: <6a62c1a4ea7f362b0685bbe3a2e74a47d24e5c43.1741256580.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741256580.git.lorenzo.stoakes@oracle.com>
References: <cover.1741256580.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0197.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::22) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|PH0PR10MB4647:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e834499-ff8f-4cfd-69ef-08dd5c9a6f43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pnUmkEw1zXuGS3pciXi6o94tounfY0H/SFNkbkLnYpEaLzd4UuNQxRVwihlR?=
 =?us-ascii?Q?qQPMJU4g2z4+pQg/Rmz3EQD6zGOJ1RxqjiYx7yrt4eRxViLv9oBrCj5MY4+7?=
 =?us-ascii?Q?c5QbEZarR4vSt9Gk0u6/w6XmaHXM17qorVKSj/YLqXqk9kr7GoMcgnmbaDjM?=
 =?us-ascii?Q?hIAMy4YsQgz6J4DbOAWsWwkONKXT2FGwyPYq675nK34b1RDZ2GVyeLCgtk4k?=
 =?us-ascii?Q?d93QV10VBK9WAoYvuOGFMjqoH3S95ecTaeHbh9TbFffXFvDHGSiCc7qIO/7+?=
 =?us-ascii?Q?9XrGmAPCcE1lCkGgGvF1y8IN3PlmPQ7hFWKQIHDghwRqE4wkB0cJtlWzEXdE?=
 =?us-ascii?Q?qSl75PjUF1qoWFIe0WkQ2eU1p2n4jyCNwFelWhxD/KCS8aX4twPZYSBwQ4Uc?=
 =?us-ascii?Q?RKbQc4pJXEx0oBMnbdXZqp27w3P8e4WPPqp1jnTK5gq9ObhbDgRgWH/G1kCn?=
 =?us-ascii?Q?b7QJncH8pZ3YGS6E91tWk2DAVtJvsx21Mic1gHUQTAgCaONuKvWsnNeqOHLG?=
 =?us-ascii?Q?yBuBxT6cvNWOpH4F00RXeqB+6MrYlFJz/ZerQHijSxXV674bxFc5gR4JREHG?=
 =?us-ascii?Q?z9yPJOPVO97AF5Po4DG1zEV3PcdzZSGcAUm41E4rvHMQczdG3nVcIqF406Kc?=
 =?us-ascii?Q?TeBg6StVWivueLPOQlARFxqX/WTbSNejxfpwsQAygX+atgGlwZbO3qrHwZFX?=
 =?us-ascii?Q?Lokk+hRtFqS2O1gBNsdL/bed3AlV2Ia/ZWrIioGSqC2h87KqAs31l9vZhWD/?=
 =?us-ascii?Q?fO0l5bSmG3XGQiy+rEvvcCRe8A9Z8PIxvjuVb0V5qwjbufXsDJlUbZMKAKu5?=
 =?us-ascii?Q?dhXAgC2qyZ83CBc0eMbWco8Zl7uC+VD9qyOCvonUsgPrInXqbXXIa26rEC1e?=
 =?us-ascii?Q?l8hUU4/zwJQSF0jFWP7sXO5l4TeT2Ih/yhByjgW2ZdeZgkixSBN1o+PUXWOf?=
 =?us-ascii?Q?JXdWfJHr+2mJxlJejt3qyNxrQqjGEXwthEAJuWRRhchF+lL7nQ5PfEq5QGCC?=
 =?us-ascii?Q?H3SeNh6UmYRSBwJPBwxuBKXdc98yqO5uVIOP3iw6hP/UFlvEhLr2Cl7q7lKf?=
 =?us-ascii?Q?89F3njlC6ptVR5ljZ7C6rF6kmwjsoLsalEKuv/vwfOkKAqILryAN+4JPxK3Z?=
 =?us-ascii?Q?EiO6G2kAOFp2O3uMEY/rQ/wGvD8NyOvnu0CXtSoC6cf2xwH9nbrB6nQuDGYf?=
 =?us-ascii?Q?NfuRhF7IUqZi6uz7G6YVXbEClfJC6TPKNXDGxoPUaVowa1ul+Ruz56SfN8t6?=
 =?us-ascii?Q?dlqM/aVz4u/Tp68ciStTZmte68LOWC06xjDTpaR+JxFxtG/YalpitbKids65?=
 =?us-ascii?Q?JS00JrWpabsQrs8y35Qyjr2aXmKQJUA9s12n/dPzpmXFPNxOoKY/S/DxnqjQ?=
 =?us-ascii?Q?49eG0P3iFsJxd4jHP03oCvn6s2ox?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p08QpdzhpNpmEUxVNOxLO50NmAcsK1/PaeWrDkxFo++4GcdkCbBQGFQlLWBr?=
 =?us-ascii?Q?bm1ehFPyUtBEveg3b+KzhY5aEfQNWXiR2ekc1C3lXeDpoZk5L6K0Quvxx50T?=
 =?us-ascii?Q?TIemdy6QhoAzWRHfFqchqCWdIWtxcSeh+XFXIG9YIHMDAYYkOSncqe5tzmEV?=
 =?us-ascii?Q?aEowl2NWyxH7vX+QtndZuc42JYQ6gDd2Vh6VmufDpqzM7FdG/PFHWQoctYd3?=
 =?us-ascii?Q?Qx38lW1O9+3kQsQqcDVnHDW/xQjsx1R0xgi9U3EhQmLovHkA5SDLl8Xczaki?=
 =?us-ascii?Q?/NHNJa/GZGF/u6+WhOd7IMpPZ8Je4TBasl8QvPtqw3WzcZHma0+5fXMyoCkL?=
 =?us-ascii?Q?AmSAxmpMFcj27eRypmJ7eSyJ5c0QxT8HFfY96BD/bPjNsw/7ou6qdvli0it4?=
 =?us-ascii?Q?554QIaiQYaQZ31MIiyWuEeN1LpXZTX1/4Fm+r5Cg5osB8YdsgK+zk9tPmEmd?=
 =?us-ascii?Q?1MfhpAbL47bNU23WX1oKo1vbyqSKV3Sw9ifUNP5113V9ppbljm4RVQIoz4aa?=
 =?us-ascii?Q?WUdzwvRbCbzS7qo0oNTh4A5w6U8g88UECvoR3FpJ+ePsaN9tv/FR0f5MWq0w?=
 =?us-ascii?Q?VlONh6qM22gRf+83oKGnA92qpoTywHYRvKoshODvVt5/kB/a/XueTxuewXfM?=
 =?us-ascii?Q?t7pm0r9XD8qDy6arI5hsm9KztlAXzbNeShS0dBkDmZFEdhTU2NLp93NKXWIj?=
 =?us-ascii?Q?iHDL2bk4VYqBPJBNNv/dj93Elhsov4K3Ks0C4RbrrB2HWDym+qs5fL1twd0D?=
 =?us-ascii?Q?qHyzIheW9CJ6ZfGfPe4jmz6jyvNHAkbns+BDahy8QMoyDMzv5+ljjFf3GNMa?=
 =?us-ascii?Q?TfzwpTxashPmndRw2Xte220tlIUFmDcg71AVuo37yWYNVVVj5XqKTT/cypbo?=
 =?us-ascii?Q?kRAotpjMcIhXDEc7n7BkSG10sWs90nQSKIWIZlJtOMcGr394y5LysXfDaDRU?=
 =?us-ascii?Q?KtOIHHiufhF6EfgtinXcoktH46q9fWUjdVj7Q8meuOhv/KU+CC+pkpj93svQ?=
 =?us-ascii?Q?Kh5NHsmHfN07fAC6TbPidwovF4cC4AQxIaxcnJGphP5kh4H877NN2mDkI50Y?=
 =?us-ascii?Q?xY6yHXnXBD+H6LkhRhVEaTbj4rzS8h8EUwQfs41A016gMD56zzYAKWDp+lmS?=
 =?us-ascii?Q?+Mgv+LrfSDS9OTtSabyiFmvdHRsp/8k9FQcdkQLlo6mmTD/NA2NkmoBmYF/9?=
 =?us-ascii?Q?eXuDhwqT03EMkvXr5kmmgWxYsA0tm5GgcocPsSwbfFtCML6E275Rp23btk1j?=
 =?us-ascii?Q?KRRflFVAf12X3j44cRIDZjin0E14MY1fVnOlcQiM+NbF30BHdc34VYijC9Z0?=
 =?us-ascii?Q?mK181/j6tf0Kwhh7pO9cUk2Zi1b/2H8ayxYt+Crz96h0N6/OofNTDJQkL7qO?=
 =?us-ascii?Q?X2VM0qlWg50dDMZ2JN2xcFEGYf5NeWaL3lPNeboHXvO2pcufZSCbZW3YR2M0?=
 =?us-ascii?Q?6sRJILtOoE3gtbbL+de5KvYt66NrArvOgM4VZjpKpYiAEs0G17RB93HyQXdQ?=
 =?us-ascii?Q?5m2iX5TcY/vexFlHErfaQEa0N16b9T7hyGVg0654erYs6Zl/q72/Dxb32tFY?=
 =?us-ascii?Q?2iX+fWzlxgK6vQe2H2Jwcou1keSES/FOurpgEn91XDP1vqcC9oB8VLmCUWC0?=
 =?us-ascii?Q?sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ldHCv+oePHu5gZsCazBSBZfQtuFL432SSXnjoX2AMZe3vqKBABkkVbsKDIYJ9sbDsb/D68eg9YyQRAcUh0vxVIuCMW8/56mwM2wzLvWXSuriEiQT1mN5AfOnPSCvLVGFYhzK+AY95291RCYqyLT7vTTp+9RVz70kkDNf6Byx8XG1ZV+xJ7gFqM72ha3OfCdx57hO2zROQaoCrXcYh/9OE2ZLhGem6lPZ/B7HJximL87R3WQHojtFVWe4drze/geAM0tMBRCKb9itBdvufWr+aW9HjjI9r8G97byUyQrpGzvgRTFlTIELR+aha5NWmcdz32By9liip3STQq/meNujSDthpYWa5nObEBVaCx5AAhsHp11+UxRaVkaxgyv/SJk7LLTKQXOwexmqFO11E4mHGwQyT3BsA3mJ3iwjWwbnpyJL0d3h2odQ5zGuysjbCSrWvWdNAULZ+Gjs7HimV76EpvuKZJgyoDaRvxSjsnBbE9GIhyuGIcuKNvRhzmwjIAUhehS3+n0IE/CgGUf4uMvl7MABIZfHzeidr5JgR7+PBVsOVWQ68PqcpTC5o03CwGWhilK2WMJiPpTOni30Ulc5ev1jkVDucnmU+5lQCLN+6n8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e834499-ff8f-4cfd-69ef-08dd5c9a6f43
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 10:34:11.9864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kaZrh3DYFpzW/kOgs9xM9gBS1AjPR0Yo/T0GSNI1a8CydT9wB3JlNutrvq8a7edsvoVMSyNdMTSqxlcZCX375xv/GwSHOnKB/hatJe945ug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503060079
X-Proofpoint-GUID: ff0Vst4zLjB1E6usFDdq-BB48XmosC4U
X-Proofpoint-ORIG-GUID: ff0Vst4zLjB1E6usFDdq-BB48XmosC4U

Place checks into a separate function so the mremap() system call is less
egregiously long, remove unnecessary mremap_to() offset_in_page() check
and just check that earlier so we keep all such basic checks together.

Separate out the VMA in-place expansion, hugetlb and expand/move logic
into separate, readable functions.

De-duplicate code where possible, add comments and ensure that all error
handling explicitly specifies the error at the point of it occurring
rather than setting a prefixed error value and implicitly setting (which
is bug prone).

This lays the groundwork for subsequent patches further simplifying and
extending the mremap() implementation.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/mremap.c | 405 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 251 insertions(+), 154 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index c3e4c86d0b8d..c4abda8dfc57 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -942,33 +942,14 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 	unsigned long ret;
 	unsigned long map_flags = 0;
 
-	if (offset_in_page(new_addr))
-		return -EINVAL;
-
+	/* Is the new length or address silly? */
 	if (new_len > TASK_SIZE || new_addr > TASK_SIZE - new_len)
 		return -EINVAL;
 
-	/* Ensure the old/new locations do not overlap */
+	/* Ensure the old/new locations do not overlap. */
 	if (addr + old_len > new_addr && new_addr + new_len > addr)
 		return -EINVAL;
 
-	/*
-	 * move_vma() need us to stay 4 maps below the threshold, otherwise
-	 * it will bail out at the very beginning.
-	 * That is a problem if we have already unmaped the regions here
-	 * (new_addr, and old_addr), because userspace will not know the
-	 * state of the vma's after it gets -ENOMEM.
-	 * So, to avoid such scenario we can pre-compute if the whole
-	 * operation has high chances to success map-wise.
-	 * Worst-scenario case is when both vma's (new_addr and old_addr) get
-	 * split in 3 before unmapping it.
-	 * That means 2 more maps (1 for each) to the ones we already hold.
-	 * Check whether current map count plus 2 still leads us to 4 maps below
-	 * the threshold, otherwise return -ENOMEM here to be more safe.
-	 */
-	if ((mm->map_count + 2) >= sysctl_max_map_count - 3)
-		return -ENOMEM;
-
 	if (flags & MREMAP_FIXED) {
 		/*
 		 * In mremap_to().
@@ -1035,6 +1016,218 @@ static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
 	return 1;
 }
 
+/* Do the mremap() flags require that the new_addr parameter be specified? */
+static bool implies_new_addr(unsigned long flags)
+{
+	return flags & (MREMAP_FIXED | MREMAP_DONTUNMAP);
+}
+
+/*
+ * Are the parameters passed to mremap() valid? If so return 0, otherwise return
+ * error.
+ */
+static unsigned long check_mremap_params(unsigned long addr,
+					 unsigned long flags,
+					 unsigned long old_len,
+					 unsigned long new_len,
+					 unsigned long new_addr)
+{
+	/* Ensure no unexpected flag values. */
+	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP))
+		return -EINVAL;
+
+	/* Start address must be page-aligned. */
+	if (offset_in_page(addr))
+		return -EINVAL;
+
+	/*
+	 * We allow a zero old-len as a special case
+	 * for DOS-emu "duplicate shm area" thing. But
+	 * a zero new-len is nonsensical.
+	 */
+	if (!PAGE_ALIGN(new_len))
+		return -EINVAL;
+
+	/* Remainder of checks are for cases with specific new_addr. */
+	if (!implies_new_addr(flags))
+		return 0;
+
+	/* The new address must be page-aligned. */
+	if (offset_in_page(new_addr))
+		return -EINVAL;
+
+	/* A fixed address implies a move. */
+	if (!(flags & MREMAP_MAYMOVE))
+		return -EINVAL;
+
+	/* MREMAP_DONTUNMAP does not allow resizing in the process. */
+	if (flags & MREMAP_DONTUNMAP && old_len != new_len)
+		return -EINVAL;
+
+	/*
+	 * move_vma() need us to stay 4 maps below the threshold, otherwise
+	 * it will bail out at the very beginning.
+	 * That is a problem if we have already unmaped the regions here
+	 * (new_addr, and old_addr), because userspace will not know the
+	 * state of the vma's after it gets -ENOMEM.
+	 * So, to avoid such scenario we can pre-compute if the whole
+	 * operation has high chances to success map-wise.
+	 * Worst-scenario case is when both vma's (new_addr and old_addr) get
+	 * split in 3 before unmapping it.
+	 * That means 2 more maps (1 for each) to the ones we already hold.
+	 * Check whether current map count plus 2 still leads us to 4 maps below
+	 * the threshold, otherwise return -ENOMEM here to be more safe.
+	 */
+	if ((current->mm->map_count + 2) >= sysctl_max_map_count - 3)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/*
+ * We know we can expand the VMA in-place by delta pages, so do so.
+ *
+ * If we discover the VMA is locked, update mm_struct statistics accordingly and
+ * indicate so to the caller.
+ */
+static unsigned long expand_vma_inplace(struct vm_area_struct *vma,
+					unsigned long delta, bool *locked)
+{
+	struct mm_struct *mm = current->mm;
+	long pages = delta >> PAGE_SHIFT;
+	VMA_ITERATOR(vmi, mm, vma->vm_end);
+	long charged = 0;
+
+	if (vma->vm_flags & VM_ACCOUNT) {
+		if (security_vm_enough_memory_mm(mm, pages))
+			return -ENOMEM;
+
+		charged = pages;
+	}
+
+	/*
+	 * Function vma_merge_extend() is called on the
+	 * extension we are adding to the already existing vma,
+	 * vma_merge_extend() will merge this extension with the
+	 * already existing vma (expand operation itself) and
+	 * possibly also with the next vma if it becomes
+	 * adjacent to the expanded vma and otherwise
+	 * compatible.
+	 */
+	vma = vma_merge_extend(&vmi, vma, delta);
+	if (!vma) {
+		vm_unacct_memory(charged);
+		return -ENOMEM;
+	}
+
+	vm_stat_account(mm, vma->vm_flags, pages);
+	if (vma->vm_flags & VM_LOCKED) {
+		mm->locked_vm += pages;
+		*locked = true;
+	}
+
+	return 0;
+}
+
+static bool align_hugetlb(struct vm_area_struct *vma,
+			  unsigned long addr,
+			  unsigned long new_addr,
+			  unsigned long *old_len_ptr,
+			  unsigned long *new_len_ptr,
+			  unsigned long *delta_ptr)
+{
+	unsigned long old_len = *old_len_ptr;
+	unsigned long new_len = *new_len_ptr;
+	struct hstate *h __maybe_unused = hstate_vma(vma);
+
+	old_len = ALIGN(old_len, huge_page_size(h));
+	new_len = ALIGN(new_len, huge_page_size(h));
+
+	/* addrs must be huge page aligned */
+	if (addr & ~huge_page_mask(h))
+		return false;
+	if (new_addr & ~huge_page_mask(h))
+		return false;
+
+	/*
+	 * Don't allow remap expansion, because the underlying hugetlb
+	 * reservation is not yet capable to handle split reservation.
+	 */
+	if (new_len > old_len)
+		return false;
+
+	*old_len_ptr = old_len;
+	*new_len_ptr = new_len;
+	*delta_ptr = abs_diff(old_len, new_len);
+	return true;
+}
+
+/*
+ * We are mremap()'ing without specifying a fixed address to move to, but are
+ * requesting that the VMA's size be increased.
+ *
+ * Try to do so in-place, if this fails, then move the VMA to a new location to
+ * action the change.
+ */
+static unsigned long expand_vma(struct vm_area_struct *vma,
+				unsigned long addr, unsigned long old_len,
+				unsigned long new_len, unsigned long flags,
+				bool *locked_ptr, unsigned long *new_addr_ptr,
+				struct vm_userfaultfd_ctx *uf_ptr,
+				struct list_head *uf_unmap_ptr)
+{
+	unsigned long err;
+	unsigned long map_flags;
+	unsigned long new_addr; /* We ignore any user-supplied one. */
+	pgoff_t pgoff;
+
+	err = resize_is_valid(vma, addr, old_len, new_len, flags);
+	if (err)
+		return err;
+
+	/*
+	 * [addr, old_len) spans precisely to the end of the VMA, so try to
+	 * expand it in-place.
+	 */
+	if (old_len == vma->vm_end - addr &&
+	    vma_expandable(vma, new_len - old_len)) {
+		err = expand_vma_inplace(vma, new_len - old_len, locked_ptr);
+		if (IS_ERR_VALUE(err))
+			return err;
+
+		/*
+		 * We want to populate the newly expanded portion of the VMA to
+		 * satisfy the expectation that mlock()'ing a VMA maintains all
+		 * of its pages in memory.
+		 */
+		if (*locked_ptr)
+			*new_addr_ptr = addr;
+
+		/* OK we're done! */
+		return addr;
+	}
+
+	/*
+	 * We weren't able to just expand or shrink the area,
+	 * we need to create a new one and move it.
+	 */
+
+	/* We're not allowed to move the VMA, so error out. */
+	if (!(flags & MREMAP_MAYMOVE))
+		return -ENOMEM;
+
+	/* Find a new location to move the VMA to. */
+	map_flags = (vma->vm_flags & VM_MAYSHARE) ? MAP_SHARED : 0;
+	pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
+	new_addr = get_unmapped_area(vma->vm_file, 0, new_len, pgoff, map_flags);
+	if (IS_ERR_VALUE(new_addr))
+		return new_addr;
+	*new_addr_ptr = new_addr;
+
+	return move_vma(vma, addr, old_len, new_len, new_addr,
+			locked_ptr, flags, uf_ptr, uf_unmap_ptr);
+}
+
 /*
  * Expand (or shrink) an existing mapping, potentially moving it at the
  * same time (controlled by the MREMAP_MAYMOVE flag and available VM space)
@@ -1048,7 +1241,8 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
-	unsigned long ret = -EINVAL;
+	unsigned long ret;
+	unsigned long delta;
 	bool locked = false;
 	struct vm_userfaultfd_ctx uf = NULL_VM_UFFD_CTX;
 	LIST_HEAD(uf_unmap_early);
@@ -1067,70 +1261,38 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	 */
 	addr = untagged_addr(addr);
 
-	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP))
-		return ret;
-
-	if (flags & MREMAP_FIXED && !(flags & MREMAP_MAYMOVE))
-		return ret;
-
-	/*
-	 * MREMAP_DONTUNMAP is always a move and it does not allow resizing
-	 * in the process.
-	 */
-	if (flags & MREMAP_DONTUNMAP &&
-			(!(flags & MREMAP_MAYMOVE) || old_len != new_len))
-		return ret;
-
-
-	if (offset_in_page(addr))
+	ret = check_mremap_params(addr, flags, old_len, new_len, new_addr);
+	if (ret)
 		return ret;
 
 	old_len = PAGE_ALIGN(old_len);
 	new_len = PAGE_ALIGN(new_len);
+	delta = abs_diff(old_len, new_len);
 
-	/*
-	 * We allow a zero old-len as a special case
-	 * for DOS-emu "duplicate shm area" thing. But
-	 * a zero new-len is nonsensical.
-	 */
-	if (!new_len)
-		return ret;
-
-	if (mmap_write_lock_killable(current->mm))
+	if (mmap_write_lock_killable(mm))
 		return -EINTR;
+
 	vma = vma_lookup(mm, addr);
 	if (!vma) {
 		ret = -EFAULT;
 		goto out;
 	}
 
-	/* Don't allow remapping vmas when they have already been sealed */
+	/* If mseal()'d, mremap() is prohibited. */
 	if (!can_modify_vma(vma)) {
 		ret = -EPERM;
 		goto out;
 	}
 
-	if (is_vm_hugetlb_page(vma)) {
-		struct hstate *h __maybe_unused = hstate_vma(vma);
-
-		old_len = ALIGN(old_len, huge_page_size(h));
-		new_len = ALIGN(new_len, huge_page_size(h));
-
-		/* addrs must be huge page aligned */
-		if (addr & ~huge_page_mask(h))
-			goto out;
-		if (new_addr & ~huge_page_mask(h))
-			goto out;
-
-		/*
-		 * Don't allow remap expansion, because the underlying hugetlb
-		 * reservation is not yet capable to handle split reservation.
-		 */
-		if (new_len > old_len)
-			goto out;
+	/* Align to hugetlb page size, if required. */
+	if (is_vm_hugetlb_page(vma) &&
+	    !align_hugetlb(vma, addr, new_addr, &old_len, &new_len, &delta)) {
+		ret = -EINVAL;
+		goto out;
 	}
 
-	if (flags & (MREMAP_FIXED | MREMAP_DONTUNMAP)) {
+	/* Are we RELOCATING the VMA to a SPECIFIC address? */
+	if (implies_new_addr(flags)) {
 		ret = mremap_to(addr, old_len, new_addr, new_len,
 				&locked, flags, &uf, &uf_unmap_early,
 				&uf_unmap);
@@ -1138,109 +1300,44 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	}
 
 	/*
-	 * Always allow a shrinking remap: that just unmaps
-	 * the unnecessary pages..
-	 * do_vmi_munmap does all the needed commit accounting, and
-	 * unlocks the mmap_lock if so directed.
+	 * From here on in we are only RESIZING the VMA, attempting to do so
+	 * in-place, moving the VMA if we cannot.
 	 */
-	if (old_len >= new_len) {
-		VMA_ITERATOR(vmi, mm, addr + new_len);
 
-		if (old_len == new_len) {
-			ret = addr;
-			goto out;
-		}
+	/* NO-OP CASE - resizing to the same size. */
+	if (new_len == old_len) {
+		ret = addr;
+		goto out;
+	}
+
+	/* SHRINK CASE. Can always be done in-place. */
+	if (new_len < old_len) {
+		VMA_ITERATOR(vmi, mm, addr + new_len);
 
-		ret = do_vmi_munmap(&vmi, mm, addr + new_len, old_len - new_len,
+		/*
+		 * Simply unmap the shrunken portion of the VMA. This does all
+		 * the needed commit accounting, unlocking the mmap lock.
+		 */
+		ret = do_vmi_munmap(&vmi, mm, addr + new_len, delta,
 				    &uf_unmap, true);
 		if (ret)
 			goto out;
 
+		/* We succeeded, mmap lock released for us. */
 		ret = addr;
 		goto out_unlocked;
 	}
 
-	/*
-	 * Ok, we need to grow..
-	 */
-	ret = resize_is_valid(vma, addr, old_len, new_len, flags);
-	if (ret)
-		goto out;
-
-	/* old_len exactly to the end of the area..
-	 */
-	if (old_len == vma->vm_end - addr) {
-		unsigned long delta = new_len - old_len;
-
-		/* can we just expand the current mapping? */
-		if (vma_expandable(vma, delta)) {
-			long pages = delta >> PAGE_SHIFT;
-			VMA_ITERATOR(vmi, mm, vma->vm_end);
-			long charged = 0;
-
-			if (vma->vm_flags & VM_ACCOUNT) {
-				if (security_vm_enough_memory_mm(mm, pages)) {
-					ret = -ENOMEM;
-					goto out;
-				}
-				charged = pages;
-			}
-
-			/*
-			 * Function vma_merge_extend() is called on the
-			 * extension we are adding to the already existing vma,
-			 * vma_merge_extend() will merge this extension with the
-			 * already existing vma (expand operation itself) and
-			 * possibly also with the next vma if it becomes
-			 * adjacent to the expanded vma and otherwise
-			 * compatible.
-			 */
-			vma = vma_merge_extend(&vmi, vma, delta);
-			if (!vma) {
-				vm_unacct_memory(charged);
-				ret = -ENOMEM;
-				goto out;
-			}
+	/* EXPAND case. We try to do in-place, if we can't, then we move it. */
+	ret = expand_vma(vma, addr, old_len, new_len, flags, &locked, &new_addr,
+			 &uf, &uf_unmap);
 
-			vm_stat_account(mm, vma->vm_flags, pages);
-			if (vma->vm_flags & VM_LOCKED) {
-				mm->locked_vm += pages;
-				locked = true;
-				new_addr = addr;
-			}
-			ret = addr;
-			goto out;
-		}
-	}
-
-	/*
-	 * We weren't able to just expand or shrink the area,
-	 * we need to create a new one and move it..
-	 */
-	ret = -ENOMEM;
-	if (flags & MREMAP_MAYMOVE) {
-		unsigned long map_flags = 0;
-		if (vma->vm_flags & VM_MAYSHARE)
-			map_flags |= MAP_SHARED;
-
-		new_addr = get_unmapped_area(vma->vm_file, 0, new_len,
-					vma->vm_pgoff +
-					((addr - vma->vm_start) >> PAGE_SHIFT),
-					map_flags);
-		if (IS_ERR_VALUE(new_addr)) {
-			ret = new_addr;
-			goto out;
-		}
-
-		ret = move_vma(vma, addr, old_len, new_len, new_addr,
-			       &locked, flags, &uf, &uf_unmap);
-	}
 out:
 	if (offset_in_page(ret))
 		locked = false;
-	mmap_write_unlock(current->mm);
+	mmap_write_unlock(mm);
 	if (locked && new_len > old_len)
-		mm_populate(new_addr + old_len, new_len - old_len);
+		mm_populate(new_addr + old_len, delta);
 out_unlocked:
 	userfaultfd_unmap_complete(mm, &uf_unmap_early);
 	mremap_userfaultfd_complete(&uf, addr, ret, old_len);
-- 
2.48.1


