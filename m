Return-Path: <linux-kernel+bounces-372414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 134FA9A4838
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C30B928132E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B16208971;
	Fri, 18 Oct 2024 20:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iHEigu1j"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F90118801F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 20:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729283738; cv=none; b=aPRFKu1zubkqBdaCI0PIpRst5ifppHw0HKCYO2eHG+m5p7OndYnpf+4KEzTuyj+FwNJsSG6uIRA/cMwi2Bi7iq+goBKLIO3eJ33ZjbfSkkS20XdmMTXx0d4HVGwiE9wj44O576LbJPT28J8e9rU4gnQz2Qp/7rQew+ctcLGrH5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729283738; c=relaxed/simple;
	bh=pKk163LMDVj6v54mfPGIRdSC85Ls7fSRSTyM5dZXEbA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kL0nsU1mx4vK/dGbdic6eU20zuRnZaGk7SesMrO6beQOYwGvm/CoTZjCfpvhtjRSXrok79LlRtAh9ohDLDne4RDnp2hsj3lkfQPr2pqWovEvbiMFxeysataBOrSZqqL7fzGCqXt+1h9k09I1256y1nXyz+2vOfdpAdAHmQtyUfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iHEigu1j; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539fbe22ac0so3056747e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729283734; x=1729888534; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DkSqDVM+OnjF+v0+0ZQEDga6Q+ZMXwj1q1eJK3kt87E=;
        b=iHEigu1jfT4QlXDIWkUdd/wrzoEHihudwEDuwsHlUzyFARXSzbhGx3PTCeHtKpYGQA
         EZ9LFQOc7ePHYDP4Om4VbcWs+j6TU6cxi4xPZ1YIGuFrB+0AgcOq5YcOWQO1FTzOnM7U
         UGMNfyNzBhz4OPzce2i7TuwBpnqDkSSUsFJm82DxGb5pipfGCGtif00umgO91Vd2ZQne
         W/V976WWPQg7HzF/cJ3zc3lAbm35Gg7Ki+K7M+le1AhF5dw4RrL9k+iirmlZQ7EDfzxe
         2hrz5DqwFGT0N8fZNn1AsiHNDe1HS4uTwHHf3lpiOpiAV+MgGYZeT3ErNYaXxCVvzitL
         Yptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729283734; x=1729888534;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DkSqDVM+OnjF+v0+0ZQEDga6Q+ZMXwj1q1eJK3kt87E=;
        b=mEPCaH/PbTe80bfh3aSInrkzAMWVKqtLSVFT5nDKSZsXBc3s6poeHPMQ5MuDACgTmt
         HnVgVRWRnyBnCA9kiACnrcAEhNAZdzeiYxwq9ac1VUPitK9hSXzes9Z8/1p3yzDcN7r/
         NRMRmDBEgkvOxZt8RNmXX3A8Uj5EmVOPkj73K0HSpvqCVoJcOttwqytW5/dLoKlM2P62
         RWwXAQLha28+dsQrp9PypeiTzdPweBWucIOGGlQwH8a+wsKmN4yxrc6NJH9MEe+TM10b
         AbxeTLHNSBLmLSrRQcg7Zd+Au9gijpcWnTiJwP231c5Rt7geaC3q6d3SkfRwjKuAr9ur
         /+Dw==
X-Forwarded-Encrypted: i=1; AJvYcCU7JWG+rboMAz6PZos3vd9nADZFI2pP2R8PHd4smyNgJO1QCoT936dGAM11J4+CZhmThh+8SZWu5u9sxVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMqSK9O3cvWqlSunRwBlSHxK2ULhrYzmZKx3QmYGp2Ssr3gkX5
	ig7SHZ0oKRY+tuN/6bBhW2qtXkFAEeP6v/lIfms/nbfqFBc8AExNVCkHqtXUaYk=
X-Google-Smtp-Source: AGHT+IHzYkuJZ6He3xwlqBtuptVarSRmqR+0hl1ibW2ueCQLRNIsql9cH5DCivezs4UNKzkdg1gvbg==
X-Received: by 2002:a05:6512:3a93:b0:539:8df0:4d3f with SMTP id 2adb3069b0e04-53a15445cefmr2551963e87.40.1729283734514;
        Fri, 18 Oct 2024 13:35:34 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a152044adsm319315e87.193.2024.10.18.13.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 13:35:33 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 18 Oct 2024 23:35:30 +0300
Subject: [PATCH] drm/fbdev: fix drm_fb_helper_deferred_io() build failure
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-fix-drm-deferred-v1-1-c33bf5d209b0@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJHGEmcC/x2MQQqAMAzAviI9W1hFpvMr4mFsVXtwSgciyP7u8
 BhI8kJmFc4wNS8o35LlTBWobSDsPm2MEitDZ7qeDI24yoNRD4y8sipHNBScczbQ4C3U7FKuzr+
 cl1I+kvcAz2IAAAA=
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Cavitt <jonathan.cavitt@intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1374;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=pKk163LMDVj6v54mfPGIRdSC85Ls7fSRSTyM5dZXEbA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnEsaU4LCIhqwK2qU4tiDA2tygruguQJdK+imJc
 t/DCOHd0JeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZxLGlAAKCRCLPIo+Aiko
 1SrhCACLFFYBzpvpksP0UsaEaxLJSu1Llqw2vqRrWTtntnAKSGUVGkj4rugWxIq6348zsbxSTBL
 8wp9JGXOm8Nz39ST3FBJEwIIrAtU6+yjVQvpmAE9cBrubxYTYI4JwheotPmBWy7xdF7DrY0rsjt
 G4iXtAjowJZE64QFkikieA+I3yB/n6pz7Kp2rO3n3mIOE/gO/NsgoXeSe/g0VQ2nOQI90R8wjoG
 X/heHdaoZv+D7GE93f4zcHJ5P4Ti4XhjgCV9d5FcgQf5w4/688TY1sX1yOWT28CqQKAU56tgSSI
 f5FoRwwvkz/pKtLVGuo4eQwPKi097e8MTD5vD5wJeiJhT4OA
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The drm_fb_helper_deferred_io() uses struct fb_deferred_io_pageref,
which isn't available without CONFIG_FB_DEFERRED_IO. Put the function
under corresponding #ifdef to fix build failure if deferred I/O isn't
enabled.

Fixes: 8058944f5226 ("drm/fbdev: Select fbdev I/O helpers from modules that require them")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/drm_fb_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index d5e8994345bb..c9008113111b 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -697,6 +697,7 @@ void drm_fb_helper_damage_area(struct fb_info *info, u32 x, u32 y, u32 width, u3
 }
 EXPORT_SYMBOL(drm_fb_helper_damage_area);
 
+#ifdef CONFIG_FB_DEFERRED_IO
 /**
  * drm_fb_helper_deferred_io() - fbdev deferred_io callback function
  * @info: fb_info struct pointer
@@ -740,6 +741,7 @@ void drm_fb_helper_deferred_io(struct fb_info *info, struct list_head *pagerefli
 	}
 }
 EXPORT_SYMBOL(drm_fb_helper_deferred_io);
+#endif
 
 /**
  * drm_fb_helper_set_suspend - wrapper around fb_set_suspend

---
base-commit: 2063ca42486bc07b49bc145b5dfcb421f4deebaf
change-id: 20241018-fix-drm-deferred-01c9996c17a6

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


