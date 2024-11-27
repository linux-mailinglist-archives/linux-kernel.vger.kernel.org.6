Return-Path: <linux-kernel+bounces-423395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E7F9DA6CA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDF94281A16
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E44C1F667C;
	Wed, 27 Nov 2024 11:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sWmTV4GG"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8D81F6677;
	Wed, 27 Nov 2024 11:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732706561; cv=fail; b=PkpDKzzFPO3apBQDqIPIJbmM4SGcmEsq64GCFyUlHWTW9QAEWd2pnn63PQo0twAi6sgkTt0mr5lg0mIyThYoJc0MhA6uy1gQ7I0GB7R9Ma6jgzVAm8XnI9z0/NrcCVXZL9lpTo9Dquoup5x1MPKpGC0jbPcBWgBu6kIuBnGjoLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732706561; c=relaxed/simple;
	bh=TYuDefE5o6JsD4jXbjI5zpjxEc0j0tNQDw/WSbjab38=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PKXMSVuVsCGXYyfOvqEwBgAuqUKQW1rUS1b4zwLORiFvSKnCZVyW7fH6qY5wPiYEuOoW+QE6kv1wCGooOjH+wwKbWEYliOqmPdVsZarw4gNwYytOWrXmWAYZnNQHGMMQLgTZjx4wYGVcCV6MLclTUYJjOoHPEbgp+oTH5WIfOvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sWmTV4GG; arc=fail smtp.client-ip=40.107.220.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUYNFUhwbPcfBv/sBtstSUoICJRkbwBtvWNTYcgcUYVRI0Zzc3KRm8E6hkH8JHON+uBZM5EOORpSq0DwvIrdXIvkAF3FEWHnX9Sh+71Hk0VpsWxXdjDZrBgzEy/GZdc/x7HKYFiIVLuAYgYUVyS3gIG4B+FByZ0w418Vo8noid6+sWz6J9WqbvINRc8tzVkKI8d0vOW8vLt3IiJzxoVJ4lKk11lTAmLP8ibMctHmfTm911LsZfuFaresgUxRlJOzI5tqr6Ko4sfXO4JEImzTIPOe2RY7IX/oU0SgleSJJMRAPzZ6IpJ+IVlLa5AkNLqLVMhaaBw4jyvuQ/eWlo5w0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tCOncg/iDILytUeVCgGrsZHuksKz3nVtd9URHAQS7I=;
 b=KBbbHeAgE7whqJDdycrf4EsUf21B6rMISDhaGFj6SyjakCjidMkV7vRew7CEmE6pPdLbCCKi6rp2fQ3K0VexLzYCoSIGtj5/vQo5zNQu02dZMhLa44Lzgu/6XLuZW0hgNMLbRTYyAKxVFmtf7Y4bhkW9m77uRQ17Sq5hdHm4Ck+E/stju6FyBGf4xsch5tisuISzSH0lh+2neD+IwPTbMGsDx6+pH4xFj6fwBo+F/j6JGDdQ7cB4QSwTTtB86c7jKKDAWyZVBjyqSE/cJASYch6sH46VhqnVpSh18o1JUoHLtPZ0TssnLE/byiZpzJTJ/g2Bwfuc0zGOi7dPU2ytmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tCOncg/iDILytUeVCgGrsZHuksKz3nVtd9URHAQS7I=;
 b=sWmTV4GG92FwWzwzF/39Qx43IXt3X4LJ/yB048t4uyVhn26D4pLBHDanrDG5hZIeHe5gFtBqOeEFACCISB323BvxAUTZ1EgiRFuXkLLQE8LS8S4OncRVPPMwzjxRqORfiH/X0wrXueZg4fDfk8XIuIZ6RttTEJ3RdfNeefNAJI4=
Received: from BN0PR03CA0035.namprd03.prod.outlook.com (2603:10b6:408:e7::10)
 by DM4PR12MB6133.namprd12.prod.outlook.com (2603:10b6:8:ae::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.21; Wed, 27 Nov 2024 11:22:35 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:e7:cafe::35) by BN0PR03CA0035.outlook.office365.com
 (2603:10b6:408:e7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12 via Frontend Transport; Wed,
 27 Nov 2024 11:22:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Wed, 27 Nov 2024 11:22:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 27 Nov
 2024 05:22:33 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 27 Nov
 2024 05:22:32 -0600
Received: from prasad-lnx-mach.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 27 Nov 2024 05:22:28 -0600
From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <syed.sabakareem@amd.com>,
	<mario.limonciello@amd.com>, Venkata Prasad Potturu
	<venkataprasad.potturu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Tim Crawford
	<tcrawford@system76.com>, =?UTF-8?q?Attila=20T=C5=91k=C3=A9s?=
	<attitokes@gmail.com>, Techno Mooney <techno.mooney@gmail.com>, Jeremy Soller
	<jeremy@system76.com>, Malcolm Hart <malcolm@5harts.com>, "open list:SOUND -
 SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: yc: Fix for enabling DMIC on acp6x via _DSD entry
Date: Wed, 27 Nov 2024 16:52:25 +0530
Message-ID: <20241127112227.227106-1-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|DM4PR12MB6133:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f4f97fc-e354-4368-b775-08dd0ed5ca7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zWCzOVHEd9BUIHL0+NjwF19g0FvASduhx9l+mrIuSho/Ko3zb56p55aIYMlw?=
 =?us-ascii?Q?t0TWAfRKxpUU3VSI3M7PiDZMtkYwjjHowjAhafgOgqoT9QB4r4JK39ZfHqnk?=
 =?us-ascii?Q?LhOORMGcJtpJc+uUP5UEfgy7PIFW0a9EIHCYlwc7YZqSimRE9yxE+H9ts2Bw?=
 =?us-ascii?Q?c7X8fatmLWHr+jt4zAw/UFRgovCWSr1NPE/Qn2vKGRQ/l9pmF+gZjn8knE6o?=
 =?us-ascii?Q?iSB1RrwBHaK2yup1sh97ffZmHg1UjaHeOJmhQGyZ9+pUcJWFcddCraJqOzFk?=
 =?us-ascii?Q?CVLPwvIU9w6Pz359RDHpwtypY/1q7/pfvVZvPV8V4r5C5XpmZNqtca9egp/V?=
 =?us-ascii?Q?kC9m2nA2QNIQc9KIRB9mmon1qeTTQAFuglU8xBjvB1wYEDyJOZUxyXB+6k+T?=
 =?us-ascii?Q?kDBob2EPqsex0fpNN9eN1Q04E7eGI7er2CWsSbpgSED7/MkljwD6IY4d6F8r?=
 =?us-ascii?Q?BGh17Pv9dP3i505MQsDfe86C9sJQgqrFq44TJOGrVDqgh/jUsQhyphAu/aA5?=
 =?us-ascii?Q?r4RuYS5Fq8RTgzB3lnUm3NH3T/zTLeNeVwpXUoBQ6hbqFrsZn92g94oiqbo9?=
 =?us-ascii?Q?KGkcmLFsk6liyWFoH2uVjAh58wR5EG2QMt8UcNoog2kMMGTTe1nlgCGL368j?=
 =?us-ascii?Q?OqqubYgzXdPtHGT5+sna+XzstjRz+eLRG3F6e6BKVkrhi8XtgaQFEYaYjuY8?=
 =?us-ascii?Q?1fpC1Gu81KbiG6LZklpk1LW3rt1dCpdYg3G0xVQ/ZtpW79tByufah7jrU3d2?=
 =?us-ascii?Q?atlpaR1zGQ8cR9kb8jmI++t6kZ4Hfs8LCttROG8q/OS7mBHIQgQwPPIzCFho?=
 =?us-ascii?Q?icby5E/xE44u9R1HQao7JEFh1LG3lgFZEjQHawUKYUrQzPDik0Y5H6zAn56D?=
 =?us-ascii?Q?r0MiYk/TpVm0hhyrp0PqYzBZMZSAOx+tX/glGVLzYLnK+9ZSCQ59FsRjUq3c?=
 =?us-ascii?Q?1qMy0NZk4qqEaVo0s4uunvtXiozDekWunshiXdvPtaTV3MxuLAu/7z5Q4Zn+?=
 =?us-ascii?Q?ALPhUso0Kl+xKwSs8IzYPG2hXwTYWHj4qxDEvlqeGPF05NRoayv1ZjgOert4?=
 =?us-ascii?Q?jAuRn0L07oAmTk0rJO6XwK52s7jzY1uBFqHuNcNRGuk8GO898BBkr3OEJtti?=
 =?us-ascii?Q?YVhkQ8MU7q2v5hcLAtVWVHQd/Q5D1WJg7gfaf5Y8aeXHObU9B002HCVD9T5O?=
 =?us-ascii?Q?xfe7ICloPrp05B9p9lSudNZkDCGi8woly8T8lHpIfkK8or7sNkydfJvY7ChV?=
 =?us-ascii?Q?wlT1fwEg2zIeZyhtgBG45G9Az1Y04lRqzeR25+rrqKMHj7TqY0InwfgCWdzY?=
 =?us-ascii?Q?U6b+H7/KhIznGB2bY+ep99QBJ+RP51o81eryTxrm2U3H3kpAGLw9mKnsIJsI?=
 =?us-ascii?Q?r0HzhV9QVMWpIfmCoFvMs3Q0dzd+nhlesuRdVxZPSEimKUaeu/GDK4u34Mn4?=
 =?us-ascii?Q?2u9lUiRh/K0EO/2mT11nGBwaBbpTWZXw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 11:22:34.3847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4f97fc-e354-4368-b775-08dd0ed5ca7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6133

Add condition check to register ACP PDM sound card by reading
_WOV acpi entry.

Fixes: 5426f506b584 ("ASoC: amd: Add support for enabling DMIC on acp6x via _DSD")

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 438865d5e376..c301dac8b979 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -523,8 +523,14 @@ static int acp6x_probe(struct platform_device *pdev)
 	struct acp6x_pdm *machine = NULL;
 	struct snd_soc_card *card;
 	struct acpi_device *adev;
+	acpi_handle handle;
+	acpi_integer dmic_status;
 	int ret;
+	bool is_dmic_enable, wov_en;
 
+	/* IF WOV entry not found, enable dmic based on AcpDmicConnected entry*/
+	is_dmic_enable = false;
+	wov_en = true;
 	/* check the parent device's firmware node has _DSD or not */
 	adev = ACPI_COMPANION(pdev->dev.parent);
 	if (adev) {
@@ -532,9 +538,19 @@ static int acp6x_probe(struct platform_device *pdev)
 
 		if (!acpi_dev_get_property(adev, "AcpDmicConnected", ACPI_TYPE_INTEGER, &obj) &&
 		    obj->integer.value == 1)
-			platform_set_drvdata(pdev, &acp6x_card);
+			is_dmic_enable = true;
 	}
 
+	handle = ACPI_HANDLE(pdev->dev.parent);
+	ret = acpi_evaluate_integer(handle, "_WOV", NULL, &dmic_status);
+	if (!ACPI_FAILURE(ret))
+		wov_en = dmic_status;
+
+	if (is_dmic_enable && wov_en)
+		platform_set_drvdata(pdev, &acp6x_card);
+	else
+		return 0;
+
 	/* check for any DMI overrides */
 	dmi_id = dmi_first_match(yc_acp_quirk_table);
 	if (dmi_id)
-- 
2.39.2


