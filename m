Return-Path: <linux-kernel+bounces-296723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 456CC95AE3B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B4951C20EF8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6931494C1;
	Thu, 22 Aug 2024 06:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="JasvBrNu"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2048.outbound.protection.outlook.com [40.107.215.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19EF13C3DD
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724309745; cv=fail; b=e0rjk23SrYaacUm/cI6/lceS/lQSJfKbBT7/WMOPYLnEPzptCe5CdvSRIik2XaPhHfqkdUHVoG3T5VIqWfeaxff295mmtXQ7XPlkhzpOZvmMlnYy4TvAPanYQdCY9m895+Cwa2ga0oPVPhhtVAIjtvrIcF5qQMn9kzBYgWGL9Kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724309745; c=relaxed/simple;
	bh=h4Cl3b/c31t0v0WLutCjDxjfnnpeE40lYojRd4SGiRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fLIHDsDOouIVnYLGq8g8MpSVwUEjfGbYnodyuzVqR+SMuVE83Pgm66nON7hNvXmMqgCc1qgDb4rY2txdqGf+1kpJDsxFOPF7ldV9NHJB+HoOHETgeA2244V7CSc4NEOUAgq52po3anwCYjChoprADg4vtPhEZoirR/6AlScbaEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=JasvBrNu; arc=fail smtp.client-ip=40.107.215.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7gIj89v3nCTNRGG27yy+pPXEXJPfLHs83AkUy03xV6TQUK6kIHTZ5xisDYN6i1tFOseR8LtidcyeaXabqf/NEfT7Wc8N50aM72n2MzirkdeYdhhLGH2O8xf0CuCe6vmNBX/b49yH0XvRnrCKExyQhbO4IuVlo/JRk4q4QzZzOJvD22o/Zg1Nu5H3f0NnL8KzfD1iwhcf9Zr301nV93PUR7QMWRlGH3DCigUYZoUFU17//bJ0raHIJXUveXVIUFj5e+0trr16BhfsHbsprBpHrcHbTyfPcxeBPr1YcclcpoulPyeVC/rkMOlxtMTgw6BpIHHE/DjN8fb0/haYH5HBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Nf4qHOg4Wy94B4bQcsuL4rSf5VRXrwo3ygBKI6+/bM=;
 b=uj2lOL8H8hbqzAeVQTMkHYjzWx2CJ2FigqaDFON8x2lJqPCRAR7TNuCtq9eWCl4dqE8nGpP6v6Eq6eiKo01tXuisazCFtioBpwodC+5ya5PK7RATVFKyiDOiQEsCGkhJqy90cyKifXuBSRwBmcaUknId41ttUNwOn1W0m+SGqKWkIkeMkcDhwJKR+k80Jh0bs36ZupB62F1YVIcsp3VzuWhGjwg130osvkg97CafqXOV+AJSSt5XcVUXXOeQT6mchccPWlF68H9t+XfYWVlV3NKm2hB4YFU/PkSQ4aF6A9JxMK6wWDVO7wYurJ/OTxzjMJ6zzA1fmXT4Tk73deU67g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Nf4qHOg4Wy94B4bQcsuL4rSf5VRXrwo3ygBKI6+/bM=;
 b=JasvBrNujCQfzikjWZdB5Wqgla5ArJq7nHcQgjwhSp/QbsBnC8AVP/bWvh8mxQVlwa92weUgf52iFHs0CGZVwhXbbepkLuXgkYcb4gUyGOviPGejUsRQvVJqLG8wm2IommScJIzBPNdkYeLnXxsZ26bpcoxQe9dcfj0lW68njZ19WgJHriEZ03Ztt/+EPHkWCijRKH8rIUUr0tVjAN+1TjvuFcMvnjZ6mYGdtU9/pvF4cVO7lDi7rlGPjpYIPzU/ec3YkykMPpHWA0pLWKHCoNBCamq/DCDLA9td/zS9fHAQrtsWtGtYjj/hOicOHQQxeN2/FumKUAhRAz7R7Y9fRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by PUZPR06MB5982.apcprd06.prod.outlook.com (2603:1096:301:112::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 06:55:40 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%7]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 06:55:40 +0000
From: Yu Jiaoliang <yujiaoliang@vivo.com>
To: Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Hersen Wu <hersenxs.wu@amd.com>,
	Dillon Varone <dillon.varone@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v1 6/6] drm/amd/display: Use max/min macro
Date: Thu, 22 Aug 2024 14:54:47 +0800
Message-Id: <20240822065447.1333390-7-yujiaoliang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822065447.1333390-1-yujiaoliang@vivo.com>
References: <20240822065447.1333390-1-yujiaoliang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0094.apcprd02.prod.outlook.com
 (2603:1096:4:90::34) To TYZPR06MB4461.apcprd06.prod.outlook.com
 (2603:1096:400:82::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4461:EE_|PUZPR06MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: a7c67985-044c-4e37-ae20-08dcc2776f4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fCspicqFE98v7SiG5/8LnUFgTAB2uHp++FTT+fF8aCspzxwKbs+NtYW6WDWB?=
 =?us-ascii?Q?fOe1OeBl47/DWkoTfMIye3AJiELgXySwKuBL/cSPuU2eN/l5X1/ja1/14jYD?=
 =?us-ascii?Q?BszpFKbZgOJ49LMol5Os++DqLwEPR8CFWnjZ1yUXiafwDpLVHKPQkdvdVDv0?=
 =?us-ascii?Q?nDAHBZ4N2kkhgDyx0d6gWhaxNqfwqv7FWVj2VrINb+sP7PvT2wqPh2fuXFv9?=
 =?us-ascii?Q?YS6qk7sStv94vtU+YfDmcCuVQFUG8ref6zmc8ro/MYAZPf4t4/3/tlpDsA6D?=
 =?us-ascii?Q?/S6MMFg8IzbuqgFyhXYbMAFKXZD2uCZ+9gTgK+ss3GDHSHJ9fU2GE3RKiB7+?=
 =?us-ascii?Q?u41mZHAPsJi+AfH+gccw5bPNbEr5w5lI5MwZcMwcGK46/KxwG/glwEeW1Tv/?=
 =?us-ascii?Q?RPMcsj4/qXfKEfE9nK5wlwzZEQk+thBrvQ+T3aEC11q9YcJ8q+1ZjRvrbWz1?=
 =?us-ascii?Q?pQe2TXJGikafGR/SyW4U5ftkHTwsIDrl8J/GF9xRECcKKjF8R4IL0tV3depI?=
 =?us-ascii?Q?t6X/Jq/4SlNCdDLStWPw2xmY7guFvYbNQiRzT6SuTgCCdetPGb6UrAFbudGx?=
 =?us-ascii?Q?KvBl9+eafdYSDGALCXWw8P0yYLIUAyoewhKZgXCqGq8vx5Cj//tQwKktqiN5?=
 =?us-ascii?Q?80vYTZPVbP7rSaoPNZC3EQDCjhf7566zTZ3sK+bn/bzx8V2864IomqhqCJwK?=
 =?us-ascii?Q?9M+K+27ZkcWDVqghvhw0B1+O3sh+jyiE20mlKr1F5zf8frjXWpn4vvfucf5m?=
 =?us-ascii?Q?jBr9QSVuLgoCI5TGtLTz39TPbA+mIRfr6gKl7rbEw7mrBIA97HPj+nIqNVZg?=
 =?us-ascii?Q?4mnuS1mVplSZvgi2Jga6lqw9nL5XS1l61NStSflXPnSl41WhHYcMJ+tTnv6F?=
 =?us-ascii?Q?6/B7mXvovZrM0MKXZpvPPqbRA2BGm2lwHk0orh/MTczm0pvMGLJUFTBTloWA?=
 =?us-ascii?Q?NlK3sE0Y8SmhGT5RMyi8W8/Om45z9kDzMx0r+GG72WTIur0xwsFPhJ8/OngY?=
 =?us-ascii?Q?spzDeOELw9y8WZWY1mxUhhsCOlyKSYH82sXIyd2R7B3LhYWeSvGm+aORzqgP?=
 =?us-ascii?Q?sWt2MdO1i0FeINh28jYxB0VOnf90a269vB09Fq66C/6FzMaKXHDa49U2dyNJ?=
 =?us-ascii?Q?HuNgr++ew4ewTkCcY8E5lM8rrdBdNwBAkri88uma5VR35dM0QncCNUqZKHis?=
 =?us-ascii?Q?RhkYQx5D0EtfPHWRXy2sPwEOHBNZt3Pvii8yVyTKlXZjB+T0al2OLiwVSIQO?=
 =?us-ascii?Q?MgQaOaHEMOp/0nAsA2xsS5FTasHlhCGWWAMgtCzAeecSPKxBE92DvBye+/v9?=
 =?us-ascii?Q?MMzIHPR782xAcYMniFnbLA/XNqCyCqsB5ckclbr9Nz6ngnxLgor4oWGDSlq5?=
 =?us-ascii?Q?UKnt40Phcjg4z97lHCXi/OjW5Z0l97Bl05O9EPNQJTRc+3VGWKcUeuTC1fuo?=
 =?us-ascii?Q?+hyiFR1msUs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XxJ2zNTx4sY0r1pnpXh/3cD3IiNcYwsUH1zHOeiKTS/2iyupV6yiG+fuslCP?=
 =?us-ascii?Q?McKjm29J/8r6KxkunAwpY9JvwwUXVBvKJz++yw3R60a5GRofMwQtaM6RCZQZ?=
 =?us-ascii?Q?vKK94s7HFQRcpedf7zE5c52UCNUGev1ZY89yA0n9+aJ+/ikC5G5dUQEMFomt?=
 =?us-ascii?Q?m+zttaDggoNw6CgW9cG36RjUxN8S5vLyeEhakEW4VpLNH1HIL25hucudx3ZM?=
 =?us-ascii?Q?aInR9lsFY9B7bjIXdnYzvgPb0/Qo3Kc7pWXzEJrYhSPM3tt6kOo37GSkDez9?=
 =?us-ascii?Q?VB7OtC/zqTdPxZtLSC3OUdDcsK/aVuN+LaXG75DpVOxd23OsLP+DlSYpFvPU?=
 =?us-ascii?Q?MvvM/XJafviFIwbMp29ylnu+wHODcH/WvrgkCZlyk31deMnbJJdjaTXHoXZc?=
 =?us-ascii?Q?2D+8wDeXHYahHw9MbJHfC08m/I6haMJ+cfOiJCZjh5VPnY8iyg8UqDCw2jxn?=
 =?us-ascii?Q?ymDDDJBXeie4v7s+AgcxqU+0+WU+gb0gX3ohCjbZHY7b+nTyCFMyoRXFQEmG?=
 =?us-ascii?Q?ZUzn9GyElq0TC23BRfFHt4cqgxTUGVNvukVvJfJbkeOp/Xv/hxOom/Bc9OWN?=
 =?us-ascii?Q?k4oIXt3diMjDj6QUAxK+BhT6KLDc+tX8343ZbwFoWMr49rnnT5zKmU34qXxj?=
 =?us-ascii?Q?MbJcdi+yOkrjdVWjIiTdd1l1likTGWqm+lDmMHJiYyfodeZ8cKkk7BCKe0Ct?=
 =?us-ascii?Q?C3HFrd6eDwSBIw7IMgvwtciZVEMQ5vx/RNtLEViD6PEkQ/16vwNrD9Qe6d8O?=
 =?us-ascii?Q?NiQXYz5f/5qJuIQFRvWtj7lAT5MQF3rhAZ8U6hkvSJc+ietVE495VP+rqe2i?=
 =?us-ascii?Q?6opCA9PstTwxOSSq9OC+hwEsdvNYw6LoHzVqP3QM9jvWSdSuhsmFt2wHxTlQ?=
 =?us-ascii?Q?HMjNwXqXvmdUO8c61f1jDKwlZKTAtjx+VpKtJTiHs7+/xRDo9QMg1Ua5fIMW?=
 =?us-ascii?Q?1AUv7+FA2/MLN/JUxdHdHMxYgju6zv7nM/iK9Z54UKqPJhJRHW0fticS8A+x?=
 =?us-ascii?Q?5zr21MxyuL9YfNtOQ8m8QesyTiL8K3nekLMUmzhPYVRlkXV3S4WF1WW+XLIu?=
 =?us-ascii?Q?y3bEg28f9yyxGN39oCrE9cQTh1i5xPfTRTaG4gFnAojIpv793bn8PXhAQCww?=
 =?us-ascii?Q?u4t9TPdT2KlGfCk+i9KLJvYmN2EKgYx/K3hsULPoMVicmI/GXylRWUqX2ijR?=
 =?us-ascii?Q?j1IpKVu2+0QUGjrov6ahDaxJFJNTDXrlyEpwdEvzCfWYK31605EvKFAA6Rli?=
 =?us-ascii?Q?lDilggiNvOEiHtOtBmUWl2a3xb8OPRBJ17rpZTR8CqWxyycfxPKmAVjmDpUI?=
 =?us-ascii?Q?ntfEBDRI77yKpQX0H6zZYMq1Icj8ot3UEJCp/j6L9h2fbbYOe0KENg2VK+Vu?=
 =?us-ascii?Q?bs+wZbyeAjOfqmuX9KXVRprTIFoFcOd6y5yvYEjGq6gpIb1AMPlWdAkSwG+/?=
 =?us-ascii?Q?cGgvqVDFyibscmI7HumBy5LKAUqkGCo3oGs6NyupVezXGH9LCW0ZJRwEw+Gy?=
 =?us-ascii?Q?LczmUiJi+RuqYw67LKQF/DAMgREQQhxyP5NJbObabmHNicKFc9tvgs5tTLaU?=
 =?us-ascii?Q?nMsYAPrYprE30VHEfxa5pV5PekdH32Co0q5w5sBS?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c67985-044c-4e37-ae20-08dcc2776f4c
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 06:55:40.5575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GOIG5xK1HgVGLv9kfRg8mLHmPk1MDbWWHYdEhPWS3rsCiTiTCXvIK0lX//T+Hz43wJOo0xUHORc7slqZTh6zVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5982

Use the macro instead of ternary operator.

Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
---
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index a40e6590215a..33b9b87d8d3a 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -1005,8 +1005,8 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 			(stream->timing.h_total * (long long)stream->ctx->dc->caps.max_v_total));
 	}
 	/* Limit minimum refresh rate to what can be supported by hardware */
-	min_refresh_in_uhz = min_hardware_refresh_in_uhz > in_config->min_refresh_in_uhz ?
-		min_hardware_refresh_in_uhz : in_config->min_refresh_in_uhz;
+	min_refresh_in_uhz =
+		max(min_hardware_refresh_in_uhz, in_config->min_refresh_in_uhz);
 	max_refresh_in_uhz = in_config->max_refresh_in_uhz;
 
 	/* Full range may be larger than current video timing, so cap at nominal */
-- 
2.34.1


