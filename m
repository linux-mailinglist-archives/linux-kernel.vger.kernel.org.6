Return-Path: <linux-kernel+bounces-555955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EB5A5BEBB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC60188F376
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D3A251782;
	Tue, 11 Mar 2025 11:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="att4kcBA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V55HtGK8"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B004224AF3
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741691895; cv=fail; b=ljLysm0CFL9wNTZPF0Vv4lKBjAJ3DseCyIjFJfVLC6EYoskbdbSBpTJIwM3kkcDjlYgVVz9JowUyw7oO7jPxL5QvGM29Oj/okHVjmSoHFYjp/g+CqsaqkmjRL9+m2ypr1ys9L/S8x+n1do2jWCy5U/2jMFxZK3rE/gdDUqWUl/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741691895; c=relaxed/simple;
	bh=DBR6Vkf4jkiTOc8mVdtG8mNuGeWoghhgfeu9NSIAGNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cEB2kyt9PsDNHbe2o5x2LUBtndkBcCBDVBo96wR095h0D5u8qMt++EL3fGTkh6Ef1rAWHxJvr848dYF9hq8JttznUAYZ8iRO3ji5r5SuZSRUNIXHGqwVBHkZL7Ui2dUmfy4E0br9X46TrAqvFlKf17LhQ3MoKHLSnTktndVsToo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=att4kcBA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V55HtGK8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B1fuTm015713;
	Tue, 11 Mar 2025 11:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=0+D4cmJFzU0phB5aG8
	HF6AMTn0BX13MsjUYXPcLjpss=; b=att4kcBA9e5ntiT/B118ExLWsbJYhCxaGQ
	VEDlvHgmEkg77JmtaUG1If1FY6kEQ2jzxqojKraZyWa05uWbMbcOp+m4kVl3gb5J
	udyCsgaUf+r6YFlG6kBqLDRO3cq5CdVb7z/WN3Raax7z+HBj4dguhrutXeRru6bD
	XBUyOOMHAhGLKDU45EAOfHTWLasBWcVFDW0mqFokG8z/NaRIlcwONKqRD3artl4T
	SWJ+F2F/t0dwstYzQ/6yHE4cUHoREr2AGc8yN9E2ECP+bpGHyE3vVI272K+XIYh7
	69wBm5S5Ukdmroe5f0SUMmnDMVvGe4OTpS9rcntc6IxXj0Enja6A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458ctb4p3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 11:17:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52BAcT5l028912;
	Tue, 11 Mar 2025 11:17:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458cb8v926-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 11:17:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQCayPmSbD5d73zr/L4qt25GGIz9PJC7jSRYifXBm0hk131JZ1EVn2x28fTcuPb+BwwYFFD7XDJ3ocT+NpEX8ZcXQfyJrDf36mpkEzYebbAMNjrbgaHqpeAheCN/YrZ2qVM0pEgLOVbobhaLDVCiK2KMw2t1XV5VuCqn2IRXmhA2uGtuaIRY+lu4K2HOOei+jj+eik+XSJne/vvm01XEomH27WuoPJnsp+SM6PgGdRfhaKoJTrN7dcOAb5nrTS+Bpc6RDyTxeq3Di0/zsl8Q8az6jY4akuK4uezSwVn/Jp3AHFJEQR3+k6scKx/DIVn/DbccWoEmLRE/1p//OgiiAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+D4cmJFzU0phB5aG8HF6AMTn0BX13MsjUYXPcLjpss=;
 b=WUaQ9ZCaN0NSlq/bl1oDuTfrWChdUD0HlIkjeKzvqQxZXRN1SDUF5I9u1F29gcIl7HLpEYLLPTZVO7E1rrhNn7//BHrpnP7ofD430BxWp+q8Txww8xBlRCbbRVr+lV2M6O4OvHy5tRUznl4rAXk4Jcc8R6Sv+DZrD4ScBLnGvWdwDnXJ/FVZNeWcUHWjdQe7QYDgSQD/H/Yd2yh8E1aN3JhQs6TdKGyHsIZBgHGQy5kuLdi/f5E0Y5shItmJ78U0FMekGtM7sdXDnY79T/kRPLzZ8qK33nM/pbQ4ZkANDZK2ocat78ZXjCIw194uI1cbFN/ttdEDPuJfvky+KIacbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+D4cmJFzU0phB5aG8HF6AMTn0BX13MsjUYXPcLjpss=;
 b=V55HtGK8JeUpZun2USNUnQVEfHy7cXekzJaflhGfyHXz39wMtB3ANvJcui9O1A4iJIArDdd8H7W7c2Ba/p1YzujOtFVGK+w8+FEr6InPa0g/5T8r6PY1WeSP1GcEzpBCO4JqQAOUfD2D2NO+mo1L1BPYKFlniri2sMlQCywPjFA=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DS0PR10MB6847.namprd10.prod.outlook.com (2603:10b6:8:11e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 11:17:54 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Tue, 11 Mar 2025
 11:17:53 +0000
Date: Tue, 11 Mar 2025 11:17:51 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>, "Liam R. Howlett" <howlett@gmail.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        kernel-team@meta.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/9] mm/madvise: batch tlb flushes for MADV_DONTNEED and
 MADV_FREE
Message-ID: <a4fa3cd2-ba8e-4d23-a513-e3f54456306c@lucifer.local>
References: <20250310172318.653630-1-sj@kernel.org>
 <20250310153921.47d390c637105e3ad6fc49c0@linux-foundation.org>
 <mecl3oimrbzeh3o2gaolmpqeyw7f7npme4zhpnzkqohrgxwotq@qssi4idgvftl>
 <Z893lHkRWhHDuWUC@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z893lHkRWhHDuWUC@google.com>
X-ClientProxiedBy: LO4P123CA0445.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::18) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|DS0PR10MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: b9786d74-37a2-4f53-4fd7-08dd608e5e1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t6mvvgjRXjAizVKuv+ARYEi1Q7tpz+5NKJPM6jrfo5G0vBBK0i1DaXL/XNm1?=
 =?us-ascii?Q?K3pauBoWFkWlq7C3YBgFnNuoQFNmJ8az68sETUHU+5KCNj6XnvIhXOTFmJYr?=
 =?us-ascii?Q?mwL4QeHuWNwqvYobO1+7XMUTI4Vib3+klXzcI8HfYCHWeFaQrSaGITZmAZmd?=
 =?us-ascii?Q?G4Cel5nyRvxQ6OXCA1+9ejkeq8c1hEZwtwm4oiHHd+lQnraOFuBQg0JYUZek?=
 =?us-ascii?Q?+fhV3Uf5fLgEs5ycikXCd+Gg5boEwNq/wcjgaMw09J8+Fov9tls02s6hXSbN?=
 =?us-ascii?Q?cUpste6WcHyCBNZqVtrmIKfkqiOCmKEfyfO7YuMWvCpGMvXxuLXDRiosZ7AU?=
 =?us-ascii?Q?kRcZ9kO6XQ7ej5/rWH7TTGrNELlFZl/njeQf0k+ZBypPQTDGO29SCep4OHC6?=
 =?us-ascii?Q?T1NAARpka74cHO+c3MkkIQA0wjnUvJaXUy3kIEEu6+Jg1TIO2Khk7383JL5Y?=
 =?us-ascii?Q?vSFVyOz1vOH6ZEBq+hwD08BO5b+an7q1TvoMjvUIyziizfERa3gEg3axjCQV?=
 =?us-ascii?Q?F+Qrnpl+RvtgR/g4rWXI/57ouZVj6osr5SemIbme/G5bxuPw31ay1s8Aisxp?=
 =?us-ascii?Q?RILzmXdEhj3yCPGqy1ZtTi547dr37h5WmNJ6KxDovyBVpS34ugIUvjm2d6d4?=
 =?us-ascii?Q?cLj5+D/kAXKFr1Exf0qHJVS5oihGuCRiFSq+v5He2T1SkbQlBoRT6n/aIllz?=
 =?us-ascii?Q?FdiNudwhGQCxchK5/JI+x0ny+6WI4zFyCdYP39+DSw7SfA2PP+qRfLkuPKmU?=
 =?us-ascii?Q?I0E6jz+ASrPkmueEnTXYX3urNlZsIjPFNxH+T/ab3Ml3QkiVY0ddxhzDS9zb?=
 =?us-ascii?Q?E8HUW9+LnDZIeIevnaxQU3WBiAMNLV29LCV+pivKVD9v0gc44hItCKuou3iM?=
 =?us-ascii?Q?gZ5xEccVLhuZOXxe9hxdin/aW8A7w1UIcr9GiYjprqu8E3AcmW0XhrhA1Se+?=
 =?us-ascii?Q?347iloJKULWzb6pmO+hX0aFc0axkdTm7mwT3OHSPxDUuuhtMtqLvqV/H45ED?=
 =?us-ascii?Q?vgE3HmombgR69AwSEZHL7LJALRqAczipvYUk3biPDSp8lVPm+9BeFzjqKdcx?=
 =?us-ascii?Q?niDeGkYuPwKYYVFobD6EXXk77z/eJQlum3aHPHHXcbEMTHAVMC+Dl5Lq+cI/?=
 =?us-ascii?Q?+bWluOsw/9jNePM6d2votndXfNliC/lJU0gSX5ugKOziw+Hz5YZ2L8Bf+xOG?=
 =?us-ascii?Q?ABBUldtGR7TptZCud8irvOmvgPIgPrVKyQ/yiET5ALDg4CjZGz5M8mG8ULcM?=
 =?us-ascii?Q?Uxy/NVC/pIl69B3K9+FweOtEnlRHD7n6NMzdlKj/d8N5+YIHEO6XYBPf0K8h?=
 =?us-ascii?Q?uXCK+G9hb98eGaU7xpq5NDBBPgvTegberQhAADf/fF0+7via2cXgsjfVYnP8?=
 =?us-ascii?Q?EFkMwocHxCrOdmg9OC+ia/VymDMr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hVUxb7wlIf/MaCFSzzPB3gskJ53AnAE+X5xfxPIZiX1QXk5YylBoYnaQSxfJ?=
 =?us-ascii?Q?XO0AUVHvdSasB266VnD8YhfopFqM+PVZTraaYNZqU5lIMrbr3JtL61wLXyDk?=
 =?us-ascii?Q?QAckf0R83Aqnf1JkYHojyoy8gjFrt7z4SnCSDtVvCnOuRp11XMQE1sqYTK19?=
 =?us-ascii?Q?GUBc6HdGMHVz3VrFpiMsE/2xJRwh8EEzq9JWVkfYEr8cWYvlKFbWTRtnVyE0?=
 =?us-ascii?Q?eup+6C6zi4Co+VQMw5WIrjS4+wFkNPcKu6UagWZ/qVCC8flezmTUf5cy75Od?=
 =?us-ascii?Q?EBZ6qhjcmm/aDTksRB7sKCc7BnW4RgZr0KzZVkT1goGzruS6nzJ0C8lnJSZ0?=
 =?us-ascii?Q?blhF8Ur5sIaFkE/dL6/boS18IlOoj16qiBIz6Yuxq4lYr4F6aCtstPsb1tzb?=
 =?us-ascii?Q?k/ZNXJeOSmCgjWNnVGt7XmJZEmgvjVyHjW3D2bY5rtV2G5ZQli4Vo8tqNPCl?=
 =?us-ascii?Q?pd8Hf1zJHv3Yt92iV7ty5n9QnJSyp0aoJZ4QEocFq3EVw0QSYiafrZ2yzCTn?=
 =?us-ascii?Q?M11JAjrAUTCQwY4rFNAQdV7UCjGLt4ymb/X7peDMpnE2gZY5j+8IHMKWL0cl?=
 =?us-ascii?Q?q+3eI0ilrfBIXEpGTBi8N30I/paXa0FLvpXd/8X6iTDPG64wctKbfuvJQBTb?=
 =?us-ascii?Q?LEVSxV5rAEzWURaC3RA2tmUG9JIg3QSimUZ+EYwltdz/W0d3MSWGhKR1hMmd?=
 =?us-ascii?Q?I5STVfSgsF/emWS6fU0NYrk0/KCyr16SesgCqv30NZcHVDkwr/XfOX1ctsSS?=
 =?us-ascii?Q?6+42KkAKBrb9/ADKO5Z9nXd6So5p6ni5c7kYXembsSKXgeIwl8sEMn5feOiF?=
 =?us-ascii?Q?iq29cs/y61WYWLk84Km2C8kwDjiNFuFrIdtsnvy4pmTu9KJWXUrn40cHMzc7?=
 =?us-ascii?Q?8t7oI/cEtHh1sOCPqyMqcdN/Fj38dqC7GuQ9g8bswA4wZKo3NaSDWD2yJS6t?=
 =?us-ascii?Q?syODa9vlAyUq1+ULPUrBm5KRfl6hRBZZOrJCxNDsMXwfuBM/EQkG8pvkGxFd?=
 =?us-ascii?Q?E6qplPUiAbjEoFNXOevqr/96t3qV4NpFff+AnGgDt/wiQu8ste+ZN097pMNQ?=
 =?us-ascii?Q?NF6tQi3hq9riZy9Q3kBIAwa0U7JVzUmteKuabEvPjVKAmsd01lY9b+ZM990A?=
 =?us-ascii?Q?4mVB5wYDq3PoOpz2+GAinHsehLvketPHuvOJSO/6GD4eWoulPOJKpnZVoXok?=
 =?us-ascii?Q?EzVYzWEMJ56JUgGAHRJT/NrF6q82gjmyWwhrEcYA7MJeVy53lxqYWyo9GD+1?=
 =?us-ascii?Q?pS/jrAAyZWUKIUtpTHOBw9xMBipLMmZgpoW4qFdw0ho8KapVG6CpKqWZ6dpL?=
 =?us-ascii?Q?ZldJjnFugZPCdWAa657jidQzAxI2mg+MuyoRvR36EDNnub9AJDyJL/ayiYy2?=
 =?us-ascii?Q?LGUIrWshV5/L3nH/YLlUqVTsYzDhidQxtqW5A0WCJOm+Q98HtRIB9f+7GNhk?=
 =?us-ascii?Q?UgSb3AIn34gIY+CgtdAiXlKAzhkFSovBrJ98cV+uRzrBfB4NVQfEvoOF0gpq?=
 =?us-ascii?Q?scCELnZy85dH2Pekfsh0LE8C+ZoJTCgslXBlqlXEyoFz57d3K3txgg2bKakH?=
 =?us-ascii?Q?yVT2o/wDYAMPGlj+685WiGoMPYq+9MZq9NonDolEgwlp07qTmH90oWkevfYo?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aesRHoWqK73NIueOKRfLN4NRpCy0wNlineDkQhlkUXp0kWnSkj5anfBkQ3QA2KDM/Gu+Z7K/VnAjSH8ppqx1TtCmjBwaCW6WQEMOyfAZKnAC2iaxFMDdfJ1bQjtSGG4BudW1lZpAMkWCH2SNVeGYTbXZnPxNyhhl+5zShBJqyDmE59Chvajr6nzOFicvso8m8Zz21HdJ2n94EZKTWRX5PIw8BUr3aHiXZRtDvrANd/Sy69+KH3KEKwCWM0cdxLxpYKdFUM/M7eU4CMezkLjtJWVqzEAWaU/Zn4pvt2YJjnMrHPQAckAw8PEfqiBYMwnF8AI383CnrMbTgh/oOquh/VuctAbxB896Ok/Vs6N/H5wnNUlhojn3ZgPk9oFbzXVU/XDNSn3MKrN0OoqBLjuF9FS9RM7OmMQgwhJYf6u9ta2wkrs8aBC6/WndqoAxxGrmOeYffaL+msCDgQdud0nZ+jrKq9EaxApW8Rx+PeQoWp1QyaTDJZQOSea5fIvqJxnaPjOmvHtLQ7zG47rdB1A3qfY0DSvu2m+87PD6aO9nJtenHsJQiBgiQwUzcz/0jVIfhnTwZmGP2bJhaR3YUDHCIpJJKtaBdlYb3qXkfJn6VGg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9786d74-37a2-4f53-4fd7-08dd608e5e1d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 11:17:53.9268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCp+H5JLms1ObW6yeGAb0ZXVOZLqH/tK3qT6R1sL3BAlST65Lm9275+U0U+O33MpEDYZV3IxxQ0Ckbghlnz6BYa8YgYhuh9paJ+MpB4QfMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6847
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=491 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503110074
X-Proofpoint-GUID: 6KQjVemxotUvAjaTLlnCiHxgWGFz-UMA
X-Proofpoint-ORIG-GUID: 6KQjVemxotUvAjaTLlnCiHxgWGFz-UMA

On Mon, Mar 10, 2025 at 11:36:52PM +0000, Roman Gushchin wrote:
> On Mon, Mar 10, 2025 at 04:15:06PM -0700, Shakeel Butt wrote:
> > On Mon, Mar 10, 2025 at 03:39:21PM -0700, Andrew Morton wrote:
> > > On Mon, 10 Mar 2025 10:23:09 -0700 SeongJae Park <sj@kernel.org> wrote:
> > >
> > > >  It is unclear if such use case
> > > > is common and the inefficiency is significant.
> > >
> > > Well, we could conduct a survey,
> > >
> > > Can you add some logging to detect when userspace performs such an
> > > madvise() call, then run that kernel on some "typical" machines which
> > > are running "typical" workloads?  That should give us a feeling for how
> > > often userspace does this, and hence will help us understand the usefulness
> > > of this patchset.
> >
> > Just for the clarification, this patchset is very useful for the
> > process_madvise() and the experiment results show that.
>
> +1
>
> Google carried an internal version for a vectorized madvise() which
> was much faster than process_madvise() last time I measured it.
> I hope SJ's patchset will (partially) address this difference,
> which will hopefully allow to drop the internal implementation
> for process_madvise.

Relatedly I also feel, at some point, we ought to remove the UIO_FASTIOV
limit on process_madvise().

But one for a future series...

