Return-Path: <linux-kernel+bounces-322418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBA39728C6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18B141F2515B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 05:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0FB1547FE;
	Tue, 10 Sep 2024 05:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VYIsnskB"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012032.outbound.protection.outlook.com [52.101.66.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A5612E48
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 05:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725944861; cv=fail; b=LQfgOYYwhvR03CwZQAuT7I34I5qVEQtKAJMkhb1c8T3ey3n0eiQLAF9nj29Z1Otx9td4IkGIHoPD0rRhr8nAm73Q8+HdPDHIAoG1pOQtLb7y8cp7Q5cR8ZytN78yOvJS0bF9xczEDxcZ+0GwK57jHi2BGL0M8xRHGcq+sYWCg10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725944861; c=relaxed/simple;
	bh=3MVDNXQSoZgsbtBYxX9n7GXp3B5h2Dm5cODXsuwQy+c=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WvGjyaVX+7mAnSfaP4OUbhYGqo1Lyq+hHkcX8l3g9hLo6+dSgDiVS2DpqwfXJOI2MgVoqYw83EffaRIiv8UI1X3B97Lio3uN/dTnNd3vGqTepIE//T7Mbgq1wPGPdOBUeoOdkssHDfWw2lexojuePZ5EG8c9I10ZDS7VYsn49Go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VYIsnskB; arc=fail smtp.client-ip=52.101.66.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vX5cpqT/qM8WXdhow+v7aJgv5B9OpmI2bobPehkpZ+z1tgw3CE1LzH6h69SSEwLd1qvPVYRVfD0lRHA/j5w1/QEYqtS9vIUt/+CCyrQ8mRyn/b/v06N7v9znHJCakPzhbxpIwiPuLcZArH/gE5Zf+vmOYljVn9AcwPobv+lVuqBoGm+PfWy2VRNWHlo6P5Y/w14jeaSfHweB/sZ2psJLIT0EiZ7QDDs4BscXE4LPZtXF/RywAPuoA1whmGfx3JHDPumikOvo+3lwmG8boHK6PNNkm1TnmoNyPyin5CIEp1t3Ra+Bg7Zv5vTj+3E/kmSrkPqXMfchsyswHBC9dsi4YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLXvFcXqaV8OnaBfbT0OdUDO3x8JowFD99/xqDUU4Oo=;
 b=QMCrL0/lIExB0g6+Avh6xgoas6tbTOa/asI6BVAJ92si46IXREeD5mf5Kx8xjZpOKb5/fQ6+qD47yNgRfsgKZqeHuO7sEawHDZZUZjtxHew4tLm1L0a2FjFEKIZj8DNEEcXWowdsy7WSCv5JVaab/O7QLV4E8M71ZpwB2V6wG7SgAus6JGp8B9aWPm/XAW+vymX92RRU6IYdCY0VQd5WIdE0Ou0NV7I6LjCk1Ferpgnl2xr/94vov9/2lRcT0uEt0QeKZD6JNqy12oNtlWaz1FREcqSbnGLwt/oqRa0EBfXOvzc2lOMStGFr8BVrhq9ir8vqsRhULmNGOZEvA/nJPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLXvFcXqaV8OnaBfbT0OdUDO3x8JowFD99/xqDUU4Oo=;
 b=VYIsnskBAytSJB2AT/kwGokCXITLHfI7v8drwfpE8iIU1HGTlKUtQpCikRQRa8a7qPRNn2oQ/eePbZBU6xyq08IooVvVxix4ICcRbH3E9cyTMKB4xBIyWhxKmSblRKHy39fiJPhw1H24rSrroHjnX6zQ9tKpg0TEXL06bWMoYW06YbEBUNc2BawwYki52gDTFtHc0hQu4MK1Iq/9Xk3hgonWouN2GUKcPPsRoxbKN1gtPpEgDGd7SavxBnf2z5/Rr5gwMR85/foyLvkuHPQF9CAiYSQWySNPMpuPrfFT+zaVmrVQHYI/8CKJKpWyqpYhpH6VeDHVbVwsha9lk+bX9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB5003.eurprd04.prod.outlook.com (2603:10a6:10:1a::19)
 by VI1PR04MB7134.eurprd04.prod.outlook.com (2603:10a6:800:12e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Tue, 10 Sep
 2024 05:07:35 +0000
Received: from DB7PR04MB5003.eurprd04.prod.outlook.com
 ([fe80::68ea:5937:4fa7:db2b]) by DB7PR04MB5003.eurprd04.prod.outlook.com
 ([fe80::68ea:5937:4fa7:db2b%6]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 05:07:35 +0000
From: carlos.song@nxp.com
To: alexandre.belloni@bootlin.com,
	miquel.raynal@bootlin.com,
	conor.culhane@silvaco.com,
	frank.li@nxp.com
Cc: linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH V5 1/2] i3c: master: support to adjust first broadcast address speed
Date: Tue, 10 Sep 2024 13:16:25 +0800
Message-Id: <20240910051626.4052552-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0197.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::8) To DB7PR04MB5003.eurprd04.prod.outlook.com
 (2603:10a6:10:1a::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB5003:EE_|VI1PR04MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a49e9a2-b6ef-46de-6d99-08dcd1567b13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tv3ADf5QxFVUY4BUfZNhU/20p589kn3PTdYolBMnEqseYaKgggXvgh9nfRX5?=
 =?us-ascii?Q?Lcwdwx/A+Iexi5gMzf2Z0Auxnp/8GhjB5WuA9LkFu4gcX+3BE1i6zZoZaEOc?=
 =?us-ascii?Q?evlV9uMoFen2V55ATg17e8+/5lOTsyP5zeAki/al9cIuyJpZTj/9ZqjStgGV?=
 =?us-ascii?Q?P9xpr/SdNuNbG1MVT2zgFSxiH4q4FV2nSAxElI5EZt+M47F4sfu9sL1yujUh?=
 =?us-ascii?Q?qVJ9rtdk9iP+HQbyXGmT1YDH9qspyCAHSghn8WFuAGaUUhkfpVBVslyofQm3?=
 =?us-ascii?Q?ke904Glj1wNTBi2FzCbDKlxnSQ0UOh7XS3X5kO1Woeo8AohvEFR3jDrlLrRt?=
 =?us-ascii?Q?qnzk6t7MfIpjbBQLrzf0IIo/pumjbpDXiaLw6u32SZ7arL2Am5xN/pH/3/N4?=
 =?us-ascii?Q?5OlAZfjN6zJILUzQ2sH2DNIB0GD+x/SGtPpO/ZyT3DA7roTmmBEny3OOFPCE?=
 =?us-ascii?Q?us9lN1pPs+Dquaubdh7giSZi6sLEV5kQu3Wcd6FeeV6MvjQuMccB6IxE3fki?=
 =?us-ascii?Q?xbFsaYZUXCwVmwXZAb0goBL4VuhGE/F3WjgcqzAGcf/I1BoUccXo1CZw9/FX?=
 =?us-ascii?Q?HaCf7/WrPRhGNrNZ0rSz+p+ywwSgxkAJNCFzS9QyiOZk7KrPi1AZnA11tGQy?=
 =?us-ascii?Q?Ke7Z3Ga+G8UJFMmt0AmWdDDElqZbvDv0PMCs1L+CBop8VlHbvTVsygUichs4?=
 =?us-ascii?Q?7cIB6L/otoQtz5aCUa5I7I8drcfRz8PdY3wgJpaf1uCKujxb5vQ52V1G6fjF?=
 =?us-ascii?Q?xc9Jsv5FP0ejJza2mmtpUNxqbHXZ3PjCjpKrPCfHpMYV9oMF6gu69q9zU+uf?=
 =?us-ascii?Q?qFHAqUU5dMGgsBuu2x6qebh9f3OjgcMAUIVRCfqeJKsQKVOKPSugRkLOHdDT?=
 =?us-ascii?Q?D4KhtYSikBS8ViXk0pSyhAL4IWp+EYqALMPLxplbm1PZAPO+5ZMH7wgmuPMi?=
 =?us-ascii?Q?jJqi2AA0jOTmSKKyQq7V9TLeU9ACFadul3aKF79O/ZD7OgZQ0I0mO6mkgLId?=
 =?us-ascii?Q?BS1UmoD2jBgZ316vwCFhbOY4NoNmj0sBPvjen1L5FNtNtfOX6ussshtG9E9k?=
 =?us-ascii?Q?miT6eEyu0IK55ndZQbD95gYqKcUv6cUSR0GG5fr+6BK21+lyOveIJJ4NJuLK?=
 =?us-ascii?Q?tOtQ9IVoiWhyjWRfMf99r8V2qroEeGQokMmm1q+jhwiEBBoJF0sJVQbx3Gfx?=
 =?us-ascii?Q?S1IlwqsK83sSkWPeFyEL+NEgnWupBxyOwUr95A8EupbfLIJtEHp2SuqyoS4g?=
 =?us-ascii?Q?YEiEFNzZzrgbHpsxp4P63unZ54bYcCCTRSEJYorWZf3wiSUPNllropnHeA0S?=
 =?us-ascii?Q?l509uGAEVo7+EataYocRbEPCY7+31a29QlEU/CV/VWlV3aJBeyK0bgZ0lDgj?=
 =?us-ascii?Q?1w/ERWSNzuzdSAk4lBr/SFgjL8Vxga/8Tpu75tXLjg3Va2cPhQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5003.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tw+5x6Ca6UkTmx7f0tjQpqvlMTef16YwSEIrSGBLUftvBgvcCwHDAx5nY8B8?=
 =?us-ascii?Q?ZwmjMh1ySqfTn3OmsyU5MJJraesoB0UBScAisxWaHrHc3dLZPtsHEWY0msli?=
 =?us-ascii?Q?Cqav/I+5mZu5wn/c+Q10+LnCQv60STUrly9a888X4hVlyP01CxzzMyAEaBnS?=
 =?us-ascii?Q?SGhe8vWYlHbwiCeCZdZcqp/8tOLYQIOnZGNFobtxqL+GGBN1jRYeiTmx1yLY?=
 =?us-ascii?Q?yZSlZVEdFqgnZLIUriUEWP8xgpU77ro8ABLMtSZxeykCWCytG4pacgoX8TxB?=
 =?us-ascii?Q?ityyqbFbdF9BpecetwtDSo5iUcvkzPj2Ft0fMG1xJM/OMbv1JvQdsOATZM/F?=
 =?us-ascii?Q?+qxFtCvWlcyeI0aSbAI3kDiKco8sBbqGDQ2rJd+tfrnU8iBn5DVhy1s4Fcbt?=
 =?us-ascii?Q?l0fE0sxQceiSS5Vd1PQH+EWcQyZtX1uKwcpfhrYGpx+yJvQCrPFSyiY14SJm?=
 =?us-ascii?Q?IMoamUl5d+fzP/ntCO7zAxtjpmzk516cAgcQknXHbrpwdSwesGh0wJLmtS+m?=
 =?us-ascii?Q?PbEi11FSnhcCgM2K27O6pf5C+HeftJd5PL/5YU1fpfM3Xj4kcZ1ezECBOUCQ?=
 =?us-ascii?Q?3/JfHrlBvmWkc18Kyl6vTBh/7MXz9VwDzYTgucaImBgNVNsAL5YNP2dp/fOQ?=
 =?us-ascii?Q?hsyNhNosL6slgE86Xnfn8pcWaKe/agELRUIRYqpwdvpeAh/tVB1cwKAcKQP9?=
 =?us-ascii?Q?C4drqAW72Y7CCqsFBDP49KiO5pBQ2hlxa7z1wFylKHVrAu6h3vXLUZn48n+l?=
 =?us-ascii?Q?HXO7m5F8FDnkNX7sypA5dL+ExADm1D+4XcO7jJryF8PSPYbCJmR9h9vfWifh?=
 =?us-ascii?Q?tm5pjBVAP4cyinWb/oYiPHAXZWgdrlo4tDvnJ9qFNignW1oFuec4FN0NjTNl?=
 =?us-ascii?Q?dHf47WoAKAU4BfycedlL2pqCHWCp7K4j6JGIeUG5fPv5TUPRQtNOehTLzxdY?=
 =?us-ascii?Q?Pcrg63Nr2ctYW19ypxIZspSTDskY7CN6FeV6cdzHTgw1pb8qznROgI4+xSzV?=
 =?us-ascii?Q?Teh0uRjqfsFTmIWBLGUEkO+xxwdzWCg81AeKiGxu3jbi9C8bP8guPwh23O6O?=
 =?us-ascii?Q?DvOu+kw+ahIPmz++F8+92+4lhWygIhDXLz/PFRQBM7HenVvWOSAa1c0MTwl3?=
 =?us-ascii?Q?e4pDKLghMpzW9HxObUhITdHoufK2gcBKHFGJ8TpxzPMzFdlswfTpZXxWGNHw?=
 =?us-ascii?Q?6tc/vLlkV9pF0UxUVTt7SxhwPP75QlnALntlwJ2Z+oLasZHknGOL/2+TxnKU?=
 =?us-ascii?Q?cKIwu98cop+yZL0+9vvIGXJr33FPE6l8Ge+E06rzmRo+w2ZlSFTQXXIyI+Pe?=
 =?us-ascii?Q?z4okI/jpLs5xDKLXg5kfUo+YAKYITDg63JbKidh4qaqaUGLQ7VlJfMGH5buq?=
 =?us-ascii?Q?+B8MsWsyBbUiORj/5rXQA5I/M3qSaABqoSq6rTQP3B/JmvObOR6Op0pypQne?=
 =?us-ascii?Q?rJpyYXOCvV3Qu/Pwo/ja9qVMqPkPnmueSC2SSDKuwOcjm4GJXnvWSzpBdx+W?=
 =?us-ascii?Q?hvpzTT0/HEXT3V5HR3Wl2edtaqDVFK5MYbJCQuuQmZ37kFvIQ3sww7lS01xc?=
 =?us-ascii?Q?1kCkDLGKhe3x/20E5juWPj4RxaD3ZcgVzJ4/F/0b?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a49e9a2-b6ef-46de-6d99-08dcd1567b13
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5003.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 05:07:35.2017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwbQHt7AxKcuND1XtjPbSrPNQyKtmNFo2UJB/saTR0kLr51KVq14gUY2yNYCtdyDDSoZtczQTery+ByIJxhk3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7134

From: Carlos Song <carlos.song@nxp.com>

According to I3C spec 6.2 Timing Specification, the Open Drain High Period
of SCL Clock timing for first broadcast address should be adjusted to 200ns
at least. I3C device working as i2c device will see the broadcast to close
its Spike Filter then change to work at I3C mode. After that I3C open drain
SCL high level should be adjusted back.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Change for V5:
- No change. Resend this patch to list after subscribe to mail list.
Change for V4:
- No change. Send this patch with svc-i3c-master.c fix patch.
Change for V3:
- Modify comments from Miquel's suggestion
Change for V2:
- Fix set_speed description from Frank's comment
---
 drivers/i3c/master.c       | 12 ++++++++++++
 include/linux/i3c/master.h | 16 ++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 7028f03c2c42..6f3eb710a75d 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1868,6 +1868,12 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 		goto err_bus_cleanup;
 	}
 
+	if (master->ops->set_speed) {
+		ret = master->ops->set_speed(master, I3C_OPEN_DRAIN_SLOW_SPEED);
+		if (ret)
+			goto err_bus_cleanup;
+	}
+
 	/*
 	 * Reset all dynamic address that may have been assigned before
 	 * (assigned by the bootloader for example).
@@ -1876,6 +1882,12 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 	if (ret && ret != I3C_ERROR_M2)
 		goto err_bus_cleanup;
 
+	if (master->ops->set_speed) {
+		master->ops->set_speed(master, I3C_OPEN_DRAIN_NORMAL_SPEED);
+		if (ret)
+			goto err_bus_cleanup;
+	}
+
 	/* Disable all slave events before starting DAA. */
 	ret = i3c_master_disec_locked(master, I3C_BROADCAST_ADDR,
 				      I3C_CCC_EVENT_SIR | I3C_CCC_EVENT_MR |
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 074f632868d9..2a1ed05d5782 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -277,6 +277,20 @@ enum i3c_bus_mode {
 	I3C_BUS_MODE_MIXED_SLOW,
 };
 
+/**
+ * enum i3c_open_drain_speed - I3C open-drain speed
+ * @I3C_OPEN_DRAIN_SLOW_SPEED: Slow open-drain speed for sending the first
+ *				broadcast address. The first broadcast address at this speed
+ *				will be visible to all devices on the I3C bus. I3C devices
+ *				working in I2C mode will turn off their spike filter when
+ *				switching into I3C mode.
+ * @I3C_OPEN_DRAIN_NORMAL_SPEED: Normal open-drain speed in I3C bus mode.
+ */
+enum i3c_open_drain_speed {
+	I3C_OPEN_DRAIN_SLOW_SPEED,
+	I3C_OPEN_DRAIN_NORMAL_SPEED,
+};
+
 /**
  * enum i3c_addr_slot_status - I3C address slot status
  * @I3C_ADDR_SLOT_FREE: address is free
@@ -436,6 +450,7 @@ struct i3c_bus {
  *		      NULL.
  * @enable_hotjoin: enable hot join event detect.
  * @disable_hotjoin: disable hot join event detect.
+ * @set_speed: adjust I3C open drain mode timing.
  */
 struct i3c_master_controller_ops {
 	int (*bus_init)(struct i3c_master_controller *master);
@@ -464,6 +479,7 @@ struct i3c_master_controller_ops {
 				 struct i3c_ibi_slot *slot);
 	int (*enable_hotjoin)(struct i3c_master_controller *master);
 	int (*disable_hotjoin)(struct i3c_master_controller *master);
+	int (*set_speed)(struct i3c_master_controller *master, enum i3c_open_drain_speed speed);
 };
 
 /**
-- 
2.34.1


