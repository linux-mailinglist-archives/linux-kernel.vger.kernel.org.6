Return-Path: <linux-kernel+bounces-241600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3103C927D03
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 20:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27291F21AA9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB47914037C;
	Thu,  4 Jul 2024 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UBD7EYdA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="msv0XSuP"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E44B13D275
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 18:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720117685; cv=fail; b=YxEEMWZZ1SNjw+UR7It0lpJwb1hoCTrK4pc4jUMiInVDwR5szkCdtFvqFdvWXpJID2o/2yGveTw16R2WfCJ+Ia7OE0bBu3UXBv7lnsq027t1ovwG0bWePJbslKFv1iJWbWlTCJ4jPSg6cqswZ1tTQKd1Dikn3chZGyKnbXIPATk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720117685; c=relaxed/simple;
	bh=U8JoBHt8ZlQB3Jof04EK92Ouxf5sSu4bZwlXusGMPB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p6qlMir+/w96fFivQVPceKGU7VSFpnyTyhbodUTL9FI6lRuWo4O+lsUxSUs2vlXAH+qAvvmfLjGnnnZUjoEz46JemiVhJWye7I7Dl1zB19sFrJ6Y5Txhd7p9pO/0e2SNsZ0RyuErJVeq7aO2OsCCEaHUM11btUetfs1qUbq6Rpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UBD7EYdA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=msv0XSuP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464DPnFV031070;
	Thu, 4 Jul 2024 18:27:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=MCMdiCS+Z5VLbHqW8repADVTOe8n4gC9NUWizk0m7gw=; b=
	UBD7EYdAxJ25XSUqum8nqiawni+4rhrttorJOO6WkprW/HvmZF8b9jp5LpJ46PW8
	M/8eIKxRIo9y9mHWx727C4YHBIUMKNCo/c8fNQofq1jQtvUjRh4P6FCRozkhHb39
	spT8gx2pznArV/NiB6XN0JSkW2VannlbqvjQhJdUHVn+lFwryxNU8FgbgekzyHZF
	Lg04zze2tpiVQWRpiIvmbMYeK6VXhJtaUHNZ0gKX1SicXYcmCpVawn93/EczTcJQ
	PEfhxc4h3CPCNovUqmAwcbr32+kn/VKIex/4TW5NaROGW3f0+hWJOB3J40INLIir
	PMv9G3MA7rmr2q6uz0aeMA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402aacjt0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 18:27:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 464HwBNi024792;
	Thu, 4 Jul 2024 18:27:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qb2h24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 18:27:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvoBqmQAtijar8bHFah0Oxu6hsFf+BFXaI1HA0AKKv1PbEkwx0Yml6MUHDJtdu5xG07etK9qBsPK2HoC3zdVPSWKwqJyQWZZICxBNpyaGEh82f2jGwv7teOYAqJbFech05ElK/2QA928nXhQh5u9iJ8dX8WYBb/AHs2af/30mAhkV2goIEGnYKtKZR1PNQaB1fdUJ7XJzoMFAREGB0y5f7jt2Yi2apIFviU0e+n0Z7cv3ydX0vJu3REk9oPIsS6P6gc84p3vyIcHGv3uQLMTc8PZnyKarsGhdXXc5Luy+DxuPnR9W4P/IWMdtemgLKuxqqeYEz8crb6xxkUqvAPmeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCMdiCS+Z5VLbHqW8repADVTOe8n4gC9NUWizk0m7gw=;
 b=h7+jME1khQcU22M7TDz8l1zS4/VYULHdfKJqlK5fxKXnQLHKV6Xm/B8qnn8MICOh8mCcwyi+g1H4gbnpKSfQPSmz7H99iyAHXtcZ2+7py6HegyT4Eun5r4Y1kWR90sMy76tedfFmfwwauK1JyyM6tIj/kWZt0q01GMjBcfsp0wWmv4MLKz5dmXMtwIgvo1yNOXL9Sm4VnRC9yFBqVf8XQQwSuuMK6uVW/oyYju/UHWGWIbZMZdm7bk1zYCZblO7lpYxl6kPG1BAmH58wWFHsQwJ9b6Kr4HVFddmblL0lZf9RKC4gbMfWRjnCDBYfJEhAbfLvoK/Adb3XEU5Tv5/e9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCMdiCS+Z5VLbHqW8repADVTOe8n4gC9NUWizk0m7gw=;
 b=msv0XSuPFGYKqYeuO7qSU92fqFXOhtm2b8PxUTr6DPPFKBH1MiS11HrzXOrvzqpgmSfRRAKeSsKIWn6UodxB0kRSc6MJzclH0IvsYCc0wKv8AjYzZQ5X+gGcjbQY5fQfXTOcTzTs0ggMTjSzjjql0Q2lCHcNwBjxUwxdhqAJSos=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BY5PR10MB4242.namprd10.prod.outlook.com (2603:10b6:a03:20d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 18:27:46 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 18:27:46 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v3 11/16] mm/mmap: Track start and end of munmap in vma_munmap_struct
Date: Thu,  4 Jul 2024 14:27:13 -0400
Message-ID: <20240704182718.2653918-12-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0445.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::27) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BY5PR10MB4242:EE_
X-MS-Office365-Filtering-Correlation-Id: 238dfe84-473a-49fb-1434-08dc9c57003a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?MsMnHtxCLr23JCqKYPkQAPL2J3nXpAPy9gzW+Quv25cXoO6qkl1xqmuzP/1G?=
 =?us-ascii?Q?JbhqMKDOFkA0o06V4Ft06d/K4Mk4gp1m/GONhsWy/MrB8n1BcSKuZJYuSfd0?=
 =?us-ascii?Q?GOdn8sQB1nc7FQOkmu0CHPLF41RpsFryt1Rxbfu2ip8lVpsF3qDBizB7JbPb?=
 =?us-ascii?Q?jeFcrt8lru66cUPs51y/pTXbARpthNSwMGvhVFY3cXjVagxe9+lzidfmah2P?=
 =?us-ascii?Q?KoOMo48/BM6Nqd+QX2KQhZM2Qtyh07n2nJ1rs+ZHVVfvDzVAsJZOCR1ymCIG?=
 =?us-ascii?Q?Ptvf23fsqQHeg8ta/0nscghtEPRSHc9x/DEEwmrXurs50UrfJImW4yD1gcbQ?=
 =?us-ascii?Q?tZ3fiQRr8bf5v8It+8SIe7XPAj4/BmyX7L4TB6Kd1gtS6zN/qI7mWYD51EX8?=
 =?us-ascii?Q?nlQNCOK54+gsoVasGxcjDZs066gfTASSDCLQYaCcmzO5iBk6UeOlz+giI5E8?=
 =?us-ascii?Q?5LJwTRLVpIwHvXgvKNzxSggrR7OrK0Qq6EyfSFABeCqLfFpI15eEVHTJ8syk?=
 =?us-ascii?Q?Tz/2DhxddfmpOpKsRWHO/luxTTPh+8ituYkaGykoqkzQEfiKgIXQ0DyMPZxl?=
 =?us-ascii?Q?Szy2QMEEMdmTnAcydlcwFIuSKV3Or/bTwXnmvdpwvM8FiJpTN4PLHKWhdU1Z?=
 =?us-ascii?Q?5WjIPKNHUK8XtYRsAenN348WHsEAknC2LEWUBFkze/Ae/Hv62H34dlxleZGd?=
 =?us-ascii?Q?ldZiC6j8/KL51yccEfF2FXgshyiJAg2enYzM/EFDy8vG04/ZYYPKuXdgLpEM?=
 =?us-ascii?Q?k5huxgTei90DCvyz+b8gGW5OFoxPBJD7AU0wF+54Czw8OGWIGBOjUtv3OQkB?=
 =?us-ascii?Q?4pqYG5PYY6AEuA1g8ykwRffa4kNFtcuq6N5Z/QWOiRKexZO7EOAVW5ABFAeI?=
 =?us-ascii?Q?xZLwYTuWkXjmv8BiVyMJTNC0njb1R9fV6JagoLDVwU1T+SXKv5hXgV1vZisz?=
 =?us-ascii?Q?cIZuH5DgKx7donUCR3PHOCwP0H4qlOGCbisrM/gIG92CsJB5uQ1wMQE4/t/q?=
 =?us-ascii?Q?n6CnynxPRq/yQZKb2h4XEjDipQOCHcRAlZ/rnacGKafYEho4r6UYOgH8mu3z?=
 =?us-ascii?Q?C/LPuy5qWriuyqIQwW8QOorDIi76N6+QUhWHPJGlU0OHrWEzziYmEwhivxrC?=
 =?us-ascii?Q?Y9jJWto3aN5Q9Z8+q8akozcz8raemJ0abuzP389Bv/k5X3cZdDGF1If2gT54?=
 =?us-ascii?Q?59wU3kWbMZY42kfsCseaH3Coav6D9l5OSBudL3js3Ab/wXRGIOxXWTkp19Cj?=
 =?us-ascii?Q?BV5H6ZOtI/lGJwSAZ2nw5fbqdEGuB9q5Cdn4LkKuRTaQADJPdcX6MVLDkfjA?=
 =?us-ascii?Q?0w+ta0BcEqul9aBZC21xZAQyKc2YUT8DQIWwvQqbLaHz0A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UzVSaES31IVQv/ReGwKIcb6ftMd4WoDreS7Yf3eKsk/adlN3Kdh6nc46Uv5k?=
 =?us-ascii?Q?HUh5yq/qCOpCeceTtOG40H9HPPN7n6ST6XF9TR5kwf3X6dT/+1I/smJqWeBt?=
 =?us-ascii?Q?vKUG8c+iN7YRvo0IUgDvERGqAA3VxRl8KbNUS76M/olVLrVSBDUNbIENV/rT?=
 =?us-ascii?Q?DzeZuSzpQL6zYmaE09Y6gPeDznCOXCbaciH5axwi5i0qZ1kxRnuf4M285ZxM?=
 =?us-ascii?Q?+7UyxWcJSxdrmxXndFN55FVtY7nN5dH9Y8u3wOy6X1v09BWDY6EKIbjYnJP3?=
 =?us-ascii?Q?YzWpuB+XuZccUmO7U4tlr9Kpx6VoutNHITw5lJwI1iFWvkHYPP8oQJGimWgF?=
 =?us-ascii?Q?0/Y3EEerTzpNFbOHwWCBae2loiZa3H5TPhRR4YpVTE3jGqbE0lHQGkPs4o7b?=
 =?us-ascii?Q?ed95Nh/yrL3RP2hHKJt69e9zKWv+V0IG3lTwWrUVcBzwRBoZWXZoUDoIZXNN?=
 =?us-ascii?Q?xpJHBlVGmg2jX/CVr+E9VACy39jl+oi7K1DrqynqTpJNtF70A2/uuQnUSj+s?=
 =?us-ascii?Q?uIAnr+xWYARKNVwaJMT09dhCu51fBgGVtphz5nagMnJ1UIBefjDmGg0f6r2B?=
 =?us-ascii?Q?adCcYw3MpNs4mxnpR5huPyBXOMFgBf2c3qVdsit6hD8mlkmKHO9sZhT9sKa3?=
 =?us-ascii?Q?pYn9Yqicl7Js1amxI5uwlmlca15XEhtfMjzaNsTaGK0/oIrC+SDPlO4k8u/5?=
 =?us-ascii?Q?Um02oVLZ/rKgZjwHXTt8Yvx5TBq8n4R66Avt0D01ogKw1Wre1HyuRi05Aj5l?=
 =?us-ascii?Q?0m9tNChleBeipPjU5Fab1iVWGiZ0LUI6pD1mskKCy4VPm+UxavEPKd9brrHZ?=
 =?us-ascii?Q?SkwKgvCqj4KOOcRDKvQJcnhT5q+uG141KV40vUCZyR7SEN8U2BRJ8LH/83qv?=
 =?us-ascii?Q?WLxF4+7mKG98aWD8FzC74eRrM8K5ZhBHsrzHXcw3BUkj1ilesn/a4uvo8BIr?=
 =?us-ascii?Q?6PPfTe+LcKBM4xcW4BGSKiJzI4jq8R44ckXspMmu2NyOBNGiaj5opr4HulB4?=
 =?us-ascii?Q?NGyj/hzeWApWACNW0p5iRSgTtAwRcy1IDGOBFJF9o93PqUc3WQeZqRcBR5/c?=
 =?us-ascii?Q?F6mPj2ILQnT9tUuo0UlHVtzmjw/QCxu7I95ii4KoTm84EalCIUztP9eVSXX8?=
 =?us-ascii?Q?0h15gBwR5Wm01FBKU0gNZOB+v2Ie8mwDCi6toiiDFCCA5Qveyy1ak34p6ydj?=
 =?us-ascii?Q?SYZRWFeydIAQFVzpTFAHG9mo9nI4u6BQlAj9yN86WVpz2qhpO0LuXArYNtwx?=
 =?us-ascii?Q?ZSIq+rrSNjrjr2U9+n2zWjGuEM6YGv71/RuZ68Kle41+H1s1sTkjIa7qrtLI?=
 =?us-ascii?Q?q7AFwWWKCqnJlH64y7oMcQzHE7Dv2e98fCqB1vcOraX3aoeHST8ecne7bS7+?=
 =?us-ascii?Q?0kTRn6Oggnsk16iBJpcWTlGLCVVlpEqN4sryONIIZ3/EKVqUCwzSwwTFmF0/?=
 =?us-ascii?Q?mtcdowhfbs9slFTAUhxhLc1QI+MUCXHrPVJ/Ce/1LZqA+t+6SMmOSPmWhl7Q?=
 =?us-ascii?Q?V6pgHMK7SqxA78BLDRczMQtkAm1W0lddpNUhY/UdCTi4e8lWGynEvFiepJi7?=
 =?us-ascii?Q?5gLZM1VDP0yaY/OpryKhH7CyXJuWlYcT0T3Ukx4epJeraQChbOi158pdGi3n?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0T28tw0OraNmhehrEEayPutqKx+8FqurgN0ToUBMZL8sUSSEIx4WAthA5zIXozBA7yEB4QdZA03whxuNG3+/7FqXE4g2/pG/ABUg9fgqO8f5jmWDvGq1XFVaZC2AJ9h/sQ181keumLn0Hm6gWthbbF5XKqFccX9ezbvWMZHWHLHTOPBjKwrpDblszPC0PcVk6a+2XJt9sCpqzKMKppZ94aGZQmyqP+3Q3UvY/ZcbbhLUGWp/qRTvU1+RkdgTvKUO2Fgt7fGOjorAEikPv9P84DLdbc2shUKvwuHWqo8O0CDmE8BMEr+tV6oOE5tPSQ16PGAvAAzxMwt/Hibenxupw552xzVSZ5bKDfPml0jPPtesJW1qEAcr6AkDt/+TuBAA0+CEimN4zaj7dq4wTvjNFts5iop6Ivi/mcmvpua7MlGzQ6AoyXf+PSsVm9rPnUj4cNjnifAqXaBR1GwDI0s+lu6o9A7B62SYQ8uTGj2FLr3bPuMmz/LUfEUa4c6vRS1dQfufgX3o1GWinqj+7pXzuivupe1rcQHHMSo9mmt1EhNeML8jGC1roooCheRwxJqD3kkRW7ufHyMYcZSwVO8ogC/rK8PXC/QXRVEa3RLGSNU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 238dfe84-473a-49fb-1434-08dc9c57003a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 18:27:46.0385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPlhPbjat1sDze9Z+3cp2fHThEjmDJ4acOJCPE2ghPwuAD1k9j/VbvMbn76T2AD3BNrOH22NLsc4FBqP6pgdGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4242
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_14,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407040134
X-Proofpoint-GUID: v5SnP3N1kFsz-RgIiczIJiS0K88X5jXU
X-Proofpoint-ORIG-GUID: v5SnP3N1kFsz-RgIiczIJiS0K88X5jXU

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Set the start and end address for munmap when the prev and next are
gathered.  This is needed to avoid incorrect addresses being used during
the vms_complete_munmap_vmas() function if the prev/next vma are
expanded.

Add a new helper vms_complete_pte_clear(), which is needed later and
will avoid growing the argument list to unmap_region() beyond the 9 it
already has.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/internal.h |  2 ++
 mm/mmap.c     | 34 +++++++++++++++++++++++++++-------
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 8cbbbe7d40f3..4c9f06669cc4 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1493,6 +1493,8 @@ struct vma_munmap_struct {
 	struct list_head *uf;		/* Userfaultfd list_head */
 	unsigned long start;		/* Aligned start addr */
 	unsigned long end;		/* Aligned end addr */
+	unsigned long unmap_start;
+	unsigned long unmap_end;
 	int vma_count;			/* Number of vmas that will be removed */
 	unsigned long nr_pages;		/* Number of pages being removed */
 	unsigned long locked_vm;	/* Number of locked pages */
diff --git a/mm/mmap.c b/mm/mmap.c
index ecf55d32e804..45443a53be76 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -525,6 +525,8 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 	vms->vma_count = 0;
 	vms->nr_pages = vms->locked_vm = vms->nr_accounted = 0;
 	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
+	vms->unmap_start = FIRST_USER_ADDRESS;
+	vms->unmap_end = USER_PGTABLES_CEILING;
 }
 
 /*
@@ -2610,6 +2612,26 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
 	__mt_destroy(mas_detach->tree);
 }
 
+
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
+	free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start, vms->unmap_end, mm_wr_locked);
+	tlb_finish_mmu(&tlb);
+}
+
 /*
  * vms_complete_munmap_vmas() - Finish the munmap() operation
  * @vms: The vma munmap struct
@@ -2631,13 +2653,7 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
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
@@ -2699,6 +2715,8 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 			goto start_split_failed;
 	}
 	vms->prev = vma_prev(vms->vmi);
+	if (vms->prev)
+		vms->unmap_start = vms->prev->vm_end;
 
 	/*
 	 * Detach a range of VMAs from the mm. Using next as a temp variable as
@@ -2757,6 +2775,8 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 	}
 
 	vms->next = vma_next(vms->vmi);
+	if (vms->next)
+		vms->unmap_end = vms->next->vm_start;
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
-- 
2.43.0


