Return-Path: <linux-kernel+bounces-224756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D547912685
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07B3EB22362
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F331514C1;
	Fri, 21 Jun 2024 13:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="lyu+vL2M"
Received: from mail-ed1-f99.google.com (mail-ed1-f99.google.com [209.85.208.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D58E1EA80
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718975979; cv=none; b=buiC0BsbZUIP3WZgBmSSSSvsq2gN7LDUEV3pNHGThOLVMcLlYLSDDEJNV8fudKhhyfD2ZP+p3bu+NPwYERFxofASUBagXUG72WpJEitkxYX6NBTq+ScqjhzVd+Jn4Kv2czTBD8R8eq1DnqbO3RVCsvIHextDNfKgsg1r3FhUGyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718975979; c=relaxed/simple;
	bh=8phWsW4UQP4S3MsRvE9yMpzW048VSwveP4al4mLYhbU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sO9s4sk5leiky9fAPykyXFCdkjloR3v1cOwG5ICt3PtADURSKmEvJEkFtEyRa5dixkumlztKclQdxkQVIm9dy2QFsAGCk/nfki3pKgpYNlzd6jkQtnp8exFDYvncpvCOFS8kCC86L4Mut24ShUrIbaFZPWmDboH4Yph8wXI26RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=lyu+vL2M; arc=none smtp.client-ip=209.85.208.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-ed1-f99.google.com with SMTP id 4fb4d7f45d1cf-57d20d89748so2025880a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 06:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1718975975; x=1719580775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ywqgUozraqYshx47u4jI8RUlSAv6wf2P9H7IH0f1xAo=;
        b=lyu+vL2MekikVh7bLJkffBy4kdJHvVkpnH+HKbU4pOMWqPlwxZ6QeB7dfnKumCGDUS
         uGtuGqLrN36x/hgDqg/CfeBDsJvGJE3A4TUlovq23WM3r5LWZ91+BtvMFfjbAOA6ix7D
         pLZQPpfAPmsfXDxzjVw02WxaJXj0T+1wMUyGR6NZgQl2uvO7eQtG7/4cOba7ojjdZvtN
         bPuMn12MwqHcdZ54DSJQkobeYKBHtrWXL8HZUWLKF5m6qVXQjJKF6jP5abmF4SuAedL7
         bBhoIjjglUOwLWeFB0RWQmEDIGoC/JNdHfj1rF4UuOYbnNthIoJ80/fedpxkDjKftS7W
         cRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718975976; x=1719580776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ywqgUozraqYshx47u4jI8RUlSAv6wf2P9H7IH0f1xAo=;
        b=HnLcQlwVXtcfwPCBcc6wUnDrTX/rta9YxM+qUDxgw3Ul1lPECnEoTNK47nvBt+4OC+
         mv7qxNVIpQFeovgvOsicRq/HVaMJ4mEoR0qjRHmc4R8KN0BCPFtll9ij7mw2tT1OJkMu
         yWmopgFZVGFLlsZbk+LCzPvh0H0j2Ebot+ftq6os+2pJ4j3Job6/vHCBG7XCCZMnEk9b
         NIszPTVFppxw1cQS8j2TufhTTaght8mBw8oA+62g6sxweIRYpWjju8tB2fiPshE04JtO
         xqKHrPkwqsO/4nyufpaBSiegpf8C6r83n5xJ76Ww+lAOBGdflDg0BVUfK5XOxL/ceKa1
         Slvw==
X-Forwarded-Encrypted: i=1; AJvYcCVlhxDpVAj3+vP99zgu+TR3Q/4+QzTZFczAhRLKpuZImG1uI6HcVsr2pHYsurJxHCNFB5YhXbPIvjfkjiHSsF6hXdChZIWvsmC7BQzU
X-Gm-Message-State: AOJu0YydGjYgynH1M8o8AZ6o3f6PGIGpyEEmBdhRFX3fTuI74ZS4ysk4
	aCVxISJTgt/vtFQ0f4sR1NktSDze0pJtaOI1upej+yyLlUtWQ0mU5+G2BS8RCDLR2bQlnbMCmHM
	ASVf/V6Czfj4asG4mi2k3iunNTGL5Oyqy
X-Google-Smtp-Source: AGHT+IE8U46ju+ybrG/Rx2Vzp4N6v27VN6j8n+u25aLnXW0S9ZEwDZZhxgamy3ur/j4ffUnG/J7SLhtrZvnR
X-Received: by 2002:a50:c35a:0:b0:57c:4db6:c0fc with SMTP id 4fb4d7f45d1cf-57d07e7acdbmr4405556a12.10.1718975975405;
        Fri, 21 Jun 2024 06:19:35 -0700 (PDT)
Received: from raspberrypi.com ([188.39.149.98])
        by smtp-relay.gmail.com with ESMTPS id 4fb4d7f45d1cf-57d303c64c4sm28772a12.0.2024.06.21.06.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 06:19:35 -0700 (PDT)
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
Subject: [PATCH v2 1/2] MAINTAINERS: drm: vc4: Add Raspberry Pi as maintainers
Date: Fri, 21 Jun 2024 14:19:25 +0100
Message-Id: <20240621131926.3133484-1-dave.stevenson@raspberrypi.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself as maintainer for VC4 alongside Maxime, and
our internal review list as reviewer.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---

v1->v2
Changed the internal list from M to R.

 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d1566c647a50..8dabcb16d29f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7520,6 +7520,8 @@ F:	include/uapi/drm/v3d_drm.h
 
 DRM DRIVERS FOR VC4
 M:	Maxime Ripard <mripard@kernel.org>
+M:	Dave Stevenson <dave.stevenson@raspberrypi.com>
+R:	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
 S:	Supported
 T:	git git://github.com/anholt/linux
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
-- 
2.34.1


