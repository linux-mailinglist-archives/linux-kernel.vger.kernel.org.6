Return-Path: <linux-kernel+bounces-245987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3821A92BC60
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E22AE286E39
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FD9194AEC;
	Tue,  9 Jul 2024 14:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WsvRIzd8"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011048.outbound.protection.outlook.com [52.101.70.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1091F194A6F;
	Tue,  9 Jul 2024 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720533678; cv=fail; b=GgZMNr5Mif56IBErto6/0XXclUj+Kga2u/Pz4/WJrj92gGMzhgOMV5MqQT+uq26WWePPD+8rx0JeLfFLNoWC59YeG7f7bko23+cll/hR9uIIAfQSJQ4xcPRVTPXUH/kv0ozdFEZsmjK9xNp5cqgu6GuRnLMmbkW3GrPA32SEwrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720533678; c=relaxed/simple;
	bh=WDL1u0FBwHrjnOuQU3MRTOLp0bf918fPuZ10O5p5csw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NHB3kRMlFlhkR07G6HDAUx/QkP/q/a4qGxbsGO7iFBHnzLdV6JyZrqmiD18uE6cat/83iSf7RQ6Ik0118duNDCTkEFaA2aRBxJ6030F1QhJdK0t45i9WVZISz85z/z2fBNMAILaHIARLp+U/+Myu/gtdNhr0zoE2LNsDwMAitno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WsvRIzd8; arc=fail smtp.client-ip=52.101.70.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeMbFGHRalINOSHgFSrKGnDgoR5VVbPbY0Bz6MPMOsZ2A3vWt10IOb23hg+bu8rWWQyCl/y/RlFzmNenJ+T/5yJq80OWSeY8f0ZWc7hze9+5xjXEwc1jzQJiEv24PbjmWdBBXxunuv6FBXpsDq+9DgIERNZCBXmyh6EVodKc9ISdHxdkWTJvOWaeh5OVvxDwxW0TXl13DA/7ZWPLwgnVUSw+HqThrfa/qhea0XWLzSVEBAF9KOjDiaLP2OF3op+U3NBnc7MuLyHfJvRKg04Mr3sanGtkjnyekO/TqXjjg0AEXamk2CY/cLMnUsKpwzTxg1XZKX9QwD+rN7cwtCNEpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4upfGYyhv3wfIPAR3t03xft5bnG8ay4hRhDOTNnfuc=;
 b=YBlVJlR6Ih5HgzzIMXTWLBe4b3VXupraElIc4bpoFO5nGXb7iG6QKt5zqWcFaYebLQX8FXteFN2TXGQMs/VfH1X5YvYFqAouvuPpUi8RtUJ5zMXUxid8Um+WkUyJ6cCmn/USvhjE47Pq2VrbH7eJMpbnIKZcxGAiPvVO04iknDfZ2MsyhlnB6A9dXDuVlY/b+XZ+cbblVe6Mw3cwcf+u5nXwMCsNp4p3hTSkFNMAdVPE9JltRpBsebnSf5ujv54c9I4p88Oj1uhN0fA3oc8s9dofAZaDk4OT4ebrGqLSRHS3bPZfhR5J3JiAs98JOmDMvYnhsZJF5qWO0ofbKUcgWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4upfGYyhv3wfIPAR3t03xft5bnG8ay4hRhDOTNnfuc=;
 b=WsvRIzd8P+toho5JCi30bxqI61unoerVYZBd9g4YUSOfJPfh6HHIKAKIgtEXiMgFgp3PMUMbZdlAqB6x3KdvsKUz+hIdgDtqO6mfHxMphCKwUKuZFprTpDHsDuJSDuOC8k9Y5URO491Lr2GuHlqvuqCnmrCuYzWaJdxGsvC0JFs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8622.eurprd04.prod.outlook.com (2603:10a6:102:219::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 14:01:12 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 14:01:12 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org,
	devicetree@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 2/2] firmware: arm_scmi: set mailbox timeout value from device tree
Date: Tue,  9 Jul 2024 22:09:57 +0800
Message-Id: <20240709140957.3171255-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240709140957.3171255-1-peng.fan@oss.nxp.com>
References: <20240709140957.3171255-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8622:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ed39383-e31b-460f-bc88-08dca01f976e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/OSFLw7L0H4FnQ5uP4oRHyHit9TnolWvM8bE9e/LvoSKCO9Bak07HtyBAYDd?=
 =?us-ascii?Q?odEWuH2DpMNHqct5h1yL8AwF9eOTpx5hdxrOSU/H3wb/QZ5ZGQ43Gh/BWIcQ?=
 =?us-ascii?Q?FKsi4vE4oh9Ov4kEo/i9zLYGPTFqYBLV+enXgfaJ4X39qW5SLoJQMdyAk7NM?=
 =?us-ascii?Q?k6WvX2W4hC1jUWxdA1QKblklivMnJ1fDbwf8P1i71jD6PqDOoanqc1CKwWSL?=
 =?us-ascii?Q?oAHJm8QfhhVeTG4uzI4M4aDYCH8QnIngKTRY0agt19rKbyEIvqJxbW8EGK5l?=
 =?us-ascii?Q?fwpmfenwlYYSvDvvMyaKppXZ8PuDDa9US//x2KKeU08IsEgxpHubeoXYAkqI?=
 =?us-ascii?Q?QW7Gud/vASXYuiHUk3UrUjN05oKsexG2wghGci5ly0D6RlRe2SSd7YNPdrGX?=
 =?us-ascii?Q?2ccwhwrw/Xi9WUBIw3Up+1abyBagspSbgJJFqzLuPXiHaHmxl97Wt6LuaIPJ?=
 =?us-ascii?Q?b6xXbALWkfXZip+Ij48LtT9BE4RN8Cw5csjU+zx9tcxVyHKBzI3+dUFYfr57?=
 =?us-ascii?Q?2J7L0fMyXi4Oma3kvG6yik74hocNQFjHz8/eZP5pHqXUT83fdbiNBAw3R/8F?=
 =?us-ascii?Q?vh3xsj3hBBevEQ4oqHELy/KhqLdue0GCfJLXUfg4YHYtbXT9VXA5yxK1YtjE?=
 =?us-ascii?Q?fZ5/UTrJPleERcgoS8pVJEEmk2yn6AFQtQzXzJtY5KIasMPmIRZH+c2fq0e+?=
 =?us-ascii?Q?We86G+1v32kDp9N5d43fyOPw/cdMuGsHb56JDgyzcCooI9et1iWE3ELlRvJx?=
 =?us-ascii?Q?XIOYXzX4os/sbeSqCzmhMGOutKoYMnQdrFedtu+G3ruqa97U2s33T0UDtU9i?=
 =?us-ascii?Q?8NdIL9BrUzMRVgVTEg4kkveibALhM3CUcJVr8aXg/Pp77EKQXIyCJZ4eL7nK?=
 =?us-ascii?Q?Ge3ArICKwXmqExGuJSW5iHP4CA7E8SRZqiHEuyX4oxnGgoEnts1vtRXqga77?=
 =?us-ascii?Q?xtu5J5h/xTPBtpgDsO2JPMvwP/ZWi/WCd9GSaY4ulFyb3SuQ6SRMi1LeWp54?=
 =?us-ascii?Q?JfdRBjN6ra2RTR1Oc+80WRsOuUsXlGaW4I/wnCbcQnj57XSPXEmQwY+ixrBG?=
 =?us-ascii?Q?OjhDb10r0I5qpLoK32n99KWZQ1mWVxa6TMi3aOSNqfD/X++17duCIstpFOaR?=
 =?us-ascii?Q?WIqstJAjY8w0Ms42CiO0TUMQgU9KXNfUXrSbRcTNKNqzTKnmzNB0cUiY1eGp?=
 =?us-ascii?Q?y79LJFYfKr6gq8spdowFnOe59EeLV1iSMz9PQNxih3htfDUL1GsTkOoRpUX3?=
 =?us-ascii?Q?I2Kuy1dR/seBx1KD/xl6ltPykZlteDOUIR6sPjhuYKbpRtYycvCx1k8JmmHP?=
 =?us-ascii?Q?iiD5Ue+CPUhnrtZlE39DwB6W5aH56FFg9O6tra8nRhqo31dI8eTQeBxyDuJ6?=
 =?us-ascii?Q?2PlxLz+EyvkmoDY678h7mIhDcSrC6e7FCsoQZO+aJ/c+DN2WZA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oA1LkSZ7J247P3nQtcBvKALon2Bya2bHa99QuSW3UDKWErjMdN9vdAJETLsD?=
 =?us-ascii?Q?mX1HWBGXRBdYACY+b6tE6+issi7KFqqoXnVl4QriSpwp8Sp/qUlEJBTe7Zvn?=
 =?us-ascii?Q?BzrWHswred7UMCmEpIl63BEjlg6PS3Ueioqb5axGZv5FV2Mo+02cJY0dR0k/?=
 =?us-ascii?Q?yY7Q5m8HTsyh6vGGwruR+AHP6C6UGI7khB+frOFCTJv0wGjoYuIqb/ok3iUz?=
 =?us-ascii?Q?KeyK5ixdj1Co8sNv0iSIM6RNy+rUqspjI8stYmE9ip11/gf1WTr4TrOyIda9?=
 =?us-ascii?Q?aeFlXX0XA4QfMEkLTrCUXPlzBvaBLTuYw44oob8uF/otKbJ4wCS8xa4oZwrU?=
 =?us-ascii?Q?v8EHe/343z4MC1dcLYq5R5Aq/jL1aYVZ39KMo8tmOAdru6MYSm8hPwHimRBU?=
 =?us-ascii?Q?agUonjqrjiYSmsmOobqGT2joHvrPqqTLKzrKMXGcznmXnGIVALEhGjwV8WGA?=
 =?us-ascii?Q?q5e0Wr7m16eaLTRfNZ7GvbFAiOGMKo1SZlYFcxGtULXkAgTBMqemHPdX7S57?=
 =?us-ascii?Q?9er2Jeo2JhhWLHM3Fcx0OuGUZrH6nTUIO6SBfh7tBWxy73whIoO8rWYCmIR1?=
 =?us-ascii?Q?X9XjqWzR73Zg0IjTtF8i/Age+6eVRwrMg1b60PgWrChushE7e9zc+N0jpPNx?=
 =?us-ascii?Q?5wMXPuAcYpJcNurCKCyqlrjIfHonT1bmQAtHme77jbMvmGDPRfhyExXcCVnW?=
 =?us-ascii?Q?Q+lEyfMLJ1XM/qqRR4SMlUaHKfxHiLq02Zbra7hDcmR2bMDFn/JeitX3usR0?=
 =?us-ascii?Q?QP23nd7uGyxVbPTQpuN+BulKAERkhpGm2REi2UJeSBp27+EtLKD9qBCKhGm0?=
 =?us-ascii?Q?xFnYPBwmeiz/wXlFCddOUzmM7bhxugcS+EtCZebmGNCjmnn5uCRR3t1i3da8?=
 =?us-ascii?Q?VnriowvhoBBj1HnOBMWrsLygLoUcqtmFLHdskWTt9rowoMua1PbC7QkffAs/?=
 =?us-ascii?Q?jUfyulRU4SNDehIOe3xrPytEahLGvGIkbUFYa85uF+6NNxWTcbkeKzqACSnP?=
 =?us-ascii?Q?n19pxAVXZQo3Zw9FYMucdfk0FM0U7almMuavryvGgH2TZs3Mkt4rZn3vaULd?=
 =?us-ascii?Q?2RBM4NarparJbqHTif9yLLM0OYRIg8ugF2v0IRvLSIc3ZmewheH7DO2qa9Vu?=
 =?us-ascii?Q?bA2LX9vdNWvn2EGgbbj0kGyuqpcrHjt3zGx3vcpXcgYTknQ0wS+GVCk9mWDp?=
 =?us-ascii?Q?aV1EmMt19MHPBmDXuss+YU21eTzQqzOIkbxq9Qqr9L2lr1TYEAr8ARbaKE1+?=
 =?us-ascii?Q?+Ba+nhvWmLYfrzeyeW7BXiNisdmNJ7wZDc+xCdzVVDAB/hvauFySCXgVRruw?=
 =?us-ascii?Q?+BrxTITK0q9H0q55ebwyMgy7T0dewhjn2Hxs/08sA6YYRtPlrMyR5Y/e7kfX?=
 =?us-ascii?Q?+jDE0ycoY5/KXtqV37oDaRJJvECXKIw4/19/MhRh+7YJLt4kb5em26vigv41?=
 =?us-ascii?Q?VgvbzWxvZwUIu4iCxgyEWhyH6GqEwcv7N5eGNJSrlPXZNUeg/7be76WbBQdn?=
 =?us-ascii?Q?7j6EvQzwF9pvqQGZn01Gu5hmb/gPJujoYVliwrDiDzLkt0MP7UDQdyY26uEB?=
 =?us-ascii?Q?b9iXpzJbcKV4ZgSA5dYeI2F65+xAVsHgehGqcV+t?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed39383-e31b-460f-bc88-08dca01f976e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 14:01:12.7778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zg9Q0dH1MKyNRD8HB+Tv34dOddy6jMyM+Y1k8clY5+Fy59O+EWWy3lRGtqSOsyUzi35B0RT8AG3NNlNQsJY0GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8622

From: Peng Fan <peng.fan@nxp.com>

Each platform might have its own maximum mailbox receive channel timeout
value, so get property max-rx-timeout-ms from device tree and use it. If
the property does not exist, use mailbox 'scmi_desc' fixed value 30ms as
before.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V3:
 None
V2:
 Fix build error for raw mode.

 drivers/firmware/arm_scmi/driver.c   | 19 ++++++++++++++-----
 drivers/firmware/arm_scmi/raw_mode.c | 13 +++++++++----
 drivers/firmware/arm_scmi/raw_mode.h |  3 ++-
 3 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 6b6957f4743f..1aa613d4cb43 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -162,6 +162,7 @@ struct scmi_debug_info {
  * @devreq_mtx: A mutex to serialize device creation for this SCMI instance
  * @dbg: A pointer to debugfs related data (if any)
  * @raw: An opaque reference handle used by SCMI Raw mode.
+ * @max_rx_timeout_ms: the maximum receive channel timeout value
  */
 struct scmi_info {
 	int id;
@@ -188,6 +189,7 @@ struct scmi_info {
 	struct mutex devreq_mtx;
 	struct scmi_debug_info *dbg;
 	void *raw;
+	unsigned int max_rx_timeout_ms;
 };
 
 #define handle_to_scmi_info(h)	container_of(h, struct scmi_info, handle)
@@ -1302,11 +1304,11 @@ static int scmi_wait_for_message_response(struct scmi_chan_info *cinfo,
 
 	trace_scmi_xfer_response_wait(xfer->transfer_id, xfer->hdr.id,
 				      xfer->hdr.protocol_id, xfer->hdr.seq,
-				      info->desc->max_rx_timeout_ms,
+				      info->max_rx_timeout_ms,
 				      xfer->hdr.poll_completion);
 
 	return scmi_wait_for_reply(dev, info->desc, cinfo, xfer,
-				   info->desc->max_rx_timeout_ms);
+				   info->max_rx_timeout_ms);
 }
 
 /**
@@ -2614,7 +2616,7 @@ static int scmi_chan_setup(struct scmi_info *info, struct device_node *of_node,
 	if (!cinfo)
 		return -ENOMEM;
 
-	cinfo->rx_timeout_ms = info->desc->max_rx_timeout_ms;
+	cinfo->rx_timeout_ms = info->max_rx_timeout_ms;
 
 	/* Create a unique name for this transport device */
 	snprintf(name, 32, "__scmi_transport_device_%s_%02X",
@@ -2888,7 +2890,7 @@ static struct scmi_debug_info *scmi_debugfs_common_setup(struct scmi_info *info)
 	debugfs_create_bool("is_atomic", 0400, trans, &dbg->is_atomic);
 
 	debugfs_create_u32("max_rx_timeout_ms", 0400, trans,
-			   (u32 *)&info->desc->max_rx_timeout_ms);
+			   (u32 *)&info->max_rx_timeout_ms);
 
 	debugfs_create_u32("max_msg_size", 0400, trans,
 			   (u32 *)&info->desc->max_msg_size);
@@ -2940,7 +2942,8 @@ static int scmi_debugfs_raw_mode_setup(struct scmi_info *info)
 
 	info->raw = scmi_raw_mode_init(&info->handle, info->dbg->top_dentry,
 				       info->id, channels, num_chans,
-				       info->desc, info->tx_minfo.max_msg);
+				       info->desc, info->tx_minfo.max_msg,
+				       info->max_rx_timeout_ms);
 	if (IS_ERR(info->raw)) {
 		dev_err(info->dev, "Failed to initialize SCMI RAW Mode !\n");
 		ret = PTR_ERR(info->raw);
@@ -2953,6 +2956,7 @@ static int scmi_debugfs_raw_mode_setup(struct scmi_info *info)
 static int scmi_probe(struct platform_device *pdev)
 {
 	int ret;
+	u32 timeout;
 	char *err_str = "probe failure\n";
 	struct scmi_handle *handle;
 	const struct scmi_desc *desc;
@@ -3002,6 +3006,11 @@ static int scmi_probe(struct platform_device *pdev)
 			 info->atomic_threshold);
 	handle->is_transport_atomic = scmi_is_transport_atomic;
 
+	if (!of_property_read_u32(np, "max-rx-timeout-ms", &timeout))
+		info->max_rx_timeout_ms = timeout;
+	else
+		info->max_rx_timeout_ms = info->desc->max_rx_timeout_ms;
+
 	if (desc->ops->link_supplier) {
 		ret = desc->ops->link_supplier(dev);
 		if (ret) {
diff --git a/drivers/firmware/arm_scmi/raw_mode.c b/drivers/firmware/arm_scmi/raw_mode.c
index 130d13e9cd6b..06a764d106f8 100644
--- a/drivers/firmware/arm_scmi/raw_mode.c
+++ b/drivers/firmware/arm_scmi/raw_mode.c
@@ -165,6 +165,7 @@ struct scmi_raw_queue {
  * @wait_wq: A workqueue reference to the created workqueue
  * @dentry: Top debugfs root dentry for SCMI Raw
  * @gid: A group ID used for devres accounting
+ * @max_rx_timeout_ms: Max receive channel timeout value
  *
  * Note that this descriptor is passed back to the core after SCMI Raw is
  * initialized as an opaque handle to use by subsequent SCMI Raw call hooks.
@@ -187,6 +188,7 @@ struct scmi_raw_mode_info {
 	struct workqueue_struct	*wait_wq;
 	struct dentry *dentry;
 	void *gid;
+	u32 max_rx_timeout_ms;
 };
 
 /**
@@ -379,7 +381,7 @@ static void scmi_xfer_raw_waiter_enqueue(struct scmi_raw_mode_info *raw,
 	trace_scmi_xfer_response_wait(rw->xfer->transfer_id, rw->xfer->hdr.id,
 				      rw->xfer->hdr.protocol_id,
 				      rw->xfer->hdr.seq,
-				      raw->desc->max_rx_timeout_ms,
+				      raw->max_rx_timeout_ms,
 				      rw->xfer->hdr.poll_completion);
 
 	mutex_lock(&raw->active_mtx);
@@ -437,7 +439,7 @@ static void scmi_xfer_raw_worker(struct work_struct *work)
 
 	raw = container_of(work, struct scmi_raw_mode_info, waiters_work);
 	dev = raw->handle->dev;
-	max_tmo = msecs_to_jiffies(raw->desc->max_rx_timeout_ms);
+	max_tmo = msecs_to_jiffies(raw->max_rx_timeout_ms);
 
 	do {
 		int ret = 0;
@@ -574,7 +576,7 @@ static int scmi_xfer_raw_get_init(struct scmi_raw_mode_info *raw, void *buf,
 			dev_dbg(dev,
 				"...retrying[%d] inflight registration\n",
 				retry);
-			msleep(raw->desc->max_rx_timeout_ms /
+			msleep(raw->max_rx_timeout_ms /
 			       SCMI_XFER_RAW_MAX_RETRIES);
 		}
 	} while (ret && --retry);
@@ -1162,6 +1164,7 @@ static int scmi_raw_mode_setup(struct scmi_raw_mode_info *raw,
  * @num_chans: The number of entries in @channels
  * @desc: Reference to the transport operations
  * @tx_max_msg: Max number of in-flight messages allowed by the transport
+ * @max_rx_timeout_ms: Max receive channel timeout value
  *
  * This function prepare the SCMI Raw stack and creates the debugfs API.
  *
@@ -1170,7 +1173,8 @@ static int scmi_raw_mode_setup(struct scmi_raw_mode_info *raw,
 void *scmi_raw_mode_init(const struct scmi_handle *handle,
 			 struct dentry *top_dentry, int instance_id,
 			 u8 *channels, int num_chans,
-			 const struct scmi_desc *desc, int tx_max_msg)
+			 const struct scmi_desc *desc, int tx_max_msg,
+			 u32 max_rx_timeout_ms)
 {
 	int ret;
 	struct scmi_raw_mode_info *raw;
@@ -1188,6 +1192,7 @@ void *scmi_raw_mode_init(const struct scmi_handle *handle,
 	raw->desc = desc;
 	raw->tx_max_msg = tx_max_msg;
 	raw->id = instance_id;
+	raw->max_rx_timeout_ms = max_rx_timeout_ms;
 
 	ret = scmi_raw_mode_setup(raw, channels, num_chans);
 	if (ret) {
diff --git a/drivers/firmware/arm_scmi/raw_mode.h b/drivers/firmware/arm_scmi/raw_mode.h
index 8af756a83fd1..25d4a46261e7 100644
--- a/drivers/firmware/arm_scmi/raw_mode.h
+++ b/drivers/firmware/arm_scmi/raw_mode.h
@@ -20,7 +20,8 @@ enum {
 void *scmi_raw_mode_init(const struct scmi_handle *handle,
 			 struct dentry *top_dentry, int instance_id,
 			 u8 *channels, int num_chans,
-			 const struct scmi_desc *desc, int tx_max_msg);
+			 const struct scmi_desc *desc, int tx_max_msg,
+			 u32 max_rx_timeout_ms);
 void scmi_raw_mode_cleanup(void *raw);
 
 void scmi_raw_message_report(void *raw, struct scmi_xfer *xfer,
-- 
2.37.1


