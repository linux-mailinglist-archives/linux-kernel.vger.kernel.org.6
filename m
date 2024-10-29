Return-Path: <linux-kernel+bounces-386992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADCC9B4A8D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 636C3B21743
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F372205ACF;
	Tue, 29 Oct 2024 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ArTrI5Bf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TQY/ttr0"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A50FC12
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730207060; cv=fail; b=uruN61Dau2qKPGfzOejOJrI7COvamSqLrd6S4MvT/YRcSLLnSo5+bQRR/Hu5JyDwKavpr88FSMnqO/SbWin3vx9JveAv7YTKjZ00KVtv+gUWc8cXM2UF7ui8y//RAU558I+mDIWv+FcUMSOddq7/YMVfzDfCHBEroFsVsC4AOxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730207060; c=relaxed/simple;
	bh=jWJv/fwsJ/pAQnVs6BwSNXDNVzkQyb//OKdueK5P+1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wh/WY3c9VmnWqV78e8S3LHTsAcUDewebLrEDKw/wzMzfHiCXSHd4PbpT+jTJs7G06BkBBA5wevN7vwull6WHhO4kaatqz5BILj7yt5RceXoe1NzshDqm4igjkc5uirv0m011lggZVZKXHo7WeFQUEO4Yxr81Bi2OSKXhAgEfpS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ArTrI5Bf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TQY/ttr0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TCbnQ9032685;
	Tue, 29 Oct 2024 13:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=woqMSvLgvosQjv/MfE1WcUuMqxJfVahDJ68XrgLxxKs=; b=
	ArTrI5Bf0SL08WgySgAjo7fSpv38lWhGzMcKKiW5MJoqtTnoeHuth4yCPz6M10FP
	wsD9gUMpQCfpdFfcVte3cbCAx0vg8L7EuoGE43qUEywojSLGcpjkUFdLFHn4C0nC
	2sReKQhNz31w0qjMXUdR05vJwWJO+PDF/MJodxBBQk/VYBRKrZ0ePtG8jmKSdkYN
	Ez6AihStXyZFFaDeSoSnMReGN/lHrz3oItxufLBtV74XdWyJ7mlbcd59vPCh045z
	GIGijIiHPnkcqRqS4oxVHzn2BGJWJB2MB/icEczFtyD5cNW7+DQ8/PJFnnWcyPl3
	BgdViKTAPBykpuFyymQj3A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdp5bv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 13:04:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TCAu0K004804;
	Tue, 29 Oct 2024 13:03:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42jb2u7h84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 13:03:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7H+2CwbDQxvFJVO43YNW6We5yUxQj+6ch/tHACeGT95U9oHR/mw/PYhgClh19lY3WTbdXEx6icDZkYWVTqgOTQbTANsn0NWp4C9mD2TlpHN4L/A8u0CJE90W6pUWZ22lLEhaL1Z5LlJzk1F3e0yViy2X00EZeR9G6T1Q69EOaRqOSJdlXcwNhasB7FyVzIGDU4rTu4LEnMQMv4sRUL0DeyGv6dBf8sSQb+dWW0gJP8GKnIu1j+dp3T1qMwftt06J6Txar1Z+g8CWAhtbwM5QV2EmEQ6cYmeKY66gWhQXr7UiqPVWPjMHfCh22S1agx7t0qtCbJ1CbdhCNx4v4sS5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woqMSvLgvosQjv/MfE1WcUuMqxJfVahDJ68XrgLxxKs=;
 b=bl+SdfQtTn1a5wAZSCKL2JWXcdci0cK94FiEio6QN9Sir9gCyobrBiNt42H1HbF0HZjOQUEUM8E50H14CuVlGxlEmofhyqQoXGeeP/W9dmi/WhTAZbiphFMnOjppejrX0MWTha4LugRTV20bNOFwcUd2Gu5wqS+AR5/nI/Nnlq6v3j/mVp8XEe3atziiZqd/dWgrvLycLkngYUhhEVzrf5nS3nYUmC2G42116PC3/xHmFUhfiXbCtN6x3XXDYONl9/E71OetAjuLkEFMBfKBahFVEjx6nsls/WLAkc+++Pw8SN0iQ9HyX87Ygp2kJ1hcvabCxkwLhnV05GyD6Vj+Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woqMSvLgvosQjv/MfE1WcUuMqxJfVahDJ68XrgLxxKs=;
 b=TQY/ttr0f7FYpDCi1QVbEAY72m+BX11ToRO3oYe86M0Yv5rPdSET4LKOZef7F4SznjlvWy0zL2GCQKvjOXA+PgXBSPrnbxDlQCOyzBg73JvzOB0/k/Haqmu/QCuddt7gwAJSyS8ETwOAgV/W5lhSf9epBm0L1kYJ4kbdClbl7vU=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MW4PR10MB6462.namprd10.prod.outlook.com (2603:10b6:303:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Tue, 29 Oct
 2024 13:03:55 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 13:03:55 +0000
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
        Andreas Larsson <andreas@gaisler.com>
Subject: [PATCH hotfix 6.12 v3 1/5] mm: avoid unsafe VMA hook invocation when error arises on mmap hook
Date: Tue, 29 Oct 2024 13:03:43 +0000
Message-ID: <d41fd763496fd0048a962f3fd9407dc72dd4fd86.1730206735.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730206735.git.lorenzo.stoakes@oracle.com>
References: <cover.1730206735.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0166.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::10) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MW4PR10MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e9252e-7b2e-4377-f5e5-08dcf81a24ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uMGz/i0Ow4UUcYw0W/p8yd/06XlLfcXSHD/jNA+WB5nJikKOAucZ5Ni+SXx7?=
 =?us-ascii?Q?6W2N2hkvDnlhA1BmD6flyW9a0Hc3uLnh3fZGb+M6mIlTzwPbh3JQqqNvQZwG?=
 =?us-ascii?Q?YMP675WLGvfauDakUvueEyfzhG+AzVnfhRWMacpXjjqqPDMQHgrnHpNOJilA?=
 =?us-ascii?Q?42k70jryJI477tdbdjpdrVBfWLnDfdSyes3FhawxQFkx7nk5fjEMYUYuxoHO?=
 =?us-ascii?Q?CnZs7AU7PaiY85awELWyJgVJSJLKP+kNdZC/5zB9I69rZ2+JMP0uiYxhSZNR?=
 =?us-ascii?Q?Zkjg0fWJHbETqK97m3Sw8QRu0nWX3M7rzqbrRwf1Sh6N3ek8mhCfvhIzYfG7?=
 =?us-ascii?Q?V48Qn5KgyGeUQWN8Y3YKUFvM6wkNztHKqZ3QZ/yh0AxxYJHNH9rfn/oBWK/g?=
 =?us-ascii?Q?O6Q9rmlQ01Seuuv4NDA+iTWqyBtTdj8Zg6GNIcWHPNuA3K3OOBpEMGR04+0V?=
 =?us-ascii?Q?OVfHG/9LDwzlo5gMLC0un+vqvbVkak2VBeEqWBnrhcdYraM4oELJ2425DK0R?=
 =?us-ascii?Q?zNXJ7cgYZPfrYwgZoxy/qWSI8uFhc/qEmNdPo850hifDlpkjibqE5g0q3VQl?=
 =?us-ascii?Q?IddJrGKNFFhtgoTwEkCaZOAkUFAkVxUi54r/pmgALm1UGPQHfcobQfTfSM1U?=
 =?us-ascii?Q?Fti2tFOXOUNqnEnr51Ial1MihnL6t45kGzZBxHUEli+CsyzEXBCg0LZ41vBM?=
 =?us-ascii?Q?vcA/kSdNyh8rC17wjtk6PlxtSRIWvkl5Q5mVGYtZ/d5vCPWVHlUAa0oRhdsF?=
 =?us-ascii?Q?NjtyjZ/pRCjW/uGZsBY4meijeyJJ5JTiQgCL2kEBsF0Qmkdg5ouzNFHf/noD?=
 =?us-ascii?Q?ZRCXNf7wvjlPnN0yCAMp7KWUsv7Ts4ugCnyu9UpJRd2IyVoPQHxMbicun3fv?=
 =?us-ascii?Q?rMpZHN6/RqWhCf9H8VlfleZnD1zX0CMlJC00b6zm5wvYGenh3wJWFSAnEJ12?=
 =?us-ascii?Q?pz73g7kCNVvw6kTCZQcY1hekHSv3E42YFm8TBXQS8qAEoX58gsu8fLRt9Mhp?=
 =?us-ascii?Q?TO9nw037lW9JeH5Bz+dNdt19MEY12CpWewZjpZvQHRSZi3eAwvtoH4xlCisV?=
 =?us-ascii?Q?DNvA9ZAs1tAeUJOHbRmmsQglDIHLsE9Vps0MTye/BklaiGyJFl5fJMWJsVd5?=
 =?us-ascii?Q?fZsO6YvfOA8Ax+Ch1V0XV5k7Znl09qKZn6vDwkwaO6sZ3Oz3KCijenU2fYqn?=
 =?us-ascii?Q?UfmPEml3G/cqJHrEhemNNJtwpjhBiYlrgEfFdkrqMIG7nutuBP+01XJYjlRT?=
 =?us-ascii?Q?inspLbp/a1CebNm0XafotQ/fkw9lho7Off1wXCS6AqscOdZ1MZts5UmSr6n2?=
 =?us-ascii?Q?Zxqa2ff84b4qq+aNbdyZdWS9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WxScr30ir7K/gg7AH4fyz8tLkkBqcCzZXCpn9murSbGLwWICzzqCSf5MDtNy?=
 =?us-ascii?Q?9OdAvcLKTpBscdx7K8t2MhR/86Y01rB6IisrKDv3DJ+mKAdWCGLbA8SQ0wKg?=
 =?us-ascii?Q?oVc1DULcceX4cKTJfFnt8lc+N9KqcmBCcbpUX4++TRt9mGnvMm9DhT8kXU0O?=
 =?us-ascii?Q?OzbfgUCiCm1EJD3jEZUQb4X4838ORHyIwcgFCueTK287WwRi4yGHKFXouXmD?=
 =?us-ascii?Q?up1hJfeh0N0yAMNWIfNp2naeaKqd+Z+MiFa3+kUruECZf/px9nX31bZxIcAd?=
 =?us-ascii?Q?2TremyLzXhsGMNopUsN+PzOJjQ5dGIPSQalQIcO1sisthsp47zKwv1tc3L09?=
 =?us-ascii?Q?/q7vUNMToavinyuGbqFNNaevlks728UUTTIAjwOGD3Odv20w5LQfBdf0YsaU?=
 =?us-ascii?Q?33V0k+P8b0RBIY0bdaXXs/lV3wBGR19buMHUpuG4dAFLVwGUad40vEs8pbo/?=
 =?us-ascii?Q?1VG8cN3awGJypPnF7FYmajYAIi+lkC6zgyhzwEfldrBx7jmEOpBD/dktJXC8?=
 =?us-ascii?Q?b5NI5Bzp1VnR94v98UUBQptKRjtI39ovggAmptqbHYCsRhwZ99d5mefRfB+3?=
 =?us-ascii?Q?gXKB/QHb17f3Bi/lL3qxwylYL6G4JP+lU1Cmbpd9EqrT/eb+W0kD0Vptr3X/?=
 =?us-ascii?Q?6TWHy6B+1tIy3ioAIqm0i/fLReXdME+sKUOYcpoh54e3ab6/sVqX0QfmMyJ/?=
 =?us-ascii?Q?I8swg6L6sgWZwWCAMYg1iZLUFk9Gso2NwxQgic/fkRrnMEw5G/HHD3p+Bins?=
 =?us-ascii?Q?RPbeSrxzvU1tE2SgrvyGi8f4ReGRp2+wbyfNWoMhynw6Zn87W6fMk9vnbNct?=
 =?us-ascii?Q?N4UJGpkEYMEuvfcd09HE2QeVaK0p9QKdROk+5nQBLZa1WP6rjJFW2vk/1Pmt?=
 =?us-ascii?Q?Ffn1+eDeyOF5BezlKcqDcqFFBX1gCE7RKH590yxlM+d3XftST+7eiivn+djA?=
 =?us-ascii?Q?M9uOL2eceICuacIXmoRcG2A1OzSynW/MptaqpaPhci5h/c4adw4Ct+TCx0YD?=
 =?us-ascii?Q?7bSkNQSJwUZ7GBx6a8hIex5tKxG4apC3ToI9OZutay8IkupLe3t7mi3J9bEi?=
 =?us-ascii?Q?LUOw0NHmpqIXYBr9t0F6z4S4wXpXTW6DDjKI3UU6xiKgTgV+cbVx2M4+Mdr5?=
 =?us-ascii?Q?Z+HtoXuJFa8lEhtP9heQFvda1SpGtNbbWhaRSW8ZKctP9qcLLE4cD6iEbUzW?=
 =?us-ascii?Q?/wWkGXdXyVw4WC7sE7c+nAI7LLTSvI1PLr9Anu9MpQWnVb51bal1wSOnwxEg?=
 =?us-ascii?Q?JLAEu4Ov8JvSEfx2irR8H7eFXDU9aKjq7/QgRNVi4nVJaa5Yzmovz3WUM3v+?=
 =?us-ascii?Q?W1PJGhdhsraCnrkxiRbqiwTPNOY8cSbKZsWOMFzjB40+uMuIGRrzmOiBlRPO?=
 =?us-ascii?Q?puKThLHJT2pZDVEENt5oAK4K97f77DylPEgr0VnGJpkQwgwX05nGhMTY5NP8?=
 =?us-ascii?Q?lSPxuX96Sh2lLDiKC3KJJ7hk3+kZvDop9lEhtL+2rqSW/q5y8LHPcr604i0O?=
 =?us-ascii?Q?3g8S89ngXN6I4RRMOD1/vQQXPNQSYGUNu0xWg9z0mPTZ6r9Tc7BawI3VKWnv?=
 =?us-ascii?Q?/oiD7i1r0+pXzWx1VltudveewrLo7H5u73YbHJDIfPYXOf9UUnMtabMSWApg?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IVAlPgSdRVV/OJ4kpYcHNg32beGu6u39g6mStJn9QpDd0LvZGnSUc2aeMAk3Qc2K6KmEIp3XtBfN/hdX8iiDs4WR7AqoEHF3/1Tkc1+TujZLmLh+kYV3bk3vCInNG+tuqk0RU6bgPmpL86XoUwLMIn2CoAXtPMThZk+FgTWMo370nfnA7WgDeU6pS1QoNVaodCb4ll8n4lpSSDps3QXqCs2HfaRMTPgJkEnJblcqO6fA5K3AIuMFoEpVLUIhq+83OJcwh5VVUxjxMGgF14cCzCyqxJhwRp02PhLvOErAVt4jBiqy19aoLSfAwrb/zbbxbSrsPYgllWRHcuZ17vwdnnDdE+lZVWvP0uJk6NCnuehi24SuYkMeQAY/APneTPAvSY//RZWD6K9bovM9V9NKK0QHqMiMkS4lIUn/a21J0ADQ7Q8vH3T06EvsZIJfdtNLXe3qpGqDAb5i6BC1qA/2o7ZmpROwQ/TC7Fkqidv2LoP8KjSiowvRGJ1mg/GVe6zWYxKhV48fnAEAFAxgKBI51WwP1NSIQ0A/yWsv8fVGnVoRa9ppBkIrT/23PIzNKI2/A7DdF0Z0HXvLEMxgAFDw0xovNwmYpRZs+jhCpT7/bpk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e9252e-7b2e-4377-f5e5-08dcf81a24ce
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 13:03:55.2483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgjlS/vMHdnFdruKxq7ErFGozHmWCnXgspwr+iRcvhecCDdirs5Fswqjjb5a85yld1Iu5PGrf+elt20x/cBl9HuWALg8pS4xATSapGdqxNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_08,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290099
X-Proofpoint-ORIG-GUID: G_plqKKvCc62mtWTYOYY4MaGLghCb19v
X-Proofpoint-GUID: G_plqKKvCc62mtWTYOYY4MaGLghCb19v

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

