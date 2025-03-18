Return-Path: <linux-kernel+bounces-566332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC440A6767A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDC3B7ABB21
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E5B20D50C;
	Tue, 18 Mar 2025 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1xUJjRl"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE08B20CCC3
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308434; cv=none; b=KV6epMGZxkMPPE24eVMiwOBVmNNQJwjbXy+q6bABxMLTakxaw5MfMo21Z/1YjpRS4pPWxsRd9eL9OqYlXqg119MQuprU0CXbmq7ELHIvTKKYayWPx/5o7oUnxr1enS3EdDFIj+oI+ChPQAuHOglU3guA8lrbKsDlDxy3avw8NgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308434; c=relaxed/simple;
	bh=LvjlKGlvZYelZeMzFGDjmvY5qPde4SPEk6Zna+puJm8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=edy8rZZE43Khb0nVIWgEjKEyNLxAtuAwVay7dZCPErluei8NLSXp0vWxDtov3JmYcvxA6u7t0YYfx1kPe0fISykIo4FQL+mTBspae0o0Sy5X1iKYKM3uvgTySQ0Zx1ChntQYhxXbkq7BXjBtRmJ+3iMTQNc7I8oQUaGVBroFCNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1xUJjRl; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22438c356c8so99361745ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742308432; x=1742913232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gADg9VNDLpQbKOL7DJWNEdDj/Dd07ziMut44yk6PmRU=;
        b=d1xUJjRlVTF3Y41QNav9tu5JnZKYv119WMiX4X+kVDb+Ed8pdyKdHFX8fnrZCJMK2X
         n1z/QruQ0MGUy2zcjQBYHlUq2DqIx5JRDjNJ/thfnSmgJDvA2S0qNw/ExJUeeb7vuOVV
         iipC7LPKPw/8j0k56Ia5tbny5v6neAb1PnTAxnJq7Q+/aSBANhKiSVsEtcAWvpGvCHI2
         amvAeaA50tPEwUwqc9/meUo+opaPguVspTaarAA72eEE4krPZl54fXFQr83pB3SJ4QCQ
         t9ix7+AzyuzVEAfyH5dhyOfcRSpaxgdVsinr4Yc4BCn82E6CEF9WhtwyE1/G+V4e88s0
         ZbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742308432; x=1742913232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gADg9VNDLpQbKOL7DJWNEdDj/Dd07ziMut44yk6PmRU=;
        b=eHUuJ2mR5cWmKUhKuKyB8mzkJFGorXuVPpgGu6GjgDen7FdkMPtZskIRMt6xKRi6iP
         pVkqSkN7pmi73b3dcLxo8LxXk4u7ptZ2tjQjD7t+PnGqc448xUG4wJjkts3L9qhX+Arg
         MJLvtPFa/r+OfSv4zf8Ipif7MINfRWazu4ol/Zw2JYh7BT92GMN1e4THsLkQ3wgnFj2/
         ki8TSkkHiCa5EhIToPZnn5UKs2kcD1ud9n3fSMNdaFSosaQEG8barczffKhlxS0C8YFD
         w5kVJ8PVmKwto1/UxRsaJ3Q/VlZSdkFU66GhFNlEqcRvkJPx/XINt0HfHQ+mvJSXWrn0
         HNTw==
X-Forwarded-Encrypted: i=1; AJvYcCWZxFi3mhkY/ySBv6fi1U+c2ZwyamPSqdgsQO7hspjUz63C+t1qzOH9VqeuhE3y8Hr1/+f3lhzWuUyhcUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJdN7nRfddYpq97Uu0Ix0K7WNmc/VmUyvK5WUmftiyCbmGD3b3
	xYjNkvJMUMTj6bWk0CPcYTRMUu7wJF7LcBfKO9dti8C/vsGEmpCC
X-Gm-Gg: ASbGncv8NWzctTvl3rSFuT+/bEfba+Gfpf/Vc6znnwymLvHmhbNoExAeBvRj8955IoF
	dxaj4YQIo7MALg/eyUh5lwHPfmO2qTvOKar2jtgB/Vk9HIv+TJLQE2H7eMGLQOv38lUlRY2SqW7
	bouWZttUQktmcIfOX1KmE1bnk+jqk2UNWfEVdMVO/xPNrkj5oeP0/0vGdBC9vfAIr7LmRv75Zah
	Na4zKB6DahkTXTjCHcAr5jz4bg2KuAUwXj03ugkAKS2r4CnWPCDcGiZsrtBYYvrjI9jBXgEzAes
	YYUMQUZvwqlCWkOolhnP8gGz3asBh5yP9Z5uDGrYjWAfMrYHSuivdU97rYuU3b/FzGHPObfHs2i
	z0k0=
X-Google-Smtp-Source: AGHT+IEfgmfK1crsVRUWCYlfsqwt+/1m0mmrpIocbRk2MJOVO/tv4/clXEIchP4T/Mf/Fhw6MElziQ==
X-Received: by 2002:a17:902:da8c:b0:21f:507b:9ad7 with SMTP id d9443c01a7336-225e0a8fac1mr177828705ad.25.1742308431908;
        Tue, 18 Mar 2025 07:33:51 -0700 (PDT)
Received: from localhost.localdomain ([183.242.254.176])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-225c6bbca06sm94446355ad.161.2025.03.18.07.33.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Mar 2025 07:33:51 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com
Subject: [PATCH] phy: rockchip-usb: Fix refcount leak in rockchip_init_usb_uart
Date: Tue, 18 Mar 2025 22:33:40 +0800
Message-Id: <20250318143340.25162-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a reference counter leak in rockchip_init_usb_uart() where
of_node_put(np) was missing after of_find_matching_node_and_match().

Fixes: 605df8af33a7 ("phy: rockchip-usb: add handler for usb-uart functionality")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/phy/rockchip/phy-rockchip-usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-usb.c b/drivers/phy/rockchip/phy-rockchip-usb.c
index 666a896c8f0a..de7d879bb460 100644
--- a/drivers/phy/rockchip/phy-rockchip-usb.c
+++ b/drivers/phy/rockchip/phy-rockchip-usb.c
@@ -539,6 +539,7 @@ static int __init rockchip_init_usb_uart(void)
 	if (!data->init_usb_uart) {
 		pr_err("%s: usb-uart not available on %s\n",
 		       __func__, match->compatible);
+		of_node_put(np);
 		return -ENOTSUPP;
 	}
 
@@ -547,6 +548,7 @@ static int __init rockchip_init_usb_uart(void)
 		grf = syscon_node_to_regmap(np->parent);
 	if (IS_ERR(grf))
 		grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
+	of_node_put(np);
 	if (IS_ERR(grf)) {
 		pr_err("%s: Missing rockchip,grf property, %lu\n",
 		       __func__, PTR_ERR(grf));
-- 
2.39.5 (Apple Git-154)


