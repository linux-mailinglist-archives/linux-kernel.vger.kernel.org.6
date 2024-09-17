Return-Path: <linux-kernel+bounces-331706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A68097B051
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 14:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2FF5B2368E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267D61741C9;
	Tue, 17 Sep 2024 12:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWpdbn+8"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36099171E5F
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 12:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726577099; cv=none; b=poa5PgKWhFXEbe+ua9Rk8OynKPUmHxcZBdW7o2lP7PsX1/UH/ib71EECwtuwekQWh7s2XGGyx88w6+xmp2oDmQGxFwr8ZXpVw7DjBwH3NmFyd7lL+Yw8AB3iSit2HB5X6SKaAsX+H3plL8A7brPUEegi2BGS1lCc4R/pmtkP8gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726577099; c=relaxed/simple;
	bh=j7HFvW9myGO2OFpl+AaBP1hzdJw+MsoPLToWcqMhK/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XUGw0tWs2KNa2tK87IorWuG+BNHXD0yypONOseL+JUb+MXsLeGasPU5QiIcjxPFhbBENFPQSNAFZv21X3jVIpVnE7Fw76j5lVtUXh5KXz4iUn2e9ZyUTl5GBXWlRN+zAN1CjohSyY3S5Q/sdX6C4A9+UGGVNTx6wnHyi8HRmaP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWpdbn+8; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7179069d029so3451195b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 05:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726577097; x=1727181897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PuR2oEx7UOd4jtIaDKowFjYpkaW0nFWhgHvIpNqBCnA=;
        b=cWpdbn+8wrb+FP4flZGHpvQa6071igUOyxdjjnViP3M6rtA6W80D2cG5RUsuz+08BS
         Gvg9XS9ux1WhIgI9f6o8OLO4lYhLXrW2XTTKTBcO2RCHaWZsgbV5Z92p0QJke3Sr9XJO
         B2kfYseAOll9VnOHH4Eq5EEEiICpnS1G0hBvAoey6TOe9QzgMGrC1+IM/R/RFtg1wDaa
         4138M39kTdGJWkWkf8WAMnFngzuhXMp5Vi5K1mjUSu8PCL3FuKctFK6GXE/JPg84NQRl
         bf4+0ZhARnqgdogOx1mCYYeiPgJ7CnpllvlumaDNRPV8SRemB7ar2EufYxkNrHytXnQt
         Aa7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726577097; x=1727181897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PuR2oEx7UOd4jtIaDKowFjYpkaW0nFWhgHvIpNqBCnA=;
        b=VFmtt1UIFNLHvxPJRDMcr349zw67aYN+3o7Cx/u/jA4zO6oy/iEET47o1iOicEdptD
         ZJ9DSltDorBm/t3Cqd391OseOcwH0BaqDX8B9QOE8r/KNHe2IsEtcv0Ls7xH/04Cj9yT
         MCa0Xg8+RotlrabtAqSDR8QJV/+YdJCm2cjCPc7qjizK9U9sGdnzVXStiNo+5sfwfuew
         BSCpvIaFXTHxizV7OUhAWUq2IvcycCqt6okQGiVCvXRdXtgqVaWa3NISTw4c3WWAZv3g
         v4URrj3hUio5CE1Ud0KbcJCBdgPiu0mAM/iVCNYfsMLMR94uHQBm52sLPfwaIITYgSSx
         n0gg==
X-Forwarded-Encrypted: i=1; AJvYcCXOhJpnJEFsBthC6bWKSq0F1ZmmbZCoU2ns3wrIIGsrld1n9cgvZS7IKQEdbSVYQRn0VqgzvO6TAaRUoa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdOL37Hosicnwwyj3w1aKY1C+VFj/yCNPUwYnr+kmPLHgt8eaw
	h7t799PZfIjbkPy+WSDZaps5wkMcH+Z6N4cfQjesqs77D2TnpxfF3X6jVqyOx5AIR3kb
X-Google-Smtp-Source: AGHT+IElrNVLMYeSdPugu8LX32nYuMCgAY1uSEYXmKx1Xd1xFBDpCzFzwKVITNzv1ITogJ2layOxZg==
X-Received: by 2002:a05:6a00:27a0:b0:714:20a8:d79f with SMTP id d2e1a72fcca58-71936a60409mr23039083b3a.14.1726577097122;
        Tue, 17 Sep 2024 05:44:57 -0700 (PDT)
Received: from fedora.. ([2405:201:d007:50c2:4888:86b4:6f32:9ae])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944a973d7sm5117415b3a.6.2024.09.17.05.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 05:44:56 -0700 (PDT)
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
Subject: [PATCH v3] drm/i915/cx0: Set power state to ready only on owned PHY lanes
Date: Tue, 17 Sep 2024 18:14:49 +0530
Message-ID: <20240917124449.223206-1-vamsikrishna.brahmajosyula@gmail.com>
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


