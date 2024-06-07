Return-Path: <linux-kernel+bounces-205812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2189000A6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E9A2850C2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EBA15ECD1;
	Fri,  7 Jun 2024 10:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DBeG+oIa"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0163515E5BB;
	Fri,  7 Jun 2024 10:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755704; cv=fail; b=iHGWo22TVr08i0wuH1HFvoCJHpJOfi3i5PZ4TbkDjdndg3RKSnU67I/fq1NYHmHWfnLG3bivK7+1SiqAXqZ/PaYVogb15CIR1N2ayY73IotiJOabaqxMnIguZh8NKgIaEKe0ZR25eOvjSG3UXCfzaZjG2tK6TKIXG1/cGCumW04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755704; c=relaxed/simple;
	bh=8jopo64aJS9Ewo/Zbk90XLHJVILuqL3qi9AASt7px7o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=afF72Nij3GQ4NSJwBV5HtPVtgKbjfm25Dvmvbb8tYoBnCpzDkD6dex5MQRfnwJR3Sm0OKU76aytmTr44qzg/RpqbFbXmZuljphr0kDgEen65iSgspi+8R0gawxuxxtR3UuCuKSj/CXjnBti+Gjzn9pRavDUbQVaeodiy5FA3gzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DBeG+oIa; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=He3ClBQ01XAX39mbBgem+dGDCbPFgN/csA2lFJ4R0Hg5LjHlzAJ7f8PV1i91+42zR4JNXbNaR1JapOmT4yGUeQURTgNvdJuP3WGTYHQoCkGE3lYiwVtfD/Vdh+Ubowvl0miDEf0l+KcVWBbRK1FdivyfNf352C8vcU5184IVynFaFEwFJ+JRLe+RYimtB+hlFmCtDeC5G3rzSt4pCpc4OkgJC6rTzofTAXBH56IJN+ty1+Q2mlKD7scx5Fv+U57HXJJQSCk2kKcLq5rbxo8mVDq4VyjsflO29o5hcZgNIVgNg+JNwMGVcLBw2XMqMO4qxixUYj1bOanq+PldxFdKCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sK1B+oYGn/D10oohky/JpiiRSxfxumanJWAuIesK2M0=;
 b=Vna/rIijRV33zSGX7u0oFs4Rsslf4UTGmGDqCrApJBk2+YKyL2w1AfAARZkFAJndR4vUE31+peSZzfqspfyuXqLQCaADbdlhoKoDf+sJ7PdDfxujQiHCwNbhpENMwTDHjt4SB/rkeoFF/BaWrl8OedRhaxcnYbPOznqRjIuTE7HDufknCysIK02r2CFxmuIfKkRyp6qrLH+ahlQE/F0oAiV6ueQ+m1F2EF7O9+nVvICZomgaf0xuF433mzv558cg1EhO6zlFbim8JOUkbukwW/VlirxJJE8m4qfiDxyfNujlvmnzpAFcjzEbk0mBWSatpQwAvSxKEPD/hht4DA36MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sK1B+oYGn/D10oohky/JpiiRSxfxumanJWAuIesK2M0=;
 b=DBeG+oIaVpQP+uw4w5pOykJ5LRi0srUmO31oENY1wUeYfFL0BaaMWXtdQwmj0U3U0yevdj09FROrKo5PfQ0SflIJgFbboEbLM8iKFHzPX2K/70UeQdhqaHF+WuUncRx3qj8X4Xp1uNK/uQp4ww3uMtv78/M+DYnJQqJ+1Or5dE0Zb3megM5Rg65rl6Ym9uayerlzVs2XXghNBUUW61tQwQhLBcqCo0Yodn1rJh0t42WMvJs98nj02TSFK5JR2M2ATiVKI7TrSqzOljHJuOSIIADkodzhCFiuj2+B1ZsNpBXehM7+Mis8w+5rll/ygsnJ/6AMDQS/RZyF27H3FsQM9g==
Received: from BYAPR07CA0052.namprd07.prod.outlook.com (2603:10b6:a03:60::29)
 by PH8PR12MB6937.namprd12.prod.outlook.com (2603:10b6:510:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 10:21:35 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:60:cafe::4) by BYAPR07CA0052.outlook.office365.com
 (2603:10b6:a03:60::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Fri, 7 Jun 2024 10:21:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Fri, 7 Jun 2024 10:21:34 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Jun 2024
 03:21:20 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Jun 2024
 03:21:20 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 7 Jun
 2024 03:21:19 -0700
From: Shravan Kumar Ramani <shravankr@nvidia.com>
To: Hans de Goede <hdegoede@redhat.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, "David
 Thompson" <davthompson@nvidia.com>
CC: Shravan Kumar Ramani <shravankr@nvidia.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/4] Documentation/ABI: Add document for Mellanox PMC driver
Date: Fri, 7 Jun 2024 06:21:11 -0400
Message-ID: <2714c0f2beddc19de3c08ddc0f9c43716884b0f2.1717755404.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1717755404.git.shravankr@nvidia.com>
References: <cover.1717755404.git.shravankr@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|PH8PR12MB6937:EE_
X-MS-Office365-Filtering-Correlation-Id: aaf0e633-4225-47a4-8f45-08dc86db9bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KpbzggMBKrsDoU9XX78ftsDiDMbYB0CkiNyaRzt1NRVOw9bB0FQ98F6J2l4t?=
 =?us-ascii?Q?A8g/PAsCaABKu3WSIL3Wmjc1tLUHDaYXfKqSkCISY2PEaAGBm3jeCdrgzxlS?=
 =?us-ascii?Q?0OTZn0T6kbwrEgT+6g4iGuDwCGv7vcaFH7qMDY0ktISiaWNGesqkVqQnTLOD?=
 =?us-ascii?Q?LV07MNOivYdyFnBaZ+ULkV9vvqiz5Nt+BbI8P6UFb2waDsUhwygVXJlpyWXo?=
 =?us-ascii?Q?GUs8vvXNBlNWFYprL/KnUcud3W2zh3g2mGi1adLnCcWeCxYoLpjX4iAN+FPE?=
 =?us-ascii?Q?zVf7o19j1Z9MT+30r0Zh8VzfqJZRmn6XHDZOgCfhvHVf8ZYBXNwMH5FN6Lt6?=
 =?us-ascii?Q?50n4xjfBQATxvVtuIna1duaBZ3v9kPNTPdazPcI1rIhvHRovixvUtP6BeAUo?=
 =?us-ascii?Q?H7KK5Bx4ABoXMqkgB/8Ya4LhWgjzntrP6WbpClrDe1R6YUoxTB2g1S8wRvMl?=
 =?us-ascii?Q?Mb/nfLXLDTISlYfQsUPyEx0+uCji4W8p4aLQ9cQe6lbgyOM7LOlp4EHq3TmD?=
 =?us-ascii?Q?GkuXA3P+dftk3V6cj9TYK8Wng9aDYpgws5nKgLNfV8BNs4phcSE5Q+BsENGO?=
 =?us-ascii?Q?K6k+7KS7+Nx8w54RIuutGeT5mOfci+Bs9zZTthgtczy4E2YCTZ5LsltUJGgp?=
 =?us-ascii?Q?0Q9zbYI672X53sMtgY5YTUglE73U3A7dICeEzTTLwB40ffI2ETIggLqJM6vU?=
 =?us-ascii?Q?NMMaByN/oXjWsS1F+5C9/EjTSursHgs+dbn9J7/zWJutCFTauwx0vvWtv+3n?=
 =?us-ascii?Q?APx5vSGDh6o/Xs6M7xIz5nGl/x7h3Pr/gL89jEfJZJLLs7megoSSAh6FSSII?=
 =?us-ascii?Q?UvvJAr7df8xtv94lMPHUvJz52XJ+5BQttg4LT+nxO2u2Iix6Du6ydsuHD42p?=
 =?us-ascii?Q?bUa9h2uufeDY8cAIC0hEl1tVR0eUj7/Z/ss/auqCyABuBzQ471W6k0ausFew?=
 =?us-ascii?Q?9WMb8G3kSjbTS01Gva+iKPNDzbSIRR5O5OyyaSFmSWr/6BPIJRC3OCrCEo3S?=
 =?us-ascii?Q?MPvUf/fAydR1dRQgdCDPx7N9eabtpm1SQ4uYMU+zc/hETlFqgs4ZAofIQscx?=
 =?us-ascii?Q?r/3fV9ej5i3dutwB4wkvBUjR62bNNwzxHWMJSIwellw2cWewJ75mo1OYAeEb?=
 =?us-ascii?Q?3HBMGumn8XdlZL41i9k7BuDJjbDwCEKx+siWmEWKZRv5Fp/1qWR1X5uL3Tw3?=
 =?us-ascii?Q?h0EXRgxIP7wIheodc1oC+UMcgVO02kzIdlWZku12uZLRJZNSJxy/7P5zWayO?=
 =?us-ascii?Q?siw4I9yn37eHOHuQsRWZslSShG6lx3dca6FSH8lSiIjaenJFHSiZAYz/Jz0g?=
 =?us-ascii?Q?JMIOkreNsHtnTzeL5CDZEXo+sBdKrCJBYKC8rhPdPva7kwPpTxMTs8DTatPa?=
 =?us-ascii?Q?p0CTkpJKM2tgqjn607uNQb+luteL9szoXYTV93C5LR8Ti5Q+5A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 10:21:34.9314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf0e633-4225-47a4-8f45-08dc86db9bca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6937

Document the sysfs interface for programming and monitoring the
performance counters in various HW blocks of Mellanox BlueField-1,
BlueField-2 and BlueField-3.

Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
Reviewed-by: David Thompson <davthompson@nvidia.com>
---
 .../ABI/testing/sysfs-platform-mellanox-pmc   | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-mellanox-pmc

diff --git a/Documentation/ABI/testing/sysfs-platform-mellanox-pmc b/Documentation/ABI/testing/sysfs-platform-mellanox-pmc
new file mode 100644
index 000000000000..9f987c6410da
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-mellanox-pmc
@@ -0,0 +1,54 @@
+HID           Driver         Description
+MLNXBFD0      mlxbf-pmc      Performance counters (BlueField-1)
+MLNXBFD1      mlxbf-pmc      Performance counters (BlueField-2)
+MLNXBFD2      mlxbf-pmc      Performance counters (BlueField-3)
+
+What:		/sys/bus/platform/devices/<HID>/hwmon/hwmonX/<block>/event_list
+Date:		Dec 2020
+KernelVersion:	5.10
+Contact:	"Shravan Kumar Ramani <shravankr@nvidia.com>"
+Description:
+		List of events supported by the counters in the specific block.
+		It is used to extract the event number or ID associated with
+		each event.
+
+What:		/sys/bus/platform/devices/<HID>/hwmon/hwmonX/<block>/event<N>
+Date:		Dec 2020
+KernelVersion:	5.10
+Contact:	"Shravan Kumar Ramani <shravankr@nvidia.com>"
+Description:
+		Event monitored by corresponding counter. This is used to
+		program or read back the event that should be or is currently
+		being monitored by counter<N>.
+
+What:		/sys/bus/platform/devices/<HID>/hwmon/hwmonX/<block>/counter<N>
+Date:		Dec 2020
+KernelVersion:	5.10
+Contact:	"Shravan Kumar Ramani <shravankr@nvidia.com>"
+Description:
+		Counter value of the event being monitored. This is used to
+		read the counter value of the event which was programmed using
+		event<N>. This is also used to clear or reset the counter value
+		by writing 0 to the counter sysfs.
+
+What:		/sys/bus/platform/devices/<HID>/hwmon/hwmonX/<block>/enable
+Date:		Dec 2020
+KernelVersion:	5.10
+Contact:	"Shravan Kumar Ramani <shravankr@nvidia.com>"
+Description:
+		Start or stop counters. This is used to start the counters
+		for monitoring the programmed events and also to stop the
+		counters after the desired duration. Writing value 1 will
+		start all the counters in the block, and writing 0 will
+		stop all the counters together.
+
+What:		/sys/bus/platform/devices/<HID>/hwmon/hwmonX/<block>/<reg>
+Date:		Dec 2020
+KernelVersion:	5.10
+Contact:	"Shravan Kumar Ramani <shravankr@nvidia.com>"
+Description:
+		Value of register. This is used to read or reset the registers
+		where various performance statistics are counted for each block.
+		Writing 0 to the sysfs will clear the counter, writing any other
+		value is not allowed.
+
-- 
2.30.1


