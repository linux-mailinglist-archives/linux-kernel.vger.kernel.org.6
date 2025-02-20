Return-Path: <linux-kernel+bounces-523730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 914B9A3DA7A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184E83AC7E5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DE91F5849;
	Thu, 20 Feb 2025 12:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oU/Labut"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B495C1F3FED;
	Thu, 20 Feb 2025 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740056036; cv=fail; b=n253RqcVww0e9RQmihvgodtmjtOKu+RUcAHbY7Fn2gG2zGyDTfcMSf3PPL+jjSw6loBgDovRISMaxkitUVUy9pe1khRjlRsxb2M1TVmsRwukuDdfegBl5XIKZnLtBDVMA8UDNjKh06gnDligftOeBmjt7NCKTxF3KUxDQsV5Hyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740056036; c=relaxed/simple;
	bh=KQ+0w2rmENQ9lSqdJjkaIP8Q7ZbPdI7raTd2w9Z4zCQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KJS2Z96YbiIVXsd/6qSNObKvvM+28uhfvh95rZsKxXs+MvL1RZaszc+x1kVcPLZ7ghZSh8ExjHJ40SKv0TvmUCa0BveGkvWUAHkhb2l3usQvZzMKxMLyzBseVpTQdHBuVTFRJl7igwRR93m9FnypdEU+E+UuJEcyG4QZedIBR6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oU/Labut; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Woq/uDRBfMCha+/8I5W7vcUwD7T6l/jnGpLXpGJIx8z9VxvW9Jm73CjKTF9ZI34oejZUpDFiTFiF9E7Ra/wpmwSm1c01iJZuFcuPFZ+JyNsHn8ePa5OXyoEIdSHoZ00y2LDPMcuPrwnYa0M+AfaePyK59zxPMtTVLOD+vYZLriMfS7YBTiV6YiAZU34wzHIu/wkMEKuY/Ove9G92Rh1WnNECHs7y6gaD3wOjNW7/KNZb2WfTaGkIi9AjffBAhCfpDeFN5UFqXbH0XRww0GB+oXCxG2axWIaB548CAbPp+MA9y11iftip7NRvbz8EQyAXXGPtjLpZ10MnTx48NTC/zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVrbPiR6EPYn5az92bcPLVyjEAW3VKkvPD6q3wbERNw=;
 b=qh/Ea1Qkw7pxVisD2CNMyrDh6U5SXVwqyXBYSUUYRLICBvC19VFMb9Vfr8t+ARlbRzsiLS+2OAdndxDxSqdJBsOb2bkfhuUjbH1YIAelMfNWhlHdoUBNRA6PH2ObNPZqKViU+PQyJcAVSAGc3AuxMiPWYsHIDPA0Z5NiBOCfOQuEvliMPE15vjdr4Ak5ixdMRiR5Yu08rBSYN47Ux5KKVEbrRB9PUxDi4lWi0+XrzoN5NYTe59/4zTvyZ2ZPoeXvGErK7km9Roj6otb886azAJ8G1ycPgC969dtDUpG4pT6ziFfX9bSCRwe/rFdii7X3WIArtGoOYC15JnHWGXeEhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVrbPiR6EPYn5az92bcPLVyjEAW3VKkvPD6q3wbERNw=;
 b=oU/LabutBoKBY6A3svPXFTZLPwhMn3OqnSlxugwDYfAivyoU4nNyvOs7tLWBSXmzt5DZQ8I9/wpRj13DuR+ijBgSQmE8lgj63eH8uB/OxRHjibI4Jt8yiNEDlPzc0rFeFmFRnQu7+VwbrCwhBRzpoKn/mql7vCT1JGB2/1+FG+E=
Received: from CH0PR08CA0005.namprd08.prod.outlook.com (2603:10b6:610:33::10)
 by CY5PR12MB6155.namprd12.prod.outlook.com (2603:10b6:930:25::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 12:53:51 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::43) by CH0PR08CA0005.outlook.office365.com
 (2603:10b6:610:33::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Thu,
 20 Feb 2025 12:53:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 12:53:51 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 06:53:47 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
Subject: [PATCH] dt-bindings: trivial-devices: Add ti,tps546b24
Date: Thu, 20 Feb 2025 13:53:43 +0100
Message-ID: <c79f69d0d37e7eb61f93f5dea69148b7756a3ee5.1740056021.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=855; i=michal.simek@amd.com; h=from:subject:message-id; bh=KQ+0w2rmENQ9lSqdJjkaIP8Q7ZbPdI7raTd2w9Z4zCQ=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvTtqjeE7VJutl4s+7jt7cYmydjNR7xdVvzjCm9YfyovY FZsiNLxjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjARPyOGOZyFTSc1//ZK/b63 PV7y5gsB4/8zChnmJ0yNmFpRXrjCNd5ldtk55cXf5Z/PAQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|CY5PR12MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f132235-35a2-49a5-5caf-08dd51ada025
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CIUzCyczSseIWriwiIDYkeO/J8QxK5JSctlgIBYd3CLhd2PHa6bzm/N3VtKv?=
 =?us-ascii?Q?PSmxnU5j8V9WU2D0AyO+6OJhp8+vp+pVUHLx2mn24Cbm4bZ/LhqxZkJ72zdo?=
 =?us-ascii?Q?0vNJXFQc8AKDXjkSrLly3h11ghgv9fO6vPzsZhJETT4HuYV5saHADXdBT4HO?=
 =?us-ascii?Q?CV4OE8FI36FHN3TATqBazK94xzw+9yJpP3AzS+sO7t4p/ZH6T+ADe2vjFpu1?=
 =?us-ascii?Q?tsevM1gbx/18e/XdzJ6YnTTvLZQH66rOasnG7FH5YzHFAVkPKxYWhu4K6/wu?=
 =?us-ascii?Q?1U/8Dn+CYKjjg3foNn17IwHxfCyOAsg8Lj3iicvH/Nbo21zUYroMckV58J9W?=
 =?us-ascii?Q?Vas/l+oOJU+qNMm97+x0fH+Ho73XtbLO6lMLJsuptuPiZ2HhuPJLHycu0Njk?=
 =?us-ascii?Q?EcU8eNCPnV4HhlVOB/q22Xe4V8FK/gOgJu6KmFnwSwea3npWB0dSq1w22a9w?=
 =?us-ascii?Q?/QSMBFm0wAgC0qHjQ6cJRtjRx7kdIx56+EORaX3YkNgaJ2DccJqbIzWC0XwT?=
 =?us-ascii?Q?PKBqJPf45hvNal4Q07hOyxTw555UiJQSQKZAS4ke+OGb6yGXfBe+Ws2lIszf?=
 =?us-ascii?Q?MU97lLhTIoQDwhoc+hg78PwwiwJHCvtKPHTqPv5lYwb3B0gMwmGu7ECr7I+l?=
 =?us-ascii?Q?WzjftlboZOxG8EcTDs2bGcqVtpc9JiSgQG90siTEIO3ju32dAivFKeSm9MlR?=
 =?us-ascii?Q?6OmA2DpHNNg9zpMAIsG9TKk0hWylLah4SazRL7KjIQUxsEfeueuIblkV1VHa?=
 =?us-ascii?Q?PI16nimemg8j1ClZJlzhjyWQ8qldBk/KGFNuzhAv2Wx6iMHDhNXlD5Z/yijO?=
 =?us-ascii?Q?M4YJr62+zm8vUX0WSSWD6k7M2MjBc7qePZV/QDcoYfBPC4TMnuWmdeAS/WGK?=
 =?us-ascii?Q?PMU8nDIM7xKYdzPINIJvNjwUvvyo8vZYMgcDxnsYtCGuhpHhz5w8wkfflpBU?=
 =?us-ascii?Q?swCDIl2dQhBYIP4gsbJ2B6c6RKHzaWdv4GIl+p4j+3G947wBt1E9HmEuQdS7?=
 =?us-ascii?Q?D6RZ30xiUmXVzer7L5PwAzGImgb5TiXAbVIwRjfbfd13mYyZauyhI1n7nGKH?=
 =?us-ascii?Q?G4JoqIomb0H1sJHR3DiFPnI8AT5avUd/CeXc6HxedVjRqBOeb5jhnz5JHjoB?=
 =?us-ascii?Q?SAv2ZSx/Yq02PeVKHZSc44IVXla5GgeTyei8c4YLMAis4cklT5ODziOIbFwd?=
 =?us-ascii?Q?kdSSc40dX33OOgxfqOjWOV31XarC2/TNUb4PQsd+zh6iz69hTArEH1YIvvwz?=
 =?us-ascii?Q?fWR7ZfvVO4ZyOR5IXqgmq3/C6SHRTuFu3JAUQQ08w0TMPjdWIZsNxNe5Zkeg?=
 =?us-ascii?Q?KxaKMjiGGFzJwZSjFxd9FeCBwqfvWgHCb2EK1TEfOwk7OpKL+BK7Cqy0Z8S1?=
 =?us-ascii?Q?tyBSkQUWQIM6LHXxyQzQvThGzsSf74Qlm2qFJvT3qhVNqR8DwwDAm8CwhATs?=
 =?us-ascii?Q?A7uNe2hDycPrGLtpNQ7cgAarFdNXGY+NQmA4OdjiRcV865WdOu4C1vbDmvMg?=
 =?us-ascii?Q?wdFepMJ0UgszDmA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 12:53:51.3536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f132235-35a2-49a5-5caf-08dd51ada025
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6155

Describe TPS546B24 DC-DC converter which is very similar to tps546d24
version. The difference is that B version handles up to 20A. D version up
to 40A.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 Documentation/devicetree/bindings/trivial-devices.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index fd6389aefc30..91a19faa8d9a 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -389,6 +389,7 @@ properties:
           - ti,tps544b25
           - ti,tps544c20
           - ti,tps544c25
+          - ti,tps546b24
           - ti,tps546d24
             # I2C Touch-Screen Controller
           - ti,tsc2003
-- 
2.43.0


