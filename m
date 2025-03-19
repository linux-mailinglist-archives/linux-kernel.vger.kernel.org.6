Return-Path: <linux-kernel+bounces-567560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054C9A687C3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E25A882B24
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF19252903;
	Wed, 19 Mar 2025 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v0GRtoYq"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B2C253350
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742375876; cv=none; b=KqIF+IvUEh6QknXh9OL1Gic0yC4mDUFvoGD7/D/abGc46SjYmxrNEjVCWSDgk9jej4OUbqSDbCaRFSoDu8Jo8d8OlPvZT8qSqdQiPMHQpWKb12yfQrd9uSIGwpZocvIVJtEirx7YJTdMjqneaQ3wfzkttvn3mCuVK1EQ73OxM2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742375876; c=relaxed/simple;
	bh=ULRWIRzW3ClVMbPCwKcuXk3yCqOKBA/uzUXVWNbco5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iKLqlshMdsnZhg8ISYFVoipe4Rfm80Nm9uyKWNb2gtulrqMDZ2CDjBwLTNNjI7WeotWpYtRKgAzoL2SGJp7DaY5Z49mDnkpxs9pYiT2UA49t4yoTco0lhhyC2w82k0fUMlwvBhE4odOQs16pr6jdQScdR6WVONl11ANVUqeETHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v0GRtoYq; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3997205e43eso750302f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 02:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742375872; x=1742980672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ySdR3tj80pBDLvsU4QQMajiIPqzNIK+BJx1XMf8UJs=;
        b=v0GRtoYqQoO0WTUTIXqtbK/IeO4I9Wco8GvnRvjcB4nxyblIwdeAbaguhXo/Z+Lcv+
         p4dnXhZM8Ai5AZtPmOEzVMDSCEaK5uVvQMhtr+bWd5AqFgyf3PbhrxB73ufXBk1qiLKL
         roeEsLl7hlgtKM7ltpWdophjkSshDavruRqDif7dGE4ITQAKNBmSM7MkGvKOnwOY+amj
         qqmNgNIK6b0Ub82dz+8GghTxHeItl+xfLmpAwRVVTD66dkBjnJTvq+DaWAkWwX9XRdDg
         4DjeueOtZmW3RmAt/HjOBU+kYNmJPUnTLr9x2cYzErnXBwRDDIGiow2XIHsUPhbpjWGp
         lRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742375872; x=1742980672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ySdR3tj80pBDLvsU4QQMajiIPqzNIK+BJx1XMf8UJs=;
        b=dbSxP3pv/ePecUGo+oi3K6TlWS0ykO1GAmt0i8DAWPRgFMlasvaG5PV9e0E0dbSHIB
         2XupZYHHG6bPm5PiNSZIOu/XklaNlIvX/XYBxQCWzc3E/tRe2VQAQWoid/471Fxta+a8
         cmoQDAHQU2IiAy2adWHxa3Z5FhTcAPV/O6aBoSVSqiA9GFuqF279muVC52NruE07lcQY
         d+cMDCXXYSS4ObtNf5vrB2xTRXHbx0C20MA8zxIrPnv9YfIl+xYvF7iFagdfhOVn0yuQ
         0qhb6VjY+QHzjKdcFNEWpDh/pXTrzWLXUigspUTHyBeQ8FDP4S6WfNfQkSoo5rD3GIl2
         tbJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUb/+En2TZkN+yBds09/dQmI4tJvYrC5B6S5Rh8NrtCvEKK+kf6Gg8zw6h0a40Acb77yTpikTvVLb4kCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXLOQ8X408x2pUsEVAPrE1g+NSrNKtssTDnmEHbjxkBrFwj/U6
	lF8gWjwwucBxyJfe6G+68T2Q5g7aYhqUeqmaISueFBnrunSE1ieLp9hShePUkcc=
X-Gm-Gg: ASbGncs1pmfzP4tp75l5kEBHO4penr/LXIncfhAgeamHq2+foEj4fS356kmxluFzhV4
	Urlg7vpU4aAkK8/o4y5UW6Q4360EIj75dxdnJOAwEH7yP7euuAPakHFRN4iNSBL3sMhaC7pVekl
	0vCKURcvnGjvpIIR3m8ZUfE3Qg0aFS2wg7Xvx6ygLwxkDHD4JGQIA3BAAS4pAbv5McZH4+830kf
	FyWfMh/hgz0jg0Q9Rfxms6mvxL9tsbJMkbmAkZPK48UTq4B8SMlRRjo9uA2tUkVdgFYppDlhpcq
	5Z7VF2r9Dr4Np1i05NSiv4FxCSTkdIxiBf9aO9IqOFi/yEhUNv+4/H40Eqq91berFbVhMCxPzWY
	rA0fb
X-Google-Smtp-Source: AGHT+IFGBgrP9XrQ3f2uafyicjPKMzKkkhYZU6En9bbVWfY5B2AqCcmoR4UU0JrQIUMOQW0ppC9i4g==
X-Received: by 2002:a5d:5f91:0:b0:390:ee34:228b with SMTP id ffacd0b85a97d-399739cbbd6mr1493601f8f.24.1742375872457;
        Wed, 19 Mar 2025 02:17:52 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c82c255bsm20023810f8f.23.2025.03.19.02.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 02:17:51 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: broonie@kernel.org,
	andersson@kernel.org
Cc: lgirdwood@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	konradybcio@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	dmitry.baryshkov@linaro.org,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	johan+linaro@kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/3] ASoC: codecs: wcd938x: add support power on hp audio switch
Date: Wed, 19 Mar 2025 09:16:36 +0000
Message-Id: <20250319091637.4505-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250319091637.4505-1-srinivas.kandagatla@linaro.org>
References: <20250319091637.4505-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

On some platforms to minimise pop and click during switching between
CTIA and OMTP headset an additional HiFi Switch is used. Most common
case is that this switch is switched on by default, but on some
platforms this needs a regulator enable. Enable this regulator if
platform is setup with regulator.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd938x.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index f2a4f3262bdb..a00845089e13 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -3267,6 +3267,13 @@ static int wcd938x_populate_dt_data(struct wcd938x_priv *wcd938x, struct device
 		return dev_err_probe(dev, PTR_ERR(wcd938x->us_euro_gpio),
 				     "us-euro swap Control GPIO not found\n");
 
+	ret = devm_regulator_get_enable_optional(dev, "vdd-hp-switch");
+	if (ret && ret != -ENODEV) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "Couldn't retrieve/enable audio switch supply\n");
+		return ret;
+	}
+
 	cfg->swap_gnd_mic = wcd938x_swap_gnd_mic;
 
 	wcd938x->supplies[0].supply = "vdd-rxtx";
-- 
2.39.5


