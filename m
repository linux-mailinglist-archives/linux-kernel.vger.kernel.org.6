Return-Path: <linux-kernel+bounces-551727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E6BA56FDD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEC853B44AA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD9724EF67;
	Fri,  7 Mar 2025 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VCR7sJp6"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B24524DFFF
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370290; cv=none; b=FEXhsru/o+Ab1w/NMJsh4b1amaS01iRwezXKXqwnO+Z3xSEgfaJKj43muZrs1Wm6LShgNIMOOVp3nM/O11Hd7vvTNDYGCdEP1Swg91cKB2g5KQ40j2n4lAzrezucKpvAgYjna0wEILZ0k9hjRIbTOUQDnHBggDhr3CWLjZUlNHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370290; c=relaxed/simple;
	bh=l4iJNAHptiuVKpCa07q2upOIZMfPgiV52LMmwgdvXhc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OltxgnalRTJ7V6+B8elwFgL0vGYC3H8cgeERMGq9Eb01mFIHRHbjzrDWHiq9T+cId/XrKMgzGtJB3S/74QzLjUV7c3kFYPM08Lq85BMPD3u06xZoRZegQmNjmk2wepvVsFGeGKKCwJtuK692H4ENzWiI0rLGkWsOgQVINbvsKCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VCR7sJp6; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e549af4927so3820988a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 09:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741370287; x=1741975087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZqArbq2CLhmn9uqH6RdF2eNuvNBqtoUAKfUBvHjG6s=;
        b=VCR7sJp6guU94m5rwCuoaZkoSLC1pxB8LQnIq8IaaRm/eU7I3g7uglDhCqXLjt1Q8e
         qmLfwB8yVDgiHVskBh1v7DA3wSWr2kpsypXyE/2AySnFgbgx+55Z5/1K/RSvLyPLzJgN
         yKJWxpYiVRpK5/XP41NV05VCwnK+xIkCGz7847PBC70e5dvcjkMn9g/oCYu6Skb3HO93
         Uayl/mx+YU+lcwLAmm+4Ut2h+jYZ9+yp+fT4ylczIkHj+XT7xdXjt54hRpkgLfosnPwE
         80TA7SaQ59IrPaUZ2skxY9QrS5kvFcxUFEKFgxaOFReoVMINKlK+St3si2mS21jjLfDS
         uhtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741370287; x=1741975087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZqArbq2CLhmn9uqH6RdF2eNuvNBqtoUAKfUBvHjG6s=;
        b=CwG2YApZP2a43vgq/Jjtl1Cnumofg6/PkZ3+TrOnAyv25+pHGTsy7vh/kCvH9DsuB5
         FEpKVRZ671kFSsGU1p21ABKrSgVjJz84SNus8vnnECNI9eSdyok5aMCiaJjuXlHaiqg3
         12RooZsMiAokNti4ItTBcXz6AEKCToYfZYLWa7MzHHWRXRgnGEI7h8EyqQCCLLgCYGtc
         AHzJqECydLvjXa789XSXFpTq/PElvxpZFWUwMikFqwRgextEzFgoh8DyS0TTYjgOqSex
         kI1rUpCw95nWCMherX+d7WerSJIMTZAD9bc1+Wsym9KF/GdqDHb1FycssZMukJRJVqU6
         l75w==
X-Gm-Message-State: AOJu0Yy0Cce8DK/f4wN/hyioq3BA6l07vm/8RjkT4dulPioY6jE4uyXU
	d6sTjZJ3eHFIR/2EASVvO2Ixpd30xdfrpMOfKbQguxjjROtW+2j5QhDcPIP0pEA=
X-Gm-Gg: ASbGncvRMr2F9vMZVqz/gw0PJTYOxXZlPOd9+UzFTeIpWzdIIntwirp4TK9zSsmFJOd
	LM9vCpHmSj9l1CiXYuUjEjAv3p+4XNv9ocSuoSqBNUxykRS7V6vBIJXNGmrzVpgZkORJkomX9hS
	79t+vT9lnxbqxF/ppzfHRsvvCIuaOvZbmGXk7QtNtvGOUSPoWVdsw/avXtJ54hUsOynYLb+ZT9i
	VjIx4e1pn7FVJNexzl9zKSuFdf990jDVpMuW1kMRuh8yNqiwlIRZ105Ku+345/N6B5wzVLtPdPv
	lVpdNX6QbkJ9JV3DRhcQLFUwXGg8fCwh3lIBYRRc0kzIoVpVNeKg082gtpSXzmPe1ILhBw==
X-Google-Smtp-Source: AGHT+IFB+pgHQOp+DmatJ3pgxLGrPswQIYz3b+jPGDBDixmGyBv4yal6DPot4X9LauxdjotyfFHQNA==
X-Received: by 2002:a05:6402:35d3:b0:5e1:9725:bb3e with SMTP id 4fb4d7f45d1cf-5e5e251077cmr5998833a12.28.1741370286961;
        Fri, 07 Mar 2025 09:58:06 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c745c5afsm2803622a12.18.2025.03.07.09.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 09:58:05 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Rudraksha Gupta <guptarud@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 14/14] dt-bindings: nvmem: Add compatible for MSM8960
Date: Fri,  7 Mar 2025 17:57:24 +0000
Message-Id: <20250307175724.15068-15-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250307175724.15068-1-srinivas.kandagatla@linaro.org>
References: <20250307175724.15068-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=910; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=FXEt/Kj/cOQDVL0xn0HFa2IaPATF3j89thQhbOzYB7o=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnyzN+dWWgcoOaGztrTUxERMTUY/4sCVheFirnh 2g8KO+3G8OJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZ8szfgAKCRB6of1ZxzRV N9RNB/0ZptGJ/wFI6VVU6qNoXS8mI+H3yJHG3pkHFqwcy8JErkwbNYhR7g0B2Lj0X8sEbKtRmVJ ITGEtDrfQjfhM5IsNqDXew5ct52/O9IQt8qOd1jXOPUUBVcbhNVnLRjojbLNdTXGDo1fKUqECex KPguovVsUpmsnWZ7F8IW5rKGfa6khE9hQNa2byMQqddwGfQr4acId96BO0CtFB8/NCFUkn0XLOE 7nGe6LroWxM96+gaYHhQ5+OfTUk4f9Drli8S2NOTfKwr82lt6dG4gEDOjryGBE0z9HRDRJV17GA c9Nq9+z4ObZuAJSQzN1PCtw8OtSJ8xpv35C37SbwCdqh2Azw
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Rudraksha Gupta <guptarud@gmail.com>

Document the QFPROM on MSM8960.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 69e3669f8178..fb4dfb1bfb4f 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -30,6 +30,7 @@ properties:
           - qcom,msm8916-qfprom
           - qcom,msm8917-qfprom
           - qcom,msm8937-qfprom
+          - qcom,msm8960-qfprom
           - qcom,msm8974-qfprom
           - qcom,msm8976-qfprom
           - qcom,msm8996-qfprom
-- 
2.25.1


