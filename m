Return-Path: <linux-kernel+bounces-260873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A13C93AFB2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 12:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D6841C21FBD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 10:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E87B155A4F;
	Wed, 24 Jul 2024 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="MMlU7id1"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2054.outbound.protection.outlook.com [40.107.117.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B319C155731
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 10:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721816048; cv=fail; b=UGZzvkaXgxNYz4f2DVwSLd+AyoK9rgxEaLUuuNVhLQCt1fH6vq1h/cO1JNmMMa6hcxCjWiZQxfxHpRO60W9zui/colPUqiO8pyDdltrMueW0TzieyQO1HUCqo+jsym1w66tSptV7CRrszMXiQyhmmPepnnEBmUpQV0AoRxf39ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721816048; c=relaxed/simple;
	bh=XzZmXRu7clLKcdM8EanvGH7tKPXBU09OrDt+1djrBgk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PNWTryLgIWFAk23xVeo5pILSDKk1OHlTBjjkQcUgUH4jzEvZ6uJisg6sNScubdKMaIPChnqOO5DIzQ70qsmfyyh8G8Fpcm4FUmm30r3B1Z6rlpgUu5WDzwaS3RHtiPl6je6O73J9wIUXpkJvqK80ncK+GApRj7rgoY2ofM+OVZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=MMlU7id1; arc=fail smtp.client-ip=40.107.117.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EssxzfQyyngxa/sgXYc7rCBrbaV8jW8aknI2IPmMobAeiZs6ZUvz2keio+LObj+1BD/euPv3ItAHd7Tf/wwigTxLb/RuA36sgVU+LK1EBA5odSbSGvfblzzu3Or/rO5ztFoGTLeBA9SXh43F4TvcwGVXaKkV6qacBgM5zW/Q3VyinSy8wvw5eaBTpw5Fu/nR7Bc7p19xTeVpxBr3+ihcNFcfYOr8ZC1uMFvtLHuts2g+igjRpBvCMnLARJ3TrkOo37UXywG8G7PR5NIhfbIhbAJ+7QQMM6u/fxxr8Qu4yzwjlVwjD55kXhdm73FEfG0HOit70+gQDxfkXeuzGwbhXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ybn/WBehd/TAOlsx7/a+TgB0a++gTXCL/ZC2WLjQHTI=;
 b=tphPvPHOHqPz5EdM3UKBvVNFT6zWd+Knaow4qPlx9CUiqqGVZ1cN2z+Al0J2AOHLFoyma+DjYyMArocOeoOstFGbp8Jj0rmPnoJHg28yFLeRsR9OVB1YXkxXT0Duo0k2545Jm/bpCcLLkknXKqxezoe8p5FSdZ1B+Pi8jjrOoEvhINZNdobGmjycYpj5ROEyD5rHGhR0Jg3Z2432ApkZxQfGb9Ej3yW+JQyjk+Hn15iLesykQqKew8UPi29haZBrEPS83WYYp8YT3Vq+e9qnke1M3v8GN2MKaUPsnMw7jpXcZreAetlLo04e6RHPVcmdq13+NXDmu74Qp0EpJrGi0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ybn/WBehd/TAOlsx7/a+TgB0a++gTXCL/ZC2WLjQHTI=;
 b=MMlU7id1eubhGgPuxLzR2WxS0bGtL4AkTJSGNt+8BPHc6gm+r0dckdwdC8J8ionFLW0R6CI/w08HtubBhFiJ1uU3pYFjAPpuiypi+ftWK43nlmQVHdFgXzb1UikP+NYr9kHNOjLQ0jL78JjBQ2TqynaJr9Tt2tY1DS2wiNGhO4xTEYKcSwDaqto+RLaCgv8f4lFO9O1RTCKQbz1F/fTJMewrazRv3O/vwY/g2U37nKDmxm9ddmFejKafH926YGJvLHY8KV34KYJY1i4dLbO9fJ/oLpNfzZIE0uhFZi9gSZmCeylK9rxl4X2Ezu0NGIQQsbIvTHTWztvhSUYifkGv6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by SEYPR06MB5232.apcprd06.prod.outlook.com (2603:1096:101:85::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Wed, 24 Jul
 2024 10:14:00 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%5]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 10:13:57 +0000
From: Wu Bo <bo.wu@vivo.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Wu Bo <wubo.oduw@gmail.com>,
	Wu Bo <bo.wu@vivo.com>
Subject: [PATCH] libf2fs: add BLKFINISHZONE define if not defined
Date: Wed, 24 Jul 2024 04:28:18 -0600
Message-Id: <20240724102818.2665047-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0175.apcprd04.prod.outlook.com
 (2603:1096:4:14::13) To PSAPR06MB4486.apcprd06.prod.outlook.com
 (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|SEYPR06MB5232:EE_
X-MS-Office365-Filtering-Correlation-Id: b86900fa-8649-4cdf-b3d5-08dcabc95491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VW4/tHqPX3XYxxjswncK/zJ3h/1n50Twyc9KcJSLj5/37nk8uKw2acShSLFO?=
 =?us-ascii?Q?kQXyCFUGR5UaAfbZ1lVpTkaCZhwtT9aeZtc9xhH9il+CoAUAS6kat0XOST0D?=
 =?us-ascii?Q?3wrJF4vvPe9KLE0DSOm9dKIdFiZSXpdphZRRVtke1AXA5GX05g5V+RWRxbUc?=
 =?us-ascii?Q?W2sxWaYnQN9qMhny8mUCcxpzDczf++ssX2/6VL5cO9oye3/NiVBox1yoCgyf?=
 =?us-ascii?Q?8VCph0aRhfp3yyPpCiAXrt+QMoKPIpgTE9wiM/h3hkgfY57tDCosdMY7HX0X?=
 =?us-ascii?Q?5a8XtUw4ZwPsejLRlVqd4J4JITKkAwvDouU1bRhS5ZjI7kWXan1sR9bP/Jck?=
 =?us-ascii?Q?TtfPF5etiQB6SLLGZtzUKk56XwHlpNQsmNmTvbYWroy9vmM0DlOTbrgFoJnR?=
 =?us-ascii?Q?ImAP/LpqMH7Yq9bZXRIi5bUo+f4uEksrUjsv8dQpu/+JPd2S+0e5boTWOMs1?=
 =?us-ascii?Q?Ak5RhSAVTKSZR2GacJO4KOqVRrzdqds19vQpXpr56UlqliX5ScV6SodH07S2?=
 =?us-ascii?Q?JvQzAKvW7LdDSlQFDGpBhcrjxhnHFXG5NRFwMGKlaScifn+TsPcehnEEK9RL?=
 =?us-ascii?Q?lWOYM+FGoAwUmFEFYc/JdSMrubX53NC+6+enogIaPEU1hc9wjKjm7vC2EAho?=
 =?us-ascii?Q?LwmR/HUxoZfLNVAKEY9VAy3ZGxX3xPjc3BwpV4t14jrqrGg4qKA9TcssuMAj?=
 =?us-ascii?Q?RPlTSR7/G/gVPCvN00+ydFYG8hkRdT0AtVVKCrd1sZk0YQ+rb9pSmOsZhTBW?=
 =?us-ascii?Q?xvIuV/jv9jxcDVYZHWZl32N45GewJFfImVL2TKG7XL9tzxKC+L+ptU86EJfr?=
 =?us-ascii?Q?TuoyYiN8Wui1Fst4HefDVZk1iaP1XI/JY7UwTHWs10TK/xYqoy3awW+nQMS9?=
 =?us-ascii?Q?ZyG7v0BtgozCt7Zpb9LQk5MKmDziIbPZona6ke1HYt5qbY9ixZ9aaU+Xs/W5?=
 =?us-ascii?Q?MWHEI5e21S6V+o92+f0DGrbkmNNzAFFpoGRrBkSiGrHQwwyjK4Ip33e4d1vi?=
 =?us-ascii?Q?DZeZgRj15oSuFgZIKlrn0LB5DiCdEhuzONV5OqTXnup7c2RcUtxuzqB7iEZf?=
 =?us-ascii?Q?+HoUSKI+c2I/wuEKAGhHpKniNx5XAGoLqOse6vlKzHqqiH+5eNnzaHeMyK/n?=
 =?us-ascii?Q?vpcAmCzI3TBSLp2Vlbejiy3WdJ54E3G6eRktnZNtqoO0DNqgbdSzNnfm30/i?=
 =?us-ascii?Q?USqx+tieKDV9tkegzhSc3zhrpoOL0e43BCk2ZMtqPCFUWQAhCzHEaG4wQSwA?=
 =?us-ascii?Q?jJXffsQ3TtnqACXow8xKslkOMZxT1IUb0oGpmGDmyByeyKgAJ4SXtqVqBsVJ?=
 =?us-ascii?Q?vaRZ5IaywWcIXU8ObZ+DT/FWcw2qy+rSU30f6THxJzVq96SYBp5EndVES3UX?=
 =?us-ascii?Q?gbRi4OOuisSlU00jFjBQ/MAqzjCZgz49Ek9daYtDrIl8KjLiYg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tGH5IrtPvQIzMStO1ewNkLLlqNPbi/rFuLFOY6TXqnXBh1r54o4cDYosHX+r?=
 =?us-ascii?Q?/JRZaBve+ivkLyCFFzGQEyF9Hdu3MzbFPRYv7B3UP+5oHEOwnBK0gdXutUOP?=
 =?us-ascii?Q?NgmqXtrif1HAkOF3FxFroJ5jfAWJi9zd2NE1l+f7XgEKK4YoDGDFL4qOAAxX?=
 =?us-ascii?Q?j4Krh7izrmVpPDg7CZfmRF9gl9/OO2mUpnE8RhFJYn3MjkbgxqZSgJf3AUKB?=
 =?us-ascii?Q?E5sSeKJ9CnyHubh3ATclx+ZnZeBslb2uZ8NkD0Vha0VUJVD25uM3WI9zD5Ac?=
 =?us-ascii?Q?LrAz6ggtvEUyYYrrJzIBIeBhpFbp27gmLTfBwvmecY6m1xqQB1nYzr3DXwjR?=
 =?us-ascii?Q?W1sbTyK6UBC6f/6ViLNgcEv11tImpyx14ztVfDI25H0GfCXhP2+QTkVSTP7q?=
 =?us-ascii?Q?DmBgHudcdm4Ij2L1WglZLJVLH8nZRbJOyPSgYVw7XovG6Q//VEzPTKzshSlJ?=
 =?us-ascii?Q?LOXU3KsWcwpyS5KzmM8y8K+a01L57WLLb5mVz0BltWNoEj/IGg/ZGR8ZDLAn?=
 =?us-ascii?Q?/pHR2cgSrC8NmTViFtk7AoL3AfzLQTevYUoJv7PWN3zwTxzZqbsuSDyCSCKL?=
 =?us-ascii?Q?9sjnvdU4Bi4//V7eLPUWoq1tcZxT3yJCh9uSOrz+NIT8hK0FHl++Td1PfJ6a?=
 =?us-ascii?Q?yhaZYDFAykNuq6YS1i3RzAzMtdMofAJGvy+As7uySc9jfu7QNgmtylbIN5I3?=
 =?us-ascii?Q?kdk2f81rSFAwHaRrUjI3GMF6O6iLeiU/2l8utWKSFxGwPtaHyjLCsChRw287?=
 =?us-ascii?Q?KQ3PWYsq+YH1rXEbYOrWZsElSyQEhySPUJyB5uS0iPyZaG/bjRvFOE+I/LNP?=
 =?us-ascii?Q?Zh0I1O+1u87tbjGdbwyV/Kj2NDgGWcYckwlYQJKDrL2k3Dl89oKvxvk+lWTh?=
 =?us-ascii?Q?qp305ZGwtjtpuawqVSc8t+ih6AYSzv4tICtqkqskMH5nR7H13f+FTPgNSktc?=
 =?us-ascii?Q?t95VbDp42EBpEVSPPK9VTLBc+1jV++AUJgFBckNtPX8+R7QWujGLlpAgCXA9?=
 =?us-ascii?Q?kxDBSDrO+5gN/YBmEafeqIrKHqyh5HCLzbEzR/NMUK9dLYCTzk8/0+O66YQf?=
 =?us-ascii?Q?Vj7Dp79lGMkxb+fNoAXUR9oJcUcT5PJRLZI9Gaqlnws+d4bfnzToOeshjUVj?=
 =?us-ascii?Q?b/pgc/DDcgmt0bW5HOU9xW5hw79zhqlcGJ5vRV8jP62mRIQdLBYyTAV7oKea?=
 =?us-ascii?Q?3g9ChHrkw30ZTSZufbNQNFdQSXyXyo0vVBKOODDE/tYCgOIV6W6b0XPp3gjY?=
 =?us-ascii?Q?vlR9+VRgwW14T0/HdW3XDzJ0gpxaUa/u6vVLJ/a9LhO9kbfABUz8lgRpK/1G?=
 =?us-ascii?Q?l+1m88w8WWi28D4Gw6lVTzP8niz/HtaxfLmelEc5zUwICgIn8gLmpF8LprRv?=
 =?us-ascii?Q?Ef/pnqateItr3Zop5hhwoeUKKToPRp3dZieN8Df9t/J/7dqMbdTnWx68oEzZ?=
 =?us-ascii?Q?ZEZokdkbaeU5bnrZcLqgnOzo7FjIzGPi59WO67evYTYrXYIzZtPENqQjBXG/?=
 =?us-ascii?Q?k2cWd34PtpNjvmCOt6Mt1z4D59Vh+zET+tVknbmszCFIiTvfKsETtuDtT+Cn?=
 =?us-ascii?Q?BFmX8bziJ4IoVJQmSuCwRzIPoteFlXsSwlxgQc+A?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b86900fa-8649-4cdf-b3d5-08dcabc95491
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 10:13:57.8086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zSwTn08SWorWB12NAmSekH8TkzwNwK0EK+G23tclhJLVMtyAKgMiS7UKhVWysmoVMLffBxAhDiX7KP37yZt2nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5232

BLKFINISHZONE may not defined in old blkzoned.h, and cause build error.

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 lib/libf2fs_zoned.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/libf2fs_zoned.c b/lib/libf2fs_zoned.c
index e55d098..221d7d1 100644
--- a/lib/libf2fs_zoned.c
+++ b/lib/libf2fs_zoned.c
@@ -27,6 +27,9 @@
 #include <libgen.h>
 
 #ifdef HAVE_LINUX_BLKZONED_H
+#ifndef BLKFINISHZONE
+#define BLKFINISHZONE   _IOW(0x12, 136, struct blk_zone_range)
+#endif
 
 int get_sysfs_path(struct device_info *dev, const char *attr,
 		   char *buf, size_t buflen)
-- 
2.25.1


