Return-Path: <linux-kernel+bounces-392000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8FE9B8E71
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 806171F25330
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DC61A01C6;
	Fri,  1 Nov 2024 09:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="DfXQFLSs"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47ED19CD1B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730455079; cv=none; b=IFOQ/8mhXczCSgkMYfdOS861zR6aE6xHoqfwWw25CWXQQZHpZh3eKm+f5fBYRlT7E2z7z7MZT/hcngu3KN+CCj6xU922/eaKm/MHZKdGRrU3OiSCN+ALH6XCWFFyWWPw2WeYTseBU+a4z8IAzQ3Ju2jVxRZsi+moy9zQFc+AVJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730455079; c=relaxed/simple;
	bh=Pf9k322Noul/AUoZF1lcvPKEcxZYOYxw5S5eT2YDnXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M/UrndwWq38c+9rHtKFhBUGaiWFx9T4i4VHwa/5mlfYKGz+kxVmB55eUz5DfMsHR/06NLINbQ+ke2081/XMTyMhYwNQzppAZhWFUfzmu8BkEVD/izjX10DP+SFFKHHdtaYYf0XoNVQ9UcEP1ePu1mGo8aqrHmnlvZMGcVeSICPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=DfXQFLSs; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c9709c9b0cso2666260a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 02:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1730455076; x=1731059876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CsdPZF9emf18XQgtgS7Xp71XPblYsQ7NBPKTENRn3uQ=;
        b=DfXQFLSsrbMNA5VOknfWfhySdFrCjvu0tDgwrTEWF1sUtGqbT8H2o/gCGINS0nfl7j
         nouq6LwZH23a9x2wml4xQCO7kR5XuND8zx1qG4+OwTqPart8LGYYvU///slPG0xfhNRz
         3iGfjI65SIjGdrP6opiRuR27K2hWE3QtrLCR6ZdSmbeKwAVCGhYio8n4rqw9VdZCHmJc
         SbCp6ML4isJAZ4q0w80/ROUfyOvxpRSM+mZwYUVUxnWEf2Za4rbFiVXnZO/X2SiJmFRV
         lKCrJsV+lA9gi1SEv1bh8fr+HWB1HJOU5aSTYsUeATkfWePam0hr28Fg989jaizKmSfM
         WDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730455076; x=1731059876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CsdPZF9emf18XQgtgS7Xp71XPblYsQ7NBPKTENRn3uQ=;
        b=CLGBe6z4aq0o9/e4W51Q8zCO1msozJWSQxt6MeaceoDkdpxHdHrn/jcawHeqHJfsEw
         DtbmTuJMJr4PgSWMgRKsbsOjak5l8W75JOYy0qyNdvaFllVXRaxMYLaSU9g27oCMctvH
         SfhFUGhn+ts5os91/NjhsAvHE4kkt+WCl4PJK146a8T09AraaELHVIMXojrowjhGuGnn
         7X6YHyGpI4MQDdKGMhEQuGsCm2PgSAi6d9Vae7PtGWybAtEkiRlahzqvIxb8Y4RLClsH
         BuFCNQeaj+ibhA3anvwPqu/W1yS3vPtmLTLStqE7GCGXd8iarYWYmHRSw8j4UZp3D754
         KfDA==
X-Forwarded-Encrypted: i=1; AJvYcCWrWOsNUCP+2WJ7VtBnOT3MXXBzz3Z/fMThmlUbj4Ulky24g2NRARnAyYiBgyYmAXcuB/vpVORJz8M/L0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxb2FkNpHevLd2kM3yaxk3dnh0cCX5CNroHbaPsdEtMO+HDY4W
	vqzCypCMOLwbHKeBUM0dZUXtLaOWymi64kr9Cng0d2zB/fuTyEuJxAOYTXJKuIM=
X-Google-Smtp-Source: AGHT+IHIInFyvvZ21N4w9XKZUzECowUn+aG9F5+oWwykmTnOmG6gYMfAOXIH3hB+PUh/16T6BdSrwQ==
X-Received: by 2002:a05:6402:518a:b0:5c9:76ca:705b with SMTP id 4fb4d7f45d1cf-5cd54afde73mr7392400a12.34.1730455075953;
        Fri, 01 Nov 2024 02:57:55 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.190])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac7c8d87sm1364136a12.76.2024.11.01.02.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 02:57:54 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alexandre.belloni@bootlin.com,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v6 8/9] arm64: dts: renesas: rzg3s-smarc-som: Enable RTC
Date: Fri,  1 Nov 2024 11:57:19 +0200
Message-Id: <20241101095720.2247815-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241101095720.2247815-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241101095720.2247815-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Enable RTC.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v6:
- none

Changes in v5:
- none

Changes in v4:
- collected tags

Changes in v3:
- none

Changes in v2:
- none

 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 30bb4f5a7dfd..2ed01d391554 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -345,6 +345,10 @@ mux {
 	};
 };
 
+&rtc {
+	status = "okay";
+};
+
 &vbattb {
 	assigned-clocks = <&vbattb VBATTB_MUX>;
 	assigned-clock-parents = <&vbattb VBATTB_XC>;
-- 
2.39.2


