Return-Path: <linux-kernel+bounces-440042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2099EB7DD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40AD418883AE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68DA241F20;
	Tue, 10 Dec 2024 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="cs7DgxPe"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE98240372
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 17:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850653; cv=none; b=jCRiBVRbfdCqS0ChnuqLK2m9JyUROUhuSxcGNZJLAnic4sH+EoA0KXaU2Ksgdw2GyUmZPrUQTNj0Ly1pLzSccFtFyMZcOwQqyTX82u5zmG7P93jz56Uy+HqPUkpOBHxb8mNt9G8CMt6rmUqVjzTFwYv+qOhvIYN1n785Dom16u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850653; c=relaxed/simple;
	bh=jlwgcsx3LUvZUCXYVhjc8Lyua4wYz+90XYYggB1WV0E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V2NfJJEwBuFNpuZm0evvvmvJgD4aLkiMGGhxEbNsJIWEtC/geiHdG3SF69NBjWMrXVdeQ2XxgXv9JQtLkujlpJihLFjdvLYHJcKdJBWiZKS2np7yjglkIf8074IaLOlYLiB/bYZeYpmoo66JUQY8CIb8uSTeIDDqHwn1x0g+Gf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=cs7DgxPe; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cf6f367f97so8534044a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733850650; x=1734455450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMj/2kdBQwniGBjdZnm5DjNL0YdrCH1deyApmD3I+y8=;
        b=cs7DgxPeXIsJnhodf4oK44aB8VicMtAoqzJfIKp+oNm1FDwMl8RTlVOk1bTCpU2kwN
         NXtrNd3IGDmMhIf6cXonlwsD1LCkpW5WKuLRhfyfqrDyUTBQ2muc4maR56R/r4+If36f
         2lHVOOFpXUmDo598BB58RYNWXT/QzJ8/3KKCmYQKhCx6T2myAQwG3VYC13nWzr3lF8PZ
         Pr4L+mMvQh+6TtdrSVzxe16w3v/IEsInGCQJJa3crQPSC8ky/4Ge6/WFq5E6T6BVxNcj
         wEt2dkGQ+N+mJlpfEpWLIasB9H3sPfLlweeyw9XQWlbWgfrJmMA2BEEGkEuOuA853D6a
         /2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733850650; x=1734455450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMj/2kdBQwniGBjdZnm5DjNL0YdrCH1deyApmD3I+y8=;
        b=RM142HmWmwNeF2zTDMIZx7mV1yty6FwFnDqQNlDdtQtfR683hi7i6hRKByBtjbu42z
         RuajQXO2Un8GAl5SE8xzy0gDMOJ4XLJsu5oI600ZxnoCTVMIkN+4mSQhNFesgCPa1K4B
         k/LzDkOR+LiqK1UpzUTg3EesNdvoaZKAtZ/NcwzVOvs8ooWPWZkebSsULEhkjOac6J8l
         xbxYlUl8pa0gSWiKkFpelCb5zJ8CxcCSIZOHLQPuVB/pMlfzUxsh5cSXC/avvmeFDdbT
         4pDzDyJEXDFrlWuaAHsshYc1qWpM6QHkq1JpgOtBdpsve8FLkrzqfyoPzvV4AGOcZ/26
         wUYg==
X-Forwarded-Encrypted: i=1; AJvYcCX0PZfztmjvUFHf/8he2vBZ/zYQ2uvWWk368ucK/4TFhDiIOqirgResR9VfHonxIqB6cMZIW51YXZoffKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPqGbQDBNGmyX+D/j0sQoeixylQFseci/CO0ThDeBtXQAB/Kvn
	owcwPEuJXRQZwjOS0Iu5s5iNzO7hfu0R89Ld76G5KRzb9057qD7GGa5M/4fM3mY=
X-Gm-Gg: ASbGncsVMOs8Uo4A0Kn1aaOMF4jpP5g3nu2cNNzh9X4Xen0amfDV0QRRwOKRTs/FIeX
	5T251ADjDcs22co0Sgp7XEqJ1SEdI0qF1kQUMJOOlQ9JNZUXn9rZfRj6Gt8ZzuuehqZ0FCwO8ok
	Jyq31Rr0AuDnKCqIXdDBjJX4HiBgJ2667olpIj3N7m8rURclODSG9Lv5vO2soOWJjsE8UgmsEPW
	MuKAvgYTGksD4rNUq2QbXi8xccWWzfFaOHqSFQCE9G+jz6MtWBCe9MOKOu4PGBVCV+y8u20wUcC
	GSJ4rUgh
X-Google-Smtp-Source: AGHT+IFXUw5ybDLD5qa89ZofGoIXkdy91MQ4lgB9QjSQ6ZzxsKHCx4/ijSbtTty6jRiH6OvTPqEZrg==
X-Received: by 2002:a05:6402:2691:b0:5d0:8f1c:8b94 with SMTP id 4fb4d7f45d1cf-5d418534c20mr6265042a12.13.1733850649565;
        Tue, 10 Dec 2024 09:10:49 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3e7936581sm4853124a12.56.2024.12.10.09.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 09:10:48 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh+dt@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	magnus.damm@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	p.zabel@pengutronix.de,
	biju.das.jz@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 19/24] ASoC: dt-bindings: renesas,rz-ssi: Document the Renesas RZ/G3S SoC
Date: Tue, 10 Dec 2024 19:09:48 +0200
Message-Id: <20241210170953.2936724-20-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241210170953.2936724-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241210170953.2936724-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The SSI IP variant present on the Renesas RZ/G3S SoC is similar to the
one found on the Renesas RZ/G2{UL, L, LC} SoCs. Add documentation for
it.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- none

Changes in v3:
- none

Changes in v2:
- collected tags

 Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
index 5b42eec864f8..e4cdbf2202b9 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
+++ b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
@@ -19,6 +19,7 @@ properties:
           - renesas,r9a07g043-ssi  # RZ/G2UL and RZ/Five
           - renesas,r9a07g044-ssi  # RZ/G2{L,LC}
           - renesas,r9a07g054-ssi  # RZ/V2L
+          - renesas,r9a08g045-ssi  # RZ/G3S
       - const: renesas,rz-ssi
 
   reg:
-- 
2.39.2


