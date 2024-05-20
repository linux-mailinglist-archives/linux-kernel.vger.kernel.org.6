Return-Path: <linux-kernel+bounces-183702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A498C9CC4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 13:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20EB281FEB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDEE548F7;
	Mon, 20 May 2024 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kYTN11Nb"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCEE53380;
	Mon, 20 May 2024 11:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716206222; cv=fail; b=K2eBhNheZ4CYa3fspV1UL59Dgw1Z3qprPiKg+/IPXWZzMoraBZSLVItcluAHulottBj92FkdYKW0b5+P7BxVHbeVy1ZmhXRViSeCKgmszGmkVH75JWdC+iYJGCLADsQqrsNyyG0pyu5kbwuRxip7bdYlPIVL/h8fFV82ozc1zhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716206222; c=relaxed/simple;
	bh=DRN9+kfUKbV3984wUIA6xnWOcm5UEBNSSPcZ25LA6Bo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CRnZhH4Kuvo140OZ5M0gqsgmA4qjesTguF5fjfAc06qk+cnYQjxTwsHEKo+Pm7seLktmChhSN4LwsI6gBrorka6pFtgvaRy270aA5ABtaJhP8/gNXHmjOZLJBe8R566NR5TOVpuVE7bR6YMzCvPz/OCCmC56lvU4sRKIjJJDXv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kYTN11Nb; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzDA65NvJalmB5iWaHwwj3ttmyUwpk7dH1C4Xp48VJx13H8IcAxX6R9WAQP3U66rNl5t7IbND6Ql6OkCgjpidhJLK/ZzHq+rY1G2pyABAWG0TIAWDEMswWxs9MaSqPwlbdhPAjaAgyNk4+Sn0GubNsGJajOqfSeRERBcBP+I1JT3DftgzwvgYIj+m4ZzGZNAPw/a51Rp6x02oE0E+fiLfDLuvZUdxWv5zS4lMVqwXfjFe1Do90nHvFuc3Cpk8SK1/Uzo74lWzQ1fIJLWfLJqBJarSeI/lZNo5G0DoUmtKIYJHKEbS8EFgNIzbRLciTz005vJIP4pTWuuYBKb7yRZFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2EzonrVhq6oIy5zaTYX6aOlc2oQnRc2mw5TlWvysXk=;
 b=ZBjsdmorMT+8M3UpW/Ar5xBu7ux1K2D9iO60aZ72QadF1xaWQoRE3inPuOvXm5xnz8Il3ZKDoiWKKC4AdNHUIU71aV+tobCp8yPC8hZnqFGNO55XoABDY1Rg0RXDGjSF/NCswz6JqDMft77Um/1D/fNs1din8x8qLcT16dUO1+vnpjyeVdgNL4colt8qBEQfOcDcIT7j1HFg8BgDRJjMyhICm+Ex7z9L21l9H28d8yn2xAVMcx9uFMu37EFgM2cDZqMukXVsZmcarHRfUvKVXY/5OXfLcXXXoKVCYi9uMnyIS3uOo+YXVQcFoiK6p6J+d9B4hc8dRaLZL9ZqFHLajA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2EzonrVhq6oIy5zaTYX6aOlc2oQnRc2mw5TlWvysXk=;
 b=kYTN11NbhOIhxa5xD4w0ZsZpn3cM7+7U40BI4SlUJFWxd+AycCE3q4LH6POlpcChtFF11HBhQgQTQ1ZR6K6FoqNo8oYdl72He/U7Bl4IdTGijLsfFVIXpjVNDj0ygLuWhgPGhE1NWrKqbpoa05mfrs+6sYGo0eZOJKa3CCHQ86hUarDmCbElUJFoqPTLGKYKF05CIxkDCxAo0AD8Zr3pW6MMCwA+asM70SpVQVd7H19X0C1WufbWKbvgcsSalcupQkmQ54xwZZsf/T5vIFl3ayhrLo1zrknqJsY1N7JNJeaD1RlPbTeoG8wl/aRcLMtWjkVPbTf0XpKXPL4YL7iM5A==
Received: from MN2PR01CA0019.prod.exchangelabs.com (2603:10b6:208:10c::32) by
 CY8PR12MB8364.namprd12.prod.outlook.com (2603:10b6:930:7f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.35; Mon, 20 May 2024 11:56:57 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:10c:cafe::2b) by MN2PR01CA0019.outlook.office365.com
 (2603:10b6:208:10c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35 via Frontend
 Transport; Mon, 20 May 2024 11:56:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Mon, 20 May 2024 11:56:56 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 20 May
 2024 04:56:45 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 20 May
 2024 04:56:45 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 20 May
 2024 04:56:44 -0700
From: Shravan Kumar Ramani <shravankr@nvidia.com>
To: Hans de Goede <hdegoede@redhat.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, "David
 Thompson" <davthompson@nvidia.com>
CC: Shravan Kumar Ramani <shravankr@nvidia.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/4] Documentation/ABI: Add document for Mellanox PMC driver
Date: Mon, 20 May 2024 07:56:33 -0400
Message-ID: <d8f86ffc4a8a93f13a278ac9c95e0f95b4dd3fb9.1716205838.git.shravankr@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|CY8PR12MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: dcb5f7e6-30b6-4102-b93e-08dc78c3f30d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DWVuzaOYGOhRUaSZx/4UdS+3/IpNrRkLAsMY4NO+AE5GU3Orx4hAY2lFXBOp?=
 =?us-ascii?Q?/5dXGcGIvWgO+GlnU0EmgIqT4VFm7XMkN0JwcTtOt9bGgj/cDnCWZ42VHC3R?=
 =?us-ascii?Q?xSry3MnKxAMqN3Azs1vCVpwcwt7B0df+ranLKPl/zGqIPcMd9KxDWGsiuoqX?=
 =?us-ascii?Q?s8T9xpftlit0Xat0BP6i1sLw95DdF8PAa7Oyx4na1pFkrKpWLa3NX18bZXjq?=
 =?us-ascii?Q?cF5sD1NnPoTwnjs5Pr4R9Iw/fqsPgXFz97uBTYNEUi6ZEbyCJhcA22O0U1u8?=
 =?us-ascii?Q?A0+iBzcu7g0LO/yzKkPb8rLGdJ13Ju/bkZVh4VlCcG9D8B3TCJfSyBPC7v5S?=
 =?us-ascii?Q?Yy3StKYfdotBpIxTjtXxLtk4I0/et1ilwKS3+8sMzAwv7Z1FGQuas31j/Nfc?=
 =?us-ascii?Q?NvX1hKyHb4BHRwf47RUG4ybL+HxDrjESDIy1B0GLopGCJ6vxzwjLKkAQbU7H?=
 =?us-ascii?Q?toy6yxVWjZ7jGwyEiU03bd+sRiXLTT+XsyyTfaWv098+jDq9GPyoumJcr7I5?=
 =?us-ascii?Q?He6cbWW0NSFXlLDUqE6FOKQJy6mPrFp8OwqJO81qnqYJ4cx/FxROqEOMc44o?=
 =?us-ascii?Q?ZU1CmoJMg7HlyMSTbEOZwJYbh/wERsDAUIsQTbOlZN05kpcjiaDaJfL3ilB/?=
 =?us-ascii?Q?aFwBCJwE6BTsJUKM9zuchaXGFYIkkKusxfTRLip5hnIBNLYB+0KHvbHc0YKl?=
 =?us-ascii?Q?92E+DFM40UKOLkyqKEwxwqEuU0+7QsMncjtNUIzD8XL6/zvGUOifclEMN6Yw?=
 =?us-ascii?Q?nX81NmgR76supd2CHd7skxau0UkuigsVyfqE4Z4W8GpxoHOMgz1bvKmXcPjB?=
 =?us-ascii?Q?T60hzicHhHrwcoYJYgkz0w19d43phTtEAxNg235f4de89NfjWWFzPOixjig1?=
 =?us-ascii?Q?DROEVqz3IzErzTHIhmrS9oCrcHTk/UqIWpHHyA3qK/Xm0iQl9Fp8YuU8sust?=
 =?us-ascii?Q?kh6nFZkaFBiOAv+/4HsCMzwAp1MMe1rvkOWWxeO0ra1TaVUslsmUUE03bXP9?=
 =?us-ascii?Q?yFvaGUeKTTxLccfJ77aou8DziO5HDf4dxVwxHTzPPjDkyAuqVE1zsGF3iHCY?=
 =?us-ascii?Q?9RZGpTmYNA0rSV/lSIt/I8AtrOwyP+crGqW9PIUjV3j6jxhzDJy3hhjIW654?=
 =?us-ascii?Q?ipmh0WpbhIWLCmRiC2Th68Xx+lts+RJCM20sKiAHwLE9cf9dBKzU3883K2zH?=
 =?us-ascii?Q?4R/293FSM/o3D095uKh4iUZVzcrlZXmH4z8SiKjTqVD6TQw/g8zsqh6lIM+c?=
 =?us-ascii?Q?2lqeffpO/72Npk3l6oW/4K9xZR0w2khFNAKvF0iu+e61W1Qolnt9zGUJo17p?=
 =?us-ascii?Q?/e13a6e77jHxBbeuNK8CngltOItPk6mN2BfVj6x9mjFnZMwRO/zK7/RsFRdr?=
 =?us-ascii?Q?5S5xiBkShp5gdlTAqIKUgtnifDdo?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 11:56:56.9455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb5f7e6-30b6-4102-b93e-08dc78c3f30d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8364

The sysfs interface is created for programming and monitoring the
performance counters in various HW blocks of Mellanox BlueField-1,
BlueField-2 and BlueField-3.

Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
Reviewed-by: David Thompson <davthompson@nvidia.com>
---
 .../ABI/testing/sysfs-platform-mellanox-pmc   | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-mellanox-pmc

diff --git a/Documentation/ABI/testing/sysfs-platform-mellanox-pmc b/Documentation/ABI/testing/sysfs-platform-mellanox-pmc
new file mode 100644
index 000000000000..47094024dbeb
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-mellanox-pmc
@@ -0,0 +1,49 @@
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
+		event<N>. This is also used to clear or reset the counter value.
+
+What:		/sys/bus/platform/devices/<HID>/hwmon/hwmonX/<block>/enable
+Date:		Dec 2020
+KernelVersion:	5.10
+Contact:	"Shravan Kumar Ramani <shravankr@nvidia.com>"
+Description:
+		Start or stop counters. This is used to start the counters
+		for monitoring the programmed events and also to stop the
+		counters after the desired duration.
+
+What:		/sys/bus/platform/devices/<HID>/hwmon/hwmonX/<block>/<reg>
+Date:		Dec 2020
+KernelVersion:	5.10
+Contact:	"Shravan Kumar Ramani <shravankr@nvidia.com>"
+Description:
+		Value of register. This is used to read or reset the registers
+		where various performance statistics are counted for each block.
+
-- 
2.30.1


