Return-Path: <linux-kernel+bounces-347776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B216698DE64
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A0931F27F00
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3878B1E529;
	Wed,  2 Oct 2024 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="t1sHDfpL"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B3A1D095D
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881616; cv=none; b=Cs81AfTdtv/nKKccjyeKwtVre0MH+O13B+yNTvYmwtxyWoamC+vthHmjaNXNO6H5lTa4SG9K5dYKAyXLvjgBIikQa4BmEElDd8ZZYgQx0+vGJ9W3i3DTfs9c4tcp6PC0/VarCAbJWsCteyHnhWiIKFgJzlgkJr2mEPhWszUuro4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881616; c=relaxed/simple;
	bh=fXCr/hsYedWkZJ9fW1Lkt3YBn7qDCmXTUPB0bTCcb9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uNhVEfGdLYyjscqwo2glKQrIEm/A7c1xA+20zDaFB0c+jTamjZgYCfQJPht3oSr/Si8gsSRdvC/ORd8NW2BQJqQwifKpoxFkd7UhO5IATJKuo+TUetWpteoPWuiZOCIQpEx0Q1LsawuSOuVIwnj5O2CIRqqq5fYSUxyeZGvMitw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=t1sHDfpL; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5398e4ae9efso4742960e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 08:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1727881613; x=1728486413; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0aaSKJint9BKAl1EBaxoQ2jVgmDuzxX5hASejfL2+k4=;
        b=t1sHDfpLvijmbXIVzlKDkn2mgC/jBtfutqJ4WljPVYAH3ARP3KzgJ5Pzcl22FHJj3Y
         zN6GDEO+7Bf4Bk+k1cNpThv0gu/A80xsnW68OnnZ8+a4+d1+9bfHoWGpAgxu6+6h/CqU
         hZYRHHcuUtRnDsTuX5P+rRfSSzuCPfLZtxSHdyYgw6opIfIJJ42kImvR9ySeKFqyhFK/
         bOxMgLFEwVBPNjtzSGbY/YfAlfe+pR18Z/DI2cTE6nsX50fZ8RJYpwlDmsmgjFA7c+oV
         qEDc9KM8IdkjTU1YXopXlpthsF1iIkeq91EhoeTV87Yk2ufE1ITT/KiPjBe1cr+lXAbY
         yO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727881613; x=1728486413;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0aaSKJint9BKAl1EBaxoQ2jVgmDuzxX5hASejfL2+k4=;
        b=ds364PYwMo9ed4kOCN2no/x+1vaXjCtC3hs/enNbTmxGkMCt8M8fyzjfq6SHCwWftX
         MHAHbRqi7CKgc8SfNwtchijaVIEm62TO9/CIchHk+Gg+DXVSjaFxzfr1VnMptbRmjPAB
         VmY27MtGyFrVmk8iD2JhUTFkCoEpP6i/HyEVkQY3HB8RxTRXO/bVa/vOyhdRI+iuwIvd
         MYXiDNcdUo/k0y8eQPehspkd4e+2buP5+4LZQbHYAsT8lRwB/gO7CEKe5TMcgkys3Rin
         cNyzF9yOdwJYthlbsSzKzqf69uY6yZRIL/p3C3jb9ZcvgZuQJnIFnqWROjn18D1kBbhw
         j4mQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6VQ4Cp89fz0AXiejQnuMrJ2sTL1O/ro1kcaB7mupoJ6nPadmUUBary2/v5n61KlYkgjamZ+vx2cm3HGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8uSsTr/SfJHIlKFkq052gd98jsJD4qGLIcX+J0jcjW8WvutIF
	dwlRWG9qJk7JTSDbAD42vj1ynQDLtRiHHIuqeUZSDAhY8IvjDPjyiIUIj1Cr5KQ=
X-Google-Smtp-Source: AGHT+IHRN0bivOMkxtd7P9Vwt5ImGLSLuu4E/375FOcRMlxCyc6JCW56eMN/xSM59wtgzA73gEK8MA==
X-Received: by 2002:a05:6512:4011:b0:52e:9481:eaa1 with SMTP id 2adb3069b0e04-539a06656cemr2152474e87.23.1727881612849;
        Wed, 02 Oct 2024 08:06:52 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42f79ec0a44sm20794485e9.17.2024.10.02.08.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 08:06:52 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 02 Oct 2024 16:06:20 +0100
Subject: [PATCH 2/2] drm/fbdev: Ensure that one of the probe functions is
 defined
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-vc4_fbdev_fix-v1-2-8737bd11b147@raspberrypi.com>
References: <20241002-vc4_fbdev_fix-v1-0-8737bd11b147@raspberrypi.com>
In-Reply-To: <20241002-vc4_fbdev_fix-v1-0-8737bd11b147@raspberrypi.com>
To: Maxime Ripard <mripard@kernel.org>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Javier Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.14.1

Commit 5d08c44e47b9 ("drm/fbdev: Add memory-agnostic fbdev client")
added the newer probe function, but left a path where no probe
function was called. fb_helper->fb would then be NULL and the strcpy
would throw a NULL pointer exception.

Handle that error case.

Fixes: 5d08c44e47b9 ("drm/fbdev: Add memory-agnostic fbdev client")
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/gpu/drm/drm_fb_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index d5e8994345bb..9c8868d7b9d3 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1635,6 +1635,8 @@ static int drm_fb_helper_single_fb_probe(struct drm_fb_helper *fb_helper)
 		ret = dev->driver->fbdev_probe(fb_helper, &sizes);
 	else if (fb_helper->funcs)
 		ret = fb_helper->funcs->fb_probe(fb_helper, &sizes);
+	else
+		ret = -EINVAL;
 	if (ret < 0)
 		return ret;
 

-- 
2.34.1


