Return-Path: <linux-kernel+bounces-224757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B60912687
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F93F281970
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE361514C1;
	Fri, 21 Jun 2024 13:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="tOXJbW34"
Received: from mail-lf1-f97.google.com (mail-lf1-f97.google.com [209.85.167.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6101B1EA80
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 13:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718976013; cv=none; b=PBk8K0xqsb/K1fDcgnMgpUhnui+g4lqlCL6NAPJf868WOd3u6Vap2OJjW71hKwr9hTI79GnZorZbj1MMdiq5EGC9jM+Hj6X30iT4ak81cGJU6BW8Y8jjhs5uls3T5I1e7QXt4dV+hH4YRN/hEFoLiGeO4mM9U8+UejOgJfYRBD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718976013; c=relaxed/simple;
	bh=M466tMXbuxs22b9X0TogkzCirZJvukhHRWob2oukJi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gGQGGXfvSxendthwW6KcKA952WffdPst+O+HqwpvFZIrzNZYBalVrnWQzfHXvmvGEc1674TiIe9nl0LWwBLvPx1+ZNJUV7lcWDEbRGWFjz0HSdZvUxk4paKwwMHyarldgeGvl3BqF+S7W7QsC0Zzne2xLHfeKFo0pyU+o+gcdIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=tOXJbW34; arc=none smtp.client-ip=209.85.167.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-lf1-f97.google.com with SMTP id 2adb3069b0e04-52c4b92c09bso2775505e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 06:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1718976009; x=1719580809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5SWq4O+1fJQvBFv7KtItarRKM0S2vzLYLjmxEsd7wc=;
        b=tOXJbW34YFVMuMoe0/LLMbHlhJm96Iw6xn3lQd+m21w7775Ho5LNhr8TrCRUgVJPe+
         zFG/5pOk3NwvDGQK+nqwMGRdMtm4HzchIa2957jNiODlCQF8hDyjmBS2a0Yo8opG8fz8
         +uZiQO6MYniokATwh/W2WntIZ7OnZ5vG6d3DpfP8wKxBp8OODo/tqxDa1ICSnI5mUtdK
         H9pyPQ893IGKaUzK8G48zAZm1caPkaTp66JfuNtkXjKfp4zftcCKZmZ+v2W7ttm5Mhxp
         4jAQzJB3p6Xea3X3isSn2ui/QuwZ52dlKAvb6YyLDXeXdRO3LlMxZpFAX4Y1Lcnsd5e+
         fDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718976009; x=1719580809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5SWq4O+1fJQvBFv7KtItarRKM0S2vzLYLjmxEsd7wc=;
        b=FKA5oPjbMtOljtQ96hkP1/HhIUlVWjJjNh35pl0EFnobgABjSuSXdTXQcE0gdA/YIu
         5513ZlQgWoIu+QSvn/BToJyez1tg3T9S2KTH2UXGcZxs6wdzQ/KwqUC6WuYt/fLssc1i
         c/cT4jL89RMa8bLv0f6UEAtV5TXL+nlvLeuLyf8Bi3qRBZAxsuuIAGVvWvd6561JSOfP
         cVjVPGsN5mhAHDdwGszt5YLAt76CHyZrYzfZkf5IqGSCSlbN6e29EFezQADLIWIj8/64
         UANeMmFbVg5iVufykgcDPsTKqvGc9L53sR5vNhBwjFHe9RosMmDCbwlaKKZy/QDS7Wk1
         OEgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDtc34ySm+Y8m+8kUa/IpHMqlf74LD9yS4Kp1A1nz3BMpgDtwAmh6aOkkTYVHCD/jAsbaeN/QByrh43JLolEq/5LnzvMC72q5QZdTJ
X-Gm-Message-State: AOJu0Yzlkuq8ZdvqHlhcYtFhj1e6MDZtzZ+bug0sWC3IfUvyZP5IB0FD
	vSzDCyadYTGYXtDA9OY90G6zTsmlgVCYb7Ai+uJpnlqASVFtfeH17wbLtVe13+OcZ6JLLnuog0m
	AGRtcQVE/a9PETfjgLU1KIow03EwJ3jGn
X-Google-Smtp-Source: AGHT+IHqUZLsTLgssBIZw8iReEOCHqen18GXQqnxoCYS9aawC9ZkikLrQX1xkcqFEecfByHdZEABleDj8t0Z
X-Received: by 2002:ac2:5934:0:b0:52c:d70d:5ff8 with SMTP id 2adb3069b0e04-52cd70d618fmr1239567e87.1.1718975979306;
        Fri, 21 Jun 2024 06:19:39 -0700 (PDT)
Received: from raspberrypi.com ([188.39.149.98])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-a6fcf549578sm5170366b.148.2024.06.21.06.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 06:19:39 -0700 (PDT)
X-Relaying-Domain: raspberrypi.com
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
To: Maxime Ripard <mripard@kernel.org>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: [PATCH v2 2/2] MAINTAINERS: drm: vc4: Drop Emma's tree
Date: Fri, 21 Jun 2024 14:19:26 +0100
Message-Id: <20240621131926.3133484-2-dave.stevenson@raspberrypi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621131926.3133484-1-dave.stevenson@raspberrypi.com>
References: <20240621131926.3133484-1-dave.stevenson@raspberrypi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Emma stepped back from VC4 maintenance a while ago, and
all patches are now merged through drm-misc.

Drop Emma's tree from MAINTAINERS.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8dabcb16d29f..3fb03de446c3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7523,7 +7523,6 @@ M:	Maxime Ripard <mripard@kernel.org>
 M:	Dave Stevenson <dave.stevenson@raspberrypi.com>
 R:	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
 S:	Supported
-T:	git git://github.com/anholt/linux
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/devicetree/bindings/display/brcm,bcm2835-*.yaml
 F:	drivers/gpu/drm/vc4/
-- 
2.34.1


