Return-Path: <linux-kernel+bounces-573682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DA1A6DAA9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ECB0188FEC4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2731125F780;
	Mon, 24 Mar 2025 13:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o4//6K7p"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFEF25E466
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742821267; cv=none; b=V9oRoFMWgapVsPwVvr1uF/S6OoNhaZGRfFsVCzathmGbTQivpBlonEgJislxwyjIm/XKRJCfF/knwIM09mfLODvD+X6HuSkp5FqT03BQMheT3hHmEL3RTXTQ6uq4wSo0/eHx6gSGZbIu/9fQvcxSsURFj7n29CX5ZeOV60Hwdq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742821267; c=relaxed/simple;
	bh=hfdMYkI1wSY3YPTVRxCMq5RnZCB7Q8NWRrwf11y3dFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YH81tsEs0I4sq28TE3SnfpvDPBej1VuEORK7v2TboC+pE7JY3y/SDuNO8GuR0E7UGIqxRaPkc3GMh/f7/+1MJTMQcnLWWV5jmIsegsufkbdDk3dWMnp8Jf3QiM9RD29R0pMSR7vIywCCPWggQsId4Co1KoaK7oDjA05Eoy6+0r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o4//6K7p; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so34832675e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 06:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742821264; x=1743426064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dx8vnuvBu7CvSAoy4lTQTdohK7w44dk4P3RzF1FDAZw=;
        b=o4//6K7pf7K6MI9VsRIUvoKHD2Zwh7PXdTDM7VgOJmrC8sApVEyh7ljoUpk6wyEeqh
         Su0sr1ZCDk8zMaOJjHejMPPLmAQDQT/YLOMq0t1DDtbuQH0OC+1sKJ20KEKgPEqS7i0b
         bE336d2CKA73r+au571v7e623LApknAA5BXwK7q54sdalH/7tjOfWmhbhQ8igd31bzuT
         h8Ox48KbNF8gm4n95wo88HW5FI/hjKShvVdDM3ECjaB5btXJ97WSbwOEmRWa9rqf0qu2
         ThyLa/M4mCcShfrF6674PfyLZxGUHkvzfArzPLxOWUd+w4XbP8/aQ0rZCsDs2UbKzbo2
         HehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742821264; x=1743426064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dx8vnuvBu7CvSAoy4lTQTdohK7w44dk4P3RzF1FDAZw=;
        b=qR8C6mYTfWm4jGngwengNR3CWlHpqdGctSr2f9+Y7mBb/eQH4KhaY48YpR3mKw50x5
         zY3K24jlh2zZnsIEHcyLgYvOAZgXJJSajNHhwh86XCU0Qymn0Xxi1uJGz4dtJmyy6kIy
         TUwEfOCvqL8O9j+wOOpfjbrU5oxYW36pUk3E6wN4/z8sSsFtnIQPPLdts7Z3G0qr50R+
         LDIEA0M/1jhCbD655SuZPl0VSjjuZ06nfcQfYTf+rE7EZaLurBDSsh77xlrKC2ACSpBe
         X/ieiGvZdA3PAeWEuOtKDK72N6uurjC16elF5DGuh6Zr5nTCkJDO9JUJZLu3HQalBwjP
         3iew==
X-Forwarded-Encrypted: i=1; AJvYcCX712Bx1YOWsWp4jkvfjbG+/3IkcM9xCbl0Bdm8OKsDOCoRFF2we7F69928jfUMKj3+LaRyySikylWv66w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjCOetIv+ek/Cvh9/Iy8kymss7pa3Ev/qBEqJaZcAyOoPO7kPY
	Ohgnj18VHz561VLW2f1Cas6FeW1aqhVBjZpupt2OgJIecw9Aw4cEy+8V6W+bL8c=
X-Gm-Gg: ASbGncsyBYI5f2fjynbxc+niOqSfxRJ3AXL3gtJJc22P3us5/SmwbJpnaQHUUMS2FlI
	0VGjuUG5sfn+8x8pMi0g4h7sKPhFHybeJ0HhSZPpeSkm/G9bCawEtLrHVBAu5iar/ugo7IM0rzo
	7pCv5zL9zEsHLZjMtzku0WcIM2+eb0DLi9CgMMczSnybFmqOgDbLhULAXAISb2agmw7vNhiPZbk
	aXRwR4UzkjC9PIt1x6er1TifW2DiSy8v0fLgfApCUOluBv20EZ3b/OB7EL9YzJVXJY7DrreQ2cn
	KHQGqAb7ekdel4oyoekaG7cRKSIN3nYtPUveMDbVvHZ4J7HqwCEaFp0w1EoKox4xURxrrA==
X-Google-Smtp-Source: AGHT+IGs1hed7eFfngKtDdIfLF7CUa5raY/UTLvoWGsHn1iu0AT2ObRpnyWdq4Tep0xWDphEI1SbUQ==
X-Received: by 2002:a05:600c:1548:b0:43c:fb5b:84d8 with SMTP id 5b1f17b1804b1-43d509f2ebemr127044545e9.16.1742821263769;
        Mon, 24 Mar 2025 06:01:03 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fdbd1c7sm122275975e9.40.2025.03.24.06.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 06:01:03 -0700 (PDT)
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
Subject: [PATCH v4 1/6] dt-bindings: mux: add optional regulator binding to gpio mux
Date: Mon, 24 Mar 2025 13:00:52 +0000
Message-Id: <20250324130057.4855-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250324130057.4855-1-srinivas.kandagatla@linaro.org>
References: <20250324130057.4855-1-srinivas.kandagatla@linaro.org>
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


