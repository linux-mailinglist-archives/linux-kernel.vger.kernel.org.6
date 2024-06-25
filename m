Return-Path: <linux-kernel+bounces-229344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2754916EA0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66FE1C22EF8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62ECF176AA5;
	Tue, 25 Jun 2024 16:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hZXrZg/p"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E652F176231
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334665; cv=none; b=uN7gNMAT+2S/NLZUyuAdAk+N5Gox/t4hft3ZubhlmniVzFMS0x1KTi5YnjvcjvQWE06sWQHOQaoXpJhmxv6Efaaa75PJRZN/p3p9RR97zB8r3xUuN48KtjFg4CA+DjXr8codI7GSfmAUz4/lNbfQ3eJFHmRZq/vED8imzFeoqSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334665; c=relaxed/simple;
	bh=IgGwHrHuFpbFHTEvgUPbclMeTRgHKAPJp73FYsZVpTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/4gda3JnNt8YihXQYwFJfr2XubKj2dGFOG4JJcUI3mwFVv953nCcDIzrHMo9Yy1qxsYgOKkJFyNRzoWQuHaTVvVVPdsTXfYe8fNwe5jZXEF5ECG0W6j8XafxIJRiLJQ+Ecq75hTVeeWhAECv+7X1AQxIok1AIWcFAnB/bwEfY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hZXrZg/p; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3650f2e540dso3876590f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719334662; x=1719939462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRIDFf691thT58ox/N/VuEZHKFWQnoUZUCRyx39jn5s=;
        b=hZXrZg/pdIKKxoEUltbP7CANhXKQRlx4s1Kj5LgrIHRQLyhtvnP8iO+3viyePNWUP7
         wPPf5CrFqEyONBLpBjPGyLFn1C3JpeFKEfCzykPXqd5WC7Tn62Lj/GgGcncjGtv8uOQd
         migK/HetNmmRWUA0Ch3diSs7fdqoFxE3qCdtkf2DFr18adJaFLB5WjfigomIYremaF7r
         yjeMVK/XSm5P0STK0YGpSYCNV1l4LXDd6bgoZwRViyDtmFHFz9iPaB3VHCYvvrMY1NhE
         0NDGugDEAZVHaFTLr0hf63jgVPnx+LWijrACa+i/olK+6vsmwAdRkrvfKsxgD0aPb3GO
         buog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719334662; x=1719939462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LRIDFf691thT58ox/N/VuEZHKFWQnoUZUCRyx39jn5s=;
        b=BuCHlZkedmz1CH9LOs++Aqdza90fYDZFbSB//MAscObpFVtQbXesOt3OFtrrTI3XRQ
         UWgFhuK4HQAR2IXjUIvc940u6LxCziIv0o/9RgyfKUsLGBQ8Vgmnbq56M+BZXimVcfwR
         LjB4MeJJK/NjSSYaGd3BPD499RP/VPDV7lAKAv1fbF/jJ50AP4WeVPBqADKBjYq6hk1B
         zDAgRuseDmDI8pvxuVKukzYiSbl3PyG/+M5ROqG+feGomao50hSGPyfBZzzcqZLz207T
         IFLv9Lt7uGY+/8m58ygbC7sR5QYymWA4joKZFbGjKLlKzZ3cD4kMiStFrvJsj/53Bxoo
         FEJw==
X-Forwarded-Encrypted: i=1; AJvYcCV3x+NupCItb8zz5BY9lLU5X6T74XvAFwxhXctN8g9NuGg3nO7eIxO2nczJgodeIh2WfD8zj5Dm1nlGEVOClgKYZlZMjDWV9gOhFcBh
X-Gm-Message-State: AOJu0YzBDfSGD+V/YBBZJYqso7hzHCOu0F92gZGoGxTx2grZ2axqvu8M
	C6VOenn1IsxYRwepG3BOvIq66jsMjqQItFzSSZdD46A21D9K/FeXrM75Q4iSLx4=
X-Google-Smtp-Source: AGHT+IE/O1fv/lIki0Fwzrt9YYS/r8AY/7+8D+IqPaAgKoFLSWyy9JqVUr3ddgb2fUcIuTZSME2ZbA==
X-Received: by 2002:a5d:46c2:0:b0:360:9cf4:58ce with SMTP id ffacd0b85a97d-366e96b22damr4696741f8f.46.1719334662267;
        Tue, 25 Jun 2024 09:57:42 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8cb6d2sm13360519f8f.111.2024.06.25.09.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 09:57:41 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-arm-msm@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ASoC: codecs: lpass-macro: Use enum for handling codec version
Date: Tue, 25 Jun 2024 18:57:36 +0200
Message-ID: <20240625165736.722106-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240625165736.722106-1-krzysztof.kozlowski@linaro.org>
References: <20240625165736.722106-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace 'int' with proper 'enum lpass_codec_version' in every place
which handles the parsed codec version (not raw register values!) to be
explicit about contents of the variable.  This makes code easier to read
and compilers could check missing switch cases.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/lpass-macro-common.c | 8 ++++----
 sound/soc/codecs/lpass-macro-common.h | 4 ++--
 sound/soc/codecs/lpass-rx-macro.c     | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/lpass-macro-common.c b/sound/soc/codecs/lpass-macro-common.c
index 8b038a99a8f9..6e3b8d0897dd 100644
--- a/sound/soc/codecs/lpass-macro-common.c
+++ b/sound/soc/codecs/lpass-macro-common.c
@@ -12,7 +12,7 @@
 #include "lpass-macro-common.h"
 
 static DEFINE_MUTEX(lpass_codec_mutex);
-static int lpass_codec_version;
+static enum lpass_codec_version lpass_codec_version;
 
 struct lpass_macro *lpass_macro_pds_init(struct device *dev)
 {
@@ -69,7 +69,7 @@ void lpass_macro_pds_exit(struct lpass_macro *pds)
 }
 EXPORT_SYMBOL_GPL(lpass_macro_pds_exit);
 
-void lpass_macro_set_codec_version(int version)
+void lpass_macro_set_codec_version(enum lpass_codec_version version)
 {
 	mutex_lock(&lpass_codec_mutex);
 	lpass_codec_version = version;
@@ -77,9 +77,9 @@ void lpass_macro_set_codec_version(int version)
 }
 EXPORT_SYMBOL_GPL(lpass_macro_set_codec_version);
 
-int lpass_macro_get_codec_version(void)
+enum lpass_codec_version lpass_macro_get_codec_version(void)
 {
-	int ver;
+	enum lpass_codec_version ver;
 
 	mutex_lock(&lpass_codec_mutex);
 	ver = lpass_codec_version;
diff --git a/sound/soc/codecs/lpass-macro-common.h b/sound/soc/codecs/lpass-macro-common.h
index 94697d0ba8c9..3aa9737f2737 100644
--- a/sound/soc/codecs/lpass-macro-common.h
+++ b/sound/soc/codecs/lpass-macro-common.h
@@ -38,8 +38,8 @@ struct lpass_macro {
 
 struct lpass_macro *lpass_macro_pds_init(struct device *dev);
 void lpass_macro_pds_exit(struct lpass_macro *pds);
-void lpass_macro_set_codec_version(int version);
-int lpass_macro_get_codec_version(void);
+void lpass_macro_set_codec_version(enum lpass_codec_version version);
+enum lpass_codec_version lpass_macro_get_codec_version(void);
 
 static inline const char *lpass_macro_get_codec_version_string(int version)
 {
diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index 1c3429f004ed..320e3261c151 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -642,7 +642,7 @@ struct rx_macro {
 	int rx_mclk_users;
 	int clsh_users;
 	int rx_mclk_cnt;
-	int codec_version;
+	enum lpass_codec_version codec_version;
 	int rxn_reg_stride;
 	bool is_ear_mode_on;
 	bool hph_pwr_mode;
-- 
2.43.0


