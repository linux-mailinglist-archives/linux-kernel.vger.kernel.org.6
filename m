Return-Path: <linux-kernel+bounces-573539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC97FA6D8D8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5712A16B45F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 11:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B01E25DD00;
	Mon, 24 Mar 2025 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fYvT1/Ls"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBE21487D1
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742814382; cv=none; b=KxVWcAlghvcQ8crf275tz884BSXtM7SJIF/qecNNAMlNEBy5gjSyAM0RpJJVSG6f0DXzMhzF/Xe92QusZZdkklOi8y5xgy0bD7XD9NNNFCqWOXAiKz5pZn0hnNAEpHz+mbG3uXxa72tSRoWZbX5oZyBx1jGLjv7p8pEil5w4AZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742814382; c=relaxed/simple;
	bh=Fajt6GQE8QH5YN/HGXfsUTV/hu9B35JpoBIyhgJYBZI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hC7HtHu1ppMVxAquoYqU1wrzZ1NA9jneZcw5BOPMnVX6zCNxLXVqTQIax8mGaZ022wScjqmmTcnT70IFbmv1i3RphV07BeXKbCs9qU08dQ7Sz3CRb0IUjRg7aYI8XOSbe3DIABogYP5XtRibQvT4XUDrMnQ2rmfSxigGWTi6n+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fYvT1/Ls; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so44986915e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 04:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742814378; x=1743419178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3WP0bnIzPp/bKVB6iCB93JUW+VRZsKoHPmvfeJJHBNw=;
        b=fYvT1/LsLbI6OxTYIU6p7yL4L3OgGeAHqF011CqWDGii24eCK4/QBfrpT5W4bdOsmv
         RODIMrgPASe4Tj2/7d7HPA4BO0jUhWMS/Izvf9Hlq9OawvC2NIbrs8JgvKdsq4xYZ4xR
         gVx/3TAXsmNbTJbWVzLz9OHQVicrxa/u7HGgtrOec0i+Up+q+weYUfrHsvuPudrcZxQU
         Afr9S8H/S0xDr9hzrBvXrKyf8U2g1uW65pjPcewGf52DYMk3s52zQaja5q+nvqYJJXNv
         igWcCs5yu9yTexvAvf7LPJk7OzLZyeTdagnP+frY09aEsifH3KqOJt75nHiuwk79491a
         4cbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742814378; x=1743419178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3WP0bnIzPp/bKVB6iCB93JUW+VRZsKoHPmvfeJJHBNw=;
        b=uxnzdjJ7qUz2zNcdjv2kiBATwFw33rX+H0gdQWLfYKHkQu57EnFo1ON9SCg6V8OvXv
         4J3F3n+8ywsqS0d8VyA5bsFy9Ajsp6cKEnFerep8lFGqgrYQScuq369R+lSk5iKsxeVQ
         b673zWkZVevRu1sbe3rL95LMSbq5Z3TJMURES4kUOV4XQoL3jKsYKqejhUT3dqO7j117
         /sKj3LWNL/2Ywc8vfxpACPcQr3vDScWr1ggCn8fabgwudLGXBgu3dz2vnrMU+7fE3oho
         8Zp/C+DTcIHXrN89ZVrusvouml3vKZwi85IZFh2wJms8XFZRSJS0Ke7DC2UldmC1n1J2
         3Y3A==
X-Forwarded-Encrypted: i=1; AJvYcCVuftLD774a6xnE0bJK6BVcn+rcBYVuTLQPuSwfsuM0jjtPfPTIqXmogj+ZTeLPZ2NEgNohBO8QvWtcprc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOVHUplIRU+U0uB9/0MXexIhdtnpbs36a793vK/bCx0BsOl6oP
	2bSfki9Qhj8LRRFBJEKranDKgYcB8s1sb6/vdqgjFpfFYBQWIPcdK2BJ7yUhU/g=
X-Gm-Gg: ASbGncsvmi9Y9PCRTMp8YPrglFZFbfg9sdl3Z7eFm0SphT8sMSOgarsUJvTuNcp4Io3
	Hb7X24EZsBTvrTqIlcLhU3ZYDHv1D5nKitgcIzOZnMwsgLgy+BrbYL4l+QP3vyDZBCjlKfooIjs
	10u0ryQUulHTKcuotQNmr/KViwTCnaAVub1XGSTNdVHN2ivhNll5jICHEnyKkXqt4ow5n9fZcuE
	qsSidcv4GoQf1eL4u3jOzLVQ4y8lSI1eRp0ZgM2e8nkfLnZjgCpJOt61Ag4u0znS2q1OhnkH2Fx
	yfth8rkz/vKIdZqefF7Y+l3hhEMm8BLs52mrHrwkiO32u7g86zjLeCdXdfkTxpGMVAm8SQGv4/Z
	r9kNJ
X-Google-Smtp-Source: AGHT+IGW+HXesDe2Nb6k7C43YiVAVslLNYvXirFy+tXP9WmjZ+UJP/9gumiDNsak+/cyJra/6fapvg==
X-Received: by 2002:a05:6000:1566:b0:391:3291:e416 with SMTP id ffacd0b85a97d-3997f903a53mr11643747f8f.19.1742814377893;
        Mon, 24 Mar 2025 04:06:17 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd28a46sm117236055e9.24.2025.03.24.04.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 04:06:17 -0700 (PDT)
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
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 0/6] ASoC: wcd938x: enable t14s audio headset
Date: Mon, 24 Mar 2025 11:06:00 +0000
Message-Id: <20250324110606.32001-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

On Lenovo ThinkPad T14s, the headset is connected via a HiFi Switch to
support CTIA and OMTP headsets. This switch is used to minimise pop and
click during headset type switching.

This patchset adds required bindings and changes to codec and dts to   
tnable the regulator required to power this switch along with wiring up
gpio that control the headset switching.

Without this patchset, there will be lots of noise on headset and mic
will not we functional.
   
Changes since v2:
	- udpated bindings as suggested by Rob and Krzysztof
	- cleaned up swap_gnd_mic callback
	- updated mux gpio to use dev_err_probe.
	- added Tested-by and reviewed-by tags 

Changes since v1:
	- moved to using mux-controls.
	- fixed typo in regulator naming.

Srinivas Kandagatla (6):
  dt-bindings: mux: add optional regulator binding to gpio mux
  mux: gpio: add optional regulator support
  ASoC: codecs: wcd-mbhc: cleanup swap_gnd_mic api
  ASoC: dt-bindings: wcd93xx: add bindings for audio mux controlling hp
  ASoC: codecs: wcd938x: add mux control support for hp audio mux
  arm64: dts: qcom: x1e78100-t14s: Enable audio headset support

 .../devicetree/bindings/mux/gpio-mux.yaml     |  4 ++
 .../bindings/sound/qcom,wcd938x.yaml          |  6 +++
 .../qcom/x1e78100-lenovo-thinkpad-t14s.dtsi   | 25 ++++++++++++
 drivers/mux/gpio.c                            |  5 +++
 sound/soc/codecs/Kconfig                      |  1 +
 sound/soc/codecs/wcd-mbhc-v2.c                |  2 +-
 sound/soc/codecs/wcd-mbhc-v2.h                |  2 +-
 sound/soc/codecs/wcd937x.c                    |  2 +-
 sound/soc/codecs/wcd938x.c                    | 40 ++++++++++++++-----
 sound/soc/codecs/wcd939x.c                    |  2 +-
 10 files changed, 76 insertions(+), 13 deletions(-)

-- 
2.39.5


