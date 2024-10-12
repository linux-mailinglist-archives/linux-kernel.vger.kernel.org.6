Return-Path: <linux-kernel+bounces-362134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E42699B17B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EAD01C22581
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 07:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73C213C69E;
	Sat, 12 Oct 2024 07:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U65mgEZc"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0618126BE1
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 07:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728717576; cv=none; b=t6GVIctpkan3b62D1mQiMK+A71Vu1ReLFxvaADzyHYzU7huuuqlbjNKtjJuMHdozj0fBG+5RJWbB9kcLY6RNt0mnF8R4Nc9G9oop/XKXw0cHC8KnZLOaCA2RT4MRedQSAdItiWNHBpCvK0KeesLwWjkPF0fWkv3M4yA/yWLD4Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728717576; c=relaxed/simple;
	bh=9BaYrpOb9M5dH726NtlwvslGIvRQOUOOk1wKuJT4/5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JCERpUuPe429aVAopBGMIso0TB5Ktv4quhVjDXCk8B6aJR1Vj3VbEwKjgKLT81rt/N3PcZzjwyV6rY1T9APzmlB9EMRVkj/x/PP7bjpm7laA6sATQz431ydM3+LMJP0IT80phGg5jvwPHc4FxUMUo7ahZGLm2VN68dKuK280/MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U65mgEZc; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e038f3835so2510894b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 00:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728717574; x=1729322374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GOQ4NtOCWS8nSrxgzexiRJdXVz0d65HDBa8KjfEVHbw=;
        b=U65mgEZcPWq3fSzFOeRlJahp3RS2LwhcrmHgxXgeilW4Qbfx5bXfwO65ElY+kfRrsk
         BDK+MjfRZHzX2puxhSKG6mQfyU0EA/OtBzNSw5TmA2GUYIsa761IhJjdjFMQ+QKMGTBm
         tHuuJxhwkiIitSA4GaHmdTzW9bj+/ax+NURNE1ZOvgJNYvAG7ZEFcMDffx+ZDWrb5kYU
         u/4U3oC+rJiAHo4R0uylUg4o5M+oKYG4wn8fxKZp6oSfSN6fnN5FzK7tU1w0nB5nEvx7
         ZRfJZa8K6h4OWKRtKbNY3Ic81CvNdVpyLINacGR3Q+wAKUudAzjcngheruHYT+Q/WQ//
         CB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728717574; x=1729322374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GOQ4NtOCWS8nSrxgzexiRJdXVz0d65HDBa8KjfEVHbw=;
        b=XgSLAwSGxrZYpGZ7Dptang47TvkQOEigCoq/SSOqOAgW81aiER6AuU4mM1PZskioAF
         DEAFNrMnYtCu2wUxYFBK2HrwFC9WYkjYGrUzho5Ycwe7/W/AWQH2G/RVdCMe3mXB3CJy
         gmAZaWY7dtGQD7sIgNpS0KqrOs9c1obpykUgSalXV4PH153s8FEQ/SsCkHb9Y00BqMmj
         Jkj5pyFOPRIcShJNLaBVzoQT1Rg96GP2EThQ5qABRHmYpVNplaiY4idG6UUF7ggrLizu
         c0fJVRb+fBbobitQTql5Z2w4czbTIMd2rPb25g6Qfpv6jSgX/EGwy6aRMLrYZVAghQbK
         UvKg==
X-Forwarded-Encrypted: i=1; AJvYcCUx9KegmhJwkY25G7lZrsVkg8/im2LEDdlhHry0wju+tlOBlZUVkAIC7MCKr5puBVUNrltGx1pLaPRYhn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YymD9aGMSLzKsAApF3ozOclJIn0iDwQqSEEU756D+dcJsk2aucp
	y28ydKAmWUKbkoH2V/wwFWx25Z2fyEVlm8MLgnwUpMIHPLy5Z1Jg
X-Google-Smtp-Source: AGHT+IFjBirKxvhcUm31N0h/rOgBdi6BvuwKEA4Xjas9bGgvDDnjeBOSkIFJs9sh6qdppfWlx/pfOw==
X-Received: by 2002:a05:6a00:3e29:b0:71d:fe5b:5ebd with SMTP id d2e1a72fcca58-71e37e2c28dmr7516133b3a.5.1728717574058;
        Sat, 12 Oct 2024 00:19:34 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aaba171sm3664620b3a.161.2024.10.12.00.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 00:19:33 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-phy@lists.infradead.org (open list:GENERIC PHY FRAMEWORK),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v3 0/6] RK3399: PCie Phy using new helper function
Date: Sat, 12 Oct 2024 12:49:02 +0530
Message-ID: <20241012071919.3726-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Few clean of the phy change and Using guard notation makes the code 
more compact and error handling for mutex_lock/mutex_unlock.

Plz review te code changes, I tend to do silly mistake.

v1:
[1] https://lore.kernel.org/all/20240901183221.240361-5-linux.amoon@gmail.com/
v2: Fix some typo in the subjects.
[2] https://lore.kernel.org/all/20241006182445.3713-1-linux.amoon@gmail.com/

Thanks
-Anand

Anand Moon (6):
  phy: rockchip-pcie: Simplify error handling with dev_err_probe()
  phy: rockchip-pcie: Use devm_clk_get_enabled() helper
  phy: rockchip-pcie: Use regmap_read_poll_timeout() for PCIe reference
    clk PLL status
  phy: rockchip-pcie: Refactor mutex handling in
    rockchip_pcie_phy_power_off()
  phy: rockchip-pcie: Refactor mutex handling in
    rockchip_pcie_phy_power_on()
  phy: rockchip-pcie: Use guard notation when acquiring mutex

 drivers/phy/rockchip/phy-rockchip-pcie.c | 148 +++++++----------------
 1 file changed, 47 insertions(+), 101 deletions(-)


base-commit: 09f6b0c8904bfaa1e0601bc102e1b6aa6de8c98f
-- 
2.44.0


