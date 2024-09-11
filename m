Return-Path: <linux-kernel+bounces-324082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2CD9747BD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 03:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C042870A2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6A417578;
	Wed, 11 Sep 2024 01:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="Fw1ykGrD"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2113.outbound.protection.outlook.com [40.107.215.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D7CB660
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 01:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726017910; cv=fail; b=Q/zS7FCq9Pm827l6GRLm8We2nS4DmZkD9iJJ1ZZziklNb/kXtELf+jISmyj96mKib9ExSJClKi6klYkbprlYS0XKMB4EKAVpmNXZk7oC9mVbeQhnPC7Q4l3bBGdkexDy9fZoLCcMEdkJQ0IB1HHi9naU6Lh0iKfs8GKTysfky/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726017910; c=relaxed/simple;
	bh=KGu7uGmCRg6E7ACUOM2mymlig7ItokM46C7qmw17CTg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=E3lNfTe/rHbJmkkPFx0kV169/wZb+LQCBO8LJchjh5xraTK9Rapv66OUg0ovx3Q7MeXoUOtShcMkyKlr0iMXc3hOD+1/inJhCPLiTH+wYO0Hnb1u33TXiqfsa+llgmGXGOuP2vEwbfnIE2BsbhH5LecuLimcS5D6jKl5LzRMVDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=Fw1ykGrD; arc=fail smtp.client-ip=40.107.215.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HaTBAfhQF/LPpgCGo4ZImmg9eu+uxKXLG9pI0oC7Rk5ilKSO0Ak5VzXKlzprdUdYO4M4A5DsT4xQGQdazsDmGuIZ7yiJlDElhysYKe5a3l5G7o91JRzvPPLPCEDjczuXywmYUoLOaqiDeI/2/ssl3iC51juVzEal2qMU4wx+A+BMxMaMB73NNou+UJNf+q14nB1/2kosll13GNEofUQEaGqzb2+f8QiUXFNVb9JKeH5nHHQ9Gt2B7J++K7ywQPjzWrtcxCXHt60e/9CNijHYjeFWFlTvUNrZbxMl9bWVW5li01eT8hkH8SMVwNuu+M78jnT9/nkM3VTqD/pof8415g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQh+2BwE5qvfVcswS2t/eGSxshRw0JS7/Zx8hJ2E/Rc=;
 b=iRcOnVNqn5CGnpXe/NNrh8Ecg7yKIObK0wxj4HAG4pbkjkIHB4v5YFKcMdT0Vcmd4Yznw9SAskCYgMJe4Gb417+iusuOFldMkUdNbbU+bVvIZyteIl0iTAmlbd/XbdUc0tB62XWsxwvpZBCOhKFAxeRIBfT0ZSsVMBF9Qrp1N2Y0dMOmAhCacQzbH1zivqzMGXtLSoOl+3v4qfb3JyVfrb8P/Ccki4gu8ADY/tH7n1eQ3OTyx5W6Kb/h2N3HfxtSaKPi8gd2eCWeWdPfnKi1dCKT+OJ51Dg4JTSdoBhGTPkyyL14V1AWIsRDCdtplGe4uP1bvzM3zIgtVpy5JLjqNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQh+2BwE5qvfVcswS2t/eGSxshRw0JS7/Zx8hJ2E/Rc=;
 b=Fw1ykGrDEIGBMWkdcgROLLI7MU1OPjfgNax93aAcZj2wWVU69yqPp/i8qal2WYQIxQct8Tlp+lJkSF4zmBVOEajdT9+48E5G7wS2+bPmBsSmUdARcQ1H9ZN772TkA+UZC05YfsEF+b7zmvqVqklJ0BTvmYFben5OX+30+7f/bLtWPc7ogNnFrjGSAb01AlW/4NlQdXu2VaJOQT6j/7PMzVbG4NulcQAq0CoQ0W5w4oyyrN/ChYFHKDBtnBUGN8exkM5V+Jw8pzJzVv4Af+FmdTIZHIYjLpTF0Y3k9yLGn+gpyBttK+/W9ZX4xNa1qw1XcOXxDKY0fqvJmIYyjpx6zA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TYZPR06MB3933.apcprd06.prod.outlook.com (2603:1096:400:29::9)
 by TYZPR06MB5298.apcprd06.prod.outlook.com (2603:1096:400:1f5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 01:24:57 +0000
Received: from TYZPR06MB3933.apcprd06.prod.outlook.com
 ([fe80::9b60:a415:f5ed:a367]) by TYZPR06MB3933.apcprd06.prod.outlook.com
 ([fe80::9b60:a415:f5ed:a367%7]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 01:24:57 +0000
From: "Shawn.Shao" <shawn.shao@jaguarmicro.com>
To: jacob.e.keller@intel.com,
	linux-kernel@vger.kernel.org
Cc: Shawn Shao <shawn.shao@jaguarmicro.com>
Subject: [PATCH v3] lib: Export the parsing functions and related data structures of the PLDM library
Date: Wed, 11 Sep 2024 09:24:44 +0800
Message-Id: <20240911012444.1979-1-shawn.shao@jaguarmicro.com>
X-Mailer: git-send-email 2.37.2.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To TYZPR06MB3933.apcprd06.prod.outlook.com
 (2603:1096:400:29::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB3933:EE_|TYZPR06MB5298:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f390b8f-54f8-46b5-66c3-08dcd2008c28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j1Hk0Mw4fxWoLV3wcPLL76whIdjZYhBGJ5tyRIX/G6d6A3PW5+fd2867c5fR?=
 =?us-ascii?Q?UyOn6rZHs/PTQj5B5wTfKSurU8TPNp4lv4G/GmVyC/rSQqU14F/Sbih8l1OM?=
 =?us-ascii?Q?NZ0tc7bqI5PleJUAQqasiA7dRC3Wao0YZJq5/TK/ninyUIqO1AZrEVKhWad/?=
 =?us-ascii?Q?qcUh9cp3nIXoqX923U9Cp+Bbsng0dmmUNyrN57Beuo9MBpEEM8S95l5IqyxM?=
 =?us-ascii?Q?h3ntWV+As3xYk4zA3VgBIiI08cy1NbIrLeAW2xwRHZ4UIvqK61qh9ryFGF45?=
 =?us-ascii?Q?5lliop5TtVu2cmAn52xByPdfDBxHRKFQs90n3RbNGSqAbiedcwLJt5icyid/?=
 =?us-ascii?Q?RjcJ+8JQyPVfJxJkC/gH0j3xdl3RWx9hOoPIu3akroJhy5+L/HRwWxHXOWvw?=
 =?us-ascii?Q?9uiJfvLTiaaRsXCJrPw0MKQ2WChxoBsqcsLUVAiQFby7czpIZ0wziwIIZQME?=
 =?us-ascii?Q?iJIYVzVz5OqHHf63JHzA2gg3ArabwWfi33e3NsGkKx1YXQIV2Xa+Ywbj94e2?=
 =?us-ascii?Q?svz0fhK6ZUL+78gAMUvJNui6y3AagqxOKkmXq1FD0DGiq5jVUywW5eJCWDww?=
 =?us-ascii?Q?XOwV9ivPRCHhvaQpoDfviL6llQgHyfH3XJknXWsACx+Ue500bQm08EokL0ux?=
 =?us-ascii?Q?OvS4qC5z2RqTvR4RbpyYHA2R5SA5BBNVXqgQv2MnQqvGqs3dp09dqhZQ75WI?=
 =?us-ascii?Q?+bc/YJQBuE7zOnq4z6NXuTUsQZafPQSTPkbrW4tLjPtm07DCcxPL0kqtQ258?=
 =?us-ascii?Q?WaDn3AgW2dgzgIk2/dUfnUBg9WvTFKmjwRRFafzQsbJlcGGCd+lx5Q1won9P?=
 =?us-ascii?Q?OIBc2e3Jd24EJ8j+wfGza8YjL6kmErM+Wp/1W1ZJYlWDfvTZMY+FiickY+Dy?=
 =?us-ascii?Q?ZT+zWQJzPEzfaO/KP4rv8bXzamr46vkdlIX6jS/cca6pQS0CzbUE9opaYpuP?=
 =?us-ascii?Q?WuxkKJozV8pr7f52WQ/iDyO3/kC5XSLVoKjl+a52M2hJzFyoW7J6tCmoTtHQ?=
 =?us-ascii?Q?61r03oJZAZmQk8uzDDoX4u8PxbTXocJpnDK7iIU0mU0/y2gX00d0/bhvO50f?=
 =?us-ascii?Q?rVDOxXn/T3pIDCXjCCG79BK0oJzlZY3CzOqlAjebJaaFr87Nuek1ry3zzZMp?=
 =?us-ascii?Q?DtbY2NUhjCPefa8WKKKfLS4ofP+F/FUWqhWUqD6GyvaRW+KS7uGFcVmA/Fcs?=
 =?us-ascii?Q?PSxNG/MUHQrZeCiAqWHa6PZq7+t488w/Dq2kfkIfweuaLIQv03EGBG40FW4P?=
 =?us-ascii?Q?pZMhDiHArVld2PGAphLgJHxCa6nB/ekUGcd8baLVBEo5CcyjRLM72qrn5Yqv?=
 =?us-ascii?Q?vFoWCalj8xn+aH311w9Hmz4+XZuIviGN7N2eVMsHYTLayJjYUhEmFDYs5y1f?=
 =?us-ascii?Q?nUD7/UldLdlP1JgkCvV6lEHGYWzvV/NdwJlScBMu7nFcSvu2CA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB3933.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qxF1ZKT43hddX4lbgHRBhQwgl8csvi5HBk1yCCrJskXXc79HrRFbwv3D3GI1?=
 =?us-ascii?Q?DuM9EB48bfsCQwzU7xncfLqcR0swBJZF1l9MZtoZ2DNCnqhos+z9l8MfHdgN?=
 =?us-ascii?Q?JJcbchrS8sQjnx2dk4UReOwC1Z9IVGEwdkNmTVuvHIDsPljWXxBj/kUB8c97?=
 =?us-ascii?Q?LwRgLVXUEZpZCKdoH+GvKPpK7PZSpjwpSB8CuUsPeDFpvjQ6Q3J1l6p9i58X?=
 =?us-ascii?Q?LtVSaV7H3ov4TxX+vESxVmqGJpg0ycni4m+5ddcbvuGDYIFYmwfiN54v0CKf?=
 =?us-ascii?Q?vIj5hhHBymxsl0MdxPsPISqwxQqS0zr1RRkYJ1nci652aCgL1K95BSGJP6f0?=
 =?us-ascii?Q?1oGPW4IrEZvtlSbvSvHW32Eu+PzPH5mDDIMsg8kk8WJvqOcLSDMw0afyeHiM?=
 =?us-ascii?Q?OQNP0PKJSBMzTS3rxCl/0XymWS5AoxMqmca549o7o5nNltGnexsvGNtx6m+v?=
 =?us-ascii?Q?kwoCONmfn2VKNR7CynxsCYLPageJM1FUiVRBv0mNQl/yZv0zQKd6GPOuHqmZ?=
 =?us-ascii?Q?bHR4UYV3ah+TnkSdJe69yOgSqaqB8CNKuR2iTFR+xZAX54FCOo18gvSgIMxJ?=
 =?us-ascii?Q?guFUGaXwrB4+j888SEhWPugXZAaO9h/KnlAf1ccfwJOQXQZUvwGkSW8sGZil?=
 =?us-ascii?Q?zP8xVuQ2yGekT//MMIPXR2/JGDBpzW33179DBuwUdCyhX8Jvjggd4aDJVf7Y?=
 =?us-ascii?Q?PwShtoNg47tjtH2XHmSwtbnMcwtB8QEM82z9aY49rUCGCGq6gzLHmDCNkDOE?=
 =?us-ascii?Q?CDklLIAZoo/c7a9lwQXPp3JeQoQNy7HhjrrgRrRtBjNn0pVpm3kveL86bgnC?=
 =?us-ascii?Q?JJfKeFJf0ZSfh2qJl1oPXV1JQgfUmCzbFozviFnaLP+avnXKdcN8bDrYXxvK?=
 =?us-ascii?Q?VLye52fdQNrvDUeXF47SF/m19xCtbyOeUhMd1tDpTHJOoOWX/ntowcHoBxnZ?=
 =?us-ascii?Q?1v2neqAG2JFWQ5JxxkQPyuBentBiJX4PZAfNlPfzjgE10Opr/19o2quTNK3O?=
 =?us-ascii?Q?HZdlF2cMUZcr8kBeCmr0ETFU8vVXg+/Lm4SENWeoBg+0AsYdZK1bzYKm6k/I?=
 =?us-ascii?Q?mdAT3w9klnOAGTvIYLqnqovznzFm0bwXBb5hLu4ViiE4nZNHGvM9z1Ovq/AX?=
 =?us-ascii?Q?DXl67Wjl2qkX1p7GM1+XLld5JvWYgPVXZ44wTnrr295MFvQn88r/9AtZKPmc?=
 =?us-ascii?Q?oAWEjnWnBUlqK/rtzQ8rbIAmzgb9JuvStiCI5rvzqwb+vripO21RXcLK+8DZ?=
 =?us-ascii?Q?EsRvZYJTX4n6mlJNM1bNUWOtXy4WKHdaXvDk7+M6cQF96GoegcwybCahwbTb?=
 =?us-ascii?Q?uYeflvUYUiKzUooQcOQebI34cz6dpemDrl0Bq1czBTdbFel5MjdxSBjEqk+F?=
 =?us-ascii?Q?m0xcFEXlUkesZ1zJOIezHZ1Sg6dLBw424+bbEsYiKDJ1xlQAYMetCxkFruKP?=
 =?us-ascii?Q?AhmNjvPv6NplFWNhfHYweVxmpMuiswM+i9Eop45FdGmKKLxoy+Xyuj0vVTwR?=
 =?us-ascii?Q?OEpmYPGwafeM3HlogNVOIcfrSttyKKvVs4tE6bnLSIlJb4d58wpdlottNeOs?=
 =?us-ascii?Q?FbVmkXP1j3gsohw4+N6rfq4Js6Fa7MZPIZBsq7j4sVTZv39Lz7qI1E9s8DTg?=
 =?us-ascii?Q?6g=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f390b8f-54f8-46b5-66c3-08dcd2008c28
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB3933.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 01:24:57.4487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PmM/zeLlZJ8AntaIbusHCXJYU3Rqyavf1/sa0m2mVKBt53fb9b8fvgZVU5HwHoqLSV9/Fe8zGGgoV0PBZhhZLHzNm2ur0iFRuHcY1f2yez0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5298

From: Shawn Shao <shawn.shao@jaguarmicro.com>

v1 -> v2: Updated the commit message, added a description
	of the changes related to `DeviceUpdateOptionFlags`, etc.
v2 -> v3: separate the device_update_flags into another patch

The PLDM library is used to implement firmware upgrades,
but the current library functions only support the
`pldmfw_flash_image` function to complete a fixed
process of parsing, sending data to the backend,
and flashing (allowing users to implement custom
logic using `pldmfw_ops`). However, this poses
significant challenges for device vendors using
PLDM for firmware upgrades.
The following scenarios are not supported:
1. Only using the PLDM parsing functions, as the
   current library does not support this operation.
2. The firmware upgrade process differs from this
   fixed flow (the firmware upgrade process may
   vary across different vendors).
	|-> pldmfw_flash_image
		|-> pldm_parse_image
			|-> pldm_parse_header
			|-> pldm_parse_records
			|-> pldm_parse_components
			-> pldm_verify_header_crc
		|-> pldm_find_matching_record (xxx_match_record)
		|-> pldm_send_package_data (xxx_send_package_data)
		|-> pldm_send_component_tables (xxx_send_package_data)
		|-> pldm_flash_components (xxx_flash_component)
		|-> pldm_finalize_update (xxx_finalize_update)

Signed-off-by: Shawn Shao <shawn.shao@jaguarmicro.com>
---
 include/linux/pldmfw.h | 38 ++++++++++++++++++++++++++++++++++++++
 lib/pldmfw/pldmfw.c    | 42 ++++--------------------------------------
 2 files changed, 42 insertions(+), 38 deletions(-)

diff --git a/include/linux/pldmfw.h b/include/linux/pldmfw.h
index 0fc831338226..5058a07a5ea4 100644
--- a/include/linux/pldmfw.h
+++ b/include/linux/pldmfw.h
@@ -130,6 +130,42 @@ struct pldmfw {
 	struct device *dev;
 };
 
+/* pldmfw_priv structure used to store details about the PLDM image file as it is
+ * being validated and processed.
+ */
+struct pldmfw_priv {
+	struct pldmfw *context;
+	const struct firmware *fw;
+
+	/* current offset of firmware image */
+	size_t offset;
+
+	struct list_head records;
+	struct list_head components;
+
+	/* PLDM Firmware Package Header */
+	const struct __pldm_header *header;
+	u16 total_header_size;
+
+	/* length of the component bitmap */
+	u16 component_bitmap_len;
+	u16 bitmap_size;
+
+	/* Start of the component image information */
+	u16 component_count;
+	const u8 *component_start;
+
+	/* Start pf the firmware device id records */
+	const u8 *record_start;
+	u8 record_count;
+
+	/* The CRC at the end of the package header */
+	u32 header_crc;
+
+	struct pldmfw_record *matching_record;
+};
+
+
 bool pldmfw_op_pci_match_record(struct pldmfw *context, struct pldmfw_record *record);
 
 /* Operations invoked by the generic PLDM firmware update engine. Used to
@@ -160,6 +196,8 @@ struct pldmfw_ops {
 	int (*finalize_update)(struct pldmfw *context);
 };
 
+int pldm_parse_image(struct pldmfw_priv *data);
+void pldmfw_free_priv(struct pldmfw_priv *data);
 int pldmfw_flash_image(struct pldmfw *context, const struct firmware *fw);
 
 #endif
diff --git a/lib/pldmfw/pldmfw.c b/lib/pldmfw/pldmfw.c
index 54e1809a38fd..15ba5f76043f 100644
--- a/lib/pldmfw/pldmfw.c
+++ b/lib/pldmfw/pldmfw.c
@@ -14,41 +14,6 @@
 
 #include "pldmfw_private.h"
 
-/* Internal structure used to store details about the PLDM image file as it is
- * being validated and processed.
- */
-struct pldmfw_priv {
-	struct pldmfw *context;
-	const struct firmware *fw;
-
-	/* current offset of firmware image */
-	size_t offset;
-
-	struct list_head records;
-	struct list_head components;
-
-	/* PLDM Firmware Package Header */
-	const struct __pldm_header *header;
-	u16 total_header_size;
-
-	/* length of the component bitmap */
-	u16 component_bitmap_len;
-	u16 bitmap_size;
-
-	/* Start of the component image information */
-	u16 component_count;
-	const u8 *component_start;
-
-	/* Start pf the firmware device id records */
-	const u8 *record_start;
-	u8 record_count;
-
-	/* The CRC at the end of the package header */
-	u32 header_crc;
-
-	struct pldmfw_record *matching_record;
-};
-
 /**
  * pldm_check_fw_space - Verify that the firmware image has space left
  * @data: pointer to private data
@@ -540,7 +505,7 @@ static int pldm_verify_header_crc(struct pldmfw_priv *data)
  * Loops through and clears all allocated memory associated with each
  * allocated descriptor, record, and component.
  */
-static void pldmfw_free_priv(struct pldmfw_priv *data)
+void pldmfw_free_priv(struct pldmfw_priv *data)
 {
 	struct pldmfw_component *component, *c_safe;
 	struct pldmfw_record *record, *r_safe;
@@ -566,7 +531,7 @@ static void pldmfw_free_priv(struct pldmfw_priv *data)
 		kfree(record);
 	}
 }
-
+EXPORT_SYMBOL(pldmfw_free_priv);
 /**
  * pldm_parse_image - parse and extract details from PLDM image
  * @data: pointer to private data
@@ -581,7 +546,7 @@ static void pldmfw_free_priv(struct pldmfw_priv *data)
  *
  * Returns: zero on success, or a negative error code on failure.
  */
-static int pldm_parse_image(struct pldmfw_priv *data)
+int pldm_parse_image(struct pldmfw_priv *data)
 {
 	int err;
 
@@ -602,6 +567,7 @@ static int pldm_parse_image(struct pldmfw_priv *data)
 
 	return pldm_verify_header_crc(data);
 }
+EXPORT_SYMBOL(pldm_parse_image);
 
 /* these are u32 so that we can store PCI_ANY_ID */
 struct pldm_pci_record_id {
-- 
2.34.1


