Return-Path: <linux-kernel+bounces-300521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D0795E4B5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 20:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F131C20AAF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 18:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A63516C69F;
	Sun, 25 Aug 2024 18:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ln3bzkiZ"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1998374076
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 18:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724610683; cv=none; b=QMe5ebnxuzaGRAMYJ6Q3yef5xMRYMuUvwxDkffIJz4mziXzUf3a+7nbQPOK1mvmYpgb0vUsr3gANBKw79xiiDQxgc8cDTgf5AVgtB2KetTRy3NPVGjIw/Cm8bOhfzMkLFGbAOanyeM8bXmjU+ygmaAC51A4R2zvi4CUvUacmgn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724610683; c=relaxed/simple;
	bh=0mfH3d3fWKDRTMp6AgLA8pqVSbXOcj6PsmBXH3W5tUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i66jPkfPRiynSWEBdQN5OcvneP6gQCYXcnxPaTRGIv3StZ87fr0fbzpyq0//xo3P9Kl7rcde+bbszlUOrprOjP2mVeMdFdHyH12s+PEh1WYkO/pzDWI+mqWMP/mghc2Tpb8JBOGWt8qkrcgnK2pOhhnP5////u9/dQ8Aw30DZoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ln3bzkiZ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42802ddfaa6so4111605e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 11:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724610680; x=1725215480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r5oZsSpqBtpVnxWWek+saFNNQcQXhk4VKnzKr/UGi3k=;
        b=ln3bzkiZWrP48+LIQRaA+K+nYtZfAZUoXjE4Q/NVXCstI4CVW1RP3W27vFKUhSblJm
         QlAukDNhO7ZIc1VNtxn+LGwqs44g265E2oBtizAhv13LOE74WTSWeyGS7tggHdG76DUA
         IetR3X0yTxiVFyobQbtDYJ8l0U0qMDjlNonwvx8QPc29T5FBvaIqLzlSqOAi55Xra+SE
         eaVpicsny/ZQNZQpHP7RtjEoIIkMSNCnrBKbAdDKhHOvGNTdTIZwYdaZBqpgFb27dZa2
         D0XuzxYNmzxPuDeEteObpmmpJKRsWIl0UtphksCiXsxaZK8FqBpuNmJliTNPv/XgQja1
         GU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724610680; x=1725215480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r5oZsSpqBtpVnxWWek+saFNNQcQXhk4VKnzKr/UGi3k=;
        b=t6EDla1yryNRHwF191GsrT6eh6ODxkYhWpjJC0oXQsU6F3HJIr0z37vtMpJpaK/OZ7
         C+G0UJnEgsGf4X9ewzS1OiyWvqXRTYpNAjb4stDgzNL8hgFHlt+18aG4dqHT1NFanhfI
         /G1vyufUk5XthSD1zRE6cqiHSFkKy9W8FOpjciCKjgIpFwJIL2c3a/rndvG2ED9/uS7Q
         NwURDzwjQfggJMh6aPpX6YV2qKC4XykGQ6GWmncXlAGQXieje49Rsdz7MoAWhbcyGb/H
         XJCAl7PQAATsk49FNRn24laqGJGYulGGhUTdO+gn4vcDLsgxJt5lpg1jHSPMdbY/bh9L
         AT3g==
X-Forwarded-Encrypted: i=1; AJvYcCWS8gCbmPCHgEXG6hsRlfy75lEIKY6n1HJ8PQRrKeXVDQaXxhpNkf327LNyoysZX08C6gV6lZ4brdGiP/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA8xFjK6c0vQiX0TiF9SzC+gJkheDqO8mI3GLnvvkF5Y6GDbvb
	SYiniz0I/ElKg98ScHPHvkFMWTrkl2nYN/thvKrYtTntI94ihIJytKOiwZ1G/1c=
X-Google-Smtp-Source: AGHT+IExUeevkTIQSWB4GNDROugF9P/4Ht1vXHY2Hj6A+8kgBoxqFRUstIlxcvyBnYWjZpE2OjAmHg==
X-Received: by 2002:a5d:5f8b:0:b0:36d:1d66:554f with SMTP id ffacd0b85a97d-3731185d6camr3061819f8f.3.1724610680074;
        Sun, 25 Aug 2024 11:31:20 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730821ab05sm8937319f8f.98.2024.08.25.11.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 11:31:19 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] pmdomain: rockchip: Simplify dropping OF node reference
Date: Sun, 25 Aug 2024 20:31:16 +0200
Message-ID: <20240825183116.102953-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop OF node reference immediately after using it in
syscon_node_to_regmap(), which is both simpler and typical/expected
code pattern.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pmdomain/rockchip/pm-domains.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 64b4d7120d83..5ee7efbd2ef8 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -716,12 +716,11 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 				goto err_unprepare_clocks;
 			}
 			pd->qos_regmap[j] = syscon_node_to_regmap(qos_node);
+			of_node_put(qos_node);
 			if (IS_ERR(pd->qos_regmap[j])) {
 				error = -ENODEV;
-				of_node_put(qos_node);
 				goto err_unprepare_clocks;
 			}
-			of_node_put(qos_node);
 		}
 	}
 
-- 
2.43.0


