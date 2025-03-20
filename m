Return-Path: <linux-kernel+bounces-569566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 750DFA6A4C3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 513E63B929F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E3321D3D4;
	Thu, 20 Mar 2025 11:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="H0kmSs3y";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="H0kmSs3y"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9384B21CA0E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.66
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469496; cv=fail; b=rje2xFUjh1y8UbMVeVkSjp/QERYHktO578wE8chnzDSJOoaYK/NrdPI/vCfS/5/WAfMcFvWpTz918/nUdBgTgwp0U+S/cA2quvL4mABF5h/l4n4URkU2fSbu4z8cD+lhpuIDYt4gnjKrklyVIsZzSXyUOdmOWPX64nIeOwXMnt4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469496; c=relaxed/simple;
	bh=Yp3f8vSODqzYH9uRD0EcQxRmCDwTuIgZWrTQoiijrdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VD+M+sF9X8O89zV4/0eQIgx/JIJUriPMA6oOOswWPYLhBvKbcqWZfP9RGo5MtcWQmTJzKN1JeEIsLcwhBnW6RUOttfAWGdzBEoGMUy4FkQuQFbToJ3xbywpOLz2/3gvY81qGMm9tsbwlp77gQuBDiBvEdkEYohcbENA9Y3LcIVo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=H0kmSs3y; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=H0kmSs3y; arc=fail smtp.client-ip=40.107.22.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=KJYawwsunOqZIWfFZDcNc43TrqzXzQjA8ct31ARDrKMHU1HZ/8p7nA+LxWMFCMga6JUMBj5aDXLuQjDIpOj0HF+M2Or1+IBrmbrn8p5pDfvf4ac1THBBDktY0R+cufkCIoUCdDe2je3Tu82K1IXTATN1nj2kwWA9S3uYwgHnWiwM7PlN+weE2PV3G6eYjjhooyHGy4FzyAiZVuw9aTAHs85fDjDxl9JNZC5hGWenB/HkYz35CjZlH/zQ5iG+xqBRIxY/IPqBl7uoskDdo+1SkTXk0be5OYWoZxbBAgLJlBVXIZARBma+D1KXT/RwIFzCr4BpZbP8Ilbd+oBtT0JvxQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHh7Af4iUDZdxAx8A3l6XrN18BNSMzVMUovDIP1fy54=;
 b=NJ0gEFU919enoIWUlo5Iqwz4TO7SiL10QHPVYOBTSyx3ak7nX1Xvy84w9rCYVLpqNmpn/vM3j4WLPxv81Jvc2V8P+0ic9A+RuwAZoJwkmCfuvfYop9V0+k1VxVZ9xHnVuxp4vGAC3pGYO933iNeR2W+VnXcFNv462/NH7MbyqMPXdqscMDLTitucyvmRLW9iyyb8zmvhGtHQ/WjB0Xf7TXERd/hulMMbn49seh/8qCUvcFesWwfWERoKCS4JXxuwYJQWcdvR9XlISOxDuglkqjIh8qnOyFKy0RB5BFmOBodX/Dy9+qDdf6CP2QSe9aF8mq1fAQIoRECy/GjbW41sow==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHh7Af4iUDZdxAx8A3l6XrN18BNSMzVMUovDIP1fy54=;
 b=H0kmSs3ynRJqDp9voCHxQstaBWCnCPLOgY1R4z6Q76TA1g8t2CxFYy6b3khQp4goiDF/UlvTjQZi9mQPoqf76UxmFTpbjgNYT/62ByLiUKi/U0CprUTkzh5rPqBYVIyEuDX4TzTjQJWziwkTKpF+Jdwbp5J4WGa8B6kW05GCMLg=
Received: from AM0PR10CA0025.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::35)
 by DB9PR08MB7795.eurprd08.prod.outlook.com (2603:10a6:10:39a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 11:18:07 +0000
Received: from AMS0EPF00000195.eurprd05.prod.outlook.com
 (2603:10a6:208:17c:cafe::e8) by AM0PR10CA0025.outlook.office365.com
 (2603:10a6:208:17c::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Thu,
 20 Mar 2025 11:18:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF00000195.mail.protection.outlook.com (10.167.16.215) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Thu, 20 Mar 2025 11:18:07 +0000
Received: ("Tessian outbound c7a7213353f4:v597"); Thu, 20 Mar 2025 11:18:06 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f1feabd50aa1467c
X-TessianGatewayMetadata: mUSgo1F9I0kbSDRLP2bFH3Xe8ZM5c/LMivq9UxGs+IbITUga6AeZoO8Mp6Ka+6M1LJBgor93ReuYKpZIb4NUZHjYxnGIZuVZBrL+E7Cjbp/W1CcFDVVZhcc7ZuPGZcReoBdxsDaT6X6ZE9QkOe0+RFG3AP6oiESrWw9Na6n0wdo=
X-CR-MTA-TID: 64aa7808
Received: from Ldeff37903ba1.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id ABF6DA69-1D0C-42D4-9453-8DC738F3597E.1;
	Thu, 20 Mar 2025 11:17:59 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Ldeff37903ba1.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Thu, 20 Mar 2025 11:17:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2Kkc/l8JnwTIIZDv1ZHy60Vv5kYjKPcJRDIJFINEdHoYY0c16x7TIcYP9grMv/fnnPsyu2fsVgDD+QyVG2y3O8p2GHHZZIXeSypyc1vtV72pFlckTqkbLXpHVKDVgjD2obw5V8dkF4hRbFiqCa+Pb5FfpUZl8CjPIWnPSsMKt1C+jKHI2UfE/AmDaIDAmNSYjzlhzKlMGiFaIj5g+Xmp3sJmkutlkthvGomekcXww4VRbH3R8thJ/N/tIxgneysn1JtXxVN6/W1js26YkHDwCXXkWtMSyQ2SYtVSMEVAn792BMgGArPuklVuqdlIzpmpikUwBNjwwb4P2+VJru3KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHh7Af4iUDZdxAx8A3l6XrN18BNSMzVMUovDIP1fy54=;
 b=Ga1oHEJNBnAqAtE3MhYB2JXfBr/m4JQyHQOlGvhkZswALnSYmUQMAP3/uAMD5ssxhwmpfFV10XJA5c4kPndHIX1L8rghCf8ifjZ0nEdINW0VcRGaSHWfaySD1R2PaapjajEnQLJ/7FlgBE22Q2JdmnMY1y5fzDmMkeYBE1/IqVYQHn/TFp4kkvfG1gq2JlREys+5FKte/4fYUrc09768n+LsyfBHnig9j3Be1U0E3VwSgq84SlKELv9rVo8XDIywlG3ltAyj9/pfd57TWghxDnXXqJRwz0HaYMFXTSCG/af2ajtZBzFUDx9NF6+Gln61BC0VD2BLt6cASrSRw45aPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHh7Af4iUDZdxAx8A3l6XrN18BNSMzVMUovDIP1fy54=;
 b=H0kmSs3ynRJqDp9voCHxQstaBWCnCPLOgY1R4z6Q76TA1g8t2CxFYy6b3khQp4goiDF/UlvTjQZi9mQPoqf76UxmFTpbjgNYT/62ByLiUKi/U0CprUTkzh5rPqBYVIyEuDX4TzTjQJWziwkTKpF+Jdwbp5J4WGa8B6kW05GCMLg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by AS2PR08MB9074.eurprd08.prod.outlook.com
 (2603:10a6:20b:5fc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 11:17:57 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::d594:64a:dfc:db74]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::d594:64a:dfc:db74%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 11:17:55 +0000
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
Subject: [PATCH v2 2/9] drm/panthor: Use 64-bit and poll register accessors
Date: Thu, 20 Mar 2025 11:17:34 +0000
Message-ID: <20250320111741.1937892-3-karunika.choo@arm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250320111741.1937892-1-karunika.choo@arm.com>
References: <20250320111741.1937892-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0052.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::16) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB11200:EE_|AS2PR08MB9074:EE_|AMS0EPF00000195:EE_|DB9PR08MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: ac9c9133-ebc2-445e-9154-08dd67a0e41b
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?xSdyAbR4EB+zD4ksWQJRBsa2zgVnLvPCMeEKrCo2RP7it1pqisa9e70I3XRC?=
 =?us-ascii?Q?dYCmjmdnEyparoCZedb4Srbr3K+WyPckvxFu0N1SNbCd1WcygJBUVJZ8b0fl?=
 =?us-ascii?Q?pPr2Mv3tWosX6FPuAQOU9RBUo5a1f2qgxvp6GkOxQt63usSQjtcXlMz9udro?=
 =?us-ascii?Q?c5yBgnlzlfwfHI+IEdD8IhsWawreiFRpcE3kFDAWMUKdOl9+KqkkrG82tMT1?=
 =?us-ascii?Q?1RYlZi+jZw3fTIkBm0c061h9E3HcysiSRdluwKTMVfRSoAoLp8+XP/NdpGS9?=
 =?us-ascii?Q?nc4Jm0e3s9JhXhgATHzqGcCbnrX8qgAwYUaysTl9qFnrfgPJaPLXbn0gRmr6?=
 =?us-ascii?Q?9N9x6lu4mPaSoqQq8nQ3Nn+maeYpjSqWpavlz7c1mYDFmdSmLg8dmseNNiiz?=
 =?us-ascii?Q?ur1maXgPJ8j/j5rrfajgeZ/X8lI5F0UMRUkb7Nu7QyXCfsYT0zB6NuN29Biv?=
 =?us-ascii?Q?bwnKKehK/6DemXJeo4teyeWzZFTOWuDwF38Rgnz0VIabhKtfEDz9KMrl3okz?=
 =?us-ascii?Q?G7myvQQ/FnrKNDVxH9kiQKAEqUmWT9lVTV1cYGBgWFGNAq6UYsc/g27eCgv4?=
 =?us-ascii?Q?8A4h+uPi/70LziTfY1/AJAu3AqlKS0Pe9i8lkViypyiiMm2bAZJFPwUhveIt?=
 =?us-ascii?Q?wbW8M4F0dFnEuCQbbOvE2D+WHb+Byu59At4aWE+yAIuJjW54ufsa2/0TQytd?=
 =?us-ascii?Q?l3EO3ANCav30hPvQRn5ydnO6f2MA0mAL0MGVPKauLVwkMuhz7JaKHmZ3QOVy?=
 =?us-ascii?Q?qr28veRkbFvMRm1kU5Dc3QVEOkt9t8Bdrmg6oK0jb4X2Yxn06eo/EdZlWGFd?=
 =?us-ascii?Q?uEapBdaDY6VmDeIv/o+byl1wfl4UEqASPJ6jnqD4seePEIo74vGufa8N1cXe?=
 =?us-ascii?Q?KTchM2wz54LIr+Xkjq0THd2t3VUsAmYSaE9QLlHJslPjZG5q119jW4pk6rla?=
 =?us-ascii?Q?60k84F+ngVpPGpC3PDiCSbyD6nYmXA82fnV8kwxNYT78DOnN99B+li3OmIGe?=
 =?us-ascii?Q?AO/sr66Z16fyBKcTcpBjM7g2SjWaW7SvoaQlmFpMw8WTrQB/b1L6ty3yTSeg?=
 =?us-ascii?Q?SpKXMJL22lHSJIpYGLBW4lWV/rggEOuIu2VFrwO0j5BF5sEsRD5hnTrkh4+P?=
 =?us-ascii?Q?ZGn0qfDCwYRTV5t9PQX0nl2jDTDpF3kssGyDQh4VaIAXlxFs7hEtjQj/rurU?=
 =?us-ascii?Q?p+51h7xnEbbIDX0JbDKK60yz70rc5WPmznRkyobjqmI8WK4kdL6UZyFcpoxk?=
 =?us-ascii?Q?TpaHgTsr6n6v+x71iB/0ceUuO9804W9spNHddD1rf79hQumDE4cMNbCVnybV?=
 =?us-ascii?Q?jjdmON/qrAa7mYONTq/990I3HBL1tLtKVMPuWLwiXLEWzPMadW8uaU3FxmEH?=
 =?us-ascii?Q?q2YCZ7C6B6xIhPGl/t40+sY9plbS?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB11200.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9074
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:800:257::18];domain=VI0PR08MB11200.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000195.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7cbdb6e8-3dcd-4294-b0cc-08dd67a0dca4
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|1800799024|14060799003|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vKpxMFzWSMyeNCL0n9v+iUvY1zkb58w7EATJbRXGH/sPxUf1kbLKDcGZpMjw?=
 =?us-ascii?Q?ei+1gJKPYU1gQNFJH0qx0Sr+7lPxp7h2xArLs2UOuKRGlxtSQsZNFdfWMEVa?=
 =?us-ascii?Q?JrKMLNwGNItzEr3QLeqruqZ5KEHdZGu5oguzq266E90RNmHFD35x9NQGCeib?=
 =?us-ascii?Q?BsqPQxquT3Ea5GN3Bx9NDs4Qvo9SaSEAUYCZWv14ZtWWbkHtOALKH3c0jpuV?=
 =?us-ascii?Q?HkP5RdtSTQIVMJTYKiv8NkrH+haxIwSbe1vaze1pNd1F1eG+FFZ0OcXijG7W?=
 =?us-ascii?Q?RmaFtaKuIBOLFvFmaTti0q2uqch5rI0/S1keRKvcUFvAagTlaNWG42g3+UlN?=
 =?us-ascii?Q?zksPzpos9T9bGMBUpHEP4ERtig5iRfy6XIYI87elIQBcKXMAaiNK1XEIuZje?=
 =?us-ascii?Q?b5D0rY3s+S0+WJGKpVA5tbeDJDLYmylsWQgc+VerE9kHwK0SlRgJpj9IDfng?=
 =?us-ascii?Q?tPyk31ulbo9flbcpI7/HJzEWocJXvtzMYawg9jcJofPs9PreKmhfASfMCgyU?=
 =?us-ascii?Q?xwCRLN8DE7VC+eMm5h5sA1xOsp1KW1B3lFcrPK62J7U3N2Sf4J4Z4sF6ZkVw?=
 =?us-ascii?Q?o/Fj+XdtNLdXY6od8ZS/HZJkI1LroL+QXGK1bBg9pC1jO5xa8EA5dwFrBQev?=
 =?us-ascii?Q?595URh6BpSp7SnQn3UVmD/nw4SLpKsbB3YeeJTnSIZ855ne9j/id31wVA5eb?=
 =?us-ascii?Q?DLJdd8w/b39IX7C/4mNchgbQELyw89vhlkjBnh21Tfz1vf7asKy3Z7wRG0TB?=
 =?us-ascii?Q?kofAAxANpiYzSM/WVUIbfsSGngG9zpIdQ5qLf0Agb2muN+5mxeY9URcajZxl?=
 =?us-ascii?Q?H1F2sKQtMIlr+jKbB7nAtgdy92UnFZW+op7IA9tO6NDXB7i2SZuYIcjsRr7q?=
 =?us-ascii?Q?GiliLRd7PvVboKoy3Jxv0LuA6AyrYHu6UjJGM06T0oGaybn9WdnkWVAkO4eB?=
 =?us-ascii?Q?aU+LZkcWtBRu5SJdWCQTZSpfZdn6s343398kWF0eCS3zmToVWJCfT5qneCeg?=
 =?us-ascii?Q?2Ig62YfCgYL0OxsMomY7RPC82U/53Z66iLPcTLwU+wthZPglF84vajhw3d3n?=
 =?us-ascii?Q?j/05XrKSxpRWXSQ8UZdfORiKQiDK+uFyJ5JhvEdGXJdsOQHMc05y7vC/VYhS?=
 =?us-ascii?Q?qBQ2jZKckAizpRczcSuic19KirCJfl8sEkTTzgAXttKvsu57+PntUX15/Vcv?=
 =?us-ascii?Q?6/82JakeOD4vhhr4/iEOXln+a0hMVIoUfFuCRQyF9MjBdlaT3wPXpC378kkU?=
 =?us-ascii?Q?k7d2bHx0IJ9oVHtauLM185bjl0stvp3jz756lSLvTxFyeUJV8CALJ8eMgnp5?=
 =?us-ascii?Q?wqD7KL5jMySBqcdLUW0Q+Z/VZUHstSWG8DPiHh8N9RspG/MRuGS8CdOo31LS?=
 =?us-ascii?Q?9hbAnSFajicxC5C2yjaSSV8tpd/TIRIIlP+nPpxlI6lX9HmEnKiqne2l3O7+?=
 =?us-ascii?Q?aXm2xD2fK3V0oZrWoOTzMy8rJEVK/UsabJMZnJozqmKSYsZnGsgBj/YqxVOK?=
 =?us-ascii?Q?2DCPwxifGiKPRbw=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(1800799024)(14060799003)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 11:18:07.5137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9c9133-ebc2-445e-9154-08dd67a0e41b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000195.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7795

This patch updates Panthor to use the new 64-bit accessors and poll
functions.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_fw.c  |   9 +-
 drivers/gpu/drm/panthor/panthor_gpu.c | 142 +++++++-------------------
 drivers/gpu/drm/panthor/panthor_mmu.c |  34 ++----
 3 files changed, 53 insertions(+), 132 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 0f52766a3120..ecfbe0456f89 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1059,8 +1059,8 @@ static void panthor_fw_stop(struct panthor_device *ptdev)
 	u32 status;
 
 	gpu_write(ptdev, MCU_CONTROL, MCU_CONTROL_DISABLE);
-	if (readl_poll_timeout(ptdev->iomem + MCU_STATUS, status,
-			       status == MCU_STATUS_DISABLED, 10, 100000))
+	if (gpu_read_poll_timeout(ptdev, MCU_STATUS, status,
+				  status == MCU_STATUS_DISABLED, 10, 100000))
 		drm_err(&ptdev->base, "Failed to stop MCU");
 }
 
@@ -1085,8 +1085,9 @@ void panthor_fw_pre_reset(struct panthor_device *ptdev, bool on_hang)
 
 		panthor_fw_update_reqs(glb_iface, req, GLB_HALT, GLB_HALT);
 		gpu_write(ptdev, CSF_DOORBELL(CSF_GLB_DOORBELL_ID), 1);
-		if (!readl_poll_timeout(ptdev->iomem + MCU_STATUS, status,
-					status == MCU_STATUS_HALT, 10, 100000)) {
+		if (!gpu_read_poll_timeout(ptdev, MCU_STATUS, status,
+					   status == MCU_STATUS_HALT, 10,
+					   100000)) {
 			ptdev->reset.fast = true;
 		} else {
 			drm_warn(&ptdev->base, "Failed to cleanly suspend MCU");
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index 671049020afa..0dee011fe2e9 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -108,14 +108,9 @@ static void panthor_gpu_init_info(struct panthor_device *ptdev)
 
 	ptdev->gpu_info.as_present = gpu_read(ptdev, GPU_AS_PRESENT);
 
-	ptdev->gpu_info.shader_present = gpu_read(ptdev, GPU_SHADER_PRESENT_LO);
-	ptdev->gpu_info.shader_present |= (u64)gpu_read(ptdev, GPU_SHADER_PRESENT_HI) << 32;
-
-	ptdev->gpu_info.tiler_present = gpu_read(ptdev, GPU_TILER_PRESENT_LO);
-	ptdev->gpu_info.tiler_present |= (u64)gpu_read(ptdev, GPU_TILER_PRESENT_HI) << 32;
-
-	ptdev->gpu_info.l2_present = gpu_read(ptdev, GPU_L2_PRESENT_LO);
-	ptdev->gpu_info.l2_present |= (u64)gpu_read(ptdev, GPU_L2_PRESENT_HI) << 32;
+	ptdev->gpu_info.shader_present = gpu_read64(ptdev, GPU_SHADER_PRESENT_LO);
+	ptdev->gpu_info.tiler_present = gpu_read64(ptdev, GPU_TILER_PRESENT_LO);
+	ptdev->gpu_info.l2_present = gpu_read64(ptdev, GPU_L2_PRESENT_LO);
 
 	arch_major = GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id);
 	product_major = GPU_PROD_MAJOR(ptdev->gpu_info.gpu_id);
@@ -152,8 +147,7 @@ static void panthor_gpu_irq_handler(struct panthor_device *ptdev, u32 status)
 {
 	if (status & GPU_IRQ_FAULT) {
 		u32 fault_status = gpu_read(ptdev, GPU_FAULT_STATUS);
-		u64 address = ((u64)gpu_read(ptdev, GPU_FAULT_ADDR_HI) << 32) |
-			      gpu_read(ptdev, GPU_FAULT_ADDR_LO);
+		u64 address = gpu_read64(ptdev, GPU_FAULT_ADDR_LO);
 
 		drm_warn(&ptdev->base, "GPU Fault 0x%08x (%s) at 0x%016llx\n",
 			 fault_status, panthor_exception_name(ptdev, fault_status & 0xFF),
@@ -244,45 +238,27 @@ int panthor_gpu_block_power_off(struct panthor_device *ptdev,
 				u32 pwroff_reg, u32 pwrtrans_reg,
 				u64 mask, u32 timeout_us)
 {
-	u32 val, i;
+	u32 val;
 	int ret;
 
-	for (i = 0; i < 2; i++) {
-		u32 mask32 = mask >> (i * 32);
-
-		if (!mask32)
-			continue;
-
-		ret = readl_relaxed_poll_timeout(ptdev->iomem + pwrtrans_reg + (i * 4),
-						 val, !(mask32 & val),
-						 100, timeout_us);
-		if (ret) {
-			drm_err(&ptdev->base, "timeout waiting on %s:%llx power transition",
-				blk_name, mask);
-			return ret;
-		}
+	ret = gpu_read64_relaxed_poll_timeout(ptdev, pwrtrans_reg, val, !val,
+					      100, timeout_us);
+	if (ret) {
+		drm_err(&ptdev->base,
+			"timeout waiting on %s:%llx power transition", blk_name,
+			mask);
+		return ret;
 	}
 
-	if (mask & GENMASK(31, 0))
-		gpu_write(ptdev, pwroff_reg, mask);
-
-	if (mask >> 32)
-		gpu_write(ptdev, pwroff_reg + 4, mask >> 32);
-
-	for (i = 0; i < 2; i++) {
-		u32 mask32 = mask >> (i * 32);
+	gpu_write64(ptdev, pwroff_reg, mask);
 
-		if (!mask32)
-			continue;
-
-		ret = readl_relaxed_poll_timeout(ptdev->iomem + pwrtrans_reg + (i * 4),
-						 val, !(mask32 & val),
-						 100, timeout_us);
-		if (ret) {
-			drm_err(&ptdev->base, "timeout waiting on %s:%llx power transition",
-				blk_name, mask);
-			return ret;
-		}
+	ret = gpu_read64_relaxed_poll_timeout(ptdev, pwrtrans_reg, val, !val,
+					      100, timeout_us);
+	if (ret) {
+		drm_err(&ptdev->base,
+			"timeout waiting on %s:%llx power transition", blk_name,
+			mask);
+		return ret;
 	}
 
 	return 0;
@@ -305,45 +281,26 @@ int panthor_gpu_block_power_on(struct panthor_device *ptdev,
 			       u32 pwron_reg, u32 pwrtrans_reg,
 			       u32 rdy_reg, u64 mask, u32 timeout_us)
 {
-	u32 val, i;
+	u32 val;
 	int ret;
 
-	for (i = 0; i < 2; i++) {
-		u32 mask32 = mask >> (i * 32);
-
-		if (!mask32)
-			continue;
-
-		ret = readl_relaxed_poll_timeout(ptdev->iomem + pwrtrans_reg + (i * 4),
-						 val, !(mask32 & val),
-						 100, timeout_us);
-		if (ret) {
-			drm_err(&ptdev->base, "timeout waiting on %s:%llx power transition",
-				blk_name, mask);
-			return ret;
-		}
+	ret = gpu_read64_relaxed_poll_timeout(ptdev, pwrtrans_reg, val, !val,
+					      100, timeout_us);
+	if (ret) {
+		drm_err(&ptdev->base,
+			"timeout waiting on %s:%llx power transition", blk_name,
+			mask);
+		return ret;
 	}
 
-	if (mask & GENMASK(31, 0))
-		gpu_write(ptdev, pwron_reg, mask);
-
-	if (mask >> 32)
-		gpu_write(ptdev, pwron_reg + 4, mask >> 32);
-
-	for (i = 0; i < 2; i++) {
-		u32 mask32 = mask >> (i * 32);
+	gpu_write64(ptdev, pwron_reg, mask);
 
-		if (!mask32)
-			continue;
-
-		ret = readl_relaxed_poll_timeout(ptdev->iomem + rdy_reg + (i * 4),
-						 val, (mask32 & val) == mask32,
-						 100, timeout_us);
-		if (ret) {
-			drm_err(&ptdev->base, "timeout waiting on %s:%llx readiness",
-				blk_name, mask);
-			return ret;
-		}
+	ret = gpu_read64_relaxed_poll_timeout(ptdev, pwrtrans_reg, val, !val,
+					      100, timeout_us);
+	if (ret) {
+		drm_err(&ptdev->base, "timeout waiting on %s:%llx readiness",
+			blk_name, mask);
+		return ret;
 	}
 
 	return 0;
@@ -492,26 +449,6 @@ void panthor_gpu_resume(struct panthor_device *ptdev)
 	panthor_gpu_l2_power_on(ptdev);
 }
 
-/**
- * panthor_gpu_read_64bit_counter() - Read a 64-bit counter at a given offset.
- * @ptdev: Device.
- * @reg: The offset of the register to read.
- *
- * Return: The counter value.
- */
-static u64
-panthor_gpu_read_64bit_counter(struct panthor_device *ptdev, u32 reg)
-{
-	u32 hi, lo;
-
-	do {
-		hi = gpu_read(ptdev, reg + 0x4);
-		lo = gpu_read(ptdev, reg);
-	} while (hi != gpu_read(ptdev, reg + 0x4));
-
-	return ((u64)hi << 32) | lo;
-}
-
 /**
  * panthor_gpu_read_timestamp() - Read the timestamp register.
  * @ptdev: Device.
@@ -520,7 +457,7 @@ panthor_gpu_read_64bit_counter(struct panthor_device *ptdev, u32 reg)
  */
 u64 panthor_gpu_read_timestamp(struct panthor_device *ptdev)
 {
-	return panthor_gpu_read_64bit_counter(ptdev, GPU_TIMESTAMP_LO);
+	return gpu_read64_sync(ptdev, GPU_TIMESTAMP_LO);
 }
 
 /**
@@ -531,10 +468,5 @@ u64 panthor_gpu_read_timestamp(struct panthor_device *ptdev)
  */
 u64 panthor_gpu_read_timestamp_offset(struct panthor_device *ptdev)
 {
-	u32 hi, lo;
-
-	hi = gpu_read(ptdev, GPU_TIMESTAMP_OFFSET_HI);
-	lo = gpu_read(ptdev, GPU_TIMESTAMP_OFFSET_LO);
-
-	return ((u64)hi << 32) | lo;
+	return gpu_read64(ptdev, GPU_TIMESTAMP_OFFSET_LO);
 }
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 12a02e28f50f..a0a79f19bdea 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -510,9 +510,9 @@ static int wait_ready(struct panthor_device *ptdev, u32 as_nr)
 	/* Wait for the MMU status to indicate there is no active command, in
 	 * case one is pending.
 	 */
-	ret = readl_relaxed_poll_timeout_atomic(ptdev->iomem + AS_STATUS(as_nr),
-						val, !(val & AS_STATUS_AS_ACTIVE),
-						10, 100000);
+	ret = gpu_read_relaxed_poll_timeout_atomic(ptdev, AS_STATUS(as_nr), val,
+						   !(val & AS_STATUS_AS_ACTIVE),
+						   10, 100000);
 
 	if (ret) {
 		panthor_device_schedule_reset(ptdev);
@@ -564,8 +564,7 @@ static void lock_region(struct panthor_device *ptdev, u32 as_nr,
 	region = region_width | region_start;
 
 	/* Lock the region that needs to be updated */
-	gpu_write(ptdev, AS_LOCKADDR_LO(as_nr), lower_32_bits(region));
-	gpu_write(ptdev, AS_LOCKADDR_HI(as_nr), upper_32_bits(region));
+	gpu_write64(ptdev, AS_LOCKADDR_LO(as_nr), region);
 	write_cmd(ptdev, as_nr, AS_COMMAND_LOCK);
 }
 
@@ -615,14 +614,9 @@ static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
 	if (ret)
 		return ret;
 
-	gpu_write(ptdev, AS_TRANSTAB_LO(as_nr), lower_32_bits(transtab));
-	gpu_write(ptdev, AS_TRANSTAB_HI(as_nr), upper_32_bits(transtab));
-
-	gpu_write(ptdev, AS_MEMATTR_LO(as_nr), lower_32_bits(memattr));
-	gpu_write(ptdev, AS_MEMATTR_HI(as_nr), upper_32_bits(memattr));
-
-	gpu_write(ptdev, AS_TRANSCFG_LO(as_nr), lower_32_bits(transcfg));
-	gpu_write(ptdev, AS_TRANSCFG_HI(as_nr), upper_32_bits(transcfg));
+	gpu_write64(ptdev, AS_TRANSTAB_LO(as_nr), transtab);
+	gpu_write64(ptdev, AS_MEMATTR_LO(as_nr), memattr);
+	gpu_write64(ptdev, AS_TRANSCFG_LO(as_nr), transcfg);
 
 	return write_cmd(ptdev, as_nr, AS_COMMAND_UPDATE);
 }
@@ -635,14 +629,9 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr)
 	if (ret)
 		return ret;
 
-	gpu_write(ptdev, AS_TRANSTAB_LO(as_nr), 0);
-	gpu_write(ptdev, AS_TRANSTAB_HI(as_nr), 0);
-
-	gpu_write(ptdev, AS_MEMATTR_LO(as_nr), 0);
-	gpu_write(ptdev, AS_MEMATTR_HI(as_nr), 0);
-
-	gpu_write(ptdev, AS_TRANSCFG_LO(as_nr), AS_TRANSCFG_ADRMODE_UNMAPPED);
-	gpu_write(ptdev, AS_TRANSCFG_HI(as_nr), 0);
+	gpu_write64(ptdev, AS_TRANSTAB_LO(as_nr), 0);
+	gpu_write64(ptdev, AS_MEMATTR_LO(as_nr), 0);
+	gpu_write64(ptdev, AS_TRANSCFG_LO(as_nr), AS_TRANSCFG_ADRMODE_UNMAPPED);
 
 	return write_cmd(ptdev, as_nr, AS_COMMAND_UPDATE);
 }
@@ -1680,8 +1669,7 @@ static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status)
 		u32 source_id;
 
 		fault_status = gpu_read(ptdev, AS_FAULTSTATUS(as));
-		addr = gpu_read(ptdev, AS_FAULTADDRESS_LO(as));
-		addr |= (u64)gpu_read(ptdev, AS_FAULTADDRESS_HI(as)) << 32;
+		addr = gpu_read64(ptdev, AS_FAULTADDRESS_LO(as));
 
 		/* decode the fault status */
 		exception_type = fault_status & 0xFF;
-- 
2.47.1


