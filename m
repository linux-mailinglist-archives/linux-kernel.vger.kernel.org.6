Return-Path: <linux-kernel+bounces-308015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E3396561F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB4F4B21D2B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791AA15381C;
	Fri, 30 Aug 2024 04:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LnYWZXTn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MB7Dy91m"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB061531C2
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724990508; cv=fail; b=iW9KWbPR1PQ50Jth5GOJ7IfmGT0AVSjWLZ6I4nvXJzTM6jjdDK0QLWjcwWtdt2EppFwV9iC8tkoyCARIsjOCPdqt69xO5H9VVdKb7KSMHRWSYHFzKxp2CbEqfGw+UcsdE+pXUJkAfCoQ4Rv0C68NW3hO/Hgj9Lko/38Ko3ClhXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724990508; c=relaxed/simple;
	bh=OeSb3lFz41JVDt69DIlFWHGQR06sBYFOopqEYSF+X6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=npr57dIy/ySkmA1XyZodt61yaKT+22agsNtTtkIK31dTnZNH1Ln6CzYnglIOnxmOc+jjabo/FRnYR48hZZCnR0UEI8EykZkmouCjfT+HYZ/HcaZdC49kIlFIUBWH50Kyg79SbV3irMgEEL7pwOgq4F3FrZz5YdjBPHLbS+bj0VU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LnYWZXTn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MB7Dy91m; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U3MisF024297;
	Fri, 30 Aug 2024 04:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=Z5cwf34TT/HBeM8I6zt4TT5YDhHE6v+wv7dphrKLbdk=; b=
	LnYWZXTnT1mSa/Za0iAOixcVHN09eRWG/VYWOLAdyQQXQEIo6fhjXsMZ/8mIfDiL
	IVv40CjhClZOFP0/njFXLHuMrJR17YDYUk7Xy/RCZeV69JOmKvEgcz1ZqJ8HgiMt
	0zWh8nPuODeVIVwwik5/efN6w4C5WNN8gxmDXRddUHt4YmZUBVKykqFhArq9cHKr
	qKSv7YePP5mmgeZdjkpmbl+ohXIUtt66oOnKuQaJqk5E5N7Ymz+aAyCtSoql6EaX
	gjm4F4mNLav2MGxKelkY+54ClnTiV2Wed6lduuxdr0UOSxWQifsvRxbOSBekW0ki
	z2+yWBOaCeRHTYrsefk2SQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41b3myr58a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47U214vn036782;
	Fri, 30 Aug 2024 04:01:34 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4189jp2t5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tr/dZB/PefCM2I8bfpUDkZ3FZHEzab1L4ic2HahQj1jCxYLwI8ebhTpH0284Rqx3UDYKgo5ws2XFg9R/DVIS4UNRN96qBhDgllndRGoSxGOgnPzSuZesSBZZWAmzc5RCaT6ow+ZCSoUTAPuvKkTGWXFD/HQLPsu48/8/eamBzieGXDcAAlXudK5GZfanmvZiauvOyT/iU37bTefpHiUKNPcPYMf5T/4aDO3lubohEwC+gncuo9/gzq+gXvUbMIF3GChb35B6D6jSGFbhTSBVI3w75USq8PKrH9luFALEFGAgIWOqvr/AZ3zOLctJ1lm1ANZsFBIS0unCpqnYiTUYNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5cwf34TT/HBeM8I6zt4TT5YDhHE6v+wv7dphrKLbdk=;
 b=c8wNhFI66pYn5IEh7gy6hJw8SJtfiFjwqci2q2CNijMtroXmlNsRsD6RCLSJLkN9WBOSYQL0r4t0jWvIJlneHD87UL/SXQW2V43kSjlkOx5cFjkGnIT1kDAOgJNH1b8DLDpa6wSIQLcoUJEU6EXymhYODPxHW2vCbpEYvhjgFr8jnhcOty+ddQAtWqe0SAW7CTKQHc5VOLH9IQIFNiPTWV1HGciO36hJmjhuEIYA5EDjlNZs87g1bxNtYJnIev5oHW4lZif+vY5joPhtUTVm4ielLzODxHihqn2kMvgyf5R9TpcUMuHzvqezZA9PkGkmzbb5N7OMM8ycFjXo5l/WRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5cwf34TT/HBeM8I6zt4TT5YDhHE6v+wv7dphrKLbdk=;
 b=MB7Dy91mgCFvQnq0Hfk2AU0+on+wPiCv2VJJO25lnu/P2S9wGOaCD+fnFJQgMsXt52KTbrXCt3Ko17jQwChzEqxYUcRfxrpAuVac4SzC3dr+dq1LU6tCV6J2PQJnCuE3wQcKkIhnVRgL9CDqMoBznwNVlZEJCB7yqPP+hLhveGY=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CYXPR10MB7949.namprd10.prod.outlook.com (2603:10b6:930:e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 04:01:32 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 04:01:32 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v8 11/21] mm/mmap: Reposition vma iterator in mmap_region()
Date: Fri, 30 Aug 2024 00:00:51 -0400
Message-ID: <20240830040101.822209-12-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830040101.822209-1-Liam.Howlett@oracle.com>
References: <20240830040101.822209-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::10) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CYXPR10MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a94a7cf-43ea-492c-90bc-08dcc8a86eee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aQrSZO4bo+Z0caHDATn3gCUeWndpZtqv+bu40fbEQv2y0lacN9sXsjOx7syO?=
 =?us-ascii?Q?7QRKknEZrTDlsk07fC3uc2TjX6mZTjwQ5ITyKhnS3JzPmhKxToqtv+wS/We1?=
 =?us-ascii?Q?+34+eBIkezkUYoHFgvRFwkBHzVAqHLpdDcG+zPys4w4EU1X/V4X27TDao1Aq?=
 =?us-ascii?Q?ttgUMbEbK2UZvKOEKagC8vV/mLnFX4sbW4fPS8yJqoH/b7aDJ3IIRZILJVwS?=
 =?us-ascii?Q?JmKMFkiNWc6D3wZpAjQ/FmALLj77StuODhn86SbplyWtRz/KGqvGTNfwPiy7?=
 =?us-ascii?Q?BsFRlc2GTFA4ZJnbgLMUYLTTwT3pZVojgx7+giDYIHWJfzmFg0cDU5LoJL7q?=
 =?us-ascii?Q?tN1jDt6BERyOaL7C4XtvuxNvkoL854sSrdoOmBfNq32OcYFaB49ltTSQdraC?=
 =?us-ascii?Q?J7VFKmz0ABmnEhBjit0yYDLputZiCuBH1eBc+EcaYprFRiYT077DR1cyfzl7?=
 =?us-ascii?Q?k1hudcwYdWNCt6ZKzCQIDAs+PtgQlBofgw4cQ+ttaYgvKIlefft8p2el589d?=
 =?us-ascii?Q?MCZmAuUjGkQtAwq/Sk9MkUVgpJBU23gVl07XbTHbyuWQ7FnnVZ/DHp3o3PpK?=
 =?us-ascii?Q?KiPOAczMsznrsD0JMO49OXInJRni1abNuOHl8dmGByVZYTNjWRWEVqRoStQK?=
 =?us-ascii?Q?dguYBxUNWevA6/fRR+DdxCZRldbQDtVjHugm2lYz8lMFQ/H1p13a7g2ZKYU5?=
 =?us-ascii?Q?2ViCHh4bVtOaai5a38pG5rk2Esc8XhEmN8Ggr9z+zYOmYzf9hJaAufkQGsml?=
 =?us-ascii?Q?rviVowwZSNPRuV6SYzHAvBV7RdQh2iIAwpS0yKQYhU4xYeL2YjqE4WHM+c6a?=
 =?us-ascii?Q?VLsGR+o05AvW58tAjYjLSCGBPr0g9z4z//ZGL13nR8JAbjfeJty+pNbAGbQw?=
 =?us-ascii?Q?2swilOCRyHNkyhzUom4o2De8JaoHE6GadMcE5pCJhjkqxw/LQu+VGZpdf2FH?=
 =?us-ascii?Q?kNJJ6xkAgBTIogLQLEOKovW5whPm1SktzIFhW4o/S0CX58oegCBTQmR/fyGO?=
 =?us-ascii?Q?gRq04mKQ+nY6swuY8a2okmQqn3xYt505T/oybuDovy90FuLjQ2uYqV2M08uE?=
 =?us-ascii?Q?B6FxWU96h6rHle+lEO9TDFLKlyqYQC/wbA+uBBw/eLktS9TPi3Sq6C9dTuFm?=
 =?us-ascii?Q?P2hVS6I8ojSDjw9fY2E7POmp0ZBafFxfQhs4xTiF5iiuOMz9xEm6JyIXJ+Rq?=
 =?us-ascii?Q?ATek3mX4dj5HE0wIJNF8M2NFZw/kJ0+uKnaOxKMxrwot2HFtSl2RQ4/GLR9x?=
 =?us-ascii?Q?uLAiovu6ZoI+t198x4+T56hhr9JQ/JPmYtAvNxGPqY3CRWAE+XZRMKVKuFlg?=
 =?us-ascii?Q?3TNX+YKjVzdqIQdBqFD8KR3Pg1BxmWskvFdpyLjQOSkehg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9yGohlGTaQ224JXYldn/QNgnOrd+gAwcZApYetqM7BPlvMT79a5jrPErBh69?=
 =?us-ascii?Q?2DNv3UuYqAuMzGqo/RFLOzMHAxzW3HqakNyfMabYm777FXEdKRuPyjQvNQ61?=
 =?us-ascii?Q?Zzn+luIzYvIJuNDJ97lSreTA7++Sv2iX/sya3pY+jEeEqBBLQYY6SYrKRfiZ?=
 =?us-ascii?Q?uQe/koa54ZkgmwNuecDJOrC+wjzVL8X2hFBRomSrLPoRO88po+6HnUMrdsAY?=
 =?us-ascii?Q?h+lTUbV3vHRrZP4LOMG6InfsvZxE3k9bkmWIHarfTcZYBEJK3xC5a2e1ivbx?=
 =?us-ascii?Q?3QNiAVcUav5QKe1XFKtbQY6pzBaF8A/Djfr26JRqMHldHWeK3SUj4ZWqDIfy?=
 =?us-ascii?Q?kGUEk0v/3nWRlzF6zaaDfq2q1Ybj7wHz1xMrfx5KPDv+YhIJ0ZsidpTTypeB?=
 =?us-ascii?Q?EYrPZt9J1U2v1d1uP7mVwCvHwkRgdgOvVVhpbo0oMRMv8x9R21UQDsjvlyuG?=
 =?us-ascii?Q?nT73biz7GfoMAqwyRdy8c9qUR0RLPWIyRo2p6sn7hvV/Jj1Yr1Ku84I0X+qb?=
 =?us-ascii?Q?VFRHAcsKDsEqC/N0G8jhFS0GDYOrJEbWlag4LnisGIGT9w102m32EPVyMr+m?=
 =?us-ascii?Q?AosRwUKzTfqjC/ZFZAa/yuvwaW1342nrPpCFRUiMpZVN9P80MJ5w2Y8ftz0r?=
 =?us-ascii?Q?3pO/wxq8jkmbImHzH+NwgFJuwWMNQ1XxLZa+oci6aDr+s+bn35WKnIGOfG1e?=
 =?us-ascii?Q?fZE7yvlP1KCugp1dsu10uwGkGT3ND53lPYq42YwqyEkNlujiHR6UPyo2l1xl?=
 =?us-ascii?Q?UK0npxDitZWKujF7AgF5gofHcIU0qcUMSkCS4m5uBNrWZHfN3XTfUuSTXcXv?=
 =?us-ascii?Q?dXI5F1ZSpk0hkDIzMBcocB93uaoGz0pB0HIHeKbot/AvGmOY9XOh+eCUYNDE?=
 =?us-ascii?Q?TvIBrv0QoZH6EkUbZ8GfaFof5nxdBwSpWq5hSGn8HNBQvMOwomfYXAmConq8?=
 =?us-ascii?Q?4IWop0lr6IhDR+43D9EYQuWrp+pR3IcFnsxM5v9ZQH8nrYYQXTBP9oS/4bwF?=
 =?us-ascii?Q?xoI4frbTog5itFWasL0pBawauEHAIY9ZoPvR0d/d8ie9sYDeMWcTLrUPLcHM?=
 =?us-ascii?Q?9zB204w1+aLhxit5WZWyewvoC5aCFBnfteTzlK+Zo87wothiUa4YQ/K4LR4U?=
 =?us-ascii?Q?+GNuwM9Z+9Ojc6znhg3OfKr7ge3cMX7A1/XkZumOqP4oyTov00Jy+Z0qARuT?=
 =?us-ascii?Q?rR1Jxlrj0L8P2HBKNYFyBe5GwDcrkTvbGHsAOxIth4TRjEqyd7/OYvYEAguR?=
 =?us-ascii?Q?WWu5N/aPUvMmFc2Kyxv+Lof9pme8Kzjkh3wguoamaR3GxlW37CghMyTwRgo6?=
 =?us-ascii?Q?vcE125/xhx1i169z5cogmJUju8CrPnK745oO9MeNYdNl0VeT4otpXEBk86Dr?=
 =?us-ascii?Q?NqrVlBv82WI0591kO1kCgEQ+YSrhbqMrXhFXATzQ7YuyHsyv7mwHd4ZPZ1b8?=
 =?us-ascii?Q?/ZltZME0OrKUHRujlaRzP7bhN7Loq6wVk9SFrYRFoeTg9Kh6k1LZ2ICxUJCk?=
 =?us-ascii?Q?5988VfkhLqbiT64NnCGAP4Y/fMyOkToWE2eIqtORNWm0SNPYcZt5Nye0oQwU?=
 =?us-ascii?Q?fj7Pwib8NxLgYXTKWoMmL898g3JuNKDgImDCtvJdTll8MLIoubLXe0DfVmA2?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6/pTG9Ih3/6rPluHLI0EdVWbPUEGSXYm7HnAm3AFGOOv7DnJbmhiUL1hL4flPU43zcGK47H8HxSu8iipO13OpZ+TXCErSSxWhWf8zHaevIpNhIlGAojXULXee38iS/AwXG027trJ6RqN4XRGqCjrR9d8dn5+5K2Z+EHuYqpSkhRaSqPwTc1JBSXqylZBqQqE2pbMgY6c5krPuy969hyhTv+2TMbruSXNP3otaNvfScp4e0n/pCj/dYTcOKQQa22lS01Ss9GJXvx4oVybmiVYOQISNZ9gpq43PIemeHXP9EuxdQ0SNBfcFR+IvMaBvH/wRiGieU6G/9weKlWHebixotRacajAq0kMnVJ3h3IWeMcK7QKjaZAywMemFdAUZrYv7975223VDTE42BP4vBDhQczGksu6k04SxgIVPjdvkJ1OHAs92yLmvPv25yK3lefzKH3F+hwj815LDh8UdqgbP/RI7aXCWWcJsjmyy79TDSHFyn9WzDpC2SsT6Oy/0KNqSxFkVLmD/eZk7NHwZ8Lr22MNd6rfzw5KLOkdwJodmueMVkiXD0JF42s5RWdoVKheqES7lOjFmNxpG7ExkCYJSMF9qjR+KSl85IKJc4O5Jug=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a94a7cf-43ea-492c-90bc-08dcc8a86eee
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 04:01:32.1919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51VkXatDBUx0xj2L+ZHWhw1HmiHJIiijKsV8IWFBj+2SU3odNm+HgYi6e7jt8/dt+RH1BO9ngcgjcEHEFkQXjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7949
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300028
X-Proofpoint-GUID: 1yByl6WiA1mCMZ-3n6MHi3MfmF4MCiq2
X-Proofpoint-ORIG-GUID: 1yByl6WiA1mCMZ-3n6MHi3MfmF4MCiq2

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Instead of moving (or leaving) the vma iterator pointing at the previous
vma, leave it pointing at the insert location.  Pointing the vma
iterator at the insert location allows for a cleaner walk of the vma
tree for MAP_FIXED and the no expansion cases.

The vma_prev() call in the case of merging the previous vma is
equivalent to vma_iter_prev_range(), since the vma iterator will be
pointing to the location just before the previous vma.

This change needs to export abort_munmap_vmas() from mm/vma.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 40 +++++++++++++++++++++++-----------------
 mm/vma.c  | 16 ----------------
 mm/vma.h  | 16 ++++++++++++++++
 3 files changed, 39 insertions(+), 33 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index ac348ae933ba..08cf9199f314 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1401,21 +1401,23 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		/* Prepare to unmap any existing mapping in the area */
 		error = vms_gather_munmap_vmas(&vms, &mas_detach);
 		if (error)
-			return error;
+			goto gather_failed;
 
 		/* Remove any existing mappings from the vma tree */
-		if (vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL))
-			return -ENOMEM;
+		error = vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL);
+		if (error)
+			goto clear_tree_failed;
 
 		/* Unmap any existing mapping in the area */
 		vms_complete_munmap_vmas(&vms, &mas_detach);
 		next = vms.next;
 		prev = vms.prev;
-		vma_prev(&vmi);
 		vma = NULL;
 	} else {
 		next = vma_next(&vmi);
 		prev = vma_prev(&vmi);
+		if (prev)
+			vma_iter_next_range(&vmi);
 	}
 
 	/*
@@ -1428,11 +1430,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vm_flags |= VM_ACCOUNT;
 	}
 
-	if (vm_flags & VM_SPECIAL) {
-		if (prev)
-			vma_iter_next_range(&vmi);
+	if (vm_flags & VM_SPECIAL)
 		goto cannot_expand;
-	}
 
 	/* Attempt to expand an old mapping */
 	/* Check next */
@@ -1453,19 +1452,21 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		merge_start = prev->vm_start;
 		vma = prev;
 		vm_pgoff = prev->vm_pgoff;
-	} else if (prev) {
-		vma_iter_next_range(&vmi);
+		vma_prev(&vmi); /* Equivalent to going to the previous range */
 	}
 
-	/* Actually expand, if possible */
-	if (vma &&
-	    !vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
-		khugepaged_enter_vma(vma, vm_flags);
-		goto expanded;
+	if (vma) {
+		/* Actually expand, if possible */
+		if (!vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
+			khugepaged_enter_vma(vma, vm_flags);
+			goto expanded;
+		}
+
+		/* If the expand fails, then reposition the vma iterator */
+		if (unlikely(vma == prev))
+			vma_iter_set(&vmi, addr);
 	}
 
-	if (vma == prev)
-		vma_iter_set(&vmi, addr);
 cannot_expand:
 
 	/*
@@ -1624,6 +1625,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
+
+clear_tree_failed:
+	if (vms.vma_count)
+		abort_munmap_vmas(&mas_detach);
+gather_failed:
 	validate_mm(mm);
 	return error;
 }
diff --git a/mm/vma.c b/mm/vma.c
index fc425eb34bf7..5e0ed5d63877 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -646,22 +646,6 @@ void vma_complete(struct vma_prepare *vp,
 		uprobe_mmap(vp->insert);
 }
 
-/*
- * abort_munmap_vmas - Undo any munmap work and free resources
- *
- * Reattach any detached vmas and free up the maple tree used to track the vmas.
- */
-static inline void abort_munmap_vmas(struct ma_state *mas_detach)
-{
-	struct vm_area_struct *vma;
-
-	mas_set(mas_detach, 0);
-	mas_for_each(mas_detach, vma, ULONG_MAX)
-		vma_mark_detached(vma, false);
-
-	__mt_destroy(mas_detach->tree);
-}
-
 /*
  * vms_complete_munmap_vmas() - Finish the munmap() operation
  * @vms: The vma munmap struct
diff --git a/mm/vma.h b/mm/vma.h
index 0e214bbf443e..c85fc7c888a8 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -116,6 +116,22 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach);
 
+/*
+ * abort_munmap_vmas - Undo any munmap work and free resources
+ *
+ * Reattach any detached vmas and free up the maple tree used to track the vmas.
+ */
+static inline void abort_munmap_vmas(struct ma_state *mas_detach)
+{
+	struct vm_area_struct *vma;
+
+	mas_set(mas_detach, 0);
+	mas_for_each(mas_detach, vma, ULONG_MAX)
+		vma_mark_detached(vma, false);
+
+	__mt_destroy(mas_detach->tree);
+}
+
 int
 do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
-- 
2.43.0


