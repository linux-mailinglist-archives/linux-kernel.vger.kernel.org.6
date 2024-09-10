Return-Path: <linux-kernel+bounces-322322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448D9972750
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 04:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C6D0B21EAF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 02:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6697814A09A;
	Tue, 10 Sep 2024 02:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="H4HzObRH"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020087.outbound.protection.outlook.com [52.101.128.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F0D4A1B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 02:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725936486; cv=fail; b=YxnTXvRnWZjf6+Yz8+8sz0GoLBz09F/wRjCbL7QNI/t05YnPvw3sg77lqW+i23YU57cPUstn3/JyF6VTwkdL9Kep1NaFLpqRPS6XEStvFiqU3Tu2R/Y7YzkIxu0SsXHWNX62n7iedtSyqV0KPdez1gDG6/tkPcOcpFbkAlKnHb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725936486; c=relaxed/simple;
	bh=KGu7uGmCRg6E7ACUOM2mymlig7ItokM46C7qmw17CTg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=vFRgetv9vLWAYZx1paJKevLV2XTWx/qLDwlu/kmbw59zDG++on2gxkKLOxtyKUu0S9X2EzeYxii43J3yM0PewlPFDsfi78/NLMi/+9vlgAlG1KKuW1eNRqEjoKpp7h737pP19dkqjNsvWcvCNy9hv8qWwDxutKXLf/TXy+cH87c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=H4HzObRH; arc=fail smtp.client-ip=52.101.128.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i9cP5ayYnaB2H/894lDS4fRpZ6poUADex6ExcU3zbkXo9kmhC/5cvdqULoufTkpsRO1MnHw3KPEJdII3TSDBfqxd2xoJG5CI+rWIHgCoQtIF/8PB7E2y3l5n6TwaRT0i6WwykCEVUywm2hWCP0T4Xo8zFSIfuZeJfoFa8bp+pO3dVTM1Wn/5vwcHDoq7v7IhVbKPVXBhcv+EqhYfsRdaK0Vh8LXFJ3hMKQMPscJBuN0HWJ+HAdinIcxhafLAJB2QItmgErIMIkHqwh2nPw0kEcc8ZeUgFC1cioTgNiwEpiIp2uCD599u8kQaTOlJXzduCapPbngQz2RdMilymXljcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQh+2BwE5qvfVcswS2t/eGSxshRw0JS7/Zx8hJ2E/Rc=;
 b=I632yKzKpg1pJKZUBmMlAu6UXEScqJftkeZVsB8DF2tlOKN9rRwQw1XKXEkNFC7JZEuJKhDyVFTGDu1RRk/WXfQ4Gw8SN4aBdHpZeLU6R2Q3dh3aUyCTCeebRUq9ncCwrUis38rwZYCDZ9yNxb4/gF5W92V8zRRpvjxuGhL4HBvmNdt0vR2Pn0s8tnDQHSYxJ2+T3qmoCMG3i8E9UFDuVCCdLljiRraZVf4zVC3XgPoFGZ77bKUe/NRlVCXYkBJV1P8Nnoi7DP3NnO0M2RJL8mNuRKN3Ak/ma8koo3a17R/5G6hiUpUKBNEVSG8uHj0VflvZi6lQvWcJTGTt49zfTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQh+2BwE5qvfVcswS2t/eGSxshRw0JS7/Zx8hJ2E/Rc=;
 b=H4HzObRHZondJoR7NNKm1HCb8WMaTEv9l1eXTlJO70235x9XI30OFrUzbo/iUAvAxukfXpJ5jepL6n3HJkYFqb+aOdxKZdwOJU5Txd9tJ1gcKd845FVH6ns3a0uJ6tFABhoEG119RLcAFhtQVr8x36huN1MYY1uaqxnnLg2oWIBniYiZy1opYw5x+W1AuvSp9RUgAFRFGV0BKggVRyZsnnmy653hinTKri4Jnmi+FrydUtcWPKD8yCXSJS/Ms2iSB46XnU8zQqyTI+TZUaB6s7918yemTixtUw3/vpl4zjk1QrF1+rYRpFs4SfR2JXgjTzmjwM73FDE7nHDHDH9Sqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TYZPR06MB3933.apcprd06.prod.outlook.com (2603:1096:400:29::9)
 by JH0PR06MB6812.apcprd06.prod.outlook.com (2603:1096:990:4f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 10 Sep
 2024 02:47:58 +0000
Received: from TYZPR06MB3933.apcprd06.prod.outlook.com
 ([fe80::9b60:a415:f5ed:a367]) by TYZPR06MB3933.apcprd06.prod.outlook.com
 ([fe80::9b60:a415:f5ed:a367%7]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 02:47:56 +0000
From: "Shawn.Shao" <shawn.shao@jaguarmicro.com>
To: jacob.e.keller@intel.com,
	linux-kernel@vger.kernel.org
Cc: Shawn Shao <shawn.shao@jaguarmicro.com>
Subject: [PATCH v3] lib: Export the parsing functions and related data
Date: Tue, 10 Sep 2024 10:47:51 +0800
Message-Id: <20240910024751.1841-1-shawn.shao@jaguarmicro.com>
X-Mailer: git-send-email 2.37.2.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:54::20) To TYZPR06MB3933.apcprd06.prod.outlook.com
 (2603:1096:400:29::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB3933:EE_|JH0PR06MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e6c17e7-2536-48f1-a53c-08dcd142f956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CUswrgunjPA9qPD9VSXMVfsobRQ7M6M59n9FSAmW0QSxNRQv1idXklCZphjO?=
 =?us-ascii?Q?2g10eqm9Zr/Ia9izZnZALOQ2pNna0DOlOAJNc+dWMydqg0BqtM21qFtV3KPY?=
 =?us-ascii?Q?LfUjsI2tmK1TasC3Ibd7IoUHd7SAgvY9zvG88T9XU+F5PFEhbW/BKKiZVs5m?=
 =?us-ascii?Q?ZorYsVVMGss6s/hLDk7NvGKv+AzYZ4Uz1MOu0oONRr0ILNI5YYUxN36kaBYr?=
 =?us-ascii?Q?UxShfxO6gsiIFGrYlOuiKkT7JcEXlfkbYHf6tCPfkMx5ZUGZKn54VBzbL/nk?=
 =?us-ascii?Q?MSTKXT7UJrJsWJICank75kqutRrxe5oVz5A60L1+c+nzKdraZDlhhR5Zhzfk?=
 =?us-ascii?Q?6v9J/q70JUbkBaZ8O5b8l/JDC2OP7o7hFJW/Jml3KxTnyDrNLk4s46e2ohmM?=
 =?us-ascii?Q?cJU23KtosmNTm/dpw0K8Jv4pf1KPi44xWGzGLW0L1IOS2wxUecee+/RuOri5?=
 =?us-ascii?Q?ueIj6n7gQSi9mL3ZgwW2mu4RatzdTjznR04ILsLpGXzgF4tEm+Wz2edfiNWK?=
 =?us-ascii?Q?0kAWKuuTOf06J6cZK0UmkmyzFHfG/2dCFgrHo7Ucnf2zEWqvyvOn28TznSf2?=
 =?us-ascii?Q?kJBv8U8/0K6Rtqst64TX8JFgywWkeeYyPldlkXZoTX6AV2BcAV8l0DAbr4IL?=
 =?us-ascii?Q?4J2QsJknkUOYga7tMSQX0ZEjlluDvva54wlqYGrNEdZAIVTF+icYlCFLcbC3?=
 =?us-ascii?Q?zQLKKoddd2hAKXZs6nH0K35qBF7prtSRe3XkQ53n0GkXzK7WkOo0MAxziR5W?=
 =?us-ascii?Q?IpZ3AYDFObabRCd6O/BO1wYiJeYHJOKWQNrm+6ZHNiU096/KUdI3+pzm/tEu?=
 =?us-ascii?Q?rlz3fuY0QALI8jUu+L/6pk3jeNr8Vfiv5cCiNdrALiskNapOfTMGnBj0EnqA?=
 =?us-ascii?Q?5XYAYd8mbgRbAa5zS8otTSJdOLDxapwcI07ocRe00gweUz/XBPFXo3JhUIjQ?=
 =?us-ascii?Q?b9SjLfCdKUpqG1ZAeWGmNJlvJMXSC6AT6b6D2F82vxyY+OTBapH+Duelbh6b?=
 =?us-ascii?Q?I+sI4/8JbhJxw218rpfKoT4+3Qx4IQAEWIT9tW6dItIYK38NYww0pW3ADit4?=
 =?us-ascii?Q?oVa6rRyzLpOPR/9BVsDSu74ee+so6PWll5esmkovxfeeESnUhMjPx4xGwNyN?=
 =?us-ascii?Q?RU2eJNBuj6hc5MMjPA/B1zgwdww1h8ooMS7PxTMqUWzXXKLR0l+kUnGoaCO4?=
 =?us-ascii?Q?uhtRO3YCFTOrfadk6Mf/9FaNiO5RS7I2oN8OKmBDcyI8rAI0JXd0Q5gZKviu?=
 =?us-ascii?Q?w1TiJMF62HuZtWYhiGWzk6kUQkMzXQMu3V859bmHS34z/+Pfd6LMIeqoEjDG?=
 =?us-ascii?Q?jwUoiGCSN1SAraQjNMw5nuBP/rbs3IYRU0iZbO5sp1t+3YekVkuUW6SfW/5x?=
 =?us-ascii?Q?kLlu5EE/EH1z/EyNxVS5To7KD/2cx2O70datx9oJ+iv11mhGLw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB3933.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ve9dTtCnaRAKzS7RQBVIylUwOsEljNV+x8KGBv4yQG23+Hfxt5HEyMnV3PmH?=
 =?us-ascii?Q?IXHgNdmwrxKAkGbmhf9vKCoXezBtJkMxBfhM5iUAMMxQCOriASDoX884zJBD?=
 =?us-ascii?Q?o4ig8oxi+lZ+Y7o8BkQSK9mLobhi3f+1LEIq9ul2nvyi96MVI8Lalgo1Cyed?=
 =?us-ascii?Q?FHPQ4gOb38X/PoPvNSm9LDAxpGe6uydcIxJJZllVCdfmkPHSWk/PEm7CR6yu?=
 =?us-ascii?Q?8LX8EG4f9MbMQlZUniCRv9dy75iaDoeNCeTClIqFR3uAUz1lPP3HMSwN2mP3?=
 =?us-ascii?Q?CLmovlMfYPAC4jwI/b0JlXbEkKPWVHrNKKBZ3MnTnGBAQInke6plH2QarZls?=
 =?us-ascii?Q?tLCMUD6mh6wNrzZDzPQMa3DHKGGvbmlBmIyNbWRS3RvVBf4JIxt/TSmFOS+Z?=
 =?us-ascii?Q?JDWc0/AZxHfNCZDs4CfsSraBkaj6MvBNsLa3w7b05iS8JaPOQhZSxmraXTSi?=
 =?us-ascii?Q?7FB8xUVemhhgY+6MSweS/jGq1wovsGrHjUp5hOKxhN3MNlc2oJRXd4WFlFrz?=
 =?us-ascii?Q?Q3XKfP1SPNyA+xUCpAXGfBEDauvoT4kUIDynwjYOxVFfNJ0PtYGfp1d0dACm?=
 =?us-ascii?Q?NvLTboGI8Xeq6K3k6vWEAHm6IJtM0dM88plWfJi9fq3w+Of4ODGmvBmaTalC?=
 =?us-ascii?Q?cAueD1h5DTrIlYOUDdu6pwjy8hfoa/sXKnX8/VrHLcvnsSWqCiX/XZ39qBPP?=
 =?us-ascii?Q?zkskMDCWOWJELUvQ2ovGbcDyjygFs/INTvIr7Sw5eQBnupiIPcd4BhBQNhal?=
 =?us-ascii?Q?iACG6qqoMiAIrQ1V0qZhRsXlkfFJ9X2h3EjZPAgULJBWdHSBZszQYwJKGwcN?=
 =?us-ascii?Q?kZqsz9ZBKnTRYimUeaglbBOmD41d2eQXN+i+MkIFalHssx1iOdWT1FIB3MsM?=
 =?us-ascii?Q?44HkPGiXVayNsGmYDPwAouhX4dbrBLwKJLJjJcqBK0GMmgaqs1TTCV+tq8cH?=
 =?us-ascii?Q?SuJ6kCNRQg0f9oqvny5JcxJjTKlsvJ0Eu/SZXrepyhR8ShQdNbAJ45T3ApUX?=
 =?us-ascii?Q?8BgR7SppwUigIVYP0kp+EkkMLtcnIUQxNXGZQGMSOvJeavl3wj18lh36iat6?=
 =?us-ascii?Q?zAAmiO7E6qfrlg+R9WMgWPtZ+hbEb6eIi6JAxgBJ2Y58Fa6z6YdDIr+ndzB0?=
 =?us-ascii?Q?4GqOY2OmlX0nGlxH2dzoCrqzpB4jLSE+HrzPAbHGRRMmz1S25WB7V9W+jkMp?=
 =?us-ascii?Q?qRZlT1IdjAa35gCh3yv8x1U3zxo7M4UpGXFi7WmftI1b6I+3Jv25J6xX4GYM?=
 =?us-ascii?Q?2cihhVjbp+2BBwEtu5KVn3o08utMW6rEfCiavJMTuK/JcVbpZa7azswWt/ks?=
 =?us-ascii?Q?HpQz+PhyKh/9cEdLesy6lNT1akgwQHdxYjB5/qwptmLPmlDEQTH5zoLYbCvu?=
 =?us-ascii?Q?1+Z01hAe6t2/SRv3P4w6ln0EeLrcfgVo9SA0LKjpNrkWC0r0CjAO/GNiZIHs?=
 =?us-ascii?Q?cL7Iy6gLmMvQJBFBUD/a3JLYo50mSTZYMdiMatRM6wlGNshfH5ESue8aC5GC?=
 =?us-ascii?Q?cGrL5Dd9Lj3+YmkT09sTCvOje88r+NUvzf5iFl9cLm+chPG/M3aD+DM2baKE?=
 =?us-ascii?Q?vmXFh9In6TGapG6BmkgRUsdxMWdGFocgarlsxdNKrDQNccj2yCw3ZfHZ9pPt?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e6c17e7-2536-48f1-a53c-08dcd142f956
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB3933.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 02:47:56.5070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FXIYpWYMzGHT/uaRgSzkXvUKzwuGgxxNiDODDjC7Glkyv2jHjIWW9r4inydE/wIEnz4Gy7A5TWa5MnOYD6Eh6QSeoLthfaXSnbUG9ar+Ans=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6812

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


