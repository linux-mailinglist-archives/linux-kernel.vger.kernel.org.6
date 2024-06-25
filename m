Return-Path: <linux-kernel+bounces-229578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD63917103
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 349961F21873
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2397317E91D;
	Tue, 25 Jun 2024 19:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UpOhjxAW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UXnLlavu"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4182617E8E0
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 19:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719342752; cv=fail; b=T4tDOwXArAZO2xVgwR4w9apz0QzWJqQsNimBGZn7vQdA6OQY06IrDrj+ff1oGUhSZujBSiDVKfSQLncSaXFX33CCgx1P+tvZGcuoTggOnkuUhqAUDdQ2ov7SmEo7Ab9Fm6R3im1rmp85Ipnge14doOJRZcevjiuRJcSSEPLYdQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719342752; c=relaxed/simple;
	bh=oDBMVYHTcYtDh4kArExKPcPSWncWOesvx1wjXsFHeSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WyLFMnN6gHgwmX3LjYJcNa7YtDmSFeyc5cWNysPYF49vjVS2t6q613LnZasaOrNAiWwXmwUAicAf1zqOjVSPMrrUvVWucFYrDuKlXlLG00qPpnjqxWqsbEpqI/OHs3rmRQf329iw1rhNr2flZGd309hQjUuF8qamawZwueUhJNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UpOhjxAW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UXnLlavu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PIfXbf021444;
	Tue, 25 Jun 2024 19:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=1pO27aodtfvC8X+gLBZpKTNrexrYAjXEivQorvyFbrQ=; b=
	UpOhjxAW4BbjWLH2YPy77DKK6mw3HwrM6gYp7K5hx98+Lzldd4b6wN4E9eLB0L6v
	uO+fO0EN74wB7prIL+cXDNOIQDKytRDHoaNgAElQN/HG3y5B0zYeLKtEyDI1Sl+F
	gzZtC81MbDYruaaUCos9kehrO30Ja4mB6/y+1nbgeXVgKYFwJ0REGURb6+cP0F3K
	AVg8VpGhcJzqX5WDjlY80RPnbqUHAQcf5q4jKHV/0btfrGDCDzZs7Lptu1m3dY7h
	18NW6E7BrYaljIM3vfWoZ/vWpD/2q4XeI7vCuAtLbwL//IU2FcgbrZQxMDsJ1Udy
	hy32T/n8+jhP5xoq0LRbxQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywpg99avn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 19:12:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45PIWuu7011498;
	Tue, 25 Jun 2024 19:12:20 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2egtu9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 19:12:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bI7IsMAlUkALICVZV47uE65hpdNqbJqOWfFOoyvD7BDWrPwH0lb6ldWkZpg9ndq+L+Z0mqR6tjIAOmg77xjHklmOZsFn1DYDZ7VkyOh+tGz+tXc3jGuknyub0AumFRqqAXAeyX7SDnB0jWVL/nbq56erKBh8xCjwrVFc0qLCNLcWTKkMlf5Q31lYfe5aCRaDisQwT1zvk5vqm/xX1EGE8WTpruHnrobG6Z7aISKvZzN9YOXI/+w3LklVdGsbE0DAsiG84K6WJZHvLc9viIdb4AdmvR9SO0zvPt0UTEKbKRi7pgI9dYv73IDzDoYVD8LLaQBCBcUPQL0ia9PDW8HuVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pO27aodtfvC8X+gLBZpKTNrexrYAjXEivQorvyFbrQ=;
 b=OzyPTK8gn0KQyFcLXpzTHmar08TcKQ0AQZJzAjNA1xCejW0k/f1LzdskogxbphqirtLWPptM7hkMiktgX/JdJrl5BrUz+OW3yzFAMb1a8+BkP/ClI1jQoZVYD8Z7ApP9JmVeJOCrzi08SnXMBFOXj4Ty0zAbg3+MIiIGuxfcv89ksoIyYhaKioNZ3z5hQjamkkPsawoKoimYRsxjMy56xpmIxAeQ3xCyeTY4hJACvy/MkQkuvIfCtdrSRcMjQsxWUJMV0ZDXeKyiz8KH3+A1WT9mHlfx7BLpn7ydSz/9afVpv7xzUmEUQ2d71diSyeoS81/emuSoRZ2BX2LacIe42Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pO27aodtfvC8X+gLBZpKTNrexrYAjXEivQorvyFbrQ=;
 b=UXnLlavuGJI6Qz6uxUskuLiVgRKheu9dvuRXVv4uNR4CNVX5Wr+TFhnVNEma30TUUtS5MWhJ2LRLjYRXHy3iEBlvytI4Sn/2Yo0zLsX3ApdxYpO0gVtFbBT6mtfmQYncOcQDTj1YGmGMyc6JR0cVSnLESl1xMIhEkqLcgqs+H2k=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS0PR10MB7066.namprd10.prod.outlook.com (2603:10b6:8:140::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Tue, 25 Jun
 2024 19:12:18 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 19:12:18 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v2 13/15] mm/mmap: Use PHYS_PFN in mmap_region()
Date: Tue, 25 Jun 2024 15:11:43 -0400
Message-ID: <20240625191145.3382793-14-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
References: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::26) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS0PR10MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: 31b9780a-7e65-4eca-787d-08dc954abb88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|7416012|1800799022;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Hhu3ERdUxZxhPQbOqNZKcJjZRZFI/3UYyQ1Ym7kR8Y1NfjO3Jy03boiNHht2?=
 =?us-ascii?Q?lCUssHh4jg88udvP2JtjGhgAn7RUMd24HfXRHSpimraal9GKKCnY2nyZpQfj?=
 =?us-ascii?Q?bB2v8ulcb9OE54khW5AwaS8Ic6Q+nk45gzNwmYsrCViSYTcOQqFpDlHGieD/?=
 =?us-ascii?Q?iuFFesZTjWWK+yTPDtRTYmiHNqefubyUmG2kCRhSIRz2yltb3Qwr2XDfAT7h?=
 =?us-ascii?Q?BqxKuFI/0kqOcAvN3vHJo0f/Hk82o7gTSQvSh+Lx30V/ETyqiZsJAhIFoVnn?=
 =?us-ascii?Q?7EroTQVHiQAMPFWioEBWHEbi9cXt9DL2x36dpkEIISWp1Uza6FUQO9rNm51L?=
 =?us-ascii?Q?mk1NGrkbmF8pbmMlRhY76tRCTG2qHGOZJ0aGEIeyN+ZPHKHgCCwx6pMKru0O?=
 =?us-ascii?Q?0+bziIod1dl9vjRzphP1hX5LDChDJkkMWZpGD2bMLnUMtZz+rfTLYoMZeTD2?=
 =?us-ascii?Q?HKCPXQw5Qxi94zepfhXMr9dY5byAkFheVJqUrUaggHIJg2R4hDvzufGyr81+?=
 =?us-ascii?Q?MrTzmMnVUKrug7zsy3uoO1pcvqRWymQVZa0qmJmzLXsXI13w2X1ZnIiSZYA4?=
 =?us-ascii?Q?n13MP+ymONWK3RS2dK7ixx7ZLHyWiG0pJYnT0CF/D/GpqL8vKvZ+3sVMoZwk?=
 =?us-ascii?Q?6Eff4dECmgHwEwJHlN8ffrgio69udCjcVa/9Y92a8Z+MU4fEaywkKNAMSaK6?=
 =?us-ascii?Q?FGygn+A9n7znRX+SlctiGPL3WlJJDdQYNvmMEQ5KkD4SWkn8h7vMtPHdszvD?=
 =?us-ascii?Q?VBx0pooWl2P/8UymA0GECPvNDd3MlZVmkfKC9rCdxMLd+HsHTS9DPv4leiwZ?=
 =?us-ascii?Q?/CqPaLtYKe/yHKIHlTLsKSIBIIi76QmEVdGTrKuC9BAXngYCT3Tl0BqQHvXN?=
 =?us-ascii?Q?TdVY6wCLWj5aKKUk6ozVRAWWqOC0atVjuf+zN3MHp0dVMq4H8PCi0hXFEg7P?=
 =?us-ascii?Q?iVyVOQ1Mz5CMag1Sc2o+BKqdz0mcFfNwE5FsIqLfiIXGjYj/t6w9trqBpvSO?=
 =?us-ascii?Q?1wLNiQfMS8JgXUZ6LaJ8gI3YWTxU09lFjJ5WVQspZ9FjKqld5bmCXitZI5d8?=
 =?us-ascii?Q?BkBYTNHt8OLf7X4COL2NEcgNpqReKDvFl8ZftqcA3SoZ3xiM2G7jBnVAkfD5?=
 =?us-ascii?Q?dx7O63PBB2KH8NHDpwFRb/iaLCBbvUJL3ZafXKbfAaP73atMP5vTJyyelxgV?=
 =?us-ascii?Q?imvoDadzxyTEJeCInZc2sf8QyF2qy09/Ncojn1ILenzDMabm9KNWP/v/MXFr?=
 =?us-ascii?Q?GqekAD64lNFjBP6h2Xt/CylfkrzqkfePRRS9+P8o5h9PtA99mvCINo6dEa2d?=
 =?us-ascii?Q?EiyQT99HqiS1Styfa2BWg2eUMpjPNXhhI1fV2WZVODCLIg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(7416012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9ItaIP+0qm2fBoILK/dcY4VsNcp94JGEO1FqMhvfpiNreu9G4YXJgufKEns5?=
 =?us-ascii?Q?XbdTCES6uR5k6M6ztLyMNMWmREi4awruZ5Hj1cku9g4alZdGZ3ONaCT10nD4?=
 =?us-ascii?Q?8l/UQGaYP7pagM0xuRiDDrVs9zS1AHaVZKs3VVrr68BbuLCIQTgxlwezr67m?=
 =?us-ascii?Q?TLKp+5yXEUE/p79vN3thhPUoTwtVWtf20h+IDZ5k4Dx9807vkPZ+3qICOHjV?=
 =?us-ascii?Q?4XfFW3p+jGINOuijAx1qblvoAjDUjMcDZS4xBNPq99ae4a1JPTCK/h9BEcZg?=
 =?us-ascii?Q?kNFfItHJmhklWViIBpFDMtbq/fmwF24hXO67HhgNlBvJqgPUgJwbl5E8lFWo?=
 =?us-ascii?Q?yZkuxSUUkmk0SDaKTDsNT7JjD07cjnYoGZh/9txNIQtfHubi5iHUrebCXpCq?=
 =?us-ascii?Q?AERhf5rbxc83In0DvOLNhO7WIeWXWCAIBjA/NtOoPTC0bDG1OcdVFHSnxhs8?=
 =?us-ascii?Q?Je9qmBPAbp6A0XP7owl7YmtkZt7VqIarxDzcGCDSup++NmheVedN8FBUDT0x?=
 =?us-ascii?Q?mj20uYBdt08Y30/O8XMsgXg/yL9XCo9nnmwXTwft9Mx2w//EQyq0HzERgh+1?=
 =?us-ascii?Q?iU/QCWpijWZwBwIZAygKzTQLp418qouEGhO//HNxroXzEWgBRjYm6pjYOLWH?=
 =?us-ascii?Q?RQvV3DHpUfpzpoYxXB5iCWvEV+klJ9g2Prk3o48c/kRrmB3KjVLsYrsZY5Sp?=
 =?us-ascii?Q?65gfKPl42mGZ+CtCjorB+dubhcSRRKjFNt8mVwIhTTsIIctgs9bjb1MDs7eT?=
 =?us-ascii?Q?cH5XynQl/cuOUcKlVKDqUpIDcuFMzBUZPbdiNNhJAPja6q+YjS9VNL+xNgE7?=
 =?us-ascii?Q?fRT5DV0BHzFznElTtaJh6MeLa3r8z5facnabJoTxIJuixfVGYo1HabUz6kYZ?=
 =?us-ascii?Q?v0UY5kEzRaN2k2zVi6xLg0NamdEAvpF4Zxalac5ejNHYWES7SI+yMtblJcq5?=
 =?us-ascii?Q?UxsWRxF7gvuoBUSqijEOjP7/+xYzw6xTKHd3KXBT1v1xQZeGFVKDmXule/ZS?=
 =?us-ascii?Q?9Op1Nt7fyprvdwhYFsCj3oXVookx12CgRSglAEQzKQoQq/EbvePq58TWi+qG?=
 =?us-ascii?Q?U8Nwnt7aj+GBBNKabQdN9kbKQ8U10FSRjODA40EoTOsD4wcYNABIH8SWqPgf?=
 =?us-ascii?Q?f36cBjugkGQlfQmb0XExUeY3Ksw0fOEH+es6FH2L8bICLQS43J5uyZU31CG0?=
 =?us-ascii?Q?DmRw8HHEVIgLxwpDx1vXk7EQ6NB+gvPBFOYMgZq/d7FNM6l6P3norxJyH4/O?=
 =?us-ascii?Q?EssSqSsOpvlGj3Ppyag3KOwOzyomUw3dnGrSOuP721R0zotMctbET5AiJ9LC?=
 =?us-ascii?Q?JUviAYWllP8Aq7Nya4gmWlvPLkou3iy3CMNzJJN/MFs14iSSyV3Ebczt1cQS?=
 =?us-ascii?Q?X56hu11Z1OIpKr4kFEM1ZXC9YGSyW9/daIt65Q4waL61+KIUHDFidRINSOgF?=
 =?us-ascii?Q?+lCfgtAqnWUfh5zF8W6BM3Nqg87FRAfqeFePObRklu7S+yR6kbQ0zcsXPkgX?=
 =?us-ascii?Q?7uOviEIlqGaJSmO+S7UbCcoCWEfAPjX/hnLv3ljG8KOIlt/bskFKEHR/Xnyh?=
 =?us-ascii?Q?YTCdviTuqlPktiAsFfA0P35hp8RnCWH2fknw3YVPylIOTFWaTRe1nZZ0S7kC?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lmOp8zGtp/vYBlqYgrzUL5H9at16r1PgZ9xoaMo9PqaD/4T/PZ4/oA4ijQmurLixNuDNjJ8f2pZkwDkdPacEC7ySTL2Pj6DSuWrq0e56/4pcvLG2W/55pRMxAeIKxAtghR7t9zr5f5PCpVSJycYLJ+dd0XTRln0J31uAJCP+0nYwnWMACHFf7ERwiC4pXPO3Ff9+YrxhPn9f/zHbEiMO+Y/ebYBsLwoU/hW3Ib4QMhBcy9PXXBkOE/z4xJkjq4CIxqX+ZS6iQHAjec7wybWz9sHJgkOOJyYoqpBLejj7DKyN2/WIEq7MyaH0V7r3pc7fgQLeDGD9DDofEwI4QmfYnV13G/G4x/o8/jr82deu2e0/ecrCNZb7DUjxtKM86X1uW+bnkoO1LIIZHu0Ln/jQbDCg5J552KY7LdXWv1PEOe5vZ2yM3CYos1PMmY5/4IIuqJkVg/22j8sGCOeAwnkug66NiO3Bzsk/ZnDZ4h8Ltqjytc68nOCqiHha5Da2YVyWNMAG3BDdL+RR4Y5pnfZlPqOgIq/YZrvDeYi3bd+v+hpBmvt7dBiDNZGo1EAOqf/S2L0P4rkYnTnyANwKUgethaxeeEPoMYyCxFiGlV5PEPE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b9780a-7e65-4eca-787d-08dc954abb88
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 19:12:18.7167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4UPJssrBMFEdKzpU2KaubEg0Gf49c6duCKRrdG9SPu0wCiztM6gY6v8+zigYZ7BDVqDLgY3TgX55vTH1YzECA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7066
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_14,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406250141
X-Proofpoint-ORIG-GUID: eol9UYN4NX4KRhF6moniVmPqXSffVbOv
X-Proofpoint-GUID: eol9UYN4NX4KRhF6moniVmPqXSffVbOv

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Instead of shifting the length by PAGE_SIZE, use PHYS_PFN.  Also use the
existing local variable everywhere instead of some of the time.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index b7f47964aaf0..f3edabf83975 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2925,7 +2925,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
 	struct vm_area_struct *next, *prev, *merge;
-	pgoff_t pglen = len >> PAGE_SHIFT;
+	pgoff_t pglen = PHYS_PFN(len);
 	unsigned long charged = 0;
 	struct vma_munmap_struct vms;
 	struct ma_state mas_detach;
@@ -2945,7 +2945,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 * MAP_FIXED may remove pages of mappings that intersects with requested
 	 * mapping. Account for the pages it would unmap.
 	 */
-	if (!may_expand_vm(mm, vm_flags, (len >> PAGE_SHIFT) - nr_pages))
+	if (!may_expand_vm(mm, vm_flags, pglen - nr_pages))
 		return -ENOMEM;
 
 	if (unlikely(!can_modify_mm(mm, addr, end)))
@@ -2980,7 +2980,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 * Private writable mapping: check memory availability
 	 */
 	if (accountable_mapping(file, vm_flags)) {
-		charged = len >> PAGE_SHIFT;
+		charged = pglen;
 		charged -= nr_accounted;
 		if (security_vm_enough_memory_mm(mm, charged))
 			goto abort_munmap;
@@ -3144,14 +3144,14 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	if (vms.nr_pages)
 		vms_complete_munmap_vmas(&vms, &mas_detach);
 
-	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
+	vm_stat_account(mm, vm_flags, pglen);
 	if (vm_flags & VM_LOCKED) {
 		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
 					is_vm_hugetlb_page(vma) ||
 					vma == get_gate_vma(current->mm))
 			vm_flags_clear(vma, VM_LOCKED_MASK);
 		else
-			mm->locked_vm += (len >> PAGE_SHIFT);
+			mm->locked_vm += pglen;
 	}
 
 	if (file)
-- 
2.43.0


