Return-Path: <linux-kernel+bounces-378502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0989AD195
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670011F244FB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C3B1D2707;
	Wed, 23 Oct 2024 16:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="pPbrKSQK"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917371D04A4
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729702219; cv=none; b=F39Rs18Q8C9x8wEbRDqvzxcFT89/MpuAVJoFidsyr8M+othwI9jgbC6GUjgWGE2AHk4xAiuxsZyjKDhju2m+COytlclCDUBsYDrBbEFhtE/rk+W3lmaRaafT5KLEF0YcBZLLNxR15CDroSFE4+f+SLv4qh+RyYpgJZqrVfMRJK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729702219; c=relaxed/simple;
	bh=PqbtIeM1IDQ5KL+eRzNbFyF6Q4wW+TRVdMlqsWJ1620=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ukomSi/tt6vFa9ehsqRMB6nuFoa4T/ONg8KyTUSSLMPKd2ufTuAlkiw3shNfbnm5uFHyoulF/t12xDdUcg2h/KYH0rfytBtD7mUdKyPQOkKueDn34a8NhD/UUnqHeG+pzDL7wAPZJr5HPFu8uAn+a0Bw3mLdxTvXCDrkujLF7YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=pPbrKSQK; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4314fa33a35so72277595e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1729702216; x=1730307016; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5yIqSMQIbhgYZ5JV0ptgvT7eERweCUm7MDofNLmccWE=;
        b=pPbrKSQKy+79QbP1q30QHQyjPdMFTSRdR+AK9u/8j3rdMev44zdO7XJwVoxLEHlfIE
         suDOWddVxjP7vN5kNretijz7HhYtGGp9AOHd7R+0Ve8Nhm7QEtV5tuHu8mJlWIj64siZ
         CPFCpJTKtJfXxKo6yPvY4dtcJp8y9UoOr+sY0pLasNlRYF5QDAcywk3kYFaeGVw4ugkN
         udqCyndtIJPtlgYKizcEPCA7CwZCHtqJjx1IYZqSN5h2Y0luijFAV/go+DV5tX5nDYDs
         wMqFFIIiZC5OaFqvd3VASi3GVHThr/8TwHdhrBnfVnYzS+fW160SVw01ardZqElg7Vf2
         Xj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729702216; x=1730307016;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5yIqSMQIbhgYZ5JV0ptgvT7eERweCUm7MDofNLmccWE=;
        b=dTq+/QG0D3gy01wJIrT5/m9/fBXO5JFFt86rB651Tg7o3GBc6uT9R6g39OSkAT6Dnc
         X1S593/vDTqBeRAIyo+wokPLkTMXSvmj4N5QA0g7FZaEB0RPnmrQ6r76RoknPER3LfqR
         P2zj83gBN0irKmv56CTHuxISJsBL10xq1Xkds6TqU1N6Fz0LaKcfe10mQ+H/rGChfPKe
         IWdouoDYw+/DF+FFZll8f1nJvLaPqgvK3ufjBWTyxaaaKcxYYH0pksujfha9depyRgSg
         OVvq/PESdbYjJaFvqZ+WzBTTD6bQAO54Dkx6vjNnGz7oBJJ8S3VVCwo8Pq5ES+/ssfbU
         0jfw==
X-Forwarded-Encrypted: i=1; AJvYcCUkRTMMBSXtqWkEIaEDCX48Y+dy89+lJGGY2CDJL2cJbvEHufncg1QQBWUqzdITG+YFBeScpQ08mr8sB/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2l1fZsa/MUtrZu9WfTQjQg0yrZiWiDxSB4KdxqxsHxTxm+HiM
	XUoTQjOywPwLD19bylpn8U4ys83xLbOtQ8TrmBqn2CEtaJvciWDgkdpD43qGI3Q=
X-Google-Smtp-Source: AGHT+IFhoWS1TvVBeb/zedIzvkvu/wsYZ/e4vvOHGOZFIjQ6RHyIgZHgWxuLAsd/TW4PoufcpONuBQ==
X-Received: by 2002:a05:600c:3b86:b0:42c:b80e:5e50 with SMTP id 5b1f17b1804b1-4318408b348mr29910635e9.0.1729702215724;
        Wed, 23 Oct 2024 09:50:15 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43186c50445sm21642035e9.39.2024.10.23.09.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 09:50:15 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 23 Oct 2024 17:50:05 +0100
Subject: [PATCH 08/37] dt-bindings: display: Add BCM2712 MOPLET bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-drm-vc4-2712-support-v1-8-1cc2d5594907@raspberrypi.com>
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

The BCM2712 has a MOPLET controller which is basically a TXP without the
transpose feature.

Express that by adding a new compatible for it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 Documentation/devicetree/bindings/display/brcm,bcm2835-txp.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2835-txp.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2835-txp.yaml
index c9c08042cffc..16f45afd2bad 100644
--- a/Documentation/devicetree/bindings/display/brcm,bcm2835-txp.yaml
+++ b/Documentation/devicetree/bindings/display/brcm,bcm2835-txp.yaml
@@ -13,6 +13,7 @@ properties:
   compatible:
     enum:
       - brcm,bcm2712-mop
+      - brcm,bcm2712-moplet
       - brcm,bcm2835-txp
 
   reg:

-- 
2.34.1


