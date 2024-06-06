Return-Path: <linux-kernel+bounces-204489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6D48FF037
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A950B2D963
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA9819D095;
	Thu,  6 Jun 2024 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vx/hBLnB"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691D3198E90;
	Thu,  6 Jun 2024 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684650; cv=none; b=a18Td5XGaSm/oVlTXdImEEo+12Voi9M3pxKAzCQls2asj27hBe0JvdfmdssspI61ghPFTtsFYI5SgA8VQdL7T40MU0b5IZj5dGL+kICuXeDr2AnGPnrbZjh1Mxk2iYD2win+fMoNnIwdLQcpeA8Tg1+tRJldlt6wN2T8wBN+/UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684650; c=relaxed/simple;
	bh=HU/XmPOYc3rLTxGSCPg7+DoNE91QKlWhJKUcEcpTqRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQi+HKQsdMuwV7n7ROmr9Vc6GGkzm3MvjRrPgsMJ5bxpv1FFXHUYJ9rdq6rtUuCqqbqpmm15WHkOrAbcmJK7XMB67L9gl6CyiGWgox2gx0nFLHMdTQeLrmfyH3pLD5aIT1SwD+00POsCKiCXi/yA2BwXXICR2d7aEl44CdaED/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vx/hBLnB; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57864327f6eso518119a12.1;
        Thu, 06 Jun 2024 07:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717684648; x=1718289448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9rzNDKvRTHIQEHFX1fo6SI12nhA/uBVeoZf8XBGrf4=;
        b=Vx/hBLnBvGycHu2vLip1HyXs4FMgFDelZR0x5VynnGjX5CXAxoIcl2XwKtLsuWib0/
         pIfOL/YXkfnTxm9OrX/hQ3e7SwB9U9jDXoB7/sZeo5hqGp4EluN2pB+TT8socn8P5V80
         iTBKna+RFTvm75cXKRmf9U+gd0CJwY2pjzu+iMlWeYA7kVtoCmXKlRAnEeDg/51D2Vby
         tfZU5ZgWpEehb9iMZymsrIhjEkR14NgDAFjCjxoKvBN+eg/+8LR9IJV7atG3AezbXybF
         UQLrcs23A7pEgp4zaiHqkjYB4uXk0Gp9h1jaHAoXawETYw/rMd0GXxLm6DQazGBVN122
         5bQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717684648; x=1718289448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9rzNDKvRTHIQEHFX1fo6SI12nhA/uBVeoZf8XBGrf4=;
        b=phlGC7HpdpaFO8rILICBsRiNXgp9m4MyMsxIu85SbcBsxLqltOBazQjfaIC5FnV7lp
         2y9MrJyZwcl/6OEc51XWjzePB8RlIC1kgU12FOP2mTFtRHxyZY5ajSYDfQLf+A/hKWlX
         NZk2ILXno2zFw/TV3uOmBVkhZIZWKiRel5QbMO46npWoRi6lf5JwuZfzOGIlCcr0GjgM
         /HSLZNcRf4kdPUOX57WLDaWLmFZk4zjaw9TpQiEwnmA6MeDZE90H2KBD/viB4fBG8T4X
         JqCfDP2rYV98MAO66qhEodl5HhiBbTzVELoFtZ/bCPLtLlkcI7o4lzjo4XnHMe4ULy8m
         8sng==
X-Forwarded-Encrypted: i=1; AJvYcCWF0ewD/0Vn9SyX0IE+DUZV3bvQzoFf5e+TwiAXAE7PRtRTJYNrDHgAiWtPNxIjfPtg88pJEuLiiSjtvgi8R8fPU0LtFBBdLMzMWsBKyc6bc/4dT5M5Zj7Qt18SRy+FhazD0nO4yNWNk1zcVJzujUifV+hJ9pPFiIkbtAdJ6BgxHY/oFg==
X-Gm-Message-State: AOJu0YzPOZ1NOQMbDtY2TgX4UZ/Yef+AnqWsMgEaK37TdFJuoMAF6AkT
	Cl2LEo4dShD/fLsBCRcBIByPtLqpVDQB6BBupPkRzjc7GpgjK4M=
X-Google-Smtp-Source: AGHT+IEZD1zCh1WfCvxH/MGx6QPAzngQWbhVxcZUWrSClLiSnL+TIe5o63jAqNH0QIyeu9gKgFaxhw==
X-Received: by 2002:a50:a6ca:0:b0:575:2a03:8ff6 with SMTP id 4fb4d7f45d1cf-57aa55ae244mr2678406a12.16.1717684647657;
        Thu, 06 Jun 2024 07:37:27 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:ed9f:91b7:21f2:3109])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae1008adsm1190925a12.38.2024.06.06.07.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 07:37:27 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/5] dt-bindings: clock: rk3128: Drop CLK_NR_CLKS
Date: Thu,  6 Jun 2024 16:33:59 +0200
Message-ID: <20240606143401.32454-4-knaerzche@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606143401.32454-2-knaerzche@gmail.com>
References: <20240606143401.32454-2-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CLK_NR_CLKS should not be part of the binding. Let's drop it, since
the kernel code no longer uses it either.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
changes since v1:
 - new patch

 include/dt-bindings/clock/rk3128-cru.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/dt-bindings/clock/rk3128-cru.h b/include/dt-bindings/clock/rk3128-cru.h
index 1be455ba4985..2616a8791c14 100644
--- a/include/dt-bindings/clock/rk3128-cru.h
+++ b/include/dt-bindings/clock/rk3128-cru.h
@@ -145,8 +145,6 @@
 #define HCLK_CRYPTO		476
 #define HCLK_PERI		478
 
-#define CLK_NR_CLKS		(HCLK_PERI + 1)
-
 /* soft-reset indices */
 #define SRST_CORE0_PO		0
 #define SRST_CORE1_PO		1
-- 
2.45.2


