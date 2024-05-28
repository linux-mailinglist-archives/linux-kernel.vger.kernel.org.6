Return-Path: <linux-kernel+bounces-191561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AE58D10F9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1B642822B6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEB01429A;
	Tue, 28 May 2024 00:36:41 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B476482F6
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856600; cv=fail; b=cpy3abNmru7ORZ41d/BwZQ5FFd8Sg1Y4k5O5QECy+A4hL8wzxzu9f8HuChYSDILNU1cY+X1DLxhVcFsPzesmDf8YbLPDRzp/QtHk72eCotinIdJ7xOqGU1WzVAO0mcZtSgxaoj2sOaMyduxYIZVS7o6bwHSvL9VLgcECpZZ+kEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856600; c=relaxed/simple;
	bh=yqdt4hIJs1uXQkYnvLy5ypMNTqD0hp2ov1BD/aET6QM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V+QU5lf+SdRJsVu9ZhMLrLiySlgdRxqPWTHrwB7/Dzasp3e7gZhVdGjs46X5iicGJW2cv3ZuIVFsxJRlaxpCqhv9IMGEp7d7+voWrq7TcWVRAXcK226xVZOIsZcpyqMBXtnNyLSdIklHkMDr3FKtymkCJQrUDnKTv9xrfejx+e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RFZPKn001283;
	Tue, 28 May 2024 00:36:22 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DN5W3IwXMsgTjnY+/93SRBp8U++X+375qYOBRi0xevkc=3D;_b?=
 =?UTF-8?Q?=3DCoUUis/9ND+MvmmjqAEsw7a/HeSaWyrYVpfuqXsJLPAR3cCT39YE73xd6IlY?=
 =?UTF-8?Q?lgh3fUDA_AljmOSH9YyKhkA6/pzG/mkLnuDyrmQNv9L1hcDbeFK9xEIKc2/0KaJ?=
 =?UTF-8?Q?OXIqdpow6pnQca_4Y4jDLKkD0Rz+j5cR4faPBXfWas4SBWny66uxYIJF86WLUIx?=
 =?UTF-8?Q?DvlRrNeM3XSwfHIKMw7X_fI3RaFwnMzkCYJnB2n/HCdaGojPvrfOsKet+IF1ETU?=
 =?UTF-8?Q?xoXBqIUcijAB3jcERPGmqIboje_qyrplYG+Hx4jLFiAw7EGml98KJBHfADn9+Cp?=
 =?UTF-8?Q?J6cljfVNCPlg+ZQ0v+e5zfw3+T/Jx1gz_Rg=3D=3D_?=
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8p7k5th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RLp7lF036807;
	Tue, 28 May 2024 00:36:20 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50w8ckx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYV95ubV+W8Wyd4LPf0NsPkArLwgrpjbsnctdahNkbr2jx9pGs4E3vR7wOQszu7gjrsMI007ocGZ6+bfQrNMZza5VcUy9AG9a7IjPbYv2RstkjMbL08LrMvTuQwWtKpsxOWATcO6cxZN4yOKfkDnNtecN13n41VCNtnFlmU2nlFK4Wb5fGV/vgCUU+MQHldlpbf/voHgQxX+po90R+Rre2etqMj7ZH/2/WND+R+v3FN6GYZ2hfKQaqC6ZdTIQAYMR+198mErx5iRDKKo5w7+uy85VguSSt9KoBPYvCtN8HIhYW0Buv6EUROKYqQt+5ikBKqvT8d5WtRW5Jg6ZOO0Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5W3IwXMsgTjnY+/93SRBp8U++X+375qYOBRi0xevkc=;
 b=VPrtbZFkMDbd6wdBaxiIOC7jBRZWrHYKjaPzHjW/mNQ6lCv+nGGaGf6+wnhQ7PabAsz0UegOcv3JD0F1kzPb1JKbOsbAf1MRiHRjK6cmoD02Almiof+F5AJF8xK5FCAF0KZ/gaUKBvamaIwgwvsebNJGui1FYz6MstFxRQcatZK8WVf1LA0/zf6rjHSSWoeQReLkNL7YoJIG9uFKB0BZDAsxqEdTiOQAJuFCi7Ho4//aFPsnubgI0XxAIK2Lctfp7nbLHSiVyi0PKIZuuzuDpgmLzeiQiAgWIuYwGFVBTBAhq4fYxRRKkVCmz6xLp4JD+UIqMZay+v4rDf5Ohr51Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5W3IwXMsgTjnY+/93SRBp8U++X+375qYOBRi0xevkc=;
 b=NJ+fQPWeIShozskjTbjrHdco6I6aGK3HH8+VlbATIkfi044fwRAlujFiZfyNX/0kJ495Qf/6AU3+ZzopCDuoRbYDDvVQQpy/R9GtA6rZszl7rvu89ruELA93ejM5VQI6eQOCpabCygevNyxApPbmuzQ06wOzt5Ps0AZ6SBMyxEo=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS7PR10MB7177.namprd10.prod.outlook.com (2603:10b6:8:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 00:36:17 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:36:17 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v2 17/35] rcu: handle quiescent states for PREEMPT_RCU=n, PREEMPT_COUNT=y
Date: Mon, 27 May 2024 17:35:03 -0700
Message-Id: <20240528003521.979836-18-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0176.namprd04.prod.outlook.com
 (2603:10b6:303:85::31) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS7PR10MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: f04ad2ae-02df-4fd9-1775-08dc7eae2fd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+NVvKPqqhUTfkMPwGnrhWjnc4yfPXSdUTlBUnwdL2zkhoYFd3vA0zFyBIZbG?=
 =?us-ascii?Q?UlFXGooQqIkRT/DKUB4pq4Z5Ld9XjMddjmDwkVq8U9FtuL7nvxFQiMrdmnS9?=
 =?us-ascii?Q?XMC8kBAT6s5Aw2Srf7JwUj9lVfz0VvFfEVkaOadfFP1VvTHojvCFu2q8udWB?=
 =?us-ascii?Q?c6o0QawsDq2uF1exibj1l6VDtIZFBKfBCGYgZNGhJkLBHKfwMSNCWFTJPMcp?=
 =?us-ascii?Q?Ew29sY9Ddq9yjXDhI92eo/VwHYr/9Xjg2RYu3H0n/1d0s0E8o4XyDcE/bfk8?=
 =?us-ascii?Q?QLCbNIoHL2H2m4lW+aloIvNOomjgixGAoBueSepwKjNYS10i2zTzAcVoTasa?=
 =?us-ascii?Q?cPKnxCrwdVNtcC4e6ZFPPQaFaPARY/cb6Kvw1nyFZ0yq9Mg5pR0TA/iIuuMB?=
 =?us-ascii?Q?Jb7UOgWTon0EQYINqNxd6CeL2+8qt1dwoxL2bxApmR8wcVmpVOF3NGqXw5SG?=
 =?us-ascii?Q?Ko4EXXsHgYWqMK7ZchcSX8fSSbGutPwUvqh9zibuIqJ+GdwOMUYSGsceBbcu?=
 =?us-ascii?Q?DCRO420pa37X6pAzhLISV6Dcbq3dtanhRVAWWFKzB47MOGIO+V4gFSf/k4gN?=
 =?us-ascii?Q?SgPbXiTnX+7MofFXzHIdh8Uoh/UMe6iOkHEL48DWEqM8Lobx0x0Ykek1BHFo?=
 =?us-ascii?Q?6BXyinqKgcgz1Io6RceyZlLsLLQCAI3yBUy3PFDZ1iN5Esff/IVlTkNdbysv?=
 =?us-ascii?Q?I/A/3pLnFaYuA72Y1nDez4N3HpNZ8c7JWzpidHUQHDxhO6D6o+SFF7Slm+uJ?=
 =?us-ascii?Q?yIu/P7oKrRIIhxa6QFTY4AkHhZo76TmLEtloNeU4ndAMpZcPber3EI8HrHYI?=
 =?us-ascii?Q?WXv8HPku2YCwnrehJqlLKUQipFWGEIX1zOb/8UJcLiJx4cC3MoeKX98wTFXE?=
 =?us-ascii?Q?NxPQWX4fYoUlFiHVT8crfRqpmiUeHNusrTlVmzfXq3xjffuEuR8zu2OIxEZd?=
 =?us-ascii?Q?/T7emQ1sSy9koJFYKjpRtvZHJT2a+yQ5S5ZqkDbVMg1Siz3LNGquQxaVphU1?=
 =?us-ascii?Q?IPd6EqdbQcblPuGxtMdbCcpEzgmGVaP+8zkSUyeUlCuqX2m4+bQmapuWl/1v?=
 =?us-ascii?Q?ULJF+i+oZ3i/c/LH1a0LblLh0sXNmR7ZC6P3xCaxu97turL7dYiB8r+k2neI?=
 =?us-ascii?Q?bvwKYwcF4J7CXQ3+MJODkfFjppxLZwNuNNQPLz1exz69SjCEl4RTHrIM4t8J?=
 =?us-ascii?Q?vcB1GtNkPLDxB/9UqwV9e25ZttRJeQqgA0lgvV4Q99QQ2GfKZSAsGEWtbKI5?=
 =?us-ascii?Q?W5W16g95zjnbm72V7AdWhBtuhtdr3eBCfCsvbpnknA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6/OOxDYF1k50x0etymIZ9WChbWZSTiOXjx4+Ttya0BwldsmzoqAI5/XO6CfD?=
 =?us-ascii?Q?Yp93ZrTS7Xyx2Nbov72cFHB2wAnx6DoO/VUZrJl9BA9g//DUBWDO/KGMmcwz?=
 =?us-ascii?Q?6OfjegbHppO+gHYWuYPJXhfaE+cPI7rm4bEEOozC5yhbPJL0r5U7e4R1JJc/?=
 =?us-ascii?Q?Lxz1qJoOH34PMe/7NG3fPOkqkl+52fZfKFZk2ZRKo8troK6peWvkPo6WPK3j?=
 =?us-ascii?Q?r9lIkDpgSlVufnqp/yp5/aYyEUUukF1uprWWCBEeOUfUg21YQMGWe2F2Za8H?=
 =?us-ascii?Q?qb3AAx4zEBGMu+ah8AbRJFN4b8QfwmNIdxEhD5VrlZCfw1DaQwYqt+cxCobR?=
 =?us-ascii?Q?AHY1wopgyLIi8C36L5vubi/v4C4k7xJIak1324PS2IjZbGFlmxWDDALbeO9m?=
 =?us-ascii?Q?nUz5Ld9Wb+cGY57Vga2kpE7Oqs7FnCmditIwzSGLIJ3ZoNPqyUjHDO9zO2uA?=
 =?us-ascii?Q?6uDN88GErdaI3zbC52hI3mj2sf6p6G9I265dP7vLxox/l8o6osBirudRSRJZ?=
 =?us-ascii?Q?Hhghs4QSYxu3uOKOz2qvQoZ3WTCIZaNBG0ec3bdF+oXVK5BHSDmZxfg/7QIg?=
 =?us-ascii?Q?QYsJ28Y/iQ1cM2qtbXKu6lgIQlP26F2fkoluYqcWUlJ5Zu9Az4ma9Tx8UrHT?=
 =?us-ascii?Q?R5sxXc3XFVrApNNE+/KjFZ7TNGQd13gCXhd4HicqCZTenS11StyJAOla0g+k?=
 =?us-ascii?Q?UKB2vQA1xqTw2r5CVd+Ie0jWz5vyBYkZSUHPUz6KKsgjNYOzuVvQnaO295a2?=
 =?us-ascii?Q?EkN1jKBA+qu/2iD87BoZnXPdpCIruOaTqFhlq9Ji7IIFfG8VESKqqYsLu6kL?=
 =?us-ascii?Q?54oc7v2p2pVnDMTikyfZuWGnYY4fam4/OXG5wXDQzvrcgs9vnyFPhhamuJxb?=
 =?us-ascii?Q?ADDHrctZVh1rUbiaMDU2PZ53MHLyyLOIt0OWny+f9FTr3kLjDeJYuTSHuKeV?=
 =?us-ascii?Q?y+5qGVnrs/JV2LTYdiHP5OwzhaNrQo7E+/HAY72zbJ/BDRA7UxX/a9Dd2Y06?=
 =?us-ascii?Q?l3drNiI9yve6h0W8j36DgsSKxJB5EbtggyLrdSfy51ssOQxF0ieAXrwy6t7d?=
 =?us-ascii?Q?v2LFQluHeOI7z4gJmg0ke8FCvLwitj9VHPrE/bWm4Z38oPXhZAT7RR3e1zST?=
 =?us-ascii?Q?C9mFo1mE+tugQbwWyfpjaEzmZhJ0HjGkq0/k8RdIivr0Wy5ZYKDLpG+zMn1x?=
 =?us-ascii?Q?uO7ElY7Pbv94qSzSdXkPIpzWYvNpH9zIWjqO5txyIiz9JKWWCDiZ2BAshvzm?=
 =?us-ascii?Q?3pxKlD8GbEuAm6R3K8eeRsAAggw7LLDBgwPVUJib2wvRk1fwOxIn2wLLH0gi?=
 =?us-ascii?Q?I/R+/VpEQWztaZH2fk2mNimydvIJQctCx2BlmOWrjt6tp7sGQ+lBOXrL/FO8?=
 =?us-ascii?Q?R7wy9QRHnWS8OcdwrJI1s7RGEvxX4k7leQ/4SKfZpHckR/kmcHInYVkHocme?=
 =?us-ascii?Q?3B56Haa0CHK9QvjYBvDWx+7/ceA5RyQcEqA9zzZXuflqee2zQSNt1jCK3F6Y?=
 =?us-ascii?Q?91sOCnVsaLc30sjmtidiBKH07rxSCivNIhHIUModhL1mvbv3nQR0CKcYqYo+?=
 =?us-ascii?Q?LLkWzdvXs3R2E7AkUIqiFk4ch59vpb0rTK+CSxoeD7VcLGpLKh1qZXixOirF?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yYFYGt4EBbxa4MqhB7beSW0whX7t9ONS73B6zs2wOrnK3i/p12DPwZUFT/NiT+/8o/jK1NKkJ31HJuc8XKLeLbYqsKJG9cSBGDMwTaBRNPzvSVZYL47Nw6mCUSNUtlSkTswyu2LYOakL7UQJV2VinqqqRFnfRI3FNVYVnbsJ4J+HHMeXBKtuUU6QlZo2e+SCZS4PDjcbruoXSkEsL8JwNV116kVFOyk8UXkfAktbHMu4tWg4CtelzbZUldyUaqWUtrqpqwEehf0mn3tDPYesAPYo+FOPffvw7hPBlqRTeCcdiolIcd2nf+CYRbAh7OXFgtHwXg7dqOaFtlPSg9mDk/sNvfHQ+vUOEi7nwWMTPzK/eg9yM1XH6PxXn3lZyHmYhUCg7+4IaV96LyHQgyPM+JyiPbDCMhr5OlwpN/UiOJOZOzpyMdpbieBDcwVUg4CVOcreGlZILb/DCzx0Gp+EkCv7rO3eB0epH/TDkbo6AD7T58BhNax8FauNNdCeIQrLz0bCblmV75vL4u/4EvoTAhJCgpD+LIQ/eso5wg0L0AA+jkoVHfzteE4lczmPvykSdNeID9B6nw3FmGwi1SAf6I4KmoFmRqnspviQBLzK2J0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f04ad2ae-02df-4fd9-1775-08dc7eae2fd0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:36:17.2564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgaOCnW9z3TM8q1q46BoYKvChmr364jL3VMJFqW9m+oZsutLA+OhLQNbpGt+XZVK+pNQv0RWGloIIPsKFvrlSAh8zKnB0Eum3bgdylCPDp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280003
X-Proofpoint-ORIG-GUID: Kk7od-FzMrHqDLI0kBykHnBNKVZRO618
X-Proofpoint-GUID: Kk7od-FzMrHqDLI0kBykHnBNKVZRO618

With PREEMPT_RCU=n, cond_resched() provides urgently needed quiescent
states for read-side critical sections via rcu_all_qs().
One reason why this was necessary: lacking preempt-count, the tick
handler has no way of knowing whether it is executing in a read-side
critical section or not.

With PREEMPT_AUTO=y, there can be configurations with (PREEMPT_COUNT=y,
PREEMPT_RCU=n). This means that cond_resched() is a stub which does
not provide for quiescent states via rcu_all_qs().

So, use the availability of preempt_count() to report quiescent states
in rcu_flavor_sched_clock_irq().

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/rcu/tree_plugin.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 36a8b5dbf5b5..741476c841a1 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -963,13 +963,16 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
  */
 static void rcu_flavor_sched_clock_irq(int user)
 {
-	if (user || rcu_is_cpu_rrupt_from_idle()) {
+	if (user || rcu_is_cpu_rrupt_from_idle() ||
+	    (IS_ENABLED(CONFIG_PREEMPT_COUNT) &&
+	     !(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)))) {
 
 		/*
 		 * Get here if this CPU took its interrupt from user
-		 * mode or from the idle loop, and if this is not a
-		 * nested interrupt.  In this case, the CPU is in
-		 * a quiescent state, so note it.
+		 * mode, from the idle loop without this being a nested
+		 * interrupt, or while not holding a preempt count.
+		 * In this case, the CPU is in a quiescent state, so note
+		 * it.
 		 *
 		 * No memory barrier is required here because rcu_qs()
 		 * references only CPU-local variables that other CPUs
-- 
2.31.1


