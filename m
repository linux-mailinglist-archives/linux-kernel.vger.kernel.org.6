Return-Path: <linux-kernel+bounces-183704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D048C9CC8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 13:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3285D1C20D8D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CB653E1A;
	Mon, 20 May 2024 11:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CmIAQMg+"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BF753E02;
	Mon, 20 May 2024 11:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716206227; cv=fail; b=aEYA2cD/mRiejamCx1ARFdFMrRtW1T5nwAQMWyB1WaRU98r+2subOQZJQXFo7mwf1X2C9UxwlugelQNE1jjoiXDdz57SbeHV9DiMYz1xneZdv8VozrVkzl2M2rLdo3awBZMqrz1oeOp5bINOzvaclbpIAVSIBiQMTruu8oSU3UM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716206227; c=relaxed/simple;
	bh=ucqeW9kbc8dpKY+Zhc+eWoKgaO58utRX/EVG8SkWLOk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oKO9R37cOaFHtHdWYKsWJSr3dkdyTv5+hkRHyyLnt9KBz6+7O2bAcXJP+/jT2HAErv2RLetGllHFw8D6VjdlY9icX8OBlv4SOTzjFOgL23CnJq5Oav+4LjA9B3ErSksyILXJqwZ4/ehPDsJvjnaXa+3xTLBvM76O3dq1HQzMFZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CmIAQMg+; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrVpaNG5BJXLcWx4YYmYKyptC0/sZrbmKRu1zu+vyJ/4nUevW1tPZeOMVo8ToWnT3r/4wv+eTzfWcWoHZVZBGXe4sDdmQs2wMjNxiK7Ed1dYPZcwYrDuAylmrilQjozxBYV9v9XmtjbOkxRvGytDb5015JQiIfvvQEo8At5K3hC618XyI0e2F9oG1kwQQsmGJ1JwuCbLmdcu0gEKO1ZgOG0CXJzhC4wICZkZ5qe71RFDQ6htRX2CurExF0X/jJcXtKNq7R2RLRYb37fLmteZySTeYioWBUq+0gX2ZffTaqKd48hPbrBv3Cst2tp4ENdicCkMnYTPBZrIzU0e8F79uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYWMgciAkx3D6/qOEEwsM9A3EY+lOrg2D9/nNr/FoYg=;
 b=FbhLd+fLk9lXi3wFgnjr1XMb0y1idPGCng5+G3x8I9zpFqr5iiZo+//KC7+PcuboBNWnE5QgaCK4ZASQuwWo+cXea3HwellkZqwN6DfPw1V18l2YPd/cl6BS5Bo7D0U+evOLKOwJTPLgBgKCjR/c9O6wtxioBKDsezmf1Xo89SOIbC7UGDSOw3Ja29OmaSL0BokuUgQchQ1KQe5RBPt3ytuZsj2CueZuaY4xw+m6kjsq8S/kJrVU7t6aUNCrki0QoDzopjSoku3QOAxQkrkMvNtg1B8AdpHtKxNOd+PPlDmO/I/vhm8j3C0t4dxSDqaDqcU/wqcKIGx6v0i5zFnPWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYWMgciAkx3D6/qOEEwsM9A3EY+lOrg2D9/nNr/FoYg=;
 b=CmIAQMg+gDve4WnBIYqgNvqX7/twaeGxRN+/Swtmn5Q6QXb017vek3OqN7goM+ogCloVDFTPSHmm2I5/S7PQmoi4ow50RRBkF7KmjOa8M+hI0Nwl/xS/teabX8n7sp2RBxalEan2qQCm46oxE2GoSZKo5ylJm78cYtFwfsecpTWaVdtwMVM1aqBQ0nf6xUC/XPU02A7F5OLgLR3AWIgXq/c3MAf15++lUF4c4SprQ5TJ2XyMFlt6LVH1yi+04NZGR+m0YV9Yjz0GETrtDa0iLabDyZ34kt/90/ubJOkRGzncn20NCKDIe2QRMyg/EQGZYhsV+QbZ0kunp/QFiDJcLw==
Received: from BL1PR13CA0131.namprd13.prod.outlook.com (2603:10b6:208:2bb::16)
 by BL3PR12MB6618.namprd12.prod.outlook.com (2603:10b6:208:38d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34; Mon, 20 May
 2024 11:57:03 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:2bb:cafe::5f) by BL1PR13CA0131.outlook.office365.com
 (2603:10b6:208:2bb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.16 via Frontend
 Transport; Mon, 20 May 2024 11:57:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Mon, 20 May 2024 11:57:03 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 20 May
 2024 04:56:52 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 20 May
 2024 04:56:51 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 20 May
 2024 04:56:51 -0700
From: Shravan Kumar Ramani <shravankr@nvidia.com>
To: Hans de Goede <hdegoede@redhat.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, "David
 Thompson" <davthompson@nvidia.com>
CC: Shravan Kumar Ramani <shravankr@nvidia.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/4] Documentation/ABI: Add new sysfs fields to sysfs-platform-mellanox-pmc
Date: Mon, 20 May 2024 07:56:36 -0400
Message-ID: <857ddcc583986631bb5f6888305fdb898c76e72e.1716205838.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1716205838.git.shravankr@nvidia.com>
References: <cover.1716205838.git.shravankr@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|BL3PR12MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: 626c1cd5-5b15-4174-b49b-08dc78c3f6d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gm3culY+vRG/7ms2lZhZzXNW8ZbpIucs/SM7EYhiFjcMP6sxVmJ6mQBC1Ned?=
 =?us-ascii?Q?llhuveYugP36YTzDvItRQmOkuVvKqm57MZqoiGCU+pTZcKGUEmGSMbZ5FVCp?=
 =?us-ascii?Q?Q/zagZs7lMOE5rECXx8mi0gdoixt1HJEJHxHaiNP1lzVyVlI8x155uiw3e/j?=
 =?us-ascii?Q?Ci3Uxdorv4d76wFq+m+czDNXl3PhMMPCY2icUSTFj5sOLOyAqjZ8f9QLRMLc?=
 =?us-ascii?Q?/AusNx67ZDBocrLXVjasXHu9zJ6uvtuEhQKcY4VeHXAYtioebje/2JFXUp5d?=
 =?us-ascii?Q?iqzoxZGCW2VJ6S3yK57HWdKhm0I0P+jCqIg+WZ6QLQTVW/r6teOCWsOYsvpX?=
 =?us-ascii?Q?UMufgb4VrItjMSDUqyTzMljro6UjFs6lfFFGcYn5n/aQ6MCBz6VEkt8cBrEs?=
 =?us-ascii?Q?jaoWSTMIJUUOKB3/nQPTHpG7fee0q6qYrahz9RHPJL24t/5zR4C41bPJRo6J?=
 =?us-ascii?Q?agM75FRr0D9QvttExLseOZgL0ri251wvZQddrnSRgcOv8HLekr9yQF6/XZ+s?=
 =?us-ascii?Q?2FqtDqSf/AO/g9WBNttCUP+Xfpsq123oUBIkmhqdu8pF6ZLNdbaBldQmlRaA?=
 =?us-ascii?Q?7pMeDjja84Dye9ffAsuVbDS91l+HlRIQ8vgdgg63eo0VE8rnHQpOy8koLvh0?=
 =?us-ascii?Q?BJEWlT6gAftAJAx6r0+UhM2XAdxm6AaXWEHa8PPfrzcBaIl/3/KkLOI83P3O?=
 =?us-ascii?Q?5mXMdCP2tvZsf5eoCUJPFdfwADmQtv89VzC6u2QifPYz/a2aIeMeccPsUb/1?=
 =?us-ascii?Q?M4qAiXMZfz9rMlNFP8jpzzqEgPN81cBRwGvi/vAnFrt5n2UKHS1+kwyCNXq0?=
 =?us-ascii?Q?Cce6ZcmXH8YPPpByZB+QsyEfUU8UpnxmEoQe/Jw75vMIH+MR0rQ4nXfrgxyi?=
 =?us-ascii?Q?NCO9FYU25r4qOg/IIIE6Pp4RaevCZPQWdVptMIQ51nzobJwtA9/NYJBD5u58?=
 =?us-ascii?Q?ET6e+OzPdFkZX/7M2Pys8ZBdG7Xc/DOpFBhlRT3r9XGmQn8Kuv7Mx1VIuXSd?=
 =?us-ascii?Q?/SvzjZP5rn3MXQ6Epw7EL4puYnGvlzVDjOgZeFC0uQy6Hrkhqi2F/mC6izgQ?=
 =?us-ascii?Q?0mNwBGSt3nXZgYPSgDns4r8QCajjtcTRHGjdcqFWeKAxieFcrJ3P8OsUFH+N?=
 =?us-ascii?Q?EbAclvJWydTx9xN0dfpzwh3NIQMbDcreSkuEXxavgq8tLKtzQr0VlIZOgOhm?=
 =?us-ascii?Q?VxexhBDMdBzE9+6ZL0C6NE8Ov26T24+CSK41dXzno9DStOTtJDVHfsVZrLFQ?=
 =?us-ascii?Q?EuXvWXHVhAe9G1/3uM7kTdp4iKvRIVrchCMa8R8WMDzq/gYHNwHd+wj+ao11?=
 =?us-ascii?Q?l4J+l5IlW+vLmRnG92OInMuEPeUtoSsAE2wsLP+lyhZdDMEf0ZJHPXRuBcmy?=
 =?us-ascii?Q?bw0CLDuucuzCa6IGdZdpxFsfJmMh?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 11:57:03.3023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 626c1cd5-5b15-4174-b49b-08dc78c3f6d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6618

Document newly added "count_clock" and "use_odd_counter" sysfs entries
for the Mellanox BlueField PMC driver.

Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
Reviewed-by: David Thompson <davthompson@nvidia.com>
---
 .../ABI/testing/sysfs-platform-mellanox-pmc      | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-mellanox-pmc b/Documentation/ABI/testing/sysfs-platform-mellanox-pmc
index 47094024dbeb..b9973ebec2fd 100644
--- a/Documentation/ABI/testing/sysfs-platform-mellanox-pmc
+++ b/Documentation/ABI/testing/sysfs-platform-mellanox-pmc
@@ -47,3 +47,19 @@ Description:
 		Value of register. This is used to read or reset the registers
 		where various performance statistics are counted for each block.
 
+What:		/sys/bus/platform/devices/<HID>/hwmon/hwmonX/<block>/count_clock
+Date:		May 2024
+KernelVersion:	6.10
+Contact:	"Shravan Kumar Ramani <shravankr@nvidia.com>"
+Description:
+		Use counter for counting cycles. This is used to program any of
+		the counters in the block to count cycles.
+
+What:		/sys/bus/platform/devices/<HID>/hwmon/hwmonX/<block>/use_odd_counter
+Date:		May 2024
+KernelVersion:	6.10
+Contact:	"Shravan Kumar Ramani <shravankr@nvidia.com>"
+Description:
+		Form 64-bit counter using 2 32-bit counters. This is used to combine
+		2 adjacent counters to form a single 64-bit counter.
+
-- 
2.30.1


