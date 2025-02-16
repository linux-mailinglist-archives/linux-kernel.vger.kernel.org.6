Return-Path: <linux-kernel+bounces-516488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518A1A3725D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 08:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F0D97A3BA8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 07:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA6114BFA2;
	Sun, 16 Feb 2025 07:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6CNLPt3"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8D7B672
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 07:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739690753; cv=none; b=bzMEv4lYsCyjup4pVSwKpPkfO3D0YqniRz4u7veo/j/PU4CjWZoZY2/8ZlURQOw1BeVsSSaXG78L/+uEuB42iSU+0Fxlo4ox5TYFAAkXuPv8IGVRkyyXg1FufkfT3bNeuu6L8l9+jD8Kl8PEewbyObXym7OCyETS1B+deW3Q3CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739690753; c=relaxed/simple;
	bh=uBmag/l3blKZ4kSZPCvO0tnh+oQWX4+LpAUKQHETcXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ibPEHn4ttzrb1aount0InYin83MThU5voSKbyPlVzLKbyTldNaOnUe+UIuU574L4/NfWIW8+PGl1rNeLw5PRQkffCso9H+obm1bZrYIb8bF68PUSCdw8f5kJkWi6BjZUEpj+nsrPZHKqOTUhZbE+pBnUwGyIHA3bm3pOe8Aknok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6CNLPt3; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3eb6b16f1a0so1039355b6e.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 23:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739690751; x=1740295551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X2MtFzYyeGI+w53HFhz70blX7wSMVkW9RRqxmsCmG4c=;
        b=Z6CNLPt3HWNbCF67GYOcKC5rzpyJHI9H6M0+orfNB9ddFFPjUDpxg73bLNrKhL9XKH
         yqWV+kQBfA/nge8IZmmaxWFVHBgRKHenmi35UokESuHmELpo+hXBH4YncnW3mN6MnGoj
         MCf7cg5dhX5ikAMwkKAY66/AsWRlmDNvy5Vc1VlFq41vl3s64CIfNQumPDdWbyEZmEIe
         ifpOKWEfnM9HtyNXJzcfYEalk7XA8Ytl1czlc9EbJQjUv0UwvPfSVmwMqcKFCj/dBN13
         +ASTDeF3tXgTBMPbC3JovC46cXfBlLtOr3dSwMT0JidS+7o0LZ4EqkIpAM0rsVuD/wtZ
         fdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739690751; x=1740295551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2MtFzYyeGI+w53HFhz70blX7wSMVkW9RRqxmsCmG4c=;
        b=sKa9UJvgzlL77IyliOv7w7jPL7PkqdVOuQyaAIEOuFw2yH7n12svJj3XMjcZJj9ID1
         YSa1m4Ms/9+WRnnjNlKQDJGuqjYZ+Hwtren3GCX26RW+Qf7z1ZRU2+GUYAnuuDrTF7ux
         pMzJ2RlUUKuhfVUnjhX6nxFMHFJQrf9WHcLH9mVn9NeC5E2IL8euZGjd3UAZRSIV8WNr
         v2KV2+D3KU9rZ5P24L8f/dXKZl8XrURrqQfyqoCf5cvaWdL11Lrfs/bWJgE2XXlEeH4G
         af0ibkSghgSwKpj9iCKpgnDvYgZf7m7GifIO9IMHgpi4/OfOJ4mhy9QHBJ93jQt2DWkW
         UIHw==
X-Forwarded-Encrypted: i=1; AJvYcCVDJzjfWFY5ik+VKma4+BXWs4cQni2m+CaaYAMrYE32L1fK+vgz8JHfZY6Di8OpvwFlbKswm/LN4SPgosM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgMCb63urXWfRegrjPVd2iUaUAj/vLTrkVPCDyty4BMSp6uKq+
	xSp6oNF2qnEPF3sp9CyD2U6Jkolvgs/KV0TtsAF7sRCRnLlrHMfn
X-Gm-Gg: ASbGncvpzgwj0htFuUI9CQ9V8FUVjdThib9vFfT+STtKyFqGm7h1BXzxJVusikbHIkD
	YSm9vSCcVrMfW6J3Pl5Wz+rgG7DYoIB9TXqrIdtdYvd5C4DdJPKbuaQw4CwArR1HB8mNSYirgdJ
	KfWgLD0Ab/kVLCNwL3m4NSL6z9FtecN3lYRreIlQ/TY5DQIAsZsqJLukfWRgoxSnNaDzL4FDyOA
	HI3FEDGHLaKCJ7C+BQy9vSuXArqE83di+x8AI6jCB/CNlJVJINrmJtz9QKBtNv/sJf02wdNg/se
	EY4WOiCNYzkCbBqMMsQCdb/7aw==
X-Google-Smtp-Source: AGHT+IEldSYRhKKvL+bF0zUKZ2HmbKXzdMRqJSuAGcuPjdAPT3c5bZVwGqGNztiB1tyFq27lo9WP7w==
X-Received: by 2002:a05:6808:2107:b0:3f3:1ca8:97b with SMTP id 5614622812f47-3f3eb122105mr3150386b6e.28.1739690750791;
        Sat, 15 Feb 2025 23:25:50 -0800 (PST)
Received: from vengeance.tcpc.lan ([97.75.251.196])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f3daa19849sm2467306b6e.44.2025.02.15.23.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 23:25:50 -0800 (PST)
From: Aaron Kling <luceoscutum@gmail.com>
X-Google-Original-From: Aaron Kling <webgeek1234@gmail.com>
To: Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Aaron Kling <webgeek1234@gmail.com>,
	Ben Skeggs <bskeggs@redhat.com>
Cc: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] drm/nouveau/pmu: Fix gp10b firmware guard
Date: Sun, 16 Feb 2025 01:25:37 -0600
Message-ID: <20250216072541.317954-1-webgeek1234@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most kernel configs enable multiple Tegra SoC generations, causing this
typo to go unnoticed. But in the case where a kernel config is strictly
for Tegra186, this is a problem.

Fixes: 989863d7cbe5 ("drm/nouveau/pmu: select implementation based on available firmware")
Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gp10b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gp10b.c b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gp10b.c
index a6f410ba60bc9..d393bc540f862 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gp10b.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gp10b.c
@@ -75,7 +75,7 @@ gp10b_pmu_acr = {
 	.bootstrap_multiple_falcons = gp10b_pmu_acr_bootstrap_multiple_falcons,
 };
 
-#if IS_ENABLED(CONFIG_ARCH_TEGRA_210_SOC)
+#if IS_ENABLED(CONFIG_ARCH_TEGRA_186_SOC)
 MODULE_FIRMWARE("nvidia/gp10b/pmu/desc.bin");
 MODULE_FIRMWARE("nvidia/gp10b/pmu/image.bin");
 MODULE_FIRMWARE("nvidia/gp10b/pmu/sig.bin");
-- 
2.48.1


