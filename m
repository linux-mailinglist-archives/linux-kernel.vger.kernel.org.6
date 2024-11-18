Return-Path: <linux-kernel+bounces-412343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEBA9D07D4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 03:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE2B0B21E28
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 02:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062162907;
	Mon, 18 Nov 2024 02:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="C4ae/oWr"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68A21D696
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731896347; cv=fail; b=H3+K7jwDu1JEiMn9iD1WbtStjXfCjONtNnbGF1JSQ/XBhw+tbL+FZdrQv6tsy8MFO44lA2OyauqACyWufZFfSLZ3PqusAF/r4ytX29l53HUuD6l+ras0vut8e1Pn1jPLKPfkntG8bY50VjYSHkWzWcVyrFNaGvkC9O2ddWi6B2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731896347; c=relaxed/simple;
	bh=hXUn5VrcA13QHO7UZd5vbkPmTMirfT8tuO957ZFViso=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PjtxiZ6KEIBqB2RO4T9zUgAUfRZC6Lf73YBuCm6YnadWyQh2ZIGSfceJAJ/penPbFVNI8fk4X8A2p+OC8oJe9f9ZeF+CvmC9yN+eOMCJ1D0um13jxJmPet7A0ssaCRGz438sJ+0482vqMX6huV79pPT+CMejBHONBFd297ft0U8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=C4ae/oWr; arc=fail smtp.client-ip=40.107.20.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WOCNQ6LYrtFw0iLe6v5hcOUSGK+zx4J7IPN5fEo/GT3AQ8PYBio+XcELdaB3oAK3RpBUyU4P8cXB14NF5C80q0gm2lkirLEWEtwiG6kUcDKRYh+PfAOp/SBXKuPKSpntPTpsbuaOZm7m4y4bed7ZmzFxNMOyxPM6xowHAtqRra4oE6RlYUO7rLs4H4kE6s40nZyEr7j90tdmeB6sWBp7Nf7L9uL7L9UVKSo5JJMYycwpEb0thw9hxkD+xx9XKUSiVM0lgTanqhGpRKmN1YNMkcof1jUxyFWG0tJ57P95sKASMSKVEZGfPvuGebRfj1yLcPC6OqdsJOSf2u2NunE8cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNTMjPt4AYPGKA9Eesy5gEC3dQkzdfBH+5BtdUNs/hA=;
 b=VK9RHQ0aSNT0Ob25+Wr3vTmFPzD/lFddHsWeb6hcY7/IyZ3xBWLhGL0IaF9ymmRZpoaW39/esDFaF5FiJS4yxbd/vQMDYX/6Lkh8hVrS8lNN2b+u9yzrbo3y8go5tFc/w7jDA5/9DG0hjNhTuew6P0sFUGq58xaPAUzHhPGVuWX5nKeTiw7Dp1oQaog0EFJL8/4QBJ4b39BqBTDGOf4Cnf91IgVuY7CiqbTUy5Llu9TT2UbaunkfUvXTty2YxbTOFojSHwhcuBJGrAlZ3lROry2ZzNI8huaUjDqHzO4aKYu/HBCQ7bS8S39zU5Lht0l8OQFHKPPbm8afXzHmbA7AYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNTMjPt4AYPGKA9Eesy5gEC3dQkzdfBH+5BtdUNs/hA=;
 b=C4ae/oWr/HtzzDvQ52ffTXp0tRWAlCCDc6y4FzxyQshkhC7R3kQnfHAWJuWlGOKxwcQkFeiBOcxkr204RYdPDBY5ES8VntDjgKPXiXCuqmQFsR1aBIMacSzMY375o2SoeUFMbs+Up4Ghctm7FfuFya6muj1sE7j3/8UiVY6pteiORQ2r3RO2SYyfD56wu5HqwGlwAcsQ3R925bs+qrFTNEpXSPJP/8U/yh0MK+oxttOzRKuw38mf8OBc28R9F4n2tRaawXnPzVoqmRaKkmfv7h3XcOQfPAXKiK3CLqtOq245w8PXb3TWq/UZrF/kI6WQL5ZIvXHBqoIxzTvSVNUJzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM0PR04MB7009.eurprd04.prod.outlook.com (2603:10a6:208:19b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 02:19:01 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 02:19:01 +0000
From: alice.guo@oss.nxp.com
To: alexander.stein@ew.tq-group.com,
	wahrenst@gmx.net,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"alice.guo" <alice.guo@nxp.com>
Subject: [PATCH v6] soc: imx: Add SoC device register for i.MX9
Date: Mon, 18 Nov 2024 10:17:16 +0800
Message-Id: <20241118021716.396001-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM0PR04MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b476bb4-dfab-467f-a6db-08dd07775d72
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rh03rhDkGk+lcIYEKAf7eTPYD7iRl6K0bPSqjCwBhRxJJy0KkV9VBLS4B7e0?=
 =?us-ascii?Q?6/az9BWVGER9oBDSwl293czSALwhO8/bRkCzILsrSt45vbyQMYO0eK5plY1Z?=
 =?us-ascii?Q?Qy9RsHZkWz39dbRLls3+WSVSmbLD6EouWCWV3LLfiIVKJSaYEQWMyYvhYglZ?=
 =?us-ascii?Q?dGhzYwgxJjHlaJkcxOP+zAiaz2RpGsTZz0wXx0BpXgPn9IXOa5bY3dFLBG0/?=
 =?us-ascii?Q?5Puey9Lys+ov4aA0NRInAozfHskQ7G+d7wBtbEyLzJKzWlFB35ccAkC3qFrp?=
 =?us-ascii?Q?pGrmBtQf3LiF266rSnGUde4I4zH/kVasnML6cIc9QwIYrIdmFQsCZG/JM+G5?=
 =?us-ascii?Q?NHUcQKFGasAIV26I4JOOpTAUOHPN3aaPhQUh8PufYRKF9lFQdKyMDDTSF9GG?=
 =?us-ascii?Q?bTGfhdYD/6zSpCGKGeDHQ9jdXLawvnVMJFLGV1idwX3KELhMFEnp0XIXXk74?=
 =?us-ascii?Q?4w5KvOf17KqXDoJ3hI+A8SwbD06XwwFkf7frY2qvXsApNOqoHqYcIIWJxgJP?=
 =?us-ascii?Q?0hTp4FPZNceKWjy0FRsUqvaSC9V7zEdumfXGjmqYBt7lqsfPmXnngg9W9Tjm?=
 =?us-ascii?Q?zHoG5hqelN4KA40rjr0wQ7O7T/O4jhAoJmkcaQPh5en0t4VU4T2Vj8besNJO?=
 =?us-ascii?Q?OrEIqVsu2JqeHJZ2DnKqSbJLh2kYrR22USbjJqp4M+Mf0MZCIv4NQ+jkbJVW?=
 =?us-ascii?Q?qsuldAqxp/FmzEmXM6+WW1iPZ8ovUYcHwJNITvcCjiIfLHd8CgMGLMHanojt?=
 =?us-ascii?Q?pzBJowxRvHWRQ8wG8rd86/moWGASV6At6AilJuZ1jZSoa85Wi3qQUyTliYeU?=
 =?us-ascii?Q?xmhw+tsysl42hFbonZ39nbgfiMrmQ/Z78ukB8lHgCvyrumlooNk6p2D8xi81?=
 =?us-ascii?Q?C9GQ9g5cO88U3Ns/lWYD/hH6HegtPonvpxgTrpPlgvir3+9WBnUtDTh7H/Kg?=
 =?us-ascii?Q?gT9q9kukRd+H3WbWm3x14AlYUJ3FYk5puWXJtk5k/TV5dYnLBuiTXu0ijj3w?=
 =?us-ascii?Q?/RPFcGOlvCxPuoZbd9wiCDYCV1rvTgtB7hiNQpGNTF/pwIGC8wvc9u15+mRg?=
 =?us-ascii?Q?OM+3gif3P+JI8ICWxjo4Z0LmmzUEsdFDzJH8hf/2JyRIIEutuySIv3HiYm7Y?=
 =?us-ascii?Q?pDcVRXEkgzfG2T56jjzdJWmGTFwnuD7Fa80i3Ij5a3moCOQXtqlFAPwyjsMb?=
 =?us-ascii?Q?XiQJcr2L5f5TyiWAlpHvOhoUGClRA+3klCxsXQf2VpDGqm1OOXrE5DBPuk1L?=
 =?us-ascii?Q?BsYmztCVBQXygzm69pmazNA+b7O9PK9NlBX4IO6dx+lx7detrN3/B4JbEQIM?=
 =?us-ascii?Q?RqABW5OgsZBH1ZiqkiRdbUwQfY8/1JE2iA1lijGw/I2YuG6ImpfRwP5M7jLb?=
 =?us-ascii?Q?XZi+jSg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uSw7Er7BdeDhI0yjwjHu08rvmDGzRdZW9AQ9/xdFLGd5bXl9aVgIIQYlII4m?=
 =?us-ascii?Q?miTK+3Fqqo0VXHqXaSTKLw7FLoe3zhxHzhoIwMw2WzJM+rDwY6uEE4CqYKdu?=
 =?us-ascii?Q?6kuEgH/J2I2X3YRrDEohzZ2pvmY4aKg/puvGQdZBX4NlBkETiYxsx07nFHef?=
 =?us-ascii?Q?eLBqjQFOPLtwHku6C3P5Y5NkQF2umbAa6ZcdnuO7nIc+y1Ez5VKCx67n9sbA?=
 =?us-ascii?Q?sdPRsdlEvCDxpGvZ9NQC9epH2wkINb7QjlDkRRWJs1YMbpOhSRUUKOkODU6u?=
 =?us-ascii?Q?/JgAkPiMy9dEJxXzb52BGqPGjIg1PYr6QcQ2jVLPWRDKW0Yd+7+EVVagZsI0?=
 =?us-ascii?Q?cCLWSSeHAER/Jd9XlbHl8Pjdvukclj8M2S+o9TwNF2CW9q1Wq7GG2kR0JGHd?=
 =?us-ascii?Q?hdBi32cqsMVjcUB8xj43GhKzwqxNOY63d7Ca0ucdBFHJTQ1Ybu80ExbnjbaI?=
 =?us-ascii?Q?rNftK3Rj9Nwx1OSjupFZjx5rWZuwceJbxSJVRW8sc4zlSyrNB8Krs+B8NTXp?=
 =?us-ascii?Q?eIsi+ShWxOFRsHjM5QiOnnsH3BIm7D4F66KC0sGsurCrgaQmjJX70gj7Sjzz?=
 =?us-ascii?Q?+AlafGhpmr0k4d2E6VwA3id/HsDijskl1XE9vsy85vcZc6OEKmulizIFtOQY?=
 =?us-ascii?Q?Who62rIAj38QGcS3Xpi5o+WftoI9ZU5jJS6NVn25bheVGDcb2Mnon56CfI86?=
 =?us-ascii?Q?KnaVrA2Ye8likLfwRAC8f2H9zGSNfidpBrqjOJDKzdMtmZFg2oxzI/zerzZ6?=
 =?us-ascii?Q?ZnWOc0eyt9mvWClOuZ7zYsXGUrsTX70yFNvPEojGj4MUi4yEWMHKsO3F8sDC?=
 =?us-ascii?Q?ATn1lAPTDnD6Ol8wcH39yIdFZNPOudkZYynbCc5+oRojpkqwg3p0P7/v9Oq3?=
 =?us-ascii?Q?l8IvUwjn5s4lMtjnzu681F664ZLKUq0AVmAj1suyPKw/3PDLVmuzutgdyYyG?=
 =?us-ascii?Q?DuqnD2hR7+HItXKJiJnejWreJAURMS5y+9Tl6Kia4BHuD8hEFKXBRL/o+Hnf?=
 =?us-ascii?Q?Exbn+XsCdzQQSf5VsWHPTmZhhJP+gto+aMuOsGChacQeK+zRq7g/rrglSEYh?=
 =?us-ascii?Q?vFLQh0Wlv+7XByQH1PsM0mLvORDwZnMHHu5pQwxQq9BtVN+WFYfgRU3mye7r?=
 =?us-ascii?Q?Mg/OaKpW/99TINsUVPYQ0WtuovBeSvxpYGdbxlC638NBXDFabwf0xtC7WBFp?=
 =?us-ascii?Q?SInM/s1TP+zDoj/OJpB5gZoFHbjoAJzYsKyT/HMizfthij/i486dYtwPAqWb?=
 =?us-ascii?Q?h+yvTQ0fcJphEigHapsCJLn34UGd+63LE4mMcG8Vj2XDTebMN/3uWl0IsR3K?=
 =?us-ascii?Q?Vo9cP2OpUFPMkpjWpwc4l2F0dpHFu1hFbhZA7wLjx80E7BjBhXYDB5eiz3wu?=
 =?us-ascii?Q?sTL5O8IyCAvOhLAectmHj3FkCuACxPgRsVQ/siNHg9WTPS2IFZOPo9jQTA+Z?=
 =?us-ascii?Q?XcJNpH5WXCdlYPZ/dcJiUHEFe3YpzHtu8aDXzxoDuULU4XVVUsFcF800RLdB?=
 =?us-ascii?Q?crtoJB6cnlCdTkCJGcAKXehLiQAiKJdcSGXzDEUplXKfx7eZdiGq+a7cziXL?=
 =?us-ascii?Q?s0u72wVKxDP9A8GoEjQ5939FctujckxJwhNHarvZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b476bb4-dfab-467f-a6db-08dd07775d72
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 02:19:01.0359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LftIGTWNbCSl+SAD4kTbN7Y6DuWhhZbDGflf50Eam9RnUQmyQg3gHoF79Cy6Jltd/iQ82wfxLqBBL199G15j+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7009

From: "alice.guo" <alice.guo@nxp.com>

i.MX9 SoCs have SoC ID, SoC revision number and chip unique identifier
which are provided by the corresponding ARM trusted firmware API. This
patch intends to use SMC call to obtain these information and then
register i.MX9 SoC as a device.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
---

Changes for v2:
 - refine error log print
Changes for v3:
 - return -EINVAL when arm_smccc_smc failed
 - fix the build warning caused by pr_err("%s: SMC failed: %d\n", __func__, res.a0);
 - drop the pr_err in imx9_soc_init
 - free the memory in the reverse order of allocation
 - use of_match_node instead of of_machine_is_compatible
Changes for v4:
 - fix the build warning: 'imx9_soc_match' defined but not used [-Wunused-const-variable=]
 - add Tested-by and Reviewed-by
Changes for v5:
 - probe imx9 soc driver as a platform driver
Changes for v6:
 - use a define for "imx9-soc"

 drivers/soc/imx/Makefile   |   2 +-
 drivers/soc/imx/soc-imx9.c | 128 +++++++++++++++++++++++++++++++++++++
 2 files changed, 129 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/imx/soc-imx9.c

diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index 3ad321ca608a..ca6a5fa1618f 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -3,4 +3,4 @@ ifeq ($(CONFIG_ARM),y)
 obj-$(CONFIG_ARCH_MXC) += soc-imx.o
 endif
 obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
-obj-$(CONFIG_SOC_IMX9) += imx93-src.o
+obj-$(CONFIG_SOC_IMX9) += imx93-src.o soc-imx9.o
diff --git a/drivers/soc/imx/soc-imx9.c b/drivers/soc/imx/soc-imx9.c
new file mode 100644
index 000000000000..b46d22cf0212
--- /dev/null
+++ b/drivers/soc/imx/soc-imx9.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+
+#define IMX_SIP_GET_SOC_INFO	0xc2000006
+#define SOC_ID(x)		(((x) & 0xFFFF) >> 8)
+#define SOC_REV_MAJOR(x)	((((x) >> 28) & 0xF) - 0x9)
+#define SOC_REV_MINOR(x)	(((x) >> 24) & 0xF)
+
+static int imx9_soc_probe(struct platform_device *pdev)
+{
+	struct soc_device_attribute *attr;
+	struct arm_smccc_res res;
+	struct soc_device *sdev;
+	u32 soc_id, rev_major, rev_minor;
+	u64 uid127_64, uid63_0;
+	int err;
+
+	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
+	if (!attr)
+		return -ENOMEM;
+
+	err = of_property_read_string(of_root, "model", &attr->machine);
+	if (err) {
+		pr_err("%s: missing model property: %d\n", __func__, err);
+		goto attr;
+	}
+
+	attr->family = kasprintf(GFP_KERNEL, "Freescale i.MX");
+
+	/*
+	 * Retrieve the soc id, rev & uid info:
+	 * res.a1[31:16]: soc revision;
+	 * res.a1[15:0]: soc id;
+	 * res.a2: uid[127:64];
+	 * res.a3: uid[63:0];
+	 */
+	arm_smccc_smc(IMX_SIP_GET_SOC_INFO, 0, 0, 0, 0, 0, 0, 0, &res);
+	if (res.a0 != SMCCC_RET_SUCCESS) {
+		pr_err("%s: SMC failed: 0x%lx\n", __func__, res.a0);
+		err = -EINVAL;
+		goto family;
+	}
+
+	soc_id = SOC_ID(res.a1);
+	rev_major = SOC_REV_MAJOR(res.a1);
+	rev_minor = SOC_REV_MINOR(res.a1);
+
+	attr->soc_id = kasprintf(GFP_KERNEL, "i.MX%2x", soc_id);
+	attr->revision = kasprintf(GFP_KERNEL, "%d.%d", rev_major, rev_minor);
+
+	uid127_64 = res.a2;
+	uid63_0 = res.a3;
+	attr->serial_number = kasprintf(GFP_KERNEL, "%016llx%016llx", uid127_64, uid63_0);
+
+	sdev = soc_device_register(attr);
+	if (IS_ERR(sdev)) {
+		err = PTR_ERR(sdev);
+		pr_err("%s failed to register SoC as a device: %d\n", __func__, err);
+		goto serial_number;
+	}
+
+	return 0;
+
+serial_number:
+	kfree(attr->serial_number);
+	kfree(attr->revision);
+	kfree(attr->soc_id);
+family:
+	kfree(attr->family);
+attr:
+	kfree(attr);
+	return err;
+}
+
+static __maybe_unused const struct of_device_id imx9_soc_match[] = {
+	{ .compatible = "fsl,imx93", },
+	{ .compatible = "fsl,imx95", },
+	{ }
+};
+
+#define IMX_SOC_DRIVER	"imx9-soc"
+
+static struct platform_driver imx9_soc_driver = {
+	.probe = imx9_soc_probe,
+	.driver = {
+		.name = IMX_SOC_DRIVER,
+	},
+};
+
+static int __init imx9_soc_init(void)
+{
+	int ret;
+	struct platform_device *pdev;
+
+	/* No match means it is not an i.MX 9 series SoC, do nothing. */
+	if (!of_match_node(imx9_soc_match, of_root))
+		return 0;
+
+	ret = platform_driver_register(&imx9_soc_driver);
+	if (ret) {
+		pr_err("failed to register imx9_soc platform driver: %d\n", ret);
+		return ret;
+	}
+
+	pdev = platform_device_register_simple(IMX_SOC_DRIVER, -1, NULL, 0);
+	if (IS_ERR(pdev)) {
+		pr_err("failed to register imx9_soc platform device: %ld\n", PTR_ERR(pdev));
+		platform_driver_unregister(&imx9_soc_driver);
+		return PTR_ERR(pdev);
+	}
+
+	return 0;
+}
+device_initcall(imx9_soc_init);
+
+MODULE_AUTHOR("NXP");
+MODULE_DESCRIPTION("NXP i.MX9 SoC");
+MODULE_LICENSE("GPL");
-- 
2.34.1


