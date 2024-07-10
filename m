Return-Path: <linux-kernel+bounces-248156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D7A92D904
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF3A1C20BE6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CB3198840;
	Wed, 10 Jul 2024 19:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WxYut9Nq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RzOECqxY"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE70C194C69
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720639427; cv=fail; b=CaEIhiUXUhfO4bU74n1oAfsNM7ttbWbe9xnkCy5R8Ldk4Oeep0AYxOMRIhJATn2wc9x6WcuPzFoUhyxh+E+K6MCyprKUGEO/vWCQCD5H8lgTM+pXr4V7AhTqPDUQekm/aezrej7lIMKy2G+6nhtsdqRdma8s6TqXu32F6SrFv1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720639427; c=relaxed/simple;
	bh=RU0HeIs3/9aDipOIl2vp9MGvwKMRUB0STEV2pCVMK60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lLcPksvA0KPzwEITFlWSJiDaWwtHpmSOxWCkRQyQ7hn7/10Wz4K9yROEHQEPiW4QmgVd9B1cC3boOfnTtRJlY5mIUkQqhpTyP8PxJMZzOXOY3G4ICC+CDDaAhVrSoL3D22Gb0spWn52Huwz2ktUCs1RP7RUwSC0Sg3y3QUs7F0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WxYut9Nq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RzOECqxY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AFo7Jf029670;
	Wed, 10 Jul 2024 19:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=krst5Gkm7JY0suARBFyucKPoaXoJgRFwa+fItqdxLmI=; b=
	WxYut9Nqu5LOZZdFbF6t8xW6KhmkTwrjYXeAwQQ8AN+9XTd/azF0isBuzXRd3wbH
	4geDGk3reuqTDXM9Etw5iW8N+rflht0ZW3WDv0YMRrdGukjkvlJNOUje2G9KwiWx
	n/ufetmNS+3LdE2Xeot1htVI0zzLAgk3XnovNUFYakYMn9vIeKgLdZpcRGEqy03O
	e9NwLTlPOtBlG8/q20tvsTHcqxH8+8mCBae8YOf8ZM87ksq780wQBHvDuqPEREmf
	Ojt8NpsILiGVfvDmM7Oqt4k/Uh8w1evNB0f/ni6LFfy8vgV2zgm8ivSSrrGqkBSQ
	F5Woc7bIZX2NJnolF/N0Qg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wgq02f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46AIihMG033699;
	Wed, 10 Jul 2024 19:23:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv1948k-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHegmWjrH0CWEgb1FJXTQdQztNBgZsXHWOFFosmxQprXIDyDMB0MtCuKKkoAc9NQU3DMFsT/S/uS3AvPdF0rOP2jcyRL5TJaY7Y4KaSKQ7ruQetdOWknDKRjjSTafurVzxshQKzcA9Mj8LkBnYhh6HeaFaKYiOa213ViRKRtTVRh+9nh+oGElyDPBgirs2GO91QYy2kowfzsq4jUboQgZOV8HUhke1jKU/YjqBMgqxN2xIR0GfVkY+BdWcyjBaEp0mtA23vmsBp8pu6Cw8pMZpTtHGEAdyn2I6jirHjniUUv/e+453tEz2ItzvJfvuff/9GjYP59BFkgvCGnHdziwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krst5Gkm7JY0suARBFyucKPoaXoJgRFwa+fItqdxLmI=;
 b=oF2GqXNVN0+ZXk7V35laZsJz9rVpxA5JbGKVh6Q59+bmjj+8ipMgfbR1h5oXrH+LMULZtj72dhkN2dmAsQO8ENpFtr1pV2NjsHP8/EyqcJ9NOVkCW3JBC8632548+m56hVRDNHBPb0ZnwCOjWjZVuuB36s99W2c+fkiAAQ2nxkkNyvBJ0U+qaacD9tc7M2po3rrPOj1eoVW3LKO0TnfXKnUeBX0XDHTmFOp7MFlWA4hdxgduc4ScB8DbZ7F2OsGlcDL15zGm+RrstR0hgzbAW48flyETM/kVsS75/L/4hpE6XzaInP6fY2xrT7wy6o6olZbovyhoyM1NioX4PbbXFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krst5Gkm7JY0suARBFyucKPoaXoJgRFwa+fItqdxLmI=;
 b=RzOECqxYZ6VYkZrRy7cUJkMdR7je6PYXfMcsPHMxyNwtzPRLMmyPP2dAPL9PPmswXZBlNizozbYc3Ulc6eIrViPxSVNIem7r/aXhKZK+9vLzhZS+fMZWcRKbPFHJ+BH2yMvuorHuc4mq88vuKul9PCQDBJv2YfHGVAKJLf5TH3g=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS0PR10MB7295.namprd10.prod.outlook.com (2603:10b6:8:f7::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.36; Wed, 10 Jul 2024 19:23:11 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 19:23:11 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v4 06/21] mm/mmap: Change munmap to use vma_munmap_struct() for accounting and surrounding vmas
Date: Wed, 10 Jul 2024 15:22:35 -0400
Message-ID: <20240710192250.4114783-7-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
References: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT2PR01CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::21) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS0PR10MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: d15f6b1e-83df-4032-fcb5-08dca115bc9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?awF/FkNLjhnlny0gicOkOh9wYoSO9ANd/5n59m0l/lnMhAQJHQCyiYY65/HR?=
 =?us-ascii?Q?HLGmRhsmQbjeDiXprA2Ao593a6hS8Y8wURCKia/Qww74p/7TLC+Eg1egATWz?=
 =?us-ascii?Q?AINd9C/CxG49Isw3ywhE3BBkhRhN9MyqtcWZIXZbqxc6AidupYQyM1UmCO+y?=
 =?us-ascii?Q?oss9hcqQKUVmcTkSzW6BFfWvGL+uWh9UFzBW1wQOwz9s/+ScVUP18vJQotwF?=
 =?us-ascii?Q?wiHlMYsaN3XYc7F2KHhOQfkqB0FIruCr5gEH4tXixE4KKhvCss59HWowkOuC?=
 =?us-ascii?Q?MwNXfvZgqn9BGymct8fLFrPnR0P4uVKtVDIqAUakrcW89IMZEC+zPY89vnda?=
 =?us-ascii?Q?iNN3FTryz54q/yQLYadnqHi9qOLuQYQX+8glQdXYyugqXosAs7vJ57+EC1mW?=
 =?us-ascii?Q?Gg7m0aV1uqmyTJpXIjP58YpatMhL5WfE4H3JuWJtx0RngA1x0qlYE++c6OMU?=
 =?us-ascii?Q?f4CCAkGlAg89tF2q8cgLutnD/xH8o+aKr1jUB82TAJEd5LWs2+fM7AOItQt0?=
 =?us-ascii?Q?da2yw1zu4mzmAbGgXzfKCIet/2KVPuVxUIfUcmr5esdXMZ9JUoT1nfAX3OjC?=
 =?us-ascii?Q?Yuc5SzvPuMWI1O7TXb1Q7cDr3Vg9/l1LwO9qpzS7O9EhekSfAySmvta9H6Rj?=
 =?us-ascii?Q?3nyjqoQVM/Oot2ZKQ67OgrlkmbSKgG2sW3knMw0CS0bNley889b48rM2sb6j?=
 =?us-ascii?Q?MVSZmmTvk7jF6LALxkstCp20KaULWPIkvtzZyg1DcHlXHbgsJVWCgou8LxJH?=
 =?us-ascii?Q?cRC+BEDJG/ylQuhdq3k/4Stn/Klzq4IY/7Vxy8fFIxxi5TzFEXyTQ9+9t+Ph?=
 =?us-ascii?Q?AO5swyXLiu85rdvk9i6hXlovKZ7pDILKB81jW7fGZAEri3f/7na/PntG/JDv?=
 =?us-ascii?Q?/eqMINlFui0nPk77zUsms5i9sD9flGUR3z1AMfXEovmBY0EEzd/h6xTsY+yk?=
 =?us-ascii?Q?pgoKy4yU7qOSgE9RAwNQImCvYUYDFNPGwaXWV9ANxIXQYnqgtg24ZcLzOef5?=
 =?us-ascii?Q?e9HcAkfikt4UNne6LjoTbkbpW4UKzLTV3kfYbXOAnDkhhEjlVaM2bvXh8i5k?=
 =?us-ascii?Q?DLuzwwqlrJq75TmPY+UEM5tiYv+wWcOhabQtmhu+N6pzzOdya893pwxorBKa?=
 =?us-ascii?Q?yLLfk0hr1A6awvaxQnjpKP32a4NJ/wgokQQqzJkZxiPUJBLhMGGgp0W+E+sS?=
 =?us-ascii?Q?5PxRW6sx8cqyYSmnpBVrLL7NAk+oHfkpGPvu0+9pdmN8C+3CjXQ+AakTqdjk?=
 =?us-ascii?Q?VuUa5C9KClSUMfU8Lvo1e2k+3TeDOFm1LDBDFXXWt/sIJbJZII1m6cAxXuZw?=
 =?us-ascii?Q?1haMKSjGzDPM1cA8QvkBGYSpoXGC0cnRqUzro3oA9DTL3Q=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?iXHVtov7Cyhh+aVNr+AGtHpnddeimGLmvKnzR8YdfiamSQq66L76q9byj7Vz?=
 =?us-ascii?Q?HfzmLGzaoEb66qewQ8YXVfmrOkVdeb7GF/3/LmuuK3vU5bwCwRMVMwXjbdyu?=
 =?us-ascii?Q?ntz34/zIqbhJKIs1eTTciPTN/kR9xDIMPW+GgtKtAKG/JGDyl/W0Iu5qQrG+?=
 =?us-ascii?Q?3EmUZIV5J99Wtq2y2zEinQKCTMxmPx3eJpt0o482wXnk1dIdfEqqoRXvfZuZ?=
 =?us-ascii?Q?rcomfZvWDagor5jqOpvFpLwrnuhptGBBVz4jsNFqjTOuLY3p9sILM6bLOVjr?=
 =?us-ascii?Q?DqlgCp++uYEhe2HMJmi5p1orIIuV4mZgy6OFR/Ly8ofVgLyAv32S4zV8ALyO?=
 =?us-ascii?Q?v27gCM1JLSA5us0lyYg+WsSnw2xMQTVe44Ny4HOscno3hsC5PyEKNmCpxD5c?=
 =?us-ascii?Q?+6ksFYQ0GxNasc4HmdaDAj9s+YxLZ8eCmwtTaK4r9nA1xsXRis686kMDb063?=
 =?us-ascii?Q?CLzNiRMGDmCPpe2FiIiAGrei/Dr7k4EXdq4K8ICmum2WvOIzLnBmyS7i6FQF?=
 =?us-ascii?Q?AfWQ5WZHU3QTqKYT1ycef8vXvt1g3RM51/MBoNzrdoBA0M2cj+fXd5JsqBvv?=
 =?us-ascii?Q?Whs1ZEyfrRoXq9A/bAJy8V88X8N1iBF4zF0TlnSN1AOCJD4GiaYEZlE7L/PU?=
 =?us-ascii?Q?1pWBmc3JS7AkHr+sPEsABK2uLfaLlQLOPVgl9NNVuCCXaGAbmjOXGWWkaqPZ?=
 =?us-ascii?Q?TuFeIEABPnVruqwL7LFv4Z6fUnJPimfDMHnbpeZs9nbu/7FpFREvoZEa3wNo?=
 =?us-ascii?Q?JnZTSdq+EbRtneUe5lNyhNprPMfhZcpLRDUCpZkTb1nYCPwkF+a2mRWN04Rr?=
 =?us-ascii?Q?IvHgmdkqysleeUoVBAH1gBiFY03ZgZokRod+wep/H6TGTfP3jrompJSNnoHX?=
 =?us-ascii?Q?ODNaKtbtf1G6PCUTPvYstvDzMvngcQ8ufe3Vrko6x/3nf+sr1uCl0vKG6KBL?=
 =?us-ascii?Q?ZZQZAkU+KJo9DzCysApxLvOuPw+9C3QkI43iUbEkRDCzZhKbwcOYz4EPHUtN?=
 =?us-ascii?Q?ilc5hahqIhsbu3uJ2ZFukXL2yYH8yv3X4N5dTEldnDUqRo6MPsBLyrqw/sPw?=
 =?us-ascii?Q?3jbRJboMseNos7e8DVM0onjHi212aOtUhlHrgXdVOkzn+AQXAR8azm9dhHDn?=
 =?us-ascii?Q?wR5poPoeUCwtnhwTo9MIf8JDFYG89PvvWVvui1jsnwtMRWPxYswLTCgSbsMY?=
 =?us-ascii?Q?yaSvuoykxgh3CUHdS/6IleCTXOwVJnHWGHqP3oifAqfSwtygjzsWOEQOgz03?=
 =?us-ascii?Q?B3fzHwf/cel4JOQyBb7uknm/ErDy6Sp1ml+AEIpXrpLPXB0vF2L2Bj7L4Oxz?=
 =?us-ascii?Q?MD3erMKrOSaHYGgafww8WSa0CRBVabrY/lIWj4zqgARhHGoccD+R4yuJ5pTF?=
 =?us-ascii?Q?1ZaSuw7h2av2DbrVoV5iZy6g2KujRtrgxYTmUjrD6MCS1J4r6UEUujiGBKRS?=
 =?us-ascii?Q?kusTBY8FX82iHxMB6nkhZsYvETtdesjc3g0WhRBNSVdackx1d9Tu69pBu8tR?=
 =?us-ascii?Q?1aitqBKY2SmisxOlINV41/IVWKYCTVaMzj4g4tHvxRTYSzI1JrN66WeYeSJX?=
 =?us-ascii?Q?9NWWjFxVAJPC7QvFj6J973jbjTg5761vq3qUTt8SEv6T4xZoEhOkk/2TCUh+?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	47OrMqAA2zP+jTvIfxczwVnlWFqNkZfe8ECPtKgepKVqbJ3n3jVoojwRKPAtR/X5tVu10nikptAeleeAhmJly4Cj+xKc+9OZavOFJdN9g21rhegSaFaHKhaVLD80eqtONE3F0l7EnOlHnVCY6ZhreYuGTLHwAW+eOO8D4QOi13Hjbt7AFPHO0iusuHuIL4Iv0deQv4/gAChuBmiLgkcxBUsTTzMH0TWv4b9LPfan2kHIsrD3/x2zfmpPIrWWiKweiZaqW68ImspUF/04HQG/ZX9m2beLrgo4ivuQ6esdyzWDCTzNkOTtXYq8FJnw9o7C6ZHT80tyIQRU/Y+L6Q+zPpsP8j4rFfTLGBDpiuXhBDwFD18tiuS+aRqNp+H5t3fpYnols+IjeAYLVYpxGK0QKNVJ6ya5Ky3LhjHKfNwGMdUwCibDSTOgUMYY2FMLVwID2hNLV6xWECLc18DJMVa3J/9AAvTfm7AO1q9nXozNn4D+6o6z00WVLP79OCv1GoaZpFymWgZ7RZ1mrFrOyhJ9RquOkrYyIDLKujIbWmEKz2J9kd5Gn5mx7ubHkfUuKuVvmlctsgJju9EGFGhXpVEyrQOPLawhX14woqqTKzNearI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d15f6b1e-83df-4032-fcb5-08dca115bc9b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:23:11.1365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h0G25c6OMp3yWJJBiCbWUyPHESvhpxRv32O8MU9VAl48rZkA5Wm6irO+7jaD4QKtcsI/pkTCQtw2nIQcw5SLkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7295
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_14,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407100137
X-Proofpoint-ORIG-GUID: 3042VwgN2bpGVj4wW1pPnVHq6t3aR_cE
X-Proofpoint-GUID: 3042VwgN2bpGVj4wW1pPnVHq6t3aR_cE

Clean up the code by changing the munmap operation to use a structure
for the accounting and munmap variables.

Since remove_mt() is only called in one location and the contents will
be reduced to almost nothing.  The remains of the function can be added
to vms_complete_munmap_vmas().

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/internal.h |  6 ++++
 mm/mmap.c     | 80 +++++++++++++++++++++++++--------------------------
 2 files changed, 46 insertions(+), 40 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 43b3c99c77ba..a22547125c13 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1488,12 +1488,18 @@ struct vma_munmap_struct {
 	struct vma_iterator *vmi;
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;	/* The first vma to munmap */
+	struct vm_area_struct *prev;    /* vma before the munmap area */
+	struct vm_area_struct *next;	/* vma after the munmap area */
 	struct list_head *uf;		/* Userfaultfd list_head */
 	unsigned long start;		/* Aligned start addr (inclusive) */
 	unsigned long end;		/* Aligned end addr (exclusive) */
 	int vma_count;			/* Number of vmas that will be removed */
 	unsigned long nr_pages;		/* Number of pages being removed */
 	unsigned long locked_vm;	/* Number of locked pages */
+	unsigned long nr_accounted;	/* Number of VM_ACCOUNT pages */
+	unsigned long exec_vm;
+	unsigned long stack_vm;
+	unsigned long data_vm;
 	bool unlock;			/* Unlock after the munmap */
 };
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 1ed0720c38c5..62ff7aa10004 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -523,7 +523,8 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 	vms->unlock = unlock;
 	vms->uf = uf;
 	vms->vma_count = 0;
-	vms->nr_pages = vms->locked_vm = 0;
+	vms->nr_pages = vms->locked_vm = vms->nr_accounted = 0;
+	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
 }
 
 /*
@@ -2388,30 +2389,6 @@ struct vm_area_struct *expand_stack(struct mm_struct *mm, unsigned long addr)
 	return vma;
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
  * Get rid of page table information in the indicated region.
  *
@@ -2632,15 +2609,14 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
  * @vms: The vma munmap struct
  * @mas_detach: The maple state of the detached vmas
  *
- * This updates the mm_struct, unmaps the region, frees the resources
+ * This function updates the mm_struct, unmaps the region, frees the resources
  * used for the munmap() and may downgrade the lock - if requested.  Everything
  * needed to be done once the vma maple tree is updated.
  */
-
 static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach)
 {
-	struct vm_area_struct *prev, *next;
+	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 
 	mm = vms->mm;
@@ -2649,21 +2625,26 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
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
@@ -2711,13 +2692,14 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
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
 		/* Does it split the end? */
 		if (next->vm_end > vms->end) {
 			error = __split_vma(vms->vmi, next, vms->end, 0);
@@ -2731,6 +2713,22 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 			goto munmap_gather_failed;
 
 		vma_mark_detached(next, true);
+		nrpages = vma_pages(next);
+
+		vms->nr_pages += nrpages;
+		if (next->vm_flags & VM_LOCKED)
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
+
 		if (next->vm_flags & VM_LOCKED)
 			vms->locked_vm += vma_pages(next);
 
@@ -2754,7 +2752,9 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		BUG_ON(next->vm_start < vms->start);
 		BUG_ON(next->vm_start > vms->end);
 #endif
-	} for_each_vma_range(*(vms->vmi), next, vms->end);
+	}
+
+	vms->next = vma_next(vms->vmi);
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
-- 
2.43.0


