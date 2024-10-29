Return-Path: <linux-kernel+bounces-387463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0E99B519B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116331F240E2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897E71DE892;
	Tue, 29 Oct 2024 18:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oOw/oLtD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s2nGUf9r"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BDC1DB350
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 18:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730225563; cv=fail; b=c4oOBle/H8CpvFj8PKDE9AOwZHXEnZ3kMkrd0JCEbjiRLXcZfPUJuHy+ADBYxxC/tS3alV38KkpaxfwgNtqM0+WlmtfcyC+PN1EofgpwsOQesN6Uj9H0ZQZw1pqeRcixZa99R6J+8b7PwPRnJZo4IS7z19Ri+aCZZ1MimZNtJP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730225563; c=relaxed/simple;
	bh=jWJv/fwsJ/pAQnVs6BwSNXDNVzkQyb//OKdueK5P+1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DkTWuex5gEteNgPB+j9RxDgM0GUzq7BICXaOhF+VDZ6K1SzUy9+UwCHSzCLqRSXnxeFwVtRW00CWPfgdHl6KMNw9IN+IwDMDafkZSWkM/OOHzSEpc9DEDl8nnBhCz88y9oFyMWrlkddqXEnnTIl1iiYCQRYjn4f1JgS0nzi0ESU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oOw/oLtD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s2nGUf9r; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TGfXGC004044;
	Tue, 29 Oct 2024 18:12:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=woqMSvLgvosQjv/MfE1WcUuMqxJfVahDJ68XrgLxxKs=; b=
	oOw/oLtDddPvg5UmO5QvX97VwHKpEMPEND7mRWBBTHIfz/UF5CXI3N0W9hM17JE4
	NIDexyLlQ2picSNo6rPwqr05IvmH9uJakEn3GZwf7a09tjsqS6Aj4CQSUCaOdAep
	tRl3iS5YyXu9e3flRCjy39Z0ld+G2ELrvVX0//insHsxS4N4EsmOmAstulJouBOn
	adChwPoWUBG6dvRsbgIGb7hH4aFShOYzWjfrv+n+8xu6xkNkjm5+JBEKpx6bKttQ
	j6ptyGw+9Wsvdju2/0T5nbglwFDUqBsugWEUy1Z2qomx5Rpeg8UTherzXrxRnj62
	rm9ceI62ESvWERC17K0bQQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grgme9k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 18:12:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TH0i3c010118;
	Tue, 29 Oct 2024 18:12:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42hn8x8ww3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 18:12:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rX7MbvU6+YOK+/7nVvglQNGmSaYn8vrdH+opiSwKJmbS+HGiCue5wttqTc409lpLuB2hu2daaD3btLwxmbJIoe/Y+SzYGesUkAJ/vzme8bQCi7TdvuGpzK04e6dJ7gYpW8b2ITF+esf1zYMSHNXB4A4PHdZAQY1sYacDKKCFEHqVtVFuXf8wnXuY1vFrj0VSuqXnk3YjPOqdS15L5OnWKcyb1e7Ht5j2Tc3qJlgKkNmxoKjuffYqnrMa3dalmnF6WymaMfKPLuzxXjf3L+oeCDJRLHI4/OVOdeB3pk7IVxU919+74o9hk7G/W8X6RhhOOZQiftPhvi182yLTsmMOHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woqMSvLgvosQjv/MfE1WcUuMqxJfVahDJ68XrgLxxKs=;
 b=BRCMqNElUdSoD/4mKgk4Ta+TtO1meSLsU2dGGB6SxXXq9LkCZvOoezTLZyLt9uPJ51f7d4ySvZkGAJPJtnNZl7q3sBd3UY7v0iEZ1/vVALI8CJSJviWL+3KVijGnnHnSYWKFzz/O9b2ccxo5wvbtlaeN9b2iomoHkmFXyaCx0AzssDcwPRdcB/Cd58mBoPzmFcadDUxQi+j7agGg4u+hkADS75ekpeka9jTnyiAYIveDLF/Gs8Q5oU+y9GSdXj38SGXvXQ3wYO2b4OlObEJ7ueqk4bHMgxDY9cdPzs77v9hP6i7tuyXOeAfw4ske6gcDQqcPnPuV+BZId5ZKvmTopw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woqMSvLgvosQjv/MfE1WcUuMqxJfVahDJ68XrgLxxKs=;
 b=s2nGUf9rEuVOivqz3aYynzenZEYw+3cI/0YJKm8MpaORRu4egZw/kqQnCI8JjCga7kwxPYjnJvfWlaHLTe3FtUOOEqCkF8fd+grIWnXUZJcRzo9nE4AkSeb9UUFHAyXyJe7RAz7piWx1qMR+F/7Ys01BcY1fgVfadxIsYnTu7Xg=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH7PR10MB6966.namprd10.prod.outlook.com (2603:10b6:510:277::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 29 Oct
 2024 18:12:11 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 18:12:06 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH hotfix 6.12 v4 1/5] mm: avoid unsafe VMA hook invocation when error arises on mmap hook
Date: Tue, 29 Oct 2024 18:11:44 +0000
Message-ID: <d41fd763496fd0048a962f3fd9407dc72dd4fd86.1730224667.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730224667.git.lorenzo.stoakes@oracle.com>
References: <cover.1730224667.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0477.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::33) To DM6PR10MB3372.namprd10.prod.outlook.com
 (2603:10b6:5:1ae::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH7PR10MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: 194d5e32-2493-42ec-11d2-08dcf8453199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bQfAxVPzYc4eZ8KW5XCFDbdX/lqqONgCAESSrQuE6L1aBFFuqHcxjZtQeuxc?=
 =?us-ascii?Q?sm6bfEkU6nPUx+P68zDp0AJXc2/zcFjtGUurGkuwZnYAiukLaScjnsHHz2zp?=
 =?us-ascii?Q?Nzn9h8e9yhgR4qXhk5VleAV4waTsFa5mQQ2yqja0NbtK1Wx0kGNdRSFmMEK0?=
 =?us-ascii?Q?sJKl44Ca+kxMigiPT+rnJeuTCOLBdRVon254VkKeDVc3aePMLzFO9awSwDwc?=
 =?us-ascii?Q?AtEvdaOUQVRLtS5hqQk154yb4OroXAob87Sx4xbBNycJDrksOVICdDLGjF66?=
 =?us-ascii?Q?XV7GQ9vLBlS4DMF1zbCxDdbbgTA0lbZidtBSgOAitgfGIvSZXR17lPr3N6EJ?=
 =?us-ascii?Q?Tq/jPJ1z1upn4Dnoi7cpV28U63LNW3rhPEwkG7TfTS+iTb8Th0k7sr8Yj86J?=
 =?us-ascii?Q?bldIkYVC+I5snXbZsF3g/+2+nohIQ6gqdvpL5yLPl/ctYWbk8z5E5pZyMKFk?=
 =?us-ascii?Q?1uJSzd24iZjSuG62WEOyErBsYYcBTb3cyM5+bP/PKjkEEvj78yAwQu8v9Cot?=
 =?us-ascii?Q?pk5tHRe1O3QtCae8LRK1PooGUxh0hvX1iCgPUvNyxUGgIvjqq5hqJApJ4lJM?=
 =?us-ascii?Q?Fdj48aGU8zGqATHyi93xgrJCgUJ10ifRM1RmWiAez/Ogm+Eotzt0bQw+558w?=
 =?us-ascii?Q?bow00hqqJrGERYAktJnoLzaBDw4dLAzUWgVxrEUmNWy0OQ4RO+WCGayUfiLe?=
 =?us-ascii?Q?0BgFXiqRTijN/w5QxhIWOXJ8a9C93bJ/KC3RuvGHIUn7O8PI5bhQr87Ys0tg?=
 =?us-ascii?Q?iJukSY9b93vm/b54/IdZSCORllonkeRMN3pwid+fWRayi/lmImaYToMrUQtS?=
 =?us-ascii?Q?MxzQv54cjEd7VAbB5grgtAhQN56pcs1B3pPWgaVnpwZxHVNPbIEK+RD55edR?=
 =?us-ascii?Q?30jnY2kdj/6gGelzODMm4nvL9IFLr91Gl4Bunb7XSoI8wa3Vmw/KM0i99h9c?=
 =?us-ascii?Q?rB0xrhenrxarY3TJ6puxE8xuM8FwSo+6WQsvqgA+JATIeeeDHVq8OslD7gxI?=
 =?us-ascii?Q?IrzTREsc7J/oPSV8sXgRRDqBPmi+gv8RHNMiEwuCsaziA/VYpG5K0FS2Coro?=
 =?us-ascii?Q?0lt1WYh+bpVF7K24k9H+OxZlgxTpff3i7wvzVoWIbRoiVzxeusDG9UX1jUMv?=
 =?us-ascii?Q?wRmoyL4j5su76GkzSE0GmVWSzeVXD4ATVPkLtRgaMfaKdJ1RH2gEYLK7ekhR?=
 =?us-ascii?Q?v8e331DDerqr5MEvRGd2IGf4/T8wwYuXUKpm4MABP4uwASqmr8FcJmsTsCUW?=
 =?us-ascii?Q?Zg1JS1Ag5fE+2aqN6YonkzHZ09yOvRf4HbzSLoHrfEEtKTqALkRy6oDigj1E?=
 =?us-ascii?Q?hVEmqplFuHbkUaZ//drYQWrx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NJa4lLcb9N8Z6CdwaT/ZPR6hgkxiXEhuy+OfPQvWMw1Wu2eVDWs6Vpw1U/ra?=
 =?us-ascii?Q?MJf+hlxCQ4hJDj5/9HceK1dXkffJeYYvfMrcyRIkyTTm2OufDDpC+vXggiuB?=
 =?us-ascii?Q?UO3dwtHDg1aWGcAkBR0U3Qrgq60FBX1lBRxuVv/OEjn3MzdAjCWaRJilQk3y?=
 =?us-ascii?Q?NPRsasKEFL96VuV/Pos7wb96Hm8dVN2+qnD70qz7wwSjEV+f1QnJDuN5yZu6?=
 =?us-ascii?Q?xR2B197JsEde8R+X2Vzbtq/PJl8JlPHnZAm9j2amBH1k51qjjtC2daz4UXK9?=
 =?us-ascii?Q?Hcc6yclz4l3FUEOQnt7xJYE6Q/n0OMPTQ3WlWrv7ZYMfMHSmjyEufzOC9iJn?=
 =?us-ascii?Q?7TdmCAAlzfSNs5NNx+9krqhBoUlIs6757nhVE9migmwCAWd/FicumgWIH1xW?=
 =?us-ascii?Q?xRuWPU7ZUp69UJeIDqqnuvQw3pJtP+PlsZG1QI3d1QGBXPQVoKj1yX8lnaVB?=
 =?us-ascii?Q?HIxuDniXSEtpp+OKqbnK0PIFTo1ySiMGtjUMtsulPtar7v+nZnCCRb75qjpH?=
 =?us-ascii?Q?0YseLCkEqwC5nq+4dLPtXPlG8ICxMe2ZNYowbwSvxTlmMc+LihEMGBGvoglm?=
 =?us-ascii?Q?cr4nWKMPn/ibywFD05Emwt5NoJiMyQ8cwEZPWxihKnecdG8R+n3A502r/seU?=
 =?us-ascii?Q?RqO7c93LfCCm64qiuX1cORSHFnqNWAa3BdQmcL2/Jn19/8oP00SP4pNYlgNL?=
 =?us-ascii?Q?jBetH/PGWM33aH8ld33nheyub0JaWbWakh+5SnAntAXIcg6NXwlOpPtlhP8J?=
 =?us-ascii?Q?mJ0oBky4nnd1FQZZJPa71xp+r8zpneks55ximJb4wOV0MWpPXq/sJiR624o7?=
 =?us-ascii?Q?GaWxoiJbtyCRoTjS02Cgm9v1/+QD2VUE4W4n+IjDuuFd17lzm/cGJz+1Citr?=
 =?us-ascii?Q?PfafKdzlgL2ffPVvNCt29TuiZ846SJgoWZ0trAu6PmuLC6HhMQOTrStqwWxG?=
 =?us-ascii?Q?uw5q2O4eEZDiglq8DWionRZZXwv2M0NikubHWhV8WJdj9uYTDVVqn0H9ZUwK?=
 =?us-ascii?Q?QdTO6RpibG7r5k/34TxpDZIel0pJw9y0GO6nSvbsOhqp7krILLT1OIw+9jhi?=
 =?us-ascii?Q?05JpXAQ2oHrTV6BlsD4395Ilive8nIm7t2GTW2+ZR/KBOGQluf5S3h2cmZa4?=
 =?us-ascii?Q?oRrM1rv0LUR+m2Ebc1W93FLeiLYmWrgZlBoGEDa6mmCzX1zFVc2PoNzrvIJl?=
 =?us-ascii?Q?HkJqZFMG4gyN61lbV4Sdj2Z9baMoJoFwKXOf+BRZkDHMInt3LTZvT1QlHUBU?=
 =?us-ascii?Q?ic4hFX/5JrXxvqvIMZw9WtWrsHQyOoctu/5SumkiQfTJCKXFxIdnNrIPHe2N?=
 =?us-ascii?Q?6cG/74N3opcXJ+gMD5Qv5YAnXEd6f+pFgeCul20AUxz1GD9g6GI5OjpRigz2?=
 =?us-ascii?Q?1CpD7408JIzc8JS53BHLy70Vqs5cBZFaxi95E/V4UPxzBQCp9DJpRBQB74vV?=
 =?us-ascii?Q?LkAndOcwTnGaAY8QhtXDsi2LFgtZBsSHrRP4kRjzLFTaIL7XFxD1S00+5JNP?=
 =?us-ascii?Q?IAXNqpp+1jCVG1P1n5CLLgP3Mufv8JeMAQ5+dLS/i9bts04bNv1IejbBQxvx?=
 =?us-ascii?Q?Sk8tjflLxurzCf9r+zNDN6txygenkugpVuMwTt/Z4SUmgZZoV8z0377B3LfA?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Jb9YVM9RR6gOfagxM9NROlWcGpVaEqIxk/pA2TsV3dtyhDW23gw00R1Xxv6o0TPWJ+xb0zhdWYbdwx6HxFIr9YJLYB76F4dkhmKJLLB9M0lQb0RfNHQqaeWYC/XLI9yhbtvgYO+0jRhnwYMnx+uX+vHv+vfXh4f+XLAzK+h+1ryEg8x+Otcdefroe7Gj29z1hTGDj2WnFHYspi5r9+MDeDXCQbg7qjvxuUloJFKA7/zqVw+Qk73h3BfvDZbuaQwsKeP1+jtc9vcfyI8GfDmBNZF7vDMy7+Mt04oo8HJXPyB8mEJIDFurqsE2LzpGioELVPCzdK86XD+qkiYYphHTjRO4T+4PltQfHV0GW5x+J64sLY/S6uxKAY9i7FEZd723icwnpU1UiNhxnuCHrVf7Is2XtqVysa7CScvfDesmSULkj1XHM595C9Wpg92d4yFN+/SHLlkDwXVn0gcq7cuqM14nKMUAxi6/BuZblIxbkH5djy4HvxLLwEYhcmQ4uVzBhyn2b3VQ/xqtKSWHapTZU2FRblcu9/pRZgdACGhDNEYUdXwoNtqFePrcT46iq360nLfojqr7fh1RAsUn+EWbR/RQ/oE9BKHbB9F9n0qxl0k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 194d5e32-2493-42ec-11d2-08dcf8453199
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3372.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 18:12:06.6439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5xJbjUIugUDVHmzsE+DItTqZOekyKatPTNw/UyE+5/ThqFsd2siIBGfXuADZom4X1K0GOYp2Hg0QqQobdingvfwYIlhVTiPXGVO1eTfYYH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6966
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_13,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290136
X-Proofpoint-GUID: B1eScH_Bx0LjuE6DA4G7ap2Qg8T_BSOM
X-Proofpoint-ORIG-GUID: B1eScH_Bx0LjuE6DA4G7ap2Qg8T_BSOM

After an attempted mmap() fails, we are no longer in a situation where we
can safely interact with VMA hooks. This is currently not enforced, meaning
that we need complicated handling to ensure we do not incorrectly call
these hooks.

We can avoid the whole issue by treating the VMA as suspect the moment that
the file->f_ops->mmap() function reports an error by replacing whatever VMA
operations were installed with a dummy empty set of VMA operations.

We do so through a new helper function internal to mm - mmap_file() - which
is both more logically named than the existing call_mmap() function and
correctly isolates handling of the vm_op reassignment to mm.

All the existing invocations of call_mmap() outside of mm are ultimately
nested within the call_mmap() from mm, which we now replace.

It is therefore safe to leave call_mmap() in place as a convenience
function (and to avoid churn). The invokers are:

     ovl_file_operations -> mmap -> ovl_mmap() -> backing_file_mmap()
    coda_file_operations -> mmap -> coda_file_mmap()
     shm_file_operations -> shm_mmap()
shm_file_operations_huge -> shm_mmap()
            dma_buf_fops -> dma_buf_mmap_internal -> i915_dmabuf_ops
	                    -> i915_gem_dmabuf_mmap()

None of these callers interact with vm_ops or mappings in a problematic way
on error, quickly exiting out.

Reported-by: Jann Horn <jannh@google.com>
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Cc: stable <stable@kernel.org>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Jann Horn <jannh@google.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/internal.h | 27 +++++++++++++++++++++++++++
 mm/mmap.c     |  6 +++---
 mm/nommu.c    |  4 ++--
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 16c1f3cd599e..4eab2961e69c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -108,6 +108,33 @@ static inline void *folio_raw_mapping(const struct folio *folio)
 	return (void *)(mapping & ~PAGE_MAPPING_FLAGS);
 }

+/*
+ * This is a file-backed mapping, and is about to be memory mapped - invoke its
+ * mmap hook and safely handle error conditions. On error, VMA hooks will be
+ * mutated.
+ *
+ * @file: File which backs the mapping.
+ * @vma:  VMA which we are mapping.
+ *
+ * Returns: 0 if success, error otherwise.
+ */
+static inline int mmap_file(struct file *file, struct vm_area_struct *vma)
+{
+	int err = call_mmap(file, vma);
+
+	if (likely(!err))
+		return 0;
+
+	/*
+	 * OK, we tried to call the file hook for mmap(), but an error
+	 * arose. The mapping is in an inconsistent state and we most not invoke
+	 * any further hooks on it.
+	 */
+	vma->vm_ops = &vma_dummy_vm_ops;
+
+	return err;
+}
+
 #ifdef CONFIG_MMU

 /* Flags for folio_pte_batch(). */
diff --git a/mm/mmap.c b/mm/mmap.c
index 9841b41e3c76..6e3b25f7728f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1422,7 +1422,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	/*
 	 * clear PTEs while the vma is still in the tree so that rmap
 	 * cannot race with the freeing later in the truncate scenario.
-	 * This is also needed for call_mmap(), which is why vm_ops
+	 * This is also needed for mmap_file(), which is why vm_ops
 	 * close function is called.
 	 */
 	vms_clean_up_area(&vms, &mas_detach);
@@ -1447,7 +1447,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,

 	if (file) {
 		vma->vm_file = get_file(file);
-		error = call_mmap(file, vma);
+		error = mmap_file(file, vma);
 		if (error)
 			goto unmap_and_free_vma;

@@ -1470,7 +1470,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,

 		vma_iter_config(&vmi, addr, end);
 		/*
-		 * If vm_flags changed after call_mmap(), we should try merge
+		 * If vm_flags changed after mmap_file(), we should try merge
 		 * vma again as we may succeed this time.
 		 */
 		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
diff --git a/mm/nommu.c b/mm/nommu.c
index 385b0c15add8..f9ccc02458ec 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -885,7 +885,7 @@ static int do_mmap_shared_file(struct vm_area_struct *vma)
 {
 	int ret;

-	ret = call_mmap(vma->vm_file, vma);
+	ret = mmap_file(vma->vm_file, vma);
 	if (ret == 0) {
 		vma->vm_region->vm_top = vma->vm_region->vm_end;
 		return 0;
@@ -918,7 +918,7 @@ static int do_mmap_private(struct vm_area_struct *vma,
 	 * happy.
 	 */
 	if (capabilities & NOMMU_MAP_DIRECT) {
-		ret = call_mmap(vma->vm_file, vma);
+		ret = mmap_file(vma->vm_file, vma);
 		/* shouldn't return success if we're not sharing */
 		if (WARN_ON_ONCE(!is_nommu_shared_mapping(vma->vm_flags)))
 			ret = -ENOSYS;
--
2.47.0

