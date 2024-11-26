Return-Path: <linux-kernel+bounces-421881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BAF9D9160
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 06:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B184D286814
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 05:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5253180A80;
	Tue, 26 Nov 2024 05:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I7Obt85M"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2045.outbound.protection.outlook.com [40.107.247.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F334B12F5A5;
	Tue, 26 Nov 2024 05:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732599221; cv=fail; b=mrw/sPBljSIBbas2Ic6x4EWDkN9EIuU8TTHHxinXnkLxPJJDRiaYVMD8iJnySD7sQuclJwI5JDbCq/qgqcDPjJXxTWCcBdys412ZoPTq9jri6W0ae3UGj8ilsAZNYebDKQGier8KQYdervWP9G5O7t9G1WGr0Jjeztt2O01GrMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732599221; c=relaxed/simple;
	bh=8kgGcxM8tn65DsPjaKXDrvKkxoyEDGYeI5uQYTtosp4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oP/8glPnQPj8CRbszPCN5Nf4ip84gTr7AdpAUobt3cWfVWNt6ulEdKLQNWZHP/vEUe3/6TlBfAlC0yv7/6CJ/My6fEOODA/u1qv7FPsHIZqOHzCiqgIhMeS2Lkh1WgL47bftAVI3J5Knza1qvuDLn5Yovdj7aQpMcE46FJdv2VE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I7Obt85M; arc=fail smtp.client-ip=40.107.247.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQ6JTeoEBgTU1zUH7gLuoRgMNXs1rakje6Fn29uh07EtfXwr9lZ2lurn6Kii5jLUBEaahkO6zR5N5pKQcbCb9Sss6SId1VBP/mXAXVHFosgcyuGFQbPQJK/RoGOj7kFUK89FJfHRnxpvZMEiclp8v0lI94PTg7nnpbAJRuEzRSi7AecM/tTwchR6IM9UOYq2nXYvDaSIN4jHJLPkiEk0rFgYLhL+lQHt2zSFC1DstMRcVZ4gyqwSNfBPZTjoL1CWeKgSRA3Zhx8SUNzjQrwaa2Oo9JSd3emx7ykmwnmy+zAqadVyIUgxDcBgYlhOLfUZFy6L1S9BN+YxkAaO/atSoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SBVo+6R8TMqDZjwFMlALR7NB/5af+hC6iksur8b5MU=;
 b=QgS92AMRUZWtA/3y4rV8QdkR6vQUbZ0X6KAObvdM2rse+21s1VcTBAYMrdjf3GNBa/8OBgdX28GPSHGSjopLdcPNTtHQ2WHMZUDrVw2yforjGnRxUnwMzoXGbbnUmhl7xONLe1mKsdtB3jtpAwOsIfPUMNi8bGAM7r50xlclUHw8uhx4jmsCMi5kFhVYvDsCMXV7ye4rda0w88IdvHXnb3IfRf6ar7YKVIgqh6gy3qsIv3oNmxUJ+YaqjMWi5BwColg/ggopR51JVsHxd8WeIgnvtHKFfALbC3yMvNnAY2bhMyTEpXm9LQZBjYQSmtQX49BHWyMTY9B3tGsl/5OHLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SBVo+6R8TMqDZjwFMlALR7NB/5af+hC6iksur8b5MU=;
 b=I7Obt85MP+vYYLNvyp5w1tRKbBcp9uhoI5+8uBjkq24tb8eFsN6s1O8Esh/yWkJgSjwFG6uajYWJLvSYl9NzHyO0DCYHbHdcbclAs5v9rSlJRCDT9RywzEkJIhq7VjPCkNUiCpA6T91cvM7LEb1XWBaLRghMG/6vVJnPTTdmLQ9WIjgeVFixX0bqPoJh6JqyAS0AkI439P3WyKDgpZsHNZdVH3X9OyBcbEzXDbeTt1rrW4u90o7K/uw03M/Zf1B+wqkMl7W0DJn5jG099+s5lmnYv6b+yIGHN3siOdUqxc1CyR3u6eFFCuzBcyvcrkq0txD6kvDbNSmMJkiHIuMakA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by VI0PR04MB11071.eurprd04.prod.outlook.com (2603:10a6:800:262::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Tue, 26 Nov
 2024 05:33:37 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%6]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 05:33:37 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ASoC: fsl_xcvr: change IFACE_PCM to IFACE_MIXER
Date: Tue, 26 Nov 2024 13:32:53 +0800
Message-Id: <20241126053254.3657344-2-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241126053254.3657344-1-shengjiu.wang@nxp.com>
References: <20241126053254.3657344-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::14) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|VI0PR04MB11071:EE_
X-MS-Office365-Filtering-Correlation-Id: 689d76fe-4228-460b-b275-08dd0ddbe016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tYtXmsfmdmqpVGZGM+TgrtpwDsn+Txy83+aSawNLk1wyMYKuGXYmCDabu0A9?=
 =?us-ascii?Q?yUZIYOFlMSK5s/IqtluNlWaA5O1Gz+L9Wge9gBmoDawTBpJ+9Ay9rCjk5vUk?=
 =?us-ascii?Q?WMTLzpv2xguPcV/hyKvRR5Y32fnijvoV8ljq3qNEDdMejnfiPoQtqVKS9rRi?=
 =?us-ascii?Q?zuaLQDe3d1ayAIVQKSBfaxhjL/IDEfJA8fopXO2XZ6Ziwl2vS0YbmgGYu5f9?=
 =?us-ascii?Q?0JP2MysMfYNT0vJagFVhabL9SKf6gcGuCQOokLuyLip525WxI3FxEPSV91MM?=
 =?us-ascii?Q?HOdQoIu/aVABTUkPzf/oP67SnJ7DZzPWzRn/azgM4PE9rtvCY/DmCJNQW7++?=
 =?us-ascii?Q?YAEg2OhMLsOL/kNgGTAhhhvkzDI2GWjWkdnxmYQLcNHjE5eZ7gHXhrthE5md?=
 =?us-ascii?Q?2ZVP27GgExvhmGUEJ+4L2ZB375CVK3/m0/Q8SZPshEcunPb2Acw2QC4XE7Yf?=
 =?us-ascii?Q?ftAfXi3mlEQhlKd2PW+dMXjAwOJ5ViDF39uZYcm646hTkhYe7mz4Ht0ZAEFT?=
 =?us-ascii?Q?sHhIxvpFKVOxWz7sRe7V2xZf2H0mQJMeOfKv6AwdDIhnzGIfXrDgd/5Jmanf?=
 =?us-ascii?Q?qBFpsEfTpr9W0+JHsx5FKDnZZMMKFhIixLU5EY5HVsuzJz/KxHCqxaOHzsni?=
 =?us-ascii?Q?m2MSu615D9SsIvGoYTAqzpuCMcCnpIb2oFvxASPrJ665cP7MvH+EP60qhJSx?=
 =?us-ascii?Q?GjiGuv6tK0jKSE4Z5TiXIIS+RU9LHAjAk3LkkTOdww+MsfXfdx8q78GzIfGE?=
 =?us-ascii?Q?tICtat4TROUMVv0nsCbEuZNVbUu/CsRe7IpYN02D+7+n3x7s2LqzJ38sg2J+?=
 =?us-ascii?Q?zN3Wyt7k15De0QuBSm91jT9TyIrHXzi+L3a2/mthwGeUTQiK+OsjvuEBXTBd?=
 =?us-ascii?Q?PMhNXVmZWIYKz8UhnQZ1PFCMsrgn3O3zn8vvFd8IjaWdlcuEqbws/8tYZcKB?=
 =?us-ascii?Q?VDzsYQ/+YUhNwxOLPEWtyPXmrLdhRtX3yc66hXglPr7o6x3+YLfZ7Y6yOefF?=
 =?us-ascii?Q?lWVPB6QDKpgTtW44UtnmBdH7/SRevTFCyazd0TZPRMN6X+imzOQ55a+7Iquu?=
 =?us-ascii?Q?A7UuMDG6E58uQiBzB3XZXjtP5DU7xGFnQ3n5dFNioIm4j1rSHnY0A9DcVW/I?=
 =?us-ascii?Q?aHUafr6yYO5M2NDYBD8v66JwglMNM5MUFlv+CnURE4Ro01XA8+8YevwIsNxZ?=
 =?us-ascii?Q?n6wHuypqPMwZrLPfD0Q2cpk9BqaCWmovtl8MKFsOGWCF7OdcMZ//A0mtumhJ?=
 =?us-ascii?Q?BZtq2UMAHEJj17nBR0x71wEFVvb67FwrNXr9KVJ1t4PnvTfmng/SDbyCRNpv?=
 =?us-ascii?Q?Ggdjlv4pCmIVm7tIUOMmc8jOewmtWnWpjvTZ5hoNyd2FOYK/AIvf+ONADtGK?=
 =?us-ascii?Q?RcPhy6cHSKi4wWBKWCIs8RlzAzKr2SVe9gjLCTPL0ihy1KHocgmYVbwd6h2o?=
 =?us-ascii?Q?XM+fzS1C76c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MWR884j76w3IaRdcHdDxZG8WCgq3kVQzgJXDzjZGQdOaM74DyZcntTXAM76N?=
 =?us-ascii?Q?sHPaePFe1nGMcLuSTzgxdIgdMdq/sUzmzv8+VpEB4BA0Y+2tL2EheJJuJXdR?=
 =?us-ascii?Q?1HBYr+B1i8PKlYiv/kLtQGiyWtsBINVFsihan1rdV6erWOf/4mq/x4OPU356?=
 =?us-ascii?Q?AwF3JO/dPo0msD5fdGcU7pRwyAUgJ1v6gWPD2deHQTYWbc6jpD71p5Xnc0TN?=
 =?us-ascii?Q?cT+Q4w9EYz6S85rjPlQAhBiKTSV/gy04Ogm8a1gKIuhjBc0k0cttLoWLWMLJ?=
 =?us-ascii?Q?7ogZLBzSbTAPrUD5tcYTUBod+epg7HwMtzpwXNVc1f05v5tmaLfyIb6rFR6k?=
 =?us-ascii?Q?1uVVZpSQ/WnKz+TTfWszIPiM34jUE7a4yEDNBy5M98OTRsgEywpHD5B0VfM/?=
 =?us-ascii?Q?rOdfIbnyAx3MKPoO4p+3O1PnDWyPWpzOGbI065RzoStCITPTMtD+lupBUMpL?=
 =?us-ascii?Q?tbPaUXtI+1KJkdKUaOtEfVp82GOBy7oy3K5kL6IdpG7EiWHiwupjlmx60NRY?=
 =?us-ascii?Q?CVcs3s8tsPqUjh9cAzY0oJrTMRnKexoVouV8GsfvsPFovp0dFmqYAwygFEM4?=
 =?us-ascii?Q?Sti0nqeGkT9+/k+XJtX7B448zPxysjj/H5GBxUGelMdhri5OgeUhL9ZwsQmf?=
 =?us-ascii?Q?evf0l2aYhXqobq1uZxUVSGkkgeTjTmCa7hX0zAvH2wrfivKk7pbL/o+a92z2?=
 =?us-ascii?Q?5HC5heAPBlsiOU/QkPVJckVUKgDlBjicIQudowtXLTsf2wMuDnRlV5nVFNYZ?=
 =?us-ascii?Q?flw6S3kH9cQEproKb6YtVL6TLj+7L+k5qPPD+EdMZ/+y1K6gMxQnP8LKCnxn?=
 =?us-ascii?Q?rayIeak+zxjyXQzUF3yBrDQ9JDb3x7j8q6gY1fKCVC7bozGbwKFgXrj5m0HC?=
 =?us-ascii?Q?BpaAS/wc47L8+WTXpnmhPqMcr1D8r6wl7VxZTNFczwXGvbYHkamV4oxykjxM?=
 =?us-ascii?Q?p/prr7eaFwnAaC/n7CLQEzDT57CbmslnnsXjV8BYxGRfb2trveU3suUfa3r0?=
 =?us-ascii?Q?JyEKYQsJ8XBW/oEITAKy1tf+PlwdKAVJfH9PcLcZcR3fXodcFgrP8IweGDiG?=
 =?us-ascii?Q?h6BbuHOM5zKwlbMgkJGWIuKR61xZWuJZt0MJLdvqC2SJtYdmtKMWZabftoNF?=
 =?us-ascii?Q?3wsmuwxrz1UDzWIzR7n5hGmk8RE03uz1VKeJPqlgYNCdg5frmZTZ/aMFr7UW?=
 =?us-ascii?Q?lV9fyQRu7UtgV97hfnDte1lbvPVwp7GB00N2e41kUhQwQvjNAI87JdCEyGfW?=
 =?us-ascii?Q?lSACFUH6fUVprDR83C/7vtcRVZ/THBTPXTFvHe0ASl4Qx/DxHrE5/yjiJKWG?=
 =?us-ascii?Q?8mkkCJEaVq/kWsFhtMi9obkLNJNp6WliaqcAUUPsWxYvsudajOSjJkpTZeFo?=
 =?us-ascii?Q?MoS6CdbM8cgCx7QvhL18vtMX229p7mZZSNpDMEwemEclFvEqBOggsoiVuvA5?=
 =?us-ascii?Q?iyJ0ioHUbop/SPyLajEJRlUYXGhqxuWZHL+G1jvCwKGG0uxi5Xn/l1YElgY2?=
 =?us-ascii?Q?+9CgV+dukUEZOGf21o9lKOx7HuhWYp9eptLjmhJ3E5NlwGgBbFJAZ4IscQ4E?=
 =?us-ascii?Q?6yKPUVm2+fWl9D0kQNwI3pcG+zFWK71V8nN/t2J/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 689d76fe-4228-460b-b275-08dd0ddbe016
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 05:33:36.9897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kE166K+/49D5oc8IUOUkxap2X5L/b+d43HhxGDVMipKvTRd+XnEUle37RG5LQIjniGHPZ7GKdwmjhZ9hUtGMcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11071

As the snd_soc_card_get_kcontrol() is updated to use
snd_ctl_find_id_mixer() in
commit 897cc72b0837 ("ASoC: soc-card: Use
snd_ctl_find_id_mixer() instead of open-coding")
which make the iface fix to be IFACE_MIXER.

Fixes: 897cc72b0837 ("ASoC: soc-card: Use snd_ctl_find_id_mixer() instead of open-coding")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_xcvr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index 1e0bfd59d511..9c184ab73468 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -171,7 +171,7 @@ static int fsl_xcvr_capds_put(struct snd_kcontrol *kcontrol,
 }
 
 static struct snd_kcontrol_new fsl_xcvr_earc_capds_kctl = {
-	.iface = SNDRV_CTL_ELEM_IFACE_PCM,
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Capabilities Data Structure",
 	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
 	.info = fsl_xcvr_type_capds_bytes_info,
-- 
2.34.1


