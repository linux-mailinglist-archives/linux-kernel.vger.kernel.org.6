Return-Path: <linux-kernel+bounces-545212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DD9A4EA57
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0DB16F050
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07F527934F;
	Tue,  4 Mar 2025 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CmhHd50D"
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244BA2780FF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.115
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109837; cv=fail; b=nFq6OmDYYbatjEhvfGasdQiaBIvz7Fa9k2Lv1DmS9R0Y7j4dzcc5x4WqetppL3tCfO2Y1COkIQSZ8JnVeUnSBGcXOo3O4AnKr8XX4sdypfodXHYR2jKEWzOwVyZBTx2VK84DgUnrSlRVrVcccFIc1svFemPzptg93dn9CwPYJXs=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109837; c=relaxed/simple;
	bh=6BRQVzOfX88GP7SvSBUjTeJkGHBY7MBwM2jybOVqKVE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ktwLlH/EN4CJyzZrSfEqkSP3Y2f0QfiEliH3jfnIgbnZ34yxCAnbCSztlCjjd1lPOpGwGqVoir3WXSik1mc1vbTuZhWqvBZYSm57gWzbLQqnsrWcXky+pDCoCJ45Dryx/uEIAC4QDeDzyOk2C9Z2imoQt9NTAso51i8a21Qdezk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CmhHd50D reason="signature verification failed"; arc=fail smtp.client-ip=40.107.94.55; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; arc=fail smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 9B176408B643
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:37:13 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CmhHd50D
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dfB3B0wzFxKr
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:41:06 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 9776E4272C; Tue,  4 Mar 2025 17:40:53 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CmhHd50D
X-Envelope-From: <linux-kernel+bounces-541470-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CmhHd50D
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 29288426D5
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:02:41 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id B2D34305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:02:40 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B3AF175E0B
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBC11F4617;
	Mon,  3 Mar 2025 10:59:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9501F417E;
	Mon,  3 Mar 2025 10:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999577; cv=fail; b=mBd6eCxE0wI6LUFB4LN/N/uU5qo7PnprulnOwHwHaIRP41MnpR0swai9iFhIg5gA+9VO6e1jnVAp1vTHiN9Rhyh6U0vlGQ5AlbPM7D+WJfvfU5MGlKQcrgTSqQk8uYHIuoYNTF0NDoEDoI6lXEaNIEYq/+mJMBAG9OAqsv+7ITY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999577; c=relaxed/simple;
	bh=PIKHWevZDSKouLGTCvfGJfjfIZtcySnJLKiJ8HTFqxE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sr/BiHTZ4F9XXmazvDX5NduQ4KjWGMSh5KuggBSC1p7JOsWusUrSuRzRnox0Tcdp+t+SPzcTYgCusT2fkJLec/mGUC2wmiWCQSapzN3bbFV9qjL5J9S30D9zfaf0112uP1XpiE5DJlGpQfm3WaNyIZnL2MYGuva+geYJ+WhvXkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CmhHd50D; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDOGzgZhZZhf+AG7PVJgWnXmDCZghjefJkf9+vCOwBVq/PKfGwhdVbwd7WnVZlc5yGzRcjPT7p+AliE7MFJ65zFU0uLfK6sZXN1+My44FCHU4qihlP0nXzk86lv2rtZlWADLn00xdi4xUtvmj0Hlw/lwJ0rA/WLODSDvdvfc/q+chjWLLzQVzGkanYDPIWVTaLgLK2VpNndeJyr82tZHINy6k9Xtv1Lf2HS44jt65OomgsygNIWUGXu3osyvGSlHnXBFm1p86AbAVHLEAo3ZJTXTeJojf3hloIh54A26SJBjSLO4Xd6d0mz2OoyuMo9JW+FP5hnOFnZMlcNnJq5ZTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqTThDyCbhumJVkijYZpjKt0/QLJeLUuLAM7Zyz1BNU=;
 b=mBb6UN5B/+1FRITJ+jVwOcPebFcXBXV+NgtOt7G5U/tC1Hnbk1DRdDMp/7raB/hwSju9rhZNBA+Lm0vsLqrA+ZMHlsZPuycmCA7VDv8eqojxu7GQDxuwt/YRPVbX/5y3U6WxC0EcnbOZ2h6TUP4VH6FkJ5IAr6oxE5L7WYZx/pWZyGY4ZcYZmVMYZ/qN2yX7gas7qsKc4zK4hKIxkbvDw6QfaZt0RoofcxgGyctNBlbQ6+Cn9q3PNr+W3yHwZ4wnps1G9sh7+KQnW95ogbSQB3rPaRlDpf2y6EqEY2xSy2W5b88MJeJSXC9nKM2xAhX2m0YQsRUZTYvNLcrhFzsVpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqTThDyCbhumJVkijYZpjKt0/QLJeLUuLAM7Zyz1BNU=;
 b=CmhHd50D0fxPI53OM6Rg+7vcVtv/DCr8Thwe3HWgRJeJ752ZBEGK+EktExNst6iar2a1sBbYblGUe7Dv3q2w3OcsU+HWRT76CSSMcN5kQpq2/69zLVzcIkdokW3Dj9i/36mElQWSJVsWEx/o7B+0WKZ66LPGt/aazHMoONTfZ5E=
Received: from SA9P223CA0016.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::21)
 by SA3PR12MB9228.namprd12.prod.outlook.com (2603:10b6:806:39c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 10:59:33 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::8) by SA9P223CA0016.outlook.office365.com
 (2603:10b6:806:26::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Mon,
 3 Mar 2025 10:59:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 10:59:33 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Mar
 2025 04:59:29 -0600
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<shyam-sundar.s-k@amd.com>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <naveenkrishna.chatradhi@amd.com>, Akshay Gupta
	<akshay.gupta@amd.com>
Subject: [PATCH v5 02/11] misc: amd-sbi: Move protocol functionality to core file
Date: Mon, 3 Mar 2025 10:58:53 +0000
Message-ID: <20250303105902.215009-3-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250303105902.215009-1-akshay.gupta@amd.com>
References: <20250303105902.215009-1-akshay.gupta@amd.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|SA3PR12MB9228:EE_
X-MS-Office365-Filtering-Correlation-Id: c50a40ab-966d-47cf-4c2c-08dd5a427add
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?27rrI9+VrPph6swUlH4B6VpGGlPoClBphkfG79gY3/V/38XSyalvZCeJn10d?=
 =?us-ascii?Q?tK77BV8fzCINS1qNRaYMvr1hb5nxZF7QcroVRCYm3bdbg9IzxqDDY9g9Crup?=
 =?us-ascii?Q?7CmnNzFltWaubOFFRZD33Rw4lClZ005ci0iPaJbIuSVlJ4UKNxMMpeltAp+P?=
 =?us-ascii?Q?GD/6AabKWlBnJjs8cUYIM7YQhj0YkPigI8SfjgfLG7OqLxWtzYEp0uXRb1+M?=
 =?us-ascii?Q?CwN5m1xnyqQi2m3nbCtpDt3QZAybzzuwyPguxZ3tfVcJwMH4Kzfd1+jNGagT?=
 =?us-ascii?Q?VBKHqZPXpNX4UnZfpn7+pPlMCArHZLn61KpGbBaN+vCYcdiPN63kXNpx/ibx?=
 =?us-ascii?Q?ChrVKiZBpTRLUtudzGujjWUDKuxW+jbFdZbZ6e3q7J2mffW8KMx1utCSEnQO?=
 =?us-ascii?Q?RAhBpYGcmZm6YawX+U9VldypwctlV48utVJ4WfsqPjWmdXxTlqU6eDVaGQbc?=
 =?us-ascii?Q?+cKjgQ6iV8CdUIszoC7t2PIWgTfZ6kw26dlZNIcNHbeNMgw7xPO1A/uHaudo?=
 =?us-ascii?Q?E8klNt0lUZsNgAaftqjtg4pWh19MMgFnLJDv20+iVmZ8l9KeUi/TLFuMyYJj?=
 =?us-ascii?Q?kowgb3oTJhKJnb59lSwReRm1+eMXfVj1nFi/+pNI7S7lQ/udbFzLYrYMZImH?=
 =?us-ascii?Q?Dhutoxx+ISSyUtGA2Mnl1kG9gPsBpruNQAiKC6Qho84Yq35Tgff55SdlNv19?=
 =?us-ascii?Q?jh6ScApFECXj6R9nZ/ZWKDNkIQqcoJykSYZWHuasXu4uvh6a7acpWIIIg7Jj?=
 =?us-ascii?Q?afYuxAkamanT9punvcQOgEBT2cBJONXM3ETbqcO2g45J5L0tTPl0b2znTeIY?=
 =?us-ascii?Q?CWMgj+kIYS5U/54QCZmdMIKQnsrSHG7hcmJLMQGmWHcIwuNCcos+o0wLDaZw?=
 =?us-ascii?Q?TWZSst2/EVCVxKG6X15Qu1YkqeDoo2HzjxEO9E5/iTZ3yNRXZ1PEpqnG0+mX?=
 =?us-ascii?Q?ZplqaM0u0qoJ/hVqUGRUu4o5M4WGw7BqwV0LNL47BUYehAPg8tGRH9aUCZQg?=
 =?us-ascii?Q?xGpRG9nf5Jsu6+cH7vc5+1hbiIyaf3qwLPxTGozUslvADN97oHJPpH2eu0YP?=
 =?us-ascii?Q?5jbvZSv6eCzy4lGNK+DLn/pTnBBx9UNbUe7oLedEbgkNsX4lpfPE4ucca5KG?=
 =?us-ascii?Q?VyWTmiUymPVzYTcV/JX6BZkNhXbs603FCF0HslB7XeBJOKzTDz/nO9Tz+ReQ?=
 =?us-ascii?Q?qu72igzh2Z10HFGou7T5Rpkr1iTXdV6+5aN6PT8yUA+qY1WnzNzxKhQ2IdcD?=
 =?us-ascii?Q?ifLeOJkDSnnRyM/3Q7GFlRGpTtvq2e/7FAKWKxFQBHcQqay/y5dVHwwyZQsT?=
 =?us-ascii?Q?Ee4FB3Wb9Yqjmk+EJ2ba3GfxaZphItfha8CGfWhlPRfIgCvs+72F2TKAAgXV?=
 =?us-ascii?Q?SRWs9UnQE9Ts1RpsRjA+ssRbLVNr3U4JcSI4sLt97LpkVRyJxuHBH9HTpK+M?=
 =?us-ascii?Q?mVWHlIJS9Z5nehKKfFspvzsIogDKDx9Rgdx6eUw0wfk1QEXicVhbTg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 10:59:33.1361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c50a40ab-966d-47cf-4c2c-08dd5a427add
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9228
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dfB3B0wzFxKr
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741714512.8819@aoSw4h4qknV8ZqekfOHNhg
X-ITU-MailScanner-SpamCheck: not spam

- This is done to utilize the protocol functionality into
  other domains.
- Increase the scalability of the module with different bus(i2c/i3c)

Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
---

Changes since v4:
New patch: Patch split from v4 patch 1/9
- Update Copyright year to 2025

 drivers/misc/amd-sbi/Makefile               |   3 +-
 drivers/misc/amd-sbi/rmi-core.c             | 113 ++++++++++++++
 drivers/misc/amd-sbi/rmi-core.h             |  63 ++++++++
 drivers/misc/amd-sbi/{sbrmi.c =3D> rmi-i2c.c} | 165 ++------------------
 4 files changed, 187 insertions(+), 157 deletions(-)
 create mode 100644 drivers/misc/amd-sbi/rmi-core.c
 create mode 100644 drivers/misc/amd-sbi/rmi-core.h
 rename drivers/misc/amd-sbi/{sbrmi.c =3D> rmi-i2c.c} (53%)

diff --git a/drivers/misc/amd-sbi/Makefile b/drivers/misc/amd-sbi/Makefil=
e
index 304394bf5e59..7cd8e0a1aa5d 100644
--- a/drivers/misc/amd-sbi/Makefile
+++ b/drivers/misc/amd-sbi/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_AMD_SBRMI_I2C)	+=3D sbrmi.o
+sbrmi-i2c-objs  		:=3D rmi-i2c.o rmi-core.o
+obj-$(CONFIG_AMD_SBRMI_I2C)	+=3D sbrmi-i2c.o
diff --git a/drivers/misc/amd-sbi/rmi-core.c b/drivers/misc/amd-sbi/rmi-c=
ore.c
new file mode 100644
index 000000000000..74456756270c
--- /dev/null
+++ b/drivers/misc/amd-sbi/rmi-core.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * sbrmi-core.c - file defining SB-RMI protocols compliant
+ *		  AMD SoC device.
+ *
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ */
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/mutex.h>
+#include "rmi-core.h"
+
+/* Mask for Status Register bit[1] */
+#define SW_ALERT_MASK	0x2
+
+/* Software Interrupt for triggering */
+#define START_CMD	0x80
+#define TRIGGER_MAILBOX	0x01
+
+int rmi_mailbox_xfer(struct sbrmi_data *data,
+		     struct sbrmi_mailbox_msg *msg)
+{
+	int i, ret, retry =3D 10;
+	int sw_status;
+	u8 byte;
+
+	mutex_lock(&data->lock);
+
+	/* Indicate firmware a command is to be serviced */
+	ret =3D i2c_smbus_write_byte_data(data->client,
+					SBRMI_INBNDMSG7, START_CMD);
+	if (ret < 0)
+		goto exit_unlock;
+
+	/* Write the command to SBRMI::InBndMsg_inst0 */
+	ret =3D i2c_smbus_write_byte_data(data->client,
+					SBRMI_INBNDMSG0, msg->cmd);
+	if (ret < 0)
+		goto exit_unlock;
+
+	/*
+	 * For both read and write the initiator (BMC) writes
+	 * Command Data In[31:0] to SBRMI::InBndMsg_inst[4:1]
+	 * SBRMI_x3C(MSB):SBRMI_x39(LSB)
+	 */
+	for (i =3D 0; i < 4; i++) {
+		byte =3D (msg->data_in >> i * 8) & 0xff;
+		ret =3D i2c_smbus_write_byte_data(data->client,
+						SBRMI_INBNDMSG1 + i, byte);
+		if (ret < 0)
+			goto exit_unlock;
+	}
+
+	/*
+	 * Write 0x01 to SBRMI::SoftwareInterrupt to notify firmware to
+	 * perform the requested read or write command
+	 */
+	ret =3D i2c_smbus_write_byte_data(data->client,
+					SBRMI_SW_INTERRUPT, TRIGGER_MAILBOX);
+	if (ret < 0)
+		goto exit_unlock;
+
+	/*
+	 * Firmware will write SBRMI::Status[SwAlertSts]=3D1 to generate
+	 * an ALERT (if enabled) to initiator (BMC) to indicate completion
+	 * of the requested command
+	 */
+	do {
+		sw_status =3D i2c_smbus_read_byte_data(data->client,
+						     SBRMI_STATUS);
+		if (sw_status < 0) {
+			ret =3D sw_status;
+			goto exit_unlock;
+		}
+		if (sw_status & SW_ALERT_MASK)
+			break;
+		usleep_range(50, 100);
+	} while (retry--);
+
+	if (retry < 0) {
+		dev_err(&data->client->dev,
+			"Firmware fail to indicate command completion\n");
+		ret =3D -EIO;
+		goto exit_unlock;
+	}
+
+	/*
+	 * For a read operation, the initiator (BMC) reads the firmware
+	 * response Command Data Out[31:0] from SBRMI::OutBndMsg_inst[4:1]
+	 * {SBRMI_x34(MSB):SBRMI_x31(LSB)}.
+	 */
+	if (msg->read) {
+		for (i =3D 0; i < 4; i++) {
+			ret =3D i2c_smbus_read_byte_data(data->client,
+						       SBRMI_OUTBNDMSG1 + i);
+			if (ret < 0)
+				goto exit_unlock;
+			msg->data_out |=3D ret << i * 8;
+		}
+	}
+
+	/*
+	 * BMC must write 1'b1 to SBRMI::Status[SwAlertSts] to clear the
+	 * ALERT to initiator
+	 */
+	ret =3D i2c_smbus_write_byte_data(data->client, SBRMI_STATUS,
+					sw_status | SW_ALERT_MASK);
+
+exit_unlock:
+	mutex_unlock(&data->lock);
+	return ret;
+}
diff --git a/drivers/misc/amd-sbi/rmi-core.h b/drivers/misc/amd-sbi/rmi-c=
ore.h
new file mode 100644
index 000000000000..8e30a43ec714
--- /dev/null
+++ b/drivers/misc/amd-sbi/rmi-core.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ */
+
+#ifndef _SBRMI_CORE_H_
+#define _SBRMI_CORE_H_
+
+#include <linux/mutex.h>
+#include <linux/i2c.h>
+#include <linux/platform_device.h>
+
+/* SB-RMI registers */
+enum sbrmi_reg {
+	SBRMI_CTRL		=3D 0x01,
+	SBRMI_STATUS,
+	SBRMI_OUTBNDMSG0	=3D 0x30,
+	SBRMI_OUTBNDMSG1,
+	SBRMI_OUTBNDMSG2,
+	SBRMI_OUTBNDMSG3,
+	SBRMI_OUTBNDMSG4,
+	SBRMI_OUTBNDMSG5,
+	SBRMI_OUTBNDMSG6,
+	SBRMI_OUTBNDMSG7,
+	SBRMI_INBNDMSG0,
+	SBRMI_INBNDMSG1,
+	SBRMI_INBNDMSG2,
+	SBRMI_INBNDMSG3,
+	SBRMI_INBNDMSG4,
+	SBRMI_INBNDMSG5,
+	SBRMI_INBNDMSG6,
+	SBRMI_INBNDMSG7,
+	SBRMI_SW_INTERRUPT,
+};
+
+/*
+ * SB-RMI supports soft mailbox service request to MP1 (power management
+ * firmware) through SBRMI inbound/outbound message registers.
+ * SB-RMI message IDs
+ */
+enum sbrmi_msg_id {
+	SBRMI_READ_PKG_PWR_CONSUMPTION =3D 0x1,
+	SBRMI_WRITE_PKG_PWR_LIMIT,
+	SBRMI_READ_PKG_PWR_LIMIT,
+	SBRMI_READ_PKG_MAX_PWR_LIMIT,
+};
+
+/* Each client has this additional data */
+struct sbrmi_data {
+	struct i2c_client *client;
+	struct mutex lock;
+	u32 pwr_limit_max;
+};
+
+struct sbrmi_mailbox_msg {
+	u8 cmd;
+	bool read;
+	u32 data_in;
+	u32 data_out;
+};
+
+int rmi_mailbox_xfer(struct sbrmi_data *data, struct sbrmi_mailbox_msg *=
msg);
+#endif /*_SBRMI_CORE_H_*/
diff --git a/drivers/misc/amd-sbi/sbrmi.c b/drivers/misc/amd-sbi/rmi-i2c.=
c
similarity index 53%
rename from drivers/misc/amd-sbi/sbrmi.c
rename to drivers/misc/amd-sbi/rmi-i2c.c
index d48d8e5460ff..914338a24246 100644
--- a/drivers/misc/amd-sbi/sbrmi.c
+++ b/drivers/misc/amd-sbi/rmi-i2c.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * sbrmi.c - hwmon driver for a SB-RMI mailbox
- *           compliant AMD SoC device.
+ * rmi-i2c.c - Side band RMI over I2C support for AMD out
+ *             of band management
  *
- * Copyright (C) 2020-2021 Advanced Micro Devices, Inc.
+ * Copyright (C) 2024 Advanced Micro Devices, Inc.
  */
=20
 #include <linux/delay.h>
@@ -14,64 +14,10 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include "rmi-core.h"
=20
 /* Do not allow setting negative power limit */
 #define SBRMI_PWR_MIN	0
-/* Mask for Status Register bit[1] */
-#define SW_ALERT_MASK	0x2
-
-/* Software Interrupt for triggering */
-#define START_CMD	0x80
-#define TRIGGER_MAILBOX	0x01
-
-/*
- * SB-RMI supports soft mailbox service request to MP1 (power management
- * firmware) through SBRMI inbound/outbound message registers.
- * SB-RMI message IDs
- */
-enum sbrmi_msg_id {
-	SBRMI_READ_PKG_PWR_CONSUMPTION =3D 0x1,
-	SBRMI_WRITE_PKG_PWR_LIMIT,
-	SBRMI_READ_PKG_PWR_LIMIT,
-	SBRMI_READ_PKG_MAX_PWR_LIMIT,
-};
-
-/* SB-RMI registers */
-enum sbrmi_reg {
-	SBRMI_CTRL		=3D 0x01,
-	SBRMI_STATUS,
-	SBRMI_OUTBNDMSG0	=3D 0x30,
-	SBRMI_OUTBNDMSG1,
-	SBRMI_OUTBNDMSG2,
-	SBRMI_OUTBNDMSG3,
-	SBRMI_OUTBNDMSG4,
-	SBRMI_OUTBNDMSG5,
-	SBRMI_OUTBNDMSG6,
-	SBRMI_OUTBNDMSG7,
-	SBRMI_INBNDMSG0,
-	SBRMI_INBNDMSG1,
-	SBRMI_INBNDMSG2,
-	SBRMI_INBNDMSG3,
-	SBRMI_INBNDMSG4,
-	SBRMI_INBNDMSG5,
-	SBRMI_INBNDMSG6,
-	SBRMI_INBNDMSG7,
-	SBRMI_SW_INTERRUPT,
-};
-
-/* Each client has this additional data */
-struct sbrmi_data {
-	struct i2c_client *client;
-	struct mutex lock;
-	u32 pwr_limit_max;
-};
-
-struct sbrmi_mailbox_msg {
-	u8 cmd;
-	bool read;
-	u32 data_in;
-	u32 data_out;
-};
=20
 static int sbrmi_enable_alert(struct i2c_client *client)
 {
@@ -94,100 +40,6 @@ static int sbrmi_enable_alert(struct i2c_client *clie=
nt)
 	return 0;
 }
=20
-static int rmi_mailbox_xfer(struct sbrmi_data *data,
-			    struct sbrmi_mailbox_msg *msg)
-{
-	int i, ret, retry =3D 10;
-	int sw_status;
-	u8 byte;
-
-	mutex_lock(&data->lock);
-
-	/* Indicate firmware a command is to be serviced */
-	ret =3D i2c_smbus_write_byte_data(data->client,
-					SBRMI_INBNDMSG7, START_CMD);
-	if (ret < 0)
-		goto exit_unlock;
-
-	/* Write the command to SBRMI::InBndMsg_inst0 */
-	ret =3D i2c_smbus_write_byte_data(data->client,
-					SBRMI_INBNDMSG0, msg->cmd);
-	if (ret < 0)
-		goto exit_unlock;
-
-	/*
-	 * For both read and write the initiator (BMC) writes
-	 * Command Data In[31:0] to SBRMI::InBndMsg_inst[4:1]
-	 * SBRMI_x3C(MSB):SBRMI_x39(LSB)
-	 */
-	for (i =3D 0; i < 4; i++) {
-		byte =3D (msg->data_in >> i * 8) & 0xff;
-		ret =3D i2c_smbus_write_byte_data(data->client,
-						SBRMI_INBNDMSG1 + i, byte);
-		if (ret < 0)
-			goto exit_unlock;
-	}
-
-	/*
-	 * Write 0x01 to SBRMI::SoftwareInterrupt to notify firmware to
-	 * perform the requested read or write command
-	 */
-	ret =3D i2c_smbus_write_byte_data(data->client,
-					SBRMI_SW_INTERRUPT, TRIGGER_MAILBOX);
-	if (ret < 0)
-		goto exit_unlock;
-
-	/*
-	 * Firmware will write SBRMI::Status[SwAlertSts]=3D1 to generate
-	 * an ALERT (if enabled) to initiator (BMC) to indicate completion
-	 * of the requested command
-	 */
-	do {
-		sw_status =3D i2c_smbus_read_byte_data(data->client,
-						     SBRMI_STATUS);
-		if (sw_status < 0) {
-			ret =3D sw_status;
-			goto exit_unlock;
-		}
-		if (sw_status & SW_ALERT_MASK)
-			break;
-		usleep_range(50, 100);
-	} while (retry--);
-
-	if (retry < 0) {
-		dev_err(&data->client->dev,
-			"Firmware fail to indicate command completion\n");
-		ret =3D -EIO;
-		goto exit_unlock;
-	}
-
-	/*
-	 * For a read operation, the initiator (BMC) reads the firmware
-	 * response Command Data Out[31:0] from SBRMI::OutBndMsg_inst[4:1]
-	 * {SBRMI_x34(MSB):SBRMI_x31(LSB)}.
-	 */
-	if (msg->read) {
-		for (i =3D 0; i < 4; i++) {
-			ret =3D i2c_smbus_read_byte_data(data->client,
-						       SBRMI_OUTBNDMSG1 + i);
-			if (ret < 0)
-				goto exit_unlock;
-			msg->data_out |=3D ret << i * 8;
-		}
-	}
-
-	/*
-	 * BMC must write 1'b1 to SBRMI::Status[SwAlertSts] to clear the
-	 * ALERT to initiator
-	 */
-	ret =3D i2c_smbus_write_byte_data(data->client, SBRMI_STATUS,
-					sw_status | SW_ALERT_MASK);
-
-exit_unlock:
-	mutex_unlock(&data->lock);
-	return ret;
-}
-
 static int sbrmi_read(struct device *dev, enum hwmon_sensor_types type,
 		      u32 attr, int channel, long *val)
 {
@@ -297,7 +149,7 @@ static int sbrmi_get_max_pwr_limit(struct sbrmi_data =
*data)
 	return ret;
 }
=20
-static int sbrmi_probe(struct i2c_client *client)
+static int sbrmi_i2c_probe(struct i2c_client *client)
 {
 	struct device *dev =3D &client->dev;
 	struct device *hwmon_dev;
@@ -328,7 +180,7 @@ static int sbrmi_probe(struct i2c_client *client)
 }
=20
 static const struct i2c_device_id sbrmi_id[] =3D {
-	{"sbrmi"},
+	{"sbrmi-i2c"},
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, sbrmi_id);
@@ -343,15 +195,16 @@ MODULE_DEVICE_TABLE(of, sbrmi_of_match);
=20
 static struct i2c_driver sbrmi_driver =3D {
 	.driver =3D {
-		.name =3D "sbrmi",
+		.name =3D "sbrmi-i2c",
 		.of_match_table =3D of_match_ptr(sbrmi_of_match),
 	},
-	.probe =3D sbrmi_probe,
+	.probe =3D sbrmi_i2c_probe,
 	.id_table =3D sbrmi_id,
 };
=20
 module_i2c_driver(sbrmi_driver);
=20
 MODULE_AUTHOR("Akshay Gupta <akshay.gupta@amd.com>");
+MODULE_AUTHOR("Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com=
>");
 MODULE_DESCRIPTION("Hwmon driver for AMD SB-RMI emulated sensor");
 MODULE_LICENSE("GPL");
--=20
2.25.1



