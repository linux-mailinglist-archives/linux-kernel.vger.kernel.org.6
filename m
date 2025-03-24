Return-Path: <linux-kernel+bounces-573543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8E2A6D8DF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2DA816BBED
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 11:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FED325E465;
	Mon, 24 Mar 2025 11:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pk6txyZc"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0451425E466
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742814387; cv=none; b=qFEYB9FP47F531cvCRA0viToIoZD6DVElD5oMa8KpCWmE+4VAwtECGGd/iB6NbRe0L0phSK9oAXZL7cElT+N6WzWsq13vBMLgzWXOCqF6UWQ4X3z+avTNLijdv8PhR2MV35udRTwzcTUiP2ZchDbGJaG12AX3E/m9hgSbpWgFlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742814387; c=relaxed/simple;
	bh=kf+isSZ+GQZroxJu0G1Ja5oS+lqo6LQdxVZrCG2obkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PQGhdJvTkjjs1TBMCvNpBUiYWw3kMTc3NaV9qGKMgE62ptmyWyx56zv+2NdPMHLkck2ua6Y57iA/VU7op9FrKg5BG4m98HEWegAnNd0tC8hie1wUfZTTF7yfe0UvcurnpRa1U4bOZOpMbfGZ7v2LdLzSYqsvNku5QjEsKGueoOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pk6txyZc; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43d0c18e84eso18819355e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 04:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742814384; x=1743419184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVoHGISMF8yznIukeGwdQkZ9ZYF3qlKA/mjLYUuaQaE=;
        b=Pk6txyZcch/aJES3YfKqzfG8MdYkZAwVWmG1rGfXfPyieuAGn/Qn767mC7xdM0iQRV
         sSr0ffZhScA7J3v35wPLBMLd2UDVMiYHbbrY/D9EqshMdkBw3AMxJTt+KUkWGFpSQIAQ
         NX1/TzR5vUtOcLbdCAwv1U8tkAG/GzMaMLLk/gi9FHWelpQ9lHo4An3ljAn+bliSQIUq
         ljm5Gpt3A8qkOhlNE+7B22Dph7X2jhE36HzRkfu5M5biMAAayEoRyDVqeJjT+m117s/N
         1k9i9Oql6RgAQK+ruOyhLn8S7b5/R6mXPeq3XpgIcrpMuNDtA6CkedP7zco1mOid9Beo
         YfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742814384; x=1743419184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVoHGISMF8yznIukeGwdQkZ9ZYF3qlKA/mjLYUuaQaE=;
        b=VBuEwznpxCytRojdNJLiB8z4XcLLp69aZWcqVDI+Dccik55lKO0AwztSW2a6TDJSII
         HpyT/cvhtZz+6NHtjACvy3hlwcjICU9PknKFHDjed7nOABac1Ug/CkHEfRThotEFF8jt
         uUOXfLYTIzh6oVcbg7K5Oa7N01xgHHrmdYV4KzwOTw/XREKuhynZCSFhInIj55tQvq9v
         VrdNVBl924oHfHI8736iDQHOqS3Bjr2+Njeh8qokZvfdKdJR/Bi5imGtebkXOpQHpt2p
         fgqsJ1uK8dhZ78m8UmiTKltZwRbfMJSqgvEAmo1VjZYpoiBm5Xo12dmFM9sY+x3RoDKm
         r0FA==
X-Forwarded-Encrypted: i=1; AJvYcCUBlcRo1LZyUa1yfoT30p466JcaS+Ti60t1VRn5pngjy704grzVpbH+boHkrh1hKGb8igaQ9scJcw+wRUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0A7OOLrvDzpU26VvXxGhKgv6bm1B8NsFIWhIHFZuRgaihS9r1
	EE913MgB4DjtjUSanV/b8Dl/5QY0uj49gNW3lkC43pV6CyI+rjC/URJLmWoWlHM=
X-Gm-Gg: ASbGnctvc3Cjy7ShYnnCuS0ROQgMk5lPSv4TzqpCLxrKJ7/kyrlAULJIBYOanhVlA1Y
	HJHgw7UGRf2yJrWPvR0Osshg4Nrj2jolOwZH5TatrlKoy9mHR8TmMj+MmK/5Xa+n2SBSMceB+Lu
	jFRiYAL4MuuqEZ2efCJfhAoNUqZ5V4VME3/w4ys7ghnjr9AegEpE6eh7XdqQlER7GQimmGgov0e
	MBD62Cve20z4M9SnplGah9ran4mgW/ihkUeV9a8xVss7JBXbfR9oUendP7jspPBWF9lA1vOlJdF
	OGE750f9Gd0qPhlH8yqWZuqd7S+04pSSNbo6oi8aeRxVn5rsXhTtlg+ATo/ml4k6WIWPMQ==
X-Google-Smtp-Source: AGHT+IH5XvwKpEbYBwlRsHeQR/bbmwfsvDbjrTdTHYv5Tzne+9/8Zd3GE27Ynz9a8q2GSpnxGcW/xQ==
X-Received: by 2002:a05:600c:3b9c:b0:439:86fb:7340 with SMTP id 5b1f17b1804b1-43d50a4ca6bmr105056735e9.30.1742814384123;
        Mon, 24 Mar 2025 04:06:24 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd28a46sm117236055e9.24.2025.03.24.04.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 04:06:23 -0700 (PDT)
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
	Christopher Obbard <christopher.obbard@linaro.org>
Subject: [PATCH v3 4/6] ASoC: dt-bindings: wcd93xx: add bindings for audio mux controlling hp
Date: Mon, 24 Mar 2025 11:06:04 +0000
Message-Id: <20250324110606.32001-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250324110606.32001-1-srinivas.kandagatla@linaro.org>
References: <20250324110606.32001-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

On some platforms to minimise pop and click during switching between
CTIA and OMTP headset an additional HiFi mux is used. Most common
case is that this switch is switched on by default, but on some
platforms this needs a regulator enable.

Move to using mux-controls so that both the gpio and regulators can be
driven correctly, rather than adding regulator handing in the codec.

This patch adds required bindings to add such mux controls.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Christopher Obbard <christopher.obbard@linaro.org>
---
 Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
index 10531350c336..ab1c6285dbf8 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
@@ -23,9 +23,15 @@ properties:
       - qcom,wcd9380-codec
       - qcom,wcd9385-codec
 
+  mux-controls:
+    description: A reference to the audio mux switch for
+      switching CTIA/OMTP Headset types
+    maxItems: 1
+
   us-euro-gpios:
     description: GPIO spec for swapping gnd and mic segments
     maxItems: 1
+    deprecated: true
 
 required:
   - compatible
-- 
2.39.5


