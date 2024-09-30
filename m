Return-Path: <linux-kernel+bounces-343292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CAC98993B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 04:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B561E1C2093A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 02:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64C618EB0;
	Mon, 30 Sep 2024 02:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="hA1wp1yl"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2070.outbound.protection.outlook.com [40.107.215.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381353C39
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 02:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727663393; cv=fail; b=fz4AkxXH8DEcVR2N/G0sRgU6OW0pG/WYc1renStpjAoZWpEJibb8reS6V+M/xrkabA+/dAGPcljgedPs4uOX+R4Ds3lh0f8Q6rI/NsTLGJLuktw1z2X2yx/c2lu0Vz15p95qrAxp2JaVgFgkXE2i/2qVhmRftxsO1sd1kbYwlSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727663393; c=relaxed/simple;
	bh=aMaxBvs58w2DzQrJEdJ6pYnwZmyQIkMHlyphEvbnh7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZsAM7450zdQlULaC1foxg65KTb6DWkORr4KzNm+bWNCJr4RjoX72R4V7BR2OSDshb6RP7Hz0AwhzkH+IQ2x07qodE8czfym5Z8kD2QNthkVlYr8yqcsh+jHvekIWhhuWEK2SICf3RbEL2oHTzzjNLkkUB1gLfjhmbjeTjN7jaks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=hA1wp1yl; arc=fail smtp.client-ip=40.107.215.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xd4kbGnViYhnAXT4KUXFN6AmdW/wuZN4QztUovN5DcZr59c1EEgNM0H75al8r7/6IVbqkyHjIa9HBfNbQz86xkzQusE3aSFv2HXmM2CG4uOOzvY6ZGVrd1RmdFVRye4upsR8UlYfp11VStZHaM504dKSMAAXqzsL5E7klO1XHbWlIcrRr02rzS9sXcURcKXXlH2T0dLqBwDdzqELwZ7HRca6CUucBHLEGRAj+9NSXOGy0oBhhPt4JxLwj9ON+5OJJE6u2Li8LjmwOZscopB9eIKbTjsEDdgmYzfcIJTYj8z4H6MIhFBgMFkJvkPlBddwGtbzqe7BRMehwLVDZZCQNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpQTEDIXtNcrtAL5VhP0Uev5rSxdC5ldEl2/ba7Y0qQ=;
 b=pqlD/hrPOq7HB+wYUzFplBbJTN53QG2Vjyp5hkUaXmBo/mDXJFggGnicYOZM5u8E/eQ9g/WckqM7guXOecBYePB6h2x5Vg5gMweQ/ScQqvMvWgLIpi9U6crZgwcFSFOnzAcBczQn2XA5FhUw7oyMP1B2Vfdeu308NQsj9MibQ0NXZRW4MWji9zU/gTrCSan7IOG2F5i8aP334T2pp3cXM7v/m8zcY9BOKlOJc1VSjO25SBceYWm6BOqmZ+5JOB6Hd1BtU35TkjpiFbnJrSmIA6VvTtecuwUQeMFftVuCPwvFTerrIbLZtYQPf4kuCh5NewfxZJhBlbuVWD2g4c1pAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpQTEDIXtNcrtAL5VhP0Uev5rSxdC5ldEl2/ba7Y0qQ=;
 b=hA1wp1yl/9VA7yeJI8FtzwUKvcw9PsSG1xStMhtJCbkBdvRvDDeIUrADBjaEB0jZ5jj7aprCSYlrZZzZXB+xoUME0AM5RNZ3XdAxqID8d+yzl8kI5ZsPHKvTxvwevuRmuAqtJgmFdYj+nyAwTLclPoOS8fDlj+M61jyw/rSZILW/T/BqlF85wsu8sL02yJlGFtlvZvIW277od6ajh3GERU/J9lX02PndKu3nlMytSDG16nTKvaBmrnWBFlXCYjyy1VugA6+oIK+vMZ4WBm1kSOyumKjl6Qc1O3PqIz0ulGBiW/vi9a/ttw0L18GqVS1Z+UkHbR6tA2senyInG/8yIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by TY0PR06MB5530.apcprd06.prod.outlook.com (2603:1096:400:27a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 02:29:47 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%6]) with mapi id 15.20.8005.020; Mon, 30 Sep 2024
 02:29:47 +0000
From: Shen Lichuan <shenlichuan@vivo.com>
To: srinivas.kandagatla@linaro.org,
	vz@mleia.com,
	claudiu.beznea@tuxon.dev
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	opensource.kernel@vivo.com,
	Shen Lichuan <shenlichuan@vivo.com>
Subject: [PATCH v1] nvmem: Correct some typos in comments
Date: Mon, 30 Sep 2024 10:29:22 +0800
Message-Id: <20240930022922.7369-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0057.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::21) To SEZPR06MB5899.apcprd06.prod.outlook.com
 (2603:1096:101:e3::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|TY0PR06MB5530:EE_
X-MS-Office365-Filtering-Correlation-Id: 4407ea91-6e60-49ab-d57f-08dce0f7c0ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QeIvnov9TGSQrJoE+UszYC1DpoBxfImLPo2DruF81nW8Ks2JLwRlLDaWzGOb?=
 =?us-ascii?Q?0P6TbLsZWRMy1W9v7nmE2W8qaFI+imQUK69GNzf4DlqIH+laeXv75Z2CK33w?=
 =?us-ascii?Q?mP3pbS1irWZrF7HSFHLfh+AM8ZXUdWV3Gzx/J8vxySSetF1oNl4BY4+ZBYpw?=
 =?us-ascii?Q?qupFhq+W2OfCYqeq2IOmjjGM0Ilf/yLPxbpeLsXWIWTI3t5gOyKanww/ffEr?=
 =?us-ascii?Q?2PIOHliZ/NduGZ53Q5wfwcvXNLdjgD+6bA2WBJk82sYzRIW6MS6hM3EiKxWH?=
 =?us-ascii?Q?REMe9G5saYri6hZiKEn79Lw0MlZziRyQ8fGKT5qYpsmX1ul9aZ5AORmmsVlJ?=
 =?us-ascii?Q?Si3HkgHk+s1QcPnq3W49PwwXwonlw9z06bns14OJw4W2UvvCLhVRDhfFw/oS?=
 =?us-ascii?Q?8w0YnoaMK0/WuWhFZB8j5FXMWQgWBGtP3cXF2KQA5KVRMqAaLaCloYj13OBm?=
 =?us-ascii?Q?Yf8/pLi0QL6uWO7EBLMOYHkvOPblRIKdxI32M/jMnLPE/5VF1sk+48Ppxlmg?=
 =?us-ascii?Q?/BYIrLaRMw+RaIBWLeR/JqDGAQIuYdBn4D/irYZdruA967iGF2ap0exYsH4i?=
 =?us-ascii?Q?9O6jG9ZfR81piRHeQGmzh00PR2I6VHq84hY7OY0+CgOY6nRROPVHGstsB72I?=
 =?us-ascii?Q?xs93Aelu1vcIumS4rUlTSIrOpKu18A82BoRcnXuYX/Mx3EuVnZjBp0vzm2Z9?=
 =?us-ascii?Q?yTXAc3V1B7+0OPM5HBVuWLhuX/MJQbgaQAUO1TL6Lgb84sAUYlSPe0zO/T49?=
 =?us-ascii?Q?CROqoyjCzc70Z+0BPxZGPFJ/00ivbGpIaw+ASSdtx3waQS4CyPuim/u6aPvC?=
 =?us-ascii?Q?AKoky540wt7Q173Xiha+x8Co0e3MO1fkE7v2vtrwSfjxuX+xn9+ZbSnI0bfO?=
 =?us-ascii?Q?460H6NlyFJb6krnKlJut4TMYZxM0VdVYHkJFfrPXcQCZljkVdacg/ljZBbdb?=
 =?us-ascii?Q?fxtOYj46CSrHqDiUst/yjysX9jHqYJrVfghbisHoINAF6HQ+ZX/GjUeviDde?=
 =?us-ascii?Q?W98ywRGo5ajds7fjhxHwvM4NttXXxQzY8RJIlfcr417oOK2V9dm/IJFIzMpe?=
 =?us-ascii?Q?qPaAY5s9O+CXU2eypZGJt+guWBQWHRUuRnvuzGqImhS1NQwWY6KaI0z3Z9IF?=
 =?us-ascii?Q?zP9D3ygAOVJBbe2ZWIckmwVyWU6Wxx3bJ8iK0FITkIHRyw1CYD8DPlCKFtgs?=
 =?us-ascii?Q?Bw+aMjFc7Nyt//66A7gl9om/4FlrRfQ/ZRJv113kuT7iDxK4Jt2aXYs2/H4w?=
 =?us-ascii?Q?7pgZwu5tuYtYVj2kov1myUYQfS/9AZJcHIm54kKny0DtaO2BPfPwMngX1rz/?=
 =?us-ascii?Q?7RZxsxGV+Ay/ca8HgfWqeodgicSnhGhLLEpUPFsRxctKIw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dSEXDcrALDJb5zK/AfeBzZ4mo1AHcnWlqvYEabepOeeGu6UoL45DqvXE1sEe?=
 =?us-ascii?Q?7Gy2CRmdnwoyGebNzkvym7AjrO4ZmvYgY2A7vryWTTrcWKilpZdjlwN3HmaD?=
 =?us-ascii?Q?30kZKbw7CUzBIHttP6pZolMxUDEWh/iIx1S0L7UkDDoBUAART+xrk8ZW/1ld?=
 =?us-ascii?Q?pQv79n1BWmTebVBZEFpc6SJNV0Wxj2zppdg0IXLGKCYFr1gI5FQnagIbqoOq?=
 =?us-ascii?Q?OqlGNaOEPiGwbKf0pnu4wLzbnogLxzYTOrlxVqmSLNzmAO6admQH0qsW58pf?=
 =?us-ascii?Q?PWw2ORWnZsqZt2/T5vZn8CTeIQ5Y7MICweq0r/ddoeTtUE+XdH1AaMjN4flO?=
 =?us-ascii?Q?zvFwzXmKAYoFqu+SM2UWJ6rO7Lm1a25CCIdlGzrr2CG+1ovpTQxHbvA/pNN8?=
 =?us-ascii?Q?1X2l6UKIGt8easeieYMdIudKFyOiGMkOfjK9cicz7E2i/sfM4iMb8hT4MwXh?=
 =?us-ascii?Q?fBpaDjPyvgF4yWo81s3IK1LWio+QYqdBIhMLXVRz3mQhYr1Ump+ziRrMVAfs?=
 =?us-ascii?Q?HeKSdygfoTy61QxFrqagn/xFbPeGe8Uyv9asUF9ykJuqqYygLuCtBB8PfhZ3?=
 =?us-ascii?Q?Pzo4+CaKxXTunemFCQQ69iSwir9T8Q3t5lE/B09Wx239RFh6LDTBkhfo1saS?=
 =?us-ascii?Q?0zAGpm0FgkR+SXtjZgT4Qi9BIszZmkxY0oAqrKrNPBFeNK4+gnlMvMgiJaBz?=
 =?us-ascii?Q?g8FIc0hlcEy3e38CwmKi6e6T5RYZVP0GXbGR0QTXgVSq7ODyd01KxxzyLRcm?=
 =?us-ascii?Q?zLPxfat7W6c/DD+5dXX6f/j6n7y1tmOwDlaasibJ2rxGiG1elXqdItboweUl?=
 =?us-ascii?Q?dQURwjdf7t7b3tx7HbLK2hfG54RGD7uT/gArBPrlkxesRrzt3rAIybMbcWqN?=
 =?us-ascii?Q?SXPrv31NnQhN4tI4mhslxELpq6dWezwlKXrqA4yh/+1w7s8GC2Z54LqhsXom?=
 =?us-ascii?Q?2ScIt+6hJHpGOTL5vbnPL77zNWfbpQvwXUAsFF5uRXVLDZ+3ujQYyTtSjT5l?=
 =?us-ascii?Q?72UugOJhACqMjbyL8Ve+W42YVrfCWHX8tarvOvhVR6j4soeG4nenEWE8GTR2?=
 =?us-ascii?Q?7UAt9NUMizvZafeQ+ZeXnzCQJ4MVZS0sEmJxt4s0v8f2FpoHyTPUCCNDeHhy?=
 =?us-ascii?Q?FIxagqwMFRrttk1PCgrDnTg3z7+ftG4qJIK8y+dmFhnFs4e04UPNBjqKSKFa?=
 =?us-ascii?Q?hmHVZCIDBMGV2CeRhI+fgSOTd8BZ1+UErZJxrie+62iaX9rNJNkpYP3uODmn?=
 =?us-ascii?Q?Au2/aA4kR5Mk84mo5/guU61gG7DY2LODyHKFMuGJt3ZeyEzMh8/uDdvy/Dax?=
 =?us-ascii?Q?qu1JMzbCGD9TtDO0o8oTfTf/TLXTlrzUJ/lojcHmBDc/pWx/DZzKdsqTPesx?=
 =?us-ascii?Q?ibJO+oGnq5eRRXbS/lO6SzpKmemCcr6RXWQ+ExpdJY4y49bKHIKO+6JmrJQe?=
 =?us-ascii?Q?RnYMjnqRAvEpJlJFBA2lqEHB8MGx2LfeoP/sC24hgANhm67HQ5dAyh2UHQkq?=
 =?us-ascii?Q?MbbaO9tgFgNtDu4FSS3SPReU3GC1A85LSCRDooY1zVgdQZ/unxowLywN4k6R?=
 =?us-ascii?Q?C748MBMLL/sB12CN7GyJAvp2o9lWyRYbYO+ypkP+?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4407ea91-6e60-49ab-d57f-08dce0f7c0ad
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 02:29:47.5790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFT8r1O3Oix3AooEaJ+EEy4zna6+GknxFnYUJug2l66gO1l7kF84pYNPggBl6m3ECfsnrLwUEADefgb2xcM3sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5530

Fixed some confusing typos that were currently identified with codespell,
the details are as follows:

-in the code comments:
drivers/nvmem/brcm_nvram.c:25: underlaying ==> underlying
drivers/nvmem/core.c:1250: alredy ==> already
drivers/nvmem/core.c:1268: alredy ==> already
drivers/nvmem/lpc18xx_otp.c:24: reseverd ==> reserved
drivers/nvmem/microchip-otpc.c:159: devide ==> divide

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
---
 drivers/nvmem/brcm_nvram.c     | 2 +-
 drivers/nvmem/core.c           | 4 ++--
 drivers/nvmem/lpc18xx_otp.c    | 2 +-
 drivers/nvmem/microchip-otpc.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
index 3d8c87835f4d..b810df727b44 100644
--- a/drivers/nvmem/brcm_nvram.c
+++ b/drivers/nvmem/brcm_nvram.c
@@ -22,7 +22,7 @@
  *
  * @dev:		NVMEM device pointer
  * @nvmem_size:		Size of the whole space available for NVRAM
- * @data:		NVRAM data copy stored to avoid poking underlaying flash controller
+ * @data:		NVRAM data copy stored to avoid poking underlying flash controller
  * @data_len:		NVRAM data size
  * @padding_byte:	Padding value used to fill remaining space
  * @cells:		Array of discovered NVMEM cells
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 33ffa2aa4c11..66eec1960801 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1247,7 +1247,7 @@ static void devm_nvmem_device_release(struct device *dev, void *res)
 }
 
 /**
- * devm_nvmem_device_put() - put alredy got nvmem device
+ * devm_nvmem_device_put() - put already got nvmem device
  *
  * @dev: Device that uses the nvmem device.
  * @nvmem: pointer to nvmem device allocated by devm_nvmem_cell_get(),
@@ -1265,7 +1265,7 @@ void devm_nvmem_device_put(struct device *dev, struct nvmem_device *nvmem)
 EXPORT_SYMBOL_GPL(devm_nvmem_device_put);
 
 /**
- * nvmem_device_put() - put alredy got nvmem device
+ * nvmem_device_put() - put already got nvmem device
  *
  * @nvmem: pointer to nvmem device that needs to be released.
  */
diff --git a/drivers/nvmem/lpc18xx_otp.c b/drivers/nvmem/lpc18xx_otp.c
index adc9948e7b2e..c41a0c58bec7 100644
--- a/drivers/nvmem/lpc18xx_otp.c
+++ b/drivers/nvmem/lpc18xx_otp.c
@@ -21,7 +21,7 @@
  * LPC18xx OTP memory contains 4 banks with 4 32-bit words. Bank 0 starts
  * at offset 0 from the base.
  *
- * Bank 0 contains the part ID for Flashless devices and is reseverd for
+ * Bank 0 contains the part ID for Flashless devices and is reserved for
  * devices with Flash.
  * Bank 1/2 is generale purpose or AES key storage for secure devices.
  * Bank 3 contains control data, USB ID and generale purpose words.
diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
index 7cf81738a3e0..df979e8549fd 100644
--- a/drivers/nvmem/microchip-otpc.c
+++ b/drivers/nvmem/microchip-otpc.c
@@ -156,7 +156,7 @@ static int mchp_otpc_read(void *priv, unsigned int off, void *val,
 	/*
 	 * We reach this point with off being multiple of stride = 4 to
 	 * be able to cross the subsystem. Inside the driver we use continuous
-	 * unsigned integer numbers for packet id, thus devide off by 4
+	 * unsigned integer numbers for packet id, thus divide off by 4
 	 * before passing it to mchp_otpc_id_to_packet().
 	 */
 	packet = mchp_otpc_id_to_packet(otpc, off / 4);
-- 
2.17.1


