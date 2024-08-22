Return-Path: <linux-kernel+bounces-297897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 084E295BEE4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B523A283186
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7310AD55;
	Thu, 22 Aug 2024 19:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UyjSsk/4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K69pW+Tu"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C031D2F54
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354831; cv=fail; b=MEoXy9vsJyNqBVgSRQCVtPZT9qOeoWNRTaXEtXbTGirw4jwYLyEhHooMiYXP4jAHk/ve3AIFNcE296MpoFwllCQJH7FM1osSQjPOGiR1+55Q4TomUHptcF5zvkDG/eqIPn3E+z47jeKMEWDfEw8HHSI57cVqVJm6rMTXS1xw/I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354831; c=relaxed/simple;
	bh=WlrZn9Ii73I7x7rQX4poBky1sGBd8aMPpGlmjGb/Sac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z7DfGKU4z8DfrL020A3ud6bot89BHLVIbEdhIHZAoHU13BPDYamSEOkNHiKKbZAGRWFvs9xMSQOANCu+xydtS4OmnuTl71YF9lq+wSe/+vpqExuGgzkqEOoCzyRCg67d88V3N/w9HA7ByAsKtoZrdHaI64+MNAZusVfLoDZEK1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UyjSsk/4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K69pW+Tu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MIMZnR025771;
	Thu, 22 Aug 2024 19:26:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=Nm50G8hesDrXLpOFDcpgh9FovxUYHbMgImgPa3a7NFw=; b=
	UyjSsk/4Vm4KBnSht8mONiqj2lqkFq1xaWYS8zUJ5P9YtW83Sdvyr7H/0pDQGReT
	UC7G7qLIGRaN66OlG8TeTM977G+EuVPr3xiqLVOEXgHA0GCrUeRuOP/XCZ64zh0K
	I0AmA4+UL9IRWHbdLwXenW3tuLUs5EFd5Xy9zwNtHAS4ZUkURsOzs0XVHmaO+I1m
	Pm/pjcDjSVuQNCS2bYtlK+x5bJXQSzawA+9TYyr2rGtrC1/Itr5ReJXJJlvrl3eU
	COLEh+9L7GVoSphojlwkDX/zxjpKmzhgOMM6ad6gKzZ3hlmihZoWuduiRnpmvf81
	inYXqxAGA78J2zhEZxBwTA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m2djxyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47MJJK8d005374;
	Thu, 22 Aug 2024 19:26:54 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 416bcu08ec-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQG01Df1ldRuGNyZ1elBjHO4rHyxYP8tfkgmUNFLj+ZAiAX25pNR4mkWmqRNiUfZ7i3EEcfSVjOZucEDPSd0ZaE6+ixcy9eCMHcLKt8JjUeeJ4LsPIhDaN8xuabHr5+vlNgx54cdyhVOo4atf6d30/xLNgLg907A1RpVKQyk6izdUMrAZU3QqZmgdT9cfnd06ZCcnSLQhyaCN7ojMtiJ0Reot/tzVN5XlYXbpb7Gi7dOsq2jH8aSCSEbqbcqK0DuKh3giTZPhYvGzWSpfFT6nf846Kty6WfsIJcREPXS+Q43P81LHuKp1CzvjRmkHdaTz1LSm5tBu5UEGo2eCbM4qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nm50G8hesDrXLpOFDcpgh9FovxUYHbMgImgPa3a7NFw=;
 b=IGBgowwmZP3cwOVsGHIFjSpi2Uf79Yc8n6uRvL2w3rzniNInIquAd5NWK5eroNhX1MT6hNRC4fvmQrE6w/K8FnaL8xPjwXKbivMr8XCOhDN9eAwVTUpA7gmo1haalb42TY57vtc2xCRjn2/Juxke0Ntsp6GSOjVUmE6wGTaPIPBFmQ0i+jT69UUXadxzMh6FFSCEX8JvgYnErz+msT5KGnNzT2RqQimZRgHkZbryz5szdwgLBfwqZMk1fkf5FN138GpOx1jz8Cc4CS54iWwu18/yKTeQZ+n+FcTWf8dG35ueAXirQy788aiNo6mcw8Jev/3uNXkPuF6Zy3UA9lPBXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nm50G8hesDrXLpOFDcpgh9FovxUYHbMgImgPa3a7NFw=;
 b=K69pW+TuHnznUN3yZKKIJzqpF2BjKZTyzIiEqkKqDhm6uIek/QIdM5+2aNObd5tdfXws21gAn2KxxP8ova5yMS/SmaKEnIguo3WMpaWFbHFTCGVWm6z9xqPedaMI3UPoy1zQyyzCJg9gUe8SObLF2MqybD+MIPCO68RW7ZEchI0=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB5729.namprd10.prod.outlook.com (2603:10b6:510:146::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Thu, 22 Aug
 2024 19:26:21 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 19:26:21 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v7 06/21] mm/vma: Change munmap to use vma_munmap_struct() for accounting and surrounding vmas
Date: Thu, 22 Aug 2024 15:25:28 -0400
Message-ID: <20240822192543.3359552-7-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
References: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0046.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::28) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: 780c3f00-8115-4fe9-a8b0-08dcc2e04d61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?FQUYcPTr3YHZlMRzt8rrfylU1s5o0vLUPKx7RzvHSXQ/TBXtM1u8qek6qNqf?=
 =?us-ascii?Q?UiJGne0RJqrPnOewzSc/eruZ352wXzKwKkqzfGL2sgPtJ2NmOD8srhcAPQeO?=
 =?us-ascii?Q?o4FKAOkEI/3PGYbbF9RqduIoswSFnxz+CuvCjK/efJvJvAI9LD5dLqR/+qpX?=
 =?us-ascii?Q?OISNzxvkg5dRkzDKRnJfMQTODJEjMupsJs4+uAQN4oTgp4Olq98XkOzKAq6u?=
 =?us-ascii?Q?+cp88cuVO8jwC90fH4XORaW33z1YE3Ykl1CP3Yp61NQDOjByS++ya+o8a9h/?=
 =?us-ascii?Q?AoF/fzvXx9bTrE+di+PPlVdIrunbwr3NgcLJMZQi0c8387rTfug9pN/6u+bJ?=
 =?us-ascii?Q?GmXSHzRynaj7e8SWZBmrxC3HpV7Tr+JE0zZuSi60y8wduqzouSMcbvkCaVKx?=
 =?us-ascii?Q?qOLLXt8dacWQuKOtEzFRt4GSNN9y6MpPFSIMIMtuDOs2cp94MFSMMvXwCwVW?=
 =?us-ascii?Q?eJaQXbwsX9pgsKKoiDOpzhLr7Z6bPpt8JFfYddGkTxohV1M80MoN7vtdE3EJ?=
 =?us-ascii?Q?xdEO7GbRTFc9qJFYMcTyvT/G3vXO9okjJrAqK+c7tzirdqKWi386R7mrQDKK?=
 =?us-ascii?Q?rWqVL7ny9moLKMr9UAGG5/YOlSbEim6ajOdxkFiEtuFdSc2jdAUYTXcZW7G2?=
 =?us-ascii?Q?0HYfuiiqJ7tMrWBkZnfLxYDZzHXvyFPCAN48ApEg8NGNescdw0PAJL+zXDDO?=
 =?us-ascii?Q?gB+c6zrKG+VBwOQCAR4HRZKTMm3GkkWKbyq/PUcL5GHW8pyFt60cVNWJuQuV?=
 =?us-ascii?Q?QJt/exmQ5+XYNwmUub4ADMzUci9n7D+Dgu3do+kKlaPZ+viJQf0mFo2ZOGJL?=
 =?us-ascii?Q?gBefKTCWlV7NRnyMH2qZf1eWtytJfWuyEaf3ReMDTys2qkAaBP7yOOPWI89a?=
 =?us-ascii?Q?kn4xiOC3P33B7xDfgmVt+kgmlD0GarAYX0WCEM3TLuelvi/v0sO2b0/QQ1z7?=
 =?us-ascii?Q?sXrAy+Mzi7jS3Kg2Lv39SBTLV/K/rNVwYn0T4MYtSJDJR5/KzA34y1KH/06M?=
 =?us-ascii?Q?L6HYUtE0IqKajuvbeJVwa6Wrj/+2lt8b1zy/uvgr4TAID1GKkKK1TBzirJUT?=
 =?us-ascii?Q?LTLFKJ6AllSn7ioLS2BH2nyxk0+PsWU0D59iMpX+Nux29aJ9zRRThF9BvoIB?=
 =?us-ascii?Q?qaU54C/m9KSrJ5GPnW9cgakHocNJgSNFaOuB4mUhbVWy7+SEDrvMlCxxRjo9?=
 =?us-ascii?Q?RwcOnSj4GjHmPuEwEmFMviBQmDoKzUUhw+jPt2Dv0U0NLYVXas17BQeuaF+K?=
 =?us-ascii?Q?c4cSx5tOcch8JWEq2NlbICTaTqQ3Jg3CmqKsSVT2qLfnt4jsB24T5gPPU1ZG?=
 =?us-ascii?Q?/w0VM+z4jTaLvtp6+Ld1icUWC/dGwiT6yDReEVA8sxfaow=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?OCmKzSWvX7hzlWZn6tNCEgTXIbqzdGtaOwK6u1dpBHoLKlR7VEDubfyYxniU?=
 =?us-ascii?Q?EsKEWfnosiOuKga2T+HzM7gnh0+mCRgNQVUwQxWSru1N4pfjMDC4B1yPx01j?=
 =?us-ascii?Q?+0L91CI2vgiGB1ffP9GY4ytbQFu6p/RiX0zkSjtCkqFDnc2VQeZRXY6zGSdJ?=
 =?us-ascii?Q?H3vJ9gIt1ZijXoAi/LObfRpVslDFQgYoGQYCJ4rxCKVLAzXQY7sGgJVWkeVA?=
 =?us-ascii?Q?g6TD61IkeWjGMRAbjW6lqfHVkMd4zhP4hiUz0ig6htcKROksRDl4P7XB33of?=
 =?us-ascii?Q?chXXm3fs/FMRxHbxiL+Vhv4prL0zCBC5oZLS3Vc35XT1Rn8Veef8Lt75LBNb?=
 =?us-ascii?Q?ZvTgh7qiAXmMpk731VO9O3FQL979g4S12JWksW0apCo/zN5qO/vhfmHMV/LB?=
 =?us-ascii?Q?jCHL7R2lnPyIL26h/UNuk0gERl8ubbevtzDEP13zdrz6qbIZ+nsvHvU76CGJ?=
 =?us-ascii?Q?VXyQcvpEHYpQbQPflcmREHtNu6Y0GsBw+hxaU2TS7sA9dlh/ah1HKXwB5Pib?=
 =?us-ascii?Q?7GBAVg7sB66lr6CvfLmS8xdAKwzMHQyfpQWIoEn4kbHL66Wf7J650L26Rd5+?=
 =?us-ascii?Q?w8gS5nJgXOOtabPZ3ygt1VYrVwuBEBxi5QAnmBB/S3nb8narghZJbaUdYT+F?=
 =?us-ascii?Q?bJCsckAstdBFKi65N3YZhYFEI9IFa6N93qNGAdQAw1lGkcAVq+KM2zaJXKEl?=
 =?us-ascii?Q?/px+vFv6PbOzrPkKkOsz5nS+eXAfu4Z/ZjZHuVSNKFpadJ9w8eQr1ZRmGC+L?=
 =?us-ascii?Q?QjkBjMibGtKcHcMCmszL+eEpdrLOAS77yJCxha3hIbaHC6JkjUThk/D17ahj?=
 =?us-ascii?Q?Rm40VFL5m8mbnW4yRei0h+oOdyBu8vvbHqaRVox755cMidZMTceuAj5042E2?=
 =?us-ascii?Q?tGaWTWCCqbta2XmnyhPGRzVR77xQ9zkERT5wvmJ18GP8kL6upJTWZtyIB+TP?=
 =?us-ascii?Q?GAxmXqBVZEikZkXZ6KnQoD8Q7Qnh30YRHPKpZj5lF+xK44SgyfyegvGorOxh?=
 =?us-ascii?Q?IJ59ZtteIlNpdQTpytb2vR7KYYtqok2xVcj0REA9Mgx2xjX45czKG3nhjdBQ?=
 =?us-ascii?Q?ZsaaxCMZumA9Dqb7pFoxlk8fmnSbVqj9OSPBHCnmxnjY99JmP9L/9Tth7Ip4?=
 =?us-ascii?Q?aTEmzlHXljx+XhKfCS9WjeJWgAOBbPTgt4b0ErAcMeoRxLFFGn0iTi2LITK5?=
 =?us-ascii?Q?D/sS6UwVImpFV5ytPI8MJPkEKFmCsCom89blMAhIMJ83ByO+8ck3S7OWljL6?=
 =?us-ascii?Q?Gvux2iNFJHRPBaWfgxs57Y1ZHw6iPPI7p/Zqla1FId1ahGvEIW9j5zsHmptI?=
 =?us-ascii?Q?uG7fbNcgKjD5lpQTyCeGcnC484j9tS4LS2hMU8SUmABoeWX8y36M4RZOGzba?=
 =?us-ascii?Q?KRETDvZeaQWdh2/LwuK2sVvm7mI6vYS9Z8DAHE1nnQcXE8M4f+1AwdWbewUy?=
 =?us-ascii?Q?UkgzmtsroslngGw4Mbe/NJgbT7jZuZl7qXmate1DEahSq7N5wKdrYYRHeIFD?=
 =?us-ascii?Q?UwZC2BlM2RZhR9TRT0Y34pY+pSwJn9uaLlNbZ+3gbVY88neh7xCuV8qV3HoE?=
 =?us-ascii?Q?PWBL0b3fLDinlHCQYPg/xMVbx4rSWxEIuqRCpNP9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 F8V+pcFNYGanK0xIhNdGUrG3FvRFqkBfmG6poy3261+EpQqWLK8GYcX7TQWXhP9PyJYethR6FKsr5a7WIvC88Off+OyvpiahjSk0aPStba5j+cExaYbv217H2TgovIMKB78h/4gKuE4olRuQKD+iBWbausnAf14rAMBUjgcAxaJIZEJJ+CvmqeiHTZYeNRtqyKE36cfenoKBOZyBmQIvp/WmlefVUcLo3KZBQnJFfh0c6OM5vnxuueSOmt+5hHXl/vojGDSratczH1AN3YoNoe/OGfGw/T8+ILjVzm7E/i5839ub0ltI4DiCgAtstQNgKgbC+XSpwZIErej7kt92wd5hV67ckOWjzhAqoKR3f+DgJzVw+mOzVdXK7SyaAZJ/KOVOuM/Ym6OcKE1UB2UycS3ylgpFFHwW1E4GBK/Jj0E39I8gOecoSYBiZrNLRCVUPHC+aym6/RMN20mM010UqoOPw8KZnjovHwsFpL+WO9E/Lmyod4yBevNoY2ANel7LKKCpEipk0IFtvbJPIV7t4xJ+qqiXFs5Ul/Q0QCmcULwdwVK8xt6cng4an1avtvcUYLytZZU4BFCFEU8qpI7BYxITz8Vaiobe5qtdvb46raw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 780c3f00-8115-4fe9-a8b0-08dcc2e04d61
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 19:26:20.8584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WvIQwv7ZqU2bMmO/vCef/lDNz36hDfwRvGa2vi4bAIIZ8x6ue8wYekpAYqPJpMH9OYNjukoLBuSfsJOIz1JyBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5729
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_12,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408220146
X-Proofpoint-GUID: q_GWAb19fzAGBZlH96lLEyPpnhj6Bq_4
X-Proofpoint-ORIG-GUID: q_GWAb19fzAGBZlH96lLEyPpnhj6Bq_4

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Clean up the code by changing the munmap operation to use a structure
for the accounting and munmap variables.

Since remove_mt() is only called in one location and the contents will
be reduced to almost nothing.  The remains of the function can be added
to vms_complete_munmap_vmas().

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/vma.c | 83 +++++++++++++++++++++++++++++---------------------------
 mm/vma.h |  6 ++++
 2 files changed, 49 insertions(+), 40 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index e1aee43a3dc4..58604fe3bd03 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -103,7 +103,8 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 	vms->unlock = unlock;
 	vms->uf = uf;
 	vms->vma_count = 0;
-	vms->nr_pages = vms->locked_vm = 0;
+	vms->nr_pages = vms->locked_vm = vms->nr_accounted = 0;
+	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
 }
 
 /*
@@ -299,30 +300,6 @@ static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return __split_vma(vmi, vma, addr, new_below);
 }
 
-/*
- * Ok - we have the memory areas we should free on a maple tree so release them,
- * and do the vma updates.
- *
- * Called with the mm semaphore held.
- */
-static inline void remove_mt(struct mm_struct *mm, struct ma_state *mas)
-{
-	unsigned long nr_accounted = 0;
-	struct vm_area_struct *vma;
-
-	/* Update high watermark before we lower total_vm */
-	update_hiwater_vm(mm);
-	mas_for_each(mas, vma, ULONG_MAX) {
-		long nrpages = vma_pages(vma);
-
-		if (vma->vm_flags & VM_ACCOUNT)
-			nr_accounted += nrpages;
-		vm_stat_account(mm, vma->vm_flags, -nrpages);
-		remove_vma(vma, false);
-	}
-	vm_unacct_memory(nr_accounted);
-}
-
 /*
  * init_vma_prep() - Initializer wrapper for vma_prepare struct
  * @vp: The vma_prepare struct
@@ -722,7 +699,7 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
 static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach)
 {
-	struct vm_area_struct *prev, *next;
+	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 
 	mm = vms->mm;
@@ -731,21 +708,31 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	if (vms->unlock)
 		mmap_write_downgrade(mm);
 
-	prev = vma_iter_prev_range(vms->vmi);
-	next = vma_next(vms->vmi);
-	if (next)
-		vma_iter_prev_range(vms->vmi);
-
 	/*
 	 * We can free page tables without write-locking mmap_lock because VMAs
 	 * were isolated before we downgraded mmap_lock.
 	 */
 	mas_set(mas_detach, 1);
-	unmap_region(mm, mas_detach, vms->vma, prev, next, vms->start, vms->end,
-		     vms->vma_count, !vms->unlock);
-	/* Statistics and freeing VMAs */
+	unmap_region(mm, mas_detach, vms->vma, vms->prev, vms->next,
+		     vms->start, vms->end, vms->vma_count, !vms->unlock);
+	/* Update high watermark before we lower total_vm */
+	update_hiwater_vm(mm);
+	/* Stat accounting */
+	WRITE_ONCE(mm->total_vm, READ_ONCE(mm->total_vm) - vms->nr_pages);
+	mm->exec_vm -= vms->exec_vm;
+	mm->stack_vm -= vms->stack_vm;
+	mm->data_vm -= vms->data_vm;
+	/* Paranoid bookkeeping */
+	VM_WARN_ON(vms->exec_vm > mm->exec_vm);
+	VM_WARN_ON(vms->stack_vm > mm->stack_vm);
+	VM_WARN_ON(vms->data_vm > mm->data_vm);
+
+	/* Remove and clean up vmas */
 	mas_set(mas_detach, 0);
-	remove_mt(mm, mas_detach);
+	mas_for_each(mas_detach, vma, ULONG_MAX)
+		remove_vma(vma, false);
+
+	vm_unacct_memory(vms->nr_accounted);
 	validate_mm(mm);
 	if (vms->unlock)
 		mmap_read_unlock(mm);
@@ -799,18 +786,19 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		if (error)
 			goto start_split_failed;
 	}
+	vms->prev = vma_prev(vms->vmi);
 
 	/*
 	 * Detach a range of VMAs from the mm. Using next as a temp variable as
 	 * it is always overwritten.
 	 */
-	next = vms->vma;
-	do {
+	for_each_vma_range(*(vms->vmi), next, vms->end) {
+		long nrpages;
+
 		if (!can_modify_vma(next)) {
 			error = -EPERM;
 			goto modify_vma_failed;
 		}
-
 		/* Does it split the end? */
 		if (next->vm_end > vms->end) {
 			error = __split_vma(vms->vmi, next, vms->end, 0);
@@ -824,8 +812,21 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 			goto munmap_gather_failed;
 
 		vma_mark_detached(next, true);
+		nrpages = vma_pages(next);
+
+		vms->nr_pages += nrpages;
 		if (next->vm_flags & VM_LOCKED)
-			vms->locked_vm += vma_pages(next);
+			vms->locked_vm += nrpages;
+
+		if (next->vm_flags & VM_ACCOUNT)
+			vms->nr_accounted += nrpages;
+
+		if (is_exec_mapping(next->vm_flags))
+			vms->exec_vm += nrpages;
+		else if (is_stack_mapping(next->vm_flags))
+			vms->stack_vm += nrpages;
+		else if (is_data_mapping(next->vm_flags))
+			vms->data_vm += nrpages;
 
 		if (unlikely(vms->uf)) {
 			/*
@@ -847,7 +848,9 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		BUG_ON(next->vm_start < vms->start);
 		BUG_ON(next->vm_start > vms->end);
 #endif
-	} for_each_vma_range(*(vms->vmi), next, vms->end);
+	}
+
+	vms->next = vma_next(vms->vmi);
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
diff --git a/mm/vma.h b/mm/vma.h
index cb67acf59012..cbf55e0e0c4f 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -33,12 +33,18 @@ struct vma_munmap_struct {
 	struct vma_iterator *vmi;
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;     /* The first vma to munmap */
+	struct vm_area_struct *prev;    /* vma before the munmap area */
+	struct vm_area_struct *next;    /* vma after the munmap area */
 	struct list_head *uf;           /* Userfaultfd list_head */
 	unsigned long start;            /* Aligned start addr (inclusive) */
 	unsigned long end;              /* Aligned end addr (exclusive) */
 	int vma_count;                  /* Number of vmas that will be removed */
 	unsigned long nr_pages;         /* Number of pages being removed */
 	unsigned long locked_vm;        /* Number of locked pages */
+	unsigned long nr_accounted;     /* Number of VM_ACCOUNT pages */
+	unsigned long exec_vm;
+	unsigned long stack_vm;
+	unsigned long data_vm;
 	bool unlock;                    /* Unlock after the munmap */
 };
 
-- 
2.43.0


