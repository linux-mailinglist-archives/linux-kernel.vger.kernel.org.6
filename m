Return-Path: <linux-kernel+bounces-204490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62ACB8FEFBD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E663128DF78
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7CD1A01CA;
	Thu,  6 Jun 2024 14:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbPQMTgS"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5246B198E99;
	Thu,  6 Jun 2024 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684651; cv=none; b=BbSrsvlNqiKeivf2+8zXyCQ2itPudA60IWTDrpKw5E8GRoQBURT/K7IcEH0PgfDq/Xj2IISFMqd00s03su+enxyhWooGtAsaAMk/nov7XiaIJ206y7uTDQN1pc1nnwPZtZzVnjVUF+zH/VDCMEBxrzbiXs4RnGtTU3/SVk9k+10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684651; c=relaxed/simple;
	bh=3zAIAfG0l1zDNiZJuAm2SkE62RSxhja2hDZKa6smMl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EopD6tVf7VIxGgY40FVFn7Wd8I32i+acadA29oa8ZLxzYBMvwUwKjXixF6OuZ76tLGiZxfc+JTq0iXr5gyxzebbEm9+GMTLxsSGaijhkpcI5W+CTgAamoigIe4w3P6VrpnailjeCznYGg3Sawd5CFUZZlEgYK0bjFsuULAbuG/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbPQMTgS; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-572c65cea55so458727a12.0;
        Thu, 06 Jun 2024 07:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717684649; x=1718289449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REl0Xx4fomFhEoX2hAlcG1iEdQqTsDARw0lBKW2BPss=;
        b=KbPQMTgSKmbo80mENCs6SZv7xXJQ7pixwwFLkuPjFAXWPf35l5XMLFwNkrexaBMZps
         ZvjVItM8MjLHxtSofppmxoKlNF/BI1bdQYE2HpFPfm/eyuZrHVeoJ/k5sIMgQ8WMUBmJ
         JhAmcujM9bLmtF/a/XTFIENN4jEHmjeb4AHFFBAjX8BE7oyB60VFyw21nLM1gr9ygK8Z
         a1GwJmc6T1zF6FE4FF7n0fiQCgTGzZnmTVpqXWkEQTqLtTK1qjTKRMGy7ieNXrPY1IdG
         zrOUPnNlPFiNcOEkpuu418pCOyy5/BKHEqW8HcAPcWe+O38aSU5mYa4Oh/qqIqoBfpNz
         PM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717684649; x=1718289449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=REl0Xx4fomFhEoX2hAlcG1iEdQqTsDARw0lBKW2BPss=;
        b=Z5athABVBcL4MXK1IwpD04AChapKzHpfS9r/1XaFdPhhzaBTC07x6qAiz+dEiMzl4K
         vX1xtLNI7FADklNwpliXWNwqzfXZbzuR7IkU7627AnJ3zMYCQyo1Vs9zta8NVLdboSBE
         lqGt9y8XjESenBazLhzD8lPSK8qI23RHgBsyQWig2+llfetEvAsJ3JykyKQk4xCOs4Bq
         kZ5EfNGbMnjTHdrSADcMySvuAEESN1fEJsIfwzYxsrEHHKo9jl9Gxkz85uosyFonHGaN
         jOPbaFEjHZJP67FVqRErUg84B30qnei8TkQvQ5yT19nbiMHyjDEKvLWI48eagth+Sq4m
         jmmg==
X-Forwarded-Encrypted: i=1; AJvYcCXjitvI7p0Xs4SQKHeIBLuCaUjxjFXoa1d231mdKEOBs8woTNVe2ULvWdwovo8pPA2TMuPz4BXpBsEa/uZMhYXqYawH1V/x/gq9WM2jZTUMx4yCUNUhkq53KQ1sKOp46xmzc0kV3Y/Z7qQmq9Zu7NagXkpnsGVKy/XaJJHg2X7z87eNxg==
X-Gm-Message-State: AOJu0YxzZJnZkTm4JlA38MptVbC/pERCpHeMyLalbYOaUKwyfGCILzai
	9/OiyDyHmT2NMQdjhG99TCY3sNidtSshx71AprcBtrvK3fvscnE=
X-Google-Smtp-Source: AGHT+IGtqB4Yqpf33WXk7lsyzw0x62MTsqjUTwKDFtbYVmSJtlwiER+p6JD5MO3ffaIRJsgfC7IDMg==
X-Received: by 2002:a05:6402:446:b0:57c:46f7:a49c with SMTP id 4fb4d7f45d1cf-57c46f7ac1cmr819478a12.7.1717684648412;
        Thu, 06 Jun 2024 07:37:28 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:ed9f:91b7:21f2:3109])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae1008adsm1190925a12.38.2024.06.06.07.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 07:37:28 -0700 (PDT)
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
Subject: [PATCH v3 3/5] dt-bindings: clock: rk3128: Add HCLK_SFC
Date: Thu,  6 Jun 2024 16:34:00 +0200
Message-ID: <20240606143401.32454-5-knaerzche@gmail.com>
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

Add a clock id for SFC's AHB clock.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
changes since v1:
 - add new clock id at the end

 include/dt-bindings/clock/rk3128-cru.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/rk3128-cru.h b/include/dt-bindings/clock/rk3128-cru.h
index 2616a8791c14..b609fcf96508 100644
--- a/include/dt-bindings/clock/rk3128-cru.h
+++ b/include/dt-bindings/clock/rk3128-cru.h
@@ -144,6 +144,7 @@
 #define HCLK_TSP		475
 #define HCLK_CRYPTO		476
 #define HCLK_PERI		478
+#define HCLK_SFC		479
 
 /* soft-reset indices */
 #define SRST_CORE0_PO		0
-- 
2.45.2


