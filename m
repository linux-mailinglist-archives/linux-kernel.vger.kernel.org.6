Return-Path: <linux-kernel+bounces-368188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3C69A0C63
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8EE41C24E06
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6471154454;
	Wed, 16 Oct 2024 14:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LOP+lo7g";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x+PO4lXV"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED2C502BE
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729088295; cv=fail; b=eulr7yToxKhsBuZNMRmN3hbwLqmiVhP6YMiOK+PpN2TuNaL5Sq4lnyY33kriDIqypnGh3Wq/JDjP4+qX6TZYd9gBCUQ7ZqlGN/rTG4hCNbBe00+92RK3c5xb7xrbt0d0uyqZuxNM9ZzF/iuRCBPVLBrMmCyBluWuu9rfGfhiVIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729088295; c=relaxed/simple;
	bh=GAEIMnyF6xqO956Bl+f7hKN3SJkETn+6FH2XSruDEQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FCu7zo3JwLu8MoY1jyHNI7RMV2ZY2wTEc4rbbN7V8//dNwL5McWmHiijoj1NwV/R9Zj6Nxzi7y9q7LLx7V+HhA3t13bMiSqkOGw8yE2oExvkPDa/BArLIjv29KQQJSSWkbGxYz/6+miuheddILSqSgpS299UDWXEeqVjhq18+uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LOP+lo7g; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x+PO4lXV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GEBfBl005065;
	Wed, 16 Oct 2024 14:17:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=x7KHQhJMJDB1U2bc2a
	4C9gdVjIQtSaXihhd+zDOEGGs=; b=LOP+lo7ghxF0xkiaQKsZdzFBGsNZhT+rMp
	cPnw5HsKc+EKNVioM1zOT/S28KiIbA8Y0jWJrGSwc/Wb2rlawtt8zSm4xs0KqFP/
	dryx9mIkOjt/rVULAJ262yFkergdBfi4LmccJeRB50RoEBKY9pNfZbGEsNZI4msg
	pqpEtS6U7cYXKWhG7ysHfvKkjRAHnbnd3iHsoo3shVtR5KbLETPzW4BuY6Qihq6I
	iJ+YZ9NiS1ph1AFsgsz/9/E2aHk7bRrJpqvOiNPI4iATxqFZHXiMCsnR4U7JqEgs
	9UMpkxY00jaZZ/dFMgGo+UmxhWLlK6ozMRDU+9GeEvKkAWUxtP3w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gq7kwmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 14:17:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49GDACxe014013;
	Wed, 16 Oct 2024 14:17:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj8ve45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 14:17:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWj2X4a7OoAOgwmGrFtgMwa0NmcmZ8HaWsHLlhgb7MZljkFruK6aR2qazKPV8PFeZttrLPA+AsyKu/HtbOJ9KQljIH3Yp6YrPvMgRtOAFaGtiNKYpCG9rwexXfsa8XKLtpw2ShvLUKY7ieCNeZWDypBRjyo1vnJJMXdG0bKdpcesgu9/eFVNL3Lo6a/VqPwCcw1M3ajdpg3q7lzV8FqZxX8MnAk/GvzLnz2vrM2XY4hcHsFdXvNDNQ1Ln59/WVgTggKUt9vccuce8WTT7oNs+aaOSIzoW0rrdBTj4yg/hTLBoa3rKMHWvA3ydW1pu1jmONBY0pnyLnwARA6YDtrIpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7KHQhJMJDB1U2bc2a4C9gdVjIQtSaXihhd+zDOEGGs=;
 b=D5S2JVOd9KaXmxLxb0NUGMazTjY97k94u37lRHH0fp1Yp5qWq0R4RLTMCPE02FGIcyXkzd8qC/NHmkfKNg1KyyJIqs5IxMcE7VQSHvf55SpNjNsEQNFEIsPtc9XxdHqJFME+AV4YLQhuxE6yWTk4lPKhvLOBZ7p4V19EXIqkhnrBKfnPuYxe2sW/agyz79Ihc9xj263z0tjRi5eZqnBVsulA7pol4QGvUuddpasRCYebNEktHPMyvPlBN2bb6o87VIsDQD4dcOSryN1bdXOmryS8IfDlhHv+N4Kp187ddT32Gm5to3D7ARJGBtt/YDhs2Pvgi6Qs3OC+e4eCfSFfUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7KHQhJMJDB1U2bc2a4C9gdVjIQtSaXihhd+zDOEGGs=;
 b=x+PO4lXVzYg7VabgdbG/3G2KZnGZrW33QqfkJZtr76WywmmODclbbwJP7vyrRcY5DE4HzYWEd4TsYgn23a+6HElq8OHYQzDsCAr/QCaRG4uCReummrw2X0CycKxn+MJEU+9e/7TkUGrXW5mryOl5C4qk2SX+bZdSuPa5ZWIWpRc=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS7PR10MB4989.namprd10.prod.outlook.com (2603:10b6:5:3a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 14:17:50 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 14:17:50 +0000
Date: Wed, 16 Oct 2024 10:17:48 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] mm/mmap: Fix race in mmap_region() with ftrucate()
Message-ID: <v2vzfowuxdcex57h3eyrqrkeue3leimpqukluyemgll6vbystg@dwbbt6pdrcvz>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	David Hildenbrand <david@redhat.com>
References: <20241016013455.2241533-1-Liam.Howlett@oracle.com>
 <575a7505-dfb2-44ca-aa5f-d34783fc14fa@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <575a7505-dfb2-44ca-aa5f-d34783fc14fa@suse.cz>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0074.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::7) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS7PR10MB4989:EE_
X-MS-Office365-Filtering-Correlation-Id: 118f9b81-1dd7-4cb8-78d8-08dceded512a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ocI0+I/XM1lwNVcICuUnh8aX3rLqci1wPV79x3ou7N7261uuEcJtwx5vltad?=
 =?us-ascii?Q?Xqe0KULwm+JYLL1AKuzlzQ8KtGhEB5LiGHS1f+rU3bDyiOE0QlfzscJu9wI+?=
 =?us-ascii?Q?Fb2WXOWB6c58e/qU/zGxHOMpIcwIiRQLqgUq8YWpJnZT5OkRQ7FnyaVvTLuF?=
 =?us-ascii?Q?QsQ07HQMz8M/UM6xeVNSgmNNIwaIK9BmE411wQsGAzAjAMJ6AFVh6LH6w+6b?=
 =?us-ascii?Q?sqKuJ2zDmyacKfUh0qAOp+8TeIKS8aHLYZi5Rp00OXVIlWCnVYGZaiFYB0di?=
 =?us-ascii?Q?6MdT5zGNHVHHI+JsHeqQduhAsZhDAHHzXjK6Q0tqRJXAnoBqks6R4ewbyY4X?=
 =?us-ascii?Q?Tviv1G1KyKvh4RgxELOSt9VQ2+pjR9CyE4QaQiZaLT3+YRNZ17IEbWgOkE0c?=
 =?us-ascii?Q?ftl+XBMYSekgmhDIrEL5gJp9Gx92TWqSRZhtRLgqOtwuPGV6mL2sm6IySHQi?=
 =?us-ascii?Q?KVbQ4UvszKGCpMNus4yDHGqCKyAy9U/92syfHATOxOfvTAbfSyItiY+7NZ/+?=
 =?us-ascii?Q?XNr0UbV5y5vOypBgVKFa58D7pgehgZP3j0ynYZ+3tgzaQIXC1fJZ9KTErpXa?=
 =?us-ascii?Q?pAnCRqgcTRp2MPxKG2Uy4HCMk+R30/knTl1lzO5ruTzL5ns47u6RvQqPIuWd?=
 =?us-ascii?Q?p6X4c7LyDeTFeraZPtfMS4gdAz85z47QT+SsjaGAKqdk7Zz/CvFdhOYc921F?=
 =?us-ascii?Q?ElYncqRFU3n4DINaWNGW9x7WQFGgRgc1hJdfXQqHSwTztxF3ixEULWAN4yCk?=
 =?us-ascii?Q?Jm14U+TBjQFD3tUMU5kvVnfg+yWlGf6gQd3Dp6gVdbAPkhYjjUdvMmC8QqJF?=
 =?us-ascii?Q?zl+Eo5jipvVlWckvpfdlYEDOrQ4JaDYUJTlvbUjwVXbew2DTocW8PotDgbBv?=
 =?us-ascii?Q?7HB3X24tl3NbIweTWJjkaxtnfNWmi9cQO5mRDIAIfvUEfU3Z7kjD/YynKXuh?=
 =?us-ascii?Q?yD6T2dJiLarP246ZkCb7PEoFaSUfCZbqG6AYY3ihLxfI1InLEd6IEds9URMR?=
 =?us-ascii?Q?p7cqHW6vlRL0Oqw0F8AXD4mk00+jSeShgoJSp5DdOnk4qNzFw/cNC6M4WljU?=
 =?us-ascii?Q?WeMfb4cM5zm4QyfNa/BKL4uqCuZl7++kGk+BZsgylUnGblfCRXTgq8PPIOjl?=
 =?us-ascii?Q?lSgqum0N5bODC6svcu3Q0cadfzFE6SBMywVexqdeNpYXrPcieKrzN0xCmDfa?=
 =?us-ascii?Q?hSjlDwD4FElAi3pToRfqWxnr234fqoGb03RlzlrvZOqjeianoAFOL3KicjAd?=
 =?us-ascii?Q?yeNscg0qWC0ogFjnTWTUqgDcXMEbvjASF7rKzHeC53UPaSlh86+UB/8Ug4G2?=
 =?us-ascii?Q?mg4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SCV/3Oy4d+K7967mjKtkfx1uee1XkrhkmCFF6BIH+eaFaTt4QAkLehGncY2x?=
 =?us-ascii?Q?vxLPdfw2zpx7kaRyXWFuUiXP2DgFJKvwV17fqMWd5yFoxF0LOpR4QJpmmcQU?=
 =?us-ascii?Q?p5EOZKjn5xiOAz7dFqDhXuvNbKluLyDVsJNrFpcFNTV7vPh7zwWvQLpApgrD?=
 =?us-ascii?Q?bUlS/9evBYMkYVhgLD6dVLWLfHw2CJoKkvTYatQZ/q1XQ2ZdAjXG6sxGLwbh?=
 =?us-ascii?Q?eYh0O+ho9PaUZ4Y/5KM3gXtjpDkbWHFNU7XUleO4XCBtZlAEXwwFoGKp235Q?=
 =?us-ascii?Q?kS3RDuSc7De+A/3JJKfTgmocZ+ZQdZwrgLGtOEfPU6vBEWls4ztV+kIwNF00?=
 =?us-ascii?Q?+IBZDimPaSlWAHMQNl+EcJ/JgSwowjXhuMESDkkb9WrjXLrgUbYelUQ5bz74?=
 =?us-ascii?Q?kJREq3HMIwcevAk+i6qHogpCgUbxCFOMhW+yuM7wZBcWoYE1rF4lb+JJRaNs?=
 =?us-ascii?Q?0DTIoc6AZ0faVSLp/CnmRE7kkQMUrTt3qchhgVKASkv8rSJ1VlJseYwLVvpj?=
 =?us-ascii?Q?MecOJQeC2J9h2RZvgyYcgvxYB02s/Lqz6x7KasrhrImIVsTP/TQGznA7zuJT?=
 =?us-ascii?Q?pv+Av34827+wNyroUg4UYW5gqcaW4iIyFF/T6MV7MaF8yNVA5fjM7N/hn3ul?=
 =?us-ascii?Q?DsvQon9u8d4c3pewc3K7dC+YRhSPy27aDrGYJH5upKmOmh3tWxH7LQv90oB9?=
 =?us-ascii?Q?8dlgGXZR2LOtD4/YWOZykJjKTFvwNVk8Vseac7lmXyvlaG4gokmbcDOT6xsr?=
 =?us-ascii?Q?lWPPPo2Fdlg10M7l5OuJoEjJXuKsZeWEdEbJlIbe1ZqAPa23+bOF69kTz9YF?=
 =?us-ascii?Q?z5us/rvLiz8B8VYKQviYjVvuDXLAZf2+L4Nz4BcV+Aq3/eYU5uc04fAyCdnK?=
 =?us-ascii?Q?MR34zfO+Vu3fAiuP9cdw/pakiksuspHrF0ccZbEt/vytx7nhNh0PfETixVFg?=
 =?us-ascii?Q?mdXFtHYtge/95LZjrfM5MlTXO3oDnxab2OSXl8gUZSelhkU/1w0Yt8q9D7xL?=
 =?us-ascii?Q?AaHeat4QOvFI+5++orCIdT5fIi6sr1yppsGdNJD4rCJiIi3RlUPzLeQhskRV?=
 =?us-ascii?Q?fsVppRl0C9XoCFJSsdAlGK/qOrmCtw6EIStn4sNlIR+xb/ykB8lVO1wHn1eZ?=
 =?us-ascii?Q?6N2QTVT4j9gi9hk5jw+n79mS6u9uZf0Nry4c9t570jhgF2hHd6pP78Oj1gpN?=
 =?us-ascii?Q?pjrTe56KpGe16n9g19+RQz0h/UFPWTtE3TGzGZaIt/5c+Maf7DAIx7/ZjKPC?=
 =?us-ascii?Q?jXrhjbzQDawYptSbycMduBcFEoWDh4aJjwFEpIcD08V+iGe9fMoR54Kr2KjA?=
 =?us-ascii?Q?N+xzlzBr3vXW9VoclLfnriWn55TwfPaBQ8pYLd7ATM2JhNAJMzdhDjp/GQ6C?=
 =?us-ascii?Q?qpCBYzlYvnR4CNjCqnq6S9YvHHHERI/W4xzU+yCFrwUclVwZiTp/R1S32Cyj?=
 =?us-ascii?Q?Xt0l5KyejLRssd5dPK4P1Tzz6yJ1XbO421zCkzNEm2DSCxZ/nsuifYnNw+xQ?=
 =?us-ascii?Q?tK4ieJTfXO50joehogUo1VIorTp1s+/UP6ZV4H1AJaDfeSh+d4D3Zr/1HTef?=
 =?us-ascii?Q?14WmwmD71Oilmk4w5/idB5VTJmsCouElJJoFmSiv2oKbeLPuYI/P6gy5jxS+?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hh0gHb07TUZ/kJRCCKeYplT0IKhD+vrIlaYhk2psW+nUlEJgZiE6AGJb6MzXL6YJHEWiMhiuAPy3gyq5fbqspSuwMkdmB9/lTNlysh97DR35ssUEKbcg5yPZRV0IGkKhHi23JkBlWvxPcOcut89m0WzEdTbFCpIqO0YHKjxHvqcBG+WUgHhQq7w3PLcMUxbVifUHDW1DKtP5SU9wCCkyXIAdyUOoOq6szoxVN5QpqD/7maQ0MGKuulz1AxjpiF3U0gOmmKeQ2RZgrD3rhLgqlkNQvGGMM5rBI4sxBr8Bc2eKjkGcOtI0OswFr/RgeBMcai2qKFpV02X3GiAOQYBaZV4SCkRGGjXbQtYsdEwdOR5Ghi42WOHP0HVeFZyBGq5u4hW8M6Xgx3JbpX4UPo3UHofdns6n1Pqpw990JErpMqK6+uwjWZ3oqLAe3ftg+65+7zJUOI2Juqc4iE6Q5cjINlETJBp9bCkl2ygdsclckmQlIxqOMqesqShsQui6qg9Ac8Npe+G0jPvc1qHOfl47A0pNIzucis2+u1rAM/nB9CFlXOZAwqEjlFkWjNOLuRM7WR6n3fFSb9KVi/exbVkJmtfX9ldZxT2+deCPaFDV10Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 118f9b81-1dd7-4cb8-78d8-08dceded512a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 14:17:50.5828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kCzlJVdutqLAcF+egJuIxn6j68F6WHrDaLp383RPAohmGWMOaq5AUnGgtAIZSwuXS4TrsoPrndEBVK+c1pDh9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4989
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_12,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410160089
X-Proofpoint-ORIG-GUID: PBgAfSSQjxhRXi3x9CO_6ZQ1IxiJxWax
X-Proofpoint-GUID: PBgAfSSQjxhRXi3x9CO_6ZQ1IxiJxWax

* Vlastimil Babka <vbabka@suse.cz> [241016 05:45]:
> Subject has a typo, should say ftruncate()
> 
> Also let's explicitly note it's a 6.12 hotfix.
> 
> On 10/16/24 03:34, Liam R. Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> > 
> > Avoiding the zeroing of the vma tree in mmap_region() introduced a race
> > with truncate in the page table walk.  To avoid any races, create a hole
> > in the rmap during the operation by clearing the pagetable entries
> > earlier under the mmap write lock and (critically) before the new vma is
> > installed into the vma tree.  The result is that the old vma(s) are left
> > in the vma tree, but free_pgtables() removes them from the rmap and
> > clears the ptes while holding the necessary locks.
> 
> And no parallel page faults can reinstate any PTEs as the vma's are marked
> as detached, right.

Right, it is detached and waiting to be freed so the per-vma page
faulting will fall through and wait for the mmap read lock to continue
page faulting, but the MAP_FIXED call has to drop the mmap write lock.

> 
> > This change extends the fix required for hugetblfs and the call_mmap()
> > function by moving the cleanup higher in the function and running it
> > unconditionally.
> > 
> > Cc: Jann Horn <jannh@google.com>
> > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: David Hildenbrand <david@redhat.com>
> > Fixes: f8d112a4e657 ("mm/mmap: avoid zeroing vma tree in mmap_region()")
> > Reported-by: Jann Horn <jannh@google.com>
> > Closes: https://lore.kernel.org/all/CAG48ez0ZpGzxi=-5O_uGQ0xKXOmbjeQ0LjZsRJ1Qtf2X5eOr1w@mail.gmail.com/
> > Link: https://lore.kernel.org/all/CAG48ez0ZpGzxi=-5O_uGQ0xKXOmbjeQ0LjZsRJ1Qtf2X5eOr1w@mail.gmail.com/
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > Reviewed-by: Jann Horn <jannh@google.com>
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

> 
> > ---
> >  mm/mmap.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> > 
> > v1: https://lore.kernel.org/all/20241015161135.2133951-1-Liam.Howlett@oracle.com/
> > 
> > Changes since v1:
> >   Updated commit message - Thanks Lorenzo
> > 
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index dd4b35a25aeb..a20998fb633c 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1413,6 +1413,13 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  		vmg.flags = vm_flags;
> >  	}
> >  
> > +	/*
> > +	 * clear PTEs while the vma is still in the tree so that rmap
> > +	 * cannot race with the freeing later in the truncate scenario.
> > +	 * This is also needed for call_mmap(), which is why vm_ops
> > +	 * close function is called.
> > +	 */
> > +	vms_clean_up_area(&vms, &mas_detach);
> >  	vma = vma_merge_new_range(&vmg);
> >  	if (vma)
> >  		goto expanded;
> > @@ -1432,11 +1439,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  
> >  	if (file) {
> >  		vma->vm_file = get_file(file);
> > -		/*
> > -		 * call_mmap() may map PTE, so ensure there are no existing PTEs
> > -		 * and call the vm_ops close function if one exists.
> > -		 */
> > -		vms_clean_up_area(&vms, &mas_detach);
> >  		error = call_mmap(file, vma);
> >  		if (error)
> >  			goto unmap_and_free_vma;
> 

