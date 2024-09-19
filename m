Return-Path: <linux-kernel+bounces-333763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E57B597CD93
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 20:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B09DB22636
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 18:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E676C2745D;
	Thu, 19 Sep 2024 18:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAq5pEtE"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E363E23741
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 18:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726770602; cv=none; b=MRqjD2tn/1KIky6QTnRnu5IDrTMW4BBGByoXZjEAEjmPwJt89Sn1c25QTy+fgBzU3YiK3k8Hz0tFg0yVOqfUy0w5unCGRxcsbsoJWo1rl6Mz7CeWy+Gc1jchpnHf8mEMpSq72yXo0RdkNaAtOHnner/2TZcXa8P3pyYXA3sOBT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726770602; c=relaxed/simple;
	bh=w7kcnxb5FqbXku6JXJ9U6HLMo2GezQ04DdxUfalJmKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EJWtWRSxHZAcVbRW/io8/RJU/vyZL1JqZmKFObRzDaEePN1hcKAuSrkzEgGyynT+i1Anp0yA2ztOnnvpt3vBg9ZfhFRlmbn9SxVYB+sVpelnupNpVpsYck2mRrTaz0KEClddLXJd9R6Hz+NRF8kT3NzGWL5ZdxAXHYL6vHnAdrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAq5pEtE; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-205659dc63aso11131525ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 11:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726770600; x=1727375400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+KMrajb1zLurcFqyiwW/j9BszHT3k0A5x96qyT+yYNw=;
        b=HAq5pEtEcGBpg1AVAcgCyy8qAJ8hkJgk3wsYXAIajnTeUPZNCCPOrLzaNn9Km3v4hW
         VUSZPmqoiJrJ0sgetNoSMf79P0vP/XNHg6Wn9NgJnX6/Jdl0VuNqvY/yA9InEUOTjbfG
         4ZIdrOTIw59a7rV/XMS3UkxZQaMvbVPU6zulUURrOjvosw0rq3FnEGyGUnaVwTNaRZde
         8ljh8r0UGERmUwmf34vzyZFWVAZxCdQQw0jA4YBFWd63zY/XR8+S3Wmqp8TM6x53si7f
         sBcabf6hHyPoiOF8pLPEGNNhtzNcOdBshttdhvFWw1pl4TIEFeG+hmB3vAaqCh0exytB
         dlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726770600; x=1727375400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+KMrajb1zLurcFqyiwW/j9BszHT3k0A5x96qyT+yYNw=;
        b=G1txof/YaBvdSrrw2+YQq4TGMx+KwrUiDv4rYmLMNF/go17tfWecoyPMcjrZoDURoC
         r1JVjtEHxvhv3NlCj/ZGXYPlJsRWuW3V+6canM65UK66I1KX5Fjlgy1PbpBSCL8a1rFL
         wE+J7DhFUwz4ZgqfdWd2452ExB0jFKC+FygdiQSu1BrrGYqEjTcnXDFhJWRbegqd3DwW
         eKf1zlmfyik7/v00xUFaBx8R5cXP3raugyYHHHgIw7ACgHApfBHDDuvtaZLTZSKN0LEn
         +Rb8qkweb/YESgBKF0Q4TESYMzq6G4gfkQKx4o7A3MQ6ZHwBujQ25o1K6W3jzu/FuCGw
         X6mw==
X-Forwarded-Encrypted: i=1; AJvYcCVOt0buw4JIRl5nit/wY1462LLerAF6c0f00rQTQZJI67gFAmVxu4m2Wrg24OnRWqAd4Mpki149kWmo4J4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym6WSz99TG1Ys1Ti/vc/Pi5wmeBlTlSoL0yGoaiyaBwqKG9AL5
	yTnyUz4gtLJu2dkdkG5d6wS7EFLllATUXGgp0/4dIKRjlM0Bp/V8
X-Google-Smtp-Source: AGHT+IE/gUWsxkqc0ZEQJ/8L+xme7Oq1BXvLj6tIvEfVCrLPGjcgd7gcG3+9hX+uwwhCnZGK8WxBAA==
X-Received: by 2002:a17:903:2449:b0:205:4bc0:1993 with SMTP id d9443c01a7336-208d82fb42amr3255205ad.6.1726770599898;
        Thu, 19 Sep 2024 11:29:59 -0700 (PDT)
Received: from fedora.. ([2405:201:d007:50c2:4888:86b4:6f32:9ae])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794735728sm83021645ad.271.2024.09.19.11.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 11:29:59 -0700 (PDT)
From: Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com>
To: gustavo.sousa@intel.com,
	jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: skhan@linuxfoundation.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/cx0: Set power state to ready only on owned PHY lanes
Date: Thu, 19 Sep 2024 23:59:52 +0530
Message-ID: <20240919182952.51326-1-vamsikrishna.brahmajosyula@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In DP alt mode, when pin assignment is D, only one PHY lane is owned
by the display. intel_cx0pll_enable currently performs a power state
ready on both the lanes in all cases.

Address the todo to perfom power state ready on owned lanes.

Tested on Meteor Lake-P [Intel Arc Graphics] with DP alt mode.

v2 -> v3:
- Fix changelog per Jani Nikula's feedback
v1 -> v2: Address Gustavo Sousa's feedback
- Use owned lanes mask to set Phy power state to Ready, instead of
  maxpclk_lane with DP alt mode check.
- Owned lanes are obtained from intel_cx0_get_owned_lane_mask().

Signed-off-by: Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com>
---
Patch version removed so that patchwork would recognize the entry

 drivers/gpu/drm/i915/display/intel_cx0_phy.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_cx0_phy.c b/drivers/gpu/drm/i915/display/intel_cx0_phy.c
index 4a6c3040ca15..cbed53d3b250 100644
--- a/drivers/gpu/drm/i915/display/intel_cx0_phy.c
+++ b/drivers/gpu/drm/i915/display/intel_cx0_phy.c
@@ -2934,6 +2934,7 @@ static void intel_cx0pll_enable(struct intel_encoder *encoder,
 	enum phy phy = intel_encoder_to_phy(encoder);
 	struct intel_digital_port *dig_port = enc_to_dig_port(encoder);
 	bool lane_reversal = dig_port->saved_port_bits & DDI_BUF_PORT_REVERSAL;
+	u8 owned_lane_mask = intel_cx0_get_owned_lane_mask(encoder);
 	u8 maxpclk_lane = lane_reversal ? INTEL_CX0_LANE1 :
 					  INTEL_CX0_LANE0;
 	intel_wakeref_t wakeref = intel_cx0_phy_transaction_begin(encoder);
@@ -2948,10 +2949,9 @@ static void intel_cx0pll_enable(struct intel_encoder *encoder,
 	intel_cx0_phy_lane_reset(encoder, lane_reversal);
 
 	/*
-	 * 3. Change Phy power state to Ready.
-	 * TODO: For DP alt mode use only one lane.
+	 * 3. Change Phy power state to Ready on owned lanes.
 	 */
-	intel_cx0_powerdown_change_sequence(encoder, INTEL_CX0_BOTH_LANES,
+	intel_cx0_powerdown_change_sequence(encoder, owned_lane_mask,
 					    CX0_P2_STATE_READY);
 
 	/*

base-commit: ad060dbbcfcfcba624ef1a75e1d71365a98b86d8
-- 
2.46.0


