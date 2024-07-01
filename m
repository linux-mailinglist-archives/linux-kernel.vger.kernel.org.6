Return-Path: <linux-kernel+bounces-235536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65ABB91D652
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 04:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890AD1C20FF5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 02:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EA4D534;
	Mon,  1 Jul 2024 02:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Nym6iSu7"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2047.outbound.protection.outlook.com [40.107.104.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDE58F77;
	Mon,  1 Jul 2024 02:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719802370; cv=fail; b=pPjLzFQ3plfPZk90EzQTGktYKQ+onmjrf0LZR0nzpBfB/PMChcZSaZ1mzMZicHFxwhWeI8A/8IWGkqzjRCTl5D4H9B9HtNoOeg5x+aC4tPwi9bHUAcMcLvLoYRZBRcdTzSRRc570wpsjM1qZjcVEROIQh5XWyLx/JJXJwq1nxSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719802370; c=relaxed/simple;
	bh=SmkcaJAxAS8haArpTe74XI74eANo45IeepBNY7XL6z8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dqRPKSvtO+Af2x2MqSEJ6c2cQoQ9TwSMyvQteZHccJdzpqCKtqJDc0Lx8f1Pn8ijAtqANRLx+KSCbVIf03NbZFPo62ZpW+xz3TdpuXRiXCGs/kvSYfmZkqxhW4VzCnVZLB4YeaABi6pZNhYQirHk7y6aXBxqGKhREoiOqlvhbrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Nym6iSu7; arc=fail smtp.client-ip=40.107.104.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cY2dB40le6D6ovtjDX2PYOWrlMgtaJ75Dl0OrviDPaoWPnR6VPNaTTojnQQ5hUKXsHcQjpPbNvhH7pcycscfpCuMxXt1HSDr4b8j8W66YMq5Ze726/I8s//oa8zirhRPRfsxxht33SQudj9zx+coCkZhXM3TC4aNsJyj9nQrCwYWQYUBnHTJuBD6bgT5RsIWe/BjxcVJUnF5ZOPEfpkZyOJIW0Tjzc0OEyMJTRpU/ANoWg+yfgz6zjGI0nPGSB0PSDScLDMtHjTIYxLwkFg3zHIjughyJrWlUvhcZjO6tm3rlSH9vQzvoKK2ijUY+5cYo55/03w1nirrwO0Bzxufig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJEFLQQvxWlzIB0A6HSFpQP6jALKEd9skWZSjZwdlOc=;
 b=VLR7aDX/34lmsiRQo64gGz/mTCfdOGctyL/8TlpVqMwFVZKLat7S3MevnHFgby6RiWb5HlWvjuMlnawuOfv8CU2hblL1slavuv4Z37hDSHkHOlx7X2xZTdpAnIUxuk8OZzBmJ4O4k84QlEk8UwWLGVoNWiN84hy8zeG98SrXtZRylGooUdFIMEvXwx9YGeyQiuJL0Zp0Tpqv4mhyWcovfGfNvx72CylBW9wV9c0zRXyhLiStIk7a+H/y1Q6GN9+l2XQrpOSLI2DqOPIyTM7zEs6vAg8CEkyy5HPqTTFNMpALCUPJnhqXp/IGNrKimiFr8LhM6reDcHcmP9nFhO3e3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJEFLQQvxWlzIB0A6HSFpQP6jALKEd9skWZSjZwdlOc=;
 b=Nym6iSu7OVP4hQxa6STkHMDQcbubQ2Gc+PW6bWzjnz93j3AzCBFM2P+HNt4QDS0vYEcU4TP1sySPEFcHTTIl2yLdQGxDeL2fHuFeHShTJKrXyDugDEW1Ncmun78fJdiCVcNjTsIhCnL2urIfDyhe86gLzk5WwCzyO4XJx19OF/4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by PAWPR04MB9765.eurprd04.prod.outlook.com (2603:10a6:102:389::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 02:52:45 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7719.028; Mon, 1 Jul 2024
 02:52:45 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: sudeep.holla@arm.com,
	cristian.marussi@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] firmware: arm_scmi: introduce setup_shmem_iomap
Date: Mon,  1 Jul 2024 11:01:43 +0800
Message-Id: <20240701030143.2327844-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::36)
 To AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|PAWPR04MB9765:EE_
X-MS-Office365-Filtering-Correlation-Id: b379d0fc-67f7-4d6d-51a6-08dc9978e227
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4Pq30S+aXftCd5vTgFjWQ5U11vTa2Cb3kDVwWTWLHcqXDPAHceTIS9IFeB5O?=
 =?us-ascii?Q?VTYQLs0eFVwUN/MoP8S2tm8OUyA51xBLeZDbm6RMxjW4or6tcDROdcfRgeBP?=
 =?us-ascii?Q?ei13q6v00AeDzbE1G6evYzAj2fbjqxRHDc6lSVKW2C9q1egiH7qXnt8r9CUT?=
 =?us-ascii?Q?T3LdRCNvMMYkj5BNZx2bfBm8rjsR7q6jhVgE12OCctngi1UGHU45V5ZkuLKc?=
 =?us-ascii?Q?pOiIi0dPXMyMPJh02V2PVdywPJeB4CajrDj+vttljMu1QZm4Ib9tcDo8DCf6?=
 =?us-ascii?Q?r3rTmsO7eTikQxXvPbEm3/+bqJuBQMwaBX5p+gGzh5IvhT836SHnGKpTm3V4?=
 =?us-ascii?Q?bioM8XT8iPY14L7CoHkXTy3Dstp9JvaYizmzsEs1Zpzg2Rrw5881kDQEkof6?=
 =?us-ascii?Q?jR/cIso618q0LD8/HUfM0AfsWdt6rNOzQryuyPkWdtQswoRFB1/CY9ggdYzC?=
 =?us-ascii?Q?6PNzhMWggtnEuZhBoZl5WZzVX05EKdNSKlCDPQlwHBWViHmK1ra8ubQ7YBOZ?=
 =?us-ascii?Q?0CS/3AZRa/SCLJDR8ryes36sf4xPYYLb6GtG24GG6AsKUfV0+DYx8uxjeLrD?=
 =?us-ascii?Q?5cB3bz0eFzzhSaFZeJwLabpz6I+12oyRIMkQnnia3yTGyJi64nqV+5Zc/q3l?=
 =?us-ascii?Q?KgTuM18UMQqcYoyCs8+YUo2Ja5mfDWb5KcmAcf5MnZv9USQqlfvjYn2tfY+J?=
 =?us-ascii?Q?KP8ZO3w4dE1awGXvygLLlv4/vlxEqkuy5bc6YFOAzuyvcwvXsd+fEXCOTRiV?=
 =?us-ascii?Q?QJPHf++0p9dqQVJA/qx+3hz9abaOP80ZQJJxAgqNb+3Kgnqmkv9wsLkEtNyP?=
 =?us-ascii?Q?eH8YMvyFlFUR+8mBICIbwlNvfA1Iqyq4WPsuKnV3hyZbk28GLZM4r0CGVSWl?=
 =?us-ascii?Q?njiSVR5cGeNEGT0jRcIy5DFxzdYFr6ZM7qBWNIT/80B6iKUDQFtJTGc8RYT8?=
 =?us-ascii?Q?1oGjb1atJOKANo+mo6SeHi8AZcvR4VLMNppLtXT7ae6ZeKYZKpTFdUuWR/bf?=
 =?us-ascii?Q?QeXdthi45h8BzS4mEziwqxinbIBPGuTYn0MC/QkFc8ormWN5TThUij0SBTnT?=
 =?us-ascii?Q?rEirpAT2eu/Xx2nLOJa1xWgiFIZYb8zvPkb40YztFLQpQ0f12II9pc0kLbOO?=
 =?us-ascii?Q?pPBjgtudUpmmTDkMbH/OKEW51P2SDjQwKk2vft1AKK3KUG5tPRR1DuaxX4OR?=
 =?us-ascii?Q?0cY2TPgVH0Px9CDm9SX2tJc/7xcyAs0jCYMJ8J5acLf+Ynnf/JA+37Hj1NHs?=
 =?us-ascii?Q?hgwP2y453XKMJz27BkE8zgm2gdKHlvYu2M71QEMwWExZoS8MwoVz7B56NIkT?=
 =?us-ascii?Q?jSO4m5QSOw/d11dYgm/XolmkbiKHEhIqaIRLpHIiwgQCNL1iZflLR6Kz0TeC?=
 =?us-ascii?Q?PA51GH+QNemdTumWRg+egs7Ybt8IIjsPo/E3CsRw82RJUIke3g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rvzdQ5dHyDMXELsPhKkEaElArhEUW7hBqWvrxw3G/+cDiJDbBQ+YKJaoCAad?=
 =?us-ascii?Q?4nIs9R9PQrsD1flItyx6d7ESZCg4S3hvYi4M7Rqpdz8xwyHw9B8xOS15qtc4?=
 =?us-ascii?Q?/VjRFFJD4qwgNB1uQHcbymEsIxQ5BA1QAFKv6WFzZEIUDI6ZTSHLQL5fLKIU?=
 =?us-ascii?Q?aagAC0zgO+bdvJr5RdsiggiEuKD1ieIfzbVsR6vm3OtWcU1ITDwFtTGYhw8D?=
 =?us-ascii?Q?73Ee1JJmIKyJUg9veDx+vLt91qt8ZUMxqjJWP5+pKw6Gqw2PQPoAHG8xd1nw?=
 =?us-ascii?Q?lym1nujM8898/MeeqCI54pcqE+N9TVE9uTRrbQp6QCqpU702WYY+D4nefzi6?=
 =?us-ascii?Q?u+tQSrJm7hVWQZKC/mjus5of5sqNHPe8Y1pcP5Bb3m05ovIZ0kNVApEoVk89?=
 =?us-ascii?Q?2jtJsS+zXZtS6RKQN/g20tT+NIQjiuJgP7zB8sP6qnZSdWEJ5SpR7BO2RBMc?=
 =?us-ascii?Q?rWP77+ZLmihD/VyftyWXLb7Wswmt7Iqmd7ieQq5VHCk3Ifhfkefa/yqufWDb?=
 =?us-ascii?Q?H+GM+raq+z7bRM/yZMmBTcc7nV78usQLCRNTsbrYPtpVvi43BRPpfw88nfuZ?=
 =?us-ascii?Q?esmk7C7QuzvkpM+gNniIezO7adJGYqXGlXDM3Exr/LM8HqAs/19HUO6A8KeT?=
 =?us-ascii?Q?VtQH+leRHNnHL8lRxZECUlDKC4KT3GkDzEjzlFL3jItpwOQ22GGkklSYwfx9?=
 =?us-ascii?Q?N+2qTds4uCYGV8RyxJ+YZeZqjyAMMsbizBeKYPwad4C1Ghj/ov/A0s8XlnBs?=
 =?us-ascii?Q?szMJu9ppoo1Vbk9cCT/6cPSFvNNmbjwiuAsZlVvCb/m4tjQJEnMqHnrF/puO?=
 =?us-ascii?Q?y9qrhEfoctgGBVvcw1GFtOaL+m/0Jr7DyELO71Mirbe5AmXx+xKvcsJ6TW5G?=
 =?us-ascii?Q?7jdVY4/9eyHLB/RS+JF7yqvc+YxGXf3FZnmyghjbjU6h8nXaFAq+oG6WScfA?=
 =?us-ascii?Q?Teu2B8QxZURasxs3Fsa52SlU9JNM9/BRXS0/yRzsaHRb3ail/HvXs4lKMBEB?=
 =?us-ascii?Q?MnfYBBvN0f6Fd+SI0iMPsvHC3HFcK/yhjNBZx3dZ98aJ6EMsEEjP0ewVXLmx?=
 =?us-ascii?Q?bqRf3QesIBSACvwBBckvHj258B+3KmTFG5a9cPKS4KCL+9AwnreaVmmbYiK4?=
 =?us-ascii?Q?ctmSYgwkHWk8dTReV2wivxHGCEDwKePcxocv2UuDh+nNO3B6GRuFZiRzjVA4?=
 =?us-ascii?Q?opzI6yeXHsVZdvmEU0Qr8KghOYwzPWL1dtUIlcbBGZk++e/VaPUb8k1nQnUF?=
 =?us-ascii?Q?zbDA9L0OExqYdGqGmR6FtXwZE6m3pf3sYyAco7IT8tLp/p5uAXZFWSgYArvL?=
 =?us-ascii?Q?Vf2KwbvtY26IzsL1mu4/joLBHMQaZY7z2f6AKvVix2X5H0LVPqd117bPxncL?=
 =?us-ascii?Q?VToRTvXXXX6IPn3QL71utxAQJwxm+XV5RfDld5uqDDikyOuWL+XjG1G1YLhA?=
 =?us-ascii?Q?NOkesmfeWFs/wg+aDzNXZa7c4yjaI7xnSSr58bG5t+ncQYyEcd/sYQDBz1oz?=
 =?us-ascii?Q?wToYRb3p66UQoCMqhVmf/5GQzgE/Fdh7CjIb7sh3pvLX24OpXcO5xIXzHMHw?=
 =?us-ascii?Q?HzMwTEg5aH10MpZeCTG662/qbjeg/SDqE7l/7ev8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b379d0fc-67f7-4d6d-51a6-08dc9978e227
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 02:52:45.2346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SS7m36xxwJ9AcQAUdv1g0mjFkIEuDlcWbQARVERtd2ZN0RZCe5vGpW0Lwp/iZ7NsMXggYA8VYiSE5P4vG4smKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9765

From: Peng Fan <peng.fan@nxp.com>

To get the address of shmem could be generalized by introducing
setup_shmem_iomap. Then the duplicated code in mailbox.c and optee.c
could be dropped.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/common.h  |  2 ++
 drivers/firmware/arm_scmi/mailbox.c | 27 ++++------------------
 drivers/firmware/arm_scmi/optee.c   | 35 ++++------------------------
 drivers/firmware/arm_scmi/shmem.c   | 36 +++++++++++++++++++++++++++++
 4 files changed, 46 insertions(+), 54 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 4b8c5250cdb5..b4c217641e3a 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -327,6 +327,8 @@ bool shmem_poll_done(struct scmi_shared_mem __iomem *shmem,
 		     struct scmi_xfer *xfer);
 bool shmem_channel_free(struct scmi_shared_mem __iomem *shmem);
 bool shmem_channel_intr_enabled(struct scmi_shared_mem __iomem *shmem);
+void __iomem *setup_shmem_iomap(struct scmi_chan_info *cinfo, struct device *dev,
+				bool tx);
 
 /* declarations for message passing transports */
 struct scmi_msg_payld;
diff --git a/drivers/firmware/arm_scmi/mailbox.c b/drivers/firmware/arm_scmi/mailbox.c
index 0219a12e3209..b0a579f31905 100644
--- a/drivers/firmware/arm_scmi/mailbox.c
+++ b/drivers/firmware/arm_scmi/mailbox.c
@@ -178,11 +178,8 @@ static int mailbox_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	const char *desc = tx ? "Tx" : "Rx";
 	struct device *cdev = cinfo->dev;
 	struct scmi_mailbox *smbox;
-	struct device_node *shmem;
-	int ret, a2p_rx_chan, p2a_chan, p2a_rx_chan, idx = tx ? 0 : 1;
+	int ret, a2p_rx_chan, p2a_chan, p2a_rx_chan;
 	struct mbox_client *cl;
-	resource_size_t size;
-	struct resource res;
 
 	ret = mailbox_chan_validate(cdev, &a2p_rx_chan, &p2a_chan, &p2a_rx_chan);
 	if (ret)
@@ -195,25 +192,9 @@ static int mailbox_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	if (!smbox)
 		return -ENOMEM;
 
-	shmem = of_parse_phandle(cdev->of_node, "shmem", idx);
-	if (!of_device_is_compatible(shmem, "arm,scmi-shmem")) {
-		of_node_put(shmem);
-		return -ENXIO;
-	}
-
-	ret = of_address_to_resource(shmem, 0, &res);
-	of_node_put(shmem);
-	if (ret) {
-		dev_err(cdev, "failed to get SCMI %s shared memory\n", desc);
-		return ret;
-	}
-
-	size = resource_size(&res);
-	smbox->shmem = devm_ioremap(dev, res.start, size);
-	if (!smbox->shmem) {
-		dev_err(dev, "failed to ioremap SCMI %s shared memory\n", desc);
-		return -EADDRNOTAVAIL;
-	}
+	smbox->shmem = setup_shmem_iomap(cinfo, dev, tx);
+	if (IS_ERR(smbox->shmem))
+		return PTR_ERR(smbox->shmem);
 
 	cl = &smbox->cl;
 	cl->dev = cdev;
diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
index 4e7944b91e38..8abcd668108c 100644
--- a/drivers/firmware/arm_scmi/optee.c
+++ b/drivers/firmware/arm_scmi/optee.c
@@ -368,38 +368,11 @@ static int setup_dynamic_shmem(struct device *dev, struct scmi_optee_channel *ch
 static int setup_static_shmem(struct device *dev, struct scmi_chan_info *cinfo,
 			      struct scmi_optee_channel *channel)
 {
-	struct device_node *np;
-	resource_size_t size;
-	struct resource res;
-	int ret;
-
-	np = of_parse_phandle(cinfo->dev->of_node, "shmem", 0);
-	if (!of_device_is_compatible(np, "arm,scmi-shmem")) {
-		ret = -ENXIO;
-		goto out;
-	}
-
-	ret = of_address_to_resource(np, 0, &res);
-	if (ret) {
-		dev_err(dev, "Failed to get SCMI Tx shared memory\n");
-		goto out;
-	}
-
-	size = resource_size(&res);
+	channel->req.shmem = setup_shmem_iomap(cinfo, dev, true);
+	if (IS_ERR(channel->req.shmem))
+		return PTR_ERR(channel->req.shmem);
 
-	channel->req.shmem = devm_ioremap(dev, res.start, size);
-	if (!channel->req.shmem) {
-		dev_err(dev, "Failed to ioremap SCMI Tx shared memory\n");
-		ret = -EADDRNOTAVAIL;
-		goto out;
-	}
-
-	ret = 0;
-
-out:
-	of_node_put(np);
-
-	return ret;
+	return 0;
 }
 
 static int setup_shmem(struct device *dev, struct scmi_chan_info *cinfo,
diff --git a/drivers/firmware/arm_scmi/shmem.c b/drivers/firmware/arm_scmi/shmem.c
index b74e5a740f2c..c31f188d74ef 100644
--- a/drivers/firmware/arm_scmi/shmem.c
+++ b/drivers/firmware/arm_scmi/shmem.c
@@ -7,6 +7,8 @@
 
 #include <linux/ktime.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/processor.h>
 #include <linux/types.h>
 
@@ -133,3 +135,37 @@ bool shmem_channel_intr_enabled(struct scmi_shared_mem __iomem *shmem)
 {
 	return ioread32(&shmem->flags) & SCMI_SHMEM_FLAG_INTR_ENABLED;
 }
+
+void *__iomem
+setup_shmem_iomap(struct scmi_chan_info *cinfo, struct device *dev, bool tx)
+{
+	const char *desc = tx ? "Tx" : "Rx";
+	int ret, idx = tx ? 0 : 1;
+	struct device *cdev = cinfo->dev;
+	struct device_node *shmem;
+	resource_size_t size;
+	struct resource res;
+	void __iomem *addr;
+
+	shmem = of_parse_phandle(cdev->of_node, "shmem", idx);
+	if (!of_device_is_compatible(shmem, "arm,scmi-shmem")) {
+		of_node_put(shmem);
+		return ERR_PTR(-ENXIO);
+	}
+
+	ret = of_address_to_resource(shmem, 0, &res);
+	of_node_put(shmem);
+	if (ret) {
+		dev_err(cdev, "failed to get SCMI %s shared memory\n", desc);
+		return ERR_PTR(ret);
+	}
+
+	size = resource_size(&res);
+	addr = devm_ioremap(dev, res.start, size);
+	if (!addr) {
+		dev_err(dev, "failed to ioremap SCMI %s shared memory\n", desc);
+		return ERR_PTR(-EADDRNOTAVAIL);
+	}
+
+	return addr;
+}
-- 
2.37.1


