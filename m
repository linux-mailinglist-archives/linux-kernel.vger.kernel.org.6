Return-Path: <linux-kernel+bounces-398912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEB99BF7E0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 21:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 905D2B20D62
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F64E20C035;
	Wed,  6 Nov 2024 20:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bfSaA4jl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cjyE9hMN"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C584209F2B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 20:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730924335; cv=fail; b=i1gmPC9XPZZ+TjvF42r7FwXpKpcVkKQ1TLph7th3rKSKWHc19CQh7b2KHbbEd2e7UAX3wn/0jx6q5XLZSV5Nwh7nIh6vdAlJEiReJc3IlJJfansaG9P4HMyvsrKQq1zBod43138N3CH3UkF0iNax9m0bQ3OA9v1OL7HOkmmVJA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730924335; c=relaxed/simple;
	bh=9SOHCv0u4pOuU5AHupOIxgUXyU+ccCT//15dgsLHq2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OYOB9UrH0aVppg+udXGqOsISCOvELXKhH9vfQoRVKiVp6JULHcx3jEzKMNZpu1TspqveoQxECXLJlP5BtxdqF8GdcXGzHrt4xz/Cd8l4Xdo+rHXQhZoI0VYUTNqdbqMZbcaEEipnFWWh41ERU/N5e+lARbqUP0GZHkXb6chYfeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bfSaA4jl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cjyE9hMN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6JXjcn001733;
	Wed, 6 Nov 2024 20:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=b23Onze0TVFA5HAgCxmgHIRwjOBYAJ8/mRJINHkdRl0=; b=
	bfSaA4jlgMC7Ms3Ml6XwguxGgoH2imAlpCLmUf0VCemEcBcgXE2/5pa0yhvoSfBd
	SnxSZxjRGriIGdEdDHwKTrjz5C1wlxO1cM1NrpGCK67HZUj9psV7uFRORWhwTxcH
	JRhIAPNj7gQ0akrx+1s3pLX+A0RHQ3Z3PbnDwYRMpaj+QlkZgthnPqV/kNbdQXHT
	p9WPcgJqqhkS8MWTPD4g6jFINFOax+BaqtXl/F0Sx8mYvFQ6VJ3Wn7LEUNC4iq/T
	9zJ7nnT1eKpGjPyUQrPbbIjKa40Qne6cMZ42wIjc5WNVMLFJQ/H0k/Oj8NdCfQjf
	zFFOlRTnxYK/gjWcNUmABA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ncmt904e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 20:18:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6ItHS3008469;
	Wed, 6 Nov 2024 20:18:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42nah91n0d-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 20:18:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2lfSACxuhpz6MmakqmezLeuOEUJ155mYUZ/kDYrew7tkkyFH8vOy3uCK4FrSI1SsILWkNvuSPEH/sVygyFvtFVK09F/BuK1LYtOm3TQciJ5FSvjjLh9OBAVvpONqGMV4GYkkQEGlZ6PvEEntiLkUdjiPGB0MlNE7mNB3L3GZvxcvX5V4KspVco6XEbm+JAfpzxp+suVfaAgml0y9JwtUpi02sgUe2tnNdTmfcH80NZ2Nd4QloMctnkzn4U6abk89+EzKZ3QhBPSiqLlzD63TwcwSAjw9gD5yBvG/BIng0e0Lh304SHXcAO+39f50Lo1Gg31qSXjWd61xLeGoYlXhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b23Onze0TVFA5HAgCxmgHIRwjOBYAJ8/mRJINHkdRl0=;
 b=HKJwbwDAYc+y4STqmhcJVZZ5v+3x4x8rhVIbKWsq0z2Bp0PgTfImPmXLGy/aLgvVk9WTyA+pc5O0TEA+I4EG+1gfkZPCv4+LRZMTptCYJAG9ZVQQhiJtGgQKR2KUFmOiG2lXt84d2AxDt4mMStAXKHd0e52nawCHKns9m0BNknzHWHl1Zjy4gTPrhIECsHsj/jdhcqY7+whSKGusgGRnNuVwkjnPV/ulZFDmc9c+9NjePuOuO5xxb14e4rFcWJqjSrVT5QvpMX+8mLfBkHg6m8Afk4Qpos2VdEnUxGKwfCm9DwN+v87Z/CBhHPp0oFEWntT9w/NH5SmDifbVVyf/Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b23Onze0TVFA5HAgCxmgHIRwjOBYAJ8/mRJINHkdRl0=;
 b=cjyE9hMNBQqQgoCf7PQ2aM2u3D9CwTbx7/8oye5CBMVdCkk4iO7zlHrVeZa0bqo7FLDkmEk/W9tSXQMHPb7Fg0lna+/d3hCbhiPObOBUudnHoAC/Nyt3m9Ut1da7x+j/fGnPzIMf/+Dkz6BOQcQlag88Ell3cDCb9fV/BI8/Md0=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by LV3PR10MB8107.namprd10.prod.outlook.com (2603:10b6:408:290::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Wed, 6 Nov
 2024 20:18:08 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%5]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 20:18:08 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, ankur.a.arora@oracle.com,
        efault@gmx.de, sshegde@linux.ibm.com, boris.ostrovsky@oracle.com
Subject: [PATCH v2 2/6] rcu: rename PREEMPT_AUTO to PREEMPT_LAZY
Date: Wed,  6 Nov 2024 12:17:54 -0800
Message-Id: <20241106201758.428310-3-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241106201758.428310-1-ankur.a.arora@oracle.com>
References: <20241106201758.428310-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0014.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::19) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|LV3PR10MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: f840e65e-a4b3-4b45-917a-08dcfea020d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Io88v4Fc9h4OdOKsWQaT2SLIfDph0ZVGeSTIiPkCoQAYo3ZU5SrzXsqAtOua?=
 =?us-ascii?Q?74SHei8u5qnQQuWUfq1jQuytve+EkNlF8EFoI7s2Zy4RDWRlAhflvGH0QVL0?=
 =?us-ascii?Q?1lbu17XaDBgSvFASTVHrDNW2aQxyeFWyEUWmUuDcHJpD+iKajAWY5kqkJ/xH?=
 =?us-ascii?Q?Xvr8Px2wkpZDVbwHrSaqxcug/iJvY7sUtNafjJfnf9BFnsG4fvHpvOTQ9T66?=
 =?us-ascii?Q?KPTpQlmfKOqGrYfXsAetUliaBZUF/O5ENGRrtLbunLPcHbM9cRGm9QiCBMHr?=
 =?us-ascii?Q?9rgmcBLSbcGFXc+S7N2A2CDYk7qq37AlNkv/xuRjuYXd1VyrC7Ai0KuN6NNq?=
 =?us-ascii?Q?2CjcqzjPExmBLqbbK2LVizc/QocBynbipGkC2IXhlsj4wTG4R2+29D3P9f2p?=
 =?us-ascii?Q?r1UpIcHW83m+tYZKV5UKFpAQAS1L4W+5yqjoyKL7xWVjaXzJDV9TzA/MglDk?=
 =?us-ascii?Q?3uQFpCnXn/BF6RjGPC6SJvtMXD1e674zyXNA6M0GeQRccUJKUWA2VvXrFzbY?=
 =?us-ascii?Q?aB8XXTobdD9DynJ1BhE7Nzo/JpNC8RU2ItjCGWMDkTOC+U7n3m/s5TQrZaZF?=
 =?us-ascii?Q?CaP0yDgbWi0rT/7rRrtfucBlb53tRdnDHTlURGPznh6KMuVU7/Ze++kfQ3FC?=
 =?us-ascii?Q?uwrZtrjNGdCeE7rZuzBArKTRENwttTvpfx7YqYtbc7jAYTovMw0izhuEeypE?=
 =?us-ascii?Q?WwzMXaaRv1WOsgNvPjag1NEsfM0DwqcTYS0MDCMszGCLSZ1A5WVK2UR6tykQ?=
 =?us-ascii?Q?onJ3t9gsOfBh1CQZgjszbHX9NhNuCs5B3WqN04zRRyJKFQOlYD6UAwmbs6nd?=
 =?us-ascii?Q?gElZaT4vpcCylHpI2wQ+MEVG/oK32l8pNDOKsmQFejCWg1LvPTFZsit4q5gK?=
 =?us-ascii?Q?MaItAnRhvIsmPEdcBV33HVS0+g36klFyHUY2wTo611T0Q0K22AE2LgdnvtmO?=
 =?us-ascii?Q?QT2dmC+6MojcGWvjRLU3T3GTmbSSvmW3lPikNitWn8FIGpyvOyfy9iNLZBpP?=
 =?us-ascii?Q?VjDxTrk6QcWeATpAu/nX/ZVH5KL5wo0nGot3xoldCHI404sTmtYaP8uIR/Nj?=
 =?us-ascii?Q?XR06ua4+6R77YeC+QvHkoFLSncXoIj2lvXyzevGNn09O83ZY0gEKwZXSYY9P?=
 =?us-ascii?Q?L14E9+6n7MlmIXkDfxkRKO1E08++EeF2VuhjngwJkjQhOGGBTBt8Lgky+ZiK?=
 =?us-ascii?Q?nWv+lN6DpUq7CEwjSdxu6rela31BsZ9Ytqsds42WESiZgIk0xm+6ZwHOOcob?=
 =?us-ascii?Q?jTtXRvcW/oYSusQTaAzWRS11bI/BNUtwkypKeJSeBxjEuq+oKCrZeDO5jOql?=
 =?us-ascii?Q?w+SDLIc/mlyTB12NzBWHL3az?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IjZ6ImuPAcXFMMnDWy8tA9f2ddw63zSpO7+HiCQe1xli6nthX40C7scZPaE4?=
 =?us-ascii?Q?K2chutGTZc9HA5vRzjPakkIYqOIdSBBF5i35EUOpBg7sLNxezXx54R/2u3rC?=
 =?us-ascii?Q?QX2JMWQ9FguaYdMpHNFS8mykCJdpsTrknG46SA2eAT1fpGAjRUtgShmYFyEA?=
 =?us-ascii?Q?dbZD6MVPgYh03UXovwl4PozEdufvh4OfvSt4kLILihbdqe1oq/yakj4iOhtM?=
 =?us-ascii?Q?8C9qMBnD63Ptt3odUELgO9EAf4tYkUtrF9Sdc5cVAO/wTfpB4g0O3Syuneko?=
 =?us-ascii?Q?2QtSt5RoMb/wF0zt/Pm1xo6fdOAA8GjrhHGyDtiH36qCjsX5nlHPk/mhLe8C?=
 =?us-ascii?Q?G76bHhpTZ3AmKUk4YO1ONvXA3K0IteD4BE8r+t9sHpKTj1w0KYVJQQ2magOq?=
 =?us-ascii?Q?z50HJVy63pCA2NQJTW4ijW8xTWpfmcG6GALhGUdtqjkLUv+K2E5nKhwSpNap?=
 =?us-ascii?Q?NAwchifKqDRKYnnC+BVASUsfDqUKf5eWiMyRvlkYF1em7cLY3rOyIbxMVBXn?=
 =?us-ascii?Q?UQxZ/EMSFsO/3MBEPfrJhSad64HEhuU17xJFlVjDBM7TJR1EdMZOEAit0TkD?=
 =?us-ascii?Q?RnOa/2yrss6T08l3RXybmemTUJOt2g+FaHz8ZlyXPdWZlDZ8tXk+gZqYKlng?=
 =?us-ascii?Q?R4B7nhQ0x7Q5cDZKt7/6Q9uHxUZEdOOdMFBlK+eKu/d51BttN5eIZji3hWfu?=
 =?us-ascii?Q?9vmKyYBvmzeKtWg5xW0QAWgZWU16k+9LNDnk425SqMeZnALF4LkzhByKLDwZ?=
 =?us-ascii?Q?POejiN/bH3JKJORVXgRuBrivtYMlCDGGUd9odYkxvcikkn+3ZVY9tKP9qXyP?=
 =?us-ascii?Q?5ZIvEE5rLuP5DQj9lqCv0awsdc3tYvmyxYSKP2V2InVp2dIgRTh04CHj3bnx?=
 =?us-ascii?Q?CsTLQ/P0vSDv6P4jdfpD8vsClalyQ8CIEo9qru6LtgBPCqNtM3S8nOQ29Nwp?=
 =?us-ascii?Q?RG5aaDr2tqfO4rFFbShEZHGlEKRpV6DFqOisCa+G1XvYse27mHxbc11g8Pos?=
 =?us-ascii?Q?4VUXMP6GzTZNAFItpd4VJug/7scDJcdVCLDfz0AU3gmLDkf0ENldB9feRK2Q?=
 =?us-ascii?Q?8GSFSDgOSRyz4JAZmjana2JXi4DJ70JPtRdh1fSSZROvE4Z8+AMu1/GWufNq?=
 =?us-ascii?Q?PTwCnBOasO4tVtha8Ub6Q0HLPcqkUMBbUYsEf9j52r2trSPNiiYdSlh5+75a?=
 =?us-ascii?Q?z0y4i04Q8i9Jvj+rgEtYcMBTqLGGcfFzWqLYmKOg/hlVjb0GvOno/U2p0sFs?=
 =?us-ascii?Q?aR2dtkSOx63l/+VCSOk6eYsjkPB8qgKthDeKJZcF3CKSlkTMIyZ/8ILrpn1t?=
 =?us-ascii?Q?7JIlOvquK/7lsW4DrG1r6YSKnqnCtCTB9JjD0umnwkF5ktwSmFLlR/J1pebL?=
 =?us-ascii?Q?+otb08fwd+riAaBIY8PbDnBs7RhbcqNmNWsg0If25vyJfW6dsl5V2tYqFthN?=
 =?us-ascii?Q?D8sG6fyuJfwIrrrhviSrYLyTIZIKL3yZlvvQzSUqk69aQjlu+TcFCDGsLT4s?=
 =?us-ascii?Q?D2HQBKJJ9NopUNFGKf5H4XgLvXdauxGtvfE25vhI+wWLPTDbMqZ9hS46ebo7?=
 =?us-ascii?Q?/PAPsF0MOfzKDa1HCEm1sZ0jan7KDKZ6nvvcSu+Qyq+pjYq/s/IENvrquwVa?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WrApzOkz7zyJFxVWEjbcIhBt2joVJOOZjAzzBIgMxT1R75PZsd9085bl1ujEEtzW2ckIpGz2rD+c1bsWmmwpgPbzNy0cVElKB0l09AUW/sc2kKCc+sN4KDP2eYuYZbURilKMIcQrdQYE+xrX59MfIOFpoVUvRV/dQDYrFgkfAfc5hqyJguzYO32t3SJTi/5LNTJ7A6Q4r1gNhx+PqRlYVrsHjkn7S9Le/3BRxCAWzwMZt5cRkPasEAMjcqyBQlRc5dd3j4MiiHKEKtfrCLMV0dywAw9ZO6/PB+QxC/aCs0xr9GP+3v3gSkayhtLF0OsunTEIOgmoB2raMKpq74bGRqeCUKi/hV3pE6hoU3UmAEn6N74VfT5YkdX9GKrdOePN/FAjqgQrp+k1rwKMbGQU4WoJjL16lXwfRnM0dTvWszX/PttTKdXFQIAetM+qeyXCVpfT+Iem00Q9bL88ogXnGPuDlm74Jf97Xx7ncI8czp3LZG2qHQuQl4+F8M3pHubugO9Ocsl4Ln3INhp9MNFoZmMkDFxSh6ugMyzMS81B3OJ2cMzimdt4gZtWXiz0AMcDO6SlGEWB6tJ5HNTTTn7pIQc1Z5MfTp06egbzZu3c8oU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f840e65e-a4b3-4b45-917a-08dcfea020d7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 20:18:08.0945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uP6Ui0LowfxnYtagJ1beT84Vw7oaPVR3f/zOorIjGHqgFksxFQWu7gtfbJZAFcWzHKlODGvchA3B00pxyQMj7pAxelaH3Q7/wROlFhbBBK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8107
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_13,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411060155
X-Proofpoint-GUID: qjwR09DyXRiIl79IKzC0JIVmmy-Pf1Lj
X-Proofpoint-ORIG-GUID: qjwR09DyXRiIl79IKzC0JIVmmy-Pf1Lj

Replace mentions of PREEMPT_AUTO with PREEMPT_LAZY.

Also, since PREMPT_LAZY implies PREEMPTION, we can just reduce the
TASKS_RCU selection criteria from:

  NEED_TASKS_RCU && (PREEMPTION || PREEMPT_AUTO)
to:
  NEED_TASKS_RCU && PREEMPTION

CC: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/srcutiny.h |  2 +-
 kernel/rcu/Kconfig       |  2 +-
 kernel/rcu/srcutiny.c    | 14 +++++++-------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 4d96bbdb45f0..1635c5e2662f 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -64,7 +64,7 @@ static inline int __srcu_read_lock(struct srcu_struct *ssp)
 {
 	int idx;
 
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	idx = ((READ_ONCE(ssp->srcu_idx) + 1) & 0x2) >> 1;
 	WRITE_ONCE(ssp->srcu_lock_nesting[idx], READ_ONCE(ssp->srcu_lock_nesting[idx]) + 1);
 	preempt_enable();
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 3e079de0f5b4..5a7ff5e1cdcb 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -91,7 +91,7 @@ config NEED_TASKS_RCU
 
 config TASKS_RCU
 	bool
-	default NEED_TASKS_RCU && (PREEMPTION || PREEMPT_AUTO)
+	default NEED_TASKS_RCU && PREEMPTION
 	select IRQ_WORK
 
 config FORCE_TASKS_RUDE_RCU
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 549c03336ee9..8a662d911abd 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -98,7 +98,7 @@ void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
 {
 	int newval;
 
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	newval = READ_ONCE(ssp->srcu_lock_nesting[idx]) - 1;
 	WRITE_ONCE(ssp->srcu_lock_nesting[idx], newval);
 	preempt_enable();
@@ -120,7 +120,7 @@ void srcu_drive_gp(struct work_struct *wp)
 	struct srcu_struct *ssp;
 
 	ssp = container_of(wp, struct srcu_struct, srcu_work);
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	if (ssp->srcu_gp_running || ULONG_CMP_GE(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max))) {
 		return; /* Already running or nothing to do. */
 		preempt_enable();
@@ -138,7 +138,7 @@ void srcu_drive_gp(struct work_struct *wp)
 	WRITE_ONCE(ssp->srcu_gp_waiting, true);  /* srcu_read_unlock() wakes! */
 	preempt_enable();
 	swait_event_exclusive(ssp->srcu_wq, !READ_ONCE(ssp->srcu_lock_nesting[idx]));
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	WRITE_ONCE(ssp->srcu_gp_waiting, false); /* srcu_read_unlock() cheap. */
 	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
 	preempt_enable();
@@ -159,7 +159,7 @@ void srcu_drive_gp(struct work_struct *wp)
 	 * at interrupt level, but the ->srcu_gp_running checks will
 	 * straighten that out.
 	 */
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	WRITE_ONCE(ssp->srcu_gp_running, false);
 	idx = ULONG_CMP_LT(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max));
 	preempt_enable();
@@ -172,7 +172,7 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
 {
 	unsigned long cookie;
 
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	cookie = get_state_synchronize_srcu(ssp);
 	if (ULONG_CMP_GE(READ_ONCE(ssp->srcu_idx_max), cookie)) {
 		preempt_enable();
@@ -199,7 +199,7 @@ void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 
 	rhp->func = func;
 	rhp->next = NULL;
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	local_irq_save(flags);
 	*ssp->srcu_cb_tail = rhp;
 	ssp->srcu_cb_tail = &rhp->next;
@@ -261,7 +261,7 @@ unsigned long start_poll_synchronize_srcu(struct srcu_struct *ssp)
 {
 	unsigned long ret;
 
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	ret = get_state_synchronize_srcu(ssp);
 	srcu_gp_start_if_needed(ssp);
 	preempt_enable();
-- 
2.43.5


