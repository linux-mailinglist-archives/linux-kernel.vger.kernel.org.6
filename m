Return-Path: <linux-kernel+bounces-296743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7670695AE6E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F016C1F23757
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC5F149012;
	Thu, 22 Aug 2024 07:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="e2CUDSCr"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2084.outbound.protection.outlook.com [40.107.117.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD7D33EA
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310459; cv=fail; b=JTo75XUA97Jw9TSRdxDYyKmLIeAzLeVMQl/sCUuW2+L8eW3WOcrHOJ8gEhlaLqzrrRuU20oCbWhXFYiJQAUBdagPvX+rgWypa60wh91cvOV0cop/B0JRn9kKnlzqgXVET8TkfHkLE/EEpwbSkMr9vuEPcNzfwklHRgq95j9ERS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310459; c=relaxed/simple;
	bh=L8lko9n+UEc1mIAKYk+aB0uxiEt/348G6o8OsgfV04w=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gIfwVT5ZDC0GJYdugyXU3GV1kuJ2NT2Lcsms+8GNDOaMVhR4mg7JnR2CosMKeo6iSe456z/ZswbU9LXZFao8LELjV7cvQnoMBa+1YrFSD2uIZ8Z8s1fm4kk7u5cgkWUkZv8zdbdfb0HXtTC0Lxgqsgz6aOObr4WbP4g+VGQVpXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=e2CUDSCr; arc=fail smtp.client-ip=40.107.117.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CziOFdpx7o6TcweENxzhDwU1btkpPARDRdUfntNE2N/z3SC0a5fp4kc3GoS0TLIvVi3MOnXNAXSfHa87JhahpTumd8kFtYURnMw2/UEZa6/eVGl885EAXsbC8UU+beebgRFqGvBW8w7lmuGhTXhEOsF7ugZPkCTVANojXxAwkccG97g9JWM9KJCDheghj4qLel+Aqq/8Q7Okeo3foVsg5JLfaahqaOz58eZuags6k2yO2EONeq7hxxT+3mjRzyoB6YqbbDYh7A+3xCmWpVI7E84juZnzMARvS9bkVDee0P4KCgiDL/Gmmk6K27UaW9+MW7MO4AIpYQgVFbfsSvLMLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YgvMKo1pC8sd/FO5PKGcAV0VvdPyyQT+TkDvy8O9m4=;
 b=TfQH0GJVGYgroi0EKuHScxQiKdi8x2Bf1WiazWOSDlJyyjYu/Mdc/L6TDLvnFVnFl5qRFMGSVHcAuLMALnEcKdMfG9ZQSvwsdtm/v9GnRk4g8PtcOi+p+TcwaGNKy2Dst7TRdc5vLTjbVnHSRIYtEHAf4gWZN5275AAq0cgX5vSKMmk0USHfLloghK7EFYb5OWoIhrDp4q8a1V7Rpn77ugz+jklSDeBX0ZtYqJ+a6zr5odF3BePtXTIxsvkO52Y/CuMFKN3zaiQ6+i+21NaMZY1cM7UdFDRKV69NTtvITJ41q1YOBOvzzHP3TY0HLUdcrgKtPR0ZcC7T6ttqL1DR8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YgvMKo1pC8sd/FO5PKGcAV0VvdPyyQT+TkDvy8O9m4=;
 b=e2CUDSCrM7PX0+s2rG7+ubpYnNYRhhNxWw4bdE+WgrYB5UVnYJpyRN07BwKu6xa3rZDMxPzniJRADh1ngIp+SxfD9Z4m1eF8VQTocO+WmIc7zf40bc5ItQneAo/CWIsfg1yJZJ3YLbLtaLd12AAug1pYDPcMLg/aO+OUOAQKNKpFL/6ba3nqfJQSltCUGFxgeBIC7GixuGKxe3DkrMwiaZxUOX5ttFQTOTnlLvpwb2f7vRMlH3u9ZU8s7pV1h9NsvZdCsgv46mjJ/ImpIK8JUtpKhf7b+oaZw4DgON1/crZ35olgvS9/fELv/G3gXxHrCrqcRm3EuAsFSBJABVSpEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB5487.apcprd06.prod.outlook.com
 (2603:1096:820:bf::14) by SEZPR06MB7138.apcprd06.prod.outlook.com
 (2603:1096:101:225::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Thu, 22 Aug
 2024 07:07:34 +0000
Received: from KL1PR0601MB5487.apcprd06.prod.outlook.com
 ([fe80::2129:59e5:6c67:311f]) by KL1PR0601MB5487.apcprd06.prod.outlook.com
 ([fe80::2129:59e5:6c67:311f%7]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 07:07:34 +0000
From: Chen Yufan <chenyufan@vivo.com>
To: John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Chen Yufan <chenyufan@vivo.com>
Subject: [PATCH v1] timekeeping: Convert to use jiffies macro
Date: Thu, 22 Aug 2024 15:07:17 +0800
Message-Id: <20240822070717.12773-1-chenyufan@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0175.apcprd04.prod.outlook.com
 (2603:1096:4:14::13) To KL1PR0601MB5487.apcprd06.prod.outlook.com
 (2603:1096:820:bf::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5487:EE_|SEZPR06MB7138:EE_
X-MS-Office365-Filtering-Correlation-Id: efa56c26-a8cf-42dd-5a75-08dcc27918e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W912nLEZGI+fD+cw5CEYqmJ48Ev2Sdpg71K5m65nZwvOCdN8rLdk0XKLgnVy?=
 =?us-ascii?Q?qRd2HeesoQrwQ5FZ77yD40OLuU2r10wsTYmKSDWfpG6CDRe+NAEwPk+GKEKz?=
 =?us-ascii?Q?MxCO32/eI7j/Bp2/tVmT5Jt3zEn1ETYIxCis3us6uiHvvoEKtWdyBNidVu4M?=
 =?us-ascii?Q?DrRdcJnPOUq9LBsgDQkqQFcwPlHFutJnbdBy8WQcvE3qzhJ3TnmZ9U7xcgCy?=
 =?us-ascii?Q?dQTmZBQ2QDoLsBm/O3E153j/7Ki+9llXbzBi9TNNfp1rURfe4V4Uj7kAGchI?=
 =?us-ascii?Q?C8XLM8a7D/4p+N2DIjO1Llz4gXcumA4skx37K0zOfbrHJMuCYxRIr4v+61Ie?=
 =?us-ascii?Q?HvigXJ13vfNPt+EMW7QkV7bwUGj2X/qzNLDXtLyNQe0F9rqqPsdyjablBSYU?=
 =?us-ascii?Q?WuIGErlcMlUjySWBBZQN0yGKXek6dS4VcfuMIX1U3Ly+HINkKbCLjnFVPzVv?=
 =?us-ascii?Q?LVwZgSVjqbFkc9x6VKhsfunQwJqrNibwTsZICUTrQD46ySH3Hz8KuU/Usv4K?=
 =?us-ascii?Q?4I5TqJx5e4S1sgL3tQwKi+5Gf3676D3Ueiq5qDx926YeeVNhFxNiB4GlkAgm?=
 =?us-ascii?Q?DXxhqlWPPH/qEC081VFv33tZ4hIkf0WGNuzmmSvMwNoaKwNBdO4rzP/N2rkE?=
 =?us-ascii?Q?MYNTFyLZJrzIpVr2tw4HN9SW/AF/EAQMZfFmC6y7pAqOV+LNuE5ULdrN06qH?=
 =?us-ascii?Q?sOhSTIdg5XbmsTkyAAw4el7pvcrTup0Zv9e71LzwgsNLZI55ql3na8jkFg5V?=
 =?us-ascii?Q?g13LvpM7ESw6ZyL4pDZIhrQoZ2Sx/syPVR5nnX3ogl8TGiVulwHRj+Ps3Xs3?=
 =?us-ascii?Q?CMXMCFLAVIrf9Kk2mHlG2aNUPnlsK91vD6Ldf9II04j7z+vnsHQwV1/Vc90T?=
 =?us-ascii?Q?JqJf6EqrvjnTZgZ4UJgwaa/iD91w5VykbLzwrqMtSxLpv0CY+O/A2H/cmM4r?=
 =?us-ascii?Q?alXX71GpXYOYu+DxazRakaT2ZkwD/RKn943sPgVhSxbkhH7FneHZ/hQW0Gnb?=
 =?us-ascii?Q?9NgsWa8G1NDB45qotG8hd3hN3j5Mts+roOLuGhgfYfWQb5RMsE+YtS364ECt?=
 =?us-ascii?Q?tGSEtesFfFAsl9HOpLMulZe4exkYttKTqfCnXpqUk9r+iF2noWm+ohwBQ/qh?=
 =?us-ascii?Q?7apImb/4kkT6wP5LmtAbnl3JqtlF3WgesCBV3zXdpbsi+hZSl4QKAzfw33kU?=
 =?us-ascii?Q?pDq8C/fY1IHATh1sJyLTyjHzpjp1NYqsqRubfpufCzTjUrJGCiHLjBMwikH+?=
 =?us-ascii?Q?XUsMgjVh01Etw8ymdpZ2HU9puesr/s9mSDjpLI/ATSBKBDjM6QSIL+dWLetP?=
 =?us-ascii?Q?owa1Rb56bLZ6cTyPAysJxHw/rKeBVGHnTTrFod8Ox/vk8ehzVNDbIhIpV9bs?=
 =?us-ascii?Q?e9ZLT1Fa3QU27nuDIXuRsDZbhFLkAh3WMuBVdCdxiSff392AZg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5487.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zkT4B0WNCis8rGjQllWYrddWRBcnao5zf8ndSgSruBbgwJnEnYqlzUxCgmqU?=
 =?us-ascii?Q?MqlF/FF+FOHNRknlzPypmL/dVprW1YUDcQTmHRfZdjWfLeJzlKIH05qscS8M?=
 =?us-ascii?Q?TaZUStJ1ySOu+x5wublTAM0JtIAF7ZtYfQkHGyVh3FHFeg/igXYc0lmSovwK?=
 =?us-ascii?Q?rwqocrbH0MV8p+h4HlaymPEKkBCGgPzykdeFERu3YpTlDNZFgtUs+j4jyOzf?=
 =?us-ascii?Q?3vgpVG5vY13XslOE2Bg2G0loGCgymamAHN8h/paQk1GYcXxr2dk9WQ73Oag+?=
 =?us-ascii?Q?OCIw690JsR2AHOi2oloQEXBH5/+SWF58eTtl7TEL1szpXmK3DYdOiOTQglau?=
 =?us-ascii?Q?tcu4hymEx98iIPQJSM6MXSajWanE78fouisgSwbqGDemDYyqoh9FkDxn+rUT?=
 =?us-ascii?Q?ZOagpRs3cDNOj5wYef8vR6pBG4yJCerkKUV5m/038mmPtgCZ7ETLMMnU+D3k?=
 =?us-ascii?Q?DubZCO8kQcvU20L1DNLU+nU4M5sT2n/2551dq2Sq/o2MQTr6skoK1/N8JIcA?=
 =?us-ascii?Q?1WbFn73YJ/eayQIr5cSqUl7DcZr5mtm/TAutJmKA35IryKd/dqn74o04gonJ?=
 =?us-ascii?Q?GrbQXYJra1QY0tKtgeuyEXdAj/1Qfx2UVs5armoCi8JdIKaFepThf/Yu71yg?=
 =?us-ascii?Q?doTe85ix83ciGOnrhHQgaWZd3nG+W+5yZ4T7Jb09r+Z/4HSHTKnF+BAQXKqz?=
 =?us-ascii?Q?xxXC1pMPSsUKCyGyMdGOurWn6gHp2OempFFC6W1rNBB0e9QIjOOUE/eHXXbZ?=
 =?us-ascii?Q?J5va5sKBpxMtmG1RAR11b5ViVvc/U6YC6UxNeU605EF1QnL+Of4j4yV4GWDC?=
 =?us-ascii?Q?Claebi3HVfyIcv3ZWMOpBubv5M1tbeXhNnduVpXdeBJcJz72YQZbBO2ysujb?=
 =?us-ascii?Q?wV4eCJxR94ShVIH2SA+pnmi16zPq9F5x7WdVE2JM9XhGS3aY/jDpt7aP/aWI?=
 =?us-ascii?Q?8bE3hgYA08P73BtaE27yqhPN69kTW/wft83VNZkMxPvUKEgq3yQZedeg6Wa7?=
 =?us-ascii?Q?kowLL74RLKt0nIzeb9J2YfuEea8Rpp7LOVw92Vq8cMcuOBK3GGvRlYD8jM4U?=
 =?us-ascii?Q?+5A1sPzJWnXKYsVfm/4KnWBKEQHGLCi+l5q6fP0UM+bObkpVh162C4/P23q9?=
 =?us-ascii?Q?iGOindO838rzdo5mbVBJfsvfHlum6+LrNcyNF0Ee6aJN2eMUxbMTE7WiQdfM?=
 =?us-ascii?Q?EFAq9qY5ki6Q5qNLiIm5OUbria5pQxUiJAWUfXeHOuTbv7dsBkqJO9vspN2I?=
 =?us-ascii?Q?tu78NdYPRbuZ0+o5PlxAJvRgblTcSpb+pxPofhI09wYzWfd1pXFp+XQFF3JP?=
 =?us-ascii?Q?OBG5sBuq8/Wy34T0Qh7IMUMy0WY8fLXozPM8JsB2ZmpuKep2WcybUlIegilK?=
 =?us-ascii?Q?m7Bjs5QIr0ZToG4NdYz9W30fEuCyMQeOvHJ5B/4LdshkE7jha592P2xObh0c?=
 =?us-ascii?Q?58LnxYla3wzQs8JdYwhqp+gF1zyzTqKIzoOWaCpzbX5JyEW5q4iW1jOiKdPu?=
 =?us-ascii?Q?UFyklorDqS3hi4QIvtrSww3wXTAnXXul4gCalbzp1ax9d1AMi/v0ToY06/Bs?=
 =?us-ascii?Q?XrbNFmyTyv2v79H5a8ClVm3rlCsbcNDfV08GklcS?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa56c26-a8cf-42dd-5a75-08dcc27918e2
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5487.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 07:07:34.5548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q9lE3/7OXV5Q04s7Xr3PFLwkq6lUNSz4BWstHuiJdKAF/IJOfb4YJRqr+QVgYwXwUsd6cUc+T1rQiHoqpDDBhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7138

Use time_after macro instead of using
jiffies directly to handle wraparound.

Signed-off-by: Chen Yufan <chenyufan@vivo.com>
---
 kernel/time/timekeeping.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 5391e4167..6cda65dbe 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -217,7 +217,7 @@ static void timekeeping_check_update(struct timekeeper *tk, u64 offset)
 	}
 
 	if (tk->underflow_seen) {
-		if (jiffies - tk->last_warning > WARNING_FREQ) {
+		if (time_after(jiffies, tk->last_warning + WARNING_FREQ)) {
 			printk_deferred("WARNING: Underflow in clocksource '%s' observed, time update ignored.\n", name);
 			printk_deferred("         Please report this, consider using a different clocksource, if possible.\n");
 			printk_deferred("         Your kernel is probably still fine.\n");
@@ -227,7 +227,7 @@ static void timekeeping_check_update(struct timekeeper *tk, u64 offset)
 	}
 
 	if (tk->overflow_seen) {
-		if (jiffies - tk->last_warning > WARNING_FREQ) {
+		if (time_after(jiffies, tk->last_warning + WARNING_FREQ)) {
 			printk_deferred("WARNING: Overflow in clocksource '%s' observed, time update capped.\n", name);
 			printk_deferred("         Please report this, consider using a different clocksource, if possible.\n");
 			printk_deferred("         Your kernel is probably still fine.\n");
-- 
2.39.0


