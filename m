Return-Path: <linux-kernel+bounces-378511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B75239AD1AD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70AEC285244
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47EC1F9432;
	Wed, 23 Oct 2024 16:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="WVyScaqg"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8374C1E2828
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729702228; cv=none; b=dCs64KtVRPPT2iTvOqWGhsa2C0B/S95rufBWhyee4FUndQu2nK57U5yaD0Nqa9X/hhvbaTPjQhn5qC+RrpDNMEuVUMBPmOp0H4VhdnBnk1P3qiIWvCUXWfDqU2cXTTgkQg+2qHrlffpLkMfup8ztmSn7ImbCi4o9brOrILRy7lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729702228; c=relaxed/simple;
	bh=UWJvMv3Z0a1PpjzyOCbjoPTg3oDPbd1fp/cxOBSwg9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DD1OoO2vziCgzjU6mmN2/z9E21fmTtExbeElWAr3/oD/deSMJGflbrf4+B3h1yqBjdutCROKvxlG44n1+RDCD5EOc6Tw6rlY8ZPGVy86KgUYp1NpDS6OsPoj47IXx83+fnSBkd3TnoD817y2SQq6Mnp0whgg9jsgQUZwVA7MhHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=WVyScaqg; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43169902057so46654405e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1729702224; x=1730307024; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QATmMbNk3c4g4hXx1UR19WiwFTrUbM+WoGxURwc9BNY=;
        b=WVyScaqgL6Kb4RZC86dG6CNTPk9F8zekv0aIf3b+HftV8AUm41975mwhCYe0WBWsmk
         EwoOQv4sb9dKrtJuCv70S+RhmLEqyInEY07VdWUxbv/s3tTBOt/jZ3G0kk6/9cKvdnqF
         lnXf+GHxUmws6MawYEH0L4oWRy65exccsEoFHCaa3/OHkRcoUXCENYp6GXSpv11Ahn+L
         R8BFaQbg00GDzRTa9KCfFueGeF6kXrMD68KVsd/Hs7fzSNtT7WCStkmn/lMxpgFWLHXd
         u2ETcUPeKCC9U9uLvXwUSPJ4oCew84rRn95TgvM5NjLGn85EQeaSwkgmaIBTM/pi5EAf
         4Cug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729702224; x=1730307024;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QATmMbNk3c4g4hXx1UR19WiwFTrUbM+WoGxURwc9BNY=;
        b=c8BPEDPIdxq+HZlFQqDyn8SX1FvUTeOrdooV4hbhQ4Sb4O/IATaXzDeIbjjomvHabN
         klS93IDdEqAUIWW7OqjA7FXYOElnW24eL05jIYH2oN0dRCgVCiXBfcjT2+xtzu4nMmRF
         xH1Zy/+jqywskPTDsgC5lCshtElMwUoZjF1+MzSgcHr9L1ExhvzZlbLO2cu4oQKW6J8b
         VnROoFHVbtsaoH438gA6X2fZm7hVPYFZ0Yi9GofPZCqxWicSwdGG6kLPbr5iehIE5GmQ
         65PfQmZvznVOerTdrPjH/zZLNKX/7/iR/P8VsWK1S7pvIEdyXd/aMtovJkDgVlStDr5F
         jsnA==
X-Forwarded-Encrypted: i=1; AJvYcCVUoewVJ3KSUpMygN0bvK8n34h4ydw0dKro4Uf71enAuydpmPATA5PfDCzCM7qOBgr7VpmZFiKuriuOw9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjWrZpIygjkLg+pfclgtfyHOYFGsJzWnz66KjMbBlWsQqZIc8M
	zeLzlnF0CZ0LQlAhdPaN5FAsOcDJxjfEblfvf6Gvlxv/KpVz/A0skHWVbLbOOMc=
X-Google-Smtp-Source: AGHT+IFQpdDu/f44Xgfd+NG6WrKmi4zfDWeKblhsLQsMneFB4Oq57+PB7CTMU6NnjVTgfyxomcFzlA==
X-Received: by 2002:a05:600c:3b16:b0:431:5ed4:7e7d with SMTP id 5b1f17b1804b1-4318415b482mr26031435e9.18.1729702223590;
        Wed, 23 Oct 2024 09:50:23 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43186c50445sm21642035e9.39.2024.10.23.09.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 09:50:23 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 23 Oct 2024 17:50:13 +0100
Subject: [PATCH 16/37] drm/vc4: txp: Add byte enable toggle bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-drm-vc4-2712-support-v1-16-1cc2d5594907@raspberrypi.com>
References: <20241023-drm-vc4-2712-support-v1-0-1cc2d5594907@raspberrypi.com>
In-Reply-To: <20241023-drm-vc4-2712-support-v1-0-1cc2d5594907@raspberrypi.com>
To: Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.14.1

From: Maxime Ripard <mripard@kernel.org>

The MOPLET doesn't have the BYTE_ENABLE field to set, but the TXP and
MOP do, so let's add a boolean to control whether or not we need to set
it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/gpu/drm/vc4/vc4_drv.h | 1 +
 drivers/gpu/drm/vc4/vc4_txp.c | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index e08c90245f94..27deb4cde02d 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -538,6 +538,7 @@ struct vc4_crtc_data {
 
 struct vc4_txp_data {
 	struct vc4_crtc_data	base;
+	unsigned int has_byte_enable:1;
 };
 
 extern const struct vc4_txp_data bcm2835_txp_data;
diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
index 6fe378b454ca..eaf30b2cfb5b 100644
--- a/drivers/gpu/drm/vc4/vc4_txp.c
+++ b/drivers/gpu/drm/vc4/vc4_txp.c
@@ -287,6 +287,7 @@ static void vc4_txp_connector_atomic_commit(struct drm_connector *conn,
 	struct drm_connector_state *conn_state = drm_atomic_get_new_connector_state(state,
 										    conn);
 	struct vc4_txp *txp = connector_to_vc4_txp(conn);
+	const struct vc4_txp_data *txp_data = txp->data;
 	struct drm_gem_dma_object *gem;
 	struct drm_display_mode *mode;
 	struct drm_framebuffer *fb;
@@ -309,9 +310,11 @@ static void vc4_txp_connector_atomic_commit(struct drm_connector *conn,
 		return;
 
 	ctrl = TXP_GO | TXP_EI |
-	       VC4_SET_FIELD(0xf, TXP_BYTE_ENABLE) |
 	       VC4_SET_FIELD(txp_fmts[i], TXP_FORMAT);
 
+	if (txp_data->has_byte_enable)
+		ctrl |= VC4_SET_FIELD(0xf, TXP_BYTE_ENABLE);
+
 	if (fb->format->has_alpha)
 		ctrl |= TXP_ALPHA_ENABLE;
 	else
@@ -492,6 +495,7 @@ const struct vc4_txp_data bcm2835_txp_data = {
 		.hvs_available_channels = BIT(2),
 		.hvs_output = 2,
 	},
+	.has_byte_enable = true,
 };
 
 static int vc4_txp_bind(struct device *dev, struct device *master, void *data)

-- 
2.34.1


