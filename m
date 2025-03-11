Return-Path: <linux-kernel+bounces-556248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F209A5C324
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 919BF7A5A93
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E578C256C8C;
	Tue, 11 Mar 2025 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M8rQ1nvE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TTrU3+y7"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3383B2566C5
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741701597; cv=fail; b=dPvUoU15kHXhCv7RyMjF6FJbATMlAxgosADqWJ9i5a9aqTZNcrcBUpCqmp4ukN0nmO8Fskz3QAlBhVSVQuhO3saHWx4G15sR6Gxm1e5sIXZhrdqgndjgQKUlJmzMRIoNS0sXEl+zb6MIUnv/HRJ9SShQioOuP5Wyd2kBJGqwFnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741701597; c=relaxed/simple;
	bh=PT7w0UbAw+FFPGPfNt8Ed6WjxY4/DZFpOOeyxP5N6L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HyGpr3U5tRVM5zx4fWrAk710uDal5ZwKYncYXMYz9xpUFIFT+CISCiUSFPJdM2CK605+04aQk7hGdo5i3JTvyW3wW6/GKfn14XjwEv8Xqy3Lt+IBWqxtLaZ/QWKiq6hSkqp6ZkX4Eyk08GqQk1FGIG0xYtAckGnmb5hKqCVhOhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M8rQ1nvE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TTrU3+y7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BDMwCQ006199;
	Tue, 11 Mar 2025 13:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=nxbljHea4kyMZWy2OA
	rHl659tKUIrcGnsved7bH6xyM=; b=M8rQ1nvEnXP70oJ50meqx05dNBxL41IXkc
	dl9sJGaMbmGlS415HWCcLEYgxOl31Ocv3exr8Ku2TSJxg9ZknwzuSKF4htgVOObK
	kEvJv+XnCuQxu2Li4IrYBmOVG7/meOdyV9uieQyC7ce+N/+bMheeRSgNkE1smFz8
	wIKow4PaixzmNxpF28JfGOmY9qE4v7Q5rn221Ib37cuAyT/Q3VHZOFkagFaJopdn
	clb2d5MXQLpL68Zx3hKD61QLiBcbEbmcJfZwnsrDJeC+Kg+HQS7ct7D5RVd2y1iK
	AccpRx0UnNN8edrOVUpqCeB3BcESbQMroTMoggbImvZ3ctsQZ+UQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458ds9mue0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 13:59:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52BCeXmx014954;
	Tue, 11 Mar 2025 13:59:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 458cbfbj5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 13:59:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqCgPTGDxK/OCes5+7hexj2fK9TfgsIZXI16hZL5uP9d+aZQxZASDiEUewUZG/fNgotXLgZ3InBAwFK8CLIFvDjbPru61E9v9UN5tPHA69x5ni592QUq0cGvaQWC3mv2mDoC1Erg2arbnyfa0o5TVazEy38lQhGlVJ4mPslZc2EKcVwM0bZ4BvhRSQ6hI7pJoCdN4R4sfdchQVRu14TpTc4jScTqMY5LL/glhVF8/7QsoWiGWfy5tUlddSqt3xF1+e2y8hz+KtECyRrJfdpLMSrdQj6OY0/T0uPXKfVvckmFhBrMNihztKs6nAX8t2jELweKseSpj5cJVyrUFUUOOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxbljHea4kyMZWy2OArHl659tKUIrcGnsved7bH6xyM=;
 b=HjhQ7Tve8H8rpUxZS9BKa7gF1QR+C3c7RqMrlFsOahmaNdkWc7LioWbkTT4e/IpapNtekQRJGtowUj3nU+QDAQr/7ETHGuzETk7579D3X0WlZiviHqO4wWa6D5I9yDZxXKOO7pSXAuwKkNq+0UQPcuikVt2uUqCYHHBhg0lRznPjbx48AS2tUcaW/c1uDGj+dnF+TPdsPAxuQCIsA4lTT/xw1cthz2k+Ahu2gZB2RwmfAiI32pbaGvS1EYMKat80X3S+N9kQD6+5ecO7vPsFzDGauxmUrDcdXdsBtOiV8lmAWbSFvewgG99pUX0RvuB/3U0lO6PPaXVw0b0+ErZejg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxbljHea4kyMZWy2OArHl659tKUIrcGnsved7bH6xyM=;
 b=TTrU3+y7SnH3PSXoygV8u2wR722q7oUSKXqRThUg8lqpFmFXXWUgKtq8OJ6A3doOzLEybGQkWj9NYcWJBQCg+0BAox6p1cKYbtRKmzN1T6BFREOkppZee33tKtaxoxvGuCeEpmLaElxQ+4/vSey7hsduPI7qV7N30CTo5V7vP5Q=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by SJ0PR10MB4509.namprd10.prod.outlook.com (2603:10b6:a03:2d9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 13:59:12 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Tue, 11 Mar 2025
 13:59:12 +0000
Date: Tue, 11 Mar 2025 13:59:10 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <howlett@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH 8/9] mm/madvise: batch tlb flushes for
 [process_]madvise(MADV_{DONTNEED[_LOCKED],FREE})
Message-ID: <d4ac2770-7ef2-4522-beba-97ba16a2f7ac@lucifer.local>
References: <20250310172318.653630-1-sj@kernel.org>
 <20250310172318.653630-9-sj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310172318.653630-9-sj@kernel.org>
X-ClientProxiedBy: LO4P265CA0223.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::9) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|SJ0PR10MB4509:EE_
X-MS-Office365-Filtering-Correlation-Id: f6487fba-dcb6-4145-5ebb-08dd60a4e6c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C9OuXxeSkCpjKh3ifuR3Dz9Gthr3iLnGOEPxk9FeW6cykgfxwEjUZyNl4MmV?=
 =?us-ascii?Q?xoH3ezKYE4KnCDhTLq64CjSWf1MF1IYHglx8WfXVaoinjkUcrbk6Ys3ilG8r?=
 =?us-ascii?Q?4E4TtMIzjPE84yfyWbf+FKDizwJ8JH4acA7Li9sp3tb74uV5lIdC5Ew45X4/?=
 =?us-ascii?Q?ehdySm1dY94QQfCBbsCgIOtHAIEbAR7xG2i12456vdTng2ksjnGkENzO+eia?=
 =?us-ascii?Q?abzCq6gwLDPSGHVVzC45BuSvpEnXnFn70oe9reXG4/bEQtB5nQczGPHBonmV?=
 =?us-ascii?Q?MQCg5K3pgtVVPWGw3jVfvP7Gz9bV8ffBuY5/9CLUVd74PCc3f7sS4+za1Igg?=
 =?us-ascii?Q?a27k9SLoE3dllLy2yjSAq5FJbReI/Bvx/tTd9Gxyi8vuJZIe12tL+Lo8Mdjp?=
 =?us-ascii?Q?hB9Z8VQqFmKfKRZPbSCm1VcX8G+DMWgQjqhdHtKkyt1ZLAVFjBWN/TPtQLPx?=
 =?us-ascii?Q?P9dhUWRrxaWgIpcIqygtDY1NBi2Hujh6Qd4RNZbJ4++MBk2PdApTRHmLBpSn?=
 =?us-ascii?Q?22XLz4VxI1KjdiWtcKAsgz/8yDnKvt/eZwrFPb/8Vki52xD2y1r/E7P8dufM?=
 =?us-ascii?Q?6DJEL//tB4CeoeZjm9xSE6oZUWrWR+RF+aEMU3Hq5KovIMQy2kqt6u54nb+M?=
 =?us-ascii?Q?lvG6DfQ5fRAKUSIvioWG4RDJiyc5F+UZNG+K7gxVjKqmKvp7TbBQNfk+991r?=
 =?us-ascii?Q?0umXSKq1OAvfXSqqWu8f9zZQ1GBCMY8nae7IJ0zI4uk6mkZ7GdBxkYJ+EOEU?=
 =?us-ascii?Q?Ich96VghRMZnKaWBNSeR3zhWLjDmLTTqZEJBAOh9XdBOU0zp9mM32BUjtnzg?=
 =?us-ascii?Q?kFXpnHxOtknuav/EZS3deBEWA3/tLaffJXNVT3Y+pq2Mbjy51wMnmabx8eWM?=
 =?us-ascii?Q?Zfzo6ZDO1/RpeZKL7sOslXmi4f8OJTCIeVv0bucgfI4X+Bz0NRy3R66dVcAP?=
 =?us-ascii?Q?N+rq9IJkNJsZRwjorNiK+DDG7ot87chlqUYaHE0scGcbhAZauVQXzaLJdKRc?=
 =?us-ascii?Q?QgbtQFLIsnlJ/I0fi6fp0BLH2tsl5q2+LqoxMX8e0M8gkkVq4FOyoDF/FtHq?=
 =?us-ascii?Q?3LSMoSupEqKhzG70DTd7Gu5niONV2j9/7W+weqqD1mbgiwpu466Rt9k0ljcr?=
 =?us-ascii?Q?UV8mGVnvVervUd0OCE6z4lyx+K7I4VCbCoC8MD64t0iSrSNFlIzjKHNPSzep?=
 =?us-ascii?Q?bvjR+OapYZHF+sCJCTKz/2DpVkCFh11KC3qgRH4Srl4XllS8fdw7FsdOtG4g?=
 =?us-ascii?Q?VVHFxKD4t12J2uet//maU4/ePTS7VHmlCqE2ybIgs/Pz/NysEVheyK9yhGy2?=
 =?us-ascii?Q?Dvi6e5kSXZ6wPDQD/Z16NtNIpMktgP7+J0DMNqCb8DzQihjBM3KmBxRrwzQb?=
 =?us-ascii?Q?VRcMFPO5R6PBHutOqH1gq1FHkuo6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H1VcXEFkAVI+o8ibkawLuFE8O7AG0gijAko0S+Y24/IAXr2tQHwd2oK+aJIT?=
 =?us-ascii?Q?Jb6fWrFdMZFB+N9OAx7bkPgkhwN9bjwtAuqF0rbAvnK64c+Vff+HSmwmwdIP?=
 =?us-ascii?Q?F4K7j7undRiteezt0GjwfJ4CAsKOuX50tRWJCOy2jfj83P1ltsRT8gttmQmm?=
 =?us-ascii?Q?BNGW3W506Tm1P9hVtKGtHqt7uHcmG29+0o4D8WtW33/FeFwnj2Fvaq9H6qtQ?=
 =?us-ascii?Q?xP629HsUP/pjO4Gy/SzxovpBL+MuW9iJRRFA1vk1Q7TgVXUi83+Z4vpKPMtQ?=
 =?us-ascii?Q?WwfNBgIQK7FT92V9JopXpCkIExQZcffd3KVfnxktB1RYOLVt0nzt7n0aFu5J?=
 =?us-ascii?Q?YY26c3N4ZeiteaZ19GNoAyNdtMdAG3t4lMGIuq+b4SctzTsXnJtlTI0KX0E1?=
 =?us-ascii?Q?3EUS2NFNUYLoHLq/biOa16/qGq9LG7Wyy9h3dBPpmA/T8QrDfAjkng0ZqKN4?=
 =?us-ascii?Q?qyQMiovKwmZgEdC4sLB9buSB1Tw87XI+3vtpM2VRPN0ZXWS0CAFVtMrSgFpw?=
 =?us-ascii?Q?coKZ9zQqGbdoXi079WtkLCOfsKOKpOUbUTk9KnSCu3+XOISQccc6+izI8dF1?=
 =?us-ascii?Q?T1nST/6pFq1dy+kFSXlzBVuFNVDzL+xgDblnuDA1O25ZTBUJ6FD0bj1otfqV?=
 =?us-ascii?Q?3KlXIuc3jObLbO7LQoS/Fyaxl81O3bz8mlO3SbMLdIyogjOnEY1ua35Xu1R2?=
 =?us-ascii?Q?uoKXD/r03SZHx7zSQ9W8KJxUJmTLMN9X639mqv6hh9EAk7As7Cg2oCPKtWDQ?=
 =?us-ascii?Q?qQGQwaYY3RiC/Stj1HyqIwPwIoqvgF4XjpzVBlDu0k/jRBf+AH1u0Ohcb7/H?=
 =?us-ascii?Q?rgCggGDJJUjFOaLF+3r5SR3rkH8lDEFSAPPWylkF6pV6AtISojQV8XxVA5rg?=
 =?us-ascii?Q?1C4JlZeeO7KoaqPzJa1u5DAZzn58qOehso/nNTkuPmMI7PxYorJKcb3Jjd+k?=
 =?us-ascii?Q?7adSFsFWerZ3q0h9IunbEriQcpNNs0nYw9/a76X4Nv/vMSCvtxld4YGkuXhp?=
 =?us-ascii?Q?mhEwZWwd6j4PJIZXFEwp+m1bhJkBqJC+4PVF8kLFi4+bQua3pem6woXDq0Kl?=
 =?us-ascii?Q?MVfo4bxLYGZaF274Nzb0cJorty67DZCHYC6ZGtBU3A/p0bn5IaTHG+6MOXp8?=
 =?us-ascii?Q?AbFz57ZL+09t7+hI7OYdbdh2I6u4APwvEzkkHQzAjZDj0WehEi/TPrU7QdbS?=
 =?us-ascii?Q?woGpcqdWnGT5v4YByu3oM2EIW96eii8y+ZKv/UmSPTGR6dE/MB+xEA+5PwcU?=
 =?us-ascii?Q?yMB2azAYtz8XWgxCeQ+bPl43AvOVM3+ElNHD3XeiiBxOHTpHunAeoQlEUkcn?=
 =?us-ascii?Q?7Wy0gaiHASsrUOlxBxOpoTCeaXKIhjVijxElXk3ZCaqfhF7us3Di/H28x2M7?=
 =?us-ascii?Q?10O6ZU5oyj/JlkfGTQhwX4mLl1Ze6Q3Vu9oCYH+b+vnYmawIL8EA9sKR7F6x?=
 =?us-ascii?Q?QDBxdgxUusKKiynVIU9GPeUi1y7ynoSageF2cQKmAPP2OXULVS+GkigLDQNj?=
 =?us-ascii?Q?rJoh8XLInrRe2ghlmsTWXXEXoJevxKM1TrwwSMSukO2z/+bC24WRQGo/A0ai?=
 =?us-ascii?Q?lfqXkY8D2ldNLSw+CgQQWvfE4NJFFz/hRE6a12iD7a79OVp5OP19RfcgOY78?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8fdivJ3MfsdIKGdKagqWC2MXWOoGsT6maSdkg/k3gKraJxCto9ZcBktklfQS+pWUi6W3e4/DZYvh86O8srdIJeT3cFBT6joQBO5J4sOnOeiUTfxp4FUI+F3RxVkc2j7tK61phD+9i9pSj0kStQruvZ+QNtZ1Ul5wWf6tW+0JOwj4GxGcjKA5KqUinUVZ/V3MuUXSc5rZLr3AAk67zv3m9cdn8lvW2Yb6wSsI0MCAG2wwuuJROiK6Qu/fVdIvML2MbZqo0Kt/VA3iYrHfGdNV+1TY65TLcWUUSqYVoJ0kEffi+zD9eVmhlfd9SO+Oe38VRjNy1DPgnnstsnV8fAnNQ1TOiLTVGPCIK0ooOVCn046L4tqebnhBXqynL1NefeX2L4f/ax+xIYjZyoyT2W/xbRvH/T1yQNgn+WwhgUDJPDJgrIM2gJ9dwzVkcLb9tZ8dk5PW42qPa5kHE7d+cBfoDtnEKxR6YyH1m1vP6jMXJ8jRWJ234BfS1p5bpbDY7LrXMWd3jtvFv+Sj6W0sujkNLtGvV5ZahaIZ0l52iL5rX85zrCq91SXdSOyMYjxIifAfsx5yYoPDUVuXU5eLVVAELGHM2doCmvgqIP7i9y48Ukg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6487fba-dcb6-4145-5ebb-08dd60a4e6c0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 13:59:12.0509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPHmQFd6VtzC/T5mAAE0gwZtwAQMH9H8QwOKQtsc1DRPEZ97M8fQDcfi+LrXsATMZSrnfl9vS9Lem9pgLwPm4qS5sBmbQdU1lqr1HYhietw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4509
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503110089
X-Proofpoint-GUID: eeEmkJdVR1GnZbqDNW_-3rDS5Vvr-j28
X-Proofpoint-ORIG-GUID: eeEmkJdVR1GnZbqDNW_-3rDS5Vvr-j28

+cc Rik on this, as he's working on TLB flush-related stuff. Maybe worth
cc-ing him on series respins too? Unless Rik objects of course :P

Again, nit, but your subject line/first line of commit message is
definitely too long here! :)

On Mon, Mar 10, 2025 at 10:23:17AM -0700, SeongJae Park wrote:
> MADV_DONTNEED[_LOCKED] and MADV_FREE internal logics for
> [process_]madvise() can be invoked with batched tlb flushes.  Update
> vector_madvise() and do_madvise(), which are called for the two system
> calls  respectively, to use those in the efficient way.  Initialize an
> mmu_gather object before starting the internal works, and flush the
> gathered tlb entries at once after all the internal works are done.

super nit but logics -> logic and works -> work :)

I think we need more here as to why you're restricting to
MADV_DONTNEED_LOCKED and MADV_FREE. I see pageout initialises a tlb gather
object, so does cold, etc. etc.?

>
> Signed-off-by: SeongJae Park <sj@kernel.org>

This is really nice, I love how we're able to evolve this towards batching
flushes.

Overall though I'd like you to address some of the concerns here before
giving tags... :)

> ---
>  mm/madvise.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 47 insertions(+), 4 deletions(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index d7ea71c6422c..d5f4ce3041a4 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -905,6 +905,7 @@ static bool madvise_dontneed_free_valid_vma(struct vm_area_struct *vma,
>
>  struct madvise_behavior {
>  	int behavior;
> +	struct mmu_gather *tlb;
>  };

Aha! Good :)

I see in 9/9 you actually pull the caller_tlb stuff out, I still feel like
we should be threading this state through further, if possible, rather than
passing in behavior->tlb as a parameter.

But this is nitty I suppose!

>
>  static long madvise_dontneed_free(struct vm_area_struct *vma,
> @@ -964,9 +965,11 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
>  	}
>
>  	if (behavior == MADV_DONTNEED || behavior == MADV_DONTNEED_LOCKED)
> -		return madvise_dontneed_single_vma(NULL, vma, start, end);
> +		return madvise_dontneed_single_vma(
> +				madv_behavior->tlb, vma, start, end);
>  	else if (behavior == MADV_FREE)
> -		return madvise_free_single_vma(NULL, vma, start, end);
> +		return madvise_free_single_vma(
> +				madv_behavior->tlb, vma, start, end);

Yeah as I said above be nice to just pass madv_behavior, makes things more
flexible to pass a pointer to the helper struct through, as you can

>  	else
>  		return -EINVAL;
>  }
> @@ -1639,6 +1642,32 @@ static void madvise_unlock(struct mm_struct *mm, int behavior)
>  		mmap_read_unlock(mm);
>  }
>
> +static bool madvise_batch_tlb_flush(int behavior)
> +{
> +	switch (behavior) {
> +	case MADV_DONTNEED:
> +	case MADV_DONTNEED_LOCKED:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}

I kind of hate this madvise_ prefix stuff, like we're in mm/madvise.c, it's
pretty obvious static functions are related to madvise :) but this is a
pre-existing thing, not your fault, and it's actually right to maintain
consistency with this.

So this is purely a whine that can be >/dev/null.

> +
> +static void madvise_init_tlb(struct madvise_behavior *madv_behavior,
> +		struct mm_struct *mm)
> +{
> +	if (!madvise_batch_tlb_flush(madv_behavior->behavior))
> +		return;
> +	tlb_gather_mmu(madv_behavior->tlb, mm);
> +}
> +
> +static void madvise_finish_tlb(struct madvise_behavior *madv_behavior)
> +{
> +	if (!madvise_batch_tlb_flush(madv_behavior->behavior))
> +		return;
> +	tlb_finish_mmu(madv_behavior->tlb);
> +}
> +

Nitty, but for both of these, usually I like the guard clause pattern, but
since it's such a trivial thing I think it reads better as:

	if (madvise_batch_tlb_flush(madv_behavior->behavior))
		tlb_gather_mmu(madv_behavior->tlb, mm);

and:

	if (madvise_batch_tlb_flush(madv_behavior->behavior))
		tlb_finish_mmu(madv_behavior->tlb);

>  static bool is_valid_madvise(unsigned long start, size_t len_in, int behavior)
>  {
>  	size_t len;
> @@ -1791,14 +1820,20 @@ static int madvise_do_behavior(struct mm_struct *mm,
>  int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior)
>  {
>  	int error;
> -	struct madvise_behavior madv_behavior = {.behavior = behavior};
> +	struct mmu_gather tlb;
> +	struct madvise_behavior madv_behavior = {
> +		.behavior = behavior,
> +		.tlb = &tlb,
> +	};
>
>  	if (madvise_should_skip(start, len_in, behavior, &error))
>  		return error;
>  	error = madvise_lock(mm, behavior);
>  	if (error)
>  		return error;
> +	madvise_init_tlb(&madv_behavior, mm);
>  	error = madvise_do_behavior(mm, start, len_in, &madv_behavior);
> +	madvise_finish_tlb(&madv_behavior);
>  	madvise_unlock(mm, behavior);
>
>  	return error;
> @@ -1815,13 +1850,18 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
>  {
>  	ssize_t ret = 0;
>  	size_t total_len;
> -	struct madvise_behavior madv_behavior = {.behavior = behavior};
> +	struct mmu_gather tlb;
> +	struct madvise_behavior madv_behavior = {
> +		.behavior = behavior,
> +		.tlb = &tlb,
> +	};
>
>  	total_len = iov_iter_count(iter);
>
>  	ret = madvise_lock(mm, behavior);
>  	if (ret)
>  		return ret;
> +	madvise_init_tlb(&madv_behavior, mm);
>
>  	while (iov_iter_count(iter)) {
>  		unsigned long start = (unsigned long)iter_iov_addr(iter);
> @@ -1850,14 +1890,17 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
>  			}
>
>  			/* Drop and reacquire lock to unwind race. */
> +			madvise_finish_tlb(&madv_behavior);
>  			madvise_unlock(mm, behavior);
>  			madvise_lock(mm, behavior);
> +			madvise_init_tlb(&madv_behavior, mm);

Fun, but I guess necessary. I strongly suspect this code path will never
actually happen, but we need to account for it.

>  			continue;
>  		}
>  		if (ret < 0)
>  			break;
>  		iov_iter_advance(iter, iter_iov_len(iter));
>  	}
> +	madvise_finish_tlb(&madv_behavior);
>  	madvise_unlock(mm, behavior);
>
>  	ret = (total_len - iov_iter_count(iter)) ? : ret;
> --
> 2.39.5

