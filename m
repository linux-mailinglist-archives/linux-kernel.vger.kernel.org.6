Return-Path: <linux-kernel+bounces-569572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D47FA6A4CE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA2C2465B8A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62532221D94;
	Thu, 20 Mar 2025 11:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="EsKQ0wxW";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="EsKQ0wxW"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013013.outbound.protection.outlook.com [52.101.67.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390B2221564
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.13
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469505; cv=fail; b=Yu9PkUkSvh2YA4RJm7gyvxXawzCNO/6YX//adLQt4pGCmeHXhuVS/qM3wBXD1tzWSzvGO+HxC1PqM2k+7SCGHEVrLhtbP73ruxXog6EZkTxaPlEPAO088/bkG8sKA6C2tgWnH73Cc4UhOjetdcX+GqpKg8+v48VQIQQMvn2+s7A=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469505; c=relaxed/simple;
	bh=5vOP66rnrCY/hota1E+OQu/8DKHqeBefwaG9rLz+jow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nt0WEk1wqWVU8FhaSqLNSaRtHWdI1OKdYobyn/90bH0f7liKfSWNNMxGHPG+lEx52Hv1w5Xqw/6dIeklUsI9ahM12OVKXAkfPVjxB2uTVWhddVtm0PrRLQ3kbvtcjbQhdjd+S0lMjio6GEXmO8Xy4uwxTjayI/xhBx13Mv6U0+k=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=EsKQ0wxW; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=EsKQ0wxW; arc=fail smtp.client-ip=52.101.67.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=GjMcxcopRGmXtPyAUFBYH+xwDC89fS8tXjQVDN8/UFQYZf1Mp0TCeh4TbKH2feZaURl7MLhdvoqJAFkJcuAOBBqFUI0y2oaI0nRvah34JJFRK9+Ih7youVgaKqdZo8Onl99dtG/d6aEpcobYeF3Y8/uCIk9teO/B6C7HYo1p4zmwWhPBvMmsbTGtPZpIg61e+omR7Ql0eUWAKBXKbH0mgG5qfTX/qrhsKLcwq+4sV0IJNWqPLmaxlBkLnXUiBvOhn2PaRhqISYsXy9VfDtmlYpMyry6cgzaFLDTF2lYMFaAnXLtRNfEPirv/jpt4GOl4Ncj9YQtv3gpNUfXIiJNokw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYfH2f2p0p7UsJOPYBI0S+h3GMsBmwKAfo3hC04ZXvs=;
 b=hb83l4HQsvNKG5Nc0ICYtBlk2AOuu/patcq4g4H2p++pucbIZp3c7F3C6ZMkq4B/QQO2WiBEUUHGyiUJ/JyufKUOij2u5yMNglU1d+pbICysIXp/Zf1ICwbdegzVynVd5Et3LnWXWLdmPq2UUb6AX3+eniCEx/iyzDKF/mwyuZ1GSWA+l7KSoe/1NSSVRJ7CwLH3xkxh+PGPsHIoA8F9uEdTYHfJnK+Z0dLa1WZKZetH6hYSbWIz5RYaiWmhIdiF6jtnp4N9i4GFqWMV0gG1P25GT/YeKXnDD8REwQ6vbeTl1mn0IKUkJpYtqugKntq473cu5JWutkcwhKV8qNsKLA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYfH2f2p0p7UsJOPYBI0S+h3GMsBmwKAfo3hC04ZXvs=;
 b=EsKQ0wxW6O45Xx2dWDn/y+jTWSsKqQ5t/FtXEach85ybn3SUxksMzM/DLMzH9fqBzh/jMZqbjv4SBZVSGpjiCVHcbE/fmL5Jd7f5CB9QVO3sSqxtlERnNLYpX+dGpL3c8bb3J5dQ+vmbZBRCdbNLVglQrc4QhGbakF3vm95DB60=
Received: from DB9PR06CA0030.eurprd06.prod.outlook.com (2603:10a6:10:1db::35)
 by AS2PR08MB10053.eurprd08.prod.outlook.com (2603:10a6:20b:640::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.35; Thu, 20 Mar
 2025 11:18:14 +0000
Received: from DU6PEPF0000B61C.eurprd02.prod.outlook.com
 (2603:10a6:10:1db:cafe::98) by DB9PR06CA0030.outlook.office365.com
 (2603:10a6:10:1db::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.35 via Frontend Transport; Thu,
 20 Mar 2025 11:18:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU6PEPF0000B61C.mail.protection.outlook.com (10.167.8.135) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Thu, 20 Mar 2025 11:18:14 +0000
Received: ("Tessian outbound bd61b317aaf8:v597"); Thu, 20 Mar 2025 11:18:14 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: da76cda19740f846
X-TessianGatewayMetadata: DWQRoTS4sdgcjfZTI6/HL9yGyElUJY2GjRbonkkC8RUv1FBai2JWRyHpBjLJ8kJqV+s1lve9haVWiK+Zg8cHkqB2og5R7CH9yZ2YsmJti+mEbrnUjhUZd61n79hfKxAJjwYZ8Kbbg7bV3YwQbZZM2muBUXu32kRKDUs2WDS4RUA=
X-CR-MTA-TID: 64aa7808
Received: from Lb15e4ab9bcef.4
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id DD4CA556-94EC-425D-8086-CB9C36A430FD.1;
	Thu, 20 Mar 2025 11:18:07 +0000
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lb15e4ab9bcef.4
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Thu, 20 Mar 2025 11:18:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdOAKenCejIwF+jQazhlqBE906y1e3FwA6MXaLgywbboOEASqKUIkQORKQhcJrucOz28xgE1f7DZi4TdwsH2CT63uUqlsUkUvTg1GKS+/HI60IhIPkMA2a+EIW+WQW987nmo1REwzrLO9Q6yTg/6b9zmq8UC5Q5haCypnmTqsHppK89PSARPKXQbXuNkCLMgkC/Pv9kDoDfkP2KjexWQhP9YUNvQFv1i+EpXAIO3QQZot7/S6+5xYUJp6mp9a+3dbZd1lP1Lwy+uYyqe9c1A+ypuR05xPMnma7uHFY+6OGA2Dfm5KFEXs4Hyh5SVa4Wdpaad7hhNeAEBFa5vJtbcgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYfH2f2p0p7UsJOPYBI0S+h3GMsBmwKAfo3hC04ZXvs=;
 b=XMuVKKth38ZZ9Rw9aS39irc7NEA36W3wmW/m0tuQA1j9+eUlfzDBTOmlRiU8YuC80SXHZ2UmhXdkGV3C1oKdSIgRsMeal4QlU6D4Xj6Oue7VIABnVCBEG+E5IqRs13ClJFI/aiZx9k3UOhkrqyX01CM1uyM6LLG4xeWGVfK4qO2FPxCr4tEyiLVKmk6iw14ZeMVMSXaALNUn2NOCgUExwu5ikjIqCyGZoWmJ46tL1wt0TEYGHPKgqHlN6z/llaPi3/bicndUvEDClTips/U6zX6O3ZlvAtx8nhgXdi3O8Bf4P752OgIbuw1WOSzoAl1BhEOG+rSNMM7wgefH2c0g5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYfH2f2p0p7UsJOPYBI0S+h3GMsBmwKAfo3hC04ZXvs=;
 b=EsKQ0wxW6O45Xx2dWDn/y+jTWSsKqQ5t/FtXEach85ybn3SUxksMzM/DLMzH9fqBzh/jMZqbjv4SBZVSGpjiCVHcbE/fmL5Jd7f5CB9QVO3sSqxtlERnNLYpX+dGpL3c8bb3J5dQ+vmbZBRCdbNLVglQrc4QhGbakF3vm95DB60=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DB9PR08MB6715.eurprd08.prod.outlook.com
 (2603:10a6:10:26f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 20 Mar
 2025 11:18:05 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::d594:64a:dfc:db74]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::d594:64a:dfc:db74%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 11:18:05 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 9/9] drm/panthor: Add support for Mali-G710, Mali-G510, and Mali-G310
Date: Thu, 20 Mar 2025 11:17:41 +0000
Message-ID: <20250320111741.1937892-10-karunika.choo@arm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250320111741.1937892-1-karunika.choo@arm.com>
References: <20250320111741.1937892-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0133.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::8) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB11200:EE_|DB9PR08MB6715:EE_|DU6PEPF0000B61C:EE_|AS2PR08MB10053:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c6fa9fa-e4d3-4f85-4e1b-08dd67a0e868
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?jb5DvYkWRoDjhVYmdkHqnE/gLTwcoiYw/muO8M83JP+xWaRwSnkgfhDVeTqC?=
 =?us-ascii?Q?J02iG91TwIx404iWW+OpmPW/48WfEW68bwda8eBdSQ9TZ7WxzCZgMCqCUBJz?=
 =?us-ascii?Q?pofeiUX2VJrqEopiKyl61o3LmxzrtZuwIezS+jEMAn8F4QiokQsEZxfzr5v9?=
 =?us-ascii?Q?wveO6s+A68eCg5sV0LWzWtcoG9KEDZR/ysI+PtGtuZpf4kJmJYLdQpwz+Hi+?=
 =?us-ascii?Q?eDelKetikUsK9rmsDU3o6gCz7amxmMKb48LlSpvmWTDUVty9pVnJuQFJlK7p?=
 =?us-ascii?Q?0FKyShXzt7LZZA4iRR1rnmpULgz1ZWpZi6qjTr+dcnk7hapgtqV/lz0IfxKA?=
 =?us-ascii?Q?ahhobMzXL5zhbOIrxbj8MQwWwQ+I7kxEuLo80ZlV6V65Bmpa5H9vu9dJ4vdj?=
 =?us-ascii?Q?KzVPSBbBxK0Zm3PaXzPJ23sUo+ZZesO5r4L+WqvxanW/cCnLpCLyhvLniW99?=
 =?us-ascii?Q?sprjy6aB18idyywcxmc9hPsxIS6J4i1iYmu8fwBPE7i/2I7SECzm30Aw7n72?=
 =?us-ascii?Q?MQZdu/qXFgbgirgyoZhqX5ty5U1PbRLT/O4VJIHz2NnVhEw67JEMYckMt45d?=
 =?us-ascii?Q?ZtgsNiv8wYhaT+kTQw8FSUnx9mVS8lPitj/0KkgqLKQKmWpgB8gSSJpM7pSn?=
 =?us-ascii?Q?0EYgzR1BCKhH7VqGxS0wB4kz8GGwFc1HDHD6hmAXu5QiLYA45nVVjE1HwKv7?=
 =?us-ascii?Q?fO2YWxC65H5JTU2/BRk2TugookLFoNbnMpLBY2yu8fS/hjj3V9jR6pMMckEt?=
 =?us-ascii?Q?yJZF3ygY2zV9eOM3WDpN5qniSEcp5Hzd78uJdZuGHnVo7g9uWaOGm9jQq9tU?=
 =?us-ascii?Q?+iUCHto2rOukr0dRM12syVaGBQOncFwTjLUmaywfoMp95nkgPfmxBkM1iBSW?=
 =?us-ascii?Q?3Ve/Gx3e/jTl9qVEfw+8jFHTeDCKuFlBCGOo3saE2uuaJDXtfof4Qmvvl2Xs?=
 =?us-ascii?Q?jY5V1UZRVJmlpUxutMwkde4z1OvV25Fsq0pJ0vCa66l/4wtxA/bUmlmu9C90?=
 =?us-ascii?Q?M7j8+6DGe91tZr16R/q8KkOW8oDTWUfRKX/5s5k8c4II7DCAV7V3ZOhlNXkd?=
 =?us-ascii?Q?Hxf9hzDZVmZbOu6HSwTladOm4FYZgw6hNn0wwAVwqV7UUpnkMZiJdK4rckUA?=
 =?us-ascii?Q?oSQN599DIV5fnd2lSFzuMBt+17Z46Zm24O6ePgu2vMt/YFkOyZFu/y0BDDpe?=
 =?us-ascii?Q?uUeU32XugUBfl90Tb5MkUz8ffjirkE52YMF0h+BEQ3pZ04EvzIQEbfizgYP2?=
 =?us-ascii?Q?0fjqUFESt13XZLLdMM6fsStg6a23S2Xjh28s6x0PFmm6vznsUa7qBPiptOom?=
 =?us-ascii?Q?IbD07EgXuZUN8OvBjGXzcDl6Yai/wW4pMIx8TvQnAh+SZMN2D1m2dtBGNDiU?=
 =?us-ascii?Q?frhJ78W1fpLTc08tUgU7/MfG7+uj?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB11200.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6715
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:800:257::18];domain=VI0PR08MB11200.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B61C.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	407acb58-ef67-4834-f9af-08dd67a0e27f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|14060799003|36860700013|376014|35042699022|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ohL0i0g1ahOKJ6EznV8Z+4dyFbXuDOBOvvHR3vi6mpc7frxDCihgsVY/Wkjz?=
 =?us-ascii?Q?Akk0RWO9O0GbWhBubXbce95MG2wpilrqmFgMvofoAxofPFJ0dYLmzezZMWTw?=
 =?us-ascii?Q?oyCh00PbXBrkfP/kJuzxtLZytNWKPE5sR6x4aTF3W+Bh9TPKImkvXP0vzxgw?=
 =?us-ascii?Q?ae/nX/cqiyOsg4c/heTjFkj790F98Vr1TzVofuI1uqbzsBsKAskJ0zG66SzD?=
 =?us-ascii?Q?mrYmlgOODF+lT6CMCjYucuslLId5l1IBc29OpO3IHuxG9Usdx/sVauKhM8rT?=
 =?us-ascii?Q?cM2Bhh0th26rK6eJwUeZ3A5NOZhMq6e1gTyt+1XGq7fLQf+uGU50kXVCqW6h?=
 =?us-ascii?Q?m50fDkozJOremA0R/bzUvEya+Q8ulTMFDnvoM6fOIPixYTMiORBHqnpMe/jT?=
 =?us-ascii?Q?GRzVIwBjOUP0CCOIvdKNUGqp2QgylUeCPXbbTkmehdyNPGuD1+6ICa9NFCzq?=
 =?us-ascii?Q?kMMMyHEzpQqWWogRy32mfhEB+e1oXGcNmrAsfM/kgfuT7KbX4sOkz88e5i/P?=
 =?us-ascii?Q?EL2cOSDuHMBV/2l1f4CmklbHkviwkM/2zMuY27jrXWpbUY9oI1crQ2+3Jx1j?=
 =?us-ascii?Q?S/TfNByX7FDekV4U9gdZfkqfNS9h6XGNtNdAWF2TS7IntqSI/22nKv2C0By/?=
 =?us-ascii?Q?47/1p8u3s7x4py0hRsjotth02wOkfvRRUQs70q+7KL8vfh5KThLhe7tFS1fA?=
 =?us-ascii?Q?Mw5TN3R+9mNW8Ujn/Jr3h00HYNeieincyLjW8uCd949TbyG1w1/YgVx60sWi?=
 =?us-ascii?Q?N8FmSlqeWykIv/cGZDOhuO9kwqCndFIZB+GikMbiUQbBp02GXWsgSv8AAIJB?=
 =?us-ascii?Q?p65Mbj+APvOGENuOcq7TKnSbeaxSAWS9AIKfbUEwbAu8+ucWfSyx4xXFS1Ab?=
 =?us-ascii?Q?Kd4VmgKSUKVUQmqc1sMlLtNiW2ppXKmfZxze8N62nsNoB5vAUqDbQtQQCcH/?=
 =?us-ascii?Q?rZ5VK++Q99ixXv/fWFndttFFC7NvLTLwIP1iMcjqTxd9eJ3+0yp9rUIcxAZc?=
 =?us-ascii?Q?65D18ttBYyiTQlWmNzPmVinsG/3Qa0Y2t/bIpVscSC/NT6JrSyPLmbB3bVy3?=
 =?us-ascii?Q?wBE7f1srOn9qi+neHL5irZ7Oib/JwAHrbllbmlNEaUAyP8A1WjzdcIuLiqiR?=
 =?us-ascii?Q?J8zktXO4q01yBpS4wERHTYnlOMkWKEn7WsRO+Uac9hmWQK7AK02NlGFOlpmG?=
 =?us-ascii?Q?izeY3PbGs2KCUvdWVdvddTZcRGIN4r8cPlHToSteHsLIYU0t05ghp25EF0BG?=
 =?us-ascii?Q?9QSzTfXEeMGHGagtAF2ogTjSt5fm1f9Jz+gxs4meZfEV/Q5DhHgPYTBfZYwM?=
 =?us-ascii?Q?WYSGceZmAldscRbBkMzjiuLGYOzvaja7T1mcFOkQ6hvaK6+aXDbdd8OOxXhF?=
 =?us-ascii?Q?gAZG/Vxz9PuNC+u5rhOf5sr8yAR7VaWuf+4E3F07RzyalYHL77OVtPOAK1vE?=
 =?us-ascii?Q?lHvWEumHM6rzkvRH4XC16MfRynMUBjRXZoHrRsLlr08T/kSrqHy1vKlej90K?=
 =?us-ascii?Q?G0uvWHrD7/dKQGg=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(82310400026)(14060799003)(36860700013)(376014)(35042699022)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 11:18:14.8056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6fa9fa-e4d3-4f85-4e1b-08dd67a0e868
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10053

This patch adds GPU model name and FW binary support for Mali-G710,
Mali-G510, and Mali-G310.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_fw.c | 2 ++
 drivers/gpu/drm/panthor/panthor_hw.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 8a967af0e2b4..7050adfaa8b6 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1398,6 +1398,8 @@ int panthor_fw_init(struct panthor_device *ptdev)
 }
 
 MODULE_FIRMWARE("arm/mali/arch10.8/mali_csffw.bin");
+MODULE_FIRMWARE("arm/mali/arch10.10/mali_csffw.bin");
+MODULE_FIRMWARE("arm/mali/arch10.12/mali_csffw.bin");
 MODULE_FIRMWARE("arm/mali/arch11.8/mali_csffw.bin");
 MODULE_FIRMWARE("arm/mali/arch12.8/mali_csffw.bin");
 MODULE_FIRMWARE("arm/mali/arch13.8/mali_csffw.bin");
diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index e6354304bbef..6f18b7420f90 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -49,8 +49,14 @@ static char *get_gpu_model_name(struct panthor_device *ptdev)
 	const u8 shader_core_count = hweight64(ptdev->gpu_info.shader_present);
 
 	switch (product_id) {
+	case GPU_PROD_ID_MAKE(10, 2):
+		return "Mali-G710";
 	case GPU_PROD_ID_MAKE(10, 7):
 		return "Mali-G610";
+	case GPU_PROD_ID_MAKE(10, 3):
+		return "Mali-G510";
+	case GPU_PROD_ID_MAKE(10, 4):
+		return "Mali-G310";
 	case GPU_PROD_ID_MAKE(11, 2):
 		if (shader_core_count > 10 && ray_intersection)
 			return "Mali-G715-Immortalis";
-- 
2.47.1


