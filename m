Return-Path: <linux-kernel+bounces-378676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBAB9AD3EE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02B2A1F237A8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5A51D0E14;
	Wed, 23 Oct 2024 18:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MzcfHVpw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Scxe0iMw"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE25B1D0BA4
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 18:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729707666; cv=fail; b=p6e8GCvEW6wpjDFDIeTpcATu2NtnxwTo0gqrMKiSXXTuPZl2qZP0dy2RXnZOTIarxnwWf6bUFN3J89tPMqU7+s1gX7HlZaL+RtyyCM1Uv/De9xXOoDgc8hMuaf17lUc02tN0s8uVGxVARtw1ypT8jHLHhue5K+MoSuWfQwtXPjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729707666; c=relaxed/simple;
	bh=wvp6xNvYUd2QRvspWqvM1Kbx13+hmtP+694flZWJxRs=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r/W7eVRBCS0AmxPdpgbHPDh6cBW+9RfWHnrhoq14ZfDDjGCW59NQ8TkE01Wu1IjJW3Ja9XLxHzJoXHgY1dxtESj5Ea5CVwSJoqzM88Uo0d5TN4RfhOB0EQ2hBimmlxwME/ajc4D84ILQNpUq/bdwpGB/swfmkf6HdVfmTgh1e9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MzcfHVpw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Scxe0iMw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfe30025373;
	Wed, 23 Oct 2024 18:20:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=WtOBPs0Pfp8UjWv7Lb
	pRbyaJgPfCHk5AqclGBHWVnK0=; b=MzcfHVpwfwTHbeODc329x4EdE5acN5Jz3+
	9P/1HbzaI3PC+H6pnaKz2kqAoR17tIkQMPVoJziQzhp0fian9k6+IconiuPAcSld
	cXygFtu8ZpuEv6+2aXu9TuZzJEBVTXVcFjXINTvExBNnHY099Nr4zUVqdSo9Waab
	hJMXUB/+sy9SHCEcndARMv3s4Ls7GA17Y4xGS7Fo42BSoF09bgJ7c8gMa6ny8D9z
	fJrx0k5qiIr8zOl7703FEJn1h3u4XPQQH+LtjbAPRUfzgZWf4G+9jSgaQDAZHMNG
	Ihd8JxbwnFlOmhBxLDAKhRbgYXF5JxQbkkgGNGH3SEm7yFSXKkCg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5asgtvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 18:20:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NHsktR027391;
	Wed, 23 Oct 2024 18:20:50 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emh36nbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 18:20:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ID6WCVK2gYBSqtcqmpDQZP4oJoxxXKvMVdbK3ynN6wukhV+KnIE1GQr8PoGbpHIHsJufSU3Emznxjq2kD0mMFIr/4YS146Jc4WDn9woE6Eb3cSCwrEr1qrtc0AsxBZhyd7XqSMpbOBLRqH4IAmieONKWr0P0OP4D1tjbxZPJUL7nyzP6ClEOm/NQo9uETEZHEv2om3rjPWdT9pLGZ1bBM10XCiwIHap08I5HMv2EToVhZlUErXvqQTmVUsTQhcqqqxDqOGIC5H9ZQhoxVsrH09yq0ZbfQfOr8gcbXpr7QeLQz1d9eA3EF77DZr1XvlLDTUdLPfAdmzn9B8vyfEOiFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtOBPs0Pfp8UjWv7LbpRbyaJgPfCHk5AqclGBHWVnK0=;
 b=ByUAeBgJ4megqgJ7TaCqUod7zUwuQ+x1nJRB6cZxOIqsPlnSgvj2kDu/h76+AnISTiQigpuPfQMLkstYtP2KwqhN5M60S/0At5ygJJTsU9bNJXc8Z2q+1ZE0CxBrfC/eLKJcF1HOFozogZ0sUDHwnpieRH23fV9rwl/OS4Od7GL98FQnnKqy/vfxJLIf+Vvn6a5PFy1lIfpTm7BzuiTm7ifx43oICGYiRFLKosFyW9DZEl2zAi9K4FlRQ3uCNrHCfFvFuVSsjo9VygaOrl67H+ALY+KfDiyCE57l/iwa6QS3mmwgdKEYw2M6Oh0aLR67YemKWJCQrhNZetnJyQ6mFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtOBPs0Pfp8UjWv7LbpRbyaJgPfCHk5AqclGBHWVnK0=;
 b=Scxe0iMwd+qDnD8HScuhi1juZmLYhmZf/+000yOiu7jEuUecypM0/kFpcs3SEBrAtz7PzhxClFyfuPfgDZIEphIbrcaHW4ynisyHxotx21sZl2I+Q9HBcS0gGDqoHn1IFSPyrM1uDz9EneHFtG/ljh4nQwm69CEEj6tFrh4c0EM=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH7PR10MB7850.namprd10.prod.outlook.com (2603:10b6:510:30c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Wed, 23 Oct
 2024 18:20:48 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 18:20:48 +0000
Date: Wed, 23 Oct 2024 19:20:44 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH hotfix 6.12 8/8] mm: do not attempt second merge for
 file-backed VMAs
Message-ID: <7ea1f225-0fd3-4d8e-8618-a275e0797345@lucifer.local>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
 <7b6bf6165080505feb5e00b313d2c84c25015e45.1729628198.git.lorenzo.stoakes@oracle.com>
 <f5037dbb-7412-4fda-b397-3e5538343686@suse.cz>
 <a97ac345-e880-4750-9114-43db358065c3@lucifer.local>
 <dgv3kvdbzj5r77qralkg4v52d6rq66kc5zly6en67iqqx3s4eu@vugze3mgo26j>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dgv3kvdbzj5r77qralkg4v52d6rq66kc5zly6en67iqqx3s4eu@vugze3mgo26j>
X-ClientProxiedBy: LO4P123CA0566.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::16) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH7PR10MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: 6685c0e7-ee8e-48e5-dce1-08dcf38f6ad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?86WvF0mwJtw0P4o7g4vm0XnJYfkcw2YaLeJBwMVBRpj14QKNBw5dTtooiU1J?=
 =?us-ascii?Q?z0IDyCDJWyv/6ywBGGRaqbp8iC58A0FafTplM3XKGQ5f6Weeh/CZbDW9JhwM?=
 =?us-ascii?Q?bTah3j5yG2DWNto/d2EfX/rLF1e1u4wKDAJeQYOxM8aVFsF8VSwJQI7SkKbj?=
 =?us-ascii?Q?8WA+hI3bE4GMjhLjT+TerDLZZNfdAO7WZH0PB2wOqb4lwmsX/77Xcd+AjkbP?=
 =?us-ascii?Q?mPdqF0j1BhlzP8Vm6tvP4cIcZ3QMr5TaGjEEUgR60LcyHtjuWqYN296hrt75?=
 =?us-ascii?Q?DQA5iODwApy/X1K66pQLoy5DmG0ijEYOfFen4a/jMJ3R6CY/pGT8yTX/vWIb?=
 =?us-ascii?Q?bZuUcxaJlKiiCwUbe9kf9w12Gt/6ux4GsWO1jbr3bOPGJrwW226MMaaKrtSF?=
 =?us-ascii?Q?D9CVRlMTnc2NC/3amUF44z/eVWEi/81i/fSSERjQG3ePT8TOdxXCq4RIeCLY?=
 =?us-ascii?Q?y1nJhEubg/D1N9Z0EmS9ByHr0F4N0P3LYzcfbBASJbMUWZjS8Sz2yO3nUZaV?=
 =?us-ascii?Q?oWiL5QV/otVSADIsbHmHcVRYh1SF4Vq+K6XNuXmzcaQmyJrc3dxtNqUFfeMp?=
 =?us-ascii?Q?uxoDFovAGgk2nh6809618FZC5/qXibg1l++fUqT3N7TYWXZqG2un62IRKcRY?=
 =?us-ascii?Q?3j4SUMtjz2Xc4LKvIDo+7ylR8/tPMuzI2UCje+FY7gn6gR9SxyBaUZNjTi/+?=
 =?us-ascii?Q?EqktpfIYKB22651OdAncxNfUNIfHYsbkcqi8UROkN3mTjztIWj3TN6doJ8hv?=
 =?us-ascii?Q?9iM4Ku2YdUdBtg7cgaqaooQCT8GR5OmYrE46ItydJgltykst3VO1F/zaBSim?=
 =?us-ascii?Q?XKzp0RZY/IzBm+i5uLBZwqHxkqd+iuikBEUnPwTX+2k0SSh18U/9ilx1Supi?=
 =?us-ascii?Q?oAe08/9eh/YH4nqGK9WvURtSQzF9FKGXNfgqlYD4PHK875S5NB0PL/y13mu+?=
 =?us-ascii?Q?eGyPgH9r59Cblh6J6bYq6xt30cH6A4qzFlgWrPAnGETpXXO2A3ZwxEeUMqo+?=
 =?us-ascii?Q?UnLped60CWIW9jUWvLC7iMHaJv4rSwLBwE2e7DbiNWky8Tmp9tohs8+hiv0n?=
 =?us-ascii?Q?fpuFrSdWReCq4+cDu9xYViIFtwIDRJN1AJ7ciQqADLgCP3VKA8NGxR2mQ7Eu?=
 =?us-ascii?Q?UERlnan/DBxfFMNtVyl0dIeG9jUe/FAnZXXGQb0ZB7bCOoG5qFMs9T4FoKfp?=
 =?us-ascii?Q?TTQ54vrVK/S2RoRz4BBzhuXZcp5XQIDRqgy7fHcu99GYBhDlxoRkc+RyV5O1?=
 =?us-ascii?Q?cxIjih1kBcjgVwa+rC/6IPoNk7yOJAetfa4uvVaSUNloBPTOr+rGiCP1/kgi?=
 =?us-ascii?Q?sYAg7G/b6VbI65fhcO8w+8vF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+HB8rnsFbpVFZSnDvKqYIZgwTg1I0aohW1SLw1u1T2EkM0MX39YCt9eLWzPf?=
 =?us-ascii?Q?UzioxiVpYEpAItMTnj4fOks2XxELDbVr0q22imnAtLw/LM16QhuTmQjJxbo6?=
 =?us-ascii?Q?aMKxVvuZufSzwcydFgdI621olrSqn6h/gZ9IdZkMTLNxvciAhUx+En1HIWS7?=
 =?us-ascii?Q?gw3rwsHm6pRWP5jLPGPvN7GavhtRvZ98bn4KirK8nsfkNxPjzSsO/ZzPG8si?=
 =?us-ascii?Q?BPyRsJAfNPKGlzZLQtMDDpp3guhK4gV0/Hq2ov//WABk2rh/3osnZfKQ1BWO?=
 =?us-ascii?Q?uzsixzjMD3sx1euOGWZ95Wj4KuBlf+6TBpy3QhxoEzaT/V29nuLAqYBniFHQ?=
 =?us-ascii?Q?pJWoiH/VOI9pqhQTs2HILajJNlEFx5AbtmHGNRmtS8KXY7+8bF3LdjrFIsGh?=
 =?us-ascii?Q?Ov7jebn1P1P48AuTFn5AtxUUGRu4jTtCsS4bp408ciNY95oW81jFJIDkjyCb?=
 =?us-ascii?Q?sCf1zQqcp+xBXv7vto+dd1wixVOdPdhzD9fX00CNXHepz5/0FkgVWRUms2GK?=
 =?us-ascii?Q?TgPBgTkLLqxcje4Wiz25STw4RxzIUephpNw/VR64RFP0c06wDbv4+0mNndTA?=
 =?us-ascii?Q?1fW8nTBYF3tOSEPltQjYJgi/fYRcdMEo2F0Ob/binTJJChS6qNhsaiPLgcPW?=
 =?us-ascii?Q?aEcOa91IGzLfY/9KXdc19IztaO1qC0mJOUWR5TmQ2UVMQE8WeM7s6rpGccPI?=
 =?us-ascii?Q?lWzOz5vpsSSlAe9cEpKRhbHjO3zpJmcndPJvHgTJqNnNb1Q3lHOuiSXqlbq0?=
 =?us-ascii?Q?xa8ZnykXbyDGLgsfuRAltj/AkYDLWniKpNJ31a9nOrURVCTKkUpFlzPFRcnk?=
 =?us-ascii?Q?OIDhCdYXwYnxo9jaoJA+kR1yn60E+5mEEhrnLjuWlSKgAMuCtACEGkmxri1e?=
 =?us-ascii?Q?7iPAduNITEWY9h8HLNtgXQ596LMiII/UZR9hlEO8YlJ/s2pUbzkxBNLWhaQF?=
 =?us-ascii?Q?r5+MwwHUpd8DSG9k95NnoN34a43PmHPcY5ROBR0wAnGUdzK6MGtLWTWVScbj?=
 =?us-ascii?Q?abA53KFXUphWvHRA2A8sSIsyDIUwZ+52bJybD1wOYn0LAeqvDxoleMEU+N8x?=
 =?us-ascii?Q?P32/ZLN/GJmlzqZbELaWNGX3ViopiOzG/UHV4fCNPsANfnqH3bl4U+OzjuHo?=
 =?us-ascii?Q?pfd5dbNl+DVUuIuf2zP4rxFbsTqMOvO8usveuetrQQNmwYA+2FjfCLkRr6SL?=
 =?us-ascii?Q?BHKfId7gHUHRWNCb+yGdOJkF+Tw/DAYTzYWSzg9N++jA+ceikNVI5uWya2YJ?=
 =?us-ascii?Q?AbSYXGpU27+SmxraN35yyOC1Hfd8QSrKnBhMVIQZSerFaghR25WhOLKA2ViJ?=
 =?us-ascii?Q?Q0HMOXqTEE64WBp8YwEfbhngyZtnBliF7mw+CvAzrEYk0IbrQEQsEPKn3/VW?=
 =?us-ascii?Q?LVwLDwQKQjOe0NOGvawOBA0xu0bdlkyrhnmzy+OMK/YnT6CKjGUqclJwJvtc?=
 =?us-ascii?Q?oEbxBwbD4bN0qMHwyTMguCdnryOEIIQ8ibVfIGD/GUFD1bWL2jQrqCyRD7As?=
 =?us-ascii?Q?VnDuRYXmCuE5vnTOQprhOt0nQqKP1U7ahkdHL72svITpz6Ps2hLouvlKFSto?=
 =?us-ascii?Q?8BV9dOmYznAuKwQMkanHR8KD6tx+/qk2o/oFuNpRj4QD1Ni1l6jUL6mRq5m1?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oHGb1uIdFCRT5f3OuTcWP+hJnHqryxjTfgMOwl8wsovACW11Sn3ZaGOXVHSJDuxqXJegfSctazICWu/iVDyhs2gXeR89YyOTu6HCsRl9BsPg/mWwDkM+wljpuH/Yrrvht8HYp12CRrL2HG8HbLy9/gDEcFvq09RJxAKyBKVRIylVQJp0KUlSx8FMJ5aAgtrbxYvHSyXzu4v3gmcJklRPwXpZZKoETdz8q58zy53Pv19NNLZuaP8rbM0C0J8Sm4MSSDuPvF8SZOf/QzylUbqS60pdBW9ApF73LSeiTXZajiRU3aI/ihf1oSjZbVUXjpgxhFvWIXW5U7LaMGG1TKs8nRacNjjRawmyaBPcb4dsxD7Ck4f1rTBi1JkRSDrEPp0ur9cwcvz99dyA03tGrlP3AaDBvFYElMwoPJdMCNFlGGlGCODqQppfam4tBMvYPaNyHUUtiR6Md876s/wOz05JmAZeEcTqxLFKiWE87wXv8kMWTOXhre6vqgl0aBXnU1fa5znjzNm89ZpCgVfvj6ZveTW74DIzs7u7jWyw0LyeCR7A1MQ5uUEDWlcE//kbWqgS0ww6on6qxRaaaQqT/jH3Y61kSvlMmaz6vaXOJGwPsw4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6685c0e7-ee8e-48e5-dce1-08dcf38f6ad8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 18:20:48.0826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fr/Lr6ppS4I66Vh2exYquHRJiuX94X+yDvNs3tOJhjszF/n9USgVDVW7o+tZTGArlqsCyDPS6f7f0LP2wY1ZHDc2tdLStxpThGVHZAcLi+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7850
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_15,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230116
X-Proofpoint-GUID: 6oeHmAPZNyWz7-D6KFwVnlv_5dUeQPUS
X-Proofpoint-ORIG-GUID: 6oeHmAPZNyWz7-D6KFwVnlv_5dUeQPUS

On Wed, Oct 23, 2024 at 02:16:19PM -0400, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241023 11:16]:
> > On Wed, Oct 23, 2024 at 05:01:29PM +0200, Vlastimil Babka wrote:
> > > On 10/22/24 22:40, Lorenzo Stoakes wrote:
> > > > Previously, we'd always try to merge a file-backed VMA if its flags were
> > > > changed by the driver.
> > > >
> > > > This however is rarely meaningful as typically the flags would be changed
> > > > to VM_PFNMAP or other VM_SPECIAL flags which are inherently unmergable.
> > > >
> > > > In cases where it is meaningful (for instance DAX) it is doubtful that this
> > >
> > > Hm if that's true, I'm imagining many piecemeal mmap()s of DAX that used to
> > > merge but now will create tons of VMA's, which doesn't sound great. Then it
> > > has also potentially breaking effects on mremap() which doesn't work accross
> > > multiple VMA's.
> >
> > I said this repeatedly to you and Liam but you both still seemed to want
> > this :))
> >
> > Anyway, yes. I mean you're pretty crazy if you are mapping a bunch of
> > adjacent DAX ranges that are all otherwise mergeable next to one another,
> > then on that basis assuming that you can mremap() the whole thing.
>
> Today, this will only work if there is a previous vma, otherwise we skip
> the attempt to merge.  It's probably a safe bet that there is a previous
> vma, but it still means relying on this merging is broken today.

True, but I also have a cunning plan, based on what Vlasta was getting at
with another idea that was possibly not quite as cunning that means we
might be able to still do this but in a much less terrible way...

>
> >
> > >
> > > > optimisation is worth the effort and maintenance risk of having to unwind
> > > > state and perform a merge.
> > >
> > > What if we simply created a new vma but only then checked if the flags
> > > changed and we can merge it with neighbours (i.e. like the mprotect()
> > > merging case). Less efficient, but less tricky and with the same result
> > > hopefully?
> >
> > I'd probably rather just drop this idea rather than wade into something
> > entirely new, but let me look at whether we can leverage
> > vma_modify_flags().
> >
> > I have a feeling we can't because we already explicitly reset state in the
> > merge new VMA case, and we'd be introducing a new way in which state could
> > get mangled.
> >
> > But I'll take a look and see, otherwise we can just drop this for now and
> > potentially come back to it later, the key bit of the non-backport patches
> > are 5-7 anyway.
> >
> > >
> > > > Since we've observed bugs and resource leaks due to complexity in this
> > > > area, it is simply not acceptable to have a 'nice to have' optimisation
> > > > like this complicating an already very complicated code path, so let's
> > > > simply eliminate it.
> > > >
> > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > ---
> > > >  mm/vma.c | 39 ++-------------------------------------
> > > >  1 file changed, 2 insertions(+), 37 deletions(-)
> > > >
> > > > diff --git a/mm/vma.c b/mm/vma.c
> > > > index a271e2b406ab..fe1fe5099e78 100644
> > > > --- a/mm/vma.c
> > > > +++ b/mm/vma.c
> > > > @@ -2260,8 +2260,7 @@ static int __mmap_prepare(struct mmap_state *map)
> > > >  	return 0;
> > > >  }
> > > >
> > > > -static int __mmap_new_file_vma(struct mmap_state *map, struct vm_area_struct *vma,
> > > > -			       struct vm_area_struct **mergep)
> > > > +static int __mmap_new_file_vma(struct mmap_state *map, struct vm_area_struct *vma)
> > > >  {
> > > >  	struct vma_iterator *vmi = map->vmi;
> > > >  	struct vma_merge_struct *vmg = map->vmg;
> > > > @@ -2291,34 +2290,6 @@ static int __mmap_new_file_vma(struct mmap_state *map, struct vm_area_struct *vm
> > > >  			(vma->vm_flags & VM_MAYWRITE));
> > > >
> > > >  	vma_iter_config(vmi, vmg->start, vmg->end);
> > > > -	/*
> > > > -	 * If flags changed after mmap_file(), we should try merge
> > > > -	 * vma again as we may succeed this time.
> > > > -	 */
> > > > -	if (unlikely(map->flags != vma->vm_flags && vmg->prev)) {
> > > > -		struct vm_area_struct *merge;
> > > > -
> > > > -		vmg->flags = vma->vm_flags;
> > > > -		/* If this fails, state is reset ready for a reattempt. */
> > > > -		merge = vma_merge_new_range(vmg);
> > > > -
> > > > -		if (merge) {
> > > > -			/*
> > > > -			 * ->mmap() can change vma->vm_file and fput
> > > > -			 * the original file. So fput the vma->vm_file
> > > > -			 * here or we would add an extra fput for file
> > > > -			 * and cause general protection fault
> > > > -			 * ultimately.
> > > > -			 */
> > > > -			fput(vma->vm_file);
> > > > -			vm_area_free(vma);
> > > > -			vma_iter_free(vmi);
> > > > -			*mergep = merge;
> > > > -		} else {
> > > > -			vma_iter_config(vmi, vmg->start, vmg->end);
> > > > -		}
> > > > -	}
> > > > -
> > > >  	map->flags = vma->vm_flags;
> > > >  	return 0;
> > > >  }
> > > > @@ -2341,7 +2312,6 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
> > > >  {
> > > >  	struct vma_iterator *vmi = map->vmi;
> > > >  	struct vma_merge_struct *vmg = map->vmg;
> > > > -	struct vm_area_struct *merge = NULL;
> > > >  	int error = 0;
> > > >  	struct vm_area_struct *vma;
> > > >
> > > > @@ -2365,7 +2335,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
> > > >  	}
> > > >
> > > >  	if (vmg->file)
> > > > -		error = __mmap_new_file_vma(map, vma, &merge);
> > > > +		error = __mmap_new_file_vma(map, vma);
> > > >  	else if (map->flags & VM_SHARED)
> > > >  		error = shmem_zero_setup(vma);
> > > >  	else
> > > > @@ -2374,9 +2344,6 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
> > > >  	if (error)
> > > >  		goto free_iter_vma;
> > > >
> > > > -	if (merge)
> > > > -		goto file_expanded;
> > > > -
> > > >  #ifdef CONFIG_SPARC64
> > > >  	/* TODO: Fix SPARC ADI! */
> > > >  	WARN_ON_ONCE(!arch_validate_flags(map->flags));
> > > > @@ -2393,8 +2360,6 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
> > > >  	 * call covers the non-merge case.
> > > >  	 */
> > > >  	khugepaged_enter_vma(vma, map->flags);
> > > > -
> > > > -file_expanded:
> > > >  	ksm_add_vma(vma);
> > > >
> > > >  	*vmap = vma;
> > > > --
> > > > 2.47.0
> > >

