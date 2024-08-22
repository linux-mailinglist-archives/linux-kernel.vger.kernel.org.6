Return-Path: <linux-kernel+bounces-296708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FB995AE13
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C57DB20D84
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7874148841;
	Thu, 22 Aug 2024 06:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="APtMyeGW"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2052.outbound.protection.outlook.com [40.107.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2889914D449
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724309552; cv=fail; b=nz01pDjpA3unuT3JESOfgxudJ1FJK2JaH222zE5Yqw1ahuDb8Q7kabs4lNw7aHxEM4yV54WHwmLSfrw41xz3/8YxOktTYKwhzu6oO2cEyrXE0wv/J9ZvzcR2CatChayfohLu4iswtiU6bvBNYNS6eFlFtqLF9nj2ZjOO0Tapd28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724309552; c=relaxed/simple;
	bh=mOTuuGp9NHdZaTyR+VhF9fYrPddCTPd2FRfu8AvMd94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AjyVHy6TM9Lc3kAeyHQetmxvs8/1ZQ8i6BzXoBG7tXJWKTacON9NcE0oVIGYQFIfrbnsYkuXCVe15nBeKjZ36uYC4D8hDODjaWFmwA0AXnVQgVD1EJov0yjbkGa7I5Ib5BBd+bAuJJ7JjuMWjZg1jD6erQNlFeRhUXVtBlDEx2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=APtMyeGW; arc=fail smtp.client-ip=40.107.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uzdqQKlfwWcEVMMamRjvwkSI8mYSUQLVfwneDtN0lq4uovNC+b528CLDWUHLnU0uS7wm7qCAEb4oFWBat4EpcEUwdrPbugiaJmP4i6bHfBhycICCNzKX9ZCbttomLy4G/K4qH8Sl0B2Js96xMwuA0DX8E2NeOj32Sjc7b04R5ukT1hzD9tSjbR36vpP3S/ngLkOYe/ZToFFIMtK9dGcuhjlqvl/QI6mR+Lv8MCOnmrEz48cLGCkkHEuYIuSgphclvQZIlNKlaN7cs/FRexw7QCiVoi7Fy+gRF00bSbmbcGwyKOSAMdI6Dv/rJPDOSuAxhngg9Tg6RiuXI1421wi6NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTsu0wrvbdIEE6vA3MQgBXlaN79AI4+N6lS1tqsz9ss=;
 b=K02PkUAzO4Furq/KRdhczOIYaOFlWXZdvYRzyMnIBFZAJ2OZzPWPqd7LVqjjE8JpnJRkNOhWp1m0+PStWkWYICtuoHCb0Mi1IMUM7cMiF1xQ0bjzKMqlg8SLsFyG3pw6ktMDK0gPT2ucY7TAUpaEAo0JYUCMKQERJktekafuONTJv3euYaxTANLjVSlNosjGSVaBAYsxfNbKHJW1mZUFe/2wPg57RKjRA3IlRGtHJNGZA+6TPSJp2NLOe5qaQcIAXQC8iPAAhdiszUXN57hPO1FN0f9Bm6u//x167cBPi54OLi0m4ivViXR8FLukAvuelmZ3XGtjBuLmLoHMBfFtfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTsu0wrvbdIEE6vA3MQgBXlaN79AI4+N6lS1tqsz9ss=;
 b=APtMyeGW9tU5w9ssP8Et7v8W86VlcCS3egToafnyVS9CfLwR64pJB/3h199+6CfOwrXhru9s0QXML02x83dXBmEv7e12K7/7f6n2OOGAtryU6LB4zexCtwVOoGwIHXYXdiViw75t1jIAmkLZj6IHSasmKopheRCjRBoyCzWKoQjnC91X/leogxy34hhh1WK31pEoQ+YJlSJb6ajVMl2OCz/enRlcLMMPqjiupyk99nOYAqzjcRE7nBtq7le1CpNwfAQ3EupH4TPJXSHRHivtOOJAGa//zruXSwgMIWq0GwMpCmZGUUFx8vBJF9hqKTP5Jsw/HgVS0EXYWeeNTizinw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by TYZPR06MB5417.apcprd06.prod.outlook.com (2603:1096:400:203::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 06:52:28 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%7]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 06:52:28 +0000
From: Yu Jiaoliang <yujiaoliang@vivo.com>
To: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
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
Subject: [PATCH v1 4/6] drm/amd/display: Use max/min macro
Date: Thu, 22 Aug 2024 14:51:35 +0800
Message-Id: <20240822065137.1331172-5-yujiaoliang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822065137.1331172-1-yujiaoliang@vivo.com>
References: <20240822065137.1331172-1-yujiaoliang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0168.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::24) To TYZPR06MB4461.apcprd06.prod.outlook.com
 (2603:1096:400:82::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4461:EE_|TYZPR06MB5417:EE_
X-MS-Office365-Filtering-Correlation-Id: 450057af-35c7-4df2-5d82-08dcc276fcec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BhwJ0OsPx7iziY1Nz68T3vkHmUys4l2Qp1Ye2LqtH5Z8OUvslMIXEb2SfkpB?=
 =?us-ascii?Q?K4z/35FMeiuvbCW+4S1YK2AV9MfMbn/JgUKfJofbXUeiny0mvr8kzZnxsNym?=
 =?us-ascii?Q?hq/rput+1akydxOZsJYhogTgYKiWLHBMUGX2W7WEhU9GgJte4FEqKA6Au/NR?=
 =?us-ascii?Q?YHt9dlp9fz/9rrVX3IZxEoD+R6orS3zLNdyfiYlNp/rx0ME4JRlR0Rn3lffd?=
 =?us-ascii?Q?xO9Luqtq6d89hDX0a+SIOp5Vy3iBkKsX3Yi48U/NIfQtKuvNNCSFikcNbAHJ?=
 =?us-ascii?Q?U+Kzt9b8xj+8CeEL54hNlgmfVtXEVKJngShbUfaLvGw8tPinJ1eDhhq73Grb?=
 =?us-ascii?Q?cbGZvwdB3mNzzbgaghpmmHouhTMv6vm5cWjElce8zDltcgR71Zhbum2ZdA++?=
 =?us-ascii?Q?tFfDOywvI/EXcE37G0zX9mg4N0eg1FaIRJcQ8260Q9ZQk/DnvazWT9n8qvIc?=
 =?us-ascii?Q?jIcsROOVvtbMbIGO/RWKAhvyjwoVgJQhTEqNHW7S/7M0f6p3aYW0kWAnesUx?=
 =?us-ascii?Q?XH+6HwLv1BUb0mqvEvV86mZUanlsmN4x6We9xs+iQmEXCIzqSrT1HScZ7J33?=
 =?us-ascii?Q?JyFFDHcJhQaxN7VQv3KlVEIQi49p8FW4VIft/Fy5xj0ALa4cVAVYeh4FFX3a?=
 =?us-ascii?Q?2xKg33DM458b/EeKtHB3dYQvpH9SYL6ShaZTKYsWliCVyMAXKlb6PETcgPkT?=
 =?us-ascii?Q?OOQ+P+UrD9upONyFalx2C4ZOC9j7LrmrElQu41MjIMeyqMnwuE0WLb1jEWs9?=
 =?us-ascii?Q?4fIeAxVOQr2PkMl6XEn2Gob/b3GWq73n/9vYUhPbAPdZYKYivvJIQxZGAYXe?=
 =?us-ascii?Q?kvbunuOszo2dWL+p6AZg/Kw08TgzlgRLkQWRMWOwgpQimnv7HavcJme1rxx0?=
 =?us-ascii?Q?uF7VTJCnRVXpWv3xGJZ4uUPQ16JB6ou0c2iWnvdjuVVPhMoFs4n5jgTsx0Cp?=
 =?us-ascii?Q?MsXvs1rpJxjYrHqopBP7eKe7PdHxgMGT1Wc8sFaC+71o9n87eSsG7zp6WZsd?=
 =?us-ascii?Q?fnbOW5Io/n4jfp1/FnrxBv6TVHmnjWoDXUB3sxIWfcQEmX4GVAYNBBAJujN6?=
 =?us-ascii?Q?L1L7vFGvDItPuTQ6MlUe9vg4NhFpcr7TAIwSGZy9huUgVf1GSHYrDKlsfK5Z?=
 =?us-ascii?Q?ZVP6Td7bW2oCSGtmQgGztKHzskH7s1UhzF/i0LmhvCS7WQ3qKFUyGVSojLVy?=
 =?us-ascii?Q?wBgAyiVoZ52MGMP4WIcfHt4Em+DN54kRQAFluUhV9mMEtbzfXAfpt5B2xmf5?=
 =?us-ascii?Q?NWf2hyD8ICwaP/2/oQOFnY0XIXDcjj6YmNhnZ9ZKmouAhlEf26BkfHuZ1n6Y?=
 =?us-ascii?Q?RV16R0xVaOPO4/UfEoDrdkdyDPRZ7iOOxivycuRGZENr+96vEBaiiTkivRKr?=
 =?us-ascii?Q?A13KMEIkB7gImUt/QdP0tuBnjbQAW3Gm8XoJwyhJ8Hnd6n0E/pdBA5DM7ls2?=
 =?us-ascii?Q?Yj+ShVUQn0A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eEn0jwfOhQMRNuqhG1fQFAwl4eVkuJSD8y3WwnkETjFvPp5MOynwMBH12Ns1?=
 =?us-ascii?Q?cHQLHjZs0G6Df/t3mO29DVw3FhxZR/JvgZS7eEAAdmHoPQuFjQPGhEpQH5dh?=
 =?us-ascii?Q?ku1/GyBETbeCx2aA1rqsNn8F4Mi98mt/3uhPRW2CWQmcIhEsGYvJGmXdd05g?=
 =?us-ascii?Q?sdk74vWFfJnfJvcFE8SGSlj3yP81flVbmQnz82Cbnu1Gm8zFKue+KshdDfNt?=
 =?us-ascii?Q?SDyXXUc6Dz6p8qFMEzg/5OeIi3crJA83rHo2Z+zEV28Qui6eXQRK6g14U7Im?=
 =?us-ascii?Q?YuVZ+GH/UFUIhEXQOJgZcFpeRYp9YlUFCnr54vH48tfgY5jUnrATrncE2Btc?=
 =?us-ascii?Q?8+QBUR9dnLQBQKERVHpu5zbIZAj+Qn0c+KKnAe6jpXqHLE9KZRB+dZIlCORU?=
 =?us-ascii?Q?ySivzZuFKIRFuT6Z+zQe7p7G1EAg2lSIAAW1CFLmG+z/WPgW5hIeR4kEBFX8?=
 =?us-ascii?Q?LYhDb4r8V7UB3BraylMit3DKBo+8PbT0vXCzzsCS+T1dFieF2Kea/m9s5upw?=
 =?us-ascii?Q?k4RYCRWZ8k6ENy8clYYAhG+GmhgELuTYuLcmeo3XiUsJct/TSPsfjJrfPaeS?=
 =?us-ascii?Q?MITfIoaoYXLj3nCyLnKtRkqGl2kW29I1PATjJh9j6fYhJYCjAbYcNEIxdxXO?=
 =?us-ascii?Q?ewfPUKXgbudOL055+OEQfmZ9Lt+ittlC6/ocn4J5Sba9GaXTWJgQWCqqIOuW?=
 =?us-ascii?Q?xQZ90iw1BmEMplJPb9CrDSnUWa+J7gVgv/LrAemjxnTGxZckgvOYp3aTERhU?=
 =?us-ascii?Q?bjGv3FTiGEdZbVwkmGBN6F9935GzRuIZe709lXVCsD99zWRZCQYDwWy9WhF/?=
 =?us-ascii?Q?u1xauTDHov4LcWgswygXDL4iYOCMU+HM0UJvFYLlHpwi2NwdLLvAefsEk8L6?=
 =?us-ascii?Q?CDLN74Bbcz2dZF4DVa4z3J8VFWHbPabPDRIAH/Ppch2I6gPzQTwbGBxx8C7i?=
 =?us-ascii?Q?DuUGBnsjZHbmYFYnaw8Q/2BEllECdf5lSmipAGN0+e7FgZz2sxRTbD2VE+6N?=
 =?us-ascii?Q?DQgkNVm/JHr3iA7t4QytxyVhR/Yfhu+cQOazVrAtQQ/dnzIT9YNVsivth/cu?=
 =?us-ascii?Q?PKhkQ6M9pcyDkIhl8wzjSDFxWYGP5Otueg5RGsa7IunazEXhElxYQgIiNhL9?=
 =?us-ascii?Q?nqNrNmRHwQB20QUFAyhy0XxI+5+IjgfKxlQ5FmF/OPjl7SrSeZrXeckFJTAv?=
 =?us-ascii?Q?/qQX3MrPAAcPKZ4Go3guXAEXe6Gop52a2eh75sv+KjwK/kt3gqsAW7pRkToG?=
 =?us-ascii?Q?+IBJTdZf3vfcBgeqM8wDXNa8/SbhVpZhERZjl7RwsdkXpPB6UVWAxbapDc1Q?=
 =?us-ascii?Q?r0WMo26aLqauXMmnCI1nbT7JTZ0uOwFdpd9Oe0J310Oo6Y1kJd2itS7wR8BK?=
 =?us-ascii?Q?3HhJVqLv6/3RWW8rKMBQcnrWaU5HxLDotXF2S5tcAwuOP6zdFytNzUL/B9+P?=
 =?us-ascii?Q?mSN/JzP8RuHYCemF+gX5OSyVL9e4qv3NpHk9gNByYRvmJDwTi4fK1wxmKqdV?=
 =?us-ascii?Q?EWz3OwlIyDh2W1IfU3bKByEs3Dvdig5Uwsy60rRHerXzbtSzQm5eg+FuLGBm?=
 =?us-ascii?Q?IH0iNTf0xqWhTWXhwrPQMuxYSNYBCe1MNvr/V0sD?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450057af-35c7-4df2-5d82-08dcc276fcec
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 06:52:28.6874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5H5yi9rqX2SQyaHd8mh5ofYpRbQhDwdUF7akr/zTeUbExWlh8PCrWclSytELmt9a2JIoTAzyWOI+lHHFo1ZGnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5417

Use the macro instead of ternary operator.

Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index b1265124608b..f48f8cf1e232 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -606,7 +606,7 @@ static void populate_subvp_cmd_drr_info(struct dc *dc,
 	max_drr_vblank_us = div64_u64((subvp_active_us - prefetch_us -
 			dc->caps.subvp_fw_processing_delay_us - drr_active_us), 2) + drr_active_us;
 	max_drr_mallregion_us = subvp_active_us - prefetch_us - mall_region_us - dc->caps.subvp_fw_processing_delay_us;
-	max_drr_supported_us = max_drr_vblank_us > max_drr_mallregion_us ? max_drr_vblank_us : max_drr_mallregion_us;
+	max_drr_supported_us = max(max_drr_vblank_us, max_drr_mallregion_us);
 	max_vtotal_supported = div64_u64(((uint64_t)drr_timing->pix_clk_100hz * 100 * max_drr_supported_us),
 			(((uint64_t)drr_timing->h_total * 1000000)));
 
-- 
2.34.1


