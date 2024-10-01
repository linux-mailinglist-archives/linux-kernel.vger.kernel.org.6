Return-Path: <linux-kernel+bounces-345372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD65698B559
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA7A1F22099
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96FE1BD03F;
	Tue,  1 Oct 2024 07:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="YY6ppZec"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2128.outbound.protection.outlook.com [40.107.244.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165EF3307B;
	Tue,  1 Oct 2024 07:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727767191; cv=fail; b=EXOSXqDF2YEpza9zNRBl3zREIfYQ1SnjQ0gRQDgfQ1eVNw82A9wLSlCPGMeh4hglpn8GcPeBfeNyOaUrqLLH30yUzoyu3/iEPNY3a6o/MW6qbBvllJWyQhclyKVxowmZ4iiEUiSR/oJmbhQ7NONWoDOFSMgfW2wG9u+uFDq6Noo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727767191; c=relaxed/simple;
	bh=BcgP5QN8+2pX5+eFkQ84mx8NQ9fkWam912fO0hL3iHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MNp+UnjTR+9QQPb6eK4sGegBQuxp38jQNR1BWvf8P9o51ns+TeDF4AfPCHEryZiwE6A1GWjOt2TfQ3ukCKCs3JgqVoIR0moGdVN+W8yQwtba2JjFabCBzo1AgirdIF60WEef8BnFqfb5qPJPhVueEg1u/EBr0n4ouL49cKE8pII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=YY6ppZec; arc=fail smtp.client-ip=40.107.244.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7wFVZ14lGHvnZ90W99VKzXPlr+bAR//MzRxCcutNdglC0jxy4T0TUnucWHGkFG4TXKj37K3+71ndJ5fl5Hs7Szq6KkoPNcmf62LoKgXZamlBe9cGyJPmDl0Bh83lY9lltPLmPveNEUpq49a1V9odx/sMJd2YF91uJo7B7BxL4kTRLMXj1q6zCm71NmKDVmtkBWAcbSbDqZrq4xOTl2jlFLg8srKnAp4nwQPOPA+whDul7s+YuDybaMqy3VsV+oJHSr/VVZyEJsYEXhaaBwiZW4yVseN0wXlZbvcHv/+Ha1akISrXQXaGG7iXPsnyLLkRFizOrvv7PKfEki2tJGtuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BL0VDu6OblbIbcfBzdqthfe6TxJ43/eKZQgc8Ir89V8=;
 b=MfFwXAb6KFROGir3qLc0AfgxfEc7cKaDd4voMpJQllbSrhd/LLp+xEQU+PUGUydKh6v08hOR+jSJ2zHExRYMscH9yi2vsIBZYxfP7l20E1l3sqO6tqDyB/VPondrXPlXhJfPdQbYjF84qwIBTcPz/ZEw2l/khWqStZcGROuLfsVzZcNxM714z6a/rs5mI9OV74Nf57uW9HsfmwFLC3siNVUmbyZGZsLYtPuzvnddXPnkQhj20FyRLI6yvr4UfLSkLLyyHhC4U4NUMpTT6k25m1lGvAephUH0oiliAoXa051OjCZv8Xzcpi5keNNZblztkhug1FEX2LDO4SEO/+AOLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BL0VDu6OblbIbcfBzdqthfe6TxJ43/eKZQgc8Ir89V8=;
 b=YY6ppZecPKnGTFoh7QS4HpZBYE2mUUSCoChDB2iDr2QqnVacR6ZFo3QmiVBzIM5k6jX/QshwWO9Qd+CcVznwZrhlYV9SQlXY+h9JcDtGmNYKPgAvmDwuzWLg1x0KEMsffIxLYUbj8sr5bXvV/zaCRqFaB3ifVPZg9eBOmvznKfI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com (2603:10b6:a03:537::8)
 by LV8PR22MB5551.namprd22.prod.outlook.com (2603:10b6:408:232::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Tue, 1 Oct
 2024 07:19:47 +0000
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d]) by SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d%5]) with mapi id 15.20.8005.024; Tue, 1 Oct 2024
 07:19:46 +0000
From: Garrett Giordano <ggiordano@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	w.egorov@phytec.de
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH v2 0/2] Reconfigure 1.4GHz in AM62 PHYCORE SoM
Date: Tue,  1 Oct 2024 00:19:14 -0700
Message-Id: <20241001071916.1362213-1-ggiordano@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR05CA0069.namprd05.prod.outlook.com
 (2603:10b6:610:38::46) To SJ2PR22MB4354.namprd22.prod.outlook.com
 (2603:10b6:a03:537::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR22MB4354:EE_|LV8PR22MB5551:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ed69ace-370a-47a1-408b-08dce1e96de7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DepzsZIzfwCciqbhKvbXOQJwzs2RM/ajLGcbXC/qrOGEG79HTNZZJlc3q1Jp?=
 =?us-ascii?Q?XM/F9fD3NygLwGj4Zh6dohCzGC6ZJJ9MnexzoS3asvuBS7lZjnf9G2VUJGx9?=
 =?us-ascii?Q?XAImUr5IqmIGDm8RK59zvp4sghX1PLqocyBLO1fCRdOy1EBIt8FlXtuwZLkZ?=
 =?us-ascii?Q?YRnCJjW6RKVUsJpu8ik7f2NFMW2ymo0btk9dsxvEWRm70AEu6iDnLOT/OK+0?=
 =?us-ascii?Q?oXC2XPARzJA08QoqiQNZFy2njIXmBFWdmNwvo7R7qS+JuYHoxY9vQvhI7Fe+?=
 =?us-ascii?Q?btMN6hAUoDoj45NwezE1d40jjFrZRltB71FmcSn9WXllMzraJurDzMripHfH?=
 =?us-ascii?Q?sEy56cVvcEBPSf1xuU+KRgruetj9wqf8gAGJqvmY38SMbIUANZGvX0nLU6jJ?=
 =?us-ascii?Q?McbJ5Cf6nMrng+FhO6JJwV/aqG34DFQYgNWGJkRZOTh/aL0eWzdjUy+pc9TK?=
 =?us-ascii?Q?a8OS3PU/Ect+eVqz6ht6ZxKjdlJAENfR2YUa3HYVw65fZsg+qb90wxoMKxjM?=
 =?us-ascii?Q?mncyHtNiT3NYQs3UKUof4nneioFlhr7X+dNOD3j88LsF66xEJNPDAthWB2Oz?=
 =?us-ascii?Q?TgOVnY6x+T9snI1fUOEDAugkhdfmM7vAVRUyivK4PqhRRr39jbvQMjm+H7wA?=
 =?us-ascii?Q?1jg57GLHjzo6Rw9lJhqeboHg3oyuc7cpU6yN3m1GbyrMtk7cPpM3Vv2KdK43?=
 =?us-ascii?Q?n4kLDOYUPN67vQ0ZhpzSki/jW+xmTJQJb914zxV+5VuqgdKz4Tb4+RY9pxki?=
 =?us-ascii?Q?WVE5BGkvHZEiAUjbUy4BgPj3xBApBT5WvLXqCFL0lnTwG5kp9aI3z4ti6H5F?=
 =?us-ascii?Q?iEDl6trsx0pf5mJx65UMs1E+vJNrm77e29KCHAALsagLYfCDCwSm93sIjc0w?=
 =?us-ascii?Q?3x5RX7ilsj9tIW3WvbJzf1xA/qiog/68pHc+spvwF5Kd8FGxbZSQUKF3tWpz?=
 =?us-ascii?Q?VlUAwXHrGFj4J5TMesFDSbTc2+myot/q4n6HuBDsgkcHmZuJ8W9xGzoaoSOc?=
 =?us-ascii?Q?OXD2MOlI0gx2iSJz+TnlcQv0FrjFWmnt3qS6uuvrhpgC1joVsECFpOQVoehW?=
 =?us-ascii?Q?0EyloA/22y2CjQryNhVNJ797+dv4kf5xncxfWslRVnLe6DmmBtndWQePW9tm?=
 =?us-ascii?Q?bAcV4ulziQRtMZ27omhn9v9KLfi4W3i925T/ns+lyLEY1PcetZm7rRorGyX0?=
 =?us-ascii?Q?rSXVe9EBgcnl6KDPIrCm5UqinkgYPkFy73LvwMVUR1S27z/KXQ/sMaVRnHKW?=
 =?us-ascii?Q?godS6Q6mrSiYIE9aSZIeFo1dHvPY2/871KBSTQtAV+iDeZxMf5Mwnc2v08a8?=
 =?us-ascii?Q?ut/7hmDxjyLC482C3FqNYa21hJ5i28BBFq0wSOYqJRIyBQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR22MB4354.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UT/2pt8UIN2hNSgnv8oE6dYZtgCPmZlBnbllfhShcZ0vyxEe0UbeiPBUZ4px?=
 =?us-ascii?Q?LCr82ShkiwbgKzRPXkchmxeAEMIOShsf8B94gXn8uJfle2c5gtHPZTAgVkdW?=
 =?us-ascii?Q?pfKkzk+ZPynT1l6Bzp4XRY58qiwA/tGV+qmp210MHVx3CSfkJ0IcRmGcqjtg?=
 =?us-ascii?Q?RW3ysJEZ7/dyE6zgBDYG5kStIUN6wSpilNrK/8SzeWe2AglcLvgiSRDLnirn?=
 =?us-ascii?Q?IuI6S1RDTa+BWs/BapqFdZVUoTIk+7AppOdV9LAZL+1V+hiGaS82b5LQuAMX?=
 =?us-ascii?Q?4QLERUe9HPRAVmbDTvfbnt/uEfPQsf5dBHZ60UZBDqYjK7v+sKCAM/z6cDOp?=
 =?us-ascii?Q?j468oX48X0rNozRmc0W6vYQnuXOKc0RuHfE5T17stTJAJPtk+SFYrBQ10BYt?=
 =?us-ascii?Q?rFvqxcumHv9njn1fs8QIP8Y7a1Ly3ika0VoQW3fxnl8k+jMQln53mKDuIZC1?=
 =?us-ascii?Q?E1y616wsVDLzMjwmHTZSF7kU1CR423+WTQNaSddlvz+fvY7YbzwLjS6UXXPA?=
 =?us-ascii?Q?aKEcaXdUoE0YCzPh+dCwg/XqYHrX9bXeiJxCZUofFUSAEZL9ZQBNvNhPKX5H?=
 =?us-ascii?Q?QTwArb6M81bzn0u5VavKJpAdb29UyMpCojG9NLy4aNcFNnoA4TLnSyshVQSF?=
 =?us-ascii?Q?/QRmbBKWvCBycAfMmUmykyhTFfi5utct2aMqhOsV+FVJkf2nllyPIZ4VI1sB?=
 =?us-ascii?Q?11ENBsUE49JdheS/5lH0yrKOFnUfKV+5RQNv8zxxlbPHarEXNf+o4hNbvkMF?=
 =?us-ascii?Q?8S2HXnozTVKncXfFwX1GF2j1QGctjIQyVrNJ5FC/VgblREno0lUVewLinC0Z?=
 =?us-ascii?Q?5N3+20Lov/gQgRe+sLjA5DnZkDYdKZFzyVcoTadXUCBiy0k+YGYspfhCQScG?=
 =?us-ascii?Q?Y7T0geGP8zbQakjSV/WCmVCHPaiPuAV7AjEsLOZq/6vYcAsCtfaFGABtd9/u?=
 =?us-ascii?Q?jA0bjKSNwk9Xe6DUu+J/oAbw7sXhbSYkFCfdYpHNKbuBwJ8UsWzi97QjPAOV?=
 =?us-ascii?Q?eb5TSCdQkqKbrzFuKr5JM3RRTm/jrI2O4gighZeOLpf7D6AaiuLFgxQqBn3s?=
 =?us-ascii?Q?37HYX3Getu1xmceC5xeqVUKG1O3UP9907PT+O9nEOKSrnT/I0O8W3C8GuUpC?=
 =?us-ascii?Q?2LOf8BSqjvSs6Exlg9gyeI/7fsKoKJ6bPp0t8moASZP7h0KkWBN6B0Ndbqfi?=
 =?us-ascii?Q?bF4lEiJYAOvkoKugrIMBM9oEB9m+Iv93Ild+jJ2iaJC52hCYM8/YV68jLljc?=
 =?us-ascii?Q?cl7LBmkNiFSds96JBDA3bFKY9/L3MADyXSLHA/Tk6DRrIzJdHv1/wxoNnxBG?=
 =?us-ascii?Q?Uc3a/lLO9uBHBOrE2bxmT9TUytgAYzdlJ5nogJllFRgHhJzaS5P7l2FeMXrN?=
 =?us-ascii?Q?BONcleC/JgoVgnSPYh4gwHUJNIRsRj/ZORTJ1FF9Fw7npUkX4D/Su5cNrTl2?=
 =?us-ascii?Q?PrSZYLXT3b+1FuncY5u/FG0lOf+Y3ht+Wf9bAFxYjvLteKn4senYJdVY1/CI?=
 =?us-ascii?Q?rLttVA3emOG5zopNLQ5gOnKeUqCexHsiF8tBPCM1oWzV5FBzWGKGDAdRuBjg?=
 =?us-ascii?Q?Tk2K5FAgp9LcwghD19hADuBtTATLSD5XsgG6Xf38?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed69ace-370a-47a1-408b-08dce1e96de7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB4354.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 07:19:46.9031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BiTPAMiRSlu6AdALye8nzPPieN0hz/nv/Pf1MtjRpI+TU+jvSyqmhMNDVDoG14vNay1DxRakH7xzv9K2ejrbBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR22MB5551

This patch set moves our 1.4GHz opp table definition out of our overlay
and into our som dtsi. This change goes along with our updated PMIC, which
is now configured to output 0.85v by default.

We drop the overlay as it is no longer needed.

Changes in v2:
  - Use git revert to revert the overlay patch
  - Update commit message to reflect revert adding the device tree overlay

Garrett Giordano (2):
  arm64: dts: ti: am62-phycore-som: Increase cpu frequency to 1.4 GHz
  Revert "arm64: dts: ti: am62-phyboard-lyra: Add overlay to increase
    cpu frequency to 1.4 GHz"

 arch/arm64/boot/dts/ti/Makefile               |  3 ---
 .../boot/dts/ti/k3-am62-phycore-som.dtsi      | 11 ++++++++--
 .../k3-am625-phyboard-lyra-1-4-ghz-opp.dtso   | 20 -------------------
 3 files changed, 9 insertions(+), 25 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-1-4-ghz-opp.dtso

--
2.25.1


