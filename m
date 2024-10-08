Return-Path: <linux-kernel+bounces-355610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 236339954C1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A42E3B24322
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDA81E0E08;
	Tue,  8 Oct 2024 16:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="c0TFij3+"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7A51E0DD6
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 16:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728405891; cv=none; b=COgj1dmboP5C6ebBGJPzRjhlAvZMp13Aem+594+hGcMyk+PW60vhCmABozjGAxXXULvX8dlCx5mqnZPbmdkrU2hVnsV5TsRSC4UMSg1AKhPjX1xr+qM0bAa4xHi9I3ODcQnsHwR9zCIBtHN37v8OuMn9cESvAfsPLFIMg3+ebfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728405891; c=relaxed/simple;
	bh=A91AYVw0BiIcY2vs/ZWbxXQUiv9EbXoVKIte1USIGEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dIByU/6YgoTmH3QEICPSwT9isqo6cKsDbfyqT2pmbYPrJUdlbWgQJh2xr1kgdW9RDR/+NiLkhh23GoNVT7sOW2Dt8mgD5jcSgzJ9xRqoTK3WFs158N9xZzKUUMoS511P2FhwH+IhKlJDN1tHSMX2ehhbtfygD/mTNxc7sfC6SvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=c0TFij3+; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cb0f28bfbso55032915e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 09:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1728405888; x=1729010688; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ikQLOlALZNXVFMnW7DqcctLilRiigotMVrHZ/dmQB8=;
        b=c0TFij3+BTLYXCjNawgoLx3RDco4yeKMjdW2NcxBBTtZ5jvhTzsV37R+FvOSAQobc6
         tyu68S9fr58SKhVx9fOhwG+FCSaM+KBWmp5o1efx1hroNiKA4ASnbXt/Qlmzpjh2d40m
         1HuYaM7qr/W0v6Kywic9l1ipSaP2nxeLFQOCbbWv6TaxnUVL4Mgc7uCVidT2HD7GnMdC
         kcufcokYCPAZO03nLmtdmKzrUjROW4HKsNS/sOLH//y8/WsqFFKo7HY7NBZoRUc65OTt
         7VXzYnxtQxCQ9pUKp8mnr1Le2ttCviWF7Q29S26B2UrWcpe+k/vShlKtll9SZpo29PWf
         W0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728405888; x=1729010688;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ikQLOlALZNXVFMnW7DqcctLilRiigotMVrHZ/dmQB8=;
        b=CsocC5feRsaeTELtZ0YYYWGKBW5tOp8+yP/MLcd3INGpq/5u/5hY9JGY12LZsdOtcq
         qHjdWvhbkoJ8YmA7bNIHxS7g/0ISOnue2bOBY0LjsgUZzWIgP+mnZ3osOGj0OHGpww9c
         nymm3TQ+P7PsC7fqWCmV2eY7vKxb/buD8gcpEPyM/TStSKKAfPZHiqGOj1e0It/pNUyS
         NLXDXxj/rRPHMP8QFh7kmCdgsGRbzpHZv004bBeyXfxG09vx9iE7ObZOzVAcvhcf3kfC
         jPrkiYhOyyge8vozJAAZc35HKLyKwGznajmTAlHGGex12pR9qvQfStRo40+yPzaa17Mg
         Lkjg==
X-Forwarded-Encrypted: i=1; AJvYcCU5jZfwZNc5sO94EZfRceQyxDBUce0TOYEwrqpe7gbP7QMybXemD9zSMzpJpmR3BmUpERg314YD0+wrBGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyalmNOF73T0te4bkWxeFLIW/1SDLmXRgrRoNymo2GGjSsNYfFk
	znmnBax/QAUp2V6bqfaYFvkn01J1a7/xBd8YMct6W3DxI7J9HbDyhfFmDVzoSWA=
X-Google-Smtp-Source: AGHT+IEsJwzrStX5MH98cq5gCBlUt8vaT7GTQuJ/pOjlbVoDQ8W+Ad1McV51f/G2wutta1nrDTZgdA==
X-Received: by 2002:a05:600c:35d6:b0:42c:b4f1:f2ad with SMTP id 5b1f17b1804b1-42f85af8c5emr124785565e9.33.1728405887824;
        Tue, 08 Oct 2024 09:44:47 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42f86b4acddsm132133155e9.44.2024.10.08.09.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 09:44:47 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 08 Oct 2024 17:44:34 +0100
Subject: [PATCH 1/3] drm/vc4: Match drm_dev_enter and exit calls in
 vc4_hvs_lut_load
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-drm-vc4-fixes-v1-1-9d0396ca9f42@raspberrypi.com>
References: <20241008-drm-vc4-fixes-v1-0-9d0396ca9f42@raspberrypi.com>
In-Reply-To: <20241008-drm-vc4-fixes-v1-0-9d0396ca9f42@raspberrypi.com>
To: Maxime Ripard <mripard@kernel.org>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.14.1

Commit 52efe364d196 ("drm/vc4: hvs: Don't write gamma luts on 2711")
added a return path to vc4_hvs_lut_load that had called
drm_dev_enter, but not drm_dev_exit.

Ensure we call drm_dev_exit.

Fixes: 52efe364d196 ("drm/vc4: hvs: Don't write gamma luts on 2711")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Closes: https://lore.kernel.org/dri-devel/37051126-3921-4afe-a936-5f828bff5752@samsung.com/
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/gpu/drm/vc4/vc4_hvs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index 2a366a607fcc..546ee11016b2 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -225,7 +225,7 @@ static void vc4_hvs_lut_load(struct vc4_hvs *hvs,
 		return;
 
 	if (hvs->vc4->gen == VC4_GEN_4)
-		return;
+		goto exit;
 
 	/* The LUT memory is laid out with each HVS channel in order,
 	 * each of which takes 256 writes for R, 256 for G, then 256
@@ -242,6 +242,7 @@ static void vc4_hvs_lut_load(struct vc4_hvs *hvs,
 	for (i = 0; i < crtc->gamma_size; i++)
 		HVS_WRITE(SCALER_GAMDATA, vc4_crtc->lut_b[i]);
 
+exit:
 	drm_dev_exit(idx);
 }
 

-- 
2.34.1


