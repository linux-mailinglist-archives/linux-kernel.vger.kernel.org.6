Return-Path: <linux-kernel+bounces-336611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B46CC983CFC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D52F21C226EA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B474137776;
	Tue, 24 Sep 2024 06:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l8SjGOYm"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2734253373;
	Tue, 24 Sep 2024 06:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158752; cv=fail; b=sAlbhwyURWr8fIgU0/0B6XMcA46ahJWkzAZ0ZglfCVGuWpnyO6ZzoHe9zBvtb3lwOfRvvtWUm+IeLlkPmQNEibt6HwHb0R1gyLBWw2tq5gW3vzz0+gEHd0yNtCDTMoPxiB2VPU/i3THza8Dc0T4q/TsXLgYtLMPCzSEBYte2dvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158752; c=relaxed/simple;
	bh=KzitV1oxuy1EUDHT8QTklG1V+1PcaT0h3pPBDN287jQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FdsFr8pakvo1NS9xtCEUaJox9pYS1RMOeKrN/s7RBzlw7fQFPaZPnkJDpfrLhLZCLvCm9S0Nc98yx+4ZsE4p2IWRkB+pq0GaI3QZOO5CZNW69fJ12ZnwpqyJjHqNqmOfDkP8qfcaFWzZ4n7hbkpr6J0SJi+a4UWyC5jhbLiEbdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l8SjGOYm; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sAVXERx8N/Cz26So9hfSLydumjiBirQEtdrfhFyO00qDkVpaRMtTr+O2jkMojJV/q4VXR2gGuVBfdh93v0D8FsgHEE3W7FFzyyw7o2MTcsR6HBkcl7Rh7HyTWOnMUjUSJje2VgRyxIjMN+7MiBayKjSiRzJ/H1CjaNeUAh5rnu0BBm61Kavi1eEzGZCDfc4oUgq3YgY3KQ93iMFKITUs0cz7znq21NTb+R4SsUApY3UG8e+K0nAQ71z8kx9Ywng3o0FSQBBDtbNSHpQbTrZFilB7XTzBIEYHtinaKhfDMborRXuuZM38ubLQIt9toSTv/sfE+lsH21hKSP2FJmgwyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yawNe7HEJ3hSME6919ctWPkNP2GbWKg/m6HoWKacOEU=;
 b=pZeJvfyKu8Yw0Pkj1Ys+K8SB8aglOvJ99npveDEpyY9YJBvckw6KzA1cSb9tEWrcyZ6TUsEphnbiSgqN3k6GyTYuii1VhBDuW8lFJQIFZmx75M7hAOYJsQ+JfZBEvzOoqCHFEk7fHN4RwyEFFtVoN+FVsTFrN5DRpH7wTFhVVkjCxMGBm45ukixdXyNB+qCTBQyOvSjUkJjVd8q/0b70yQpSRVVV/f8gsZPFwRyFUxA3W1CMziqqJZpIQyMay9kAqBD7Zkdg/g1oQ7or2b9U4MBlvTR08Xgqeu6bwB3wTCVm2df2NZ44nnVeQ2XQvbODKq9QvxEVwlO0pYaYHX7IrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yawNe7HEJ3hSME6919ctWPkNP2GbWKg/m6HoWKacOEU=;
 b=l8SjGOYmuNQp+mmZ5L4T3eADsCE7hWLxZ6x0/NjF8cT7NKpavf27wUVNuAhZaUrLcToWU9JQxkvTur7QFat90QrqnD+mb5RHQ7WU02pFlv1598txfM1Zen40/RX74XWfse34BagPHhHR9xHN2l57iZ/V3cAPyKrNbaE8dXlt8aM=
Received: from PH8PR07CA0030.namprd07.prod.outlook.com (2603:10b6:510:2cf::16)
 by MW4PR12MB6975.namprd12.prod.outlook.com (2603:10b6:303:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 06:19:07 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::32) by PH8PR07CA0030.outlook.office365.com
 (2603:10b6:510:2cf::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27 via Frontend
 Transport; Tue, 24 Sep 2024 06:19:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Tue, 24 Sep 2024 06:19:07 +0000
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 01:19:03 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH V2 8/9] ASoC: amd: acp: replace adata->platform conditional check
Date: Tue, 24 Sep 2024 11:48:20 +0530
Message-ID: <20240924061821.1127054-9-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240924061821.1127054-1-Vijendar.Mukunda@amd.com>
References: <20240924061821.1127054-1-Vijendar.Mukunda@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|MW4PR12MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 61bd5262-a6f7-4bfa-35ce-08dcdc60cba9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eAgMQS6E+AbffL5tIoTjqJlnfrHQw4j2Eg0SjadMzOzFJDVHUVHN+wDl8eFq?=
 =?us-ascii?Q?O6h7QsKUd9rsZS0FJIvF+1gpnn+JY0O0Vupi0b4M4M1DhKPHlRaPYY4cA8dE?=
 =?us-ascii?Q?FwX4f3fl/NpuUY6CxuPO5efQHL3gBUlQ4n8Hho2MZZQ1SxFlfFXjZQbWpBLN?=
 =?us-ascii?Q?cgSZWsEVUp5Jn5PvfsnBgS9ceajZYPX36fc4yy1vfu2iKs2PO1eW4TKyMUzQ?=
 =?us-ascii?Q?rgt8pElFcZMzrHHKleMvx28jhe2t+50bvWitgDxHmmmfFYnapNoHnQkyZY5F?=
 =?us-ascii?Q?FsrSP5WdxugA6zTuPEAp5iRnCrqPl/FDX0byJuXN3jLj93okhR7vtADY0DHx?=
 =?us-ascii?Q?7Y97dRtPtjcpiVe/IIjbdP5F2RIwyEvYL3USqWI62XazPmXycLR1K6SGNNdD?=
 =?us-ascii?Q?IvwbpoSwtzN1YteTOHLogitZ+nyCWry54v6TahJZuqeBvzw3JDNuNe84B16U?=
 =?us-ascii?Q?hKQClVYO/B2NAVef/ENteZsUDp+LwgdZRXSdQNYOj/i801HDzehnj4GOQM9f?=
 =?us-ascii?Q?G0t1r2SQaGNpkkW8P6WSt79dBOwpnisBZc+aV47/xzzX698wftCBltgvC0Lj?=
 =?us-ascii?Q?A/gb5PJQONSj8UxCb3sgR7k3idiy+4OVIwnUtekEKxQXn3hWKxqQX37VwZkK?=
 =?us-ascii?Q?qSL4teCqdH9iiPbtpcEkoNmnvSEvQgwSVm0FGarANbyCqYtVn2R+u9dMui1r?=
 =?us-ascii?Q?JH5N3ECLrJgXFfoWNlX/keGY4g+TqUf3GyqIb6A9RrDDBYqFxG17evM2ghDZ?=
 =?us-ascii?Q?KJR07rNiQFEjvjJC10QXbhM7gAoKHqrnQguAMyitzCVI2K2Ij+tXi620Dgk3?=
 =?us-ascii?Q?9Js1Xhmza7lD58/eRQva9ORSBfhOQFNB5u0xu/vbX70MzRcYhywXPyZqbbl3?=
 =?us-ascii?Q?2w+O2831vu5bdruEz/kdY4E+Pg+uWf5830BRY/KAMXAhKeaT76aZj36SvQ/l?=
 =?us-ascii?Q?789XfrZ4AUu88DASyvUtO4lYPryg86DWzinqJbBTISOW4FnC94GLPCR9yVxh?=
 =?us-ascii?Q?L6jGgkN/EmUiUYuD8QCOOF7FeWP3BrWiXIJunpZifmoL9xQMi59cw42iGtIV?=
 =?us-ascii?Q?z+nona8sDNE2g0IbJidMKNqeSPvfAtg+DraFmVtmOSWvPnFyIkyjL/IxFSiZ?=
 =?us-ascii?Q?vJs7HCNkKg2O2/8iVwa4P1HDAMAzQjukziCLWmAm2rrvsL5acp3fpqR9je/W?=
 =?us-ascii?Q?ihBEgEwH9w20H6DFvh/Fo/N40E1kGIZH+Q5tO1GZuHdbIeo+EPX4FxNXs5CV?=
 =?us-ascii?Q?cobiQIl7U4QwvftskYFK8rrUKCP+pW1BiJ6oAzy2/yWGNjo3vyOOD0IVMB3K?=
 =?us-ascii?Q?wjiuf1ydOVE8ASq2BNVbXr8rhj5ioXbE2bIkfNYGux6VlMgxabID98S7TNCD?=
 =?us-ascii?Q?1jf9qF8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 06:19:07.0821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61bd5262-a6f7-4bfa-35ce-08dcdc60cba9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6975

Replace adata->platform condition check with acp pci revision id
variable in config_acp_dma() & acp70_i2s_master_clock_generate()
functions.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-platform.c | 6 +++---
 sound/soc/amd/acp/acp70.c        | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/amd/acp/acp-platform.c b/sound/soc/amd/acp/acp-platform.c
index 78fcff6ea657..7be9b4ff7923 100644
--- a/sound/soc/amd/acp/acp-platform.c
+++ b/sound/soc/amd/acp/acp-platform.c
@@ -205,9 +205,9 @@ void config_acp_dma(struct acp_dev_data *adata, struct acp_stream *stream, int s
 	u32 low, high, val;
 	u16 page_idx;
 
-	switch (adata->platform) {
-	case ACP70:
-	case ACP71:
+	switch (adata->acp_rev) {
+	case ACP70_PCI_ID:
+	case ACP71_PCI_ID:
 		switch (stream->dai_id) {
 		case I2S_SP_INSTANCE:
 			if (stream->dir == SNDRV_PCM_STREAM_PLAYBACK)
diff --git a/sound/soc/amd/acp/acp70.c b/sound/soc/amd/acp/acp70.c
index 82c26e4fefc1..db5dd64969b0 100644
--- a/sound/soc/amd/acp/acp70.c
+++ b/sound/soc/amd/acp/acp70.c
@@ -142,9 +142,9 @@ static int acp70_i2s_master_clock_generate(struct acp_dev_data *adata)
 	struct pci_dev *smn_dev;
 	u32 device_id;
 
-	if (adata->platform == ACP70)
+	if (adata->acp_rev == ACP70_PCI_ID)
 		device_id = 0x1507;
-	else if (adata->platform == ACP71)
+	else if (adata->acp_rev == ACP71_PCI_ID)
 		device_id = 0x1122;
 	else
 		return -ENODEV;
-- 
2.34.1


