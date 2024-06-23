Return-Path: <linux-kernel+bounces-225937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D42729137D4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 07:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7B01C20FFE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 05:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16332207A;
	Sun, 23 Jun 2024 05:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d1urR37r"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4753D1DFE3
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 05:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719120462; cv=none; b=TXax7aTQGR1MnXPX4P4wfQet4YJ5XqNp3sRQyFfgVdRblpxGI6Y+RPFLOtz2NkAxEYa8RpFL0zG4vojgFVGzQ2eDg6mVZH/T9dJMLOtdLy6PBWXSJpCSzHkJhB4eNkWyBOj7Sk6I5/yrON2S9xyCD/C1aPxjUNnompuhB8lJ2zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719120462; c=relaxed/simple;
	bh=bUab8eZo5zd7axeNt57zTJfAqfjDozucTQKMhG84tSw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AWdcsYqe5G2FQ3FKH21cqXOaJ+YLfixZro677/WiAfjw7m9WTnrEgUCAJcwWn+/tsR0m1TrV/UChoBZFOcgvxVqf2R31MSEAD8nyri0J52+a6m9AepLyrd8TOh+vf0cAKz1M5Ei0SWOCGvsONFwuj1PEH6Mrl9KJXX8orioiHG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d1urR37r; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52cdebf9f6fso1091834e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 22:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719120458; x=1719725258; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LVAL5mslFEILc/7J/ilzR8hF7Wd9A0knVqrCwFF7a8k=;
        b=d1urR37rkqWEAxvI+G2Qc0TMVCfs+LDBqKtGaPyaZJM/7w7WjO0kwKk/Y/fg0MFc7t
         P3wo23RfLbEYRuP14EbTXxk9mdKicnA04QGj8PD5d20Q6I+PNkpYKhNoO8KrOjR0wXJN
         MfvDKltj2brGBfnQby19NxZVrwCfeteURfYBEOqrm8Zj9VK6j98qwrg8miS29FiqrYXp
         b+7lH8V+dj/b61e9XZntW8Jk1E4n4Q+v1hwliewrffHJ/r0KlIzZTlqv8gfga974/fng
         BxAWhpzCWgZy4Wnt/oSu2fegJm7C1VK3bAI7AVHW55ExTRNa2ZMaqL9gNohy0Jo4v4NR
         zIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719120458; x=1719725258;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LVAL5mslFEILc/7J/ilzR8hF7Wd9A0knVqrCwFF7a8k=;
        b=gzZt2Xr8grAmMREQhkcd177R+2pQ3kEPGQ+muuIPCgVMLJIwDObzJ1QueGK7LCSLLU
         3Kqfy8y+wrwt6qB4tXp3Q7huZyY5p6PVHNILan/z2ue1XRiJKEzjdy8h5xj1y/o0oIAo
         DrOetKP5wYkW6dyEDWc8li5Bm/F9T6W7DUPchX/jNxbKFNmAjfrCvwOFvgcLxE+sP28L
         xTjlHhUm9LddrUPNRuiuFEW9UjL5TZbqKCCXgBM8ERuKt3FsbNEVjjsscfyUQOv4zshB
         nAN2EohPVMtWktrAiLL1vJJY225nrNwGtyVIE7jnCvaMZ6x0EFUGypCmXEj1fP114sbJ
         JWVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ3d/B6A7F8tkmo4+ZrIepNJm7hZ5No/0Aanq+v/DWzrHr3a2kS9AobCbJZpbGLA68QCy2yLeagXEKSCXF9ofZK+lzFBAok+eojGLo
X-Gm-Message-State: AOJu0YyslOxxaJgZkexnbDOxCxyH4yutmqKwVhxYTIdKA8SFFi6OKmhv
	HGfuc+iVAHU0eT9kRbdt8yM8oiiXKsmV8XWKXPCVOh6UCC1iFth6Lxkybpv8010=
X-Google-Smtp-Source: AGHT+IEU3dRYcuKIxDZCaoumBhvHMhR5hsmhogChQ/yKxr+nuwKSL/e5bj5MwiA1Bx/1nKPuyNraRg==
X-Received: by 2002:a05:6512:1cb:b0:52c:dd59:6784 with SMTP id 2adb3069b0e04-52ce183c00bmr942505e87.40.1719120458160;
        Sat, 22 Jun 2024 22:27:38 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd6432006sm657651e87.194.2024.06.22.22.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 22:27:37 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 0/2] drm: fix two issues related to HDMI Connector
 implementation
Date: Sun, 23 Jun 2024 08:27:34 +0300
Message-Id: <20240623-drm-bridge-connector-fix-hdmi-reset-v1-0-41e9894dcdec@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEayd2YC/x2NywqDMBBFf0Vm3YE0Pij9FekiJtc6CxOZiAjiv
 3fo8nAP91xUoYJK7+YixSFVSjZ4PhqKS8hfsCRj8s53bvAtJ115Ukm2xJIz4l6UZzl5SauwomJ
 nF/Eawuz6NgSyp01hxr8yfu77B2jEylF1AAAA
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1068;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=bUab8eZo5zd7axeNt57zTJfAqfjDozucTQKMhG84tSw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmd7JIkQxHOJAfU5GQNKIRtya8MW/CuGqj9HEGw
 MkLtjzsA5+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZneySAAKCRCLPIo+Aiko
 1du4B/0SzvgMTO6mpyNVCqXIulJxkFeWxTc7+c3rJic556COfQByFQ6u1NMyE3tFVaUn5l+HLkV
 eFFObocMqlbzxkd2RE7sRxLdbr6P76hGaVjrwXs4s6E5/VplzcjgRikfLfqXGZLh8rX/Gg4fLRi
 Z4BPZwUuiYWp4XJs0ncgMmnZ4ZGGg2xQx8p4ovicyGfW8JI1qaHrdOe/HM3NsG1N2vxzTqeTc3w
 X/1yXwitAlCKHl8k3/cEPUSBfWyHBiQmmVeftefDENcct38Q1o7Xn6bWBqzmR/5tk04C7riFpfP
 OujDtvvsvm5LIa5ebgiH0GFXx11IjtA6q5AsguZJmYYlO9CI
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Running IGT tests on Qualcomm Dragonboard820c uncovered two issues with
the HDMI Connector implementation and with its integration into the
drm_bridge_connector. Fix those issues.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (2):
      drm/bridge-connector: reset the HDMI connector state
      drm/connector: automatically set immutable flag for max_bpc property

 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 21 ---------------------
 drivers/gpu/drm/drm_atomic_state_helper.c       | 21 +++++++++++++++++++++
 drivers/gpu/drm/drm_bridge_connector.c          | 13 ++++++++++++-
 drivers/gpu/drm/drm_connector.c                 |  5 +++++
 include/drm/display/drm_hdmi_state_helper.h     |  3 ---
 include/drm/drm_atomic_state_helper.h           |  2 ++
 6 files changed, 40 insertions(+), 25 deletions(-)
---
base-commit: 2102cb0d050d34d50b9642a3a50861787527e922
change-id: 20240623-drm-bridge-connector-fix-hdmi-reset-0ce86af053aa

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


