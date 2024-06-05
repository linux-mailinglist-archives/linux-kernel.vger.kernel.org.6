Return-Path: <linux-kernel+bounces-203210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B95A8FD7EA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9D01C2545F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FBA1667C0;
	Wed,  5 Jun 2024 20:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmXxpZZ0"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBE715FD16;
	Wed,  5 Jun 2024 20:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717620740; cv=none; b=P2zuz/QviGamsCxZ71BywkTmajrgFNwGQScxMUhJtJoMYi1cBkCutH1+eiferACQ0J9AVjfm0aqtti7GLqGrOCGzGcgWBCjLO5OL6gJY0dANzzl/+citP+r0iq6Q8JD6UYwFdhBAY0zmkohIZvnWPXXULxR9cTiWgQNoxJfzdHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717620740; c=relaxed/simple;
	bh=qj5xcBjZErFO/5M33HBTO0XOhViDdJ/QFEMyH3GL7rU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EX+swr9D6GsA0k4+pz6bYP6px8R0gDw+dlZdaslStodUNzPxyLM4LmPQxtGsTxEmJ/0fbiD4bxiJ9/Hp2bdaMSt7KknuorTF0PeM2ed2wMy/b1Ufxa7J0yD3H6EHvd/NgbMYlGkePT4/hVDncc/cYlbggoRZQZ+J0QrNeaAJvaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmXxpZZ0; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a68b41ef3f6so23553766b.1;
        Wed, 05 Jun 2024 13:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717620737; x=1718225537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33SKSYjNACPXXw3O2oejlfq/sz5jEco/GHNmXgivYNQ=;
        b=EmXxpZZ06QrobmJl1Fy2vauMUFR2furFUwhEbZU5q0WyYqyVw4dS1OL07HuO6BRQtF
         7n66kRJiWgUOELGOad8/iF2XggH8z7k6hs1eajxCYZcGFfNGi6yS+ii8SAJzwWSm5jgQ
         KAFMmfTMKI/9yNk4wum20Z26b6ihg2oU3c2T9o0lg/sAcZSOlL1Ai0HY9ia1OmhQwccO
         ZDpBOSdxrqNjrdkC5y8W6z9nsRi0QpGgOQBjHw49ICreVpWoLXB4Eckifn7CqWn/dL9y
         RzY9IAVdb4zQy3sA7bHeqvljmebkKprwARFfGfLuyFihMKi1WEcTq48ONKC/b0gQ9YP5
         wL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717620737; x=1718225537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33SKSYjNACPXXw3O2oejlfq/sz5jEco/GHNmXgivYNQ=;
        b=EJoFIl4eo2IjHBIyrUwUmRpL7yJavOc5wKpAiU6BjPrGRbbjdg8WpWcTkR57E0l7kC
         +5F8EBoG3GIAqxldfXive8+wn0wZ7hJDP0J7IJvHosc6ehd6BeVRxMUMwzzg8YdSBOqR
         EqzxedQ41eHTvRh1Cbkr98RBewZDuAhdcI+JEmvH8lBGvp8fjKAEibKqAKhQBXekvTSr
         SeVg53MGDUJJq1y8lcFOskOEin+HU+yb9wgKNHDak4LtE4ka06GWNyfUiRBkYc1Wnf4M
         UHf7qF6td71Ayw0BfqXcSQ+S8pLzMIQk1cUEeBNoiX61OILEnY9xe6r8Sai39oX2WOY3
         p6ag==
X-Forwarded-Encrypted: i=1; AJvYcCW12bTr41Em946ZzTOMSy0ImHsk4NRgoX3UsxdXinP6GjIagvnz1Vdw3vuC1x2yxY7wZ0nho8TnZOHSLlrrlAyGa2dvpJlaZtXnxh7foNMO7nM8+Tbl757+/dtvXzamsVD6SSY9MZAk2GMfmB6UQUCacRTLlzaATOFqJbaJt3ppSL4lQw==
X-Gm-Message-State: AOJu0Yx+pBQTEjGFUl15z2sR6gjLocaTnCY8lYXnRo7MfoJ+ACzBoBzV
	Idrs+8/Ve+oFjwXY40rHF2EG8xaTUnNjlb+e430rhnOuJb0JFJ8=
X-Google-Smtp-Source: AGHT+IFIDerHktAZirR6ar95KtrL8RlysFwPrG5PvbJC1Cu9Jj6XSFP96k+U46so3QZVSMUrWG4NyA==
X-Received: by 2002:a17:906:b7da:b0:a68:cb24:a123 with SMTP id a640c23a62f3a-a699f56e66fmr241689066b.19.1717620737442;
        Wed, 05 Jun 2024 13:52:17 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:5211:58fe:dfef:c48c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c71bb5affsm72265866b.147.2024.06.05.13.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 13:52:17 -0700 (PDT)
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
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 3/5] dt-bindings: clock: rk3128: Add HCLK_SFC
Date: Wed,  5 Jun 2024 22:52:07 +0200
Message-ID: <20240605205209.232005-9-knaerzche@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240605205209.232005-1-knaerzche@gmail.com>
References: <20240605205209.232005-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a clock id for SFC's AHB clock.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes since v1:
 - add new clock id at the end

 include/dt-bindings/clock/rk3128-cru.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/rk3128-cru.h b/include/dt-bindings/clock/rk3128-cru.h
index 420984fc2285..d731c3ffbe1e 100644
--- a/include/dt-bindings/clock/rk3128-cru.h
+++ b/include/dt-bindings/clock/rk3128-cru.h
@@ -144,6 +144,7 @@
 #define HCLK_TSP		475
 #define HCLK_CRYPTO		476
 #define HCLK_PERI		478
+#define HCLK_SFC		479
 
 
 /* soft-reset indices */
-- 
2.45.2


