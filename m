Return-Path: <linux-kernel+bounces-199347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF8B8D85D9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18A24B21FCB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C97512FF71;
	Mon,  3 Jun 2024 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jOLVUtrS"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2086.outbound.protection.outlook.com [40.107.22.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE99BA31
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 15:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717427747; cv=fail; b=NXG8e+oXETF/IKwPE86rJZpLtPZhgS0dkE2O0vZNDa3TpXolUO74/QP72hZRq6V9LHzC8LTkohUvJUpGz0y7AY7YCQ5O1chJcIOYy692Z0dZGOyZBuPVeoZRQfrLP+Qb7ngqyM0rr2PamFf+NJToLy+1kf4yDsCV2hYc0PPVZK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717427747; c=relaxed/simple;
	bh=BzloYGMEZS0YA2RrAvhyLoyWw4lmzfEBQiYFJaDajN8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tIFtWhfIn7L6zgMZmyRmErZ+1fHCX6jH6w4HjWxTqkPQfAfFZCAEhbmoyC41Na8QvwSEZd/zIS+umH330M0zJQ8Pv2abO78kF/MqbhVA2SNEWstxvwNmUwzfPJk4GNLYIDRCyRALa6bu87PG7L6ZLXY9NmOe9Ymz+bxaDAqDwaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jOLVUtrS; arc=fail smtp.client-ip=40.107.22.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwlEvS9542zbUtnpprnYTLnkcMUwPBVmIy+wug58QFPMFpB8W7MicWB70q5Al5Dvr8Ezian4ooDo5IwWcvfJIULFKYcb+3v240umVE60kL+UappFfAMesEdZ2ZaFr4Fsz+kZ4yDgHvUimdQypPfjzSxsXyiyl6/FGxi+ucN9M1ySosC21xWfqUmAGBCnzKBfw7C/lqhgGslMXZKN/zwj8aHh5tYpvlBY2DUlxAT4VAQ1aaHhlSRCu1QkMAvgZjroUpP1t1h0zXLD8CS1eSMrVcaYIsK4suVGoOnNKrbFs8Y7IW3+JTqZiuLJPSB8P+UWSpo5erBeBgCR0Jh760bYSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wBUPdXHQ6sB8PkOXiw8IMEV06+hIgB2FCJ3VygLSW0=;
 b=lrYT1MgggAtFnPIKXbSSMLenll0ntWblOKfOoVeQwdAnyaRga4+adgt8XQEtD9S6EAO2t9Gh+zmu9RDbjb/7IFk+1ist6H7ksGRu/A+yzp8SAUypiSYxkkbqzd1+v/RwYPx+K32l7KbuAMiUyQk1zS8O1f+D9PWbSYQeBu7Okln1Z3xcrhkRrn8ThodsqPwMGQ2LYSK/h1tp+H0/fPmeoYymiUBuXEpa/9tpNs/DArydq+WVEmr2Ey84WKDOw5jjmCfsH1ghIrYDEVKs5BCjA4tz4mdiTV+oSQVLUwKUgiCyJheriY9TRJBUmsBgLlb+CxjxsCRKaH02CA4tgzBbqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wBUPdXHQ6sB8PkOXiw8IMEV06+hIgB2FCJ3VygLSW0=;
 b=jOLVUtrSneaPXLcYEXyDGCF33zlLnx5ovJgZ8t4eAjR+iJ/aQKSfoF/NyXrv47oZBg6wnxjM0NEAs+uGl/bXyJSezLJ+kOatuV6y/ksl+pP/DV95FTtaDqhxoRRIc6oVCHB2i36B24e4k1JMW3LqCbl5E/dzfGvIK12+j9YzyfI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS4PR04MB9624.eurprd04.prod.outlook.com (2603:10a6:20b:4ce::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Mon, 3 Jun
 2024 15:15:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 15:15:42 +0000
From: Frank Li <Frank.Li@nxp.com>
To: miquel.raynal@bootlin.com
Cc: Frank.Li@nxp.com,
	alexandre.belloni@bootlin.com,
	conor.culhane@silvaco.com,
	imx@lists.linux.dev,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] i3c: master: svc: fix IBIWON not set if IBI follow a hot join
Date: Mon,  3 Jun 2024 11:15:26 -0400
Message-Id: <20240603151527.52235-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: 65beb6db-6433-4c17-2530-08dc83e008ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|52116005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fGJ3SpU6Fw5n7EL3r0IfJB97kPa/6/X/IQIlQZIKXVeTVh4fdbbtbNtBdxVa?=
 =?us-ascii?Q?z3icv6W/hXNWWl7KDU8wp/CnjrWNvyTuT11QobrN4QJDa7Tj62HtWJmxmdqZ?=
 =?us-ascii?Q?UXYYr0Lp2QjjQlkF48ovHR2rbNJpspmqqHPjuTYdWmdmPBC2FTaF7qLEuw2h?=
 =?us-ascii?Q?6zJS5IgpKRF0aAvh2c5KMBcp2lz8kb5gFP1lyZMtVPRpnKb074kwY4tL8421?=
 =?us-ascii?Q?Cd7NI1Q2QWkdzDnrPIRztR+SK1aczXla1DrSbhi5fd3+16eAYuWwD5idA9zD?=
 =?us-ascii?Q?rvs7zrCEFktajwNNWpMq0mRxReDCP4NxrrlXu25L/JS+v8On9i+4lHovMLe1?=
 =?us-ascii?Q?judq5tgOU6y7lm2JoZcubZIv1JVOfgPQ7DiL/jvbkSOXb7ma1Qkl6Qkic94N?=
 =?us-ascii?Q?yRGYcRdmDgg0/OkBKe0YQVD4cI7N8L8mql7SoCvSZMAcrh29lSprfQGbMEzt?=
 =?us-ascii?Q?vNVWIvAZ87RzqKoWHbZynBKHDoSkMY1SsxttnbKvWJZ4yAlV1P9XfN6FPxHD?=
 =?us-ascii?Q?Niy+PB7qM6NvTKqGMmv0BQFHUaSVsgA3oJBNOXc3hgxVqEbXioSPtfPkU4me?=
 =?us-ascii?Q?s8Zh3gjLweXnWlLHtC10jfr8TRl22uKeRy3/zn8uzEGL2urpKuHGv+OWBcdV?=
 =?us-ascii?Q?t10AQqQtiUVvDpTpGRwQ8LibXHoO7KEG3YAo0W41Xk7jxMxMwVf/OLmXJlcm?=
 =?us-ascii?Q?68XyGNs5NP1EvdlZ6IHKKleZqAWUx7xlZBNKwbcs+U3+s7AqCy8qJfiaUDPI?=
 =?us-ascii?Q?wNyhDjA9BnoUTEFjPox/XBd9941k2AiAS//C/7UOpuQsmcL7be6J/SoOlwIl?=
 =?us-ascii?Q?hDadF34Q17nL9Qv321iTD1Syyq/qjRmrnpdNSFBvTUnxj4MT5Ngi/D2pXDDV?=
 =?us-ascii?Q?ibO68u5xlE+gpsiwNKWPzV3DAlYCqW+55pwOmZ1Ka+RVbfbpz18XNnRsviRH?=
 =?us-ascii?Q?m3g7t4L9w5jhYL5F7+MJrRPTGSkai7MlTxCnEFhDvkQpFhAXerajHfZJkBrT?=
 =?us-ascii?Q?dWlf/RfYKpY/y9Z82vVgQYUPXYP4/GKCObkqLzYVjGr+vYQv+glEAWIj1wlS?=
 =?us-ascii?Q?eH/JrJEKqeOhaRB0e0E5av1sYlt4vw86J3RuH7AEBHmtPwDtyA35kBmGBH1n?=
 =?us-ascii?Q?b6FNc/1ZpJXPpzZ7I+q+Bn9gxK7EPCwIQ6NLdnU6MArE4LiDjMVAG9Dg6sY6?=
 =?us-ascii?Q?EhQKSZvh+hnohTAeA/Iy6DNHkeHrDURbD80awxQwUQrfQUTyI3iBJkdLcR2J?=
 =?us-ascii?Q?up0GPO0YsLsEhrRt2EDxCSl1G+6rBoFD7EdhEiwYZqKHEJT/OcgJS4omQbGU?=
 =?us-ascii?Q?uecOA7Bra/doJ4G0dAtO9GqYhoq0cqRRRLWrFW1YEXTZZA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6ht1KAdOVCbZX4ijb2blV0VlxQ4WbketRA1Sn3xAH7jGGKiIHGqfH0binOof?=
 =?us-ascii?Q?dbI/tg3IX6m9Yrnmi/H6POWvP8FSlXRnyIF9/uPAuymq/wejjNts/cqg672r?=
 =?us-ascii?Q?TH55F20XQW06Wu/9NAz7deaYTWhbQCFi3hsN+t1M6k9Pdf4e2S/4inlXbjw+?=
 =?us-ascii?Q?O5CCGkaooxUZjVTqdo0wOtQl8jH5VscxQqCW3eZvkvkTpQHkzunNFMhKHGpA?=
 =?us-ascii?Q?i1eNczdYNJl/+DlvuSwFcNB6cUzmW+TOWQweTzGupcph2TVV7QfEQCO6lRPs?=
 =?us-ascii?Q?HvqBcwmKoZHpjufBQ3xFffWWpjxDXTFZ37neonYK1bdVXQJlGMDypqgF5CJe?=
 =?us-ascii?Q?cQ1gypYgnTOyz/aytogFJ47hfAH8IjHzsfgIKX1rylc7xpfM/IjBnDWtkHWH?=
 =?us-ascii?Q?uvjaMdDrVLegtc9XJymmh4saGUZuvyUDwtBpNGshe/OD7JtYUX3AXklEAVcr?=
 =?us-ascii?Q?+2mAYVrbC1JIrPVL/gvJa7mYJxpp0Cf9mMYmfJZRPaesEgJ/8+CfDdNPf/br?=
 =?us-ascii?Q?QVR0rqLIv8hR0kAuJGNeOxnzc/2Yh4WNJ8QoMOLZgou09Eu0Ood9cz8StaBD?=
 =?us-ascii?Q?1I1Ws+h1Li0phz2YJER7UV5ehqKi9a+1jZmTbuESbQyyawU+o3QI8TSfiJGy?=
 =?us-ascii?Q?UTb2OZd/o+r/nbFN9d0r2bBe4Rsa25isrcWtUdheG+F2TWRy4szvtdIUzgzC?=
 =?us-ascii?Q?USBQjEZz5eFLQZKh9OC2AQWLbv7ynY5FKaGCaOd83RCP2TLHlymUox6WMHfz?=
 =?us-ascii?Q?Zmst696EWTCa4dM7Qljt9tEu+nQ6XuGVyVm2kYD5GY0fLuB4OMH6mL6xi/IV?=
 =?us-ascii?Q?5UUVeEd+zLVaZkDjfwCSTn4ivY2O/zi/QIkkvxq44l8K+5vSOC/CD4VSx9yi?=
 =?us-ascii?Q?fCAnH9aYqRsXWisIelmrAs6tNBOnAsJgzoQEVXwl6ULIdkHnBEcRFlLzFISF?=
 =?us-ascii?Q?M3ur3AObGTrCyyfEA24U8QljNQODioCeHimVqWEH8UHNaokFIRZtFd+99rYy?=
 =?us-ascii?Q?KWZRx4aMdYPdV1zXIn54Sob64lqFjrBdl1D4VWx1vncJoJOIQJuodhlhtwdD?=
 =?us-ascii?Q?qtDzeSIHPV5HM0Ci0kk8MiMoPpPEk0DgGLZQyfg4D4SI8w6kiwvLvBbaDAil?=
 =?us-ascii?Q?/s+mirx0XRoDck0ZFk8R/lO7yweph6cIQRnojw//rOUhDUfIp5rL7sUa5l1+?=
 =?us-ascii?Q?RaQgD9dB0GSGfRZqBsTJOnvZHszFjLCycNfSCHWZfHfnq4x7VDY6fzKHVC3u?=
 =?us-ascii?Q?vy15AlZ5y9AL7WZLOU6EOSVOoV7e8+W/IFwDi8y/vJI3O0nofeWwNTw+bPlb?=
 =?us-ascii?Q?inbbHdfPhLc/BdGzvVlAbvFgC9f7VJN1N93xh2dv0m89oNsqUxk78zmn+agW?=
 =?us-ascii?Q?w1tGE3PAQ3Yi3f/S+BokCE06+5KkQN7NAaGUyFSEOwnKiHLHA0Z5rv8caqUE?=
 =?us-ascii?Q?InRJChfOiJCvdU+D+Foj3KR0RZH7RIxI7xBlLF90evQvQhmyoZ+AtoO+TEfK?=
 =?us-ascii?Q?CTrkiS0rIcW/GpLrIOTwdlWCEXwN6maQJ4x36cfUyaFbYVvb6/SBFmQgXu97?=
 =?us-ascii?Q?sT++ZLqHh2aZGi523UQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65beb6db-6433-4c17-2530-08dc83e008ea
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 15:15:42.6650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CdgMr5uCYXCTalp4WG/AjxX9fIG8AnUT/IlEcD55AbHMxxivNm/G+8KksOj5ztbO8CALRvc5iKdT5RM6mszhoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9624

When an In-Band Interrupt(IBI) occurs after svc_i3c_master_do_daa_locked(),
typically triggered during a Hot Join (HJ) event, the IBIWON flag fails to
be set when issuing an auto IBI command.

The issue stems from the omission of emitting STOP upon successful
execution of svc_i3c_master_do_daa_locked(). Consequently, the controller
interprets it as a repeat start when emitting the auto IBI command. Per the
I3C specification, an IBI should never occur during a repeat start, thus
preventing the IBIWON flag from being set.

Emit STOP regardless of the success or failure of
svc_i3c_master_do_daa_locked() to match I3C spec requirement.

Cc: <stable@vger.kernel.org>
Fixes: 05b26c31a485 ("i3c: master: svc: add hot join support")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    - update fixes tag

 drivers/i3c/master/svc-i3c-master.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index bb299ce02cccb..032fe032ec433 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -961,11 +961,11 @@ static int svc_i3c_master_do_daa(struct i3c_master_controller *m)
 	spin_lock_irqsave(&master->xferqueue.lock, flags);
 	ret = svc_i3c_master_do_daa_locked(master, addrs, &dev_nb);
 	spin_unlock_irqrestore(&master->xferqueue.lock, flags);
-	if (ret) {
-		svc_i3c_master_emit_stop(master);
-		svc_i3c_master_clear_merrwarn(master);
+
+	svc_i3c_master_emit_stop(master);
+	svc_i3c_master_clear_merrwarn(master);
+	if (ret)
 		goto rpm_out;
-	}
 
 	/* Register all devices who participated to the core */
 	for (i = 0; i < dev_nb; i++) {
-- 
2.34.1


