Return-Path: <linux-kernel+bounces-544430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0741A4E10F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9942617CA48
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C233520E01A;
	Tue,  4 Mar 2025 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KxdVfa/0"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8428520AF67
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098609; cv=fail; b=jQR1MRgJHiMu5Y3a385zhfMbmlLYsDhUHDRkgDg2aicPE5B+bgi5TbI6VskyH7S/BSnw0H9zJTjunOEOFhPXp49OXADRYsAuvM57m7bBJAyzyWmnEgyz08wFDnDHruToWLE5c0pnDV65wxvWb9mJTb/1JqPuhUGEuROfwTohuxk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098609; c=relaxed/simple;
	bh=0odlpRR3LDKZlOkRE95XD7n1o9Drb0rA1N/W3Ym6+RA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZwqOi8g2HPQgfzveg6eKcOfZKhF9CBfWkR1Jh2tT4gr6e/1Pm+a6XnY5CAl+uK7MB5R2yNeSL0s+8XZYT9O01UyLH92DoRybWUB72SPX28aNH2Bp/n9AST50Fo/wK9lV+ITaNLzNEWAgmA04G2Z+6HfMJY3Uv5Y6n3uka918TI0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KxdVfa/0 reason="signature verification failed"; arc=fail smtp.client-ip=40.107.100.69; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id A716C40CEC82
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:30:06 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KxdVfa/0
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dMx2SkRzFwQ7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:28:45 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 8E120400C6; Tue,  4 Mar 2025 17:28:30 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KxdVfa/0
X-Envelope-From: <linux-kernel+bounces-541479-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KxdVfa/0
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 1575642A88
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:04:57 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id A41AD305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:04:56 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18A67174EDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C151F7069;
	Mon,  3 Mar 2025 11:00:18 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BB21E991A;
	Mon,  3 Mar 2025 11:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999613; cv=fail; b=sVrovgBKBtJpaXcyabPzF+UnWmrI1E/1xCUXJqo8bsaNmBmIBWHdbd7kipgisaa7RVRaxxomMU+3aEBZLRgt9CI39j4srFKNIqMgcO25ETVOdmm4JKwWxpVvhcv6uhO0xqh43XWoJ9qLstmfmhuXwNyp1mPn9VeBBQKhu2idec0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999613; c=relaxed/simple;
	bh=7AYevgm/dk0FY3evDjkmxRve/nPzE3jjDYRHUDalSQo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G92Bd0fOIJmlwbjtl2uVYrO9ydZvX/i//4asiRxPNVRRPh48l7fV7s/UONN59D/KIm5Z5fUPB8lr8SwQz/ktBrh/9DDelH9Eo5ePbcB/N0Yr/H7dUMMK0q8UKcYdvAlhYAfog0UvL/GpNa/AZiJr12nAT/S70l4hfjaS0yoAHDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KxdVfa/0; arc=fail smtp.client-ip=40.107.100.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mh0wE6B2hPz+CncnzdMwH1u7azP+T7TizMhiqUnIdXyOfALN74hyEbCTVrtu2NshZyolZTTQPMwjLl0itbWxgSFg3di8fSHYgUWC9t/4lfaAwF1A5+RI6sJBMNNnb4g5rEw9canOAb5MkxOMLTyHiV46l6h+w7lamkWQM1vJL+ZP4kq5Jl4jSXu3p/X8/8MzOGfYazT87VY8QDHQnD4MugXZyrnJ+PrfgMJeZ1taGInRARRvxj2DMdR0xMzAhwGJQZ49ltmfXjWTcnV2Z5EpIu4kAHA5Z4sIMdHNBgjnHh2dBCukl0pMSXyer9WnqvfYq0DdLbIarQgAPjqyNNr5sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGMoeu14lEt8msC9YkjZnWB4zDinMCue4dnI2muRl0g=;
 b=QhT1zxgtY6q8Hr+/3xjeTgnvIfPbZy2PdWNleIDusV1jt8p+dwz3oIoUUoyaKWoeyrSg0REpyIQ3TXOLFj6gM8ZnN86ZhRlmSbNhtY4F9hg8KLMYnLMkEYIKlOgBsNb2I6W+A3965VvXwGVFvj0izMoAljxqWq4iLFcf45bANnZ00JEmVz4xa5Ay12XiKIAWGcnyCDP/FeeAFQi1w136GQlD3wGYFQX/Lc+l9y+t6T2ZWK02n3mln5QwZjI0OtrJI4IG5AXSgPA5Y9vEY1jXwz219ONNjB8MqyV6CrWHHgiYAJmtEC1znFK6jf3Lefm5nkA4ys+8rtosho7R4lkPbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGMoeu14lEt8msC9YkjZnWB4zDinMCue4dnI2muRl0g=;
 b=KxdVfa/0FxId++72gTPi6moVmpW1s1kcv2KPbxxWvSmvAK/4thJgPuyIzBxnZo3OCEAz/qGl8pkiTTIMUNZ/mtMSdLb+gV4YZnq2en76T8NkNhjV+CcPWx8phOOPGCzbcTbk+VKHdRzCWE8Y2PNcdouGh+A9rJQLk8kMaXOIX8A=
Received: from SA1PR05CA0017.namprd05.prod.outlook.com (2603:10b6:806:2d2::20)
 by SA1PR12MB6847.namprd12.prod.outlook.com (2603:10b6:806:25e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 11:00:02 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:806:2d2:cafe::7) by SA1PR05CA0017.outlook.office365.com
 (2603:10b6:806:2d2::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.13 via Frontend Transport; Mon,
 3 Mar 2025 11:00:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 11:00:02 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Mar
 2025 04:59:55 -0600
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<shyam-sundar.s-k@amd.com>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <naveenkrishna.chatradhi@amd.com>, Akshay Gupta
	<akshay.gupta@amd.com>
Subject: [PATCH v5 09/11] misc: amd-sbi: Add support for read MCA register protocol
Date: Mon, 3 Mar 2025 10:59:00 +0000
Message-ID: <20250303105902.215009-10-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|SA1PR12MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: 4744807a-ea41-4a9f-807f-08dd5a428c38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yD8EaVLkQp+mzDjiTshh+Jp6gixV3iCFzLHYroC/+h3yKuAa/GMmUzOCzB6o?=
 =?us-ascii?Q?hhivhPiMYU9nC4uBuyeG919jErenSEIQ0l+FpzBda2qybiCt6WaNo24iW5Mo?=
 =?us-ascii?Q?w9SfxO+INE0xGQJ/Tuf+jaQ3qNxJTIUgxRu+/ZuCQbHMDpnLQ0IRwRYGb2c3?=
 =?us-ascii?Q?h4Y2PswL3bBCfFWNS91VXFQyaYmksEbKnIGd3i8hUcfh8Hd7j9Ces5qPZzZS?=
 =?us-ascii?Q?yk2HCusW+nZpP5DZ3nuBWGcR0uaO++3FFHhfIyRtaqYSkeJEvYmiwzVuTaPU?=
 =?us-ascii?Q?3LKNKh52tiPm5cZnh4RghPhLmwsXz/vapwrjryKXFSlPWfIPbq7LtCzvA8y9?=
 =?us-ascii?Q?jdPyuM8x+7ywjqBJvpv4H4idLrlENCZ0kKd58dV8aX8ff4LR4WkavVpVMCQl?=
 =?us-ascii?Q?7jHdKop7Xi4UEkawE3s8/3QyNAbBWPt0qC23ryl71AWA5GYLU71xlwu88V0M?=
 =?us-ascii?Q?frv7yc8k2PR0MpNvLvvDib3KEwf34bWP4wrPBkPprEd3xmqtW5l8rOX9DpHD?=
 =?us-ascii?Q?nGc6HZrRVZeSt2UU6IVLd0WCM2m0Bn/3PllbhbDIGKZmaqsw4Z0EbPW7D8R7?=
 =?us-ascii?Q?iq4wv3wQTzVzk/z3yU3jS3vvQfDTNL1Kmwhyt3IAYS/WdrPakhqaJ4EgKplb?=
 =?us-ascii?Q?fMwF+R6s6OWGdISzQnqiRkwasMoY0SC4kCchPuXNySFf3SRZz2RAg1DCx1JI?=
 =?us-ascii?Q?eTptdwFIEy4tYut3F3Njo5ywU5VJ56v+tv1xSzRAWRXgBBF/6RouyczNAr2P?=
 =?us-ascii?Q?xxaczS5tNErMAyAAZs1mOpPEVWxribZ8XHlSKa1nSvKoNreBbKPDeqMyVfNA?=
 =?us-ascii?Q?lI97FPfrPx0CAgx9xGA16Ty3RLcwReTHNB02tMFGvpaMXZLT1fx5crwjtr2a?=
 =?us-ascii?Q?69DJmYhFH9sktDVDt5gHq43CuZ1C8/j8lc+tgE2IXOw5dF0vWb4YSq//7R1i?=
 =?us-ascii?Q?iYUa131uQax7DkDy+8rOo3d7HLdAvwScUYCvoA1jg0gSUPyW4E3EKY8FHp9q?=
 =?us-ascii?Q?LW0J7HFK+Pb7bD6cceJgmSgyPTRRK+hMSUYaVRSeAhzfQmYGnjPyASM9upZF?=
 =?us-ascii?Q?7Pfb6/BxosF3yHIzTZuDhduJrKMI1iNAEbgyKc+jt9Mwr1kaRV7D+9eNsZtD?=
 =?us-ascii?Q?M6IBmynnjRgWXceZy7BpznzbxFYOenKPdrKm43pktKSK6Izjr8dXpTW7nEsq?=
 =?us-ascii?Q?QMEwmLjXvG/ubuXjRpkV2iqYVKlQxgbsBcfvkJZZEoQDqvKZ4Vr5ftVp1bM/?=
 =?us-ascii?Q?E2N/3QZUqd7GiLgv3hpyacSgrDhzF7ST1Yd24zy+S19fND+HMuJPJE6Sifjz?=
 =?us-ascii?Q?NaaigLJQJSPMz3E+avcPtMOe0gU51ozDbooaEiE/u0wf+Dyq2jHrsvb1t7g9?=
 =?us-ascii?Q?GiLcDg76ttTstUHyigtVWQr63k+oTTdBk+rWagDLdfAi3ryJDqzKAWaB3MEw?=
 =?us-ascii?Q?cfzzsRt12wIPaQRWjpIT7MqZxfFkKQga3gYP22CfeITbkiTrEtsEDI0DRozo?=
 =?us-ascii?Q?tfdbEPOCeQqZCMA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 11:00:02.2395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4744807a-ea41-4a9f-807f-08dd5a428c38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6847
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dMx2SkRzFwQ7
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741703326.66489@VDSA6vXZ2EFnz2tSYekv2Q
X-ITU-MailScanner-SpamCheck: not spam

- AMD provides custom protocol to read Machine Check Architecture(MCA)
  registers over sideband. The information is accessed for range of
  MCA registers by passing register address and thread ID to the protocol=

