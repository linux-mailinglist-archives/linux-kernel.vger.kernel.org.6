Return-Path: <linux-kernel+bounces-298611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D26895C962
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DED32822EC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9747A14C599;
	Fri, 23 Aug 2024 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="kBVLMXNl"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2040.outbound.protection.outlook.com [40.107.215.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF21433BE
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724405983; cv=fail; b=etBiqQ8Wq+dZ5xxhoc08CJFxGmTvo4ibkpfnaKqbedE9Lq/TR5ugjlSymq4wK5pjkYkRoQ4m5TbjR7ne5WLggihbPDEgmzYyMhItoI0KT05w75F8A+W6VZC1rL56KOW3QNg42Go87rhz6+OpB2XtD+rTPmqKhIE7SZ4w5aBVV3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724405983; c=relaxed/simple;
	bh=2dC9znqT6I9pc3NOcGO7KaP2vTKzN1n2J2xfpkD6Ljs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=u4PalWK+PsR0ytfVE85K37eBNUdIiIp7cF8TFF+itUOx8Srd/fP2XqkAUe7rGFoDPN0tGSW08iv8az9vzy7PQw3WeUpiy/vWRILCRw18phKi/8JKq7vNxbkn2PvoHjAnvvgtzPD1hFsiKSVvm3S2a/pyXNDe4vTw/DZCYRLAfdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=kBVLMXNl; arc=fail smtp.client-ip=40.107.215.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZOjtPiMufkP/1vNKYT8UIFhPkjHUOZbiAUF3Y1Ywzdv8DuP07QJIyCYJDIpWkKvtJLsZMpOsW4m1rWSeZ0lbCNcQRQr8XTd52izvC4AOeNtMWdZGajoakvfuTx3FDUdj5V/yp+XuDlqUaptmo4AmDEcpXeb9L1QvAir8e2tW93gjbOmKFq1bFXiouddO05lsm92xg6yT6S+zsjhiIrEBJxmkPOaDjv//GSvud1sUt782+hO+AYkzwcptrMwxP0VDqBQEd1UJe7PF/yhvZHgRnIrEPSQQjVA+b14FrSg2XNydcQy1ldHB3g88CYX/5TC01VRIfyFUq2XikiKgfuGgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwL98ugu5Ie/LZn6olQZuUJVBBalWRKRMZWGDyzjZPU=;
 b=n2hctopDxtYLH6AvZX7eX0byCe3WCOg/swFQXDjKPJFYXBn8yyC4XArwy5HXcxmbY01tipwdFrMjZ8IQeAz+smxklgIv8hcGjSKiVIhEMUJ5yZYrXGWhYPm1lVjKtHpA+cBOX9ssDcbLGRF9B8HhuqydFis6Vtlo+KxYyO/gufJedDDXgLLR3VApn0RZR6UAPe5acpH7tzMLEciudivMgvS+fgShUYdU67CuuZ72vrugsx8dLe5PwBZAA9PzHeDW6566uqf8o8/hykVy7O0OD9UpjuFlgcvGm9N7L3HdyjpJQ5i9IHEfTSDLBB2QfaXgLkFtABWJgTHrLBvJIRGvBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwL98ugu5Ie/LZn6olQZuUJVBBalWRKRMZWGDyzjZPU=;
 b=kBVLMXNlYHBYc+vBRFCJFqKdvU7g3Xov+kr6xfX4vIIefn8lb1ZcL3178OWFCg95fJE8+bZITI1+YZgCAw0h/kp3KWuEy3ikdyZr6YaQu/ADyuy0OAUDf6Nx1vEAUevT48K+Bn98ZUwKAqhUZLYykxF9f7QVOGlIQn1e2ICzn4yQ8o75F3Sm7EdNaFy+rAqyA/Nh2lYk4P4/kkxb1HqsON5FowYh4K7ZZjbWvRpPhNWKfVH/XrZq96eCw4rRSYe8LZcviamOaw0XO7rJHglkF0en428ckNLiZ7oGYkIUa32hQEFheu6Pmu+ZWQx+vzT3khf0PLIzQFLVTSlV/jZdqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB5487.apcprd06.prod.outlook.com
 (2603:1096:820:bf::14) by TYZPR06MB6637.apcprd06.prod.outlook.com
 (2603:1096:400:451::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 09:39:38 +0000
Received: from KL1PR0601MB5487.apcprd06.prod.outlook.com
 ([fe80::2129:59e5:6c67:311f]) by KL1PR0601MB5487.apcprd06.prod.outlook.com
 ([fe80::2129:59e5:6c67:311f%7]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 09:39:38 +0000
From: Chen Yufan <chenyufan@vivo.com>
To: Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Donald Robson <donald.robson@imgtec.com>,
	Sarah Walker <sarah.walker@imgtec.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Chen Yufan <chenyufan@vivo.com>
Subject: [PATCH v3] drm/imagination: Convert to use time_before macro
Date: Fri, 23 Aug 2024 17:39:24 +0800
Message-Id: <20240823093925.9599-1-chenyufan@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0030.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::20) To KL1PR0601MB5487.apcprd06.prod.outlook.com
 (2603:1096:820:bf::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5487:EE_|TYZPR06MB6637:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a7658e4-378e-4923-8d0d-08dcc3578171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4g0ceeOC3i4quCIeFIGzD2MeDqsV1UceqszxOs6i7EcQ28bZ0tKItlqtSF/3?=
 =?us-ascii?Q?h2Ee+ZT8Z/wEGsTo3AiSbcbqChkxfXtFzS5N3C1MBYMafgmpRhZBvoTh/RXb?=
 =?us-ascii?Q?Gt5cvMPnVYyTx7LwHcTkA3d6UNalBN2NgHzYNGagPuNhHSjKk8n/a9Bnc9Iz?=
 =?us-ascii?Q?UDp3JQZRxGTgNTAcCIxUM1Kjq2RPhX+gHuhppvuStYjl8s7cAMvt8rcgEywk?=
 =?us-ascii?Q?Dp8BV+FDO0oLmXPK/B5v48RYcBG51+eMNO5tp5nkNRNKU07OBJbYhzWr16LR?=
 =?us-ascii?Q?1PfT8JcEbVH149FoHY8DACjSMbd1LNEOYEgxpJTHVKd4wAsUZps/Z1d8U45I?=
 =?us-ascii?Q?wdJIGdrtNw1E7NSC5frh5KY337PTRjBZUyY21RSzbeRbNRvTii06S4wRpJaD?=
 =?us-ascii?Q?lXB3Y+KvsElMfa8RcwWO59Xif1O0VERhkuSh2nsZ9eWFd4GOyThADGnCYJML?=
 =?us-ascii?Q?sLXLWa03HYAW29oWMT7SX1BbQ6HHFya/LvTWl4oRpf5cTr0Ndtknu2CEMX+o?=
 =?us-ascii?Q?QzyR4iXXRJNH3TOqKdEpvEyRH7YKo+ZsmRp/ZQ+Ndb0Y242igxv1eq6aaMbV?=
 =?us-ascii?Q?vf4Dp6SNZwSPn8AQPoHI7SL0psEMgQhWhh4cTN++dDmRWooIU5SDeoJcr+fY?=
 =?us-ascii?Q?5iO5tc2eSspYjifc0k5UGdP24/b8wTkmhjUfpjUwd0yRsI5gU9ZciMnTLFL+?=
 =?us-ascii?Q?tA8ZifYm2XXSLqNMs6WxpyfagaGxbalOPL41KUkWluyfTTKqKPw8FfWIaXli?=
 =?us-ascii?Q?NSn9XT4F+NIKP+e4/ul+bjmScTIVgI3B/BTa1fIzNLIRRvPTTwiG6f53ZQDo?=
 =?us-ascii?Q?gkGghjgW6T0sqKAldAogLMSNOC1notxQ0qTYSLYS6rq5z6c2M3TCiu/AEe11?=
 =?us-ascii?Q?oIAZLZ5WeVFLzQfLtvgIlgxnwVsWhf61JuVLhCgV4sSS3miTsahPHu6C+BF1?=
 =?us-ascii?Q?8NkxGa7ntwRdQIwfvYZTA+bniUSrLwX57Zgm/5QIj5Va/E11RB8tuqL62xE3?=
 =?us-ascii?Q?A8tWUaBs5hdrzn3rUtyqNIOjQ4sC8tx9Xzedkz+o24AKBX0LEOcagaXtdIQD?=
 =?us-ascii?Q?Ny4XHCMx6LAtk7435WKHhexrF5zcxdiqD3MdM0fSV8lgRhg1gv/LKWRlhGTa?=
 =?us-ascii?Q?3+qaWc0xRW6jcYrzV07AK9OaUlr7PVPwnH8hKtzc9rTDkDpU1514OSLwCnMm?=
 =?us-ascii?Q?ZBhQXU7dFULHfU0nZ3cjUt8QIU/MBZEB6CEFWW4D26Fz+I6k/oa+5j2F3GUr?=
 =?us-ascii?Q?toOu9SoAdvMgdCcuQBV09maQGO/Lj5NgOQyoOD73M+J+mzTYc8pDj3dD8dpD?=
 =?us-ascii?Q?eBF4bIyxzd26z80r6Ghy+WXq0sGSFDD8YLjri7yv8Gpn3CnEU0VnSATQMD5v?=
 =?us-ascii?Q?hrn/uHsb/7Sy1uS4kDqnyjP3xSFCP2hM4QiPrevUepj2gb2GYR8IF0kcI+8y?=
 =?us-ascii?Q?MYK8qob44l4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5487.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rpV8FaBNJDgqdOeawGpPk0wgNILv+yvQMUnY65QtBKfrBs8cFTdxITiYfEcz?=
 =?us-ascii?Q?aOlMK5xJeYS9lGnuuYFvTcyKBuumsMw/pRX2DTkyAmy03u3/I2ax3lwGqvP4?=
 =?us-ascii?Q?QlBefkq2xZQJ6pq7Zz7rWGkk6zyjRRgHRzbIyXJRlYuxI84YbRHZFTdXgfPG?=
 =?us-ascii?Q?vEeVmMuC6fyIFma2ouaifTSD4k09CQVl87XLHBt85VYSvIM0hpImFrp3uX6c?=
 =?us-ascii?Q?k8oYdxxLvTJaYCZqk8XmUsubsbkFK2GPeWUPA++1bputAFna1A1x9T2nosDu?=
 =?us-ascii?Q?3jlayJvQp2Ld+3ipbZ8NhWgXucUqfRovf9LFedT4wfB3TfM/vwNjU6PDfWPI?=
 =?us-ascii?Q?IU1t88Y8sUg4o/iRqf3lTQP6iLcSObtFt+q9v9EdfmSdkeBUKxha9VBoSN/o?=
 =?us-ascii?Q?aiug1xVdmyhbKQLV87E2ootppVOmn0jEa2mzFYiS602MShs8PnUzlPIDSwBM?=
 =?us-ascii?Q?8vKb5VMp8pUPjHkTKjghKZynp1cuNvYYlqTN70KUgrbOqx5KscVJtmhi/H33?=
 =?us-ascii?Q?KKJfyPZ9OdwnmjaNJO3F55q5t+dEA0WiastlZqRwBjhnp8FkVT0jFyz4vF9+?=
 =?us-ascii?Q?SivVllW5cOyH8Oy6YDFawlycN/k3dPaXkpjuzM/YXi/FulJbqoRcT6u3C06Q?=
 =?us-ascii?Q?9OA5uDww3AZjttVXznXQgjbsdaeEGJQICY+jZY88VdND1CtXNwccvASg4Igo?=
 =?us-ascii?Q?OsaIGmfoK7Lor4jQADoXyRQiW2+ORDiMp6CvKU4XgglUWdafMjsLlRSTLEC4?=
 =?us-ascii?Q?Ne67ubKxLjU+Rb70+ylOC27TCItu+tHtxVqDh6ZsB0dRymrVJpJWJoFWXldW?=
 =?us-ascii?Q?S/koxn+8aLNufNPYCUuZqpzy+64NxPonSZ3ulhYwmYxTTZwCoyS9HuZaFUAR?=
 =?us-ascii?Q?GFXOp+xMUFJRJqBeMnNze8xZEA3ELhqilAoafdjliX5AtnY+vx0cVUIA4ayT?=
 =?us-ascii?Q?lIlFjLJVzUC/ZJYtiUeTWxf7h7OqRa3TAhcBlnx9EeZrEMJ7kHfn+hHMQZBi?=
 =?us-ascii?Q?Kh4wgzuMidIZ/bG1ptdIlaRT7j02bGFFmPLZ/Ism8aoXB8E2SQO2q/a/0T0p?=
 =?us-ascii?Q?XaCsosjpSZfHzft0ViSXMuKcH8kMnOQ7WBXMlEfQ2N/chOS9PcxbToKisHm7?=
 =?us-ascii?Q?HImiCnIRAoHA9td9g9XlHnvC3p0Y7PihBWtIVMlB9QdedVCJUvpSBgycg5W7?=
 =?us-ascii?Q?nf6t2yYLOttUeUDC2IGZTOPqBsa15smGfwc1G55CXcU8qTrwLPDvMvHBPFhA?=
 =?us-ascii?Q?fhZ0q2e2s4Pd+lgVE7hF0mUhhlnG2yHkVFDupubn4ktdlNHoyHatIq0kM0l9?=
 =?us-ascii?Q?afW08+t6jC6H4mb1+vpVWtvxHMthkl3SAQxLaJdJ3GfgtkmiTRebpsfXB+/h?=
 =?us-ascii?Q?08+ZJDw2Ys8o26oiII9JrLCBLRT+PPuoktMHetv/wYq0NfLGtaHnjqPSMBbK?=
 =?us-ascii?Q?GjPu4KiiGUbeuj2UlExUgSNnsq0kdpP+sqnS/btUCItEcQQr68x1YirBQtvC?=
 =?us-ascii?Q?ZB0PdVwb4nQDd5T9Rru0PDopTekQGelba9SRa6iFsSrDNxvhGdrD8RM403C+?=
 =?us-ascii?Q?eGCekddbl6f2FDPYwByQ0HcNwEPTo3sgwrtiOyVl?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7658e4-378e-4923-8d0d-08dcc3578171
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5487.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 09:39:38.2831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V8+Nvpmb7iTAcK0aKLjTy/CwtRtpNdBY8f2dM0T2fC9005lZHO2Dn+Xdu5pPmV+4NIcCx5/eElPrmOUAJrT1GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6637

Use time_*() macros instead of using
jiffies directly to handle overflow issues.

Fixes: cc1aeedb98ad ("drm/imagination: Implement firmware infrastructure and META FW support")
Signed-off-by: Chen Yufan <chenyufan@vivo.com>
---
The modifications made compared to the previous version are as follows:
1. Change the prefix of subject.
2. Correct fixes.
3. Drop the cast of RESERVE_SLOT_TIMEOUT.
---
 drivers/gpu/drm/imagination/pvr_ccb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_ccb.c b/drivers/gpu/drm/imagination/pvr_ccb.c
index 4deeac7ed40a..b7d5f9ca3ca6 100644
--- a/drivers/gpu/drm/imagination/pvr_ccb.c
+++ b/drivers/gpu/drm/imagination/pvr_ccb.c
@@ -321,7 +321,7 @@ static int pvr_kccb_reserve_slot_sync(struct pvr_device *pvr_dev)
 	bool reserved = false;
 	u32 retries = 0;
 
-	while ((jiffies - start_timestamp) < (u32)RESERVE_SLOT_TIMEOUT ||
+	while (time_before(jiffies, start_timestamp + RESERVE_SLOT_TIMEOUT) ||
 	       retries < RESERVE_SLOT_MIN_RETRIES) {
 		reserved = pvr_kccb_try_reserve_slot(pvr_dev);
 		if (reserved)
-- 
2.39.0


