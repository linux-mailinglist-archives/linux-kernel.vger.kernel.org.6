Return-Path: <linux-kernel+bounces-378802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C299AD59F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D38AF1C2230E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10F31E8822;
	Wed, 23 Oct 2024 20:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mDLV1RSF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ncxS35y3"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C1D1E5735
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 20:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715951; cv=fail; b=Nm1xxOzn1LTsb7KlFr7wO5GLjGW8qlX70O7IMNPxJtmhmd5+iGjfYAGlZaMvOKlV2htN64YFSR4+Z1ldCGX6p/8HDf0Yo5/nT53/Nq5wi+78AdTcphafYFcfRQ7xCJ2QzfKzC/VmWc3MLNwmv7kSXU+bnO8FpOglkhjFD1W/Bw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715951; c=relaxed/simple;
	bh=U/VqoPvSp3QgbdtOKlkpWFmnYRwaaHQU0SRBD47aUoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MdWqtC79wojDnOKjOnZxgezNfuErUxoH32gozt0OVGgZNooZ+PkHU6gmfIStJ0i6bSoMrZQRQJqsNCN8CPfRapw9NeAgglpquXaZgzWM7Y/yB4r8m2Bdg4cmcJtpkjw0vVMeZh058jvymZ7pQco9kfHI3P0SaxDRmJLLmc2rHJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mDLV1RSF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ncxS35y3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NKcaVB026722;
	Wed, 23 Oct 2024 20:38:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=GoV/SXOqaoQJF6Y962A0upUaI4C5tg8OVEAFdKWNTU8=; b=
	mDLV1RSFcwAqq0lHdBl8LBxAJeqYvj+hjmbIEIjxiO5cOb211FyG7zHA6X09W4pJ
	Mt545YKd0HNS0zAGdbMbXjdT4J3Fu1esPtrJ5Qj6x0k8elW8SOhbr14cQ9/GxZge
	XNh8wg1zxG6SQ4b+A2CSFkykoPIPt2F2HsEBAwXhJ4Sb0NXP26os4lME1p9EOXJ+
	rb/4gUuewS7J4b4JTOy47NFyYpknKiKM8lFKQ31WgrfvjrXDSQr7hzVHKmPknlYH
	mLmazHk4b5rNSERD7d0191yyb+amxVztPBHJzpuQmTEQmsGJG9AJbDoE3PI/3gSX
	802bH8QnpdP6PEgHUBonXw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55v14fv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 20:38:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NJ8ndL027496;
	Wed, 23 Oct 2024 20:38:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emh3bjwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 20:38:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6YR/W7+tVMaZTrxwZKJRP09virM6kTQGbGO32O5li79bMi44RQtiQm9Hy1Vlbo3sC84nThclgr+dqnm/kwCwhID/5pehiV03+AhCzrQgWadtI+KuL5RoSvaW3cH7RBiyYqzKX45Y8s2Rys0R+pOLjikb23PAtS5P6XMKr2gvnu5vsCsL9TRsOsGGVppR2S6HMszTcPVT3rDao+r/1anu8H5ceNXmk6HePnzFw8cZr6GMGUTkx+UOoTJ+be1ecf69XxO+oP887w/32EdWDlvjhntrga7ou5C6fMu/8xBT8srnyKLpFACfyMAvSqvagfsbSRkqs79f5J4BeV/pXvsag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GoV/SXOqaoQJF6Y962A0upUaI4C5tg8OVEAFdKWNTU8=;
 b=S56PHo9kk3XqtuW1igiW/eFZxNGCihVFzpiTJjiN1ti0gz19Ieuju2SGaLMWbGqRYcPnygJ74zMhlGxMkOOttiLSZmwFfZLjDlwSI8Qbc+q6yxBvYXJq4iskM2akhHNjqGG6DyOgpY9+qOYNfAonCCjxtDKLPGdPblXmkZ8OFUVETxkhUqts8pGAyMwfum2PdFX0sBCv8tuxZ8FMPNHA5+3HJeNZtgkI4Rdjfw8pN7AwCQPXZa6gWrL5ITecFNv7Kf7kH033mGOe4U07j4k4OkpSJojDVPjI52c5UESeAor6Ev0PGKW4/yPDIpcIda6r+fawzHsLzvcPrPpdEy5hSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GoV/SXOqaoQJF6Y962A0upUaI4C5tg8OVEAFdKWNTU8=;
 b=ncxS35y32JBpihG9WaLuv0ymC4l/nkwVtj32Sy81dL1WWA+44B+ijyfNSbWYGeQ8vxiTztK6O5DtWveO2BY9XJ0ig16QwUkQcxASAmLk+T2vbeVpmTC0eUVw/9L4Dv1AfZa/samrcY7nzeCSomr9rTbGniulTgChqHnNwllqLyI=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB5833.namprd10.prod.outlook.com (2603:10b6:a03:3ed::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 20:38:52 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 20:38:52 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH hotfix 6.12 v2 1/8] mm: avoid unsafe VMA hook invocation when error arises on mmap hook
Date: Wed, 23 Oct 2024 21:38:26 +0100
Message-ID: <69f3c04df1ece2b7d402a29451ec19290ff429a4.1729715266.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729715266.git.lorenzo.stoakes@oracle.com>
References: <cover.1729715266.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0012.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::19) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b27283d-c3df-483f-f08e-08dcf3a2b479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5FMzz/agnPPgTvbwQPjJjvoTCLL02RKS9WTSlDJDr++1bRblfAge84g4xg3r?=
 =?us-ascii?Q?WuSoDBs+FHgo9lfJ52CM1COyc+V87TT2OrBns/WPDE75Ylh4KOZ+fmq44Dqt?=
 =?us-ascii?Q?yoacgSxJxd23G1khMTnUGl7cyU7jVBQzqBUVZn6n87ykncRYm1O7MmCjxH2p?=
 =?us-ascii?Q?bsLxPrSoscAUWpe+HilBQy9Y2DjNHZ4U/hPnaw1VVBfcsdltPZ9KoBqbZHtv?=
 =?us-ascii?Q?1XzJA/v5SipeUeSSlMwZVD6GnK1fobd34xsbYy7T8rFzaeBWSzDi77PdSiII?=
 =?us-ascii?Q?mo/hXj6o+cNr4a61WzfgEMNGh7b2K+w5zb3tmqfCwzv7JdZckSlG6LGhdvzt?=
 =?us-ascii?Q?zu0hs78OAu0BjUgKQrAyO6fOMvcXp7+RtGRtE3Wf6BpXJlu04OR0jrNs/6Lt?=
 =?us-ascii?Q?Q1ynLI2Au+aeVFGrhQ39h4aP6UYLRVD/+pyOacifjDEcSBVgmDs8v0lYUJDT?=
 =?us-ascii?Q?ibuu6a9X2itlgzS3yLPSHkS+k3oTb2FBJXlUzjUULuYltTRDMTBmHXPpINlw?=
 =?us-ascii?Q?BkIxGaH8Crtke1NhKddL5WBq01M4FYafAB+1ktayJcPsJpnsIyD9Ms3C0Zjf?=
 =?us-ascii?Q?ihn9ch+ooG3gxxu6T1OoCtl/lI1lMrhDn9sl3AepFIa5IwAGArdnLOuQpzW9?=
 =?us-ascii?Q?osp7ZZROeJ8vBEAPBFf7VBCDHn+b/8gIuq1FsZYND2dquhEKtEBYWFslk4Vj?=
 =?us-ascii?Q?gbjLOt0OFoI7Zry2vVdqvEvo2xkq4wpW9A/C9wv+wEEU+B8g9hp9p4Me7j99?=
 =?us-ascii?Q?ac35GAcico9VswOiTwS4eDtgs4AYDqSwkTsjWd/bVCGrbp4Mo9EbQ3t3KDDb?=
 =?us-ascii?Q?ivbz04/3XQ3o7OOKlqzmQzHJAFCUVwRgKAzjJ1htDyLg4WDn3v2Jcm6QE8e2?=
 =?us-ascii?Q?+/FZ5+SjfhcAJT9mw+BqEr9w3MNAQM/7/mcorkMaXnb6pXCogwJ4qtQj/p3u?=
 =?us-ascii?Q?1TWMdpSJQ2czE0jRKoV5JzWlVxK+vn2qnu52l5ZPLn3uuawoYKTSDQoeUqGt?=
 =?us-ascii?Q?NQXk18qKiG+MgxrsXf4QoIsRJw2Vvfjzc1mct4+LtYD0jj5DZ9lnpSbsHH5b?=
 =?us-ascii?Q?5KP8UxT3wkg+8U0SPE/hYsFjFzKU+8HeXz5efNanqKSb7ZXXyrhxE6fH7k9u?=
 =?us-ascii?Q?eYS4/QCsHQfyY2s+Pr7Trix1qX5casA2lyX3LTIyHpmnbc55l8iYzNWe7MGj?=
 =?us-ascii?Q?FfP4Djs8w7tztHhigHkH0bcORD4PY+bITZljWT0elkTZZFU/E5xR2lrBaHdh?=
 =?us-ascii?Q?xX2ee9EGdqyrRwSX2e8aaegY0uQCYW89Rm8JlFfTIFFL9XFBn/qghXg+UYK0?=
 =?us-ascii?Q?YTQVYv6f6+T8ceK4nZQWz8LG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZMQ1Gvd6zCBXXxtzXig2Frz3zU9AKhAbnEhHOfc2H/iZ95Uuze+EX2IX8lz2?=
 =?us-ascii?Q?Nb1OL+uS19rMEA/Uq6+PW9dXTCs+NE88HBUSjrw902xMBYtaB9bwGnmDdL1V?=
 =?us-ascii?Q?6JxFAPMV7b+nlwtm0peRdxj1Ir9OxGSaOJRgf/9Brie2F1JLswFc9IWgtnzY?=
 =?us-ascii?Q?JfDDFTD1Jz47+uAbSgit5OSPA4C6mi6qGVq1pj7wRkdpSShlEc0QytggG0E1?=
 =?us-ascii?Q?IcFITZa96kSvibGN0UbmbjF7WPw+s4zsV464L4vQnco17NzMcYOla8dTQrjJ?=
 =?us-ascii?Q?Mp7nLt4SWbOJpfJEugpgI5rKaDxOr9NsSD6uxJ869/LZXDkQLgoV6AOABKN7?=
 =?us-ascii?Q?2iiEydxzBPeXCG5lVF5asww96Iu+kRUuf6kR0g1O/U3O6gzUI0jTC+v3koaS?=
 =?us-ascii?Q?mL/OIzZlOpWi/aikQ202alVr1z/Ik2eREgJ6ChFQipHQLGpxekisA3YmlpNO?=
 =?us-ascii?Q?Gwi1QRGfLsiM0SBXk6LSE6P0/RuvKsmAqi03r8Mq4yA35nHNRPhUMCEKe/MQ?=
 =?us-ascii?Q?coVtiWIMzZWRwFFv0cKDLOVk056hOqhFr3gWvkdA0ytZfZi9SVBqHXGoWE3e?=
 =?us-ascii?Q?hp8m4HzIOCKmR5ITQ5xXXV3fmmDkLYdQi8ZtQ0QqTbpEt0nn9qlsR4mn08fK?=
 =?us-ascii?Q?Az6PcJYmAUkGsNI96N55AU5JVUC4IPdLX0ggLZpHlm37hv7cGP0fec4dT4FF?=
 =?us-ascii?Q?NQCwvkKy0+kDrzMt6VjtUHKoCIDUUZCm8AqtRKH4EUeUQiOtlSQIUx8EyYoj?=
 =?us-ascii?Q?zFjq2ktgKJNB4ZN+NTKq2PZbd3KM/kFaQMct4Uubhp6sIiaghr6wyctAqfM3?=
 =?us-ascii?Q?9gSx8yzMKsuRD6KlkenDUYfPNNwAogB/GvrjRAQ9mBUUepD3x5vq8j9ZolYe?=
 =?us-ascii?Q?rFJab+oh09L8gcrI94hyE0llK6mc5/4AOxB9jNRLRO8dD3i4voO6V6jMeaOi?=
 =?us-ascii?Q?4OVefD7FmmOj+ykKaMxaWp05Q2uS3i1zK0s+qsDIonlB1WYgzuQ4ULQczA2D?=
 =?us-ascii?Q?opx7w5+HA5nJe242SGzKNohsFu5JpiS8Q07y3AxYgb6y5vfWTv465xcfJDW1?=
 =?us-ascii?Q?cfqmyYIWj3NSQl9+GsD1XdS+Ya9PhPr/EFHP/STH0gRqlO4PT2DfRrDVEwPh?=
 =?us-ascii?Q?D/gcV+d7CXmxF2xjGScVr+L+Fdy2jobvPWF90vVdHSWTCrqyxrqm+4W9mVm9?=
 =?us-ascii?Q?tlgC5Mdgwuiqpi0VzRDvqe8NNMjwL/t52R3FdhrcaUjrxIqatpp/wXhi2eV1?=
 =?us-ascii?Q?8EHsd2M/CBb4QahQ3uHHpuuCQN9hmq5fMibjHdYn50I+SbZeF625+rWmNTOo?=
 =?us-ascii?Q?HVC7+NEXJJHoRIWn5+7qET7L5aqC3FmU6TqH4jK95aWp2sQ4C0+m+34UTorU?=
 =?us-ascii?Q?e4q7agSK0L4GLsrPDE/zCDN/4+xAbyfQTkEx2fplsW42aTdjd3QRJFqvFeFG?=
 =?us-ascii?Q?mVNY41rzQ1Hli3kvAwchk2v6X6MFNN2Bp8kE7CThF4ikisqR70I1IHa3oGIv?=
 =?us-ascii?Q?uLGuklQo/8+lmL4DdDzk03uPmWlvCFZj4582nOaQ9uxeOg/9v8tK5MCsiH+I?=
 =?us-ascii?Q?sn95/Vep/giMOQ+Rg3lXYdt5MT+wCmDN+VmccrMmb6kaSiWY8B+xiGwa4PK9?=
 =?us-ascii?Q?2rLIL0orvVj2pm1G9wzAvHefOIk5Zfxt42TO22oOQbVO6tQ6yIpW40UJvNvv?=
 =?us-ascii?Q?FRU0rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Aou/9qqGc0ReEn9gOXVADm31mcSjK85tauEwTvkT6x1Ywv/Z7ZJDn2espdSmNpbwhSJccawy6Krvc1ChCOm9/nnUj5+zrKpPakhEEq+5zpcy5lczvudacdzi80GPab1i+oaXrdaf8z6vYDRgMLwvPGfr8S/XTLSiJ6L60iXc203q9uRC8KSda6/92dSHYD1+/dD+Dj2rExUfxY0CG8HDZhDiR72bWpdsyY1AD343G73ssKqYtJKMuzaiLgttvt1INNS1o5KMX8R55ZAk5xTCYlz1yMkBhfUpkUEKMCEVGCZ1jXE4X1RtcA/mNX1zIzb9M1o4w80pJHr4OLIkEi74q5t4q64SwlPKo5WiTAFwW8ZXxaMPKYCfFfw7aj3Z3AwSICHkG3Jap5u+F3wqyogzA07JA3J6bDLjY6tw24ngd/vb13Of+okoqA44wsolyMMIBQskLMxYFNvjkJWZG2v4DxazNX81UVw1sgDWIa2C/497GhORFamrsYTN2QSqflahJ4chbltjrpmJANmkKnYxwZ2vktbAI1FC42I46yRVYnTuUM8RV7Gqh+sL+HrtEpP5r7V8t1wvNKLhJjw1q0X9x+JSTOSPVYaKq7q6ZTYeW68=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b27283d-c3df-483f-f08e-08dcf3a2b479
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 20:38:52.0661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uIA4w2DI3F9qNt+lZNffz4TVxRCEz6XXtN+4FM2FuiLKuMOCANnJNIjZkypxE5ydWJNPlVmlzcxOrxhc218pXulGWx6P86cmPVK1aFB/8DU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_16,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230132
X-Proofpoint-GUID: 9UzNX2otY6yG9b7VdoE1gg2T7uVYINpX
X-Proofpoint-ORIG-GUID: 9UzNX2otY6yG9b7VdoE1gg2T7uVYINpX

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
index 508f7802dd2b..af032e76dfd4 100644
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
index 1ba0878bbc30..10f4ccaf491b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1425,7 +1425,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	/*
 	 * clear PTEs while the vma is still in the tree so that rmap
 	 * cannot race with the freeing later in the truncate scenario.
-	 * This is also needed for call_mmap(), which is why vm_ops
+	 * This is also needed for mmap_file(), which is why vm_ops
 	 * close function is called.
 	 */
 	vms_clean_up_area(&vms, &mas_detach);
@@ -1450,7 +1450,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,

 	if (file) {
 		vma->vm_file = get_file(file);
-		error = call_mmap(file, vma);
+		error = mmap_file(file, vma);
 		if (error)
 			goto unmap_and_free_vma;

@@ -1473,7 +1473,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,

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

