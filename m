Return-Path: <linux-kernel+bounces-382247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B102E9B0B7B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B80F2826F2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1532D22CC7D;
	Fri, 25 Oct 2024 17:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="nscASpWN"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E248A229B5E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876598; cv=none; b=CoDWmytLubu6HH6y+dUL+eFjcsF1lw2S5v/Yb4LciDoDbJmSTKbBretUZEKJknd+DIXh1zCkHDpPGP4Z+u0Ti41Ow/khKxAb5J2rP9zBUczWd7XIJF/nA5vkY2RWHFI6HhUxa6jzxDhH5FS25wOLlw1pAe8ZIstDdoEQHtAtPTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876598; c=relaxed/simple;
	bh=SjVwsOGppg/2aMc/EjblXpBI+5dLiqOiAgVLBX/FLjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ufGIUMQcpbtOyq+sMe/xAYWaUrVyPbjOlxY955lMXHeoDDqugXN7xyZyDfRJ9gfKWc/rIo3UlPCbC6NNAcsO+8aleUEyiMUiFt+13JH4AAVRqQKq4YrfMlqxjGR10oVivpxoYNrefcSSGF51fGe0QObVIdb8JBitY3FHXUwu1+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=nscASpWN; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d518f9abcso1664434f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1729876590; x=1730481390; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RbWeszNg1J6sxJWK/VxJPpcVrMqaA756zdsXOCwMWo8=;
        b=nscASpWN62rI3D3OGjJsawD0pakTkw02JI4PNGo7mhlMvdQI9GNdxKlfxn+iCFzikT
         vIPkqzaVmlOqvfa0vJH/6bSWvGkdANytMsXaNrAuMjQjhfW7SJXOiWnB9hxyrZ/s8G6m
         R2wHQghhb+raBag/Bb8o2OzYqatNWOEY4UmOz7lpMPmFzaQMA4FFAJIfWpVB5de6trfv
         AXQYnWrfcWN4mcSY7GL1Rk2FQO/p8NBQqL0qyaJURh7Tv2s4U6op2aTQkiG01eV6X/+b
         dn4/X9r778R6/vHdBp5wDVUe/Jd3VUjXlig8cfEYiuCDnQ71TYVGFy/twA3xlj7g7vSk
         uZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729876590; x=1730481390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RbWeszNg1J6sxJWK/VxJPpcVrMqaA756zdsXOCwMWo8=;
        b=ezcR1MnhniJcOSZ2svGygyPQa/IycfSOlLiz2K8kpbR317j+M+gCHgv6Cv0LASKdMR
         fZRl9aqmi+I5/oyvdpFnOlZB1YgcXWR10wDx9X8R0dl3lebqHTFyg21M99Y9VCSdMG08
         YtNU4VRvtOkpdwBaAEofrg7Fs5rhbHuWmkDhj7Fllv0iXHtmUQH1nGs7qvEw4j5H9Lx/
         MssLrf3ZdJJIwjaloJjpoG8NeBSRQH7+rPq/FgIl6q/JxFsBDh07cYdkY6e9DN7/JbkN
         l2/E7RMWw7bPgw4tKIl0WG7+aTzjf+GKCWj4XIbV5NOPn2oHQsrja9e9BjLfdU550Il7
         7UgA==
X-Forwarded-Encrypted: i=1; AJvYcCVgk3jELe9ldwa+wKtQOTNSJTXG1kDISmB3m7tCSfid6N6crWVzO3k0NwbDBDZks14SLpSaQtd/6DRFBC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxecEoNctu+mGOPcOq6qq+gDr2OVoqwBpiH/mfSqi9kYSI+Gcoz
	CosoN4EBYrtOlnm6HduText/4QvxSoq/bqQKmGg7g4sHAZlZcZ7NR+VRQ+YqexA=
X-Google-Smtp-Source: AGHT+IFzLQpTgUQ1GGNf1FFbit3NR6SLMLyJmHIlrv1yJ02k6Akx4PaydsdQXONZLxuVWGUKuRmYsg==
X-Received: by 2002:a5d:5224:0:b0:37d:53dd:4dec with SMTP id ffacd0b85a97d-38061137a3emr110320f8f.15.1729876590408;
        Fri, 25 Oct 2024 10:16:30 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38058b91f50sm2013649f8f.94.2024.10.25.10.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 10:16:29 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Fri, 25 Oct 2024 18:16:01 +0100
Subject: [PATCH v2 30/36] clk: bcm: rpi: Allow cpufreq driver to also
 adjust gpu clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-drm-vc4-2712-support-v2-30-35efa83c8fc0@raspberrypi.com>
References: <20241025-drm-vc4-2712-support-v2-0-35efa83c8fc0@raspberrypi.com>
In-Reply-To: <20241025-drm-vc4-2712-support-v2-0-35efa83c8fc0@raspberrypi.com>
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
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Dom Cobley <popcornmix@gmail.com>
X-Mailer: b4 0.14.1

From: Dom Cobley <popcornmix@gmail.com>

For performance/power it is beneficial to adjust gpu clocks with arm clock.
This is how the downstream cpufreq driver works

Signed-off-by: Dom Cobley <popcornmix@gmail.com>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/clk/bcm/clk-raspberrypi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 6d5ee1cddded..d374538e7108 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -156,7 +156,6 @@ static int raspberrypi_clock_property(struct rpi_firmware *firmware,
 	struct raspberrypi_firmware_prop msg = {
 		.id = cpu_to_le32(data->id),
 		.val = cpu_to_le32(*val),
-		.disable_turbo = cpu_to_le32(1),
 	};
 	int ret;
 

-- 
2.34.1


