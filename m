Return-Path: <linux-kernel+bounces-538054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 132CBA49416
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C35387A33F6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23E5254867;
	Fri, 28 Feb 2025 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkY93gCW"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906B0253F13;
	Fri, 28 Feb 2025 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740732869; cv=none; b=ppyw2psa8n0DTuJvqYPQrlTz4Q0ifqLkRsZ9JywJEoFd4YYAfCuVhysT6Iw9j78N0F32/U0LvkyHtLj2hmjaedOMCMu8/NnjAlu5xO06JnDT/FdlQo8rrXKf4hBDmEArExmJuGDkDpACRqHGFup+SbFhx/4dZQwAFObwlTmi1gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740732869; c=relaxed/simple;
	bh=ZvK6C2oIFOBpbz7tsIqs78gU5UkTLIzkwpiUI4de2Js=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CifNkzHycDNIgj6mfXh64oVvsLL3fvxULftQ5KJ2OiTPIIIMH/tmZ+vo0bz+4ceAn7Fjonl+Ls2aOuYeRfyBDejz0qg0OEKTvqtN655RBjBmYcjuQdrCKV1KcE91ayXUVddOqCdYasZKc9nA2AAmHZA56jaUmEMsWYnnxyt30dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkY93gCW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4399ee18a57so11930905e9.1;
        Fri, 28 Feb 2025 00:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740732866; x=1741337666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4PU3VROE0VC3jFwJOOb4ASIIAwndMW9ZvNWHPQLq2Hc=;
        b=OkY93gCW2s85y2Zw2SCqr9xrdZ2PFfGwYfNDDBAyiefuixoUP4/XS/CXaSUvbXKsm3
         BxDYqkpSjSV7/TbBms1O/70qCsB4/xjUkkEGMtuk5zlA5CA1roHtQlMlE10aJrOQePu6
         h+X00j4wkR5z3SGjKZYkByR2j+OHtdNjU22r1Nyq8VV0FwboDo5tEz+ieVmPpUk4jsLZ
         NUwqkJXkjNemz3JifF8P003fmnvTsLVF2lbHTA/v1Z4A9zVm5sYFNNAB0YAtyJaiohbQ
         BN7Wf1So3GVX+/mVXLCu3/gmuzx0+jYzz2RrZB4nkX8pR+rct8Wf8hBR9TgczvdPa73T
         PH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740732866; x=1741337666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4PU3VROE0VC3jFwJOOb4ASIIAwndMW9ZvNWHPQLq2Hc=;
        b=YUS/9axDljZ0l8mundNFGcZGgsFczl5R1jsvW954+WnM+EP4wsUb+28e/jUS29ODZo
         6oqQbbzzH24Yh4hC+LDKcnM42N2pl0FtSTsUhqYzB7EjbYGpbqZNsC+Z0lElQiFlGYi2
         molEhl8TqSKIFbnk7dVUH60S+ntls0FhJuIpm07QAQW6/00+kUyAQbemTe0HxUkHc4/J
         GlvHKoSxWb9m8EdQ7Dd5rHwsB1CKmqBJ+bPJudnMUQ8OJjZYZYJE8x8hDOM152+mqrji
         DiO8hFLKom4U6T9frmYqsDzhFZgoS9RuLVxXpTymz+PKFwoAcbJ6vxYhkXy5139uI+X8
         E11A==
X-Forwarded-Encrypted: i=1; AJvYcCX+9a/A+FQkBejji7LY8wtrdicZaHQdZwyBTXe6S+xxV41pwYYoa/ivNg3R4SpF3kOMkybr4Q9f0njrags=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyD+6IOkiuHBb6z/kxiBcfa2NKHz0wsWC410cHUZgNnrIWKBPc
	IM+ZmgTECie3+DJVssRSIQb+BpkLHZgQDYdAQJzzUTs1RklxHj91
X-Gm-Gg: ASbGncuwAjxwjNPntA3BSOC3aW65rRNGB8YjVGD3dF1CgIf0frpMGXhSViyo7GGl0/Z
	Hf797Gg4oT7SLcxWn20iLeB6lXJTLA2acpah8kl3eV8ufk0Vg6TZaPGIllhMWM1Ljg2KbsDQ87O
	qjsdGKtDZIdm27YchraAXV9jwd/mW3/UPC7VOzAafE8CKjo4f+GwRWCk8GxDXUXDs0BF1J3YAoM
	+3ISP8N9tFb7yVeCTOuBSnud3R8qaQLLDDDuV5EW8RIhC361Ey5b4dCk230lm6p09EQ514ElSE8
	zURNM3ivl0f2s1QDlUNREnBqUrY=
X-Google-Smtp-Source: AGHT+IFdN9QWjQoWfvRrcmLYLHSNfLWzrvfKg1j1asn0+L35lErLU+3cgXYWH8XIqwOdFUt4mobwmQ==
X-Received: by 2002:a05:600c:4193:b0:439:9384:7d08 with SMTP id 5b1f17b1804b1-43afdd934eemr55383815e9.2.1740732865675;
        Fri, 28 Feb 2025 00:54:25 -0800 (PST)
Received: from localhost ([194.120.133.72])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43aba5871d8sm79843175e9.37.2025.02.28.00.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 00:54:25 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/connector: Fix spelling mistake "provded" -> "provided"
Date: Fri, 28 Feb 2025 08:53:50 +0000
Message-ID: <20250228085350.678446-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are spelling mistakes in drm_err messages. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/drm_connector.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 5f24d6b41cc6..9cf347f70643 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2525,13 +2525,13 @@ static int drm_mode_create_colorspace_property(struct drm_connector *connector,
 		return 0;
 
 	if (!supported_colorspaces) {
-		drm_err(dev, "No supported colorspaces provded on [CONNECTOR:%d:%s]\n",
+		drm_err(dev, "No supported colorspaces provided on [CONNECTOR:%d:%s]\n",
 			    connector->base.id, connector->name);
 		return -EINVAL;
 	}
 
 	if ((supported_colorspaces & -BIT(DRM_MODE_COLORIMETRY_COUNT)) != 0) {
-		drm_err(dev, "Unknown colorspace provded on [CONNECTOR:%d:%s]\n",
+		drm_err(dev, "Unknown colorspace provided on [CONNECTOR:%d:%s]\n",
 			    connector->base.id, connector->name);
 		return -EINVAL;
 	}
-- 
2.47.2


