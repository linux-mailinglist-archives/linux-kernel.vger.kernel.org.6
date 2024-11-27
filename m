Return-Path: <linux-kernel+bounces-422997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEFF9DA106
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 04:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07FE8B25F5A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 03:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB753E499;
	Wed, 27 Nov 2024 03:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=analogixsemi.com header.i=@analogixsemi.com header.b="aecidKi4"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2123.outbound.protection.outlook.com [40.107.220.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F5D1946B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 03:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732676573; cv=fail; b=NSaCm/pRb71+VVg5NZ8uIWoVVFTeLM6IJ2mPMbdeTJsDAH7Wt11Rb7Etahcbt0MfoK306rzLOrJ0SRNAY3WEU9qgEM3AIbDo8RNJagWkGSguHlxHM7aMHJfUt8Koh9VsixrGt2RngZM47npH869QNBSkbrmpnLGqaQcZbVSQ1G8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732676573; c=relaxed/simple;
	bh=fNqhJttR8ssPvuVIBWvImXnkfpJP67BZSTWW4KX5+fw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=EoHQ6noJ9CCMStNmdVDgex7JIyPntP59kTnsjMPw5Y5LV38YWjCNqbYNP8M5ZOJPcFCK3F1LGuo1QASjIzdtcDSHHmXEGxtVXIonp2MOuU5zazZP0PsJ6t2MqH3Co0i8V4vwsxXYnfIjJmpk9HgF1ow2g1Zm34YQ7n1h3zHzN/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analogixsemi.com; spf=pass smtp.mailfrom=analogixsemi.com; dkim=pass (1024-bit key) header.d=analogixsemi.com header.i=@analogixsemi.com header.b=aecidKi4; arc=fail smtp.client-ip=40.107.220.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analogixsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analogixsemi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atgaRAnVsIpuKYE8WS7qOqjS5LSFLl11cDifjrZ3LS71AmZqlFRbwMkrnC/CmShr1rjSTleo4P0mYb6HN9GbabNDBhAhaUZ5CRHFE7y00OFas6AjTyktsnOA2m3nRJRqanUvV8MwvRvWmNOz9JMfdHFm1/EsAiXkg87aSpYK+4n71/JpvoZWo3sV6TQL6aV8YNjygaAz5ckdgEaeFyhO8Xy6OTuFa1l/WhZ5IV6XEaMENs7HA65b/jS3Nt8SHIL/XpeVb+0NaQhWE7CQapX1l2wxGBAcHsKywX73JxqBb7XWGQAwhnPsRPSAWTkRZr7obt4DnbI1l5H/NB2hBA5liw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zc0zghJEIJ9tuwMrzJqK++e6YUeQjFmFrkBSd4Em4Z4=;
 b=qBAXQoF2UXg7Ckty4OCQ4mmJS26Y7KzA3x9U6ZwdWeSv08XEyVBPiIJyMvxSC+ibexxOagQPG96dC7+w+vvgcbCUgJaTyG9Onv7qszP9dmatGd59/rsAqfrVkougvQx06ujqep0+zpvItB6kVyG7ZeWSXIgA3lB1wXeHsH4JBdFskgQtY00FC9zwmDBA6PRSw1aooFNzKbIGd4fsE7H+/YHVO/OQvm0lfO94migaPlPTe7QjBoGq6kq5rgILI66g+VUTYhK9vzHsg4Wgk7LnDuogaRcA4Kb9oR1lqcYm+aFKUMN4nLeueYaU8Xh4ZWwDBSVEQiSQJQ+8T+5BwHgVJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analogixsemi.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zc0zghJEIJ9tuwMrzJqK++e6YUeQjFmFrkBSd4Em4Z4=;
 b=aecidKi4E+mHJGDMkCehv2LBF55y0Fi02HkycSlJLp7FpYW4nK/y8oczCRPJ2FxHvr8l8XkkL5FkpfXSSys44fqX90d+UIcKoIONBcukj25h6OCqIbschih0GwReAqtY1DHjgiMlCY5rRDZ/pdSGWmkkzDIdXL387lzXIcQ5mUQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by IA3PR04MB9677.namprd04.prod.outlook.com (2603:10b6:208:502::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Wed, 27 Nov
 2024 03:02:49 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::5a7e:9e8c:138f:1815]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::5a7e:9e8c:138f:1815%6]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 03:02:48 +0000
From: Xin Ji <xji@analogixsemi.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: bliang@analogixsemi.com,
	qwen@analogixsemi.com,
	treapking@google.com,
	Xin Ji <xji@analogixsemi.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge:anx7625: Update HDCP status at atomic_disable()
Date: Wed, 27 Nov 2024 11:02:20 +0800
Message-Id: <20241127030221.1586352-1-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0052.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::18) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR04MB6739:EE_|IA3PR04MB9677:EE_
X-MS-Office365-Filtering-Correlation-Id: 30e51d49-4a84-4bb1-0b86-08dd0e8ff995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?23uWpzcx9OGUhYA0fP66rIFviNDVb8+7V3yUgivFVS6a3FsUc/dExq+r1Ft1?=
 =?us-ascii?Q?7ti8TDz0rtjFaERRGjwvIK0vPBnIDMdY65EAWK+Y+L6r3R2XjqC8kNHn6Tj+?=
 =?us-ascii?Q?B86aSWFXN7V1jhF4CHGQ+dFjiDbhrKA9G3Hlo+iNJdd+9VOxEebGsCg0/hAF?=
 =?us-ascii?Q?J++QU/RyE7jxynuehIlgpNZ+spm+Few8e/D3jRjOMca80ut7jQzxCbzVT7em?=
 =?us-ascii?Q?2pHCVpX7m2nO6lU+3rQxevVbtNPojb3nMTMbm5So4p/tQN8vZoOVNOyteFIE?=
 =?us-ascii?Q?8JOuT2gZfY1tWInovHpjWlM2KJWH4rvJBDnaohGEENXyBO2m5LF44rmxtfcq?=
 =?us-ascii?Q?MmreJXwu6ZAYs2cQli8F9F064l6Wfon1JX2WeuOMXz46Ii4K0DFw4Otiqv0y?=
 =?us-ascii?Q?UbhXwWnhiocE4K6z30Q9yfVIeaLAbRsibR7pSfeaeW80HKLlZgxL+qGYp0nc?=
 =?us-ascii?Q?o0cqb5uYCeKEngDHwIOZIL2ISPRgM0LLJ8/pyhV1Cg8CqGqBfH/NTWlXULy9?=
 =?us-ascii?Q?T/dlgAnbWZWPDvEekswmmJQjOIalZ/xM9SH+w18efl6nUxI2F83cajDZ6aU3?=
 =?us-ascii?Q?VnfLZPmQr6Ig6Pw0Cemv02chDdnPBSeaEDrXaDr7N9UMY+q5Ih5lOumn3N5a?=
 =?us-ascii?Q?urWhXNoj1h6T16JJcOW2xfsQTJaEQpYDImUiQ3rUvZfLu8o6xyYgxF27F2X3?=
 =?us-ascii?Q?brgiT7wqoX6Ue8ojf6FrQ7llvSDMy4TzpeM8FQLCcnH7QF1eh+nbEbtYty4k?=
 =?us-ascii?Q?A2nHfN+RSJUOG3F3UC5Mi433U+cvy4WOSKmOIRbbNwNmiA7NQNDEl6//s2Fg?=
 =?us-ascii?Q?1GwkCNhUDrzTaO3JYSpJyksm/cGZjmMEhysByEsc373Dtc3ksDgkb9URWHQ6?=
 =?us-ascii?Q?yRZKtbOrjatTDRWDL0/MYefL6i9DurtDvY5twnXuulRG4jxtszEoE5EIB/H/?=
 =?us-ascii?Q?qJSc/DPMuHkfkwdACeUk5aJnpyXQ5k/mVuUbTvZoKkX5HqFZp5MN4/UGLD/t?=
 =?us-ascii?Q?YldPcozj1YoGDoVwsEZ/8XJeJ64dkD+F79CW8ubZu67NMf4GqycptRzwx0lj?=
 =?us-ascii?Q?IDrsqC/3rha+ecaWhBkjrf1eoGG6o7R7K5gS23KoX4SFgV+2im3UiV7vr37e?=
 =?us-ascii?Q?4EmQrxn7NQZT+Bfk1EgLY27fPUYen3yWJLrmj2+JnZsFhs01k/OJYAXispsJ?=
 =?us-ascii?Q?JAmtyKwZuXUyBB/7/IpWGEgaz9niQtcnngQAW0Hv/SgiOFOXXUlps05qOQFh?=
 =?us-ascii?Q?GzV0EA+S5MjRQ5xJfd/bFg8cQTmc7HgvrdH6fwb91YBRyfy7iuEJ2ZII/vIB?=
 =?us-ascii?Q?nPRMOeca+oypMtT50JOxtOuDwcWWsHFUfyqAFb2zuME9qtZHvFGG/17FdOM4?=
 =?us-ascii?Q?qvbsGjbw8WWarqBq0BK7Dk1isvKYF3jsj4g+M/QUTOW7JDM4vWdILndIoR3o?=
 =?us-ascii?Q?rKOqVy1/2tc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SIZOYU068v8nJTSyprq/5u1B6ubk1klDtrPXuYeYb67GXIgYbDtmt5YZXaUy?=
 =?us-ascii?Q?RwxErjjZRfWz29GL2GCKTa5loERzQJmXIP8snzJyS4yyLj9e6gY8/VRfLwbg?=
 =?us-ascii?Q?aRXqMPy6M7jnvxYcoLPxNbsf71IIvSfWR3S7y3RboQgNXcICtk10a1M+f0cK?=
 =?us-ascii?Q?eI4tLhNr03TtPnwWF89SDzb9XlJ8K85eiNZACs+3+QoWvRB/5jdaf0h6d3wj?=
 =?us-ascii?Q?HTVikYsjKK/7oKVlboDbLcg+sH5H53iu76WBQviiCSHhxu6d1mcTi4zPYlUn?=
 =?us-ascii?Q?wl3DVvwhg57VW8cVuUQIdIZzFQkP8aZmFrOABlim1WAf//mDVYOkeC2SqWYi?=
 =?us-ascii?Q?ZjiE24StixNo0IKVNEqWz7HaSpmknOszXX/XAckddD+PL5b/oPeIfSngEik5?=
 =?us-ascii?Q?CPWb2bwia4U+DH6EH3bKz88vdgNnC4VNBygNZMgbsm3nscP9ei4e/++Gpfbq?=
 =?us-ascii?Q?WzFmWA7wlXug6nE304KMp/AZXNHV7EqtWRZUHl104qGAdhU4w6YzDlFZrA4x?=
 =?us-ascii?Q?XlV+Nd8vW8D9ENVvsknWjFAebFKp8cc9zKZadbUYJlg9SRdry0+nQPo/H1N3?=
 =?us-ascii?Q?ajzwNV9mhKn7Yb4iB3Yc5kw523XfQfpG7iJecUM7Qyl8ev/Xudj3nIS0R/Gx?=
 =?us-ascii?Q?AIRS47v/457HwJGxyNktud5qjHkWoCcYHdMNuVfNEyCp+tF2qBwkDeBx4g0x?=
 =?us-ascii?Q?/FsJjsBVNLYwlRzComSN4eqDzXUdynip3USeDiwvBEwNdLU1BGg+q2snO6GS?=
 =?us-ascii?Q?qiX0RvsEzCBixYBlkektb0+XAg5cPOh+WOdDOm5dqebVWApFNs5kKam489LF?=
 =?us-ascii?Q?MWNQXBHnFmN25m0t7I59PpzdLkc3Q9tunYvQ84WgtIjM6y5D5yfWmuDyVbf1?=
 =?us-ascii?Q?u96CCB1pd+3Mv5y2f5hUZmWQeoseKa36Q84dVhf9A73mLq1za78p+Ealouyr?=
 =?us-ascii?Q?w0Ski2MLleeQFgQdiy0xEZazR2k0HsBiPIXHT1ha1L0qyU+cBORyoOeELK3/?=
 =?us-ascii?Q?SVs2Y+GSdByk96Ec7FpyZDstCgAtPb5NSNDYdQtSrT/7F1+CIiz/7bcW35nl?=
 =?us-ascii?Q?vjt2oCmQocZPlVPKcbEyJ2R7HWlcJ923SGDQ1kxeqSpr+yqFKUOP5f2hWH+K?=
 =?us-ascii?Q?28wDytdZIpEo8DkMdYz/BRQVMql4E2i50QsobpkKDEyBfwKnKsyJlkBbanB4?=
 =?us-ascii?Q?OhPBmexv0N3JrAzbihMrpc8WQyjmDkxAWObnb/LA5dJlOaBNABg7OwbvZMKH?=
 =?us-ascii?Q?2ehUe294DvKV/1G9DbT2iSNqeBfilbhJp5YkpMRyi3uh1kHU9siYg5IRwuB/?=
 =?us-ascii?Q?alAYIF8UkKqrqNLL0iwX7RgwkFq2l11hZZQ5YhuY/cmV3vT8FZFPoLXxXgNe?=
 =?us-ascii?Q?tHpXPjGgMo6CgGNRb+EYrQdw9T47E8UGss6RZS1xz9pR2RCziXbOqk9sUK7f?=
 =?us-ascii?Q?kHPH/hizX0mZocebSc+WHtVNBDis9qP5LmS5+9rjxI+pL1JZWZpG3nSEv5lX?=
 =?us-ascii?Q?zaGUsdvny+D1kjJVCEDNeBbyrhPpKBpXS1IB/MeEpiFJH8bRUWE+i36Sx/Q2?=
 =?us-ascii?Q?mk7XBfFd3UTdJxY2N9PL9xUFEJNfuiulWF9LiOtK?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e51d49-4a84-4bb1-0b86-08dd0e8ff995
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 03:02:48.7941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RmcVeV7fRIpUE4KHazRmoAKRo6PBOD+rFPGLm8pAzp2CRDWrE6dR4doMBI36W71ao1+VPbIHMRqjs3juo0U8Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9677

Update HDCP content_protection to DRM_MODE_CONTENT_PROTECTION_UNDESIRED
in bridge .atomic_disable().

Signed-off-by: Xin Ji <xji@analogixsemi.com>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 25 ++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index a2675b121fe4..a75f519ddcb8 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -861,6 +861,22 @@ static int anx7625_hdcp_disable(struct anx7625_data *ctx)
 				 TX_HDCP_CTRL0, ~HARD_AUTH_EN & 0xFF);
 }
 
+static void anx7625_hdcp_disable_and_update_cp(struct anx7625_data *ctx)
+{
+	struct device *dev = ctx->dev;
+
+	if (!ctx->connector)
+		return;
+
+	anx7625_hdcp_disable(ctx);
+
+	ctx->hdcp_cp = DRM_MODE_CONTENT_PROTECTION_UNDESIRED;
+	drm_hdcp_update_content_protection(ctx->connector,
+					   ctx->hdcp_cp);
+
+	dev_dbg(dev, "update CP to UNDESIRE\n");
+}
+
 static int anx7625_hdcp_enable(struct anx7625_data *ctx)
 {
 	u8 bcap;
@@ -2165,11 +2181,8 @@ static int anx7625_connector_atomic_check(struct anx7625_data *ctx,
 			dev_err(dev, "current CP is not ENABLED\n");
 			return -EINVAL;
 		}
-		anx7625_hdcp_disable(ctx);
-		ctx->hdcp_cp = DRM_MODE_CONTENT_PROTECTION_UNDESIRED;
-		drm_hdcp_update_content_protection(ctx->connector,
-						   ctx->hdcp_cp);
-		dev_dbg(dev, "update CP to UNDESIRE\n");
+
+		anx7625_hdcp_disable_and_update_cp(ctx);
 	}
 
 	if (cp == DRM_MODE_CONTENT_PROTECTION_ENABLED) {
@@ -2449,6 +2462,8 @@ static void anx7625_bridge_atomic_disable(struct drm_bridge *bridge,
 
 	dev_dbg(dev, "drm atomic disable\n");
 
+	anx7625_hdcp_disable_and_update_cp(ctx);
+
 	ctx->connector = NULL;
 	anx7625_dp_stop(ctx);
 
-- 
2.25.1


