Return-Path: <linux-kernel+bounces-576415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A62EA70EE7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 03:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0210F3BCCD4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 02:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D94C137775;
	Wed, 26 Mar 2025 02:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="NFcWAZMt"
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E920EEA9
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 02:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742955658; cv=fail; b=OTSthRZBj9ZIrQNYJPym2EZFqcNDohYLts0SrnBlKAn7tpeJHoCc50ETIT6FDZmQogY3EJDhztAFKNAK7I0yLyN1hUaZTtTwqTcApaFqgSLnTCuUT1bc53b5yPHrh5eMJ0A362206RNBl7x/d6O6dusyeLSJfH9xKVfPOWfnSB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742955658; c=relaxed/simple;
	bh=yApzWJHQZnLakfOq/g05v0qodCJyk9jm61cISbbGOJU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=M4NA7NhNWiiX12vGj9G2Q7qYxYkzjWlARFRWleGQrObg6N38DNawAsAjwEHx9hwarJFD4owScvo9wui175QMfrn0/Yi/iVVuTTwzE2qipkVq8sX7FdulsBmU54ZJtJtUpQ7ulpBqrutrBDQPQMgGWH4qtrDIe15cCCVP5UdeEEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=NFcWAZMt; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PMaOvI007014
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 19:20:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-type:date:from:message-id:mime-version
	:subject:to; s=s2048-2021-q4; bh=WYgxXaeLTHOsUTF46uyQF5gjJIcCDj/
	ujpH26uVjqus=; b=NFcWAZMtiuXmv73cDEZTWgm/EHqyC6PH3xgkX95mBSJLaJq
	8L7CmWfA5Pqte6IKYS9PVTexnCGLsxxXh2dn55ZGWPfBY8XX3C/kDicLoO7EcrRJ
	9Wn7Ds83k8H0oYFwlzK7BYaJQZciP4vv/6/IoJc25cSL00V4BHg0gW1htFGpWJrz
	IBe/gRM8V6jrSYO/EDEW9QX7n4rbavwrnzQ7Hy6N0KTrkAnWs7jWmW77pmPYZRp3
	FYmdXCgFksipLRQZ5g28kKBfzJiHoDqm/eOtP2qUzl5SdvxqyY4S85w7MWE2x6cm
	w5M3XbhDobiOpMXmbQH7RHJt9kZvHaTe/xyF2Rg==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 45m52t1bux-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 19:20:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7iM6cMI/m69aQKUv+IDd4QnkBVBB23aOBnxohUCGF+kPzVHpyOSpxLZmxkHOK+OXwswCB3o0+yVuRKyu+zmd+Vf0jLqMiKH6USs112MdEP+8X2k5Edrmm5lFSHb43oMOnr4xht0bzra+sDbyWbLzsZS3goMzcPiaHEfLJtChjQRAM9Ls8ZC/fBnEZwTte0fMr2DsxIdhWOMcamFe14DQfzV0MMuuzU3lmbM/Ko7DEhpss7hkhWdVswJmFygfuL4XjPlxbElUMgdnmNA2ObALRh6DF/U0kbVNip9JFViT3CZWu1ZpikhImgr+441UcS0HVre3HqTWZGruHtspJ/49Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYgxXaeLTHOsUTF46uyQF5gjJIcCDj/ujpH26uVjqus=;
 b=QgXq2ETm+7Qq+vKJy+TL29NVBOhmhWcAjru/7qCfvQXyk7ILTn71CzquOQPTLKlxxW3/mq3ZXjZa+Yp1VkfogvFQ6cE86B+i1a6tQTGVTGyEAjXgoURRuQzW2Wen8T+DRAmcaAk9hFJBjVqfD8AHGC61mDIyp2wtalZGE/zm8ms2WzK/hu7J+s5CGgL3X4rwIymZCWM6Hg5yTG7kuTFIfVUsqGEc0Csoxd20pJ1KOAGrXtDqkN88ncRoNXHALeSpmrLZeC2KPvYA23INc8Llu2V2uTNd6aDL5EKOGenbzMAOXcJGGkHOW2K4/JPLtHzcK3La8UMY+2TSF6AerX12cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MW4PR15MB4732.namprd15.prod.outlook.com (2603:10b6:303:10d::15)
 by MW3PR15MB3866.namprd15.prod.outlook.com (2603:10b6:303:50::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 02:20:52 +0000
Received: from MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::f3ab:533:bb24:3981]) by MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::f3ab:533:bb24:3981%5]) with mapi id 15.20.8534.042; Wed, 26 Mar 2025
 02:20:52 +0000
From: Nick Terrell <terrelln@meta.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Nick Terrell <nickrterrell@gmail.com>, David Sterba <dsterba@suse.com>,
        Kernel Team <kernel-team@meta.com>, Ingo Molnar <mingo@redhat.com>,
        lkml
	<linux-kernel@vger.kernel.org>
Subject: [GIT PULL] zstd changes for v6.15-rc1
Thread-Topic: [GIT PULL] zstd changes for v6.15-rc1
Thread-Index: AQHbnfWy/H6qaHbHVECr7M2sVuLzgw==
Date: Wed, 26 Mar 2025 02:20:52 +0000
Message-ID: <44A5CFC9-5B88-4910-9674-BAEDD9969165@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR15MB4732:EE_|MW3PR15MB3866:EE_
x-ms-office365-filtering-correlation-id: 45b09551-7606-4e4a-63ef-08dd6c0cd4cb
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GZF4N4Xv+tGHs/Q2c9t9dKchFxudCcTLErM7Ae4vNiiptVyMGSDkFAEYHbWr?=
 =?us-ascii?Q?CGqZR/Lt7XT+nL9c+nrzAv/S8VNN2ojo/JRDYGZkzXbw9UDd9pFQpkz+BQ1x?=
 =?us-ascii?Q?wMlGQ8OpqRHwiLE7ZtanfLoM1y5VI1Hb9EKZ/ku9hZOboBaRlNMLuY1wslJS?=
 =?us-ascii?Q?x2nidpk+osOfaCkZIo0DwQycsME65XsRB0+O1qKg4ffA7GIDk9w7xH3hxmcM?=
 =?us-ascii?Q?rxzVJNAoMT5whjfSzCV7EnrsnOP1tVc1MGPWNhoDVibiNnZnl92PxwdRaetz?=
 =?us-ascii?Q?JieqOCqE0r01+oPxinH0xMKiM6v0ihlwZ6XD10JMZsCZnVbN956E+7fo/L3N?=
 =?us-ascii?Q?LCdDUyMY1REetFQheG7pmv+fujobxAPpxLdvehEKgCzHvb6zK+GW9mb6iAd0?=
 =?us-ascii?Q?m+evPCj0XHIaEQDOOrGphQ3knWX0mpYkbcOBGQ/L27x23ArYIU4DcUFe0Ekt?=
 =?us-ascii?Q?lSnb+mNZ/6gJcDqohbFe3M64vyhi7wzAeLxFWsIVlW/0+LnmPf5ye7Ui7Tc5?=
 =?us-ascii?Q?UDZFvyI1W6KXQxJd7XpqinOH0GajHvyC/V+bD/j6izEOzzGKZArQtfrXW+B6?=
 =?us-ascii?Q?vBIUzyulSlORxHZgRbc0jIC/j5U2CUKNc44lBEZ6QkCvwlaO+XA82ajRQSPk?=
 =?us-ascii?Q?IOueISrAacAdYOusDAMR85Yajiya5/hB3YGkVwtAq+Yn24+/0b3YnZ7Y81w8?=
 =?us-ascii?Q?v+LkFTYkHoYg2GPDnvIJbQjalTqA/Vge6Z3Bhff928UXRowwPJ+BdyhEtaqo?=
 =?us-ascii?Q?jg2+jj3Vx21MJhPRW+DdVh290JZE2+wlhh4tIoNncMRC26O9cvXNme3adHdI?=
 =?us-ascii?Q?UpYAt9GSB4+8AGh/1IMpKcX34yEBvsjsS8riKzm2V12W442xt/jVjx3kWMbO?=
 =?us-ascii?Q?/t2EVjsLJ+Z6fhIoQWdYFoy2GJ21GyddonAqqXZx5QI5d7sw/t+b9cN/JKFE?=
 =?us-ascii?Q?ecw/Fy28Dv5BOjLbBtKW3tJmbVgONJ24GBc+dnm6v3ttC92/ieB5Mxzst7kq?=
 =?us-ascii?Q?ubs4shRpHEQDvrwLiFyzbXyzvojUSxdNhBEnD+2bRrzjknVVVyBqSk5HwqVl?=
 =?us-ascii?Q?dg5cbcT3eVpTSDxg5FyixmKxrtT9QEUTyMOrjx+SsymNjCXNafWtapGRgjef?=
 =?us-ascii?Q?okgXgH5TGP09pz4l7TaD7U9omp0hS49N6MgsR8eZrSan4ixcQrTR0FY0acKf?=
 =?us-ascii?Q?yn9Zyjcs8y+SiRZKMFAAnHpuco+gPfHhTP1C42+BMoHf8fSJyYj+U9YoPEQY?=
 =?us-ascii?Q?LRO/WGsYX0Aiv4JmmEcO1NDCWG2kSnj7JZn/worBXYnJOBjuMw+nK4N8oPw7?=
 =?us-ascii?Q?K2UgC2Ex7eglxQvaiXrTNPuV4ef/XZ1LZYv8/8sVLsfys8TS84ErBcqzM1dT?=
 =?us-ascii?Q?fqz+I5I11x+wcsiLx2XWCaP9ejywue0xqYR0OjtMOL9Kdn38MMRiCUh+k1vl?=
 =?us-ascii?Q?Dplohaog14qtXNKV5q78xZZUiOKWxHCw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4732.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IsdTRFCQTebDfNaYM32M3BnqXsJ5N1NQFBjnA/4A+2u6nt2RXEkawhOvijZg?=
 =?us-ascii?Q?/2TNE0qsH6dytBxRzbAUzkBHPR5GWrBDTcdQdqLiKjnxMHpXol2mdb2N7m1/?=
 =?us-ascii?Q?1L+ApmNzZVfZ8LiNk2mPS1d92nL8vYr9Hcd124OjNw9Jc6kfc8JB+UMNR5ND?=
 =?us-ascii?Q?LtQTYkfywLeYHGk0C7bITHL0NuG1qFYGIQIHPH7/3UpqSui05Rj3dS8X5RqV?=
 =?us-ascii?Q?+Nw6ZmhdPWaCHZRhVbZ5Ohul0GxcJhpHti43ynTNBzoCOosjuMPnuRp78UMB?=
 =?us-ascii?Q?Wqu08R8M0UWUTHMCu0jd38Kz+MWQXJU0MzmckmnJ93hRqYuWKHwQsBqrgcKI?=
 =?us-ascii?Q?ZlBKUJ2tvDTziCi3O1JfNjWlBJRevAG/fGXM1pQmvImRf7diR3KhOsszwwz3?=
 =?us-ascii?Q?+JBx18yC2aOgbqHyi0rZy8FoEkeWTU5VePBW52A0/BUHEc1gAbEfUWOIhMcV?=
 =?us-ascii?Q?BxWt7Q7CORR2pAk/0/HEB8jOYrkSujJg/nZuTYXUZnFC9x2IYJzUSIzC4elc?=
 =?us-ascii?Q?PD4UmjII3x6AwIYsZuBsjd8CQanFJTkRcZAQZVAXh9vH2+vKPT9vHherDPTA?=
 =?us-ascii?Q?nVrQBf2kg7AoeVLrsLrx8Dg9IpVW3f/H2ej2fFDyTeB8lZ/h1/6pKzUZ/sBF?=
 =?us-ascii?Q?L8NUTJ7ZY9xrGngT87ta18u3Z0gBWvulT709WVGhHm4eoCwu2uGnyRxN9ZlP?=
 =?us-ascii?Q?M++FiR/Rnov47th5lLYonBmd/w9K7qxRTTWlNzKyx0J1DEBqEbboER/dfrec?=
 =?us-ascii?Q?pYi1NQs2aGzRir0PTO+IfLAhqRAFlN+ol4oJo00FqPHb8sMlKG7XSwiPNIQi?=
 =?us-ascii?Q?xZJRVkKraUi8GCZnN/go1yE8rMTLf++EmjvQKvVsZrXXamYt146rEqpHn2eR?=
 =?us-ascii?Q?GFMG4j9vD0YaOvINL6WsgYPj46QE+YLr3R2FDmM103J07hHjFqnMkjLyzQNY?=
 =?us-ascii?Q?lLNUkljzkDIECbN5Z05nTctoMMwvqmwfN+IYDWmCn7yXkPul9XkOsGRgZ/TI?=
 =?us-ascii?Q?l5D+UNUHKyzvb8DPr8nI5hKEtGcLwWCcemzHth4nb1k/rtcSTE2c6RmWKUhr?=
 =?us-ascii?Q?r+xxzEXqkFphQ1QrN537IZtNwm8pkjfC1PjEHpZaZ519gu+ohtyta4PkG/5j?=
 =?us-ascii?Q?L3HBPIJdhaRcuuDLqjpQcaaGdwBq8GLDP44xGe5FbneQ2n+qPMH8Xlnl4pu7?=
 =?us-ascii?Q?iVxMjS6i+4DVHFdJkSKwjfBwhNray2QuFZ8JIwDVqZx0CvJllwUmVVIrvR8T?=
 =?us-ascii?Q?V8X2clcL/D/L/oXXMeHsEZsaoIDjqIwpwNXaEqLjPKHr8Po7h7V4KuYkUzqE?=
 =?us-ascii?Q?7a3NCml8cTuAO4P6Srm2xcYdV5NPnU6x0iuRnua3YpoUlZT0NHqX3F7sVF1P?=
 =?us-ascii?Q?V0mA+kcmB+cOsUE5YtIIDK0Lk9IYIJ6uj034S3DStBe+hjgvRQz6pYAk4f8u?=
 =?us-ascii?Q?TV7MlAXaSeJWOVp/sRIoKqOz4rqOhPe5bBwr+dqfz2yZn8xYjOHHriFBw+fD?=
 =?us-ascii?Q?bH2kge1ahaVY5LY3kHjf5dZ1tCwPXUC2L1VtLBjLKaENqmGDzmtE/dx1Urjp?=
 =?us-ascii?Q?xxgKboZRe3eqLg05zg1LMBRWYL71MIQM80RpoaE4?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <420C1F10EB4CEE4A87797634CF6FF2F1@namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4732.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b09551-7606-4e4a-63ef-08dd6c0cd4cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 02:20:52.1560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m/mqGX48qQr7zQh/4JrCK3QSodUCztUk4jTpkZTEOSsG7baYHBi+OnMK1ITa3LLDuABH21e7Eo33ACEPMNPHsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3866
X-Proofpoint-GUID: xnkHrZ5bDFzBp6Lbm062vSYPsCX--4xF
X-Proofpoint-ORIG-GUID: xnkHrZ5bDFzBp6Lbm062vSYPsCX--4xF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_10,2025-03-25_02,2024-11-22_01

Hi Linus,

This pull request updates Zstandard to the latest upstream release v1.5.7. The
two major motivations for updating Zstandard are to keep the code up to date,
and to expose API's needed by Intel for the QAT compression accelerator. Detailed
changelog and testing information are in the commit message.

This change conflicts with 1400c87e. It should be merged to keep the change to
(__GNUC__ >= 11) to work around a gcc segfault which is still present after the
update to zstd-v1.5.7. I've tested that the merge builds & runs successfully
on x86-64 with gcc-9 and gcc-14. I've left the conflict as-is to avoid back merges.

This pull request has been baking in linux-next since March 18th. This is on the
short side because the commit was only completed on the 13th. If this is acceptable,
I would still like to merge the zstd update, so we don't have to wait for another
cycle. The updated Zstandard has been tested in btrfs and squashfs on x86-64,
and tested in kernel & initramfs decompression on x86-64, i386, and aarch64.

Thanks,
Nick Terrell

Link: https://lore.kernel.org/lkml/SN6PR02MB415723FBCD79365E8D72CA5FD4D82@SN6PR02MB4157.namprd02.prod.outlook.com/
Link: https://lore.kernel.org/lkml/20250313205923.4105088-1-nickrterrell@gmail.com/

--
The following changes since commit 7eb172143d5508b4da468ed59ee857c6e5e01da6:

  Linux 6.14-rc5 (2025-03-02 11:48:20 -0800)

are available in the Git repository at:

  https://github.com/terrelln/linux.git tags/zstd-linus-v6.15-rc1

for you to fetch changes up to 65d1f5507ed2c78c64fce40e44e5574a9419eb09:

  zstd: Import upstream v1.5.7 (2025-03-13 13:25:58 -0700)

----------------------------------------------------------------
Update zstd to the latest upstream release v1.5.7. Imported cleanly from the
upstream tag v1.5.7-kernel, which is signed by upstream's signing key
EF8FE99528B52FFD.

Link: https://github.com/facebook/zstd/releases/tag/v1.5.7
Link: https://github.com/facebook/zstd/releases/tag/v1.5.7-kernel
Link: https://keyserver.ubuntu.com/pks/lookup?search=EF8FE99528B52FFD&fingerprint=on&op=index

Signed-off-by: Nick Terrell <terrelln@fb.com>

----------------------------------------------------------------
Nick Terrell (1):
      zstd: Import upstream v1.5.7

 include/linux/zstd.h                           |   87 +-
 include/linux/zstd_errors.h                    |   30 +-
 include/linux/zstd_lib.h                       | 1123 ++++++--
 lib/zstd/Makefile                              |    3 +-
 lib/zstd/common/allocations.h                  |   56 +
 lib/zstd/common/bits.h                         |  150 ++
 lib/zstd/common/bitstream.h                    |  155 +-
 lib/zstd/common/compiler.h                     |  151 +-
 lib/zstd/common/cpu.h                          |    3 +-
 lib/zstd/common/debug.c                        |    9 +-
 lib/zstd/common/debug.h                        |   37 +-
 lib/zstd/common/entropy_common.c               |   42 +-
 lib/zstd/common/error_private.c                |   13 +-
 lib/zstd/common/error_private.h                |   88 +-
 lib/zstd/common/fse.h                          |  103 +-
 lib/zstd/common/fse_decompress.c               |  132 +-
 lib/zstd/common/huf.h                          |  240 +-
 lib/zstd/common/mem.h                          |    3 +-
 lib/zstd/common/portability_macros.h           |   45 +-
 lib/zstd/common/zstd_common.c                  |   38 +-
 lib/zstd/common/zstd_deps.h                    |   16 +-
 lib/zstd/common/zstd_internal.h                |  153 +-
 lib/zstd/compress/clevels.h                    |    3 +-
 lib/zstd/compress/fse_compress.c               |   74 +-
 lib/zstd/compress/hist.c                       |   13 +-
 lib/zstd/compress/hist.h                       |   10 +-
 lib/zstd/compress/huf_compress.c               |  441 ++--
 lib/zstd/compress/zstd_compress.c              | 3293 +++++++++++++++++-------
 lib/zstd/compress/zstd_compress_internal.h     |  621 +++--
 lib/zstd/compress/zstd_compress_literals.c     |  157 +-
 lib/zstd/compress/zstd_compress_literals.h     |   25 +-
 lib/zstd/compress/zstd_compress_sequences.c    |   21 +-
 lib/zstd/compress/zstd_compress_sequences.h    |   16 +-
 lib/zstd/compress/zstd_compress_superblock.c   |  394 ++-
 lib/zstd/compress/zstd_compress_superblock.h   |    3 +-
 lib/zstd/compress/zstd_cwksp.h                 |  222 +-
 lib/zstd/compress/zstd_double_fast.c           |  245 +-
 lib/zstd/compress/zstd_double_fast.h           |   27 +-
 lib/zstd/compress/zstd_fast.c                  |  703 +++--
 lib/zstd/compress/zstd_fast.h                  |   16 +-
 lib/zstd/compress/zstd_lazy.c                  |  840 +++---
 lib/zstd/compress/zstd_lazy.h                  |  195 +-
 lib/zstd/compress/zstd_ldm.c                   |  102 +-
 lib/zstd/compress/zstd_ldm.h                   |   17 +-
 lib/zstd/compress/zstd_ldm_geartab.h           |    3 +-
 lib/zstd/compress/zstd_opt.c                   |  571 ++--
 lib/zstd/compress/zstd_opt.h                   |   55 +-
 lib/zstd/compress/zstd_preSplit.c              |  239 ++
 lib/zstd/compress/zstd_preSplit.h              |   34 +
 lib/zstd/decompress/huf_decompress.c           |  887 ++++---
 lib/zstd/decompress/zstd_ddict.c               |    9 +-
 lib/zstd/decompress/zstd_ddict.h               |    3 +-
 lib/zstd/decompress/zstd_decompress.c          |  375 ++-
 lib/zstd/decompress/zstd_decompress_block.c    |  724 +++---
 lib/zstd/decompress/zstd_decompress_block.h    |   10 +-
 lib/zstd/decompress/zstd_decompress_internal.h |   19 +-
 lib/zstd/decompress_sources.h                  |    2 +-
 lib/zstd/zstd_common_module.c                  |    5 +-
 lib/zstd/zstd_compress_module.c                |   75 +-
 lib/zstd/zstd_decompress_module.c              |    4 +-
 60 files changed, 8749 insertions(+), 4381 deletions(-)
 create mode 100644 lib/zstd/common/allocations.h
 create mode 100644 lib/zstd/common/bits.h
 create mode 100644 lib/zstd/compress/zstd_preSplit.c
 create mode 100644 lib/zstd/compress/zstd_preSplit.h


