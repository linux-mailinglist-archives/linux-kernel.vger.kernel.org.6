Return-Path: <linux-kernel+bounces-182649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD868C8DCC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 23:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136B7285DB3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 21:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A7414265C;
	Fri, 17 May 2024 21:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QIJ/oLi8"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7A3142645
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 21:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715981869; cv=none; b=TgaixTVAjUKsjNjzYqnxbBQjPCLtK0BXNBlh1VsgTi4CiKd7ogHzFJxQgNkiqlnTF20aNJ4Bz62OT8fAMSHcc1p30qmvYhvSv9MknHo6R7P49fiOgj4YKKAn0Msfv0kqcv5+PNwAy+/bSKA+7Xt9tB+el0XTPCVqN4Mtofglh9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715981869; c=relaxed/simple;
	bh=hxNkIs6yfIKLDJk1aH9dnT73mR+5k0qkAL6JqA+tZXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SyGm/ZUvdcNdAq8XcqIRDhgc2Q2S8WXp3t9ce8RUgG/R8jvAtHKAt1K+1g5l+ygigVhFQdTvspy+ZdQycBhzsEHpQpq0lUW4nAzoDto4AFPaw3b5PQ+a94Nsdp6p+3e9sNDcx3dYTGiNXWOaZzS5nqYaKohg/67k7iexloPul94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QIJ/oLi8; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f4302187c0so1305066b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 14:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715981867; x=1716586667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMrmoliKPswHzuEojIBGChDP268r8lDTpqZYT1tgrB0=;
        b=QIJ/oLi80IgNec5P9027uUlrT+n1fmfUSmKT9hw1LMMP5GF8G4dtQkdl5CIfADAGJv
         9h2Kb2R0h93A0fNeUt0p3IAffpJi/ha840Hh+q2M2w3/etsGtHhfo74t0MSt/dx++olA
         PG2HGzO8D/zfVHA0LnWTgYU65wtWkDoT1KgNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715981867; x=1716586667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMrmoliKPswHzuEojIBGChDP268r8lDTpqZYT1tgrB0=;
        b=fy76wmgtgILEUS4Ob8oIht+fLALq7g1QCwTQ0kJvz3T5+LeJEaufYQqLYPpiVhEIPi
         0ZRBg40JuLFcdBdr5ggaVBksPxTjRCk54RKgyYgxL6NORfCHRZXYx7KN6VUAs26lw5ZF
         hI/pHcS1WynR1uyNPActM+wzRNaUja7vMgfMq7Us119XcXDgIu+6C4PWqTHRLhNwaXuv
         MOsRC4wOJR2VIl2kqiGtTxEvudBHyF2qm43JNNTH2gtDe5l6Z1zmNccBzTqTDNLj4T5C
         mdgtUXrvajtExtusid6IMbKZRSl9mIWrxnLHmFxTEtF8yeMwiJ8DpEoSNW5XxFSfcfos
         EFEg==
X-Forwarded-Encrypted: i=1; AJvYcCX3cF4HecwC5Xo8AiSTXlp6GBWVGHi6BeYu93MeFziuMJH3PHlquehquFH2eNR1SFEg6AgTt5svRYUXc2y7R+AVozMYdJzbJD/V71wg
X-Gm-Message-State: AOJu0YyKDabBxbDvhcH4B7sSy7SXB90d/h8Wx3Apqz733xcyaSs88dCs
	vJHQFVNvSMou5sI+3vFTCV6Z8xhYoTzNEJBI6EQJYDNdpKSkB8W6cmkynxjo+A==
X-Google-Smtp-Source: AGHT+IG0DV+RQTrF64BGZMxIPU0+NC5JzIe/lzMpLQ15ksBfa6Z15kVlWjTAgXqC398NIEA3infXfw==
X-Received: by 2002:a05:6a21:9988:b0:1ad:886e:ef5a with SMTP id adf61e73a8af0-1b1ca42879dmr436290637.19.1715981867162;
        Fri, 17 May 2024 14:37:47 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:26de:b1dd:5:771c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b2f8b3sm15168736b3a.211.2024.05.17.14.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 14:37:46 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] drm/panel: himax-hx83102: If prepare fails, disable GPIO before regulators
Date: Fri, 17 May 2024 14:36:41 -0700
Message-ID: <20240517143643.6.Id0659a80147cf51e0ebb8fe7fee18db86851960d@changeid>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240517213712.3135166-1-dianders@chromium.org>
References: <20240517213712.3135166-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The enable GPIO should clearly be set low before turning off
regulators. That matches both the inverse order that things were
enabled and also the order in unprepare().

Fixes: 0ef94554dc40 ("drm/panel: himax-hx83102: Break out as separate driver")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/panel/panel-himax-hx83102.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-himax-hx83102.c b/drivers/gpu/drm/panel/panel-himax-hx83102.c
index 1a6975937f30..4ac7f9d8b232 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx83102.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx83102.c
@@ -578,13 +578,13 @@ static int hx83102_prepare(struct drm_panel *panel)
 	return 0;
 
 poweroff:
+	gpiod_set_value(ctx->enable_gpio, 0);
 	regulator_disable(ctx->avee);
 poweroffavdd:
 	regulator_disable(ctx->avdd);
 poweroff1v8:
 	usleep_range(5000, 7000);
 	regulator_disable(ctx->pp1800);
-	gpiod_set_value(ctx->enable_gpio, 0);
 
 	return ret;
 }
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


