Return-Path: <linux-kernel+bounces-268537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F409425EB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B89232860FD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 05:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD6D5339E;
	Wed, 31 Jul 2024 05:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ajXx2497"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BF24965C
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 05:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722404685; cv=none; b=Lycjb+6jUmqZtGXzlm+oxa28EUWYjPiBOxZ1S8zEVTIFjYnN7OUAz07Ou6O8YITtx8nXk/Q0TMM3BkmKTjZONZPy9TaViuziEZ5+MB34u8DdieCQv14mqoQTD2eZX7od50lSukNxDGbYb5z/uw87HHEeWDS++1kt0izYDXGLSnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722404685; c=relaxed/simple;
	bh=qmEk+HRbgjzJ4b6wsqa+XId/OohdPcTkLCsEGD8Cqgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tSFCM+2cV8CC32uesCDrmXynLh931/nnR2iuJVV1Oh6hQNoN6V/8GYfwm5Nra4smYKW2p3aYL7eD49ya8MZki20QCJiPsvK3C2ifb0aH34Xrp3BHDPO2R7kc5jctx2nynKymroR6N6w5Kl5rbopmoxNYBYt8MZ82GrCIvEql1hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ajXx2497; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-428085a3ad1so34381465e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 22:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722404681; x=1723009481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3aH3De4WIZtFbyS12dyd1qXZqBk4SKLj9OlpT9UkbuQ=;
        b=ajXx2497yx2stXCYakkQlKU9PoLGFA5+k24LZaVdOWtRaXNS00z62GlxEB4uK/jVST
         I6SRHfi9sXFzExVEb1lkByjdJBn1d7FAF4vefZnPNl7a69ZvP6QCQXWhlhuzMZ7+hwgm
         fFlPNxIifpyTDNgrHOUJpoXUMQesWwl+Hgfvp9WteVZchUas8PC3W8xtnGgWRF0CiX/8
         pQWoJJOBRmt4m6ZivDa/taxgZ5/1+PTSq0GWwz/aafHk1YdJAPMfdqdYw+UDoNmhzAPZ
         gAzM1AuKvhpE2gc2xplYyc3MnE3bJx5vbdAd+zZ/Kde6BHAK9GutElHqW2ZHYpB040bu
         hrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722404681; x=1723009481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3aH3De4WIZtFbyS12dyd1qXZqBk4SKLj9OlpT9UkbuQ=;
        b=VM/AMEkNKIStC+by0B6o3e/xWoApCfuiHhioyYgm1eNokOfYeK6HMI7CZosqkAiSR8
         Ygg/5X0S6Xu1SAo/bI94BRNFI6VYvg/f6ou5NMBZqmnHx2WEAEXgIi9GLi1kn5YekJ9I
         wAl/DNC1Y3Hfv85EpuwFvsRG7m2VcNV4qWhWSsE7xR8+yBZI1WZNMFqJgQQYFxEUDVdh
         Qw9txKG3tAdhKs8ePpz7LzcOT9Iht2uILlDDzSYAAnJMMIRufTip+4+dTlLNj1h5DA9V
         7pkb8VWn5LWtOF4zr/hp4Mo+nDTCjjN4HqndTprCBqjCP+HUJLhDhP8wvAr1chbJrdl4
         IPIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUexytQTVf3Y+usM0zCSlQfS8WTkYRmdlBQDdvNcIZd6kbZfC1jCDBtZM7KvWpERN7/WyMMCNaKWhI90pcC0AUp+3v93RNHXhHWPu4y
X-Gm-Message-State: AOJu0YwJhbSgM45KsHMt7BrmBwaQrJHl8Uosv1PRL4feMvWiXSmNEcvD
	R9bI5GU386bZTRK9cEVmr+1YqblKsBWDuB/KmL+GgZjm6nLah9DFj0lulH7r7jY=
X-Google-Smtp-Source: AGHT+IHx4zf9FG/L6T+0AuVPC0EZ26TemOB8izSYWzYFEl61KTs2n+sG4y/8QWnmw2anvLsYD9uQnw==
X-Received: by 2002:a05:600c:1386:b0:426:5416:67e0 with SMTP id 5b1f17b1804b1-42811df0e55mr88395835e9.31.1722404680896;
        Tue, 30 Jul 2024 22:44:40 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282baa9071sm7070605e9.13.2024.07.30.22.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 22:44:40 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-msm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] usb: misc: eud: switch to fallback compatible for device matching
Date: Wed, 31 Jul 2024 07:44:38 +0200
Message-ID: <20240731054438.9073-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bindings require two compatibles to be used: qcom,sc7280-eud
followed by fallback qcom,eud.  The convention is to use fallback
compatible in OF device ID tables, unless some device-specific quirks
are needed.

This will also simplify matching any new devices - they will use
existing OF device ID entry, instead of adding a new one.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/misc/qcom_eud.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/misc/qcom_eud.c b/drivers/usb/misc/qcom_eud.c
index 26e9b8749d8a..19906301a4eb 100644
--- a/drivers/usb/misc/qcom_eud.c
+++ b/drivers/usb/misc/qcom_eud.c
@@ -232,7 +232,7 @@ static void eud_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id eud_dt_match[] = {
-	{ .compatible = "qcom,sc7280-eud" },
+	{ .compatible = "qcom,eud" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, eud_dt_match);
-- 
2.43.0


