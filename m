Return-Path: <linux-kernel+bounces-296730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4480C95AE4D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2C81F219A7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CBD1607AA;
	Thu, 22 Aug 2024 06:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="FndzF8gg"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2050.outbound.protection.outlook.com [40.107.215.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE5015CD78
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724309888; cv=fail; b=VDuBubZbJIqc1g+OKGKmF1jU2kg9J1LBWjlxubHvMAaxASOHF21Dmph+peo7ngHG6hvRkYIR8paOEJ6lZxWgkC6cnHpkcV22kn7+hu3ND9h6JbKlVZt0Y4MBHzoeabCtmoSGKTNOYIRyTwwuGxq32CYXmN3H5piI+8h0R8/xNyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724309888; c=relaxed/simple;
	bh=+KhRbbpPLcKSWJ6HAX/NWIVQexesDXnBFIqq8ymjUK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZQgHjPSm9DhpMMbXotoHOisC35MLqspwEW8tAZ3qQkxsd24MVljgcHUXFzNe+OCny4KLJ0/LsrOoHmFfVFRr8BZLKQ/Bz7zZ9NdPPydAs/NxRGvCuPYj5anNATFMTUIKcfY8RsEtHVNxJwhQYcQ6S7pse4lmbDf6ldHWGpXC72Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=FndzF8gg; arc=fail smtp.client-ip=40.107.215.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOsh81T83NAHfPE0/Hx4IT3K/lvj66SemP8Sf0xllAWDkXqszeHNxA23JJL2FaXQNjO0YZ3QfcuBgxOy2H4TJfWpLMF6br4DoJAGgVE1DDsBpzX+9GW6q2vpbZWyYd1VQVPDdpYD8KE2ES/7ChqezDzryHFvVj7Ka5SPiBGhX9NTHhbHhHLn59qIAwxvtEMRAo6sDY/cReQsKoDCFz66t3aMFodBjqM+R4KbuqrO+b2QjxGRjobGZHOJHjjDkeAVnfg16n6k/U6dgkafEUuHoCTFSkQ+N68BRUzCYcsIcUTG5iMTgv0A7WzPQBY5U67ixhp3L1zm2wZMkww/INcn5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDzZO710rFLkj1elfDytM9c007FIqcUXwciJ5i4GCmw=;
 b=HfSZJW4hAQoDPqEbR7TTxSUsgul6z/H2NYNgOVReGDuwMudS0acIC7g3YQsln8eiCysqkFySlu9Qxi4AwXtu3jdZWUxvx61FfsMsNlFJYjf35yjgOgZqnZ6cP2pZswGJYU4E7sx2BquJ/ZScGnJxPUvo8Wh/3riwl2Ctm4Nj0vBcDSYrEtz5OmQtJHcIM1KIfLKOpOMNdvVQu80WB1b566XwENsHsOJOnCh+tKeMpXHT2QnMQNHPAaMlvLseNKShOLOpS6EDoAUDcRHBVvLPVfxbT3VerAFhcKzsql6tzKyHOqXbjHrYa5HS846dQ5id8P4rYq+daIaPEv33k1vbyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDzZO710rFLkj1elfDytM9c007FIqcUXwciJ5i4GCmw=;
 b=FndzF8gg3Hxhe+7knGAVeWWe250+xSztjhCUQbYElaEn2ilO/ZBNtDXayltjueb5U7dHVI9Pl2+nN1xHZf3cgUAIOoEjRC2hn4hAVJwnA/xi5DjSB03MDpiiwjbW7Irio25G//U5DqyzCw1lfJ37MjTjC0Oj9CKXrCLAB5AiIwD32n/1zzWGrHXOMhFdNqMZhFit3+aAH7HxEEaMMbK06KvsvUsMCNMnSoGs1zz5XR2hfMajc+T2JQU+dV9S21R1ih0jc9jcTFrK/Aar0AWqZgMmKlMSWclsXxvxlbLzj5eWDmRQZ7I+qucSWKyf/q4+M4JuuewOM2Z+QjRCkw7B/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by PUZPR06MB5982.apcprd06.prod.outlook.com (2603:1096:301:112::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 06:58:03 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%7]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 06:58:03 +0000
From: Yu Jiaoliang <yujiaoliang@vivo.com>
To: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Dillon Varone <dillon.varone@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v1 2/6] drm/amd/display: Use max/min macro
Date: Thu, 22 Aug 2024 14:57:19 +0800
Message-Id: <20240822065723.1336181-3-yujiaoliang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822065723.1336181-1-yujiaoliang@vivo.com>
References: <20240822065723.1336181-1-yujiaoliang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To TYZPR06MB4461.apcprd06.prod.outlook.com
 (2603:1096:400:82::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4461:EE_|PUZPR06MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: 008e3275-4452-4c86-60e9-08dcc277c436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R/b0Pe+ES63IhXplpner79lhqJQ0+1B/KUUTGmMWxtcCpa3k7140ZL4wIn8f?=
 =?us-ascii?Q?PGRm+sVE//u4BqHHvVrDLl8mEpLvERLAQF/2KCJr14plzARbtzHwKINxNKAL?=
 =?us-ascii?Q?XC20fvZJZU0+FFp4HS0YKJO/7mF0jRzCVuEHYJWqsLOzTwJ/hy/+jd+UvthQ?=
 =?us-ascii?Q?lSypSokvnnf/DGpSK/mvsmtCYYteJfGNMBlqqz5e5GAOxHN7Z1Zi7ntXDrBk?=
 =?us-ascii?Q?VzB9GtZyBJhLqtFlFeGNphnebu7/Vm4R/l/JW4FbZ4mkPa3lWL9R/xW1Fxg0?=
 =?us-ascii?Q?FKwliNBmtKAzHqvKgK4ioDE/nQL/2Igx4A/VKPI3OvfknRIftm9+mLD/lgeM?=
 =?us-ascii?Q?PoTRhDlIuHzgOtaXO4HLrahM4Fajr9+ouMjJsL7K97ZieAHbQAjF238NwElg?=
 =?us-ascii?Q?sAIiBBt7J+THXMmMQEw95wBcg/hpkHkAMINvONK+cYM5SbuLu1Qmjb0Fp4g2?=
 =?us-ascii?Q?GRsWldvw1pcrVZb8HZaxGOfBZHk5xwbUQ50ArrbIaZFtnJG6MmStGHLqDgnR?=
 =?us-ascii?Q?uSfovNcmCc0vgpO5OqPySW7vgenx0HPSEo2e2Hd1cAP2g0QHrYS0lw4yqvDs?=
 =?us-ascii?Q?ZDmZf6No8pAN0+fozKl3YL0CHR5YeXF/VVEvmkaI/LoLv3fCODxLRSHW0dug?=
 =?us-ascii?Q?KKTFhs2EVxdtklE4e18lU+afZF75+oatjlcWwQbAnwNffFXvnU8H9DN7mV5x?=
 =?us-ascii?Q?mrJ5/6WqfnshW7GqkAefH6AHVUtm3IE2S8NFlF7/e2m7TqTexEqW0hbH0TAN?=
 =?us-ascii?Q?iaEs+ae82il2TKRvEjkh2oz4AGQwfUW7oXTtd0QVIpXPDnVHKYdu/n43FpxF?=
 =?us-ascii?Q?9wGUrz4hspuMSTYwH7SuchnIZQz2pMtmsj07I1h5dTnjqZxhkUBMOorg2DQo?=
 =?us-ascii?Q?BmHykEuSQwmc/WxFs8lYEuXrA8E1pTrp3vb8jNA3jfMsRppqVK2KwHrcDxmq?=
 =?us-ascii?Q?WkHahaUNcZ/wqgLl+lTQ83pvoUurChDX6HxmpJ4ulRFfuKtKTdjBMssOmem8?=
 =?us-ascii?Q?wEORcZQ5WBBvaWn00Tw+0I+RTP6Y5EZSlGXT0vBvE6QHq7IHO48LDxcZu71D?=
 =?us-ascii?Q?OdmT1MZDAe0zwTq0CJsT3UwZuEwYHEjeEBVYxUuyi+afNWql2nHjpLjI6WYt?=
 =?us-ascii?Q?b14CyAySptCX+e32VsHhSMkvEM3923O3R0kLs6Z4xR+CXNTOz/c7hhA0YxQU?=
 =?us-ascii?Q?yNpPIR3bIZo/CRq9PGW4bVBkaSyhSy7XdOMmewlN2hXXlLJc1cDO3oUYEya4?=
 =?us-ascii?Q?gp9rGATIim64/sd3N5uEkTFXk6zsCV3yX46ZoSP+dD/+cNSJvhk/OE0nTLBX?=
 =?us-ascii?Q?OHgcaiLEEiSOJqVeoJT6IczY5PAIpgKtBuiSKEK+I7X/O66ZBF55G1yPDOHM?=
 =?us-ascii?Q?6suspO9fX4aDX2h0QUCVt4bwHWjcFsRNm/g0j3sg8M957vA2NWJUVHuPSVE9?=
 =?us-ascii?Q?2MkBFv48Bjo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s3Plp0pPgCziqL2v1Fq53wUIb0JAsvX6B76VPL179xJyt859eSTh5P+MLQAT?=
 =?us-ascii?Q?Hgn2QGwKEOrb953E2r5s2yVOtq/PFxJ8tyE8y4HRFR/LKZBeb0t1njEHjc97?=
 =?us-ascii?Q?6fbBYMXJE5F/IXGQEm34fVXneXU1gQLq0XTBioLIYA6YjauGo8sKorh7urRe?=
 =?us-ascii?Q?B/htSa/A00mHQU8Tc3kpzHWGv7GjqIPgR/MWK7EmepMPLLF+H7NPE3vsex3f?=
 =?us-ascii?Q?06fyX+irf7N9daDMVdosxWm9R1148PSGo8rGx61aCyoZZfTHcMaEf3/8PBB5?=
 =?us-ascii?Q?ZVVqpQXdlDvnZo4Rxj6M9ZDXMFIXVhEHDtDc68U3QJl7C5xkf1xEwsxD+CIv?=
 =?us-ascii?Q?tWflKeVjHaN7vp5ST7FuLPpbYDbGg0W4MOFo78WhrERaf+7rLmtlTSFu7NY8?=
 =?us-ascii?Q?VhWtra/LuiPTvENG2Vp6rpQNiP9KkafTIAOhb/pRJNa3UUeSXtM0qL4dmWRQ?=
 =?us-ascii?Q?uPKgW3UYb2qDctLGKUDGqAc4OKCgvYmwSf9RYjYngQG6jL4XfM/FWVGhY/G0?=
 =?us-ascii?Q?w8/htTRzWq8UNSH92E65CGuWhTPIgPbk6snKjr8D74yMVmPpRMxFLpZ2Lder?=
 =?us-ascii?Q?Vbuzz7OgWTTkbhCSt8H4CxKfEDVkMbVBvggADYBAnf1qyZhTSFOjvwAk0d0A?=
 =?us-ascii?Q?ybNJoIddtqR9zhMnwaGaBiyM6vQS8/o74MVvM8q8J/ARddSKD0TgEWpQU4Tf?=
 =?us-ascii?Q?QYxQwdKEk/rRR8dulLDVBiu6/doRej5ZTn11GuX1H7Ymu7T5ybNhRmL1q9FN?=
 =?us-ascii?Q?sT4onhEwtQQz/S3Rid3akXGtvUk9iugk5LRtsLiVZylROfdONsRB3SZg9Uop?=
 =?us-ascii?Q?21g/2b1L8DbXjU0nPKxeblglr5PYymJDsfr4DfYC3vgPXL+LCsf2qkx/SIrX?=
 =?us-ascii?Q?VMPtsqfDIlIj+fI8MBxgm+FjKm42oq6x0d+/9U2n9pmpnz+2Z2FoYIUIarzU?=
 =?us-ascii?Q?AcSkam3x32rFs/YVyTAq4RNQeC9Kd4+xF+yKDXDaCIzbnBX7vvEqo8iysn1q?=
 =?us-ascii?Q?lCYxh8hijz2ZO7nz3S1/ysEQs/7k+t0yGzahYQN0Js3Y9seALw8g88RBsjK1?=
 =?us-ascii?Q?KFQ5N3sKbqeVnGxqFnqI6PUUEBqDoqNe5XGCRKZwmFs/oxTSgKNy+mWkV/oC?=
 =?us-ascii?Q?sGDhPgvfnt6W6HZnrPoyrCRlPTlXc3/ux5Ylv86UtKF54RCrh3nykyLbK1qe?=
 =?us-ascii?Q?+65KpH2wCDx5mWE6+GfawjEhVSO+r9O3WNX3v9UejbAjS5CzebGyYsWr5MQG?=
 =?us-ascii?Q?ZRvEtocH0cDyT+YkVJMJJo4VdNaNOPNGrSm4uA9gSEOB2eFDT4pi7C1+QIic?=
 =?us-ascii?Q?p/LySA37+0/AtBcpNcvGQ8b8X5rD0wALE0RjjkNriHwKaHGaMqJeT/X1adum?=
 =?us-ascii?Q?hxNDP1PAXrdX8lURBTCG7vmG/CVw34k4R+ivALP6V0Muybx1m1SoxZ46HezP?=
 =?us-ascii?Q?qwIDMJKk5w7B9nlrFsGFIHf1S+R8LynwExhN0pLFC4sVfTyzl5kN4aAwazNj?=
 =?us-ascii?Q?rI7b41Ktrp7dlogyrEiM1Cf1EZS7lIp6VOWRhW0CB6x9DOpYcigC2doGswcI?=
 =?us-ascii?Q?PheFPeGm2/l2dlUggRyKFQmuPO3vgYSfXlVF6kPM?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 008e3275-4452-4c86-60e9-08dcc277c436
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 06:58:03.0240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rZbTjc5tG/f8I6Ue7f4UIUwCb1NJfixVckB+f6BCcGMvRsU5usGSiYF7ugsgesRzNkzYupLG7aLQtUEPBb89g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5982

Use the macro instead of ternary operator.

Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
index bb4f3bd7532e..4975d47b66d8 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
@@ -311,7 +311,9 @@ void dcn2_update_clocks(struct clk_mgr *clk_mgr_base,
 		new_clocks->disp_dpp_voltage_level_khz = new_clocks->dppclk_khz;
 
 		if (update_dispclk)
-			new_clocks->disp_dpp_voltage_level_khz = new_clocks->dispclk_khz > new_clocks->dppclk_khz ? new_clocks->dispclk_khz : new_clocks->dppclk_khz;
+			new_clocks->disp_dpp_voltage_level_khz =
+				max(new_clocks->dispclk_khz,
+				    new_clocks->dppclk_khz);
 
 		clk_mgr_base->clks.disp_dpp_voltage_level_khz = new_clocks->disp_dpp_voltage_level_khz;
 		if (pp_smu && pp_smu->set_voltage_by_freq)
-- 
2.34.1


