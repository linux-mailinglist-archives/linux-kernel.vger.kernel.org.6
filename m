Return-Path: <linux-kernel+bounces-260196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B8693A466
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 741782846EC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EF214EC57;
	Tue, 23 Jul 2024 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="H+0aOQxN"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2047.outbound.protection.outlook.com [40.92.20.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B6513C3EE
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 16:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721752311; cv=fail; b=s2Ug8qtWy2bczu9wVUVxWiBiKwnOU0TknsXAdgoOjbo+DBHEgXv6iJyanA+kZ9ZgNkMIBRlrGsUcOBJqvRSfcJg32+9QjRbS3DwwJDpLq+4K3+MHVfnvB7g4FJfyQRj3iy7YKN2TgH+BKHg+53qPK8kFY0SK33H9KsQG1w9XFis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721752311; c=relaxed/simple;
	bh=/akNgJMJafP2eyXxwDKKoCwnK3BbEI7hqoQU+opsClc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KdWoM9uIerwlengy0tEhEuwo5pAi+yJeOCMarT1v9DutAjitPXjAAeTOVh8uHmeyeHY84CbBzQ+Q5sVAoHNm3X5WngAy2p/LNG0s9EhJ0uJIaEvzKrr8LRkKrJonwHKy/mVuatyivvUYasd3BcOjjV51rJ10yZk2PcGYP0MOI7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=H+0aOQxN; arc=fail smtp.client-ip=40.92.20.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzpYdYw+YSKhDcHgRTK60QsFAIMQhxaICzHd4hfO11Jv1SM9blv+qK33T4aZkfai/f3v02sIB3lm4MccK8pmpY1jDtY1vY7qifDrKSf7SDlIp6q+v7Lp6g+q6Dx6KWwWT3a6+LXj0j9NbJodyMVZb784XUPOf3M2kanoVdVbm2heNZVxLhkEaLsjm3m/erSDrS8XshXFcxmNsCuA2NzXxsHWnlZDgunkDOw8o57KZs8X3M7V5aoTcMBo2hYCcyKRVzRvbmSSi67P5h/j19NGbUo2os16pVQIot0Evq6TgGImM/JstxAGgVqAMvYbL8+kIHJH2hRTl3BbKs5F4DfGkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkcsvel0U3EOWV/odVZSnAUEMXqSnzfqfJX2sywFWqg=;
 b=M+/nRW0dBiBR2iiuvfAq+1Y374p9dsjmTae+yeYWRbFSt6zAbczNrqItMisB6xkRm+A7gcvNuL/el3bdlxvwRd8Iwl+kJQ25WwhG3HbUYESUAY1mcVUO44tKuysfA+/5TEQzMrO0+u0xeXvLEp4cAotY0w4uSpVY44zlzq8nwJTeMWvmONqu1PLkgm8nF3iEbrI4LbZITNjhVVxBhXRO8eXIicwAB4xN2gDhg2xqlYH7E0OTEb7Skj2E6EWMQdQbin1nEC3NNh1omxKnaAyZP61KTLYxMUMYi8R5MnGYUpcLA5h3ACvPVh79oIQYT4Ctq2mVSxQLzvXtZPOf0kNQTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkcsvel0U3EOWV/odVZSnAUEMXqSnzfqfJX2sywFWqg=;
 b=H+0aOQxNwVAwF8JeeQvhCAm7Rp2QQKBBPGIDsmyBQNio1OfRpyapKZr6827V/wh8N7aUpCdwsFWMEkkuLZjJrK46uO/dqE1yrAmeS73tgvSUHclqi8jYAmbicivSh/B+GvL0C7hRS9hZW7Ouyl2f320+Ts8sz8zBOAWkTn+tiBFDVljIxyROPZfHMMDcAK7I8wwnTUIMhOEHNoqv9xf7ws3DIHMHpzqeSahQye0lJWy6zLYjxzUtmYsTXyx//MPilMol6/cY273yS76vrXDUjoFF5ltX2OqZ1GW5kP6xNyf4gBfVlCNO4oP0uzp9bOgjjsqUjDKH5FCJdoEdmqlw9A==
Received: from SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:a03:570::8)
 by LV3P223MB0848.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:1d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15; Tue, 23 Jul
 2024 16:31:45 +0000
Received: from SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
 ([fe80::b5cd:c37a:bd3e:e3fd]) by SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
 ([fe80::b5cd:c37a:bd3e:e3fd%2]) with mapi id 15.20.7762.030; Tue, 23 Jul 2024
 16:31:45 +0000
From: Steven Davis <goldside000@outlook.com>
To: gregkh@linuxfoundation.org,
	christian.gromm@microchip.com,
	parthiban.veerasooran@microchip.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Steven Davis <goldside000@outlook.com>
Subject: [PATCH v5] staging: most: video: Fixed minor capitalization and grammatical issues
Date: Tue, 23 Jul 2024 12:31:03 -0400
Message-ID:
 <SJ2P223MB1026E786B28986901BC1C126F7A92@SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [sZL+2zisUz3076lIw+XDlH56v2wU0PYF]
X-ClientProxiedBy: CH0PR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:610:32::34) To SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:a03:570::8)
X-Microsoft-Original-Message-ID:
 <20240723163103.1550-1-goldside000@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2P223MB1026:EE_|LV3P223MB0848:EE_
X-MS-Office365-Filtering-Correlation-Id: 429f32f1-09d4-4ff1-37de-08dcab34f0cc
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|461199028|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	Msq8dwDQb3HpDvIoPIKHnIoVK/polsOuJjz/7FPzhUE+rPhDOZfJBGAMEjIT2EvGA8Y1miZ2XeLwAQrE2q03WZJ3KEELJlId06iRHuIxq1UD1eYvjqump0XPU+oiycT9UHyorAgLnmAhenrnwl1k7AQR6tj+GTIlxiZKDGEaNcQ8UANkUYVuwlvrVXmi7s/hJgWp1L0NxFDcPBGzNaodR6OJl5IyhJ/DaF36jxmpoKaIYcFySel93R1PqJoJ2gkbhmIwkcdtxsTbHZwHXOKqK9fe9O46BueH5zByLt6eeIKCTo0VmxE/zP8fjdt8erYBPguZWRoYoB967Oxjo0PX7VMi5yq4+PkM+2+zLe/oUmzrg7LOlUaShiDo7BhuhQUnp8yeQeb/5d9b7adD6pXVipQGl9MPRFkx1n0aY8NzrJrkEbdmCBHEXyxiNRGL4fmSSYiDOseghafPa4S9ykeRI6nkeZ2TrQIqQXa4qbrK+7dn9Q3ic+QGGow5ue2oVG5eijRjNAHY5VjPpH1W1P9BWeeTdl1wHKoPUv/7UxgySN5iPOnGCH9ylGNeGNoOg+pP99aXvj7TpvHhet1Yua8k1mptYY0FN4h31veTRgOUfOvcqwCZo6CxiyyTK8qnKCI1giRcsN1uNP2TY3gxtaK9UOQUi48CjHqTEVti4a27xnMp7qCdATSiJgocEzG7+KyV
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hgyPQTfBcodGbwAJZozi0wkw7JTyh7p86kNx9ScJlFmL3KOxUCcU6qCZuhuM?=
 =?us-ascii?Q?yXQ2OWTD8aC6NPIFzE2fGXYIBHnpbenedT+7lT9x3F7yyrwejgqofXWsYxnF?=
 =?us-ascii?Q?t7CWw2gQgN2pgREFP1fRx1EWgrI4FeRKo1oyZr0S8DUMyATGUzj4/3aecvJW?=
 =?us-ascii?Q?U6Lt5c6Se55Dj70F7ntZ004vBzeGnwpgYeNkE5FKRZRCHNc3Kgp5QRPMf4Ne?=
 =?us-ascii?Q?OBZJ+4C1kqRLoRpDvToRtapOHsELs/HQLuHLrIbbIfkiEngoKnsV80Sz3hzr?=
 =?us-ascii?Q?gDKYiOfYhJo+MVaxgA1e+PljDS+kNmWnpTClZ638We7+BWfPdWkDOyitPKsU?=
 =?us-ascii?Q?Gru2zaqkzhNjQoqCzlf40U9MVD/0AMKuLp7MMjih6KPFTdNnnzv6UOJcpPq4?=
 =?us-ascii?Q?IRmELnOQhD2jrgERAHgl3bzJv3b4b8SqmagKlMJeb3jpEBzd0T+bqRyyUcc2?=
 =?us-ascii?Q?8nC7lyYY2fyp739lnJCP2k40HNgo/TLAiE6M+WIm4+t4T7IDDHC3pa6s1dXU?=
 =?us-ascii?Q?aTHHLEDX+TCjpVrBqrULOssOKmjjm2LgblnSyQSbkXWTz9d74EHx4vAtC2yc?=
 =?us-ascii?Q?WsvXk5p261BddMS4G2lrpLOMWXzGkTbDVSVqWuhjfesuspznYyUegHKacZQ6?=
 =?us-ascii?Q?DTffUbMhznumh5D/bF+IgaIyleLHagXnWuTrDtcNveQFuTT39l9xT8IoWNyN?=
 =?us-ascii?Q?s0u4i2T3w5EGywBxL9H9nY2IJTVcYtawn9hH8N0FdpWonR1EBQGAQ3ru4CAd?=
 =?us-ascii?Q?xJK1JBWx278RNCNMZrHGe9c1mPhDjuDAnAEg9kDNdQDUgDIemzy4l5Bk8Nor?=
 =?us-ascii?Q?Thj5n28rtbdaqNRgzqARfeGjFThS2lkEAgEn0wGlQ9DwPaYoBAfvLO/vrDFK?=
 =?us-ascii?Q?RcNRfcGTTxb3QfjC9RU10JDLEFaeivQHkHUxooWkfiTSg6Y3rVYCQ4hEPVlD?=
 =?us-ascii?Q?t4mMebl1lyfkHFjLaBNNaQHxtdwp7qBcTyrj9cUsbD3ts63QAElHFqPeswPU?=
 =?us-ascii?Q?BGHKBEfjYxyb2Ux+Da5ytjLnTMwE1ubIHinK0q1Wpkar304gGjVnVWyy0+Zn?=
 =?us-ascii?Q?pWUU2uc06q0mGcIWa0LYS6RXlXJUAUtwRMYKBukHMWpo0Heap/qNFR23bsdb?=
 =?us-ascii?Q?u0bieNYZghcXxsb2kYxjrDijaKhDnoDn4EdNbOq0Ed5ouq2p1nOlmfP0Y6Uu?=
 =?us-ascii?Q?4w3yLm3z/PMC9/0mTEBj9Qm9qvcxDOxxsG301+9StoSGdFwnynTbS3QTUn0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 429f32f1-09d4-4ff1-37de-08dcab34f0cc
X-MS-Exchange-CrossTenant-AuthSource: SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 16:31:45.0513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3P223MB0848

This patch makes three error messages in the driver easier to read by
capitalizing the first letters properly.
For example, "channel already linked" becomes "Channel already linked", and
"expect" becomes "expected", as you would typically 
find in an error message.
This patch improves user experience by making the errors clearer.

Signed-off-by: Steven Davis <goldside000@outlook.com>
---
V1 -> V2: Added a patch description
V2 -> V3: Changed subject line, removed apology from patch 
description, added change log
V3 -> V4: Rehauled subject and description
V4 -> V5: Updated change log, as I forgot in V4.

 drivers/staging/most/video/video.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
index 6254a5df2502..2b3cdb1ce140 100644
--- a/drivers/staging/most/video/video.c
+++ b/drivers/staging/most/video/video.c
@@ -454,18 +454,18 @@ static int comp_probe_channel(struct most_interface *iface, int channel_idx,
 	struct most_video_dev *mdev = get_comp_dev(iface, channel_idx);
 
 	if (mdev) {
-		pr_err("channel already linked\n");
+		pr_err("Channel already linked\n");
 		return -EEXIST;
 	}
 
 	if (ccfg->direction != MOST_CH_RX) {
-		pr_err("wrong direction, expect rx\n");
+		pr_err("Wrong direction, expected rx\n");
 		return -EINVAL;
 	}
 
 	if (ccfg->data_type != MOST_CH_SYNC &&
 	    ccfg->data_type != MOST_CH_ISOC) {
-		pr_err("wrong channel type, expect sync or isoc\n");
+		pr_err("Wrong channel type, expected sync or isoc\n");
 		return -EINVAL;
 	}
 
-- 
2.45.2


