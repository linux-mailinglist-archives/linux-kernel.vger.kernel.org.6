Return-Path: <linux-kernel+bounces-363719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9EE99C5FB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CC7B1F22B5C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B444156F3F;
	Mon, 14 Oct 2024 09:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHTLyPaP"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655BA15666B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898862; cv=none; b=Ok2hbjg9NPxAWm+ZCEvIARWrIF8bz08ROAcKen0p55Ye2xx8fMQfJQmjLDlgmciUibqHJtqHOfdnDHzdEHV4PvPFNHJPKcDg/RKzJizH9f/oQlHyAwBxvwdo0G88EnYFsCigat4QGuT2aMfQaYRvVVlIyGDpYXPDabeVn1cLlWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898862; c=relaxed/simple;
	bh=p5XMYQmLQn6nDeqPFmROh50lCFrxs3BLS4f63jKnnuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X/p6pHB/m/1anDWGvkgPA+6prh8OcyAo4jN7zXGstrl6TiotUpVXLiABz9l1LqberEwKG9LuzF7Jn3BcVyEU1KH7RUnPNuvfQndSHRMTAHnNwyTBmPSOdXhKyOSNuIy4a+A0DieRJGVl4vAWWG76mnLP2ro3SONKCxDYwH0KMAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHTLyPaP; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43124843b04so18166605e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 02:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728898858; x=1729503658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5a4qfjLxUFAWrjF7SBSebNnHB1LQ0GNam3wZT3QbPkg=;
        b=VHTLyPaPS4ee0S8AV3y39kVcFIIGIj9DlxRauLiQdiNgauHrbIdv/lpCUxdM4oBsB9
         n9NtcBt9G/J++BHqFi6Y58H67zYzIzp1GIk1brL9oC2nIsHmGrTZeGJR5QEAg6ziMw30
         l6Xe8pOXBxurZ02u3hE93QcplMtCTjkxADN2Q/78F4Bmek1PbxhoXXktRsofidNcD9+3
         avLYhb/96i2xWGa4wAsVK+uXqCtd6BsCc3F2x8ilbB11HwrgKomaHZ76bdXm6TwS+ddE
         rCtpnfLsZ+T5xqvZyyPwSf1uqphJVxjDXWnBFPgxdv7QSkM0r9BoKLtrQRpsNBjrH7IG
         9fsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728898858; x=1729503658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5a4qfjLxUFAWrjF7SBSebNnHB1LQ0GNam3wZT3QbPkg=;
        b=BfkMgVuoszvKXgInpAL4SFmTqDdc1zXxto4hDauP3woDlGVct7pBZLDHKNdCfCOZ1Z
         zWnzrcK9HxAukYpW9EaTIsn/iMWi+5cDlrrY00S4TvfzRbVmL3mgjCTj8TnQImkDsF8n
         P6MFBZrxkpqK8fSyqg3RwZr7U6eelPmRx3qdYYrdcJDLdw0XxQ9rQTeo2MiSe0bEsuou
         OUDMC2Y709cxX/ue20X1ycMOYB4tiuIQ0Fq7uAksNKBZgg6hKtcKcijgHrUfqJL7ReiZ
         RzWl+qBO2IjrjyWgsX4bv5IA4knumMS4JMQvsAa2tE5OIoKvlWlUR/Ug7R7BdJ7Yf1Ir
         dmtg==
X-Forwarded-Encrypted: i=1; AJvYcCWxB5M9qPzt8oEbBez8uv8LLezRkEPf1MnWQkr6U8/Bz8pblYkGiq6EYecfTU0XAqf8cz5KqFoMovnaIaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw86RGk0T4kgcomxCCCb+v6N37dlrKeLNoKff7hOwGtJjC59NrV
	6MUytQ+T7JTB0ETu/45Kpb2b/QojlBH0lrM0K3mlk2/wuIkUSQeAvUxj6g4VCp0=
X-Google-Smtp-Source: AGHT+IHBDC3j3sVyvHElbDNRRmedDAgbyplgVakeUYKBKRQlyrc/vtKe3qcsRtcd4U4umqg8KfNKVg==
X-Received: by 2002:a05:600c:5705:b0:431:2b66:44f7 with SMTP id 5b1f17b1804b1-4312b664514mr43060755e9.31.1728898858349;
        Mon, 14 Oct 2024 02:40:58 -0700 (PDT)
Received: from giedriuslaptop.vinted.net ([92.61.38.146])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37d4b6bd03fsm10889481f8f.34.2024.10.14.02.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 02:40:57 -0700 (PDT)
From: =?UTF-8?q?Giedrius=20Statkevi=C4=8Dius?= <giedriuswork@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Cc: =?UTF-8?q?Giedrius=20Statkevi=C4=8Dius?= <giedriuswork@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Subject: [PATCH] drm/i915/lspcon: do not hardcode settle timeout
Date: Mon, 14 Oct 2024 12:39:12 +0300
Message-ID: <20241014093914.109162-1-giedriuswork@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Avoid hardcoding the LSPCON settle timeout because it takes a longer
time on certain chips made by certain vendors. Use the function that
already exists to determine the timeout.

Signed-off-by: Giedrius Statkevičius <giedriuswork@gmail.com>
---
 drivers/gpu/drm/display/drm_dp_dual_mode_helper.c | 3 +--
 drivers/gpu/drm/i915/display/intel_lspcon.c       | 2 +-
 include/drm/display/drm_dp_dual_mode_helper.h     | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c b/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c
index 14a2a8473682..ae9d6b93136b 100644
--- a/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c
@@ -491,11 +491,10 @@ EXPORT_SYMBOL(drm_lspcon_get_mode);
  * 0 on success, -error on failure/timeout
  */
 int drm_lspcon_set_mode(const struct drm_device *dev, struct i2c_adapter *adapter,
-			enum drm_lspcon_mode mode)
+			enum drm_lspcon_mode mode, int time_out)
 {
 	u8 data = 0;
 	int ret;
-	int time_out = 200;
 	enum drm_lspcon_mode current_mode;
 
 	if (mode == DRM_LSPCON_MODE_PCON)
diff --git a/drivers/gpu/drm/i915/display/intel_lspcon.c b/drivers/gpu/drm/i915/display/intel_lspcon.c
index f9db867fae89..764cf4898364 100644
--- a/drivers/gpu/drm/i915/display/intel_lspcon.c
+++ b/drivers/gpu/drm/i915/display/intel_lspcon.c
@@ -211,7 +211,7 @@ static int lspcon_change_mode(struct intel_lspcon *lspcon,
 		return 0;
 	}
 
-	err = drm_lspcon_set_mode(intel_dp->aux.drm_dev, ddc, mode);
+	err = drm_lspcon_set_mode(intel_dp->aux.drm_dev, ddc, mode, lspcon_get_mode_settle_timeout(lspcon));
 	if (err < 0) {
 		drm_err(display->drm, "LSPCON mode change failed\n");
 		return err;
diff --git a/include/drm/display/drm_dp_dual_mode_helper.h b/include/drm/display/drm_dp_dual_mode_helper.h
index 7ee482265087..7ac6969db935 100644
--- a/include/drm/display/drm_dp_dual_mode_helper.h
+++ b/include/drm/display/drm_dp_dual_mode_helper.h
@@ -117,5 +117,5 @@ const char *drm_dp_get_dual_mode_type_name(enum drm_dp_dual_mode_type type);
 int drm_lspcon_get_mode(const struct drm_device *dev, struct i2c_adapter *adapter,
 			enum drm_lspcon_mode *current_mode);
 int drm_lspcon_set_mode(const struct drm_device *dev, struct i2c_adapter *adapter,
-			enum drm_lspcon_mode reqd_mode);
+			enum drm_lspcon_mode reqd_mode, int time_out);
 #endif
-- 
2.47.0


