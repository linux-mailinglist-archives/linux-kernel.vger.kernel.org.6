Return-Path: <linux-kernel+bounces-442569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A149EDE6D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 05:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 445B0281B51
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 04:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C3D158DB1;
	Thu, 12 Dec 2024 04:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="RoXvgibO"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2087.outbound.protection.outlook.com [40.107.104.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434FC1E4A9;
	Thu, 12 Dec 2024 04:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733977480; cv=fail; b=PSZcRxwaqCOfSBnw8V4Wu5z8PrX/4ZLDXzrwjhpZP7RU4URi5oEaES6jPI4FfiO43PH248PcsnROyi2XhKmS6bG4noQitPQwnjImTM9Ftk1dvGqYB3isJ/3xOBy5PxurGKBEop17tERYF+kJ29BjgvXiTC4AkFn98zfgmlyZZ38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733977480; c=relaxed/simple;
	bh=IygbuR9uJ2IGdvkFsslDaDsrTOWnOgCIEBO/U0WhDGQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YUGaz2q/nF4UVqP79nX1FDXb/o3Y4eIu56aOcrwVnyKg6P48QLSqw30On4BZq3wqr3aKRXrpNx7Jl2FxMI99Vj189Pz+XC9XJXPGECGIYyNyJUWYfTFoFLGA/T12IoMX6hDXR36OToxkxD9T3okC+23EGUQgZ0bQRJMtWVjEulA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=RoXvgibO; arc=fail smtp.client-ip=40.107.104.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtMyUICZ7VAhOKGwD3rxVIwm6B9t5a8JJo97FdPqmh2H+r0K/P8DKogYtY6NMhaI+xUqPtQLFZ/JHnioFZPyl/jEcq7T0LfwbCTcaWZ65C8dxzanhoG9RWUPyky2JZfopnUQAGy9WKlFQaOnbxA/PBABE2KiToaZ2dccDxzGHYCM0TUWIXTUeve4Echntu8objMpUqk60GFF+fyjfks4FsnPcTB53Teit2Ok+gWbQ7v518uuS47Cv5AAiLg8Ot59wze+dynciiQNYoC+6tKgu36xWM4cMXMIb9517oY6dI9KE/gcZ+gAE8cQX6ItpuVU+vIcAHiNerLt25YukY0CaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VAmhSgqunW5Dk56LgrirAfk0V6c+pV/0zGFxP3gTOA=;
 b=IAhqwF9o8GSPhZuKRYUcs2FvdCnx6xuJn+8ol4OzCDI7mZjNpG9TUiJmOycE2QxvtErjhuuVrlXS/hY+swyCP+pTZpoU2ojdUszn73wWChV0djJWmKuqnHzKLtKe32N9u0A4WHhdtSc7wdpc4ZY5mR9SQ6mxpVQKNfNgWmSKlvVW52rghhE5TVoEcHZTsxQqwB3QB0vPJuJxZLkik/MO4md8NrzK32uUoIc0m2BJkfn6MA3uwcE4TIfF/KJNE2txLWMBJggAXclAecWi8GHIB859PDh1BogKUcPEiwu3VvxFD6IvCx7JzZaK0p8TAKn5/2j47ds7nOsZl22HzuQYFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VAmhSgqunW5Dk56LgrirAfk0V6c+pV/0zGFxP3gTOA=;
 b=RoXvgibO05mcfjV2XR9d/1ihj8anWxGF5yxs84qRLFHRmsj7c5l7OJLtMB4t0ggwzElE8jbeKjqrLqNVLWdhU+Ou/eU59T62CZ/3s6KTAUd08g+B9WW3s9SuwMqORJ49tSX0mALJutszwpcG9+u+KMwat8oHrdbJJ7qhvt1pT4k=
Received: from DB3PR08CA0004.eurprd08.prod.outlook.com (2603:10a6:8::17) by
 DB5PR02MB10096.eurprd02.prod.outlook.com (2603:10a6:10:48d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.20; Thu, 12 Dec
 2024 04:24:33 +0000
Received: from DB1PEPF000509F5.eurprd02.prod.outlook.com
 (2603:10a6:8:0:cafe::77) by DB3PR08CA0004.outlook.office365.com
 (2603:10a6:8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Thu,
 12 Dec 2024 04:24:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509F5.mail.protection.outlook.com (10.167.242.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 04:24:33 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 05:24:31 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 12 Dec 2024 05:24:31 +0100
Received: from lnxchenhuiz2.sh.cn.axis.com (lnxchenhuiz2.sh.cn.axis.com [192.168.77.59])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id E2B6D286;
	Thu, 12 Dec 2024 05:24:28 +0100 (CET)
From: Hermes Zhang <Hermes.Zhang@axis.com>
To: <jdelvare@suse.com>, <linux@roeck-us.net>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, Hermes Zhang
	<Hermes.Zhang@axis.com>
CC: <kernel@axis.com>, <linux-hwmon@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: hwmon: Add D3-323-AA
Date: Thu, 12 Dec 2024 12:24:09 +0800
Message-ID: <20241212042412.702044-2-Hermes.Zhang@axis.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212042412.702044-1-Hermes.Zhang@axis.com>
References: <20241212042412.702044-1-Hermes.Zhang@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F5:EE_|DB5PR02MB10096:EE_
X-MS-Office365-Filtering-Correlation-Id: e1219338-95cc-40c5-e3f3-08dd1a64e130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R6w84gMhd1XZqC4P56PVbjUqXwy8Zae1JUv76ps+eETrXuS+OaQ89vvDQ9EL?=
 =?us-ascii?Q?o5WemzF5GK1OMb0UcOd9oLYz99eXWZLdsg/kgGA1Sp4tsgiEIp4T9ennaoIg?=
 =?us-ascii?Q?NkqPx/sfVHgXyf/NFGe7ZZWUH8uUHbjjXhFlZNf57UWpFrquCHv2q119CDnh?=
 =?us-ascii?Q?P1mCOFs05mECdDb4SXdDWDKqtSdBDvUkX1x1C+mXoadS0xRWPjHgZ6llgB9B?=
 =?us-ascii?Q?Zq1foBp090fgJb9BFW3BU9PD3bl3x7TvlQFZ3GqCJ1YnruRrxdkCnzLfONbY?=
 =?us-ascii?Q?1EglnadtyMQBTODesbP1xO8PoJp8D6YrzghZA3jTm+oJyB2ML7ZkdXpz1rR6?=
 =?us-ascii?Q?YVA5DpMS6L4hsrx4gqF/aGGrhgQHeMwsOJXTyms5Yy+jtqyk6s2OHNWHwVqM?=
 =?us-ascii?Q?xPmQgSmS89q/jlBWil71L5z56hBvkAURBOGK3rWwcpCuYyFOVn2me1ha9EXG?=
 =?us-ascii?Q?AXoKkvlP1AnHHsLXX14FhcYfUxoBtB1zfKexrvW6/kRa1i4U8dDp1DEEq+ce?=
 =?us-ascii?Q?rSiUg6hE3135xeIkMFWjMRNymhDhtu68mtN1Vqmcc28nyNPERENbzaVSuP2B?=
 =?us-ascii?Q?YaQEJrJs6mnb9VZ0wU8eRdQS4Eb+IbNsDEjgEGXmGbaDEStjUtJLznhZuU2r?=
 =?us-ascii?Q?XA4ZG1x4HG1sQuNyQQC2hh22sij6eYUGv5vWmlMXPNc7S9h/96y/3YE4FVC9?=
 =?us-ascii?Q?fIn3olzM9s2mcssuINXHYPG9MXFXSW4/lqdkfRk1ZamJ9LVqKNP8ftG1DaG6?=
 =?us-ascii?Q?ImklWTSHzWaYoJq3sTLQUrgwNbAV5295PxdULD8zXxAZeOvCQTCKQU5sVsk7?=
 =?us-ascii?Q?C1mPjkz6Y5lJremQilaCASqFxcxvLYQ1p1IpAM0rCM/xfAbb7ebVDbTgDOXz?=
 =?us-ascii?Q?v2Q7HU0fGbNJMKm9DFMznG8qUlAFQG14sXExnVbAegKhpbcnjGlRZKDlZnsf?=
 =?us-ascii?Q?vhuM0bc6o0TZ3ApSR8bLbxzbzmL92WhJdHad8xAYUJI8vyJk3FJ6IIulnm5h?=
 =?us-ascii?Q?bWDhR179FsALIT7xwy710tEMbNKbdyyzP83SiCtoGWbQkFh1ccvimMDbRZDP?=
 =?us-ascii?Q?ghH5MA/OhcJ4HJ4eaGPFlY2vP6kdZ0y7gTPgZg5MB2uF9i6MkX3UeN9j1aVZ?=
 =?us-ascii?Q?AH/jOvbOrXLHVMnKmsM2F4fBTGUrZ3B251cqwVHhv0ReeRpVCbX1zzzrNNOy?=
 =?us-ascii?Q?OMK0R3vLhvCngTbQj1NUV5FMViTwDcZyx7M1ufSqm4ZdeLAn9oxMhTZWhzvH?=
 =?us-ascii?Q?5PVAl20ZMT5w/hkki/71ppB2JIkt+BC5lkpcXOWLdLIPEUwAgi5tQqeBLLn9?=
 =?us-ascii?Q?Brw+SzoZNopOCeGhoCJOJEc6BeGfCjdm5gVf03ZGtUym0/8EP0ZCmyfnSRZ2?=
 =?us-ascii?Q?y/pZAqpUkpjOss0qBL4aECKbxRY1oKffk/ut4H7Jvpw/Oo6q5g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 04:24:33.2826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1219338-95cc-40c5-e3f3-08dd1a64e130
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR02MB10096

Add Devicetree binding documentation for Nicera D3-323-AA Pyroelectric
IR sensor.

Signed-off-by: Hermes Zhang <Hermes.Zhang@axis.com>
---
 .../bindings/hwmon/nicera,d3-323-aa.yaml      | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/nicera,d3-323-aa.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/nicera,d3-323-aa.yaml b/Documentation/devicetree/bindings/hwmon/nicera,d3-323-aa.yaml
new file mode 100644
index 000000000000..31690e630b5f
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/nicera,d3-323-aa.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/nicera,d3-323-aa.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nicera D3-323-AA Pyroelectric IR sensor
+
+maintainers:
+  - Hermes Zhang <Hermes.Zhang@axis.com>
+
+description: |
+  Nicera D3-323-AA Pyroelectric IR sensor
+
+  datasheet:
+    https://www.nicera.co.jp/wordpress/wp-content/uploads/2022/01/D3-323-AA_e.pdf
+
+properties:
+  compatible:
+    const: nicera,d3-323-aa
+
+  reset-gpios:
+    description: The GPIO pin connected to the reset pin on the sensor
+    maxItems: 1
+
+  clk-gpios:
+    description: The GPIO pin connected to the clk pin on the sensor
+    maxItems: 1
+
+  si-gpios:
+    description: The GPIO pin connected to the si pin on the sensor
+    maxItems: 1
+
+required:
+  - compatible
+  - reset-gpios
+  - clk-gpios
+  - si-gpios
+
+
+additionalProperties: false
+
+examples:
+  - |
+    sensor {
+        compatible = "nicera,d3-323-aa";
+        reset-gpios = <&gpio4 12 0>;
+        clk-gpios = <&gpio4 13 0>;
+        si-gpios = <&gpio4 14 0>;
+    };
-- 
2.45.2


