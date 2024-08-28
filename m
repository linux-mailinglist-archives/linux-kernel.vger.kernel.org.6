Return-Path: <linux-kernel+bounces-305423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8F0962E6E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73E67281B57
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BDD1A706D;
	Wed, 28 Aug 2024 17:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="W2Q7OUXJ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="W2Q7OUXJ"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2085.outbound.protection.outlook.com [40.107.104.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D581A704D
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 17:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.85
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724866017; cv=fail; b=tj1uBMwUv4B7n/d41gHkKzWG4R6QQ6nS7c7TqlgKX7dmznimSA8uMdlxMsgsS5MLVrSrZ30ZGTNL4A0xMhNwqXag6h/ZdX1VGWCN5ALI2EagRS5ww4GowBSE/vOhnPb1iOo37XI3Fz1VO+N65fpgYea1C1oqZlvcRCLiB1dedrs=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724866017; c=relaxed/simple;
	bh=ntjO93otC8q+mMNpdMf40nxlLNXTbOaERHiNEkRWpXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n2cTlFP4fXBwqn4h3hamCif0/B/s9Ke5eROAhmJE5xlOAleSgDq1zkKjsOiPpHJWX8MzEFfdLwsWueb8yM5pYjfQzXaHtmlnuyuZQvMRyS6YX+EotmC0i+vzL9qCsK5GCssAfkb6oNmE9ZL9j01f5khHoWoBNI/1/ylwo3bZalM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=W2Q7OUXJ; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=W2Q7OUXJ; arc=fail smtp.client-ip=40.107.104.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=t4BWg3rGTgeDZBXdc6JUPoV1kODQkan44128tCVwJC8tARMxeFg9is0WsgpL8KNP/SIQwFTGibtYWMeev8qFh/7gdQnNE3TB6aEMab/U01cncrvE9jYpAUxIwJ2o0nz8MBAPEwP471pgKXRbU+rPFKqr/kw6aRvkNtaQBY8UMNOiZa/5RyOV6OdCKhVx3Y30kHOQyFQynO62yoA0dTWZRDXnJQzFc4J12A+hEyA8mJQ+ZFytJpXITK2ZczbV0ec8Bmc+ZqPYE+pnb6vRlBvMUN87bHOiqn0MqbMBKHBafo3RKCc9XIILFXtaOfae8bOdAm9GDF5N+8wt/eYTwDnSdw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeHX61/O/2umCZPw5t1DtMVfso/n8K7MF+3P+aihtWE=;
 b=pPzrzkItH3DE+fGevcjqp4BmtS1HbrydqeLSfkOdPRqsmc0K2lN6/45yghavwS4BukxWg83ogoo+VGROSRfDirhzV8g3TZsiEOcV6q4+/zHqgK2KECDF7GK05lmQmMVAIyHCZJEUK8R46t+CCAabAx7NRhbQ6EBafUGTNGRnJ+AfFAEQ3uVx52X210ITtlhluFIum3pwmBbdeTGWAhvmUUlJS5UyUob62cfq5PrsgxSEFAqdG6ZuzkCl+Wdmf57bNU3N8IO3Ia+XcpVeydU8G6g/2qE1jlG/uLwVaBRfEaw7JxCdmDlqbS+RfJ7YrN+1RzMy6XNwjD7+Naf6zlGMhw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeHX61/O/2umCZPw5t1DtMVfso/n8K7MF+3P+aihtWE=;
 b=W2Q7OUXJDnmX5WN7lhH06Qt+2hiUtfPCTG6j/Y8wUEIEzN6TkbPIi29DGr04Pyky6z2CIm5E+1geGsk4tHoybU2fcYOvk/dImtCFOlA9cXPslDsShyVOPwhv3xcM9RMPvb7Hy1Fl3a1dxHvss1BUG1AKiBoNOf5txYSk2VqCRG4=
Received: from DB8P191CA0012.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::22)
 by AM8PR08MB5715.eurprd08.prod.outlook.com (2603:10a6:20b:1d7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.17; Wed, 28 Aug
 2024 17:26:47 +0000
Received: from DB3PEPF0000885A.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::48) by DB8P191CA0012.outlook.office365.com
 (2603:10a6:10:130::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27 via Frontend
 Transport; Wed, 28 Aug 2024 17:26:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB3PEPF0000885A.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Wed, 28 Aug 2024 17:26:47 +0000
Received: ("Tessian outbound 8e666bd17457:v403"); Wed, 28 Aug 2024 17:26:47 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 15b7cb167668d8f4
X-CR-MTA-TID: 64aa7808
Received: from Lf956fe85abe3.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id CDCA5A81-66DA-497B-86BB-23DBFC2F6D54.1;
	Wed, 28 Aug 2024 17:26:36 +0000
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lf956fe85abe3.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 28 Aug 2024 17:26:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNXwtjdy0oloupi7lxa8rOnGgFsmwPUq/QlHCXIOtZI69igVML3v/knB1+/x/pk98FW2l7uH6HefK3Iv02mgRPH8RWWu+Q2AA+ISIm+a4EQwePRg6bqfoR3kxoiE846GHHrmF3kyl7oDGxUOuTk4Bg1vOkI2fTqCli6cqf1ny36ZizTkqAx5OrhHmy26Qt1jhxh5S1GdYosvnhiduMpvWOqqUFJ0Lh8sBoHHrgieGfI14Q6lndDnitN3brpeInjeU1F7nu3scvhwdreBWhMeh/WY7iKTIU9lNU1hOgCyEHdyZff3LQE7nJ8RfxGU06ZK0LJdv3u5T0ctbeFsqb6/1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeHX61/O/2umCZPw5t1DtMVfso/n8K7MF+3P+aihtWE=;
 b=c/pOl2fezuzyUwnSqoI2Yr+nSZGVYkkzbueWYY+EdUZqOpZ2bjoKr9UHCqBWYciuMKG46n/AcEyAYWGoFhht/8NPwPoliS0VBn1iciKgA5kS0etXYIwdCmsuozvEQJT8zkhScAK+ohq4znwGpMfR9DytvUsfidaAQ/Q3cGk2bxp2Z/8o2g5rzCQxTzNd0FfMcd91HBcj+8rGF46ZDGB9dCeP4qJ5UfU8CYwGEOTLgKzq7DQgyukx2FPRkWETKp8cOqxymsjt9lLpELRYoG5MhSDyZZ00+2jhZYWcg7Pb8Hg6q6Jm1YNb0NWMTVOv4RAskd15n2sNWN5aGpD6Y1ZJUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeHX61/O/2umCZPw5t1DtMVfso/n8K7MF+3P+aihtWE=;
 b=W2Q7OUXJDnmX5WN7lhH06Qt+2hiUtfPCTG6j/Y8wUEIEzN6TkbPIi29DGr04Pyky6z2CIm5E+1geGsk4tHoybU2fcYOvk/dImtCFOlA9cXPslDsShyVOPwhv3xcM9RMPvb7Hy1Fl3a1dxHvss1BUG1AKiBoNOf5txYSk2VqCRG4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB6263.eurprd08.prod.outlook.com (2603:10a6:20b:290::9)
 by AS8PR08MB6551.eurprd08.prod.outlook.com (2603:10a6:20b:319::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.18; Wed, 28 Aug
 2024 17:26:33 +0000
Received: from AS8PR08MB6263.eurprd08.prod.outlook.com
 ([fe80::12b5:3f0a:2090:fa7c]) by AS8PR08MB6263.eurprd08.prod.outlook.com
 ([fe80::12b5:3f0a:2090:fa7c%7]) with mapi id 15.20.7918.012; Wed, 28 Aug 2024
 17:26:33 +0000
From: Mihail Atanassov <mihail.atanassov@arm.com>
To: linux-kernel@vger.kernel.org,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Steven Price <steven.price@arm.com>
Cc: dri-devel@lists.freedesktop.org,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	Shashank Sharma <shashank.sharma@amd.com>,
	Ketil Johnsen <ketil.johnsen@arm.com>,
	Akash Goel <akash.goel@arm.com>,
	Mihail Atanassov <mihail.atanassov@arm.com>
Subject: [PATCH 3/8] drm/panthor: Map doorbell pages
Date: Wed, 28 Aug 2024 18:25:59 +0100
Message-ID: <20240828172605.19176-4-mihail.atanassov@arm.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240828172605.19176-1-mihail.atanassov@arm.com>
References: <20240828172605.19176-1-mihail.atanassov@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0120.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::17) To AS8PR08MB6263.eurprd08.prod.outlook.com
 (2603:10a6:20b:290::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR08MB6263:EE_|AS8PR08MB6551:EE_|DB3PEPF0000885A:EE_|AM8PR08MB5715:EE_
X-MS-Office365-Filtering-Correlation-Id: fd1a7a69-95f7-41bc-43e6-08dcc7869856
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?zrGKAEk/GItpKimgYibyl4ro+EjW0sXNC/EPr6kALlpB1dU7vh4QRocFmzQL?=
 =?us-ascii?Q?nf6bjbKIObjX7m2y2hQIIjXIHg/YYraheZiF4hB6jD+q5mz5z+gWv6jrTq7k?=
 =?us-ascii?Q?MUQCstOcYYrCgE6gBK8fLQckXPGxNNAC6lB64wTGgUp7bNKcIIqHkZRzrPPQ?=
 =?us-ascii?Q?7wKLMnPE5BvNyFIOCY0R+rjIID+vYJkpWMuKvSlupA75e36x7+ILg6TlvzWf?=
 =?us-ascii?Q?/OLlhWrau89DjPZxWwEpoyL5c5O0HWdsT3LFGljhB1Yzkhs2VQjFw4YUlezT?=
 =?us-ascii?Q?+kPsZyPecjR0o/QQfSNlk0sHJBj+/d5OQwUHBCGHNPSzkRcC0r5/GslqaNMp?=
 =?us-ascii?Q?Q3UK04DFW/cPESwYZfH9CgsuEGhrvNtl78f0C+EsPiBDdAAvml7PVyFQ5Wlj?=
 =?us-ascii?Q?PsSO7oOctR3NfSDkR4yW+2zK9rmuVabseV/kOykWtBESopbkO8SPaL/WFviZ?=
 =?us-ascii?Q?qc/T+5Pu2eKTfJB8uRY9KbToGrXOMcjf8pqddMEPT/u7fIe/l5lUsL8fopul?=
 =?us-ascii?Q?toB59KpKr0/bY38IfgcA0BYHpg7c4sYqqIGRil6D8j8VuGacf/I4mfqoJviO?=
 =?us-ascii?Q?LFXE5Bbj8x+CeDtyg3lDBfo44f4v+MBSho4AHfrjNV/WhbaRsj7PuiKF6yvz?=
 =?us-ascii?Q?99iDwTx2U3zsRn9GX+MGXhwIBR8o2fsi1D8uTywpVwwrYUazo9h2GlHYifPc?=
 =?us-ascii?Q?4vY+uKltJCh+iinoWCdoiI/Japw9IOaMif+Zu2HlQAPGrOTU/npuyZyD384S?=
 =?us-ascii?Q?Of8rsg4V0d/bLlCjB2HCIn4UrGIL7+Htn4nbMSziLErvOKRa7lI9jxaevwNe?=
 =?us-ascii?Q?0wEUCEf2hMwBqlD2rOL0pIFjg4SIJMhA9AmAZECP4ISKw3BTrDoe/Z4/uBix?=
 =?us-ascii?Q?dEbSTANVC4YLEwdVzK1hV2X8FGbdzogT/bSmDRhp4+PHmjplIDw8bxKMuKWA?=
 =?us-ascii?Q?zQgQqSh6u7w6wShEJircJqC8vuM7XveKFpKPfFeatdQeccWUEtCEbDC/TZbv?=
 =?us-ascii?Q?5WbsTCRa5+zjjthHguWUHppLhYQIuuDnBaWnnyplK/je4/1ri9KRBkiHjcO3?=
 =?us-ascii?Q?8xUlwWsgeEjjVWyjO19dsjY04jazmgU6txBZvCAleS5fTVti420EVWcqIsFp?=
 =?us-ascii?Q?YI9ObYNIERwHy6tcYQR7ygztwUxqDersJJB2NPTzcPYwYYTl139/6+KUwWO6?=
 =?us-ascii?Q?92SbZ2a87RLNsyWfxJiZIw+ORIM0k0+7RUbzeqfSvscubIsO2PWk7l97K3N8?=
 =?us-ascii?Q?nm/8P+A97cT1JG2LIFM1lSTLyaPdbpin0xlqaMqauIZZXYYStT8RZJ+7ygd0?=
 =?us-ascii?Q?JISgfIBnMygglbCXd4picchKUwlrG6fYH8T3N2d+4PUQVg=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6263.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6551
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:290::9];domain=AS8PR08MB6263.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	132e0104-8de0-4b94-6cad-08dcc7868fbb
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SC/4wcgxOoGxNT1lxrJ6+XXT1uuBtPcC1wgkH6/bCsCEcxf5vmg/rzeGHCkO?=
 =?us-ascii?Q?slXF/ZGVSyYOeFT1WtN0hnKO2XiDglYIiRUycq5P8tNgAgJ2MgCyETXOI9Jf?=
 =?us-ascii?Q?ny7wFwB0SDycIpTOEnjWX757WG2WD61q8KXqUfZXfePFiO+9uSpkwd7OWENf?=
 =?us-ascii?Q?ktMwSzhkfffduo4a79gPFxEnBNiFZjOEEv9FoDh65OX9LjTD6psoyTRwV+8G?=
 =?us-ascii?Q?suT1pn/zP9a6EYXEmRFLhjyjgTIGGXnmj5CjrP7j1j9+DI6c5SRKlLrH7p1j?=
 =?us-ascii?Q?V01GAy88d4TIqTNl6Z63JbKXkHn0xkcDIqw5pkC3pffDzD5F5HXbS/GVd4Iy?=
 =?us-ascii?Q?BKWbzgyt9plZlrn8wY9MVOB3k5H5RreVi6LX768KhLwgR5As0utsmfcOKKtA?=
 =?us-ascii?Q?2nxEL9+j0e/qhzKmf4rTukGZeHAyeKdo48ADgwALY0mBh+9fl+DgcXD35bm6?=
 =?us-ascii?Q?dEwLn22ODd8CGPoqIkv23qs+FS1sIK4Nk82nUIzxh/b40ffhjdceVVtWMMnR?=
 =?us-ascii?Q?Qr8SHokDkjc5u7bvdm1Ty3XmesVSztNWfrH6UZaO+fRn/IN/rGHe9QRX3V0g?=
 =?us-ascii?Q?FsgdaydgzHukFuox6FC1BPy5piW7A8C7jOX8O/Rp02S0/7zO9LNoCPXzFEzt?=
 =?us-ascii?Q?0Z5UehqSsu1VHXI0fNntIR8+qhhower8fWP97GZMsL/ogsVOD9r4mhaRSjH1?=
 =?us-ascii?Q?0FwXM/gSt4rYXro2mgEefp/xAR9Xwlwl6JiJHYOIRvvNtsYjS3SQYfuIp8eT?=
 =?us-ascii?Q?9+nX6m4REQsctYuq9j3ygB4CXRRIqFllN0I9t0+HprG4O2W4TpztrpyRu4D9?=
 =?us-ascii?Q?euczzIlFLqFmhg5m8EoLQkJ7nAvE/TrfG0snFoHeQBs1SdAnuMwqw3En+led?=
 =?us-ascii?Q?lG6cMh7T/ZkG1iJ5WaEbe7KYNllcua04pBH4EJR2TtUIz4T59hh3PaljVn84?=
 =?us-ascii?Q?Wj2n5C7HzXLvJc1NzUlwilsu6NEq8UdbPcswYL2Tk1klwR6+3uCM9es+aUdb?=
 =?us-ascii?Q?20U5JhnIP5Zu/FAjywTxKNs2R0v2ZNdHjutuRoPDAv7jUlwf48jgXKu8VPNG?=
 =?us-ascii?Q?iUovbTIdrInAXvpAu/xN12N88dsmjfePIgyWJPXjvzdzxu4BTTkTRHhOq6i3?=
 =?us-ascii?Q?OMZh2jL/cQLG6IBoDz7nd8a3pK5upr7FFV99LiUkb8Nj3WhJlzYdHsQ3mQmy?=
 =?us-ascii?Q?t6g+GHeY9SM2p4C5KbcoWbr37STWSGGjN27AqNANPc7kqU8VFbTOOh6gwKaH?=
 =?us-ascii?Q?opO4nIn5Ky88WaJMk/UA26RZUU7BAYUf5QXle8MdPwmoxBFMz2DCvJryTX6d?=
 =?us-ascii?Q?GE0ujxaRx+QSU5H2ri/BDytlg1c4h177HjPWG+JsHooTEB1tnjCGX3WdP3rw?=
 =?us-ascii?Q?mnPiIvaDGHmzxFIl+2C5ohnLKstoqwB3K/SLAJiTaaAvH0BNSenxe81OnZuZ?=
 =?us-ascii?Q?ulWWRCnU5g0zj66OvgOAxOGBL4r3mFTq?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 17:26:47.4634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1a7a69-95f7-41bc-43e6-08dcc7869856
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5715

From: Ketil Johnsen <ketil.johnsen@arm.com>

Dinging the doorbell directly from userspace allows the user driver to
bypass the kernel if the group is already assigned and active.

Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/panthor/panthor_device.c | 66 ++++++++++++++++++------
 drivers/gpu/drm/panthor/panthor_device.h |  7 ++-
 drivers/gpu/drm/panthor/panthor_drv.c    |  3 +-
 drivers/gpu/drm/panthor/panthor_fw.c     |  2 +-
 drivers/gpu/drm/panthor/panthor_sched.c  | 46 ++++++++++++++++-
 drivers/gpu/drm/panthor/panthor_sched.h  |  2 +
 6 files changed, 104 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 4082c8f2951d..3c376e21bd2e 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -179,6 +179,14 @@ int panthor_device_init(struct panthor_device *ptdev)
 	if (ret)
 		return ret;
 
+	ptdev->dummy_doorbell_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (!ptdev->dummy_doorbell_page)
+		return -ENOMEM;
+
+	ret = drmm_add_action_or_reset(&ptdev->base, panthor_device_free_page,
+				       page_address(ptdev->dummy_doorbell_page));
+	if (ret)
+		return ret;
 	/*
 	 * Set the dummy page holding the latest flush to 1. This will cause the
 	 * flush to avoided as we know it isn't necessary if the submission
@@ -343,41 +351,58 @@ const char *panthor_exception_name(struct panthor_device *ptdev, u32 exception_c
 static vm_fault_t panthor_mmio_vm_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	struct panthor_device *ptdev = vma->vm_private_data;
+	struct panthor_file *pfile = vma->vm_private_data;
+	struct panthor_device *ptdev = pfile->ptdev;
 	u64 offset = (u64)vma->vm_pgoff << PAGE_SHIFT;
 	unsigned long pfn;
 	pgprot_t pgprot;
 	vm_fault_t ret;
 	bool active;
 	int cookie;
+	u32 group_handle;
+	u8 doorbell_id;
 
 	if (!drm_dev_enter(&ptdev->base, &cookie))
 		return VM_FAULT_SIGBUS;
 
-	mutex_lock(&ptdev->pm.mmio_lock);
-	active = atomic_read(&ptdev->pm.state) == PANTHOR_DEVICE_PM_STATE_ACTIVE;
-
 	switch (offset) {
 	case DRM_PANTHOR_USER_FLUSH_ID_MMIO_OFFSET:
-		if (active)
+		mutex_lock(&ptdev->pm.mmio_lock);
+
+		pgprot = vma->vm_page_prot;
+
+		active = atomic_read(&ptdev->pm.state) == PANTHOR_DEVICE_PM_STATE_ACTIVE;
+		if (active) {
 			pfn = __phys_to_pfn(ptdev->phys_addr + CSF_GPU_LATEST_FLUSH_ID);
-		else
+			pgprot = pgprot_noncached(pgprot);
+		} else {
 			pfn = page_to_pfn(ptdev->pm.dummy_latest_flush);
+		}
+
+		ret = vmf_insert_pfn_prot(vma, vmf->address, pfn, pgprot);
+
+		mutex_unlock(&ptdev->pm.mmio_lock);
+
+		break;
+
+	case PANTHOR_DOORBELL_OFFSET_START ... (PANTHOR_DOORBELL_OFFSET_END - 1):
+		group_handle = PANTHOR_DOORBELL_GROUP_FROM_OFFSET(offset) + 1;
+
+		doorbell_id = panthor_sched_doorbell_id(pfile, group_handle);
+		if (doorbell_id != (u8)-1)
+			pfn = PHYS_PFN(ptdev->phys_addr + CSF_DOORBELL(doorbell_id));
+		else
+			pfn = page_to_pfn(ptdev->dummy_doorbell_page);
+
+		ret = vmf_insert_pfn_prot(vma, vmf->address, pfn,
+					  pgprot_device(vma->vm_page_prot));
+
 		break;
 
 	default:
 		ret = VM_FAULT_SIGBUS;
-		goto out_unlock;
 	}
 
-	pgprot = vma->vm_page_prot;
-	if (active)
-		pgprot = pgprot_noncached(pgprot);
-
-	ret = vmf_insert_pfn_prot(vma, vmf->address, pfn, pgprot);
-
-out_unlock:
-	mutex_unlock(&ptdev->pm.mmio_lock);
 	drm_dev_exit(cookie);
 	return ret;
 }
@@ -386,7 +411,7 @@ static const struct vm_operations_struct panthor_mmio_vm_ops = {
 	.fault = panthor_mmio_vm_fault,
 };
 
-int panthor_device_mmap_io(struct panthor_device *ptdev, struct vm_area_struct *vma)
+int panthor_device_mmap_io(struct panthor_file *pfile, struct vm_area_struct *vma)
 {
 	u64 offset = (u64)vma->vm_pgoff << PAGE_SHIFT;
 
@@ -398,12 +423,19 @@ int panthor_device_mmap_io(struct panthor_device *ptdev, struct vm_area_struct *
 
 		break;
 
+	case PANTHOR_DOORBELL_OFFSET_START ... (PANTHOR_DOORBELL_OFFSET_END - 1):
+		if (vma->vm_end - vma->vm_start != PAGE_SIZE ||
+		    (vma->vm_flags & (VM_READ | VM_EXEC)))
+			return -EINVAL;
+
+		break;
+
 	default:
 		return -EINVAL;
 	}
 
 	/* Defer actual mapping to the fault handler. */
-	vma->vm_private_data = ptdev;
+	vma->vm_private_data = pfile;
 	vma->vm_ops = &panthor_mmio_vm_ops;
 	vm_flags_set(vma,
 		     VM_IO | VM_DONTCOPY | VM_DONTEXPAND |
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 7c27dbba8270..87cce384e36a 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -162,6 +162,9 @@ struct panthor_device {
 		 */
 		struct page *dummy_latest_flush;
 	} pm;
+
+	/** @dummy_doorbell_page: dummy doorbell page when queue is not on HW */
+	struct page *dummy_doorbell_page;
 };
 
 /**
@@ -204,7 +207,7 @@ static inline bool panthor_device_reset_is_pending(struct panthor_device *ptdev)
 	return atomic_read(&ptdev->reset.pending) != 0;
 }
 
-int panthor_device_mmap_io(struct panthor_device *ptdev,
+int panthor_device_mmap_io(struct panthor_file *pfile,
 			   struct vm_area_struct *vma);
 
 int panthor_device_resume(struct device *dev);
@@ -376,6 +379,8 @@ static int panthor_request_ ## __name ## _irq(struct panthor_device *ptdev,			\
 					((group) << DRM_PANTHOR_MAX_PAGE_SHIFT))
 #define PANTHOR_DOORBELL_OFFSET_START PANTHOR_DOORBELL_OFFSET(0)
 #define PANTHOR_DOORBELL_OFFSET_END PANTHOR_DOORBELL_OFFSET(MAX_GROUPS_PER_POOL)
+#define PANTHOR_DOORBELL_GROUP_FROM_OFFSET(offset) \
+	((offset - PANTHOR_PRIVATE_MMIO_OFFSET) >> DRM_PANTHOR_MAX_PAGE_SHIFT)
 
 extern struct workqueue_struct *panthor_cleanup_wq;
 
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 0bd600c464b8..e391ab6aaab2 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1381,7 +1381,6 @@ static int panthor_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	struct drm_file *file = filp->private_data;
 	struct panthor_file *pfile = file->driver_priv;
-	struct panthor_device *ptdev = pfile->ptdev;
 	u64 offset = (u64)vma->vm_pgoff << PAGE_SHIFT;
 	int ret, cookie;
 
@@ -1404,7 +1403,7 @@ static int panthor_mmap(struct file *filp, struct vm_area_struct *vma)
 #endif
 
 	if (offset >= DRM_PANTHOR_USER_MMIO_OFFSET)
-		ret = panthor_device_mmap_io(ptdev, vma);
+		ret = panthor_device_mmap_io(pfile, vma);
 	else
 		ret = drm_gem_mmap(filp, vma);
 
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index ef232c0c2049..ce51f75a419b 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -444,7 +444,7 @@ panthor_fw_alloc_queue_iface_mem(struct panthor_device *ptdev,
 	int ret;
 
 	mem = panthor_kernel_bo_create(ptdev, ptdev->fw->vm, SZ_8K,
-				       DRM_PANTHOR_BO_NO_MMAP,
+				       0,
 				       DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC |
 				       DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED,
 				       PANTHOR_VM_KERNEL_AUTO_VA);
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index ad160a821957..471bb8f2b44c 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -954,6 +954,10 @@ group_bind_locked(struct panthor_group *group, u32 csg_id)
 	for (u32 i = 0; i < group->queue_count; i++)
 		group->queues[i]->doorbell_id = csg_id + 1;
 
+	/* Unmap the dummy doorbell page (if mapped) */
+	unmap_mapping_range(ptdev->base.anon_inode->i_mapping,
+			    PANTHOR_DOORBELL_OFFSET(group->handle - 1), 0, 1);
+
 	csg_slot->group = group;
 
 	return 0;
@@ -990,6 +994,10 @@ group_unbind_locked(struct panthor_group *group)
 	for (u32 i = 0; i < group->queue_count; i++)
 		group->queues[i]->doorbell_id = -1;
 
+	/* Unmap the dummy doorbell page (if mapped) */
+	unmap_mapping_range(ptdev->base.anon_inode->i_mapping,
+			    PANTHOR_DOORBELL_OFFSET(group->handle - 1), 0, 1);
+
 	slot->group = NULL;
 
 	group_put(group);
@@ -1726,6 +1734,41 @@ void panthor_sched_report_fw_events(struct panthor_device *ptdev, u32 events)
 	sched_queue_work(ptdev->scheduler, fw_events);
 }
 
+/**
+ * panthor_sched_doorbell_id() - Get the doorbell ID for a given group.
+ * @pfile: Panthor file.
+ * @group_handle: group slot id
+ *
+ * Return: a doorbell ID if valid, -1 otherwise
+ */
+u8 panthor_sched_doorbell_id(struct panthor_file *pfile, u32 group_handle)
+{
+	struct panthor_group_pool *gpool = pfile->groups;
+	struct panthor_scheduler *sched = pfile->ptdev->scheduler;
+	u8 doorbell_id;
+	struct panthor_group *group;
+
+	group = group_get(xa_load(&gpool->xa, group_handle));
+	if (!group)
+		return -1;
+
+	if (!group->queue_count) {
+		doorbell_id = -1;
+		goto err_put_group;
+	}
+
+	mutex_lock(&sched->lock);
+
+	/* In current implementation, all queues of same group share same doorbell page. */
+	doorbell_id = group->queues[0]->doorbell_id;
+
+	mutex_unlock(&sched->lock);
+
+err_put_group:
+	group_put(group);
+	return doorbell_id;
+}
+
 static const char *fence_get_driver_name(struct dma_fence *fence)
 {
 	return "panthor";
@@ -3057,6 +3100,7 @@ group_create_queue(struct panthor_group *group,
 	if (!queue)
 		return ERR_PTR(-ENOMEM);
 
+	queue->doorbell_id = -1;
 	queue->fence_ctx.id = dma_fence_context_alloc(1);
 	spin_lock_init(&queue->fence_ctx.lock);
 	INIT_LIST_HEAD(&queue->fence_ctx.in_flight_jobs);
@@ -3065,7 +3109,7 @@ group_create_queue(struct panthor_group *group,
 
 	queue->ringbuf = panthor_kernel_bo_create(group->ptdev, group->vm,
 						  args->ringbuf_size,
-						  DRM_PANTHOR_BO_NO_MMAP,
+						  0,
 						  DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC |
 						  DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED,
 						  PANTHOR_VM_KERNEL_AUTO_VA);
diff --git a/drivers/gpu/drm/panthor/panthor_sched.h b/drivers/gpu/drm/panthor/panthor_sched.h
index 55b6534fa390..0b3a2ee2a0ad 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.h
+++ b/drivers/gpu/drm/panthor/panthor_sched.h
@@ -47,4 +47,6 @@ void panthor_sched_resume(struct panthor_device *ptdev);
 void panthor_sched_report_mmu_fault(struct panthor_device *ptdev);
 void panthor_sched_report_fw_events(struct panthor_device *ptdev, u32 events);
 
+u8 panthor_sched_doorbell_id(struct panthor_file *pfile, u32 group_handle);
+
 #endif
-- 
2.45.0


