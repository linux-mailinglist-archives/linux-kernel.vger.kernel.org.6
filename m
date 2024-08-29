Return-Path: <linux-kernel+bounces-306751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789189642F8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC831C222BC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945DD191F77;
	Thu, 29 Aug 2024 11:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="SdtYhD6L"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010066.outbound.protection.outlook.com [52.101.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DF822339;
	Thu, 29 Aug 2024 11:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724930937; cv=fail; b=AahxYI9nZb4mhcxFfaRdPH21Ko/EN5TYHku9Wts9MS/Tor2fBibgQ5KtDHKoem0SC5uwUEUVWp+8TfSVs0Iiwe/PUjq35b/q73BNSmmcByjo8Ot7M+7UDBFW3j1swQl/K5SMA01ibXvLvsLtkIceHiHieS7CSiYnRJSe+2Gzp/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724930937; c=relaxed/simple;
	bh=vL++GPCsZroY/ZjVwBMGgQJYHkv49yy3HVcU5lgeIlU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=eFeh6/UzNZfNDlDKpOz6ULpONUoQNDH9PODZtSzofAYOozsVPIT59sgYbZ9R7o1uUWtkZ3K8d1mAwUhggw1KtULThPkRmU5SzUOYKbg3JpsRodMdG/C8aFb/j8ltKyRY+NXQ3zgzKj1btDO9A1OepZ4+dW9nifrGxMk3Q/HK9vA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=SdtYhD6L; arc=fail smtp.client-ip=52.101.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcBRU5zXY/A2IXglcrDqzW1AbKmOJI2sqW8g2X0gSGrxmlaUZBtmwyZGkJEBOxvWMSajJwAcYoXHeizXYjDDCds6xfZlJVJt6/a8w1+ZLF+4h7VqxGC4BT1x2R0Z0Xrt8Drtgbm8nep46zEmoV+0oustcbxYRDsjLBaHAmBjyUaSjS7k+cNHvO4x9LTGobfb1eXYhFCZc81sZx2siwqQI9ZIX218lxwpdozgErfSWhPAX+LAYYNDbQMLAWCefC46jibugQEOLcwk7HfHKxRrW/AStpzaRgoO/kX9SjEEv9EWPKoDkSLFGY3HZhyDqfTYINxjoNGq5E0IYk5goN3lIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bI/AWi3BmnGtWg+SuNmDC+TgzdLsm9n1q2LtAcNwpcg=;
 b=AD3TbR94qtSqus8NQXHPRF1yyBsfI08Cn9Gb0nQmRIKXXFg4G5fCyMPgVc9HPZoJzMuFMrzsXHDl6lUooyZtO3Aqurp6LrPZlIiDikjP+mP6bPf0FbDKhKTMv9aVnfqI1FzrhLTf+WhqeBxJrsi0CDfsCHv3FxYHtVlIA76432pshVwb3Mg69I8sGS3qKn8ZjZo3X1WVwblu9h0A8d1McdOXCkEvYuQujWUxNDOV0vSYRvsBdXmmsA16D4G+axab2TqlYrKWAxcb7MZunOMfAzygWHDM8n5dPtPY4wg6MFZ4WBrKulAuOh1imgS5KlediB8M/U908+bUrhlvvnX8uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bI/AWi3BmnGtWg+SuNmDC+TgzdLsm9n1q2LtAcNwpcg=;
 b=SdtYhD6LVejHez5Y+r2VCfW/0NcXtgcupDsy4LuXbfvPrx0hzw8I2py2gBKP997dL/4cmCpFKR7af947zxr6owYJO+mNWEI5kPewYUr6C7yaox6lK9NyLLCWlno8pDo3wa3vFR6SbStGCjd6h/ly9XjtA20Fe4ZfHXN1g5RP3+/AZGTSAK7n0nIe4VkPW0/Q06Y4GhqjaxG2/EGP41ZC7tDf7U1dWXc77miabY0IA6O9t/fmqTKjVSZd+vipOrT5jr2U5AyiJx7w1VDGRzIkMCl33yzQpIA7pM7M4LUiNTPSkSi45j49/0Dh9RPWpqiSAQbdE35GPqgbfBLG2mjSNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by OSQPR06MB7156.apcprd06.prod.outlook.com (2603:1096:604:293::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Thu, 29 Aug
 2024 11:28:51 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 11:28:51 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: pawell@cadence.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH v1] usb: gadget: udc: cdns2: Simplify with dev_err_probe()
Date: Thu, 29 Aug 2024 19:28:22 +0800
Message-Id: <20240829112822.3193428-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0090.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::17) To KL1PR0601MB4113.apcprd06.prod.outlook.com
 (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|OSQPR06MB7156:EE_
X-MS-Office365-Filtering-Correlation-Id: e6f5837b-4b39-4d44-0fd9-08dcc81dc172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D8SVcthjcsnoNX4vKbDO4NcxyXsFF64TIRNyJz/XLZN1tCHY0zsj5mmjpVqs?=
 =?us-ascii?Q?66MP0JdQWZTPR/r6djCg5xpV5elko9UkuGfBA4zyVGnjebNwOiWyusdO72Ci?=
 =?us-ascii?Q?wxZh2a0P0ufUrzM0gHqQPzRujNNFhlySdcd0DEqfZ17qmCqwgYBiRw7upydt?=
 =?us-ascii?Q?IU4NeIjdOA2pZ2uTi/J6Ik1PgTLy3XL8Fh5tyAkfQkco/LYNDQ8H56yIr80E?=
 =?us-ascii?Q?OD+JmWWPWJKupCJQRfe8Uo0Ih+RtWqwcoXaoEmETDOtLwkjtKzUy+Pk2JvIw?=
 =?us-ascii?Q?2ppj4sebRirL+H9XHe1sHsHWuiork+sDOo/R1EOqZEctuiT+ZUHi1zepOD7U?=
 =?us-ascii?Q?CDmbczGDtz44FPpij+clH8Lf6Ib2FuScLvQ3uV4EWX3u4gO+gcgM7WDriFkN?=
 =?us-ascii?Q?dp9H6uWx2ZennSZ5KA3pybcOiYn3fCAZt2c5Gu+LFAWnFvbQhJGnqqeNeaJK?=
 =?us-ascii?Q?mWyhpNpZEEcKAt+YqZyBFPBgkYTMZpQlM2lWWRKZYHZh1KwRCpKZ2BzBi8xv?=
 =?us-ascii?Q?OIUb8E/N9WMt2wb8duX7tD2buxvBR+Mf3b2ugDR3Uf9cU8SpKTBTILW6lsKp?=
 =?us-ascii?Q?/n0/p1mW4JpCDCK6VYQYMnv8yCLOq71H7XszxY2ExAqoVgbpHTKi9WnZ4+K5?=
 =?us-ascii?Q?XNVMQv/z5s+OP0yrU8877EFH1AXcu6JtnRSOm+oAJ6byv66V1HbVQfRu9ZvB?=
 =?us-ascii?Q?IV1LrrYWs7KsGOIvzZUT/6F6/K61T/PtsEWWgEDgFhPz2pc/qLR+6S5ewY6z?=
 =?us-ascii?Q?gc8t+rfKQvd1+NlbcEXEgx9Pmu/7C63NC7gM1eMS55+WSC7lC9pjUnl9Cf3i?=
 =?us-ascii?Q?NgxrZHvCRT7yaWj3yV9Z2ee9LXVeg4AlkKDMI0KNHw78p9k4IjVT5vIgIli5?=
 =?us-ascii?Q?oA9G+sZRGO4RJLlZagi7AUFnT8jqnTcIEpFXtKRbZsuiAU/wu8dKam+wC8dl?=
 =?us-ascii?Q?YhWwOeBQa35z8mLoARSnv3eMlHGa3dFCghryPfQieVdTWkUyhuqNakmT+gVa?=
 =?us-ascii?Q?hpqC3En/2tkRCVFgVzHM89rLW1vwka6hmMARu4vBMU3NUJd7aFuOA5+8XMty?=
 =?us-ascii?Q?QVMitRDwj/r+2VDKcJeR8g2Z6AvMzAGqbQ0kHE+GroVdGxTSRV/OX8Rsqrr1?=
 =?us-ascii?Q?cNQNtoRCsQq4fNiV4nPjLZBbYw3UHWCG+549rB/mHwlVBqHFyy9MGNWWJhm4?=
 =?us-ascii?Q?u+8Qc3kMNpimogn2aSPrV4eakBNUxbCOMzWN2oCzRNZPmkHB8EESfThrW0ki?=
 =?us-ascii?Q?GVzaCgYOXUtWlhDhwCH0NNA9XfZHWQVdhcj0aM7GXnno2pPVgVQu3idibBeK?=
 =?us-ascii?Q?6E+GeJ01umgdS/Tli49lyXg9nQegNYP3CvFEIgnErY6EtHpAORB/bgUynGxe?=
 =?us-ascii?Q?/6qQexRGhUNW0fWbm1MKXoW5jCtK73DZPjOjO5bIqcLQVm4vKg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lb99nUuv8TotkcJcDN7BCW4I7Z+XPiGTxXUMS1H/7LLVj/VjVTd9MAE4i+dV?=
 =?us-ascii?Q?IlIH0w+obN56BdO/R3Kr+Js77bYmASnvQQIOMjgBTddf6n9lGvFpzba9ojDx?=
 =?us-ascii?Q?pVcMPLcccYJO60swXhMZD4h68QQhRaHKW0CIdkgPpDP5eVBovFmkHbi6psPg?=
 =?us-ascii?Q?X+GfAN1R68xCzDWU6Ua3lW59qBQiXzqGVfw1etn9p7EwWU9gMuh2snrfmCbi?=
 =?us-ascii?Q?ggSKkGjp8OmHlwgbAl59iaSE+TYQMyzMiYXCVK/ESsNvUSypR7bsGZuK6Wds?=
 =?us-ascii?Q?jOEgE7+xD6+jpkQFTJxWGb5p+dBXb7HQv+O9BlQwq/qzg0aoCTi0al2rNWbw?=
 =?us-ascii?Q?orlts/i3RQjTUMSR3nT9/qwN7XcsDltAX+SXXQ7wn50tmevkvQ/mgpR3p9fB?=
 =?us-ascii?Q?s31bw9r14tYOTjRR/sZ9PX5ZU4DQqZwU6s62dOve2S7tyATRYRTKKNHU2p+z?=
 =?us-ascii?Q?eoZ1tb0dqvaZRZ7o3eIo8j2ZE8XrQ701EWEy9RzJngJcf2QFLPZq0nhVv5HW?=
 =?us-ascii?Q?Twl9RYNMiEa9njvlfjH8FBJvnMMpnmhqptpI8z6Lj2tHjUBV6jmy58XCwiOO?=
 =?us-ascii?Q?2E2wIbWz+8pr5NUO7D9mz/xeM+rSg3TXAqKDSEJu1DBKTjW+s3NaqKfpJyhr?=
 =?us-ascii?Q?2YrmrSE7gpET9vDeEEYoKZTB6z74bYostqF7OMEdGOZy48K7YVvw2gY9l/7u?=
 =?us-ascii?Q?VLBi5atX3PovrQ4cixVpBbWGPiBCr7ADzEW2OJ4arRXw69LgfWYrU6NkpUJe?=
 =?us-ascii?Q?s9ucJO4p5kYRLM8uZhe9QXi9ojlpUYNx+r1vYzhZui92tDSWZYJeswJpC999?=
 =?us-ascii?Q?b0551xSubwcmldNimTANN5WOPR6AP63iboRzZRw3d3r/INeTGFsyBc2/HFDQ?=
 =?us-ascii?Q?3v5/lASVnXXI00A/OJVqyXkYllbY88HxDPtWmN6abyCFw7DatpL4wUREE1o2?=
 =?us-ascii?Q?IvdIU0zvyFl413jaEVq19iMMgpi9ZoHL+95CjjsT8+jcIrnGutjkZG23RcLa?=
 =?us-ascii?Q?HUqZR/LM4VRob8/wLcbTqhHT96Uw3lJUZSvfyS4nShAzwlxvvq2UqeoF78+R?=
 =?us-ascii?Q?hnJE6Ng+ECcDEnNUl3w8aN9oIyluCrCa+NQOlZcmo6uAbgQ188fUKi/L2CLh?=
 =?us-ascii?Q?gDdLyffT6hJimtWRitKsvp1GdG08vuSYTZ1rJjA2Z0nzCYLhP2OCs3wZALE4?=
 =?us-ascii?Q?lYW8CKOfsZX/Lm2AiEgTkIxYC7jLFxM8nTthdIVAxvL/m3JLTLs3nLVIbgB/?=
 =?us-ascii?Q?0wm24Ksbi4rWln7rncY08m4T78V9vwCAG3MxCiGunXufydMm9kHQaiFzE9Tx?=
 =?us-ascii?Q?SE766pX90HgZZ039WQuu1YRH/Gy5InsUUslny5cQD9sHyOPIdBllljtLjpzt?=
 =?us-ascii?Q?eBdbc6ZJWqGLcLX3SQMkPPdPq48mbvLms6roHE7D3FC6ofHobTaCUFjMzX+r?=
 =?us-ascii?Q?PigvDSEzsjTFCm2zNJTgim7+ZAIEBtxqWZ4xZ4COBwHBrYbG9lojoL9Yag/j?=
 =?us-ascii?Q?9CRhJPrrAEy9A2HshKFZwztFihxFpXXtxHslHULF3cS4b2lH6vWJZXin1Z86?=
 =?us-ascii?Q?ybO2uvWg9TCvCGNO6fI91q+653yMPhszifGOV3q1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f5837b-4b39-4d44-0fd9-08dcc81dc172
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 11:28:51.4053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBlvp3dEEiwrnNmxLUkxLej3UN544L6WfcB8oC0BYqGiYcy2GjVAWF72z58FzAN37JVHtAm/xsXmKxPwjOx0Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7156

Use dev_err_probe() to simplify the error path and unify a 
message template.

Using this helper is totally fine even if err is known to never 
be -EPROBE_DEFER.

The benefit compared to a normal dev_err() is the standardized format
of the error code, it being emitted symbolically and the fact that
the error code is returned which allows more compact error paths.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---
 drivers/usb/gadget/udc/cdns2/cdns2-pci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/cdns2/cdns2-pci.c b/drivers/usb/gadget/udc/cdns2/cdns2-pci.c
index 50c3d0974d9b..0e904085d968 100644
--- a/drivers/usb/gadget/udc/cdns2/cdns2-pci.c
+++ b/drivers/usb/gadget/udc/cdns2/cdns2-pci.c
@@ -35,10 +35,8 @@ static int cdns2_pci_probe(struct pci_dev *pdev,
 		return -EINVAL;
 
 	ret = pcim_enable_device(pdev);
-	if (ret) {
-		dev_err(&pdev->dev, "Enabling PCI device has failed %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Enabling PCI device has failed\n");
 
 	pci_set_master(pdev);
 
-- 
2.34.1


