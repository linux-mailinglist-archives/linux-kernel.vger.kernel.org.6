Return-Path: <linux-kernel+bounces-294706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3967E95917B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 02:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7D3A1F25CC7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01051D0DDC;
	Tue, 20 Aug 2024 23:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rlxd/xZY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kG926isL"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A72A1CCB2E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 23:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724198307; cv=fail; b=F77QjrUU+7SpuYf9gEjoAZE8dopDX25YuQeyLWU+swvFDwqX6y52d+2n9VLoMH2Jj9LBe8y31t65aM9OVZG/bSrCwjXCctOik30C70/FXN36mqXbJvsiV8x1dV3LSxA5GWXG7U9zIxMRBJ0F5v65XRQIHl4B3bQT0PM2oYqg39I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724198307; c=relaxed/simple;
	bh=0lxxJy1krsBWo32qInFhesCJokQ5PiwXTG0pkGa4zlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YHB2Z3wWRUbS2WAhlBR3X4e03rsgz8w6uXlhFvD/SxsXaorMShsMoRDzCf1EJs509Kha6QGVm9QnCnjHUrhqm6Qoxe9egqSBlEuEpU5umsURDrU8YyqA4cQUFyZOiBUpJ6/egWyZYgUE6gq+y3g/+mui16Q8B1bzHgZ8kuM8tVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rlxd/xZY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kG926isL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KMBa8w017785;
	Tue, 20 Aug 2024 23:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=7cM32KTH1tzc1Ltl5lH6KrVUwxyw6BJXIXdnd+YGGaw=; b=
	Rlxd/xZYuzMLfy8/iaTIsS1PnzvH/+g0W9WdXD4HgsRX9MhE8DJUPz/gK673Im3j
	gn3YSlxeYCVxK1PPryzmniwgV6rY4yq7SjhIshAelgcHtqVfj8maDk8Qt6cAKCnl
	zlD7TnuaMOGBEYPtvjfmyucfR80ERnzRszPwFuqRSy5cGs7wGSDGAok7Vg7LEwsy
	Ve/ToE7VyeehTP+2N/ysrCYzmtsZzE4hjbL6f2qztMeIKv73la1IHHKgT7vRPjxC
	+c2g6JdHNR5aYlyoynlNpyu1h9rNwTxfaXimPKWh7NRLQphSk+HMYpI9ix3YiDiN
	uJR1TWTWQK3AnharzUaViA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412mdsxagr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:58:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47KNi8oV033669;
	Tue, 20 Aug 2024 23:58:12 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41552xg9rn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:58:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMAoNH2tquvPaVaOCTQ0nvCrTJFSha+a5lNZHmubMGMMDihwCxnkIaVFIREu0HgGnKeRS023EUZC2xQ9WaEnnkGww9SAauOGXkw9Ye5DfYftpw0b//bQt/lJPLXEh/1DgtqxCepC8iH9hWFpRq2dUG/DCojfxpQ9TAtRgYPlD7NL+n3Hxx0E/HtWnl+LjZUftOsLvInzs8a2JRU2/dW+07hUY9eAS2zeBfXznkmUvQAmzBh0ok/40RsEvot5e0aYG5vZjqFT169a6b/nn0w/6n6aycC6u1SKV21trfyioPJopktHxce2CrIRGBSJwSwFnyBAz8EahJS8j+sTfzUx7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cM32KTH1tzc1Ltl5lH6KrVUwxyw6BJXIXdnd+YGGaw=;
 b=awT5Ib24lOTaJNxVbTuuO03+qZjUBLFW09XlKuKL5Ks2Fr1lAB7kweLavMHSxWi3YMivc8x1dSxbr9SnFaWTj03bDDODKUmqvvfYGLvjxvxBUy9HwjcJCQ5Eb8mTsVWkRwsaYZaei6Kw6iCXxgqTh4XyPPcl9H3LpIl17+5Hu0o2N670ok1Es2gETEZgmkY2hswq3yBRSo0G4xqu7Umra9iwemsoBNy41nnPL/1bWo1lEHQJ31e9yKb9p2YqJGBiB0oMUY+qZbPJeMdGa/KRKVr8psNdleOGDhf1RBecbhh8s2UWyp+m+NAxGzayXZqatuaH93/AqigygJEzBugoBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cM32KTH1tzc1Ltl5lH6KrVUwxyw6BJXIXdnd+YGGaw=;
 b=kG926isLG3B3FxbuLf+r4EvmZ5ZY3e/ZtcTFvYWPKNtXn0Nakcx5A9qwUS3M8Za6qo9W/Yev5uBKcz+/cq/F8Q5bHxxgxTbqGZyfudHZZ6tyP9RMhZYcBb26o/+gn8lF0w/MUyVvtV3P2zwODbwqg6QN8GTp6KPNnXRZ7R3rNWE=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB7099.namprd10.prod.outlook.com (2603:10b6:510:26d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Tue, 20 Aug
 2024 23:58:09 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.010; Tue, 20 Aug 2024
 23:58:09 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v6 12/20] mm/vma: Track start and end for munmap in vma_munmap_struct
Date: Tue, 20 Aug 2024 19:57:21 -0400
Message-ID: <20240820235730.2852400-13-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
References: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0479.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::19) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: ddea7f9f-7a1c-4874-923f-08dcc173f139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7j+YMejonpVEeOEqS8LZwMX3AVkiEaMcl1vMpS0cn4cXb/tazyTeYD/tJJnR?=
 =?us-ascii?Q?jaE/yYdtKRbn5tOM3NTmneSeQlamsJbPkRJdpfojRI9oyW56P6+nmRG0yoAV?=
 =?us-ascii?Q?I0aqTpEang1wQ6AeKFElhrwQ8WV1UkTqxsL1fFkTq+3e6WouWfRbapV2f0Pn?=
 =?us-ascii?Q?uELU/0rBVbDP99+NzmyJ1ZyThL0RkzQLZLyiSltMShGjdezLY3JHo8tH6NQO?=
 =?us-ascii?Q?ZD5rwiqifkGsLVMxMxoL48mH76vNWwI26mbXN+9B+t1rbLY1x/umKm0hW7Q7?=
 =?us-ascii?Q?CSJIpNBbo+1Va8CCdZKkBfJvJRLMj/dL2NI/+OdbksqjHY8uBPy+DFTzH8Je?=
 =?us-ascii?Q?89XJmwm15xL4ODwfdMEVnrt3If4xr3zB4qIOVeSi7dxcZszbxSSjlKNNhKZP?=
 =?us-ascii?Q?jV8ZMnbWR3f3qK3GVCLGsM0k8mAJnN0BhwXnv3uFWPACuMR0Tky73DVspkC9?=
 =?us-ascii?Q?TJ/6tCVUPjTtflQdQTgI9wIHCwEx6pc6XqpkvKpvzOK7mljjiumLyEBPBH5i?=
 =?us-ascii?Q?K4u2DqzP3V88LViq7vo2XyrJsN28J4QqlGAjeBl54ZiE0Yd6Ezvjdk9jNK9J?=
 =?us-ascii?Q?x6dRDbhVE/f3n95AlXQoN0bvYe9AsWIR+s1DYyGnqihK3gpO1fya3sWhwdgv?=
 =?us-ascii?Q?8WD0jWWAarhB3cfek1G/NDbRmCmCV9rS8zjappzI2cGSJnKZG9HEFQnwYbIy?=
 =?us-ascii?Q?FrgRXGqcn0S0b5lpG6wmnrcH0+dG8eWO4YLhtQsagZm+AA7WlXfTNv6P2VtL?=
 =?us-ascii?Q?AzB2DuoJTqx8DxYy/JlF3PzkbGhVBblA1zfOIb06789HJr1O3MdYDbRqSaOf?=
 =?us-ascii?Q?mFBml4oeDh1cNAkwYfI06TOtjKsozfDv9wngAEXZ5tKCM6g6Byio3cgRfyqL?=
 =?us-ascii?Q?s1AinVW79IalDmHDY02r0Umt0h3joN6kGzVSidBkdNa2elM5AUt8PLfKxCfx?=
 =?us-ascii?Q?HpNTr2jWTaEpd6vW5eSK8ajtIl6kqO6tO7Vh6G3V8MUBqjwgzeEMDoRMSBIT?=
 =?us-ascii?Q?LmVfvnemQ3mj6QC+TrM97+wybSAzpCW9U47V1l9yeZEQBnqabh8gBl/PMKMm?=
 =?us-ascii?Q?unPeQ5Of8DPCx3LO3MoPxTySaAeJlw3HleQ6ZVh6HOAvXpUxxFVbpItFmoa4?=
 =?us-ascii?Q?kHRTAQe2kUDAwmUKATrN9pbNHOQJ0BY/HAjUVKVWonHOnJTz6qiYR7oaAyKi?=
 =?us-ascii?Q?YRt9Qsf/YRmdFFFXlbl84stIW/f3c8rlquehPUwWYkt4f3QD9xKOtvOfg+8M?=
 =?us-ascii?Q?Hc7k5pVUujwdc1DLg42OD6H5Fm7VXGz2sURMZ0oqC8Jsi5O1GPtKaI8P0H1o?=
 =?us-ascii?Q?zqIuq9c4d+9vqzyqUF/IOuXoR27O+o9jNoZMyZ13U0KNMA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0y+Ng962avDhX3eMS/lZObwmq83V8wK3ewjlsd9qRVb3Dx5zTR6iJwWX3WId?=
 =?us-ascii?Q?UMa8jHl58grdCQmketaB1EC1DHDFfPXziHtzezpseb4grI+K24Q59T9h2jN+?=
 =?us-ascii?Q?9gP58IPh7xJ4T79MRKIsxC5XW8xqm2MfE5uWO9fIAX8e364fPMi2skJiLwu8?=
 =?us-ascii?Q?sDwrmbRQLDfCWxDi0jSU58hxe3s/R645zwkNQjWv1OfQbnRgJrJV33TLXKLi?=
 =?us-ascii?Q?o2cJo3Tn8ZfayKUS8vai/fjTXNs+VsoTscT91TYvWkduJqzZJk25SZy/zrLu?=
 =?us-ascii?Q?Earuov3CZunJm92wgF20obzZomkPdkJZUJV/ls/suE2vO1yfHgSC5tMO/lQA?=
 =?us-ascii?Q?B+K7l34WK9NVSo3UdFAI3fMymDUlkd57edYBhhDtqZis7ufXa0MMiBQWZKNj?=
 =?us-ascii?Q?VABv99RFHQGkaQeVfjoQcOlrbKAQSixYJlZG4DyziUdP24acea78YwT8SINF?=
 =?us-ascii?Q?c7uOAe8rl4o+6d//l3bxmeAM0oJC0gPUwO5WlEMzK8xvDKluDRFaesQzZjYR?=
 =?us-ascii?Q?HkZERpGwfrqSsRmUQAtNzpoPL5e7fxY7zKRzLWtA3GKnBNtHABwLonum8HJa?=
 =?us-ascii?Q?3vh3sFFi7nfmjNv0vR9xa0BuvkubIK1S55S2U/hMqh4nHAj/2QPSqkz9xAe9?=
 =?us-ascii?Q?DpDLB38mLh6wl5W6Mhk0i+ii92CPoLPDwQwFlfEjSUSjGT9T8s6ab1P6D0Me?=
 =?us-ascii?Q?67rwuPLYGsEi88HH07+2OERy6PaZ2xDLHQPTwkpdTqpmzkoR8pdOXcaVoZ2C?=
 =?us-ascii?Q?OQmP550glb0pwCjAgABNK05b9pXWUT6IkgQ7ljGDE1as4WqMbXQ/G0HGWwvC?=
 =?us-ascii?Q?hJEOp9J4JHR5TTnvVfMwEGa5GxzJG7/Bd7hPYcjQIduHf7FLO4Q1Oe/PituB?=
 =?us-ascii?Q?IVUQPGehBMMqHpU0UyYq5DLeqMyvrPNZniUgDzd/I+unIxKy+gZUOZjJpLsL?=
 =?us-ascii?Q?tzUV9zUfU4vrAFfQEvGffX0fOu4VQ/WL4YnpZdOiVukTNDHPc5tXLi0KHVxX?=
 =?us-ascii?Q?VPNuAWbkPu7+e1HXG/XFtAsPQVfFl8LeaCHWrhXwKDIKmpp6Ogfpo8jQGbTP?=
 =?us-ascii?Q?zOjt1FRJT+1gh5F3ucRzefv/2/3CKr+7a1nV1y/s29elihr2mmBqxK7MbZL/?=
 =?us-ascii?Q?ZmJ0mt2HQeQIEn7RMNpBDtk9Bm69TUN7IGnggbLzVXWcJuXPvBuqYxXmZtRI?=
 =?us-ascii?Q?vii8gbowhkfvCIvLefK43j3X5fpWGRHzb/gb+puNRmdoMyxSMiG5oL89rUTM?=
 =?us-ascii?Q?wDkGJxyQcie6I9zX8qapYYVbEd+VvghBuOQuTSmIs51MXv3BnUWGCWz2a9Om?=
 =?us-ascii?Q?LiEWCaq0xTq8xlUDKbvozZU6sjYrozL2cD4RsIBUXgQGPKnMvZSunZjNAv6K?=
 =?us-ascii?Q?nWBjln70ko+OxRjY59eINM/VNvnPC1bVbSZgGK4/xHX+FkFJLwU1W7CxM0lt?=
 =?us-ascii?Q?4MEUyPOdsNsR1VSHtiTsJyjhUVLkezCAoOMMxtB5yjkf90nYW/frRaiBarcO?=
 =?us-ascii?Q?wCc8Zaa1Rla1/Z2DnB8/V9Pwok+wjCuTnP7LlzL8vhHtQN2VVQI6+ZDgjIvp?=
 =?us-ascii?Q?GMqtF3T+hhtg3mzFCwCKmGFy2O/bR0hemKaLp3X2VRP/wuQ5fxJr9PuuAiiM?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gYS8Rr5j2Iag+5jrw7iUEk6mZ4QiHIvZ2YSdGh+wtc4ST+5lcrGgqlxu9+3gDRmqq0N9ASbt5KUzT/TCA1Bp8+p4JrYHJrz8WATpOZqicLg+aIeWuQn7gjn+BMKYre+r+7FGGd5dm9X3fV9ATqhwe5CGcRt2GfLtB/X/CnLSwkVdYb4Xh9VK9b7Mi12VfDcML6/4N+BcphgvJR3EyXKjI0sSCApUrfQi4wNnZZkg39hc+FTHdujBqLJqLgJ1m39ZEb7Rf4Ju0QwNSQ72EKCvJi/zU7eLBVDmNtWB0wTEKHAhRqsuNOiDK9dKxihsB5p/aAjbi4Svt5ySD0eUTRW4zJmdXs60iqIt8JPQqWvmOI6e3pUzLJMYntwUApECGup3hmSfDlcUMdLclBTOZ44zFVxUJdpsgKbgX36ESC6qe05/wKruq1HE/KE8RTA0EIWQZRq7OWO4ZI3jNfqXLtVWQ6WAJ1gFBsC8Vf3LdaXVzkjKNIBr1RsVjFYVLGorHx0i5bmXaJ03sCfSoEIR0ifpAd0R+X0W8gkIvUTR1LSNdAY++Jy21rxcqqM1xUXWZfKbRJ7Eb3J87c0VK5aq0BZO6eykwl33hWO3zc5iQXjPLW4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddea7f9f-7a1c-4874-923f-08dcc173f139
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 23:58:09.3453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XeUF9VWnElqMbuTTrEYl2AuyHLyub3H4g5RtMn+Ki01UVCtzr/vx22aJ62WCQ8f9Hhapdiq3FmHdHpjk9Dd3mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_18,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408200176
X-Proofpoint-ORIG-GUID: bvT6GbAxtERbTNSWLz5XWoE9aZzQewGt
X-Proofpoint-GUID: bvT6GbAxtERbTNSWLz5XWoE9aZzQewGt

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Set the start and end address for munmap when the prev and next are
gathered.  This is needed to avoid incorrect addresses being used during
the vms_complete_munmap_vmas() function if the prev/next vma are
expanded.

Add a new helper vms_complete_pte_clear(), which is needed later and
will avoid growing the argument list to unmap_region() beyond the 9 it
already has.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 32 +++++++++++++++++++++++++-------
 mm/vma.h |  4 ++++
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index a8d716c39db2..5ba01dde52e7 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -646,6 +646,26 @@ void vma_complete(struct vma_prepare *vp,
 		uprobe_mmap(vp->insert);
 }
 
+static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach, bool mm_wr_locked)
+{
+	struct mmu_gather tlb;
+
+	/*
+	 * We can free page tables without write-locking mmap_lock because VMAs
+	 * were isolated before we downgraded mmap_lock.
+	 */
+	mas_set(mas_detach, 1);
+	lru_add_drain();
+	tlb_gather_mmu(&tlb, vms->mm);
+	update_hiwater_rss(vms->mm);
+	unmap_vmas(&tlb, mas_detach, vms->vma, vms->start, vms->end, vms->vma_count, mm_wr_locked);
+	mas_set(mas_detach, 1);
+	/* start and end may be different if there is no prev or next vma. */
+	free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start, vms->unmap_end, mm_wr_locked);
+	tlb_finish_mmu(&tlb);
+}
+
 /*
  * vms_complete_munmap_vmas() - Finish the munmap() operation
  * @vms: The vma munmap struct
@@ -667,13 +687,7 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	if (vms->unlock)
 		mmap_write_downgrade(mm);
 
-	/*
-	 * We can free page tables without write-locking mmap_lock because VMAs
-	 * were isolated before we downgraded mmap_lock.
-	 */
-	mas_set(mas_detach, 1);
-	unmap_region(mm, mas_detach, vms->vma, vms->prev, vms->next,
-		     vms->start, vms->end, vms->vma_count, !vms->unlock);
+	vms_complete_pte_clear(vms, mas_detach, !vms->unlock);
 	/* Update high watermark before we lower total_vm */
 	update_hiwater_vm(mm);
 	/* Stat accounting */
@@ -741,6 +755,8 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 			goto start_split_failed;
 	}
 	vms->prev = vma_prev(vms->vmi);
+	if (vms->prev)
+		vms->unmap_start = vms->prev->vm_end;
 
 	/*
 	 * Detach a range of VMAs from the mm. Using next as a temp variable as
@@ -808,6 +824,8 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 	}
 
 	vms->next = vma_next(vms->vmi);
+	if (vms->next)
+		vms->unmap_end = vms->next->vm_start;
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
diff --git a/mm/vma.h b/mm/vma.h
index c85fc7c888a8..7bc0f9e7751b 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -38,6 +38,8 @@ struct vma_munmap_struct {
 	struct list_head *uf;           /* Userfaultfd list_head */
 	unsigned long start;            /* Aligned start addr (inclusive) */
 	unsigned long end;              /* Aligned end addr (exclusive) */
+	unsigned long unmap_start;      /* Unmap PTE start */
+	unsigned long unmap_end;        /* Unmap PTE end */
 	int vma_count;                  /* Number of vmas that will be removed */
 	unsigned long nr_pages;         /* Number of pages being removed */
 	unsigned long locked_vm;        /* Number of locked pages */
@@ -108,6 +110,8 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 	vms->vma_count = 0;
 	vms->nr_pages = vms->locked_vm = vms->nr_accounted = 0;
 	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
+	vms->unmap_start = FIRST_USER_ADDRESS;
+	vms->unmap_end = USER_PGTABLES_CEILING;
 }
 
 int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
-- 
2.43.0


