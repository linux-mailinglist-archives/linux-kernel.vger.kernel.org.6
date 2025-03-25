Return-Path: <linux-kernel+bounces-575218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E34A6F46D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 284397A3D35
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EC92561DB;
	Tue, 25 Mar 2025 11:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ffWRSv8J"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A602561B8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902867; cv=none; b=TuMFe42h/kuRowDPGkPJPFDAHc8GqxUByZmBmV9Ra38naSruahSz5vTbyNJqKtYritEBcffpJgaKPXKifwpFZWANQtN1q054mdrrrEFYPyl5gRS7VwM0nY8QHL8+pgNpp57HsNYHO3j2dZOrs+cBGxgZGUdty/SLiAAsW7w3IKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902867; c=relaxed/simple;
	bh=nzVmJfufed+ekMZEjdRDlysNfkHvhI2RIGmGqRITGrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dNIQYJhWMrL/BZrkr2FnnPiQVYf8Q03DItJ+kdPQ3shApGyOGOUjT9fNkadykSZhV6eCvYnhgvNTWdc+pyJicpx2VkUq9nmQcBcIQH/wDb5gPR9wWkz5XPdp3MVowQB1sIZkI5pa3LU6xwqKowNaN0QuWxLiZkpu9A57RN3lAkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ffWRSv8J; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4394036c0efso34322665e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 04:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742902864; x=1743507664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGhDhYESbCVLGZrKJ7EvUOhY/AIfq8zAGCvPtzsm0PA=;
        b=ffWRSv8J+GPpoy6DbNK+oKp1tY7WD4lq0zW2WzZjKmfy9AqtHmFqar8PY63iyhyqpY
         IJ3v31dtWrDJ8IGoUkGogdK1ezqGXD/4+8flP3qusj1Sdn4m4cQVmxmZHFm5Mg9VY49G
         Gw6+qTpu41rj4/dc3srTpCkgaV+SjikJw//DNigemL8yyZNXLVuo3u4/WVAgBYQmMial
         7WyPLZuIZjknB3KQTQ4M2Yh/oH1cqUaZh2lObK/ug7O5ouDCvXxoSOumxIlloOyQ5gGM
         j8AhfR2J9xgSlJkekOtSVcglrViP+rnDcwH2ZX5+YfSoO/wpz0WAJUCav2irLGm4l4zb
         SPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742902864; x=1743507664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGhDhYESbCVLGZrKJ7EvUOhY/AIfq8zAGCvPtzsm0PA=;
        b=uGtzEyObCeCqXFRSsAZx/riCodZZamO7ISWLU7yV+9hHAuA0ssW9CvPX5tYDmxCm6B
         tNiw5fDwJ/tb9NuDpY2krF8oaE/bADB5t41KAi18TX2XDygPlRZSg4rWQlbGxl1OVTaH
         8xPV6HUGuKsncW+eD4thavxqbR6oUR4rzzg/UTIHsf41JV0GVdC5qfm8L1M6wDi9VXza
         mUdTsolaZtCMxYffbcdfadjVcctl8WqUnOt5puDvtVYpgS7SMXCs8HB6+INBM/8J7bNT
         C46y2QcSubccpkc1NYzO98X9tp1Jgr7JGUTVyJP36E5x1qATH7rqt1YIod3yRmCNlHER
         MumA==
X-Forwarded-Encrypted: i=1; AJvYcCVHMdC70DRKk1QjPS+5RiWqfVNKk3OJ/fzmxslkR+Hf5E7sZiH8P8d0O5g4XzzqFxCs0pPp4my7Qh/Crwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaLtAG89io+p3AEovnwCbQPgiKcKATS33SWYcImFdMz2c3g/VO
	apdx30xrCMrT0v/ldY0VMlpkQfpjp+EegcnhmHSiU+UISyc2ug3Rb2MQJk1M3MY=
X-Gm-Gg: ASbGnctaaF9C0+M9k3+Pf5/VWYZGRYNo0bGLSvmpQxOuQshCkc/US2AEvY+KaDe/0MX
	MH94ZRpVc6iPLhHfM6V8cxsuZnac80qo4boXYH/l5GqBRh6IxWhU3S0pQq90Sz+nU8XCOhLoqZI
	UwbFtUWhE8n3OtJqvyFYxUN4+Orj4JIdTquPnckpmeX8iSSL4uiwTaI3yu0q4tkjmpV+LPIWBhk
	Mj6J0Vg8oNBONBltJZ3x9qr3zTKpA81rptMtFJ/F8gzs1L5qiUwr6yG2HdysMITg31QVAHq20ML
	mrgDNZkkG0xRJVuqVokXviH3NB6fW15oCDpbNbrssdCtdVu8uwk9gY3ZZOmrt1fVF3P2Eg==
X-Google-Smtp-Source: AGHT+IHnXTKa7PclIfoxNwdAn+abeRK1ZHaSvsObkxA3nuEMe8tz977mZM57XF3mqVcCCaA/t91RfQ==
X-Received: by 2002:a05:600c:5021:b0:43d:1c3:cb2e with SMTP id 5b1f17b1804b1-43d509f6788mr171568615e9.17.1742902864348;
        Tue, 25 Mar 2025 04:41:04 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a6326sm13213330f8f.29.2025.03.25.04.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 04:41:03 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: peda@axentia.se,
	broonie@kernel.org,
	andersson@kernel.org,
	krzk+dt@kernel.org
Cc: ivprusov@salutedevices.com,
	luca.ceresoli@bootlin.com,
	zhoubinbin@loongson.cn,
	paulha@opensource.cirrus.com,
	lgirdwood@gmail.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	konradybcio@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	dmitry.baryshkov@oss.qualcomm.com,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	johan+linaro@kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/6] dt-bindings: mux: add optional regulator binding to gpio mux
Date: Tue, 25 Mar 2025 11:40:53 +0000
Message-Id: <20250325114058.12083-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325114058.12083-1-srinivas.kandagatla@linaro.org>
References: <20250325114058.12083-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

On some platforms to minimise pop and click during switching between
CTIA and OMTP headset an additional HiFi Mux Switch is used. Most common
case is that this switch is switched on by default, but on some
platforms this needs a regulator enable. One such platform is Lenovo
T14s.

This patch adds required bindings in gpio-mux to add such optional regulator.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/mux/gpio-mux.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mux/gpio-mux.yaml b/Documentation/devicetree/bindings/mux/gpio-mux.yaml
index b597c1f2c577..ef7e33ec85d4 100644
--- a/Documentation/devicetree/bindings/mux/gpio-mux.yaml
+++ b/Documentation/devicetree/bindings/mux/gpio-mux.yaml
@@ -25,6 +25,10 @@ properties:
     description:
       List of gpios used to control the multiplexer, least significant bit first.
 
+  mux-supply:
+    description:
+      Regulator to power on the multiplexer.
+
   '#mux-control-cells':
     enum: [ 0, 1 ]
 
-- 
2.39.5


