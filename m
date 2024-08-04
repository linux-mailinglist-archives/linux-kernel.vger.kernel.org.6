Return-Path: <linux-kernel+bounces-273942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DEE946FEE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 19:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A49971C2091D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 17:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C658174E;
	Sun,  4 Aug 2024 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9cc2H4O"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612FB2AC29
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722791169; cv=none; b=mSX4FCyHjqA8El0PVk4JirYKL6fOfUU137XZ37xxfuAhY2k2sVud7soP4J/jVKcLe9fea/ST8Xv2yfooRL/pqLS1DO9kdsJwUP0Ez/eJukn5a8G/bb1ObeZMbSnTb1md87lpw14YRJl/4jODTHjTfPcufxBrreWASleOZp+DwlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722791169; c=relaxed/simple;
	bh=2hQvWC1WZX0lluA5y5jZIG7NCCsbYC/Q1NN4eMO7reg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UzuiXpc7zIJIqUybRRbSTp92ArdnIojPOPOFKnlEMYswi9GIBwiKIObJGczRlV9M5tuOEcnHMxVL1ADN4rGYBXJ0yPSADvMFrMEr6xiC/PHF9KWGOCjCRW7Vavsp5MQMRjqAqBxshiJluhKv1s77MTVsKeJUPPmTkETgrY/yhXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9cc2H4O; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-428f5c0833bso2319175e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 10:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722791167; x=1723395967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4PeGkAqwlK/5hc67fq6/8GiQEA+H64FAGEN/Ha1SuCA=;
        b=g9cc2H4OUXk0hyRcdnvPGC0sD7Xh+LVLRwptYrkgihiiIZAelDOgJsAhhqtkLE57hl
         66YBojFypbl2zm+G/GyL+Z4E+jUl6ZrPPJNgse8eAYB2UmUwbExbCbReDbooVCvcTo6T
         IJIVZcfHuio71INb7a9bHZqWlPrXSILavH+wy6uIGM+hI0Vh/TXd//9JFQp5z32pCK2I
         Oh0MLS8wqFC/IwnWT17SZBkKCemDnVieAvphNBa/8YoaXLMLDRaS6NOVcFEajJYu05Bk
         i+kyjXuv4zw9PrSCPfKX3gVuYjS0mSe5l8ugd3kHrp4iv1XFgmLZBk+a+1JzHwgO7JVH
         vu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722791167; x=1723395967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4PeGkAqwlK/5hc67fq6/8GiQEA+H64FAGEN/Ha1SuCA=;
        b=fD0fEd2nwLQ+K0Fpwi4DIVwDkQF9wfMoXimRG9dHTGBBFp3pmz+ylPLg+62jpcuzdm
         jyywsbbwPo6PrdSnNO2efWjLpTGDoVPCJ7Xd8Ehb3S+ChEF0IqVdpACzxQ0a7n3e580s
         ITsY+iuJaWDL7fOZFF6kfbGcDetXOng7lTobSEFjlQVruThLyyR/ZvBiEbrR9729ogSg
         A3EA0QNKSOqc4d4CtDeVDm7yVsdsexqCDKxnzGH88eFxUtVUag83mZ9dqtMfuwzO/RJr
         UK58W0CtFuiFszMSdCBy3jk9VK46yH1UwwPX/M8Z6+OZN68PJKrrubDP4iNwIKssOkbe
         GJog==
X-Forwarded-Encrypted: i=1; AJvYcCWGJLXtTIuNJgMUOnWI16yK97Ua83XMDVVJx+EMiT3jJCv3ZBGVi5lj/aNAiAWt9BUTrOflWWZRBzl1zyX1hCXceQ20vxFA3G1T8j0E
X-Gm-Message-State: AOJu0YxlhRTHqUF2geDE9aSqzvWI7jBpeL34FA/MWo2FuaZJABx4cUHa
	z5T+SMLFNjLYgtKvxz+o4Tzhw/z7Jhc3RlGNrsW/Bl//1WIBL5Pr
X-Google-Smtp-Source: AGHT+IEgVvrEgv7hcfvABXrrT21NZew/QZfcRx3nbNREQCfAWCnsVnqz+hurRUO/dy28W87dIgWm9g==
X-Received: by 2002:a05:6000:bc9:b0:36b:a9e8:6b5 with SMTP id ffacd0b85a97d-36bbbe3f759mr6977726f8f.10.1722791166290;
        Sun, 04 Aug 2024 10:06:06 -0700 (PDT)
Received: from fedora.. ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd059801sm7424502f8f.83.2024.08.04.10.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 10:06:05 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: maarten.lankhorst@linux.intel.com
Cc: mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] drm/connector: Document destroy hook in drmm init functions
Date: Sun,  4 Aug 2024 19:05:52 +0200
Message-ID: <20240804170551.33971-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Document that the drm_connector_funcs.destroy hook must be NULL in
drmm_connector_init() and drmm_connector_hdmi_init().

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/drm_connector.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 7c44e3a1d8e0..292aaffb6aab 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -426,6 +426,8 @@ static void drm_connector_cleanup_action(struct drm_device *dev,
  *
  * The connector structure should be allocated with drmm_kzalloc().
  *
+ * The @drm_connector_funcs.destroy hook must be NULL.
+ *
  * Returns:
  * Zero on success, error code on failure.
  */
@@ -474,6 +476,8 @@ EXPORT_SYMBOL(drmm_connector_init);
  *
  * The connector structure should be allocated with drmm_kzalloc().
  *
+ * The @drm_connector_funcs.destroy hook must be NULL.
+ *
  * Returns:
  * Zero on success, error code on failure.
  */
-- 
2.45.2


