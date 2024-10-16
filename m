Return-Path: <linux-kernel+bounces-368141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 582219A0BCA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08D111F22A2A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6BA209F59;
	Wed, 16 Oct 2024 13:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="VefHAbya"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652EF187555
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729086229; cv=none; b=GhPViuug/BEwXhb1r9UcNpGZctBXBXq8JyCCi88rijvWp08IlnEmKA60xIqKVtxMuZE4CKrzKfxS6KQtdAZ3fzH9StNosXU+QsOze5LRspBe2kgCi1uaIyIIPrpWuRYsb4rYdWwMlyu7VUBe7y6c8fyKeyfJEdpZhrSjZnBGmA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729086229; c=relaxed/simple;
	bh=KWcWN0Jm2eUdhtHlZSZFOhv8Zx+tr8YDUBPTLQTMBgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ftXQ5TiLtVxaCjLVR2sdhejlFK11JWC4GnREAJUdpPGqZ7mT5Y0waVCiwc822dPwIWuWuVlRHPu+AXc3hTLmugjTimWyebpxfGP//fRi8JqNEQTZMr9hr1RDmGQsjf0f0hhr5kmRo2Po0EV2GcnV3ppk8Q8h70wQUBXseCx1okU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=VefHAbya; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e52582cf8so2817856b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 06:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1729086228; x=1729691028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hPSkU20Itc6yAh+bZBbT2R0RT9oB/wml9mSdgooTOww=;
        b=VefHAbyajJ+EibY++LZu5yyNn8ulR6BdY4Xor9w+0ufoTXHxwawvH65ukuEch2Gmgs
         D4giuT05u9kSpUZ9VzhhX5V0nNeKJlYoU7YwZ0KMgYPYb34NR/LcuYtvESYJykH2cqDh
         yWu0zAMjnSJJsSO1+v8Ejr7/XR73n09RrvRyXPYTWx+DMA8/ischIZlALM3fMo6wTi07
         kmJlIPaOhBZLq5G5a47+tk8TQFm7/H9I0BunCss/tJR+1SRHEy3jxITB2d+UJBTlMnjR
         RULfdPFnO36GW0u7qDhNWewOC8akmqPiEt33zkobuFE7bmA0++KXjO4A0GmhgOdZOsAe
         QMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729086228; x=1729691028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPSkU20Itc6yAh+bZBbT2R0RT9oB/wml9mSdgooTOww=;
        b=beLiXN0R+ydBseBuyaodwWfJwjziFDqEjX8081ucLtYojgSGsZLurW7NkssipRtIgB
         lktjIQZP8m2PVM0TN8tEaRT08hZJFqFljQzZtGSnF+B92U1/5pX736GMjFAnvc0YLUQo
         NI7iwpWEiJu+a9YgAa2JkYerggfdTgJTgwDQ7L46yVXpAZDp6w90zVC2KzjMrmVy7lO8
         FiE9WAlDNaw40e1LU1ZtxTDWUkys3X3mWym9zd2AngMcoGfnoblq3RoadUNX6yyk4BAL
         G+GnDg6TIhbgMejfJfexuUEWeY8HsKNruT18I4c6zHv8FUM2X2Snc8UYLoOzp/JNSrdp
         dsaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/MnuMbyxoCQCHGh4RG+7WlwyFt762B4Ac1fNyqy5ruDixzqKJqJps5tlD1Ozj9xDDMxZGi9oCia7PLaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOFtBtwgcVIhx6A3jRLIFqe4BlSaya8G32WSf/I1Io+lOPwujk
	tLB8d+aC7WL6YYFDfTDNGNRLx4vkYefhuLxou8QKxKHcULgoB1C7UH8LQFqF5pc=
X-Google-Smtp-Source: AGHT+IE1Q+vPA30KNlMFxGEt9h2r7Mf4JtaF8VKYh5yzDNUyMZMQT+8Yyx33/wO8c5gt6uUjOIGAxw==
X-Received: by 2002:a05:6a20:d49b:b0:1d7:cc6:53d0 with SMTP id adf61e73a8af0-1d8c9576f83mr22762980637.5.1729086227779;
        Wed, 16 Oct 2024 06:43:47 -0700 (PDT)
Received: from localhost.localdomain ([132.178.238.27])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20d17f84e9bsm28977495ad.19.2024.10.16.06.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 06:43:47 -0700 (PDT)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: drew@pdp7.com,
	guoren@kernel.org,
	wefu@redhat.com,
	linus.walleij@linaro.org
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	skhan@linuxfoundation.org,
	linux-riscv@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] pinctrl: th1520: Dereference pointer only after NULL check
Date: Wed, 16 Oct 2024 07:42:21 -0600
Message-ID: <20241016134223.4079-1-everestkc@everestkc.com.np>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pointer `func` is dereferenced before NULL check.
Move the dereference after the NULL check.

This issue was reported by Coverity Scan.
Report:
CID 1600802: (#1 of 1): Dereference before null check
(REVERSE_INULL)
check_after_deref: Null-checking func suggests that it
may be null, but it has already been dereferenced on all
paths leading to the check.

Fixes: 1fc30cd92770 ("pinctrl: th1520: Factor out casts")
Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
---
 drivers/pinctrl/pinctrl-th1520.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-th1520.c b/drivers/pinctrl/pinctrl-th1520.c
index 7474d8da32f9..07f8b51fb294 100644
--- a/drivers/pinctrl/pinctrl-th1520.c
+++ b/drivers/pinctrl/pinctrl-th1520.c
@@ -803,11 +803,13 @@ static int th1520_pinmux_set_mux(struct pinctrl_dev *pctldev,
 {
 	struct th1520_pinctrl *thp = pinctrl_dev_get_drvdata(pctldev);
 	const struct function_desc *func = pinmux_generic_get_function(pctldev, fsel);
-	enum th1520_muxtype muxtype = (uintptr_t)func->data;
+	enum th1520_muxtype muxtype;
 
 	if (!func)
 		return -EINVAL;
 
+	muxtype = (uintptr_t)func->data;
+
 	return th1520_pinmux_set(thp, thp->desc.pins[gsel].number,
 				 th1520_pad_muxdata(thp->desc.pins[gsel].drv_data),
 				 muxtype);
-- 
2.43.0


