Return-Path: <linux-kernel+bounces-405864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEB49C5842
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9811284804
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8BB13AA2D;
	Tue, 12 Nov 2024 12:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbXXwOw5"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BE6224FD
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 12:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731415742; cv=none; b=u2D/DC+84Ik8dQb+dT7tE3aa3bGh+rlQz+YNNGQHGbw1ddZGTLi5jnTggpNTHEvolWMLPIfT20Q3d7DfYujT3dyv4EGyKGdZEUj9+ra/QifUyHu84xb5HN0Ao76myBvZ1XLiec0xq8IeDTAxai2JcZlofSSNqKYnmMXPjg+a6Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731415742; c=relaxed/simple;
	bh=1x2LryC0qTxoTpM7vcWCH/RnvCF4xENPoyJG/UGp6NU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ukHkfLEFbqRR/+mrFeVaGGxAWwWgucpbmmNcFhCBp8Ppjze5n1b9kAqZjP+seWFp7uuHgYMHgXGP69O4xU794cFWXwN/4/+I/VpEGHOGD1JyEGjQKPkw1Amxzf3LrYHHqZh/Z+4XYowC/vGSiify3dergYO/tTkO90n/yeXhZ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbXXwOw5; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e2ad9825a7so4244151a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 04:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731415741; x=1732020541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uyDbG8WmlHUfOOwJXFgUm11idSuEHNxJbOFfw4uInpo=;
        b=LbXXwOw5ppxfRGMZOVRyp/8S6SBZMJuwT8PWdNdhJiqh71HsMpHNe1br0tJIaQmhOP
         HcM84kDLlw4ZHjOIR35nKHhPUcThQOQPeMI2tA18tGh3h7hJ6qisTq+an8HVctWuGoDh
         RN3O0R7f0FdgIzxF6/cCtXFWY2HYhmwS5DT7mWNethn+BC8pxzb6oiLT+fYH5ePse3XV
         7+J7kPFfnqPKj8JdpHnc/PazY/rf6PbdAFWfxyGWb1lUj0BiKt7jKeafn4qvYwgwnf69
         AGv/qrrRCHCfJFmjvq7Nod/KunlXcTktuR4z2ihtCMP5vIFrSXs/6SP2symu920i84cK
         PBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731415741; x=1732020541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uyDbG8WmlHUfOOwJXFgUm11idSuEHNxJbOFfw4uInpo=;
        b=u+dtw1OXH6l6d7XFZlK+7pIQiEXvtRI5fG37fgvVT7YihktWTvzD0eCnAr4yyRWW29
         6MBz1v8Bg+jaWJGa+62YotX7WqrTwlnjEsMn8amg2xdxs7nhBOkFoR0CZVOtQHnWj9Q7
         iOY+FGz76kXt9bZUFKwcHhezFbJrTHmIbwBlf4w/24IElUQJmMHsga8LFzuHG/oIpUux
         CxhK47s5957b8E0fdjVvE4fxwj80B8p8PoRIzjAOTHb8tqmzRFxYEX4GOrVKSsBLxV/+
         HFhwN9n3mnSB5IjMhTnyY4f2N2Ro7cfnXBOAS2RLovSzkn5ugBQkrXHPSrh6SrntZp8C
         wpsA==
X-Forwarded-Encrypted: i=1; AJvYcCXDRn7fOcY1O+bd2a89DhDGK4zHUxupurbLHHG6pWQsYPtzCWLmYjsX9EVQOt+uvcTU4ym2bFH9K5c6/lM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKMaP9X6yq/YJiW2rKiz8IG0Kmt2MUsnTpqF2MOCBYHv5NaHSh
	5gYnE/z41cLlM5vEbKd1CgotuCLLdyvAfvEygGFXXxal5GJ6wbn0
X-Google-Smtp-Source: AGHT+IHpwK0BSIgTdysN3cqOYSyVo/pFhuw+GU8ilXyR4z3p4poQm1CADIm8AMOz1aERTBgxtDNSGQ==
X-Received: by 2002:a17:90b:2ecb:b0:2e5:5ab5:ba52 with SMTP id 98e67ed59e1d1-2e9b173f1ddmr21641830a91.20.1731415740429;
        Tue, 12 Nov 2024 04:49:00 -0800 (PST)
Received: from fedora.. ([2405:201:d007:50c2:b7e7:6df3:9958:a45d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9e9b55935sm779521a91.1.2024.11.12.04.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 04:48:59 -0800 (PST)
From: Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com>
To: gustavo.sousa@intel.com,
	jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: skhan@linuxfoundation.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] drm/i915/cx0: Set power state to ready only on owned PHY lanes
Date: Tue, 12 Nov 2024 18:18:52 +0530
Message-ID: <20241112124852.6940-1-vamsikrishna.brahmajosyula@gmail.com>
X-Mailer: git-send-email 2.47.0
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

Address the following todo to perfom power state ready on owned lanes.
    TODO: For DP alt mode use only one lane.

Tested on Meteor Lake-P [Intel Arc Graphics] with DP alt mode.

Signed-off-by: Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com>
---
v3 -> v4:
- Rebase code
- Include exact TODO to the commit message
v2 -> v3:
- Fix changelog per Jani Nikula's feedback
v1 -> v2: Address Gustavo Sousa's feedback
- Use owned lanes mask to set Phy power state to Ready, instead of
  maxpclk_lane with DP alt mode check.
- Owned lanes are obtained from intel_cx0_get_owned_lane_mask().
---
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

base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
-- 
2.47.0


