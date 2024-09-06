Return-Path: <linux-kernel+bounces-319285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EDD96FA16
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 010C0B22C2C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F3C1D2F5D;
	Fri,  6 Sep 2024 17:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gANvLQKJ"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C820B200DE
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725644772; cv=none; b=RSKwy2eqwiFoWoQNT/mKjXtNFALig0YsrPoJD0K56UMfun91Z7nAsWcuoGqF78nvx1t+L1ttCXfW3eUyyxDyocZaviXPsZzkQ7hBrMU2AluHKRgHGLaUfhSTspDmNjg9DJnDVwtKUzSe4bPAkKp/oC8CVgxEZRBMIUtZ5RtZj7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725644772; c=relaxed/simple;
	bh=SPKeOKmKZRFLowFV/zLqa2KvC8mYZLS8DlgV8474r20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QFwOQtZXb/vo3fnFkAyMk2EMIheuGwdB/JngJlnws784z6UJtOhCj/iAEHWJEzg2lTFeONHI66GUk9KOTdxcMk0XEgRY0TpfPERxayjIg1KSCOmI0RNJ0BplEr54z0trsMqw8Lp41PWxrs6ol6Dunm4FoGiwzERAMs7eeQodJTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gANvLQKJ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d87f34a650so1645736a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 10:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725644770; x=1726249570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=//GMh5wcWPuvbL5byVeOpp7gx8/ceI9tmF4jI5oBjrY=;
        b=gANvLQKJqWBF2Yom1eg6miG8eImOdHMGBRRlKkxpn7+BIUFeEcZ7ZxNjhRu0rhWTPq
         edAAHn7N49eyond9e4AfL0FCCupWz90nuCX6wpqOEn3F4JXk/99agHKv2d5HXePEe/S7
         gueOnBzTxgZYSOqZfow9TEr+vhoisCxEJ0RYPYTC2MAS2X49bHAgGSTmGHDYxfFMw2Na
         jjIum8zW5vueKxMdLzbxU96xvt45mINJOcL4fAJAwJmFRDk9o9LtyizCTaDBE99PveUS
         cZFNt2djuonlpLbKXUgOIz5sKJexbOksrG1TQ7Pz020IUopkfUb5Bpx6LjYIjmDJarko
         alxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725644770; x=1726249570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=//GMh5wcWPuvbL5byVeOpp7gx8/ceI9tmF4jI5oBjrY=;
        b=Rqxgd6bR7Q1sLXGRCzmr90ImduffSY/umqrBZH0PG1HXLsMbd0tevyLXw+iDFgC4nW
         7B3jvy0XXOs2bSeS/DLYhIUunR7fO04jWdC42nYqoWsHwkboaJWEOeguYuGt+lsesNWG
         vSi7jQ4aeY3IMlnbqP5IM3Z1D2spcquaeff3AQ2Zk4qlZagnLAfnQRPjnU0SQuxWThvU
         WjgkuG+rKn0WviDrLYEsaAUJLwZZU3pfGtm/5CCnv8Rkz0+cX2zGQhyVXMUuM9YF6fWO
         +sdhqGIRWkJJOWZ23NhUmkRreRnN0WZXsmI101VctzdSx2tKeWw1gWHnl8PXNwbdCPty
         D2oA==
X-Forwarded-Encrypted: i=1; AJvYcCUYf4fyw7SYNybVHeU8F5gpOKC4e9thnjv5hzSgtGuMJa5Bw7XKmTsC1GYFleHZQ7X591NqzoskV+pIZbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Wp7oZbp4dYkgtOqVDPbezvqP07z6Gs6nFaVjpxOsvJG2ReFn
	f0s01rLtQpTYMZ6veQKFELLMWguXcNX1sYOpBsPdpd0htBfqECu/
X-Google-Smtp-Source: AGHT+IHl1QwGj6f27gy0SNNX8R4uHPJcDOIVI4Q+cvPI+qzi59HzqJAavBhcgc+seszYKXg3rYCwsg==
X-Received: by 2002:a17:90b:4c42:b0:2c9:7343:71f1 with SMTP id 98e67ed59e1d1-2dad511c22fmr5252445a91.14.1725644769664;
        Fri, 06 Sep 2024 10:46:09 -0700 (PDT)
Received: from fedora.. ([2405:201:d007:50c2:4888:86b4:6f32:9ae])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dab6e5dc04sm1466452a91.1.2024.09.06.10.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 10:46:09 -0700 (PDT)
From: Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	daniel@ffwll.ch,
	skhan@linuxfoundation.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/cx0: Use one lane to set power state to ready in DP alt mode
Date: Fri,  6 Sep 2024 23:16:01 +0530
Message-ID: <20240906174601.9271-1-vamsikrishna.brahmajosyula@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In DP alt mode one lane is owned by display and the other by usb
intel_cx0pll_enable currently performs a power cycle ready on both
the lanes in all cases.

Address the todo to perfom power state ready only on the display lane
when DP alt mode is enabled.

Tested on Meteor Lake-P [Intel Arc Graphics] with DP alt mode.

Signed-off-by: Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_cx0_phy.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_cx0_phy.c b/drivers/gpu/drm/i915/display/intel_cx0_phy.c
index 4a6c3040ca15..47aa0418379c 100644
--- a/drivers/gpu/drm/i915/display/intel_cx0_phy.c
+++ b/drivers/gpu/drm/i915/display/intel_cx0_phy.c
@@ -2949,9 +2949,13 @@ static void intel_cx0pll_enable(struct intel_encoder *encoder,
 
 	/*
 	 * 3. Change Phy power state to Ready.
-	 * TODO: For DP alt mode use only one lane.
+	 * For DP alt mode use only one lane.
 	 */
-	intel_cx0_powerdown_change_sequence(encoder, INTEL_CX0_BOTH_LANES,
+	if (intel_tc_port_in_dp_alt_mode(dig_port))
+		intel_cx0_powerdown_change_sequence(encoder, maxpclk_lane,
+					    CX0_P2_STATE_READY);
+	else
+		intel_cx0_powerdown_change_sequence(encoder, INTEL_CX0_BOTH_LANES,
 					    CX0_P2_STATE_READY);
 
 	/*

base-commit: b831f83e40a24f07c8dcba5be408d93beedc820f
-- 
2.46.0


