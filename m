Return-Path: <linux-kernel+bounces-553180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B47A5852C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 15:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620AC16BDD3
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B3F1F5844;
	Sun,  9 Mar 2025 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vx/mHd5u"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7321DE89C
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 14:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741532271; cv=none; b=hFh9EJSe/Wq8ZHsJ0JxDHkG11cKHdZG1rIA6ceGLqNvFvpVQB+PQ1c6BPZvCgLE/V7KxSzLRL9w2hhcOIXiYQl8TsyiLw8gM4F2TH3rzh34Mfb/I13OJ/eNdoftETJnPZeFuiQ3OCv2c+lGt5WGeyyz+/aj6JlTqXGIgsHU2TbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741532271; c=relaxed/simple;
	bh=l4iJNAHptiuVKpCa07q2upOIZMfPgiV52LMmwgdvXhc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l+APEHq42+c8ZTCSiLmCfziNU+wYT5Zb/p3U+o0/MKunv26LDIunBdP/DwXVQ9roScbGMPn31o0AU8prRvdK7w0dx1Q3QR/UigJUBXyg6JZ4ZQfn8ppRWoe+4NhIm2Q1+A4LYdDesmJ8v+6Xc7r1eIzqFgms60pRc/iHrOJgbQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vx/mHd5u; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso2834047f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 07:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741532268; x=1742137068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZqArbq2CLhmn9uqH6RdF2eNuvNBqtoUAKfUBvHjG6s=;
        b=vx/mHd5uKKDHcl87CDQyvl4fLMe0G7PYQSdMRH7fyWRfuMsC7ppp97E1ll3IOCa4zz
         Yjwysj4O77idOgmj4Ws6qyeZhDhlpEeudY2iOH+Kop+Go7hQeT1ko+hnKClQVyIylVMn
         4Vu7RSTtVb5SOjcb4RF+8b33Kjldb8h+gy8lFaq9epqFYQtxYk/P7g2zg3th2OeM0/Ls
         dSSx/MnuBsCFYMdokBh5BmQn2Ua6VevDB+SAK+ydMejpD+/Z3RzRTrlWFjKVC9X/waPV
         nfTk06tgQiSy1G7NWU/I38sZ7IZacmlV3ouP4twBHvsFMVWLweQGjecasqpm++uPxn1d
         ejeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741532268; x=1742137068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZqArbq2CLhmn9uqH6RdF2eNuvNBqtoUAKfUBvHjG6s=;
        b=eR/AYc65aFdxXplDdK5wiBq2ODBlZr+eJxyUpw9W4PhjEm8CnhS2fyk5on8LvUNSgw
         mcsMufjhjeaOoTKaNtnvlJ+cK5aye7vmCxgz4PT4R5Ow48zk7pxcWIkVV/LTSnbACxmo
         yB5XO5zJ7qXVhe0s2MeWCUQfDRocMJe4V84bhYRlbFwjweVHnvOYQZ03xTpQQ2lUgMn/
         mTHE78oqu8ceZlP1gRku/dc76QRa+L2QesTz4LArIsnavQhSvDt31AOSOSm0jr97sdZO
         zvLSLoCUu5C20jOY6aMlBA8aBaV5iOQRTqdcr0HETIbJKg2MDao6vggPaSsUHycO9HF4
         qupg==
X-Gm-Message-State: AOJu0YyxYi7zYuGxDkRRkKSMDQa9pana+pM482LWbDBvVy0IhBstNIhO
	PP98L+Zaq4LRTMuiSLnHkpBio+ZAZWN/rO/7RX6ivzvYR5cooO+LjAHMoAPSivE=
X-Gm-Gg: ASbGncu87bi+QrLtx4zktJwQ8rOMSYkbTOB5CzrtDploxSYoEC7SatXNwPk+5Vy6KpC
	JvzK48rQUX99GDx46QQ/CNlZsowxKE2KbN8SqTVhy2e9BTD2OkuOt28qLZP6nk9hUWiA2ljAC+V
	fJ4dPAkJplKPZB31t19lw/XV7pD56WiDcohtajbOpc9udzDk53W5KkZqIreJSjSF0c7t+A8/PDF
	TtASqe4+OuuBkCLVNpj0B9Z9ujkyzsRWHJXDNFEBTUh5k767/4IJZ62ROV4SoJEXF0U/dkgJA4O
	ea9JOoOeIitrXnh3E+kcRnJt641c4OfuW9DSFYvte+PSHdGUFMPXOptvWMM43XQw/TsDzA==
X-Google-Smtp-Source: AGHT+IHXwZqeORzAMxtEeUTzJ3kWo3J0ChYt1uv9alOhQ3jpF5kQ1aADa7sui4RG5CIz53NBYA6z7g==
X-Received: by 2002:a5d:588f:0:b0:390:f699:8c27 with SMTP id ffacd0b85a97d-39132d4d155mr5516373f8f.12.1741532267621;
        Sun, 09 Mar 2025 07:57:47 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c1031fdsm11744899f8f.89.2025.03.09.07.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 07:57:46 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Rudraksha Gupta <guptarud@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 13/13] dt-bindings: nvmem: Add compatible for MSM8960
Date: Sun,  9 Mar 2025 14:57:03 +0000
Message-Id: <20250309145703.12974-14-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250309145703.12974-1-srinivas.kandagatla@linaro.org>
References: <20250309145703.12974-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=910; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=FXEt/Kj/cOQDVL0xn0HFa2IaPATF3j89thQhbOzYB7o=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnzaw6dWWgcoOaGztrTUxERMTUY/4sCVheFirnh 2g8KO+3G8OJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZ82sOgAKCRB6of1ZxzRV N5xICACFlMDTNJ+72mcu3/nmff9FmdjieaDcBwWNPTF+xvRQwlH0f6cETa7LyzuCrg6e5jM1WDN iOP8nobXkGh0EFAch15uwz9guUaCuX8Q/6VSI9rRBAIOECAyYPt4LXHVcgoziO3JJR3eVM5Qijz QPyRGPpxUzqK1RfXkGWln62ylemG9KLNElayDhJfufyM8tupXvSg842yBVLWjfYL9Gqf7grad+M T3aIr34VjhXVSmp3XeaanLpGtQTvdkV1lSsTY6JpN4mgzjgLe98ufFmJOUtRYecFn48tw4Pn8rG HeognM5DKOn/tRUaEhEu9yKdEkegz5L2xj+bkHinb43nt4he
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


