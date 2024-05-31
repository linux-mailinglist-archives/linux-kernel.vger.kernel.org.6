Return-Path: <linux-kernel+bounces-197156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1128D66E4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA4C1C21046
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E626415CD7F;
	Fri, 31 May 2024 16:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K8HkuLln"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2081.outbound.protection.outlook.com [40.107.6.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7414F15D5A6
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717173203; cv=fail; b=sq4EAfKRd0yiHvnUF2z8k+LoGb9EpGkams3Duo3sqJ+K8KDkcMkTpvrfHoyBy3U5+erBwLEPfNCeDAC3byJLCpFvk3XUCnnU47t64VHoTwfrXqxp1G9ByZILOzWjFCj/kJQZemyszgYdGaBiYkqn93OmpkBwCgxgJ4Aa7623oTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717173203; c=relaxed/simple;
	bh=Ghpe2PBxMJvA9M+XfCvvAcoc30m7q+ocjEHykEl3mmg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XBf2j1FGTGSMJt9DTEjSueBXSHUL+r41MmuMbKXvvo3r3izqa/TlXuEiQnduSanNKbrRjV/1k3wTrR1GUzav8uSCS2sC9URKNNlfdkQdtTn8R7Bh0g2d+y1Se1EZb74ZfsFcp8vRD6EBxTVl/917oEaZbFdSrdLNhAr61Z4R46o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=K8HkuLln; arc=fail smtp.client-ip=40.107.6.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KnKoJOGFV/0n/0JMwI4d6v4o5SAEzD5XVFTpn8vuJ/NdjJbJE5/2mNHqk3SBALl08Hi64pNhayRy5NV3TqiByxLVhBo/H5t71KmICkihHQbwtLvemZNmJq0SXoXsuo91G4y9MA3xAXG7WrHRAzNKlLmnlm4oumvNwMvmmOtv5AtRfif5ez/ptoGDRsmOUC4/lSp49H71Mzm0eVaBnYu0IR1tlrPBYo7NvgvVyMfPsyC6hH6kxQPTaXpIZUwG+cwlx6X95bPNJJ1ThCXCSFc1MEASXoJAxUC2k9NnRTbTGFaM8hplZi7DCA9m7WEZP7TtzAKLSk3XSB4feaFhOwWAAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRJ/O0ryhVZY+/ZZv17Sbp7hjtMigMkBXC8btHCtd8M=;
 b=mvnmG6fvKn3muzHWUMVMOjuX1Bml9Zbu4+DH0/o6WE+wO8TGJNjXkGxXuXXX4Q2ehOJgrgHM+I1JcvFoSwbs3QPQWfstzwQFT4ykJFCwRoxVYaJdE7NYBdoc29QZUCUdVVoln6sqMRvoqlxKI9iWfu41aNijxZWJgzeOEfOFSWNUM19ysURgmciiqPjix+QO1AA7daSlDu66bqccPX+WC/jF2UmKpkZTdP1ctmcT9X/Ak+62oIE7KBj8xhhVe6GX1IAahQMwW1+St1Vy5MxXbgSMWVqVYcuaYZHypc4WL4+/jy2SAsuDwvC0AQaNz8hUk/fiM/qDh972o+cI9pr62g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRJ/O0ryhVZY+/ZZv17Sbp7hjtMigMkBXC8btHCtd8M=;
 b=K8HkuLln799WXnZJUtxksZ6vhYZgD10fLo2+wPf5JX6VBXKe1clw+mUUO9qUSJdtnaNsrcbf7hTVSs0WIsU18eBrBcrwYh1CcByWSHCCqRn9s6U1nqKzx9hlZDNzR7Kz62MoDWN3eIuY8qS862iEaHrYUJFuwDGPM14VWLM+we4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB11066.eurprd04.prod.outlook.com (2603:10a6:150:224::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.27; Fri, 31 May
 2024 16:33:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 16:33:18 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Culhane <conor.culhane@silvaco.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-i3c@lists.infradead.org (moderated list:SILVACO I3C DUAL-ROLE MASTER),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] i3c: master: svc: resend target address when get NACK
Date: Fri, 31 May 2024 12:33:00 -0400
Message-Id: <20240531163301.1401281-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0141.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB11066:EE_
X-MS-Office365-Filtering-Correlation-Id: 2080b874-9666-4995-cb5c-08dc818f6107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|52116005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iPI/iGSMWb/6LO89RXqrVjjd3PpHGrZP/hQZ15fBUNw2pyTm7R9ufSXiJFOp?=
 =?us-ascii?Q?YBj+e2mS3N5jvIRGZpfQAKTUI+on0t5osUKlN++jpWfrTZnkCdxoMMLk5ri5?=
 =?us-ascii?Q?ixfjA7yypNTFkVJuzmBZMR+cL7PAYDXPT+YNi/uKmbZAEa1PBSQQc1W4CQHP?=
 =?us-ascii?Q?Noujv+flDW8oGoTfd17HOSMGxkzSjgPnwm8W6tU9M+6kY/F4RscjtGPLOKUY?=
 =?us-ascii?Q?EWX39inQZaeibmHmbNOzlWS5iqgcGDA8p4KHqt4xihRtqbNfW7+LzgMOa3nW?=
 =?us-ascii?Q?eI1nvew2d6FaB3rKsaz+Z0d6c23sF+0CBw8cv+ZWnrto84ZZknyESDmg+7jL?=
 =?us-ascii?Q?UW3kWO5MFSaIrYT7c+4CmTI4FC2JewpvO1Z+81Uh5ePFa7NZFcJ6vvCf05ep?=
 =?us-ascii?Q?KLLhm1fdSKVq8YFrSWpM/61uishItQH8D23kR/oxEZMVqASXk6DPyj4rjKgh?=
 =?us-ascii?Q?yzBACSJoNUQNs3OyiJhE8Ick1QWdFksguKzplLbWA0f1Q139ufqn4PgQre5o?=
 =?us-ascii?Q?a51HUIXVJodTG9hkFTVE+MOUz/w/afX+AD/eJdQ0cKqc10jWB4LadWGCFJah?=
 =?us-ascii?Q?ArC6xzIuBIgJTZcPNRkYX3V39ppd08yidGpbP3X9BJ++AEnfQoAhDiOlO4+L?=
 =?us-ascii?Q?2EjOxZqIlQ4C8Z2pjAt6goCfpml0YqYcdFmNzk7QKIb864ev4lq7xVWEZFdU?=
 =?us-ascii?Q?VFcPDtA0hpri7Y6SCe7IfPypDiFsz4iN/vxV+qOzk7gzRUWNlbPbdkNJQKtV?=
 =?us-ascii?Q?wCIxXehlq0hUHvmUgsisNGX5qOy5/u5xCtDeALtLV267oZGzD3xFyNVpXASq?=
 =?us-ascii?Q?bBJP19kgNHbGLj4qWVtUSei4qvrNHwX2Tbqx4TtaAOEu8ArVk+BJCq88xuda?=
 =?us-ascii?Q?SroAzgit0lXLU6S+cLmCrxFbf3ZRRnC0mnD+jBxFmaZhFYa5pD7MlGFv4+Us?=
 =?us-ascii?Q?tVE+ID3cCYxSRWLHrnWq5PsgRO9YT8OzAwv1PN+7IKEjDPUZLq/H5ayw21Yz?=
 =?us-ascii?Q?uxZAomBvTkwDKDwsutjB472ecS2pK+v/f2LP2wPou0HAWW9hUyQ6zrrW1Ng9?=
 =?us-ascii?Q?m6OvgO3QpDGcZ9vkRa3rluyq9KSet/JOE1rISKkQc15vpcJw2IMKzaTheLS4?=
 =?us-ascii?Q?lo6/lIlzttWe6L+y8gW6pAxe3YFn4JLeGDOYyG7GBu38GfPmDDOdQBJgPSaM?=
 =?us-ascii?Q?Eh/gwAMNCCu31BmKTx2/KESBIE2ObJWAkXc6oV8Mz76LfXRGJj715avcZl7N?=
 =?us-ascii?Q?yf2Qm5eAdEkWOmevxtf8evA6a6Rp3y1ZuP7Kwz1qXwsOzGMhCKeX24G8w39G?=
 =?us-ascii?Q?K5GABMuHl5bW7PimrwFfQQ24YUAerbpwYSdAMO837mMI+w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?40eMn6Z3wgddlja0rbc2FjygJcnBGapQqutZVFwbHL6DH3tMAhaChlB0tzNU?=
 =?us-ascii?Q?2LV/fGDWtziVjmPjJ5ciqEodRdoqvgR3jzT7v3pW1JQPIdrwgtYjxB5o+MY8?=
 =?us-ascii?Q?bdpQBuBtX60IR6Dit+6mDPrJSbpN0/VvkFxKeXCtNymgA6YkOcHRW9XFSWno?=
 =?us-ascii?Q?hvGuUIM80J3Eslr4l3cO3Rc/Amb7YPI7PaDS4Eglyl0yC1ryieZoEavG5TYr?=
 =?us-ascii?Q?odVv184TxRByaf0qOnbsdMPVnunTRhBcvxNej+e0tgRCaQSxbnh5ltLvL6jD?=
 =?us-ascii?Q?qPgYJRrlaavHTmB1on7jDcRxkFEuQaIw6HbbBKCrjyComzAHi/cHDTos6ocf?=
 =?us-ascii?Q?ZPNXqZVJb7P9Pd2zgrHnb8B/MS3xAwnKQPcrTTq/8jsiYL8ZXTTjZJ+Q0tXf?=
 =?us-ascii?Q?gzjW6cfcJZZJNsQhuHOp2OTJ6CEWjSVlOjSvhUUVlZPhRBQUbbbCn2G0/mfp?=
 =?us-ascii?Q?G+oFIo/pwHy/nU88Ysb562CJB9+IwV0lRN15T7BYFHm4X9HUNyO4KIhw95p5?=
 =?us-ascii?Q?zj85caTcPZDOydhRsiVjMlTI2in83mU61fkuqRJxIY4BGhj7YNodYLn8KQ4N?=
 =?us-ascii?Q?xLlG16/4z8EW7GI1AOM4R7MuUK8bwA7yCpBR12mPeSwgc0uCMbwUEOmXw5Wq?=
 =?us-ascii?Q?VUvYFpPY04QFjM/pdFuI00dl5W3d12cGmyOIqOHRKLY9v0LdxQn6E8K4fyo1?=
 =?us-ascii?Q?RvevAesHJ2mkU6oY57q4LA6h7Af8S9MIvJkhjQSj9VQ/DMjU+nE9uHCBBkh+?=
 =?us-ascii?Q?Op915URW12N9o4eCV+i1Cpp+673weWtyUCkJr+1wE2LOuEJFHKF4OSsRNC8c?=
 =?us-ascii?Q?NeYOW9ds0ebJVwTa82o0WTCn82+pfNLLru/qUTLfO6ow0ZJX6Bj//RDPuJ9/?=
 =?us-ascii?Q?0JVuitBRzeJYLmvWOfKcBHrOokT+nOzs4+DzMjv/EVmkNBBpy+irCxV9gPvg?=
 =?us-ascii?Q?9WziqZ1ARFVXbS4xJEr2GVdUzoV7+GaG4SWTv0XHFOPjIwrzVMxVyircYAyl?=
 =?us-ascii?Q?5pYK4EBP3Y0kJKJGsEAB4DrYiIzmMW+pL+ObCa/aoLRrZcfiktyrzhQpCYq0?=
 =?us-ascii?Q?Yhg/awj0qnrvzFmTcUN9SO2rpH2KKlNLgS3OW2NTHjqNIRnk/YCeMEHz56fP?=
 =?us-ascii?Q?wdfbBwEYJZsS083qFQQ1h9t36A4hjAVx0KI7E194piz2ZXB09btq4hpn16Fz?=
 =?us-ascii?Q?I+HXsLTB9FriRWWVtWKS9T9AzyvuOJjs48URyXuErcdPN38yVm8SZKboA0n/?=
 =?us-ascii?Q?N7rhVD9AEKTkBm1O+akc/t3lodz6hhPCz7uZZhueVcfeWQUgthCaR514QI7b?=
 =?us-ascii?Q?5KkTEPR9TymWJfnmjGck/3xs2ptjHLDWMHU+hwfZ5A3gaUc/9KEoz+1J5QUV?=
 =?us-ascii?Q?T+fzX/4mRXOcG5UMB20Zb48iDikbYvFxPlXVgoChCLvBrJJxfbHVKLsiu1kJ?=
 =?us-ascii?Q?oukCZaIPFZy/FqR2/R4uPhnsBd7mCGNm06J188KD0/42hEPPE2sriDrR/NIZ?=
 =?us-ascii?Q?QPjXVb3uv++D550JSPJcyHQmZzO/dIIN5JVfnkJiEA1deIDq77tsQTSB23HR?=
 =?us-ascii?Q?OOLMO1GnBsGKGfF1A18X6y2Xc01HkhVtADFsD2Jk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2080b874-9666-4995-cb5c-08dc818f6107
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:33:18.9149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NpaTI5/Hq2fB2reXMJTTbk+GtnMeLNJXlqa+VsSxFk1gEdP1cSvJD3O6f2aX3GZAeE6bFyOV55S1cRyypIC6Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11066

According to I3C Spec 1.1.1, 11-Jun-2021, section: 5.1.2.2.3:

If the Controller chooses to start an I3C Message with an I3C Dynamic
Address, then special provisions shall be made because that same I3C Target
may be initiating an IBI or a Controller Role Request. So, one of three
things may happen: (skip 1, 2)

3. The Addresses match and the RnW bits also match, and so neither
Controller nor Target will ACK since both are expecting the other side to
provide ACK. As a result, each side might think it had "won" arbitration,
but neither side would continue, as each would subsequently see that the
other did not provide ACK.
..
For either value of RnW: Due to the NACK, the Controller shall defer the
Private Write or Private Read, and should typically transmit the Target
						    ^^^^^^^^^^^^^^^^^^^
Address again after a Repeated START (i.e., the next one or any one prior
^^^^^^^^^^^^^
to a STOP in the Frame). Since the Address Header following a Repeated
START is not arbitrated, the Controller will always win (see Section
5.1.2.2.4).

Resend target address again if address is not 7E and controller get NACK.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 58 ++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 14 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 032fe032ec433..0b588ed5894ea 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1052,29 +1052,59 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 			       u8 *in, const u8 *out, unsigned int xfer_len,
 			       unsigned int *actual_len, bool continued)
 {
+	int retry = 2;
 	u32 reg;
 	int ret;
 
 	/* clean SVC_I3C_MINT_IBIWON w1c bits */
 	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
 
-	writel(SVC_I3C_MCTRL_REQUEST_START_ADDR |
-	       xfer_type |
-	       SVC_I3C_MCTRL_IBIRESP_NACK |
-	       SVC_I3C_MCTRL_DIR(rnw) |
-	       SVC_I3C_MCTRL_ADDR(addr) |
-	       SVC_I3C_MCTRL_RDTERM(*actual_len),
-	       master->regs + SVC_I3C_MCTRL);
 
-	ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
+	while (retry--) {
+		writel(SVC_I3C_MCTRL_REQUEST_START_ADDR |
+		       xfer_type |
+		       SVC_I3C_MCTRL_IBIRESP_NACK |
+		       SVC_I3C_MCTRL_DIR(rnw) |
+		       SVC_I3C_MCTRL_ADDR(addr) |
+		       SVC_I3C_MCTRL_RDTERM(*actual_len),
+		       master->regs + SVC_I3C_MCTRL);
+
+		ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
 				 SVC_I3C_MSTATUS_MCTRLDONE(reg), 0, 1000);
-	if (ret)
-		goto emit_stop;
+		if (ret)
+			goto emit_stop;
 
-	if (readl(master->regs + SVC_I3C_MERRWARN) & SVC_I3C_MERRWARN_NACK) {
-		ret = -ENXIO;
-		*actual_len = 0;
-		goto emit_stop;
+		if (readl(master->regs + SVC_I3C_MERRWARN) & SVC_I3C_MERRWARN_NACK) {
+			/*
+			 * According to I3C Spec 1.1.1, 11-Jun-2021, section: 5.1.2.2.3.
+			 * If the Controller chooses to start an I3C Message with an I3C Dynamic
+			 * Address, then special provisions shall be made because that same I3C
+			 * Target may be initiating an IBI or a Controller Role Request. So, one of
+			 * three things may happen: (skip 1, 2)
+			 *
+			 * 3. The Addresses match and the RnW bits also match, and so neither
+			 * Controller nor Target will ACK since both are expecting the other side to
+			 * provide ACK. As a result, each side might think it had "won" arbitration,
+			 * but neither side would continue, as each would subsequently see that the
+			 * other did not provide ACK.
+			 * ...
+			 * For either value of RnW: Due to the NACK, the Controller shall defer the
+			 * Private Write or Private Read, and should typically transmit the Target
+			 * Address again after a Repeated START (i.e., the next one or any one prior
+			 * to a STOP in the Frame). Since the Address Header following a Repeated
+			 * START is not arbitrated, the Controller will always win (see Section
+			 * 5.1.2.2.4).
+			 */
+			if (retry && addr != 0x7e) {
+				writel(SVC_I3C_MERRWARN_NACK, master->regs + SVC_I3C_MERRWARN);
+			} else {
+				ret = -ENXIO;
+				*actual_len = 0;
+				goto emit_stop;
+			}
+		} else {
+			break;
+		}
 	}
 
 	/*
-- 
2.34.1


