Return-Path: <linux-kernel+bounces-428921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A49C9E1502
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FA291647EC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08271D90A4;
	Tue,  3 Dec 2024 08:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EBHMYrfh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IJtSn3AG"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09B02500C5
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 08:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733212872; cv=fail; b=UZ354+Zf00c5ucau90qgyt7kcOh0GUWTC1XMgXnMLD8EjzycvMDJ+CaoCj7bEubPI42i1gslJDheYIdUvoZPwlrV3h0UtrmMTloXINaPBZj9JluL6pVxnju4PtUt98IwANQAl/GY1oR7MFJDat3/tLurIPX0IzkFc69FSh1Crvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733212872; c=relaxed/simple;
	bh=4oWTmuapwi3sW3JJvNHNq/1JIJnpcUwd64SHv4LEYYU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WAcPiQP6dKv8z2wWcxBU2UmF5XZ7JRLXH5CSO7A+ZqCUYBRXWNC3xsmfpVInZktg8OrKBh2w3K1RGGFDD+KgSm8gst9QHW0O+AhVLM1zwxOzq8/+8b1EI52hSpbUzvO6LEZxJbGNh9k5aowQ7L+IKpk25bizEaaMnmFG0UMzy60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EBHMYrfh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IJtSn3AG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B37Xa8T005034;
	Tue, 3 Dec 2024 08:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=Kjv5HpEm8Yc7cUmY
	2J6WQVe31q96waX6YgUXJD6cLUQ=; b=EBHMYrfhdw09uIF9j1wNbrWW4r2j/Exf
	IK6djQlQ5hBF2z2VPGLoPuDn6OhrMouUyEEo0lcYx9cEn0M0lUsz5f+WK3EUaOBa
	U+MI2UGZoh7qwfmKc8TI4xraD0psuFwLOVR2yS31zFfJN5rcqhPGGDxAqC4D8Pi8
	1zq9var8HEGzfrFVlTM5rvsJKVQRKKzfH3xjZ023knsw3NMFFdGgo2ctVrS1/t2X
	IhSfwnjpltgFF7PF/E9d/oknt6EO3nkrUYe4eUILmneSyGstbOYwsG05bAqmXx7u
	YyAj+9FJusBJHnL5Z/gcCzyQMe+oCGECL7JNPXgPkdrd8Fjsoo+qJQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437sg25hew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 08:01:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B370lp1031180;
	Tue, 3 Dec 2024 08:00:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437wjc7j41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 08:00:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEKxWUXnDnZQst56THEOzkpiB7FwFQCwURbTg6gMKGmvhJtsLAu6gWKLCejIPhrP2OXVJ7VyeqVAM3GPqD99GzYOH6ubBUZcb972yQDGcnI1v1dDac3CFrub7i/hGQUSkbj9ZBnQ4XvvSCYiHAWuQwHkd+N3eZEUAsQ1q1FipvzAWKkDVvtDYWHuN8tdvsa/sLjc5ZFkvUrpbUqvWvtA6EFRgWnxE91DnZ3gi0AaPcyQ2vpFVSJ1mfZjFK/cpk4coh/uAzBclkv34I1R+Di5FjUqLPhqOG6LcmnaBXDKodGPszOqVQocJ3s6CnSAb+dRi6JhBDrORQ2g2gSMUoZHVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kjv5HpEm8Yc7cUmY2J6WQVe31q96waX6YgUXJD6cLUQ=;
 b=EQ2SVjhji+BjXbn9aKiTYT4NdKnWkrOoDqz7XmHglwp3Fql0xZ13cZWQmmIJ9UDQPrGNdN/NmlAqhIuI7y6eZV+gtBtZdLNSwh3W0qossrEoFkeUFqgW/1SnBbg7nIszEpnk39SSsKOOygbnjN8ZeD8qW79CDWCxGLpCCDiqzR65WYfTT0O29hunmrLPxkwGWn9BiFeC743p4aOoDe71Len/j/R63J8qyzI3ysO8dcf27dU8veIod4NOXv+J8k0tWajJw+vYUO/cVXppRn3VHfuPwn+kXsP+M73v8ZeyztJz51hQmkKt2P4mCGDUcmKL4m5D1ZWhCFmTvmg0kVPQQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kjv5HpEm8Yc7cUmY2J6WQVe31q96waX6YgUXJD6cLUQ=;
 b=IJtSn3AGjDvXPaCrM/N/qgQBfTh6MyK6cg7YMyR32b1+SDKl8DUDsegsk9OK4W3h4SITTeAps4SxqBbhUMaIwIl2qq9rCOcbiJXxg/Bt5WoJkFEFNBttw0lNRgRusRP/OEM7mMEU8Nml53cbDsI+vDyXLn1I5HfZiLVgLRRORlI=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CY8PR10MB6444.namprd10.prod.outlook.com (2603:10b6:930:60::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 08:00:57 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 08:00:56 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v2] intel_th: avoid using deprecated page->mapping, index fields
Date: Tue,  3 Dec 2024 08:00:01 +0000
Message-ID: <20241203080001.12341-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0502.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::9) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CY8PR10MB6444:EE_
X-MS-Office365-Filtering-Correlation-Id: de78b5a3-c88a-4f00-2420-08dd13709e1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BItn2077xc9THXzqhbfZVr75NWkczNmK4hfNVvaeBKh2GF2bZVlRmkcx3Gul?=
 =?us-ascii?Q?3gNCaiWFVuLIEQ6lHsZx52RRoio6LPyRaN2btVqEDlj3t3GGCWHkksjsCwKL?=
 =?us-ascii?Q?fli3Ew2e2MFzlC7ZRpawxLTkoGT2SLZI72TUpTFE+fq0SD+G2FA+mYz5VR08?=
 =?us-ascii?Q?7uIvWFMZUP7FkmQL6V9ik+G7FX7OPnBNT6yKOe2CEs34w7ZsIyrhBujBCdHu?=
 =?us-ascii?Q?yWrr+Pt9ex4yjB3zN0pxY2o1fBtAjmxZ9IiDJU85KzCy0i7zPA/n/60q7l/T?=
 =?us-ascii?Q?O9FWtWCWnN9VciIfMDMReXq5nterh3UYyu+t7v1tUif4hdKVKVhgzKLUxzX+?=
 =?us-ascii?Q?eHiFLEtjB1YaaPzRAqLTh5OdYDm89WPImgBpkQz6DdvBmtqYsNoG996a8+gQ?=
 =?us-ascii?Q?aPBlPNamDOSiNN4MT62ZXFsYsFuqzfj9lkIA0wYJvhmpoXKHMwYno+jvjHck?=
 =?us-ascii?Q?gL/HFgbKTsqf9GoFyqrvu/RyBWKtceSYzDO7viDYa17USKorAGIakNgEV3Se?=
 =?us-ascii?Q?PMtClPqZ6dWkB30b99sLqj8fl6oz5e/7ehLS/TCz6vAkueEdo1wkHwAYhVCU?=
 =?us-ascii?Q?em1e5lrBzKFmb/rq7wNF3AsCg+hOCkxke+eWel3HWXu0O3UJuW6DikpfJUIW?=
 =?us-ascii?Q?to8Orf4mxf3Q5pR2VJdG1oE+GVD/sLsSrZ/dPbIagGvcJ2j+pQsBUscOakMy?=
 =?us-ascii?Q?8Pe5qCrdfMW8pqgOJ8QJG5l/d/oZeGd0GP60Al23dRfxBO1EM3sR4/o4HEHQ?=
 =?us-ascii?Q?mf3Qtp8pWTYXUcMMJz2R7mt/DH2mUdpFM/2xvxNqN4a9Al0CXPMpOClMBLnf?=
 =?us-ascii?Q?tSuZsUbwv7HYuXGz+rKPuKmUiuAGEMJxyROes/W0dZchtO5Z03G5ziEZBrdy?=
 =?us-ascii?Q?Vmg8OcbE8RR9vJGFA3UzVBS2tcF3ut3XxtmnSq2pzmchrn2b1eAlloLCUyP6?=
 =?us-ascii?Q?AmMG6KAFT0+KFo8yk6iy8UqcZTGJZHn8EVDf34lt/wxaxBOjZMjqKP3LRtVI?=
 =?us-ascii?Q?A6bgrz+wIkCO4YeK5pPq9EjOyEJ8pszL0RXsSraeA4m5/QYkHWh0M/T1N8Sg?=
 =?us-ascii?Q?7rYGN9orVfBGjUpoKv3AZMRH7dDE6+o24q4xFSMZPmdkEAi6M3l/pvZ99Uo8?=
 =?us-ascii?Q?u8OH1ZWM2C1Oyzp+sj+5X5dcVkz/B384A0SE75IBqaXpjsKIyWtCbY4yUXzt?=
 =?us-ascii?Q?kzuxHos/vbPKE/L2fEku9l64QL8+K9YCLZFvmTI9ZiFNzezS23NqewvbETOQ?=
 =?us-ascii?Q?ime0yJz2A/c2OWP9npK23arfVPpWXGbbUvQ4k3JIDsqxHk0S/yNjdCkrIhL2?=
 =?us-ascii?Q?E9McGdV80hXtk9uWLjykdKzXFwlA1RyjQRLNctzYyn5zUw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R4cgrc1ke9nN7BLDethbmdgJO/awClVcjEWYSHdF1FKlacRdgN+BIskl7pD7?=
 =?us-ascii?Q?9DqB5VzzWH4gVa3SdFOuosF678hbazZVcjsyOE9WAjIKl1aIkIt0JLQusjiz?=
 =?us-ascii?Q?YWUnThASxxB+R44VKFN5Hgjose2HrsfFRavnwVyP3rJPnumWYx9+nF+dtFec?=
 =?us-ascii?Q?ksSJwwH07DRZodbQoQwbmngYdtUxnCCBQAHUm5ZNDVCn8MDsS1W4PJuO7yKZ?=
 =?us-ascii?Q?Q7rhD82bMc8y+SrUpY6N1C8KF/MTzaLhv6MSQElfNri3xMl9Ucxjg6w/L9Ip?=
 =?us-ascii?Q?2Y61kIfS1M3CNcyeq2lnOv+wmXxPpJpDvjTYxIz2MDt9CGlnskOKCHFOcVYi?=
 =?us-ascii?Q?Tl/+x+MWn06ynBJ/048MUl+w9T/jRpT21Ol8517ZfiVFzySU+EdZZEVnqIM7?=
 =?us-ascii?Q?gRjaxgFF8WQWUvx7YPHlIyBSQ2MnF2ef2WvL9m44Y0ZSmuKm0d5+2M3cDKiR?=
 =?us-ascii?Q?Em21hCkuYMIsAdU8a+G2wHEIzFeW2b82WGguTpwKrHH9NtnqXI/P7mtcGrko?=
 =?us-ascii?Q?WtHf4sD6UW5q/NROKK04jVNuPiUNDm9yPCxGjgL9u58L0nBET/bVNwXCz7PO?=
 =?us-ascii?Q?tHWucsuBxiGUrHRFYEpwlkQM9WmBUeY9HQE02Ev6T5AQp+0DCoxTw4x9HK9K?=
 =?us-ascii?Q?XYjpuP5DGXOI4mWaxG5L8l8RQ9VemSYVlRN3C0kBX0w29uFtz2n5fNom6FKb?=
 =?us-ascii?Q?aoBAn2fAPgjWzxXZnZd43DSWMN/dhJo9D1pRE4chfjOs5rkW7As2GIWhS6sg?=
 =?us-ascii?Q?EFpXjXoOhVfiAyZGAI41dZaPoIeuYyN6DI4itQbLVH5a1GspNRSGdyJTWrYC?=
 =?us-ascii?Q?jfkDwHnDeXmwBZivNWZBWXwlrcKwEpZEHHFSNAokUHuFZm9ee4TXJs0ZNU+c?=
 =?us-ascii?Q?gWk8Ee9DnM8gOp/KkZMdOvXMMHNdfmcleU0kBvoY4AL9PZBIM4XLJQYHmEBu?=
 =?us-ascii?Q?ey4xRRbJln4I3gGBMD5Kv98eM/LZsl00GlRx+sUkV5r4I2AmgCqwmsBUi8am?=
 =?us-ascii?Q?6n8gtIJYwOvpmJ9raaLHxNMgP7LEGwBLhVRo3nQ+04Ojf1L2Tz9dI5haimI7?=
 =?us-ascii?Q?ysLe82/XD6NK3gxB8wTXxiqACaoy0JaUCzXsnLKX2VhL/W6b5spq1QcVt6Is?=
 =?us-ascii?Q?D4QZ3lYjd0Fu66l6pqqsMBxc94FJSKFdEpUdGS7lULC2zxvKyiCMaAyQPRc8?=
 =?us-ascii?Q?w93QsNq95Ami4qacV7zMVuMvfscPzHb7WTEpJE+5dxaE5y36xZH2zvMDs7Rf?=
 =?us-ascii?Q?imzkbKjCjborpcmZJTBUp4za5MNefRfSFuHx3BQw0U+8aADLq4uDWLLPPlZF?=
 =?us-ascii?Q?JblP2H4Wpl/mRNCh9cWpoi/Ea3ulR/YzuKgjRzQnxlvgiVicSWpyyDGi899P?=
 =?us-ascii?Q?Ar0MRnmScCFrlaBHtQ+hFjPQjFicN5zHrJnqYs+BGXkAUTdML1Zkzx9JorrZ?=
 =?us-ascii?Q?/UlmDCgWzwYEpLkdAXZdXSXzP4SdgJ4oy9l1uKEje2hv+UCAvs1bETzvCeIT?=
 =?us-ascii?Q?gpnl1mp9KjKXwyQSUPzdsglqqX3RRHVEK/ZU/4g08jQ51eucUl1UBDkqTngh?=
 =?us-ascii?Q?xjyPfn11j6iI4vDQBWz7R5OTjAYXgALK8yPGUUwhYV2v9Ffg0U0e7sgjZW2p?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	POR0aA0RuOjqOQdQXpZ+A+B2AO4Xaa4K5mvubsF/yQ/8UDg5nqyNsbX9SWCbIk0z46dvnME+AoffrvtzaxwUBlKaLqqv1kK2yWkzbbq+ymRYX8cJqRK274N+mw8WuPvaEznOnfxBm0DWKXyOWLyE54gq+BRxvZ2XkxfX70rJNlLaFSw/1BfqutWQqpjmmw9THzLW5mcZjrmydAQN+oytOPKZI7YnQfR5RUm7B++a/nYTw9o5nHMu6+OwR0bMHBF7fEFkT5m29sn1qeFihcYy9XM+DHWuURujbDsX00OoZ7vePAl15BD+niRAyzI8evHzvZo1sUucM+RcZpGmzjGHMcHLgJwG0cvv+yMgYTJw4eXDoPxQU6HEKmhmuDwEO9oPOhwFkTYL6AHrIOc/FptxzhZnsi7Bj46rafjeKsLeG3EygcSUiOMLDFqogjj0R9oZmVacHAwpsAB5nceH0/X8zZZEkYyKOfP+hHCNjbxiVsF/PTqJnM42tq317aWp1J1zbBNgNjor801aOVsXHPR0cV8fiZnxdPhYo7FldVQZi4CwCLtl/DvsWK2xCI4XOpE9tRHHyFzMVIF195veT09F1oY5uuAnOJbBN1zlW6W26t4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de78b5a3-c88a-4f00-2420-08dd13709e1e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 08:00:56.8710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2cbqI7wUzCW9hb0iQRWDJmTJjs5yvjFG7xnkdzREHERoosMd6C6l9CmLod8I+ZPq8r6OnGkCq5i6NzK4ZyAL85PMIoY+7ZJGcQQ4G9XpXWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6444
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_14,2024-12-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412030067
X-Proofpoint-ORIG-GUID: ep_DYR-8ERza_BAKASalcOMCff96QvDK
X-Proofpoint-GUID: ep_DYR-8ERza_BAKASalcOMCff96QvDK

The struct page->mapping, index fields are deprecated and soon to be only
available as part of a folio.

It is likely the intel_th code which sets page->mapping, index is was
implemented out of concern that some aspect of the page fault logic may
encounter unexpected problems should they not.

However, the appropriate interface for inserting kernel-allocated memory is
vm_insert_page() in a VM_MIXEDMAP. By using the helper function
vmf_insert_mixed() we can do this with minimal churn in the existing fault
handler.

By doing so, we bypass the remainder of the faulting logic. The pages are
still pinned so there is no possibility of anything unexpected being done
with the pages once established.

It would also be reasonable to pre-map everything on fault, however to
minimise churn we retain the fault handler.

We also eliminate all code which clears page->mapping on teardown as this
has now become unnecessary.

The MSU code relies on faulting to function correctly, so is by definition
dependent on CONFIG_MMU. We avoid spurious reports about compilation
failure for unsupported platforms by making this requirement explicit in
Kconfig as part of this change too.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---

v2:
* Make the MSU driver dependent on CONFIG_MMU to avoid spurious compilation
  failure reports.

v1:
https://lore.kernel.org/all/20241202122127.51313-1-lorenzo.stoakes@oracle.com/

 drivers/hwtracing/intel_th/Kconfig |  1 +
 drivers/hwtracing/intel_th/msu.c   | 31 +++++++-----------------------
 2 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/hwtracing/intel_th/Kconfig b/drivers/hwtracing/intel_th/Kconfig
index 4b6359326ede..4f7d2b6d79e2 100644
--- a/drivers/hwtracing/intel_th/Kconfig
+++ b/drivers/hwtracing/intel_th/Kconfig
@@ -60,6 +60,7 @@ config INTEL_TH_STH

 config INTEL_TH_MSU
 	tristate "Intel(R) Trace Hub Memory Storage Unit"
+	depends on MMU
 	help
 	  Memory Storage Unit (MSU) trace output device enables
 	  storing STP traces to system memory. It supports single
diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 66123d684ac9..93b65a9731d7 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 #include <linux/workqueue.h>
 #include <linux/dma-mapping.h>
+#include <linux/pfn_t.h>

 #ifdef CONFIG_X86
 #include <asm/set_memory.h>
@@ -967,7 +968,6 @@ static void msc_buffer_contig_free(struct msc *msc)
 	for (off = 0; off < msc->nr_pages << PAGE_SHIFT; off += PAGE_SIZE) {
 		struct page *page = virt_to_page(msc->base + off);

-		page->mapping = NULL;
 		__free_page(page);
 	}

@@ -1149,9 +1149,6 @@ static void __msc_buffer_win_free(struct msc *msc, struct msc_window *win)
 	int i;

 	for_each_sg(win->sgt->sgl, sg, win->nr_segs, i) {
-		struct page *page = msc_sg_page(sg);
-
-		page->mapping = NULL;
 		dma_free_coherent(msc_dev(win->msc)->parent->parent, PAGE_SIZE,
 				  sg_virt(sg), sg_dma_address(sg));
 	}
@@ -1592,22 +1589,10 @@ static void msc_mmap_close(struct vm_area_struct *vma)
 {
 	struct msc_iter *iter = vma->vm_file->private_data;
 	struct msc *msc = iter->msc;
-	unsigned long pg;

 	if (!atomic_dec_and_mutex_lock(&msc->mmap_count, &msc->buf_mutex))
 		return;

-	/* drop page _refcounts */
-	for (pg = 0; pg < msc->nr_pages; pg++) {
-		struct page *page = msc_buffer_get_page(msc, pg);
-
-		if (WARN_ON_ONCE(!page))
-			continue;
-
-		if (page->mapping)
-			page->mapping = NULL;
-	}
-
 	/* last mapping -- drop user_count */
 	atomic_dec(&msc->user_count);
 	mutex_unlock(&msc->buf_mutex);
@@ -1617,16 +1602,14 @@ static vm_fault_t msc_mmap_fault(struct vm_fault *vmf)
 {
 	struct msc_iter *iter = vmf->vma->vm_file->private_data;
 	struct msc *msc = iter->msc;
+	struct page *page;

-	vmf->page = msc_buffer_get_page(msc, vmf->pgoff);
-	if (!vmf->page)
+	page = msc_buffer_get_page(msc, vmf->pgoff);
+	if (!page)
 		return VM_FAULT_SIGBUS;

-	get_page(vmf->page);
-	vmf->page->mapping = vmf->vma->vm_file->f_mapping;
-	vmf->page->index = vmf->pgoff;
-
-	return 0;
+	get_page(page);
+	return vmf_insert_mixed(vmf->vma, vmf->address, page_to_pfn_t(page));
 }

 static const struct vm_operations_struct msc_mmap_ops = {
@@ -1667,7 +1650,7 @@ static int intel_th_msc_mmap(struct file *file, struct vm_area_struct *vma)
 		atomic_dec(&msc->user_count);

 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTCOPY);
+	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTCOPY | VM_MIXEDMAP);
 	vma->vm_ops = &msc_mmap_ops;
 	return ret;
 }
--
2.47.1

