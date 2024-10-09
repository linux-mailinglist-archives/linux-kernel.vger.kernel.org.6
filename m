Return-Path: <linux-kernel+bounces-357550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2974F99726A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69A75B27621
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228981A2846;
	Wed,  9 Oct 2024 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T8OZAbqj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BfX+KVM7"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CF41E0083
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728492903; cv=fail; b=jYGPuGs9XqYdDDQ55Obc8JDF4gJ5mp+HuSXGC+utwQwuqTtJhiwwKSsfY97k4WQyZUEIRm+om7QbAuNuMPvPViEMdV4I7DE7pUQrPv84m6i4ZJUJrUtxyFbhoW4c1/h7Pv3hA9x06TaOh8lBEG9mVNB6qgsvXYSi100uruoF3lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728492903; c=relaxed/simple;
	bh=Y0P3ZuCmfVs1LGk6YGRo/53CfYDQ11BB4V9FM6GHbYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gtmWpLwZwjd4GUOdIZqSQ/MJZ+q8jX+vtotdOJKq9iMHAuvW9wjjnSycGv7Ay01UfUpxnnqPLMyGkhCEq6Ort/5VBI/uk2u6Rsiv2EGOKjpmv/VoOr+3JiZNh61azZeHpz2zN1kz2JhckjbyEEsDdpKfeAXQfHR5ZaRbU3jrtNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T8OZAbqj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BfX+KVM7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499GBZX5013489;
	Wed, 9 Oct 2024 16:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=R3I47lHBInlJHDZ+/y8tvLiaCauJr76ohni1ibbPLuI=; b=
	T8OZAbqj0zqLnVkKNKf24MevEree8dlSZ7iOC9dPUIdUvfrMQblhs+CF+h0ekGBP
	bjMbNKDR2kfqKQScC3JNWa6Tawc+Eh+7LPBcf5tJrZcPuIcIUTgNcjEwzQfW5s0P
	vZ4glOZYZNaBcLRGeVSmFaEosPJk/j5u6aMtp/sASephlLwMR348EBVaYXXQjyjj
	huM8lVsmIO5DHG6VP46vqiq8CY7ohJ+6ui7VQunkOYvkiTCGGfZ4hIVVdwTVzBKq
	H8QqhXLCZTmqOlKCsEPC+R5FhuI0sYO+wy42XQhNuCzJ3/qStXKQIs3aeFh0TpJh
	bFqoiv+SHAj+gD4F08kRYA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42300e0w73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 16:54:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 499FedFR022916;
	Wed, 9 Oct 2024 16:54:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw8ve1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 16:54:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UeTgBKEJYyHBNHDiJ3bgJZ8PWDlJ7vPrGlrAv8vPaQyyAG+Qgfv7Mc8I4BOcjxxEp2iUX9j7itFJWmSB50TFRN4zURt6Glr+tQTl3noYHBjAoMmnVlVTPh7veWdqOGCs5ClV6MHQlvpEbsw2CIXX2GJvhJFeubNx9hvhUJbnWmlhBhVHzEiu24m7+qAlksPL9ftWsFDhQ7pR7LMfdt439zPXpn7ZO8ZLd8dfQN3L8ZSiSD1cMSkueXSgtYnUHR9MiAlEzj8hei0FZJaiZx6tkQhow5W2sWDhGlH0u8Ba0t0m7kQX91SsU9iIZF4LMHRglc+Tkoekn7CRJIs+RjSIvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3I47lHBInlJHDZ+/y8tvLiaCauJr76ohni1ibbPLuI=;
 b=jawfpqCmWo4xz4W1dai/gUne+5C1scwbfhmMgBQqquo3N4h/pIlM9dMpiO0RepMOGxOaaxPlyajaQE/7RVmkLBaVOX/KeZS/vY8CKgDYenNN4aS1LQNSTpF0YAqn4z0KXVEHqpiQF6revLo4wOgLVBmoRtZST51BzUFU8QpFFWRtCIjlZZlcd72AzethxmK/F56FVGtTB/coU81GKZLGAH05yfy2bhM9BTdRF1GoSpdJnmmgBxpRJKtzZkeg5AakmyR4/uRpwHANRcbmnR9ll3yhoyP7kaLH3gjbM5bhdZV0c2I4y62WwXR/auuzTfSH1n2VFWwQLtzlAKioTKbRYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3I47lHBInlJHDZ+/y8tvLiaCauJr76ohni1ibbPLuI=;
 b=BfX+KVM7gPScrOMXnJXS2D7evjok8V2wts4BZCAxmBXuw42fYMRegJFdbUO+zMR+u3NX/AeExH6nDTT2GBNqpGrTpCdoHCvj9mZzZArZhaW3xPOO1SLVY95vGakiw/bh2BXIIcfWgeHrbOoAwMthtgD10VC5FMfpdEfEjc/gxms=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BL3PR10MB6044.namprd10.prod.outlook.com (2603:10b6:208:3b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 16:54:31 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 16:54:31 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, ankur.a.arora@oracle.com,
        efault@gmx.de
Subject: [PATCH 6/7] osnoise: handle quiescent states for PREEMPT_RCU=n, PREEMPTION=y
Date: Wed,  9 Oct 2024 09:54:10 -0700
Message-Id: <20241009165411.3426937-7-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:303:b9::8) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BL3PR10MB6044:EE_
X-MS-Office365-Filtering-Correlation-Id: d29f0e0e-c8ee-4520-e284-08dce8830bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wvCuVFLOSzBlbAAGGqfuT0VTmqqaxSbZb8yScJzbzyAYWwDdk4vZ8e/xOrrv?=
 =?us-ascii?Q?yyvJzWts4KwY2IxqOes+d0Q4UlsbY5A9IHcCsih4ZpUA/sIDo4ELpM7QA3zf?=
 =?us-ascii?Q?WTZxTcsxnEswnQG7+TSnAdBMINRtrEIE0OugIE84Vu+BBoCTcRadnIDc5DrJ?=
 =?us-ascii?Q?gSu0rTKgyWXTOVP7gbqZ1ero4X7qnApaCnmjSOWKr9zoWZzAUgsyZYAFHmrE?=
 =?us-ascii?Q?bQgAnZa8a+nzwepVO9En52UF9tUXMFa1INH0Py568i78vtjf92vfKH3C5GYE?=
 =?us-ascii?Q?T0ax/HkUoLkxrcwpmJpymU5B8fO0QW3PQx1SSe7voT782sQrkiFDA2Z/olNq?=
 =?us-ascii?Q?/OP+GdgyOEekewltqABN8EuPBvgpRYqkZOxUNOF6ETTi/uaZfx1IYhPFhLUp?=
 =?us-ascii?Q?u8F1dZ6niWfXvRDAxSW4zprsK4Hy963wOYxn8vNfovmcf4AciYWmBGpiy50c?=
 =?us-ascii?Q?QV/srRo3/YxOmlHzANiWuC5DFsN8sTWjdtauyt+Fml/p0QgY3SoirTUkHmVJ?=
 =?us-ascii?Q?4vS5V51kjxwI9PQEsQ/9GDAsGpjqAzSbdwtxu1+slnMTbWQB0X+Pr1KEC57i?=
 =?us-ascii?Q?WPSap2ZCriLJbnfqJ+UrcTzozYoS9ii2boI3x7Iv1E3Hd9bdtlZYKgxPmaq7?=
 =?us-ascii?Q?ZjnOjUONDX/R1BdtU9FR18mJwY0OwtukJg1fls5h0G5zp/LZ6cw4Hg6zGPz9?=
 =?us-ascii?Q?8x+A4zwihaDLGy2un109ODToXeCjFPVzcWfK4ZtTJyhShiZbHRbW0UR77u2W?=
 =?us-ascii?Q?LCAuREv47NtdjbS0msMWVoKqqjRnsrLMfUPqsjvY3eZIrecQzhI2KoHW0YE9?=
 =?us-ascii?Q?iXI9ZSW4Jvutftjj7zJPwJsN84mdwBGhdcxCpK+CQT8upI9mVpeneWZXvrKW?=
 =?us-ascii?Q?IzYdE0Qf3GHJe2vgMEobJZAifE/sk0eMZMZyUxtfdSEgxw2+nhErnSzhUSD/?=
 =?us-ascii?Q?qvknXmPQRQsZEBzyA0MWCgBu4ko6S2SHSxzFCiqNMFOclqkABppKpgwFaLqr?=
 =?us-ascii?Q?p6dB1ic2aii69DgBu+QC8QWYAMAhXz3IOiTJWe23Src69tdxaUXSuIdf6K6h?=
 =?us-ascii?Q?q2jKnOiPlan6oSBplZkl5wOWMxhCXSA/RGLVIVIKXHbfjqQqo/P98Mhw/70r?=
 =?us-ascii?Q?Je6mCzVOngkZ2pvi3r89nIhrTSTW3I6Wl0lvZzsPXt6STwgMCHSmR7uUmMt3?=
 =?us-ascii?Q?jb+XPB8N0iikp5NqVYbggxnmFmyXUE06j1OoNcK+areY0dy5eWhPuLlA0dCV?=
 =?us-ascii?Q?4JsLno48D8EAwfcyprYrHPiJsIhebZvxnZ0sFlkNYQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/ajbGf2rkip6BNmGmr5bYRGLpfRm5fFFGPNslf+Faea4zVvK93pdzxBlEknY?=
 =?us-ascii?Q?xtek04HHtFE4Mekhrp+Sd/bsRhdzAGZNduAITXYHsXVk+9X3O5iH2bDOHIek?=
 =?us-ascii?Q?VwcrVK4hi/1sP2K6KGBUH36MSYlGxXBbg5dZ3Hi/rqUy6iFLbN4Yu8UXBp0t?=
 =?us-ascii?Q?wHhkF0grNgEd5czoKSawygUYdR8Z5mqq4qN/6YbzX6AJfVVmqzbRhL0fmPsg?=
 =?us-ascii?Q?NyZv4VIyx455k2HNMoEfoQ8syB7k9CLGv7OuPz9K2k39vu7s1bFN/nXUIX3P?=
 =?us-ascii?Q?533xUZEQVhm/HrcF2c48FL7yOsa8kGb8VgqJWe1HGWWeSEIu58HgYqZbF87P?=
 =?us-ascii?Q?WtGwNCI2e7rZoSVj/aTuyrYG3S6BKZdsury9TV36telTg8boyOFlERj5odlk?=
 =?us-ascii?Q?GrKkMfJutg+NlB2X17qI1lbA/oi6mf3N7rWaD9CJjGRCFBYlDaEB/BddcLjo?=
 =?us-ascii?Q?apiNSJ5YkH1E0XyKzuw5Afg8O+XmPsE3Hjb904mO4YKLabOg22bT/4LxciJK?=
 =?us-ascii?Q?WgBxqYFfDH9W3a2aVMHxRhT1UZGQ850FSKcuhH37T5j3zahOf61VwJSoMxj3?=
 =?us-ascii?Q?Lj1Nb1n9YtdtnESsRYo0XckDYOXE5/Y/zn5g8CYpfg8HWSwQnKMetSyRbe8u?=
 =?us-ascii?Q?V94wmFOFLiFCveahOoROZS+OGJXo/aPuYTOy5zTiYE0iMAKDKPrXxhRe74XF?=
 =?us-ascii?Q?u02vbI1PUXN/nyeJQJ+rkby2wWB3Nz1c0Co8tB7U+Hf6b9r9yOYPdjIq1yXd?=
 =?us-ascii?Q?wGV++pO7HZrUTHyJ2AmY6WfyFWScXa++bId02BtZDoCuhzij0djfxXkgRCzJ?=
 =?us-ascii?Q?nicpTjQn2waiUkwvN7uavUS8brvH+EXYgq9c4GPBML468xqNbelBoZE3K85S?=
 =?us-ascii?Q?lC1yKo1fqd2Uc1mvISGhBYd8IlOwANCyic4gNTD0iKLkR/O824a7Ht4FVOVb?=
 =?us-ascii?Q?7SkvfrqFKHd2fg7PZNOtztkjIFSVG8f5jxl8RVMHxHr42Y+j+8MD/c0RHMsE?=
 =?us-ascii?Q?AyT3tb1w+1A2N5vPWcnaUENe6gW7o+Q/VpUi1r24zsR2Xc6ACx0cfKv7ThdA?=
 =?us-ascii?Q?TVCJrvCl/oIYTDGkD0d/6NObhfMVu0uMtcJ5JrwCaERjFV8Ckz75LRMfXtKY?=
 =?us-ascii?Q?pwhO1nmZcTqaEpW8ywt467taqdiOCCo2kX6hgJNj6w54MJgjU76n36Nqq7y6?=
 =?us-ascii?Q?FbCf/2QEz3CduHYWuHBoEYtSWEkDk/KrkvdyfbqYgl9SxiTEVOa/3GsFejQq?=
 =?us-ascii?Q?carpPi7u18KQZsU3rWzYo/ufsGa9UxZ3w+o1vmB4wx2Bkq3b8Xtcd452aqRm?=
 =?us-ascii?Q?nFyiNABo+u94zBubhq1NwK2ua74xxgYcfC4AKj3PRYhFAonHkpfeXyJR15wP?=
 =?us-ascii?Q?McU77a89m6cWptoXiwwnudqBGAHC08PXYuP541ZaK9LXhNvFZXthecd2f5DD?=
 =?us-ascii?Q?K6zFyJdGvI6AOST2S/oOijqbaJ+4JI8bWo6eAZZfGg3TTHxYlr1/VzM3zzSL?=
 =?us-ascii?Q?POnN/jv2DzIYInwqSDmwgeiTI4LjLoxl07jSLNqadnO89NhrJSn5UDTYSLNm?=
 =?us-ascii?Q?PryrJ2z98dEvpx8TwraGozyXJHGGv8cPlpGwXT27vBDTzCdGM47ntReaeIJp?=
 =?us-ascii?Q?0g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YgHl7x71S6uZYkH+AqIIg9hajlAgFriEU+Viy+h/kxSClnbSM9hMbmN/TsG34UNw60jg5EQZVZAXMZjPmgghnxJrYtNpMGdh/RPDFD8Df58BltO0QBveovsz6IhfM9PTKPs7a+xGLu4S5Xauzey/zaxIIzCePfTkOf+vgIfGURqxOt4JSrxK59exCCQpGoxVTheKpAoF9tBawHipTo2Ywkgn0UhXZOO1zSrZUenCSL8MKaAYbkFTe8hf82hJq6FKI3XgPP2f0Q1ZL5lffpMIvaO0x9v73MfbEbmIRSLyY6Y5DNKB0OVtqcwRSilLCuAEs2fjVMu+bVhAMRnCKALhXo1TQge+RUgDwTh2QD3MmJRacNlcZbH5erXk5SHWj2IepkPw6brp2vvW+z29mPXNbKxg0aldGcshco1CBo3KCrQv40i2+siSS1n2UCObur+JWKf6ALO07lsTc8VxxhGxulcW11cYpD6UTY9vuqAots1SMqtmdbTJlJ+UXwc14p191cww5Ox2PFuJfb17CtjpUxYWJd9eEuHZDgGWlBNyY6TX1e0ey0KB4LazSWRELXawenaYyDzFS4qk5KjpnjsY+utFbPhYt8Khw/rC5aitH+M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d29f0e0e-c8ee-4520-e284-08dce8830bba
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:54:31.6052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E/2C5BOCK9JkibWW+O6ulytN+UzaUes8m+bSEhTbRW/VRGExHpHRdlk2dT/7ZOP03imqFP9J+wGANsB7AIB1838o1qXLTGKCzd5Mjfroi5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6044
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_14,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=964
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410090101
X-Proofpoint-GUID: bIKX-hNc0Dh-n-9CNF4EvkZKhHBlvBdJ
X-Proofpoint-ORIG-GUID: bIKX-hNc0Dh-n-9CNF4EvkZKhHBlvBdJ

To reduce RCU noise for nohz_full configurations, osnoise depends
on cond_resched() providing quiescent states for PREEMPT_RCU=n
configurations. And, for PREEMPT_RCU=y configurations does this
by directly calling rcu_momentary_eqs().

With PREEMPT_LAZY=y, however, we can have configurations with
(PREEMPTION=y, PREEMPT_RCU=n), which means neither of the above
can help.

Handle that by fallback to the explicit quiescent states via
rcu_momentary_eqs().

Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/trace/trace_osnoise.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 1439064f65d6..4f4ebf3f15f0 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1538,18 +1538,20 @@ static int run_osnoise(void)
 		/*
 		 * In some cases, notably when running on a nohz_full CPU with
 		 * a stopped tick PREEMPT_RCU has no way to account for QSs.
-		 * This will eventually cause unwarranted noise as PREEMPT_RCU
-		 * will force preemption as the means of ending the current
-		 * grace period. We avoid this problem by calling
-		 * rcu_momentary_eqs(), which performs a zero duration
-		 * EQS allowing PREEMPT_RCU to end the current grace period.
-		 * This call shouldn't be wrapped inside an RCU critical
-		 * section.
+		 * This will eventually cause unwarranted noise as RCU forces
+		 * preemption as the means of ending the current grace period.
+		 * We avoid this by calling rcu_momentary_eqs(), which performs
+		 * a zero duration EQS allowing RCU to end the current grace
+		 * period. This call shouldn't be wrapped inside an RCU
+		 * critical section.
 		 *
-		 * Note that in non PREEMPT_RCU kernels QSs are handled through
-		 * cond_resched()
+		 * For non-PREEMPT_RCU kernels with cond_resched() (non-
+		 * PREEMPT_LAZY configurations), QSs are handled through
+		 * cond_resched(). For PREEMPT_LAZY kernels, we fallback to
+		 * the zero duration QS via rcu_momentary_eqs().
 		 */
-		if (IS_ENABLED(CONFIG_PREEMPT_RCU)) {
+		if (IS_ENABLED(CONFIG_PREEMPT_RCU) ||
+		    (!IS_ENABLED(CONFIG_PREEMPT_RCU) && IS_ENABLED(CONFIG_PREEMPTION))) {
 			if (!disable_irq)
 				local_irq_disable();
 
-- 
2.43.5


