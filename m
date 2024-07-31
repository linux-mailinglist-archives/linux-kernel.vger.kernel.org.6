Return-Path: <linux-kernel+bounces-269501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0F1943390
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 178B61C223E1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631CA1BC097;
	Wed, 31 Jul 2024 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JvJmmcop"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2FF1BC065;
	Wed, 31 Jul 2024 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722440564; cv=fail; b=AFftRwi14dz9wlUfCwzVTTZKXLUQnTzxew6pMwlS2cEK/EXeDqt/HhKxvk2WjVcZKmQknWJ7XGGnR5cxBWyvUh+Y3MYOg+bJjPxuJo+vg0zS/VmoLZnogQMsQPAT975a8nbkpt+8aQgJQFykyFsrwIYK37zqfDNfsWDHf/Fmpzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722440564; c=relaxed/simple;
	bh=5ay0Gt0hva7MVhckA/jSt8XQTSk8oi0Bn/H/Y3Mpq7Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ftnTBNX5XbzF+iggmJcpcLxw9TomUqWx+GGCF1pnymRDpfEnoGB4x4m9z2tBMPkVfLOUMDFG+Fr3IX49QYMl40+BmxiwcVzW7/8azOWHrAc6DgV2kfJnAioeXmzTlSea2f+Ze8ACn5s8Wy5mOw7FhHApLl9FCV3TieR57oMymFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JvJmmcop; arc=fail smtp.client-ip=40.107.96.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EftrP48gDV3Z6lmoIG4r2FfWXzoGWp3AoMdmiEMAsMiIbqRp8Vjdl0zk9aJ/D7odNUILyUrVCni3pcgkNvpQhjL+/LmSPP5HfDKwqU+Q7iOaV4a9BuTDysZiRokbVAl+DeUCnUPkJFgCbNZmR8DItu4BFxzDPO9Ys9WBmMv/2/jLGr1GWaWlRmd58ImuvHShAV09ccaIfKRQ6o5jgbFC5JHuKNstne7HJ3xvSAyp4zVzIy/jn/sbJdbQvrdkBNq6gGYRNWJcRuUsmwRLuAoYsyPrB60tuhvWwVREr9amxOiYVyajYm8bZLHLHKdhGoFVjQh959XGpiSNYMA8MGS4JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5utttJCw9otr4OYG/wtifAYsp6L77djCWab126RLfo=;
 b=KYistJbl98G1+VMGPj++jhg73I4vNcTQWpD2msP2NERi7eRzVhcw7CLJNUjjq8L0Op7coWOrdWyZDrVXoTJh0zHzFPTqyn8LfHU+kwzxk34Gj3qa5prSSG+DjEb+qzND2Cj371spxtIaf6lbntcFON/PnIzOnfJlWV2eDHTVsoUCD6jnmg5kuvWYrxGWqKilYSgin+Q7qDOAm8wbynhlEMXPPj2wVHNjg94VXgXmAuVU/Qbc5/arLK9uluRLQew8S5J16yt7laRb2fqyRSABwO2XaYej54PPi29RWf9C5NYrfxGeapV1cKgqUI9IdBwY0jKlEj3lKsGT7XO6Js8BrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5utttJCw9otr4OYG/wtifAYsp6L77djCWab126RLfo=;
 b=JvJmmcopdkZxPs+64/5p45AJjIhXZKqs3FVtoGxyuRvUeBt/1fSMd4TkeWsEJBpPcTLBLbLa6pfampBvynjGzsAuaTHZ43g7F6m/VpfRBN+dViwoqS3mV4L56RNlHYeKKfAZe4UAWVPggx20ML34VJs5/o+q04x0TYPqaCONy4s=
Received: from CH2PR18CA0029.namprd18.prod.outlook.com (2603:10b6:610:4f::39)
 by CY5PR12MB6346.namprd12.prod.outlook.com (2603:10b6:930:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 15:42:39 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::30) by CH2PR18CA0029.outlook.office365.com
 (2603:10b6:610:4f::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22 via Frontend
 Transport; Wed, 31 Jul 2024 15:42:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Wed, 31 Jul 2024 15:42:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 31 Jul
 2024 10:42:37 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 31 Jul
 2024 10:42:37 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 31 Jul 2024 10:42:34 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <mka@chromium.org>, <gregkh@linuxfoundation.org>,
	<javier.carrasco@wolfvision.net>, <macpaul.lin@mediatek.com>,
	<jbrunet@baylibre.com>, <stefan.eichenberger@toradex.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH v3 1/2] usb: misc: onboard_dev: extend platform data to add power on delay field
Date: Wed, 31 Jul 2024 21:12:27 +0530
Message-ID: <1722440548-107682-2-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1722440548-107682-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1722440548-107682-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: radhey.shyam.pandey@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|CY5PR12MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: b2a4e99e-8331-4808-c215-08dcb177688a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R6umQHLRDZljcSF9McdJrin6oqpjrrgOKFRK5mIkv9zhzomFKLAiWcJqqRmu?=
 =?us-ascii?Q?tnVgoJxNQFslGZiBSo7eO+cVrcaf5IXcrJ49faXvXmVZ8DhZkT8PLo5fRFSq?=
 =?us-ascii?Q?5nWuTNVHBb5Ev77by9ttQCZkkIFbyWRca42pRCrqK91hevHtoGIOtAjgy+Xl?=
 =?us-ascii?Q?4H45x0Qadd7bgaL81xqtEBIfi8oQ3sLl+SgRzQi2CtlJn4PPZBNmQimxB8y+?=
 =?us-ascii?Q?c6IlfkS1qVT6gHsEBi926MQtO6HPtayam49S8HAemwnHBXQU+pqhK5f9YGnj?=
 =?us-ascii?Q?Y5b+p/xPMNvhSHevsRNZ7DjgKXAoZaol56Ec0Tk1e5u8KA7NpmxWCSQhYKmW?=
 =?us-ascii?Q?rL6TGoYvx8etRVuE/knbtTVKIgaLLbVVVZB8MbmTz2+oumirFBtXkNGnwbJW?=
 =?us-ascii?Q?bt4KnBgimptolx07OleBgMRv4QhShBF5Oiyqj7SZlx/w5ZZ0h8czg9TgHRoF?=
 =?us-ascii?Q?mkDtwvb0FS9nj0ylTkNP+wM4YMjXilFCnogJPbaj+L78ghQQWI1/h7wZgW1S?=
 =?us-ascii?Q?G229dZ+Ke9teb7XCbQTT10aprffjzAWw+b6sZ7xZJ2a5lfqgKB+iXiDYQT8c?=
 =?us-ascii?Q?rnEBzzyLFjkd9JnEUm7Kjrg9DOS0x/yEpSDMNTw07g5svAXEomS11b7Jd8dx?=
 =?us-ascii?Q?72dwp27xzCMKqwI1feRUQBrO3g4xxYb3GqY5Lepkfm46IIoT7FeI36WdJArr?=
 =?us-ascii?Q?CkfYk8ozHtxOUX4//dAO6NZlm/CA4Q2DjY5X2It8obRRIkbqX0CIa3TsB5+3?=
 =?us-ascii?Q?ZhfnK5joA7is2Smtlh22rpdemil/uXoQMCfdIcV+kLO4sv8VnBsW9s1VxYzP?=
 =?us-ascii?Q?WezxCjlwp2euR2on94NeuEYyKs0ezvUiPY9LGVz8u0YoHSS9pOZZad1kErvZ?=
 =?us-ascii?Q?ASneJzFxm+yYIbSKS51Ud05XrTN8vqwUAKxqr7kZnq8WeeuWe9vzdWtpWR8z?=
 =?us-ascii?Q?CgwfVkrcQrzvFzGnpPbIuBC1NzO+ogWpsuDxALZ0/K8OTnuMHXRbz/jTnwEL?=
 =?us-ascii?Q?cvWWNp8jlQvgeAwhKWcEyM1yjhD3XK14SETI3DI1F6psg+I8ITyMeLI/p4Hn?=
 =?us-ascii?Q?ckWFFMnqHBQ2WafS8CQgZA6NcHYjMhFV650Ybwae3jSjR0ozWA+ROWLeS/JC?=
 =?us-ascii?Q?OJskYTaIAbisk5pMzu2ExvURDBk2qk2r+9luGhooT3LOCTyN9DnJ+5KKsEA6?=
 =?us-ascii?Q?vV11A1qCJQ5Ns+GGh1IPfVwXLNnvKL16AI4t6ZH5jMNbh08LljFcnY/+F6py?=
 =?us-ascii?Q?OmQtqew013h5uv221KmT/nrEQUiQ5yLLZ7sf57Rfs2NE8aWxiXXxT5qeb9sM?=
 =?us-ascii?Q?U5v43a2edDVJHJGL6903753dXb9BiII/sKZMjApSbQaxwFx9jKYvIsMCVFbX?=
 =?us-ascii?Q?CSU8FYx9mtKfwgNT/ROUgo7wNAce4kVlVcDA+loLw34gj4KEGebwwCk1XE8N?=
 =?us-ascii?Q?XxyppWBOgdWgweomYtDEWHYx36YVEG1u?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 15:42:39.1666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a4e99e-8331-4808-c215-08dcb177688a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6346

Introduce dedicated field 'power_on_delay_us' in onboard platform data
and update its delay for USB5744 configuration. Hub itself requires some
delay after reset to get to state where configuration data is going to
be accepted. Without delay upcoming support for configuration via SMBUS
is reporting a failure on the first SMBus write.

i2c 2-002d: error -ENXIO: BYPASS_UDC_SUSPEND bit configuration failed

Similar delay is likely also required for default configuration but
because there is enough time (code execution) between reset and usage
of the hub any issue is not visible but it doesn't mean delay shouldn't
be reflected.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Suggested-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes for v3:
- Modified power_on_delay_us comment.

Changes for v2:
- New patch
---
 drivers/usb/misc/onboard_usb_dev.c | 1 +
 drivers/usb/misc/onboard_usb_dev.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
index 56710e6b1653..da27c48fc11d 100644
--- a/drivers/usb/misc/onboard_usb_dev.c
+++ b/drivers/usb/misc/onboard_usb_dev.c
@@ -98,6 +98,7 @@ static int onboard_dev_power_on(struct onboard_dev *onboard_dev)
 
 	fsleep(onboard_dev->pdata->reset_us);
 	gpiod_set_value_cansleep(onboard_dev->reset_gpio, 0);
+	fsleep(onboard_dev->pdata->power_on_delay_us);
 
 	onboard_dev->is_powered_on = true;
 
diff --git a/drivers/usb/misc/onboard_usb_dev.h b/drivers/usb/misc/onboard_usb_dev.h
index fbba549c0f47..317b3eb99c02 100644
--- a/drivers/usb/misc/onboard_usb_dev.h
+++ b/drivers/usb/misc/onboard_usb_dev.h
@@ -10,6 +10,7 @@
 
 struct onboard_dev_pdata {
 	unsigned long reset_us;		/* reset pulse width in us */
+	unsigned long power_on_delay_us; /* power on delay in us */
 	unsigned int num_supplies;	/* number of supplies */
 	const char * const supply_names[MAX_SUPPLIES];
 	bool is_hub;
@@ -24,6 +25,7 @@ static const struct onboard_dev_pdata microchip_usb424_data = {
 
 static const struct onboard_dev_pdata microchip_usb5744_data = {
 	.reset_us = 0,
+	.power_on_delay_us = 10000,
 	.num_supplies = 2,
 	.supply_names = { "vdd", "vdd2" },
 	.is_hub = true,
-- 
2.34.1


