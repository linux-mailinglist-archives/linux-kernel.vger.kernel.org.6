Return-Path: <linux-kernel+bounces-437092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB149E8EFE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A5651882349
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE592215F6B;
	Mon,  9 Dec 2024 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JvwHl3ez"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7118D215F6D
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 09:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737496; cv=none; b=WOO7k1EypWuiqtmpybT2p4atQ9QjGaDCaqZ4wg+8vvOmlv4TS/pBX0azs4F7fbGfJ4idDycUAjdLyWtiMybFQXS9/TZ1XzCuRzgMNodzmKy83LT/r1wkuV4agsyE58YB7vBkeoYnuOlvH3NwElXkWwIz8mgcctg1lUz8Q5i0tAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737496; c=relaxed/simple;
	bh=fjb9i990GoQpb8o7S4Y3ba1ibdKhHVEzq60SLMZRjGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OOGw3mW5b73opmAPurBfhycfQO485uzvmixKBn00qW8Uwn7ekpbxr84oq9nUuwG4dlZhvDyf1aB3Yo7kDkAyB6csVe++/d0hLxhsg8FHc+TwkEAKKRK3XBwtQ4ozmfh+01QHj2qex3CaDCZUhfYkFEPNHHw+LL2QDYCbmpRkHkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JvwHl3ez; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434a1582c86so3517605e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 01:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733737493; x=1734342293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l1sUV7roJsGmgZfOhLBngscTUOda+ttUP/edvvhP//E=;
        b=JvwHl3ezHSEJaYCiyOrpmTuh9tSGsuLKg+QoRQEGtLp7pSd1qQtfKuP/pyu5GV7QIs
         fHIJ7NYZRwth/XPfGa6W6/O/diVe25HcsyvupgkBS0oupeIbQuotxlNBN50xAZb6xTkM
         c6h8syR8eUxmlzF9qt4Y+qu65Bw6UGKbN2WMAxQGRlJ6293fcbg465HZtxnFOYBxlQfG
         fJSIVoVGqZ9ySCXDnrnJefDGM7pPWtsyWon+eel7Ck/2lMKQN+z2JqDs41/10w7qLnpQ
         koJ6njV+VcC9osEbTvuspWlP6fDyYvmnfpi0zGSVv1rSR88EPVSMc5rHlBMFqc3tZeCC
         gfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733737493; x=1734342293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1sUV7roJsGmgZfOhLBngscTUOda+ttUP/edvvhP//E=;
        b=Df6gn6OLLm6sgMgic4WGmvz0B+zTHnMYh2BbljG09apL++3L5VkovP2p7rpahAODNI
         JuR7NLIA5Q8iWYNuuwMYgMDllb1ghwaVfhNE92moDTrG+b3K0eAUcX+V+VwORAA9Pyaq
         cutjHKjnRkx7hUeOxn25j9XfM3kp8fekb2u+CVB3OMcLF6QMxjA9AkIkjSk8MxZhwkAh
         438fjzWSC2DPlW95xQJHBwCNGNuNwqrtvNktM6tXZD6GYmeGn5ZyvOuNyz45wyQbLsbD
         Vt48V+GbdIjcq/GkbCQu+/V8X4rzrWdbEgRaWUQcfPww0Em4KUxIUTXM9wrUwNJicd3z
         889g==
X-Forwarded-Encrypted: i=1; AJvYcCVpz1PW7QH0bJFV0790z2cR8g4eDMfH8p/Ia3CGz3BgCewXgMvQ2d2qNv8iypgNOnArDox94tzcPcDCEbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNFNdKB65q6MAH2RPiL6tbCMSgYm4W17DNDmtfD186i4FDskuy
	O22HCjKkTAyihD5a6Nxa3hLgQLt7SebvMDxRAmR7o7lTTj7Famix8LJb58KThMQ=
X-Gm-Gg: ASbGncsGIak3hRLheS//Xu1k2Xylvk0Ze8i6Vd13udDSMWfUFqgBY1yIwhfjAzpZn/y
	6D0p6h01SkSqFDWN9hPBkRyW7zWnLUs+RL664XXxh3pluzf+KeGiPPam1ccox4Gi/OPL3A7jNjH
	zEPvZFwxzxFhjMXAuGuuJ561CYcOYWsnfPU/ZewBm1M5aKiR9Wi2G+sToy198sRZGFHf2eNCdAD
	zHUEDJmB6p3ajK43BeR8mZ9I9QoQAv3J+pmHC1NzjhrSEO1NHSu29KsCj10Juyi
X-Google-Smtp-Source: AGHT+IFfnWuaEEFQ2SCpKa35Hxvbxx4TbEd7vRGr3JaRGDSa3d6Pbtwvg8lyAMELgezOfxR6fP5yTw==
X-Received: by 2002:a05:600c:1c0e:b0:42c:aeee:80a with SMTP id 5b1f17b1804b1-434dded5411mr38198335e9.7.1733737492784;
        Mon, 09 Dec 2024 01:44:52 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434e962028bsm80503345e9.38.2024.12.09.01.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 01:44:52 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH v2 1/2] ASoC: codecs: wcd9335: Add define for number of DAIs
Date: Mon,  9 Dec 2024 10:44:41 +0100
Message-ID: <20241209094442.38900-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Number of DAIs in the codec is not really a binding, because it could
grow, e.g. when we implement missing features.  Add the define to the
driver, which will replace the one in the binding header.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Dzmitry Sankouski <dsankouski@gmail.com>

Changes in v2:
1. Fix 'error: "NUM_CODEC_DAIS" redefined' error (Mark).
---
 sound/soc/codecs/wcd9335.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index a2521e16c099..7cef43bb2a88 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -159,6 +159,8 @@
 	{"AMIC MUX" #id, "ADC5", "ADC5"},		\
 	{"AMIC MUX" #id, "ADC6", "ADC6"}
 
+#define NUM_CODEC_DAIS          7
+
 enum {
 	WCD9335_RX0 = 0,
 	WCD9335_RX1,
-- 
2.43.0


