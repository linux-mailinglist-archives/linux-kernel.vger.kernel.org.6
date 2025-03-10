Return-Path: <linux-kernel+bounces-554844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA150A5A1AE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B770188D990
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054FA2309B0;
	Mon, 10 Mar 2025 18:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NOloXSFH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="muGGR9Qx"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2CB2206BD
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 18:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630187; cv=fail; b=ubZcUOhiBrqMy/+cjhtABYKGp7yt91ZDBoPa4nE2l6iyyqTRcwFCbMPbM5RVVPHheJLjo+bog0ozHr7HIw5Ck0bk1PGRgcjVgjo87hJJbLZv8z5SOh0eW8oIKSSiwPTBwg2C9evMqu7x0ERACB08rK7Xv3JWXLN7dYXbVOeE4ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630187; c=relaxed/simple;
	bh=MDtg4jVOgx1jokYtjyYaRQERjXAmH3qjpGdm4fT8R20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LxeEWz0tU+ADkFZrMasMVhel0O+7vsWG42T34dws1IvohIOthbDYK8bRiKlQWk46aZUk4OVAzlOZi42MMRafg4bj9aesq3naFELEw23rPm64PorVhCr47/bI3MP5ZdYgnrwn9d1V6AJ4HCRWSab9MYDpD3qudXLsId4dqqw4Ij0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NOloXSFH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=muGGR9Qx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AGfkHW005924;
	Mon, 10 Mar 2025 18:09:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=6Rod60qytNhQ4s/FVI
	mnISfhkDEp3/Mh77GuT04Cc6I=; b=NOloXSFHsgVeV2H4rgG6AVOWqaSwmRHNvW
	3uDPmLTAryUGir8a5zgIydsWBRC+0qL7yxHCQidFCMEmPzAV2thzM+jpSrE+WoE0
	GeVY7rZif8eH06P0w+JEtEur9oIe5u6G/XvbISd6EOAyAUhQB7jDFCP6wIc7/pe/
	WgZdtzz5z5pMgdUv4dU8erwqpJw8U8RXp+8BI+oDny6N6u8U5S2RBFEV3DJj5XIr
	xuHnDRHoBhPVkbREXUXC0r4vKsOJ8ztShBhuCojIXGmaKteDK1JkVGrol1iczed0
	uEZvUXTJ/ZENkQFz9S6O0p8Fcacj4NM0BssTyPlzG7a8qBNnhR9g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458cg0u9aq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 18:09:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52AI5qAo019356;
	Mon, 10 Mar 2025 18:09:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 458cbefth3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 18:09:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8A6Ev2k5Zrm+OkyZfJZ3msUeUabTMr37wMJDbi5ZjJ9O1KB7kQUBUWWIBe7FF30opvaPVFs2yKgVPPt9UfLkwSA6+1/zKlGEE4fdzCWHIhgkX+YxUoa6OmS3zyUHJRd15TXucDzvcbMvFh68Lk1XOHhLP5XDQnZBMMSs6qXGXShjVM3mZeaPpK4PBD/EbzuwuhILKPoT5hs9qLPDAMI4fp787Bppf55xQXCcDHm6axHzwXTQfzEW5RPFECAx1xl4TtTrdnq9S0fQHX8A1Jsv9TwtqXWQDMPIj/c1CpUreR6nth/htwI9Yp7GeWgkGZfkcKoatI+ZVatYkw/xiGHrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Rod60qytNhQ4s/FVImnISfhkDEp3/Mh77GuT04Cc6I=;
 b=icX01umilfK8wOiUgevYr0vDz3Af9V/mIKsyaciTCvHDLqLV0/M1NKy0zIMoLR0MrAtspi40L+Pr75Kh0yH6wAHjW6Wn05YZRLPEZeTfXrmB1EaBfpllhi/QNYk3w/L2s8/eLqEDmXb+VVIXEBTyyFsV/HvjoildTRZx4F31r2Jp+XgxY07C8ToOcNR/KRKcf9vGq8gBpRYAvLZaeFg9aHaRyyxNEjTzHAj/JpRbHN9Boy1aELE/N8f85HA8wAO+o37OcZrPkbBuxL+JtSv3f4IWuqYQ1ivY64MBncQdDM4OWDvYOc3fzWvyQoOAiF+uEKD/gFyUgy6/4n7ZQJCB2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Rod60qytNhQ4s/FVImnISfhkDEp3/Mh77GuT04Cc6I=;
 b=muGGR9QxvjtApqf6ZssEi8D1+10o0xCRiwn2jGDmHp8jAbrQT/nSntRhTXx6sun9Y2H8t5EBDwQdGFHYFRYGLn67JxM3QYihgaqEcfNYuzFw78zVBg1vrKlZ0RWHUg9dsCKsD5D3YVhjBGNKSoD2tUYjV8c1SzooT/9hGwZOnLk=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by MN2PR10MB4255.namprd10.prod.outlook.com (2603:10b6:208:1d2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 18:09:23 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Mon, 10 Mar 2025
 18:09:23 +0000
Date: Mon, 10 Mar 2025 18:09:21 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jann Horn <jannh@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Harry Yoo <harry.yoo@oracle.com>,
        Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: Re: [PATCH v2 6/7] mm/mremap: refactor move_page_tables(),
 abstracting state
Message-ID: <8afc409d-dcc8-474f-8b2c-9f6665a960ad@lucifer.local>
References: <cover.1741256580.git.lorenzo.stoakes@oracle.com>
 <89f2446f70acd41172dadbb3404db9d95415c78c.1741256580.git.lorenzo.stoakes@oracle.com>
 <40d1c30b-f437-4cf5-a37f-2e3084f03086@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40d1c30b-f437-4cf5-a37f-2e3084f03086@suse.cz>
X-ClientProxiedBy: LO4P123CA0386.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::13) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|MN2PR10MB4255:EE_
X-MS-Office365-Filtering-Correlation-Id: be74003c-4ca3-49cc-76c0-08dd5ffeafc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WZ6ijCH6R41iu38BAAyDLR+vIaVSjlXKnjx7AJtcGHMI0cOPT1LizfPWX8DW?=
 =?us-ascii?Q?o8dBT2wFcwm6DNgTOvgq0MVYpft/oq2xHSVr1FiWfhc9NqfwIMtkJAZ27536?=
 =?us-ascii?Q?Q8oZrEhoHVYgLbuxjOBBAsGTQXe5q42wTQFo4QQdk2k0I+MQjqWvY/CY07ke?=
 =?us-ascii?Q?ioso3rqEP4zTjyKQSF7Gi+qQnNbNzD3i5AuI71qhk8l41fcnheddhQ55unVc?=
 =?us-ascii?Q?e4x6k+5w4jvp3x5KlFasvFuMyHOKH1Qs2ryW5lrwLPP51M/uyldFPXiHY49j?=
 =?us-ascii?Q?xIYtctiehlGz/nXPboSOjmCGDHLNMtKeuGoXxU7XKXUIIx35tqskt2EUeZ9+?=
 =?us-ascii?Q?9Q/tw97Cp9+8IqKc6JJxg37jfuIOlWLovJelpG4M0/6msCRpcwzyjmptzpdY?=
 =?us-ascii?Q?U+PKivF/f4szFHRFMRuIuRNnuTPfOgpg43toYpQsU2jMs93kt1qAxScPmkn7?=
 =?us-ascii?Q?8Q0O+6aEkBUK88gryjA1DrXRsLvoCwSckzFyec+Z/4y08FcITEnYNMpL2aQn?=
 =?us-ascii?Q?bxAaOM6y5fY1uowZF7bgqdv9e3sC5vRpXLHMjuHS4bwYEOgOthbCmDbN+ZaT?=
 =?us-ascii?Q?qowNTRLaHcORqtoZz589c4vmqqi65imPLTqVPCrx2+jMJzEftXkM4AGqpjO9?=
 =?us-ascii?Q?uLaEU6Du5SwaKP2FFXIXNp9CNJL9WlpvPIX9BeoBiels74vH18DhzNOGzp87?=
 =?us-ascii?Q?T5Lg0fIdPIHdVy6RoDii8fsj+W/ddZ8DK2megmMqUgXYZBGnX38oemjTdE5n?=
 =?us-ascii?Q?93wPkJfbbVBXCJPjSNbpvs4du4gterw8n+Cyzm4HFxa9HgYxRsN6pysOMouZ?=
 =?us-ascii?Q?PCMqRO+XixelLEIDuHfpw8rB1PWuY/wx9kp9twy9K+lTkbP99A5APcOKQFAK?=
 =?us-ascii?Q?UsrGVdV43yMeEIOTICtGoHrOtv3AnSocJ2Reoh/VRfPffSbudotJsMLsNOji?=
 =?us-ascii?Q?csjQfbozNcWW3fEtz0jX4BXCxq0KTfbGW5mZ0p4wR/it4SJjAhoLugUbLoGI?=
 =?us-ascii?Q?ibOf4SDhJWD6lguNo4nv4fb8/UGpOUWaVddYhElROk81AgskhbWnppp683UP?=
 =?us-ascii?Q?YHbzfDsdaa6+JUbpLHm1unl9BMoMDh5hEkyD1AlWGH/gLzTqupo6ZjWxSyPi?=
 =?us-ascii?Q?QGepQxItyl+9VodzI9vOJ78nLhBjw2Sm3BoukBBXOMtOH0FhCMrxBwgAOjFi?=
 =?us-ascii?Q?OIrGjO8D4W9OkrmAjhZPauKnZ2Vn4fW7zbPuEiZ3REXzXn+vElVWGEJNWYU+?=
 =?us-ascii?Q?HajbXATVRU9aoNOmH9WgmvhR9zSA/LuuOkoPfKdbw6eguhC6p89J7pK5RXVC?=
 =?us-ascii?Q?Wvj2+DiC357LtaEj/TiwSWJNm4qCVynuPEP+Z1M80rTnFQFaVRimRlmViI6f?=
 =?us-ascii?Q?Yw5jc6J4loeA6B80JiGfrb2WuS6e?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XGDssNSmy5Fi1zgZO4JuBijbXd8/g0B+QFdxTjfrQ1DSps/kX0Y3gG2Nu/Wa?=
 =?us-ascii?Q?qJ3ysCUqq5OilOheHlF4jW9JaGlG7M1nE3Uwut42KKxFLqjPMUkmbcJuNi4l?=
 =?us-ascii?Q?16PQctTrV+nFYgxWoBpYwVZyA5WE9R/7XT1Yr/8mtNMfipY2DPzyhcmSO5nt?=
 =?us-ascii?Q?0t++Dd0RtSBSisnceUxEdBEonF84uZlQfHNoi53ymWqNPl9zzje60QXXUqJr?=
 =?us-ascii?Q?mRXA+hkZYsRdbsW6065O8/WgPWup8HVY9v9imCLP6Rhr1tDZaJ1SpqeOdfNB?=
 =?us-ascii?Q?0BpL/0ziknwekuw+zheJguW9gUMi96tDPNzAxWFsdwW0qNNIXw5zqD5x6SQU?=
 =?us-ascii?Q?P+Pt6TfAGb5n8lbmjpEQHsMZdRnOMMxB4oWVZqwWDvTJ0Ybryb2Jr/XUI/Qk?=
 =?us-ascii?Q?CycmtMS9EWQZWVJnNbEU1p3CR5jfx/t74/zppkKZS5O9vqPckB1GX7T3YLe7?=
 =?us-ascii?Q?H4Qcj1ZsmzqXPA/rHWm6bkca9lyp+UGo9qrVtGBtl5jUNDVgFGKWr7FiI3si?=
 =?us-ascii?Q?0kkbXfzHZoWwFObWWz+oO5I1KnNDbFq5cKUl4wPLcb69Pfz0e2no4pTuIA4C?=
 =?us-ascii?Q?w3Vh5dCmqIlBuW0SgvIg9TWAWiv0b6jiO48rJO8Lv3CNu12UxqSCCPBwd9I7?=
 =?us-ascii?Q?pFi0qd25ccbOenHR9ACQFk2sFd5tpYTW2BFqRNVuTkZnDWeuc/yKgmqLWb1P?=
 =?us-ascii?Q?Ii3gBBDWRVqLhmugw/d1kuJdV07J8MKqqQACChkzHglB+agar+QggYacHRNk?=
 =?us-ascii?Q?94kknXodpQ3lYxDaS6MxOex/4hdFkyFh5zDM73oqCtXK873zU7CdA1PfyJNp?=
 =?us-ascii?Q?IXlsOG2KvPjob7Chr4VOo5kLsc/1zgUjIOtg/1s5qL+2njOTbTca7ResyI61?=
 =?us-ascii?Q?0vjla15vvRJYDiOXoQ2wkGaJCQk4QkB+JH2aWBVmMO2TUT97GBw7iNg86F8E?=
 =?us-ascii?Q?K9FE45+U3sUVEWsUUlXubWsTdZZfJbeq/N7eON0c9AMXElp+NCVPPeufFR0p?=
 =?us-ascii?Q?6jnN1zvEptPEq1BIdPEH2abQhcIlJwgvIfRLvIlyHBBKhuhLre4bxJWcN4wf?=
 =?us-ascii?Q?iO8qB9wZeuOYjVNfHOdI2F61OISSHHiAL8EWIu/Cr9zdRqmNIwvKOy1SKcSv?=
 =?us-ascii?Q?rzwZ/sfBa5p1NyvEkXroqNSjWYMw+ia+2YZg7aRG/QPN5bDH0ulJJMgTNvzk?=
 =?us-ascii?Q?fJMhHujP4VfoQ/X6Ixsr9iGXxnsls3s4AR4jsxV3uD3IimBqxckOae8goKrc?=
 =?us-ascii?Q?VHa2emY4xudXhhjoOcU3Y6i546yqYNWJPG4LiMJb+aEIOZFXn+PVMOM0jKGP?=
 =?us-ascii?Q?BAeisblvjuPaZVpiEX86GsPj9Dh/ZKZFCxu6+herKc8SEIYGdCAGxXEBsMlj?=
 =?us-ascii?Q?7ygj8dW13htR7zw33XcGu4HBidcwA2YMjhulwa1wAeIUuaUSyhXOhtkGUxCz?=
 =?us-ascii?Q?MahJwsnfdUd/wfemBxa1CZPd2ARJlQlevOyGDOI2koEv1hZnPBeRFyh/oM8S?=
 =?us-ascii?Q?e/7DoMkoHxyohWN8uhQTXQB7HzVx1GhkOIHdm0G42To/IOziFKwI4DRyTIZb?=
 =?us-ascii?Q?3ysTbB8bN/ZbHYnAYJGcqDHeheqRM+qmNPEcJRYf3nxATMAM2sH/cDzG0cm8?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cXtXIc0yrm8QvlqMZfPzRfQXbzIwoaARpl0EthNnX8a+ztunat1raK4zKIcziboWSnJP67zkM+zy3gqQ4QlostT1cyo/dUhtWo1S0lqqB4vdR3sT3w5Rctx/QmlqTaRdilrj0mNR7HuTY2Y/oWEBcsBDCfywDPyNyNYrYvUHXv7/y1Yu9ivTntQuYobu4oP/DIuMdFfilzS75mPETE56bodldKfBEXmxRMSjY8Jwg9QcNXaIXu67d6ck+skd2KCORJg/NxXZvT8Es445FokqMvzwYjw2Ubm9i7PjTdefXvlh1oqATUmKMLLJAJhWpATTKWXJUHrMlAR7ZEXBiS4LeEAk9fEDaBb/UwQSSt+MEAsuo5TjNPcKcj4VEGL6ktNv2dEwhJNtOy9+19dTDjZnLCiEPhNXLnlBnW0C3ieUmc1ENbY82dxzpBfJFZ5kWVD99XtCtgdkdaX9bArWu19Z2cojMFopH6ShYDIh1LqEFCOSwh7DANXqGxqjMVpHmElj6LFp9ONr5pxvlUdV60CR6x+PveCcuN5RBt/+dAmb7CBWWiKYZHKbEnTaIbfXlb53woE8H7uEs3FUWm4fSQrMhR2ROtc408deT/xK+a/yvSg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be74003c-4ca3-49cc-76c0-08dd5ffeafc8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 18:09:23.3801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zsew/YxtdeERi3NGuQQimd1057u3LfMJxtFkC9H9BIEYmMGzwn6glD5r5wFamcaAkrkJoRjEPvMyIHKFh24rlVYGWFi3BMqqR26/UCImYaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4255
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_06,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503100141
X-Proofpoint-GUID: NO3ySMHMJs9T5FRachoboCT_Q1rY9WQK
X-Proofpoint-ORIG-GUID: NO3ySMHMJs9T5FRachoboCT_Q1rY9WQK

On Mon, Mar 10, 2025 at 06:05:45PM +0100, Vlastimil Babka wrote:
> On 3/6/25 11:34, Lorenzo Stoakes wrote:
> > A lot of state is threaded throughout the page table moving logic within
> > the mremap code, including boolean values which control behaviour
> > specifically in regard to whether rmap locks need be held over the
> > operation and whether the VMA belongs to a temporary stack being moved by
> > move_arg_pages() (and consequently, relocate_vma_down()).
> >
> > As we already transmit state throughout this operation, it is neater and
> > more readable to maintain a small state object.  We do so in the form of
> > pagetable_move_control.
> >
> > In addition, this allows us to update parameters within the state as we
> > manipulate things, for instance with regard to the page table realignment
> > logic.
> >
> > In future I want to add additional functionality to the page table logic,
> > so this is an additional motivation for making it easier to do so.
> >
> > This patch changes move_page_tables() to accept a pointer to a
> > pagetable_move_control struct, and performs changes at this level only.
> > Further page table logic will be updated in a subsequent patch.
> >
> > We additionally also take the opportunity to add significant comments
> > describing the address realignment logic to make it abundantly clear what
> > is going on in this code.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

>
> Some nits below.
>
> > ---
> >  mm/internal.h |  46 ++++++++++++--
> >  mm/mmap.c     |   5 +-
> >  mm/mremap.c   | 172 ++++++++++++++++++++++++++++++++++++--------------
> >  3 files changed, 171 insertions(+), 52 deletions(-)
> >
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 7a4f81a6edd6..a4608c85a3ba 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -24,6 +24,47 @@
> >
> >  struct folio_batch;
> >
> > +/*
> > + * Maintains state across a page table move. The operation assumes both source
> > + * and destination VMAs already exist and are specified by the user.
> > + *
> > + * Partial moves are permitted, but:
> > + *      from_vma->vm_start <= from_addr < from_vma->vm_end - len
> > + *      to_vma->vm_start <= to_addr < to_vma->vm_end - len
>
> Should this rather be expressed using the actual field names?

I think I should drop these equations and replace with words honestly,
otherwise misleading. Will fix!

>
> > + *
> > + * Must be maintained.
> > + *
> > + * mmap lock must be held in write and VMA write locks must be held on any VMA
> > + * that is visible.
> > + *
> > + * Use the PAGETABLE_MOVE() macro to initialise this struct.
> > + *
> > + * NOTE: The page table move is affected by reading from [old_addr, old_end),
> > + * and old_addr may be updated for better page table alignment, so len_in
> > + * represents the length of the range being copied as specified by the user.
> > + */
> > +struct pagetable_move_control {
> > +	struct vm_area_struct *old; /* Source VMA. */
> > +	struct vm_area_struct *new; /* Destination VMA. */
> > +	unsigned long old_addr; /* Address from which the move begins. */
> > +	unsigned long old_end; /* Exclusive address at which old range ends. */
> > +	unsigned long new_addr; /* Address to move page tables to. */
> > +	unsigned long len_in; /* Bytes to remap specified by user. */
> > +
> > +	bool need_rmap_locks; /* Do rmap locks need to be taken? */
> > +	bool for_stack; /* Is this an early temp stack being moved? */
> > +};
> > +
> > +#define PAGETABLE_MOVE(name, old_, new_, old_addr_, new_addr_, len_)	\
> > +	struct pagetable_move_control name = {				\
> > +		.old = old_,						\
> > +		.new = new_,						\
> > +		.old_addr = old_addr_,					\
> > +		.old_end = (old_addr_) + (len_),			\
> > +		.new_addr = new_addr_,					\
> > +		.len_in = len_,						\
> > +	}
> > +
> >  /*
> >   * The set of flags that only affect watermark checking and reclaim
> >   * behaviour. This is used by the MM to obey the caller constraints
> > @@ -1537,10 +1578,7 @@ extern struct list_lru shadow_nodes;
> >  } while (0)
> >
> >  /* mremap.c */
> > -unsigned long move_page_tables(struct vm_area_struct *vma,
> > -	unsigned long old_addr, struct vm_area_struct *new_vma,
> > -	unsigned long new_addr, unsigned long len,
> > -	bool need_rmap_locks, bool for_stack);
> > +unsigned long move_page_tables(struct pagetable_move_control *pmc);
> >
> >  #ifdef CONFIG_UNACCEPTED_MEMORY
> >  void accept_page(struct page *page);
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 15d6cd7cc845..efcc4ca7500d 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1694,6 +1694,7 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
> >  	VMG_STATE(vmg, mm, &vmi, new_start, old_end, 0, vma->vm_pgoff);
> >  	struct vm_area_struct *next;
> >  	struct mmu_gather tlb;
> > +	PAGETABLE_MOVE(pmc, vma, vma, old_start, new_start, length);
> >
> >  	BUG_ON(new_start > new_end);
> >
> > @@ -1716,8 +1717,8 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
> >  	 * move the page tables downwards, on failure we rely on
> >  	 * process cleanup to remove whatever mess we made.
> >  	 */
> > -	if (length != move_page_tables(vma, old_start,
> > -				       vma, new_start, length, false, true))
> > +	pmc.for_stack = true;
> > +	if (length != move_page_tables(&pmc))
> >  		return -ENOMEM;
> >
> >  	tlb_gather_mmu(&tlb, mm);
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index df550780a450..a4b0124528fa 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -580,8 +580,9 @@ static bool move_pgt_entry(enum pgt_entry entry, struct vm_area_struct *vma,
> >   * the VMA that is created to span the source and destination of the move,
> >   * so we make an exception for it.
> >   */
> > -static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_align,
> > -			    unsigned long mask, bool for_stack)
> > +static bool can_align_down(struct pagetable_move_control *pmc,
> > +			   struct vm_area_struct *vma, unsigned long addr_to_align,
> > +			   unsigned long mask)
> >  {
> >  	unsigned long addr_masked = addr_to_align & mask;
> >
> > @@ -590,11 +591,11 @@ static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_ali
> >  	 * of the corresponding VMA, we can't align down or we will destroy part
> >  	 * of the current mapping.
> >  	 */
> > -	if (!for_stack && vma->vm_start != addr_to_align)
> > +	if (!pmc->for_stack && vma->vm_start != addr_to_align)
> >  		return false;
> >
> >  	/* In the stack case we explicitly permit in-VMA alignment. */
> > -	if (for_stack && addr_masked >= vma->vm_start)
> > +	if (pmc->for_stack && addr_masked >= vma->vm_start)
> >  		return true;
> >
> >  	/*
> > @@ -604,54 +605,131 @@ static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_ali
> >  	return find_vma_intersection(vma->vm_mm, addr_masked, vma->vm_start) == NULL;
> >  }
> >
> > -/* Opportunistically realign to specified boundary for faster copy. */
> > -static void try_realign_addr(unsigned long *old_addr, struct vm_area_struct *old_vma,
> > -			     unsigned long *new_addr, struct vm_area_struct *new_vma,
> > -			     unsigned long mask, bool for_stack)
> > +/*
> > + * Determine if are in fact able to realign for efficiency to a higher page
> > + * table boundary.
> > + */
> > +static bool can_realign_addr(struct pagetable_move_control *pmc,
> > +			     unsigned long pagetable_mask)
> >  {
> > +	unsigned long align_mask = ~pagetable_mask;
> > +	unsigned long old_align = pmc->old_addr & align_mask;
> > +	unsigned long new_align = pmc->new_addr & align_mask;
> > +	unsigned long pagetable_size = align_mask + 1;
> > +	unsigned long old_align_next = pagetable_size - old_align;
> > +
> > +	/*
> > +	 * We don't want to have to go hunting for VMAs from the end of the old
> > +	 * VMA to the next page table boundary, also we want to make sure the
> > +	 * operation is wortwhile.
> > +	 *
> > +	 * So ensure that we only perform this realignment if the end of the
> > +	 * range being copied from is at least page table aligned:
>
> AFAIU we need to at least reach (or cross) one page table boundary? Might be
> just me, but I'd understand that sentences that it has to be aligned with a
> page table boundary, and "at least" just means it can be naturaly aligned
> with a higher power-of-two value than the pagetable_size (but doesn't matter).

Will reword. Yes we need to a least reach/cross page table boundary.

>
> > +	 *
> > +	 * boundary                        boundary
> > +	 *    .<- old_align ->                .
> > +	 *    .              |----------------.-----------|
> > +	 *    .              |          vma   .           |
> > +	 *    .              |----------------.-----------|
> > +	 *    .              <----------------.----------->
> > +	 *    .                          len_in
> > +	 *    <------------------------------->
> > +	 *    .         pagetable_size        .
> > +	 *    .              <---------------->
> > +	 *    .                old_align_next .
> > +	 */
> > +	if (pmc->len_in < old_align_next)
> > +		return false;
> > +
> >  	/* Skip if the addresses are already aligned. */
> > -	if ((*old_addr & ~mask) == 0)
> > -		return;
> > +	if (old_align == 0)
> > +		return false;
> >
> >  	/* Only realign if the new and old addresses are mutually aligned. */
> > -	if ((*old_addr & ~mask) != (*new_addr & ~mask))
> > -		return;
> > +	if (old_align != new_align)
> > +		return false;
> >
> >  	/* Ensure realignment doesn't cause overlap with existing mappings. */
> > -	if (!can_align_down(old_vma, *old_addr, mask, for_stack) ||
> > -	    !can_align_down(new_vma, *new_addr, mask, for_stack))
> > +	if (!can_align_down(pmc, pmc->old, pmc->old_addr, pagetable_mask) ||
> > +	    !can_align_down(pmc, pmc->new, pmc->new_addr, pagetable_mask))
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> > +/*
> > + * Opportunistically realign to specified boundary for faster copy.
> > + *
> > + * Consider an mremap() of a VMA with page table boundaries as below, and no
> > + * preceding VMAs from the lower page table boundary to the start of the VMA,
> > + * with the end of the range being at least page table aligned:
>
> Same.

Ack will reword.

>
> > + *
> > + *   boundary                        boundary
> > + *      .              |----------------.-----------|
> > + *      .              |          vma   .           |
> > + *      .              |----------------.-----------|
> > + *      .         pmc->old_addr         .      pmc->old_end
> > + *      .              <---------------------------->
> > + *      .                  move these page tables
> > + *
> > + * If we proceed with moving page tables in this scenario, we will have a lot of
> > + * work to do traversing old page tables and establishing new ones in the
> > + * destination across multiple lower level page tables.
> > + *
> > + * The idea here is simply to align pmc->old_addr, pmc->new_addr down to the
> > + * page table boundary, so we can simply copy a single page table entry for the
> > + * aligned portion of the VMA instead:
> > + *
> > + *   boundary                        boundary
> > + *      .              |----------------.-----------|
> > + *      .              |          vma   .           |
> > + *      .              |----------------.-----------|
> > + * pmc->old_addr                        .      pmc->old_end
> > + *      <------------------------------------------->
> > + *      .           move these page tables
> > + */
> > +static void try_realign_addr(struct pagetable_move_control *pmc,
> > +			     unsigned long pagetable_mask)
> > +{
> > +
> > +	if (!can_realign_addr(pmc, pagetable_mask))
> >  		return;
> >
> > -	*old_addr = *old_addr & mask;
> > -	*new_addr = *new_addr & mask;
> > +	/*
> > +	 * Simply align to page table boundaries. Note that we do NOT update the
> > +	 * pmc->old_end value, and since the move_page_tables() operation spans
>
> As per this comment about not updating old_end...
>
> > +	 * from [old_addr, old_end) (offsetting new_addr as it is performed),
> > +	 * this simply changes the start of the copy, not the end.
> > +	 */
> > +	pmc->old_addr &= pagetable_mask;
> > +	pmc->new_addr &= pagetable_mask;
>
> ... and we really don't touch it ...
>
> >  }
> >
> > -unsigned long move_page_tables(struct vm_area_struct *vma,
> > -		unsigned long old_addr, struct vm_area_struct *new_vma,
> > -		unsigned long new_addr, unsigned long len,
> > -		bool need_rmap_locks, bool for_stack)
> > +unsigned long move_page_tables(struct pagetable_move_control *pmc)
> >  {
> >  	unsigned long extent, old_end;
> >  	struct mmu_notifier_range range;
> >  	pmd_t *old_pmd, *new_pmd;
> >  	pud_t *old_pud, *new_pud;
> > +	unsigned long old_addr, new_addr;
> > +	struct vm_area_struct *vma = pmc->old;
> >
> > -	if (!len)
> > +	if (!pmc->len_in)
> >  		return 0;
> >
> > -	old_end = old_addr + len;
> > -
> >  	if (is_vm_hugetlb_page(vma))
> > -		return move_hugetlb_page_tables(vma, new_vma, old_addr,
> > -						new_addr, len);
> > +		return move_hugetlb_page_tables(pmc->old, pmc->new, pmc->old_addr,
> > +						pmc->new_addr, pmc->len_in);
> >
> >  	/*
> >  	 * If possible, realign addresses to PMD boundary for faster copy.
> >  	 * Only realign if the mremap copying hits a PMD boundary.
> >  	 */
> > -	if (len >= PMD_SIZE - (old_addr & ~PMD_MASK))
> > -		try_realign_addr(&old_addr, vma, &new_addr, new_vma, PMD_MASK,
> > -				 for_stack);
> > +	try_realign_addr(pmc, PMD_MASK);
> > +	/* These may have been changed. */
> > +	old_addr = pmc->old_addr;
> > +	new_addr = pmc->new_addr;
> > +	old_end = pmc->old_end;
>
> ... this line seems unnecessary.

Right, we change this in the next patch though :P but for avoidance of
confusion I'll drop that here.

>
> >
> >  	flush_cache_range(vma, old_addr, old_end);
> >  	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma->vm_mm,

