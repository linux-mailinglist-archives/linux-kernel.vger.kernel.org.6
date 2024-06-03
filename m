Return-Path: <linux-kernel+bounces-199348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85FF8D85DA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24043B22648
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95D9130A79;
	Mon,  3 Jun 2024 15:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Grv1oISL"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2086.outbound.protection.outlook.com [40.107.22.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FDB12E1FF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717427749; cv=fail; b=BzYAAr2RB1Laqzj4KesxxZfAwKD1t87twhe8NPF/LvkENvY4H+4jCLwEJhva47YVld0PWVPvrxt4vgZ1sde/GL3GPUTgmwUQMwsQDk82ICGrbXIt4dyqdSGgGbNPaKjlvPSAAfHvD7O+CtEuctpzb9bJ+yEAc4pfGwGdXExWr1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717427749; c=relaxed/simple;
	bh=R3T2YhhdGL1I7RAGbgR1nuUccLzzRYCmINE5Q4q82PE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t+ayx05ILtABr9eHMYsbTBrrN8IC2tq9IrPcOXfBpIZIT45BfNbn08LV3flqSeBJkicdFYeBXIF/EbfwSIYnqZG5wkBx31wz3yY/B/ohzsgI7D3N8O/XGFINrbuPydl0WinmDTHvxbAjIWqezq7afBaGegmUqmMiAlz0EMAAD88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Grv1oISL; arc=fail smtp.client-ip=40.107.22.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxtNWgPUFynpkHHO3sH58rzAnhU9ynK6hu4LkbB7QA7JjkU3839MhIWrjF35GOsVChLgs+wf5u1sY07GJhfC+1be9DCKd3M5Fk+OJUiMPiZyvVd6iWAq7/Hwcd0sj0Fq/hiydUo8YgNclK7kRr5IxEbyHnftq2Mat3aXyHhhmOx8D2ybHPLuI+v+62WN0QIkWleU33LeXtMf1tF6+nzQL3Zn1r9u95FbsgP/SsfiGb90VCHEOjY9kMJQdQHlP96XXlNgHdJnjkYvxpNycJ+K0MiagL+lhkKo7fedf07jTCvI1ud8sJRw4F2zVyNI8rS5KHj4f3urx8KDZkk3bU0sOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWisBc9PQkOmgHG+ALPjmuDuF3UjhVUe3DAd/6Qs2bc=;
 b=VcWQm7BVzxeu6ICzUX1QukXJ1RbyJfVfyn63e2qKqQOH30y72fCC6zq+73uUhcUQR+mJb9dVbFowqwBqZ23GrmKjuj5f/IjkRkYHWopIZjO5Xwn5pLSGkKx/aQpO2QwsNYPvHTvG6erHX0Dy/VMCiyGNm0YlvFpmdF6KAQwDPdBo9xqLGJ7+1wQU75Ecqt0Pqd59HQ/WaWQYCGsNJiwbY/TwwlfPV8sOhoPgtSU6AMA+y/IJIw8JVnLtIZ0rpFWj97lgYSk7mz+YyHkd3ByN17Ql8WbohZMW6hja0Plmjk0Y/Auc3GZhHWMGLTyn79xwUJ8Y6WKma4RzaCnYIGrKHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWisBc9PQkOmgHG+ALPjmuDuF3UjhVUe3DAd/6Qs2bc=;
 b=Grv1oISLXfbOFiHWC3uz4u2rnX5Z5rsbbZoqVPvIAJxWaZzEqo4UNWfPcIklFud2EKrESvjhpDjumhbnZuyDznpykwhfeq9I7OJpJB7v4pv1DfCF52f4A+NiKdGPLs3wdLpXAJYpJHArcHLy+fq3+uq64qjN5ROlP/LdoenD1bs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS4PR04MB9624.eurprd04.prod.outlook.com (2603:10a6:20b:4ce::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Mon, 3 Jun
 2024 15:15:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 15:15:45 +0000
From: Frank Li <Frank.Li@nxp.com>
To: miquel.raynal@bootlin.com
Cc: Frank.Li@nxp.com,
	alexandre.belloni@bootlin.com,
	conor.culhane@silvaco.com,
	imx@lists.linux.dev,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] i3c: master: svc: resend target address when get NACK
Date: Mon,  3 Jun 2024 11:15:27 -0400
Message-Id: <20240603151527.52235-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603151527.52235-1-Frank.Li@nxp.com>
References: <20240603151527.52235-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:a03:217::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS4PR04MB9624:EE_
X-MS-Office365-Filtering-Correlation-Id: fad26744-d99b-4e1e-75b7-08dc83e00a51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|52116005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6vWvH30gjLOGLkU0xpAYQ0hlCzUKJnr+TTPdRInORaPtm4oN8ws8l8mOrp0E?=
 =?us-ascii?Q?uJl8OyrTdRHyd2o5y1tJT1PiXiEq5KfJzgimws4AHqGTwKSzPy5oi/+E73Ra?=
 =?us-ascii?Q?gO6dsXlJiW4SpOFKI6mG4BmAWjxkYPrVbFQkeJdPudNgq5sfTueD4WIZWTq5?=
 =?us-ascii?Q?4qclz35eFmrwqbRyHn8SwRBqGEugXJK7GO01hbYYW6pjHkkKvtHjnQgf8+Mh?=
 =?us-ascii?Q?wK2ogJ4PnCd5aJgmMgRnMMVcib/t0oM05oLRN4Hjob307TSEalvWFXoGmf5A?=
 =?us-ascii?Q?zcbBzkd/MBRMHBi4uhh2quTsKkWFDsdqbjrVFq9gIDo9ZRXih403S7V+xvtI?=
 =?us-ascii?Q?1wWj9z26C2bpSl3Z/NcSjybttd/MGi8JCD9/vbfREfVzdP3Y2Wn3etTpFnso?=
 =?us-ascii?Q?EkVSQJOWqUZtiHDc1Mh1XUtR/cQKdX/oC5ukHae+B2EsFc+QF/bZ1AIB5P1/?=
 =?us-ascii?Q?+UX5CpU0B+GoZJ2citMarbAJOBhTyNUTSsgfatmlDYrVPWyrPZBNHVkH+evQ?=
 =?us-ascii?Q?x2r8Ro+HVaBTw+fHDz7vE37VeLGcVXuxllCyAU7bhzj0umC4kJrNSf4C1nH8?=
 =?us-ascii?Q?adXg9EVHoyv+Tzy1+Ifzv/Ty2oPMTreb1JlY9m4hQn0l0SlJxX2zXStconB+?=
 =?us-ascii?Q?DDcjk23zE1HotgGu0oAQfg9AfWVmBtemWlETg8Mc1QQ17ZJdOO2FZmkkeFqZ?=
 =?us-ascii?Q?euVZ+2M/FyiO5OK8KOTnCZhNtlYz+yoQzg8S8rOaHnSoEndrCf0tZj/j0W90?=
 =?us-ascii?Q?21grQTI/Gl/HXItEMmSB7zxKkgedM7bwCl6HIdZpyRE3LlM2Lr2/vu3xQ5ON?=
 =?us-ascii?Q?XyCFF+yTdt0/wm+3RptVj1GqMYQiNR8gvMIB5WhVVpjh57L/lCMW3W2eq2cy?=
 =?us-ascii?Q?Vt+4LNhVEMAUtZVSEbMkAY9kIHPAkCZJadFgTx4MBdKdO5flCdwAjbTPFW8N?=
 =?us-ascii?Q?LMG7GX7I0xKkNKhMQZeAxJ4j2XD6r9HJfgoiDg+2daX3Ahx+oOaeT8OJCYr7?=
 =?us-ascii?Q?J9PgFY/5esl3fhy92On1GRikTFauCVM/Z3cL6CkXVBY14TEGc18aS5Rdj4AY?=
 =?us-ascii?Q?+Bfef7BSA7AeYNnh3HtItGM7t6sz8ALrJPRXvn+iWZZKMsmE7Jb/6JFjLSKA?=
 =?us-ascii?Q?4zu0aY/FOFDakTs91wwhrJM7VN3+znZ9CBTZp7V+seZ45qpYB2bI6wLDlcpx?=
 =?us-ascii?Q?jiczPLSRYXJHsMy9MPwVNrdGF1xcDDlGFhAVcQKmDiPacDx6+R+OUCq+Oa/X?=
 =?us-ascii?Q?mGlxNaT4KC+pg9GgXzHX+zZluwtYAofcpmw/YDOrRCHS86mwSrS3GenrNfIe?=
 =?us-ascii?Q?E+9ERtkV7/LeZTsb6zFlno01ss6sdKmMSWLBveYdZM9oMA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DnXr7E0NtMW9dqXFiz1xhzn6xaHZmqkTQSIMBQTAWPV819j06OSS/clU1U0A?=
 =?us-ascii?Q?ZRpP5rQSsIHIaby468OeApNtHz9T1DZXDpMVSYzBnEuf0dn9sUkYSLk3MZnr?=
 =?us-ascii?Q?ENSfBtbzsvNQHwuwiipHAI0J7srAEc6GCH4q5rMtQ0wu8dcpg8ewt8Qx1PtP?=
 =?us-ascii?Q?Zc688jKq2tkDq83uOPmK0f4MQ2rNkYg1I8VHRCD8FT2sNNwHenGB8dKVe/b0?=
 =?us-ascii?Q?G3ECMn6AulQEz6yksU71NWHwRgPz82ksJI9jzysnJft6N90gUzgGZnNCpIS8?=
 =?us-ascii?Q?1RV6KdCVVJRgKC4Bg6qerpCrPf5bF/liDeBwhQA5+gJi2NqCx5XDpVgcrK3W?=
 =?us-ascii?Q?ZDykeokb4u1Clyd8RGpTNgTw9X9StZX06KsoYUsvovLTQgiPQAZzSvQ8EZaf?=
 =?us-ascii?Q?NK5sBLmMtP2XnE66BNn0bT5ACPNywuaoC7soVeOSYFut1UU/NAC1h3BsGFVP?=
 =?us-ascii?Q?diVPYS7oT6oIehs6QLaFXElQyzhomWoxsofsiJDRwIkejM1aXLkEjMoRG16/?=
 =?us-ascii?Q?kPn625FHgpLyZtXIIkKyJeCpttA2UxA9ygZXei9N0bg5hNwcVeK5WyvLnArR?=
 =?us-ascii?Q?t/87fI0W615WCCVPfNxU5aTWjoF1ckLbPbz7We3+maROPLOpRwt2yqFw7VJG?=
 =?us-ascii?Q?f6LpZ0FSfHlAVXinoj2SFus1LYSOs5qozJPCeRut3WqjruW8nznC0ScPHow1?=
 =?us-ascii?Q?eeOcevjZxcNRN7hkaAvw6fyUpYjDA4WElv/mGSXSF8qNyHRp55D876DrjX/C?=
 =?us-ascii?Q?spYthskht/QRkqv+FhgfITA8LywK+U+w5jQSwdy3Cg+Ga8bbMdPC50GHiA2u?=
 =?us-ascii?Q?4Xvj9oVGbEw1lycdSk9bEkKL/cClMeMNCPcR0g4IyCGX62om8OAU5LT1pE8B?=
 =?us-ascii?Q?+fX/YpEFK8O0fljPyzEahS+9/PYfpioygEqWEK7V+ff2C2s4F5zsxN9FaKwa?=
 =?us-ascii?Q?muUCiZuezFO98Ebf7V859NAZm9TSALFNilxEikIqhU1uwlJegRdonrZuStNn?=
 =?us-ascii?Q?GkndDfgYFg9hsqOksztUDQlHkGGmYyDUgQ8R69ZdvU7sNoB3Dwipng+E4lYa?=
 =?us-ascii?Q?DusZENLsIjcaWZ+/L87i9R/rt8u3AWZXnlED8rd4NNeYwT0f4GBeJktHYAix?=
 =?us-ascii?Q?bWfZvGL7a41Ef5UhiH6dat+Ms+7V+B1yIdxkzjWaY1ZykSf1jTDtFanu1MoA?=
 =?us-ascii?Q?ONqvrRCiSot86DX0w2EhvPzq/iZQTo8x5FgIVpw/DVMI+8EBCZ65uXmXpHZz?=
 =?us-ascii?Q?9uvIOdKcTuOfuOkvjS0z1q5ZVXS/GgTIYWrBS3/QKAUFxPXS1gfX/7OBesXN?=
 =?us-ascii?Q?wK2nMYkg1WpBvkLMgxEmZmfeQuOR2BiA08HKol3cT/H5wAmPh1sDh+auk0Gw?=
 =?us-ascii?Q?kzjblwlXMnW9VPZOKLokscqwweMwDxNabXppUrbmZifF4Z765NqT6D26LRMZ?=
 =?us-ascii?Q?gOz3zCcgazO3hpJiiaXGYiJ1eoNtnXMZ2dlyAX7TTWOYst7S1ANg7qMD/dpg?=
 =?us-ascii?Q?dF4fprRNzbDRD224RLC55rhdD6J4TnbzJXzu9zvdFSfic++nvo23AcKCzAbP?=
 =?us-ascii?Q?ikU+q3YLC8mDysBgB48=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad26744-d99b-4e1e-75b7-08dc83e00a51
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 15:15:45.0170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/ogYWg9ne/tRpmMR8dYCPdNiVeFWkFDwmmD7xySx62V8QaVc5qHS/XIEAUKztbxvWGlCQDg8NzDnU4F8Pd/Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9624

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
...
For either value of RnW: Due to the NACK, the Controller shall defer the
Private Write or Private Read, and should typically transmit the Target
						    ^^^^^^^^^^^^^^^^^^^
Address again after a Repeated START (i.e., the next one or any one prior
^^^^^^^^^^^^^
to a STOP in the Frame). Since the Address Header following a Repeated
START is not arbitrated, the Controller will always win (see Section
5.1.2.2.4).

Resend target address again if address is not 7E and controller get NACK.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    Add Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

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


