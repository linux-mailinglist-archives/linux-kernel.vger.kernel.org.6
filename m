Return-Path: <linux-kernel+bounces-439709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A4D9EB2EF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96371881FC3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6921AF0D0;
	Tue, 10 Dec 2024 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iG3Hgv0h"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30711A9B5A
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840217; cv=none; b=iD8XsFQYqwY2CPVHCgE5AdZsBHXpl0vRtEYKU1+MPK1z4NaRPUl4QlqflsPnnII1wqOEmCVd362rGIh+Uo4TMIEesMHXv6MY4wzyIdY3KGL0PBCQ5UgPqWVUZ8IllmtJAlgtvI3n2ZxOxO+8Le27OUJ0bV2HZfprVHeZjpqrW/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840217; c=relaxed/simple;
	bh=rB/0Gsa/+27l3uQdwPdG65mhrhs66t5UJhoR+oY4WrY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pIys4Vi0L1yPF1jFdwwf/muvK4uA+zGBb9MWvxbipFUVibelQfTEyzJuC3Ek7ljTXqcDIw7i+WV7jCkT8jHo8jtu2cEy4IeWkrV6syC0Q6lPlHS5cAHFRxbqWhtG+6J9XVFWXtxXlk5MPVKv6rcscYU2omCVp+V9BkvEp0MFkAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iG3Hgv0h; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3f65844deso3709554a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733840214; x=1734445014; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6+crVXPu3DLH2LlYuBMFmzZfW/018nLXCNXzwVqSUhk=;
        b=iG3Hgv0hyDtaIBIfmFy2AFvJnuuKteWENrwLDocCh1RG4waWkHL00AgXb1joLHAASl
         7J3TKNLmBQf+27crlBnnHSm4KXW0oTZw3LhDG1pPsbEiECGzTgRCb6SN7tEGhOPFZSAw
         5Og2LUc+Dcwq6vvDQOxcBEkp/y9PglFcQyPAqPUXGbSAMkKe9zHzaKE/Vs97cnE2TZdL
         jBvQQE3PF8OkD6CCj/g5SaJxHuHRME0qhJTmymHVmpC4eaoyalg7C1V4ThHe3QHs610v
         JhfBxnKQ+IUK53zJNkXTqLh7wGg4CTiehmTu3sfmcdt7tVA11xzjCZsGjbWKZMHC77mB
         E7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733840214; x=1734445014;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+crVXPu3DLH2LlYuBMFmzZfW/018nLXCNXzwVqSUhk=;
        b=kYLWRl7lVWqrh+i//XdBt+pkBVFcq849L/4Yc8aeJbGOYPvJkBQDwHlDxvGayKNdp3
         Q3vm3rudwxr4Q4C87l/jvu1sxzhVCz73z7KcSej5L8stTqqbzXtDLcFygA9HzRUwozsO
         6dI7nSM7PHdWdeoVjqYQM8X1Cj9/wM8V83XqJaCOLuMw5i5ZOCN4aYZ9bTbTDEJKnJg1
         y+JiXnTU8ENgK6tvjSsoCejZN8gcj1lMW5b+hk7mZfpQZZgfmiF80pQRlTHKQhtW3syV
         1HCfXAqrBFSOPpvIrAQhEiYr+MAxfxdhABEPFAilcQEnti/RA72gSPOIXvACH+YOcFMm
         10pQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI3W1SDqBBOOBw9HOY8Al8/4PTsxJXdjTxm6VF4zQtpSyaEXvyWp5FTuBg5uHdY+jZxliAhR7XtjLzovg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0d9TmYcwDGRUL5G883TNJ0xk87Tx4idH/c9frNwBBZHk+g7At
	bzLQuJ1HjbsO7AoXX7YIUi3b5LEttYodoo3Xlvz2iIF9yKmfKUuWgJUxkAeBNdY=
X-Gm-Gg: ASbGncvIWTIe6tT64LjVlOZCqQxxriVkgpPNImmFfUqryOUqFShCWZYMl0SwLttJzFY
	7jmN5fE4gTCyzT463xZaq2kf3a18aHPTbA1N+WpIAdhq6qXTsRIYKJGMkBLfB+HeQLMDxY6URYj
	8xIVrDNdLZ7avP3EZGx3+lDogTry0lhB7XljXbkbxKQnUIwLT5OwM3J2kdaPVPwxMkjIvqKTTXZ
	LNtAlLPNXWx65yoqcg7a+/EmTTX66yaKO7f7KgJC9qJxn8tfHNnId4i3AvtLg==
X-Google-Smtp-Source: AGHT+IGxZHjKR5SCMI0IfbjDGhMhOA5BIzHnQ1eSiwRBGeabz2+uUXHR8Rsyhp3v0sQ66agXWWUdHA==
X-Received: by 2002:a05:6402:1f11:b0:5d1:226e:e3bb with SMTP id 4fb4d7f45d1cf-5d3be715252mr15513178a12.19.1733840214182;
        Tue, 10 Dec 2024 06:16:54 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3dc2602b0sm5104362a12.18.2024.12.10.06.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 06:16:53 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 10 Dec 2024 16:16:48 +0200
Subject: [PATCH 2/4] drm/bridge: ite-it6263: drop atomic_check() callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-bridge_hdmi_check-v1-2-a8fdd8c5afa5@linaro.org>
References: <20241210-bridge_hdmi_check-v1-0-a8fdd8c5afa5@linaro.org>
In-Reply-To: <20241210-bridge_hdmi_check-v1-0-a8fdd8c5afa5@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1627;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=rB/0Gsa/+27l3uQdwPdG65mhrhs66t5UJhoR+oY4WrY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnWE1SrdHcDpzN/kkXAE+ciWoTZRgyac4hMJI58
 4e4awoizfWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1hNUgAKCRCLPIo+Aiko
 1c0XB/4wCdakY+iL+5vJu8w6sDWGCs1YreJcnbtzjAEPWnpXIXQe9AtTgrQ7y8qGSCkS94VMf34
 WPn9zTT1BAhvOBqitBey1l0Z/m45w/2OirgOn8X/LJGqXRqGtK0mhvauVdMdfMZszXABfn/BQwh
 A8nuYp6UNxSTdqSudtixSGD8jZmgwOuGHd5ynNstJuhuW9e6S4sRlkC22M2ERLr7WNSFNukqNRE
 KFZ+CW76ORQdCjyTPmRe9ZE3nwpYwf9XQ/z+KfHgK664N6wg53/Nf/f8VkeDILhC68jlJApptwi
 lwG3uuOZwuujl2LZAyWkFqNu2qDVp6b6pOccFcxzDOKBDJ0h
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

As drm_bridge_connector now provides atomic_check() implementation which
calls drm_atomic_helper_connector_hdmi_check(), drop the duplicating
callback from the bridge driver.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/bridge/ite-it6263.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6263.c b/drivers/gpu/drm/bridge/ite-it6263.c
index cbabd4e20d3ebbe632a60f7cac73302815fab7d8..902444317d67e7a65ab05568fbe6f4571c500585 100644
--- a/drivers/gpu/drm/bridge/ite-it6263.c
+++ b/drivers/gpu/drm/bridge/ite-it6263.c
@@ -550,15 +550,6 @@ static int it6263_read_edid(void *data, u8 *buf, unsigned int block, size_t len)
 	return 0;
 }
 
-static int it6263_bridge_atomic_check(struct drm_bridge *bridge,
-				      struct drm_bridge_state *bridge_state,
-				      struct drm_crtc_state *crtc_state,
-				      struct drm_connector_state *conn_state)
-{
-	return drm_atomic_helper_connector_hdmi_check(conn_state->connector,
-						      conn_state->state);
-}
-
 static void
 it6263_bridge_atomic_disable(struct drm_bridge *bridge,
 			     struct drm_bridge_state *old_bridge_state)
@@ -793,7 +784,6 @@ static const struct drm_bridge_funcs it6263_bridge_funcs = {
 	.mode_valid = it6263_bridge_mode_valid,
 	.atomic_disable = it6263_bridge_atomic_disable,
 	.atomic_enable = it6263_bridge_atomic_enable,
-	.atomic_check = it6263_bridge_atomic_check,
 	.detect = it6263_bridge_detect,
 	.edid_read = it6263_bridge_edid_read,
 	.atomic_get_input_bus_fmts = it6263_bridge_atomic_get_input_bus_fmts,

-- 
2.39.5


