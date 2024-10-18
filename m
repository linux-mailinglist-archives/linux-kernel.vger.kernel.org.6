Return-Path: <linux-kernel+bounces-371696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E82589A3EC9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847FD2821C1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772FB1F4266;
	Fri, 18 Oct 2024 12:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z5AWc95e"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06071D2B0E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 12:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729255787; cv=none; b=nJW1RNBadIsmfjCCQwslPQZ96RCIqPGoZFjbD1AnpGCMu3dphGCnvJfq2u6edU60MQWbsN9LXvLv/UAIU1/LnBMFgUKSgIm8m7+ZhYzCOo9V8BB/65EqOz9HnfsUSEkqUAspD42UvA4wM7T4YP8wNuZT/UyF0iu+HWd6KrswykI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729255787; c=relaxed/simple;
	bh=kfWulNWqB4gXHg5uFx3b3lXmDfL4uoz1uwfWItgVKtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mL573Ms6jWkXLbIu+Ua+PTTwN2JrAH9P2wcUbQGx2n52nBosqenwAYGfzFdfRICzz79pLKhzQHmrT81CpzyykhJ4fC6nggEkYhEvatcvU01Tp/N/+pWCZR7goWKRrVpyxiNnQM+7C2Jgnlra9PZNqxe2X5HdFfpl7YD55SEsXEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z5AWc95e; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d49a7207cso1482145f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 05:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729255784; x=1729860584; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wNoX5IHrzAxgidozBILlAFDudMpJyA8374WuU9SBpdg=;
        b=z5AWc95eFTJfH/KhqSLCljE64Qui0xi545Wq5CT3+PfW3GG39RGb6w7FrXkSMoPpB5
         18XPVBxrySrTUi48iSF1S0LThrzCRlpJCISfGeZjbAhKPHoLqH84Ug4FddczvRF1ZQXm
         475Qe3/Ker4UJoODLyUxQ6c3CktZLiNaKmi9s84EpZvQvwVeGx7TLT1cW4IMD3BPnxdB
         V481476i85Vv9CeVCtvUcaxBGQeC/PRLh7oD3zS9a7CNoYL/Sa6m7tz5cCrYe8siEMzX
         oh7+eA7S+Wo1W0VwKcAuCrC8hf1CCc//OhuShKFreBnFPJgkRRh0bMelrfUsNGTm8bUW
         Fcww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729255784; x=1729860584;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wNoX5IHrzAxgidozBILlAFDudMpJyA8374WuU9SBpdg=;
        b=JKbpj0IAWOYP9ts8rUx/P+E1Rp32kV6XaSkpKxuUPsUOtUqlTnhFYnmMzgjgt9bV6C
         BcNgE+SGMIE9rdxTz/HLpie5S3yeW9HY0V6cFE87RJdcBEXNpXJDKYz3e4xgxNrog+CH
         kPTdTMVn3kR6VJI3x4/TrazoqLuoftZYJAyD1r3vsE7BFlRqN64dwlrMem8c+1bf9wS4
         qcfoA9PCt0+MVTSPO/iY9nH0LHOoUeDYLwBgIcWPI8h7mMZWl0v3T0Of47c46C678sgt
         60OLg+qjFaF/cc2zULkXptGN3MqvW6i/wstrXGVnQ7CR6F5RJ4WqskMSnYTMEFkAorTt
         F2sg==
X-Forwarded-Encrypted: i=1; AJvYcCVj/D8bKABhe3nHLDmgUhOBpDQp1ENl3yygK1+rVwS7z8c7YgOrDobIdlimVByWdAc2Klw1XZ1sKT4Vzyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz78Wqn+u+y1EdivITw+q0hwQJIPVSKffiXKfCmgcrL/Gy4YVjA
	F6nA3RXKDiSFcUx2lwGQQ47Mf+oz3b41aOuhpSh6CWKJEG4CSXA3xBKI7L4lSUo=
X-Google-Smtp-Source: AGHT+IE0g5FUhbZpxx/i7vohMC6D1yREIsPBdB29vyxyl4XkKH0dXnNvgXo8WwLLiI1oQb6uoUq09A==
X-Received: by 2002:adf:ffc5:0:b0:37d:5338:872c with SMTP id ffacd0b85a97d-37ea2136f6emr1545159f8f.1.1729255784024;
        Fri, 18 Oct 2024 05:49:44 -0700 (PDT)
Received: from [127.0.1.1] ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316067dc56sm26751725e9.3.2024.10.18.05.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 05:49:43 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Fri, 18 Oct 2024 15:49:34 +0300
Subject: [PATCH v2] drm/bridge: Fix assignment of the of_node of the parent
 to aux bridge
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-drm-aux-bridge-mark-of-node-reused-v2-1-aeed1b445c7d@linaro.org>
X-B4-Tracking: v=1; b=H4sIAF1ZEmcC/5WNQQ6CMBBFr0Jm7Zi2gTS68h6GRaFTmCitmQrBE
 O5u5QYu3//JextkEqYM12oDoYUzp1jAnCroRxcHQvaFwShTa6UtepnQzSt2wr68k5MHpoAxeUK
 hOZPHpjdEtlYh6AsU0Uso8HpE7m3hkfM7yedoLvq3/qVfNGq0vW+sMl1XB3N7cnSSzkkGaPd9/
 wLdUh+W1QAAAA==
X-Change-ID: 20241017-drm-aux-bridge-mark-of-node-reused-5c2ee740ff19
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Johan Hovold <johan@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1833; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=kfWulNWqB4gXHg5uFx3b3lXmDfL4uoz1uwfWItgVKtM=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnEllg/6+luv/EDjB6p7bP/2XwiFNKKUBTqWE/k
 gyey9MA9L+JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZxJZYAAKCRAbX0TJAJUV
 Viq2D/4ogi9WzQdFvO605u37JteTykuywyIuZKo4ul7KwGW2DSVO7LZ1vaYl5FU9HiS/EBcv6RY
 bah13DqPLIq88p5509alQOJbS2wIRVDYywa2NbUR0ZyVFQbjzWXpvN/8Du2K6F8j18pnnvJLXIE
 9os5LVxYeBjawUIFuDvdt5MUj1vxpYrdpcDtG5LCfKus6vjET03/hvebfcNx2tsNp3aeZR6F90w
 lWt2r833KeBE/QCFdUC0eKtor3U/rr8cQPKpDI5XhuJXkQsfZMVErhk9aLOhfQAGtP6Gy36t++u
 uBkQ4OAPSGbGkdqfSAP7ZsScfKEm0veOjXLUdsYkcUknoizIhlRgZjQ8sYi7WU1lrfUE9sFrhAX
 Hlf63ITK382waV1tQd9zd1ylpQJhetrl64HyYLNwXaenjtHoPL/Vi1jX2YX3EbQBNRKDOsI5ir/
 dWQNJLeRy1exV6vQuaE8jlceCe795hDdGL26FvHce9QP7sLVfkvRbDQkcySesq9MhpuAGHaQ8ZQ
 7bwXCHdyILO9dTa0U1//fMaOpmsruQFnqte+buQpTi4OtjKaXCj2hyG+ils+9O7FfDMa8YDTh02
 YpRNb5UOxLTKJdbcW05MWShGfs3gUtpJ6W/Ep9aaulkt6WYvwESX99S9O+uLKZVd/QsGrkuDYs5
 wK1rlN6/xHnaHMw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The assignment of the of_node to the aux bridge needs to mark the
of_node as reused as well, otherwise resource providers like pinctrl will
report a gpio as already requested by a different device when both pinconf
and gpios property are present.
Fix that by using the device_set_of_node_from_dev() helper instead.

Fixes: 6914968a0b52 ("drm/bridge: properly refcount DT nodes in aux bridge drivers")
Cc: stable@vger.kernel.org      # 6.8
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Changes in v2:
- Re-worded commit to be more explicit of what it fixes, as Johan suggested
- Used device_set_of_node_from_dev() helper, as per Johan's suggestion
- Added Fixes tag and cc'ed stable
- Link to v1: https://lore.kernel.org/r/20241017-drm-aux-bridge-mark-of-node-reused-v1-1-7cd5702bb4f2@linaro.org
---
 drivers/gpu/drm/bridge/aux-bridge.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/aux-bridge.c b/drivers/gpu/drm/bridge/aux-bridge.c
index b29980f95379ec7af873ed6e0fb79a9abb663c7b..295e9d031e2dc86cbfd2a7350718fca181c99487 100644
--- a/drivers/gpu/drm/bridge/aux-bridge.c
+++ b/drivers/gpu/drm/bridge/aux-bridge.c
@@ -58,9 +58,10 @@ int drm_aux_bridge_register(struct device *parent)
 	adev->id = ret;
 	adev->name = "aux_bridge";
 	adev->dev.parent = parent;
-	adev->dev.of_node = of_node_get(parent->of_node);
 	adev->dev.release = drm_aux_bridge_release;
 
+	device_set_of_node_from_dev(&adev->dev, parent);
+
 	ret = auxiliary_device_init(adev);
 	if (ret) {
 		ida_free(&drm_aux_bridge_ida, adev->id);

---
base-commit: d61a00525464bfc5fe92c6ad713350988e492b88
change-id: 20241017-drm-aux-bridge-mark-of-node-reused-5c2ee740ff19

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


