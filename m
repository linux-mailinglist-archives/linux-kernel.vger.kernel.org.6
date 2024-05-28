Return-Path: <linux-kernel+bounces-191546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0968D10E9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DBFA1C20FFA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B088F70;
	Tue, 28 May 2024 00:36:04 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABD9623
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856562; cv=fail; b=O8V8hPUkWxe71DfHEBJSjsP3s236+Op/nmZl7DZdiOvsALWAor+8JJqDnadHVgHeQBi8vRijPAELWJLS2Owm/A56VA/PIGVWEQ3YU5UGaKYFzNVhq27XG7lYPd9JoElfkqNWgcTqA/K9NXZC6S1bfO8FvNfk0eYVV0KKOZtoxEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856562; c=relaxed/simple;
	bh=oCkvccfuhqU8HvRSsFfhTH7bARyEHdlyjW2pbmRe9o8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=brppCpWgP6o87y0Pkb+SV/yUa2Vkh83Kc+RBUDZmssLvF5bFK9hbouvorXnJ/iVcTkMMz1AFJx6Ef6AHV4RhxsWOa9hQcbmq3norfgtXtBDQGqtoZ7+aYXVmO1m3o9NI62lpCv8b05Pir6Bc/BmiHPamJoML7+5AfXPms4X3k34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RH4gjb001286;
	Tue, 28 May 2024 00:35:28 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:message-?=
 =?UTF-8?Q?id:mime-version:subject:to;_s=3Dcorp-2023-11-20;_bh=3Df3Y7F7vta?=
 =?UTF-8?Q?Bt88mu/o//epFnZhlhCJ4ZgYFjcWvT+Aq0=3D;_b=3DimxwLjD7EMFNnW7kygaf?=
 =?UTF-8?Q?VgPO4MWEbonE6l7JhOXQanF1hESRHViX0o5F6giVZoibHYA+_YGMsvnL6bavkux?=
 =?UTF-8?Q?C98/J+EvkTIbRWJ00u30tgH1njFhYN3Z9fCdjQlp+Er2alX5nJ9e6r_5FD74Iel?=
 =?UTF-8?Q?TsyCk53E3kCWqKTe0+kJws1rNd+DN0PfYcnu9/SAZ4PW7GnISmb9UYRKNsvt_LM?=
 =?UTF-8?Q?jOpHLwtoAPqjnj30WcyPK9ZbLbJQjek9r9+Prc5G8agYV1NQork6njInfbcE49H?=
 =?UTF-8?Q?0D+_37TSpvbJP6ZpT37K0nGAOZan87tPqKsGw0AOPt4pwQebZp0z+VCtFZQNshh?=
 =?UTF-8?Q?ZThVhShau_WQ=3D=3D_?=
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g9k8vq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:35:28 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RME2Oh016172;
	Tue, 28 May 2024 00:35:27 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc55vtf67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:35:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KggOaCoCl2YlKtxmFxapeGW1GAPLO4AFO1AMDuwBjZNUBvfY4cvvmY0qZRcY7R3QShHnnj/2vnrhZpBoNviulPtGAHMZZZ4X/hslKpTB81BB8jbYJ1BoI/wut3MpfDQpLjTL29NzNcJx99Ts4IO7UPMi6DAL3kX3NyX5WlNVC+pUbp+UVKwPRc+/MIAVHrqCY2RO5BnQt2SeHttzPk+6FcKiQS5P8Ga0ctBJNez/gVPeEDaCWJMFc1rXONhGcV4SdI7iOdMCvqMAg6etz1nmPrHufNzHb3awuJk35tipDtYy2ppA/rp9bC1LE/pJ3zWMRmd5a57ghTggxNd+JHMwYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3Y7F7vtaBt88mu/o//epFnZhlhCJ4ZgYFjcWvT+Aq0=;
 b=mTyHJuiEO/N21JBEdoyHAdvJXITMnNx02r9l9+dpxhKM7JJXE2vifEMsdpnQScbZvEC/35x/fMzbPPV5J666lJbaMO7bshXS0FFKhKZy+oSU/fTh0SaY8qMvSo6mji/NUfY4de0dCqyfo1rq06YFGL3G14TSGIWt5gyljd9ADDNvLsyfDoAi+2vfoTK6rMei6HY8lvEJHhg3T/URGCP0OBkDK51oljAHEjb3/Lacm0J890a4FNg2JjtaFYcOe4bRJ5bXKDG1tzeC+UDaBkLEEnbk0DJe//pRmnDmo0agF8LEUmY+nxXUokxUeC1zIiNSwXiWsM8L/7RYlpc7JiOzXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3Y7F7vtaBt88mu/o//epFnZhlhCJ4ZgYFjcWvT+Aq0=;
 b=WKhGXJTy4RCENpJ5MHzXmPlfR+PXcclbtpA7xN6yKs0ud56dRtcGQXtIX1QFeV787kcVzoQZuw5sTxA4IGXaGjeiXp6kvM/m4yVPoVMdWC/3Xxvr36688X91qJPzXkdONqoFCK8PXboy4g3EbHtM/H3UwD1ZXtq4T+ETcndO+Ig=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW4PR10MB6510.namprd10.prod.outlook.com (2603:10b6:303:224::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 00:35:23 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:35:23 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v2 00/35] PREEMPT_AUTO: support lazy rescheduling
Date: Mon, 27 May 2024 17:34:46 -0700
Message-Id: <20240528003521.979836-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::18) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW4PR10MB6510:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d1ec267-2aca-41cc-3b5e-08dc7eae0faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?wOPbwhUGvHnBuRrqH2FsM/WfDS72GKyVMLi9YoHUj8pSLh04pED/bbyXG44K?=
 =?us-ascii?Q?zZhDKzSPjX50Tz3qVa7gxRCaJen0XVJnG86UzaEwxflfOrsantLhXCHqG6X8?=
 =?us-ascii?Q?hZ5yX58vt6CMRx98vQ7tD9SsoozaMtWL4dTguOvmTBShHW0dwWZzaOwpHieW?=
 =?us-ascii?Q?RkxpBHPyDgPmO/anY1NJDlHeZH8Som/TlHuzY0FLZ8tZPVnyeriVUnYRyzFl?=
 =?us-ascii?Q?WyIscDDfuM6ZbwwPmc/LMMqOYWwZRP4Ln4xysSqDaikJcaOfenWfp6OPlG1f?=
 =?us-ascii?Q?/swoKgT2DCq/1iC6MC0lZcWBw0e4NJT4laGbk6Hxtb30+lvM+A6gbn1W0RfZ?=
 =?us-ascii?Q?rthqxiqPctAw5oVcJj2djYgWtawOmoiVkUSUW8VDrPBTGhXXGC1xxvcAx2WN?=
 =?us-ascii?Q?TsKZELqoDMbrDdo4yEgzOOU4Td+RHwfEGwMZVG97uaKPKf9rRBZjK4RO4FuH?=
 =?us-ascii?Q?qXE0We26HK0Gu6M5Vs0ip7TpP10O7sbfP8UKwgrz3oh9BT88ugGt4EhFTptg?=
 =?us-ascii?Q?f/oOdkALmorQgY0T4+yauh4qJ+GYgrRxnUzFigZ+SZQkDLYJMxPa6K8jNPFa?=
 =?us-ascii?Q?ru+Ql8RxDJ0+HhP0nYy0jUVPof9CljENwmBOBcRO0bQtU4bDnsJj7blyr/tM?=
 =?us-ascii?Q?Ri0saj9C7k48iK1IyXJGclRHD7hVsbdJCYP+B6BtuoRx2gP49V7SSIbjhZjh?=
 =?us-ascii?Q?Zfz0PLwk+Dad40NaO8nnxcLsjPAJlgqa4Tbjqc9PqEEOC1gW8onPKThzB3e+?=
 =?us-ascii?Q?cQ0Du9Vg4EsAumEXcZFUgWnyXQjm7oinfVMOjP9Oluacpt9nYUAfMl2oNyoA?=
 =?us-ascii?Q?VcipR41BQfJiK+o8HTyIMUrVeSz0UCxm+f1ZzlDYl5oCjnlzZDGqbtJIhCZY?=
 =?us-ascii?Q?n4Puu7mVDpqQKLVALrAHEm6K8mVXpvRSfQm8wdhic3sjdTlLMYcQ/yRQfc6L?=
 =?us-ascii?Q?66DSJTjFAjfClbkpTByGwByhrjugiI2YY4iyxxmS71FZWsFbBqzfmws0EIaz?=
 =?us-ascii?Q?b4ubN7H8C/1pNbGY/YxO+AqvUVU52sm/HmZYd1zJA3p3FLo0r4yzzcG/Gxcu?=
 =?us-ascii?Q?mbiYFjToZqhPfC1o1Nq1Ggg1RX0KNPxUluBq7u1+uOh9vTN4FsIniuF5I+vy?=
 =?us-ascii?Q?6ne+vwcMHzyN8TE06siPO6P2OCDauafb72rwMaHapQVp/wo+FJOcVrFa8rGg?=
 =?us-ascii?Q?fLfR+PN5hqdodYwn56mRm+AjV6YqprVMlDAzUJJwVnOZu8TUjhElJ8Qn0co?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0ir5Tb74NXdJqX4p7gi9XEEW7BdjQIPBZJCIArUQl3VrvcFlPmZzLIkgiOA5?=
 =?us-ascii?Q?DwvPqBZRkrhWTsYwLUq5DsxeL4ySptHfRzZJE+ZJNhbs92wrttNLBPnmlCGT?=
 =?us-ascii?Q?U23IWMMY4YBpozHrWkwkbFkAcuL+zpaS1261Zvsx7yGj8a8snx9r5wikmn5H?=
 =?us-ascii?Q?iweBICw7RuruftS9AZNJb4SV6wx9bNLwQJn6sx7TfuBMzufayzmnZNHC9GMs?=
 =?us-ascii?Q?0Qe0i/Kq6Qxxh1Et2UoQqVfUC1jDLJFh903CC7WRCP/eXu1nSEaF+GnIb90+?=
 =?us-ascii?Q?ZfbpqD16TwSNpLSv0WnupIN3OY1okI0fDq7+HsOYZyfhYp4ilxHBUoSHwURW?=
 =?us-ascii?Q?yudyax4vqswWl+46f4kLk7YmrbmxscsBbKL6He0N/f5pfmJs+rl5yg4S1uHu?=
 =?us-ascii?Q?QIYKB+gYVWrmelR0boFCGSWC5N/eVTJodTHtUKcsTmI07TVvhXYzXkKnQCSn?=
 =?us-ascii?Q?oLtE+ZGx14C9mFE13lv9h64YRWHzVJSBLxIzcLb1rGUaqeIyYYP/zOS/GW1M?=
 =?us-ascii?Q?4vKSinMGi2aqjydDbVaxV1nbNLyGB8AE0xPAwgtWEA+Xe6M2dl3ZqJ/nSGJq?=
 =?us-ascii?Q?bGV6snogXZu4U2cDVUjsFzoycxfjlbatjUZmTXbchKMq+prllJyMuMI+485f?=
 =?us-ascii?Q?QkvrBFv2twTYa+eAkZxJlF5crWpSoHCxfBnYiSPWxkIdW7ZeqOckddgao3QJ?=
 =?us-ascii?Q?4IG9r3Y0nEJiNTzCU9OZ9tzJesFOZ8NVHaHpeOi812Btt7Zn0Gp5gSVrOPjm?=
 =?us-ascii?Q?Xb8Rzs/mfxXK1aZiZvKbEMjNCj9V4Yib6oKuWZ4rsysJvclg7V1AEDSvujTV?=
 =?us-ascii?Q?ZLD7p20yK0y0rKBNHz/jV0tHLIm8sDeO3ikzsR01iDVD8AGRBZSAW54Z4feG?=
 =?us-ascii?Q?UZf4y3ekBAW7DM5w0nYHu3XqafxNui8qZlOaXQXygG0WkK0/FrWLypWgv5O3?=
 =?us-ascii?Q?t1ysQwKMyPCUwPfh5/x2pmXwn94p78EkbccLGZ+05Jo8kZDOhLO97OyePamB?=
 =?us-ascii?Q?T7nqu6fpxjHA37OFXZA6fzUYOSp1UX6BdL9xI+gUKI1d84kBhpcWUjsYoJnC?=
 =?us-ascii?Q?Cy4cWzj3mrTqwvJMVSBykpxjAZzGtxdzxhveUCMIUnZa+m6O7AS/0TH5L3gZ?=
 =?us-ascii?Q?I0COAjvCuKx8MvzsU36KUrLpCe/yuoI2cFgvnqrB6ZBRTkokogovd+0CxIFw?=
 =?us-ascii?Q?udB+jgEo5mhMfmjTi0MPPwDxZ724HROqdqUx7a0KQX8GWqvnMejpKQ7Z8JWi?=
 =?us-ascii?Q?CFQT2F+E/9TDTu84CSo4fkbpLwnJqihn8q7doECnWkNQz3BSX9Lr8B6g/bhJ?=
 =?us-ascii?Q?5uECzdxOt6tW7Fy318Oe0NC8fPCA3E1urNc6YGvOhTCHIMBcPlPnAwqOYYpO?=
 =?us-ascii?Q?yEW/ivd4GZMXVkqeet+19Jeh32nfWisgAep3Gm1n+r57812WuNwRa2zHxman?=
 =?us-ascii?Q?jWRa7wKJWa9+vkRWD06nwWva1cWoXhsC/NyU4htczAprq4TsXk7fVnfKbcQD?=
 =?us-ascii?Q?3w7TsiJBxTyMZiizRHnTbSzEibcl8QrfnvuNralpI/lwrU74VqH/HOxiiSTR?=
 =?us-ascii?Q?/zepeb5uxl+pLWI6Klx/z/5Ejbe3nEVuThcd3kElQsvWvD7EsLYyVZk2mAVQ?=
 =?us-ascii?Q?SQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	voyQ5BcsYAZj9qVM1RU+OnzDkJ2ZNH0hTq82JMKfRiuNwxHoffd1OXZbifqz1YtVQaT6VH1SRj5YNnEoUud2hdht0MTaMwQWhrm08HT0CL+7+F2k6EmGlELXw1qJmOQIHrNRtG1DyyS07nd0VSt6F1CqTRsavUSZHQIYdpmiOtHOv+3Qp7aixR5uKmmUdz/dv03L1jk6xmSqdwv1vGh6+SpjQ4gyi39+oUpdFa91UmCrjGAkOSQH9q9e8RvhI0dDgQJAAnc15hlxarazTbGm+zaHyUtAFgnbCjzFxEKM9KMbV8TKEVvU0pMkGCZbNGfLfVKo90QnoBNBMLz+Zedg0g5KzqsjtmnRVMnsEVdcWyH1Gl7jwDmkHquAWWkM/G6+ZvuppgDBBATWXz3CLxDfLlBARKeA4mvRzTD+0YEx6wLfI0RH2Mf6pt+U+XoVXW8m1MiDUUtAwk0n/PEeqqp0Szf/BZGgKzRmihaYEE3p6bsDZNmG0oN2zYlJ3e1DlzPNSnG3UWAEOuJZn5qVNazvkTut9py36RQ5qjpK9CSXJYuvzWysM9eexp9kt5DcPzs3g3NO7tO00p4Ct1APrcMeXs+aQoazxsM8hvVcQPnfN04=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1ec267-2aca-41cc-3b5e-08dc7eae0faf
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:35:23.3935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dV8yj/BywYxe/qGS9O/h3ESO7NN8D2q/r6RDf+Qv9A6ywoUNmQDkb+SPQsayNdwjTz4qk5TVwylc0swijCEflV+tBregw8d8KlFL2BDaABc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6510
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280003
X-Proofpoint-GUID: WgRIWoUafPWOeK8ZTZUGmRRXoFLVLnxc
X-Proofpoint-ORIG-GUID: WgRIWoUafPWOeK8ZTZUGmRRXoFLVLnxc

Hi,

This series adds a new scheduling model PREEMPT_AUTO, which like
PREEMPT_DYNAMIC allows dynamic switching between a none/voluntary/full
preemption model. Unlike, PREEMPT_DYNAMIC, it doesn't depend
on explicit preemption points for the voluntary models.

The series is based on Thomas' original proposal which he outlined
in [1], [2] and in his PoC [3].

v2 mostly reworks v1, with one of the main changes having less
noisy need-resched-lazy related interfaces.
More details in the changelog below.

The v1 of the series is at [4] and the RFC at [5].

Design
==

PREEMPT_AUTO works by always enabling CONFIG_PREEMPTION (and thus
PREEMPT_COUNT). This means that the scheduler can always safely
preempt. (This is identical to CONFIG_PREEMPT.)

Having that, the next step is to make the rescheduling policy dependent
on the chosen scheduling model. Currently, the scheduler uses a single
need-resched bit (TIF_NEED_RESCHED) which it uses to state that a
reschedule is needed.
PREEMPT_AUTO extends this by adding an additional need-resched bit
(TIF_NEED_RESCHED_LAZY) which, with TIF_NEED_RESCHED now allows the
scheduler to express two kinds of rescheduling intent: schedule at
the earliest opportunity (TIF_NEED_RESCHED), or express a need for
rescheduling while allowing the task on the runqueue to run to
timeslice completion (TIF_NEED_RESCHED_LAZY).

The scheduler decides which need-resched bits are chosen based on
the preemption model in use:

	       TIF_NEED_RESCHED        TIF_NEED_RESCHED_LAZY

none		never   		always [*]
voluntary       higher sched class	other tasks [*]
full 		always                  never

[*] some details elided.

The last part of the puzzle is, when does preemption happen, or
alternately stated, when are the need-resched bits checked:

                 exit-to-user    ret-to-kernel    preempt_count()

NEED_RESCHED_LAZY     Y               N                N
NEED_RESCHED          Y               Y                Y

Using NEED_RESCHED_LAZY allows for run-to-completion semantics when
none/voluntary preemption policies are in effect. And eager semantics
under full preemption.

In addition, since this is driven purely by the scheduler (not
depending on cond_resched() placement and the like), there is enough
flexibility in the scheduler to cope with edge cases -- ex. a kernel
task not relinquishing CPU under NEED_RESCHED_LAZY can be handled by
simply upgrading to a full NEED_RESCHED which can use more coercive
instruments like resched IPI to induce a context-switch.

Performance
==
The performance in the basic tests (perf bench sched messaging, kernbench,
cyclictest) matches or improves what we see under PREEMPT_DYNAMIC.
(See patches 
  "sched: support preempt=none under PREEMPT_AUTO"
  "sched: support preempt=full under PREEMPT_AUTO"
  "sched: handle preempt=voluntary under PREEMPT_AUTO")

For a macro test, a colleague in Oracle's Exadata team tried two
OLTP benchmarks (on a 5.4.17 based Oracle kernel, with the v1 series
backported.)

In both tests the data was cached on remote nodes (cells), and the
database nodes (compute) served client queries, with clients being
local in the first test and remote in the second.

Compute node: Oracle E5, dual socket AMD EPYC 9J14, KVM guest (380 CPUs)
Cells (11 nodes): Oracle E5, dual socket AMD EPYC 9334, 128 CPUs


				  PREEMPT_VOLUNTARY                        PREEMPT_AUTO
				                                        (preempt=voluntary)          
                              ==============================      =============================
                      clients  throughput    cpu-usage            throughput     cpu-usage         Gain
                               (tx/min)    (utime %/stime %)      (tx/min)    (utime %/stime %)
		      -------  ----------  -----------------      ----------  -----------------   -------
				                                            

  OLTP                  384     9,315,653     25/ 6                9,253,252       25/ 6            -0.7%
  benchmark	       1536    13,177,565     50/10               13,657,306       50/10            +3.6%
 (local clients)       3456    14,063,017     63/12               14,179,706       64/12            +0.8%


  OLTP                   96     8,973,985     17/ 2                8,924,926       17/ 2            -0.5%
  benchmark	        384    22,577,254     60/ 8               22,211,419       59/ 8            -1.6%
 (remote clients,      2304    25,882,857     82/11               25,536,100       82/11            -1.3%
  90/10 RW ratio)


(Both sets of tests have a fair amount of NW traffic since the query
tables etc are cached on the cells. Additionally, the first set,
given the local clients, stress the scheduler a bit more than the
second.)

The comparative performance for both the tests is fairly close,
more or less within a margin of error.

Raghu KT also tested v1 on an AMD Milan (2 node, 256 cpu,  512GB RAM):

"
 a) Base kernel (6.7),
 b) v1, PREEMPT_AUTO, preempt=voluntary
 c) v1, PREEMPT_DYNAMIC, preempt=voluntary
 d) v1, PREEMPT_AUTO=y, preempt=voluntary, PREEMPT_RCU = y
 
 Workloads I tested and their %gain,
                    case b           case c       case d
 NAS                +2.7%              +1.9%         +2.1%
 Hashjoin,          +0.0%              +0.0%         +0.0%
 Graph500,          -6.0%              +0.0%         +0.0%
 XSBench            +1.7%              +0.0%         +1.2%
 
 (Note about the Graph500 numbers at [8].)
 
 Did kernbench etc test from Mel's mmtests suite also. Did not notice
 much difference.
"

One case where there is a significant performance drop is on powerpc,
seen running hackbench on a 320 core system (a test on a smaller system is
fine.) In theory there's no reason for this to only happen on powerpc
since most of the code is common, but I haven't been able to reproduce
it on x86 so far.

All in all, I think the tests above show that this scheduling model has legs.
However, the none/voluntary models under PREEMPT_AUTO are conceptually
different enough from the current none/voluntary models that there
likely are workloads where performance would be subpar. That needs more
extensive testing to figure out the weak points.


Series layout
==

Patches 1,2 
 "sched/core: Move preempt_model_*() helpers from sched.h to preempt.h"
 "sched/core: Drop spinlocks on contention iff kernel is preemptible"
condition spin_needbreak() on the dynamic preempt_model_*().
Not really required but a useful bugfix for PREEMPT_DYNAMIC and PREEMPT_AUTO.

Patch 3
  "sched: make test_*_tsk_thread_flag() return bool"
is a minor cleanup.

Patch 4,
  "preempt: introduce CONFIG_PREEMPT_AUTO"
introduces the new scheduling model.

Patch 5-7,
 "thread_info: selector for TIF_NEED_RESCHED[_LAZY]"
 "thread_info: define __tif_need_resched(resched_t)"
 "sched: define *_tsk_need_resched_lazy() helpers"

introduce new thread_info/task helper interfaces or make changes to
pre-existing ones that will be used in the rest of the series.

Patches 8-11,
  "entry: handle lazy rescheduling at user-exit"
  "entry/kvm: handle lazy rescheduling at guest-entry"
  "entry: irqentry_exit only preempts for TIF_NEED_RESCHED"
  "sched: __schedule_loop() doesn't need to check for need_resched_lazy()"

make changes/document the rescheduling points.

Patches 12-13,
  "sched: separate PREEMPT_DYNAMIC config logic"
  "sched: allow runtime config for PREEMPT_AUTO"

reuse the PREEMPT_DYNAMIC runtime configuration logic.

Patch 14-18,

  "rcu: limit PREEMPT_RCU to full preemption under PREEMPT_AUTO"
  "rcu: fix header guard for rcu_all_qs()"
  "preempt,rcu: warn on PREEMPT_RCU=n, preempt=full"
  "rcu: handle quiescent states for PREEMPT_RCU=n, PREEMPT_COUNT=y"
  "rcu: force context-switch for PREEMPT_RCU=n, PREEMPT_COUNT=y"

add changes needed for RCU.

Patch 19-20,
  "x86/thread_info: define TIF_NEED_RESCHED_LAZY"
  "powerpc: add support for PREEMPT_AUTO"

adds x86, powerpc support. 

Patches 21-24,
  "sched: prepare for lazy rescheduling in resched_curr()"
  "sched: default preemption policy for PREEMPT_AUTO"
  "sched: handle idle preemption for PREEMPT_AUTO"
  "sched: schedule eagerly in resched_cpu()"

are preparatory patches for adding PREEMPT_AUTO. Among other things
they add the default need-resched policy for !PREEMPT_AUTO,
PREEMPT_AUTO, and the idle task.

Patches 25-26,
  "sched/fair: refactor update_curr(), entity_tick()",
  "sched/fair: handle tick expiry under lazy preemption"

handle the 'hog' problem, where a kernel task does not voluntarily
schedule out.

And, finally patches 27-29,
  "sched: support preempt=none under PREEMPT_AUTO"
  "sched: support preempt=full under PREEMPT_AUTO"
  "sched: handle preempt=voluntary under PREEMPT_AUTO"

add support for the three preemption models.

Patch 30-33,
  "sched: latency warn for TIF_NEED_RESCHED_LAZY",
  "tracing: support lazy resched",
  "Documentation: tracing: add TIF_NEED_RESCHED_LAZY",
  "osnoise: handle quiescent states for PREEMPT_RCU=n, PREEMPTION=y"

handles remaining bits and pieces to do with TIF_NEED_RESCHED_LAZY.

And, finally patches 34-35

  "kconfig: decompose ARCH_NO_PREEMPT"
  "arch: decompose ARCH_NO_PREEMPT"

decompose ARCH_NO_PREEMPT which might make it easier to support
CONFIG_PREEMPTION on some architectures.


Changelog
==
v2: rebased to v6.9, addreses review comments, folds some other patches.

 - the lazy interfaces are less noisy now: the current interfaces stay
   unchanged so non-scheduler code doesn't need to change.
   This also means that the lazy preemption becomes a scheduler detail
   which works well with the core idea of lazy scheduling.
   (Mark Rutland, Thomas Gleixner)

 - preempt=none model now respects the leftmost deadline (Juri Lelli)
 - Add need-resched flag combination state in tracing headers (Steven Rostedt)
 - Decompose ARCH_NO_PREEMPT
 - Changes for RCU (and TASKS_RCU) will go in separately [6]

 - spin_needbreak() should be conditioned on preempt_model_*() at
   runtime (patches from Sean Christopherson [7])
 - powerpc support from Shrikanth Hegde

RFC:
 - Addresses review comments and is generally a more focused
   version of the RFC.
 - Lots of code reorganization.
 - Bugfixes all over.
 - need_resched() now only checks for TIF_NEED_RESCHED instead
   of TIF_NEED_RESCHED|TIF_NEED_RESCHED_LAZY.
 - set_nr_if_polling() now does not check for TIF_NEED_RESCHED_LAZY.
 - Tighten idle related checks.
 - RCU changes to force context-switches when a quiescent state is
   urgently needed.
 - Does not break live-patching anymore

Also at: github.com/terminus/linux preempt-v2

Please review.

Thanks
Ankur

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Raghavendra K T <raghavendra.kt@amd.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>

[1] https://lore.kernel.org/lkml/87cyyfxd4k.ffs@tglx/
[2] https://lore.kernel.org/lkml/87led2wdj0.ffs@tglx/
[3] https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
[4] https://lore.kernel.org/lkml/20240213055554.1802415-1-ankur.a.arora@oracle.com/
[5] https://lore.kernel.org/lkml/20231107215742.363031-1-ankur.a.arora@oracle.com/
[6] https://lore.kernel.org/lkml/20240507093530.3043-1-urezki@gmail.com/
[7] https://lore.kernel.org/lkml/20240312193911.1796717-1-seanjc@google.com/
[8] https://lore.kernel.org/lkml/af122806-8325-4302-991f-9c0dc1857bfe@amd.com/
[9] https://lore.kernel.org/lkml/17cc54c4-2e75-4964-9155-84db081ce209@linux.ibm.com/

Ankur Arora (32):
  sched: make test_*_tsk_thread_flag() return bool
  preempt: introduce CONFIG_PREEMPT_AUTO
  thread_info: selector for TIF_NEED_RESCHED[_LAZY]
  thread_info: define __tif_need_resched(resched_t)
  sched: define *_tsk_need_resched_lazy() helpers
  entry: handle lazy rescheduling at user-exit
  entry/kvm: handle lazy rescheduling at guest-entry
  entry: irqentry_exit only preempts for TIF_NEED_RESCHED
  sched: __schedule_loop() doesn't need to check for need_resched_lazy()
  sched: separate PREEMPT_DYNAMIC config logic
  sched: allow runtime config for PREEMPT_AUTO
  rcu: limit PREEMPT_RCU to full preemption under PREEMPT_AUTO
  rcu: fix header guard for rcu_all_qs()
  preempt,rcu: warn on PREEMPT_RCU=n, preempt=full
  rcu: handle quiescent states for PREEMPT_RCU=n, PREEMPT_COUNT=y
  rcu: force context-switch for PREEMPT_RCU=n, PREEMPT_COUNT=y
  x86/thread_info: define TIF_NEED_RESCHED_LAZY
  sched: prepare for lazy rescheduling in resched_curr()
  sched: default preemption policy for PREEMPT_AUTO
  sched: handle idle preemption for PREEMPT_AUTO
  sched: schedule eagerly in resched_cpu()
  sched/fair: refactor update_curr(), entity_tick()
  sched/fair: handle tick expiry under lazy preemption
  sched: support preempt=none under PREEMPT_AUTO
  sched: support preempt=full under PREEMPT_AUTO
  sched: handle preempt=voluntary under PREEMPT_AUTO
  sched: latency warn for TIF_NEED_RESCHED_LAZY
  tracing: support lazy resched
  Documentation: tracing: add TIF_NEED_RESCHED_LAZY
  osnoise: handle quiescent states for PREEMPT_RCU=n, PREEMPTION=y
  kconfig: decompose ARCH_NO_PREEMPT
  arch: decompose ARCH_NO_PREEMPT

Sean Christopherson (2):
  sched/core: Move preempt_model_*() helpers from sched.h to preempt.h
  sched/core: Drop spinlocks on contention iff kernel is preemptible

Shrikanth Hegde (1):
  powerpc: add support for PREEMPT_AUTO

 .../admin-guide/kernel-parameters.txt         |   5 +-
 Documentation/trace/ftrace.rst                |   6 +-
 arch/Kconfig                                  |   7 +
 arch/alpha/Kconfig                            |   3 +-
 arch/hexagon/Kconfig                          |   3 +-
 arch/m68k/Kconfig                             |   3 +-
 arch/powerpc/Kconfig                          |   1 +
 arch/powerpc/include/asm/thread_info.h        |   5 +-
 arch/powerpc/kernel/interrupt.c               |   5 +-
 arch/um/Kconfig                               |   3 +-
 arch/x86/Kconfig                              |   1 +
 arch/x86/include/asm/thread_info.h            |   6 +-
 include/linux/entry-common.h                  |   2 +-
 include/linux/entry-kvm.h                     |   2 +-
 include/linux/preempt.h                       |  43 ++-
 include/linux/rcutree.h                       |   2 +-
 include/linux/sched.h                         | 101 +++---
 include/linux/spinlock.h                      |  14 +-
 include/linux/thread_info.h                   |  71 +++-
 include/linux/trace_events.h                  |   6 +-
 init/Makefile                                 |   1 +
 kernel/Kconfig.preempt                        |  37 ++-
 kernel/entry/common.c                         |  16 +-
 kernel/entry/kvm.c                            |   4 +-
 kernel/rcu/Kconfig                            |   2 +-
 kernel/rcu/tree.c                             |  13 +-
 kernel/rcu/tree_plugin.h                      |  11 +-
 kernel/sched/core.c                           | 311 ++++++++++++------
 kernel/sched/deadline.c                       |   9 +-
 kernel/sched/debug.c                          |  13 +-
 kernel/sched/fair.c                           |  56 ++--
 kernel/sched/rt.c                             |   6 +-
 kernel/sched/sched.h                          |  27 +-
 kernel/trace/trace.c                          |  30 +-
 kernel/trace/trace_osnoise.c                  |  22 +-
 kernel/trace/trace_output.c                   |  16 +-
 36 files changed, 598 insertions(+), 265 deletions(-)

-- 
2.31.1


