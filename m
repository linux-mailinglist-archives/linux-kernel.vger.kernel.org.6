Return-Path: <linux-kernel+bounces-248172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400F792D916
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63AFC1C20ABE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7CC19883C;
	Wed, 10 Jul 2024 19:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ege1EWxD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WcDOuWbV"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE86199256
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720639438; cv=fail; b=YgoB9KUiCQD5GqpyGp+c5KbvsH8VmXHu05IZHxBJ8sR9w+c8ypJBQUMsZX7LQh7EcsY7Y7DlqqQLq1efLl8CF3WPvPJvh+Z1ymNm3D+h/ZaLikxsad9AfumhMXoBOQyCjlPBPZe38NrrrcSwATS4r9pT5Xg1I0/nrzzrYJ19Bd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720639438; c=relaxed/simple;
	bh=QNO4lRIBFUpkoNIP3WQBpiQGDirrsXGNO0KSdsQ6SK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FiLjQohJ3z8ElMVYWlWdjn/XN2paeH1oCqU0sWwYfHdkvc2ptSi+CAzpD9jhLK4f1QhlO3ZrSIWtITUWdFTm4yMoHlQvgtCQeYfDBsoZDzezwA0hDkQT/Crvg9nW/W59ebbtJ621YpBAvSs+jpR7iXRmv2HrcYR23GsUz4tGQxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ege1EWxD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WcDOuWbV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AFndMq017517;
	Wed, 10 Jul 2024 19:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=zX443Iheh2qc0Sqk+4vF3PSlITJU3/wSXCmEz+kPPYI=; b=
	ege1EWxDg8iyAF8C6IZMFroQpXLzn+xUA5EzhKog5ti3+NAADsji1zG8BrOAfyJy
	hmWjYEyzNl7vEEPGic/rGVTotHpQPnrTljtB8RlFJtVZvqfS5z9RC6JNJ5ozuOJ4
	MURJQyt3LH8kglI57ZkV0WyyZK/fdNtK5dXW0hDLemF30M3OpVpsvWOoh0YoHxd7
	H5PxJqbTjKvkECLqnPh4OFrZcXZcaD152hH9kD73LEXuqgVfPzqIaNtNsb1BDhzG
	yj/IYamLC+8PH0mrWhtgi85HBcLe9pUXom2ahaVPe+z3jkqbukCEqjWeKuSzOD9u
	snsaPhUlUBWFMcgn3o2ucg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wybr4dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46AIlfXx010839;
	Wed, 10 Jul 2024 19:23:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vv4s3w9-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ld80O+onTBfY87Z+OWQCwTcz3mCbvJPcr1RB9EBNk3HzbcjgTV5MY6xx30XReG4f/nlZfiunHYSerNyM2FV/ipF4k4CWSLj9Qc8j2JVmRMHCvernm4HtoycqdqjvhW+zewATPqVjyt+KbmOo5EExhojVR+F9cgjtW5xq2CfhkP/Q2f1HdnENh0BEwC6Yz6RZrRzfj1X6fkX2gwF9L6/U5D3bDqwPvOwKQTyfY53n3lHbri+dWzfVC2flMglN86v/Skw+2vA4si4mMSdw1UovQqi9kfbrgqSTiFmOeI8SB+pE7jBbD7FXfCLuIQ0R1z0qFNL7TnYeAAyIK4kt+HvIzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zX443Iheh2qc0Sqk+4vF3PSlITJU3/wSXCmEz+kPPYI=;
 b=EbCs5QGOuBG3HR5xgdk2k5FeSlgxMVojZioVAPpT0zaiSOO2TicMYrFx1MgmhqbMZe4KGCgLVZmsTpifQeFlrqA4avvNC3Pe2kyCbvpD3+dcCrz1A+BVuYqJWswXeN42qWtNS4P64cL+rgq2G1TwF/LMpttM6YL53FjjDvZpTfC8QsOtK0SQWYut2lctv1gsJH9mnKvDnR7WcZqHfeInAyohgXT4MWApqjeMyR/kbNBbStBEg54I/JiqplHhavnJXuPvv+06ysGTHjRdb2NLelIyWHAr+qY5rg3dbqTsQxvg2cD3x/kHla+jPOAAc1l0AIq9tXaoVYJnQDcNr3GRog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zX443Iheh2qc0Sqk+4vF3PSlITJU3/wSXCmEz+kPPYI=;
 b=WcDOuWbVITf/hwKEOMm+Pk/ZPIMGHdwL/UfmHkWTzDLCj7Y+scWgOKeG5JkE3d3z/e8CY1JWvZRzeSmWPkCtYtjTeUN9ha8+jYTXXB4Acbnet1zGAq+ArKV6uC1ViBlfZEH+gBCECzhAojuFTst891K53sBNWNtXUEJiJuVysno=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH7PR10MB6106.namprd10.prod.outlook.com (2603:10b6:510:1fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 19:23:42 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 19:23:42 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v4 21/21] mm/mmap: Drop incorrect comment from vms_gather_munmap_vmas()
Date: Wed, 10 Jul 2024 15:22:50 -0400
Message-ID: <20240710192250.4114783-22-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
References: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::21) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH7PR10MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b0bcbfd-c7f9-4457-bc15-08dca115cf00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ru25plP2nNE+eCboteehqD9svpaDf10LpS2OKod/Z4rBojvRo+k1tI8CVleB?=
 =?us-ascii?Q?kjlfcor8CO4vR05r+4fu/8/jn83Kb6PntLkZMSvL78HGqCWBne/0oVO618Q9?=
 =?us-ascii?Q?5SNCV0q2QamFSlt8WQhsuu5FQVFQKaeH1NxUd96BhfkOU2AwPHnPsAZoXOnr?=
 =?us-ascii?Q?Dxam6VqrbMIV15bmPKku47+wb/MRSz16aSotoVeyMN1zjpjc8UywqipEMPKv?=
 =?us-ascii?Q?4pXmvt0jfNuW3g1COLa6ISKwob44KeqF/QRwipn62MoNsnvfy+ARQWwHKN/f?=
 =?us-ascii?Q?Wwp8+iSxJnjBlkIbdH9vha8y8IKb2EVGzKOfSXXCe/nxpkqUgHMrprI/SMhL?=
 =?us-ascii?Q?I9MA124TWLeI7XPrSUgtHGXKgsCYpHs60EBEAxhoIfr3uBDZC41PuL6v5LMs?=
 =?us-ascii?Q?T+uaLdjUE1pkLwpiQQJu9Gl0f8OsenzBGUaZXyeTOIKYzU/Uqpa91Hm4seVW?=
 =?us-ascii?Q?d/j1UV16Ld9rZZZ6YA/7gkGKfbuT1+fMtJxP4W1YhNgnlUGwnANd3yHBtr1h?=
 =?us-ascii?Q?OJOoK+/i4G5jmoflfdvp15PQxRnhxdF7UeDmkhm2MaqqwLmzf28okJdUBkto?=
 =?us-ascii?Q?wRVh6rou+vpQN/NFKKr3fiEI1w9AR9ZcTkTjyOApzQIsziVPGQFnImJDJMjc?=
 =?us-ascii?Q?HMA3AyIOJ2xMoOBJxhMlQg8gMQXA1RcQcBxARZDjJpmU9ZRyee83lit9qMRc?=
 =?us-ascii?Q?r5z+P+prz+pSqz/lOFkTRrQZeqScPAbYwK1luBgBoxQ+UDLaBMGN7Z+Wi9qv?=
 =?us-ascii?Q?5uNAvt6aNclHb5X/qNjjBXd/aUGpl4cx0QJHWgxQUFQ0CkLOA7Dsr0BPeTtb?=
 =?us-ascii?Q?yh+h+q+5sVEnxzbebI7FcgR3DgTHeu3iFnS2zSKPaNEmLX8cVHsgt5I9XpKf?=
 =?us-ascii?Q?S1668T/YGElc1GzgRX5YzCZ6ITMn2eyIwQCd9R70E18m/YkmDzaoi3ZR1MyT?=
 =?us-ascii?Q?VgWqq2Nol9PutpzOe0H2/E8027vgnHmlDmnt8wOYgpFva30zs19Do0FyIbI+?=
 =?us-ascii?Q?s+fS6DKriR4kHMEsGPYUGjG9riqmgnH87UxDabq/zc/GA6F/JBADXEi47JAo?=
 =?us-ascii?Q?WAHC9afZ+pVJQnNtok9zJJ/Unn7rIBpjRma2xed1Jwv+w/iUPQYKwcVNUs6q?=
 =?us-ascii?Q?6yxpN+4jW/0grQrDfGSBjV/DAE2wX3zopfErvJ0Ie681GIpm/Y9Jzg1CS8pa?=
 =?us-ascii?Q?sjhNWrPdvmdM4AmZeMiuiKjVNdHrWjPVm+GiPJ/B3st7Z8GABBt204Qr34+f?=
 =?us-ascii?Q?+kS7EB6CxRZ+VRAMWeIwMi+gKYN/ihZtWY312AIyNkiHJLpvSFgNbAj66cKp?=
 =?us-ascii?Q?HhErg+VlLhNkwztpnLEJ7ExkoM++U0+D9yHFQaq08Jr29w=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?g0cP+ZgzV4pQZvQ2LQPyFOz5E9FuHdQ25qGsgDz9jrH4cITbapEh8fMv92P6?=
 =?us-ascii?Q?bQMYJzAjNJPdePD2ZRIFlRS5ekTH2FXYBFbRMSnCf7Lm9AILBCo3Z1kqK5VV?=
 =?us-ascii?Q?SBFvGI1R820kQSkCV/CvNbnL6HGtOgRQEgaFeX6AS/vvA2ANoneU8f6MsLVf?=
 =?us-ascii?Q?DUJy6jwKCl3FXA2KhoTNmMaACp3cxtn3ZGIoPwer3FyS8hzBA2D3+97QFVdz?=
 =?us-ascii?Q?A+B1TeaHWr/C3OC/JurRtAq++ZKa198b/QBC5E8knvftT1drSZqvYDttC9j/?=
 =?us-ascii?Q?8rqYy5pp8wSxrMsFDZqzv8JuUZXodUrf3rBd2m0SBXwhTUV3cyLHCNNfQob1?=
 =?us-ascii?Q?1754fNX2xG4p+TOtATP8eg1kBERNCnXFNgX0kQ34I7Hm+m7EjkVxouqpl9jG?=
 =?us-ascii?Q?I4TEQBWB6hv2eBzs4dqw8g3Ccxu9T9pdtFmCK2MzGRL9IJQJQVXgrNVPHAFK?=
 =?us-ascii?Q?wI/ZuPuvxb6u0XZh8nvh3ky7/EZrm45S35c1VMA+AHM+UcakFKsZIn6yahuo?=
 =?us-ascii?Q?63zAdAwDLybLcG3QvSot2UQ1K3l2dJgWOzGnI63IaMOy5G9e3QXZ2KMclcOt?=
 =?us-ascii?Q?EE/DRrlEL2CKAsZKcH3QYYwjEFIS8+N6yY2xXo3eBc9zFr0KLKcYZ/DgjHZ/?=
 =?us-ascii?Q?C38Lwf0jQsQsmpBx5UGWVWjHrEbbEw9Mi0kVEU5RWTkyJrkcLfCk9/SzOKSj?=
 =?us-ascii?Q?U3fY+jggtVC6CKntfev8+k89XPbH1ec91wu7wen5MGGhuYFsPLCcVxEdNCvK?=
 =?us-ascii?Q?a8MQ6nlnE96XnAzmFHpHfV3UtdxCB98dGMxof/2hgx1Jl/Qb49hHa9Ga4pER?=
 =?us-ascii?Q?Xh54yiNOtwMgeWfAc1GjDfA5Y1AuqeinbtDxcQH//eYJRiIVo/z5C1Myz8xM?=
 =?us-ascii?Q?aPWQM/Qp9+Tz1hOM8EC5DKu5s87ZxfJ73FPGKGFdOawYlRtJkBVtXzPuf+5P?=
 =?us-ascii?Q?Xb2TalI71lc95M3bJzAe8fwjB6bLpvy00d7l9DMyUl9Tiyq0xQYIG4ML4JM0?=
 =?us-ascii?Q?pdHfaXrGv/v3ANlj5grIEcioavwFHWTghUUwqhAT9ni9JS0mbyB/J8xH3q2g?=
 =?us-ascii?Q?OZHD6JxE2FvNOI6PV/Enh9SGmEIaya6o52P/EO6erHhYNqoI4mr+t2w4RkWp?=
 =?us-ascii?Q?OC1YvHDz8HKsTxV+rwGV4YqAo/IzH+qMdsULUtJhF9rYbQog5AhxH8094bBZ?=
 =?us-ascii?Q?+JBoDixQ0S9Cey/L1DTITmM8o9X2sCox/FZeZDUFJNNLd0hQ2HB+DhHkoH0m?=
 =?us-ascii?Q?k0vm5HFTYOcoN3k0pv0QaLNctbetr8kOBt0/kI7PI/D95wgohJbV1OiWoRWK?=
 =?us-ascii?Q?J1kA2jY5p/WfZZ0AL5MnDoVzA+mNLnSrxRqvG1ZAic2yPhwVfKs4bN0JDCje?=
 =?us-ascii?Q?+y9vrBC0WPncYLyf8AEqucxUvq7asvSJQzTJ2/SdV9mj35YNlB3zyTl4jbH7?=
 =?us-ascii?Q?qH9wXznB/ChBPPRE0HUH7whGw/T4v1gIAnC5xmvIcojbAM4nJgUBnuuEtLE8?=
 =?us-ascii?Q?SxVAl43b2Qw5hvd14f6RFXjkdyLPwkMIgUkiH2/m1ii5/bBNgsT8NHX1/riS?=
 =?us-ascii?Q?CmgT90U1pRSoABf8P0yI/kmRW1ysCvdlWjC8uKeKrI2jx/KpwNHwxzrxTt0M?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7WH9TQ5GiK6zlXnb0aQgfEeOLA332LnT7rG5sAEgDdiMVV0TzNLMI7TPH0BPNv7lKFE63q203k5DNXJ9ZpV6jhVdJ6vX2ImpZ2ed9JLcvQqNGkIwLop9Je0w62WU4/eHN3T7JE0QP+y4Y2/xDvfBAKVkiUJncoF3VXo1NsBPS+ovnvWUrqM0KP85cXCw9osx2HPDgNF8K9uu6BOC56fDR+/y307qKa4On8cziam2oJUBybVNrN2uFJat47rmbLAh0YLTZAszKedLcxxjMsgztS8QVVGj3VTjsBTs+OZTVCmQ+T0nuABC+wTGsJOTVB3bWHj1Mf9VRsVnt50IbaB9vieYCdRi8yb3XNbPli/TWFG4vP+rFzQAZzK/aciyvdIjDUBtdW9ULUB6bDq5kBHgMFaFyM0c5WjsPPsW+xdr/iHgE/H9T31W5Q+3ERz6GSZu1tOArvjf60E7mCf39BAIzl1uPMDADIYbx4vKaATCilyf6Ut4cwyTY+MINvobRGKB85mCWdyc5QIlUfSsW77nYh9heEmFnbosT49drataLPIYrIVSYQxWkt9zrRnPtkb4XA/NpDHpjO0OT5NK1v+n8Elw2tBkhQ4np/8Rtv5i3lA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0bcbfd-c7f9-4457-bc15-08dca115cf00
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:23:41.9972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RV/cUp6xPxdLePf4bxO9ZA/p7pUoPeP1G6iZ668rPMJCgb/hK8Z5WaRJidU4ULnjfpdoZetVnrIKU6tyS0v8iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6106
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_14,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407100137
X-Proofpoint-GUID: j-UxD2jZbeyyCIx3Sd6hr7dn8wYMM8JW
X-Proofpoint-ORIG-GUID: j-UxD2jZbeyyCIx3Sd6hr7dn8wYMM8JW

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The comment has been outdated since 6b73cff239e52 ("mm: change munmap
splitting order and move_vma()").  The move_vma() was altered to fix the
fragile state of the accounting since then.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 7a440e7da55a..ca3872e5fbd8 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2675,13 +2675,8 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 
 	/*
 	 * If we need to split any vma, do it now to save pain later.
-	 *
-	 * Note: mremap's move_vma VM_ACCOUNT handling assumes a partially
-	 * unmapped vm_area_struct will remain in use: so lower split_vma
-	 * places tmp vma above, and higher split_vma places tmp vma below.
+	 * Does it split the first one?
 	 */
-
-	/* Does it split the first one? */
 	if (vms->start > vms->vma->vm_start) {
 
 		/*
-- 
2.43.0


