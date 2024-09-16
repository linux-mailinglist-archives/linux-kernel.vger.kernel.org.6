Return-Path: <linux-kernel+bounces-331002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D5C97A71F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 20:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A4428A2DD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E2715B149;
	Mon, 16 Sep 2024 18:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVgevNiV"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17477158A1F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 18:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726509708; cv=none; b=lEtiKWiY/jPnEWoXkyb6GT5BqYWp3ZHqo/U2RhNXOWVKzYe/7D/MVtsV1eF4+snrCWeD61s12ZzoTM6s6Ff8XDEcXI7CwWQk1WvZTlnFMzXt5jIoBvTlpj+1eyeLIVpR5vPeiNJqS6o9B5f7UeMWxT1+88f1T19gPkNnE/gCelI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726509708; c=relaxed/simple;
	bh=NRNz8ssAHhhm2oXxnE/h1hUFTmTpqIVzh4uHfbMY4sE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XiPyDhfylY+EyUCdrOdkPYSX92QOMc6ZoBfJYG5XN1OtnEAfmDclNjdCyk8+AGkXLR8I70wUhY8XVaqo6IIzMr/npWC9VUvFTG+sBYNMOr09fJHeSrXJdGm4S9cUZthe1NBGZ7bQuvU09KA2bAfFegMjDXFRXyCq/VhsKNGQBnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVgevNiV; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fee6435a34so41304455ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 11:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726509705; x=1727114505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HM7yZDstT32KnRF5TqsXhuhE8I3k19PJmZPriUtEwCM=;
        b=OVgevNiVq+LW6K8C8GVv6g961DgHTK+OKDzIw45BRZXUtOS3w/AGA1YMgT5UdfyX26
         +7l121GMuONCJB540pbgBlJJ29I9pzqzZk4QknwcMAu0xTy7wWAcjImG9qiBDvO/yN0t
         FHxUgaPVbzeZIUMkUV97fdUuXJNygi0/uwAqShGa3oSLg1gogU9dyVL0TlTjwOj+JFEt
         QXA+GJQ1ZdxYi50ZsyFDeCPbO8AOGf2iAvSPGWm3XUqOxZ600vAd6/XKOCTZ8scv6Hs4
         Ancj8Z5VnpxlykZQNNLTNLs0++VdysOyD84t0CRZXPJgZRIg2FXkUyNldT47Lq4Qaxm4
         6V5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726509705; x=1727114505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HM7yZDstT32KnRF5TqsXhuhE8I3k19PJmZPriUtEwCM=;
        b=WgIvX/eUspZqnNAUHFXAccV3ovfIdfHJ7Gbm8Y8TU0iqZoYpl4kyqPF1b95tUfRJ+P
         9Gi8i6/vsBUjwG3X50jtAks9soEBoDKJlFvNlnfq4xA7QcCNVcYLYqCvryFDFp8rADDt
         3BhmHgXrTHuSdHDBDJVC4xn2qXO7Q+v+EPlf8vnTNWQZkF+Qclucn3BNNPB9r8X7fsB4
         YGXQt2c2qGvRLnMW0jGo8VjbSoKG5V9mlitS/0l8NPxiv6E0gnFFmFymBjaXW28LzNAP
         t8+btmUVrf4d5jilSovmTXOYaTlgQO3OtYj5kEFb6Fg5x7WsgwTbSCPM+HUs5ME92qX8
         KAcw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ3DNpOK0wLY7FrgCXdN162rUZ8RQm5dEFGDXd9HT513VvhJdK9tQQF0XKPVDzpbxZZ1FCJDhSIOWIGlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwRvupvKJfdrAJgRUbdBrG3pG4RK+qLlsorV1LiMz8MMnb0ccJ
	N/LAiZlQIVf6Cr8uiYb6p1f/vTvlZgCPf7wBO3GBdFWO5d9FmkVV
X-Google-Smtp-Source: AGHT+IF/+A6mrgl6Ock23OiKbg4Cer/TYYH0w02Pdbq5FW/ya8TUeOPtqQhk7tXeYaNhDI1b5GUG3Q==
X-Received: by 2002:a17:902:face:b0:205:3e6d:9949 with SMTP id d9443c01a7336-2076e42e171mr181216255ad.52.1726509704832;
        Mon, 16 Sep 2024 11:01:44 -0700 (PDT)
Received: from fedora.. ([2405:201:d007:50c2:4888:86b4:6f32:9ae])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945da788sm38868525ad.18.2024.09.16.11.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 11:01:44 -0700 (PDT)
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
Subject: [PATCH v2] drm/i915/cx0: Set power state to ready only on owned PHY lanes
Date: Mon, 16 Sep 2024 23:31:37 +0530
Message-ID: <20240916180137.9203-1-vamsikrishna.brahmajosyula@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In DP alt mode, when pin assignment is D, only one PHY lane is owned
by the display. intel_cx0pll_enable currently performs a power cycle
ready on both the lanes in all cases.

Address the todo to perfom power state ready on owned lanes.

Tested on Meteor Lake-P [Intel Arc Graphics] with DP alt mode.

v1 -> v2: Address comments from Gustavo Sousa

Signed-off-by: Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com>
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

base-commit: ad060dbbcfcfcba624ef1a75e1d71365a98b86d8
-- 
2.46.0


