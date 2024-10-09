Return-Path: <linux-kernel+bounces-356426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D34B9960EC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB30CB217BA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C77B183098;
	Wed,  9 Oct 2024 07:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jB1BJW1w";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c0zcw6pu"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE3417C9F1
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 07:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728459068; cv=fail; b=ho3x99eJVg3hrKiBUjlblTSeOK9vPH17YRSDweNaTNzThLuZF0L+JF/HCmcUKj2UJtrlRRy3DXQ9VCUBM3ZLL9FxlwbW/WDH3pYSdxX/sLcxq6L3mVilUostbyn4F1xPdA54pGE95kBUlNx7rsLZ+qZ2y5eKcbTLSsuAWXHA1qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728459068; c=relaxed/simple;
	bh=dRcvFuemhEqTGgj6diwSQDVHqhiweRqdPvGnbqb55co=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=ouNqGMxdoKrNoelZDnNPh2sRqwk6ZVgQTvydXqu5B8aJl3lEg/IIRpGLWwrpdKrztr3UZH0TeYiJS0s1O6oMoZBR/EI9RzHzE4PyuI+1l6A6hG18mLW82vXSXIrE6/FecTtEcPLkwzirsvE/G3vNSSx4xVZ39iZRNY49BG2rYO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jB1BJW1w; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c0zcw6pu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4991tfPg026977;
	Wed, 9 Oct 2024 07:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=dRcvFuemhEqTGgj6di
	wSQDVHqhiweRqdPvGnbqb55co=; b=jB1BJW1we9Pvm6m7NN+UZ8EjqOerDKknwd
	WmOZFwnSq0NkDDHO89m0w7L62sDjK8N+HFN7qB2byMHdb06Dpe7dsSQkLBGhDeRl
	raK/Svg5YYlIwpnXACcQyAMR7sgnasN1EnU4XJS94n4SwUUTEC8aiEmXmPu4hq1S
	EmyLcTstKGok8xYeSkLphxMNs668ayrmP/7m54xFFq1YLLpfUsn2gOGw68rBWlqd
	QZHSxE9uwaBhPuyiGmGygmZoRz2OsYzD035obhruB2/gZz6H/zMyUpE1w75eMB4x
	aaEHOfx+xYbUOr3LaM+ohNfUWZ8qj4jAnKItPstoa6V1yZJIRI/g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42303yfha7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 07:30:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4995jTeq038219;
	Wed, 9 Oct 2024 07:30:35 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uw88vwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 07:30:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwOWa5POHVztAtofs77mZ2OwqkAoHBfUTqp3TMHfuMJB4TNXyB8jLVy6XA22/mNGvUzV4o9BUQmBD7QdWfZxci7KKVjyXbZK0Z3OI9AKBVRL6+CZl5cuoENPYYWMf+JyTM6dsqBXWbs6glEmwaHfZyoZ5TxGS5pg5dyTitixoRPVDgDTmVX4z4iGf+yPeNZcmPcMeNbAzDrZKPHDylkdA6zWg9YbDavwQhLtHmheJON5KHz1FWU18MudHbwDrp2o95g5ozVMgYjYGio2Xt022pA1ZIFaWt3ZNf/MdPmygyZjbnQ4CcJl7zNVJ8DbBDNTVmni6VOeIUUaamcRG5srFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRcvFuemhEqTGgj6diwSQDVHqhiweRqdPvGnbqb55co=;
 b=i1WhLBWy5m/n7V9NKBlnHii/wT6DfJoH79tzcYh6FxscL+ED9PuNaXv2c7mm6Gy6j05IDZd+BnsK+5QGmtbQ1E37Qj/t+1BZU6r/h1pX/Z+jvU49iHh3Du78rgCZn/TQOmHtmvs2DPbr5LBhzpL5NHjzw+CliJamEED+P9dMQyrJ618wpT6K3HppmHvyWA2uDFN0zZ0tSAWbrdt5ntaVLA49pnEPyGuV2iodCZEC0SHZGZZmM8AWdKQR9rpD30CjYy7BO7Kt3zySWLJq2P7bMczE+jjhYRYqTBYTKYWL9K6UbmuEIbB0+zkfCjf2NXu54Y8HV8vRiNzrCoZb1ulonA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRcvFuemhEqTGgj6diwSQDVHqhiweRqdPvGnbqb55co=;
 b=c0zcw6put7HY2AmVSxbIIKBdsla3qZOrTJwabu2QmSY+yJblOdKkNtwQS5+qTV3HQT/h4mujW6oda2V9lxwqx6Wyze7BN85RSQ4Bwq201zRogMPIvb7RG2S4WUr9/KrNW0BCV8vdoHuUkvY8GpnvAfNEuZ/2Tba0alharGAYk2E=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SN7PR10MB7047.namprd10.prod.outlook.com (2603:10b6:806:349::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 07:30:33 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 07:30:33 +0000
References: <20241007074609.447006177@infradead.org>
 <20241008153232.YwZfzF0r@linutronix.de>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, ankur.a.arora@oracle.com, efault@gmx.de
Subject: Re: [PATCH 0/5] sched: Lazy preemption muck
In-reply-to: <20241008153232.YwZfzF0r@linutronix.de>
Date: Wed, 09 Oct 2024 00:30:30 -0700
Message-ID: <87o73tbund.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW2PR2101CA0028.namprd21.prod.outlook.com
 (2603:10b6:302:1::41) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SN7PR10MB7047:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eb6febd-d42c-4a49-e6fd-08dce8344290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Paa0dnDNAh3tMd9bYhWmp6Z6Qbka3H8g6P0o7IXf1ou2qGaOnDkQC2QcrkK0?=
 =?us-ascii?Q?cSTz4LtLzV5cVxGQh0xevyi9EFIyw+MbG4HPMLB1xR0PTAOhaVH65OfhXGYC?=
 =?us-ascii?Q?qomwhoilO9suWJXmrl3Nufdv1hSZnT+IxFoTEuiyHwcm8PE22Hzw5RJZBxJT?=
 =?us-ascii?Q?gebsQziTjud7nlaXJEuhfOztOWPtUyEmF7mzku0VjTc5pxmCn3zVQCNh5I01?=
 =?us-ascii?Q?p9cMr6kvOuChzDpy49wA4CQ8MVoKLDSMTmZ+IWBpW6q6u+g294xRHEZfGzv2?=
 =?us-ascii?Q?KaZlP819Ca071EB0GEm/iSyU2DAyXvG1RjsbmjspboQsOh3wgpgdTMGSGcay?=
 =?us-ascii?Q?hgl8etllaBXPUTR9OK8lHYLtbd2eWf08HK1hqU/4ffvuPAUMZIiLGxZhxYvM?=
 =?us-ascii?Q?wYoWGO1Pdcjz1SqCz3iL1nrLAtqEyiMo5i1noMh2CZBJEuz0D6pCPYvza7d2?=
 =?us-ascii?Q?hRDCB3wLppYHvnk+aAkC36g6dUx4u9WfK51hpbwoo9Gaeq2ivO1ocnYQomXk?=
 =?us-ascii?Q?4YTVtSb7V9euLlOlUgtMV1istCsne1JEiARThTTehL/LTLgftMV1A+gmo/gp?=
 =?us-ascii?Q?c9f4l1WZCHKTRV7kNfCbksu79QMGzEacpC6JK4bPgsGhvDRYsYmGT6o+JoEl?=
 =?us-ascii?Q?npuboz+XWFQcWMHyFcZ8uNmeNe5fBqvXHQZilNfJEaF5xzL6aFVtiqUhQ+17?=
 =?us-ascii?Q?FD8JOa1bZFLReRPlKV65meUt5g4YJfWMOO/GWrqe2ZOCEer3oTMKHBmrWpGc?=
 =?us-ascii?Q?IvEoCiasU1z2zvy1VPWsdRgu15zs0yr2YjWxGaLg4/ARpdA9Zv27U2YUdokE?=
 =?us-ascii?Q?8EeokX79mpRKBreNHjcwlvj45jWMAHU2cPiHoCF68cScM4vIUa43oiPRvMZG?=
 =?us-ascii?Q?6E3kjNe91ZuTpBU6Tj68Yr3VHWqFe6fZerVaXCV9UquO7hMS2Xi6sVwYhr6w?=
 =?us-ascii?Q?jh+ynM0rb/fYrA4rAlQvKnw1TqxVpE40WL+cnSMGhkqR8AIxztX//JpnohD1?=
 =?us-ascii?Q?o1WEC0q8iaBOjfb6M1vX9wqctxGLltxKL/srlwG+x5BaHEOe8MxP9coiumjH?=
 =?us-ascii?Q?yB3X5/TDr3XEt1eHrbTZfLgQhlno0ALmixpp2KSX4ei34apS1r8OW3dsn2Sg?=
 =?us-ascii?Q?v6iRf4X8IDQ86kEdrekl/XpQZDjpA3ZA+540+vuwP17uDSXt7FJXLA7VU6XB?=
 =?us-ascii?Q?YESGvx8/fKczV8e3zGdfdI5J7Byz4c9X0FpKNJQ6HGxagD1KA0HxyW4eBpQj?=
 =?us-ascii?Q?eusVYDCdS9IHh705T3kGbr47m02LKCJ3C1UpdM4wkA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?84ecNK847NV0Y0Tdl59u4nQHutpowH+HfObTAj6W1XT6JG4/XUGdzGLF0iP6?=
 =?us-ascii?Q?c9xZrPPj61emU1Za07T4w0tOWHJWtdt5dKBuXn3lyK4LSAYT80tFb96EqxcK?=
 =?us-ascii?Q?EP9UNp4239CLopwZl0X7YW4PnOm4+lD1XHmCPqlcR1whZg5wGigi0wfr3xK3?=
 =?us-ascii?Q?vWvAc/HBvbIYN1ayi7PKDyUlaeXfQoXC3J/KbNtCoZYaOuI5LdDqvdBPwEUj?=
 =?us-ascii?Q?rkUbQbhPA5CZ+R6k+HkRlta3wRpgFRirclh4pIHKaNOpescAgKHCV5lYssvj?=
 =?us-ascii?Q?jIRxT5QQYKJiEbWskxq9F+jjE948vdjmhcC/DBbN6s33LQQIbPH9aaFufZYe?=
 =?us-ascii?Q?+mXX+6E40ODy5/nXX/D4kAX1Jbx8VFXxwpU4G1kv3ZzxBQWmrqDfUvZo4VOr?=
 =?us-ascii?Q?3akZjCcDnWpep76XWOphOMILE0WUMmD8HskbLs6tyhbwiyAVBB8eq8ucIwwL?=
 =?us-ascii?Q?ksOGTiB2UI4u6dQDfy3DmQmuZfqOp3KupE+wTFmIquuqUnY5DCbxAiy+OFyx?=
 =?us-ascii?Q?Fc9Cyj9UKnyq4VJPxdqZfleCswgVG1E00TkYHvDOR11C6XRq4qUlZhATbAa3?=
 =?us-ascii?Q?LlcIQSObgJsSCe3yKwXqiFp1zgbtTMisnMh/Qu2Gwx8eSQT9xESVzFH4AX8c?=
 =?us-ascii?Q?ddbyd9cHKsObvLx7E++APWsiR6kDrjfRbdg5tFfSvqsJAbmfMO2HtDJWknzv?=
 =?us-ascii?Q?aGx4xPmvPhBtrQYEKp0UzuorszAJdkg+DQ2BpyKCrstIf2HU3eH7NSSTGrqm?=
 =?us-ascii?Q?2QmngI0EgM+JxH6/CBf3qHFEJ9E+G4SNPapRRD/oWvIyl6GHND4f5AuDJk5I?=
 =?us-ascii?Q?RvSM+VZF9U8bLczCcZ6w6uzV66WXrIy2BfX3ctYbLrTqNWX43wDgVPyi31nN?=
 =?us-ascii?Q?U0TDhywHRhQWboJRpIUj9L8yLzbU9RueRB15OapGynOvnECuC1pjd7fCTKsA?=
 =?us-ascii?Q?3BJtcF2DoTdOtsWiXfMsMPZ+XQE4c7fe4h38id4hf5GBNKe1esyMfq585z14?=
 =?us-ascii?Q?is6w5OGCUy6H3wtfGwZkfoQUgsaQW3uYvwtnIn3iyQamC5zv9IJKl98ihq8b?=
 =?us-ascii?Q?PRsZPen5THCzzJAyBtK+bnOnGstahMhPO3lGEIQTkwru4GV94ZFCFgPaxOeA?=
 =?us-ascii?Q?xoTrlA3Q86M84VLPtOVw1mUP68nszTDqvwm48RDK6a1LUR5JKu9mCkQ8QnjU?=
 =?us-ascii?Q?33/qUI3oFw/XyYogUTbD+jaeTGIVtkShcd3kNQU0GPMMXFoSpJASCATY9rt2?=
 =?us-ascii?Q?qFRhjzTJRN4ms35wcBMZLNj4UBLhn7I6rfItZiR+q+MHJRY7MqxWZCgORj4x?=
 =?us-ascii?Q?0VascOVgAk1EQBL3OMdLqgkBt4pdaQ1ltceo+0oLM+ehQULVbKU/0NAGA4EP?=
 =?us-ascii?Q?TKrcHnn5ICxgNPhqLTaObsAP/40gvrey6THm6oC7539a3TX4YEFKp2fDGnJu?=
 =?us-ascii?Q?H3Ng2SfTkcjvzl+S6QfG8zeQk3qM8DPEEKtfIKT1eUS5Op+zasnWRXD4b2ZX?=
 =?us-ascii?Q?R0c7tOiCUZlHYN42ehJp4RN4II9GYle/N1EvqbH/VF/c6Hvw1VH28s+6y/WA?=
 =?us-ascii?Q?klpWY6uyIrjCzmhl1LL0PfZySjTtmdYOCCS4mODtBJeZhQzvCyI7JWnPr+zn?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	S7d3vhDfVkJJYx+lICja3EXUDmSYju3weSR2YXencrJ5gihX60SXocPrXzfFWsSHHbONJuBFGbKP2WUGplupshE+/U0swcgEHH8AebWD+BszogeLjgIrElaALLgXlUkoxtQ6hT/IxHFygvOpdIYtuxVqCoZRMw/1YgrwBYrKL8g9UCvhGs4WdTIur0iekvzQYkin6vyJ9ATXQVYke35Rkmw0texkhEAonKxBkg2rTaAzd5t82PuMI+3jdqxjd3El4JNSpB++TESevLuEM7ervv6T4Pr5peUHSem/b27Q8MrNemcscAos/nwOrk2q+nppAwI2fR7zNvU4PCboTu1id5r/Z45u+nyYvsLQp2v3CZo9woGIpM1zwOVUxpnu0m2vjJf6Rev2XBC6SiiZCOSkPforAys+oKuvYn07SyvDfnJyRaVgLm7zViL3O3KLzU36jJVirtzDe/eUddwhSRVkt7OKugFnG3FY7BRQSpTSPJ5nUtC1eYwmwguiqPci7Uv9t4FswX7nVwbNxeCurbZdQxLjpe1Idk9Fk092gNrTjVBa8MEWnuozlB/84JQmlqT5M2lZ9z/Ib6pWJQZNH2cvONzFhcAFzrN0+JSclInNWFU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb6febd-d42c-4a49-e6fd-08dce8344290
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 07:30:33.3827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H75rYx94kpaV/avdR9wH4Vp6QPpaulAgPJ/az0n4YDEPWsG++BrxPhj8d9bOoWPmdX1aGRGhsDkfwdnTYTv0OaVZwODZNSQoJAHXcUEl8e4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7047
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_06,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=700 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410090048
X-Proofpoint-ORIG-GUID: SYWH66u2ir13Bktt05sTkGFc7j8lSWMu
X-Proofpoint-GUID: SYWH66u2ir13Bktt05sTkGFc7j8lSWMu


Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2024-10-07 09:46:09 [+0200], Peter Zijlstra wrote:
>> Hi!
>>
>> During LPC Thomas reminded me that the lazy preemption stuff was not there yet.
>>
>> So here goes, robot says it builds, and I checked both a regular and PREEMPT_RT
>> build boots and can change the mode.
>>
>> Please have a poke.
>
> I have also tracing and riscv bits which I port tomorrow, test and add
> to your pile.

I also have a set of RCU, powerpc, and tracing bits. Since you are
working on the tracing part as well, maybe we can just unify our
patches before sending to Peter?

My patches are at:

 git://github.com/terminus/linux/ sched/lazy

--
ankur

