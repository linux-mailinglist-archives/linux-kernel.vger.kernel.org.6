Return-Path: <linux-kernel+bounces-242879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A335928E48
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 22:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6951F2557C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 20:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D44C13AD33;
	Fri,  5 Jul 2024 20:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hApXKNKa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B/rWUVZT"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9C61F61C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 20:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720211644; cv=fail; b=ac29fuXk/uAALz1AYcLLUlnJ8VRpUmyRJI+c5Adk+HHB6NV03rwU7p/E4BxdE8wT5/QVhm0diGuegZ0TX2BMn0XQOm012ha5q9yYCtwoSnXvvRKtaYj3Vx2YNvHjlJq6Z6+6vWiobDWhamuelKNAUMOKDdhK9N5Ci1j7ia87jDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720211644; c=relaxed/simple;
	bh=SmcGy6Lywvj0hWzIn1GvXbbMW4NQ/XJXiM622ZfkjFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gW6fl1Yx5fRs/W3V/s1V+hGXdDoxZxA9g3pKeKmf2IJ/xtKAyHSGpk7Fw1dvMdTTFv4a1oG8Gg64l4WQsDU5CoIjCg1cQXMVcNAYG/f64778UnFghqPjBAPHXlKAqD8EX7ABQiICxx8loavsLkDgGaZphp2xRlhz5zlvUKXyImE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hApXKNKa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B/rWUVZT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465K7XtX030297;
	Fri, 5 Jul 2024 20:33:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=0qMYG8lazQcx+MP
	7yrBK4hVcHkjfwnSyCie7c7SmmgI=; b=hApXKNKauT3htNVT1T3WJNEVbjuvr+Q
	TSKOtWbZ/kwDFTyeKgjMENN6OYwvb3pC55IvTZwNwkZgTnxetjcnYwObY4bUj+So
	u4y5lDLa9pDkbEAE/1B5tR9pQJ7UPzTFNClZ8HSmciNm9MRw5SLWTzeemXT8Ted6
	ngbRbLAwqHW/JB+XWLH+XGEzAhmK9mYWgr3KNksDXzgdnKrvZGNflBlgnShcmdbf
	PZCw4Nm4omCWNyy5CB3h8gXCLFseTfEaIZYKD8wDGLBQktXYPGAH7m4C9XwaDlii
	HNL/+mC2xxH/FI+r4St06g9uDKrg0ZZrWyMF2wjeeSZ6jpQgoWvIfPQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4029vsvd77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 20:33:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465J2khf010337;
	Fri, 5 Jul 2024 20:33:46 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qj3e89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 20:33:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+sdwzV9sI1oQtuQcY6+w9QC5UWmPLn8gv77QUdjvdLheoYN25Gp1jSC1JNl2q91cvv2MCFQuGv3CaCo6pxlFdwDOz3hj6bwUKaWX6n/GzLJ7mjMMIfCZfAM/sefxImq63N+T6+2IutPh01M09JfJJ1ZyEkxHsJhQeRBgLX1epcXF4GdletbVxFsay+m9IB3aMgfGnUXgwdKHByu+ONej6754W/bmfRWMU4ryYC2vkkv1PuXQrfpZ9NW2Pa5I21RQ3v6gvQSpq1hAhajr9Rao+BuneS5Zkkiu6iFdiVJ1qG47wvT0HiNZOnJHYJ/WQVhUEf0Pljb+W4+RekOjpDp2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qMYG8lazQcx+MP7yrBK4hVcHkjfwnSyCie7c7SmmgI=;
 b=LvGIN+lDSSR6f832NpyW6Ia1VTAB78EQoqkMo4LCJ/LUcG7hs7+qo/obsTm/L7aE/3kfi2OdWWNExS3rB1KtYwqy3Z0VhUU9TCuiJLfqLQ1R5HR6nfyUhye1bSrEjOiOTx7OX8WJN/hQtgkvih3/nG/50R41cLwcv/LrD9cU96yeoN4Y4ao6pYrRnJq0zbdTn3JLuSS64v+7KMlgmz7bWQN0LeTvejTrgKkbn6cqadcllglxQ/8/5dY/mQP6eKxvURCXHdpmmQNTpS0RjH6gpS6G4Y64hQQ9/6Jee2VYcr9yuNXDgZnSOfWe266pxm0NFph5hvFwJtlf1Qupuk3gOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qMYG8lazQcx+MP7yrBK4hVcHkjfwnSyCie7c7SmmgI=;
 b=B/rWUVZTAAUp0icNt3DKulrpjMCq6fv/gyF5QmH/147K6tmI4JY8ihy+XuUb08qz/DBOcAk9lF4CWR7R32pwMEfx/PKDcBYjxUjdCq53Am4vlNwziCwoNIEGijE1LgspP78fgEt3GXuMU13FhRhyJQIUo3JiI1Fw9DyXViPW7ds=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA1PR10MB6711.namprd10.prod.outlook.com (2603:10b6:208:418::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Fri, 5 Jul
 2024 20:33:43 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 20:33:43 +0000
Date: Fri, 5 Jul 2024 21:33:39 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 12/16] mm/mmap: Clean up unmap_region() argument list
Message-ID: <44baee28-a626-4be6-98ed-f5473d99157c@lucifer.local>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-13-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704182718.2653918-13-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO6P123CA0043.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::17) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA1PR10MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: ca498b8b-69a9-47f1-3ec5-08dc9d31c349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ZKc94sgIt4MscUJwXy6byGszuWOvKeDDBE9w3eyk7/dBBr2B0BA+6Ky3GHJA?=
 =?us-ascii?Q?43PGaEJkWG2fC00FYicyvnqBxH5zDd5NaA1QvvFoTDFX8FeCBW3zEcku1zd5?=
 =?us-ascii?Q?58nxkOeZh1yCuQ7bJap+d7qtwIp/jrudE8lnL1ZxLuDIs9Lauxg/EWb0w9pD?=
 =?us-ascii?Q?5Af2y8nPrvQup9LQEAWgLp+jusnHQso2ob08bSfYsPwsCrlrhOZqfsmrFAJu?=
 =?us-ascii?Q?ls6WC1VR5WmD92/0t8aCVH7xRpdWTNukjZtPjVUgJ1XN2UqCsK+y8rVzZgXw?=
 =?us-ascii?Q?2aqg53OWkODckJcIY0wX+CXIhI1SPu32IksRUpKfZltFcvHmZgfjBwrxavI8?=
 =?us-ascii?Q?xkvrRT/68bUb718r3sA6mlUWA17XXrTdFe2DIU7x8J9CEfCV5sW+pW5nVsUj?=
 =?us-ascii?Q?tOwV8g9DPggTxdmAKXNzEkOzZt/sqR/BI10PX9fywqLH/oTuQmEFSNG5BiSG?=
 =?us-ascii?Q?/cEqaPflvwUeXKlZpMNGLkn1MThqgyMH+1yxvlGGBAneGGG4mRn+H8UGsetQ?=
 =?us-ascii?Q?1jE9N4woCjGUJMjwC4Sr4lTQOnqvxNnR1P46dhR0s39BR/yCOKvey6CRFSwa?=
 =?us-ascii?Q?SuJHFWNZ+k2B0cycucY3jyhaQ/TOEfDFN2sBhfZIxLLlzoNFHRBQcBNiKbfE?=
 =?us-ascii?Q?x0/lhD9XxsV5+aIN3PjaxVmllvcOc0xlE+iow47kdUDnxfHGNUZIJYGzYQtf?=
 =?us-ascii?Q?8cIG+z/SGIMa9g5q8kM2BP1/V+2+fnr3QrZlDWB7/I6g7OIJeZTVsdJazzfs?=
 =?us-ascii?Q?AgM/dtPpnQdr744SFyTyaZ5SGJ3hXk0chb/52jrKkQvChXs5+o9KSs653hbG?=
 =?us-ascii?Q?2XEYoRlBAsm/YKIzRgb6wC+/r2gAI/uobDsi8xpP7tR8bKBRLQWNS6tmNn1s?=
 =?us-ascii?Q?yXPBnCxHbe09HvWnScoBqIdqOGdqE3Q2rg53tWnfORVpCWh8sK+/otFNON/r?=
 =?us-ascii?Q?V9vgYjWpFQExPDnbLLuYyD8szS5d1hwfssh2mwqYSSl+wQxwKKeExeeo75ag?=
 =?us-ascii?Q?onlIw7rAiU/G83xcigdvD3141rS0iIZSGJhNdR+btXBONW48JS+E16rwbGIN?=
 =?us-ascii?Q?svlGBzWvJ9306+KKTNzAG4D4Jit+tdTQmYkvTf56SghD/sb0VBXcY0THl7cl?=
 =?us-ascii?Q?+1iypQ0kA6V5GTOYJ5EMFJwoAPOS1xjqBJNOqU5SXJPETeqZMzOhB5qSRqzb?=
 =?us-ascii?Q?7a2k+NOfO8+TTYQjta2jDwKD+nT8cajSoOGRzy0w2d5wEi0AriBWGCX9E1EU?=
 =?us-ascii?Q?cPJ+hMUPlrD04KcasxghDZZy6aoI36Lk0JpzMz/35FqaCrwC4bhQomjzcASh?=
 =?us-ascii?Q?p3c66Ipn9bNQqThfpVq03MnHuw+2V80wiN7/kpjVY+3VzQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BRpJeFSYLmANJWwc86ViqYFinNQlL+tWouxhGcTjAepreWNgjwe2TRWiLnHF?=
 =?us-ascii?Q?t4YuQNJU1HVcv+L31H9KjrC7wHcrCebLAk7a6oNosS2dvWqLXWaWFWNYH1sS?=
 =?us-ascii?Q?FSNXUOqbn7+cQFgmXRzK0Oz+xO9fmZb4/7dUr45wSaTDbrXzIhsnT4dx82s8?=
 =?us-ascii?Q?Yh+zcddkhTMqn/qUv9xRHlDvUZLeqkDU6VEem1LmMXbmqsfOAQ80ez+TDqAi?=
 =?us-ascii?Q?prk1xPOLf/zDvaaOzYvFgmZuL38Kb/RLlHSJZEM8L//XdMsF0//ut0NDiyDO?=
 =?us-ascii?Q?72oLhTXQUlqTIUJYuOH1eV85Id5jI1pLjmpK/prZmqS+8DANEcSM6QOXXbAA?=
 =?us-ascii?Q?mBgh3KK3JguaNRNbNPNUQaQ7DOEXfR1KUJuu8DmDpENFx1id/8F/4cww3Pir?=
 =?us-ascii?Q?xlPmb2if28StE/aUk5mvXNadBjyFFiz+zcDmIZA+0S5DOdp2KWdeTXrE3DAy?=
 =?us-ascii?Q?7A2TxxgWv3r+Dig7n0m/SwjlRqvsrL62zn9CJF3FGh/saWrbMyj9VRRYcls3?=
 =?us-ascii?Q?0EdYAnm0G7iFYXEB2sa8/fkCwbl0KPWUMcj1E15Ckh+kuKx9Is2RoQGsqaFp?=
 =?us-ascii?Q?ESkg9A6aY3hVDnFypgSmYTK7CnRriyfmC8+/w7eStgBYT6OUly1OGlfOwPkY?=
 =?us-ascii?Q?3fC4N4DFUhOdXZap0m7sLO1TbCQDG803+jQRsUWOJfnvZ7ksG1Dr+KJ/CVi5?=
 =?us-ascii?Q?dfU3898Fk1dT4+waaJ7OTt2DBSkHOAdgzMWHLv24tJWL+gLv5njMA0jWjgU/?=
 =?us-ascii?Q?3vs1mPiIflQFDtKn2IvNVqrCJF1tPh9OYCLh2/IKEb9MuFcspwEkWybi5NHz?=
 =?us-ascii?Q?kQmYJhYKhNAsVXJ7B1eNKzhUhcguuiCCMaGUbM3I8TOOTOMYI6092L9hIKui?=
 =?us-ascii?Q?o7Y0mMPZi2Qwl6f/TgRTNzvHOkO6Mn5RO3q7O++joT4S/xZvyDjRTmRNHKew?=
 =?us-ascii?Q?m/6FG4xA+4Es+chv0bOKWY5cA1+ZitAGxxNRFKXV/iRZLwdMvY3cHu/04/3u?=
 =?us-ascii?Q?1yACmvhAqTnff1j2QqNRkaunEwxbWRUxqjSjKBQm3NANObFUtCASGkfE07FP?=
 =?us-ascii?Q?ul+HQwwuyemNDUrpugyWXCXK3WTKirQtRq/NVPIy2bYjHeI+PTotSuBOlfA3?=
 =?us-ascii?Q?lnsLP6mqC/tD5M5tV8GQEXAumaeaecDUALD5zNgZ8NvtoGV2ZSMKeAJ1myxO?=
 =?us-ascii?Q?Xev9kgyhFBL3Gp2iRifdM0UkevDtYtigjaZvLw3gzaH7usLGZd5IR5deIUaD?=
 =?us-ascii?Q?VBupAC9d8R8oMd68d+e8PCgaLIyFbkO4CBxZoyTtduMoQxxUUyqp8oNE6Kt/?=
 =?us-ascii?Q?0DwBSMb1mFUkJjvHKImqYVMzClGARh2nJ6udxF0nKNNa1LoLgZc5pYA23Plw?=
 =?us-ascii?Q?jF5+MQI7T1kd7ShACf1/02+gRl2Gayy/WQlGASsXglpq63JuEvhlCGcCdqok?=
 =?us-ascii?Q?kxYxMstrBKLPndweRY4kyWVrNjkvidyWC8ICELnlf9ZJ9fZRYTmW44l0Ehzk?=
 =?us-ascii?Q?S5BmOF1V4Dg51zdIux+p8eBCxYbcOhLjnw0rLV5E3sAj1yLWZel9openz/u+?=
 =?us-ascii?Q?YO78XRpY2xyAj9u1p0AmTEj2BwVy8AZf/e36ZB3kPTOLywhFLBCRJcyeBhzn?=
 =?us-ascii?Q?qA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	16GkvCl1Iyz0Xl43Ih6LwWuAmE4XV0X27xVgc7rqPogCOrjurT8YXFueLTm046ktlLdPdXuPi0VhHIY0uLEEWGstn0YqGCc+JCeW0sqxaionNwHpPFOr3zxhCnWn4uCmL0imsRvzgiYPfoRa0azFx1mF1LdajS+FwU83gd1kK/eWJv4VkAfIg2NiSxpDq72SPsm0PbrXyiO/xUB5JFLOWSWb75VIrO5Jv1EACrtWdVFv7z7qvSMQotIFkplYRv2DLKmX558+Piaz8JR1HCZuH2t2RLPsBu8dyQJR3PHkTpOZXElyrE0BBZkUNfLbpVdX304JFltfEarIx5tpZ5lBqh4+FesKIeIC1a3015vjSPH67fqQGQuNxK98JPZGISbpURazJVqEsgbST3EpdjJ2+6a7+ib+3q78/nDFLF2B2wij/lgDVuimv0IxLm06rqED/akdnN2dbXw77oF06Sv8m4eSjB6EYqLNRQS0LaLjyGFm3mxicyM0o59VxV+A9xQZBEriYPCbhWthj80CxIIUwdqlggXm+fUX4XkhwqUMcq8RFvC+Op4VNlCujx30rilIwC/Ty/cnGXfvItztNmTJXBdP4xZr44x9dlgVncnerlU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca498b8b-69a9-47f1-3ec5-08dc9d31c349
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 20:33:43.7363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nIZ+9dyknlujktftoXSVSJAuc61zM7s47AHBA8wQBtebdCGfbxIUKgO5+f6La9gGBXICkhfY0rYilq1cJEGh6PYBWrCTpoLT4hfZdwv3Jxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6711
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_15,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407050150
X-Proofpoint-GUID: rNpm9h8zX1rTWGxqD8mB4EZ8A1A1RJ0A
X-Proofpoint-ORIG-GUID: rNpm9h8zX1rTWGxqD8mB4EZ8A1A1RJ0A

On Thu, Jul 04, 2024 at 02:27:14PM GMT, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> With the only caller to unmap_region() being the error path of
> mmap_region(), the argument list can be significantly reduced.
>
> There is also no need to forward declare the static function any
> longer.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  mm/mmap.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 45443a53be76..5d458c5f080e 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -76,11 +76,6 @@ int mmap_rnd_compat_bits __read_mostly = CONFIG_ARCH_MMAP_RND_COMPAT_BITS;
>  static bool ignore_rlimit_data;
>  core_param(ignore_rlimit_data, ignore_rlimit_data, bool, 0644);
>
> -static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
> -		struct vm_area_struct *vma, struct vm_area_struct *prev,
> -		struct vm_area_struct *next, unsigned long start,
> -		unsigned long end, unsigned long tree_end, bool mm_wr_locked);
> -
>  static pgprot_t vm_pgprot_modify(pgprot_t oldprot, unsigned long vm_flags)
>  {
>  	return pgprot_modify(oldprot, vm_get_page_prot(vm_flags));
> @@ -2398,22 +2393,21 @@ struct vm_area_struct *expand_stack(struct mm_struct *mm, unsigned long addr)
>   *
>   * Called with the mm semaphore held.
>   */
> -static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
> -		struct vm_area_struct *vma, struct vm_area_struct *prev,
> -		struct vm_area_struct *next, unsigned long start,
> -		unsigned long end, unsigned long tree_end, bool mm_wr_locked)
> +static void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
> +		struct vm_area_struct *prev, struct vm_area_struct *next)
>  {
> +	struct mm_struct *mm = vma->vm_mm;
>  	struct mmu_gather tlb;
> -	unsigned long mt_start = mas->index;
>
>  	lru_add_drain();
>  	tlb_gather_mmu(&tlb, mm);
>  	update_hiwater_rss(mm);
> -	unmap_vmas(&tlb, mas, vma, start, end, tree_end, mm_wr_locked);
> -	mas_set(mas, mt_start);

OK so the 'raise something in one patch only for it to be removed in the
next' pattern continues :) more aesthetically plasing.

> +	unmap_vmas(&tlb, mas, vma, vma->vm_start, vma->vm_end, vma->vm_end,
> +		   /* mm_wr_locked = */ true);
> +	mas_set(mas, vma->vm_end);
>  	free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
> -				 next ? next->vm_start : USER_PGTABLES_CEILING,
> -				 mm_wr_locked);
> +		      next ? next->vm_start : USER_PGTABLES_CEILING,
> +		      /* mm_wr_locked = */ true);
>  	tlb_finish_mmu(&tlb);
>  }
>
> @@ -3186,8 +3180,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>
>  		vma_iter_set(&vmi, vma->vm_end);
>  		/* Undo any partial mapping done by a device driver. */
> -		unmap_region(mm, &vmi.mas, vma, prev, next, vma->vm_start,
> -			     vma->vm_end, vma->vm_end, true);
> +		unmap_region(&vmi.mas, vma, prev, next);
>  	}
>  	if (writable_file_mapping)
>  		mapping_unmap_writable(file->f_mapping);
> --
> 2.43.0
>

Lovely reduction in parameters.

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

