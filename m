Return-Path: <linux-kernel+bounces-569565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42719A6A4BD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BD193BBA63
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B4221638D;
	Thu, 20 Mar 2025 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KyzWO5cY";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KyzWO5cY"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013001.outbound.protection.outlook.com [40.107.162.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF57921CA00
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.1
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469493; cv=fail; b=dEWwMIiutBN2oT8hci5kMMgDy51GUFQEfz9Q9uwr5My3tjosnYW2VDo65/e8qJ+3B4GMvn9jQjlZolKDqQWbCmJ+yO6CIFjhlKFdz2hKtYYds6pGtF95BmAq1QcuErXyDgo6vEFfcbvUts4duMG2a/HH/HLtpxD8DJ70BFiyVMc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469493; c=relaxed/simple;
	bh=2Pf5a7CYQeH9+gJ/7pgpg7X//sZbDgXOk9aWWKmC1a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ueOqC3/oz8SHs8m+46ef5R2ANFJKD2X7So7R7rpJZ8jLg7mo3/JYiCAbBVMoDV0yKDNd6ssd8mCW0NhfFdP+6yos7p/ImsWOm59v252mc6IStCkX9x/vcVYkhwXqm/gU8IDun2XAj7UGPNgCHWBdmFwCRRGsrliaKHYXoRPdZpA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KyzWO5cY; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KyzWO5cY; arc=fail smtp.client-ip=40.107.162.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=yw2N9hRYFZb+j+PVw4tx4MDVdt1HOMjEuUdivoomkmMfaCCjSez3s7D+JZdPygB1v2SkY5r1X1tkswt8RYEXr2w2EumpEadQ66D3kAhKKsKeUZ8zr3oJpg+cJoz0YA/I5bzQF8XGkUTgfh1dyHAq9L979p9mlYn0O4H2/Ls7ouXFDC1nJ3xZyo9NZABuKHNCPI3xP7MTFcpC9WsHDwozsRCOV+fg15Y8mcU3vgADYn5FOhsdinFUPc2z8qPaA7Bxv+6yrwRFbNye1/T3jEOsuXq4nQVVc46ex0xSMDhBGQinBfgPTR3pPZ4M3U6oJOf2qaa9Qc4mGNzMDtqRE9a7Og==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRebtytzwduaT1yFLixubl//0RIkS3ONaXIJs4lqlBI=;
 b=jS1gdEm5R/mP/BVs3t57rNTxyk/0gZdO0/JQzL2KRmh+pq2i0G/Yi85glOWaeuO1u4wRrdBbTXWKTawcvneDryc4305qsP2dZzcVWd6DwuF0idTMa6Mv8TVRd3gFrRlG52c1x1VbstCKVB0VIZMfCQUbdGO7/NZVG5QK/3KkimAEKJpTgOpqHoBCgSOC1zbJ9hHkRKtPX0V5NWRyF+ZBNWMbw40Aw4xtMbwrVjFCbZbuxI9RALwHYzfFOV3oLToDbirFFfQ8tLZd5pqdG+aN1I2VLByI9XmytM0jjBeGxueWVVSmj2wJegVuhtzTuinctC9J3mUWHHjuGk0+lUjgVA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRebtytzwduaT1yFLixubl//0RIkS3ONaXIJs4lqlBI=;
 b=KyzWO5cY1/MWK5m7EJN6vA6tAX2eIO1Z/3qI9ozdLJomCIAGXOTO/chmpxszRPnG2XVjIYIOXdqq0GGzRcjiJOYTxTNL5Y0gDkHYw5VB0UXqU6Q5oyH83akCJyoJ0HWhLFKdlotpt/OHOpkL+xsKK35qNIh2iuZwyp5FWO4zdnU=
Received: from AM9P192CA0028.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::33)
 by GV1PR08MB7705.eurprd08.prod.outlook.com (2603:10a6:150:50::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.35; Thu, 20 Mar
 2025 11:18:03 +0000
Received: from AM4PEPF00027A5D.eurprd04.prod.outlook.com
 (2603:10a6:20b:21d:cafe::bf) by AM9P192CA0028.outlook.office365.com
 (2603:10a6:20b:21d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Thu,
 20 Mar 2025 11:18:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM4PEPF00027A5D.mail.protection.outlook.com (10.167.16.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Thu, 20 Mar 2025 11:18:02 +0000
Received: ("Tessian outbound bf3b9ac19d92:v597"); Thu, 20 Mar 2025 11:18:02 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0868f4351d434c20
X-TessianGatewayMetadata: kqKfuUxgC7LiPkY2f7lIeirY/u3/B+ClWxcIg/vS96ZVzrneE0tBdinuSNz3EVDBGTOdN812OaAYURTqlxALCOU3+HW4Igc0rWNJrbgynm/J+Ox/3XQelCkEqN+FejmgsQxJJhi8SwVZLFCPphxHCyDhrgvMMCm0aRPPnzL73F0=
X-CR-MTA-TID: 64aa7808
Received: from Ld7c658350928.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 823BE96C-9267-4309-9A10-767B3B00ABB6.1;
	Thu, 20 Mar 2025 11:17:56 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Ld7c658350928.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Thu, 20 Mar 2025 11:17:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPVttxSsWn+r6VFKIM0Tw5wP5DXq6U+zV7Hm0tyvXPVsdE4nNAuVk1Yfcaow4JuJ6y9sgisAPl3P17alOEqbMZ9zY0nrMWCg0qZoNf1vlccV01DrjUaFEflNEBhR1SROV5VXe+83dHwickCYk9yHSnGfdIOAoRq97moFeU6XeIp51sxrz8p8hgVEqVuDhC16mswj8rux60bXQ0z0t6jlKeL8J4uHeb7iJUmjZk+OCtGiviHu9TG3isiAX30wT7ejEliMDcG9Z4F9f/d7ozu4KxoeXJKHwc1sYweKcx139MShjbGJ02nfmviofx5FOMqOLz9fRSFTHt+Z8/CPEa1UvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRebtytzwduaT1yFLixubl//0RIkS3ONaXIJs4lqlBI=;
 b=Z/SQ27n9PUymONjQ+4JkX16RtsTQy/TXRp4pELhvpeJDOwMqzB6ZQ6Sbvn7G0C2FLeoBtL84U7UIvG15wSZ4chpGpWqdClULEuGQM43ll0tHWeRXhM+tVJiIms2BjKfBE+sLDE14aVAdRkUlcM75Q8JnA4I1TqZYYTAYKIuo8AMPV29vOIdI3CAZhs105VfiSDFdaApoHLuTWrypjfYDSeEGjxAn0dtqE1ibm2wGenCkKUa1XaPXeG2PlueLZ+Q03Evd2Rxgl80u/vnO3yTC7AItwrQSSMIDJn/v44V7XYvGKsih39eHY/bpXmC99pUxVVAY8VEeOL1rQkH1wqcRcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRebtytzwduaT1yFLixubl//0RIkS3ONaXIJs4lqlBI=;
 b=KyzWO5cY1/MWK5m7EJN6vA6tAX2eIO1Z/3qI9ozdLJomCIAGXOTO/chmpxszRPnG2XVjIYIOXdqq0GGzRcjiJOYTxTNL5Y0gDkHYw5VB0UXqU6Q5oyH83akCJyoJ0HWhLFKdlotpt/OHOpkL+xsKK35qNIh2iuZwyp5FWO4zdnU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DB9PR08MB6715.eurprd08.prod.outlook.com
 (2603:10a6:10:26f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 20 Mar
 2025 11:17:54 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::d594:64a:dfc:db74]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::d594:64a:dfc:db74%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 11:17:53 +0000
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
Subject: [PATCH v2 1/9] drm/panthor: Add 64-bit and poll register accessors
Date: Thu, 20 Mar 2025 11:17:33 +0000
Message-ID: <20250320111741.1937892-2-karunika.choo@arm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250320111741.1937892-1-karunika.choo@arm.com>
References: <20250320111741.1937892-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0072.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::36) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB11200:EE_|DB9PR08MB6715:EE_|AM4PEPF00027A5D:EE_|GV1PR08MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b11753-babd-4ef2-f5b8-08dd67a0e166
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?ghwbbx4LDgu1mCBjYmIruUORTZ2jJMVvOYR6/SW/N8KC2oZgvlMWgSI/IXG3?=
 =?us-ascii?Q?IQ4UgLlLWrfZ0jQJgUmgfSz7zg+cKagcH5vUIWoaCCYev2XJraVtQB+31jPJ?=
 =?us-ascii?Q?vXMcrqIUxXljUiOWQ8B2t7/vzdGGRYL9HacATXSFjW31KxV5lZZCkR7huasD?=
 =?us-ascii?Q?Tl/hsjo6zb9PoOwXODKkBcVG02m1us2WKe6yULC4qdd845Cf7ww4fv5O6lT3?=
 =?us-ascii?Q?Iu4YzZ76vNiHxBESE/aVPgKqbLNOsf1Q2I7YA8Tgu79Hbz/B9VTkzUpd2ZiE?=
 =?us-ascii?Q?XHGw1ZrCE9oyrF/nx640HDQIEpv1M0aLLG2AnnhJJv3TP6fDSV3U4QiQY8Pl?=
 =?us-ascii?Q?h0bVMmLDYqB0iOtBWNYfCJxz1m9Av1GegpRqRzNN6nYjn0/4xwaghBI9FV7d?=
 =?us-ascii?Q?aTIOVG6wXvtD8wkDFhGqDNMnXpEKenrnMPU272oP7F5xFCSjhyPLsdWgCHq0?=
 =?us-ascii?Q?cjSBq7OeH3NJYzwSFONFUPoIqUUL/6Y/ipQVHqQ4pcIi0wBJ8WcgLLqINiua?=
 =?us-ascii?Q?CgdeN0o/1xpPKJgpnBu1HJZiDEeOKUbGBLtGocrWcDz9QMuk/n6/bZrJ/2Rv?=
 =?us-ascii?Q?5jGrxqHFZBsTG+Lf3C+hUKh4Dob0/f/lfC7a841fHhsZHLcY6U/hHgfGgVbD?=
 =?us-ascii?Q?m/zln4Az/ki57DgIQN+d5/EfvdXIw+XJ7gzI4U8AsGUjJ3mbWqFOQZhQLVnv?=
 =?us-ascii?Q?1aJqvW/0SRbdUdygABDa82o2T4/rPb9/Je2S7UeID3/pyQoLVGPbWTtOua8r?=
 =?us-ascii?Q?MJkEQ5/Q+kdhF94kB2xOFfs/OMckUmZpX7DvryxeaMaOXGxhYFnFdwJBRSkK?=
 =?us-ascii?Q?Q8nb66YZy94+KT8PYmzV2h87VJeYFUfJoJsAPoBCO1j26sfdcxJFpWjOy7Az?=
 =?us-ascii?Q?KwGhDU/WC7dqzX0ZzV8Lz0nJMupyf4Y/9qQc8iu5X5G68svXfF5/58JHH31T?=
 =?us-ascii?Q?dTKSWIOSvxfzHnArDMz/I+xL77foiAFyfVH2Q4VKx3BRd3OZBxtCr9gyuVPl?=
 =?us-ascii?Q?nxdRY87kkLhL37Ke14EIW8Q10wmMuwgazSKtovtL9zLXU1lZvxFKC2A8If4R?=
 =?us-ascii?Q?ERDl7W6PZT13gnmistg0RTWNZrZMEGS8BhUMFRayR3NxlgBLnVugQzFsoVmu?=
 =?us-ascii?Q?blKGLhj/VvJkWv/on6MOTr6JMdUieF+r2aYHGZMqBccwoqCnjUrZaJw48ThS?=
 =?us-ascii?Q?wR/vzvaTujgHGh5AbHUl/pYCUuzbWkN2hu72huMaPRYVh2S+3YSn7cuoZuqs?=
 =?us-ascii?Q?lx8QDxU/ToEJc1doiAeezJ08pl0AckSfXSsb/VsvrNJaWHjZbjjIMCH5zBSG?=
 =?us-ascii?Q?1XGCGIvB0mO30MyP2NG7kcI6nOGgxurNbT+LqdK4Olyzouh+tn6dqNDqjm7B?=
 =?us-ascii?Q?IcVj4TY2yvPe7DX5sSK8P/qkXuXy?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB11200.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6715
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:800:257::18];domain=VI0PR08MB11200.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A5D.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	65afeabe-54d5-41b5-35d5-08dd67a0dbd0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|35042699022|1800799024|82310400026|14060799003|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LN+8j9bBpWjFDVlkBFlH3CrQwcC2YGo8Hh7s7FWDcFR0Edy4OSz9DsDPR424?=
 =?us-ascii?Q?jNm/sRF0Za2VDyBqt0vSnhf471OOYq0lAv3RuL+XvFlftZF0AhFJNrcc51Cm?=
 =?us-ascii?Q?Uvp37NZxxc4AnLjMMkKYrrFi5tXC8tuVZCdZpUosn09rLjPHRBJqaS9qM/IR?=
 =?us-ascii?Q?mr3yY+tqW74dUQft8xLDsWFDXOAdPUx8e1/8OUkJbrCvMESQG+KeWWoxl5o5?=
 =?us-ascii?Q?C/tmOq1fxh5kldS9gZ60jOBriTxlsWITmGfzDa4iMaJaUKbZWQ8eqW+qBOqg?=
 =?us-ascii?Q?BF0yeq/jtQwZmT4uK9Uwa9oNITVnqNjjqxsB0bXAUPTXCqmPV7istZN93CuT?=
 =?us-ascii?Q?s+8qol/D+LXCPTz8oobj7OLKQtHZ3zEvouJlO8Cz/2YZUVWRPFxxkqW3HPT/?=
 =?us-ascii?Q?RHKkBCHkG+yxbScqfANqg9EWynSapFoUv3ivoag2E8ZUxBR7XFgN81kU8snu?=
 =?us-ascii?Q?3m1RF+tq5KZBuUxqM01NJqREgA+lWNOcanA6BVFl4iOPbs8PAHnC3zgR5wPa?=
 =?us-ascii?Q?0MG/cfzTfLYTtgcL12G9lBKnCT/WBFjvJXpr1D4xRnX7nBh/lETud0ddu5x3?=
 =?us-ascii?Q?IIR8LCQnTjkifntIRNMe2rxG0N15qe6aLVnEnD3JS+eX7erHhpLuE8SF8GSC?=
 =?us-ascii?Q?12Z/fKowOwzxzah2uBMpLRymQI/Xc07EAQHGFluteeGCAkhcTuAh7RXFTqgy?=
 =?us-ascii?Q?teowQBBBN/NYhaGFXaBInWxMFF8KhgqmRLKxHOXvID1FPGHOpAGcJzX6hVva?=
 =?us-ascii?Q?J2SNmnJq3Sq8G5XI4KJnfwWx5LpRpFW1K58Ra0iJHfCrB5uofhVLY9FqABWM?=
 =?us-ascii?Q?cX+ne2i+NdtBuFZCYO4H0BDGVOMQduNAerbnLgABCrgteseWerfTTNPZys/f?=
 =?us-ascii?Q?mpXxZd9R0k2LpfQJoDk7Uoy2ITkxJMdeUTDnulGdDNlMHPmwoFltspZv4pYP?=
 =?us-ascii?Q?ps+hL3FraOTvj8/XkTEz/uBfW9VEaxeYhZOEq/FCm5F97NmwPF8xQBVVA09q?=
 =?us-ascii?Q?Gj+Wg/ZM41KcCXWoAEVkNXf5nnK1X8JVAdAufaY+xDUuRckfyNgFtR57YpEC?=
 =?us-ascii?Q?CIQpQW4TgiWWne+X1snj9Wgv5/k5qM1v6Q74zqFbavO1w4YP9ElUMVRlx6LH?=
 =?us-ascii?Q?99KZ0hKbeoJLhKB0y484lijIJzdmMJ5oB5MpbdRquf1+nIV8xy1nAjj8LCEK?=
 =?us-ascii?Q?XilwfLsseItxbN55zi+sQyXNOr4WMFyyUzpp5SuUtYOj+bF800snJ32yD1Jg?=
 =?us-ascii?Q?sLYMm3LZ3oomH4UBG0hEPfKw2gha9yKHnHluML2MCrO/w1MUWL/NpT3WRVuB?=
 =?us-ascii?Q?5uwf7/majnum39fAfnTJF7r0C1mIFsGMtohe5nhFNTg89ej8LmsSu2Tcz1Uo?=
 =?us-ascii?Q?SJOPDSXuNHlb/ARPKP/T/pc6xSp0Wz1JnCn1DPLKDylF4lhDIWL6fzTPdxCZ?=
 =?us-ascii?Q?DyXAiKiqodqWaR9KHwbhGmW52yks+EfOXX+tsoLlj3MWVeBy+7e/ZgReultD?=
 =?us-ascii?Q?crsqmGGpivQJdwo=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(376014)(35042699022)(1800799024)(82310400026)(14060799003)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 11:18:02.9434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b11753-babd-4ef2-f5b8-08dd67a0e166
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7705

This patch adds 64-bit register accessors to simplify register access in
Panthor. It also adds 32-bit and 64-bit variants for read_poll_timeout.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_regs.h | 55 ++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_regs.h b/drivers/gpu/drm/panthor/panthor_regs.h
index 42dc3fedb0d4..7ec4a1d04e20 100644
--- a/drivers/gpu/drm/panthor/panthor_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_regs.h
@@ -238,4 +238,59 @@
 #define gpu_read(dev, reg) \
 	readl((dev)->iomem + (reg))
 
+#define gpu_read_relaxed(dev, reg) readl_relaxed((dev)->iomem + (reg))
+
+#define gpu_write64(dev, reg, data)                            \
+	do {                                                   \
+		u64 __val = (u64)(data);                       \
+		gpu_write(dev, reg, lower_32_bits(__val));     \
+		gpu_write(dev, reg + 4, upper_32_bits(__val)); \
+	} while (0)
+
+#define gpu_read64(dev, reg) \
+	(gpu_read(dev, reg) | ((u64)gpu_read(dev, reg + 4) << 32))
+
+#define gpu_read64_relaxed(dev, reg)  \
+	(gpu_read_relaxed(dev, reg) | \
+	 ((u64)gpu_read_relaxed(dev, reg + 4) << 32))
+
+#define gpu_read64_sync(dev, reg)                     \
+	({                                            \
+		u32 lo, hi1, hi2;                     \
+		do {                                  \
+			hi1 = gpu_read(dev, reg + 4); \
+			lo = gpu_read(dev, reg);      \
+			hi2 = gpu_read(dev, reg + 4); \
+		} while (hi1 != hi2);                 \
+		lo | ((u64)hi2 << 32);                \
+	})
+
+#define gpu_read_poll_timeout(dev, reg, val, cond, delay_us, timeout_us)    \
+	read_poll_timeout(gpu_read, val, cond, delay_us, timeout_us, false, \
+			  dev, reg)
+
+#define gpu_read_poll_timeout_atomic(dev, reg, val, cond, delay_us,         \
+				     timeout_us)                            \
+	read_poll_timeout_atomic(gpu_read, val, cond, delay_us, timeout_us, \
+				 false, dev, reg)
+
+#define gpu_read64_poll_timeout(dev, reg, val, cond, delay_us, timeout_us)    \
+	read_poll_timeout(gpu_read64, val, cond, delay_us, timeout_us, false, \
+			  dev, reg)
+
+#define gpu_read64_poll_timeout_atomic(dev, reg, val, cond, delay_us,         \
+				       timeout_us)                            \
+	read_poll_timeout_atomic(gpu_read64, val, cond, delay_us, timeout_us, \
+				 false, dev, reg)
+
+#define gpu_read_relaxed_poll_timeout_atomic(dev, reg, val, cond, delay_us, \
+					     timeout_us)                    \
+	read_poll_timeout_atomic(gpu_read_relaxed, val, cond, delay_us,     \
+				 timeout_us, false, dev, reg)
+
+#define gpu_read64_relaxed_poll_timeout(dev, reg, val, cond, delay_us,         \
+					timeout_us)                            \
+	read_poll_timeout(gpu_read64_relaxed, val, cond, delay_us, timeout_us, \
+			  false, dev, reg)
+
 #endif
-- 
2.47.1


