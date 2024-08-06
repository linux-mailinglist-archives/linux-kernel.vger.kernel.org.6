Return-Path: <linux-kernel+bounces-276432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 076D69493A7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B6CBB22B34
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22081D27A3;
	Tue,  6 Aug 2024 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UAps6tzG"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C57218D643;
	Tue,  6 Aug 2024 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955654; cv=fail; b=iiLAq+HYjmYKzV5azManTJ+cDUMEiEsVCrGPXmrCsIfEyqEzpUJsAUKgDYlBUOlMsD9y5R2ztktvAdN24g4MhfqQiXGLUMI9rr9nNw7E9zZ1/uOXTqV1JnqAsut33k0B7cxT/VNlIzwhdcsK7/okECHOQk3j43Dl8AwEZQch+mI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955654; c=relaxed/simple;
	bh=Yi5Q3IFSqS+7J45FO6SgqeVphuaxGeSDNvHgNsodcsY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=COCVeMEUyTHqiHGqS/JC8EqTXHb1B5oTp4ifj/mbRd4LHwVy1EelKbNZlDSyx1Vf4Roh8g9oKBtZ8uYGqbnDT+cedYURRZB1Y9ep8mWWsgoDxW5prw8xx3k38WjafQIkdUY+rXHWIgpr1aADIfwvwfSrRhf5qGjkFCsm3x+u4dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=UAps6tzG; arc=fail smtp.client-ip=40.107.22.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9Z6G98LDjCZYJd0cj0tchDQQz+BsT06E2tHwtYey5UqYbR722JXxZF5F31zKckUgA5sYwYMxc1eoF7xKgLP16nUQFZywDqAPaewoJ/IRnUB0niDjpoP11p2Dp7d0Uka2H0D8PbxZ0Iorjxj50MVMAWs0dQh2X5uPf+RDmDxT3/qeGfIIBVlUVI4QzyMlCXILHJis+DJl/fpRTTvSAugVqbkwWyiE9CgJ9dR726egjtAH1HzYYgaCYwiGSV8KxVkRpcYeofzozYg1eMo/w6z3a7tTTTUkVAOGaay9va4LQx6wgkUSpYao8Ept2ZftEY3yMSJejFRHX8eVdI731yVeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LuUy0YluQDfn/rdRf34ltJQ3oLxXYRAHJf15gqLOj4=;
 b=WOLQ6TJ4+J4rtDsN2mDHrnZAVR2JA0boq5p5RnChLJxxP+SGzT1kNuZS5ZQdlOYYNvsSGAiddrGAK5XVsyWMrBW44MuW3m71Mej138a3TYKHY9QWEOVIMx2dZ4N0t3addtM8ud+40BL8O+r3se0t2J4KIhiVg5pw6GNeZrbAqnbP3/yqB7LQprgWdZILZnusmruhw0e/gA8ikRx1UbD52FwSWj65OCWXkPKtMCilzT0uuzMScRJxMT2CKIESWd3StKfjeXWNNj8E+CTTzAS3weaq2r3DU7qv5KJ6GzfUItoMdnnPtzSE58LW2IhBjGGVbuMzgUYW/YXrSgb7Rdy4bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LuUy0YluQDfn/rdRf34ltJQ3oLxXYRAHJf15gqLOj4=;
 b=UAps6tzGoiHhgqHq6zJp2MYo1vO9SeRquEdNfc4+Z4pH5QlWNdVr7Nz3Is/rkETw+up4Z3MQljeue1sfVTfTWCtcklGFLItB09jrGuhkc6NiDu0SJ4kT/kyqo5zcSO4EcPhMWWanSabnaprG8kTNhY8F8aEo+4XmecgkZy2ESxzsMwechBWbwWRwCUpHqptjuugKktq+wIKh1/3u3dffUI3gECRRDL7wEqfDhBs8yexgWM8064MK6rMoGUbdrfg67Cbm9IH4g0PQZgeBKngMZWW5sytFdrZuC1QGB9RjW5pKm/aY7nQlrukebs17z8Zgitz0eJVK4O2goL4i1QjtYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB6886.eurprd04.prod.outlook.com (2603:10a6:20b:106::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Tue, 6 Aug
 2024 14:47:28 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Tue, 6 Aug 2024
 14:47:28 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	linux-clk@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org,
	d-gole@ti.com,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3] clk: scmi: add is_prepared hook
Date: Tue,  6 Aug 2024 22:56:01 +0800
Message-Id: <20240806145601.1184337-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM7PR04MB6886:EE_
X-MS-Office365-Filtering-Correlation-Id: 533676ff-2992-4f7a-7157-08dcb626b11e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/0hsMXPU1DL+QF0zzwA/FHq1hMdzdL02cN5hqUYkxNTZ9b5wCWm/Y99wpYj7?=
 =?us-ascii?Q?oT/OB11BoK06JG/1vQFqPjqICa0G9aZqtl9CGtEF5Kr4mMgh4yvsARWUvk6w?=
 =?us-ascii?Q?2JuRZbWpm6vGACz9wVMNIANb+7DadDkCHZJuZ+Xj7Eu5amkF1GZ4jGEK+DwV?=
 =?us-ascii?Q?5vIpWoAgXCzvpiqLL77AWuCn8HXdUzUmqJPJvHFTpzjqfOwg6CJ44mMwsc6p?=
 =?us-ascii?Q?ULQzQZYBKJCjMKa7F+e0AIsMYItGGfpWKBtM1XwrDNeZg3wAMtc18K3x9/l0?=
 =?us-ascii?Q?cifTVHptlTT/5Mtc549L2/AI5t379vjSr7LWkVvqTPTy9tOPGefQqF5nIVa4?=
 =?us-ascii?Q?Cban2wBeSFkidATODEK2aYznqevIGMySGI508rSnvLUqZvbN0OSJSpkBC/An?=
 =?us-ascii?Q?X/M25Qe7conZi8x+JnTyxJ0oDjVva/7wkDeZvR3QYkFPlMwuPvp4g66o/vCl?=
 =?us-ascii?Q?RZung5LExzIydU0O8TzVYpNc8Caa4hXPzsnne+tVyx2GfHaZhWfb90vEjybE?=
 =?us-ascii?Q?n1dFO1jm3HgCyyQkII9s0mXdAshh+YJ+EdNLmiqFpcZJO8AmjsfwKfLJ4R8B?=
 =?us-ascii?Q?fwUAg2PhB4/jSTrwlmmNaQnWdcg4IV0nB0XjMbGnpWMpqKD+jaaOXXgHtydF?=
 =?us-ascii?Q?dDbVBdIOPgUzaIJh7Ishua/7JJ3fJKfxcINTTVe48eB5JEy8cxE6LRLX1yUL?=
 =?us-ascii?Q?xXcu+G45iIorVBI6U6u3+trqn/Rrcnc48J/NblgNLKByPbafY6fsVDmvDkyo?=
 =?us-ascii?Q?Bn2Ku6IGfsSFvSUNTCNVqKEVSSTDkcIM4bLoB7Orf5j5x7q5cRD9p6pM0Sj+?=
 =?us-ascii?Q?WYCq67RTpgvUE2KAasVFcVai5ObGg2CAjOZtxfOX2EZcVubHVl08DAM9O7Qm?=
 =?us-ascii?Q?aRF3A0nbnRtzhtVUdFxFzkJ0MV41miPy0tig0s7ttqiwJHsZqbHmQuEv8PV/?=
 =?us-ascii?Q?LIaBrrY1vd8fx6YvWr4hiNa6DuD7ErdBhBOyQdyL1fGauFqeMP8ky3vWPOYw?=
 =?us-ascii?Q?1Qn96NEm9mSGTdcERu9RxWsdnJoVVGkWvZbnnPh11NvlJ71vo9gD4ys+HVAf?=
 =?us-ascii?Q?2gz8S8TZWJytnChYPf7pLXQ5XQ5OjTtZzHbOplvRYyTd3xuBMOh0O73F7cY+?=
 =?us-ascii?Q?VmkM0nJjsWBC7qmAdZu2TXATOUQvcKd898DyTlR+L7yX4e5kJzx6vNcMxNwO?=
 =?us-ascii?Q?k0JIzF3p6qGedOgYjc084ZFCG9nlaopYfy47gMjCI0sEFvfkGhcJjSgyF9gA?=
 =?us-ascii?Q?7czikeZcj8EDM55+vvtt4Bk4yf9yflqOUZm4RScN+J8vv8ZEs1oVSjxiMNvk?=
 =?us-ascii?Q?PK4dP0DH7H4uL4oVex0+ScxqCxK9sS3ifUylEs8005cp/ngszGmY7TEvVEdN?=
 =?us-ascii?Q?tFysl4Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pX7mKDdT1XvmzSJvr51y6tS8DzyKnSAIJXE+4ox2uNRPoW5Lilgi40OG2wNg?=
 =?us-ascii?Q?zHdP8iTGycg/3UYhweG2av9klZiZ2DO+L7bHpR3NxNU5Ym09OIZo2DO34Ksv?=
 =?us-ascii?Q?wwThHVRhZG8WiJnlktXybnwGP4phArG1gEyLtt2wtTUKvcg++CxlxPGlencC?=
 =?us-ascii?Q?dkv9jE15PdTnErPhVcWSyOvFV5b7MeepbbB48rHDrd8ARZT6VWYvkhgxlmWs?=
 =?us-ascii?Q?6UaWWcq4okMfced4V9YhxQ9tss4LqRW1utBp/k6HAGcUxiYFbZjTWpeTgKrV?=
 =?us-ascii?Q?z+p5rMQeQVGzsCGovFCJgV9ISb913IjTwJbk+IQ9p8mrPFiwsxATHp9Ud0fB?=
 =?us-ascii?Q?WiRDeoB4gqpd4w06cjMKtbbLkflXZSqpkJCQVsQ3wKpcMwA1UXjZA2/8B+ti?=
 =?us-ascii?Q?R0RTxLTqCzHpmfEw+H59Z4hL3dyQxmnLDTEa/J4mqgy3QyGA3HyiYjLk/An2?=
 =?us-ascii?Q?lhRsKmOsMKo27CR7DRSDuzKwJym4Y0yAAWkTa/GSp4wuPk867GR5ASCI14y+?=
 =?us-ascii?Q?SM2YGuGMxdIOp1W4mApEwO1zjdw00c++utZHsBSodIys3ZTP2JGPAhWxJwT0?=
 =?us-ascii?Q?WsqOCFTqmVurZvXsYEhmngIB0IrU5hfMXHPWhauywNvp8Fs/R6hI4Acv6Xsk?=
 =?us-ascii?Q?zAZ8JMzOIOAIYtPl+4QIqdtNx3aOo1n3+5rL5u9K5WhpIfCdp89j5chDN0BG?=
 =?us-ascii?Q?sgph37dzOtwkX3yYFls/FkvAjI1TBbjuRF36iq0jS/qTv9db1RV93aLdHwyl?=
 =?us-ascii?Q?iuY1F3VeDr7pWVh1r/koAoFUKuO1AbKY0kdiGvq7sBkvnangMGY6l2NFYSTf?=
 =?us-ascii?Q?zZkNzd7PgIoBI0taLVZa9aHJY1gAcuaf4fPCVoqdwLTpbMBnq+UY8LGOSPC9?=
 =?us-ascii?Q?Ypu6CZ2tjppmBo/NYdSQMw3E7+hbwTgoyFgVXl4NJ5bNiLZi0gonbs+YgM5C?=
 =?us-ascii?Q?a9Iyw5ivRVQU2qxThNcxmrNfVC20oX7QsmF+zcnLMMoklQri022ZGxY3ULz2?=
 =?us-ascii?Q?x+P801yQQshdt2QCh/cXRK1we4fQXJDyc5pVY50nxUam6zgRdrN55w49vAU5?=
 =?us-ascii?Q?lB8LBd/DAlRKkuy5yjBuq+kcOZNtzs9qtkMJlSm6u5il9XpLyu2lAJWCK5TN?=
 =?us-ascii?Q?Hvu0VxmT6c7ibVucvE/NAfkDOxqERCxqnAQobUv3/B9aMxa/HixGcRxRy/Lo?=
 =?us-ascii?Q?6EP9M9ndn0awuLoTBdPVRxP9sM3IEET7UriUJirnlt/lEQyZabyNF2Sv+Njw?=
 =?us-ascii?Q?OXIariJpNfVCQXUEPNga3yw9QSTJqKbDUm6nI/By9uwHFIq7CsTwf00kos0W?=
 =?us-ascii?Q?2L4JxZCVTTA9dUFjDumXalf4lXYWzu9Afl4bHxEMl+6O6QxHUe3BwmhmRapI?=
 =?us-ascii?Q?nn9lA6bDmEb/OFYCkNpIYOPs0/XFWd7tx6C7r7ZzNPFIU06PqJMYZB8rdCNf?=
 =?us-ascii?Q?P+caTRzpXFq1Jy0zDbqR7qzfeUUFfNmD4mVrWq8LC69hU835RFDs2uKvYnov?=
 =?us-ascii?Q?Pi8xtqEI1rWgBJVGcjLLXaSajMJLApVyXt/c5yojkVAja8la5pikCaF99uxL?=
 =?us-ascii?Q?90NxD3JWsu+ucT15+ojMXbsoT3IOljJFZQuaqG0B?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 533676ff-2992-4f7a-7157-08dcb626b11e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 14:47:28.0237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yz+x90DaBbpTocJSTQd85FKDNhkTBDOx2kFh/MsxD4V8aWEQtanCSte7TKHX4H/N/zdVDJ35qEi5Tsy4ezcltw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6886

From: Peng Fan <peng.fan@nxp.com>

Some clocks maybe default enabled by hardware. For clocks that don't
have users, that will be left in hardware default state, because prepare
count and enable count is zero,if there is no is_prepared hook to get
the hardware state. So add is_prepared hook to detect the hardware
state. Then when disabling the unused clocks, they can be simply
turned OFF to save power during kernel boot.

Reviewed-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V3:
 Update the commit log. See discussion:
 https://lore.kernel.org/all/20240802061234.njlviydzmjbsyteb@lcpd911/
V2:
 Provider helper __scmi_clk_is_enabled for atomic and non-atomic usage
 Move is_prepared hook out of SCMI_CLK_STATE_CTRL_SUPPORTED
 https://lore.kernel.org/all/20240802061234.njlviydzmjbsyteb@lcpd911/

 drivers/clk/clk-scmi.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index d86a02563f6c..15510c2ff21c 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -156,13 +156,13 @@ static void scmi_clk_atomic_disable(struct clk_hw *hw)
 	scmi_proto_clk_ops->disable(clk->ph, clk->id, ATOMIC);
 }
 
-static int scmi_clk_atomic_is_enabled(struct clk_hw *hw)
+static int __scmi_clk_is_enabled(struct clk_hw *hw, bool atomic)
 {
 	int ret;
 	bool enabled = false;
 	struct scmi_clk *clk = to_scmi_clk(hw);
 
-	ret = scmi_proto_clk_ops->state_get(clk->ph, clk->id, &enabled, ATOMIC);
+	ret = scmi_proto_clk_ops->state_get(clk->ph, clk->id, &enabled, atomic);
 	if (ret)
 		dev_warn(clk->dev,
 			 "Failed to get state for clock ID %d\n", clk->id);
@@ -170,6 +170,16 @@ static int scmi_clk_atomic_is_enabled(struct clk_hw *hw)
 	return !!enabled;
 }
 
+static int scmi_clk_atomic_is_enabled(struct clk_hw *hw)
+{
+	return __scmi_clk_is_enabled(hw, ATOMIC);
+}
+
+static int scmi_clk_is_enabled(struct clk_hw *hw)
+{
+	return __scmi_clk_is_enabled(hw, NOT_ATOMIC);
+}
+
 static int scmi_clk_get_duty_cycle(struct clk_hw *hw, struct clk_duty *duty)
 {
 	int ret;
@@ -285,6 +295,8 @@ scmi_clk_ops_alloc(struct device *dev, unsigned long feats_key)
 
 	if (feats_key & BIT(SCMI_CLK_ATOMIC_SUPPORTED))
 		ops->is_enabled = scmi_clk_atomic_is_enabled;
+	else
+		ops->is_prepared = scmi_clk_is_enabled;
 
 	/* Rate ops */
 	ops->recalc_rate = scmi_clk_recalc_rate;
-- 
2.37.1


